local addon_name, addon = ...

-- Everything below this line is a workaround for CLASSIC ONLY.
if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then return end

local TotemItems = {
    EARTH_TOTEM_SLOT = 5175,
    FIRE_TOTEM_SLOT = 5176,
    WATER_TOTEM_SLOT = 5177,
    AIR_TOTEM_SLOT = 5178,
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

function addon:HandleTotemSpell(id)
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

function addon:HandleTotemEvent(elem)
    if ActiveTotems[elem] then
        if not ActiveTotems[elem].acknowledged then
            ActiveTotems[elem].acknowledged = true
        else
            ActiveTotems[elem] = nil
        end
    end
end

function GetTotemInfo(elem)
    return (GetItemCount(TotemItems[elem]) and true or false),
           (ActiveTotems[elem] and GetSpellInfo(ActiveTotems[elem].spellid) or ""),
           (ActiveTotems[elem] and ActiveTotems[elem].cast or 0),
           (ActiveTotems[elem] and ActiveTotems[elem].duration or 0)
end
