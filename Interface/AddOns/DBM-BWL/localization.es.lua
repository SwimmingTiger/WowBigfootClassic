if GetLocale() ~= "esES" then return end
local L

-----------------
--  Razorgore  --
-----------------
L = DBM:GetModLocalization("Razorgore")

L:SetGeneralLocalization{
	name = "Sangrevaja el Indomable"
}
L:SetTimerLocalization{
	TimerAddsSpawn	= "Primeros esbirros"
}
L:SetOptionLocalization{
	TimerAddsSpawn	= "Mostrar temporizador para cuando aparezcan los primeros esbirros"
}
L:SetMiscLocalization{
	Phase2Emote	= "huyen mientras se consume el poder del orbe.",
	YellEgg1	= "¡Pagarás por obligarme a hacer esto!",
	YellEgg2	= "¡Idiotas! ¡Esos huevos son más valiosos que los vuestros!",
	YellEgg3	= "¡No, otro no! ¡Haré que os corten la cabeza por esta atrocidad!",
	YellPull	= "¡Tenemos intrusos en El Criadero! ¡Haced sonar la alarma! ¡Proteged los huevos a toda costa!"
}
-------------------
--  Vaelastrasz  --
-------------------
L = DBM:GetModLocalization("Vaelastrasz")

L:SetGeneralLocalization{
	name				= "Vaelastrasz el Corrupto"
}

L:SetMiscLocalization{
	Event				= "¡Demasiado tarde, amigos! La corrupción de Nefarius me ha vencido... No... No puedo controlarme."
}
-----------------
--  Broodlord  --
-----------------
L = DBM:GetModLocalization("Broodlord")

L:SetGeneralLocalization{
	name	= "Señor de prole Capazote"
}

L:SetMiscLocalization{
	Pull	= "¡Ninguno de los vuestros debería estar aquí! ¡Os habéis condenado vosotros mismos!"
}

---------------
--  Firemaw  --
---------------
L = DBM:GetModLocalization("Firemaw")

L:SetGeneralLocalization{
	name = "Faucefogo"
}

---------------
--  Ebonroc  --
---------------
L = DBM:GetModLocalization("Ebonroc")

L:SetGeneralLocalization{
	name = "Ebanorroca"
}

----------------
--  Flamegor  --
----------------
L = DBM:GetModLocalization("Flamegor")

L:SetGeneralLocalization{
	name = "Flamagor"
}

-----------------------
--  Vulnerabilities  --
-----------------------
-- Chromaggus, Death Talon Overseer and Death Talon Wyrmguard
L = DBM:GetModLocalization("TalonGuards")

L:SetGeneralLocalization{
	name = "Guardias Garramortal"
}
L:SetWarningLocalization{
	WarnVulnerable		= "Vulnerabilidad: %s"
}
L:SetOptionLocalization{
	WarnVulnerable		= "Mostrar aviso de vulnerabilidades de hechizo"
}
L:SetMiscLocalization{
	Fire		= "Fuego",
	Nature		= "Naturaleza",
	Frost		= "Escarcha",
	Shadow		= "Sombras",
	Arcane		= "Arcano",
	Holy		= "Sagrado"
}

------------------
--  Chromaggus  --
------------------
L = DBM:GetModLocalization("Chromaggus")

L:SetGeneralLocalization{
	name = "Chromaggus"
}
L:SetWarningLocalization{
	WarnBreath		= "%s",
	WarnVulnerable	= "Vulnerabilidad: %s"
}
L:SetTimerLocalization{
	TimerBreathCD	= "%s TdR",
	TimerBreath		= "%s lanzamiento",
	TimerVulnCD		= "TdR de Vulnerabilidad"
}
L:SetOptionLocalization{
	WarnBreath		= "Mostrar aviso cuando Chromaggus lance uno de sus alientos",
	WarnVulnerable	= "Mostrar temporizador para el tiempo de reutilización de los alientos",
	TimerBreathCD	= "Mostrar TdR de aliento",
	TimerBreath		= "Mostrar lanzamiento de aliento",
	TimerVulnCD		= "Mostrar TdR de Vulnerabilidad"
}
L:SetMiscLocalization{
	Breath1	= "Primer aliento",
	Breath2	= "Segundo aliento",
	VulnEmote	= "%s se estremece mientras su piel empieza a brillar.",
	Vuln		= "Vulnerabilidad",
	Fire		= "Fuego",
	Nature		= "Naturaleza",
	Frost		= "Escarcha",
	Shadow		= "Sombras",
	Arcane		= "Arcano",
	Holy		= "Sagrado"
}

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-Classic")

L:SetGeneralLocalization{
	name = "Nefarian"
}
L:SetWarningLocalization{
	WarnAddsLeft		= "%d restante",
	WarnClassCall		= "Llamada de %s",
	specwarnClassCall	= "¡Llamada de tu clase!"
}
L:SetTimerLocalization{
	TimerClassCall		= "Llamada de %s termina"
}
L:SetOptionLocalization{
	TimerClassCall		= "Mostrar temporizador para la duración de las llamadas en cada clase",
	WarnAddsLeft		= "Anunciar muertes restante hasta Fase 2",
	WarnClassCall		= "Mostrar aviso para las llamadas de clase",
	specwarnClassCall	= "Mostrar aviso especial cuando se ve afectado por la llamada de clase"
}
L:SetMiscLocalization{
	YellP1		= "¡Que comiencen los juegos!",
	YellP2		= "Bien hecho, esbirros. La valentía de los mortales empieza a menguar. Ahora, ¡veamos cómo se enfrentan al verdadero Señor de la Cubre de Roca Negra!",
	YellP3		= "¡Imposible! ¡Levantaos, esbirros! ¡Servid a vuestro maestro una vez más!",
	YellShaman	= "¡Chamanes, mostradme lo que pueden hacer vuestros totems!",
	YellPaladin	= "Paladines... He oído que tenéis muchas vidas. Demostrádmelo.",
	YellDruid	= "Los druidas y vuestro estúpido poder de cambiar de forma. ¡Veámoslo en acción!",
	YellPriest	= "¡Sacerdotes! Si vais a seguir curando de esa forma, ¡podíamos hacerlo más interesante!",
	YellWarrior	= "¡Vamos guerreros, sé que podéis golpear más fuerte que eso! ¡Veámoslo!",
	YellRogue	= "¿Pícaros? ¡Dejad de esconderos y enfrentaos a mí!",
	YellWarlock	= "Brujos... No deberíais estar jugando con magia que no comprendéis. ¿Veis lo que pasa?",
	YellHunter	= "¡Cazadores y vuestras molestas cerbatanas!",
	YellMage	= "¿Magos también? Deberíais tener más cuidado cuando jugáis con la magia..."
--	YellDK		= "¡Caballeros de la Muerte... venid aquí!",
--	YellMonk	= "Monjes, ¿no os mareáis con tanta vuelta?",
--	YellDH		= "¿Cazadores de demonios? Qué raro eso de taparos los ojos así. ¿No os cuesta ver lo que tenéis alrededor?"--Demon Hunter call; I know this hasn't been implemented yet in DBM, but I added it just in case.
}
