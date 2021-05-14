if GetLocale() ~= "zhCN" then return end
local L

---------------------------
--  Hydross the Unstable --
---------------------------
L = DBM:GetModLocalization("Hydross")

L:SetGeneralLocalization{
	name = "不稳定的海度斯"
}

L:SetWarningLocalization{
	WarnMark 		= "%s : %s",
	WarnPhase		= "%s Phase",--Translate
	SpecWarnMark	= "%s : %s"
}

L:SetTimerLocalization{
	TimerMark	= "Next %s : %s"--Translate
}

L:SetOptionLocalization{
	WarnMark		= "警报印记",
	WarnPhase		= "警报阶段变化",
	SpecWarnMark	= "Show warning when Marks debuff damage over 100%",--Translate
	TimerMark		= "Show timer for next Marks"--Translate
}

L:SetMiscLocalization{
	Frost	= "冰霜阶段",
	Nature	= "自然阶段"
}

-----------------------
--  The Lurker Below --
-----------------------
L = DBM:GetModLocalization("LurkerBelow")

L:SetGeneralLocalization{
	name = "鱼斯拉"
}

L:SetWarningLocalization{
	WarnSubmerge		= "下潜",
	WarnSubmergeSoon	= "Submerge in 10 sec",--Translate
	WarnEmerge			= "重新出现",
	WarnEmergeSoon		= "Emerge in 10 sec"--Translate
}

L:SetTimerLocalization{
	TimerSubmerge		= "下潜",
	TimerEmerge			= "重新出现"
}

L:SetOptionLocalization{
	WarnSubmerge		= "Show warning when submerge",--Translate
	WarnSubmergeSoon	= "Show pre-warning for submerge",--Translate
	WarnEmerge			= "Show warning when emerge",--Translate
	WarnEmergeSoon		= "Show pre-warning for emerge",--Translate
	TimerSubmerge		= "Show time for submerge",--Translate
	TimerEmerge			= "Show time for emerge"--Translate
}

L:SetMiscLocalization{
	Spout	= "%s深深吸了一口气！"
}

--------------------------
--  Leotheras the Blind --
--------------------------
L = DBM:GetModLocalization("Leotheras")

L:SetGeneralLocalization{
	name = "盲眼者莱欧瑟拉斯"
}

L:SetWarningLocalization{
	WarnPhase		= "%s Phase",--Translate
	WarnPhaseSoon	= "%s Phase in 5 sec"--Translate
}

L:SetTimerLocalization{
	TimerPhase	= "Next %s Phase"--Translate
}

L:SetOptionLocalization{
	WarnPhase		= "Show warning for next phase",--Translate
	WarnPhaseSoon	= "Show pre-warning for next phase",--Translate
	TimerPhase		= "Show time for next phase"--Translate
}

L:SetMiscLocalization{
	Human		= "Human",--Translate
	Demon		= "Demon",--Translate
	YellDemon	= "滚开吧，脆弱的精灵。现在我说了算！",
	YellPhase2	= "不……不！你在干什么？我才是主宰！你听到没有？我……啊啊啊啊！控制……不住了。"
}

-----------------------------
--  Fathom-Lord Karathress --
-----------------------------
L = DBM:GetModLocalization("Fathomlord")

L:SetGeneralLocalization{
	name = "深水领主卡拉瑟雷斯"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	Caribdis	= "Fathom-Guard Caribdis",--Translate
	Tidalvess	= "Fathom-Guard Tidalvess",--Translate
	Sharkkis	= "Fathom-Guard Sharkkis"--Translate
}

--------------------------
--  Morogrim Tidewalker --
--------------------------
L = DBM:GetModLocalization("Tidewalker")

L:SetGeneralLocalization{
	name = "莫洛格里·踏潮者"
}

L:SetWarningLocalization{
	WarnMurlocs		= "鱼人群出现",
	SpecWarnMurlocs	= "鱼人群出现!"
}

L:SetTimerLocalization{
	TimerMurlocs	= "鱼人群"
}

L:SetOptionLocalization{
	WarnMurlocs		= "警报鱼人群",
	SpecWarnMurlocs	= "Show special warning when Murlocs spawning",--Translate
	TimerMurlocs	= "Show timer for Murlocs spawning",--Translate
	GraveIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(38049)
}

L:SetMiscLocalization{
}

-----------------
--  Lady Vashj --
-----------------
L = DBM:GetModLocalization("Vashj")

L:SetGeneralLocalization{
	name = "瓦丝琪"
}

L:SetWarningLocalization{
	WarnElemental		= "被污染的元素 - 5秒后出现 (%s)",
	WarnStrider			= "盘牙巡逻者 - 5秒后出现 (%s)",
	WarnNaga			= "盘牙精英 - 5秒后出现 (%s)",
	WarnShield			= "护盾 - %d/4被击碎",
	WarnLoot			= ">%s<获得了污染之核",
	SpecWarnElemental	= "被污染的元素 - 5秒后出现!"
}

L:SetTimerLocalization{
	TimerElemental		= "被污染的元素 (%d)",--Verify
	TimerStrider		= "盘牙巡逻者 (%d)",--Verify
	TimerNaga			= "盘牙精英 (%d)"--Verify
}

L:SetOptionLocalization{
	WarnElemental		= "Show pre-warning for next Tainted Elemental",--Translate
	WarnStrider			= "Show pre-warning for next Strider",--Translate
	WarnNaga			= "Show pre-warning for next Naga",--Translate
	WarnShield			= "Show warning for Phase 2 shield down",--Translate
	WarnLoot			= "警报是谁拾取了污染之核",
	TimerElemental		= "Show time for next Tainted Elemental",--Translate
	TimerStrider		= "Show time for next Strider",--Translate
	TimerNaga			= "Show time for next Strider",--Translate
	SpecWarnElemental	= "Show special warning when Tainted Elemental coming",--Translate
	ChargeIcon			= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(38280),
	AutoChangeLootToFFA	= "第3阶段自动转换拾取方式为自由拾取"
}

L:SetMiscLocalization{
	DBM_VASHJ_YELL_PHASE2	= "机会来了！一个活口都不要留下！",
	LootMsg				= "(.+)获得了物品：.*Hitem:(%d+)"
}
