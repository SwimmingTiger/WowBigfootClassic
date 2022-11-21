function GladiatorlosSA:GetSpellList ()
	return {
		auraApplied ={					-- aura applied [spellid] = ".mp3 file name",
			-- GENERAL

			-- General (Aura Applied)
			[34709] = "shadowSight",
			[5530] = "maceStun", -- lmao
			-- Drinking
			[5006] = "drinking",
			[44055] = "battlemaster",
			[54861] = "nitroBoost",
			[54758] = "hyperspeedAccelerator",

			-- Druid (Aura Applied)
			[5229] = "enrage",
			[2893] = "abolishPoison",
			[61336] = "survivalInstincts",
			[29166] = "innervate",
			[22812] = "barkskin",
			[5217] = "tigersFury", -- Rank 1
			[6793] = "tigersFury", -- Rank 2
			[9845] = "tigersFury", -- Rank 3
			[9846] = "tigersFury", -- Rank 4
			[22842] = "frenziedRegeneration",
			[16689] = "naturesGrasp", -- Rank 1
			[16810] = "naturesGrasp", -- Rank 2
			[16811] = "naturesGrasp", -- Rank 3
			[16812] = "naturesGrasp", -- Rank 4
			[16813] = "naturesGrasp", -- Rank 5
			[17329] = "naturesGrasp", -- Rank 6
			[27009] = "naturesGrasp", -- Rank 7
			[53312] = "naturesGrasp", -- Rank 8
			[17116] = "naturesSwiftness",
			[50334] = "berserk",
			[48518] = "lunarEclipse",
			[48517] = "solarEclipse",
			[16870] = "clearcasting",
			[52610] = "savageRoar",
			[69369] = "predatorsSwiftness",

			-- Hunter (Aura Applied)
			[3045] = "rapidFire",
			[19577] = "intimidation",
			[19263] = "deterrence",
			[19574] = "bestialWrath",
			[53480] = "roarofsacrifice",
			[34471] = "theBeastWithin",
			[54216] = "mastersCall",
			[34027] = "killCommand",
			-- Check on friendly
			[1499] = "trapped", -- Freezing Trap Rank 1
			[14310] = "trapped", -- Freezing Trap Rank 2
			[14311] = "trapped", -- Freezing Trap Rank 3


			-- Mage (Aura Applied)
			[1008] = "amplifyMagic", -- Rank 1
			[8455] = "amplifyMagic", -- Rank 2
			[10169] = "amplifyMagic", -- Rank 3
			[10170] = "amplifyMagic", -- Rank 4
			[27130] = "amplifyMagic", -- Rank 5
			[33946] = "amplifyMagic", -- Rank 6
			[604] = "dampenMagic", -- Rank 1
			[8450] = "dampenMagic", -- Rank 2
			[8451] = "dampenMagic", -- Rank 3
			[10173] = "dampenMagic", -- Rank 4
			[10174] = "dampenMagic", -- Rank 5
			[33944] = "dampenMagic", -- Rank 6
			[543] = "fireWard", -- Rank 1
			[8457] = "fireWard", -- Rank 2
			[8458] = "fireWard", -- Rank 3
			[10223] = "fireWard", -- Rank 4
			[10225] = "fireWard", -- Rank 5
			[27128] = "fireWard", -- Rank 6
			[43010] = "fireWard",
			[6143] = "frostWard", -- Rank 1
			[8461] = "frostWard", -- Rank 2
			[8462] = "frostWard", -- Rank 3
			[10177] = "frostWard", -- Rank 4
			[28609] = "frostWard", -- Rank 5
			[32796] = "frostWard", -- Rank 6
			[43012] = "frostWard",
			[1463] = "manaShield", -- Rank 1
			[8494] = "manaShield", -- Rank 2
			[8495] = "manaShield", -- Rank 3
			[10191] = "manaShield", -- Rank 4
			[10192] = "manaShield", -- Rank 5
			[10193] = "manaShield", -- Rank 6
			[27131] = "manaShield", -- Rank 7
			[43020] = "manaShield",
			[43039] = "iceBarrier",
			[12043] = "presenceOfMind",
			[12042] = "arcanePower",
			[28682] = "combustion",
			[12472] = "icyVeins",
			[11426] = "mageShield", -- Rank 1
			[13031] = "mageShield", -- Rank 2
			[13032] = "mageShield", -- Rank 3
			[13033] = "mageShield", -- Rank 4
			[27134] = "mageShield", -- Rank 5
			[33405] = "mageShield", -- Rank 6
			[31643] = "blazingSpeed",
			[64343] = "impact",
			[48108] = "hotStreak",
			[74396] = "fingersOfFrost",
			[57761] = "brainFreeze",

			--DK
			[45529] = "bloodTap",
			[49028] = "dancingRuneWeapon",
			[49016] = "hysteria",
			[55233] = "vampiricBlood",
			[57623] = "hornOfWinter",
			[48792] = "iceboundFortitude",
			[49039] = "lichborne",
			[51271] = "unbreakableArmor",
			[48707] = "antiMagicShell",
			[51052] = "antiMagicZone",
			[49222] = "boneShield",

			-- Paladin (Aura Applied)
			[1044] = "handOfFreedom",
			[498] = "divineProtection", -- Rank 1
			[31821] = "auraMastery",
			[1022] = "handOfProtection",	--Hand of Protection rank 1
			[5599] = "handOfProtection",	--Hand of Protection rank 2
			[10278] = "handOfProtection",	--Hand of Protection rank 3
			[20164] = "sealOfJustice", -- Rank 1
			[642] = "divineShield", -- Rank 1
			[31884] = "avengingWrath",
			[6940] = "Sacrifice", -- Rank 1
			[6940]  = "handofsacrifice",
			[1038]  = "handofsalvation",
			[20216] = "divineFavor",
			[20375] = "sealOfCommand",
			[31842] = "divineIllumination",
			[20178] = "reckoning",
			[10308] = "hammerOfJustice",
			[54428] = "divinePlea",
			[53563] = "beaconOfLight",
			[53601] = "sacredShield",

			-- Priest (Aura Applied)
			[33206] = "painSuppression",
			[10060] = "powerInfusion",
			[6346] = "fearWard",
			[14751] = "innerFocus",
			[15286] = "vampiricEmbrace",
			[552] = "abolishDisease",
			[47788] = "GuardianSpirit",
			[47585] = "dispersion",
			[48066] = "powerWordShield",
			[586]   = "fade",
			[15473] = "shadowForm",

			-- Rogue (Aura Applied)
			[5277] = "evasion", -- Rank 1
			[26669] = "evasion", -- Rank 2
			[31224] = "cloakOfShadows",
			[14177] = "coldBlood",
			[13750] = "adrenalineRush",
			[51690] = "killingSpree", 
			-- Check on friendly
			[1833] = "cheapShot",
			[6770] = "sap", -- Rank 1
			[2070] = "sap", -- Rank 2
			[11297] = "sap", -- Rank 3
			[26839] = "garrote", -- Rank 7 (7+ silence)
			[26884] = "garrote", -- Rank 8
			[51713] = "shadowDance",
			[57934] = "trickOfTheTrade",
			[45182] = "cheatingDeath",

			-- Shaman (Aura Applied)
			[16166] = "elementalMastery",
			[30823] = "shamanisticRage",
			[16188] = "naturesSwiftness",
			[974] = "earthShield",	--Earth Shield rank 1
			[32593] = "earthShield",	--Earth Shield rank 2
			[32594] = "earthShield",	--Earth Shield rank 3
			[49283] = "earthShield",	--Earth Shield rank 4
			[49284] = "earthShield",	--Earth Shield rank 5
			[52127] = "waterShield",	--Water Shield rank 1
			[52129] = "waterShield",	--Water Shield rank 2
			[52131] = "waterShield",	--Water Shield rank 3
			[52134] = "waterShield",	--Water Shield rank 4
			[52136] = "waterShield",	--Water Shield rank 5
			[52138] = "waterShield",	--Water Shield rank 6
			[24398] = "waterShield",	--Water Shield rank 7
			[33736] = "waterShield",	--Water Shield rank 8
			[57960] = "waterShield",	--Water Shield rank 9

			-- Warlock (Aura Applied)
			[132] = "detectInvisibility",
			[6229] = "shadowWard", -- Rank 1
			[11739] = "shadowWard", -- Rank 2
			[11740] = "shadowWard", -- Rank 3
			[28610] = "shadowWard", -- Rank 4
			[47891] = "shadowWard",
			[18708] = "felDomination",
			[47241] = "metamorphosis",

			-- Warrior (Buff Applied)
			[55694] = "enragedRegeneration",
			[46924] = "bladestorm",
			[2687] = "bloodRage",
			[871] = "shieldWall",
			[18499] = "berserkerRage",
			[1719] = "recklessness",
			[23920] = "spellReflection",
			[12292] = "deathWish",
			[12975] = "lastStand",
			[20230] = "Retaliation",
			[23881] = "bloodthirst",
		},
		auraRemoved = {					-- aura removed [spellid] = ".mp3 file name",
			-- General (Aura Removed)
			[44055] = "battlemasterDown",
			[34709] = "shadowSightDown",

			[54861] = "nitroBoostDown",
			[54758] = "hyperspeedAceleratorDown",

			--Races
			[58984] = "shadowmeldDown",
			[26297] = "berserkingDown",
			[20594] = "stoneformDown",
			[20572] = "bloodFuryDown",
			[33702] = "bloodFuryDown",
			[7744] = "willOfTheForsakenDown",
			[28880] = "giftOfTheNaaruDown",
			[28730] = "arcaneTorrentDown",
			[25046] = "arcaneTorrentDown",
			[50613] = "arcaneTorrentDown",

			-- Druid (Aura Removed)
			[22812] = "barkskinDown",
			[29166] = "innervateDown",
			[17329] = "naturesGraspDown",	--rank 6
			[27009] = "naturesGraspDown",	--rank 7
			[53312] = "naturesGraspDown",	--rank 8
			[48505] = "starfallDown",	--rank 1
			[53199] = "starfallDown",	--rank 2
			[53200] = "starfallDown",	--rank 3
			[53201] = "starfallDown",	--rank 4
			[50334] = "berserkDown",
			[1850] = "dashDown",	--rank 1
			[9821] = "dashDown",	--rank 2
			[33357] = "dashDown",	--rank 3
			[5229] = "enrageDown",
			[22842] = "frenziedRegenerationDown",
			[52610] = "savageRoarDown",
			[61336] = "survivalInstinctsDown",
			[69369] = "predatorsSwiftnessDown",
			[17116] = "naturesSwiftnessDown",

			-- Hunter (Aura Removed)
			[34027] = "killCommandDown",
			[54216] = "mastersCallDown",
			[34471] = "theBeastWithinDown",
			[3045] = "rapidFireDown",
			[19263] = "deterrenceDown",

			-- Mage (Aura Removed)
			[12042] = "arcanePowerDown",
			[66] = "invisibilityDown",
			[43020] = "manaShieldDown",
			[28682] = "combustionDown",
			[12043] = "presenceOfMindDown",
			[64343] = "impactDown",
			[48108] = "hotStreakDown",
			[43012] = "frostWardDown",
			[43039] = "iceBarrierDown",
			[45438] = "iceBlockDown",
			[12472] = "icyveinsDown",
			[43010] = "fireWardDown",
			[31643] = "blazingSpeedDown",
			[74396] = "fingersOfFrostDown",
			[57761] = "brainFreezeDown",

			-- Paladin (Aura Removed)
			[31821] = "auraMasteryDown",
			[53563] = "beaconOfLightDown",
			[31842] = "divineIlluminationDown",
			[54428] = "divinePleaDown",
			[53601] = "sacredShieldDown",
			[25771] = "forbearanceDown",
			[498] = "divineProtectionDown", -- Rank 1
			[642] = "divineShieldDown", -- Rank 1
			[6940] = "divineSacrificeDown", -- Rank 1
			[20216] = "divineFavorDown",
			[1044] = "handOfFreedomDown",
			[1022] = "handOfProtectionDown",	--Hand of Protection rank 1
			[5599] = "handOfProtectionDown",	--Hand of Protection rank 2
			[10278] = "handOfProtectionDown",	--Hand of Protection rank 3
			[6940] = "handofsacrificeDown",
			[1038] = "handofsalvationDown",
			[20178] = "reckoningDown",
			[31884] = "avengingWrathDown",

			-- Priest (Aura Removed)
			[6346] = "fearWardDown",
			[48168] = "innerFireDown", 
			[33206] = "painSuppressionDown",
			[10060] = "powerInfusionDown",
			[48066] = "powerWordShieldDown", 
			[47788] = "guardianSpiritDown",
			[47585] = "dispersionDown",
			[586] = "fadeDown",	
			[15473] = "shadowFormDown",

			-- Rogue (Aura Removed)
			[14177] = "coldBloodDown",
			[13750] = "adrenalineRushDown",
			[5277] = "evasionDown", --Evasion rank 1
			[26669] = "evasionDown", --Evasion rank 2
			[51690] = "killingSpreeDown",
			[2983] = "sprintDown",	--Sprint rank 1
			[8696] = "sprintDown",	--Sprint rank 3
			[11305] = "sprintDown",	--Sprint rank 2
			[31224] = "cloakDown",
			[51713] = "shadowDanceDown",
			[57934] = "trickOfTheTradeDown",
			[45182] = "cheatingDeathDown",

			-- Shaman (Aura Removed)
			[16166] = "elementalMasteryDown",
			[32182] = "heroismDown", 
			[2825] = "bloodlustDown",
			[30823] = "shamanisticRageDown",
			[16188] = "naturesSwiftnessDown",

			-- Warlock (Aura Removed)
			[18708] = "felDominationDown",
			[47241] = "metamorphDown",

			--DK
			[45529] = "bloodTapDown",
			[49028] = "dancingRuneWeaponDown",
			[49016] = "hysteriaDown",
			[55233] = "vampiricBloodDown",
			[57623] = "hornOfWinterDown",
			[48792] = "iceboundFortitudeDown",
			[49039] = "lichborneDown",
			[51271] = "unbreakableArmorDown",
			[48707] = "antiMagicShellDown",
			[51052] = "antiMagicZoneDown",
			[49222] = "boneShieldDown",

			-- Warrior (Aura Removed)
			[46924] = "bladestormDown",
			[20230] = "RetaliationDown",
			[12328] = "sweepingStrikesDown",
			[18499] = "berserkerRageDown",
			[12292] = "deathWishDown",
			[55694] = "enragedRegenerationDown",
			[12975] = "lastStandDown",
			[1719] = "recklessnessDown",
			[871] = "shieldWallDown",
			[23920] = "spellReflectionDown",
		},
		castStart = {					-- cast start [spellid] = ".mp3 file name",
		
		--GENERAL
			-- Big Heals
			[635] = "bigHeal",	--Holy Light rank 1
			[639] = "bigHeal",	--Holy Light rank 2
			[647] = "bigHeal",	--Holy Light rank 3
			[1026] = "bigHeal",	--Holy Light rank 4
			[1042] = "bigHeal",	--Holy Light rank 5
			[3472] = "bigHeal",	--Holy Light rank 6
			[10328] = "bigHeal",	--Holy Light rank 7
			[10329] = "bigHeal",	--Holy Light rank 8
			[25292] = "bigHeal",	--Holy Light rank 9
			[27135] = "bigHeal",	--Holy Light rank 10
			[27136] = "bigHeal",	--Holy Light rank 11
			[48782] = "bigHeal",	--Holy Light rank 12
			[2054] = "bigHeal",		--Heal rank 1
			[2055] = "bigHeal",		--Heal rank 2
			[6063] = "bigHeal",		--Heal rank 3
			[6064] = "bigHeal",		--Heal rank 4
			[2060] = "bigHeal",		--Greater Heal rank 1
			[332] = "bigHeal",	--Healing Wave rank 2
			[547] = "bigHeal",	--Healing Wave rank 3
			[913] = "bigHeal",	--Healing Wave rank 4
			[939] = "bigHeal",	--Healing Wave rank 5
			[959] = "bigHeal",	--Healing Wave rank 6
			[8005] = "bigHeal",	--Healing Wave rank 7
			[10395] = "bigHeal",	--Healing Wave rank 8
			[10396] = "bigHeal",	--Healing Wave rank 9
			[25357] = "bigHeal",	--Healing Wave rank 10
			[25391] = "bigHeal",	--Healing Wave rank 11
			[25396] = "bigHeal",	--Healing Wave rank 12
			[49272] = "bigHeal",	--Healing Wave rank 13
			[49273] = "bigHeal",	--Healing Wave rank 14
			[5185] = "bigHeal",		--Healing Touch rank 1
			[5186] = "bigHeal",		--Healing Touch rank 2
			[5187] = "bigHeal",		--Healing Touch rank 3
			[5188] = "bigHeal",		--Healing Touch rank 4
			[5189] = "bigHeal",		--Healing Touch rank 5
			[6778] = "bigHeal",		--Healing Touch rank 6
			[8903] = "bigHeal",		--Healing Touch rank 7
			[9758] = "bigHeal",		--Healing Touch rank 8
			[9888] = "bigHeal",		--Healing Touch rank 9
			[9889] = "bigHeal",		--Healing Touch rank 10
			[25297] = "bigHeal",		--Healing Touch rank 11
			[26978] = "bigHeal",		--Healing Touch rank 12
			[26979] = "bigHeal",		--Healing Touch rank 13
			[48377] = "bigHeal",		--Healing Touch rank 14
			[48378] = "bigHeal",		--Healing Touch rank 15
			
			-- Non-Combat Resurrections
			[2006] = "resurrection",	--Resurrection (priest) rank 1
			[2010] = "resurrection",	--Resurrection (priest) rank 2
			[10880] = "resurrection",	--Resurrection (priest) rank 3
			[10881] = "resurrection",	--Resurrection (priest) rank 4
			[20770] = "resurrection",	--Resurrection (priest) rank 5
			[25435] = "resurrection",	--Resurrection (priest) rank 6
			[48171] = "resurrection",	--Resurrection (priest) rank 7
			[7328] = "resurrection",	--Redemption rank 1
			[10322] = "resurrection",	--Redemption rank 2
			[10324] = "resurrection",	--Redemption rank 3
			[20772] = "resurrection",	--Redemption rank 4
			[20773] = "resurrection",	--Redemption rank 5
			[48949] = "resurrection",	--Redemption rank 6
			[48950] = "resurrection",	--Redemption rank 7
			[2008] = "resurrection",	--Ancestral Spirit rank 1
			[20609] = "resurrection",	--Ancestral Spirit rank 2
			[50769] = "resurrection",	--Revive rank 1
			[50768] = "resurrection",	--Revive rank 2
			[50767] = "resurrection",	--Revive rank 3
			[50766] = "resurrection",	--Revive rank 4
			[50765] = "resurrection",	--Revive rank 5
			[50764] = "resurrection",	--Revive rank 6
			[50763] = "resurrection",	--Revive rank 7

			-- Druid (Spell Casting)
			[2637] = "hibernate", -- Rank 1
			[18657] = "hibernate", -- Rank 2
			[18658] = "hibernate", -- Rank 3
			[339] = "entanglingRoots", -- Rank 1
			[1062] = "entanglingRoots", -- Rank 2
			[5195] = "entanglingRoots", -- Rank 3
			[5196] = "entanglingRoots", -- Rank 4
			[9852] = "entanglingRoots", -- Rank 5
			[26989] = "entanglingRoots", -- Rank 6
			[53308] = "entanglingRoots",
			[33786] = "cyclone",
			[48465] = "starfire", --rank 10
			[740] = "tranquility", -- Rank 1
			[8918] = "tranquility", -- Rank 2
			[9862] = "tranquility", -- Rank 3
			[9863] = "tranquility", -- Rank 4
			[26983] = "tranquility", -- Rank 5
			[48447] = "tranquility",

			-- Hunter (Spell Casting)
			[19434] = "aimedShot", -- Rank 1
			[20900] = "aimedShot", -- Rank 2
			[20901] = "aimedShot", -- Rank 3
			[20902] = "aimedShot", -- Rank 4
			[20903] = "aimedShot", -- Rank 5
			[20904] = "aimedShot", -- Rank 6
			[27065] = "aimedShot", -- Rank 7
			[49050] = "aimedShot", -- Rank 9
			[982] = "revivePet",
			[1513] = "scareBeast", -- Rank 1
			[14326] = "scareBeast", -- Rank 2
			[14327] = "scareBeast", -- Rank 3

			-- Mage (Spell Casting)
			[118] = "polymorph", -- Rank 1 (Sheep)
			[12824] = "polymorph", -- Rank 2 (Sheep)
			[12825] = "polymorph", -- Rank 3 (Sheep)
			[12826] = "polymorph", -- Rank 4 (Sheep)
			[28271] = "polymorph", -- Rank 1 (Turtle)
			[28272] = "polymorph", -- Rank 1 (Pig)
			[61305] = "polymorph",
			[61721] = "polymorph",
			[61025] = "polymorph",
			[61780] = "polymorph",
			[12051] = "evocation",

			-- Paladin (Spell Casting)
			[10326] = "turnEvil",

			-- This is when the drinking started so maybe double check later when I'm sober  vvvvv

			-- Priest (Spell Casting)
			[605] = "mindControl", -- Rank 1
			[8129] = "manaBurn", -- Rank 1
			[32375] = "massDispel",
			[64843] = "divineHymn",
			[9484]  = "shackleUndead",
			[10955] = "shackleUndead",

			-- Rogue (Spell Casting)
			[1842]  = "disarmTrap",

			-- Shaman (Spell Casting)			
			[51514] = "hex", --works
			[60043] = "lavaBurst",

			-- Warlock (Spell Casting)
			[688] = "summonImp", -- Imp
			[697] = "summonVoidwalker", -- Voidwalker
			[712] = "summonSuccube", -- Succubus
			[691] = "summonFelhunter", -- Felhunter
			[30146] = "summonFelGuard", -- Felguard
			[1122] = "summonInfernal", -- O THIS WAS SCARY HUH
			[6215] = "fear", -- Rank 3
			[5484] = "howlOfTerror", -- Rank 1
			[17928] = "howlOfTerror", -- Rank 2
			[30108] = "unstableAffliction", -- Rank 1
			[30404] = "umstableAffliction", -- Rank 2
			[30405] = "unstableAffliction", -- Rank 3
			[47843] = "unstableAffliction",
			[710] = "banish",
			[18647] = "banish",
			[29893] = "createHealthstone", -- Ritual of Souls Rank 1
			[6201] = "createHealthstone", -- Create Healthstone Rank 1
			[6202] = "createHealthstone", -- Create Healthstone Rank 2
			[5699] = "createHealthstone", -- Create Healthstone Rank 3
			[11729] = "createHealthstone", -- Create Healthstone Rank 4
			[11730] = "createHealthstone", -- Create Healthstone Rank 5
			[27230] = "createHealthstone", -- Create Healthstone Rank 6
			[47878] = "createHealstone",
			[689] = "drainLife", -- Rank 1
			[699] = "drainLife", -- Rank 2
			[709] = "drainLife", -- Rank 3
			[7651] = "drainLife", -- Rank 4
			[11699] = "drainLife", -- Rank 5
			[11700] = "drainLife", -- Rank 6
			[27219] = "drainLife", -- Rank 7
			[27220] = "drainLife", -- Rank 8
			[47857] = "drainLife", -- Rank 9
			[5138] = "drainMana", -- Rank 1
			[6353] = "soulFire", -- Rank 1
			[17924] = "soulFire", -- Rank 2
			[27211] = "soulFire", -- Rank 3
			[30545] = "soulFire", -- Rank 4
			[47824] = "soulFire", -- Rank 5
			[47825] = "soulFire", -- Rank 6
			[48018] = "demonicCircleSummon",
			[59172] = "chaosBolt",

			-- Warrior (Cast Start)
			[64382] = "shatteringThrow",
		},
		castSuccess = {					--cast success [spellid] = ".mp3 file name",
--[[			-- Cure (DPS Dispel)
			[51886] = "cure", 		-- Cleanse Spirit (Enhancement/Elemental Shaman)
			[2782] = "cure", 		-- Remove Corruption (Guardian/Feral/Balance Druid)
			[475] = "cure",			-- Remove Curse (Mage)
			--I miss Remove Curse for mages. :( This spot is reserved for its memory. ]]
			
--[[			-- Dispel (Healer (Magic) Dispel)
			[4987] = "dispel", 		-- Cleanse (Holy Paladin)
			[527] = "dispel", 		-- Purify (Holy/Discipline Priest)]]
			
			-- CastSuccess (Major, cast-time CCs that went off)
			-- DRUID
			[2637] = "success", -- Hibernate Rank 1
			[18657] = "success", -- Hibernate Rank 2
			[18658] = "success", -- Hibernate Rank 3
			[33786] = "success", -- Cyclone
			-- HUNTER
			[1513] = "success", -- Scare Beast Rank 1
			[14326] = "success", -- Scare Beast Rank 2
			[14327] = "success", -- Scare Beast Rank 3
			-- MAGE
			[118] = "success", -- Polymorph Rank 1 (Sheep)
			[12824] = "success", -- Polymorph Rank 2 (Sheep)
			[12825] = "success", -- Polymorph Rank 3 (Sheep)
			[12826] = "success", -- Polymorph Rank 4 (Sheep)
			[28271] = "success", -- Polymorph Rank 1 (Turtle)
			[28272] = "success", -- Polymorph Rank 1 (Pig)
			-- PRIEST
			[605] = "success", -- Mind Control Rank 1
			[10911] = "success", -- Mind Control Rank 2
			[10912] = "success", -- Mind Control Rank 3
			-- WARLOCK
			[5782] = "success", -- Fear Rank 1
			[6213] = "success", -- Fear Rank 2
			[6215] = "success", -- Fear Rank 3
			-- Shaman
			[51514] = "success", -- Hex

			-- CastSuccess (Major non-CC spells that connect)
			[8129] = "connected", -- Mana Burn Rank 1
			[8131] = "connected", -- Mana Burn Rank 2
			[10874] = "connected", -- Mana Burn Rank 3
			[10875] = "connected", -- Mana Burn Rank 4
			[10876] = "connected", -- Mana Burn Rank 5
			[25379] = "connected", -- Mana Burn Rank 6
			[25380] = "connected", -- Mana Burn Rank 7

			[6353] = "connected", -- Soul Fire Rank 1
			[17924] = "connected", -- Soul Fire Rank 2
			[27211] = "connected", -- Soul Fire Rank 3
			[30545] = "connected", -- Soul Fire Rank 4
			
			-- Purges
			-- PH
		
			--GENERAL
			[107079] = "quakingPalm",
			--[20549] = "warStomp",
			[28730] = "arcaneTorrent",
			[25046] = "arcaneTorrent",
			[50613] = "arcaneTorrent",
			[58984] = "shadowmeld",
			[26297] = "berserking",
			[20594] = "stoneform",
			[20572] = "bloodFury",
			[33702] = "bloodFury",
			[7744]  = "willOfTheForsaken",
			[28880] = "giftOfTheNaaru",
			[59752] = "everyMan", 

			[59752] = "trinket",
			[42292] = "trinket", -- Inherited Insignias (Heirloom PvP Trinkets)
			[6262] = "Healthstone", -- Healthstone consumable

			-- Druid (Cast Success)
			[8946] = "curePoison",
			[2782] = "removeCurse",
			[5211] = "bash", -- Rank 1
			[6798] = "bash", -- Rank 2
			[8983] = "bash", -- Rank 3
			[5215] = "prowl", -- Rank 1
			[6783] = "prowl", -- Rank 2
			[9913] = "prowl", -- Rank 3
			[1850] = "dash", -- Rank 1
			[9821] = "dash", -- Rank 2
			[33357] = "dash", -- Rank 3
			[770] = "faeryFire", -- Rank 1
			[16857] = "faeryFire",
			[33831] = "forceOfNature",
			[18562] = "swiftmend",
			[48505] = "starfall",	--starfall rank 1
			[53199] = "starfall",	--starfall rank 2
			[53200] = "starfall",	--starfall rank 3
			[53201] = "starfall",	--starfall rank 4
			[16979] = "feralChargeBear",
			[49376] = "feralChargeCat",
			[49802] = "maim",
			[9005] = "pounce", -- Rank 1
			[9823] = "pounce", -- Rank 2
			[9827] = "pounce", -- Rank 3
			[27006] = "pounce", -- Rank 4
			[49803] = "pounce",
			[2893]  = "abolishPoison",

			-- Hunter (Cast Success)
			[5116] = "concussiveShot",
			[1543] = "flare",
			[1130] = "huntersMark", -- Rank 1
			[14323] = "huntersMark", -- Rank 2
			[14324] = "huntersMark", -- Rank 3
			[14325] = "huntersMark", -- Rank 4
			[1499] = "freezingTrap", -- Rank 1
			[14310] = "freezingTrap", -- Rank 2
			[14311] = "freezingTrap", -- Rank 3
			[60192] = "freezingtrap", --double check
			[14309] = "freezingtrap", --freezing trap effect
			[13810] = "frostTrap", --frost trap aura
			[13809] = "frostTrap", --frost trap aura
			[60192] = "freezingArrow",
			[34490] = "silencingshot",
			[19801] = "tranquilizingShot",
			[3034]  = "viperSting",
			[23989] = "readiness",
			[19386] = "wyvernSting", -- Rank 1
			[24132] = "wyvernSting", -- Rank 2
			[24133] = "wyvernSting", -- Rank 3
			[27068] = "wyvernSting", -- Rank 4
			[49010] = "wyvernSting",
			[19503] = "scatterShot",
			[14285] = "arcaneShot", -- Rank 6 (this rank and higher purges)
			[14286] = "arcaneShot", -- Rank 7
			[14287] = "arcaneShot", -- Rank 8
			[27019] = "arcaneShot", -- Rank 9
			[53271] = "masterscall",
			[781]   = "disengage",
			[34600] = "snaketrap",
			[53547] = "petPin",


			-- Mage (Cast Success)
			[475] = "removeLesserCurse",
			[1953] = "blink",
			[2139] = "counterspell",
			[45438] = "iceBlock",
			[42987] = "manaGem",
			[122] = "frostNova", -- Rank 1
			[865] = "frostNova", -- Rank 2
			[6131] = "frostNova", -- Rank 3
			[10230] = "frostNova", -- Rank 4
			[27088] = "frostNova", -- Rank 5
			[42917] = "frostNova",
			[66] = "invisibility",
			[30449] = "spellSteal",
			[11113] = "blastWave",
			[11958] = "coldSnap",
			[31687] = "summonWaterElemental",
			[44572] = "deepFreeze",
			[55342] = "mirrorImage",
			[475]   = "removeCurse",
			[42950] = "dragonsBreath",
			[33395] = "petFreeze",

			--DK
			[49941] = "bloodBoil", 
			[48266] = "bloodPresence", 
			[49005] = "markofblood", 
			[48982] = "runeTap", 
			[47476] = "strangulate",
			[45524] = "chainOfIce", 
			[47568] = "empowerRuneWeapon",
			[48263] = "frostPresence", 
			[49203] = "hungeringCold",
			[47528] = "mindFreeze",
			[49938] = "deathAndDecay", 
			[49576] = "deathGrip", 
			[61999] = "raiseAlly", 
			[46584] = "raiseDead", 
			[49206] = "summonGargoyle",
			[48265] = "unholyPresence",
			[47481] = "petStun", 

			-- Paladin (Cast Success)
			[53407] = "judgementOfJustice",
			[20271] = "judgementOfLight",
			[53408] = "judgementOfWisdom",		
			[1152] = "purify",
			[4987] = "cleanse",
			[853] = "hammerOfJustice", -- Rank 1
			[5588] = "hammerOfJustice", -- Rank 2
			[5589] = "hammerOfJustice", -- Rank 3
			[10308] = "hammerOfJustice", -- Rank 4
			[633] = "layOnHands", -- Rank 1
			[2800] = "layOnHands", -- Rank 2
			[10310] = "layOnHands", -- Rank 3
			[27154] = "layOnHands", -- Rank 4
			[20473] = "holyShock", -- Rank 1
			[20929] = "holyShock", -- Rank 2
			[20930] = "holyShock", -- Rank 3
			[27174] = "holyShock", -- Rank 4
			[33072] = "holyShock", -- Rank 5
			[48825] = "holyShock",
			[20066] = "repentance",
			[19746] = "concentrationAura",

			-- Priest (Cast Success)
			[528] = "cureDisease",
			[552]   = "abolishDisease",
			[527] = "dispelMagic", -- Rank 1 (Purge)
			[988] = "dispelMagic", -- Rank 2 (Purge)
			[8122] = "Fear4", -- Rank 1
			[8124] = "Fear4", -- Rank 2
			[10888] = "Fear4", -- Rank 3
			[10890] = "Fear4", -- Rank 4
			[34433] = "shadowFiend",
			[2944] = "devouringPlague", -- Rank 1
			[19276] = "devouringPlague", -- Rank 2
			[19277] = "devouringPlague", -- Rank 3
			[19278] = "devouringPlague", -- Rank 4
			[19279] = "devouringPlague", -- Rank 5
			[19280] = "devouringPlague", -- Rank 6
			[25467] = "devouringPlague", -- Rank 7
			[48299] = "devouringPlague", -- Rank 8
			[48300] = "devouringPlague", -- Rank 9
			[32379] = "shadowWordDeath", -- Rank 1
			[32996] = "shadowWordDeath", -- Rank 2
			[15487] = "silence",
			[64044] = "psychicHorror", --psychic horror, works
			[48078] = "holyNova",
			[53023] = "mindSear",

			-- Rogue (Cast Success)
			[2094] = "blind",
			[408] = "kidney", -- Rank 1
			[8643] = "kidney", -- Rank 2
			[2983] = "sprint", -- Rank 1
			[8696] = "sprint", -- Rank 2
			[11305] = "sprint", -- Rank 3
			[1784] = "stealth", -- Rank 1
			[1856] = "vanish", -- Rank 1
			[1857] = "vanish", -- Rank 2
			[26889] = "vanish", -- Rank 3
			[1776] = "gouge", -- Rank 1
			[1766] = "kick", -- Rank 1
			[14278] = "ghostlyStrike",
			[14185] = "preparation",
			[36554] = "shadowstep",
			[51722] = "disarm2", --dismantle
			[51724] = "sap",
			[11297] = "sap",
			[6770] = "sap",
			[13877] = "bladeflurry",
			[51723] = "fanOfKnive",

			-- Shaman (Cast Success)
			[2484] = "earthbindTotem",
			[8143] = "tremorTotem",
			[8177] = "groundingTotem",
			[370] = "purge", -- Rank 1
			[8012] = "purge", -- Rank 2
			[8042] = "earthShock", -- Rank 1
			[8044] = "earthShock", -- Rank 2
			[8045] = "earthShock", -- Rank 3
			[8046] = "earthShock", -- Rank 4
			[10412] = "earthShock", -- Rank 5
			[10413] = "earthShock", -- Rank 6
			[10414] = "earthShock", -- Rank 7
			[25454] = "earthShock", -- Rank 8
			[49231] = "earthShock",
			[8170] = "diseaseCleansingTotem",
			[2062] = "earthElementalTotem",
			[2894] = "fireElementalTotem",
			[2825] = "bloodlust",
			[32182] = "heroism", -- Heroism
			[16190] = "manaTideTotem",
			[8143] = "tremorTotem", --works
			[65992] = "tremorTotem", --dont know which one
			[51533] = "feralSpirit",
			[59159] = "thunderstorm",
			[51886] = "cleanseSpirit",
			[8170]  = "cleansingTotem",
			[526]   = "cureToxins",

			-- Warlock (Cast Success)
			[17928] = "fear2", --Howl of Terror
			[19647] = "spellLock",
			[48020] = "demonicCircleTeleport",
			[6789] = "deathcoil",
			[47860] = "deathcoil",
			[30283] = "shadowfury", -- Rank 1
			[30413] = "shadowfury", -- Rank 2
			[30414] = "shadowfury", -- Rank 3
			[47847] = "shadowFury",
			[48011] = "devourMagic",
			[47875] = "healthtone",
			[6358] = "seduction",

			-- Warrior (Cast Success)
			[676] = "disarm",
			[5246] = "Fear3",
			[6552] = "pummel", -- Rank 1
			[72] = "shieldBash", -- Rank 1
			[100] = "charge", -- Rank 1
			[6178] = "charge", -- Rank 2
			[11578] = "charge", -- Rank 3
			[20252] = "intercept", -- Rank 1
			[3411] = "intervene",
			[12328] = "sweepingStrikes",
			[12809] = "concussionBlow",
			[2457] = "battleStance",
			[71] = "defensiveStance",
			[2458] = "berserkerStance",
			[57755] = "heroicThrow",
			[57823] = "revenge",
			[46968] = "shockwave",
			[7386]  = "sunderArmor",
		},
		friendlyInterrupt = {			--friendly interrupt [spellid] = ".mp3 file name",
			[19647] = "lockout", -- Spell Locks begin
			[119910] = "lockout",
			[171140] = "lockout",
			[171138] = "lockout",
			[212619] = "lockout",
			[115781] = "lockout",
			[132409] = "lockout",
			[119910] = "lockout",
			[251523] = "lockout",
			[251922] = "lockout",
			[288047] = "lockout",
			[119898] = "lockout", -- Spell Locks end
			[2139] = "lockout", -- Counterspell
			[1766] = "lockout", -- Kick
			[6552] = "lockout", -- Pummel
			[47528] = "lockout", -- Mind Freeze
			[96231] = "lockout", -- Rebuke
			[93985] = "lockout", -- Skull Bash
			[97547] = "lockout", -- Solar Beam
			[57994] = "lockout", -- Wind Shear
			[116705] = "lockout", -- Spear Hand Strike
			[147362] = "lockout", -- Counter Shot
			[183752] = "lockout", -- Consume Magic (Demon Hunter)
			[187707] = "lockout", -- Muzzle (Survival Hunter)
		},
		friendlyInterrupted = {			--friendly interrupt [spellid] = ".mp3 file name",
			[19647] = "interrupted", -- Spell Lock
			[171140] = "interrupted", -- Spell Lock
			[171138] = "interrupted", -- Spell Lock
			[212619] = "interrupted", -- Spell Lock
			[119910] = "interrupted", -- Spell Lock
			[115781] = "interrupted", -- Spell Lock (Optical Blast)
			[119898] = "interrupted", -- Spell Lock YET AGAIN
			[2139] = "interrupted", -- Counterspell
			[1766] = "interrupted", -- Kick
			[6552] = "interrupted", -- Pummel
			[47528] = "interrupted", -- Mind Freeze
			[96231] = "interrupted", -- Rebuke
			[93985] = "interrupted", -- Skull Bash
			[97547] = "interrupted", -- Solar Beam
			[57994] = "interrupted", -- Wind Shear
			[116705] = "interrupted", -- Spear Hand Strike
			[147362] = "interrupted", -- Counter Shot
			[183752] = "interrupted", -- Consume Magic (Demon Hunter)
			[187707] = "interrupted", -- Muzzle (Survival Hunter)
		},
	}
end
