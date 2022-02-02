--[[
	Italian Localization
]]--

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'itIT')
if not L then return end

--keybindings
L.ToggleBags = "Attiva l'Inventario"
L.ToggleBank = 'Attiva la Banca'
L.ToggleGuild = 'Attiva la Banca di Gilda'
L.ToggleVault = 'Attiva la Banca Eterea'

--terminal
L.Commands = 'lista comandi:'
L.CmdShowInventory = 'Mostra il tuo Inventario'
L.CmdShowBank = 'Mostra la tua Banca'
L.CmdShowGuild = 'Mostra la tua Banca di Gilda'
L.CmdShowVault = 'Mostra la tua Banca Eterea'
L.CmdShowVersion = 'Mostra la versione attuale'
L.CmdShowOptions = 'Apri il menù di configurazione'
L.Updated = 'Aggiornato a v%s'

--frame titles
L.TitleBags = 'Inventario di %s'
L.TitleBank = 'Banca di %s'
L.TitleVault = 'Banca Eterea di %s'

--dropdowns
L.TitleFrames = 'Riquadro di %s'
L.SelectCharacter = 'Seleziona Personaggio'
L.ConfirmDelete = 'Sei sicuro di eliminare i dati di   %s\?'

--interactions
L.Click = 'Clicca'
L.Drag = '<Trascina>'
L.LeftClick = '<Clic Sinistro>'
L.RightClick = '<Clic Destro>'
L.DoubleClick = '<Doppio Clic>'
L.ShiftClick = '<Shift+Clic>'

--tooltips
L.Total = 'Totali'
L.GuildFunds = 'Fondi di Gilda'
L.TipGoldOnRealm = '%s Totali'
L.NumWithdraw = '%d Prelevati'
L.NumDeposit = '%d Depositati'
L.NumRemainingWithdrawals = '%d Rimanenti da Prelevare'

--action tooltips
L.TipChangePlayer = '%s per vedere gli oggetti di un altro personaggio.'
L.TipCleanItems = '%s per cancellare gli oggetti.'
L.TipConfigure = '%s per configurare questa finestra.'
L.TipDepositReagents = '%s per depositare tutti i reagenti.'
L.TipDeposit = '%s per depositare.'
L.TipWithdraw = '%s per prelevare (%s rimanenti).'
L.TipFrameToggle = "per attivare un'altra finestra."
L.TipHideBag = '%s per nascondere questa borsa.'
L.TipHideBags = '%s per nascondere il riquadro delle borse.'
L.TipHideSearch = '%s per nascondere la barra di ricerca.'
L.TipMove = '%s per muovere.'
L.PurchaseBag = '%s per comprare questo spazio di Banca.'
L.TipResetPlayer = '%s per tornare al personaggio attuale.'
L.TipShowBag = '%s per mostrare questa borsa.'
L.TipShowBags = '%s per mostrare il riquadro delle borse.'
L.TipShowBank = '%s per visualizzare la tua banca.'
L.TipShowInventory = '%s per visualizzare il tuo inventario.'
L.TipShowOptions = '%s per aprire il menù delle opzioni.'
L.TipShowSearch = '%s per cercare.'

--itemcount tooltips
L.TipCountEquip = 'Equipaggiati: %d'
L.TipCountBags = 'Borse: %d'
L.TipCountBank = 'Banca: %d'
L.TipCountVault = 'Banca Eterea: %d'
L.TipCountGuild = 'Gilda: %d'
L.TipDelimiter = '|'

--dialogs
L.AskMafia = 'Chiedi alla Mafia'
L.ConfirmTransfer = 'Depositare qualsiasi oggetto rimuoverà qualsiasi modifica e/o incantamento e lo renderà non scambiabile e non rimborsabile.|n|nVuoi continuare?'
L.CannotPurchaseVault = 'Non hai abbastasnza soldi per sbloccare il servizio di Banca Eterea|n|n|cffff2020Costo: %s|r'
L.PurchaseVault = 'Vuoi sbloccare il servizio di Banca Eterea?|n|n|cffffd200Costo:|r %s'
