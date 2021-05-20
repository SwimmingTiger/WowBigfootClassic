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
local Talent = helpers.ClassicTalent
local Totem = helpers.Totem
local Glyph = helpers.Glyph
local GetCP = helpers.GetCP
local SPECS = helpers.SPECS
local IsPlayerSpell = IsPlayerSpell
local IsUsableSpell = IsUsableSpell
local _,class = UnitClass("player")
local Interrupt = helpers.Interrupt
local colors = NugRunningConfig.colors

NugRunningConfig.nameplates.parented = true

local tocVersion = select(4,GetBuildInfo())
local isBC = tocVersion >= 20000 and tocVersion < 30000 -- WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
if not isBC then return end

-- RACIALS
Spell( 23234 ,{ name = "Blood Fury", global = true, duration = 15, scale = 0.75, group = "buffs" })
-- EventTimer({ spellID = 23234, event = "SPELL_CAST_SUCCESS", name = "Blood Fury", duration = 15, scale = 0.75, group = "buffs" })
Spell( 26635 ,{ name = "Berserking", global = true, duration = 10 }) -- Berserking
Spell( 20594 ,{ name = "Stoneform", global = true, duration = 8, shine = true, group = "buffs" })
Spell( 20549 ,{ name = "War Stomp", global = true, duration = 2, multiTarget = true, color = colors.DRED })
Spell( 7744 , { name = "Will of the Forsaken", global = true, duration = 5, group = "buffs", color = colors.PURPLE5 })
Spell( 4068 , { name = "Iron Grenade", global = true, maxtimers = 1, color = colors.DBROWN, shine = true, duration = 3 }) -- Iron Grenade
-- Cast({ 746, 1159, 3267, 3268, 7926, 7927, 10838, 10839, 18608, 18610, 23567, 23568, 23569, 23696, 24412, 24413, 24414 },
    -- { name = "First Aid", global = true, tick = 1, tickshine = true, overlay = {"tick", "tickend", 0.4 }, color = colors.LGREEN })



if class == "WARLOCK" then
-- Interrupt(119910, "Spell Lock", 6) -- Felhunter spell from action bar
Interrupt(19244, "Spell Lock", 6) -- Rank 1
Interrupt(19647, "Spell Lock", 8) -- Rank 2
Spell( 24259 ,{ name = "Silence", duration = 3, color = colors.PINK }) -- Spell Lock Silence

local normalize_dots_to = nil--26

Spell( 27243 ,{ name = "Seed of Corruption", duration = 18, nameplates = true,  color = colors.DBLUE, short = "SoC" })
Spell({ 30108, 30404, 30405 } ,{ name = "Unstable Affliction", duration = 18, overlay = {0, 4.8, 0.2}, priority = 10, nameplates = true, ghost = true, color = colors.PINK2 })
Spell({ 1714, 11719 }, { name = "Curse of Tongues", duration = 30, color = colors.CURSE })
Spell({ 702, 1108, 6205, 7646, 11707, 11708, 27224, 30909 },{  name = "Curse of Weakness", duration = 120, color = colors.CURSE })
Spell({ 17862, 17937 }, { name = "Curse of Shadows", duration = 300, glowtime = 15, color = colors.CURSE })
Spell({ 1490, 11721, 11722, 27228 }, { name = "Curse of Elements", duration = 300, glowtime = 15, color = colors.CURSE })
Spell({ 704, 7658, 7659, 11717, 27226 }, { name = "Curse of Recklessness", duration = 120, shine = true, color = colors.CURSE })
Spell({ 603, 30910 },{ name = "Curse of Doom", duration = 60, ghost = true, color = colors.CURSE, nameplates = true, })
Spell( 18223 ,{ name = "Curse of Exhaustion", duration = 12, ghost = true, color = colors.CURSE })

Spell( 17941 ,{ name = "Shadow Trance", duration = 10, shine = true, priority = 15, glowtime = 10, scale = 0.7, shinerefresh = true, color = colors.DPURPLE })


Spell( 6358, { name = "Seduction", duration = 15, pvpduration = 20, color = colors.PURPLE4 }) -- varies, Improved Succubus
Spell({ 5484, 17928 }, { name = "Howl of Terror", shine = true, multiTarget = true,
    duration = function(timer)
        return timer.spellID == 5484 and 10 or 15
    end
})
Spell({ 5782, 6213, 6215 }, { name = "Fear",
    pvpduration = 20,
    duration = function(timer)
        if timer.spellID == 5782 then return 10
        elseif timer.spellID == 6213 then return 15
        else return 20 end
    end
})
Spell({ 710, 18647 }, { name = "Banish", nameplates = true, color = colors.TEAL3,
    pvpduration = 20,
    duration = function(timer)
        return timer.spellID == 710 and 20 or 30
    end
})
Spell({ 6789, 17925, 17926, 27223 }, { name = "Death Coil", duration = 3, color = colors.DTEAL })


Spell({ 18265, 18879, 18880, 18881, 27264, 30911 }, { name = "Siphon Life", duration = 30, priority = 5, fixedlen = normalize_dots_to, nameplates = true, ghost = true, color = colors.DTEAL })
Spell({ 980, 1014, 6217, 11711, 11712, 11713, 27218 }, { name = "Curse of Agony", duration = 24, fixedlen = normalize_dots_to, nameplates = true, ghost = true, priority = 6, color = colors.CURSE })
Spell({ 172, 6222, 6223, 7648, 11671, 11672, 25311, 27216 }, { name = "Corruption", tick = 3, overlay = {"tick", "end", 0.35}, priority = 9, fixedlen = normalize_dots_to, nameplates = true, ghost = true, color = colors.PINKIERED,
    duration = function(timer, opts)
        if timer.spellID == 172 then
            return 12
        elseif timer.spellID == 6222 then
            return 15
        else
            return 18
        end
    end }) -- Corruption
Spell({ 348, 707, 1094, 2941, 11665, 11667, 11668, 25309, 27215 },{ name = "Immolate", recast_mark = 1.5, overlay = {0, 1.5, 0.3}, duration = 15, nameplates = true, priority = 10, ghost = true, color = colors.RED })

Spell( 29341, { name = "Shadowburn", duration = 5, scale = 0.5, color = colors.DPURPLE }) -- Soul Shard debuff

Cooldown( 17962, { name = "Conflagrate", ghost = true, priority = 5, color = colors.PINK })


Spell({ 6229, 11739, 11740, 28610 } ,{ name = "Shadow Ward", duration = 30, group = "buffs", scale = 0.7, color=colors.DPURPLE})
Spell({ 7812, 19438, 19440, 19441, 19442, 19443, 27273 }, { name = "Sacrifice", duration = 30, group = "buffs", shine = true, color=colors.GOLD })
Spell({ 17767, 17850, 17851, 17852, 17853, 17854, 27272 }, { name = "Consume Shadows", duration = 10, color = colors.LRED, target = "pet" })

end



if class == "SHAMAN" then
Interrupt({ 8042, 8044, 8045, 8046, 10412, 10413, 10414, 25454 }, "Earth Shock", 2)

Spell({ 974, 32593, 32594 } ,{ name = "Earth Shield", duration = 60, timeless = true, charged = true, maxcharge = 6, color = colors.LGREEN })
Spell( 30823 ,{ name = "Shamanistic Rage", group = "buffs", duration = 15, shine = true, color = colors.PURPLE3 })
-- Spell( 3600 ,{ name = "Earthbind", maxtimers = 1, duration = 5, timeless = true, color = colors.BROWN, scale = 0.7 })
Spell({ 16257, 16277, 16278, 16279, 16280 }, { name = "Flurry", duration = 15, scale = 0.8, group = "buffs", shine = true, shinerefresh = true, color = colors.DPURPLE })
Spell({ 8056, 8058, 10472, 10473, 25464 }, { name = "Frost Shock", duration = 8, color = colors.LBLUE })
Spell({ 8050, 8052, 8053, 10447, 10448, 25457, 29228 }, { name = "Flame Shock", duration = 12, color = colors.RED, ghost = true })
Cooldown( 8042 ,{ name = "Shock", color = colors.TEAL3, ghost = 2, priority = 1, ghosteffect = "MAGICCAST", scale = 0.9 })
Cooldown( 17364 ,{ name = "Stormstrike", color = colors.CURSE, priority = 10, scale_until = 5, ghost = true  })
Spell( 29063 ,{ name = "Focused Casting", shine = true, duration = 6, color = colors.PURPLE4, group = "buffs" })
Spell( 16246 ,{ name = "Clearcasting", shine = true, duration = 15, color = colors.CHIM, group = "buffs" })
Spell( 16166 ,{ name = "Elemental Mastery", shine = true, duration = 15, priority = 12, timeless = true, color = colors.DPURPLE })
Spell( 16188 ,{ name = "Nature's Swiftness", shine = true, duration = 15, group = "buffs", priority = -12, timeless = true, color = colors.WOO2DARK })
--[[
Spell( 29203 ,{ name = "Healing Way", maxtimers = 2, duration = 15, scale = 0.7, color = colors.LGREEN })

EventTimer({ event = "SPELL_CAST_SUCCESS", spellID = 25357, name = "HealingWayRefresh",
    action = function(active, srcGUID, dstGUID, spellID, damage )
        local timer = NugRunning.gettimer(active, GetSpellInfo(29203), dstGUID, "BUFF")
        if timer then
            local now = GetTime()
            timer:SetTime(now, now + 15, timer.fixedoffset)
        end
    end
})
]]

-- TOTEMS
local PRIO_FIRE = -77
local PRIO_EARTH = -78
local PRIO_WATER = -79
local PRIO_AIR = -80
Totem(136102, { name = "Earthbind Totem", spellID = 2484, group = "buffs", ghost = 1, color = colors.DBROWN, shine = true, tick = 3, overlay = {"tick", "tickend"}, priority = PRIO_EARTH })
Totem(136097, { name = "Stoneclaw Totem", spellID = 5730, group = "buffs", color = colors.WOO2, shine = true, priority = PRIO_EARTH })
Totem(136098, { name = "Stoneskin Totem", spellID = 8071, group = "buffs", color = colors.WOO, ghost = 1, scale = 0.7, priority = PRIO_EARTH })
Totem(136023, { name = "Strength of the Earth Totem", short = "Strength", spellID = 8075, group = "buffs", color = colors.DTEAL, scale = 0.7, ghost = 1, priority = PRIO_EARTH })
Totem(136108, { name = "Tremor Totem", spellID = 8143, group = "buffs", color = colors.PINK, ghost = 1, priority = PRIO_EARTH })
Totem(136024, { name = "Earth Elemental", spellID = 2062, group = "buffs", color = colors.DBROWN, priority = PRIO_EARTH })

Totem(135824, { name = "Fire Nova Totem", spellID = 1535, group = "buffs", color = colors.LRED, shine = true, priority = PRIO_FIRE })
Totem(135826, { name = "Magma Totem", spellID = 8190, group = "buffs", color = colors.DRED, tick = 2, overlay = {"tick", "end", 0.3}, priority = PRIO_FIRE })
Totem(135825, { name = "Searing Totem", spellID = 3599, group = "buffs", color = colors.RED, priority = PRIO_FIRE, ghost = 1 })
Totem(136040, { name = "Flametongue Totem", spellID = 8227, group = "buffs", color = colors.PURPLE4, priority = PRIO_FIRE, scale = 0.7, ghost = 1 })
Totem(135866, { name = "Frost Resistance Totem", short = "Frost Res", spellID = 8181, group = "buffs", color = colors.LRED, ghost = 1, scale_until = 15, priority = PRIO_FIRE })
Totem(135790, { name = "Fire Elemental", spellID = 2894, group = "buffs", color = colors.LRED, priority = PRIO_FIRE })
Totem(135829, { name = "Totem of Wrath", spellID = 30706, group = "buffs", color = colors.PINKIERED, priority = PRIO_FIRE })

Totem(135832, { name = "Fire Resistance Totem", short = "Fire Res", spellID = 8184, group = "buffs", color = colors.FROZEN, ghost = 1, scale_until = 15, priority = PRIO_WATER })
Totem(135127, { name = "Healing Stream Totem", short = "Healing Stream", spellID = 5394, group = "buffs", color = colors.LGREEN, ghost = 3, scale = 0.7, priority = PRIO_WATER })
Totem(136053, { name = "Mana Spring Totem", short = "Mana Spring", spellID = 5675, group = "buffs", color = colors.PURPLE, ghost = 3, scale = 0.7, priority = PRIO_WATER })
Totem(136070, { name = "Poison Cleansing Totem", short = "Poison Cleanse", spellID = 8166, group = "buffs", color = colors.GREEN, ghost = 1, scale = 0.7, priority = PRIO_WATER })
Totem(136019, { name = "Disease Cleansing Totem", short = "Disease Cleanse", spellID = 8166, group = "buffs", color = colors.BROWN, ghost = 1, scale = 0.7, priority = PRIO_WATER })
Totem(135861, { name = "Mana Tide Totem", short = "Mana Tide", spellID = 16190, group = "buffs", effect = "UNHOLY", color = colors.TEAL2, ghost = 1, priority = PRIO_WATER })

Totem(136039, { name = "Grounding Totem", spellID = 8177, group = "buffs", color = colors.CURSE, shine = true, tick = 10, overlay = {"tick", "end", 0.35}, priority = PRIO_AIR, ghost = 1, ghosteffect = "SLICENDICE" })
Totem(136114, { name = "Windfury Totem", spellID = 8512, group = "buffs", color = colors.PINK3, shine = true, scale = 0.7, ghosteffect = "FIRESHOT", priority = PRIO_AIR, ghost = 3 })
Totem(136046, { name = "Grace of Air Totem", short = "Agility", spellID = 8835, group = "buffs", color = colors.PURPLE5, ghost = 1, scale = 0.7, priority = PRIO_AIR })
Totem(136061, { name = "Nature Resistance Totem", short = "Nature Res", spellID = 10595, group = "buffs", color = colors.TEAL3, ghost = 1, scale_until = 15, priority = PRIO_AIR })
Totem(136022, { name = "Windwall Totem", spellID = 15107, group = "buffs", color = colors.BLACK, scale = 0.7, priority = PRIO_AIR, ghost = 1 })
Totem(136013, { name = "Tranquil Air Totem", short = "Tranquil Air", spellID = 25908, group = "buffs", color = colors.LBLUE, scale_until = 15, priority = PRIO_AIR, ghost = 1 })
-- Totem(136082, { name = "Sentry Totem", spellID = 6495, group = "buffs", color = colors.CURSE, ghost = 1, priority = PRIO_AIR })
Totem(136092, { name = "Wrath of Air Totem", short = "Wrath of Air", spellID = 3738, group = "buffs", color = colors.PINK3, shine = true, scale = 0.7, ghosteffect = "FIRESHOT", priority = PRIO_AIR, ghost = 3 })
end

if class == "PALADIN" then

Spell( 20066 ,{ name = "Repentance", duration = 6 })
Spell({ 2878, 5627, 10326 }, { name = "Turn Undead",
    duration = function(timer)
        if timer.spellID == 2878 then return 10
        elseif timer.spellID == 5627 then return 15
        else return 20 end
    end
})
Cooldown( 879 ,{ name = "Exorcism", color = colors.ORANGE, ghost = true, priority = 8, })
Cooldown( 24275 ,{ name = "Hammer of Wrath", color = colors.TEAL2, ghost = true, priority = 11 })

Spell( 1044 ,{ name = "Blessing of Freedom", duration = 10, group = "buffs" })
Spell({ 6940, 20729, 27147, 27148 }, { name = "Blessing of Sacrifice", duration = 10, group = "buffs", color = colors.LRED })
Spell({ 1022, 5599, 10278 }, { name = "Blessing of Protection", group = "buffs", color = colors.WOO2,
    duration = function(timer)
        if timer.spellID == 1022 then return 6
        elseif timer.spellID == 5599 then return 8
        else return 10 end
    end
})
-- DS includes Divine Protection
Spell( 31884 ,{ name = "Avenging Wrath",duration = 20, group = "buffs", color = colors.LRED, effect = "JUDGEMENT" })
Spell({ 498, 5573, 642, 1020 }, { name = "Divine Shield", duration = 12, group = "buffs", color = colors.BLACK }) --varies BUFF
Spell({ 31892, 348700 }, { name = "Seal of Blood", scale_until = 8, priority = 6, duration = 30, ghost = 1, color = colors.LRED })
Spell({ 31801, 348704 }, { name = "Seal of Vengeance", scale_until = 8, priority = 6, duration = 30, ghost = 1, color = colors.GOLD })
Spell(31834, { name = "Light's Grace", scale = 0.75, duration = 15, color = colors.DPURPLE })
Cooldown( 31935 ,{ name = "Avenger's Shield", resetable = true, priority = 5, scale = 1, color = colors.TEAL, ghost = true })
Cooldown( 35395 ,{ name = "Crusader Strike", tick = 1.5, tickshine = true, overlay = {"tick", "end"}, ghost = true, short = "", priority = 10, color = colors.CURSE })

Spell({ 20375, 20915, 20918, 20919, 20920, 27170 }, { name = "Seal of Command", scale_until = 8, priority = 6, duration = 30, ghost = 1, color = colors.RED })
Spell({ 20154, 20287, 20288, 20289, 20290, 20291, 20292, 20293, 21084, 27155 }, { name = "Seal of Righteousness", scale_until = 8, priority = 6, duration = 30, ghost = 1, color = colors.DTEAL })
Spell({ 20162, 20305, 20306, 20307, 20308, 21082, 27158 }, { name = "Seal of the Crusader", scale_until = 8, priority = 6, duration = 30, ghost = 1, color = colors.GOLD })
Spell({ 20165, 20347, 20348, 20349, 27160 }, { name = "Seal of Light", scale_until = 8, priority = 6, duration = 30, ghost = 1, color = colors.LGREEN })
Spell({ 20166, 20356, 20357, 27166 }, { name = "Seal of Wisdom", scale_until = 8, priority = 6, duration = 30, ghost = 1, color = colors.LBLUE })
Spell({ 20164, 31895 } , { name = "Seal of Justice", scale_until = 8, priority = 6, duration = 30, ghost = 1, color = colors.BLACK })

Spell({ 21183, 20188, 20300, 20301, 20302, 20303, 27159 }, { name = "Judgement of the Crusader", short = "Crusader", duration = 10, color = colors.GOLD })
Spell({ 20185, 20344, 20345, 20346, 27162 }, { name = "Judgement of Light", short = "Light", duration = 10, color = colors.LGREEN })
Spell({ 20186, 20354, 20355, 27164 }, { name = "Judgement of Wisdom", short = "Wisdom", duration = 10, color = colors.LBLUE })
Spell({ 20184, 31896 } , { name = "Judgement of Justice", short = "Justice", duration = 10, color = colors.BLACK })

Spell({ 853, 5588, 5589, 10308 }, { name = "Hammer of Justice", short = "Hammer", color = colors.FROZEN,
    duration = function(timer)
        if timer.spellID == 853 then return 3
        elseif timer.spellID == 5588 then return 4
        elseif timer.spellID == 5589 then return 5
        else return 6 end
    end
}) -- varies

Spell( 20216 ,{ name = "Divine Favor", shine = true, duration = 15, priority = 12, timeless = true, scale = 0.7, color = colors.DPURPLE })
Cooldown( 26573 ,{ name = "Consecration", color = colors.PINKIERED, priority = 9, scale = 0.85, ghost = true })
Cooldown( 20473 ,{ name = "Holy Shock", ghost = 1, priority = 5, scale_until = 5, color = colors.WOO })
Cooldown( 20271 ,{ name = "Judgement", ghost = true, priority = 8, color = colors.PURPLE })

Spell({ 20925, 20927, 20928, 27179 }, { name = "Holy Shield", duration = 10, priority = 7, scale = 1, ghost = true, arrow = colors.PINK2, color = colors.PINK3 })

end

if class == "HUNTER" then

-- EventTimer({ event = "SPELL_CAST_SUCCESS", spellID = 1543, name = "Flare", scale = 0.5, color = colors.GOLD, duration = 30 })
Spell( 19263 ,{ name = "Deterrence", duration = 10, color = colors.LBLUE, shine = true, group = "buffs" })
Spell( 3045 ,{ name = "Rapid Fire", duration = 15, color = colors.PINK2, group = "buffs" })
Spell( 19574 ,{ name = "Bestial Wrath", duration = 18, target = "pet", group = "buffs", shine = true, color = colors.LRED })

Spell({ 1513, 14326, 14327 }, { name = "Scare Beast",
    pvpduration = 20,
    duration = function(timer)
        if timer.spellID == 1513 then return 10
        elseif timer.spellID == 14326 then return 15
        else return 20 end
    end
})
Cooldown( 34026 , { name = "Kill Command ", color = colors.CURSE, ghost = true, tick = 1.5, fixedlen = 9, priority = 10, resetable = true })
Spell({ 136, 3111, 3661, 3662, 13542, 13543, 13544, 27046 }, { name = "Mend Pet", duration = 15, color = colors.LGREEN })
Spell( 34490, { name = "Silencing Shot", duration = 3, color = colors.PINK })


Spell({ 1130, 14323, 14324, 14325 }, { name = "Hunter's Mark", duration = 120, ghost = 3, color = colors.PURPLE4 })

Spell({ 1978, 13549, 13550, 13551, 13552, 13553, 13554, 13555, 25295, 27016 }, { name = "Serpent Sting", duration = 15, color = colors.PURPLE, ghost = true, })
Spell({ 3043, 14275, 14276, 14277 }, { name = "Scorpid Sting", duration = 20, color = colors.TEAL })
Spell({ 3034, 14279, 14280, 27018 }, { name = "Viper Sting", duration = 8, color = colors.DBLUE })
Spell({ 19386, 24132, 24133, 27068 }, { name = "Wyvern Sting", short = "Sleep", duration = 12, color = colors.PURPLE3, ghost = 1 })
Spell({ 24131, 24134, 24135, 27069 }, { name = "Wyvern Sting", duration = 12, color = colors.GREEN }) -- Wyvern Sting Dot


Spell(19229, { name = "Wing Clip", shine = true, duration = 5, scale = 0.6, color = colors.DBROWN })
Spell({ 19306, 20909, 20910 }, { name = "Counterattack", shine = true, duration = 5, scale = 0.6, color = colors.DBROWN })

Cooldown( 19306 ,{ name = "Counterattack", ghost = 1, priority = 5, color = colors.PURPLE4 })
Activation( 19306, { for_cd = true, effect = "FIRESHOT", ghost = 5 })

Spell({ 13812, 14314, 14315, 27026 }, { name = "Explosive Trap", duration = 20, multiTarget = true, color = colors.RED, ghost = 1 })
Spell({ 13797, 14298, 14299, 14300, 14301, 27024 }, { name = "Immolation Trap", duration = 15, color = colors.RED, ghost = 1 })
Spell({ 3355, 14308, 14309 }, { name = "Freezing Trap", color = colors.FROZEN,
    pvpduration = 20,
    duration = function(timer)
        local mul = 1 + 0.15*Talent(19239, 19245) -- Clever Traps
        if timer.spellID == 3355 then return 10*mul
        elseif timer.spellID == 14308 then return 15*mul
        else return 20*mul end
    end
})

Spell( 19503 , { name = "Scatter Shot", duration = 4, color = colors.PINK3, shine = true })

Cooldown( 1495 ,{ name = "Mongoose Bite", ghost = true, priority = 4, color = colors.WOO })
Cooldown( 2973 ,{ name = "Raptor Strike", ghost = 1, priority = 3, color = colors.LBLUE })

-- Cooldown( 19434 ,{ name = "Aimed Shot", ghost = true, priority = 10, color = colors.TEAL3 })
Cooldown( 2643 ,{ name = "Multi-Shot", ghost = true, priority = 5, color = colors.PINKIERED })
Cooldown( 3044 ,{ name = "Shot", ghost = true, priority = 7, color = colors.TEAL3 })
Spell({ 2974, 14267, 14268 }, { name = "Wing Clip", duration = 10, color = colors.BROWN })
Spell( 5116 ,{ name = "Concussive Shot", duration = 4, color = colors.BROWN })
Spell( 19410 ,{ name = "Conc Stun", duration = 3, shine = true, color = colors.RED })
Spell( 24394 ,{ name = "Intimidation", duration = 3, shine = true, color = colors.RED })

end

if class == "DRUID" then
Interrupt(16979, "Feral Charge", 4)

-- TODO: Force of Nature

Spell( 22812 ,{ name = "Barkskin", duration = 12, color = colors.WOO2, group = "buffs" })
Spell({ 339, 1062, 5195, 5196, 9852, 9853, 26989 }, { name = "Entangling Roots", color = colors.DBROWN,
    pvpduration = 20,
    duration = function(timer)
        if timer.spellID == 339 then return 12
        elseif timer.spellID == 1062 then return 15
        elseif timer.spellID == 5195 then return 18
        elseif timer.spellID == 5196 then return 21
        elseif timer.spellID == 9852 then return 24
        else return 27 end
    end
}) -- varies
Spell( 33786 ,{ name = "Cyclone", shine = true, color = colors.BLACK, overlay = {0, "gcd"}, duration = 6 })
Spell({ 2908, 8955, 9901, 26995 }, { name = "Soothe Animal", duration = 15, color = colors.PURPLE5 })
Spell({ 770, 778, 9749, 9907, 26993 }, { name = "Faerie Fire", duration = 40, color = colors.PURPLE5 })
Spell({ 16857, 17390, 17391, 17392, 27011 }, { name = "Faerie Fire Feral", duration = 40, color = colors.PURPLE5 })
Spell({ 2637, 18657, 18658 }, { name = "Hibernate", color = colors.PURPLE4, nameplates = true,
    pvpduration = 20,
    duration = function(timer)
        if timer.spellID == 2637 then return 20
        elseif timer.spellID == 18657 then return 30
        else return 40 end
    end
}) -- varies
Spell({ 99, 1735, 9490, 9747, 9898, 26998 }, { name = "Demoralizing Roar", duration = 30, color = colors.DTEAL, multiTarget = true, shinerefresh = true })
Spell({ 5211, 6798, 8983 }, { name = "Bash", color = colors.RED,
    duration = function(timer)
        local brutal_impact = Talent(16940, 16941)*0.5
        if timer.spellID == 5211 then return 2+brutal_impact
        elseif timer.spellID == 6798 then return 3+brutal_impact
        else return 4+brutal_impact end
    end
}) -- varies
Spell( 33745, { name = "Lacerate", duration = 15, color = colors.RED, priority = 2, ghost = true })
Spell( 5209 , { name = "Challenging Roar", duration = 6, multiTarget = true })
Spell( 6795 ,{ name = "Taunt", duration = 3 })
-- SKIPPING: Nature's Grasp
Spell({ 1850, 9821, 33357 }, { name = "Dash", duration = 15 })
Spell( 5229, { name = "Enrage", color = colors.PURPLE4, shine = true, scale = 0.6, group = "buffs", duration = 10 })
Spell({ 22842, 22895, 22896, 26999 }, { name = "Frenzied Regeneration", duration = 10, color = colors.LGREEN })
Spell(22570, { name = "Maim", shine = true, color = colors.LRED,
    duration = function(timer)
        return 1 + GetCP()
    end,
}) -- varies
Spell( 19675, { name = "Feral Charge", duration = 4, color = colors.DBROWN, shine = true })
--          bear                        cat
Spell({ 33878, 33986, 33987,    33876, 33982, 33983 }, { name = "Mangle", duration = 12, color = colors.DRED, shinerefresh = true, shine = true, group = "buffs", priority = -10,  })



Spell( 16922, { name = "Starfire Stun", duration = 3, shine = true, color = colors.RED })
Spell({ 9005, 9823, 9827, 27006 }, { name = "Pounce", _skipunitaura = true, priority = -20, color = colors.RED,
    duration = function(timer)
        local brutal_impact = Talent(16940, 16941)*0.5
        return 2+brutal_impact
    end
})
Spell({ 9007, 9824, 9826 }, { name = "Pounce Bleed", duration = 18, priority = 4, color = colors.PINK3 })
Spell({ 8921, 8924, 8925, 8926, 8927, 8928, 8929, 9833, 9834, 9835, 26987, 26988 }, { name = "Moonfire", priority = 5, ghost = true, color = colors.PURPLE, nameplates = true,
duration = function(timer)
    if timer.spellID == 8921 then return 9
    else return 12 end
end
})
Spell({ 1822, 1823, 1824, 9904 }, { name = "Rake", tick = 3, overlay = {"tick", "end"}, duration = 9, priority = 6, nameplates = true, ghost = true, color = colors.PINKIERED })
Spell({ 1079, 9492, 9493, 9752, 9894, 9896, 27008 }, { name = "Rip", tick = 2, overlay = {"tick", "end"}, duration = 12, priority = 5, ghost = true, nameplates = true, color = colors.RED })
Spell({ 5217, 6793, 9845, 9846 }, { name = "Tiger's Fury", duration = 6, color = colors.GOLD, scale = 0.7, group = "buffs", shine = true })

Spell( 2893 ,{ name = "Abolish Poison", tick = 2, tickshine = true, overlay = {"tick", "end"}, group = "buffs", duration = 8, color = colors.TEAL2 })
Spell( 29166 , { name = "Innervate", duration = 20, shine = true, color = colors.DBLUE })

Spell({ 8936, 8938, 8939, 8940, 8941, 9750, 9856, 9857, 9858, 26980 }, { name = "Regrowth", duration = 21, scale = 0.7, color = colors.LGREEN })
Spell({ 774, 1058, 1430, 2090, 2091, 3627, 8910, 9839, 9840, 9841, 25299, 26981, 26982 }, { name = "Rejuvenation", scale = 1, duration = 12, color = colors.REJUV })
Spell( 16870 ,{ name = "Clearcasting", shine = true, group = "buffs", duration = 15, color = colors.CHIM })

Spell({ 5570, 24974, 24975, 24976, 24977, 27013 }, { name = "Insect Swarm", duration = 12, priority = 6, color = colors.TEAL3, ghost = true, nameplates = true, })
Spell( 17116 ,{ name = "Nature's Swiftness", shine = true, duration = 15, group = "buffs", priority = -12, timeless = true, scale = 0.7, color = colors.WOO2DARK })
Spell( 33763 ,{ name = "Lifebloom", shinerefresh = true, duration = 7, color = { 0.5, 1, 0.5} })


end

if class == "MAGE" then
Interrupt(2139, "Counterspell", 8)

Spell( 18469 ,{ name = "Silence", duration = 4, color = colors.CHIM }) -- Improved Counterspell
Spell({ 118, 12824, 12825, 28271, 28272, 12826 },{ name = "Polymorph", glowtime = 5, ghost = 1, ghosteffect = "SLICENDICE", color = colors.LGREEN,
    pvpduration = 20,
    duration = function(timer)
        if timer.spellID == 118 then return 20
        elseif timer.spellID == 12824 then return 30
        elseif timer.spellID == 12825 then return 40
        else return 50 end
    end
}) -- varies

Spell( 36032 ,{ name = "Arcane Blast", color = colors.REJUV, charged = true, maxcharge = 3, priority = 10.1, scale = 0.7, duration = 8, timeless = true })

Spell( 66, { name = "Invisibility Fade", duration = 5, color = colors.LBLUE })
Spell( 32612, { name = "Invisibility", duration = 20 })

Spell( 11958 ,{ name = "Ice Block", duration = 10, color = colors.CHIM, group = "buffs", shine = true })
Spell({ 1463, 8494, 8495, 10191, 10192, 10193, 27131 }, { name = "Mana Shield", duration = 60, ghost = true, group = "buffs", color = colors.TEAL })
Spell({ 11426, 13031, 13032, 13033, 27134, 33405 }, { name = "Ice Barrier", duration = 60, ghost = true, group = "buffs", color = colors.TEAL3 })
Spell({ 543, 8457, 8458, 10223, 10225, 27128 }, { name = "Fire Ward", duration = 30, group = "buffs", scale = 0.7, color = colors.ORANGE })
Spell({ 6143, 8461, 8462, 10177, 28609, 32796 }, { name = "Frost Ward", duration = 30, group = "buffs", scale = 0.7, color = colors.LBLUE })
Spell( 28682 ,{ name = "Combustion", color = colors.DPURPLE, timeless = true, group = "buffs", priority = -20, duration = 10 })

Cooldown( 2136, { name = "Fire Blast", color = colors.LRED, ghost = true })

Spell( 12355 ,{ name = "Impact", duration = 2, shine = true, color = colors.PURPLE3 }) -- fire talent stun proc
Spell( 12654 ,{ name = "Ignite", duration = 4, shine = true, shinerefresh = true, ghost = true, ghosteffect = "FIRESHOT", color = colors.PINK3 })
EventTimer({ spellID = 12654, event = "SPELL_PERIODIC_DAMAGE",
    action = function(active, srcGUID, dstGUID, spellID, damage )
        local ignite_timer = NugRunning.gettimer(active, spellID, dstGUID, "DEBUFF")
        if ignite_timer then
            ignite_timer:SetName(damage)
        end
    end})
Spell( 22959 ,{ name = "Fire Vulnerability", duration = 30, scale = 0.5, priority = -10, glowtime = 4, ghost = true, ghosteffect = "GOUGE", color = colors.BROWN })

Spell({ 2120, 2121, 8422, 8423, 10215, 10216, 27086 }, { name = "Flamestrike", duration = 8, color = colors.PURPLE, multiTarget = true })

-- EventTimer({ spellID = 153561, event = "SPELL_CAST_SUCCESS", name = "Meteor", duration = 2.9, color = colors.FIRE })

Spell({ 11113, 13018, 13019, 13020, 13021 }, { name = "Blast Wave", duration = 6, scale = 1,  color = colors.DBROWN, multiTarget = true })
Spell({ 120, 8492, 10159, 10160, 10161, 27087 }, { name = "Cone of Cold", scale = 0.6,  color = colors.CHILL, multiTarget = true,
    duration = function(timer)
        local permafrost = Talent(11175, 12569, 12571)
        return 8 + permafrost
    end
})

-- Frost Armor
Spell( 6136 , { name = "Chilled", scale = 0.6,  color = colors.CHILL, multiTarget = true,
    duration = function(timer)
        local permafrost = Talent(11175, 12569, 12571)
        return 5 + permafrost
    end
})


Spell({ 116, 205, 837, 7322, 8406, 8407, 8408, 10179, 10180, 10181, 25304 }, { name = "Frostbolt", scale = 0.6, color = colors.CHILL,
    duration = function(timer)
        local permafrost = Talent(11175, 12569, 12571)
        if timer.spellID == 116 then return 5 + permafrost
        elseif timer.spellID == 205 then return 6 + permafrost
        elseif timer.spellID == 837 then return 6 + permafrost
        elseif timer.spellID == 7322 then return 7 + permafrost
        elseif timer.spellID == 8406 then return 7 + permafrost
        elseif timer.spellID == 8407 then return 8 + permafrost
        elseif timer.spellID == 8408 then return 8 + permafrost
        else return 9 + permafrost end
    end
}) -- varies


Spell( 12494 ,{ name = "Frostbite", duration = 5, color = colors.FROZEN, shine = true })
Spell({ 122, 865, 6131, 10230, 27088 } ,{ name = "Frost Nova", duration = 8, color = colors.FROZEN, multiTarget = true })

Spell( 12536 ,{ name = "Clearcasting", shine = true, group = "buffs", duration = 15, color = colors.CHIM })
Spell( 12043 ,{ name = "Presence of Mind", shine = true, duration = 15, group = "buffs", priority = -12, timeless = true, scale = 0.7, color = colors.WOO2DARK })
Spell( 12042 ,{ name = "Arcane Power", duration = 15, group = "buffs", color = colors.PINK })

Spell( 31589 ,{ name = "Slow", duration = 15 })
Spell({ 31661, 33041, 33042, 33043 } ,{ name = "Dragon's Breath", duration = 3, color = colors.ORANGE, short = "Breath", maxtimers = 1 })
Spell( 12472 ,{ name = "Icy Veins", group = "buffs", duration = 20, color = colors.PINK3 })
Spell( 33395 ,{ name = "Freeze", duration = 8, maxtimers = 1, color = colors.FROZEN }) -- Water Elemental's Ability

end

if class == "PRIEST" then

Spell( 15487 ,{ name = "Silence", duration = 5, color = colors.PINK })

Spell({ 14743, 27828 } ,{ name = "Focused Casting", shine = true, duration = 6, effect = "FIRESHOT", color = colors.PURPLE4, group = "buffs" })
Cast({ 15407, 17311, 17312, 17313, 17314, 18807, 25387 }, { name = "Mind Flay", short = "", priority = 13, tick = 1, overlay = {"tick", "tickend"}, color = colors.PURPLE2, priority = 11, duration = 3, scale = 0.8 })
Spell({ 10797, 19296, 19299, 19302, 19303, 19304, 19305, 25446 }, { name = "Starshards", duration = 6, priority = 9, color = colors.CHIM })
Spell({ 2944, 19276, 19277, 19278, 19279, 19280, 25467 }, { name = "Devouring Plague", duration = 24, priority = 9, color = colors.PURPLE4 })

Spell({ 453, 8192, 10953, 25596 }, { name = "Mind Soothe", duration = 15, color = colors.PURPLE5 })

Spell({ 9484, 9485, 10955 }, { name = "Shackle Undead", glowtime = 5, nameplates = true, color = colors.PURPLE3, ghost = 1, ghosteffect = "SLICENDICE",
    duration = function(timer)
        if timer.spellID == 9484 then return 30
        elseif timer.spellID == 9485 then return 40
        else return 50 end
    end
}) -- varies
Spell( 10060, { name = "Power Infusion", duration = 15, group = "buffs", color = colors.TEAL2 })
Spell( 41635 ,{ name = "Prayer of Mending", shinerefresh = true, duration = 30, color = colors.TEAL3, scale = 1, textfunc = function(timer) return timer.dstName end })
Spell( 33206 ,{ name = "Pain Suppression", shine = true, duration = 8, color = colors.PINK })
Spell( 34754 ,{ name = "Clearcasting", shine = true, duration = 15, color = colors.PINK, group = "buffs" })

Spell({ 34914, 34916, 34917 },{ name = "Vampiric Touch", short = "", preghost = true, ghost = true, overlay = { 0, "gcd", 0.25 }, nameplates = true, priority = 10, duration = 15, color = colors.RED, })
-- make charged to 20?
Spell({ 588, 602, 1006, 7128, 10951, 10952 }, { name = "Inner Fire", duration = 600, ghost = true, charged = true, maxcharge = 20, priority = -100, color = colors.GOLD, scale = 0.7 })
Spell({ 17, 592, 600, 3747, 6065, 6066, 10898, 10899, 10900, 10901, 25217, 25218 }, { name = "Power Word: Shield", short = "Shield", shinerefresh = true, duration = 30, color = colors.LRED })
Spell( 552 , { name = "Abolish Disease", tick = 5, tickshine = true, overlay = {"tick", "end"}, duration = 20, scale = 0.5, color = colors.BROWN })

Spell({ 14914, 15261, 15262, 15263, 15264, 15265, 15266, 15267, 25384 }, { name = "Holy Fire", color = colors.PINK, duration = 10, ghost = true })
Spell({ 139, 6074, 6075, 6076, 6077, 6078, 10927, 10928, 10929, 25221, 25222, 25315 }, { name = "Renew", shinerefresh = true, color = colors.LGREEN, duration = 15,  scale = 0.8  })
Spell({ 586, 9578, 9579, 9592, 10941, 10942, 25429 }, { name = "Fade", duration = 10, scale = 0.6, shine = true, color = colors.CHILL })
Cooldown( 8092, { name = "Mind Blast", priority = 9, color = colors.CURSE, ghosteffect = "MAGICCAST", ghost = true })

Spell({ 8122, 8124, 10888, 10890 }, { name = "Psychic Scream", duration = 8, shine = true, multiTarget = true })
Spell({ 589, 594, 970, 992, 2767, 10892, 10893, 10894, 25367, 25368 }, { name = "Shadow Word: Pain", short = "Pain", ghost = true, nameplates = true, priority = 8, color = colors.PURPLE,
    duration = function(timer, opts)
        local duration = 18
        -- Improved SWP, 2 ranks: Increases the duration of your Shadow Word: Pain spell by 3 sec.
        return duration + 3*Talent(15275, 15317)
    end
 }) -- varies by talents

Spell( 15269 ,{ name = "Blackout", duration = 3, shine = true, color = colors.PURPLE3 })
-- Cast( 15407, { name = "Mind Flay", short = "", priority = 12, tick = 1, overlay = {"tick", "tickend"}, color = colors.PURPLE2, priority = 11, duration = 3, scale = 0.8 })
-- Spell( 15258 ,{ name = "Shadow Vulnerability", short = "Vulnerability", duration = 15, scale = 0.5, priority = -10, glowtime = 4, ghost = true, ghosteffect = "GOUGE", color = colors.DPURPLE })
Spell( 15286 ,{ name = "Vampiric Embrace", duration = 60, priority = 5, shinerefresh = true, ghost = true, ghosteffect = "GOUGE", color = colors.PURPLE4 })
Spell( 14751 ,{ name = "Inner Focus", shine = true, duration = 15, group = "buffs", priority = -12, timeless = true, scale = 0.7, color = colors.WOO2DARK })

Spell( 15258 ,{ name = "Shadow Weaving", color = colors.PURPLE3, scale = 0.75, priority = -10, ghost = 2, maxtimers = 1, duration = 15 })

EventTimer({ event = "SPELL_CAST_SUCCESS", spellID = 34433, name = "Shadowfiend", group = "buffs", duration = 12, priority = -10, color = colors.BLACK })

end

if class == "ROGUE" then
Interrupt({ 1766, 1767, 1768, 1769, 38768 }, "Kick", 5)

Spell( 18425 ,{ name = "Silence", duration = 2, color = colors.PINK }) -- Improved Kick

-- Premedi doesn't work because UnitAura scan kills it
-- Spell( 14183 ,{ name = "Premeditation", duration = 10, group = "buffs", color = colors.CURSE })

Spell( 31224 ,{ name = "Cloak of Shadows", group = "buffs", color = colors.CURSE, duration = 5 })
Spell( 26679 ,{ name = "Deadly Throw", color = colors.DBLUE, duration = 6 })

Spell( 13750 ,{ name = "Adrenaline Rush", group = "buffs", priority = -5, duration = 15, color = colors.LRED })
Spell( 13877 ,{ name = "Blade Flurry", group = "buffs", priority = -4, duration = 15, color = colors.PURPLE5 })

Spell( 1833 , { name = "Cheap Shot", duration = 4, color = colors.LRED })
Spell({ 2070, 6770, 11297 }, { name = "Sap", color = colors.LBLUE, glowtime = 5, ghost = 1, ghosteffect = "SLICENDICE",
    pvpduration = 20,
    duration = function(timer)
        if timer.spellID == 6770 then return 25 -- yes, Rank 1 spell id is 6770 actually
        elseif timer.spellID == 2070 then return 35
        else return 45 end
    end
}) -- varies
Spell( 2094 , { name = "Blind", duration = 10, color = colors.WOO })

Spell({ 11327, 11329 }, { name = "Vanish", duration = 10, group = "buffs", scale = 0.5, color = colors.BLACK })

Spell({ 8647, 8649, 8650, 11197, 11198, 26866 }, { name = "Expose Armor", duration = 30, color = colors.WOO2 })
Spell( 1330, { name = "Silence", color = colors.PINKIERED, duration = 3 })
Spell({ 703, 8631, 8632, 8633, 11289, 11290, 26839, 26884 }, { name = "Garrote", color = colors.PINK3, duration = 18 })
Spell({ 408, 8643 }, { name = "Kidney Shot", shine = true, color = colors.LRED,
    duration = function(timer) return 1+GetCP() end,
}) -- varies
Spell({ 1943, 8639, 8640, 11273, 11274, 11275, 26867 }, { name = "Rupture", tick = 2, tickshine = true, overlay = {"tick", "end"}, shine = true, color = colors.RED,
    duration = function(timer)
        return (6 + GetCP()*2)
    end,
}) -- varies
Spell({ 5171, 6774 }, { name = "Slice and Dice", shinerefresh = true, color = colors.PURPLE,
    duration = function(timer)
        local mul = 1 + 0.15*Talent(14165, 14166, 14167)
        return (6 + GetCP()*3)*mul
    end
}) -- varies

Spell({ 2983, 8696, 11305 }, { name = "Sprint", group = "buffs", shine = true, duration = 8 })
Spell({ 5277, 26669 } ,{ name = "Evasion", group = "buffs", color = colors.PINK, duration = 15 })
Spell({ 1776, 1777, 8629, 11285, 11286, 38764 }, { name = "Gouge", shine = true, color = colors.PINK3,
    duration = function(timer)
        return 4 + 0.5*Talent(13741, 13793, 13792)
    end
})

Spell( 14177 ,{ name = "Cold Blood", shine = true, duration = 15, group = "buffs", priority = -12, timeless = true, scale = 0.7, color = colors.DTEAL })
Spell({ 14143, 14149 }, { name = "Remorseless", group = "buffs", scale = 0.75, duration = 20, color = colors.TEAL3 })
Cooldown( 14251, { name = "Riposte", color = colors.DBROWN, scale = 0.8 })
Activation( 14251, { for_cd = true, effect = "FIRESHOT", ghost = 6 })

Cooldown( 14278, { name = "Ghostly Strike", color = colors.WOO, ghost = true, scale_until = 5, })

EventTimer({ event = "SPELL_CAST_SUCCESS", spellID = 1725, name = "Distract", color = colors.WOO2DARK, duration = 10 })

end

if class == "WARRIOR" then
Interrupt({ 6552, 6554 }, "Pummel", 4)
Interrupt({ 72, 1671, 1672, 29704 }, "Shield Bash", 6)

Spell( 18498 ,{ name = "Silence", duration = 3, color = colors.PINK }) -- Improved Shield Bash
Spell( 23920 ,{ name = "Spell Reflect", color = colors.LBLUE, group = "buffs", arrow = colors.LBLUE, duration = 5, scale = 0.75, shine = true })
Spell({ 29801, 30030, 30033 } ,{ name = "Rampage", shine = true, shinerefresh = true, color = colors.DPURPLE, color2 = colors.REJUV, priority = 11, duration = 30 })

Spell( 20230 ,{ name = "Retaliation", group = "buffs", shine = true, duration = 15, color = colors.PINK })
Spell( 1719 ,{ name = "Recklessness", group = "buffs", shine = true, duration = 15, color = colors.REJUV })
Spell( 871, { name = "Shield Wall", group = "buffs", shine = true, duration = 10, color = colors.WOO }) -- varies
Spell( 12976, { name = "Last Stand", group = "buffs", color = colors.PURPLE3, duration = 20, priority = -8 })
Spell( 12328, { name = "Death Wish", group = "buffs", shine = true, duration = 30, color = colors.PINKIERED })

Spell({ 772, 6546, 6547, 6548, 11572, 11573, 11574, 25208 }, { name = "Rend", tick = 3, tickshine = true, overlay = {"tick", "end"}, color = colors.RED, ghost = true,
    duration = function(timer)
        if timer.spellID == 772 then return 9
        elseif timer.spellID == 6546 then return 12
        elseif timer.spellID == 6547 then return 15
        elseif timer.spellID == 6548 then return 18
        else return 21 end
    end
}) -- varies
Spell({ 1715, 7372, 7373, 25212 }, { name = "Hamstring", ghost = true, color = colors.PURPLE4, duration = 15 })
Spell( 23694 , { name = "Immobilized", shine = true, color = colors.BLACK, duration = 5 }) -- Improved Hamstring

Spell({ 694, 7400, 7402, 20559, 20560, 25266 }, { name = "Mocking Blow", color = colors.LRED, duration = 6, shine = true })
Spell( 1161 ,{ name = "Challenging Shout", duration = 6, multiTarget = true })
Spell( 355 ,{ name = "Taunt", duration = 3 })

Cooldown( 7384, { name = "Overpower", shine = true, priority = 9, color = colors.TEAL3, priority = 7, isknowncheck = function() return GetShapeshiftForm() ~= 2 end })
Activation( 7384, { for_cd = true, effect = "FIRESHOT", ghost = 5 })

Cooldown( 1680, { name = "Whirlwind", ghost = true, color = colors.PINKIERED, priority = 9.5 })
Spell({ 6343, 8198, 8204, 8205, 11580, 11581, 25264 }, { name = "Thunder Clap", multiTarget = true, color = colors.DBLUE, scale = 0.6, affiliation = "raid",
    duration = function(spellID)
        if spellID == 6343 then return 10
        elseif spellID == 8198 then return 14
        elseif spellID == 8204 then return 18
        elseif spellID == 8205 then return 22
        elseif spellID == 11580 then return 26
        else return 30 end
    end
}) -- Thunder Clap
-- Cooldown( 6343, { name = "Thunder Clap", ghost = 1, scale = 0.8, color = colors.PINKIERED, priority = 9.5 })

Spell(469, { name = "Commanding Shout", ghost = 7, target = "player", scale_until = 20, priority = -301, effect = "BLOODBOIL", effecttime = 10, glowtime = 10, affiliation = "raid", color = colors.DPURPLE, duration = 120 })
Spell({ 2048, 5242, 6192, 6673, 11549, 11550, 11551, 25289 }, { name = "Battle Shout", ghost = 7, target = "player", scale_until = 20, priority = -300, effect = "BLOODBOIL", effecttime = 10, glowtime = 10, affiliation = "raid", color = colors.DPURPLE, duration = 120 })
Spell({ 1160, 6190, 11554, 11555, 11556, 25202, 25203 }, { name = "Demoralizing Shout", duration = 30, scale = 0.85, color = colors.DTEAL, affiliation = "raid", multiTarget = true, shinerefresh = true })
Spell( 18499, { name = "Berserker Rage", color = colors.REJUV, shine = true, scale = 0.6, group = "buffs", duration = 10 })
Spell({ 20253, 20614, 20615, 25273, 25274 }, { name = "Intercept", duration = 3, shine = true, color = colors.DRED })

Spell( 12323, { name = "Piercing Howl", multiTarget = true, duration = 6, color = colors.DBROWN })

-- Spell( 20511 ,{ name = "Intimidating Shout", duration = 8, priority = -1 }) -- Main Target
Spell( 5246 ,{ name = "Intimidating Shout", duration = 8, priority = -1.1, color = colors.PURPLE4, multiTarget = true }) -- AoE Fear

-- TODO: Victory Rush activation

Spell( 676 ,{ name = "Disarm", color = colors.PINK3, scale = 0.8, shine = true,
    duration = function(timer)
        return 10 + Talent(12313, 12804, 12807)
    end,
}) -- varies
-- Spell( 29131 ,{ name = "Bloodrage", color = colors.WOO, duration = 10, scale = 0.5, shine = true })

Cooldown( 6572 ,{ name = "Revenge", priority = 5, color = colors.PURPLE, resetable = true, fixedlen = 6, isknowncheck = function() return GetShapeshiftForm() == 2 end })
Activation( 6572, { for_cd = true, effect = "FIRESHOT", ghost = 5 })
-- There's no spell activation overlay in classic, so using SPELL_UPDATE_USABLE to emulate it

Spell( 12798 , { name = "Revenge Stun", duration = 3, shine = true, color = colors.DRED })

Spell( 2565 ,{ name = "Shield Block", color = colors.WOO2, shine = true, group = "buffs", shinerefresh = true, priority = - 9, duration = 5, arrow = colors.LGREEN }) -- varies BUFF
Cooldown( 2565 ,{ name = "Shield Block", priority = 9.9, scale = 0.5, ghost = true, color = colors.DPURPLE })

Cooldown( 23922, { name = "Shield Slam", short = "", priority = 10, fixedlen = 6, ghost = true, ghosteffect = "MAGICCAST", color = colors.CURSE, isknowncheck = function() return IsPlayerSpell(23922) end })
Cooldown( 12294, { name = "Mortal Strike", priority = 10, short = "", fixedlen = 6, ghost = true, ghosteffect = "MAGICCAST",  color = colors.CURSE, isknowncheck = function() return IsPlayerSpell(12294) end })
Cooldown( 23881, { name = "Bloodthirst", priority = 10, short = "", fixedlen = 6, ghost = true, ghosteffect = "MAGICCAST",  color = colors.CURSE, isknowncheck = function() return IsPlayerSpell(23881) end })

-- Make Charges?
Spell({ 7386, 7405, 8380, 11596, 11597, 25225 }, { name = "Sunder Armor", duration = 30, color = colors.DBROWN })
--[[
EventTimer({ event = "SPELL_CAST_SUCCESS", spellID = 11597, name = "SunderArmor5StackRefresh",
    action = function(active, srcGUID, dstGUID, spellID, damage )
        local timer = NugRunning.gettimer(active, GetSpellInfo(spellID), dstGUID, "DEBUFF")
        if timer then
            local now = GetTime()
            timer:SetTime(now, now + 30, timer.fixedoffset)
        end
    end
})
]]

Spell( 12809 ,{ name = "Concussion Blow", color = colors.TEAL2, shine = true, duration = 5 })
Spell( 12292 ,{ name = "Sweeping Strikes", group = "buffs", shine = true, priority = -100503, color = colors.LRED, duration = 20, scale = 0.8 })
Spell({ 12880, 14201, 14202, 14203, 14204 }, { name = "Enrage", color = colors.PURPLE4, shine = true, shinerefresh = true, scale = 1, group = "buffs", priority = -3, duration = 12 })
Spell({ 12966, 12967, 12968, 12969, 12970 }, { name = "Flurry", color = colors.PURPLE5, shinerefresh = true, shine = true, scale = 0.7, group = "buffs", priority = -1, duration = 15 })

end


local effects = {}
effects["UNHOLY"] = {
    path = "spells/enchantments/skullballs.m2",
    scale = 4,
    x = -6, y = -2,
}
effects["PURPLESWIPE"] = {
    path = "spells/enchantments/shaman_purple.m2",
    scale = 4,
    x = -10, y = -3,
}
effects["FIRESHOT"] = {
    path = "spells/fireshot_missile.m2",
    scale = 5,
    x = -3, y = -4,
}
effects["GOUGE"] = {
    path = "spells/Gouge_precast_state_hand.m2",
    scale = 5,
    x = -4, y = 0,
}
effects["MAGICCAST"] = {
    path = "spells/magic_cast_hand.m2",
    scale = 3,
    x = -12, y = -1,
}
effects["LIGHTNING"] = {
    path = "spells/lightning_precast_low_hand.m2",
    scale = 5,
    x = -1, y = 0,
}
effects["BACKSTAB"] = {
    path = "spells/backstab_impact_chest.m2",
    scale = 3,
    x = -5, y = -2,
}
effects["SLICENDICE"] = {
    path = "spells/slicedice_impact_chest.m2",
    scale = 3,
    x = -8, y = 0,
}
effects["BLOODBOIL"] = {
    path = "spells/bloodboil_impact_chest.m2",
    scale = 3.5,
    x = -4, y = -8,
}
NugRunningConfig.effects = effects


NugRunningConfig.DRopts = {
    FEAR = { id = 1, showid = 8122, name = "Fear", priority = -999, scale = 0.5, color = colors.DPURPLE },
    -- SILENCE = { id = 2, showid = 15487, name = "Silence", priority = -999, scale = 0.5, color = colors.DPURPLE2 },
    INCAP = { id = 3, showid = 6770, name = "Incapacitation", priority = -999, scale = 0.5, color = colors.DBLUE },
    STUN = { id = 4, showid = 7922, name = "Stun", priority = -999, scale = 0.5, color = colors.DRED },
    -- HORROR = { id = 5, showid = 15487, name = "Horror", priority = -999, scale = 0.5, color = colors.DTEAL },
    -- RANDOM_STUN = { id = 6, showid = 15487, name = "Random Stun", priority = -999, scale = 0.5, color = colors. },
    -- RANDOM_ROOT = { id = 7, showid = 15487, name = "Random Root", priority = -999, scale = 0.5, color = colors. },
    -- FROST_SHOCK = { id = 8, showid = 15487, name = "Frost Shock", priority = -999, scale = 0.5, color = colors.DTEAL },
    ROOT = { id = 9, showid = 339, name = "Root", priority = -999, scale = 0.5, color = colors.DBROWN },
    KIDNEY_SHOT = { id = 10, showid = 408, name = "Kidney Shot", priority = -999, scale = 0.5, color = colors.WOO2DARK },
}

local FEAR = "FEAR"
local SILENCE = "SILENCE"
local INCAP = "INCAP"
local STUN = "STUN"
local HORROR = "HORROR"
-- local OPENER_STUN = "OPENER_STUN"
local RANDOM_STUN = "RANDOM_STUN"
local RANDOM_ROOT = "RANDOM_ROOT"
local FROST_SHOCK = "FROST_SHOCK"
local ROOT = "ROOT"
local KIDNEY_SHOT = "KIDNEY_SHOT"
local CYCLONE = "CYCLONE"

helpers.DR_TypesPVE = {
    [KIDNEY_SHOT] = true,
    [STUN] = true,
}

helpers.DR_CategoryBySpellID = {
    -- Silences weren't on DR until 3.0.8
    -- Are random stuns even diminished at all among themselves?
    -- Random roots?

    [20549] = STUN, -- War Stomp
    [16566] = ROOT, -- Net-o-Matic

    [5782] = FEAR, -- Fear 3 ranks
    [6213] = FEAR,
    [6215] = FEAR,
    [5484] = FEAR, -- Howl of Terror 2 ranks
    [17928] = FEAR,
    [6358] = FEAR, -- Seduction

    [30153] = STUN, -- Felguard Intercept Stun
    [30195] = STUN,
    [30197] = STUN,

    [1090] = INCAP, -- Magic Dust
    [13327] = INCAP, -- Goblin Rocket Helm, Reckless Charge
    [5134] = FEAR, -- Flash Bomb

    -- [24259] = SILENCE, -- Spell Lock

    -- Coil wasn't on DR in classic, not sure about BC
    [6789] = HORROR, -- Death Coil 3 ranks
    [17925] = HORROR,
    [17926] = HORROR,
    [27223] = HORROR,

    [22703] = STUN, -- Infernal Summon Stun


    [20066] = INCAP, -- Repentance

    [853] = STUN, -- Hammer of Justice 4 ranks
    [5588] = STUN,
    [5589] = STUN,
    [10308] = STUN,

    [20170] = RANDOM_STUN, -- Seal of Justice Stun



    [3355] = INCAP, -- Freezing Trap Effect 3 ranks
    [14308] = INCAP,
    [14309] = INCAP,

    [19386] = INCAP, -- Wyvern Sting 4ranks
    [24132] = INCAP,
    [24133] = INCAP,
    [27068] = INCAP,

    [19503] = INCAP, -- Scatter Shot
    -- [19229] = RANDOM_ROOT, -- Improved Wing Clip Root

    [19306] = ROOT, -- Counterattack

    [19410] = RANDOM_STUN, -- Conc stun
    [24394] = STUN, -- Intimidation


    [2637] = INCAP, -- Hibernate 3 ranks
    [18657] = INCAP,
    [18658] = INCAP,

    [5211] = STUN, -- Bash 3 ranks
    [6798] = STUN,
    [8983] = STUN,

    [339] = ROOT, -- Entangling Roots 6 ranks
    [1062] = ROOT,
    [5195] = ROOT,
    [5196] = ROOT,
    [9852] = ROOT,
    [9853] = ROOT,
    [26989] = ROOT,
    [16922] = RANDOM_STUN, -- Improved Starfire

    [33786] = CYCLONE, -- Cyclone

    -- Pounce wasn't on the same DR with Cheap Shot until 3.1.0
    [9005] = STUN, -- Pounce
    [9823] = STUN,
    [9827] = STUN,
    [27006] = STUN,


    -- [18469] = SILENCE, -- Silence (Improved Counterspell)

    [118] = INCAP, -- Polymorph 7 variants
    [12824] = INCAP,
    [12825] = INCAP,
    [12826] = INCAP,
    [28271] = INCAP,
    [28272] = INCAP,

    -- Frostbite wasn't on DR until 2.1.0
    -- [12494] = RANDOM_ROOT, -- Frostbite
    [12355] = RANDOM_STUN, -- Impact

    [122] = ROOT, -- Frost Nova 4 rank
    [865] = ROOT,
    [6131] = ROOT,
    [10230] = ROOT,

    [8056] = FROST_SHOCK, -- Frost Shock 4 ranks
    [8058] = FROST_SHOCK,
    [10472] = FROST_SHOCK,
    [10473] = FROST_SHOCK,


    -- [15487] = SILENCE, -- Silence (Priest)
    [15269] = RANDOM_STUN, -- Blackout

    -- MIND CONTROL ???
    -- No Undeads for Shackle in classic

    [8122] = FEAR, -- Psychic Scream
    [8124] = FEAR,
    [10888] = FEAR,
    [10890] = FEAR,


    -- [18425] = SILENCE, -- Imp Kick
    [1833] = STUN, -- Cheap Shot
    -- Blind wasn't on Fear until some time in 3.0, and before that it was with Cyclone,
    -- and in classic probably with itself

    -- In BC Blind and Cyclone share DR
    [2094] = CYCLONE, -- Blind

    [2070] = INCAP, -- Sap 3 ranks
    [6770] = INCAP,
    [11297] = INCAP,

    [1776] = INCAP, -- Gouge 5 ranks
    [1777] = INCAP,
    [8629] = INCAP,
    [11285] = INCAP,
    [11286] = INCAP,
    [38764] = INCAP,

    [408] = KIDNEY_SHOT, -- Kidney Shot 2 ranks
    [8643] = KIDNEY_SHOT,

    [5530] = RANDOM_STUN, -- Mace Spec Stun, shared by both Rogue and Warrior


    -- [18498] = SILENCE, -- Imp Shield Bash Silence
    -- [23694] = RANDOM_ROOT, -- Improved Hamstring Root

    -- Disarm wasn't on DR until 2.3.0
    -- [676] = "DISARM", -- Disarm

    [12809] = STUN, -- Concussion Blow
    [12798] = RANDOM_STUN, -- Improved Revenge

    [5246] = FEAR, -- Intimidating Shout
    [20511] = FEAR, -- Int shout on off targets i think

    [7922] = STUN, -- Charge

    [20253] = STUN, -- Intercept Stun 5 ranks
    [20614] = STUN,
    [20615] = STUN,
    [25273] = STUN,
    [25274] = STUN,
}
