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
	WarnPhase		= "%s 阶段",
	SpecWarnMark	= "%s : %s"
}

L:SetTimerLocalization{
	TimerMark	= "下一次 %s : %s"
}

L:SetOptionLocalization{
	WarnMark		= "警报印记",
	WarnPhase		= "警报阶段变化",
	SpecWarnMark	= "显示：当印记到100%时警报",
	TimerMark		= "显示下一次印记时间"
}

L:SetMiscLocalization{
	Frost	= "水阶段",
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
	WarnSubmergeSoon	= "下潜 10 秒",
	WarnEmerge			= "重新出现",
	WarnEmergeSoon		= "重新出现 10 秒"
}

L:SetTimerLocalization{
	TimerSubmerge		= "下潜",
	TimerEmerge			= "重新出现"
}

L:SetOptionLocalization{
	WarnSubmerge		= "显示下潜警报",
	WarnSubmergeSoon	= "显示下潜预警",
	WarnEmerge			= "显示重新出现警报",
	WarnEmergeSoon		= "显示重新出现预警",
	TimerSubmerge		= "显示下潜时间",
	TimerEmerge			= "显示重新出现时间"
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
	WarnPhase		= "%s 阶段",
	WarnPhaseSoon	= "%s 阶段转换 5 秒"
}

L:SetTimerLocalization{
	TimerPhase	= "下一次 %s 阶段"
}

L:SetOptionLocalization{
	WarnPhase		= "显示下一阶段的警报",
	WarnPhaseSoon	= "显示下一阶段预警",
	TimerPhase		= "显示下一阶段时间"
}

L:SetMiscLocalization{
	Human		= "人形态",
	Demon		= "恶魔形态",
	YellDemon	= "滚开吧，脆弱的精灵。现在我说了算！",
	YellPhase1  = "我的放逐终于结束了！",
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
	Caribdis	= "深水卫士卡莉蒂丝",
	Tidalvess	= "深水卫士泰达维斯 ",
	Sharkkis	= "深水卫士沙克基斯"
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
	SpecWarnMurlocs	= "鱼人群出现时显示特殊警报",
	TimerMurlocs	= "显示鱼人群出现计时",
	GraveIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(38049)
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
	TimerElemental		= "被污染的元素 (%d)",
	TimerStrider		= "盘牙巡逻者 (%d)",
	TimerNaga			= "盘牙精英 (%d)"
}

L:SetOptionLocalization{
	WarnElemental		= "显示被污染的元素出现的预警",
	WarnStrider			= "显示盘牙巡逻者出现的预警",
	WarnNaga			= "显示盘牙精英出现的预警",
	WarnShield			= "显示第2阶段护盾消失警报",
	WarnLoot			= "警告是谁拾取了污染之核",
	TimerElementalActive	= "为下一次被污染的元素出现显示计时器",
	TimerElemental		= "显示下一次被污染的元素出现的时间",
	TimerStrider		= "显示下一次盘牙巡逻者出现的时间",
	TimerNaga			= "显示盘牙精英出现的时间",
	SpecWarnCore		= "显示特别警报：当被污染之核在你身上",
	SpecWarnElemental	= "显示特别警报：当被污染的元素到来时"
}

L:SetMiscLocalization{
	DBM_VASHJ_YELL_PHASE2	= "机会来了！一个活口都不要留下！",
	DBM_VASHJ_YELL_PHASE3	= "你们最好找掩护。",
	LootMsg				= "(.+)获得了物品：.*Hitem:(%d+)"
}
