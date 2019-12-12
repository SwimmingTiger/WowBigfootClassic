-- Copyright © 2008 - 2012 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.
-- Current distribution permissions only include curse.com, wowinterface.com and their respective addon updaters

if select(2,UnitClass("player")) ~= "SHAMAN" then return end

TotemTimers = {}


TotemTimers.AvailableSpells = {}
TotemTimers.AvailableSpellIDs = {}
TotemTimers.AvailableTalents = {}

TotemTimers.SpellIDs = {

    Tremor = 8143, --
    Stoneskin = 8071, --
    Stoneclaw = 5730, --
    StrengthOfEarth = 8075, --
    EarthBind = 2484, --

    Searing = 3599, --
    FireNova = 1535, --
    Magma = 8190, --
    FrostResistance = 8181, --
    Flametongue = 8227, --
    
    HealingStream = 5394, --
    ManaTide = 16190, --
    PoisonCleansing = 8166, --
    DiseaseCleansing = 8170, --
    ManaSpring = 5675, --
    FireResistance = 8184, --
    
    Grounding = 8177, --
    NatureResistance = 10595, --
    Windfury = 8512, --
    Sentry = 6495, --
    Windwall = 15107, --
    GraceOfAir = 8835, --
    TranquilAir = 25908, --
	
    
    Ankh = 20608,
    LightningShield = 324,

    RockbiterWeapon = 8017,
    FlametongueWeapon = 8024,
    FrostbrandWeapon = 8033,
    WindfuryWeapon = 8232,
    --[[ WaterShield = 52127,
    EarthShield = 974,
    TotemicCall = 36936,
    
    StormStrike = 17364,
    PrimalStrike = 73899,
    EarthShock = 8042,
    FrostShock = 8056,
    FlameShock = 8050,
    LavaLash = 60103,
    LightningBolt = 403,
    ChainLightning = 421,
    LavaBurst = 51505,
    Maelstrom = 51530,
    WindShear = 57994,
    ShamanisticRage = 30823,
    FeralSpirit = 51533,
    ElementalMastery = 16166,
    Thunderstorm = 51490,
    HealingRain = 73920,
    Riptide = 61295,
    UnleashElements = 73680,
	UnleashLife = 73685,
    SpiritwalkersGrace = 79206,
    Ascendance = 114049,
	AscendanceEnhancement = 114051,
	AscendanceElemental = 114050,
	AscendanceRestoration = 114052,
     
    CallOfElements = 108285,
    SpiritWalk = 58875,
    AstralShift = 108271,
    TotemicProjection = 108287,
    AncestralSwiftness = 16188,
    AncestralGuidance = 108281,
    ElementalBlast = 117014,
    
    LiquidMagma = 152255,
    LavaSurge = 77762,
    
    Hex = 51514,
    
    UnleashFlame = 73683,
	UnleashFlameEle = 165462,
    Volcano = 99207,
	
	Bloodlust = 2825,
	Heroism = 32182,
	AstralShift = 108271,
	Stormblast = 115356,
	PurifySpirit = 77130,
	
	ChainHeal = 1064, ]]
	
}

TotemTimers.SpellTextures = {}
TotemTimers.SpellNames = {}

for k,v in pairs(TotemTimers.SpellIDs) do
    local n,_,t = GetSpellInfo(v)
    TotemTimers.SpellTextures[v] = t
    TotemTimers.SpellNames[v] = n
end


--[[
1 - Melee
2 - Ranged
3 - Caster
4 - Healer
5 - Hybrid (mostly Enh. Shaman)
]]


TotemData = {
	[TotemTimers.SpellIDs.Tremor] = {
        element = EARTH_TOTEM_SLOT,
        noRangeCheck = true,
        warningPoint = 2,
		duration = 120,
    },
    [TotemTimers.SpellIDs.Stoneskin] = {
        element = EARTH_TOTEM_SLOT,
        noRangeCheck = true,
		duration = 120,
    },
    [TotemTimers.SpellIDs.Stoneclaw] = {
        element = EARTH_TOTEM_SLOT,
        noRangeCheck = true,
        warningPoint = 2,
		duration = 15,
    },
    [TotemTimers.SpellIDs.StrengthOfEarth] = {
        element = EARTH_TOTEM_SLOT,
        noRangeCheck = true,
		duration = 120,
    },
    [TotemTimers.SpellIDs.EarthBind] = {
        element = EARTH_TOTEM_SLOT,
        noRangeCheck = true,
        flashInterval = 3,
        flashDelay = 1,
        warningPoint = 5,
		duration = 45,
    },
	[TotemTimers.SpellIDs.Searing] = {
		element = FIRE_TOTEM_SLOT,
        noRangeCheck = true,
        warningPoint = 5,
		duration = 55,
	},
    [TotemTimers.SpellIDs.FireNova] = {
        element = FIRE_TOTEM_SLOT,
        noRangeCheck = true,
		duration = 4,
    },
	[TotemTimers.SpellIDs.Magma] = {
		element = FIRE_TOTEM_SLOT,
        noRangeCheck = true,
		duration = 20,
	},
    [TotemTimers.SpellIDs.FrostResistance] = {
        element = FIRE_TOTEM_SLOT,
        noRangeCheck = true,
		duration = 120,
    },
    [TotemTimers.SpellIDs.Flametongue] = {
        element = FIRE_TOTEM_SLOT,
        noRangeCheck = true,
		duration = 120,
    },
    [TotemTimers.SpellIDs.HealingStream] = {
		element = WATER_TOTEM_SLOT,
        range = 1600,
		warningPoint = 4,
		duration = 60,
	},
    [TotemTimers.SpellIDs.ManaTide] = {
        element = WATER_TOTEM_SLOT,
        warningPoint = 2,
		duration = 12,
    },
    [TotemTimers.SpellIDs.PoisonCleansing] = {
        element = WATER_TOTEM_SLOT,
        noRangeCheck = true,
        flashInterval = 5,
		duration = 120,
    },
    [TotemTimers.SpellIDs.DiseaseCleansing] = {
        element = WATER_TOTEM_SLOT,
        noRangeCheck = true,
        flashInterval = 5,
		duration = 120,
    },
    [TotemTimers.SpellIDs.ManaSpring] = {
        element = WATER_TOTEM_SLOT,
        noRangeCheck = true,
		duration = 60,
    },
    [TotemTimers.SpellIDs.FireResistance] = {
        element = WATER_TOTEM_SLOT,
        noRangeCheck = true,
		duration = 120,
    },
	[TotemTimers.SpellIDs.Grounding] = {
		element = AIR_TOTEM_SLOT,
        partyOnly = true,
        range = 100,
		warningPoint = 5,
		duration = 45,
	},
    [TotemTimers.SpellIDs.NatureResistance] = {
        element = AIR_TOTEM_SLOT,
        noRangeCheck = true,
		duration = 120,
    },
    [TotemTimers.SpellIDs.Windfury] = {
        element = AIR_TOTEM_SLOT,
        noRangeCheck = true,
		duration = 120,
    },
    [TotemTimers.SpellIDs.Sentry] = {
        element = AIR_TOTEM_SLOT,
        noRangeCheck = true,
		duration = 600,
    },
    [TotemTimers.SpellIDs.Windwall] = {
        element = AIR_TOTEM_SLOT,
        noRangeCheck = true,
		duration = 120,
    },
    [TotemTimers.SpellIDs.GraceOfAir] = {
        element = AIR_TOTEM_SLOT,
        noRangeCheck = true,
		duration = 120,
    },
    [TotemTimers.SpellIDs.TranquilAir] = {
        element = AIR_TOTEM_SLOT,
        noRangeCheck = true,
		duration = 120,
    },
}

TotemTimers.NameToSpellID = {}
for k,v in pairs(TotemTimers.SpellIDs) do
    if v and TotemTimers.SpellNames[v] then
        TotemTimers.NameToSpellID[TotemTimers.SpellNames[v]] = v 
    end
end

