--[[
    This file is part of Decursive.

    Decursive (v 2.7.8.2) add-on for World of Warcraft UI
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
-- French localization
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
T._LoadedFiles["frFR.lua"] = false;

local L = LibStub("AceLocale-3.0"):NewLocale("Decursive", "frFR");

if not L then
    T._LoadedFiles["frFR.lua"] = "2.7.8.2";
    return;
end

L["ABOLISH_CHECK"] = "Voir si \"Abolir\" sur la cible avant de guérir"
L["ABOUT_AUTHOREMAIL"] = "CONTACTER L'AUTEUR"
L["ABOUT_CREDITS"] = "REMERCIEMENTS"
L["ABOUT_LICENSE"] = "LICENCE"
L["ABOUT_NOTES"] = "Affichage et guérison des affections avec un système évolué de filtrage et de priorité."
L["ABOUT_OFFICIALWEBSITE"] = "SITE OFFICIEL"
L["ABOUT_SHAREDLIBS"] = "LIBRAIRIES PARTAGÉES"
L["ABSENT"] = "Absente (%s)"
L["AFFLICTEDBY"] = "Affecté par %s"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "Nombre d'affectés à afficher : "
L["ANCHOR"] = "Ancre du texte"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "Afficher ou masquer les micro-portraits"
L["BINDING_NAME_DCRPRADD"] = "Ajouter la cible à la liste de priorités"
L["BINDING_NAME_DCRPRCLEAR"] = "Effacer la liste de priorités"
L["BINDING_NAME_DCRPRLIST"] = "Afficher la liste de priorités"
L["BINDING_NAME_DCRPRSHOW"] = "Afficher ou Cacher la liste de priorités"
L["BINDING_NAME_DCRSHOW"] = [=[Afficher ou Cacher la barre Decursive
(Ancre de la liste des affectés)]=]
L["BINDING_NAME_DCRSHOWOPTION"] = "Affiche le panneau des options"
L["BINDING_NAME_DCRSKADD"] = "Ajouter la cible à la liste des exceptions"
L["BINDING_NAME_DCRSKCLEAR"] = "Effacer la liste des exceptions"
L["BINDING_NAME_DCRSKLIST"] = "Afficher la liste des exceptions"
L["BINDING_NAME_DCRSKSHOW"] = "Afficher ou Cacher la liste des exceptions"
L["BLACK_LENGTH"] = "Délais (Secs) sur la *blacklist* : "
L["BLACKLISTED"] = "Sur liste noire"
L["CHARM"] = "Possession"
L["CLASS_HUNTER"] = "Chasseur"
L["CLEAR_PRIO"] = "E"
L["CLEAR_SKIP"] = "E"
L["COLORALERT"] = "Règle la couleur d'alerte quand un '%s' est requis."
L["COLORCHRONOS"] = "Compteur central"
L["COLORCHRONOS_DESC"] = "Règle la couleur du compteur au centre de chaque micro-portrait"
L["COLORSTATUS"] = "Règle la couleur du statut '%s'."
L["CTRL"] = "Ctrl"
L["CURE_PETS"] = "Contrôler et guérir les familiers"
L["CURSE"] = "Malédiction"
L["DEBUG_REPORT_HEADER"] = [=[|cFF11FF33Merci d'envoyer par email le contenu de cette fenêtre à <%s>|r
|cFF009999(Faire CTRL+A pour tout sélectionner et CTRL+C pour le copier dans votre "presse papier")|r
Dîtes également dans votre rapport si vous avez remarqué un comportement étrange de %s.
]=]
L["DECURSIVE_DEBUG_REPORT"] = "**** |cFFFF0000Rapport de debuggage de Decursive|r ****"
L["DECURSIVE_DEBUG_REPORT_BUT_NEW_VERSION"] = [=[|cFF11FF33Decursive s'est planté ! Mais n'ayez crainte ! Une NOUVELLE version de Decursive a été détectée (%s). Il suffit simplement de vous mettre à jour. Aller sur Curse.com et chercher 'Decursive' ou utilisez le client de Curse.com, Il mettra à jour tous vos add-ons préférés automatiquement.|r
|cFFFF1133Ne perdez donc pas votre temps en rapportant ce problème, ce bug à probablement déjà été corrigé. Mettez simplement Decursive à jour pour vous débarrasser de ce problème. !|r
|cFF11FF33Merci d'avoir lu ce message !|r]=]
L["DECURSIVE_DEBUG_REPORT_NOTIFY"] = [=[Un rapport de debuggage est disponible !
Taper |cFFFF0000/DCRREPORT|r pour le voir.]=]
L["DECURSIVE_DEBUG_REPORT_SHOW"] = "Rapport de debuggage disponible !"
L["DECURSIVE_DEBUG_REPORT_SHOW_DESC"] = "Affiche un rapport de debuggage que l'auteur doit voir..."
L["DEFAULT_MACROKEY"] = "NONE"
L["DEV_VERSION_ALERT"] = [=[Vous  utilisez une version de développement de Decursive.

Si vous ne voulez pas participer au test des nouvelles fonctionnalités/corrections, recevoir des rapports de débuggage pendant le jeu, rapporter les problèmes à l'auteur alors N'UTILISEZ PAS CETTE VERSION et télécharger la dernière version STABLE sur curse.com ou wowace.com.

Ce message ne sera affiché qu'une seule fois par version.

]=]
L["DEV_VERSION_EXPIRED"] = [=[Cette version de développement de Decursive a expiré.
Vous devriez télécharger la dernière version de développement ou retourner à la version stable courante disponible sur CURSE.COM ou WOWACE.COM]=]
L["DEWDROPISGONE"] = "Il n'y a pas d'équivalent à DewDrop pour Ace3. Faire Alt-clique-droit pour ouvrir le panneau des options."
L["DISABLEWARNING"] = [=[Decursive a été désactivé !
Pour le réactiver, tapper |cFFFFAA44/DCR ENABLE|r]=]
L["DISEASE"] = "Maladie"
L["DONOT_BL_PRIO"] = "Ne pas *blacklister* les gens prioritaires"
L["DONT_SHOOT_THE_MESSENGER"] = "Decursive ne fait que rapporter le problème. Alors, ne tirez pas sur le messager et adressez le vrai problème."
L["FAILEDCAST"] = [=[|cFF22FFFF%s %s|r sur %s |cFFAA0000échoué !|r
|cFF00AAAA%s|r]=]
L["FOCUSUNIT"] = "Focalise l'unité"
L["FUBARMENU"] = "Menu de Fubar"
L["FUBARMENU_DESC"] = "Règles les options relatives à l'icône de FuBar"
L["GLOR1"] = "À la mémoire de Glorfindal"
L["GLOR2"] = "Decursive est dédié à la mémoire de Bertrand qui nous a quitté bien trop tôt. On se souviendra toujours de lui."
L["GLOR3"] = [=[En souvenir de Bertrand Sense
1969 - 2007]=]
L["GLOR4"] = [=[L'amitié et l'affection peuvent prendre naissance n'importe où, ceux qui ont rencontré Glorfindal dans World Of Warcraft ont connu un homme engagé et un leader charismatique.

Il était dans la vie comme dans le jeux, désintéressé, généreux, dévoué envers les siens et surtout un homme passionné.

Il nous a quitté à l'âge de 38 ans laissant derrière lui pas seulement des joueurs anonymes dans un monde virtuel, mais un groupe de véritables amis à qui il manquera éternellement.]=]
L["GLOR5"] = "On ne l'oubliera jamais..."
L["HANDLEHELP"] = "Déplacer tous les micro-portraits"
L["HIDE_MAIN"] = "Cacher la fenêtre \"Decursive\""
L["HIDESHOW_BUTTONS"] = "Cacher/Afficher les boutons et Verrouiller/Déverrouiller la barre \"Decursive\""
L["HLP_LEFTCLICK"] = "Clic Gauche"
L["HLP_LL_ONCLICK_TEXT"] = [=[Cette liste n'est pas cliquable. Merci de lire la documentation pour apprendre à utiliser cet add-on. Cherchez 'Decursive' sur WoWAce.com
(Pour bouger cette liste, bougez la barre de Decursive, /dcrshow et alt-clic-gauche pour déplacer)]=]
L["HLP_MIDDLECLICK"] = "Clic Milieu"
L["HLP_MOUSE4"] = "Souris 4"
L["HLP_MOUSE5"] = "Souris 5"
L["HLP_NOTHINGTOCURE"] = "Il n'y a rien à guérir !"
L["HLP_RIGHTCLICK"] = "Clic Droit"
L["HLP_USEXBUTTONTOCURE"] = "Utilisez \"%s\" pour guérir cette affection !"
L["HLP_WRONGMBUTTON"] = "Mauvais clique !"
L["IGNORE_STEALTH"] = "Ignorer les unités camouflées"
L["IS_HERE_MSG"] = "Decursive est initialisé, n'oubliez pas de contrôler les options disponibles (/decursive)"
L["LIST_ENTRY_ACTIONS"] = [=[|cFF33AA33[CTRL]|r Click : Efface ce joueur
Click |cFF33AA33GAUCHE|r : Monte ce joueur
Click |cFF33AA33DROIT|r: Descend ce joueur
|cFF33AA33[MAJ]|r Click |cFF33AA33GAUCHE|r : Met ce joueur en haut
|cFF33AA33[MAJ]|r Click |cFF33AA33DROIT|r : Met ce joueur en bas]=]
L["MACROKEYALREADYMAPPED"] = [=[ATTENTION: La touche affectée à la macro de Decursive [%s] était affectée à l'action '%s'.
Decursive restaurera l'action originale si vous affectez une autre touche à la macro.]=]
L["MACROKEYMAPPINGFAILED"] = "La touche [%s] n'a pas pu être affectée à la macro de Decursive"
L["MACROKEYMAPPINGSUCCESS"] = "La touche [%s] a été correctement affectée à la macro de Decursive."
L["MACROKEYNOTMAPPED"] = "Aucune touche n'est affectée à la macro de Decursive, reportez-vous aux options concernant la macro !"
L["MAGIC"] = "Magie"
L["MAGICCHARMED"] = "Contrôle magique"
L["MISSINGUNIT"] = "Unité absente"
L["NEW_VERSION_ALERT"] = [=[Une nouvelle version de Decursive a été détectée: |cFFEE7722%q|r sortie le |cFFEE7722%s|r!


Allez sur |cFFFF0000WoWAce.com|r pour l'obtenir !
--------]=]
L["NORMAL"] = "Normal"
L["NOSPELL"] = "Aucun sort disponible"
L["NOTICE_FRAME_TEMPLATE"] = [=[|cFFFF0000Decursive - Information|r

%s]=]
L["OPT_ABOLISHCHECK_DESC"] = "Définit si les unités avec un sort 'Abolir' actif sont affichées et soignées"
L["OPT_ABOUT"] = "À propos"
L["OPT_ADD_A_CUSTOM_SPELL"] = "Ajouter un sort / objet personnalisé"
L["OPT_ADD_A_CUSTOM_SPELL_DESC"] = "Glissez-déposez un sort ou un objet utilisable ici. Vous pouvez aussi directement taper son nom, son identifiant numérique ou utiliser MAJ+Clique."
L["OPT_ADDDEBUFF"] = "Ajouter une affection"
L["OPT_ADDDEBUFF_DESC"] = "Ajoute une nouvelle affection à cette liste"
L["OPT_ADDDEBUFF_USAGE"] = "<Spell ID de l'affection> (Vous pouvez trouver cet ID dans les URLs du site WoWHead.com)"
L["OPT_ADDDEBUFFFHIST"] = "Ajouter une affection récemment guérie"
L["OPT_ADDDEBUFFFHIST_DESC"] = "Ajouter une affection depuis l'historique des affections que vous avez récemment guérie."
L["OPT_ADVDISP"] = "Options avancées"
L["OPT_ADVDISP_DESC"] = "Permet de régler la transparence de la bordure et du centre séparément, permet de régler l'espace entre les micro-portraits"
L["OPT_AFFLICTEDBYSKIPPED"] = "%s affecté(e) par %s sera ignoré"
L["OPT_ALLOWMACROEDIT"] = "Autoriser l'édition de la macro"
L["OPT_ALLOWMACROEDIT_DESC"] = "Activer cette option empêche Decursive de mettre à jour sa macro, vous permettant de la modifier."
L["OPT_ALWAYSIGNORE"] = "Ignorer aussi hors combat"
L["OPT_ALWAYSIGNORE_DESC"] = "Si cochée, cette affection sera aussi ignorée en dehors des combats"
L["OPT_AMOUNT_AFFLIC_DESC"] = "Définit le nombre max d'affectés affichés dans la liste des affectés."
L["OPT_ANCHOR_DESC"] = "Montre l'ancre de la fenêtre de discussion spéciale"
L["OPT_AUTOHIDEMFS"] = "Masquer les MUFs quand :"
L["OPT_AUTOHIDEMFS_DESC"] = "Choisissez quand la fenêtre des micro-portraits doit être masquée automatiquement."
L["OPT_BLACKLENTGH_DESC"] = "Définit combien de temps quelqu'un reste sur liste noire"
L["OPT_BORDERTRANSP"] = "Transparence de la bordure"
L["OPT_BORDERTRANSP_DESC"] = "Règle la transparence de la bordure"
L["OPT_CENTERTEXT"] = "Compteur central :"
L["OPT_CENTERTEXT_DESC"] = [=[Affiche des informations concernant l'affliction la plus importante (selon vos priorités) au centre de chaque micro-portrait.

Soit:
- Le temps restant avant l'expiration naturelle
- Le temps écoulé depuis l'infection
- Le nombre d'applications]=]
L["OPT_CENTERTEXT_DISABLED"] = "Désactivé"
L["OPT_CENTERTEXT_ELAPSED"] = "Temps écoulé"
L["OPT_CENTERTEXT_STACKS"] = "Nombre d'applications"
L["OPT_CENTERTEXT_TIMELEFT"] = "Temps restant"
L["OPT_CENTERTRANSP"] = "Transparence du centre"
L["OPT_CENTERTRANSP_DESC"] = "Règle la transparence du centre"
L["OPT_CHARMEDCHECK_DESC"] = "Si cochée, vous pourrez voir et guérir les unités possédées"
L["OPT_CHATFRAME_DESC"] = "Les messages de Decursive seront affichés dans la fenêtre de discussion par défaut"
L["OPT_CHECKOTHERPLAYERS"] = "Vérifier les autres joueurs"
L["OPT_CHECKOTHERPLAYERS_DESC"] = "Affiche la version de Decursive utilisée par les joueurs de votre groupe ou de votre guilde (Ne fonctionne qu'à partir de la version 2.4.6 de Decursive)."
L["OPT_CMD_DISBLED"] = "Désactivé"
L["OPT_CMD_ENABLED"] = "Activé"
L["OPT_CREATE_VIRTUAL_DEBUFF"] = "Créer une affection virtuelle de test"
L["OPT_CREATE_VIRTUAL_DEBUFF_DESC"] = "Permet de voir ce qu'il se passe lorsqu'une affection est détectée"
L["OPT_CURE_PRIORITY_NUM"] = "Priorité #%d"
L["OPT_CUREPETS_DESC"] = "Les familiers seront affichés et guéris"
L["OPT_CURINGOPTIONS"] = "Options de guérison"
L["OPT_CURINGOPTIONS_DESC"] = "Définit les différents aspects du processus de guérison (Types d'affections, et priorités)"
L["OPT_CURINGOPTIONS_EXPLANATION"] = [=[Sélectionnez les types d'affection que vous souhaitez guérir. Les types non sélectionnés seront complètement ignorés par Decursive.

Les chiffres en vert indiquent la priorité du type d'affections. Cette priorité affecte plusieurs aspects de Decursive :

- Quelle affection Decursive vous montre en premier lorsqu'un joueur souffre de plusieurs types affections.

- Quelle sera la couleur du micro-portrait et donc sur quel bouton de la souris vous devrez cliquer pour guérir ce type d'affections (clique gauche pour le premier sort, clique droit pour le second, etc...).

(Pour changer l'ordre, dé-sélectionnez tous les types et cochez-les dans l'ordre souhaité)]=]
L["OPT_CURINGORDEROPTIONS"] = "Types d'affections et priorités"
L["OPT_CURSECHECK_DESC"] = "Si cochée, vous pourrez voir et guérir les unités maudites"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING"] = "Autoriser la modification de la macro interne pour le sort ci-dessus"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING_DESC"] = [=[Cochez cela si vous voulez modifier la macro interne que Decursive utilisera pour le sort personnalisé que vous êtes en train d'ajouter.

Note: En cochant cela vous pourrez modifier les sorts gérés par Decursive.

Si un sort est déjà listé, il faudra d'abord le retirer pour activer cette option.

(---Seulement pour les utilisateurs avancés---)]=]
L["OPT_CUSTOM_SPELL_CURE_TYPES"] = "Types d'afflictions"
L["OPT_CUSTOM_SPELL_IS_DEFAULT"] = "Ce sort fait partie de la configuration automatique de Decursive. Si le sort ne fonctionne plus correctement, vous pouvez l'effacer pour retrouver le comportement par défaut de Decursive."
L["OPT_CUSTOM_SPELL_ISPET"] = "Capacité de familier"
L["OPT_CUSTOM_SPELL_ISPET_DESC"] = "Cocher cette option si c'est une capacité appartenant à l'un de vos familiers afin que Decursive puisse la détecter et l'utiliser correctement."
L["OPT_CUSTOM_SPELL_MACRO_MISSING_NOMINAL_SPELL"] = "Attention: le sort %q n’apparaît pas dans votre macro, les informations de cooldown et de portée ne correspondront pas... "
L["OPT_CUSTOM_SPELL_MACRO_MISSING_UNITID_KEYWORD"] = "Le mot-clé UNITID est manquant."
L["OPT_CUSTOM_SPELL_MACRO_TEXT"] = "Texte de la macro :"
L["OPT_CUSTOM_SPELL_MACRO_TEXT_DESC"] = [=[Modifiez le texte original de la macro.
|cFFFF0000Seulement 2 restrictions:|r

- Vous devez spécifier la cible en utilisant le mot-clé UNITID qui sera automatiquement remplacé par l'identifiant d'unité de chaque micro-portrait.

- Quel que soit le sort utilisé dans la macro, Decursive utilisera le nom originel indiqué à gauche pour récupérer et afficher les informations de portée et de cooldown.
(Gardez cela à l'esprit si vous comptez utiliser différents sorts avec des conditions)]=]
L["OPT_CUSTOM_SPELL_MACRO_TOO_LONG"] = "Votre macro est trop longue, vous devez enlever %d caractères."
L["OPT_CUSTOM_SPELL_PRIORITY"] = "Priorité du sort"
L["OPT_CUSTOM_SPELL_PRIORITY_DESC"] = [=[Quand plusieurs sorts peuvent guérir les mêmes types d'afflictions, ceux ayant la priorité la plus élevée seront préférés.

Notez que les sorts par défaut gérés par Decursive ont une priorité allant de 0 à 9.

Ainsi, si vous donnez une priorité négative à l'un de vos sort, il ne sera choisi que si le sort par défaut n'est pas disponible.]=]
L["OPT_CUSTOM_SPELL_UNAVAILABLE"] = "indisponible"
L["OPT_CUSTOM_SPELL_UNIT_FILTER"] = "Filtrage"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_DESC"] = "Sélectionnez les unités qui peuvent bénéficier de cette technique"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_NONE"] = "Toutes les unités"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_NONPLAYER"] = "Les autres seulement"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_PLAYER"] = "Seulement sois-même"
L["OPT_CUSTOMSPELLS"] = "Sorts / objets personnalisés"
L["OPT_CUSTOMSPELLS_DESC"] = [=[Ici vous pouvez ajouter des sorts pour étendre la configuration automatique de Decursive.
Vos sorts personnalisés auront toujours une priorité plus élevée et remplaceront systématiquement les sorts par défaut (si et seulement si votre personnage peut utiliser ces sorts)]=]
L["OPT_CUSTOMSPELLS_EFFECTIVE_ASSIGNMENTS"] = "Assignations effectives des sorts :"
L["OPT_DEBCHECKEDBYDEF"] = [=[

Cochée par défaut]=]
L["OPT_DEBUFFENTRY_DESC"] = "Sélectionnez quelle classe doit être ignorée pour cette affection"
L["OPT_DEBUFFFILTER"] = "Filtrage des affections"
L["OPT_DEBUFFFILTER_DESC"] = "Sélectionner les affections à filtrer par nom et par classe pendant les combat"
L["OPT_DELETE_A_CUSTOM_SPELL"] = "Supprimer"
L["OPT_DISABLEABOLISH"] = "Ne pas utiliser les sorts 'Abolir'"
L["OPT_DISABLEABOLISH_DESC"] = "Si activée, Decursive préfèrera 'Guérison des maladies' et 'Guérison du poison' à la place de leur équivalent en 'Abolir'"
L["OPT_DISABLEMACROCREATION"] = "Ne pas créer de macro"
L["OPT_DISABLEMACROCREATION_DESC"] = "La macro de Decursive ne sera plus créée ni mis à jour."
L["OPT_DISEASECHECK_DESC"] = "Si cochée, vous pourrez voir et guérir les unités malade"
L["OPT_DISPLAYOPTIONS"] = "Options d'affichage"
L["OPT_DONOTBLPRIO_DESC"] = "Les unités prioritaires ne seront pas blacklistées"
L["OPT_ENABLE_A_CUSTOM_SPELL"] = "Activer"
L["OPT_ENABLE_LIVELIST"] = "Activer la liste des affligés"
L["OPT_ENABLE_LIVELIST_DESC"] = [=[Affiche une liste des gens affligés.

vous pouvez déplacer cette liste en déplaçant la barre de Decursive (tapper /DCRSHOW pour afficher cette barre)]=]
L["OPT_ENABLEDEBUG"] = "Debug"
L["OPT_ENABLEDEBUG_DESC"] = "Activer les informations de debuggage"
L["OPT_ENABLEDECURSIVE"] = "Activer Decursive"
L["OPT_FILTERED_DEBUFF_RENAMED"] = "L'affection filtrée \"%s\" a automatiquement été renommé par \"%s\" pour le Spell ID %d"
L["OPT_FILTEROUTCLASSES_FOR_X"] = "%q sera ignoré sur les classes spécifiées pendant que vous êtes en combat."
L["OPT_GENERAL"] = "Options générales"
L["OPT_GROWDIRECTION"] = "Inverser l'affichage des micro-portraits"
L["OPT_GROWDIRECTION_DESC"] = "Les micro-portraits seront affichés de bas en haut"
L["OPT_HIDEMFS_GROUP"] = "en solo ou en groupe"
L["OPT_HIDEMFS_GROUP_DESC"] = "Masque la fenêtre lorsque vous n'êtes pas dans un groupe de raid."
L["OPT_HIDEMFS_NEVER"] = "Ne jamais masquer"
L["OPT_HIDEMFS_NEVER_DESC"] = "Ne jamais masquer la fenêtre automatiquement."
L["OPT_HIDEMFS_SOLO"] = "en solo"
L["OPT_HIDEMFS_SOLO_DESC"] = "Masque la fenêtre lorsque vous jouez en solo."
L["OPT_HIDEMUFSHANDLE"] = "Chacher la poignée des Micro-Portraits"
L["OPT_HIDEMUFSHANDLE_DESC"] = [=[Cache la poignée des Micro-Portraits et désactive la possibilité de les bouger.
Utilisez la même commande pour la retrouver.]=]
L["OPT_IGNORESTEALTHED_DESC"] = "Les unités camouflées seront ignorées"
L["OPT_INPUT_SPELL_BAD_INPUT_ALREADY_HERE"] = "Le sort est déjà dans la liste !"
L["OPT_INPUT_SPELL_BAD_INPUT_DEFAULT_SPELL"] = "Decursive gère déjà ce sort. MAJ-cliquez sur le sort ou tapez son ID pour ajouter un rang spécial."
L["OPT_INPUT_SPELL_BAD_INPUT_ID"] = "ID de sort invalide !"
L["OPT_INPUT_SPELL_BAD_INPUT_NOT_SPELL"] = "Ce sort ne se trouve pas dans votre grimoire !"
L["OPT_ISNOTVALID_SPELLID"] = "n'est pas un Spell ID valide"
L["OPT_LIVELIST"] = "Liste des affligés"
L["OPT_LIVELIST_DESC"] = [=[Ce sont les options concernant la liste des affligés affichée en dessous de la barre "Decursive".

Pour déplacer cette liste il faut bouger cette barre. Certains des réglages ci-dessous ne sont accessibles que lorsque cette barre est affichée. Vous pouvez l'afficher en tapant |cff20CC20/DCRSHOW|r dans votre fenêtre de discussion.

Une fois que vous avez réglé la position, l'échelle et la transparence vous pouvez cacher cette barre sans problème en tapant  |cff20CC20/DCRHIDE|r.]=]
L["OPT_LLALPHA"] = "Transparence"
L["OPT_LLALPHA_DESC"] = [=[Définit la transparence de la barre principale de Decursive et de la liste des affligés
(la barre principale doit être affichée)]=]
L["OPT_LLSCALE"] = "Échelle de la liste des affectés"
L["OPT_LLSCALE_DESC"] = [=[Définit la taille de la barre principale de Decursive et de la liste des affectés
(la barre principale doit être affichée)]=]
L["OPT_LVONLYINRANGE"] = "Unités à portée seulement"
L["OPT_LVONLYINRANGE_DESC"] = "Si cette option est activée, uniquement les unités à portée de sorts seront affichées dans la liste"
L["OPT_MACROBIND"] = "Définit la touche liée à la macro"
L["OPT_MACROBIND_DESC"] = [=[Définit la touche à partir de laquelle la macro 'Decursive' sera appelée.

Appuyer sur la touche puis sur 'Entrée' pour sauvegarder la nouvelle affectation.]=]
L["OPT_MACROOPTIONS"] = "Options de la macro"
L["OPT_MACROOPTIONS_DESC"] = "Définit le comportement de la macro 'mouseover' créée par Decursive"
L["OPT_MAGICCHARMEDCHECK_DESC"] = "Si cochée, vous pourrez voir et guérir les unités contrôlées par magie"
L["OPT_MAGICCHECK_DESC"] = "Si cochée, vous pourrez voir et guérir les unités affectées par la magie"
L["OPT_MAXMFS"] = "Nombre maximum d'unités affichées"
L["OPT_MAXMFS_DESC"] = "Définit le nombre maximum de micro-portraits à afficher"
L["OPT_MESSAGES"] = "Messages"
L["OPT_MESSAGES_DESC"] = "Options sur les messages affichés"
L["OPT_MFALPHA"] = "Transparence"
L["OPT_MFALPHA_DESC"] = "Définit la transparence des micro-portraits, lorsque l'unité n'est pas affectée."
L["OPT_MFPERFOPT"] = "Options de performance"
L["OPT_MFREFRESHRATE"] = "Taux de rafraîchissement"
L["OPT_MFREFRESHRATE_DESC"] = "Période de rafraîchissement (1 ou plusieurs micro-portraits peuvent être rafraîchis en même temps)"
L["OPT_MFREFRESHSPEED"] = "Rapidité de rafraîchissement"
L["OPT_MFREFRESHSPEED_DESC"] = "Nombre de micro-portraits à rafraîchir à chaque passage"
L["OPT_MFSCALE"] = "Échelle des micro-portraits"
L["OPT_MFSCALE_DESC"] = "Définit la taille des micro-portraits"
L["OPT_MFSETTINGS"] = "Options des micro-portraits"
L["OPT_MFSETTINGS_DESC"] = "Règle divers options d'affichage des micro-portraits et des priorités de guérison"
L["OPT_MUFFOCUSBUTTON"] = "Bouton de focalisation"
L["OPT_MUFHANDLE_HINT"] = "Pour déplacer les micro-portraits : ALT-cliquez sur la poignée invisible située au dessus du premier micro-portrait."
L["OPT_MUFMOUSEBUTTONS"] = "Boutons de la souris"
L["OPT_MUFMOUSEBUTTONS_DESC"] = [=[Ici vous pouvez changer le bouton de la souris correspondant à chacune des actions possibles sur les micro-portraits (guérison, ciblage et focalisation).

À chacune des différentes priorités correspond un certain type d'affection, comme indiqué dans le panneau "|cFFFF5533Options de guérison|r".

Les sorts utilisés pour chaque type d'affection sont réglés automatiquement, vous pouvez changer ces sorts dans le panneau '|cFF00DDDDSorts personnalisés|r'.]=]
L["OPT_MUFSCOLORS"] = "Couleurs"
L["OPT_MUFSCOLORS_DESC"] = [=[Options pour changer la couleur de chaque priorité de guérison et des différents statuts des micro-portraits.

À chacune des différentes priorités correspond un certain type d'affection, comme indiqué dans le panneau "|cFFFF5533Options de guérison|r".]=]
L["OPT_MUFSVERTICALDISPLAY"] = "Affichage vertical"
L["OPT_MUFSVERTICALDISPLAY_DESC"] = "La fenêtre des micro-portraits s'agrandira verticalement"
L["OPT_MUFTARGETBUTTON"] = "Bouton de ciblage"
L["OPT_NEWVERSIONBUGMENOT"] = "Alertes de mise à jour"
L["OPT_NEWVERSIONBUGMENOT_DESC"] = "Si une nouvelle version de Decursive est détectée, une alerte sera affichée une fois tous les sept jours."
L["OPT_NOKEYWARN"] = "Avertir si aucune touche"
L["OPT_NOKEYWARN_DESC"] = "Affiche un avertissement si aucune touche n'est affectée à la macro."
L["OPT_NOSTARTMESSAGES"] = "Désactiver les messages de bienvenue"
L["OPT_NOSTARTMESSAGES_DESC"] = "Enlève les deux messages que Decursive écrit dans le chat à chaque connexion."
L["OPT_OPTIONS_DISABLED_WHILE_IN_COMBAT"] = "Ces options sont désactivées lorsque vous combattez."
L["OPT_PERFOPTIONWARNING"] = "ATTENTION : Ne changez pas ces réglages sauf si vous savez parfaitement ce que vous faites. Ces réglages peuvent affecter grandement les performances du jeux. La plus part des utilisateurs devrait utiliser les valeurs par défaut de 0,1 et 10."
L["OPT_PLAYSOUND_DESC"] = "Joue un son si quelqu'un est affecté."
L["OPT_POISONCHECK_DESC"] = "Si cochée, vous pourrez voir et guérir les unités empoisonnées"
L["OPT_PRINT_CUSTOM_DESC"] = "Les messages de Decursive seront affichés dans une fenêtre de discussion spéciale"
L["OPT_PRINT_ERRORS_DESC"] = "Les erreurs seront affichées"
L["OPT_PROFILERESET"] = "Remise à zéro du profil..."
L["OPT_RANDOMORDER_DESC"] = "Les unités seront affichées et guéries au hasard (non recommandé)"
L["OPT_READDDEFAULTSD"] = "Ré-ajouter les affections par défaut"
L["OPT_READDDEFAULTSD_DESC1"] = [=[Ajoute les affections de Decursive manquant à cette liste
Votre configuration ne sera pas changée]=]
L["OPT_READDDEFAULTSD_DESC2"] = "Toutes les affections par défaut de Decursive sont dans cette liste"
L["OPT_REMOVESKDEBCONF"] = [=[Êtes-vous sûr de vouloir enlever 
 '%s' 
de la liste des exceptions ?]=]
L["OPT_REMOVETHISDEBUFF"] = "Enlever cette affection"
L["OPT_REMOVETHISDEBUFF_DESC"] = "Supprime '%s' de la liste d'exception"
L["OPT_RESETDEBUFF"] = "Remettre à zéro cette affection"
L["OPT_RESETDTDCRDEFAULT"] = "Met '%s' aux valeurs par défaut de Decursive"
L["OPT_RESETMUFMOUSEBUTTONS"] = "Réinitialiser"
L["OPT_RESETMUFMOUSEBUTTONS_DESC"] = "Réinitialise les affectations des boutons de la souris aux valeurs par défaut."
L["OPT_RESETOPTIONS"] = "Remet les options par défaut"
L["OPT_RESETOPTIONS_DESC"] = "Met les options du profil courant aux valeurs par défaut"
L["OPT_RESTPROFILECONF"] = [=[Êtes-vous sûr de vouloir remettre votre profil
 '(%s) %s'
 aux valeurs par défaut ?]=]
L["OPT_REVERSE_LIVELIST_DESC"] = "La liste des affectés se remplit de bas en haut"
L["OPT_SCANLENGTH_DESC"] = "Définit le temps entre chaque scan"
L["OPT_SETAFFTYPECOLOR_DESC"] = [=[Change la couleur des afflictions de type "%s"

(Apparaît principalement dans les infobulles des MUFs et dans la Live list)]=]
L["OPT_SHOW_STEALTH_STATUS"] = "Montrer le camouflage"
L["OPT_SHOW_STEALTH_STATUS_DESC"] = "Lorsqu'un joueur est camouflé, son micro-portrait prendra une couleur spéciale."
L["OPT_SHOWBORDER"] = "Afficher la bordure colorée des classes"
L["OPT_SHOWBORDER_DESC"] = "Une bordure colorée représentant la classe de l'unité est affichée autour des micro-portraits"
L["OPT_SHOWHELP"] = "Affiche l'aide"
L["OPT_SHOWHELP_DESC"] = "Affiche une bulle d'aide lorsque la souris passe au-dessus d'un micro-portrait"
L["OPT_SHOWMFS"] = "Affiche la fenêtre de micro-portraits"
L["OPT_SHOWMFS_DESC"] = "Cette option doit être activée, si vous voulez guérir en cliquant avec la souris"
L["OPT_SHOWMINIMAPICON"] = "Icône Minicarte"
L["OPT_SHOWMINIMAPICON_DESC"] = "Active/Désactive l'icône de la minicarte"
L["OPT_SHOWTOOLTIP_DESC"] = "Affiche une bulle d'informations détaillées à propos des affections sur les micro-portraits et dans la liste des affectés."
L["OPT_SPELL_DESCRIPTION_LOADING"] = "Chargement de la description en cours... revenez plus tard."
L["OPT_SPELL_DESCRIPTION_UNAVAILABLE"] = "La description n'est pas disponible"
L["OPT_SPELLID_MISSING_READD"] = "Vous devez ré-ajouter cette affection en utilisant son Spell ID pour avoir une description au lieu de ce message."
L["OPT_STICKTORIGHT"] = "Aligner la fenêtre à droite"
L["OPT_STICKTORIGHT_DESC"] = "La fenêtre des micro-portrait se développera de la droite vers la gauche, la poignée sera déplacée automatiquement."
L["OPT_TESTLAYOUT"] = "Tester la disposition"
L["OPT_TESTLAYOUT_DESC"] = [=[Créé des unités virtuelles permettant de tester leur disposition.
(Attendre quelques secondes après avoir cliqué)]=]
L["OPT_TESTLAYOUTUNUM"] = "Nombre d'unité"
L["OPT_TESTLAYOUTUNUM_DESC"] = "Règle le nombre d'unité virtuelles à créer."
L["OPT_TIE_LIVELIST_DESC"] = "L'affichage de la liste des affectés est lié à celui de la barre \"Decursive\""
L["OPT_TIECENTERANDBORDER"] = "Lier le centre et la bordure"
L["OPT_TIECENTERANDBORDER_OPT"] = "Quand activée, la transparence de la bordure vaut la moitié de celle du centre"
L["OPT_TIEXYSPACING"] = "Lier l'espacement horizontale et verticale"
L["OPT_TIEXYSPACING_DESC"] = "L'espacement horizontale et verticale entre les micro-portraits sont identiques"
L["OPT_UNITPERLINES"] = "Nombre d'unités par rangée"
L["OPT_UNITPERLINES_DESC"] = "Définit le nombre maximum de micro-portraits à afficher par rangée"
L["OPT_USERDEBUFF"] = "Cette affection ne fait pas partie de la liste des affections par défaut de Decursive"
L["OPT_XSPACING"] = "Espacement horizontal"
L["OPT_XSPACING_DESC"] = "Règle l'espacement horizontal entre les micro-portraits"
L["OPT_YSPACING"] = "Espacement vertical"
L["OPT_YSPACING_DESC"] = "Règle l'espacement vertical entre les micro-portraits"
L["OPTION_MENU"] = "Menu options"
L["PLAY_SOUND"] = "Jouer un son quand il y a quelqu'un à guérir"
L["POISON"] = "Poison"
L["POPULATE"] = "R"
L["POPULATE_LIST"] = "Remplir rapidement la liste"
L["PRINT_CHATFRAME"] = "Afficher les messages dans le canal par défaut"
L["PRINT_CUSTOM"] = "Afficher les messages dans la fenêtre"
L["PRINT_ERRORS"] = "Afficher les messages d'erreurs"
L["PRIORITY_LIST"] = "Liste des priorités"
L["PRIORITY_SHOW"] = "P"
L["RANDOM_ORDER"] = "Guérir aléatoirement"
L["REVERSE_LIVELIST"] = "Inverser l'affichage de la liste"
L["SCAN_LENGTH"] = "Délai (secs) entre les scans : "
L["SHIFT"] = "Maj"
L["SHOW_MSG"] = "Pour afficher la fenêtre \"Decursive\", tapez /dcrshow."
L["SHOW_TOOLTIP"] = "Afficher les infos-bulles sur les unités affectées"
L["SKIP_LIST_STR"] = "Liste des exceptions"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "%s trouvé !"
L["STEALTHED"] = "Camouflée"
L["STR_CLOSE"] = "Fermer"
L["STR_DCR_PRIO"] = "Liste de priorités"
L["STR_DCR_SKIP"] = "Liste des exceptions"
L["STR_GROUP"] = "Groupe "
L["STR_OPTIONS"] = "Options de Decursive"
L["STR_OTHER"] = "Autre"
L["STR_POP"] = "Remplir la liste"
L["STR_QUICK_POP"] = "Remplir rapidement"
L["SUCCESSCAST"] = "|cFF22FFFF%s %s|r sur %s |cFF00AA00réussi !|r"
L["TARGETUNIT"] = "Cible l'unité"
L["TIE_LIVELIST"] = "Lier la visibilité de la liste à \"Decursive\""
L["TOC_VERSION_EXPIRED"] = [=[Votre version de Decursive est périmée. Cette version de Decursive est plus ancienne que la version de World of Warcraft que vous utilisez.
Vous devez mettre à jour Decursive pour corriger d'éventuelles incompatibilités ou erreurs.

Allez sur curse.com et cherchez "Decursive" ou utilisez le client de Curse.com pour mettre tous vos add-ons à jour.

Cette note sera affichée de nouveau dans deux jours.]=]
L["TOO_MANY_ERRORS_ALERT"] = [=[Il y a trop d'erreurs Lua dans votre interface utilisateur (%d erreurs). Votre expérience de jeu peut être dégradée. Désactivez ou mettez à jour les add-ons en erreur pour stopper ce message.
Vous devriez activer les rapports d'erreur Lua (/console scriptErrors 1).]=]
L["TOOFAR"] = "Hors de portée"
L["UNITSTATUS"] = "Statut de l'unité : "
L["UNSTABLERELEASE"] = "Version instable"



T._LoadedFiles["frFR.lua"] = "2.7.8.2";
