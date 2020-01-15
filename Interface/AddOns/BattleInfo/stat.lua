local _, ADDONSELF = ...
local L = ADDONSELF.L
local RegEvent = ADDONSELF.regevent
local BattleZoneHelper = ADDONSELF.BattleZoneHelper

local f = CreateFrame("Frame", nil, HonorFrame)
f:SetBackdrop({ 
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    tile = true,
    tileEdge = true,
    tileSize = 16,
    edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 },    
})
f:SetWidth(200)
f:SetHeight(180)
f:SetBackdropColor(0, 0, 0)
f:SetPoint("TOPLEFT", HonorFrame, "TOPRIGHT" , -30, -15)
f:Hide()

local loc = 50
local function nextloc()
    loc = loc - 50
    return loc
end

local labels = {}

local function DrawStat(bgid)

    local p = CreateFrame("Frame", nil, f)
    p:SetPoint("TOPLEFT", f, 15, -15 + nextloc())
    p:SetWidth(200)
    p:SetHeight(50)

    do
        local t = p:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        t:SetText(BattleZoneHelper.BGID_MAPNAME_MAP[bgid])
        t:SetPoint("TOPLEFT", p, 0, 0)
    end

    do
        local t = p:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        t:SetPoint("TOPLEFT", p, 0, -25)
        labels[bgid] = t
    end
end

local function UpdateStatLabels()

    for bgid, l in pairs(labels) do
        local stat = BatteInfoStat[bgid]
        local win = stat.win or 0 
        local total = stat.total or 0

        local rate = ""
        if total > 0 then
            rate = "= " .. (math.floor(win / total * 10000) / 100) .. "%"
        end
        l:SetText(L["Win rate"] .. ": " .. string.format("%s/%s %s", win, total, rate))
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
            BatteInfoStat[battleGroundID].win = BatteInfoStat[battleGroundID].win or 0
            BatteInfoStat[battleGroundID].total = BatteInfoStat[battleGroundID].total or 0
            
            BatteInfoStat[battleGroundID].total = BatteInfoStat[battleGroundID].total + 1

            if win then
                BatteInfoStat[battleGroundID].win = BatteInfoStat[battleGroundID].win + 1
            end

            scorerecorded = true

            -- print(BatteInfoStat[battleGroundID].win)
            -- print(BatteInfoStat[battleGroundID].total)
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
    
end)
