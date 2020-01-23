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


local battleList = {}
local function UpdateBattleListCache()
    local mapName = GetBattlegroundInfo()

    if not mapName then
        return
    end

    if not battleList[mapName] then
        battleList[mapName] = {}
    end
    table.wipe(battleList[mapName])
    
    local n = GetNumBattlefields()
    for i = 1, n  do
        local instanceID = GetBattlefieldInstanceInfo(i)
        battleList[mapName][tonumber(instanceID)] = { i = i , n = n }
    end

    UpdateInstanceButtonText()
end

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

    hooksecurefunc("JoinBattlefield", UpdateBattleListCache)
    hooksecurefunc("BattlefieldFrame_Update", UpdateBattleListCache)

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

        if string.find(tx, L["List Position"], 1, 1) or string.find(tx, L["New"], 1 , 1) then			
            return
        end    

        for mapName, instanceIDs in pairs(battleList) do
            local _, _ ,toJ = string.find(tx, ".+" .. mapName .. " (%d+).+")
            toJ = tonumber(toJ)
            if toJ then
                if instanceIDs[toJ] then

                    -- first half 0 - rate -> red (0)
                    -- second half rate - 100% -> red(0) -> yellow (1)
                    local rate = 0.45
                    local pos = instanceIDs[toJ].i
                    local total = instanceIDs[toJ].n

                    local pos0 = math.max(pos - total * rate - 1, 0)

                    local color = CreateColor(1.0, math.min(pos0 / (total * (1 - rate)), 1) , 0)
                    local text = color:WrapTextInColorCode(L["List Position"] .. " " .. string.format("%d/%d", pos, total))

                    local elp = GetElapseFromCache(mapName, toJ)
                    if elp then
                        text = RED_FONT_COLOR:WrapTextInColorCode(SecondsToTime(elp))
                    end

                    self.text:SetText(string.gsub(tx ,toJ , YELLOW_FONT_COLOR:WrapTextInColorCode(toJ) .. "(" .. text .. ")"))
                else
                    local text = GREEN_FONT_COLOR:WrapTextInColorCode(L["New"])
                    self.text:SetText(string.gsub(tx ,toJ , YELLOW_FONT_COLOR:WrapTextInColorCode(toJ) .. "(" .. text .. ")"))

                end
                break
            end
        end
        
    end

end)
