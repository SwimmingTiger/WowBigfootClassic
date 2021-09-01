if GetLocale() ~= "esMX" then return end
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
	YellEgg1	= "¡Pagarán por obligarme a hacer esto!",
	YellEgg2	= "¡Locos! ¡Esos huevos son más valiosos de lo que creen!",
	YellEgg3	= "¡No, otro no! ¡Rodarán sus cabezas por esta infamia!",
	YellPull	= "¡Los invasores han penetrado en El Criadero! ¡Activa la alarma! ¡Hay que proteger los huevos a toda costa!"
}
-------------------
--  Vaelastrasz  --
-------------------
L = DBM:GetModLocalization("Vaelastrasz")

L:SetGeneralLocalization{
	name				= "Vaelastrasz el Corrupto"
}

L:SetMiscLocalization{
	Event				= "¡Demasiado tarde, amigos! Ahora estoy poseído por la corrupción de Nefarius... No puedo... controlarme."
}
-----------------
--  Broodlord  --
-----------------
L = DBM:GetModLocalization("Broodlord")

L:SetGeneralLocalization{
	name	= "Señor de linaje Capazote"
}

L:SetMiscLocalization{
	Pull	= "¡Nadie de su raza debería estar aquí! ¡Están condenados!"
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
	YellP2		= "Bien hecho, mis esbirros. El coraje de los mortales empieza a mermar. ¡Veamos ahora cómo se enfrentan al verdadero Señor de la Cubre de Roca Negra!",
	YellP3		= "¡Imposible! ¡Levántense, mis esbirros! ¡Sirvan a su amo una vez más!",
	YellShaman	= "¡Chamanes, muéstrenme lo que pueden hacer sus tótems!",
	YellPaladin	= "Paladines... He oído que tienen muchas vidas. Demuéstrenmelo.",
	YellDruid	= "Los druidas y su estúpido poder de cambiar de forma. ¡Veámoslo en acción!",
	YellPriest	= "¡Sacerdotes! Si van a seguir curando de esa forma, ¡podíamos hacerlo más interesante!",
	YellWarrior	= "¡Vamos guerreros, sé que pueden golpear más fuerte que eso! ¡Veámoslo!",
	YellRogue	= "¿Pícaros? ¡Dejen de esconderse y enfréntense a mí!",
	YellWarlock	= "Brujos... No deberían estar jugando con magia que no comprenden. ¿Ven lo que pasa?",
	YellHunter	= "¡Cazadores y sus molestas cerbatanas!",
	YellMage	= "¿Magos también? Deberían tener más cuidado cuando juegan con la magia...",
--	YellDK		= "¡Caballeros de la Muerte... venid aquí!",
--	YellMonk	= "Monjes, ¿no os mareáis con tanta vuelta?",
--	YellDH		= "¿Cazadores de demonios? Qué raro eso de taparos los ojos así. ¿No os cuesta ver lo que tenéis alrededor?"--Demon Hunter call; I know this hasn't been implemented yet in DBM, but I added it just in case.
}
