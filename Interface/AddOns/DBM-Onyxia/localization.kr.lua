if GetLocale() ~= "koKR" then return end

local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization{
	name = "오닉시아"
}

L:SetWarningLocalization{
	WarnWhelpsSoon		= "곧 오닉시아 새끼용 등장"
}

L:SetTimerLocalization{
	TimerWhelps 		= "오닉시아 새끼용"
}

L:SetOptionLocalization{
	TimerWhelps				= "오닉시아 새끼용 등장 타이머 바 보기",
	WarnWhelpsSoon			= "오닉시아 새끼용 등장 사전 경고 보기",
	SoundWTF3				= "전설적인 오닉시아 레이드 영상에서 추출한 재미있는 효과음 재생"
}

L:SetMiscLocalization{
	Breath 		= "%s 숨을 깊게 들이쉽니다.",
	YellPull 	= "오늘은 운이 아주 좋군. 평소엔 먹이를 찾으려면 둥지에서 나가야 하는데 말이야.",
	YellP2 		= "쓸데없이 힘을 쓰는 것도 지루하군. 네 녀석들 머리 위에서 모조리 불살라 주마!",
	YellP3 		= "혼이 더 나야 정신을 차리겠구나!"
}
