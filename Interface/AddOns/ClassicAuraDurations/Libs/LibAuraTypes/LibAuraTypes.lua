--[================[
LibAuraTypes-1.0
Author: d87
Description: Provides aura classification and priority
--]================]


local MAJOR, MINOR = "LibAuraTypes", 2
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end


local CROWD_CONTROL = "CROWD_CONTROL"
local STUN = "STUN"
local INCAP = "INCAP"
local FROZEN = "FROZEN"
local SILENCE = "SILENCE"
local ROOT = "ROOT"
local SLOW = "SLOW"
local SPEED_BOOST = "SPEED_BOOST"
local IMMUNITY = "IMMUNITY"
local DAMAGE_REDUCTION = "DAMAGE_REDUCTION"
local DAMAGE_ABSORB = "DAMAGE_ABSORB"
local DAMAGE_VULNERABILITY = "DAMAGE_VULNERABILITY"
local DAMAGE_INCREASE = "DAMAGE_INCREASE"
local DAMAGE_DECREASE = "DAMAGE_DECREASE"
local TRASH = "TRASH"
local EFFECT_IMMUNITY = "EFFECT_IMMUNITY"
local HEALING_REDUCTION = "HEALING_REDUCTION"
local ATTENTION = "ATTENTION"

lib.priority = lib.priority or {
    ATTENTION = 21,
    IMMUNITY = 20,
    STUN = 18,
    ANTI_DISPEL = 17,
    EFFECT_IMMUNITY = 17,

    CROWD_CONTROL = 14,
    INCAP = 13,
    SILENCE = 10,
    FROZEN = 9.1,
    ROOT = 9,

    DAMAGE_REDUCTION = 6,
    DAMAGE_ABSORB = 5.7,
    DAMAGE_VULNERABILITY = 5.5,

    DAMAGE_INCREASE = 6,
    DAMAGE_DECREASE = 5.5,

    SLOW = 3,
    SPEED_BOOST = 2.8,
    HEALING_REDUCTION = 2,
    TRASH = -1,
}
local priority = lib.priority
local data

local isClassic = select(4,GetBuildInfo()) <= 19999

-----------------------
-- LIVE
-----------------------
if not isClassic then

lib.data = lib.data or {
    -- [25163] = { type = ATTENTION }, -- Oozeling's Aura

    [115804] = { type = HEALING_REDUCTION }, -- Mortal Wounds
    [8680] = { type = HEALING_REDUCTION }, -- Wound Poison
    [197046] = { type = HEALING_REDUCTION }, -- Minor Wound Poison

    -- DEATH KNIGHT

    [47476] = { type = CROWD_CONTROL }, -- Strangulate
    [48707] = { type = IMMUNITY }, -- Anti-Magic Shell
    [48265] = { type = DAMAGE_REDUCTION }, -- Death's Advance
    [48792] = { type = DAMAGE_REDUCTION }, -- Icebound Fortitude
    [81256] = { type = DAMAGE_REDUCTION }, -- Dancing Rune Weapon
    [51271] = { type = DAMAGE_INCREASE }, -- Pillar of Frost
    [55233] = { type = DAMAGE_REDUCTION }, -- Vampiric Blood
    [77606] = { type = ATTENTION }, -- Dark Simulacrum
    [91797] = { type = CROWD_CONTROL }, -- Monstrous Blow
    [91800] = { type = CROWD_CONTROL }, -- Gnaw
    [108194] = { type = CROWD_CONTROL }, -- Asphyxiate
        [221562] = { type = CROWD_CONTROL, originalID = 108194 }, -- Asphyxiate (Blood)
    [152279] = { type = DAMAGE_INCREASE }, -- Breath of Sindragosa
    [194679] = { type = DAMAGE_REDUCTION }, -- Rune Tap
    [194844] = { type = DAMAGE_REDUCTION }, -- Bonestorm
    [204080] = { type = ROOT }, -- Frostbite
    [206977] = { type = DAMAGE_REDUCTION }, -- Blood Mirror
    [207127] = { type = DAMAGE_INCREASE }, -- Hungering Rune Weapon
    [207167] = { type = CROWD_CONTROL }, -- Blinding Sleet
    [207171] = { type = CROWD_CONTROL }, -- Winter is Coming
    [207256] = { type = DAMAGE_INCREASE }, -- Obliteration
    [207289] = { type = DAMAGE_INCREASE }, -- Unholy Frenzy
    [212332] = { type = CROWD_CONTROL }, -- Smash
        [212337] = { type = CROWD_CONTROL, originalID = 212332 }, -- Powerful Smash
    [212552] = { type = DAMAGE_REDUCTION }, -- Wraith Walk
    [219809] = { type = DAMAGE_REDUCTION }, -- Tombstone
    [223929] = { type = HEALING_REDUCTION }, -- Necrotic Wound

    -- Demon Hunter

    [179057] = { type = CROWD_CONTROL }, -- Chaos Nova
    [187827] = { type = DAMAGE_REDUCTION }, -- Metamorphosis
    [188499] = { type = DAMAGE_REDUCTION }, -- Blade Dance
    [188501] = { type = DAMAGE_INCREASE }, -- Spectral Sight
    [204490] = { type = CROWD_CONTROL }, -- Sigil of Silence
    [205629] = { type = DAMAGE_REDUCTION }, -- Demonic Trample
    [205630] = { type = CROWD_CONTROL }, -- Illidan's Grasp
    [206649] = { type = ATTENTION }, -- Eye of Leotheras
    [207685] = { type = CROWD_CONTROL }, -- Sigil of Misery
    [207810] = { type = DAMAGE_REDUCTION }, -- Nether Bond
    [211048] = { type = DAMAGE_INCREASE }, -- Chaos Blades
    [211881] = { type = CROWD_CONTROL }, -- Fel Eruption
    [212800] = { type = DAMAGE_REDUCTION }, -- Blur
        [196555] = { type = DAMAGE_REDUCTION }, -- Netherwalk
    [218256] = { type = DAMAGE_REDUCTION }, -- Empower Wards
    [221527] = { type = CROWD_CONTROL }, -- Imprison (Detainment Honor Talent)
        [217832] = { type = CROWD_CONTROL, originalID = 221527 }, -- Imprison (Baseline Undispellable)
    [227225] = { type = DAMAGE_REDUCTION }, -- Soul Barrier

    -- Druid / probably good, no slow

    [99] = { type = CROWD_CONTROL }, -- Incapacitating Roar
    [339] = { type = ROOT }, -- Entangling Roots
    [740] = { type = DAMAGE_REDUCTION }, -- Tranquility
    [1850] = { type = SPEED_BOOST }, -- Dash
        [252216] = { type = SPEED_BOOST, originalID = 1850 }, -- Tiger Dash
    [2637] = { type = CROWD_CONTROL }, -- Hibernate
    [5211] = { type = STUN }, -- Mighty Bash
    [5217] = { type = DAMAGE_INCREASE }, -- Tiger's Fury
    [22812] = { type = DAMAGE_REDUCTION }, -- Barkskin
    -- [22842] = { type = DAMAGE_REDUCTION }, -- Frenzied Regeneration
    -- [29166] = { type = DAMAGE_INCREASE }, -- Innervate
    [33891] = { type = DAMAGE_INCREASE }, -- Incarnation: Tree of Life
    [45334] = { type = ROOT }, -- Wild Charge
    [61336] = { type = DAMAGE_REDUCTION }, -- Survival Instincts
    [81261] = { type = SILENCE }, -- Solar Beam
    [102342] = { type = DAMAGE_REDUCTION }, -- Ironbark
    [102359] = { type = ROOT }, -- Mass Entanglement
    [279642] = { type = DAMAGE_INCREASE }, -- Lively Spirit
    [102543] = { type = DAMAGE_INCREASE }, -- Incarnation: King of the Jungle
    [102558] = { type = DAMAGE_INCREASE }, -- Incarnation: Guardian of Ursoc
    [102560] = { type = DAMAGE_INCREASE }, -- Incarnation: Chosen of Elune
    [106951] = { type = DAMAGE_INCREASE }, -- Berserk
    [155835] = { type = DAMAGE_REDUCTION }, -- Bristling Fur
    [192081] = { type = DAMAGE_REDUCTION }, -- Ironfur
    [163505] = { type = STUN }, -- Rake
    [194223] = { type = DAMAGE_INCREASE }, -- Celestial Alignment
    [200851] = { type = DAMAGE_REDUCTION }, -- Rage of the Sleeper
    [202425] = { type = DAMAGE_INCREASE }, -- Warrior of Elune
    [204399] = { type = STUN }, -- Earthfury
    [204437] = { type = STUN }, -- Lightning Lasso

    [209749] = { type = DAMAGE_DECREASE }, -- Faerie Swarm (Slow/Disarm)
    [209753] = { type = CROWD_CONTROL, priority = true }, -- Cyclone
        [33786] = { type = CROWD_CONTROL, originalID = 209753 }, -- Cyclone
    [22570] = { type = STUN }, -- Maim
    [236696] = { type = DAMAGE_REDUCTION }, -- Thorns (PvP Talent)
    [232559] = { type = SLOW }, -- Thorns Slow (PvP Talent)


    -- Hunter

    [136] = { type = DAMAGE_REDUCTION }, -- Mend Pet
    [3355] = { type = CROWD_CONTROL }, -- Freezing Trap
        [203340] = { type = CROWD_CONTROL }, -- Diamond Ice (Survival Honor Talent)
    [5384] = { type = DAMAGE_REDUCTION }, -- Feign Death
    [19386] = { type = CROWD_CONTROL }, -- Wyvern Sting
    [19574] = { type = DAMAGE_INCREASE }, -- Bestial Wrath
    [19577] = { type = CROWD_CONTROL }, -- Intimidation
        [24394] = { type = CROWD_CONTROL, originalID = 19577 }, -- Intimidation
    [53480] = { type = DAMAGE_REDUCTION }, -- Roar of Sacrifice (Hunter Pet Skill)
    [117526] = { type = ROOT }, -- Binding Shot
    [131894] = { type = DAMAGE_INCREASE }, -- A Murder of Crows (Beast Mastery, Marksmanship)
        [206505] = { type = DAMAGE_INCREASE, originalID = 131894 }, -- A Murder of Crows (Survival)
    [186265] = { type = DAMAGE_REDUCTION }, -- Aspect of the Turtle
    [186289] = { type = DAMAGE_INCREASE }, -- Aspect of the Eagle
    [238559] = { type = CROWD_CONTROL }, -- Bursting Shot
        [186387] = { type = CROWD_CONTROL, originalID = 238559 }, -- Bursting Shot
    [193526] = { type = DAMAGE_INCREASE }, -- Trueshot
    [193530] = { type = DAMAGE_INCREASE }, -- Aspect of the Wild
    [199483] = { type = DAMAGE_REDUCTION }, -- Camouflage
    [202914] = { type = CROWD_CONTROL }, -- Spider Sting (Armed)
        [202933] = { type = CROWD_CONTROL, originalID = 202914 }, -- Spider Sting (Silenced)
        [233022] = { type = CROWD_CONTROL, originalID = 202914 }, -- Spider Sting (Silenced)
    [209790] = { type = CROWD_CONTROL }, -- Freezing Arrow
    [209997] = { type = DAMAGE_REDUCTION }, -- Play Dead
    [213691] = { type = CROWD_CONTROL }, -- Scatter Shot
    [272682] = { type = DAMAGE_REDUCTION }, -- Master's Call

    -- Mage / ok, no slow

    [66] = { type = DAMAGE_INCREASE }, -- Invisibility
        [110959] = { type = DAMAGE_INCREASE, originalID = 66 }, -- Greater Invisibility
    [118] = { type = CROWD_CONTROL }, -- Polymorph
        [28271] = { type = CROWD_CONTROL, originalID = 118 }, -- Polymorph Turtle
        [28272] = { type = CROWD_CONTROL, originalID = 118 }, -- Polymorph Pig
        [61025] = { type = CROWD_CONTROL, originalID = 118 }, -- Polymorph Serpent
        [61305] = { type = CROWD_CONTROL, originalID = 118 }, -- Polymorph Black Cat
        [61721] = { type = CROWD_CONTROL, originalID = 118 }, -- Polymorph Rabbit
        [61780] = { type = CROWD_CONTROL, originalID = 118 }, -- Polymorph Turkey
        [126819] = { type = CROWD_CONTROL, originalID = 118 }, -- Polymorph Porcupine
        [161353] = { type = CROWD_CONTROL, originalID = 118 }, -- Polymorph Polar Bear Cub
        [161354] = { type = CROWD_CONTROL, originalID = 118 }, -- Polymorph Monkey
        [161355] = { type = CROWD_CONTROL, originalID = 118 }, -- Polymorph Penguin
        [161372] = { type = CROWD_CONTROL, originalID = 118 }, -- Polymorph Peacock
        [277787] = { type = CROWD_CONTROL, originalID = 118 }, -- Polymorph Direhorn
        [277792] = { type = CROWD_CONTROL, originalID = 118 }, -- Polymorph Bumblebee
    [122] = { type = ROOT }, -- Frost Nova
        [33395] = { type = ROOT, originalID = 122 }, -- Freeze
    [11426] = { type = DAMAGE_REDUCTION }, -- Ice Barrier
    [12042] = { type = DAMAGE_INCREASE }, -- Arcane Power
    [12051] = { type = DAMAGE_INCREASE }, -- Evocation
    [12472] = { type = DAMAGE_INCREASE }, -- Icy Veins
        [198144] = { type = DAMAGE_INCREASE, originalID = 12472 }, -- Ice Form
    [31661] = { type = CROWD_CONTROL }, -- Dragon's Breath
    [45438] = { type = IMMUNITY }, -- Ice Block
        [41425] = { type = TRASH }, -- Hypothermia
    [80353] = { type = DAMAGE_INCREASE }, -- Time Warp
    [82691] = { type = CROWD_CONTROL }, -- Ring of Frost
    [108839] = { type = DAMAGE_INCREASE }, -- Ice Floes
    [157997] = { type = ROOT }, -- Ice Nova
    [190319] = { type = DAMAGE_INCREASE }, -- Combustion
    [198111] = { type = DAMAGE_REDUCTION }, -- Temporal Shield
    [198158] = { type = DAMAGE_INCREASE }, -- Mass Invisibility
    [198064] = { type = DAMAGE_REDUCTION }, -- Prismatic Cloak
        [198065] = { type = DAMAGE_REDUCTION, originalID = 198064 }, -- Prismatic Cloak
    [205025] = { type = DAMAGE_INCREASE }, -- Presence of Mind
    [228600] = { type = ROOT }, -- Glacial Spike Root

    -- Monk / good

    [115078] = { type = CROWD_CONTROL }, -- Paralysis
    [115080] = { type = DAMAGE_VULNERABILITY }, -- Touch of Death
    [120954] = { type = DAMAGE_REDUCTION }, -- Fortifying Brew (Brewmaster)
        [201318] = { type = DAMAGE_REDUCTION, originalID = 120954 }, -- Fortifying Brew (Windwalker PvP Talent)
        [243435] = { type = DAMAGE_REDUCTION, originalID = 120954 }, -- Fortifying Brew (Mistweaver)
    [116095] = { type = SLOW }, -- Disable Slow
    [116706] = { type = ROOT }, -- Disable Root
    [116849] = { type = DAMAGE_REDUCTION }, -- Life Cocoon
    [119381] = { type = STUN }, -- Leg Sweep
    [122278] = { type = DAMAGE_REDUCTION }, -- Dampen Harm
    [122470] = { type = IMMUNITY }, -- Touch of Karma
    [122783] = { type = DAMAGE_REDUCTION }, -- Diffuse Magic
    [137639] = { type = DAMAGE_REDUCTION }, -- Storm, Earth, and Fire
    [198909] = { type = CROWD_CONTROL }, -- Song of Chi-Ji
    [115176] = { type = DAMAGE_REDUCTION }, -- Zen Meditation
    [216113] = { type = DAMAGE_INCREASE }, -- Way of the Crane
    [232055] = { type = CROWD_CONTROL }, -- Fists of Fury
        [120086] = { type = CROWD_CONTROL, originalID = 232055 }, -- Fists of Fury
    [233759] = { type = CROWD_CONTROL }, -- Grapple Weapon

    -- Paladin

    [498] = { type = DAMAGE_REDUCTION }, -- Divine Protection
    [642] = { type = IMMUNITY }, -- Divine Shield
    [853] = { type = CROWD_CONTROL }, -- Hammer of Justice
    [1022] = { type = DAMAGE_REDUCTION }, -- Blessing of Protection
        [204018] = { type = DAMAGE_REDUCTION }, -- Blessing of Spellwarding
    [1044] = { type = DAMAGE_REDUCTION }, -- Blessing of Freedom
    [6940] = { type = DAMAGE_REDUCTION }, -- Blessing of Sacrifice
        [199448] = { type = DAMAGE_REDUCTION, originalID = 6940 }, -- Blessing of Sacrifice (Ultimate Sacrifice Honor Talent)
    [20066] = { type = CROWD_CONTROL }, -- Repentance
    [31821] = { type = DAMAGE_REDUCTION }, -- Aura Mastery
    [31850] = { type = DAMAGE_REDUCTION }, -- Ardent Defender
    [31884] = { type = DAMAGE_INCREASE }, -- Avenging Wrath (Protection/Retribution)
        [31842] = { type = DAMAGE_INCREASE, originalID = 31884 }, -- Avenging Wrath (Holy)
        [216331] = { type = DAMAGE_INCREASE, originalID = 31884 }, -- Avenging Crusader (Holy Honor Talent)
        [231895] = { type = DAMAGE_INCREASE, originalID = 31884 }, -- Crusade (Retribution Talent)
    [31935] = { type = CROWD_CONTROL }, -- Avenger's Shield
    [86659] = { type = DAMAGE_REDUCTION }, -- Guardian of Ancient Kings
        [212641] = { type = DAMAGE_REDUCTION }, -- Guardian of Ancient Kings (Glyphed)
        [228049] = { type = DAMAGE_REDUCTION }, -- Guardian of the Forgotten Queen
    [105809] = { type = DAMAGE_INCREASE }, -- Holy Avenger
    [115750] = { type = CROWD_CONTROL }, -- Blinding Light
        [105421] = { type = CROWD_CONTROL, originalID = 115750 }, -- Blinding Light
    [152262] = { type = DAMAGE_INCREASE }, -- Seraphim
    [184662] = { type = DAMAGE_REDUCTION }, -- Shield of Vengeance
    [204150] = { type = DAMAGE_REDUCTION }, -- Aegis of Light
    [205191] = { type = DAMAGE_REDUCTION }, -- Eye for an Eye
    [210256] = { type = DAMAGE_REDUCTION }, -- Blessing of Sanctuary
    [210294] = { type = IMMUNITY }, -- Divine Favor
    [215652] = { type = DAMAGE_INCREASE }, -- Shield of Virtue


    -- Priest / unchecked, no slow

    [34914] = { type = ANTI_DISPEL }, -- Vampiric Touch
    [586] = { type = DAMAGE_REDUCTION }, -- Fade
        [213602] = { type = DAMAGE_REDUCTION }, -- Greater Fade
    [605] = { type = CROWD_CONTROL }, -- Mind Control
    [8122] = { type = CROWD_CONTROL }, -- Psychic Scream
    [9484] = { type = CROWD_CONTROL }, -- Shackle Undead
    [10060] = { type = DAMAGE_INCREASE }, -- Power Infusion
    [15487] = { type = SILENCE }, -- Silence
        [199683] = { type = CROWD_CONTROL, originalID = 15487 }, -- Last Word
    [33206] = { type = DAMAGE_REDUCTION }, -- Pain Suppression
    [47536] = { type = DAMAGE_REDUCTION }, -- Rapture
    [47585] = { type = DAMAGE_REDUCTION }, -- Dispersion
    [47788] = { type = DAMAGE_REDUCTION }, -- Guardian Spirit
    [64044] = { type = CROWD_CONTROL }, -- Psychic Horror
    [64843] = { type = DAMAGE_REDUCTION }, -- Divine Hymn
    [81782] = { type = DAMAGE_REDUCTION }, -- Power Word: Barrier
        [271466] = { type = DAMAGE_REDUCTION, originalID = 81782 }, -- Luminous Barrier (Disc Talent)
    [87204] = { type = CROWD_CONTROL }, -- Sin and Punishment
    [193223] = { type = DAMAGE_INCREASE }, -- Surrender to Madness
    [194249] = { type = DAMAGE_INCREASE }, -- Voidform
    [196762] = { type = DAMAGE_REDUCTION }, -- Inner Focus
    [197268] = { type = DAMAGE_REDUCTION }, -- Ray of Hope
    [197862] = { type = DAMAGE_REDUCTION }, -- Archangel
    [197871] = { type = DAMAGE_INCREASE }, -- Dark Archangel
    [200183] = { type = DAMAGE_REDUCTION }, -- Apotheosis
    [200196] = { type = INCAP }, -- Holy Word: Chastise
        [200200] = { type = CROWD_CONTROL, originalID = 200196 }, -- Holy Word: Chastise (Stun)
    [205369] = { type = CROWD_CONTROL }, -- Mind Bomb
        [226943] = { type = CROWD_CONTROL, originalID = 205369 }, -- Mind Bomb (Disorient)
    [213610] = { type = EFFECT_IMMUNITY }, -- Holy Ward
    [215769] = { type = IMMUNITY }, -- Spirit of Redemption
    [221660] = { type = IMMUNITY }, -- Holy Concentration

    -- Rogue / good

    [408] = { type = STUN }, -- Kidney Shot
    [1330] = { type = SILENCE }, -- Garrote - Silence
    [1776] = { type = INCAP }, -- Gouge
    [1833] = { type = STUN }, -- Cheap Shot
    [1966] = { type = DAMAGE_REDUCTION }, -- Feint
    [2094] = { type = CROWD_CONTROL }, -- Blind
    [5277] = { type = DAMAGE_REDUCTION }, -- Evasion
    [6770] = { type = INCAP }, -- Sap
    [13750] = { type = DAMAGE_INCREASE }, -- Adrenaline Rush
    [31224] = { type = IMMUNITY }, -- Cloak of Shadows
    [51690] = { type = DAMAGE_INCREASE }, -- Killing Spree
    [79140] = { type = DAMAGE_INCREASE }, -- Vendetta
    [121471] = { type = DAMAGE_INCREASE }, -- Shadow Blades
    [199754] = { type = IMMUNITY }, -- Riposte
    [199804] = { type = STUN }, -- Between the Eyes
    [207736] = { type = DAMAGE_INCREASE }, -- Shadowy Duel
    [212183] = { type = CROWD_CONTROL }, -- Smoke Bomb
    [3409] = { type = SLOW }, -- Crippling Poison
    [185763] = { type = SLOW }, -- Pistol Shot
    [206760] = { type = SLOW }, -- Shadow's Grasp
    -- [277953] = { type = SLOW }, -- Night Terrors
    [199027] = { type = EFFECT_IMMUNITY }, -- Veil of Midnight (100% dodge)


    -- Shaman

    [2825] = { type = DAMAGE_INCREASE }, -- Bloodlust
        [32182] = { type = DAMAGE_INCREASE, originalID = 2825 }, -- Heroism
    [51514] = { type = CROWD_CONTROL }, -- Hex
        [196932] = { type = CROWD_CONTROL, originalID = 51514 }, -- Voodoo Totem
        [210873] = { type = CROWD_CONTROL, originalID = 51514 }, -- Hex (Compy)
        [211004] = { type = CROWD_CONTROL, originalID = 51514 }, -- Hex (Spider)
        [211010] = { type = CROWD_CONTROL, originalID = 51514 }, -- Hex (Snake)
        [211015] = { type = CROWD_CONTROL, originalID = 51514 }, -- Hex (Cockroach)
        [269352] = { type = CROWD_CONTROL, originalID = 51514 }, -- Hex (Skeletal Hatchling)
        [277778] = { type = CROWD_CONTROL, originalID = 51514 }, -- Hex (Zandalari Tendonripper)
        [277784] = { type = CROWD_CONTROL, originalID = 51514 }, -- Hex (Wicker Mongrel)
    [79206] = { type = DAMAGE_REDUCTION }, -- Spiritwalker's Grace 60 * OTHER
    [108281] = { type = DAMAGE_REDUCTION }, -- Ancestral Guidance
    [16166] = { type = DAMAGE_INCREASE }, -- Elemental Mastery
    [64695] = { type = ROOT }, -- Earthgrab Totem
    [77505] = { type = CROWD_CONTROL }, -- Earthquake (Stun)
    [98008] = { type = DAMAGE_REDUCTION }, -- Spirit Link Totem
    [108271] = { type = DAMAGE_REDUCTION }, -- Astral Shift
        [210918] = { type = DAMAGE_REDUCTION, originalID = 108271 }, -- Ethereal Form
    [114050] = { type = DAMAGE_REDUCTION }, -- Ascendance (Elemental)
        [114051] = { type = DAMAGE_INCREASE, originalID = 114050 }, -- Ascendance (Enhancement)
        [114052] = { type = DAMAGE_REDUCTION, originalID = 114050 }, -- Ascendance (Restoration)
    [118345] = { type = CROWD_CONTROL }, -- Pulverize
    [118905] = { type = CROWD_CONTROL }, -- Static Charge
    [197214] = { type = CROWD_CONTROL }, -- Sundering
    [204293] = { type = DAMAGE_REDUCTION }, -- Spirit Link
    [204366] = { type = DAMAGE_INCREASE }, -- Thundercharge
    [204945] = { type = DAMAGE_INCREASE }, -- Doom Winds
    [260878] = { type = DAMAGE_REDUCTION }, -- Spirit Wolf
    [8178] = { type = IMMUNITY }, -- Grounding
        [255016] = { type = IMMUNITY, originalID = 8178 }, -- Grounding
        [204336] = { type = IMMUNITY, originalID = 8178 }, -- Grounding
        [34079] = { type = IMMUNITY, originalID = 8178 }, -- Grounding

    -- Warlock / ok, no slow

    [710] = { type = CROWD_CONTROL }, -- Banish
    [5484] = { type = CROWD_CONTROL }, -- Howl of Terror
    [6358] = { type = CROWD_CONTROL }, -- Seduction
        [115268] = { type = CROWD_CONTROL, originalID = 6358 }, -- Mesmerize
    [6789] = { type = CROWD_CONTROL }, -- Mortal Coil
    -- [20707] = { type = DAMAGE_REDUCTION }, -- Soulstone
    -- [22703] = { type = CROWD_CONTROL }, -- Infernal Awakening (infernal summon)
    [30283] = { type = STUN }, -- Shadowfury
    [89751] = { type = DAMAGE_INCREASE }, -- Felstorm
        [115831] = { type = DAMAGE_INCREASE, originalID = 89751 }, -- Wrathstorm
    [89766] = { type = STUN }, -- Axe Toss
    [104773] = { type = IMMUNITY }, -- Unending Resolve
    [108416] = { type = DAMAGE_REDUCTION }, -- Dark Pact
    [113860] = { type = DAMAGE_INCREASE }, -- Dark Soul: Misery (Affliction)
    [113858] = { type = DAMAGE_INCREASE }, -- Dark Soul: Instability (Demonology)
    [118699] = { type = CROWD_CONTROL }, -- Fear
        [130616] = { type = CROWD_CONTROL, originalID = 118699 }, -- Fear (Glyph of Fear)
    [171017] = { type = CROWD_CONTROL }, -- Meteor Strike
    [196098] = { type = DAMAGE_INCREASE }, -- Soul Harvest
    [196364] = { type = SILENCE }, -- Unstable Affliction (Silence)
    [233490] = { type = ANTI_DISPEL }, -- Unstable Affliction applications
    [233496] = { type = ANTI_DISPEL, originalID = 233490 }, -- Unstable Affliction applications
    [233497] = { type = ANTI_DISPEL, originalID = 233490 }, -- Unstable Affliction applications
    [233498] = { type = ANTI_DISPEL, originalID = 233490 }, -- Unstable Affliction applications
    [233499] = { type = ANTI_DISPEL, originalID = 233490 }, -- Unstable Affliction applications
    [212284] = { type = DAMAGE_INCREASE }, -- Firestone
    [212295] = { type = IMMUNITY }, -- Nether Ward

    -- Warrior / good, maybe more slow?

    [871] = { type = DAMAGE_REDUCTION }, -- Shield Wall
    [1719] = { type = DAMAGE_INCREASE }, -- Recklessness
    [5246] = { type = CROWD_CONTROL }, -- Intimidating Shout
    [12975] = { type = DAMAGE_REDUCTION }, -- Last Stand
    [18499] = { type = EFFECT_IMMUNITY }, -- Berserker Rage
    [23920] = { type = IMMUNITY }, -- Spell Reflection
        -- [213915] = { type = IMMUNITY, originalID = 23920 }, -- Mass Spell Reflection
        [216890] = { type = IMMUNITY, originalID = 23920 }, -- Spell Reflection (Arms, Fury)
    [46968] = { type = STUN }, -- Shockwave
    [97462] = { type = DAMAGE_REDUCTION }, -- Rallying Cry
    [105771] = { type = ROOT }, -- Charge (Warrior)
    [107574] = { type = DAMAGE_INCREASE }, -- Avatar
    [118038] = { type = DAMAGE_REDUCTION }, -- Die by the Sword
    [107570] = { type = STUN }, -- Storm Bolt
    -- [184364] = { type = DAMAGE_REDUCTION }, -- Enraged Regeneration
    [197690] = { type = DAMAGE_REDUCTION }, -- Defensive Stance
    [213871] = { type = DAMAGE_REDUCTION }, -- Bodyguard
    [227847] = { type = IMMUNITY }, -- Bladestorm (Arms)
        [46924] = { type = IMMUNITY, originalID = 227847 }, -- Bladestorm (Fury)
        -- [152277] = { type = IMMUNITY, originalID = 227847 }, -- Ravager
    [228920] = { type = DAMAGE_REDUCTION }, -- Ravager
    [236077] = { type = DAMAGE_DECREASE }, -- Disarm
    [1715] = { type = SLOW }, -- Hamstring
}
data = lib.data


-----------------------
-- CLASSIC
-----------------------

elseif isClassic then


lib.data = lib.data or {}
data = lib.data

local function A( id, opts )
    if type(id) == "table" then
        for i, spellID in ipairs(id) do
            data[spellID] = opts
        end
        if #id > 2 then
            opts.originalID = id[1]
        end
    else
        data[id] = opts
    end
end


--MISC
A( 23451 ,{ type = SPEED_BOOST }) -- Battleground Speed buff
A( 23493 ,{ type = DAMAGE_REDUCTION }) -- Battleground Heal buff
A( 23505 ,{ type = DAMAGE_INCREASE }) -- Battleground Damage buff
A( 6615 ,{ type = EFFECT_IMMUNITY }) -- Free Action Potion
A( 24364 ,{ type = EFFECT_IMMUNITY }) -- Living Action Potion
A( 3169 ,{ type = IMMUNITY }) -- Limited Invulnerability Potion
A( 16621 ,{ type = IMMUNITY }) -- Invulnerable Mail
A( 1090 ,{ type = CROWD_CONTROL }) -- Magic Dust
A( 13327 ,{ type = INCAP }) -- Reckless Charge
A({ 26740, 13181 }, { type = CROWD_CONTROL }) -- Mind Control Cap + Backfire
A( 835 ,{ type = STUN }) -- Tidal Charm
A( 11359 ,{ type = EFFECT_IMMUNITY }) -- Restorative Potion, Removes 1 magic, curse, poison or disease effect on you every 5 seconds for 30 seconds.
A( 6727 ,{ type = EFFECT_IMMUNITY }) -- Violet Tragan -- probably wrong id
A( 5024 ,{ type = EFFECT_IMMUNITY }) -- Skull of Impending Doom
A( 2379 ,{ type = SPEED_BOOST }) -- Swiftness Potion
A({ 13099, 13138, 16566 }, { type = CROWD_CONTROL }) -- Net-o-matic + Backfire
A( 5134 ,{ type = CROWD_CONTROL }) -- Flash Bomb
A( 23097 ,{ type = ATTENTION }) -- Fire Reflector
A( 23131 ,{ type = ATTENTION }) -- Frost Reflector
A( 23132 ,{ type = ATTENTION }) -- Shadow Reflector
A( 19769 ,{ type = INCAP }) -- Thorium Grenade
A( 4068 ,{ type = INCAP }) -- Iron Grenade
A( 1604 ,{ type = SLOW }) -- Common Daze
A({ 23333, 23335 }, { type = ATTENTION }) -- Warsong Flag
A({ 25750, 25747, 25746, 23991 }, { type = DAMAGE_ABSORB }) -- AB Trinkets
A( 23506 ,{ type = DAMAGE_ABSORB }) -- Arena Grand Master trinket
A( 29506 ,{ type = DAMAGE_ABSORB }) -- Burrower's Shell trinket
A( 12733 ,{ type = EFFECT_IMMUNITY }) -- Blacksmith trinket, Fear immunity
A( 15753 ,{ type = STUN }) -- Linken's Boomerang stun
A( 15752 ,{ type = DAMAGE_DECREASE }) -- Linken's Boomerang disarm
A( 14530 ,{ type = SPEED_BOOST }) -- Nifty Stopwatch
A( 13237 ,{ type = STUN }) -- Goblin Mortar trinket
A( 14253 ,{ type = EFFECT_IMMUNITY }) -- Black Husk Shield
A( 9175 ,{ type = SPEED_BOOST }) -- Swift Boots
A( 13141 ,{ type = SPEED_BOOST }) -- Gnomish Rocket Boots
A( 8892 ,{ type = SPEED_BOOST }) -- Goblin Rocket Boots
A( 9774 ,{ type = EFFECT_IMMUNITY }) -- Spider Belt & Ornate Mithril Boots




-- RACIALS

A( 23230 ,{ type = HEALING_REDUCTION }) -- Blood Fury Debuff
A( 20594 ,{ type = EFFECT_IMMUNITY }) -- Stoneform, Immune to Bleed, Poison, and Disease.
A( 20549 ,{ type = STUN }) -- War Stomp
A( 7744 ,{ type = EFFECT_IMMUNITY }) -- Will of the Forsaken, Immune to Charm, Fear, and Sleep.
A({ 9035, 19281, 19282, 19283, 19284, 19285 }, { type = HEALING_REDUCTION }) -- Hex of Weakness
A( 20600 ,{ type = EFFECT_IMMUNITY }) -- Perception



-- WARLOCK

A( 24259 ,{ type = SILENCE }) -- Spell Lock Silence
A( 6358, { type = CROWD_CONTROL }) -- Seduction
A({ 5782, 6213, 6215 }, { type = CROWD_CONTROL }) -- Fear
A({ 5484, 17928 }, { type = CROWD_CONTROL }) -- Howl of Terror
A({ 710, 18647 }, { type = CROWD_CONTROL }) -- Banish
A({ 6789, 17925, 17926 }, { type = CROWD_CONTROL }) -- Death Coil
A( 18223 ,{ type = SLOW }) -- Curse of Exhaustion
A( 18118 ,{ type = SLOW }) -- Aftermath (Destruction Talent)
A({ 1714, 11719 }, { type = DAMAGE_DECREASE }) -- Curse of Tongues
A({ 6229, 11739, 11740, 28610 } ,{ type = DAMAGE_ABSORB }) -- Shadow Ward
A({ 7812, 19438, 19440, 19441, 19442, 19443 } ,{ type = DAMAGE_ABSORB }) -- Sacrifice
A( 18093 ,{ type = STUN }) -- Pyroclasm


-- SHAMAN

A({ 8056, 8058, 10472, 10473 }, { type = SLOW }) -- Frost Shock
A( 3600 ,{ type = SLOW }) -- Earthbind
A({ 8034, 8037, 10458, 16352, 16353  }, { type = SLOW }) -- Frostbrand Attack
-- Lightning shield??
A( 8178 ,{ type = IMMUNITY }) -- Grounding Totem Effect
-- A( 2645 ,{ type = SPEED_BOOST }) -- Ghost Wolf

-- PALADIN

A({ 1022, 5599, 10278 }, { type = IMMUNITY }) -- Blessing of Protection
A({ 498, 5573, 642, 1020 }, { type = IMMUNITY }) -- Divine Shield
A({ 853, 5588, 5589, 10308 }, { type = STUN }) -- Hammer of Justice
A( 1044 ,{ type = SPEED_BOOST }) -- Blessing of Freedom
A( 20066 ,{ type = INCAP }) -- Repentance
A( 20170 ,{ type = STUN }) -- Seal of Justice stun

-- HUNTER


A( 13159 ,{ type = SPEED_BOOST }) -- Aspect of the Pack
A( 5118 ,{ type = SPEED_BOOST }) -- Aspect of the Cheetah
A( 15571 ,{ type = SLOW }) -- Daze from Aspect of Cheetah/Pack
A({ 1513, 14326, 14327 }, { type = CROWD_CONTROL }) -- Scare Beast
A( 5116 ,{ type = SLOW }) -- Concussive Shot
A( 19410 ,{ type = STUN }) -- Concussive Shot Stun
A({ 1130, 14323, 14324, 14325 }, { type = DAMAGE_VULNERABILITY }) -- Hunter's Mark
A( 3045 ,{ type = DAMAGE_INCREASE }) -- Rapid Fire
-- A( 19574 ,{ type = DAMAGE_INCREASE }) -- Bestial Wrath
A( 19263 ,{ type = DAMAGE_REDUCTION }) -- Deterrence
A( 13810 ,{ type = SLOW }) -- Frost Trap Aura
A({ 3355, 14308, 14309 }, { type = CROWD_CONTROL }) -- Freezing Trap
A({ 2974, 14267, 14268 }, { type = SLOW }) -- Wing Clip
A( 19229, { type = ROOT }) -- Wing Clip Root
A({ 19306, 20909, 20910 }, { type = ROOT }) -- Counterattack Root
A( 24394 ,{ type = STUN }) -- Intimidation
A({ 19386, 24132, 24133 }, { type = CROWD_CONTROL }) --Wyvern Sting
A( 19185 ,{ type = ROOT }) -- Entrapment
-- A({ 3034, 14279, 14280}, { type = TRASH }) -- Viper Sting
A( 19503 ,{ type = CROWD_CONTROL }) -- Scatter Shot
A( 25999 ,{ type = ROOT }) -- Boar Charge

-- DRUID

A( 22812 ,{ type = DAMAGE_REDUCTION }) -- Barkskin
A( 19975 ,{ type = ROOT }) -- Nature's Grasp
A({ 339, 1062, 5195, 5196, 9852, 9853 }, { type = ROOT }) -- Entangling Roots
A({ 770, 778, 9749, 9907, 17390, 17391, 17392 }, { type = DAMAGE_VULNERABILITY }) -- Faerie Fire
A({ 2637, 18657, 18658 }, { type = CROWD_CONTROL }) -- Hibernate
A( 29166, { type = TRASH }) -- Innervate
A({ 9005, 9823, 9827 }, { type = STUN }) -- Pounce Stun
A( 16922, { type = STUN }) -- Starfire Stun
-- A({ 5217, 6793, 9845, 9846 }, { type = DAMAGE_INCREASE }) -- Tiger's Fury
A({ 5211, 6798, 8983 }, { type = STUN }) -- Bash
A( 16979 ,{ type = ROOT }) -- Feral Charge
-- A( 2893 ,{ type = TRASH }) -- Abolish Poison
A({ 1850, 9821 }, { type = SPEED_BOOST }) -- Dash
A({ 16689, 16810, 16811, 16812, 16813, 17329}, { type = ATTENTION }) -- Nature's Grasp Buff
A({ 783, 1066 }, { type = SPEED_BOOST }) -- Travel Form & Aquatic Form

-- MAGE

A( 18469 ,{ type = SILENCE }) -- Improved Counterspell
A({ 118, 12824, 12825, 12826, 28270, 28271, 28272 }, { type = CROWD_CONTROL }) -- Polymorph
A({ 11426, 13031, 13032, 13033 }, { type = DAMAGE_ABSORB }) -- Ice Barrier
A({ 543, 8457, 8458, 10223, 10225 }, { type = DAMAGE_ABSORB}) -- Fire Ward
A({ 6143, 8461, 8462, 10177, 28609 }, { type = DAMAGE_ABSORB}) -- Frost Ward
A( 12355 ,{ type = STUN }) -- Impact
A( 22959 ,{ type = TRASH }) -- Fire Vulnerability
A({ 11113, 13018, 13019, 13020, 13021 }, { type = SLOW }) -- Blast Wave
A({ 120, 8492, 10159, 10160, 10161 }, { type = SLOW }) -- Cone of Cold
A({ 12484, 12485, 12486 }, { type = SLOW }) -- Improved Blizzard
A({ 6136, 7321 }, { type = SLOW }) -- Frost Armor Chill
A({ 116, 205, 837, 7322, 8406, 8407, 8408, 10179, 10180, 10181, 25304 }, { type = SLOW }) -- Frostbolt
A( 12494 ,{ type = FROZEN }) -- Frostbite
A({ 122, 865, 6131, 10230 }, { type = FROZEN }) -- Frost Nova
A( 12042 ,{ type = DAMAGE_INCREASE }) -- Arcane Power
A( 11958 ,{ type = IMMUNITY }) -- Ice Block
A( 12579 ,{ type = TRASH }) -- Winter's Chill
A({ 133, 143, 145, 3140, 8400, 8401, 8402, 10148, 10149, 10150, 10151, 25306 }, { type = TRASH }) -- Fireball dot
A({ 11366, 12505, 12522, 12523, 12524, 12525, 12526, 18809 }, { type = TRASH }) -- Pyroblast dot
A( 12051 ,{ type = ATTENTION }) -- Evocation
A({ 1463, 8494, 8495, 10191, 10192, 10193 }, { type = DAMAGE_ABSORB }) -- Mana Shield

-- PRIEST

A( 15487, { type = SILENCE }) -- Silence
A( 10060, { type = DAMAGE_INCREASE }) -- Power Infusion
A({ 17, 592, 600, 3747, 6065, 6066, 10898, 10899, 10900, 10901 }, { type = DAMAGE_ABSORB }) -- Power Word: Shield
A({ 8122, 8124, 10888, 10890 }, { type = CROWD_CONTROL }) -- Psychic Scream
A( 15269 ,{ type = STUN }) -- Blackout
A({ 15407, 17311, 17312, 17313, 17314, 18807 }, { type = SLOW }) -- Mind Flay
A( 15258 ,{ type = TRASH }) -- Shadow Vulnerability
A({ 605, 10911, 10912 }, { type = CROWD_CONTROL }) -- Mind Control

-- ROGUE

A( 18425 ,{ type = SILENCE }) -- Improved Kick
A( 13750 ,{ type = DAMAGE_INCREASE }) -- Adrenaline Rush
A( 13877 ,{ type = DAMAGE_INCREASE }) -- Blade Flurry
A( 1833 , { type = STUN }) -- Cheap Shot
A({ 408, 8643 }, { type = STUN }) -- Kidney Shot
A({ 2070, 6770, 11297 }, { type = INCAP }) -- Sap
A( 2094 , { type = CROWD_CONTROL }) -- Blind
-- A({ 8647, 8649, 8650, 11197, 11198 }, { type = DAMAGE_VULNERABILITY }) -- Expose Armor
A({ 2983, 8696, 11305 }, { type = SPEED_BOOST }) -- Sprint
A( 5277 ,{ type = DAMAGE_REDUCTION }) -- Evasion
A({ 1776, 1777, 8629, 11285, 11286 }, { type = INCAP }) -- Gouge
A({ 3409, 11201 }, { type = ROOT }) -- Crippling Poison NOTE: it's a slow but we prio it as root because its 70% and better than all other slows
A( 14251 ,{ type = DAMAGE_DECREASE }) -- Riposte (Disarm)
A( 14278 ,{ type = DAMAGE_REDUCTION }) -- Ghostly Strike

-- WARRIOR

A( 18498 ,{ type = SILENCE }) -- Improved Shield Bash
A( 20230 ,{ type = IMMUNITY }) -- Retaliation
A( 1719 ,{ type = EFFECT_IMMUNITY }) -- Recklessness, Fear immunity
A( 871, { type = DAMAGE_REDUCTION }) -- Shield Wall
A( 12328, { type = EFFECT_IMMUNITY }) -- Death Wish, Fear immunity
A({ 1715, 7372, 7373 }, { type = SLOW }) -- Hamstring
A( 23694 , { type = ROOT }) -- Improved Hamstring
A( 12323, { type = SLOW }) -- Piercing Howl
-- Thunder Clap?
A( 18499, { type = EFFECT_IMMUNITY }) -- Berserker Rage
A({ 20253, 20614, 20615 }, { type = STUN }) -- Intercept Stun
A({ 5246, 20511 }, { type = CROWD_CONTROL }) -- Intimidating Shout
A( 676 ,{ type = DAMAGE_DECREASE }) -- Disarm
A( 12798 , { type = STUN }) -- Revenge Stun
A( 12809 ,{ type = STUN }) -- Concussion Blow
A({ 16488, 16490, 16491 }, { type = TRASH }) -- Blood Craze
A({ 12294, 21551, 21552, 21553 }, { type = HEALING_REDUCTION }) -- Mortal Strike
A( 7922 ,{ type = STUN }) -- Charge Stun
A( 5530 ,{ type = STUN }) -- Mace Spec. Stun (Warrior & Rogue)

end


function lib.GetDebuffInfo(spellID)
    if data[spellID] then
        local spellData = data[spellID]
        local spellType = spellData.type
        if spellData.originalID then spellID = spellData.originalID end
        local prio = priority[spellType]
        return spellID, spellType, prio
    end
end

function lib.GetDebuffTypePriority(dType)
    return priority[dType]
end