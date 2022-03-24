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
	timerP2	= "2 阶段"
}

L:SetOptionLocalization{
	timerP2	= "显示2阶段计时器"
}

L:SetMiscLocalization{
	DBM_MAG_EMOTE_PULL		= "%s的禁锢开始变弱！",
	DBM_MAG_YELL_PHASE2		= "我……自由了！",
	DBM_MAG_YELL_PHASE3		= "我是不会轻易倒下的！让这座牢狱的墙壁颤抖并崩塌吧！"
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
