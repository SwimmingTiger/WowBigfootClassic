local L = LibStub("AceLocale-3.0"):NewLocale("NovaWorldBuffs", "koKR");
if (not L) then
    return;
end
 
--Rend buff aura name.
L["Warchief's Blessing"] = "대족장의 축복";
--Onyxia and Nefarian buff aura name.
L["Rallying Cry of the Dragonslayer"] = "용사냥꾼 재집결의 외침";
--Songflower buff aura name from felwood.
L["Songflower Serenade"] = "노래꽃의 세레나데";
L["Songflower"] = "노래꽃";
 
L["Flask of Supreme Power"] = "강력한 마력의 영약";
L["Flask of the Titans"] = "티탄의 영약";
L["Flask of Distilled Wisdom"] = "순수한 지혜의 영약";
L["Flask of Chromatic Resistance"] = "마력 저항의 영약";
--3 of the flasks spells seem to be named differently than the flask item, but titan is exact same name as the flask item.
L["Supreme Power"] = "강력한 마력";
L["Distilled Wisdom"] = "순수한 지혜";
L["Chromatic Resistance"] = "마력 저항";
 
---=====---
---Horde---
---=====---
 
--Horde Orgrimmar Rend buff NPC.
L["Thrall"] = "스랄";
--Horde The Barrens Rend buff NPC.
L["Herald of Thrall"] = "스랄의 전령";
--Horde rend buff NPC first yell string (part of his first yell msg before before buff).
L["Rend Blackhand, has fallen"] = "렌드 블랙핸드가 쓰러졌도다";
--Horde rend buff NPC second yell string (part of his second yell msg before before buff).
L["Be bathed in my power"] = "온몸으로 나의 힘을 느껴라";
 
--Horde Onyxia buff NPC.
L["Overlord Runthak"] = "대군주 룬탁";
--Horde Onyxia buff NPC first yell string (part of his first yell msg before before buff).
L["Onyxia, has been slain"] = "오닉시아가 처형됐도다";
--Horde Onyxia buff NPC second yell string (part of his second yell msg before before buff).
L["Be lifted by the rallying cry"] = "부인할 수 없는 대족장님의 힘을 보라";
 
--Horde Nefarian buff NPC.
L["High Overlord Saurfang"] = "대군주 사울팽";
--Horde Nefarian buff NPC first yell string (part of his first yell msg before before buff).
L["NEFARIAN IS SLAIN"] = "네파리안이 쓰러졌다";
--Horde Nefarian buff NPC second yell string (part of his second yell msg before before buff).
L["Revel in his rallying cry"] = "모두 함께 함성을 질러 승리를 축하하자";
 
---========---
---Alliance---
---========---
 
--Alliance Onyxia buff NPC.
L["Major Mattingly"] = "상사 매팅글리";
--Alliance Onyxia buff NPC first yell string (part of his first yell msg before before buff).
L["history has been made"] = "역사가 이루어졌노라";
--Alliance Onyxia buff NPC second yell string (part of his second yell msg before before buff).
L["Onyxia, hangs from the arches"] = "오닉시아의 목이 잘려 홍예문에 걸려 있다";
 
 
--Alliance Nefarian buff NPC.
L["Field Marshal Afrasiabi"] = "야전사령관 아프라샤비";
--Alliance Nefarian buff NPC first yell string (part of his first yell msg before before buff).
L["the Lord of Blackrock is slain"] = "검은바위부족의 군주가 쓰려졌다";
--Alliance Nefarian buff NPC second yell string (part of his second yell msg before before buff).
L["Revel in the rallying cry"] = "단결을 향한 외침을 즐겨라";
 
---===========----
---NPC's killed---
---============---
 
L["onyxiaNpcKilledHorde"] = "대군주 룬탁이 지금 죽었습니다 (오닉 버프 NPC).";
L["onyxiaNpcKilledAlliance"] = "상사 매팅글리가 지금 죽었습니다 (오닉 버프 NPC).";
L["nefarianNpcKilledHorde"] = "대군주 사울팽이 지금 죽었습니다 (네파 버프 NPC).";
L["nefarianNpcKilledAlliance"] = "야전사령관 아프라샤비가 지금 죽었습니다 (네파 버프 NPC).";
L["onyxiaNpcKilledHordeWithTimer"] = "오닉시아 NPC (룬탁) 가 %s 전에 죽었고 이후 버프기록이 없습니다.";
L["nefarianNpcKilledHordeWithTimer"] = "네파리안 NPC (사울팽) 가 %s 전에 죽었고 이후 버프기록이 없습니다.";
L["onyxiaNpcKilledAllianceWithTimer"] = "오닉시아 NPC (매팅글리) 가 %s 전에 죽었고 이후 버프기록이 없습니다.";
L["nefarianNpcKilledAllianceWithTimer"] = "네파리안 NPC (아프라샤비) 가 %s 전에 죽었고 이후 버프기록이 없습니다.";
L["anyNpcKilledWithTimer"] = "NPC 가 %s 전에 죽었다."; --Map timers tooltip msg.
 
 
---==============---
---Darkmoon Faire---
---==============---
 
L["Darkmoon Faire"] = "다크문 축제";
L["Sayge's Dark Fortune of Agility"] = "암흑의 세이지 점괘: 민첩성";
L["Sayge's Dark Fortune of Intelligence"] = "암흑의 세이지 점괘: 지능";
L["Sayge's Dark Fortune of Spirit"] = "암흑의 세이지 점괘: 정신력";
L["Sayge's Dark Fortune of Stamina"] = "암흑의 세이지 점괘: 체력";
L["Sayge's Dark Fortune of Strength"] = "암흑의 세이지 점괘: 힘";
L["Sayge's Dark Fortune of Armor"] = "암흑의 세이지 점괘: 방어도";
L["Sayge's Dark Fortune of Resistance"] = "암흑의 세이지 점괘: 저항력";
L["Sayge's Dark Fortune of Damage"] = "암흑의 세이지 점괘: 공격력";
L["dmfBuffCooldownMsg"] = "다크문 축제 버프 쿨다운 %s 남음.";
L["dmfBuffCooldownMsg2"] = "다크문 축제 버프 쿨다운 %s 남음.";
L["dmfBuffCooldownMsg3"] = "DMF Buff cooldown also resets with the weekly server reset."; --/wb frame 2nd msg.
L["dmfBuffReady"] = "다크문 축제 버프 가능"; --These 2 buff msgs are slightly different for a reason.
L["dmfBuffReset"] = "다크문 축제 버프 초기화"; --These 2 buff msgs are slightly different for a reason.
L["dmfBuffDropped"] = "다크문 축제 버프 %s 받음, 인게임 4시간 쿨다운. /buffs 로 확인";
L["dmfSpawns"] = "다크문 축제가 %s (%s) 이후 시작";
L["dmfEnds"] = "다크문 축제가 %s (%s) 이후 종료";
L["mulgore"] = "멀고어";
L["elwynnForest"] = "엘윈 숲";
 
---==============---
---Output Strings---
---==============---
 
L["rend"] = "렌드"; --Rend Blackhand
L["onyxia"] = "오닉"; --Onyxia
L["nefarian"] = "네파"; --Nefarian
L["dmf"] = "다크문 축제"; --Darkmoon Faire
L["noTimer"] = "기록 없음"; --No timer
L["noCurrentTimer"] = "현재 기록 없음"; --No current timer
L["noActiveTimers"] = "활성화된 기록 없음"; --No active timers
L["newBuffCanBeDropped"] = "%s 버프 가능";
L["buffResetsIn"] = "%s 버프가 %s 후 리셋";
L["rendFirstYellMsg"] = "대족장의 축복 6초 전!!";
L["onyxiaFirstYellMsg"] = "오닉 버프 14초 전!!";
L["nefarianFirstYellMsg"] = "네파 버프 15초 전!!";
L["rendBuffDropped"] = "대족장의 축복 완료!!";
L["onyxiaBuffDropped"] = "오닉 버프 완료!!";
L["nefarianBuffDropped"] = "네파 버프 완료!!";
L["onyxiaNpcKilledHorde"] = "대군주 룬탁이 죽음 (오닉버프 NPC).";
L["onyxiaNpcKilledAlliance"] = "상사 매팅글리가 죽음 (오닉버프 NPC).";
L["nefarianNpcKilledHorde"] = "대군주 사울팽이 죽음 (네파버프 NPC).";
L["nefarianNpcKilledAlliance"] = "야전사령관 아프라샤비가 죽음 (네파버프 NPC).";
L["newSongflowerReceived"] = "새 노래꽃 시간 받음"; --New songflower timer received
L["songflowerPicked"] = "%s 에 노래꽃 획득, 25분 후 재생성"; -- Guild msg when songflower picked.
L["North Felpaw Village"] = "악령발 마을(북)"; --Felwood map subzones (flower1).
L["West Felpaw Village"] = "악령발 마을(서)"; --Felwood map subzones (flower2).
L["North of Irontree Woods"] = "강철나무 숲(북)"; --Felwood map subzones (flower3).
L["Talonbranch Glade"] = "갈퀴가지 숲"; --Felwood map subzones (flower4).
L["Shatter Scar Vale"] = "피멍울 폭포"; --Felwood map subzones (flower5).
L["Bloodvenom Post"] = "피멍울초소"; --Felwood map subzones (flower6).
L["East of Jaedenar"] = "자에데나르(동)"; --Felwood map subzones (flower7).
L["North of Emerald Sanctuary"] = "에메랄드 성소(북)"; --Felwood map subzones (flower8).
L["West of Emerald Sanctuary"] = "에메랄드 성소(서)"; --Felwood map subzones (flower9).
L["South of Emerald Sanctuary"] = "에메랄드 성소(남)"; --Felwood map subzones (flower10).
L["second"] = "초"; --Second (singular).
L["seconds"] = "초"; --Seconds (plural).
L["minute"] = "분"; --Minute (singular).
L["minutes"] = "분"; --Minutes (plural).
L["hour"] = "시간"; --Hour (singular).
L["hours"] = "시간"; --Hours (plural).
L["day"] = "일"; --Day (singular).
L["days"] = "일"; --Days (plural).
L["secondShort"] = "초"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "분"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "시간"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "일"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "%s 이후 개최"; --"Starts in 1hour".
L["endsIn"] = "%s 이후 종료"; --"Ends in 1hour".
L["versionOutOfDate"] = "Nova World Buffs 애드온을 트위치나 URL을 통해 업데이트 해주세요. https://www.curseforge.com/wow/addons/nova-world-buffs";
L["Your Current World Buffs"] = "현재 월드 버프";
L["Options"] = "Options";
 
---New stuff---
 
--Spirit of Zandalar buff NPC first yell string (part of his first yell msg before before buff).
L["Begin the ritual"] = "의식을 시작하라"
L["The Blood God"] = "공포의 혈신"; --First Booty bay yell from Zandalarian Emissary.
--Spirit of Zandalar buff NPC second yell string (part of his second yell msg before before buff).
L["slayer of Hakkar"] = "학카르를 물리친 아제로스의 영웅이여";
 
L["Spirit of Zandalar"] = "잔달라의 영혼";
L["Molthor"] = "몰소르";
L["Zandalarian Emissary"] = "잔달라부족 사절";
L["Whipper Root Tuber"] = "채찍뿌리 줄기";
L["Night Dragon's Breath"] = "어둠용의 숨결";
L["Resist Fire"] = "상층 화염저항"; -- LBRS fire resist buff.
L["Blessing of Blackfathom"] = "검은심연의 축복";
 
L["zan"] = "잔달라";
L["zanFirstYellMsg"] = "잔달라버프 30초 전!!";
L["zanBuffDropped"] = "잔달라버프 끝!!";
L["singleSongflowerMsg"] = "%s의 노래꽃 %s 재생성"; -- Songflower at Bloodvenom Post spawns at 1pm.
L["spawn"] = "재생성"; --Used in Felwood map marker tooltip (03:46pm spawn).
L["Irontree Woods"] = "강철나무 숲";
L["West of Irontree Woods"] = "강철나무 숲(서)";
L["Bloodvenom Falls"] = "피멍울 폭포";
L["Jaedenar"] = "자에데나르";
L["North-West of Irontree Woods"] = "강철나무 숲(북서)";
L["South of Irontree Woods"] = "강철나무 숲(남)";
 
L["worldMapBuffsMsg"] = "/buff 명령으로 당신 케릭터들의 \n월드버프를 보여줍니다.";
L["cityMapLayerMsgHorde"] = "현재 위상은 %s 입니다.\n지역변경 후 오그리마 내 NPC를 \n타겟하면 위상이 업데이트 됩니다.|r";
L["cityMapLayerMsgAlliance"] = "현재 위상은 %s 입니다.\n지역변경 후 스톰윈드 내 \n NPC를 타겟하면 위상이 업데이트 됩니다.|r";
L["noLayerYetHorde"] = "오그리마 내 아무 NPC를 타겟하면 \n당신의 위상을 특정하고 시간을 가져옵니다.";
L["noLayerYetAlliance"] = "스톰윈드 내 아무 NPC를 타겟하면 \n당신의 위상을 특정하고 시간을 가져옵니다.";
L["Reset Data"] = "기록 리셋"; --A button to Reset buffs window data.

---New translations to do---
L["layerFrameMsgOne"] = "Old layers will still show for a few hours after server restarts."; --Msg at bottom of layer timers frame.
L["layerFrameMsgTwo"] = "Layers will disappear from here 8 hours after having no timers."; --Msg at bottom of layer timers frame.
L["You are currently on"] = "You are currently on"; --You are currently on [Layer 2]


-------------
---Config---
-------------
--There are 2 types of strings here, the names end in Title or Desc L["exampleTitle"] and L["exampleDesc"].
--Title must not be any longer than 21 characters (maybe less for chinese characters because they are larger).
--Desc can be any length.

---Description at the top---
L["mainTextDesc"] = "Type /wb to display timers to yourself.\nType /wb <channel> to display timers to the specified channel.\nScroll down for more options.";

---Show Buffs Button
L["showBuffsTitle"] = "Click To Show Your Current World Buffs";
L["showBuffsDesc"] = "Show your current world buffs for all your characters, this can also be opened by typing /buffs or clicking on the [WorldBuffs] prefix in chat.";

---General Options---
L["generalHeaderDesc"] = "General Options";

L["showWorldMapMarkersTitle"] = "City Map Timers";
L["showWorldMapMarkersDesc"] = "Show timer icons on the Orgrimmar/Stormwind world map?";

L["receiveGuildDataOnlyTitle"] = "Guild Data Only";
L["receiveGuildDataOnlyDesc"] = "This will make it so you don't get timer data from anyone outside the guild. You should only enable this if you think someone is spoofing wrong timer data on purpose because it will lower the accuracy of your timers with less people to pull data from. It will make it especially hard to get songflower timers becaus they are so short. Every single person in the guild needs this enabled for it to even work.";

L["chatColorTitle"] = "Chat Msg Color";
L["chatColorDesc"] = "What color should the timer msgs in chat be?";

L["middleColorTitle"] = "Middle Screen Color";
L["middleColorDesc"] = "What color should the raid warning style msgs in the middle of the screen be?";

L["resetColorsTitle"] = "Reset Colors";
L["resetColorsDesc"] = "Reset colors back to default.";

L["showTimeStampTitle"] = "Show Time Stamp";
L["showTimeStampDesc"] = "Show a time stamp (1:23pm) beside the timer msg?";

L["timeStampFormatTitle"] = "Time Stamp Format";
L["timeStampFormatDesc"] = "Set which timestamp format to use, 12 hour (1:23pm) or 24 hour (13:23).";

L["timeStampZoneTitle"] = "Local Time / Server Time";
L["timeStampZoneDesc"] = "Use local time or server time for timestamps?";

L["colorizePrefixLinksTitle"] = "Colored Prefix Link";
L["colorizePrefixLinksDesc"] = "Colorize the prefix [WorldBuffs] in all chat channels? This is the prefix in chat you can click to show all your characters current world buffs.";

L["showAllAltsTitle"] = "Show All Alts";
L["showAllAltsDesc"] = "Show all alts in the /buffs window even if they don't have an active buff?";

L["minimapButtonTitle"] = "Show Minimap Button";
L["minimapButtonDesc"] = "Show the NWB button the minimap?";

---Logon Messages---
L["logonHeaderDesc"] = "Logon Messages";

L["logonPrintTitle"] = "Logon Timers";
L["logonPrintDesc"] = "Show timers in the chat window when you log on, you can disable all logon msgs with this setting.";

L["logonRendTitle"] = "Rend";
L["logonRendDesc"] = "Show Rend timer in the chat window when you log on.";

L["logonOnyTitle"] = "Onyxia";
L["logonOnyDesc"] = "Show Onyxia timer in the chat window when you log on.";

L["logonNefTitle"] = "Nefarian";
L["logonNefDesc"] = "Show Nefarian timer in the chat window when you log on.";

L["logonDmfSpawnTitle"] = "DMF Spawn";
L["logonDmfSpawnDesc"] = "Show Darkmoon Faire spawn time, this will only show when there is less than 6 hours left until spawn or despawn.";

L["logonDmfBuffCooldownTitle"] = "DMF Buff Coooldown";
L["logonDmfBuffCooldownDesc"] = "Show Darkmoon Faire buff 4 hour cooldown, this will only show when you have an ative cooldown and when DMF is up.";

---Chat Window Timer Warnings---
L["chatWarningHeaderDesc"] = "Chat Window Timer Warnings";

L["chat30Title"] = "30 Minutes";
L["chat30Desc"] = "Print a msg in chat when 30 minutes left.";

L["chat15Title"] = "15 Minutes";
L["chat15Desc"] = "Print a msg in chat when 15 minutes left.";

L["chat10Title"] = "10 Minutes";
L["chat10Desc"] = "Print a msg in chat when 10 minutes left.";

L["chat5Title"] = "5 Minutes";
L["chat5Desc"] = "Print a msg in chat when 5 minutes left.";

L["chat1Title"] = "1 Minute";
L["chat1Desc"] = "Print a msg in chat when 1 minute left.";

L["chatResetTitle"] = "Buff Has Reset";
L["chatResetDesc"] = "Print a msg in chat when a buff has reset and a new one can be dropped.";

L["chatZanTitle"] = "Zandalar Buff Warning";
L["chatZanDesc"] = "Print a msg in chat 30 seconds before Zandalar buff will drop when the NPC starts yelling.";

---Middle Of The Screen Timer Warnings---
L["middleWarningHeaderDesc"] = "Middle Of The Screen Timer Warnings";

L["middle30Title"] = "30 Minutes";
L["middle30Desc"] = "Show a raid warning style msg in the middle of the screen when 30 minutes left.";

L["middle15Title"] = "15 Minutes";
L["middle15Desc"] = "Show a raid warning style msg in the middle of the screen when 15 minutes left.";

L["middle10Title"] = "10 Minutes";
L["middle10Desc"] = "Show a raid warning style msg in the middle of the screen when 10 minutes left.";

L["middle5Title"] = "5 Minutes";
L["middle5Desc"] = "Show a raid warning style msg in the middle of the screen when 5 minutes left.";

L["middle1Title"] = "1 Minute";
L["middle1Desc"] = "Show a raid warning style msg in the middle of the screen when 1 minute left.";

L["middleResetTitle"] = "Buff Has Reset";
L["middleResetDesc"] = "Show a raid warning style msg in the middle of the screen when a buff has reset and a new one can be dropped.";

L["middleBuffWarningTitle"] = "Buff Drop Warning";
L["middleBuffWarningDesc"] = "Show a raid warning style msg in the middle of the screen when someone hands in the head for any buff and the NPC yells a few seconds before the buff will drop.";

L["middleHideCombatTitle"] = "Hide In Combat";
L["middleHideCombatDesc"] = "Hide middle of the screen warnings in combat?";

L["middleHideRaidTitle"] = "Hide In Raid";
L["middleHideRaidDesc"] = "Hide middle of the screen warnings in raid instances? (Doesn't hide in normal dungeons)";

---Guild Messages---
L["guildWarningHeaderDesc"] = "Guild Messages";

L["guild10Title"] = "10 Minutes";
L["guild10Desc"] = "Send a message to guild chat when 10 minutes left.";

L["guild1Title"] = "1 Minute";
L["guild1Desc"] = "Send a message to guild chat when 1 minute left.";

L["guildNpcDialogueTitle"] = "NPC Dialogue Started";
L["guildNpcDialogueDesc"] = "Send a message to guild when someone hands in a head and the NPC first yells and you still have time to relog if fast?";

L["guildBuffDroppedTitle"] = "New Buff Dropped";
L["guildBuffDroppedDesc"] = "Send a message to guild when a new buff has been dropped? This msg is sent after the NPC is finished yelling and you get the actual buff a few seconds later. (6 seconds after first yell for rend, 14 seconds for ony, 15 seconds for nef)";

L["guildZanDialogueTitle"] = "Zandalar Buff Warning";
L["guildZanDialogueDesc"] = "Send a message to guild when Spirit of Zandalar buff is about to drop? (If you want no guild msgs at all for this buff then everyone in guild needs to disable this).";

L["guildNpcKilledTitle"] = "NPC Was Killed";
L["guildNpcKilledDesc"] = "Send a message to guild when one of the buff NPC's were killed in Orgrimmar or Stormwind? (mind control reset).";

L["guildCommandTitle"] = "Guild Commands";
L["guildCommandDesc"] = "Reply with timer info to !wb and !dmf commands in guild chat? You should probably leave this enabled to help your guild, if you really want to disable all guild msgs and leave only this command then untick everything else in the guild sectionand don't tick the Disable All Guild Msgs at the top.";

L["disableAllGuildMsgsTitle"] = "Disable All Guild Msgs";
L["disableAllGuildMsgsDesc"] = "Disable all guild messages including timers and when buffs drop? Note: You can disable all msgs one by one above and just leave certain things enabled to help out your guild if you rather.";

---Songflowers---
L["songflowersHeaderDesc"] = "Songflowers";

L["guildSongflowerTitle"] = "Tell Guild When Picked";
L["guildSongflowerDesc"] = "Tell your guild chat when you have picked a songflower with the time of next spawn?";

L["mySongflowerOnlyTitle"] = "Only When I Pick";
L["mySongflowerOnlyDesc"] = "Only record a new timer when I pick a songflower and not when others pick infront of me? This option is here just incase you have problems with false timers being set from other players. There's currently no way to tell if another players buff is new so a timer may trigger on rare occasions if the game loads the songflower buff on someone else when they logon infront of you beside a songflower.";

L["syncFlowersAllTitle"] = "Sync Flowers With All";
L["syncFlowersAllDesc"] = "Enable this to override the guild only data setting at the top of this config so you can share songflower data outside the guild but keep worldbuff data guild only still.";

L["showNewFlowerTitle"] = "Show New SF Timers";
L["showNewFlowerDesc"] = "This will show you in chat window when a new flower timer is found from another player not in your guild (guild msgs already show in guild chat when a flower is picked).";

L["showSongflowerWorldmapMarkersTitle"] = "Songflower Worldmap";
L["showSongflowerWorldmapMarkersDesc"] = "Show songflower icons on the world map?";

L["showSongflowerMinimapMarkersTitle"] = "Songflower Minimap";
L["showSongflowerMinimapMarkersDesc"] = "Show songflower icons on the mini map?";

L["showTuberWorldmapMarkersTitle"] = "Tuber Worldmap";
L["showTuberWorldmapMarkersDesc"] = "Show Whipper Root Tuber icons on the world map?";

L["showTuberMinimapMarkersTitle"] = "Tuber Minimap";
L["showTuberMinimapMarkersDesc"] = "Show Whipper Root Tuber icons on the mini map?";

L["showDragonWorldmapMarkersTitle"] = "Dragon Worldmap";
L["showDragonWorldmapMarkersDesc"] = "Show Night Dragon's Breath icons on the world map?";

L["showDragonMinimapMarkersTitle"] = "Dragon Minimap";
L["showDragonMinimapMarkersDesc"] = "Show Night Dragon's Breath icons on the mini map?";

L["showExpiredTimersTitle"] = "Show Expired Timers";
L["showExpiredTimersDesc"] = "Show expired timers in Felwood? They will be shown in red text how long ago a timer expired, the default time is 5 minutes (people say songflowers stay cleansed for 5 minutes after spawn?).";

L["expiredTimersDurationTitle"] = "Expired Timers Duraton";
L["expiredTimersDurationDesc"] = "How long should Felwood timers show for after expiring on the world map?";

---Darkmoon Faire---
L["dmfHeaderDesc"] = "Darkmoon Faire";

L["dmfTextDesc"] = "Your DMF damage buff cooldown will also show on the Darkmoon Faire map icon when you hover it, if you have a cooldown and DMF is currently up.";

L["showDmfWbTitle"] = "Show DMF with /wb";
L["showDmfWbDesc"] = "Show DMF spawn timer together with /wb command?";

L["showDmfBuffWbTitle"] = "DMF Buff Cooldown /wb";
L["showDmfBuffWbDesc"] = "Show your DMF buff cooldown timer together with /wb command? Only shows when you are on an active cooldown and DMF is currently up.";

L["showDmfMapTitle"] = "Show Map Marker";
L["showDmfMapDesc"] = "Show DMF map marker with spawn timer and buff cooldown info in Mulgore and Elwynn Forest world maps (whichever is next spawn). You can also type /dmf map to open the world map strait to this marker.";

---Guild Chat Filter---
L["guildChatFilterHeaderDesc"] = "Guild Chat Filter";

L["guildChatFilterTextDesc"] = "This will block any guild msgs from this addon you choose so you don't see them. It will stop you from seeing your own msgs and msgs from other addon users in guild chat.";

L["filterYellsTitle"] = "Filter Buff Warning";
L["filterYellsDesc"] = "Filter the msg when a buff is about to drop in a few seconds (Onyxia will drop in 14 seconds).";

L["filterDropsTitle"] = "Filter Buff Dropped";
L["filterDropsDesc"] = "Filter the msg when a buff has dropped (Rallying Cry of the Dragonslayer (Onyxia) has dropped).";

L["filterTimersTitle"] = "Filter Timer Msgs";
L["filterTimersDesc"] = "Filter timer msgs (Onyxia resets in 1 minute).";

L["filterCommandTitle"] = "Filter !wb command";
L["filterCommandDesc"] = "Filter the !wb and !dmf in guild chat when typed by players.";

L["filterCommandResponseTitle"] = "Filter !wb reply";
L["filterCommandResponseDesc"] = "Filter the reply msg with timers this addon does when !wb or !!dmf is used.";

L["filterSongflowersTitle"] = "Filter Songflowers";
L["filterSongflowersDesc"] = "Filter the msg when a songflower is picked.";

L["filterNpcKilledTitle"] = "Filter NPC Killed";
L["filterNpcKilledDesc"] = "Filter the msg when a buff hand in NPC is killed in your city.";

---Sounds---
L["soundsHeaderDesc"] = "Sounds";

L["soundsTextDesc"] = "Set sound to \"None\" to disable.";

L["disableAllSoundsTitle"] = "Disable All Sounds";
L["disableAllSoundsDesc"] = "Disable all sounds from this addon.";

L["extraSoundOptionsTitle"] = "Extra Sound Options";
L["extraSoundOptionsDesc"] = "Enable this to display all the sounds from all your addons at once in the dropdown lists here.";

L["soundOnlyInCityTitle"] = "Only In City";
L["soundOnlyInCityDesc"] = "Only play buff sounds when you are in the main city where the buffs drop (Stranglethorn Vale included for Zandalar buff).";

L["soundsDisableInInstancesTitle"] = "Disable In Instances";
L["soundsDisableInInstancesDesc"] = "Disable sounds while in raids and instances.";

L["soundsFirstYellTitle"] = "Buff Coming";
L["soundsFirstYellDesc"] = "Sound to play when head is handed in and you have a few seconds before buff will drop (First NPC Yell).";

L["soundsOneMinuteTitle"] = "One Minute Warning";
L["soundsOneMinuteDesc"] = "Sound to play for 1 minute left timer warning.";

L["soundsRendDropTitle"] = "Rend Buff Gained";
L["soundsRendDropDesc"] = "Sound to play for Rend buff drops and you get the buff.";

L["soundsOnyDropTitle"] = "Ony Buff Gained";
L["soundsOnyDropDesc"] = "Sound to play for Onyxia buff drops and you get the buff.";

L["soundsNefDropTitle"] = "Nef Buff Gained";
L["soundsNefDropDesc"] = "Sound to play for Nefarian buff drops and you get the buff.";

L["soundsZanDropTitle"] = "Zandalar Buff Gained";
L["soundsZanDropDesc"] = "Sound to play for Zandalar buff drops and you get the buff.";

---Flash When Minimized---
L["flashHeaderDesc"] = "Flash When Minimized";

L["flashOneMinTitle"] = "Flash One Minute";
L["flashOneMinDesc"] = "Flash the wow client when you have it minimized and 1 minute is left on timer?";

L["flashFirstYellTitle"] = "Flash NPC Yell";
L["flashFirstYellDesc"] = "Flash the wow client when you have it minimized and the NPC's yells a few seconds before buff drops?";

L["flashFirstYellZanTitle"] = "Flash Zandalar";
L["flashFirstYellZanDesc"] = "Flash the wow client when you have it minimized and the Zandalar buff is about to go out?";

---Faction/realm specific options---

L["allianceEnableRendTitle"] = "Enable Alliance Rend";
L["allianceEnableRendDesc"] = "Enable this to track rend as Alliance, for guilds that mind control to get rend buff. If you use this then everyone in the guild with the addon should enable it or guild chat msgs may not work properly (personal timer msgs will still work).";

L["minimapLayerFrameTitle"] = "Show Minimap Layer";
L["minimapLayerFrameDesc"] = "Show the little frame on the minimap with your current layer while in a capital city?";

L["minimapLayerFrameResetTitle"] = "Reset Minimap Layer";
L["minimapLayerFrameResetDesc"] = "Reset minimap layer frame back to default position (hold shift to drag the minimap frame).";

---Dispels---
L["dispelsHeaderDesc"] = "Dispels";

L["dispelsMineTitle"] = "My Buffs";
L["dispelsMineDesc"] = "Show in chat my buffs being dispelled? This shows who dispelled you and what buff.";

L["dispelsMineWBOnlyTitle"] = "My Worldbuffs Only";
L["dispelsMineWBOnlyDesc"] = "Only show my worldbuffs being dispelled and not any other kind of buffs.";

L["soundsDispelsMineTitle"] = "My Buffs Sound";
L["soundsDispelsMineDesc"] = "Which sound to play for my buffs being dispelled.";

L["dispelsAllTitle"] = "Other Players Buffs";
L["dispelsAllDesc"] = "Show in chat everyone's buffs being dispelled around me? This shows who dispelled anyone close to you and what buff.";

L["dispelsAllWBOnlyTitle"] = "Others Worldbuffs Only";
L["dispelsAllWBOnlyDesc"] = "Only show worldbuffs on everyone else being dispelled and not any other kind of buffs.";

L["soundsDispelsAllTitle"] = "Others Players Buffs Sound";
L["soundsDispelsAllDesc"] = "Which sound to play for other players buffs being dispelled.";

L["middleHideBattlegroundsTitle"] = "Hide In Battlegrounds";
L["middleHideBattlegroundsDesc"] = "Hide middle of the screen warnings in Battlegrounds?";

L["soundsDisableInBattlegroundsTitle"] = "Disable In Battleground";
L["soundsDisableInBattlegroundsDesc"] = "Disable sounds while in Battlegrounds.";

L["autoBuffsHeaderDesc"] = "Auto Get Buffs From NPCs";

L["autoDmfBuffTitle"] = "Auto Get DMF Buff";
L["autoDmfBuffDesc"] = "Do you want this addon to auto select a Darkmoon Faire buff for you when you speak to the Sayge NPC? Make sure you pick which buff you want also.";

L["autoDmfBuffTypeTitle"] = "Which DMF Buff";
L["autoDmfBuffTypeDesc"] = "Which Darkmoon Faire buff do you want this addon to auto select for you when you speak to Sayge?";

L["autoDireMaulBuffTitle"] = "Dire Maul Buffs";
L["autoDireMaulBuffDesc"] = "Do you want this addon to auto get buffs from the NPC's in Dire Maul when you talk to them? (Also auto gets King buff).";

L["autoBwlPortalTitle"] = "Auto BWL Portal";
L["autoBwlPortalDesc"] = "Do you want this addon to auto use the Blackwing Lair portal when you click the orb?";

L["showBuffStatsTitle"] = "Show Buff Stats";
L["showBuffStatsDesc"] = "Show how many times you've gotten each world buff in the /buffs frame? Ony/Nef/Rend/Zand buffs have been recording since the buffs frame was put in, but the rest of the buffs only started recording now in version 1.65";

L["buffResetButtonTooltip"] = "This will reset all buffs.\nBuff count data will not be reset."; --Reset button tooltip for the /buffs frame.
L["time"] = "time"; --Singular - This shows how many timers you got a buff. Example: (1 time)
L["times"] = "times"; --Plural - This shows how many timers you got a buff. Example: (5 times)