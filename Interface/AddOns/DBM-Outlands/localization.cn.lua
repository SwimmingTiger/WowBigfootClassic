if GetLocale() ~= "zhCN" then return end

local L

--Maulgar
L = DBM:GetModLocalization("Maulgar")

L:SetGeneralLocalization{
	name = "莫加尔大王"
}


--Gruul the Dragonkiller
L = DBM:GetModLocalization("Gruul")

L:SetGeneralLocalization{
	name = "屠龙者格鲁尔"
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
	name = "玛瑟里顿"
}

L:SetTimerLocalization{
	timerP2	= "Phase 2"
}

L:SetOptionLocalization{
	timerP2	= "Show timer for start of phase 2"
}

L:SetMiscLocalization{
	DBM_MAG_EMOTE_PULL		= "%s的禁锢开始变弱！",
	DBM_MAG_YELL_PHASE2		= "我……自由了！",
	DBM_MAG_YELL_PHASE3		= "I will not be taken so easily! Let the walls of this prison tremble... and fall!"
}

-- Doom Lord Kazzak
L = DBM:GetModLocalization("Kazzak")

L:SetGeneralLocalization{
	name = "末日领主卡扎克"
}

L:SetMiscLocalization{
	DBM_KAZZAK_EMOTE_ENRAGE		= "%s becomes enraged!"--Probalby won't be used, at least not long. Once spellid replaces it
}

-- Doomwalker
L = DBM:GetModLocalization("Doomwalker")

L:SetGeneralLocalization{
	name = "末日行者"
}

L:SetMiscLocalization{
	DBM_DOOMW_EMOTE_ENRAGE	= "%s becomes enraged!"--Probalby won't be used, at least not long. Once spellid replaces it
}
