---@type ns
local ADDON_NAME, ns = ...

ns.ADDON_VERSION = GetAddOnMetadata(ADDON_NAME, 'Version')

local function GetSlotItemLevel(slot)
    local id = GetInventoryItemID('player', slot)
    if not id then
        return 0
    end
    local itemLevel = select(4, GetItemInfo(id))
    return itemLevel
end

local function IsNoRangeWeaponClass()
    local class = select(2, UnitClass('player'))
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
    [16] = function(slot)
        local id = GetInventoryItemID('player', slot)
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
    [18] = function()
        if IsNoRangeWeaponClass() then
            return 0
        end
        return GetSlotItemLevel(18)
    end,
}

function ns.GetPlayerItemLevel()
    local itemLevel = 0
    for slot, func in pairs(ITEMS) do
        itemLevel = itemLevel + func(slot)
    end
    local count = IsNoRangeWeaponClass() and 16 or 17
    return floor(itemLevel / count)
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
