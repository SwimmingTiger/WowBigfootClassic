if GetLocale() ~= "koKR" then return end
local L

---------------------------
--  Hydross the Unstable --
---------------------------
L = DBM:GetModLocalization("Hydross")

L:SetGeneralLocalization{
	name = "불안정한 히드로스"
}

L:SetWarningLocalization{
	WarnMark 		= "%s : %s",
	WarnPhase		= "%s 단계",
	SpecWarnMark	= "%s : %s"
}

L:SetTimerLocalization{
	TimerMark	= "다음 %s : %s"
}

L:SetOptionLocalization{
	WarnMark		= "징표 알림 보기",
	WarnPhase		= "단계 전환 알림 보기",
	SpecWarnMark	= "징표 피해가 100%를 넘을 경우 특수 경고 보기",
	TimerMark		= "다음 징표 바 보기"
}

L:SetMiscLocalization{
	Frost	= "냉기",
	Nature	= "자연"
}

-----------------------
--  The Lurker Below --
-----------------------
L = DBM:GetModLocalization("LurkerBelow")

L:SetGeneralLocalization{
	name = "심연의 잠복꾼"
}

L:SetWarningLocalization{
	WarnSubmerge		= "잠수",
	WarnEmerge			= "재등장"
}

L:SetTimerLocalization{
	TimerSubmerge		= "잠수",
	TimerEmerge			= "재등장"
}

L:SetOptionLocalization{
	WarnSubmerge		= "잠수 알림 보기",
	WarnEmerge			= "재등장 알림 보기",
	TimerSubmerge		= "다음 잠수 바 보기",
	TimerEmerge			= "다음 재등장 바 보기"
}

--------------------------
--  Leotheras the Blind --
--------------------------
L = DBM:GetModLocalization("Leotheras")

L:SetGeneralLocalization{
	name = "눈먼 레오테라스"
}

L:SetWarningLocalization{
	WarnPhase		= "%s 단계"
}

L:SetTimerLocalization{
	TimerPhase	= "다음 %s 단계"
}

L:SetOptionLocalization{
	WarnPhase		= "단계 전환 알림 보기",
	TimerPhase		= "다음 단계 바 보기"
}

L:SetMiscLocalization{
	Human		= "인간",
	Demon		= "악마",
	YellDemon	= "꺼져라, 엘프 꼬맹이. 지금부터는 내가 주인이다!",
	YellPhase2	= "안 돼... 안 돼! 무슨 짓이냐? 내가 주인이야! 내 말 듣지 못해? 나란 말이야! 내가... 으아악! 놈을 억누를 수... 없...어."
}

-----------------------------
--  Fathom-Lord Karathress --
-----------------------------
L = DBM:GetModLocalization("Fathomlord")

L:SetGeneralLocalization{
	name = "심해군주 카라드레스"
}

L:SetMiscLocalization{
	Caribdis	= "심연의 경비병 카리브디스",
	Tidalvess	= "심연의 경비병 타이달베스",
	Sharkkis	= "심연의 경비병 샤르키스"
}

--------------------------
--  Morogrim Tidewalker --
--------------------------
L = DBM:GetModLocalization("Tidewalker")

L:SetGeneralLocalization{
	name = "겅둥파도 모로그림"
}

L:SetWarningLocalization{
	WarnMurlocs		= "멀록 소환",
	SpecWarnMurlocs	= "멀록 소환!"
}

L:SetTimerLocalization{
	TimerMurlocs	= "다음 멀록 소환"
}

L:SetOptionLocalization{
	WarnMurlocs		= "멀록 소환 알림 보기",
	SpecWarnMurlocs	= "멀록 소환 특수 경고 보기",
	TimerMurlocs	= "다음 멀록 소환 바 보기"
}

-----------------
--  Lady Vashj --
-----------------
L = DBM:GetModLocalization("Vashj")

L:SetGeneralLocalization{
	name = "여군주 바쉬"
}

L:SetWarningLocalization{
	WarnElemental			= "곧 오염된 정령 등장 (%s)",
	WarnStrider				= "곧 포자손 등장 (%s)",
	WarnNaga				= "곧 나가 등장 (%s)",
	WarnShield				= "보호막 %d/4 남음",
	WarnLoot				= "오염된 핵: >%s<",
	SpecWarnElemental		= "오염된 정령 - 대상 전환!"
}

L:SetTimerLocalization{
	TimerElementalActive	= "오염된 정령 활성화",
	TimerElemental			= "오염된 정령 가능 (%d)",
	TimerStrider			= "다음 포자손 (%d)",
	TimerNaga				= "다음 나가 (%d)"
}

L:SetOptionLocalization{
	WarnElemental			= "오염된 정령 등장 이전에 알림 보기",
	WarnStrider				= "포자손 등장 이전에 알림 보기",
	WarnNaga				= "나가 등장 이전에 알림 보기",
	WarnShield				= "보호막 사라짐 알림 보기",
	WarnLoot				= "오염된 핵 획득 대상 알림 보기",
	TimerElementalActive	= "오염된 정령 활성화 시간 바 보기",
	TimerElemental			= "오염된 정령 대기시간 바 보기",
	TimerStrider			= "다음 포자손 바 보기",
	TimerNaga				= "다음 나가 바 보기",
	SpecWarnElemental		= "오염된 정령 등장 특수 경고 보기",
	AutoChangeLootToFFA		= "2 단계에서 전리품 획득 설정 자동으로 변경"
}

L:SetMiscLocalization{
	DBM_VASHJ_YELL_PHASE2	= "때가 왔다! 한 놈도 살려두지 마라!",
	DBM_VASHJ_YELL_PHASE3	= "숨을 곳이나 마련해 둬라!",
	LootMsg					= "([^%s]+).*Hitem:(%d+)"
}
