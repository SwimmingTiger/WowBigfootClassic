--[[
	French Localization
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'frFR')
if not L then return end

--keybindings
L.ToggleBags = 'Afficher votre inventaire'
L.ToggleBank = 'Afficher votre banque'
L.ToggleGuild = 'Afficher votre banque de guilde'
L.ToggleVault = 'Afficher votre chambre du Vide'

--terminal
L.Commands = 'Liste des commandes :'
L.CmdShowInventory = 'Affiche ou cache votre inventaire'
L.CmdShowBank = 'Affiche ou cache votre banque'
L.CmdShowGuild = 'Affiche ou cache votre banque de guilde'
L.CmdShowVault = 'Affiche ou cache votre chambre du Vide'
L.CmdShowVersion = 'Affiche la version actuelle'
L.CmdShowOptions = 'Ouvre le menu de configuration'
L.Updated = 'Mise à jour vers la v%s'

--frames
L.TitleBags = 'Inventaire |2 %s'
L.TitleBank = 'Banque |2 %s'
L.TitleVault = 'Chambre du Vide |2 %s'

--interactions
L.Click = 'Cliquez'
L.Drag = '<Saisir>'
L.LeftClick = '<Clic Gauche>'
L.RightClick = '<Clic Droit>'
L.DoubleClick = '<Double Clic>'
L.ShiftClick = '<Shift+Clic>'

--tooltips
L.TipChangePlayer = '%s pour afficher les objets d\'un autre personnage.'
L.TipCleanBags = '%s pour ranger vos sacs.'
L.TipCleanBank = '%s pour ranger votre banque.'
L.TipDepositReagents = '%s pour déposer tous les composants.'
L.TipFrameToggle = '%s pour afficher d\'autres fenêtres.'
L.TipGoldOnRealm = '%s Totals'
L.TipHideBag = '%s pour cacher ce sac.'
L.TipHideBags = '%s pour cacher l\'affichage des sac.'
L.TipHideSearch = '%s pour cacher le champ de recherche.'
L.TipResetPlayer = '%s pour retourner sur le personnage actuel.'
L.PurchaseBag = '%s pour acheter cet emplacement de sac.'
L.TipShowBag = '%s pour afficher ce sac.'
L.TipShowBags = '%s pour afficher la fenêtre de vos sacs.'
L.TipShowBank = '%s pour afficher/cacher votre banque.'
L.TipShowInventory = '%s pour afficher/cacher votre inventaire.'
L.TipShowMenu = '%s pour configurer cette fenêtre.'
L.TipShowOptions = '%s pour ouvrir le menu des options.'
L.TipShowSearch = '%s pour rechercher.'
L.TipShowFrameConfig = '%s pour configurer cette fenêtre.'
L.TipDeposit = '%s pour déposer.'
L.TipWithdrawRemaining = '%s pour retirer (%s encore possible).'
L.TipWithdraw = '%s pour retirer (no remaining).'
L.NumWithdraw = '%d |4retrait:retraits;'
L.NumDeposit = '%d |4dépôt:dépôts;'
L.GuildFunds = 'Guild Funds'
L.Total = 'Total'

--itemcount tooltips
L.TipCountEquip = 'Équipé : %d'
L.TipCountBags = 'Sacs : %d'
L.TipCountBank = 'Banque : %d'
L.TipCountVault = 'Chambre : %d'
L.TipCountGuild = 'Guilde : %d'
L.TipDelimiter = '|'
