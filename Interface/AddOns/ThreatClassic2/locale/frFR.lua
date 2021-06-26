local TC2, C, L, _ = unpack(select(2, ...))
if TC2.locale ~= "frFR" then return end

-----------------------------
--	frFR client
-----------------------------
-- main frame
L.gui_threat = "Menace"
L.gui_config = "Ouvrir la configuration"

-- cadre de configuration
L.reset = "Rétablir les valeurs par défaut"

-- messages
L.message_welcome = "Tapez /tc2 pour les options."
L.message_leader = "Vous devez être le chef du groupe ou avoir un assistant pour le faire."
L.message_outdated = "|cFFFBB709ThreatClassic2:|r Une nouvelle version est disponible! Veuillez mettre à jour."
L.message_incompatible = "|cFFFBB709ThreatClassic2|r est obsolète et incompatible avec les versions précédentes. Veuillez mettre à jour immédiatement!"

L.general = "Général"
L.general_welcome = "Afficher un message de bienvenue lors de la connexion."
L.general_rawPercent = "Utiliser le pourcentage de menace brut (aggro à 110% de mêlée /130% de portée)"
L.general_downscaleThreat = "Mettre à l'échelle les valeurs de menace (donc 1 dégât équivaut à 1 menace avant les modificateurs)"
L.general_downscaleThreatDesc = "L'API des menaces de Blizzard utilise 100 menaces pour 1 dommage. Ce paramètre réduit les numéros d'API des menaces à ce que nous utilisions avant le patch 1.13.5"
L.general_updateFreq = "Temps minimum (en secondes) entre les mises à jour."
L.general_updateFreq_desc = "Ce paramètre est destiné à limiter la consommation du processeur, lorsque tc2 est mis à jour à intervalles réguliers (par exemple, en mode cible cible). En général, les valeurs de menace ne peuvent pas être mises à jour plus rapidement que l'API de Blizzard les fournit. "
L.general_test = "Activer le mode test."
L.general_minimap = "Activer/désactiver l'icône de la mini-carte."
L.general_ignorePets = "Ignorez la menace des animaux de compagnie des joueurs."


L.visibility = "Visibilité"
L.visibility_hideOOC = "Cacher le cadre en dehors du combat."
L.visibility_hideSolo = "Masquer le cadre lorsque vous n'êtes pas dans le groupe."
L.visibility_hideInPvP = "Masquer le cadre sur les champs de bataille."
L.visibility_hideOpenWorld = "Cachez le cadre lorsque vous n'êtes pas dans une pièce (cela cache également les boss du monde!)."
L.visibility_hideAlways = "Cacher le cadre toujours. /toggle Tc2"

L.profiles = "Profils"

L.color = "Couleurs"

L.appearance = "Apparence"

L.frame = "Cadre"
L.frame_header = "En-tête"
L.frame_bg = "Arrière-plan"
L.frame_test = "Mode test"
L.frame_strata = "Strates"
L.frame_scale = "Échelle"
L.frame_lock = "Verrouiller"
L.frame_headerShow = "Afficher l'en-tête"
L.frame_headerColor = "Couleur de l'en-tête"
L.frame_position = "Position"
L.frame_width = "Largeur"
L.frame_height = "Hauteur"
L.frame_xOffset = "Décalage X"
L.frame_yOffset = "Décalage Y"

L.bar = "Barres"
L.bar_descend = "Croissance inversée"
L.bar_height = "Hauteur"
L.bar_padding = "Rembourrage"
L.bar_texture = "Texture"
L.bar_alpha = "Barre alpha (couleurs par défaut)"
L.bar_showThreatValue = "Afficher la valeur de la menace"
L.bar_showThreatPercentage = "Afficher le pourcentage de menace"
L.bar_showIgniteIndicator = "Afficher l'indicateur d'enflammé"
L.bar_showIgniteIndicator_desc = "Afficher une petite icône d'enflammé à côté du nom du joueur, qui possède actuellement l'enflammé."

L.igniteIndicator = "Indicateur d'enflammé"
L.igniteIndicator_makeRound = "Faites tourner l'icône"
L.igniteIndicator_makeRound_desc = "Nécessite /recharger pour recréer la texture."
L.igniteIndicator_size = "Taille"

L.customBarColors = "Couleurs de barre personnalisées"
L.customBarColorsPlayer_enabled = "Activer la couleur personnalisée du lecteur"
L.customBarColorsPlayer_desc = "Cette option définit une couleur fixe pour le lecteur indépendamment des autres options de couleur."
L.customBarColorsActiveTank_enabled = "Activer la couleur de réservoir active personnalisée"
L.customBarColorsOtherUnit_enabled = "Activer une autre couleur d'unité personnalisée"
L.customBarColorsIgnite_enabled = "Activer la couleur d'enflammé"
L.customBarColorsIgnite_desc = "Ceci changera la couleur de la barre si l'unité est enflammée sur la cible. La couleur du joueur et du tank a priorité."
L.customBarColorsPlayer_color = "Couleur du joueur"
L.customBarColorsActiveTank_color = "Couleur du réservoir actif"
L.customBarColorsOtherUnit_color = "Couleur de l'autre unité"
L.customBarColorsIgnite_color = "Couleur de l'unité d'enflammée"


L.font = "Police"
L.font_name = "Nom"
L.font_size = "Taille"
L.font_style = "Style"
L.NONE = "AUCUN"
L.OUTLINE = "CONTOUR"
L.THICKOUTLINE = "CONTOURGROSSE"
L.font_shadow = "Dropshadow"

L.warnings = "Avertissements"
L.warnings_flash = "Activer le clignotement de l'écran."
L.warnings_sound = "Activer les sons"
L.warnings_threshold = "Seuil d'avertissement (100% = agro)"
L.warnings_minThreatAmount = "Menace minimale pour déclencher des avertissements"
L.warnings_minThreatAmount_desc = "La valeur dépend du paramètre 'Général -> Échelle des valeurs de menace' et correspond à la menace affichée. Des nombres plus grands peuvent être définis avec la zone de saisie."

L.warnings_soundFile = "Fichier son"
L.warnings_soundChannel = "Canal sonore"

L.soundChannel_master = "Maître"
L.soundChannel_sfx = "SFX"
L.soundChannel_ambience = "Environnement"
L.soundChannel_music = "Musique"
