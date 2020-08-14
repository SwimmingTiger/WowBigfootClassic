if GetLocale() ~= "ptBR" then return end
local L

---------------
-- Kurinnaxx --
---------------
L = DBM:GetModLocalization("Kurinnaxx")

L:SetGeneralLocalization{
	name 		= "Korinnaxx"
}
------------
-- Rajaxx --
------------
L = DBM:GetModLocalization("Rajaxx")

L:SetGeneralLocalization{
	name 		= "General Rajaxx"
}
L:SetWarningLocalization{
	WarnWave	= "Onda %s"
}
L:SetOptionLocalization{
	WarnWave	= "Anunciar a próxima onda de entrada"
}
L:SetMiscLocalization{
	Wave12		= "They come now. Try not to get yourself killed, young blood.",
	Wave12Alt	= "Remember, Rajaxx, when I said I'd kill you last?",
	Wave3		= "The time of our retribution is at hand! Let darkness reign in the hearts of our enemies!",
	Wave4		= "No longer will we wait behind barred doors and walls of stone! No longer will our vengeance be denied! The dragons themselves will tremble before our wrath!",
	Wave5		= "Fear is for the enemy! Fear and death!",
	Wave6		= "Staghelm will whimper and beg for his life, just as his whelp of a son did! One thousand years of injustice will end this day!",
	Wave7		= "Fandral! Your time has come! Go and hide in the Emerald Dream and pray we never find you!",
	Wave8		= "Impudent fool! I will kill you myself!"
}

----------
-- Moam --
----------
L = DBM:GetModLocalization("Moam")

L:SetGeneralLocalization{
	name 		= "Moam"
}

----------
-- Buru --
----------
L = DBM:GetModLocalization("Buru")

L:SetGeneralLocalization{
	name 		= "Buru, o Banqueteador"
}
L:SetWarningLocalization{
	WarnPursue		= "Perseguir em >%s<",
	SpecWarnPursue	= "Perseguindo você",
	WarnDismember	= "%s em >%s< (%s)"
}
L:SetOptionLocalization{
	WarnPursue		= "Anunciar alvos perseguidos",
	SpecWarnPursue	= "Exibir aviso especial quando estiver sendo perseguido",
	WarnDismember	= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format(96)
}
L:SetMiscLocalization{
	PursueEmote 	= "%s sets eyes on %s!"
}

-------------
-- Ayamiss --
-------------
L = DBM:GetModLocalization("Ayamiss")

L:SetGeneralLocalization{
	name 		= "Ayamiss, o Caçador"
}

--------------
-- Ossirian --
--------------
L = DBM:GetModLocalization("Ossirian")

L:SetGeneralLocalization{
	name 		= "Ossirian, o Intocado"
}
L:SetWarningLocalization{
	WarnVulnerable	= "%s"
}
L:SetTimerLocalization{
	TimerVulnerable	= "%s"
}
L:SetOptionLocalization{
	WarnVulnerable	= "Anunciar fraqueza",
	TimerVulnerable	= "Exibir cronômetro para fraqueza"
}

----------------
-- AQ20 Trash --
----------------
L = DBM:GetModLocalization("AQ20Trash")

L:SetGeneralLocalization{
	name = "AQ20: Lixo"
}
