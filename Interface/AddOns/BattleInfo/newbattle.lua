local _, ADDONSELF = ...
local L = ADDONSELF.L
local RegEvent = ADDONSELF.regevent
local BattleZoneHelper = ADDONSELF.BattleZoneHelper
local RegisterKeyChangedCallback = ADDONSELF.RegisterKeyChangedCallback 

local elapseCache = {}

local function GetElapseFromCache(nameOrId, instanceID)
    if BattleZoneHelper.MAPNAME_BGID_MAP[nameOrId] then
        nameOrId = BattleZoneHelper.MAPNAME_BGID_MAP[nameOrId]
    end

    local key = nameOrId .. "-" .. instanceID

    local data = elapseCache[key]

    if data then

        if GetServerTime() - data.time > 90 then -- data ttl 90sec (bg will close in 2 min)
            elapseCache[key] = nil
            return nil
        end

        return GetServerTime() - data.time + data.elapse
    end

    return nil
end

local function UpdateInstanceButtonText()
    local mapName, _, _, _, battleGroundID = GetBattlegroundInfo()

    if not mapName then
        return
    end

	for i = 1, BATTLEFIELD_ZONES_DISPLAYED, 1 do
        local button = getglobal("BattlefieldZone"..i)

        local tx = button.title;

        (function()
            if not tx then
                return
            end

            local _, _, instanceID = string.find(tx, mapName .. " (%d+)")

            if not instanceID then
                return
            end

            local elp = GetElapseFromCache(battleGroundID, instanceID)

            if elp then

                -- local start = data.time - data.elapse
                -- print(GetServerTime() - data.time)
                -- print(data.elapse)
                button:SetText(tx .. GREEN_FONT_COLOR:WrapTextInColorCode(" (" .. SecondsToTime(elp) .. ")"))
                -- print()
            end

        end)()


    end
end

RegEvent("CHAT_MSG_ADDON", function(prefix, text, channel, sender)
    if prefix ~= "BATTLEINFO" then
        return
    end

    sender = strsplit("-", sender)

    if sender == UnitName("player") then
        return
    end

    -- print(sender)
    -- print(text)
    local cmd, arg1, arg2, arg3 = strsplit(" ", text)

    if cmd == "ELAPSE_WANTED" then
        local battleGroundID, instanceID = BattleZoneHelper:GetCurrentBG()

        if battleGroundID and instanceID then
            local key = battleGroundID .. "-" .. instanceID
            local elapse = -1
            if not GetBattlefieldWinner() then
                elapse = floor(GetBattlefieldInstanceRunTime() / 1000)
            end
            C_ChatInfo.SendAddonMessage("BATTLEINFO", "ELAPSE_SYNC " .. key .. " " .. elapse .. " " .. GetServerTime(), "GUILD")
        end
    elseif cmd == "ELAPSE_SYNC" then

        local key = arg1
        local elapse = tonumber(arg2)
        local time = tonumber(arg3)

        if (not key) or (not elapse) or (not time) then
            return
        end
      
        if elapseCache[key] then
            if elapseCache[key].time > time then
                return
            end
        end

        if elapse < 0 then
            elapseCache[key] = nil
        else
            elapseCache[key] = {
                sender = sender,
                elapse = elapse,
                time = time,
            }
        end

        UpdateInstanceButtonText()
    end


end)

RegEvent("BATTLEFIELDS_SHOW", function()
    C_ChatInfo.SendAddonMessage("BATTLEINFO", "ELAPSE_WANTED", "GUILD")
end)

local DROP_MENU_LOC_ENTER = 2
local DROP_MENU_LOC_LEAVE = 1

local function SearchDropMenuLoc(showid, offset)
    local queued = 0

    for i = 1, MAX_BATTLEFIELD_QUEUES do
        local status, mapName, instanceID = GetBattlefieldStatus(i)
        local current = i == showid 

        if current then
            return i * 4 - offset - queued;
        end

        if status == "queued" then
            queued = queued + 1
        end
    end    
end

RegEvent("ADDON_LOADED", function()
    C_ChatInfo.RegisterAddonMessagePrefix("BATTLEINFO")

    hooksecurefunc("BattlefieldFrame_Update", UpdateInstanceButtonText)

    local joinqueuebtn
    do
        local t = CreateFrame("Button", nil, nil, "UIPanelButtonTemplate, SecureActionButtonTemplate")
        t:SetFrameStrata("TOOLTIP")
        t:SetText(ENTER_BATTLE)
        t:SetAttribute("type", "macro") -- left click causes macro
        t:Hide()

        t.updateMacro = function()
            local loc = SearchDropMenuLoc(t.showid, DROP_MENU_LOC_ENTER)
            if loc then
                t:SetAttribute("macrotext", "/click MiniMapBattlefieldFrame RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button" .. (loc)) -- text for macro on left click
            end
        end        

        t:SetScript("OnUpdate", function()
            t.updateMacro()

            for i = 1, MAX_BATTLEFIELD_QUEUES do
                local time = GetBattlefieldPortExpiration(i)
                if time > 0 then
                    t:SetText(ENTER_BATTLE .. "(" .. GREEN_FONT_COLOR:WrapTextInColorCode(time) .. ")")
                    return
                end
            end
            t:SetText(ENTER_BATTLE .. "(" .. GREEN_FONT_COLOR:WrapTextInColorCode("?") .. ")")
        end)

        joinqueuebtn = t
    end

    -- HAHAHAHAHA 
    local leavequeuebtn
    do
        local t = CreateFrame("Button", nil, nil, "UIPanelButtonTemplate, SecureActionButtonTemplate")
        t:SetFrameStrata("TOOLTIP")
        t:SetText(L["CTRL+Hide=Leave"])
        t:SetAttribute("type", "macro") -- left click causes macro
        t:Hide()

        t.updateMacro = function()
            local loc = SearchDropMenuLoc(t.showid, DROP_MENU_LOC_LEAVE)
            if loc then
                t:SetAttribute("macrotext", "/click MiniMapBattlefieldFrame RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button" .. (loc)) -- text for macro on left click
            end
        end

        t.updateframe = CreateFrame("Frame")
        t.updateframe:SetScript("OnUpdate", function()
            t.updateMacro()

            if IsControlKeyDown() then
                leavequeuebtn:Show()
            else
                leavequeuebtn:Hide()
            end
        end)
        t.updateframe:Hide()

        leavequeuebtn = t
    end

    StaticPopupDialogs["CONFIRM_BATTLEFIELD_ENTRY"].OnHide = function()
        joinqueuebtn:Hide()
        joinqueuebtn:ClearAllPoints()
        leavequeuebtn:Hide()
        leavequeuebtn:ClearAllPoints()
        leavequeuebtn.updateframe:Hide()
    end


    local replaceEnter = true
    local replaceHide = true
    local flashIcon = true

    RegisterKeyChangedCallback("replace_enter_battle", function(v)
        replaceEnter = v
    end)
    RegisterKeyChangedCallback("replace_hide_battle", function(v)
        replaceHide = v
        if v then
            StaticPopupDialogs["CONFIRM_BATTLEFIELD_ENTRY"].button2 = L["CTRL+Hide=Leave"]
        else
            StaticPopupDialogs["CONFIRM_BATTLEFIELD_ENTRY"].button2 = HIDE
        end
    end)
    RegisterKeyChangedCallback("flash_icon", function(v)
        flashIcon = v
    end)


    -- hooksecurefunc(StaticPopupDialogs["CONFIRM_BATTLEFIELD_ENTRY"], "OnShow", function(self)
    StaticPopupDialogs["CONFIRM_BATTLEFIELD_ENTRY"].OnShow = function(self, data)
        if flashIcon then
            FlashClientIcon()
        end

        local tx = self.text:GetText()
        if InCombatLockdown() then
            ADDONSELF.Print(L["Button may not work properly during combat"])
            return
        end

        if replaceEnter then
            joinqueuebtn.showid = data
            joinqueuebtn:SetAllPoints(self.button1)
            joinqueuebtn:Show()
        end

        if replaceHide then
            leavequeuebtn.showid = data
            leavequeuebtn:SetAllPoints(self.button2)
            leavequeuebtn.updateframe:Show()
        end

    end

end)
