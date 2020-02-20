if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

--------------------------
--  General BG Options  --
--------------------------
L = DBM:GetModLocalization("PvPGeneral")

L:SetGeneralLocalization({
	name	= "Opciones generales"
})

L:SetTimerLocalization({
	TimerInvite	= "%s"
})

L:SetOptionLocalization({
	ColorByClass		= "Mostrar nombres con el color de su clase en la tabla de estadísticas",
	TimerInvite			= "Mostrar tiempo restante para unirse al campo de batalla",
	AutoSpirit			= "Liberar espíritu automáticamente",
	HideBossEmoteFrame	= "Ocultar marco de jefe de banda y botón de ciudadela en campos de batalla"
})

L:SetMiscLocalization({
	BgStart60	= "La batalla comienza en 1 minuto.",
	BgStart30	= "La batalla comienza en 30 segundos. ¡Preparaos!",
	ArenaInvite	= "Invitación a la arena"
})

--------------
--  Arenas  --
--------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name	= "Arenas"
})

L:SetTimerLocalization({
	TimerShadow	= "Visión de las Sombras"
})

L:SetOptionLocalization({
	TimerShadow	= "Mostrar temporizador para Visión de las Sombras"
})

L:SetMiscLocalization({
	Start15			= "¡Quince segundos hasta que comience la batalla en arena!",
	highmaulArena	= "¡La batalla por la supremacía comienza en 30 segundos!"
})

----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("z30")

L:SetTimerLocalization({
	TimerTower	= "%s",
	TimerGY		= "%s"
})

L:SetOptionLocalization({
	TimerTower	= "Mostrar temporizador para captura de torres",
	TimerGY		= "Mostrar temporizador para captura de cementerios",
	AutoTurnIn	= "Entregar misiones automáticamente"
})

--------------------
--  Arathi Basin  --
--------------------
L = DBM:GetModLocalization("z529")

L:SetTimerLocalization({
	TimerCap	= "%s"
})

L:SetOptionLocalization({
	TimerWin				= "Mostrar temporizador de victoria",
	TimerCap				= "Mostrar temporizador de captura",
	ShowAbEstimatedPoints	= "Mostrar recursos restantes estimados para ganar/perder",
	ShowAbBasesToWin		= "Mostrar bases necesarias para ganar"
})

L:SetMiscLocalization({
	ScoreExpr	= "(%d+)/1500",
	WinBarText	= "La %s gana",
	BasesToWin	= "Bases para ganar: %d"
})

---------------------
--  Deepwind Gorge --
---------------------
L = DBM:GetModLocalization("z1105")

L:SetTimerLocalization({
	TimerCap	= "%s"
})

L:SetOptionLocalization({
	TimerCap	= "Mostrar temporizador de captura",
	TimerWin	= "Mostrar temporizador de victoria"
})

L:SetMiscLocalization({
	ScoreExpr	= "(%d+)/1500",
	WinBarText	= "La %s gana"
})

------------------------
--  Eye of the Storm  --
------------------------
L = DBM:GetModLocalization("z566")

L:SetTimerLocalization({
	TimerFlag	= "Reaparición de bandera"
})

L:SetOptionLocalization({
	TimerWin		= "Mostrar temporizador de victoria",
	TimerFlag		= "Mostrar temporizador de reaparición de bandera",
	ShowPointFrame	= "Mostrar portador de bandera y puntos estimados"
})

L:SetMiscLocalization({
	ScoreExpr		= "(%d+)/1500",
	WinBarText		= "La %s gana",
	Flag			= "Bandera",
	FlagReset		= "La bandera se ha restablecido.",
	FlagTaken		= "¡(.+) ha tomado la bandera!",
	FlagCaptured	= "¡La .+ ha%w+ ha capturado la bandera!",
	FlagDropped		= "¡Ha caído la bandera!"
})

---------------------
--  Warsong Gulch  --
---------------------
L = DBM:GetModLocalization("z489")

L:SetTimerLocalization({
	TimerStart	= "La batalla comienza",
	TimerFlag	= "Reaparición de bandera"
})

L:SetOptionLocalization({
	TimerStart					= "Mostrar temporizador de inicio",
	TimerFlag					= "Mostrar temporizador de reaparición de banderas",
	ShowFlagCarrier				= "Mostrar portadores de banderas",
	ShowFlagCarrierErrorNote	= "Mostrar mensaje de error de portador de bandera al estar en combate"
})

L:SetMiscLocalization({
	InfoErrorText		= "La función de selección de portador de bandera se restaurará cuando salgas de combate.",
	ExprFlagPickUp		= "¡(.+) ha cogido la bandera de la (%w+)!",
	ExprFlagCaptured	= "¡(.+) ha capturado la bandera de la (%w+)!",
	ExprFlagReturn		= "¡(.+) ha devuelto la bandera de la (%w+) a su base!",
	FlagAlliance		= "Banderas capturadas por la Alianza: ",
	FlagHorde			= "Banderas capturadas por la Horda: ",
	FlagBase			= "Base",
	Vulnerable1			= "¡Los portadores de las banderas se han vuelto vulnerables a los ataques!",
	Vulnerable2			= "¡Los portadores de las banderas se han vuelto más vulnerables a los ataques!"
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("z628")

L:SetWarningLocalization({
	WarnSiegeEngine		= "¡Máquina de asedio lista!",
	WarnSiegeEngineSoon	= "Máquina de asedio en ~10 s"
})

L:SetTimerLocalization({
	TimerPOI			= "%s",
	TimerSiegeEngine	= "Máquina de asedio lista"
})

L:SetOptionLocalization({
	TimerPOI			= "Mostrar temporizador de captura",
	TimerSiegeEngine	= "Mostrar temporizador para construcción de máquinas de asedio",
	WarnSiegeEngine		= "Mostrar aviso cuando una máquina de asedio esté lista",
	WarnSiegeEngineSoon	= "Mostrar aviso cuando una máquina de asedio esté casi lista",
	ShowGatesHealth		= "Mostrar salud de puertas dañadas (¡puede dar resultados erróneos al unirse a una batalla en curso!)"
})

L:SetMiscLocalization({
	GatesHealthFrame		= "Puertas dañadas",
	SiegeEngine				= "Máquina de asedio",
	GoblinStartAlliance		= "¿Ves esas bombas de seforio? Úsalas en las puertas mientras reparo la máquina de asedio.",
	GoblinStartHorde		= "Trabajaré en la máquina de asedio, solo cúbreme las espaldas. ¡Usa esas bombas de seforio en las puertas si las necesitas!",
	GoblinHalfwayAlliance	= "¡Ya casi estoy! Mantén a la Horda alejada. ¡No me enseñaron a luchar en la escuela de ingeniería!",
	GoblinHalfwayHorde		= "¡Ya casi estoy! Mantén a la Alianza alejada... ¡Luchar no entra en mi contrato!",
	GoblinFinishedAlliance	= "¡Mi mejor trabajo hasta ahora! ¡Esta máquina de asedio está lista para la acción!",
	GoblinFinishedHorde		= "¡La máquina de asedio está lista para la acción!",
	GoblinBrokenAlliance	= "¡¿Ya se ha roto?! No te preocupes. No es nada que no pueda arreglar.",
	GoblinBrokenHorde		= "¡¿Se ha vuelto a romper?1 Ya lo arreglo... Pero no esperes que esto lo cubra la garantía."
})

------------------
--  Twin Peaks  --
------------------
L = DBM:GetModLocalization("z726")

L:SetTimerLocalization({
	TimerStart	= "La batalla comienza",
	TimerFlag	= "Reaparición de banderas"
})

L:SetOptionLocalization({
	TimerStart					= "Mostrar temporizador de inicio",
	TimerFlag					= "Mostrar temporizador de reaparición de banderas",
	ShowFlagCarrier				= "Mostrar portadores de banderas",
	ShowFlagCarrierErrorNote	= "Mostrar mensaje de error de portador de bandera al estar en combate"
})

L:SetMiscLocalization({
	InfoErrorText		= "La función de selección de portador de bandera se restaurará cuando salgas de combate.",
	ExprFlagPickUp		= "¡(.+) ha cogido la bandera de la (%w+)!",
	ExprFlagCaptured	= "¡(.+) ha capturado la bandera de la (%w+)!",
	ExprFlagReturn		= "¡(.+) ha devuelto la bandera de la (%w+) a su base!",
	FlagAlliance		= "Banderas capturadas por la Alianza: ",
	FlagHorde			= "Banderas capturadas por la Horda: ",
	FlagBase			= "Base",
	Vulnerable1			= "¡Los portadores de las banderas se han vuelto vulnerables a los ataques!",
	Vulnerable2			= "¡Los portadores de las banderas se han vuelto más vulnerables a los ataques!"
})

------------------------------
--  The Battle for Gilneas  --
------------------------------
L = DBM:GetModLocalization("z761")

L:SetTimerLocalization({
	TimerCap	= "%s"
})

L:SetOptionLocalization({
	TimerWin					= "Mostrar temporizador de victoria",
	TimerCap					= "Mostrar temporizador de captura",
	ShowGilneasEstimatedPoints	= "Mostrar recursos restantes estimados para ganar/perder",
	ShowGilneasBasesToWin		= "Mostrar bases necesarias para ganar"
})

L:SetMiscLocalization({
	ScoreExpr	= "(%d+)/1500",
	WinBarText	= "La %s gana",
	BasesToWin	= "Bases para ganar: %d"
})

-------------------------
--  Silvershard Mines  --
-------------------------
L = DBM:GetModLocalization("z727")

L:SetTimerLocalization({
	TimerCart	= "Reaparición de vagoneta"
})

L:SetOptionLocalization({
	TimerCart	= "Mostrar temporizador de reaparición de vagoneta"
})

L:SetMiscLocalization({
	Capture	= "ha capturado"
})

-------------------------
--  Temple of Kotmogu  --
-------------------------
L = DBM:GetModLocalization("z998")

L:SetOptionLocalization({
	TimerWin					= "Mostrar temporizador de victoria",
	ShowKotmoguEstimatedPoints	= "Mostrar puntos restantes estimados para ganar/perder",
	ShowKotmoguOrbsToWin		= "Mostrar orbes necesarios para ganar"
})

L:SetMiscLocalization({
	OrbTaken	= "¡(%S+) se ha hecho con el orbe (%S+)!",
	OrbReturn	= "¡El orbe (%S+) ha sido devuelto!",
	ScoreExpr	= "(%d+)/1500",
	WinBarText	= "La %s gana",
	OrbsToWin	= "Orbes para ganar: %d"
})
