--[[
    This file is part of Decursive.

    Decursive (v 2.7.7) add-on for World of Warcraft UI
    Copyright (C) 2006-2019 John Wellesz (Decursive AT 2072productions.com) ( http://www.2072productions.com/to/decursive.php )

    Decursive is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Decursive is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Decursive.  If not, see <https://www.gnu.org/licenses/>.


    Decursive is inspired from the original "Decursive v1.9.4" by Patrick Bohnet (Quu).
    The original "Decursive 1.9.4" is in public domain ( www.quutar.com )

    Decursive is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY.

    This file was last updated on 2019-11-18T13:42:00Z
--]]
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- German localization
-------------------------------------------------------------------------------

--[=[
--                      YOUR ATTENTION PLEASE
--
--         !!!!!!! TRANSLATORS TRANSLATORS TRANSLATORS !!!!!!!
--
--    Thank you very much for your interest in translating Decursive.
--    Do not edit those files. Use the localization interface available at the following address:
--
--      ################################################################
--      #  http://wow.curseforge.com/projects/decursive/localization/  #
--      ################################################################
--
--    Your translations made using this interface will be automatically included in the next release.
--
--]=]

local addonName, T = ...;
-- big ugly scary fatal error message display function {{{
if not T._FatalError then
-- the beautiful error popup : {{{ -
StaticPopupDialogs["DECURSIVE_ERROR_FRAME"] = {
    text = "|cFFFF0000Decursive Error:|r\n%s",
    button1 = "OK",
    OnAccept = function()
        return false;
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    showAlert = 1,
    preferredIndex = 3,
    }; -- }}}
T._FatalError = function (TheError) StaticPopup_Show ("DECURSIVE_ERROR_FRAME", TheError); end
end
-- }}}
if not T._LoadedFiles or not T._LoadedFiles["enUS.lua"] then
    if not DecursiveInstallCorrupted then T._FatalError("Decursive installation is corrupted! (enUS.lua not loaded)"); end;
    DecursiveInstallCorrupted = true;
    return;
end
T._LoadedFiles["deDE.lua"] = false;

local L = LibStub("AceLocale-3.0"):NewLocale("Decursive", "deDE");

if not L then
    T._LoadedFiles["deDE.lua"] = "2.7.7";
    return;
end;


L["ABOLISH_CHECK"] = "Zuvor überprüfen ob Reinigung nötig"
L["ABOUT_AUTHOREMAIL"] = "E-MAIL DES ENTWICKLERS"
L["ABOUT_CREDITS"] = "VERDIENST"
L["ABOUT_LICENSE"] = "LIZENZ"
L["ABOUT_NOTES"] = "Anzeige und Reinigung von Gebrechen für Solo, Gruppe und Schlachtzug mit erweitertem Filter- und Prioritäten-System."
L["ABOUT_OFFICIALWEBSITE"] = "OFFIZIELLE WEBSEITE"
L["ABOUT_SHAREDLIBS"] = "GEMEINSAM GENUTZTE SAMMLUNGEN"
L["ABSENT"] = "Fehlt (%s)"
L["AFFLICTEDBY"] = "%s leidend"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "Die Anzahl der Befallenen anzeigen: "
L["ANCHOR"] = "Anker des Decursive-Textfensters"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "Micro-Einheiten-Rahmen anzeigen oder verbergen"
L["BINDING_NAME_DCRPRADD"] = "Ziel der Prioritätenliste hinzufügen"
L["BINDING_NAME_DCRPRCLEAR"] = "Prioritätenliste leeren"
L["BINDING_NAME_DCRPRLIST"] = "Prioritätenliste ausgeben"
L["BINDING_NAME_DCRPRSHOW"] = "Die Prioritätenliste anzeigen/verbergen"
L["BINDING_NAME_DCRSHOW"] = [=[Decursive-Hauptleiste anzeigen/verbergen
(Anker der aktuellen Liste)]=]
L["BINDING_NAME_DCRSHOWOPTION"] = "Feststehendes Optionsfeld anzeigen"
L["BINDING_NAME_DCRSKADD"] = "Ziel der Ignorierliste hinzufügen"
L["BINDING_NAME_DCRSKCLEAR"] = "Ignorierliste leeren"
L["BINDING_NAME_DCRSKLIST"] = "Ignorierliste ausgeben"
L["BINDING_NAME_DCRSKSHOW"] = "Die Ignorierliste anzeigen/verbergen"
L["BLACK_LENGTH"] = "Sekunden auf der schwarzen Liste: "
L["BLACKLISTED"] = "Auf schwarzer Liste"
L["CHARM"] = "Gedankenkontrolle"
L["CLASS_HUNTER"] = "Jäger"
L["CLEAR_PRIO"] = "C"
L["CLEAR_SKIP"] = "C"
L["COLORALERT"] = "Warnfarbe einstellen, wenn ein '%s' benötigt wird."
L["COLORCHRONOS"] = "Counter zentriert"
L["COLORCHRONOS_DESC"] = "Einstellung der Farbe für den zentrierten Counter"
L["COLORSTATUS"] = "Farbe für '%s' MUF-Status einstellen."
L["CTRL"] = "Strg"
L["CURE_PETS"] = "Begleiter scannen und reinigen"
L["CURSE"] = "Fluch"
L["DEBUG_REPORT_HEADER"] = [=[|cFF11FF33Bitte sende den Inhalt dieses Fensters an <%s>|r
|cFF009999(Benutze Strg+A, um alles zu markieren, und dann Strg+C, um den Text in deine Zwischenablage zu kopieren)|r
Bitte berichte ebenfalls, ob du merkwürdiges Verhalten von %s bemerkt hast.
]=]
L["DECURSIVE_DEBUG_REPORT"] = " **** |cFFFF0000Decursive-Debug-Bericht|r ****"
L["DECURSIVE_DEBUG_REPORT_NOTIFY"] = [=[Ein Debug-Bericht ist vorhanden!
Gib |cFFFF0000/DCRREPORT|r ein, um ihn zu sehen.]=]
L["DECURSIVE_DEBUG_REPORT_SHOW"] = "Debug-Bericht verfügbar!"
L["DECURSIVE_DEBUG_REPORT_SHOW_DESC"] = "Einen Debug-Bericht anzeigen, den der Autor sehen sollte..."
L["DEFAULT_MACROKEY"] = "`"
L["DEV_VERSION_ALERT"] = [=[Du benutzt eine Entwickler-Version von Decursive.

Falls du nicht teilhaben willst am Testen neuer Features/Fehlerbehebungen, Erhalten von Fehlerbehebungsberichten im Spiel, Probleme oder Anfragen senden möchtest an den Entwickler, dann VERWENDE DIESE VERSION NICHT und lade die letzte stabile Version herunter bei curse.com oder wowace.com.

Diese Mitteilunge wird nur einmal pro Version in den Chat ausgegeben.]=]
L["DEV_VERSION_EXPIRED"] = [=[Diese Entwickler-Version von Decursive ist abgelaufen.
Du solltest die neueste Entwickler-Version herunterladen oder zurückgehen zur aktuellen stabilen Release-Version, die du bei CURSE.COM oder WAWACE.COM findest.
Diese Warnung wird alle zwei Tage angezeigt.]=]
L["DEWDROPISGONE"] = "Es gibt kein Äquivalent zu DewDrop für Ace3. Alt-Rechts-Klicken, um das Optionsfeld zu öffnen."
L["DISABLEWARNING"] = [=[Decursive wurde ausgeschaltet!

Um es erneut zu aktivieren, gib |cFFFFAA44/DCR ENABLE|r ein.]=]
L["DISEASE"] = "Krankheit"
L["DONOT_BL_PRIO"] = "Namen der Prioritätenliste nicht auf schwarze Liste setzen"
L["FAILEDCAST"] = [=[|cFF22FFFF%s %s|r |cFFAA0000gescheitert bei|r %s
|cFF00AAAA%s|r]=]
L["FOCUSUNIT"] = "Focus Einheit"
L["FUBARMENU"] = "FuBar-Menü"
L["FUBARMENU_DESC"] = "Optionen relativ zum FuBar-Symbol einstellen"
L["GLOR1"] = "In Gedenken an Glorfindal"
L["GLOR2"] = [=[Decursive ist Bertrand gewidmet, der uns viel zu früh verlassen hat.
Er wird immer in Erinnerung bleiben.]=]
L["GLOR3"] = [=[In Gedenken an Bertrand Sense
1969 - 2007]=]
L["GLOR4"] = [=[Freundschaft und Zuneigung können ihre Wurzeln in alle Richtungen und überall hin wachsen lassen. Jene, die Glorfindal in World of Warcraft getroffen haben, kannten einen Mann mit großem Engagement und einen charismatischen Führer.

In seinem Leben war er wie im Spiel - selbstlos, großzügig, treu und hingebungsvoll seinen Freunden gegenüber und vor allem ein leidenschaftlicher Mann.

Er verließ uns im Alter von 38 Jahren; er ließ nicht bloß anonyme Spieler in einer virtuellen Welt zurück, sondern eine Gruppe treuer Freunde, die ihn für immer vermissen werden.]=]
L["GLOR5"] = "Er wird immer in Erinnerung bleiben..."
L["HANDLEHELP"] = "Alle Mikro-Einheiten-Rahmen (MUFs) bewegen"
L["HIDE_MAIN"] = "Decursive-Fenster verbergen"
L["HIDESHOW_BUTTONS"] = "Verbergen/Anzeigen-Schaltflächen und (ent)sperre die \"Decursive\" Leiste."
L["HLP_LEFTCLICK"] = "Linksklick"
L["HLP_LL_ONCLICK_TEXT"] = [=[Lies bitte die Dokumentation, um den Umgang mit diesem Addon zu lernen. Suche nach "Decursive" auf WoWAce.com
(Um diese Liste zu bewegen, bewege die Decursive-Leiste, /dcrshow und Links-Alt-Klick zum Bewegen)]=]
L["HLP_MIDDLECLICK"] = "Mittlere Maustaste"
L["HLP_NOTHINGTOCURE"] = "Es gibt nichts zu heilen!"
L["HLP_RIGHTCLICK"] = "Rechtsklick"
L["HLP_USEXBUTTONTOCURE"] = "Benutze \"%s\", um dieses Gebrechen zu heilen!"
L["HLP_WRONGMBUTTON"] = "Falscher Mausknopf!"
L["IGNORE_STEALTH"] = "Ignoriere getarnte Einheiten"
L["IS_HERE_MSG"] = "Decursive wurde geladen, kontrolliere bitte die Einstellungen"
L["LIST_ENTRY_ACTIONS"] = [=[|cFF33AA33[Strg]|r-Klick: Diesen Spieler entfernen
|cFF33AA33LINKS|r-Klick: Diesen Spieler höher setzen
|cFF33AA33RECHTS|r-Klick: Diesen Spieler herabsetzen
|cFF33AA33[SHIFT] LINKS|r-Klick: Diesen Spieler ganz nach oben setzen
|cFF33AA33[SHIFT] RECHTS|r-Klick: Diesen Spieler ganz nach unten setzen]=]
L["MACROKEYALREADYMAPPED"] = [=[WARNUNG: Die an das Decursive-Makro [%s] gebundene Taste war bereits an die Aktion '%s' gebunden.
Decursive wird die vorherige Tastenbindung wiederherstellen, falls du eine andere Taste für das Makro einstellst.]=]
L["MACROKEYMAPPINGFAILED"] = "Die Taste [%s] konnte nicht an das Decursive-Makro gebunden werden!"
L["MACROKEYMAPPINGSUCCESS"] = "Die Taste [%s] wurde erfolgreich an das Decursive-Makro gebunden."
L["MACROKEYNOTMAPPED"] = "Das Decursive-Makro zum Darüberlegen der Maus ist nicht an eine Taste gebunden; wirf einen Blick auf die \"Makro\"-Optionen!"
L["MAGIC"] = "Magie"
L["MAGICCHARMED"] = "Magische Verzauberung"
L["MISSINGUNIT"] = "Fehlende Einheit"
L["NEW_VERSION_ALERT"] = [=[Eine neue Version von Decursive wurde ermittelt: |cFFEE7722%q|r veröffentlicht am |cFFEE7722%s|r!


Gehe zu |cFFFF0000WoWAce.com|r, um es zu holen!
--------]=]
L["NORMAL"] = "Normal"
L["NOSPELL"] = "Kein Zauber verfügbar"
L["OPT_ABOLISHCHECK_DESC"] = "Wähle, ob Einheiten mit einem aktiven \"Aufheben\"-Zauber angezeigt und geheilt werden sollen."
L["OPT_ABOUT"] = "Über"
L["OPT_ADD_A_CUSTOM_SPELL"] = "Füge eigenen Spell/Item hinzu"
L["OPT_ADD_A_CUSTOM_SPELL_DESC"] = "Spell oder benutzbares Item per Ziehen und Ablegen hier hinzufügen. Du kannst auch direkt seinen Namen rein schreiben, seine ID, oder Shift-Klick verwenden."
L["OPT_ADDDEBUFF"] = "Ein Gebrechen manuell hinzufügen"
L["OPT_ADDDEBUFF_DESC"] = "Ein neues Gebrechen wird der Liste hinzugefügt"
L["OPT_ADDDEBUFF_USAGE"] = "<Name des Gebrechens>"
L["OPT_ADDDEBUFFFHIST"] = "Erneuertes Gebrechen hinzufügen."
L["OPT_ADDDEBUFFFHIST_DESC"] = "Ein Gebrechen aus der Vergangenheit hinzufügen"
L["OPT_ADVDISP"] = "Fortgeschrittene Anzeige-Optionen"
L["OPT_ADVDISP_DESC"] = "Erlauben, die Transparenz des Rands und der Mitte getrennt einzustellen, den Abstand zwischen jedem MUF einzustellen."
L["OPT_AFFLICTEDBYSKIPPED"] = "%s befallen von %s, wird jedoch übergangen."
L["OPT_ALLOWMACROEDIT"] = "Makro-Bearbeitung zulassen"
L["OPT_ALLOWMACROEDIT_DESC"] = "Aktivieren, um Decursive an der Aktualisierung seines Makros zu hindern, und dir die Bearbeitung zu ermöglichen."
L["OPT_ALWAYSIGNORE"] = "Auch außerhalb des Kampfes ignorieren"
L["OPT_ALWAYSIGNORE_DESC"] = "Falls Markiert, wird dieses Gebrechen auch dann ignoriert, wenn du dich nicht im Kampf befindest."
L["OPT_AMOUNT_AFFLIC_DESC"] = "Definiert die maximale Anzahl der anzuzeigenden Verfluchten in der aktuellen Liste"
L["OPT_ANCHOR_DESC"] = "Zeigt Anker des Rahmens der allgemeinen Mitteilungen an"
L["OPT_AUTOHIDEMFS"] = "MUFs verbergen, wenn: "
L["OPT_AUTOHIDEMFS_DESC"] = "Wähle, wann das MUF-Fenster automatisch verborgen werden soll."
L["OPT_BLACKLENTGH_DESC"] = "Definiert, wie lange jemand auf der schwarzen Liste verbleibt."
L["OPT_BORDERTRANSP"] = "Transparenz der Umrandung"
L["OPT_BORDERTRANSP_DESC"] = "Transparenz der Umrandung einstellen"
L["OPT_CENTERTEXT_DISABLED"] = "Deaktiviert"
L["OPT_CENTERTEXT_ELAPSED"] = "Verstrichene Zeit"
L["OPT_CENTERTEXT_STACKS"] = "Anzahl Stacks"
L["OPT_CENTERTEXT_TIMELEFT"] = "Verbleibende Zeit"
L["OPT_CENTERTRANSP"] = "Transparenz Mitte"
L["OPT_CENTERTRANSP_DESC"] = "Transparenz der Mitte einstellen"
L["OPT_CHARMEDCHECK_DESC"] = "Wenn markiert, bist du in der Lage, bezauberte Einheiten zu sehen und zu behandeln."
L["OPT_CHATFRAME_DESC"] = "Decursive-Mitteilungen werden im Standard-Chat-Rahmen ausgegeben."
L["OPT_CHECKOTHERPLAYERS"] = "Andere Spieler überprüfen"
L["OPT_CHECKOTHERPLAYERS_DESC"] = "Zeigt Decursive-Version den Spielern in deiner aktuellen Gruppe oder Gilde an (kann nicht Versionen vor Decursive 2.4.6 anzeigen)."
L["OPT_CMD_DISBLED"] = "Deaktiviert"
L["OPT_CMD_ENABLED"] = "Aktiviert"
L["OPT_CREATE_VIRTUAL_DEBUFF"] = "Ein virtuelles Gebrechen zum Testen erzeugen."
L["OPT_CREATE_VIRTUAL_DEBUFF_DESC"] = "Lässt dich sehen, wie es aussieht, wenn ein Gebrechen gefunden wurde."
L["OPT_CURE_PRIORITY_NUM"] = "Priorität #%d"
L["OPT_CUREPETS_DESC"] = "Begleiter werden bearbeitet und geheilt"
L["OPT_CURINGOPTIONS"] = "Optionen zur Heilung"
L["OPT_CURINGOPTIONS_DESC"] = "Verschiedene Aspekte des Heilungsprozesses einstellen"
L["OPT_CURINGOPTIONS_EXPLANATION"] = [=[Wähle die Arten von Gebrechen, die du heilen möchtest. Nicht markierte Typen werden komplett von Decursive ignoriert.

Die grüne Zahl legt die Priorität des Gebrechens fest. Diese Priorität beeinflußt mehrere Aspekte:
- Was Decursive als erstes anzeigt, wenn ein Spieler an verschiedenen Debuff-Typen leidet.
- Welche Maus-Schaltfläche du klicken mußt, um den jeweiligen Debuff zu heilen (Erster Zauber ist Linksklick, zweiter ist Rechtsklick, etc...).

All dies wird in der Dokumentation genau erklärt (muß gelesen werden):
http://www.wowace.com/addons/decursive/
]=]
L["OPT_CURINGORDEROPTIONS"] = "Optionen zur Rehenfolge der Heilungen"
L["OPT_CURSECHECK_DESC"] = "Falls markiert, bist du in der Lage, verfluchte Einheiten zu sehen und zu heilen."
L["OPT_CUSTOM_SPELL_ISPET"] = "Pet-Fähigkeit"
L["OPT_CUSTOM_SPELL_MACRO_TEXT"] = "Macro Text:"
L["OPT_CUSTOM_SPELL_MACRO_TOO_LONG"] = "Dein Macro ist zu lang, du musst %d Zeichen entfernen."
L["OPT_CUSTOM_SPELL_PRIORITY"] = "Zauber-Priorität"
L["OPT_CUSTOM_SPELL_UNAVAILABLE"] = "Nicht verfügbar"
L["OPT_CUSTOMSPELLS"] = "Eigene Zauber/Items"
L["OPT_DEBCHECKEDBYDEF"] = [=[

Standardmäßig markiert]=]
L["OPT_DEBUFFENTRY_DESC"] = "Wähle welche Klasse im Kampf ignoriert werden soll,  wenn jemand von diesem Leiden betroffen ist."
L["OPT_DEBUFFFILTER"] = "Gebrechen-Filter"
L["OPT_DEBUFFFILTER_DESC"] = "Gebrechen wählen, die nach Name und Klasse gefiltert werden sollen, während du dich im Kampf befindest."
L["OPT_DELETE_A_CUSTOM_SPELL"] = "Entfernen"
L["OPT_DISABLEABOLISH"] = "\"Aufheben\"-Zauber nicht verwenden"
L["OPT_DISABLEABOLISH_DESC"] = "Wenn aktiviert, bevorzugt Decursive \"Krankheit heilen\" und \"Gift heilen\" gegenüber den entsprechenden \"Aufheben\"-Zaubern."
L["OPT_DISABLEMACROCREATION"] = "Makro-Erstellung ausschalten"
L["OPT_DISABLEMACROCREATION_DESC"] = "Decursive-Makro wird nicht mehr kreiert oder erhalten"
L["OPT_DISEASECHECK_DESC"] = "Falls markiert, wirst du in der Lage sein, erkrankte Einheiten zu sehen und zu heilen."
L["OPT_DISPLAYOPTIONS"] = "Anzeigeoptionen"
L["OPT_DONOTBLPRIO_DESC"] = "Priorisierte Einheiten werden nicht auf die schwarze Liste gesetzt."
L["OPT_ENABLE_A_CUSTOM_SPELL"] = "Aktivieren"
L["OPT_ENABLEDEBUG"] = "Fehlersuche zulassen"
L["OPT_ENABLEDEBUG_DESC"] = "Ausgabe der Fehlersuche zulassen"
L["OPT_ENABLEDECURSIVE"] = "Decursive aktivieren"
L["OPT_FILTEROUTCLASSES_FOR_X"] = "%q wird bei den spezifizierten Klassen ignoriert während du dich im Kampf befindest."
L["OPT_GENERAL"] = "Allgemeine Optionen"
L["OPT_GROWDIRECTION"] = "Anzeige der MUFs umkehren"
L["OPT_GROWDIRECTION_DESC"] = "Die MUFs werden von unten nach oben angezeigt."
L["OPT_HIDEMFS_GROUP"] = "im Solo- oder Gruppenspiel"
L["OPT_HIDEMFS_GROUP_DESC"] = "Das MUF-Fenster verbergen, wenn du nicht in einem Schlachtzug bist."
L["OPT_HIDEMFS_NEVER"] = "Niemals autom. verbergen"
L["OPT_HIDEMFS_NEVER_DESC"] = "Das MUF-Fenster nie automatisch verbergen."
L["OPT_HIDEMFS_SOLO"] = "im Solospiel"
L["OPT_HIDEMFS_SOLO_DESC"] = "Das MUF-Fenster verbergen, wenn du nicht in irgendeiner Art von Gruppe bist."
L["OPT_HIDEMUFSHANDLE"] = "MUF-Handhabung verbergen"
L["OPT_HIDEMUFSHANDLE_DESC"] = [=[Verbirgt die Handhabung der Mikro-Einheiten-Rahmen und schaltet die Möglichkeit aus, diese zu bewegen.
Benutze denselben Befehl, um diese wiederherzustellen.]=]
L["OPT_IGNORESTEALTHED_DESC"] = "Getarnte Einheiten werden ignoriert"
L["OPT_INPUT_SPELL_BAD_INPUT_ALREADY_HERE"] = "Zauber bereits gelistet!"
L["OPT_INPUT_SPELL_BAD_INPUT_DEFAULT_SPELL"] = "Decursive managed diesen Zauber bereits. Shift-Klick auf diesen Zauber, oder gebe seine ID ein, um einen speziellen Rang hinzuzufügen."
L["OPT_INPUT_SPELL_BAD_INPUT_ID"] = "Ungültige Zauber-ID!"
L["OPT_INPUT_SPELL_BAD_INPUT_NOT_SPELL"] = "Zauber wurde in deinem Zauberbuch nicht gefunden!"
L["OPT_LIVELIST"] = "Aktuelle Liste"
L["OPT_LIVELIST_DESC"] = "Optionen für die aktuelle Liste"
L["OPT_LLALPHA"] = "Transparenz Lder aktuellen Liste"
L["OPT_LLALPHA_DESC"] = "Verändert die Transparenz der Decursive-Hauptleiste und der aktuellen Liste (Haupotleiste muß dabei angezeigt werden)"
L["OPT_LLSCALE"] = "Skalierung der aktuellen Liste"
L["OPT_LLSCALE_DESC"] = "Die Größe der Decursive-Hauptleiste und der aktuellen Liste einstellen (die Hauptleiste muß dabei angezeigt werden)."
L["OPT_LVONLYINRANGE"] = "Nur Einheiten in Reichweite"
L["OPT_LVONLYINRANGE_DESC"] = "Nur Einheiten in Heilungsreichweite werden in der aktuellen Liste angezeigt."
L["OPT_MACROBIND"] = "Die an das Makro gebundene Taste festlegen"
L["OPT_MACROBIND_DESC"] = [=[Definiert die Taste, mit der das "Decursive"-Makro aufgerufen wird.

Drücke die Taste und bestätige die Eingabe mit "Enter", um die neue Zuweisung zu speichern (mit deinem Mauszeiger über dem Bearbeitungsfeld)]=]
L["OPT_MACROOPTIONS"] = "Makro-Optionen"
L["OPT_MACROOPTIONS_DESC"] = "Das Verhalten des von Decursive erstellten Mouseover-Makros festlegen."
L["OPT_MAGICCHARMEDCHECK_DESC"] = "Falls markiert, wirst du in der Lage sein, magisch verzauberte Einheiten zu sehen und zu heilen."
L["OPT_MAGICCHECK_DESC"] = "Falls markiert, wirst du in der Lage sein, mit magischen Gebrechen behaftete Einheiten zu sehen und zu heilen."
L["OPT_MAXMFS"] = "Maximale Anzahl der Einheiten, die angezeigt werden sollen"
L["OPT_MAXMFS_DESC"] = "Definiert die maximale Anzahl an Mikro-Einheitsrahmen, die angezeigt werden sollen"
L["OPT_MESSAGES"] = "Mitteilungen"
L["OPT_MESSAGES_DESC"] = "Anzeige-Optionen für Mitteilungen"
L["OPT_MFALPHA"] = "Transparenz"
L["OPT_MFALPHA_DESC"] = "Definiert die Transparenz der MUFs, wenn Einheiten nicht befallen sind"
L["OPT_MFPERFOPT"] = "Leistungs-Optionen"
L["OPT_MFREFRESHRATE"] = "Aktualisierungsrate"
L["OPT_MFREFRESHRATE_DESC"] = "Zeitlicher Abstand zwischen den Erneuerungsabfragen ( 1 oder mehrere Mikro-Einheiten-Rahmen können gleichzeitig erneuert werden)."
L["OPT_MFREFRESHSPEED"] = "Aktualisierungsgeschwindigkeit"
L["OPT_MFREFRESHSPEED_DESC"] = "Anzahl der Mikro-Einheiten-Rahmen, die bei jedem Aktualisierungsabruf auf einmal erneuert werden sollen."
L["OPT_MFSCALE"] = "Skalierung der Mikro-Einheiten-Rahmen (MUFs)"
L["OPT_MFSCALE_DESC"] = "Die Größe der Mikro-Einheiten-Rahmen (MUFs) festlegen"
L["OPT_MFSETTINGS"] = "Einstellungen der Mikro-Einheiten-Rahmen (MUFs)"
L["OPT_MFSETTINGS_DESC"] = "Die Fenster-Optionen der Mikro-Einheiten-Rahmen (MUF) deinen Bedürfnissen anpassen."
L["OPT_MUFFOCUSBUTTON"] = "Fokus-Schaltfläche:"
L["OPT_MUFHANDLE_HINT"] = "Um die Micro-Unit-Frames zu bewegen: ALT-Klick auf das unsichtbare Icon über dem ersten Micro-Unit-Frame Icon."
L["OPT_MUFMOUSEBUTTONS"] = "Maus-Schaltflächen"
L["OPT_MUFMOUSEBUTTONS_DESC"] = "Bestimme die Maustasten, die Du für die verschiedenen Warnfarben der Mikroeinheiten Anzeige (MUF) benutzen möchtest. "
L["OPT_MUFSCOLORS"] = "Farben"
L["OPT_MUFSCOLORS_DESC"] = "Die Farben der Mikro-Einheiten-Rahmen verändern"
L["OPT_MUFSVERTICALDISPLAY"] = "Vertikale Anzeige"
L["OPT_MUFSVERTICALDISPLAY_DESC"] = "MUF's Fenster wächst senkrecht an"
L["OPT_MUFTARGETBUTTON"] = "Tiel-Schaltfläche:"
L["OPT_NEWVERSIONBUGMENOT"] = "Warnung bei neuer Version"
L["OPT_NEWVERSIONBUGMENOT_DESC"] = "Falls eine neuere Version von Decursive ermittelt wird, erscheint einmal alle sieben Tage eine Pop-Up-Meldung dazu."
L["OPT_NOKEYWARN"] = "Warnen, falls keine Tastenbelegung vorhanden"
L["OPT_NOKEYWARN_DESC"] = "Eine Warnmeldung ausgeben, wenn keine Taste zugeordnet wurde."
L["OPT_NOSTARTMESSAGES"] = "Begrüssungsmitteilungen ausschalten"
L["OPT_NOSTARTMESSAGES_DESC"] = "Die Mitteilungen entfernen, die Decursive bei jedem Einloggen im Chat-Fenster ausgibt."
L["OPT_OPTIONS_DISABLED_WHILE_IN_COMBAT"] = "Während du dich im Kampf befindest, sind diese Optionen gesperrt."
L["OPT_PERFOPTIONWARNING"] = "WANUNG: Verändere niemals diese Werte, ausser Du weißt genau was Du machst! Diese Einstellung können massive Auswirkungen auf die Lesitungsfähigkeit des Spiels haben. Für die meisten Spieler genügen die Grundeinstellungen von 0.1 und 10."
L["OPT_PLAYSOUND_DESC"] = "Einen Ton abspielen, wenn jemand mit einem Fluch belegt worden ist."
L["OPT_POISONCHECK_DESC"] = "Falls markiert, wirst du in der Lage sein, vergiftete Einheiten zu sehen und zu heilen."
L["OPT_PRINT_CUSTOM_DESC"] = "Decursive-Mitteilungen werden in einem eigenen Chat-Rahmen ausgegeben"
L["OPT_PRINT_ERRORS_DESC"] = "Fehler werden angezeigt"
L["OPT_PROFILERESET"] = "Profil wird zurückgesetzt...."
L["OPT_RANDOMORDER_DESC"] = "Einheiten werden willkürlich angezeigt und geheilt (nicht empfohlen)"
L["OPT_READDDEFAULTSD"] = "Standard-Gebrechen erneut hinzufügen"
L["OPT_READDDEFAULTSD_DESC1"] = [=[Fehlende Decursive-Standard-Gebrechen dieser Liste hinzufügen.
Deine Einstellungen werden hiermit nicht verändert.]=]
L["OPT_READDDEFAULTSD_DESC2"] = "Alle Decursive-Standard-Gebrechen befinden sich in der Liste."
L["OPT_REMOVESKDEBCONF"] = [=[Bist du dir sicher, dass du
 '%s'
von der Decursive-Liste der zu übergehenden Gebrechen entfernen möchtest?]=]
L["OPT_REMOVETHISDEBUFF"] = "Dieses Gebrechen entfernen"
L["OPT_REMOVETHISDEBUFF_DESC"] = "Entfernt '%s' von der Liste der zu übergehenden Gebrechen."
L["OPT_RESETDEBUFF"] = "Dieses Gebrechen zurücksetzen"
L["OPT_RESETDTDCRDEFAULT"] = "'%s'  wird auf Decursives Standard zurückgesetzt"
L["OPT_RESETMUFMOUSEBUTTONS"] = "Zurücksetzen"
L["OPT_RESETMUFMOUSEBUTTONS_DESC"] = "Zuordnungen der Maus-Schaltflächen auf Standard zurücksetzen."
L["OPT_RESETOPTIONS"] = "Optionen auf Standard zurücksetzen"
L["OPT_RESETOPTIONS_DESC"] = "Aktuelles Profil auf die Standardwerte zurücksetzen."
L["OPT_RESTPROFILECONF"] = [=[Bist du dir sicher, dass du das Profil
'(%s) %s'
auf die Standardoptionen zurücksetzen möchtest?]=]
L["OPT_REVERSE_LIVELIST_DESC"] = "Die aktuelle Liste wird von unten nach oben ausgefüllt"
L["OPT_SCANLENGTH_DESC"] = "Definiert den Zeitabstand zwischen jedem Scanvorgang"
L["OPT_SHOW_STEALTH_STATUS"] = "Verborgenheitsstatus anzeigen"
L["OPT_SHOW_STEALTH_STATUS_DESC"] = "Wenn sich ein Spieler in Verborgenheit befindet, nimmt sein MUF eine spezielle Farbe an."
L["OPT_SHOWBORDER"] = "Umrandung in Klassenfarben anzeigen"
L["OPT_SHOWBORDER_DESC"] = "Eine farbige Umrandung wird um die MUFs angezeigt, die der Klasse der Einheiten entspricht."
L["OPT_SHOWHELP"] = "Hilfe anzeigen"
L["OPT_SHOWHELP_DESC"] = "Zeigt einen detaillierten Tooltip an, wenn du die Maus über einen Mikro-Einheiten-Rahmen legst."
L["OPT_SHOWMFS"] = "Mikro-Einheiten-Rahmen anzeigen"
L["OPT_SHOWMFS_DESC"] = "Dies muss eingeschaltet sein, wenn du mit Mausklicks heilen möchtest."
L["OPT_SHOWMINIMAPICON"] = "Symbol an der Minikarte"
L["OPT_SHOWMINIMAPICON_DESC"] = "Symbol an der Minikarte anzeigen/verbergen."
L["OPT_SHOWTOOLTIP_DESC"] = "Zeigt einen detaillierten Tooltip über Flüche in der aktuellen Liste und in den MUFs an."
L["OPT_STICKTORIGHT"] = "MUF-Fenster rechtsbündig ausrichten"
L["OPT_STICKTORIGHT_DESC"] = "Das MUF-Fenster wächst von rechts nach links. Falls notwendig, wird der Halter bewegt."
L["OPT_TESTLAYOUT"] = "Test-Layout"
L["OPT_TESTLAYOUT_DESC"] = [=[Erschaffe simulierte Einheiten, so dass du das Anzeige-Layout testen kannst.
(Warte ein paar Sekunden nach dem Klicken!)]=]
L["OPT_TESTLAYOUTUNUM"] = "Einheitsnummer"
L["OPT_TESTLAYOUTUNUM_DESC"] = "Anzahl der zu erschaffenden simulierten Einheiten einstellen."
L["OPT_TIE_LIVELIST_DESC"] = "Die Anzeige der aktuellen Liste ist verbunden mit der Anzeige der Decursive-Leisten."
L["OPT_TIECENTERANDBORDER"] = "Transparenz der Mitte und des Rands miteinander verbinden."
L["OPT_TIECENTERANDBORDER_OPT"] = "Falls markiert, ist die Transparenz des Rands die Hälfte der Transparenz der Mitte."
L["OPT_TIEXYSPACING"] = "Horizontalen und vertikalen Abstand an einander binden"
L["OPT_TIEXYSPACING_DESC"] = "Der horizontale und vertikale Abstand zwischen MUFs sind gleich."
L["OPT_UNITPERLINES"] = "Anzahl der Einheiten pro Zeile"
L["OPT_UNITPERLINES_DESC"] = "Definiert die max. Anzahl an Mikro-Einheitenrahmen, die pro Zeile angezeigt werden sollen."
L["OPT_USERDEBUFF"] = "Dieses Leiden gehört nicht zu Decursives standardmässigen Leiden."
L["OPT_XSPACING"] = "Horizontaler Abstand"
L["OPT_XSPACING_DESC"] = "Den horizontalen Abstand zwischen MUFs einstellen."
L["OPT_YSPACING"] = "Vertikaler Abstand"
L["OPT_YSPACING_DESC"] = "Den vertikalen Abstand zwischen MUFs einstellen."
L["OPTION_MENU"] = "Decursive-Optionsmenü"
L["PLAY_SOUND"] = "Akustische Warnung, falls jemand eine Reinigung benötigt"
L["POISON"] = "Gift"
L["POPULATE"] = "P"
L["POPULATE_LIST"] = "Decursive-Liste schnell bestücken"
L["PRINT_CHATFRAME"] = "Mitteilungen im Standard-Chat ausgeben"
L["PRINT_CUSTOM"] = "Mitteilungen im Fenster ausgeben"
L["PRINT_ERRORS"] = "Fehlermitteilungen ausgeben"
L["PRIORITY_LIST"] = "Decursive-Prioritätenliste"
L["PRIORITY_SHOW"] = "P"
L["RANDOM_ORDER"] = "Reinige in zufälliger Reihenfolge"
L["REVERSE_LIVELIST"] = "Aktuelle Liste umgekehrt anzeigen"
L["SCAN_LENGTH"] = "Sekunden zwischen Live-Scans: "
L["SHIFT"] = "SHIFT"
L["SHOW_MSG"] = "Um den Decursive-Rahmen anzuzeigen, /dcrshow eingeben"
L["SHOW_TOOLTIP"] = "Tooltips bei befallenen Einheiten anzeigen"
L["SKIP_LIST_STR"] = "Decursive-Ignorierliste"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "Zauber %s gefunden!"
L["STEALTHED"] = "getarnt"
L["STR_CLOSE"] = "Schließen"
L["STR_DCR_PRIO"] = "Decursive-Prioritätenliste"
L["STR_DCR_SKIP"] = "Decursive-Ignorierliste"
L["STR_GROUP"] = "Gruppe "
L["STR_OPTIONS"] = "Decursive-Optionen"
L["STR_OTHER"] = "Sonstige"
L["STR_POP"] = "Bestückungsliste"
L["STR_QUICK_POP"] = "Schnellbestücken"
L["SUCCESSCAST"] = "|cFF22FFFF%s %s|r |cFF00AA00Erfolgreich bei|r %s"
L["TARGETUNIT"] = "Zieleinheit"
L["TIE_LIVELIST"] = "Sichtbarkeit der aktuellen Liste an DCR-Fenster binden"
L["TOOFAR"] = "Zu weit entfernt"
L["UNITSTATUS"] = "Einheitenstatus:"
L["UNSTABLERELEASE"] = "Instabile Veröffentlichung"



T._LoadedFiles["deDE.lua"] = "2.7.7";
