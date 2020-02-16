local _, ADDONSELF = ...
local L = ADDONSELF.L
local RegEvent = ADDONSELF.regevent
local BattleZoneHelper = ADDONSELF.BattleZoneHelper
local RegisterKeyChangedCallback = ADDONSELF.RegisterKeyChangedCallback 

local winratestats = {
    HONOR_TODAY, 
    HONOR_YESTERDAY, 
    HONOR_THISWEEK, 
    HONOR_LASTWEEK, 
    HONOR_LIFETIME,
}

local panelheight = (#winratestats) * 20

local f = CreateFrame("Frame", nil, HonorFrame)
f:SetBackdrop({ 
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileEdge = true,
    tileSize = 16,
    edgeSize = 24,
    insets = { left = 4, right = 4, top = 4, bottom = 4 },    
})
-- f:SetBackdropColor(0, 0, 0)
f:SetPoint("TOPLEFT", HonorFrame, "TOPRIGHT" , -30, -15)
f:SetWidth(260)
f:SetHeight((30 + panelheight + 10) * 3 + 10)

local loc = 30 + panelheight
local function nextloc()
    loc = loc - 30 - panelheight
    return loc
end

local function Today()
    return math.floor((time() + time(date("*t", time())) - time(date("!*t", time()))) / 86400) 
end

local labels = {}

local function DrawStat(bgid)

    local p = CreateFrame("Frame", nil, f)
    p:SetBackdrop({ 
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 16,
    })    
    p:SetPoint("TOPLEFT", f, 15, -15 + nextloc())
    p:SetWidth(230)
    p:SetHeight(30 + panelheight + 10)

    -- p:SetScript("OnMouseUp", function()
    --     DEFAULT_CHAT_FRAME.editBox:SetText(DEFAULT_CHAT_FRAME.editBox:GetText() .. BattleZoneHelper.BGID_MAPNAME_MAP[bgid] .. " " .. labels[bgid]:GetText())
    --     DEFAULT_CHAT_FRAME.editBox:Show()
    -- end)

    labels[bgid] = {}

    do
        local t = p:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        t:SetText(BattleZoneHelper.BGID_MAPNAME_MAP[bgid] .. " " .. L["Win rate"])
        t:SetPoint("TOPLEFT", p, 10, -10)
    end

    local l = -10
    for i, n in pairs(winratestats) do
        local t = p:CreateFontString(nil, "ARTWORK", "GameFontWhite")
        t:SetPoint("TOPLEFT", p, 20, -10 + i * (-20))
        -- t:SetText(L["Win rate"] .. " " .. n .. ": " )
        -- labels[bgid] = t

        labels[bgid][n] = t
    end
end

local function UpdateStatLabel(l, n, win, total)
    local win = win or 0 
    local total = total or 0

    local rate = ""
    if total > 0 then
        rate = "= " .. NORMAL_FONT_COLOR:WrapTextInColorCode((math.floor(win / total * 10000) / 100) .. "%")
    end
    l:SetText(n .. ": " .. string.format("%s/%s %s", GREEN_FONT_COLOR:WrapTextInColorCode(win), YELLOW_FONT_COLOR:WrapTextInColorCode(total), rate))
end

local function UpdateStatLabels()
    local today = Today()

    for bgid, ls in pairs(labels) do
        local stat = {}
        for _, n in pairs(winratestats) do
            stat[n] = {}
        end

        stat[HONOR_TODAY].win = (BatteInfoStat[bgid][today] or {}).win
        stat[HONOR_TODAY].total = (BatteInfoStat[bgid][today] or {}).total

        stat[HONOR_YESTERDAY].win = (BatteInfoStat[bgid][today - 1] or {}).win
        stat[HONOR_YESTERDAY].total = (BatteInfoStat[bgid][today - 1] or {}).total

        stat[HONOR_LIFETIME].win = (BatteInfoStat[bgid] or {}).win
        stat[HONOR_LIFETIME].total = (BatteInfoStat[bgid] or {}).total

        -- this week
        do
            local s = {}
            s.win = 0
            s.total = 0

            for i = 0, 6 do
                s.win = s.win + ((BatteInfoStat[bgid][today - i] or {}).win or 0)
                s.total = s.total + ((BatteInfoStat[bgid][today - i] or {}).total or 0)
            end

            stat[HONOR_THISWEEK] = s
        end

        -- last week
        do
            local s = {}
            s.win = 0
            s.total = 0

            for i = 7, 13 do
                s.win = s.win + ((BatteInfoStat[bgid][today - i] or {}).win or 0)
                s.total = s.total + ((BatteInfoStat[bgid][today - i] or {}).total or 0)
            end

            stat[HONOR_LASTWEEK] = s
        end

        for n, l in pairs(ls) do
            UpdateStatLabel(l, n, stat[n].win, stat[n].total)
        end

        -- local stat = BatteInfoStat[bgid]
    end
end


local FACTION_HORDE = 0
local FACTION_ALLIANCE = 1

local function PlayerFaction() 
    local factionGroup = UnitFactionGroup("player");
    if ( factionGroup == "Alliance" ) then
        return FACTION_ALLIANCE
    else
        return FACTION_HORDE
    end
end

local scorerecorded = false
RegEvent("PLAYER_ENTERING_WORLD", function()
    scorerecorded = false
end)

RegEvent("UPDATE_BATTLEFIELD_STATUS", function()
    if scorerecorded then
        return
    end

    local battlefieldWinner = GetBattlefieldWinner()

    if battlefieldWinner then
        local battleGroundID = BattleZoneHelper.MAPNAME_BGID_MAP[GetRealZoneText()]
        local win = battlefieldWinner == PlayerFaction()
        if battleGroundID then
            local today = Today()
            BatteInfoStat[battleGroundID] = BatteInfoStat[battleGroundID] or {}
            BatteInfoStat[battleGroundID][today] = BatteInfoStat[battleGroundID][today] or {}

            local stats = {BatteInfoStat[battleGroundID], BatteInfoStat[battleGroundID][today]}

            for _, stat in pairs(stats) do
                stat.win = stat.win or 0
                stat.total = stat.total or 0

                stat.total = stat.total + 1

                if win then
                    stat.win = stat.win + 1
                end
            end

            scorerecorded = true

        end
        
        UpdateStatLabels()
    end
end)

RegEvent("ADDON_LOADED", function()
    BatteInfoStat = BatteInfoStat or {}

    for _, id in pairs(BattleZoneHelper.MAPNAME_BGID_MAP) do
        BatteInfoStat[id] = BatteInfoStat[id] or {
            start = time(),
        }

        DrawStat(id)
    end

    UpdateStatLabels()

    RegisterKeyChangedCallback("stat_window", function(v)
        if v then
            f:Show()
        else
            f:Hide()
        end
    end)   
    
end)
