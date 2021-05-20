local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Spy", "enUS", true)
if not L then return end

-- Configuration
L["Spy"] = "Spy"
L["Version"] = "Version"
L["Spy Option"] = "Spy"
L["Profiles"] = "Profiles"

-- Information
L["About"] = "About"
L["SpyDescription1"] = [[
Spy is an addon that will alert you to the presence of nearby enemy players. These are some of the main features.
]]
L["SpyDescription2"] = [[
|cffffd000Nearby List|cffffffff
Displays enemy players that have been detected nearby. Players are removed from the list if they have not been detected after a period of time.

|cffffd000Last Hour List|cffffffff
Displays all enemies that have been detected in the last hour.

|cffffd000Ignore List|cffffffff
Players that are added to the Ignore list will not be reported by Spy. You can add and remove players to/from this list by using the button's drop down menu or by holding the Control key while clicking the button.

|cffffd000Kill On Sight List|cffffffff
Players on your Kill On Sight list cause an alarm to sound when detected. You can add and remove players to/from this list by using the button's drop down menu or by holding the Shift key while clicking the button.

The drop down menu can also be used to set the reasons why you have added someone to the Kill On Sight list. If you want to enter a specific reason that is not in the list, then use the "Enter your own reason..." in the Other list.

|cffffd000Statistics Window|cffffffff
The Statistics Window contains a list of all enemy encounters which can be sorted by name, level, guild, wins, losses and the last time an enemy was detected. It also provides the ability to search for a specific enemy by name or guild and has filters to show only enemies that are marked as Kill on Sight, with a Win/Loss or entered Reasons.

|cffffd000Kill On Sight Button|cffffffff
If enabled, this button will be located on the enemy players target frame. Clicking on this button will add/remove the enemy target to/from the Kill On Sight list. Right clicking on the button will allow you to enter Kill on Sight reasons.

|cffffd000Author: Slipjack|cffffffff
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
L["DisabledInZonesDescription"]	= "Select locations where Spy will be disabled"
L["Booty Bay"] = "Booty Bay"
L["Everlook"] = "Everlook"						
L["Gadgetzan"] = "Gadgetzan"
L["Ratchet"] = "Ratchet"
L["The Salty Sailor Tavern"] = "The Salty Sailor Tavern"
L["Shattrath City"] = "Shattrath City"
L["Area 52"] = "Area 52"
L["Dalaran"] = "Dalaran"
L["Dalaran (Northrend)"] = "Dalaran (Northrend)"
L["Bogpaddle"] = "Bogpaddle"
L["The Vindicaar"] = "The Vindicaar"
L["Krasus' Landing"] = "Krasus' Landing"
L["The Violet Gate"] = "The Violet Gate"
L["Magni's Encampment"] = "Magni's Encampment"
L["Silithus"] = "Silithus"
L["Chamber of Heart"] = "Chamber of Heart"
L["Hall of Ancient Paths"] = "Hall of Ancient Paths"
L["Sanctum of the Sages"] = "Sanctum of the Sages"

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
L["ClampToScreen"] = "Clamp to Screen"
L["ClampToScreenDescription"] = "Controls whether the Spy window can be dragged off screen."
L["InvertSpy"] = "Invert the Spy window"
L["InvertSpyDescription"] = "Flips the Spy window upside down."
L["Reload"] = "Reload UI"
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
L["DisplayListData"] = "Select enemy data to display"
L["Name"] = "Name"
L["Class"] = "Class"
L["SelectFont"] = "Select a Font"
L["SelectFontDescription"] = "Select a Font for the Spy Window."
L["RowHeight"] = "Select the Row Height"
L["RowHeightDescription"] = "Select the Row Height for the Spy window."
L["Texture"] = "Texture"
L["TextureDescription"] = "Select a texture for the Spy Window"

-- Alerts
L["AlertOptions"] = "Alerts"
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
L["SelfDescription"] = "Announce to yourself when enemy players are detected."
L["Party"] = "Party"
L["PartyDescription"] = "Announce to your party when enemy players are detected."
L["Guild"] = "Guild"
L["GuildDescription"] = "Announce to your guild when enemy players are detected."
L["Raid"] = "Raid"
L["RaidDescription"] = "Announce to your raid when enemy players are detected."
L["LocalDefense"] = "Local Defense"
L["LocalDefenseDescription"] = "Announce to the Local Defense channel when enemy players are detected."
L["OnlyAnnounceKoS"] = "Only announce enemy players that are Kill On Sight"
L["OnlyAnnounceKoSDescription"] = "Set this to only announce enemy players that are on your Kill On Sight list."
L["WarnOnStealth"] = "Warn upon stealth detection"
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
--L["DisplayWarningsInErrorsFrame"] = "Display warnings in the errors frame"
--L["DisplayWarningsInErrorsFrameDescription"] = "Set this to use the errors frame to display warnings instead of using the graphical popup frames."
L["DisplayWarnings"] = "Select warnings message location"
L["Default"] = "Default"
L["ErrorFrame"] = "Error Frame"
L["Moveable"] = "Moveable"
L["EnableSound"] = "Enable audio alerts"
L["EnableSoundDescription"] = "Set this to enable audio alerts when enemy players are detected. Different alerts sound if an enemy player gains stealth or if an enemy player is on your Kill On Sight list."
L["OnlySoundKoS"] = "Only sound audio alerts for Kill On Sight detection"
L["OnlySoundKoSDescription"] = "Set this to only play audio alerts when enemy players on the Kill on Sight list are detected."
L["StopAlertsOnTaxi"] = "Turn off alerts while on a flight path"
L["StopAlertsOnTaxiDescription"] = "Stop all new alerts and warnings while on a flight path."

-- Nearby List
L["ListOptions"] = "Nearby List"
L["ListOptionsDescription"] = [[
Options on how enemy players are added and removed.
]]
L["RemoveUndetected"] = "Remove enemy players from the Nearby list after:"
L["1Min"] = "1 minute"
L["1MinDescription"] = "Remove an enemy player who has been undetected for over 1 minute."
L["2Min"] = "2 minutes"
L["2MinDescription"] = "Remove an enemy player who has been undetected for over 2 minutes."
L["5Min"] = "5 minutes"
L["5MinDescription"] = "Remove an enemy player who has been undetected for over 5 minutes."
L["10Min"] = "10 minutes"
L["10MinDescription"] = "Remove an enemy player who has been undetected for over 10 minutes."
L["15Min"] = "15 minutes"
L["15MinDescription"] = "Remove an enemy player who has been undetected for over 15 minutes."
L["Never"] = "Never remove"
L["NeverDescription"] = "Never remove enemy players. The Nearby list can still be cleared manually."
L["ShowNearbyList"] = "Switch to the Nearby list upon enemy player detection"
L["ShowNearbyListDescription"] = "Set this to display the Nearby list if it is not already visible when enemy players are detected."
L["PrioritiseKoS"] = "Prioritise Kill On Sight enemy players in the Nearby list"
L["PrioritiseKoSDescription"] = "Set this to always show Kill On Sight enemy players first in the Nearby list."

-- Map
L["MapOptions"] = "Map"
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
L["LimitSameZone"] = "Same zone"
L["LimitSameZoneDescription"] = "Only displays detected enemies on the map if you are in the same zone."
L["LimitSameContinent"] = "Same continent"
L["LimitSameContinentDescription"] = "Only displays detected enemies on the map if you are on the same continent."

-- Data Management
L["DataOptions"] = "Data Management"
L["DataOptionsDescription"] = [[

Options on how Spy maintains and gathers data.
]]
L["PurgeData"] = "Purge undetected enemy player data after:"
L["OneDay"] = "1 day"
L["OneDayDescription"] = "Purge data for enemy players that have been undetected for 1 day."
L["FiveDays"] = "5 days"
L["FiveDaysDescription"] = "Purge data for enemy players that have been undetected for 5 days."
L["TenDays"] = "10 days"
L["TenDaysDescription"] = "Purge data for enemy players that have been undetected for 10 days."
L["ThirtyDays"] = "30 days"
L["ThirtyDaysDescription"] = "Purge data for enemy players that have been undetected for 30 days."
L["SixtyDays"] = "60 days"
L["SixtyDaysDescription"] = "Purge data for enemy players that have been undetected for 60 days."
L["NinetyDays"] = "90 days"
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
L["KOSDescription"] = "Add/remove a player to/from the Kill On Sight list."
L["InvalidInput"] = "Invalid Input"
L["Ignore"] = "Ignore"
L["IgnoreDescription"] = "Add/remove a player to/from the Ignore list."
L["Test"] = "Test"
L["TestDescription"] = "Shows a warning so it can be repositioned."

-- Lists
L["Nearby"] = "Nearby"
L["LastHour"] = "Last Hour"
L["Ignore"] = "Ignore"
L["KillOnSight"] = "Kill On Sight"

--Stats
L["Won"] = "Won"
L["Lost"] = "Lost"
L["Time"] = "Time"	
L["List"] = "List"
L["Filter"] = "Filter"
L["Show Only"] = "Show Only"
L["KOS"] = "KOS"
L["Won/Lost"] = "Won/Lost"
L["Reason"] = "Reason"	 
L["HonorKills"] = "Honor Kills"
L["PvPDeaths"] = "PvP Deaths"

-- Output Messages
L["VersionCheck"] = "|cffc41e3aWarning! The wrong version of Spy is installed. Remove this version and install Spy Classic."
L["SpyEnabled"] = "|cff9933ffSpy addon enabled."
L["SpyDisabled"] = "|cff9933ffSpy addon disabled. Type |cffffffff/spy show|cff9933ff to enable."
L["UpgradeAvailable"] = "|cff9933ffA new version of Spy is available. It can be downloaded from:\n|cffffffffhttps://www.curseforge.com/wow/addons/spy-classic"
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
L["PlayerAddedToIgnoreColored"] = "Added player to Ignore list: |cffffffff"
L["PlayerRemovedFromIgnoreColored"] = "Removed player from Ignore list: |cffffffff"
L["PlayerAddedToKOSColored"] = "Added player to Kill On Sight list: |cffffffff"
L["PlayerRemovedFromKOSColored"] = "Removed player from Kill On Sight list: |cffffffff"
L["PlayerDetected"] = "[Spy] Player detected: "
L["KillOnSightDetected"] = "[Spy] Kill On Sight player detected: "
L["Level"] = "Level"
L["LastSeen"] = "Last seen"
L["LessThanOneMinuteAgo"] = "less than a minute ago"
L["MinutesAgo"] = "minutes ago"
L["HoursAgo"] = "hours ago"
L["DaysAgo"] = "days ago"
L["Close"] = "Close"
L["CloseDescription"] = "|cffffffffHides the Spy window. By default will show again when the next enemy player is detected."
L["Left/Right"] = "Left/Right"
L["Left/RightDescription"] = "|cffffffffNavigates between the Nearby, Last Hour, Ignore and Kill On Sight lists."
L["Clear"] = "Clear"
L["ClearDescription"] = "|cffffffffClears the list of players that have been detected. CTRL-Click will turn Spy On/Off. Shift-Click will turn all sound On/Off."
L["SoundEnabled"] = "Audio alerts enabled"
L["SoundDisabled"] = "Audio alerts disabled"
L["NearbyCount"] = "Nearby Count"
L["NearbyCountDescription"] = "|cffffffffCount of nearby players."
L["Statistics"] = "Statistics"
L["StatsDescription"] = "|cffffffffShows a list of enemy players encountered, win/loss records and where they were last seen."
L["AddToIgnoreList"] = "Add to Ignore list"
L["AddToKOSList"] = "Add to Kill On Sight list"
L["RemoveFromIgnoreList"] = "Remove from Ignore list"
L["RemoveFromKOSList"] = "Remove from Kill On Sight list"
L["RemoveFromStatsList"] = "Remove from Statistics List"
L["AnnounceDropDownMenu"] = "Announce"
L["KOSReasonDropDownMenu"] = "Set Kill On Sight reason"
L["PartyDropDownMenu"] = "Party"
L["RaidDropDownMenu"] = "Raid"
L["GuildDropDownMenu"] = "Guild"
L["LocalDefenseDropDownMenu"] = "Local Defense"
L["Player"] = " (Player)"
L["KOSReason"] = "Kill On Sight"
L["KOSReasonIndent"] = "    "
L["KOSReasonOther"] = "Enter your own reason..."
L["KOSReasonClear"] = "Clear Reason"
L["StatsWins"] = "|cff40ff00Wins: "
L["StatsSeparator"] = "  "
L["StatsLoses"] = "|cff0070ddLosses: "
L["Located"] = "located:"
L["Yards"] = "yards"
L["LocalDefenseChannelName"] = "LocalDefense"

Spy_KOSReasonListLength = 6
Spy_KOSReasonList = {
	[1] = {
		["title"] = "Started combat";
		["content"] = {
			"Attacked me for no reason",
			"Attacked me at a quest giver", 
			"Attacked me while I was fighting NPCs",
			"Attacked me while I was near an instance",
			"Attacked me while I was AFK",
			"Attacked me while I was mounted/flying",
			"Attacked me while I had low health/mana",
		};
	},
	[2] = {
		["title"] = "Style of combat";
		["content"] = {
			"Ambushed me",
			"Always attacks me on sight",
			"Killed me with a higher level character",
			"Steamrolled me with a group of enemies",
			"Doesn't attack without backup",
			"Always calls for help",
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
			"Attacked me while I was questing",
			"Attacked me after I helped with a quest",
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
			"Always manages to escape",
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
	button2 = "Cancel",
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
L["UNKNOWN"] = "Unknown"
L["DRUID"] = "Druid"
L["HUNTER"] = "Hunter"
L["MAGE"] = "Mage"
L["PALADIN"] = "Paladin"
L["PRIEST"] = "Priest"
L["ROGUE"] = "Rogue"
L["SHAMAN"] = "Shaman"
L["WARLOCK"] = "Warlock"
L["WARRIOR"] = "Warrior"
L["DEATHKNIGHT"] = "Death Knight"
L["MONK"] = "Monk"
L["DEMONHUNTER"] = "Demon Hunter"

-- Race descriptions
L["Human"] = "Human"
L["Orc"] = "Orc"
L["Dwarf"] = "Dwarf"
L["Tauren"] = "Tauren"
L["Troll"] = "Troll"
L["Night Elf"] = "Night Elf"
L["Undead"] = "Undead"
L["Gnome"] = "Gnome"
L["Blood Elf"] = "Blood Elf"
L["Draenei"] = "Draenei"
L["Goblin"] = "Goblin"
L["Worgen"] = "Worgen"
L["Pandaren"] = "Pandaren"
L["Highmountain Tauren"] = "Highmountain Tauren"
L["Lightforged Draenei"] = "Lightforged Draenei"
L["Nightborne"] = "Nightborne"
L["Void Elf"] = "Void Elf"
L["Dark Iron Dwarf"] = "Dark Iron Dwarf"
L["Mag'har Orc"] = "Mag'har Orc"
L["Kul Tiran"] = "Kul Tiran"
L["Zandalari Troll"] = "Zandalari Troll"
L["Mechagnome"] = "Mechagnome"
L["Vulpera"] = "Vulpera"

-- Stealth abilities
L["Stealth"] = "Stealth"
L["Prowl"] = "Prowl"

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
	["Shadowmeld"]={ race = "Night Elf", level = 1, },
	["Blood Fury"]={ race = "Orc", level = 1, },
	["Will of the Forsaken"]={ race = "Undead", level = 1, },
	["Stoneform"]={ race = "Dwarf", level = 1, },
	["Berserking"]={ race = "Troll", level = 1, },
	["Hardiness"]={ race = "Orc", level = 1, },
	["Sword Specialization"]={ race = "Human", level = 1, },
	["Escape Artist"]={ race = "Gnome", level = 1, },
	["The Human Spirit"]={ race = "Human", level = 1, },
	["Regeneration"]={ race = "Troll", level = 1, },
	["Perception"]={ race = "Human", level = 1, },
	["Endurance"]={ race = "Tauren", level = 1, },
	["Bow Specialization"]={ race = "Troll", level = 1, },
	["Cultivation"]={ race = "Tauren", level = 1, },
	["Engineering Specialization"]={ race = "Gnome", level = 1, },
	["War Stomp"]={ race = "Tauren", level = 1, },
	["Beast Slaying"]={ race = "Troll", level = 1, },
	["Find Treasure"]={ race = "Dwarf", level = 1, },
	["Axe Specialization"]={ race = "Orc", level = 1, },
	["Cannibalize"]={ race = "Undead", level = 1, },
	["Diplomacy"]={ race = "Human", level = 1, },
	["Quickness"]={ race = "Night Elf", level = 1, },
	["Throwing Specialization"]={ race = "Troll", level = 1, },
	["Mace Specialization"]={ race = "Human", level = 1, },
	["Gun Specialization"]={ race = "Dwarf", level = 1, },
	["Underwater Breathing"]={ race = "Undead", level = 1, },
	["Command"]={ race = "Orc", level = 1, },
	["Nature Resistance"]={ race = "Night Elf", level = 1, },
	["Frost Resistance"]={ race = "Dwarf", level = 1, },
	["Shadow Resistance"]={ race = "Undead", level = 1, },
	["Arcane Resistance"]={ race = "Gnome", level = 1, },
	["Wisp Spirit"]={ race = "Night Elf", level = 1, },

--++ Druid Abilities ++	
	["Healing Touch"]={ class = "DRUID", level = 1, },
   	["Wrath"]={ class = "DRUID", level = 1, },
	["Moonfire"]={ class = "DRUID", level = 4, },
	["Entangling Roots"]={ class = "DRUID", level = 8, },
	["Bear Form"]={ class = "DRUID", level = 10, },
	["Demoralizing Roar"]={ class = "DRUID", level = 10, },
	["Growl"]={ class = "DRUID", level = 10, },
	["Maul"]={ class = "DRUID", level = 10, },
	["Teleport: Moonglade"]={ class = "DRUID", level = 10, },
	["Enrage"]={ class = "DRUID", level = 12, },
	["Regrowth"]={ class = "DRUID", level = 12, },
	["Bash"]={ class = "DRUID", level = 14, },
	["Aquatic Form"]={ class = "DRUID", level = 16, },
	["Swipe"]={ class = "DRUID", level = 16, },
	["Faerie Fire"]={ class = "DRUID", level = 18, },
	["Hibernate"]={ class = "DRUID", level = 18, },
	["Cat Form"]={ class = "DRUID", level = 20, },
	["Claw"]={ class = "DRUID", level = 20, },
	["Prowl"]={ class = "DRUID", level = 20, },
	["Rebirth"]={ class = "DRUID", level = 20, },
	["Rip"]={ class = "DRUID", level = 20, },
	["Starfire"]={ class = "DRUID", level = 20, },
	["Shred"]={ class = "DRUID", level = 22, },
	["Soothe Animal"]={ class = "DRUID", level = 22, },
	["Rake"]={ class = "DRUID", level = 24, },
	["Remove Curse"]={ class = "DRUID", level = 24, },
	["Tiger's Fury"]={ class = "DRUID", level = 24, },
	["Abolish Poison"]={ class = "DRUID", level = 26, },
	["Dash"]={ class = "DRUID", level = 26, },
	["Challenging Roar"]={ class = "DRUID", level = 28, },
	["Cower"]={ class = "DRUID", level = 28, },
	["Travel Form"]={ class = "DRUID", level = 30, },
	["Ferocious Bite"]={ class = "DRUID", level = 32, },
	["Ravage"]={ class = "DRUID", level = 32, },
	["Frenzied Regeneration"]={ class = "DRUID", level = 36, },
	["Pounce"]={ class = "DRUID", level = 36, },
	["Dire Bear Form"]={ class = "DRUID", level = 40, },
--++ Druid Talents ++	
	["Nature's Grasp"]={ class = "DRUID", level = 10, },
	["Feral Charge"]={ class = "DRUID", level = 20, },
	["Insect Swarm"]={ class = "DRUID", level = 20, },
	["Omen of Clarity"]={ class = "DRUID", level = 20, },
	["Faerie Fire (Feral)"]={ class = "DRUID", level = 30, },
--++ Hunter Abilities ++	
	["Readiness"]={ class = "HUNTER", level = 1, },
	["Auto Shot"]={ class = "HUNTER", level = 1, },
	["Raptor Strike"]={ class = "HUNTER", level = 1, },
	["Track Beasts"]={ class = "HUNTER", level = 1, },
	["Aspect of the Monkey"]={ class = "HUNTER", level = 4, },
	["Serpent Sting"]={ class = "HUNTER", level = 4, },
	["Arcane Shot"]={ class = "HUNTER", level = 6, },
	["Hunter's Mark"]={ class = "HUNTER", level = 6, },
	["Concussive Shot"]={ class = "HUNTER", level = 8, },
	["Aspect of the Hawk"]={ class = "HUNTER", level = 10, },
	["Call Pet"]={ class = "HUNTER", level = 10, },
	["Dismiss Pet"]={ class = "HUNTER", level = 10, },
	["Feed Pet"]={ class = "HUNTER", level = 10, },
	["Revive Pet"]={ class = "HUNTER", level = 10, },
	["Tame Beast"]={ class = "HUNTER", level = 10, },
	["Distracting Shot"]={ class = "HUNTER", level = 12, },
	["Mend Pet"]={ class = "HUNTER", level = 12, },
	["Wing Clip"]={ class = "HUNTER", level = 12, },
	["Eagle Eye"]={ class = "HUNTER", level = 14, },
	["Eyes of the Beast"]={ class = "HUNTER", level = 14, },
	["Scare Beast"]={ class = "HUNTER", level = 14, },
	["Immolation Trap"]={ class = "HUNTER", level = 16, },
	["Mongoose Bite"]={ class = "HUNTER", level = 16, },
	["Multi-Shot"]={ class = "HUNTER", level = 18, },
	["Track Undead"]={ class = "HUNTER", level = 18, },
	["Aspect of the Cheetah"]={ class = "HUNTER", level = 20, },
	["Disengage"]={ class = "HUNTER", level = 20, },
	["Freezing Trap"]={ class = "HUNTER", level = 20, },
	["Scorpid Sting"]={ class = "HUNTER", level = 22, },
	["Beast Lore"]={ class = "HUNTER", level = 24, },
	["Track Hidden"]={ class = "HUNTER", level = 24, },
	["Rapid Fire"]={ class = "HUNTER", level = 26, },
	["Track Elementals"]={ class = "HUNTER", level = 26, },
	["Frost Trap"]={ class = "HUNTER", level = 28, },
	["Aspect of the Beast"]={ class = "HUNTER", level = 30, },
	["Feign Death"]={ class = "HUNTER", level = 30, },
	["Flare"]={ class = "HUNTER", level = 32, },
	["Track Demons"]={ class = "HUNTER", level = 32, },
	["Explosive Trap"]={ class = "HUNTER", level = 34, },
	["Viper Sting"]={ class = "HUNTER", level = 36, },
	["Aspect of the Pack"]={ class = "HUNTER", level = 40, },
	["Track Giants"]={ class = "HUNTER", level = 40, },
	["Volley"]={ class = "HUNTER", level = 40, },
	["Aspect of the Wild"]={ class = "HUNTER", level = 46, },
	["Track Dragonkin"]={ class = "HUNTER", level = 50, },
	["Tranquilizing Shot"]={ class = "HUNTER", level = 60, },
--++ Hunter Talents ++	
	["Aimed Shot"]={ class = "HUNTER", level = 20, },
	["Deterrence"]={ class = "HUNTER", level = 20, },
	["Counterattack"]={ class = "HUNTER", level = 30, },
	["Intimidation"]={ class = "HUNTER", level = 30, },
	["Scatter Shot"]={ class = "HUNTER", level = 30, },
	["Bestial Wrath"]={ class = "HUNTER", level = 40, },
	["Wyvern Sting"]={ class = "HUNTER", level = 40, },
--++ Mage Abilities ++	
	["Fireball"]={ class = "MAGE", level = 1, },
	["Frost Armor"]={ class = "MAGE", level = 1, },
	["Frostbolt"]={ class = "MAGE", level = 4, },
	["Conjure Water"]={ class = "MAGE", level = 4, },
	["Fire Blast"]={ class = "MAGE", level = 6, },
	["Conjure Food"]={ class = "MAGE", level = 6, },
	["Arcane Missiles"]={ class = "MAGE", level = 8, },
	["Polymorph"]={ class = "MAGE", level = 8, },
	["Frost Nova"]={ class = "MAGE", level = 10, },
	["Arcane Explosion"]={ class = "MAGE", level = 14, },
	["Detect Magic"]={ class = "MAGE", level = 16, },
	["Flamestrike"]={ class = "MAGE", level = 16, },
	["Remove Lesser Curse"]={ class = "MAGE", level = 18, },
	["Blink"]={ class = "MAGE", level = 20, },
	["Blizzard"]={ class = "MAGE", level = 20, },
	["Evocation"]={ class = "MAGE", level = 20, },
	["Fire Ward"]={ class = "MAGE", level = 20, },
	["Mana Shield"]={ class = "MAGE", level = 20, },
	["Teleport: Ironforge"]={ class = "MAGE", level = 20, },
	["Teleport: Orgrimmar"]={ class = "MAGE", level = 20, },
	["Teleport: Stormwind"]={ class = "MAGE", level = 20, },
	["Teleport: Undercity"]={ class = "MAGE", level = 20, },
	["Frost Ward"]={ class = "MAGE", level = 22, },
	["Scorch"]={ class = "MAGE", level = 22, },
	["Counterspell"]={ class = "MAGE", level = 24, },
	["Cone of Cold"]={ class = "MAGE", level = 26, },
	["Conjure Mana Agate"]={ class = "MAGE", level = 28, },
	["Ice Armor"]={ class = "MAGE", level = 30, },
	["Teleport: Darnassus"]={ class = "MAGE", level = 30, },
	["Teleport: Thunder Bluff"]={ class = "MAGE", level = 30, },
	["Mage Armor"]={ class = "MAGE", level = 34, },
	["Conjure Mana Jade"]={ class = "MAGE", level = 38, },
	["Portal: Ironforge"]={ class = "MAGE", level = 40, },
	["Portal: Orgrimmar"]={ class = "MAGE", level = 40, },
	["Portal: Stormwind"]={ class = "MAGE", level = 40, },
	["Portal: Undercity"]={ class = "MAGE", level = 40, },
	["Conjure Mana Citrine"]={ class = "MAGE", level = 48, },
	["Portal: Darnassus"]={ class = "MAGE", level = 50, },
	["Portal: Thunder Bluff"]={ class = "MAGE", level = 50, },
	["Arcane Brilliance"]={ class = "MAGE", level = 56, },
	["Conjure Mana Ruby"]={ class = "MAGE", level = 58, },
	["Polymorph: Cow"]={ class = "MAGE", level = 60, },
	["Polymorph: Pig"]={ class = "MAGE", level = 60, },
	["Polymorph: Turtle"]={ class = "MAGE", level = 60, },
--++ Mage Talents ++	
	["Cold Snap"]={ class = "MAGE", level = 20, },
	["Pyroblast"]={ class = "MAGE", level = 20, },
	["Blast Wave"]={ class = "MAGE", level = 30, },
	["Ice Block"]={ class = "MAGE", level = 30, },
	["Presence of Mind"]={ class = "MAGE", level = 30, },
	["Arcane Power"]={ class = "MAGE", level = 40, },
	["Combustion"]={ class = "MAGE", level = 40, },
	["Ice Barrier"]={ class = "MAGE", level = 40, },
--++ Paladin Abilities ++	
	["Holy Light"]={ class = "PALADIN", level = 1, },
	["Seal of Righteousness"]={ class = "PALADIN", level = 1, },
	["Judgement"]={ class = "PALADIN", level = 4, },
	["Divine Protection"]={ class = "PALADIN", level = 6, },
	["Seal of the Crusader"]={ class = "PALADIN", level = 6, },
	["Hammer of Justice"]={ class = "PALADIN", level = 8, },
	["Purify"]={ class = "PALADIN", level = 8, },
	["Lay on Hands"]={ class = "PALADIN", level = 10, },
	["Redemption"]={ class = "PALADIN", level = 12, },
	["Righteous Fury"]={ class = "PALADIN", level = 16, },
	["Exorcism"]={ class = "PALADIN", level = 20, },
	["Flash of Light"]={ class = "PALADIN", level = 20, },
	["Sense Undead"]={ class = "PALADIN", level = 20, },
	["Seal of Justice"]={ class = "PALADIN", level = 22, },
	["Turn Undead"]={ class = "PALADIN", level = 24, },
	["Blessing of Salvation"]={ class = "PALADIN", level = 26, },
	["Divine Intervention"]={ class = "PALADIN", level = 30, },
	["Seal of Light"]={ class = "PALADIN", level = 30, },
	["Divine Shield"]={ class = "PALADIN", level = 34, },
	["Seal of Wisdom"]={ class = "PALADIN", level = 38, },
	["Blessing of Light"]={ class = "PALADIN", level = 40, },
	["Summon Warhorse"]={ class = "PALADIN", level = 40, },
	["Cleanse"]={ class = "PALADIN", level = 42, },
	["Hammer of Wrath"]={ class = "PALADIN", level = 44, },
	["Holy Wrath"]={ class = "PALADIN", level = 50, },
	["Summon Charger"]={ class = "PALADIN", level = 60, },
--++ Paladin Talents ++	
	["Consecration"]={ class = "PALADIN", level = 20, },
	["Seal of Command"]={ class = "PALADIN", level = 20, },
	["Divine Favor"]={ class = "PALADIN", level = 30, },
	["Holy Shield"]={ class = "PALADIN", level = 40, },
	["Holy Shock"]={ class = "PALADIN", level = 40, },
	["Repentance"]={ class = "PALADIN", level = 40, },
--++ Priest Abilities ++	
	["Lesser Heal"]={ class = "PRIEST", level = 1, },
	["Smite"]={ class = "PRIEST", level = 1, },
	["Shadow Word: Pain"]={ class = "PRIEST", level = 4, },
	["Fade"]={ class = "PRIEST", level = 8, },
	["Desperate Prayer"]={ class = "PRIEST", level = 10, },
	["Hex of Weakness"]={ class = "PRIEST", level = 10, },
	["Mind Blast"]={ class = "PRIEST", level = 10, },
	["Resurrection"]={ class = "PRIEST", level = 10, },
	["Starshards"]={ class = "PRIEST", level = 10, },
	["Touch of Weakness"]={ class = "PRIEST", level = 10, },
	["Inner Fire"]={ class = "PRIEST", level = 12, },
	["Psychic Scream"]={ class = "PRIEST", level = 14, },
	["Heal"]={ class = "PRIEST", level = 16, },
	["Dispel Magic"]={ class = "PRIEST", level = 18, },
	["Devouring Plague"]={ class = "PRIEST", level = 20, },
	["Elune's Grace"]={ class = "PRIEST", level = 20, },
	["Feedback"]={ class = "PRIEST", level = 20, },
	["Flash Heal"]={ class = "PRIEST", level = 20, },
	["Holy Fire"]={ class = "PRIEST", level = 20, },
	["Mind Soothe"]={ class = "PRIEST", level = 20, },
	["Shackle Undead"]={ class = "PRIEST", level = 20, },
	["Shadowguard"]={ class = "PRIEST", level = 20, },
	["Mind Vision"]={ class = "PRIEST", level = 22, },
	["Mana Burn"]={ class = "PRIEST", level = 24, },
	["Mind Control"]={ class = "PRIEST", level = 30, },
	["Prayer of Healing"]={ class = "PRIEST", level = 30, },
	["Abolish Disease"]={ class = "PRIEST", level = 32, },
	["Levitate"]={ class = "PRIEST", level = 34, },
	["Greater Heal"]={ class = "PRIEST", level = 40, },
--++ Priest Talents ++	
	["Holy Nova"]={ class = "PRIEST", level = 20, },
	["Inner Focus"]={ class = "PRIEST", level = 20, },
	["Mind Flay"]={ class = "PRIEST", level = 20, },
	["Silence"]={ class = "PRIEST", level = 30, },
	["Lightwell"]={ class = "PRIEST", level = 40, },
	["Shadowform"]={ class = "PRIEST", level = 40, },
--++ Rogue Abilities ++	
	["Eviscerate"]={ class = "ROGUE", level = 1, },
	["Pick Lock"]={ class = "ROGUE", level = 1, },
	["Sinister Strike"]={ class = "ROGUE", level = 1, },
	["Stealth"]={ class = "ROGUE", level = 1, },
	["Backstab"]={ class = "ROGUE", level = 4, },
	["Pick Pocket"]={ class = "ROGUE", level = 4, },
	["Gouge"]={ class = "ROGUE", level = 6, },
	["Evasion"]={ class = "ROGUE", level = 8, },
	["Sap"]={ class = "ROGUE", level = 10, },
	["Slice and Dice"]={ class = "ROGUE", level = 10, },
	["Sprint"]={ class = "ROGUE", level = 10, },
	["Kick"]={ class = "ROGUE", level = 12, },
	["Expose Armor"]={ class = "ROGUE", level = 14, },
	["Garrote"]={ class = "ROGUE", level = 14, },
	["Feint"]={ class = "ROGUE", level = 16, },
	["Ambush"]={ class = "ROGUE", level = 18, },
	["Poisons"]={ class = "ROGUE", level = 20, },
	["Rupture"]={ class = "ROGUE", level = 20, },
	["Crippling Poison"]={ class = "ROGUE", level = 20, },
	["Instant Poison"]={ class = "ROGUE", level = 20, },
	["Distract"]={ class = "ROGUE", level = 22, },
	["Vanish"]={ class = "ROGUE", level = 22, },
	["Detect Traps"]={ class = "ROGUE", level = 24, },
	["Mind-numbing Poison"]={ class = "ROGUE", level = 24, },
	["Cheap Shot"]={ class = "ROGUE", level = 26, },
	["Disarm Trap"]={ class = "ROGUE", level = 30, },
	["Kidney Shot"]={ class = "ROGUE", level = 30, },
	["Deadly Poison"]={ class = "ROGUE", level = 30, },
	["Wound Poison"]={ class = "ROGUE", level = 32, },
	["Blind"]={ class = "ROGUE", level = 34, },
	["Blinding Powder"]={ class = "ROGUE", level = 34, },
	["Safe Fall"]={ class = "ROGUE", level = 40, },
--++ Rogue Talents ++	
	["Ghostly Strike"]={ class = "ROGUE", level = 20, },
	["Riposte"]={ class = "ROGUE", level = 20, },
	["Blade Flurry"]={ class = "ROGUE", level = 30, },
	["Cold Blood"]={ class = "ROGUE", level = 30, },
	["Hemorrhage"]={ class = "ROGUE", level = 30, },
	["Preparation"]={ class = "ROGUE", level = 30, },
	["Adrenaline Rush"]={ class = "ROGUE", level = 40, },
	["Premeditation"]={ class = "ROGUE", level = 40, },
--++ Shaman Abilities ++	
	["Healing Wave"]={ class = "SHAMAN", level = 1, },
	["Lightning Bolt"]={ class = "SHAMAN", level = 1, },
	["Rockbiter Weapon"]={ class = "SHAMAN", level = 1, },
	["Earth Shock"]={ class = "SHAMAN", level = 4, },
	["Stoneskin Totem"]={ class = "SHAMAN", level = 4, },
	["Earthbind Totem"]={ class = "SHAMAN", level = 6, },
	["Lightning Shield"]={ class = "SHAMAN", level = 8, },
	["Stoneclaw Totem"]={ class = "SHAMAN", level = 8, },
	["Flame Shock"]={ class = "SHAMAN", level = 10, },
	["Flametongue Weapon"]={ class = "SHAMAN", level = 10, },
	["Searing Totem"]={ class = "SHAMAN", level = 10, },
	["Strength of Earth Totem"]={ class = "SHAMAN", level = 10, },
	["Ancestral Spirit"]={ class = "SHAMAN", level = 12, },
	["Fire Nova Totem"]={ class = "SHAMAN", level = 12, },
	["Purge"]={ class = "SHAMAN", level = 12, },
	["Tremor Totem"]={ class = "SHAMAN", level = 18, },
	["Frost Shock"]={ class = "SHAMAN", level = 20, },
	["Frostbrand Weapon"]={ class = "SHAMAN", level = 20, },
	["Ghost Wolf"]={ class = "SHAMAN", level = 20, },
	["Healing Stream Totem"]={ class = "SHAMAN", level = 20, },
	["Lesser Healing Wave"]={ class = "SHAMAN", level = 20, },
	["Poison Cleansing Totem"]={ class = "SHAMAN", level = 22, },
	["Frost Resistance Totem"]={ class = "SHAMAN", level = 24, },
	["Far Sight"]={ class = "SHAMAN", level = 26, },
	["Magma Totem"]={ class = "SHAMAN", level = 26, },
	["Mana Spring Totem"]={ class = "SHAMAN", level = 26, },
	["Fire Resistance Totem"]={ class = "SHAMAN", level = 28, },
	["Flametongue Totem"]={ class = "SHAMAN", level = 28, },
	["Astral Recall"]={ class = "SHAMAN", level = 30, },
	["Grounding Totem"]={ class = "SHAMAN", level = 30, },
	["Nature Resistance Totem"]={ class = "SHAMAN", level = 30, },
	["Reincarnation"]={ class = "SHAMAN", level = 30, },
	["Windfury Weapon"]={ class = "SHAMAN", level = 30, },
	["Chain Lightning"]={ class = "SHAMAN", level = 32, },
	["Windfury Totem"]={ class = "SHAMAN", level = 32, },
	["Sentry Totem"]={ class = "SHAMAN", level = 34, },
	["Windwall Totem"]={ class = "SHAMAN", level = 36, },
	["Disease Cleansing Totem"]={ class = "SHAMAN", level = 38, },
	["Chain Heal"]={ class = "SHAMAN", level = 40, },
	["Grace of Air Totem"]={ class = "SHAMAN", level = 42, },
	["Tranquil Air Totem"]={ class = "SHAMAN", level = 50, },
--++ Shaman Talents ++	
	["Parry"]={ class = "SHAMAN", level = 30, },
	["Elemental Mastery"]={ class = "SHAMAN", level = 40, },
	["Mana Tide Totem"]={ class = "SHAMAN", level = 40, },
	["Stormstrike"]={ class = "SHAMAN", level = 40, },
--++ Warlock Abilities ++	
	["Demon Skin"]={ class = "WARLOCK", level = 1, },
	["Immolate"]={ class = "WARLOCK", level = 1, },
	["Shadow Bolt"]={ class = "WARLOCK", level = 1, },
	["Summon Imp"]={ class = "WARLOCK", level = 1, },
	["Corruption"]={ class = "WARLOCK", level = 4, },
	["Curse of Weakness"]={ class = "WARLOCK", level = 4, },
	["Life Tap"]={ class = "WARLOCK", level = 6, },
	["Curse of Agony"]={ class = "WARLOCK", level = 8, },
	["Fear"]={ class = "WARLOCK", level = 8, },
	["Create Healthstone (Minor)"]={ class = "WARLOCK", level = 10, },
	["Drain Soul"]={ class = "WARLOCK", level = 10, },
	["Summon Voidwalker"]={ class = "WARLOCK", level = 10, },
	["Health Funnel"]={ class = "WARLOCK", level = 12, },
	["Curse of Recklessness"]={ class = "WARLOCK", level = 14, },
	["Drain Life"]={ class = "WARLOCK", level = 14, },
	["Unending Breath"]={ class = "WARLOCK", level = 16, },
	["Searing Pain"]={ class = "WARLOCK", level = 18, },
	["Create Soulstone (Minor)"]={ class = "WARLOCK", level = 18, },
	["Demon Armor"]={ class = "WARLOCK", level = 20, },
	["Rain of Fire"]={ class = "WARLOCK", level = 20, },
	["Ritual of Summoning"]={ class = "WARLOCK", level = 20, },
	["Summon Succubus"]={ class = "WARLOCK", level = 20, },
	["Create Healthstone (Lesser)"]={ class = "WARLOCK", level = 22, },
	["Eye of Kilrogg"]={ class = "WARLOCK", level = 22, },
	["Drain Mana"]={ class = "WARLOCK", level = 24, },
	["Sense Demons"]={ class = "WARLOCK", level = 24, },
	["Curse of Tongues"]={ class = "WARLOCK", level = 26, },
	["Detect Lesser Invisibility"]={ class = "WARLOCK", level = 26, },
	["Banish"]={ class = "WARLOCK", level = 28, },
	["Create Firestone (Lesser)"]={ class = "WARLOCK", level = 28, },
	["Enslave Demon"]={ class = "WARLOCK", level = 30, },
	["Hellfire"]={ class = "WARLOCK", level = 30, },
	["Summon Felhunter"]={ class = "WARLOCK", level = 30, },
	["Create Soulstone (Lesser)"]={ class = "WARLOCK", level = 30, },
	["Curse of the Elements"]={ class = "WARLOCK", level = 32, },
	["Shadow Ward"]={ class = "WARLOCK", level = 32, },
	["Create Healthstone"]={ class = "WARLOCK", level = 34, },
	["Create Firestone"]={ class = "WARLOCK", level = 36, },
	["Create Spellstone"]={ class = "WARLOCK", level = 36, },
	["Detect Invisibility"]={ class = "WARLOCK", level = 38, },
	["Howl of Terror"]={ class = "WARLOCK", level = 40, },
	["Summon Felsteed"]={ class = "WARLOCK", level = 40, },
	["Create Soulstone"]={ class = "WARLOCK", level = 40, },
	["Death Coil"]={ class = "WARLOCK", level = 42, },
	["Curse of Shadow"]={ class = "WARLOCK", level = 44, },
	["Create Healthstone (Greater)"]={ class = "WARLOCK", level = 46, },
	["Create Firestone (Greater)"]={ class = "WARLOCK", level = 46, },
	["Soul Fire"]={ class = "WARLOCK", level = 48, },
	["Create Spellstone (Greater)"]={ class = "WARLOCK", level = 48, },
	["Detect Greater Invisibility"]={ class = "WARLOCK", level = 50, },
	["Inferno"]={ class = "WARLOCK", level = 50, },
	["Create Soulstone (Greater)"]={ class = "WARLOCK", level = 50, },
	["Create Firestone (Major)"]={ class = "WARLOCK", level = 56, },
	["Create Healthstone (Major)"]={ class = "WARLOCK", level = 58, },
	["Curse of Doom"]={ class = "WARLOCK", level = 60, },
	["Ritual of Doom"]={ class = "WARLOCK", level = 60, },
	["Summon Dreadsteed"]={ class = "WARLOCK", level = 60, },
	["Create Soulstone (Major)"]={ class = "WARLOCK", level = 60, },
	["Create Spellstone (Major)"]={ class = "WARLOCK", level = 60, },
--++ Warlock Talents ++	
	["Amplify Curse"]={ class = "WARLOCK", level = 20, },
	["Fel Domination"]={ class = "WARLOCK", level = 20, },
	["Shadowburn"]={ class = "WARLOCK", level = 20, },
	["Curse of Exhaustion"]={ class = "WARLOCK", level = 30, },
	["Demonic Sacrifice"]={ class = "WARLOCK", level = 30, },
	["Siphon Life"]={ class = "WARLOCK", level = 30, },
	["Conflagrate"]={ class = "WARLOCK", level = 40, },
	["Dark Pact"]={ class = "WARLOCK", level = 40, },
	["Soul Link"]={ class = "WARLOCK", level = 40, },
--++ Warrior Abilities ++	
	["Battle Stance"]={ class = "WARRIOR", level = 1, },
	["Heroic Strike"]={ class = "WARRIOR", level = 1, },
	["Improved Pummel"]={ class = "WARRIOR", level = 1, },
	["Charge"]={ class = "WARRIOR", level = 4, },
	["Rend"]={ class = "WARRIOR", level = 4, },
	["Thunder Clap"]={ class = "WARRIOR", level = 6, },
	["Hamstring"]={ class = "WARRIOR", level = 8, },
	["Bloodrage"]={ class = "WARRIOR", level = 10, },
	["Defensive Stance"]={ class = "WARRIOR", level = 10, },
	["Sunder Armor"]={ class = "WARRIOR", level = 10, },
	["Taunt"]={ class = "WARRIOR", level = 10, },
	["Overpower"]={ class = "WARRIOR", level = 12, },
	["Shield Bash"]={ class = "WARRIOR", level = 12, },
	["Demoralizing Shout"]={ class = "WARRIOR", level = 14, },
	["Revenge"]={ class = "WARRIOR", level = 14, },
	["Mocking Blow"]={ class = "WARRIOR", level = 16, },
	["Shield Block"]={ class = "WARRIOR", level = 16, },
	["Disarm"]={ class = "WARRIOR", level = 18, },
	["Cleave"]={ class = "WARRIOR", level = 20, },
	["Retaliation"]={ class = "WARRIOR", level = 20, },
	["Intimidating Shout"]={ class = "WARRIOR", level = 22, },
	["Execute"]={ class = "WARRIOR", level = 24, },
	["Challenging Shout"]={ class = "WARRIOR", level = 26, },
	["Shield Wall"]={ class = "WARRIOR", level = 28, },
	["Berserker Stance"]={ class = "WARRIOR", level = 30, },
	["Intercept"]={ class = "WARRIOR", level = 30, },
	["Slam"]={ class = "WARRIOR", level = 30, },
	["Berserker Rage"]={ class = "WARRIOR", level = 32, },
	["Whirlwind"]={ class = "WARRIOR", level = 36, },
	["Pummel"]={ class = "WARRIOR", level = 38, },
	["Recklessness"]={ class = "WARRIOR", level = 50, },
--++ Warrior Talents ++	
	["Last Stand"]={ class = "WARRIOR", level = 20, },
	["Piercing Howl"]={ class = "WARRIOR", level = 20, },
	["Concussion Blow"]={ class = "WARRIOR", level = 30, },
	["Death Wish"]={ class = "WARRIOR", level = 30, },
	["Sweeping Strikes"]={ class = "WARRIOR", level = 30, },
	["Bloodthirst"]={ class = "WARRIOR", level = 40, },
	["Mortal Strike"]={ class = "WARRIOR", level = 40, },
	["Shield Slam"]={ class = "WARRIOR", level = 40, },
};

Spy_IgnoreList = {
	["Mailbox"]=true, 
	["Treasure Chest"]=true, 
	["Small Treasure Chest"]=true,	
};