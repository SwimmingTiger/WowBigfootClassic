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
L["NefarianNpcKilledHordeWithTimer"] = "奈法利安增益NPC (薩魯法爾) 以經被殺了 %s 時間，之後沒有任何增益紀錄。";
L["onyxiaNpcKilledAllianceWithTimer"] = "奧妮克西婭增益NPC (瑪丁雷) 已經被殺了 %s 時間，之後沒有任何增益紀錄。";
L["NefarianNpcKilledAllianceWithTimer"] = "奈法利安增益NPC (艾法希比) 以經被殺了 %s 時間，之後沒有任何增益紀錄。";
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
L["Blessing of Blackfathom"] = "Blessing of Blackfathom";

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
L["cityMapLayerMsgHorde"] = "正確 %s\n選取奧格馬的任何NPC\n用來在傳換區域後更新鏡像。|r";
L["cityMapLayerMsgAlliance"] = "正確 %s\n選取暴風城的任何NPC\n用來在傳換區域後更新鏡像。|r";
L["noLayerYetHorde"] = "請點選奧格馬的任何NPC\n去找到你的鏡像。";
L["noLayerYetAlliance"] = "請點選暴風城的任何NPC\n去找到你的鏡像。";
L["Reset Data"] = "重置資料"; --A button to Reset buffs window data.