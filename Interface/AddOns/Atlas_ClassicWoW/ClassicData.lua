-- $Id: ClassicData.lua 73 2021-05-20 15:17:09Z arithmandar $
--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2011 ~ 2021 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

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

local WoWClassicEra, WoWClassicTBC, WoWRetail
local wowtocversion  = select(4, GetBuildInfo())
if wowtocversion < 20000 then
	WoWClassicEra = true
elseif wowtocversion > 19999 and wowtocversion < 90000 then 
	WoWClassicTBC = true
else
	WoWRetail = true
end

local function Atlas_GetBossName(bossname, encounterID, creatureIndex)
	local BB = Atlas_GetLocaleLibBabble("LibBabble-Boss-3.0")

	if (bossname and L[bossname]) then
		bossname = L[bossname]
	elseif (bossname and BB[bossname]) then
		bossname = BB[bossname]
	else
		--bossname = bossname
	end

	return bossname
end
if (WoWClassicEra or WoWClassicTBC) then
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
	--************************************************
	-- Eastern Kingdoms Instances (Classic)
	--************************************************
		CL_BlackrockMountainEnt = {
			ZoneName = { BZ["Blackrock Mountain"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
			Location = { BZ["Searing Gorge"]..ALC["Slash"]..BZ["Burning Steppes"] },
			LevelRange = "48-60+",
			PlayerLimit = { 5, 10, 25, 40},
			Acronym = L["BRM"],
			Module = "Atlas_ClassicWoW",
			{ BLUE.." A) "..BZ["Searing Gorge"] },
			{ BLUE.." B) "..BZ["Burning Steppes"] },
			{ BLUE.." C) "..BZ["Blackrock Depths"]..ALC["L-Parenthesis"]..L["BRD"]..ALC["R-Parenthesis"] },
			{ BLUE..INDENT..BZ["Molten Core"]..ALC["L-Parenthesis"]..L["MC"]..ALC["R-Parenthesis"] },
			{ BLUE.." D) "..BZ["Blackrock Spire"]..ALC["L-Parenthesis"]..L["Lower"]..ALC["Comma"]..L["LBRS"]..ALC["R-Parenthesis"] },
			{ BLUE..INDENT..BZ["Blackrock Spire"]..ALC["L-Parenthesis"]..L["Upper"]..ALC["Comma"]..L["UBRS"]..ALC["R-Parenthesis"] },
			{ BLUE..INDENT..BZ["Blackwing Lair"]..ALC["L-Parenthesis"]..L["BWL"]..ALC["R-Parenthesis"] },
			{ BLUE..INDENT..L["Bodley"]..ALC["L-Parenthesis"]..ALC["Ghost"]..ALC["R-Parenthesis"] },
			{ WHIT.." 1) "..L["Overmaster Pyron"]..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"] },
			{ WHIT.." 2) "..L["Lothos Riftwaker"] },
			{ WHIT.." 3) "..L["Franclorn Forgewright"]..ALC["L-Parenthesis"]..ALC["Ghost"]..ALC["R-Parenthesis"] },
			{ WHIT.." 4) "..ALC["Meeting Stone"]..ALC["L-Parenthesis"]..L["BRD"]..ALC["R-Parenthesis"] },
			{ WHIT.." 5) "..L["Orb of Command"] },
			{ WHIT.." 6) "..ALC["Meeting Stone"]..ALC["L-Parenthesis"]..L["LBRS"]..ALC["Comma"]..L["UBRS"]..ALC["R-Parenthesis"] },
			{ WHIT.." 7) "..L["Scarshield Quartermaster <Scarshield Legion>"] },
		},
		CL_BlackrockDepths = {
			ZoneName = { BZ["Blackrock Mountain"]..ALC["Colon"]..BZ["Blackrock Depths"] },
			Location = { BZ["Searing Gorge"]..ALC["Slash"]..BZ["Burning Steppes"] },
			LevelRange = "48-60",
			PlayerLimit = { 5 },
			Acronym = L["BRD"],
			DungeonID = 29,
			WorldMapID = 242,
			JournalInstanceID = 228,
			Module = "Atlas_ClassicWoW",
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ WHIT.." 1) "..Atlas_GetBossName("Lord Roccor", 370)..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"], 370 },
			{ WHIT.." 2) "..Atlas_GetBossName("Kharan Mighthammer") },
			{ WHIT.." 3) "..Atlas_GetBossName("Commander Gor'shak") },
			{ WHIT.." 4) "..Atlas_GetBossName("Marshal Windsor") },
			{ WHIT.." 5) "..Atlas_GetBossName("High Interrogator Gerstahn", 369), 369 },
			{ WHIT.." 6) "..Atlas_GetBossName("Ring of Law", 372), 372 },
			{ WHIT..INDENT..Atlas_GetBossName("Anub'shiah")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..Atlas_GetBossName("Eviscerator")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..Atlas_GetBossName("Gorosh the Dervish")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..Atlas_GetBossName("Grizzle")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..Atlas_GetBossName("Hedrum the Creeper")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..Atlas_GetBossName("Ok'thor the Breaker")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..Atlas_GetBossName("Theldren")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..Atlas_GetBossName("Lefty") },
			{ WHIT..INDENT..Atlas_GetBossName("Malgen Longspear") },
			{ WHIT..INDENT..Atlas_GetBossName("Gnashjaw") },
			{ WHIT..INDENT..Atlas_GetBossName("Rotfang") },
			{ WHIT..INDENT..Atlas_GetBossName("Va'jashni") },
			{ WHIT..INDENT..Atlas_GetBossName("Houndmaster Grebmar", 371), 371 },
			{ WHIT..INDENT..L["Elder Morndeep"]..ALC["L-Parenthesis"]..ALC["Lunar Festival"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..Atlas_GetBossName("High Justice Grimstone", 372, 1), 372 },
			{ WHIT.." 7) "..Atlas_GetBossName("Monument of Franclorn Forgewright") },
			{ WHIT..INDENT..Atlas_GetBossName("Pyromancer Loregrain", 373), 373 },
			{ WHIT.." 8) "..L["The Vault"] },
			{ WHIT..INDENT..Atlas_GetBossName("Warder Stilgiss", 375), 375 },
			{ WHIT..INDENT..Atlas_GetBossName("Verek") },
			{ WHIT..INDENT..L["Watchman Doomgrip"] },
			{ WHIT.." 9) "..Atlas_GetBossName("Fineous Darkvire", 376)..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"], 376 },
			{ WHIT.."10) "..L["The Black Anvil"] },
			{ WHIT..INDENT..Atlas_GetBossName("Lord Incendius", 374), 374 },
			{ WHIT.."11) "..Atlas_GetBossName("Bael'Gar", 377), 377 },
			{ WHIT.."12) "..L["The Shadowforge Lock"], 10009 },
			{ WHIT.."13) "..Atlas_GetBossName("General Angerforge", 378), 378 },
			{ WHIT.."14) "..Atlas_GetBossName("Golem Lord Argelmach", 379), 379 },
			{ WHIT..INDENT..L["Schematic: Field Repair Bot 74A"] },
			{ WHIT..INDENT..ALC["Blacksmithing Plans"] },
			{ WHIT.."15) "..Atlas_GetBossName("The Grim Guzzler") },
			{ WHIT..INDENT..Atlas_GetBossName("Hurley Blackbreath", 380), 380 },
			{ WHIT..INDENT..Atlas_GetBossName("Lokhtos Darkbargainer") },
			{ WHIT..INDENT..Atlas_GetBossName("Mistress Nagmara") }, 
			{ WHIT..INDENT..Atlas_GetBossName("Phalanx", 381), 381 },
			{ WHIT..INDENT..Atlas_GetBossName("Plugger Spazzring", 383), 383 },
			{ WHIT..INDENT..L["Private Rocknot"] },
			{ WHIT..INDENT..Atlas_GetBossName("Ribbly Screwspigot", 382), 382 },
			{ WHIT.."16) "..Atlas_GetBossName("Ambassador Flamelash", 384), 384 },
			{ WHIT.."17) "..Atlas_GetBossName("Panzor the Invincible")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Wanders"]..ALC["R-Parenthesis"], 10004 },
			{ WHIT..INDENT..ALC["Blacksmithing Plans"], 10010 },
			{ WHIT.."18) "..L["Summoner's Tomb"] },
			{ WHIT.."19) "..Atlas_GetBossName("The Lyceum") },
			{ WHIT.."20) "..Atlas_GetBossName("Magmus", 386), 386 },
			{ WHIT.."21) "..Atlas_GetBossName("Emperor Dagran Thaurissan", 387), 387 },
			{ WHIT..INDENT..Atlas_GetBossName("Princess Moira Bronzebeard") },
			{ WHIT.."22) "..L["The Black Forge"], 10016 },
			{ WHIT.."23) "..BZ["The Molten Core"], 10003 },
			{ WHIT..INDENT..L["Core Fragment"], 10017 },
			{ WHIT.."24) "..Atlas_GetBossName("Overmaster Pyron") },
			{ WHIT.."25) "..ALC["Blacksmithing Plans"], 10010 },
		},
		CL_BlackrockSpireLower = {
			ZoneName = { BZ["Blackrock Mountain"]..ALC["Colon"]..BZ["Lower Blackrock Spire"] },
			Location = { BZ["Searing Gorge"]..ALC["Slash"]..BZ["Burning Steppes"] },
			LevelRange = "52-60",
			PlayerLimit = { 10 },
			DungeonID = 31,
			Acronym = L["LBRS"],
			WorldMapID = 906,
			JournalInstanceID = 229,
			Module = "Atlas_ClassicWoW",
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ BLUE.."B) "..BZ["Blackrock Spire"]..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"] },
			{ BLUE.."C-F) "..ALC["Connection"] },
			{ WHIT.." 1) "..Atlas_GetBossName("Vaelan") },
			{ WHIT.." 2) "..Atlas_GetBossName("Warosh") },
			{ WHIT..INDENT..L["Elder Stonefort"]..ALC["L-Parenthesis"]..ALC["Lunar Festival"]..ALC["R-Parenthesis"], 10012 },
			{ WHIT.." 3) "..L["Roughshod Pike"] },
			{ WHIT.." 4) "..Atlas_GetBossName("Spirestone Butcher")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"], 10006 },
			{ WHIT.." 5) "..Atlas_GetBossName("Highlord Omokk", 388), 388 },
			{ WHIT.." 6) "..Atlas_GetBossName("Spirestone Battle Lord")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"], 10007 },
			{ WHIT..INDENT..Atlas_GetBossName("Spirestone Lord Magus")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
			{ WHIT.." 7) "..Atlas_GetBossName("Shadow Hunter Vosh'gajin", 389), 389 },
			{ WHIT..INDENT..L["Fifth Mosh'aru Tablet"] },
			{ WHIT.." 8) "..L["Bijou"] },
			{ WHIT.." 9) "..Atlas_GetBossName("War Master Voone", 390), 390 },
			{ WHIT..INDENT..L["Sixth Mosh'aru Tablet"] },
			{ WHIT..INDENT..Atlas_GetBossName("Mor Grayhoof")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"] },
			{ WHIT.."10) "..L["Bijou's Belongings"] },
			{ WHIT.."11) "..L["Human Remains"] },
			{ WHIT..INDENT..L["Unfired Plate Gauntlets"]..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["R-Parenthesis"] },
			{ WHIT.."12) "..Atlas_GetBossName("Bannok Grimaxe")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"], 10008 },
			{ WHIT.."13) "..Atlas_GetBossName("Mother Smolderweb", 391), 391 },
			{ WHIT.."14) "..Atlas_GetBossName("Crystal Fang")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"], 10009 },
			{ WHIT.."15) "..L["Urok's Tribute Pile"]..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"], 392 },
			{ WHIT..INDENT..Atlas_GetBossName("Urok Doomhowl")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"] },
			{ WHIT.."16) "..Atlas_GetBossName("Quartermaster Zigris", 393), 393 },
			{ WHIT.."17) "..Atlas_GetBossName("Halycon", 394), 394 },
			{ WHIT..INDENT..Atlas_GetBossName("Gizrul the Slavener", 395), 395 },
			{ WHIT.."18) "..Atlas_GetBossName("Ghok Bashguud")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"], 10010 },
			{ WHIT.."19) "..Atlas_GetBossName("Overlord Wyrmthalak", 396), 396 },
			{ GREN.." 1) "..Atlas_GetBossName("Burning Felguard")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Summon"]..ALC["R-Parenthesis"], 10005 },
		},
		CL_BlackrockSpireUpper = {
			ZoneName = { BZ["Blackrock Mountain"]..ALC["Colon"]..BZ["Upper Blackrock Spire"] },
			Location = { BZ["Searing Gorge"]..ALC["Slash"]..BZ["Burning Steppes"] },
			DungeonID = 43,
			LevelRange = "56-60",
			PlayerLimit = { 10 },
			Acronym = L["UBRS"],
			WorldMapID = 616,
			JournalInstanceID = 559,
			Module = "Atlas_ClassicWoW",
			{ BLUE.." A) "..ALC["Entrance"] },
			{ BLUE.." B) "..BZ["Blackrock Spire"]..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["R-Parenthesis"] },
			{ BLUE.."C-E) "..ALC["Connection"] },
			{ WHIT.." 1) "..Atlas_GetBossName("Pyroguard Emberseer") },
			{ WHIT.." 2) "..Atlas_GetBossName("Solakar Flamewreath") },
			{ WHIT..INDENT..L["Father Flame"] },
			{ WHIT.." 3) "..L["Darkstone Tablet"] },
			{ WHIT..INDENT..L["Doomrigger's Coffer"] },
			{ WHIT.." 4) "..Atlas_GetBossName("Jed Runewatcher")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
			{ WHIT.." 5) "..Atlas_GetBossName("Goraluk Anvilcrack") },
			{ WHIT.." 6) "..Atlas_GetBossName("Warchief Rend Blackhand")  },
			{ WHIT..INDENT..Atlas_GetBossName("Gyth") },
			{ WHIT.." 7) "..L["Awbee"] },
			{ WHIT.." 8) "..Atlas_GetBossName("The Beast") },
			{ WHIT..INDENT..Atlas_GetBossName("Lord Valthalak"), ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..L["Finkle Einhorn"] },
			{ WHIT.." 9) "..Atlas_GetBossName("General Drakkisath") },
			{ WHIT..INDENT..L["Drakkisath's Brand"] },
			{ WHIT.."10) "..BZ["Blackwing Lair"] },
		},
		CL_BlackwingLair = {
			ZoneName = { BZ["Blackrock Mountain"]..ALC["Colon"]..BZ["Blackwing Lair"] },
			Location = { BZ["Searing Gorge"]..ALC["Slash"]..BZ["Burning Steppes"] },
			LevelRange = "60",
			DungeonID = 49,
			PlayerLimit = { 40 },
			WorldMapID = 287,
			JournalInstanceID = 742,
			Acronym = L["BWL"],
			Module = "Atlas_ClassicWoW",
			{ ORNG..ALC["Attunement Required"] },
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ BLUE.." B-C) "..ALC["Connection"], 10002 },
			{ WHIT.." 1) "..Atlas_GetBossName("Razorgore the Untamed", 1529), 1529 },
			{ WHIT.." 2) "..Atlas_GetBossName("Vaelastrasz the Corrupt", 1530), 1530 },
			{ WHIT.." 3) "..Atlas_GetBossName("Broodlord Lashlayer", 1531), 1531 },
			{ WHIT.." 4) "..Atlas_GetBossName("Firemaw", 1532), 1532 },
			{ WHIT.." 5) "..Atlas_GetBossName("Ebonroc", 1533), 1533 },
			{ WHIT.." 6) "..Atlas_GetBossName("Flamegor", 1534), 1534 },
			{ WHIT.." 7) "..Atlas_GetBossName("Chromaggus", 1535), 1535 },
			{ WHIT.." 8) "..Atlas_GetBossName("Nefarian", 1536), 1536 },
			{ WHIT.." 9)"..L["Master Elemental Shaper Krixix"] },
		},
		CL_GnomereganEnt = {
			ZoneName = { BZ["Gnomeregan"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
			Location = { BZ["Dun Morogh"] },
			LevelRange = "24-40",
			PlayerLimit = { 5 },
			DungeonID = 13,
			Acronym = L["Gnome"],
			WorldMapID = 226,
			JournalInstanceID = 231,
			Module = "Atlas_ClassicWoW",
			NextMap = "Gnomeregan",
			{ BLUE.."A) "..ALC["Entrance"] },
			{ BLUE..INDENT..ALC["Meeting Stone"] },
			{ BLUE.."B) "..BZ["Gnomeregan"]..ALC["L-Parenthesis"]..ALC["Front"]..ALC["R-Parenthesis"] },
			{ BLUE.."C) "..BZ["Gnomeregan"]..ALC["L-Parenthesis"]..ALC["Back"]..ALC["R-Parenthesis"] },
			{ WHIT.."1) "..ALC["Elevator"] },
			{ WHIT.."2) "..L["Transpolyporter"] },
			{ WHIT..INDENT..Atlas_GetBossName("Sprok <Away Team>") },
			{ WHIT.."3) "..Atlas_GetBossName("Matrix Punchograph 3005-A") },
			{ WHIT..INDENT..Atlas_GetBossName("Namdo Bizzfizzle <Engineering Supplies>") },
			{ WHIT.."4) "..Atlas_GetBossName("Techbot") },
		},
		CL_Gnomeregan = {
			ZoneName = { BZ["Gnomeregan"] },
			Location = { BZ["Dun Morogh"] },
			LevelRange = "24-40",
			PlayerLimit = { 5 },
			DungeonID = 13,
			Acronym = L["Gnome"],
			WorldMapID = 226,
			JournalInstanceID = 231,
			Module = "Atlas_ClassicWoW",
			PrevMap = "GnomereganEnt",
			{ BLUE.." A) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Front"]..ALC["R-Parenthesis"], 10001 },
			{ BLUE.." B) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Back"]..ALC["R-Parenthesis"], 10002 },
			{ WHIT.." 1) "..L["Blastmaster Emi Shortfuse"] },
			{ WHIT..INDENT..Atlas_GetBossName("Grubbis", 419), 419 },
			{ WHIT..INDENT..L["Chomper"] },
			{ WHIT.." 2) "..BZ["The Clean Zone"], 10005 },
			{ WHIT..INDENT..L["Tink Sprocketwhistle <Engineering Supplies>"] },
			{ WHIT..INDENT..L["The Sparklematic 5200"] },
			{ WHIT..INDENT..L["Mail Box"] },
			{ WHIT.." 3) "..L["Kernobee"] },
			{ WHIT..INDENT..L["Alarm-a-bomb 2600"] },
			{ WHIT..INDENT..L["Matrix Punchograph 3005-B"] },
			{ WHIT.." 4) "..Atlas_GetBossName("Viscous Fallout", 420)..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"], 420 },
			{ WHIT.." 5) "..Atlas_GetBossName("Electrocutioner 6000", 421), 421 },
			{ WHIT..INDENT..L["Matrix Punchograph 3005-C"] },
			{ WHIT.." 6) "..Atlas_GetBossName("Crowd Pummeler 9-60", 418), 418 },
			{ WHIT..INDENT..L["Matrix Punchograph 3005-D"] },
			{ WHIT.." 7) "..L["Dark Iron Ambassador"] },
			{ WHIT.." 8) "..Atlas_GetBossName("Mekgineer Thermaplugg", 422), 422 },
		},
		CL_MoltenCore = {
			ZoneName = { BZ["Blackrock Mountain"]..ALC["Colon"]..BZ["The Molten Core"] },
			Location = { BZ["Searing Gorge"]..ALC["Slash"]..BZ["Burning Steppes"] },
			DungeonID = 47,
			LevelRange = "60",
			Acronym = L["MC"],
			PlayerLimit = { 40 },
			WorldMapID = 232,
			JournalInstanceID = 741,
			Module = "Atlas_ClassicWoW",
			{ ORNG..ALC["Attunement Required"] },
			{ ORNG..REPUTATION..ALC["Colon"]..BF["Hydraxian Waterlords"] },
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ WHIT.." 1) "..Atlas_GetBossName("Lucifron", 1519), 1519 },
			{ WHIT.." 2) "..Atlas_GetBossName("Magmadar", 1520), 1520 },
			{ WHIT.." 3) "..Atlas_GetBossName("Gehennas", 1521), 1521 },
			{ WHIT.." 4) "..Atlas_GetBossName("Garr", 1522), 1522 },
			{ WHIT.." 5) "..Atlas_GetBossName("Shazzrah", 1523), 1523 },
			{ WHIT.." 6) "..Atlas_GetBossName("Baron Geddon", 1524), 1524 },
			{ WHIT.." 7) "..Atlas_GetBossName("Golemagg the Incinerator", 1526), 1526 },
			{ WHIT.." 8) "..Atlas_GetBossName("Sulfuron Harbinger", 1525), 1525 },
			{ WHIT.." 9) "..Atlas_GetBossName("Majordomo Executus", 1527), 1527 },
			{ WHIT.."10) "..Atlas_GetBossName("Ragnaros", 1528), 1528 },
		},
		CL_ScarletMonasteryEnt = {
			ZoneName = { BZ["Scarlet Monastery"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
			Location = { BZ["Tirisfal Glades"] },
			LevelRange = "29-48",
			PlayerLimit = { 5 },
			DungeonID = 17,
			Acronym = L["SM"],
			Module = "Atlas_ClassicWoW",
			PrevMap = "ScarletMonastery",
			NextMap = "ScarletHalls",
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ BLUE.." B) "..ALC["Graveyard"] },
			{ BLUE.." C) "..L["Cathedral"] },
			{ BLUE.." D) "..L["Armory"] },
			{ BLUE.." E) "..L["Library"] },
		},
		CL_SMLibrary = {
			ZoneName = { BZ["Scarlet Monastery"]..ALC["Colon"]..L["Library"] },
			Location = { BZ["Tirisfal Glades"] },
			LevelRange = "29-48",
			PlayerLimit = { 5 },
			DungeonID = 17,
			Acronym = L["Lib"],
			Module = "Atlas_ClassicWoW",
			{ BLUE.." A) "..ALC["Entrance"] },
			{ WHIT.." 1) "..Atlas_GetBossName("Houndmaster Loksey") },
			{ WHIT.." 2) "..Atlas_GetBossName("Arcanist Doan") },
		},
		CL_SMArmory = {
			ZoneName = { BZ["Scarlet Monastery"]..ALC["Colon"]..L["Armory"] },
			Location = { BZ["Tirisfal Glades"] },
			LevelRange = "29-48",
			PlayerLimit = { 5 },
			DungeonID = 17,
			Acronym = L["Armory"],
			Module = "Atlas_ClassicWoW",
			{ BLUE.." A) "..ALC["Entrance"] },
			{ WHIT.." 1) "..Atlas_GetBossName("Herod") },
		},
		CL_SMCathedral = {
			ZoneName = { BZ["Scarlet Monastery"]..ALC["Colon"]..L["Cathedral"] },
			Location = { BZ["Tirisfal Glades"] },
			LevelRange = "29-48",
			PlayerLimit = { 5 },
			DungeonID = 17,
			Acronym = L["Cath"],
			Module = "Atlas_ClassicWoW",
			{ BLUE.." A) "..ALC["Entrance"] },
			{ WHIT.." 1) "..Atlas_GetBossName("High Inquisitor Fairbanks") },
			{ WHIT.." 2) "..Atlas_GetBossName("Scarlet Commander Mograine") },
			{ WHIT.." 3) "..Atlas_GetBossName("High Inquisitor Whitemane") },
		},
		CL_SMGraveyard = {
			ZoneName = { BZ["Scarlet Monastery"]..ALC["Colon"]..ALC["Graveyard"] },
			Location = { BZ["Tirisfal Glades"] },
			LevelRange = "29-48",
			PlayerLimit = { 5 },
			DungeonID = 17,
			Acronym = L["GY"],
			Module = "Atlas_ClassicWoW",
			{ BLUE.." A) "..ALC["Entrance"] },
			{ WHIT.." 1) "..Atlas_GetBossName("Interrogator Vishas") },
			{ WHIT..INDENT..L["Vorrel Sengutz"] },
			{ WHIT.." 2) "..Atlas_GetBossName("Ironspine")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
			{ WHIT.." 3) "..Atlas_GetBossName("Azshir the Sleepless")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
			{ WHIT.." 4) "..Atlas_GetBossName("Fallen Champion")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
			{ WHIT.." 5) "..Atlas_GetBossName("Bloodmage Thalnos") },
		},
		CL_Scholomance = {
			ZoneName = { BZ["Scholomance"] },
			Location = { BZ["Western Plaguelands"] },
			DungeonID = 2,
			LevelRange = "56-60",
			PlayerLimit = { 5 },
			Acronym = L["Scholo"],
			WorldMapID = 476,
			JournalInstanceID = 246,
			Module = "Atlas_ClassicWoW",
			{ ORNG..ALC["Key"]..ALC["Colon"]..L["Blood of Innocents"]..ALC["L-Parenthesis"]..Atlas_GetBossName("Kirtonos the Herald")..ALC["R-Parenthesis"] },
			{ ORNG..ALC["Key"]..ALC["Colon"]..L["Divination Scryer"]..ALC["L-Parenthesis"]..Atlas_GetBossName("Death Knight Darkreaver")..ALC["R-Parenthesis"] },
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ BLUE.." B-C) "..ALC["Stairs"] },
			{ WHIT.." 1) "..Atlas_GetBossName("Blood Steward of Kirtonos") },
			{ WHIT..INDENT..L["The Deed to Southshore"] },
			{ WHIT.." 2) "..Atlas_GetBossName("Kirtonos the Herald")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"] },
			{ WHIT.." 3) "..Atlas_GetBossName("Jandice Barov") },
			{ WHIT.." 4) "..L["The Deed to Tarren Mill"] },
			{ WHIT.." 5) "..Atlas_GetBossName("Rattlegore")..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..Atlas_GetBossName("Death Knight Darkreaver")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"] },
			{ WHIT.." 6) "..Atlas_GetBossName("Marduk Blackpool") },
			{ WHIT..INDENT..Atlas_GetBossName("Vectus") },
			{ WHIT.." 7) "..Atlas_GetBossName("Ras Frostwhisper") },
			{ WHIT..INDENT..L["The Deed to Brill"] },
			{ WHIT..INDENT..Atlas_GetBossName("Kormok")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"] },
			{ WHIT.." 8) "..Atlas_GetBossName("Instructor Malicia") },	
			{ WHIT.." 9) "..Atlas_GetBossName("Doctor Theolen Krastinov") },
			{ WHIT.."10) "..Atlas_GetBossName("Lorekeeper Polkelt") },
			{ WHIT.."11) "..Atlas_GetBossName("The Ravenian") },
			{ WHIT.."12) "..Atlas_GetBossName("Lord Alexei Barov") },
			{ WHIT..INDENT..L["The Deed to Caer Darrow"] },
			{ WHIT.."13) "..Atlas_GetBossName("Lady Illucia Barov") },
			{ WHIT.."14) "..Atlas_GetBossName("Darkmaster Gandling") },
			{ GREN.." 1') "..L["Torch Lever"] },
			{ GREN.." 2') "..L["Secret Chest"] },
			{ GREN.." 3') "..L["Alchemy Lab"] },
		},
		CL_ShadowfangKeep = {
			ZoneName = { BZ["Shadowfang Keep"] },
			Location = { BZ["Silverpine Forest"] },
			DungeonID = 7,
			LevelRange = "18-32",
			PlayerLimit = { 5 },
			Acronym = L["SFK"],
			WorldMapID = 310,
			JournalInstanceID = 64,
			Module = "Atlas_ClassicWoW",
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ BLUE.." B-C) "..L["Walkway"] },
			{ BLUE..INDENT..Atlas_GetBossName("Deathsworn Captain")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
			{ WHIT.." 1) "..Atlas_GetBossName("Deathstalker Adamant") },
			{ WHIT..INDENT..Atlas_GetBossName("Sorcerer Ashcrombe") },
			{ WHIT..INDENT..Atlas_GetBossName("Rethilgore")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["Comma"]..ALC["Summon"]..ALC["R-Parenthesis"] },
			{ WHIT.." 2) "..Atlas_GetBossName("Razorclaw the Butcher")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["Comma"]..ALC["Summon"]..ALC["R-Parenthesis"] },
			{ WHIT.." 3) "..Atlas_GetBossName("Baron Silverlaine", 97), 97 },
			{ WHIT.." 4) "..Atlas_GetBossName("Commander Springvale", 98), 98 },
			{ WHIT.." 5) "..Atlas_GetBossName("Odo the Blindwatcher")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["Comma"]..ALC["Summon"]..ALC["R-Parenthesis"] },
			{ WHIT.." 6) "..Atlas_GetBossName("Fenrus the Devourer") },
			{ WHIT.." 7) "..Atlas_GetBossName("Wolf Master Nandos")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["Comma"]..ALC["Summon"]..ALC["R-Parenthesis"] },
			{ WHIT.." 8) "..Atlas_GetBossName("Archmage Arugal") },
			{ WHIT.." 9) "..Atlas_GetBossName("Fel Steed") },
			{ WHIT..INDENT..L["Jordan's Hammer"] },
		},
		CL_Stratholme = {
			ZoneName = { BZ["Stratholme"] },
			Location = { BZ["Eastern Plaguelands"] },
			Acronym = L["Strat"],
			DungeonID = 39,
			LevelRange = "56-60",
			PlayerLimit = { 5 },
			Module = "Atlas_ClassicWoW",
			{ ORNG..ALC["Key"]..ALC["Colon"]..L["Various Postbox Keys"]..ALC["L-Parenthesis"]..Atlas_GetBossName("Postmaster Malown")..ALC["R-Parenthesis"] },
			{ BLUE.." A) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Front"]..ALC["R-Parenthesis"] },
			{ BLUE.." B) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Side"]..ALC["R-Parenthesis"] },
			{ WHIT.." 1) "..Atlas_GetBossName("Skul")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..L["Stratholme Courier"], 10002 },
			{ WHIT..INDENT..L["Fras Siabi"] },
			{ WHIT.." 2) "..Atlas_GetBossName("Atiesh")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"] },
			{ WHIT.." 3) "..Atlas_GetBossName("Hearthsinger Forresten", 443)..ALC["L-Parenthesis"]..ALC["Varies"]..ALC["R-Parenthesis"], 10003 , 443 },
			{ WHIT.." 4) "..Atlas_GetBossName("The Unforgiven", 450), 450 },
			{ WHIT.." 5) "..L["Elder Farwhisper"]..ALC["L-Parenthesis"]..ALC["Lunar Festival"]..ALC["R-Parenthesis"], 10007 },
			{ WHIT.." 6) "..Atlas_GetBossName("Timmy the Cruel", 445), 445 },
			{ WHIT.." 7) "..Atlas_GetBossName("Malor the Zealous") },
			{ WHIT..INDENT..L["Medallion of Faith"] },
			{ WHIT.." 8) "..Atlas_GetBossName("Crimson Hammersmith")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..ALC["Blacksmithing Plans"] },
			{ WHIT.." 9) "..Atlas_GetBossName("Cannon Master Willey") },
			{ WHIT.."10) "..Atlas_GetBossName("Archivist Galford") },
			{ WHIT.."11) "..Atlas_GetBossName("Grand Crusader Dathrohan") },
			{ WHIT..INDENT..Atlas_GetBossName("Balnazzar", 449), 449 },
			{ WHIT..INDENT..Atlas_GetBossName("Sothos")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..Atlas_GetBossName("Jarien")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"] },
			{ WHIT.."12) "..Atlas_GetBossName("Magistrate Barthilas", 454)..ALC["L-Parenthesis"]..ALC["Varies"]..ALC["R-Parenthesis"], 454 },
			{ WHIT.."13) "..Atlas_GetBossName("Aurius", 10917) },
			{ WHIT.."14) "..Atlas_GetBossName("Stonespine")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
			{ WHIT.."15) "..Atlas_GetBossName("Baroness Anastari", 451), 451 },
			{ WHIT..INDENT..Atlas_GetBossName("Black Guard Swordsmith")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"], 10003 },
			{ WHIT..INDENT..ALC["Blacksmithing Plans"] },
			{ WHIT.."16) "..Atlas_GetBossName("Nerub'enkan", 452), 452 },
			{ WHIT.."17) "..Atlas_GetBossName("Maleki the Pallid", 453), 453 },
			{ WHIT.."18) "..Atlas_GetBossName("Ramstein the Gorger", 455), 455 },
			{ WHIT.."19) "..Atlas_GetBossName("Baron Rivendare") },
			{ WHIT..INDENT..L["Ysida Harmon"] },
			{ GREN.." 1') "..L["Crusaders' Square Postbox"] },
			{ GREN.." 2') "..L["Market Row Postbox"] },
			{ GREN.." 3') "..L["Festival Lane Postbox"] },
			{ GREN.." 4') "..L["Elders' Square Postbox"] },
			{ GREN.." 5') "..L["King's Square Postbox"] },
			{ GREN.." 6') "..L["Fras Siabi's Postbox"] },
			{ GREN..L["3rd Box Opened: Postmaster Malown"] },
		},
		CL_TheDeadminesEnt = {
			ZoneName = { BZ["The Deadmines"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
			Location = { BZ["Westfall"] },
			DungeonID = 5,
			LevelRange = "15-28",
			PlayerLimit = { 5 },
			Acronym = L["VC"],
			WorldMapID = 291,
			JournalInstanceID = 63,
			Module = "Atlas_ClassicWoW",
			NextMap = "TheDeadmines",
			{ BLUE.."A) "..ALC["Entrance"] },
			{ BLUE.."B) "..BZ["The Deadmines"] },
			{ WHIT.."1) "..Atlas_GetBossName("Marisa du'Paige")..ALC["L-Parenthesis"]..ALC["Varies"]..ALC["R-Parenthesis"] },
			{ WHIT.."2) "..Atlas_GetBossName("Brainwashed Noble")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
			{ WHIT.."3) "..Atlas_GetBossName("Foreman Thistlenettle") },
		},
		CL_TheDeadmines = {
			ZoneName = { BZ["The Deadmines"] },
			Location = { BZ["Westfall"] },
			DungeonID = 5,
			LevelRange = "15-28",
			PlayerLimit = { 5 },
			Acronym = L["VC"],
			WorldMapID = 291,
			Module = "Atlas_ClassicWoW",
			{ BLUE.." A) "..ALC["Entrance"] },
			{ BLUE.." B) "..ALC["Exit"] },
			{ WHIT.." 1) "..Atlas_GetBossName("Rhahk'Zor") },
			{ WHIT.." 2) "..Atlas_GetBossName("Miner Johnson")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
			{ WHIT.." 3) "..Atlas_GetBossName("Sneed") },
			{ WHIT..INDENT..L["Sneed's Shredder"] },
			{ WHIT.." 4) "..Atlas_GetBossName("Gilnid") },
			{ WHIT.." 5) "..L["Defias Gunpowder"] },
			{ WHIT.." 6) "..Atlas_GetBossName("Captain Greenskin") },
			{ WHIT..INDENT..Atlas_GetBossName("Edwin VanCleef") },
			{ WHIT..INDENT..Atlas_GetBossName("Mr. Smite") },
			{ WHIT..INDENT..Atlas_GetBossName("Cookie") },
		},
		CL_TheStockade = {
			ZoneName = { BZ["The Stockade"] },
			Location = { BZ["Stormwind City"] },
			DungeonID = 11,
			LevelRange = "22-34",
			PlayerLimit = { 5 },
			Acronym = L["Stocks"],
			WorldMapID = 225,
			JournalInstanceID = 238,
			Module = "Atlas_ClassicWoW",
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ WHIT.." 1) "..Atlas_GetBossName("Targorr the Dread")..ALC["L-Parenthesis"]..ALC["Varies"]..ALC["R-Parenthesis"] },
			{ WHIT.." 2) "..Atlas_GetBossName("Kam Deepfury") },
			{ WHIT.." 3) "..Atlas_GetBossName("Hamhock") },
			{ WHIT.." 4) "..Atlas_GetBossName("Bazil Thredd") },
			{ WHIT.." 5) "..Atlas_GetBossName("Dextren Ward") },
			{ WHIT.." 6) "..Atlas_GetBossName("Bruegal Ironknuckle")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
		},
		CL_TheSunkenTempleEnt = {
			ZoneName = { BZ["Sunken Temple"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
			Location = { BZ["Swamp of Sorrows"] },
			DungeonID = 27,
			LevelRange = "44-60",
			PlayerLimit = { 5 },
			Acronym = L["ST"],
			WorldMapID = 220,
			JournalInstanceID = 237,
			Module = "Atlas_ClassicWoW",
			NextMap = "TheSunkenTemple",
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ GREN..INDENT..ALC["Meeting Stone"] },
			{ GREN..INDENT..L["Jade"]..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
			{ BLUE.." B) "..BZ["Sunken Temple"], 10002 },
			{ WHIT.." 1) "..L["Kazkaz the Unholy"]..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"], 10003 },
			{ WHIT.." 2) "..L["Zekkis"]..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Lower"]..ALC["R-Parenthesis"], 10004 },
		},
		CL_TheSunkenTemple = {
			ZoneName = { BZ["Sunken Temple"] },
			Location = { BZ["Swamp of Sorrows"] },
			DungeonID = 27,
			LevelRange = "44-60",
			PlayerLimit = { 5 },
			Acronym = L["ST"],
			WorldMapID = 220,
			JournalInstanceID = 237,
			Module = "Atlas_ClassicWoW",
			PrevMap = "TheSunkenTempleEnt",
			{ ORNG..ALC["AKA"]..ALC["Colon"]..BZ["The Temple of Atal'Hakkar"] },
			{ BLUE.." A) "..ALC["Entrance"] },
			{ BLUE.." B) "..ALC["Stairs"] },
			{ BLUE.." C) "..L["Troll Minibosses"]..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"] },
			{ WHIT.." 1) "..Atlas_GetBossName("Altar of Hakkar") },
			{ WHIT..INDENT..L["Atal'alarion"] },
			{ WHIT.." 2) "..Atlas_GetBossName("Dreamscythe") },
			{ WHIT..INDENT..L["Weaver"] },
			{ WHIT.." 3) "..Atlas_GetBossName("Avatar of Hakkar", 457), 457 },
			{ WHIT.." 4) "..Atlas_GetBossName("Jammal'an the Prophet", 458), 458 },
			{ WHIT..INDENT..Atlas_GetBossName("Ogom the Wretched") },
			{ WHIT.." 5) "..Atlas_GetBossName("Morphaz", 459, 3)..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"], 459 },
			{ WHIT..INDENT..Atlas_GetBossName("Hazzas", 459, 4)..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"], 459 },
			{ WHIT.." 6) "..Atlas_GetBossName("Shade of Eranikus", 463), 463 },
			{ WHIT..INDENT..L["Essence Font"] },
			{ WHIT.." 7) "..Atlas_GetBossName("Spawn of Hakkar")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
			{ WHIT.." 8) "..L["Elder Starsong"]..ALC["L-Parenthesis"]..ALC["Lunar Festival"]..ALC["R-Parenthesis"], 10003 },
			{ GREN.."1'-6') "..L["Statue Activation Order"] },
		},
		CL_UldamanEnt = {
			ZoneName = { BZ["Uldaman"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
			Location = { BZ["Badlands"] },
			DungeonID = 21,
			LevelRange = "38-53",
			PlayerLimit = { 5 },
			Acronym = L["Ulda"],
			WorldMapID = 230,
			JournalInstanceID = 239,
			Module = "Atlas_ClassicWoW",
			NextMap = "Uldaman",
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ BLUE.." B) "..BZ["Uldaman"], 10002 },
			{ WHIT.." 1) "..Atlas_GetBossName("Hammertoe Grez"), 2909 },
			{ WHIT.." 2) "..Atlas_GetBossName("Magregan Deepshadow")..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"], 2932 },
			{ WHIT.." 3) "..L["Tablet of Ryun'Eh"], 4631 },
			{ WHIT.." 4) "..L["Krom Stoutarm's Chest"], 124389 },
			{ WHIT.." 5) "..L["Garrett Family Chest"], 124388 },
			{ GREN.." 1') "..Atlas_GetBossName("Digmaster Shovelphlange")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"], 7057 },
		},
		CL_Uldaman = {
			ZoneName = { BZ["Uldaman"] },
			Location = { BZ["Badlands"] },
			DungeonID = 21,
			LevelRange = "38-53",
			PlayerLimit = { 5 },
			Acronym = L["Ulda"],
			WorldMapID = 230,
			JournalInstanceID = 239,
			Module = "Atlas_ClassicWoW",
			PrevMap = "UldamanEnt",
			{ BLUE.." A) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Front"]..ALC["R-Parenthesis"], 10001 },
			{ BLUE.." B) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Back"]..ALC["R-Parenthesis"], 10002 },
			{ WHIT.." 1) "..Atlas_GetBossName("Baelog", 468, 1), 468 },
			{ WHIT..INDENT..Atlas_GetBossName("Eric \"The Swift\"", 468, 2), 468 },
			{ WHIT..INDENT..Atlas_GetBossName("Olaf", 468, 3), 468 },
			{ WHIT..INDENT..L["Baelog's Chest"] },
			{ WHIT..INDENT..L["Conspicuous Urn"] },
			{ WHIT.." 2) "..L["Remains of a Paladin"] },
			{ WHIT.." 3) "..Atlas_GetBossName("Revelosh", 467), 467 },
			{ WHIT.." 4) "..Atlas_GetBossName("Ironaya", 469), 469 },
			{ WHIT.." 5) "..Atlas_GetBossName("Obsidian Sentinel", 748), 748 },
			{ WHIT.." 6) "..Atlas_GetBossName("Annora <Master Enchanter>") },
			{ WHIT.." 7) "..Atlas_GetBossName("Ancient Stone Keeper", 470), 470 },
			{ WHIT.." 8) "..Atlas_GetBossName("Galgann Firehammer", 471), 471 },
			{ WHIT..INDENT..L["Tablet of Will"] },
			{ WHIT..INDENT..L["Shadowforge Cache"] },
			{ WHIT.." 9) "..Atlas_GetBossName("Grimlok", 472), 472 },
			{ WHIT.."10) "..Atlas_GetBossName("Archaedas", 473), 473 },
			{ WHIT.."11) "..L["The Discs of Norgannon"] },
			{ WHIT..INDENT..L["Ancient Treasure"] },

		},
		CL_ZulGurub = {
			ZoneName = { BZ["Zul'Gurub"] },
			Location = { BZ["Stranglethorn Vale"] },
			Acronym = L["ZG"],
			DungeonID = 41,
			LevelRange = "56-60",
			PlayerLimit = { 20 },
			Module = "Atlas_ClassicWoW",
			{ BLUE.." A) "..ALC["Entrance"] },
			{ WHIT.." 1) "..Atlas_GetBossName("High Priestess Jeklik")..ALC["L-Parenthesis"]..L["Bat"]..ALC["R-Parenthesis"] },
			{ WHIT.." 2) "..Atlas_GetBossName("High Priest Venoxis")..ALC["L-Parenthesis"]..L["Snake"]..ALC["R-Parenthesis"] },
			{ WHIT.." 3) "..Atlas_GetBossName("Zanza the Restless") },
			{ WHIT.." 4) "..Atlas_GetBossName("High Priestess Mar'li")..ALC["L-Parenthesis"]..L["Spider"]..ALC["R-Parenthesis"] },
			{ WHIT.." 5) "..Atlas_GetBossName("Bloodlord Mandokir")..ALC["L-Parenthesis"]..L["Raptor"]..", "..ALC["Optional"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..Atlas_GetBossName("Ohgan") },
			{ WHIT.." 6) "..Atlas_GetBossName("Edge of Madness")..ALC["L-Parenthesis"]..ALC["Optional"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..Atlas_GetBossName("Gri'lek")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..Atlas_GetBossName("Hazza'rah")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..Atlas_GetBossName("Renataki")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..Atlas_GetBossName("Wushoolay")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
			{ WHIT.." 7) "..Atlas_GetBossName("Gahz'ranka")..ALC["L-Parenthesis"]..ALC["Optional"]..", "..ALC["Summon"]..ALC["R-Parenthesis"] },
			{ WHIT.." 8) "..Atlas_GetBossName("High Priest Thekal")..ALC["L-Parenthesis"]..L["Tiger"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..Atlas_GetBossName("Zealot Zath") },
			{ WHIT..INDENT..Atlas_GetBossName("Zealot Lor'Khan") },
			{ WHIT.." 9) "..Atlas_GetBossName("High Priestess Arlokk")..ALC["L-Parenthesis"]..L["Panther"]..ALC["R-Parenthesis"] },
			{ WHIT.."10) "..Atlas_GetBossName("Jin'do the Hexxer")..ALC["L-Parenthesis"]..L["Undead"]..", "..ALC["Optional"]..ALC["R-Parenthesis"] },
			{ WHIT.."11) "..Atlas_GetBossName("Hakkar") },
			{ GREN.." 1') "..Atlas_GetBossName("Muddy Churning Waters") },
		},
		CL_Naxxramas = {
			ZoneName = { BZ["Naxxramas"], 3456 },
			Location = { BZ["Eastern Plaguelands"], 139 },
			LevelRange = "60+",
			PlayerLimit = { 40} ,
			Module = "Atlas_ClassicWoW",
			{ BLUE.."A) "..ALC["Entrance"] },
			{ BLUE..INDENT..Atlas_GetBossName("Archmage Tarsis Kir-Moldir"), 16381 },
			{ BLUE..INDENT..Atlas_GetBossName("Mr. Bigglesworth")..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"], 16998 },
			{ WHIT..L["Abomination Wing"] },
			{ WHIT..INDENT.."1) "..Atlas_GetBossName("Patchwerk"), 16028 },
			{ WHIT..INDENT.."2) "..Atlas_GetBossName("Grobbulus"), 15931 },
			{ WHIT..INDENT.."3) "..Atlas_GetBossName("Gluth"), 15932 },
			{ WHIT..INDENT.."4) "..Atlas_GetBossName("Thaddius"), 15928 },
			{ ORNG..L["Spider Wing"] },
			{ ORNG..INDENT.."1) "..Atlas_GetBossName("Anub'Rekhan"), 15956 },
			{ ORNG..INDENT.."2) "..Atlas_GetBossName("Grand Widow Faerlina"), 15953 },
			{ ORNG..INDENT.."3) "..Atlas_GetBossName("Maexxna"), 15952 },
			{ _RED..L["Deathknight Wing"] },
			{ _RED..INDENT.."1) "..Atlas_GetBossName("Instructor Razuvious"), 16061 },
			{ _RED..INDENT.."2) "..Atlas_GetBossName("Gothik the Harvester"), 16060 },
			{ _RED..INDENT.."3) "..Atlas_GetBossName("The Four Horsemen") },
			{ _RED..INDENT..INDENT..Atlas_GetBossName("Thane Korth'azz"), 16064 },
			{ _RED..INDENT..INDENT..Atlas_GetBossName("Lady Blaumeux"), 16065 },
			{ _RED..INDENT..INDENT..Atlas_GetBossName("Highlord Mograine <The Ashbringer>"), 16062 },
			{ _RED..INDENT..INDENT..Atlas_GetBossName("Sir Zeliek"), 16063 },
			{ _RED..INDENT..INDENT..L["Four Horsemen Chest"], 181366 },
			{ PURP..L["Plague Wing"] },
			{ PURP..INDENT.."1) "..Atlas_GetBossName("Noth the Plaguebringer"), 15954 },
			{ PURP..INDENT.."2) "..Atlas_GetBossName("Heigan the Unclean"), 15936 },
			{ PURP..INDENT.."3) "..Atlas_GetBossName("Loatheb"), 16011 },
			{ GREN..L["Frostwyrm Lair"] },
			{ GREN..INDENT.."1) "..Atlas_GetBossName("Sapphiron"), 15989 },
			{ GREN..INDENT.."2) "..Atlas_GetBossName("Kel'Thuzad"), 15990 },
		},
	--************************************************
	-- Kalimdor Instances (Classic)
	--************************************************
		CL_BlackfathomDeepsEnt = {
			ZoneName = { BZ["Blackfathom Deeps"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
			Location = { BZ["Ashenvale"] },
			DungeonID = 9,
			LevelRange = "20-34",
			PlayerLimit = { 5 },
			Acronym = L["BFD"],
			WorldMapID = 221,
			JournalInstanceID = 227,
			Module = "Atlas_ClassicWoW",
			NextMap = "BlackfathomDeepsA",
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ BLUE.." B) "..BZ["Blackfathom Deeps"], 10002 },
		},
		CL_BlackfathomDeepsA = {
			ZoneName = { BZ["Blackfathom Deeps"]..ALC["MapA"] },
			Location = { BZ["Ashenvale"] },
			DungeonID = 9,
			LevelRange = "20-34",
			PlayerLimit = { 5 },
			Acronym = L["BFD"],
			WorldMapID = 221,
			JournalInstanceID = 227,
			Module = "Atlas_ClassicWoW",
			PrevMap = "BlackfathomDeepsEnt",
			NextMap = "BlackfathomDeepsB",
			{ BLUE.." A) "..ALC["Entrance"] },
			{ WHIT.." 1) "..Atlas_GetBossName("Ghamoo-ra") },
			{ WHIT.." 2) "..L["Lorgalis Manuscript"] },
			{ WHIT.." 3) "..Atlas_GetBossName("Lady Sarevess") },
			{ WHIT.." 4) "..L["Argent Guard Thaelrid"] },
			{ WHIT.." 5) "..Atlas_GetBossName("Gelihast") },
			{ WHIT.." 6) "..Atlas_GetBossName("Lorgus Jett")..ALC["L-Parenthesis"]..ALC["Varies"]..ALC["R-Parenthesis"] },
		},
		CL_BlackfathomDeepsB = {
			ZoneName = { BZ["Blackfathom Deeps"]..ALC["MapB"] },
			Location = { BZ["Ashenvale"] },
			DungeonID = 9,
			LevelRange = "20-34",
			PlayerLimit = { 5 },
			Acronym = L["BFD"],
			WorldMapID = 221,
			JournalInstanceID = 227,
			Module = "Atlas_ClassicWoW",
			PrevMap = "BlackfathomDeepsA",
			NextMap = "BlackfathomDeepsC",
			{ WHIT.." 6) "..Atlas_GetBossName("Lorgus Jett")..ALC["L-Parenthesis"]..ALC["Varies"]..ALC["R-Parenthesis"] },
			{ WHIT.." 7) "..Atlas_GetBossName("Baron Aquanis")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"] },
			{ WHIT..INDENT..L["Fathom Core"] },
			{ WHIT.." 8) "..Atlas_GetBossName("Twilight Lord Kelris") },
			{ WHIT.."10) "..Atlas_GetBossName("Aku'mai") },
		},
		CL_BlackfathomDeepsC = {
			ZoneName = { BZ["Blackfathom Deeps"]..ALC["MapC"] },
			Location = { BZ["Ashenvale"] },
			DungeonID = 9,
			LevelRange = "20-34",
			PlayerLimit = { 5 },
			Acronym = L["BFD"],
			WorldMapID = 221,
			JournalInstanceID = 227,
			Module = "Atlas_ClassicWoW",
			PrevMap = "BlackfathomDeepsB",
			{ WHIT.." 9) "..Atlas_GetBossName("Old Serra'kis") },
		},
		CL_DireMaulEnt = {
			ZoneName = { BZ["Dire Maul"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
			Location = { BZ["Feralas"] },
			LevelRange = "54-60",
			DungeonID = 33,
			PlayerLimit = { 5 },
			Acronym = L["DM"],
			WorldMapID = 235,
			JournalInstanceID = 230,
			Module = "Atlas_ClassicWoW",
			NextMap = "DireMaulEast",
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ BLUE.." B) "..BZ["Dire Maul"]..ALC["L-Parenthesis"]..ALC["East"]..ALC["R-Parenthesis"], 10002 },
			{ BLUE.." C) "..BZ["Dire Maul"]..ALC["L-Parenthesis"]..ALC["North"]..ALC["R-Parenthesis"], 10003 },
			{ BLUE.." D) "..BZ["Dire Maul"]..ALC["L-Parenthesis"]..ALC["West"]..ALC["R-Parenthesis"], 10004 },
			{ GREN.." 1') "..L["Dire Pool"], 10005 },
			{ GREN.." 2') "..L["Dire Maul Arena"], 10006 },
			{ GREN..INDENT..L["Elder Mistwalker"]..ALC["L-Parenthesis"]..ALC["Lunar Festival"]..ALC["R-Parenthesis"] },
		},
		CL_DireMaulEast = {
			ZoneName = { BZ["Dire Maul"]..ALC["L-Parenthesis"]..ALC["East"]..ALC["R-Parenthesis"] },
			Location = { BZ["Feralas"] },
			DungeonID = 33,
			LevelRange = "54-60",
			PlayerLimit = { 5 },
			Acronym = L["DM"],
			WorldMapID = 239,
			DungeonLevel = 6,
			JournalInstanceID = 230,
			Module = "Atlas_ClassicWoW",
			PrevMap = "DireMaulEnt",
			NextMap = "DireMaulNorth",
			{ BLUE.." A-C) "..ALC["Entrance"] },
			{ BLUE.." D) "..ALC["Exit"] },
			{ WHIT.." 1) "..Atlas_GetBossName("Pusillin")..ALC["L-Parenthesis"]..L["Chase Begins"]..ALC["R-Parenthesis"] },
			{ WHIT.." 2) "..Atlas_GetBossName("Pusillin")..ALC["L-Parenthesis"]..L["Chase Ends"]..ALC["R-Parenthesis"] },
			{ WHIT.." 3) "..Atlas_GetBossName("Zevrim Thornhoof", 402)..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"], 402 },
			{ WHIT..INDENT..Atlas_GetBossName("Hydrospawn", 403), 403 },
			{ WHIT..INDENT..Atlas_GetBossName("Lethtendris", 404), 404 },
			{ WHIT..INDENT..Atlas_GetBossName("Pimgib") },
			{ WHIT.." 4) "..L["Old Ironbark"]..ALC["Slash"]..L["Ironbark the Redeemed"] },
			{ WHIT.." 5) "..Atlas_GetBossName("Alzzin the Wildshaper", 405), 405 },
			{ WHIT..INDENT..Atlas_GetBossName("Isalien")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"] },
		},
		CL_DireMaulNorth = {
			ZoneName = { BZ["Dire Maul"]..ALC["L-Parenthesis"]..ALC["North"]..ALC["R-Parenthesis"] },
			Location = { BZ["Feralas"] },
			DungeonID = 37,
			LevelRange = "56-60",
			PlayerLimit = { 5 },
			Acronym = L["DM"],
			WorldMapID = 234,
			DungeonLevel = 1,
			JournalInstanceID = 230,
			Module = "Atlas_ClassicWoW",
			PrevMap = "DireMaulEast",
			NextMap = "DireMaulWest",
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ WHIT.." 1) "..Atlas_GetBossName("Guard Mol'dar", 411), 411 },
			{ WHIT.." 2) "..Atlas_GetBossName("Stomper Kreeg", 412), 412 },
			{ WHIT.." 3) "..Atlas_GetBossName("Guard Fengus", 413), 413 },
			{ WHIT.." 4) "..L["Knot Thimblejack"] },
			{ WHIT..INDENT..Atlas_GetBossName("Guard Slip'kik", 414), 414 },
			{ WHIT.." 5) "..Atlas_GetBossName("Captain Kromcrush", 415), 415 },
			{ WHIT.." 6) "..Atlas_GetBossName("King Gordok", 417), 417 },
			{ WHIT..INDENT..Atlas_GetBossName("Cho'Rush the Observer", 416), 416 },
		},
		CL_DireMaulWest = {
			ZoneName = { BZ["Dire Maul"]..ALC["L-Parenthesis"]..ALC["West"]..ALC["R-Parenthesis"] },
			Location = { BZ["Feralas"] },
			DungeonID = 35,
			LevelRange = "56-60",
			PlayerLimit = { 5 },
			Acronym = L["DM"],
			WorldMapID = 237,
			DungeonLevel = 4,
			JournalInstanceID = 230,
			Module = "Atlas_ClassicWoW",
			PrevMap = "DireMaulNorth",
			{ ORNG..ALC["Key"]..ALC["Colon"]..ALIL["J'eevee's Jar"]..ALC["L-Parenthesis"]..Atlas_GetBossName("Lord Hel'nurath")..ALC["R-Parenthesis"] },
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ BLUE.." B) "..L["Pylons"], 10002 },
			{ WHIT.." 1) "..L["Shen'dralar Ancient"], 10006 },
			{ WHIT.." 2) "..Atlas_GetBossName("Tendris Warpwood", 406), 406 },
			{ WHIT..INDENT..L["Ancient Equine Spirit"], 10005 },
			{ WHIT.." 3) "..Atlas_GetBossName("Illyanna Ravenoak", 407), 407 },
			{ WHIT..INDENT..L["Ferra"] },
			{ WHIT.." 4) "..Atlas_GetBossName("Magister Kalendris", 408), 408 },
			{ WHIT.." 5) "..Atlas_GetBossName("Tsu'zee")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"], 10008 },
			{ WHIT.." 6) "..Atlas_GetBossName("Immol'thar", 409), 409 },
			{ WHIT..INDENT..Atlas_GetBossName("Lord Hel'nurath")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"] },
			{ WHIT.." 7) "..Atlas_GetBossName("Prince Tortheldrin", 410), 410 },
			{ GREN.." 1') "..L["Library"] },
			{ GREN..INDENT..L["Falrin Treeshaper"] },
			{ GREN..INDENT..L["Lorekeeper Lydros"] },
			{ GREN..INDENT..L["Lorekeeper Javon"] },
			{ GREN..INDENT..L["Lorekeeper Kildrath"] },
			{ GREN..INDENT..L["Lorekeeper Mykos"] },
			{ GREN..INDENT..L["Shen'dralar Provisioner"] },
			{ GREN..INDENT..L["Skeletal Remains of Kariel Winthalus"] },
		},
		CL_MaraudonEnt = {
			ZoneName = { BZ["Maraudon"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
			Location = { BZ["Desolace"] },
			DungeonID = 35,
			LevelRange = "40-58",
			PlayerLimit = { 5 },
			Acronym = L["Mara"],
			WorldMapID = 280,
			JournalInstanceID = 232,
			Module = "Atlas_ClassicWoW",
			NextMap = "Maraudon",
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ WHIT..INDENT..L["The Nameless Prophet"]..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["R-Parenthesis"] },
			{ BLUE.." B) "..BZ["Maraudon"]..ALC["L-Parenthesis"]..ALC["Purple"]..ALC["R-Parenthesis"], 10002 },
			{ BLUE.." C) "..BZ["Maraudon"]..ALC["L-Parenthesis"]..ALC["Orange"]..ALC["R-Parenthesis"], 10003 },
			{ BLUE.." D) "..BZ["Maraudon"]..ALC["L-Parenthesis"]..ALC["Portal"]..ALC["Comma"]..ALC["Lower"]..ALC["R-Parenthesis"], 10004 },
			{ WHIT.."1) "..Atlas_GetBossName("Kolk <The First Kahn>") };
			{ WHIT.."2) "..Atlas_GetBossName("Gelk <The Second Kahn>") };
			{ WHIT.."3) "..Atlas_GetBossName("Magra <The Third Kahn>") };
			{ WHIT.."4) "..Atlas_GetBossName("Cavindra") };
		},
		CL_Maraudon = {
			ZoneName = { BZ["Maraudon"] },
			Location = { BZ["Desolace"] },
			DungeonID = 35,
			LevelRange = "40-58",
			PlayerLimit = { 5 },
			Acronym = L["Mara"],
			WorldMapID = 280,
			JournalInstanceID = 232,
			Module = "Atlas_ClassicWoW",
			PrevMap = "MaraudonEnt",
			{ BLUE.." A) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Orange"]..ALC["R-Parenthesis"], 10001 },
			{ BLUE.." B) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Purple"]..ALC["R-Parenthesis"], 10002 },
			{ BLUE.." C) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Portal"]..ALC["R-Parenthesis"], 10003 },
			{ WHIT.." 1) "..L["Veng (The Fifth Khan)"] },
			{ WHIT.." 2) "..Atlas_GetBossName("Noxxion", 423), 423 },
			{ WHIT.." 3) "..Atlas_GetBossName("Razorlash", 424), 424 },
			{ WHIT.." 4) "..L["Maraudos (The Fourth Khan)"] },
			{ WHIT.." 5) "..Atlas_GetBossName("Lord Vyletongue", 427), 427 },
			{ WHIT.." 6) "..Atlas_GetBossName("Meshlok the Harvester")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Wanders"]..ALC["R-Parenthesis"], 10004 },
			{ WHIT.." 7) "..Atlas_GetBossName("Celebras the Cursed", 428), 428 },
			{ WHIT.." 8) "..Atlas_GetBossName("Landslide", 429), 429 },
			{ WHIT.." 9) "..Atlas_GetBossName("Tinkerer Gizlock", 425), 425 },
			{ WHIT.."10) "..Atlas_GetBossName("Rotgrip", 430), 430 },
			{ WHIT.."11) "..Atlas_GetBossName("Princess Theradras", 431), 431 },
			{ WHIT.."12) "..L["Elder Splitrock"]..ALC["L-Parenthesis"]..ALC["Lunar Festival"]..ALC["R-Parenthesis"], 10005 },
		},
		CL_OnyxiasLair = {
			ZoneName = { BZ["Onyxia's Lair"] },
			Acronym = L["Ony"],
			Location = { BZ["Dustwallow Marsh"] },
			DungeonID = 45,
			LevelRange = "60",
			PlayerLimit = { 40 },
			Module = "Atlas_ClassicWoW",
			{ ORNG..ALC["Attunement Required"] },
			{ ORNG..ALC["Key"]..ALC["Colon"]..L["Drakefire Amulet"] },
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ WHIT.." 1) "..Atlas_GetBossName("Onyxian Warders") },
			{ WHIT.." 2) "..Atlas_GetBossName("Whelp Eggs") },
			{ WHIT.." 3) "..Atlas_GetBossName("Onyxia") },
		},
		CL_TheRuinsofAhnQiraj = {
			ZoneName = { BZ["Ahn'Qiraj"]..ALC["Colon"]..BZ["Ruins of Ahn'Qiraj"] },
			Location = { BZ["Silithus"] },
			DungeonID = 160,
			Acronym = L["AQ20"],
			LevelRange = "60",
			PlayerLimit = { 20 },
			WorldMapID = 247,
			JournalInstanceID = 743,
			Module = "Atlas_ClassicWoW",
			{ ORNG..REPUTATION..ALC["Colon"]..BF["Cenarion Circle"] },
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ WHIT.." 1) "..Atlas_GetBossName("Kurinnaxx", 1537), 1537 },
			{ GREN..INDENT..Atlas_GetBossName("Lieutenant General Andorov") },
			{ GREN..INDENT..L["Four Kaldorei Elites"] },
			{ WHIT.." 2) "..Atlas_GetBossName("General Rajaxx", 1538), 1538 },
			{ WHIT..INDENT..L["Captain Qeez"] },
			{ WHIT..INDENT..L["Captain Tuubid"] },
			{ WHIT..INDENT..L["Captain Drenn"] },
			{ WHIT..INDENT..L["Captain Xurrem"] },
			{ WHIT..INDENT..L["Major Yeggeth"] },
			{ WHIT..INDENT..L["Major Pakkon"] },
			{ WHIT..INDENT..L["Colonel Zerran"] },
			{ WHIT.." 3) "..Atlas_GetBossName("Moam", 1539)..ALC["L-Parenthesis"]..ALC["Optional"]..ALC["R-Parenthesis"], 1539 },
			{ WHIT.." 4) "..Atlas_GetBossName("Buru the Gorger", 1540)..ALC["L-Parenthesis"]..ALC["Optional"]..ALC["R-Parenthesis"], 1540 },
			{ WHIT.." 5) "..Atlas_GetBossName("Ayamiss the Hunter", 1541)..ALC["L-Parenthesis"]..ALC["Optional"]..ALC["R-Parenthesis"], 1541 },
			{ WHIT.." 6) "..Atlas_GetBossName("Ossirian the Unscarred", 1542), 1542 },
			{ GREN.." 1') "..L["Safe Room"], 10008 },
		},
		CL_TheTempleofAhnQiraj = {
			ZoneName = { BZ["Ahn'Qiraj"]..ALC["Colon"]..BZ["Temple of Ahn'Qiraj"] },
			Location = { BZ["Silithus"] },
			DungeonID = 161,
			Acronym = L["AQ40"],
			LevelRange = "60",
			PlayerLimit = { 40 },
			WorldMapID = 319,
			JournalInstanceID = 744,
			Module = "Atlas_ClassicWoW",
			{ ORNG..REPUTATION..ALC["Colon"]..BF["Brood of Nozdormu"] },
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ BLUE.." B-D) "..ALC["Connection"], 10002 },
			{ WHIT.." 1) "..Atlas_GetBossName("The Prophet Skeram", 1543)..ALC["L-Parenthesis"]..ALC["Outside"]..ALC["R-Parenthesis"], 1543 },
			{ WHIT.." 2) "..L["The Bug Family"]..ALC["L-Parenthesis"]..ALC["Optional"]..ALC["R-Parenthesis"], 10004 },
			{ WHIT..INDENT..Atlas_GetBossName("Vem") },
			{ WHIT..INDENT..Atlas_GetBossName("Lord Kri") },
			{ WHIT..INDENT..Atlas_GetBossName("Princess Yauj") },
			{ WHIT.." 3) "..Atlas_GetBossName("Battleguard Sartura", 1544), 1544 },
			{ WHIT.." 4) "..Atlas_GetBossName("Fankriss the Unyielding", 1545), 1545 },
			{ WHIT.." 5) "..Atlas_GetBossName("Viscidus", 1548)..ALC["L-Parenthesis"]..ALC["Optional"]..ALC["R-Parenthesis"], 1548 },
			{ WHIT.." 6) "..Atlas_GetBossName("Princess Huhuran", 1546), 1546 },
			{ WHIT.." 7) "..Atlas_GetBossName("The Twin Emperors", 1549), 1549 },
			{ WHIT..INDENT..Atlas_GetBossName("Emperor Vek'lor") },
			{ WHIT..INDENT..Atlas_GetBossName("Emperor Vek'nilash") },
			{ GREN..INDENT..ALC["Teleporter destination"] },
			{ WHIT.." 8) "..Atlas_GetBossName("Ouro", 1550)..ALC["L-Parenthesis"]..ALC["Optional"]..ALC["R-Parenthesis"], 1550 },
			{ WHIT.." 9) "..Atlas_GetBossName("C'Thun", 1551), 1551 },
			{ GREN.." 1') "..L["Andorgos <Brood of Malygos>"]..ALC["L-Parenthesis"]..ALC["Teleporter"]..ALC["R-Parenthesis"], 10012 },
			{ GREN..INDENT..L["Vethsera <Brood of Ysera>"] },
			{ GREN..INDENT..L["Kandrostrasz <Brood of Alexstrasza>"] },
			{ GREN.." 2') "..L["Arygos"], 10013 },
			{ GREN..INDENT..L["Caelestrasz"] },
			{ GREN..INDENT..L["Merithra of the Dream"] },
			{ GREN..INDENT..ALC["Teleporter destination"] },
			--Atlas_GetBossName("Silithid Royalty", 1547)
		},
		CL_RagefireChasm = {
			ZoneName = { BZ["Ragefire Chasm"] },
			Location = { BZ["Orgrimmar"] },
			DungeonID = 3,
			LevelRange = "13-22",
			PlayerLimit = { 5 },
			Acronym = L["RFC"],
			WorldMapID = 213,
			JournalInstanceID = 226,
			Module = "Atlas_ClassicWoW",
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ WHIT.." 1) "..Atlas_GetBossName("Oggleflint") },
			{ WHIT.." 2) "..Atlas_GetBossName("Taragaman the Hungerer") },
			{ WHIT.." 3) "..Atlas_GetBossName("Jergosh the Invoker") },
			{ WHIT.." 4) "..Atlas_GetBossName("Bazzalan") },
		},
		CL_RazorfenDowns = {
			ZoneName = { BZ["Razorfen Downs"] },
			Location = { BZ["The Barrens"] },
			DungeonID = 19,
			LevelRange = "33-47",
			PlayerLimit = { 5 },
			Acronym = L["RFD"],
			WorldMapID = 300,
			JournalInstanceID = 233,
			Module = "Atlas_ClassicWoW",
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ WHIT.." 1) "..Atlas_GetBossName("Tuten'kash") },
			{ WHIT.." 2) "..Atlas_GetBossName("Henry Stern") },
			{ WHIT..INDENT..L["Belnistrasz"] },
			{ WHIT.." 3) "..Atlas_GetBossName("Mordresh Fire Eye") },
			{ WHIT.." 4) "..Atlas_GetBossName("Glutton") },
			{ WHIT.." 5) "..Atlas_GetBossName("Ragglesnout")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Varies"]..ALC["R-Parenthesis"] },
			{ WHIT.." 6) "..Atlas_GetBossName("Amnennar the Coldbringer") },
			{ WHIT.." 7) "..Atlas_GetBossName("Plaguemaw the Rotting") },
		},
		CL_RazorfenKraul = {
			ZoneName = { BZ["Razorfen Kraul"] },
			Location = { BZ["The Barrens"] },
			DungeonID = 15,
			LevelRange = "24-40",
			PlayerLimit = { 5 },
			Acronym = L["RFK"],
			WorldMapID = 301,
			JournalInstanceID = 234,
			Module = "Atlas_ClassicWoW",
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ WHIT.." 1) "..Atlas_GetBossName("Roogug") },
			{ WHIT.." 2) "..Atlas_GetBossName("Aggem Thorncurse") },
			{ WHIT.." 3) "..Atlas_GetBossName("Death Speaker Jargba") },
			{ WHIT.." 4) "..Atlas_GetBossName("Overlord Ramtusk") },
			{ WHIT.." 5) "..Atlas_GetBossName("Agathelos the Raging") },
			{ WHIT.." 6) "..Atlas_GetBossName("Blind Hunter")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
			{ WHIT.." 7) "..Atlas_GetBossName("Charlga Razorflank") },
			{ WHIT.." 8) "..L["Willix the Importer"] },
			{ WHIT..INDENT..L["Heralath Fallowbrook"] },
			{ WHIT.." 9) "..Atlas_GetBossName("Earthcaller Halmgar")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
		},
		CL_WailingCavernsEnt = {
			ZoneName = { BZ["Wailing Caverns"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
			Location = { BZ["The Barrens"] },
			DungeonID = 1,
			LevelRange = "15-28",
			PlayerLimit = { 5 },
			Acronym = L["WC"],
			WorldMapID = 279,
			JournalInstanceID = 240,
			Module = "Atlas_ClassicWoW",
			NextMap = "WailingCaverns",
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ BLUE.." B) "..BZ["Wailing Caverns"], 10002 },
			{ WHIT.." 1) "..Atlas_GetBossName("Mad Magglish")..ALC["L-Parenthesis"]..ALC["Varies"]..ALC["R-Parenthesis"], 10003 },
			{ WHIT.." 2) "..Atlas_GetBossName("Trigore the Lasher")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"], 10004 },
			{ WHIT.." 3) "..Atlas_GetBossName("Boahn")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"], 10005 },
		},
		CL_WailingCaverns = {
			ZoneName = { BZ["Wailing Caverns"] },
			Location = { BZ["The Barrens"] },
			DungeonID = 1,
			LevelRange = "15-28",
			PlayerLimit = { 5 },
			Acronym = L["WC"],
			WorldMapID = 279,
			DungeonLevel = 1,
			JournalInstanceID = 240,
			Module = "Atlas_ClassicWoW",
			PrevMap = "WailingCavernsEnt",
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ WHIT.." 1) "..L["Disciple of Naralex"] },
			{ WHIT.." 2) "..Atlas_GetBossName("Lord Cobrahn", 475), 475 },
			{ WHIT.." 3) "..Atlas_GetBossName("Lady Anacondra", 474), 474 },
			{ WHIT.." 4) "..Atlas_GetBossName("Kresh", 477)..ALC["L-Parenthesis"]..ALC["Varies"]..ALC["R-Parenthesis"], 477 },
			{ WHIT.." 5) "..Atlas_GetBossName("Lord Pythas", 476), 476 },
			{ WHIT.." 6) "..Atlas_GetBossName("Skum", 478), 478 },
			{ WHIT.." 7) "..Atlas_GetBossName("Lord Serpentis", 479)..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"], 479 },
			{ WHIT.." 8) "..Atlas_GetBossName("Verdan the Everliving", 480)..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"], 480 },
			{ WHIT.." 9) "..Atlas_GetBossName("Mutanus the Devourer", 481), 481 },
			{ WHIT..INDENT..L["Naralex"] },
			{ WHIT.."10) "..Atlas_GetBossName("Deviate Faerie Dragon")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Varies"]..ALC["R-Parenthesis"], 10002 },
		},
		CL_ZulFarrak = {
			ZoneName = { BZ["Zul'Farrak"] },
			Location = { BZ["Tanaris"] },
			DungeonID = 23,
			LevelRange = "43-54",
			PlayerLimit = { 5 },
			Acronym = L["ZF"],
			WorldMapID = 219,
			JournalInstanceID = 241,
			Module = "Atlas_ClassicWoW",
			{ BLUE.." A) "..ALC["Entrance"], 10001 },
			{ WHIT.." 1) "..Atlas_GetBossName("Antu'sul", 484), 484 },
			{ WHIT.." 2) "..Atlas_GetBossName("Theka the Martyr", 485), 485 },
			{ WHIT.." 3) "..Atlas_GetBossName("Witch Doctor Zum'rah", 486), 486 },
			{ WHIT..INDENT..L["Zul'Farrak Dead Hero"] },
			{ WHIT.." 4) "..Atlas_GetBossName("Nekrum Gutchewer") },
			{ WHIT..INDENT..Atlas_GetBossName("Shadowpriest Sezz'ziz") },
			{ WHIT..INDENT..Atlas_GetBossName("Dustwraith")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Varies"]..ALC["R-Parenthesis"], 10003 },
			{ WHIT.." 5) "..Atlas_GetBossName("Sergeant Bly") },
			{ WHIT..INDENT..L["Weegli Blastfuse"] },
			{ WHIT..INDENT..Atlas_GetBossName("Murta Grimgut") },
			{ WHIT..INDENT..L["Raven"] },
			{ WHIT..INDENT..Atlas_GetBossName("Oro Eyegouge") },
			{ WHIT..INDENT..Atlas_GetBossName("Sandfury Executioner") },
			{ WHIT.." 6) "..Atlas_GetBossName("Hydromancer Velratha", 482), 482 },
			{ WHIT..INDENT..Atlas_GetBossName("Gahz'rilla", 483)..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"], 483 },
			{ WHIT..INDENT..L["Elder Wildmane"]..ALC["L-Parenthesis"]..ALC["Lunar Festival"]..ALC["R-Parenthesis"], 10005 },
			{ WHIT.." 7) "..Atlas_GetBossName("Chief Ukorz Sandscalp", 489), 489 },
			{ WHIT..INDENT..Atlas_GetBossName("Ruuzlu") },
			{ WHIT.." 8) "..Atlas_GetBossName("Zerillis")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Wanders"]..ALC["R-Parenthesis"], 10004 },
			{ WHIT.." 9) "..Atlas_GetBossName("Sandarr Dunereaver")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"], 10002 },
		},
	}


	-- Atlas Map NPC Description Data
	db.AtlasMaps_NPC_DB = {
	--************************************************
	-- Eastern Kingdoms Instances (Classic)
	--************************************************
	--************************************************
	-- Kalimdor Instances (Classic)
	--************************************************
	}

	--[[
		AssocDefaults{}

		Default map to be auto-selected when no SubZone data is available.

		For example, "Dire Maul" has a subzone called "Warpwood Quarter" located in East Dirl Maul, however, there are also 
		some areas which have not been named with any subzone, and we would like to pick a proper default map in this condition.

		Define this table entries only when the instance has multiple maps.

		Table index is zone name, it need to be localized value, but we will handle the localization with BabbleSubZone library.
		The table value is map's key-name.
	]]
	db.AssocDefaults = {
		[BZ["Blackrock Mountain"]] =		"CL_BlackrockMountainEnt",
		[BZ["Blackrock Spire"]] =		"CL_BlackrockSpireLower",
		[BZ["Hall of Blackhand"]] =		"CL_BlackrockSpireLower",
		[BZ["Dire Maul"]] =			"CL_DireMaulNorth",
		[BZ["The Deadmines"]] = 		"CL_TheDeadmines",
		[BZ["The Wailing Caverns"]] = 		"CL_WailingCavernsEnt",
		[BZ["Sunken Temple"]] = 		"CL_TheSunkenTemple",
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
		-- Blackrock Spire
		[BZ["Hall of Blackhand"]] = {
			-- Lower Blackrock Spire
			["CL_BlackrockSpireLower"] = {
				BZ["Hordemar City"],
				BZ["Mok'Doom"],
				BZ["Tazz'Alor"],
				BZ["Skitterweb Tunnels"],
				BZ["The Storehouse"],
				BZ["Halycon's Lair"],
				BZ["Chamber of Battle"],
			},
		},
		-- Dire Maul
		[BZ["Dire Maul"]] = {
			-- Dire Maul, Entrance
			["CL_DireMaulEnt"] = {
				BZ["Broken Commons"],
				-- Comment out below as they are currently redundant due to the Zone is Feralas
				--BZ["Eldreth Row"],
				--BZ["The Maul"],
			},
			-- Dire Maul, North
			["CL_DireMaulNorth"] = {
				BZ["Halls of Destruction"],
				BZ["Gordok's Seat"],
			},
			-- Dire Maul, East
			["CL_DireMaulEast"] = {
				BZ["Warpwood Quarter"],
				BZ["The Hidden Reach"],
				BZ["The Conservatory"],
				BZ["The Shrine of Eldretharr"],
			},
			-- Dire Maul, West
			["CL_DireMaulWest"] = {
				BZ["Capital Gardens"],
				BZ["Court of the Highborne"],
				BZ["Prison of Immol'thar"],
				BZ["The Athenaeum"],
			},
		},
		-- Stratholme
		[BZ["Stratholme"]] = {
			-- Stratholme
			["CL_Stratholme"] = {
				BZ["King's Square"],
				BZ["Festival Lane"],
				BZ["Market Row"],
				BZ["Crusaders' Square"],
				BZ["The Scarlet Bastion"],
				BZ["The Hall of Lights"],
				BZ["The Hoard"],
				BZ["The Crimson Throne"],
				BZ["Elders' Square"],
				BZ["The Gauntlet"],
				BZ["Slaughter Square"],
				BZ["The Slaughter House"],
			},
		},
		-- The Deadmines
		[BZ["The Deadmines"]] = {
			["CL_TheDeadmines"] = {
				BZ["Goblin Foundry"],
				BZ["Mast Room"],
				BZ["Ironclad Cove"],
			},
		},
		-- The Stockade
		[BZ["The Stockade"]] = {
			-- The Stockade
			["CL_TheStockade"] = {
				BZ["Stormwind Stockade"],
			},
		},
		-- Wailing Caverns
		[BZ["Wailing Caverns"]] = {
			-- Wailing Caverns, Entrance
			["CL_WailingCavernsEnt"] = {
				BZ["Cavern of Mists"],
			},
			-- Wailing Caverns
			["CL_WailingCaverns"] = {
				BZ["Screaming Gully"],
				BZ["Dreamer's Rock"],
				BZ["Pit of Fangs"],
				BZ["Crag of the Everliving"],
				BZ["Pit of Fangs"],
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
		[BZ["Burning Steppes"]] = 		"CL_BlackrockMountainEnt",
		[BZ["Searing Gorge"]] = 		"CL_BlackrockMountainEnt",
		[BZ["Ashenvale"]] = 			"CL_BlackfathomDeepsEnt",
		[BZ["Feralas"]] = 			"CL_DireMaulEnt",
		[BZ["Dun Morogh"]] = 			"CL_GnomereganEnt",
		[BZ["Desolace"]] = 			"CL_MaraudonEnt",
		[BZ["Orgrimmar"]] = 			"CL_RagefireChasm",
		[BZ["Thousand Needles"]] = 		"CL_RazorfenDowns",
		[BZ["Southern Barrens"]] = 		"CL_RazorfenKraul",
		[BZ["Silverpine Forest"]] = 		"CL_ShadowfangKeep",
		[BZ["Tirisfal Glades"]] = 		"CL_ScarletMonasteryEnt",
		[BZ["Western Plaguelands"]] = 		"CL_Scholomance",
		[BZ["Eastern Plaguelands"]] = 		"CL_Stratholme",
		[BZ["Westfall"]] = 			"CL_TheDeadminesEnt",
		[BZ["Stormwind City"]] = 		"CL_TheStockade",
		[BZ["Swamp of Sorrows"]] = 		"CL_TheSunkenTempleEnt",
		[BZ["Badlands"]] = 			"CL_UldamanEnt",
		[BZ["Northern Barrens"]] = 		"CL_WailingCavernsEnt",
		[BZ["Tanaris"]] = 			"CL_ZulFarrak",
		[BZ["Ahn'Qiraj: The Fallen Kingdom"]] = "CL_TheTempleofAhnQiraj",
		[BZ["Silithus"]] = 			"CL_TheTempleofAhnQiraj",
		[BZ["Dustwallow Marsh"]] = 		"CL_OnyxiasLair",
	}

	-- Yes, the following two tables are redundant, but they're both here in case there's ever more than one entrance map for an instance
	-- Entrance maps to instance maps
	db.EntToInstMatches = {
		["CL_BlackfathomDeepsEnt"] =		{"CL_BlackfathomDeepsA","CL_BlackfathomDeepsB","CL_BlackfathomDeepsC"},
		["CL_BlackrockMountainEnt"] =		{"CL_BlackrockDepths","CL_BlackwingLair","CL_BlackrockSpireLower","CL_BlackrockSpireUpper","CL_MoltenCore"},
		["CL_DireMaulEnt"] =			{"CL_DireMaulEast","CL_DireMaulNorth","CL_DireMaulWest"},
		["CL_GnomereganEnt"] =			{"CL_Gnomeregan"},
		["CL_MaraudonEnt"] =			{"CL_Maraudon"},
		["CL_ScarletMonasteryEnt"] = 		{"CL_SMArmory", "CL_SMCathedral", "CL_SMGraveyard", "CL_SMLibrary"},
		["CL_TheDeadminesEnt"] =		{"CL_TheDeadmines"},
		["CL_TheSunkenTempleEnt"] =		{"CL_TheSunkenTemple"},
		["CL_UldamanEnt"] =			{"CL_Uldaman"},
		["CL_WailingCavernsEnt"] =		{"CL_WailingCaverns"},
	}

	-- Instance maps to entrance maps
	db.InstToEntMatches = {
		["CL_BlackfathomDeepsA"] =		{"CL_BlackfathomDeepsEnt"},
		["CL_BlackfathomDeepsB"] =		{"CL_BlackfathomDeepsEnt"},
		["CL_BlackfathomDeepsC"] =		{"CL_BlackfathomDeepsEnt"},
		["CL_BlackrockDepths"] =		{"CL_BlackrockMountainEnt"},
		["CL_BlackwingLair"] =			{"CL_BlackrockMountainEnt"},
		["CL_BlackrockSpireLower"] =		{"CL_BlackrockMountainEnt"},
		["CL_BlackrockSpireUpper"] =		{"CL_BlackrockMountainEnt"},
		["CL_MoltenCore"] =			{"CL_BlackrockMountainEnt"},
		["CL_DireMaulEast"] =			{"CL_DireMaulEnt"},
		["CL_DireMaulNorth"] =			{"CL_DireMaulEnt"},
		["CL_DireMaulWest"] =			{"CL_DireMaulEnt"},
		["CL_Gnomeregan"] =			{"CL_GnomereganEnt"},
		["CL_SMArmory"] =			{"CL_ScarletMonasteryEnt"},
		["CL_SMCathedral"] =			{"CL_ScarletMonasteryEnt"},
		["CL_SMGraveyard"] =			{"CL_ScarletMonasteryEnt"},
		["CL_SMLibrary"] =			{"CL_ScarletMonasteryEnt"},
		["CL_TheDeadmines"] =			{"CL_TheDeadminesEnt"},
		["CL_TheSunkenTemple"] =		{"CL_TheSunkenTempleEnt"},
		["CL_Uldaman"] =			{"CL_UldamanEnt"},
		["CL_WailingCaverns"] =			{"CL_WailingCavernsEnt"},
	}

	db.MapSeries = {
		["CL_BlackfathomDeepsA"] = 		{"CL_BlackfathomDeepsA","CL_BlackfathomDeepsB","CL_BlackfathomDeepsC"},
		["CL_BlackfathomDeepsB"] = 		{"CL_BlackfathomDeepsA","CL_BlackfathomDeepsB","CL_BlackfathomDeepsC"},
		["CL_BlackfathomDeepsC"] = 		{"CL_BlackfathomDeepsA","CL_BlackfathomDeepsB","CL_BlackfathomDeepsC"},
	}

	-- Links maps together that are part of the same instance
	db.SubZoneAssoc = {
		["CL_DireMaulNorth"] =			BZ["Dire Maul"],
		["CL_DireMaulEast"] =			BZ["Dire Maul"],
		["CL_DireMaulWest"] =			BZ["Dire Maul"],
		["CL_DireMaulEnt"] =			BZ["Dire Maul"],
		["CL_BlackfathomDeepsA"] = 		BZ["Blackfathom Deeps"],
		["CL_BlackfathomDeepsB"] = 		BZ["Blackfathom Deeps"],
		["CL_BlackfathomDeepsC"] = 		BZ["Blackfathom Deeps"],
	}

	db.DropDownLayouts_Order = {
		[ATLAS_DDL_CONTINENT] = {
			ATLAS_DDL_CONTINENT_EASTERN,
			ATLAS_DDL_CONTINENT_KALIMDOR,
		},
		[ATLAS_DDL_LEVEL] = {
			ATLAS_DDL_LEVEL_UNDER45,
			ATLAS_DDL_LEVEL_45TO60,
			ATLAS_DDL_LEVEL_60TO70,
		},
		[ATLAS_DDL_EXPANSION] = {
			ATLAS_DDL_EXPANSION_OLD,
		},
	}

	db.DropDownLayouts = {
		[ATLAS_DDL_CONTINENT] = {
			[ATLAS_DDL_CONTINENT_EASTERN] = {
				"CL_BlackrockMountainEnt",		-- Classic WoW, Catalysm, Draenor
				"CL_BlackrockDepths",		-- Classic WoW
				"CL_BlackwingLair",		-- Classic WoW
				"CL_TheDeadmines",			-- Classic WoW, Catalysm
				"CL_TheDeadminesEnt",		-- Classic WoW, Catalysm
				"CL_Gnomeregan",			-- Classic WoW
				"CL_GnomereganEnt",		-- Classic WoW
				"CL_BlackrockSpireLower",		-- Classic WoW
				"CL_BlackrockSpireUpper",		-- Classic WoW
				"CL_MoltenCore",			-- Classic WoW
				"CL_ShadowfangKeep",		-- Classic WoW, Catalysm
				"CL_Stratholme",			-- Classic WoW
				"CL_TheStockade",			-- Classic WoW
				"CL_TheSunkenTemple",		-- Classic WoW
				"CL_TheSunkenTempleEnt",		-- Classic WoW
				"CL_Uldaman",			-- Classic WoW
				"CL_UldamanEnt",			-- Classic WoW
				"CL_Scholomance",			-- Classic WoW
				"CL_ScarletMonasteryEnt",		-- Classic WoW
				"CL_SMArmory",			-- Classic WoW
				"CL_SMCathedral",			-- Classic WoW
				"CL_SMGraveyard",			-- Classic WoW
				"CL_SMLibrary",			-- Classic WoW
				"CL_ZulGurub",
				"CL_Naxxramas",
			},
			[ATLAS_DDL_CONTINENT_KALIMDOR] = {
				"CL_BlackfathomDeepsA",		-- Classic WoW
				"CL_BlackfathomDeepsB",		-- Classic WoW
				"CL_BlackfathomDeepsC",		-- Classic WoW
				"CL_BlackfathomDeepsEnt",		-- Classic WoW
				"CL_DireMaulEast",			-- Classic WoW
				"CL_DireMaulEnt",			-- Classic WoW
				"CL_DireMaulNorth",		-- Classic WoW
				"CL_DireMaulWest",			-- Classic WoW
				"CL_Maraudon",			-- Classic WoW
				"CL_MaraudonEnt",			-- Classic WoW
				"CL_OnyxiasLair",
				"CL_RagefireChasm",		-- Classic WoW
				"CL_RazorfenDowns",		-- Classic WoW
				"CL_RazorfenKraul",		-- Classic WoW
				"CL_TheTempleofAhnQiraj",
				"CL_TheRuinsofAhnQiraj",
				"CL_WailingCaverns",		-- Classic WoW
				"CL_WailingCavernsEnt",		-- Classic WoW
				"CL_ZulFarrak",			-- Classic WoW
			},
		},
		[ATLAS_DDL_EXPANSION] = {
			[ATLAS_DDL_EXPANSION_OLD] = {
				"CL_BlackfathomDeepsA",
				"CL_BlackfathomDeepsB",
				"CL_BlackfathomDeepsC",
				"CL_BlackfathomDeepsEnt",
				"CL_BlackrockMountainEnt",
				"CL_BlackrockDepths",
				"CL_BlackwingLair",
				"CL_DireMaulEast",
				"CL_DireMaulEnt",
				"CL_DireMaulNorth",
				"CL_DireMaulWest",
				"CL_Gnomeregan",
				"CL_GnomereganEnt",
				"CL_BlackrockSpireLower",		-- Classic WoW
				"CL_BlackrockSpireUpper",		-- Classic WoW
				"CL_Maraudon",
				"CL_MaraudonEnt",
				"CL_MoltenCore",
				"CL_OnyxiasLair",
				"CL_TheDeadmines",			-- Classic WoW, Catalysm
				"CL_TheDeadminesEnt",
				"CL_RagefireChasm",
				"CL_RazorfenDowns",
				"CL_RazorfenKraul",
				"CL_Scholomance",
				"CL_ShadowfangKeep",
				"CL_ScarletMonasteryEnt",
				"CL_SMArmory",			-- Classic WoW
				"CL_SMCathedral",			-- Classic WoW
				"CL_SMGraveyard",			-- Classic WoW
				"CL_SMLibrary",			-- Classic WoW
				"CL_Stratholme",			-- Classic WoW
				"CL_TheStockade",
				"CL_TheSunkenTemple",
				"CL_TheSunkenTempleEnt",
				"CL_TheTempleofAhnQiraj",
				"CL_TheRuinsofAhnQiraj",
				"CL_Uldaman",
				"CL_UldamanEnt",
				"CL_WailingCaverns",
				"CL_WailingCavernsEnt",
				"CL_ZulFarrak",
				"CL_ZulGurub",
				"CL_Naxxramas",
			},
		},
		[ATLAS_DDL_LEVEL] = {
			[ATLAS_DDL_LEVEL_UNDER45] = {
				"CL_BlackfathomDeepsA",		-- Classic WoW
				"CL_BlackfathomDeepsB",		-- Classic WoW
				"CL_BlackfathomDeepsC",		-- Classic WoW
				"CL_BlackfathomDeepsEnt",		-- Classic WoW
				"CL_Gnomeregan",			-- Classic WoW
				"CL_GnomereganEnt",		-- Classic WoW
				"CL_RagefireChasm",		-- Classic WoW
				"CL_RazorfenDowns",		-- Classic WoW
				"CL_RazorfenKraul",		-- Classic WoW
				"CL_ShadowfangKeep",		-- Classic WoW
				"CL_ScarletMonasteryEnt",		-- Classic WoW
				"CL_SMArmory",			-- Classic WoW
				"CL_SMCathedral",			-- Classic WoW
				"CL_SMGraveyard",			-- Classic WoW
				"CL_SMLibrary",			-- Classic WoW
				"CL_TheDeadmines",			-- Classic WoW, Catalysm
				"CL_TheDeadminesEnt",		-- Classic WoW
				"CL_TheStockade",			-- Classic WoW
				"CL_Uldaman",			-- Classic WoW
				"CL_UldamanEnt",			-- Classic WoW
				"CL_WailingCaverns",		-- Classic WoW
				"CL_WailingCavernsEnt",		-- Classic WoW
			},
			[ATLAS_DDL_LEVEL_45TO60] = {
				"CL_BlackrockMountainEnt",		-- Classic WoW
				"CL_BlackrockDepths",		-- Classic WoW
				"CL_DireMaulEast",			-- Classic WoW
				"CL_DireMaulEnt",			-- Classic WoW
				"CL_DireMaulNorth",		-- Classic WoW
				"CL_DireMaulWest",			-- Classic WoW
				"CL_BlackrockSpireLower",		-- Classic WoW
				"CL_BlackrockSpireUpper",		-- Classic WoW
				"CL_Maraudon",			-- Classic WoW
				"CL_MaraudonEnt",			-- Classic WoW
				"CL_Scholomance",			-- Classic WoW
				"CL_Stratholme",			-- Classic WoW
				"CL_TheSunkenTemple",		-- Classic WoW
				"CL_TheSunkenTempleEnt",		-- Classic WoW
				"CL_ZulFarrak",			-- Classic WoW
			},
			[ATLAS_DDL_LEVEL_60TO70] = {
				"CL_BlackrockMountainEnt",		-- Classic WoW
				"CL_BlackwingLair",		-- Classic WoW
				"CL_MoltenCore",			-- Classic WoW
				"CL_OnyxiasLair",
				"CL_TheTempleofAhnQiraj",
				"CL_TheRuinsofAhnQiraj",
				"CL_ZulGurub",
				"CL_Naxxramas",
			},
		},
		[ATLAS_DDL_PARTYSIZE] = {
			[ATLAS_DDL_PARTYSIZE_5] = {
				"CL_BlackrockMountainEnt",		-- Classic WoW
				"CL_BlackfathomDeepsA",		-- Classic WoW
				"CL_BlackfathomDeepsB",		-- Classic WoW
				"CL_BlackfathomDeepsC",		-- Classic WoW
				"CL_BlackfathomDeepsEnt",		-- Classic WoW
				"CL_BlackrockDepths",		-- Classic WoW
				"CL_BlackrockSpireLower",		-- Classic WoW
				"CL_BlackrockSpireUpper",		-- Classic WoW
				"CL_TheDeadmines",			-- Classic WoW
				"CL_TheDeadminesEnt",		-- Classic WoW
				"CL_DireMaulEast",			-- Classic WoW
				"CL_DireMaulEnt",			-- Classic WoW
				"CL_DireMaulNorth",		-- Classic WoW
				"CL_DireMaulWest",			-- Classic WoW
				"CL_Gnomeregan",			-- Classic WoW
				"CL_GnomereganEnt",		-- Classic WoW
				"CL_Maraudon",			-- Classic WoW
				"CL_MaraudonEnt",			-- Classic WoW
				"CL_RagefireChasm",		-- Classic WoW
				"CL_RazorfenDowns",		-- Classic WoW
				"CL_RazorfenKraul",		-- Classic WoW
				"CL_SMArmory",			-- Classic WoW
				"CL_SMCathedral",			-- Classic WoW
				"CL_SMGraveyard",			-- Classic WoW
				"CL_SMLibrary",			-- Classic WoW
				"CL_ScarletMonasteryEnt",		-- Classic WoW
				"CL_Scholomance",			-- Classic WoW
				"CL_ShadowfangKeep",		-- Classic WoW
				"CL_TheStockade",			-- Classic WoW
				"CL_Stratholme",			-- Classic WoW
				"CL_TheSunkenTemple",		-- Classic WoW
				"CL_TheSunkenTempleEnt",		-- Classic WoW
				"CL_Uldaman",			-- Classic WoW
				"CL_UldamanEnt",			-- Classic WoW
				"CL_WailingCaverns",		-- Classic WoW
				"CL_WailingCavernsEnt",		-- Classic WoW
				"CL_ZulFarrak",			-- Classic WoW
			},
			[ATLAS_DDL_PARTYSIZE_20TO40] = {
				"CL_BlackrockMountainEnt",		-- Classic WoW
				"CL_BlackwingLair",		-- Classic WoW
				"CL_MoltenCore",			-- Classic WoW
				"CL_OnyxiasLair",
				"CL_TheTempleofAhnQiraj",
				"CL_TheRuinsofAhnQiraj",
				"CL_ZulGurub",
				"CL_Naxxramas",
			},
		},
		[ATLAS_DDL_TYPE] = {
			[ATLAS_DDL_TYPE_INSTANCE] = {
				"CL_BlackfathomDeepsA",		-- Classic WoW
				"CL_BlackfathomDeepsB",		-- Classic WoW
				"CL_BlackfathomDeepsC",		-- Classic WoW
				"CL_BlackrockDepths",		-- Classic WoW
				"CL_BlackwingLair",		-- Classic WoW
				"CL_BlackrockSpireLower",		-- Classic WoW
				"CL_BlackrockSpireUpper",		-- Classic WoW
				"CL_TheDeadmines",			-- Classic WoW
				"CL_DireMaulEast",			-- Classic WoW
				"CL_DireMaulNorth",		-- Classic WoW
				"CL_DireMaulWest",			-- Classic WoW
				"CL_Gnomeregan",			-- Classic WoW
				"CL_Maraudon",			-- Classic WoW
				"CL_OnyxiasLair",
				"CL_MoltenCore",			-- Classic WoW
				"CL_RagefireChasm",		-- Classic WoW
				"CL_RazorfenDowns",		-- Classic WoW
				"CL_RazorfenKraul",		-- Classic WoW
				"CL_SMArmory",			-- Classic WoW
				"CL_SMCathedral",			-- Classic WoW
				"CL_SMGraveyard",			-- Classic WoW
				"CL_SMLibrary",			-- Classic WoW
				"CL_Scholomance",			-- Classic WoW
				"CL_ShadowfangKeep",		-- Classic WoW
				"CL_Stratholme",			-- Classic WoW
				"CL_TheStockade",			-- Classic WoW
				"CL_TheSunkenTemple",		-- Classic WoW
				"CL_Uldaman",			-- Classic WoW
				"CL_WailingCaverns",		-- Classic WoW
				"CL_ZulFarrak",			-- Classic WoW
				"CL_ZulGurub",
				"CL_TheTempleofAhnQiraj",
				"CL_TheRuinsofAhnQiraj",
				"CL_Naxxramas",
			},
			[ATLAS_DDL_TYPE_ENTRANCE] = {
				"CL_BlackrockMountainEnt",		-- Classic WoW
				"CL_TheDeadminesEnt",		-- Classic WoW
				"CL_ScarletMonasteryEnt",		-- Classic WoW
				"CL_BlackfathomDeepsEnt",		-- Classic WoW
				"CL_DireMaulEnt",			-- Classic WoW
				"CL_GnomereganEnt",		-- Classic WoW
				"CL_MaraudonEnt",			-- Classic WoW
				"CL_TheSunkenTempleEnt",		-- Classic WoW
				"CL_UldamanEnt",			-- Classic WoW
				"CL_WailingCavernsEnt",		-- Classic WoW
			},
		},
	}
end
