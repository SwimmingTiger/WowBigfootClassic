--[[
-- A compatible implementation of GetTotemInfo() API for WoW Classic 1.13.3.
-- The code from <https://git.neuromancy.net/projects/RM/repos/rotationmaster/browse/fake.lua?until=a0a2fc3bdfb5fa8199f14d66bd22666258f67aa4&untilPath=fake.lua>
-- and edited / fixed by SwimmingTiger.
]]
local MAJOR = "LibTotemInfo-1.0"
local MINOR = 1 -- Should be manually increased
local LibStub = _G.LibStub

assert(LibStub, MAJOR .. " requires LibStub")

local lib, oldMinor = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then
	return
end -- No upgrade needed

local TotemItems = {
    [EARTH_TOTEM_SLOT] = 5175,
    [FIRE_TOTEM_SLOT] = 5176,
    [WATER_TOTEM_SLOT] = 5177,
    [AIR_TOTEM_SLOT] = 5178,
}

local TotemSpells = {
    Tremor = {
        element = EARTH_TOTEM_SLOT,
        spellids = { 8143, },
        duration = 120,
    },
    Stoneskin = {
        element = EARTH_TOTEM_SLOT,
        spellids = { 8071, 8154, 8155, 10406, 10407, 10408, },
        duration = 120,
    },
    Stoneclaw = {
        element = EARTH_TOTEM_SLOT,
        spellids = { 5730, 6390, 6391, 6392, 10427, 10428 },
        duration = 15,
    },
    StrengthOfEarth = {
        element = EARTH_TOTEM_SLOT,
        spellids = { 8075, 8160, 8161, 10442, },
        duration = 120,
    },
    EarthBind = {
        element = EARTH_TOTEM_SLOT,
        spellids = { 2484, },
        duration = 45,
    },

    Searing = {
        element = FIRE_TOTEM_SLOT,
        spellids = { 3599, 6363, 6364, 6365, 10437, 10438, },
        duration = 55,
    },
    FireNova = {
        element = FIRE_TOTEM_SLOT,
        spellids = { 1535, 8498, 8499, 11314, 11315 },
        duration = 4,
    },
    Magma = {
        element = FIRE_TOTEM_SLOT,
        spellids = { 8190, 10585, 10586, 10587 },
        duration = 20,
    },
    FrostResistance = {
        element = FIRE_TOTEM_SLOT,
        spellids = { 8181, 10478, 10479, },
        duration = 120,
    },
    Flametongue = {
        element = FIRE_TOTEM_SLOT,
        spellids = { 8227, 8249, 10526, 16387, },
        duration = 120,
    },

    HealingStream = {
        element = WATER_TOTEM_SLOT,
        spellids = { 5394, 6365, 6377, 10462, 10463, },
        duration = 60,
    },
    ManaTide = {
        element = WATER_TOTEM_SLOT,
        spellids = { 16190, 17354, 17359, },
        duration = 12,
    },
    PoisonCleansing = {
        element = WATER_TOTEM_SLOT,
        spellids = { 8166, },
        duration = 120,
    },
    DiseaseCleansing = {
        element = WATER_TOTEM_SLOT,
        spellids = { 8170, },
        duration = 120,
    },
    ManaSpring = {
        element = WATER_TOTEM_SLOT,
        spellids = { 5675, 10495, 10496, 10497, },
        duration = 60,
    },
    FireResistance = {
        element = WATER_TOTEM_SLOT,
        spellids = { 8184, 10537, 10538, },
        duration = 120,
    },

    Grounding = {
        element = AIR_TOTEM_SLOT,
        spellids = { 8177, },
        duration = 45,
    },
    NatureResistance = {
        element = AIR_TOTEM_SLOT,
        spellids = { 10595, 10600, 10601, },
        duration = 120,
    },
    Windfury = {
        element = AIR_TOTEM_SLOT,
        spellids = { 8512, 10613, 10614, },
        duration = 120,
    },
    Sentry = {
        element = AIR_TOTEM_SLOT,
        spellids = { 6495, },
        duration = 600,
    },
    Windwall = {
        element = AIR_TOTEM_SLOT,
        spellids = { 15107, 15111, 15112, },
        duration = 120,
    },
    GraceOfAir = {
        element = AIR_TOTEM_SLOT,
        spellids = { 8835, 10627, },
        duration = 120,
    },
    TranquilAir = {
        element = AIR_TOTEM_SLOT,
        spellids = { 25908, },
        duration = 120,
    },
}

local SpellIDToTotem = {}

for name,val in pairs(TotemSpells) do
    for _, x in pairs(val.spellids) do
        SpellIDToTotem[x] = name
    end
end

local ActiveTotems = {}

function lib.HandleTotemSpell(id)
    local totem = SpellIDToTotem[id]
    if totem then
        ActiveTotems[TotemSpells[totem].element] = {
            spellid = id,
            duration = TotemSpells[totem].duration,
            cast = GetTime(),
            acknowledged = false,
        }
    end
end

function lib.HandleTotemEvent(elem)
    if ActiveTotems[elem] then
        if not ActiveTotems[elem].acknowledged then
            ActiveTotems[elem].acknowledged = true
        else
            ActiveTotems[elem] = nil
        end
    end
end

function lib.UNIT_SPELLCAST_SUCCEEDED(event, unit, castguid, spellid)
    lib.HandleTotemSpell(spellid)
end

function lib.PLAYER_TOTEM_UPDATE(event, elem)
    lib.HandleTotemEvent(elem)
end

lib.EventFrame = CreateFrame('Frame')
lib.EventFrame:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED')
lib.EventFrame:RegisterEvent('PLAYER_TOTEM_UPDATE')

lib.EventFrame:SetScript("OnEvent", function(_, event, ...)
    if type(lib[event]) == 'function' then
        lib[event](event, ...)
    end
end)

-- haveTotem, totemName, startTime, duration, icon = GetTotemInfo(1 through 4).
-- <https://wow.gamepedia.com/API_GetTotemInfo>
function lib.GetTotemInfo(elem)
    local haveTotem, totemName, startTime, duration, icon = false, "", 0, 0, 0
    if (not TotemItems[elem]) then
        return haveTotem, totemName, startTime, duration, icon
    end

    haveTotem = (GetItemCount(TotemItems[elem]) and true or false)
    if haveTotem and ActiveTotems[elem] then
        totemInfo = ActiveTotems[elem]
        startTime = totemInfo.cast
        duration = totemInfo.duration

        totemName, _, icon = GetSpellInfo(totemInfo.spellid)
        totemName = totemName or ""
        icon = icon or 0
    end

    return haveTotem, totemName, startTime, duration, icon
end

-- Exposing GetTotemInfo() to other addons
if type(GetTotemInfo) ~= 'function' then
    GetTotemInfo = lib.GetTotemInfo
end
