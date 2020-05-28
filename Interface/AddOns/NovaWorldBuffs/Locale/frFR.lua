local L = LibStub("AceLocale-3.0"):NewLocale("NovaWorldBuffs", "frFR");
if (not L) then
	return;
end

--Rend buff aura name.
L["Warchief's Blessing"] = "Bénédiction du chef de guerre";
--Onyxia and Nefarian buff aura name.
L["Rallying Cry of the Dragonslayer"] = "Cri de ralliement du tueur de dragon";
--Songflower buff aura name from felwood.
L["Songflower Serenade"] = "Sérénade de fleur-de-chant";
L["Songflower"] = "Fleur-de-chant";
--Spirit of Zandalar.
L["Spirit of Zandalar"] = "Esprit des Zandalar";
L["Flask of Supreme Power"] = "Flacon de pouvoir suprême";
L["Flask of the Titans"] = "Flacon des Titans";
L["Flask of Distilled Wisdom"] = "Flacon de sagesse distillée";
L["Flask of Chromatic Resistance"] = "Flacon de résistance chromatique";
--3 of the flasks spells seem to be named differently than the flask item, but titan is exact same name as the flask item.
L["Supreme Power"] = "Pouvoir suprême";
L["Distilled Wisdom"] = "Sagesse distillée";
L["Chromatic Resistance"] = "Résistance chromatique";

---=====---
---Horde---
---=====---

--Horde Orgrimmar Rend buff NPC.
L["Thrall"] = "Thrall";
--Horde The Barrens Rend buff NPC.
L["Herald of Thrall"] = "Héraut de Thrall";
--Horde rend buff NPC first yell string (part of his first yell msg before before buff).
L["Rend Blackhand, has fallen"] = "Le faux chef Rend Blackhand est tombé";
--Horde rend buff NPC second yell string (part of his second yell msg before before buff).
L["Be bathed in my power"] = "Que ma puissance vous baigne";

--Horde Onyxia buff NPC.
L["Overlord Runthak"] = "Seigneur Runthak";
--Horde Onyxia buff NPC first yell string (part of his first yell msg before before buff).
L["Onyxia, has been slain"] = "Peuple de la Horde, citoyens d'Orgrimmar";
--Horde Onyxia buff NPC second yell string (part of his second yell msg before before buff).
L["Be lifted by the rallying cry"] = "Soyez témoins de la puissance de votre Chef de guerre";

--Horde Nefarian buff NPC.
L["High Overlord Saurfang"] = "Haut seigneur Saurfang";
--Horde Nefarian buff NPC first yell string (part of his first yell msg before before buff).
L["NEFARIAN IS SLAIN"] = "NEFARIAN A ÉTÉ TUÉ";
--Horde Nefarian buff NPC second yell string (part of his second yell msg before before buff).
--L["Revel in his rallying cry"] = "";

---========---
---Alliance---
---========---

--Alliance Onyxia buff NPC.
L["Major Mattingly"] = "Major Mattingly";
--Alliance Onyxia buff NPC first yell string (part of his first yell msg before before buff).
--L["history has been made"] = "";
--Alliance Onyxia buff NPC second yell string (part of his second yell msg before before buff).
--L["Onyxia, hangs from the arches"] = "";


--Alliance Nefarian buff NPC.
L["Field Marshal Afrasiabi"] = "Grand maréchal Afrasiabi";
--Alliance Nefarian buff NPC first yell string (part of his first yell msg before before buff).
--L["the Lord of Blackrock is slain"] = "";
--Alliance Nefarian buff NPC second yell string (part of his second yell msg before before buff).
--L["Revel in the rallying cry"] = "";

---===========----
---NPC's killed---
---============---

L["onyxiaNpcKilledHorde"] = "Seigneur Runthak a été tué (PNJ Onyxia buff).";
L["onyxiaNpcKilledAlliance"] = "Major Mattingly a été tué (PNJ Onyxia buff).";
L["nefarianNpcKilledHorde"] = "Haut seigneur Saurfang a été tué (PNJ Nefarian buff).";
L["nefarianNpcKilledAlliance"] = "Grand maréchal Afrasiabi a été tué (PNJ Nefarian buff).";
L["onyxiaNpcKilledHordeWithTimer"] = "Le PNJ d'Onyxia (Runthak) a été tué il y a %s, pas de buff enregistré depuis";
L["NefarianNpcKilledHordeWithTimer"] = "Le PNJ de Nefarian (Saurfang) a été tué il y a %s, pas de buff enregistré depuis";
L["onyxiaNpcKilledAllianceWithTimer"] = "Le PNJ d'Onyxia (Mattingly) a été tué il y a %s, pas de buff enregistré depuis";
L["NefarianNpcKilledAllianceWithTimer"] = "Le PNJ de Nefarian (Afrasiabi) a été tué il y a %s, pas de buff enregistré depuis";
L["anyNpcKilledWithTimer"] = "Le PNJ a été tué il y a %s";

---==============---
---Darkmoon Faire---
---==============---

L["Darkmoon Faire"] = "Foire de Sombrelune";
L["Sayge's Dark Fortune of Agility"] = "Sombre prédiction d'Agilité de Sayge";
L["Sayge's Dark Fortune of Intelligence"] = "Sombre prédiction d'Intelligence de Sayge";
L["Sayge's Dark Fortune of Spirit"] = "Sombre prédiction d'Esprit de Sayge";
L["Sayge's Dark Fortune of Stamina"] = "Sombre prédiction d'Endurance de Sayge";
L["Sayge's Dark Fortune of Strength"] = "Sombre prédiction de Force de Sayge";
L["Sayge's Dark Fortune of Armor"] = "Sombre prédiction d'Armure de Sayge";
L["Sayge's Dark Fortune of Resistance"] = "Sombre prédiction de résistance de Sayge";
L["Sayge's Dark Fortune of Damage"] = "Sombre prédiction de dégâts de Sayge";
L["dmfBuffCooldownMsg"] = "Votre buff de la Foire de Sombrelune est en cooldown pour encore %s";
L["dmfBuffReady"] = "Votre buff de la Foire de Sombrelune est reset";
L["dmfBuffReset"] = "Votre buff Foire de Sombrelune est de nouveau disponible.";
L["dmfBuffDropped"] = "Buff Foire de Sombrelune %s reçue. Pour suivre le cooldown de 5heures tapez /dmf";
L["dmfSpawns"] = "La Foire de Sombrelune va apparaître dans %s (%s)";
L["dmfEnds"] = "La Foire de Sombrelune est actuellement présente, elle finie dans %s (%s)";
L["mulgore"] = "Mulgore";
L["elwynnForest"] = "Forêt d'Elwynn";
				
---==============---
---Output Strings---
---==============---

L["rend"] = "Rend"; --Rend Blackhand
L["onyxia"] = "Onyxia"; --Onyxia
L["nefarian"] = "Nefarian"; --Nefarian
L["dmf"] = "Foire de Sombrelune"; --Darkmoon Faire
--L["noTimer"] = "Pas de timer"; --No timer (used only in map timer frames)
L["noTimer"] = "--"; --No timer (used only in map timer frames)
L["noCurrentTimer"] = "Actuellement pas de timer"; --No current timer
L["noActiveTimers"] = "Pas de timer actif";	--No active timers
L["newBuffCanBeDropped"] = "Un nouveau buff %s peut être activé";
L["buffResetsIn"] = "%s resets dans %s";
L["rendFirstYellMsg"] = "Rend va être posé dans 6 secondes.";
L["onyxiaFirstYellMsg"] = "Onyxia va être posé dans 14 secondes.";
L["nefarianFirstYellMsg"] = "Nefarian va être posé dans 15 secondes.";
L["rendBuffDropped"] = "Bénédiction du chef de guerre (Rend) a été posé.";
L["onyxiaBuffDropped"] = "Cri de ralliement du tueur de dragon (Onyxia) a été posé.";
L["nefarianBuffDropped"] = "Cri de ralliement du tueur de dragon (Nefarian) a été posé.";
L["newSongflowerReceived"] = "Nouveau timer Songflower reçu"; --New songflower timer received
L["songflowerPicked"] = "Songflower prise à %s, prochain spawn dans 25mins."; -- Guild msg when songflower picked.
L["North Felpaw Village"] = "Village Mort-Bois nord"; --Felwood map subzones (flower1).
L["West Felpaw Village"] = "Village Mort-Bois ouest"; --Felwood map subzones (flower2).
L["North of Irontree Woods"] = "Nord des bois d'Arbrefer"; --Felwood map subzones (flower3).
L["Talonbranch Glade"] = "Clairière de Griffebranche"; --Felwood map subzones (flower4).
L["Shatter Scar Vale"] = "Val Grêlé"; --Felwood map subzones (flower5).
L["Bloodvenom Post"] = "Poste de la Vénéneuse"; --Felwood map subzones (flower6).
L["East of Jaedenar"] = "Est de Jaedenar"; --Felwood map subzones (flower7).
L["North of Emerald Sanctuary"] = "Nord du Sanctuaire d'émeraude"; --Felwood map subzones (flower8).
L["West of Emerald Sanctuary"] = "Ouest du Sanctuaire d'émeraude"; --Felwood map subzones (flower9).
L["South of Emerald Sanctuary"] = "Sud du Sanctuaire d'émeraude"; --Felwood map subzones (flower10).
L["second"] = "seconde"; --Second (singular).
L["seconds"] = "secondes"; --Seconds (plural).
L["minute"] = "minute"; --Minute (singular).
L["minutes"] = "minutes"; --Minutes (plural).
L["hour"] = "heure"; --Hour (singular).
L["hours"] = "heures"; --Hours (plural).
L["day"] = "jour"; --Day (singular).
L["days"] = "jours"; --Days (plural).
L["secondShort"] = "s"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "m"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "h"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "j"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "Commence dans %s"; --"Starts in 1hour".
L["endsIn"] = "Fini dans %s"; --"Ends in 1hour".
L["versionOutOfDate"] = "Votre addon Nova World Buffs n'est plus à jour, mettez le à jour sur https://www.curseforge.com/wow/addons/nova-world-buffs ou via l'app twitch";
L["Your Current World Buffs"] = "Vos World Buffs actuels";
L["Options"] = "Options";

---New stuff---

--Spirit of Zandalar buff NPC first yell string (part of his first yell msg before before buff).
L["Begin the ritual"] = "Commencez le rituel"
L["The Blood God"] = "Le Dieu sanglantd"; --First Booty bay yell from Zandalarian Emissary.
--Spirit of Zandalar buff NPC second yell string (part of his second yell msg before before buff).
L["slayer of Hakkar"] = "vainqueur d’Hakkar";

L["Molthor"] = "Molthor";
L["Zandalarian Emissary"] = "Emissaire zandalarien";
L["Whipper Root Tuber"] = "Tubercule de navetille";
L["Night Dragon's Breath"] = "Souffle de dragon nocturne";
L["Resist Fire"] = "Résistance au Feu"; -- LBRS fire resist buff.
L["Blessing of Blackfathom"] = "Bénédiction de Brassenoire";

L["zan"] = "Zandalar";
L["zanFirstYellMsg"] = "Zandalar va être posé dans 30 secondes.";
L["zanBuffDropped"] = "Esprit des Zandalar (Hakkar) a été posé.";
L["singleSongflowerMsg"] = "La Songflower prise à %s va apparaître dans %s.";
L["spawn"] = "spawn"; --Used in Felwood map marker tooltip (03:46pm spawn).
L["Irontree Woods"] = "Bois d'Arbrefer";
L["West of Irontree Woods"] = "l'ouest du bois d'Arbrefer";
L["Bloodvenom Falls"] = "Chutes de la Vénéneuse";
L["Jaedenar"] = "Jaedenar";
L["North-West of Irontree Woods"] = "le nord du bois d'Arbrefer";
L["South of Irontree Woods"] = "le sud du bois d'Arbrefer";