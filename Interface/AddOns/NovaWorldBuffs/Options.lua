--------------------
--Nova World Buffs--
--------------------
--Classic WoW world buff timers and pre warnings.
--Novaspark-Arugal OCE (classic).
--https://www.curseforge.com/members/venomisto/projects

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
			name = "|cFFFFFF00" .. L["mainTextDesc"],
			fontSize = "medium",
			order = 3,
		},
		showBuffs = {
			type = "execute",
			name = L["showBuffsTitle"],
			desc = L["showBuffsDesc"],
			func = "openBuffListFrame",
			order = 4,
			width = 1.7,
		},
		generalHeader = {
			type = "header",
			name = L["generalHeaderDesc"],
			order = 5,
		},
		showWorldMapMarkers = {
			type = "toggle",
			name = L["showWorldMapMarkersTitle"],
			desc = L["showWorldMapMarkersDesc"],
			order = 6,
			get = "getShowWorldMapMarkers",
			set = "setShowWorldMapMarkers",
		},
		receiveGuildDataOnly  = {
			type = "toggle",
			name = L["receiveGuildDataOnlyTitle"],
			desc = L["receiveGuildDataOnlyDesc"],
			order = 7,
			get = "getReceiveGuildDataOnly",
			set = "setReceiveGuildDataOnly",
		},
		chatColor = {
			type = "color",
			name = L["chatColorTitle"],
			desc = L["chatColorDesc"],
			order = 8,
			get = "getChatColor",
			set = "setChatColor",
			hasAlpha = false,
		},
		mmColor = {
			type = "color",
			name = L["mmColorTitle"],
			desc = L["mmColorDesc"],
			order = 9,
			get = "getMmColor",
			set = "setMmColor",
			hasAlpha = false,
		},
		middleColor = {
			type = "color",
			name = L["middleColorTitle"],
			desc = L["middleColorDesc"],
			order = 10,
			get = "getMiddleColor",
			set = "setMiddleColor",
			hasAlpha = false,
		},
		resetColors = {
			type = "execute",
			name = L["resetColorsTitle"],
			desc = L["resetColorsDesc"],
			func = "resetColors",
			order = 11,
		},
		showTimeStamp = {
			type = "toggle",
			name = L["showTimeStampTitle"],
			desc = L["showTimeStampDesc"],
			order = 12,
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
			order = 13,
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
			order = 14,
			get = "getTimeStampZone",
			set = "setTimeStampZone",
		},
		colorizePrefixLinks = {
			type = "toggle",
			name = L["colorizePrefixLinksTitle"],
			desc = L["colorizePrefixLinksDesc"],
			order = 15,
			get = "getColorizePrefixLinks",
			set = "setColorizePrefixLinks",
		},
		showAllAlts = {
			type = "toggle",
			name = L["showAllAltsTitle"],
			desc = L["showAllAltsDesc"],
			order = 16,
			get = "getShowAllAlts",
			set = "setShowAllAlts",
		},
		minimapButton = {
			type = "toggle",
			name = L["minimapButtonTitle"],
			desc = L["minimapButtonDesc"],
			order = 20,
			get = "getMinimapButton",
			set = "setMinimapButton",
		},
		showBuffStats = {
			type = "toggle",
			name = L["showBuffStatsTitle"],
			desc = L["showBuffStatsDesc"],
			order = 21,
			get = "getShowBuffStats",
			set = "setShowBuffStats",
		},
		minimapLayerHover = {
			type = "toggle",
			name = L["minimapLayerHoverTitle"],
			desc = L["minimapLayerHoverDesc"],
			order = 22,
			get = "getMinimapLayerHover",
			set = "setMinimapLayerHover",
		},
		logonHeader = {
			type = "header",
			name = L["logonHeaderDesc"],
			order = 23,
		},
		logonPrint = {
			type = "toggle",
			name = L["logonPrintTitle"],
			desc = L["logonPrintDesc"],
			order = 24,
			get = "getLogonPrint",
			set = "setLogonPrint",
		},
		logonRend = {
			type = "toggle",
			name = L["logonRendTitle"],
			desc = L["logonRendDesc"],
			order = 25,
			get = "getLogonRend",
			set = "setLogonRend",
		},
		logonOny = {
			type = "toggle",
			name = L["logonOnyTitle"],
			desc = L["logonOnyDesc"],
			order = 26,
			get = "getLogonOny",
			set = "setLogonOny",
		},
		logonNef = {
			type = "toggle",
			name = L["logonNefTitle"],
			desc = L["logonNefDesc"],
			order = 27,
			get = "getLogonNef",
			set = "setLogonNef",
		},
		logonDmfSpawn = {
			type = "toggle",
			name = L["logonDmfSpawnTitle"],
			desc = L["logonDmfSpawnDesc"],
			order = 28,
			get = "getLogonDmfSpawn",
			set = "setLogonDmfSpawn",
		},
		logonDmfBuffCooldown = {
			type = "toggle",
			name = L["logonDmfBuffCooldownTitle"],
			desc = L["logonDmfBuffCooldownDesc"],
			order = 29,
			get = "getLogonDmfBuffCooldown",
			set = "setLogonDmfBuffCooldown",
		},
		chatWarningHeader = {
			type = "header",
			name = L["chatWarningHeaderDesc"],
			order = 30,
		},
		chat30 = {
			type = "toggle",
			name = L["chat30Title"],
			desc = L["chat30Desc"],
			order = 31,
			get = "getChat30",
			set = "setChat30",
		},
		chat15 = {
			type = "toggle",
			name = L["chat15Title"],
			desc = L["chat15Desc"],
			order = 32,
			get = "getChat15",
			set = "setChat15",
		},
		chat10 = {
			type = "toggle",
			name = L["chat10Title"],
			desc = L["chat10Desc"],
			order = 33,
			get = "getChat10",
			set = "setChat10",
		},
		chat5 = {
			type = "toggle",
			name = L["chat5Title"],
			desc = L["chat5Desc"],
			order = 34,
			get = "getChat5",
			set = "setChat5",
		},
		chat1 = {
			type = "toggle",
			name = L["chat1Title"],
			desc = L["chat1Desc"],
			order = 35,
			get = "getChat1",
			set = "setChat1",
		},
		chatReset = {
			type = "toggle",
			name = L["chatResetTitle"],
			desc = L["chatResetDesc"],
			order = 36,
			get = "getChat0",
			set = "setChat0",
		},
		chatZan = {
			type = "toggle",
			name = L["chatZanTitle"],
			desc = L["chatZanDesc"],
			order = 37,
			get = "getChatZan",
			set = "setChatZan",
		},
		middleWarningHeader = {
			type = "header",
			name = L["middleWarningHeaderDesc"],
			order = 40,
		},
		middle30 = {
			type = "toggle",
			name = L["middle30Title"],
			desc = L["middle30Desc"],
			order = 41,
			get = "getMiddle30",
			set = "setMiddle30",
		},
		middle15 = {
			type = "toggle",
			name = L["middle15Title"],
			desc = L["middle15Desc"],
			order = 42,
			get = "getMiddle15",
			set = "setMiddle15",
		},
		middle10 = {
			type = "toggle",
			name = L["middle10Title"],
			desc = L["middle10Desc"],
			order = 43,
			get = "getMiddle10",
			set = "setMiddle10",
		},
		middle5 = {
			type = "toggle",
			name = L["middle5Title"],
			desc = L["middle5Desc"],
			order = 44,
			get = "getMiddle5",
			set = "setMiddle5",
		},
		middle1 = {
			type = "toggle",
			name = L["middle1Title"],
			desc = L["middle1Desc"],
			order = 45,
			get = "getMiddle1",
			set = "setMiddle1",
		},
		middleReset = {
			type = "toggle",
			name = L["middleResetTitle"],
			desc = L["middleResetDesc"],
			order = 46,
			get = "getMiddle0",
			set = "setMiddle0",
		},
		middleBuffWarning = {
			type = "toggle",
			name = L["middleBuffWarningTitle"],
			desc = L["middleBuffWarningDesc"],
			order = 47,
			get = "getMiddleBuffWarning",
			set = "setMiddleBuffWarning",
		},
		middleHideCombat = {
			type = "toggle",
			name = L["middleHideCombatTitle"],
			desc = L["middleHideCombatDesc"],
			order = 48,
			get = "getMiddleHideCombat",
			set = "setMiddleHideCombat",
		},
		middleHideRaid = {
			type = "toggle",
			name = L["middleHideRaidTitle"],
			desc = L["middleHideRaidDesc"],
			order = 49,
			get = "getMiddleHideRaid",
			set = "setMiddleHideRaid",
		},
		middleHideBattlegrounds = {
			type = "toggle",
			name = L["middleHideBattlegroundsTitle"],
			desc = L["middleHideBattlegroundsDesc"],
			order = 50,
			get = "getMiddleHideBattlegrounds",
			set = "setMiddleHideBattlegrounds",
		},
		guildWarningHeader = {
			type = "header",
			name = L["guildWarningHeaderDesc"],
			order = 52,
		},
		guild10 = {
			type = "toggle",
			name = L["guild10Title"],
			desc = L["guild10Desc"],
			order = 53,
			get = "getGuild10",
			set = "setGuild10",
		},
		guild1 = {
			type = "toggle",
			name = L["guild1Title"],
			desc = L["guild1Desc"],
			order = 55,
			get = "getGuild1",
			set = "setGuild1",
		},
		guildNpcDialogue = {
			type = "toggle",
			name = L["guildNpcDialogueTitle"],
			desc = L["guildNpcDialogueDesc"],
			order = 57,
			get = "getGuildNpcDialogue",
			set = "setGuildNpcDialogue",
		},
		guildBuffDropped = {
			type = "toggle",
			name = L["guildBuffDroppedTitle"],
			desc = L["guildBuffDroppedDesc"],
			order = 58,
			get = "getGuildBuffDropped",
			set = "setGuildBuffDropped",
		},
		guildZanDialogue = {
			type = "toggle",
			name = L["guildZanDialogueTitle"],
			desc = L["guildZanDialogueDesc"],
			order = 59,
			get = "getGuildZanDialogue",
			set = "setGuildZanDialogue",
		},
		guildNpcKilled = {
			type = "toggle",
			name = L["guildNpcKilledTitle"],
			desc = L["guildNpcKilledDesc"],
			order = 60,
			get = "getGuildNpcKilled",
			set = "setGuildNpcKilled",
		},
		guildCommand = {
			type = "toggle",
			name = L["guildCommandTitle"],
			desc = L["guildCommandDesc"],
			order = 61,
			get = "getGuildCommand",
			set = "setGuildCommand",
		},
		disableAllGuildMsgs = {
			type = "toggle",
			name = L["disableAllGuildMsgsTitle"],
			desc = L["disableAllGuildMsgsDesc"],
			order = 62,
			get = "getDisableAllGuildMsgs",
			set = "setDisableAllGuildMsgs",
		},
		songflowersHeader = {
			type = "header",
			name = L["songflowersHeaderDesc"],
			order = 70,
		},
		guildSongflower = {
			type = "toggle",
			name = L["guildSongflowerTitle"],
			desc = L["guildSongflowerDesc"],
			order = 71,
			get = "getGuildSongflower",
			set = "setGuildSongflower",
		},
		mySongflowerOnly = {
			type = "toggle",
			name = L["mySongflowerOnlyTitle"],
			desc = L["mySongflowerOnlyDesc"],
			order = 72,
			get = "getMySongflowerOnly",
			set = "setMySongflowerOnly",
		},
		syncFlowersAll = {
			type = "toggle",
			name = L["syncFlowersAllTitle"],
			desc = L["syncFlowersAllDesc"],
			order = 73,
			get = "getSyncFlowersAll",
			set = "setSyncFlowersAll",
		},
		showNewFlower = {
			type = "toggle",
			name = L["showNewFlowerTitle"],
			desc = L["showNewFlowerDesc"],
			order = 74,
			get = "getShowNewFlower",
			set = "setShowNewFlower",
		},
		showSongflowerWorldmapMarkers = {
			type = "toggle",
			name = L["showSongflowerWorldmapMarkersTitle"],
			desc = L["showSongflowerWorldmapMarkersDesc"],
			order = 75,
			get = "getShowSongflowerWorldmapMarkers",
			set = "setShowSongflowerWorldmapMarkers",
		},
		showSongflowerMinimapMarkers = {
			type = "toggle",
			name = L["showSongflowerMinimapMarkersTitle"],
			desc = L["showSongflowerMinimapMarkersDesc"],
			order = 76,
			get = "getShowSongflowerMinimapMarkers",
			set = "setShowSongflowerMinimapMarkers",
		},
		showTuberWorldmapMarkers = {
			type = "toggle",
			name = L["showTuberWorldmapMarkersTitle"],
			desc = L["showTuberWorldmapMarkersDesc"],
			order = 77,
			get = "getShowTuberWorldmapMarkers",
			set = "setShowTuberWorldmapMarkers",
		},
		showTuberMinimapMarkers = {
			type = "toggle",
			name = L["showTuberMinimapMarkersTitle"],
			desc = L["showTuberMinimapMarkersDesc"],
			order = 78,
			get = "getShowTuberMinimapMarkers",
			set = "setShowTuberMinimapMarkers",
		},
		showDragonWorldmapMarkers = {
			type = "toggle",
			name = L["showDragonWorldmapMarkersTitle"],
			desc = L["showDragonWorldmapMarkersDesc"],
			order = 79,
			get = "getShowDragonWorldmapMarkers",
			set = "setShowDragonWorldmapMarkers",
		},
		showDragonMinimapMarkers = {
			type = "toggle",
			name = L["showDragonMinimapMarkersTitle"],
			desc = L["showDragonMinimapMarkersDesc"],
			order = 80
			,
			get = "getShowDragonMinimapMarkers",
			set = "setShowDragonMinimapMarkers",
		},
		showExpiredTimers = {
			type = "toggle",
			name = L["showExpiredTimersTitle"],
			desc = L["showExpiredTimersDesc"],
			order = 81,
			get = "getShowExpiredTimers",
			set = "setShowExpiredTimers",
		},
		expiredTimersDuration = {
			type = "range",
			name = L["expiredTimersDurationTitle"],
			desc = L["expiredTimersDurationDesc"],
			order = 82,
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
			name = L["dmfHeaderDesc"],
			order = 90,
		},
		dmfText = {
			type = "description",
			name = "|CffDEDE42" .. L["dmfTextDesc"],
			fontSize = "medium",
			order = 91,
		},
		showDmfWb = {
			type = "toggle",
			name = L["showDmfWbTitle"],
			desc = L["showDmfWbDesc"],
			order = 92,
			get = "getShowDmfWb",
			set = "setShowDmfWb",
		},
		showDmfBuffWb = {
			type = "toggle",
			name = L["showDmfBuffWbTitle"],
			desc = L["showDmfBuffWbDesc"],
			order = 93,
			get = "getShowDmfBuffWb",
			set = "setShowDmfBuffWb",
		},
		showDmfMap = {
			type = "toggle",
			name = L["showDmfMapTitle"],
			desc = L["showDmfMapDesc"],
			order = 95,
			get = "getShowDmfMap",
			set = "setShowDmfMap",
		},
		guildChatFilterHeader = {
			type = "header",
			name = L["guildChatFilterHeaderDesc"],
			order = 100,
		},
		guildChatFilterText = {
			type = "description",
			name = "|CffDEDE42".. L["guildChatFilterTextDesc"],
			fontSize = "medium",
			order = 101,
		},
		filterYells = {
			type = "toggle",
			name = L["filterYellsTitle"],
			desc = L["filterYellsDesc"],
			order = 102,
			get = "getFilterYells",
			set = "setFilterYells",
		},
		filterDrops = {
			type = "toggle",
			name = L["filterDropsTitle"],
			desc = L["filterDropsDesc"],
			order = 103,
			get = "getFilterDrops",
			set = "setFilterDrops",
		},
		filterTimers = {
			type = "toggle",
			name = L["filterTimersTitle"],
			desc = L["filterTimersDesc"],
			order = 104,
			get = "getFilterTimers",
			set = "setFilterTimers",
		},
		filterCommand = {
			type = "toggle",
			name = L["filterCommandTitle"],
			desc = L["filterCommandDesc"],
			order = 105,
			get = "getFilterCommand",
			set = "setFilterCommand",
		},
		filterCommandResponse = {
			type = "toggle",
			name = L["filterCommandResponseTitle"],
			desc = L["filterCommandResponseDesc"],
			order = 106,
			get = "getFilterCommandResponse",
			set = "setFilterCommandResponse",
		},
		filterSongflowers = {
			type = "toggle",
			name = L["filterSongflowersTitle"],
			desc = L["filterSongflowersDesc"],
			order = 107,
			get = "getFilterSongflowers",
			set = "setFilterSongflowers",
		},
		filterNpcKilled = {
			type = "toggle",
			name = L["filterNpcKilledTitle"],
			desc = L["filterNpcKilledDesc"],
			order = 108,
			get = "getFilterNpcKilled",
			set = "setFilterNpcKilled",
		},
		soundsHeader = {
			type = "header",
			name = L["soundsHeaderDesc"],
			order = 110,
		},
		soundsText = {
			type = "description",
			name = "|CffDEDE42" .. L["soundsTextDesc"],
			fontSize = "medium",
			order = 111,
		},
		disableAllSounds = {
			type = "toggle",
			name = L["disableAllSoundsTitle"],
			desc = L["disableAllSoundsDesc"],
			order = 112,
			get = "getDisableAllSounds",
			set = "setDisableAllSounds",
		},
		extraSoundOptions = {
			type = "toggle",
			name = L["extraSoundOptionsTitle"],
			desc = L["extraSoundOptionsDesc"],
			order = 113,
			get = "getExtraSoundOptions",
			set = "setExtraSoundOptions",
			--width = "double",
		},
		soundOnlyInCity = {
			type = "toggle",
			name = L["soundOnlyInCityTitle"],
			desc = L["soundOnlyInCityDesc"],
			order = 114,
			get = "getSoundOnlyInCity",
			set = "setSoundOnlyInCity",
		},
		soundsDisableInInstances = {
			type = "toggle",
			name = L["soundsDisableInInstancesTitle"],
			desc = L["soundsDisableInInstancesDesc"],
			order = 115,
			get = "getSoundsDisableInInstances",
			set = "setSoundsDisableInInstances",
		},
		soundsDisableInBattlegrounds = {
			type = "toggle",
			name = L["soundsDisableInBattlegroundsTitle"],
			desc = L["soundsDisableInBattlegroundsDesc"],
			order = 116,
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
			order = 117,
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
			order = 118,
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
			order = 120,
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
			order = 121,
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
			order = 122,
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
			order = 123,
			get = "getSoundsZanDrop",
			set = "setSoundsZanDrop",
		},
		flashHeader = {
			type = "header",
			name = L["flashHeaderDesc"],
			order = 130,
		},
		flashOneMin = {
			type = "toggle",
			name = L["flashOneMinTitle"],
			desc = L["flashOneMinDesc"],
			order = 131,
			get = "getFlashOneMin",
			set = "setFlashOneMin",
		},
		flashFirstYell = {
			type = "toggle",
			name = L["flashFirstYellTitle"],
			desc = L["flashFirstYellDesc"],
			order = 132,
			get = "getFlashFirstYell",
			set = "setFlashFirstYell",
		},
		flashFirstYellZan = {
			type = "toggle",
			name = L["flashFirstYellZanTitle"],
			desc = L["flashFirstYellZanDesc"],
			order = 133,
			get = "getFlashFirstYellZan",
			set = "setFlashFirstYellZan",
		},
		dispelsHeader = {
			type = "header",
			name = L["dispelsHeaderDesc"],
			order = 140,
		},
		dispelsMine = {
			type = "toggle",
			name = L["dispelsMineTitle"],
			desc = L["dispelsMineDesc"],
			order = 141,
			get = "getDispelsMine",
			set = "setDispelsMine",
		},
		dispelsMineWBOnly = {
			type = "toggle",
			name = L["dispelsMineWBOnlyTitle"],
			desc = L["dispelsMineWBOnlyDesc"],
			order = 142,
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
			order = 143,
			get = "getSoundsDispelsMine",
			set = "setSoundsDispelsMine",
		},
		dispelsAll = {
			type = "toggle",
			name = L["dispelsAllTitle"],
			desc = L["dispelsAllDesc"],
			order = 144,
			get = "getDispelsAll",
			set = "setDispelsAll",
		},
		dispelsAllWBOnly = {
			type = "toggle",
			name = L["dispelsAllWBOnlyTitle"],
			desc = L["dispelsAllWBOnlyDesc"],
			order = 145,
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
			order = 146,
			get = "getSoundsDispelsAll",
			set = "setSoundsDispelsAll",
		},
		autoBuffsHeader = {
			type = "header",
			name = L["autoBuffsHeaderDesc"],
			order = 160,
		},
		autoDmfBuff = {
			type = "toggle",
			name = L["autoDmfBuffTitle"],
			desc = L["autoDmfBuffDesc"],
			order = 164,
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
			order = 165,
			width = "double",
			--width = 1.6,
			get = "getAutoDmfBuffType",
			set = "setAutoDmfBuffType",
		},
		autoDireMaulBuff = {
			type = "toggle",
			name = L["autoDireMaulBuffTitle"],
			desc = L["autoDireMaulBuffDesc"],
			order = 166,
			get = "getAutoDireMaulBuff",
			set = "setAutoDireMaulBuff",
		},
		autoBwlPortal = {
			type = "toggle",
			name = L["autoBwlPortalTitle"],
			desc = L["autoBwlPortalDesc"],
			order = 167,
			get = "getAutoBwlPortal",
			set = "setAutoBwlPortal",
		},
	},
};

function NWB:loadSpecificOptions()
	if (NWB.faction == "Alliance") then
		NWB.options.args["allianceEnableRend"] = {
			type = "toggle",
			name = L["allianceEnableRendTitle"],
			desc = L["allianceEnableRendDesc"],
			order = 17,
			get = "getAllianceEnableRend",
			set = "setAllianceEnableRend",
		};
	end
	if (NWB.isLayered) then
		NWB.options.args["minimapLayerFrame"] = {
			type = "toggle",
			name = L["minimapLayerFrameTitle"],
			desc = L["minimapLayerFrameDesc"],
			order = 18,
			get = "getMinimapLayerFrame",
			set = "setMinimapLayerFrame",
		};
		NWB.options.args["minimapLayerFrameReset"] = {
			type = "execute",
			name = L["minimapLayerFrameResetTitle"],
			desc = L["minimapLayerFrameResetDesc"],
			func = "resetMinimapLayerFrame",
			order = 19,
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
		rendRespawnTime = 10800,
		rendBuffTime = 3600,
		onyRespawnTime = 21600,
		onyBuffTime = 7200,
		nefRespawnTime = 28800,
		nefBuffTime = 7200,
		zanRespawnTime = 28800,
		zanBuffTime = 7200,
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
		songflowerBuffTime = 3600,
		dmfBuffTime = 7200,
		dmfBuffCooldown = 18000,
		moxieBuffTime = 7200,
		ferocityBuffTime = 7200,
		savvyBuffTime = 7200,
		colorizePrefixLinks = false,
		flaskPowerBuffTime = 7200,
		flaskTitansBuffTime = 7200,
		flaskWisdomBuffTime = 7200,
		flaskResistanceBuffTime = 7200,
		resistFireBuffTime = 3600,
		festivalFortitudeBuffTime = 3600,
		festivalFuryBuffTime = 3600,
		ribbonDanceBuffTime = 3600,
		silithystBuffTime = 3600,
		printRend = true,
		printOny = true,
		printNef = true,
		printZan = true,
		iceBuffTime = 1800, --Debug.
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
		blackfathomBuffTime = 3600,
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
		showExpiredTimers = true,
		expiredTimersDuration = 5,
		minimapIcon = {["minimapPos"] = 160, ["hide"] = false},
		minimapButton = true,
		flashOneMin = true,
		flashFirstYell = true,
		flashFirstYellZan = true,
		dispelsMine = true,
		dispelsMineWBOnly = true,
		dispelsAll = false,
		dispelsAllWBOnly = false,
		soundsDispelsMine = "NWB - Dink",
		soundsDispelsAll = "None",
		autoDmfBuff = false,
		autoDmfBuffType = "Damage",
		autoDireMaulBuff = true,
		autoBwlPortal = true,
		showBuffStats = false,
		minimapLayerHover = false,
		timerLogShowRend = true,
		timerLogShowOny = true,
		timerLogShowNef = true,
		timerLogMergeLayers = true,
		
		resetLayers4 = true, --Reset layers one time (sometimes needed when upgrading from old version.
		resetSongflowers = true, --Reset songflowers one time.
		experimental = true, --Enable features being tested on occasion.
		resetLayerMaps = true,
		convertSettings = true,
		wipeSingleLayer = true,
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
	if (not self.db.global[NWB.realm][NWB.faction].layers) then
			self.db.global[NWB.realm][NWB.faction].layers = {};
	end
	if (not self.db.global[NWB.realm][NWB.faction].layersDisabled) then
			self.db.global[NWB.realm][NWB.faction].layersDisabled = {};
	end
	if (not self.db.global[NWB.realm][NWB.faction].timerLog) then
			self.db.global[NWB.realm][NWB.faction].timerLog = {};
	end
	local localizedClass, englishClass = UnitClass("player");
	self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].localizedClass = localizedClass;
	self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].englishClass = englishClass;
	self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].level = UnitLevel("player");
	self.db.global[NWB.realm][NWB.faction].myChars[UnitName("player")].race = UnitRace("player");
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
	MinimapLayerFrame:SetPoint("BOTTOM", Minimap, 0, -21);
end
--Colorize chat prefix in all chat channels.
function NWB:setColorizePrefixLinks(info, value)
	self.db.global.colorizePrefixLinks = value;
end

function NWB:getColorizePrefixLinks(info)
	return self.db.global.colorizePrefixLinks;
end

--Show all alts in the buffs window.
function NWB:setShowAllAlts(info, value)
	self.db.global.showAllAlts = value;
end

function NWB:getShowAllAlts(info)
	return self.db.global.showAllAlts;
end

--Flash minimized.
function NWB:setFlashMinimized(info, value)
	self.db.global.flashMinimized = value;
end

function NWB:getFlashMinimized(info)
	return self.db.global.flashMinimized;
end

--Flash minimized.
function NWB:setFlashOneMin(info, value)
	self.db.global.flashOneMin = value;
end

function NWB:getFlashOneMin(info)
	return self.db.global.flashOneMin;
end

--Flash minimized.
function NWB:setFlashFirstYell(info, value)
	self.db.global.flashFirstYell = value;
end

function NWB:getFlashFirstYell(info)
	return self.db.global.flashFirstYell;
end

--Flash minimized.
function NWB:setFlashFirstYellZan(info, value)
	self.db.global.flashFirstYellZan = value;
end

function NWB:getFlashFirstYellZan(info)
	return self.db.global.flashFirstYellZan;
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

--Show buff stats.
function NWB:setShowBuffStats(info, value)
	self.db.global.showBuffStats = value;
	NWB:recalcBuffListFrame();
end

function NWB:getShowBuffStats(info)
	return self.db.global.showBuffStats;
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
	--Random snipets from youtube.
	["NWB - Zelda"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\Zelda.ogg",
	["NWB - FF7"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\FF7.ogg",
	["NWB - Bell"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\Bell.ogg",
	["NWB - Alarm"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\Alarm.ogg",
	["NWB - Alien"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\Alien.ogg",
	["NWB - Clock"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\Clock.ogg",
	["NWB - Electronic"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\Electronic.ogg",
	["NWB - Pop"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\Pop.ogg",
	["NWB - Dink"] = "Interface\\AddOns\\NovaWorldBuffs\\Media\\Dink.ogg",
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
	self.db.global.autoDmfBuffType = value;
end

function NWB:getAutoDmfBuffType(info)
	return self.db.global.autoDmfBuffType;
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