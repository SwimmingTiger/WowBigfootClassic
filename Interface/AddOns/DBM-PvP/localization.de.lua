if GetLocale() ~= "deDE" then return end
local L

--------------------------
--  General BG Options  --
--------------------------
L = DBM:GetModLocalization("PvPGeneral")

L:SetGeneralLocalization({
	name	= "Allgemeine Einstellungen"
})

L:SetTimerLocalization({
	TimerInvite	= "%s"
})

L:SetOptionLocalization({
	ColorByClass		= "Einfärbung der Spielernamen nach Klasse in der Schlachtfeld-Punktetafel",
	TimerInvite			= "Zeige Zeit für Schlachtfeld-Beitrittsmöglichkeit",
	AutoSpirit			= "Automatisch Geist freilassen",
	HideBossEmoteFrame	= "Verberge das Fenster \"RaidBossEmoteFrame\" und Garnisons-/Gildenerfolgsmeldungen während Schlachtfeldern"
})

L:SetMiscLocalization({
	BgStart60			= "Die Schlacht beginnt in 1 Minute.",
	BgStart30			= "Die Schlacht beginnt in 30 Sekunden. Macht Euch bereit!",
	ExprFlagPickUp		= "(.+) hat die Flagge der (%w+) aufgenommen!",
	ExprFlagCaptured	= "(.+) hat die Flagge der (%w+) errungen!",
	ExprFlagReturn		= "Die Flagge der (%w+) wurde von (.+) zu ihrem Stützpunkt zurückgebracht!",
	Vulnerable1			= "Eure Angriffe verursachen nun schwerere Verletzungen bei Flaggenträgern!",
	Vulnerable2			= "Eure Angriffe verursachen nun sehr schwere Verletzungen bei Flaggenträgern!"
})
----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("z30")

L:SetOptionLocalization({
	AutoTurnIn	= "Automatisches Abgeben der Quests im Alteractal"
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("z628")

L:SetWarningLocalization({
	WarnSiegeEngine		= "Belagerungsmaschine bereit!",
	WarnSiegeEngineSoon	= "Belagerungsmaschine in ~10 Sekunden"
})

L:SetTimerLocalization({
	TimerSiegeEngine	= "Belagerungsmaschine"
})

L:SetOptionLocalization({
	TimerSiegeEngine	= "Zeige Zeit bis Belagerungsmaschine bereit ist",
	WarnSiegeEngine		= "Zeige Warnung, wenn Belagerungsmaschine bereit ist",
	WarnSiegeEngineSoon	= "Zeige Warnung, wenn Belagerungsmaschine fast bereit ist",
	ShowGatesHealth		= "Zeige Erhaltungsgrad beschädigter Tore (kann nach dem Beitritt<br/>zu einem bereits laufenden Schlachtfeld falsche Werte liefern!)"
})

L:SetMiscLocalization({
	GatesHealthFrame		= "Beschädigte Tore",
	SiegeEngine				= "Belagerungsmaschine",
	GoblinStartAlliance		= "Seht Ihr diese Zephyriumbomben? Benutzt sie an den Toren, während ich die Belagerungsmaschine repariere!",
	GoblinStartHorde		= "Ich arbeite an der Belagerungsmaschine. Haltet mir einfach nur den Rücken frei. Benutzt diese Zephyriumbomben an den Toren, solltet Ihr sie brauchen!",
	GoblinHalfwayAlliance	= "Ich hab's gleich! Haltet die Horde von hier fern. Kämpfen stand in der Ingenieursschule nicht auf dem Lehrplan!",
	GoblinHalfwayHorde		= "Ich hab's gleich! Haltet mir die Allianz vom Leib. Kämpfen steht nicht in meinem Vertrag!",
	GoblinFinishedAlliance	= "Meine beste Arbeit bisher! Diese Belagerungsmaschine ist bereit, ein bisschen Aktion zu sehen!",
	GoblinFinishedHorde		= "Die Belagerungsmaschine ist bereit, loszurollen!",
	GoblinBrokenAlliance	= "Es ist schon kaputt?! Ach, keine Sorge, nichts, was ich nicht reparieren kann.",
	GoblinBrokenHorde		= "Schon wieder kaputt?! Ich werde es richten... Ihr solltet allerdings nicht davon ausgehen, dass das noch unter die Garantie fällt."
})

-------------------------
--  Silvershard Mines  --
-------------------------
L = DBM:GetModLocalization("z727")

L:SetTimerLocalization({
	TimerRespawn	= "Wagen-Respawn"
})

L:SetOptionLocalization({
	TimerRespawn	= "Zeige Zeit bis zum Respawn der Wagen",
	TimerCart		= "Show cart cap timer"
})

L:SetMiscLocalization({
	Capture	= "hat eine Minenlore erobert",
	Arrived	= "has arived",
	Begun	= "has begun"
})

-------------------------
--  Temple of Kotmogu  --
-------------------------
L = DBM:GetModLocalization("z998")

L:SetMiscLocalization({
	OrbTaken	= "(%S+) hat die (%S+) Kugel genommen!",
	OrbReturn	= "Die (%S+) Kugel wurde zurückgebracht!"
})
