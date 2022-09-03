if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

------------------
-- Lord Tuétano --
------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Lord Tuétano"
}

L:SetOptionLocalization{
	SetIconOnImpale		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(69062)
}

------------------------
-- Lady Susurramuerte --
------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "Lady Susurramuerte"
}

L:SetTimerLocalization{
	TimerAdds	= "Siguientes esbirros"
}

L:SetWarningLocalization{
	WarnReanimating				= "Esbirro reanimado",			-- Reanimating an adherent or fanatic
	WarnAddsSoon				= "Esbirros en breve"
}

L:SetOptionLocalization{
	WarnAddsSoon				= "Mostrar aviso previo para cuando aparezcan esbirros",
	WarnReanimating				= "Mostrar aviso cuando se esté reanimando a un esbirro",	-- Reanimated Adherent/Fanatic spawning
	TimerAdds					= "Mostrar temporizador para los siguientes esbirros",
	SetIconOnDominateMind		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(71289),
	SetIconOnDeformedFanatic	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(70900),
	SetIconOnEmpoweredAdherent	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(70901)
}

L:SetMiscLocalization{
	YellReanimatedFanatic	= "¡Álzate y goza de tu verdadera forma!",
	Fanatic1				= "Fanático del Culto",
	Fanatic2				= "Fanático deformado",
	Fanatic3				= "Fanático reanimado"
}

--------------------------------
-- Batalla de naves de guerra --
--------------------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "Batalla de naves de guerra"
}

L:SetWarningLocalization{
	WarnAddsSoon	= "Esbirros en breve"
}

L:SetOptionLocalization{
	WarnAddsSoon		= "Mostrar aviso previo para cuando aparezcan esbirros",
	TimerAdds			= "Mostrar temporizador para los siguientes esbirros"
}

L:SetTimerLocalization{
	TimerAdds			= "Siguientes esbirros"
}

L:SetMiscLocalization{
	PullAlliance	= "¡Arrancad motores! ¡Tenemos una cita con el destino, muchachos!",
	PullHorde		= "¡Alzaos, hijos e hijas de la Horda! ¡Hoy nos enfrentamos a un odiado enemigo de la Horda! ¡LOK'TAR OGAR!",
	AddsAlliance	= "¡Atracadores, sargentos, atacad!",
	AddsHorde		= "¡Soldados, sargentos, atacad!",
	MageAlliance	= "Nos están dañando el casco, ¡traed un mago de batalla aquí para acabar con esos cañones!",
	MageHorde		= "Nos están dañando el casco, ¡traed un brujo aquí para acabar con esos cañones!",
	Hammer 			= "Martillo de Orgrim",
	Skybreaker		= "El Rompecielos"
}

------------------------------
-- Libramorte Colmillosauro --
------------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Libramorte Colmillosauro"
}

L:SetOptionLocalization{
	BoilingBloodIcons		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(72385),
	RangeFrame				= "Mostrar marco de distancia (12 m)",
	RunePowerFrame			= "Mostrar marco de salud del jefe y $spell:72371"
}

L:SetMiscLocalization{
	PullAlliance		= "Por cada soldado de la Horda que matasteis... Por cada perro de la Alianza que cayó, el ejército del Rey Exánime creció. Ahora, hasta las Val'kyr alzan a los caídos para la Plaga.",
	PullHorde			= "¡Kor'kron, vámonos! Campeones, vigilad vuestra retaguardia. La Plaga ha sido..."
}

------------------
-- Panzachancro --
------------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "Panzachancro"
}

L:SetOptionLocalization{
	RangeFrame			= "Mostrar marco de distancia (8 m)",
	SetIconOnGasSpore	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(69279),
	AnnounceSporeIcons	= "Anunciar iconos de los objetivos de $spell:69279 en el chat de banda (requiere líder o ayudante)",
	AchievementCheck	= "Anunciar si se falla el logro 'Sin vacunas' en el chat de banda (requiere líder o ayudante)"
}

L:SetMiscLocalization{
	SporeSet			= "Icono {rt%d} de Espora de gas en %s",
	AchievementFailed	= ">> LOGRO FALLADO: %s tiene %d acumulaciones de Inoculado <<"
}

----------------
-- Carapútrea --
----------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "Carapútrea"
}

L:SetWarningLocalization{
	WarnOozeSpawn				= "Moco pequeño",
	SpecWarnLittleOoze			= "Te está atacando un Moco pequeño - ¡huye!"--creatureid 36897
}

L:SetOptionLocalization{
	WarnOozeSpawn				= "Mostrar aviso cuando aparezca un Moco pequeño",
	SpecWarnLittleOoze			= "Mostrar aviso especial cuando te ataque un Moco pequeño",--creatureid 36897
	RangeFrame					= "Mostrar marco de distancia (8 m)",
	InfectionIcon				= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(69674)
}

L:SetMiscLocalization{
	YellSlimePipes1	= "¡Buenas noticias, amigos! He arreglado las tuberías de babosas venenosas.",	-- Professor Putricide
	YellSlimePipes2	= "¡Grandes noticias, amigos! Las babosas vuelven a fluir."	-- Professor Putricide
}

-------------------------
-- Profesor Putricidio --
-------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "Profesor Putricidio"
}

L:SetOptionLocalization{
	OozeAdhesiveIcon			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(70447),
	GaseousBloatIcon			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(70672),
	UnboundPlagueIcon			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(70911),
	MalleableGooIcon			= "Poner icono en el primer objetivo de $spell:72295"
}

------------------------------------
-- Consejo de Príncipes de Sangre --
------------------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "Consejo de Príncipes de Sangre"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "Cambio de objetivo: %s",
	WarnTargetSwitchSoon	= "Cambio de objetivo en breve"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "Cambio de objetivo"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Mostrar aviso cuando haya que cambiar de objetivo",-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "Mostrar aviso previo para cuando haya que cambiar de objetivo",-- Every ~47 secs, you have to dps a different Prince
	TimerTargetSwitch		= "Mostrar temporizador para el siguiente cambio de objetivo",
	EmpoweredFlameIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(72040),
	ActivePrinceIcon		= "Poner icono (calavera) en el príncipe potenciado",
	RangeFrame				= "Mostrar marco de distancia (12 m)"
}

L:SetMiscLocalization{
	Keleseth			= "Príncipe Keleseth",
	Taldaram			= "Príncipe Taldaram",
	Valanar				= "Príncipe Valanar",
	EmpoweredFlames		= "¡Llamas potenciadas arremeten contra (%S+)!"
}

-------------------------------
-- Reina de Sangre Lana'thel --
-------------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "Reina de Sangre Lana'thel"
}

L:SetOptionLocalization{
	SetIconOnDarkFallen		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(71340),
	SwarmingShadowsIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(71266),
	BloodMirrorIcon			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(70838),
	RangeFrame				= "Mostrar marco de distancia (8 m)"
}

L:SetMiscLocalization{
	SwarmingShadows			= "¡Las sombras se acumulan alrededor de (%S+)!",
	YellFrenzy				= "¡Tengo hambre!"
}

----------------------------
-- Valithria Caminasueños --
----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "Valithria Caminasueños"
}

L:SetWarningLocalization{
	WarnPortalOpen	= "Siguientes portales"
}

L:SetTimerLocalization{
	TimerPortalsOpen		= "Portales abiertos",
	TimerPortalsClose		= "Portales cerrados",
	TimerBlazingSkeleton	= "Siguiente Esqueleto llameante",
	TimerAbom				= "Siguiente Abominación glotona"
}

L:SetOptionLocalization{
	SetIconOnBlazingSkeleton	= "Poner icono (calavera) en Esqueleto llameante",
	WarnPortalOpen				= "Mostrar aviso cuando se abran los portales",
	TimerPortalsOpen			= "Mostrar temporizador para cuando se abran los portales",
	TimerPortalsClose			= "Mostrar temporizador para cuando se cierren los portales",
	TimerBlazingSkeleton		= "Mostrar temporizador para el siguiente Esqueleto llameante",
	TimerAbom					= "Mostrar temporizador para la siguiente Abominación glotona"
}

L:SetMiscLocalization{
	YellPortals		= "He abierto un portal al Sueño. Vuestra salvación está dentro, héroes..."
}

----------------
-- Sindragosa --
----------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "Sindragosa"
}

L:SetWarningLocalization{
	WarnAirphase			= "Fase aérea",
	WarnGroundphaseSoon		= "Fase en tierra en breve"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "Siguiente fase aérea",
	TimerNextGroundphase	= "Siguiente fase en tierra",
	AchievementMystic		= "Logro: Sacúdete"
}

L:SetOptionLocalization{
	WarnAirphase			= "Anunciar cambio a fase aérea",
	WarnGroundphaseSoon		= "Mostrar aviso previo para el cambio a fase en tierra",
	TimerNextAirphase		= "Mostrar temporizador para la siguiente fase aérea",
	TimerNextGroundphase	= "Mostrar temporizador para la siguiente fase en tierra",
	AnnounceFrostBeaconIcons= "Anunciar iconos de los objetivos de $spell:70126 en el chat de banda (requiere líder)",
	SetIconOnFrostBeacon	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(70126),
	SetIconOnUnchainedMagic	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(69762),
	ClearIconsOnAirphase	= "Quitar todos los iconos al comenzar la fase aérea",
	AchievementCheck		= "Anunciar avisos del logro 'Sacúdete' en el chat de banda (requiere líder o ayudante)",
	RangeFrame				= "Mostrar marco de distancia (10/20 m) dinámico en función de la última habilidad usada por el jefe y los perjuicios de los jugadores"
}

L:SetMiscLocalization{
	YellAirphase	= "¡Aquí termina vuestra incursión! ¡Nadie sobrevivirá!",
	YellPhase2		= "¡Ahora sentid el poder sin fin de mi maestro y desesperad!",
	YellAirphaseDem		= "Rikk zilthuras rikk zila Aman adare tiriosh ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	YellPhase2Dem		= "Zar kiel xi romathIs zilthuras revos ruk toralar ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	BeaconIconSet		= "Icono {rt%d} de Señal de Escarcha en %s",
	AchievementWarning	= "Aviso: %s tiene 5 acumulaciones de Sacudida mística",
	AchievementFailed	= ">> LOGRO FALLADO: %s tiene %d acumulaciones de Sacudida mística <<"
}

--------------------
-- El Rey Exánime --
--------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "El Rey Exánime"
}

L:SetWarningLocalization{
	ValkyrWarning			= "¡>%s< ha sido agarrado!",
	SpecWarnYouAreValkd		= "¡Te han agarrado!!",
	WarnNecroticPlagueJump	= "Plaga necrótica salta a >%s<",
	SpecWarnValkyrLow		= "Val'kyr por debajo del 55%"
}

L:SetTimerLocalization{
	TimerRoleplay		= "Diálogo",
	PhaseTransition		= "Intermedio",
	TimerNecroticPlagueCleanse = "Purgar Plaga necrótica"
}

L:SetOptionLocalization{
	TimerRoleplay			= "Mostrar temporizador para los diálogos",
	WarnNecroticPlagueJump	= "Anunciar objetivos de los saltos de $spell:70337",
	TimerNecroticPlagueCleanse	= "Mostrar temporizador para purgar Plaga necrótica antes del primer pulso",
	PhaseTransition			= "Mostrar duración de los intermedios",
	ValkyrWarning			= "Anunciar jugadores agarrados por las Guardias de las Sombras Val'kyr",
	SpecWarnYouAreValkd		= "Mostrar aviso especial cuando te agarrae una Guardia de las Sombras Val'kyr",--npc36609
	DefileIcon				= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(72762),
	NecroticPlagueIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(70337),
	RagingSpiritIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(69200),
	TrapIcon				= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(73539),
	HarvestSoulIcon			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(68980),
	AnnounceValkGrabs		= "Anunciar jugadores agarrados por las Guardias de las Sombras Val'kyr en el chat de banda (requiere líder o ayudante)",
	SpecWarnValkyrLow		= "Mostrar aviso especial cuando una Guardia de las Sombras Val'kyr esté por debajo del 55% de salud",
	AnnouncePlagueStack		= "Anunciar acumulaciones de $spell:70337 en el chat de banda (al llegar a 10 y tras cada 5; requiere líder o ayudante)"
}

L:SetMiscLocalization{
	LKPull					= "¿Así que por fin ha llegado la elogiada justicia de la Luz? ¿Debería deponer la Agonía de Escarcha y confiar en tu piedad, Vadín?",
	LKRoleplay				= "¿Me pregunto si de verdad os mueve la... rectitud?",
	ValkGrabbedIcon			= "Una Val'kyr ha agarrado a %s {rt%d}",
	ValkGrabbed				= "Una Val'kyr ha agarrado a %s",
	PlagueStackWarning		= "Aviso: %s tiene %d acumulaciones de Peste necrótica",
	AchievementCompleted	= ">> LOGRO COMPLETADO: %s tiene %d acumulaciones de Plaga necrótica <<"
}

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("ICCTrash")

L:SetGeneralLocalization{
	name = "Enemigos menores"
}

L:SetWarningLocalization{
	SpecWarnTrapL		= "Trampa activada - ¡se ha liberado un Depositario vinculado a la muerte!",
	SpecWarnTrapP		= "Trampa activada - ¡se aproximan Siegacarnes vengativos!",
	SpecWarnGosaEvent	= "¡Emboscada de Sindragosa iniciada!"
}

L:SetOptionLocalization{
	SpecWarnTrapL		= "Mostrar aviso especial cuando se active una trampa de Depositario vinculado a la muerte",
	SpecWarnTrapP		= "Mostrar aviso especial cuando se active una trampa de Siegacarnes vengativos",
	SpecWarnGosaEvent	= "Mostrar aviso especial cuando comience el evento de la emboscada de Sindragosa"
}

L:SetMiscLocalization{
	WarderTrap1			= "¿Quién... anda ahí?",
	WarderTrap2			= "Estoy despierto...",
	WarderTrap3			= "El sagrario del maestro ha sido perturbado.",
	FleshreaperTrap1	= "Rápido, ¡atacaremos por la espalda!",
	FleshreaperTrap2	= "¡No... puedes escapar!",
	FleshreaperTrap3	= "¿Los vivos? ¿¡Aquí!?",
	SindragosaEvent		= "No debéis acercaros a la Reina de Escarcha. ¡Detenedlos, rápido!"
}
