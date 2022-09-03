if GetLocale() ~= "frFR" then return end
local L

------------------------
--  Rage Winterchill  --
------------------------
L = DBM:GetModLocalization("Rage")

L:SetGeneralLocalization{
	name = "Rage Froidhiver"
}

-----------------
--  Anetheron  --
-----------------
L = DBM:GetModLocalization("Anetheron")

L:SetGeneralLocalization{
	name = "Anetheron"
}

----------------
--  Kazrogal  --
----------------
L = DBM:GetModLocalization("Kazrogal")

L:SetGeneralLocalization{
	name = "Kaz'rogal"
}

---------------
--  Azgalor  --
---------------
L = DBM:GetModLocalization("Azgalor")

L:SetGeneralLocalization{
	name = "Azgalor"
}

------------------
--  Archimonde  --
------------------
L = DBM:GetModLocalization("Archimonde")

L:SetGeneralLocalization{
	name = "Archimonde"
}

----------------
-- WaveTimers --
----------------
L = DBM:GetModLocalization("HyjalWaveTimers")

L:SetGeneralLocalization{
	name 		= "Vagues"
}
L:SetWarningLocalization{
	WarnWave	= "%s",
}
L:SetTimerLocalization{
	TimerWave	= "Prochaine vague"
}
L:SetOptionLocalization{
	WarnWave		= "Avertit quand une nouvelle vague arrive",
	DetailedWave	= "Avertissement détaillé quand une nouvelle vague arrive (quels mobs)",
	TimerWave		= "Affiche un compteur pour la prochaine vague"
}
L:SetMiscLocalization{
	HyjalZoneName	= "Le Sommet d'Hyjal",
	Thrall			= "Thrall",
	Jaina			= "Dame Jaina Portvaillant",
	GeneralBoss		= "Arrivée d'un boss'",
	RageWinterchill	= "Arrivée de Rage Froidhiver",
	Anetheron		= "Arrivée d'Anetheron",
	Kazrogal		= "Arrivée de Kazrogal",
	Azgalor			= "Arrivée d'Azgalor",
	WarnWave_0		= "Vague %s/8",
	WarnWave_1		= "Vague %s/8 - %s %s",
	WarnWave_2		= "Vague %s/8 - %s %s et %s %s",
	WarnWave_3		= "Vague %s/8 - %s %s, %s %s et %s %s",
	WarnWave_4		= "Vague %s/8 - %s %s, %s %s, %s %s et %s %s",
	WarnWave_5		= "Vague %s/8 - %s %s, %s %s, %s %s, %s %s et %s %s",
	RageGossip		= "Mes compagnons et moi sommes à vos côtés, dame Portvaillant.",
	AnetheronGossip	= "Nous sommes prêts à affronter tout ce qu'Archimonde pourra mettre sur notre chemin, dame Portvaillant.",
	KazrogalGossip	= "Je suis avec vous, Thrall.",
	AzgalorGossip	= "Nous n'avons rien à craindre.'",
	Ghoul			= "Goules",
	Abomination		= "Abominations",
	Necromancer		= "Nécromanciens",
	Banshee			= "Banshees",
	Fiend			= "Démons des cryptes",
	Gargoyle		= "Gargouilles",
	Wyrm			= "Wyrm de glace",
	Stalker			= "Traqueurs gangrenés",
	Infernal		= "Infernaux"
}
