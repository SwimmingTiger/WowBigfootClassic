local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("HandyNotes_TravelGuide (Classic)", "enUS", true);

-- https://www.curseforge.com/members/dathwada
if L then
--config.options
L["HandyNotes: TravelGuide (Classic)"] = true
L["Icon settings"] = true
L["These settings control the look and feel of the icon."] = true
L["Icon Scale"] = true
L["The scale of the icons"] = true
L["Icon Alpha"] = true
L["The alpha transparency of the icons"] = true
L["What to display?"] = true
L["These settings control what type of icons to be displayed."] = true
L["Boat"] = true
L["Show the boat locations."] = true
L["Alliance Boat"] = true
L["Show the Alliance boat locations."] = true
L["Zeppelin"] = true
L["Show the Zeppelin locations."] = true
L["Horde Zeppelin"] = true
L["Show the Horde Zeppelin locations."] = true
L["Note"] = true
L["Show the node's additional notes when it's available."] = true
L["Easy waypoints"] = true
L["easy_waypoints_desc"] = "Activates simplified waypoint creation. \nAllows you to set a waypoint by right-clicking and access to more options by CTRL + right-clicking."

L["Deeprun Tram"] = true
L["Show the Deeprun Tram locations in Stormwind and Ironforge."] = true

--Plugin_config
L["AddOn Settings"] = true
-- L["Query from server"] = true
-- L["Send query request to server to lookup localized name. May be a little bit slower for the first time lookup but would be very fast once the name is found and cached."] = true
L["Reset hidden nodes"] = true
L["Show all nodes that you manually hid by right-clicking on them and choosing \"hide\"."] = true

--Handler
L["Shows the boat and zepplin locations on the World Map and the MiniMap."] = true
L["TravelGuide (Classic)"] = true

--DB
L["Eastern Kingdoms"] = true
L["Eastern Kingdoms, Wetlands"] = true
L["Boat to Menethil Harbor"] = true

L["Eastern Kingdoms, Tirisfal Glades"] = true
L["Zeppelin to Undercity"] = true

L["Eastern Kingdoms, Stranglethorn Vale"] = true
L["Eastern Kingdoms, Grom'gol Base Camp"] = true
L["Zeppelin to Stranglethorn Vale"] = true
L["Boat to Booty Bay"] = true

L["Eastern Kingdoms, Elwynn Forest"] = true
L["Deeprun Tram to Stormwind"] = true

L["Eastern Kingdoms, Dun Morogh"] = true
L["Deeprun Tram to Ironforge"] = true

L["Kalimdor"] = true
L["Kalimdor, Durotar"] = true
L["Zeppelin to Orgrimmar"] = true

L["Kalimdor, Teldrassil"] = true
L["Boat to Darnassus"] = true

L["Kalimdor, The Barrens"] = true
L["Boat to Ratchet"] = true

L["Kalimdor, Dustwallow Marsh"] = true
L["Boat to Theramore"] = true

L["Kalimdor, Darkshore"] = true
L["Boat to Auberdine"] = true

end