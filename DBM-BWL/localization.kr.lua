if GetLocale() ~= "koKR" then return end
local L

-----------------
--  Razorgore  --
-----------------
L = DBM:GetModLocalization("Razorgore")

L:SetGeneralLocalization{
	name = "폭군 서슬송곳니"
}
L:SetTimerLocalization{
	TimerAddsSpawn	= "추가 병력 등장"
}
L:SetOptionLocalization{
	TimerAddsSpawn	= "첫번째 추가 병력 등장 바 보기"
}
L:SetMiscLocalization{
	Phase2Emote	= "지배의 수정구가 힘을 잃고 작동을 멈춥니다!",
	YellPull 	= "침입자들이 들어왔다! 어떤 희생이 있더라도 알을 반드시 수호하라!"
}
-------------------
--  Vaelastrasz  --
-------------------
L = DBM:GetModLocalization("Vaelastrasz")

L:SetGeneralLocalization{
	name = "타락한 밸라스트라즈"
}

L:SetMiscLocalization{
	Event	= "너무 늦었어! 네파리우스의 타락이 뿌리를 내려... 난... 나 자신을 통제할 수가 없어."
}
-----------------
--  Broodlord  --
-----------------
L = DBM:GetModLocalization("Broodlord")

L:SetGeneralLocalization{
	name = "용기대장 래쉬레이어"
}

L:SetMiscLocalization{
	Pull	= "너희 같은 놈들이 올 곳은 아닌데... 죽음을 자초했구나!"
}

---------------
--  Firemaw  --
---------------
L = DBM:GetModLocalization("Firemaw")

L:SetGeneralLocalization{
	name = "화염아귀"
}

---------------
--  Ebonroc  --
---------------
L = DBM:GetModLocalization("Ebonroc")

L:SetGeneralLocalization{
	name = "에본로크"
}

----------------
--  Flamegor  --
----------------
L = DBM:GetModLocalization("Flamegor")

L:SetGeneralLocalization{
	name = "플레임고르"
}

------------------
--  Chromaggus  --
------------------
L = DBM:GetModLocalization("Chromaggus")

L:SetGeneralLocalization{
	name = "크로마구스"
}
L:SetWarningLocalization{
	WarnBreath		= "%s",
}
L:SetTimerLocalization{
	TimerBreathCD	= "다음 %s"
}
L:SetOptionLocalization{
	WarnBreath		= "숨결 알림 보기",
	TimerBreathCD	= "다음 숨결 바 보기"
}
L:SetMiscLocalization{
	Breath1	= "숨결 (1)",
	Breath2	= "숨결 (2)"
}

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-Classic")

L:SetGeneralLocalization{
	name = "네파리안"
}
L:SetWarningLocalization{
	WarnClassCall		= "직업 지목: %s",
	WarnPhase			= "%s 단계"
}
L:SetTimerLocalization{
	TimerClassCall		= "직업 지목: %s"
}
L:SetOptionLocalization{
	TimerClassCall		= "직업 지목 바 보기",
	WarnClassCall		= "직업 지목 알림 보기",
	WarnPhase			= "단계 전환 알림 보기"
}
L:SetMiscLocalization{
	YellP2			= "잘했다! 적들의 사기가 떨어지고 있다! 검은바위 첨탑의 군주에게 도전한 대가를 치르게 해주자!",
	YellP3			= "말도 안 돼! 일어나라! 다시 한 번 너희 주인을 섬겨라!",
	YellShaman		= "주술사",
	YellPaladin		= "성기사",
	YellDruid		= "드루이드",
	YellPriest		= "사제",
	YellWarrior		= "전사",
	YellRogue		= "도적",
	YellWarlock		= "흑마법사",
	YellHunter		= "사냥꾼",
	YellMage		= "마법사",
	YellDeathKnight	= "죽음의 기사",
	YellMonk		= "수도사"
}