--[[
	French Localization
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'frFR')
if not L then return end

--keybinding
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

--frame text
L.TitleBags = 'Inventaire |2 %s'
L.TitleBank = 'Banque |2 %s'
L.TitleVault = 'Chambre du Vide |2 %s'

--tooltips
L.TipChangePlayer = '<Clic gauche> pour afficher les objets d\'un autre personnage.'
L.TipCleanBags = 'Cliquez pour ranger vos sacs.'
L.TipCleanBank = '<Clic droit> pour ranger votre banque.'
L.TipDepositReagents = '<Clic gauche> pour déposer tous les composants.'
L.TipFrameToggle = '<Clic droit> pour afficher d\'autres fenêtres.'
L.TipGoldOnRealm = '%s Totals'
L.TipHideBag = 'Cliquez pour cacher ce sac.'
L.TipHideBags = '<Clic gauche> pour cacher l\'affichage des sac.'
L.TipHideSearch = 'Cliquez pour cacher le champ de recherche.'
L.TipManageBank = 'Gestion de la banque'
L.TipResetPlayer = '<Clic droit> pour retourner sur le personnage actuel.'
L.PurchaseBag = 'Cliquez pour acheter cet emplacement de sac.'
L.TipShowBag = 'Cliquez pour afficher ce sac.'
L.TipShowBags = '<Clic gauche> pour afficher la fenêtre de vos sacs.'
L.TipShowBank = '<Clic droit> pour afficher/cacher votre banque.'
L.TipShowInventory = '<Clic gauche> pour afficher/cacher votre inventaire.'
L.TipShowMenu = '<Clic droit> pour configurer cette fenêtre.'
L.TipShowOptions = '<Shift clic> pour ouvrir le menu des options.'
L.TipShowSearch = 'Cliquez pour rechercher.'
L.TipShowFrameConfig = 'Cliquez pour configurer cette fenêtre.'
L.TipDoubleClickSearch = '<Alt-Saisir> pour bouger.\n<Clic droit> pour configurer.\n<Double clic> pour rechercher.'
L.TipDeposit = '<Clic gauche> pour déposer.'
L.TipWithdrawRemaining = '<Clic droit> pour retirer (%s encore possible).'
L.TipWithdraw = '<Clic droit> pour retirer (no remaining).'
L.NumWithdraw = '%d |4retrait:retraits;'
L.NumDeposit = '%d |4dépôt:dépôts;'
L.GuildFunds = 'Guild Funds'
L.Total = 'Total'

--dialogs
L.ConfirmTransfer = 'Depositing these items will remove all modifications and make them non-tradeable and non-refundable.|n|nDo you wish to continue?'
L.PurchaseVault = 'Would you like to unlock the Void Storage service?|n|n|cffffd200Cost:|r %s'
L.CannotPurchaseVault = 'You do not have enough money to unlock the Void Storage service|n|n|cffff2020Cost: %s|r'
L.AskMafia = 'Ask Mafia'

--itemcount tooltips
L.TipCountEquip = 'Équipé : %d'
L.TipCountBags = 'Sacs : %d'
L.TipCountBank = 'Banque : %d'
L.TipCountVault = 'Chambre : %d'
L.TipCountGuild = 'Guilde : %d'
L.TipDelimiter = '|'
