-- $Id: Data.lua 73 2022-08-22 16:04:24Z arithmandar $
--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2011 ~ 2022 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs = _G.pairs
-- Libraries

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local LibStub = _G.LibStub
local BZ = Atlas_GetLocaleLibBabble("LibBabble-SubZone-3.0")
local BF = Atlas_GetLocaleLibBabble("LibBabble-Faction-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local ALC = LibStub("AceLocale-3.0"):GetLocale("Atlas")
local ALIL = Atlas_IngameLocales
local Atlas = LibStub("AceAddon-3.0"):GetAddon("Atlas")
local addon = Atlas:GetModule(private.module_name)


local function Atlas_GetBossName(bossname, encounterID, creatureIndex)
	return Atlas:GetBossName(bossname, encounterID, creatureIndex, private.module_name)
end

local db = {}
addon.db = db

local BLUE = "|cff6666ff"
local GREN = "|cff66cc33"
local GREY = "|cff999999"
local LBLU = "|cff33cccc"
local _RED = "|cffcc3333"
local ORNG = "|cffcc9933"
local PINK = "|ccfcc33cc"
local PURP = "|cff9900ff"
local WHIT = "|cffffffff"
local YLOW = "|cffcccc33"
local INDENT = "      "

db.AtlasMaps = {
	AuchindounEnt = {
		ZoneName = { BZ["Auchindoun"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Terokkar Forest"] },
		LevelRange = "64-75",
		MinLevel = "62",
		PlayerLimit = { 5 },
		Acronym = L["Auch"],
		Module = "Atlas_BurningCrusade",
		{ BLUE.." A) "..BZ["Auchenai Crypts"], 10001 },
		{ BLUE.." B) "..BZ["Mana-Tombs"], 10002 },
		{ BLUE.." C) "..BZ["Sethekk Halls"], 10003 },
		{ BLUE.." D) "..BZ["Shadow Labyrinth"], 10004 },
		{ BLUE.." E) "..ALC["Entrance"], 10005 },
		{ GREN.." 1') "..L["Clarissa"], 10006 },
		{ GREN..INDENT..L["Greatfather Aldrimus"] },
		{ GREN..INDENT..L["Ha'lei"] },
		{ GREN..INDENT..L["Horvon the Armorer <Armorsmith>"] },
		{ GREN..INDENT..L["Ramdor the Mad"] },
		{ GREN.." 2') "..L["Nexus-Prince Haramad"], 10007 },
		{ GREN..INDENT..L["\"Slim\" <Shady Dealer>"] },
		{ GREN..INDENT..L["\"Captain\" Kaftiz"] },
		{ GREN.." 3') "..L["Dealer Tariq <Shady Dealer>"], 10008 },
		{ GREN..INDENT..L["Provisioner Tsaalt"] },
		{ GREN.." 4') "..ALC["Meeting Stone"], 10009 },
	},
	AuchAuchenaiCrypts = {
		ZoneName = { BZ["Auchindoun"]..ALC["Colon"]..BZ["Auchenai Crypts"] },
		Location = { BZ["Terokkar Forest"] },
		DungeonID = 149,
		DungeonHeroicID = 178,
		Acronym = L["AC"],
		WorldMapID = 256,
		JournalInstanceID = 247,
		Module = "Atlas_BurningCrusade",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Lower City"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ GREN..INDENT..L["Draenei Spirit"] },
		{ WHIT.." 1) "..Atlas_GetBossName("Shirrak the Dead Watcher", 523), 523 },
		{ WHIT.." 2) "..Atlas_GetBossName("Exarch Maladaar", 524), 524 },
		{ WHIT..INDENT..L["Avatar of the Martyred"] },
		{ GREN..INDENT..L["D'ore"] },
		{ GREN.." 1') "..L["Tormented Soulpriest"], 10002 },
	},
	AuchManaTombs = {
		ZoneName = { BZ["Auchindoun"]..ALC["Colon"]..BZ["Mana-Tombs"] },
		Location = { BZ["Terokkar Forest"] },
		DungeonID = 148,
		DungeonHeroicID = 179,
		Acronym = L["MT"],
		WorldMapID = 272,
		JournalInstanceID = 250,
		Module = "Atlas_BurningCrusade",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["The Consortium"] },
		{ ORNG..L["Key"]..ALC["Colon"]..ALIL["The Eye of Haramad"]..ALC["L-Parenthesis"]..ALC["Exalted"]..ALC["Comma"]..Atlas_GetBossName("Yor")..ALC["R-Parenthesis"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ GREN..INDENT..L["Artificer Morphalius"] },
		{ GREN..INDENT..L["Mamdy the \"Ologist\""] },
		{ WHIT.." 1) "..Atlas_GetBossName("Pandemonius", 534), 534 },
		{ ORNG..INDENT..L["Shadow Lord Xiraxis"]..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"] },
		{ WHIT.." 2) "..Atlas_GetBossName("Tavarok", 535), 535 },
		{ WHIT.." 3) "..Atlas_GetBossName("Nexus-Prince Shaffar", 537), 537 },
		{ ORNG..INDENT..Atlas_GetBossName("Yor", 536)..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["Comma"]..ALC["Heroic"]..ALC["R-Parenthesis"], 536 },
		{ GREN.." 1') "..L["Ambassador Pax'ivi"]..ALC["L-Parenthesis"]..ALC["Heroic"]..ALC["R-Parenthesis"], 10002 },
		{ GREN.." 2') "..L["Cryo-Engineer Sha'heen"], 10003 },
		{ GREN..INDENT..L["Ethereal Transporter Control Panel"] },
	},
	AuchSethekkHalls = {
		ZoneName = { BZ["Auchindoun"]..ALC["Colon"]..BZ["Sethekk Halls"] },
		Location = { BZ["Terokkar Forest"] },
		DungeonID = 150,
		DungeonHeroicID = 180,
		Acronym = L["Seth"],
		WorldMapID = 258,
		JournalInstanceID = 252,
		Module = "Atlas_BurningCrusade",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Lower City"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ GREN..INDENT..L["Isfar"] },
		{ WHIT.." 1) "..Atlas_GetBossName("Darkweaver Syth", 541), 541 },
		{ GREN..INDENT..L["Dealer Vijaad"] },
		{ GREN..INDENT..L["Lakka"] },
		{ WHIT.." 2) "..Atlas_GetBossName("Anzu", 542)..ALC["L-Parenthesis"]..ALC["Heroic"]..ALC["R-Parenthesis"], 542 },
		{ GREN..INDENT..L["The Saga of Terokk"] },
		{ WHIT.." 3) "..Atlas_GetBossName("Talon King Ikiss", 543), 543 },
	},
	AuchShadowLabyrinth = {
		ZoneName = { BZ["Auchindoun"]..ALC["Colon"]..BZ["Shadow Labyrinth"] },
		Location = { BZ["Terokkar Forest"] },
		DungeonID = 151,
		DungeonHeroicID = 181,
		Acronym = L["SL"],
		WorldMapID = 260,
		JournalInstanceID = 253,
		Module = "Atlas_BurningCrusade",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Lower City"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ GREN..INDENT..L["Field Commander Mahfuun"] },
		{ GREN..INDENT..L["Spy Grik'tha"] },
		{ WHIT.." 1) "..Atlas_GetBossName("Ambassador Hellmaw", 544), 544 },
		{ WHIT.." 2) "..Atlas_GetBossName("Blackheart the Inciter", 545), 545 },
		{ WHIT.." 3) "..Atlas_GetBossName("Grandmaster Vorpil", 546), 546 },
		{ GREN..INDENT..L["The Codex of Blood"] },
		{ WHIT.." 4) "..Atlas_GetBossName("Murmur", 547), 547 },
		{ ORNG.." 1) "..L["First Fragment Guardian"], 10002 },
		{ GREN..INDENT..ALC["Arcane Container"] },
		{ GREN.." 1') "..L["Spy To'gun"], 10003 },
	},
	BlackTempleStart = {
		ZoneName = { BZ["Black Temple"]..ALC["MapA"]..ALC["L-Parenthesis"]..ALC["Start"]..ALC["R-Parenthesis"] },
		Location = { BZ["Shadowmoon Valley"] },
		DungeonID = 196,
		Acronym = L["BT"],
		PlayerLimit = { 25 },
		WorldMapID = 339,
		DungeonLevel = 1,
		JournalInstanceID = 751,
		PlayerLimit = { 10, 30 },
		Module = "Atlas_BurningCrusade",
		NextMap = "BlackTempleBasement",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Ashtongue Deathsworn"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ BLUE.." B) "..L["Towards Reliquary of Souls"], 10002 },
		{ BLUE.." C) "..L["Towards Teron Gorefiend"], 10003 },
		{ BLUE.." D) "..L["Towards Illidan Stormrage"], 10004 },
		{ WHIT.." 1) "..Atlas_GetBossName("High Warlord Naj'entus", 1582), 1582 },
		{ WHIT.." 2) "..Atlas_GetBossName("Supremus", 1583), 1583 },
		{ WHIT.." 3) "..Atlas_GetBossName("Shade of Akama", 1584), 1584 },
		{ GREN.." 1') "..L["Spirit of Olum"], 10008 },
		{ GREN.." 2') "..L["Spirit of Udalo"], 10009 },
		{ GREN..INDENT..L["Aluyen <Reagents>"] },
		{ GREN..INDENT..L["Okuno <Ashtongue Deathsworn Quartermaster>"] },
		{ GREN..INDENT..L["Seer Kanai"] },
	},
	BlackTempleBasement = {
		ZoneName = { BZ["Black Temple"]..ALC["MapB"]..ALC["L-Parenthesis"]..ALC["Basement"]..ALC["R-Parenthesis"] },
		Location = { BZ["Shadowmoon Valley"] },
		DungeonID = 196,
		Acronym = L["BT"],
		PlayerLimit = { 25 },
		WorldMapID = 342,
		DungeonLevel = 4,
		JournalInstanceID = 751,
		PlayerLimit = { 10, 30 },
		Module = "Atlas_BurningCrusade",
		PrevMap = "BlackTempleStart",
		NextMap = "BlackTempleTop",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Ashtongue Deathsworn"] },
		{ BLUE.." B) "..ALC["Entrance"], 10001 },
		{ BLUE.." C) "..ALC["Entrance"], 10002 },
		{ WHIT.." 4) "..Atlas_GetBossName("Gurtogg Bloodboil", 1586), 1586 },
		{ WHIT.." 5) "..Atlas_GetBossName("Reliquary of Souls", 1587), 1587 },
		{ WHIT..INDENT..Atlas_GetBossName("Essence of Suffering", 1587, 1) },
		{ WHIT..INDENT..Atlas_GetBossName("Essence of Desire", 1587, 2) },
		{ WHIT..INDENT..Atlas_GetBossName("Essence of Anger", 1587, 3) },
		{ WHIT.." 6) "..Atlas_GetBossName("Teron Gorefiend", 1585), 1585 },
	},
	BlackTempleTop = {
		ZoneName = { BZ["Black Temple"]..ALC["MapC"]..ALC["L-Parenthesis"]..ALC["Top"]..ALC["R-Parenthesis"] },
		Location = { BZ["Shadowmoon Valley"] },
		DungeonID = 196,
		Acronym = L["BT"],
		PlayerLimit = { 25 },
		WorldMapID = 346,
		DungeonLevel = 8,
		JournalInstanceID = 751,
		PlayerLimit = { 10, 30 },
		Module = "Atlas_BurningCrusade",
		PrevMap = "BlackTempleBasement",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Ashtongue Deathsworn"] },
		{ BLUE.." D) "..ALC["Entrance"], 10001 },
		{ BLUE.." E) "..ALC["Connection"], 10002 },
		{ WHIT.." 7) "..Atlas_GetBossName("Mother Shahraz", 1588), 1588 },
		{ WHIT.." 8) "..Atlas_GetBossName("The Illidari Council", 1589), 1589 },
		{ WHIT..INDENT..Atlas_GetBossName("Gathios the Shatterer", 1589, 1)..ALC["L-Parenthesis"]..Atlas_GetClassName("PALADIN")..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..Atlas_GetBossName("High Nethermancer Zerevor", 1589, 2)..ALC["L-Parenthesis"]..Atlas_GetClassName("MAGE")..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..Atlas_GetBossName("Lady Malande", 1589, 3)..ALC["L-Parenthesis"]..Atlas_GetClassName("PRIEST")..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..Atlas_GetBossName("Veras Darkshadow", 1589, 4)..ALC["L-Parenthesis"]..Atlas_GetClassName("ROGUE")..ALC["R-Parenthesis"] },
		{ WHIT.." 9) "..Atlas_GetBossName("Illidan Stormrage", 1590), 1590 },
	},
	CoilfangReservoirEnt = {
		ZoneName = { BZ["Coilfang Reservoir"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Zangarmarsh"] },
		LevelRange = "62-73",
		MinLevel = "61",
		PlayerLimit = { 5, 25},
		Acronym = L["CR"],
		Module = "Atlas_BurningCrusade",
		{ BLUE.." A) "..BZ["The Slave Pens"], 10001 },
		{ BLUE.." B) "..BZ["The Steamvault"], 10002 },
		{ BLUE.." C) "..BZ["Serpentshrine Cavern"], 10003 },
		{ BLUE.." D) "..BZ["The Underbog"], 10004 },
		{ BLUE.." E) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Underwater"]..ALC["R-Parenthesis"], 10005 },
		{ GREN.." 1') "..ALC["Meeting Stone"], 10006 },
		{ GREN.." 2') "..L["Mortog Steamhead"], 10007 },
	},
	CFRSerpentshrineCavern = {
		ZoneName = { BZ["Coilfang Reservoir"]..ALC["Colon"]..BZ["Serpentshrine Cavern"] },
		Location = { BZ["Zangarmarsh"] },
		DungeonID = 194,
		Acronym = L["SSC"],
		PlayerLimit = { 25 },
		WorldMapID = 332,
		JournalInstanceID = 748,
		Module = "Atlas_BurningCrusade",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Cenarion Expedition"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ BLUE.." B) "..ALC["Elevator"], 10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Hydross the Unstable", 1567), 1567 },
		{ WHIT.." 2) "..Atlas_GetBossName("The Lurker Below", 1568), 1568 },
		{ WHIT.." 3) "..Atlas_GetBossName("Leotheras the Blind", 1569), 1569 },
		{ WHIT.." 4) "..Atlas_GetBossName("Fathom-Lord Karathress", 1570), 1570 },
		{ GREN..INDENT..L["Seer Olum"] },
		{ WHIT.." 5) "..Atlas_GetBossName("Morogrim Tidewalker", 1571), 1571 },
		{ WHIT.." 6) "..Atlas_GetBossName("Lady Vashj", 1572), 1572 },
	},
	CFRTheSlavePens = {
		ZoneName = { BZ["Coilfang Reservoir"]..ALC["Colon"]..BZ["The Slave Pens"] },
		Location = { BZ["Zangarmarsh"] },
		DungeonID = 140,
		DungeonHeroicID = 184,
		Acronym = L["SP"],
		WorldMapID = 265,
		JournalInstanceID = 260,
		Module = "Atlas_BurningCrusade",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Cenarion Expedition"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ GREN..INDENT..L["Nahuud"] },
		{ GREN..INDENT..L["Watcher Jhang"] },
		{ WHIT.." 1) "..Atlas_GetBossName("Mennu the Betrayer", 570), 570 },
		{ WHIT.." 2) "..Atlas_GetBossName("Rokmar the Crackler", 571), 571 },
		{ WHIT.." 3) "..Atlas_GetBossName("Quagmirran", 572), 572 },
		{ ORNG.." 1) "..Atlas_GetBossName("Ahune")..ALC["L-Parenthesis"]..ALC["Midsummer Festival"]..ALC["R-Parenthesis"], 10002 },
		{ GREN.." 1') "..L["Weeder Greenthumb"], 10003 },
		{ GREN.." 2') "..L["Skar'this the Heretic"]..ALC["L-Parenthesis"]..ALC["Heroic"]..ALC["R-Parenthesis"], 10004 },
		{ GREN.." 3') "..L["Naturalist Bite"], 10005 },
	},
	CFRTheSteamvault = {
		ZoneName = { BZ["Coilfang Reservoir"]..ALC["Colon"]..BZ["The Steamvault"] },
		Location = { BZ["Zangarmarsh"] },
		DungeonID = 147,
		DungeonHeroicID = 185,
		Acronym = L["SV"],
		WorldMapID = 263,
		JournalInstanceID = 261,
		Module = "Atlas_BurningCrusade",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Cenarion Expedition"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ GREN..INDENT..L["Naturalist Bite"] },
		{ GREN..INDENT..L["Watcher Jhang"] },
		{ GREN..INDENT..L["Windcaller Claw"] },
		{ WHIT.." 1) "..Atlas_GetBossName("Hydromancer Thespia", 573), 573 },
		{ GREN..INDENT..L["Main Chambers Access Panel"] },
		{ WHIT.." 2) "..Atlas_GetBossName("Mekgineer Steamrigger", 574), 574 },
		{ GREN..INDENT..L["Main Chambers Access Panel"] },
		{ WHIT.." 3) "..Atlas_GetBossName("Warlord Kalithresh", 575), 575 },
		{ ORNG.." 1) "..L["Second Fragment Guardian"], 10002 },
		{ GREN..INDENT..ALC["Arcane Container"] },
	},
	CFRTheUnderbog = {
		ZoneName = { BZ["Coilfang Reservoir"]..ALC["Colon"]..BZ["The Underbog"] },
		Location = { BZ["Zangarmarsh"] },
		DungeonID = 146,
		DungeonHeroicID = 186,
		Acronym = L["UB"],
		WorldMapID = 262,
		JournalInstanceID = 262,
		Module = "Atlas_BurningCrusade",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Cenarion Expedition"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ GREN..INDENT..L["Naturalist Bite"] },
		{ GREN..INDENT..L["T'shu"] },
		{ GREN..INDENT..L["Watcher Jhang"] },
		{ WHIT.." 1) "..Atlas_GetBossName("Hungarfen", 576), 576 },
		{ GREN..INDENT..L["The Underspore"] },
		{ WHIT.." 2) "..Atlas_GetBossName("Ghaz'an", 577), 577 },
		{ WHIT.." 3) "..Atlas_GetBossName("Swamplord Musel'ek", 578), 578 },
		{ WHIT..INDENT..Atlas_GetBossName("Claw") },
		{ WHIT.." 4) "..Atlas_GetBossName("The Black Stalker", 579), 579 },
		{ GREN.." 1') "..L["Earthbinder Rayge"], 10002 },
	},
	CavernsOfTimeEnt = {
		ZoneName = { BZ["Caverns of Time"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Tanaris"] },
		LevelRange = "66-85+",
		MinLevel = "66",
		PlayerLimit = { 5, 10, 25},
		Acronym = L["CoT"],
		Module = "Atlas_BurningCrusade",
		{ BLUE.." A) "..L["Entrance"], 10001 },
		{ BLUE.." B) "..BZ["Hyjal Summit"], 10002 },
		{ BLUE.." C) "..BZ["Old Hillsbrad Foothills"], 10003 },
		{ BLUE.." D) "..BZ["The Black Morass"], 10004 },
		{ BLUE.." E) "..BZ["The Culling of Stratholme"], 10005 },
		{ BLUE.." F) "..BZ["Dragon Soul"], 10006 },
		{ BLUE.." G) "..BZ["End Time"], 10007 },
		{ BLUE.." H) "..BZ["Well of Eternity"], 10008 },
		{ BLUE.." I) "..BZ["Hour of Twilight"], 10009 },
		{ GREN.." 1') "..L["Steward of Time <Keepers of Time>"], 10010 },
		{ GREN.." 2') "..L["Alexston Chrome <Tavern of Time>"], 10011 },
		{ GREN.." 3') "..L["Graveyard"], 10012 },
		{ GREN.." 4') "..L["Yarley <Armorer>"], 10013 },
		{ GREN.." 5') "..L["Bortega <Reagents & Poison Supplies>"], 10014 },
		{ GREN..INDENT..L["Alurmi <Keepers of Time Quartermaster>"] },
		{ GREN..INDENT..L["Galgrom <Provisioner>"] },
		{ GREN.." 6') "..L["Zaladormu"], 10015 },
		{ GREN..INDENT..L["Soridormi <The Scale of Sands>"]..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Arazmodu <The Scale of Sands>"]..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"] },
		{ GREN.." 7') "..L["Moonwell"], 10016 },
		{ GREN.." 8') "..L["Andormu <Keepers of Time>"]..ALC["L-Parenthesis"]..ALC["Child"]..ALC["R-Parenthesis"], 10017 },
		{ GREN..INDENT..L["Nozari <Keepers of Time>"]..ALC["L-Parenthesis"]..ALC["Child"]..ALC["R-Parenthesis"] },
		{ GREN.." 9') "..L["Anachronos <Keepers of Time>"], 10018 },
		{ GREN.."10') "..L["Andormu <Keepers of Time>"]..ALC["L-Parenthesis"]..ALC["Adult"]..ALC["R-Parenthesis"], 10019 },
		{ GREN..INDENT..L["Nozari <Keepers of Time>"]..ALC["L-Parenthesis"]..ALC["Adult"]..ALC["R-Parenthesis"] },
	},
	CoTBlackMorass = {
		ZoneName = { BZ["Caverns of Time"]..ALC["Colon"]..BZ["The Black Morass"] },
		Location = { BZ["Tanaris"] },
		LevelRange = "68-75",
		MinLevel = "68",
		PlayerLimit = { 5 },
		Acronym = L["CoT2"],
		WorldMapID = 273,
		JournalInstanceID = 255,
		Module = "Atlas_BurningCrusade",
		{ PURP..ALC["Event"]..ALC["Colon"]..BZ["Opening of the Dark Portal"] },
		{ ORNG..ALC["Attunement Required"] },
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Keepers of Time"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ GREN..INDENT..L["Sa'at <Keepers of Time>"] },
		{ ORNG.." X) "..ALC["Portal"]..ALC["L-Parenthesis"]..ALC["Spawn Point"]..ALC["R-Parenthesis"], 10002 },
		{ WHIT..INDENT..ALC["Wave 6"]..ALC["Colon"]..Atlas_GetBossName("Chrono Lord Deja", 552), 552 },
		{ WHIT..INDENT..ALC["Wave 12"]..ALC["Colon"]..Atlas_GetBossName("Temporus", 553), 553 },
		{ WHIT..INDENT..ALC["Wave 18"]..ALC["Colon"]..Atlas_GetBossName("Aeonus", 554), 554 },
		{ GREN.." 1') "..BZ["The Dark Portal"], 10003 },
		{ GREN..INDENT..Atlas_GetBossName("Medivh") },
	},
	CoTHyjalEnt = {
		ZoneName = { BZ["Caverns of Time"]..ALC["Colon"]..BZ["Hyjal Summit"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Tanaris"] },
		LevelRange = "70-73",
		MinLevel = "70",
		PlayerLimit = { 25 },
		Acronym = L["CoT3"],
		Module = "Atlas_BurningCrusade",
		{ PURP..ALC["Event"]..ALC["Colon"]..BZ["The Battle for Mount Hyjal"] },
		{ ORNG..REPUTATION..ALC["Colon"]..BF["The Scale of the Sands"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ BLUE.." B) "..BZ["Alliance Base"], 10002 },
		{ BLUE.." C) "..BZ["Horde Encampment"], 10003 },
		{ BLUE.." D) "..BZ["Night Elf Village"], 10004 },
		{ GREN.." 1') "..L["Indormi <Keeper of Ancient Gem Lore>"], 10005 },
		{ GREN..INDENT..L["Tydormu <Keeper of Lost Artifacts>"] },
	},
	CoTHyjal = {
		ZoneName = { BZ["Caverns of Time"]..ALC["Colon"]..BZ["Hyjal Summit"] },
		Location = { BZ["Tanaris"] },
		LevelRange = "70-73",
		MinLevel = "70",
		PlayerLimit = { 25 },
		Acronym = L["CoT3"],
		WorldMapID = 329,
		JournalInstanceID = 750,
		Module = "Atlas_BurningCrusade",
		{ PURP..ALC["Event"]..ALC["Colon"]..BZ["The Battle for Mount Hyjal"] },
		{ ORNG..REPUTATION..ALC["Colon"]..BF["The Scale of the Sands"] },
		{ BLUE.." A) "..BZ["Alliance Base"], 10001 },
		{ GREN..INDENT..L["Lady Jaina Proudmoore"] },
		{ BLUE.." B) "..BZ["Horde Encampment"], 10002 },
		{ GREN..INDENT..L["Thrall <Warchief>"] },
		{ BLUE.." C) "..BZ["Night Elf Village"], 10003 },
		{ GREN..INDENT..L["Tyrande Whisperwind <High Priestess of Elune>"] },
		{ WHIT.." 1) "..Atlas_GetBossName("Rage Winterchill", 1577), 1577 },
		{ WHIT.." 2) "..Atlas_GetBossName("Anetheron", 1578), 1578 },
		{ WHIT.." 3) "..Atlas_GetBossName("Kaz'rogal", 1579), 1579 },
		{ WHIT.." 4) "..Atlas_GetBossName("Azgalor", 1580), 1580 },
		{ WHIT.." 5) "..Atlas_GetBossName("Archimonde", 1581), 1581 },
	},
	CoTOldHillsbrad = {
		ZoneName = { BZ["Caverns of Time"]..ALC["Colon"]..BZ["Old Hillsbrad Foothills"] },
		Location = { BZ["Tanaris"] },
		LevelRange = "66-68 / 70",
		MinLevel = "66",
		PlayerLimit = { 5 },
		Acronym = L["CoT1"],
		WorldMapID = 274,
		JournalInstanceID = 251,
		Module = "Atlas_BurningCrusade",
		{ PURP..ALC["Event"]..ALC["Colon"]..BZ["The Escape From Durnholde"] },
		{ ORNG..ALC["Attunement Required"] },
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Keepers of Time"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ GREN..INDENT..L["Erozion"] },
		{ GREN..INDENT..L["Brazen"] },
		{ BLUE.." B) "..L["Landing Spot"], 10002 },
		{ BLUE.." C) "..BZ["Southshore"], 10003 },
		{ BLUE.." D) "..BZ["Tarren Mill"], 10004 },
		{ WHIT.." 1) "..Atlas_GetBossName("Lieutenant Drake", 538), 538 },
		{ GREN.." 1') "..L["Thrall"]..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["R-Parenthesis"], 10005 },
		{ WHIT.." 2) "..Atlas_GetBossName("Captain Skarloc", 539), 539 },
		{ GREN..INDENT..L["Thrall"]..ALC["L-Parenthesis"]..ALC["Second Stop"]..ALC["R-Parenthesis"] },
		{ GREN.." 2') "..L["Thrall"]..ALC["L-Parenthesis"]..ALC["Third Stop"]..ALC["R-Parenthesis"], 10006 },
		{ WHIT.." 3) "..Atlas_GetBossName("Epoch Hunter", 540), 540 },
		{ GREN..INDENT..L["Thrall"]..ALC["L-Parenthesis"]..ALC["Fourth Stop"]..ALC["Comma"]..ALC["Upper"]..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Taretha"]..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"] },
		{ WHIT.." 4) "..L["Don Carlos"]..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"], 10007 },
		{ WHIT..INDENT..INDENT..L["Guerrero"]..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Thomas Yance <Travelling Salesman>"]..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Aged Dalaran Wizard"]..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"] },
		{ GREN.." 3') "..L["Jonathan Revah"], 10008 },
		{ GREN..INDENT..L["Jerry Carter"] },
		{ "" },
		{ "" },
		{ "" },
		{ ORNG..BZ["Southshore"] },
		{ GREN..INDENT..Atlas_GetBossName("Kel'Thuzad") },
		{ GREN..INDENT..L["Helcular"] },
		{ GREN..INDENT..L["Farmer Kent"] },
		{ GREN..INDENT..L["Sally Whitemane"] },
		{ GREN..INDENT..L["Renault Mograine"] },
		{ GREN..INDENT..L["Little Jimmy Vishas"] },
		{ GREN..INDENT..L["Herod the Bully"] },
		{ GREN..INDENT..L["Nat Pagle"] },
		{ GREN..INDENT..L["Hal McAllister"] },
		{ GREN..INDENT..L["Zixil <Aspiring Merchant>"] },
		{ GREN..INDENT..L["Overwatch Mark 0 <Protector>"] },
		{ "" },
		{ ORNG..L["Southshore Inn"] },
		{ GREN..INDENT..L["Captain Edward Hanes"] },
		{ GREN..INDENT..L["Captain Sanders"] },
		{ GREN..INDENT..L["Commander Mograine"] },
		{ GREN..INDENT..L["Isillien"] },
		{ GREN..INDENT..L["Abbendis"] },
		{ GREN..INDENT..L["Fairbanks"] },
		{ GREN..INDENT..Atlas_GetBossName("Tirion Fordring") },
		{ GREN..INDENT..Atlas_GetBossName("Arcanist Doan") },
		{ GREN..INDENT..L["Taelan"]..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Barkeep Kelly <Bartender>"] },
		{ GREN..INDENT..L["Frances Lin <Barmaid>"] },
		{ GREN..INDENT..L["Chef Jessen <Speciality Meat & Slop>"] },
		{ GREN..INDENT..L["Stalvan Mistmantle"]..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Phin Odelic <The Kirin Tor>"]..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"] },
		{ "" },
		{ ORNG..BZ["Southshore Town Hall"] },
		{ GREN..INDENT..L["Magistrate Henry Maleb"] },
		{ GREN..INDENT..L["Raleigh the True"] },
		{ GREN..INDENT..L["Nathanos Marris"] },
		{ GREN..INDENT..L["Bilger the Straight-laced"] },
		{ "" },
		{ ORNG..BZ["Tarren Mill"] },
		{ GREN..INDENT..L["Innkeeper Monica"] },
		{ GREN..INDENT..L["Julie Honeywell"] },
		{ GREN..INDENT..L["Jay Lemieux"] },
		{ GREN..INDENT..L["Young Blanchy"] },
	},
	GruulsLair = {
		ZoneName = { BZ["Gruul's Lair"] },
		Location = { BZ["Blade's Edge Mountains"] },
		DungeonID = 177,
		Acronym = L["GL"],
		PlayerLimit = { 25 },
		WorldMapID = 330,
		JournalInstanceID = 746,
		Module = "Atlas_BurningCrusade",
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("High King Maulgar", 1564), 1564 },
		{ WHIT..INDENT..Atlas_GetBossName("Kiggler the Crazed", 1564, 2)..ALC["L-Parenthesis"]..Atlas_GetClassName("SHAMAN")..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..Atlas_GetBossName("Blindeye the Seer", 1564, 3)..ALC["L-Parenthesis"]..Atlas_GetClassName("PRIEST")..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..Atlas_GetBossName("Olm the Summoner", 1564, 4)..ALC["L-Parenthesis"]..Atlas_GetClassName("WARLOCK")..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..Atlas_GetBossName("Krosh Firehand", 1564, 5)..ALC["L-Parenthesis"]..Atlas_GetClassName("MAGE")..ALC["R-Parenthesis"] },
		{ WHIT.." 2) "..Atlas_GetBossName("Gruul the Dragonkiller", 1565), 1565 },
	},
	HellfireCitadelEnt = {
		ZoneName = { BZ["Hellfire Citadel"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Hellfire Peninsula"] },
		LevelRange = "59-73",
		MinLevel = "57",
		PlayerLimit = { 5, 25},
		Acronym = L["HC"],
		Module = "Atlas_BurningCrusade",
		{ BLUE.." A) "..BZ["Hellfire Ramparts"], 10001 },
		{ BLUE.." B) "..BZ["The Shattered Halls"], 10002 },
		{ BLUE.." C) "..BZ["The Blood Furnace"], 10003 },
		{ BLUE.." D) "..BZ["Magtheridon's Lair"], 10004 },
		{ GREN.." 1') "..L["Meeting Stone of Magtheridon's Lair"], 10005 },
		{ GREN.." 2') "..L["Meeting Stone of Hellfire Citadel"], 10006 },
		{ GREN.." 3') "..L["Steps and path to the Blood Furnace"], 10007 },
		{ GREN.." 4') "..L["Path to the Hellfire Ramparts and Shattered Halls"], 10008 },
	},
	HCBloodFurnace = {
		ZoneName = { BZ["Hellfire Citadel"]..ALC["Colon"]..BZ["The Blood Furnace"] },
		Location = { BZ["Hellfire Peninsula"] },
		DungeonID = 137,
		DungeonHeroicID = 187,
		Acronym = L["BF"],
		WorldMapID = 261,
		JournalInstanceID = 256,
		Module = "Atlas_BurningCrusade",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Honor Hold"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Thrallmar"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ GREN..INDENT..L["Gunny"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Caza'rez"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ WHIT.." 1) "..Atlas_GetBossName("The Maker", 555), 555 },
		{ WHIT.." 2) "..Atlas_GetBossName("Broggok", 556), 556 },
		{ WHIT.." 3) "..Atlas_GetBossName("Keli'dan the Breaker", 557), 557 },
	},
	HCHellfireRamparts = {
		ZoneName = { BZ["Hellfire Citadel"]..ALC["Colon"]..BZ["Hellfire Ramparts"] },
		Location = { BZ["Hellfire Peninsula"] },
		DungeonID = 136,
		DungeonHeroicID = 188,
		Acronym = L["Ramp"],
		WorldMapID = 347,
		JournalInstanceID = 248,
		Module = "Atlas_BurningCrusade",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Honor Hold"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Thrallmar"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ GREN..INDENT..L["Advance Scout Chadwick"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Stone Guard Stok'ton"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ WHIT.." 1) "..Atlas_GetBossName("Watchkeeper Gargolmar", 527), 527 },
		{ WHIT.." 2) "..Atlas_GetBossName("Omor the Unscarred", 528), 528 },
		{ WHIT.." 3) "..Atlas_GetBossName("Vazruden the Herald", 529), 529 },
		{ WHIT..INDENT..Atlas_GetBossName("Nazan") },
		{ GREN..INDENT..L["Reinforced Fel Iron Chest"] },
	},
	HCMagtheridonsLair = {
		ZoneName = { BZ["Hellfire Citadel"]..ALC["Colon"]..BZ["Magtheridon's Lair"] },
		Location = { BZ["Hellfire Peninsula"] },
		DungeonID = 176,
		Acronym = L["Mag"],
		PlayerLimit = { 25 },
		WorldMapID = 331,
		JournalInstanceID = 747,
		Module = "Atlas_BurningCrusade",
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Magtheridon", 1566), 1566 },
	},
	HCTheShatteredHalls = {
		ZoneName = { BZ["Hellfire Citadel"]..ALC["Colon"]..BZ["The Shattered Halls"] },
		Location = { BZ["Hellfire Peninsula"] },
		DungeonID = 138,
		DungeonHeroicID = 189,
		Acronym = L["SH"],
		WorldMapID = 246,
		JournalInstanceID = 259,
		Module = "Atlas_BurningCrusade",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Honor Hold"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Thrallmar"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ GREN..INDENT..L["Advance Scout Chadwick"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Gunny"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Caza'rez"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Stone Guard Stok'ton"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ WHIT.." 1) "..Atlas_GetBossName("Grand Warlock Nethekurse", 566), 566 },
		{ WHIT.." 2) "..Atlas_GetBossName("Blood Guard Porung", 728)..ALC["L-Parenthesis"]..ALC["Heroic"]..ALC["R-Parenthesis"], 728 },
		{ WHIT.." 3) "..Atlas_GetBossName("Warbringer O'mrogg", 568), 568 },
		{ WHIT.." 4) "..Atlas_GetBossName("Warchief Kargath Bladefist", 569), 569 },
		{ WHIT..INDENT..L["Shattered Hand Executioner"]..ALC["L-Parenthesis"]..ALC["Heroic"]..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Private Jacint"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["Comma"]..ALC["Heroic"]..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Rifleman Brownbeard"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["Comma"]..ALC["Heroic"]..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Captain Alina"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["Comma"]..ALC["Heroic"]..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Scout Orgarr"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["Comma"]..ALC["Heroic"]..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Korag Proudmane"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["Comma"]..ALC["Heroic"]..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Captain Boneshatter"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["Comma"]..ALC["Heroic"]..ALC["R-Parenthesis"] },
		{ GREN.." 1') "..L["Randy Whizzlesprocket"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["Comma"]..ALC["Heroic"]..ALC["R-Parenthesis"], 10002 },
		{ GREN..INDENT..L["Drisella"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["Comma"]..ALC["Heroic"]..ALC["R-Parenthesis"] },
	},
	KarazhanEnt = {
		ZoneName = { BZ["Karazhan"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Deadwind Pass"] },
		DungeonID = 175,
		PlayerLimit = { 10 },
		Acronym = L["Kara"],
		WorldMapID = 42,
		JournalInstanceID = 745,
		Module = "Atlas_BurningCrusade",
		NextMap = "KarazhanStart",
		{ BLUE.." A) "..BZ["Karazhan"]..ALC["L-Parenthesis"]..ALC["Front"]..ALC["R-Parenthesis"], 10001 },
		{ BLUE.." B) "..BZ["Karazhan"]..ALC["L-Parenthesis"]..ALC["Back"]..ALC["R-Parenthesis"], 10002 },
		{ BLUE.." C) "..BZ["Return to Karazhan"]..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"], 10003 },
		{ GREN.." 1') "..L["Mage Darius"], 18255 },
		{ GREN.." 2') "..format(ALC["Stairs to %s"], BZ["The Master's Cellar"]), 10004 },
		{ GREN.." 3') "..format(ALC["Stairs to %s"], BZ["The Master's Cellar"]), 10005 },
		{ GREN.." 4') "..L["Charred Bone Fragment"], 10006 },
		{ GREN.." 5') "..ALC["Meeting Stone"], 10007 },
		{ GREN.." 6') "..ALC["Graveyard"], 10008 },
		{ GREN.." 7') "..L["Lydia Accoste"], 66255 },
	},
--    [799] = { mapFile = "Karazhan", [1] = 350, [2] = 351, [3] = 352, [4] = 353, [5] = 354, [6] = 355, [7] = 356, [8] = 357, [9] = 358, [10] = 359, [11] = 360, [12] = 361, [13] = 362, [14] = 363, [15] = 364, [16] = 365, [17] = 366},
	KarazhanStart = {
		ZoneName = { BZ["Karazhan"]..ALC["MapA"]..ALC["L-Parenthesis"]..ALC["Start"]..ALC["R-Parenthesis"] },
		Location = { BZ["Deadwind Pass"] },
		DungeonID = 175,
		Acronym = L["Kara"],
		PlayerLimit = { 10 },
		WorldMapID = 350,
		JournalInstanceID = 745,
		Module = "Atlas_BurningCrusade",
		PrevMap = "KarazhanEnt",
		NextMap = "KarazhanEnd",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["The Violet Eye"] },
		{ BLUE.." A) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Front"]..ALC["R-Parenthesis"], 10001 },
		{ BLUE.." B-J) "..ALC["Connection"], 10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Attumen the Huntsman", 1553), 1553 },
		{ WHIT..INDENT..Atlas_GetBossName("Midnight", 1553, 2) },
		{ WHIT.." 2) "..Atlas_GetBossName("Moroes", 1554), 1554 },
		{ WHIT..INDENT..L["Baroness Dorothea Millstipe"]..ALC["L-Parenthesis"]..ALC["Random"]..ALC["Comma"]..ALC["Shadow Priest"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..L["Lady Catriona Von'Indi"]..ALC["L-Parenthesis"]..ALC["Random"]..ALC["Comma"]..ALC["Holy Priest"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..L["Lady Keira Berrybuck"]..ALC["L-Parenthesis"]..ALC["Random"]..ALC["Comma"]..ALC["Holy Paladin"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..L["Baron Rafe Dreuger"]..ALC["L-Parenthesis"]..ALC["Random"]..ALC["Comma"]..ALC["Retribution Paladin"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..L["Lord Robin Daris"]..ALC["L-Parenthesis"]..ALC["Random"]..ALC["Comma"]..ALC["Arms Warrior"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..L["Lord Crispin Ference"]..ALC["L-Parenthesis"]..ALC["Random"]..ALC["Comma"]..ALC["Protection Warrior"]..ALC["R-Parenthesis"] },
		{ WHIT.." 3) "..Atlas_GetBossName("Maiden of Virtue", 1555), 1555 },
		{ WHIT.." 4) "..Atlas_GetBossName("Opera Hall", 1556), 1556 },
		{ ORNG..INDENT..L["Red Riding Hood"]..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..INDENT..Atlas_GetBossName("The Big Bad Wolf") },
		{ ORNG..INDENT..L["Wizard of Oz"]..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..INDENT..Atlas_GetBossName("Dorothee") },
		{ WHIT..INDENT..INDENT..Atlas_GetBossName("Tito") },
		{ WHIT..INDENT..INDENT..Atlas_GetBossName("Strawman") },
		{ WHIT..INDENT..INDENT..Atlas_GetBossName("Tinhead") },
		{ WHIT..INDENT..INDENT..Atlas_GetBossName("Roar") },
		{ WHIT..INDENT..INDENT..Atlas_GetBossName("The Crone", 1556, 4) },
		{ ORNG..INDENT..Atlas_GetBossName("Romulo & Julianne")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..INDENT..Atlas_GetBossName("Romulo", 1556, 2) },
		{ WHIT..INDENT..INDENT..Atlas_GetBossName("Julianne", 1556, 3) },
		{ WHIT.." 5 ) "..Atlas_GetBossName("Nightbane")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"], 10018 },
		{ GREN..INDENT..L["The Master's Terrace"] },
		{ ORNG.." 1) "..Atlas_GetBossName("Servant Quarters", 1552), 1552 },
		{ ORNG..INDENT..Atlas_GetBossName("Rokad the Ravager", 1552, 1)..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Random"]..ALC["R-Parenthesis"] },
		{ ORNG..INDENT..Atlas_GetBossName("Shadikith the Glider", 1552, 2)..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Random"]..ALC["R-Parenthesis"] },
		{ ORNG..INDENT..Atlas_GetBossName("Hyakiss the Lurker", 1552, 3)..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Random"]..ALC["R-Parenthesis"] },
		{ GREN.." 1') "..L["Hastings <The Caretaker>"], 10009 },
		{ GREN.." 2') "..L["Berthold <The Doorman>"], 10010 },
		{ GREN.." 3') "..L["Calliard <The Nightman>"], 10011 },
		{ GREN.." 4') "..L["Koren <The Blacksmith>"], 10012 },
		{ GREN.." 5') "..L["Bennett <The Sergeant at Arms>"], 10013 },
		{ GREN.." 6') "..L["Keanna's Log"], 10014 },
		{ GREN.." 7') "..L["Ebonlocke <The Noble>"], 10015 },
		{ GREN.." 8') "..L["Sebastian <The Organist>"], 10016 },
		{ GREN.." 9') "..L["Barnes <The Stage Manager>"], 10017 },
	},
	KarazhanEnd = {
		ZoneName = { BZ["Karazhan"]..ALC["MapB"]..ALC["L-Parenthesis"]..ALC["End"]..ALC["R-Parenthesis"] },
		Location = { BZ["Deadwind Pass"] },
		DungeonID = 175,
		Acronym = L["Kara"],
		PlayerLimit = { 10 },
		WorldMapID = 350, -- which level?
		JournalInstanceID = 745,
		Module = "Atlas_BurningCrusade",
		PrevMap = "KarazhanStart",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["The Violet Eye"] },
		{ BLUE.." I) "..L["Path to the Broken Stairs"], 10001 },
		{ BLUE.." J) "..L["Broken Stairs"], 10002 },
		{ BLUE.." K) "..L["Ramp to Guardian's Library"]..ALC["L-Parenthesis"]..Atlas_GetBossName("Shade of Aran")..ALC["R-Parenthesis"], 10003 },
		{ BLUE.." L) "..L["Mysterious Bookshelf"]..ALC["L-Parenthesis"]..Atlas_GetBossName("Terestian Illhoof")..ALC["R-Parenthesis"], 10004 },
		{ BLUE.." M) "..L["Ramp up to the Celestial Watch"]..ALC["L-Parenthesis"]..Atlas_GetBossName("Netherspite")..ALC["R-Parenthesis"], 10005 },
		{ BLUE..INDENT..L["Ramp down to the Gamesman's Hall"]..ALC["L-Parenthesis"]..Atlas_GetBossName("Chess Event", 1764)..ALC["R-Parenthesis"], 1764 },
		{ BLUE.." N) "..L["Ramp to Medivh's Chamber"], 10006 },
		{ BLUE.." O) "..L["Spiral Stairs to Netherspace"]..ALC["L-Parenthesis"]..Atlas_GetBossName("Prince Malchezaar")..ALC["R-Parenthesis"], 10007 },
		{ WHIT.." 7) "..Atlas_GetBossName("The Curator", 1557), 1557 },
		{ WHIT.." 8) "..Atlas_GetBossName("Terestian Illhoof", 1560), 1560 },
		{ WHIT..INDENT..Atlas_GetBossName("Kil'rek")..ALC["L-Parenthesis"]..ALC["Imp"]..ALC["R-Parenthesis"] },
		{ WHIT.." 9) "..Atlas_GetBossName("Shade of Aran", 1559), 1559 },
		{ WHIT.."10) "..Atlas_GetBossName("Netherspite", 1561), 1561 },
		{ WHIT.."11) "..Atlas_GetBossName("Chess Event", 1562), 1562 },
		{ GREN..INDENT..Atlas_GetBossName("Dust Covered Chest") },
		{ WHIT.."12) "..Atlas_GetBossName("Prince Malchezaar", 1563), 1563 },
		{ GREN.."10') "..L["Wravien <The Mage>"], 10014 },
		{ GREN.."11') "..L["Gradav <The Warlock>"], 10015 },
		{ GREN.."12') "..L["Kamsis <The Conjurer>"], 10016 },
		{ GREN.."13') "..L["Ythyar"]..ALC["L-Parenthesis"]..ALC["Repair"]..ALC["Comma"]..ALC["Rewards"]..ALC["R-Parenthesis"], 10017 },
		{ GREN.."14') "..L["Echo of Medivh"], 10018 },
	},
	MagistersTerrace = {
		ZoneName = { BZ["Magisters' Terrace"] },
		Location = { BZ["Isle of Quel'Danas"] },
		DungeonID = 198,
		DungeonHeroicID = 201,
		Acronym = L["MaT"],
		WorldMapID = 348,
		JournalInstanceID = 249,
		Module = "Atlas_BurningCrusade",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Shattered Sun Offensive"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ GREN..INDENT..L["Exarch Larethor"] },
		{ BLUE.." B) "..ALC["Exit"]..ALC["L-Parenthesis"]..ALC["Portal"]..ALC["R-Parenthesis"], 10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Selin Fireheart", 530), 530 },
		{ GREN..INDENT..L["Fel Crystals"] },
		{ WHIT.." 2) "..Atlas_GetBossName("Vexallus", 531), 531 },
		{ WHIT.." 3) "..Atlas_GetBossName("Priestess Delrissa", 532)..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["R-Parenthesis"], 532 },
		{ WHIT..INDENT..L["Apoko"]..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["Comma"]..ALC["Random"]..ALC["Comma"]..Atlas_GetClassName("SHAMAN")..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..L["Eramas Brightblaze"]..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["Comma"]..ALC["Random"]..ALC["Comma"]..Atlas_GetClassName("MONK")..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..L["Ellrys Duskhallow"]..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["Comma"]..ALC["Random"]..ALC["Comma"]..Atlas_GetClassName("WARLOCK")..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..INDENT..L["Fizzle"]..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["Comma"]..ALC["Random"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..L["Garaxxas"]..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["Comma"]..ALC["Random"]..ALC["Comma"]..Atlas_GetClassName("HUNTER")..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..INDENT..L["Sliver <Garaxxas' Pet>"]..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["Comma"]..ALC["Random"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..L["Kagani Nightstrike"]..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["Comma"]..ALC["Random"]..ALC["Comma"]..Atlas_GetClassName("ROGUE")..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..L["Warlord Salaris"]..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["Comma"]..ALC["Random"]..ALC["Comma"]..Atlas_GetClassName("WARRIOR")..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..L["Yazzai"]..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["Comma"]..ALC["Random"]..ALC["Comma"]..Atlas_GetClassName("MAGE")..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..L["Zelfan"]..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["Comma"]..ALC["Random"]..ALC["Comma"]..ALC["Engineer"]..ALC["R-Parenthesis"] },
		{ WHIT.." 4) "..Atlas_GetBossName("Kael'thas Sunstrider", 533), 533 },
		{ GREN.." 1') "..L["Tyrith"], 10003 },
		{ GREN.." 2') "..L["Scrying Orb"], 10004 },
		{ GREN..INDENT..Atlas_GetBossName("Kalecgos") },
	},
	SunwellPlateau = {
		ZoneName = { BZ["Sunwell Plateau"] },
		Location = { BZ["Isle of Quel'Danas"] },
		DungeonID = 199,
		Acronym = L["SuP"],
		PlayerLimit = { 25 },
		WorldMapID = 335,
		JournalInstanceID = 752,
		Module = "Atlas_BurningCrusade",
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Kalecgos", 1591), 1591 },
		{ WHIT..INDENT..Atlas_GetBossName("Sathrovarr the Corruptor", 1591, 2) },
		{ WHIT.." 2) "..Atlas_GetBossName("Brutallus", 1592), 1592 },
		{ WHIT..INDENT..Atlas_GetBossName("Felmyst", 1593), 1593 },
		{ GREN..INDENT..L["Madrigosa"] },
		{ WHIT.." 3) "..Atlas_GetBossName("The Eredar Twins", 1594)..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["R-Parenthesis"], 1594 },
		{ WHIT..INDENT..Atlas_GetBossName("Grand Warlock Alythess", 1594, 1)..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..Atlas_GetBossName("Lady Sacrolash", 1594, 2)..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..Atlas_GetBossName("M'uru", 1595, 1)..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"], 1595 },
		{ WHIT..INDENT..Atlas_GetBossName("Entropius", 1595, 2)..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"] },
		{ WHIT.." 4) "..Atlas_GetBossName("Kil'jaeden", 1596), 1596 },
	},
	TempestKeepEnt = {
		ZoneName = { BZ["Tempest Keep"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Netherstorm"] },
		LevelRange = "70-73",
		MinLevel= "67",
		PlayerLimit = { 5, 25},
		Acronym = L["TK"],
		Module = "Atlas_BurningCrusade",
		{ BLUE.." A) "..BZ["The Mechanar"], 10001 },
		{ BLUE.." B) "..BZ["The Botanica"], 10002 },
		{ BLUE.." C) "..BZ["The Arcatraz"], 10003 },
		{ BLUE.." D) "..BZ["Tempest Keep"], 10004 },
	},
	TempestKeepArcatraz = {
		ZoneName = { BZ["Tempest Keep"]..ALC["Colon"]..BZ["The Arcatraz"] },
		Location = { BZ["Netherstorm"] },
		DungeonID = 174,
		DungeonHeroicID = 190,
		Acronym = L["Arca"],
		WorldMapID = 269,
		JournalInstanceID = 254,
		Module = "Atlas_BurningCrusade",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["The Sha'tar"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Zereketh the Unbound", 548), 548 },
		{ WHIT.." 2) "..Atlas_GetBossName("Dalliah the Doomsayer", 549), 549 },
		{ WHIT.." 3) "..Atlas_GetBossName("Wrath-Scryer Soccothrates", 550), 550 },
		{ WHIT.." 4) "..Atlas_GetBossName("Harbinger Skyriss", 551), 551 },
		{ WHIT..INDENT..Atlas_GetBossName("Warden Mellichar") },
		{ GREN..INDENT..L["Millhouse Manastorm"] },
		{ ORNG.." 1) "..L["Third Fragment Guardian"], 10002 },
		{ GREN..INDENT..ALC["Arcane Container"] },
		{ GREN.." 1') "..L["Udalo"], 10003 },
	},
	TempestKeepBotanica = {
		ZoneName = { BZ["Tempest Keep"]..ALC["Colon"]..BZ["The Botanica"] },
		Location = { BZ["Netherstorm"] },
		DungeonID = 173,
		DungeonHeroicID = 191,
		Acronym = L["Bota"],
		WorldMapID = 266,
		JournalInstanceID = 257,
		Module = "Atlas_BurningCrusade",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["The Sha'tar"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ BLUE.." B) "..ALC["Exit"], 10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Commander Sarannis", 558), 558 },
		{ WHIT.." 2) "..Atlas_GetBossName("High Botanist Freywinn", 559), 559 },
		{ WHIT.." 3) "..Atlas_GetBossName("Thorngrin the Tender", 560), 560 },
		{ WHIT.." 4) "..Atlas_GetBossName("Laj", 561), 561 },
		{ WHIT.." 5) "..Atlas_GetBossName("Warp Splinter", 562), 562 },
	},
	TempestKeepMechanar = {
		ZoneName = { BZ["Tempest Keep"]..ALC["Colon"]..BZ["The Mechanar"] },
		Location = { BZ["Netherstorm"] },
		DungeonID = 172,
		DungeonHeroicID = 192,
		Acronym = L["Mech"],
		WorldMapID = 267,
		JournalInstanceID = 258,
		Module = "Atlas_BurningCrusade",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["The Sha'tar"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ BLUE.." B) "..ALC["Exit"], 10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Gatewatcher Gyro-Kill"), 10003 },
		{ WHIT.." 2) "..Atlas_GetBossName("Gatewatcher Iron-Hand"), 10004 },
		{ WHIT.." 3) "..Atlas_GetBossName("Mechano-Lord Capacitus", 563)..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"], 563 },
		{ GREN..INDENT..L["Overcharged Manacell"] },
		{ WHIT.." 4) "..Atlas_GetBossName("Nethermancer Sepethrea", 564), 564 },
		{ WHIT.." 5) "..Atlas_GetBossName("Pathaleon the Calculator", 565), 565 },
		{ GREN.." 1') "..Atlas_GetBossName("Cache of the Legion"), 10005 },
	},
	TempestKeepTheEye = {
		ZoneName = { BZ["Tempest Keep"]..ALC["Colon"]..BZ["Tempest Keep"] },
		Location = { BZ["Netherstorm"] },
		DungeonID = "193",
		Acronym = L["TK"],
		PlayerLimit = "25",
		WorldMapID = 266,
		JournalInstanceID = "749",
		Module = "Atlas_BurningCrusade",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["The Sha'tar"] },
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Al'ar", 1573), 1573 },
		{ WHIT.." 2) "..Atlas_GetBossName("Void Reaver", 1574), 1574 },
		{ WHIT.." 3) "..Atlas_GetBossName("High Astromancer Solarian", 1575), 1575 },
		{ WHIT.." 4) "..Atlas_GetBossName("Kael'thas Sunstrider", 1576), 1576 },
		{ WHIT..INDENT..Atlas_GetBossName("Thaladred the Darkener", 1576, 2)..ALC["L-Parenthesis"]..Atlas_GetClassName("WARRIOR")..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..Atlas_GetBossName("Master Engineer Telonicus", 1576, 5)..ALC["L-Parenthesis"]..Atlas_GetClassName("HUNTER")..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..Atlas_GetBossName("Grand Astromancer Capernian", 1576, 4)..ALC["L-Parenthesis"]..Atlas_GetClassName("MAGE")..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..Atlas_GetBossName("Lord Sanguinar", 1576, 3)..ALC["L-Parenthesis"]..Atlas_GetClassName("PALADIN")..ALC["R-Parenthesis"] },
	},
}

-- Atlas Map NPC Description Data
db.AtlasMaps_NPC_DB = {
	AuchindounEnt = {
		{ "A", 10001, 52, 255 }, -- Auchenai Crypts
		{ "B", 10002, 251, 53 }, -- Mana-Tombs
		{ "C", 10003, 450, 251 }, -- Sethekk Halls
		{ "D", 10004, 251, 451 }, -- Shadow Labyrinth
		{ "E", 10005, 97, 97 }, -- Entrance
		{ "E", 10005, 405, 100 }, -- Entrance
		{ "E", 10005, 97, 406 }, -- Entrance
		{ "E", 10005, 405, 406 }, -- Entrance
		{ "1'", 10006, 88, 250 }, -- Clarissa
		{ "2'", 10007, 253, 88 }, -- Nexus-Prince Haramad
		{ "3'", 10008, 419, 253 }, -- Dealer Tariq <Shady Dealer>
		{ "3'", 10008, 253, 414 }, -- Dealer Tariq <Shady Dealer>
		{ "4'", 10009, 253, 251 }, -- Meeting Stone
	},
	AuchAuchenaiCrypts = {
		{ 1, 523, 220, 362 }, -- Shirrak the Dead Watcher
		{ 2, 524, 448, 227 }, -- Exarch Maladaar
		{ "A", 10001, 104, 400 },
		{ "1'", 10002, 260, 66 },
	},
	AuchManaTombs = {
		{ 1, 534, 253, 142 }, -- Pandemonius
		{ 2, 535, 357, 394 }, -- Tavarok
		{ 3, 537, 127, 266 }, -- Nexus-Prince Shaffar
		{ "A", 10001, 87, 12 },
		{ "1'", 10002, 359, 66 },
		{ "2'", 10003, 211, 429 },
	},
	AuchSethekkHalls = {
		{ 1, 541, 230, 317 }, -- Darkweaver Syth
		{ 2, 542, 91, 253 }, -- Anzu
		{ 3, 543, 95, 88 }, -- Talon King Ikiss
		{ "A", 10001, 498, 231 },
	},
	AuchShadowLabyrinth = {
		{ 1, 544, 60, 217 }, -- Ambassador Hellmaw
		{ 2, 545, 95, 363 }, -- Blackheart the Inciter
		{ 3, 546, 272, 293 }, -- Grandmaster Vorpil
		{ 4, 547, 456, 216 }, -- Murmur
		{ "A", 10001, 24, 40 },
		{ "1", 10002, 470, 186 },
		{ "1'", 10003, 21, 156 },
	},
	BlackTempleStart = {
		{ "A", 10001, 92, 477 },
		{ "B", 10002, 492, 119 },
		{ "C", 10003, 496, 256 },
		{ "D", 10004, 240, 95 },
		{ 1, 1582, 246, 306 },
		{ 2, 1583, 214, 191 },
		{ 3, 1584, 334, 357 },
		{ "1'", 10008, 83, 459 },
		{ "2'", 10009, 464, 189 },
	},
	BlackTempleBasement = {
		{ "B", 10001, 337, 161 },
		{ "C", 10002, 294, 268 },
		{ 4, 1586, 270, 207 },
		{ 5, 1587, 359, 429 },
		{ 6, 1585, 72, 266 },
	},
	BlackTempleTop = {
		{ "D", 10001, 48, 120 },
		{ "E", 10002, 82, 263 },
		{ "E", 10002, 280, 252 },
		{ 7, 1588, 430, 60 },
		{ 8, 1589, 277, 294 },
		{ 9, 1590, 82, 386 },
	},
	CFRSerpentshrineCavern = {
		{ "A", 10001, 10, 333 },
		{ "B", 10002, 49, 268 },
		{ "B", 10002, 93, 319 },
		{ 1, 1567, 190, 379 },
		{ 2, 1568, 212, 270 },
		{ 3, 1569, 225, 137 },
		{ 4, 1570, 256, 85 },
		{ 5, 1571, 334, 136 },
		{ 6, 1572, 411, 277 },
	},
	CFRTheSlavePens = {
		{ 1, 570, 243, 167 }, -- Mennu the Betrayer
		{ 2, 571, 288, 220 }, -- Rokmar the Crackler
		{ 3, 572, 401, 369 }, -- Quagmirran
		{ "A", 10001, 116, 103 },
		{ "1", 10002, 160, 249 },
		{ "1'", 10003, 245, 345 },
		{ "2'", 10004, 292, 366 },
		{ "3'", 10005, 488, 309 },
	},
	CFRTheSteamvault = {
		{ 1, 573, 270, 80 }, -- Hydromancer Thespia
		{ 2, 574, 123, 401 }, -- Mekgineer Steamrigger
		{ 3, 575, 470, 217 }, -- Warlord Kalithresh
		{ "A", 10001, 5, 176 },
		{ "1", 10002, 264, 125 },
	},
	CFRTheUnderbog = {
		{ 1, 576, 360, 423 }, -- Hungarfen
		{ 2, 577, 414, 169 }, -- Ghaz'an
		{ 3, 578, 195, 148 }, -- Swamplord Musel'ek
		{ 4, 579, 101, 230 }, -- The Black Stalker
		{ "A", 10001, 118, 340 },
		{ "1'", 10002, 359, 149 },
	},
	CoilfangReservoirEnt = {
		{ "A", 10001, 79, 321 }, -- The Slave Pens
		{ "B", 10002, 139, 230 }, -- The Steamvault
		{ "C", 10003, 241, 224 }, -- Serpentshrine Cavern
		{ "D", 10004, 349, 292 }, -- The Underbog
		{ "E", 10005, 241, 378 }, -- Entrance - Underwater
		{ "1'", 10006, 251, 321 }, -- Meeting Stone
		{ "2'", 10007, 227, 308 }, -- Mortog Steamhead
	},
	CavernsOfTimeEnt = {
		{ "A", 10001, 405, 170 }, -- Entrance
		{ "B", 10002, 140, 79 }, -- Hyjal Summit
		{ "C", 10003, 18, 156 }, -- Old Hillsbrad Foothills
		{ "D", 10004, 65, 442 }, -- The Black Morass
		{ "E", 10005, 263, 411 }, -- The Culling of Stratholme
		{ "F", 10006, 291, 170 }, -- Dragon Soul
		{ "G", 10007, 261, 201 }, -- End Time
		{ "H", 10008, 28, 298 }, -- Well of Eternity
		{ "I", 10009, 329, 210 }, -- Hour of Twilight
		{ "1'", 10010, 426, 170 }, -- Steward of Time <Keepers of Time>
		{ "2'", 10011, 461, 159 }, -- Alexston Chrome <Tavern of Time>
		{ "3'", 10012, 355, 148 }, -- Graveyard
		{ "4'", 10013, 323, 303 }, -- Yarley <Armorer>
		{ "5'", 10014, 313, 329 }, -- Bortega <Reagents & Poison Supplies>
		{ "6'", 10015, 196, 293 }, -- Zaladormu
		{ "7'", 10016, 198, 157 }, -- Moonwell
		{ "8'", 10017, 161, 216 }, -- Andormu <Keepers of Time>
		{ "9'", 10018, 146, 263 }, -- Anachronos <Keepers of Time>
		{ "10'", 10019, 115, 317 }, -- Andormu <Keepers of Time>
	},
	CoTBlackMorass = {
		{ "A", 10001, 255, 123 },
		{ "X", 10002, 262, 243 },
		{ "X", 10002, 226, 271 },
		{ "X", 10002, 307, 279 },
		{ "X", 10002, 305, 314 },
		{ "1'", 10003, 249, 346 },
	},
	CoTHyjal = {
		{ "A", 10001, 102, 252 },
		{ "B", 10002, 281, 189 },
		{ "C", 10003, 374, 238 },
		{ 1, 1577, 120, 241 },
		{ 2, 1578, 120, 262 },
		{ 3, 1579, 298, 178 },
		{ 4, 1580, 298, 199 },
		{ 5, 1581, 409, 167 },
	},
	CoTHyjalEnt = {
		{ "A", 10001, 380, 303 }, -- Entrance
		{ "B", 10002, 298, 410 }, -- Alliance Base
		{ "C", 10003, 221, 124 }, -- Horde Encampment
		{ "D", 10004, 143, 254 }, -- Night Elf Village
		{ "1'", 10005, 249, 268 }, -- Indormi <Keeper of Ancient Gem Lore>
	},
	CoTOldHillsbrad = {
		{ 1, 538, 402, 286 }, -- Lieutenant Drake
		{ 2, 539, 355, 298 }, -- Captain Skarloc
		{ 3, 540, 220, 123 }, -- Epoch Hunter
		{ "A", 10001, 67, 201 },
		{ "B", 10002, 339, 297 },
		{ "C", 10003, 114, 349 },
		{ "D", 10004, 218, 150 },
		{ "1'", 10005, 392, 251 },
		{ "2'", 10006, 237, 176 },
		{ "4", 10007, 182, 228 },
		{ "3'", 10008, 152, 228 },
	},
	GruulsLair = {
		{ "A", 10001, 458, 407 },
		{ 1, 1564, 274, 243 },
		{ 2, 1565, 91, 129 },
	},
	HCBloodFurnace = {
		{ 1, 555, 138, 191 }, -- The Maker
		{ 2, 556, 198, 80 }, -- Broggok
		{ 3, 557, 323, 191 }, -- Keli'dan the Breaker
		{ "A", 10001, 232, 472 },
	},
	HCHellfireRamparts = {
		{ 1, 527, 392, 143 }, -- Watchkeeper Gargolmar
		{ 2, 528, 106, 80 }, -- Omor the Unscarred
		{ 3, 529, 77, 418 }, -- Vazruden the Herald
		{ "A", 10001, 197, 354 },
	},
	HCMagtheridonsLair = {
		{ "A", 10001, 111, 67 },
		{ 1, 1566, 269, 359 },
	},
	HCTheShatteredHalls = {
		{ 1, 566, 114, 328 }, -- Grand Warlock Nethekurse
		{ 2, 728, 69, 47 }, -- Blood Guard Porung
		{ 3, 568, 283, 166 }, -- Warbringer O'mrogg
		{ 4, 569, 401, 287 }, -- Warchief Kargath Bladefist
		{ "A", 10001, 331, 488 },
		{ "1'", 10002, 114, 375 },
	},
	HellfireCitadelEnt = {
		{ "A", 10001, 275, 306 }, -- Hellfire Ramparts
		{ "B", 10002, 305, 253 }, -- The Shattered Halls
		{ "C", 10003, 201, 249 }, -- The Blood Furnace
		{ "D", 10004, 210, 286 }, -- Magtheridon's Lair
		{ "1'", 10005, 190, 344 }, -- Meeting Stone of Magtheridon's Lair
		{ "2'", 10006, 309, 283 }, -- Meeting Stone of Hellfire Citadel
		{ "3'", 10007, 205, 489 }, -- Steps and path to the Blood Furnace
		{ "4'", 10008, 331, 377 }, -- Path to the Hellfire Ramparts and Shattered Halls
		{ "4'", 10008, 326, 134 }, -- Path to the Hellfire Ramparts and Shattered Halls
	},
	KarazhanStart = {
		{ "A", 10001, 138, 207 },
		{ "B", 10002, 100, 156 },
		{ "B", 10002, 112, 342 },
		{ "C", 10002, 45, 215 },
		{ "C", 10002, 66, 438 },
		{ "D", 10002, 28, 30 },
		{ "D", 10002, 313, 275 },
		{ "E", 10002, 155, 251 },
		{ "E", 10002, 427, 309 },
		{ "F", 10002, 235, 207 },
		{ "F", 10002, 224, 320 },
		{ "G", 10002, 283, 16 },
		{ "G", 10002, 286, 137 },
		{ "H", 10002, 410, 141 },
		{ "H", 10002, 399, 384 },
		{ "I", 10002, 363, 179 },
		{ "I", 10002, 352, 421 },
		{ "J", 10002, 436, 164 },
		{ "J", 10002, 426, 409 },
		{ 1, 1553, 75, 218 },
		{ 2, 1554, 36, 310 },
		{ 3, 1555, 473, 313 },
		{ 4, 1556, 205, 300 },
		{ 5, 10018, 349, 493 },
		{ 1, 1552, 145, 62 },
		{ "1'", 10009, 141, 169 },
		{ "2'", 10010, 101, 170 },
		{ "3'", 10011, 105, 211 },
		{ "4'", 10012, 59, 193 },
		{ "5'", 10013, 56, 406 },
		{ "6'", 10014, 411, 239 },
		{ "7'", 10015, 359, 361 },
		{ "8'", 10016, 233, 332 },
		{ "9'", 10017, 221, 281 },
	},
	KarazhanEnd = {
		{ "I", 10001, 210, 39 },
		{ "J", 10002, 179, 44 },
		{ "K", 10003, 39, 227 },
		{ "K", 10003, 172, 385 },
		{ "L", 10004, 193, 312 },
		{ "M", 10005, 189, 406 },
		{ "M", 10005, 356, 227 },
		{ "N", 10006, 422, 142 },
		{ "N", 10006, 419, 14 },
		{ "O", 10007, 497, 65 },
		{ "O", 10007, 497, 304 },
		{ "O", 10007, 497, 205 },
		{ "O", 10007, 486, 492 },
		{ "7", 1557, 96, 80 },
		{ 8, 1560, 115, 389 },
		{ 9, 1559, 290, 296 },
		{ 10, 1561, 232, 154 },
		{ 11, 1562, 429, 51 },
		{ 12, 1563, 463, 399 },
		{ "10'", 10014, 75, 149 },
		{ "11'", 10015, 21, 162 },
		{ "12'", 10016, 22, 210 },
		{ "13'", 10017, 401, 117 },
		{ "14'", 10018, 404, 75 },
	},
	KarazhanEnt = {
		{ "A", 10001, 279, 289 }, -- Karazhan, Front
		{ "B", 10002, 327, 192 }, -- Karazhan, Back
		{ "C", 10003, 266, 220 }, -- Return to Karazhan
		{ "1'", 18255, 290, 304 }, -- Archmage Leryda
		{ "2'", 10004, 300, 355 }, -- Stairs to The Master's Cellar
		{ "3'", 10005, 325, 365 }, -- Stairs to The Master's Cellar
		{ "4'", 10006, 226, 364 }, -- Charred Bone Fragment
		{ "5'", 10007, 274, 315 }, -- Meeting Stone
		{ "6'", 10008, 94, 288 }, -- Graveyard
		{ "7'", 66255, 93, 328 }, -- Lydia Accoste
	},
	MagistersTerrace = {
		{ 1, 530, 210, 123 }, -- Selin Fireheart
		{ 2, 531, 424, 153 }, -- Vexallus
		{ 3, 532, 190, 257 }, -- Priestess Delrissa
		{ 4, 533, 34, 236 }, -- Kael'thas Sunstrider
		{ "A", 10001, 212, 397 },
		{ "B", 10002, 10, 238 },
		{ "1'", 10003, 313, 149 },
		{ "2'", 10004, 487, 154 },
	},
	SunwellPlateau = {
		{ "A", 10001, 174, 90 },
		{ 1, 1591, 174, 162 },
		{ 2, 1592, 338, 273 },
		{ 3, 1594, 319, 106 },
		{ 4, 1596, 320, 164 },
	},
	TempestKeepArcatraz = {
		{ 1, 548, 331, 234 }, -- Zereketh the Unbound
		{ 2, 549, 142, 353 }, -- Dalliah the Doomsayer
		{ 3, 550, 65, 353 }, -- Wrath-Scryer Soccothrates
		{ 4, 551, 364, 81 }, -- Harbinger Skyriss
		{ "A", 10001, 187, 490 },
		{ "1", 10002, 238, 179 },
		{ "1'", 10003, 199, 75 },
	},
	TempestKeepBotanica = {
		{ 1, 558, 221, 144 }, -- Commander Sarannis
		{ 2, 559, 114, 144 }, -- High Botanist Freywinn
		{ 3, 560, 31, 235 }, -- Thorngrin the Tender
		{ 4, 561, 167, 352 }, -- Laj
		{ 5, 562, 168, 197 }, -- Warp Splinter
		{ "A", 10001, 495, 211 },
		{ "B", 10002, 168, 134 },
	},
	TempestKeepEnt = {
		{ "A", 10001, 233, 354 }, -- The Mechanar
		{ "B", 10002, 266, 127 }, -- The Botanica
		{ "C", 10003, 332, 165 }, -- The Arcatraz
		{ "D", 10004, 257, 258 }, -- Tempest Keep
	},
	TempestKeepMechanar = {
		{ 1, 10003, 227, 281 },
		{ 2, 10004, 331, 256 },
		{ 3, 563, 295, 175 }, -- Mechano-Lord Capacitus
		{ 4, 564, 234, 25 }, -- Nethermancer Sepethrea
		{ 5, 565, 82, 232 }, -- Pathaleon the Calculator	
		{ "A", 10001, 205, 482 },
		{ "B", 10002, 46, 359 },
		{ "1'", 10005, 162, 153 },
	},
	TempestKeepTheEye = {
		{ "A", 10001, 230, 481 },
		{ 1, 1573, 250, 283 },
		{ 2, 1574, 61, 233 },
		{ 3, 1575, 438, 231 },
		{ 4, 1576, 251, 52 },
	},
}

db.AssocDefaults = {
	[BZ["Black Temple"]] =			"BlackTempleBasement",
	--[BZ["Karazhan"]] =			"KarazhanStart",
}

--[[
	SubZoneData{}

	Define SubZone data for default map to be selected for instance which has multiple maps.
	Subzone data should be able to be pulled out from WMOAreaTable for indoor areas, or from AreaTable for outdoor areas.

	Array Syntax: 
	["localized zone name"] = {
		["atlas map name"] = {
			["localized subzone name 1"],
			["localized subzone name 2"],
		},
	},
]]
db.SubZoneData = {
	-- Black Temple
	[BZ["Black Temple"]] = {
		-- Black Temple, Start
		["BlackTempleStart"] = {
			BZ["Karabor Sewers"],
			BZ["Illidari Training Grounds"],
			BZ["Sanctuary of Shadows"],
			BZ["The Refectory"],
		},
		-- Black Temple, Basement
		["BlackTempleBasement"] = {
			BZ["Gorefiend's Vigil"],
			BZ["Halls of Anguish"],
			BZ["Shrine of Lost Souls"],
		},
		-- Black Temple, Top
		["BlackTempleTop"] = {
			BZ["Den of Mortal Delights"],
			BZ["Grand Promenade"],
			BZ["Chamber of Command"],
			BZ["Temple Summit"],
		},
	},
	-- Karazhan
	[BZ["Karazhan"]] = {
		-- Karazhan, Start
		["KarazhanStart"] = {
			BZ["The Gatehouse"],
			BZ["Livery Stables"],
			BZ["The Guardhouse"],
			BZ["The Scullery"],
			BZ["Servants' Quarters"],
			BZ["The Grand Ballroom"],
			BZ["The Banquet Hall"],
			BZ["The Guest Chambers"],
			BZ["The Opera Hall"],
			BZ["The Broken Stair"],
			BZ["Master's Terrace"],
		},
		-- Karazhan, End
		["KarazhanEnd"] = {
			BZ["The Menagerie"],
			BZ["Guardian's Library"],
			BZ["The Repository"],
			BZ["The Celestial Watch"],
			BZ["Gamesman's Hall"],
			BZ["Medivh's Chambers"],
			BZ["Master's Terrace"],
			BZ["Netherspace"],
		},
	},
}

--[[
	OutdoorZoneToAtlas{}

	Maps to auto-select to from outdoor zones.

	Table index is sub-zone name, it need to be localized value, but we will handle
	the localization with BabbleSubZone library.
	The table value is map's key-name.

	Duplicates are commented out.
	Not for localization.
]]
db.OutdoorZoneToAtlas = {
	[BZ["Tanaris"]] = 			"CavernsOfTimeEnt",	-- Burning Crusade, WoLTK, Catalysm
	[BZ["Terokkar Forest"]] = 		"AuchindounEnt",		-- Outland
	[BZ["Shadowmoon Valley"]] = 		"BlackTempleStart",		-- Outland
	[BZ["Zangarmarsh"]] = 			"CoilfangReservoirEnt",		-- Outland
	[BZ["Blade's Edge Mountains"]] = 	"GruulsLair",			-- Outland
	[BZ["Hellfire Peninsula"]] = 		"HellfireCitadelEnt",		-- Outland
	[BZ["Deadwind Pass"]] = 		"KarazhanEnt",
	[BZ["Isle of Quel'Danas"]] = 		"SunwellPlateau",
	[BZ["Netherstorm"]] = 			"TempestKeepEnt",
}

-- Entrance maps to instance maps
db.EntToInstMatches = {
	["AuchindounEnt"] =			{"AuchManaTombs","AuchAuchenaiCrypts","AuchSethekkHalls","AuchShadowLabyrinth"},
	["CoilfangReservoirEnt"] =		{"CFRTheSlavePens","CFRTheUnderbog","CFRTheSteamvault","CFRSerpentshrineCavern"},
	["CavernsOfTimeEnt"] =			{"CoTBlackMorass","CoTHyjal","CoTHyjalEnt","CoTOldHillsbrad",},
	["HellfireCitadelEnt"] = 		{"HCBloodFurnace", "HCHellfireRamparts", "HCMagtheridonsLair", "HCTheShatteredHalls"},
	["KarazhanEnt"] =			{"KarazhanStart","KarazhanEnd"},
	["TempestKeepEnt"] = 			{"TempestKeepArcatraz", "TempestKeepBotanica", "TempestKeepMechanar", "TempestKeepTheEye"},
}

-- Instance maps to entrance maps
db.InstToEntMatches = {
	["AuchManaTombs"] =			{"AuchindounEnt"},
	["AuchAuchenaiCrypts"] =		{"AuchindounEnt"},
	["AuchSethekkHalls"] =			{"AuchindounEnt"},
	["AuchShadowLabyrinth"] =		{"AuchindounEnt"},
	["CFRTheSlavePens"] =			{"CoilfangReservoirEnt"},
	["CFRTheUnderbog"] =			{"CoilfangReservoirEnt"},
	["CFRTheSteamvault"] =			{"CoilfangReservoirEnt"},
	["CFRSerpentshrineCavern"] =		{"CoilfangReservoirEnt"},
	["CoTBlackMorass"] =			{"CavernsOfTimeEnt"},
	["CoTHyjal"] =				{"CavernsOfTimeEnt"},
	["CoTHyjalEnt"] =			{"CavernsOfTimeEnt"},
	["CoTOldHillsbrad"] =			{"CavernsOfTimeEnt"},
	["HCBloodFurnace"] = 			{"HellfireCitadelEnt"},
	["HCHellfireRamparts"] = 		{"HellfireCitadelEnt"},
	["HCMagtheridonsLair"] = 		{"HellfireCitadelEnt"},
	["HCTheShatteredHalls"] = 		{"HellfireCitadelEnt"},
	["KarazhanStart"] =			{"KarazhanEnt"},
	["KarazhanEnd"] =			{"KarazhanEnt"},
	["Maraudon"] =				{"MaraudonEnt"},
	["TempestKeepArcatraz"] = 		{"TempestKeepEnt"},
	["TempestKeepBotanica"] = 		{"TempestKeepEnt"}, 
	["TempestKeepMechanar"] = 		{"TempestKeepEnt"}, 
	["TempestKeepTheEye"] = 		{"TempestKeepEnt"},
}

-- Defines the instance which have multiple maps
-- Added only when the Entrance map is not available, for example, Ulduar do have entrance map, so no need to add it here
db.MapSeries = {
	["BlackTempleStart"] = 			{"BlackTempleStart", "BlackTempleBasement", "BlackTempleTop" },
	["BlackTempleBasement"] = 		{"BlackTempleStart", "BlackTempleBasement", "BlackTempleTop" },
	["BlackTempleTop"] = 			{"BlackTempleStart", "BlackTempleBasement", "BlackTempleTop" },
}

-- Links maps together that are part of the same instance
db.SubZoneAssoc = {
	["BlackTempleStart"] =			BZ["Black Temple"],
	["BlackTempleBasement"] =		BZ["Black Temple"],
	["BlackTempleTop"] =			BZ["Black Temple"],
	["KarazhanStart"] =			BZ["Karazhan"],
	["KarazhanEnd"] =			BZ["Karazhan"],
	["KarazhanEnt"] =			BZ["Karazhan"],
}

db.DropDownLayouts_Order = {
	[ATLAS_DDL_CONTINENT] = {
		ATLAS_DDL_CONTINENT_EASTERN,
		ATLAS_DDL_CONTINENT_OUTLAND,
	},
	[ATLAS_DDL_LEVEL] = {
		ATLAS_DDL_LEVEL_10TO30,
	},
	[ATLAS_DDL_EXPANSION] = {
		ATLAS_DDL_EXPANSION_BC,
	},
}

db.DropDownLayouts = {
	[ATLAS_DDL_CONTINENT] = {
		[ATLAS_DDL_CONTINENT_EASTERN] = {
			"KarazhanEnd",			-- Burning Crusade
			"KarazhanEnt",			-- Burning Crusade
			"KarazhanStart",		-- Burning Crusade
			"MagistersTerrace",		-- Burning Crusade
			"SunwellPlateau",		-- Burning Crusade
		},
		[ATLAS_DDL_CONTINENT_KALIMDOR] = {
			"CavernsOfTimeEnt",		-- Burning Crusade, WoLTK, Catalysm
			"CoTBlackMorass",		-- Burning Crusade
			"CoTHyjal",			-- Burning Crusade
			"CoTHyjalEnt",			-- Burning Crusade
			"CoTOldHillsbrad",		-- Burning Crusade
		},
		[ATLAS_DDL_CONTINENT_OUTLAND] = {
			"AuchAuchenaiCrypts",
			"AuchindounEnt",
			"AuchManaTombs",
			"AuchSethekkHalls",
			"AuchShadowLabyrinth",
			"BlackTempleBasement",
			"BlackTempleStart",
			"BlackTempleTop",
			"CFRSerpentshrineCavern",
			"CFRTheSlavePens",
			"CFRTheSteamvault",
			"CFRTheUnderbog",
			"CoilfangReservoirEnt",
			"GruulsLair",
			"HellfireCitadelEnt",
			"HCBloodFurnace",
			"HCHellfireRamparts",
			"HCMagtheridonsLair",
			"HCTheShatteredHalls",
			"TempestKeepEnt",
			"TempestKeepArcatraz",
			"TempestKeepBotanica",
			"TempestKeepMechanar",
			"TempestKeepTheEye",
		},
	},
	[ATLAS_DDL_EXPANSION] = {
		[ATLAS_DDL_EXPANSION_BC] = {
			"AuchAuchenaiCrypts",
			"AuchindounEnt",
			"AuchManaTombs",
			"AuchSethekkHalls",
			"AuchShadowLabyrinth",
			"BlackTempleBasement",
			"BlackTempleStart",
			"BlackTempleTop",
			"CFRSerpentshrineCavern",
			"CFRTheSlavePens",
			"CFRTheSteamvault",
			"CFRTheUnderbog",
			"CoilfangReservoirEnt",
			"CavernsOfTimeEnt",
			"CoTBlackMorass",
			"CoTHyjal",
			"CoTHyjalEnt",
			"CoTOldHillsbrad",
			"GruulsLair",
			"HellfireCitadelEnt",
			"HCBloodFurnace",
			"HCHellfireRamparts",
			"HCMagtheridonsLair",
			"HCTheShatteredHalls",
			"KarazhanEnd",
			"KarazhanEnt",
			"KarazhanStart",
			"MagistersTerrace",
			"SunwellPlateau",
			"TempestKeepEnt",
			"TempestKeepArcatraz",
			"TempestKeepBotanica",
			"TempestKeepMechanar",
			"TempestKeepTheEye",
		},
	},
	[ATLAS_DDL_LEVEL] = {
		[ATLAS_DDL_LEVEL_10TO30] = {
			"AuchAuchenaiCrypts",		-- Burning Crusade
			"AuchindounEnt",		-- Burning Crusade
			"AuchManaTombs",		-- Burning Crusade
			"AuchSethekkHalls",		-- Burning Crusade
			"AuchShadowLabyrinth",		-- Burning Crusade
			"CFRTheSlavePens",		-- Burning Crusade
			"CFRTheSteamvault",		-- Burning Crusade
			"CFRTheUnderbog",		-- Burning Crusade
			"CoilfangReservoirEnt",		-- Burning Crusade
			"CavernsOfTimeEnt",		-- Burning Crusade
			"CoTBlackMorass",		-- Burning Crusade
			"CavernsOfTimeEnt",		-- Burning Crusade
			"CoTOldHillsbrad",		-- Burning Crusade
			"HellfireCitadelEnt",		-- Burning Crusade
			"HCBloodFurnace",		-- Burning Crusade
			"HCHellfireRamparts",		-- Burning Crusade
			"HCTheShatteredHalls",		-- Burning Crusade
			"MagistersTerrace",		-- Burning Crusade
			"TempestKeepEnt",		-- Burning Crusade
			"TempestKeepArcatraz",		-- Burning Crusade
			"TempestKeepBotanica",		-- Burning Crusade
			"TempestKeepMechanar",		-- Burning Crusade
			"BlackTempleBasement",		-- Burning Crusade
			"BlackTempleStart",		-- Burning Crusade
			"BlackTempleTop",		-- Burning Crusade
			"CFRSerpentshrineCavern",	-- Burning Crusade
			"CavernsOfTimeEnt",		-- Burning Crusade
			"CoTHyjal",			-- Burning Crusade
			"CoTHyjalEnt",			-- Burning Crusade
			"KarazhanEnd",			-- Burning Crusade
			"KarazhanEnt",			-- Burning Crusade
			"KarazhanStart",		-- Burning Crusade
		},
	},
	[ATLAS_DDL_PARTYSIZE] = {
		[ATLAS_DDL_PARTYSIZE_5] = {
			"AuchAuchenaiCrypts",		-- Burning Crusade
			"AuchindounEnt",		-- Burning Crusade
			"AuchManaTombs",		-- Burning Crusade
			"AuchSethekkHalls",		-- Burning Crusade
			"AuchShadowLabyrinth",		-- Burning Crusade
			"CavernsOfTimeEnt",		-- Burning Crusade
			"CFRTheSlavePens",		-- Burning Crusade
			"CFRTheSteamvault",		-- Burning Crusade
			"CFRTheUnderbog",		-- Burning Crusade
			"CoilfangReservoirEnt",		-- Burning Crusade
			"CoTBlackMorass",		-- Burning Crusade
			"CoTOldHillsbrad",		-- Burning Crusade
			"HCBloodFurnace",		-- Burning Crusade
			"HCHellfireRamparts",		-- Burning Crusade
			"HCTheShatteredHalls",		-- Burning Crusade
			"HellfireCitadelEnt",		-- Burning Crusade
			"MagistersTerrace",		-- Burning Crusade
			"TempestKeepArcatraz",		-- Burning Crusade
			"TempestKeepBotanica",		-- Burning Crusade
			"TempestKeepEnt",		-- Burning Crusade
			"TempestKeepMechanar",		-- Burning Crusade
		},
		[ATLAS_DDL_PARTYSIZE_10] = {
			"KarazhanEnd",			-- Burning Crusade
			"KarazhanEnt",			-- Burning Crusade
			"KarazhanStart",		-- Burning Crusade
		},
		[ATLAS_DDL_PARTYSIZE_20TO40] = {
			"BlackTempleBasement",		-- Burning Crusade
			"BlackTempleStart",		-- Burning Crusade
			"BlackTempleTop",		-- Burning Crusade
			"CFRSerpentshrineCavern",	-- Burning Crusade
			"CoilfangReservoirEnt",		-- Burning Crusade
			"CavernsOfTimeEnt",		-- Burning Crusade
			"CoTHyjal",			-- Burning Crusade
			"CoTHyjalEnt",			-- Burning Crusade
			"GruulsLair",			-- Burning Crusade
			"HCMagtheridonsLair",		-- Burning Crusade
			"HellfireCitadelEnt",		-- Burning Crusade
			"SunwellPlateau",		-- Burning Crusade
			"TempestKeepEnt",		-- Burning Crusade
			"TempestKeepTheEye",		-- Burning Crusade
		},
	},
	[ATLAS_DDL_TYPE] = {
		[ATLAS_DDL_TYPE_INSTANCE] = {
			"AuchAuchenaiCrypts",		-- Burning Crusade
			"AuchManaTombs",		-- Burning Crusade
			"AuchSethekkHalls",		-- Burning Crusade
			"AuchShadowLabyrinth",		-- Burning Crusade
			"BlackTempleBasement",		-- Burning Crusade
			"BlackTempleStart",		-- Burning Crusade
			"BlackTempleTop",		-- Burning Crusade
			"CFRSerpentshrineCavern",	-- Burning Crusade
			"CFRTheSlavePens",		-- Burning Crusade
			"CFRTheSteamvault",		-- Burning Crusade
			"CFRTheUnderbog",		-- Burning Crusade
			"CoTBlackMorass",		-- Burning Crusade
			"CoTHyjal",			-- Burning Crusade
			"CoTHyjalEnt",			-- Burning Crusade
			"CoTOldHillsbrad",		-- Burning Crusade
			"GruulsLair",			-- Burning Crusade
			"HCBloodFurnace",		-- Burning Crusade
			"HCHellfireRamparts",		-- Burning Crusade
			"HCMagtheridonsLair",		-- Burning Crusade
			"HCTheShatteredHalls",		-- Burning Crusade
			"KarazhanEnd",			-- Burning Crusade
			"KarazhanStart",		-- Burning Crusade
			"MagistersTerrace",		-- Burning Crusade
			"SunwellPlateau",		-- Burning Crusade
			"TempestKeepArcatraz",		-- Burning Crusade
			"TempestKeepBotanica",		-- Burning Crusade
			"TempestKeepMechanar",		-- Burning Crusade
			"TempestKeepTheEye",		-- Burning Crusade
		},
		[ATLAS_DDL_TYPE_ENTRANCE] = {
			"AuchindounEnt",		-- Burning Crusade
			"CoilfangReservoirEnt",		-- Burning Crusade
			"CavernsOfTimeEnt",		-- Burning Crusade
			"CoTHyjalEnt",			-- Burning Crusade
			"HellfireCitadelEnt",		-- Burning Crusade
			"KarazhanEnt",			-- Burning Crusade
			"TempestKeepEnt",		-- Burning Crusade
		},
	},
}
