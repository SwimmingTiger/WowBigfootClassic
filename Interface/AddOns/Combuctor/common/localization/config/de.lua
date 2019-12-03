--[[
	German Localization
		Credits/Blame: Phanx
--]]

local CONFIG, Config = ...
local L = LibStub('AceLocale-3.0'):NewLocale(CONFIG, 'deDE')
if not L then return end

-- general
L.GeneralDesc = 'Allgemeine Einstellungen für ADDON anpassen'
L.Locked = 'Fensterpositionen sperren'
L.Fading = 'Ermögliche Ausblenden des Fensters'
L.TipCount = 'Ermögliche tooltip item count'
L.FlashFind = 'Ermögliche Blitzsuche'
L.EmptySlots = 'Zeige einen Hintergrund für leere Gegenstandslots'
L.DisplayBlizzard = 'Blizzard Fenster für die deaktivierten Taschen anzeigen'

-- frame
L.FrameSettings = 'Fenstereinstellungen'
L.FrameSettingsDesc = 'Einstellungen für ein bestimmtes ADDON Fenster anpassen'
L.Frame = 'Fenster'
L.Enabled = 'Aktiviert'
L.CharacterSpecific = 'Charakterspezifische Einstellungen'
L.ExclusiveReagent = 'Getrenntes Materiallager'

L.BagToggle = 'Taschenschaltflächen'
L.Money = 'Gold'
L.Broker = 'Databroker'
L.Sort = 'Sortierschaltfläche'
L.Search = 'Suchsschaltfläche'
L.Options = 'Optionenschaltfläche'

L.Appearance = 'Erscheinung'
L.Layer = 'Ebene'
L.BagBreak = 'Trennen der Taschen aktivieren'
L.ReverseBags = 'Taschen umkehren'
L.ReverseSlots = 'Slots umkehren'

L.Color = 'Farbe des Fensters'
L.BorderColor = 'Farbe des Fensterrands'

L.Strata = 'Ebene'
L.Columns = 'Spalten'
L.Scale = 'Skalierung'
L.ItemScale = 'Gegenstandsskalierung'
L.Spacing = 'Abstand'
L.Alpha = 'Transparenz'

-- auto display
L.DisplaySettings = 'Automatische Anzeige'
L.DisplaySettingsDesc = 'Einstellungen für das automatische öffnen der Fenster'
L.DisplayInventory = 'Inventar anzeigen...'
L.CloseInventory = 'Inventar schließen...'

L.DisplayBank = 'beim Öffnen der Bank'
L.DisplayAuction = 'beim Öffnen des Auktionshauses'
L.DisplayTrade = 'beim Handel von Gegenständen'
L.DisplayCraft = 'beim Herstellen'
L.DisplayMail = 'beim Abholen der Post'
L.DisplayGuildbank = 'beim Öffnen der Gildenbank'
L.DisplayPlayer = 'beim Öffnen des Spielerfensters'
L.DisplayGems = 'beim Gesockeln eines Gegenstands'

L.CloseCombat = 'beim Kampfbeginn'
L.CloseVehicle = 'beim Eintritt in ein Fahrzeugs'
L.CloseBank = 'beim Verlassen der Bank'
L.CloseVendor = 'beim Verlassen des Handlers'

-- colors
L.ColorSettings = 'Farbeinstellungen'
L.ColorSettingsDesc = 'Einstellungen für das Einfärben der Gegenstandslots'
L.GlowQuality = 'Gegenstände nach der Seltenheit hervorheben'
L.GlowNew = 'Neue Gegenstände hervorheben'
L.GlowQuest = 'Questgegenstände hervorheben'
L.GlowUnusable = 'Unbrauchbare Gegenstände hervorheben'
L.GlowSets = 'Ausrüstungsset-Gegenstände hervorheben'
L.ColorSlots = 'Leere Gegenstandslots nach der Taschen-Art einfärben'

L.NormalColor = 'Universaltasche'
L.LeatherColor = 'Lederertasche'
L.InscribeColor = 'Schreibertasche'
L.HerbColor = 'Kräutertasche'
L.EnchantColor = 'Verzauberertasche'
L.EngineerColor = 'Ingnieurstasche'
L.GemColor = 'Edelsteintasche'
L.MineColor = 'Bergbautasche'
L.TackleColor = 'Anglertasche'
L.RefrigeColor = 'Küchentasche'
L.ReagentColor = 'Materiallager'
L.GlowAlpha = 'Helligkeit der Gegenstandshervorhebung'