--------------------
--Nova World Buffs--
--------------------
--Classic WoW world buff timers and pre warnings.
--Novaspark-Arugal OCE (classic).
--https://www.curseforge.com/members/venomisto/projects

local L = LibStub("AceLocale-3.0"):GetLocale("NovaWorldBuffs");

NWB.options = {
	name = "|TInterface\\AddOns\\NovaWorldBuffs\\Media\\logo32:24:24:0:5|t NovaWorldBuffs v" .. GetAddOnMetadata("NovaWorldBuffs", "Version"),
	handler = NWB,
	type = 'group',
	args = {
		desc = {
			type = "description",
			name = L["|CffDEDE42World Buffs Config (You can type /wb config to open this).\n"]
					.. L["Type /wb to display timers to yourself.\n"]
					.. L["Type /wb <channel> to display timers to the specified channel.\n"]
					.. L["Scroll down for more options."],
			fontSize = "medium",
			order = 1,
		},
		showBuffs = {
			type = "execute",
			name = L["Click To Show Your Current World Buffs"],
			desc = L["Show your current world buffs for all your characters, this can also be opened by typing /buffs or clicking "]
					.. L["on the [WorldBuffs] prefix in chat."],
			func = "openBuffListFrame",
			order = 2,
			width = 1.7,
		},
		colorHeader = {
			type = "header",
			name = L["General Options"],
			order = 3,
		},
		showWorldMapMarkers = {
			type = "toggle",
			name = L["City Map Timers"],
			desc = L["Show timer icons on the Orgrimmar/Stormwind world map?"],
			order = 4,
			get = "getShowWorldMapMarkers",
			set = "setShowWorldMapMarkers",
		},
		disableAllGuildMsgs = {
			type = "toggle",
			name = L["Disable Guild Msgs"],
			desc = L["Disable all guild messages including timers and when buffs drop? Note: You can disable all msgs 1 by 1 below and "]
					.. L["just leave certain things enabled such as the !wb command to help out your guild if you rather."],
			order = 5,
			get = "getDisableAllGuildMsgs",
			set = "setDisableAllGuildMsgs",
		},
		receiveGuildDataOnly  = {
			type = "toggle",
			name = L["Guild Data Only"],
			desc = L["This will make it so you don't get timer data from anyone outside the guild. You should only enable this "]
					.. L["if you think someone is spoofing wrong timer data on purpose because it will lower the accuracy of your timers "]
					.. L["with less people to pull data from. It will make it especially hard to get songflower timers becaus "]
					.. L["they are so short."],
			order = 6,
			get = "getReceiveGuildDataOnly",
			set = "setReceiveGuildDataOnly",
		},
		chatColor = {
			type = "color",
			name = L["Chat Msg Color"],
			desc = L["What color should the timer msgs in chat be?"],
			order = 7,
			get = "getChatColor",
			set = "setChatColor",
			hasAlpha = false,
		},
		middleColor = {
			type = "color",
			name = L["Middle Screen Color"],
			desc = L["What color should the raid warning style msgs in the middle of the screen be?"],
			order = 8,
			get = "getMiddleColor",
			set = "setMiddleColor",
			hasAlpha = false,
		},
		resetColors = {
			type = "execute",
			name = L["Reset Colors"],
			desc = L["Reset colors back to default."],
			func = "resetColors",
			order = 9,
		},
		showTimeStamp = {
			type = "toggle",
			name = L["Show Time Stamp"],
			desc = L["Show a time stamp (1:23pm) beside the timer msg?"],
			order = 10,
			get = "getShowTimeStamp",
			set = "setShowTimeStamp",
		},
		timeStampFormat = {
			type = "select",
			name = L["Time Stamp Format"],
			desc = L["Set which timestamp format to use, 12 hour (1:23pm) or 24 hour (13:23)."],
			values = {
				[12] = L["12 hour"],
				[24] = L["24 hour"],
			},
			sorting = {
				[1] = 12,
				[2] = 24,
			},
			order = 11,
			get = "getTimeStampFormat",
			set = "setTimeStampFormat",
		},
		timeStampZone = {
			type = "select",
			name = L["Local Time / Server Time"],
			desc = L["Use local time or server time for timestamps?"],
			values = {
				["local"] = L["Local Time"],
				["server"] = L["Server Time"],
			},
			sorting = {
				[1] = "local",
				[2] = "server",
			},
			order = 12,
			get = "getTimeStampZone",
			set = "setTimeStampZone",
		},
		guildCommand = {
			type = "toggle",
			name = L["Guild Commands"],
			desc = L["Reply with timer info to !wb and !dmf commands in guild chat? You should probably leave this enabled to help your guild, "]
					.. L["if you really want to disable all guild msgs and leave only this command then untick everything else in the "]
					.. L["guild sectionand don't tick the Disable All Guild Msgs at the top."],
			order = 14,
			get = "getGuildCommand",
			set = "setGuildCommand",
		},
		colorizePrefixLinks = {
			type = "toggle",
			name = L["Colored Prefix Link"],
			desc = L["Colorize the prefix [WorldBuffs] in all chat channels? This is the prefix in chat you can click to show "]
					.. L["all your characters current world buffs."],
			order = 15,
			get = "getColorizePrefixLinks",
			set = "setColorizePrefixLinks",
		},
		showAllAlts = {
			type = "toggle",
			name = L["Show All Alts"],
			desc = L["Show all alts in the /buffs window even if they don't have an active buff?"],
			order = 16,
			get = "getShowAllAlts",
			set = "setShowAllAlts",
		},
		minimapButton = {
			type = "toggle",
			name = L["Show Minimap Button"],
			desc = L["Show the NWB button the minimap?"],
			order = 20,
			get = "getMinimapButton",
			set = "setMinimapButton",
		},
		logonHeader = {
			type = "header",
			name = L["Logon Messages"],
			order = 23,
		},
		logonPrint = {
			type = "toggle",
			name = L["Logon Timers"],
			desc = L["Show timers in the chat window when you log on, you can disable all logon msgs with this setting."],
			order = 24,
			get = "getLogonPrint",
			set = "setLogonPrint",
		},
		logonRend = {
			type = "toggle",
			name = L["Rend"],
			desc = L["Show Rend timer in the chat window when you log on."],
			order = 25,
			get = "getLogonRend",
			set = "setLogonRend",
		},
		logonOny = {
			type = "toggle",
			name = L["Onyxia"],
			desc = L["Show Onyxia timer in the chat window when you log on."],
			order = 26,
			get = "getLogonOny",
			set = "setLogonOny",
		},
		logonNef = {
			type = "toggle",
			name = L["Nefarian"],
			desc = L["Show Nefarian timer in the chat window when you log on."],
			order = 27,
			get = "getLogonNef",
			set = "setLogonNef",
		},
		logonDmfSpawn = {
			type = "toggle",
			name = L["DMF Spawn"],
			desc = L["Show Darkmoon Faire spawn time, this will only show when there is less than 6 hours left until spawn or despawn."],
			order = 8,
			get = "getLogonDmfSpawn",
			set = "setLogonDmfSpawn",
		},
		logonDmfBuffCooldown = {
			type = "toggle",
			name = L["DMF Buff Coooldown"],
			desc = L["Show Darkmoon Faire buff 5 hour cooldown, this will only show when you have an ative cooldown and when DMF is up."],
			order = 29,
			get = "getLogonDmfBuffCooldown",
			set = "setLogonDmfBuffCooldown",
		},
		chatWarningHeader = {
			type = "header",
			name = L["Chat Window Timer Warnings"],
			order = 30,
		},
		chat30 = {
			type = "toggle",
			name = L["30 Minutes"],
			desc = L["Print a msg in chat when 30 minutes left."],
			order = 31,
			get = "getChat30",
			set = "setChat30",
		},
		chat15 = {
			type = "toggle",
			name = L["15 Minutes"],
			desc = L["Print a msg in chat when 15 minutes left."],
			order = 32,
			get = "getChat15",
			set = "setChat15",
		},
		chat10 = {
			type = "toggle",
			name = L["10 Minutes"],
			desc = L["Print a msg in chat when 10 minutes left."],
			order = 33,
			get = "getChat10",
			set = "setChat10",
		},
		chat5 = {
			type = "toggle",
			name = L["5 Minutes"],
			desc = L["Print a msg in chat when 5 minutes left."],
			order = 34,
			get = "getChat5",
			set = "setChat5",
		},
		chat1 = {
			type = "toggle",
			name = L["1 Minute"],
			desc = L["Print a msg in chat when 1 minute left."],
			order = 35,
			get = "getChat1",
			set = "setChat1",
		},
		chatReset = {
			type = "toggle",
			name = L["Buff Has Reset"],
			desc = L["Print a msg in chat when a buff has reset and a new one can be dropped."],
			order = 36,
			get = "getChat0",
			set = "setChat0",
		},
		chatZan = {
			type = "toggle",
			name = L["Zandalar Buff Warning"],
			desc = L["Print a msg in chat 30 seconds before Zandalar buff will drop when the NPC starts yelling."],
			order = 37,
			get = "getChatZan",
			set = "setChatZan",
		},
		middleWarningHeader = {
			type = "header",
			name = L["Middle Of The Screen Timer Warnings"],
			order = 40,
		},
		middle30 = {
			type = "toggle",
			name = L["30 Minutes"],
			desc = L["Show a raid warning style msg in the middle of the screen when 30 minutes left."],
			order = 41,
			get = "getMiddle30",
			set = "setMiddle30",
		},
		middle15 = {
			type = "toggle",
			name = L["15 Minutes"],
			desc = L["Show a raid warning style msg in the middle of the screen when 15 minutes left."],
			order = 42,
			get = "getMiddle15",
			set = "setMiddle15",
		},
		middle10 = {
			type = "toggle",
			name = L["10 Minutes"],
			desc = L["Show a raid warning style msg in the middle of the screen when 10 minutes left."],
			order = 43,
			get = "getMiddle10",
			set = "setMiddle10",
		},
		middle5 = {
			type = "toggle",
			name = L["5 Minutes"],
			desc = L["Show a raid warning style msg in the middle of the screen when 5 minutes left."],
			order = 44,
			get = "getMiddle5",
			set = "setMiddle5",
		},
		middle1 = {
			type = "toggle",
			name = L["1 Minute"],
			desc = L["Show a raid warning style msg in the middle of the screen when 1 minute left."],
			order = 45,
			get = "getMiddle1",
			set = "setMiddle1",
		},
		middleReset = {
			type = "toggle",
			name = L["Buff Has Reset"],
			desc = L["Show a raid warning style msg in the middle of the screen when a buff has reset and a new one can be dropped."],
			order = 46,
			get = "getMiddle0",
			set = "setMiddle0",
		},
		middleBuffWarning = {
			type = "toggle",
			name = L["Buff Drop Warning"],
			desc = L["Show a raid warning style msg in the middle of the screen when someone hands in the head for any buff and the "]
					.. L["NPC yells a few seconds before the buff will drop."],
			order = 47,
			get = "getMiddleBuffWarning",
			set = "setMiddleBuffWarning",
		},
		middleHideCombat = {
			type = "toggle",
			name = L["Hide In Combat"],
			desc = L["Hide middle of the screen warnings in combat?"],
			order = 48,
			get = "getMiddleHideCombat",
			set = "settMiddleHideCombat",
		},
		middleHideRaid = {
			type = "toggle",
			name = L["Hide In Raid"],
			desc = L["Hide middle of the screen warnings in raid instances? (Doesn't hide in normal dungeons)"],
			order = 49,
			get = "getMiddleHideRaid",
			set = "settMiddleHideRaid",
		},
		guildWarningHeader = {
			type = "header",
			name = L["Guild Message Timer Warnings"],
			order = 50,
		},
		--[[guild30 = {
			type = "toggle",
			name = L["30 Minutes"],
			desc = L["Send a message to guild chat when 30 minutes left."],
			order = 51,
			get = "getGuild30",
			set = "setGuild30",
		},
		guild15 = {
			type = "toggle",
			name = L["15 Minutes"],
			desc = L["Send a message to guild chat when 15 minutes left."],
			order = 52,
			get = "getGuild15",
			set = "setGuild15",
		},]]
		guild10 = {
			type = "toggle",
			name = L["10 Minutes"],
			desc = L["Send a message to guild chat when 10 minutes left."],
			order = 53,
			get = "getGuild10",
			set = "setGuild10",
		},
		--[[guild5 = {
			type = "toggle",
			name = L["5 Minutes"],
			desc = L["Send a message to guild chat when 5 minutes left."],
			order = 54,
			get = "getGuild5",
			set = "setGuild5",
		},]]
		guild1 = {
			type = "toggle",
			name = L["1 Minute"],
			desc = L["Send a message to guild chat when 1 minute left."],
			order = 55,
			get = "getGuild1",
			set = "setGuild1",
		},
		--[[guildReset = {
			type = "toggle",
			name = L["Buff Has Reset"],
			desc = L["Send a message to guild chat when a buff has reset and a new one can be dropped."],
			order = 56,
			get = "getGuild0",
			set = "setGuild0",
		},]]
		guildNpcDialogue = {
			type = "toggle",
			name = L["NPC Dialogue Started"],
			desc = L["Send a message to guild when someone hands in a head and the NPC first yells and you still have time to relog if fast?"],
			order = 57,
			get = "getGuildNpcDialogue",
			set = "setGuildNpcDialogue",
		},
		guildBuffDropped = {
			type = "toggle",
			name = L["New Buff Dropped"],
			desc = L["Send a message to guild when a new buff has been dropped? This msg is sent after the NPC is finished yelling "]
					.. L[" and you get the actual buff a few seconds later. (6 seconds after first yell for rend, 14 seconds for ony, "]
					.. L[" 15 seconds for nef)"],
			order = 58,
			get = "getGuildBuffDropped",
			set = "setGuildBuffDropped",
		},
		guildNpcKilled = {
			type = "toggle",
			name = L["NPC Was Killed"],
			desc = L["Send a message to guild when one of the buff NPC's were killed in Orgrimmar or Stormwind? (mind control reset)."],
			order = 59,
			get = "getGuildNpcKilled",
			set = "setGuildNpcKilled",
		},
		guildZanDialogue = {
			type = "toggle",
			name = L["Zandalar Buff Warning"],
			desc = L["Send a message to guild when Spirit of Zandalar buff is about to drop? (If you want no guild msgs at all "]
					.. L["for this buff then everyone in guild needs to disable this)."],
			order = 60,
			get = "getGuildZanDialogue",
			set = "setGuildZanDialogue",
		},
		songflowers = {
			type = "header",
			name = L["Songflowers"],
			order = 70,
		},
		guildSongflower = {
			type = "toggle",
			name = L["Tell Guild When Picked"],
			desc = L["Tell your guild chat when you have picked a songflower with the time of next spawn?"],
			order = 71,
			get = "getGuildSongflower",
			set = "setGuildSongflower",
		},
		mySongflowerOnly = {
			type = "toggle",
			name = L["Only When I Pick"],
			desc = L["Only record a new timer when I pick a songflower and not when others pick infront of me? This option is here "]
					.. L["just incase you have problems with false timers being set from other players. There's currently "]
					.. L["no way to tell if another players buff is new so a timer may trigger on rare occasions if the game loads "]
					.. L["the songflower buff on someone else when they logon infront of you beside a songflower."],
			order = 72,
			get = "getMySongflowerOnly",
			set = "setMySongflowerOnly",
		},
		syncFlowersAll = {
			type = "toggle",
			name = L["Sync Flowers With All"],
			desc = L["Enable this to override the guild only data setting at the top of this config so you can share songflower "]
					.. L["data outside the guild but keep worldbuff data guild only still."],
			order = 73,
			get = "getSyncFlowersAll",
			set = "setSyncFlowersAll",
		},
		showNewFlower = {
			type = "toggle",
			name = L["Show New SF Timers"],
			desc = L["This will show you in chat window when a new flower timer is found from another player not in your guild "]
					.. L[" (guild msgs already show in guild chat when a flower is picked)."],
			order = 74,
			get = "getShowNewFlower",
			set = "setShowNewFlower",
		},
		showSongflowerWorldmapMarkers = {
			type = "toggle",
			name = L["Songflower Worldmap"],
			desc = L["Show songflower icons on the world map?."],
			order = 75,
			get = "getShowSongflowerWorldmapMarkers",
			set = "setShowSongflowerWorldmapMarkers",
		},
		showSongflowerMinimapMarkers = {
			type = "toggle",
			name = L["Songflower Minimap"],
			desc = L["Show songflower icons on the mini map?."],
			order = 76,
			get = "getShowSongflowerMinimapMarkers",
			set = "setShowSongflowerMinimapMarkers",
		},
		showTuberWorldmapMarkers = {
			type = "toggle",
			name = L["Tuber Worldmap"],
			desc = L["Show Whipper Root Tuber icons on the world map?."],
			order = 77,
			get = "getShowTuberWorldmapMarkers",
			set = "setShowTuberWorldmapMarkers",
		},
		showTuberMinimapMarkers = {
			type = "toggle",
			name = L["Tuber Minimap"],
			desc = L["Show Whipper Root Tuber icons on the mini map?."],
			order = 78,
			get = "getShowTuberMinimapMarkers",
			set = "setShowTuberMinimapMarkers",
		},
		showDragonWorldmapMarkers = {
			type = "toggle",
			name = L["Dragon Worldmap"],
			desc = L["Show Night Dragon's Breath icons on the world map?."],
			order = 79,
			get = "getShowDragonWorldmapMarkers",
			set = "setShowDragonWorldmapMarkers",
		},
		showDragonMinimapMarkers = {
			type = "toggle",
			name = L["Dragon Minimap"],
			desc = L["Show Night Dragon's Breath icons on the mini map?."],
			order = 80
			,
			get = "getShowDragonMinimapMarkers",
			set = "setShowDragonMinimapMarkers",
		},
		showExpiredTimers = {
			type = "toggle",
			name = L["Show Expired Timers"],
			desc = L["Show expired timers in Felwood? They will be shown in red text how long ago a timer expired, the default "]
					.. L["time is 5 minutes (people say songflowers stay cleansed for 5 minutes after spawn?)."],
			order = 81,
			get = "getShowExpiredTimers",
			set = "setShowExpiredTimers",
		},
		expiredTimersDuration = {
			type = "range",
			name = L["Expired Timers Duraton"],
			desc = L["How long should Felwood timers show for after expiring on the world map?"],
			order = 82,
			get = "getExpiredTimersDuration",
			set = "setExpiredTimersDuration",
			min = 1,
			max = 60,
			softMin = 1,
			softMax = 60,
			step = 1,
		},
		dmf = {
			type = "header",
			name = L["Darkmoon Faire"],
			order = 90,
		},
		dmfDesc = {
			type = "description",
			name = L["|CffDEDE42Your DMF damage buff cooldown will also show on the Darkmoon Faire map icon when you hover it, if you"]
					.. L[" have a cooldown and DMF is currently up."],
			fontSize = "medium",
			order = 91,
		},
		showDmfWb = {
			type = "toggle",
			name = L["Show DMF with /wb"],
			desc = L["Show DMF spawn timer together with /wb command?"],
			order = 92,
			get = "getShowDmfWb",
			set = "setShowDmfWb",
		},
		showDmfWb = {
			type = "toggle",
			name = L["DMF Spawn with /wb"],
			desc = L["Show DMF spawn timer together with /wb command?"],
			order = 92,
			get = "getShowDmfWb",
			set = "setShowDmfWb",
		},
		showDmfBuffWb = {
			type = "toggle",
			name = L["DMF Buff Cooldown /wb"],
			desc = L["Show your DMF buff cooldown timer together with /wb command? Only shows when you are on an active cooldown"]
					.. L[" and DMF is currently up."],
			order = 93,
			get = "getShowDmfBuffWb",
			set = "setShowDmfBuffWb",
		},
		--[[showDmfWhenClose = {
			type = "toggle",
			name = L["Show Close To Spawn"],
			desc = L["Show DMF spawn timer at logon and together with /wb command when it's within 12 hours of spawn or despawn."],
			order = 93,
			get = "getShowDmfWhenClose",
			set = "setShowDmfWhenClose",
		},]]
		--[[showDmfLogon = {
			type = "toggle",
			name = L["Show Always Logon"],
			desc = L["Show DMF spawn timer at logon always, even if it's not close to spawn."],
			order = 94,
			get = "getShowDmfLogon",
			set = "setShowDmfLogon",
		},]]
		showDmfMap = {
			type = "toggle",
			name = L["Show Map Marker"],
			desc = L["Show DMF map marker with spawn timer and buff cooldown info in Mulgore and Elwynn Forest "]
					.. L["world maps (whichever is next spawn). You can also type /dmf map to open the world map strait to this marker."],
			order = 95,
			get = "getShowDmfMap",
			set = "setShowDmfMap",
		},
		guildChatFilter = {
			type = "header",
			name = L["Guild Chat Filter"],
			order = 100,
		},
		guildChatFilterDesc = {
			type = "description",
			name = L["|CffDEDE42This will block any guild msgs from this addon you choose so you don't see them. It will stop "]
					.. L["you from seeing your own msgs and msgs from other addon users in guild chat."],
			fontSize = "medium",
			order = 101,
		},
		filterYells = {
			type = "toggle",
			name = L["Filter Buff Warning"],
			desc = L["Filter the msg when a buff is about to drop in a few seconds (Onyxia will drop in 14 seconds)."],
			order = 102,
			get = "getFilterYells",
			set = "setFilterYells",
		},
		filterDrops = {
			type = "toggle",
			name = L["Filter Buff Dropped"],
			desc = L["Filter the msg when a buff has dropped (Rallying Cry of the Dragonslayer (Onyxia) has dropped)."],
			order = 103,
			get = "getFilterDrops",
			set = "setFilterDrops",
		},
		filterTimers = {
			type = "toggle",
			name = L["Filter Timer Msgs"],
			desc = L["Filter timer msgs (Onyxia resets in 1 minute)."],
			order = 104,
			get = "getFilterTimers",
			set = "setFilterTimers",
		},
		filterCommand = {
			type = "toggle",
			name = L["Filter !wb command"],
			desc = L["Filter the !wb and !dmf in guild chat when typed by players."],
			order = 105,
			get = "getFilterCommand",
			set = "setFilterCommand",
		},
		filterCommandResponse = {
			type = "toggle",
			name = L["Filter !wb reply"],
			desc = L["Filter the reply msg with timers this addon does when !wb or !!dmf is used."],
			order = 106,
			get = "getFilterCommandResponse",
			set = "setFilterCommandResponse",
		},
		filterSongflowers = {
			type = "toggle",
			name = L["Filter Songflowers"],
			desc = L["Filter the msg when a songflower is picked."],
			order = 107,
			get = "getFilterSongflowers",
			set = "setFilterSongflowers",
		},
		filterNpcKilled = {
			type = "toggle",
			name = L["Filter NPC Killed"],
			desc = L["Filter the msg when a buff hand in NPC is killed in your city."],
			order = 108,
			get = "getFilterNpcKilled",
			set = "setFilterNpcKilled",
		},
		sounds = {
			type = "header",
			name = L["Sounds"],
			order = 110,
		},
		soundsDesc = {
			type = "description",
			name = L["|CffDEDE42Set sound to \"None\" to disable."],
			fontSize = "medium",
			order = 111,
		},
		disableAllSounds = {
			type = "toggle",
			name = L["Disable All Sounds"],
			desc = L["Disable all sounds from this addon."],
			order = 112,
			get = "getDisableAllSounds",
			set = "setDisableAllSounds",
		},
		extraSoundOptions = {
			type = "toggle",
			name = L["Extra Sound Options"],
			desc = L["Enable this to display all the sounds from all your addons at once in the dropdown lists here."],
			order = 113,
			get = "getExtraSoundOptions",
			set = "setExtraSoundOptions",
			--width = "double",
		},
		soundOnlyInCity = {
			type = "toggle",
			name = L["Only In City"],
			desc = L["Only play buff sounds when you are in the main city where the buffs drop (Stranglethorn Vale included for Zandalar buff)."],
			order = 114,
			get = "getSoundOnlyInCity",
			set = "setSoundOnlyInCity",
		},
		soundsDisableInInstances = {
			type = "toggle",
			name = L["Disable In Instances"],
			desc = L["Disable sounds while in raids and instances."],
			order = 115,
			get = "getSoundsDisableInInstances",
			set = "setSoundsDisableInInstances",
		},
		soundsFirstYell = {
			type = "select",
			name = L["Buff Coming"],
			desc = L["Sound to play when head is handed in and you have a few seconds before buff will drop (First NPC Yell)."],
			values = function()
				return NWB:getSounds();
			end,
			order = 116,
			get = "getSoundsFirstYell",
			set = "setSoundsFirstYell",
		},
		soundsOneMinute = {
			type = "select",
			name = L["One Minute Warning"],
			desc = L["Sound to play for 1 minute left timer warning."],
			values = function()
				return NWB:getSounds();
			end,
			order = 117,
			get = "getSoundsOneMinute",
			set = "setSoundsOneMinute",
		},
		soundsRendDrop = {
			type = "select",
			name = L["Rend Buff Gained"],
			desc = L["Sound to play for Rend buff drops and you get the buff."],
			values = function()
				return NWB:getSounds("rend");
			end,
			order = 120,
			get = "getSoundsRendDrop",
			set = "setSoundsRendDrop",
		},
		soundsOnyDrop = {
			type = "select",
			name = L["Ony Buff Gained"],
			desc = L["Sound to play for Onyxia buff drops and you get the buff."],
			values = function()
				return NWB:getSounds("ony");
			end,
			order = 121,
			get = "getSoundsOnyDrop",
			set = "setSoundsOnyDrop",
		},
		soundsNefDrop = {
			type = "select",
			name = L["Nef Buff Gained"],
			desc = L["Sound to play for Nefarian buff drops and you get the buff."],
			values = function()
				return NWB:getSounds("nef");
			end,
			order = 122,
			get = "getSoundsNefDrop",
			set = "setSoundsNefDrop",
		},
		soundsZanDrop = {
			type = "select",
			name = L["Zandalar Buff Gained"],
			desc = L["Sound to play for Zandalar buff drops and you get the buff."],
			values = function()
				return NWB:getSounds("zan");
			end,
			order = 123,
			get = "getSoundsZanDrop",
			set = "setSoundsZanDrop",
		},
		flash = {
			type = "header",
			name = L["Flash When Minimized"],
			order = 130,
		},
		flashOneMin = {
			type = "toggle",
			name = L["Flash One Minute"],
			desc = L["Flash the wow client when you have it minimized and 1 minute is left on timer?"],
			order = 131,
			get = "getFlashOneMin",
			set = "setFlashOneMin",
		},
		flashFirstYell = {
			type = "toggle",
			name = L["Flash NPC Yell"],
			desc = L["Flash the wow client when you have it minimized and the NPC's out a few seconds before buff drops?"],
			order = 132,
			get = "getFlashFirstYell",
			set = "setFlashFirstYell",
		},
		flashFirstYellZan = {
			type = "toggle",
			name = L["Flash Zandalar"],
			desc = L["Flash the wow client when you have it minimized and the Zandalar buff is about to go out?"],
			order = 133,
			get = "getFlashFirstYellZan",
			set = "setFlashFirstYellZan",
		},
	},
};

function NWB:loadSpecificOptions()
	if (NWB.faction == "Alliance") then
		NWB.options.args["allianceEnableRend"] = {
			type = "toggle",
			name = L["Enable Alliance Rend"],
			desc = L["Enable this to track rend as Alliance, for guilds that mind control to get rend buff. If you use this then everyone in "]
					.. L["the guild with the addon should enable it or guild chat msgs may not work properly (personal timer msgs will still work)."];
			order = 18,
			get = "getAllianceEnableRend",
			set = "setAllianceEnableRend",
		};
	end
	if (NWB.isLayered) then
		NWB.options.args["minimapLayerFrame"] = {
			type = "toggle",
			name = L["Show Minimap Layer"],
			desc = L["Show the little frame on the minimap with your current layer while in a capital city?"];
			order = 18,
			get = "getMinimapLayerFrame",
			set = "setMinimapLayerFrame",
		};
		NWB.options.args["minimapLayerFrameReset"] = {
				type = "execute",
				name = L["Reset Minimap Layer"],
				desc = L["Reset minimap layer frame back to default position (hold shift to drag the minimap frame)."],
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
		chatColorR = 255, chatColorG = 255, chatColorB = 0,
		middleColorR = 1, middleColorG = 0.96, middleColorB = 0.41,
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
		guild30 = false,
		guild15 = false,
		guild10 = true,
		guild5 = false,
		guild1 = true,
		guild0 = false,
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
		guildNpcKilled = true,
		guildBuffDropped = true,
		guildNpcDialogue = true,
		guildZanDialogue = true,
		guildCommand = true,
		disableAllGuildMsgs = false,
		receiveGuildDataOnly = false,
		guildSongflower = true,
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
		soundsFirstYell = "NWB - Electronic",
		soundsOneMinute = "None",
		soundsRendDrop = "NWB - Zelda",
		soundsOnyDrop = "NWB - Zelda",
		soundsNefDrop = "NWB - Zelda",
		soundsZanDrop = "NWB - Zelda",
		showExpiredTimers = true,
		expiredTimersDuration = 5,
		minimapIcon = {["minimapPos"] = 165, ["hide"] = false},
		minimapButton = true,
		flashOneMin = true,
		flashFirstYell = true,
		flashFirstYellZan = true,
		resetLayers3 = true, --Reset layers one time (sometimes needed when upgrading from old version.
		resetSongflowers = true, --Reset songflowers one time.
		experimental = true, --Enable features being tested on occasion.
		resetLayerMaps = true;
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

--Disable all guild msgs.
function NWB:setDisableAllGuildMsgs(info, value)
	self.db.global.disableAllGuildMsgs = value;
	NWB:sendData("GUILD");
end

function NWB:getDisableAllGuildMsgs(info)
	return self.db.global.disableAllGuildMsgs;
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

--Reset colors.
function NWB:resetColors(info, r, g, b, a)
	self.db.global.chatColorR = self.optionDefaults.global.chatColorR;
	self.db.global.chatColorG = self.optionDefaults.global.chatColorG;
	self.db.global.chatColorB = self.optionDefaults.global.chatColorB;
	self.db.global.middleColorR = self.optionDefaults.global.middleColorR;
	self.db.global.middleColorG = self.optionDefaults.global.middleColorG;
	self.db.global.middleColorB = self.optionDefaults.global.middleColorB;
	NWB.chatColor = "|cff" .. NWB:RGBToHex(self.db.global.chatColorR, self.db.global.chatColorG, self.db.global.chatColorB);
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

--Guild 30 minute warning.
function NWB:setGuild30(info, value)
	self.db.global.guild30 = value;
end

function NWB:getGuild30(info)
	return self.db.global.guild30;
end

--Guild 15 minute warning.
function NWB:setGuild15(info, value)
	self.db.global.guild15 = value;
end

function NWB:getGuild15(info)
	return self.db.global.guild15;
end

--Guild 10 minute warning.
function NWB:setGuild10(info, value)
	self.db.global.guild10 = value;
end

function NWB:getGuild10(info)
	return self.db.global.guild10;
end

--Guild 5 minute warning.
function NWB:setGuild5(info, value)
	self.db.global.guild5 = value;
end

function NWB:getGuild5(info)
	return self.db.global.guild5;
end

--Guild 1 minute warning.
function NWB:setGuild1(info, value)
	self.db.global.guild1 = value;
end

function NWB:getGuild1(info)
	return self.db.global.guild1;
end

--Guild 0 minute warning.
function NWB:setGuild0(info, value)
	self.db.global.guild0 = value;
end

function NWB:getGuild0(info)
	return self.db.global.guild0;
end

--Guild NPC dialogue started.
function NWB:setGuildNpcDialogue(info, value)
	self.db.global.guildNpcDialogue = value;
	NWB:sendData("GUILD");
end

function NWB:getGuildNpcDialogue(info)
	return self.db.global.guildNpcDialogue;
end

--Guild Zan dialogue started.
function NWB:setGuildZanDialogue(info, value)
	self.db.global.guildZanDialogue = value;
	NWB:sendData("GUILD");
end

function NWB:getGuildZanDialogue(info)
	return self.db.global.guildZanDialogue;
end

--Guild buff dropped.
function NWB:setGuildBuffDropped(info, value)
	self.db.global.guildBuffDropped = value;
	NWB:sendData("GUILD");
end

function NWB:getGuildBuffDropped(info)
	return self.db.global.guildBuffDropped;
end

--Guild NPC killed.
function NWB:setGuildNpcKilled(info, value)
	self.db.global.guildNpcKilled = value;
	NWB:sendData("GUILD");
end

function NWB:getGuildNpcKilled(info)
	return self.db.global.guildNpcKilled;
end

--Guild !wb command.
function NWB:setGuildCommand(info, value)
	self.db.global.guildCommand = value;
	NWB:sendData("GUILD");
end

function NWB:getGuildCommand(info)
	return self.db.global.guildCommand;
end

--Guild songflower picked announce.
function NWB:setGuildSongflower(info, value)
	self.db.global.guildSongflower = value;
end

function NWB:getGuildSongflower(info)
	return self.db.global.guildSongflower;
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