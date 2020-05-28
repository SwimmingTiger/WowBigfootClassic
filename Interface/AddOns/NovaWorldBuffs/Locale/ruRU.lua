local L = LibStub("AceLocale-3.0"):NewLocale("NovaWorldBuffs", "ruRU");
if (not L) then
	return;
end

--Rend buff aura name.
L["Warchief's Blessing"] = "Благословление вождя";
--Onyxia and Nefarian buff aura name.
L["Rallying Cry of the Dragonslayer"] = "Ободряющий клич Драконоборца";
--Songflower buff aura name from felwood.
L["Songflower Serenade"] = "Серенада песнецвета";
L["Songflower"] = "Песнецвет";
--Spirit of Zandalar.
L["Spirit of Zandalar"] = "Дух Зандалара";
L["Flask of Supreme Power"] = "Настой великой силы";
L["Flask of the Titans"] = "Склянка Титанов";
L["Flask of Distilled Wisdom"] = "Настой Концентрированной мудрости";
L["Flask of Chromatic Resistance"] = "Настой всецветного сопротивления";
--3 of the flasks spells seem to be named differently than the flask item, but titan is exact same name as the flask item.
L["Supreme Power"] = "Превосходная мощь";
L["Distilled Wisdom"] = "Очищенная мудрость";
L["Chromatic Resistance"] = "Всецветное сопротивление";

---=====---
---Horde---
---=====---

--Horde Orgrimmar Rend buff NPC.
L["Thrall"] = "Тралл";
--Horde The Barrens Rend buff NPC.
L["Herald of Thrall"] = "Глашатай Тралла";
--Horde rend buff NPC first yell string (part of his first yell msg before before buff).
L["Rend Blackhand, has fallen"] = "Самозванец Ренд Чернорук мертв";
--Horde rend buff NPC second yell string (part of his second yell msg before before buff).
L["Be bathed in my power"] = "Проникнитесь моей мощью";

--Horde Onyxia buff NPC.
L["Overlord Runthak"] = "Властитель Рунтак";
--Horde Onyxia buff NPC first yell string (part of his first yell msg before before buff).
L["Onyxia, has been slain"] = "Царица черных драконов Ониксия убита";
--Horde Onyxia buff NPC second yell string (part of his second yell msg before before buff).
L["Be lifted by the rallying cry"] = "Узри неоспоримую силу своего Вождя";

--Horde Nefarian buff NPC.
L["High Overlord Saurfang"] = "Верховный воевода Саурфанг";
--Horde Nefarian buff NPC first yell string (part of his first yell msg before before buff).
L["NEFARIAN IS SLAIN"] = "НЕФАРИАН УБИТ";
--Horde Nefarian buff NPC second yell string (part of his second yell msg before before buff).
L["Revel in his rallying cry"] = "Внемлите боевому кличу";

---========---
---Alliance---
---========---

--Alliance Onyxia buff NPC.
L["Major Mattingly"] = "Майор Маттингли";
--Alliance Onyxia buff NPC first yell string (part of his first yell msg before before buff).
L["history has been made"] = "в этот день вершилась история";
--Alliance Onyxia buff NPC second yell string (part of his second yell msg before before buff).
L["Onyxia, hangs from the arches"] = "Ониксия подвешена под сводами";


--Alliance Nefarian buff NPC.
L["Field Marshal Afrasiabi"] = "Фельдмаршал Афрасиаби";
--Alliance Nefarian buff NPC first yell string (part of his first yell msg before before buff).
L["the Lord of Blackrock is slain"] = "Владыка Черной горы повержен";
--Alliance Nefarian buff NPC second yell string (part of his second yell msg before before buff).
L["Revel in the rallying cry"] = "Соберитесь вокруг своей защитницы";

---===========----
---NPC's killed---
---============---

L["onyxiaNpcKilledHorde"] = "Властитель Рунтак был убит (NPC, который бафает Ониксию).";
L["onyxiaNpcKilledAlliance"] = "Майор Маттингли был убит (NPC, который бафает Ониксию).";
L["nefarianNpcKilledHorde"] = "Верховный воевода Саурфанг был убит (NPC, который бафает Нефариана).";
L["nefarianNpcKilledAlliance"] = "Фельдмаршал Афрасиаби был убит (NPC, который бафает Нефариана).";
L["onyxiaNpcKilledHordeWithTimer"] = "Рунтак (баф Ониксии) был убит %s назад. С тех пор баф не был зафиксирован.";
L["NefarianNpcKilledHordeWithTimer"] = "Саурфанг (баф Нефариана) был убит %s назад. С тех пор баф не был зафиксирован.";
L["onyxiaNpcKilledAllianceWithTimer"] = "Маттингли (баф Ониксии) был убит %s назад. С тех пор баф не был зафиксирован.";
L["NefarianNpcKilledAllianceWithTimer"] = "Афрасиаби (баф Нефариана) был убит %s назад. С тех пор баф не был зафиксирован.";
L["anyNpcKilledWithTimer"] = "был убит %s назад"; --Map timers tooltip msg.

---==============---
---Darkmoon Faire---
---==============---

L["Darkmoon Faire"] = "Ярмарка Новолуния";
L["Sayge's Dark Fortune of Agility"] = "Темный жребий Сейджа - ловкость";
L["Sayge's Dark Fortune of Intelligence"] = "Темный жребий Сейджа - разум";
L["Sayge's Dark Fortune of Spirit"] = "Темный жребий Сейджа - дух";
L["Sayge's Dark Fortune of Stamina"] = "Темный жребий Сейджа - выносливость";
L["Sayge's Dark Fortune of Strength"] = "Темный жребий Сейджа - сила";
L["Sayge's Dark Fortune of Armor"] = "Темный жребий Сейджа - защита";
L["Sayge's Dark Fortune of Resistance"] = "Темный жребий Сейджа - сопротивление";
L["Sayge's Dark Fortune of Damage"] = "Темный жребий Сейджа - урон";
L["dmfBuffCooldownMsg"] = "Баф Ярмарки Новолуния на перезарядке еще %s.";
L["dmfBuffReady"] = "Баф Ярмарки Новолуния откатился.";
L["dmfBuffReset"] = "Баф Ярмарки Новолуния откатился.";
L["dmfBuffDropped"] = "Баф Ярмарки Новолуния %s получен. Отслеживать 5-часовую перезарядку бафа можно с помощью команды /dmf.";
L["dmfSpawns"] = "Ярмарка Новолуния появится через %s (%s)";
L["dmfEnds"] = "Ярмарка Новолуния в данный момент работает и закончится через %s (%s)";
L["mulgore"] = "Мулгор";
L["elwynnForest"] = "Элвиннский лес";
				
---==============---
---Output Strings---
---==============---

L["rend"] = "Ренд"; --Rend Blackhand
L["onyxia"] = "Ониксия"; --Onyxia
L["nefarian"] = "Нефариан"; --Nefarian
L["dmf"] = "Ярмарка Новолуния"; --Darkmoon Faire
L["noTimer"] = "—"; --No timer (used only in map timer frames)
L["noCurrentTimer"] = "Таймер отсутствует"; --No current timer
L["noActiveTimers"] = "Таймер отсутствует";	--No active timers
L["newBuffCanBeDropped"] = "%s может быть поставлен(а) сейчас";
L["buffResetsIn"] = "%s откатится через %s";
L["rendFirstYellMsg"] = "Ренд будет бафнут через 6 секунд.";
L["onyxiaFirstYellMsg"] = "Ониксия будет бафнута через 14 секунд.";
L["nefarianFirstYellMsg"] = "Нефариан будет бафнут через 15 секунд.";
L["rendBuffDropped"] = "Благословление вождя (Ренд) было бафнуто.";
L["onyxiaBuffDropped"] = "Ободряющий клич Драконоборца (Ониксия) был бафнут.";
L["nefarianBuffDropped"] = "Ободряющий клич Драконоборца (Нефариан) был бафнут.";
L["newSongflowerReceived"] = "Получен новый таймер Песнецвета"; --New songflower timer received
L["songflowerPicked"] = "Песнецвет взят в локации: %s. Следующий через 25 мин."; -- Guild msg when songflower picked.
L["North Felpaw Village"] = "Деревня сквернолапов — Север"; --Felwood map subzones (flower1).
L["West Felpaw Village"] = "Деревня сквернолапов — Запад"; --Felwood map subzones (flower2).
L["North of Irontree Woods"] = "Железнолесье — Север"; --Felwood map subzones (flower3).
L["Talonbranch Glade"] = "Поляна Когтистых Ветвей"; --Felwood map subzones (flower4).
L["Shatter Scar Vale"] = "Долина Рваных Ран"; --Felwood map subzones (flower5).
L["Bloodvenom Post"] = "Застава Отравленной Крови"; --Felwood map subzones (flower6).
L["East of Jaedenar"] = "Джеденар — Восток"; --Felwood map subzones (flower7).
L["North of Emerald Sanctuary"] = "Изумрудное святилище — Север"; --Felwood map subzones (flower8).
L["West of Emerald Sanctuary"] = "Изумрудное святилище — Запад"; --Felwood map subzones (flower9).
L["South of Emerald Sanctuary"] = "Изумрудное святилище — Юг"; --Felwood map subzones (flower10).
L["second"] = "сек"; --Second (singular).
L["seconds"] = "сек"; --Seconds (plural).
L["minute"] = "мин"; --Minute (singular).
L["minutes"] = "мин"; --Minutes (plural).
L["hour"] = "ч"; --Hour (singular).
L["hours"] = "ч"; --Hours (plural).
L["day"] = "д"; --Day (singular).
L["days"] = "д"; --Days (plural).
L["secondShort"] = "с"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "м"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "ч"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "д"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "Начнется через %s"; --"Starts in 1hour".
L["endsIn"] = "Закончится через %s"; --"Ends in 1hour".
L["versionOutOfDate"] = "Ваша версия аддона Nova World Buffs устарела. Пожалуйста, обновите ее по ссылке https://www.curseforge.com/wow/addons/nova-world-buffs или через Twitch-клиент";
L["Your Current World Buffs"] = "Ваши текущие мировые бафы";
L["Options"] = "Настройки";

---New stuff---

--Spirit of Zandalar buff NPC first yell string (part of his first yell msg before before buff).
L["Begin the ritual"] = "Начинайте ритуал"
L["The Blood God"] = "Кровавый Свежеватель Душ"; --First Booty bay yell from Zandalarian Emissary.
--Spirit of Zandalar buff NPC second yell string (part of his second yell msg before before buff).
L["slayer of Hakkar"] = "победитель Хаккара";

L["Molthor"] = "Молтор";
L["Zandalarian Emissary"] = "Зандаларский эмиссар";
L["Whipper Root Tuber"] = "Плод кнутокорня";
L["Night Dragon's Breath"] = "Ночное дыхание дракона";
L["Resist Fire"] = "Сопротивление огню"; -- LBRS fire resist buff.
L["Blessing of Blackfathom"] = "Благословение Черных Глубин";

L["zan"] = "Зандалар";
L["zanFirstYellMsg"] = "Зандалар будет бафнут через 30 секунд.";
L["zanBuffDropped"] = "Дух Зандалара (Хаккар) был бафнут.";
L["singleSongflowerMsg"] = "Песнецвет в локации: %s заспавнится в %s."; -- Songflower at Bloodvenom Post spawns at 1pm.
L["spawn"] = ""; --Used in Felwood map marker tooltip (03:46pm spawn). (blank for russian on purpose)
L["Irontree Woods"] = "Железнолесье";
L["West of Irontree Woods"] = "Железнолесье — Запад";
L["Bloodvenom Falls"] = "Водопад отравленной крови";
L["Jaedenar"] = "Джеденар";
L["North-West of Irontree Woods"] = "Железнолесье — Северо-восток";
L["South of Irontree Woods"] = "Железнолесье — Юг";