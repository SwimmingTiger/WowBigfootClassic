--[[
	Italian Localization
]]--

local CONFIG = ...
local L = LibStub('AceLocale-3.0'):NewLocale(CONFIG, 'itIT')
if not L then return end

-- general
L.GeneralOptionsDesc = 'Impostazioni generali di configurazioni per %s.'
L.Locked = 'Blocca la posizione della finestra.'
L.Fading = 'Attiva opacità finestra.'
L.TipCount = 'Attiva conteggio degli oggetti.'
L.CountGuild = 'Includi Banca di Gilda'
L.FlashFind = 'Attiva Ricerca Veloce.'
L.DisplayBlizzard = 'Mostra le finestre di Blizzard per le borse disabilitate.'
L.DisplayBlizzardTip = 'Se abilitato, verrà utilizzata l\'interfaccia Blizzard di base per le sacche o gli inventari di banca nascosti.\n\n|cffff1919Richiede un riavvio dell\'UI.|r'
L.ConfirmGlobals = 'Sei sicuro di voler disabilitare le impostazioni specifiche per questo personaggio? Tutte le impostazioni specifiche verranno perse.'
L.CharacterSpecific = 'Impostazioni specifiche personaggio'

-- frame
L.FrameOptions = 'Impostazioni finestre'
L.FrameOptionsDesc = 'Configurazioni specifiche per le finestre di %s.'
L.Frame = 'Finestra'
L.Enabled = 'Attiva la finestra'
L.EnabledTip = 'Se disabilitato, l\'interfaccia Blizzard predefinita non verrà sostituita per questa finestra.\n\n|cffff1919Richiede un riavvio dell\'UI.|r'
L.ActPanel = 'Considera come Finestra Standard'
L.ActPanelTip = [[
Se abilitato, questa finestra si posizionerà automaticamente come quelle standard dell\'interfaccia, come quella del |cffffffffGrimorio|r
 o della |cffffffffRicerca delle Incursioni|r, e non potrà essere spostata.]]


L.BagToggle = 'Attiva Riquadro Borse'
L.Money = 'Soldi'
L.Broker = 'Plugins Databroker'
L.Sort = "Pulsante per l'Ordinamento"
L.Search = 'Pulsante di Ricerca'
L.Options = 'Pulsante delle Opzioni'
L.ExclusiveReagent = 'Separa la Banca dei Reagenti'
L.LeftTabs = 'Rulesets a Sinistra'
L.LeftTabsTip = [[
Se abilitato, i pannelli laterali verranno mostrati a sinistra della finestra]]


L.Appearance = 'Aspetto'
L.Layer = 'Livello'
L.BagBreak = 'Separazione tra Borse'
L.ReverseBags = 'Inverti le Borse'
L.ReverseSlots = 'Inverti gli Scomparti'

L.Color = 'Colore della Finestra'
L.BorderColor = 'Colore del Bordo'

L.Strata = 'Livello'
L.Columns = 'Colonne'
L.Scale = 'Proporzione'
L.ItemScale = 'Scala di Oggetti'
L.Spacing = 'Distanza'
L.Alpha = 'Opacità'

-- auto display
L.DisplayOptions = 'Mostra Automaticamente'
L.DisplayOptionsDesc = 'Queste opzioni ti permettono di configurare quando aprire o chiudere l\'inventario automaticamente in base agli eventi in gioco.'
L.DisplayInventory = 'Mostra l\'Inventario'
L.CloseInventory = 'Chiudi l\'Inventario'

L.DisplayBank = "Quando si visita la Banca"
L.DisplayGuildbank = "Quando si visita la Banca di Gilda"
L.DisplayAuction = "Quando si visita la Casa d'Aste"
L.DisplayMail = "Quando controlli la posta"
L.DisplayTrade = "Quando scambi degli oggetti"
L.DisplayScrapping = 'Quando ricicli dell\'equipaggiamento'
L.DisplayGems = "Quando inserisci una gemma nell'Incavo di un Oggetto"
L.DisplayCraft = "Durante la creazione di un\'Oggetto"
L.DisplayPlayer = "Quando apri la Finestra del Giocatore"

L.CloseCombat = "Quando entri in Combattimento"
L.CloseVehicle = "Quando entri un Veicolo"
L.CloseBank = 'Quando chiudi la Banca'
L.CloseVendor = "Quando ti allontani da un Venditore"
L.CloseMap = 'Quando apri la Mappa del Mondo'

-- colors
L.ColorOptions = 'Impostazioni del Colore'
L.ColorOptionsDesc = 'Impostazione dei Colori sui vari Oggetti.'
L.GlowQuality = 'Evidenzia Oggetti per Qualità.'
L.GlowQuest = 'Evidenzia Oggetti delle Missioni.'
L.GlowUnusable = 'Evidenzia Oggetti non Utilizzabili.'
L.GlowSets = "Evidenzia l'Equipaggiamento che fa parte di un Set."
L.GlowNew = 'Evidenzia i Nuovi Oggetti.'
L.GlowPoor = 'Evidenzia Oggetti Inutili'
L.GlowAlpha = 'Brillantezza del Bagliore'

L.EmptySlots = 'Mostra Sfondo'
L.ColorSlots = 'Colora per Tipo di Borsa'
L.NormalColor = 'Colore Normale'
L.KeyColor = 'Colore Portachiavi'
L.QuiverColor = 'Colore Faretra'
L.SoulColor = 'Colore Sacche per Anime'
L.ReagentColor = 'Colore Banca dei Reagenti'
L.LeatherColor = 'Colore per Conciatori'
L.InscribeColor = 'Colore per Runografi'
L.HerbColor = 'Colore per Erbalisti'
L.EnchantColor = 'Colore per Incantatori'
L.EngineerColor = 'Colore per Ingegneri'
L.GemColor = 'Colore per Gemme'
L.MineColor = 'Colore per Minatori'
L.TackleColor = 'Colore per Sacca degli Attrezzi'
L.FridgeColor = 'Colore per Sacche da Cucina'

-- rulesets
L.RuleOptions = 'Set di Opzioni'
L.RuleOptionsDesc = 'Queste impostazioni ti permettono di scegliere quale set di opzioni usare e in quale ordine.'
