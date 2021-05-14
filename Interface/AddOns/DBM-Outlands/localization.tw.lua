if GetLocale() ~= "zhTW" then return end

local L

--Maulgar
L = DBM:GetModLocalization("Maulgar")

L:SetGeneralLocalization{
	name = "大君王莫卡爾"
}


--Gruul the Dragonkiller
L = DBM:GetModLocalization("Gruul")

L:SetGeneralLocalization{
	name = "弒龍者戈魯爾"
}

L:SetWarningLocalization{
	WarnGrowth	= "%s (%d)"
}

L:SetOptionLocalization{
	WarnGrowth	= "為$spell:36300顯示警告"
}


-- Magtheridon
L = DBM:GetModLocalization("Magtheridon")

L:SetGeneralLocalization{
	name = "瑪瑟里頓"
}

L:SetTimerLocalization{
	timerP2	= "第2階段"
}

L:SetOptionLocalization{
	timerP2	= "為第2階段開始顯示計時器"
}

L:SetMiscLocalization{
	DBM_MAG_EMOTE_PULL		= "%s的束縛開始變弱!",
	DBM_MAG_YELL_PHASE2		= "我...被...釋放了!",
	DBM_MAG_YELL_PHASE3		= "我不會這麼輕易就被擊敗!讓這座監獄的牆壁震顫...然後崩塌!"
}

-- Doom Lord Kazzak
L = DBM:GetModLocalization("Kazzak")

L:SetGeneralLocalization{
	name = "毀滅領主卡札克"
}

L:SetMiscLocalization{
	DBM_KAZZAK_EMOTE_ENRAGE		= "%s becomes enraged!"
}

-- Doomwalker
L = DBM:GetModLocalization("Doomwalker")

L:SetGeneralLocalization{
	name = "厄運行者"
}

L:SetMiscLocalization{
	DBM_DOOMW_EMOTE_ENRAGE	= "%s becomes enraged!"
}
