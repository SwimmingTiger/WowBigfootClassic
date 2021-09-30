local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("HandyNotes_TravelGuide (Classic)", "enUS", true, true)

-- https://www.curseforge.com/members/dathwada
if L then
----------------------------------------------------------------------------------------------------
-----------------------------------------------CONFIG-----------------------------------------------
----------------------------------------------------------------------------------------------------

L["config_plugin_name"] = "TravelGuide (Classic)"
L["config_plugin_desc"] = "Shows the boat and zeppelin locations on the World Map and the MiniMap."

L["config_tab_general"] = "General"
L["config_tab_scale_alpha"] = "Scale / Alpha"
--L["config_scale_alpha_desc"] = "PH"
L["config_icon_scale"] = "Icon Scale"
L["config_icon_scale_desc"] = "The scale of the icons"
L["config_icon_alpha"] = "Icon Alpha"
L["config_icon_alpha_desc"] = "The alpha transparency of the icons"
L["config_what_to_display"] = "What to display?"
L["config_what_to_display_desc"] = "These settings control what type of icons to be displayed."

L["config_boat"] = "Boat"
L["config_boat_desc"] = "Show the boat locations."
L["config_boat_alliance"] = "Alliance Boat"
L["config_boat_alliance_desc"] = "Show the Alliance boat locations."

L["config_zeppelin"] = "Zeppelin"
L["config_zeppelin_desc"] = "Show the Zeppelin locations."
L["config_zeppelin_horde"] = "Horde Zeppelin"
L["config_zeppelin_horde_desc"] = "Show the Horde Zeppelin locations."

L["config_tram"] = "Deerun Tram"
L["config_tram_desc"] = "Show the Deeprun Tram locations in Stormwind and Ironforge."

L["config_note"] = "Note"
L["config_note_desc"] = "Show the node's additional notes when it's available."

L["config_easy_waypoints"] = "Easy Waypoints"
L["config_easy_waypoints_desc"] = "Activates simplified waypoint creation. \nAllows you to set a waypoint by right-clicking and access to more options by CTRL + right-clicking."
L["config_easy_waypoints_requires"] = "Requires"

L["config_restore_nodes"] = "Restore hidden nodes"
L["config_restore_nodes_desc"] = "Restore all nodes that were hidden via the context menu."
L["config_restore_nodes_print"] = "All hidden nodes have been restored"

----------------------------------------------------------------------------------------------------
-------------------------------------------------DEV------------------------------------------------
----------------------------------------------------------------------------------------------------

L["dev_config_tab"] = "DEV"

L["dev_config_force_nodes"] = "Force Nodes"
L["dev_config_force_nodes_desc"] = "Force the display of all nodes regardless of class, faction or covenant."

L["dev_config_show_prints"] = "Show print()"
L["dev_config_show_prints_desc"] = "Show print() messages in the chat window."

----------------------------------------------------------------------------------------------------
-----------------------------------------------HANDLER----------------------------------------------
----------------------------------------------------------------------------------------------------

--==========================================CONTEXT_MENU==========================================--

L["handler_context_menu_addon_name"] = "HandyNotes: TravelGuide"
L["handler_context_menu_add_tomtom"] = "Add to TomTom"
L["handler_context_menu_hide_node"] = "Hide this node"

----------------------------------------------------------------------------------------------------
----------------------------------------------DATABASE----------------------------------------------
----------------------------------------------------------------------------------------------------

L["Boat to Menethil Harbor"] = true

L["Zeppelin to Undercity"] = true

L["Zeppelin to Stranglethorn Vale"] = true
L["Boat to Booty Bay"] = true

L["Deeprun Tram to Stormwind"] = true

L["Deeprun Tram to Ironforge"] = true

L["Zeppelin to Orgrimmar"] = true

L["Boat to Darnassus"] = true

L["Boat to Ratchet"] = true

L["Boat to Theramore"] = true

L["Boat to Auberdine"] = true

end