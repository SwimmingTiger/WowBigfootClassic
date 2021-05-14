if GetLocale() ~= "ruRU" then return end

local L

--Maulgar
L = DBM:GetModLocalization("Maulgar")

L:SetGeneralLocalization{
	name = "Король Молгар"
}


--Gruul the Dragonkiller
L = DBM:GetModLocalization("Gruul")

L:SetGeneralLocalization{
	name = "Груул Драконобой"
}

L:SetWarningLocalization{
	WarnGrowth	= "%s (%d)"
}

L:SetOptionLocalization{
	WarnGrowth	= "Show warning for $spell:36300"
}


-- Magtheridon
L = DBM:GetModLocalization("Magtheridon")

L:SetGeneralLocalization{
	name = "Магтеридон"
}

L:SetTimerLocalization{
	timerP2	= "Phase 2"
}

L:SetOptionLocalization{
	timerP2	= "Show timer for start of phase 2"
}

L:SetMiscLocalization{
	DBM_MAG_EMOTE_PULL		= "начинает ослабевать!",
	DBM_MAG_YELL_PHASE2		= "Я… освобожден!",
	DBM_MAG_YELL_PHASE3		= "I will not be taken so easily! Let the walls of this prison tremble... and fall!"
}

-- Doom Lord Kazzak
L = DBM:GetModLocalization("Kazzak")

L:SetGeneralLocalization{
	name = "Владыка Судеб Каззак"
}

L:SetMiscLocalization{
	DBM_KAZZAK_EMOTE_ENRAGE		= "%s becomes enraged!"--Probalby won't be used, at least not long. Once spellid replaces it
}

-- Doomwalker
L = DBM:GetModLocalization("Doomwalker")

L:SetGeneralLocalization{
	name = "Судьболом"
}

L:SetMiscLocalization{
	DBM_DOOMW_EMOTE_ENRAGE	= "%s becomes enraged!"--Probalby won't be used, at least not long. Once spellid replaces it
}
