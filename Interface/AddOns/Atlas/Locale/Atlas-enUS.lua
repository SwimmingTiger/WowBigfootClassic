-- $Id: Atlas-enUS.lua 398 2022-03-23 15:12:06Z arithmandar $
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

local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("Atlas", "enUS", true, true);
-- Localize file must set above to false, for example:
--    local AL = AceLocale:NewLocale("Atlas", "deDE", false);

-- Atlas English Localization
--if ( GetLocale() ==	"enUS" ) then
	-- Define the leading strings to be ignored while sorting
	-- Ex: The Stockade
	AtlasSortIgnore = {"the (.+)", "The (.+)"};

	-- Syntax: ["real_zone_name"] = "localized map zone name"
	AtlasZoneSubstitutions = {
		["Ahn'Qiraj"] = "Temple of Ahn'Qiraj";
		["The Temple of Atal'Hakkar"] = "Sunken Temple";
	--	["Throne of Tides"] = "The Abyssal Maw: Throne of the Tides";
	}
--end


if L then
L[" 1/2"] = " 1/2"
L[" 2/2"] = " 2/2"
L["%s Dungeons"] = "%s Dungeons"
L["%s Instances"] = "%s Instances"
L["%s Raids"] = "%s Raids"
L["Adult"] = "Adult"
L["AKA"] = "AKA"
L["Alexston Chrome <Tavern of Time>"] = "Alexston Chrome <Tavern of Time>"
L["Alurmi <Keepers of Time Quartermaster>"] = "Alurmi <Keepers of Time Quartermaster>"
L["Anachronos <Keepers of Time>"] = "Anachronos <Keepers of Time>"
L["Andormu <Keepers of Time>"] = "Andormu <Keepers of Time>"
L["Arazmodu <The Scale of Sands>"] = "Arazmodu <The Scale of Sands>"
L["Arcane Container"] = "Arcane Container"
L["Arms Warrior"] = "Arms Warrior"
L["ATLAS_BUTTON_CLOSE"] = "Close"
L["ATLAS_CLICK_TO_OPEN"] = "Click to open Atlas map window."
L["ATLAS_CLOSE_ATLASLOOT_WINDOW"] = "Right-click to close AtlasLoot window."
L["ATLAS_COLLAPSE_BUTTON"] = "Click to close Atlas' legend panel."
L["ATLAS_DDL_CONTINENT"] = "Continent"
L["ATLAS_DDL_CONTINENT_BROKENISLES"] = "Broken Isles Instances"
L["ATLAS_DDL_CONTINENT_BROKENISLES1"] = "Broken Isles Dungeons"
L["ATLAS_DDL_CONTINENT_BROKENISLES2"] = "Broken Isles Raids"
L["ATLAS_DDL_CONTINENT_DEEPHOLM"] = "Deepholm Instances"
L["ATLAS_DDL_CONTINENT_DRAENOR"] = "Draenor Instances"
L["ATLAS_DDL_CONTINENT_EASTERN"] = "Eastern Kingdoms Instances"
L["ATLAS_DDL_CONTINENT_KALIMDOR"] = "Kalimdor Instances"
L["ATLAS_DDL_CONTINENT_KULTIRAS"] = "Kul Tiras Instances"
L["ATLAS_DDL_CONTINENT_NAZJATAR"] = "Nazjatar Instances"
L["ATLAS_DDL_CONTINENT_NORTHREND"] = "Northrend Instances"
L["ATLAS_DDL_CONTINENT_OUTLAND"] = "Outland Instances"
L["ATLAS_DDL_CONTINENT_PANDARIA"] = "Pandaria Instances"
L["ATLAS_DDL_CONTINENT_ZANDALAR"] = "Zandalar Instances"
L["ATLAS_DDL_EXPANSION"] = "Expansion"
L["ATLAS_DDL_EXPANSION_BC"] = "Burning Crusade Instances"
L["ATLAS_DDL_EXPANSION_BFA"] = "Battle for Azeroth Instances"
L["ATLAS_DDL_EXPANSION_CATA"] = "Cataclysm Instances"
L["ATLAS_DDL_EXPANSION_LEGION"] = "Legion Instances"
L["ATLAS_DDL_EXPANSION_LEGION1"] = "Legion Dungeons"
L["ATLAS_DDL_EXPANSION_LEGION2"] = "Legion Raids"
L["ATLAS_DDL_EXPANSION_MOP"] = "Mists of Pandaria Instances"
L["ATLAS_DDL_EXPANSION_OLD"] = "Old World Instances"
L["ATLAS_DDL_EXPANSION_SHADOWLANDS"] = "Shadowlands Instances"
L["ATLAS_DDL_EXPANSION_WOD"] = "Warlords of Draenor Instances"
L["ATLAS_DDL_EXPANSION_WOTLK"] = "Wrath of the Lich King Instances"
L["ATLAS_DDL_LEVEL"] = "Level"
L["ATLAS_DDL_LEVEL_100PLUS"] = "Instances Level 100+"
L["ATLAS_DDL_LEVEL_100TO110"] = "Instances Level 100-110"
L["ATLAS_DDL_LEVEL_10TO20"] = "Instances Level 10-20"
L["ATLAS_DDL_LEVEL_10TO30"] = "Instances Level 10-30"
L["ATLAS_DDL_LEVEL_110PLUS"] = "Instances Level 110+"
L["ATLAS_DDL_LEVEL_110TO120"] = "Instances Level 110-120"
L["ATLAS_DDL_LEVEL_120PLUS"] = "Instances Level 120+"
L["ATLAS_DDL_LEVEL_120TO130"] = "Instances Level 120-130"
L["ATLAS_DDL_LEVEL_130PLUS"] = "Instances Level 130+"
L["ATLAS_DDL_LEVEL_20TO40"] = "Instances Level 20-40"
L["ATLAS_DDL_LEVEL_30TO35"] = "Instances Level 30-35"
L["ATLAS_DDL_LEVEL_35TO40"] = "Instances Level 35-40"
L["ATLAS_DDL_LEVEL_40TO45"] = "Instances Level 40-45"
L["ATLAS_DDL_LEVEL_40TO60"] = "Instances Level 40-60"
L["ATLAS_DDL_LEVEL_45TO50"] = "Instances Level 45-50"
L["ATLAS_DDL_LEVEL_45TO60"] = "Instances Level 45-60"
L["ATLAS_DDL_LEVEL_50TO60"] = "Instances Level 50-60"
L["ATLAS_DDL_LEVEL_60PLUS"] = "Instances Level 60+"
L["ATLAS_DDL_LEVEL_60TO70"] = "Instances Level 60-70"
L["ATLAS_DDL_LEVEL_70TO80"] = "Instances Level 70-80"
L["ATLAS_DDL_LEVEL_80TO85"] = "Instances Level 80-85"
L["ATLAS_DDL_LEVEL_85TO90"] = "Instances Level 85-90"
L["ATLAS_DDL_LEVEL_90TO100"] = "Instances Level 90-100"
L["ATLAS_DDL_LEVEL_UNDER30"] = "Instances Under Level 30"
L["ATLAS_DDL_LEVEL_UNDER45"] = "Instances Under Level 45"
L["ATLAS_DDL_PARTYSIZE"] = "Party Size"
L["ATLAS_DDL_PARTYSIZE_10"] = "Instances for 10 Players"
L["ATLAS_DDL_PARTYSIZE_20TO40"] = "Instances for 20-40 Players"
L["ATLAS_DDL_PARTYSIZE_5"] = "Instances for 5 Players"
L["ATLAS_DDL_TYPE"] = "Type"
L["ATLAS_DDL_TYPE_ENTRANCE"] = "Entrances"
L["ATLAS_DDL_TYPE_INSTANCE"] = "Instances"
L["ATLAS_DEP_MSG1"] = "Atlas has detected outdated plugin(s)/module(s)/addon(s)."
L["ATLAS_DEP_MSG2"] = "It has / They have been disabled for this character."
L["ATLAS_DEP_MSG3"] = [=[Delete it/them from your AddOns folder and get the latest one installed.

List of outdated plugin(s)/module(s)/addon(s):]=]
L["ATLAS_DEP_MSG4"] = [=[Once you have the latest ones installed, 
don't forget to enable them from Addon list.]=]
L["ATLAS_DEP_OK"] = "Ok"
L["ATLAS_ENTRANCE_BUTTON"] = "Entrance"
L["ATLAS_EXPAND_BUTTON"] = "Click to open Atlas' legend panel."
L["ATLAS_INFO"] = "Atlas Information"
L["ATLAS_INFO_12200"] = [=[Important Notice:

Due to the concern of increasing addon file size, we have moved out 
npart of our dungeon maps and built-in plug-ins into separated addon package.

Users who download our addons from some of the famous game web sites 
nmay only get our core addon which only include the Atlas core function 
nand the latest WoW expansion maps.

If you also want to see all the old expansions' maps, and also want all those 
Atlas plug-ins made by us, you have to download and install them separately.

Read below forum topic for more information:
|cff6666ffhttp://www.atlasmod.com/phpBB3/viewtopic.php?t=1522|cffffffff

Or visit our website to see where to download:
|cff6666ffhttp://www.atlasmod.com/|cffffffff]=]
L["ATLAS_INFO_12201"] = [=[Please be advised that we have created a new plug-in - |cff6666ffAtlas Scenarios|cffffffff, to 
nprovide the brand-new Scenarios maps introduced in WoW 5.0. 

Check out our web site for more details, and don't forget to download / 
install it separately.
|cff6666ffhttp://www.atlasmod.com/|cffffffff]=]
L["ATLAS_INSTANCE_BUTTON"] = "Instance"
L["ATLAS_LDB_HINT"] = [=[Left-Click to open Atlas.
Right-Click for Atlas options.]=]
L["ATLAS_MINIMAPLDB_HINT"] = [=[Left-Click to open Atlas.
Right-Click for Atlas options.
Left-click and drag to move this button.]=]
L["ATLAS_MISSING_MODULE"] = [=[Atlas has detected some missing module(s) / plugin(s). 

It could be you had outdated module(s) / plugin(s) which had been disabled by Atlas. 
If you have now installed all latest ones, go to your addon list to see if all of them have been enabled. 

If you are sure that you don't need those \"missing\" module(s) / plugin(s) and do not want to see this message again, you can go to option panel to disable the notification. 

List of missing module(s) / plugin(s): 
]=]
L["ATLAS_NO_MODULE_OR_PLUGIN"] = [=[|cffff66ffError:|r
Atlas can not detect any of map module 
or plugin installed and enabled.
Note that Atlas itself is a map browser, 
you will have to at least install one 
map module or plugin to browse the maps.]=]
L["ATLAS_OPEN_ACHIEVEMENT"] = "Click to open achievement details."
L["ATLAS_OPEN_ADDON_LIST"] = "Open addon list"
L["ATLAS_OPEN_ADVENTURE"] = "Click to open Adventure Journal window."
L["ATLAS_OPEN_ATLASLOOT_WINDOW"] = "Click to open AtlasLoot window."
L["ATLAS_OPEN_WOWMAP_WINDOW"] = "Click to open Adventure Journal Map window."
L["ATLAS_OPTIONS_ACRONYMS"] = "Display Acronyms"
L["ATLAS_OPTIONS_ACRONYMS_TIP"] = "Display the instance's acronym in the map details."
L["ATLAS_OPTIONS_AUTOSEL"] = "Auto-Select Instance Map"
L["ATLAS_OPTIONS_AUTOSEL_TIP"] = "Auto-select instance map, Atlas will detect your location to choose the best instance map for you."
L["ATLAS_OPTIONS_BOSS_DESC"] = "Show boss description when available"
L["ATLAS_OPTIONS_BOSS_DESC_SCALE"] = "Boss Description Map ToolTip Scale"
L["ATLAS_OPTIONS_BOSS_DESC_TIP"] = "When mouse hover the boss number, display the boss description when relative information is available."
L["ATLAS_OPTIONS_BOSS_POTRAIT"] = "Show boss potrait when available"
L["ATLAS_OPTIONS_BUTPOS"] = "Button Position"
L["ATLAS_OPTIONS_BUTRAD"] = "Button Radius"
L["ATLAS_OPTIONS_BUTTON"] = "Options"
L["ATLAS_OPTIONS_CATDD"] = "Sort Instance Maps by:"
L["ATLAS_OPTIONS_CHECKMODULE"] = "Remind me for missing module(s) / plug-in(s)."
L["ATLAS_OPTIONS_CHECKMODULE_TIP"] = "Enable to perform checking if any missing Atlas module / plug-in after WoW loaded."
L["ATLAS_OPTIONS_CLAMPED"] = "Clamp window to screen"
L["ATLAS_OPTIONS_CLAMPED_TIP"] = "Clamp Atlas window to screen, disable to allow Atlas window can be dragged outside the game screen."
L["ATLAS_OPTIONS_COLORINGDROPDOWN"] = "Show instance dropdown in colors"
L["ATLAS_OPTIONS_COLORINGDROPDOWN_TIP"] = "Based on the instance's recommended minimul level and player's level, to show the instance with difficulty colors."
L["ATLAS_OPTIONS_CTRL"] = "Hold down Control for tooltips"
L["ATLAS_OPTIONS_CTRL_TIP"] = "Enable to show tooltips text while hold down control key and mouse over the map info. Useful when the text is too long to be displayed in the window."
L["ATLAS_OPTIONS_DONTSHOWAGAIN"] = "Don't show the same information again."
L["ATLAS_OPTIONS_HEADER_ADDONCONFIG"] = "Addon Configurations"
L["ATLAS_OPTIONS_HEADER_DISPLAY"] = "Display Options"
L["ATLAS_OPTIONS_LOCK"] = "Lock Atlas window"
L["ATLAS_OPTIONS_LOCK_TIP"] = "Toggle lock / unlock of Atlas window."
L["ATLAS_OPTIONS_MAXMENUITEMS"] = "Maximum Number of Menu Items"
L["ATLAS_OPTIONS_MAXMENUITEMS_TIP"] = "Configure the maximum number of dropdown menu items to be displayed before spliting to another menu category."
L["ATLAS_OPTIONS_RCLICK"] = "Right-Click for World Map"
L["ATLAS_OPTIONS_RCLICK_TIP"] = "Enable the Right-Click in Atlas window to switch to WoW World Map."
L["ATLAS_OPTIONS_RESETPOS"] = "Reset Position"
L["ATLAS_OPTIONS_SCALE"] = "Atlas Frame Scale"
L["ATLAS_OPTIONS_SHOWBUT"] = "Show Button on Minimap"
L["ATLAS_OPTIONS_SHOWBUT_TIP"] = "Show Atlas button around the minimap."
L["ATLAS_OPTIONS_SHOWWMBUT"] = "Show Button on World Map window."
L["ATLAS_OPTIONS_TRANS"] = "Transparency"
L["ATLAS_REOPEN_LOOT_AGAIN"] = "Please reopen the loot window to reload."
L["ATLAS_ROPEN_ATLASLOOT_WINDOW"] = "Right-click to open AtlasLoot window."
L["ATLAS_SEARCH_UNAVAIL"] = "Search Unavailable"
L["ATLAS_SLASH"] = "/atlas"
L["ATLAS_SLASH_OPTIONS"] = "options"
L["ATLAS_STRING_CLEAR"] = "Clear"
L["ATLAS_STRING_LEVELRANGE"] = "Level Range"
L["ATLAS_STRING_LOCATION"] = "Location"
L["ATLAS_STRING_MINGEARLEVEL"] = "Minimum Gear Level"
L["ATLAS_STRING_MINLEVEL"] = "Minimum Level"
L["ATLAS_STRING_PLAYERLIMIT"] = "Player Limit"
L["ATLAS_STRING_RECLEVELRANGE"] = "Recommended Level"
L["ATLAS_STRING_SEARCH"] = "Search"
L["ATLAS_STRING_SELECT_CAT"] = "Select Category"
L["ATLAS_STRING_SELECT_MAP"] = "Select Map"
L["ATLAS_TITLE"] = "Atlas"
L["ATLAS_TOGGLE_LOOT"] = "Right-click to toggle loot panel."
L["Attunement Required"] = "Attunement Required"
L["Back"] = "Back"
L["Basement"] = "Basement"
L["BINDING_HEADER_ATLAS_TITLE"] = "Atlas Bindings"
L["BINDING_NAME_ATLAS_AUTOSEL"] = "Auto-Select"
L["BINDING_NAME_ATLAS_OPTIONS"] = "Toggle Options"
L["BINDING_NAME_ATLAS_TOGGLE"] = "Toggle Atlas"
L["Blacksmithing Plans"] = "Blacksmithing Plans"
L["Bodley"] = "Bodley"
L["Bortega <Reagents & Poison Supplies>"] = "Bortega <Reagents & Poison Supplies>"
L["Brewfest"] = "Brewfest"
L["Child"] = "Child"
L["Colon"] = ": "
L["Comma"] = ", "
L["Connection"] = "Connection"
L["East"] = "East"
L["Elevator"] = "Elevator"
L["End"] = "End"
L["Engineer"] = "Engineer"
L["Entrance"] = "Entrance"
L["Event"] = "Event"
L["Exalted"] = "Exalted"
L["Exit"] = "Exit"
L["Fourth Stop"] = "Fourth Stop"
L["Front"] = "Front"
L["Galgrom <Provisioner>"] = "Galgrom <Provisioner>"
L["Ghost"] = "Ghost"
L["Graveyard"] = "Graveyard"
L["Hallow's End"] = "Hallow's End"
L["Heroic"] = "Heroic"
L["Heroic_Symbol"] = "(H)"
L["Holy Paladin"] = "Holy Paladin"
L["Holy Priest"] = "Holy Priest"
L["Hyphen"] = " - "
L["Imp"] = "Imp"
L["Key"] = "Key"
L["L-DQuote"] = "\""
L["Lothos Riftwaker"] = "Lothos Riftwaker"
L["Love is in the Air"] = "Love is in the Air"
L["Lower"] = "Lower"
L["L-Parenthesis"] = " ("
L["L-SBracket"] = "["
L["Lunar Festival"] = "Lunar Festival"
L["MapA"] = " [A]"
L["MapB"] = " [B]"
L["MapC"] = " [C]"
L["MapD"] = " [D]"
L["MapE"] = " [E]"
L["MapF"] = " [F]"
L["MapG"] = " [G]"
L["MapH"] = " [H]"
L["MapI"] = " [I]"
L["MapJ"] = " [J]"
L["MapsNotFound"] = [=[The current selected instance does not have a 
corresponding map image associated with. 

Please make sure you have installed 
the corresponding Atlas map module(s).]=]
L["Meeting Stone"] = "Meeting Stone"
L["Middle"] = "Middle"
L["Midsummer Festival"] = "Midsummer Festival"
L["Moonwell"] = "Moonwell"
L["Mythic"] = "Mythic"
L["Mythic_Symbol"] = "(M)"
L["North"] = "North"
L["Nozari <Keepers of Time>"] = "Nozari <Keepers of Time>"
L["Optional"] = "Optional"
L["Orange"] = "Orange"
L["Orb of Command"] = "Orb of Command"
L["Outside"] = "Outside"
L["Period"] = ". "
L["Portal"] = "Portal"
L["Portal to %s"] = "Portal to %s"
L["PossibleMissingModule"] = "It is likely this map is from this module: "
L["Profile Options"] = "Profile Options"
L["Protection Warrior"] = "Protection Warrior"
L["Purple"] = "Purple"
L["Random"] = "Random"
L["Rare"] = "Rare"
L["R-DQuote"] = "\""
L["Repair"] = "Repair"
L["Retribution Paladin"] = "Retribution Paladin"
L["Rewards"] = "Rewards"
L["R-Parenthesis"] = ") "
L["R-SBracket"] = "]"
L["Scale and Transparency"] = "Scale and Transparency"
L["Scarshield Quartermaster <Scarshield Legion>"] = "Scarshield Quartermaster <Scarshield Legion>"
L["Second Stop"] = "Second Stop"
L["Semicolon"] = " "
L["Shadow Priest"] = "Shadow Priest"
L["Slash"] = " / "
L["Soridormi <The Scale of Sands>"] = "Soridormi <The Scale of Sands>"
L["South"] = "South"
L["Spawn Point"] = "Spawn Point"
L["Stairs"] = "Stairs"
L["Stairs to %s"] = "Stairs to %s"
L["Start"] = "Start"
L["Steward of Time <Keepers of Time>"] = "Steward of Time <Keepers of Time>"
L["Summon"] = "Summon"
L["Teleporter"] = "Teleporter"
L["Teleporter destination"] = "Teleporter destination"
L["The Behemoth"] = "The Behemoth"
L["Third Stop"] = "Third Stop"
L["Top"] = "Top"
L["Transport"] = "Transport"
L["Tunnel"] = "Tunnel"
L["Underwater"] = "Underwater"
L["Upper"] = "Upper"
L["Upper floor"] = "Upper floor"
L["Varies"] = "Varies"
L["Wanders"] = "Wanders"
L["Wave 10"] = "Wave 10"
L["Wave 12"] = "Wave 12"
L["Wave 18"] = "Wave 18"
L["Wave 5"] = "Wave 5"
L["Wave 6"] = "Wave 6"
L["West"] = "West"
L["Yarley <Armorer>"] = "Yarley <Armorer>"
L["Zaladormu"] = "Zaladormu"

end
