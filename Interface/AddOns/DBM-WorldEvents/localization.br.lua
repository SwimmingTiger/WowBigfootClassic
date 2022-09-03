--Last update by GlitterStorm @ Azralon on Feb,21th,2015

if GetLocale() ~= "ptBR" then return end

local L

-------------
--  Ahune  --
-------------
L = DBM:GetModLocalization("d286")

L:SetWarningLocalization({
	Emerged			= "Ahune Emergiu",
	specWarnAttack	= "Ahune está vulnerável - Ataque agora!"
})

L:SetTimerLocalization{
	SubmergeTimer	        = "Submergir",
	EmergeTimer		= "Emergir"
}


L:SetOptionLocalization({
	Emerged			= "Exibir aviso quando Ahune emergir",
	specWarnAttack	= "Exibir aviso especial quando Ahune tornar-se vulnerável",
	SubmergeTimer	= "Exibir cronógrafo para submergir",
	EmergeTimer		= "Exibir cronógrafo para emergir"
})

L:SetMiscLocalization({
	Pull			= "A pedra de gelo derreteu!"
})

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew		= "Livre-se da bebida antes que ela te jogue outra!",
	specWarnBrewStun	= "DICA: Você foi atordoado, lembre-se de beber da próxima vez!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Exibir aviso especial para $spell:47376",
	specWarnBrewStun	= "Exibir aviso especial para $spell:47340"
})

L:SetMiscLocalization({
	YellBarrel			= "Barril em mim!"
})

-------------------------
--  Headless Horseman  --
-------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "Fase %d",
	warnHorsemanSoldiers	= "Abóboras Pulsantes surgindo",
	warnHorsemanHead		= "Cabeça do Cavaleiro ativa"
})

L:SetOptionLocalization({
	WarnPhase				= "Exibir aviso para cada mudança de fase",
	warnHorsemanSoldiers	= "Exibir aviso para surgimento de Abóboras Pulsantes",
	warnHorsemanHead		= "Exibir aviso para surgimento da Cabeça do Cavaleiro"
})

L:SetMiscLocalization({
	HorsemanSummon			= "Cavaleiro ascende...",
	HorsemanSoldiers		= "Soldados levantem-se, fiquem e lutem! Tragam finalmente à vitória para este cavaleiro caido!"
})
