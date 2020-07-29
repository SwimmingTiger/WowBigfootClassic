local L = LibStub("AceLocale-3.0"):NewLocale("Spy", "frFR")
if not L then return end
-- TOC Note: "Détecte et vous avertit de la présence de joueurs ennemis à proximité."

-- Configuration
L["Spy"] = "Spy"
L["Version"] = "Version"
L["Spy Option"] = "Spy"
L["Profiles"] = "Profils"

-- About
L["About"] = "Info"
L["SpyDescription1"] = [[
SPY est un addon qui vous avertit de la présence de joueurs ennemis à proximité. Ce sont quelques-unes des principales caractéristiques.
]]
L["SpyDescription2"] = [[
|cffffd000Liste des ennemis à proximité|cffffffff
Affiche les joueurs ennemis qui ont été détectés à proximité. Les joueurs sont retirés de la liste s'ils n'ont pas été détectés après un certain temps.

|cffffd000Liste des dernières heures|cffffffff
Affiche tous les ennemis qui ont été détectés au cours de la dernière heure.

|cffffd000Liste des joueurs à ignorer|cffffffff
Les joueurs qui sont ajoutés à la liste d'ignorés ne seront pas signalés par Spy. Vous pouvez ajouter et supprimer des joueurs de cette liste en utilisant le menu déroulant du bouton ou en maintenant la touche Ctrl enfoncée tout en cliquant sur le bouton.

|cffffd000Liste des Tuer à vue|cffffffff
Les joueurs de votre liste \"Tuer à vue\" déclenchent une alarme lorsqu'ils sont détectés. Vous pouvez ajouter et supprimer des joueurs de cette liste en utilisant le menu déroulant du bouton ou en maintenant la touche Maj enfoncée tout en cliquant sur le bouton.

Le menu déroulant peut également être utilisé pour définir les raisons pour lesquelles vous avez ajouté quelqu'un à la liste "Tuer à vue". Si vous voulez entrer un raison spécifique qui n'est pas dans la liste, utilisez le bouton "Entrez votre propre raison ..." dans la liste "Autre".

|cffffd000Statistics Window|cffffffff
The Statistics Window contains a list of all enemy encounters which can be sorted by name, level, guild, wins, losses and the last time an enemy was detected. It also provides the ability to search for a specific enemy by name or guild and has filters to show only enemies that are marked as Kill on Sight, with a Win/Loss or entered Reasons. 

|cffffd000Kill On Sight Button|cffffffff
If enabled, this button will be located on the enemy players target frame. Clicking on this button will add/remove the enemy target to/from the Kill On Sight list. Right clicking on the button will allow you to enter Kill on Sight reasons.

|cffffd000Auteur: Slipjack|cffffffff
]]

-- General Settings
L["GeneralSettings"] = "Configuration générale"
L["GeneralSettingsDescription"] = [[
Options lorsque Spy est activé ou désactivé.
]] 
L["EnableSpy"] = "Activer Spy"
L["EnableSpyDescription"] = "Active ou désactive Spy."
L["EnabledInBattlegrounds"] = "Activer Spy en champs de bataille"
L["EnabledInBattlegroundsDescription"] = "Active ou désactive Spy lorsque vous êtes sur un champ de bataille."
L["EnabledInArenas"] = "Activer Spy en arènes"
L["EnabledInArenasDescription"] = "Active ou désactive Spy lorsque vous êtes dans une arène."
L["EnabledInWintergrasp"] = "Activer Spy en zone de combat mondiale"
L["EnabledInWintergraspDescription"] = "Active ou désactive Spy lorsque vous êtes dans des zones de combat mondial comme le Joug-d’Hiver en Northrend."
L["DisableWhenPVPUnflagged"] = "Désactiver Spy lorsque le mode JcJ est désactiver"
L["DisableWhenPVPUnflaggedDescription"] = "Active ou désactive Spy en fonction de votre statut JcJ."
L["DisabledInZones"] = "Désactivez Spy lorsque vous vous trouvez dans ces emplacements"
L["DisabledInZonesDescription"]	= "Sélectionnez les emplacements où Spy sera désactivé"
L["Booty Bay"] = "Baie-du-Butin"
L["Everlook"] = "Long-Guet"						
L["Gadgetzan"] = "Gadgetzan"
L["Ratchet"] = "Cabestan"
L["The Salty Sailor Tavern"] = "La taverne du Loup de mer"
L["Shattrath City"] = "Shattrath"
L["Area 52"] = "Zone 52"
L["Dalaran"] = "Dalaran"
L["Dalaran (Northrend)"] = "Dalaran (Norfendre)"
L["Bogpaddle"] = "Brasse-Tourbe"
L["The Vindicaar"] = "Le Vindicaar"
L["Krasus' Landing"] = "Aire de Krasus"
L["The Violet Gate"] = "La porte Pourpre"
L["Magni's Encampment"] = "Campement de Magni"
L["Silithus"] = "Silithus"
L["Chamber of Heart"] = "Chambre du Cœur"
L["Hall of Ancient Paths"] = "Hall des Voies antiques"
L["Sanctum of the Sages"] = "Sanctum des Sages"

-- Display
L["DisplayOptions"] = "Affichage"
L["DisplayOptionsDescription"] = [[
Options pour la fenêtre Spy et les infobulles.
]]
L["ShowOnDetection"] = "Afficher Spy lorsque des joueurs ennemis sont détectés"
L["ShowOnDetectionDescription"] = "Choisir cette option pour afficher la fenêtre SPY et la liste des ennemis proches si SPY est masqué lorsque des joueurs ennemis sont détectés."
L["HideSpy"] = "Cacher SPY quand aucun ennemi est détecté"
L["HideSpyDescription"] = "Choisir cette option pour masquer SPY lorsque la liste des ennemis proches s'affiche et qu'elle devient vide. SPY ne sera pas caché si vous effacez la liste manuellement."
L["ShowOnlyPvPFlagged"] = "Afficher uniquement les joueurs ennemis marqués pour le JcJ."
L["ShowOnlyPvPFlaggedDescription"] = "Choisir cette option pour n'afficher que les joueurs ennemis qui ont activé le mode JcJ dans la liste des joueurs à proximité."
L["ShowKoSButton"] = "Afficher le bouton TaV dans le cadre cible ennemi"
L["ShowKoSButtonDescription"] = "Choisir ce paramètre pour afficher le bouton TaV sur le cadre cible du joueur ennemi."
L["Alpha"] = "Transparence"
L["AlphaDescription"] = "Définissez la transparence de la fenêtre Spy."
L["AlphaBG"] = "Transparence sur les champs de bataille"
L["AlphaBGDescription"] = "Définissez la transparence de la fenêtre Spy sur les champs de bataille."
L["LockSpy"] = "Verrouillez la fenêtre SPY"
L["LockSpyDescription"] = "Verrouille la fenêtre Spy pour qu'elle ne bouge pas."
L["ClampToScreen"] = "Garder à l'écran"
L["ClampToScreenDescription"] = "Contrôle si la fenêtre Spy peut être déplacée hors écran."
L["InvertSpy"] = "Inverser la fenêtre Spy"
L["InvertSpyDescription"] = "Renverse la fenêtre Spy"
L["Reload"] = "Reload UI"
L["ReloadDescription"] = "Requis lors du changement de la fenêtre SPY."
L["ResizeSpy"] = "Redimensionner la fenêtre Spy automatiquement"
L["ResizeSpyDescription"] = "Choisir cette option pour redimensionner automatiquement la fenêtre Spy au fur et à mesure que les joueurs ennemis sont ajoutés et supprimés."
L["ResizeSpyLimit"] = "Limite de liste"
L["ResizeSpyLimitDescription"] = "Limite le nombre de joueurs ennemis affichés dans la fenêtre Spy."
L["DisplayTooltipNearSpyWindow"] = "Afficher la bulle d'aide près de la fenêtre Spy"
L["DisplayTooltipNearSpyWindowDescription"] = "Choisir cette option pour afficher des infobulles près de la fenêtre Spy."
L["SelectTooltipAnchor"] = "Point d'ancrage de l'infobulle"
L["SelectTooltipAnchorDescription"] = "Sélectionnez le point d'ancrage de l'infobulle si l'option ci-dessus a été cochée."
L["ANCHOR_CURSOR"] = "Curseur"
L["ANCHOR_TOP"] = "Haut"
L["ANCHOR_BOTTOM"] = "Sous"
L["ANCHOR_LEFT"] = "Gauche"			
L["ANCHOR_RIGHT"] = "Droite"
L["TooltipDisplayWinLoss"] = "Afficher les statistiques de Victoire/Défaite dans l'info-bulle"
L["TooltipDisplayWinLossDescription"] = "Choisir cette option pour afficher les statistiques des Victoire/Défaite d'un joueur dans la bulle d'aide du joueur."
L["TooltipDisplayKOSReason"] = "Afficher les raisons de \"tuer à vue\" dans l'info-bulle"
L["TooltipDisplayKOSReasonDescription"] = "Réglez-le pour afficher les raisons de tuer à vue d'un joueur dans l'info-bulle du joueur."
L["TooltipDisplayLastSeen"] = "Afficher le détail des derniers vus dans l'infobulle"
L["TooltipDisplayLastSeenDescription"] = "Choisir cette option pour afficher la dernière heure et la dernière position connues d'un joueur dans l'info-bulle du joueur."
L["DisplayListData"] = "Sélectionnez les données ennemies à afficher"
L["Name"] = "Nom"
L["Class"] = "Classe"
L["SelectFont"] = "Choisir une police"
L["SelectFontDescription"] = "Sélectionnez une police pour la fenêtre SPY."
L["RowHeight"] = "Sélectionner la hauteur de ligne"
L["RowHeightDescription"] = "Sélectionnez la hauteur de ligne pour la fenêtre Spy."
L["Texture"] = "Texture"
L["TextureDescription"] = "Sélectionner une texture pour la fenêtre d'espionnage"

-- Alerts
L["AlertOptions"] = "Alertes"
L["AlertOptionsDescription"] = [[
Options d'alertes, d'annonces et d'avertissements lorsque des joueurs ennemis sont détectés.
]]
L["SoundChannel"] = "Sélectionner le canal sonore"
L["Master"] = "Global"
L["SFX"] = "Effets"
L["Music"] = "Musique"
L["Ambience"] = "Ambiance"
L["Announce"] = "Envoyer les annonces à:"
L["None"] = "Aucun"
L["NoneDescription"] = "Ne pas annoncer lorsque des joueurs ennemis sont détectés."
L["Self"] = "Soi"
L["SelfDescription"] = "Annoncer à vous même lorsqu'un joueur ennemi est détecté."
L["Party"] = "Groupe"
L["PartyDescription"] = "Annoncez à votre groupe lorsque des joueurs ennemis sont détectés."
L["Guild"] = "Guilde"
L["GuildDescription"] = "Annoncez votre guilde lorsque des joueurs ennemis sont détectés."
L["Raid"] = "Raid"
L["RaidDescription"] = "Annoncez votre raid lorsque des joueurs ennemis sont détectés."
L["LocalDefense"] = "Défense locale"
L["LocalDefenseDescription"] = "Annoncer sur le canal de défense locale lorsqu'un joueur ennemi est détecté"
L["OnlyAnnounceKoS"] = "annoncer uniquement les ennemis figurant sur la liste des tuer à vue"
L["OnlyAnnounceKoSDescription"] = "Choisissez cette option pour annoncer uniquement les joueurs ennemis présents dans votre liste Tuer à vue."
L["WarnOnStealth"] = "Avertir si une furtivité est détectée"
L["WarnOnStealthDescription"] = "Choisissez cette option pour afficher un avertissement et déclencher une alerte lorsqu'un joueur ennemi active la furtivité."
L["WarnOnKOS"] = "Avertissement en cas de détection Tuer à vue"
L["WarnOnKOSDescription"] = "Choisissez cette option pour afficher un avertissement et déclencher une alerte lorsqu'un joueur ennemi de la même guilde qu'un ennemi dans votre liste de Tuer à vue est détecté."
L["WarnOnKOSGuild"] = "Avertissement en cas de détection d'une guilde Tuer à vue"
L["WarnOnKOSGuildDescription"] = "Choisissez cette option pour afficher un avertissement et déclencher une alerte lorsqu'un joueur ennemi de votre liste Tuer à vue est détecté."
L["WarnOnRace"] = "Avertissement en cas de détection de race"
L["WarnOnRaceDescription"] = "Choisir cette option pour déclencher une alerte lorsque la race sélectionnée est détectée."
L["SelectWarnRace"] = "Sélectionnez la race à détecter"
L["SelectWarnRaceDescription"] = "Sélectionnez une race pour l'alerte audio."
L["WarnRaceNote"] = "Note: Vous devez cibler un ennemi au moins une fois pour que sa race puisse être ajoutée à la base de données. Lors de la détection suivante, une alerte retentit. Cela ne fonctionne pas de la même façon que de détecter les ennemis proches au combat."
L["DisplayWarningsInErrorsFrame"] = "Afficher les avertissements dans le cadre d'erreurs"
L["DisplayWarningsInErrorsFrameDescription"] = "Choisir cette option pour utiliser le cadre d'erreurs afin d'afficher les avertissements au lieu d'utiliser les cadres contextuels graphiques."
L["DisplayWarnings"] = "Sélectionner l'emplacement du message d'avertissement"
L["Default"] = "défaut"
L["ErrorFrame"] = "Trame d'erreur"
L["Moveable"] = "mobile"
L["EnableSound"] = "Activer les alertes audio"
L["EnableSoundDescription"] = "Choisissez cette option pour activer les alertes audio lorsque des joueurs ennemis sont détectés. Différentes alertes sonneront si un joueur ennemi utilise la furtivité ou si un joueur ennemi est sur votre liste Tuer à vue."
L["OnlySoundKoS"] = "Seules les alertes sonores pour la détection tuer à vue"
L["OnlySoundKoSDescription"] = "Choisissez cette option pour entendre les alertes audio uniquement lorsque les joueurs de la liste Tuer à vue sont détectés."
L["StopAlertsOnTaxi"] = "Désactiver les alertes lors de l'utilisation d'une trajectoire de vol"
L["StopAlertsOnTaxiDescription"] = "Arrêtez tous les nouveaux avertissements et avertissements lorsque vous utilisez une trajectoire de vol."

-- Nearby List
L["ListOptions"] = "Liste à proximité"
L["ListOptionsDescription"] = [[
Options sur la façon dont les joueurs ennemis sont ajoutés et supprimés.
]]
L["RemoveUndetected"] = "Supprimez les joueurs ennemis de la liste des joueurs à proximité après:"
L["1Min"] = "1 minute"
L["1MinDescription"] = "Retirez un joueur ennemi qui n'a pas été détecté depuis plus d'une minute."
L["2Min"] = "2 minutes"
L["2MinDescription"] = "Retirez un joueur ennemi qui n'a pas été détecté depuis plus de 2 minutes."
L["5Min"] = "5 minutes"
L["5MinDescription"] = "Retirez un joueur ennemi qui n'a pas été détecté depuis plus de 5 minutes."
L["10Min"] = "10 minutes"
L["10MinDescription"] = "Retirez un joueur ennemi qui n'a pas été détecté depuis plus de 10 minutes."
L["15Min"] = "15 minutes"
L["15MinDescription"] = "Retirez un joueur ennemi qui n'a pas été détecté depuis plus de 15 minutes."
L["Never"] = "Ne jamais enlevé"
L["NeverDescription"] = "Ne jamais retirer les joueurs ennemis. La liste des ennemis proche peut être effacée manuellement."
L["ShowNearbyList"] = "Passez à la liste des ennemis proches lors de la détection d'un joueur ennemi"
L["ShowNearbyListDescription"] = "Choisir cette option pour afficher la liste Proche si elle n'est pas déjà visible lorsque des joueurs ennemis sont détectés."
L["PrioritiseKoS"] = "Prioriser les joueurs ennemis Tuer à vue dans la liste des joueurs à proximité"
L["PrioritiseKoSDescription"] = "Choisissez cette option pour toujours afficher les joueurs ennemis Tuer à vue en premier dans la liste des ennemis proches."

-- Map
L["MapOptions"] = "Carte"
L["MapOptionsDescription"] = [[
Options pour la carte du monde et la mini-carte, y compris les icônes et les info-bulles.
]]
L["MinimapDetection"] = "Activer la détection sur la minimap"
L["MinimapDetectionDescription"] = "Faire glisser le curseur sur les joueurs ennemis connus détectés sur la minimap les ajoutera à la liste des joueurs les plus proches."
L["MinimapNote"] = "          Note: Ne fonctionne que pour les joueurs qui peuvent traquer les humanoïdes."
L["MinimapDetails"] = "Affiché le niveau/class dans l’infobulle"
L["MinimapDetailsDescription"] = "Choisir cette option pour mettre à jour les infobulles de la carte de sorte que les détails de niveau/classe soient affichés à côté du nom des ennemis."
L["DisplayOnMap"] = "Afficher les icônes sur la carte"
L["DisplayOnMapDescription"] = "Affichez les icônes de la carte pour localiser les autres utilisateurs Spy de votre groupe / raid / guilde lorsqu'ils détectent des ennemis."
L["SwitchToZone"] = "Passer à la carte de zone actuelle lors de la détection d'un ennemi"
L["SwitchToZoneDescription"] = "Change l'affichage de la carte vers la zone actuelle lors de la détection d’ennemis."
L["MapDisplayLimit"] = "Limiter l'affichage des icônes de la carte à:"
L["LimitNone"] = "Partout"
L["LimitNoneDescription"] = "Affiche tous les ennemis détectés sur la carte, quel que soit votre emplacement actuel."
L["LimitSameZone"] = "Même zone"
L["LimitSameZoneDescription"] = "N'affiche que les ennemis détectés dans la carte si vous êtes dans la même zone."
L["LimitSameContinent"] = "Même continent"
L["LimitSameContinentDescription"] = "N'affiche que les ennemis détectés dans la carte si vous êtes sur le même continent."

-- Data Management
L["DataOptions"] = "Gestion des données"
L["DataOptionsDescription"] = [[
Options sur la façon dont Spy maintient et recueille les données.
]]
L["PurgeData"] = "Purger les données des joueurs ennemis non détectés après:"
L["OneDay"] = "1 jour"
L["OneDayDescription"] = "Purger les données des joueurs ennemis qui n'ont pas été détectés pendant 1 jour."
L["FiveDays"] = "5 jours"
L["FiveDaysDescription"] = "Purgez les données des joueurs ennemis qui n'ont pas été détectés depuis 5 jours.."
L["TenDays"] = "10 jours"
L["TenDaysDescription"] = "Purger les données des joueurs ennemis qui n'ont pas été détectés pendant 10 jours."
L["ThirtyDays"] = "30 jours"
L["ThirtyDaysDescription"] = "Purger les données des joueurs ennemis qui n'ont pas été détectés pendant 30 jours."
L["SixtyDays"] = "60 jours"
L["SixtyDaysDescription"] = "Purgez les données des joueurs ennemis qui n'ont pas été détectés depuis 60 jours."
L["NinetyDays"] = "90 jours"
L["NinetyDaysDescription"] = "Purgez les données des joueurs ennemis qui n'ont pas été détectés depuis 90 jours."
L["PurgeKoS"] = "Purger les joueurs de la Tuer à vue en fonction du temps de non détection."
L["PurgeKoSDescription"] = "Choisir cette option pour purger les joueurs Tuer à vue qui n'ont pas été détectés en fonction des paramètres de temps pour les joueurs non détectés."
L["PurgeWinLossData"] = "Purgez les données de Victoire/Défaite en fonction du temps non détection."
L["PurgeWinLossDataDescription"] = "Choisir cette option pour purger les données de Victoire/Défaite de vos rencontres ennemies en fonction des paramètres de temps pour les joueurs non détectés."
L["ShareData"] = "Partager des données avec d'autres utilisateurs de Spy"
L["ShareDataDescription"] = "Choisissez cette option pour partager les détails de vos rencontres avec des joueurs ennemis avec d'autres utilisateurs Spy de votre groupe, de votre raid et de votre guilde."
L["UseData"] = "Utiliser les données d'autres utilisateurs de Spy"
L["UseDataDescription"] = "Choisir cette option pour utiliser les données collectées par d'autres utilisateurs de Spy dans votre groupe, raid et guilde."
L["ShareKOSBetweenCharacters"] = "Partagez des joueurs Tuer à vue entre vos personnages"
L["ShareKOSBetweenCharactersDescription"] = "Choisir cette option pour partager les joueurs présent dans votre liste des Tuer à vue avec les autres personnages que vous jouez sur le même serveur et la même faction."

-- Commands
L["SlashCommand"] = "Commande Slash"
L["SpySlashDescription"] = "Ces boutons exécutent les mêmes fonctions que celles de la commande /spy"
L["Enable"] = "Activer"
L["EnableDescription"] = "Active Spy et affiche la fenêtre principale."
L["Show"] = "Afficher"
L["ShowDescription"] = "SAffichez la fenêtre Spy."
L["Hide"] = "Cacher"
L["HideDescription"] = "Masque la fenêtre principale."
L["Reset"] = "Réinitialiser"
L["ResetDescription"] = "Réinitialise la position et l'apparence de la fenêtre principale."
L["ClearSlash"] = "Effacer"
L["ClearSlashDescription"] = "Effacer la liste des joueurs qui ont été détecté"
L["Config"] = "Config"
L["ConfigDescription"] = "Ouvre la fenêtre de configuration de Spy"
L["KOS"] = "TAV"
L["KOSDescription"] = "Ajouter / retirer un joueur à / de la liste Tuer à vue"
L["InvalidInput"] = "Saisie invalide"
L["Ignore"] = "Ignore"
L["IgnoreDescription"] = "Ajouter/retirer un joueur à/de la liste ingnore."
L["Test"] = "Test"
L["TestDescription"] = "Affiche un avertissement afin que vous puissiez le repositionner."

-- Lists
L["Nearby"] = "Proche"
L["LastHour"] = "Dernière heure"
L["Ignore"] = "Ignorer"
L["KillOnSight"] = "Tuer à vue"

--Stats
L["Won"] = "Victoire"
L["Lost"] = "Défaite"
L["Time"] = "Temps"	
L["List"] = "Liste"
L["Filter"] = "filtre"
L["Show Only"] = "Afficher seulement"
L["KOS"] = "TAV"
L["Won/Lost"] = "Victoire/Défaite"
L["Reason"] = "Raison"	 
L["HonorKills"] = "l'honneur tue"
L["PvPDeaths"] = "Décès JcJ"

-- Output Messages
L["VersionCheck"] = "|cffc41e3aAttention! La mauvaise version de Spy est installée. Supprimez cette version et installez Spy Classic."
L["SpyEnabled"] = "|cff9933ffAddon SPY activé"
L["SpyDisabled"] = "|cff9933ffAddon SPY désactivé. Taper |cffffffff/spy show|cff9933ff pour l'activer"
L["UpgradeAvailable"] = "|cff9933ffUne nouvelle version de Spy est disponible. Elle peut être téléchargée à partir de:\n|cffffffffhttps://www.curseforge.com/wow/addons/spy-classic"
L["AlertStealthTitle"] = "Joueur furtif détecté!"
L["AlertKOSTitle"] = "Joueur Tuer à vue détecté!"
L["AlertKOSGuildTitle"] = "Guilde Tuer à vue détecté!"
L["AlertTitle_kosaway"] = "Joueur Tuer à vue détecté par "
L["AlertTitle_kosguildaway"] = "Guilde Tuer à vue détecté par: "
L["StealthWarning"] = "|cff9933ffJoueur furtif détecté: |cffffffff"
L["KOSWarning"] = "|cffff0000Guilde Tuer à vue détecté par: |cffffffff"
L["KOSGuildWarning"] = "|cffff0000Guilde Tuer à vue détecté: |cffffffff"
L["SpySignatureColored"] = "|cff9933ff[Spy] "
L["PlayerDetectedColored"] = "Joueur détecté: |cffffffff"
L["PlayersDetectedColored"] = "Joueurs détectés: |cffffffff"
L["KillOnSightDetectedColored"] = "Joueur Tuer à vue détecté: |cffffffff"
L["PlayerAddedToIgnoreColored"] = "Joueur ajouté à la liste Ignore: |cffffffff"
L["PlayerRemovedFromIgnoreColored"] = "Suppression du joueur de la liste Ignore: |cffffffff"
L["PlayerAddedToKOSColored"] = "Joueur ajouté à la liste Tuer à vue: |cffffffff"
L["PlayerRemovedFromKOSColored"] = "Suppression du joueur de la liste Tuer à vue: |cffffffff"
L["PlayerDetected"] = "[Spy] Joueur détecté: "
L["KillOnSightDetected"] = "[Spy] Joueur Tuer à vue détecté: "
L["Level"] = "Niveau"
L["LastSeen"] = "vue dernière fois il y a"
L["LessThanOneMinuteAgo"] = "il y a moins d'une minute"
L["MinutesAgo"] = "minutes"
L["HoursAgo"] = "heures"
L["DaysAgo"] = "jours"
L["Close"] = "Fermer"
L["CloseDescription"] = "|cffffffffMasque la fenêtre Espion, elle réapparaîtra lorsque le prochain joueur ennemi sera détecté."
L["Left/Right"] = "Gauche/Droite"
L["Left/RightDescription"] = "|cffffffffNavigue entre les listes A proximité, Dernière heure, Ignore et Tuer à vue"
L["Clear"] = "Effacer"
L["ClearDescription"] = "|cffffffffEfface la liste des joueurs qui ont été détectés. Control-Click activera ou désactivera Spy. Shift-Click activera ou désactivera tous les sons."
L["SoundEnabled"] = "Alertes audio activées"
L["SoundDisabled"] = "Alertes audio désactivées"
L["NearbyCount"] = "comte à proximité"
L["NearbyCountDescription"] = "|cffffffffNombre d’ennemis à proximité"
L["Statistics"] = "Statistiques"
L["StatsDescription"] = "|cffffffffAffiche une liste des joueurs ennemis rencontrés, les statistiques de Victoire/Défaite et l'endroit où ils ont été vus pour la dernière fois."
L["AddToIgnoreList"] = "Ajouter à votre liste ignore"
L["AddToKOSList"] = "Ajouter à la liste Tuer à vue"
L["RemoveFromIgnoreList"] = "Retirer de la liste Ignorer"
L["RemoveFromKOSList"] = "Retirer de la liste Tuer à vue"
L["RemoveFromStatsList"] = "Retirer de la liste des statistiques"   
L["AnnounceDropDownMenu"] = "Annoncer"
L["KOSReasonDropDownMenu"] = "Saisir une raison pour Tuer à vue"
L["PartyDropDownMenu"] = "Groupe"
L["RaidDropDownMenu"] = "Raid"
L["GuildDropDownMenu"] = "Guilde"
L["LocalDefenseDropDownMenu"] = "Défense locale"
L["Player"] = " (Joueur)"
L["KOSReason"] = "Tuer à Vue"
L["KOSReasonIndent"] = "    "
L["KOSReasonOther"] = "Saisir votre propre raison..."
L["KOSReasonClear"] = "Effacer la raison"
L["StatsWins"] = "|cff40ff00Victoires: "
L["StatsSeparator"] = "  "
L["StatsLoses"] = "|cff0070ddDéfaites: "
L["Located"] = "localisé:"
L["Yards"] = "mètres"
L["LocalDefenseChannelName"] = "Défenselocale"

Spy_KOSReasonListLength = 6
Spy_KOSReasonList = {
	[1] = {
		["title"] = "Commencé le combat";
		["content"] = {
			"M'a attaqué sans raison",
			"M'a attaqué au donneur de quête", 
			"M'a attaqué pendant que je combattais des PNJ",
			"M'a attaqué alors que j'étais proche d'une instance",
			"M'a attaqué alors que je suis AFK",
			"M'a attaqué pendant que j'étais monté",
			"M'a attaqué lorsque j'étais bas en vie/mana",
		};
	},
	[2] = {
		["title"] = "Style de combat";
		["content"] = {
			"Me tendre une embuscade",
			"M'attaque toujours à vue",
			"M'a tué avec un caractère de haut niveau",
			"Ganked moi avec un groupe d'ennemis",
			"N'attaquez pas sans renforts",
			"Appelle toujours à l'aide",
			"Utilise trop de contrôle (stun, fear ...)",
		};
	},
	[3] = {
		["title"] = "Camper";
		["content"] = {
			"Le joueur me campe",
			"campé mon autre caractère",
			"Caractère de niveau inférieur campés",
			"Camping furtif",
			"Membres de guilde campés",
			"Camping sur un PNJ/objectif",
			"Camping dans une ville/lieu",
		};
	},
	[4] = {
		["title"] = "Quête";
		["content"] = {
			"M'a attaqué alors que j'étais en quête",
			"M'a attaqué après l'avoir aidé pour une quête",
			"Interférer avec un objectif de quête",
			"Commencé une quête que je voulais faire",
			"Tué les PNJ de ma faction",
			"Tue les PNJ de quête",
		};
	},
	[5] = {
		["title"] = "A volé des ressources";
		["content"] = {
			"Rassemblé les herbes que je voulais",
			"Rassemblé le minéral que je voulais",
			"Rassemblé les ressources que je voulais",
			"Il m'a tué et m'a volé ma cible ou un PNJ rare",
			"A dépecé mes mobs",
			"A pris des articles de mes mobs",
			"Pêché dans ma piscine",
		};
	},
	[6] = {
		["title"] = "Autre";
		["content"] = {
			"Flaggé JcJ",
			"M'a poussé d'une falaise",
			"Utilise des objets d'ingénierie",
			"Parvient toujours à s'échapper",
			"Utilise des objets et des compétences pour s'échapper",
			"Exploite la mécanique du jeu",
			"Saisir votre propre raison...",
		};
	},
}

StaticPopupDialogs["Spy_SetKOSReasonOther"] = {
	preferredIndex=STATICPOPUPS_NUMDIALOGS,  -- http://forums.wowace.com/showthread.php?p=320956
	text = "Entrez une raison pour tuer à vue pour %s:",
	button1 = "Saisir",
	button2 = "Annuler",
	timeout = 120,
	hasEditBox = 1,
	editBoxWidth = 260,	
	whileDead = 1,
	hideOnEscape = 1,
	OnShow = function(self)
		self.editBox:SetText("");
	end,
    OnAccept = function(self)
		local reason = self.editBox:GetText()
		Spy:SetKOSReason(self.playerName, "Saisir votre propre raison...", reason)
	end,
};

-- Class descriptions
L["UNKNOWN"] = "Inconnu"
L["DRUID"] = "Druide"
L["HUNTER"] = "Chasseur"
L["MAGE"] = "Mage"
L["PALADIN"] = "Paladin"
L["PRIEST"] = "Prêtre"
L["ROGUE"] = "Voleur"
L["SHAMAN"] = "Chaman"
L["WARLOCK"] = "Démoniste"
L["WARRIOR"] = "Guerrier"
L["DEATHKNIGHt"] =" Chevalier de la mort "
L["MONK"] = "Moine"
L["DEMONHUNTER"] = "Chasseur de démons"

--++ Race descriptions
L["Human"] = "Humain"
L["Orc"] = "Orc"
L["Dwarf"] = "Nain"
L["Tauren"] = "Tauren"
L["Troll"] = "Troll"
L["Night Elf"] = "Elfe de la nuit"
L["Undead"] = "Mort-vivant"
L["Gnome"] = "Gnome"
L["Blood Elf"] = "Elfe de sang"
L["Draenei"] = "Draeneï"
L["Goblin"] = "Gobelin"
L["Worgen"] = "Worgen"
L["Pandaren"] = "Pandaren"
L["Highmountain Tauren"] = "Tauren de Haut-Roc"
L["Lightforged Draenei"] = "Draeneï sancteforge"
L["Nightborne"] = "Sacrenuit"
L["Void Elf"] = "Elfe du Vide"
L["Dark Iron Dwarf"] = "Nain sombrefer"
L["Mag'har Orc"] = "Orc mag’har"
L["Kul Tiran"] = "Kultirassien"
L["Zandalari Troll"] = "Troll zandalari"
L["Mechagnome"] = "Mécagnome"
L["Vulpera"] = "Vulpérin"
 
-- Capacités stealth
L["Stealth"] = "Camouflage"
L["Prowl"] = "Rôder"
 
--++ Minimap color codes
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
-- Allows an estimation of the race, class and level of a
-- player based on the abilities observed in the combat log.
-----------------------------------------------------------

--++ Racial Traits ++	
	["Camouflage dans l'ombre"]={ class = "Night Elf", level = 1, },
	["Fureur sanguinaire"]={ class = "Orc", level = 1, },
	["Volonté des Réprouvés"]={ class = "Undead", level = 1, },
	["Forme de pierre"]={ class = "Dwarf", level = 1, },
	["Berserker"]={ class = "Troll", level = 1, },
	["Solidité"]={ class = "Orc", level = 1, },
	["Spécialisation Epée"]={ class = "Human", level = 1, },
	["Maître de l'évasion"]={ class = "Gnome", level = 1, },
	["L'esprit humain"]={ class = "Human", level = 1, },
	["Régénération"]={ class = "Troll", level = 1, },
	["Perception"]={ class = "Human", level = 1, },
	["Endurance"]={ class = "Tauren", level = 1, },
	["Spécialisation Arc"]={ class = "Troll", level = 1, },
	["Culture"]={ class = "Tauren", level = 1, },
	["Spécialisation (Ingénierie)"]={ class = "Gnome", level = 1, },
	["Choc martial"]={ class = "Tauren", level = 1, },
	["Tueur de bêtes"]={ class = "Troll", level = 1, },
	["Découverte de trésors"]={ class = "Dwarf", level = 1, },
	["Spécialisation Hache"]={ class = "Orc", level = 1, },
	["Cannibalisme"]={ class = "Undead", level = 1, },
	["Diplomatie"]={ class = "Human", level = 1, },
	["Rapidité"]={ class = "Night Elf", level = 1, },
	["Spécialisation Armes de jet"]={ class = "Troll", level = 1, },
	["Spécialisation Masse"]={ class = "Human", level = 1, },
	["Spécialisation Armes à feu"]={ class = "Dwarf", level = 1, },
	["Respiration aquatique"]={ class = "Undead", level = 1, },
	["Commandement"]={ class = "Orc", level = 1, },
	["Résistance à la Nature"]={ class = "Night Elf", level = 1, },
	["Résistance au Givre"]={ class = "Dwarf", level = 1, },
	["Résistance à l'Ombre"]={ class = "Undead", level = 1, },
	["Résistance aux Arcanes"]={ class = "Gnome", level = 1, },
	["Esprit feu follet"]={ class = "Night Elf", level = 1, },
	
--++ Druid Abilities ++	
	["Toucher guérisseur"]={ class = "DRUID", level = 1, },
	["Colère"]={ class = "DRUID", level = 1, },
	["Eclat lunaire"]={ class = "DRUID", level = 4, },
	["Sarments"]={ class = "DRUID", level = 8, },
	["Forme d’ours"]={ class = "DRUID", level = 10, },
	["Rugissement démoralisant"]={ class = "DRUID", level = 10, },
	["Grondement"]={ class = "DRUID", level = 10, },
	["Mutiler"]={ class = "DRUID", level = 10, },
	["Téléportation : Reflet-de-Lune"]={ class = "DRUID", level = 10, },
	["Enrager"]={ class = "DRUID", level = 12, },
	["Rétablissement"]={ class = "DRUID", level = 12, },
	["Sonner"]={ class = "DRUID", level = 14, },
	["Forme aquatique"]={ class = "DRUID", level = 16, },
	["Balayage"]={ class = "DRUID", level = 16, },
	["Lucioles"]={ class = "DRUID", level = 18, },
	["Hibernation"]={ class = "DRUID", level = 18, },
	["Forme de félin"]={ class = "DRUID", level = 20, },
	["Griffe"]={ class = "DRUID", level = 20, },
	["Rôder"]={ class = "DRUID", level = 20, },
	["Renaissance"]={ class = "DRUID", level = 20, },
	["Déchirure"]={ class = "DRUID", level = 20, },
	["Feu stellaire"]={ class = "DRUID", level = 20, },
	["Lambeau"]={ class = "DRUID", level = 22, },
	["Apaiser les animaux"]={ class = "DRUID", level = 22, },
	["Griffure"]={ class = "DRUID", level = 24, },
	["Délivrance de la malédiction"]={ class = "DRUID", level = 24, },
	["Fureur du tigre"]={ class = "DRUID", level = 24, },
	["Abolir le poison"]={ class = "DRUID", level = 26, },
	["Célérité"]={ class = "DRUID", level = 26, },
	["Rugissement provocateur"]={ class = "DRUID", level = 28, },
	["Dérobade"]={ class = "DRUID", level = 28, },
	["Forme de voyage"]={ class = "DRUID", level = 30, },
	["Morsure féroce"]={ class = "DRUID", level = 32, },
	["Ravage"]={ class = "DRUID", level = 32, },
	["Régénération frénétique"]={ class = "DRUID", level = 36, },
	["Traquenard"]={ class = "DRUID", level = 36, },
	["Forme d’ours redoutable"]={ class = "DRUID", level = 40, },
--++ Druid Talents ++	
	["Emprise de la nature"]={ class = "DRUID", level = 10, },
	["Charge farouche"]={ class = "DRUID", level = 20, },
	["Essaim d'insectes"]={ class = "DRUID", level = 20, },
	["Augure de clarté"]={ class = "DRUID", level = 20, },
	["Lucioles (farouche)"]={ class = "DRUID", level = 30, },
--++ Hunter Abilities ++	
	["Promptitude"]={ class = "HUNTER", level = 1, },
	["Tir automatique"]={ class = "HUNTER", level = 1, },
	["Attaque du raptor"]={ class = "HUNTER", level = 1, },
	["Pistage des bêtes"]={ class = "HUNTER", level = 1, },
	["Aspect du singe"]={ class = "HUNTER", level = 4, },
	["Morsure de serpent"]={ class = "HUNTER", level = 4, },
	["Tir des arcanes"]={ class = "HUNTER", level = 6, },
	["Marque du chasseur"]={ class = "HUNTER", level = 6, },
	["Trait de choc"]={ class = "HUNTER", level = 8, },
	["Aspect du faucon"]={ class = "HUNTER", level = 10, },
	["Appel du familier"]={ class = "HUNTER", level = 10, },
	["Renvoyer le familier"]={ class = "HUNTER", level = 10, },
	["Nourrir le familier"]={ class = "HUNTER", level = 10, },
	["Ressusciter le familier"]={ class = "HUNTER", level = 10, },
	["Apprivoise une bête"]={ class = "HUNTER", level = 10, },
	["Trait provocateur"]={ class = "HUNTER", level = 12, },
	["Guérison du familier"]={ class = "HUNTER", level = 12, },
	["Coupure d'ailes"]={ class = "HUNTER", level = 12, },
	["Oeil d'aigle"]={ class = "HUNTER", level = 14, },
	["Oeil de la bête"]={ class = "HUNTER", level = 14, },
	["Effrayer une bête"]={ class = "HUNTER", level = 14, },
	["Piège d'Immolation"]={ class = "HUNTER", level = 16, },
	["Morsure de la mangouste"]={ class = "HUNTER", level = 16, },
	["Flèches multiples"]={ class = "HUNTER", level = 18, },
	["Pistage des morts-vivants"]={ class = "HUNTER", level = 18, },
	["Aspect du guépard"]={ class = "HUNTER", level = 20, },
	["Désengagement"]={ class = "HUNTER", level = 20, },
	["Piège givrant"]={ class = "HUNTER", level = 20, },
	["Piqûre de scorpide"]={ class = "HUNTER", level = 22, },
	["Connaissance des bêtes"]={ class = "HUNTER", level = 24, },
	["Pistage des camouflés"]={ class = "HUNTER", level = 24, },
	["Tir rapide"]={ class = "HUNTER", level = 26, },
	["Pistage des élémentaires"]={ class = "HUNTER", level = 26, },
	["Piège de givre"]={ class = "HUNTER", level = 28, },
	["Aspect de la bête"]={ class = "HUNTER", level = 30, },
	["Feindre la mort"]={ class = "HUNTER", level = 30, },
	["Fusée éclairante"]={ class = "HUNTER", level = 32, },
	["Pistage des démons"]={ class = "HUNTER", level = 32, },
	["Piège explosif"]={ class = "HUNTER", level = 34, },
	["Morsure de vipère"]={ class = "HUNTER", level = 36, },
	["Aspect de la meute"]={ class = "HUNTER", level = 40, },
	["Pistage des géants"]={ class = "HUNTER", level = 40, },
	["Salve"]={ class = "HUNTER", level = 40, },
	["Aspect de la nature"]={ class = "HUNTER", level = 46, },
	["Pistage des draconiens"]={ class = "HUNTER", level = 50, },
	["Tir tranquillisant"]={ class = "HUNTER", level = 60, },
--++ Hunter Talents ++	
	["Visée"]={ class = "HUNTER", level = 20, },
	["Dissuasion"]={ class = "HUNTER", level = 20, },
	["Contre-attaque"]={ class = "HUNTER", level = 30, },
	["Intimidation"]={ class = "HUNTER", level = 30, },
	["Flèche de dispersion"]={ class = "HUNTER", level = 30, },
	["Courroux bestial"]={ class = "HUNTER", level = 40, },
	["Piqûre de wyverne"]={ class = "HUNTER", level = 40, },
--++ Mage Abilities ++	
	["Boule de feu"]={ class = "MAGE", level = 1, },
	["Armure de givre"]={ class = "MAGE", level = 1, },
	["Eclair de givre"]={ class = "MAGE", level = 4, },
	["Invocation d'eau"]={ class = "MAGE", level = 4, },
	["Trait de feu"]={ class = "MAGE", level = 6, },
	["Invocation de nourriture"]={ class = "MAGE", level = 6, },
	["Projectiles des arcanes"]={ class = "MAGE", level = 8, },
	["Métamorphose"]={ class = "MAGE", level = 8, },
	["Nova de givre"]={ class = "MAGE", level = 10, },
	["Explosion des arcanes"]={ class = "MAGE", level = 14, },
	["Détection de la magie"]={ class = "MAGE", level = 16, },
	["Choc de flammes"]={ class = "MAGE", level = 16, },
	["Délivrance de la malédiction mineure"]={ class = "MAGE", level = 18, },
	["Transfert"]={ class = "MAGE", level = 20, },
	["Blizzard"]={ class = "MAGE", level = 20, },
	["Evocation"]={ class = "MAGE", level = 20, },
	["Gardien de feu"]={ class = "MAGE", level = 20, },
	["Bouclier de mana"]={ class = "MAGE", level = 20, },
	["Téléportation : Ironforge"]={ class = "MAGE", level = 20, },
	["Téléportation : Orgrimmar"]={ class = "MAGE", level = 20, },
	["Téléportation : Stormwind"]={ class = "MAGE", level = 20, },
	["Téléportation : Undercity"]={ class = "MAGE", level = 20, },
	["Gardien de givre"]={ class = "MAGE", level = 22, },
	["Brûlure"]={ class = "MAGE", level = 22, },
	["Contresort"]={ class = "MAGE", level = 24, },
	["Cône de froid"]={ class = "MAGE", level = 26, },
	["Invocation d'une agate de mana"]={ class = "MAGE", level = 28, },
	["Armure de glace"]={ class = "MAGE", level = 30, },
	["Téléportation : Darnassus"]={ class = "MAGE", level = 30, },
	["Téléportation : Thunder Bluff"]={ class = "MAGE", level = 30, },
	["Armure du mage"]={ class = "MAGE", level = 34, },
	["Invocation d'une jade de mana"]={ class = "MAGE", level = 38, },
	["Portail : Ironforge"]={ class = "MAGE", level = 40, },
	["Portail : Orgrimmar"]={ class = "MAGE", level = 40, },
	["Portail : Stormwind"]={ class = "MAGE", level = 40, },
	["Portail : Undercity"]={ class = "MAGE", level = 40, },
	["Invocation d'une citrine de mana"]={ class = "MAGE", level = 48, },
	["Portail : Darnassus"]={ class = "MAGE", level = 50, },
	["Portail : Thunder Bluff"]={ class = "MAGE", level = 50, },
	["Illumination des arcanes"]={ class = "MAGE", level = 56, },
	["Invocation d'un rubis de mana"]={ class = "MAGE", level = 58, },
	["Métamorphose : vache"]={ class = "MAGE", level = 60, },
	["Métamorphose"]={ class = "MAGE", level = 60, },
	["Métamorphose"]={ class = "MAGE", level = 60, },
--++ Mage Talents ++	
	["Morsure de glace"]={ class = "MAGE", level = 20, },
	["Explosion pyrotechnique"]={ class = "MAGE", level = 20, },
	["Vague explosive"]={ class = "MAGE", level = 30, },
	["Bloc de glace"]={ class = "MAGE", level = 30, },
	["Présence spirituelle"]={ class = "MAGE", level = 30, },
	["Pouvoir des arcanes"]={ class = "MAGE", level = 40, },
	["Combustion"]={ class = "MAGE", level = 40, },
	["Barrière de glace"]={ class = "MAGE", level = 40, },
--++ Paladin Abilities ++	
	["Lumière sacrée"]={ class = "PALADIN", level = 1, },
	["Sceau de piété"]={ class = "PALADIN", level = 1, },
	["Jugement"]={ class = "PALADIN", level = 4, },
	["Protection divine"]={ class = "PALADIN", level = 6, },
	["Sceau du Croisé"]={ class = "PALADIN", level = 6, },
	["Marteau de la justice"]={ class = "PALADIN", level = 8, },
	["Purification"]={ class = "PALADIN", level = 8, },
	["Imposition des mains"]={ class = "PALADIN", level = 10, },
	["Rédemption"]={ class = "PALADIN", level = 12, },
	["Fureur vertueuse"]={ class = "PALADIN", level = 16, },
	["Exorcisme"]={ class = "PALADIN", level = 20, },
	["Eclair lumineux"]={ class = "PALADIN", level = 20, },
	["Détection des morts-vivants"]={ class = "PALADIN", level = 20, },
	["Sceau de justice"]={ class = "PALADIN", level = 22, },
	["Renvoi des morts-vivants"]={ class = "PALADIN", level = 24, },
	["Bénédiction de salut"]={ class = "PALADIN", level = 26, },
	["Intervention divine"]={ class = "PALADIN", level = 30, },
	["Sceau de lumière"]={ class = "PALADIN", level = 30, },
	["Bouclier divin"]={ class = "PALADIN", level = 34, },
	["Sceau de sagesse"]={ class = "PALADIN", level = 38, },
	["Bénédiction de lumière"]={ class = "PALADIN", level = 40, },
	["Invocation d'un cheval de guerre"]={ class = "PALADIN", level = 40, },
	["Epuration"]={ class = "PALADIN", level = 42, },
	["Marteau de courroux"]={ class = "PALADIN", level = 44, },
	["Colère divine"]={ class = "PALADIN", level = 50, },
	["Invocation de destrier"]={ class = "PALADIN", level = 60, },
--++ Paladin Talents ++	
	["Consécration"]={ class = "PALADIN", level = 20, },
	["Sceau d'autorité"]={ class = "PALADIN", level = 20, },
	["Faveur divine"]={ class = "PALADIN", level = 30, },
	["Bouclier sacré"]={ class = "PALADIN", level = 40, },
	["Horion sacré"]={ class = "PALADIN", level = 40, },
	["Repentir"]={ class = "PALADIN", level = 40, },
--++ Priest Abilities ++	
	["Soins inférieurs"]={ class = "PRIEST", level = 1, },
	["Châtiment"]={ class = "PRIEST", level = 1, },
	["Mot de l'ombre : Douleur"]={ class = "PRIEST", level = 4, },
	["Oubli"]={ class = "PRIEST", level = 8, },
	["Prière du désespoir"]={ class = "PRIEST", level = 10, },
	["Maléfice de faiblesse"]={ class = "PRIEST", level = 10, },
	["Attaque mentale"]={ class = "PRIEST", level = 10, },
	["Résurrection"]={ class = "PRIEST", level = 10, },
	["Eclats stellaires"]={ class = "PRIEST", level = 10, },
	["Toucher de faiblesse"]={ class = "PRIEST", level = 10, },
	["Feu intérieur"]={ class = "PRIEST", level = 12, },
	["Cri psychique"]={ class = "PRIEST", level = 14, },
	["Soins"]={ class = "PRIEST", level = 16, },
	["Dissipation de la magie"]={ class = "PRIEST", level = 18, },
	["Peste dévorante"]={ class = "PRIEST", level = 20, },
	["Grâce d'Elune"]={ class = "PRIEST", level = 20, },
	["Réaction"]={ class = "PRIEST", level = 20, },
	["Soins rapides"]={ class = "PRIEST", level = 20, },
	["Flammes sacrées"]={ class = "PRIEST", level = 20, },
	["Apaisement"]={ class = "PRIEST", level = 20, },
	["Entraves des morts-vivants"]={ class = "PRIEST", level = 20, },
	["Garde de l'ombre"]={ class = "PRIEST", level = 20, },
	["Vision télépathique"]={ class = "PRIEST", level = 22, },
	["Brûlure de mana"]={ class = "PRIEST", level = 24, },
	["Contrôle mental"]={ class = "PRIEST", level = 30, },
	["Prière de soins"]={ class = "PRIEST", level = 30, },
	["Abolir maladie"]={ class = "PRIEST", level = 32, },
	["Lévitation"]={ class = "PRIEST", level = 34, },
	["Soins supérieurs"]={ class = "PRIEST", level = 40, },
--++ Priest Talents ++	
	["Nova sacrée"]={ class = "PRIEST", level = 20, },
	["Focalisation améliorée"]={ class = "PRIEST", level = 20, },
	["Fouet mental"]={ class = "PRIEST", level = 20, },
	["Silence"]={ class = "PRIEST", level = 30, },
	["Puits de lumière"]={ class = "PRIEST", level = 40, },
	["Forme d'Ombre"]={ class = "PRIEST", level = 40, },
--++ Rogue Abilities ++	
	["Eviscération"]={ class = "ROGUE", level = 1, },
	["Crochetage"]={ class = "ROGUE", level = 1, },
	["Attaque pernicieuse"]={ class = "ROGUE", level = 1, },
	["Camouflage"]={ class = "ROGUE", level = 1, },
	["Attaque sournoise"]={ class = "ROGUE", level = 4, },
	["Vol à la tire"]={ class = "ROGUE", level = 4, },
	["Suriner"]={ class = "ROGUE", level = 6, },
	["Evasion"]={ class = "ROGUE", level = 8, },
	["Assommer"]={ class = "ROGUE", level = 10, },
	["Débiter"]={ class = "ROGUE", level = 10, },
	["Sprint"]={ class = "ROGUE", level = 10, },
	["Coup de pied"]={ class = "ROGUE", level = 12, },
	["Exposer l'armure"]={ class = "ROGUE", level = 14, },
	["Garrot"]={ class = "ROGUE", level = 14, },
	["Feinte"]={ class = "ROGUE", level = 16, },
	["Embuscade"]={ class = "ROGUE", level = 18, },
	["Poisons"]={ class = "ROGUE", level = 20, },
	["Rupture"]={ class = "ROGUE", level = 20, },
	["Poison affaiblissant"]={ class = "ROGUE", level = 20, },
	["Poison instantané"]={ class = "ROGUE", level = 20, },
	["Distraction"]={ class = "ROGUE", level = 22, },
	["Disparition"]={ class = "ROGUE", level = 22, },
	["Détection des pièges"]={ class = "ROGUE", level = 24, },
	["Poison de distraction mentale"]={ class = "ROGUE", level = 24, },
	["Coup bas"]={ class = "ROGUE", level = 26, },
	["Désarmement de piège"]={ class = "ROGUE", level = 30, },
	["Aiguillon perfide"]={ class = "ROGUE", level = 30, },
	["Poison mortel"]={ class = "ROGUE", level = 30, },
	["Poison douloureux"]={ class = "ROGUE", level = 32, },
	["Cécité"]={ class = "ROGUE", level = 34, },
	["Poudre aveuglante"]={ class = "ROGUE", level = 34, },
	["Chute amortie"]={ class = "ROGUE", level = 40, },
--++ Rogue Talents ++	
	["Frappe fantomatique"]={ class = "ROGUE", level = 20, },
	["Riposte"]={ class = "ROGUE", level = 20, },
	["Déluge de lames"]={ class = "ROGUE", level = 30, },
	["Sang froid"]={ class = "ROGUE", level = 30, },
	["Hémorragie"]={ class = "ROGUE", level = 30, },
	["Préparation"]={ class = "ROGUE", level = 30, },
	["Poussée d'adrénaline"]={ class = "ROGUE", level = 40, },
	["Préméditation"]={ class = "ROGUE", level = 40, },
--++ Shaman Abilities ++	
	["Vague de soins"]={ class = "SHAMAN", level = 1, },
	["Eclair"]={ class = "SHAMAN", level = 1, },
	["Arme Croque-roc"]={ class = "SHAMAN", level = 1, },
	["Horion de terre"]={ class = "SHAMAN", level = 4, },
	["Totem de Peau de pierre"]={ class = "SHAMAN", level = 4, },
	["Totem de lien terrestre"]={ class = "SHAMAN", level = 6, },
	["Bouclier de foudre"]={ class = "SHAMAN", level = 8, },
	["Totem de Griffes de pierre"]={ class = "SHAMAN", level = 8, },
	["Horion de flammes"]={ class = "SHAMAN", level = 10, },
	["Arme Langue de feu"]={ class = "SHAMAN", level = 10, },
	["Totem incendiaire"]={ class = "SHAMAN", level = 10, },
	["Totem de Force de la Terre"]={ class = "SHAMAN", level = 10, },
	["Esprit ancestral"]={ class = "SHAMAN", level = 12, },
	["Totem Nova de feu"]={ class = "SHAMAN", level = 12, },
	["Expiation"]={ class = "SHAMAN", level = 12, },
	["Totem de Séisme"]={ class = "SHAMAN", level = 18, },
	["Horion de givre"]={ class = "SHAMAN", level = 20, },
	["Arme de givre"]={ class = "SHAMAN", level = 20, },
	["Loup fantôme"]={ class = "SHAMAN", level = 20, },
	["Totem guérisseur"]={ class = "SHAMAN", level = 20, },
	["Vague de soins inférieurs"]={ class = "SHAMAN", level = 20, },
	["Totem de Purification du poison"]={ class = "SHAMAN", level = 22, },
	["Totem de résistance au Givre"]={ class = "SHAMAN", level = 24, },
	["Double vue"]={ class = "SHAMAN", level = 26, },
	["Totem de Magma"]={ class = "SHAMAN", level = 26, },
	["Totem Fontaine de mana"]={ class = "SHAMAN", level = 26, },
	["Totem de résistance au Feu"]={ class = "SHAMAN", level = 28, },
	["Totem Langue de feu"]={ class = "SHAMAN", level = 28, },
	["Rappel astral"]={ class = "SHAMAN", level = 30, },
	["Totem de Glèbe"]={ class = "SHAMAN", level = 30, },
	["Totem de résistance à la Nature"]={ class = "SHAMAN", level = 30, },
	["Réincarnation"]={ class = "SHAMAN", level = 30, },
	["Arme Furie-des-vents"]={ class = "SHAMAN", level = 30, },
	["Chaîne d'éclairs"]={ class = "SHAMAN", level = 32, },
	["Totem Furie-des-vents"]={ class = "SHAMAN", level = 32, },
	["Totem Sentinelle"]={ class = "SHAMAN", level = 34, },
	["Totem de Mur des vents"]={ class = "SHAMAN", level = 36, },
	["Totem de Purification des maladies"]={ class = "SHAMAN", level = 38, },
	["Salve de guérison"]={ class = "SHAMAN", level = 40, },
	["Totem de Grâce aérienne"]={ class = "SHAMAN", level = 42, },
	["Totem de Tranquillité de l'air"]={ class = "SHAMAN", level = 50, },
--++ Shaman Talents ++	
	["Parade"]={ class = "SHAMAN", level = 30, },
	["Maîtrise élémentaire"]={ class = "SHAMAN", level = 40, },
	["Totem de Vague de mana"]={ class = "SHAMAN", level = 40, },
	["Courroux naturel"]={ class = "SHAMAN", level = 40, },
--++ Warlock Abilities ++	
	["Peau de démon"]={ class = "WARLOCK", level = 1, },
	["Immolation"]={ class = "WARLOCK", level = 1, },
	["Trait de l'ombre"]={ class = "WARLOCK", level = 1, },
	["Invocation d'un diablotin"]={ class = "WARLOCK", level = 1, },
	["Corruption"]={ class = "WARLOCK", level = 4, },
	["Malédiction de faiblesse"]={ class = "WARLOCK", level = 4, },
	["Connexion"]={ class = "WARLOCK", level = 6, },
	["Malédiction d'agonie"]={ class = "WARLOCK", level = 8, },
	["Peur"]={ class = "WARLOCK", level = 8, },
	["Création de Pierre de soins (mineure)"]={ class = "WARLOCK", level = 10, },
	["Siphon d'âme"]={ class = "WARLOCK", level = 10, },
	["Invocation d'un marcheur du Vide"]={ class = "WARLOCK", level = 10, },
	["Captation de vie"]={ class = "WARLOCK", level = 12, },
	["Malédiction de témérité"]={ class = "WARLOCK", level = 14, },
	["Drain de vie"]={ class = "WARLOCK", level = 14, },
	["Respiration interminable"]={ class = "WARLOCK", level = 16, },
	["Douleur brûlante"]={ class = "WARLOCK", level = 18, },
	["Création de Pierre d'âme (mineure)"]={ class = "WARLOCK", level = 18, },
	["Armure démoniaque"]={ class = "WARLOCK", level = 20, },
	["Pluie de feu"]={ class = "WARLOCK", level = 20, },
	["Rituel d'invocation"]={ class = "WARLOCK", level = 20, },
	["Invocation d'une succube"]={ class = "WARLOCK", level = 20, },
	["Création de Pierre de soins (inférieure)"]={ class = "WARLOCK", level = 22, },
	["Oeil de Kilrogg"]={ class = "WARLOCK", level = 22, },
	["Drain de mana"]={ class = "WARLOCK", level = 24, },
	["Détection des démons"]={ class = "WARLOCK", level = 24, },
	["Malédiction des langages"]={ class = "WARLOCK", level = 26, },
	["Détection de l'invisibilité inférieure"]={ class = "WARLOCK", level = 26, },
	["Bannir"]={ class = "WARLOCK", level = 28, },
	["Création de Pierre de feu (inférieure)"]={ class = "WARLOCK", level = 28, },
	["Asservir démon"]={ class = "WARLOCK", level = 30, },
	["Flammes infernales"]={ class = "WARLOCK", level = 30, },
	["Invocation d'un chasseur corrompu"]={ class = "WARLOCK", level = 30, },
	["Création de Pierre d'âme (inférieure)"]={ class = "WARLOCK", level = 30, },
	["Malédiction des éléments"]={ class = "WARLOCK", level = 32, },
	["Gardien de l'ombre"]={ class = "WARLOCK", level = 32, },
	["Création de Pierre de soins"]={ class = "WARLOCK", level = 34, },
	["Création de Pierre de feu"]={ class = "WARLOCK", level = 36, },
	["Création de Pierre de sort"]={ class = "WARLOCK", level = 36, },
	["Détection de l'invisibilité"]={ class = "WARLOCK", level = 38, },
	["Hurlement de terreur"]={ class = "WARLOCK", level = 40, },
	["Invocation d'un palefroi corrompu"]={ class = "WARLOCK", level = 40, },
	["Création de Pierre d'âme"]={ class = "WARLOCK", level = 40, },
	["Voile mortel"]={ class = "WARLOCK", level = 42, },
	["Malédiction de l'ombre"]={ class = "WARLOCK", level = 44, },
	["Création de Pierre de soins (supérieure)"]={ class = "WARLOCK", level = 46, },
	["Création de Pierre de feu (supérieure)"]={ class = "WARLOCK", level = 46, },
	["Feu de l'âme"]={ class = "WARLOCK", level = 48, },
	["Création de Pierre de sort (supérieure)"]={ class = "WARLOCK", level = 48, },
	["Détection de l'invisibilité supérieure"]={ class = "WARLOCK", level = 50, },
	["Inferno"]={ class = "WARLOCK", level = 50, },
	["Création de Pierre d'âme (supérieure)"]={ class = "WARLOCK", level = 50, },
	["Création de Pierre de feu (majeure)"]={ class = "WARLOCK", level = 56, },
	["Création de Pierre de soins (majeure)"]={ class = "WARLOCK", level = 58, },
	["Malédiction funeste"]={ class = "WARLOCK", level = 60, },
	["Rituel de malédiction"]={ class = "WARLOCK", level = 60, },
	["Invocation d'un destrier de l'effroi"]={ class = "WARLOCK", level = 60, },
	["Création de Pierre d'âme (majeure)"]={ class = "WARLOCK", level = 60, },
	["Création de Pierre de sort (majeure)"]={ class = "WARLOCK", level = 60, },
--++ Warlock Talents ++	
	["Malédiction amplifiée"]={ class = "WARLOCK", level = 20, },
	["Domination corrompue"]={ class = "WARLOCK", level = 20, },
	["Brûlure de l'ombre"]={ class = "WARLOCK", level = 20, },
	["Malédiction de fatigue"]={ class = "WARLOCK", level = 30, },
	["Sacrifice démoniaque"]={ class = "WARLOCK", level = 30, },
	["Siphon de vie"]={ class = "WARLOCK", level = 30, },
	["Conflagration"]={ class = "WARLOCK", level = 40, },
	["Pacte noir"]={ class = "WARLOCK", level = 40, },
	["Lien spirituel"]={ class = "WARLOCK", level = 40, },
--++ Warrior Abilities ++	
	["Posture de combat"]={ class = "WARRIOR", level = 1, },
	["Frappe héroïque"]={ class = "WARRIOR", level = 1, },
	["Volée de coups améliorée"]={ class = "WARRIOR", level = 1, },
	["Charge"]={ class = "WARRIOR", level = 4, },
	["Pourfendre"]={ class = "WARRIOR", level = 4, },
	["Coup de tonnerre"]={ class = "WARRIOR", level = 6, },
	["Brise-genou"]={ class = "WARRIOR", level = 8, },
	["Rage sanguinaire"]={ class = "WARRIOR", level = 10, },
	["Posture défensive"]={ class = "WARRIOR", level = 10, },
	["Fracasser armure"]={ class = "WARRIOR", level = 10, },
	["Provocation"]={ class = "WARRIOR", level = 10, },
	["Fulgurance"]={ class = "WARRIOR", level = 12, },
	["Coup de bouclier"]={ class = "WARRIOR", level = 12, },
	["Cri démoralisant"]={ class = "WARRIOR", level = 14, },
	["Vengeance"]={ class = "WARRIOR", level = 14, },
	["Coup railleur"]={ class = "WARRIOR", level = 16, },
	["Maîtrise du blocage"]={ class = "WARRIOR", level = 16, },
	["Désarmement"]={ class = "WARRIOR", level = 18, },
	["Enchaînement"]={ class = "WARRIOR", level = 20, },
	["Représailles"]={ class = "WARRIOR", level = 20, },
	["Cri d’intimidation"]={ class = "WARRIOR", level = 22, },
	["Exécution"]={ class = "WARRIOR", level = 24, },
	["Cri de défi"]={ class = "WARRIOR", level = 26, },
	["Mur protecteur"]={ class = "WARRIOR", level = 28, },
	["Posture berserker"]={ class = "WARRIOR", level = 30, },
	["Interception"]={ class = "WARRIOR", level = 30, },
	["Heurtoir"]={ class = "WARRIOR", level = 30, },
	["Rage berserker"]={ class = "WARRIOR", level = 32, },
	["Tourbillon"]={ class = "WARRIOR", level = 36, },
	["Volée de coups"]={ class = "WARRIOR", level = 38, },
	["Témérité"]={ class = "WARRIOR", level = 50, },
--++ Warrior Talents ++	
	["Dernier rempart"]={ class = "WARRIOR", level = 20, },
	["Hurlement perçant"]={ class = "WARRIOR", level = 20, },
	["Bourrasque"]={ class = "WARRIOR", level = 30, },
	["Souhait mortel"]={ class = "WARRIOR", level = 30, },
	["Attaques circulaires"]={ class = "WARRIOR", level = 30, },
	["Sanguinaire"]={ class = "WARRIOR", level = 40, },
	["Frappe mortelle"]={ class = "WARRIOR", level = 40, },
	["Heurt de bouclier"]={ class = "WARRIOR", level = 40, },
};

Spy_IgnoreList = {

};
 
