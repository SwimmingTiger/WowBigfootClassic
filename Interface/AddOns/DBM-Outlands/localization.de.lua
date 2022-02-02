if GetLocale() ~= "deDE" then return end
local L

--Maulgar
L = DBM:GetModLocalization("Maulgar")

L:SetGeneralLocalization{
	name = "Hochkönig Maulgar"
}


--Gruul the Dragonkiller
L = DBM:GetModLocalization("Gruul")

L:SetGeneralLocalization{
	name = "Gruul der Drachenschlächter"
}

L:SetWarningLocalization{
	WarnGrowth	= "%s (%d)"
}

L:SetOptionLocalization{
	WarnGrowth	= "Zeige Warnung für $spell:36300"
}


-- Magtheridon
L = DBM:GetModLocalization("Magtheridon")

L:SetGeneralLocalization{
	name = "Magtheridon"
}

L:SetTimerLocalization{
	timerP2	= "Phase 2"
}

L:SetOptionLocalization{
	timerP2	= "Zeige Zeit bis Phase 2 beginnt"
}

L:SetMiscLocalization{
	DBM_MAG_EMOTE_PULL		= "Die Fesseln von %s werden schwächer!",
	DBM_MAG_YELL_PHASE2		= "Ich... bin... frei!",
	DBM_MAG_YELL_PHASE3		= "Ich lasse mich nicht so leicht bezwingen! Lasst die Mauern dieses Kerkers erzittern... und einstürzen!"
}

-- Doom Lord Kazzak
L = DBM:GetModLocalization("Kazzak")

L:SetGeneralLocalization{
	name = "Verdammnislord Kazzak"
}

L:SetMiscLocalization{
	DBM_KAZZAK_EMOTE_ENRAGE		= "%s wird wütend!" --guessed translation / currently unused (r335)
}

-- Doomwalker
L = DBM:GetModLocalization("Doomwalker")

L:SetGeneralLocalization{
	name = "Verdammniswandler"
}

L:SetMiscLocalization{
	DBM_DOOMW_EMOTE_ENRAGE	= "%s wird wütend!" --guessed translation / currently unused (r335)
}
