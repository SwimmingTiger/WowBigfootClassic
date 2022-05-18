-- Copyright © 2008 - 2012 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.
-- Current distribution permissions only include curse.com, wowinterface.com and their respective addon updaters

if select(2,UnitClass("player")) ~= "SHAMAN" then return end

TotemTimers = {}

TotemTimers.ElementColors = {
    [FIRE_TOTEM_SLOT] = CreateColorFromHexString("FFFF7500"),
    [EARTH_TOTEM_SLOT] = CreateColorFromHexString("FFCBA57B"),
    [WATER_TOTEM_SLOT] = CreateColor(0.4,0.4,1), --CreateColorFromHexString("FF76c7f3"),
    [AIR_TOTEM_SLOT] = CreateColor(1,1,1),
}


TotemTimers.AvailableSpells = {}
TotemTimers.AvailableSpellIDs = {}
TotemTimers.AvailableTalents = {}

TotemTimers.SpellIDs = {

    Tremor = 8143, --
    Stoneskin = 8071, --
    Stoneclaw = 5730, --
    StrengthOfEarth = 8075, --
    EarthBind = 2484, --
    EarthElemental = 2062,

    Searing = 3599, --
    FireNova = 1535, --
    Magma = 8190, --
    FrostResistance = 8181, --
    Flametongue = 8227, --
    FireElemental = 2894,
    Wrath = 30706,
    
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
    WrathOfAir = 3738,
	
    
    Ankh = 20608,
    TotemicCall = 36936,
    LightningShield = 324,
    WaterShield = 24398,
    EarthShield = 974,

    RockbiterWeapon = 8017,
    FlametongueWeapon = 8024,
    FrostbrandWeapon = 8033,
    WindfuryWeapon = 8232,

    EarthShock = 8042,
    FrostShock = 8056,
    FlameShock = 8050,
    StormStrike = 17364,

    LightningBolt = 403,
    ChainLightning = 421,

    --EnamoredWaterSpirit = 24854 -- Water Totem trinket
    --[[
    PrimalStrike = 73899,
    LavaLash = 60103,
    LightningBolt = 403,

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
TotemTimers.NameToSpellID = {}
TotemTimers.TextureToSpellID = {}
TotemTimers.RankedNameToSpellID = {}

local SpellIDs = TotemTimers.SpellIDs
local AvailableSpells = TotemTimers.AvailableSpells
local SpellNames = TotemTimers.SpellNames
local SpellTextures = TotemTimers.SpellTextures
local NameToSpellID = TotemTimers.NameToSpellID
local TextureToSpellID = TotemTimers.TextureToSpellID
local RankedNameToSpellID = TotemTimers.RankedNameToSpellID

local gsub = gsub
function TotemTimers.StripRank(spell)
    local stripped = gsub(spell, "%(.*%)", "")
    return stripped
end


-- populate SpellNames and NameToSpellID with unranked spells first
-- TT inits with that info and upgrades ranks later when ranks are available

for _, spellID in pairs(SpellIDs) do
    local name,_,texture = GetSpellInfo(spellID)
    if name then
        NameToSpellID[name] = spellID
        SpellNames[spellID] = name
        SpellTextures[spellID] = texture
        TextureToSpellID[texture] = spellID
    end
    AvailableSpells[spellID] = IsPlayerSpell(spellID)
end

local WindfuryName = GetSpellInfo(SpellIDs.Windfury)

-- get ranked spell names from spell book
function TotemTimers.GetSpells()
    wipe(AvailableSpells)
    local index = 1
    local windfuryFound = false
    while true do
        local name, rank, rankedSpellID = GetSpellBookItemName(index, BOOKTYPE_SPELL)
        if not name then break end
        local spellID = NameToSpellID[name]
        if spellID then
            AvailableSpells[spellID] = true
            if rank and string.find(rank, "%d") then
                 local rankedName = name.."("..rank..")"
                 NameToSpellID[rankedName] = spellID
                 SpellNames[spellID] = rankedName
                 RankedNameToSpellID[rankedName] = rankedSpellID
                 if not windfuryFound and name == WindfuryName then
                    TotemTimers.WindfuryRank1 = rankedName
                    windfuryFound = true
                 end
            end
        end
        index = index + 1
    end
end
--TotemTimers.GetSpells()

TotemData = {
	[SpellIDs.Tremor] = {
        element = EARTH_TOTEM_SLOT,
        flashInterval = 3,
        warningPoint = 0,
        rangeCheck = 30,
    },
    [SpellIDs.Stoneskin] = {
        element = EARTH_TOTEM_SLOT,
        buff = 8072,
    },
    [SpellIDs.Stoneclaw] = {
        element = EARTH_TOTEM_SLOT,
        warningPoint = 2,
    },
    [SpellIDs.StrengthOfEarth] = {
        element = EARTH_TOTEM_SLOT,
        buff = 8076,
    },
    [SpellIDs.EarthBind] = {
        element = EARTH_TOTEM_SLOT,
        flashInterval = 3,
        flashDelay = 0,
        warningPoint = 5,
    },
    [SpellIDs.EarthElemental] = {
        element = EARTH_TOTEM_SLOT,
    },
	[SpellIDs.Searing] = {
		element = FIRE_TOTEM_SLOT,
        warningPoint = 5,
	},
    [SpellIDs.FireNova] = {
        element = FIRE_TOTEM_SLOT,
    },
	[SpellIDs.Magma] = {
		element = FIRE_TOTEM_SLOT,
	},
    [SpellIDs.FrostResistance] = {
        element = FIRE_TOTEM_SLOT,
        buff = 8182,
    },
    [SpellIDs.Flametongue] = {
        element = FIRE_TOTEM_SLOT,
        --rangeCheck = 20,
    },
    [SpellIDs.FireElemental] = {
        element = FIRE_TOTEM_SLOT,
    },
    [SpellIDs.Wrath] = {
        element = FIRE_TOTEM_SLOT,
        buff = 30708,
    },
    [SpellIDs.HealingStream] = {
		element = WATER_TOTEM_SLOT,
		warningPoint = 4,
        buff = 5672,
	},
    [SpellIDs.ManaTide] = {
        element = WATER_TOTEM_SLOT,
        warningPoint = 2,
        rangeCheck = 20,
    },
    [SpellIDs.PoisonCleansing] = {
        element = WATER_TOTEM_SLOT,
        flashInterval = 5,
        rangeCheck = 20,
    },
    [SpellIDs.DiseaseCleansing] = {
        element = WATER_TOTEM_SLOT,
        flashInterval = 5,
        rangeCheck = 20,
    },
    [SpellIDs.ManaSpring] = {
        element = WATER_TOTEM_SLOT,
        buff = 5677,
    },
    [SpellIDs.FireResistance] = {
        element = WATER_TOTEM_SLOT,
        buff = 8185,
    },
	[SpellIDs.Grounding] = {
		element = AIR_TOTEM_SLOT,
        range = 100,
		warningPoint = 5,
		--flashInterval = 10,
        buff = 8178,
	},
    [SpellIDs.NatureResistance] = {
        element = AIR_TOTEM_SLOT,
        buff = 10596,
    },
    [SpellIDs.Windfury] = {
        element = AIR_TOTEM_SLOT,
        --rangeCheck = 20,
    },
    [SpellIDs.Sentry] = {
        element = AIR_TOTEM_SLOT,
    },
    [SpellIDs.Windwall] = {
        element = AIR_TOTEM_SLOT,
        buff = 15108,
    },
    [SpellIDs.GraceOfAir] = {
        element = AIR_TOTEM_SLOT,
        buff = 8836,
    },
    [SpellIDs.TranquilAir] = {
        element = AIR_TOTEM_SLOT,
        buff = 25909,
    },
    [SpellIDs.WrathOfAir] = {
        element = AIR_TOTEM_SLOT,
        buff = 2895,
    },
}

local TotemCount = {}
for k,v in pairs(TotemData) do
    TotemCount[v.element] = (TotemCount[v.element] or 0) + 1
end
TotemTimers.TotemCount = TotemCount

for k,v in pairs(TotemData) do
    if  v.buff then v.buffName = GetSpellInfo(v.buff) end
end


TotemTimers.WeaponEnchants = {
    [3] = SpellIDs.FlametongueWeapon,
    [4] = SpellIDs.FlametongueWeapon,
    [5] = SpellIDs.FlametongueWeapon,
    [523] = SpellIDs.FlametongueWeapon,
    [1665] = SpellIDs.FlametongueWeapon,
    [1666] = SpellIDs.FlametongueWeapon,
    [2634] = SpellIDs.FlametongueWeapon,
    [3779] = SpellIDs.FlametongueWeapon,
    [3780] = SpellIDs.FlametongueWeapon,
    [3781] = SpellIDs.FlametongueWeapon,
    [1] = SpellIDs.RockbiterWeapon,
    [6] = SpellIDs.RockbiterWeapon,
    [29] = SpellIDs.RockbiterWeapon,
    [503] = SpellIDs.RockbiterWeapon,
    [504] = SpellIDs.RockbiterWeapon,
    [683] = SpellIDs.RockbiterWeapon,
    [1663] = SpellIDs.RockbiterWeapon,
    [1664] = SpellIDs.RockbiterWeapon,
    [2632] = SpellIDs.RockbiterWeapon,
    [2633] = SpellIDs.RockbiterWeapon,
    [3018] = SpellIDs.RockbiterWeapon,
    [283] = SpellIDs.WindfuryWeapon,
    [284] = SpellIDs.WindfuryWeapon,
    [525] = SpellIDs.WindfuryWeapon,
    [1669] = SpellIDs.WindfuryWeapon,
    [2636] = SpellIDs.WindfuryWeapon,
    [3785] = SpellIDs.WindfuryWeapon,
    [3786] = SpellIDs.WindfuryWeapon,
    [3787] = SpellIDs.WindfuryWeapon,
    [2] = SpellIDs.FrostbrandWeapon,
    [12] = SpellIDs.FrostbrandWeapon,
    [5244] = SpellIDs.FrostbrandWeapon,
    [1667] = SpellIDs.FrostbrandWeapon,
    [1668] = SpellIDs.FrostbrandWeapon,
    [2635] = SpellIDs.FrostbrandWeapon,
    [3782] = SpellIDs.FrostbrandWeapon,
    [3783] = SpellIDs.FrostbrandWeapon,
    [3784] = SpellIDs.FrostbrandWeapon,
    [563] = SpellIDs.Windfury,
    [564] = SpellIDs.Windfury,
    [1783] = SpellIDs.Windfury,
    [2638] = SpellIDs.Windfury,
    [2639] = SpellIDs.Windfury,
    [3014] = SpellIDs.Windfury,
    [124] = SpellIDs.Flametongue,
    [285] = SpellIDs.Flametongue,
    [543] = SpellIDs.Flametongue,
    [1683] = SpellIDs.Flametongue,
    [2637] = SpellIDs.Flametongue,
}

for i = 3018, 3044 do TotemTimers.WeaponEnchants[i] = SpellIDs.RockbiterWeapon end

TotemTimers.TotemWeaponEnchants = {
    [563] = SpellIDs.Windfury,
    [564] = SpellIDs.Windfury,
    [1783] = SpellIDs.Windfury,
    [2638] = SpellIDs.Windfury,
    [2639] = SpellIDs.Windfury,
    [3014] = SpellIDs.Windfury,
    [124] = SpellIDs.Flametongue,
    [285] = SpellIDs.Flametongue,
    [543] = SpellIDs.Flametongue,
    [1683] = SpellIDs.Flametongue,
    [2637] = SpellIDs.Flametongue,
}




