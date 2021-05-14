if GetLocale() ~= "zhCN" then return end

local L

-----------
--  Alar --
-----------
L = DBM:GetModLocalization("Alar")

L:SetGeneralLocalization{
	name = "奥"
}

L:SetTimerLocalization{
	NextPlatform	= "下一个位置"
}

L:SetOptionLocalization{
	NextPlatform	= "Show timer for when Al'ar changes platforms"
}

------------------
--  Void Reaver --
------------------
L = DBM:GetModLocalization("VoidReaver")

L:SetGeneralLocalization{
	name = "空灵机甲"
}

--------------------------------
--  High Astromancer Solarian --
--------------------------------
L = DBM:GetModLocalization("Solarian")

L:SetGeneralLocalization{
	name = "大星术师索兰莉安"
}

L:SetWarningLocalization{
	WarnSplit		= "*** 下属即将出现 ***",
	WarnSplitSoon	= "*** 5秒后分裂 ***",
	WarnAgent		= "*** 密探出现 ***",
	WarnPriest		= "*** 祭司与索兰莉安出现 ***"

}

L:SetTimerLocalization{
	TimerSplit		= "分裂",
	TimerAgent		= "密探",
	TimerPriest		= "祭司与索兰莉安"
}

L:SetOptionLocalization{
	WarnSplit		= "Show warning for Split",
	WarnSplitSoon	= "Show pre-warning for Split",
	WarnAgent		= "Show warning for Agents spawn",
	WarnPriest		= "Show warning for Priests and Solarian spawn",
	TimerSplit		= "Show timer for Split",
	TimerAgent		= "Show timer for Agents spawn",
	TimerPriest		= "Show timer for Priests and Solarian spawn",
	WrathWhisper	= "向受到星术师之怒效果的目标发送密语"
}

L:SetMiscLocalization{
	WrathWhisper	= "星术师之怒！",
	YellSplit1		= "I will crush your delusions of grandeur!",--Translate
	YellSplit2		= "You are hopelessly outmatched!",--Translate
	YellPhase2		= "I become"--Translate
}

---------------------------
--  Kael'thas Sunstrider --
---------------------------
L = DBM:GetModLocalization("KaelThas")

L:SetGeneralLocalization{
	name = "凯尔萨斯·逐日者"
}

L:SetWarningLocalization{
	WarnGaze		= "*** 萨拉德雷注视着>%s< ***",
	WarnMobDead		= "%s down",--Translate
	WarnEgg			= "*** 凤凰倒下 - 卵出现 ***",
	SpecWarnGaze	= "快跑！",
	SpecWarnEgg		= "*** 凤凰倒下 - 卵出现 ***"
}

L:SetTimerLocalization{
	TimerPhase		= "Next Phase",--Translate
	TimerPhase1mob	= "%s",
	TimerNextGaze	= "凝视冷却",
	TimerRebirth	= "复生"
}

L:SetOptionLocalization{
	WarnGaze		= "Show warning for Thaladred's Gaze target",--Translate
	WarnMobDead		= "Show warning for Phase 2 mob down",--Translate
	WarnEgg			= "Show warning when Phoenix Egg spawn",--Translate
	SpecWarnGaze	= "Show special warning when Gaze on you",--Translate
	SpecWarnEgg		= "Show special warning when Phoenix Egg spawn",--Translate
	TimerPhase		= "Show time for next phase",--Translate
	TimerPhase1mob	= "Show time for Phase 1 mob active",--Translate
	TimerNextGaze	= "Show timer for Thaladred's Gaze target changes",--Translate
	TimerRebirth	= "Show timer for Phoenix Egg rebirth remaining",--Translate
	GazeWhisper		= "对萨拉德雷的目标发送密语",
	GazeIcon		= "对萨拉德雷的目标添加标注"
}

L:SetMiscLocalization{
	YellPhase2	= "你们看，我的个人收藏中有许多武器……",
	YellPhase3	= "也许我确实低估了你们。虽然让你们同时面对我的四位顾问显得有些不公平，但是我的人民从来都没有得到过公平的待遇。我只是在以牙还牙。",
	YellPhase4	= "唉，有些时候，有些事情，必须得亲自解决才行。Balamore shanal！",
	YellPhase5	= "我的心血是不会被你们轻易浪费的！我精心谋划的未来是不会被你们轻易破坏的！感受我真正的力量吧！",
	YellSang	= "你们击败了我最强大的顾问……但是没有人能战胜鲜血之锤。出来吧，萨古纳尔男爵！",
	YellCaper	= "卡波妮娅会很快解决你们的。",
	YellTelo	= "干得不错。看来你们有能力挑战我的首席技师，塔隆尼库斯。",
	EmoteGaze	= "凝视着([^%s]+)！",
	GazeWhisper	= "萨拉德雷注视着你！快跑！",
	Thaladred	= "萨拉德雷",
	Sanguinar	= "萨古纳尔",
	Capernian	= "卡波妮娅",
	Telonicus	= "塔隆尼库斯",
	Bow			= "弓",
	Axe			= "斧",
	Mace		= "锤",
	Dagger		= "匕首",
	Sword		= "剑",
	Shield		= "盾牌",
	Staff		= "法杖",
	Egg			= "凤凰卵"
}
