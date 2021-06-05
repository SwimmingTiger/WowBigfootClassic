local L = LibStub("AceLocale-3.0"):NewLocale("HandyNotes_TravelGuide (BCC)", "deDE", false, true)

if not L then return end
--german translation by Dathwada EU-Eredar https://www.curseforge.com/members/dathwada
if L then
----------------------------------------------------------------------------------------------------
-----------------------------------------------CONFIG-----------------------------------------------
----------------------------------------------------------------------------------------------------

L["config_plugin_name"] = "TravelGuide (BCC)"
L["config_plugin_desc"] = "Zeigt die Positionen von Portalen, Zeppelinen und Schiffen auf der Worldmap und der Minimap an."

L["config_tab_general"] = "Allgemein"
L["config_tab_scale_alpha"] = "Größe / Transparenz"
--L["config_scale_alpha_desc"] = "PH"
L["config_icon_scale"] = "Symbolgröße"
L["config_icon_scale_desc"] = "Die größe der Symbole"
L["config_icon_alpha"] = "Symboltransparenz"
L["config_icon_alpha_desc"] = "Die Transparenz der Symbole"
L["config_what_to_display"] = "Was soll angezeigt werden?"
L["config_what_to_display_desc"] = "Diese Einstellungen legen fest welche Symbole auf der Welt- und Minimap angezeigt werden sollen."

L["config_portal"] = "Portale"
L["config_portal_desc"] = "Zeigt die Positionen von Portalen an."

L["config_boat"] = "Schiffe"
L["config_boat_desc"] = "Zeigt die Positionen von Schiffen an."
L["config_boat_alliance"] = "Allianz Schiffe"
L["config_boat_alliance_desc"] = "Zeigt die Positionen von Allianz Schiffen an."

L["config_zeppelin"] = "Zeppeline"
L["config_zeppelin_desc"] = "Zeigt die Positionen von Zeppelinen an."
L["config_zeppelin_horde"] = "Horde Zeppeline"
L["config_zeppelin_horde_desc"] = "Zeigt die Positionen von Horde Zeppelinen an."

L["config_tram"] = "Tiefenbahn"
L["config_tram_desc"] = "Zeigt die Positionen der Tiefenbahn in Sturmwind und Eisenschmiede an."

L["config_note"] = "Notizen"
L["config_note_desc"] = "Zeigt zusätzliche Notizen an, wenn diese verfügbar sind."

L["config_easy_waypoints"] = "Vereinfachte Wegpunkte"
L["config_easy_waypoints_desc"] = "Aktiviert die vereinfachte Wegpunkterstellung. \nErlaubt es per Rechtsklick einen Wegpunkt zu setzen und per STRG + Rechtsklick mehr Optionen aufzurufen."
L["config_easy_waypoints_requires"] = "Benötigt"

L["config_restore_nodes"] = "Versteckte Punkte wiederherstellen"
L["config_restore_nodes_desc"] = "Stellt alle Punkte wieder her, die über das Kontextmenü versteckt wurden."
L["config_restore_nodes_print"] = "Alle versteckten Punkte wurden wiederhergestellt."

----------------------------------------------------------------------------------------------------
-------------------------------------------------DEV------------------------------------------------
----------------------------------------------------------------------------------------------------

L["dev_config_tab"] = "DEV"

L["dev_config_force_nodes"] = "Erzwinge Punkte"
L["dev_config_force_nodes_desc"] = "Erzwingt die Anzeige aller Punkte unabhängig von Klasse, Fraktion oder Pakt."

L["dev_config_show_prints"] = "Zeige print()"
L["dev_config_show_prints_desc"] = "Zeigt print() Nachrichten im Chatfenster an."

----------------------------------------------------------------------------------------------------
-----------------------------------------------HANDLER----------------------------------------------
----------------------------------------------------------------------------------------------------

--==========================================CONTEXT_MENU==========================================--

L["handler_context_menu_addon_name"] = "HandyNotes: TravelGuide"
L["handler_context_menu_add_tomtom"] = "Zu TomTom hinzufügen"
L["handler_context_menu_hide_node"] = "Verstecke diesen Punkt"

----------------------------------------------------------------------------------------------------
----------------------------------------------DATABASE----------------------------------------------
----------------------------------------------------------------------------------------------------

L["Boat to Menethil Harbor"] = "Schiff zum Hafen von Menethil"

L["Zeppelin to Undercity"] = "Zeppelin nach Unterstadt"

L["Zeppelin to Stranglethorn Vale"] = "Zeppelin ins Schlingendorntal"
L["Boat to Booty Bay"] = "Schiff nach Beutebucht"

L["Deeprun Tram to Stormwind"] = "Tiefenbahn nach Sturmwind"

L["Deeprun Tram to Ironforge"] = "Tiefenbahn nach Eisenschmiede"

L["Zeppelin to Orgrimmar"] = "Zeppelin nach Orgrimmar"

L["Boat to Darnassus"] = "Schiff nach Darnassus"

L["Boat to Ratchet"] = "Schiff nach Ratchet"

L["Boat to Theramore"] = "Schiff nach Theramore"

L["Boat to Auberdine"] = "Schiff nach Auberdine"

L["Portal to Silvermoon"] = "Portal nach Silbermond"

L["Portal to Undercity"] = "Portal nach Unterstadt"
L["Orb of translocation"] = "Translokationskugel"

L["Shattrath Portal to Thunder Bluff"] = "Shattrathportal nach Donnerfels"
L["Shattrath Portal to Orgrimmar"] = "Shattrathportal nach Orgrimmar"
L["Shattrath Portal to Undercity"] = "Shattrathportal nach Unterstadt"
L["Shattrath Portal to Silvermoon"] = "Shattrathportal nach Silbermond"

L["Boat to Exodar"] = "Schiff zur Exodar"
L["Shattrath Portal to Exodar"] = "Shattrathportal zur Exodar"
L["Shattrath Portal to Darnassus"] = "Shattrathportal nach Darnassus"
L["Shattrath Portal to Stormwind"] = "Shattrathportal nach Sturmwind"
L["Shattrath Portal to Ironforge"] = "Shattrathportal nach Eisenschmiede"

L["Shattrath Portal to Isle of Quel'Danas"] = "Shattrathportal zur Insel von Quel'Danas"
end