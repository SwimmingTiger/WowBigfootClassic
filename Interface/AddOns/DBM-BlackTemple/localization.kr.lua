if GetLocale() ~= "koKR" then return end
local L

-----------------
--  Najentus  --
-----------------
L = DBM:GetModLocalization("Najentus")

L:SetGeneralLocalization{
	name = "대장군 나젠투스"
}

L:SetOptionLocalization{
	InfoFrame	= "체력이 낮은 대상을 정보 창으로 보기(8800 미만)"
}

L:SetMiscLocalization{
	HealthInfo	= "체력 정보"
}

----------------
-- Supremus --
----------------
L = DBM:GetModLocalization("Supremus")

L:SetGeneralLocalization{
	name = "궁극의 심연"
}

L:SetWarningLocalization{
	WarnPhase		= "%s 단계",
	WarnKite		= "추적 : >%s<"
}

L:SetTimerLocalization{
	TimerPhase		= "다음 %s 단계"
}

L:SetOptionLocalization{
	WarnPhase		= "단계 전환 알림 보기",
	WarnKite		= "추적 대상 알림 보기",
	TimerPhase		= "다음 단계 바 보기",
	KiteIcon		= "추적 대상에게 전술 목표 아이콘 설정"
}

L:SetMiscLocalization{
	PhaseTank		= "땅이 갈라져서 열리기 시작합니다!",--Check if Backwards
	PhaseKite		= "분노하여 땅을 내리찍습니다!",--Check if Backwards
	ChangeTarget	= "새로운 대상이 필요합니다!",
	Kite			= "추적",
	Tank			= "일반"
}

-------------------------
--  Shape of Akama  --
-------------------------
L = DBM:GetModLocalization("Akama")

L:SetGeneralLocalization{
	name = "아카마의 망령"
}

-------------------------
--  Teron Gorefiend  --
-------------------------
L = DBM:GetModLocalization("TeronGorefiend")

L:SetGeneralLocalization{
	name = "테론 고어핀드"
}

L:SetTimerLocalization{
	TimerVengefulSpirit		= "유령 : %s"
}

L:SetOptionLocalization{
	TimerVengefulSpirit		= "유령 유지시간 바 보기"
}

----------------------------
--  Gurtogg Bloodboil  --
----------------------------
L = DBM:GetModLocalization("Bloodboil")

L:SetGeneralLocalization{
	name = "구르토그 블러드보일"
}

--------------------------
--  Essence Of Souls  --
--------------------------
L = DBM:GetModLocalization("Souls")

L:SetGeneralLocalization{
	name = "영혼의 성물함"
}

L:SetWarningLocalization{
	WarnMana		= "30초 후 마나 0"
}

L:SetTimerLocalization{
	TimerMana		= "마나 0"
}

L:SetOptionLocalization{
	WarnMana		= "2 단계 에서 마나 0 이 되기 30초 전에 알림 보기",
	TimerMana		= "마나 0까지 남은시간 바 보기"
}

L:SetMiscLocalization{
	Suffering		= "고뇌의 정수",
	Desire			= "욕망의 정수",
	Anger			= "격노의 정수"
}

-----------------------
--  Mother Shahraz --
-----------------------
L = DBM:GetModLocalization("Shahraz")

L:SetGeneralLocalization{
	name = "대모 샤라즈"
}

L:SetTimerLocalization{
	timerAura	= "%s"
}

L:SetOptionLocalization{
	timerAura	= "변위의 오라 바 보기"
}

----------------------
--  Illidari Council  --
----------------------
L = DBM:GetModLocalization("Council")

L:SetGeneralLocalization{
	name = "일리다리 의회"
}

L:SetWarningLocalization{
	Immune			= "말란데 - 15초간 %s 면역!"
}

L:SetOptionLocalization{
	Immune			= "말란데가 물리 또는 주문 면역이 되었을 때 특수 경고 보기"
}

L:SetMiscLocalization{
	Gathios			= "파괴자 가디오스",
	Malande			= "여군주 말란데",
	Zerevor			= "고위 황천술사 제레보르",
	Veras			= "베라스 다크섀도",
	Melee			= "물리",
	Spell			= "주문"
}

-------------------------
--  Illidan Stormrage --
-------------------------
L = DBM:GetModLocalization("Illidan")

L:SetGeneralLocalization{
	name = "일리단 스톰레이지"
}

L:SetWarningLocalization{
	WarnHuman		= "인간 형상",
	WarnDemon		= "악마 형상"
}

L:SetTimerLocalization{
	TimerNextHuman		= "다음 인간 형상",
	TimerNextDemon		= "다음 악마 형상"
}

L:SetOptionLocalization{
	WarnHuman		= "인간 형상 알림 보기",
	WarnDemon		= "악마 형상 알림 보기",
	TimerNextHuman	= "다음 인간 형상 바 보기",
	TimerNextDemon	= "다음 악마 형상 바 보기",
	RangeFrame		= "3, 4 단계에서 거리 창 보기(10m)"
}

L:SetMiscLocalization{
	Pull			= "아카마, 너의 불충은 그리 놀랍지도 않구나. 너희 흉측한 형제들을 벌써 오래전에 없애버렸어야 했는데...",
	Eyebeam			= "배신자의 눈을 똑바로 쳐다봐라!",
	Demon			= "내 안에 깃든... 악마의 힘을 보여주마!",
	Phase4			= "필멸의 종족들이여, 나에 대한 증오가 고작 이 정도냐?"
}
