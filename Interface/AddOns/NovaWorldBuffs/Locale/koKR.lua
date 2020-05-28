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
L["NefarianNpcKilledHordeWithTimer"] = "네파리안 NPC (사울팽) 가 %s 전에 죽었고 이후 버프기록이 없습니다.";
L["onyxiaNpcKilledAllianceWithTimer"] = "오닉시아 NPC (매팅글리) 가 %s 전에 죽었고 이후 버프기록이 없습니다.";
L["NefarianNpcKilledAllianceWithTimer"] = "네파리안 NPC (아프라샤비) 가 %s 전에 죽었고 이후 버프기록이 없습니다.";
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