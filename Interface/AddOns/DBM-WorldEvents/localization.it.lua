if GetLocale() ~= "itIT" then return end
local L

----------------------------
--  The Frost Lord Ahune  --
----------------------------
L = DBM:GetModLocalization("d286")

L:SetWarningLocalization({
	Emerged			= "Emersione",
	specWarnAttack	= "Ahune è vulnerabile - Attaccalo!"
})

L:SetTimerLocalization{
	SubmergeTimer	= "Immersione",
	EmergeTimer		= "Emersione"
}

L:SetOptionLocalization({
	Emerged			= "Mostra avviso all'emersione di Ahune",
	specWarnAttack	= "Mostra avviso speciale quando Ahune diventa vulnerabile",
	SubmergeTimer	= "Mostra temporizzatore immersione",
	EmergeTimer		= "Mostra temporizzatore emersione"
})

L:SetMiscLocalization({
	Pull			= "The Ice Stone has melted!" -- TODO
})

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew		= "Sbarazzati della botte prima che te ne lanci un altro!",
	specWarnBrewStun	= "SUGGERIMENTO: Sei stato colpito, ricordati di bere la birra la prossima volta!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Mostra avviso speciale per $spell:47376",
	specWarnBrewStun	= "Mostra avviso speciale per $spell:47340"
})

L:SetMiscLocalization({
	YellBarrel			= "Botte su di me!"
})

-----------------------------
--  The Headless Horseman  --
-----------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "Fase %d",
	warnHorsemanSoldiers	= "Evocazione Zucche Pulsanti",
	warnHorsemanHead		= "Testa del Cavaliere Attiva"
})

L:SetOptionLocalization({
	WarnPhase				= "Mostra avviso per ogni cambio fase",
	warnHorsemanSoldiers	= "Mostra avviso evocazione Zucche Pulsanti",
	warnHorsemanHead		= "Mostra avviso evocazione Testa del Cavaliere"
})

L:SetMiscLocalization({
	HorsemanSummon			= "Horseman rise...", -- TODO
	HorsemanSoldiers		= "Soldiers arise, stand and fight! Bring victory at last to this fallen knight!" -- TODO
})
