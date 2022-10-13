local tbl_sort, select, string_lower = table.sort, select, string.lower

local GetSpellInfo = GetSpellInfo
local GetItemInfo = GetItemInfo

local Gladdy = LibStub("Gladdy")
local L = Gladdy.L
local AURA_TYPE_DEBUFF, AURA_TYPE_BUFF = AURA_TYPE_DEBUFF, AURA_TYPE_BUFF

Gladdy.expansion = "BCC"
Gladdy.CLASSES = {"MAGE", "PRIEST", "DRUID", "SHAMAN", "PALADIN", "WARLOCK", "WARRIOR", "HUNTER", "ROGUE"}
tbl_sort(Gladdy.CLASSES)

local specBuffs = {
    -- DRUID
    [GetSpellInfo(45283)] = L["Restoration"], -- Natural Perfection
    [GetSpellInfo(16880)] = L["Restoration"], -- Nature's Grace; Dreamstate spec in TBC equals Restoration
    [GetSpellInfo(24858)] = L["Restoration"], -- Moonkin Form; Dreamstate spec in TBC equals Restoration
    [GetSpellInfo(17007)] = L["Feral"], -- Leader of the Pack
    [GetSpellInfo(16188)] = L["Restoration"], -- Nature's Swiftness
    [GetSpellInfo(33891)] = L["Restoration"], -- Tree of Life

    -- HUNTER
    [GetSpellInfo(34471)] = L["Beast Mastery"], -- The Beast Within
    [GetSpellInfo(20895)] = L["Beast Mastery"], -- Spirit Bond
    [GetSpellInfo(34455)] = L["Beast Mastery"], -- Ferocious Inspiration
    [GetSpellInfo(27066)] = L["Marksmanship"], -- Trueshot Aura
    [GetSpellInfo(34501)] = L["Survival"], -- Expose Weakness

    -- MAGE
    [GetSpellInfo(33405)] = L["Frost"], -- Ice Barrier
    [GetSpellInfo(11129)] = L["Fire"], -- Combustion
    [GetSpellInfo(12042)] = L["Arcane"], -- Arcane Power
    [GetSpellInfo(12043)] = L["Arcane"], -- Presence of Mind
    [GetSpellInfo(31589)] = L["Arcane"], -- Slow
    [GetSpellInfo(12472)] = L["Frost"], -- Icy Veins
    [GetSpellInfo(46989)] = L["Arcane"], -- Improved Blink

    -- PALADIN
    [GetSpellInfo(31836)] = L["Holy"], -- Light's Grace
    [GetSpellInfo(31842)] = L["Holy"], -- Divine Illumination
    [GetSpellInfo(20216)] = L["Holy"], -- Divine Favor
    [GetSpellInfo(20375)] = L["Retribution"], -- Seal of Command
    [GetSpellInfo(20049)] = L["Retribution"], -- Vengeance
    [GetSpellInfo(20218)] = L["Retribution"], -- Sanctity Aura
    [GetSpellInfo(26018)] = L["Retribution"], -- Vindication
    [GetSpellInfo(27179)] = L["Protection"], -- Holy Shield

    -- PRIEST
    [GetSpellInfo(15473)] = L["Shadow"], -- Shadowform
    [GetSpellInfo(15286)] = L["Shadow"], -- Vampiric Embrace
    [GetSpellInfo(45234)] = L["Discipline"], -- Focused Will
    [GetSpellInfo(27811)] = L["Discipline"], -- Blessed Recovery
    [GetSpellInfo(33142)] = L["Holy"], -- Blessed Resilience
    [GetSpellInfo(14752)] = L["Discipline"], -- Divine Spirit
    [GetSpellInfo(27681)] = L["Discipline"], -- Prayer of Spirit
    [GetSpellInfo(10060)] = L["Discipline"], -- Power Infusion
    [GetSpellInfo(33206)] = L["Discipline"], -- Pain Suppression
    [GetSpellInfo(14893)] = L["Discipline"], -- Inspiration

    -- ROGUE
    [GetSpellInfo(36554)] = L["Subtlety"], -- Shadowstep
    [GetSpellInfo(44373)] = L["Subtlety"], -- Shadowstep Speed
    [GetSpellInfo(36563)] = L["Subtlety"], -- Shadowstep DMG
    [GetSpellInfo(14278)] = L["Subtlety"], -- Ghostly Strike
    [GetSpellInfo(31233)] = L["Assassination"], -- Find Weakness
    [GetSpellInfo(13877)] = L["Combat"], -- Blade Flurry

    --Shaman
    [GetSpellInfo(30807)] = L["Enhancement"], -- Unleashed Rage
    [GetSpellInfo(16280)] = L["Enhancement"], -- Flurry
    [GetSpellInfo(30823)] = L["Enhancement"], -- Shamanistic Rage
    [GetSpellInfo(16190)] = L["Restoration"], -- Mana Tide Totem
    [GetSpellInfo(32594)] = L["Restoration"], -- Earth Shield
    [GetSpellInfo(29202)] = L["Restoration"], -- Healing Way

    -- WARLOCK
    [GetSpellInfo(19028)] = L["Demonology"], -- Soul Link
    [GetSpellInfo(23759)] = L["Demonology"], -- Master Demonologist
    [GetSpellInfo(35696)] = L["Demonology"], -- Demonic Knowledge
    [GetSpellInfo(30300)] = L["Destruction"], -- Nether Protection
    [GetSpellInfo(34936)] = L["Destruction"], -- Backlash

    -- WARRIOR
    [GetSpellInfo(29838)] = L["Arms"], -- Second Wind
    [GetSpellInfo(12292)] = L["Arms"], -- Death Wish

}
function Gladdy:GetSpecBuffs()
    return specBuffs
end

local specSpells = {
    -- DRUID
    [GetSpellInfo(33831)] = L["Balance"], -- Force of Nature
    [GetSpellInfo(33983)] = L["Feral"], -- Mangle (Cat)
    [GetSpellInfo(33987)] = L["Feral"], -- Mangle (Bear)
    [GetSpellInfo(18562)] = L["Restoration"], -- Swiftmend
    [GetSpellInfo(17116)] = L["Restoration"], -- Nature's Swiftness
    [GetSpellInfo(33891)] = L["Restoration"], -- Tree of Life

    -- HUNTER
    [GetSpellInfo(19577)] = L["Beast Mastery"], -- Intimidation
    [GetSpellInfo(34490)] = L["Marksmanship"], -- Silencing Shot
    [GetSpellInfo(27068)] = L["Survival"], -- Wyvern Sting
    [GetSpellInfo(19306)] = L["Survival"], -- Counterattack
    [GetSpellInfo(27066)] = L["Marksmanship"], -- Trueshot Aura

    -- MAGE
    [GetSpellInfo(12042)] = L["Arcane"], -- Arcane Power
    [GetSpellInfo(33043)] = L["Fire"], -- Dragon's Breath
    [GetSpellInfo(33933)] = L["Fire"], -- Blast Wave
    [GetSpellInfo(33405)] = L["Frost"], -- Ice Barrier
    [GetSpellInfo(31687)] = L["Frost"], -- Summon Water Elemental
    [GetSpellInfo(12472)] = L["Frost"], -- Icy Veins
    [GetSpellInfo(11958)] = L["Frost"], -- Cold Snap

    -- PALADIN
    [GetSpellInfo(33072)] = L["Holy"], -- Holy Shock
    [GetSpellInfo(20216)] = L["Holy"], -- Divine Favor
    [GetSpellInfo(31842)] = L["Holy"], -- Divine Illumination
    [GetSpellInfo(32700)] = L["Protection"], -- Avenger's Shield
    [GetSpellInfo(27170)] = L["Retribution"], -- Seal of Command
    [GetSpellInfo(35395)] = L["Retribution"], -- Crusader Strike
    [GetSpellInfo(20066)] = L["Retribution"], -- Repentance
    [GetSpellInfo(20218)] = L["Retribution"], -- Sanctity Aura

    -- PRIEST
    [GetSpellInfo(10060)] = L["Discipline"], -- Power Infusion
    [GetSpellInfo(33206)] = L["Discipline"], -- Pain Suppression
    [GetSpellInfo(14752)] = L["Discipline"], -- Divine Spirit
    [GetSpellInfo(33143)] = L["Holy"], -- Blessed Resilience
    [GetSpellInfo(34861)] = L["Holy"], -- Circle of Healing
    [GetSpellInfo(15473)] = L["Shadow"], -- Shadowform
    [GetSpellInfo(34917)] = L["Shadow"], -- Vampiric Touch
    [GetSpellInfo(15286)] = L["Shadow"], -- Vampiric Embrace

    -- ROGUE
    [GetSpellInfo(34413)] = L["Assassination"], -- Mutilate
    [GetSpellInfo(14177)] = L["Assassination"], -- Cold Blood
    [GetSpellInfo(13750)] = L["Combat"], -- Adrenaline Rush
    [GetSpellInfo(13877)] = L["Combat"], -- Blade Flurry
    [GetSpellInfo(14185)] = L["Subtlety"], -- Preparation
    [GetSpellInfo(16511)] = L["Subtlety"], -- Hemorrhage
    [GetSpellInfo(36554)] = L["Subtlety"], -- Shadowstep
    [GetSpellInfo(14278)] = L["Subtlety"], -- Ghostly Strike
    [GetSpellInfo(14183)] = L["Subtlety"], -- Premeditation

    -- SHAMAN
    [GetSpellInfo(16166)] = L["Elemental"], -- Elemental Mastery
    [GetSpellInfo(30706)] = L["Elemental"], -- Totem of Wrath
    [GetSpellInfo(30823)] = L["Enhancement"], -- Shamanistic Rage
    [GetSpellInfo(17364)] = L["Enhancement"], -- Stormstrike
    [GetSpellInfo(16190)] = L["Restoration"], -- Mana Tide Totem
    [GetSpellInfo(32594)] = L["Restoration"], -- Earth Shield
    [GetSpellInfo(16188)] = L["Restoration"], -- Nature's Swiftness

    -- WARLOCK
    [GetSpellInfo(30405)] = L["Affliction"], -- Unstable Affliction
    [GetSpellInfo(18220)] = L["Affliction"], -- Dark Pact
    --[GetSpellInfo(30911)] = L["Affliction"], -- Siphon Life
    [GetSpellInfo(30414)] = L["Destruction"], -- Shadowfury
    [GetSpellInfo(30912)] = L["Destruction"], -- Conflagrate
    [GetSpellInfo(18708)] = L["Demonology"], -- Fel Domination

    -- WARRIOR
    [GetSpellInfo(30330)] = L["Arms"], -- Mortal Strike
    [GetSpellInfo(12292)] = L["Arms"], -- Death Wish
    [GetSpellInfo(30335)] = L["Fury"], -- Bloodthirst
    [GetSpellInfo(12809)] = L["Protection"], -- Concussion Blow
    [GetSpellInfo(30022)] = L["Protection"], -- Devastation
    [GetSpellInfo(30356)] = L["Protection"], -- Shield Slam
}
function Gladdy:GetSpecSpells()
    return specSpells
end

local importantAuras = {
    -- Cyclone
    [GetSpellInfo(33786)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 6,
        priority = 40,
        spellID = 33786,
    },
    -- Hibernate
    [GetSpellInfo(18658)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 10,
        priority = 40,
        magic = true,
        spellID = 18658,
    },
    -- Entangling Roots
    [GetSpellInfo(26989)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 10,
        priority = 30,
        onDamage = true,
        magic = true,
        root = true,
        spellID = 26989,
    },
    [select(1, GetSpellInfo(27010)) .. " " .. select(1, GetSpellInfo(16689))] = {
        track = AURA_TYPE_DEBUFF,
        duration = 10,
        priority = 30,
        spellID = 27010,
        altName = select(1, GetSpellInfo(27010)) .. " " .. select(1, GetSpellInfo(16689)),
    },
    -- Feral Charge
    [GetSpellInfo(16979)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 4,
        priority = 30,
        root = true,
        spellID = 16979,
    },
    -- Bash
    [GetSpellInfo(8983)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 4,
        priority = 30,
        spellID = 8983,
    },
    -- Pounce
    [GetSpellInfo(9005)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 3,
        priority = 40,
        spellID = 9005,
    },
    -- Maim
    [GetSpellInfo(22570)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 6,
        priority = 40,
        incapacite = true,
        spellID = 22570,
    },
    -- Innervate
    [GetSpellInfo(29166)] = {
        track = AURA_TYPE_BUFF,
        duration = 20,
        priority = 10,
        spellID = 29166,
    },
    -- Imp Starfire Stun
    [GetSpellInfo(16922)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 3,
        priority = 40,
        spellSchool = "physical",
        spellID = 16922,
    },


    -- Freezing Trap Effect
    [GetSpellInfo(14309)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 10,
        priority = 40,
        onDamage = true,
        magic = true,
        spellID = 14309,
    },
    -- Wyvern Sting
    [GetSpellInfo(19386)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 10,
        priority = 40,
        onDamage = true,
        poison = true,
        sleep = true,
        spellID = 19386,
    },
    -- Scatter Shot
    [GetSpellInfo(19503)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 4,
        priority = 40,
        onDamage = true,
        spellID = 19503,
    },
    -- Scare Beast
    [GetSpellInfo(14327)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 8,
        priority = 40,
        onDamage = true,
        fear = true,
        magic = true,
        spellID = 14327,
    },
    -- Silencing Shot
    [GetSpellInfo(34490)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 3,
        priority = 15,
        magic = true,
        spellID = 34490,
    },
    -- Intimidation
    [GetSpellInfo(19577)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 2,
        priority = 40,
        spellID = 19577,
    },
    -- The Beast Within
    [GetSpellInfo(34471)] = {
        track = AURA_TYPE_BUFF,
        duration = 18,
        priority = 20,
        spellID = 34471,
    },


    -- Polymorph
    [GetSpellInfo(12826)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 10,
        priority = 40,
        onDamage = true,
        magic = true,
        spellID = 12826,
    },
    -- Dragon's Breath
    [GetSpellInfo(31661)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 3,
        priority = 40,
        onDamage = true,
        magic = true,
        spellID = 31661,
    },
    -- Frost Nova
    [GetSpellInfo(27088)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 8,
        priority = 30,
        onDamage = true,
        magic = true,
        root = true,
        spellID = 27088,
    },
    -- Freeze (Water Elemental)
    [GetSpellInfo(33395)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 8,
        priority = 30,
        onDamage = true,
        magic = true,
        root = true,
        spellID = 33395,
    },
    -- Counterspell - Silence
    [GetSpellInfo(18469)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 4,
        priority = 15,
        magic = true,
        spellID = 18469,
    },
    -- Ice Block
    [GetSpellInfo(45438)] = {
        track = AURA_TYPE_BUFF,
        duration = 10,
        priority = 20,
        spellID = 45438,
    },
    [GetSpellInfo(41425)] = { -- Hypothermia (Ice Block Immune
        track = AURA_TYPE_DEBUFF,
        priority = 8,
        spellID = 41425,
    },
    -- Impact
    [GetSpellInfo(12355)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 2,
        priority = 40,
        spellID = 12355,
    },

    -- Hammer of Justice
    [GetSpellInfo(10308)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 6,
        priority = 40,
        magic = true,
        spellID = 10308,
    },
    -- Repentance
    [GetSpellInfo(20066)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 6,
        priority = 40,
        onDamage = true,
        magic = true,
        incapacite = true,
        spellID = 20066,
    },
    -- Blessing of Protection
    [GetSpellInfo(10278)] = {
        track = AURA_TYPE_BUFF,
        duration = 10,
        priority = 10,
        spellID = 10278,
    },
    -- Blessing of Freedom
    [GetSpellInfo(1044)] = {
        track = AURA_TYPE_BUFF,
        duration = 14,
        priority = 10,
        spellID = 1044,
    },
    -- Blessing of Sacrifice
    [GetSpellInfo(6940)] = {
        track = AURA_TYPE_BUFF,
        duration = 30,
        priority = 12,
        spellID = 6940,
    },
    -- Divine Shield
    [GetSpellInfo(642)] = {
        track = AURA_TYPE_BUFF,
        duration = 12,
        priority = 20,
        spellID = 642,
    },


    -- Psychic Scream
    [GetSpellInfo(8122)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 8,
        priority = 40,
        onDamage = true,
        fear = true,
        magic = true,
        spellID = 8122,
    },
    -- Chastise
    [GetSpellInfo(44047)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 8,
        priority = 30,
        root = true,
        spellID = 44047,
    },
    -- Mind Control
    [GetSpellInfo(605)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 10,
        priority = 40,
        magic = true,
        spellID = 605,
    },
    --Blackout Stun 15269
    [GetSpellInfo(15269)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 3,
        priority = 40,
        spellSchool = "magic",
        spellID = 15269,
    },
    -- Silence
    [GetSpellInfo(15487)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 5,
        priority = 15,
        magic = true,
        spellID = 15487,
    },
    -- Pain Suppression
    [GetSpellInfo(33206)] = {
        track = AURA_TYPE_BUFF,
        duration = 8,
        priority = 10,
        spellID = 33206,
    },
    -- Fear Ward
    [GetSpellInfo(6346)] = {
        track = AURA_TYPE_BUFF,
        duration = 180,
        priority = 9,
        spellID = 6346,
    },


    -- Sap
    [GetSpellInfo(6770)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 10,
        priority = 40,
        onDamage = true,
        incapacite = true,
        spellID = 6770,
    },
    -- Blind
    [GetSpellInfo(2094)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 10,
        priority = 40,
        onDamage = true,
        spellID = 2094,
    },
    -- Cheap Shot
    [GetSpellInfo(1833)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 4,
        priority = 40,
        spellID = 1833,
    },
    -- Kidney Shot
    [GetSpellInfo(8643)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 6,
        priority = 40,
        spellID = 8643,
    },
    -- Gouge
    [GetSpellInfo(1776)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 4,
        priority = 40,
        onDamage = true,
        incapacite = true,
        spellID = 1776,
    },
    -- Kick - Silence
    [GetSpellInfo(18425)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 2,
        priority = 15,
        spellID = 18425,
    },
    -- Garrote - Silence
    [GetSpellInfo(1330)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 3,
        priority = 15,
        spellID = 1330,
    },
    -- Cloak of Shadows
    [GetSpellInfo(31224)] = {
        track = AURA_TYPE_BUFF,
        duration = 5,
        priority = 20,
        spellID = 31224,
    },
    -- Evasion
    [GetSpellInfo(26669)] = {
        track = AURA_TYPE_BUFF,
        duration = 15,
        priority = 10,
        spellID = 26669,
    },
    -- Riposte
    [GetSpellInfo(14251)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 6,
        priority = 20,
        spellID = 14251,
    },

    -- Fear
    [GetSpellInfo(5782)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 10,
        priority = 40,
        onDamage = true,
        fear = true,
        magic = true,
        spellID = 5782,
    },
    -- Death Coil
    [GetSpellInfo(27223)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 3,
        priority = 40,
        spellID = 27223,
    },
    --Banish
    [GetSpellInfo(710)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 10,
        priority = 40,
        spellID = 710,
    },
    -- Shadowfury
    [GetSpellInfo(30283)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 2,
        priority = 40,
        magic = true,
        spellID = 30283,
    },
    -- Seduction (Succubus)
    [GetSpellInfo(6358)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 10,
        priority = 40,
        onDamage = true,
        fear = true,
        magic = true,
        spellID = 6358,
    },
    -- Howl of Terror
    [GetSpellInfo(5484)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 8,
        priority = 40,
        onDamage = true,
        fear = true,
        magic = true,
        spellID = 5484,
        texture = select(3, GetSpellInfo(5484))
    },
    -- Spell Lock (Felhunter)
    [GetSpellInfo(24259)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 3,
        priority = 15,
        magic = true,
        spellID = 24259,
    },
    -- Unstable Affliction Silence
    [select(1, GetSpellInfo(31117)) .. " Silence"] = { -- GetSpellInfo returns "Unstable Affliction"
        track = AURA_TYPE_DEBUFF,
        altName = select(1, GetSpellInfo(31117)) .. " Silence",
        duration = 5,
        priority = 15,
        magic = true,
        spellID = 31117,
    },


    -- Intimidating Shout
    [GetSpellInfo(5246)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 8,
        priority = 15,
        onDamage = true,
        fear = true,
        spellID = 5246,
    },
    -- Concussion Blow
    [GetSpellInfo(12809)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 5,
        priority = 40,
        spellID = 12809,
    },
    -- Intercept Stun
    [GetSpellInfo(25274)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 3,
        priority = 40,
        spellID = 25274,
        texture = select(3, GetSpellInfo(25272))
    },
    -- Charge Stun
    [GetSpellInfo(7922)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 1,
        priority = 40,
        spellID = 7922,
        texture = select(3, GetSpellInfo(100))
    },
    -- Spell Reflection
    [GetSpellInfo(23920)] = {
        track = AURA_TYPE_BUFF,
        duration = 5,
        priority = 50,
        spellID = 23920,
    },
    -- Shield Bash - Silenced
    [GetSpellInfo(18498)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 3,
        priority = 15,
        spellSchool = "magic",
        spellID = 18498,
    },
    -- Death Wish
    [GetSpellInfo(12292)] = {
        track = AURA_TYPE_BUFF,
        duration = 3,
        priority = 15,
        spellSchool = "magic",
        spellID = 12292,
    },
    --Disarm
    [GetSpellInfo(676)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 10,
        priority = 20,
        spellID = 676,
    },

    -- Grounding Totem Effect
    [GetSpellInfo(8178)] = {
        track = AURA_TYPE_BUFF,
        duration = 0,
        priority = 20,
        spellID = 8178
    },
    --Intervene
    [GetSpellInfo(3411)] = {
        track = AURA_TYPE_BUFF,
        duration = 10,
        priority = 10,
        spellSchool = "physical",
        spellID = 3411,
    },
    --Improved Hamstring
    [GetSpellInfo(23694)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 5,
        priority = 40,
        spellSchool = "physical",
        spellID = 23694,
    },

    -- Mace Stun Effect
    [GetSpellInfo(5530)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 3,
        priority = 40,
        spellSchool = "physical",
        texture = select(3, GetSpellInfo(12284)),
        spellID = 5530,
    },

    -- Storm Herald Stun effect
    [GetSpellInfo(34510)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 4,
        priority = 40,
        spellSchool = "physical",
        spellID = 34510,
    },

    -- War Stomp
    [GetSpellInfo(20549)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 2,
        priority = 40,
        spellID = 20549,
    },
    -- Arcane Torrent
    [GetSpellInfo(28730)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 2,
        priority = 15,
        magic = true,
        spellID = 28730,
    },
    -- Shadowsight Buff
    [GetSpellInfo(34709)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 15,
        priority = 9,
        magic = true,
        spellID = 34709,
    },
    -- Net-o-Matic
    [GetSpellInfo(13120)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 10,
        priority = 30,
        spellID = 13120,
    },
    -- Nigh Invulnerability Shield
    [GetSpellInfo(30458)] = {
        track = AURA_TYPE_BUFF,
        duration = 8,
        priority = 15,
        spellID = 30458,
        texture = select(10, GetItemInfo(23825))
    },
    -- Nigh Invulnerability Belt Backfire
    [GetSpellInfo(30457)] = {
        track = AURA_TYPE_DEBUFF,
        duration = 8,
        priority = 15,
        spellID = 30457,
    },
    -- Flee (Skull of impending Doom) -- 5024
    [GetSpellInfo(5024)] = {
        track = AURA_TYPE_BUFF,
        duration = 8,
        priority = 15,
        spellID = 5024,
        altName = select(1, GetSpellInfo(5024)) .. " - " .. (select(1, GetItemInfo(4984)) or "Skull of Impending Doom"),
    },
    -- Will of the Forsaken
    [GetSpellInfo(7744)] = {
        track = AURA_TYPE_BUFF,
        duration = 5,
        priority = 15,
        spellID = 7744,
    },
}
function Gladdy:GetImportantAuras()
    return importantAuras
end

local interrupts = {
    [GetSpellInfo(19675)] = {duration = 4, spellID = 19675, track = AURA_TYPE_DEBUFF, texture = select(3, GetSpellInfo(19675)), priority = 15}, -- Feral Charge Effect (Druid)
    [GetSpellInfo(2139)] = {duration = 8, spellID = 2139, track = AURA_TYPE_DEBUFF, texture = select(3, GetSpellInfo(2139)), priority = 15}, -- Counterspell (Mage)
    [GetSpellInfo(1766)] = {duration = 5, spellID = 1766, track = AURA_TYPE_DEBUFF, texture = select(3, GetSpellInfo(1766)), priority = 15}, -- Kick (Rogue)
    [GetSpellInfo(6552)] = {duration = 4, spellID = 6552, track = AURA_TYPE_DEBUFF, texture = select(3, GetSpellInfo(6552)), priority = 15}, -- Pummel (Warrior)
    [GetSpellInfo(72)] = {duration = 6, spellID = 72, track = AURA_TYPE_DEBUFF, texture = select(3, GetSpellInfo(72)), priority = 15}, -- Shield Bash (Warrior)
    [GetSpellInfo(8042)] = {duration = 2, spellID = 8042, track = AURA_TYPE_DEBUFF, texture = select(3, GetSpellInfo(8042)), priority = 15}, -- Earth Shock (Shaman)
    [GetSpellInfo(19244)] = {duration = 5, spellID = 19244, track = AURA_TYPE_DEBUFF, texture = select(3, GetSpellInfo(19244)), priority = 15}, -- Spell Lock (Warlock
    [GetSpellInfo(32747)] = {duration = 3, spellID = 32747, track = AURA_TYPE_DEBUFF, texture = select(3, GetSpellInfo(32747)), priority = 15}, -- Deadly Throw Interrupt
}
function Gladdy:GetInterrupts()
    return interrupts
end

local cooldownList = {
    -- Spell Name			   Cooldown[, Spec]
    -- Mage
    ["MAGE"] = {
        [1953] = 15, -- Blink
        --[122] 	= 22,    -- Frost Nova
        [12051] = 480, --Evocation
        [2139] = 24, -- Counterspell
        [45438] = { cd = 300, [L["Frost"]] = 240, }, -- Ice Block
        [12472] = { cd = 180, spec = L["Frost"], }, -- Icy Veins
        [31687] = { cd = 180, spec = L["Frost"], }, -- Summon Water Elemental
        [12043] = { cd = 180, spec = L["Arcane"], }, -- Presence of Mind
        [11129] = { cd = 180, spec = L["Fire"] }, -- Combustion
        [120] = { cd = 10,
                  sharedCD = {
                      [31661] = true, -- Cone of Cold
                  }, spec = L["Fire"] }, -- Dragon's Breath
        [31661] = { cd = 20,
                    sharedCD = {
                        [120] = true, -- Cone of Cold
                    }, spec = L["Fire"] }, -- Dragon's Breath
        [12042] = { cd = 180, spec = L["Arcane"], }, -- Arcane Power
        [11958] = { cd = 384, spec = L["Frost"], -- Coldsnap
                    resetCD = {
                        [12472] = true,
                        [45438] = true,
                        [31687] = true,
                    },
        },
    },

    -- Priest
    ["PRIEST"] = {
        [10890] = { cd = 27, [L["Shadow"]] = 23, }, -- Psychic Scream
        [15487] = { cd = 45, spec = L["Shadow"], }, -- Silence
        [10060] = { cd = 180, spec = L["Discipline"], }, -- Power Infusion
        [33206] = { cd = 120, spec = L["Discipline"], }, -- Pain Suppression
        [34433] = 300, -- Shadowfiend
        [32379] = 12, -- Shadow Word: Death
        [6346] = 180, -- Fear Ward
    },

    -- Druid
    ["DRUID"] = {
        [22812] = 60, -- Barkskin
        [29166] = 360, -- Innervate
        [8983] = 60, -- Bash
        [16689] = 60, -- Natures Grasp
        [18562] = { cd = 15, spec = L["Restoration"], }, -- Swiftmend
        [17116] = { cd = 180, spec = L["Restoration"], }, -- Natures Swiftness
        [33831] = { cd = 180, spec = L["Balance"], }, -- Force of Nature
    },

    -- Shaman
    ["SHAMAN"] = {
        [8042] = { cd = 6, -- Earth Shock
                   sharedCD = {
                       [8056] = true, -- Frost Shock
                       [8050] = true, -- Flame Shock
                   },
        },
        [30823] = { cd = 120, spec = L["Enhancement"], }, -- Shamanistic Rage
        [16166] = { cd = 180, spec = L["Elemental"], }, -- Elemental Mastery
        [16188] = { cd = 180, spec = L["Restoration"], }, -- Natures Swiftness
        [16190] = { cd = 300, spec = L["Restoration"], }, -- Mana Tide Totem
        [8177] = 15, -- Grounding Totem
    },

    -- Paladin
    ["PALADIN"] = {
        [10278] = 180, -- Blessing of Protection
        [1044] = 25, -- Blessing of Freedom
        [10308] = { cd = 60, [L["Retribution"]] = 40, }, -- Hammer of Justice
        [642] = { cd = 300, -- Divine Shield
                  sharedCD = {
                      cd = 60, -- no actual shared CD but debuff
                      [31884] = true,
                  },
        },
        [31884] = { cd = 180, spec = L["Retribution"], -- Avenging Wrath
                    sharedCD = {
                        cd = 60,
                        [642] = true,
                    },
        },
        [20066] = { cd = 60, spec = L["Retribution"], }, -- Repentance
        [31842] = { cd = 180, spec = L["Holy"], }, -- Divine Illumination
        [31935] = { cd = 30, spec = L["Protection"], }, -- Avengers Shield

    },

    -- Warlock
    ["WARLOCK"] = {
        [17928] = 40, -- Howl of Terror
        [27223] = 120, -- Death Coil
        [19647] = 24,	-- Spell Lock
        [27277] = 8,	-- Devour Magic
        [30414] = { cd = 20, spec = L["Destruction"], }, -- Shadowfury
        [17877] = { cd = 15, spec = L["Destruction"], }, -- Shadowburn
        [30912] = { cd = 10, spec = L["Destruction"], }, -- Conflagrate
        [18708] = { cd = 900, spec = L["Demonology"], }, -- Feldom
    },

    -- Warrior
    ["WARRIOR"] = {
        [6552] 	= { cd = 10,                              -- Pummel
           sharedCD = {
              [72] = true,
           },
        },
        --[[72] 	   = { cd = 12,                              -- Shield Bash
           sharedCD = {
              [6552] = true,
           },
        }, ]]
        --[23920] 	= 10,    -- Spell Reflection
        [3411] = 30, -- Intervene
        [676] = 60, -- Disarm
        [5246] = 180, -- Intimidating Shout
        [18499] = 30, -- Berserker Rage
        --[2565] 	= 60,    -- Shield Block
        [12292] = { cd = 180, spec = L["Arms"], }, -- Death Wish
        [20252] = { cd = 25, [L["Arms"]] = 15 }, -- Intercept
        [12975] = { cd = 180, spec = L["Protection"], }, -- Last Stand
        [12809] = { cd = 30, spec = L["Protection"], }, -- Concussion Blow

    },

    -- Hunter
    ["HUNTER"] = {
        [19503] = 30, -- Scatter Shot
        [14327] = 30, -- Scare Beast
        [19263] = 300, -- Deterrence; not on BM but can't do 2 specs


        [13809] = { cd = 30, -- Frost Trap
                    sharedCD = {
                        [14311] = true, -- Freezing Trap
                        [34600] = true, -- Snake Trap
                    },
                    icon = select(3, GetSpellInfo(14311)),
        },
        [14311] = { cd = 30, -- Freezing Trap
                    sharedCD = {
                        [13809] = true, -- Frost Trap
                        [34600] = true, -- Snake Trap
                    },
                    icon = select(3, GetSpellInfo(14311)),
        },
        [34600] = { cd = 30, -- Snake Trap
                    sharedCD = {
                        [14311] = true, -- Freezing Trap
                        [13809] = true, -- Frost Trap
                    },
                    icon = select(3, GetSpellInfo(14311)),
        },
        [34490] = { cd = 20, spec = L["Marksmanship"], }, -- Silencing Shot
        [19386] = { cd = 120, spec = L["Survival"], }, -- Wyvern Sting
        [19577] = { cd = 60, spec = L["Beast Mastery"], }, -- Intimidation
        [34471] = { cd = 120, spec = L["Beast Mastery"], }, -- The Beast Within
        [5384] = 30, -- Feign Death
        [3034] = 15, -- Viper Sting
        [1543] = 20, -- Flare
    },

    -- Rogue
    ["ROGUE"] = {
        [1766] 	= 10,    -- Kick
        [8643] 	= 20,    -- Kidney Shot
        [31224] = 60, -- Cloak of Shadow
        [26889] = { cd = 300, [L["Subtlety"]] = 180, }, -- Vanish
        [2094] = { cd = 180, [L["Subtlety"]] = 90, }, -- Blind
        [11305] = { cd = 300, [L["Combat"]] = 180, }, -- Sprint
        [26669] = { cd = 300, [L["Combat"]] = 180, }, -- Evasion
        [14177] = { cd = 180, spec = L["Assassination"], }, -- Cold Blood
        [13750] = { cd = 300, spec = L["Combat"], }, -- Adrenaline Rush
        [13877] = { cd = 120, spec = L["Combat"], }, -- Blade Flurry
        [36554] = { cd = 30, spec = L["Subtlety"], }, -- Shadowstep
        [14185] = { cd = 600, spec = L["Subtlety"], -- Preparation
                    resetCD = {
                        [26669] = true,
                        [11305] = true,
                        [26889] = true,
                        [14177] = true,
                        [36554] = true,
                    },
        },
    },
    ["Scourge"] = {

    },
    ["BloodElf"] = {

    },
    ["Tauren"] = {

    },
    ["Orc"] = {

    },
    ["Troll"] = {

    },
    ["NightElf"] = {
        [2651] = { cd = 180, spec = L["Discipline"], class = "PRIEST"}, -- Elune's Grace
        [10797] = { cd = 30, spec = L["Discipline"], class = "PRIEST"}, -- Star Shards
    },
    ["Draenei"] = {
        [32548] = { cd = 300, spec = L["Discipline"], class = "PRIEST"}, -- Hymn of Hope
    },
    ["Human"] = {
        [13908] = { cd = 600, spec = L["Discipline"], class = "PRIEST"}, -- Desperate Prayer
    },
    ["Gnome"] = {
    },
    ["Dwarf"] = {
        [13908] = { cd = 600, spec = L["Discipline"], class = "PRIEST"}, -- Desperate Prayer
    },
}
function Gladdy:GetCooldownList()
    return cooldownList
end

local racials = {
    ["Scourge"] = {
        [7744] = true, -- Will of the Forsaken
        duration = 120,
        spellName = select(1, GetSpellInfo(7744)),
        texture = select(3, GetSpellInfo(7744))
    },
    ["BloodElf"] = {
        [28730] = true, -- Arcane Torrent
        duration = 120,
        spellName = select(1, GetSpellInfo(28730)),
        texture = select(3, GetSpellInfo(28730))
    },
    ["Tauren"] = {
        [20549] = true, -- War Stomp
        duration = 120,
        spellName = select(1, GetSpellInfo(20549)),
        texture = select(3, GetSpellInfo(20549))
    },
    ["Orc"] = {
        [20572] = true,
        [33697] = true,
        [33702] = true,
        duration = 120,
        spellName = select(1, GetSpellInfo(20572)),
        texture = select(3, GetSpellInfo(20572))
    },
    ["Troll"] = {
        [20554] = true,
        [26296] = true,
        [26297] = true,
        duration = 180,
        spellName = select(1, GetSpellInfo(20554)),
        texture = select(3, GetSpellInfo(20554))
    },
    ["NightElf"] = {
        [20580] = true,
        duration = 10,
        spellName = select(1, GetSpellInfo(20580)),
        texture = select(3, GetSpellInfo(20580))
    },
    ["Draenei"] = {
        [28880] = true,
        duration = 180,
        spellName = select(1, GetSpellInfo(28880)),
        texture = select(3, GetSpellInfo(28880))
    },
    ["Human"] = {
        [20600] = true, -- Perception
        duration = 180,
        spellName = select(1, GetSpellInfo(20600)),
        texture = select(3, GetSpellInfo(20600))
    },
    ["Gnome"] = {
        [20589] = true, -- Escape Artist
        duration = 105,
        spellName = select(1, GetSpellInfo(20589)),
        texture = select(3, GetSpellInfo(20589))
    },
    ["Dwarf"] = {
        [20594] = true, -- Stoneform
        duration = 180,
        spellName = select(1, GetSpellInfo(20594)),
        texture = select(3, GetSpellInfo(20594))
    },
}
function Gladdy:Racials()
    return racials
end


---------------------
-- TOTEM STUFF
---------------------

local totemData = {
    -- Fire
    -- Water
    [string_lower("Poison Cleansing Totem")] = {id = 8166,texture = select(3, GetSpellInfo(8166)), color = {r = 0, g = 0, b = 0, a = 1}, pulse = 5},
    [string_lower("Mana Spring Totem")] = {id = 5675,texture = select(3, GetSpellInfo(5675)), color = {r = 0, g = 0, b = 0, a = 1}, pulse = 2},
    -- Earth
    -- Air
    [string_lower("Grace of Air Totem")] = {id = 8835,texture = select(3, GetSpellInfo(8835)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Windwall Totem")] = {id = 15107,texture = select(3, GetSpellInfo(15107)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Tranquil Air Totem")] = {id = 25908,texture = select(3, GetSpellInfo(25908)), color = {r = 0, g = 0, b = 0, a = 1}},
}

local totemSpellIdToPulse = {
    [GetSpellInfo(totemData[string_lower("Poison Cleansing Totem")].id)] = totemData[string_lower("Poison Cleansing Totem")].pulse,
    [8166] = totemData[string_lower("Poison Cleansing Totem")].pulse,
    [GetSpellInfo(totemData[string_lower("Mana Spring Totem")].id)] = totemData[string_lower("Mana Spring Totem")].pulse,
    [5675] = totemData[string_lower("Mana Spring Totem")].pulse, -- Rank 1
    [10495] = totemData[string_lower("Mana Spring Totem")].pulse, -- Rank 2
    [10496] = totemData[string_lower("Mana Spring Totem")].pulse, -- Rank 3
    [10497] = totemData[string_lower("Mana Spring Totem")].pulse, -- Rank 4
    [25570] = totemData[string_lower("Mana Spring Totem")].pulse, -- Rank 5
    [58771] = totemData[string_lower("Mana Spring Totem")].pulse, -- Rank 6
    [58773] = totemData[string_lower("Mana Spring Totem")].pulse, -- Rank 7
    [58774] = totemData[string_lower("Mana Spring Totem")].pulse, -- Rank 8
}

local totemNpcIdsToTotemData = {
    --fire
    -- Water
    [5923] = totemData[string_lower("Poison Cleansing Totem")],
    [22487] = totemData[string_lower("Poison Cleansing Totem")],

    -- Earth
    -- Air
    [7486] = totemData[string_lower("Grace of Air Totem")],
    [7487] = totemData[string_lower("Grace of Air Totem")],
    [15463] = totemData[string_lower("Grace of Air Totem")],

    [9687] = totemData[string_lower("Windwall Totem")],
    [9688] = totemData[string_lower("Windwall Totem")],
    [9689] = totemData[string_lower("Windwall Totem")],
    [15492] = totemData[string_lower("Windwall Totem")],

    [15803] = totemData[string_lower("Tranquil Air Totem")],
}

local totemDataShared, totemNpcIdsToTotemDataShared, totemSpellIdToPulseShared = Gladdy:GetSharedTotemData()
Gladdy:AddEntriesToTable(totemData, totemDataShared)
Gladdy:AddEntriesToTable(totemNpcIdsToTotemData, totemNpcIdsToTotemDataShared)
Gladdy:AddEntriesToTable(totemSpellIdToPulse, totemSpellIdToPulseShared)

function Gladdy:GetTotemData()
    return totemData, totemNpcIdsToTotemData, totemSpellIdToPulse
end
