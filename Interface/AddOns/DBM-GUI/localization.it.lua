if GetLocale() ~= "itIT" then return end
if not DBM_GUI_L then DBM_GUI_L = {} end
local L = DBM_GUI_L

L.MainFrame = "Deadly Boss Mods"

L.TranslationBy 			= "Kaliad @Pozzo dell'Eternita'"

L.OTabBosses	= "Boss"
L.OTabOptions	= "Optioni"

L.TabCategory_Options	 	= "Opzioni generali"
L.TabCategory_OTHER    		= "Altri Boss Mods"

L.BossModLoaded 			= "%s statistiche"
L.BossModLoad_now 			= [[Questo BossMod non e' caricato.
Verra' caricato quando entri nell'istanza.
Puoi anche cliccare il bottone per caricare il modulo manualmente.]]

L.PosX						= "Posizione X"
L.PosY						= "Posizione Y"

L.MoveMe 					= "Spostami"
L.Button_OK 				= "OK"
L.Button_Cancel 			= "Cancella"
L.Button_LoadMod 			= "Carica AddOn"
L.Mod_Enabled				= "Abilita boss mod"
L.Reset 					= "Resetta"

L.Enable  					= "Abilita"
L.Disable					= "Disabilita"

L.NoSound					= "Nessun Suono"

L.IconsInUse				= "Icone usate da questo mod"

-- Tab: Boss Statistics
L.BossStatistics			= "Statistiche del Boss"
L.Statistic_Kills			= "Uccisioni:"
L.Statistic_Wipes			= "Sconfitte:"
L.Statistic_BestKill		= "Miglior Kill:"

-- Tab: General Options
L.General 					= "DBM - Opzioni Generali"
L.EnableMiniMapIcon			= "Visualizza il bottone della minimappa"
L.UseMasterVolume			= "Usa il canale audio Principale per eseguire i suoni."
L.DisableCinematics			= "Disabilita tutti i video e le cinematiche"
L.SKT_Enabled				= "Visualizza sempre un timer per la miglior uccisione(Sovrascrive l'opzione specifica del boss)"
L.Latency_Text				= "Imposta la soglia massima di latenza di sincronizzazione: %d"

L.ModelOptions				= "Opzioni di visualizzazione dei Boss in 3D"
L.EnableModels				= "Abilita i modelli 3D dei boss nelle opzioni"
L.ModelSoundOptions			= "Imposta le opzioni dei suoni per il visualizzatore dei boss"
L.ModelSoundShort			= "Breve"
L.ModelSoundLong			= "Lungo"

L.Button_RangeFrame			= "Visualizza/Nascondi la finestra di Prossimita'"
L.Button_RangeRadar			= "Visualizza/Nascondi il radar di Prossimita'"
L.Button_InfoFrame			= "Visualizza/Nascondi la finestra Informazioni"
L.Button_TestBars			= "Avvia le Barre di Test"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "Avvisi di Incursione"
L.RaidWarning_Header		= "Avvisi di Incursione - Avvisi"
L.RaidWarnColors 			= "Avvisi di Incursione - Colori"
L.RaidWarnColor_1 			= "Colore 1"
L.RaidWarnColor_2 			= "Colore 2"
L.RaidWarnColor_3		 	= "Colore 3"
L.RaidWarnColor_4 			= "Colore 4"
L.InfoRaidWarning			= [[Puoi specificare la posizione e i colori degli Avvisi di Incursione.
Questi messaggi sono usati ad esempio per "Giocatore X e' afflitto da Y".]]
L.ColorResetted 			= "L'opzione dei colori di questo frame e' stato resettato."
L.ShowWarningsInChat 		= "Visualizza gli Avvisi anche in Chat"
L.WarningIconLeft 			= "Visualizza Icona a Sinistra"
L.WarningIconRight 			= "Visualizza Icona a Destra"
L.RaidWarnMessage 			= "Grazie per usare Deadly Boss Mods"
L.BarWhileMove 				= "Avvisi di Incursione Mobili"
L.RaidWarnSound				= "Emetti un suono per gli Avvisi di Incursione"
L.CountdownVoice			= "Imposta la voce per i conti alla rovescia"
L.SpecialWarnSound			= "Imposta il suono per gli Avvisi Speciali che riguardano solo te."
L.SpecialWarnSound2			= "Imposta il suono per gli Avvisi Speciali che riguardano un qualsiasi giocatore dell'incursione"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "Messaggi Generali"
L.CoreMessages				= "Messaggi - Opzioni Principali"
L.ShowLoadMessage 			= "Visualizza i messaggi di caricamento dei moduli in chat"
L.ShowPizzaMessage 			= "Visualizza i messaggi inviati a tutti in chat"
L.CombatMessages			= "Messaggi di Combattimento - Opzioni"
L.ShowEngageMessage 		= "Visualizza in chat il messaggio di Ingaggio"
L.ShowDefeatMessage 		= "Visualizza in chat il messaggio di uccisione"
L.Area_WhisperMessages		= "Sussurri - Opzioni"
L.AutoRespond 				= "Rispondi automaticamente ai sussurri mentre stai combattendo"
L.WhisperStats 				= "Nelle risposte ai sussurri, aggiungi le informazioni su uccisioni e sconfitte."

-- Tab: Barsetup
L.BarSetup   				= "Barre - Stile"
L.BarTexture 				= "Barre - Texture"
L.BarStartColor				= "Colore iniziale"
L.BarEndColor 				= "Colore finale"
L.ExpandUpwards				= "Espandi verso l'altro"
L.Slider_BarOffSetX 		= "Sfasamento X: %d"
L.Slider_BarOffSetY 		= "Sfasamento Y: %d"
L.Slider_BarWidth 			= "Lunghezza Barra: %d"
L.Slider_BarScale 			= "Scala Barra: %0.2f"
L.AreaTitle_BarSetup		= "Barre - Opzioni Generali"
L.AreaTitle_BarSetupSmall 	= "Barre Piccole - Opzioni"
L.AreaTitle_BarSetupHuge	= "Barre Grandi - Opzioni"
L.BarIconLeft 				= "Icona a Sinistra"
L.BarIconRight 				= "Icona a Destra"
L.EnableHugeBar 			= "Abilita le barre Grandi"
L.FillUpBars				= "Riempi la barre"
L.ClickThrough				= "Disabilita i click sulle barre"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Avvisi Speciali di Incursione"
L.Area_SpecWarn				= "Messaggi Speciali - Opzioni"
L.SpecWarn_DemoButton		= "Esempio"
L.SpecWarn_ResetMe			= "Ripristina impostazioni di default"

-- Tab: Spam Filter
L.Panel_SpamFilter				= "Filtri globali e di Spam"
L.Area_SpamFilter				= "Filtri di Spam - Opzioni"
L.HideBossEmoteFrame			= "Nascondi la finestra con i messaggi dei boss"
L.ShowBBOnCombatStart			= "Fai un Check dei Benefici con Big Brother quando inizia un combattimento"
L.BigBrotherAnnounceToRaid		= "Annuncia i risultati di Big Brother all'incursione"

L.Area_SpamFilter_Outgoing		= "Filtri Globali - Opzioni"
L.SpamBlockNoShowAnnounce		= "Non visualizzare annunci o suoni"
L.SpamBlockNoSetIcon			= "Non impostare icone sui giocatori"

-- Misc
L.FontType					= "Seleziona carattere"
L.FontStyle					= "Stile carattere"
L.FontColor					= "Colore carattere"
L.FontShadow				= "Ombre"
L.FontSize					= "Dimensioni carattere: %d"

L.FontHeight	= 16
