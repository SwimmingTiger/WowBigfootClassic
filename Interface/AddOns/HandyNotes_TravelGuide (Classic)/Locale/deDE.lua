local L = LibStub("AceLocale-3.0"):NewLocale("HandyNotes_TravelGuide (Classic)", "deDE", false)

if not L then return end
--german translation by Dathwada EU-Eredar https://www.curseforge.com/members/dathwada
if L then
--config.options
L["HandyNotes: TravelGuide (Classic)"] = true
L["Icon settings"] = "Symboleinstellungen"
L["These settings control the look and feel of the icon."] = "Diese Einstellungen legen das Aussehen der Symbole fest."
L["Icon Scale"] = "Symbolgröße"
L["The scale of the icons"] = "Die größe der Symbole"
L["Icon Alpha"] = "Symboltranzparenz"
L["The alpha transparency of the icons"] = "Die Transparenz der Symbole"
L["What to display?"] = "Was soll angezeigt werden?"
L["These settings control what type of icons to be displayed."] = "Diese Einstellungen legen fest welche Symbole auf der Welt- und Minimap angezeigt werden sollen."
L["Boat"] = "Schiffe"
L["Show the boat locations."] = "Zeigt die positionen von Schiffen an."
L["Alliance Boat"] = "Allianz Schiffe"
L["Show the Alliance boat locations."] = "Zeigt die positionen von Allianz Schiffen an."
L["Zeppelin"] = "Zeppeline"
L["Show the Zeppelin locations."] = "Zeigt die positionen von Zeppelinen an."
L["Horde Zeppelin"] = "Horde Zeppeline"
L["Show the Horde Zeppelin locations."] = "Zeigt die positionen von Horde Zeppelinen an."
L["Note"] = "Notizen"
L["Show the node's additional notes when it's available."] = "Zeigt zusätzliche Notizen an wenn diese verfügbar sind."
L["Easy waypoints"] = "Vereinfachte Wegpunkte"
L["easy_waypoints_desc"] = "Aktiviert die vereinfachte Wegpunkterstellung. \nErlaubt es per Rechtsklick einen Wegpunkt zu setzen und per STRG + Rechtsklick mehr Optionen aufzurufen."
L["Deeprun Tram"] = "Tiefenbahn"
L["Show the Deeprun Tram locations in Stormwind and Ironforge."] = "Zeigt die Positionen der Tiefenbahn in Sturmwind und Eisenschmiede an."

--Plugin_config
L["AddOn Settings"] = "AddOn Einstellungen"
-- L["Query from server"] = "Abfrage vom Server"
-- L["Send query request to server to lookup localized name. May be a little bit slower for the first time lookup but would be very fast once the name is found and cached."] = "Senden Sie eine Abfrageanforderung an den Server, um den lokalisierten Namen zu suchen. Kann beim ersten Mal ein wenig langsamer sein, ist aber schneller sobald der Name gefunden und zwischengespeichert wurde."
L["Reset hidden nodes"] = "Ausgeblendete Symbole zurücksetzen"
L["Show all nodes that you manually hid by right-clicking on them and choosing \"hide\"."] = "Zeige wieder alle Symbole die mit rechtsklick --> \"Ausblenden\" manuell Ausgeblendet worden sind."

--Handler
L["Shows the boat and zepplin locations on the World Map and the MiniMap."] = "Zeigt die Positionen von Schiffen und Zeppelinen auf der Worldmap und der Minimap an."
L["TravelGuide (Classic)"] = true

--DB
L["Eastern Kingdoms"] = "Die Östlichen Königreiche"
L["Eastern Kingdoms, Wetlands"] = "Die Östlichen Königreiche, Sumpfland"
L["Boat to Menethil Harbor"] = "Schiff zum Hafen von Menethil"

L["Eastern Kingdoms, Tirisfal Glades"] = "Die Östlichen Königreiche, Tirisfal"
L["Zeppelin to Undercity"] = "Zeppelin nach Unterstadt"

L["Eastern Kingdoms, Stranglethorn Vale"] = "Die Östlichen Königreiche, Schlingendorntal"
L["Eastern Kingdoms, Grom'gol Base Camp"] = "Die Östlichen Königreiche, Basislager Grom'gol"
L["Zeppelin to Stranglethorn Vale"] = "Zeppelin ins Schlingendorntal"
L["Boat to Booty Bay"] = "Schiff nach Beutebucht"

L["Eastern Kingdoms, Elwynn Forest"] = "Die Östlichen Königreiche, Wald von Elwynn"
L["Deeprun Tram to Stormwind"] = "Tiefenbahn nach Sturmwind"

L["Eastern Kingdoms, Dun Morogh"] = "Die Östlichen Königreiche, Dun Morogh"
L["Deeprun Tram to Ironforge"] = "Tiefenbahn nach Eisenschmiede"

L["Kalimdor"] = "Kalimdor"
L["Kalimdor, Durotar"] = "Kalimdor, Durotar"
L["Zeppelin to Orgrimmar"] = "Zeppelin nach Orgrimmar"

L["Kalimdor, Teldrassil"] = "Kalimdor, Teldrassil"
L["Boat to Darnassus"] = "Schiff nach Darnassus"

L["Kalimdor, The Barrens"] = "Kalimdor, Das Brachland"
L["Boat to Ratchet"] = "Schiff nach Ratchet"

L["Kalimdor, Dustwallow Marsh"] = "Kalimdor, Düstermarschen"
L["Boat to Theramore"] = "Schiff nach Theramore"

L["Kalimdor, Darkshore"] = "Kalimdor, Dunkelküste"
L["Boat to Auberdine"] = "Schiff nach Auberdine"

end