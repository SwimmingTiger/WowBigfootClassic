local L = LibStub("AceLocale-3.0"):NewLocale("NovaWorldBuffs", "zhTW");
if (not L) then
	return;
end

--Rend buff aura name.
L["Warchief's Blessing"] = "酋長的祝福";
--Onyxia and Nefarian buff aura name.
L["Rallying Cry of the Dragonslayer"] = "屠龍者的咆哮";
--Songflower buff aura name from felwood.
L["Songflower Serenade"] = "風歌夜曲";
L["Songflower"] = "輕歌花";
--Spirit of Zandalar.
L["Spirit of Zandalar"] = "贊達拉之魂";
L["Flask of Supreme Power"] = "超級能量精煉藥水";
L["Flask of the Titans"] = "泰坦精煉藥水";
L["Flask of Distilled Wisdom"] = "智慧精煉藥水";
L["Flask of Chromatic Resistance"] = "多重抗性精煉藥水";
--3 of the flasks spells seem to be named differently than the flask item, but titan is exact same name as the flask item.
L["Supreme Power"] = "至高能量";
L["Distilled Wisdom"] = "萃取智慧";
L["Chromatic Resistance"] = "多彩抗性";
L["Sap"] = "悶棍";
L["Fire Festival Fortitude"] = "火焰節慶之韌";
L["Fire Festival Fury"] = "火焰節慶之怒";
L["Ribbon Dance"] = "緞帶舞";

---=====---
---Horde---
---=====---

--Horde Orgrimmar Rend buff NPC.
L["Thrall"] = "索爾";
--Horde The Barrens Rend buff NPC.
L["Herald of Thrall"] = "索爾的使者";
--Horde rend buff NPC first yell string (part of his first yell msg before before buff).
L["Rend Blackhand, has fallen"] = "為你們的英雄而歡慶";
--Horde rend buff NPC second yell string (part of his second yell msg before before buff).
L["Be bathed in my power"] = "沐浴在我的力量中吧";

--Horde Onyxia buff NPC.
L["Overlord Runthak"] = "倫薩克";
--Horde Onyxia buff NPC first yell string (part of his first yell msg before before buff).
L["Onyxia, has been slain"] = "部落的人民，奧格瑪的城民";
--Horde Onyxia buff NPC second yell string (part of his second yell msg before before buff).
L["Be lifted by the rallying cry"] = "在屠龍大軍的戰鬥口號聲中精神抖擻地前進吧";

--Horde Nefarian buff NPC.
L["High Overlord Saurfang"] = "薩魯法爾大王";
--Horde Nefarian buff NPC first yell string (part of his first yell msg before before buff).
L["NEFARIAN IS SLAIN"] = "奈法利安被幹掉了";
--Horde Nefarian buff NPC second yell string (part of his second yell msg before before buff).
L["Revel in his rallying cry"] = "為他的勝利而狂歡吧";

---===========----
---NPC's killed---
---============---

L["onyxiaNpcKilledHorde"] = "倫薩克已經被殺了!(奧妮克西婭增益NPC ).";
L["onyxiaNpcKilledAlliance"] = "瑪丁雷少校已經被殺了! (奧妮克西婭增益NPC).";
L["nefarianNpcKilledHorde"] = "薩魯法爾大王已經被殺了! (奈法利安增益NPC ).";
L["nefarianNpcKilledAlliance"] = "艾法希比元帥已經被殺了! (奈法利安增益NPC ).";
L["onyxiaNpcKilledHordeWithTimer"] = "奧妮克西婭增益NPC (倫薩克) 已經被殺了 %s 時間，之後沒有任何增益紀錄。";
L["nefarianNpcKilledHordeWithTimer"] = "奈法利安增益NPC (薩魯法爾) 以經被殺了 %s 時間，之後沒有任何增益紀錄。";
L["onyxiaNpcKilledAllianceWithTimer"] = "奧妮克西婭增益NPC (瑪丁雷) 已經被殺了 %s 時間，之後沒有任何增益紀錄。";
L["nefarianNpcKilledAllianceWithTimer"] = "奈法利安增益NPC (艾法希比) 以經被殺了 %s 時間，之後沒有任何增益紀錄。";
L["anyNpcKilledWithTimer"] = "在 %s 以前被殺了"; --Map timers tooltip msg.

---========---
---Alliance---
---========---

--Alliance Onyxia buff NPC.
L["Major Mattingly"] = "瑪丁雷少校";
--Alliance Onyxia buff NPC first yell string (part of his first yell msg before before buff).
L["history has been made"] = "暴風城的城民和盟友們";
--Alliance Onyxia buff NPC second yell string (part of his second yell msg before before buff).
L["Onyxia, hangs from the arches"] = "看看強大的聯盟吧";


--Alliance Nefarian buff NPC.
L["Field Marshal Afrasiabi"] = "艾法希比元帥";
--Alliance Nefarian buff NPC first yell string (part of his first yell msg before before buff).
L["the Lord of Blackrock is slain"] = "聯盟的人民們";
--Alliance Nefarian buff NPC second yell string (part of his second yell msg before before buff).
L["Revel in the rallying cry"] = "興奮起來";

---==============---
---Darkmoon Faire---
---==============---

L["Darkmoon Faire"] = "暗月馬戲團";
L["Sayge's Dark Fortune of Agility"] = "賽吉的敏捷黑暗籤詩";
L["Sayge's Dark Fortune of Intelligence"] = "賽吉的智力黑暗籤詩";
L["Sayge's Dark Fortune of Spirit"] = "賽吉的精神黑暗籤詩";
L["Sayge's Dark Fortune of Stamina"] = "賽吉的耐力黑暗籤詩";
L["Sayge's Dark Fortune of Strength"] = "賽吉的力量黑暗籤詩";
L["Sayge's Dark Fortune of Armor"] = "賽吉的護甲黑暗籤詩";
L["Sayge's Dark Fortune of Resistance"] = "賽吉的抗性黑暗籤詩";
L["Sayge's Dark Fortune of Damage"] = "賽吉的傷害黑暗籤詩";
L["dmfBuffCooldownMsg"] = "你的暗月馬戲團增益倒數剩下 %s 。";
L["dmfBuffCooldownMsg2"] = "你的暗月馬戲團增益倒數剩下 %s 。";
L["dmfBuffCooldownMsg3"] = "暗月馬戲團增益冷卻時間也在伺服器每周重置時重置。"; --/wb frame 2nd msg.
L["dmfBuffReady"] = "你的暗月馬戲團增益已經停止倒數。";
L["dmfBuffReset"] = "你的暗月馬戲團增益冷卻時間已經重置。";
L["dmfBuffDropped"] = "暗月馬戲團增益 %s 已取得, 您可以使用 /dmf，查詢遊戲內冷卻時間，以再次獲得馬戲團增益。";
L["dmfSpawns"] = "暗月馬戲團出現在 %s (%s)";
L["dmfEnds"] = "暗月馬戲團活動已經開始，這結束在 %s (%s)";
L["mulgore"] = "莫高雷";
L["elwynnForest"] = "艾爾文森林";
				
---==============---
---Output Strings---
---==============---
L["rend"] = "雷德"; --Rend Blackhand
L["onyxia"] = "奧妮克西婭"; --Onyxia
L["nefarian"] = "奈法利安"; --Nefarian
L["dmf"] = "暗月馬戲團"; --Darkmoon Faire
L["noTimer"] = "未取得"; --No timer (used only in map timer frames)
L["noCurrentTimer"] = "未取得"; --No current timer
L["noActiveTimers"] = "未啟動";	--No active timers
L["newBuffCanBeDropped"] = "一個新的 %s 增益現在可以取得";
L["buffResetsIn"] = "%s 重置在 %s";
L["rendFirstYellMsg"] = "酋長祝福的閃電，將在6秒後施放。";
L["onyxiaFirstYellMsg"] = "奧妮克西婭的頭顱已插，閃電將在14秒後施放。";
L["nefarianFirstYellMsg"] = "奈法利安的頭顱已插，閃電將在15秒後施放。";
L["rendBuffDropped"] = "酋長的祝福(雷德) 已經施放。";
L["onyxiaBuffDropped"] = "屠龍者的咆哮 (奧妮克西婭) 已經施放。";
L["nefarianBuffDropped"] = "屠龍者的咆哮 (奈法利安) 已經施放。";
L["newSongflowerReceived"] = "收到了新的輕歌花計時"; --New songflower timer received
L["songflowerPicked"] = "輕歌花已被拾取，在 %s ，重生在25分鐘後。"; -- Guild msg when songflower picked.
L["North Felpaw Village"] = "魔爪村北邊"; --Felwood map subzones (flower1).
L["West Felpaw Village"] = "魔爪村西邊"; --Felwood map subzones (flower2).
L["North of Irontree Woods"] = "鐵木森林北邊"; --Felwood map subzones (flower3).
L["Talonbranch Glade"] = "刺枝林地"; --Felwood map subzones (flower4).
L["Shatter Scar Vale"] = "碎痕谷"; --Felwood map subzones (flower5).
L["Bloodvenom Post"] = "血毒崗哨"; --Felwood map subzones (flower6).
L["East of Jaedenar"] = "加德納爾東邊"; --Felwood map subzones (flower7).
L["North of Emerald Sanctuary"] = "翡翠聖地北邊"; --Felwood map subzones (flower8).
L["West of Emerald Sanctuary"] = "翡翠聖地西邊"; --Felwood map subzones (flower9).
L["South of Emerald Sanctuary"] = "翡翠聖地南邊"; --Felwood map subzones (flower10).
L["second"] = "秒"; --Second (singular).
L["seconds"] = "秒"; --Seconds (plural).
L["minute"] = "分"; --Minute (singular).
L["minutes"] = "分"; --Minutes (plural).
L["hour"] = "時"; --Hour (singular).
L["hours"] = "時"; --Hours (plural).
L["day"] = "天"; --Day (singular).
L["days"] = "天"; --Days (plural).
L["secondShort"] = "秒"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "分"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "時"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "天"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "在 %s 後開始"; --"Starts in 1hour".
L["endsIn"] = "在 %s 後結束"; --"Ends in 1hour".
L["versionOutOfDate"] = "你的<Nova World Buffs>插件已經過期了，請上https://www.curseforge.com/wow/addons/nova-world-buffs 更新，或通過twitch客戶端更新。";
L["Your Current World Buffs"] = "你擁有的世界buff";
L["Options"] = " 選項";

---New stuff---

--Spirit of Zandalar buff NPC first yell string (part of his first yell msg before before buff).
L["Begin the ritual"] = "開始儀式"
L["The Blood God"] = "血神"; --First Booty bay yell from Zandalarian Emissary.
--Spirit of Zandalar buff NPC second yell string (part of his second yell msg before before buff).
L["slayer of Hakkar"] = "殺死哈卡";

L["Molthor"] = "莫托爾"; --NPC on zaldalar sland you hand in ZG head to.
L["Zandalarian Emissary"] = "贊達拉大使";
L["Whipper Root Tuber"] = "鞭根塊莖";
L["Night Dragon's Breath"] = "夜龍之息";
L["Resist Fire"] = "抵抗火焰"; -- LBRS fire resist buff.
L["Blessing of Blackfathom"] = "黑暗深淵的祝福";

L["zan"] = "贊達拉";
L["zanFirstYellMsg"] = "贊達拉之魂，將在30秒後施放。";
L["zanBuffDropped"] = "贊達拉之魂已經施放。";
L["singleSongflowerMsg"] = "%s 的輕歌花重生在 %s。"; -- Songflower at Bloodvenom Post spawns at 1pm.
L["spawn"] = "重生"; --Used in Felwood map marker tooltip (03:46pm spawn).
L["Irontree Woods"] = "鐵木森林";
L["West of Irontree Woods"] = "鐵木森林西邊";
L["Bloodvenom Falls"] = "血毒瀑布";
L["Jaedenar"] = "加德納爾";
L["North-West of Irontree Woods"] = "鐵木森林西北邊";
L["South of Irontree Woods"] = "鐵木森林南邊";

L["worldMapBuffsMsg"] = "輸入 /buffs 可以看到你\n所有角色的世界增益。";
L["cityMapLayerMsgHorde"] = "正確 %s\n選取奧格瑪的任何NPC\n用來在傳換區域後更新鏡像。|r";
L["cityMapLayerMsgAlliance"] = "正確 %s\n選取暴風城的任何NPC\n用來在傳換區域後更新鏡像。|r";
L["noLayerYetHorde"] = "請點選奧格瑪的任何NPC\n去找到你的鏡像。";
L["noLayerYetAlliance"] = "請點選暴風城的任何NPC\n去找到你的鏡像。";
L["Reset Data"] = "重置資料"; --A button to Reset buffs window data.

L["layerFrameMsgOne"] = "伺服器重開後舊的鏡像依然會顯示幾個小時。"; --Msg at bottom of layer timers frame.
L["layerFrameMsgTwo"] = "沒有計時器後的六個小時靜像會消失。"; --Msg at bottom of layer timers frame.
L["You are currently on"] = "你目前正在"; --You are currently on [Layer 2]


-------------
---Config---
-------------
--There are 2 types of strings here, the names end in Title or Desc L["exampleTitle"] and L["exampleDesc"].
--Title must not be any longer than 21 characters (maybe less for chinese characters because they are larger).
--Desc can be any length.

---Description at the top---
L["mainTextDesc"] = "輸入 /wb 對你顯示計時器視窗。 \n輸入 /wb <頻道名> 隊指定頻道顯示計時器。 \n往下滾動滑鼠有更多選項。";

---Show Buffs Button
L["showBuffsTitle"] = "單擊以顯示您當前的世界增益";
L["showBuffsDesc"] = "顯示你所有角色當前的世界增益， 這個功能同樣可輸入/buffs 開啟，或點擊聊天頻道開始的 [WorldBuffs] 。";

---General Options---
L["generalHeaderDesc"] = "一般選項";

L["showWorldMapMarkersTitle"] = "城市計時器";
L["showWorldMapMarkersDesc"] = "顯示計時圖標在世界地圖上的奧格瑪/暴風城。";

L["receiveGuildDataOnlyTitle"] = "只接受公會數據";
L["receiveGuildDataOnlyDesc"] = "這會讓你不向公會以外的任何人取得計時資料。 僅當您認為有人故意製造錯誤的計時器數據時，才應啟用此功能，因為這樣做會降低計時器的準確性，減少了從中提取數據的人員。因為它們很短，所以很難獲得輕歌花計時器。公會中的每個人都需要啟用此功能才能正常工作。";

L["chatColorTitle"] = "聊天訊息顏色";
L["chatColorDesc"] = "聊天頻道的計時器聊天的顏色。";

L["middleColorTitle"] = "警告訊息顏色";
L["middleColorDesc"] = "在螢幕中的團隊警告訊息的顏色。";

L["resetColorsTitle"] = "重置顏色";
L["resetColorsDesc"] = "重置顏色回到預設值。";

L["showTimeStampTitle"] = "顯示時間戳";
L["showTimeStampDesc"] = "顯示時間戳 (1:23pm) 在計時器訊息旁邊。";

L["timeStampFormatTitle"] = "時間戳格式";
L["timeStampFormatDesc"] = "設置使用的時間戳格式為12小時制（1:23 pm）或24小時制（13:23）。";

L["timeStampZoneTitle"] = "本地時間/伺服器時間";
L["timeStampZoneDesc"] = "使用本地時間或是伺服器時間當時間戳。";

L["colorizePrefixLinksTitle"] = "字首連結的顏色";
L["colorizePrefixLinksDesc"] = "可以改變字首 [WorldBuffs] 顏色在所有聊天頻道。 這是在聊天頻道的字首你可以點擊顯示你所有角色當前的世界增益。";

L["showAllAltsTitle"] = "所有分身";
L["showAllAltsDesc"] = "在 /buffs 視窗中顯示所有分身，即使它們沒有作用中的增益。";

L["minimapButtonTitle"] = "顯示小地圖按鈕";
L["minimapButtonDesc"] = "顯示NWB的按鈕在小地圖。";

---Logon Messages---
L["logonHeaderDesc"] = "登入訊息";

L["logonPrintTitle"] = "登入計時器";
L["logonPrintDesc"] = "當你登入的時候顯示計時器時間, 你可以用這個選項關掉所有登入訊息。";

L["logonRendTitle"] = "雷德";
L["logonRendDesc"] = "在你登入的時候在聊天視窗顯示雷德計時。";

L["logonOnyTitle"] = "奧妮克西婭";
L["logonOnyDesc"] = "在你登入的時候在聊天視窗顯示奧妮克西婭計時。";

L["logonNefTitle"] = "奈法利安";
L["logonNefDesc"] = "在你登入的時候在聊天視窗顯示奈法利安計時。";

L["logonDmfSpawnTitle"] = "暗月馬戲團重生";
L["logonDmfSpawnDesc"] = "顯示暗月馬戲團重生時間, 這只有在不到六小時重生時才會顯示。";

L["logonDmfBuffCooldownTitle"] = "暗月馬戲團增益冷卻";
L["logonDmfBuffCooldownDesc"] = "顯示暗月馬戲團增益四小時倒數, 只有當你啟動冷卻時間及獲得按月增益才會顯示。";

---Chat Window Timer Warnings---
L["chatWarningHeaderDesc"] = "聊天視窗計時器警告";

L["chat30Title"] = "30 分";
L["chat30Desc"] = "在聊天視窗顯示還剩下 30 分。";

L["chat15Title"] = "15 分";
L["chat15Desc"] = "在聊天視窗顯示還剩下 15 分。";

L["chat10Title"] = "10 分";
L["chat10Desc"] = "在聊天視窗顯示還剩下 10 分。";

L["chat5Title"] = "5 分";
L["chat5Desc"] = "在聊天視窗顯示還剩下 5 分。";

L["chat1Title"] = "1 分";
L["chat1Desc"] = "在聊天視窗顯示還剩下 1 分。";

L["chatResetTitle"] = "增益重置時間";
L["chatResetDesc"] = "在增益重置跟可獲得新的時，在聊天視窗顯示提示警告。";

L["chatZanTitle"] = "贊達拉增益警告";
L["chatZanDesc"] = "在贊達拉npc開始喊話，在增益施放前30秒，在聊天視窗出現訊息警告。";

---Middle Of The Screen Timer Warnings---
L["middleWarningHeaderDesc"] = "螢幕中間計時器警告";

L["middle30Title"] = "30 分";
L["middle30Desc"] = "在剩30分鐘時，在螢幕中間出現團隊警告樣式的警告訊息。";

L["middle15Title"] = "15 分";
L["middle15Desc"] = "在剩15分鐘時，在螢幕中間出現團隊警告樣式的警告訊息。";

L["middle10Title"] = "10 分";
L["middle10Desc"] = "在剩10分鐘時，在螢幕中間出現團隊警告樣式的警告訊息。";

L["middle5Title"] = "5 分";
L["middle5Desc"] = "在剩5分鐘時，在螢幕中間出現團隊警告樣式的警告訊息。";

L["middle1Title"] = "1 分";
L["middle1Desc"] = "在剩1分鐘時，在螢幕中間出現團隊警告樣式的警告訊息。";

L["middleResetTitle"] = "增益已經重置";
L["middleResetDesc"] = "當增益已經重置可施放新的增益的時候，在螢幕中間出現團隊警告樣式的警告訊息。";

L["middleBuffWarningTitle"] = "增益施放警告";
L["middleBuffWarningDesc"] = "當任何人看到任何增益及增益施放前npc喊話的時候，在螢幕中間出現團隊警告樣式的警告訊息。";

L["middleHideCombatTitle"] = "在戰鬥中隱藏";
L["middleHideCombatDesc"] = "在戰鬥中隱藏螢幕警告訊息。";

L["middleHideRaidTitle"] = "在團隊中隱藏";
L["middleHideRaidDesc"] = "在團隊副本中隱藏螢幕警告訊息(普通副本不隱藏)";

---Guild Messages---
L["guildWarningHeaderDesc"] = "公會訊息";

L["guild10Title"] = "10 分";
L["guild10Desc"] = "當剩下10分鐘時傳送公會訊息。";

L["guild1Title"] = "1 分";
L["guild1Desc"] = "當剩下1分鐘時傳送公會訊息。";

L["guildNpcDialogueTitle"] = "NPC喊話開始";
L["guildNpcDialogueDesc"] = "當有人掛頭的時候傳送公會訊息，在NPC第一句喊話時，你仍然有時間去重登如果你夠快。";

L["guildBuffDroppedTitle"] = "新的增益施放";
L["guildBuffDroppedDesc"] = "傳送一個訊息給公會，當施放增益時。 這個訊息會在NPC完成喊話及你時記得到增益的幾秒後。(雷德第一句喊話後6秒, 奧妮14秒, 奈法15秒)";

L["guildZanDialogueTitle"] = "ZG增益警告";
L["guildZanDialogueDesc"] = "傳送一個訊息當贊達拉之魂將要施放時。 (如果你想要沒有顯示這個增益那公會的所有人都需要關閉這個選項)。";

L["guildNpcKilledTitle"] = "NPC被殺了";
L["guildNpcKilledDesc"] = "傳送一個公會訊息當NPC在奧格瑪或暴風城被殺時。 (心控重置).";

L["guildCommandTitle"] = "公會指令";
L["guildCommandDesc"] = "當有人打!wb 及 !dmf 指令時船傳送公會訊息。 你應該開啟這個功能去幫助你的公會, 如果你真的要關閉所有公會訊息只保留此指令，應在公會訊息中選取其他選項，不要在上面打勾 關閉所有公會訊息 選項。 ";

L["disableAllGuildMsgsTitle"] = "關閉所有公會訊息";
L["disableAllGuildMsgsDesc"] = "關閉所有公會訊息包刮計時與增益施放。 筆記: 您可以一個一個停用所有訊息，如果願意，可以僅啟用一部分功能來幫助你的公會。";

---Songflowers---
L["songflowersHeaderDesc"] = "輕歌花";

L["guildSongflowerTitle"] = "當拾取時告訴公會";
L["guildSongflowerDesc"] = "當拾取輕歌花時告訴公會與下一個重生時間。";

L["mySongflowerOnlyTitle"] = "只有當自己拾取時";
L["mySongflowerOnlyDesc"] = "只有當自己拾取時紀錄輕歌花的時間。 這個選項只有在你遇別人傳送假的計時才使用。 目前沒有辦法判定其他玩家的增益是否是新的，如果有玩家在你面前登入並帶有輕歌花的增益時，有極少機會造成錯誤的時間。 ";

L["syncFlowersAllTitle"] = "跟所有人同步輕歌花的時間";
L["syncFlowersAllDesc"] = "打開這選項可以跟公會以外的人分享輕歌花的時間，但不會分享其他世界增益。";

L["showNewFlowerTitle"] = "顯示新的輕歌花計時器";
L["showNewFlowerDesc"] = "''當找一個新的計時器在非公會成員身上時，顯示在聊天視窗警告'' (當公會成員取得輕歌花計時已經會出現在公會訊息).";

L["showSongflowerWorldmapMarkersTitle"] = "輕歌花世界地圖";
L["showSongflowerWorldmapMarkersDesc"] = "在世界地圖顯示輕歌花的圖示。";

L["showSongflowerMinimapMarkersTitle"] = "輕歌花小地圖";
L["showSongflowerMinimapMarkersDesc"] = "在小地圖顯示輕歌花。";

L["showTuberWorldmapMarkersTitle"] = "鞭根塊莖世界地圖";
L["showTuberWorldmapMarkersDesc"] = "在世界地圖顯示鞭根塊莖的圖示。";

L["showTuberMinimapMarkersTitle"] = "鞭根塊莖小地圖";
L["showTuberMinimapMarkersDesc"] = "在小地圖顯示輕歌花在。";

L["showDragonWorldmapMarkersTitle"] = "夜龍之息世界地圖";
L["showDragonWorldmapMarkersDesc"] = "在世界地圖顯示夜龍之息的圖示。";

L["showDragonMinimapMarkersTitle"] = "夜龍之息";
L["showDragonMinimapMarkersDesc"] = "在小地圖顯示夜龍之息。";

L["showExpiredTimersTitle"] = "顯示過期計時器";
L["showExpiredTimersDesc"] = "在費伍德顯示過期計時器。 它們將以紅色文字計時器顯示過期多長時間，默認時間是5分鐘 (有人說重生時會保持五分鐘乾淨的輕歌花。).";

L["expiredTimersDurationTitle"] = "過期計時器長短";
L["expiredTimersDurationDesc"] = "在廢伍德計時器過期後，顯示多久過期計時器時間。";

---Darkmoon Faire---
L["dmfHeaderDesc"] = "暗月馬戲團";

L["dmfTextDesc"] = "如果你有暗月馬戲團傷害增益冷卻時間並且暗月馬戲團當前處於活動狀態，則則暗月馬戲團傷害增益冷卻時間也會顯示在暗月馬戲團的地圖。";

L["showDmfWbTitle"] = "使用 /wb 顯示按月馬息團時間";
L["showDmfWbDesc"] = "使用 /wb 指令也一起顯示暗月馬戲團時間。";

L["showDmfBuffWbTitle"] = "使用 /wb 顯示暗月馬戲團增益倒數";
L["showDmfBuffWbDesc"] = "使用 /wb 指令也一起顯示暗月馬戲團增益冷卻時間。 只當你有暗月馬戲團增益冷卻狀態時.";

L["showDmfMapTitle"] = "顯示地圖標記";
L["showDmfMapDesc"] = "在莫高雷及艾爾文森林顯示暗月馬戲團地圖標記及冷卻時間 (下一個重生時間). 你也可以輸入 /dmf map 打開帶有標記的世界地圖。";

---Guild Chat Filter---
L["guildChatFilterHeaderDesc"] = "公會聊天過濾";

L["guildChatFilterTextDesc"] = "這將會阻擋所有從這個插件送的公會訊息，你選了所以你看不到它。 這將會停止你自己看到訊息及公會其他人使用這個插件的訊息。";

L["filterYellsTitle"] = "過濾增益警告";
L["filterYellsDesc"] = "過濾掉這個增益要施放時的訊息 (奧妮克西婭的頭顱已插，閃電將在14秒後施放。)。";

L["filterDropsTitle"] = "過濾增益施放警告";
L["filterDropsDesc"] = "過濾掉增益施放時的訊息 (屠龍者的咆嘯 (奧妮克西婭) 以施放)。";

L["filterTimersTitle"] = "過濾計時器訊息";
L["filterTimersDesc"] = "過濾掉計時器 (奧妮克西婭增益重置在1分鐘)。";

L["filterCommandTitle"] = "過濾 !wb 命令";
L["filterCommandDesc"] = "當有公會的人打 !wb 及 !dmf 指令，會被過濾掉。";

L["filterCommandResponseTitle"] = "過濾 !wb 回復";
L["filterCommandResponseDesc"] = "當有公會的人打 !wb 及 !dmf 指令，回復的消息會被過濾掉。";

L["filterSongflowersTitle"] = "過濾輕歌花";
L["filterSongflowersDesc"] = "過濾當花被拾取的訊息";

L["filterNpcKilledTitle"] = "過濾NPC被殺訊息";
L["filterNpcKilledDesc"] = "'當你的主城有人殺掉NPC時訊息會被過濾'";

---Sounds---
L["soundsHeaderDesc"] = "聲音";

L["soundsTextDesc"] = "將聲音設定成 \"None\" 來停用。";

L["disableAllSoundsTitle"] = "關閉所有聲音";
L["disableAllSoundsDesc"] = "關閉所以從這個插件來的聲音";

L["extraSoundOptionsTitle"] = "額外聲音選項";
L["extraSoundOptionsDesc"] = "開啟這個選項在下拉選單顯示所有插件的音效。";

L["soundOnlyInCityTitle"] = "只有城市裡";
L["soundOnlyInCityDesc"] = "只有在你主城(有增益施放的地方)才撥放增益音效(包括贊達拉)。";

L["soundsDisableInInstancesTitle"] = "出團停用";
L["soundsDisableInInstancesDesc"] = "在打團隊副本時停用";

L["soundsFirstYellTitle"] = "增益準備施放";
L["soundsFirstYellDesc"] = "當增益準備施放 (第一句NPC的喊話時).";

L["soundsOneMinuteTitle"] = "一分鐘警告";
L["soundsOneMinuteDesc"] = "音效在剩下一分鐘時警告。";

L["soundsRendDropTitle"] = "獲得雷德增益";
L["soundsRendDropDesc"] = "音效在雷德增益施放時及你取得增益時播放。";

L["soundsOnyDropTitle"] = "獲得奧妮增益";
L["soundsOnyDropDesc"] = "音效在奧妮克西婭增益施放時及你取得增益時播放。";

L["soundsNefDropTitle"] = "獲得奈法增益";
L["soundsNefDropDesc"] = "音效在奈法利安增益施放時及你取得增益時播放。";

L["soundsZanDropTitle"] = "獲得贊達拉增益";
L["soundsZanDropDesc"] = "音效在贊達拉增益施放時及你取得增益時播放。";

---Flash When Minimized---
L["flashHeaderDesc"] = "當最小化時閃爍";

L["flashOneMinTitle"] = "一分鐘閃爍";
L["flashOneMinDesc"] = "當你最小化魔獸視窗及剩下一分鐘時閃爍。";

L["flashFirstYellTitle"] = "NPC喊話閃爍";
L["flashFirstYellDesc"] = "當你最小化魔獸視窗及NPC喊話在增益施放前閃爍。";

L["flashFirstYellZanTitle"] = "閃亮亮贊達拉";
L["flashFirstYellZanDesc"] = "當你最小化魔獸視窗及贊達拉增益準備出來吃。";

---Faction/realm specific options---

L["allianceEnableRendTitle"] = "開啟聯盟雷德";
L["allianceEnableRendDesc"] = "啟動選項聯盟可以追蹤雷德,為公會心控取得雷德增益。 如果你使用這個功能那公會使用此插件應該開啟，但是公會訊息可能不會顯示。 (個人計時器顯示正常)。";

L["minimapLayerFrameTitle"] = "顯示小地圖鏡像";
L["minimapLayerFrameDesc"] = "當你在主城，顯示一個鏡像框在小地圖上告訴你，你的鏡像。";

L["minimapLayerFrameResetTitle"] = "重置小地圖鏡像";
L["minimapLayerFrameResetDesc"] = "重置小地圖鏡像框到預設位置 (按住SHIFT可以拖曳鏡像框).";

L["dispelsHeaderDesc"] = "驅散";

L["dispelsMineTitle"] = "顯示我被驅散";
L["dispelsMineDesc"] = "當我的增益被驅散時顯示?這將會顯示誰驅散了你什麼增益。";

L["dispelsMineWBOnlyTitle"] = "只顯示我的世界增益";
L["dispelsMineWBOnlyDesc"] = "只顯示我的世界增益被驅散，一般增益不顯示。";

L["soundsDispelsMineTitle"] = "增益驅散音效";
L["soundsDispelsMineDesc"] = "我的增益被驅散時要撥放什麼音效";

L["dispelsAllTitle"] = "所有驅散";
L["dispelsAllDesc"] = "在聊天顯示所有在我身邊被驅散的人? 這個會顯示所有靠近你的人被驅散了什麼增益。";

L["dispelsAllWBOnlyTitle"] = "只顯示世界增益";
L["dispelsAllWBOnlyDesc"] = "只會顯示在你身邊被驅散的世界增益，不會顯示一般增益。";

L["soundsDispelsAllTitle"] = "其他人的增益驅散音效";
L["soundsDispelsAllDesc"] = "其他人增益被驅散時要撥放什麼音效";

L["middleHideBattlegroundsTitle"] = "在戰場時隱藏。";
L["middleHideBattlegroundsDesc"] = "在戰場時隱藏螢幕中間的警告?";

L["soundsDisableInBattlegroundsTitle"] = "在戰場時關閉。";
L["soundsDisableInBattlegroundsDesc"] = "在戰場時關閉音效。";

L["autoBuffsHeaderDesc"] = "從NPC自動取得增益";

L["autoDmfBuffTitle"] = "自動取得暗月增益";
L["autoDmfBuffDesc"] = "你想跟賽吉講話時自動對話選擇你要的增益嗎? 確定你選擇你想要哪種增益。";

L["autoDmfBuffTypeTitle"] = "哪個暗月增益";
L["autoDmfBuffTypeDesc"] = "你想要在跟賽吉講話時，這個插件幫你選擇哪個暗月增益?";

L["autoDireMaulBuffTitle"] = "厄運增益";
L["autoDireMaulBuffDesc"] = "你想要這個插件在你對話時，自動幫你取得增益嗎?";

L["autoBwlPortalTitle"] = "自動使用黑翼之巢寶珠";
L["autoBwlPortalDesc"] = "你想要插件幫你在你點擊寶珠時自動進入副本嗎?";

L["showBuffStatsTitle"] = "顯示增益次數";
L["showBuffStatsDesc"] = "在/buff 框架顯示你獲得每個增益的次數?";

L["buffResetButtonTooltip"] = "這將會重置所有增益\n增益次數資料不會被重置."; --/buff 框架的重置按鈕的提示。
L["time"] = "次"; --Singular - This shows how many timers you got a buff. Example: (1 time)
L["times"] = "次"; --Plural - This shows how many timers you got a buff. Example: (5 times)
L["flowerWarning"] = "輕歌花的鏡像紀錄已啟動，但是你沒有在到達費伍德時先點擊NPC，所以沒有計時器被記錄。";

L["mmColorTitle"] = "小地圖Layer顏色";
L["mmColorDesc"] = "小地圖的Layer要用什麼色? (Layer 1)";


L["layerHasBeenDisabled"] = "關閉鏡像 %s, 直到你再次開啟或是再次偵測之前，鏡像仍會在資料庫中。";
L["layerHasBeenEnabled"] = "啟用鏡像 %s, 現在回到計時與鏡像運算。";
L["layerDoesNotExist"] = "這鏡像編號 %s 不存在於資料庫。";
L["enableLayerButton"] = "啟動鏡像";
L["disableLayerButton"] = "關閉鏡像";
L["enableLayerButtonTooltip"] = "點擊以重新啟動鏡像,\n這將會將鏡像計時及圖層計算放回去。";
L["disableLayerButtonTooltip"] = "在伺服器重開之後，後點擊取消舊的鏡像。\n這將會忽略這個插件移除鏡像。";

L["Blackrock Mountain"] = "黑石山";