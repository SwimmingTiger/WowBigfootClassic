if GetLocale() ~= "koKR" then return end
local L

----------------------------
--  General BG functions  --
----------------------------
L = DBM:GetModLocalization("PvPGeneral")

L:SetGeneralLocalization({
	name	= "기본 전장 기능"
})

L:SetTimerLocalization({
	TimerInvite	= "%s"
})

L:SetOptionLocalization({
	ColorByClass		= "전장 점수판 캐릭터명에 직업 색상 사용",
	TimerInvite			= "전장 입장까지 남은시간 바 보기",
	AutoSpirit			= "전장에서 사망시 자동으로 무덤 이동",
	HideBossEmoteFrame	= "화면 가운데 나타나는 전장 메세지, 주둔지 및 길드 알림 숨김"
})

L:SetMiscLocalization({
	BgStart60		= "1분 후 전투가 시작됩니다!",
	BgStart30		= "30초 후 전투가 시작됩니다!",
	ArenaInvite		= "전투 참여",
	Flag			= "깃발",
	FlagReset		= "깃발이 다시 제자리로 돌아갔습니다.",
	FlagTaken		= "^(.+)|1이;가; 깃발을 차지했습니다!",
	FlagCaptured	= "(.+)|1이;가; 깃발을 차지했습니다!",
	FlagDropped		= "깃발을 떨어뜨렸습니다!",
	ExprFlagPickUp		= "(.+)|1이;가; (.+) 깃발을 손에 넣었습니다!",
	ExprFlagCaptured	= "(.+)|1이;가; (.+) 깃발 쟁탈에 성공했습니다!",
	ExprFlagReturn		= "(.+)|1이;가; (.+) 깃발을 되찾았습니다!",
	Vulnerable1			= "약해져서",
	Vulnerable2			= "약해져서"
})

----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("z30")

L:SetOptionLocalization({
	AutoTurnIn	= "알터랙 계곡내 퀘스트 자동 완료"
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("z628")

L:SetWarningLocalization({
	WarnSiegeEngine		= "공성 전차 준비 완료",
	WarnSiegeEngineSoon	= "공성 전차 완료 10초 전"
})

L:SetTimerLocalization({
	TimerSiegeEngine	= "공성 전차 준비"
})

L:SetOptionLocalization({
	TimerSiegeEngine	= "공성 전차 준비 바 보기",
	WarnSiegeEngine		= "공성 전차 준비 완료 알림 보기",
	WarnSiegeEngineSoon	= "공성 전차 준비 완료 이전에 알림 보기",
	ShowGatesHealth		= "관문 체력 바 보기(진행 도중인 전장에 진입한경우 맞지 않음)"
})

L:SetMiscLocalization({
	GatesHealthFrame		= "피해 입은 관문",
	SiegeEngine				= "공성 전차",
	GoblinStartAlliance		= "저기 시포리움 폭탄 보이세요? 제가 공성 전차를 수리하는 동안엔 그걸 사용해서 관문을 공격하세요!",
	GoblinStartHorde		= "공성 전차를 수리하는 동안 날 좀 지켜 달라고. 필요하면 저기 있는 시포리움 폭탄을 관문에 사용해!",
	GoblinHalfwayAlliance	= "반쯤 됐어요! 호드가 절 못 때리게 해주세요. 기계공학 학교에서는 싸움은 안 가르친다고요!",
	GoblinHalfwayHorde		= "반쯤 됐다고! 얼라이언스 놈들이 가까이 못 오게 해줘. 계약서에 전투 얘긴 없었다고!",
	GoblinFinishedAlliance	= "제 최고의 작품인 듯한데요! 이제 이 공성 전차를 몰고 나가셔도 돼요!",
	GoblinFinishedHorde		= "이제 이 공성 전차를 끌고 나가도 좋아!",
	GoblinBrokenAlliance	= "벌써 부서졌어요?! 괜찮아요. 제가 못 고칠 정도는 아니에요.",
	GoblinBrokenHorde		= "또 부서졌다고?! 내가 고쳐 주지... 하지만 사용자 과실이니까 공짜로 해 줄 순 없다고."
})

-------------------------
--  Silvershard Mines  --
-------------------------
L = DBM:GetModLocalization("z727")

L:SetTimerLocalization({
	TimerRespawn	= "수레 재생성"
})

L:SetOptionLocalization({
	TimerRespawn	= "수레 재생성 바 보기",
	TimerCart		= "Show cart cap timer"
})

L:SetMiscLocalization({
	Capture	= "수레를 빼앗았습니다!",
	Arrived	= "has arived",
	Begun	= "has begun"
})

-------------------------
--  Temple of Kotmogu  --
-------------------------
L = DBM:GetModLocalization("z998")

L:SetMiscLocalization({
	OrbTaken	= "(.+)|1이;가; (.+) 공을 차지했습니다!",
	OrbReturn	= "(.+) 공이 돌아왔습니다!"
})
