local _, ADDONSELF = ...
local L = ADDONSELF.L
local RegEvent = ADDONSELF.regevent


ADDONSELF.Print = function(msg)
    DEFAULT_CHAT_FRAME:AddMessage("|CFFFF0000<|r|CFFFFD100BattleInfo|r|CFFFF0000>|r"..(msg or "nil"))
end

ADDONSELF.InBattleground = function()
    -- return true
    return UnitInBattleground("player")
end

local BattleZoneHelper = {}
ADDONSELF.BattleZoneHelper = BattleZoneHelper

BattleZoneHelper.MAPID_ALTERAC = 1459
BattleZoneHelper.MAPNAME_ALTERAC = C_Map.GetMapInfo(BattleZoneHelper.MAPID_ALTERAC).name

BattleZoneHelper.MAPID_WARSONG = 1460
BattleZoneHelper.MAPNAME_WARSONG = C_Map.GetMapInfo(BattleZoneHelper.MAPID_WARSONG).name

BattleZoneHelper.MAPID_ARATHI = 1461
BattleZoneHelper.MAPNAME_ARATHI = C_Map.GetMapInfo(BattleZoneHelper.MAPID_ARATHI).name

-- ( 1 for Alterac Valley, 2 for Warsong Gulch, 3 for Arathi Basin,
BattleZoneHelper.BGID_ALTERAC = 1
BattleZoneHelper.BGID_WARSONG = 2
BattleZoneHelper.BGID_ARATHI = 3

BattleZoneHelper.BGID_MAPNAME_MAP = {
    [BattleZoneHelper.MAPNAME_ALTERAC] = BattleZoneHelper.BGID_ALTERAC,
    [BattleZoneHelper.MAPNAME_WARSONG] = BattleZoneHelper.BGID_WARSONG,
    [BattleZoneHelper.MAPNAME_ARATHI] = BattleZoneHelper.BGID_ARATHI,
}

function BattleZoneHelper:IsInAlterac()
    return GetRealZoneText() == self.MAPNAME_ALTERAC
end

function BattleZoneHelper:IsInWarsong()
    return GetRealZoneText() == self.MAPNAME_WARSONG
end

function BattleZoneHelper:GetCurrentBG()

    for i=1, MAX_BATTLEFIELD_QUEUES do
        local status, mapName, instanceID = GetBattlefieldStatus(i);

        if status == "active" then
            return self.BGID_MAPNAME_MAP[mapName], instanceID
        end
    end
end

RegEvent("ADDON_LOADED", function()
    ADDONSELF.Print(L["BattleInfo Loaded"])
end)
