--------------------
--Nova World Buffs--
--------------------
--Classic WoW world buff timers and pre warnings.
--Novaspark-Arugal OCE (classic).
--https://www.curseforge.com/members/venomisto/projects

local addonName, addon = ...;
local NWB = addon.a;
local L = LibStub("AceLocale-3.0"):GetLocale("NovaWorldBuffs");

NWB.options = {
	name =  "",
	handler = NWB,
	type = 'group',
	args = {
		titleText = {
			type = "description",
			name = "        " .. NWB.prefixColor .. "NovaWorldBuffs (v" .. GetAddOnMetadata("NovaWorldBuffs", "Version") .. ")",
			fontSize = "large",
			order = 1,
		},
		authorText = {
			type = "description",
			name = "|TInterface\\AddOns\\NovaWorldBuffs\\Media\\logo32:32:32:0:20|t |cFF9CD6DEby Novaspark-Arugal",
			fontSize = "medium",
			order = 2,
		},
		mainText = {
			type = "description",
			name = "|cFF9CD6DE" .. L["mainTextDesc"],
			fontSize = "medium",
			order = 103,
		},
		ignoreKillData = {
			type = "toggle",
			name = L["ignoreKillDataTitle"],
			desc = L["ignoreKillDataDesc"],
			order = 104,
			get = "getIgnoreKillData",
			set = "setIgnoreKillData",
		},
		noOverwrite = {
			type = "toggle",
			name = L["noOverwriteTitle"],
			desc = L["noOverwriteDesc"],
			order = 105,
			get = "getNoOverwrite",
			set = "setNoOverwrite",
		},
		showBuffs = {
			type = "execute",
			name = L["showBuffsTitle"],
			desc = L["showBuffsDesc"],
			func = "openBuffListFrame",
			order = 106,
			width = 1,
		},
		generalHeader = {
			type = "header",
			name = NWB.prefixColor .. L["generalHeaderDesc"],
			order = 100,
		},
		showWorldMapMarkers = {
			type = "toggle",
			name = L["showWorldMapMarkersTitle"],
			desc = L["showWorldMapMarkersDesc"],
			order = 111,
			get = "getShowWorldMapMarkers",
			set = "setShowWorldMapMarkers",
		},
		receiveGuildDataOnly  = {
			type = "toggle",
			name = L["receiveGuildDataOnlyTitle"],
			desc = L["receiveGuildDataOnlyDesc"],
			order = 112,
			get = "getReceiveGuildDataOnly",
			set = "setReceiveGuildDataOnly",
		},
		chatColor = {
			type = "color",
			name = L["chatColorTitle"],
			desc = L["chatColorDesc"],
			order = 113,
			get = "getChatColor",
			set = "setChatColor",
			hasAlpha = false,
		},
		mmColor = {
			type = "color",
			name = L["mmColorTitle"],
			desc = L["mmColorDesc"],
			order = 114,
			get = "getMmColor",
			set = "setMmColor",
			hasAlpha = false,
		},
		middleColor = {
			type = "color",
			name = L["middleColorTitle"],
			desc = L["middleColorDesc"],
			order = 115,
			get = "getMiddleColor",
			set = "setMiddleColor",
			hasAlpha = false,
		},
		resetColors = {
			type = "execute",
			name = L["resetColorsTitle"],
			desc = L["resetColorsDesc"],
			func = "resetColors",
			order = 116,
		},
		showTimeStamp = {
			type = "toggle",
			name = L["showTimeStampTitle"],
			desc = L["showTimeStampDesc"],
			order = 117,
			get = "getShowTimeStamp",
			set = "setShowTimeStamp",
		},
		timeStampFormat = {
			type = "select",
			name = L["timeStampFormatTitle"],
			desc = L["timeStampFormatDesc"],
			values = {
				[12] = "12 hour",
				[24] = "24 hour",
			},
			sorting = {
				[1] = 12,
				[2] = 24,
			},
			order = 118,
			get = "getTimeStampFormat",
			set = "setTimeStampFormat",
		},
		timeStampZone = {
			type = "select",
			name = L["timeStampZoneTitle"],
			desc = L["timeStampZoneDesc"],
			values = {
				["local"] = "Local Time",
				["server"] = "Server Time",
			},
			sorting = {
				[1] = "local",
				[2] = "server",
			},
			order = 119,
			get = "getTimeStampZone",
			set = "setTimeStampZone",
		},
		colorizePrefixLinks = {
			type = "toggle",
			name = L["colorizePrefixLinksTitle"],
			desc = L["colorizePrefixLinksDesc"],
			order = 120,
			get = "getColorizePrefixLinks",
			set = "setColorizePrefixLinks",
		},
		minimapButton = {
			type = "toggle",
			name = L["minimapButtonTitle"],
			desc = L["minimapButtonDesc"],
			order = 121,
			get = "getMinimapButton",
			set = "setMinimapButton",
		},
		minimapLayerHover = {
			type = "toggle",
			name = L["minimapLayerHoverTitle"],
			desc = L["minimapLayerHoverDesc"],
			order = 122,
			get = "getMinimapLayerHover",
			set = "setMinimapLayerHover",
		},
		showBuffStats = {
			type = "toggle",
			name = L["showBuffStatsTitle"],
			desc = L["showBuffStatsDesc"],
			order = 123,
			get = "getShowBuffStats",
			set = "setShowBuffStats",
		},
		showAllAlts = {
			type = "toggle",
			name = L["showAllAltsTitle"],
			desc = L["showAllAltsDesc"],
			order = 124,
			get = "getShowAllAlts",
			set = "setShowAllAlts",
		},
		showUnbuffedAlts = {
			type = "toggle",
			name = L["showUnbuffedAltsTitle"],
			desc = L["showUnbuffedAltsDesc"],
			order = 125,
			get = "getShowUnbuffedAlts",
			set = "setShowUnbuffedAlts",
		},
		guildL = {
			type = "toggle",
			name = L["guildLTitle"],
			desc = L["guildLDesc"],
			order = 126,
			get = "getGuildL",
			set = "setGuildL",
		},
		timerWindowWidth = {
			type = "range",
			name = L["timerWindowWidthTitle"],
			desc = L["timerWindowWidthDesc"],
			order = 127,
			get = "getTimerWindowWidth",
			set = "setTimerWindowWidth",
			min = 350,
			max = 900,
			softMin = 350,
			softMax = 900,
			step = 1,
			width = 1.5,
		},
		timerWindowHeight = {
			type = "range",
			name = L["timerWindowHeightTitle"],
			desc = L["timerWindowHeightDesc"],
			order = 128,
			get = "getTimerWindowHeight",
			set = "setTimerWindowHeight",
			min = 150,
			max = 950,
			softMin = 150,
			softMax = 950,
			step = 1,
			width = 1.5,
		},
		buffWindowWidth = {
			type = "range",
			name = L["buffWindowWidthTitle"],
			desc = L["buffWindowWidthDesc"],
			order = 129,
			get = "getBuffWindowWidth",
			set = "setBuffWindowWidth",
			min = 350,
			max = 900,
			softMin = 350,
			softMax = 900,
			step = 1,
			width = 1.5,
		},
		buffWindowHeight = {
			type = "range",
			name = L["buffWindowHeightTitle"],
			desc = L["buffWindowHeightDesc"],
			order = 130,
			get = "getBuffWindowHeight",
			set = "setBuffWindowHeight",
			min = 150,
			max = 950,
			softMin = 150,
			softMax = 950,
			step = 1,
			width = 1.5,
		},
		showNaxxWorldmapMarkers = {
			type = "toggle",
			name = L["showNaxxWorldmapMarkersTitle"],
			desc = L["showNaxxWorldmapMarkersDesc"],
			order = 131,
			get = "getShowNaxxWorldmapMarkers",
			set = "setShowNaxxWorldmapMarkers",
		},
		showNaxxMinimapMarkers = {
			type = "toggle",
			name = L["showNaxxMinimapMarkersTitle"],
			desc = L["showNaxxMinimapMarkersDesc"],
			order = 132,
			get = "getShowNaxxMinimapMarkers",
			set = "setShowNaxxMinimapMarkers",
		},
		bigWigsSupport = {
			type = "toggle",
			name = L["bigWigsSupportTitle"],
			desc = L["bigWigsSupportDesc"],
			order = 133,
			get = "getBigWigsSupport",
			set = "setBigWigsSupport",
		},
		logonHeader = {
			type = "header",
			name = NWB.prefixColor .. L["logonHeaderDesc"],
			order = 140,
		},
		logonPrint = {
			type = "toggle",
			name = L["logonPrintTitle"],
			desc = L["logonPrintDesc"],
			order = 141,
			get = "getLogonPrint",
			set = "setLogonPrint",
		},
		logonRend = {
			type = "toggle",
			name = L["logonRendTitle"],
			desc = L["logonRendDesc"],
			order = 142,
			get = "getLogonRend",
			set = "setLogonRend",
		},
		logonOny = {
			type = "toggle",
			name = L["logonOnyTitle"],
			desc = L["logonOnyDesc"],
			order = 143,
			get = "getLogonOny",
			set = "setLogonOny",
		},
		logonNef = {
			type = "toggle",
			name = L["logonNefTitle"],
			desc = L["logonNefDesc"],
			order = 144,
			get = "getLogonNef",
			set = "setLogonNef",
		},
		logonDmfSpawn = {
			type = "toggle",
			name = L["logonDmfSpawnTitle"],
			desc = L["logonDmfSpawnDesc"],
			order = 145,
			get = "getLogonDmfSpawn",
			set = "setLogonDmfSpawn",
		},
		logonDmfBuffCooldown = {
			type = "toggle",
			name = L["logonDmfBuffCooldownTitle"],
			desc = L["logonDmfBuffCooldownDesc"],
			order = 146,
			get = "getLogonDmfBuffCooldown",
			set = "setLogonDmfBuffCooldown",
		},
		chatWarningHeader = {
			type = "header",
			name = NWB.prefixColor .. L["chatWarningHeaderDesc"],
			order = 160,
		},
		chat30 = {
			type = "toggle",
			name = L["chat30Title"],
			desc = L["chat30Desc"],
			order = 161,
			get = "getChat30",
			set = "setChat30",
		},
		chat15 = {
			type = "toggle",
			name = L["chat15Title"],
			desc = L["chat15Desc"],
			order = 162,
			get = "getChat15",
			set = "setChat15",
		},
		chat10 = {
			type = "toggle",
			name = L["chat10Title"],
			desc = L["chat10Desc"],
			order = 163,
			get = "getChat10",
			set = "setChat10",
		},
		chat5 = {
			type = "toggle",
			name = L["chat5Title"],
			desc = L["chat5Desc"],
			order = 164,
			get = "getChat5",
			set = "setChat5",
		},
		chat1 = {
			type = "toggle",
			name = L["chat1Title"],
			desc = L["chat1Desc"],
			order = 165,
			get = "getChat1",
			set = "setChat1",
		},
		chatReset = {
			type = "toggle",
			name = L["chatResetTitle"],
			desc = L["chatResetDesc"],
			order = 166,
			get = "getChat0",
			set = "setChat0",
		},
		chatZan = {
			type = "toggle",
			name = L["chatZanTitle"],
			desc = L["chatZanDesc"],
			order = 167,
			get = "getChatZan",
			set = "setChatZan",
		},
		chatNpcKilled = {
			type = "toggle",
			name = L["chatNpcKilledTitle"],
			desc = L["chatNpcKilledDesc"],
			order = 168,
			get = "getChatNpcKilled",
			set = "setChatNpcKilled",
		},
		terokkarChat10 = {
			type = "toggle",
			name = L["terokkarChat10Title"],
			desc = L["terokkarChat10Desc"],
			order = 169,
			get = "getTerokkarChat10",
			set = "setTerokkarChat10",
		},
		middleWarningHeader = {
			type = "header",
			name = NWB.prefixColor .. L["middleWarningHeaderDesc"],
			order = 180,
		},
		middle30 = {
			type = "toggle",
			name = L["middle30Title"],
			desc = L["middle30Desc"],
			order = 181,
			get = "getMiddle30",
			set = "setMiddle30",
		},
		middle15 = {
			type = "toggle",
			name = L["middle15Title"],
			desc = L["middle15Desc"],
			order = 182,
			get = "getMiddle15",
			set = "setMiddle15",
		},
		middle10 = {
			type = "toggle",
			name = L["middle10Title"],
			desc = L["middle10Desc"],
			order = 183,
			get = "getMiddle10",
			set = "setMiddle10",
		},
		middle5 = {
			type = "toggle",
			name = L["middle5Title"],
			desc = L["middle5Desc"],
			order = 184,
			get = "getMiddle5",
			set = "setMiddle5",
		},
		middle1 = {
			type = "toggle",
			name = L["middle1Title"],
			desc = L["middle1Desc"],
			order = 185,
			get = "getMiddle1",
			set = "setMiddle1",
		},
		middleReset = {
			type = "toggle",
			name = L["middleResetTitle"],
			desc = L["middleResetDesc"],
			order = 186,
			get = "getMiddle0",
			set = "setMiddle0",
		},
		middleBuffWarning = {
			type = "toggle",
			name = L["middleBuffWarningTitle"],
			desc = L["middleBuffWarningDesc"],
			order = 187,
			get = "getMiddleBuffWarning",
			set = "setMiddleBuffWarning",
		},
		middleHideCombat = {
			type = "toggle",
			name = L["middleHideCombatTitle"],
			desc = L["middleHideCombatDesc"],
			order = 188,
			get = "getMiddleHideCombat",
			set = "setMiddleHideCombat",
		},
		middleHideRaid = {
			type = "toggle",
			name = L["middleHideRaidTitle"],
			desc = L["middleHideRaidDesc"],
			order = 189,
			get = "getMiddleHideRaid",
			set = "setMiddleHideRaid",
		},
		middleHideBattlegrounds = {
			type = "toggle",
			name = L["middleHideBattlegroundsTitle"],
			desc = L["middleHideBattlegroundsDesc"],
			order = 190,
			get = "getMiddleHideBattlegrounds",
			set = "setMiddleHideBattlegrounds",
		},
		middleNpcKilled = {
			type = "toggle",
			name = L["middleNpcKilledTitle"],
			desc = L["middleNpcKilledDesc"],
			order = 191,
			get = "getMiddleNpcKilled",
			set = "setMiddleNpcKilled",
		},
		terokkarMiddle10 = {
			type = "toggle",
			name = L["terokkarMiddle10Title"],
			desc = L["terokkarMiddle10Desc"],
			order = 192,
			get = "getTerokkarMiddle10",
			set = "setTerokkarMiddle10",
		},
		guildWarningHeader = {
			type = "header",
			name = NWB.prefixColor .. L["guildWarningHeaderDesc"],
			order = 210,
		},
		guild10 = {
			type = "toggle",
			name = L["guild10Title"],
			desc = L["guild10Desc"],
			order = 211,
			get = "getGuild10",
			set = "setGuild10",
		},
		guild1 = {
			type = "toggle",
			name = L["guild1Title"],
			desc = L["guild1Desc"],
			order = 212,
			get = "getGuild1",
			set = "setGuild1",
		},
		guildNpcDialogue = {
			type = "toggle",
			name = L["guildNpcDialogueTitle"],
			desc = L["guildNpcDialogueDesc"],
			order = 213,
			get = "getGuildNpcDialogue",
			set = "setGuildNpcDialogue",
		},
		guildBuffDropped = {
			type = "toggle",
			name = L["guildBuffDroppedTitle"],
			desc = L["guildBuffDroppedDesc"],
			order = 214,
			get = "getGuildBuffDropped",
			set = "setGuildBuffDropped",
		},
		guildZanDialogue = {
			type = "toggle",
			name = L["guildZanDialogueTitle"],
			desc = L["guildZanDialogueDesc"],
			order = 215,
			get = "getGuildZanDialogue",
			set = "setGuildZanDialogue",
		},
		guildNpcKilled = {
			type = "toggle",
			name = L["guildNpcKilledTitle"],
			desc = L["guildNpcKilledDesc"],
			order = 216,
			get = "getGuildNpcKilled",
			set = "setGuildNpcKilled",
		},
		guildCommand = {
			type = "toggle",
			name = L["guildCommandTitle"],
			desc = L["guildCommandDesc"],
			order = 218,
			get = "getGuildCommand",
			set = "setGuildCommand",
		},
		disableAllGuildMsgs = {
			type = "toggle",
			name = L["disableAllGuildMsgsTitle"],
			desc = L["disableAllGuildMsgsDesc"],
			order = 219,
			get = "getDisableAllGuildMsgs",
			set = "setDisableAllGuildMsgs",
		},
		songflowersHeader = {
			type = "header",
			name = NWB.prefixColor .. L["songflowersHeaderDesc"],
			order = 240,
		},
		guildSongflower = {
			type = "toggle",
			name = L["guildSongflowerTitle"],
			desc = L["guildSongflowerDesc"],
			order = 241,
			get = "getGuildSongflower",
			set = "setGuildSongflower",
		},
		mySongflowerOnly = {
			type = "toggle",
			name = L["mySongflowerOnlyTitle"],
			desc = L["mySongflowerOnlyDesc"],
			order = 242,
			get = "getMySongflowerOnly",
			set = "setMySongflowerOnly",
		},
		syncFlowersAll = {
			type = "toggle",
			name = L["syncFlowersAllTitle"],
			desc = L["syncFlowersAllDesc"],
			order = 243,
			get = "getSyncFlowersAll",
			set = "setSyncFlowersAll",
		},
		showNewFlower = {
			type = "toggle",
			name = L["showNewFlowerTitle"],
			desc = L["showNewFlowerDesc"],
			order = 244,
			get = "getShowNewFlower",
			set = "setShowNewFlower",
		},
		showSongflowerWorldmapMarkers = {
			type = "toggle",
			name = L["showSongflowerWorldmapMarkersTitle"],
			desc = L["showSongflowerWorldmapMarkersDesc"],
			order = 245,
			get = "getShowSongflowerWorldmapMarkers",
			set = "setShowSongflowerWorldmapMarkers",
		},
		showSongflowerMinimapMarkers = {
			type = "toggle",
			name = L["showSongflowerMinimapMarkersTitle"],
			desc = L["showSongflowerMinimapMarkersDesc"],
			order = 246,
			get = "getShowSongflowerMinimapMarkers",
			set = "setShowSongflowerMinimapMarkers",
		},
		showTuberWorldmapMarkers = {
			type = "toggle",
			name = L["showTuberWorldmapMarkersTitle"],
			desc = L["showTuberWorldmapMarkersDesc"],
			order = 247,
			get = "getShowTuberWorldmapMarkers",
			set = "setShowTuberWorldmapMarkers",
		},
		showTuberMinimapMarkers = {
			type = "toggle",
			name = L["showTuberMinimapMarkersTitle"],
			desc = L["showTuberMinimapMarkersDesc"],
			order = 248,
			get = "getShowTuberMinimapMarkers",
			set = "setShowTuberMinimapMarkers",
		},
		showDragonWorldmapMarkers = {
			type = "toggle",
			name = L["showDragonWorldmapMarkersTitle"],
			desc = L["showDragonWorldmapMarkersDesc"],
			order = 249,
			get = "getShowDragonWorldmapMarkers",
			set = "setShowDragonWorldmapMarkers",
		},
		showDragonMinimapMarkers = {
			type = "toggle",
			name = L["showDragonMinimapMarkersTitle"],
			desc = L["showDragonMinimapMarkersDesc"],
			order = 250
			,
			get = "getShowDragonMinimapMarkers",
			set = "setShowDragonMinimapMarkers",
		},
		showExpiredTimers = {
			type = "toggle",
			name = L["showExpiredTimersTitle"],
			desc = L["showExpiredTimersDesc"],
			order = 251,
			get = "getShowExpiredTimers",
			set = "setShowExpiredTimers",
		},
		expiredTimersDuration = {
			type = "range",
			name = L["expiredTimersDurationTitle"],
			desc = L["expiredTimersDurationDesc"],
			order = 252,
			get = "getExpiredTimersDuration",
			set = "setExpiredTimersDuration",
			min = 1,
			max = 60,
			softMin = 1,
			softMax = 60,
			step = 1,
		},
		dmfHeader = {
			type = "header",
			name = NWB.prefixColor .. L["dmfHeaderDesc"],
			order = 270,
		},
		dmfText = {
			type = "description",
			name = "|cFF9CD6DE" .. L["dmfTextDesc"],
			fontSize = "medium",
			order = 271,
		},
		showDmfWb = {
			type = "toggle",
			name = L["showDmfWbTitle"],
			desc = L["showDmfWbDesc"],
			order = 272,
			get = "getShowDmfWb",
			set = "setShowDmfWb",
		},
		showDmfBuffWb = {
			type = "toggle",
			name = L["showDmfBuffWbTitle"],
			desc = L["showDmfBuffWbDesc"],
			order = 273,
			get = "getShowDmfBuffWb",
			set = "setShowDmfBuffWb",
		},
		showDmfMap = {
			type = "toggle",
			name = L["showDmfMapTitle"],
			desc = L["showDmfMapDesc"],
			order = 275,
			get = "getShowDmfMap",
			set = "setShowDmfMap",
		},
		autoDmfBuff = {
			type = "toggle",
			name = L["autoDmfBuffTitle"],
			desc = L["autoDmfBuffDesc"],
			order = 283,
			get = "getAutoDmfBuff",
			set = "setAutoDmfBuff",
		},
		autoDmfBuffType = {
			type = "select",
			name = L["autoDmfBuffTypeTitle"],
			desc = L["autoDmfBuffTypeDesc"],
			values = {
				["Damage"] = L["Sayge's Dark Fortune of Damage"],
				["Agility"] = L["Sayge's Dark Fortune of Agility"],
				["Intelligence"] = L["Sayge's Dark Fortune of Intelligence"],
				["Spirit"] = L["Sayge's Dark Fortune of Spirit"],
				["Stamina"] = L["Sayge's Dark Fortune of Stamina"],
				["Strength"] = L["Sayge's Dark Fortune of Strength"],
				["Armor"] = L["Sayge's Dark Fortune of Armor"],
				["Resistance"] = L["Sayge's Dark Fortune of Resistance"],
			},
			sorting = {
				[1] = "Damage",
				[2] = "Agility",
				[3] = "Intelligence",
				[4] = "Spirit",
				[5] = "Stamina",
				[6] = "Strength",
				[7] = "Armor",
				[8] = "Resistance",
			},
			order = 284,
			width = "double",
			--width = 1.6,
			get = "getAutoDmfBuffType",
			set = "setAutoDmfBuffType",
		},
		autoBuffsText = {
			type = "description",
			name = "|cFFFF0000" .. L["note"] .. " |cFF9CD6DE" .. L["dmfConfigWarning"],
			fontSize = "medium",
			order = 285,
		},
		dmfSettingsList = {
			type = "execute",
			name = L["dmfSettingsListTitle"],
			desc = L["dmfSettingsListDesc"],
			func = "openDMFListFrame",
			order = 286,
		},
		guildChatFilterHeader = {
			type = "header",
			name = NWB.prefixColor .. L["guildChatFilterHeaderDesc"],
			order = 290,
		},
		guildChatFilterText = {
			type = "description",
			name = "|cFF9CD6DE".. L["guildChatFilterTextDesc"],
			fontSize = "medium",
			order = 291,
		},
		filterYells = {
			type = "toggle",
			name = L["filterYellsTitle"],
			desc = L["filterYellsDesc"],
			order = 292,
			get = "getFilterYells",
			set = "setFilterYells",
		},
		filterDrops = {
			type = "toggle",
			name = L["filterDropsTitle"],
			desc = L["filterDropsDesc"],
			order = 293,
			get = "getFilterDrops",
			set = "setFilterDrops",
		},
		filterTimers = {
			type = "toggle",
			name = L["filterTimersTitle"],
			desc = L["filterTimersDesc"],
			order = 294,
			get = "getFilterTimers",
			set = "setFilterTimers",
		},
		filterCommand = {
			type = "toggle",
			name = L["filterCommandTitle"],
			desc = L["filterCommandDesc"],
			order = 295,
			get = "getFilterCommand",
			set = "setFilterCommand",
		},
		filterCommandResponse = {
			type = "toggle",
			name = L["filterCommandResponseTitle"],
			desc = L["filterCommandResponseDesc"],
			order = 296,
			get = "getFilterCommandResponse",
			set = "setFilterCommandResponse",
		},
		filterSongflowers = {
			type = "toggle",
			name = L["filterSongflowersTitle"],
			desc = L["filterSongflowersDesc"],
			order = 297,
			get = "getFilterSongflowers",
			set = "setFilterSongflowers",
		},
		filterNpcKilled = {
			type = "toggle",
			name = L["filterNpcKilledTitle"],
			desc = L["filterNpcKilledDesc"],
			order = 298,
			get = "getFilterNpcKilled",
			set = "setFilterNpcKilled",
		},
		soundsHeader = {
			type = "header",
			name = NWB.prefixColor .. L["soundsHeaderDesc"],
			order = 320,
		},
		soundsText = {
			type = "description",
			name = "|CffDEDE42" .. L["soundsTextDesc"],
			fontSize = "medium",
			order = 321,
		},
		disableAllSounds = {
			type = "toggle",
			name = L["disableAllSoundsTitle"],
			desc = L["disableAllSoundsDesc"],
			order = 322,
			get = "getDisableAllSounds",
			set = "setDisableAllSounds",
		},
		extraSoundOptions = {
			type = "toggle",
			name = L["extraSoundOptionsTitle"],
			desc = L["extraSoundOptionsDesc"],
			order = 323,
			get = "getExtraSoundOptions",
			set = "setExtraSoundOptions",
			--width = "double",
		},
		soundOnlyInCity = {
			type = "toggle",
			name = L["soundOnlyInCityTitle"],
			desc = L["soundOnlyInCityDesc"],
			order = 324,
			get = "getSoundOnlyInCity",
			set = "setSoundOnlyInCity",
		},
		soundsDisableInInstances = {
			type = "toggle",
			name = L["soundsDisableInInstancesTitle"],
			desc = L["soundsDisableInInstancesDesc"],
			order = 325,
			get = "getSoundsDisableInInstances",
			set = "setSoundsDisableInInstances",
		},
		soundsDisableInBattlegrounds = {
			type = "toggle",
			name = L["soundsDisableInBattlegroundsTitle"],
			desc = L["soundsDisableInBattlegroundsDesc"],
			order = 326,
			get = "getSoundsDisableInBattlegrounds",
			set = "setSoundsDisableInBattlegrounds",
		},
		soundsFirstYell = {
			type = "select",
			name = L["soundsFirstYellTitle"],
			desc = L["soundsFirstYellDesc"],
			values = function()
				return NWB:getSounds();
			end,
			order = 327,
			get = "getSoundsFirstYell",
			set = "setSoundsFirstYell",
		},
		soundsOneMinute = {
			type = "select",
			name = L["soundsOneMinuteTitle"],
			desc = L["soundsOneMinuteDesc"],
			values = function()
				return NWB:getSounds();
			end,
			order = 228,
			get = "getSoundsOneMinute",
			set = "setSoundsOneMinute",
		},
		soundsRendDrop = {
			type = "select",
			name = L["soundsRendDropTitle"],
			desc = L["soundsRendDropDesc"],
			values = function()
				return NWB:getSounds("rend");
			end,
			order = 329,
			get = "getSoundsRendDrop",
			set = "setSoundsRendDrop",
		},
		soundsOnyDrop = {
			type = "select",
			name = L["soundsOnyDropTitle"],
			desc = L["soundsOnyDropDesc"],
			values = function()
				return NWB:getSounds("ony");
			end,
			order = 330,
			get = "getSoundsOnyDrop",
			set = "setSoundsOnyDrop",
		},
		soundsNefDrop = {
			type = "select",
			name = L["soundsNefDropTitle"],
			desc = L["soundsNefDropDesc"],
			values = function()
				return NWB:getSounds("nef");
			end,
			order = 331,
			get = "getSoundsNefDrop",
			set = "setSoundsNefDrop",
		},
		soundsZanDrop = {
			type = "select",
			name = L["soundsZanDropTitle"],
			desc = L["soundsZanDropDesc"],
			values = function()
				return NWB:getSounds("zan");
			end,
			order = 332,
			get = "getSoundsZanDrop",
			set = "setSoundsZanDrop",
		},
		soundsNpcKilled = {
			type = "select",
			name = L["soundsNpcKilledTitle"],
			desc = L["soundsNpcKilledDesc"],
			values = function()
				return NWB:getSounds("npcKilled");
			end,
			order = 333,
			get = "getSoundsNpcKilled",
			set = "setSoundsNpcKilled",
		},
		soundsNpcWalking = {
			type = "select",
			name = L["soundsNpcWalkingTitle"],
			desc = L["soundsNpcWalkingDesc"],
			values = function()
				return NWB:getSounds("npcWalking");
			end,
			order = 334,
			get = "getSoundsNpcWalking",
			set = "setSoundsNpcWalking",
		},
		flashHeader = {
			type = "header",
			name = NWB.prefixColor .. L["flashHeaderDesc"],
			order = 360,
		},
		flashOneMin = {
			type = "toggle",
			name = L["flashOneMinTitle"],
			desc = L["flashOneMinDesc"],
			order = 361,
			get = "getFlashOneMin",
			set = "setFlashOneMin",
		},
		flashFirstYell = {
			type = "toggle",
			name = L["flashFirstYellTitle"],
			desc = L["flashFirstYellDesc"],
			order = 362,
			get = "getFlashFirstYell",
			set = "setFlashFirstYell",
		},
		flashFirstYellZan = {
			type = "toggle",
			name = L["flashFirstYellZanTitle"],
			desc = L["flashFirstYellZanDesc"],
			order = 363,
			get = "getFlashFirstYellZan",
			set = "setFlashFirstYellZan",
		},
		flashNpcKilled = {
			type = "toggle",
			name = L["flashNpcKilledTitle"],
			desc = L["flashNpcKilledDesc"],
			order = 364,
			get = "getFlashNpcKilled",
			set = "setFlashNpcKilled",
		},
		dispelsHeader = {
			type = "header",
			name = NWB.prefixColor .. L["dispelsHeaderDesc"],
			order = 380,
		},
		dispelsMine = {
			type = "toggle",
			name = L["dispelsMineTitle"],
			desc = L["dispelsMineDesc"],
			order = 381,
			get = "getDispelsMine",
			set = "setDispelsMine",
		},
		dispelsMineWBOnly = {
			type = "toggle",
			name = L["dispelsMineWBOnlyTitle"],
			desc = L["dispelsMineWBOnlyDesc"],
			order = 382,
			get = "getDispelsMineWBOnly",
			set = "setDispelsMineWBOnly",
		},
		soundsDispelsMine = {
			type = "select",
			name = L["soundsDispelsMineTitle"],
			desc = L["soundsDispelsMineDesc"],
			values = function()
				return NWB:getSounds();
			end,
			order = 383,
			get = "getSoundsDispelsMine",
			set = "setSoundsDispelsMine",
		},
		dispelsAll = {
			type = "toggle",
			name = L["dispelsAllTitle"],
			desc = L["dispelsAllDesc"],
			order = 384,
			get = "getDispelsAll",
			set = "setDispelsAll",
		},
		dispelsAllWBOnly = {
			type = "toggle",
			name = L["dispelsAllWBOnlyTitle"],
			desc = L["dispelsAllWBOnlyDesc"],
			order = 385,
			get = "getDispelsAllWBOnly",
			set = "setDispelsAllWBOnly",
		},
		soundsDispelsAll = {
			type = "select",
			name = L["soundsDispelsAllTitle"],
			desc = L["soundsDispelsAllDesc"],
			values = function()
				return NWB:getSounds();
			end,
			order = 386,
			get = "getSoundsDispelsAll",
			set = "setSoundsDispelsAll",
		},
		autoBuffsHeader = {
			type = "header",
			name = NWB.prefixColor .. L["autoBuffsHeaderDesc"],
			order = 400,
		},
		autoDireMaulBuff = {
			type = "toggle",
			name = L["autoDireMaulBuffTitle"],
			desc = L["autoDireMaulBuffDesc"],
			order = 406,
			get = "getAutoDireMaulBuff",
			set = "setAutoDireMaulBuff",
		},
		autoBwlPortal = {
			type = "toggle",
			name = L["autoBwlPortalTitle"],
			desc = L["autoBwlPortalDesc"],
			order = 407,
			get = "getAutoBwlPortal",
			set = "setAutoBwlPortal",
		},
		trimDataHeader = {
			type = "header",
			name = NWB.prefixColor .. L["trimDataHeaderDesc"],
			order = 430,
		},
		trimDataText = {
			type = "description",
			name = "|cFF9CD6DE".. L["trimDataTextDesc"],
			fontSize = "medium",
			order = 431,
		},
		trimDataBelowLevel = {
			type = "range",
			name = L["trimDataBelowLevelTitle"],
			desc = L["trimDataBelowLevelDesc"],
			order = 432,
			get = "getTrimDataBelowLevel",
			set = "setTrimDataBelowLevel",
			min = 1,
			max = 60,
			softMin = 1,
			softMax = 60,
			step = 1,
			width = "double",
		},
		trimDataBelowLevelButton = {
			type = "execute",
			name = L["trimDataBelowLevelButtonTitle"],
			desc = L["trimDataBelowLevelButtonDesc"],
			func = "removeCharsBelowLevel",
			order = 433,
			--width = 1.7,
			confirm = function()
				return string.format(L["trimDataBelowLevelButtonConfirm"], "|cFFFFFF00" .. NWB.db.global.trimDataBelowLevel .. "|r");
			end,
		},
		trimDataText2 = {
			type = "description",
			name = "|cFF9CD6DE".. L["trimDataText2Desc"],
			fontSize = "medium",
			order = 434,
		},
		trimDataCharInput = {
			type = "input",
			name = L["trimDataCharInputTitle"],
			desc = L["trimDataCharInputDesc"],
			get = "getTrimDataCharInput",
			set = "setTrimDataCharInput",
			order = 435,
			--width = 1.7,
			confirm = function(self, input)
				return string.format(L["trimDataCharInputConfirm"], "|cFFFFFF00" .. input .. "|r");
			end,
		},
		buffHelpersHeader = {
			type = "header",
			name = NWB.prefixColor .. L["buffHelpersHeaderDesc"],
			order = 500,
		},
		buffHelpersText = {
			type = "description",
			name = "|cFF9CD6DE".. L["buffHelpersTextDesc"],
			fontSize = "medium",
			order = 501,
		},
		buffHelperDelay = {
			type = "range",
			name = L["buffHelperDelayTitle"],
			desc = L["buffHelperDelayDesc"],
			order = 502,
			get = "getBuffHelperDelay",
			set = "setBuffHelperDelay",
			min = 5,
			max = 300,
			softMin = 5,
			softMax = 300,
			step = 1,
			width = 2,
		},
		buffHelpersText2 = {
			type = "description",
			name = "|CffDEDE42" .. L["buffHelpersTextDesc2"],
			fontSize = "medium",
			order = 503,
		},
		takeTaxiZG = {
			type = "toggle",
			name = L["takeTaxiZGTitle"],
			desc = L["takeTaxiZGDesc"],
			order = 504,
			get = "getTakeTaxiZG",
			set = "setTakeTaxiZG",
		},
		takeTaxiNodeZG = {
			type = "select",
			name = L["takeTaxiNodeTitle"],
			desc = L["takeTaxiNodeDesc"],
			values = function()
				return NWB:getTaxiNodes();
			end,
			order = 505,
			width = "double",
			get = "getTakeTaxiNodeZG",
			set = "setTakeTaxiNodeZG",
		},
		zgGotBuffSummon = {
			type = "toggle",
			name = L["zgGotBuffSummonTitle"],
			desc = L["zgGotBuffSummonDesc"],
			order = 506,
			get = "getZgGotBuffSummon",
			set = "setZgGotBuffSummon",
		},
		buffHelpersText3 = {
			type = "description",
			name = "|CffDEDE42" .. L["buffHelpersTextDesc3"],
			fontSize = "medium",
			order = 510,
		},
		dmfGotBuffSummon = {
			type = "toggle",
			name = L["dmfGotBuffSummonTitle"],
			desc = L["dmfGotBuffSummonDesc"],
			order = 511,
			get = "getDmfGotBuffSummon",
			set = "setDmfGotBuffSummon",
		},
		dmfVanishSummon = {
			type = "toggle",
			name = L["dmfVanishSummonTitle"],
			desc = L["dmfVanishSummonDesc"],
			order = 512,
			get = "getDmfVanishSummon",
			set = "setDmfVanishSummon",
		},
		dmfFeignSummon = {
			type = "toggle",
			name = L["dmfFeignSummonTitle"],
			desc = L["dmfFeignSummonDesc"],
			order = 513,
			get = "getDmfFeignSummon",
			set = "setDmfFeignSummon",
		},
		dmfCombatSummon = {
			type = "toggle",
			name = L["dmfCombatSummonTitle"],
			desc = L["dmfCombatSummonDesc"],
			order = 514,
			get = "getDmfCombatSummon",
			set = "setDmfCombatSummon",
		},
		dmfLeaveBG = {
			type = "toggle",
			name = L["dmfLeaveBGTitle"],
			desc = L["dmfLeaveBGDesc"],
			order = 515,
			get = "getDmfLeaveBG",
			set = "setDmfLeaveBG",
			width = 2,
		},
		buffHelpersText4 = {
			type = "description",
			name = "|CffDEDE42" .. L["buffHelpersTextDesc4"],
			fontSize = "medium",
			order = 516,
		},
		songflowerGotBuffSummon = {
			type = "toggle",
			name = L["songflowerGotBuffSummonTitle"],
			desc = L["songflowerGotBuffSummonDesc"],
			order = 517,
			get = "getSongflowerGotBuffSummon",
			set = "setSongflowerGotBuffSummon",
		},
		cityHelpersText5 = {
			type = "description",
			name = "|CffDEDE42" .. L["buffHelpersTextDesc5"],
			fontSize = "medium",
			order = 518,
		},
		cityGotBuffSummon = {
			type = "toggle",
			name = L["cityGotBuffSummonTitle"],
			desc = L["cityGotBuffSummonDesc"],
			order = 519,
			get = "getCityGotBuffSummon",
			set = "setCityGotBuffSummon",
		},
		cityHelpersText6 = {
			type = "description",
			name = "|CffDEDE42" .. L["buffHelpersTextDesc6"],
			fontSize = "medium",
			order = 520,
		},
		dmfFrame = {
			type = "toggle",
			name = L["dmfFrameTitle"],
			desc = L["dmfFrameDesc"],
			order = 521,
			get = "getDmfFrame",
			set = "setDmfFrame",
		},
	},
};

function NWB:loadSpecificOptions()
	if (NWB.isTBC) then
		NWB.options.args["tbcHeader"] = {
			type = "description",
			name = "|cFF50D050" .. L["tbcHeaderText"],
			fontSize = "large",
			order = 5,
		};
		NWB.options.args["disableSoundsAboveMaxBuffLevel"] = {
			type = "toggle",
			name = L["disableSoundsAboveMaxBuffLevelTitle"],
			desc = L["disableSoundsAboveMaxBuffLevelDesc"],
			order = 10,
			get = "getDisableSoundsAboveMaxBuffLevel",
			set = "setDisableSoundsAboveMaxBuffLevel",
			width = 1.5,
		};
		NWB.options.args["disableSoundsAllLevels"] = {
			type = "toggle",
			name = L["disableSoundsAllLevelsTitle"],
			desc = L["disableSoundsAllLevelsDesc"],
			order = 11,
			get = "getDisableSoundsAllLevels",
			set = "setDisableSoundsAllLevels",
			width = 1.5,
		};
		NWB.options.args["disableMiddleAboveMaxBuffLevel"] = {
			type = "toggle",
			name = L["disableMiddleAboveMaxBuffLevelTitle"],
			desc = L["disableMiddleAboveMaxBuffLevelDesc"],
			order = 12,
			get = "getDisableMiddleAboveMaxBuffLevel",
			set = "setDisableMiddleAboveMaxBuffLevel",
			width = 1.5,
		};
		NWB.options.args["disableMiddleAllLevels"] = {
			type = "toggle",
			name = L["disableMiddleAllLevelsTitle"],
			desc = L["disableMiddleAllLevelsDesc"],
			order = 13,
			get = "getDisableMiddleAllLevels",
			set = "setDisableMiddleAllLevels",
			width = 1.5,
		};
		NWB.options.args["disableChatAboveMaxBuffLevel"] = {
			type = "toggle",
			name = L["disableChatAboveMaxBuffLevelTitle"],
			desc = L["disableChatAboveMaxBuffLevelDesc"],
			order = 14,
			get = "getDisableChatAboveMaxBuffLevel",
			set = "setDisableChatAboveMaxBuffLevel",
			width = 1.5,
		};
		NWB.options.args["disableChatAllLevels"] = {
			type = "toggle",
			name = L["disableChatAllLevelsTitle"],
			desc = L["disableChatAllLevelsDesc"],
			order = 15,
			get = "getDisableChatAllLevels",
			set = "setDisableChatAllLevels",
			width = 1.5,
		};
		NWB.options.args["disableFlashAboveMaxBuffLevel"] = {
			type = "toggle",
			name = L["disableFlashAboveMaxBuffLevelTitle"],
			desc = L["disableFlashAboveMaxBuffLevelDesc"],
			order = 16,
			get = "getDisableFlashAboveMaxBuffLevel",
			set = "setDisableFlashAboveMaxBuffLevel",
			width = 1.5,
		};
		NWB.options.args["disableFlashAllLevels"] = {
			type = "toggle",
			name = L["disableFlashAllLevelsTitle"],
			desc = L["disableFlashAllLevelsDesc"],
			order = 17,
			get = "getDisableFlashAllLevels",
			set = "setDisableFlashAllLevels",
			width = 1.5,
		};
		NWB.options.args["disableLogonAboveMaxBuffLevel"] = {
			type = "toggle",
			name = L["disableLogonAboveMaxBuffLevelTitle"],
			desc = L["disableLogonAboveMaxBuffLevelDesc"],
			order = 23,
			get = "getDisableLogonAboveMaxBuffLevel",
			set = "setDisableLogonAboveMaxBuffLevel",
			width = 1.5,
		};
		NWB.options.args["disableLogonAllLevels"] = {
			type = "toggle",
			name = L["disableLogonAllLevelsTitle"],
			desc = L["disableLogonAllLevelsDesc"],
			order = 24,
			get = "getDisableLogonAllLevels",
			set = "setDisableLogonAllLevels",
			width = 1.5,
		};
		NWB.options.args["tbcNote"] = {
			type = "description",
			name = "|cFF50D050" .. L["tbcNoteText"],
			fontSize = "medium",
			order = 25,
		};
	end
	if (NWB.isTBC or NWB.realmsTBC) then
		NWB.optionDefaults.global.minimapIcon = {["minimapPos"] = 139, ["hide"] = false};
	end
	if (NWB.faction == "Alliance") then
		NWB.options.args["allianceEnableRend"] = {
			type = "toggle",
			name = L["allianceEnableRendTitle"],
			desc = L["allianceEnableRendDesc"],
			order = 117,
			get = "getAllianceEnableRend",
			set = "setAllianceEnableRend",
		};
		--Set default zg drop flight path location for alliance.
		NWB.optionDefaults.global.takeTaxiNodeZG = 2;
	else
		--Set default zg drop flight path location for horde.
		NWB.optionDefaults.global.takeTaxiNodeZG = 20;
		NWB.options.args["soundsNpcKilled"] = {
			type = "select",
			name = L["soundsNpcKilledTitle"],
			desc = L["soundsNpcKilledDesc"],
			values = function()
				return NWB:getSounds("npcKilled");
			end,
			order = 333,
			get = "getSoundsNpcKilled",
			set = "setSoundsNpcKilled",
		};
		NWB.options.args["guildNpcWalking"] = {
			type = "toggle",
			name = L["guildNpcWalkingTitle"],
			desc = L["guildNpcWalkingDesc"],
			order = 217,
			get = "getGuildNpcWalking",
			set = "setGuildNpcWalking",
		};
	end
	if (NWB.isLayered) then
		NWB.options.args["minimapLayerFrame"] = {
			type = "toggle",
			name = L["minimapLayerFrameTitle"],
			desc = L["minimapLayerFrameDesc"],
			order = 118,
			get = "getMinimapLayerFrame",
			set = "setMinimapLayerFrame",
		};
		NWB.options.args["minimapLayerFrameReset"] = {
			type = "execute",
			name = L["minimapLayerFrameResetTitle"],
			desc = L["minimapLayerFrameResetDesc"],
			func = "resetMinimapLayerFrame",
			order = 119,
		};
	end
end

------------------------
--Load option defaults--
------------------------
NWB.optionDefaults = {
	global = {
		--The Ace3 GUI color picker seems to play better with decimals.
		--Some colors work with 255 method, some don't.
		chatColorR = 1, chatColorG = 1, chatColorB = 0,
		prefixColorR = 1, prefixColorG = 0.4117647058823529, prefixColorB = 0,
		middleColorR = 1, middleColorG = 0.96, middleColorB = 0.41,
		mmColorR = 1, mmColorG = 1, mmColorB = 1,
		logonPrint = true,
		chatWarning = true,
		middleScreenWarning = true,
		chat30 = true,
		chat15 = false,
		chat10 = true,
		chat5 = false,
		chat1 = true,
		chat0 = true,
		chatZan = false,
		chatNpcKilled = true,
		middle30 = true,
		middle15 = false,
		middle10 = true,
		middle5 = false,
		middle1 = true,
		middle0 = true,
		middleBuffWarning = true,
		middleHideCombat = false,
		middleHideRaid = false,
		middleHideBattlegrounds = false,
		middleNpcKilled = true,
		middleHandInMsg = true,
		middleHandInMsgWhenOnCooldown = true,
		--These are 1/0 instead of true/false to be smaller via addon comms.
		guild10 = 1,
		guild1 = 1,
		guildNpcKilled = 1,
		guildBuffDropped = 1,
		guildNpcDialogue = 1,
		guildZanDialogue = 1,
		guildCommand = 1,
		guildSongflower = 0,
		disableAllGuildMsgs = 0,
		guildNpcWalking = 1,
		handInMsg = false,
		flashNpcWalking = true,
		rendRespawnTime = 10800,
		onyRespawnTime = 21600,
		nefRespawnTime = 28800,
		zanRespawnTime = 28800,
		syncVicinity = true,
		lastVersionMsg = 0,
		showTimeStamp = true,
		timeStampFormat = 12,
		timeStampZone = "local",
		receiveGuildDataOnly = false,
		mySongflowerOnly = false,
		syncFlowersAll = true,
		allianceEnableRend = false,
		showWorldMapMarkers = true,
		showSongflowerWorldmapMarkers = true,
		showSongflowerMinimapMarkers = true,
		showTuberWorldmapMarkers = true,
		showTuberMinimapMarkers = true,
		showDragonWorldmapMarkers = true,
		showDragonMinimapMarkers = true,
		showNewFlower = false,
		showDmfLogon = false,
		showDmfWb = false, --show dmf with /wb cmd
		showDmfWhenClose = true, --both logon and /wb
		showDmfMap = true,
		dmfBuffCooldown = 18000,
		colorizePrefixLinks = false,
		printRend = true,
		printOny = true,
		printNef = true,
		printZan = true,
		logonRend = true,
		logonOny = true,
		logonNef = true,
		logonDmfSpawn = true,
		logonDmfBuffCooldown = true,
		showDmfBuffWb = true,
		showAllAlts = false,
		filterYells = false,
		filterDrops = false,
		filterTimers = false,
		filterCommand = false,
		filterCommandResponse = false,
		filterSongflowers = false,
		filterNpcKilled = false,
		minimapLayerFrame = true,
		disableAllSounds = false,
		extraSoundOptions = false,
		soundOnlyInCity = false,
		soundsDisableInInstances = true,
		soundsDisableInBattlegrounds = false,
		soundsFirstYell = "NWB - Electronic",
		soundsOneMinute = "None",
		soundsRendDrop = "NWB - Zelda",
		soundsOnyDrop = "NWB - Zelda",
		soundsNefDrop = "NWB - Zelda",
		soundsZanDrop = "NWB - Zelda",
		soundsNpcKilled = "NWB - Pop",
		soundsNpcWalking = "NWB - MGS2",
		showExpiredTimers = true,
		expiredTimersDuration = 5,
		minimapIcon = {["minimapPos"] = 160, ["hide"] = false},
		minimapButton = true,
		flashOneMin = true,
		flashFirstYell = true,
		flashFirstYellZan = true,
		flashNpcKilled = true,
		dispelsMine = true,
		dispelsMineWBOnly = true,
		dispelsAll = false,
		dispelsAllWBOnly = false,
		soundsDispelsMine = "NWB - Dink",
		soundsDispelsAll = "NWB - Dink",
		autoDmfBuff = false,
		autoDmfBuffType = "Damage",
		autoDireMaulBuff = true,
		autoBwlPortal = true,
		showBuffStats = false,
		showBuffAllStats = false,
		minimapLayerHover = false,
		timerLogShowRend = true,
		timerLogShowOny = true,
		timerLogShowNef = true,
		timerLogMergeLayers = true,
		copyFormatDiscord = false,
		trimDataBelowLevel = 1,
		showUnbuffedAlts = false,
		timerWindowWidth = 450,
		timerWindowHeight = 300,
		buffWindowWidth = 475,
		buffWindowHeight = 400,
		ignoreKillData = false,
		noOverwrite = false,
		buffHelperDelay = 30,
		dmfGotBuffSummon = true,
		songflowerGotBuffSummon = true,
		cityGotBuffSummon = false,
		dmfVanishSummon = true,
		dmfFeignSummon = true,
		dmfLeaveBG = false,
		dmfCombatSummon = true,
		zgGotBuffSummon = true,
		takeTaxiZG = false,
		showNaxxWorldmapMarkers = true,
		showNaxxMinimapMarkers = true,
		bigWigsSupport = true,
		earlyRendScan = true,
		dmfFrame = true,
		dmfAutoRes = false,
		dmfAutoResTime = 3,
		dmfChatCountdown = true,
		resetLayers5 = true, --Reset layers one time (sometimes needed when upgrading from old version.
		resetSongflowers = true, --Reset songflowers one time.
		beta = false, --Enable features being tested on occasion.
		resetTimerData1 = true,
		resetLayerMaps = true,
		convertSettings = true,
		wipeSingleLayer = true,
		guildL = true,
		terokkarChat10 = true,
		terokkarMiddle10 = false,
		wipeTerokkarData = true,
		
		--TBC options
		disableSoundsAboveMaxBuffLevel = true,
		disableSoundsAllLevels = false,
		disableMiddleAboveMaxBuffLevel = true,
		disableMiddleAllLevels = false,
		disableChatAboveMaxBuffLevel = true,
		disableChatAllLevels = false,
		disableFlashAboveMaxBuffLevel = true,
		disableFlashAllLevels = false,
		disableLogonAboveMaxBuffLevel = true,
		disableLogonAllLevels = false,
	},
};

--Configuraton options are shared but buff data is realm and faction specific so I store timer data seperately.
--Config options = NWB.db.global (ace3)
--Timer data = NWB.data
function NWB:buildRealmFactionData()
	local defaults = {
		rendTimer = 0,
		rendYell = 0,
		rendYell2 = 0,
		onyTimer = 0,
		onyYell = 0,
		onyYell2 = 0,
		onyNpcDied = 0,
		nefTimer = 0,
		nefYell = 0,
		nefYell2 = 0,
		nefNpcDied = 0,
		--zanTimer = 0,
		zanYell = 0,
		zanYell2 = 0,
		flower1 = 0,
		flower2 = 0,
		flower3 = 0,
		flower4 = 0,
		flower5 = 0,
		flower6 = 0,
		flower7 = 0,
		flower8 = 0,
		flower9 = 0,
		flower10 = 0,
		tuber1 = 0,
		tuber2 = 0,
		tuber3 = 0,
		tuber4 = 0,
		tuber5 = 0,
		tuber6 = 0,
		dragon1 = 0,
		dragon2 = 0,
		dragon3 = 0,
		dragon4 = 0,
	};
	--Create realm and faction tables if they don't exist.
	if (not self.db.global[NWB.realm]) then
		self.db.global[NWB.realm] = {};
	end
	if (not self.db.global[NWB.realm][NWB.faction]) then
		self.db.global[NWB.realm][NWB.faction] = {};
	end
	if (not self.db.global[NWB.realm][NWB.faction].myChars) then
		self.db.global[NWB.realm][NWB.faction].myChars = {};
	end
	if (not self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")]) then
		self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")] = {};
	end
	if (not self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].buffs) then
		self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].buffs = {};
	end
	if (not self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].rendCount) then
		self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].rendCount = 0;
	end
	if (not self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].onyCount) then
		self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].onyCount = 0;
	end
	if (not self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].nefCount) then
		self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].nefCount = 0;
	end
	if (not self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].zanCount) then
		self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].zanCount = 0;
	end
	--if (not self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].dmfCooldown) then
	--	self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].dmfCooldown = 9999999999;
	--end
	if (not self.db.global[NWB.realm][NWB.faction].layers) then
		self.db.global[NWB.realm][NWB.faction].layers = {};
	end
	if (not self.db.global[NWB.realm][NWB.faction].layersDisabled) then
		self.db.global[NWB.realm][NWB.faction].layersDisabled = {};
	end
	if (not self.db.global[NWB.realm][NWB.faction].timerLog) then
		self.db.global[NWB.realm][NWB.faction].timerLog = {};
	end
	if (not self.db.global[NWB.realm][NWB.faction].dmfBuffSettings) then
		--Enable after testing at the next DMF.
		self.db.global[NWB.realm][NWB.faction].dmfBuffSettings = {};
	end
	local localizedClass, englishClass = UnitClass("player");
	self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].localizedClass = localizedClass;
	self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].englishClass = englishClass;
	self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].level = UnitLevel("player");
	self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].race = UnitRace("player");
	self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].g = UnitGUID("player");
	self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].faction = UnitFactionGroup("player");
	self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].playerName = UnitName("player");
	for k, v in pairs(defaults) do
		if (not self.db.global[NWB.realm][NWB.faction][k]) then
			--Add default values if no value is already set.
			self.db.global[NWB.realm][NWB.faction][k] = v;
		end
	end
	--Timer data is stored within the ace3 global table but I create a shortcut here "NWB.data".
	self.data = self.db.global[NWB.realm][NWB.faction];
end

function NWB:convertSettings()
	if (NWB.db.global.convertSettings) then
		if (NWB.db.global.guild10 == true or NWB.db.global.guild10 == 1) then
			NWB.db.global.guild10 = 1;
		else
			NWB.db.global.guild10 = 0;
		end
		if (NWB.db.global.guild1 or NWB.db.global.guild1 == 1) then
			NWB.db.global.guild1 = 1;
		else
			NWB.db.global.guild1 = 0;
		end
		if (NWB.db.global.guildNpcKilled == true or NWB.db.global.guildNpcKilled == 1) then
			NWB.db.global.guildNpcKilled = 1;
		else
			NWB.db.global.guildNpcKilled = 0;
		end
		if (NWB.db.global.guildBuffDropped == true or NWB.db.global.guildBuffDropped == 1) then
			NWB.db.global.guildBuffDropped = 1;
		else
			NWB.db.global.guildBuffDropped = 0;
		end
		if (NWB.db.global.guildNpcDialogue == true or NWB.db.global.guildNpcDialogue == 1) then
			NWB.db.global.guildNpcDialogue = 1;
		else
			NWB.db.global.guildNpcDialogue = 0;
		end
		if (NWB.db.global.guildZanDialogue == true or NWB.db.global.guildZanDialogue == 1) then
			NWB.db.global.guildZanDialogue = 1;
		else
			NWB.db.global.guildZanDialogue = 0;
		end
		if (NWB.db.global.guildCommand == true or NWB.db.global.guildCommand == 1) then
			NWB.db.global.guildCommand = 1;
		else
			NWB.db.global.guildCommand = 0;
		end
		if (NWB.db.global.disableAllGuildMsgs == true or NWB.db.global.disableAllGuildMsgs == 1) then
			NWB.db.global.disableAllGuildMsgs = 1;
		else
			NWB.db.global.disableAllGuildMsgs = 0;
		end
		NWB.db.global.convertSettings = false;
	end
end

--Print timers to chat window at logon time.
function NWB:setLogonPrint(info, value)
	self.db.global.logonPrint = value;
end

function NWB:getLogonPrint(info)
	return self.db.global.logonPrint;
end

--Show a time stamp after the timers.
function NWB:setShowTimeStamp(info, value)
	self.db.global.showTimeStamp = value;
end

function NWB:getShowTimeStamp(info)
	return self.db.global.showTimeStamp;
end

--Which timestamp format to use 12h/24h.
function NWB:setTimeStampFormat(info, value)
	self.db.global.timeStampFormat = value;
end

function NWB:getTimeStampFormat(info)
	return self.db.global.timeStampFormat;
end

--Which timezone format to use local/server.
function NWB:setTimeStampZone(info, value)
	self.db.global.timeStampZone = value;
end

function NWB:getTimeStampZone(info)
	return self.db.global.timeStampZone;
end

--Show world map markers.
function NWB:setShowWorldMapMarkers(info, value)
	self.db.global.showWorldMapMarkers = value;
	NWB:refreshWorldbuffMarkers();
end

function NWB:getShowWorldMapMarkers(info)
	return self.db.global.showWorldMapMarkers;
end

--Enable rend timers for alliance.
function NWB:setAllianceEnableRend(info, value)
	self.db.global.allianceEnableRend = value;
	NWB:refreshWorldbuffMarkers();
end

function NWB:getAllianceEnableRend(info)
	return self.db.global.allianceEnableRend;
end

--Ignore data from outside the guild.
function NWB:setReceiveGuildDataOnly(info, value)
	self.db.global.receiveGuildDataOnly = value;
end

function NWB:getReceiveGuildDataOnly(info)
	return self.db.global.receiveGuildDataOnly;
end

--Chat color.
function NWB:setChatColor(info, r, g, b, a)
	self.db.global.chatColorR, self.db.global.chatColorG, self.db.global.chatColorB = r, g, b;
	NWB.chatColor = "|cff" .. NWB:RGBToHex(self.db.global.chatColorR, self.db.global.chatColorG, self.db.global.chatColorB);
end

function NWB:getChatColor(info)
	return self.db.global.chatColorR, self.db.global.chatColorG, self.db.global.chatColorB;
end

--Middle of screen color.
function NWB:setMiddleColor(info, r, g, b, a)
	self.db.global.middleColorR, self.db.global.middleColorG, self.db.global.middleColorB = r, g, b;
end

function NWB:getMiddleColor(info)
	return self.db.global.middleColorR, self.db.global.middleColorG, self.db.global.middleColorB;
end

--Minimap layer color.
function NWB:setMmColor(info, r, g, b, a)
	self.db.global.mmColorR, self.db.global.mmColorG, self.db.global.mmColorB = r, g, b;
	NWB.mmColor = "|cff" .. NWB:RGBToHex(self.db.global.mmColorR, self.db.global.mmColorG, self.db.global.mmColorB);
	NWB:recalcMinimapLayerFrame();
end

function NWB:getMmColor(info)
	return self.db.global.mmColorR, self.db.global.mmColorG, self.db.global.mmColorB;
end

--Reset colors.
function NWB:resetColors(info, r, g, b, a)
	self.db.global.chatColorR = self.optionDefaults.global.chatColorR;
	self.db.global.chatColorG = self.optionDefaults.global.chatColorG;
	self.db.global.chatColorB = self.optionDefaults.global.chatColorB;
	self.db.global.middleColorR = self.optionDefaults.global.middleColorR;
	self.db.global.middleColorG = self.optionDefaults.global.middleColorG;
	self.db.global.middleColorB = self.optionDefaults.global.middleColorB;
	self.db.global.mmColorR = self.optionDefaults.global.mmColorR;
	self.db.global.mmColorG = self.optionDefaults.global.mmColorG;
	self.db.global.mmColorB = self.optionDefaults.global.mmColorB;
	NWB.chatColor = "|cff" .. NWB:RGBToHex(self.db.global.chatColorR, self.db.global.chatColorG, self.db.global.chatColorB);
	NWB.mmColor = "|cff" .. NWB:RGBToHex(self.db.global.mmColorR, self.db.global.mmColorG, self.db.global.mmColorB);
	NWB:recalcMinimapLayerFrame();
end

--Reset colors.
function NWB:resetMinimapLayerFrame(info)
	MinimapLayerFrame:ClearAllPoints();
	MinimapLayerFrame:SetPoint("BOTTOM", Minimap, 2, 4);
end
--Colorize chat prefix in all chat channels.
function NWB:setColorizePrefixLinks(info, value)
	self.db.global.colorizePrefixLinks = value;
end

function NWB:getColorizePrefixLinks(info)
	return self.db.global.colorizePrefixLinks;
end

--Show buff stats.
function NWB:setShowBuffStats(info, value)
	self.db.global.showBuffStats = value;
	NWB.showStatsButton:SetChecked(value);
	NWB:recalcBuffListFrame(true);
end

function NWB:getShowBuffStats(info)
	return self.db.global.showBuffStats;
end

--Show all alts with buff stats in the buffs window.
function NWB:setShowAllAlts(info, value)
	self.db.global.showBuffAllStats = value;
	NWB.showStatsAllButton:SetChecked(value);
	NWB:recalcBuffListFrame(true);
end

function NWB:getShowAllAlts(info)
	return self.db.global.showBuffAllStats;
end

--Show unbuffed alts in the buffs window.
function NWB:setShowUnbuffedAlts(info, value)
	self.db.global.showUnbuffedAlts = value;
	NWB:recalcBuffListFrame(true);
end

function NWB:getShowUnbuffedAlts(info)
	return self.db.global.showUnbuffedAlts;
end

--Flash one min warnings.
function NWB:setFlashOneMin(info, value)
	self.db.global.flashOneMin = value;
end

function NWB:getFlashOneMin(info)
	return self.db.global.flashOneMin;
end

--Flash first yell.
function NWB:setFlashFirstYell(info, value)
	self.db.global.flashFirstYell = value;
end

function NWB:getFlashFirstYell(info)
	return self.db.global.flashFirstYell;
end

--Flash first yell zandalar buff.
function NWB:setFlashFirstYellZan(info, value)
	self.db.global.flashFirstYellZan = value;
end

function NWB:getFlashFirstYellZan(info)
	return self.db.global.flashFirstYellZan;
end

--Flash NPC killed.
function NWB:setFlashNpcKilled(info, value)
	self.db.global.flashNpcKilled = value;
end

function NWB:getFlashNpcKilled(info)
	return self.db.global.flashNpcKilled;
end

--Minimap button
function NWB:setMinimapButton(info, value)
	self.db.global.minimapButton = value;
	if (value) then
		NWB.LDBIcon:Show("NovaWorldBuffs");
		self.db.global.minimapIcon.hide = false;
	else
		NWB.LDBIcon:Hide("NovaWorldBuffs");
		self.db.global.minimapIcon.hide = true;
	end
end

function NWB:getMinimapButton(info)
	return self.db.global.minimapButton;
end

--Chat 30 minute warning.
function NWB:setChat30(info, value)
	self.db.global.chat30 = value;
end

function NWB:getChat30(info)
	return self.db.global.chat30;
end

--Chat 15 minute warning.
function NWB:setChat15(info, value)
	self.db.global.chat15 = value;
end

function NWB:getChat15(info)
	return self.db.global.chat15;
end

--Chat 10 minute warning.
function NWB:setChat10(info, value)
	self.db.global.chat10 = value;
end

function NWB:getChat10(info)
	return self.db.global.chat10;
end

--Chat 5 minute warning.
function NWB:setChat5(info, value)
	self.db.global.chat5 = value;
end

function NWB:getChat5(info)
	return self.db.global.chat5;
end

--Chat 1 minute warning.
function NWB:setChat1(info, value)
	self.db.global.chat1 = value;
end

function NWB:getChat1(info)
	return self.db.global.chat1;
end

--Chat timer finished warning.
function NWB:setChat0(info, value)
	self.db.global.chat0 = value;
end

function NWB:getChat0(info)
	return self.db.global.chat0;
end

--Chat zan warning.
function NWB:setChatZan(info, value)
	self.db.global.chatZan = value;
end

function NWB:getChatZan(info)
	return self.db.global.chatZan;
end

--Chat NPC killed warning.
function NWB:setChatNpcKilled(info, value)
	self.db.global.chatNpcKilled = value;
end

function NWB:getChatNpcKilled(info)
	return self.db.global.chatNpcKilled;
end

--Middle of the screen 30 minute warning.
function NWB:setMiddle30(info, value)
	self.db.global.middle30 = value;
end

function NWB:getMiddle30(info)
	return self.db.global.middle30;
end

--Middle of the screen 15 minute warning.
function NWB:setMiddle15(info, value)
	self.db.global.middle15 = value;
end

function NWB:getMiddle15(info)
	return self.db.global.middle15;
end

--Middle of the screen 10 minute warning.
function NWB:setMiddle10(info, value)
	self.db.global.middle10 = value;
end

function NWB:getMiddle10(info)
	return self.db.global.middle10;
end

--Middle of the screen 5 minute warning.
function NWB:setMiddle5(info, value)
	self.db.global.middle5 = value;
end

function NWB:getMiddle5(info)
	return self.db.global.middle5;
end

--Middle of the screen 1 minute warning.
function NWB:setMiddle1(info, value)
	self.db.global.middle1 = value;
end

function NWB:getMiddle1(info)
	return self.db.global.middle1;
end

--Middle of the screen 0 minute warning.
function NWB:setMiddle0(info, value)
	self.db.global.middle0 = value;
end

function NWB:getMiddle0(info)
	return self.db.global.middle0;
end

--Middle of the screen buff hand in warning.
function NWB:setMiddleBuffWarning(info, value)
	self.db.global.middleBuffWarning = value;
end

function NWB:getMiddleBuffWarning(info)
	return self.db.global.middleBuffWarning;
end

--Middle of the screen hide in combat.
function NWB:setMiddleHideCombat(info, value)
	self.db.global.middleHideCombat = value;
end

function NWB:getMiddleHideCombat(info)
	return self.db.global.middleHideCombat;
end

--Middle of the screen hide in raid.
function NWB:setMiddleHideRaid(info, value)
	self.db.global.middleHideRaid = value;
end

function NWB:getMiddleHideRaid(info)
	return self.db.global.middleHideRaid;
end

--Middle of the screen hide in raid.
function NWB:setMiddleHideBattlegrounds(info, value)
	self.db.global.middleHideBattlegrounds = value;
end

function NWB:getMiddleHideBattlegrounds(info)
	return self.db.global.middleHideBattlegrounds;
end

--Middle of the screen NPC killed warning.
function NWB:setMiddleNpcKilled(info, value)
	self.db.global.middleNpcKilled = value;
end

function NWB:getMiddleNpcKilled(info)
	return self.db.global.middleNpcKilled;
end

--Guild 10 minute warning.
function NWB:setGuild10(info, value)
	if (value) then
		self.db.global.guild10 = 1;
	else
		self.db.global.guild10 = 0;
	end
	NWB:sendSettings("GUILD");
end

function NWB:getGuild10(info)
	if (self.db.global.guild10 == 1) then
		return true;
	else
		return false;
	end
end

--Guild 1 minute warning.
function NWB:setGuild1(info, value)
	if (value) then
		self.db.global.guild1 = 1;
	else
		self.db.global.guild1 = 0;
	end
	NWB:sendSettings("GUILD");
end

function NWB:getGuild1(info)
	if (self.db.global.guild1 == 1) then
		return true;
	else
		return false;
	end
end

--Guild NPC killed.
function NWB:setGuildNpcKilled(info, value)
	if (value) then
		self.db.global.guildNpcKilled = 1;
	else
		self.db.global.guildNpcKilled = 0;
	end
	NWB:sendSettings("GUILD");
end

function NWB:getGuildNpcKilled(info)
	if (self.db.global.guildNpcKilled == 1) then
		return true;
	else
		return false;
	end
end

--Guild buff dropped.
function NWB:setGuildBuffDropped(info, value)
	if (value) then
		self.db.global.guildBuffDropped = 1;
	else
		self.db.global.guildBuffDropped = 0;
	end
	NWB:sendSettings("GUILD");
end

function NWB:getGuildBuffDropped(info)
	if (self.db.global.guildBuffDropped == 1) then
		return true;
	else
		return false;
	end
end

--Guild NPC dialogue started.
function NWB:setGuildNpcDialogue(info, value)
	if (value) then
		self.db.global.guildNpcDialogue = 1;
	else
		self.db.global.guildNpcDialogue = 0;
	end
	NWB:sendSettings("GUILD");
end

function NWB:getGuildNpcDialogue(info)
	if (self.db.global.guildNpcDialogue == 1) then
		return true;
	else
		return false;
	end
end

--Guild Zan dialogue started.
function NWB:setGuildZanDialogue(info, value)
	if (value) then
		self.db.global.guildZanDialogue = 1;
	else
		self.db.global.guildZanDialogue = 0;
	end
	NWB:sendSettings("GUILD");
end

function NWB:getGuildZanDialogue(info)
	if (self.db.global.guildZanDialogue == 1) then
		return true;
	else
		return false;
	end
end

--Guild !wb command.
function NWB:setGuildCommand(info, value)
	if (value) then
		self.db.global.guildCommand = 1;
	else
		self.db.global.guildCommand = 0;
	end
	NWB:sendSettings("GUILD");
end

function NWB:getGuildCommand(info)
	if (self.db.global.guildCommand == 1) then
		return true;
	else
		return false;
	end
end

--Disable all guild msgs.
function NWB:setDisableAllGuildMsgs(info, value)
	if (value) then
		self.db.global.disableAllGuildMsgs = 1;
	else
		self.db.global.disableAllGuildMsgs = 0;
	end
	NWB:sendSettings("GUILD");
end

function NWB:getDisableAllGuildMsgs(info)
	if (self.db.global.disableAllGuildMsgs == 1) then
		return true;
	else
		return false;
	end
end

--Guild songflower picked announce.
function NWB:setGuildSongflower(info, value)
	if (value) then
		self.db.global.guildSongflower = 1;
	else
		self.db.global.guildSongflower = 0;
	end
	NWB:sendSettings("GUILD");
end

function NWB:getGuildSongflower(info)
	if (self.db.global.guildSongflower == 1) then
		return true;
	else
		return false;
	end
end

--Only set songflower timer if I picked it.
function NWB:setMySongflowerOnly(info, value)
	self.db.global.mySongflowerOnly = value;
end

function NWB:getMySongflowerOnly(info)
	return self.db.global.mySongflowerOnly;
end

--Sync songflowers on all channels when guild only is selected for data.
function NWB:setSyncFlowersAll(info, value)
	self.db.global.syncFlowersAll = value;
end

function NWB:getSyncFlowersAll(info)
	return self.db.global.syncFlowersAll;
end

--Sync songflowers on all channels when guild only is selected for data.
function NWB:setShowNewFlower(info, value)
	self.db.global.showNewFlower = value;
end

function NWB:getShowNewFlower(info)
	return self.db.global.showNewFlower;
end

--Show world map songflower markers.
function NWB:setShowSongflowerWorldmapMarkers(info, value)
	self.db.global.showSongflowerWorldmapMarkers = value;
	NWB:refreshFelwoodMarkers();
end

function NWB:getShowSongflowerWorldmapMarkers(info)
	return self.db.global.showSongflowerWorldmapMarkers;
end

--Show mini map songflower markers.
function NWB:setShowSongflowerMinimapMarkers(info, value)
	self.db.global.showSongflowerMinimapMarkers = value;
	NWB:refreshFelwoodMarkers();
end

function NWB:getShowSongflowerMinimapMarkers(info)
	return self.db.global.showSongflowerMinimapMarkers;
end

--Show world map tuber markers.
function NWB:setShowTuberWorldmapMarkers(info, value)
	self.db.global.showTuberWorldmapMarkers = value;
	NWB:refreshFelwoodMarkers();
end

function NWB:getShowTuberWorldmapMarkers(info)
	return self.db.global.showTuberWorldmapMarkers;
end

--Show mini map tuber markers.
function NWB:setShowTuberMinimapMarkers(info, value)
	self.db.global.showTuberMinimapMarkers = value;
	NWB:refreshFelwoodMarkers();
end

function NWB:getShowTuberMinimapMarkers(info)
	return self.db.global.showTuberMinimapMarkers;
end

--Show world map dragon markers.
function NWB:setShowDragonWorldmapMarkers(info, value)
	self.db.global.showDragonWorldmapMarkers = value;
	NWB:refreshFelwoodMarkers();
end

function NWB:getShowDragonWorldmapMarkers(info)
	return self.db.global.showDragonWorldmapMarkers;
end

--Show mini map dragon markers.
function NWB:setShowDragonMinimapMarkers(info, value)
	self.db.global.showDragonMinimapMarkers = value;
	NWB:refreshFelwoodMarkers();
end

function NWB:getShowDragonMinimapMarkers(info)
	return self.db.global.showDragonMinimapMarkers;
end

--Show expired timers.
function NWB:setShowExpiredTimers(info, value)
	self.db.global.showExpiredTimers = value;
end

function NWB:getShowExpiredTimers(info)
	return self.db.global.showExpiredTimers;
end

--Expired timers duration.
function NWB:setExpiredTimersDuration(info, value)
	self.db.global.expiredTimersDuration = value;
end

function NWB:getExpiredTimersDuration(info)
	return self.db.global.expiredTimersDuration;
end

--Show DMF at logon always.
function NWB:setShowDmfLogon(info, value)
	self.db.global.showDmfLogon = value;
end

function NWB:getShowDmfLogon(info)
	return self.db.global.showDmfLogon;
end

--Show DMF timer together with /wb.
function NWB:setShowDmfWb(info, value)
	self.db.global.showDmfWb = value;
end

function NWB:getShowDmfWb(info)
	return self.db.global.showDmfWb;
end

--Show DMF buff cooldown together with /wb.
function NWB:setShowDmfBuffWb(info, value)
	self.db.global.showDmfBuffWb = value;
end

function NWB:getShowDmfBuffWb(info)
	return self.db.global.showDmfBuffWb;
end

--Show DMF when timer is close to spawn.
function NWB:setShowDmfWhenClose(info, value)
	self.db.global.showDmfWhenClose = value;
end

function NWB:getShowDmfWhenClose(info)
	return self.db.global.showDmfWhenClose;
end

--Show DMF map marker.
function NWB:setShowDmfMap(info, value)
	self.db.global.showDmfMap = value;
	NWB:refreshDmfMarkers();
end

function NWB:getShowDmfMap(info)
	return self.db.global.showDmfMap;
end


--Rend logon msg.
function NWB:setLogonRend(info, value)
	self.db.global.logonRend = value;
end

function NWB:getLogonRend(info)
	return self.db.global.logonRend;
end

--Ony logon msg.
function NWB:setLogonOny(info, value)
	self.db.global.logonOny = value;
end

function NWB:getLogonOny(info)
	return self.db.global.logonOny;
end

--Nef logon msg.
function NWB:setLogonNef(info, value)
	self.db.global.logonNef = value;
end

function NWB:getLogonNef(info)
	return self.db.global.logonNef;
end

--DMF spawn logon msg.
function NWB:setLogonDmfSpawn(info, value)
	self.db.global.logonDmfSpawn = value;
end

function NWB:getLogonDmfSpawn(info)
	return self.db.global.logonDmfSpawn;
end

--DMF buff cooldown logon msg.
function NWB:setLogonDmfBuffCooldown(info, value)
	self.db.global.logonDmfBuffCooldown = value;
end

function NWB:getLogonDmfBuffCooldown(info)
	return self.db.global.logonDmfBuffCooldown;
end

--Filter guild chat buff warning.
function NWB:setFilterYells(info, value)
	self.db.global.filterYells = value;
end

function NWB:getFilterYells(info)
	return self.db.global.filterYells;
end

--Filter guild chat buff dropped.
function NWB:setFilterDrops(info, value)
	self.db.global.filterDrops = value;
end

function NWB:getFilterDrops(info)
	return self.db.global.filterDrops;
end

--Filter guild chat buff timer warnings.
function NWB:setFilterTimers(info, value)
	self.db.global.filterTimers = value;
end

function NWB:getFilterTimers(info)
	return self.db.global.filterTimers;
end

--Filter guild chat !wb and !dmf commands.
function NWB:setFilterCommand(info, value)
	self.db.global.filterCommand = value;
end

function NWB:getFilterCommand(info)
	return self.db.global.filterCommand;
end

--Filter guild chat !wb and !dmf command response.
function NWB:setFilterCommandResponse(info, value)
	self.db.global.filterCommandResponse = value;
end

function NWB:getFilterCommandResponse(info)
	return self.db.global.filterCommandResponse;
end

--Filter guild chat songflower picked.
function NWB:setFilterSongflowers(info, value)
	self.db.global.filterSongflowers = value;
end

function NWB:getFilterSongflowers(info)
	return self.db.global.filterSongflowers;
end

--Filter guild chat NPC killed msg.
function NWB:setFilterNpcKilled(info, value)
	self.db.global.filterNpcKilled = value;
end

function NWB:getFilterNpcKilled(info)
	return self.db.global.filterNpcKilled;
end

--Minimap layer frame.
function NWB:setMinimapLayerFrame(info, value)
	self.db.global.minimapLayerFrame = value;
	NWB:recalcMinimapLayerFrame();
end

function NWB:getMinimapLayerFrame(info)
	return self.db.global.minimapLayerFrame;
end

------------
---Sounds---
------------

local sounds = {
	--Random snipets from youtube mostly.
	["NWB - Zelda"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\Zelda.ogg",
	["NWB - FF7"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\FF7.ogg",
	["NWB - Bell"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\Bell.ogg",
	["NWB - Alarm"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\Alarm.ogg",
	["NWB - Alien"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\Alien.ogg",
	["NWB - Clock"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\Clock.ogg",
	["NWB - Electronic"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\Electronic.ogg",
	["NWB - Pop"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\Pop.ogg",
	["NWB - Pop2"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\Pop2.ogg",
	["NWB - Dink"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\Dink.ogg",
	["NWB - MGS"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\MGS.ogg",
	["NWB - MGS2"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\MGS2.ogg",
	["NWB - WT"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\WT.ogg",
}

function NWB:registerSounds()
	for k, v in pairs(sounds) do
		NWB.LSM:Register("sound", k, v);
	end
end

function NWB:getSounds(type)
	NWB.sounds = {};
	if (self.db.global.extraSoundOptions) then
		for _, v in pairs(NWB.LSM:List("sound")) do
			NWB.sounds[v] = v;
		end
	else
		for k, v in NWB:pairsByKeys(sounds) do
			NWB.sounds[k] = k;
		end
		NWB.sounds["None"] = "None";
	end
	if (type == "rend") then
		NWB.sounds["NWB - Rend Voice"] = "NWB - Rend Voice";
	elseif (type == "ony") then
		NWB.sounds["NWB - Ony Voice"] = "NWB - Ony Voice";
	elseif (type == "nef") then
		NWB.sounds["NWB - Nef Voice"] = "NWB - Nef Voice";
		NWB.sounds["NWB - Ony Voice"] = "NWB - Ony Voice";
	elseif (type == "zan") then
		NWB.sounds["NWB - Zandalar Voice"] = "NWB - Zandalar Voice";
	end
	return NWB.sounds;
end

--Disable all sounds.
function NWB:setDisableAllSounds(info, value)
	self.db.global.disableAllSounds = value;
end

function NWB:getDisableAllSounds(info)
	return self.db.global.disableAllSounds;
end

--Enable extra sounds.
function NWB:setExtraSoundOptions(info, value)
	self.db.global.extraSoundOptions = value;
end

function NWB:getExtraSoundOptions(info)
	return self.db.global.extraSoundOptions;
end

--Only plays sounds in city.
function NWB:setSoundOnlyInCity(info, value)
	self.db.global.soundOnlyInCity = value;
end

function NWB:getSoundOnlyInCity(info)
	return self.db.global.soundOnlyInCity;
end

--Only plays sounds in city.
function NWB:setSoundsDisableInInstances(info, value)
	self.db.global.soundsDisableInInstances = value;
end

function NWB:getSoundsDisableInInstances(info)
	return self.db.global.soundsDisableInInstances;
end

--Only plays sounds in city.
function NWB:setSoundsDisableInBattlegrounds(info, value)
	self.db.global.soundsDisableInBattlegrounds = value;
end

function NWB:getSoundsDisableInBattlegrounds(info)
	return self.db.global.soundsDisableInBattlegrounds;
end

--First yell sound.
function NWB:setSoundsFirstYell(info, value)
	self.db.global.soundsFirstYell = value;
	local soundFile = NWB.LSM:Fetch("sound", value);
	PlaySoundFile(soundFile);
end

function NWB:getSoundsFirstYell(info)
	return self.db.global.soundsFirstYell;
end

--One minute warning sound.
function NWB:setSoundsOneMinute(info, value)
	self.db.global.soundsOneMinute = value;
	local soundFile = NWB.LSM:Fetch("sound", value);
	PlaySoundFile(soundFile);
end

function NWB:getSoundsOneMinute(info)
	return self.db.global.soundsOneMinute;
end

--Rend drop sound.
function NWB:setSoundsRendDrop(info, value)
	self.db.global.soundsRendDrop = value;
	if (value == "NWB - Rend Voice") then
		PlaySoundFile("Interface\\AddOns\\NovaWorldBuffs\\Media\\RendDropped.ogg", "Master");
	else
		local soundFile = NWB.LSM:Fetch("sound", value);
		PlaySoundFile(soundFile);
	end
end

function NWB:getSoundsRendDrop(info)
	return self.db.global.soundsRendDrop;
end

--Ony drop sound.
function NWB:setSoundsOnyDrop(info, value)
	self.db.global.soundsOnyDrop = value;
	if (value == "NWB - Ony Voice") then
		PlaySoundFile("Interface\\AddOns\\NovaWorldBuffs\\Media\\OnyxiaDropped.ogg", "Master");
	else
		local soundFile = NWB.LSM:Fetch("sound", value);
		PlaySoundFile(soundFile);
	end
end

function NWB:getSoundsOnyDrop(info)
	return self.db.global.soundsOnyDrop;
end

--Nef drop sound.
function NWB:setSoundsNefDrop(info, value)
	self.db.global.soundsNefDrop = value;
	if (value == "NWB - Nef Voice") then
		PlaySoundFile("Interface\\AddOns\\NovaWorldBuffs\\Media\\NefarianDropped.ogg", "Master");
	elseif (value == "NWB - Ony Voice") then
		PlaySoundFile("Interface\\AddOns\\NovaWorldBuffs\\Media\\OnyxiaDropped.ogg", "Master");
	else
		local soundFile = NWB.LSM:Fetch("sound", value);
		PlaySoundFile(soundFile);
	end
end

function NWB:getSoundsNefDrop(info)
	return self.db.global.soundsNefDrop;
end

--Zan drop sound.
function NWB:setSoundsZanDrop(info, value)
	self.db.global.soundsZanDrop = value;
	if (value == "NWB - Zandalar Voice") then
		PlaySoundFile("Interface\\AddOns\\NovaWorldBuffs\\Media\\ZandalarDropped.ogg", "Master");
	else
		local soundFile = NWB.LSM:Fetch("sound", value);
		PlaySoundFile(soundFile);
	end
end

function NWB:getSoundsZanDrop(info)
	return self.db.global.soundsZanDrop;
end

--NPC killed sound.
function NWB:setSoundsNpcKilled(info, value)
	self.db.global.soundsNpcKilled = value;
	local soundFile = NWB.LSM:Fetch("sound", value);
	PlaySoundFile(soundFile);
end

function NWB:getSoundsNpcKilled(info)
	return self.db.global.soundsNpcKilled;
end

--My buffs dispelled.
function NWB:setSoundsDispelsMine(info, value)
	self.db.global.soundsDispelsMine = value;
	local soundFile = NWB.LSM:Fetch("sound", value);
	PlaySoundFile(soundFile);
end

function NWB:getSoundsDispelsMine(info)
	return self.db.global.soundsDispelsMine;
end

--Others buffs dispelled.
function NWB:setSoundsDispelsAll(info, value)
	self.db.global.soundsDispelsAll = value;
	local soundFile = NWB.LSM:Fetch("sound", value);
	PlaySoundFile(soundFile);
end

function NWB:getSoundsDispelsAll(info)
	return self.db.global.soundsDispelsAll;
end

--Show my buffs dispelled.
function NWB:setDispelsMine(info, value)
	self.db.global.dispelsMine = value;
end

function NWB:getDispelsMine(info)
	return self.db.global.dispelsMine;
end

--Show my buffs dispelled (world buffs only).
function NWB:setDispelsMineWBOnly(info, value)
	self.db.global.dispelsMineWBOnly = value;
end

function NWB:getDispelsMineWBOnly(info)
	return self.db.global.dispelsMineWBOnly;
end

--Show all buffs dispelled.
function NWB:setDispelsAll(info, value)
	self.db.global.dispelsAll = value;
end

function NWB:getDispelsAll(info)
	return self.db.global.dispelsAll;
end

--Show all buffs dispelled (world buffs only).
function NWB:setDispelsAllWBOnly(info, value)
	self.db.global.dispelsAllWBOnly = value;
end

function NWB:getDispelsAllWBOnly(info)
	return self.db.global.dispelsAllWBOnly;
end

--Auto get DMF buff.
function NWB:setAutoDmfBuff(info, value)
	self.db.global.autoDmfBuff = value;
end

function NWB:getAutoDmfBuff(info)
	return self.db.global.autoDmfBuff;
end

--Which DMF buff to get.
function NWB:setAutoDmfBuffType(info, value)
	if (NWB.data.dmfBuffSettings) then
		NWB.data.dmfBuffSettings[UnitName("player")] = value;
	else
		self.db.global.autoDmfBuffType = value;
	end
end

function NWB:getAutoDmfBuffType(info)
	if (NWB.data.dmfBuffSettings and NWB.data.dmfBuffSettings[UnitName("player")]) then
		return NWB.data.dmfBuffSettings[UnitName("player")];
	else
		return self.db.global.autoDmfBuffType;
	end
end

--Auto get Dire Maul buff.
function NWB:setAutoDireMaulBuff(info, value)
	self.db.global.autoDireMaulBuff = value;
end

function NWB:getAutoDireMaulBuff(info)
	return self.db.global.autoDireMaulBuff;
end

--Auto enter BWL portal.
function NWB:setAutoBwlPortal(info, value)
	self.db.global.autoBwlPortal = value;
end

function NWB:getAutoBwlPortal(info)
	return self.db.global.autoBwlPortal;
end

--Show minimap layer frame on mouseover only.
function NWB:setMinimapLayerHover(info, value)
	self.db.global.minimapLayerHover = value;
	if (not value and NWB.minimapLayerFrameState) then
		MinimapLayerFrame:Show();
	elseif (value) then
		MinimapLayerFrame:Hide();
	end
end

function NWB:getMinimapLayerHover(info)
	return self.db.global.minimapLayerHover;
end

--Trim data of characters below this level.
function NWB:setTrimDataBelowLevel(info, value)
	self.db.global.trimDataBelowLevel = value;
end

function NWB:getTrimDataBelowLevel(info)
	return self.db.global.trimDataBelowLevel;
end

--Trim data for single char.
function NWB:setTrimDataCharInput(info, value)
	NWB:removeSingleChar(value);
end

function NWB:getTrimDataCharInput(info)

end

--Window dimensions.
function NWB:setTimerWindowWidth(info, value)
	self.db.global.timerWindowWidth = value;
	_G["NWBlayerFrame"]:SetWidth(value);
	_G["NWBlayerFrame"].EditBox:SetWidth(value - 30);
end

function NWB:getTimerWindowWidth(info)
	return self.db.global.timerWindowWidth;
end

--Window dimensions.
function NWB:setTimerWindowHeight(info, value)
	self.db.global.timerWindowHeight = value;
	_G["NWBlayerFrame"]:SetHeight(value);
end

function NWB:getTimerWindowHeight(info)
	return self.db.global.timerWindowHeight;
end

--Window dimensions.
function NWB:setBuffWindowWidth(info, value)
	self.db.global.buffWindowWidth = value;
	_G["NWBbuffListFrame"]:SetWidth(value);
	_G["NWBbuffListFrame"].EditBox:SetWidth(value - 30);
end

function NWB:getBuffWindowWidth(info)
	return self.db.global.buffWindowWidth;
end

--Window dimensions.
function NWB:setBuffWindowHeight(info, value)
	self.db.global.buffWindowHeight = value;
	_G["NWBbuffListFrame"]:SetHeight(value);
end

function NWB:getBuffWindowHeight(info)
	return self.db.global.buffWindowHeight;
end

function NWB:setIgnoreKillData(info, value)
	self.db.global.ignoreKillData = value;
end

function NWB:getIgnoreKillData(info)
	return self.db.global.ignoreKillData;
end

function NWB:setNoOverwrite(info, value)
	self.db.global.noOverwrite = value;
end

function NWB:getNoOverwrite(info)
	return self.db.global.noOverwrite;
end

--DMF settings list frame.
local NWBDMFListFrame = CreateFrame("ScrollFrame", "NWBDMFListFrame", UIParent, NWB:addBackdrop("InputScrollFrameTemplate"));
NWBDMFListFrame:Hide();
NWBDMFListFrame:SetToplevel(true);
NWBDMFListFrame:SetMovable(true);
NWBDMFListFrame:EnableMouse(true);
tinsert(UISpecialFrames, "NWBDMFListFrame");
NWBDMFListFrame:SetPoint("CENTER", UIParent, 0, 100);
NWBDMFListFrame:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8",insets = {top = 0, left = 0, bottom = 0, right = 0}});
NWBDMFListFrame:SetBackdropColor(0,0,0,.5);
NWBDMFListFrame.CharCount:Hide();
NWBDMFListFrame:SetFrameStrata("HIGH");
NWBDMFListFrame.EditBox:SetAutoFocus(false);
NWBDMFListFrame.EditBox:SetScript("OnKeyDown", function(self, arg)
	--If control key is down keep focus for copy/paste to work.
	--Otherwise remove focus so "enter" can be used to open chat and not have a stuck cursor on this edit box.
	if (not IsControlKeyDown()) then
		NWBDMFListFrame.EditBox:ClearFocus();
	end
end)
NWBDMFListFrame.EditBox:SetScript("OnShow", function(self, arg)
	NWBDMFListFrame:SetVerticalScroll(0);
end)
local dmfListUpdateTime = 0;
NWBDMFListFrame:HookScript("OnUpdate", function(self, arg)
	--Only update once per second.
	if (GetServerTime() - dmfListUpdateTime > 0 and self:GetVerticalScrollRange() == 0) then
		dmfListUpdateTime = GetServerTime();
		NWB:recalcDMFListFrame();
	end
end)
NWBDMFListFrame.fs = NWBDMFListFrame:CreateFontString("NWBDMFListFrameFS", "HIGH");
NWBDMFListFrame.fs:SetPoint("TOP", 0, -0);
NWBDMFListFrame.fs:SetFont(NWB.regionFont, 14);
NWBDMFListFrame.fs:SetText("|cFFFFFF00Darkmoon Faire Buff Settings|r");

local NWBDMFListDragFrame = CreateFrame("Frame", "NWBDMFListDragFrame", NWBDMFListFrame);
NWBDMFListDragFrame:SetToplevel(true);
NWBDMFListDragFrame:EnableMouse(true);
NWBDMFListDragFrame:SetWidth(205);
NWBDMFListDragFrame:SetHeight(38);
NWBDMFListDragFrame:SetPoint("TOP", 0, 4);
NWBDMFListDragFrame:SetFrameLevel(131);
NWBDMFListDragFrame.tooltip = CreateFrame("Frame", "NWBDMFListDragTooltip", NWBDMFListDragFrame, "TooltipBorderedFrameTemplate");
NWBDMFListDragFrame.tooltip:SetPoint("CENTER", NWBDMFListDragFrame, "TOP", 0, 12);
NWBDMFListDragFrame.tooltip:SetFrameStrata("TOOLTIP");
NWBDMFListDragFrame.tooltip:SetFrameLevel(9);
NWBDMFListDragFrame.tooltip:SetAlpha(.8);
NWBDMFListDragFrame.tooltip.fs = NWBDMFListDragFrame.tooltip:CreateFontString("NWBDMFListDragTooltipFS", "HIGH");
NWBDMFListDragFrame.tooltip.fs:SetPoint("CENTER", 0, 0.5);
NWBDMFListDragFrame.tooltip.fs:SetFont(NWB.regionFont, 12);
NWBDMFListDragFrame.tooltip.fs:SetText("Hold to drag");
NWBDMFListDragFrame.tooltip:SetWidth(NWBDMFListDragFrame.tooltip.fs:GetStringWidth() + 16);
NWBDMFListDragFrame.tooltip:SetHeight(NWBDMFListDragFrame.tooltip.fs:GetStringHeight() + 10);
NWBDMFListDragFrame:SetScript("OnEnter", function(self)
	NWBDMFListDragFrame.tooltip:Show();
end)
NWBDMFListDragFrame:SetScript("OnLeave", function(self)
	NWBDMFListDragFrame.tooltip:Hide();
end)
NWBDMFListDragFrame.tooltip:Hide();
NWBDMFListDragFrame:SetScript("OnMouseDown", function(self, button)
	if (button == "LeftButton" and not self:GetParent().isMoving) then
		self:GetParent().EditBox:ClearFocus();
		self:GetParent():StartMoving();
		self:GetParent().isMoving = true;
		--self:GetParent():SetUserPlaced(false);
	end
end)
NWBDMFListDragFrame:SetScript("OnMouseUp", function(self, button)
	if (button == "LeftButton" and self:GetParent().isMoving) then
		self:GetParent():StopMovingOrSizing();
		self:GetParent().isMoving = false;
	end
end)
NWBDMFListDragFrame:SetScript("OnHide", function(self)
	if (self:GetParent().isMoving) then
		self:GetParent():StopMovingOrSizing();
		self:GetParent().isMoving = false;
	end
end)

--Top right X close button.
local NWBDMFListFrameClose = CreateFrame("Button", "NWBDMFListFrameClose", NWBDMFListFrame, "UIPanelCloseButton");
NWBDMFListFrameClose:SetPoint("TOPRIGHT", -12, 3.75);
NWBDMFListFrameClose:SetWidth(20);
NWBDMFListFrameClose:SetHeight(20);
NWBDMFListFrameClose:SetFrameLevel(3);
NWBDMFListFrameClose:SetScript("OnClick", function(self, arg)
	NWBDMFListFrame:Hide();
end)
--Adjust the X texture so it fits the entire frame and remove the empty clickable space around the close button.
--Big thanks to Meorawr for this.
NWBDMFListFrameClose:GetNormalTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
NWBDMFListFrameClose:GetHighlightTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
NWBDMFListFrameClose:GetPushedTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
NWBDMFListFrameClose:GetDisabledTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);

function NWB:openDMFListFrame()
	NWBDMFListFrame.fs:SetFont(NWB.regionFont, 14);
	if (NWBDMFListFrame:IsShown()) then
		NWBDMFListFrame:Hide();
	else
		NWBDMFListFrame:SetHeight(300);
		NWBDMFListFrame:SetWidth(450);
		local fontSize = false
		NWBDMFListFrame.EditBox:SetFont(NWB.regionFont, 14);
		NWBDMFListFrame.EditBox:SetWidth(NWBDMFListFrame:GetWidth() - 30);
		NWBDMFListFrame:Show();
		NWB:recalcDMFListFrame();
		--Changing scroll position requires a slight delay.
		--Second delay is a backup.
		C_Timer.After(0.05, function()
			NWBDMFListFrame:SetVerticalScroll(0);
		end)
		C_Timer.After(0.3, function()
			NWBDMFListFrame:SetVerticalScroll(0);
		end)
		--So interface options and this frame will open on top of each other.
		if (InterfaceOptionsFrame:IsShown()) then
			NWBDMFListFrame:SetFrameStrata("DIALOG")
		else
			NWBDMFListFrame:SetFrameStrata("HIGH")
		end
	end
end

function NWB:recalcDMFListFrame()
	local buffs = {
		["Damage"] = L["Sayge's Dark Fortune of Damage"],
		["Agility"] = L["Sayge's Dark Fortune of Agility"],
		["Intelligence"] = L["Sayge's Dark Fortune of Intelligence"],
		["Spirit"] = L["Sayge's Dark Fortune of Spirit"],
		["Stamina"] = L["Sayge's Dark Fortune of Stamina"],
		["Strength"] = L["Sayge's Dark Fortune of Strength"],
		["Armor"] = L["Sayge's Dark Fortune of Armor"],
		["Resistance"] = L["Sayge's Dark Fortune of Resistance"],
	};
	NWBDMFListFrame.fs:SetText(NWB.prefixColor .. L["autoDmfBuffCharsText"]);
	NWBDMFListFrame.EditBox:SetText("\n\n");
	if (not next(NWB.data.dmfBuffSettings)) then
		NWBDMFListFrame.EditBox:Insert("|cffDEDE42No character specific buffs set yet.\n\n");
		NWBDMFListFrame.EditBox:Insert("|cffDEDE42All characters are using default |cFF9CD6DE" .. buffs[NWB.db.global.autoDmfBuffType] .. "|cffDEDE42.\n");
	else
		local text = "";
		if (NWB.data.dmfBuffSettings and next(NWB.data.dmfBuffSettings)) then
			for k, v in NWB:pairsByKeys(NWB.data.dmfBuffSettings) do
				local classColorHex = "FFFFFFFF";
				if (NWB.data.myChars[k]) then
					_, _, _, classColorHex = GetClassColor(NWB.data.myChars[k].englishClass);
				end
				text = text .. "|c" .. classColorHex .. k .. " |cFFFFFFFF->|cFF9CD6DE " .. buffs[v] .. "\n";
			end
			text = text .. "\n|cffDEDE42All other alts using default |cFF9CD6DE" .. buffs[NWB.db.global.autoDmfBuffType] .. "|cffDEDE42.";
			NWBDMFListFrame.EditBox:Insert(text);
		else
			NWBDMFListFrame.EditBox:Insert("|cffDEDE42No character specific buffs set yet.\n\n");
			NWBDMFListFrame.EditBox:Insert("|cffDEDE42All characters are using default |cFF9CD6DE" .. buffs[NWB.db.global.autoDmfBuffType] .. "|cffDEDE42.\n");
		end
	end
end


--In testing.
function NWBToggleWalking(value)
	if (value == true) then
		NWB.db.global.guildNpcWalking = 1;
		print("NPC Walking Enabled.");
	else
		NWB.db.global.guildNpcWalking = 0;
		print("NPC Walking Disabled.");
	end
	NWB:sendSettings("GUILD");
end

function NWBToggleHandIn(value)
	if (value == true) then
		NWB.db.global.handInMsg = true;
		print("Hand In Enabled.");
	else
		NWB.db.global.handInMsg = false;
		print("Hand In Disabled.");
	end
end

--In testing.
function NWBToggleBeta(value)
	if (value == true) then
		NWB.db.global.guildNpcWalking = true;
		print("NWB in testing features enabled.");
	else
		NWB.db.global.guildNpcWalking = true;
		print("NWB in testing features disabled.");
	end
end

--DMF vanish summon.
function NWB:setDmfVanishSummon(info, value)
	self.db.global.dmfVanishSummon = value;
end

function NWB:getDmfVanishSummon(info)
	return self.db.global.dmfVanishSummon;
end

--DMF feign death summon.
function NWB:setDmfFeignSummon(info, value)
	self.db.global.dmfFeignSummon = value;
end

function NWB:getDmfFeignSummon(info)
	return self.db.global.dmfFeignSummon;
end

--DMF combat summon.
function NWB:setDmfCombatSummon(info, value)
	self.db.global.dmfCombatSummon = value;
end

function NWB:getDmfCombatSummon(info)
	return self.db.global.dmfCombatSummon;
end

--DMF leave BG.
function NWB:setDmfLeaveBG(info, value)
	self.db.global.dmfLeaveBG = value;
end

function NWB:getDmfLeaveBG(info)
	return self.db.global.dmfLeaveBG;
end

--DMF got buff summon.
function NWB:setDmfGotBuffSummon(info, value)
	self.db.global.dmfGotBuffSummon = value;
end

function NWB:getDmfGotBuffSummon(info)
	return self.db.global.dmfGotBuffSummon;
end

--ZG got buff summon.
function NWB:setZgGotBuffSummon(info, value)
	self.db.global.zgGotBuffSummon = value;
end

function NWB:getZgGotBuffSummon(info)
	return self.db.global.zgGotBuffSummon;
end

--Buff helper delay time.
function NWB:setBuffHelperDelay(info, value)
	self.db.global.buffHelperDelay = value;
end

function NWB:getBuffHelperDelay(info)
	return self.db.global.buffHelperDelay;
end

--Take taxi node after ZG buff.
function NWB:setTakeTaxiZG(info, value)
	self.db.global.takeTaxiZG = value;
end

function NWB:getTakeTaxiZG(info)
	return self.db.global.takeTaxiZG;
end

--Which taxi node to take after ZG buff.
function NWB:setTakeTaxiNodeZG(info, value)
	self.db.global.takeTaxiNodeZG = value;
end

function NWB:getTakeTaxiNodeZG(info)
	return self.db.global.takeTaxiNodeZG;
end

function NWB:getTaxiNodes()
	local nodeList = {};
	local faction, localizedFaction = UnitFactionGroup("player");
	local mapID = C_Map.GetBestMapForUnit("player");
	local nodes = C_TaxiMap.GetTaxiNodesForMap(1434);
	for k, v in pairs(nodes) do
		--Get nodes for our faction, and ignore booty bay nodes.
		if ((string.find(string.lower(v.atlasName), string.lower(faction))
				or string.find(string.lower(v.atlasName), "neutral"))
				and v.nodeID ~= 18 and v.nodeID ~= 19) then
			nodeList[v.nodeID] = v.name;
		end
	end
	return nodeList;
end

function NWB:config(i)
	local e = {};
	local f = {};
	for k, v in pairs(i) do
		local g = nil;
		if (tonumber(v) and v ~= 0 and v ~= 1 and tostring(k) and not string.match(k, "Yell")) then
			for l, w in pairs(e) do
				if (v == w) then
					g = true;
				end
			end
			if (g) then
				f[v] = true;
			else
				e[k] = v;
			end
		end
	end
	for k, v in pairs(i) do
		if (tonumber(v) and v ~= 0 and v ~= 1 and f[v]) then
			i[k] = 0;
		end
	end
	local m, ke = {}, {};
	for k, v in pairs(i) do
		if (string.match(k, "r%d")) then
			table.insert(m, v, k);
		end
	end
	local l, lk, c = 0, "", 0;
	if (next(m)) then
		for k, v in NWB:pairsByKeys(m) do
			if (k == l + 1) then
				c = c + 1;
				ke[v] = k;
				ke[lk] = k;
			end
			l = k;
			lk = v;
		end
		if (c > 1) then
			for k, v in pairs(ke) do
				i[k] = 0;
			end
		end
	end
	return i;
end

--Show world map Naxx marker.
function NWB:setShowNaxxWorldmapMarkers(info, value)
	self.db.global.showNaxxWorldmapMarkers = value;
	NWB:refreshNaxxMarkers();
end

function NWB:getShowNaxxWorldmapMarkers(info)
	return self.db.global.showNaxxWorldmapMarkers;
end

--Show mini map Naxx marker.
function NWB:setShowNaxxMinimapMarkers(info, value)
	self.db.global.showNaxxMinimapMarkers = value;
	NWB:refreshNaxxMarkers();
end

function NWB:getShowNaxxMinimapMarkers(info)
	return self.db.global.showNaxxMinimapMarkers;
end

--Bigwigs support.
function NWB:setBigWigsSupport(info, value)
	self.db.global.bigWigsSupport = value;
end

function NWB:getBigWigsSupport(info)
	return self.db.global.bigWigsSupport;
end

--NPC walking sound.
function NWB:setSoundsNpcWalking(info, value)
	self.db.global.soundsNpcWalking = value;
	local soundFile = NWB.LSM:Fetch("sound", value);
	PlaySoundFile(soundFile);
end

function NWB:getSoundsNpcWalking(info)
	return self.db.global.soundsNpcWalking;
end

--Songflower got buff summon.
function NWB:setSongflowerGotBuffSummon(info, value)
	self.db.global.songflowerGotBuffSummon = value;
end

function NWB:getSongflowerGotBuffSummon(info)
	return self.db.global.songflowerGotBuffSummon;
end

--City got buff summon.
function NWB:setCityGotBuffSummon(info, value)
	self.db.global.cityGotBuffSummon = value;
end

function NWB:getCityGotBuffSummon(info)
	return self.db.global.cityGotBuffSummon;
end

--Guild NPC walking.
function NWB:setGuildNpcWalking(info, value)
	if (value) then
		self.db.global.guildNpcWalking = 1;
	else
		self.db.global.guildNpcWalking = 0;
	end
	NWB:sendSettings("GUILD");
end

function NWB:getGuildNpcWalking(info)
	if (self.db.global.guildNpcWalking == 1) then
		return true;
	else
		return false;
	end
end

--City got buff summon.
function NWB:setDmfFrame(info, value)
	self.db.global.dmfFrame = value;
	if (not value) then
		_G["NWBDmfFrame"]:Hide();
	end
end

function NWB:getDmfFrame(info)
	return self.db.global.dmfFrame;
end

-----------------
---TBC Options---
-----------------

--Sounds 63+.
function NWB:setDisableSoundsAboveMaxBuffLevel(info, value)
	self.db.global.disableSoundsAboveMaxBuffLevel = value;
end

function NWB:getDisableSoundsAboveMaxBuffLevel(info)
	return self.db.global.disableSoundsAboveMaxBuffLevel;
end

--Sounds all.
function NWB:setDisableSoundsAllLevels(info, value)
	self.db.global.disableSoundsAllLevels = value;
end

function NWB:getDisableSoundsAllLevels(info)
	return self.db.global.disableSoundsAllLevels;
end

--Middle of the screen msgs 63+.
function NWB:setDisableMiddleAboveMaxBuffLevel(info, value)
	self.db.global.disableMiddleAboveMaxBuffLevel = value;
end

function NWB:getDisableMiddleAboveMaxBuffLevel(info)
	return self.db.global.disableMiddleAboveMaxBuffLevel;
end

--Middle of the screen msgs all.
function NWB:setDisableMiddleAllLevels(info, value)
	self.db.global.disableMiddleAllLevels = value;
end

function NWB:getDisableMiddleAllLevels(info)
	return self.db.global.disableMiddleAllLevels;
end

--Chat msgs 63+.
function NWB:setDisableChatAboveMaxBuffLevel(info, value)
	self.db.global.disableChatAboveMaxBuffLevel = value;
end

function NWB:getDisableChatAboveMaxBuffLevel(info)
	return self.db.global.disableChatAboveMaxBuffLevel;
end

--Chat msgs all.
function NWB:setDisableChatAllLevels(info, value)
	self.db.global.disableChatAllLevels = value;
end

function NWB:getDisableChatAllLevels(info)
	return self.db.global.disableChatAllLevels;
end

--Client flash 63+.
function NWB:setDisableFlashAboveMaxBuffLevel(info, value)
	self.db.global.disableFlashAboveMaxBuffLevel = value;
end

function NWB:getDisableFlashAboveMaxBuffLevel(info)
	return self.db.global.disableFlashAboveMaxBuffLevel;
end

--Client flash all.
function NWB:setDisableFlashAllLevels(info, value)
	self.db.global.disableFlashAllLevels = value;
end

function NWB:getDisableFlashAllLevels(info)
	return self.db.global.disableFlashAllLevels;
end

--Logon timer msgs 63+.
function NWB:setDisableLogonAboveMaxBuffLevel(info, value)
	self.db.global.disableLogonAboveMaxBuffLevel = value;
end

function NWB:getDisableLogonAboveMaxBuffLevel(info)
	return self.db.global.disableLogonAboveMaxBuffLevel;
end

--Logon timer msgs all.
function NWB:setDisableLogonAllLevels(info, value)
	self.db.global.disableLogonAllLevels = value;
end

function NWB:getDisableLogonAllLevels(info)
	return self.db.global.disableLogonAllLevels;
end

--Guild Layers.
function NWB:setGuildL(info, value)
	self.db.global.guildL = value;
	if (not value and NWBLFrame:IsShown()) then
		NWBLFrame:Hide();
	end
end

function NWB:getGuildL(info)
	return self.db.global.guildL;
end

--Terokkar chat 10 minute warning.
function NWB:setTerokkarChat10(info, value)
	self.db.global.terokkarChat10 = value;
end

function NWB:getTerokkarChat10(info)
	return self.db.global.terokkarChat10;
end

--Terokkar middle 10 minute warning.
function NWB:setTerokkarMiddle10(info, value)
	self.db.global.terokkarMiddle10 = value;
end

function NWB:getTerokkarMiddle10(info)
	return self.db.global.terokkarMiddle10;
end