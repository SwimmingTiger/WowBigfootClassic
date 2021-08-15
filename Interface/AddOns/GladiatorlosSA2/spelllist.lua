function GladiatorlosSA:GetSpellList ()
	return {
		auraApplied ={					-- aura applied [spellid] = ".mp3 file name",
			-- GENERAL

			-- General (Aura Applied)
			[34709] = "shadowSight",
			[5530] = "maceStun", -- lmao
			-- Drinking
			[104270] = "drinking",
			[167152] = "drinking",
			[5006] = "drinking",
			[274194] = "drinking",
			[262568] = "drinking",
			[274913] = "drinking",
			[257427] = "drinking",
			[257428] = "drinking",
			[272819] = "drinking",
			[279739] = "drinking",
			--Was I drunk when I did this??
			[44055] = "battlemaster",


			-- Druid (Aura Applied)
			[5229] = "enrage",
			[2893] = "abolishPoison",
			[29166] = "innervate",
			[22812] = "barkskin",
			[5217] = "tigersFury", -- Rank 1
			[6793] = "tigersFury", -- Rank 2
			[9845] = "tigersFury", -- Rank 3
			[9846] = "tigersFury", -- Rank 4
			[22842] = "frenziedRegen", -- Rank 1
			[22895] = "frenziedRegen", -- Rank 2
			[22896] = "frenziedRegen", -- Rank 3
			[26999] = "frenziedRegen", -- Rank 4
			[16689] = "naturesGrasp", -- Rank 1
			[16810] = "naturesGrasp", -- Rank 2
			[16811] = "naturesGrasp", -- Rank 3
			[16812] = "naturesGrasp", -- Rank 4
			[16813] = "naturesGrasp", -- Rank 5
			[17329] = "naturesGrasp", -- Rank 6
			[27009] = "naturesGrasp", -- Rank 7
			[17116] = "naturesSwiftness",
			-- Check on friendly
			[9005] = "pounce", -- Rank 1
			[9823] = "pounce", -- Rank 2
			[9827] = "pounce", -- Rank 3
			[27006] = "pounce", -- Rank 4


			-- Hunter (Aura Applied)
			[3045] = "rapidFire",
			[19577] = "intimidation",
			[19263] = "deterrence",
			[19574] = "bestialWrath",
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
			[6143] = "frostWard", -- Rank 1
			[8461] = "frostWard", -- Rank 2
			[8462] = "frostWard", -- Rank 3
			[10177] = "frostWard", -- Rank 4
			[28609] = "frostWard", -- Rank 5
			[32796] = "frostWard", -- Rank 6
			[1463] = "manaShield", -- Rank 1
			[8494] = "manaShield", -- Rank 2
			[8495] = "manaShield", -- Rank 3
			[10191] = "manaShield", -- Rank 4
			[10192] = "manaShield", -- Rank 5
			[10193] = "manaShield", -- Rank 6
			[27131] = "manaShield", -- Rank 7
			[12043] = "presenceOfMind",
			[12042] = "arcanePower",
			[11129] = "combustion",
			[12472] = "icyVeins",
			[11426] = "mageShield", -- Rank 1
			[13031] = "mageShield", -- Rank 2
			[13032] = "mageShield", -- Rank 3
			[13033] = "mageShield", -- Rank 4
			[27134] = "mageShield", -- Rank 5
			[33405] = "mageShield", -- Rank 6
			-- Check on friendly
			[12355] = "impact", -- Actual debuff

			-- Paladin (Aura Applied)
			[1044] = "handOfFreedom",
			[498] = "divineProtection", -- Rank 1
			[5573] = "divineProtection", -- Rank 2
			[1022] = "handOfProtection", -- Rank 1
			[5599] = "handOfProtection", -- Rank 2
			[10278] = "handOfProtection", -- Rank 3
			[20164] = "sealOfJustice", -- Rank 1
			[31895] = "sealOfJustice", -- Rank 2
			[642] = "divineShield", -- Rank 1
			[1020] = "divineShield", -- Rank 2
			[21082] = "sealOfCrusader", -- Rank 1
			[20162] = "sealOfCrusader", -- Rank 2
			[20305] = "sealOfCrusader", -- Rank 3
			[20306] = "sealOfCrusader", -- Rank 4
			[20307] = "sealOfCrusader", -- Rank 5
			[20308] = "sealOfCrusader", -- Rank 6
			[27158] = "sealOfCrusader", -- Rank 7
			[31892] = "sealOfBlood",
			[348700] = "sealOfBlood", -- Seal of the Martyr
			[31801] = "sealOfVengeance",
			[348704] = "sealOfVengeance", -- Seal of Corruption
			[20154] = "sealOfRighteousness", -- Rank 1
			[21084] = "sealOfRighteousness", -- Rank 1 again?
			[20287] = "sealOfRighteousness", -- Rank 2
			[20288] = "sealOfRighteousness", -- Rank 3
			[20289] = "sealOfRighteousness", -- Rank 4
			[20290] = "sealOfRighteousness", -- Rank 5
			[20291] = "sealOfRighteousness", -- Rank 6
			[20292] = "sealOfRighteousness", -- Rank 7
			[20293] = "sealOfRighteousness", -- Rank 8
			[27155] = "sealOfRighteousness", -- Rank 9
			[20166] = "sealOfWisdom", -- Rank 1
			[20356] = "sealOfWisdom", -- Rank 2
			[20357] = "sealOfWisdom", -- Rank 3
			[27166] = "sealOfWisdom", -- Rank 4
			[20165] = "sealOfLight", -- Rank 1
			[20347] = "sealOfLight", -- Rank 2
			[20348] = "sealOfLight", -- Rank 3
			[20349] = "sealOfLight", -- Rank 4
			[27160] = "sealOfLight", -- Rank 5
			[31884] = "avengingWrath",
			[6940] = "Sacrifice", -- Rank 1
			[20729] = "Sacrifice", -- Rank 2
			[27147] = "Sacrifice", -- Rank 3
			[27148] = "Sacrifice", -- Rank 4
			[20216] = "divineFavor",
			[20375] = "sealOfCommand",
			[31842] = "divineIllumination",
			-- Check on friendly
			[20170] = "justiceStun",

			-- Priest (Aura Applied)
			[2651] = "elunesGrace",
			[6346] = "fearWard",
			[13896] = "feedback", -- Rank 1
			[19271] = "feedback", -- Rank 2
			[19273] = "feedback", -- Rank 3
			[19274] = "feedback", -- Rank 4
			[19275] = "feedback", -- Rank 5
			[25441] = "feedback", -- Rank 6
			[33206] = "painSuppression",
			[10060] = "powerInfusion",
			[14751] = "innerFocus",
			[15286] = "vampiricEmbrace",
			[552] = "abolishDisease",

			-- Rogue (Aura Applied)
			[5277] = "evasion", -- Rank 1
			[26669] = "evasion", -- Rank 2
			[31224] = "cloakOfShadows",
			[14177] = "coldBlood",
			[13750] = "adrenalineRush",
			-- Check on friendly
			[1833] = "cheapShot",
			[6770] = "sap", -- Rank 1
			[2070] = "sap", -- Rank 2
			[11297] = "sap", -- Rank 3
			[26839] = "garrote", -- Rank 7 (7+ silence)
			[26884] = "garrote", -- Rank 8

			-- Shaman (Aura Applied)
			[16166] = "elementalMastery",
			[30823] = "shamanisticRage",
			[16188] = "naturesSwiftness",

			-- Warlock (Aura Applied)
			[132] = "detectInvisibility",
			[6229] = "shadowWard", -- Rank 1
			[11739] = "shadowWard", -- Rank 2
			[11740] = "shadowWard", -- Rank 3
			[28610] = "shadowWard", -- Rank 4
			[18288] = "amplifyCurse",

			-- Warrior (Buff Applied)
			[2457] = "damageStance",
			[71] = "defenseStance",
			[2458] = "berserkerStance",
			[2687] = "bloodRage",
			[871] = "shieldWall",
			[18499] = "berserkerRage",
			[1719] = "recklessness",
			[23920] = "spellReflection",
			[12292] = "deathwish",
			[12975] = "lastStand",


		},
		auraRemoved = {					-- aura removed [spellid] = ".mp3 file name",
			-- General (Aura Removed)
			[44055] = "battlemasterDown",

			-- Druid (Aura Removed)
			[29166] = "innervateDown",

			-- Hunter (Aura Removed)
			[19263] = "deterrenceDown",

			-- Mage (Aura Removed)
			[12042] = "APDown",
			[11129] = "combustionDown",
			[12472] = "icyVeinsDown",

			-- Paladin (Aura Removed)
			[25771] = "forbearanceDown",
			[498] = "ProtectionDown", -- Rank 1
			[5573] = "ProtectionDown", -- Rank 2
			[1022] = "ProtectionDown", -- Rank 1
			[5599] = "ProtectionDown", -- Rank 2
			[10278] = "ProtectionDown", -- Rank 3
			[642] = "bubbleDown", -- Rank 1
			[1020] = "bubbleDown", -- Rank 2
			[6940] = "sacrificeDown", -- Rank 1
			[20729] = "sacrificeDown", -- Rank 2
			[27147] = "sacrificeDown", -- Rank 3
			[27148] = "sacrificeDown", -- Rank 4
			[20216] = "divineFavorDown",

			-- Priest (Aura Removed)
			[2651] = "elunesGraceDown",
			[6346] = "fearWardDown",
			[13896] = "feedbackDown", -- Rank 1
			[19271] = "feedbackDown", -- Rank 2
			[19273] = "feedbackDown", -- Rank 3
			[19274] = "feedbackDown", -- Rank 4
			[19275] = "feedbackDown", -- Rank 5
			[25441] = "feedbackDown", -- Rank 6
			[15286] = "vampiricEmbraceDown",
			[33206] = "PSDown",
			[10060] = "infusionDown",
			[14751] = "innerFocusDown",

			-- Rogue (Aura Removed)
			[5277] = "evasionDown", -- Rank 1
			[26669] = "evasionDown", -- Rank 2
			[31224] = "cloakDown",

			-- Shaman (Aura Removed)
			[30823] = "shamanisticRageDown",

			-- Warlock (Aura Removed)
			-- nope

			-- Warrior (Aura Removed)
			[871] = "shieldWallDown",
			[1719] = "recklessnessDown",
			[23920] = "spellReflectionDown",
			[12292] = "deathwishDown",
			[12975] = "lastStandDown",
		},
		castStart = {					-- cast start [spellid] = ".mp3 file name",
		
		--GENERAL
			-- Big Heals
--[[			[2060] = "bigHeal", -- Heal (Holy Priest)
			[82326] = "bigHeal", -- Holy Light (Paladin)
			[77472] = "bigHeal", -- Healing Wave (Shaman)
			--[5185] = "bigHeal", -- Healing Touch (Druid)
			--[116670] = "bigHeal", -- Vivify (Mistweaver)
			[227344] = "bigHeal", -- Surging Mist (Honor Talent)
			[194509] = "bigHeal", -- Power Word: Radiance (Discipline)
			--[204065] = "bigHeal", -- Shadow Covenant (Discipline)
			[152118] = "bigHeal", -- Clarity of Will (Discipline)
			--[186263] = "bigHeal", -- Shadow Mend (Discipline/Shadow Priest)
			--[116694] = "bigHeal", -- Effuse (Mistweaver)
			--[124682] = "bigHeal", -- Enveloping Mists (Mistweaver)]]
			
			-- Non-Combat Resurrections
			[2006] = "resurrection", -- Resurrection (Priest)
			[7328] = "resurrection", -- Redemption (Paladin)
			[2008] = "resurrection", -- Ancestral Spirit (Shaman)
			[115178] = "resurrection", -- Resusicate (Monk)
			[50769] = "resurrection",  -- Revive (Druid)
			-- Non-Combat Mass Resurrections
			[212040] = "resurrection", -- Revitalize (Druid Mass Rez)
			[212051] = "resurrection", -- Reawaken (Monk Mass Rez)
			[212036] = "resurrection", -- Mass Resurrection (Priest Mass Rez)
			[212056] = "resurrection", -- Absolution (Paladin Mass Rez)
			[212048] = "resurrection", -- Ancestral Vision (Shaman Mass Rez)

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
			[33786] = "cyclone",

			-- Hunter (Spell Casting)
			[19434] = "aimedShot", -- Rank 1
			[20900] = "aimedShot", -- Rank 2
			[20901] = "aimedShot", -- Rank 3
			[20902] = "aimedShot", -- Rank 4
			[20903] = "aimedShot", -- Rank 5
			[20904] = "aimedShot", -- Rank 6
			[27065] = "aimedShot", -- Rank 7
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
			[12051] = "evocation",

			-- Paladin (Spell Casting)
			[10326] = "turnEvil",

			-- This is when the drinking started so maybe double check later when I'm sober  vvvvv

			-- Priest (Spell Casting)
			[605] = "mindControl", -- Rank 1
			[10911] = "mindControl", -- Rank 2
			[10912] = "mindControl", -- Rank 3
			[8129] = "manaBurn", -- Rank 1
			[8131] = "manaBurn", -- Rank 2
			[10874] = "manaBurn", -- Rank 3
			[10875] = "manaBurn", -- Rank 4
			[10876] = "manaBurn", -- Rank 5
			[25379] = "manaBurn", -- Rank 6
			[25380] = "manaBurn", -- Rank 7
			[32375] = "massDispell",

			-- Rogue (Spell Casting)
			-- lol

			-- Shaman (Spell Casting)
			-- ...also lol apparently

			-- Warlock (Spell Casting)
			[688] = "summonDemon", -- Imp
			[697] = "summonDemon", -- Voidwalker
			[712] = "summonDemon", -- Succubus
			[691] = "summonDemon", -- Felhunter
			[30146] = "summonDemon", -- Felguard
			[1122] = "summonInfernal", -- O THIS WAS SCARY HUH
			[5782] = "fear", -- Rank 1
			[6213] = "fear", -- Rank 2
			[6215] = "fear", -- Rank 3
			[5484] = "terrorHowl", -- Rank 1
			[17928] = "terrorHowl", -- Rank 2
			[30108] = "unstableAffliction", -- Rank 1
			[30404] = "umstableAffliction", -- Rank 2
			[30405] = "unstableAffliction", -- Rank 3
			[710] = "banish", -- Rank 1
			[18647] = "banish", -- Rank 2
			[30283] = "shadowfury", -- Rank 1
			[30413] = "shadowfury", -- Rank 2
			[30414] = "shadowfury", -- Rank 3
			[29893] = "createHealthstone", -- Ritual of Souls Rank 1
			[6201] = "createHealthstone", -- Create Healthstone Rank 1
			[6202] = "createHealthstone", -- Create Healthstone Rank 2
			[5699] = "createHealthstone", -- Create Healthstone Rank 3
			[11729] = "createHealthstone", -- Create Healthstone Rank 4
			[11730] = "createHealthstone", -- Create Healthstone Rank 5
			[27230] = "createHealthstone", -- Create Healthstone Rank 6
			[689] = "drainLife", -- Rank 1
			[699] = "drainLife", -- Rank 2
			[709] = "drainLife", -- Rank 3
			[7651] = "drainLife", -- Rank 4
			[11699] = "drainLife", -- Rank 5
			[11700] = "drainLife", -- Rank 6
			[27219] = "drainLife", -- Rank 7
			[27220] = "drainLife", -- Rank 8
			[5138] = "drainMana", -- Rank 1
			[6226] = "drainMana", -- Rank 2
			[11703] = "drainMana", -- Rank 3
			[11704] = "drainMana", -- Rank 4
			[27221] = "drainMana", -- Rank 5
			[30908] = "drainMana", -- Rank 6
			[6353] = "soulFire", -- Rank 1
			[17924] = "soulFire", -- Rank 2
			[27211] = "soulFire", -- Rank 3
			[30545] = "soulFire", -- Rank 4

			-- Warrior (Cast Start)
			-- smack smack smack

		},
		castSuccess = {					--cast success [spellid] = ".mp3 file name",
--[[			-- Cure (DPS Dispel)
			[213644] = "cure", 		-- Cleanse Toxins (Retribution/Protection Paladin)
			[236186] = "cure",		-- Cleansing Light (Paladin Honor Talent)
			[51886] = "cure", 		-- Cleanse Spirit (Enhancement/Elemental Shaman)
			[2782] = "cure", 		-- Remove Corruption (Guardian/Feral/Balance Druid)
			[213634] = "cure", 		-- Purify Disease (Shadow Priest)
			[218164] = "cure", 		-- Detox (Brewmaster/Windwalker Monk)
			[475] = "cure",			-- Remove Curse (Mage)
			--I miss Remove Curse for mages. :( This spot is reserved for its memory. ]]
			
--[[			-- Dispel (Healer (Magic) Dispel)
			[4987] = "dispel", 		-- Cleanse (Holy Paladin)
			[77130] = "dispel", 	-- Purify Spirit (Restoration Shaman)
			[88423] = "dispel", 	-- Nature's Cure (Restoration Druid)
			[527] = "dispel", 		-- Purify (Holy/Discipline Priest)
			[115450] = "dispel", 	-- Detox (Mistweaver Monk)
			-- Warlocks, because they're special snowflakes.
			[89808] = "dispel", 	-- Singe Magic
			[137178] = "dispel",	-- Singe Magic (Green)
			[119905] = "dispel",	-- Singe Magic 2, Electric Boogaloo
			[212623] = "dispel",	-- Singe Magic (PvP Talent)
			[212620] = "dispel",	-- Singe Magic (PvP Talent, looks to be unused)]]
			
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
			[20549] = "warStomp",
			[28730] = "arcaneTorrent",
			[25046] = "arcaneTorrent",
			[50613] = "arcaneTorrent",
			[69179] = "arcaneTorrent",
			[155145] = "arcaneTorrent",
			[129597] = "arcaneTorrent",
			[202719] = "arcaneTorrent",
			[80483] = "arcaneTorrent",
			[232633] = "arcaneTorrent",
			[58984] = "shadowmeld",
			[20594] = "stoneform",
			[7744] = "willOfTheForsaken",
			[59752] = "everyMan", 
			[287712] = "haymaker",
			[295707] = "regeneratin",

			[208683] = "trinket", -- Gladiator's Medallion Legion
			[195710] = "trinket", -- Honorable Medallion Legion
			[336126] = "trinket", -- Gladiator's Medallion Shadowlands
			[42292] = "trinket", -- Inherited Insignias (Heirloom PvP Trinkets)
			[23035] = "battleStandard",
			[23034] = "battleStandard",
			[213664] = "NimbleBrew", -- Nimble Brew consumable
			[6262] = "Healthstone", -- Healthstone consumable
			[265221] = "Fireblood", -- Fireblood (Dark Iron Dwarf)
			[256948] = "SpatialRift", -- Spatial Rift (Void Elf)
			[257040] = "SpatialRift2", -- Spatial Rift Teleport (Spatial Warp) (Void Elf)
			[255654] = "BullRush", -- Bull Rush (Highmountain Racial)

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
			[770] = "faerieFire", -- Rank 1
			[778] = "faerieFire", -- Rank 2
			[9749] = "faerieFire", -- Rank 3
			[9907] = "faerieFire", -- Rank 4
			[26993] = "faerieFire", -- Rank 5
			[16857] = "faerieFire", -- Rank 1 (Feral)
			[17390] = "faerieFire", -- Rank 2 (Feral)
			[17391] = "faerieFire", -- Rank 3 (Feral)
			[17392] = "faerieFire", -- Rank 4 (Feral)
			[27011] = "faerieFire", -- Rank 5 (Feral)
			[33831] = "forceOfNature",
			[740] = "tranquility", -- Rank 1
			[8918] = "tranquility", -- Rank 2
			[9862] = "tranquility", -- Rank 3
			[9863] = "tranquility", -- Rank 4
			[26983] = "tranquility", -- Rank 5
			[18562] = "swiftmend",

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
			[34490] = "silencingShot",
			[23989] = "readiness",
			[19386] = "wyvernSting", -- Rank 1
			[24132] = "wyvernSting", -- Rank 2
			[24133] = "wyvernSting", -- Rank 3
			[27068] = "wyvernSting", -- Rank 4
			[19503] = "scatterShot",
			[14285] = "arcaneShot", -- Rank 6 (this rank and higher purges)
			[14286] = "arcaneShot", -- Rank 7
			[14287] = "arcaneShot", -- Rank 8
			[27019] = "arcaneShot", -- Rank 9

			-- Mage (Cast Success)
			[475] = "removeLesserCurse",
			[1953] = "blink",
			[2139] = "counterspell",
			[45438] = "iceBlock",
			[122] = "frostNova", -- Rank 1
			[865] = "frostNova", -- Rank 2
			[6131] = "frostNova", -- Rank 3
			[10230] = "frostNova", -- Rank 4
			[27088] = "frostNova", -- Rank 5
			[66] = "invisibility",
			[30449] = "spellsteal",
			[11113] = "blastWave",
			[11958] = "coldSnap",
			[31687] = "waterElemental",

			-- Paladin (Cast Success)
			[20271] = "judgement", -- blizzard can't spell
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
			[20066] = "repentance",

			-- Priest (Cast Success)
			[32548] = "symbolOfHope",
			[528] = "cureDisease",
			[527] = "dispelMagic", -- Rank 1 (Purge)
			[988] = "dispelMagic", -- Rank 2 (Purge)
			[8122] = "Fear4", -- Rank 1
			[8124] = "Fear4", -- Rank 2
			[10888] = "Fear4", -- Rank 3
			[10890] = "Fear4", -- Rank 4
			[34433] = "shadowfiend",
			[2944] = "devouringPlague", -- Rank 1
			[19276] = "devouringPlague", -- Rank 2
			[19277] = "devouringPlague", -- Rank 3
			[19278] = "devouringPlague", -- Rank 4
			[19279] = "devouringPlague", -- Rank 5
			[19280] = "devouringPlague", -- Rank 6
			[25467] = "devouringPlague", -- Rank 7
			[44041] = "chastise", -- Rank 1
			[44043] = "chastise", -- Rank 2
			[44044] = "chastise", -- Rank 3
			[44045] = "chastise", -- Rank 4
			[44046] = "chastise", -- Rank 5
			[44047] = "chastise", -- Rank 6
			[32379] = "shadowWordDeath", -- Rank 1
			[32996] = "shadowWordDeath", -- Rank 2
			[15487] = "silence",

			-- Rogue (Cast Success)
			[2094] = "blind",
			[408] = "kidney", -- Rank 1
			[8643] = "kidney", -- Rank 2
			[2983] = "sprint", -- Rank 1
			[8696] = "sprint", -- Rank 2
			[11305] = "sprint", -- Rank 3
			[1784] = "stealth", -- Rank 1
			[1785] = "stealth", -- Rank 2
			[1786] = "stealth", -- Rank 3
			[1787] = "stealth", -- Rank 4
			[1856] = "vanish", -- Rank 1
			[1857] = "vanish", -- Rank 2
			[26889] = "vanish", -- Rank 3
			[1776] = "gouge", -- Rank 1
			[1777] = "gouge", -- Rank 2
			[8629] = "gouge", -- Rank 3
			[11285] = "gouge", -- Rank 4
			[11286] = "gouge", -- Rank 5
			[38764] = "gouge", -- Rank 6
			[1766] = "kick", -- Rank 1
			[1767] = "kick", -- Rank 2
			[1768] = "kick", -- Rank 3
			[1769] = "kick", -- Rank 4
			[38768] = "kick", -- Rank 5
			[14278] = "ghostlyStrike",
			[14185] = "preparation",
			[36554] = "shadowstep",

			-- Shaman (Cast Success)
			[2484] = "earthbindTotem",
			[526] = "curePoison",
			[8143] = "tremorTotem",
			[2870] = "cureDisease",
			[8166] = "poisonCleansingTotem",
			[8177] = "grounding",
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
			[8170] = "diseaseCleansingTotem",
			[2062] = "earthElemental",
			[2894] = "fireElemental",
			[2825] = "bloodlust",
			[32182] = "bloodlust", -- Heroism
			[16190] = "manaTideTotem",

			-- Warlock (Cast Success)
			[6789] = "mortalCoil", -- Rank 1
			[17925] = "mortalCoil", -- Rank 2
			[17926] = "mortalCoil", -- Rank 3
			[27223] = "mortalCoil", -- Rank 4


			-- Warrior (Cast Success)
			[676] = "disarm",
			[5246] = "Fear3",
			[6552] = "pummel", -- Rank 1
			[6554] = "pummel", -- Rank 2
			[72] = "shieldBash", -- Rank 1
			[1671] = "shieldBash", -- Rank 2
			[1672] = "shieldBash", -- Rank 3
			[29704] = "shieldBash", -- Rank 4
			[100] = "charge", -- Rank 1
			[6178] = "charge", -- Rank 2
			[11578] = "charge", -- Rank 3
			[20252] = "intercept", -- Rank 1
			[20616] = "intercept", -- Rank 2
			[20617] = "intercept", -- Rank 3
			[25272] = "intercept", -- Rank 4
			[25275] = "intercept", -- Rank 5
			[3411] = "intervene",
			[12328] = "sweepingStrikes",
			[12809] = "concussionBlow",
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
