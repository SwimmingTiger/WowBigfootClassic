-- Diablohu(diablohudream@gmail.com)
-- yleaf(yaroot@gmail.com)
-- Mini_Dragon(projecteurs@gmail.com)
-- Yike Xia
-- Last update: Sep 23 2015, 06:10 UTC@14543

if GetLocale() ~= "zhCN" then return end

local L

------------------------------
--  The Crown Chemical Co.  --
------------------------------
L = DBM:GetModLocalization("d288")

L:SetTimerLocalization({
	HummelActive		= "汉摩尔加入战斗",
	BaxterActive		= "拜克斯特加入战斗",
	FryeActive		= "弗莱加入战斗"
})

L:SetOptionLocalization({
	TrioActiveTimer		= "计时条：药剂师何时加入战斗"
})

L:SetMiscLocalization({
	SayCombatStart		= "他们顾得上告诉你我是谁或者我在做些什么吗？"
})

----------------------------
--  The Frost Lord Ahune  --
----------------------------
L = DBM:GetModLocalization("d286")

L:SetGeneralLocalization{
	name = "埃霍恩"
}

L:SetWarningLocalization({
	Emerged			= "埃霍恩已现身",
	specWarnAttack	= "埃霍恩拥有易伤 - 现在攻击!"
})

L:SetTimerLocalization{
	SubmergeTimer	= "隐没",
	EmergeTimer		= "现身"
}

L:SetOptionLocalization({
	Emerged			= "警报：埃霍恩现身",
	specWarnAttack	= "特殊警报：埃霍恩拥有易伤",
	SubmergeTimer	= "计时条：隐没",
	EmergeTimer		= "计时条：现身"
})

L:SetMiscLocalization({
	Pull			= "冰石已经溶化了!"
})

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("d287")

L:SetGeneralLocalization{
	name = "科林·烈酒"
}

L:SetWarningLocalization({
	specWarnBrew		= "在他再丢你一个前喝掉酒！",
	specWarnBrewStun	= "提示：你疯狂了，记得下一次喝啤酒！"
})

L:SetOptionLocalization({
	specWarnBrew		= "特殊警报：$spell:47376",
	specWarnBrewStun	= "特殊警报：$spell:47340"
})

L:SetMiscLocalization({
	YellBarrel			= "我中了空桶！"
})

-----------------------------
--  The Headless Horseman  --
-----------------------------
L = DBM:GetModLocalization("d285")

L:SetGeneralLocalization{
	name = "无头骑士"
}

L:SetWarningLocalization({
	WarnPhase				= "第%d阶段",
	warnHorsemanSoldiers	= "跃动的南瓜出现了",
	warnHorsemanHead		= "打脑袋！"
})

L:SetOptionLocalization({
	WarnPhase				= "警报：阶段转换",
	warnHorsemanSoldiers	= "警报：跃动的南瓜出现",
	warnHorsemanHead		= "特殊警报：无头骑士的脑袋出现"
})

L:SetMiscLocalization({
	HorsemanSummon			= "无头骑士来了……",
	HorsemanSoldiers		= "士兵们，起来战斗吧！为死去的骑士带来胜利的荣耀！"
})
