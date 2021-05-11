-- Not translations
MONKEYQUEST_TITLE						= "MonkeyQuest"
MONKEYQUEST_VERSION						= "2.11.0"
MONKEYQUEST_TITLE_VERSION				= MONKEYQUEST_TITLE .. " v" .. MONKEYQUEST_VERSION
MONKEYQUEST_INFO_COLOUR					= "|cffffff00"
MONKEYQUEST_CHAT_COLOUR					= "|cff00ff00"
BINDING_HEADER_MONKEYQUEST				= MONKEYQUEST_TITLE

-- English, the default
MONKEYQUEST_DESCRIPTION					= "Displays your quests for quick viewing."
MONKEYQUEST_LOADED_MSG					= MONKEYQUEST_INFO_COLOUR .. MONKEYQUEST_TITLE .. " v" .. MONKEYQUEST_VERSION .. " loaded"
MONKEYQUEST_OPTIONS1					= "Please install MonkeyBuddy to configure your MonkeyQuest easily."
MONKEYQUEST_OPTIONS2					= "\124TInterface\\Icons\\Trade_Engineering:0\124t MonkeyBuddy is currently not installed."

MONKEYQUEST_NO_HEADER					= "No Header"
MONKEYQUEST_QUEST_DONE					= "done"
MONKEYQUEST_QUEST_FAILED				= "failed"
MONKEYQUEST_CONFIRM_RESET				= "Okay to reset " .. MONKEYQUEST_TITLE .. " settings to default values?"
MONKEYQUEST_CONFIRM_RESET_TO_BLIZZARD_STYLE				= "Okay to set " .. MONKEYQUEST_TITLE .. " settings to Blizzard quest tracker style?"

MONKEYQUEST_SET_WIDTH_MSG				= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": You may need to '/console reloadui' to see the changes in width."
MONKEYQUEST_RESET_MSG					= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": Settings reset."
MONKEYQUEST_RESET_TO_BLIZZARD_STYLE_MSG	= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": Settings set to Blizzard quest tracker style."

MONKEYQUEST_HELP_MSG					= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest help <command>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Where <command> is any of the following: \n" ..
										  "reset, open, close, showhidden, hidehidden, useoverviews, nooverviews, " ..
										  "tipanchor, alpha, width, hideheaders, showheaders, hideborder, showborder, " ..
										  "growup, growdown, hidenumquests, shownumquests, lock, unlock, colourtitleon, " ..
										  "colourtitleoff, hidecompletedquests, showcompletedquests, hidecompletedobjectives, " ..
										  "showcompletedobjectives, fontheight, showtooltipobjectives, hidetootipobjectives, " ..
										  "allowrightclick, disallowrightclick, hidetitlebuttons, showtitlebuttons, allowworkcomplete, disallowworkcomplete, " ..
										  "colourobjectiveson, colourobjectivesoff, showitems, hideitems, itemsonleft, itemsonright, hideviaclick, nohideviaclick."
MONKEYQUEST_HELP_RESET_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest reset\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Displays the reset config variables dialog.\n"
MONKEYQUEST_HELP_OPEN_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest open\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Shows the main " .. MONKEYQUEST_TITLE .. " frame.\n"
MONKEYQUEST_HELP_CLOSE_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest close\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hides the main " .. MONKEYQUEST_TITLE .. " frame.\n"
MONKEYQUEST_HELP_SHOWHIDDEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showhidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Shows collapsed zone headers and hidden quests.\n"
MONKEYQUEST_HELP_HIDEHIDDEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidehidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hides collapsed zone headers and hidden quests.\n"
MONKEYQUEST_HELP_USEOVERVIEWS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest useoverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Displays the quest overview for quests without objectives.\n"
MONKEYQUEST_HELP_NOOVERVIEWS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest nooverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Don't display the quest overview for quests without objectives.\n"
MONKEYQUEST_HELP_TIPANCHOR_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest tipanchor=<anchor position>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the anchor point of the tooltip where <anchor position> " .. 
										  "can be any of the following:\nANCHOR_TOPLEFT, ANCHOR_TOPRIGHT, ANCHOR_TOP, ANCHOR_LEFT, " ..
										  "ANCHOR_RIGHT, ANCHOR_BOTTOMLEFT, ANCHOR_BOTTOMRIGHT, ANCHOR_BOTTOM, ANCHOR_CURSOR, " .. 
										  "DEFAULT, NONE"
MONKEYQUEST_HELP_ALPHA_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest alpha=<0 - 255>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the backdrop alpha to the specified value.\n"
MONKEYQUEST_HELP_WIDTH_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest width=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the width to the specified value, the default is 255.\n"
MONKEYQUEST_HELP_HIDEHEADERS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hideheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Never display any zone headers.\n"
MONKEYQUEST_HELP_SHOWHEADERS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Display zone headers.\n"
MONKEYQUEST_HELP_HIDEBORDER_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hideborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hide the border around the main " .. MONKEYQUEST_TITLE .. " frame.\n"
MONKEYQUEST_HELP_SHOWBORDER_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Show the border around the main " .. MONKEYQUEST_TITLE .. " frame.\n"
MONKEYQUEST_HELP_GROWUP_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest growup\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Makes the main " .. MONKEYQUEST_TITLE .. " frame expand upwards.\n"
MONKEYQUEST_HELP_GROWDOWN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest growdown\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Makes the main " .. MONKEYQUEST_TITLE .. " frame expand downwards.\n"
MONKEYQUEST_HELP_HIDENUMQUESTS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidenumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hide the number of quests next to the title.\n"
MONKEYQUEST_HELP_SHOWNUMQUESTS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest shownumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Show the number of quests next to the title.\n"
MONKEYQUEST_HELP_LOCK_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest lock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Locks the " .. MONKEYQUEST_TITLE .. " frame in place.\n"
MONKEYQUEST_HELP_UNLOCK_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest unlock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Unlocks the " .. MONKEYQUEST_TITLE .. " frame, making it movable.\n"
MONKEYQUEST_HELP_COLOURTITLEON_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest colourtitleon\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Uses the difficulty to colour the entier quest title.\n"
MONKEYQUEST_HELP_COLOURTITLEOFF_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest colourtitleoff\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Doesn't colour the entier quest title by difficulty.\n"
MONKEYQUEST_HELP_HIDECOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidecompletedquests\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Hides completed quests.\n"
MONKEYQUEST_HELP_SHOWCOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showcompletedquests\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Shows completed quests.\n"
MONKEYQUEST_HELP_HIDECOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidecompletedobjectives\n" ..
												  MONKEYQUEST_CHAT_COLOUR .. "Hides completed objectives.\n"
MONKEYQUEST_HELP_SHOWCOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showcompletedobjectives\n" ..
												  MONKEYQUEST_CHAT_COLOUR .. "Shows completed objectives.\n"
MONKEYQUEST_HELP_FONTHEIGHT_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest fontheight=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the font height to the specified value, the default is 12.\n"
MONKEYQUEST_HELP_SHOWTOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showtooltipobjectives\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Adds a line to the tooltip which shows the completeness of that quest objective.\n"
MONKEYQUEST_HELP_HIDETOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidetooltipobjectives\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Does not add a line to the tooltip about the completeness of that quest objective.\n"
MONKEYQUEST_HELP_ALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest allowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Allows you to right-click to open MonkeyBuddy.\n"
MONKEYQUEST_HELP_DISALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest disallowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Disallows you from right-clicking to open MonkeyBuddy.\n"
MONKEYQUEST_HELP_HIDETITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidetitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hides the title buttons.\n"
MONKEYQUEST_HELP_SHOWTITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showtitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Shows the title buttons.\n"
MONKEYQUEST_HELP_ALLOWWORKCOMPLETE_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest allowworkcomplete\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Enables >work complete< sound.\n"
MONKEYQUEST_HELP_DISALLOWWORKCOMPLETE_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest disallowworkcomplete\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Disables >work complete< sound.\n"

-- tooltip strings
MONKEYQUEST_TOOLTIP_QUESTITEM			= "Quest Item"					-- as it appears in the tooltip of unique quest items
MONKEYQUEST_TOOLTIP_QUEST				= "Quest"
MONKEYQUEST_TOOLTIP_SLAIN				= "slain"						-- as it appears in the objective text

-- misc quest strings
MONKEYQUEST_DUNGEON						= "Dungeon"
MONKEYQUEST_PVP							= "PvP"

-- noob tips
MONKEYQUEST_NOOBTIP_HEADER				= "Noob Tip:"

MONKEYQUEST_NOOBTIP_CLOSE				= "Click here to close the main frame. To get it back try:"
MONKEYQUEST_NOOBTIP_MINIMIZE			= "Click here to minimize the main frame"
MONKEYQUEST_NOOBTIP_RESTORE				= "Click here to restore the main frame"
MONKEYQUEST_NOOBTIP_SHOWALLHIDDEN		= "Click here to show all hidden items"
MONKEYQUEST_NOOBTIP_HIDEALLHIDDEN		= "Click here to hide all hidden items"
MONKEYQUEST_NOOBTIP_HIDEBUTTON			= "Click here to hide this quest. Activate 'Show all hidden items' to see this quest again"
MONKEYQUEST_NOOBTIP_TITLE				= "Right Click here to open MonkeyBuddy so you can configure " .. MONKEYQUEST_TITLE
MONKEYQUEST_NOOBTIP_QUESTHEADER			= "Click here to hide/show all the quests under this zone. Activate 'Show all hidden items' to show zone headers you've hidden."

-- bindings
BINDING_NAME_MONKEYQUEST_CLOSE			= "Close/Open"
BINDING_NAME_MONKEYQUEST_MINIMIZE		= "Minimize/Restore"
BINDING_NAME_MONKEYQUEST_HIDDEN			= "Hide/Show all hidden items"
BINDING_NAME_MONKEYQUEST_NOHEADERS		= "Toggle No Headers"

if ( GetLocale() == "frFR" ) then

MONKEYQUEST_DESCRIPTION					= "Affiche vos quêtes pour un aperçu rapide."
MONKEYQUEST_LOADED_MSG					= MONKEYQUEST_INFO_COLOUR .. MONKEYQUEST_TITLE .. " v" .. MONKEYQUEST_VERSION .. " chargé"
--MONKEYQUEST_OPTIONS1					= "Please install MonkeyBuddy to configure your MonkeyQuest easily."
--MONKEYQUEST_OPTIONS2					= "\124TInterface\\Icons\\Trade_Engineering:0\124t MonkeyBuddy is currently not installed."

MONKEYQUEST_QUEST_DONE					= "Terminée"
--MONKEYQUEST_QUEST_FAILED				= "failed"
MONKEYQUEST_CONFIRM_RESET				= "Ok pour remettre les options " .. MONKEYQUEST_TITLE .. " à leurs valeurs par défaut ?"

MONKEYQUEST_SET_WIDTH_MSG				= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. " : Vous aurez peut être besoin de '/console reloadui' pour voir les changements de la largeur."
MONKEYQUEST_RESET_MSG					= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. " : Options remises à zero."

MONKEYQUEST_HELP_MSG					= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest help <command>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Où <command> est une des suivantes : \n" ..
										  "reset, open, close, showhidden, hidehidden, useoverviews, nooverviews, " ..
										  "tipanchor, alpha, width, hideheaders, showheaders, hideborder, showborder, " ..
										  "growup, growdown, hidenumquests, shownumquests, lock, unlock, colourtitleon, " ..
										  "colourtitleoff, hidecompletedquests, showcompletedquests, hidecompletedobjectives, " ..
										  "showcompletedobjectives."
MONKEYQUEST_HELP_RESET_MSG				= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest reset\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Affiche le dialogue de remise à zero des options.\n"
MONKEYQUEST_HELP_OPEN_MSG				= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest open\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Ouvre la fenêtre " .. MONKEYQUEST_TITLE .. ".\n"
MONKEYQUEST_HELP_CLOSE_MSG				= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest close\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Ferme la fenêtre " .. MONKEYQUEST_TITLE .. ".\n"
MONKEYQUEST_HELP_SHOWHIDDEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest showhidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Montrer les noms de zone et les quêtes cachées.\n"
MONKEYQUEST_HELP_HIDEHIDDEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest hidehidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Cacher les noms de zone et les quêtes cachées.\n"
MONKEYQUEST_HELP_USEOVERVIEWS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest useoverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Montrer la description quand il n'y a pas d'objectifs.\n"
MONKEYQUEST_HELP_NOOVERVIEWS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest nooverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Ne pas montrer la description quand il n'y a pas d'objectifs.\n"
MONKEYQUEST_HELP_TIPANCHOR_MSG			= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest tipanchor=<anchor position>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Fixer le point d'ancrage du tooltip où <anchor position> " .. 
										  "peut être un des suivants :\nANCHOR_TOPLEFT, ANCHOR_TOPRIGHT, ANCHOR_TOP, ANCHOR_LEFT, " ..
										  "ANCHOR_RIGHT, ANCHOR_BOTTOMLEFT, ANCHOR_BOTTOMRIGHT, ANCHOR_BOTTOM, ANCHOR_CURSOR, " .. 
										  "DEFAULT, NONE"
MONKEYQUEST_HELP_ALPHA_MSG				= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest alpha=<0 - 255>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Fixer l'Alpha à la valeur spécifiée.\n"
MONKEYQUEST_HELP_WIDTH_MSG				= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest width=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Fixer la largeur à la valeur spécifiée, 255 par défaut. " .. 
										  "Nécessite de '/console reloadui' pour prendre effet.\n"
MONKEYQUEST_HELP_HIDEHEADERS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest hideheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Cacher les noms de zone.\n"
MONKEYQUEST_HELP_SHOWHEADERS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest showheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Montrer les noms de zone.\n"
MONKEYQUEST_HELP_HIDEBORDER_MSG			= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest hideborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Cacher les bords de la fenêtre " .. MONKEYQUEST_TITLE .. ".\n"
MONKEYQUEST_HELP_SHOWBORDER_MSG			= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest showborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Montrer les bords de la fenêtre " .. MONKEYQUEST_TITLE .. ".\n"
MONKEYQUEST_HELP_GROWUP_MSG				= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest growup\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Augmenter la fenêtre " .. MONKEYQUEST_TITLE .. " vers le haut.\n"
MONKEYQUEST_HELP_GROWDOWN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest growdown\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Augmenter la fenêtre " .. MONKEYQUEST_TITLE .. " vers le bas.\n"
MONKEYQUEST_HELP_HIDENUMQUESTS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest hidenumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Cacher le nombre de quêtes.\n"
MONKEYQUEST_HELP_SHOWNUMQUESTS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest shownumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Montrer le nombre de quêtes.\n"
MONKEYQUEST_HELP_LOCK_MSG				= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest lock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Bloquer la fenêtre " .. MONKEYQUEST_TITLE .. ".\n"
MONKEYQUEST_HELP_UNLOCK_MSG				= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest unlock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Débloquer la fenêtre " .. MONKEYQUEST_TITLE .. ", la rend mobile.\n"
MONKEYQUEST_HELP_COLOURTITLEON_MSG		= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest colourtitleon\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Colorer les titres de quêtes selon la difficulté.\n"
MONKEYQUEST_HELP_COLOURTITLEOFF_MSG		= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest colourtitleoff\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Ne pas colorer les titres de quêtes selon la difficulté.\n"
MONKEYQUEST_HELP_HIDECOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest hidecompletedquests\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Cacher les quêtes terminées.\n"
MONKEYQUEST_HELP_SHOWCOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest showcompletedquests\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Montrer les quêtes terminées.\n"
MONKEYQUEST_HELP_HIDECOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest hidecompletedobjectives\n" ..
												  MONKEYQUEST_CHAT_COLOUR .. "Cacher les objectifs terminés.\n"
MONKEYQUEST_HELP_SHOWCOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest showcompletedobjectives\n" ..
												  MONKEYQUEST_CHAT_COLOUR .. "Montrer les objectifs terminés.\n"								
MONKEYQUEST_HELP_FONTHEIGHT_MSG			= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest fontheight=<entier positif>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Fixe la taille de la police de caractères, 12 par défaut.\n"
MONKEYQUEST_HELP_SHOWTOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest showtooltipobjectives\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Ajoute une ligne au tooltip qui montre l'avancement de cet objectif de quête.\n"
MONKEYQUEST_HELP_HIDETOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest hidetooltipobjectives\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Retire la ligne du tooltip qui montre l'avancement de cet objectif de quête.\n"
MONKEYQUEST_HELP_ALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest allowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Vous permet de faire un clic droit pour ouvrir MonkeyBuddy.\n"
MONKEYQUEST_HELP_DISALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest disallowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Désactive le clic droit pour ouvrir MonkeyBuddy.\n"
MONKEYQUEST_HELP_HIDETITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest hidetitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Cacher les boutons de titre.\n"
MONKEYQUEST_HELP_SHOWTITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest showtitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Montrer les boutons de titre.\n"
--MONKEYQUEST_HELP_ALLOWWORKCOMPLETE_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest allowworkcomplete\n" ..
--										  MONKEYQUEST_CHAT_COLOUR .. "Enables >work complete< sound.\n"
--MONKEYQUEST_HELP_DISALLOWWORKCOMPLETE_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest disallowworkcomplete\n" ..
--											  MONKEYQUEST_CHAT_COLOUR .. "Disables >work complete< sound.\n"

-- tooltip strings
MONKEYQUEST_TOOLTIP_QUESTITEM			= "Objet de quête"				-- as it appears in the tooltip of unique quest items
MONKEYQUEST_TOOLTIP_QUEST				= "Quête"
MONKEYQUEST_TOOLTIP_SLAIN				= "morts"						-- as it appears in the objective text

-- misc quest strings
MONKEYQUEST_DUNGEON						= "Donjon"
MONKEYQUEST_PVP							= "JcJ"

-- noob tips
--MONKEYQUEST_NOOBTIP_HEADER				= "Noob Tip:"

--MONKEYQUEST_NOOBTIP_CLOSE				= "Click here to close the main frame. To get it back try:"
--MONKEYQUEST_NOOBTIP_MINIMIZE			= "Click here to minimize the main frame"
--MONKEYQUEST_NOOBTIP_RESTORE				= "Click here to restore the main frame"
--MONKEYQUEST_NOOBTIP_SHOWALLHIDDEN		= "Click here to show all hidden items"
--MONKEYQUEST_NOOBTIP_HIDEALLHIDDEN		= "Click here to hide all hidden items"
--MONKEYQUEST_NOOBTIP_HIDEBUTTON			= "Click here to hide this quest. Activate 'Show all hidden items' to see this quest again"
--MONKEYQUEST_NOOBTIP_TITLE				= "Right Click here to open MonkeyBuddy so you can configure " .. MONKEYQUEST_TITLE
--MONKEYQUEST_NOOBTIP_QUESTHEADER			= "Click here to hide/show all the quests under this zone. Activate 'Show all hidden items' to show zone headers you've hidden."

-- bindings
BINDING_NAME_MONKEYQUEST_CLOSE			= "Fermer/Open"
BINDING_NAME_MONKEYQUEST_MINIMIZE		= "Réduire/Restore"
BINDING_NAME_MONKEYQUEST_HIDDEN			= "Hide/Montrer les quêtes cachées"
BINDING_NAME_MONKEYQUEST_NOHEADERS		= "Afficher/Masquer Headers"

elseif (GetLocale() == "ruRU") then

MONKEYQUEST_DESCRIPTION					= "Отображает ваши задания для быстрого просмотра."
MONKEYQUEST_LOADED_MSG					= MONKEYQUEST_INFO_COLOUR .. MONKEYQUEST_TITLE .. " v" .. MONKEYQUEST_VERSION .. " загрузка"
MONKEYQUEST_OPTIONS1					= "Пожалуйста, установите MonkeyBuddy, чтобы легко настроить MonkeyQuest."
MONKEYQUEST_OPTIONS2					= "\124TInterface\\Icons\\Trade_Engineering:0\124t MonkeyBuddy в настоящее время не установлен."

MONKEYQUEST_NO_HEADER					= "Нет заголовка"
MONKEYQUEST_QUEST_DONE					= "сделанный"
MONKEYQUEST_QUEST_FAILED				= "не удалось"
MONKEYQUEST_CONFIRM_RESET				= "Хорошо, чтобы сбросить " .. MONKEYQUEST_TITLE .. " настройки по умолчанию?"
MONKEYQUEST_CONFIRM_RESET_TO_BLIZZARD_STYLE				= "Хорошо, чтобы установить " .. MONKEYQUEST_TITLE .. " настройки в стиле квест-трекера Blizzard?"

MONKEYQUEST_SET_WIDTH_MSG				= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": Вам может понадобиться '/console reloadui' чтобы увидеть изменения в ширине."
MONKEYQUEST_RESET_MSG					= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": Сброс настроек."
MONKEYQUEST_RESET_TO_BLIZZARD_STYLE_MSG	= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": В настройках Blizzard установлен стиль заданий."

MONKEYQUEST_HELP_MSG					= MONKEYQUEST_INFO_COLOUR .. "Команды: /mquest help <command>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Где <command> отвечает за: \n" ..
										  "reset, open, close, showhidden, hidehidden, useoverviews, nooverviews, " ..
										  "tipanchor, alpha, width, hideheaders, showheaders, hideborder, showborder, " ..
										  "growup, growdown, hidenumquests, shownumquests, lock, unlock, colourtitleon, " ..
										  "colourtitleoff, hidecompletedquests, showcompletedquests, hidecompletedobjectives, " ..
										  "showcompletedobjectives, fontheight, showtooltipobjectives, hidetootipobjectives, " ..
										  "allowrightclick, disallowrightclick, hidetitlebuttons, showtitlebuttons, allowworkcomplete, disallowworkcomplete, " ..
										  "colourobjectiveson, colourobjectivesoff, showitems, hideitems, itemsonleft, itemsonright, hideviaclick, nohideviaclick."
MONKEYQUEST_HELP_RESET_MSG				= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest reset\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Отображает диалог сброса переменных конфигурации.\n"
MONKEYQUEST_HELP_OPEN_MSG				= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest open\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Показывает основное " .. MONKEYQUEST_TITLE .. " окно.\n"
MONKEYQUEST_HELP_CLOSE_MSG				= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest close\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Скрывает основное " .. MONKEYQUEST_TITLE .. " окно.\n"
MONKEYQUEST_HELP_SHOWHIDDEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest showhidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Показывает свернутые заголовки зоны и скрытые задания.\n"
MONKEYQUEST_HELP_HIDEHIDDEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest hidehidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Скрывает свернутые заголовки зон и скрытые задания.\n"
MONKEYQUEST_HELP_USEOVERVIEWS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest useoverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Отображает обзор заданий для заданий без целей.\n"
MONKEYQUEST_HELP_NOOVERVIEWS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest nooverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Скрывает обзор заданий для заданий без целей.\n"
MONKEYQUEST_HELP_TIPANCHOR_MSG			= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest tipanchor=<anchor position>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Устанавливает точку привязки всплывающей подсказки, где <anchor position> " .. 
										  "может быть в любом из следующих:\nANCHOR_TOPLEFT, ANCHOR_TOPRIGHT, ANCHOR_TOP, ANCHOR_LEFT, " ..
										  "ANCHOR_RIGHT, ANCHOR_BOTTOMLEFT, ANCHOR_BOTTOMRIGHT, ANCHOR_BOTTOM, ANCHOR_CURSOR, " .. 
										  "DEFAULT, NONE"
MONKEYQUEST_HELP_ALPHA_MSG				= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest alpha=<0 - 255>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Устанавливает прозрачность фона на указанное значение.\n"
MONKEYQUEST_HELP_WIDTH_MSG				= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest width=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Устанавливает ширину в указанное значение, по умолчанию 255.\n"
MONKEYQUEST_HELP_HIDEHEADERS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest hideheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Скрывает отображение заголовок зон.\n"
MONKEYQUEST_HELP_SHOWHEADERS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest showheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Показывает отображение заголовок зон.\n"
MONKEYQUEST_HELP_HIDEBORDER_MSG			= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest hideborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Скрывает границу вокруг главного " .. MONKEYQUEST_TITLE .. " окна.\n"
MONKEYQUEST_HELP_SHOWBORDER_MSG			= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest showborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Отображает границу вокруг главного " .. MONKEYQUEST_TITLE .. " окна.\n"
MONKEYQUEST_HELP_GROWUP_MSG				= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest growup\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Заставляет " .. MONKEYQUEST_TITLE .. " главное окно двигатся вверх.\n"
MONKEYQUEST_HELP_GROWDOWN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest growdown\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Заставляет " .. MONKEYQUEST_TITLE .. " главное окно двигатся вниз.\n"
MONKEYQUEST_HELP_HIDENUMQUESTS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest hidenumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Скрыть количество заданий рядом с названием.\n"
MONKEYQUEST_HELP_SHOWNUMQUESTS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest shownumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Показать количество заданий рядом с названием.\n"
MONKEYQUEST_HELP_LOCK_MSG				= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest lock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Заблокировать " .. MONKEYQUEST_TITLE .. " окно на месте.\n"
MONKEYQUEST_HELP_UNLOCK_MSG				= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest unlock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Разблокировать " .. MONKEYQUEST_TITLE .. " окно, делая его подвижным.\n"
MONKEYQUEST_HELP_COLOURTITLEON_MSG		= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest colourtitleon\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Окрашивает задания исходя из сложности при выполнении.\n"
MONKEYQUEST_HELP_COLOURTITLEOFF_MSG		= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest colourtitleoff\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Не окрашивает задания по сложности.\n"
MONKEYQUEST_HELP_HIDECOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest hidecompletedquests\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Скрывает выполненные задания.\n"
MONKEYQUEST_HELP_SHOWCOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest showcompletedquests\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Показывает выполненные задания.\n"
MONKEYQUEST_HELP_HIDECOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest hidecompletedobjectives\n" ..
												  MONKEYQUEST_CHAT_COLOUR .. "Скрывает выполненные задачи.\n"
MONKEYQUEST_HELP_SHOWCOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest showcompletedobjectives\n" ..
												  MONKEYQUEST_CHAT_COLOUR .. "Показывает выполненные задачи.\n"
MONKEYQUEST_HELP_FONTHEIGHT_MSG			= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest fontheight=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Устанавливает высоту шрифта в указанное значение, по умолчанию 12.\n"
MONKEYQUEST_HELP_SHOWTOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest showtooltipobjectives\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Добавляет строку во всплывающую подсказку, которая отображает описание к этой цели задания.\n"
MONKEYQUEST_HELP_HIDETOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest hidetooltipobjectives\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Не добавляет строку во всплывающую подсказку, которая отображает описание к этой цели задания.\n"
MONKEYQUEST_HELP_ALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest allowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Позволяет по нажатию ПКМ открыть MonkeyBuddy.\n"
MONKEYQUEST_HELP_DISALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest disallowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Не позволяет по нажатию ПКМ открыть MonkeyBuddy.\n"
MONKEYQUEST_HELP_HIDETITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest hidetitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Скрывает кнопки заголовка.\n"
MONKEYQUEST_HELP_SHOWTITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest showtitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Показывает кнопки заголовка.\n"
MONKEYQUEST_HELP_ALLOWWORKCOMPLETE_MSG	= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest allowworkcomplete\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Включить >работа завершена< звук.\n"
MONKEYQUEST_HELP_DISALLOWWORKCOMPLETE_MSG	= MONKEYQUEST_INFO_COLOUR .. "Команда: /mquest disallowworkcomplete\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Отключить >работа завершена< звук.\n"

-- tooltip strings
MONKEYQUEST_TOOLTIP_QUESTITEM			= "Предмет Задания"					-- as it appears in the tooltip of unique quest items
MONKEYQUEST_TOOLTIP_QUEST				= "Задание"
MONKEYQUEST_TOOLTIP_SLAIN				= "убитый"						-- as it appears in the objective text

-- misc quest strings
MONKEYQUEST_DUNGEON						= "Подземелье"
MONKEYQUEST_PVP							= "PvP"

-- noob tips
MONKEYQUEST_NOOBTIP_HEADER				= "Подсказки для Новичка:"

MONKEYQUEST_NOOBTIP_CLOSE				= "Нажмите здесь, чтобы закрыть основное окно. Чтобы вернуть его попробуйте:"
MONKEYQUEST_NOOBTIP_MINIMIZE			= "Нажмите здесь, чтобы свернуть основное окно"
MONKEYQUEST_NOOBTIP_RESTORE				= "Нажмите здесь, чтобы восстановить основное окно"
MONKEYQUEST_NOOBTIP_SHOWALLHIDDEN		= "Нажмите здесь, чтобы показать все скрытые предметы"
MONKEYQUEST_NOOBTIP_HIDEALLHIDDEN		= "Нажмите здесь, чтобы скрыть все скрытые предметы"
MONKEYQUEST_NOOBTIP_HIDEBUTTON			= "Нажмите здесь, чтобы скрыть это задание. Активируйте 'Показать все скрытые предметы', чтобы увидеть это задание снова"
MONKEYQUEST_NOOBTIP_TITLE				= "Нажмите ПКМ здесь, чтобы открыть MonkeyBuddy, чтобы вы могли настроить " .. MONKEYQUEST_TITLE
MONKEYQUEST_NOOBTIP_QUESTHEADER			= "Нажмите здесь, чтобы скрыть/показать все задания в этой зоне. Активируйте 'Показать все скрытые предметы', чтобы показать скрытые заголовки зон."

-- bindings
BINDING_NAME_MONKEYQUEST_CLOSE			= "Закрыто/Открыто"
BINDING_NAME_MONKEYQUEST_MINIMIZE		= "Свернуть/Восстановить"
BINDING_NAME_MONKEYQUEST_HIDDEN			= "Скрыть/Показать все скрытые предметы"
BINDING_NAME_MONKEYQUEST_NOHEADERS		= "Переключить без заголовков"

elseif (GetLocale() == "deDE") then

MONKEYQUEST_DESCRIPTION					= "Stellt Quests in einer kompakten \195\156bersicht dar."
MONKEYQUEST_LOADED_MSG					= MONKEYQUEST_INFO_COLOUR .. MONKEYQUEST_TITLE .. " v" .. MONKEYQUEST_VERSION .. " geladen"
MONKEYQUEST_OPTIONS1					= "Bitte installiere MonkeyBuddy um dein MonkeyQuest einzustellen."
MONKEYQUEST_OPTIONS2					= "\124TInterface\\Icons\\Trade_Engineering:0\124t MonkeyBuddy ist derzeit nicht installiert."

MONKEYQUEST_NO_HEADER					= "Keine Region"
MONKEYQUEST_QUEST_DONE					= "fertig"
MONKEYQUEST_QUEST_FAILED				= "fehlgeschlagen"
MONKEYQUEST_CONFIRM_RESET				= "Die Einstellungen von " .. MONKEYQUEST_TITLE .. " wirklich zur\195\188cksetzen?"

MONKEYQUEST_RESET_MSG					= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": Einstellungen zur\195\188ckgesetzt."
MONKEYQUEST_SET_WIDTH_MSG				= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": Um \195\134nderungen an der Breite wirksam werden zu lassen, m\195\188ssen Sie '/console reloadui' ausf\195\188hren."

MONKEYQUEST_HELP_MSG					= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest help <Kommando>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Anzeigen der Hilfe, wobei <Kommando> eines der folgenden sein kann: \n" ..
										  "reset, open, close, showhidden, hidehidden, useoverviews, nooverviews, " ..
										  "tipanchor, alpha, width, hideheaders, showheaders, hideborder, showborder, " ..
										  "growup, growdown, hidenumquests, shownumquests, lock, unlock, colourtitleon, " ..
										  "colourtitleoff, hidecompletedquests, showcompletedquests, hidecompletedobjectives, " ..
										  "showcompletedobjectives, fontheight, showtooltipobjectives, hidetootipobjectives, " ..
										  "allowrightclick, disallowrightclick, hidetitlebuttons, showtitlebuttons, allowworkcomplete, disallowworkcomplete, " ..
										  "colourobjectiveson, colourobjectivesoff, showitems, hideitems, itemsonleft, itemsonright, hideviaclick, nohideviaclick."
MONKEYQUEST_HELP_RESET_MSG				= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest reset\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Zur\195\188cksetzen der Einstellungen auf die Werkseinstellung\n"
MONKEYQUEST_HELP_OPEN_MSG				= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest open\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "\195\150ffnen des " .. MONKEYQUEST_TITLE .. " Fensters\n"
MONKEYQUEST_HELP_CLOSE_MSG				= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest close\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Schlie\195\159en des " .. MONKEYQUEST_TITLE .. " Fensters\n"
MONKEYQUEST_HELP_SHOWHIDDEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest showhidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Anzeigen aller, auch ausgeblendeter Quests\n"
MONKEYQUEST_HELP_HIDEHIDDEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest hidehidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Ausblenden entsprechend markierter Quests\n"
MONKEYQUEST_HELP_USEOVERVIEWS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest useoverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Anzeigen der Questzusammenfassung bei Quests, die keine Sammel- oder Killquest sind\n"
MONKEYQUEST_HELP_NOOVERVIEWS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest nooverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Kein Anzeigen der Questzusammenfassung bei Quests, die keine Sammel- oder Killquest sind\n"
MONKEYQUEST_HELP_TIPANCHOR_MSG			= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest tipanchor=<Ankerposition>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Festlegen der Tooltip-Position. M\195\182gliche Werte f\195\188r <Ankerposition> sind \n" ..
										  "ANCHOR_TOPLEFT, ANCHOR_TOPRIGHT, ANCHOR_TOP, ANCHOR_LEFT, " ..
										  "ANCHOR_RIGHT, ANCHOR_BOTTOMLEFT, ANCHOR_BOTTOMRIGHT, ANCHOR_BOTTOM, ANCHOR_CURSOR, " ..
										  "DEFAULT, NONE"
MONKEYQUEST_HELP_ALPHA_MSG				= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest alpha=<0 - 255>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Festlegen der Transparenz des Fensters, mu\195\159 eine positive Ganzzahl sein. 0 ist komplett transparent, 255 komplett undurchsichtig\n"
MONKEYQUEST_HELP_WIDTH_MSG				= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest width=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Festlegen der Fensterbreite, Standardwert ist 225, mu\195\159 eine positive Ganzzahl sein. Um die \195\134nderung sichtbar zu machen, mu\195\159 die Oberfl\195\164che \195\188ber das Kommando /console reloadui neu geladen werden\n"
MONKEYQUEST_HELP_SHOWHEADERS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest showheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Einblenden der Namen der Regionen\n"
MONKEYQUEST_HELP_HIDEHEADERS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest hideheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Ausblenden der Namen der Regionen\n"
MONKEYQUEST_HELP_HIDEBORDER_MSG			= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest hideborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Kein Zeichnen eines Rahmens um das Fenster\n"
MONKEYQUEST_HELP_SHOWBORDER_MSG			= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest showborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Zeichnen eines Rahmens um das Fenster\n"
MONKEYQUEST_HELP_GROWUP_MSG				= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest growup\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Festlegung, da\195\159 sich das Fenster nach oben hin erweitert, wenn eine neue Quest angenommen wird\n"
MONKEYQUEST_HELP_GROWDOWN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest growdown\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Festlegung, da\195\159 sich das Fenster nach unten hin erweitert, wenn eine neue Quest angenommen wird\n"
MONKEYQUEST_HELP_HIDENUMQUESTS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest hidenumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Keine Anzeige der Anzahl der angenommenen Quests\n"
MONKEYQUEST_HELP_SHOWNUMQUESTS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest shownumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Anzeige der Anzahl der angenommenen Quests\n"
MONKEYQUEST_HELP_LOCK_MSG				= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest lock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Fixierung des Fensters\n"
MONKEYQUEST_HELP_UNLOCK_MSG				= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest unlock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Aufhebung der Fixierung des Fensters\n"
MONKEYQUEST_HELP_COLOURTITLEON_MSG		= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest colourtitleon\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Farbliche Kodierung der Quests nach ihrem Schwierigkeitsgrad\n"
MONKEYQUEST_HELP_COLOURTITLEOFF_MSG		= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest colourtitleoff\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Keine farbliche Kodierung der Quests nach ihrem Schwierigkeitsgrad\n"
MONKEYQUEST_HELP_HIDECOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest hidecompletedquests\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Versteckt alle Quests.\n"
MONKEYQUEST_HELP_SHOWCOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest showcompletedquests\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Zeigt alle Quests.\n"
MONKEYQUEST_HELP_HIDECOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest hidecompletedobjectives\n" ..
												  MONKEYQUEST_CHAT_COLOUR .. "Versteckt alle Questziele.\n"
MONKEYQUEST_HELP_SHOWCOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest showcompletedobjectives\n" ..
												  MONKEYQUEST_CHAT_COLOUR .. "Zeigt alle Questziele.\n"
MONKEYQUEST_HELP_FONTHEIGHT_MSG 		= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest fontheight=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Stellt die Schriftgr\195\182sse ein, Standard ist 12.\n"
MONKEYQUEST_HELP_SHOWTOOLTIPOBJECTIVES_MSG 	= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest showtooltipobjectives\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "F\195\188gt den Tooltips eine Info hinzu, welche die Vollst\195\164ndigkeit der jeweiligen Questziele anzeigt.\n"
MONKEYQUEST_HELP_HIDETOOLTIPOBJECTIVES_MSG 	= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest hidetooltipobjectives\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "F\195\188gt den Tooltips keine Info hinzu, welche die Vollst\195\164ndigkeit der jeweiligen Questziele anzeigen w\195\188rde.\n"
MONKEYQUEST_HELP_ALLOWRIGHTCLICK_MSG 	= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest allowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Erm\195\182glicht dir MonkeyBuddy mit Rechtsklick zu \195\182ffnen.\n"
MONKEYQUEST_HELP_DISALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest disallowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Erm\195\182glicht dir nicht MonkeyBuddy mit Rechtsklick zu \195\182ffnen.\n"
MONKEYQUEST_HELP_HIDETITLEBUTTONS_MSG 	= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest hidetitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Versteckt die Titel-Buttons.\n"
MONKEYQUEST_HELP_SHOWTITLEBUTTONS_MSG 	= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest showtitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Zeigt die Titel-Buttons.\n"
MONKEYQUEST_HELP_ALLOWWORKCOMPLETE_MSG	= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest allowworkcomplete\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Aktiviert >Arbeit erledigt< Sound.\n"
MONKEYQUEST_HELP_DISALLOWWORKCOMPLETE_MSG	= MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest disallowworkcomplete\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Deaktiviert >Arbeit erledigt< Sound.\n"

-- tooltip strings
MONKEYQUEST_TOOLTIP_QUESTITEM			= "Questgegenstand"				-- as it appears in the tooltip of unique quest items
MONKEYQUEST_TOOLTIP_QUEST				= "Quest"
MONKEYQUEST_TOOLTIP_SLAIN				= "get\195\182tet"				-- as it appears in the objective text

-- misc quest strings
MONKEYQUEST_DUNGEON						= "Dungeon"
MONKEYQUEST_PVP							= "PvP"

-- noob tips
MONKEYQUEST_NOOBTIP_HEADER				= "Anf\195\164nger Info:"

MONKEYQUEST_NOOBTIP_CLOSE				= "Klicke hier um das Hauptfenster zu schlie\195\159en. R\195\188ckg\195\164ngig durch:"
MONKEYQUEST_NOOBTIP_MINIMIZE			= "Klicke hier um das Hauptfenster zu minimieren"
MONKEYQUEST_NOOBTIP_RESTORE				= "Klicke hier um das Hauptfenster wiederherzustellen"
MONKEYQUEST_NOOBTIP_SHOWALLHIDDEN		= "Klicke hier um ausgeblendete Elemente anzuzeigen"
MONKEYQUEST_NOOBTIP_HIDEALLHIDDEN		= "Klicke hier um ausgeblendete Elemente zu verbergen"
MONKEYQUEST_NOOBTIP_HIDEBUTTON			= "Klicke hier um den Quest auszublenden. Aktiviere 'Zeige ausgeblendete Elemente' um den Quest wieder einzublenden"
MONKEYQUEST_NOOBTIP_TITLE				= "Rechtsklick erm\195\182glicht es dir MonkeyBuddy zu \195\182ffnen und so " .. MONKEYQUEST_TITLE .. " zu konfigurieren"
MONKEYQUEST_NOOBTIP_QUESTHEADER			= "Klicke hier um alle Quests dieser Zone ein/auszublenden. Aktiviere 'Zeige ausgeblendete Elemente' um ausgeblendete Questzonen wieder einzublenden."

-- bindings
BINDING_NAME_MONKEYQUEST_CLOSE			= "Schlie\195\159en/\195\150ffnen"
BINDING_NAME_MONKEYQUEST_MINIMIZE		= "Minimieren/Wiederherstellen"
BINDING_NAME_MONKEYQUEST_HIDDEN			= "Ausgeblentete Elemente ein/ausblenden"
BINDING_NAME_MONKEYQUEST_NOHEADERS		= "Verberge Questzonen"

elseif (GetLocale() == "esES") then

MONKEYQUEST_QUEST_DONE					= "hecho"
MONKEYQUEST_CONFIRM_RESET				= "Vale para reset " .. MONKEYQUEST_TITLE .. " settings to default values?"
MONKEYQUEST_SET_WIDTH_MSG				= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": Tu puedes necesitar de '/console reloadui' para ver los cambios."
MONKEYQUEST_RESET_MSG					= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": Opciones reseteadas."
MONKEYQUEST_HELP_MSG					= MONKEYQUEST_INFO_COLOUR .. "Comando: /mquest help <command>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Cuando <command> is any of the following: \n" ..
										  "reset, open, close, showhidden, hidehidden, useoverviews, nooverviews, " ..
										  "tipanchor, alpha, width, hideheaders, showheaders, hideborder, showborder, " ..
										  "growup, growdown, hidenumquests, shownumquests, lock, unlock, colourtitleon, " ..
										  "colourtitleoff, hidecompletedquests, showcompletedquests, hidecompletedobjectives, " ..
										  "showcompletedobjectives, fontheight, showtooltipobjectives, hidetootipobjectives, " ..
										  "allowrightclick, disallowrightclick, hidetitlebuttons, showtitlebuttons."
MONKEYQUEST_HELP_RESET_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest reset\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Displays the reset config variables dialog.\n"
MONKEYQUEST_HELP_OPEN_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest open\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Shows the main " .. MONKEYQUEST_TITLE .. " frame.\n"
MONKEYQUEST_HELP_CLOSE_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest close\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hides the main " .. MONKEYQUEST_TITLE .. " frame.\n"
MONKEYQUEST_HELP_SHOWHIDDEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showhidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Shows collapsed zone headers and hidden quests.\n"
MONKEYQUEST_HELP_HIDEHIDDEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidehidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hides collapsed zone headers and hidden quests.\n"
MONKEYQUEST_HELP_USEOVERVIEWS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest useoverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Displays the quest overview for quests without objectives.\n"
MONKEYQUEST_HELP_NOOVERVIEWS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest nooverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Don't display the quest overview for quests without objectives.\n"
MONKEYQUEST_HELP_TIPANCHOR_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest tipanchor=<anchor position>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the anchor point of the tooltip where <anchor position> " .. 
										  "can be any of the following:\nANCHOR_TOPLEFT, ANCHOR_TOPRIGHT, ANCHOR_TOP, ANCHOR_LEFT, " ..
										  "ANCHOR_RIGHT, ANCHOR_BOTTOMLEFT, ANCHOR_BOTTOMRIGHT, ANCHOR_BOTTOM, ANCHOR_CURSOR, " .. 
										  "DEFAULT, NONE"
MONKEYQUEST_HELP_ALPHA_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest alpha=<0 - 255>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the backdrop alpha to the specified value.\n"
MONKEYQUEST_HELP_WIDTH_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest width=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the width to the specified value, the default is 255.\n"
MONKEYQUEST_HELP_HIDEHEADERS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hideheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Never display any zone headers.\n"
MONKEYQUEST_HELP_SHOWHEADERS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Display zone headers.\n"
MONKEYQUEST_HELP_HIDEBORDER_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hideborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hide the border around the main " .. MONKEYQUEST_TITLE .. " frame.\n"
MONKEYQUEST_HELP_SHOWBORDER_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Show the border around the main " .. MONKEYQUEST_TITLE .. " frame.\n"
MONKEYQUEST_HELP_GROWUP_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest growup\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Makes the main " .. MONKEYQUEST_TITLE .. " frame expand upwards.\n"
MONKEYQUEST_HELP_GROWDOWN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest growdown\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Makes the main " .. MONKEYQUEST_TITLE .. " frame expand downwards.\n"
MONKEYQUEST_HELP_HIDENUMQUESTS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidenumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hide the number of quests next to the title.\n"
MONKEYQUEST_HELP_SHOWNUMQUESTS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest shownumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Show the number of quests next to the title.\n"
MONKEYQUEST_HELP_LOCK_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest lock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Locks the " .. MONKEYQUEST_TITLE .. " frame in place.\n"
MONKEYQUEST_HELP_UNLOCK_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest unlock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Unlocks the " .. MONKEYQUEST_TITLE .. " frame, making it movable.\n"
MONKEYQUEST_HELP_COLOURTITLEON_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest colourtitleon\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Uses the difficulty to colour the entier quest title.\n"
MONKEYQUEST_HELP_COLOURTITLEOFF_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest colourtitleoff\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Doesn't colour the entier quest title by difficulty.\n"
MONKEYQUEST_HELP_HIDECOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidecompletedquests\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Hides completed quests.\n"
MONKEYQUEST_HELP_SHOWCOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showcompletedquests\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Shows completed quests.\n"
MONKEYQUEST_HELP_HIDECOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidecompletedobjectives\n" ..
												  MONKEYQUEST_CHAT_COLOUR .. "Hides completed objectives.\n"
MONKEYQUEST_HELP_SHOWCOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showcompletedobjectives\n" ..
												  MONKEYQUEST_CHAT_COLOUR .. "Shows completed objectives.\n"
MONKEYQUEST_HELP_FONTHEIGHT_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest fontheight=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the font height to the specified value, the default is 12.\n"
MONKEYQUEST_HELP_SHOWTOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showtooltipobjectives\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Adds a line to the tooltip which shows the completeness of that quest objective.\n"
MONKEYQUEST_HELP_HIDETOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidetooltipobjectives\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Does not add a line to the tooltip about the completeness of that quest objective.\n"
MONKEYQUEST_HELP_ALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest allowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Allows you to right-click to open MonkeyBuddy.\n"
MONKEYQUEST_HELP_DISALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest disallowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Disallows you from right-clicking to open MonkeyBuddy.\n"
MONKEYQUEST_HELP_HIDETITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidetitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hides the title buttons.\n"
MONKEYQUEST_HELP_SHOWTITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showtitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Shows the title buttons.\n"

-- tooltip strings
MONKEYQUEST_TOOLTIP_QUESTITEM			= "Objeto de Quest"				-- as it appears in the tooltip of unique quest items
MONKEYQUEST_TOOLTIP_QUEST				= "Quest"
MONKEYQUEST_TOOLTIP_SLAIN				= "slain"						-- as it appears in the objective text

-- misc quest strings
MONKEYQUEST_DUNGEON						= "Mazmorra"
MONKEYQUEST_PVP							= "PvP"

-- noob tips
MONKEYQUEST_NOOBTIP_HEADER				= "Noob Tip:"

MONKEYQUEST_NOOBTIP_CLOSE				= "Pulsa aqui para cerrar esta ventana. Podras volver:"
MONKEYQUEST_NOOBTIP_MINIMIZE			= "Pulsa aqui para miminizar esta ventana"
MONKEYQUEST_NOOBTIP_RESTORE				= "Pulsa aqui para restaurar esta ventana"
MONKEYQUEST_NOOBTIP_SHOWALLHIDDEN		= "Pulsa aqui para ver todos los objetos ocultos"
MONKEYQUEST_NOOBTIP_HIDEALLHIDDEN		= "Pulsa aqui para ocultar todos los objetos escondidos"
MONKEYQUEST_NOOBTIP_HIDEBUTTON			= "Pulsa aqui para ocultar esta quest. Activalo en 'Show all hidden items' para mirar todas las quest"
MONKEYQUEST_NOOBTIP_TITLE				= "Click derecho para abrir MonkeyBuddy y poder configurarlo " .. MONKEYQUEST_TITLE
MONKEYQUEST_NOOBTIP_QUESTHEADER			= "Pulsa aqui para ocultar/mostrar todas las quest en esta zona. Activa 'Show all hidden items' para mostrar las de las zonas en que no estas."

-- bindings
BINDING_NAME_MONKEYQUEST_CLOSE			= "Cerrar/Abrir"
BINDING_NAME_MONKEYQUEST_MINIMIZE		= "Minimizar/Restaurar"
BINDING_NAME_MONKEYQUEST_HIDDEN			= "Ocultar/Mostrar todos los objetos ocultos"
BINDING_NAME_MONKEYQUEST_NOHEADERS		= "Toggle No Headers"

elseif (GetLocale() == "zhTW") then

-- English, the default
MONKEYQUEST_DESCRIPTION					= "顯示一個便於瀏覽的任務視窗。"
MONKEYQUEST_LOADED_MSG					= MONKEYQUEST_INFO_COLOUR .. MONKEYQUEST_TITLE .. " v" .. MONKEYQUEST_VERSION .. " loaded"
MONKEYQUEST_OPTIONS1					= "請安裝MonkeyBuddy來幫助你調整MonkeyQuest的設定"
MONKEYQUEST_OPTIONS2					= "\124TInterface\\Icons\\Trade_Engineering:0\124t尚未安裝MonkeyBuddy"

MONKEYQUEST_NO_HEADER					= "無標題"
MONKEYQUEST_QUEST_DONE					= "完成"
MONKEYQUEST_QUEST_FAILED				= "失敗"
MONKEYQUEST_CONFIRM_RESET				= "確定要把" .. MONKEYQUEST_TITLE .. "的設定還原為預設值嗎？"
MONKEYQUEST_CONFIRM_RESET_TO_BLIZZARD_STYLE				= "要把" .. MONKEYQUEST_TITLE .. "調整成與暴雪的任務追蹤相似的風格嗎？"

MONKEYQUEST_SET_WIDTH_MSG				= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. "：你必需'/reloadui'，才能使寬度變更生效"
MONKEYQUEST_RESET_MSG					= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. "：設定已還原。"
MONKEYQUEST_RESET_TO_BLIZZARD_STYLE_MSG	= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. "：已將任務追蹤框的外觀調整為暴雪風格"

MONKEYQUEST_HELP_MSG					= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest help <command>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "<command>可以是下面這幾種：\n" ..
										  "reset, open, close, showhidden, hidehidden, useoverviews, nooverviews, " ..
										  "tipanchor, alpha, width, hideheaders, showheaders, hideborder, showborder, " ..
										  "growup, growdown, hidenumquests, shownumquests, lock, unlock, colourtitleon, " ..
										  "colourtitleoff, hidecompletedquests, showcompletedquests, hidecompletedobjectives, " ..
										  "showcompletedobjectives, fontheight, showtooltipobjectives, hidetootipobjectives, " ..
										  "allowrightclick, disallowrightclick, hidetitlebuttons, showtitlebuttons, allowworkcomplete, disallowworkcomplete, " ..
										  "colourobjectiveson, colourobjectivesoff, showitems, hideitems, itemsonleft, itemsonright, hideviaclick, nohideviaclick."
MONKEYQUEST_HELP_RESET_MSG				= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest reset\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Displays the reset config variables dialog.\n"
MONKEYQUEST_HELP_OPEN_MSG				= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest open\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "顯示" .. MONKEYQUEST_TITLE .. "視窗\n"
MONKEYQUEST_HELP_CLOSE_MSG				= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest close\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隱藏" .. MONKEYQUEST_TITLE .. "視窗\n"
MONKEYQUEST_HELP_SHOWHIDDEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest showhidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "顯示折疊的區域與隱藏的任務\n"
MONKEYQUEST_HELP_HIDEHIDDEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest hidehidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隱藏折疊的區域與隱藏的任務\n"
MONKEYQUEST_HELP_USEOVERVIEWS_MSG		= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest useoverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "沒有具體的任務目標時，顯示任務概述\n"
MONKEYQUEST_HELP_NOOVERVIEWS_MSG		= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest nooverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "沒有具體目標的任務，同樣不顯示任務概述\n"
MONKEYQUEST_HELP_TIPANCHOR_MSG			= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest tipanchor=<anchor position>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "設定滑鼠提示錨點於主視窗的位置：<anchor position>" .. 
										  "可以是：\nANCHOR_TOPLEFT, ANCHOR_TOPRIGHT, ANCHOR_TOP, ANCHOR_LEFT, " ..
										  "ANCHOR_RIGHT, ANCHOR_BOTTOMLEFT, ANCHOR_BOTTOMRIGHT, ANCHOR_BOTTOM, ANCHOR_CURSOR, " .. 
										  "DEFAULT, NONE"
MONKEYQUEST_HELP_ALPHA_MSG				= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest alpha=<0 - 255>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "設定透明度的值\n"
MONKEYQUEST_HELP_WIDTH_MSG				= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest width=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "設定寬度的值，預設255\n"
MONKEYQUEST_HELP_HIDEHEADERS_MSG		= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest hideheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "不顯示區域標題。\n"
MONKEYQUEST_HELP_SHOWHEADERS_MSG		= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest showheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "顯示區域標題。\n"
MONKEYQUEST_HELP_HIDEBORDER_MSG			= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest hideborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隱藏" .. MONKEYQUEST_TITLE .. "主視窗的邊框\n"
MONKEYQUEST_HELP_SHOWBORDER_MSG			= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest showborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "顯示" .. MONKEYQUEST_TITLE .. "主視窗的邊框\n"
MONKEYQUEST_HELP_GROWUP_MSG				= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest growup\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "使" .. MONKEYQUEST_TITLE .. "主視窗向上展開\n"
MONKEYQUEST_HELP_GROWDOWN_MSG			= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest growdown\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "使" .. MONKEYQUEST_TITLE .. "主視窗向下展開\n"
MONKEYQUEST_HELP_HIDENUMQUESTS_MSG		= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest hidenumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "不要在主標題上顯示任務數量\n"
MONKEYQUEST_HELP_SHOWNUMQUESTS_MSG		= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest shownumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "在主標題上顯示任務數量\n"
MONKEYQUEST_HELP_LOCK_MSG				= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest lock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "鎖定" .. MONKEYQUEST_TITLE .. "的位置。\n"
MONKEYQUEST_HELP_UNLOCK_MSG				= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest unlock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "解鎖" .. MONKEYQUEST_TITLE .. "視窗，使其可移動。\n"
MONKEYQUEST_HELP_COLOURTITLEON_MSG		= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest colourtitleon\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "根據難度著色任務標題。\n"
MONKEYQUEST_HELP_COLOURTITLEOFF_MSG		= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest colourtitleoff\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "不以難度著色任務標題。\n"
MONKEYQUEST_HELP_HIDECOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest hidecompletedquests\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "隱藏已完成任務。\n"
MONKEYQUEST_HELP_SHOWCOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest showcompletedquests\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "顯示已完成任務。\n"
MONKEYQUEST_HELP_HIDECOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest hidecompletedobjectives\n" ..
												  MONKEYQUEST_CHAT_COLOUR .. "隱藏已完成目標\n"
MONKEYQUEST_HELP_SHOWCOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest showcompletedobjectives\n" ..
												  MONKEYQUEST_CHAT_COLOUR .. "顯示已完成目標\n"
MONKEYQUEST_HELP_FONTHEIGHT_MSG			= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest fontheight=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "設定字型大小，預設12\n"
MONKEYQUEST_HELP_SHOWTOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest showtooltipobjectives\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "在任物目標的滑鼠提示上顯示進度\n"
MONKEYQUEST_HELP_HIDETOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest hidetooltipobjectives\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "不在任務目標的滑鼠提示上顯示進度\n"
MONKEYQUEST_HELP_ALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest allowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "右鍵點擊視窗開啟MonkeyBuddy。\n"
MONKEYQUEST_HELP_DISALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest disallowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "使你不能用右鍵點擊視窗開啟MonkeyBuddy。\n"
MONKEYQUEST_HELP_HIDETITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest hidetitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隱藏主標題按鈕。\n"
MONKEYQUEST_HELP_SHOWTITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest showtitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "顯示主標題按鈕。\n"
MONKEYQUEST_HELP_ALLOWWORKCOMPLETE_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest allowworkcomplete\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "啟用「任務完成」的音效"
MONKEYQUEST_HELP_DISALLOWWORKCOMPLETE_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest disallowworkcomplete\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "停用「任務完成」的音效"

-- tooltip strings
MONKEYQUEST_TOOLTIP_QUESTITEM			= "任務物品"					-- as it appears in the tooltip of unique quest items
MONKEYQUEST_TOOLTIP_QUEST				= "任務"
MONKEYQUEST_TOOLTIP_SLAIN				= "擊殺"						-- as it appears in the objective text

-- misc quest strings
MONKEYQUEST_DUNGEON						= "地城"
MONKEYQUEST_PVP							= "PvP"

-- noob tips
MONKEYQUEST_NOOBTIP_HEADER				= "新手提示"

MONKEYQUEST_NOOBTIP_CLOSE				= "點擊這裡關閉主視窗。重新打開請用："
MONKEYQUEST_NOOBTIP_MINIMIZE			= "點擊這裡將主視窗最小化"
MONKEYQUEST_NOOBTIP_RESTORE				= "點擊這裡還原主視窗"
MONKEYQUEST_NOOBTIP_SHOWALLHIDDEN		= "點擊這裡顯示所有隱藏的項目"
MONKEYQUEST_NOOBTIP_HIDEALLHIDDEN		= "點擊這裡隱藏所有未勾選的項目"
MONKEYQUEST_NOOBTIP_HIDEBUTTON			= "點擊這裡，取消勾選來隱藏這個任務。要重新顯示，啟用「顯示所有隱藏的項目」"
MONKEYQUEST_NOOBTIP_TITLE				= "右鍵點擊此處開啟MonkeyBuddy，調整" .. MONKEYQUEST_TITLE .. "的設定"
MONKEYQUEST_NOOBTIP_QUESTHEADER			= "點擊這裡隱藏或顯示這個區域內的所有任務。要重新顯示，啟用「顯示所有隱藏的項目」"

-- bindings
BINDING_NAME_MONKEYQUEST_CLOSE			= "開啟或關閉"
BINDING_NAME_MONKEYQUEST_MINIMIZE		= "縮小或還原"
BINDING_NAME_MONKEYQUEST_HIDDEN			= "顯示已隱藏的項目"
BINDING_NAME_MONKEYQUEST_NOHEADERS		= "顯示或隱藏區域標題"

elseif (GetLocale() == "zhCN") then

-- English, the default
MONKEYQUEST_DESCRIPTION					= "显示一个便于浏览的任务窗口。"
MONKEYQUEST_LOADED_MSG					= MONKEYQUEST_INFO_COLOUR .. MONKEYQUEST_TITLE .. " v" .. MONKEYQUEST_VERSION .. " loaded"
MONKEYQUEST_OPTIONS1					= "请安装MonkeyBuddy来帮助你调整MonkeyQuest的设置"
MONKEYQUEST_OPTIONS2					= "\124TInterface\\Icons\\Trade_Engineering:0\124t尚未安装MonkeyBuddy"

MONKEYQUEST_NO_HEADER					= "无标题"
MONKEYQUEST_QUEST_DONE					= "完成"
MONKEYQUEST_QUEST_FAILED				= "失败"
MONKEYQUEST_CONFIRM_RESET				= "确定要把" .. MONKEYQUEST_TITLE .. "的设置还原为默认值吗？"
MONKEYQUEST_CONFIRM_RESET_TO_BLIZZARD_STYLE				= "要把" .. MONKEYQUEST_TITLE .. "调整成与暴雪的任务追踪相似的风格吗？"

MONKEYQUEST_SET_WIDTH_MSG				= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. "：你必需'/reloadui'，才能使宽度变更生效"
MONKEYQUEST_RESET_MSG					= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. "：设置已还原。"
MONKEYQUEST_RESET_TO_BLIZZARD_STYLE_MSG	= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. "：已将任务追踪框的外观调整为暴雪风格"

MONKEYQUEST_HELP_MSG					= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest help <command>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "<command>可以是下面这几种：\n" ..
										  "reset, open, close, showhidden, hidehidden, useoverviews, nooverviews, " ..
										  "tipanchor, alpha, width, hideheaders, showheaders, hideborder, showborder, " ..
										  "growup, growdown, hidenumquests, shownumquests, lock, unlock, colourtitleon, " ..
										  "colourtitleoff, hidecompletedquests, showcompletedquests, hidecompletedobjectives, " ..
										  "showcompletedobjectives, fontheight, showtooltipobjectives, hidetootipobjectives, " ..
										  "allowrightclick, disallowrightclick, hidetitlebuttons, showtitlebuttons, allowworkcomplete, disallowworkcomplete, " ..
										  "colourobjectiveson, colourobjectivesoff, showitems, hideitems, itemsonleft, itemsonright, hideviaclick, nohideviaclick."
MONKEYQUEST_HELP_RESET_MSG				= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest reset\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Displays the reset config variables dialog.\n"
MONKEYQUEST_HELP_OPEN_MSG				= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest open\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "显示" .. MONKEYQUEST_TITLE .. "窗口\n"
MONKEYQUEST_HELP_CLOSE_MSG				= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest close\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隐藏" .. MONKEYQUEST_TITLE .. "窗口\n"
MONKEYQUEST_HELP_SHOWHIDDEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest showhidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "显示折叠的区域与隐藏的任务\n"
MONKEYQUEST_HELP_HIDEHIDDEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest hidehidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隐藏折叠的区域与隐藏的任务\n"
MONKEYQUEST_HELP_USEOVERVIEWS_MSG		= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest useoverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "没有具体的任务目标时，显示任务概述\n"
MONKEYQUEST_HELP_NOOVERVIEWS_MSG		= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest nooverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "没有具体目标的任务时，同样不显示任务概述\n"
MONKEYQUEST_HELP_TIPANCHOR_MSG			= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest tipanchor=<anchor position>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "设置鼠标提示锚点于主窗口的位置：<anchor position>" .. 
										  "可以是：\nANCHOR_TOPLEFT, ANCHOR_TOPRIGHT, ANCHOR_TOP, ANCHOR_LEFT, " ..
										  "ANCHOR_RIGHT, ANCHOR_BOTTOMLEFT, ANCHOR_BOTTOMRIGHT, ANCHOR_BOTTOM, ANCHOR_CURSOR, " .. 
										  "DEFAULT, NONE"
MONKEYQUEST_HELP_ALPHA_MSG				= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest alpha=<0 - 255>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "设置透明度的值\n"
MONKEYQUEST_HELP_WIDTH_MSG				= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest width=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "设置宽度的值，默认255\n"
MONKEYQUEST_HELP_HIDEHEADERS_MSG		= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest hideheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "不显示区域标题。\n"
MONKEYQUEST_HELP_SHOWHEADERS_MSG		= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest showheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "显示区域标题。\n"
MONKEYQUEST_HELP_HIDEBORDER_MSG			= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest hideborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隐藏" .. MONKEYQUEST_TITLE .. "边框\n"
MONKEYQUEST_HELP_SHOWBORDER_MSG			= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest showborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "显示" .. MONKEYQUEST_TITLE .. "边框\n"
MONKEYQUEST_HELP_GROWUP_MSG				= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest growup\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "使" .. MONKEYQUEST_TITLE .. "向上展开\n"
MONKEYQUEST_HELP_GROWDOWN_MSG			= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest growdown\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "使" .. MONKEYQUEST_TITLE .. "向下展开\n"
MONKEYQUEST_HELP_HIDENUMQUESTS_MSG		= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest hidenumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "不要在主标题上显示任务数量\n"
MONKEYQUEST_HELP_SHOWNUMQUESTS_MSG		= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest shownumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "在主标题上显示任务数量\n"
MONKEYQUEST_HELP_LOCK_MSG				= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest lock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "锁定" .. MONKEYQUEST_TITLE .. "的位置。\n"
MONKEYQUEST_HELP_UNLOCK_MSG				= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest unlock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "解锁" .. MONKEYQUEST_TITLE .. "，使其可移动。\n"
MONKEYQUEST_HELP_COLOURTITLEON_MSG		= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest colourtitleon\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "根据难度着色任务标题。\n"
MONKEYQUEST_HELP_COLOURTITLEOFF_MSG		= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest colourtitleoff\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "不以难度着色任务标题。\n"
MONKEYQUEST_HELP_HIDECOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest hidecompletedquests\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "隐藏已完成任务。\n"
MONKEYQUEST_HELP_SHOWCOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest showcompletedquests\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "显示已完成任务。\n"
MONKEYQUEST_HELP_HIDECOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest hidecompletedobjectives\n" ..
												  MONKEYQUEST_CHAT_COLOUR .. "隐藏已完成目标\n"
MONKEYQUEST_HELP_SHOWCOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest showcompletedobjectives\n" ..
												  MONKEYQUEST_CHAT_COLOUR .. "显示已完成目标\n"
MONKEYQUEST_HELP_FONTHEIGHT_MSG			= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest fontheight=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "设置字号，默认12\n"
MONKEYQUEST_HELP_SHOWTOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest showtooltipobjectives\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "在任物目标的鼠标提示上显示进度\n"
MONKEYQUEST_HELP_HIDETOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest hidetooltipobjectives\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "不在任务目标的鼠标提示上显示进度\n"
MONKEYQUEST_HELP_ALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest allowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "右键点击窗口开启MonkeyBuddy。\n"
MONKEYQUEST_HELP_DISALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest disallowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "使你不能用右键点击窗口开启MonkeyBuddy。\n"
MONKEYQUEST_HELP_HIDETITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest hidetitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "隐藏主标题按钮。\n"
MONKEYQUEST_HELP_SHOWTITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest showtitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "显示主标题按钮。\n"
MONKEYQUEST_HELP_ALLOWWORKCOMPLETE_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest allowworkcomplete\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "启用“任务完成”的音效"
MONKEYQUEST_HELP_DISALLOWWORKCOMPLETE_MSG	= MONKEYQUEST_INFO_COLOUR .. "指令：/mquest disallowworkcomplete\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "停用“任务完成”的音效"

-- tooltip strings
MONKEYQUEST_TOOLTIP_QUESTITEM			= "任务物品"					-- as it appears in the tooltip of unique quest items
MONKEYQUEST_TOOLTIP_QUEST				= "任务"
MONKEYQUEST_TOOLTIP_SLAIN				= "击杀"						-- as it appears in the objective text

-- misc quest strings
MONKEYQUEST_DUNGEON						= "地城"
MONKEYQUEST_PVP							= "PvP"

-- noob tips
MONKEYQUEST_NOOBTIP_HEADER				= "新手提示"

MONKEYQUEST_NOOBTIP_CLOSE				= "点击这里关闭主视窗。重新打开请用："
MONKEYQUEST_NOOBTIP_MINIMIZE			= "点击这里将主视窗最小化"
MONKEYQUEST_NOOBTIP_RESTORE				= "点击这里还原主视窗"
MONKEYQUEST_NOOBTIP_SHOWALLHIDDEN		= "点击这里显示所有隐藏的项目"
MONKEYQUEST_NOOBTIP_HIDEALLHIDDEN		= "点击这里隐藏所有未勾选的项目"
MONKEYQUEST_NOOBTIP_HIDEBUTTON			= "点击这里，取消勾选来隐藏这个任务。要重新显示，启用“显示所有隐藏的项目”"
MONKEYQUEST_NOOBTIP_TITLE				= "右键点击此处开启MonkeyBuddy，调整" .. MONKEYQUEST_TITLE .. "的设置"
MONKEYQUEST_NOOBTIP_QUESTHEADER			= "点击这里隐藏或显示这个区域内的所有任务。要重新显示，启用“显示所有隐藏的项目”"

-- bindings
BINDING_NAME_MONKEYQUEST_CLOSE			= "开启或关闭"
BINDING_NAME_MONKEYQUEST_MINIMIZE		= "缩小或还原"
BINDING_NAME_MONKEYQUEST_HIDDEN			= "显示已隐藏的项目"
BINDING_NAME_MONKEYQUEST_NOHEADERS		= "显示或隐藏区域标题"

end