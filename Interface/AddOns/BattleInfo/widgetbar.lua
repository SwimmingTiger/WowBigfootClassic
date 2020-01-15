local _, ADDONSELF = ...
local L = ADDONSELF.L
local RegEvent = ADDONSELF.regevent
local BattleZoneHelper = ADDONSELF.BattleZoneHelper
local RegisterKeyChangedCallback = ADDONSELF.RegisterKeyChangedCallback 

local f = CreateFrame("Frame", nil, UIWidgetTopCenterContainerFrame)
f:SetAllPoints()

do
    local av = CreateFrame("Frame", nil, f)
    av:SetAllPoints()
    f.av = av
    av.forcehide = false
    av.nums = {}

    RegisterKeyChangedCallback("show_alterac", function(v)
        av.forcehide = not v
    end)
end

local spirittime

local function GetSpiritHealerText()
	if spirittime then
		local c = 31515 -- magic :(
		local x = mod(c - mod((( GetTime() - spirittime)) * 1000, c), c) / 1000 + 1
		if x > 30 then
			return L["Spirit healing ..."]
        end
		return L["Spirit heal AE in: %s Secs"]:format(GREEN_FONT_COLOR:WrapTextInColorCode(floor(x)))
	else
		return L["Spirit heal AE: not dead"]
	end
end

local function UpdatepiritHealerText()
    if GetAreaSpiritHealerTime() > 0 then 
        spirittime = GetTime() + GetAreaSpiritHealerTime()
    end

    f.spiritlabel:SetText(GetSpiritHealerText())
end


local function CreateAlteracStatus()

    local av = f.av
    
    if av.created then
        return
    end

    local poiequal = function(poi1, poi2)
        local arr1 = {GetPOITextureCoords(poi1)}
        local arr2 = {GetPOITextureCoords(poi2)}

        for i = 1, 4 do
            if arr1[i] ~= arr2[i] then
                return false
            end
        end

        return true
    end

    -- this is tricky, cause during login, poi is not available. retry later
    if poiequal(BattleZoneHelper.POI_ALLIANCE_TOWER, BattleZoneHelper.POI_ALLIANCE_GRAVEYARD) then
        return
    end

    do
        local t = av:CreateTexture(nil, "BACKGROUND")
        t:SetAtlas("alliance_icon_horde_flag-icon")
        t:SetWidth(42)
        t:SetHeight(42)
        t:SetPoint("TOP", av, "TOP", -3, 0)

    end

    do
        local t = av:CreateTexture(nil, "BACKGROUND")
        t:SetPoint("TOP", av, "TOP", 15, -5)
        t:SetWidth(16)
        t:SetHeight(16)
        t:SetTexture("Interface/Minimap/POIIcons")
        
        local x1, x2, y1, y2 = GetPOITextureCoords(BattleZoneHelper.POI_ALLIANCE_TOWER) -- Alliance Tower
        t:SetTexCoord(x1, x2, y1, y2)

        local l = av:CreateFontString(nil, "BACKGROUND", "GameFontNormalSmall")
        l:SetPoint("TOPLEFT", t, "TOPLEFT", 20, -3)
        l:SetText("?")
        av.nums[10] = l
    end

    do
        local t = av:CreateTexture(nil, "BACKGROUND")
        t:SetPoint("TOP", av, "TOP", 50, -5)
        t:SetWidth(16)
        t:SetHeight(16)
        t:SetTexture("Interface/Minimap/POIIcons")
        
        local x1, x2, y1, y2 = GetPOITextureCoords(BattleZoneHelper.POI_ALLIANCE_GRAVEYARD) -- Alliance Graveyard 
        t:SetTexCoord(x1, x2, y1, y2)

        local l = av:CreateFontString(nil, "BACKGROUND", "GameFontNormalSmall")
        l:SetPoint("TOPLEFT", t, "TOPLEFT", 20, -3)
        l:SetText("?")
        av.nums[14] = l
    end

    do
        local t = av:CreateTexture(nil, "BACKGROUND")
        t:SetAtlas("horde_icon_alliance_flag-icon")
        t:SetWidth(42)
        t:SetHeight(42)
        t:SetPoint("TOP", av, "TOP", -3, -25)
    end

    do
        local t = av:CreateTexture(nil, "BACKGROUND")
        t:SetPoint("TOP", av, "TOP", 15, -27)
        t:SetWidth(16)
        t:SetHeight(16)
        t:SetTexture("Interface/Minimap/POIIcons")
        
        local x1, x2, y1, y2 = GetPOITextureCoords(BattleZoneHelper.POI_HORDE_TOWER) -- Horde Tower
        t:SetTexCoord(x1, x2, y1, y2)

        local l = av:CreateFontString(nil, "BACKGROUND", "GameFontNormalSmall")
        l:SetPoint("TOPLEFT", t, "TOPLEFT", 20, -3)
        l:SetText("?")
        av.nums[9] = l
    end

    do
        local t = av:CreateTexture(nil, "BACKGROUND")
        t:SetPoint("TOP", av, "TOP", 50, -27)
        t:SetWidth(16)
        t:SetHeight(16)
        t:SetTexture("Interface/Minimap/POIIcons")
        
        local x1, x2, y1, y2 = GetPOITextureCoords(BattleZoneHelper.POI_HORDE_GRAVEYARD) -- Horde Graveyard 
        t:SetTexCoord(x1, x2, y1, y2)

        local l = av:CreateFontString(nil, "BACKGROUND", "GameFontNormalSmall")
        l:SetPoint("TOPLEFT", t, "TOPLEFT", 20, -3)
        l:SetText("?")
        av.nums[12] = l
    end        

    av.created = true
end

local function UpdateAlteracNumbers()
    if not BattleZoneHelper:IsInAlterac() then
        return
    end

    CreateAlteracStatus()

    local data = BattleZoneHelper:GetAlteracPOI()
    for _, l in pairs(f.av.nums) do
        l:SetText("0")
    end
    
    for t, n in pairs(data) do
        if f.av.nums[t] then
            f.av.nums[t]:SetText(n)
        end
    end
end

local function HideAll()
    f:Hide()
end

local function ShowAll()
    f:Show()

    if BattleZoneHelper:IsInAlterac() and not f.av.forcehide then
        f.av:Show()
    else
        f.av:Hide()
    end
end

local function OnUpdate()
    if not ADDONSELF.InBattleground() then
        HideAll()
        return
    end

    ShowAll()
    UpdatepiritHealerText()

    f.elapselabel:SetText(SecondsToTime(GetBattlefieldInstanceRunTime()/1000))

    RequestBattlefieldScoreData()
end

RegEvent("AREA_POIS_UPDATED", function()
    UpdateAlteracNumbers()
end)

RegEvent("PLAYER_ENTERING_WORLD", function()
    spirittime = nil
    
    f.num.alliance:SetText("")
    f.num.horde:SetText("")
    f.num.stat = nil
    
    UpdateAlteracNumbers()
end)

local FACTION_HORDE = 0
local FACTION_ALLIANCE = 1

RegEvent("UPDATE_BATTLEFIELD_SCORE", function()

    local stat = {}
    stat[FACTION_ALLIANCE] = {
        class = {},
        realm = {},
        maxrealm = "",
        maxrealmc = 0,
        rank = 0,
    }
    stat[FACTION_HORDE] = {
        class = {},
        realm = {},
        maxrealm = "",
        maxrealmc = 0,
        rank = 0,
    }

    for i = 1, 80 do
        local playerName, _, _, _, _, faction, rank, _, _, filename = GetBattlefieldScore(i)

        if filename then
            if not stat[faction].class[filename] then
                stat[faction].class[filename] = 0
            end

            stat[faction].class[filename] = stat[faction].class[filename] + 1

            local _, realm = strsplit("-", playerName)
            realm = realm or GetRealmName()

            if not stat[faction].realm[realm] then
                stat[faction].realm[realm] = 0
            end
            
            stat[faction].realm[realm] = stat[faction].realm[realm] + 1

            if stat[faction].maxrealmc < stat[faction].realm[realm] then
                stat[faction].maxrealmc = stat[faction].realm[realm]
                stat[faction].maxrealm  = realm
            end

            stat[faction].rank = stat[faction].rank + rank
        end
    end

    local _, _, _, _, numHorde = GetBattlefieldTeamInfo(FACTION_HORDE)
    local _, _, _, _, numAlliance = GetBattlefieldTeamInfo(FACTION_ALLIANCE)
    
    stat[FACTION_HORDE].count = numHorde
    stat[FACTION_ALLIANCE].count = numAlliance

    f.num.alliance:SetText(numAlliance)
    f.num.horde:SetText(numHorde)

    f.num.stat = stat
end)

RegEvent("ADDON_LOADED", function()

    -- do
    --     local setID = C_UIWidgetManager.GetTopCenterWidgetSetID()
    --     if setID then
    --         hooksecurefunc(UIWidgetManager.registeredWidgetSetContainers[setID], "layoutFunc", function()
    --             print(11)
    --         end)
    --     end
    -- end
   
    do
        local l = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
        l:SetPoint("TOPLEFT", f, -15, 12)
        f.spiritlabel = l
        RegisterKeyChangedCallback("show_spirit_heal", function(v)
            if v then
                l:Show()
            else
                l:Hide()
            end
        end)
    end


    do
        local tooltip = CreateFrame("GameTooltip", "BattleInfoNumber" .. random(10000), UIParent, "GameTooltipTemplate")

        UIWidgetTopCenterContainerFrame:SetMovable(true)
        local dragStart = function()
            tooltip:Hide()

            if IsAltKeyDown() then
                UIWidgetTopCenterContainerFrame:StartMoving()
            end
        end

        local dragStop = function()
            UIWidgetTopCenterContainerFrame:StopMovingOrSizing()
        end

        local num = CreateFrame("Frame", nil, f)
        num:SetSize(35, 42)
        num:SetPoint("TOPLEFT", f, -35, 0)

        num:SetScript("OnLeave", hideTooltip)

        f.num = num

        local factionLoc = {}
        factionLoc[FACTION_ALLIANCE] = C_CreatureInfo.GetFactionInfo(1).name
        factionLoc[FACTION_HORDE] = C_CreatureInfo.GetFactionInfo(2).name

        local showTooltip = function(faction)
            if not num.stat then
                return
            end
            if #num.stat == 0 then
                return
            end

            local stat = num.stat[faction]

            tooltip:SetOwner(num, "ANCHOR_LEFT")
            tooltip:SetText(factionLoc[faction])
            tooltip:AddLine(" ")

            if stat.maxrealmc / stat.count  > 0.15 and stat.maxrealmc > 1 then
                tooltip:AddDoubleLine(stat.maxrealm, string.format("%d/%d", stat.maxrealmc, stat.count))
                tooltip:AddLine(" ")
            end

            if stat.rank > 0 then
                local rank = math.floor(stat.rank / stat.count)
                local rankName, rankNumber = GetPVPRankInfo(rank, faction)
                tooltip:AddDoubleLine(L["Avg Rank"], rankName .. " (R" .. rankNumber .. ")")
                tooltip:AddLine(" ")
            end

            for c, n in pairs(stat.class) do
                local color = GetClassColorObj(c)
                tooltip:AddDoubleLine(color:WrapTextInColorCode(ADDONSELF.CLASS_LOC[c]), n)
            end

            tooltip:Show()
        end

        local hideTooltip = function()
            tooltip:Hide()
            tooltip:SetOwner(UIParent, "ANCHOR_NONE")
        end  

        local yellComposition = function(faction)
            if not num.stat then
                return
            end
            if #num.stat == 0 then
                return
            end

            local stat = num.stat[faction]
            local text = factionLoc[faction]

            for c, n in pairs(stat.class) do
                text = text .. " " .. ADDONSELF.CLASS_LOC[c] .. ":" .. n
            end

            if stat.maxrealmc / stat.count  > 0.15 and stat.maxrealmc > 1 then
                text = text .. " " .. stat.maxrealm .. ":" .. string.format("%d/%d", stat.maxrealmc, stat.count)
            end

            if stat.rank > 0 then
                local rank = math.floor(stat.rank / stat.count)
                local rankName, rankNumber = GetPVPRankInfo(rank, faction)
                text = text .. " " .. L["Avg Rank"] .. ":" .. rankName .. " (R" .. rankNumber .. ")"
            end            

            SendChatMessage(text, "INSTANCE_CHAT")
        end

        do
            local t =  CreateFrame("Frame", nil, num)
            t:SetPoint("TOPLEFT", num, 0, -7)
            t:SetSize(35, 10)
            t:SetScript("OnMouseUp", function()
                yellComposition(FACTION_ALLIANCE)
            end)
            t:SetScript("OnEnter", function()
                showTooltip(FACTION_ALLIANCE)
            end)
            WorldStateScoreFrameTab2:HookScript("OnEnter", function()
                showTooltip(FACTION_ALLIANCE)
            end)
            t:SetScript("OnLeave", hideTooltip)
            WorldStateScoreFrameTab2:HookScript("OnLeave", hideTooltip)            
            t:RegisterForDrag("LeftButton")
            t:SetScript("OnDragStart", dragStart)
            t:SetScript("OnDragStop", dragStop)

            local l = t:CreateFontString(nil, "ARTWORK", "GameFontNormal")
            l:SetPoint("TOPLEFT", num, 0, -7)
            f.num.alliance = l
            -- l:SetText("10")
        end

        do
            local t =  CreateFrame("Frame", nil, num)
            t:SetPoint("TOPLEFT", num, 0, -30)
            t:SetSize(35, 21)
            t:SetScript("OnMouseUp", function()
                yellComposition(FACTION_HORDE)
            end)
            t:SetScript("OnEnter", function()
                showTooltip(FACTION_HORDE)
            end)
            WorldStateScoreFrameTab3:HookScript("OnEnter", function()
                showTooltip(FACTION_HORDE)
            end)
            t:SetScript("OnLeave", hideTooltip)
            WorldStateScoreFrameTab3:HookScript("OnLeave", hideTooltip)               
            t:RegisterForDrag("LeftButton")
            t:SetScript("OnDragStart", dragStart)
            t:SetScript("OnDragStop", dragStop)

            local l = t:CreateFontString(nil, "ARTWORK", "GameFontNormal")
            l:SetPoint("TOPLEFT", num, 0, -30)
            f.num.horde = l
            -- l:SetText("20")
        end

        RegisterKeyChangedCallback("show_number", function(v)
            if v then
                f.num:Show()
            else
                f.num:Hide()
            end
        end)
    end

    do
        local l = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
        l:SetPoint("TOPLEFT", f, -15, -50)
        f.elapselabel = l
        RegisterKeyChangedCallback("show_time_elapsed", function(v)
            if v then
                l:Show()
            else
                l:Hide()
            end
        end)
    end

    UIWidgetTopCenterContainerFrame:HookScript("OnUpdate", OnUpdate)

    local MAX_SCORE_BUTTONS = 22
    hooksecurefunc("WorldStateScoreFrame_Update", function() 
        for i = 1, MAX_SCORE_BUTTONS do
            local scoreButton = _G["WorldStateScoreButton"..i]

            if scoreButton.index then
                local _, _, _, _, _, _, _, _, _, filename = GetBattlefieldScore(scoreButton.index)

                local text = scoreButton.name.text:GetText()

                if text and filename then
                    local color = GetClassColorObj(filename)
                    scoreButton.name.text:SetText(color:WrapTextInColorCode(text))
                end
            end
        end
    end)
end)
