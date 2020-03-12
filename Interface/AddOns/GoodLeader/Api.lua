---@type ns
local ADDON_NAME, ns = ...
local L = ns.L

ns.ADDON_VERSION = GetAddOnMetadata(ADDON_NAME, 'Version')
ns.ADDON_PREFIX = format('|cff00ffff%s|r：', L.ADDON_NAME)

ns.RAID_LOGO = {
    [C_Map.GetAreaInfo(2717)] = [[Interface\ENCOUNTERJOURNAL\UI-EJ-BOSS-Ragnaros]], -- 熔火之心
    [C_Map.GetAreaInfo(2159)] = [[Interface\ENCOUNTERJOURNAL\UI-EJ-BOSS-Onyxia]], -- 奥妮克希亚的巢穴
    [C_Map.GetAreaInfo(2677)] = [[Interface\ENCOUNTERJOURNAL\UI-EJ-BOSS-Nefarian]], -- 黑翼之巢
    [C_Map.GetAreaInfo(3428)] = [[Interface\ENCOUNTERJOURNAL\UI-EJ-BOSS-CThun]], -- 安其拉神殿
    [C_Map.GetAreaInfo(3456)] = [[Interface\ENCOUNTERJOURNAL\UI-EJ-BOSS-KelThuzad]], -- 纳克萨玛斯
    [C_Map.GetAreaInfo(1977)] = [[Interface\ENCOUNTERJOURNAL\UI-EJ-BOSS-Avatar of Hakkar]], -- 祖尔格拉布
    [C_Map.GetAreaInfo(3429)] = [[Interface\ENCOUNTERJOURNAL\UI-EJ-BOSS-Ossirian the Unscarred]], -- 安其拉废墟
}

local function GetSlotItemLevel(unit, slot)
    local id = GetInventoryItemID(unit, slot)
    if not id then
        return 0
    end
    local itemLevel = select(4, GetItemInfo(id))
    return itemLevel
end

local function IsNoRangeWeaponClass(unit)
    local class = select(2, UnitClass(unit))
    return class == 'PALADIN' or class == 'SHAMAN' or class == 'DRUID'
end

local ITEMS = { --
    [1] = GetSlotItemLevel,
    [2] = GetSlotItemLevel,
    [3] = GetSlotItemLevel,
    [5] = GetSlotItemLevel,
    [6] = GetSlotItemLevel,
    [7] = GetSlotItemLevel,
    [8] = GetSlotItemLevel,
    [9] = GetSlotItemLevel,
    [10] = GetSlotItemLevel,
    [11] = GetSlotItemLevel,
    [12] = GetSlotItemLevel,
    [13] = GetSlotItemLevel,
    [14] = GetSlotItemLevel,
    [15] = GetSlotItemLevel,
    [16] = function(unit, slot)
        local id = GetInventoryItemID(unit, slot)
        if not id then
            return 0
        end
        local itemLevel, _, _, _, _, itemEquipLoc = select(4, GetItemInfo(id))
        if itemEquipLoc == 'INVTYPE_2HWEAPON' then
            return itemLevel * 2
        end
        return itemLevel
    end,
    [17] = GetSlotItemLevel,
    [18] = function(unit, slot)
        if IsNoRangeWeaponClass(unit) then
            return 0
        end
        return GetSlotItemLevel(unit, slot)
    end,
}

function ns.GetPlayerItemLevel()
    return ns.GetUnitItemLevel('player')
end

function ns.GetUnitItemLevel(unit)
    local itemLevel = 0
    for slot, func in pairs(ITEMS) do
        local level = func(unit, slot)
        if not level then
            return
        end
        itemLevel = itemLevel + level
    end
    local count = IsNoRangeWeaponClass(unit) and 16 or 17
    return floor(itemLevel / count * 10) / 10
end

local RAID_UNITS = {}
local PARTY_UNITS = {player = true}
local SOLO_UNITS = {player = true}

for i = 1, 40 do
    RAID_UNITS['raid' .. i] = true
end

for i = 1, 4 do
    PARTY_UNITS['party' .. i] = true
end

function ns.IterateGroupUnits()
    if IsInRaid() then
        return pairs(RAID_UNITS)
    elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
        return pairs(PARTY_UNITS)
    else
        return pairs(SOLO_UNITS)
    end
end

function ns.GetGroupLeader()
    for unit in ns.IterateGroupUnits() do
        if UnitIsGroupLeader(unit) then
            return UnitName(unit), UnitGUID(unit)
        end
    end
    return UnitName('player'), UnitGUID('player')
end

function ns.IsInGroup()
    return IsInGroup(LE_PARTY_CATEGORY_HOME)
end

function ns.Message(msg, ...)
    if select('#', ...) > 0 then
        return SendSystemMessage(string.format(ns.ADDON_PREFIX .. msg, ...))
    end
    return SendSystemMessage(ns.ADDON_PREFIX .. msg)
end
