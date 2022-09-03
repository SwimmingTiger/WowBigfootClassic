if GetLocale() ~= "deDE" then return end
local L

----------------------------
--  The Frost Lord Ahune  --
----------------------------
L = DBM:GetModLocalization("d286")

L:SetWarningLocalization({
	Emerged			= "Aufgetaucht",
	specWarnAttack	= "Ahune ist verwundbar - Angriff!"
})

L:SetTimerLocalization{
	SubmergeTimer	= "Abtauchen",
	EmergeTimer		= "Auftauchen"
}

L:SetOptionLocalization({
	Emerged			= "Zeige Warnung, wenn Ahune auftaucht",
	specWarnAttack	= "Spezialwarnung, wenn Ahune verwundbar wird",
	SubmergeTimer	= "Zeige Zeit bis Abtauchen",
	EmergeTimer		= "Zeige Zeit bis Auftauchen"
})

L:SetMiscLocalization({
	Pull			= "Der Eisbrocken ist geschmolzen!"
})

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew		= "Werde das Bier los, bevor sie dir noch eins zuwirft!",
	specWarnBrewStun	= "TIPP: Du hast eine Kopfnuss kassiert, trink das Bier beim nächsten Mal!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Spezialwarnung für $spell:47376",
	specWarnBrewStun	= "Spezialwarnung für $spell:47340"
})

L:SetMiscLocalization({
	YellBarrel			= "Stecke im Fass!"
})

-----------------------------
--  The Headless Horseman  --
-----------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "Phase %d",
	warnHorsemanSoldiers	= "Pulsierende Kürbisse erscheinen",
	warnHorsemanHead		= "Kopf des Reiters aktiv"
})

L:SetOptionLocalization({
	WarnPhase				= "Zeige Warnung für jeden Phasenwechsel",
	warnHorsemanSoldiers	= "Zeige Warnung, wenn Pulsierende Kürbnisse erscheinen",
	warnHorsemanHead		= "Zeige Warnung, wenn Kopf des Reiters erscheint"
})

L:SetMiscLocalization({
	HorsemanSummon			= "Erhebe dich, Reiter,...",
	HorsemanSoldiers		= "Soldaten, erhebt Euch und kämpft immer weiter. Bringt endlich den Sieg zum gefallenen Reiter!"
})
