-----------------------------------------------------------------------------------
-- It's a better idea to edit userconfig.lua in NugRunningUserConfig addon folder
-- CONFIG GUIDE: https://github.com/rgd87/NugRunning/wiki/NugRunningUserConfig
-----------------------------------------------------------------------------------
local _, helpers = ...
local Spell = helpers.Spell
local ModSpell = helpers.ModSpell
local Cooldown = helpers.Cooldown
local Activation = helpers.Activation
local EventTimer = helpers.EventTimer
local Cast = helpers.Cast
local Item = helpers.Item
local Anchor = helpers.Anchor
local Talent = helpers.Talent
local Totem = helpers.Totem
local Glyph = helpers.Glyph
local GetCP = helpers.GetCP
local SPECS = helpers.SPECS
local IsPlayerSpell = IsPlayerSpell
local IsUsableSpell = IsUsableSpell
local _,class = UnitClass("player")

NugRunningConfig.nameplates.parented = true

NugRunningConfig.colors = {}
local colors = NugRunningConfig.colors
colors["RED"] = { 0.8, 0, 0}
colors["RED2"] = { 1, 0, 0}
-- colors["RED3"] = { 183/255, 58/255, 93/255}
colors["LRED"] = { 1,0.4,0.4}
colors["DRED"] = { 0.55,0,0}
colors["CURSE"] = { 0.6, 0, 1 }
colors["PINK"] = { 1, 0.3, 0.6 }
colors["PINK2"] = { 1, 0, 0.5 }
colors["PINK3"] = { 226/255, 35/255, 103/255 }
colors["PINKIERED"] = { 206/255, 4/256, 56/256 }
colors["TEAL"] = { 0.32, 0.52, 0.82 }
colors["TEAL2"] = {38/255, 221/255, 163/255}
colors["TEAL3"] = {52/255, 172/255, 114/255}
colors["DTEAL"] = {15/255, 78/255, 60/255}
colors["ORANGE"] = { 1, 124/255, 33/255 }
colors["ORANGE2"] = { 1, 66/255, 0 }
colors["FIRE"] = {1,80/255,0}
colors["LBLUE"] = {149/255, 121/255, 214/255}
colors["DBLUE"] = { 50/255, 34/255, 151/255 }
colors["GOLD"] = {1,0.7,0.5}
colors["LGREEN"] = { 0.63, 0.8, 0.35 }
colors["GREEN"] = {0.3, 0.9, 0.3}
colors["DGREEN"] = { 0, 0.35, 0 }
colors["PURPLE"] = { 187/255, 75/255, 128/255 }
colors["PURPLE2"] = { 188/255, 37/255, 186/255 }
colors["BURGUNDY"] = { 102/255, 22/255, 49/255 }
colors["REJUV"] = { 1, 0.2, 1}
colors["PURPLE3"] = { 64/255, 48/255, 109/255 }
colors["PURPLE4"] = { 121/255, 29/255, 57/255 }
colors["PURPLE5"] = { 0.49, 0.16, 0.60 }
colors["DPURPLE"] = {74/255, 14/255, 85/255}
colors["DPURPLE2"] = {0.37, 0, 0.6}
colors["CHIM"] = {199/255, 130/255, 255/255}
colors["FROZEN"] = { 65/255, 110/255, 1 }
colors["CHILL"] = { 0.6, 0.6, 1}
colors["BLACK"] = {0.35,0.35,0.35}
colors["SAND"] = { 168/255, 75/255, 11/255 }
colors["WOO"] = {151/255, 86/255, 168/255}
colors["WOO2"] = {80/255, 83/255, 150/255}
colors["WOO2DARK"] = {30/255, 30/255, 65/255}
colors["BROWN"] = { 192/255, 77/255, 48/255}
colors["DBROWN"] = { 118/255, 69/255, 50/255}
colors["MISSED"] = { .15, .15, .15}
colors["DEFAULT_DEBUFF"] = { 0.8, 0.1, 0.7}
colors["DEFAULT_BUFF"] = { 1, 0.4, 0.2}

local DotSpell = function(id, opts)
    if type(opts.duration) == "number" then
        local m = opts.duration*0.3 - 0.2
        -- opts.recast_mark = m
        opts.overlay = {0, m, 0.25}
    end
    return Spell(id,opts)
end
helpers.DotSpell = DotSpell


local Interrupt = function(id, name, duration)
    EventTimer(id, { event = "SPELL_INTERRUPT", short = "Interrupted", name = name, target = "pvp", duration = duration,  scale = 0.75, shine = true, color = colors.LBLUE })
end
helpers.Interrupt = Interrupt

local isMainline = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
if not isMainline then return end

local _, race = UnitRace("player")
-- if race == "Troll" then Spell( 26297 ,{ name = "Berserking", duration = 10 }) end --Troll Racial
-- if race == "Orc" then Spell({ 33702,33697,20572 },{ name = "Blood Fury", duration = 15 }) end --Orc Racial

Spell( 2825  ,{ name = "Bloodlust", group = "buffs", global = true, duration = 40, color = colors.DRED, shine = true, affiliation = "raid", target = "player" })
Spell( 32182 ,{ name = "Heroism", group = "buffs", global = true, duration = 40, color = colors.DRED, shine = true, affiliation = "raid", target = "player" })
Spell( 80353 ,{ name = "Time Warp", group = "buffs", global = true, duration = 40, color = colors.DRED, shine = true, affiliation = "raid", target = "player" })
Spell( 264667 ,{ name = "Primal Rage", group = "buffs", global = true, duration = 40, color = colors.DRED, shine = true, affiliation = "raid", target = "player" })
Spell( 230935 ,{ name = "Drums of the Mountain", short = "Drums", group = "buffs", global = true, duration = 40, color = colors.DRED, shine = true, affiliation = "raid", target = "player" })
Spell( 256740 ,{ name = "Drums of the Maelstrom", short = "Drums", group = "buffs", global = true, duration = 40, color = colors.DRED, shine = true, affiliation = "raid", target = "player" })


-- Essences
Spell( 297108, { name = "Blood of the Enemy", global = true, duration = 10, maxtimers = 1, scale = 0.8, arrow = colors.PINKIERED, glow2time = 5, shine = true, priority = -999999, color = colors.PINKIERED })
Spell( 295838, { name = "Condensed Life-Force", global = true, duration = 6, maxtimers = 1, group = "buffs", shine = true, priority = -999999, color = colors.PINKIERED })
Spell( 298357, { name = "Memory of Lucid Dreams", short = "Lucid Dreams", global = true, duration = 15, group = "buffs", shine = true, priority = -999999, color = colors.PINKIERED })

Spell( 299624, { name = "The Ever-Rising Tide", global = true, duration = 10, group = "buffs", shine = true, scale = 1, priority = -999998, color = colors.PINKIERED })
Spell( 296072, { name = "The Ever-Rising Tide", global = true, duration = 10, group = "buffs", shine = true, scale = 0.5, priority = -999999, color = colors.PURPLE3})

-- POTIONS
Spell( 344314, { name = "Potion of Psychopomp's Speed", short = "Speed", global = true, duration = 8, group = "buffs", shine = true, color = colors.LGREEN })
Spell( 307195, { name = "Potion of Invisibility", short = "Invisible", global = true, duration = 18, group = "buffs", shine = true, color = colors.LBLUE })
Spell( 307164, { name = "Potion of Spectral Strength", short = "Strength", global = true, duration = 25, group = "buffs", shine = true, color = colors.LRED })
Spell( 307159, { name = "Potion of Spectral Agility", short = "Agility", global = true, duration = 25, group = "buffs", shine = true, color = colors.LGREEN })
Spell( 307162, { name = "Potion of Spectral Intellect", short = "Intellect", global = true, duration = 25, group = "buffs", shine = true, color = colors.PINK })
Spell( 307494, { name = "Potion of Empowered Exorcisms", short = "Exorcisms", global = true, duration = 25, group = "buffs", shine = true, color = colors.REJUV })
Spell( 307495, { name = "Potion of Phantom Fire", short = "Phantom Fire", global = true, duration = 25, group = "buffs", shine = true, color = colors.REJUV })
Spell( 307496, { name = "Potion of Divine Awakening", short = "Divine Awakening", global = true, duration = 25, group = "buffs", shine = true, color = colors.REJUV })

-- SOULBINDS
Spell( 331937, { --[[Nadja]] name = "Euphoria", global = true, duration = 10, group = "buffs", shine = true, color = colors.LRED })


if class == "WARLOCK" then

-- [[ COVENANTS ]]
Spell( 312321 ,{ --[[Kyrian]] name = "Scouring Tithe", duration = 18, nameplates = true, ghost = 5, ghosteffect = "AEGWYNN", color = colors.WOO2 })
Spell( 325640 ,{ --[[Night Fae]] name = "Soul Rot", duration = 8, maxtimers = 1, ghost = 2, color = colors.WOO2 })


Interrupt(212619, "Call Felhunter", 6) -- pvp talent
Interrupt(119910, "Spell Lock", 6) -- Felhunter spell from action bar
Interrupt(19647, "Spell Lock", 6) -- Felhunter spell from pet bar
Interrupt(132409, "Spell Lock", 6) -- Command Demon after sacrificing Felhunter

-- [[ ARTIFACTS ]]
-- Spell( 216708 ,{ name = "Deadwind Harvester", ghost = true, duration = 25, group = "buffs", shine = true, priority = -100, color = colors.PURPLE3 })
-- Cooldown( 211714 ,{ name = "Thal'kiel's Consumptions", ghost = true, scale_until = 10, color = colors.DBLUE })
-- Cooldown( 196586 ,{ name = "Dimensional Rift", ghost = true, scale_until = 10, priority = -1, color = colors.PURPLE3 })


Spell( 1714 ,{ name = "Curse of Tongues", duration = 30, scale = 0.8, color = colors.CURSE })
Spell( 702 ,{ name = "Curse of Weakness", duration = 120, scale = 0.8, color = colors.CURSE })
Spell( 321997 ,{ name = "Curse of Recklessness", duration = 120, scale = 0.8, color = colors.CURSE })
Spell( 334275 ,{ name = "Curse of Exhaustion", duration = 12, scale = 0.8, color = colors.CURSE })

-- pvp
Spell( 234877 ,{ name = "Bane of Shadows", duration = 10, scale = 0.8, color = colors.CURSE })
Spell( 236471 ,{ name = "Soulshatter", duration = 8, group = "buffs", color = colors.PINKIERED })
Spell( 212295 ,{ name = "Nether Ward", duration = 3, group = "buffs", color = colors.LBLUE })
Spell( 221715 ,{ name = "Essence Drain", duration = 6, group = "buffs", scale = 0.8, color = colors.CHIM })
EventTimer({ spellID = 221703, event = "SPELL_CAST_SUCCESS", group = "buffs", name = "Casting Circle", duration = 8,  scale = 0.8, color = colors.WOO })


Spell( 264571 ,{ name = "Nightfall", duration = 12, priority = 15, scale = 0.75, color = colors.DPURPLE, glowtime = 12 })
Cooldown( 264106 ,{ name = "Deathbolt", ghost = true, scale_until = 5, color = colors.PURPLE2 })
Spell( 113860 ,{ name = "Dark Soul: Misery", short = "Dark Soul", group = "buffs", duration = 20, color = colors.CURSE })
Spell( 113858 ,{ name = "Dark Soul: Instability", short = "Dark Soul", group = "buffs", duration = 20, color = colors.CURSE })
Spell( 267218 ,{ name = "Nether Portal", group = "buffs", duration = 15, color = colors.CURSE })
Cooldown( 264119 ,{ name = "Summon Vilefiend", ghost = true, scale_until = 10, color = colors.DBLUE })
Cooldown( 264057 ,{ name = "Soul Strike", ghost = true, color = colors.DBLUE })
Cooldown( 196447 ,{ name = "Demonfire", ghost = true, color = colors.DTEAL, scale_until = 8 })
Spell( 205178, { name = "Soul Effigy", duration = 600, priority = -1, scale = 0.7, color = colors.PURPLE3 })
Spell( 205179, { name = "Phantom Singularity", duration = 16, color = colors.PURPLE4, scale = 0.7 })
Spell( 278350, { name = "Vile Taint", duration = 10, color = colors.PURPLE4, scale = 0.7, maxtimers = 1 })
-- Cooldown( 205179, { name = "Phantom Singularity", hide_until = 15, priority = -1, color = colors.DPURPLE, color2 = colors.PURPLE4 })

Spell( 111400 ,{ name = "Burning Rush",duration = 20, timeless = true, color = colors.PURPLE2 })
--Immolate
Spell( 157736,{ name = "", preghost = true, recast_mark = 5.3, overlay = {0, 5.3, 0.2}, maxtimers = 4, duration = 18, nameplates = true, priority = 10, ghost = 5, color = colors.RED,
isknowncheck = function()
    return IsPlayerSpell(348)
end })


Spell( 117828 ,{ name = "Backdraft", duration = 15, shine = true, priority = -4, shinerefresh = true, color = colors.PURPLE3, scale = 0.5 })

Cooldown( 205180,{ name = "Summon Darkglare", color = colors.DTEAL, scale_until = 12, ghost = true })

EventTimer({ event = "SPELL_SUMMON", spellID = 60478, name = "Doomguard", group = "buffs", duration = 25, color = colors.BLACK })
EventTimer({ event = "SPELL_SUMMON", spellID = 111685, name = "Infernal", group = "buffs", duration = 25, color = colors.BLACK })

EventTimer({ event = "SPELL_SUMMON", spellID = 111859, name = "Grimoire: Imp", group = "buffs", duration = 25, color = colors.TEAL3 })
EventTimer({ event = "SPELL_SUMMON", spellID = 111895, name = "Grimoire: Voidwalker", group = "buffs", duration = 25, color = colors.TEAL3 })
EventTimer({ event = "SPELL_SUMMON", spellID = 111896, name = "Grimoire: Succubus", group = "buffs", duration = 25, color = colors.TEAL3 })
EventTimer({ event = "SPELL_SUMMON", spellID = 111897, name = "Grimoire: Felhunter", group = "buffs", duration = 25, color = colors.TEAL3 })
EventTimer({ event = "SPELL_SUMMON", spellID = 111898, name = "Grimoire: Felguard", group = "buffs", duration = 25, color = colors.TEAL3 })

Cooldown( 104316, { name = "Dreadstalkers", ghost = true, color = colors.DRED })


Spell( 264173,{ name = "Demonic Core", duration = 20, color = colors.PURPLE4, group = "buffs", priority = -100 })


-- EventTimer({ spellID = 104317, event = "SPELL_SUMMON", duration = 12, color = colors.WOO })

Spell( 80240 ,{ name = "Havoc", nameplates = true, duration = 8, color = colors.PINK2, scale = 0.8, ghost = true })

Spell( 196414 ,{ name = "Eradication", nameplates = true, duration = 8, color = colors.DPURPLE2, scale = 0.75, ghost = true })

Cooldown( 17962, { name = "Conflagrate", ghost = true, priority = 5, color = colors.PINK, stackcolor = { colors.PINK, colors.PURPLE4 } })

Spell( 205146,{ name = "Demonic Calling", group = "buffs", duration = 20, shine = true, shinerefresh = true, scale = 0.5, color = colors.TEAL2 })

DotSpell( 603 ,{ name = "Doom", duration = 20, nameplates = true, ghost = true, priority = 6, color = colors.DPURPLE2 })

Spell( 265273 ,{ name = "Demonic Power", group = "buffs", duration = 15, color = colors.WOO2, target = "player" })

-- Cooldown( 105174, { name = "Hand of Gul'dan",  ghost = true, shinerefresh = true, color = colors.CURSE })

Spell( 104773,{ name = "Unending Resolve",duration = 12, color = colors.WOO2, group = "buffs" })

Spell( 86211 ,{ name = "Soul Swap", duration = 20, shine = true, color = colors.BLACK })

Spell( 198590 ,{ name = "Drain Soul", short = "", tick = 1, overlay = {"tick", "tickend"},  priority = 14, duration = 6, color = colors.CURSE })
Spell( 234153 ,{ name = "Drain Life", tick = 1, overlay = {"tick", "tickend"},  priority = 14, duration = 6, color = colors.CURSE })

local normalize_dots_to = nil--26

--Haunt
Spell( 48181 ,{ name = "Haunt", priority = 8, ghost = true, color = colors.TEAL, duration = 18, overlay = {0, 3} })

local creeping_death = function(self)
    local duration = IsPlayerSpell(264000) and self.duration*0.85 or self.duration
    if self.overlay then
        self.overlay[2] = duration*0.3
    end
    self.recast_mark = duration*0.3
end

--Unstable Affliction, UA with Rampant Afflications
Spell({ 316099, 342938 } ,{ name = "", duration = 16, overlay = {0, 4.8, 0.2}, priority = 10, nameplates = true, ghost = true, color = colors.PINK2,
    init = function(self)
        self.duration = IsPlayerSpell(334315) and 21 or 16
        creeping_death(self)
    end
})
--Agony
Spell( 980 ,{ name = "", preghost = 5, duration = 18, recast_mark = 5.4, overlay = {0, 5.4, 0.2},  fixedlen = normalize_dots_to, nameplates = true, _ignore_applied_dose = true, ghost = 6, priority = 6, color = colors.WOO, init = creeping_death })
--Corruption
Spell( 146739 ,{ name = "", preghost = 5, maxtimers = 5, duration = 14, recast_mark = 4.2, overlay = {0,4.2, 0.2}, priority = 9, fixedlen = normalize_dots_to, nameplates = true, ghost = 6, color = colors.PINKIERED,
    init = function(self)
        if IsPlayerSpell(196103) then -- Absolute Corruption
            self.scale = 0.7
            self.priority = 0.1
            self.timeless = true
        else
            self.scale = 1
            self.priority = 9
            self.timeless = false
        end
        creeping_death(self)
    end,
    isknowncheck = function()
        return IsPlayerSpell(172)
    end})
--Siphon Life
Spell( 63106 ,{ name = "", preghost = 5, duration = 15, recast_mark = 4.5, overlay = {0, 4.5, 0.2}, priority = 5, fixedlen = normalize_dots_to, nameplates = true, ghost = 6, color = colors.DTEAL, init = creeping_death,
    isknowncheck = function()
        return IsPlayerSpell(63106)
    end })


Spell( 27243 ,{ name = "Seed of Corruption",duration = 18, nameplates = true,  color = colors.DBLUE, short = "SoC" })

--
-- EventTimer({ spellID = 86121, event = "SPELL_CAST_SUCCESS",
--     action = function(active, srcGUID, dstGUID, spellID )
--         NugRunning:SoulSwapStore(active, srcGUID, dstGUID, spellID )
--     end})
--
-- EventTimer({ spellID = 86213, event = "SPELL_CAST_SUCCESS",
--     action = function(active, srcGUID, dstGUID, spellID )
--         NugRunning:SoulSwapUsed(active, srcGUID, dstGUID, spellID )
--     end})

Spell( 6358 ,{ name = "Seduction",duration = 30, pvpduration = 8 })
Spell( 89766 ,{ name = "Axe Toss", color = colors.BROWN, duration = 4 })

Spell( 6789 ,{ name = "Mortal Coil", duration = 3 })
Spell( 5484 ,{ name = "Howl of Terror", duration = 20, pvpduration = 8, maxtimers = 1 })
Spell( 108416 ,{ name = "Dark Pact", duration = 10, group = "buffs", color = colors.DPURPLE })
Spell( 30283 ,{ name = "Shadowfury", duration = 3, maxtimers = 1 })

-- Spell( 5782 ,{ name = "Fear", duration = 20, nameplates = true, pvpduration = 8 }) --old id
Spell( 118699 ,{ name = "Fear", duration = 20, pvpduration = 8 })
Spell( 710 ,{ name = "Banish", nameplates = true, duration = 30 })
end

if class == "PRIEST" then

-- [[ COVENANTS ]]
Spell( 325013 ,{ --[[Kyrian]] name = "Boon of the Ascended", group = "buffs", priority = -7, duration = 10, color = colors.PINK3 })
Spell( 323673 ,{ --[[Venthyr]] name = "Mindgames", duration = 5, color = colors.LRED })
Spell( 325203 ,{ --[[Necrolord]] name = "Unholy Transfusion", duration = 15, maxtimers = 1, ghost = 2, color = colors.TEAL3 })
Spell( 327661 ,{ --[[Night Fae]] name = "Fae Guardians", group = "buffs", priority = -7, duration = 20, ghost = 2, color = colors.PINK3 })


-- PVP
Spell( 232707 ,{ name = "Ray of Hope", shine = true, group = "buffs", color = colors.LBLUE, duration = 6, scale = 1, priority = 15  })


-- [[ ARTIFACTS ]]
-- Cooldown( 205065,{ name = "Void Torrent", color = colors.DTEAL, ghost = true, scale_until = 10 })
-- Cooldown( 207946,{ name = "Light's Wrath", color = colors.DTEAL, ghost = true, scale_until = 10 })

-- Spell( 196762 ,{ name = "Inner Focus", shine = true, color = colors.LBLUE, group = "buffs", priority = -200, timeless = true, duration = 1 })

Cooldown( 263165,{ name = "Void Torrent", color = colors.DTEAL, ghost = true, scale_until = 10 })
Cooldown( 2050,{ name = "Serenity", color = colors.LBLUE, priority = -10, ghosteffect = "AEGWYNN", ghost = true, scale = .8 })
Cooldown( 34861,{ name = "Sanctify", color = colors.GOLD, priority = -9, ghosteffect = "JUDGEMENT", ghost = true, scale = .8 })

-- Cooldown( 17,{ name = "Power Word: Shield", priority = -10, scale = 0.5, color = colors.PINKIERED, ghost = true })

Spell( 198069 ,{ name = "Dark Side", shine = true, color = colors.WOO, duration = 20,  scale = .7, priority = 15, glowtime = 5  })
Spell( 322105 ,{ name = "Shadow Covenant", group = "buffs", color = colors.PURPLE3, duration = 6,  scale = .8  })

Spell( 139 ,{ name = "Renew", shinerefresh = true, color = colors.LGREEN, duration = 12,  scale = .7,  })
Spell( 17 ,{ name = "Power Word: Shield", shinerefresh = true, duration = 15, color = colors.LRED })

Spell( 41635 ,{ name = "Prayer of Mending", shinerefresh = true, duration = 30, color = colors.TEAL3, scale = .7, textfunc = function(timer) return timer.dstName end })
Spell( 47788 ,{ name = "Guardian Spirit", shine = true, duration = 10, color = colors.PINK, short = "Guardian" })
Spell( 33206 ,{ name = "Pain Suppression",shine = true, duration = 8, color = colors.PINK })
Spell( 586 ,{ name = "Fade",duration = 10 })
-- Spell( 89485 ,{ name = "Inner Focus", shine = true, color = colors.LBLUE, timeless = true, duration = 0.1 })
-- Spell( 49694,59000 ,{ name = "Improved Spirit Tap",duration = 8 })
-- Spell( 15271 ,{ name = "Spirit Tap",duration = 15 })

Spell( 109964 ,{ name = "Spirit Shell",duration = 12, color = colors.PINK, shine = true, group = "buffs", ghost = 1 })

Spell( 341207 ,{ name = "Dark Thought", duration = 6, glowtime = 6, color = colors.PURPLE5, effect = "NIGHTBORNE", priority = 13 })
DotSpell( 204213 ,{ name = "Purge the Wicked", short = "", preghost = true, duration = 20, ghost = true, nameplates = true, priority = 9, color = colors.PURPLE, maxtimers = 5,
                isknowncheck = function() return IsPlayerSpell(204197) end })
DotSpell( 589 ,{ name = "Shadow Word: Pain", short = "", preghost = true, duration = 16, ghost = true, maxtimers = 4, nameplates = true, fixedlen = 16, priority = 9, color =colors.PURPLE,
                isknowncheck = function() return IsPlayerSpell(589) and not IsPlayerSpell(204197) end, })
DotSpell( 34914 ,{ name = "Vampiric Touch", short = "", preghost = true, ghost = true, nameplates = true, fixedlen = 21, priority = 10, duration = 21, color = colors.RED,  })
Spell( 335467 ,{ name = "Devouring Plague", short = "", shine = true, duration = 6, ghost = 1, nameplates = true, priority = 8.5, color = colors.WOO })

-- Cooldown( 228260,{ name = "Void Eruption", color = colors.REJUV, ghost = 6, isknowncheck = function() end })
Cooldown( 200174,{ name = "Mindbender", color = colors.PURPLE3, effecttime = 2, effect = "BLOODBOIL", ghost = 6, scale_until = 10 })

-- EventTimer({ event = "SPELL_SUMMON", spellID = 200174, name = "Mindbender", group = "buffs", duration = 15, priority = -10, color = colors.BLACK })
EventTimer({ event = "SPELL_SUMMON", spellID = 34433, name = "Shadowfiend", group = "buffs", duration = 12, priority = -10, color = colors.BLACK })

Spell( 47585 ,{ name = "Dispersion",duration = 6, color = colors.PURPLE })
-- Spell( 15286 ,{ name = "Vampiric Embrace",duration = 15, color = colors.CURSE, short = "VampEmbrace" })

Spell( 123254, { name = "Twist of Fate", duration = 10, group = "buffs", priority = -10, color = colors.CURSE, specmask = SPECS(1,2) })
Spell( 10060, { name = "Power Infusion", duration = 20, group = "buffs", color = colors.TEAL3, global = true, affiliation = "raid" })
Cooldown( 10060, { name = "Power Infusion", color = colors.DBROWN, scale_until = 10, })
-- Spell( 205372, { name = "Void Ray", duration = 6, group = "buffs", priority = -20, scale = 0.5, color = colors.PINK3 })
Spell( 194249 ,{ name = "Voidform", duration = 1, arrow = colors.REJUV, priority = -20, scale = 0.8, group = "buffs", shine = true, color = colors.PINK3 })
Cooldown( 228260 ,{ name = "Voidform", color = colors.REJUV, scale_until = 10, shine = true, ghost = 7, ghosteffect = "JUDGEMENT", priority = -20 })
Spell( 319952 ,{ name = "Surrender to Madness", short = "STM", duration = 25, arrow = colors.CURSE, priority = -21, group = "buffs", shine = true, color = colors.PURPLE4, target = "player" })

-- Spell( 47753 ,{ name = "Divine Aegis", duration = 12 })

Spell( 114255,{ name = "Surge of Light", duration = 20, color = colors.LRED })

Spell( 124430,{ name = "Shadowy Insight", duration = 12, color = colors.BLACK }) -- shadow

Spell( 9484 ,{ name = "Shackle Undead",duration = 50, pvpduration = 8, short = "Shackle" })
Spell( 15487 ,{ name = "Silence",duration = 5, color = colors.PINK })

Spell( 322098 ,{ name = "Death and Madness", duration = 7, scale = 0.6, color = colors.DPURPLE })
Spell( 64044 ,{ name = "Psychic Horror", duration = 3, pvpduration = 4 })
Spell( 8122 ,{ name = "Psychic Scream", duration = 8, maxtimers = 1 })
Spell( 205369,{ name = "Mind Bomb", duration = 4, maxtimers = 1 })
Spell( 47536,{ name = "Rapture", duration = 11, color = colors.LBLUE, group = "buffs", shine = true })
Spell( 200183,{ name = "Apotheosis", duration = 11, color = colors.LBLUE, group = "buffs", shine = true })
-- Spell( 64044 ,{ name = "Psychic Horror",duration = 1, maxtimers = 1 })

local priest_normalize = 7

Cast( 15407, { name = "Mind Flay", short = "", fixedlen = priest_normalize, priority = 12, tick = 1, color = colors.TEAL3, priority = 11, duration = 3, scale = 1 })
Cast( 48045, { name = "Mind Shear", short = "", fixedlen = priest_normalize, priority = 12, tick = 1, color = colors.TEAL2, priority = 11, duration = 3, scale = 1 })

Spell( 453, { name = "Mind Soothe", color = colors.PURPLE3, duration = 20 })
--Old Shadow Orbs
-- Spell( 77487 ,{ name = "",duration = 60, charged = true, maxcharge = 3, shine = true, shinerefresh = true, priority = -3, color = colors.WOO })

Cooldown( 47540 ,{ name = "Penance", tick = 1.5, overlay = {"tick", "tickend"}, fixedlen = 9, priority = 15, color = colors.TEAL3, ghost = true, ghost = 3, ghosteffect = "AEGWYNN" })

Spell( 214621, { name = "Schism", color = colors.PINKIERED, arrow = colors.PINKIERED, duration = 9 })
Cooldown( 214621, { name = "Schism", color = colors.PURPLE4, scale_until = 8, ghost = true })
Cooldown( 129250, { name = "PW:Solace", fixedlen = 9,  color = colors.WOO, priority = 7, ghost = true })

Cooldown( 205351, { name = "Shadow Word: Void", short = "Void", priority = 9, fixedlen = priest_normalize, color = colors.CURSE, resetable = true, ghost = true, stackcolor = { colors.CURSE, colors.DPURPLE2 } })
Cooldown( 8092, { name = "Mind Blast", priority = 9, fixedlen = priest_normalize, overlay = { 0, "gcd", 0.25 }, ghosteffect = "NIGHTBORNE", color = colors.CURSE, resetable = true, ghost = 7 })
-- EventTimer({ spellID = 8092, event = "SPELL_CAST_SUCCESS", priority = 12, name = "Mind Blast", duration = 0.5, color = colors.PINK,
-- isknowncheck = function()
--     -- local timer = NugRunning:FindFirstActiveTimer(341207)
--     return true
-- end
--  })

local UnitAura = UnitAura
local function FindAura(unit, spellID, filter)
    for i=1, 100 do
        local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, auraSpellID = UnitAura(unit, i, filter)
        if not name then return nil end
        if spellID == auraSpellID then
            return name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, auraSpellID
        end
    end
end

Cooldown( 205448, { name = "Void Bolt", priority = 10, fixedlen = priest_normalize, color = colors.PINKIERED, resetable = true, ghost = true,
    isknowncheck = function()
        return FindAura("player", 194249, "HELPFUL|PLAYER")
    end
})
EventTimer({ spellID = 194249, event = "SPELL_AURA_REMOVED", name = "VoidBoltCleanup",
    action = function(active, srcGUID, dstGUID, spellID, damage )
        local voidbolt_timer = NugRunning:FindActiveTimer(205448, UnitGUID("player"), "COOLDOWN")
        if voidbolt_timer then
            voidbolt_timer.isGhost = true
            voidbolt_timer:GhostExpire()
        end
    end})

Cooldown( 32379, { name = "Shadow Word: Death", short = "SW:Death",  color = colors.PURPLE, resetable = true  })

Cooldown( 205385, { name = "Shadow Crash", color = colors.WOO2, scale_until = 10 })

Cooldown( 110744, { name = "Divine Star", color = colors.DBLUE, fixedlen = 9, ghost = true})
Cooldown( 120517, { name = "Halo", color = colors.GOLD, fixedlen = 9, scale_until = 9 })

EventTimer({ event = "SPELL_CAST_SUCCESS", spellID = 62618, name = "PW:Barrier", duration = 10, color = colors.GOLD })
Spell( 271466 ,{ name = "Luminous Barrier", group = "buffs", duration = 10, color = colors.GOLD, target = "player" })
-- Spell( 81782 ,{ name = "Power Word: Barrier", short = "PW: Barrier", duration = 25, color = {1,0.7,0.5} }) -- duration actually used here, invisible aura applied

-- Spell( 81208 ,{ name = "Chakra: Serenity", short = "Serenity", color = colors.WOO, shine = true, timeless = true, duration = 9999 })
-- Spell( 81206 ,{ name = "Chakra: Sanctuary", color = colors.WOO2, short = "Sanctuary", shine = true, timeless = true, duration = 9999 })
-- Spell( 81209 ,{ name = "Chakra: Chastise", short = "Chastise", color = colors.RED, shine = true, timeless = true, duration = 9999 })
-- Spell( 88625 ,{ name = "Holy Word: Chastise", color = colors.LRED, short = "HW: Chastise", duration = 3 })
-- Cooldown( 88625 ,{ name = "Holy Word: Chastise", color = colors.CURSE, short = "Chastise", resetable = true })
Spell( 200200 ,{ name = "Holy Word: Chastise", short = "Castise", color = colors.RED, duration = 5 })


-- Cooldown( 34861 ,{ name = "Circle of Healing", priority = 15, color = colors.CURSE, resetable = true, ghost = true })
Cooldown( 33076 ,{ name = "Prayer of Mending", priority = 13, color = colors.PINKIERED, resetable = true, ghost = 6 })

-- Spell( 14914 ,{ name = "Holy Fire", priority = 14.1, color = colors.PINK, ghost = 3, duration = 7 }) --holy fire
Cooldown( 14914 ,{ name = "", priority = 14, color = colors.PINK, resetable = true }) --holy fire

--Spell( 81700 ,{ name = "Archangel",duration = 18, color = colors.CURSE })

--Spell({ 63731,63735 } ,{ name = "Serendipity",duration = 20, color = {0.4,0.4,0.9} })


-- helpers.TrackItemSet("Shadow_T15", {
--     96674, 96675, 96676, 96677, 96678, --heroic
--     95300, 95301, 95302, 95303, 95304, --normal
--     95930, 95931, 95932, 95933, 95934, --lfr
-- })
-- helpers.RegisterSetBonusCallback("Shadow_T15", 2,
--     function()
--         scanner = scanner or CreateFrame("Frame", nil, UIParent)
--         scanner:SetScript("OnUpdate", scannerOnUpdate)
--     end,
--     function()
--         scanner:SetScript("OnUpdate", nil)
--     end
-- )

end


if class == "ROGUE" then

-- [[ COVENANTS ]]
-- Spell( 324073 ,{ --[[Necrolord]] name = "Serrated Bone Spike", priority = -7, timeless = true, duration = 30, scale = 0.5, maxtimers = 1, color = colors.TEAL3 })

Interrupt(1766, "Kick", 5)

-- [[ ARTIFACTS ]]
-- Cooldown( 209782 ,{ name = "Goremaw's Bite", ghost = true, shine = true, minduration = 10, scale_until = 10, color = colors.DTEAL, priority = -10 })
-- Spell( 202665 ,{ name = "Curse of the Dreadblades", shine = true, duration = 12, color = colors.DTEAL })
-- Cooldown( 192759 ,{ name = "Kingsbane", ghost = true, minduration = 10, color = colors.DBLUE, scale_until = 10,  })
-- Spell( 192759 ,{ name = "Kingsbane", shine = true, duration = 14, color = colors.DGREEN })

EventTimer({ event = "SPELL_CAST_SUCCESS", spellID = 212182, name = "Smoke Bomb", color = colors.BLACK, duration = 5 })
Cooldown( 269513,{ name = "Death from Above", color = colors.DBROWN, ghost = true, scale_until = 10 })
Spell( 212150 ,{ name = "Cheatp Tricks", duration = 5, color = colors.LBLUE, scale = 0.75 })
Spell( 207777 ,{ name = "Dismantle", duration = 6, color = colors.DBROWN, scale = 0.6, shine = true })
Spell( 197091 ,{ name = "Neurotoxin", duration = 10, color = colors.TEAL3, scale = 0.75 })
-- Spell( 198688 ,{ name = "Dagger in the Dark", duration = 10, scale = 0.6, color = colors.PURPLE4, singleTarget = true })



Spell( 114018 ,{ name = "Shroud", group = "buffs", duration = 15, color = colors.BLACK })

Spell( 91021 ,{ name = "Find Weakness", group = "buffs", duration = 10, priority = -3, shine = true, shinerefresh = true, color = colors.TEAL2, scale = 0.75 })
Spell( 51690 ,{ name = "Killing Spree", duration = 2, color = colors.CURSE, priority = 14 })
Spell( 121153 ,{ name = "Blindside", group = "buffs", effect = "JUDGEMENT", priority = 13, duration = 10, scale = 0.6, color = colors.PURPLE4 })

Cooldown( 271877 ,{ name = "Blade Rush", ghost = true, scale_until = 7, color = colors.DTEAL, priority = -10 })

Cooldown( 185313 ,{ name = "Shadow Dance", minduration = 10, ghost = true, color = colors.PURPLE3, scale = 0.5, priority = -100 })

Spell( 1966  ,{ name = "Feint", group = "buffs", duration = 5, priority = -1, shine = true, shinerefresh = true, color = colors.LBLUE })
Spell( 2983  ,{ name = "Sprint", group = "buffs", shine = true, duration = 8 })
Spell( 5277  ,{ name = "Evasion", group = "buffs", color = colors.PINK, duration = 15 })
Spell( 31224 ,{ name = "Cloak of Shadows", group = "buffs", color = colors.CURSE, duration = 5 })
Spell( 185311 ,{ name = "Crimson Vial", group ="buffs", shine = true, color = colors.LGREEN ,duration = 6 })
DotSpell( 315496 ,{ name = "Slice and Dice", shinerefresh = true, duration = 36, priority = 10, overlay = {0, 36*0.3, 0.2}, short = "SnD", color = colors.PURPLE,
    init = function(self)
        if self.overlay then
            self.overlay[2] = IsPlayerSpell(193531) and 42*0.3 or 36*0.3 --Deeper Stratagem
        end
    end })
-- effect = "AEGWYNN", ghosteffect = "JUDGEMENT,
Spell( 212283  ,{ name = "Symbols", shinerefresh = true, ghost = 1, group = "buffs", duration = 10, color = colors.PINKIERED })
Cooldown( 212283 ,{ name = "Symbols", ghost = 5, ghosteffect = "AEGWYNN", color = colors.CURSE, scale_until = 5 })

Spell( 1833  ,{ name = "Cheap Shot", duration = 4, color = colors.LRED })
Spell( 408   ,{ name = "Kidney Shot", shine = true, duration = function() return 1+GetCP() end, color = colors.LRED })
Spell( 199804   ,{ name = "Between the Eyes", shine = true, duration = function() return GetCP() end, color = colors.LRED })
Spell( 1776  ,{ name = "Gouge", color = colors.PINK, duration = 4 })
Spell( 2094  ,{ name = "Blind",duration = 60, pvpduration = 8, color = {0.20, 0.80, 0.2} })

-- Spell( 51722 ,{ name = "Dismantle",duration = 10,color = colors.LRED }) --removed
Spell( 6770  ,{ name = "Sap",duration = 60, color = colors.LBLUE })

local bleed_normalize = 24
--Garrote
DotSpell( 703,{ name = "", nameplates = true, scale = 0.85, priority = 8, fixedlen = bleed_normalize, color = colors.PINKIERED, duration = 18 })
--Rupture
Spell( 1943  ,{ name = "Rupture", short = "", shinerefresh = true, priority = 7, fixedlen = bleed_normalize, nameplates = true, overlay = {0, 24*0.3, 0.3}, color = colors.PURPLE5, duration = 24, preghost = true,  ghost = 7,
    init = function(self)
        if self.overlay then
            self.overlay[2] = IsPlayerSpell(193531) and 28*0.3 or 24*0.3 --Deeper Stratagem
        end
    end
})

Spell( 121411, { name = "Crimson Tempest", overlay = {0, 12*0.3, 0.2}, color = colors.PURPLE4, maxtimers = 1, duration = 12,
    init = function(self)
        if self.overlay then
            self.overlay[2] = IsPlayerSpell(193531) and 14*0.3 or 12*0.3 --Deeper Stratagem
        end
    end
})
--Nightblade
-- Spell( 195452  ,{ name = "", ghost = true, nameplates = true, shinerefresh = true, overlay = {0, 4.8, 0.3}, fixedlen = 16, color = colors.PURPLE5, duration = 16})

-- Spell( 1330  ,{ name = "Silence", color = colors.PINK, duration = 3 })

-- Spell( 200803 ,{ name = "Agonizing Poison", color = { 192/255, 77/255, 48/255}, duration = 12, short = "Agonizing" })
--Spell( 3409 ,{ name = "Crippling Poison", color = { 192/255, 77/255, 48/255}, duration = 12, short = "Crippling" })

Spell( 32645 ,{ name = "Envenom", color = colors.DTEAL, priority = -1, group = "buffs", target = "player", duration = function() return (1+GetCP()) end })
Spell( 79140 ,{ name = "Vendetta", shine = true, group = "buffs", color = colors.PINK3, duration = 20 })
Cooldown( 79140 ,{ name = "Vendetta", color = colors.DPURPLE2, effect = "BLOODBOIL", effecttime = 1.5, ghost = 3, scale_until = 10 })
Cooldown( 703 ,{ name = "Garrote", short = "", ghost = 3, ghosteffect = "MAGICCAST", color = colors.PURPLE4, color2 = colors.PINK, scale = 0.75, priority = -20, resetable = true })
Spell( 193538 ,{ name = "Alacrity", shinerefresh = true, priority = -2, scale_until = 5, color = colors.WOO2DARK, color2 = colors.WOO2, duration = 20 })

Spell( 195627,{ name = "Opportunity", shine = true, effect = "JUDGEMENT", shinerefresh = true, priority = 11, color = colors.PINKIERED, duration = 10 })

--Roll the bones
Spell( 193358,{ name = "Grand Melee", color = colors.PURPLE3, shine = true, group = "buffs", scale = 0.75, duration = 36 }) -- haste
Spell( 193359,{ name = "True Bearing", shine = true, color = colors.REJUV, group = "buffs", scale = 0.75, duration = 36 }) -- cdr
Spell( 199603,{ name = "Jolly Roger", shine = true, color = colors.TEAL, group = "buffs", scale = 0.75, duration = 36 }) -- extra attack
Spell( 199600,{ name = "Buried Treasure", color = colors.GOLD, shine = true, group = "buffs", scale = 0.75, duration = 36 }) -- energy regen
Spell( 193356,{ name = "Broadsides", shine = true, color = colors.WOO2, group = "buffs", scale = 0.75, duration = 36 }) -- cp generation
Spell( 193357,{ name = "Shark Infested Waters", short = "Crit", color = colors.PINK3, shine = true, group = "buffs", scale = 0.75, duration = 36 }) -- crit

Spell( 13750 ,{ name = "Adrenaline Rush", group = "buffs", priority = -5, duration = 20, arrow = colors.LRED, color = colors.LRED })
Cooldown( 13750 ,{ name = "Adrenaline Rush", scale_until = 10, effect = "BLOODBOIL", effecttime = 2, minduration = 10, color = colors.LRED })

Spell( 13877 ,{ name = "Blade Flurry", group = "buffs", priority = -10, duration = 12, scale = 0.8, color = colors.PINKIERED })

Spell( 51690 ,{ name = "Killing Spree", duration = 3, shine = true, color = colors.RED  })
Cooldown( 280719 ,{ name = "Secret Technique", color = colors.DBLUE, ghost = true, scale_until = 10 })
Cooldown( 277925 ,{ name = "Shuriken Tornado", color = colors.DBROWN, ghost = true, scale_until = 10 })


Spell( 115192 ,{ name = "Subterfuge", group = "buffs", duration = 6, color = colors.PURPLE3 })
Spell( 185422 ,{ name = "Shadow Dance", short = "", group = "buffs", priority = -9999, shine = true, tick = 1, glowtime = 6, overlay = {"tick", "end", 0.2}, scale = 0.8, duration = 3, color = colors.PURPLE5 })
Spell( 121471 ,{ name = "Shadow Blades", group = "buffs", duration = 15, shine = true, color = colors.DPURPLE })
Spell( 16511 ,{ name = "Hemorrhage", priority = -1, glowghost = true, color = colors.DPURPLE, color2 = colors.PURPLE2, scale = .8, ghost = 7, duration = 20, shinerefresh = true })
-- Spell( 196937 ,{ name = "Ghostly Strike", priority = -1, glowghost = true, color = colors.DPURPLE, color2 = colors.PURPLE, scale = .8, ghost = 7, duration = 15 })
Cooldown( 196937 ,{ name = "Ghostly Strike", color = colors.DPURPLE, color2 = colors.PURPLE, scale_until = 5 })

--Spell( 1784 ,{ name = "Stealth", color = colors.CURSE, timeless = true, duration = 0.1})

Cooldown( 200806 ,{ name = "Exsanguinate", ghost = true, color = colors.PURPLE2, scale_until = 10 })
-- Cooldown( 245388,{ name = "Toxic Blade", color = colors.TEAL3, effect = "UNHOLY", effecttime = 1.5, ghost = true, scale_until = 5 })
-- Spell( 245389,{ name = "Toxic Blade", color = colors.TEAL2, priority = -0.9, arrow = colors.TEAL2, shine = true, group = "buffs", duration = 9 })
Cooldown( 137619 ,{ name = "Marked for Death", ghost = true, color = colors.LRED, scale_until = 10 })


EventTimer({ event = "SPELL_CAST_SUCCESS", spellID = 1725, name = "Distract", color = colors.PURPLE5, duration = 10 })
end

if class == "WARRIOR" then

-- [[ COVENANTS ]]
Spell( 307871 ,{ --[[Kyrian]] name = "Spear of Bastion", duration = 4, maxtimers = 1, ghost = 2, color = colors.WOO2 })
Spell( 325787 ,{ --[[Necrolord]] name = "Glory", group = "buffs", priority = -7, duration = 30, scale = 0.5, color = colors.PINK3 })
Spell( 343672 ,{ --[[Necrolord]] name = "Conqueror's Frenzy", group = "buffs", target = "player", priority = -7, duration = 20, color = colors.PINK3 })
Spell( 326062 ,{ --[[Night Fae]] name = "Ancient Aftershock", group = "buffs", priority = -7, maxtimers = 1, duration = 12, ghost = 1, color = colors.PURPLE2 })

Interrupt(6552, "Pummel", 4)

-- [[ ARTIFACTS ]]
-- Cooldown( 209577 ,{ name = "Warbreaker", ghost = true, color = colors.DTEAL, scale_until = 9, fixedlen = 9 })
-- helpers.Cast(203524, {name = "Neltharion's Fury", color = colors.REJUV, group = "buffs", priority = -8.5, arrow = colors.LGREEN })
-- Cooldown( 203524 ,{ name = "Neltharion's Fury", ghost = true, fixedlen = 9, scale_until = 9, color = colors.DTEAL })
-- Cooldown( 205545 ,{ name = "Odyn's Fury", ghost = true, color = colors.DTEAL, scale_until = 10 })

-- PVP
EventTimer({ spellID = 236320, event = "SPELL_CAST_SUCCESS", group = "buffs", name = "War Banner", duration = 15,  scale = 0.75,  shine = true, color = colors.RED })
Spell( 236273 ,{ name = "Duel", color = colors.GOLD, duration = 6 })
Spell( 199085 ,{ name = "Warpath", color = colors.DRED, duration = 3, maxtimers = 1 })
-- Spell( 206891 ,{ name = "Intimidated", color = colors.RED, shine = true, duration = 6, scale = 0.6 }) -- Opressor
Cooldown( 198912 ,{ name = "Shield Bash", priority = 10, fixedlen = 9, scale = .8, ghost = true, color = colors.TEAL3, resetable = true, ghosteffect = "AEGWYNN" })
Spell( 236077 ,{ name = "Disarm", color = colors.DBROWN, duration = 4, scale = 0.6, shine = true })

Spell( 23920 ,{ name = "Spell Reflect", color = colors.LBLUE, group = "buffs", arrow = colors.LBLUE, duration = 5, scale = 0.75, shine = true })


Spell( 213858 ,{ name = "Battle Trance", color = colors.LGREEN, group = "buffs", duration = 18, shine = true })
Spell( 199261 ,{ name = "Death Wish", color = colors.PINKIERED, group = "buffs", duration = 15, shine = true, shinerefresh = true, priority = -100, arrow = colors.PINKIERED, glow2time = 3 })
-- Spell( 262232 ,{ name = "War Machine", priority = -1, color = colors.RED2, shine = true, shinerefresh = true, duration = 10, group = "buffs" })

Spell( 85739 ,{ name = "Whirlwind", short = "", glowtime = 20, group = "buffs", priority = -100503, color = colors.TEAL2, shine = true, scale = 0.8, duration = 20, charged = true, maxcharge = 2,
    init = function(self)
        self.maxcharge = IsPlayerSpell(280392) and 4 or 2
    end })
-- Spell( 6673 ,{ name = "Battle Shout", target = "player", glowtime = 10, priority = -10, color = colors.DPURPLE, duration = 120 })
-- Spell( 469 ,{ name = "Commanding Shout", target = "player", priority = -10, glowtime = 10, short = "CommShout", color = colors.DPURPLE, duration = 120 })
Spell( 132404 ,{ name = "Shield Block", color = colors.WOO2, shine = true, group = "buffs", priority = - 9, duration = 6, arrow = colors.LGREEN })
Spell( 12975, { name = "Last Stand", color = colors.PURPLE3, duration = 20, group = "buffs", priority = -8, arrow = colors.LGREEN })
-- Spell( 169667 ,{ name = "Shield Charge", shine = true, color = colors.PURPLE2, group = "buffs", priority = - 9, duration = 6 })
Cooldown( 2565 ,{ name = "", priority = 9.9, fixedlen = 9, scale = .5, ghost = true, color = colors.DPURPLE, }) -- shield block cd
-- Cooldown( 156321 ,{ name = "", priority = 9.9, fixedlen = 9, scale = .5, ghost = true, color = colors.DPURPLE, }) -- shield charge cd
Spell( 190456 ,{ name = "Ignore Pain", ghost = 0.5, group = "buffs", priority = -8, glowtime = 4, color = colors.WOO, duration = 12, arrow = colors.WOO })
Spell( 202574 ,{ name = "Vengeance Ignore Pain", group = "buffs", priority = -10, scale = 0.5, color = colors.DRED, duration = 15, })
Spell( 202573 ,{ name = "Vengeance Revenge", group = "buffs", priority = -10, scale = 0.5, color = colors.TEAL2, duration = 15, })

Spell( 262228 ,{ name = "Deadly Calm", group = "buffs", color = colors.BROWN, duration = 6 })
DotSpell( 262115 ,{ name = "Deep Wounds", color = colors.PINKIERED, ghost = true, specmask = SPECS(1), preghost = true, duration = 12, maxtimers = 1, isknowncheck = function() return true end })

Spell( 5246 ,{ name = "Intimidating Shout", duration = 8, maxtimers = 1 })

Spell( 260708 ,{ name = "Sweeping Strikes", group = "buffs", shine = true, priority = -100503, color = colors.LRED, duration = 10, scale = 0.6 })

Cooldown( 260643, { name = "Skullsplitter", color = colors.RED, priority = 3, scale_until = 5 })
--arms
Spell( 52437 ,{ name = "Sudden Death", glowtime = 10, effect = "AEGWYNN", priority = 13, duration = 10, scale = 0.8, color = colors.LRED, glowtime = 10 })
--fury
Spell( 280776 ,{ name = "Sudden Death", glowtime = 10, effect = "AEGWYNN", priority = 13, duration = 10, scale = 0.8, color = colors.LRED, glowtime = 10 })

-- Spell( 7384 ,{ name = "Overpower", group = "buffs", shine = true, shinerefresh = true, priority = -100501, color = colors.WOO, duration = 15, charged = true, maxcharge = 2, scale = 0.6 })
Cooldown( 7384,{ name = "Overpower", shine = true, resetable = true, ghost = true, ghosteffect = "JUDGEMENT", color = colors.PURPLE, priority = 7 })
DotSpell( 772 ,{ name = "Rend", color = colors.RED, duration = 15, ghost = true })
Spell( 208086 ,{ name = "Colossus Smash", singleTarget = true, shine = true, priority = -100500, color = colors.PURPLE2, duration = 6 }) --debuff

--different versions of spell for arms and fury
Cooldown( 167105,{ name = "Colossus Smash", scale_until = 10, ghost = true, effect = "JUDGEMENT", effecttime = 1.5, color = colors.PINKIERED, resetable = true })
-- Cooldown( 86346 ,{ name = "Colossus Smash", priority = 9.5, overlay = {0,"gcd",.3}, scale = .7, check_known = true, ghost = true, color = colors.PINKIERED, resetable = true, duration = 20 })

-- Spell( 676  ,{ name = "Disarm", color = colors.BROWN, duration = 10 }) --removed
Spell( 1715 ,{ name = "Hamstring", ghost = true, color = colors.PURPLE, duration = 15, pvpduration = 8 })

-- Spell( 12809 ,{ name = "Concussion Blow", color = { 1, 0.3, 0.6 }, duration = 5 })
-- Spell( 355 ,{ name = "Taunt", duration = 3 })
-- Spell( 113746 ,{ name = "Weakened Armor", specmask = 0xF00, short = "WeakArmor", priority = -10, affiliation = "any", singleTarget = true, color = colors.BROWN, duration = 30 })
-- Demo shout also applies self-buff (id 125565), but it doesn't appear in combat log
Spell( 1160 ,{ name = "Demoralizing Shout", short = "DemoShout", shine = true, group = "buffs", color = colors.DPURPLE, duration = 8, maxtimers = 1 })

Cooldown( 6572 ,{ name = "Revenge", priority = 5, color = colors.PURPLE, resetable = true, fixedlen = 9, ghost = 1 })
Activation( 6572, { for_cd = true, effect = "JUDGEMENT", ghost = 6 })

Spell( 184364 ,{ name = "Enraged Regeneration", short = "Regen", scale = 0.6, group = "buffs", color = colors.LGREEN, duration = 8 })
Spell( 132168 ,{ name = "Shockwave", color = colors.CURSE, arrow = colors.LGREEN, duration = 4, maxtimers = 1 , })
Cooldown( 46968 ,{ name = "Shockwave", fixedlen = 9, ghost = 3, priority = 2, color = colors.DBLUE })
Cooldown( 107570 ,{ name = "Storm Bolt", fixedlen = 9, ghost = 3, priority = 2, color = colors.DBLUE, scale_until = 9 })
--but shockwave still needs to be used on cooldown
--old enrage Spell( 85288, { name = "Enraged", shine = true, showid = 14202, color = colors.RED, duration = 10 })
Spell( 184362,{ name = "Enrage", color = colors.PURPLE4, shine = true, shinerefresh = true, scale = 0.8, group = "buffs", specmask = SPECS(2), priority = 1, duration = 4 })
Spell( 335082,{ name = "Frenzy", color = colors.DPURPLE, scale = 0.5, group = "buffs", priority = 2, duration = 12 })
-- Spell( 215572,{ name = "Frothing Berserker", short = "Frothing", color = colors.DRED, group = "buffs", priority = 2, scale = 0.6, shine = true, shinerefresh = true, duration = 6 })

Cooldown( 845 ,{ name = "Cleave", priority = 8, color = colors.TEAL3, fixedlen = 9, ghost = true, scale = 0.75 })
Cooldown( 280735 ,{ name = "Execute", priority = 8, color = colors.RED2, fixedlen = 9, ghost = true, scale = 0.75 })

-- Spell( 188923 ,{ name = "Cleave", maxcharge = 5, charged = true, color = colors.TEAL2, duration = 5 })
Spell( 12323 ,{ name = "Piercing Howl", maxtimers = 1, duration = 15 })
-- Spell( 105771 ,{ name = "Charge Root", duration = 3 })
Spell( 107574 ,{ name = "Avatar", shine = true, group = "buffs", color = colors.PURPLE3, duration = 20 })
Spell( 132169 ,{ name = "Storm Bolt", color = colors.TEAL2, duration = 3})

-- Activation( 184367 ,{ name = "Rampage", shine = true, color = colors.RED, priority = 11, glowtime = 7, duration = 8 })

--settings for special rampage timer
Spell( 184367 ,{ name = "Rampage", shine = true, color = colors.DPURPLE, color2 = colors.REJUV, priority = 11, glowtime = 7, duration = 8 })

--banners are totems actually
-- EventTimer({ spellID = 114207, event = "SPELL_CAST_SUCCESS", group = "buffs", affiliation = "raid", name = "Skull Banner", duration = 10, color = colors.RED })
-- EventTimer({ spellID = 114203, event = "SPELL_CAST_SUCCESS", group = "buffs", name = "Demoralizing Banner", affiliation = "raid", short = "DemoBanner", duration = 15, color = colors.BLACK })
Spell( 1719 ,{ name = "Recklessness", color = colors.REJUV, scale = 0.7, shine = true, group = "buffs", duration = 10})
Cooldown( 1719 ,{ name = "Recklessness", color = colors.REJUV, scale_until = 10, shine = true, ghost = 4, ghosteffect = "AEGWYNN", priority = -20 })
-- Cooldown( 107570, { name = "Storm Bolt", color = colors.TEAL2 })

-- Spell( 169686, { name = "Exquisite Proficiency", duration = 6, priority = -5, stackcolor = {
--                                                                             [1] = { .3, 0, 0},
--                                                                             [2] = { .4, 0, 0},
--                                                                             [3] = { .6, 0, 0},
--                                                                             [4] = { .8, 0, 0},
--                                                                             [5] = { 1, 0, 0},
--                                                                             [6] = { 1, 0, 0},
--                                                                         }})


--Spell( 56112 ,{ name = "Furious Attacks", duration = 10 })
--Activation( 5308, { name = "Execute", shine = true, timeless = true, color = colors.CURSE, duration = 0.1 })

Cooldown( 12294, { name = "Mortal Strike", tick = 1.5, tickshine = true, overlay = {"tick", "end"}, priority = 10, short = "", fixedlen = 9, ghost = 6, ghosteffect = "NIGHTBORNE",  color = colors.CURSE, resetable = true })
-- these popups are for visual confirmation
EventTimer({ spellID = 1464, event = "SPELL_CAST_SUCCESS", priority = 12, name = "Slam", duration = 0.5, color = colors.PINK, scale = 0.6 })
-- EventTimer({ spellID = 1680, event = "SPELL_CAST_SUCCESS", priority = 12, name = "Whirlwind", duration = 0.5, color = colors.PINK, scale = 0.6 })
-- EventTimer({ spellID = 5308, event = "SPELL_CAST_SUCCESS", priority = 12, name = "Execute", duration = 0.5, color = colors.PINK, scale = 0.6 })
-- EventTimer({ spellID = 20243, event = "SPELL_CAST_SUCCESS", priority = 12, name = "Devastate", duration = 0.5, color = colors.PINK, scale = 0.6 })
-- EventTimer({ spellID = 85288, event = "SPELL_CAST_SUCCESS", priority = 12, name = "Raging Blow", duration = 0.5, color = colors.PINK, scale = 0.6 })
EventTimer({ spellID = 100130, event = "SPELL_CAST_SUCCESS", priority = 12, name = "Furious Slash", duration = 0.5, color = colors.PINK, scale = 0.6 })
-- EventTimer({ spellID = 78, event = "SPELL_CAST_SUCCESS", priority = 12.1, name = "Heroic Strike", scale = .7, duration = 0.5, shine = true, color = colors.ORANGE2 })

-- special timer
-- Spell( 7384, { name = "Overpower", overlay = {0,-4.5, 0.15}, priority = 11, shine = true, shinerefresh = true, color = colors.PINKIERED, recast_mark = -4.5, duration = 9})
--Activation( 7384, { name = "Overpower", short = "", shine = true, color = colors.RED, recast_mark = 4.5, duration = 9})
-- Spell(  ,{ name = "Overpower", glowtime = 5, shinerefresh = true, shine = true, color = colors.TEAL, duration = 10, scale = 0.8 })

-- Spell( 60503 ,{ name = "Overpower", priority = 9, overlay = {0,7, 0.3}, fixedlen = 9, shinerefresh = true, shine = true, color = colors.PINKIERED, duration = 12 }) -- Taste for blood --removed

Cooldown( 23881, { name = "Bloodthirst", fixedlen = 9, tick = 1.5, tickshine = true, overlay = {"tick", "end"}, short = "", priority = 10, check_known = true, ghost = true,  color = colors.CURSE })
Cooldown( 85288, { name = "Raging Blow", fixedlen = 9, short = "", priority = 9, ghost = true,  color = colors.PINKIERED, stackcolor = { colors.RED2, colors.PINKIERED } })
Activation( 85288, { for_cd = true, effect = "SLICENDICE", ghost = 3})
Cooldown( 118000 ,{ name = "Dragon Roar", fixedlen = 9, ghost = 3, priority = 7, ghost = true, scale = 0.8, color = colors.DBROWN, scale_until = 10 })
Cooldown( 315720 ,{ name = "Onslaught", fixedlen = 9, priority = 8, ghost = true, color = colors.PINK })
-- Spell( 131116 ,{ name = "Raging Blow", priority = 9, fixedlen = 9, shine = true, shinerefresh = true, duration = 12, stackcolor = {
                                                                                                -- [1] = colors.WOO,
                                                                                                -- [2] = colors.PINK3,
                                                                                            -- },
                                                                            -- onupdate = function(self)
                                                                            --     local now = GetTime()
                                                                            --     local colcd = 0
                                                                            --         local start, duration = GetSpellCooldown(86346)
                                                                            --         if duration > 1.5 then
                                                                            --             colcd = (start+duration) - now
                                                                            --         end
                                                                            --     local _, _, _, rbstacks = UnitBuff("player",  GetSpellInfo(131116))
                                                                            --     if colcd > 3 and colcd < 14 and rbstacks == 2 then
                                                                            --         -- self:SetAlpha(1)
                                                                            --         if not self.glow:IsPlaying() then self.glow:Play() end
                                                                            --     else
                                                                            --         -- self:SetAlpha(0.3)
                                                                            --         if self.glow:IsPlaying() then self.glow:Stop() end
                                                                            --     end
                                                                            -- end
                                                                                -- })


Spell( 97463, { name = "Commanding Shout", color = colors.BLACK, target = "player", duration = 10, group = "buffs" })
Spell( 118038, { name = "Die by the Sword", short = "DbtS", color = colors.BLACK, duration = 8, group = "buffs" })
Spell( 871, { name = "Shield Wall", color = colors.WOO2, duration = 12, group = "buffs" })
Cooldown( 23922, { name = "Shield Slam", tick = 1.5, tickshine = true, overlay = {"tick", "end"}, short = "", priority = 10, fixedlen = 9, ghost = true, ghosteffect = "NIGHTBORNE", color = colors.CURSE, resetable = true })

-- Cooldown( 78, { name = "Heroic Strike", short = "Heroic", fixedlen = 6, ghost = true })
Cooldown( 6343, { name = "Thunder Clap", ghost = true, short = "", scale = 0.7,overlay = {0,"gcd",.3}, specmask = SPECS(3), color = colors.PINKIERED, fixedlen = 9, priority = 9.5 })
Spell( 32216, { name = "Victory Rush", group = "buffs", priority = -9, color = colors.PURPLE, duration = 20})

Spell( 152277 ,{ name = "Ravager", color = colors.DRED, group = "buffs", duration = 11 })
Spell( 280773 ,{ name = "Siegebreaker", shine = true, scale = 0.75, fixedlen = 9, ghost = true, duration = 10, color = colors.REJUV })
Cooldown( 280772 ,{ name = "Siegebreaker", ghost = true, color = colors.DTEAL, scale_until = 8 })

end

if class == "MONK" then

-- [[ COVENANTS ]]
Spell( 328908 ,{ --[[Kyrian, Pelagos]] name = "Combat Meditation", group = "buffs", duration = 10, scale = 0.5, color = colors.WOO2, priority = -4.9 })
Spell( 310454 ,{ --[[Kyrian]] name = "Weapons of Order", group = "buffs", duration = 30, color = colors.WOO2, priority = -5 })
Spell( 326860 ,{ --[[Venthyr]] name = "Fallen Order", group = "buffs", duration = 24, color = colors.LRED })
Spell( 325216 ,{ --[[Necrolord]] name = "Bonedust Brew", duration = 10, color = colors.BLACK, singleTarget = true })
Cooldown( 327104 ,{ --[[Night Fae]] name = "Faeline Stomp", priority = 1, scale_until = 5, ghosteffect = "NIGHTBORNE", ghost = 3, color = colors.WOO2 })

Interrupt(116705, "Spear Hand Strike", 4)

-- [[ ARTIFACTS ]]
Spell( 325153 ,{ name = "Exploding Keg", color = colors.DBLUE, shine = true, maxtimers = 1, duration = 3, ghost = 1, group = "buffs" })
-- Cooldown( 205320 ,{ name = "Strike of the Windlord", color = colors.DTEAL, scale_until = 10, ghost = true })

Spell( 233759 ,{ name = "Grapple Weapon", color = colors.DBROWN, duration = 6, scale = 0.6, shine = true })
Spell( 248646 ,{ name = "Tigereye Brew", color = colors.DBROWN, group = "buffs", duration = 120, scale = 0.5 })
Spell( 247483 ,{ name = "Tigereye Brew", color = colors.PINKIERED, shine = true, priority = -5, group = "buffs", duration = 20, target = "player" })
Spell( 233766 ,{ name = "Control the Mists", color = colors.DTEAL, group = "buffs", fixedlen = 10, duration = 10, scale = 0.6, ghost = true })

Spell( 209584 ,{ name = "Zen Focus Tea", color = colors.LBLUE, shine = true, group = "buffs", duration = 5 })

Spell( 325092 ,{ name = "Purified Chi", group = "buffs", duration = 10, arrow = colors.TEAL2, color = colors.TEAL3, glow2time = 3, glowtime = 2, priority = -15 })

EventTimer({ spellID = 116844, event = "SPELL_CAST_SUCCESS", name = "Ring of Peace", duration = 5, group = "buffs", color = colors.WOO })

local ww_normalize = 10

Cooldown( 261947 ,{ name = "Fist of the White Tiger", short = "Whtie Tiger", fixedlen = ww_normalize, color = colors.CHIM, scale_until = 10, ghost = true })
-- Spell( 120086, { name = "Fists of Fury", color = colors.BLUE, duration = 4 })
Spell( 120954, { name = "Fortifying Brew", group = "buffs", color = colors.BLACK, duration = 20 })
Spell( 115078, { name = "Paralysis", color = colors.PURPLE, duration = 30, pvpduration = 8 })


-- EventTimer({ spellID = 100780, event = "SPELL_CAST_SUCCESS", priority = 12, name = "Tiger Palm", duration = 0.5, color = colors.PINK, scale = 0.6 })
-- EventTimer({ spellID = 205523, event = "SPELL_CAST_SUCCESS", priority = 12, name = "Blackout Strike", duration = 0.5, color = colors.PINK, scale = 0.6 })

local function FindAura(unit, spellID, filter)
    for i=1, 100 do
        -- rank will be removed in bfa
        local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, auraSpellID = UnitAura(unit, i, filter)
        if not name then return nil end
        if spellID == auraSpellID then
            return name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, auraSpellID
        end
    end
end

local function GetBuff(unit, spellID)
    local name, _, count, _, duration, expirationTime, caster, _,_, aura_spellID = FindAura(unit, spellID, "HELPFUL")
    if not name then return nil, 0 end
    return expirationTime - GetTime(), count
end
local BlackoutCombo = 228563

local stagger_pause_opts = { name = "Stagger Pause", group = "buffs", priority = -8, showid = 7812, color = colors.DRED, shine = true, duration = 3}
EventTimer({ spellID = 322507, event = "SPELL_CAST_SUCCESS",
    action = function(active, srcGUID, dstGUID, spellID, damage )
        local IsBlackoutComboOn = GetBuff("player", BlackoutCombo)
        if IsBlackoutComboOn then
            local playerGUID = UnitGUID("player")
            NugRunning:ActivateTimer(playerGUID, playerGUID, "player", nil, spellID, "Stagger Paused", stagger_pause_opts, "EVENT", stagger_pause_opts.duration)
        end
    end,
 })

Spell( 325202 ,{ name = "Dance of Chi-Ji", scale = 0.6, priority = 13, glowtime = 15, color = colors.PURPLE, duration = 15 })
Spell( 116768 ,{ name = "Blackout Kick", scale = 0.6, priority = 6, glowtime = 15, color = colors.PINK, duration = 15 })

Cooldown( 107428, { name = "Rising Sun Kick",tick = -1, overlay = {"tick", "end", .35}, fixedlen = ww_normalize, short = "Rising Sun", color = colors.CURSE, priority = 10, ghost = 8, resetable = true })

Cooldown( 115098, { name = "Chi Wave", color = { 29/255, 134/255, 83/255 }, fixedlen = 8, color2 = colors.LGREEN, priority = 6, ghost = true })

Spell( 116095 ,{ name = "Disable", ghost = true, color = colors.PURPLE, duration = 15, pvpduration = 8 })
Spell( 116706 ,{ name = "Root", color = colors.BROWN, duration = 8 })

Totem(620832, { spellID = 123904, name = "Xuen", group = "buffs", duration = 24, priority = -8, color = colors.CHILL })
Totem(608951, { spellID = 132578, name = "Niuzao", group = "buffs", duration = 25, priority = -8, color = colors.DBROWN })
Totem(574571, { spellID = 322118, name = "Yu'lon", group = "buffs", duration = 25, priority = -8, color = colors.TEAL2 })
-- Totem(877514, { spellID = 325197, name = "Chi-Ji", group = "buffs", duration = 25, priority = -8, color = colors.TEAL2 })

helpers.Cast(113656, {name = "Fists of Fury", fixedlen = ww_normalize, color = colors.PINK3, priority = 10.1 })
Cooldown( 113656, { name = "Fists of Fury", fixedlen = ww_normalize, scale_until = 10, effect = "AEGWYNN", effecttime = 3,  color = colors.PINKIERED, priority = 3, ghost = true })
Cooldown( 152175, { name = "Whirling Dragon Punch", fixedlen = ww_normalize, scale_until = 10, color = colors.TEAL2, priority = 2, ghost =true })

Spell( 119611 ,{ name = "Renewing Mist", color = colors.LGREEN, fixedlen = 25, scale = 0.5, duration = 20 })
Cooldown( 115151 ,{ name = "Renewing Mist", color = colors.TEAL3, priority = -100, ghost = true, ghosteffect = "NIGHTBORNE" })

Spell( 202090 ,{ name = "Teachings", color = colors.REJUV, charged = true, maxcharge = 3, priority = 10.1, scale = 0.7, duration = 18, timeless = true })

Spell( 197916 ,{ name = "Lifecycles", color = colors.TEAL3, duration = 15 })
Spell( 197919 ,{ name = "Lifecycles", color = colors.GOLD, duration = 15 })
-- Spell( 115151 ,{ name = "Renewing Mist", color = colors.TEAL2 })
Spell( 116849 ,{ name = "Life Cocoon", color = colors.PURPLE, duration = 12 })

-- Cooldown( 116680 ,{ name = "Thunder Focus Tea", color = colors.CURSE, overlay = {0, 15}, recast_mark = 15 })
Spell( 116680 ,{ name = "Thunder Focus Tea", color = colors.CURSE, duration = 30 })

Spell( 137639 ,{ name = "Storm, Earth and Fire", short = "SEF", group = "buffs", priority = -6, color = colors.DPURPLE, duration = 15 })

Spell( 197908 ,{ name = "Mana Tea", priority = -10, group = "buffs", duration = 10, color = colors.FROZEN })
-- NugRunningConfig.totems[1] = { name = "", color = colors.DPURPLE, priority = - 100, hideName = true }
-- NugRunningConfig.totems[2] = { name = "", color = colors.WOO2DARK, priority = - 100, hideName = true }
-- Spell( 138130 ,{ name = "Clone", color = colors.RED, duration = 100, timeless = true, singleTarget = true })

Spell( 322507, { name = "Celestial Brew", priority = -15, spark = true, arrow = colors.REJUV, group = "buffs", shine = true, glowtime = 1, ghost = 1, color = colors.TEAL3, duration = 8 })
Spell( 215479, { name = "Shuffle", priority = -10, spark = true, fixedlen = 10, arrow = colors.REJUV, group = "buffs", shine = true, glowtime = 1, ghost = 5, color = colors.PINK3, duration = 6, })
Spell( 214373, { name = "Brew-Stache", priority = -9, fixedlen = 10, ghosteffect = "AEGWYNN", arrow = colors.PINK2, group = "buffs", shine = true, ghost = 4, color = colors.REJUV, duration = 4.5, scale = 0.5 })

-- Cooldown( 119381 ,{ name = "Leg Sweep", color = colors.DBLUE, scale_until = 8, fixedlen = 8 })
Spell( 119381 ,{ name = "Leg Sweep", duration = 5, color = colors.RED, maxtimers = 1 })
Spell( 122783 ,{ name = "Diffuse Magic", group = "buffs", shine = true, duration = 6, color = colors.CURSE })
Spell( 122278 ,{ name = "Dampen Harm", group = "buffs", shine = true, duration = 6, color = colors.CURSE })
Spell( 152173 ,{ name = "Serenity", duration = 10, color = colors.TEAL2, group = "buffs", priority = -10 })

Cooldown( 287771 ,{ name = "Reverse Harm", priority = 5, color = colors.TEAL3, ghost = true, ghosteffect = "MAGICCAST" })

Spell( 228563 ,{ name = "Blackout Combo", group = "buffs", scale = .8, priority = -1, glowtime = 15, color = colors.PURPLE3, duration = 15 })
Cooldown( 205523 ,{ name = "Blackout Kick", overlay = {0,1, 0.2}, fixedlen = 8, priority = 9, color = colors.WOO, ghost = true, })
Cooldown( 119582 ,{ name = "Purifying Brew", scale = 0.5, color = colors.TEAL3, ghost = 6, ghosteffect = "NIGHTBORNE" })
Cooldown( 115399 ,{ name = "Black Ox Brew", scale_until = 10, ghosteffect = "AEGWYNN", color = colors.REJUV, ghost = 6, priority = -20 })

-- Keg Smash
Cooldown( 121253, { name = "", fixedlen = 8, spark = true, overlay = {1.1, 4.1, .30, true}, recast_mark = 1.1,ghost = true, priority = 10, color = colors.CURSE,
        init = function(self)
            if IsPlayerSpell(196736) then
                self.overlay = {1, 4, .30}
                self.recast_mark = 1
                self.tick = nil
            else
                self.tick = -1
                self.overlay = {"tick", "tickend", 0.30}
                self.recast_mark  = nil
            end
        end })
Cooldown( 115181 ,{ name = "Breath of Fire", priority = 4, color = colors.RED, ghost = true, ghosteffect = "JUDGEMENT" })
-- Spell( 123725 ,{ name = "Breath of Fire",  priority = 11, shine = true, color = colors.RED, maxtimers = 1, duration = 8 })
Spell( 116847, { name = "Rushing Jade Wind", short = "", scale = .7, fixedlen = 8, color = colors.DTEAL, ghost = true, duration = 7, priority = 6 })
-- Windwalker RJW
Spell( 261715, { name = "Rushing Jade Wind", short = "", scale = .7, color = colors.DTEAL, duration = 7, timeless = true, priority = 2 })
-- Mistweaver RJW
Spell( 196725, { name = "Refreshing Jade Wind", short = "", scale = .7, color = colors.DTEAL, duration = 7, priority = 2 })


-- Cooldown( 115072, { name = "Expel Harm", color = colors.LGREEN, resetable = true, ghost = true })
-- EventTimer({ spellID = 100784, event = "SPELL_CAST_SUCCESS", priority = 12, name = "Blackout Kick", duration = 0.5, color = colors.REJUV })
-- EventTimer({ spellID = 100780, event = "SPELL_CAST_SUCCESS", priority = 12, name = "Tiger Palm", duration = 0.5, color = colors.PINK })
end

if class == "DEATHKNIGHT" then

-- [[ COVENANTS ]]
Spell( 315443 ,{ --[[Necrolord]] name = "Abomination Limb", duration = 12, color = colors.DTEAL, shine = true })
Spell( 311648 ,{ --[[Venthyr]] name = "Swarming Mist", duration = 8, color = colors.DRED, shine = true, ghost = 1 })
Spell( 312202 ,{ --[[Kyrian]] name = "Shackle the Unworthy", duration = 14, color = colors.PINK })
Cooldown( 312202 ,{ --[[Kyrian]] name = "Shackle the Unworthy", scale_until = 5, fixedlen = 60, ghosteffect = "NIGHTBORNE", ghost = 3, color = colors.PURPLE3 })

Interrupt(47528, "Mind Freeze", 3)

-- [[ ARTIFACTS ]]
-- Cooldown( 205223 ,{ name = "Consumption", color = colors.DBLUE, ghost = true, scale_until = 10 })
-- Cooldown( 220143 ,{ name = "Apocalypse", color = colors.DBLUE, scale_until = 15, ghost = true })

Spell( 152279,{ name = "Breath of Sindragosa", group = "buffs", priority = -100501, arrow = colors.TEAL3, color = colors.TEAL3, shine = true, timeless = true, duration = 5 })
Spell( 207167,{ name = "Blinding Sleet", color = colors.DBLUE, shine = true, duration = 5, maxtimers = 1 })
Spell( 194879,{ name = "Icy Talons", priority = -100500, color = colors.PURPLE5, group = "buffs", effect = "JUDGEMENT", effecttime = 2, scale = 0.6, shine = true, shinerefresh = true, duration = 6 })
Spell( 207256,{ name = "Pillar of Frost", color = colors.CURSE, group = "buffs", shine = true, duration = 15 })
Spell( 207289,{ name = "Unholy Frenzy", color = colors.CURSE, group = "buffs", shine = true, duration = 12 })
Spell( 48265 ,{ name = "Death's Advance", color = colors.PURPLE4, scale = 0.7, group = "buffs", duration = 8 })
Spell( 206940 ,{ name = "Mark of Blood", color = colors.PINK, scale = 0.7, duration = 15 })
Spell( 194679 ,{ name = "Rune Tap", color = colors.WOO, shine = true, scale = 0.7, arrow = colors.WOO, duration = 4, group = "buffs", priority = -200 })
Cooldown( 194913 ,{ name = "Glacial Advance", color = colors.WOO, ghost = true, ghosteffect = "AEGWYNN" })
Cooldown( 210764 ,{ name = "Rune Strike", color = colors.TEAL3, ghost = true, scale_until = 10 })
Cooldown( 274156 ,{ name = "Consumption", color = colors.DBLUE, ghost = true, scale_until = 10 }) -- talent
DotSpell( 55095 ,{ name = "Frost Fever", ghost = true, color = colors.PURPLE, duration = 24, maxtimers = 1, })
DotSpell( 55078 ,{ name = "Blood Plague", ghost = true, color = colors.PURPLE, priority = 9, maxtimers = 1, duration = 24 })
Spell( 191587,{ name = "Virulent Plague", ghost = true, color = colors.PURPLE, priority = 9, singleTarget = true, duration = 27 })
-- Spell( 43265 ,{ name = "Death and Decay", short = "DnD", color = colors.RED, duration = 10, target = "player" })
Cooldown( 43265 ,{ name = "Death and Decay", color = colors.PINKIERED, priority = 8, resetable = true, ghost = true, minduration = 11 })
Cooldown( 152280 ,{ name = "Defile", color = colors.PINKIERED, priority = 8, resetable = true, ghost = true, minduration = 11 })
Cooldown( 196770,{ name = "Remorseless Winter", color = colors.DRED, ghost = true, minduration = 12 })
Spell( 195181,{ name = "Bone Shield", duration = 100500, timeless = true, charged = true, maxcharge = 10, color = colors.CURSE, group = "buffs", priority = -100 })
Spell( 196782,{ name = "Outbreak", color = colors.DTEAL, duration = 10 })
Spell( 219809,{ name = "Tombstone", color = colors.DTEAL, duration = 8 })
Spell( 180612, { name = "Mitigation", scale = 0.6, arrow = colors.WOO, color = colors.DTEAL, group = "buffs", priority = -20, duration = 3 })
Cooldown(50842,{ name = "Blood Boil", color = colors.PINK3, scale = 0.85,  priority = 6,  ghost = true })
Cooldown( 206931,{ name = "Exsanguinate", color = colors.DRED, ghost = true, minduration = 20, scale_until = 6, })
-- Cooldown( 207317,{ name = "Epidemic", color = colors.PURPLE3, ghost = true, minduration = 6 })
Spell( 194310,{ name = "Festering Wound", charged = true, singleTarget = true, ghost = true, maxcharge = 6, color = colors.PINK2, duration = 2000, timeless = true })
Spell( 343294,{ name = "Soul Reaper", priority = -300, color = colors.TEAL3, duration = 5, })
-- Cooldown( 343294,{ name = "Soul Reaper", color = colors.DPURPLE, color2 = colors.WOO, ghosteffect = "AEGWYNN", minduration = 5.7, scale_until = 10 })

Spell( 77606, { name = "Dark Simulacrum", color = colors.DPURPLE, duration = 8 })

-- Spell( 56222 ,{ name = "Taunt", duration = 3 })
Spell( 55233 ,{ name = "Vampiric Blood", duration = 10, color = colors.RED2, shine = true, group = "buffs", scale = 0.8 })
Spell( 81256 ,{ name = "Dancing Rune Weapon", duration = 12, color = colors.BROWN })

Spell( 81141 ,{ name = "Crimson Scourge", duration = 15, color = colors.LRED, scale = 0.6, glowtime = 8, priority = 11, shine = true })

Spell( 45524 ,{ name = "Chains of Ice", duration = 8, color = colors.CHILL })
Spell( 48792 ,{ name = "Icebound Fortitude", duration = 8, color = colors.CHIM, group = "buffs" })
Spell( 51124 ,{ name = "Killing Machine", duration = 8, scale = 0.8, priority = 7, color = colors.DPURPLE, shine = true })
Spell( 59052 ,{ name = "Freezing Fog", duration = 15, color = colors.TEAL2, priority = 9, shine = true })

Spell( 321995, { name = "Hypothermic Presence", color = colors.FROZEN, duration = 8, shine = true, ghost = 1, group = "buffs" })
Spell( 51271, { name = "Pillar of Frost", color = colors.BROWN, duration = 20, group = "buffs" })
Spell( 63560 ,{ name = "Dark Transformation", shine = true, duration = 30, color = colors.LGREEN, short = "Monstrosity" })
Spell( 81340 ,{ name = "Sudden Doom", shine = true, duration = 10, color = colors.CURSE })
Spell( 91800 ,{ name = "Gnaw", duration = 3, color = colors.RED })
Spell( 91797 ,{ name = "Monstrous Blow", duration = 4, color = colors.RED, short = "Gnaw" })
Spell( 48707 ,{ name = "Anti-Magic Shell", duration = 5, short = "Shell", color = colors.LGREEN })
EventTimer({ event = "SPELL_CAST_SUCCESS", spellID = 51052, name = "Anti-Magic Zone", duration = 10, color = colors.WOO2DARK, shine = true })

-- Spell( 116888 ,{ name = "Purgatory", color = colors.LGREEN, duration = 3, shine = true })
Spell( {221562, 108194} ,{ name = "Asphyxiate", color = colors.PINK, duration = 5 })
end

if class == "MAGE" then

-- [[ COVENANTS ]]
Spell( 324220 ,{ --[[Necrolord]] name = "Deathborne", group = "buffs", arrow = colors.PINK3, duration = 20, color = colors.PINK3, ghost = 1, shine = true })
Cooldown( 312202 ,{ --[[Kyrian]] name = "Shackle the Unworthy", scale_until = 5, fixedlen = 60, ghosteffect = "NIGHTBORNE", ghost = 3, color = colors.PURPLE3 })

Interrupt(2139, "Counterspell", 6)

-- [[ ARTIFACTS ]]
-- Cooldown( 214634 ,{ name = "Ebonbolt", color = colors.DTEAL, scale_until = 10, ghost = true }) -- artifact
-- Cooldown( 194466 ,{ name = "Phoenix's Flames", color = colors.DTEAL, scale = 0.5, priority = -1, ghost = true })
-- Cooldown( 224968 ,{ name = "Mark of Aluneth", color = colors.DTEAL, scale_until = 10, ghost = true })
-- Spell( 224968 ,{ name = "Mark of Aluneth", duration = 6, color = colors.DBLUE })


-- Item( 153130 ,{ name = "Man'Ari", color = colors.DTEAL, ghost = true })
Spell( 110909 ,{ name = "Alter Time", group = "buffs", duration = 10, color = colors.PURPLE3 })

helpers.Cast( 205021 ,{ name = "Ray of Frost", tick = 1, overlay = {"tick", "tickend"}, color = colors.CURSE, priority = 12, })

Spell( 210134 ,{ name = "Erosion", duration = 10, charged = true, maxcharge = 8, priority = -10, scale = 0.5, group = "buffs", color = colors.PURPLE4 })

Cooldown( 257537 ,{ name = "Ebonbolt", color = colors.DTEAL, scale_until = 10, ghost = true }) -- talent
Cooldown( 257541 ,{ name = "Phoenix's Flames", color = colors.DTEAL, scale = 0.5, priority = -1, ghost = true }) --talent

--ARCANE
-- Spell( 80353 ,{ name = "Time Warp", shine = true, target = "player", duration = 40, color = colors.WOO2 })
Spell({ 118,61305,28271,28272,61721,61780 },{ name = "Polymorph", duration = 50, color = colors.LGREEN, pvpduration = 8, short = "Poly" })
Spell( 12042 ,{ name = "Arcane Power",duration = 15, group = "buffs", color = colors.PINK })
--~ Spell( 66 ,{ name = "Fading",duration = 3 - NugRunning.TalentInfo(31574) })
Spell( 36032 ,{ name = "Arcane Charge",duration = 10, color = colors.CURSE })
-- Cooldown( 44425 ,{ name = "Arcane Barrage", color = colors.PINK3 })
Spell( 263725 ,{ name = "Clearcasting", shine = true, duration = 15, color = colors.CHIM })
Spell( 55342 ,{ name = "Mirror Image",duration = 40, group = "buffs" })

Cooldown( 153626 ,{ name = "Arcane Orb", color = colors.CHIM, ghost = true })


Cooldown( 198929,{ name = "Cinderstorm", color = colors.PINKIERED, ghost = true })
-- Cooldown( 153561,{ name = "Meteor", color = colors.PINKIERED, ghost = true })
-- Cooldown( 205029,{ name = "Flame On", color = colors.DPURPLE2, scale = 0.7 })

-- not shown in combat log
Spell( 116267 ,{ name = "Incanter's Flow", duration = 100500, group = "buffs", priority = -0.1, timeless = true, charged = true, maxcharge = 5, color = colors.LRED, stackcolor = {
                                                                            [1] = { .3, 0, 0},
                                                                            [2] = { .4, 0, 0},
                                                                            [3] = { .6, 0, 0},
                                                                            [4] = { .8, 0, 0},
                                                                            [5] = { 1, 0, 0},
                                                                        }})

-- Spell( 12536 ,{ name = "Clearcast",duration = 15, color = colors.BLACK })
Spell( 31589 ,{ name = "Slow", duration = 15, pvpduration = 8 })
--FIRE

Spell( 31661 ,{ name = "Dragon's Breath", duration = 5, color = colors.ORANGE, short = "Breath", maxtimers = 1 })
Spell( 2120 ,{ name = "Flamestrike", duration = 8, color = colors.PURPLE, maxtimers = 1 })

Spell( 269651 ,{ name = "Pyroclasm", priority = 5.1, shine = true, scale = 0.75, glowtime = 5, duration = 15, color = colors.PURPLE4 })

Spell( 48107 ,{ name = "Heating Up", priority = 5.2, effect = "AEGWYNN", shine = true, scale = 0.75, glowtime = 7, duration = 10, color = colors.DPURPLE })
Spell( 48108 ,{ name = "Hot Streak", priority = 5, effect = "JUDGEMENT", duration = 15, shine = true, color = colors.REJUV })
--Pyroblast
DotSpell( 11366 ,{ name = "", ghost = true, duration = 18, priority = 8, color = colors.PURPLE, singleTarget = true })
--Living Bomb
DotSpell( 44457 ,{ name = "", ghost = true, color = colors.PINKIERED, priority = 9, duration = 12, singleTarget = true })
Spell( 12654 ,{ name = "Ignite", shinerefresh = false, color = colors.DRED, priority = 1, duration = 5, singleTarget = true })
Spell( 190319,{ name = "Combustion", color = colors.ORANGE2, group = "buffs", priority = -5, duration = 10 })
Cooldown( 44457, { name = "Living Bomb", color = colors.RED, ghost = true })
Cooldown( 108853, { name = "Fire Blast", color = colors.LRED, ghost = true, resetable = true })
--Cooldown( 2136, { name = "Fire Blast", resetable = true, color = colors.LRED})
EventTimer({ spellID = 153561, event = "SPELL_CAST_SUCCESS", name = "Meteor", duration = 2.9, color = colors.FIRE })
EventTimer({ spellID = 12654, event = "SPELL_PERIODIC_DAMAGE", name = "Ignite",
    action = function(active, srcGUID, dstGUID, spellID, damage )
        local ignite_timer = NugRunning:FindActiveTimer(spellID, dstGUID, "DEBUFF")
        if ignite_timer then
            ignite_timer:SetName(damage)
        end
    end})

Spell( 198111 ,{ name = "Temporal Shield",duration = 6, color = colors.CHIM, group = "buffs" })

--FROST
Spell( 12472 ,{ name = "Icy Veins", group = "buffs", duration = 20, color = colors.PINK3 })
Spell( 82691 ,{ name = "Ring of Frost", shine = true, color = colors.FROZEN, maxtimers = 1, duration = 12, pvpduration = 8 }) -- it's not multi target, but... it can spam
Spell( 122 ,{ name = "Frost Nova",duration = 8, color = colors.FROZEN, maxtimers = 1 })
Spell( 228600 ,{ name = "Glacial Spike",duration = 4, color = colors.FROZEN, maxtimers = 1 })
Spell( 33395 ,{ name = "Freeze",duration = 8, maxtimers = 1, color = colors.FROZEN })
Spell( 44544 ,{ name = "Fingers of Frost", shine = true, shinerefresh = true, priority = 10, scale = 0.8, duration = 15, color = colors.PURPLE3 })
Spell( 228358 ,{ name = "Winter's Chill", duration = 6, shine = true, shinerefresh = true, color = colors.FROZEN })
Spell( 190446 ,{ name = "Brain Freeze", priority = 12, duration = 15, scale = 0.8, glowtime = 15, shine = true, shinerefresh = true, color = colors.DBLUE })
Spell( 195418 ,{ name = "Chain Reaction", duration = 6, color = colors.PURPLE, group = "buffs", scale = 0.7 })


Spell( 45438 ,{ name = "Ice Block",duration = 10, color = colors.CHIM })
Spell( 120 ,{ name = "Cone of Cold", duration = 8, color = colors.CHILL, short = "CoC", maxtimers = 1 })
Cooldown( 153595, { name = "Comet Storm", color = colors.PURPLE2})
Cooldown( 84714, { name = "Frozen Orb", color = colors.WOO, scale_until = 10, ghost = true})

--talents
Spell( 11426 ,{ name = "Ice Barrier", group = "buffs", duration = 60, color = colors.LGREEN })
Spell( 108839 ,{ name = "Ice Floes", duration = 15, color = colors.CURSE, group = "buffs" })
Spell( 236298 ,{ name = "Chrono Shift", duration = 5, color = colors.TEAL2, scale = 0.7, group = "buffs", priority = -5 })
-- Spell( 115610 ,{ name = "Temporal Shield", duration = 4, color = colors.LGREEN })

Spell( 32612 ,{ name = "Invisibility",duration = 20 })
Spell( 110960 ,{ name = "Greater Invisibility", duration = 20, color = colors.CURSE })

Spell( 116014, { name = "Rune of Power", timeless = true, duration = 1, color = colors.DPURPLE, priority = -50 })

Spell( 114923 ,{ name = "Nether Tempest", duration = 12, color = colors.PURPLE })

end

if class == "PALADIN" then

-- [[ COVENANTS ]]
Spell( 328282 ,{ --[[Night Fae]] name = "Blessing of Spring", group = "buffs", duration = 30, color = colors.WOO2, ghost = 1, shine = true })
Cooldown( 328282 ,{ --[[Night Fae]] name = "Blessing of Spring", scale_until = 5, ghosteffect = "NIGHTBORNE", ghost = 5, color = colors.PURPLE3 })
Spell( 328620 ,{ --[[Night Fae]] name = "Blessing of Summer", group = "buffs", duration = 30, color = colors.WOO2, ghost = 1, shine = true })
-- Cooldown( 328620 ,{ --[[Night Fae]] name = "Blessing of Summer", scale_until = 5, ghosteffect = "NIGHTBORNE", ghost = 5, color = colors.PURPLE3 })
Spell( 328622 ,{ --[[Night Fae]] name = "Blessing of Autumn", group = "buffs", duration = 30, color = colors.WOO2, ghost = 1, shine = true })
-- Cooldown( 328622 ,{ --[[Night Fae]] name = "Blessing of Autumn", scale_until = 5, ghosteffect = "NIGHTBORNE", ghost = 5, color = colors.PURPLE3 })
Spell( 328281 ,{ --[[Night Fae]] name = "Blessing of Winter", group = "buffs", duration = 30, color = colors.WOO2, ghost = 1, shine = true })
-- Cooldown( 328281 ,{ --[[Night Fae]] name = "Blessing of Winter", scale_until = 5, ghosteffect = "NIGHTBORNE", ghost = 5, color = colors.PURPLE3 })

Interrupt(96231, "Rebuke", 4)

local normalized_length = 8
-- [[ ARTIFACTS ]]
-- Cooldown( 205273 ,{ name = "Wake of Ashes", ghost = true, color = colors.DBLUE, scale_until = 8, fixedlen = normalized_length })
-- Spell( 200652 ,{ name = "Tyr's Deliverance", duration = 10, color = colors.DBLUE })
-- Spell( 209202 ,{ name = "Eye of Tyr", duration = 9, maxtimers = 1, color = colors.DBLUE })

Spell( 205191 ,{ name = "Eye for an Eye", duration = 10, group = "buffs", color = colors.DTEAL })
Spell( 184662 ,{ name = "Shield of Vengeance", duration = 15, group = "buffs", color = colors.GOLD })

Spell( 84963 ,{ name = "Inquisition", duration = 45, group = "buffs", scale = 0.6, ghost = true, color = colors.PURPLE })
Spell( 231895 ,{ name = "Crusade", duration = 25, shine = true, group = "buffs", scale = 0.6, ghost = true, color = colors.PURPLE })

Cooldown( 255937 ,{ name = "Wake of Ashes", ghost = true, color = colors.DBLUE, scale_until = 8 })
Spell( 343527 ,{ name = "Execution Sentence", scale = 0.9, duration = 8, color = colors.REJUV })
-- Cooldown( 267798 ,{ name = "Execution Sentence", ghost = true, color = colors.DPURPLE, scale_until = 5 })


--Spell( 53657 ,{ name = "Judgements of the Pure", short = "JotP", duration = 100500, color = colors.LBLUE })
Spell( 31884 ,{ name = "Avenging Wrath",duration = 20, group = "buffs", color = colors.LRED, effect = "JUDGEMENT" })
Spell( 216331 ,{ name = "Avenging Crusader",duration = 20, group = "buffs", color = colors.LRED, effect = "JUDGEMENT" })
Spell( 498 ,{ name = "Divine Protection",duration = 10, group = "buffs", color = colors.BLACK })
Spell( 642 ,{ name = "Divine Shield",duration = 8, group = "buffs", color = colors.BLACK })
Spell( 31850,{ name = "Ardent Defender", duration = 10, color = colors.BLACK, group = "buffs"})
Spell( 86659,{ name = "Guardian", duration = 8, color = colors.BLACK, group = "buffs"})
Spell( 31821,{ name = "Aura Mastery", duration = 6, target = "player", color = colors.GOLD, group = "buffs"})
Spell( 1022 ,{ name = "Blessing of Protection",duration = 10, short = "Protection", color = colors.WOO2, group = "buffs" })
Spell( 204018,{ name = "Blessing of Spellwarding",duration = 10, short = "Spellwarding", color = colors.WOO2, group = "buffs" })
Spell( 1044 ,{ name = "Blessing of Freedom",duration = 6, short = "Freedom", color = colors.BROWN, group = "buffs", scale = 0.8 })


Spell( 152262 ,{ name = "Seraphim", color = colors.PINKIERED, shine = true, shinerefresh = true, group = "buffs", priority = -10, duration = 15 })

-- Spell( 53563 ,{ name = "Beacon of Light", duration = 300, timeless = true, priority = -20, short = "Beacon",color = colors.RED })
-- Spell( 31842 ,{ name = "Divine Favor",duration = 20, short = "Favor" })
Spell( 20066 ,{ name = "Repentance",duration = 60, pvpduration = 8, color = colors.LBLUE })
Spell( 853 ,{ name = "Hammer of Justice", duration = 6, short = "HoJ", color = colors.FROZEN })
--Spell( 31803 ,{ name = "Censure",duration = 15, color = colors.RED})
-- Spell( 85696 ,{ name = "Zealotry",duration = 20 })

Spell( 183218 ,{ name = "Hand of Hindrance", duration = 10, short = "Hindrance", color = colors.BROWN })

Cooldown( 20473 ,{ name = "Holy Shock", ghost = true, priority = 9, fixedlen = normalized_length, color = colors.WOO })

Spell( 326733 ,{ name = "Empyrean Power", scale = 0.8, priority = 15, glowtime = 15, color = colors.PINK, duration = 15 })

Cooldown( 184575 ,{ name = "Blade of Justice", tickshine = true, ghost = true, priority = 9, fixedlen = normalized_length, color = colors.WOO, ghosteffect = "NIGHTBORNE" })
Cooldown( 35395 ,{ name = "Crusader Strike", tick = 1.5, tickshine = true, overlay = {"tick", "end"}, ghost = true, short = "", priority = 10, fixedlen = normalized_length, color = colors.CURSE, stackcolor = { colors.CURSE, colors.DPURPLE2 } })
Cooldown( 204019 ,{ name = "Blessed Hammer", short = "", ghost = true, ghosteffect = "AEGWYNN", priority = 10, fixedlen = normalized_length, color = colors.CURSE, stackcolor = {colors.CURSE, colors.CURSE, colors.DPURPLE2 } })
Cooldown( 53595 ,{ name = "Hammer of the Righteous", short = "", ghost = true, ghosteffect = "AEGWYNN", priority = 10, fixedlen = normalized_length, color = colors.CURSE, stackcolor = { colors.CURSE, colors.DPURPLE2 } })

Spell( 197277,{ name = "Judgement", shine = true, singleTarget = true, priority = -100500, color = colors.PURPLE2, duration = 6 }) --debuff
Cooldown( 20271 ,{ name = "Judgement", ghost = true, fixedlen = normalized_length, priority = 8, color = colors.PURPLE, ghosteffect = "JUDGEMENT", stackcolor = { colors.PURPLE, colors.PURPLE4} })

Totem(135926, { name = "Consecration", spellID = 26573, color = colors.PINKIERED, overlay = {0, 3, 0.3}, priority = 9, ghost = true, fixedlen = normalized_length })
-- EventTimer({ spellID = 26573 , event = "SPELL_CAST_SUCCESS", specmask = SPECS(1,2), name = "Consecration", duration = 12, color = colors.PINKIERED, overlay = {0,"gcd",.3}, multiTarget = true, priority = 9, ghost = 5, arrow = colors.PINKIERED, glow2time = 2, fixedlen = normalized_length })
-- Cooldown( 26573 ,{ name = "Consecration", minduration = 6, color = colors.PINKIERED, overlay = {0,"gcd",.3}, priority = 9, scale = 0.85, ghost = true, fixedlen = normalized_length })
Cooldown( 24275 ,{ name = "Hammer of Wrath", color = colors.TEAL2, fixedlen = normalized_length, ghost = true, priority = 11 })
Cooldown( 31935 ,{ name = "Avenger's Shield", resetable = true, fixedlen = normalized_length, priority = 5, scale = 1, ghosteffect = "NIGHTBORNE", color = colors.TEAL, ghost = true })

Spell( 132403 ,{ name = "Shield of the Righteous", short = "Shield", group = "buffs", duration = 3, priority = -15, scale = 1, glowtime = 1, arrow = colors.PINK2, color = colors.PINK3 })
-- Spell( 132403 ,{ name = "Shield of the Righteous", short = "SotR", duration = 3, priority = 10, color = colors.DPURPLE })

--Spell( 94686 ,{ name = "Crusader", duration = 15 })
Spell( 157048 ,{ name = "Final Verdict", duration = 30, color = colors.DPURPLE, timeless = true, priority = -7.5, scale = .6 })
--Activation( 879 ,{ name = "Exorcism", shine = true, color = colors.ORANGE, duration = 15 })
--Activation( 84963 ,{ name = "Hand of Light", shine = true, showid = 85256, short = "Light", color = colors.PINK, duration = 8 })

-- Spell( 62124 ,{ name = "Taunt", duration = 3 })
-- Spell( 85416 ,{ name = "Reset", shine = true, timeless = true, duration = 0.1, color = colors.BLACK })
--Activation( 31935 ,{ name = "Reset", shine = true, timeless = true, duration = 0.1, color = colors.BLACK })


-- EventTimer({ spellID = 223819 , event = "SPELL_AURA_REMOVED", priority = 14, name = "Divine Purpose", duration = 0.5, color = colors.REJUV })
-- EventTimer({ spellID = 85256 , event = "SPELL_CAST_SUCCESS", priority = 13, name = "Templar's Verdict", duration = 0.5, color = colors.PINK })
-- EventTimer({ spellID = 157048, event = "SPELL_CAST_SUCCESS", priority = 13, name = "Final Verdict", duration = 0.5, color = colors.PINK })
-- EventTimer({ spellID = 53385 , event = "SPELL_CAST_SUCCESS", priority = 13, name = "Divine Storm", duration = 0.5, color = colors.PINK })
-- EventTimer({ spellID = 53600 , event = "SPELL_CAST_SUCCESS", priority = 13, name = "SHOTR", duration = 0.5, color = colors.PINK })


Spell( 105421 ,{ name = "Blinding Light", duration = 6, maxtimers = 1 })
Spell( 105809 ,{ name = "Holy Avenger", color = colors.GOLD, group = "buffs", effect = "JUDGEMENT", duration = 20 })
Cooldown( 114165 ,{ name = "Holy Prism", color = colors.BLACK })
end

if class == "DRUID" then

-- [[ COVENANTS ]]
Spell( 338035 ,{ --[[Kyrian]] name = "Lone Meditation", group = "buffs", duration = 10, color = colors.WOO2, shine = true })
Spell( 338018 ,{ --[[Kyrian]] name = "Lone Protection", group = "buffs", duration = 10, color = colors.WOO2, shine = true })
Spell( 338142 ,{ --[[Kyrian]] name = "Lone Empowerment", group = "buffs", duration = 10, color = colors.WOO2, shine = true })
Spell( 327071 ,{ --[[Kyrian]] name = "Kindred Focus", group = "buffs", duration = 10, color = colors.WOO2, shine = true })
Spell( 327037 ,{ --[[Kyrian]] name = "Kindred Protection", group = "buffs", duration = 10, color = colors.WOO2, shine = true })
Spell( 327022 ,{ --[[Kyrian]] name = "Kindred Empowerment", group = "buffs", duration = 10, color = colors.WOO2, shine = true })

Spell( 323546 ,{ --[[Venthyr]] name = "Ravenous Frenzy", group = "buffs", duration = 20, color = colors.RED2, shine = true })
Spell( { 325748, 325733 } ,{ --[[Necrolord]] name = "Adaptive Swarm", duration = 12, color = colors.WOO2, shine = true })

Interrupt(106839, "Skull Bash", 4)

-- [[ ARTIFACTS ]]
-- Spell( 208253 ,{ name = "Essence of G'Hanir", duration = 8, color = colors.DBLUE })
-- Cooldown( 202767 ,{ name = "Moon", ghost = true, color = colors.PINK3 })
-- Cooldown( 210722 ,{ name = "Ashmane's Frenzy", scale_until = 15, ghost = true, color = colors.DTEAL })
-- Spell( 210723 ,{ name = "Ashmane's Frenzy", scale = 0.3, duration = 6, color = colors.PURPLE4 })
-- Spell( 200851 ,{ name = "Rage of the Sleeper", shine = true, duration = 10, color = colors.DBLUE })

Spell( 209749 ,{ name = "Faerie Swarm", duration = 8, color = colors.TEAL3 })
Spell( 236696 ,{ name = "Thorns", duration = 12, scale = 0.5, group = "buffs", shine = true, color = colors.DBROWN })

Spell( 2637 ,{ name = "Hibernate", duration = 40, color = colors.DBROWN })

Cooldown( 274837 ,{ name = "Feral Frenzy", scale_until = 10, ghost = true, color = colors.DTEAL })
Cooldown( 274281 ,{ name = "New Moon", ghost = true, color = colors.PINK, stackcolor = { colors.PINK, colors.PINK, colors.PURPLE4 } })

Spell( 135700 ,{ name = "Moment of Clarity", shine = true, duration = 15, color = colors.LBLUE, group = "buffs" })


Totem(134222, { name = "Efflorescence", spellID = 145205, color = colors.PINKIERED, priority = - 100, hideName = true })

Spell( 339 ,{ name = "Entangling Roots",duration = 30 })

Spell( 22842 ,{ name = "Frenzied Regeneration", duration = 5, color = colors.TEAL3, group = "buffs", shine = true })
-- Spell( 113746 ,{ name = "Weakened Armor", short = "WeakArmor", priority = -10, affiliation = "any", singleTarget = true, color = colors.BROWN, duration = 30 })

Spell( 48517 ,{ name = "Solar Eclipse", group = "buffs", duration = 15, shine = true, priority = -25, short = "Solar", color = colors.ORANGE }) -- Wrath boost
Spell( 48518 ,{ name = "Lunar Eclipse", group = "buffs", duration = 15, shine = true, priority = -24, short = "Lunar", color = colors.LBLUE }) -- Starfire boost

Spell( 78675,{ name = "Solar Beam", duration = 10, color = colors.GOLD, target = "player" })
Spell( 33786 ,{ name = "Cyclone", shine = true, color = colors.BLACK, overlay = {0, "gcd"}, duration = 6 })
DotSpell( 164812 ,{ name = "Moonfire", duration = 16, preghost = true, nameplates = true, priority = 10, ghost = true, color = colors.PURPLE,
        init = function(self)
            local duration = 16
            if GetSpecialization() == 1 then duration = duration + 6 end -- balance druid thing
            self.duration = duration
            if self.overlay then
                self.overlay[2] = duration*0.3
            end
            self.fixedlen = duration

            if GetSpecialization() == 3 then
                -- self.maxtimers = 1
                self.scale = 0.7
            else
                -- self.maxtimers = nil
                self.scale = 1
            end
        end,
        isknowncheck = function() return GetSpecialization() == 1 end
        })
-- Spell( 164547 ,{ name = "Lunar Empowerment", short = "", group = "buffs", priority = -25, duration = 30, scale = 0.8, ghost = true, color = colors.REJUV, charged = true, maxcharge = 3})
-- Spell( 164545 ,{ name = "Solar Empowerment", short = "", group = "buffs", priority = -24, duration = 30, scale = 0.8, ghost = true, color = colors.ORANGE2, charged = true, maxcharge = 3})
DotSpell( 164815 ,{ name = "Sunfire",duration = 12, preghost = true, nameplates = true, priority = 9, ghost = true, color = colors.ORANGE, maxtimers = 1,
        init = function(self)
            local duration = 12
            if GetSpecialization() == 1 then duration = duration + 6 end -- balance druid thing
            self.duration = duration
            if self.overlay then
                self.overlay[2] = duration*0.3
            end
            self.fixedlen = duration
        end,
        isknowncheck = function() return GetSpecialization() == 1 end }) -- Sunfire button spell id
-- Spell( 93400 ,{ name = "Shooting Stars", shine = true, duration = 12, color = colors.CURSE })
DotSpell( 191034 ,{ name = "Starfall", shine = true, duration = 10, color = colors.WOO2 })
-- Cooldown( 78674 ,{ name = "Starsurge", resetable = true, priority = 6, ghost = true, color = colors.CURSE })
Cooldown( 197626 ,{ name = "Starsurge", resetable = true, priority = 6, ghost = true, color = colors.CURSE })
DotSpell( 202347, { name = "Stellar Flare",duration = 24, priority = 5, ghost = true, color = colors.CHIM })
Spell( 279709, { name = "Starlord", duration = 15, group = "buffs", color = colors.CHIM, scale = 0.5 })

Spell( 213708,{ name = "Galactic Guardian", shine = true, priority = 12, duration = 15, glowtime = 15, scale = 0.7, color = colors.TEAL2 })

Spell( 192081, { name = "Ironfur", priority = -10, group = "buffs", shine = true, glowtime = 1, ghost = 1, color = colors.PINK3, duration = 7 })

Spell( 80313 ,{ name = "Pulverize",duration = 10, ghost = true, color = colors.WOO2 })
Spell( 155835 ,{ name = "Bristling Fur",duration = 3, color = colors.WOO2 })

Spell( 106951 ,{ name = "Berserk", duration = 15, shine = true, color = colors.TEAL2, group = "buffs" })
--cat
Spell( 163505 ,{ name = "Rake Stun", duration = 4, scale = 0.5, priority = 6.2, color = colors.PINK })

local bleed_normalize = 24
Spell( 155722 ,{ name = "Rake", duration = 15, showpower = true, priority = 6, preghost = true, nameplates = true, ghost = 4, overlay = {0, 15*0.3, 0.2}, fixedlen = bleed_normalize, color = colors.PINKIERED,
        isknowncheck = function() return IsPlayerSpell(1822) and IsUsableSpell(1822) end })
Spell( 1079 ,{ name = "Rip", duration = 24, preghost = true, showpower = true, priority = 5, ghost = 4, nameplates = true, maxtimers = 4, overlay = {0, 24*0.3, 0.2}, fixedlen = bleed_normalize, color = colors.RED, })

-- Spell( 210705 ,{ name = "Ashamane's Rip", duration = 24, priority = 4, scale = 0.75, fixedlen = 24, color = colors.PURPLE })
-- feral's thrash
Spell( 106830, { name = "Thrash", showpower = true, fixedlen = bleed_normalize, nameplates = true, overlay = {0, 15*0.3, 0.2}, maxtimers = 1, color = colors.PURPLE, duration = 15, ghost = true })
Spell( 192090, { name = "Thrash", maxtimers = 1, color = colors.PURPLE, duration = 15, scale = 0.7, ghost = true })

Cooldown( 202028, { name = "Brutal Slash", priority = 10, ghost = true, color = colors.CURSE, stackcolor = {colors.CURSE, colors.CURSE, colors.DPURPLE2 } })

Spell( 203123 ,{ name = "Maim", color = colors.PINK, duration = 5 })
Spell( 5217, { name = "Tiger's Fury", duration = 8, color = colors.GOLD, scale = 0.7, group = "buffs", shine = true })
Cooldown( 5217, { name = "Tiger's Fury", color = colors.DBROWN, ghost = true, ghosteffect = "AEGWYNN", scale_until = 5})
Cooldown( 202060, { name = "Elune's Guidance", color = colors.PURPLE3, ghost = true, scale_until = 10, fixedlen = 15})
--normal, glyph of savage roar
Spell( 52610,{ name = "Savage Roar", group = "buffs", priority = -10, overlay = {0, 10.8}, color = colors.PURPLE, duration = 36 })
Spell( 1850 ,{ name = "Dash", duration = 15 })

Spell( 145152,{ name = "Bloodtalons", short = "", duration = 30, color = colors.DRED, charged = true, maxcharge = 2, priority = -25, group = "buffs", shine = true, })
Spell( 69369,{ name = "Predatory Swiftness", priority = -20, duration = 12, color = colors.PURPLE4, color2 = colors.REJUV, scale = 0.5, glowtime = 12, group = "buffs",
    init = function(self)
        if IsPlayerSpell(155672) then -- Bloodtalons
            -- self.shine = true
            self.glowtime = 12
            self.priority = -20
            self.scale = 0.6
        else
            -- self.shine = nil
            self.glowtime = nil
            self.priority = 1
            self.scale = 0.3
        end

    end})
-- Spell( 81022 ,{ name = "Stampede", duration = 8 })
--bear
Spell( 22812 ,{ name = "Barkskin",duration = 12, color = colors.WOO2, priority = -9 })
Spell( 99 ,{ name = "Incapacitating Roar", duration = 3, maxtimers = 1 })
-- Spell( 6795 ,{ name = "Taunt", duration = 3 })
-- Spell( 5209 ,{ name = "Challenging Roar", shine = true, duration = 6, maxtimers = 1 })
Spell( 5211 ,{ name = "Bash",duration = 5, shine = true, color = colors.PINK })
-- guardian's thrash
Cooldown( 77758, { name = "Thrash", priority = 8, color = colors.PINKIERED, fixedlen = 9, overlay = {0, "gcd", 0.3}, ghost = true })


Cooldown( 33917, { name = "Mangle", tick = 1.5, tickshine = true, overlay = {"tick", "end"}, priority = 10, short = "", resetable = true, fixedlen = 9, ghost = true,  color = colors.CURSE })
-- Spell( 93622 ,{ name = "Reset", shine = true, color = colors.CURSE, duration = 5 })

Spell( 102359 ,{ name = "Mass Entanglement", duration = 20, color = colors.BROWN, maxtimers = 1 })
Spell( 102351 ,{ name = "Cenarion Ward",duration = 30, color = colors.WOO2 })
Spell( 102352 ,{ name = "Cenarion Ward",duration = 6, color = colors.TEAL })

Spell( 117679 ,{ name = "Incarnation: Tree of Life", short = "Incarnation", duration =  30, color = colors.TEAL2, group = "buffs", shine = true })
Spell( 102558 ,{ name = "Incarnation: Son of Ursoc", short = "Incarnation", duration =  30, color = colors.TEAL2, group = "buffs", shine = true })
Spell( 102560 ,{ name = "Incarnation: Chosen of Elune", short = "Incarnation", duration =  30, color = colors.TEAL2, group = "buffs", shine = true })
Spell( 102543 ,{ name = "Incarnation: King of the Jungle", short = "Incarnation", duration =  30, color = colors.TEAL2, group = "buffs", shine = true })

Spell( 194223 ,{ name = "Celestial Alignment", short = "Alignment", duration =  15, color = colors.TEAL2, group = "buffs", shine = true })

Spell( 102342 ,{ name = "Ironbark",duration = 12 })

Spell( 61336 ,{ name = "Survival Instincts", color = colors.BLACK, duration = 6, group = "buffs", ghost = 1 })
Spell( 774 ,{ name = "Rejuvenation", scale = 0.7, priority = 5, duration = 18, color = colors.REJUV })
Spell( 155777 ,{ name = "Germination", scale = 0.5, priority = 5.2, duration = 18, color = colors.PURPLE2 })
-- Spell( 8936 ,{ name = "Regrowth",duration = 6, specmask = 0xFF0F, color = { 198/255, 233/255, 80/255} })
Spell( 33763 ,{ name = "Lifebloom", shinerefresh = true, recast_mark = 3, duration = 15, color = { 0.5, 1, 0.5} })
Spell( 48438 ,{ name = "Wild Growth", duration = 7, maxtimers = 1, color = colors.LGREEN })
Spell( 16870 ,{ name = "Clearcasting",  duration = 15 })
end

if class == "DEMONHUNTER" then

    -- [[ COVENANTS ]]
    Spell( 317009 ,{ --[[Venthyr]] name = "Sinful Brand", duration = 8, color = colors.RED2, maxtimers = 1 })

    Interrupt(183752, "Disrupt", 3)

    Spell( 205630,{ name = "Illidan's Grasp", color = colors.PURPLE4, duration = 6 })

    Spell( 204490,{ name = "Sigil of Silence", color = colors.LBLUE, maxtimers = 1, duration = 8 })

    Spell( 204598,{ name = "Sigil of Flame", short = "", color = colors.PINKIERED, duration = 6, effect = "JUDGEMENT", recast_mark = 2, overlay = {0,3}, effecttime = 3, maxtimers = 1 })

    Cooldown( 204513,{ name = "Sigil of Flame", color = colors.WOO, scale_until = 5, ghost = true })
    Cooldown( 189110,{ name = "Infernal Strike", color = colors.PURPLE3, scale = 0.8, ghost = true })

    DotSpell( 247456,{ name = "Frailty", color = colors.PURPLE4, scale = 0.9, duration = 20, glowtime = 3, singleTarget = true })

    Spell( 263648,{ name = "Soul Barrier", color = colors.CHIM, shine = true, group = "buffs", scale = 0.9, duration = 12 })

    Cooldown( 263642,{ name = "Fracture", tick = 1.5, overlay = {"tick", "tickend"}, color = colors.CURSE, ghost = true, fixedlen = 10,  ghosteffect = "NIGHTBORNE", priority = 11 })

    Spell( 206491,{ name = "Nemesis", color = colors.RED, shine = true, scale = 0.9, duration = 60 })

    Spell( 258860,{ name = "Dark Slash", color = colors.PURPLE, scale = 0.75, duration = 8 })
    Cooldown( 258860,{ name = "Dark Slash", color = colors.PURPLE4, scale_until = 5, priority = -2 })

    -- havoc
    Spell( 258920,{ name = "Immolation Aura", color = colors.TEAL3, scale = 0.75, group = "buffs", priority = 6, duration = 10 })
    Cooldown( 258920,{ name = "Immolation Aura", color = colors.PINKIERED, scale_until = 5, ghosteffect = "JUDGEMENT", priority = -1 })

    -- vengeance
    Spell( 207771,{ name = "Fiery Brand",  duration = 10, shine = true, group = "buffs", color = colors.RED })
    Spell( 203819,{ name = "Demon Spikes", ghost = 1, arrow = colors.PINK3, glow2time = 1, color = colors.PINK3, shine = true, group = "buffs", priority = - 9, duration = 6 })

    EventTimer({ spellID = 196718, event = "SPELL_CAST_SUCCESS", name = "Darkness", duration = 8, shine = true, color = colors.DPURPLE, scale = 0.8 })

    Spell( 187827,{ name = "Metamorphosis",  duration = 20, group = "buffs", priority = -8, color = colors.CURSE }) -- vengeance
    Spell( 162264,{ name = "Metamorphosis",  duration = 30, group = "buffs", priority = -8, color = colors.CURSE }) -- havoc
    Spell( 212800,{ name = "Blur",  duration = 10, shine = true, group = "buffs", color = colors.PINK })
    Spell( 196555,{ name = "Netherwalk",  duration = 5, group = "buffs", color = colors.PURPLE4, shine = true })
    Cooldown( 232893,{ name = "Felblade", color = colors.PURPLE, ghosteffect = "NIGHTBORNE", ghost = true, fixedlen = 10, priority = 10, resetable = true})
    Cooldown( 185123,{ name = "Throw Glaive", ghost = true, color = colors.TEAL3, scale = 0.75, priority = 4, resetable = true, })
    Cooldown( 188499,{ name = "Blade Dance",  color = colors.PINKIERED, ghost = 2, fixedlen = 10, priority = 3, resetable = true })

    helpers.Cast( 198013 ,{ name = "Eye Beam", color = colors.PINK, priority = 12, })
    helpers.Cast( 258925 ,{ name = "Fel Barrage", color = colors.PINK, priority = 12, })


    Cooldown( 195072 ,{ name = "Fel Rush", ghost = true, minduration = 3, color = colors.PURPLE3, fixedlen = 10, scale = 0.8, resetable = true })
    Cooldown( 198013 ,{ name = "Eye Beam", ghost = true, color = colors.DPURPLE2, color2 = colors.REJUV, scale_until = 10, resetable = true })
    Cooldown( 212084 ,{ name = "Fel Devastation", ghost = true, color = colors.DTEAL, scale_until = 10 })
    Spell( 179057,{ name = "Chaos Nova",  duration = 5, color = colors.RED, shine = true, maxtimers = 1 })
    Spell( 211881,{ name = "Fel Eruption",  duration = 2, color = colors.RED, shine = true })
    Spell( 217832,{ name = "Imprison",  duration = 60, color = colors.GOLD })
    Spell( 224509,{ name = "Frailty",  duration = 15, singleTarget = true, ghost = true, color = colors.DPURPLE })
    Spell( 208628,{ name = "Momentum",  duration = 6, group = "buffs", ghost = 1, priority = -9999, shine = true, shinerefresh = true, color = colors.REJUV, scale = 0.8 })
    Spell( 203650,{ name = "Prepared", group = "buffs", color = colors.DPURPLE, scale = 0.8, duration = 10 })

    Spell( 207811,{ name = "Nether Bond", group = "buffs", duration = 15, color = colors.WOO2, shine = true })

    Cooldown( 211881,{ name = "Fel Eruption", color = colors.DBROWN, ghost = true,  resetable = true, scale_until = 10, fixedlen = 10})

    Cooldown( 207407,{ name = "Soul Carver", color = colors.DTEAL, scale_until = 10,})
    Cooldown( 201467,{ name = "Fury of the Illidari", color = colors.DTEAL, scale_until = 10,})
    -- EventTimer({ spellID = 204596, event = "SPELL_CAST_SUCCESS", name = "Sigil of Flame", duration = 2, color = colors.FIRE, scale = 0.8 })
    -- EventTimer({ spellID = 202138, event = "SPELL_CAST_SUCCESS", name = "Sigil of Chains", duration = 2, color = colors.BROWN, scale = 0.8 })
    -- EventTimer({ spellID = 202137, event = "SPELL_CAST_SUCCESS", name = "Sigil of Silence", duration = 2, color = colors.WOO2, scale = 0.8 })
end

if class == "HUNTER" then

-- [[ COVENANTS ]]
Spell( 308498 ,{ --[[Kyrian]] name = "Resonating Arrow", group = "buffs", maxtimers = 1, duration = 10, color = colors.WOO2 })
-- Spell( 324149 ,{ --[[Venthyr]] name = "Flayed Shot", duration = 20, color = colors.RED })
Cooldown( 324149 ,{ --[[Venthyr]] name = "Flayed Shot", color = colors.WOO2, ghost = 5 })
Spell( 324156 ,{ --[[Venthyr]] name = "Flayer's Mark", priority = 15, glowtime = 12, duration = 12, color = colors.PINK })
Spell( 328275 ,{ --[[Night Fae]] name = "Wild Spirits", maxtimers = 1, duration = 15, color = colors.WOO2 })


Interrupt(187707, "Muzzle", 3)
Interrupt(147362, "Counter Shot", 3)

-- [[ ARTIFACTS ]]
-- Cooldown( 207068 ,{ name = "Titan's Thunder", ghost = true, color = colors.DTEAL, scale_until = 10 })
-- Cooldown( 204147 ,{ name = "Windburst", ghost = true, color = colors.DTEAL, scale_until = 8, })
-- Cooldown( 203415 ,{ name = "Fury of the Eagle", ghost = true, color = colors.DTEAL, scale_until = 10 })
-- helpers.Cast( 203415 ,{ name = "Fury of the Eagle", shine = true, color = colors.DBLUE, priority = 12, })


Spell( 271049,{ name = "Volatile Wildfire", shine = true, color = colors.TEAL2, group = "buffs", scale = 0.75, duration = 5, maxtimers = 1 })
Spell( 270339,{ name = "Scorching Shrapnel", shine = true, color = colors.BLUE, group = "buffs", scale = 0.75, duration = 5, maxtimers = 1 })
Spell( 270332,{ name = "Scorching Pheromones", shine = true, color = colors.ORANGE, group = "buffs", scale = 0.75, duration = 5, maxtimers = 1 })

Cooldown( 269751 ,{ name = "Flanking Strike", ghost = true, color = colors.DTEAL, scale_until = 8, })
Cooldown( 19574 ,{ name = "Bestial Wrath", ghost = true, glowtime = 5, effecttime = 5, effect = "NIGHTBORNE", color = colors.PINK3, scale = 0.5 })

Spell( 260242 ,{ name = "Precise Shots", duration = 15, scale = 0.6, group = "buffs", color = colors.PINKIERED, priority = -55, shine = true, charged = true, maxcharge = 2 })
Spell( 257622 ,{ name = "Trick Shots", duration = 20, scale = 0.6, group = "buffs", priority = -60, shine = true, color = colors.DBROWN, })


Spell( 266779,{ name = "Coordinated Assault", duration = 20, fixedlen = 20, group = "buffs", target = "player", color = colors.BLACK, shine = true })

-- EventTimer({ spellID = 131894, event = "SPELL_CAST_SUCCESS", name = "A Murder of Crows", duration = 30, color = colors.LBLUE })
Spell( 199483,{ name = "Camouflage", duration = 60, target = "player", color = colors.CURSE })

--Spell( 77769 ,{ name = "Trap Launcher", shine = true, timeless = true, duration = 0.1, color = colors.CURSE })
-- Spell( 193534 ,{ name = "Steady Focus", duration = 10, group = "buffs", scale = 0.8, color = colors.BLACK })

-- Spell( 82925 ,{ name = "Ready, Set, Aim...", short = "", duration = 30, shinerefresh = true, color = colors.LBLUE }) --removed
-- Spell( 82926 ,{ name = "Aimed Shot!", duration = 10, shine = true, color = colors.WOO2 }) --removed
-- Spell( 34720 ,{ name = "Thrill of the Hunt", duration = 15, shine = true, color = colors.TEAL, priority = -5 })



Spell( 118455 ,{ name = "Beast Cleave", duration = 4, target = "pet", priority = -6, color = colors.TEAL2 })
-- Spell( 82654 ,{ name = "Widow Venom", duration = 30, color = { 0.1, 0.75, 0.1} })--removed

Spell( 19574 ,{ name = "Bestial Wrath", group = "buffs", duration = 10, priority = -9, color = colors.LRED, target = "player" })

Spell( 193534 ,{ name = "Steady Focus", group = "buffs", duration = 10, priority = -7, color = colors.GOLD })

Spell( 136 ,{ name = "Mend Pet", duration = 10, color = colors.LGREEN })

Spell( 195645,{ name = "Wing Clip", duration = 15, pvpduration = 8, color = colors.BROWN })
Spell( 200108,{ name = "Ranger's Net Root", short = "Root", duration = 3, color = colors.RED })
Spell( 206755,{ name = "Ranger's Net", duration = 15, pvpduration = 8, color = colors.BROWN })

Spell( 191241,{ name = "Sticky Bomb", duration = 3, shine = true, color = colors.LRED })
--Spell( 19306 ,{ name = "Counterattack", duration = 5, color = { 192/255, 77/255, 48/255} })l

-- Surv Ability
DotSpell( 259491 ,{ name = "Serpent Sting (Surv)", short = "Serpent Sting", duration = 12, color = colors.PURPLE, maxtimers = 3, ghost = true })
-- MM Talent
DotSpell( 271788 ,{ name = "Serpent Sting", duration = 18, color = colors.PURPLE, ghost = true })
Spell( 5116 ,{ name = "Concussive Shot", duration = 6, color = colors.CHILL, init = function(self)self.duration = 4 + Talent(19407) end })

Spell( 24394 ,{ name = "Intimidation", duration = 5, color = colors.RED })
Spell( 19386 ,{ name = "Wyvern Sting", duration = 30, pvpduration = 8, short = "Wyvern",color = colors.LGREEN })

Spell( 259277 ,{ name = "Bloodseeker", duration = 8, color = colors.RED, scale = 0.8 })

Spell( 3355 ,{ name = "Freezing Trap", duration = 10, pvpduration = 8, color = colors.FROZEN, init = function(self)self.duration = 20 * (1+Talent(19376)*0.1) end })


Cooldown( 34026 ,{ name = "Kill Command (BM)", short = "Kill Command", color = colors.CURSE, ghost = true, tick = 1.5, overlay = {"tick", "end"}, short = "", ghosteffect = "NIGHTBORNE", fixedlen = 9, priority = 10, resetable = true })
Cooldown( 259489 ,{ name = "Kill Command (Suv)", short = "Kill Command", color = colors.CURSE, ghost = true, tick = 1.5, overlay = {"tick", "end"}, short = "", ghosteffect = "NIGHTBORNE", resetable = true, fixedlen = 9, priority = 10, resetable = true })

Cooldown( 53351 ,{ name = "Kill Shot", color = colors.PINKIERED, ghost = true, priority = 9, resetable = true })


Cooldown( 194599,{ name = "Black Arrow", color = colors.PURPLE, ghost = true, priority = 8 })

Cooldown( 212436,{ name = "Butchery", color = colors.PINK, ghost = true, priority = 7, stackcolor = {colors.PINK, colors.PINK3, colors.PURPLE4 } })
Cooldown( 187708,{ name = "Carve", color = colors.PINKIERED, scale = 0.75, ghost = true, priority = 5 })


Cooldown( 259391,{ name = "Chakrams", color = colors.WOO2, ghost = true, ghosteffect = "JUDGEMENT", scale = 0.8, priority = 5 })
Cooldown( 259495,{ name = "Wildfire Bomb", color = colors.WOO, ghost = true, ghosteffect = "AEGWYNN", scale = 0.8, priority = 5 })

Cooldown( 257044,{ name = "Rapid Fire", color = colors.PURPLE4, ghost = true, effect = "AEGWYNN", effecttime = 1.5, priority = 5 })
Cooldown( 212431 ,{ name = "Explosive Shot", color = colors.WOO, effect = "JUDGEMENT", effecttime = 1.5, ghost = true, priority = 3, scale_until = 5 })

Spell( 117526,{ name = "Binding Shot Root", short = "Root", duration = 8, color = colors.BROWN, maxtimers = 1 })
Spell( 321469 ,{ name = "Binding Shackles", duration = 8, color = colors.DBROWN })

-- helpers.Cast(257044, {name = "Rapid Fire", scale = 0.5, color = colors.PINKIERED, priority = 10.1 })
-- helpers.Cast(19434, {name = "Aimed Shot", scale = 0.5, color = colors.PINKIERED, priority = 10.1 })
-- helpers.Cast(56641, {name = "Steady Shot", scale = 0.5, color = colors.PINKIERED, priority = 10.1 })
Cooldown( 19434, {name = "Aimed Shot", color = colors.CURSE, stackcolor = { colors.CURSE, colors.PURPLE5 }, tick = 1.5, overlay = {"tick", "end"}, ghost = true, ghosteffect = "NIGHTBORNE", priority = 10 })
-- Activation( 19434, { for_cd = true, effect = "MAGICCAST", ghost = 3 })
EventTimer({ spellID = 185358, event = "SPELL_CAST_SUCCESS", priority = 12, name = "Arcane Shot", duration = 0.5, color = colors.PINK })
EventTimer({ spellID = 2643, event = "SPELL_CAST_SUCCESS", priority = 12, name = "Multi-Shot", duration = 0.5, color = colors.PINK })

Cooldown( 194855,{ name = "Dragonsfire Grenade", color = colors.DRED, scale_until = 7, ghost = true, priority = 3 })
Cooldown( 131894,{ name = "A Murder of Crows", short = "Crows", scale_until = 10, ghost = true, resetable = true, priority = 3, color = colors.PURPLE3  })
Cooldown( 162488,{ name = "Steel Trap", color = colors.BLACK, scale_until = 10, ghost = true })
Cooldown( 191433,{ name = "Explosive Trap", color = colors.PURPLE, scale_until = 7, ghost = true, priority = 4 })
Cooldown( 194407,{ name = "Spitting Cobra", color = colors.PINK3, scale = 0.7, ghost = true, priority = 1 })

Spell( 259388,{ name = "Mongoose Fury", fixedlen = 14, duration = 14, color = colors.PINKIERED, group = "buffs", scale = 0.85, priority = -100, shine = true })
DotSpell( 185855,{ name = "Lacerate", duration = 12, color = colors.RED, priority = -5, ghost = true })

Spell( 201081,{ name = "Mok'Nathal Tactics", duration = 8, group = "buffs", scale = 0.8, priority = -200, color = colors.PINK3, shine = true, shinerefresh = true })

Spell( 288613,{ name = "Trueshot", duration = 15, group = "buffs", priority = -1, color = colors.TEAL, shine = true })
Spell( 186265,{ name = "Aspect of the Turtle", short = "Turtle", group = "buffs", duration = 8, color = colors.BLACK, shine = true })
Spell( 186289,{ name = "Aspect of the Eagle", short = "Eagle", group = "buffs", duration = 10, color = colors.TEAL, shine = true })
Spell( 193530,{ name = "Aspect of the Wild", short = "Wild", group = "buffs", duration = 10, target = "player", color = colors.TEAL, shine = true })

Spell( 117526 ,{ name = "Binding Shot", duration = 5, pvpduration = 3, color = colors.RED, maxtimers = 1 })
Cooldown( 120679,{ name = "Dire Beast", priority = 6, ghost = true, scale = 0.8, color = colors.PURPLE, fixedlen = 9 })
Cooldown( 217200,{ name = "Barbed Shot", priority = 6, ghost = true, color = colors.PINKIERED, stackcolor = { colors.RED, colors.PURPLE4 }, fixedlen = 9, resetable = true })
Activation( 217200, { for_cd = true, effect = "SLICENDICE", ghost = 3 })
Spell( 257946,{ name = "Thrill of the Hunt", group = "buffs", duration = 8, ghost = true, color = colors.PINK3, scale = 0.75, priority = -50 })
Spell( 217200,{ name = "Barbed Shot", overlay = {0, 1}, recast_mark = 1, duration = 8, ghost = true, color = colors.PURPLE, fixedlen = 9 })
Cooldown( 53209 ,{ name = "Chimera Shot", color = colors.CHIM, ghost = true, fixedlen = 9 })

helpers.Cast( 120360 ,{ name = "Barrage", color = colors.CURSE, priority = 12 })
Cooldown( 120360 ,{ name = "Barrage", color = colors.WOO, scale_until = 8, ghost = true })
-- Cooldown( 194386 , { name = "Volley", ghost = true, scale = 0.7,    overlay = {0,"gcd",.3}, color = colors.DBLUE, fixedlen = 9, priority = 9.5 })

Cooldown( 198670 ,{ name = "Head Shot", color = colors.DBLUE, ghost = true })
Cooldown( 214579 ,{ name = "Sidewinders", color = colors.DBROWN, ghost = true })
Spell( 194594,{ name = "Lock and Load", color = colors.TEAL3, glowtime = 15, priority = 12, scale = 0.8, duration = 15})
Cooldown( 198670 ,{ name = "Piercing Shot", color = colors.WOO2, scale_until = 7, ghost = true })

-- helpers.Cast(77767, {name = "Cobra Shot", tick = .5, overlay = {"tick", "end"}, fixedlen = 8, color = colors.GREEN, priority = 15 })

end

if class == "SHAMAN" then
Interrupt(57994, "Wind Shear", 3)

-- [[ ARTIFACTS ]]
-- Cooldown( 205495 ,{ name = "Stormkeeper", ghost = true, color = colors.DTEAL, scale_until = 10 })
-- Cooldown( 204945 ,{ name = "Doom Winds", ghost = true, color = colors.DTEAL, scale_until = 10 })
-- Spell( 204945 ,{ name = "Doom Winds", shine = true, color = colors.TEAL3, group = "buffs", duration = 6 })


local enh_normalize = 8

-- Spell( 8056 ,{ name = "Frost Shock", duration = 8, color = colors.CHILL, short = "FrS" })
Spell( 974 ,{ name = "Earth Shield", duration = 60, timeless = true, charged = true, maxcharge = 9, color = colors.LGREEN })

Spell( 61295 ,{ name = "Riptide", duration = 15, color = colors.FROZEN })
Spell( 51514 ,{ name = "Hex", duration = 50, pvpduration = 8, color = colors.CURSE })
Spell( 79206 ,{ name = "Spiritwalker's Grace", duration = 10, color = colors.LGREEN, group = "buffs" })

DotSpell( 188389 ,{ name = "Flame Shock", duration = 18, color = colors.RED, preghost = true, ghost = true, ghosteffect = "JUDGEMENT" }) -- elemental
Cooldown( 188389 ,{ name = "Flame Shock", color = colors.DTEAL, scale = 0.6, ghost = 1, priority = 1, scale = 1 })  -- elemental

Spell( 196840 ,{ name = "Frost Shock", duration = 5, color = colors.LBLUE, })
Spell( 197209 ,{ name = "Lightning Rod", duration = 10, color = colors.DBLUE, shine = true, shinerefresh = true })



Spell( 16166 ,{ name = "Elemental Mastery", duration = 20, color = colors.PINKIERED, group = "buffs" })
Spell( 77762 ,{ name = "Lava Surge", duration = 6, color = colors.TEAL2, glowtime = 6, effect = "JUDGEMENT", priority = 11, scale = .7, shine = true })
Cooldown( 51505 ,{ name = "Lava Burst", color = colors.CURSE, ghost = true, priority = 10, resetable = true })
-- Cooldown( 51490 ,{ name = "Thunderstorm", color = colors.WOO2, scale_until = 5 })
Cooldown( 61882 ,{ name = "Earthquake", color = colors.BROWN })
Cooldown( 117014 ,{ name = "Elemental Blast", priority = 9, ghost = true, scale = 0.75, color = colors.PINK })

Spell( 108281,{ name = "Ancestral Guidance", duration = 10, color = colors.DPURPLE, shine = true })

Cooldown( 60103 ,{ name = "Lava Lash", color = colors.LRED, priority = 9, ghost = 5, fixedlen = enh_normalize })

Spell( 210714 ,{ name = "Icefury", duration = 15, color = colors.FROZEN, scale = 0.8, group = "buffs" })
Cooldown( 210714 ,{ name = "Icefury", duration = 15, ghost = true, scale_until = 5, color = colors.TEAL })


Spell( 194084 ,{ name = "Flametongue", duration = 16, color = colors.PINK3, scale = 0.75, fixedlen = enh_normalize, group = "buffs" })
Spell( 196834 ,{ name = "Frostbrand", duration = 16, color = colors.FROZEN, group = "buffs" })
Spell( 187878 ,{ name = "Crash Lightning", duration = 10, overlay = {0, 2}, color = colors.PURPLE, ghost = 6, priority = 7, fixedlen = enh_normalize })

Spell( 201898 ,{ name = "Windsong", duration = 20, color = colors.WOO, group = "buffs" })

Spell( 197211 ,{ name = "Fury of Air", timeless = true, duration = 5, color = colors.DPURPLE, priority = -5, scale = 0.8, shine = true })
Cooldown( 197214 ,{ name = "Sundering", color = colors.DBROWN, ghost = true, scale_until = 10 })

Spell( 215785 ,{ name = "Hot Hand", duration = 15, glowtime = 14, color = colors.RED, priority = -8, group = "buffs" })

Spell( 201846 ,{ name = "Stormbringer", duration = 12, glowtime = 12, color = colors.TEAL3, priority = 10.5, scale = 0.5 })
Cooldown( 17364 ,{ name = "Stormstrike", color = colors.CURSE, ghosteffect = "NIGHTBORNE", fixedlen = enh_normalize, priority = 10, resetable = true, ghost = 9  })
Cooldown( 193786 ,{ name = "Rockbiter", color = colors.PINKIERED, priority = 9, fixedlen = enh_normalize, ghost = true, stackcolor = { colors.PINKIERED, colors.PURPLE4 } })

Cooldown( 188089 ,{ name = "Earthen Spike", color = colors.PURPLE3, ghost = true, scale_until = 10 })


Spell({ 114050, 114051, 114052} ,{ name = "Ascendance", duration = 15, color = colors.PINK }) --ele, enh, resto
Spell( 108271 ,{ name = "Astral Shift", group = "buffs", duration = 6, shine = true, color = colors.PURPLE3 })
Spell( 58875 ,{ name = "Spirit Walk", group = "buffs", duration = 8, shine = true })

Spell( 320125 ,{ name = "Echoing Shock", duration = 8, color = colors.DBLUE, effect = "AEGWYNN", ghost = 1 })
Spell( 260111 ,{ name = "Fulmination", duration = 30, maxcharge = 8, group = "buffs", glowstack = 7, priority = -10, charged = true, ghost = 3, color = colors.PINK2 })
EventTimer({ event = "SPELL_CAST_SUCCESS", spellID = 61882, name = "Earthquake", duration = 6, color = colors.DBROWN, shine = true })

Spell( 187881 ,{ name = "Maelstrom", duration = 30, maxcharge = 10, group = "buffs", glowstack = 5, priority = -10, charged = true, ghost = 3, color = colors.PINK2 })
Cooldown( 333974 ,{ name = "Fire Nova", color = colors.WOO, ghost = true, scale_until = 10 })

EventTimer({ spellID = 51533, event = "SPELL_CAST_SUCCESS", group = "buffs", name = "Feral Spirit", duration = 15, scale = 0.6, color = colors.WOO2 })
Spell( 118905 ,{ name = "Static Charge", duration = 3, color = colors.BLACK, maxtimers = 1 })
Spell( 64695 ,{ name = "Earthgrab Root", duration = 8, color = colors.BROWN, scale = 0.7, maxtimers = 1 })

Spell( 73685 ,{ name = "Unleash Life", duration = 10, color = colors.TEAL3, ghost = 1, scale = 0.8 })
Spell( 73920 ,{ name = "Healing Rain", duration = 10, color = colors.FROZEN })
--pvp
Spell( 210918 ,{ name = "Ethereal Form", group = "buffs", duration = 15, shine = true, color = colors.CHIM })
-- Spell( 208997, { name = "Counterstrike Totem", timeless = true, maxtimers = 1, group = "buffs", duration = 15, scale = 0.7, color = colors.DBLUE })
Totem(511726, { spellID = 208997, group = "buffs", name = "Counterstrike Totem", scale = 0.7, color = colors.DBLUE, ghost = 1 })
Totem(135829, { spellID = 208963, group = "buffs", name = "Skyfury Totem", scale = 0.7, color = colors.PURPLE4, ghost = 1 })
Totem(971076, { spellID = 157153, group = "buffs", name = "Cloudburst Totem", color = colors.LGREEN })
Totem(136013, { spellID = 192058, group = "buffs", name = "Capacitor Totem", color = colors.LBLUE })
Totem(135861, { spellID = 16191, group = "buffs", name = "Mana Tide Totem", color = colors.PURPLE })
-- Totem(136114, { spellID = 8512, group = "buffs", name = "Windfury Totem", color = colors.PINK3 })
Totem(136039, { spellID = 204336, name = "Grounding Totem", group = "buffs", scale = 0.7, shine = true, color = colors.CURSE, ghost = 1 })
Totem(136108, { spellID = 8143, group = "buffs", name = "Tremor Totem", color = colors.DPURPLE, ghost = 1 })
Totem(538576, { spellID = 192077, group = "buffs", name = "Wind Rush Totem", ghost = 1 })
Totem(136102, { spellID = 2484, group = "buffs", name = "Earthbind Totem", color = colors.DBROWN, ghost = 1 })
Totem(237586, { spellID = 98008, group = "buffs", name = "Spirit Link Totem", shine = true, color = colors.TEAL2, ghost = 1 })
Totem(135127, { spellID = 5394, group = "buffs", name = "Healing Stream Totem", scale = 0.8, short = "Healing Stream", color = colors.LGREEN, ghost = 1 })
Totem(538569, { spellID = 108280, group = "buffs", name = "Healing Tide Totem", scale = 0.8, short = "Healing Tide", color = colors.TEAL3, ghost = 1 })
Totem(136080, { spellID = 207399, group = "buffs", name = "Ancestral Protection Totem", short = "Ancestral Totem", color = colors.LRED })
Totem(971079, { spellID = 192222, group = "buffs", name = "Liquid Magma Totem", scale = 0.8, color = colors.WOO })
Totem(135790, { spellID = 188592, group = "buffs", name = "Fire Elemental", duration = 30, scale = 0.6, color = colors.ORANGE2, ghost = 1 })
Totem(1020304,{ spellID = 157299, group = "buffs", name = "Storm Elemental", duration = 30, scale = 0.6, color = colors.WOO2, ghost = 1 })
Totem(136024, { spellID = 198103, group = "buffs", name = "Earth Elemental", duration = 60, scale = 0.6, color = colors.DBROWN, ghost = 1 })
Totem(136098, { spellID = 198838, group = "buffs", name = "Earthen Wall Totem", scale = 0.8, color = colors.PURPLE4 })

end

-- [1398449] = "spells/7fx_nightborne_missile_streak.m2"
-- [1261307] = "spells/7fx_paladin_judgement_missile.m2"
-- [1414253] = "spells/7fx_mage_aegwynnsascendance_statehand.m2"

local effects = {}
effects["NIGHTBORNE"] = {
    path = 1398449,
    scale = 4,
    x = 0, y = 1,
}
effects["JUDGEMENT"] = {
    path = 1261307,
    scale = 2.7,
    x = 0, y = 5,
}
effects["AEGWYNN"] = {
    path = 1414253,
    scale = 3,
    x = -6, y = 0,
}
effects["GOUGE"] = {
    path = 166255, --"spells/Gouge_precast_state_hand.m2",
    scale = 5,
    x = -4, y = 0,
}
effects["FIRESHOT"] = {
    path = 166158, --"spells/fireshot_missile.m2",
    scale = 4,
    x = -3, y = -4,
}
effects["UNHOLY"] = {
    path = 166024, --"spells/enchantments/skullballs.m2",
    scale = 4,
    x = -1, y = 0,
}
effects["SLICENDICE"] = {
    path = 166893, --"spells/slicedice_impact_chest.m2",
    scale = 3,
    x = -8, y = 0,
}
effects["MAGICCAST"] = {
    path = 166524,
    scale = 3,
    x = -12, y = -1,
}
effects["BLOODBOIL"] = {
    path = 165722, --"spells/bloodboil_impact_chest.m2"
    scale = 3.5,
    x = -4, y = -8,
}
-- effects["LIGHTNING"] = {
--     path = 166492, --"spells/lightning_precast_low_hand.m2",
--     scale = 5,
--     x = -1, y = 0,
-- }

NugRunningConfig.effects = effects
