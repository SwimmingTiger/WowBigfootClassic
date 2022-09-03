if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-----------
-- Ahune --
-----------
L = DBM:GetModLocalization("d286")

L:SetWarningLocalization({
	Emerged			= "Ahune vuelve a la superficie",
	specWarnAttack	= "Ahune es vulnerable - ¡Ataca ahora!"
})

L:SetTimerLocalization{
	SubmergeTimer	= "Sumergir",
	EmergeTimer		= "Volver a la superficie"
}

L:SetOptionLocalization({
	Emerged			= "Mostrar aviso cuando Ahune vuelva a la superficie",
	specWarnAttack	= "Mostrar aviso especial cuando Ahune se vuelva vulnerable",
	SubmergeTimer	= "Mostrar temporizador para cuando Ahune se sumerja",
	EmergeTimer		= "Mostrar temporizador para cuando Ahune vuelva a la superficie"
})

L:SetMiscLocalization({
	Pull			= "¡La piedra de hielo se ha derretido!"
})

---------------------------
-- Coren Cerveza Temible --
---------------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew		= "¡Bebe la cerveza antes de que te lance otra!",
	specWarnBrewStun	= "SUGERENCIA: ¡Te han dado! ¡No te olvides de beber la cerveza!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Mostrar aviso especial para $spell:47376",
	specWarnBrewStun	= "Mostrar aviso especial para $spell:47340"
})

L:SetMiscLocalization({
	YellBarrel			= "¡Tengo el barril!"
})

--------------------------
-- El Jinete decapitado --
--------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "Fase %d",
	warnHorsemanSoldiers	= "Calabazas con pulso",
	warnHorsemanHead		= "Cabeza de El jinete decapitado"
})

L:SetOptionLocalization({
	WarnPhase				= "Mostrar aviso para cambios de fase",
	warnHorsemanSoldiers	= "Mostrar aviso cuando aparezcan Cabalazas con pulso",
	warnHorsemanHead		= "Mostrar aviso cuando aparezca la Cabeza de El jinete decapitado"
})

L:SetMiscLocalization({
	HorsemanSummon			= "Jinete álzate...",
	HorsemanSoldiers		= "Soldados, alzaos y luchad, tomad vuestro acero. Dad la victoria a este deshonrado caballero."
})
