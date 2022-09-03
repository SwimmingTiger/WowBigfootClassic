if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-------------------------------
-- Las bestias de Rasganorte --
-------------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Las bestias de Rasganorte"
}

L:SetWarningLocalization{
	WarningSnobold		= "Vasallo snóbold en >%s<"
}

L:SetTimerLocalization{
	TimerNextBoss		= "Siguiente jefe",
	TimerEmerge			= "Emersión",
	TimerSubmerge		= "Sumersión"
}

L:SetOptionLocalization{
	WarningSnobold		= "Mostrar aviso cuando aparezca un Vasallo snóbold",
	ClearIconsOnIceHowl	= "Quitar todos los iconos antes de cada carga",
	TimerNextBoss		= "Mostrar temporizador para el siguiente jefe",
	TimerEmerge			= "Mostrar temporizador para cuando Fauceácida y Aterraescama regresen a la superficie",
	TimerSubmerge		= "Mostrar temporizador para cuando Fauceácida y Aterraescama se sumerjan en la tierra",
	IcehowlArrow		= "Mostrar flecha cuando Aullahielo vaya a cargar hacia ti"
}

L:SetMiscLocalization{
	Charge		= "¡Aullahielo mira a (%S+) y emite un bramido!",
	CombatStart	= "Desde las cavernas más oscuras y profundas de Las Cumbres Tormentosas: ¡Gormok el Empalador! ¡A luchar, héroes!",
	Phase2		= "Preparaos, héroes, para los temibles gemelos: ¡Fauceácida y Aterraescama! ¡A la arena!",
	Phase3		= "El propio aire se congela al presentar a nuestro siguiente combatiente: ¡Aullahielo! ¡Matad o morid, campeones!",
	Gormok		= "Gormok el Empalador",
	Acidmaw		= "Fauceácida",
	Dreadscale	= "Aterraescama",
	Icehowl		= "Aullahielo"
}

-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "Lord Jaraxxus"
}

L:SetOptionLocalization{
	IncinerateShieldFrame		= "Mostrar salud del jefe en una barra de vida durante Incinerar carne"
}

L:SetMiscLocalization{
	IncinerateTarget	= "Incinerar carne: %s",
	FirstPull	= "El gran brujo Wilfred Chispobang invocará al siguiente contrincante. Esperad a que aparezca."
}

-----------------------------
-- Campeones de la facción --
-----------------------------
L = DBM:GetModLocalization("Champions")

local champions = "Campeones de la facción"
if UnitFactionGroup("player") == "Alliance" then
	champions = "Campeones de la Horda"
elseif UnitFactionGroup("player") == "Horde" then
	champions = "Campeones de la Alianza"
end

L:SetGeneralLocalization{
	name = champions
}

L:SetMiscLocalization{
	AllianceVictory    = "¡GLORIA A LA ALIANZA!",
	HordeVictory       = "Eso solo ha sido una muestra de lo que os depara el futuro. ¡POR LA HORDA!"
}

---------------------
-- Gemelas Val'kyr --
---------------------
L = DBM:GetModLocalization("ValkTwins")

L:SetGeneralLocalization{
	name = "Gemelas Val'kyr"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "Siguiente facultad especial"
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "Facultad especial en breve",
	SpecWarnSpecial				= "Cambia de color",
	SpecWarnSwitchTarget		= "Cambia de objetivo",
	SpecWarnKickNow				= "Interrumpe ahora",
	WarningTouchDebuff			= "Perjuicio en >%s<",
	WarningPoweroftheTwins2		= "Poder de las Gemelas - ¡más sanación en >%s<!",
	SpecWarnPoweroftheTwins		= "Poder de las Gemelas"
}

L:SetMiscLocalization{
	Fjola		= "Fjola Penívea",
	Eydis		= "Eydis Penaumbra"
}

L:SetOptionLocalization{
	TimerSpecialSpell			= "Mostrar temporizador para la siguiente facultad especial",
	WarnSpecialSpellSoon		= "Mostrar aviso previo para la siguiente facultad especial",
	SpecWarnSpecial				= "Mostrar aviso especial cuando debas cambiar de color",
	SpecWarnSwitchTarget		= "Mostrar aviso especial cuando la otra gemela esté lanzando un hechizo",
	SpecWarnKickNow				= "Mostrar aviso especial cuando debas interrumpir",
	SpecialWarnOnDebuff			= "Mostrar aviso especial cuando estés afectado por un perjuicio (para cambiarlo por otro)",
	SetIconOnDebuffTarget		= "Poner iconos en los objetivos de los perjuicios de $spell:65950 y $spell:66001 (dificultad heroica)",
	WarningTouchDebuff			= "Anunciar objetivos de los perjuicios de $spell:65950 y $spell:66001",
	WarningPoweroftheTwins2		= "Anunciar la gemela afectada por $spell:65916",
	SpecWarnPoweroftheTwins		= "Mostrar aviso especial cuando estés tanqueando una gemela afectada por $spell:65916"
}

---------------
-- Anub'arak --
---------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 					= "Anub'arak"
}

L:SetTimerLocalization{
	TimerEmerge				= "Emersión",
	TimerSubmerge			= "Sumersión",
	timerAdds				= "Siguientes esbirros"
}

L:SetWarningLocalization{
	WarnEmerge				= "Anub'arak regresa a la superficie",
	WarnEmergeSoon			= "Emersión en 10 s",
	WarnSubmerge			= "Anub'arak se entierra en el suelo",
	WarnSubmergeSoon		= "Sumersión en 10 s",
	specWarnSubmergeSoon	= "¡Sumersión en 10 s!",
	warnAdds				= "Siguientes esbirros"
}

L:SetMiscLocalization{
	Emerge				= "emerge de la tierra!",
	Burrow				= "se entierra en el suelo!",
	PcoldIconSet		= "Icono {rt%d} colocado en %s",
	PcoldIconRemoved	= "Icono quitado en %s"
}

L:SetOptionLocalization{
	WarnEmerge				= "Mostrar aviso cuando Anub'arak regrese a la superficie",
	WarnEmergeSoon			= "Mostrar aviso previo para cuando Anub'arak regrese a la superficie",
	WarnSubmerge			= "Mostrar aviso cuando Anub'arak se entierre en el suelo",
	WarnSubmergeSoon		= "Mostrar aviso previo para cuando Anub'arak se entierre en el suelo",
	specWarnSubmergeSoon	= "Mostrar aviso especial cuando falte poco para que Anub'arak se entierre en el suelo",
	warnAdds				= "Anunciar cuando aparezcan esbirros",
	timerAdds				= "Mostrar temporizador para los siguientes esbirros",
	TimerEmerge				= "Mostrar temporizador para cuando Anub'arak regrese a la superficie",
	TimerSubmerge			= "Mostrar temporizador para cuando Anub'arak se entierre en el suelo",
	AnnouncePColdIcons		= "Anunciar iconos de los objetivos de $spell:66013 en el chat de banda (requiere líder o ayudante)",
	AnnouncePColdIconsRemoved	= "Anunciar iconos quitados de los objetivos de $spell:66013 (requiere que la opción anterior esté habilitada)"
}

