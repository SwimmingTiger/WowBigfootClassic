-- $Id: Constants.lua 400 2022-07-23 10:38:27Z arithmandar $
--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 ~ 2010 - Dan Gilbert <dan.b.gilbert at gmail dot com>
	Copyright 2010 - Lothaer <lothayer at gmail dot com>, Atlas Team
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

-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
-- Libraries
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
private.addon_name = "Atlas"

local constants = { }
private.constants = constants

-- Initialization
ATLAS_VERSION = GetAddOnMetadata(private.addon_name, "Version")
ATLAS_PLAYER_FACTION = UnitFactionGroup("player")
ATLAS_DROPDOWNS = {}
ATLAS_INST_ENT_DROPDOWN = {}
ATLAS_NUM_LINES = 26
ATLAS_CUR_LINES = 0
ATLAS_SCROLL_LIST = {}
ATLAS_SCROLL_ID = {}
ATLAS_DATA = {}
ATLAS_SEARCH_METHOD = nil
ATLAS_PLUGINS = {}
ATLAS_PLUGIN_DATA = {}
Atlas_MapTypes = {}
AtlasMaps_NPC_DB = {}
ATLAS_SMALLFRAME_SELECTED = false
ATLAS_DROPDOWN_WIDTH = 190
ATLAS_PLUGINS_COLOR = "|cff66cc33"
ATLAS_OLD_TYPE = false
ATLAS_OLD_ZONE = false
ATLAS_MAX_MENUITEMS = 30
ATLAS_MODULE_MENUS = 0
ATLAS_PLUGIN_MENUS = 0
ATLAS_DROPDOWN_TYPES = {}

ATLAS_GAMETOOLTIP_ORIGINAL_SCALE = GameTooltip:GetScale()

-- Only update this version number when the options have been revised and a force update is needed.
ATLAS_OLDEST_VERSION_SAME_SETTINGS = "1.24.00" 

-- Turn ON / OFF Atlas debug mode
ATLAS_DEBUGMODE = false

--[[
# Structure of JournalInstance.dbc
Column	Field		Type		Notes
------	-------------	--------	----------------------------------------------------------------------------------------------
1	ID		Integer
2	Map ID		Integer		Map ID refer to Map.dbc's 1st column
3	Area ID		Integer		Area ID refer to AreaTable.dbc's 1st column
4~6			Integer
7			Integer
8	Name		String
9	Description	String


# Structure of JournalEncounter.dbc
Column	Field		Type		Notes
------	-------------	--------	----------------------------------------------------------------------------------------------
1	ID		Integer
2	Map ID?		Integer
3	Area ID?	Integer
4~5			Float
6	Selection ID	Integer
7	Instance ID	Integer		Refer to JournalInstance.dbc's 1st column
8	Index		Integer		Boss index
9
10	Name		String		Boss name
11	Description	String		Boss description


# Structure of JournalEncounterCreature.dbc
Column	Field 		Type 		Notes
------	-------------	--------	----------------------------------------------------------------------------------------------
1	ID		Integer
2	encounterID	Integer
3	modelID		Integer
4	Index		Integer
5			Integer
6	name		String


# Structure of LFGDungeons.dbc
Column	Field 		Type 		Notes
------	-------------	--------	----------------------------------------------------------------------------------------------
1 	ID 		Integer 		
2	Map Name	String		Dungeon Name
3	level_min 	Integer 	Minimum level to participate. 
4 	level_max 	Integer 	Maximum level when this dungeon becomes trivial. 
5	rec_level	Integer
6	rec_minlevel	Integer
7	rec_maxlevel	Integer
8 	Map ID	        Integer 	Here you must add the Map Id where you will be ported
9	difficulty	Integer
13	systemname
14	expansion

]]

AtlasMaps = {
--[[
Syntax: 
	MapName = {
		ZoneName = { "Map name" },
		Location = { "Location of this map" },
		LevelRange = "level range",
		MinLevel = "minimum level",
		PlayerLimit = "player limit",
		Acronym = "acronym",
		MinGearLevel = "minimum itel level to enter this instance",
		JournalInstanceID = journal instance ID, 	-- ID can be found from JournalInstance.dbc, Column 1 is the dungeon ID, column 8 is dungeon name
		DungeonID = LFGDungeon ID, 			-- ID can be fround from LFGDungeons.dbc.txt
		DungeonHeoricID = LFGDungeon ID for Heroic mode,
		DungeonMythicID = LFGDungeon ID for Mythic mode,
		WorldMapID = uiMapID,
		DungeonLevel = level number of the dungeon map series, 
		Module = "map module name",
		LargeMap = "large map's prefix name",
		PrevMap = "previous map name",
		NextMap = "next map name",
		{ "list entry 1", id of list entry or encounter id },
		{ "list entry 2", "achivement id by using the format of ac=12345" },
		{ "list entry 3" item id, "item", "item's English name"},
		{ "list entry 4" },
	},
]]
}

AtlasMaps_NPC_DB = {
--[[
Syntax: 
	MapName = {
		{ number, EJ_BossID, X coordinate, Y coordinate };
		{ 2, 193,339, 435 };
	};
]]
}

ATLAS_LETTER_MARKS_TCOORDS = {
	["Atlas_Letter_Blue_A"] 	= {0.00000000, 0.15625000, 0.00000000, 0.15625000},
	["Atlas_Letter_Blue_B"] 	= {0.15625000, 0.31250000, 0.00000000, 0.15625000},
	["Atlas_Letter_Blue_C"] 	= {0.31250000, 0.46875000, 0.00000000, 0.15625000},
	["Atlas_Letter_Blue_D"] 	= {0.46875000, 0.62500000, 0.00000000, 0.15625000},
	["Atlas_Letter_Blue_E"] 	= {0.62500000, 0.78125000, 0.00000000, 0.15625000},
	["Atlas_Letter_Blue_F"] 	= {0.78125000, 0.93750000, 0.00000000, 0.15625000},
	["Atlas_Letter_Blue_G"] 	= {0.00000000, 0.15625000, 0.15625000, 0.31250000},
	["Atlas_Letter_Blue_H"] 	= {0.15625000, 0.31250000, 0.15625000, 0.31250000},
	["Atlas_Letter_Blue_I"] 	= {0.31250000, 0.46875000, 0.15625000, 0.31250000},
	["Atlas_Letter_Blue_J"] 	= {0.46875000, 0.62500000, 0.15625000, 0.31250000},
	["Atlas_Letter_Blue_K"] 	= {0.62500000, 0.78125000, 0.15625000, 0.31250000},
	["Atlas_Letter_Blue_L"] 	= {0.78125000, 0.93750000, 0.15625000, 0.31250000},
	["Atlas_Letter_Blue_M"] 	= {0.00000000, 0.15625000, 0.31250000, 0.46875000},
	["Atlas_Letter_Blue_N"] 	= {0.15625000, 0.31250000, 0.31250000, 0.46875000},
	["Atlas_Letter_Blue_O"] 	= {0.31250000, 0.46875000, 0.31250000, 0.46875000},
	["Atlas_Letter_Blue_P"] 	= {0.46875000, 0.62500000, 0.31250000, 0.46875000},
	["Atlas_Letter_Blue_Q"] 	= {0.62500000, 0.78125000, 0.31250000, 0.46875000},
	["Atlas_Letter_Blue_R"] 	= {0.78125000, 0.93750000, 0.31250000, 0.46875000},
	["Atlas_Letter_Blue_S"] 	= {0.00000000, 0.15625000, 0.46875000, 0.62500000},
	["Atlas_Letter_Blue_T"] 	= {0.15625000, 0.31250000, 0.46875000, 0.62500000},
	["Atlas_Letter_Blue_U"] 	= {0.31250000, 0.46875000, 0.46875000, 0.62500000},
	["Atlas_Letter_Blue_V"] 	= {0.46875000, 0.62500000, 0.46875000, 0.62500000},
	["Atlas_Letter_Purple_A"] 	= {0.62500000, 0.78125000, 0.46875000, 0.62500000},
	["Atlas_Letter_Purple_B"] 	= {0.78125000, 0.93750000, 0.46875000, 0.62500000},
	["Atlas_Letter_Purple_C"] 	= {0.00000000, 0.15625000, 0.62500000, 0.78125000},
	["Atlas_Letter_Purple_D"] 	= {0.15625000, 0.31250000, 0.62500000, 0.78125000},
	["Atlas_Letter_Purple_E"] 	= {0.31250000, 0.46875000, 0.62500000, 0.78125000},
	["Atlas_Letter_Purple_F"] 	= {0.46875000, 0.62500000, 0.62500000, 0.78125000},
	["Atlas_Letter_Purple_G"] 	= {0.62500000, 0.78125000, 0.62500000, 0.78125000},
	["Atlas_Letter_Purple_H"] 	= {0.78125000, 0.93750000, 0.62500000, 0.78125000},
	["Atlas_Letter_Purple_I"] 	= {0.00000000, 0.15625000, 0.78125000, 0.93750000},
	["Atlas_Letter_Purple_J"] 	= {0.15625000, 0.31250000, 0.78125000, 0.93750000},
	["Atlas_Letter_Purple_K"] 	= {0.31250000, 0.46875000, 0.78125000, 0.93750000},
	["Atlas_Letter_Purple_L"] 	= {0.46875000, 0.62500000, 0.78125000, 0.93750000},
	["Atlas_Letter_Purple_M"] 	= {0.62500000, 0.78125000, 0.78125000, 0.93750000},
	["Atlas_Letter_Purple_N"] 	= {0.78125000, 0.93750000, 0.78125000, 0.93750000},
}

ATLAS_FONT_COLORS = {
	["White"] 	= {1.00, 1.00, 1.00},
	["Yellow"] 	= {1.00, 1.00, 0.00},
	["Green"] 	= {0.00, 1.00, 0.00},
	["Red"] 	= {1.00, 0.00, 0.00},
	["Orange"] 	= {1.00, 0.82, 0.00},
	["Purple"]	= {0.73, 0.40, 1.00},
	["Blue"]	= {0.40, 0.40, 1.00},
}

ATLAS_TAXI_TCOORDS = {
	["TaxiNeutral"] 	= {0.00000000, 0.31250000, 0.00000000, 0.31250000},
	["TaxiHorde"] 		= {0.31250000, 0.62500000, 0.00000000, 0.31250000},
	["TaxiAlliance"] 	= {0.62500000, 0.93750000, 0.00000000, 0.31250000},
}

constants.defaults = {
	profile = {
		minimap = {
			hide = false,
			minimapPos = 190,
		},
		dropdowns = {
		},
		options = {
			autoSelect = false,			-- AtlasAutoSelect
			frames = {
				alpha = 1.0,			-- AtlasAlpha
				scale = 1.0,			-- AtlasScale
				boss_description_scale = 0.9,	-- AtlasBossDescScale
				showBossDesc = true,		-- AtlasBossDesc
				showBossPotrait = true,
				lock = false,			-- AtlasLocked
				rightClick = false,		-- AtlasRightClick
				contrClclick = false, 		-- AtlasCtrl
				clamp = true, 			-- AtlasClamped
				showAcronyms = true,		-- AtlasAcronyms
			},
			dropdowns = {
				color = true,			-- AtlasColoringDropDown
				menuType = 1,			-- AtlasSortBy
				module = 1,			-- AtlasType
				zone = 1,			-- AtlasZone
				maxItems = 30,
			},
			worldMapButton = true,			-- AtlasWorldMapButtonShown
			checkMissingModules = false,		-- AtlasCheckModule
			last_compatible_version = ATLAS_OLDEST_VERSION_SAME_SETTINGS, -- AtlasVersion
		},
		options_copied = false,
	},
}

constants.moduleList = {
	"Atlas_ClassicWoW",
	"Atlas_BurningCrusade",
	"Atlas_WrathoftheLichKing",
	"Atlas_Cataclysm",
	"Atlas_MistsofPandaria",
	"Atlas_WarlordsofDraenor",
	"Atlas_Legion",
	"Atlas_BattleforAzeroth",
	"Atlas_Battlegrounds",
	"Atlas_DungeonLocs",
	"Atlas_OutdoorRaids",
	"Atlas_Transportation",
	"Atlas_Scenarios",
	"Atlas_ClassOrderHalls",
}

constants.deprecatedList = {
	-- List of deprecated Atlas modules.
	-- First value is the addon name
	-- Second value is the version
	-- Nil version means NO version will EVER be loaded!
	-- Non-nil version mean ONLY IT OR NEWER versions will be loaded!
	-- Note that 2.10 isn't greater than 2.9 (2.10 >= 2.9 will fail), so the addon version number must be with the same digits
	-- For example, name it as 2.09 instead of 2.9
	-- Most recent (working) versions of known modules at time of release
	-- Atlas Modules
	{ "Atlas_BattleforAzeroth", 	"1.50.00", "r30" },
	{ "Atlas_Legion",	 			"1.50.00", "r169" },
	{ "Atlas_WarlordsofDraenor", 	"1.50.00", "r69" },
	{ "Atlas_MistsofPandaria",		"1.50.00", "r49" },
	{ "Atlas_Cataclysm", 			"1.50.00", "r51" },
	{ "Atlas_WrathoftheLichKing", 	"1.50.00", "r58" },
	{ "Atlas_BurningCrusade", 		"1.50.00", "r61" },
	{ "Atlas_ClassicWoW", 			"1.50.00", "r83" },
	-- Atlas Plugins
	{ "Atlas_Battlegrounds", 		"1.50.00", "r1579" },
	{ "Atlas_DungeonLocs", 			"1.50.00", "r75" },
	{ "Atlas_OutdoorRaids", 		"1.50.00", "r74" },
	{ "Atlas_Transportation", 		"1.50.00", "r144" },
	{ "Atlas_Scenarios", 			"1.44.00", "r53" },
	{ "Atlas_ClassOrderHalls",		"1.50.00", "r134" },
	-- 3rd parties plugins
	{ "AtlasQuest", 		"4.10.25" },
	{ "Atlas_Arena", 		"1.07.02", "r80" },
	{ "Atlas_WorldEvents", 		"3.24", "r107" },
	{ "AtlasLoot", 			"v8.03.02", "r4615" },
	{ "AtlasMajorCitiesEnhanced", 	"v1.15" }, 	
	--{ "AtlasWorld", 		"3.3.5.25" }, 	-- updated July 14, 2010 -- comment out because this plugin is no longer maintained
}

