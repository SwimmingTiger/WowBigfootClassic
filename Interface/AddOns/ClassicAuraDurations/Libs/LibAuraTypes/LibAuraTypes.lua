--[================[
LibAuraTypes-1.0
Author: d87
Description: Provides aura classification and priority
--]================]


local MAJOR, MINOR = "LibAuraTypes", 28
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end

local isMainline = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE

local tocVersion = select(4,GetBuildInfo())
local isBC = tocVersion >= 20000 and tocVersion < 30000

local isClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC and not isBC

local CROWD_CONTROL = "CROWD_CONTROL"
local STUN = "STUN"
local INCAP = "INCAP"
local FROZEN = "FROZEN"
local SILENCE = "SILENCE"
local ROOT = "ROOT"
local SLOW = "SLOW"
local HEAVY_SLOW = "HEAVY_SLOW"
local STEALTH = "STEALTH"
local ANTI_DISPEL = "ANTI_DISPEL"
local ANTI_HEAL = "ANTI_HEAL"
local SPEED_BOOST = "SPEED_BOOST"
local IMMUNITY = "IMMUNITY"
local SPELLSTOLEN = "SPELLSTOLEN"
local DAMAGE_REDUCTION = "DAMAGE_REDUCTION"
local DAMAGE_REDUCTION2 = "DAMAGE_REDUCTION2"
local DAMAGE_ABSORB = "DAMAGE_ABSORB"
local DAMAGE_VULNERABILITY = "DAMAGE_VULNERABILITY"
local DAMAGE_INCREASE = "DAMAGE_INCREASE"
local DAMAGE_INCREASE2 = "DAMAGE_INCREASE2"
local DAMAGE_DECREASE = "DAMAGE_DECREASE"
local TRASH = "TRASH"
local EFFECT_IMMUNITY = "EFFECT_IMMUNITY"
local PHYSICAL_REFLECTION = "PHYSICAL_REFLECTION"
local PHYSICAL_IMMUNITY = "PHYSICAL_IMMUNITY"
local SPELL_REFLECTION = "SPELL_REFLECTION"
local SPELL_IMMUNITY = "SPELL_IMMUNITY"
local INTERRUPT_IMMUNITY = "INTERRUPT_IMMUNITY"
local FEAR_IMMUNITY = "FEAR_IMMUNITY"
local ROOT_IMMUNITY = "ROOT_IMMUNITY"
local CROWD_CONTROL_IMMUNITY = "CROWD_CONTROL_IMMUNITY"
local CROWD_CONTROL_REDUCTION = "CROWD_CONTROL_REDUCTION"
local HEALING_REDUCTION = "HEALING_REDUCTION"
local ATTENTION = "ATTENTION"
local STEALTH_DETECTION = "STEALTH_DETECTION"
local PVE_DAMAGE_REDUCTION = "PVE_DAMAGE_REDUCTION"
local TAUNT = "TAUNT"
local ANTI_STEALTH = "ANTI_STEALTH"

lib.E_SLOW         = 1
lib.E_ROOT         = 2
lib.E_DISORIENT    = 4
lib.E_DISARM       = 8
lib.E_SILENCE      = 16
lib.E_INCAP        = 32
lib.E_FEAR         = 64
lib.E_STUN         = 128
lib.E_ANTIDISPEL   = 256
lib.E_PHASED       = 512
lib.E_BADTHING     = 1024

local E_SLOW         = lib.E_SLOW
local E_ROOT         = lib.E_ROOT
local E_DISORIENT    = lib.E_DISORIENT
local E_DISARM       = lib.E_DISARM
local E_SILENCE      = lib.E_SILENCE
local E_INCAP        = lib.E_INCAP
local E_FEAR         = lib.E_FEAR
local E_STUN         = lib.E_STUN
local E_ANTIDISPEL   = lib.E_ANTIDISPEL
local E_PHASED       = lib.E_PHASED
local E_BADTHING     = lib.E_BADTHING

-- effects.SLOW         = 1
-- effects.ROOT         = 2
-- effects.DISORIENT    = 4
-- effects.DISARM       = 8
-- effects.SILENCE      = 16
-- effects.INCAP        = 32
-- effects.FEAR         = 64
-- effects.STUN         = 128
-- effects.ANTIDISPEL   = 256

lib.friendlyPriority = {
    PVE_DAMAGE_REDUCTION = 0,
    TAUNT = 0,

    ATTENTION = 95,
    IMMUNITY = 90,
    STUN = 85,
    CROWD_CONTROL_IMMUNITY = 60,
    CROWD_CONTROL_REDUCTION = 10,
    ANTI_DISPEL = 10,
    ANTI_HEAL = 10,
    ANTI_STEALTH = 25,
    PHYSICAL_IMMUNITY = 65,
    PHYSICAL_REFLECTION = 65,
    SPELL_IMMUNITY = 65,
    STEALTH = 20,
    CROWD_CONTROL = 70,

    -- Don't care about these on friendly
    INTERRUPT_IMMUNITY = 10,
    FEAR_IMMUNITY = 10,
    EFFECT_IMMUNITY = 31,
    ROOT_IMMUNITY = 25,
    SPELL_REFLECTION = 35,

    SPELLSTOLEN = 50,
    INCAP = 68,
    SILENCE = 65,
    FROZEN = 46,
    ROOT = 45,
    HEAVY_SLOW = 40,

    DAMAGE_REDUCTION = 40,
    DAMAGE_REDUCTION2 = 50,
    DAMAGE_ABSORB = 1,
    DAMAGE_VULNERABILITY = 37,

    DAMAGE_INCREASE = 10,
    DAMAGE_INCREASE2 = 12,
    DAMAGE_DECREASE = 9,

    SLOW = 30,
    SPEED_BOOST = 25,
    HEALING_REDUCTION = 2, -- increased for healers
    STEALTH_DETECTION = 0,
    TRASH = -1,
}
local friendlyPriority = lib.friendlyPriority

lib.enemyPriority = {
    PVE_DAMAGE_REDUCTION = 85,

    ATTENTION = 95,
    SPELL_REFLECTION = 95,
    PHYSICAL_REFLECTION = 90,
    IMMUNITY = 90,
    STUN = 85,
    ANTI_DISPEL = 0, ------------
    ANTI_HEAL = 0,
    ANTI_STEALTH = 0,
    CROWD_CONTROL_IMMUNITY = 80,
    CROWD_CONTROL_REDUCTION = 70,
    PHYSICAL_IMMUNITY = 65,
    SPELL_IMMUNITY = 65,

    CROWD_CONTROL = 70,
    INCAP = 69,
    SILENCE = 67,

    TAUNT = 60,

    INTERRUPT_IMMUNITY = 64,
    FEAR_IMMUNITY = 20,
    EFFECT_IMMUNITY = 50,
    ROOT_IMMUNITY = 50,

    STEALTH_DETECTION = 60,

    DAMAGE_REDUCTION2 = 55,

    FROZEN = 46,
    ROOT = 45,

    DAMAGE_REDUCTION = 55,
    DAMAGE_ABSORB = 38,
    DAMAGE_VULNERABILITY = 37,
    SPELLSTOLEN = 37,

    DAMAGE_INCREASE2 = 80,
    DAMAGE_INCREASE = 35,
    DAMAGE_DECREASE = 34,

    HEAVY_SLOW = 31,
    SLOW = 30,
    STEALTH = 20,
    SPEED_BOOST = 25,
    HEALING_REDUCTION = 1,
    TRASH = -1,
}
local enemyPriority = lib.enemyPriority

local data


local playerClass = select(2, UnitClass('player'))
if playerClass == "ROGUE" then
    -- enemyPriority[STEALTH_DETECTION] = 60
    enemyPriority[PHYSICAL_IMMUNITY] = 90
elseif playerClass == "DEMONHUNTER" then
    enemyPriority[PHYSICAL_IMMUNITY] = 90
    enemyPriority[STEALTH] = 60
elseif playerClass == "DRUID" then
    -- enemyPriority[STEALTH_DETECTION] = 60
    friendlyPriority[HEALING_REDUCTION] = 28
    friendlyPriority[ANTI_DISPEL] = 70
    friendlyPriority[ANTI_HEAL] = 70
elseif playerClass == "PRIEST" then
    enemyPriority[FEAR_IMMUNITY] = 80
    friendlyPriority[HEALING_REDUCTION] = 28
    friendlyPriority[ANTI_DISPEL] = 70
    friendlyPriority[ANTI_HEAL] = 70
elseif playerClass == "SHAMAN" then
    friendlyPriority[HEALING_REDUCTION] = 28
    friendlyPriority[ANTI_DISPEL] = 70
    friendlyPriority[ANTI_HEAL] = 70
elseif playerClass == "PALADIN" then
    friendlyPriority[HEALING_REDUCTION] = 28
    friendlyPriority[ANTI_DISPEL] = 70
    friendlyPriority[ANTI_HEAL] = 70
elseif playerClass == "MONK" then
    friendlyPriority[HEALING_REDUCTION] = 28
    friendlyPriority[ANTI_DISPEL] = 70
    friendlyPriority[ANTI_HEAL] = 70
elseif playerClass == "MAGE" then
    enemyPriority[FROZEN] = 60
elseif playerClass == "WARLOCK" then
    enemyPriority[FEAR_IMMUNITY] = 80
elseif playerClass == "WARRIOR" then
    enemyPriority[SLOW] = 39
    enemyPriority[FEAR_IMMUNITY] = 55
    enemyPriority[PHYSICAL_IMMUNITY] = 90
    enemyPriority[SPELL_REFLECTION] = 60
    enemyPriority[SPELL_IMMUNITY] = 10
end

local function A( id, opts )
    if type(id) == "table" then
        if #id > 2 then
            if type(opts) == "string" then
                local category = opts
                opts = { category }
            end
            opts.originalID = id[1]
        end
        for i, spellID in ipairs(id) do
            data[spellID] = opts
        end
    else
        data[id] = opts
    end
end

-----------------------
-- LIVE
-----------------------
if isMainline then

lib.data = {
    -- [25163] = { ATTENTION }, -- Oozeling's Aura

    [115804] = HEALING_REDUCTION, -- Mortal Wounds
    [8680] = HEALING_REDUCTION, -- Wound Poison
    [197046] = HEALING_REDUCTION, -- Minor Wound Poison

    [348436] = ATTENTION, -- Shadowlands Drink
    [308429] = ATTENTION, -- Shadowlands Drink
    [308433] = ATTENTION, -- Shadowlands Drink
    [327786] = ATTENTION, -- Shadowlands Drink
    [340109] = ATTENTION, -- Shadowlands Drink
    [167152] = ATTENTION, -- Mage food

    [34709] = STEALTH_DETECTION, -- Arena Shadow Sight

    [330749] = DAMAGE_REDUCTION, -- Phial of Serenity (Patience, overtime soulbind trait from pelagos)

    -- [336126] = ATTENTTION, -- PVP trinket (Medallion)
    [345231] = DAMAGE_REDUCTION, -- Gladiator's Emblem (+max hp)

    [320224] = ATTENTION, -- Podtender Night Fae soulbind ability (move in all, not druid specific)
	[327140] = IMMUNITY, -- Forgeborn covenant necrolord (new soulbind necrolord)

    [332505] = CROWD_CONTROL_REDUCTION, -- Soulsteel Clamps still (Mikanikos cc reduction Soulbind Kyrian)
    [332506] = CROWD_CONTROL_REDUCTION, -- Soulsteel Clamps moving (Mikanikos cc reduction Soulbind Kyrian)

    [323524] = CROWD_CONTROL_IMMUNITY, -- Ultimate Form, Anti cc Necrolord

    -- [324631] = DAMAGE_REDUCTION, -- Fleshcraft 30% DR (9.0.5)

    -- DEATH KNIGHT

    [315443] = DAMAGE_INCREASE2, -- Abomination Limb

    [47476] = { SILENCE, effect = E_SILENCE }, -- Strangulate
    [49039] = FEAR_IMMUNITY, -- Lichborne
    [48707] = SPELL_IMMUNITY, -- Anti-Magic Shell
    [145629] = DAMAGE_REDUCTION, -- Anti-Magic Zone
    [48265] = ROOT_IMMUNITY, -- Death's Advance
    [48792] = DAMAGE_REDUCTION2, -- Icebound Fortitude
    [81256] = DAMAGE_REDUCTION, -- Dancing Rune Weapon
    [51271] = DAMAGE_INCREASE, -- Pillar of Frost
    [55233] = DAMAGE_REDUCTION, -- Vampiric Blood
    [77606] = ATTENTION, -- Dark Simulacrum
    [91797] = { STUN, effect = E_STUN }, -- Monstrous Blow
    [91800] = { STUN, effect = E_STUN }, -- Gnaw
    [108194] = { STUN, effect = E_STUN }, -- Asphyxiate
        [221562] = { STUN, effect = E_STUN, originalID = 108194 }, -- Asphyxiate (Blood)
    [152279] = DAMAGE_INCREASE, -- Breath of Sindragosa
    [194679] = DAMAGE_REDUCTION, -- Rune Tap
    [194844] = DAMAGE_REDUCTION, -- Bonestorm
    [206977] = DAMAGE_REDUCTION, -- Blood Mirror
    [207127] = DAMAGE_INCREASE, -- Hungering Rune Weapon
    [207167] = { CROWD_CONTROL, effect = E_DISORIENT }, -- Blinding Sleet
    [317898] = { CROWD_CONTROL, effect = E_SLOW }, -- Blinding Sleet Slow 50% 6s
    [207256] = DAMAGE_INCREASE, -- Obliteration
    [207289] = DAMAGE_INCREASE, -- Unholy Frenzy
    [212332] = { CROWD_CONTROL, effect = E_STUN }, -- Smash
        [212337] = { CROWD_CONTROL, effect = E_STUN, originalID = 212332 }, -- Powerful Smash
    [212552] = DAMAGE_REDUCTION, -- Wraith Walk
    [219809] = DAMAGE_REDUCTION, -- Tombstone
    [223929] = HEALING_REDUCTION, -- Necrotic Wound
    [204085] = { FROZEN, effect = E_ROOT }, -- Deathchill, pvp talent 4s root on chains
    [204206] = { HEAVY_SLOW, effect = E_SLOW }, -- Chill Streak, 70% mov red
    [288849] = ANTI_HEAL, -- Crypt Fever, Unholy pvp talent 8% over 4s, refreshed on heal
    [45524] = { HEAVY_SLOW, effect = E_SLOW }, -- Chains of Ice, 70% slow
    [287254] = { STUN, effect = E_STUN }, -- Dead of Winter pvp Talent
    [334693] = { STUN, effect = E_STUN }, -- Absolute Zero legendary
    [207171] = { ROOT, effect = E_ROOT }, -- Winter is Coming

    -- Demon Hunter

    [209426] = DAMAGE_REDUCTION2, -- DARKNESS
    [179057] = { CROWD_CONTROL, effect = E_STUN }, -- Chaos Nova
    [162264] = DAMAGE_INCREASE2, -- Metamorphosis (Havoc)
    [187827] = DAMAGE_REDUCTION2, -- Metamorphosis (Vengeance)
    [188501] = STEALTH_DETECTION, -- Spectral Sight
    [204490] = { SILENCE, effect = E_SILENCE }, -- Sigil of Silence
    [205629] = DAMAGE_REDUCTION, -- Demonic Trample
    [205630] = { STUN, effect = E_STUN }, -- Illidan's Grasp 6s stun
    [206649] = ATTENTION, -- Eye of Leotheras
    [207685] = { CROWD_CONTROL, effect = E_DISORIENT }, -- Sigil of Misery
    [207810] = DAMAGE_REDUCTION, -- Nether Bond
    [211048] = DAMAGE_INCREASE, -- Chaos Blades
    [211881] = { STUN, effect = E_STUN }, -- Fel Eruption 4s stun
    [212800] = DAMAGE_REDUCTION, -- Blur
    [196555] = IMMUNITY, -- Netherwalk
    [218256] = DAMAGE_REDUCTION, -- Empower Wards
    [217832] = { CROWD_CONTROL, effect = E_INCAP }, -- Imprison Magic 4s incap
    [221527] = { CROWD_CONTROL, effect = E_INCAP }, -- the id for PvP talent
	[323996] = { ROOT, effect = E_ROOT }, -- Hunt root
    [227225] = DAMAGE_REDUCTION, -- Soul Barrier
    [206803] = DAMAGE_REDUCTION, -- Rain from Above, initial jump
    [206804] = DAMAGE_REDUCTION, -- Rain from Above, slow fall

    -- DRUID

    [99] = { CROWD_CONTROL, effect = E_INCAP }, -- Incapacitating Roar 3s
    [339] = { ROOT, effect = E_ROOT }, -- Entangling Roots
    [740] = DAMAGE_REDUCTION, -- Tranquility
    [1850] = SPEED_BOOST, -- Dash
        [252216] = { SPEED_BOOST, originalID = 1850 }, -- Tiger Dash
    [2637] = CROWD_CONTROL, -- Hibernate
    [5211] = { STUN, effect = E_STUN }, -- Mighty Bash 5s
    [5217] = DAMAGE_INCREASE, -- Tiger's Fury
    [22812] = DAMAGE_REDUCTION, -- Barkskin
    [22842] = DAMAGE_REDUCTION, -- Frenzied Regeneration
    -- [29166] = DAMAGE_INCREASE, -- Innervate
    [33891] = DAMAGE_INCREASE, -- Incarnation: Tree of Life
    [45334] = { ROOT, effect = E_ROOT }, -- Wild Charge
    [61336] = DAMAGE_REDUCTION2, -- Survival Instincts
    [81261] = { SILENCE, effect = E_SILENCE }, -- Solar Beam
    [102342] = DAMAGE_REDUCTION, -- Ironbark
    [102359] = { ROOT, effect = E_ROOT }, -- Mass Entanglement
    [279642] = DAMAGE_INCREASE, -- Lively Spirit
    [102543] = DAMAGE_INCREASE, -- Incarnation: King of the Jungle

    [50334] = CROWD_CONTROL_IMMUNITY, -- Guardian Berserk (for Legacy of the Sleeper legendary)
    [102558] = CROWD_CONTROL_IMMUNITY, -- Guardian Incarnation (replaces Berserk)
    -- [102558] = DAMAGE_INCREASE, -- Incarnation: Guardian of Ursoc

    [102560] = DAMAGE_INCREASE, -- Incarnation: Chosen of Elune
    [106951] = DAMAGE_INCREASE, -- Berserk
    [155835] = DAMAGE_REDUCTION, -- Bristling Fur
    [192081] = DAMAGE_REDUCTION, -- Ironfur
    [163505] = { STUN, effect = E_STUN }, -- Rake
    [194223] = DAMAGE_INCREASE2, -- Celestial Alignment
    [200851] = DAMAGE_REDUCTION, -- Rage of the Sleeper
    [202425] = DAMAGE_INCREASE, -- Warrior of Elune

    [209749] = DAMAGE_DECREASE, -- Faerie Swarm (Slow/Disarm)
    [33786] = { CROWD_CONTROL, effect = E_PHASED }, -- Cyclone
    [22570] = { STUN, effect = E_STUN }, -- Maim
    [305497] = PHYSICAL_REFLECTION, -- Thorns (PvP Talent)
    [323764] = DAMAGE_INCREASE2, -- Convoke Spirits
    [337433] = DAMAGE_INCREASE2, -- Convoke Spirits other id
    [320224] = ATTENTION, -- Podtender Night Fae soulbind ability
    -- [234084] = INTERRUPT_IMMUNITY, Moon and Stars, pvp  70% interrupt reduction


    -- Hunter

    [195645] = { SLOW, effect = E_SLOW }, -- Wing Clip 50% slow
    [135299] = { SLOW, effect = E_SLOW }, -- Tar trap 50%
    [136] = DAMAGE_REDUCTION, -- Mend Pet
    [3355] = { CROWD_CONTROL, effect = E_INCAP }, -- Freezing Trap
        [203337] = { CROWD_CONTROL, effect = E_PHASED }, -- Diamond Ice, Survival pvp talent 5s cyclone type
    [5384] = DAMAGE_REDUCTION, -- Feign Death
    [19386] = CROWD_CONTROL, -- Wyvern Sting
    [19574] = DAMAGE_INCREASE, -- Bestial Wrath
    [19577] = { CROWD_CONTROL, effect = E_STUN }, -- Intimidation
        [24394] = { CROWD_CONTROL, effect = E_STUN, originalID = 19577 }, -- Intimidation
    [53480] = DAMAGE_REDUCTION, -- Roar of Sacrifice (Hunter Pet Skill)
    [117526] = { ROOT, effect = E_ROOT }, -- Binding Shot actual root
    -- [117405] = { ROOT, effect = E_ROOT }, -- Binding Shot (armed)
    [321469] = DAMAGE_DECREASE, -- Binding Shot, deal 20% less damage to you for 8 sec after the root effect ends
    [131894] = DAMAGE_INCREASE, -- A Murder of Crows (Beast Mastery, Marksmanship)
        [206505] = { DAMAGE_INCREASE, originalID = 131894 }, -- A Murder of Crows (Survival)
    [186265] = DAMAGE_REDUCTION, -- Aspect of the Turtle
    [186289] = DAMAGE_INCREASE, -- Aspect of the Eagle
    [266779] = DAMAGE_INCREASE2, -- Coordinated Assault, Surv damage cd
    [186387] = { SLOW, effect = E_SLOW }, -- Bursting Shot
    [288613] = DAMAGE_INCREASE2, -- Trueshot
    [193530] = DAMAGE_INCREASE, -- Aspect of the Wild
    [199483] = STEALTH, -- Camouflage
    [202914] = SILENCE, -- Spider Sting (Armed)
        [233022] = { SILENCE, effect = E_SILENCE, 202914 }, -- Spider Sting (Silenced)
    [209997] = DAMAGE_REDUCTION, -- Play Dead
    [213691] = { CROWD_CONTROL, effect = E_DISORIENT }, -- Scatter Shot 4s disorient
    [54216] = ROOT_IMMUNITY, -- Master's Call root immune
    [272682] = DAMAGE_REDUCTION, -- Master's Call
    [202900] = DAMAGE_DECREASE, -- Scorpid Sting
    [212638] = { ROOT, effect = E_ROOT }, -- Tracker's Net 6s root

    -- Mage / ok, no slow
    [317589] = { CROWD_CONTROL, effect = E_SILENCE }, -- Tormenting Backlash Venthyr Mage root+silence

    [157981] = { SLOW, effect = E_SLOW }, -- Blast Wave 70% slow
    [205708] = { SLOW, effect = E_SLOW }, -- Chilled 50% frostbolt slow
    [212792] = { HEAVY_SLOW, effect = E_SLOW }, -- Cone of Cold 70% slow
    [289308] = { SLOW, effect = E_SLOW }, -- Ice orb 30% slow, 3s repeating
    [12486] = { SLOW, effect = E_SLOW }, -- Blizzard 50% slow
    [321329] = { HEAVY_SLOW, effect = E_SLOW }, -- Post Ring of Frost 65% slow
    [31589] = { HEAVY_SLOW, effect = E_SLOW }, -- Arcabe Slow 60% 15s
    [108843] = ROOT_IMMUNITY, -- Blazing Speed from Cauterize +150% speed
    -- [228354] = { SLOW, effect = E_SLOW }, -- Flyrry 70% slow, but 1s duration
    [66] = DAMAGE_INCREASE, -- Invisibility
        [110959] = { DAMAGE_INCREASE, originalID = 66 }, -- Greater Invisibility

    -- Polymorph is at the end of the list

    [122] = { ROOT, effect = E_ROOT }, -- Frost Nova
    [33395] = { ROOT, effect = E_ROOT }, -- Freeze
    [11426] = DAMAGE_REDUCTION, -- Ice Barrier
    [12042] = DAMAGE_INCREASE, -- Arcane Power
    [12051] = DAMAGE_INCREASE, -- Evocation
    [12472] = DAMAGE_INCREASE2, -- Icy Veins
        [198144] = { DAMAGE_INCREASE2, originalID = 12472 }, -- Ice Form, Stun Immune
    [31661] = { CROWD_CONTROL, effect = E_DISORIENT }, -- Dragon's Breath
    [45438] = IMMUNITY, -- Ice Block
        [41425] = TRASH, -- Hypothermia
    [110909] = DAMAGE_REDUCTION, -- Alter Time Fire/Frost
    [342246] = DAMAGE_REDUCTION, -- Alter Time Arcane
    [80353] = DAMAGE_INCREASE, -- Time Warp
    [82691] = { CROWD_CONTROL, effect = E_INCAP }, -- Ring of Frost
    [108839] = DAMAGE_INCREASE, -- Ice Floes
    [157997] = { ROOT, effect = E_ROOT }, -- Ice Nova
    [190319] = DAMAGE_INCREASE2, -- Combustion
    [269651] = DAMAGE_INCREASE2, -- Pyroclasm
    [198111] = DAMAGE_REDUCTION, -- Temporal Shield
    [198158] = STEALTH, -- Mass Invisibility
    [198064] = DAMAGE_REDUCTION, -- Prismatic Cloak
        [198065] = { DAMAGE_REDUCTION, originalID = 198064 }, -- Prismatic Cloak
    [205025] = DAMAGE_INCREASE, -- Presence of Mind
    [228600] = { ROOT, effect = E_ROOT }, -- Glacial Spike Root
    [198121] = { FROZEN, effect = E_ROOT }, -- Frostbite

    -- Monk

    [310454] = DAMAGE_INCREASE, -- Weapons of order
    [152173] = DAMAGE_INCREASE2, -- Serenity

    [115078] = { CROWD_CONTROL, effect = E_INCAP }, -- Paralysis
    [115080] = DAMAGE_VULNERABILITY, -- Touch of Death
    [120954] = DAMAGE_REDUCTION, -- Fortifying Brew (Brewmaster)
        [201318] = { DAMAGE_REDUCTION, originalID = 120954 }, -- Fortifying Brew (Windwalker PvP Talent)
        [243435] = { DAMAGE_REDUCTION, originalID = 120954 }, -- Fortifying Brew (Mistweaver)
    [201787] = SLOW, -- Heavy-Handed Strikes (PVP talent) slow from fists of fury
    [116095] = { SLOW, effect = E_SLOW }, -- Disable Slow
    [116706] = { ROOT, effect = E_ROOT }, -- Disable Root
    [116849] = DAMAGE_REDUCTION, -- Life Cocoon
    [119381] = { STUN, effect = E_STUN }, -- Leg Sweep
    [122278] = DAMAGE_REDUCTION, -- Dampen Harm
    [125174] = IMMUNITY, -- Touch of Karma
    [122783] = DAMAGE_REDUCTION2, -- Diffuse Magic
    [137639] = DAMAGE_INCREASE2, -- Storm, Earth, and Fire
    [198909] = CROWD_CONTROL, -- Song of Chi-Ji
    [115176] = DAMAGE_REDUCTION, -- Zen Meditation
    [216113] = DAMAGE_INCREASE, -- Way of the Crane
    [233759] = { CROWD_CONTROL, effect = E_DISARM }, -- Grapple Weapon
    [209584] = INTERRUPT_IMMUNITY, -- Zen Focus Tea

    -- Paladin

    [498] = DAMAGE_REDUCTION, -- Divine Protection
    [642] = IMMUNITY, -- Divine Shield
    [853] = { CROWD_CONTROL, effect = E_STUN }, -- Hammer of Justice
    [1022] = PHYSICAL_IMMUNITY, -- Blessing of Protection
        [204018] = SPELL_IMMUNITY, -- Blessing of Spellwarding
    [1044] = ROOT_IMMUNITY, -- Blessing of Freedom
    [6940] = DAMAGE_REDUCTION, -- Blessing of Sacrifice
        [199448] = { DAMAGE_REDUCTION, originalID = 6940 }, -- Blessing of Sacrifice (Ultimate Sacrifice Honor Talent)
    [20066] = { CROWD_CONTROL, effect = E_INCAP }, -- Repentance
    [31821] = DAMAGE_REDUCTION, -- Aura Mastery
    [31850] = DAMAGE_REDUCTION, -- Ardent Defender
    [31884] = DAMAGE_INCREASE2, -- Avenging Wrath (Protection/Retribution)
        [216331] = { DAMAGE_INCREASE2, originalID = 31884 }, -- Avenging Crusader (Holy Talent)
        [231895] = { DAMAGE_INCREASE2, originalID = 31884 }, -- Crusade (Retribution Talent)
    [31935] = { CROWD_CONTROL, effect = E_SILENCE }, -- Avenger's Shield
    [86659] = DAMAGE_REDUCTION, -- Guardian of Ancient Kings
        [212641] = DAMAGE_REDUCTION, -- Guardian of Ancient Kings (Glyphed)
        [228049] = DAMAGE_REDUCTION, -- Guardian of the Forgotten Queen
    [105809] = DAMAGE_INCREASE, -- Holy Avenger
    [105421] = { CROWD_CONTROL, effect = E_DISORIENT }, -- Blinding Light
    [152262] = DAMAGE_INCREASE, -- Seraphim
    [184662] = DAMAGE_REDUCTION, -- Shield of Vengeance
    [204150] = DAMAGE_REDUCTION, -- Aegis of Light
    [205191] = DAMAGE_REDUCTION, -- Eye for an Eye
    [210256] = DAMAGE_REDUCTION, -- Blessing of Sanctuary
    [215652] = DAMAGE_INCREASE, -- Shield of Virtue
    [210294] = INTERRUPT_IMMUNITY, -- Divine Favor
    [183218] = { HEAVY_SLOW, effect = E_SLOW }, -- Hand of Hindrance 70% slow
    [199545] = ROOT_IMMUNITY, -- Protection paladin steed cc immunity

    -- Priest / unchecked, no slow

    [323673] = ANTI_HEAL, -- Mindgames (Venthyr), The next 450 damage and 450 healing dealt will be reversed.
    [325013] = DAMAGE_INCREASE, --  Boon of the Ascended

    [34914] = { ANTI_DISPEL, effect = E_ANTIDISPEL }, -- Vampiric Touch
    [586] = DAMAGE_REDUCTION, -- Fade
        [213602] = DAMAGE_REDUCTION2, -- Greater Fade
    [605] = { CROWD_CONTROL, effect = E_INCAP }, -- Mind Control
    [8122] = { CROWD_CONTROL, effect = E_FEAR }, -- Psychic Scream
    [9484] = { CROWD_CONTROL, effect = E_INCAP }, -- Shackle Undead
    [10060] = DAMAGE_INCREASE, -- Power Infusion
    [15487] = { SILENCE, effect = E_SILENCE }, -- Silence
    [33206] = DAMAGE_REDUCTION, -- Pain Suppression
    [47536] = DAMAGE_REDUCTION, -- Rapture
    [47585] = DAMAGE_REDUCTION2, -- Dispersion
    [47788] = DAMAGE_REDUCTION, -- Guardian Spirit
    [64044] = { STUN, effect = E_STUN }, -- Psychic Horror
    [64843] = DAMAGE_REDUCTION, -- Divine Hymn
    [81782] = DAMAGE_REDUCTION, -- Power Word: Barrier
    [87204] = { CROWD_CONTROL, effect = E_FEAR }, -- Sin and Punishment (for VT dispel)
    [319952] = DAMAGE_INCREASE, -- Surrender to Madness
    [194249] = DAMAGE_INCREASE2, -- Voidform
    [196762] = DAMAGE_REDUCTION, -- Inner Focus
    [197268] = DAMAGE_REDUCTION, -- Ray of Hope
    [197862] = DAMAGE_REDUCTION, -- Archangel
    [197871] = DAMAGE_INCREASE, -- Dark Archangel
    [200183] = DAMAGE_REDUCTION, -- Apotheosis
    [200196] = { INCAP, effect = E_INCAP }, -- Holy Word: Chastise
        [200200] = { STUN, effect = E_STUN, originalID = 200196 }, -- Holy Word: Censure (Stun)
    [205369] = { CROWD_CONTROL, effect = E_DISORIENT }, -- Mind Bomb
        [226943] = { CROWD_CONTROL, effect = E_DISORIENT, originalID = 205369 }, -- Mind Bomb (Disorient)
    [213610] = CROWD_CONTROL_IMMUNITY, -- Holy Ward
    [215769] = IMMUNITY, -- Spirit of Redemption
    [221660] = IMMUNITY, -- Holy Concentration
    [323716] = SPELLSTOLEN, -- Thoughtsteal (PVP talent)
    [328530] = DAMAGE_REDUCTION, -- Divine Ascension, rise
    [329543] = DAMAGE_REDUCTION, -- Divine Ascension, fall
    [199845] = HEALING_REDUCTION, -- Psyflay from Psyfiend, 9.0 Priest pvp talent


    -- Rogue / good

    [408] = { STUN, effect = E_STUN }, -- Kidney Shot
    [1330] = { SILENCE, effect = E_SILENCE }, -- Garrote - Silence
    [1776] = { INCAP, effect = E_INCAP }, -- Gouge
    [1833] = { STUN, effect = E_STUN }, -- Cheap Shot
    [1966] = DAMAGE_REDUCTION, -- Feint
    [2094] = { CROWD_CONTROL, effect = E_DISORIENT }, -- Blind
    [5277] = PHYSICAL_IMMUNITY, -- Evasion
    [6770] = { INCAP, effect = E_INCAP }, -- Sap
    [13750] = DAMAGE_INCREASE, -- Adrenaline Rush
    [31224] = SPELL_IMMUNITY, -- Cloak of Shadows
    [51690] = DAMAGE_INCREASE, -- Killing Spree
    [79140] = DAMAGE_INCREASE, -- Vendetta
    [121471] = DAMAGE_INCREASE2, -- Shadow Blades
    [199754] = PHYSICAL_IMMUNITY, -- Riposte
    [207736] = ANTI_HEAL, -- Shadowy Duel
    [185422] = DAMAGE_INCREASE, -- Shadow Dance
    [212183] = { ANTI_HEAL, effect = E_PHASED }, -- Smoke Bomb
    [3409] = { SLOW, effect = E_SLOW }, -- Crippling Poison 50%
    [185763] = { SLOW, effect = E_SLOW }, -- Pistol Shot 30%
    [206760] = SLOW, -- Shadow's Grasp 30%
    -- [277953] = SLOW, -- Night Terrors
    [199027] = PHYSICAL_IMMUNITY, -- Veil of Midnight (100% dodge)
    [207777] = { DAMAGE_DECREASE, effect = E_DISARM }, -- Dismantle
    [11327] = STEALTH, -- Vanish
    [207736] = { ANTI_HEAL, effect = E_PHASED }, -- Shadowy Duel

    -- Shaman

    [196840] = { SLOW, effect = E_SLOW }, -- Frost Shock
    [3600] = { SLOW, effect = E_SLOW }, -- Earthbind totem effect
    [51490] = { SLOW, effect = E_SLOW }, -- Thunderstorm slow 40%
    [2825] = DAMAGE_INCREASE2, -- Bloodlust
        [32182] = { DAMAGE_INCREASE2, originalID = 2825 }, -- Heroism

    [204361] = DAMAGE_INCREASE2, -- Bloodlust 1m cd pvp talent
        [204362] = { DAMAGE_INCREASE2, originalID = 2825 }, -- Heroism

    [51514] = { CROWD_CONTROL, effect = E_INCAP }, -- Hex
        [196932] = { CROWD_CONTROL, effect = E_INCAP, originalID = 51514 }, -- Voodoo Totem
        [210873] = { CROWD_CONTROL, effect = E_INCAP, originalID = 51514 }, -- Hex (Compy)
        [211004] = { CROWD_CONTROL, effect = E_INCAP, originalID = 51514 }, -- Hex (Spider)
        [211010] = { CROWD_CONTROL, effect = E_INCAP, originalID = 51514 }, -- Hex (Snake)
        [211015] = { CROWD_CONTROL, effect = E_INCAP, originalID = 51514 }, -- Hex (Cockroach)
        [269352] = { CROWD_CONTROL, effect = E_INCAP, originalID = 51514 }, -- Hex (Skeletal Hatchling)
        [277778] = { CROWD_CONTROL, effect = E_INCAP, originalID = 51514 }, -- Hex (Zandalari Tendonripper)
        [277784] = { CROWD_CONTROL, effect = E_INCAP, originalID = 51514 }, -- Hex (Wicker Mongrel)
    [79206] = DAMAGE_REDUCTION, -- Spiritwalker's Grace 60 * OTHER
    [108281] = DAMAGE_REDUCTION, -- Ancestral Guidance
    [16166] = DAMAGE_INCREASE, -- Elemental Mastery
    [64695] = { ROOT, effect = E_ROOT }, -- Earthgrab Totem
    [77505] = { CROWD_CONTROL, effect = E_STUN }, -- Earthquake (Stun/Knockdown)
    [98008] = DAMAGE_REDUCTION, -- Spirit Link Totem
    [325174] = DAMAGE_REDUCTION, -- Spirit Link other id
    [108271] = DAMAGE_REDUCTION, -- Astral Shift
        [210918] = { PHYSICAL_IMMUNITY, originalID = 108271 }, -- Ethereal Form
    [114050] = DAMAGE_INCREASE2, -- Ascendance (Elemental)
    [114051] = DAMAGE_INCREASE2, -- Ascendance (Enhancement)
    [114052] = DAMAGE_REDUCTION2, -- Ascendance (Restoration)
    [118345] = { CROWD_CONTROL, effect = E_STUN }, -- Pulverize (Earth Elemental stun)
    [118905] = { CROWD_CONTROL, effect = E_STUN }, -- Static Charge
    [197214] = { CROWD_CONTROL, effect = E_INCAP }, -- Sundering
    [204293] = DAMAGE_REDUCTION, -- Spirit Link
    [58875] = SPEED_BOOST, -- Spiritwalk
    [204366] = DAMAGE_INCREASE, -- Thundercharge
    [204945] = DAMAGE_INCREASE, -- Doom Winds
    [260878] = DAMAGE_REDUCTION, -- Spirit Wolf
    [8178] = SPELL_IMMUNITY, -- Grounding
        [255016] = { SPELL_IMMUNITY, originalID = 8178 }, -- Grounding
        [204336] = { SPELL_IMMUNITY, originalID = 8178 }, -- Grounding
        [34079] = { SPELL_IMMUNITY, originalID = 8178 }, -- Grounding
    [204399] = { STUN, effect = E_STUN }, -- Earthfury
    [204437] = { STUN, effect = E_STUN }, -- Lightning Lasso

    [290641] = INTERRUPT_IMMUNITY, -- Ancestral Gift
    [191634] = DAMAGE_INCREASE2, -- Stormkeeper
    [320125] = DAMAGE_INCREASE2, -- Echoing Shock

    -- Warlock

    [334275] = { SLOW, effect = E_SLOW }, -- CoEX
    [1714] = DAMAGE_DECREASE, -- Curse of Tongues
    [710] = { CROWD_CONTROL, effect = E_INCAP }, -- Banish
    [5484] = { CROWD_CONTROL, effect = E_FEAR }, -- Howl of Terror
    [6358] = { CROWD_CONTROL, effect = E_DISORIENT }, -- Seduction
        [115268] = { CROWD_CONTROL, effect = E_DISORIENT, originalID = 6358 }, -- Mesmerize
    [6789] = { CROWD_CONTROL, effect = E_INCAP }, -- Mortal Coil
    -- [20707] = DAMAGE_REDUCTION, -- Soulstone
    -- [22703] = CROWD_CONTROL, -- Infernal Awakening (infernal summon)
    [30283] = { STUN, effect = E_STUN }, -- Shadowfury
    [89751] = DAMAGE_INCREASE, -- Felstorm
        [115831] = { DAMAGE_INCREASE, originalID = 89751 }, -- Wrathstorm
    [89766] = { STUN, effect = E_STUN }, -- Axe Toss
    [104773] = IMMUNITY, -- Unending Resolve
    [108416] = DAMAGE_REDUCTION, -- Dark Pact
    [113860] = DAMAGE_INCREASE, -- Dark Soul: Misery (Affliction)
    [113858] = DAMAGE_INCREASE, -- Dark Soul: Instability (Demonology)
    [118699] = { CROWD_CONTROL, effect = E_FEAR }, -- Fear
    [171017] = { CROWD_CONTROL, effect = E_FEAR }, -- Meteor Strike, Infernal Ability 2s stun
    [196098] = DAMAGE_INCREASE, -- Soul Harvest
    [196364] = { SILENCE, effect = E_SILENCE }, -- Unstable Affliction (Silence)
    [316099] = { ANTI_DISPEL, effect = E_ANTIDISPEL }, -- Unstable Affliction applications
    [342938] = { ANTI_DISPEL, effect = E_ANTIDISPEL }, -- Unstable Affliction with Rampant Afflictions
    [212284] = DAMAGE_INCREASE, -- Firestone
    [212295] = SPELL_REFLECTION, -- Nether Ward
    [221705] = INTERRUPT_IMMUNITY, -- Casting Circle, immune to interrupt and silence
    [200587] = HEALING_REDUCTION, -- Fel Fissue, 25% Healing reduction from CB

    -- Warrior

    -- [324143] = ROOT_IMMUNITY, -- Conqueror's Banner 9.0.5, Warrior Necrolord ability can't slow below 100%

    [871] = DAMAGE_REDUCTION, -- Shield Wall
    [1719] = DAMAGE_INCREASE, -- Recklessness
    [5246] = { CROWD_CONTROL, effect = E_FEAR }, -- Intimidating Shout
    [12975] = DAMAGE_REDUCTION, -- Last Stand
    [18499] = FEAR_IMMUNITY, -- Berserker Rage
    [23920] = SPELL_REFLECTION, -- Spell Reflection
    [46968] = { STUN, effect = E_STUN }, -- Shockwave
    [97462] = DAMAGE_REDUCTION, -- Rallying Cry
    [105771] = ROOT, -- Charge (Warrior)
    [236273] = DAMAGE_DECREASE, -- Duel pvp talent
    [107574] = DAMAGE_INCREASE, -- Avatar
    [118038] = DAMAGE_REDUCTION, -- Die by the Sword
    [132169] = { STUN, effect = E_STUN }, -- Storm Bolt
    -- [184364] = DAMAGE_REDUCTION, -- Enraged Regeneration
    [197690] = DAMAGE_REDUCTION, -- Defensive Stance
    [147833] = DAMAGE_REDUCTION2, -- Intervene
    [330279] = SPELL_REFLECTION, -- Overwatch pvp talent, spell reflect on intervene
    [213871] = DAMAGE_REDUCTION, -- Bodyguard
    [227847] = IMMUNITY, -- Bladestorm (Arms)
        [46924] = { IMMUNITY, originalID = 227847 }, -- Bladestorm (Fury)
        -- [152277] = IMMUNITYoriginalID = 227847 }, -- Ravager
    [228920] = DAMAGE_REDUCTION, -- Ravager
    [236077] = { CROWD_CONTROL, effect = E_DISARM }, -- Disarm
    [1715] = { SLOW, effect = E_SLOW }, -- Hamstring
    [236321] = EFFECT_IMMUNITY, -- War Banner, 50% CC reduction
    [167105] = DAMAGE_VULNERABILITY, -- Colossus Smash

    -- Mythic+ Shadowlands

    [333737] = PVE_DAMAGE_REDUCTION, -- Congealed Contagion, Ickus, Plaguefall
    [343502] = PVE_DAMAGE_REDUCTION, -- Inspiring Affix Buff
}
data = lib.data

A({ 118, 28271, 28272, 61025, 61305, 61721, 61780, 126819, 161353, 161354, 161355, 161372, 277787, 277792 }, { CROWD_CONTROL, effect = E_INCAP }) -- Polymorph




-----------------------
-- CLASSIC
-----------------------

elseif isClassic then


lib.data = {}
data = lib.data

--MISC
A( 23451 , SPEED_BOOST) -- Battleground Speed buff
A( 23493 , DAMAGE_REDUCTION) -- Battleground Heal buff
A( 23505 , DAMAGE_INCREASE) -- Battleground Damage buff
A( 6615 , CROWD_CONTROL_IMMUNITY) -- Free Action Potion
A( 24364 , CROWD_CONTROL_IMMUNITY) -- Living Action Potion
A( 3169 , IMMUNITY) -- Limited Invulnerability Potion
A( 16621 , IMMUNITY) -- Invulnerable Mail
A( 1090 , CROWD_CONTROL) -- Magic Dust
A( 13327 , INCAP) -- Reckless Charge
A({ 26740, 13181 }, CROWD_CONTROL) -- Mind Control Cap + Backfire
A( 835 , STUN) -- Tidal Charm
A( 11359 , EFFECT_IMMUNITY) -- Restorative Potion, Removes 1 magic, curse, poison or disease effect on you every 5 seconds for 30 seconds.
A( 6727 , EFFECT_IMMUNITY) -- Violet Tragan -- probably wrong id
A( 5024 , EFFECT_IMMUNITY) -- Skull of Impending Doom
A( 2379 , SPEED_BOOST) -- Swiftness Potion
A({ 13099, 13138, 16566 },  CROWD_CONTROL) -- Net-o-matic + Backfire
A( 5134 , CROWD_CONTROL) -- Flash Bomb
A( 23097 , SPELL_REFLECTION) -- Fire Reflector
A( 23131 , SPELL_REFLECTION) -- Frost Reflector
A( 23132 , SPELL_REFLECTION) -- Shadow Reflector
A( 19769 , INCAP) -- Thorium Grenade
A( 4068 , INCAP) -- Iron Grenade
A( 1604 , SLOW) -- Common Daze
A({ 23333, 23335 },  ATTENTION) -- Warsong Flag
A({ 25750, 25747, 25746, 23991 },  DAMAGE_ABSORB) -- AB Trinkets
A( 23506 , DAMAGE_ABSORB) -- Arena Grand Master trinket
A( 29506 , DAMAGE_ABSORB) -- Burrower's Shell trinket
A( 12733 , FEAR_IMMUNITY) -- Blacksmith trinket, Fear immunity
A( 15753 , STUN) -- Linken's Boomerang stun
A( 15752 , DAMAGE_DECREASE) -- Linken's Boomerang disarm
A( 14530 , SPEED_BOOST) -- Nifty Stopwatch
A( 13237 , STUN) -- Goblin Mortar trinket
A( 14253 , EFFECT_IMMUNITY) -- Black Husk Shield, Periodic Poison dispel
A( 9175 , SPEED_BOOST) -- Swift Boots
A( 13141 , SPEED_BOOST) -- Gnomish Rocket Boots
A( 8892 , SPEED_BOOST) -- Goblin Rocket Boots
A( 9774 , ROOT_IMMUNITY) -- Spider Belt & Ornate Mithril Boots, Root Immune




-- RACIALS

A( 23230 , HEALING_REDUCTION) -- Blood Fury Debuff
A( 20594 , EFFECT_IMMUNITY) -- Stoneform, Immune to Bleed, Poison, and Disease.
A( 20549 , { STUN, effect = E_STUN }) -- War Stomp
A( 7744 , EFFECT_IMMUNITY) -- Will of the Forsaken, Immune to Charm, Fear, and Sleep.
A({ 9035, 19281, 19282, 19283, 19284, 19285 },  HEALING_REDUCTION) -- Hex of Weakness
A( 20600 , STEALTH_DETECTION) -- Perception



-- WARLOCK

A( 24259 , SILENCE) -- Spell Lock Silence
A( 6358, { CROWD_CONTROL, effect = E_DISORIENT }) -- Seduction
A({ 5782, 6213, 6215 }, { CROWD_CONTROL, effect = E_FEAR }) -- Fear
A({ 5484, 17928 }, { CROWD_CONTROL, effect = E_FEAR }) -- Howl of Terror
A({ 710, 18647 }, { CROWD_CONTROL, effect = E_PHASED }) -- Banish
A({ 6789, 17925, 17926 }, { CROWD_CONTROL, effect = E_DISORIENT }) -- Death Coil
A( 18223 , { SLOW, effect = E_SLOW }) -- Curse of Exhaustion
A( 18118 , { SLOW, effect = E_SLOW }) -- Aftermath (Destruction Talent)
A({ 1714, 11719 },  DAMAGE_DECREASE) -- Curse of Tongues
A({ 6229, 11739, 11740, 28610 } , DAMAGE_ABSORB) -- Shadow Ward
A({ 7812, 19438, 19440, 19441, 19442, 19443 } , DAMAGE_ABSORB) -- Sacrifice
A( 18093 , { STUN, effect = E_STUN }) -- Pyroclasm


-- SHAMAN

A({ 8056, 8058, 10472, 10473 }, { SLOW, effect = E_SLOW }) -- Frost Shock
A( 3600 , { SLOW, effect = E_SLOW }) -- Earthbind
A({ 8034, 8037, 10458, 16352, 16353  }, { SLOW, effect = E_SLOW }) -- Frostbrand Attack
-- Lightning shield??
A( 8178 , SPELL_IMMUNITY) -- Grounding Totem Effect
-- A( 2645 , SPEED_BOOST) -- Ghost Wolf
A( 16166, DAMAGE_INCREASE2) -- Elemental Mastery

-- PALADIN

A({ 1022, 5599, 10278 },  PHYSICAL_IMMUNITY) -- Blessing of Protection
A({ 498, 5573, 642, 1020 },  IMMUNITY) -- Divine Shield
A({ 853, 5588, 5589, 10308 }, { STUN, effect = E_STUN }) -- Hammer of Justice
A( 1044 , SPEED_BOOST) -- Blessing of Freedom
A( 20066 , { INCAP, effect = E_INCAP }) -- Repentance
A( 20170 , { STUN, effect = E_STUN }) -- Seal of Justice stun

-- HUNTER


A( 13159 , SPEED_BOOST) -- Aspect of the Pack
A( 5118 , SPEED_BOOST) -- Aspect of the Cheetah
A( 15571, { SLOW, effect = E_SLOW }) -- Daze from Aspect of Cheetah/Pack
A({ 1513, 14326, 14327 }, { CROWD_CONTROL, effect = E_FEAR }) -- Scare Beast
A( 5116 ,{ SLOW, effect = E_SLOW }) -- Concussive Shot
A( 19410,{ STUN, effect = E_STUN }) -- Concussive Shot Stun
A({ 1130, 14323, 14324, 14325 },  DAMAGE_VULNERABILITY) -- Hunter's Mark
A( 3045 , DAMAGE_INCREASE) -- Rapid Fire
-- A( 19574 , DAMAGE_INCREASE) -- Bestial Wrath
A( 19263 , DAMAGE_REDUCTION) -- Deterrence
A( 13810,{ SLOW, effect = E_SLOW }) -- Frost Trap Aura
A({ 3355, 14308, 14309 },  CROWD_CONTROL) -- Freezing Trap
A({ 2974, 14267, 14268 }, { SLOW, effect = E_SLOW }) -- Wing Clip
A( 19229, { ROOT, effect = E_ROOT }) -- Wing Clip Root
A({ 19306, 20909, 20910 },{ ROOT, effect = E_ROOT }) -- Counterattack Root
A( 24394,{ STUN, effect = E_STUN }) -- Intimidation
A({ 19386, 24132, 24133 }, { CROWD_CONTROL, effect = E_INCAP }) --Wyvern Sting
A( 19185,{ ROOT, effect = E_ROOT }) -- Entrapment
-- A({ 3034, 14279, 14280},  TRASH) -- Viper Sting
A( 19503,{ CROWD_CONTROL, effect = E_DISORIENT }) -- Scatter Shot
A( 25999,{ ROOT, effect = E_ROOT }) -- Boar Charge

-- DRUID

A( 22812 , DAMAGE_REDUCTION) -- Barkskin
A( 19975,{ ROOT, effect = E_ROOT }) -- Nature's Grasp
A({ 339, 1062, 5195, 5196, 9852, 9853 },{ ROOT, effect = E_ROOT }) -- Entangling Roots
A({ 770, 778, 9749, 9907, 16857, 17390, 17391, 17392 }, ANTI_STEALTH) -- Faerie Fire
A({ 2637, 18657, 18658 },{ CROWD_CONTROL, effect = E_INCAP }) -- Hibernate
A( 29166, DAMAGE_INCREASE) -- Innervate
A({ 9005, 9823, 9827 }, { STUN, effect = E_STUN }) -- Pounce Stun
A( 16922, { STUN, effect = E_STUN }) -- Starfire Stun
-- A({ 5217, 6793, 9845, 9846 },  DAMAGE_INCREASE) -- Tiger's Fury
A({ 5211, 6798, 8983 }, { STUN, effect = E_STUN }) -- Bash
A( 16979, { ROOT, effect = E_ROOT }) -- Feral Charge
-- A( 2893 , TRASH) -- Abolish Poison
A({ 1850, 9821 }, SPEED_BOOST) -- Dash
A({ 16689, 16810, 16811, 16812, 16813, 17329},  ATTENTION) -- Nature's Grasp Buff
A({ 783, 1066 },  SPEED_BOOST) -- Travel Form & Aquatic Form
A( 6795 , TAUNT) -- Growl
A( 5209 , TAUNT) -- Challenging Roar

-- MAGE

A( 18469, { SILENCE, effect = E_SILENCE }) -- Improved Counterspell
A({ 118, 12824, 12825, 12826, 28270, 28271, 28272 }, { CROWD_CONTROL, effect = E_INCAP }) -- Polymorph
A({ 11426, 13031, 13032, 13033 },  DAMAGE_ABSORB) -- Ice Barrier
A({ 543, 8457, 8458, 10223, 10225 },  DAMAGE_ABSORB) -- Fire Ward
A({ 6143, 8461, 8462, 10177, 28609 },  DAMAGE_ABSORB) -- Frost Ward
A( 12355, { STUN, effect = E_STUN }) -- Impact
A( 22959 , TRASH) -- Fire Vulnerability
A({ 11113, 13018, 13019, 13020, 13021 }, { SLOW, effect = E_SLOW }) -- Blast Wave
A({ 120, 8492, 10159, 10160, 10161 }, { SLOW, effect = E_SLOW }) -- Cone of Cold
A({ 12484, 12485, 12486 }, { SLOW, effect = E_SLOW }) -- Improved Blizzard
A({ 6136, 7321 }, { SLOW, effect = E_SLOW }) -- Frost Armor Chill
A({ 116, 205, 837, 7322, 8406, 8407, 8408, 10179, 10180, 10181, 25304 }, { SLOW, effect = E_SLOW }) -- Frostbolt
A( 12494, { FROZEN, effect = E_ROOT }) -- Frostbite
A({ 122, 865, 6131, 10230 }, { FROZEN, effect = E_ROOT }) -- Frost Nova
A( 12042 , DAMAGE_INCREASE2) -- Arcane Power
A( 11958 , IMMUNITY) -- Ice Block
A( 12579 , TRASH) -- Winter's Chill
A({ 133, 143, 145, 3140, 8400, 8401, 8402, 10148, 10149, 10150, 10151, 25306 },  TRASH) -- Fireball dot
A({ 11366, 12505, 12522, 12523, 12524, 12525, 12526, 18809 },  TRASH) -- Pyroblast dot
A({ 2120, 2121, 8422, 8423, 10215, 10216 },  TRASH) -- Flamestrike dot
A( 12051 , ATTENTION) -- Evocation
A({ 1463, 8494, 8495, 10191, 10192, 10193 },  DAMAGE_ABSORB) -- Mana Shield

-- PRIEST

A( 15487, { SILENCE, effect = E_SILENCE }) -- Silence
A( 10060,  DAMAGE_INCREASE) -- Power Infusion
A({ 17, 592, 600, 3747, 6065, 6066, 10898, 10899, 10900, 10901 },  DAMAGE_ABSORB) -- Power Word: Shield
A({ 8122, 8124, 10888, 10890 }, { CROWD_CONTROL, effect = E_FEAR }) -- Psychic Scream
A( 15269, { STUN, effect = E_STUN }) -- Blackout
A({ 15407, 17311, 17312, 17313, 17314, 18807 }, { SLOW, effect = E_SLOW }) -- Mind Flay
A( 15258 , TRASH) -- Shadow Vulnerability
A({ 605, 10911, 10912 }, { CROWD_CONTROL, effect = E_PHASED }) -- Mind Control

-- ROGUE

A( 18425, { SILENCE, effect = E_SILENCE }) -- Improved Kick
A( 13750 , DAMAGE_INCREASE) -- Adrenaline Rush
A( 13877 , DAMAGE_INCREASE) -- Blade Flurry
A( 1833, { STUN, effect = E_STUN }) -- Cheap Shot
A({ 408, 8643 }, { STUN, effect = E_STUN }) -- Kidney Shot
A({ 2070, 6770, 11297 }, { INCAP, effect = E_INCAP }) -- Sap
A( 2094 , { CROWD_CONTROL, effect = E_DISORIENT }) -- Blind
-- A({ 8647, 8649, 8650, 11197, 11198 },  DAMAGE_VULNERABILITY) -- Expose Armor
A({ 2983, 8696, 11305 },  SPEED_BOOST) -- Sprint
A( 5277 , DAMAGE_REDUCTION) -- Evasion
A({ 1776, 1777, 8629, 11285, 11286 }, { INCAP, effect = E_INCAP }) -- Gouge
A({ 3409, 11201 }, { HEAVY_SLOW, effect = E_SLOW })
A( 14251 , DAMAGE_DECREASE) -- Riposte (Disarm)
A( 14278 , DAMAGE_REDUCTION) -- Ghostly Strike

-- WARRIOR

A( 355 , TAUNT) -- Taunt
A( 1161 , TAUNT) -- Challenging Shout
A( 18498, { SILENCE, effect = E_SILENCE }) -- Improved Shield Bash
A( 20230 , PHYSICAL_IMMUNITY) -- Retaliation
A( 1719 , DAMAGE_VULNERABILITY) -- Recklessness, Fear immunity, Damage Vuln
A( 871,  DAMAGE_REDUCTION) -- Shield Wall
A( 12328,  FEAR_IMMUNITY) -- Death Wish, Fear immunity
A({ 1715, 7372, 7373 }, { SLOW, effect = E_SLOW }) -- Hamstring
A( 23694, { ROOT, effect = E_ROOT }) -- Improved Hamstring
A( 12323, { SLOW, effect = E_SLOW }) -- Piercing Howl
-- Thunder Clap?
A( 18499,  EFFECT_IMMUNITY) -- Berserker Rage
A({ 20253, 20614, 20615 }, { STUN, effect = E_STUN }) -- Intercept Stun
A({ 5246, 20511 }, { CROWD_CONTROL, effect = E_FEAR }) -- Intimidating Shout
A( 676, { DAMAGE_DECREASE, effect = E_DISARM }) -- Disarm
A( 12798, { STUN, effect = E_STUN }) -- Revenge Stun
A( 12809, { STUN, effect = E_STUN }) -- Concussion Blow
A({ 16488, 16490, 16491 },  TRASH) -- Blood Craze
A({ 12294, 21551, 21552, 21553 },  HEALING_REDUCTION) -- Mortal Strike
A( 7922, { STUN, effect = E_STUN }) -- Charge Stun
A( 5530, { STUN, effect = E_STUN }) -- Mace Spec. Stun (Warrior & Rogue)

-----------------------
-- BURNING CRUSADE
-----------------------

elseif isBC then

lib.data = {}
data = lib.data

-- DRUID
A( 22812 , DAMAGE_REDUCTION) -- Barkskin
A( 33786, { CROWD_CONTROL, effect = E_PHASED }) -- Cyclone
A( 19975,{ ROOT, effect = E_ROOT }) -- Nature's Grasp
A({ 339, 1062, 5195, 5196, 9852, 9853, 26989 },{ ROOT, effect = E_ROOT }) -- Entangling Roots
A({ 770, 778, 9749, 9907, 26993,     16857, 17390, 17391, 17392, 27011 }, ANTI_STEALTH) -- Faerie Fire (normal & feral)
A({ 2637, 18657, 18658 },{ CROWD_CONTROL, effect = E_INCAP }) -- Hibernate
A( 29166, DAMAGE_INCREASE) -- Innervate
A({ 9005, 9823, 9827, 27006 }, { STUN, effect = E_STUN }) -- Pounce Stun
A( 16922, { STUN, effect = E_STUN }) -- Starfire Stun
-- A({ 5217, 6793, 9845, 9846 },  DAMAGE_INCREASE) -- Tiger's Fury
A({ 5211, 6798, 8983 }, { STUN, effect = E_STUN }) -- Bash
A( 16979, { ROOT, effect = E_ROOT }) -- Feral Charge
-- A( 2893 , TRASH) -- Abolish Poison
A({ 1850, 9821, 33357 }, SPEED_BOOST) -- Dash
A({ 16689, 16810, 16811, 16812, 16813, 17329, 27009 },  ATTENTION) -- Nature's Grasp Buff
A({ 783, 1066 },  SPEED_BOOST) -- Travel Form & Aquatic Form
A( 6795 , TAUNT) -- Growl
A( 5209 , TAUNT) -- Challenging Roar
A({ 33878, 33986, 33987,    33876, 33982, 33983 }, TRASH) -- Mangle (Bear & Cat)


-- WARLOCK

A( 24259 , SILENCE) -- Spell Lock Silence
A( 6358, { CROWD_CONTROL, effect = E_DISORIENT }) -- Seduction
A({ 5782, 6213, 6215 }, { CROWD_CONTROL, effect = E_FEAR }) -- Fear
A({ 5484, 17928 }, { CROWD_CONTROL, effect = E_FEAR }) -- Howl of Terror
A({ 710, 18647 }, { CROWD_CONTROL, effect = E_PHASED }) -- Banish
A({ 6789, 17925, 17926, 27223 }, { CROWD_CONTROL, effect = E_DISORIENT }) -- Death Coil
A( 18223 , { SLOW, effect = E_SLOW }) -- Curse of Exhaustion
A( 18118 , { SLOW, effect = E_SLOW }) -- Aftermath (Destruction Talent)
A({ 1714, 11719 },  DAMAGE_DECREASE) -- Curse of Tongues
A({ 6229, 11739, 11740, 28610 } , DAMAGE_ABSORB) -- Shadow Ward
A({ 7812, 19438, 19440, 19441, 19442, 19443, 27273 } , DAMAGE_ABSORB) -- Sacrifice
A( 18093 , { STUN, effect = E_STUN }) -- Pyroclasm
A({ 30108, 30404, 30405 } , { ANTI_DISPEL, effect = E_ANTIDISPEL }) -- Unstable Affliction
A( 17794, TRASH) -- Improved Shadowbolt
A({ 30153, 30195, 30197 }, { STUN, effect = E_STUN }) -- Felguard Intercept Stun

-- PRIEST
A( 15487, { SILENCE, effect = E_SILENCE }) -- Silence
A( 10060,  DAMAGE_INCREASE) -- Power Infusion
A({ 17, 592, 600, 3747, 6065, 6066, 10898, 10899, 10900, 10901, 25217, 25218 },  DAMAGE_ABSORB) -- Power Word: Shield
A({ 8122, 8124, 10888, 10890 }, { CROWD_CONTROL, effect = E_FEAR }) -- Psychic Scream
A( 15269, { STUN, effect = E_STUN }) -- Blackout
A({ 15407, 17311, 17312, 17313, 17314, 18807, 25387 }, { SLOW, effect = E_SLOW }) -- Mind Flay
A( 15258 , TRASH) -- Shadow Vulnerability
A({ 605, 10911, 10912 }, { CROWD_CONTROL, effect = E_PHASED }) -- Mind Control
A({ 33196, 33197, 33198, 33199, 33200 }, TRASH) -- Misery

-- ROGUE
A( 18425, { SILENCE, effect = E_SILENCE }) -- Improved Kick
A( 13750 , DAMAGE_INCREASE2) -- Adrenaline Rush
A( 13877 , DAMAGE_INCREASE) -- Blade Flurry
A( 1833, { STUN, effect = E_STUN }) -- Cheap Shot
A({ 408, 8643 }, { STUN, effect = E_STUN }) -- Kidney Shot
A({ 2070, 6770, 11297 }, { INCAP, effect = E_INCAP }) -- Sap
A( 2094 , { CROWD_CONTROL, effect = E_DISORIENT }) -- Blind
-- A({ 8647, 8649, 8650, 11197, 11198, 26866 },  DAMAGE_VULNERABILITY) -- Expose Armor
A({ 2983, 8696, 11305 },  SPEED_BOOST) -- Sprint
A({ 5277, 26669 }, DAMAGE_REDUCTION2) -- Evasion
A({ 1776, 1777, 8629, 11285, 11286, 38764 }, { INCAP, effect = E_INCAP }) -- Gouge
A({ 3409, 11201 }, { HEAVY_SLOW, effect = E_SLOW })
A( 14251 , DAMAGE_DECREASE) -- Riposte (Disarm)
A( 14278 , DAMAGE_REDUCTION) -- Ghostly Strike
A( 1330 , { SILENCE, effect = E_SILENCE }) -- Garrote Silence
A({ 31234, 31235, 31236, 31237, 31238 }, TRASH) -- Find Weakness

-- WARRIOR
A( 355 , TAUNT) -- Taunt
A( 1161 , TAUNT) -- Challenging Shout
A( 18498, { SILENCE, effect = E_SILENCE }) -- Improved Shield Bash
A( 20230 , PHYSICAL_IMMUNITY) -- Retaliation
A( 1719 , { DAMAGE_INCREASE2, FEAR_IMMUNITY }) -- Recklessness, Fear immunity, Damage Vuln
A( 871,  DAMAGE_REDUCTION2) -- Shield Wall
A( 12328, { DAMAGE_INCREASE, FEAR_IMMUNITY }) -- Death Wish, Fear immunity
A({ 1715, 7372, 7373, 25212 }, { SLOW, effect = E_SLOW }) -- Hamstring
A( 23694, { ROOT, effect = E_ROOT }) -- Improved Hamstring
A( 12323, { SLOW, effect = E_SLOW }) -- Piercing Howl
-- Thunder Clap?
A( 18499,  EFFECT_IMMUNITY) -- Berserker Rage, (Fear/Incap)
A({ 20253, 20614, 20615, 25273, 25274 }, { STUN, effect = E_STUN }) -- Intercept Stun
A({ 5246, 20511 }, { CROWD_CONTROL, effect = E_FEAR }) -- Intimidating Shout
A( 676, { DAMAGE_DECREASE, effect = E_DISARM }) -- Disarm
A( 12798, { STUN, effect = E_STUN }) -- Revenge Stun
A( 12809, { STUN, effect = E_STUN }) -- Concussion Blow
A({ 16488, 16490, 16491 },  TRASH) -- Blood Craze
A({ 12294, 21551, 21552, 21553, 25248, 30330 },  HEALING_REDUCTION) -- Mortal Strike
A( 7922, { STUN, effect = E_STUN }) -- Charge Stun
A( 5530, { STUN, effect = E_STUN }) -- Mace Spec. Stun (Warrior & Rogue)
A({ 30069, 30070 },  TRASH) -- Blood Frenzy

-- HUNTER
A( 13159 , SPEED_BOOST) -- Aspect of the Pack
A( 5118 , SPEED_BOOST) -- Aspect of the Cheetah
A( 15571, { SLOW, effect = E_SLOW }) -- Daze from Aspect of Cheetah/Pack
A({ 1513, 14326, 14327 }, { CROWD_CONTROL, effect = E_FEAR }) -- Scare Beast
A( 5116 ,{ SLOW, effect = E_SLOW }) -- Concussive Shot
A( 19410,{ STUN, effect = E_STUN }) -- Concussive Shot Stun
A({ 1130, 14323, 14324, 14325 },  DAMAGE_VULNERABILITY) -- Hunter's Mark
A( 3045 , DAMAGE_INCREASE) -- Rapid Fire
-- A( 19574 , DAMAGE_INCREASE) -- Bestial Wrath
A( 19263 , DAMAGE_REDUCTION) -- Deterrence
A( 13810,{ SLOW, effect = E_SLOW }) -- Frost Trap Aura
A({ 3355, 14308, 14309 }, { CROWD_CONTROL, effect = E_INCAP }) -- Freezing Trap
A({ 2974, 14267, 14268 }, { SLOW, effect = E_SLOW }) -- Wing Clip
A( 19229, { ROOT, effect = E_ROOT }) -- Wing Clip Root
A({ 19306, 20909, 20910 },{ ROOT, effect = E_ROOT }) -- Counterattack Root
A( 24394,{ STUN, effect = E_STUN }) -- Intimidation
A({ 19386, 24132, 24133 }, { CROWD_CONTROL, effect = E_INCAP }) --Wyvern Sting
A( 19185,{ ROOT, effect = E_ROOT }) -- Entrapment
-- A({ 3034, 14279, 14280},  TRASH) -- Viper Sting
A( 19503,{ CROWD_CONTROL, effect = E_DISORIENT }) -- Scatter Shot
A( 25999,{ ROOT, effect = E_ROOT }) -- Boar Charge
A( 34490,{ SILENCE, effect = E_SILENCE }) -- Silencing Shot

-- MAGE
A( 31589 , { DAMAGE_DECREASE, SLOW, effect = E_SLOW }) -- Slow
A( 18469, { SILENCE, effect = E_SILENCE }) -- Improved Counterspell
A({ 118, 12824, 12825, 12826, 28270, 28271, 28272 }, { CROWD_CONTROL, effect = E_INCAP }) -- Polymorph
A({ 11426, 13031, 13032, 13033, 27134, 33405 },  DAMAGE_ABSORB) -- Ice Barrier
A({ 543, 8457, 8458, 10223, 10225, 27128 },  DAMAGE_ABSORB) -- Fire Ward
A({ 6143, 8461, 8462, 10177, 28609, 32796 },  DAMAGE_ABSORB) -- Frost Ward
A( 12355, { STUN, effect = E_STUN }) -- Impact
A( 22959 , TRASH) -- Fire Vulnerability
A({ 11113, 13018, 13019, 13020, 13021 }, { SLOW, effect = E_SLOW }) -- Blast Wave
A({ 120, 8492, 10159, 10160, 10161, 27087 }, { SLOW, effect = E_SLOW }) -- Cone of Cold
A({ 12484, 12485, 12486 }, { SLOW, effect = E_SLOW }) -- Improved Blizzard
A({ 6136, 7321 }, { SLOW, effect = E_SLOW }) -- Frost Armor Chill
A({ 116, 205, 837, 7322, 8406, 8407, 8408, 10179, 10180, 10181, 25304, 27071, 27072, 38697 }, { SLOW, effect = E_SLOW }) -- Frostbolt
A( 12494, { FROZEN, effect = E_ROOT }) -- Frostbite
A( 33395, { FROZEN, effect = E_ROOT }) -- Water Elemental's Freeze
A({ 122, 865, 6131, 10230, 27088 }, { FROZEN, effect = E_ROOT }) -- Frost Nova
A( 12042 , DAMAGE_INCREASE2) -- Arcane Power
A( 11958 , IMMUNITY) -- Ice Block
A( 12579 , TRASH) -- Winter's Chill
A({ 133, 143, 145, 3140, 8400, 8401, 8402, 10148, 10149, 10150, 10151, 25306, 27070, 38692 },  TRASH) -- Fireball dot
A({ 11366, 12505, 12522, 12523, 12524, 12525, 12526, 18809, 27132, 33938 },  TRASH) -- Pyroblast dot
A({ 2120, 2121, 8422, 8423, 10215, 10216, 27086 },  TRASH) -- Flamestrike dot
A( 12051 , ATTENTION) -- Evocation
A({ 1463, 8494, 8495, 10191, 10192, 10193, 27131 },  DAMAGE_ABSORB) -- Mana Shield

-- SHAMAN
A({ 8056, 8058, 10472, 10473, 25464 }, { SLOW, effect = E_SLOW }) -- Frost Shock
A( 3600 , { SLOW, effect = E_SLOW }) -- Earthbind
A({ 8034, 8037, 10458, 16352, 16353, 25501  }, { SLOW, effect = E_SLOW }) -- Frostbrand Attack
-- Lightning shield??
A( 8178 , SPELL_IMMUNITY) -- Grounding Totem Effect
-- A( 2645 , SPEED_BOOST) -- Ghost Wolf
A( 16166, DAMAGE_INCREASE2) -- Elemental Mastery
A( 30823, DAMAGE_REDUCTION2) -- Shamanistic Rage 30% DR

-- PALADIN
A({ 1022, 5599, 10278 },  PHYSICAL_IMMUNITY) -- Blessing of Protection
A({ 498, 5573, 642, 1020 },  IMMUNITY) -- Divine Shield
A({ 853, 5588, 5589, 10308 }, { STUN, effect = E_STUN }) -- Hammer of Justice
A( 1044 , SPEED_BOOST) -- Blessing of Freedom
A( 20066 , { INCAP, effect = E_INCAP }) -- Repentance
A( 20170 , { STUN, effect = E_STUN }) -- Seal of Justice stun

end


local math_max = math.max
function lib.GetDebuffInfo(...) -- older version of the function with stupid return value order
    local prio, spellType, spellID, effectType = lib.GetAuraInfo(...)
    return spellID, spellType, prio, effectType
end
function lib.GetAuraInfo(spellID, targetType)
    local spellData = data[spellID]
    if spellData then
        targetType = targetType or "ALLY"
        local priorityTable = targetType == "ALLY" and friendlyPriority or enemyPriority
        local spellType
        local maxPrio = -1000
        local effectType
        if type(spellData) == "table" then
            if spellData.originalID then spellID = spellData.originalID end
            for _, spellType in ipairs(spellData) do
                local prio = priorityTable[spellType]
                maxPrio = math_max(prio, maxPrio)
            end
            effectType = spellData.effect
        else
            spellType = spellData
            maxPrio = priorityTable[spellType]
        end

        return maxPrio, spellType, spellID, effectType
    end
end

function lib.GetAuraTypePriority(dType, targetType)
    targetType = targetType or "ALLY"
    local priorityTable = targetType == "ALLY" and friendlyPriority or enemyPriority
    return priorityTable[dType]
end
lib.GetDebuffTypePriority = lib.GetAuraTypePriority

function lib.GetPriorities(targetType)
    targetType = targetType or "ALLY"
    local priorityTable = targetType == "ALLY" and friendlyPriority or enemyPriority

    local sortfunc = function(a,b) return a[2] > b[2] end
    local orderedTable = {}
    for category, priority in pairs(priorityTable) do
        table.insert(orderedTable, { category, priority })
    end
    table.sort(orderedTable, sortfunc)

    return orderedTable
end

-- If you're going to use this, make sure it's after all addons are loaded.
-- Otherwise newer version of the lib data may overwrite your changes
function lib.AddAura( id, opts )
    A(id, opts)
end

-- function lib.GetRelativeAuraTypePriority(...)
--     return lib.GetAuraTypePriority(...)/100
-- end
