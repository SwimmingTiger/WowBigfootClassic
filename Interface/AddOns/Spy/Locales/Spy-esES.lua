local L = LibStub("AceLocale-3.0"):NewLocale("Spy", "esES")
if not L then return end
-- TOC Note: Detects and alerts you to the presence of nearby enemy players.

-- Configuration
L["Spy"] = "Spy"
L["Version"] = "Versión"
L["Spy Option"] = "Spy"
L["Profiles"] = "Perfiles"

-- About
L["About"] = "Info"
L["SpyDescription1"] = [[
Spy is an addon that will alert you to the presence of nearby enemy players. These are some of the main features.
]]
L["SpyDescription2"] = [[
|cffffd000Nearby list|cffffffff
Displays enemy players that have been detected nearby. Players are removed from the list if they have not been detected after a period of time.

|cffffd000Last Hour list|cffffffff
Displays all enemies that have been detected in the last hour.

|cffffd000Lista de Ignorados|cffffffff
Players that are added to the Ignore list will not be reported by Spy. You can add and remove players to/from this list by using the button's drop down menu or by holding the Control key while clicking the button.

|cffffd000Kill On Sight list|cffffffff
Players on your Kill On Sight list cause an alarm to sound when detected. You can add and remove players to/from this list by using the button's drop down menu or by holding the Shift key while clicking the button.

The drop down menu can also be used to set the reasons why you have added someone to the Kill On Sight list. If you want to enter a specific reason that is not in the list, then use the "Enter your own reason..." in the Other list.

|cffffd000Statistics Window|cffffffff
The Statistics Window contains a list of all enemy encounters which can be sorted by name, level, guild, wins, losses and the last time an enemy was detected. It also provides the ability to search for a specific enemy by name or guild and has filters to show only enemies that are marked as Kill on Sight, with a Win/Loss or entered Reasons.  

|cffffd000Kill On Sight Button|cffffffff
If enabled, this button will be located on the enemy players target frame. Clicking on this button will add/remove the enemy target to/from the Kill On Sight list. Right clicking on the button will allow you to enter Kill on Sight reasons.

|cffffd000Autor: Slipjack|cffffffff
]]

-- General Settings
L["GeneralSettings"] = "General Settings"
L["GeneralSettingsDescription"] = [[
Options for when Spy is Enabled or Disabled.
]]
L["EnableSpy"] = "Enable Spy"
L["EnableSpyDescription"] = "Enables or disables Spy."
L["EnabledInBattlegrounds"] = "Enable Spy in battlegrounds"
L["EnabledInBattlegroundsDescription"] = "Enables or disables Spy when you are in a battleground."
L["EnabledInArenas"] = "Enable Spy in arenas"
L["EnabledInArenasDescription"] = "Enables or disables Spy when you are in an arena."
L["EnabledInWintergrasp"] = "Enable Spy in world combat zones"
L["EnabledInWintergraspDescription"] = "Enables or disables Spy when you are in world combat zones such as Lake Wintergrasp in Northrend."
L["DisableWhenPVPUnflagged"] = "Disable Spy when not flagged for PVP"
L["DisableWhenPVPUnflaggedDescription"] = "Enables or disables Spy depending on your PVP status."
L["DisabledInZones"] = "Disable Spy while in these locations"
L["DisabledInZonesDescription"]	= "Selecet locations where Spy will be disabled"
L["Booty Bay"] = "Bahía del Botín"
L["Everlook"] = "Vista Eterna"						
L["Gadgetzan"] = "Gadgetzan"
L["Ratchet"] = "Trinquete"
L["The Salty Sailor Tavern"] = "Taberna del Grumete Frito"
L["Shattrath City"] = "Ciudad de Shattrath"
L["Area 52"] = "Area 52"
L["Dalaran"] = "Dalaran"
L["Dalaran (Northrend)"] = "Dalaran (Rasganorte)"
L["Bogpaddle"] = "Chapaleos"
L["The Vindicaar"] = "El Vindicaar"
L["Krasus' Landing"] = "Alto de Krasus"
L["The Violet Gate"] = "La Puerta Violeta"
L["Magni's Encampment"] = "Campamento de Magni"
L["Silithus"] = "Silithus"
L["Chamber of Heart"] = "Cámara del Corazón"
L["Hall of Ancient Paths"] = "Cámara de Sendas Ancestrales"
L["Sanctum of the Sages"] = "Santuario de los Sabios"

-- Display
L["DisplayOptions"] = "Display"
L["DisplayOptionsDescription"] = [[
Options for the Spy window and tooltips.
]]
L["ShowOnDetection"] = "Show Spy when enemy players are detected"
L["ShowOnDetectionDescription"] = "Set this to display the Spy window and the Nearby list if Spy is hidden when enemy players are detected."
L["HideSpy"] = "Hide Spy when no enemy players are detected"
L["HideSpyDescription"] = "Set this to hide Spy when the Nearby list is displayed and it becomes empty. Spy will not be hidden if you clear the list manually."
L["ShowOnlyPvPFlagged"] = "Show only enemy players flagged for PvP"
L["ShowOnlyPvPFlaggedDescription"] = "Set this to show only enemy players that are flagged for PvP in the Nearby list."
L["ShowKoSButton"] = "Show KOS button on the enemy target frame"
L["ShowKoSButtonDescription"] = "Set this to show the KOS button on the enemy player's target frame."
L["Alpha"] = "Transparency"
L["AlphaDescription"] = "Set the transparency of the Spy window."
L["AlphaBG"] = "Transparency in BGs"
L["AlphaBGDescription"] = "Set the transparency of the Spy window in battlegrounds."
L["LockSpy"] = "Lock the Spy window"
L["LockSpyDescription"] = "Locks the Spy window in place so it doesn't move."
L["ClampToScreen"] = "Anclar a la pantalla"
L["ClampToScreenDescription"] = "Controla si la ventana de Spy se puede mover fuera de la pantalla."
L["InvertSpy"] = "Invert the Spy window"
L["InvertSpyDescription"] = "Flips the Spy window upside down."
L["Reload"] = "Recargar UI"
L["ReloadDescription"] = "Required when changing the Spy window."
L["ResizeSpy"] = "Resize the Spy window automatically"
L["ResizeSpyDescription"] = "Set this to automatically resize the Spy window as enemy players are added and removed."
L["ResizeSpyLimit"] = "List Limit"
L["ResizeSpyLimitDescription"] = "Limit the number of enemy players shown in the Spy window."
L["DisplayTooltipNearSpyWindow"] = "Display tooltip near the Spy window"
L["DisplayTooltipNearSpyWindowDescription"] = "Set this to display tooltips near the Spy window."
L["SelectTooltipAnchor"] = "Tooltip Anchor Point"
L["SelectTooltipAnchorDescription"] = "Select the anchor point for the tooltip if the option above has been checked"
L["ANCHOR_CURSOR"] = "Cursor"
L["ANCHOR_TOP"] = "Top"
L["ANCHOR_BOTTOM"] = "Bottom"
L["ANCHOR_LEFT"] = "Left"			
L["ANCHOR_RIGHT"] = "Right"
L["TooltipDisplayWinLoss"] = "Display win/loss statistics in tooltip"
L["TooltipDisplayWinLossDescription"] = "Set this to display the win/loss statistics of a player in the player's tooltip."
L["TooltipDisplayKOSReason"] = "Display Kill On Sight reasons in tooltip"
L["TooltipDisplayKOSReasonDescription"] = "Set this to display the Kill On Sight reasons of a player in the player's tooltip."
L["TooltipDisplayLastSeen"] = "Display last seen details in tooltip"
L["TooltipDisplayLastSeenDescription"] = "Set this to display the last known time and location of a player in the player's tooltip."
L["DisplayListData"] = "Seleccionar datos del enemigo para mostrar"
L["Name"] = "Nombre"
L["Class"] = "Clase"
L["SelectFont"] = "Select a Font"
L["SelectFontDescription"] = "Select a Font for the Spy Window."
L["RowHeight"] = "Select the Row Height"
L["RowHeightDescription"] = "Select the Row Height for the Spy window."
L["Texture"] = "Texture"
L["TextureDescription"] = "Select a texture for the Spy Window"
				
-- Alerts				
L["AlertOptions"] = "Alertas"
L["AlertOptionsDescription"] = [[
Options for alerts, announcements and warnings when enemy players are detected.
]]
L["SoundChannel"] = "Select Sound Channel"
L["Master"] = "Master"
L["SFX"] = "Sound Effects"
L["Music"] = "Music"
L["Ambience"] = "Ambience"
L["Announce"] = "Send announcements to:"
L["None"] = "None"
L["NoneDescription"] = "Do not announce when enemy players are detected."
L["Self"] = "Self"
L["SelfDescription"] = "Avisarte a ti mismo cuando detectas jugadores enemigos."
L["Party"] = "Party"
L["PartyDescription"] = "Avisar a tu grupo cuando detectas jugadores enemigos."
L["Guild"] = "Guild"
L["GuildDescription"] = "Avisar a tu guild cuando detectas jugadores enemigos."
L["Raid"] = "Raid"
L["RaidDescription"] = "Avisar a tu grupo de raid cuando detectas jugadores enemigos."
L["LocalDefense"] = "Defensa Local"
L["LocalDefenseDescription"] = "Avisar al canal de Defensa Local cuando detectas jugadores enemigos."
L["OnlyAnnounceKoS"] = "Only announce enemy players that are Kill On Sight"
L["OnlyAnnounceKoSDescription"] = "Set this to only announce enemy players that are on your Kill On Sight list."
L["WarnOnStealth"] = "Advertir sobre la detección de sigilo"
L["WarnOnStealthDescription"] = "Set this to display a warning and sound an alert when an enemy player gains stealth."
L["WarnOnKOS"] = "Warn upon Kill On Sight detection"
L["WarnOnKOSDescription"] = "Set this to display a warning and sound an alert when an enemy player on your Kill On Sight list is detected."
L["WarnOnKOSGuild"] = "Warn upon Kill On Sight guild detection"
L["WarnOnKOSGuildDescription"] = "Set this to display a warning and sound an alert when an enemy player in the same guild as someone on your Kill On Sight list is detected."
L["WarnOnRace"] = "Warn upon Race detection"
L["WarnOnRaceDescription"] = "Set this to sound an alert when the selected Race is detected."
L["SelectWarnRace"] = "Select Race for detection"
L["SelectWarnRaceDescription"] = "Select a Race for audio alert."
L["WarnRaceNote"] = "Note: You must target an enemy at least once so their Race can be added to the database. Upon the next detection an alert will sound. This does not work the same as detecting nearby enemies in combat."
L["DisplayWarningsInErrorsFrame"] = "Display warnings in the errors frame"
L["DisplayWarningsInErrorsFrameDescription"] = "Set this to use the errors frame to display warnings instead of using the graphical popup frames."
L["DisplayWarnings"] = "Seleccionar ubicación del mensaje de advertencia"
L["Default"] = "predeterminada"
L["ErrorFrame"] = "Marco de error"
L["Moveable"] = "movible"
L["EnableSound"] = "Enable audio alerts"
L["EnableSoundDescription"] = "Set this to enable audio alerts when enemy players are detected. Different alerts sound if an enemy player gains stealth or if an enemy player is on your Kill On Sight list."
L["OnlySoundKoS"] = "Only sound audio alerts for Kill on Sight detection"
L["OnlySoundKoSDescription"] = "Set this to only play audio alerts when enemy players on the Kill on Sight list are detected."
L["StopAlertsOnTaxi"] = "Turn off alerts while on a flight path"
L["StopAlertsOnTaxiDescription"] = "Stop all new alerts and warnings while on a flight path."

-- Nearby List
L["ListOptions"] = "Nearby List"
L["ListOptionsDescription"] = [[
Options on how enemy players are added and removed.
]]
L["RemoveUndetected"] = "Remove enemy players from the Nearby list after:"
L["1Min"] = "1 minuto"
L["1MinDescription"] = "Remove an enemy player who has been undetected for over 1 minute."
L["2Min"] = "2 minutos "
L["2MinDescription"] = "Remove an enemy player who has been undetected for over 2 minutes."
L["5Min"] = "5 minutos "
L["5MinDescription"] = "Remove an enemy player who has been undetected for over 5 minutes."
L["10Min"] = "10 minutos "
L["10MinDescription"] = "Remove an enemy player who has been undetected for over 10 minutes."
L["15Min"] = "15 minutos "
L["15MinDescription"] = "Remove an enemy player who has been undetected for over 15 minutes."
L["Never"] = "Never remove"
L["NeverDescription"] = "Never remove enemy players. The Nearby list can still be cleared manually."
L["ShowNearbyList"] = "Switch to the Nearby list upon enemy player detection"
L["ShowNearbyListDescription"] = "Set this to display the Nearby list if it is not already visible when enemy players are detected."
L["PrioritiseKoS"] = "Prioritise Kill On Sight enemy players in the Nearby list"
L["PrioritiseKoSDescription"] = "Set this to always show Kill On Sight enemy players first in the Nearby list."

-- Map
L["MapOptions"] = "Mapa"
L["MapOptionsDescription"] = [[
Options for world map and minimap including icons and tooltips.
]]
L["MinimapDetection"] = "Enable minimap detection"
L["MinimapDetectionDescription"] = "Rolling the cursor over known enemy players detected on the minimap will add them to the Nearby list."
L["MinimapNote"] = "          Note: Only works for players that can Track Humanoids."
L["MinimapDetails"] = "Display level/class details in tooltips"
L["MinimapDetailsDescription"] = "Set this to update the map tooltips so that level/class details are displayed alongside enemy names."
L["DisplayOnMap"] = "Display icons on the map"
L["DisplayOnMapDescription"] = "Display map icons for the location of other Spy users in your party, raid and guild when they detect enemies."
L["SwitchToZone"] = "Switch to current zone map on enemy detection"
L["SwitchToZoneDescription"] = "Change the map to the players current zone map when enemies are detected."
L["MapDisplayLimit"] = "Limit displayed map icons to:"
L["LimitNone"] = "Everywhere"
L["LimitNoneDescription"] = "Displays all detected enemies on the map regardless of your current location."
L["LimitSameZone"] = "Misma zona"
L["LimitSameZoneDescription"] = "Only displays detected enemies on the map if you are in the same zone."
L["LimitSameContinent"] = "Mismo continente"
L["LimitSameContinentDescription"] = "Only displays detected enemies on the map if you are on the same continent."

-- Data Management
L["DataOptions"] = "Gestión de Datos"
L["DataOptionsDescription"] = [[
Options on how Spy maintains and gathers data.
]]
L["PurgeData"] = "Purge undetected enemy player data after:"
L["OneDay"] = "1 día"
L["OneDayDescription"] = "Purge data for enemy players that have been undetected for 1 day."
L["FiveDays"] = "5 días"
L["FiveDaysDescription"] = "Purge data for enemy players that have been undetected for 5 days."
L["TenDays"] = "10 días"
L["TenDaysDescription"] = "Purge data for enemy players that have been undetected for 10 days."
L["ThirtyDays"] = "30 días"
L["ThirtyDaysDescription"] = "Purge data for enemy players that have been undetected for 30 days."
L["SixtyDays"] = "60 días"
L["SixtyDaysDescription"] = "Purge data for enemy players that have been undetected for 60 days."
L["NinetyDays"] = "90 días"
L["NinetyDaysDescription"] = "Purge data for enemy players that have been undetected for 90 days."
L["PurgeKoS"] = "Purge Kill on Sight players based on undetected time."
L["PurgeKoSDescription"] = "Set this to purge Kill on Sight players that have been undetected based on the time settings for undetected players."
L["PurgeWinLossData"] = "Purge win/loss data based on undetected time."
L["PurgeWinLossDataDescription"] = "Set this to purge win/loss data of your enemy encounters based on the time settings for undetected players."
L["ShareData"] = "Share data with other Spy addon users"
L["ShareDataDescription"] = "Set this to share the details of your enemy player encounters with other Spy users in your party, raid and guild."
L["UseData"] = "Use data from other Spy addon users"
L["UseDataDescription"] = "Set this to use the data collected by other Spy users in your party, raid and guild."
L["ShareKOSBetweenCharacters"] = "Share Kill On Sight players between your characters"
L["ShareKOSBetweenCharactersDescription"] = "Set this to share the players you mark as Kill On Sight between other characters that you play on the same server and faction."

-- Commands
L["SlashCommand"] = "Slash Command"
L["SpySlashDescription"] = "These buttons execute the same functions as the ones in the slash command /spy"
L["Enable"] = "Enable"
L["EnableDescription"] = "Enables Spy and shows the main window."
L["Show"] = "Show"
L["ShowDescription"] = "Shows the main window."
L["Hide"] = "Hide"
L["HideDescription"] = "Hides the main window."
L["Reset"] = "Reset"
L["ResetDescription"] = "Resets the position and appearance of the main window."
L["ClearSlash"] = "Clear"
L["ClearSlashDescription"] = "Clears the list of players that have been detected."
L["Config"] = "Config"
L["ConfigDescription"] = "Open the Interface Addons configuration window for Spy."
L["KOS"] = "KOS"
L["KOSDescription"] = "Añadir/Eliminar un jugador de la lista de Matar a la Vista."
L["InvalidInput"] = "Invalid Input"
L["Ignore"] = "Ignore"
L["IgnoreDescription"] = "Añadir/Eliminar un jugador de la lista de Ignorados."
L["Test"] = "Test"
L["TestDescription"] = "Muestra una advertencia para que pueda reposicionarla."

-- Lists
L["Nearby"] = "Nearby"
L["LastHour"] = "Last Hour"
L["Ignore"] = "Ignorar"
L["KillOnSight"] = "Kill On Sight"

--Stats
L["Won"] = "Ganado"
L["Lost"] = "Perdido"
L["Time"] = "Time"	
L["List"] = "Lista"
L["Filter"] = "Filter"
L["Show Only"] = "Show Only"
L["KOS"] = "KOS"
L["Won/Lost"] = "Ganado/Perdido"
L["Reason"] = "Razón"	 
L["HonorKills"] = "Honor Kills"
L["PvPDeaths"] = "PvP Deaths"

-- Output Messages
L["VersionCheck"] = "|cffc41e3a¡Advertencia! La versión incorrecta de Spy está instalada. Elimine esta versión e instale Spy Classic."
L["SpyEnabled"] = "|cff9933ffSpy-Addon aktiviert."
L["SpyDisabled"] = "|cff9933ffSpy-Addon deaktiviert. Tippen Sie |cffffffff/spy show|cff9933ff um es zu aktivieren."
L["UpgradeAvailable"] = "|cff9933ffEine neue Version von Spy ist verfügbar. Es kann von: \n|cffffffffhttps://www.curseforge.com/wow/addons/spy-classic"
L["AlertStealthTitle"] = "Stealth player detected!"
L["AlertKOSTitle"] = "Kill On Sight player detected!"
L["AlertKOSGuildTitle"] = "Kill On Sight player guild detected!"
L["AlertTitle_kosaway"] = "Kill On Sight player located by "
L["AlertTitle_kosguildaway"] = "Kill On Sight player guild located by "
L["StealthWarning"] = "|cff9933ffStealth player detected: |cffffffff"
L["KOSWarning"] = "|cffff0000Kill On Sight player detected: |cffffffff"
L["KOSGuildWarning"] = "|cffff0000Kill On Sight player guild detected: |cffffffff"
L["SpySignatureColored"] = "|cff9933ff[Spy] "
L["PlayerDetectedColored"] = "Player detected: |cffffffff"
L["PlayersDetectedColored"] = "Players detected: |cffffffff"
L["KillOnSightDetectedColored"] = "Kill On Sight player detected: |cffffffff"
L["PlayerAddedToIgnoreColored"] = "Jugador añadido a la lista de Ignorados: |cffffffff"
L["PlayerRemovedFromIgnoreColored"] = "Removed player from Ignore list: |cffffffff"
L["PlayerAddedToKOSColored"] = "Jugador añadido a la lista de Matar a la Vista: |cffffffff"
L["PlayerRemovedFromKOSColored"] = "Removed player from Kill On Sight list: |cffffffff"
L["PlayerDetected"] = "[Spy] Player detected: "
L["KillOnSightDetected"] = "[Spy] Kill On Sight player detected: "
L["Level"] = "Nivel"
L["LastSeen"] = "Last seen"
L["LessThanOneMinuteAgo"] = "less than a minute ago"
L["MinutesAgo"] = "minutes ago"
L["HoursAgo"] = "hours ago"
L["DaysAgo"] = "días atrás"
L["Close"] = "Cerrar"
L["CloseDescription"] = "|cffffffffHides the Spy window. By default will show again when the next enemy player is detected."
L["Left/Right"] = "Left/Right"
L["Left/RightDescription"] = "|cffffffffNavigates between the Nearby, Last Hour, Ignore and Kill On Sight lists."
L["Clear"] = "Clear"
L["ClearDescription"] = "|cffffffffClears the list of players that have been detected. CTRL-Click will turn Spy On/Off. Shift-Click will turn all sound On/Off."
L["SoundEnabled"] = "Alertas de audio habilitadas"
L["SoundDisabled"] = "Alertas de audio deshabilitadas"
L["NearbyCount"] = "Nearby Count"
L["NearbyCountDescription"] = "|cffffffffCount of nearby players."
L["Statistics"] = "Estadística"
L["StatsDescription"] = "|cffffffffShows a list of enemy players encountered, win/loss records and where they were last seen."
L["AddToIgnoreList"] = "Añadir a la lista de Ignorados"
L["AddToKOSList"] = "Añadir a la lista de Matar a la Vista"
L["RemoveFromIgnoreList"] = "Remove from Ignore list"
L["RemoveFromKOSList"] = "Remove from Kill On Sight list"
L["RemoveFromStatsList"] = "Remove from Statistics List"   
L["AnnounceDropDownMenu"] = "Avisos"
L["KOSReasonDropDownMenu"] = "Set Kill On Sight reason"
L["PartyDropDownMenu"] = "Party"
L["RaidDropDownMenu"] = "Raid"
L["GuildDropDownMenu"] = "Guild"
L["LocalDefenseDropDownMenu"] = "Defensa Local"
L["Player"] = " (Player)"
L["KOSReason"] = "Kill On Sight"
L["KOSReasonIndent"] = "    "
L["KOSReasonOther"] = "Enter your own reason..."
L["KOSReasonClear"] = "Clear Reason"
L["StatsWins"] = "|cff40ff00Ganados: "
L["StatsSeparator"] = "  "
L["StatsLoses"] = "|cff0070ddLosses: "
L["Located"] = "located:"
L["Yards"] = "Yardas"
L["LocalDefenseChannelName"] = "DefensaLocal"

Spy_KOSReasonListLength = 6
Spy_KOSReasonList = {
	[1] = {
		["title"] = "Started combat";
		["content"] = {
			"Me atacó sin razón",
			"Me atacó cerca del NPC que me dio una misión.", 
			"Me atacó mientras luchaba contra NPCs",
			"Me atacó mientras estaba cerca de una mazmorra",
			"Me atacó mientras estaba AFK",
			"Me atacó mientras estaba montado / volando",
			"Me atacó mientras tenía poca vida / maná",
		};
	},
	[2] = {
		["title"] = "Style of combat";
		["content"] = {
			"Me emboscó",
			"Siempre me ataca cuando me ve",
			"Killed me with a higher level character",
			"Steamrolled me with a group of enemies",
			"No ataca sin ayuda",
			"Siempre pide ayuda a otros enemigos.",
			"Uses too much crowd control",
		};
	},
	[3] = {
		["title"] = "Camping";
		["content"] = {
			"Camped me",
			"Camped an alt",
			"Camped lowbies",
			"Camped from stealth",
			"Camped guild members",
			"Camped game NPCs/objectives",
			"Camped a city/site",
		};
	},
	[4] = {
		["title"] = "Questing";
		["content"] = {
			"Me atacó mientras estaba haciendo una mision",
			"Me atacó después de ayudarle con una mision",
			"Interfered with a quest objective",
			"Started a quest I wanted to do",
			"Killed my faction's NPCs",
			"Killed a quest NPC",
		};
	},
	[5] = {
		["title"] = "Stole resources";
		["content"] = {
			"Gathered herbs I wanted",
			"Gathered minerals I wanted",
			"Gathered resources I wanted",
			"Killed me and stole my target/rare NPC",
			"Skinned my kills",
			"Salvaged my kills",
			"Fished in my pool",
		};
	},
	[6] = {
		["title"] = "Other";
		["content"] = {
			"Flagged for PvP",
			"Pushed me off a cliff",
			"Uses engineering tricks",
			"Siempre escapa",
			"Uses items and skills to escape",
			"Exploits game mechanics",
			"Enter your own reason...",
		};
	},
}

StaticPopupDialogs["Spy_SetKOSReasonOther"] = {
	preferredIndex=STATICPOPUPS_NUMDIALOGS,  -- http://forums.wowace.com/showthread.php?p=320956
	text = "Enter the Kill On Sight reason for %s:",
	button1 = "Set",
	button2 = "Cancelar",
	timeout = 120,
	hasEditBox = 1,
	editBoxWidth = 260,	
	whileDead = 1,
	hideOnEscape = 1,
	OnShow = function(self)
		self.editBox:SetText("");
	end,
   	OnAccept = function(self)
		local reason = self.editBox:GetText()
		Spy:SetKOSReason(self.playerName, "Enter your own reason...", reason)
	end,
};

-- Class descriptions
L["UNKNOWN"] = "Desconocido"
L["DRUID"] = "Druida"
L["HUNTER"] = "Cazador"
L["MAGE"] = "Mago"
L["PALADIN"] = "Paladín"
L["PRIEST"] = "Sacerdote"
L["ROGUE"] = "Pícaro"
L["SHAMAN"] = "Chamán"
L["WARLOCK"] = "Brujo"
L["WARRIOR"] = "Guerrero"
L["DEATHKNIGHT"] = "Caballero de la muerte"
L["MONK"] = "Monje"
L["DEMONHUNTER"] = "Cazador de demonios"

-- Race descriptions
L["Human"] = "Humano"
L["Orc"] = "Orco"
L["Dwarf"] = "Enano"
L["Tauren"] = "Tauren"
L["Troll"] = "Trol"
L["Night Elf"] = "Elfo de la noche"
L["Undead"] = "No-muerto"
L["Gnome"] = "Gnomo"
L["Blood Elf"] = "Elfo de sangre"
L["Draenei"] = "Draenei"
L["Goblin"] = "Goblin"
L["Worgen"] = "Huargen"
L["Pandaren"] = "Pandaren"
L["Highmountain Tauren"] = "Tauren Monte Alto"
L["Lightforged Draenei"] = "Draenei forjado por la Luz"
L["Nightborne"] = "Nocheterna"
L["Void Elf"] = "Elfo del Vacío"
L["Dark Iron Dwarf"] = "Enano Hierro Negro"
L["Mag'har Orc"] = "Orco Mag'har"
L["Kul Tiran"] = "Ciudadano de Kul Tiras"
L["Zandalari Troll"] = "Trol Zandalari"
L["Mechagnome"] = "Mecagnomo"
L["Vulpera"] = "Vulpera"
 
-- Stealth abilities
L["Stealth"] = "Sigilo"
L["Acechar"] = "Acechar"
 
-- Minimap color codes
L["MinimapGuildText"] = "|cffffffff"
L["MinimapClassTextUNKNOWN"] = "|cff191919"
L["MinimapClassTextDRUID"] = "|cffff7c0a"
L["MinimapClassTextHUNTER"] = "|cffaad372"
L["MinimapClassTextMAGE"] = "|cff68ccef"
L["MinimapClassTextPALADIN"] = "|cfff48cba"
L["MinimapClassTextPRIEST"] = "|cffffffff"
L["MinimapClassTextROGUE"] = "|cfffff468"
L["MinimapClassTextSHAMAN"] = "|cff2359ff"
L["MinimapClassTextWARLOCK"] = "|cff9382c9"
L["MinimapClassTextWARRIOR"] = "|cffc69b6d"
L["MinimapClassTextDEATHKNIGHT"] = "|cffc41e3a"
L["MinimapClassTextMONK"] = "|cff00ff96"
L["MinimapClassTextDEMONHUNTER"] = "|cffa330c9"

Spy_AbilityList = {
-----------------------------------------------------------
-- Allows an estimation of the race, class and level of a
-- player based on the abilities observed in the combat log.
-----------------------------------------------------------

--++ Racial Traits ++	
	["Fisión de las Sombras"]={ class = "Night Elf", level = 1, },
	["Furia sangrienta"]={ class = "Orc", level = 1, },
	["Voluntad de los Renegados"]={ class = "Undead", level = 1, },
	["Petraforma"]={ class = "Dwarf", level = 1, },
	["Iracundia"]={ class = "Troll", level = 1, },
	["Firmeza"]={ class = "Orc", level = 1, },
	["Especialización en espada"]={ class = "Human", level = 1, },
	["Artista del escape"]={ class = "Gnome", level = 1, },
	["El espíritu humano"]={ class = "Human", level = 1, },
	["Regeneración"]={ class = "Troll", level = 1, },
	["Percepción"]={ class = "Human", level = 1, },
	["Aguante"]={ class = "Tauren", level = 1, },
	["Especialización en arcos"]={ class = "Troll", level = 1, },
	["Cultivo"]={ class = "Tauren", level = 1, },
	["Especialización de ingeniería"]={ class = "Gnome", level = 1, },
	["Pisotón de guerra"]={ class = "Tauren", level = 1, },
	["Matanza de bestias"]={ class = "Troll", level = 1, },
	["Buscar tesoro"]={ class = "Dwarf", level = 1, },
	["Especialización en hachas"]={ class = "Orc", level = 1, },
	["Canibalizar"]={ class = "Undead", level = 1, },
	["Diplomacia"]={ class = "Human", level = 1, },
	["Prontitud"]={ class = "Night Elf", level = 1, },
	["Especialización en lanzamiento"]={ class = "Troll", level = 1, },
	["Especialización con mazas"]={ class = "Human", level = 1, },
	["Especialización en armas de fuego"]={ class = "Dwarf", level = 1, },
	["Respiración subacuática"]={ class = "Undead", level = 1, },
	["Comandar"]={ class = "Orc", level = 1, },
	["Resistencia a la naturaleza"]={ class = "Night Elf", level = 1, },
	["Resistencia a la Escarcha"]={ class = "Dwarf", level = 1, },
	["Resistencia a las Sombras"]={ class = "Undead", level = 1, },
	["Resistencia Arcana"]={ class = "Gnome", level = 1, },
	["Espíritu de fuego fatuo"]={ class = "Night Elf", level = 1, },

	--++ Druid Abilities ++	
	["Toque curativo"]={ class = "DRUID", level = 1, },
	["Cólera"]={ class = "DRUID", level = 1, },
	["Fuegolunar"]={ class = "DRUID", level = 4, },
	["Enredaderas"]={ class = "DRUID", level = 8, },
	["Forma de oso"]={ class = "DRUID", level = 10, },
	["Clamor desmoralizador"]={ class = "DRUID", level = 10, },
	["Bramido"]={ class = "DRUID", level = 10, },
	["Machaque"]={ class = "DRUID", level = 10, },
	["Teletransporte a: Claro de la Luna"]={ class = "DRUID", level = 10, },
	["Enfurecer"]={ class = "DRUID", level = 12, },
	["Recrecimiento"]={ class = "DRUID", level = 12, },
	["Azote"]={ class = "DRUID", level = 14, },
	["Forma acuática"]={ class = "DRUID", level = 16, },
	["Flagelo"]={ class = "DRUID", level = 16, },
	["Fuego feérico"]={ class = "DRUID", level = 18, },
	["Hibernar"]={ class = "DRUID", level = 18, },
	["Forma felina"]={ class = "DRUID", level = 20, },
	["Zarpa"]={ class = "DRUID", level = 20, },
	["Acechar"]={ class = "DRUID", level = 20, },
	["Renacer"]={ class = "DRUID", level = 20, },
	["Destripar"]={ class = "DRUID", level = 20, },
	["Fuego estelar"]={ class = "DRUID", level = 20, },
	["Triturar"]={ class = "DRUID", level = 22, },
	["Calmar animal"]={ class = "DRUID", level = 22, },
	["Arañazo"]={ class = "DRUID", level = 24, },
	["Deshacer maldición"]={ class = "DRUID", level = 24, },
	["Furia del tigre"]={ class = "DRUID", level = 24, },
	["Suprimir veneno"]={ class = "DRUID", level = 26, },
	["Diligencia"]={ class = "DRUID", level = 26, },
	["Clamor desafiante"]={ class = "DRUID", level = 28, },
	["Pavor"]={ class = "DRUID", level = 28, },
	["Forma de viaje"]={ class = "DRUID", level = 30, },
	["Mordedura feroz"]={ class = "DRUID", level = 32, },
	["Devastar"]={ class = "DRUID", level = 32, },
	["Regeneración frenética"]={ class = "DRUID", level = 36, },
	["Lanzarse"]={ class = "DRUID", level = 36, },
	["Forma de oso nefasto"]={ class = "DRUID", level = 40, },
--++ Druid Talents ++	
	["Gracia de la naturaleza"]={ class = "DRUID", level = 10, },
	["Embestida feral"]={ class = "DRUID", level = 20, },
	["Enjambre de insectos"]={ class = "DRUID", level = 20, },
	["Augurio de claridad"]={ class = "DRUID", level = 20, },
	["Fuego feérico (feral)"]={ class = "DRUID", level = 30, },
--++ Hunter Abilities ++	
	["Presteza"]={ class = "HUNTER", level = 1, },
	["Tiro automático"]={ class = "HUNTER", level = 1, },
	["Golpe de raptor"]={ class = "HUNTER", level = 1, },
	["Rastrear bestias"]={ class = "HUNTER", level = 1, },
	["Aspecto del mono"]={ class = "HUNTER", level = 4, },
	["Aguijón de serpiente"]={ class = "HUNTER", level = 4, },
	["Tiro Arcano"]={ class = "HUNTER", level = 6, },
	["Marca del cazador"]={ class = "HUNTER", level = 6, },
	["Disparo de concusión"]={ class = "HUNTER", level = 8, },
	["Aspecto del halcón"]={ class = "HUNTER", level = 10, },
	["Llamar a mascota"]={ class = "HUNTER", level = 10, },
	["Retirar mascota"]={ class = "HUNTER", level = 10, },
	["Alimentar mascota"]={ class = "HUNTER", level = 10, },
	["Revivir mascota"]={ class = "HUNTER", level = 10, },
	["Domesticar bestia"]={ class = "HUNTER", level = 10, },
	["Disparo de distracción"]={ class = "HUNTER", level = 12, },
	["Sanar mascota"]={ class = "HUNTER", level = 12, },
	["Cortar alas"]={ class = "HUNTER", level = 12, },
	["Ojo de águila"]={ class = "HUNTER", level = 14, },
	["Ojos de la bestia"]={ class = "HUNTER", level = 14, },
	["Bestia temible"]={ class = "HUNTER", level = 14, },
	["Trampa de inmolación"]={ class = "HUNTER", level = 16, },
	["Mordedura de mangosta"]={ class = "HUNTER", level = 16, },
	["Multidisparo"]={ class = "HUNTER", level = 18, },
	["Rastrear no-muertos"]={ class = "HUNTER", level = 18, },
	["Aspecto del guepardo"]={ class = "HUNTER", level = 20, },
	["Separación"]={ class = "HUNTER", level = 20, },
	["Trampa congelante"]={ class = "HUNTER", level = 20, },
	["Aguijón de escorpido"]={ class = "HUNTER", level = 22, },
	["Tradición de bestias"]={ class = "HUNTER", level = 24, },
	["Rastrear lo oculto"]={ class = "HUNTER", level = 24, },
	["Fuego veloz"]={ class = "HUNTER", level = 26, },
	["Rastrear elementales"]={ class = "HUNTER", level = 26, },
	["Trampa de Escarcha"]={ class = "HUNTER", level = 28, },
	["Aspecto de la bestia"]={ class = "HUNTER", level = 30, },
	["Fingir muerte"]={ class = "HUNTER", level = 30, },
	["Bengala"]={ class = "HUNTER", level = 32, },
	["Rastrear demonios"]={ class = "HUNTER", level = 32, },
	["Trampa explosiva"]={ class = "HUNTER", level = 34, },
	["Picadura de víbora"]={ class = "HUNTER", level = 36, },
	["Aspecto de la manada"]={ class = "HUNTER", level = 40, },
	["Rastrear gigantes"]={ class = "HUNTER", level = 40, },
	["Lluvia"]={ class = "HUNTER", level = 40, },
	["Aspecto salvaje"]={ class = "HUNTER", level = 46, },
	["Rastrear dragonantes"]={ class = "HUNTER", level = 50, },
	["Disparo tranquilizante"]={ class = "HUNTER", level = 60, },
--++ Hunter Talents ++	
	["Tiro de puntería"]={ class = "HUNTER", level = 20, },
	["Disuasión"]={ class = "HUNTER", level = 20, },
	["Contraataque"]={ class = "HUNTER", level = 30, },
	["Intimidación"]={ class = "HUNTER", level = 30, },
	["Disparo disperso"]={ class = "HUNTER", level = 30, },
	["Ira de bestias"]={ class = "HUNTER", level = 40, },
	["Aguijón de dracoleón"]={ class = "HUNTER", level = 40, },
--++ Mage Abilities ++	
	["Bola de Fuego"]={ class = "MAGE", level = 1, },
	["Armadura de Escarcha"]={ class = "MAGE", level = 1, },
	["Descarga de Escarcha"]={ class = "MAGE", level = 4, },
	["Conjurar agua"]={ class = "MAGE", level = 4, },
	["Explosión de Fuego"]={ class = "MAGE", level = 6, },
	["Conjurar comida"]={ class = "MAGE", level = 6, },
	["Misiles Arcanos"]={ class = "MAGE", level = 8, },
	["Polimorfia"]={ class = "MAGE", level = 8, },
	["Nova de Escarcha"]={ class = "MAGE", level = 10, },
	["Deflagración Arcana"]={ class = "MAGE", level = 14, },
	["Detectar magia"]={ class = "MAGE", level = 16, },
	["Fogonazo"]={ class = "MAGE", level = 16, },
	["Deshacer maldición inferior"]={ class = "MAGE", level = 18, },
	["Traslación"]={ class = "MAGE", level = 20, },
	["Ventisca"]={ class = "MAGE", level = 20, },
	["Evocación"]={ class = "MAGE", level = 20, },
	["Custodia de Fuego"]={ class = "MAGE", level = 20, },
	["Escudo de maná"]={ class = "MAGE", level = 20, },
	["Teletransporte a: Forjaz"]={ class = "MAGE", level = 20, },
	["Teletransporte a: Orgrimmar"]={ class = "MAGE", level = 20, },
	["Teletransporte a: Ventormenta"]={ class = "MAGE", level = 20, },
	["Teletransporte a: Entrañas"]={ class = "MAGE", level = 20, },
	["Custodia de Escarcha"]={ class = "MAGE", level = 22, },
	["Chamuscar"]={ class = "MAGE", level = 22, },
	["Contrahechizo"]={ class = "MAGE", level = 24, },
	["Cono de frío"]={ class = "MAGE", level = 26, },
	["Conjurar ágata de maná"]={ class = "MAGE", level = 28, },
	["Armadura de hielo"]={ class = "MAGE", level = 30, },
	["Teletransporte a Darnassus"]={ class = "MAGE", level = 30, },
	["Teletransporte a: Cima del Trueno"]={ class = "MAGE", level = 30, },
	["Armadura de mago"]={ class = "MAGE", level = 34, },
	["Conjurar jade de maná"]={ class = "MAGE", level = 38, },
	["Portal: Forjaz"]={ class = "MAGE", level = 40, },
	["Portal: Orgrimmar"]={ class = "MAGE", level = 40, },
	["Portal: Ventormenta"]={ class = "MAGE", level = 40, },
	["Portal: Entrañas"]={ class = "MAGE", level = 40, },
	["Conjurar citrino de maná"]={ class = "MAGE", level = 48, },
	["Portal: Darnassus"]={ class = "MAGE", level = 50, },
	["Portal: Cima del Trueno"]={ class = "MAGE", level = 50, },
	["Resplandor Arcano"]={ class = "MAGE", level = 56, },
	["Conjurar rubí de maná"]={ class = "MAGE", level = 58, },
	["Polimorfia: vaca"]={ class = "MAGE", level = 60, },
	["Polimorfia"]={ class = "MAGE", level = 60, },
	["Polimorfia"]={ class = "MAGE", level = 60, },
--++ Mage Talents ++	
	["Ola de frío"]={ class = "MAGE", level = 20, },
	["Piroexplosión"]={ class = "MAGE", level = 20, },
	["Ola explosiva"]={ class = "MAGE", level = 30, },
	["Bloqueo de hielo"]={ class = "MAGE", level = 30, },
	["Presencia mental"]={ class = "MAGE", level = 30, },
	["Poder Arcano"]={ class = "MAGE", level = 40, },
	["Combustión"]={ class = "MAGE", level = 40, },
	["Barrera de hielo"]={ class = "MAGE", level = 40, },
--++ Paladin Abilities ++	
	["Luz Sagrada"]={ class = "PALADIN", level = 1, },
	["Sello de rectitud"]={ class = "PALADIN", level = 1, },
	["Sentencia"]={ class = "PALADIN", level = 4, },
	["Protección divina"]={ class = "PALADIN", level = 6, },
	["Sello del Cruzado"]={ class = "PALADIN", level = 6, },
	["Martillo de justicia"]={ class = "PALADIN", level = 8, },
	["Purificar"]={ class = "PALADIN", level = 8, },
	["Emposición"]={ class = "PALADIN", level = 10, },
	["Redención"]={ class = "PALADIN", level = 12, },
	["Furia justa"]={ class = "PALADIN", level = 16, },
	["Exorcismo"]={ class = "PALADIN", level = 20, },
	["Destello de Luz"]={ class = "PALADIN", level = 20, },
	["Captar no-muertes"]={ class = "PALADIN", level = 20, },
	["Sello de justicia"]={ class = "PALADIN", level = 22, },
	["Ahuyentar a no-muerto"]={ class = "PALADIN", level = 24, },
	["Bendición de Salvación"]={ class = "PALADIN", level = 26, },
	["Intervención divina"]={ class = "PALADIN", level = 30, },
	["Sello de luz"]={ class = "PALADIN", level = 30, },
	["Escudo divino"]={ class = "PALADIN", level = 34, },
	["Sello de sabiduría"]={ class = "PALADIN", level = 38, },
	["Bendición de la luz"]={ class = "PALADIN", level = 40, },
	["Invocar a caballo de combate"]={ class = "PALADIN", level = 40, },
	["Purgación"]={ class = "PALADIN", level = 42, },
	["Martillo de cólera"]={ class = "PALADIN", level = 44, },
	["Cólera sagrada"]={ class = "PALADIN", level = 50, },
	["Invocar a cargador"]={ class = "PALADIN", level = 60, },
--++ Paladin Talents ++	
	["Consagración"]={ class = "PALADIN", level = 20, },
	["Sello de orden"]={ class = "PALADIN", level = 20, },
	["Favor divino"]={ class = "PALADIN", level = 30, },
	["Escudo Sagrado"]={ class = "PALADIN", level = 40, },
	["Choque Sagrado"]={ class = "PALADIN", level = 40, },
	["Arrepentimiento"]={ class = "PALADIN", level = 40, },
--++ Priest Abilities ++	
	["Curación inferior"]={ class = "PRIEST", level = 1, },
	["Acometida"]={ class = "PRIEST", level = 1, },
	["Palabra de las Sombras: Dolor"]={ class = "PRIEST", level = 4, },
	["Desvanecer"]={ class = "PRIEST", level = 8, },
	["Rezo desesperado"]={ class = "PRIEST", level = 10, },
	["Maleficio de debilidad"]={ class = "PRIEST", level = 10, },
	["Explosión mental"]={ class = "PRIEST", level = 10, },
	["Resurrección"]={ class = "PRIEST", level = 10, },
	["Fragmentos estelares"]={ class = "PRIEST", level = 10, },
	["Toque de debilidad"]={ class = "PRIEST", level = 10, },
	["Fuego interno"]={ class = "PRIEST", level = 12, },
	["Alarido psíquico"]={ class = "PRIEST", level = 14, },
	["Curar"]={ class = "PRIEST", level = 16, },
	["Disipar magia"]={ class = "PRIEST", level = 18, },
	["Peste devoradora"]={ class = "PRIEST", level = 20, },
	["Gracia de Elune"]={ class = "PRIEST", level = 20, },
	["Rebote"]={ class = "PRIEST", level = 20, },
	["Destello curativo"]={ class = "PRIEST", level = 20, },
	["Fuego Sagrado"]={ class = "PRIEST", level = 20, },
	["Calma mental"]={ class = "PRIEST", level = 20, },
	["Encadenar no-muerto"]={ class = "PRIEST", level = 20, },
	["Guardia de las Sombras"]={ class = "PRIEST", level = 20, },
	["Visión mental"]={ class = "PRIEST", level = 22, },
	["Quemar maná"]={ class = "PRIEST", level = 24, },
	["Control mental"]={ class = "PRIEST", level = 30, },
	["Rezo de curación"]={ class = "PRIEST", level = 30, },
	["Suprimir enfermedad"]={ class = "PRIEST", level = 32, },
	["Levitar"]={ class = "PRIEST", level = 34, },
	["Curación superior"]={ class = "PRIEST", level = 40, },
--++ Priest Talents ++	
	["Nova Sagrada"]={ class = "PRIEST", level = 20, },
	["Enfoque interno"]={ class = "PRIEST", level = 20, },
	["Despelleje mental"]={ class = "PRIEST", level = 20, },
	["Silencio"]={ class = "PRIEST", level = 30, },
	["Pozo de Luz"]={ class = "PRIEST", level = 40, },
	["Forma de las Sombras"]={ class = "PRIEST", level = 40, },
--++ Rogue Abilities ++	
	["Eviscerar"]={ class = "ROGUE", level = 1, },
	["Ganzúa"]={ class = "ROGUE", level = 1, },
	["Golpe siniestro"]={ class = "ROGUE", level = 1, },
	["Sigilo"]={ class = "ROGUE", level = 1, },
	["Puñalada"]={ class = "ROGUE", level = 4, },
	["Robar"]={ class = "ROGUE", level = 4, },
	["Incapacitación"]={ class = "ROGUE", level = 6, },
	["Evasión"]={ class = "ROGUE", level = 8, },
	["Zapar"]={ class = "ROGUE", level = 10, },
	["Hacer picadillo"]={ class = "ROGUE", level = 10, },
	["Correr"]={ class = "ROGUE", level = 10, },
	["Patada"]={ class = "ROGUE", level = 12, },
	["Exponer armadura"]={ class = "ROGUE", level = 14, },
	["Garrote"]={ class = "ROGUE", level = 14, },
	["Amago"]={ class = "ROGUE", level = 16, },
	["Emboscada"]={ class = "ROGUE", level = 18, },
	["Venenos"]={ class = "ROGUE", level = 20, },
	["Ruptura"]={ class = "ROGUE", level = 20, },
	["Veneno paralizante"]={ class = "ROGUE", level = 20, },
	["Veneno instantáneo"]={ class = "ROGUE", level = 20, },
	["Distraer"]={ class = "ROGUE", level = 22, },
	["Esfumar"]={ class = "ROGUE", level = 22, },
	["Detectar trampas"]={ class = "ROGUE", level = 24, },
	["Veneno de aturdimiento mental"]={ class = "ROGUE", level = 24, },
	["Golpe bajo"]={ class = "ROGUE", level = 26, },
	["Desactivar trampa"]={ class = "ROGUE", level = 30, },
	["Golpe a los riñones"]={ class = "ROGUE", level = 30, },
	["Veneno mortal"]={ class = "ROGUE", level = 30, },
	["Envenenar herida"]={ class = "ROGUE", level = 32, },
	["Ceguera"]={ class = "ROGUE", level = 34, },
	["Polvo cegador"]={ class = "ROGUE", level = 34, },
	["Caída segura"]={ class = "ROGUE", level = 40, },
--++ Rogue Talents ++	
	["Golpe fantasmal"]={ class = "ROGUE", level = 20, },
	["Estocada"]={ class = "ROGUE", level = 20, },
	["Ráfaga con espada"]={ class = "ROGUE", level = 30, },
	["Sangre fría"]={ class = "ROGUE", level = 30, },
	["Hemorragia"]={ class = "ROGUE", level = 30, },
	["Preparación"]={ class = "ROGUE", level = 30, },
	["Subidón de adrenalina"]={ class = "ROGUE", level = 40, },
	["Premeditación"]={ class = "ROGUE", level = 40, },
--++ Shaman Abilities ++	
	["Onda de curación"]={ class = "SHAMAN", level = 1, },
	["Descarga de relámpagos"]={ class = "SHAMAN", level = 1, },
	["Arma comerrocas"]={ class = "SHAMAN", level = 1, },
	["Choque de tierra"]={ class = "SHAMAN", level = 4, },
	["Tótem piel de piedra"]={ class = "SHAMAN", level = 4, },
	["Tótem nexo terrestre"]={ class = "SHAMAN", level = 6, },
	["Escudo de relámpagos"]={ class = "SHAMAN", level = 8, },
	["Tótem Garra de piedra"]={ class = "SHAMAN", level = 8, },
	["Choque de llamas"]={ class = "SHAMAN", level = 10, },
	["Arma lengua de Fuego"]={ class = "SHAMAN", level = 10, },
	["Tótem abrasador"]={ class = "SHAMAN", level = 10, },
	["Fuerza de tótem de la Tierra"]={ class = "SHAMAN", level = 10, },
	["Espíritu ancestral"]={ class = "SHAMAN", level = 12, },
	["Tótem Nova de Fuego"]={ class = "SHAMAN", level = 12, },
	["Purgar"]={ class = "SHAMAN", level = 12, },
	["Tótem de tremor"]={ class = "SHAMAN", level = 18, },
	["Choque de Escarcha"]={ class = "SHAMAN", level = 20, },
	["Arma Estigma de Escarcha"]={ class = "SHAMAN", level = 20, },
	["Lobo fantasmal"]={ class = "SHAMAN", level = 20, },
	["Tótem de corriente curativa"]={ class = "SHAMAN", level = 20, },
	["Onda inferior de curación"]={ class = "SHAMAN", level = 20, },
	["Tótem de purificación de veneno"]={ class = "SHAMAN", level = 22, },
	["Tótem de resistencia a la Escarcha"]={ class = "SHAMAN", level = 24, },
	["Visión lejana"]={ class = "SHAMAN", level = 26, },
	["Tótem de magma"]={ class = "SHAMAN", level = 26, },
	["Tótem de fuente de maná"]={ class = "SHAMAN", level = 26, },
	["Tótem de Resistencia al Fuego"]={ class = "SHAMAN", level = 28, },
	["Tótem lengua de Fuego"]={ class = "SHAMAN", level = 28, },
	["Viaje astral"]={ class = "SHAMAN", level = 30, },
	["Tótem derribador"]={ class = "SHAMAN", level = 30, },
	["Tótem de resistencia a la naturaleza"]={ class = "SHAMAN", level = 30, },
	["Reencarnación"]={ class = "SHAMAN", level = 30, },
	["Arma tótem Viento Furioso"]={ class = "SHAMAN", level = 30, },
	["Cadena de relámpagos"]={ class = "SHAMAN", level = 32, },
	["Tótem Viento Furioso"]={ class = "SHAMAN", level = 32, },
	["Tótem centinela"]={ class = "SHAMAN", level = 34, },
	["Tótem muro de viento"]={ class = "SHAMAN", level = 36, },
	["Tótem purgador de enfermedades"]={ class = "SHAMAN", level = 38, },
	["Curación en cadena"]={ class = "SHAMAN", level = 40, },
	["Tótem gracia del aire"]={ class = "SHAMAN", level = 42, },
	["Tótem de aire sosegado"]={ class = "SHAMAN", level = 50, },
--++ Shaman Talents ++	
	["Parar"]={ class = "SHAMAN", level = 30, },
	["Maestría elemental"]={ class = "SHAMAN", level = 40, },
	["Tótem de marea de maná"]={ class = "SHAMAN", level = 40, },
	["Golpe de tormenta"]={ class = "SHAMAN", level = 40, },
--++ Warlock Abilities ++	
	["Piel de demonio"]={ class = "WARLOCK", level = 1, },
	["Inmolar"]={ class = "WARLOCK", level = 1, },
	["Descarga de las Sombras"]={ class = "WARLOCK", level = 1, },
	["Invocar a diablillo"]={ class = "WARLOCK", level = 1, },
	["Corrupción"]={ class = "WARLOCK", level = 4, },
	["Maldición de debilidad"]={ class = "WARLOCK", level = 4, },
	["Transfusión de vida"]={ class = "WARLOCK", level = 6, },
	["Maldición de Agonía"]={ class = "WARLOCK", level = 8, },
	["Miedo"]={ class = "WARLOCK", level = 8, },
	["Crear piedra de salud (menor)"]={ class = "WARLOCK", level = 10, },
	["Drenar alma"]={ class = "WARLOCK", level = 10, },
	["Invocar a abisario"]={ class = "WARLOCK", level = 10, },
	["Cauce de salud"]={ class = "WARLOCK", level = 12, },
	["Maldición de Temeridad"]={ class = "WARLOCK", level = 14, },
	["Drenar vida"]={ class = "WARLOCK", level = 14, },
	["Fuerza inmortal"]={ class = "WARLOCK", level = 16, },
	["Dolor abrasador"]={ class = "WARLOCK", level = 18, },
	["Crear piedra de alma (menor)"]={ class = "WARLOCK", level = 18, },
	["Armadura demoníaca"]={ class = "WARLOCK", level = 20, },
	["Lluvia de Fuego"]={ class = "WARLOCK", level = 20, },
	["Ritual de invocación"]={ class = "WARLOCK", level = 20, },
	["Invocar a súcubo"]={ class = "WARLOCK", level = 20, },
	["Crear piedra de salud (inferior)"]={ class = "WARLOCK", level = 22, },
	["Ojo de Kilrogg"]={ class = "WARLOCK", level = 22, },
	["Drenar maná"]={ class = "WARLOCK", level = 24, },
	["Captar demonios"]={ class = "WARLOCK", level = 24, },
	["Maldición de la lengua"]={ class = "WARLOCK", level = 26, },
	["Detectar invisibilidad inferior"]={ class = "WARLOCK", level = 26, },
	["Desterrar"]={ class = "WARLOCK", level = 28, },
	["Crear pirorroca (inferior)"]={ class = "WARLOCK", level = 28, },
	["Esclavizar demonio"]={ class = "WARLOCK", level = 30, },
	["Piroinferno"]={ class = "WARLOCK", level = 30, },
	["Invocar a manáfago"]={ class = "WARLOCK", level = 30, },
	["Crear piedra de alma (inferior)"]={ class = "WARLOCK", level = 30, },
	["Maldición de los Elementos"]={ class = "WARLOCK", level = 32, },
	["Custodia de las Sombras"]={ class = "WARLOCK", level = 32, },
	["Crear piedra de salud"]={ class = "WARLOCK", level = 34, },
	["Crear pirorroca"]={ class = "WARLOCK", level = 36, },
	["Crear piedra de hechizos"]={ class = "WARLOCK", level = 36, },
	["Detectar invisibilidad"]={ class = "WARLOCK", level = 38, },
	["Aullido de terror"]={ class = "WARLOCK", level = 40, },
	["Invocar a corcel nefasto"]={ class = "WARLOCK", level = 40, },
	["Crear piedra de alma"]={ class = "WARLOCK", level = 40, },
	["Espiral mortal"]={ class = "WARLOCK", level = 42, },
	["Maldición de las Sombras"]={ class = "WARLOCK", level = 44, },
	["Crear piedra de salud (superior)"]={ class = "WARLOCK", level = 46, },
	["Crear pirorroca (superior)"]={ class = "WARLOCK", level = 46, },
	["Fuego de alma"]={ class = "WARLOCK", level = 48, },
	["Crear piedra de hechizos (superior)"]={ class = "WARLOCK", level = 48, },
	["Detectar invisibilidad superior"]={ class = "WARLOCK", level = 50, },
	["Inferno"]={ class = "WARLOCK", level = 50, },
	["Crear piedra de alma (superior)"]={ class = "WARLOCK", level = 50, },
	["Crear pirorroca (sublime)"]={ class = "WARLOCK", level = 56, },
	["Crear piedra de salud (sublime)"]={ class = "WARLOCK", level = 58, },
	["Maldición del apocalipsis"]={ class = "WARLOCK", level = 60, },
	["Ritual de condena"]={ class = "WARLOCK", level = 60, },
	["Invocar a corcel de la muerte"]={ class = "WARLOCK", level = 60, },
	["Crear piedra de alma (sublime)"]={ class = "WARLOCK", level = 60, },
	["Crear piedra de hechizos (sublime)"]={ class = "WARLOCK", level = 60, },
--++ Warlock Talents ++	
	["Amplificar maldición"]={ class = "WARLOCK", level = 20, },
	["Dominio de lo maldito"]={ class = "WARLOCK", level = 20, },
	["Quemadura de las Sombras"]={ class = "WARLOCK", level = 20, },
	["Maldición de agotamiento"]={ class = "WARLOCK", level = 30, },
	["Sacrificio demoníaco"]={ class = "WARLOCK", level = 30, },
	["Absorver vida"]={ class = "WARLOCK", level = 30, },
	["Conflagrar"]={ class = "WARLOCK", level = 40, },
	["Pacto oscuro"]={ class = "WARLOCK", level = 40, },
	["Vínculo de alma"]={ class = "WARLOCK", level = 40, },
--++ Warrior Abilities ++	
	["Posture de combat"]={ class = "WARRIOR", level = 1, },
	["Frappe héroïque"]={ class = "WARRIOR", level = 1, },
	["Volée de coups améliorée"]={ class = "WARRIOR", level = 1, },
	["Charge"]={ class = "WARRIOR", level = 4, },
	["Pourfendre"]={ class = "WARRIOR", level = 4, },
	["Coup de tonnerre"]={ class = "WARRIOR", level = 6, },
	["Brise-genou"]={ class = "WARRIOR", level = 8, },
	["Rage sanguinaire"]={ class = "WARRIOR", level = 10, },
	["Posture défensive"]={ class = "WARRIOR", level = 10, },
	["Fracasser armure"]={ class = "WARRIOR", level = 10, },
	["Provocation"]={ class = "WARRIOR", level = 10, },
	["Fulgurance"]={ class = "WARRIOR", level = 12, },
	["Coup de bouclier"]={ class = "WARRIOR", level = 12, },
	["Cri démoralisant"]={ class = "WARRIOR", level = 14, },
	["Vengeance"]={ class = "WARRIOR", level = 14, },
	["Coup railleur"]={ class = "WARRIOR", level = 16, },
	["Maîtrise du blocage"]={ class = "WARRIOR", level = 16, },
	["Désarmement"]={ class = "WARRIOR", level = 18, },
	["Enchaînement"]={ class = "WARRIOR", level = 20, },
	["Représailles"]={ class = "WARRIOR", level = 20, },
	["Cri d’intimidation"]={ class = "WARRIOR", level = 22, },
	["Exécution"]={ class = "WARRIOR", level = 24, },
	["Cri de défi"]={ class = "WARRIOR", level = 26, },
	["Mur protecteur"]={ class = "WARRIOR", level = 28, },
	["Posture berserker"]={ class = "WARRIOR", level = 30, },
	["Interception"]={ class = "WARRIOR", level = 30, },
	["Heurtoir"]={ class = "WARRIOR", level = 30, },
	["Rage berserker"]={ class = "WARRIOR", level = 32, },
	["Tourbillon"]={ class = "WARRIOR", level = 36, },
	["Volée de coups"]={ class = "WARRIOR", level = 38, },
	["Témérité"]={ class = "WARRIOR", level = 50, },
--++ Warrior Talents ++	
	["Dernier rempart"]={ class = "WARRIOR", level = 20, },
	["Hurlement perçant"]={ class = "WARRIOR", level = 20, },
	["Bourrasque"]={ class = "WARRIOR", level = 30, },
	["Souhait mortel"]={ class = "WARRIOR", level = 30, },
	["Attaques circulaires"]={ class = "WARRIOR", level = 30, },
	["Sanguinaire"]={ class = "WARRIOR", level = 40, },
	["Frappe mortelle"]={ class = "WARRIOR", level = 40, },
	["Heurt de bouclier"]={ class = "WARRIOR", level = 40, },
};

Spy_IgnoreList = {

};
 
