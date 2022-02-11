if GetLocale() ~= "zhCN" then return end
local L

---------------
--  Nalorakk --
---------------
L = DBM:GetModLocalization("Nalorakk")

L:SetGeneralLocalization{
	name = "纳洛拉克"
}

L:SetWarningLocalization{
	WarnBear		= "熊形态",
	WarnBearSoon	= "5秒后变为熊形态",
	WarnNormal		= "人形态",
	WarnNormalSoon	= "5秒后变为人形态"
}

L:SetTimerLocalization{
	TimerBear		= "熊形态",
	TimerNormal		= "人形态"
}

L:SetOptionLocalization{
	WarnBear		= "警报：熊形态",
	WarnBearSoon	= "预警：熊形态",
	WarnNormal		= "警报：人形态",
	WarnNormalSoon	= "预警：人形态",
	TimerBear		= "计时条：熊形态",
	TimerNormal		= "计时条：人形态"
}

L:SetMiscLocalization{
	YellBear 	= "你们召唤野兽？你马上就要大大的后悔了！",
	YellNormal	= "纳洛拉克，变形，出发！"
}

---------------
--  Akil'zon --
---------------
L = DBM:GetModLocalization("Akilzon")

L:SetGeneralLocalization{
	name = "埃基尔松"
}

---------------
--  Jan'alai --
---------------
L = DBM:GetModLocalization("Janalai")

L:SetGeneralLocalization{
	name = "加亚莱"
}

L:SetMiscLocalization{
	YellBomb	= "烧死你们！",
	YellAdds	= "雌鹰哪里去了？快去孵蛋！"
}

--------------
--  Halazzi --
--------------
L = DBM:GetModLocalization("Halazzi")

L:SetGeneralLocalization{
	name = "哈尔拉兹"
}

L:SetWarningLocalization{
	WarnSpirit	= "灵魂分裂",
	WarnNormal	= "灵魂消失"
}

L:SetOptionLocalization{
	WarnSpirit	= "警报：灵魂阶段",
	WarnNormal	= "警报：正常阶段"
}

L:SetMiscLocalization{
	YellSpirit	= "狂野的灵魂与我同在……",
	YellNormal	= "灵魂，到我这里来！"
}

--------------------------
--  Hex Lord Malacrass --
--------------------------
L = DBM:GetModLocalization("Malacrass")

L:SetGeneralLocalization{
	name = "妖术领主玛拉卡斯"
}

L:SetMiscLocalization{
	YellPull	= "阴影将会降临在你们头上……"
}

--------------
--  Zul'jin --
--------------
L = DBM:GetModLocalization("ZulJin")

L:SetGeneralLocalization{
	name = "祖尔金"
}

L:SetMiscLocalization{
	YellPhase2	= "你看我有许多新招，变个熊……",
	YellPhase3	= "变成猎鹰，谁也别想逃出我的眼睛！",
	YellPhase4	= "现在来让你看看我的尖牙和利爪！",
	YellPhase5	= "龙鹰，不用抬头就能看见！"
}
