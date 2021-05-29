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
L.FlashFind = 'Attiva ricerca veloce.'
L.DisplayBlizzard = 'Mostra le finestre di Blizzard per le borse disabilitate.'
L.DisplayBlizzardTip = 'Se abilitato, verrà utilizzata l\'interfaccia Blizzard di base  per le sacche o gli inventari di banca nascosti.\n\n|cffff1919Richiede un riavvio dell\'UI.|r'
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


L.BagToggle = 'Attiva riquadro borse'
L.Money = 'Soldi'
L.Broker = 'Plugins Databroker'
L.Sort = "Bottone per l'ordinamento"
L.Search = 'Pulsante di ricerca'
L.Options = 'Pulsante delle opzioni'
L.ExclusiveReagent = 'Separa la Banca dei Reagenti'
L.LeftTabs = 'Rulesets a Sinistra'
L.LeftTabsTip = [[
Se abilitato, i pannelli laterali verranno mostrati a sinistra della finestra]]


L.Appearance = 'Aspetto'
L.Layer = 'Livello'
L.BagBreak = 'Separazione tra borse'
L.ReverseBags = 'Inverti i borse'
L.ReverseSlots = 'Inverti gli scomparti'

L.Color = 'Colore della finestra'
L.BorderColor = 'Colore del bordo'

L.Strata = 'Livello'
L.Columns = 'Colonne'
L.Scale = 'Proporzione'
L.ItemScale = 'Scala di oggetti'
L.Spacing = 'Distanza'
L.Alpha = 'Opacità'

-- auto display
L.DisplayOptions = 'Mostra automaticamente'
L.DisplayOptionsDesc = 'Queste opzioni ti permettono di configurare quando aprire o chiudere l\'inventario automaticamente in base agli eventi in gioco.'
L.DisplayInventory = 'Mostra l\'inventario'
L.CloseInventory = 'Chiudi l\'Inventario'

L.DisplayBank = "quando si visita la Banca"
L.DisplayGuildbank = "quando si visita la Banca di Gilda"
L.DisplayAuction = "quando si visita la Casa d'Aste"
L.DisplayMail = "quando controlli la posta"
L.DisplayTrade = "quando scambi degli oggetti"
L.DisplayScrapping = 'quando ricicli dell\'equipaggiamento'
L.DisplayGems = "quando inserisci una gemma nell'incavo di un oggetto"
L.DisplayCraft = "durante la creazione di un\'oggetto"
L.DisplayPlayer = "quando apri la finestra del giocatore"

L.CloseCombat = "quando entri in combattimento"
L.CloseVehicle = "quando entri un veicolo"
L.CloseBank = 'quando sali la Banca'
L.CloseVendor = "quando ti allontani da un venditore"
L.CloseMap = 'Quando chiudi la Mappa del Mondo'

-- colors
L.ColorOptions = 'Impostazioni del colore'
L.ColorOptionsDesc = 'Impostazione dei colori sui vari oggetti.'
L.GlowQuality = 'Evidenzia oggetti per qualità.'
L.GlowQuest = 'Evidenzia oggetti delle missioni.'
L.GlowUnusable = 'Evidenzia oggetti non utilizzabili.'
L.GlowSets = "Evidenzia l'equipaggiamento che fa parte di un set."
L.GlowNew = 'Evidenzia i nuovi oggetti.'
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
L.GemColor = 'Colore per Orafi'
L.MineColor = 'Colore per Minatori'
L.TackleColor = 'Colore degli Attrezzi'
L.RefrigeColor = 'Colore per Sacche da Cucina'

-- rulesets
L.RuleOptions = 'Set di Opzioni'
L.RuleOptionsDesc = 'Queste impostazioni ti permettono di scegliere quale set di opzioni usare e in quale ordine.'
