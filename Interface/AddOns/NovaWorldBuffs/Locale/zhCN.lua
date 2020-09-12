local L = LibStub("AceLocale-3.0"):NewLocale("NovaWorldBuffs", "zhCN");
if (not L) then
	return;
end
--由国服[寒脊山小径]服务器“新春快乐”汉化（Simplified Chinese localization by "新春快乐" from Coldridge Pass-CN）
--Rend buff aura name.
L["Warchief's Blessing"] = "酋长的祝福";
--Onyxia and Nefarian buff aura name.
L["Rallying Cry of the Dragonslayer"] = "屠龙者的咆哮";
--Songflower buff aura name from felwood.
L["Songflower Serenade"] = "风歌夜曲";
L["Songflower"] = "轻歌花";

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

L["onyxiaNpcKilledHorde"] = "伦萨克 刚刚被杀死了。 (奥妮克希亚 buff NPC)。";
L["onyxiaNpcKilledAlliance"] = "玛丁雷少校 刚刚被杀死了。 (奥妮克希亚 buff NPC)。";
L["nefarianNpcKilledHorde"] = "萨鲁法尔大王 刚刚被杀死了。 (奈法利安 buff NPC)。";
L["nefarianNpcKilledAlliance"] = "艾法希比元帅 刚刚被杀死了 (奈法利安 buff NPC)。";
L["onyxiaNpcKilledHordeWithTimer"] = "奥妮克希亚 NPC (伦萨克) 已于 %s 前被击杀，之后没有buff记录。";
L["nefarianNpcKilledHordeWithTimer"] = "奈法利安 NPC (萨鲁法尔大王) 已于 %s 前被击杀，之后没有buff记录。";
L["onyxiaNpcKilledAllianceWithTimer"] = "奥妮克希亚 NPC (玛丁雷少校) 已于 %s 前被击杀，之后没有buff记录。";
L["nefarianNpcKilledAllianceWithTimer"] = "奈法利安 NPC (艾法希比元帅) 已于 %s 前被击杀，之后没有buff记录。";
L["anyNpcKilledWithTimer"] = "NPC 已于 %s 前被击杀"; --Map timers tooltip msg.


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
L["dmfBuffCooldownMsg"] = "你的暗月马戏团buff冷却时间还剩 %s 。";
L["dmfBuffCooldownMsg2"] = "你的暗月马戏团buff冷却时间还剩 %s 。";
L["dmfBuffCooldownMsg3"] = "暗夜马戏团buff的冷却时间也会随着每周的服务器重启而重置。"; --/wb frame 2nd msg.
L["dmfBuffReady"] = "你的暗月马戏团buff冷却时间已结束。"; --These 2 buff msgs are slightly different for a reason.
L["dmfBuffReset"] = "您的暗月马戏团buff冷却时间已重置。"; --These 2 buff msgs are slightly different for a reason.
L["dmfBuffDropped"] = "暗月马戏团 buff %s 已获得，输入/buffs来查看该buff在游戏内4小时的冷却剩余时间。";
L["dmfSpawns"] = "暗月马戏团将于 %s 后 (%s) 刷新于";
L["dmfEnds"] = "暗月马戏团将于 %s 后 (%s) 结束";
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
L["noActiveTimers"] = "没有激活计时"; --No active timers
L["newBuffCanBeDropped"] = "现在可以取得一个新的 %s buff";
L["buffResetsIn"] = "%s 将于 %s 后重置。";
L["rendFirstYellMsg"] = "雷德·黑手Buff将于 6 秒后释放。";
L["onyxiaFirstYellMsg"] = "奥妮克希亚Buff将于 14 秒后释放。";
L["nefarianFirstYellMsg"] = "奈法利安Buff将于 15 秒后释放。";
L["rendBuffDropped"] = "酋长的祝福Buff(雷德·黑手) 已经释放。";
L["onyxiaBuffDropped"] = "屠龙者的咆哮Buff（奥妮克希亚）已经释放。";
L["nefarianBuffDropped"] = "屠龙者的咆哮Buff（奈法利安）已经释放。";
L["onyxiaNpcKilledHorde"] = "伦萨克 刚刚被杀死了。(奥妮克希亚 buff NPC)。";
L["onyxiaNpcKilledAlliance"] = "玛丁雷少校 刚刚被杀死了。(奥妮克希亚 buff NPC)。";
L["nefarianNpcKilledHorde"] = "萨鲁法尔大王 刚刚被杀死了。(奈法利安 buff NPC)。";
L["nefarianNpcKilledAlliance"] = "艾法希比元帅 刚刚被杀死了。(奈法利安 buff NPC)。";
L["newSongflowerReceived"] = "收到新的轻歌花计时"; --New songflower timer received
L["songflowerPicked"] = "轻歌花在 %s 被拾取，将于25分钟后刷新。"; -- Guild msg when songflower picked.
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
L["hour"] = "小时"; --Hour (singular).
L["hours"] = "小时"; --Hours (plural).
L["day"] = "天"; --Day (singular).
L["days"] = "天"; --Days (plural).
L["secondShort"] = "秒"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "分"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "小时"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "天"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "将于 %s 后开始"; --"Starts in 1hour".
L["endsIn"] = "将于 %s 后结束"; --"Ends in 1hour".
L["versionOutOfDate"] = "Nova World Buffs 插件已过期，请前往 https://www.curseforge.com/wow/addons/nova-world-buffs 或在 twitch 上更新。";
L["Your Current World Buffs"] = "当前的世界Buffs";
L["Options"] = "设置";

---New stuff---

--Spirit of Zandalar buff NPC first yell string (part of his first yell msg before before buff).
L["Begin the ritual"] = "开始仪式";
L["The Blood God"] = "夺灵者已经被打败了"; --First Booty bay yell from Zandalarian Emissary.
--Spirit of Zandalar buff NPC second yell string (part of his second yell msg before before buff).
L["slayer of Hakkar"] = "向你致敬";

L["Spirit of Zandalar"] = "赞达拉之魂";
L["Molthor"] = "莫托尔";
L["Zandalarian Emissary"] = "赞达拉大使";
L["Whipper Root Tuber"] = "鞭根块茎";
L["Night Dragon's Breath"] = "夜龙之息";
L["Resist Fire"] = "抵抗火焰"; -- LBRS fire resist buff.
L["Blessing of Blackfathom"] = "黑暗深渊的祝福";

L["zan"] = "赞达拉";
L["zanFirstYellMsg"] = "赞达拉之魂Buff将于 30 秒后释放。";
L["zanBuffDropped"] = "赞达拉之魂Buff(哈卡)已经释放。";
L["singleSongflowerMsg"] = "位于 %s 的轻歌花将于 %s 后刷新。"; -- Songflower at Bloodvenom Post spawns at 1pm.
L["spawn"] = "刷新"; --Used in Felwood map marker tooltip (03:46pm spawn).
L["Irontree Woods"] = "铁木森林";
L["West of Irontree Woods"] = "铁木森林西部";
L["Bloodvenom Falls"] = "血毒瀑布";
L["Jaedenar"] = "加德纳尔";
L["North-West of Irontree Woods"] = "铁木森林西北部";
L["South of Irontree Woods"] = "铁木森林南部";

L["worldMapBuffsMsg"] = "输入/buffs来查看你所有的\n角色已获得的世界Buffs。";
L["cityMapLayerMsgHorde"] = "当前位于 %s\n选中奥格瑞玛的任何NPC\n来更新你的位面信息。\n（在切换地区后）|r";
L["cityMapLayerMsgAlliance"] = "当前位于 %s\n选中暴风城的任何NPC\n来更新你的位面信息。\n（在切换地区后）|r";
L["noLayerYetHorde"] = "请选定奥格瑞玛的任何NPC\n来确认你当前所在的位面。";
L["noLayerYetAlliance"] = "请选定暴风城的任何NPC\n来确认你当前所在的位面。";
L["Reset Data"] = "重置数据"; --A button to Reset buffs window data.

---New translations to do---
L["layerFrameMsgOne"] = "服务器重启后，以前的位面仍会显示几个小时。"; --Msg at bottom of layer timers frame.
L["layerFrameMsgTwo"] = "如果一个位面在6个小时后仍没有计时信息，则该位面将从此处消失。"; --Msg at bottom of layer timers frame.
L["You are currently on"] = "你当前位于"; --You are currently on [Layer 2]


-------------
---Config---
-------------
--There are 2 types of strings here, the names end in Title or Desc L["exampleTitle"] and L["exampleDesc"].
--Title must not be any longer than 21 characters (maybe less for chinese characters because they are larger).
--Desc can be any length.

---Description at the top---
L["mainTextDesc"] = "输入/wb显示自己的buff计时器。\n输入/wb <频道名> 发送buff计时信息到指定频道。\n下拉进行更多设置。";

---Show Buffs Button
L["showBuffsTitle"] = "点此显示你当前的世界BUFF";
L["showBuffsDesc"] = "显示你所有角色的当前世界Buff，可以输入/buffs或者点击聊天频道的[WorldBuffs]链接打开显示界面。";

---General Options---
L["generalHeaderDesc"] = "通用设置";

L["showWorldMapMarkersTitle"] = "主城地图计时器";
L["showWorldMapMarkersDesc"] = "在奥格和暴风城地图上显示计时器图标。";

L["receiveGuildDataOnlyTitle"] = "仅限公会数据";
L["receiveGuildDataOnlyDesc"] = "这将导致你无法从公会外的玩家获取buff数据信息。仅当你认为有人故意提供错误的计时数据时，才应勾选该选项。因为减少了提供数据玩家的数量，将会降低计时器的准确性。还会导致你很难获得风歌花计时数据，因为风歌花的计时太短，并且公会中的每个玩家都要勾选此选项才能使该功能正常工作。";

L["chatColorTitle"] = "聊天频道信息颜色";
L["chatColorDesc"] = "选择[WorldBuffs]计时器信息在聊天频道中的颜色。";

L["middleColorTitle"] = "屏幕中央信息颜色";
L["middleColorDesc"] = "选择屏幕中央的提示信息的颜色。";

L["resetColorsTitle"] = "重置颜色";
L["resetColorsDesc"] = "将颜色重置为默认。";

L["showTimeStampTitle"] = "显示时间戳";
L["showTimeStampDesc"] = "在计时器信息中显示一个时间戳(1:23pm)。";

L["timeStampFormatTitle"] = "时间戳格式";
L["timeStampFormatDesc"] = "设置时间戳格式，12小时制(1:23pm)或24小时制(13:23)。";

L["timeStampZoneTitle"] = "本地时间/服务器时间";
L["timeStampZoneDesc"] = "时间戳使用本地时间还是服务器时间。";

L["colorizePrefixLinksTitle"] = "彩色前缀链接";
L["colorizePrefixLinksDesc"] = "将聊天频道[WorldBuffs]前缀链接着色。这个前缀会出现在聊天频道中，可点击显示你所有角色当前的世界BUFF计时。";

L["showAllAltsTitle"] = "显示所有小号";
L["showAllAltsDesc"] = "在/buffs窗口中显示你的小号，即使他们没有获得任何buff。";

L["minimapButtonTitle"] = "显示小地图按钮";
L["minimapButtonDesc"] = "在小地图上显示NWB按钮。";

---Logon Messages---
L["logonHeaderDesc"] = "登录提示信息";

L["logonPrintTitle"] = "登录计时器";
L["logonPrintDesc"] = "当你登录游戏时在聊天窗口中显示计时器，可以通过该设置来关闭所有登录提示信息。";

L["logonRendTitle"] = "雷德·黑手";
L["logonRendDesc"] = "登录时在聊天窗口中显示雷德·黑手计时器。";

L["logonOnyTitle"] = "奥妮克希亚";
L["logonOnyDesc"] = "登录时在聊天窗口中显示奥妮克希亚计时器。";

L["logonNefTitle"] = "奈法利安";
L["logonNefDesc"] = "登录时在聊天窗口中显示奈法利安计时器。";

L["logonDmfSpawnTitle"] = "暗月马戏团刷新";
L["logonDmfSpawnDesc"] = "显示暗月马戏团刷新时间，只有在马戏团将于6小时内刷新/消失时才会显示。";

L["logonDmfBuffCooldownTitle"] = "暗月马戏团Buff冷却";
L["logonDmfBuffCooldownDesc"] = "显示马戏团BUFF 4小时的冷却，只有暗月马戏团存在且你有马戏团BUFF时才显示。";

---Chat Window Timer Warnings---
L["chatWarningHeaderDesc"] = "聊天频道计时信息提示";

L["chat30Title"] = "30分钟";
L["chat30Desc"] = "重置时间剩余30分钟时，在聊天频道中发送一条提示信息。";

L["chat15Title"] = "15分钟";
L["chat15Desc"] = "重置时间剩余15分钟时，在聊天频道中发送一条提示信息。";

L["chat10Title"] = "10分钟";
L["chat10Desc"] = "重置时间剩余10分钟时，在聊天频道中发送一条提示信息。";

L["chat5Title"] = "5分钟";
L["chat5Desc"] = "重置时间剩余5分钟时，在聊天频道中发送一条提示信息。";

L["chat1Title"] = "1分钟";
L["chat1Desc"] = "重置时间剩余1分钟时，在聊天频道中发送一条提示信息。";

L["chatResetTitle"] = "Buff已重置提示";
L["chatResetDesc"] = "当buff已重置且可以获得新buff时，在聊天频道中发送一条提示信息。";

L["chatZanTitle"] = "赞达拉Buff提示";
L["chatZanDesc"] = "在赞达拉NPC开始大喊，给予buff前30秒时，在聊天频道中发送一条提示信息。";

---Middle Of The Screen Timer Warnings---
L["middleWarningHeaderDesc"] = "屏幕中央计时信息提示";

L["middle30Title"] = "30 分钟";
L["middle30Desc"] = "重置时间剩余30分钟时，在屏幕中央发送一条团队警报样式的提示信息。";

L["middle15Title"] = "15分钟";
L["middle15Desc"] = "重置时间剩余15分钟时，在屏幕中央发送一条团队警报样式的提示信息。";

L["middle10Title"] = "10分钟";
L["middle10Desc"] = "重置时间剩余10分钟时，在屏幕中央发送一条团队警报样式的提示信息。";

L["middle5Title"] = "5分钟";
L["middle5Desc"] = "重置时间剩余5分钟时，在屏幕中央发送一条团队警报样式的提示信息。";

L["middle1Title"] = "1分钟";
L["middle1Desc"] = "重置时间剩余1分钟时，在屏幕中央发送一条团队警报样式的提示信息。";

L["middleResetTitle"] = "Buff已重置提示";
L["middleResetDesc"] = "当buff已重置且可以获得新buff时，在屏幕中央发送一条团队警报样式的提示信息。";

L["middleBuffWarningTitle"] = "Buff释放提示";
L["middleBuffWarningDesc"] = "当玩家已完成任何世界buff任务，NPC开始大喊，buff即将在几秒后释放时，在屏幕中央发送一条团队警报样式的提示信息。";

L["middleHideCombatTitle"] = "战斗中隐藏提示信息";
L["middleHideCombatDesc"] = "当在战斗中时，隐藏屏幕中央的提示信息。";

L["middleHideRaidTitle"] = "团队中隐藏提示信息";
L["middleHideRaidDesc"] = "当在团队中时，隐藏屏幕中央的提示信息(在5人副本中不会隐藏)。";

---Guild Messages---
L["guildWarningHeaderDesc"] = "公会信息提示";

L["guild10Title"] = "10分钟";
L["guild10Desc"] = "重置时间剩余10分钟时，在公会频道中发送一条提示信息。";

L["guild1Title"] = "1分钟";
L["guild1Desc"] = "重置时间剩余1分钟时，在公会频道中发送一条提示信息。";

L["guildNpcDialogueTitle"] = "NPC开始喊话提示";
L["guildNpcDialogueDesc"] = "当玩家已完成任何世界buff任务，NPC第一次开始喊话时，在公会频道中发送一条提示信息(如果你速度够快，仍有时间换号)。";

L["guildBuffDroppedTitle"] = "Buff已释放提示";
L["guildBuffDroppedDesc"] = "当玩家已获得新的世界buff时，在公会频道中发送一条提示信息。这条信息会在NPC喊话已结束，你将在几秒后获得buff时发送(NPC第一次大喊后的时间，雷德·黑手buff6秒后，奥妮克希亚buff14秒后，奈法利安buff15秒后)。";

L["guildZanDialogueTitle"] = "赞达拉Buff提示";
L["guildZanDialogueDesc"] = "当玩家即将获得赞达拉之魂buff时，在公会频道中发送一条提示信息(如果你不想看到这个buff的提示，需要公会所有人都关闭它)。";

L["guildNpcKilledTitle"] = "NPC被击杀提示";
L["guildNpcKilledDesc"] = "当奥格瑞玛或暴风城交世界BUFF任务的NPC被击时，在公会频道中发送一条提示信息(通过心灵控制重置)。";

L["guildCommandTitle"] = "公会命令提示";
L["guildCommandDesc"] = "针对公会聊天频道中的!wb和!dmf命令回复计时器信息。你应该启用此功能来帮助你的公会，如果您确实要禁用所有公会消息并且仅保留此命令，则应在公会信息提示中取消选中其他所有内容，而不是在顶部勾选“关闭所有公会提示信息。";

L["disableAllGuildMsgsTitle"] = "关闭所有公会提示信息";
L["disableAllGuildMsgsDesc"] = "关闭所有在公会频道发送的计时信息和buff释放信息。注意:如果你愿意的话，你可以逐一关闭所有的公会提示信息，并且只启用某些功能来帮助你的公会。";

---Songflowers---
L["songflowersHeaderDesc"] = "风歌花";

L["guildSongflowerTitle"] = "采集后在公会频道通告";
L["guildSongflowerDesc"] = "当你采集了一个风歌花后，在在公会频道中发送一条带有风歌花下次刷新时间的提示信息。";

L["mySongflowerOnlyTitle"] = "仅当我采集时才计时";
L["mySongflowerOnlyDesc"] = "只有当我自己采集了风歌花，而不是我之前的其他人采集时，才开始计时。此选项仅当你因其他玩家的数据而导致计时器错误时才启用。因为目前尚无办法判断其他人的buff是否是新获得的。因此，如果某个玩家带着风歌花buff上线进入游戏时，正好在风歌花旁边，则会罕见地触发计时。";

L["syncFlowersAllTitle"] = "与所有人同步风歌花";
L["syncFlowersAllDesc"] = "启用此选项会覆盖前面的[仅限公会数据]设置，这样你就可以与公会外玩家同步风歌花BUFF的计时数据，但世界buff数据仍然只会在公会玩家中同步。";

L["showNewFlowerTitle"] = "显示新的风歌花计时";
L["showNewFlowerDesc"] = "当从公会外玩家获得风歌花计时数据后，在聊天频道中发送一条提示信息(当风歌花被采集时，公会频道也会出现提示)。";

L["showSongflowerWorldmapMarkersTitle"] = "世界地图显示风歌花";
L["showSongflowerWorldmapMarkersDesc"] = "在世界地图上显示风歌花图标。";

L["showSongflowerMinimapMarkersTitle"] = "小地图显示风歌花";
L["showSongflowerMinimapMarkersDesc"] = "在小地图上显示风歌花图标。";

L["showTuberWorldmapMarkersTitle"] = "世界地图显示鞭根块茎";
L["showTuberWorldmapMarkersDesc"] = "在世界地图上显示鞭根块茎图标。";

L["showTuberMinimapMarkersTitle"] = "小地图显示鞭根块茎";
L["showTuberMinimapMarkersDesc"] = "在小地图上显示鞭根块茎图标。";

L["showDragonWorldmapMarkersTitle"] = "世界地图显示夜龙之息";
L["showDragonWorldmapMarkersDesc"] = "在世界地图上显示夜龙之息图标。";

L["showDragonMinimapMarkersTitle"] = "小地图显示夜龙之息";
L["showDragonMinimapMarkersDesc"] = "在小底图上显示夜龙之息图标。";

L["showExpiredTimersTitle"] = "显示过期时间计时器";
L["showExpiredTimersDesc"] = "在费伍德地图上显示过期时间计时器。它们将以红色文字显示，计时器已过期多长时间，默认时间是5分钟(玩家反馈风歌花刷新后5分钟内将保持已净化状态，不需要净化就可以直接采集)。";

L["expiredTimersDurationTitle"] = "过期时间计时器周期";
L["expiredTimersDurationDesc"] = "世界地图上的Felwood计时器在到期后应显示多长时间。";

---Darkmoon Faire---
L["dmfHeaderDesc"] = "暗月马戏团(DMF)";

L["dmfTextDesc"] = "如果你有暗月马戏团伤害buff冷却时间，并且暗月马戏团当前处于开启状态，则暗月马戏团伤害buff冷却时间也会显示在暗月马戏团地图图标上。";

L["showDmfWbTitle"] = "/wb打开BUFF计时";
L["showDmfWbDesc"] = "输入/wb命令打开暗月马戏团BUFF计时器";

L["showDmfBuffWbTitle"] = "/wb打开冷却计时";
L["showDmfBuffWbDesc"] = "随/wb命令一起显示暗月马戏团buff冷却计时器，仅当你处于冷却时间且暗月马戏团当前处于开启状态时才显示。";

L["showDmfMapTitle"] = "显示地图标记";
L["showDmfMapDesc"] = "在莫高雷和艾尔文森林地图上显示暗月马戏团和BUFF的刷新时间(下一个刷新时间)。你可以输入/dmf map来打开带有标记的世界地图。";

---Guild Chat Filter---
L["guildChatFilterHeaderDesc"] = "公会频道过滤";

L["guildChatFilterTextDesc"] = "这将阻止您选择的此插件发送的任何公会消息，因此您不会看到它们。它将阻止您在公会聊天中看到您自己的消息以及来自其他插件用户的消息。";

L["filterYellsTitle"] = "过滤BUFF将释放提示";
L["filterYellsDesc"] = "屏蔽世界buff将在几秒后释放的公会提示信息(奥妮克希亚Buff将在 14 秒后释放)。";

L["filterDropsTitle"] = "过滤BUFF已释放提示";
L["filterDropsDesc"] = "屏蔽世界buff已经释放的公会提示信息[屠龙者的咆哮（奥妮克希亚）Buff 已经释放]。";

L["filterTimersTitle"] = "过滤计时器提示";
L["filterTimersDesc"] = "屏蔽计时器提示的公会提示信息(奥妮克希亚buff将于1分钟后重置)。";

L["filterCommandTitle"] = "过滤!wb命令";
L["filterCommandDesc"] = "屏蔽玩家在公会聊天频道输入的!wb或!dmf命令。";

L["filterCommandResponseTitle"] = "过滤!wb回复";
L["filterCommandResponseDesc"] = "屏蔽当!wb或!!dmf 命令被使用时此插件回复的计时提示信息。";

L["filterSongflowersTitle"] = "过滤风歌花提示";
L["filterSongflowersDesc"] = "屏蔽当一个风歌花被采集时在公会频道发送的提示信息。";

L["filterNpcKilledTitle"] = "过滤NPC被杀提示";
L["filterNpcKilledDesc"] = "屏蔽当一个主城中释放Buff的NPC被击杀时在公会频道发送的提示信息。";

---Sounds---
L["soundsHeaderDesc"] = "提示音";

L["soundsTextDesc"] = "设置提示音至\"None\" 来关闭。";

L["disableAllSoundsTitle"] = "关闭所有提示音";
L["disableAllSoundsDesc"] = "关闭来自该插件的所有提示音。";

L["extraSoundOptionsTitle"] = "额外的提示声选项";
L["extraSoundOptionsDesc"] = "启用此功能可在下拉列表中显示来自你所有插件的提示声。";

L["soundOnlyInCityTitle"] = "仅在主城时";
L["soundOnlyInCityDesc"] = "仅当你位于可以获得世界buff的主城时才播放buff提示音(赞达拉buff包含荆棘谷地区)。";

L["soundsDisableInInstancesTitle"] = "在副本中禁用";
L["soundsDisableInInstancesDesc"] = "当你在副本中时禁用提示音。";

L["soundsFirstYellTitle"] = "Buff即将释放时";
L["soundsFirstYellDesc"] = "当龙头任务已交时播放提示声，你需要等待几秒钟，buff才会释放（NPC第一次喊话）。";

L["soundsOneMinuteTitle"] = "1分钟提示";
L["soundsOneMinuteDesc"] = "当计时器还剩一分钟时，播放提示声。";

L["soundsRendDropTitle"] = "获得雷德黑手Buff时";
L["soundsRendDropDesc"] = "当雷德黑手buff释放且你获得buff时播放提示声。";

L["soundsOnyDropTitle"] = "获得奥妮克希亚Buff时";
L["soundsOnyDropDesc"] = "当奥妮克希亚buff释放且你获得buff时播放提示声。";

L["soundsNefDropTitle"] = "获得奈法利安Buff";
L["soundsNefDropDesc"] = "当奈法利安buff释放且你获得buff时播放提示声。";

L["soundsZanDropTitle"] = "获得赞达拉Buff时";
L["soundsZanDropDesc"] = "当赞达拉buff释放且你获得buff时播放提示声。";

---Flash When Minimized---
L["flashHeaderDesc"] = "最小化时闪烁";

L["flashOneMinTitle"] = "重置时间1分钟时闪烁";
L["flashOneMinDesc"] = "当你将魔兽世界最小化且buff重置时间剩余1分钟时，闪烁魔兽世界图标。";

L["flashFirstYellTitle"] = "NPC喊话时闪烁";
L["flashFirstYellDesc"] = "当你将魔兽世界最小化且NPC在buff释放前几秒喊话时，闪烁魔兽世界图标。";

L["flashFirstYellZanTitle"] = "赞达拉Buff闪烁";
L["flashFirstYellZanDesc"] = "当你将魔兽世界最小化且赞达拉buff即将释放时，闪烁魔兽世界图标。";

---Faction/realm specific options---

L["allianceEnableRendTitle"] = "开启联盟雷德提示";
L["allianceEnableRendDesc"] = "启用此选项可以为联盟玩家跟踪雷德·黑手Buff，以便通过心灵控制来获得酋长的祝福Buff。";

L["minimapLayerFrameTitle"] = "在小地图上显示位面";
L["minimapLayerFrameDesc"] = "当你位于主城时，在小地图上显示你当前所在的位面。";

L["minimapLayerFrameResetTitle"] = "重置小地图位面位置";
L["minimapLayerFrameResetDesc"] = "重置小地图位面信息的位置(按住shift并拖动来改变小地图位面信息位置)。";

---Dispels---
L["dispelsHeaderDesc"] = "Buff被驱散提示";

L["dispelsMineTitle"] = "我的Buff";
L["dispelsMineDesc"] = "在聊天频道显示我的Buff被驱散了。这将提示谁驱散了你的什么Buff。";

L["dispelsMineWBOnlyTitle"] = "我的世界Buff";
L["dispelsMineWBOnlyDesc"] = "仅在聊天频道显示我的世界Buff被驱散了，而忽略其他任何Buff。";

L["soundsDispelsMineTitle"] = "我的Buff被驱散提示音";
L["soundsDispelsMineDesc"] = "请选择当我的Buff被驱散时，所播放的提示音。";

L["dispelsAllTitle"] = "其他人的Buff";
L["dispelsAllDesc"] = "在聊天频道显示我周围玩家的Buff被驱散了。这将提示谁驱散了你附近玩家的什么Buff。";

L["dispelsAllWBOnlyTitle"] = "其他人的世界Buff";
L["dispelsAllWBOnlyDesc"] = "仅在聊天频道显示其他人的世界Buff被驱散了，而忽略其他任何Buff。";

L["soundsDispelsAllTitle"] = "其他人的Buff被驱散提示音";
L["soundsDispelsAllDesc"] = "请选择当其他人的Buff被驱散时，所播放的提示音。";

L["middleHideBattlegroundsTitle"] = "战场中隐藏提示信息";
L["middleHideBattlegroundsDesc"] = "当你在战场中时，隐藏屏幕中央的提示信息。";

L["soundsDisableInBattlegroundsTitle"] = "战场中禁用提示音";
L["soundsDisableInBattlegroundsDesc"] = "当你在战场中时，禁用提示音。";

L["autoBuffsHeaderDesc"] = "与NPC对话时自动获取Buff";

L["autoDmfBuffTitle"] = "暗夜马戏团Buff";
L["autoDmfBuffDesc"] = "当你与[塞格]对话时，插件将自动为你选择一个暗夜马戏团Buff。请确认你选择了所希望获取的Buff。";

L["autoDmfBuffTypeTitle"] = "请选择一个暗夜马戏团Buff";
L["autoDmfBuffTypeDesc"] = "当你与[塞格]对话时，你希望插件自动为你选择哪一个暗夜马戏团Buff。";

L["autoDireMaulBuffTitle"] = "厄运之槌Buff";
L["autoDireMaulBuffDesc"] = "当你与厄运之槌那三个可以加Buff的[BOSS]对话时，插件将自动为你选择厄运之槌Buff";

L["autoBwlPortalTitle"] = "黑翼之巢自动传送";
L["autoBwlPortalDesc"] = "当你点击了黑翼之巢门口的[命令宝珠]时，插件会自动选择对话，从而将你传送到黑翼之巢副本内。";

L["showBuffStatsTitle"] = "显示Buff计数器";
L["showBuffStatsDesc"] = "在/buffs命令出现的窗口中显示你获得的每个世界Buff的次数。";

L["buffResetButtonTooltip"] = "重置所有已记录的Buffs。\nBuff计数器数据不会被重置。"; --Reset button tooltip for the /buffs frame.
L["time"] = "次"; --Singular - This shows how many timers you got a buff. Example: (1 time)
L["times"] = "次"; --Plural - This shows how many timers you got a buff. Example: (5 times)
L["flowerWarning"] = "你在开启了位面的服务器上采集了风歌花，虽然风歌花计时器已启用，但是自你到达费伍德森林后，尚未选中任何NPC，所以插件无法记录采集时间。";
L["mmColorTitle"] = "小地图位面信息颜色";
L["mmColorDesc"] = "设置小地图位面信息文本(位面1)的颜色";

---new---
L["layerHasBeenDisabled"] = "位面%s已禁用，此位面仍在数据库中,但是将被忽略,直到你再次启用它或它被检测为是有效的。";
L["layerHasBeenEnabled"] = "位面%s已启用，此位面会重新显示计时器和位面计数。";
L["layerDoesNotExist"] = "位面ID%s在数据库中不存在。";
L["enableLayerButton"] = "启用位面";
L["disableLayerButton"] = "禁用位面";
L["enableLayerButtonTooltip"] = "单击以重新启用此位面。\n此位面将被重新放回计时器和位面计算中。";
L["disableLayerButtonTooltip"] = "在服务器重启后，单击以禁用此位面。\n插件将忽略此位面并在稍后将其删除。";

L["Blackrock Mountain"] = "黑石山";

---Aoikaze

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
L["Layers will disappear from here 6 hours after having no timers。"] = "位面在6小时无活动信息时将被销毁。"

L["Out of date version "] = "已过期版本"
L[" (New version: "] = "(新版本："
L[")\nPlease update so your timers are accurate。"] = "）\n请更新NWB插件。"

L["|HNWBCustomLink:timers|hYou are on a layered realm.|h"] = "|HNWBCustomLink:timers|h你的服务器存在位面。|h"
L["|HNWBCustomLink:timers|hClick here to view current timers.|h"] = "|HNWBCustomLink:timers|h点击查看当前计时器信息。|h"

L["(No layers found)"] = "(没有找到位面）"
L["That layer wasn't found or has no valid timers。"] = "未找到位面，或没有有效的计时信息。"

L["(Onyxia: NPC (Runthak) was killed "] = "(奥妮克希亚：伦萨克已死亡"
L["(Onyxia: NPC (Mattingly) was killed "] = "(奥妮克希亚：玛丁雷已死亡"
L["(Nefarian: NPC (Saurfang) was killed "] = "(奈法利安：萨鲁法尔已死亡"
L["(Nefarian: NPC (Afrasiabi) was killed "] = "(奈法利安：艾法希比已死亡"
L[" ago no buff recorded since"] = "，至今无Buff释放记录"

L[" (Layer "] = "(位面"
L[" of "] = "/"
L[" (Layer 1 of "] = "(位面1/"
L["(No layers found)"] = "(没有找到位面)"
L["|cff00ff00[Layer "] = "|cff00ff00[位面"
L[" (expired)"] = "(已过期)"
L[" (expired) (Layer "] = "(已过期)(位面"

L["  -|cffFFFF00No zones mapped for this layer yet.\n"] = " -|cffFFFF00没有区域被记录在此位面。\n"
L["]|r  |cff9CD6DE(Orgrimmar "] = "]|r |cff9CD6DE(奥格瑞玛"
L["]|r  |cff9CD6DE(Stormwind "] = "]|r |cff9CD6DE(暴风城"
L[" zones mapped)|r\n"] = "区域已记录"

L["Removing old layer:"] = "移除过期位面："

L["\n\n|cFF9CD6DEYour guild master has the following public guild note settings enabled:"] = "\n\n|cFF9CD6DE会长已对公会信息进行了如下设置："

L[" dispelled "] = "驱散了"

L["Onyxia buff NPC sapped by "] = "奥妮克希亚 Buff NPC 被 "
L[", setting backup timer."] = "消耗了，开始重生计时。"
L["Onyxia buff NPC sapped, setting backup timer."] = "奥妮克希亚 Buff NPC 被消耗，开始重生计时。"

L["No channel with id "] = "不存在ID为"
L[" exists."] = "的频道。"
L["Type \"/wb\" to print world buff timers to yourself."] = "输入\"/wb\" 显示你当前的世界Buff情况。"
L["Type \"/wb config\" to open options."] = "输入\"/wb config\" 打开设置窗口。"
L["Type \"/wb guild\" to post buff timers to the specified chat channel (accepts channel names and numbers)."] = "输入\"/wb guild\" 向特定频道通报世界Buff信息（接受频道数字或频道名称）。"
L["Use \"/sf\" in the same way for songflowers."] = "使用\"/sf\" 查看轻歌花情况。"
L["Type \"/dmf\" for your Darkmoon Faire buff cooldown."] = "输入\"/dmf\" 查看暗月马戏团Buff冷却情况。"
L["Type \"/buffs\" to view all your alts world buffs."] = "输入\"/buffs\" 查看所有角色世界Buff情况。"

L["\n|cFF989898[Layer Disabled]  (zone "] = "\n|cFF989898[位面已禁用](区域"

L["|cFFFFFF00Looking for layered timers to convert."] = "|cFFFFFF00寻找可以转换的位面计时器。"

L["No timers found."] = "未找到计时器。"
L["."] = "。"