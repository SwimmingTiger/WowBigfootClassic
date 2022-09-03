if GetLocale() ~= "koKR" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "군주 매로우가르"
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "여교주 데스위스퍼"
}

L:SetWarningLocalization{
	WarnReanimating			= "이교도 부활",
	WarnAddsSoon			= "곧 새로운 이교도 등장"
}

L:SetTimerLocalization{
	TimerAdds				= "다음 이교도"
}

L:SetOptionLocalization{
	WarnAddsSoon			= "이교도 등장 이전에 알림 보기",
	WarnReanimating			= "이교도 부활 알림 보기",
	TimerAdds				= "다음 이교도 바 보기"
}

L:SetMiscLocalization{
	YellReanimatedFanatic	= "일어나라, 순수한 모습을 기뻐하라!",
	Fanatic1				= "교단 광신자",
	Fanatic2				= "변형된 광신자",
	Fanatic3				= "되살아난 광신자"
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "얼음왕관 비행선 전투"
}

L:SetWarningLocalization{
	WarnAddsSoon		= "곧 추가 병력"
}

L:SetTimerLocalization{
	TimerAdds			= "다음 추가 병력"
}

L:SetOptionLocalization{
	WarnAddsSoon		= "추가 병력 이전에 알림 보기",
	TimerAdds			= "다음 추가 병력 바 보기"
}

L:SetMiscLocalization{
	PullAlliance		= "속도를 올려라! 제군들, 곧 운명과 마주할 것이다!",
	PullHorde			= "호드의 아들딸이여, 일어나라! 오늘 우리는 증오하던 적과 전투를 벌이리라! 록타르 오가르!",
	AddsAlliance		= "약탈자",--확인필요
	AddsHorde			= "해병, 하사관, 공격하라!",
	MageAlliance		= "마술사",--확인필요
	MageHorde			= "선체가 공격받고 있다. 마술사를 불러 저 대포를 막아버려라!",
	Hammer 				= "오그림의 망치호",
	Skybreaker			= "하늘파괴자호"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "죽음의 인도자 사울팽"
}

L:SetOptionLocalization{
	RangeFrame				= "거리 창 보기(12m)",
	RunePowerFrame			= "우두머리 체력 바 사용시 $spell:72371 바 함께 보기"
}

L:SetMiscLocalization{
	PullHorde				= "코르크론, 출발하라! 용사들이여, 뒤를 조심하게. 스컬지는...",
	PullAlliance			= "그러면 이동하자! 이동..."
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "구린속"
}

L:SetOptionLocalization{
	RangeFrame				= "거리 창 보기(8m)",
	AnnounceSporeIcons		= "$spell:69279 전술 목표 아이콘 설정 내역을 공격대 대화로 알리기(공격대장 권한 필요)",
	AchievementCheck		= "역병 예방 접종 업적 실패시 실패 내용을 공격대 대화로 알리기(공격대장 권한 필요)"
}

L:SetMiscLocalization{
	SporeSet				= "가스 포자 아이콘{rt%d} : %s",
	AchievementFailed		= ">> 업적 실패 - 역병 저항 : %s (%d 중첩) <<"
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "썩은얼굴"
}

L:SetWarningLocalization{
	WarnOozeSpawn				= "작은 수액괴물 생성",
	SpecWarnLittleOoze			= "작은 수액괴물의 공격! - 뛰세요!"
}

L:SetOptionLocalization{
	WarnOozeSpawn				= "작은 수액괴물 생성 알림 보기",
	SpecWarnLittleOoze			= "작은 수액괴물에게 공격을 받을 경우 특수 경고 보기",
	RangeFrame					= "거리 창 보기(8m)"
}

L:SetMiscLocalization{
	YellSlimePipes1				= "좋은 소식이에요, 여러분! 독성 수액 배출관을 고쳤어요!",
	YellSlimePipes2				= "끝내 주는 소식이에요, 여러분! 수액이 다시 나오는군요!"
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "교수 퓨트리사이드"
}

L:SetWarningLocalization{
	SpecWarnMalleableGoo		= "당신에게 유연한 끈적이 - 이동하세요!",
	SpecWarnMalleableGooNear	= "당신 주변에 유연한 끈적이 - 벗어나세요!"
}

L:SetOptionLocalization{
	MalleableGooIcon			= "$spell:72295 대상에게 전술 목표 아이콘 설정"
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "피의 의회"
}

L:SetWarningLocalization{
	WarnTargetSwitch			= "대상 전환 : %s",
	WarnTargetSwitchSoon		= "곧 대상 전환"
}

L:SetTimerLocalization{
	TimerTargetSwitch			= "대상 전환"
}

L:SetOptionLocalization{
	WarnTargetSwitch			= "대상 전환 알림 보기",
	WarnTargetSwitchSoon		= "대상 전환 이전에 알림 보기",
	TimerTargetSwitch			= "대상 전환 바 보기",
	ActivePrinceIcon			= "활성화 된 공작에게 전술 목표 아이콘 설정(해골)",
	RangeFrame					= "거리 창 보기(12m)"
}


L:SetMiscLocalization{
	Keleseth					= "공작 켈레세스",
	Taldaram					= "공작 탈다람",
	Valanar						= "공작 발라나르",
	EmpoweredFlames				= "강력한 불꽃이"
}

-----------------------
--  Queen Lana'thel  --
-----------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "피의 여왕 라나텔"
}

L:SetOptionLocalization{
	RangeFrame				= "거리 창 보기(8m)",
	YellOnFrenzy			= "$spell:70877 대상이 된 경우 대화로 알리기"
}

L:SetMiscLocalization{
	SwarmingShadows			= "어둠이 쌓이더니",
	YellFrenzy				= "피가 모잘라~! 앙~"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "발리스리아 드림워커"
}

L:SetWarningLocalization{
	WarnPortalOpen				= "차원문 열림"
}

L:SetTimerLocalization{
	TimerPortalsOpen			= "차원문 열림",
	TimerPortalsClose			= "차원문 닫힘",
	TimerBlazingSkeleton		= "다음 타오르는 해골",
	TimerAbom					= "다음 누더기골렘"
}

L:SetOptionLocalization{
	SetIconOnBlazingSkeleton	= "타오르는 해골에게 전술 목표 아이콘 설정(해골)",
	WarnPortalOpen				= "$spell:72483 열림 알림 보기",
	TimerPortalsOpen			= "차원문 열림 바 보기",
	TimerPortalsClose			= "차원문 닫힘 바 보기",
	TimerBlazingSkeleton		= "다음 타오르는 해골 바 보기",
	TimerAbom					= "다음 걸신들린 누더기골렘 바 보기(부정확할 수 있음)"
}

L:SetMiscLocalization{
	YellPortals		= "에메랄드의 꿈으로 가는 차원문을 열어두었다. 너희의 구원은 그 안에 있다..."
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "신드라고사"
}

L:SetWarningLocalization{
	WarnAirphase			= "공중 단계",
	WarnGroundphaseSoon		= "곧 신드라고사 착륙"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "다음 공중 단계",
	TimerNextGroundphase	= "신드라고사 착륙",
	AchievementMystic		= "신비한 아픔 업적 가능"
}

L:SetOptionLocalization{
	WarnAirphase				= "공중 단계 알림 보기",
	WarnGroundphaseSoon			= "신드라고사 착륙 이전에 알림 보기",
	WarnPhase2soon				= "2 단계 이전에 알림 보기",
	TimerNextAirphase			= "다음 공중 단계 바 보기",
	TimerNextGroundphase		= "신드라고사 착륙 바 보기",
	AnnounceFrostBeaconIcons	= "$spell:70126 전술 목표 아이콘 설정 내역을 공격대 대화로 알리기(공격대장 권한 필요)",
	ClearIconsOnAirphase		= "공중 단계에서 모든 전술 목표 아이콘 제거",
	AchievementCheck			= "신비한 아픔 업적 실패시 실패 내용을 공격대 대화로 알리기(공격대장 권한 필요)",
	RangeFrame					= "강화 또는 약화 효과에 맞추어 거리 창 보기(10/20m)"
}

L:SetMiscLocalization{
	YellAirphase			= "여기가 끝이다! 아무도 살아남지 못하리라!",
	YellAirphaseDem			= "Rikk zilthuras rikk zila Aman adare tiriosh",
	YellPhase2				= "자, 주인님의 무한한 힘을 느끼고 절망에 빠져보아라!",
	YellPhase2Dem			= "Zar kiel xi romathIs zilthuras revos ruk toralar",
	BeaconIconSet			= "냉기 봉화 아이콘{rt%d} : %s",
	AchievementWarning		= "경고 : %s님의 신비한 강타가 5 중첩입니다.",
	AchievementFailed		= ">> 업적 실패 - 신비한 아픔 : %s (%d 중첩) <<"
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "리치 왕"
}

L:SetWarningLocalization{
	ValkyrWarning				= "발키리 납치 : >%s<",
	SpecWarnYouAreValkd			= "발키리가 납치 중!",
	WarnNecroticPlagueJump		= "괴저 역병 전이 : >%s<",
	SpecWarnValkyrLow			= "발키리 HP 55% 이하!!"
}

L:SetTimerLocalization{
	TimerRoleplay				= "이벤트 종료",
	PhaseTransition				= "다음 단계",
	TimerNecroticPlagueCleanse 	= "괴저 역병 사라짐"
}

L:SetOptionLocalization{
	TimerRoleplay				= "이벤트 종료 바 보기",
	WarnNecroticPlagueJump		= "$spell:70337 전이 대상 알림",
	TimerNecroticPlagueCleanse	= "$spell:70337 사라짐 바 보기",
	PhaseTransition				= "다음 단계 바 보기",
	ValkyrWarning				= "발키리 대상 알림 보기",
	SpecWarnYouAreValkd			= "발키리에게 붙잡혔을 때 특수 경고 보기",
	AnnounceValkGrabs			= "발키리 대상 및 전술 목표 아이콘 설정 내용을 공격대 대화로 알리기(공격대장 권한 필요)",
	SpecWarnValkyrLow			= "발키리의 HP가 55%이하가 된 경우 특수 경고 보기",
	AnnouncePlagueStack			= "$spell:70337 중첩 알림 보기(10중첩 이상일때, 5 중첩마다)(공격대장 권한 필요)"
}

L:SetMiscLocalization{
	LKPull					= "그러니까 성스러운 빛이 자랑하던 정의가 마침내 왔다 이건가? 폴드링, 서리한을 내려놓고 자비라도 애걸하라는 건가?",
	LKRoleplay				= "진정으로 정의에 이끌렸단 말이냐? 궁금하구나...",
	ValkGrabbedIcon			= "발키리 납치 : {rt%d} %s",
	ValkGrabbed				= "발키리 납치 : %s",
	PlagueStackWarning		= "경고: 괴저역병 - %s (%d 중첩)",
	AchievementCompleted	= ">> 업적 성공 - 괴저역병 %s (%d 중첩) <<"
}

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ICCTrash")

L:SetGeneralLocalization{
	name = "얼음왕관 성채: 일반구간"
}

L:SetWarningLocalization{
	SpecWarnTrapL		= "함정 활성화 - 죽음에 속박된 감시자!",
	SpecWarnTrapP		= "함정 활성화 - 복수의 육신해체자!",
	SpecWarnGosaEvent	= "신드라고사 수호병 등장!"
}

L:SetOptionLocalization{
	SpecWarnTrapL		= "죽음에 속박된 감시자 함정 활성화 특수 경고 보기",
	SpecWarnTrapP		= "복수의 육신해체자 함정 활성화 특수 경고 보기",
	SpecWarnGosaEvent	= "신드라고사 수호병 특수 경고 보기"
}

L:SetMiscLocalization{
	WarderTrap1			= "거기... 누구냐?",
	WarderTrap2			= "내가... 깨어난다!",
	WarderTrap3			= "주인님의 성소를 어지럽혔구나!",
	FleshreaperTrap1	= "서둘러! 저놈들 뒤에서 습격하자!",
	FleshreaperTrap2	= "우리에게서... 벗어날 수 없다!",
	FleshreaperTrap3	= "살아있는 놈이... 여기에?!",
	SindragosaEvent		= "서리 여왕께 다가가도록 두지 않겠다. 서둘러라! 저들을 막아라!"
}
