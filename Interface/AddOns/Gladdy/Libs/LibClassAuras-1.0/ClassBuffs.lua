local GetSpellInfo = GetSpellInfo
local select = select
local LibClassAuras = LibStub("LibClassAuras-1.0")
local Buff = LibClassAuras.Buff

-------------
-- PRIEST
-------------
Buff({ 1243, 1244, 1245, 2791, 10937, 10938, 25389, 48161 }, { buffType = "magic" }, "PRIEST") -- Power Word: Fortitude
Buff({ 21562, 21564, 25392, 48162 }, { buffType = "magic" }, "PRIEST") -- Prayer of Fortitude
Buff({ 17, 592, 600, 3747, 6065, 6066, 10898, 10899, 10900, 10901, 25217, 25218, 48065, 48066 }, { buffType = "magic" }, "PRIEST") -- Power Word: Shield
Buff({ 588, 7128, 602, 1006, 10951, 10952, 25431, 48040, 48168 }, { buffType = "magic" }, "PRIEST") -- Inner Fire
Buff({ 2651 }, { buffType = "magic" }, "PRIEST") -- Elune's Grace
Buff({ 6346 }, { buffType = "magic" }, "PRIEST") -- Fear Ward
Buff({ 14752, 14818, 14819, 27841, 25312, 48073 }, { buffType = "magic" }, "PRIEST") -- Divine Spirit
Buff({ 27681, 32999, 48074 }, { buffType = "magic" }, "PRIEST") -- Prayer of Spirit
Buff({ 1706 }, { buffType = "magic" }, "PRIEST") -- Levitate
Buff({ 139, 6074, 6075, 6076, 6077, 6078, 10927, 10928, 10929, 25315, 25221, 25222, 48067, 48068 }, { buffType = "magic" }, "PRIEST") -- Renew
Buff({ 552 }, { buffType = "magic" }, "PRIEST") -- Abolish Disease
Buff({ 33076, 48112, 48113 }, { buffType = "magic" }, "PRIEST") -- Prayer of Mending
Buff({ 586, 9578, 9579, 9592, 10941, 10942, 25429 }, { buffType = "magic" }, "PRIEST") -- Fade
Buff({ 2652, 19261, 19262, 19264, 19265, 19266, 25461 }, { buffType = "magic" }, "PRIEST") -- Touch of Weakness
Buff({ 18137, 19308, 19310, 19311, 19312, 25477 }, { buffType = "magic" }, "PRIEST") -- Shadowguard
Buff({ 976, 10957, 10958, 16874, 25433 }, { buffType = "magic" }, "PRIEST") -- Shadow Protection
Buff({ 27683, 39374 }, { buffType = "magic" }, "PRIEST") -- Prayer of Shadow Protection
--talents
Buff({ 14893, 15357, 15359 }, { buffType = "magic" }, "PRIEST") -- Inspiration
Buff({ 27813, 27817, 27818 }, { buffType = "magic" }, "PRIEST") -- Blessed Recovery
Buff({ 14743 }, { buffType = "magic" }, "PRIEST") -- Focused Casting
Buff({ 14751 }, { buffType = "magic" }, "PRIEST") -- Inner Focus
Buff({ 10060 }, { buffType = "magic" }, "PRIEST") -- Power Infusion
Buff({ 33206 }, { buffType = "magic" }, "PRIEST") -- Pain Suppression
Buff({ 34754 }, { buffType = "magic" }, "PRIEST") -- Clearcasting
Buff({ 15473 }, { buffType = "form" }, "PRIEST") -- Shadowform
Buff({ 47788 }, { buffType = "magic" }, "PRIEST") -- Guardian's Spirit
Buff({ 47585 }, { buffType = "magic" }, "PRIEST") -- Dispersion
Buff({ 65081 }, { buffType = "magic" }, "PRIEST") -- Body and Soul
Buff({ 33151 }, { buffType = "magic" }, "PRIEST") -- Surge of Light
Buff({ 47753 }, { buffType = "magic" }, "PRIEST") -- Divine Aegis
Buff({ 47930 }, { buffType = "magic" }, "PRIEST") -- Grace
Buff({ 63734 }, { buffType = "magic" }, "PRIEST") -- Serendipity

---------------
-- DRUID
---------------
Buff({ 467, 782, 1075, 8914, 9756, 9910, 26992, 53307 }, { buffType = "magic"}, "DRUID") -- Thorns
Buff({ 5487 }, { buffType = "form"}, "DRUID") -- Bear Form
Buff({ 783 }, { buffType = "form"}, "DRUID") -- Travel Form
Buff({ 9634 }, { buffType = "form"}, "DRUID") -- Dire Bear Form
Buff({ 768 }, { buffType = "form"}, "DRUID") -- Cat Form
Buff({ 22812 }, { buffType = "magic"}, "DRUID") -- Barkskin
Buff({ 5229 }, { buffType = "enrage"}, "DRUID") -- Enrage
Buff({ 5217, 6793, 9845, 9846, 50212, 50213 }, { buffType = "physical"}, "DRUID") -- Tiger's Fury
Buff({ 1850, 9821, 33357 }, { buffType = "physical"}, "DRUID") -- Dash
Buff({ 22842 }, { buffType = "physical"}, "DRUID") -- Frenzied Regeneration
Buff({ 1126, 5232, 6756, 5234, 8907, 9884, 9885, 26990, 48469 }, { buffType = "magic"}, "DRUID") -- Mark of the Wild
Buff({ 21849, 21850, 26991, 48470 }, { buffType = "magic"}, "DRUID") -- Gift of the Wild
Buff({ 774, 1058, 1430, 2090, 2091, 3627, 8910, 9839, 9840, 9841, 25299, 26981, 26982, 48442, 48443 }, { buffType = "magic"}, "DRUID") -- Regrowth
Buff({ 8936, 8938, 8939, 8940, 8941, 9750, 9856, 9857, 9858, 26980, 48440, 48441 }, { buffType = "magic"}, "DRUID") -- Rejuvenation
Buff({ 2893 }, { buffType = "magic"}, "DRUID") -- Abolish Poison
Buff({ 33763, 48450, 48451}, { buffType = "magic"}, "DRUID") -- Lifebloom
--Talents
Buff({ 24858 }, { buffType = "form"}, "DRUID") -- Moonkin Form
Buff({ 24907 }, { buffType = "aura"}, "DRUID") -- Moonkin Aura
Buff({ 33891 }, { buffType = "form"}, "DRUID") -- Tree of Life
Buff({ 16864, 16870 }, { buffType = "magic"}, "DRUID") -- Omen of Clarity
Buff({ 16689, 16810, 16811, 16812, 16813, 17329, 27009, 53312 }, { buffType = "magic"}, "DRUID") -- Nature's Grasp
Buff({ 45281, 45282, 45283 }, { buffType = "magic"}, "DRUID") -- Natural Perfection
Buff({ 17116 }, { buffType = "magic"}, "DRUID") -- Nature's Swiftness
Buff({ 17007 }, { buffType = "aura"}, "DRUID") -- Leader of the Pack
Buff({ 48518 }, { buffType = "physical"}, "DRUID") -- Eclipse (Lunar)
Buff({ 48517 }, { buffType = "physical"}, "DRUID") -- Eclipse (Solar)
Buff({ 16886 }, { buffType = "magic"}, "DRUID") -- Nature's Grace
Buff({ 48503, 48504 }, { buffType = "magic"}, "DRUID") -- Living Seed
Buff({ 50334 }, { buffType = "physical"}, "DRUID") -- Berserk
Buff({ 52610, 62071 }, { buffType = "enrage"}, "DRUID") -- Savage Roar
Buff({ 48391 }, { buffType = "enrage"}, "DRUID") -- Owlkin Frenzy


-------------
-- WARRIOR -- TODO
-------------
Buff({ 29838 }, { buffType = "physical"}, "WARRIOR") -- Second Wind
Buff({ 12292 }, { buffType = "enrage"}, "WARRIOR") -- Death Wish
Buff({ 6673 }, { buffType = "physical"}, "WARRIOR") -- Battle Shout
Buff({ 469 }, { buffType = "physical"}, "WARRIOR") -- Commanding Shout
Buff({ 12328 }, { buffType = "physical"}, "WARRIOR") -- Sweeping Strikes
Buff({ 29801, 30032 }, { buffType = "aura"}, "WARRIOR") -- Rampage
Buff({ 2687 }, { buffType = "enrage"}, "WARRIOR") -- Blood Rage
Buff({ 20230 }, { buffType = "physical"}, "WARRIOR") -- Retaliation
Buff({ 871 }, { buffType = "physical"}, "WARRIOR") -- Shield Wall
Buff({ 18499 }, { buffType = "enrage"}, "WARRIOR") -- Berserker Rage
Buff({ 23885 }, { buffType = "enrage"}, "WARRIOR") -- Bloodthirst
Buff({ 3411 }, { buffType = "physical"}, "WARRIOR") -- Intervene
Buff({ 50622 }, { buffType = "physical"}, "WARRIOR") -- Bladestorm (whirlwind)
Buff({ 52437 }, { buffType = "physical"}, "WARRIOR") -- Sudden Death
Buff({ 57522 }, { buffType = "physical"}, "WARRIOR") -- Wrecking Crew
Buff({ 46916 }, { buffType = "physical"}, "WARRIOR") -- Slam!
Buff({ 50720 }, { buffType = "physical"}, "WARRIOR") -- Vigilance
Buff({ 55694 }, { buffType = "enrage"}, "WARRIOR") -- Enraged Regeneration
Buff({ 1719 }, { buffType = "enrage"}, "WARRIOR") -- Recklessness


--------------
-- ROGUE -- TODO
--------------

Buff({ 2983 }, { buffType = "physical" }, "ROGUE") -- Sprint
Buff({ 5277 }, { buffType = "physical" }, "ROGUE") -- Evasion
Buff({ 31224 }, { buffType = "physical" }, "ROGUE") -- Cloak of Shadows
Buff({ 14278 }, { buffType = "physical" }, "ROGUE") -- Ghostly Strike
Buff({ 51713 }, { buffType = "physical" }, "ROGUE") -- Shadow Dance
Buff({ 31665 }, { buffType = "physical" }, "ROGUE") -- Master of Subtlety
Buff({ 51690 }, { buffType = "physical" }, "ROGUE") -- Killing Spree
Buff({ 63848 }, { buffType = "enrage" }, "ROGUE") -- Hunger For Blood
Buff({ 57934 }, { buffType = "physical" }, "ROGUE") -- Tricks of the Trade


------------
-- WARLOCK --TODO
------------
Buff({ 19028 }, { buffType = "aura"}, "WARLOCK") -- Soul Link
Buff({ 687, 696 }, { buffType = "aura"}, "WARLOCK") -- Demon Skin
Buff({ 706, 1086, 11733, 11734, 11735, 27260, 47793, 47889 }, { buffType = "aura"}, "WARLOCK") -- Demon Armor
Buff({ 28176, 28189, 47892, 47893 }, { buffType = "aura"}, "WARLOCK") -- Fel Armor
Buff({ 23759 }, { buffType = "aura"}, "WARLOCK") -- Master Demonologist
Buff({ 34936 }, { buffType = "magic"}, "WARLOCK") -- Backlash
Buff({ 5697 }, { buffType = "magic"}, "WARLOCK") -- Unending Breath
Buff({ 132 }, { buffType = "magic"}, "WARLOCK") -- Detect Invisibility
Buff({ 1949, 11683, 11684, 27213, 47823 }, { buffType = "aura"}, "WARLOCK") -- Hellfire
Buff({ 6229, 11739, 11740, 28610, 47890, 47891 }, { buffType = "magic"}, "WARLOCK") -- Shadow Ward
Buff({ 19480, 20435, 41002 }, { buffType = "aura"}, "WARLOCK") -- Paranoia
Buff({ 7812, 19438, 19440, 19441, 19442, 19443, 27273, 47985, 47986 }, { buffType = "magic"}, "WARLOCK") -- Sacrifice
Buff({ 2947, 8316, 8317, 11770, 11771, 27269, 47983 }, { buffType = "magic"}, "WARLOCK") -- Fire Shield
Buff({ 48018 }, { buffType = "magic"}, "WARLOCK") -- Demonic Circle: Summon
Buff({ 59672 }, { buffType = "physical"}, "WARLOCK") -- Metamorphosis
Buff({ 54277 }, { buffType = "physical"}, "WARLOCK") -- Backdraft
Buff({ 47283 }, { buffType = "magic"}, "WARLOCK") -- Empowered Imp
Buff({ 64371 }, { buffType = "magic"}, "WARLOCK") -- Eradication
Buff({ 18093, 63243, 63244 } ,{ buffType = "physical" }, "WARLOCK") -- Pyroclasm


---------------
-- SHAMAN
---------------

Buff({ 8178 } ,{ buffType = "magic" }, "SHAMAN") -- Grounding Totem Effect
Buff({ 30823 } ,{ buffType = "magic" }, "SHAMAN") -- Shamanistic Rage
Buff({ 32182 } ,{ buffType = "magic" }, "SHAMAN") -- Heroism
Buff({ 2825 } ,{ buffType = "magic" }, "SHAMAN") -- Bloodlust
Buff({ 974, 32593, 32594, 49283, 49284 } ,{ buffType = "magic" }, "SHAMAN") -- Earth Shield
Buff({ 24398, 33736, 57960 } ,{ buffType = "magic" }, "SHAMAN") -- Water Shield
Buff({ 324, 25472, 49280, 49281 } ,{ buffType = "magic" }, "SHAMAN") -- Lightning Shield
Buff({ 16188 } ,{ buffType = "magic" }, "SHAMAN") -- Nature's Swiftness
Buff({ 16166 } ,{ buffType = "magic" }, "SHAMAN") -- Elemental Mastery
Buff({ 51470 } ,{ buffType = "aura" }, "SHAMAN") -- Elemental Oath
Buff({ 30809 } ,{ buffType = "aura" }, "SHAMAN") -- Unleashed Rage
Buff({ 52179 } ,{ buffType = "magic" }, "SHAMAN") -- Astral Shift
Buff({ 61295, 61299, 61300, 61301 } ,{ buffType = "magic" }, "SHAMAN") -- Riptide
Buff({ 53390 } ,{ buffType = "magic" }, "SHAMAN") -- Tidal Waves
Buff({ 52000, 51999, 51998, 51997, 51990, 51945 } ,{ buffType = "magic" }, "SHAMAN") -- Earthliving proc



--------------
-- PALADIN --TODO
--------------
--Blessings
Buff( { 1022, 5599, 10278 }, { buffType = "magic"}, "PALADIN") -- Blessing/Hand of Protection
Buff( { 6940 }, { buffType = "magic"}, "PALADIN") -- Blessing/Hand of Sacrifice
Buff( { 1044, 66115 }, { buffType = "magic"}, "PALADIN") -- Blessing/Hand of Freedom
Buff( { 19740, 19834, 19835, 19836, 19837, 19838, 25291, 27140, 48931, 48932 }, { buffType = "magic"}, "PALADIN") -- Blessing of Might
Buff( { 19742, 19850, 19852, 19853, 19854, 25290, 27142, 48935, 48936 }, { buffType = "magic"}, "PALADIN") -- Blessing of Wisdom
Buff( { 20217 }, { buffType = "magic"}, "PALADIN") -- Blessing of Kings
Buff( { 19977 }, { buffType = "magic"}, "PALADIN") -- Blessing of Light
Buff( { 1038 }, { buffType = "magic"}, "PALADIN") -- Blessing/Hand of Salvation
Buff( { 20911 }, { buffType = "magic"}, "PALADIN") -- Blessing of Sanctuary
Buff( { 25898 }, { buffType = "magic"}, "PALADIN") -- Greater Blessing of Kings
Buff( { 25890 }, { buffType = "magic"}, "PALADIN") -- Greater Blessing of Light
Buff( { 25782, 27141, 48933, 48934 }, { buffType = "magic"}, "PALADIN") -- Greater Blessing of Might
Buff( { 25895  }, { buffType = "magic"}, "PALADIN") -- Greater Blessing of Salvation
Buff( { 25899 }, { buffType = "magic"}, "PALADIN") -- Greater Blessing of Sanctuary
Buff( { 25894, 48937 }, { buffType = "magic"}, "PALADIN") -- Greater Blessing of Wisdom
Buff( { 642 }, { buffType = "immune"}, "PALADIN") -- Divine Shield
Buff( { 31884 }, { buffType = "magic"}, "PALADIN") -- Avenging Wrath
--Auras
Buff( { 465, 10290, 643, 10291, 1032, 10292, 10293, 27149, 48941, 48942 }, { buffType = "aura"}, "PALADIN") -- Devotion Aura
Buff( { 7294 }, { buffType = "aura"}, "PALADIN") -- Retribution Aura
Buff( { 19746 }, { buffType = "aura"}, "PALADIN") -- Concentration Aura
Buff( { 19876 }, { buffType = "aura"}, "PALADIN") -- Shadow Resistance Aura
Buff( { 20218 }, { buffType = "aura"}, "PALADIN") -- Sanctity Aura
Buff( { 19888 }, { buffType = "aura"}, "PALADIN") -- Frost Resistance Aura
Buff( { 19891 }, { buffType = "aura"}, "PALADIN") -- Fire Resistance Aura
Buff( { 32223 }, { buffType = "aura"}, "PALADIN") -- Crusader Aura
--Seals
Buff( { 20154, 21084, 20287, 20288, 20289, 20290, 20291, 20292, 20293, 27155 }, { buffType = "magic"}, "PALADIN") -- Seal of Righteousness
Buff( { 31892 }, { buffType = "magic"}, "PALADIN") -- Seal of Blood
Buff( { 20375 }, { buffType = "magic"}, "PALADIN") -- Seal of Command
Buff( { 20164 }, { buffType = "magic"}, "PALADIN") -- Seal of Justice
Buff( { 20165 }, { buffType = "magic"}, "PALADIN") -- Seal of Light
Buff( { 15277 }, { buffType = "magic"}, "PALADIN") -- Seal of Reckoning
Buff( { 31801 }, { buffType = "magic"}, "PALADIN") -- Seal of Vengeance
Buff( { 20166 }, { buffType = "magic"}, "PALADIN") -- Seal of Wisdom
Buff( { 21082 }, { buffType = "magic"}, "PALADIN") -- Seal of the Crusade
Buff( { 53563 }, { buffType = "magic"}, "PALADIN") -- Beacon of Light
Buff( { 54149 }, { buffType = "magic"}, "PALADIN") -- Infusion of Light
Buff( { 59578 }, { buffType = "magic"}, "PALADIN") -- The Art of War
Buff( { 20925, 20927, 20928, 27179, 48951, 48952 }, { buffType = "magic"}, "PALADIN") -- Holy Shield
Buff( { 53601 }, { buffType = "magic"}, "PALADIN") -- Sacred Shield
Buff( { 54428 }, { buffType = "magic"}, "PALADIN") -- Divine Plea
Buff( { 31821 }, { buffType = "magic"}, "PALADIN") -- Aura Mastery
Buff( { 31842 }, { buffType = "magic"}, "PALADIN") -- Divine Illumination
Buff( { 20216 }, { buffType = "magic"}, "PALADIN") -- Divine Favor
Buff( { 25780 }, { buffType = "magic"}, "PALADIN") -- Righteous Fury




-------------
-- HUNTER
-------------

Buff( { 5384 }, { buffType = "physical"}, "HUNTER") -- Feign Death
Buff( { 19263 }, { buffType = "physical"}, "HUNTER") -- Deterrence
Buff( { 3045 }, { buffType = "physical"}, "HUNTER") -- Rapid Fire
Buff( { 64420 }, { buffType = "physical"}, "HUNTER") -- Sniper Training
Buff( { 34835 }, { buffType = "physical"}, "HUNTER") -- Master Tactician
Buff( { 54216 }, { buffType = "physical"}, "HUNTER") -- Master's Call
Buff( { 34471 }, { buffType = "physical"}, "HUNTER") -- The Beast Within


-------------
-- MAGE --TODO
-------------

Buff({ 66 }, { buffType = "magic"}, "MAGE") -- Invisibility
Buff({ 1459, 1460, 1461, 10156, 10157, 27126, 42995 }, { buffType = "magic"}, "MAGE") -- Arcane Intellect
Buff({ 130 }, { buffType = "magic"}, "MAGE") -- Slow Fall
Buff({ 604, 8450, 8451, 10173, 10174, 33944, 43015 }, { buffType = "magic"}, "MAGE") -- Dampen Magic
Buff({ 1008, 8455, 10169, 10170, 27130, 33946, 43017,  }, { buffType = "magic"}, "MAGE") -- Amplify Magic
Buff({ 1463, 8494, 8495, 10191, 10192, 10193, 27131, 43019, 43020 }, { buffType = "magic"}, "MAGE") -- Mana Shield
Buff({ 6117, 22782, 22783, 27125, 43023, 43024 }, { buffType = "form"}, "MAGE") -- Mage Armor
Buff({ 31643 }, { buffType = "magic"}, "MAGE") -- Blazing Speed
Buff({ 543, 8457, 8458, 10223, 10225, 27128, 43010 }, { buffType = "magic"}, "MAGE") -- Fire Ward
Buff({ 11129 }, { buffType = "magic"}, "MAGE") -- Combustion
Buff({ 30482, 43045, 43046 }, { buffType = "form"}, "MAGE") -- Molten Armor
Buff({ 168, 7300, 7301 }, { buffType = "form"}, "MAGE") -- Frost Armor
Buff({ 7302, 7320, 10219, 10220, 27124, 43008 }, { buffType = "form"}, "MAGE") -- Ice Armor
Buff({ 45438 }, { buffType = "immune"}, "MAGE") -- Ice Block
Buff({ 6143, 32796, 8462, 28609, 10177, 43012, 8461 }, { buffType = "magic"}, "MAGE") -- Frost Ward
--talents
Buff({ 11426, 13031, 13032, 13033, 27134, 33405, 43038, 43039 }, { buffType = "magic"}, "MAGE") -- Ice Barrier
Buff({ 12472 }, { buffType = "magic"}, "MAGE") -- Icy Veins
Buff({ 74396 }, { buffType = "magic"}, "MAGE") -- Fingers of Frost
Buff({ 57761 }, { buffType = "magic"}, "MAGE") -- FireBall!
Buff({ 44413 }, { buffType = "magic"}, "MAGE") -- Incanter's Absorption
Buff({ 48108 }, { buffType = "magic"}, "MAGE") -- Hot Streak
Buff({ 54741 }, { buffType = "magic"}, "MAGE") -- Hot Streak
Buff({ 61316 }, { buffType = "magic"}, "MAGE") -- Dalaran Brilliance
Buff({ 44401 }, { buffType = "magic"}, "MAGE") -- Missile Barrage




-------------
-- DEATHKNIGHT
-------------

Buff({ 48707 }, { buffType = "physical"}, "DEATHKNIGHT") -- Anti-Magic Shell
Buff({ 48792 }, { buffType = "physical"}, "DEATHKNIGHT") -- Icebound Fortitude
Buff({ 49039 }, { buffType = "physical"}, "DEATHKNIGHT") -- Lichborne
Buff({ 50461 }, { buffType = "physical"}, "DEATHKNIGHT") -- Anti-Magic Zone
Buff({ 57330, 57623 }, { buffType = "physical"}, "DEATHKNIGHT") -- Horn of Winter
Buff({ 49222 }, { buffType = "physical"}, "DEATHKNIGHT") -- Bone Shield
Buff({ 49016 }, { buffType = "enrage"}, "DEATHKNIGHT") -- Unholy Frenzy
Buff({ 59052 }, { buffType = "physical"}, "DEATHKNIGHT") -- Freezing Fog
Buff({ 55233 }, { buffType = "physical"}, "DEATHKNIGHT") -- Vampiric Blood
Buff({ 51271 }, { buffType = "physical"}, "DEATHKNIGHT") -- Unbreakable Armor
Buff({ 49796 }, { buffType = "physical"}, "DEATHKNIGHT") -- Deathchill
Buff({ 50485 }, { buffType = "physical"}, "DEATHKNIGHT") -- Acclimation
Buff({ 66803 }, { buffType = "physical"}, "DEATHKNIGHT") -- Desolation
Buff({ 55610 }, { buffType = "aura"}, "DEATHKNIGHT") -- Improved Icy Talons
Buff({ 53138 }, { buffType = "aura"}, "DEATHKNIGHT") -- Abomination's Might