if GetLocale() ~= "deDE" then return end
local L

----------------------------------
--  Ahn'Kahet: The Old Kingdom  --
----------------------------------
--  Prince Taldaram  --
-----------------------
L = DBM:GetModLocalization(581)

-------------------
--  Elder Nadox  --
-------------------
L = DBM:GetModLocalization(580)

---------------------------
--  Jedoga Shadowseeker  --
---------------------------
L = DBM:GetModLocalization(582)

---------------------
--  Herald Volazj  --
---------------------
L = DBM:GetModLocalization(584)

----------------
--  Amanitar  --
----------------
L = DBM:GetModLocalization(583)

-------------------
--  Azjol-Nerub  --
---------------------------------
--  Krik'thir the Gatewatcher  --
---------------------------------
L = DBM:GetModLocalization(585)

----------------
--  Hadronox  --
----------------
L = DBM:GetModLocalization(586)

-------------------------
--  Anub'arak (Party)  --
-------------------------
L = DBM:GetModLocalization(587)

---------------------------------------
--  Caverns of Time: Old Stratholme  --
---------------------------------------
--  Meathook  --
----------------
L = DBM:GetModLocalization(611)

--------------------------------
--  Salramm the Fleshcrafter  --
--------------------------------
L = DBM:GetModLocalization(612)

-------------------------
--  Chrono-Lord Epoch  --
-------------------------
L = DBM:GetModLocalization(613)

-----------------
--  Mal'Ganis  --
-----------------
L = DBM:GetModLocalization(614)

L:SetMiscLocalization({
	Outro	= "Eure Reise hat erst begonnen, junger Prinz. Sammelt Eure Streitmacht und folgt mir in das arktische Land Nordend. Dort werden wir unsere Rechnung begleichen. Dort wird sich Euer wahres Schicksal offenbaren."
})

-------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "Wellen (HdZ 4)"
})

L:SetWarningLocalization({
	WarningWaveNow = "Welle %d: %s erschienen"
})

L:SetTimerLocalization({
	TimerWaveIn		= "Nächste Welle (6)",
	TimerRoleplay	= "Eröffnungsrollenspiel"
})

L:SetOptionLocalization({
	WarningWaveNow	= "Zeige Warnung für neue Welle",
	TimerWaveIn		= "Zeige Zeit bis die nächste Wellengruppe nach dem ersten Boss kommt",
	TimerRoleplay	= "Dauer des Eröffnungsrollenspiels anzeigen"
})

L:SetMiscLocalization({
	Devouring	= "Verschlingender Ghul",
	Enraged		= "Aufgebrachter Ghul",
	Necro		= "Totenbeschwörer",
	Fiend		= "Gruftbestie",
	Stalker		= "Grabschleicher",
	Abom		= "Flickwerkkonstrukt",
	Acolyte		= "Akolyth",
	Wave1		= "%d %s",
	Wave2		= "%d %s und %d %s",
	Wave3		= "%d %s, %d %s und %d %s",
	Wave4		= "%d %s, %d %s, %d %s und %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "Geißelwelle = (%d+)/10",
	Roleplay	= "Wie schön, dass Ihr es geschafft habt, Uther.",
	Roleplay2	= "Alle sind bereit. Vergesst nicht, diese Leute sind alle infiziert und werden bald sterben. Wir müssen Stratholme säubern, um den Rest Lordaerons vor der Geißel zu schützen. Los jetzt."
})

------------------------
--  Drak'Tharon Keep  --
------------------------
--  Trollgore  --
-----------------
L = DBM:GetModLocalization(588)

--------------------------
--  Novos the Summoner  --
--------------------------
L = DBM:GetModLocalization(589)

L:SetMiscLocalization({
	YellPull		= "Was ihr spürt, ist euer Ende, das naht.",
	HandlerYell		= "Verstärkt meine Verteidigung! Schnell, verdammt!",
	Phase2			= "Sicher seht ihr, dass alles vergebens ist!",
	YellKill		= "Eure Mühen... sind umsonst."
})

-----------------
--  King Dred  --
-----------------
L = DBM:GetModLocalization(590)

-----------------------------
--  The Prophet Tharon'ja  --
-----------------------------
L = DBM:GetModLocalization(591)

---------------
--  Gundrak  --
----------------
--  Slad'ran  --
----------------
L = DBM:GetModLocalization(592)

---------------
--  Moorabi  --
---------------
L = DBM:GetModLocalization(594)

-------------------------
--  Drakkari Colossus  --
-------------------------
L = DBM:GetModLocalization(593)

-----------------
--  Gal'darah  --
-----------------
L = DBM:GetModLocalization(596)

-------------------------
--  Eck the Ferocious  --
-------------------------
L = DBM:GetModLocalization(595)

--------------------------
--  Halls of Lightning  --
--------------------------
--  General Bjarngrim  --
-------------------------
L = DBM:GetModLocalization(597)

-------------
--  Ionar  --
-------------
L = DBM:GetModLocalization(599)

---------------
--  Volkhan  --
---------------
L = DBM:GetModLocalization(598)

-------------
--  Loken  --
-------------
L = DBM:GetModLocalization(600)

----------------------
--  Halls of Stone  --
-----------------------
--  Maiden of Grief  --
-----------------------
L = DBM:GetModLocalization(605)

------------------
--  Krystallus  --
------------------
L = DBM:GetModLocalization(604)

------------------------------
--  Sjonnir the Ironshaper  --
------------------------------
L = DBM:GetModLocalization(607)

--------------------------------------
--  Brann Bronzebeard Escort Event  --
--------------------------------------
L = DBM:GetModLocalization(606)

L:SetWarningLocalization({
	WarningPhase	= "Phase %d"
})

L:SetTimerLocalization({
	timerEvent	= "Zeit verbleibend"
})

L:SetOptionLocalization({
	WarningPhase	= "Zeige Warnung für Phasenwechsel",
	timerEvent		= "Dauer des Ereignisses anzeigen"
})

L:SetMiscLocalization({
	Pull	= "Haltet jetzt die Augen offen! Ich werde die Sache hier im Handumdrehen...",
	Phase1	= "Sicherheitsverletzung. Setze Analyse historischer Archive auf niedrige Priorität. Leite Gegenmaßnahmen ein.",
	Phase2	= "Bedrohungsindexgrenze überschritten. Himmelsarchiv abgebrochen. Alarmstufe erhöht.",
	Phase3	= "Kritischer Bedrohungsindex. Leerenanalyse umgeleitet. Initialisiere Säuberungsprotokoll.",
	Kill	= "Alarm: Sicherungssysteme deaktiviert. Beginne Speichersäuberung und..."
})

-----------------
--  The Nexus  --
-----------------
--  Anomalus  --
----------------
L = DBM:GetModLocalization(619)

-------------------------------
--  Ormorok the Tree-Shaper  --
-------------------------------
L = DBM:GetModLocalization(620)

----------------------------
--  Grand Magus Telestra  --
----------------------------
L = DBM:GetModLocalization(618)

L:SetMiscLocalization({
	SplitTrigger1		= "Es ist genug von mir für alle da.",
	SplitTrigger2		= "Ich teile mehr aus, als ihr verkraften könnt"
})

-------------------
--  Keristrasza  --
-------------------
L = DBM:GetModLocalization(621)

-----------------------------------
--  Commander Kolurg/Stoutbeard  --
-----------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "Eingefrorener Kommandant"
if UnitFactionGroup("player") == "Alliance" then
	commander = "Kommandant Kolurg"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "Kommandant Starkbart"
end

L:SetGeneralLocalization({
	name = commander
})

------------------
--  The Oculus  --
-------------------------------
--  Drakos the Interrogator  --
-------------------------------
L = DBM:GetModLocalization(622)

L:SetOptionLocalization({
	MakeitCountTimer	= "Zeige Timer für Erfolg 'Jagt ihn!'"
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Jagt ihn!"
})

----------------------
--  Mage-Lord Urom  --
----------------------
L = DBM:GetModLocalization(624)

L:SetMiscLocalization({
	CombatStart		= "Arme, blinde Narren!"
})

--------------------------
--  Varos Cloudstrider  --
--------------------------
L = DBM:GetModLocalization(623)

---------------------------
--  Ley-Guardian Eregos  --
---------------------------
L = DBM:GetModLocalization(625)

L:SetMiscLocalization({
	MakeitCountTimer	= "Jagt ihn!"
})

--------------------
--  Utgarde Keep  --
-----------------------
--  Prince Keleseth  --
-----------------------
L = DBM:GetModLocalization(638)

--------------------------------
--  Skarvald the Constructor  --
--  & Dalronn the Controller  --
--------------------------------
L = DBM:GetModLocalization(639)

----------------------------
--  Ingvar the Plunderer  --
----------------------------
L = DBM:GetModLocalization(640)

L:SetMiscLocalization({
	YellCombatEnd	= "Nein! Ich bin... besser, Ich bin..."
})

------------------------
--  Utgarde Pinnacle  --
--------------------------
--  Skadi the Ruthless  --
--------------------------
L = DBM:GetModLocalization(643)

L:SetMiscLocalization({
	CombatStart		= "Welche Hunde wagen es, hier einzudringen? Auf sie, meine Brüder! Ein Fest für den, der mir ihre Köpfe bringt!",
	Phase2			= "Ihr räudigen Halunken! Eure Leichen werden feine Appetithappen für meinen neuen Drachen abgeben!"
})

-------------------
--  King Ymiron  --
-------------------
L = DBM:GetModLocalization(644)

-------------------------
--  Svala Sorrowgrave  --
-------------------------
L = DBM:GetModLocalization(641)

L:SetTimerLocalization({
	timerRoleplay		= "Svala Grabesleid aktiv"
})

L:SetOptionLocalization({
	timerRoleplay		= "Zeige Dauer des Rollenspiels bevor Svala Grabesleid aktiv wird"
})

L:SetMiscLocalization({
	SvalaRoleplayStart	= "Mein Meister! Ich tat, was Ihr verlangtet, und ersuche Euch um Euren Segen!"
})

-----------------------
--  Gortok Palehoof  --
-----------------------
L = DBM:GetModLocalization(642)

-----------------------
--  The Violet Hold  --
-----------------------
--  Cyanigosa  --
-----------------
L = DBM:GetModLocalization(632)

L:SetMiscLocalization({
	CyanArrived	= "Eine beherzte Verteidigung, aber diese Stadt muss dem Erdboden gleichgemacht werden. Ich werde Malygos' Befehle persönlich ausführen!"
})

--------------
--  Erekem  --
--------------
L = DBM:GetModLocalization(626)

---------------
--  Ichoron  --
---------------
L = DBM:GetModLocalization(628)

-----------------
--  Lavanthor  --
-----------------
L = DBM:GetModLocalization(630)

--------------
--  Moragg  --
--------------
L = DBM:GetModLocalization(627)

--------------
--  Xevozz  --
--------------
L = DBM:GetModLocalization(629)

-------------------------------
--  Zuramat the Obliterator  --
-------------------------------
L = DBM:GetModLocalization(631)

---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "Portaltimer"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "Neues Portal bald",
	WarningPortalNow	= "Portal %d",
	WarningBossNow		= "Boss kommt"
})

L:SetTimerLocalization({
	TimerPortalIn	= "Portal %d",
})

L:SetOptionLocalization({
	WarningPortalNow		= "Zeige Warnung für neues Portal",
	WarningPortalSoon		= "Zeige Vorwarnung für neues Portal",
	WarningBossNow			= "Zeige Warnung für neuen Boss",
	TimerPortalIn			= "Zeige Timer für nächstes Portal (nach einem Boss)",
	ShowAllPortalTimers		= "Zeige Timer für alle Portale (ungenau)"
})

L:SetMiscLocalization({
	Sealbroken	= "Wir haben das Gefängnistor durchbrochen! Der Weg nach Dalaran ist frei! Jetzt können wir den Nexuskrieg endlich beenden!",
	WavePortal	= "Geöffnete Portale: (%d+)/18"
})

-----------------------------
--  Trial of the Champion  --
-----------------------------
--  The Black Knight  --
------------------------
L = DBM:GetModLocalization(637)

L:SetOptionLocalization({
	AchievementCheck		= "Verkünde Fehlschlag des Erfolgs 'Ich hab' schon Schlimmeres gesehen' an Gruppe"
})

L:SetMiscLocalization({
	Pull				= "Gut gemacht. Ihr habt Euch heute bewiesen-",
	AchievementFailed	= ">> ERFOLG FEHLGESCHLAGEN: %s wurde von Ghulexplosion getroffen <<",
	YellCombatEnd		= "Meine Glückwünsche, Champions. In Prüfungen sowohl geplant als auch unerwartet habt Ihr triumphiert."	-- can also be "Nein! Ich darf nicht... wieder... versagen..."
})

-----------------------
--  Grand Champions  --
-----------------------
L = DBM:GetModLocalization(634)

L:SetMiscLocalization({
	YellCombatEnd	= "Gut gekämpft! Eure nächste Herausforderung kommt aus den eigenen Reihen des Kreuzzugs. Ihr werdet Euch gegen ihre eindrucksvolle Tapferkeit beweisen müssen."
})

----------------------------------
--  Argent Confessor Paletress  --
----------------------------------
L = DBM:GetModLocalization(636)

L:SetMiscLocalization({
	YellCombatEnd	= "Exzellente Arbeit!"
})

-----------------------
--  Eadric the Pure  --
-----------------------
L = DBM:GetModLocalization(635)

L:SetMiscLocalization({
	YellCombatEnd	= "Ich ergebe mich! Exzellente Arbeit. Darf ich jetzt wegrennen?"
})

--------------------
--  Pit of Saron  --
---------------------
--  Ick and Krick  --
---------------------
L = DBM:GetModLocalization(609)

L:SetMiscLocalization({
	Barrage	= "%s fängt an, schnell explosive Minen herbeizuzaubern!"
})

----------------------------
--  Forgemaster Garfrost  --
----------------------------
L = DBM:GetModLocalization(608)

L:SetOptionLocalization({
	AchievementCheck			= "Verkünde Warnungen für den Erfolg 'Elfer raus!' an Gruppe"
})

L:SetMiscLocalization({
	SaroniteRockThrow	= "%s schleudert Euch einen massiven Saronitstein entgegen!",
	AchievementWarning	= "Warnung: %s hat %d Stapel von Permafrost",
	AchievementFailed	= ">> ERFOLG FEHLGESCHLAGEN: %s hat %d Stapel von Permafrost <<"
})

----------------------------
--  Scourgelord Tyrannus  --
----------------------------
L = DBM:GetModLocalization(610)

L:SetMiscLocalization({
	CombatStart	= "Ach, Ihr tapferen, tapferen Helden, Euer kleiner Aufstand endet hier. Hört Ihr das Geklapper von Stahl und Knochen aus dem Tunnel hinter Euch? Das ist das Geräusch Eures Todes.",
	HoarfrostTarget	= "Der Frostwyrm Raufang wendet sich (%S+) zu und bereitet einen eisigen Angriff vor!",
	YellCombatEnd	= "Unmöglich... Raufang... warne..."
})

----------------------
--  Forge of Souls  --
----------------------
--  Bronjahm  --
----------------
L = DBM:GetModLocalization(615)

-------------------------
--  Devourer of Souls  --
-------------------------
L = DBM:GetModLocalization(616)

---------------------------
--  Halls of Reflection  --
---------------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("HoRWaveTimer")

L:SetGeneralLocalization({
	name = "Wellentimer"
})

L:SetWarningLocalization({
	WarnNewWaveSoon	= "Neue Welle bald",
	WarnNewWave		= "%s kommt"
})

L:SetTimerLocalization({
	TimerNextWave	= "Nächste Welle"
})

L:SetOptionLocalization({
	WarnNewWave			= "Zeige Warnung für neuen Boss",
	WarnNewWaveSoon		= "Zeige Vorwarnung für neue Welle nach dem ersten Boss",
	ShowAllWaveWarnings	= "Zeige Warnungen für alle Wellen",
	TimerNextWave		= "Zeige Zeit bis die nächste Wellengruppe nach dem ersten Boss kommt",
	ShowAllWaveTimers	= "Zeige Vorwarnung und Timer für alle Wellen (ungenau)"
})

L:SetMiscLocalization({
	WaveCheck	= "Geisterwelle = (%d+)/10"
})

--------------
--  Falric  --
--------------
L = DBM:GetModLocalization(601)

--------------
--  Marwyn  --
--------------
L = DBM:GetModLocalization(602)

-----------------------
--  Lich King Event  --
-----------------------
L = DBM:GetModLocalization(603)

L:SetWarningLocalization({
	WarnWave		= "%s"
})

L:SetTimerLocalization({
	achievementEscape	= "Zeit zur Flucht"
})

L:SetOptionLocalization({
	WarnWave	= "Zeige Warnung für Monsterwellen"
})

L:SetMiscLocalization({
	ACombatStart	= "Seine Macht ist zu groß. Wir müssen diesen Ort sofort verlassen! Meine Magie kann ihn nur kurze Zeit halten. Beeilt Euch, Helden!",
	HCombatStart	= "Er ist... zu mächtig. Schnell, Helden... kommt! Wir müssen fliehen. Ich werde mein Möglichstes tun, um ihn solange es geht an Ort und Stelle zu halten."
})
