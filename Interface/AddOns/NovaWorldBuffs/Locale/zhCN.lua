local L = LibStub("AceLocale-3.0"):NewLocale("NovaWorldBuffs", "zhCN");
if (not L) then
	return;
end

--Rend buff aura name.
L["Warchief's Blessing"] = "酋长的祝福";
--Onyxia and Nefarian buff aura name.
L["Rallying Cry of the Dragonslayer"] = "屠龙者的咆哮";
--Songflower buff aura name from felwood.
L["Songflower Serenade"] = "风歌夜曲";
L["Songflower"] = "轻歌花";
--Spirit of Zandalar.
L["Spirit of Zandalar"] = "赞达拉之魂";
L["Flask of Supreme Power"] = "超级能量合剂";
L["Flask of the Titans"] = "泰坦合剂";
L["Flask of Distilled Wisdom"] = "精炼智慧合剂";
L["Flask of Chromatic Resistance"] = "多重抗性合剂";
--3 of the flasks spells seem to be named differently than the flask item, but titan is exact same name as the flask item.
L["Supreme Power"] = "至高能量";
L["Distilled Wisdom"] = "萃取智慧";
L["Chromatic Resistance"] = "多彩抗性";

---=====---
---Horde---
---=====---

--Horde Orgrimmar Rend buff NPC.
L["Thrall"] = "萨尔";
--Horde The Barrens Rend buff NPC.
L["Herald of Thrall"] = "萨尔的使者";
--Horde rend buff NPC first yell string (part of his first yell msg before before buff).
L["Rend Blackhand, has fallen"] = "为你们的英雄而欢庆";
--Horde rend buff NPC second yell string (part of his second yell msg before before buff).
L["Be bathed in my power"] = "沐浴在我的力量中吧";

--Horde Onyxia buff NPC.
L["Overlord Runthak"] = "伦萨克";
--Horde Onyxia buff NPC first yell string (part of his first yell msg before before buff).
L["Onyxia, has been slain"] = "部落的人民，奥格瑞玛的居民";
--Horde Onyxia buff NPC second yell string (part of his second yell msg before before buff).
L["Be lifted by the rallying cry"] = "在屠龙大军的战斗号角声中精神抖擞地前进吧";

--Horde Nefarian buff NPC.
L["High Overlord Saurfang"] = "萨鲁法尔大王";
--Horde Nefarian buff NPC first yell string (part of his first yell msg before before buff).
L["NEFARIAN IS SLAIN"] = "奈法利安被杀掉了";
--Horde Nefarian buff NPC second yell string (part of his second yell msg before before buff).
L["Revel in his rallying cry"] = "为他的胜利而狂欢吧";

---========---
---Alliance---
---========---

--Alliance Onyxia buff NPC.
L["Major Mattingly"] = "玛丁雷少校";
--Alliance Onyxia buff NPC first yell string (part of his first yell msg before before buff).
L["history has been made"] = "暴风城的城民和盟友们";
--Alliance Onyxia buff NPC second yell string (part of his second yell msg before before buff).
L["Onyxia, hangs from the arches"] = "看看强大的联盟吧";


--Alliance Nefarian buff NPC.
L["Field Marshal Afrasiabi"] = "艾法希比元帅";
--Alliance Nefarian buff NPC first yell string (part of his first yell msg before before buff).
L["the Lord of Blackrock is slain"] = "联盟的人民们";
--Alliance Nefarian buff NPC second yell string (part of his second yell msg before before buff).
L["Revel in the rallying cry"] = "兴奋起来";

---===========----
---NPC's killed---
---============---

L["onyxiaNpcKilledHorde"] = "伦萨克死亡了。 (奥妮克希亚 buff NPC)。";
L["onyxiaNpcKilledAlliance"] = "玛丁雷少校死亡了。(奥妮克希亚 buff NPC)。";
L["nefarianNpcKilledHorde"] = "萨鲁法尔大王死亡了。 (奈法利安 buff NPC)。";
L["nefarianNpcKilledAlliance"] = "艾法希比元帅死亡了。(奈法利安 buff NPC)。";
L["onyxiaNpcKilledHordeWithTimer"] = "奥妮克希亚 NPC (伦萨克) 已经被击杀了 %s ， 之后没有任何buff记录。";
L["NefarianNpcKilledHordeWithTimer"] = "奈法利安 NPC (萨鲁法尔大王)已经被击杀了 %s ， 之后没有任何buff记录。";
L["onyxiaNpcKilledAllianceWithTimer"] = "奥妮克希亚 buff NPC (玛丁雷少校) 已经被击杀了 %s ， 之后没有任何buff记录。";
L["NefarianNpcKilledAllianceWithTimer"] = "奈法利安 buff NPC (艾法希比元帅)已经被击杀了 %s ， 之后没有任何buff记录。";
L["anyNpcKilledAllianceWithTimer"] = "NPC 在 %s 以前被击杀了"; --Map timers tooltip msg.


---==============---
---Darkmoon Faire---
---==============---

L["Darkmoon Faire"] = "暗月马戏团";
L["Sayge's Dark Fortune of Agility"] = "塞格的黑暗塔罗牌：敏捷";
L["Sayge's Dark Fortune of Intelligence"] = "塞格的黑暗塔罗牌：智力";
L["Sayge's Dark Fortune of Spirit"] = "塞格的黑暗塔罗牌：精神";
L["Sayge's Dark Fortune of Stamina"] = "塞格的黑暗塔罗牌：耐力";
L["Sayge's Dark Fortune of Strength"] = "塞格的黑暗塔罗牌：力量";
L["Sayge's Dark Fortune of Armor"] = "塞格的黑暗塔罗牌：护甲";
L["Sayge's Dark Fortune of Resistance"] = "塞格的黑暗塔罗牌：抗性";
L["Sayge's Dark Fortune of Damage"] = "塞格的黑暗塔罗牌：伤害";
L["dmfBuffCooldownMsg"] = "你的暗月马戏团 buff 冷却剩余时间 %s 。";
L["dmfBuffReady"] = "你的暗月马戏团 buff 冷却剩余时间已就绪。"; --These 2 buff msgs are slightly different for a reason.
L["dmfBuffReset"] = "你的暗月马戏团 buff 冷却剩余时间已重置。"; --These 2 buff msgs are slightly different for a reason.
L["dmfBuffDropped"] = "暗月马戏团 buff %s 已获得, 输入/buffs来查看该buff在4小时游戏时间的冷却剩余。";
L["dmfSpawns"] = "暗月马戏团将刷新于%s后(%s)。";
L["dmfEnds"] = "暗月马戏团已刷新, 将于%s后(%s)结束。";
L["mulgore"] = "莫高雷";
L["elwynnForest"] = "艾尔文森林";
				
---==============---
---Output Strings---
---==============---

L["rend"] = "雷德·黑手"; --Rend Blackhand
L["onyxia"] = "奥妮克希亚"; --Onyxia
L["nefarian"] = "奈法利安"; --Nefarian
L["dmf"] = "暗月马戏团"; --Darkmoon Faire
L["noTimer"] = "没有计时"; --No timer
L["noCurrentTimer"] = "没有当前计时"; --No current timer
L["noActiveTimers"] = "没有激活计时";	--No active timers
L["newBuffCanBeDropped"] = "一个新的%sBuff现在可以释放"
L["buffResetsIn"] = "%s将于%s后重置。";
L["rendFirstYellMsg"] = "雷德·黑手Buff将于6秒后释放。";
L["onyxiaFirstYellMsg"] = "奥妮克希亚Buff将于14秒后释放。";
L["nefarianFirstYellMsg"] = "奈法利安Buff将于15秒后释放。";
L["rendBuffDropped"] = "酋长的祝福（雷德·黑手）已经释放。";
L["onyxiaBuffDropped"] = "屠龙者的咆哮（奥妮克希亚）Buff已经释放。";
L["nefarianBuffDropped"] = "屠龙者的咆哮（奈法利安）Buff已经释放。";
L["onyxiaNpcKilledHorde"] = "伦萨克死亡了。 (奥妮克希亚 buff NPC)。";
L["onyxiaNpcKilledAlliance"] = "玛丁雷少校死亡了。(奥妮克希亚 buff NPC)。";
L["nefarianNpcKilledHorde"] = "萨鲁法尔大王死亡了。 (奈法利安 buff NPC)。";
L["nefarianNpcKilledAlliance"] = "艾法希比元帅死亡了。(奈法利安 buff NPC)。";
L["newSongflowerReceived"] = "收到新的轻歌花计时"; --New songflower timer received
L["songflowerPicked"] = "%s的轻歌花已被拾取, 25分钟后刷新。"; -- Guild msg when songflower picked.
L["North Felpaw Village"] = "魔爪村北部"; --Felwood map subzones (flower1).
L["West Felpaw Village"] = "魔爪村西部"; --Felwood map subzones (flower2).
L["North of Irontree Woods"] = "铁木森林北部"; --Felwood map subzones (flower3).
L["Talonbranch Glade"] = "刺枝林地"; --Felwood map subzones (flower4).
L["Shatter Scar Vale"] = "碎痕谷"; --Felwood map subzones (flower5).
L["Bloodvenom Post"] = "血毒岗哨"; --Felwood map subzones (flower6).
L["East of Jaedenar"] = "加德纳尔东部"; --Felwood map subzones (flower7).
L["North of Emerald Sanctuary"] = "翡翠圣地北部"; --Felwood map subzones (flower8).
L["West of Emerald Sanctuary"] = "翡翠圣地西部"; --Felwood map subzones (flower9).
L["South of Emerald Sanctuary"] = "翡翠圣地南部"; --Felwood map subzones (flower10).
L["second"] = "秒"; --Second (singular).
L["seconds"] = "秒"; --Seconds (plural).
L["minute"] = "分"; --Minute (singular).
L["minutes"] = "分"; --Minutes (plural).
L["hour"] = "时"; --Hour (singular).
L["hours"] = "时"; --Hours (plural).
L["day"] = "天"; --Day (singular).
L["days"] = "天"; --Days (plural).
L["secondShort"] = "秒"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "分"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "时"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "天"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "将于%s后开始"; --"Starts in 1hour".
L["endsIn"] = "将于%s后结束"; --"Ends in 1hour".
L["versionOutOfDate"] = "Nova World Buffs 插件已过期,请在 https://www.curseforge.com/wow/addons/nova-world-buffs 或 twitch 更新。";
L["Your Current World Buffs"] = "当前世界Buff";
L["Options"] = "选项";

---New stuff---

--Spirit of Zandalar buff NPC first yell string (part of his first yell msg before before buff).
L["Begin the ritual"] = "开始仪式";
L["The Blood God"] = "夺灵者已经被打败了"; --First Booty bay yell from Zandalarian Emissary.
--Spirit of Zandalar buff NPC second yell string (part of his second yell msg before before buff).
L["slayer of Hakkar"] = "向你致敬";

L["Spirit of Zandalar"] = "赞达拉之魂"
L["Molthor"] = "莫托尔";
L["Zandalarian Emissary"] = "赞达拉大使";
L["Whipper Root Tuber"] = "鞭根块茎";
L["Night Dragon's Breath"] = "夜龙之息";
L["Resist Fire"] = "抵抗火焰"; -- LBRS fire resist buff.
L["Blessing of Blackfathom"] = "黑暗深渊的祝福";

L["zan"] = "赞达拉";
L["zanFirstYellMsg"] = "赞达拉之魂将于30秒后释放。";
L["zanBuffDropped"] = "赞达拉之魂已经释放。";
L["singleSongflowerMsg"] = "%s的轻歌花将于%s后刷新。";
L["spawn"] = "刷新"; --Used in Felwood map marker tooltip (03:46pm spawn).

L["Irontree Woods"] = "铁木森林";
L["West of Irontree Woods"] = "铁木森林西部";
L["Bloodvenom Falls"] = "血毒瀑布";
L["Jaedenar"] = "加德纳尔";
L["North-West of Irontree Woods"] = "铁木森林西北部";
L["South of Irontree Woods"] = "铁木森林南部";

L["cityMapLayerMsgHorde"] = "当前在%s\n点选奥格瑞玛任意NPC\n更新你的位面信息。|r";
L["cityMapLayerMsgAlliance"] = "当前在%s\n点选暴风城任意NPC\n更新你的位面信息。|r";
L["noLayerYetHorde"] = "点选奥格瑞玛任意NPC\n确认你当前所在的位面。";
L["noLayerYetAlliance"] = "点选暴风城任意NPC\n确认你当前所在的位面。";
L["Reset Data"] = "重置数据"; --A button to Reset buffs window data.

-- Option汉化 by Aoikaze
L["|CffDEDE42World Buffs Config (You can type /wb config to open this).\n"] = "|CffDEDE42世界Buff插件配置（输入/wb config开启此窗口）。\n"
L["Type /wb to display timers to yourself.\n"] = "输入/wb 显示自身Buff状态。\n"
L["Type /wb <channel> to display timers to the specified channel.\n"] = "输入/wb <channel> 在特定<channel>显示你的Buff状态。\n"
L["Scroll down for more options."] = "向下滚动查看更多设置项目。"
L["Send a message to guild when Spirit of Zandalar buff is about to drop? (If you want no guild msgs at all "] = "当赞达拉之魂即将释放时向公会频道发送信息。"
L["Show a raid warning style msg in the middle of the screen when 30 minutesLeft."] = "Show a raid warning style msg in the middle of the screen when 30 minutesLeft."
L["Filter the msg when a songflower is picked."] = "Filter the msg when a songflower is picked."
L["Enable this to override the guild only data setting at the top of this config so you can share songflower "] = "Enable this to override the guild only data setting at the top of this config so you can share songflower "
L["Disable all sounds from this addon."] = "Disable all sounds from this addon."
L["Disable all guild messages including timers and when buffs drop? Note: You can disable all msgs 1 by 1 below and "] = "Disable all guild messages including timers and when buffs drop? Note: You can disable all msgs 1 by 1 below and "
L["Colorize the prefix [WorldBuffs] in all chat channels? This is the prefix in chat you can click to show "] = "Colorize the prefix [WorldBuffs in all chat channels? This is the prefix in chat you can click to show "
L["Disable sounds while in raids and instances."] = "Disable sounds while in raids and instances."
L["Enable this to display all the sounds from all your addons at once in the dropdownLists here."] = "Enable this to display all the sounds from all your addons at once in the dropdownLists here."
L["Enable this to track rend as Alliance, for guilds that mind control to get rend buff. If you use this then everyone in "] = "Enable this to track rend as Alliance, for guilds that mind control to get rend buff. If you use this then everyone in "
L["Filter the !wb and !dmf in guild chat when typed by players."] = "Filter the !wb and !dmf in guild chat when typed by players."
L["Filter the msg when a buff hand in NPC is killed in your city."] = "Filter the msg when a buff hand in NPC is killed in your city."
L["Filter the msg when a buff has dropped (Rallying Cry of the Dragonslayer (Onyxia) has dropped)."] = "Filter the msg when a buff has dropped (Rallying Cry of the Dragonslayer (Onyxia) has dropped)."
L["Filter the msg when a buff is about to drop in a few seconds (Onyxia will drop in 14 seconds)."] = "Filter the msg when a buff is about to drop in a few seconds (Onyxia will drop in 14 seconds)."
L["Filter the reply msg with timers this addon does when !wb or !!dmf is used."] = "Filter the reply msg with timers this addon does when !wb or !!dmf is used."
L["Filter timer msgs (Onyxia resets in 1 minute)."] = "Filter timer msgs (Onyxia resets in 1 minute)."
L["Flash the wow client when you have it minimized and a buff is about to drop? Flashes when  minuteLeft on timer "] = "Flash the wow client when you have it minimized and a buff is about to drop? Flashes when  minuteLeft on timer "
L["Only play buff sounds when you are in the main city where the buffs drop (Stranglethorn Vale included for Zandalar buff)."] = "Only play buff sounds when you are in the main city where the buffs drop (Stranglethorn Vale included for Zandalar buff)."
L["Only record a new timer when I pick a songflower and not when others pick infront of me? This option is here "] = "Only record a new timer when I pick a songflower and not when others pick infront of me? This option is here "
L["Print a msg in chat 30 seconds before Zandalar buff will drop when the NPC starts yelling."] = "Print a msg in chat 30 seconds before Zandalar buff will drop when the NPC starts yelling."
L["Print a msg in chat when 1 minuteLeft."] = "Print a msg in chat when 1 minuteLeft."
L["Print a msg in chat when 10 minutesLeft."] = "Print a msg in chat when 10 minutesLeft."
L["Print a msg in chat when 15 minutesLeft."] = "Print a msg in chat when 15 minutesLeft."
L["Print a msg in chat when 30 minutesLeft."] = "Print a msg in chat when 30 minutesLeft."
L["Print a msg in chat when 5 minutesLeft."] = "Print a msg in chat when 5 minutesLeft."
L["Print a msg in chat when a buff has reset and a new one can be dropped."] = "Print a msg in chat when a buff has reset and a new one can be dropped."
L["Reply with timer info to !wb and !dmf commands in guild chat? You should probablyLeave this enabled to help your guild, "] = "Reply with timer info to !wb and !dmf commands in guild chat? You should probablyLeave this enabled to help your guild, "
L["Reset colors back to default."] = "Reset colors back to default."
L["Send a message to guild chat when 1 minuteLeft."] = "Send a message to guild chat when 1 minuteLeft."
L["Send a message to guild chat when 10 minutesLeft."] = "Send a message to guild chat when 10 minutesLeft."
L["Send a message to guild chat when 15 minutesLeft."] = "Send a message to guild chat when 15 minutesLeft."
L["Send a message to guild chat when 30 minutesLeft."] = "Send a message to guild chat when 30 minutesLeft."
L["Send a message to guild chat when 5 minutesLeft."] = "Send a message to guild chat when 5 minutesLeft."
L["Send a message to guild chat when a buff has reset and a new one can be dropped."] = "Send a message to guild chat when a buff has reset and a new one can be dropped."
L["Send a message to guild when one of the buff NPC's were killed in Orgrimmar or Stormwind? (mind control reset)."] = "Send a message to guild when one of the buff NPC's were killed in Orgrimmar or Stormwind? (mind control reset)."
L["Send a message to guild when someone hands in a head and the NPC first yells and you still have time to relog if fast?"] = "Send a message to guild when someone hands in a head and the NPC first yells and you still have time to relog if fast?"
L["Set which timestamp format to use, 12 hour (1:23pm) or 24 hour (13:23)."] = "Set which timestamp format to use, 12 hour (1:23pm) or 24 hour (13:23)."
L["Show a raid warning style msg in the middle of the screen when 1 minuteLeft."] = "Show a raid warning style msg in the middle of the screen when 1 minuteLeft."
L["Show a raid warning style msg in the middle of the screen when 10 minutesLeft."] = "Show a raid warning style msg in the middle of the screen when 10 minutesLeft."
L["Show a raid warning style msg in the middle of the screen when 15 minutesLeft."] = "Show a raid warning style msg in the middle of the screen when 15 minutesLeft."
L["Show a raid warning style msg in the middle of the screen when 5 minutesLeft."] = "Show a raid warning style msg in the middle of the screen when 5 minutesLeft."
L["Show a raid warning style msg in the middle of the screen when a buff has reset and a new one can be dropped."] = "Show a raid warning style msg in the middle of the screen when a buff has reset and a new one can be dropped."
L["Show a raid warning style msg in the middle of the screen when someone hands in the head for any buff and the "] = "Show a raid warning style msg in the middle of the screen when someone hands in the head for any buff and the "
L["Show a time stamp (1:23pm) beside the timer msg?"] = "Show a time stamp (1:23pm) beside the timer msg?"
L["Show all alts in the /buffs window even if they don't have an active buff?"] = "Show all alts in the /buffs window even if they don't have an active buff?"
L["Show Darkmoon Faire buff 5 hour cooldown, this will only show when you have an ative cooldown and when DMF is up."] = "Show Darkmoon Faire buff 5 hour cooldown, this will only show when you have an ative cooldown and when DMF is up."
L["Show Darkmoon Faire spawn time, this will only show when there isLess than 6 hours Left until spawn or despawn."] = "Show Darkmoon Faire spawn time, this will only show when there isLess than 6 hours Left until spawn or despawn."
L["Show DMF map marker with spawn timer and buff cooldown info in Mulgore and Elwynn Forest "] = "Show DMF map marker with spawn timer and buff cooldown info in Mulgore and Elwynn Forest "
L["Show DMF spawn timer atLogon always, even if it's not close to spawn."] = "Show DMF spawn timer atLogon always, even if it's not close to spawn."
L["Show DMF spawn timer atLogon and together with /wb command when it's within 12 hours of spawn or despawn."] = "Show DMF spawn timer atLogon and together with /wb command when it's within 12 hours of spawn or despawn."
L["Show DMF spawn timer together with /wb command?"] = "Show DMF spawn timer together with /wb command?"
L["Show DMF spawn timer together with /wb command?"] = "Show DMF spawn timer together with /wb command?"
L["Show Nefarian timer in the chat window when youLog on."] = "Show Nefarian timer in the chat window when youLog on."
L["Show Night Dragon's Breath icons on the mini map?."] = "Show Night Dragon's Breath icons on the mini map?."
L["Show Night Dragon's Breath icons on the world map?."] = "Show Night Dragon's Breath icons on the world map?."
L["Show Onyxia timer in the chat window when youLog on."] = "Show Onyxia timer in the chat window when youLog on."
L["Show Rend timer in the chat window when youLog on."] = "Show Rend timer in the chat window when youLog on."
L["Show songflower icons on the mini map?."] = "Show songflower icons on the mini map?."
L["Show songflower icons on the world map?."] = "Show songflower icons on the world map?."
L["Show theLittle frame on the minimap with your currentLayer while in a capital city?"] = "Show theLittle frame on the minimap with your currentLayer while in a capital city?";
L["Show timer icons on the Orgrimmar/Stormwind world map?"] = "Show timer icons on the Orgrimmar/Stormwind world map?"
L["Show Whipper Root Tuber icons on the mini map?."] = "Show Whipper Root Tuber icons on the mini map?."
L["Show Whipper Root Tuber icons on the world map?."] = "Show Whipper Root Tuber icons on the world map?."
L["Show your current world buffs for all your characters, this can also be opened by typing /buffs or clicking "] = "Show your current world buffs for all your characters, this can also be opened by typing /buffs or clicking "
L["Show your DMF buff cooldown timer together with /wb command? Only shows when you are on an active cooldown"] = "Show your DMF buff cooldown timer together with /wb command? Only shows when you are on an active cooldown"
L["Sound to play for 1 minuteLeft timer warning."] = "Sound to play for 1 minuteLeft timer warning."
L["Sound to play for Nefarian buff drops and you get the buff."] = "Sound to play for Nefarian buff drops and you get the buff."
L["Sound to play for Onyxia buff drops and you get the buff."] = "Sound to play for Onyxia buff drops and you get the buff."
L["Sound to play for Rend buff drops and you get the buff."] = "Sound to play for Rend buff drops and you get the buff."
L["Sound to play for Zandalar buff drops and you get the buff."] = "Sound to play for Zandalar buff drops and you get the buff."
L["Sound to play when head is handed in and you have a few seconds before buff will drop (First NPC Yell)."] = "Sound to play when head is handed in and you have a few seconds before buff will drop (First NPC Yell)."
L["Tell your guild chat when you have picked a songflower with the time of next spawn?"] = "Tell your guild chat when you have picked a songflower with the time of next spawn?"
L["This will make it so you don't get timer data from anyone outside the guild. You should only enable this "] = "This will make it so you don't get timer data from anyone outside the guild. You should only enable this "
L["This will show you in chat window when a new flower timer is found from another player not in your guild "] = "This will show you in chat window when a new flower timer is found from another player not in your guild "
L["UseLocal time or server time for timestamps?"] = "UseLocal time or server time for timestamps?"
L["What color should the raid warning style msgs in the middle of the screen be?"] = "What color should the raid warning style msgs in the middle of the screen be?"
L["What color should the timer msgs in chat be?"] = "What color should the timer msgs in chat be?"
L[" (guild msgs already show in guild chat when a flower is picked)."] = " (guild msgs already show in guild chat when a flower is picked)."
L[" and DMF is currently up."] = " and DMF is currently up."
L["data outside the guild but keep worldbuff data guild only still."] = "data outside the guild but keep worldbuff data guild only still."
L["for this buff then everyone in guild needs to disable this)."] = "for this buff then everyone in guild needs to disable this)."
L["just incase you have problems with false timers being set from other players. There's currently "] = "just incase you have problems with false timers being set from other players. There's currently "
L["no way to tell if another players buff is new so a timer may trigger on rare occasions if the gameLoads "] = "no way to tell if another players buff is new so a timer may trigger on rare occasions if the gameLoads "
L["the guild with the addon should enable it or guild chat msgs may not work properly (personal timer msgs will still work)."] = "the guild with the addon should enable it or guild chat msgs may not work properly (personal timer msgs will still work).";
L["the songflower buff on someone else when theyLogon infront of you beside a songflower."] = "the songflower buff on someone else when theyLogon infront of you beside a songflower."
L["world maps (whichever is next spawn). You can also type /dmf map to open the world map strait to this marker."] = "world maps (whichever is next spawn). You can also type /dmf map to open the world map strait to this marker."
L["if you really want to disable all guild msgs andLeave only this command then untick everything else in the "] = "if you really want to disable all guild msgs andLeave only this command then untick everything else in the "
L["guild sectionand don't tick the Disable All Guild Msgs at the top."] = "guild sectionand don't tick the Disable All Guild Msgs at the top."
L["if you think someone is spoofing wrong timer data on purpose because it willLower the accuracy of your timers "] = "if you think someone is spoofing wrong timer data on purpose because it willLower the accuracy of your timers "
L["withLess people to pull data from. It will make it especially hard to get songflower timers becaus "] = "withLess people to pull data from. It will make it especially hard to get songflower timers becaus "
L["they are so short."] = "they are so short."
L["all your characters current world buffs."] = "all your characters current world buffs."
L["and when a head is handed in a few seconds before buff drops."] = "and when a head is handed in a few seconds before buff drops."
L["justLeave certain things enabled such as the !wb command to help out your guild if you rather."] = "justLeave certain things enabled such as the !wb command to help out your guild if you rather."
L["on the [WorldBuffs] prefix in chat."] = "on the [WorldBuffs prefix in chat."
L["1 Minute"] = "1分钟"
L["10 Minutes"] = "10分钟"
L["15 Minutes"] = "15分钟"
L["30 Minutes"] = "30分钟"
L["5 Minutes"] = "5分钟"
L["Buff Coming"] = "世界Buff即将降临"
L["Buff Drop Warning"] = "Buff释放提示"
L["Buff Has Reset"] = "Buff已重置"
L["Chat Msg Color"] = "聊天信息颜色"
L["Chat Window Timer Warnings"] = "聊天窗口信息提示"
L["City Map Timers"] = "城市计时器"
L["Click To Show Your Current World Buffs"] = "点击显示你的当前世界Buff情况"
L["Colored Prefix Link"] = "彩色信息前缀"
L["Darkmoon Faire"] = "暗月马戏团"
L["Disable All Sounds"] = "禁止所有提示音"
L["Disable Guild Msgs"] = "禁止公会频道提示"
L["Disable In Instances"] = "副本中禁止提示"
L["DMF Buff Cooldown /wb"] = "查看暗月Buff CD"
L["DMF Buff Coooldown"] = "暗月Buff冷却"
L["NPC yells a few seconds before the buff will drop."] = "NPC大喊后将提供Buff。"
L["DMF Spawn with /wb"] = "查看马戏团位置"
L["DMF Spawn"] = "暗月马戏团"
L["Dragon Minimap"] = "小地图夜龙之息"
L["Dragon Worldmap"] = "大地图夜龙之息"
L["Enable Alliance Rend"] = "启用联盟雷德提示"
L["Extra Sound Options"] = "额外声音选项"
L["Filter !wb command"] = "过滤!wb命令"
L["Filter !wb reply"] = "过滤!wb回应"
L["Filter Buff Dropped"] = "过滤Buff获取"
L["Filter Buff Warning"] = "过滤Buff提示"
L["Filter NPC Killed"] = "过滤NPC死亡"
L["Filter Songflowers"] = "过滤轻歌花"
L["Filter Timer Msgs"] = "计时器信息"
L["Flash Minimized"] = "最小化闪光"
L["General Options"] = "基本设置"
L["Guild Chat Filter"] = "公会信息过滤器"
L["Guild Commands"] = "公会命令"
L["Guild Data Only"] = "只信任公会信息"
L["Guild Message Timer Warnings"] = "公会信息计时提示"
L["Local Time / Server Time"] = "本地时间/服务器时间"
L["Logon Messages"] = "登录信息"
L["Logon Timers"] = "登录计时器"
L["Middle Of The Screen Timer Warnings"] = "屏幕提示计时器"
L["Middle Screen Color"] = "屏幕提示颜色"
L["Nef Buff Gained"] = "获得奈法利安Buff"
L["Nefarian"] = "奈法利安"
L["New Buff Dropped"] = "新Buff释放"
L["NPC Dialogue Started"] = "NPC对话开始"
L["NPC Was Killed"] = "NPC被杀死"
L["One Minute Warning"] = "一分钟提示"
L["Only In City"] = "仅在城市"
L["Only When I Pick"] = "仅当我拾取时"
L["Ony Buff Gained"] = "获得奥妮克希亚Buff"
L["Onyxia"] = "奥妮克希亚"
L["Rend Buff Gained"] = "获得雷德Buff"
L["Rend"] = "雷德"
L["Reset Colors"] = "重置颜色"
L["Reset Minimap Layer"] = "还原位面提示窗"
L["Show All Alts"] = "显示所有角色"
L["Show Always Logon"] = "Show AlwaysLogon"
L["Show Close To Spawn"] = "Show Close To Spawn"
L["Show DMF with /wb"] = "在/wb中显示暗月马戏团"
L["Show Map Marker"] = "显示地图标记"
L["Show Minimap Layer"] = "显示位面提示窗"
L["Show New SF Timers"] = "显示轻歌花计时器"
L["Show Time Stamp"] = "显示时间戳"
L["Songflower Minimap"] = "小地图轻歌花"
L["Songflower Worldmap"] = "大地图轻歌花"
L["Songflowers"] = "费伍德植物"
L["Sounds"] = "声音"
L["Sync Flowers With All"] = "同步拾取信息"
L["Tell Guild When Picked"] = "公会通告拾取"
L["Time Stamp Format"] = "时间戳格式"
L["Tuber Minimap"] = "小地图鞭根块茎"
L["Tuber Worldmap"] = "大地图鞭根块茎"
L["Zandalar Buff Gained"] = "获取赞达拉之魂"
L["Zandalar Buff Warning"] = "赞达拉之魂通告"

L["Scroll down for more options."] = "向下滚动查看更多设置选项。"
L["Type /wb <channel> to display timers to the specified channel.\n"] = "输入/wb <channel> 在指定频道<channel>通告你的计时信息。\n"
L["Type /wb to display timers to yourself.\n"] = "输入/wb 显示你的Buff计时信息。\n"

L["Target a NPC to\nupdate your layer"] = "选择一个NPC\n更新位面信息"
L["Layer "] = "位面"
L["No Layer"] = "未知位面"
L["|cFFFFFF00Guild versions seen since logon|r"] = "|cFFFFFF00登录后查看公会版本|r"
L["Hold to drag"] = "按住移动"

L["12 hour"] = "12小时制"
L["24 hour"] = "24小时制"
L["Local Time"] = "本地时间"
L["Server Time"] = "服务器时间"

L["Buffs"] = "世界Buff"
L["Layer Map"] = "位面"

L["|cFF9CD6DETarget any NPC in Orgrimmar to see your current layer.|r"] = "|cFF9CD6DE点击任意NPC获取奥格瑞玛位面信息。|r"
L["|cFF9CD6DETarget any NPC in Stormwind to see your current layer.|r"] = "|cFF9CD6DE点击任意NPC获取暴风城位面信息。|r"
L["|cFF9CD6DEYou are currently on |cff00ff00[Layer "] = "|cFF9CD6DE你正在|cff00ff00[位面 "
L["|cff00ff00[Layer "] = "|cff00ff00[位面"
L["\n|cff00ff00[Layer "] = "\n|cff00ff00[位面"
L["]|r  |cFF989898(zone "] = "]|r  |cFF989898(区域"
L["|cFF9CD6DECan't find current layer or no timers active for this layer.|r"] = "|cFF9CD6DE未找到位面信息，或当前位面没有计时器。|r"
L["|cffFFFF00No zones have been mapped yet since server restart.\n"] = "|cffFFFF00服务器重启后尚未获取位面信息。\n"
L["|cffFFFF00You have no guild, this command shows guild members only.\n"] = "|cffFFFF00你没有公会，这个命令仅显示公会成员。\n"
L["|cFF9CD6DETarget any NPC to see your current layer.|r"] = "|cFF9CD6DE点击任意NPC显示你的位面信息。|r"
L["|cFFFFFF00Layer Mapping for "] = "|cFFFFFF00位面信息："

L["Layer 1"] = "位面1"
L["|Cff00ff00Darkmoon Faire"] = "|Cff00ff00暗月马戏团"
L["Timers"] = "计时器"

L["|cFFDEDE42Layers may be inaccurate for a few hours after server restarts.\n"] = "|cFFDEDE42位面将在服务器重启数小时内生成。\n"
L["Layers will disappear from here 6 hours after having no timers."] = "位面在6小时无活动信息时将被销毁。"

L["Out of date version "] = "已过期版本"
L[" (New version: "] = "（新版本："
L[")\nPlease update so your timers are accurate."] = "）\n请更新NWB插件。"

L["|HNWBCustomLink:timers|hYou are on a layered realm.|h"] = "|HNWBCustomLink:timers|h你的服务器存在位面。|h"
L["|HNWBCustomLink:timers|hClick here to view current timers.|h"] = "|HNWBCustomLink:timers|h点击查看当前计时器信息。|h"

L["(No layers found)"] = "（没有找到位面）"
L["That layer wasn't found or has no valid timers."] = "未找到位面，或没有有效的计时信息。"

L["(Onyxia: NPC (Runthak) was killed "] = "（奥妮克希亚：伦萨克已死亡"
L["(Onyxia: NPC (Mattingly) was killed "] = "（奥妮克希亚：玛丁雷已死亡"
L["(Nefarian: NPC (Saurfang) was killed "] = "（奈法利安：萨鲁法尔已死亡"
L["(Nefarian: NPC (Afrasiabi) was killed "] = "（奈法利安：艾法希比已死亡"
L[" ago no buff recorded since) "] = "，至今无Buff释放记录）"

L[" (Layer "] = "(位面"
L[" of "] = "/"
L[" (Layer 1 of "] = "(位面1/"

L["|cFFFF5100|HNWBCustomLink:buffs|h[WorldBuffs]|h|r"] = "|cFFFF5100|HNWBCustomLink:buffs|h[WorldBuffs]|h|r"
L["|cFFFF5100|HNWBCustomLink:buffs|h[NovaWorldBuffs]|h|r"] = "|cFFFF5100|HNWBCustomLink:buffs|h[NovaWorldBuffs]|h|r"
L["|cFFFF5100|HNWBCustomLink:buffs|h[DMF]|h|r"] = "|cFFFF5100|HNWBCustomLink:buffs|h[DMF]|h|r"
L["|HNWBCustomLink:buffs|h[WorldBuffs]|h"] = "|HNWBCustomLink:buffs|h[WorldBuffs]|h"
L["|HNWBCustomLink:buffs|h[NovaWorldBuffs]|h"] = "|HNWBCustomLink:buffs|h[NovaWorldBuffs]|h"
L["|HNWBCustomLink:buffs|h[DMF]|h"] = "|HNWBCustomLink:buffs|h[DMF]|h"
L[" |HNWBCustomLink:timers|h%1|h"] = " |HNWBCustomLink:timers|h%1|h"

L["No whisper target found."] = "没有找到密语对象。"

L["|cFFFFFF00No channel with id |cFFFF5100"] = "|cFFFFFF00ID：|cFFFF5100"
L["|cFFFFFF00No channel with name |cFFFF5100"] = "|cFFFFFF00名称：|cFFFF5100"
L[" |cFFFFFF00exists."] = " |cFFFFFF00频道不存在。"
L["|cFFFFFF00Type \"/wb\" to print world buff timers to yourself."] = "|cFFFFFF00输入\"/wb\" 提示自身Buff信息。"
L["|cFFFFFF00Type \"/wb config\" to open options."] = "|cFFFFFF00输入\"/wb config\" 开启设置窗口。"
L["|cFFFFFF00Type \"/wb guild\" to post buff timers to the specified chat channel (accepts channel names and numbers)."] = "|cFFFFFF00输入\"/wb guild\" 将Buff信息通告至目标频道(频道序号或者频道名称均可)。"
L["|cFFFFFF00Use \"/sf\" in the same way for songflowers."] = "|cFFFFFF00使用\"/sf\" 提示费伍德植物信息。"
L["|cFFFFFF00Type \"/dmf\" for your Darkmoon Faire buff cooldown."] = "|cFFFFFF00输入\"/dmf\" 查看暗月马戏团Buff情况。"
L["|cFFFFFF00Type \"/buffs\" to view all your alts world buffs."] = "|cFFFFFF00输入\"/buffs\" 查看所有角色世界Buff信息。"
L["|cFFFFFF00Type \"/wb\" to  world buff timers to yourself."] = "|cFFFFFF00输入\"/wb\" 显示自身世界Buff信息。"

L["|cff00ff00[Layer "] = "|cff00ff00[位面"

L["|cffffff00No characters with buffs found."] = "|cffffff00未找到拥有世界Buff的角色。"
L["Buff records have been reset."] = "Buff记录已被重置。"

L["|CffDEDE42Set sound to \"None\" to disable."] = "|CffDEDE42选择\"None\"禁用声音提示。"
L["|CffDEDE42This will block any guild msgs from this addon you choose so you don't see them. It will stop "] = "|CffDEDE42这些选项决定需要过滤的公会提示信息类别。一旦选择，你将无法看到自己或公会其他成员发出的该类型信息。"
L["you from seeing your own msgs and msgs from other addon users in guild chat."] = ""
L["|CffDEDE42Your DMF damage buff cooldown will also show on the Darkmoon Faire map icon when you hover it, if you"] = "|CffDEDE42如果暗月马戏团存在且Buff CD已到，你可以获取的暗月马戏团伤害Buff也将在在地图上显示。"
L[" have a cooldown and DMF is currently up."] = ""
L["Send a message to guild when a new buff has been dropped? This msg is sent after the NPC is finished yelling "] = "当有世界Buff降临时发出公会通告。这个通告将在NPC大叫后发出，用于提示几秒后实际获取Buff。(6秒后释放雷德Buff，14秒后释放奥妮克希亚Buff，15秒后奈法利安Buff）"
L[" and you get the actual buff a few secondsLater. (6 seconds after first yell for rend, 14 seconds for ony, "] = ""
L[" 15 seconds for nef)"] = ""

L["Show Expired Timers"] = "Show Expired Timers"
L["Show expired timers in Felwood? They will be shown in red text how long ago a timer expired, the default "] = "Show expired timers in Felwood? They will be shown in red text how long ago a timer expired, the default "
L["time is 5 minutes (people say songflowers stay cleansed for 5 minutes after spawn?)."] = "time is 5 minutes (people say songflowers stay cleansed for 5 minutes after spawn?)."
L["Expired Timers Duraton"] = "Expired Timers Duraton"
L["How long should Felwood timers show for after expiring on the world map?"] = "How long should Felwood timers show for after expiring on the world map?"

L["You are on a layered realm."] = "你在一个有位面的服务器。"
L["Click here to view current timers."] = "点击此链接获取计时器信息。"

L["  -|cffFFFF00No zones mapped for this layer yet.\n"] = " -|cffFFFF00没有区域被记录在此位面。\n"
L["]|r  |cff9CD6DE(Orgrimmar "] = "]|r |cff9CD6DE(奥格瑞玛"
L["]|r  |cff9CD6DE(Stormwind "] = "]|r |cff9CD6DE(暴风城"
L[" zones mapped)|r\n"] = "区域已记录"

L["|cFFFFFF00Looking for layered timers to convert."] = "|cFFFFFF00寻找可以转换的位面计时器。"
L["|cFFFFFF00Found current Rend timer, converting."] = "|cFFFFFF00找到雷德计时器，转换中。"
L["|cFFFFFF00Found current Onyxia timer, converting."] = "|cFFFFFF00找到奥妮克希亚计时器，转换中。"
L["|cFFFFFF00Found current Nefarian timer, converting."] = "|cFFFFFF00找到奈法利安计时器，转换中。"
L["|cFFFFFF00Done."] = "|cFFFFFF00完成。"
L["|cFFFFFF00Done, found no timers on old layer 1."] = "|cFFFFFF00完成，没有在老位面1上找到计时器。"

L["Got rend buff but no layer ID was found."] = "已获得雷德Buff但未能找到位面ID。"

L["|cFF9CD6DELeft-Click|r Timers"] = "|cFF9CD6DE左键|r 计时器"
L["|cFF9CD6DERight-Click|r Buffs"] = "|cFF9CD6DE右键|r Buff情况"
L["|cFF9CD6DEShift Left-Click|r Felwood Map"] = "|cFF9CD6DEShift+左键|r 费伍德地图"
L["|cFF9CD6DEShift Right-Click|r Config"] = "|cFF9CD6DEShift+右键|r 设置"

L["Show Minimap Button"] = "显示小地图按钮"
L["Show the NWB button the minimap?"] = "在小地图旁显示NWB按钮"

L["\n -All NWB guild msgs disabled (#nwb1)."] = "\n -公会频道禁止所有NWB信息(#nwb1)."
L["\n -Timer guild msgs disabled (#nwb2)."] = "\n -公会频道禁止通报计时器(#nwb2)."
L["\n -Buff dropped guild msgs disabled (#nwb3)."] = "\n -公会频道禁止Buff释放信息(#nwb3)."
L["\n -!wb guild command disabled (#nwb4)."] = "\n -禁止!wb公会命令(#nwb4)."
L["\n -Songflower guild msgs disabled (#nwb5)."] = "\n -公会频道禁止轻歌花信息(#nwb5)."

L["Hide In Combat"] = "战斗中隐藏"
L["Hide middle of the screen warnings in combat?"] = "战斗中隐藏屏幕中间的提示。"

L["Hide In Raid"] = "Raid中隐藏"
L["Hide middle of the screen warnings in raid instances? (Doesn't hide in normal dungeons)"] = "处于Raid副本中时隐藏屏幕中间的提示（普通副本不隐藏）。"

L["Flash When Minimized"] = "闪动WOW图标"

L["Flash One Minute"] = "一分钟倒计时"
L["Flash the wow client when you have it minimized and 1 minute is left on timer?"] = "在倒计时一分钟时闪动任务栏WOW图标。"

L["Flash NPC Yell"] = "NPC大喊时"
L["Flash the wow client when you have it minimized and the NPC's out a few seconds before buff drops?"] = "在NPC大喊时闪动任务栏WOW图标。"
L["Flash Zandalar"] = "赞达拉Buff"
L["Flash the wow client when you have it minimized and the Zandalar buff is about to go out?"] = "在赞达拉Buff即将释放时闪动任务栏WOW图标。"

