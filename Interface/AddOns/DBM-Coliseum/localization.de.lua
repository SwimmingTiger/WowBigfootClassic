if GetLocale() ~= "deDE" then return end
local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Bestien von Nordend"
}

L:SetWarningLocalization{
	WarningSnobold		= "Schneeboldvasall erschienen auf >%s<"
}

L:SetTimerLocalization{
	TimerNextBoss		= "Nächster Boss",
	TimerEmerge			= "Auftauchen",
	TimerSubmerge		= "Abtauchen"
}

L:SetOptionLocalization{
	WarningSnobold		= "Zeige Warnung, wenn ein Schneeboldvasall erscheint",
	ClearIconsOnIceHowl	= "Entferne alle Zeichen vor dem Trampeln",
	TimerNextBoss		= "Zeige Zeit bis zum Erscheinen des nächsten Bosses",
	TimerEmerge			= "Zeige Zeit bis Auftauchen",
	TimerSubmerge		= "Zeige Zeit bis Abtauchen",
	IcehowlArrow		= "Zeige DBM-Pfeil, wenn Eisheuler jemand in deiner Nähe niedertrampeln will"
}

L:SetMiscLocalization{
	Charge		= "^%%s sieht (%S+) zornig an und lässt einen gewaltigen Schrei ertönen!",
	CombatStart	= "Er kommt aus den tiefsten, dunkelsten Höhlen der Sturmgipfel - Gormok der Pfähler! Voran, Helden!",
	Phase2		= "Stählt Euch, Helden, denn die Zwillingsschrecken Ätzschlund und Schreckensmaul erscheinen in der Arena!",
	Phase3		= "Mit der Ankündigung unseres nächsten Kämpfers gefriert die Luft selbst: Eisheuler! Tötet oder werdet getötet, Champions!",
	Gormok		= "Gormok der Pfähler",
	Acidmaw		= "Ätzschlund",
	Dreadscale	= "Schreckensmaul",
	Icehowl		= "Eisheuler"
}

---------------------
--  Lord Jaraxxus  --
---------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "Lord Jaraxxus"
}

L:SetOptionLocalization{
	IncinerateShieldFrame		= "Zeige Lebensanzeige mit einem Balken für Fleisch einäschern"
}

L:SetMiscLocalization{
	IncinerateTarget	= "Fleisch einäschern: %s",
	FirstPull	= "Großhexenmeister Wilfred Zischknall wird Eure nächste Herausforderung beschwören. Harrt seiner Ankunft."
}

-------------------------
--  Faction Champions  --
-------------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "Fraktionschampions"
}

L:SetMiscLocalization{
	AllianceVictory    = "EHRE DER ALLIANZ!",
	HordeVictory       = "Das ist nur ein Vorgeschmack auf die Zukunft. FÜR DIE HORDE!"
}

---------------------
--  Val'kyr Twins  --
---------------------
L = DBM:GetModLocalization("ValkTwins")

L:SetGeneralLocalization{
	name = "Zwillingsval'kyr"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "Nächste Spezialfähigkeit"
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "Spezialfähigkeit bald",
	SpecWarnSpecial				= "Farbe wechseln",
	SpecWarnSwitchTarget		= "Ziel wechseln",
	SpecWarnKickNow				= "Jetzt unterbrechen",
	WarningTouchDebuff			= "Berührung auf >%s<",
	WarningPoweroftheTwins2		= "Macht der Zwillinge - Mehr Heilung auf >%s<"
}

L:SetMiscLocalization{
	Fjola		= "Fjola Lichtbann",
	Eydis		= "Eydis Nachtbann"
}

L:SetOptionLocalization{
	TimerSpecialSpell			= "Zeige Zeit bis nächste Spezialfähigkeit",
	WarnSpecialSpellSoon		= "Zeige Vorwarnung für nächste Spezialfähigkeit",
	SpecWarnSpecial				= "Spezialwarnung, wenn du die Farbe wechseln musst",
	SpecWarnSwitchTarget		= "Spezialwarnung, wenn der andere Zwilling zaubert",
	SpecWarnKickNow				= "Spezialwarnung zum Unterbrechen",
	SpecialWarnOnDebuff			= "Spezialwarnung bei Berührung (um Farbe zu wechseln)",
	SetIconOnDebuffTarget		= "Setze Zeichen auf Ziele von Berührung des Lichts/der Nacht (heroisch)",
	WarningTouchDebuff			= "Verkünde Ziele von Berührung des Lichts/der Nacht",
	WarningPoweroftheTwins2		= "Verkünde Ziele von Macht der Zwillinge"
}

-----------------
--  Anub'arak  --
-----------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 					= "Anub'arak"
}

L:SetTimerLocalization{
	TimerEmerge				= "Auftauchen",
	TimerSubmerge			= "Abtauchen",
	timerAdds				= "Neue Adds"
}

L:SetWarningLocalization{
	WarnEmerge				= "Auftauchen",
	WarnEmergeSoon			= "Auftauchen in 10 Sekunden",
	WarnSubmerge			= "Abtauchen",
	WarnSubmergeSoon		= "Abtauchen in 10 Sekunden",
	specWarnSubmergeSoon	= "Abtauchen in 10 Sekunden!",
	warnAdds				= "Neue Adds"
}

L:SetMiscLocalization{
	Emerge				= "entsteigt dem Boden!",
	Burrow				= "gräbt sich in den Boden!",
	PcoldIconSet		= "DKälte-Zeichen {rt%d} auf %s gesetzt",
	PcoldIconRemoved	= "DKälte-Zeichen von %s entfernt"
}

L:SetOptionLocalization{
	WarnEmerge				= "Zeige Warnung für Auftauchen",
	WarnEmergeSoon			= "Zeige Vorwarnung für Auftauchen",
	WarnSubmerge			= "Zeige Warnung für Abtauchen",
	WarnSubmergeSoon		= "Zeige Vorwarnung für Abtauchen",
	specWarnSubmergeSoon	= "Spezialwarnung für baldiges Abtauchen",
	warnAdds				= "Verkünde neue Adds",
	timerAdds				= "Zeige Zeit bis neue Adds erscheinen",
	TimerEmerge				= "Zeige Zeit bis Auftauchen",
	TimerSubmerge			= "Zeige Zeit bis Abtauchen",
	AnnouncePColdIcons		= "Verkünde Zeichen für Ziele von $spell:66013 im Schlachtzugchat (nur als Leiter)",
	AnnouncePColdIconsRemoved	= "Verkünde auch das Entfernen von Zeichen für $spell:66013 (benötigt obige Einstellung)"
}

