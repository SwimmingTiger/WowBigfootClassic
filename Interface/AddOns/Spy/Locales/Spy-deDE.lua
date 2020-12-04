local L = LibStub("AceLocale-3.0"):NewLocale("Spy", "deDE")
if not L then return end
-- TOC Note: Detektiert und warnt Sie vor, in der Nähe befindlichen, Gegnern.

-- Configuration
L["Spy"] = "Spy"
L["Version"] = "Version"
L["Spy Option"] = "Spy"
L["Profiles"] = "Profile"

-- About
L["About"] = "Info"
L["SpyDescription1"] = [[
Spy ist ein Addon, das Sie über das Vorhandensein von, in der Nähe befindlichen, feindlichen Spielern benachrichtigt. Dies sind einige der Hauptmerkmale
]]
L["SpyDescription2"] = [[
|cffffd000In der Nähe-Liste|cffffffff
Die "In der Nähe"-Liste zeigt alle feindlichen Spieler, die in der Nähe entdeckt wurden.  Spieler, die für eine gewisse Zeit nicht erkannt wurden, werden aus der Liste entfernt.

|cffffd000Letzte Stunde-Liste|cffffffff
Zeigt alle Feinde, die in der letzten Stunde erkannt wurden.

|cffffd000Ignorierliste|cffffffff
Spieler, die der Ignorierliste hinzugefügt werden, werden nicht vom Spy gemeldet. Mithilfe des Dropdown-Menüs der Schaltfläche oder Halten der STRG-Taste beim Klicken auf die Schaltfläche können Sie Spieler zu der Liste hinzufügen oder entfernen.

|cffffd000Bei Sichtkontakt zu Töten-Liste|cffffffff
Wird ein Spieler der "Bei Sichtkontakt zu Töten"-Liste erkannt, erklingt ein Alarm. Mithilfe des Dropdown-Menüs der Schaltfläche oder Halten der STRG-Taste beim Klicken auf die Schaltfläche können Sie Spieler zu der Liste hinzufügen oder entfernen.

Ausserdem können Sie mithilfe des Dropdown-Menüs die Gründe hinterlegen, warum Sie jemanden zu der "Bei Sichtkontakt zu Töten"-Liste hinzugefügt haben. Möchten Sie einen nicht in der Liste hinterlegten Grund eingeben, verwenden Sie "Geben Sie Ihren eigenen Grund..." in der anderen Liste.

|cffffd000Statistics Window|cffffffff
The Statistics Window contains a list of all enemy encounters which can be sorted by name, level, guild, wins, losses and the last time an enemy was detected. It also provides the ability to search for a specific enemy by name or guild and has filters to show only enemies that are marked as Kill on Sight, with a Win/Loss or entered Reasons.

|cffffd000Kill On Sight Button|cffffffff
If enabled, this button will be located on the enemy players target frame. Clicking on this button will add/remove the enemy target to/from the Kill On Sight list. Right clicking on the button will allow you to enter Kill on Sight reasons.

|cffffd000Autor: Slipjack|cffffffff
]]

-- General Settings
L["GeneralSettings"] = "Allgemeine Einstellungen"
L["GeneralSettingsDescription"] = [[
Optionen für die Aktivierung oder Deaktivierung von Spy.
]] 
L["EnableSpy"] = "Aktiviert Spy"
L["EnableSpyDescription"] = "Aktiviert oder deaktiviert Spy."
L["EnabledInBattlegrounds"] = "Aktiviert Spy in Schlachtfeldern"
L["EnabledInBattlegroundsDescription"] = "Aktiviert oder deaktiviert Spy, wenn Sie in einer Arena sind."
L["EnabledInArenas"] = "Aktiviert Spy in Arenen"
L["EnabledInArenasDescription"] = "Aktiviert oder deaktiviert Spy, wenn Sie in einer Arena sind."
L["EnabledInWintergrasp"] = "Aktiviert Spy in Kampfgebieten der Welt"
L["EnabledInWintergraspDescription"] = "Aktiviert oder deaktiviert Spy, wenn Sie in Kampfgebieten der Welt, wie z.B. Wintergrasp in Northrend, sind."
L["DisableWhenPVPUnflagged"] = "Deaktiviert Spy, wenn PVP nicht eingeschaltet ist"
L["DisableWhenPVPUnflaggedDescription"] = "Aktiviert oder deaktiviert Spy, abhängig von Ihrem PVP-Status."
L["DisabledInZones"] = "Disable Spy while in these locations"
L["DisabledInZonesDescription"]	= "Selecet locations where Spy will be disabled"
L["Booty Bay"] = "Beutebucht"
L["Everlook"] = "Ewige Warte"						
L["Gadgetzan"] = "Gadgetzan"
L["Ratchet"] = "Ratschet"
L["The Salty Sailor Tavern"] = "Taverne \"Zum Salzigen Seemann\""
L["Shattrath City"] = "Shattrath"
L["Area 52"] = "Area 52"
L["Dalaran"] = "Dalaran"
L["Dalaran (Northrend)"] = "Dalaran (Nordend)"
L["Bogpaddle"] = "Kraulsumpf"
L["The Vindicaar"] = "Die Vindikaar" 
L["Krasus' Landing"] = "Krasus' Landeplatz"
L["The Violet Gate"] = "Das Violette Tor"
L["Magni's Encampment"] = "Magnis Lager"
L["Silithus"] = "Silithus"
L["Chamber of Heart"] = "Die Herzkammer"
L["Hall of Ancient Paths"] = "Halle der Uralten Pfade"
L["Sanctum of the Sages"] = "Das Sanktum der Weisen"

-- Display
L["DisplayOptions"] = "Anzeigen"
L["DisplayOptionsDescription"] = [[
Optionen für das Spy-Fenster und QuickInfos.
]]
L["ShowOnDetection"] = "Blendet Spy ein, wenn feindliche Spieler erkannt werden"
L["ShowOnDetectionDescription"] = "Wählen Sie diese Einstellung, um das Spy-Fenster und In der Nähe-Liste anzuzeigen, wenn Spy verborgen ist und feindliche Spieler erkannt werden."
L["HideSpy"] = "Spy ausblenden, wenn keine feindlichen Spieler erkannt werden"
L["HideSpyDescription"] = "Wählen Sie diese Einstellung, um Spy auszublenden, wenn die In der Nähe-Liste angezeigt wird und leer wird. Spy wird nicht ausgeblendet, wenn Sie die Liste manuell löschen."
L["ShowOnlyPvPFlagged"] = "Zeige nur gegnerische Spieler, die im PvP-Modus sind"
L["ShowOnlyPvPFlaggedDescription"] = "Wählen Sie diese Einstellung, um nur die gegnerischen Spieler der In der Nähe-Liste anzuzeigen, die im PvP-Modus sind."
L["ShowKoSButton"] = "Zeigen Sie die Schaltfläche bei Sichtkontakt töten auf dem feindlichen Zielrahmen"
L["ShowKoSButtonDescription"] = "Stellen Sie dies ein, um die Schaltfläche bei Sichtkontakt töten im Zielrahman des Feindes anzuzeigen."
L["Alpha"] = "Transparenz"
L["AlphaDescription"] = "Stellen Sie die Transparenz des SPY-Fensters ein."
L["AlphaBG"] = "Transparenz auf Schlachtfeldern"
L["AlphaBGDescription"] = "Stellen Sie die Transparenz des SPY-Fensters auf Schlachtfeldern ein."
L["LockSpy"] = "Sperrt das Spy-Fenster"
L["LockSpyDescription"] = "Fixiert das Spy-Fenster an einem Ort, so dass es sich nicht bewegt."
L["ClampToScreen"] = "Auf dem Bildschirm halten"
L["ClampToScreenDescription"] = "Kontrolliert, ob das Spy-Fenster über die Bildschirmkanten hinaus verschoben werden kann."
L["InvertSpy"] = "Dreht das Spy-Fenster um"
L["InvertSpyDescription"] = "Kippt das Spy-Fenster verkehrt herum."
L["Reload"] = "Neu laden UI"
L["ReloadDescription"] = "Erforderlich beim Wechseln des SPY-Fenster."
L["ResizeSpy"] = "Adaptiert die Größe des Spy-Fensters automatisch."
L["ResizeSpyDescription"] = "Wählen Sie diese Einstellung, um die Größe des Spy-Fensters automatisch anzupassen, wenn feindliche Spieler hinzugefügt oder entfernt werden."
L["ResizeSpyLimit"] = "Listenlimit"
L["ResizeSpyLimitDescription"] = "Begrenzen Sie die Anzahl der im Spy-Fenster angezeigten gegnerischen Spieler."
L["DisplayTooltipNearSpyWindow"] = "Tooltip in der Nähe des Spy-Fensters anzeigen"
L["DisplayTooltipNearSpyWindowDescription"] = "Stellen Sie dies ein, um Tooltips in der Nähe des Spy-Fensters anzuzeigen."
L["SelectTooltipAnchor"] = "Tooltip-Ankerpunkt"
L["SelectTooltipAnchorDescription"] = "Wählen Sie den Ankerpunkt für den Tooltip aus, wenn die obige Option aktiviert wurde."
L["ANCHOR_CURSOR"] = "Mauszeiger"
L["ANCHOR_TOP"] = "Oben"
L["ANCHOR_BOTTOM"] = "Unterseite"
L["ANCHOR_LEFT"] = "Links"			
L["ANCHOR_RIGHT"] = "Rechts"
L["TooltipDisplayWinLoss"] = "Zeigt die Gewinn/Verlust-Statistik im Tooltip an."
L["TooltipDisplayWinLossDescription"] = "Wählen Sie diese Einstellung, um die Gewinn/Verlust-Statistik eines Spielers in dessen QuickInfo anzuzeigen."
L["TooltipDisplayKOSReason"] = "Zeigt die Gründe für das Töten bei Sichtkontakt im Tooltip an."
L["TooltipDisplayKOSReasonDescription"] = "Wählen Sie diese Einstellung, um die Gründe für das Töten eines Spielers bei Sichtkontakt in der QuickInfo des Spielers anzuzeigen."
L["TooltipDisplayLastSeen"] = "Zeigt die zuletzt angesehenen Details in der QuickInfo an."
L["TooltipDisplayLastSeenDescription"] = "Wählen Sie diese Einstellung, um die letzte bekannte Zeit und den letzten bekannten Ort eines Spielers in der QuickInfo des Spielers anzuzeigen."
L["DisplayListData"] = "Wählen Sie die anzuzeigenden feindlichen Daten aus"
L["Name"] = "Name"
L["Class"] = "Klasse"
L["SelectFont"] = "Wählen Sie eine Schriftart"
L["SelectFontDescription"] = "Wählen Sie eine Schriftart für das Spy-Fenster."
L["RowHeight"] = "Wählen Sie die Zeilenhöhe aus"
L["RowHeightDescription"] = "Wählen Sie die Zeilenhöhe für das Spy-Fenster aus."
L["Texture"] = "Textur"
L["TextureDescription"] = "Wählen Sie eine Textur für das SPY-Fenster"
 
-- Alerts
L["AlertOptions"] = "Warnungen"
L["AlertOptionsDescription"] = [[
Optionen für Warnungen, Ankündigungen und Warnungen, wenn feindliche Spieler erkannt werden.
]]
L["SoundChannel"] = "Wählen Sie Tonkanal"
L["Master"] = "Gesamt"
L["SFX"] = "Effekte"
L["Music"] = "Musik"
L["Ambience"] = "Umgebung"
L["Announce"] = "Ankündigungen senden an:"
L["None"] = "Nichts"
L["NoneDescription"] = "Melde nichts, wenn feindliche Spieler erkannt werden."
L["Self"] = "Selbst"
L["SelfDescription"] = "Melde dir selbst, wenn feindliche Spieler erkannt werden."
L["Party"] = "Gruppe"
L["PartyDescription"] = "Melde deiner Gruppe, wenn feindliche Spieler erkannt werden."
L["Guild"] = "Gilde"
L["GuildDescription"] = "Melde deiner Gilde, wenn feindliche Spieler erkannt werden."
L["Raid"] = "Angriff"
L["RaidDescription"] = "Melde deiner Raid, wenn feindliche Spieler erkannt werden."
L["LocalDefense"] = "Lokale Verteidigung"
L["LocalDefenseDescription"] = "Gebe dem lokalen Verteidigungskanal bekannt, wenn feindliche Spieler erkannt werden."
L["OnlyAnnounceKoS"] = "Gebe nur Gegner bekannt, die bei Sichtkontakt zu töten sind"
L["OnlyAnnounceKoSDescription"] = "Wählen Sie diese Einstellung, um nur die gegnerischen Spielern bekannt zu geben, die auf Ihrer Bei Sichtkontakt zu Töten-Liste sind."
L["WarnOnStealth"] = "Warnt, wenn Tarnungen erkannt werden"
L["WarnOnStealthDescription"] = "Wählen Sie diese Einstellung, um eine Warnung und einen Alarmton wiederzugeben, wenn ein feindlicher Spieler sich tarnt."
L["WarnOnKOS"] = "Warnt bei Erkennung eines Töten bei Sichtkontakts."
L["WarnOnKOSDescription"] = "Wählen Sie diese Einstellung, um eine Warnung und einen Alarmton wiederzugeben, wenn ein feindlicher Spieler von Ihrer Bei Sichtkontakt zu Töten-Liste erkannt wird"
L["WarnOnKOSGuild"] = "Warnt bei Erkennung einer Gilde der Bei Sichtkontakt zu Töten-Liste"
L["WarnOnKOSGuildDescription"] = "Wählen Sie diese Einstellung, um eine Warnung und einen Alarmton wiederzugeben, wenn ein feindlicher Spieler der gleichen Gilde wie jemand auf Ihrer Bei Sichtkontakt zu Töten-Liste erkannt wird."
L["WarnOnRace"] = "Warnt bei Erkennung einer Rasse"
L["WarnOnRaceDescription"] = "Wählen Sie diese Einstellung, um einen Alarmton wiederzugeben, wenn die ausgewählte Rasse detektiert wurde"
L["SelectWarnRace"] = "Wähle die Rasse, welche detektiert werden soll."
L["SelectWarnRaceDescription"] = "Wählen Sie eine Rasse, welche mittels akustischen Alarm angezeigt werden soll."
L["WarnRaceNote"] = "Hinweis: Sie müssen den Feind mindestens einmal ins Visier genommen haben, damit dessen Rasse in die Datenbank aufgenommen werden kann. Bei der nächsten Detektion ertönt ein Alarm. Das funktioniert nicht genauso, wie die Detektion von kämpfenden Gegnern in der Nähe."
L["DisplayWarningsInErrorsFrame"] = "Zeigt Warnungen im Fehler-Fenster an."
L["DisplayWarningsInErrorsFrameDescription"] = "Wählen Sie diese Einstellung, um eine Warnung wiederzugeben, anstatt grafische Popup-Frames anzuzeigen."
L["DisplayWarnings"] = "Wählen Sie den Speicherort der Warnmeldung"
L["Default"] = "Standard"
L["ErrorFrame"] = "Fehlerrahmen"
L["Moveable"] = "Beweglich"
L["EnableSound"] = "Aktiviert akustische Warnungen."
L["EnableSoundDescription"] = "Wählen Sie diese Einstellung, um akustische Warnungen zu aktivieren, wenn feindliche Spieler erkannt werden. Es erklingen unterschiedliche Warnungen, wenn ein feindlicher Spieler sich tarnt oder wenn ein feindlicher Spieler auf deiner Bei Sichtkontakt zu Töten-Liste ist."
L["OnlySoundKoS"] = "Es ertönen nur akustische Alarme fuer die Bei Sichtkontakt zu Töten-Liste"
L["OnlySoundKoSDescription"] = "Wählen Sie diese Einstellung, so dass nur akustische Warnungen ertönen, wenn feindliche Spieler von der Bei Sichtkontakt zu Töten-Liste erkannt werden."
L["StopAlertsOnTaxi"] = "Deaktivieren Sie Warnungen, während Sie sich auf einer Flugroute befinden"
L["StopAlertsOnTaxiDescription"] = "Stoppen Sie alle neuen Alarme und Warnungen, während Sie sich auf einer Flugroute befinden."
 
-- Nearby List
L["ListOptions"] = "In der Nähe-Liste"
L["ListOptionsDescription"] = [[
Optionen, wie feindliche Spieler hinzugefügt und entfernt werden.
]]
L["RemoveUndetected"] = "Entfernt feindliche Spieler aus der In der Nähe-Liste nach:"
L["1Min"] = "1 Minute"
L["1MinDescription"] = "Entfernt einen feindlichen Spieler, der seit über 1 Minute unentdeckt geblieben ist."
L["2Min"] = "2 Minuten"
L["2MinDescription"] = "Entfernt einen feindlichen Spieler, der seit über 2 Minuten unentdeckt geblieben ist."
L["5 Minuten"] = "5 Minuten"
L["5MinDescription"] = "Entfernt einen feindlichen Spieler, der seit über 5 Minuten unentdeckt geblieben ist."
L["10Min"] = "10 Minuten"
L["10MinDescription"] = "Entfernt einen feindlichen Spieler, der seit über 10 Minuten unentdeckt geblieben ist."
L["15Min"] = "15 Minuten"
L["15MinDescription"] = "Entfernt einen feindlichen Spieler, der seit über 15 Minuten unentdeckt geblieben ist."
L["Never"] = "Niemals entfernen"
L["NeverDescription"] = "Entfernt niemals feindliche Spieler. Die In der Nähe-Liste kann weiterhin manuell gelöscht werden."
L["ShowNearbyList"] = "Wechselt auf die In der Nähe-Liste bei Entdeckung feindlicher Spieler."
L["ShowNearbyListDescription"] = "Stellen Sie hier die Anzeige der In der Nähe-Liste ein, wenn sie nicht bereits bei Entdeckung feindlicher Spieler sichtbar ist."
L["PrioritiseKoS"] = "Priorisiere feindliche Spieler auf der In der Nähe-Liste, die sofort getötet werden sollen."
L["PrioritiseKoSDescription"] = "Stellen Sie hier ein, das feindliche Spieler, die sofort getötet werden sollen, immer zuerst  auf der In der Nähe-Liste erscheinen."
 
-- Map
L["MapOptions"] = "Karte"
L["MapOptionsDescription"] = [[
Optionen für Weltkarte und Minikarte, einschließlich Symbole und QuickInfos.
]]
L["MinimapDetection"] = "Aktiviere Minikarte Entdeckung"
L["MinimapDetectionDescription"] = "Wenn Sie den Mauszeiger über bekannte feindliche Spieler bewegen, die auf der Minikarte gefunden wurden, werden diese zur Nähe-Liste hinzugefügt."
L["MinimapNote"] = "          Hinweis: Funktioniert nur für Spieler, die Humanoide verfolgen können."
L["MinimapDetails"] = "Zeige die Details der Level/Klassen in QuickInfos an."
L["MinimapDetailsDescription"] = "Aktualisieren Sie hier die QuickInfo der Karte, sodass die Details der Level/Klassen neben feindlichen Namen angezeigt werden."
L["DisplayOnMap"] = "Symbole auf der Karte anzeigen"
L["DisplayOnMapDescription"] = "Zeigen Sie Kartensymbole für die Position anderer Spy-Benutzer in Ihrer Gruppe, Schlachtzug und Gilde an, wenn sie Feinde erkennen."
L["SwitchToZone"] = "Wechseln Sie in der aktuellen Zonenkarte auf feindliche Erkennung"
L["SwitchToZoneDescription"] = "Change the map to the players current zone map when enemies are detected."
L["MapDisplayLimit"] = "Limitiert angezeigte Kartensymbole auf:"
L["LimitNone"] = "Überall"
L["LimitNoneDescription"] = "Zeigt, unabhängig von Ihrem aktuellen Standort, alle erkannten Feinde auf der Karte an."
L["LimitSameZone"] = "Gleiche Zone"
L["LimitSameZoneDescription"] = "Zeigt nur die entdeckten Feinde auf der Karte an, die sich in der gleichen Zone befinden."
L["LimitSameContinent"] = "Gleicher Kontinent"
L["LimitSameContinentDescription"] = "Zeigt nur die entdeckten Feinde auf der Karte an, die sich auf dem gleichen Kontinent befinden."

-- Data Management
L["DataOptions"] = "Datenmanagement"
L["DataOptionsDescription"] = [[
Optionen, wie Spy Daten verwaltet und sammelt.
]]
L["PurgeData"] = "Eliminiert unentdeckte feindliche Spieler-Daten nach:"
L["OneDay"] = "1 Tag"
L["OneDayDescription"] = "Eliminiert Daten feindlicher Spieler, die für 1 Tag unentdeckt geblieben sind."
L["FiveDays"] = "5 Tage"
L["FiveDaysDescription"] = "Eliminiert Daten feindlicher Spieler, die für 5 Tage unentdeckt geblieben sind."
L["TenDays"] = "10 Tage"
L["TenDaysDescription"] = "Eliminiert Daten feindlicher Spieler, die für 10 Tage unentdeckt geblieben sind."
L["ThirtyDays"] = "30 Tage"
L["ThirtyDaysDescription"] = "Eliminiert Daten feindlicher Spieler, die für 30 Tage unentdeckt geblieben sind."
L["SixtyDays"] = "60 Tage"
L["SixtyDaysDescription"] = "Eliminiert Daten feindlicher Spieler, die für 60 Tage unentdeckt geblieben sind."
L["NinetyDays"] = "90 Tage"
L["NinetyDaysDescription"] = "Eliminiert Daten feindlicher Spieler, die für 90 Tage unentdeckt geblieben sind."
L["PurgeKoS"] = "Eliminiert feindliche Spieler, basierend auf der Zeit, die sie unentdeckt geblieben sind."
L["PurgeKoSDescription"] = "Eliminiert Sofort zu tötende Spieler, welche unentdeckt geblieben sind, basierend auf den Zeiteinstellungen für unentdeckte Spieler."
L["PurgeWinLossData"] = "Eliminiert Sieg/Verlust-Daten, basierend auf der unentdeckten Zeit."
L["PurgeWinLossDataDescription"] = "Stellt die Eliminierung der Sieg/Verlust-Daten Ihrer feindlichen Spieler-Begegnungen ein, basierend auf den Zeiteinstellungen für unentdeckte Spieler."
L["ShareData"] = "Teile die Daten mit anderen Spy-Benutzern."
L["ShareDataDescription"] = "Stellt ein, dass Details Ihrer feindlichen Spieler-Begegnungen mit anderen Spy-Benutzern Ihrer Gruppe und Gilde geteilt werden."
L["UseData"] = "Verwende Daten anderer Spy-Benutzer."
L["UseDataDescription"] = "Stelle dies ein, um gesammelte Daten anderer Spy-Benutzer Ihrer Gruppe und Gilde zu verwenden."
L["ShareKOSBetweenCharacters"] = "Teile Sofort zu tötende Spieler mit Ihren anderen Charakteren."
L["ShareKOSBetweenCharactersDescription"] = "Wählen Sie diese Einstellung, um die Sofort zu tötende Spieler mit Ihren anderen Charakteren auf dem gleichen Server und Lager zu teilen."

-- Commands
L["SlashCommand"] = "Slash Befehl"
L["SpySlashDescription"] = "Diese Schaltflächen führen die gleichen Funktionen aus, wie die in den Slash Befehl /spy"
L["Enable"] = "Aktivieren"
L["EnableDescription"] = "Aktiviert Spy und zeigt das Hauptfenster."
L["Show"] = "Zeigen"
L["ShowDescription"] = "Zeigt das Hauptfenster."
L["Hide"] = "Ausblenden"
L["HideDescription"] = "Blendet das Hauptfenster aus."
L["Reset"] = "Zurücksetzen"
L["ResetDescription"] = "Setzt die Position und die Darstellung des Hauptfensters zurück."
L["ClearSlash"] = "Löschen"
L["ClearSlashDescription"] = "Löscht die Liste der Spieler, die entdeckt wurden."
L["Config"] = "Konfigurieren"
L["ConfigDescription"] = "Öffnet das Interface-Konfigurationsfenster für Spy."
L["KOS"] = "KOS"
L["KOSDescription"] = "Fügt hinzu/entfernt einen Spieler von der Sofort zu Töten-Liste."
L["InvalidInput"] = "Ungültige Eingabe"
L["Ignore"] = "Ignorieren"
L["IgnoreDescription"] = "Fügt hinzu/entfernt einen Spieler von der Zu Ignorieren-Liste."
L["Test"] = "Testen"
L["TestDescription"] = "Zeigt eine Warnung an, damit Sie sie neu positionieren können."
 
--Listen
L["Nearby"] = "In der Nähe"
L["LastHour"] = "Letzte Stunde"
L["Ignore"] = "Ignorieren"
L["KillOnSight"] = "Sofort zu Töten"
 
--Stats
L["Won"] = "Gewonnen"
L["Lost"] = "Verloren"
L["Time"] = "Zeit"	
L["List"] = "Liste"	
L["Filter"] = "Filter"
L["Show Only"] = "Zeige nur"
L["Won/Lost"] = "Gewonnen/Verloren"
L["KOS"] = "KOS"
L["Reason"] = "Grund"	
L["HonorKills"] = "Ehrenvolle Siege"
L["PvPDeatchs"] = "PvP Tode"

--Ausgabemeldungen
L["VersionCheck"] = "|cffc41e3aWarnung! Die falsche Version von Spy ist installiert. Entfernen Sie diese Version und installieren Sie Spy Classic."
L["SpyEnabled"] = "|cff9933ffSpy-Addon aktiviert."
L["SpyDisabled"] = "|cff9933ffSpy-Addon deaktiviert. Tippen Sie |cffffffff/spy show|cff9933ff um es zu aktivieren."
L["UpgradeAvailable"] = "|cff9933ffEine neue Version von Spy ist verfügbar. Es kann von: \n| cffffffffhttps://www.curseforge.com/wow/addons/spy-classic heruntergeladen werden."
L["AlertStealthTitle"] = "Getarnte Spieler erkannt!"
L["AlertKOSTitle"] = "Sofort zu tötenden Spieler erkannt!"
L["AlertKOSGuildTitle"] = "Gilde eines Sofort zu tötenden Spielers erkannt!"
L["AlertTitle_kosaway"] = "Sofort zu tötenden Spieler lokalisiert bei "
L["AlertTitle_kosguildaway"] = "Gilde eines Sofort zu tötenden Spielers lokalisiert bei"
L["StealthWarning"] = "|cff9933ffGetarnten Spieler erkannt: |cffffffff"
L["KOSWarning"] = "|cffff0000Sofort zu töten-Spieler erkannt: |cffffffff"
L["KOSGuildWarning"] = "|cffff0000Gilde eines Sofort zu tötenden Spielers erkannt: |cffffffff"
L["SpySignatureColored"] = "|cff9933ff [Spy]"
L["PlayerDetectedColored"] = "Spieler erkannt: |cffffffff"
L["PlayersDetectedColored"] = "Spieler erkannt: |cffffffff"
L["KillOnSightDetectedColored"] = "Sofort zu tötenden Spieler erkannt: |cffffffff"
L["PlayerAddedToIgnoreColored"] = "Zur Ignorieren-Liste hinzugefügter Spieler: |cffffffff"
L["PlayerRemovedFromIgnoreColored"] = "Von der Ignorieren-Liste entfernter Spieler: |cffffffff"
L["PlayerAddedToKOSColored"] = "Fügt Spieler der Sofort zu töten-Liste hinzu: |cffffffff"
L["PlayerRemovedFromKOSColored"] = "Von der Sofort zu töten-Liste entfernter Spieler: |cffffffff"
L["PlayerDetected"] = "[Spy] Spieler erkannt:"
L["KillOnSightDetected"] = "[Spy] Sofort zu tötenden Spieler erkannt:"
L["Level"] = "Level"
L["LastSeen"] = "Zuletzt gesehen"
L["LessThanOneMinuteAgo"] = "vor weniger als einer minute"
L["MinutesAgo"] = "vor Minuten"
L["HoursAgo"] = "vor Stunden"
L["DaysAgo"] = "vor Tagen"
L["Close"] = "Schließen"
L["CloseDescription"] = "|cffffffffVerbirgt das Spy-Fenster. Es wird standardmäßig wieder gezeigt, wenn der nächste feindliche Spieler erkannt wird."
L["Left/Right"] = "Links/Rechts"
L["Left/RightDescription"] = "|cffffffffNavigiert zwischen den Listen: In der Nähe, Letzte Stunde, Ignorieren und Sofort zu töten."
L["Clear"] = "Löschen"
L["ClearDescription"] = "|cffffffffLöscht die Liste der Spieler, die gefunden wurden. Strg-Klick stoppt/startet Spy. Shift-Click schaltet den Ton ein / aus."
L["SoundEnabled"] = "Audiowarnungen aktiviert"
L["SoundDisabled"] = "Audiowarnungen deaktiviert"
L["NearbyCount"] = "Anzahl der Spieler in der Nähe "
L["NearbyCountDescription"] = "|cffffffffSendet die Anzahl der in der Nähe befindlichen Spieler zum chatten"
L["Statistics"] = "Statistiken"
L["StatsDescription"] = "|cffffffffZeigt eine Liste der angetroffenen feindlichen Spieler,  Aufzeichnungen über Gewinne/Niederlagen und wo sie zuletzt gesehen wurden"
L["AddToIgnoreList"] = "Fügt zur Ignorieren-Liste hinzu"
L["AddToKOSList"] = "Fügt zur Sofort zu töten-Liste hinzu"
L["RemoveFromIgnoreList"] = "Entfernt von der zu Ignorieren-Liste"
L["RemoveFromKOSList"] = "Entfernt von der Sofort zu töten-Liste"
L["RemoveFromStatsList"] = "Entfernt von der Statistikliste"   
L["AnnounceDropDownMenu"] = "Melden"
L["KOSReasonDropDownMenu"] = "Hinterlegt Grund für Sofort zu töten"
L["PartyDropDownMenu"] = "Gruppe"
L["RaidDropDownMenu"] = "Raid"
L["GuildDropDownMenu"] = "Gilde"
L["LocalDefenseDropDownMenu"] = "Lokale Verteidigung"
L["Player"] = "(Spieler)"
L["KOSReason"] = "Sofort zu töten"
L["KOSReasonIndent"] = "    "
L["KOSReasonOther"] = "Geben Sie Ihren eigenen Grund ein ..."
L["KOSReasonClear"] = "Löschen Grund"
L["StatsWins"] = "|cff40ff00Gewinne:"
L["StatsSeparator"] = ""
L["StatsLoses"] = "|cff0070ddNiederlagen:"
L["Located"] = "lokalisiert:"
L["Yards"] = "Yards"
L["LocalDefenseChannelName"] = "LokaleVerteidigung"
 
Spy_KOSReasonListLength = 6
Spy_KOSReasonList = {
	[1] = {
		["title"] = "Gestarteter Kampf";
		["content"] = {
			"Griff mich ohne Grund an",
			"Griff mich auf einer Suche an",
			"Griff mich an, während ich NSCs bekämpfte",
			"Griff mich an, während ich in der Nähe einer Instanz war",
			"Griff mich an, während ich AFK war",
			"Griff mich an, während ich ritt/flog",
			"Griff mich an, während ich schlechter Gesundheit/Mana war",
		};
	},
	[2] = {
		["title"] = "Stil des Kampfes";
		["content"] = {
			"Überfiel mich",
			"Attackiert mich immer, wenn es mich sieht",
			"Tötete mich mit einem Charakter höheren Levels",
			"Überwältigte mich mit einer Gruppe von Feinden",
			"Attackiert nicht ohne Backup",
			"Ruft immer um Hilfe",
			"Nutzt zu viel Menschenmengenkontrolle",
		};
	},
	[3] = {
		["title"] = "camping";
		["content"] = {
			"Camped mich",
			"Camped meinen anderen Charakter",
			"Camped untere Charaktere",
			"Camped durch Unsichtbare",
			"Camped Gildenmitglieder",
			"Camped Spiel NPCs/Ziele",
			"Camped eine/n Stadt/Ort ",
		};
	},
	[4] = {
		["title"] = "Suchen";
		["content"] = {
			"Griff mich an, während ich suchte.",
			"Griff mich an, nachdem ich mit der Suche geholfen hatte.",
			"Störte mit einen Suchobjekt.",
			"Startete eine Suche, die ich durchführen wollte",
			"Tötete meine Fraktion NPCs",
			"Tötete eine NPC Suche",
		};
	},
	[5] = {
		["title"] = "Diebstahl Ressourcen";
		["content"] = {
			"Gesammelte Kräuter, die ich wollte",
			"Gefundene Mineralien, die ich wollte",
			"Gesammelte Ressourcen, die ich wollte",
			"Tötete mich und stahl meine Ziele/seltene NPC",
			"Enthäutete meine Kills",
			"Barg meine Kills",
			"In meinem Pool gefischt",
		};
	},
	[6] = {
		["title"] = "Andere";
		["content"] = {
		"Markiert für PvP",
		"Stie mich von einer Klippe",
		"Verwendete Engineering-Tricks",
		"Gelingt es immer, zu entkommen",
		"Benutzt Gegenstände und Fähigkeiten um zu entkommen",
		"Nutzt Spielmechanism en aus",
		"Geben Sie Ihren eigenen Grund ein ...",
		};
	},
}
 
StaticPopupDialogs ["Spy_SetKOSReasonOther"] = {
	PreferredIndex = STATICPOPUPS_NUMDIALOGS,--http://forums.wowace.com/showthread.php?p=320956
	text = "Geben Sie den Grund für das Sofort zu töten %s ein",
	button1 = "Einstellen",
	button2 = "Abbrechen",
	timeout = 20,
	hasEditBox = 1,
	editBoxWidth = 260,		
	whileDead = 1,
	hideOnEscape = 1,
	OnShow = function(self)
		self.editBox:SetText("");
	end,
	OnAccept = function(self)
		local reason = Self.editBox:GetText()
		Spy:SetKOSReason(self.playerName, "Geben Sie Ihren eigenen Grund ein ...", reason)
	end,
};

-- Class descriptions
L["UNKNOWN"] = "Unbekannt"
L["DRUID"] = "Druide"
L["HUNTER"] = "Jäger"
L["MAGE"] = "Magier"
L["PALADIN"] = "Paladin"
L["PREIST"] = "Priester"
L["ROGUE"] = "Schurke"
L["SHAMAN"] = "Schamane"
L["WARLOCK"] = "Hexenmeister"
L["WARRIOR"] = "Krieger"
L["DEATHKNIGHT"] = "Todesritter"
L["MONK"] = "Mönch"
L["DEMONHUNTER"] = "Dämonenjäger"
 
-- Race descriptions
L["Human"] = "Mensch"
L["Orc"] = "Orc"
L["Dwarf"] = "Zwerg"
L["Tauren"] = "Tauren"
L["Troll"] = "Troll"
L["Night Elf"] = "Nachtelf"
L["Undead"] = "Untoter"
L["Gnome"] = "Gnom"
L["Blood Elf"] = "Blutelf"
L["Draenei"] = "Draenei"
L["Goblin"] = "Goblin"
L["Worgen"] = "Worgen"
L["Pandaren"] = "Pandaren"
L["Highmountain Tauren"] = "Hochbergtauren"
L["Lightforged Draenei"] = "Lichtgeschmiedeter Draenei"
L["Nightborne"] = "Nachtgeborener"
L["Void Elf"] = "Leerenelf"	
L["Dark Iron Dwarf"] = "Dunkeleisenzwerg"
L["Mag'har Orc"] = "Mag'har"
L["Kul Tiran"] = "Kul Tiran"
L["Zandalari Troll"] = "Zandalaritroll"
L["Mechagnome"] = "Mechagnom"
L["Vulpera"] = "Vulpera"
 
-- Stealth Fähigkeiten
L["Stealth"] = "Verstohlenheit"
L["Prowl"] = "Schleichen"
 
-- Minimap-Farbcodes
L["MinimapGuildText"] = "|cffffffff"
L["MinimapClassTextUNKNOWN"] = "|cff191919"
L["MinimapClassTextDRUID"] = "|cffff7c0a"
L["MinimapClassTextHUNTER"] = "|cffaad372"
L["MinimapClassTextMAGE"] = "|cff68ccef"
L["MinimapClassTextPALADIN"] = "|cfff48cba"
L["MinimapClassTextPRIEST"] = "|cffffffff"
L["MinimapClassTextROGUE"] = "|cfffff468"
L["MinimapClassTextSHAMAN"] = "|cff2359ff"
L["MinimapClassTextWARLOCK"] = "|cff9382c9"
L["MinimapClassTextWARRIOR"] = "|cffc69b6d"
L["MinimapClassTextDEATHKNIGHT"] = "|cffc41e3a"
L["MinimapClassTextMONK"] = "|cff00ff96"
L["MinimapClassTextDEMONHUNTER"] = "|cffa330c9"
 
Spy_AbilityList = {
 -----------------------------------------------------------
--Ermöglicht eine Abschätzung der Rasse, Klasse und Niveau ein
--Spieler bestimmt, welche Fähigkeiten beobachtet werden
--im Kampflog angezeigt.
-----------------------------------------------------------
--++ Racial Traits ++	
	["Schattenhaftigkeit"]={ race = "Night Elf", level = 1, },
	["Kochendes Blut"]={ race = "Orc", level = 1, },
	["Wille der Verlassenen"]={ race = "Undead", level = 1, },
	["Steingestalt"]={ race = "Dwarf", level = 1, },
	["Berserker"]={ race = "Troll", level = 1, },
	["Zähigkeit"]={ race = "Orc", level = 1, },
	["Schwert-Spezialisierung"]={ race = "Human", level = 1, },
	["Entfesselungskünstler"]={ race = "Gnome", level = 1, },
	["Unbeugsamkeit"]={ race = "Human", level = 1, },
	["Regeneration"]={ race = "Troll", level = 1, },
	["Wachsamkeit"]={ race = "Human", level = 1, },
	["Durchhaltevermögen"]={ race = "Tauren", level = 1, },
	["Bogenspezialisierung"]={ race = "Troll", level = 1, },
	["Grüner Daumen"]={ race = "Tauren", level = 1, },
	["Technologist"]={ race = "Gnome", level = 1, },
	["Kriegsdonner"]={ race = "Tauren", level = 1, },
	["Wildtierschlächter"]={ race = "Troll", level = 1, },
	["Schatzsucher"]={ race = "Dwarf", level = 1, },
	["Axtspezialisierung"]={ race = "Orc", level = 1, },
	["Kannibalismus"]={ race = "Undead", level = 1, },
	["Diplomatie"]={ race = "Human", level = 1, },
	["Schnelligkeit"]={ race = "Night Elf", level = 1, },
	["Wurfwaffen-Spezialisierung"]={ race = "Troll", level = 1, },
	["Streitkolben-Spezialisierung"]={ race = "Human", level = 1, },
	["Schusswaffenspezialisierung"]={ race = "Dwarf", level = 1, },
	["Unterwasseratmung"]={ race = "Undead", level = 1, },
	["Befehlsgewalt"]={ race = "Orc", level = 1, },
	["Naturwiderstand"]={ race = "Night Elf", level = 1, },
	["Frostwiderstand"]={ race = "Dwarf", level = 1, },
	["Schattenwiderstand"]={ race = "Undead", level = 1, },
	["Arkanwiderstand"]={ race = "Gnome", level = 1, },
	["Irrwischgeist"]={ race = "Night Elf", level = 1, },

--++ Druid Abilities ++	
	["Heilende Berührung"]={ class = "DRUID", level = 1, },
	["Zorn"]={ class = "DRUID", level = 1, },
	["Mondfeuer"]={ class = "DRUID", level = 4, },
	["Wucherwurzeln"]={ class = "DRUID", level = 8, },
	["Bärengestalt"]={ class = "DRUID", level = 10, },
	["Demoralisierendes Gebrüll"]={ class = "DRUID", level = 10, },
	["Knurren"]={ class = "DRUID", level = 10, },
	["Zermalmen"]={ class = "DRUID", level = 10, },
	["Teleportieren: Moonglade"]={ class = "DRUID", level = 10, },
	["Wutanfall"]={ class = "DRUID", level = 12, },
	["Nachwachsen"]={ class = "DRUID", level = 12, },
	["Hieb"]={ class = "DRUID", level = 14, },
	["Wassergestalt"]={ class = "DRUID", level = 16, },
	["Prankenhieb"]={ class = "DRUID", level = 16, },
	["Feenfeuer"]={ class = "DRUID", level = 18, },
	["Winterschlaf"]={ class = "DRUID", level = 18, },
	["Katzengestalt"]={ class = "DRUID", level = 20, },
	["Klaue"]={ class = "DRUID", level = 20, },
	["Schleichen"]={ class = "DRUID", level = 20, },
	["Wiedergeburt"]={ class = "DRUID", level = 20, },
	["Zerfetzen"]={ class = "DRUID", level = 20, },
	["Sternenfeuer"]={ class = "DRUID", level = 20, },
	["Schreddern"]={ class = "DRUID", level = 22, },
	["Tier besänftigen"]={ class = "DRUID", level = 22, },
	["Krallenhieb"]={ class = "DRUID", level = 24, },
	["Fluch aufheben"]={ class = "DRUID", level = 24, },
	["Tigerfuror"]={ class = "DRUID", level = 24, },
	["Vergiftung aufheben"]={ class = "DRUID", level = 26, },
	["Spurt"]={ class = "DRUID", level = 26, },
	["Herausforderndes Gebrüll"]={ class = "DRUID", level = 28, },
	["Ducken"]={ class = "DRUID", level = 28, },
	["Reisegestalt"]={ class = "DRUID", level = 30, },
	["Wilder Biss"]={ class = "DRUID", level = 32, },
	["Verheeren"]={ class = "DRUID", level = 32, },
	["Rasende Regeneration"]={ class = "DRUID", level = 36, },
	["Anspringen"]={ class = "DRUID", level = 36, },
	["Terrorbärengestalt"]={ class = "DRUID", level = 40, },
--++ Druid Talents ++	
	["Griff der Natur"]={ class = "DRUID", level = 10, },
	["Wilde Attacke"]={ class = "DRUID", level = 20, },
	["Insektenschwarm"]={ class = "DRUID", level = 20, },
	["Omen der Klarsicht"]={ class = "DRUID", level = 20, },
	["Feenfeuer (Tiergestalt)"]={ class = "DRUID", level = 30, },
--++ Hunter Abilities ++	
	["Bereitschaft"]={ class = "HUNTER", level = 1, },
	["Automatischer Schuss"]={ class = "HUNTER", level = 1, },
	["Raptorstoß"]={ class = "HUNTER", level = 1, },
	["Wildtiere aufspüren"]={ class = "HUNTER", level = 1, },
	["Aspekt des Affen"]={ class = "HUNTER", level = 4, },
	["Schlangenbiss"]={ class = "HUNTER", level = 4, },
	["Arkaner Schuss"]={ class = "HUNTER", level = 6, },
	["Mal des Jägers"]={ class = "HUNTER", level = 6, },
	["Erschütternder Schuss"]={ class = "HUNTER", level = 8, },
	["Aspekt des Falken"]={ class = "HUNTER", level = 10, },
	["Tier rufen"]={ class = "HUNTER", level = 10, },
	["Tier freigeben"]={ class = "HUNTER", level = 10, },
	["Tier füttern"]={ class = "HUNTER", level = 10, },
	["Tier wiederbeleben"]={ class = "HUNTER", level = 10, },
	["Wildtier zähmen"]={ class = "HUNTER", level = 10, },
	["Ablenkender Schuss"]={ class = "HUNTER", level = 12, },
	["Tier heilen"]={ class = "HUNTER", level = 12, },
	["Zurechtstutzen"]={ class = "HUNTER", level = 12, },
	["Adlerauge"]={ class = "HUNTER", level = 14, },
	["Augen des Wildtiers"]={ class = "HUNTER", level = 14, },
	["Wildtier ängstigen"]={ class = "HUNTER", level = 14, },
	["Feuerbrandfalle"]={ class = "HUNTER", level = 16, },
	["Mungobiss"]={ class = "HUNTER", level = 16, },
	["Mehrfachschuss"]={ class = "HUNTER", level = 18, },
	["Untote aufspüren"]={ class = "HUNTER", level = 18, },
	["Aspekt des Geparden"]={ class = "HUNTER", level = 20, },
	["Rückzug"]={ class = "HUNTER", level = 20, },
	["Eiskältefalle"]={ class = "HUNTER", level = 20, },
	["Skorpidstich"]={ class = "HUNTER", level = 22, },
	["Wildtierkunde"]={ class = "HUNTER", level = 24, },
	["Verborgenes aufspüren"]={ class = "HUNTER", level = 24, },
	["Schnellfeuer"]={ class = "HUNTER", level = 26, },
	["Elementare aufspüren"]={ class = "HUNTER", level = 26, },
	["Frostfalle"]={ class = "HUNTER", level = 28, },
	["Aspekt des Wildtiers"]={ class = "HUNTER", level = 30, },
	["Totstellen"]={ class = "HUNTER", level = 30, },
	["Leuchtfeuer"]={ class = "HUNTER", level = 32, },
	["Dämonen aufspüren"]={ class = "HUNTER", level = 32, },
	["Sprengfalle"]={ class = "HUNTER", level = 34, },
	["Vipernbiss"]={ class = "HUNTER", level = 36, },
	["Aspekt des Rudels"]={ class = "HUNTER", level = 40, },
	["Riesen aufspüren"]={ class = "HUNTER", level = 40, },
	["Salve"]={ class = "HUNTER", level = 40, },
	["Aspekt der Wildnis"]={ class = "HUNTER", level = 46, },
	["Drachkin aufspüren"]={ class = "HUNTER", level = 50, },
	["Einlullender Schuss"]={ class = "HUNTER", level = 60, },
--++ Hunter Talents ++	
	["Gezielter Schuss"]={ class = "HUNTER", level = 20, },
	["Abschreckung"]={ class = "HUNTER", level = 20, },
	["Gegenangriff"]={ class = "HUNTER", level = 30, },
	["Einschüchterung"]={ class = "HUNTER", level = 30, },
	["Streuschuss"]={ class = "HUNTER", level = 30, },
	["Zorn des Wildtiers"]={ class = "HUNTER", level = 40, },
	["Stich des Flügeldrachen"]={ class = "HUNTER", level = 40, },
--++ Mage Abilities ++	
	["Feuerball"]={ class = "MAGE", level = 1, },
	["Frostrüstung"]={ class = "MAGE", level = 1, },
	["Frostblitz"]={ class = "MAGE", level = 4, },
	["Wasser herbeizaubern"]={ class = "MAGE", level = 4, },
	["Feuerschlag"]={ class = "MAGE", level = 6, },
	["Essen herbeizaubern"]={ class = "MAGE", level = 6, },
	["Arkane Geschosse"]={ class = "MAGE", level = 8, },
	["Verwandlung"]={ class = "MAGE", level = 8, },
	["Frostnova"]={ class = "MAGE", level = 10, },
	["Arkane Explosion"]={ class = "MAGE", level = 14, },
	["Magie entdecken"]={ class = "MAGE", level = 16, },
	["Flammenstoß"]={ class = "MAGE", level = 16, },
	["Geringen Fluch aufheben"]={ class = "MAGE", level = 18, },
	["Blinzeln"]={ class = "MAGE", level = 20, },
	["Blizzard"]={ class = "MAGE", level = 20, },
	["Hervorrufung"]={ class = "MAGE", level = 20, },
	["Feuerzauberschutz"]={ class = "MAGE", level = 20, },
	["Manaschild"]={ class = "MAGE", level = 20, },
	["Teleportieren: Ironforge"]={ class = "MAGE", level = 20, },
	["Teleportieren: Orgrimmar"]={ class = "MAGE", level = 20, },
	["Teleportieren: Stormwind"]={ class = "MAGE", level = 20, },
	["Teleportieren: Undercity"]={ class = "MAGE", level = 20, },
	["Frostzauberschutz"]={ class = "MAGE", level = 22, },
	["Versengen"]={ class = "MAGE", level = 22, },
	["Gegenzauber"]={ class = "MAGE", level = 24, },
	["Kältekegel"]={ class = "MAGE", level = 26, },
	["Manaachat herbeizaubern"]={ class = "MAGE", level = 28, },
	["Eisrüstung"]={ class = "MAGE", level = 30, },
	["Teleportieren: Darnassus"]={ class = "MAGE", level = 30, },
	["Teleportieren: Thunder Bluff"]={ class = "MAGE", level = 30, },
	["Magische Rüstung"]={ class = "MAGE", level = 34, },
	["Manajadestein herbeizaubern"]={ class = "MAGE", level = 38, },
	["Portal: Ironforge"]={ class = "MAGE", level = 40, },
	["Portal: Orgrimmar"]={ class = "MAGE", level = 40, },
	["Portal: Stormwind"]={ class = "MAGE", level = 40, },
	["Portal: Undercity"]={ class = "MAGE", level = 40, },
	["Manacitrin herbeizaubern"]={ class = "MAGE", level = 48, },
	["Portal: Darnassus"]={ class = "MAGE", level = 50, },
	["Portal: Thunder Bluff"]={ class = "MAGE", level = 50, },
	["Arkane Brillanz"]={ class = "MAGE", level = 56, },
	["Manarubin herbeizaubern"]={ class = "MAGE", level = 58, },
	["Verwandlung: Kuh"]={ class = "MAGE", level = 60, },
	["Verwandlung"]={ class = "MAGE", level = 60, },
	["Verwandlung"]={ class = "MAGE", level = 60, },
--++ Mage Talents ++	
	["Kälteeinbruch"]={ class = "MAGE", level = 20, },
	["Pyroschlag"]={ class = "MAGE", level = 20, },
	["Druckwelle"]={ class = "MAGE", level = 30, },
	["Eisblock"]={ class = "MAGE", level = 30, },
	["Geistesgegenwart"]={ class = "MAGE", level = 30, },
	["Arkane Macht"]={ class = "MAGE", level = 40, },
	["Verbrennung"]={ class = "MAGE", level = 40, },
	["Eisbarriere"]={ class = "MAGE", level = 40, },
--++ Paladin Abilities ++	
	["Heiliges Licht"]={ class = "PALADIN", level = 1, },
	["Siegel der Rechtschaffenheit"]={ class = "PALADIN", level = 1, },
	["Richturteil"]={ class = "PALADIN", level = 4, },
	["Göttlicher Schutz"]={ class = "PALADIN", level = 6, },
	["Siegel des Kreuzfahrers"]={ class = "PALADIN", level = 6, },
	["Hammer der Gerechtigkeit"]={ class = "PALADIN", level = 8, },
	["Läutern"]={ class = "PALADIN", level = 8, },
	["Handauflegung"]={ class = "PALADIN", level = 10, },
	["Erlösung"]={ class = "PALADIN", level = 12, },
	["Zorn der Gerechtigkeit"]={ class = "PALADIN", level = 16, },
	["Exorzismus"]={ class = "PALADIN", level = 20, },
	["Lichtblitz"]={ class = "PALADIN", level = 20, },
	["Untote spüren"]={ class = "PALADIN", level = 20, },
	["Siegel der Gerechtigkeit"]={ class = "PALADIN", level = 22, },
	["Untote vertreiben"]={ class = "PALADIN", level = 24, },
	["Segen der Rettung"]={ class = "PALADIN", level = 26, },
	["Göttliches Eingreifen"]={ class = "PALADIN", level = 30, },
	["Siegel des Lichts"]={ class = "PALADIN", level = 30, },
	["Gottesschild"]={ class = "PALADIN", level = 34, },
	["Siegel der Weisheit"]={ class = "PALADIN", level = 38, },
	["Segen des Lichts"]={ class = "PALADIN", level = 40, },
	["Schlachtross beschwören"]={ class = "PALADIN", level = 40, },
	["Reinigung des Glaubens"]={ class = "PALADIN", level = 42, },
	["Hammer des Zorns"]={ class = "PALADIN", level = 44, },
	["Heiliger Zorn"]={ class = "PALADIN", level = 50, },
	["Streitross beschwören"]={ class = "PALADIN", level = 60, },
--++ Paladin Talents ++	
	["Weihe"]={ class = "PALADIN", level = 20, },
	["Siegel des Befehls"]={ class = "PALADIN", level = 20, },
	["Göttliche Gunst"]={ class = "PALADIN", level = 30, },
	["Heiliger Schild"]={ class = "PALADIN", level = 40, },
	["Heiliger Schock"]={ class = "PALADIN", level = 40, },
	["Buße"]={ class = "PALADIN", level = 40, },
--++ Priest Abilities ++	
	["Geringes Heilen"]={ class = "PRIEST", level = 1, },
	["Göttliche Pein"]={ class = "PRIEST", level = 1, },
	["Schattenwort: Schmerz"]={ class = "PRIEST", level = 4, },
	["Verblassen"]={ class = "PRIEST", level = 8, },
	["Verzweifeltes Gebet"]={ class = "PRIEST", level = 10, },
	["Verhexung der Schwäche"]={ class = "PRIEST", level = 10, },
	["Gedankenschlag"]={ class = "PRIEST", level = 10, },
	["Auferstehung"]={ class = "PRIEST", level = 10, },
	["Sternensplitter"]={ class = "PRIEST", level = 10, },
	["Berührung der Schwäche"]={ class = "PRIEST", level = 10, },
	["Inneres Feuer"]={ class = "PRIEST", level = 12, },
	["Psychischer Schrei"]={ class = "PRIEST", level = 14, },
	["Heilen"]={ class = "PRIEST", level = 16, },
	["Magiebannung"]={ class = "PRIEST", level = 18, },
	["Verschlingende Seuche"]={ class = "PRIEST", level = 20, },
	["Elunes Anmut"]={ class = "PRIEST", level = 20, },
	["Rückkopplung"]={ class = "PRIEST", level = 20, },
	["Blitzheilung"]={ class = "PRIEST", level = 20, },
	["Heiliges Feuer"]={ class = "PRIEST", level = 20, },
	["Gedankenbesänftigung"]={ class = "PRIEST", level = 20, },
	["Untote fesseln"]={ class = "PRIEST", level = 20, },
	["Schattenschild"]={ class = "PRIEST", level = 20, },
	["Gedankensicht"]={ class = "PRIEST", level = 22, },
	["Manabrand"]={ class = "PRIEST", level = 24, },
	["Gedankenkontrolle"]={ class = "PRIEST", level = 30, },
	["Gebet der Heilung"]={ class = "PRIEST", level = 30, },
	["Krankheit aufheben"]={ class = "PRIEST", level = 32, },
	["Levitieren"]={ class = "PRIEST", level = 34, },
	["Große Heilung"]={ class = "PRIEST", level = 40, },
--++ Priest Talents ++	
	["Heilige Nova"]={ class = "PRIEST", level = 20, },
	["Innerer Fokus"]={ class = "PRIEST", level = 20, },
	["Gedankenschinden"]={ class = "PRIEST", level = 20, },
	["Stille"]={ class = "PRIEST", level = 30, },
	["Brunnen des Lichts"]={ class = "PRIEST", level = 40, },
	["Schattengestalt"]={ class = "PRIEST", level = 40, },
--++ Rogue Abilities ++	
	["Ausweiden"]={ class = "ROGUE", level = 1, },
	["Schloss knacken"]={ class = "ROGUE", level = 1, },
	["Finsterer Stoß"]={ class = "ROGUE", level = 1, },
	["Verstohlenheit"]={ class = "ROGUE", level = 1, },
	["Meucheln"]={ class = "ROGUE", level = 4, },
	["Taschendiebstahl"]={ class = "ROGUE", level = 4, },
	["Solarplexus"]={ class = "ROGUE", level = 6, },
	["Entrinnen"]={ class = "ROGUE", level = 8, },
	["Kopfnuss"]={ class = "ROGUE", level = 10, },
	["Zerhäckseln"]={ class = "ROGUE", level = 10, },
	["Sprinten"]={ class = "ROGUE", level = 10, },
	["Tritt"]={ class = "ROGUE", level = 12, },
	["Rüstung schwächen"]={ class = "ROGUE", level = 14, },
	["Erdrosseln"]={ class = "ROGUE", level = 14, },
	["Finte"]={ class = "ROGUE", level = 16, },
	["Hinterhalt"]={ class = "ROGUE", level = 18, },
	["Gifte"]={ class = "ROGUE", level = 20, },
	["Blutung"]={ class = "ROGUE", level = 20, },
	["Verkrüppelndes Gift"]={ class = "ROGUE", level = 20, },
	["Sofort wirkendes Gift"]={ class = "ROGUE", level = 20, },
	["Ablenken"]={ class = "ROGUE", level = 22, },
	["Verschwinden"]={ class = "ROGUE", level = 22, },
	["Fallen entdecken"]={ class = "ROGUE", level = 24, },
	["Gedankenbenebelndes Gift"]={ class = "ROGUE", level = 24, },
	["Fieser Trick"]={ class = "ROGUE", level = 26, },
	["Falle entschärfen"]={ class = "ROGUE", level = 30, },
	["Nierenhieb"]={ class = "ROGUE", level = 30, },
	["Tödliches Gift"]={ class = "ROGUE", level = 30, },
	["Wundgift"]={ class = "ROGUE", level = 32, },
	["Blenden"]={ class = "ROGUE", level = 34, },
	["Blendungspulver"]={ class = "ROGUE", level = 34, },
	["Sicheres Fallen"]={ class = "ROGUE", level = 40, },
--++ Rogue Talents ++	
	["Geisterhafter Stoß"]={ class = "ROGUE", level = 20, },
	["Riposte"]={ class = "ROGUE", level = 20, },
	["Klingenwirbel"]={ class = "ROGUE", level = 30, },
	["Kaltblütigkeit"]={ class = "ROGUE", level = 30, },
	["Blutsturz"]={ class = "ROGUE", level = 30, },
	["Vorbereitung"]={ class = "ROGUE", level = 30, },
	["Adrenalinrausch"]={ class = "ROGUE", level = 40, },
	["Konzentration"]={ class = "ROGUE", level = 40, },
--++ Shaman Abilities ++	
	["Welle der Heilung"]={ class = "SHAMAN", level = 1, },
	["Blitzschlag"]={ class = "SHAMAN", level = 1, },
	["Waffe des Felsbeißers"]={ class = "SHAMAN", level = 1, },
	["Erdschock"]={ class = "SHAMAN", level = 4, },
	["Totem der Steinhaut"]={ class = "SHAMAN", level = 4, },
	["Totem der Erdbindung"]={ class = "SHAMAN", level = 6, },
	["Blitzschlagschild"]={ class = "SHAMAN", level = 8, },
	["Totem der Steinklaue"]={ class = "SHAMAN", level = 8, },
	["Flammenschock"]={ class = "SHAMAN", level = 10, },
	["Waffe der Flammenzunge"]={ class = "SHAMAN", level = 10, },
	["Totem der Verbrennung"]={ class = "SHAMAN", level = 10, },
	["Totem der Erdstärke"]={ class = "SHAMAN", level = 10, },
	["Geist der Ahnen"]={ class = "SHAMAN", level = 12, },
	["Totem der Feuernova"]={ class = "SHAMAN", level = 12, },
	["Reinigen"]={ class = "SHAMAN", level = 12, },
	["Totem des Erdstoßes"]={ class = "SHAMAN", level = 18, },
	["Frostschock"]={ class = "SHAMAN", level = 20, },
	["Waffe des Frostbrands"]={ class = "SHAMAN", level = 20, },
	["Geisterwolf"]={ class = "SHAMAN", level = 20, },
	["Totem des heilenden Flusses"]={ class = "SHAMAN", level = 20, },
	["Geringe Welle der Heilung"]={ class = "SHAMAN", level = 20, },
	["Totem der Giftreinigung"]={ class = "SHAMAN", level = 22, },
	["Totem des Frostwiderstands"]={ class = "SHAMAN", level = 24, },
	["Fernsicht"]={ class = "SHAMAN", level = 26, },
	["Totem der glühenden Magma"]={ class = "SHAMAN", level = 26, },
	["Totem der Manaquelle"]={ class = "SHAMAN", level = 26, },
	["Totem des Feuerwiderstands"]={ class = "SHAMAN", level = 28, },
	["Totem der Flammenzunge"]={ class = "SHAMAN", level = 28, },
	["Astraler Rückruf"]={ class = "SHAMAN", level = 30, },
	["Totem der Erdung"]={ class = "SHAMAN", level = 30, },
	["Totem des Naturwiderstands"]={ class = "SHAMAN", level = 30, },
	["Reinkarnation"]={ class = "SHAMAN", level = 30, },
	["Waffe des Windzorns"]={ class = "SHAMAN", level = 30, },
	["Kettenblitzschlag"]={ class = "SHAMAN", level = 32, },
	["Totem des Windzorns"]={ class = "SHAMAN", level = 32, },
	["Totem des Wachens"]={ class = "SHAMAN", level = 34, },
	["Totem der Windmauer"]={ class = "SHAMAN", level = 36, },
	["Totem der Krankheitsreinigung"]={ class = "SHAMAN", level = 38, },
	["Kettenheilung"]={ class = "SHAMAN", level = 40, },
	["Totem der luftgleichen Anmut"]={ class = "SHAMAN", level = 42, },
	["Totem der beruhigenden Winde"]={ class = "SHAMAN", level = 50, },
--++ Shaman Talents ++	
	["Parieren"]={ class = "SHAMAN", level = 30, },
	["Elementarbeherrschung"]={ class = "SHAMAN", level = 40, },
	["Totem der Manaflut"]={ class = "SHAMAN", level = 40, },
	["Sturmschlag"]={ class = "SHAMAN", level = 40, },
--++ Warlock Abilities ++	
	["Dämonenhaut"]={ class = "WARLOCK", level = 1, },
	["Feuerbrand"]={ class = "WARLOCK", level = 1, },
	["Schattenblitz"]={ class = "WARLOCK", level = 1, },
	["Wichtel beschwören"]={ class = "WARLOCK", level = 1, },
	["Verderbnis"]={ class = "WARLOCK", level = 4, },
	["Fluch der Schwäche"]={ class = "WARLOCK", level = 4, },
	["Aderlass"]={ class = "WARLOCK", level = 6, },
	["Fluch der Pein"]={ class = "WARLOCK", level = 8, },
	["Furcht"]={ class = "WARLOCK", level = 8, },
	["Gesundheitsstein herstellen (schwach)"]={ class = "WARLOCK", level = 10, },
	["Seelendieb"]={ class = "WARLOCK", level = 10, },
	["Leerwandler beschwören"]={ class = "WARLOCK", level = 10, },
	["Lebenslinie"]={ class = "WARLOCK", level = 12, },
	["Fluch der Tollkühnheit"]={ class = "WARLOCK", level = 14, },
	["Blutsauger"]={ class = "WARLOCK", level = 14, },
	["Unendlicher Atem"]={ class = "WARLOCK", level = 16, },
	["Sengender Schmerz"]={ class = "WARLOCK", level = 18, },
	["Seelenstein herstellen (schwach)"]={ class = "WARLOCK", level = 18, },
	["Dämonenrüstung"]={ class = "WARLOCK", level = 20, },
	["Feuerregen"]={ class = "WARLOCK", level = 20, },
	["Ritual der Beschwörung"]={ class = "WARLOCK", level = 20, },
	["Sukkubus beschwören"]={ class = "WARLOCK", level = 20, },
	["Gesundheitsstein herstellen (gering)"]={ class = "WARLOCK", level = 22, },
	["Auge von Kilrogg"]={ class = "WARLOCK", level = 22, },
	["Mana entziehen"]={ class = "WARLOCK", level = 24, },
	["Dämonen spüren"]={ class = "WARLOCK", level = 24, },
	["Fluch der Sprachen"]={ class = "WARLOCK", level = 26, },
	["Geringe Unsichtbarkeit entdecken"]={ class = "WARLOCK", level = 26, },
	["Verbannen"]={ class = "WARLOCK", level = 28, },
	["Feuerstein herstellen (gering)"]={ class = "WARLOCK", level = 28, },
	["Dämonensklave"]={ class = "WARLOCK", level = 30, },
	["Höllenfeuer"]={ class = "WARLOCK", level = 30, },
	["Teufelsjäger beschwören"]={ class = "WARLOCK", level = 30, },
	["Seelenstein herstellen (gering)"]={ class = "WARLOCK", level = 30, },
	["Fluch der Elemente"]={ class = "WARLOCK", level = 32, },
	["Schattenzauberschutz"]={ class = "WARLOCK", level = 32, },
	["Gesundheitsstein herstellen"]={ class = "WARLOCK", level = 34, },
	["Feuerstein herstellen"]={ class = "WARLOCK", level = 36, },
	["Zauberstein herstellen"]={ class = "WARLOCK", level = 36, },
	["Unsichtbarkeit entdecken"]={ class = "WARLOCK", level = 38, },
	["Schreckensgeheul"]={ class = "WARLOCK", level = 40, },
	["Teufelsross beschwören"]={ class = "WARLOCK", level = 40, },
	["Seelenstein herstellen"]={ class = "WARLOCK", level = 40, },
	["Todesmantel"]={ class = "WARLOCK", level = 42, },
	["Fluch der Schatten"]={ class = "WARLOCK", level = 44, },
	["Gesundheitsstein herstellen (groß)"]={ class = "WARLOCK", level = 46, },
	["Feuerstein herstellen (groß)"]={ class = "WARLOCK", level = 46, },
	["Seelenfeuer"]={ class = "WARLOCK", level = 48, },
	["Zauberstein herstellen (groß)"]={ class = "WARLOCK", level = 48, },
	["Große Unsichtbarkeit entdecken"]={ class = "WARLOCK", level = 50, },
	["Inferno"]={ class = "WARLOCK", level = 50, },
	["Seelenstein herstellen (groß)"]={ class = "WARLOCK", level = 50, },
	["Feuerstein herstellen (erheblich)"]={ class = "WARLOCK", level = 56, },
	["Gesundheitsstein herstellen (erheblich)"]={ class = "WARLOCK", level = 58, },
	["Fluch der Verdammnis"]={ class = "WARLOCK", level = 60, },
	["Ritual der Verdammnis"]={ class = "WARLOCK", level = 60, },
	["Schreckensross herbeirufen"]={ class = "WARLOCK", level = 60, },
	["Seelenstein herstellen (erheblich)"]={ class = "WARLOCK", level = 60, },
	["Zauberstein herstellen (erheblich)"]={ class = "WARLOCK", level = 60, },
--++ Warlock Talents ++	
	["Fluch verstärken"]={ class = "WARLOCK", level = 20, },
	["Teufelsbeherrschung"]={ class = "WARLOCK", level = 20, },
	["Schattenbrand"]={ class = "WARLOCK", level = 20, },
	["Fluch der Erschöpfung"]={ class = "WARLOCK", level = 30, },
	["Dämonische Opferung"]={ class = "WARLOCK", level = 30, },
	["Lebensentzug"]={ class = "WARLOCK", level = 30, },
	["Feuersbrunst"]={ class = "WARLOCK", level = 40, },
	["Dunkler Pakt"]={ class = "WARLOCK", level = 40, },
	["Seelenverbindung"]={ class = "WARLOCK", level = 40, },
--++ Warrior Abilities ++	
	["Kampfhaltung"]={ class = "WARRIOR", level = 1, },
	["Heldenhafter Stoß"]={ class = "WARRIOR", level = 1, },
	["Verbessertes Zuschlagen"]={ class = "WARRIOR", level = 1, },
	["Sturmangriff"]={ class = "WARRIOR", level = 4, },
	["Verwunden"]={ class = "WARRIOR", level = 4, },
	["Donnerknall"]={ class = "WARRIOR", level = 6, },
	["Kniesehne"]={ class = "WARRIOR", level = 8, },
	["Blutrausch"]={ class = "WARRIOR", level = 10, },
	["Verteidigungshaltung"]={ class = "WARRIOR", level = 10, },
	["Rüstung zerreißen"]={ class = "WARRIOR", level = 10, },
	["Spott"]={ class = "WARRIOR", level = 10, },
	["Überwältigen"]={ class = "WARRIOR", level = 12, },
	["Schildhieb"]={ class = "WARRIOR", level = 12, },
	["Demoralisierungsruf"]={ class = "WARRIOR", level = 14, },
	["Rache"]={ class = "WARRIOR", level = 14, },
	["Spöttischer Schlag"]={ class = "WARRIOR", level = 16, },
	["Schildblock"]={ class = "WARRIOR", level = 16, },
	["Entwaffnen"]={ class = "WARRIOR", level = 18, },
	["Spalten"]={ class = "WARRIOR", level = 20, },
	["Gegenschlag"]={ class = "WARRIOR", level = 20, },
	["Drohruf"]={ class = "WARRIOR", level = 22, },
	["Hinrichten"]={ class = "WARRIOR", level = 24, },
	["Herausforderungsruf"]={ class = "WARRIOR", level = 26, },
	["Schildwall"]={ class = "WARRIOR", level = 28, },
	["Berserkerhaltung"]={ class = "WARRIOR", level = 30, },
	["Abfangen"]={ class = "WARRIOR", level = 30, },
	["Zerschmettern"]={ class = "WARRIOR", level = 30, },
	["Berserkerwut"]={ class = "WARRIOR", level = 32, },
	["Wirbelwind"]={ class = "WARRIOR", level = 36, },
	["Zuschlagen"]={ class = "WARRIOR", level = 38, },
	["Tollkühnheit"]={ class = "WARRIOR", level = 50, },
--++ Warrior Talents ++	
	["Letztes Gefecht"]={ class = "WARRIOR", level = 20, },
	["Durchdringendes Heulen"]={ class = "WARRIOR", level = 20, },
	["Erschütternder Schlag"]={ class = "WARRIOR", level = 30, },
	["Todeswunsch"]={ class = "WARRIOR", level = 30, },
	["Weitreichende Stöße"]={ class = "WARRIOR", level = 30, },
	["Blutdurst"]={ class = "WARRIOR", level = 40, },
	["Tödlicher Stoß"]={ class = "WARRIOR", level = 40, },
	["Schildschlag"]={ class = "WARRIOR", level = 40, },
};

Spy_IgnoreList = {
	["Briefkasten"]=true, 
	["Schatztruhe"]=true,
	["Kleine Schatztruhe"]=true,
};