local L = LibStub("AceLocale-3.0"):NewLocale("NovaWorldBuffs", "deDE");
if (not L) then
	return;
end

--Rend buff aura name.
L["Warchief's Blessing"] = "Segen des Kriegshäuptlings";
--Onyxia and Nefarian buff aura name.
L["Rallying Cry of the Dragonslayer"] = "Schlachtruf der Drachentöter";
--Songflower buff aura name from felwood.
L["Songflower Serenade"] = "Liedblumenserenade";
L["Songflower"] = "Liedblume";
--Spirit of Zandalar.
L["Spirit of Zandalar"] = "Geist von Zandalar";
L["Flask of Supreme Power"] = "Fläschchen mit oberster Macht";
L["Flask of the Titans"] = "Fläschchen der Titanen";
L["Flask of Distilled Wisdom"] = "Fläschchen mit destillierter Weisheit";
L["Flask of Chromatic Resistance"] = "Fläschchen mit chromatischem Widerstand";
--3 of the flasks spells seem to be named differently than the flask item, but titan is exact same name as the flask item.
L["Supreme Power"] = "Oberste Macht";
L["Distilled Wisdom"] = "Destillierte Weisheit";
L["Chromatic Resistance"] = "Chromatischer Widerstand";

---=====---
---Horde---
---=====---

--Horde Orgrimmar Rend buff NPC.
L["Thrall"] = "Thrall";
--Horde The Barrens Rend buff NPC.
L["Herald of Thrall"] = "Herold von Thrall";
--Horde rend buff NPC first yell string (part of his first yell msg before before buff).
L["Rend Blackhand, has fallen"] = "Rend Blackhand, der falsche";
--Horde rend buff NPC second yell string (part of his second yell msg before before buff).
L["Be bathed in my power"] = "Badet in meiner Macht";

--Horde Onyxia buff NPC.
L["Overlord Runthak"] = "Oberanführer Runthak";
--Horde Onyxia buff NPC first yell string (part of his first yell msg before before buff).
L["Onyxia, has been slain"] = "Die Brutmutter Onyxia wurde getötet";
--Horde Onyxia buff NPC second yell string (part of his second yell msg before before buff).
L["Be lifted by the rallying cry"] = "Lasst den Siegesschrei der Drachentöter eure Herzen höher schlagen";

--Horde Nefarian buff NPC.
L["High Overlord Saurfang"] = "Hochfürst Saurfang";
--Horde Nefarian buff NPC first yell string (part of his first yell msg before before buff).
L["NEFARIAN IS SLAIN"] = "NAFARIAN IST TOT";
--Horde Nefarian buff NPC second yell string (part of his second yell msg before before buff).
L["Revel in his rallying cry"] = "Lasst seinen Siegesschrei eure Herzen höher schlagen";

---========---
---Alliance---
---========---

--Alliance Onyxia buff NPC.
L["Major Mattingly"] = "Major Mattingly";
--Alliance Onyxia buff NPC first yell string (part of his first yell msg before before buff).
L["history has been made"] = "am heutigen Tage ist Geschichte geschrieben worden";
--Alliance Onyxia buff NPC second yell string (part of his second yell msg before before buff).
L["Onyxia, hangs from the arches"] = "Onyxia baumelt leblos von den Torbögen";


--Alliance Nefarian buff NPC.
L["Field Marshal Afrasiabi"] = "Feldmarschall Afrasiabi";
--Alliance Nefarian buff NPC first yell string (part of his first yell msg before before buff).
L["the Lord of Blackrock is slain"] = "der Herrscher des Blackrocks wurde besiegt";
--Alliance Nefarian buff NPC second yell string (part of his second yell msg before before buff).
L["Revel in the rallying cry"] = "Lasst den Siegesschrei des Drachentöters eure Herzen höher schlagen";

---===========----
---NPC's killed---
---============---

L["onyxiaNpcKilledHorde"] = "Oberanführer Runthak wurde getötet (Onyxia Buff NPC).";
L["onyxiaNpcKilledAlliance"] = "Major Mattingly wurde getötet (Onyxia Buff NPC).";
L["nefarianNpcKilledHorde"] = "Hochfürst Saurfang wurde getötet (Nefarian Buff NPC).";
L["nefarianNpcKilledAlliance"] = "Feldmarschall Afrasiabi wurde getötet (Nefarian Buff NPC).";
L["onyxiaNpcKilledHordeWithTimer"] = "Onyxia NPC (Runthak) wurde vor %s getötet. Ein neuer Buff wurde bisher nicht festgestellt.";
L["NefarianNpcKilledHordeWithTimer"] = "Nefarian NPC (Saurfang) wurde vor %s getötet. Ein neuer Buff wurde bisher nicht festgestellt.";
L["onyxiaNpcKilledAllianceWithTimer"] = "Onyxia NPC (Mattingly) wurde vor %s getötet. Ein neuer Buff wurde bisher nicht festgestellt.";
L["NefarianNpcKilledAllianceWithTimer"] = "Nefarian NPC (Afrasiabi) wurde vor %s getötet. Ein neuer Buff wurde bisher nicht festgestellt.";
L["anyNpcKilledWithTimer"] = "NPC wurde vor %s getötet"; --Map timers tooltip msg.

---==============---
---Darkmoon Faire---
---==============---

L["Darkmoon Faire"] = "Dunkelmond-Jahrmarkt";
L["Sayge's Dark Fortune of Agility"] = "Sayges dunkles Schicksal der Beweglichkeit";
L["Sayge's Dark Fortune of Intelligence"] = "Sayges dunkles Schicksal der Intelligenz";
L["Sayge's Dark Fortune of Spirit"] = "Sayges dunkles Schicksal der Willenskraft";
L["Sayge's Dark Fortune of Stamina"] = "Sayges dunkles Schicksal der Ausdauer";
L["Sayge's Dark Fortune of Strength"] = "Sayges dunkles Schicksal der Stärke";
L["Sayge's Dark Fortune of Armor"] = "Sayges dunkles Schicksal der Rüstung";
L["Sayge's Dark Fortune of Resistance"] = "Sayges dunkles Schicksal des Widerstands";
L["Sayge's Dark Fortune of Damage"] = "Sayges dunkles Schicksal des Schadens";
L["dmfBuffCooldownMsg"] = "Ein neuer Dunkelmond-Jahrmarkt Buff kann geholt werden in %s.";
L["dmfBuffReady"] = "Ein neuer Dunkelmond-Jahrmarkt Buff kann jetzt geholt werden.";
L["dmfBuffReset"] = "Dunkelmond-Jahrmarkt Buff Cooldown wurde zurückgesetzt.";
L["dmfBuffDropped"] = "Dunkelmond-Jahrmarkt Buff %s erhalten. Um den 5 Stunden Cooldown zu tracken tippe /dmf.";
L["dmfSpawns"] = "Der Dunkelmond-Jahrmarkt öffnet in %s (%s)";
L["dmfEnds"] = "Der Dunkelmond-Jahrmarkt hat noch %s bis %s Uhr geöffnet";
L["mulgore"] = "Mulgore";
L["elwynnForest"] = "Wald von Elwynn";
				
---==============---
---Output Strings---
---==============---

L["rend"] = "Rend"; --Rend Blackhand
L["onyxia"] = "Onyxia"; --Onyxia
L["nefarian"] = "Nefarian"; --Nefarian
L["dmf"] = "Dunkelmond-Jahrmarkt"; --Darkmoon Faire
--L["noTimer"] = "Kein Timer"; --No timer (used only in map timer frames)
L["noTimer"] = "--"; --No timer (used only in map timer frames)
L["noCurrentTimer"] = "Kein aktueller Timer"; --No current timer
L["noActiveTimers"] = "Kein aktiver Timer";	--No active timers
L["newBuffCanBeDropped"] = "Ein neuer %s Buff kann jetzt gestellt werden";
L["buffResetsIn"] = "%s wird zurückgesetzt in %s";
L["rendFirstYellMsg"] = "Rend Buff in 6 Sekunden";
L["onyxiaFirstYellMsg"] = "Onyxia Buff in 14 Sekunden.";
L["nefarianFirstYellMsg"] = "Nefarian Buff in 15 Sekunden.";
L["rendBuffDropped"] = "Segen des Kriegshäuptlings (Rend) Buff wurde gewirkt.";
L["onyxiaBuffDropped"] = "Schlachtruf der Drachentöter (Onyxia) Buff wurde gewirkt.";
L["nefarianBuffDropped"] = "Schlachtruf der Drachentöter (Nefarian) Buff wurde gewirkt.";
L["newSongflowerReceived"] = "Neue Liedblume(n) synchronisiert"; --New songflower timer received
L["songflowerPicked"] = "Liedblume %s gepflückt. Erneut zu pflücken in 25min."; -- Guild msg when songflower picked.
L["North Felpaw Village"] = "Nördlich vom Revier der Teufelspfoten"; --Felwood map subzones (flower1).
L["West Felpaw Village"] = "Westlich vom Revier der Teufelspfoten"; --Felwood map subzones (flower2).
L["North of Irontree Woods"] = "Nördlich vom der Eisenwald"; --Felwood map subzones (flower3).
L["Talonbranch Glade"] = "Nachtlaublichtung"; --Felwood map subzones (flower4).
L["Shatter Scar Vale"] = "Shatter Scar-Tal"; --Felwood map subzones (flower5).
L["Bloodvenom Post"] = "Blutgiftposten"; --Felwood map subzones (flower6).
L["East of Jaedenar"] = "Östlich von Jaedenar"; --Felwood map subzones (flower7).
L["North of Emerald Sanctuary"] = "Nördlich vom smaragdgrünen Heiligtum"; --Felwood map subzones (flower8).
L["West of Emerald Sanctuary"] = "Westlich vom smaragdgrünen Heiligtum"; --Felwood map subzones (flower9).
L["South of Emerald Sanctuary"] = "Südlich vom smaragdgrünen Heiligtum"; --Felwood map subzones (flower10).
L["second"] = "Sekunde"; --Second (singular).
L["seconds"] = "Sekunden"; --Seconds (plural).
L["minute"] = "Minute"; --Minute (singular).
L["minutes"] = "Minuten"; --Minutes (plural).
L["hour"] = "Stunde"; --Hour (singular).
L["hours"] = "Stunden"; --Hours (plural).
L["day"] = "Tag"; --Day (singular).
L["days"] = "Tage"; --Days (plural).
L["secondShort"] = "s"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "m"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "h"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "d"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "Startet in %s"; --"Starts in 1hour".
L["endsIn"] = "Endet in %s"; --"Ends in 1hour".
L["versionOutOfDate"] = "Dein Nova World Buffs Addon ist nicht mehr aktuell. Bitte führe ein Update über https://www.curseforge.com/wow/addons/nova-world-buffs oder den Twitch Client durch.";
L["Your Current World Buffs"] = "Deine aktuellen World Buffs";
L["Options"] = "Einstellungen";

---New stuff---

--Spirit of Zandalar buff NPC first yell string (part of his first yell msg before before buff).
L["Begin the ritual"] = "Beginnt mit dem Ritual"
L["The Blood God"] = "Der Blutgott"; --First Booty bay yell from Zandalarian Emissary.
--Spirit of Zandalar buff NPC second yell string (part of his second yell msg before before buff).
L["slayer of Hakkar"] = "Besieger von Hakkar";

L["Molthor"] = "Molthor";
L["Zandalarian Emissary"] = "Abgesandter der Zandalarianer";
L["Whipper Root Tuber"] = "Peitscherwurzelknollen";
L["Night Dragon's Breath"] = "Nachtdrachenodem";
L["Resist Fire"] = "Feuer widerstehen"; -- LBRS fire resist buff.
L["Blessing of Blackfathom"] = "Segen von Blackfathom";

L["zan"] = "Zandalar";
L["zanFirstYellMsg"] = "Zandalar Buff in 27 Sekunden.";
L["zanBuffDropped"] = "Geist von Zandalar (Hakkar) Buff wurde gewirkt.";
L["singleSongflowerMsg"] = "Liedblume %s zu pflücken um %s."; -- Songflower at Bloodvenom Post spawns at 1pm.
L["spawn"] = "Spawn"; --Used in Felwood map marker tooltip (03:46pm spawn).
L["Irontree Woods"] = "Eisenwald";
L["West of Irontree Woods"] = "Westlich vom Eisenwald";
L["Bloodvenom Falls"] = "Blutgift Wasserfälle";
L["Jaedenar"] = "Jaedenar";
L["North-West of Irontree Woods"] = "Nordwestlich vom Eisenwald";
L["South of Irontree Woods"] = "Südlich des Eisenwalds";