--[================[
LibAuraTypes-1.0
Author: d87
Description: Provides aura classification and priority
--]================]


local MAJOR, MINOR = "LibAuraTypes", 8
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end


local CROWD_CONTROL = "CROWD_CONTROL"
local STUN = "STUN"
local INCAP = "INCAP"
local FROZEN = "FROZEN"
local SILENCE = "SILENCE"
local ROOT = "ROOT"
local SLOW = "SLOW"
local ANTI_DISPEL = "ANTI_DISPEL"
local SPEED_BOOST = "SPEED_BOOST"
local IMMUNITY = "IMMUNITY"
local DAMAGE_REDUCTION = "DAMAGE_REDUCTION"
local DAMAGE_ABSORB = "DAMAGE_ABSORB"
local DAMAGE_VULNERABILITY = "DAMAGE_VULNERABILITY"
local DAMAGE_INCREASE = "DAMAGE_INCREASE"
local DAMAGE_DECREASE = "DAMAGE_DECREASE"
local TRASH = "TRASH"
local EFFECT_IMMUNITY = "EFFECT_IMMUNITY"
local PHYSICAL_IMMUNITY = "PHYSICAL_IMMUNITY"
local SPELL_IMMUNITY = "SPELL_IMMUNITY"
local INTERRUPT_IMMUNITY = "INTERRUPT_IMMUNITY"
local FEAR_IMMUNITY = "FEAR_IMMUNITY"
local ROOT_IMMUNITY = "ROOT_IMMUNITY"
local CROWD_CONTROL_IMMUNITY = "CROWD_CONTROL_IMMUNITY"
local HEALING_REDUCTION = "HEALING_REDUCTION"
local ATTENTION = "ATTENTION"
local STEALTH_DETECTION = "STEALTH_DETECTION"

lib.friendlyPriority = {
    ATTENTION = 95,
    IMMUNITY = 90,
    STUN = 85,
    CROWD_CONTROL_IMMUNITY = 60,
    ANTI_DISPEL = 10,
    PHYSICAL_IMMUNITY = 65,
    SPELL_IMMUNITY = 65,

    CROWD_CONTROL = 70,

    -- Don't care about these on friendly
    INTERRUPT_IMMUNITY = 10,
    FEAR_IMMUNITY = 10,
    EFFECT_IMMUNITY = 31,
    ROOT_IMMUNITY = 25,

    INCAP = 68,
    SILENCE = 65,
    FROZEN = 46,
    ROOT = 45,

    DAMAGE_REDUCTION = 40,
    DAMAGE_ABSORB = 1,
    DAMAGE_VULNERABILITY = 37,

    DAMAGE_INCREASE = 10,
    DAMAGE_DECREASE = 9,

    SLOW = 30,
    SPEED_BOOST = 25,
    HEALING_REDUCTION = 2, -- increased for healers
    STEALTH_DETECTION = 0,
    TRASH = -1,
}
local friendlyPriority = lib.friendlyPriority

lib.enemyPriority = {
    ATTENTION = 95,
    IMMUNITY = 90,
    STUN = 85,
    ANTI_DISPEL = 0, ------------
    CROWD_CONTROL_IMMUNITY = 80,
    PHYSICAL_IMMUNITY = 65,
    SPELL_IMMUNITY = 65,

    CROWD_CONTROL = 70,
    INCAP = 69,
    SILENCE = 67,

    INTERRUPT_IMMUNITY = 55,
    FEAR_IMMUNITY = 20,
    EFFECT_IMMUNITY = 50,
    ROOT_IMMUNITY = 50,


    FROZEN = 46,
    ROOT = 45,

    DAMAGE_REDUCTION = 55,
    DAMAGE_ABSORB = 38,
    DAMAGE_VULNERABILITY = 37,

    DAMAGE_INCREASE = 35,
    DAMAGE_DECREASE = 34,

    SLOW = 30,
    SPEED_BOOST = 25,
    HEALING_REDUCTION = 1,
    STEALTH_DETECTION = 1, -- increased for stealth classes
    TRASH = -1,
}
local enemyPriority = lib.enemyPriority

local data

local isClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC


local playerClass = select(2, UnitClass('player'))
if playerClass == "ROGUE" then
    enemyPriority[STEALTH_DETECTION] = 60
    enemyPriority[PHYSICAL_IMMUNITY] = 90
elseif playerClass == "DRUID" then
    enemyPriority[STEALTH_DETECTION] = 60
    friendlyPriority[HEALING_REDUCTION] = 28
    friendlyPriority[ANTI_DISPEL] = 70
elseif playerClass == "PRIEST" then
    enemyPriority[FEAR_IMMUNITY] = 80
    friendlyPriority[HEALING_REDUCTION] = 28
    friendlyPriority[ANTI_DISPEL] = 70
elseif playerClass == "SHAMAN" then
    friendlyPriority[HEALING_REDUCTION] = 28
    friendlyPriority[ANTI_DISPEL] = 70
elseif playerClass == "PALADIN" then
    friendlyPriority[HEALING_REDUCTION] = 28
    friendlyPriority[ANTI_DISPEL] = 70
elseif playerClass == "MONK" then
    friendlyPriority[HEALING_REDUCTION] = 28
    friendlyPriority[ANTI_DISPEL] = 70
elseif playerClass == "MAGE" then
    enemyPriority[FROZEN] = 60
elseif playerClass == "WARLOCK" then
    enemyPriority[FEAR_IMMUNITY] = 80
elseif playerClass == "WARRIOR" then
    enemyPriority[SLOW] = 39
    enemyPriority[FEAR_IMMUNITY] = 55
    enemyPriority[PHYSICAL_IMMUNITY] = 90
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
if not isClassic then

lib.data = {
    -- [25163] = { ATTENTION }, -- Oozeling's Aura

    [115804] = { HEALING_REDUCTION }, -- Mortal Wounds
    [8680] = { HEALING_REDUCTION }, -- Wound Poison
    [197046] = { HEALING_REDUCTION }, -- Minor Wound Poison

    -- DEATH KNIGHT

    [47476] = { CROWD_CONTROL }, -- Strangulate
    [48707] = { IMMUNITY }, -- Anti-Magic Shell
    [48265] = { DAMAGE_REDUCTION }, -- Death's Advance
    [48792] = { DAMAGE_REDUCTION }, -- Icebound Fortitude
    [81256] = { DAMAGE_REDUCTION }, -- Dancing Rune Weapon
    [51271] = { DAMAGE_INCREASE }, -- Pillar of Frost
    [55233] = { DAMAGE_REDUCTION }, -- Vampiric Blood
    [77606] = { ATTENTION }, -- Dark Simulacrum
    [91797] = { CROWD_CONTROL }, -- Monstrous Blow
    [91800] = { CROWD_CONTROL }, -- Gnaw
    [108194] = { CROWD_CONTROL }, -- Asphyxiate
        [221562] = { CROWD_CONTROL, originalID = 108194 }, -- Asphyxiate (Blood)
    [152279] = { DAMAGE_INCREASE }, -- Breath of Sindragosa
    [194679] = { DAMAGE_REDUCTION }, -- Rune Tap
    [194844] = { DAMAGE_REDUCTION }, -- Bonestorm
    [204080] = { ROOT }, -- Frostbite
    [206977] = { DAMAGE_REDUCTION }, -- Blood Mirror
    [207127] = { DAMAGE_INCREASE }, -- Hungering Rune Weapon
    [207167] = { CROWD_CONTROL }, -- Blinding Sleet
    [207171] = { CROWD_CONTROL }, -- Winter is Coming
    [207256] = { DAMAGE_INCREASE }, -- Obliteration
    [207289] = { DAMAGE_INCREASE }, -- Unholy Frenzy
    [212332] = { CROWD_CONTROL }, -- Smash
        [212337] = { CROWD_CONTROL, originalID = 212332 }, -- Powerful Smash
    [212552] = { DAMAGE_REDUCTION }, -- Wraith Walk
    [219809] = { DAMAGE_REDUCTION }, -- Tombstone
    [223929] = { HEALING_REDUCTION }, -- Necrotic Wound

    -- Demon Hunter

    [179057] = { CROWD_CONTROL }, -- Chaos Nova
    [187827] = { DAMAGE_REDUCTION }, -- Metamorphosis
    [188499] = { DAMAGE_REDUCTION }, -- Blade Dance
    [188501] = { STEALTH_DETECTION }, -- Spectral Sight
    [204490] = { CROWD_CONTROL }, -- Sigil of Silence
    [205629] = { DAMAGE_REDUCTION }, -- Demonic Trample
    [205630] = { CROWD_CONTROL }, -- Illidan's Grasp
    [206649] = { ATTENTION }, -- Eye of Leotheras
    [207685] = { CROWD_CONTROL }, -- Sigil of Misery
    [207810] = { DAMAGE_REDUCTION }, -- Nether Bond
    [211048] = { DAMAGE_INCREASE }, -- Chaos Blades
    [211881] = { CROWD_CONTROL }, -- Fel Eruption
    [212800] = { DAMAGE_REDUCTION }, -- Blur
        [196555] = { DAMAGE_REDUCTION }, -- Netherwalk
    [218256] = { DAMAGE_REDUCTION }, -- Empower Wards
    [221527] = { CROWD_CONTROL }, -- Imprison (Detainment Honor Talent)
        [217832] = { CROWD_CONTROL, originalID = 221527 }, -- Imprison (Baseline Undispellable)
    [227225] = { DAMAGE_REDUCTION }, -- Soul Barrier

    -- Druid / probably good, no slow

    [99] = { CROWD_CONTROL }, -- Incapacitating Roar
    [339] = { ROOT }, -- Entangling Roots
    [740] = { DAMAGE_REDUCTION }, -- Tranquility
    [1850] = { SPEED_BOOST }, -- Dash
        [252216] = { SPEED_BOOST, originalID = 1850 }, -- Tiger Dash
    [2637] = { CROWD_CONTROL }, -- Hibernate
    [5211] = { STUN }, -- Mighty Bash
    [5217] = { DAMAGE_INCREASE }, -- Tiger's Fury
    [22812] = { DAMAGE_REDUCTION }, -- Barkskin
    -- [22842] = { DAMAGE_REDUCTION }, -- Frenzied Regeneration
    -- [29166] = { DAMAGE_INCREASE }, -- Innervate
    [33891] = { DAMAGE_INCREASE }, -- Incarnation: Tree of Life
    [45334] = { ROOT }, -- Wild Charge
    [61336] = { DAMAGE_REDUCTION }, -- Survival Instincts
    [81261] = { SILENCE }, -- Solar Beam
    [102342] = { DAMAGE_REDUCTION }, -- Ironbark
    [102359] = { ROOT }, -- Mass Entanglement
    [279642] = { DAMAGE_INCREASE }, -- Lively Spirit
    [102543] = { DAMAGE_INCREASE }, -- Incarnation: King of the Jungle
    [102558] = { DAMAGE_INCREASE }, -- Incarnation: Guardian of Ursoc
    [102560] = { DAMAGE_INCREASE }, -- Incarnation: Chosen of Elune
    [106951] = { DAMAGE_INCREASE }, -- Berserk
    [155835] = { DAMAGE_REDUCTION }, -- Bristling Fur
    [192081] = { DAMAGE_REDUCTION }, -- Ironfur
    [163505] = { STUN }, -- Rake
    [194223] = { DAMAGE_INCREASE }, -- Celestial Alignment
    [200851] = { DAMAGE_REDUCTION }, -- Rage of the Sleeper
    [202425] = { DAMAGE_INCREASE }, -- Warrior of Elune
    [204399] = { STUN }, -- Earthfury
    [204437] = { STUN }, -- Lightning Lasso

    [209749] = { DAMAGE_DECREASE }, -- Faerie Swarm (Slow/Disarm)
    [209753] = { CROWD_CONTROL, priority = true }, -- Cyclone
        [33786] = { CROWD_CONTROL, originalID = 209753 }, -- Cyclone
    [22570] = { STUN }, -- Maim
    [236696] = { DAMAGE_REDUCTION }, -- Thorns (PvP Talent)
    [232559] = { SLOW }, -- Thorns Slow (PvP Talent)


    -- Hunter

    [136] = { DAMAGE_REDUCTION }, -- Mend Pet
    [3355] = { CROWD_CONTROL }, -- Freezing Trap
        [203340] = { CROWD_CONTROL }, -- Diamond Ice (Survival Honor Talent)
    [5384] = { DAMAGE_REDUCTION }, -- Feign Death
    [19386] = { CROWD_CONTROL }, -- Wyvern Sting
    [19574] = { DAMAGE_INCREASE }, -- Bestial Wrath
    [19577] = { CROWD_CONTROL }, -- Intimidation
        [24394] = { CROWD_CONTROL, originalID = 19577 }, -- Intimidation
    [53480] = { DAMAGE_REDUCTION }, -- Roar of Sacrifice (Hunter Pet Skill)
    [117526] = { ROOT }, -- Binding Shot
    [131894] = { DAMAGE_INCREASE }, -- A Murder of Crows (Beast Mastery, Marksmanship)
        [206505] = { DAMAGE_INCREASE, originalID = 131894 }, -- A Murder of Crows (Survival)
    [186265] = { DAMAGE_REDUCTION }, -- Aspect of the Turtle
    [186289] = { DAMAGE_INCREASE }, -- Aspect of the Eagle
    [238559] = { CROWD_CONTROL }, -- Bursting Shot
        [186387] = { CROWD_CONTROL, originalID = 238559 }, -- Bursting Shot
    [193526] = { DAMAGE_INCREASE }, -- Trueshot
    [193530] = { DAMAGE_INCREASE }, -- Aspect of the Wild
    [199483] = { DAMAGE_REDUCTION }, -- Camouflage
    [202914] = { CROWD_CONTROL }, -- Spider Sting (Armed)
        [202933] = { CROWD_CONTROL, originalID = 202914 }, -- Spider Sting (Silenced)
        [233022] = { CROWD_CONTROL, originalID = 202914 }, -- Spider Sting (Silenced)
    [209790] = { CROWD_CONTROL }, -- Freezing Arrow
    [209997] = { DAMAGE_REDUCTION }, -- Play Dead
    [213691] = { CROWD_CONTROL }, -- Scatter Shot
    [272682] = { DAMAGE_REDUCTION }, -- Master's Call

    -- Mage / ok, no slow

    [66] = { DAMAGE_INCREASE }, -- Invisibility
        [110959] = { DAMAGE_INCREASE, originalID = 66 }, -- Greater Invisibility
    -- [118] = { CROWD_CONTROL }, -- Polymorph
    --     [28271] = { CROWD_CONTROL, originalID = 118 }, -- Polymorph Turtle
    --     [28272] = { CROWD_CONTROL, originalID = 118 }, -- Polymorph Pig
    --     [61025] = { CROWD_CONTROL, originalID = 118 }, -- Polymorph Serpent
    --     [61305] = { CROWD_CONTROL, originalID = 118 }, -- Polymorph Black Cat
    --     [61721] = { CROWD_CONTROL, originalID = 118 }, -- Polymorph Rabbit
    --     [61780] = { CROWD_CONTROL, originalID = 118 }, -- Polymorph Turkey
    --     [126819] = { CROWD_CONTROL, originalID = 118 }, -- Polymorph Porcupine
    --     [161353] = { CROWD_CONTROL, originalID = 118 }, -- Polymorph Polar Bear Cub
    --     [161354] = { CROWD_CONTROL, originalID = 118 }, -- Polymorph Monkey
    --     [161355] = { CROWD_CONTROL, originalID = 118 }, -- Polymorph Penguin
    --     [161372] = { CROWD_CONTROL, originalID = 118 }, -- Polymorph Peacock
    --     [277787] = { CROWD_CONTROL, originalID = 118 }, -- Polymorph Direhorn
    --     [277792] = { CROWD_CONTROL, originalID = 118 }, -- Polymorph Bumblebee
    [122] = { ROOT }, -- Frost Nova
        [33395] = { ROOT, originalID = 122 }, -- Freeze
    [11426] = { DAMAGE_REDUCTION }, -- Ice Barrier
    [12042] = { DAMAGE_INCREASE }, -- Arcane Power
    [12051] = { DAMAGE_INCREASE }, -- Evocation
    [12472] = { DAMAGE_INCREASE }, -- Icy Veins
        [198144] = { DAMAGE_INCREASE, originalID = 12472 }, -- Ice Form
    [31661] = { CROWD_CONTROL }, -- Dragon's Breath
    [45438] = { IMMUNITY }, -- Ice Block
        [41425] = { TRASH }, -- Hypothermia
    [80353] = { DAMAGE_INCREASE }, -- Time Warp
    [82691] = { CROWD_CONTROL }, -- Ring of Frost
    [108839] = { DAMAGE_INCREASE }, -- Ice Floes
    [157997] = { ROOT }, -- Ice Nova
    [190319] = { DAMAGE_INCREASE }, -- Combustion
    [198111] = { DAMAGE_REDUCTION }, -- Temporal Shield
    [198158] = { DAMAGE_INCREASE }, -- Mass Invisibility
    [198064] = { DAMAGE_REDUCTION }, -- Prismatic Cloak
        [198065] = { DAMAGE_REDUCTION, originalID = 198064 }, -- Prismatic Cloak
    [205025] = { DAMAGE_INCREASE }, -- Presence of Mind
    [228600] = { ROOT }, -- Glacial Spike Root

    -- Monk / good

    [115078] = { CROWD_CONTROL }, -- Paralysis
    [115080] = { DAMAGE_VULNERABILITY }, -- Touch of Death
    [120954] = { DAMAGE_REDUCTION }, -- Fortifying Brew (Brewmaster)
        [201318] = { DAMAGE_REDUCTION, originalID = 120954 }, -- Fortifying Brew (Windwalker PvP Talent)
        [243435] = { DAMAGE_REDUCTION, originalID = 120954 }, -- Fortifying Brew (Mistweaver)
    [116095] = { SLOW }, -- Disable Slow
    [116706] = { ROOT }, -- Disable Root
    [116849] = { DAMAGE_REDUCTION }, -- Life Cocoon
    [119381] = { STUN }, -- Leg Sweep
    [122278] = { DAMAGE_REDUCTION }, -- Dampen Harm
    [122470] = { IMMUNITY }, -- Touch of Karma
    [122783] = { DAMAGE_REDUCTION }, -- Diffuse Magic
    [137639] = { DAMAGE_REDUCTION }, -- Storm, Earth, and Fire
    [198909] = { CROWD_CONTROL }, -- Song of Chi-Ji
    [115176] = { DAMAGE_REDUCTION }, -- Zen Meditation
    [216113] = { DAMAGE_INCREASE }, -- Way of the Crane
    [232055] = { CROWD_CONTROL }, -- Fists of Fury
        [120086] = { CROWD_CONTROL, originalID = 232055 }, -- Fists of Fury
    [233759] = { CROWD_CONTROL }, -- Grapple Weapon

    -- Paladin

    [498] = { DAMAGE_REDUCTION }, -- Divine Protection
    [642] = { IMMUNITY }, -- Divine Shield
    [853] = { CROWD_CONTROL }, -- Hammer of Justice
    [1022] = { DAMAGE_REDUCTION }, -- Blessing of Protection
        [204018] = { DAMAGE_REDUCTION }, -- Blessing of Spellwarding
    [1044] = { DAMAGE_REDUCTION }, -- Blessing of Freedom
    [6940] = { DAMAGE_REDUCTION }, -- Blessing of Sacrifice
        [199448] = { DAMAGE_REDUCTION, originalID = 6940 }, -- Blessing of Sacrifice (Ultimate Sacrifice Honor Talent)
    [20066] = { CROWD_CONTROL }, -- Repentance
    [31821] = { DAMAGE_REDUCTION }, -- Aura Mastery
    [31850] = { DAMAGE_REDUCTION }, -- Ardent Defender
    [31884] = { DAMAGE_INCREASE }, -- Avenging Wrath (Protection/Retribution)
        [31842] = { DAMAGE_INCREASE, originalID = 31884 }, -- Avenging Wrath (Holy)
        [216331] = { DAMAGE_INCREASE, originalID = 31884 }, -- Avenging Crusader (Holy Honor Talent)
        [231895] = { DAMAGE_INCREASE, originalID = 31884 }, -- Crusade (Retribution Talent)
    [31935] = { CROWD_CONTROL }, -- Avenger's Shield
    [86659] = { DAMAGE_REDUCTION }, -- Guardian of Ancient Kings
        [212641] = { DAMAGE_REDUCTION }, -- Guardian of Ancient Kings (Glyphed)
        [228049] = { DAMAGE_REDUCTION }, -- Guardian of the Forgotten Queen
    [105809] = { DAMAGE_INCREASE }, -- Holy Avenger
    [115750] = { CROWD_CONTROL }, -- Blinding Light
        [105421] = { CROWD_CONTROL, originalID = 115750 }, -- Blinding Light
    [152262] = { DAMAGE_INCREASE }, -- Seraphim
    [184662] = { DAMAGE_REDUCTION }, -- Shield of Vengeance
    [204150] = { DAMAGE_REDUCTION }, -- Aegis of Light
    [205191] = { DAMAGE_REDUCTION }, -- Eye for an Eye
    [210256] = { DAMAGE_REDUCTION }, -- Blessing of Sanctuary
    [210294] = { IMMUNITY }, -- Divine Favor
    [215652] = { DAMAGE_INCREASE }, -- Shield of Virtue


    -- Priest / unchecked, no slow

    [34914] = { ANTI_DISPEL }, -- Vampiric Touch
    [586] = { DAMAGE_REDUCTION }, -- Fade
        [213602] = { DAMAGE_REDUCTION }, -- Greater Fade
    [605] = { CROWD_CONTROL }, -- Mind Control
    [8122] = { CROWD_CONTROL }, -- Psychic Scream
    [9484] = { CROWD_CONTROL }, -- Shackle Undead
    [10060] = { DAMAGE_INCREASE }, -- Power Infusion
    [15487] = { SILENCE }, -- Silence
        [199683] = { CROWD_CONTROL, originalID = 15487 }, -- Last Word
    [33206] = { DAMAGE_REDUCTION }, -- Pain Suppression
    [47536] = { DAMAGE_REDUCTION }, -- Rapture
    [47585] = { DAMAGE_REDUCTION }, -- Dispersion
    [47788] = { DAMAGE_REDUCTION }, -- Guardian Spirit
    [64044] = { CROWD_CONTROL }, -- Psychic Horror
    [64843] = { DAMAGE_REDUCTION }, -- Divine Hymn
    [81782] = { DAMAGE_REDUCTION }, -- Power Word: Barrier
        [271466] = { DAMAGE_REDUCTION, originalID = 81782 }, -- Luminous Barrier (Disc Talent)
    [87204] = { CROWD_CONTROL }, -- Sin and Punishment
    [193223] = { DAMAGE_INCREASE }, -- Surrender to Madness
    [194249] = { DAMAGE_INCREASE }, -- Voidform
    [196762] = { DAMAGE_REDUCTION }, -- Inner Focus
    [197268] = { DAMAGE_REDUCTION }, -- Ray of Hope
    [197862] = { DAMAGE_REDUCTION }, -- Archangel
    [197871] = { DAMAGE_INCREASE }, -- Dark Archangel
    [200183] = { DAMAGE_REDUCTION }, -- Apotheosis
    [200196] = { INCAP }, -- Holy Word: Chastise
        [200200] = { CROWD_CONTROL, originalID = 200196 }, -- Holy Word: Chastise (Stun)
    [205369] = { CROWD_CONTROL }, -- Mind Bomb
        [226943] = { CROWD_CONTROL, originalID = 205369 }, -- Mind Bomb (Disorient)
    [213610] = { EFFECT_IMMUNITY }, -- Holy Ward
    [215769] = { IMMUNITY }, -- Spirit of Redemption
    [221660] = { IMMUNITY }, -- Holy Concentration

    -- Rogue / good

    [408] = { STUN }, -- Kidney Shot
    [1330] = { SILENCE }, -- Garrote - Silence
    [1776] = { INCAP }, -- Gouge
    [1833] = { STUN }, -- Cheap Shot
    [1966] = { DAMAGE_REDUCTION }, -- Feint
    [2094] = { CROWD_CONTROL }, -- Blind
    [5277] = { PHYSICAL_IMMUNITY }, -- Evasion
    [6770] = { INCAP }, -- Sap
    [13750] = { DAMAGE_INCREASE }, -- Adrenaline Rush
    [31224] = { IMMUNITY }, -- Cloak of Shadows
    [51690] = { DAMAGE_INCREASE }, -- Killing Spree
    [79140] = { DAMAGE_INCREASE }, -- Vendetta
    [121471] = { DAMAGE_INCREASE }, -- Shadow Blades
    [199754] = { IMMUNITY }, -- Riposte
    [199804] = { STUN }, -- Between the Eyes
    [207736] = { DAMAGE_INCREASE }, -- Shadowy Duel
    [212183] = { CROWD_CONTROL }, -- Smoke Bomb
    [3409] = { SLOW }, -- Crippling Poison
    [185763] = { SLOW }, -- Pistol Shot
    [206760] = { SLOW }, -- Shadow's Grasp
    -- [277953] = { SLOW }, -- Night Terrors
    [199027] = { PHYSICAL_IMMUNITY }, -- Veil of Midnight (100% dodge)


    -- Shaman

    [2825] = { DAMAGE_INCREASE }, -- Bloodlust
        [32182] = { DAMAGE_INCREASE, originalID = 2825 }, -- Heroism
    [51514] = { CROWD_CONTROL }, -- Hex
        [196932] = { CROWD_CONTROL, originalID = 51514 }, -- Voodoo Totem
        [210873] = { CROWD_CONTROL, originalID = 51514 }, -- Hex (Compy)
        [211004] = { CROWD_CONTROL, originalID = 51514 }, -- Hex (Spider)
        [211010] = { CROWD_CONTROL, originalID = 51514 }, -- Hex (Snake)
        [211015] = { CROWD_CONTROL, originalID = 51514 }, -- Hex (Cockroach)
        [269352] = { CROWD_CONTROL, originalID = 51514 }, -- Hex (Skeletal Hatchling)
        [277778] = { CROWD_CONTROL, originalID = 51514 }, -- Hex (Zandalari Tendonripper)
        [277784] = { CROWD_CONTROL, originalID = 51514 }, -- Hex (Wicker Mongrel)
    [79206] = { DAMAGE_REDUCTION }, -- Spiritwalker's Grace 60 * OTHER
    [108281] = { DAMAGE_REDUCTION }, -- Ancestral Guidance
    [16166] = { DAMAGE_INCREASE }, -- Elemental Mastery
    [64695] = { ROOT }, -- Earthgrab Totem
    [77505] = { CROWD_CONTROL }, -- Earthquake (Stun)
    [98008] = { DAMAGE_REDUCTION }, -- Spirit Link Totem
    [108271] = { DAMAGE_REDUCTION }, -- Astral Shift
        [210918] = { DAMAGE_REDUCTION, originalID = 108271 }, -- Ethereal Form
    [114050] = { DAMAGE_REDUCTION }, -- Ascendance (Elemental)
        [114051] = { DAMAGE_INCREASE, originalID = 114050 }, -- Ascendance (Enhancement)
        [114052] = { DAMAGE_REDUCTION, originalID = 114050 }, -- Ascendance (Restoration)
    [118345] = { CROWD_CONTROL }, -- Pulverize
    [118905] = { CROWD_CONTROL }, -- Static Charge
    [197214] = { CROWD_CONTROL }, -- Sundering
    [204293] = { DAMAGE_REDUCTION }, -- Spirit Link
    [204366] = { DAMAGE_INCREASE }, -- Thundercharge
    [204945] = { DAMAGE_INCREASE }, -- Doom Winds
    [260878] = { DAMAGE_REDUCTION }, -- Spirit Wolf
    [8178] = { SPELL_IMMUNITY }, -- Grounding
        [255016] = { SPELL_IMMUNITY, originalID = 8178 }, -- Grounding
        [204336] = { SPELL_IMMUNITY, originalID = 8178 }, -- Grounding
        [34079] = { SPELL_IMMUNITY, originalID = 8178 }, -- Grounding

    -- Warlock / ok, no slow

    [710] = { CROWD_CONTROL }, -- Banish
    [5484] = { CROWD_CONTROL }, -- Howl of Terror
    [6358] = { CROWD_CONTROL }, -- Seduction
        [115268] = { CROWD_CONTROL, originalID = 6358 }, -- Mesmerize
    [6789] = { CROWD_CONTROL }, -- Mortal Coil
    -- [20707] = { DAMAGE_REDUCTION }, -- Soulstone
    -- [22703] = { CROWD_CONTROL }, -- Infernal Awakening (infernal summon)
    [30283] = { STUN }, -- Shadowfury
    [89751] = { DAMAGE_INCREASE }, -- Felstorm
        [115831] = { DAMAGE_INCREASE, originalID = 89751 }, -- Wrathstorm
    [89766] = { STUN }, -- Axe Toss
    [104773] = { IMMUNITY }, -- Unending Resolve
    [108416] = { DAMAGE_REDUCTION }, -- Dark Pact
    [113860] = { DAMAGE_INCREASE }, -- Dark Soul: Misery (Affliction)
    [113858] = { DAMAGE_INCREASE }, -- Dark Soul: Instability (Demonology)
    [118699] = { CROWD_CONTROL }, -- Fear
        [130616] = { CROWD_CONTROL, originalID = 118699 }, -- Fear (Glyph of Fear)
    [171017] = { CROWD_CONTROL }, -- Meteor Strike
    [196098] = { DAMAGE_INCREASE }, -- Soul Harvest
    [196364] = { SILENCE }, -- Unstable Affliction (Silence)
    [233490] = { ANTI_DISPEL }, -- Unstable Affliction applications
    [233496] = { ANTI_DISPEL, originalID = 233490 }, -- Unstable Affliction applications
    [233497] = { ANTI_DISPEL, originalID = 233490 }, -- Unstable Affliction applications
    [233498] = { ANTI_DISPEL, originalID = 233490 }, -- Unstable Affliction applications
    [233499] = { ANTI_DISPEL, originalID = 233490 }, -- Unstable Affliction applications
    [212284] = { DAMAGE_INCREASE }, -- Firestone
    [212295] = { IMMUNITY }, -- Nether Ward

    -- Warrior / good, maybe more slow?

    [871] = { DAMAGE_REDUCTION }, -- Shield Wall
    [1719] = { DAMAGE_INCREASE }, -- Recklessness
    [5246] = { CROWD_CONTROL }, -- Intimidating Shout
    [12975] = { DAMAGE_REDUCTION }, -- Last Stand
    [18499] = { FEAR_IMMUNITY }, -- Berserker Rage
    [23920] = { IMMUNITY }, -- Spell Reflection
        -- [213915] = { IMMUNITY, originalID = 23920 }, -- Mass Spell Reflection
        [216890] = { IMMUNITY, originalID = 23920 }, -- Spell Reflection (Arms, Fury)
    [46968] = { STUN }, -- Shockwave
    [97462] = { DAMAGE_REDUCTION }, -- Rallying Cry
    [105771] = { ROOT }, -- Charge (Warrior)
    [107574] = { DAMAGE_INCREASE }, -- Avatar
    [118038] = { DAMAGE_REDUCTION }, -- Die by the Sword
    [107570] = { STUN }, -- Storm Bolt
    -- [184364] = { DAMAGE_REDUCTION }, -- Enraged Regeneration
    [197690] = { DAMAGE_REDUCTION }, -- Defensive Stance
    [213871] = { DAMAGE_REDUCTION }, -- Bodyguard
    [227847] = { IMMUNITY }, -- Bladestorm (Arms)
        [46924] = { IMMUNITY, originalID = 227847 }, -- Bladestorm (Fury)
        -- [152277] = { IMMUNITY, originalID = 227847 }, -- Ravager
    [228920] = { DAMAGE_REDUCTION }, -- Ravager
    [236077] = { DAMAGE_DECREASE }, -- Disarm
    [1715] = { SLOW }, -- Hamstring
}
data = lib.data

A({ 118, 28271, 28272, 61025, 61305, 61721, 61780, 126819, 161353, 161354, 161355, 161372, 277787, 277792 }, { CROWD_CONTROL }) -- Polymorph




-----------------------
-- CLASSIC
-----------------------

elseif isClassic then


lib.data = {}
data = lib.data

--MISC
A( 23451 ,{ SPEED_BOOST }) -- Battleground Speed buff
A( 23493 ,{ DAMAGE_REDUCTION }) -- Battleground Heal buff
A( 23505 ,{ DAMAGE_INCREASE }) -- Battleground Damage buff
A( 6615 ,{ CROWD_CONTROL_IMMUNITY }) -- Free Action Potion
A( 24364 ,{ CROWD_CONTROL_IMMUNITY }) -- Living Action Potion
A( 3169 ,{ IMMUNITY }) -- Limited Invulnerability Potion
A( 16621 ,{ IMMUNITY }) -- Invulnerable Mail
A( 1090 ,{ CROWD_CONTROL }) -- Magic Dust
A( 13327 ,{ INCAP }) -- Reckless Charge
A({ 26740, 13181 }, { CROWD_CONTROL }) -- Mind Control Cap + Backfire
A( 835 ,{ STUN }) -- Tidal Charm
A( 11359 ,{ EFFECT_IMMUNITY }) -- Restorative Potion, Removes 1 magic, curse, poison or disease effect on you every 5 seconds for 30 seconds.
A( 6727 ,{ EFFECT_IMMUNITY }) -- Violet Tragan -- probably wrong id
A( 5024 ,{ EFFECT_IMMUNITY }) -- Skull of Impending Doom
A( 2379 ,{ SPEED_BOOST }) -- Swiftness Potion
A({ 13099, 13138, 16566 }, { CROWD_CONTROL }) -- Net-o-matic + Backfire
A( 5134 ,{ CROWD_CONTROL }) -- Flash Bomb
A( 23097 ,{ ATTENTION }) -- Fire Reflector
A( 23131 ,{ ATTENTION }) -- Frost Reflector
A( 23132 ,{ ATTENTION }) -- Shadow Reflector
A( 19769 ,{ INCAP }) -- Thorium Grenade
A( 4068 ,{ INCAP }) -- Iron Grenade
A( 1604 ,{ SLOW }) -- Common Daze
A({ 23333, 23335 }, { ATTENTION }) -- Warsong Flag
A({ 25750, 25747, 25746, 23991 }, { DAMAGE_ABSORB }) -- AB Trinkets
A( 23506 ,{ DAMAGE_ABSORB }) -- Arena Grand Master trinket
A( 29506 ,{ DAMAGE_ABSORB }) -- Burrower's Shell trinket
A( 12733 ,{ FEAR_IMMUNITY }) -- Blacksmith trinket, Fear immunity
A( 15753 ,{ STUN }) -- Linken's Boomerang stun
A( 15752 ,{ DAMAGE_DECREASE }) -- Linken's Boomerang disarm
A( 14530 ,{ SPEED_BOOST }) -- Nifty Stopwatch
A( 13237 ,{ STUN }) -- Goblin Mortar trinket
A( 14253 ,{ EFFECT_IMMUNITY }) -- Black Husk Shield, Periodic Poison dispel
A( 9175 ,{ SPEED_BOOST }) -- Swift Boots
A( 13141 ,{ SPEED_BOOST }) -- Gnomish Rocket Boots
A( 8892 ,{ SPEED_BOOST }) -- Goblin Rocket Boots
A( 9774 ,{ ROOT_IMMUNITY }) -- Spider Belt & Ornate Mithril Boots, Root Immune




-- RACIALS

A( 23230 ,{ HEALING_REDUCTION }) -- Blood Fury Debuff
A( 20594 ,{ EFFECT_IMMUNITY }) -- Stoneform, Immune to Bleed, Poison, and Disease.
A( 20549 ,{ STUN }) -- War Stomp
A( 7744 ,{ EFFECT_IMMUNITY }) -- Will of the Forsaken, Immune to Charm, Fear, and Sleep.
A({ 9035, 19281, 19282, 19283, 19284, 19285 }, { HEALING_REDUCTION }) -- Hex of Weakness
A( 20600 ,{ STEALTH_DETECTION }) -- Perception



-- WARLOCK

A( 24259 ,{ SILENCE }) -- Spell Lock Silence
A( 6358, { CROWD_CONTROL }) -- Seduction
A({ 5782, 6213, 6215 }, { CROWD_CONTROL }) -- Fear
A({ 5484, 17928 }, { CROWD_CONTROL }) -- Howl of Terror
A({ 710, 18647 }, { CROWD_CONTROL }) -- Banish
A({ 6789, 17925, 17926 }, { CROWD_CONTROL }) -- Death Coil
A( 18223 ,{ SLOW }) -- Curse of Exhaustion
A( 18118 ,{ SLOW }) -- Aftermath (Destruction Talent)
A({ 1714, 11719 }, { DAMAGE_DECREASE }) -- Curse of Tongues
A({ 6229, 11739, 11740, 28610 } ,{ DAMAGE_ABSORB }) -- Shadow Ward
A({ 7812, 19438, 19440, 19441, 19442, 19443 } ,{ DAMAGE_ABSORB }) -- Sacrifice
A( 18093 ,{ STUN }) -- Pyroclasm


-- SHAMAN

A({ 8056, 8058, 10472, 10473 }, { SLOW }) -- Frost Shock
A( 3600 ,{ SLOW }) -- Earthbind
A({ 8034, 8037, 10458, 16352, 16353  }, { SLOW }) -- Frostbrand Attack
-- Lightning shield??
A( 8178 ,{ SPELL_IMMUNITY }) -- Grounding Totem Effect
-- A( 2645 ,{ SPEED_BOOST }) -- Ghost Wolf

-- PALADIN

A({ 1022, 5599, 10278 }, { PHYSICAL_IMMUNITY }) -- Blessing of Protection
A({ 498, 5573, 642, 1020 }, { IMMUNITY }) -- Divine Shield
A({ 853, 5588, 5589, 10308 }, { STUN }) -- Hammer of Justice
A( 1044 ,{ SPEED_BOOST }) -- Blessing of Freedom
A( 20066 ,{ INCAP }) -- Repentance
A( 20170 ,{ STUN }) -- Seal of Justice stun

-- HUNTER


A( 13159 ,{ SPEED_BOOST }) -- Aspect of the Pack
A( 5118 ,{ SPEED_BOOST }) -- Aspect of the Cheetah
A( 15571 ,{ SLOW }) -- Daze from Aspect of Cheetah/Pack
A({ 1513, 14326, 14327 }, { CROWD_CONTROL }) -- Scare Beast
A( 5116 ,{ SLOW }) -- Concussive Shot
A( 19410 ,{ STUN }) -- Concussive Shot Stun
A({ 1130, 14323, 14324, 14325 }, { DAMAGE_VULNERABILITY }) -- Hunter's Mark
A( 3045 ,{ DAMAGE_INCREASE }) -- Rapid Fire
-- A( 19574 ,{ DAMAGE_INCREASE }) -- Bestial Wrath
A( 19263 ,{ DAMAGE_REDUCTION }) -- Deterrence
A( 13810 ,{ SLOW }) -- Frost Trap Aura
A({ 3355, 14308, 14309 }, { CROWD_CONTROL }) -- Freezing Trap
A({ 2974, 14267, 14268 }, { SLOW }) -- Wing Clip
A( 19229, { ROOT }) -- Wing Clip Root
A({ 19306, 20909, 20910 }, { ROOT }) -- Counterattack Root
A( 24394 ,{ STUN }) -- Intimidation
A({ 19386, 24132, 24133 }, { CROWD_CONTROL }) --Wyvern Sting
A( 19185 ,{ ROOT }) -- Entrapment
-- A({ 3034, 14279, 14280}, { TRASH }) -- Viper Sting
A( 19503 ,{ CROWD_CONTROL }) -- Scatter Shot
A( 25999 ,{ ROOT }) -- Boar Charge

-- DRUID

A( 22812 ,{ DAMAGE_REDUCTION }) -- Barkskin
A( 19975 ,{ ROOT }) -- Nature's Grasp
A({ 339, 1062, 5195, 5196, 9852, 9853 }, { ROOT }) -- Entangling Roots
A({ 770, 778, 9749, 9907, 16857, 17390, 17391, 17392 }, { STEALTH_DETECTION }) -- Faerie Fire
A({ 2637, 18657, 18658 }, { CROWD_CONTROL }) -- Hibernate
A( 29166, { DAMAGE_INCREASE }) -- Innervate
A({ 9005, 9823, 9827 }, { STUN }) -- Pounce Stun
A( 16922, { STUN }) -- Starfire Stun
-- A({ 5217, 6793, 9845, 9846 }, { DAMAGE_INCREASE }) -- Tiger's Fury
A({ 5211, 6798, 8983 }, { STUN }) -- Bash
A( 16979 ,{ ROOT }) -- Feral Charge
-- A( 2893 ,{ TRASH }) -- Abolish Poison
A({ 1850, 9821 }, { SPEED_BOOST }) -- Dash
A({ 16689, 16810, 16811, 16812, 16813, 17329}, { ATTENTION }) -- Nature's Grasp Buff
A({ 783, 1066 }, { SPEED_BOOST }) -- Travel Form & Aquatic Form

-- MAGE

A( 18469 ,{ SILENCE }) -- Improved Counterspell
A({ 118, 12824, 12825, 12826, 28270, 28271, 28272 }, { CROWD_CONTROL }) -- Polymorph
A({ 11426, 13031, 13032, 13033 }, { DAMAGE_ABSORB }) -- Ice Barrier
A({ 543, 8457, 8458, 10223, 10225 }, { DAMAGE_ABSORB}) -- Fire Ward
A({ 6143, 8461, 8462, 10177, 28609 }, { DAMAGE_ABSORB}) -- Frost Ward
A( 12355 ,{ STUN }) -- Impact
A( 22959 ,{ TRASH }) -- Fire Vulnerability
A({ 11113, 13018, 13019, 13020, 13021 }, { SLOW }) -- Blast Wave
A({ 120, 8492, 10159, 10160, 10161 }, { SLOW }) -- Cone of Cold
A({ 12484, 12485, 12486 }, { SLOW }) -- Improved Blizzard
A({ 6136, 7321 }, { SLOW }) -- Frost Armor Chill
A({ 116, 205, 837, 7322, 8406, 8407, 8408, 10179, 10180, 10181, 25304 }, { SLOW }) -- Frostbolt
A( 12494 ,{ FROZEN }) -- Frostbite
A({ 122, 865, 6131, 10230 }, { FROZEN }) -- Frost Nova
A( 12042 ,{ DAMAGE_INCREASE }) -- Arcane Power
A( 11958 ,{ IMMUNITY }) -- Ice Block
A( 12579 ,{ TRASH }) -- Winter's Chill
A({ 133, 143, 145, 3140, 8400, 8401, 8402, 10148, 10149, 10150, 10151, 25306 }, { TRASH }) -- Fireball dot
A({ 11366, 12505, 12522, 12523, 12524, 12525, 12526, 18809 }, { TRASH }) -- Pyroblast dot
A( 12051 ,{ ATTENTION }) -- Evocation
A({ 1463, 8494, 8495, 10191, 10192, 10193 }, { DAMAGE_ABSORB }) -- Mana Shield

-- PRIEST

A( 15487, { SILENCE }) -- Silence
A( 10060, { DAMAGE_INCREASE }) -- Power Infusion
A({ 17, 592, 600, 3747, 6065, 6066, 10898, 10899, 10900, 10901 }, { DAMAGE_ABSORB }) -- Power Word: Shield
A({ 8122, 8124, 10888, 10890 }, { CROWD_CONTROL }) -- Psychic Scream
A( 15269 ,{ STUN }) -- Blackout
A({ 15407, 17311, 17312, 17313, 17314, 18807 }, { SLOW }) -- Mind Flay
A( 15258 ,{ TRASH }) -- Shadow Vulnerability
A({ 605, 10911, 10912 }, { CROWD_CONTROL }) -- Mind Control

-- ROGUE

A( 18425 ,{ SILENCE }) -- Improved Kick
A( 13750 ,{ DAMAGE_INCREASE }) -- Adrenaline Rush
A( 13877 ,{ DAMAGE_INCREASE }) -- Blade Flurry
A( 1833 , { STUN }) -- Cheap Shot
A({ 408, 8643 }, { STUN }) -- Kidney Shot
A({ 2070, 6770, 11297 }, { INCAP }) -- Sap
A( 2094 , { CROWD_CONTROL }) -- Blind
-- A({ 8647, 8649, 8650, 11197, 11198 }, { DAMAGE_VULNERABILITY }) -- Expose Armor
A({ 2983, 8696, 11305 }, { SPEED_BOOST }) -- Sprint
A( 5277 ,{ DAMAGE_REDUCTION }) -- Evasion
A({ 1776, 1777, 8629, 11285, 11286 }, { INCAP }) -- Gouge
A({ 3409, 11201 }, { ROOT }) -- Crippling Poison NOTE: it's a slow but we prio it as root because its 70% and better than all other slows
A( 14251 ,{ DAMAGE_DECREASE }) -- Riposte (Disarm)
A( 14278 ,{ DAMAGE_REDUCTION }) -- Ghostly Strike

-- WARRIOR

A( 18498 ,{ SILENCE }) -- Improved Shield Bash
A( 20230 ,{ PHYSICAL_IMMUNITY }) -- Retaliation
A( 1719 ,{ DAMAGE_VULNERABILITY }) -- Recklessness, Fear immunity, Damage Vuln
A( 871, { DAMAGE_REDUCTION }) -- Shield Wall
A( 12328, { FEAR_IMMUNITY }) -- Death Wish, Fear immunity
A({ 1715, 7372, 7373 }, { SLOW }) -- Hamstring
A( 23694 , { ROOT }) -- Improved Hamstring
A( 12323, { SLOW }) -- Piercing Howl
-- Thunder Clap?
A( 18499, { EFFECT_IMMUNITY }) -- Berserker Rage
A({ 20253, 20614, 20615 }, { STUN }) -- Intercept Stun
A({ 5246, 20511 }, { CROWD_CONTROL }) -- Intimidating Shout
A( 676 ,{ DAMAGE_DECREASE }) -- Disarm
A( 12798 , { STUN }) -- Revenge Stun
A( 12809 ,{ STUN }) -- Concussion Blow
A({ 16488, 16490, 16491 }, { TRASH }) -- Blood Craze
A({ 12294, 21551, 21552, 21553 }, { HEALING_REDUCTION }) -- Mortal Strike
A( 7922 ,{ STUN }) -- Charge Stun
A( 5530 ,{ STUN }) -- Mace Spec. Stun (Warrior & Rogue)

end


function lib.GetDebuffInfo(spellID, targetType) -- older version of the function with stupid return value order
    if data[spellID] then
        targetType = targetType or "ALLY"
        local priorityTable = targetType == "ALLY" and friendlyPriority or enemyPriority
        local spellData = data[spellID]
        -- TODO: Compare multiple categories if assigned
        local spellType
        if type(spellData) == "table" then
            spellType = spellData[1]
        else
            spellType = spellData
        end
        if spellData.originalID then spellID = spellData.originalID end
        local prio = priorityTable[spellType]
        return spellID, spellType, prio
    end
end
function lib.GetAuraInfo(...)
    local spellID, spellType, prio = lib.GetDebuffInfo(...)
    return prio, spellType, spellID
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
