if GetLocale() ~= "koKR" then return end
local L

--Maulgar
L = DBM:GetModLocalization("Maulgar")

L:SetGeneralLocalization{
	name = "왕중왕 마울가르"
}


--Gruul the Dragonkiller
L = DBM:GetModLocalization("Gruul")

L:SetGeneralLocalization{
	name = "용 학살자 그룰"
}

L:SetOptionLocalization{
	WarnGrowth	= "$spell:36300 알림 보기"
}


-- Magtheridon
L = DBM:GetModLocalization("Magtheridon")

L:SetGeneralLocalization{
	name = "마그테리돈"
}

L:SetTimerLocalization{
	timerP2	= "2단계"
}

L:SetOptionLocalization{
	timerP2	= "2단계 시작 바 보기"
}

L:SetMiscLocalization{
	DBM_MAG_EMOTE_PULL		= "%s의 속박이 약해지기 시작합니다!",
	DBM_MAG_YELL_PHASE2		= "내가... 풀려났도다!",
	DBM_MAG_YELL_PHASE3		= "그렇게 쉽게"
}

-- Doom Lord Kazzak
L = DBM:GetModLocalization("Kazzak")

L:SetGeneralLocalization{
	name = "파멸의 군주 카자크"
}

L:SetMiscLocalization{
	DBM_KAZZAK_EMOTE_ENRAGE		= "%s|1이;가; 분노에 휩싸입니다!"--Probalby won't be used, at least not long. Once spellid replaces it
}

-- Doomwalker
L = DBM:GetModLocalization("Doomwalker")

L:SetGeneralLocalization{
	name = "파멸의 절단기"
}

L:SetMiscLocalization{
	DBM_DOOMW_EMOTE_ENRAGE	= "%s|1이;가; 분노에 휩싸입니다!"----Probalby won't be used, at least not long. Once spellid replaces it
}

-- Quest
L = DBM:GetModLocalization("Quest")

L:SetGeneralLocalization{
	name = "퀘스트",
}

L:SetOptionLocalization{
	Timers = "몇가지 호위 퀘스트의 타이머 바 보기"
}
