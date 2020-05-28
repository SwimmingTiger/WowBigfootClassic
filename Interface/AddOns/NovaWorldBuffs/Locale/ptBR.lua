local L = LibStub("AceLocale-3.0"):NewLocale("NovaWorldBuffs", "ptBR");
if (not L) then
	return;
end

--Rend buff aura name.
L["Warchief's Blessing"] = "Bênção do Chefe Guerreiro";
--Onyxia and Nefarian buff aura name.
L["Rallying Cry of the Dragonslayer"] = "Brado Empolgante do Mata-dragões";
--Songflower buff aura name from felwood.
L["Songflower Serenade"] = "Serenata Flor da Canção";
L["Songflower"] = "Serenata Flor";
--Spirit of Zandalar.
L["Spirit of Zandalar"] = "Spirit of Zandalar";
L["Flask of Supreme Power"] = "Flask of Supreme Power";
L["Flask of the Titans"] = "Frasco dos Titãs";
L["Flask of Distilled Wisdom"] = "Flask of Distilled Wisdom";
L["Flask of Chromatic Resistance"] = "Flask of Chromatic Resistance";
--3 of the flasks spells seem to be named differently than the flask item, but titan is exact same name as the flask item.
L["Supreme Power"] = "Poder Supremo";
L["Distilled Wisdom"] = "Sabedoria Destilada";
L["Chromatic Resistance"] = "Resistência Cromática";

---=====---
---Horde---
---=====---

--Horde Orgrimmar Rend buff NPC.
L["Thrall"] = "Thrall";
--Horde The Barrens Rend buff NPC.
L["Herald of Thrall"] = "Arauto de Thrall";
--Horde rend buff NPC first yell string (part of his first yell msg before before buff).
--L["Rend Blackhand, has fallen"] = "";
--Horde rend buff NPC second yell string (part of his second yell msg before before buff).
--L["Be bathed in my power"] = "";

--Horde Onyxia buff NPC.
L["Overlord Runthak"] = "Lorde Supremo Runthak";
--Horde Onyxia buff NPC first yell string (part of his first yell msg before before buff).
--L["Onyxia, has been slain"] = "";
--Horde Onyxia buff NPC second yell string (part of his second yell msg before before buff).
--L["Be lifted by the rallying cry"] = "";

--Horde Nefarian buff NPC.
L["High Overlord Saurfang"] = "Lorde Supremo Saurfang";
--Horde Nefarian buff NPC first yell string (part of his first yell msg before before buff).
--L["NEFARIAN IS SLAIN"] = "";
--Horde Nefarian buff NPC second yell string (part of his second yell msg before before buff).
--L["Revel in his rallying cry"] = "";

---========---
---Alliance---
---========---

--Alliance Onyxia buff NPC.
L["Major Mattingly"] = "Major Valadão";
--Alliance Onyxia buff NPC first yell string (part of his first yell msg before before buff).
--L["history has been made"] = "";
--Alliance Onyxia buff NPC second yell string (part of his second yell msg before before buff).
--L["Onyxia, hangs from the arches"] = "";


--Alliance Nefarian buff NPC.
L["Field Marshal Afrasiabi"] = "Marechal de Campo Afrasiabi";
--Alliance Nefarian buff NPC first yell string (part of his first yell msg before before buff).
--L["the Lord of Blackrock is slain"] = "";
--Alliance Nefarian buff NPC second yell string (part of his second yell msg before before buff).
--L["Revel in the rallying cry"] = "";

---===========----
---NPC's killed---
---============---

L["onyxiaNpcKilledHorde"] = "Overlord Runthak has just been killed (Onyxia buff NPC).";
L["onyxiaNpcKilledAlliance"] = "Major Mattingly has just been killed (Onyxia buff NPC).";
L["nefarianNpcKilledHorde"] = "High Overlord Saurfang has just been killed (Nefarian buff NPC).";
L["nefarianNpcKilledAlliance"] = "Field Marshal Afrasiabi has just been killed (Nefarian buff NPC).";
L["onyxiaNpcKilledHordeWithTimer"] = "Onyxia NPC (Runthak) was killed %s ago no buff recorded since.";
L["NefarianNpcKilledHordeWithTimer"] = "Nefarian NPC (Saurfang) was killed %s ago no buff recorded since.";
L["onyxiaNpcKilledAllianceWithTimer"] = "Onyxia NPC (Mattingly) was killed %s ago no buff recorded since.";
L["NefarianNpcKilledAllianceWithTimer"] = "Nefarian NPC (Afrasiabi) was killed %s ago no buff recorded since.";
L["anyNpcKilledWithTimer"] = "NPC was killed %s ago"; --Map timers tooltip msg.


---==============---
---Darkmoon Faire---
---==============---

L["Darkmoon Faire"] = "Darkmoon Faire";
L["Sayge's Dark Fortune of Agility"] = "Sayge's Dark Fortune of Agility";
L["Sayge's Dark Fortune of Intelligence"] = "Sayge's Dark Fortune of Intelligence";
L["Sayge's Dark Fortune of Spirit"] = "Sayge's Dark Fortune of Spirit";
L["Sayge's Dark Fortune of Stamina"] = "Sayge's Dark Fortune of Stamina";
L["Sayge's Dark Fortune of Strength"] = "Sayge's Dark Fortune of Strength";
L["Sayge's Dark Fortune of Armor"] = "Sayge's Dark Fortune of Armor";
L["Sayge's Dark Fortune of Resistance"] = "Sayge's Dark Fortune of Resistance";
L["Sayge's Dark Fortune of Damage"] = "Sayge's Dark Fortune of Damage";
L["dmfBuffCooldownMsg"] = "Your Darkmoon Faire buff cooldown has %s left.";
L["dmfBuffReady"] = "Your Darkmoon Faire buff is off cooldown."; --These 2 buff msgs are slightly different for a reason.
L["dmfBuffReset"] = "Your Darkmoon Faire buff cooldown has reset."; --These 2 buff msgs are slightly different for a reason.
L["dmfBuffDropped"] = "Darkmoon Faire buff %s received, to track the 4 hour ingame cooldown for this buff type /buffs.";
L["dmfSpawns"] = "Darkmoon Faire spawns in %s (%s)";
L["dmfEnds"] = "Darkmoon Faire ends in %s (%s)";
L["mulgore"] = "Mulgore";
L["elwynnForest"] = "Elwynn Forest";
				
---==============---
---Output Strings---
---==============---

L["rend"] = "Rend"; --Rend Blackhand
L["onyxia"] = "Onyxia"; --Onyxia
L["nefarian"] = "Nefarian"; --Nefarian
L["dmf"] = "Darkmoon Faire"; --Darkmoon Faire
L["noTimer"] = "No timer"; --No timer
L["noCurrentTimer"] = "No current timer"; --No current timer
L["noActiveTimers"] = "No active timers";	--No active timers
L["newBuffCanBeDropped"] = "A new %s buff can be dropped now"
L["buffResetsIn"] = "%s resets in %s";
L["rendFirstYellMsg"] = "Rend will drop in 6 seconds.";
L["onyxiaFirstYellMsg"] = "Onyxia will drop in 14 seconds.";
L["nefarianFirstYellMsg"] = "Nefarian will drop in 15 seconds.";
L["rendBuffDropped"] = "Warchief's Blessing (Rend) has dropped.";
L["onyxiaBuffDropped"] = "Rallying Cry of the Dragonslayer (Onyxia) has dropped.";
L["nefarianBuffDropped"] = "Rallying Cry of the Dragonslayer (Nefarian) has dropped.";
L["onyxiaNpcKilledHorde"] = "Overlord Runthak has just been killed (Onyxia buff NPC).";
L["onyxiaNpcKilledAlliance"] = "Major Mattingly has just been killed (Onyxia buff NPC).";
L["nefarianNpcKilledHorde"] = "High Overlord Saurfang has just been killed (Nefarian buff NPC).";
L["nefarianNpcKilledAlliance"] = "Field Marshal Afrasiabi has just been killed (Nefarian buff NPC).";
L["newSongflowerReceived"] = "New songflower timer received"; --New songflower timer received
L["songflowerPicked"] = "Songflower picked at %s, next spawn in 25mins."; -- Guild msg when songflower picked.
L["North Felpaw Village"] = "North Felpaw Village"; --Felwood map subzones (flower1).
L["West Felpaw Village"] = "West Felpaw Village"; --Felwood map subzones (flower2).
L["North of Irontree Woods"] = "North of Irontree Woods"; --Felwood map subzones (flower3).
L["Talonbranch Glade"] = "Talonbranch Glade"; --Felwood map subzones (flower4).
L["Shatter Scar Vale"] = "Shatter Scar Vale"; --Felwood map subzones (flower5).
L["Bloodvenom Post"] = "Bloodvenom Post"; --Felwood map subzones (flower6).
L["East of Jaedenar"] = "East of Jaedenar"; --Felwood map subzones (flower7).
L["North of Emerald Sanctuary"] = "North of Emerald Sanctuary"; --Felwood map subzones (flower8).
L["West of Emerald Sanctuary"] = "West of Emerald Sanctuary"; --Felwood map subzones (flower9).
L["South of Emerald Sanctuary"] = "South of Emerald Sanctuary"; --Felwood map subzones (flower10).
L["second"] = "second"; --Second (singular).
L["seconds"] = "seconds"; --Seconds (plural).
L["minute"] = "minute"; --Minute (singular).
L["minutes"] = "minutes"; --Minutes (plural).
L["hour"] = "hour"; --Hour (singular).
L["hours"] = "hours"; --Hours (plural).
L["day"] = "day"; --Day (singular).
L["days"] = "days"; --Days (plural).
L["secondShort"] = "s"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "m"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "h"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "d"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "Starts in %s"; --"Starts in 1hour".
L["endsIn"] = "Ends in %s"; --"Ends in 1hour".
L["versionOutOfDate"] = "Nova World Buffs is out of date, please update at https://www.curseforge.com/wow/addons/nova-world-buffs or twitch.";
L["Your Current World Buffs"] = "Current World Buffs";
L["Options"] = "Options";

---New stuff---

--Spirit of Zandalar buff NPC first yell string (part of his first yell msg before before buff).
L["Begin the ritual"] = "Begin the ritual"
L["The Blood God"] = "The Blood God"; --First Booty bay yell from Zandalarian Emissary.
--Spirit of Zandalar buff NPC second yell string (part of his second yell msg before before buff).
L["slayer of Hakkar"] = "slayer of Hakkar";

L["Molthor"] = "Molthor";
L["Zandalarian Emissary"] = "Emissário Zandalariano";
L["Whipper Root Tuber"] = "Tubérculo de Raiz-açoite";
L["Night Dragon's Breath"] = "Sopro de Dragão Noturno";
L["Resist Fire"] = "Resistir ao Fogo"; -- LBRS fire resist buff.
L["Blessing of Blackfathom"] = "Bênção das Profundezas Negras";

L["zan"] = "Zandalar";
L["zanFirstYellMsg"] = "Zandalar will drop in 30 seconds.";
L["zanBuffDropped"] = "Spirit of Zandalar (Hakkar) has dropped.";
L["singleSongflowerMsg"] = "Songflower at %s spawns in %s."; -- Songflower at Bloodvenom Post spawns at 1pm.
L["spawn"] = "spawn"; --Used in Felwood map marker tooltip (03:46pm spawn).
L["Irontree Woods"] = "Irontree Woods";
L["West of Irontree Woods"] = "West of Irontree Woods";
L["Bloodvenom Falls"] = "Bloodvenom Falls";
L["Jaedenar"] = "Jaedenar";
L["North-West of Irontree Woods"] = "North-West of Irontree Woods";
L["South of Irontree Woods"] = "South of Irontree Woods";