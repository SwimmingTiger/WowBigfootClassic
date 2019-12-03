--[[
	Italian Localization
		***
]]--

local CONFIG, Config = ...
local L = LibStub('AceLocale-3.0'):NewLocale(CONFIG, 'itIT')
if not L then return end

-- general
L.GeneralDesc = 'Impostazioni generali di configurazioni per ADDON.'
L.Locked = 'Blocca la posizione della finestra.'
L.Fading = 'Attiva opacità finestra.'
L.TipCount = 'Attiva conteggio degli oggetti.'
L.FlashFind = 'Attiva ricerca mediante sintassi.'
L.DisplayBlizzard = 'Mostra le finestre di Blizzard per le borse disabilitate.'
L.EmptySlots = 'Mostra uno sfondo per gli scomparti vuoti.'

-- frame
L.FrameSettings = 'Impostazioni finestre'
L.FrameSettingsDesc = 'Configurazioni specifiche per le finestre di ADDON.'
L.Frame = 'Finestra'
L.Enabled = 'Attiva la finestra'
--L.CharacterSpecific = 'Character Specific Settings'
--L.ExclusiveReagent = 'Separate Reagent Bank'

L.BagToggle = 'Attiva riquadro borse'
L.Money = 'Riquadro delle monete'
L.Broker = 'Riquadro degli addon (Data Broker)'
L.Sort = "Bottone per l'ordinamento"
L.Search = 'Pulsante di ricerca'
L.Options = 'Pulsante delle opzioni'

L.Appearance = 'Aspetto'
L.Layer = 'Livello'
L.BagBreak = 'Separazione tra borse'
L.ReverseBags = 'Inverti i borse'
L.ReverseSlots = 'Inverti i scomparti'

L.Color = 'Colore della finestra'
L.BorderColor = 'Colore del bordo'

L.Strata = 'Livello'
L.Columns = 'Colonne'
L.Scale = 'Proporzione'
L.Scale = 'Scala di oggetti'
L.Spacing = 'Distanza'
L.Alpha = 'Opacità'

-- auto display
L.DisplaySettings = 'Mostra automaticamente'
L.DisplaySettingsDesc = 'Condizioni per mostrare automaticamente ADDON.'
L.DisplayInventory = 'Mostra l\'inventario'
L.CloseInventory = 'Chiudi l\'Inventario'

L.DisplayBank = "quando si visita la Banca"
L.DisplayAuction = "quando si visita la casa d'aste"
L.DisplayTrade = "quando scambi degli oggetti"
L.DisplayCraft = "durante la professione"
L.DisplayMail = "mentre controlli la posta"
L.DisplayGuildbank = "mentre controlli la Banca di Gilda"
L.DisplayPlayer = "quando apri la finestra del giocatore"
L.DisplayGems = "quando inserisci una gemma nell'incavo di un oggetto"

L.CloseCombat = "quando entri in combattimento"
L.CloseVehicle = "quando entri un veicolo"
L.CloseBank = 'quando sali la Banca'
L.CloseVendor = "quando ti allontani da un venditore"

-- colors
L.ColorSettings = 'Impostazioni del colore'
L.ColorSettingsDesc = 'Impostazione dei colori sui vari oggetti.'
L.GlowQuality = 'Evidenzia oggetti per qualità.'
L.GlowNew = 'Evidenzia i nuovi oggetti.'
L.GlowQuest = 'Evidenzia oggetti delle missioni.'
L.GlowUnusable = 'Evidenzia oggetti non utilizzabili.'
L.GlowSets = "Evidenzia l'equipaggiamento che fa parte di un set."
L.ColorSlots = 'Colora gli scomparti vuoti in base al tipo di borsa.'

L.NormalColor = 'Colore normale'
L.LeatherColor = 'Borse per conciatori'
L.InscribeColor = 'Borse per runografi'
L.HerbColor = 'Borse per erbalisti'
L.EnchantColor = 'Borse per incantatori'
L.EngineerColor = 'Borse per ingegneri'
L.GemColor = 'Borse per orafi'
L.MineColor = 'Borse per minatori'
L.TackleColor = 'Borse degli attrezzi'
L.RefrigeColor = 'Borse frigorifera'
L.ReagentColor = 'Scomparto reagenti in Banca'
L.GlowAlpha = 'Brillantezza oggetti evidenziati'