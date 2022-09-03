if GetLocale() ~= "koKR" then return end
local L

----------------------
--  FlameLeviathan  --
----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "거대 화염전차"
}

L:SetWarningLocalization{
	PursueWarn				= "추적 : >%s<",
	warnNextPursueSoon		= "추적 전환 5 초전",
	warnWardofLife			= "생명지기 덩굴손 등장!",
	SpecialPursueWarnYou	= "거대 화염전차가 당신을 추적합니다!"
}

L:SetOptionLocalization{
	SpecialPursueWarnYou	= "$spell:62374 대상이 된 경우 특수 경고 보기",
	PursueWarn				= "$spell:62374 대상 알림 보기",
	warnNextPursueSoon		= "$spell:62374 이전에 알림 보기",
	warnWardofLife			= "생명지기 덩굴손 등장시 특수 경고 보기"
}

L:SetMiscLocalization{
	YellPull				= "적대적인 존재 감지. 위협 수준 평가 체제 가동. 주 목표물과 교전. 위협 수준 재평가까지 30초.",
	Emote					= "%%s 추적중 (%S+)%."
}

-------------
--  Ignis  --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "용광로 군주 이그니스"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "칼날비늘"
}

L:SetWarningLocalization{
	warnTurretsReadySoon		= "마지막 포탑 20초 전",
	warnTurretsReady			= "마지막 포탑 준비"
}

L:SetTimerLocalization{
	timerTurret1			= "1 번째 포탑",
	timerTurret2			= "2 번째 포탑",
	timerTurret3			= "3 번째 포탑",
	timerTurret4			= "4 번째 포탑",
	timerGrounded			= "지상 착지 종료"
}

L:SetOptionLocalization{
	warnTurretsReadySoon		= "마지막 포탑 이전에 알림 보기",
	warnTurretsReady			= "마지막 포탑 알림 보기",
	timerTurret1				= "첫번째 포탑 바 보기",
	timerTurret2				= "두번째 포탑 바 보기",
	timerTurret3				= "세번째 포탑 바 보기(25인)",
	timerTurret4				= "네번째 포탑 바 보기(25인)",
	timerGrounded				= "지상 착지 유지시간 바 보기"
}

L:SetMiscLocalization{
	YellAir 			= "저희에게 잠깐 포탑을 설치할 시간을 주세요.",
	YellAir2			= "불꽃이 꺼졌습니다! 포탑을 재설치합시다!",
	YellGround			= "움직이세요! 오래 붙잡아둘 순 없을 겁니다!",
	EmotePhase2			= "완전히 땅에 내려앉았습니다!"
}

-------------
--  XT002  --
-------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "XT-002 해체자"
}

-------------------
--  무쇠 평의회  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "무쇠 평의회"
}

L:SetOptionLocalization{
	AlwaysWarnOnOverload		= "$spell:63481 특수 경고를 항상 보기(해제하면 브룬디르가 대상일때만 알림)"
}

L:SetMiscLocalization{
	Steelbreaker			= "강철파괴자",
	RunemasterMolgeim 		= "룬술사 몰가임",
	StormcallerBrundir 		= "폭풍소환사 브룬디르"
}

---------------
--  Algalon  --
---------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "관찰자 알갈론"
}

L:SetWarningLocalization{
	WarnPhase2Soon			= "곧 2단계",
	warnStarLow				= "붕괴의 별 체력 낮음"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "다음 붕괴의 별",
	TimerCombatStart		= "전투 시작"
}

L:SetOptionLocalization{
	WarningPhasePunch			= "위상의 주먹 대상 알림 보기",
	NextCollapsingStar			= "다음 붕괴의 별 바 보기",
	TimerCombatStart			= "전투 시작 바 보기",
	WarnPhase2Soon				= "2 단계 전에 알림 보기",
	warnStarLow					= "붕괴의 별 체력이 낮을 경우 특수 경고 보기(25% 이하)"
}

L:SetMiscLocalization{
	YellPull				= "너희 행동은 비논리적이다. 이 전투에서 가능한 결말은 모두 계산되었다. 결과와 상관없이 판테온은 관찰자의 전갈을 받을 것이다.",
	YellKill				= "나는 창조주의 불길이 씻어내린 세상을 보았다. 모두 변변히 저항도 못하고 사그라졌지. 너희 필멸자의 심장이 단 한 번 뛸 시간에 전 행성계가 탄생하고 무너졌다. 그러나 그 모든 시간 동안, 나는 공감이란 감정을... 몰랐다. 나는, 아무것도, 느끼지, 못했다. 무수한, 무수한 생명이 꺼졌다. 그들이 모두 너희처럼 강인했더냐? 그들이 모두 너희처럼 삶을 사랑했단 말이냐?",
	Emote_CollapsingStar	= "붕괴하는 별을 소환하기 시작합니다!",
	Phase2					= "창조의 도구를 바라보아라!",
	FirstPull				= "내 눈을 통해 너희 세상을 보아라. 측정할 수 없이 광활한 우주를... 너희 지성으로는 절대 이해할 수 없다.",
	PullCheck				= "(%d+)분 후에 알갈론이 신호 전송을 시작합니다."
}

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "콜로간"
}

L:SetTimerLocalization{
	timerLeftArm			= "왼쪽 팔 재생성",
	timerRightArm			= "오른쪽 팔 재생성",
	achievementDisarmed		= "무장해제 업적 가능"
}

L:SetOptionLocalization{
	timerLeftArm			= "왼쪽 팔 재생성 바 보기",
	timerRightArm			= "오른쪽 팔 재생성 바 보기",
	achievementDisarmed		= "무장해제 업적 바 보기"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left	= "얕은 상처야!",
	Yell_Trigger_arm_right	= "꽉꽉 쥐어짜 주마!",
	Health_Body				= "콜로간 몸통",
	Health_Right_Arm		= "오른쪽 팔",
	Health_Left_Arm			= "왼쪽 팔",
	FocusedEyebeam			= "당신에게 안광을 집중합니다!"
}

--------------
--  Auriya  --
--------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "아우리아야"
}

L:SetWarningLocalization{
	WarnCatDied 		= "수호 야수 죽음 (%d 번 남음)",
	WarnCatDiedOne 		= "수호 야수 죽음 (1 번 남음)"
}

L:SetTimerLocalization{
	timerDefender	= "수호 야수 활성"
}

L:SetOptionLocalization{
	WarnCatDied 		= "수호 야수의 남은부활 횟수 알림 보기",
	WarnCatDiedOne 		= "수호 야수 부활 횟수가 1번 남았을 때 알림 보기",
	timerDefender       = "다음 수호 야수 활성 바 보기"
}

L:SetMiscLocalization{
	Defender 		= "수호 야수 (%d)",
	YellPull 		= "내버려두는 편이 나았을 텐데!"
}

-------------
--  호디르  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "호디르"
}

L:SetMiscLocalization{
	Pull			= "침입자는 쓴맛을 보게 될 게다!",
	YellKill		= "드디어... 드디어 그의 손아귀를... 벗어나는구나."
}

--------------
--  토림  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "토림"
}

L:SetTimerLocalization{
	TimerHardmode			= "영웅 난이도 진입 가능"
}

L:SetOptionLocalization{
	TimerHardmode			= "영웅 난이도 진입 가능 바 보기",
	AnnounceFails			= "$spell:62017 주문에 피해를 입은 대상을 공격대 대화로 알림(승급 권한 필요)"
}

L:SetMiscLocalization{
	YellPhase1				= "침입자라니! 감히 내 취미 생활을 방해하는 놈들은 쓴맛을 단단히... 잠깐... 너는...",
	YellPhase2				= "건방진 젖먹이 같으니... 감히 여기까지 기어올라와 내게 도전해? 내 손으로 쓸어버리겠다!",
	YellKill				= "무기를 거둬라! 내가 졌다!",
	ChargeOn				= "번개 충전: %s",
	Charge					= "번개 충전 맞음 (이번 시도): %s"
}

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "프레이야"
}

L:SetWarningLocalization{
	WarnSimulKill		= "첫번째 소환수 죽음 - 12초 후 부활"
}

L:SetTimerLocalization{
	TimerSimulKill 			= "소환수 부활"
}

L:SetOptionLocalization{
	WarnSimulKill			= "첫번째 소환수 죽음 알림 보기",
	TimerSimulKill			= "소환수 부활 바 보기"
}

L:SetMiscLocalization{
	SpawnYell			= "얘들아, 날 도와라!",
	WaterSpirit			= "고대 물의 정령",
	Snaplasher 			= "악어덩굴손",
	StormLasher 		= "폭풍덩굴손",
	YellKill			= "내게서 그의 지배력이 걷혔다. 다시 온전한 정신을 찾았도다. 영웅들이여, 고맙다."
}

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "프레이야의 장로"
}

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "미미론"
}

L:SetWarningLocalization{
	MagneticCore			= "자기 증폭기 획득 : >%s<",
	WarningShockBlast		= "충격 작렬 - 움직이세요!",
	WarnBombSpawn			= "폭탄 로봇 생성!"
}

L:SetTimerLocalization{
	TimerHardmode			= "광폭화",
	TimeToPhase2			= "2 단계",
	TimeToPhase3			= "3 단계",
	TimeToPhase4			= "4 단계"
}

L:SetOptionLocalization{
	TimeToPhase2			= "2 단계 바 보기",
	TimeToPhase3			= "3 단계 바 보기",
	TimeToPhase4			= "4 단계 바 보기",
	MagneticCore			= "자기 증폭기 획득자 알림 보기",
	WarnBombSpawn			= "폭탄 로봇 생성 알림 보기",
	TimerHardmode			= "영웅 난이도 광폭화 바 보기",
	ShockBlastWarningInP1	= "$spell:63631 특수 경고 보기(1 단계)",
	ShockBlastWarningInP4	= "$spell:63631 특수 경고 보기(4 단계)"
}

L:SetMiscLocalization{
	MobPhase1 		= "거대 전차 Mk II",
	MobPhase2 		= "VX-001",
	MobPhase3 		= "공중지휘기",
	YellPull		= "시간이 없어, 친구들! 내가 최근에 만든 기막힌 발명품을 시험하게 도와 주겠지? 자, 마음 바꿀 생각은 말라고. XT-002를 그 꼬락서니로 만들었으니, 너흰 나한테 빚진 셈이란 걸 잊지 마!",
	YellHardPull	= "자폭 절차를 시작합니다.",
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
}

--------------------
--  GeneralVezax  --
--------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "장군 베작스"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash		= "당신에게 어둠 붕괴 - 이동하세요!",
	SpecialWarningShadowCrashNear	= "당신 주변에 어둠 붕괴!",
	SpecialWarningLLNear			= "당신 주변에 생명력 흡수! (%s)"
}

L:SetTimerLocalization{
	hardmodeSpawn = "사로나이트 원혼 생성 중"
}

L:SetOptionLocalization{
	SpecialWarningShadowCrash		= "$spell:62660 특수 경고 보기",
	SpecialWarningShadowCrashNear	= "$spell:62660 대상이 가까이 있을 경우 특수 경고 보기",
	SpecialWarningLLNear			= "$spell:63276 대상이 가까이 있을 경우 특수 경고 보기",
	hardmodeSpawn					= "사로나이드 원혼 생성 바 보기(영웅 난이도 진입용)",
	CrashArrow						= "$spell:62660 대상이 가까이 있을 경우 DBM 화살표 보기"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors		= "가까운 사로나이트 증기 구름이 합쳐집니다!"
}

-----------------
--  YoggSaron  --
-----------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "요그사론"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "요그사론의 수호자 소환 (%d)",
	WarningCrusherTentacleSpawned	= "분쇄의 촉수 생성",
	WarningSanity 					= "%d 이성 남음",
	SpecWarnSanity 					= "%d 이성 남음!",
	SpecWarnGuardianLow 			= "수호자 체력 낮음 - 주의!",
	SpecWarnMadnessOutNow			= "광기 유발 종료 직전 - 밖으로 나가세요!",
	WarnBrainPortalSoon				= "3초 후 차원문",
	SpecWarnFervorCast				= "당신에게 사라의 열정 시전 중!",
	specWarnBrainPortalSoon			= "곧 차원문!"
}

L:SetTimerLocalization{
	NextPortal			= "차원문"
}

L:SetOptionLocalization{
	WarningGuardianSpawned			= "요그사론의 수호자 소환 알림 보기",
	WarningCrusherTentacleSpawned	= "분쇄의 촉수 생성 알림 보기",
	WarningSanity					= "$spell:63050이 낮은 경우 알림 보기",
	SpecWarnSanity					= "$spell:63050이 매우 낮은 경우 특수 경고 보기",
	SpecWarnGuardianLow				= "수호자의 생명력이 낮을 때 특수 경고 보기(1 단계만)",
	WarnBrainPortalSoon				= "차원문 이전에 알림 보기",
	SpecWarnMadnessOutNow			= "$spell:64059이 끝나기 전 특수 경고 보기",
	SpecWarnFervorCast				= "$spell:63138을 대상이 된 경우 특수 경고 보기<br/>(공격대원 중 최소 한명이 사라를 대상 또는 주시대상으로 설정해야 함)",
	specWarnBrainPortalSoon			= "차원문 이전에 특수 경고 보기",
	NextPortal						= "다음 차원문 바 보기",
	MaladyArrow						= "$spell:63881 대상이 가까이 있을 경우 DBM 화살표 보기"
}

L:SetMiscLocalization{
	YellPull 				= "짐승의 대장을 칠 때가 곧 다가올 거예요! 놈의 졸개들에게 노여움과 미움을 쏟아부으세요!",
	YellPhase2 				= "나는, 살아 있는 꿈이다.",
	Sara 					= "사라"
}
