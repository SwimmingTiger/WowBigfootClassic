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


ADDONSELF.CLASS_LOC = {}
FillLocalizedClassList(ADDONSELF.CLASS_LOC)

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
    [BattleZoneHelper.BGID_ALTERAC] = BattleZoneHelper.MAPNAME_ALTERAC,
    [BattleZoneHelper.BGID_WARSONG] = BattleZoneHelper.MAPNAME_WARSONG, 
    [BattleZoneHelper.BGID_ARATHI]  = BattleZoneHelper.MAPNAME_ARATHI,
}

BattleZoneHelper.MAPNAME_BGID_MAP = {
    [BattleZoneHelper.MAPNAME_ALTERAC] = BattleZoneHelper.BGID_ALTERAC,
    [BattleZoneHelper.MAPNAME_WARSONG] = BattleZoneHelper.BGID_WARSONG,
    [BattleZoneHelper.MAPNAME_ARATHI]  = BattleZoneHelper.BGID_ARATHI,
}


-- Alliance Tower 10
-- Alliance Tower Half 8
-- Alliance Graveyard 14
-- Alliance Graveyard Half 3

-- Horde Tower 9
-- Horde Tower Half 11
-- Horde Graveyard 12
-- Horde Graveyard Half 13
BattleZoneHelper.POI_ALLIANCE_TOWER = 10
BattleZoneHelper.POI_ALLIANCE_TOWER_HALF = 8
BattleZoneHelper.POI_ALLIANCE_GRAVEYARD = 14
BattleZoneHelper.POI_ALLIANCE_GRAVEYARD_HALF = 3

BattleZoneHelper.POI_HORDE_TOWER = 9
BattleZoneHelper.POI_HORDE_TOWER_HALF = 11
BattleZoneHelper.POI_HORDE_GRAVEYARD = 12
BattleZoneHelper.POI_HORDE_GRAVEYARD_HALF = 13


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
            return self.MAPNAME_BGID_MAP[mapName], instanceID
        end
    end
end

function BattleZoneHelper:GetAlteracPOI()
    local data = {}

    local areaPOIs = C_AreaPoiInfo.GetAreaPOIForMap(BattleZoneHelper.MAPID_ALTERAC)
    local textures = C_Map.GetMapArtLayerTextures(BattleZoneHelper.MAPID_ALTERAC, 1) -- 1 for layer id, should be a const value

	for _, areaPoiID in ipairs(areaPOIs) do
		local poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(BattleZoneHelper.MAPID_ALTERAC, areaPoiID)
        if poiInfo then
            local t = poiInfo.textureIndex

            if not data[t] then
                data[t] = 0
            end

            data[t] = data[t] + 1
		end
    end

    return data
end

RegEvent("ADDON_LOADED", function()
    ADDONSELF.Print(L["BattleInfo Loaded"])
end)
