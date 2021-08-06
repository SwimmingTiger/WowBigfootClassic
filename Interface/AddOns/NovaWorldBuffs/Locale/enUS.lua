local L = LibStub("AceLocale-3.0"):NewLocale("NovaWorldBuffs", "enUS", true, true);

--Rend buff aura name.
L["Warchief's Blessing"] = true;
--Onyxia and Nefarian buff aura name.
L["Rallying Cry of the Dragonslayer"] = true;
--Songflower buff aura name from felwood.
L["Songflower Serenade"] = true;
L["Songflower"] = true;

L["Flask of Supreme Power"] = "Flask of Supreme Power";
L["Flask of the Titans"] = "Flask of the Titans";
L["Flask of Distilled Wisdom"] = "Flask of Distilled Wisdom";
L["Flask of Chromatic Resistance"] = "Flask of Chromatic Resistance";
--3 of the flasks spells seem to be named differently than the flask item, but titan is exact same name as the flask item.
L["Supreme Power"] = "Supreme Power";
L["Distilled Wisdom"] = "Distilled Wisdom";
L["Chromatic Resistance"] = "Chromatic Resistance";
L["Sap"] = "Sap";
L["Fire Festival Fortitude"] = "Fire Festival Fortitude";
L["Fire Festival Fury"] = "Fire Festival Fury";
L["Ribbon Dance"] = "Ribbon Dance";
L["Traces of Silithyst"] = "Traces of Silithyst";
L["Slip'kik's Savvy"] = "Slip'kik's Savvy";
L["Fengus' Ferocity"] = "Fengus' Ferocity";
L["Mol'dar's Moxie"] = "Mol'dar's Moxie";

---=====---
---Horde---
---=====---

--Horde Orgrimmar Rend buff NPC.
L["Thrall"] = true;
--Horde The Barrens Rend buff NPC.
L["Herald of Thrall"] = true;
--Horde rend buff NPC first yell string (part of his first yell msg before before buff).
L["Rend Blackhand, has fallen"] = true;
--Horde rend buff NPC second yell string (part of his second yell msg before before buff).
L["Be bathed in my power"] = true;

--Horde Onyxia buff NPC.
L["Overlord Runthak"] = true;
--Horde Onyxia buff NPC first yell string (part of his first yell msg before before buff).
L["Onyxia, has been slain"] = true;
--Horde Onyxia buff NPC second yell string (part of his second yell msg before before buff).
L["Be lifted by the rallying cry"] = true;

--Horde Nefarian buff NPC.
L["High Overlord Saurfang"] = true;
--Horde Nefarian buff NPC first yell string (part of his first yell msg before before buff).
L["NEFARIAN IS SLAIN"] = true;
--Horde Nefarian buff NPC second yell string (part of his second yell msg before before buff).
L["Revel in his rallying cry"] = true;

---========---
---Alliance---
---========---

--Alliance Onyxia buff NPC.
L["Major Mattingly"] = true;
--Alliance Onyxia buff NPC first yell string (part of his first yell msg before before buff).
L["history has been made"] = true;
--Alliance Onyxia buff NPC second yell string (part of his second yell msg before before buff).
L["Onyxia, hangs from the arches"] = true;


--Alliance Nefarian buff NPC.
L["Field Marshal Afrasiabi"] = true;
L["Field Marshal Stonebridge"] = true;
--Alliance Nefarian buff NPC first yell string (part of his first yell msg before before buff).
L["the Lord of Blackrock is slain"] = true;
--Alliance Nefarian buff NPC second yell string (part of his second yell msg before before buff).
L["Revel in the rallying cry"] = true;

---===========----
---NPC's killed---
---============---

L["onyxiaNpcKilledHorde"] = "Overlord Runthak has just been killed (Onyxia buff NPC).";
L["onyxiaNpcKilledAlliance"] = "Major Mattingly has just been killed (Onyxia buff NPC).";
L["nefarianNpcKilledHorde"] = "High Overlord Saurfang has just been killed (Nefarian buff NPC).";
L["nefarianNpcKilledAlliance"] = "Field Marshal Afrasiabi has just been killed (Nefarian buff NPC).";
L["onyxiaNpcKilledHordeWithTimer"] = "Onyxia NPC (Runthak) was killed %s ago, no buff recorded since.";
L["nefarianNpcKilledHordeWithTimer"] = "Nefarian NPC (Saurfang) was killed %s ago, no buff recorded since.";
L["onyxiaNpcKilledAllianceWithTimer"] = "Onyxia NPC (Mattingly) was killed %s ago, no buff recorded since.";
L["nefarianNpcKilledAllianceWithTimer"] = "Nefarian NPC (Afrasiabi) was killed %s ago, no buff recorded since.";
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
L["dmfBuffCooldownMsg"] = "Your DMF buff cooldown has %s left.";
L["dmfBuffCooldownMsg2"] = "Your DMF buff cooldown has %s left."; --/wb frame.
L["dmfBuffCooldownMsg3"] = "DMF Buff cooldown also resets with the weekly server reset."; --/wb frame 2nd msg.
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
L["newBuffCanBeDropped"] = "A new %s buff can be dropped now";
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
L["secondMedium"] = "sec"; --Second (singular).
L["secondsMedium"] = "secs"; --Seconds (plural).
L["minuteMedium"] = "min"; --Minute (singular).
L["minutesMedium"] = "mins"; --Minutes (plural).
L["hourMedium"] = "hour"; --Hour (singular).
L["hoursMedium"] = "hours"; --Hours (plural).
L["dayMedium"] = "day"; --Day (singular).
L["daysMedium"] = "days"; --Days (plural).
L["secondShort"] = "s"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "m"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "h"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "d"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "Starts in %s"; --"Starts in 1hour".
L["endsIn"] = "Ends in %s"; --"Ends in 1hour".
L["versionOutOfDate"] = "Nova World Buffs is out of date, please update at https://www.curseforge.com/wow/addons/nova-world-buffs";
L["Your Current World Buffs"] = "Current World Buffs";
L["Options"] = "Options";

--Spirit of Zandalar buff NPC first yell string (part of his first yell msg before before buff).
L["Begin the ritual"] = "Begin the ritual";
L["The Blood God"] = "The Blood God"; --First Booty bay yell from Zandalarian Emissary.
--Spirit of Zandalar buff NPC second yell string (part of his second yell msg before before buff).
L["slayer of Hakkar"] = "slayer of Hakkar";

L["Spirit of Zandalar"] = "Spirit of Zandalar";
L["Molthor"] = "Molthor";
L["Zandalarian Emissary"] = "Zandalarian Emissary";
L["Whipper Root Tuber"] = "Whipper Root Tuber";
L["Night Dragon's Breath"] = "Night Dragon's Breath";
L["Resist Fire"] = "Resist Fire"; -- LBRS fire resist buff.
L["Blessing of Blackfathom"] = "Blessing of Blackfathom";

L["zan"] = "Zandalar";
L["zanFirstYellMsg"] = "Zandalar will drop in %s seconds.";
L["zanBuffDropped"] = "Spirit of Zandalar (Hakkar) has dropped.";
L["singleSongflowerMsg"] = "Songflower at %s spawns in %s."; -- Songflower at Bloodvenom Post spawns at 1pm.
L["spawn"] = "spawn"; --Used in Felwood map marker tooltip (03:46pm spawn).
L["Irontree Woods"] = "Irontree Woods";
L["West of Irontree Woods"] = "West of Irontree Woods";
L["Bloodvenom Falls"] = "Bloodvenom Falls";
L["Jaedenar"] = "Jaedenar";
L["North-West of Irontree Woods"] = "North-West of Irontree Woods";
L["South of Irontree Woods"] = "South of Irontree Woods";

L["worldMapBuffsMsg"] = "Type /buffs to view all your\ncharacters current world buffs.";
L["cityMapLayerMsgHorde"] = "Currently on %s\nTarget any NPC in Orgrimmar\nto update your layer after changing zones.|r";
L["cityMapLayerMsgAlliance"] = "Currently on %s\nTarget any NPC in Stormwind\nto update your layer after changing zones.|r";
L["noLayerYetHorde"] = "Please target any NPC in Orgrimmar\nto find your current layer.";
L["noLayerYetAlliance"] = "Please target any NPC in Stormwind\nto find your current layer.";
L["Reset Data"] = "Reset Data"; --A button to Reset buffs window data.

---New translations to do---
L["layerFrameMsgOne"] = "Old layers will still show for a few hours after server restarts."; --Msg at bottom of layer timers frame.
L["layerFrameMsgTwo"] = "Layers will disappear from here 6 hours after having no timers."; --Msg at bottom of layer timers frame.
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
L["showBuffsTitle"] = "Current World Buffs";
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

L["showAllAltsTitle"] = "Show All Buff Stats";
L["showAllAltsDesc"] = "Show all alts with buff stats in the buffs window even if they don't have an active buff?";

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

--L["autoBuffsHeaderDesc"] = "Auto Get Buffs From NPCs";
L["autoBuffsHeaderDesc"] = "Automation";

L["autoDmfBuffTitle"] = "Auto Get DMF Buff";
L["autoDmfBuffDesc"] = "Do you want this addon to auto select a Darkmoon Faire buff for you when you speak to the Sayge NPC? Make sure you pick which buff you want also.";

L["autoDmfBuffTypeTitle"] = "Which DMF Buff";
L["autoDmfBuffTypeDesc"] = "Which Darkmoon Faire buff do you want this addon to auto select for you when you speak to Sayge?";

L["autoDireMaulBuffTitle"] = "Dire Maul Buffs";
L["autoDireMaulBuffDesc"] = "Do you want this addon to auto get buffs from the NPC's in Dire Maul when you talk to them? (Also auto gets King buff).";

L["autoBwlPortalTitle"] = "Auto BWL Portal";
L["autoBwlPortalDesc"] = "Do you want this addon to auto use the Blackwing Lair portal when you click the orb?";

L["showBuffStatsTitle"] = "Show Buff Stats";
L["showBuffStatsDesc"] = "Show how many times you've gotten each world buff in the buffs window? Ony/Nef/Rend/Zand buffs have been recording since the buffs frame was put in, but the rest of the buffs only started recording now in version 1.65";

L["buffResetButtonTooltip"] = "This will reset all buffs.\nBuff count data will not be reset."; --Reset button tooltip for the /buffs frame.
L["time"] = "(%s time)"; --Singular - This shows how many timers you got a buff. Example: (1 time)
L["times"] = "(%s times)"; --Plural - This shows how many timers you got a buff. Example: (5 times)
L["flowerWarning"] = "Songflower picked on a realm with layered songflower timers enabled but you haven't targeted a NPC since arriving in Felwood so no timer could be recorded.";

L["mmColorTitle"] = "Minimap Layer Color";
L["mmColorDesc"] = "What color should the minimap layer text be? (Layer 1)";

L["layerHasBeenDisabled"] = "Disabled layer %s, this layer is still in the database but will be ignored until you enable it again or it's detected again as being valid.";
L["layerHasBeenEnabled"] = "Enabled layer %s, this is now back in timer and layer calculations.";
L["layerDoesNotExist"] = "The layer ID %s doesn't exist in the database.";
L["enableLayerButton"] = "Enable Layer";
L["disableLayerButton"] = "Disable Layer";
L["enableLayerButtonTooltip"] = "Click to re-enable this layer,\nIt will be put back into timer and layer calcs.";
L["disableLayerButtonTooltip"] = "Click to disable this old layer after server restarts.\nIt will be ignored by the addon and removed later.";

L["minimapLayerHoverTitle"] = "Minimap Mouseover";
L["minimapLayerHoverDesc"] = "Only show the minimap layer number frame when you hover the mouse over the minimap?";

L["Blackrock Mountain"] = "Blackrock Mountain";

L["soundsNpcKilledTitle"] = "NPC Killed";
L["soundsNpcKilledDesc"] = "Sound to play when a buff NPC is killed to reset a timer.";

L["autoDmfBuffCharsText"] = "Darkmoon Faire Character Specific Buff Settings";

L["middleNpcKilledTitle"] = "NPC Killed";
L["middleNpcKilledDesc"] = "Show a raid warning style msg in the middle of the screen when an Ony or Nef NPC is killed for a buff reset.";

L["chatNpcKilledTitle"] = "NPC Killed";
L["chatNpcKilledDesc"] = "Print a msg in chat when an Ony or Nef NPC is killed for a buff reset.";

L["onyxiaNpcRespawnHorde"] = "Onyxia NPC (Runthak) will respawn at a random time within the next 2 minutes.";
L["nefarianNpcRespawnHorde"] = "Nefarian NPC (Saurfang) will respawn at a random time within the next 2 minutes.";
L["onyxiaNpcRespawnAlliance"] = "Onyxia NPC (Mattingly) will respawn at a random time within the next 2 minutes.";
L["nefarianNpcRespawnAlliance"] = "Nefarian NPC (Afrasiabi) will respawn at a random time within the next 2 minutes.";

L["onyxiaNpcKilledHordeWithTimer2"] = "Onyxia NPC (Runthak) was killed %s ago, respawn in %s.";
L["nefarianNpcKilledHordeWithTimer2"] = "Nefarian NPC (Saurfang) was killed %s ago, respawn in %s.";
L["onyxiaNpcKilledAllianceWithTimer2"] = "Onyxia NPC (Mattingly) was killed %s ago, respawn in %s.";
L["nefarianNpcKilledAllianceWithTimer2"] = "Nefarian NPC (Afrasiabi) was killed %s ago, respawn in %s.";

L["flashNpcKilledTitle"] = "Flash NPC Killed";
L["flashNpcKilledDesc"] = "Flash the wow client when a buff NPC is killed?";

L["trimDataHeaderDesc"] = "Data Cleanup";

L["trimDataBelowLevelTitle"] = "Maximum Level To Remove";
L["trimDataBelowLevelDesc"] = "Select maximum level of characters to remove from database, all characters this level and below will be deleted.";

L["trimDataBelowLevelButtonTitle"] = "Remove Characters";
L["trimDataBelowLevelButtonDesc"] = "Click this button to remove all characters with the selected level and lower from this addon database. Note: This removes buff count data permanently.";

L["trimDataTextDesc"] = "Remove multiple characters from buffs database:";
L["trimDataText2Desc"] = "Remove one character from buffs database:";

L["trimDataCharInputTitle"] = "Remove One Character Input";
L["trimDataCharInputDesc"] = "Type a character here to remove, format as Name-Realm (Case sensitive). Note: This removes buff count data permanently.";

L["trimDataBelowLevelButtonConfirm"] = "Are you sure you want to remove all characters below level %s from the database?";
L["trimDataCharInputConfirm"] = "Are you sure you want to remove this character %s from the database?";

L["trimDataMsg1"] = "Buff records have been reset."
L["trimDataMsg2"] = "Removing all chars below level %s.";
L["trimDataMsg3"] = "Removed: %s.";
L["trimDataMsg4"] = "Done, no characters found.";
L["trimDataMsg5"] = "Done, removed %s characters.";
L["trimDataMsg6"] = "Please enter a valid Character-Name to delete from database.";
L["trimDataMsg7"] = "This character name %s doesn't include a realm, please input Name-Realm.";
L["trimDataMsg8"] = "Error removing %s from the database, character not found (name is case sensitive).";
L["trimDataMsg9"] = "Removed %s from the database.";

L["serverTime"] = "server time";
L["serverTimeShort"] = "st";

L["showUnbuffedAltsTitle"] = "Show Unbuffed Alts";
L["showUnbuffedAltsDesc"] = "Show alts without any buffs in the buffs window? This is so you can see what characters have no buffs if you would like.";

L["timerWindowWidthTitle"] = "Timer Window Width";
L["timerWindowWidthDesc"] = "How wide should the timer window be.";

L["timerWindowHeightTitle"] = "Timer Window Height";
L["timerWindowHeghtDesc"] = "How high should the timer window be.";

L["buffWindowWidthTitle"] = "Buff Window Width";
L["buffWindowWidthDesc"] = "How wide should the buff window be.";

L["buffWindowHeightTitle"] = "Buff Window Height";
L["buffWindowHeghtDesc"] = "How high should the buff window be.";

L["dmfSettingsListTitle"] = "DMF Buffs List";
L["dmfSettingsListDesc"] = "Click this to show a list of your alts DMF buff type settings.";

L["ignoreKillDataTitle"] = "Ignore NPC Killed Data";
L["ignoreKillDataDesc"] = "Ignore any NPC killed data from being recorded.";
			
L["noOverwriteTitle"] = "Dont Overwrite Timers";
L["noOverwriteDesc"] = "You can enable this so if you have a valid timer already running you will ignore any new data for that timer until the timer ends.";

L["layerMsg1"] = "You are on a layered realm.";
L["layerMsg2"] = "Click here to view current timers.";
L["layerMsg3"] = "Target any NPC to see your current layer.";
L["layerMsg4"] = "Target any NPC in %s to see your current layer."; --Target any NPC in Orgrimmar to see your current layer.

--NOTE: Darkmoon Faire buff type is now a character specific setting, changing buff type will only change it for this character.
L["note"] = "NOTE:";
L["dmfConfigWarning"] = "Darkmoon Faire buff type is now a character specific setting, changing buff type will only change it for this character.";

---New---

L["onyNpcMoving"] = "Onyxia NPC has started walking!";
L["nefNpcMoving"] = "Nefarian NPC has started walking!";

L["buffHelpersHeaderDesc"] = "Buff Helpers for PvP Servers";

L["buffHelpersTextDesc"] = "Buff helpers for PvP servers (These will fire if you get a buff and do one of these actions within the set seconds of getting the buff, you can adjust the seconds below).";
L["buffHelpersTextDesc2"] = "\nZandalar Buff";
L["buffHelpersTextDesc3"] = "Darkmoon Faire Buff";
--L["buffHelpersTextDesc4"] = "Enter Battleground Macro (you need to press this twice to work so just spam it, this will drop queue if you don't have a pop yet so be careful not to press it early).\n|cFF9CD6DE/click DropDownList1Button2\n/click MiniMapBatlefieldFrame RightButton";

L["takeTaxiZGTitle"] = "Auto Take Flight Path";
L["takeTaxiZGDesc"] = "Auto take a flight path from Booty Bay as soon as a buff drops, you can talk to the flight NPC after the drop or have it already open when it drops both ways will work. |cFF00C800(You can get the buff in ghost so I suggest sitting in ghost until buff drops then ressing and talk to flight NPC to auto fly out)";

L["takeTaxiNodeTitle"] = "Where to Fly";
L["takeTaxiNodeDesc"] = "If you have the auto flight path option enabled where to do you want to fly?";
			
L["dmfVanishSummonTitle"] = "Vanish Summon";
L["dmfVanishSummonDesc"] = "Rogues: Auto accept summon as soon as you vanish after getting DMF buff?";

L["dmfFeignSummonTitle"] = "Feign Death Summon";
L["dmfFeignSummonDesc"] = "Hunters: Auto accept summon as soon as you feign death after getting DMF buff?";
			
L["dmfCombatSummonTitle"] = "Combat Ends Summon";
L["dmfCombatSummonDesc"] = "Auto accept summon as soon as you drop combat after getting DMF buff?";
			
L["dmfLeaveBGTitle"] = "Auto Leave Battlegound";
L["dmfLeaveBGDesc"] = "Auto leave your Battleground when zoning in after getting DMF buff?";

L["dmfGotBuffSummonTitle"] = "DMF Buff Summon";
L["dmfGotBuffSummonDesc"] = "Auto accept any pending summon when you get Darkmoon Faire buff.";

L["zgGotBuffSummonTitle"] = "ZG Buff Summon";
L["zgGotBuffSummonDesc"] = "Auto accept any pending summon when you get Zandalar buff.";

L["buffHelperDelayTitle"] = "How Many Seconds Are Helpers Enabled For";
L["buffHelperDelayDesc"] = "How many seconds after you get a buff should these helpers work for? This is so you can leave the options enabled and they will only work right after getting a buff.";

L["showNaxxWorldmapMarkersTitle"] = "Naxxramas Worldmap";
L["showNaxxWorldmapMarkersDesc"] = "Show Naxxramas marker on the world map?";

L["showNaxxMinimapMarkersTitle"] = "Naxxramas Minimap";
L["showNaxxMinimapMarkersDesc"] = "Show Naxxramas marker on the mini map? This will also show you the direction back to naxx when you are a ghost and died inside raid.";

L["bigWigsSupportTitle"] = "BigWigs Support";
L["bigWigsSupportDesc"] = "Start a timer bar for buff drops if BigWigs is installed? The same type of timer bar DBM does.";

L["soundsNpcWalkingTitle"] = "NPC Walking";
L["soundsNpcWalkingDesc"] = "Sound to play when a buff NPC starts walking in Orgrimmar?";

L["buffHelpersTextDesc4"] = "Songflower Buff";
L["songflowerGotBuffSummonTitle"] = "Songflower Summon";
L["songflowerGotBuffSummonDesc"] = "Auto accept any pending summon when you get a Songflower buff.";

L["buffHelpersTextDesc5"] = "Ony/Rend Buff";
L["cityGotBuffSummonTitle"] = "Ony/Rend Summon";
L["cityGotBuffSummonDesc"] = "Auto accept any pending summon when you get a Ony/Nef/Rend buff.";

L["heraldFoundCrossroads"] = "Herald Found! Crossroads Rend will drop in 20 seconds.";
L["heraldFoundTimerMsg"] = "Crossroads Rend"; --DBM/Bigwigs timer bar text.

L["guildNpcWalkingTitle"] = "NPC Walking";
L["guildNpcWalkingDesc"] = "Send a message to guild and play a sound when you trigger or receive a NPC walking alert? (Open chat dialogue with Ony/Nef NPC's in Orgrimmar and wait for someone to hand the head in to trigger this early alert).";

L["buffHelpersTextDesc6"] = "Darkmoon Faire Helper Window";
L["dmfFrameTitle"] = "DMF Helper Window";
L["dmfFrameDesc"] = "A window that pops up when you go near Sayge at DMF while a ghost on pvp servers, helps with Blizzard stuck features.";

L["Sheen of Zanza"] = "Sheen of Zanza";
L["Spirit of Zanza"] = "Spirit of Zanza";
L["Swiftness of Zanza"] = "Swiftness of Zanza";

L["Mind Control"] = "Mind Control";
L["Gnomish Mind Control Cap"] = "Gnomish Mind Control Cap";


L["tbcHeaderText"] = "The Burning Crusade Options";
L["tbcNoteText"] = "Note: All guild chat msgs are also disabled on TBC realms.";

L["disableSoundsAboveMaxBuffLevelTitle"] = "Disable Sounds Above Level 64+";
L["disableSoundsAboveMaxBuffLevelDesc"] = "Disable world buff related sounds for characters above level 63 on TBC realms?";

L["disableSoundsAllLevelsTitle"] = "Disable Sounds All Levels";
L["disableSoundsAllLevelsDesc"] = "Disable world buff related sounds for characters of all levels on TBC realms.";

L["disableMiddleAboveMaxBuffLevelTitle"] = "Disable Middle Screen Msgs 64+";
L["disableMiddleAboveMaxBuffLevelDesc"] = "Disable world buff related msgs in middle of the screen for characters above level 63 on TBC realms?";

L["disableMiddleAllLevelsTitle"] = "Disable Middle Screen All Levels";
L["disableMiddleAllLevelsDesc"] = "Disable world buff related msgs in middle of the screen for characters of all levels on TBC realms.";

L["disableChatAboveMaxBuffLevelTitle"] = "Disable Chat Window Msgs 64+";
L["disableChatAboveMaxBuffLevelDesc"] = "Disable world buff timer related msgs in the chat window for characters above level 63 on TBC realms?";

L["disableChatAllLevelsTitle"] = "Disable Chat Window All Levels";
L["disableChatAllLevelsDesc"] = "Disable world buff timer related msgs in the chat window for characters of all levels on TBC realms.";

L["disableFlashAboveMaxBuffLevelTitle"] = "Disable Minimized Client Flash 64+";
L["disableFlashAboveMaxBuffLevelDesc"] = "Disable the wow client from flashing while minimized for world buff events for characters above level 63 on TBC realms?";

L["disableFlashAllLevelsTitle"] = "Disable Minimized Client Flash All Levels";
L["disableFlashAllLevelsDesc"] = "Disable the wow client from flashing while minimized for world buff events for characters of all levels on TBC realms.";

L["disableLogonAboveMaxBuffLevelTitle"] = "Disable Logon Timers 64+";
L["disableLogonAboveMaxBuffLevelDesc"] = "Disable timers in chat when you logon for characters above level 63 on TBC realms?";

L["disableLogonAllLevelsTitle"] = "Disable Logon Timers All Levels";
L["disableLogonAllLevelsDesc"] = "Disable timers in chat when you logon for characters of all levels on TBC realms.";

L["Flask of Fortification"] = "Flask of Fortification";
L["Flask of Pure Death"] = "Flask of Pure Death";
L["Flask of Relentless Assault"] = "Flask of Relentless Assault";
L["Flask of Blinding Light"] = "Flask of Blinding Light";
L["Flask of Mighty Restoration"] = "Flask of Mighty Restoration";
L["Flask of Chromatic Wonder"] = "Flask of Chromatic Wonder";
L["Fortification of Shattrath"] = "Fortification of Shattrath";
L["Pure Death of Shattrath"] = "Pure Death of Shattrath";
L["Relentless Assault of Shattrath"] = "Relentless Assault of Shattrath";
L["Blinding Light of Shattrath"] = "Blinding Light of Shattrath";
L["Mighty Restoration of Shattrath"] = "Mighty Restoration of Shattrath";
L["Supreme Power of Shattrath"] = "Supreme Power of Shattrath";
L["Unstable Flask of the Beast"] = "Unstable Flask of the Beast";
L["Unstable Flask of the Sorcerer"] = "Unstable Flask of the Sorcerer";
L["Unstable Flask of the Bandit"] = "Unstable Flask of the Bandit";
L["Unstable Flask of the Elder"] = "Unstable Flask of the Elder";
L["Unstable Flask of the Physician"] = "Unstable Flask of the Physician";
L["Unstable Flask of the Soldier"] = "Unstable Flask of the Soldier";

L["Chronoboon Displacer"] = "Chronoboon Displacer";

L["Silithyst"] = "Silithyst";

L["Gold"] = "Gold";
L["level"] = "Level";
L["realmGold"] = "Realm gold for";
L["total"] = "Total";
L["guild"] = "Guild";
L["bagSlots"] = "Bag slots";
L["durability"] = "Durability";
L["items"] = "Items";
L["ammunition"] = "Ammo";
L["attunements"] = "Attunements";
L["currentRaidLockouts"] = "Current Raid Lockouts";
L["none"] = "None.";

L["dmfDamagePercent"] = "This new DMF buff is at %s%% damage.";
L["dmfDamagePercentTooltip"] = "NWB detected this as %s damage.";

L["guildLTitle"] = "Guild Layer Sharing";
L["guildLDesc"] = "Share what layer you are on with your guild? You can see your guilds layer list with /wb guild";

L["terokkarTimer"] = "Terokkar";
L["terokkarWarning"] = "Terokkar Forest spirit towers reset in %s";

L["Nazgrel"] = "Nazgrel";
L["Hellfire Citadel is ours"] = "Hellfire Citadel is ours";
L["The time for us to rise"] = "The time for us to rise";
L["Force Commander Danath Trollbane"] = "Force Commander Danath Trollbane";
L["The feast of corruption is no more"] = "The feast of corruption is no more";
L["Hear me brothers"] = "Hear me brothers";

L["terokkarChat10Title"] = "Terokkar 10 Minutes";
L["terokkarChat10Desc"] = "Print a msg in chat when 10 minutes left on terokkar spirit towers.";

L["terokkarMiddle10Title"] = "Terokkar 10 Minutes";
L["terokkarMiddle10Desc"] = "Show a raid warning style msg in the middle of the screen when 10 minutes left on terokkar spirit towers.";

L["showShatWorldmapMarkersTitle"] = "Shattrath Worldmap";
L["showShatWorldmapMarkersDesc"] = "Show dungeon daily markers on the Shattrath world map?";