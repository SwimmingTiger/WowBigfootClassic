if GetLocale() ~= "zhCN" then return end
local L

---------------
--  Kalecgos --
---------------
L = DBM:GetModLocalization("Kal")

L:SetGeneralLocalization{
	name = "卡雷苟斯"
}

L:SetWarningLocalization{
	WarnPortal			= "传送 #%d : >%s< (%d组)",
	SpecWarnWildMagic	= "狂野魔法 - %s!"
}

L:SetOptionLocalization{
	WarnPortal			= "显示 $spell:46021 的目标",
	SpecWarnWildMagic	= "特殊警报：狂野魔法",
	ShowFrame			= "显示灵魂世界框体" ,
	FrameClassColor		= "灵魂世界框体内使用职业颜色",
	FrameUpwards		= "灵魂世界框体向上扩展",
	FrameLocked			= "设置灵魂世界框体不可移动"
}

L:SetMiscLocalization{
	Demon				= "腐蚀者萨索瓦尔",
	Heal				= "+100%治疗效果",
	Haste				= "+100%施法时间",
	Hit					= "-50%命中几率",
	Crit				= "+100%爆击伤害",
	Aggro				= "+100%威胁值",
	Mana				= "-50%技能消耗",
	FrameTitle			= "首领生命值",
	FrameLock			= "锁定框体",
	FrameClassColor		= "使用职业颜色",
	FrameOrientation	= "灵魂世界框体向上延伸",
	FrameHide			= "隐藏框体",
	FrameClose			= "关闭"
}

----------------
--  Brutallus --
----------------
L = DBM:GetModLocalization("Brutallus")

L:SetGeneralLocalization{
	name = "布鲁塔卢斯"
}

L:SetMiscLocalization{
	Pull			= "啊，又来了一群小绵羊！"
}

--------------
--  Felmyst --
--------------
L = DBM:GetModLocalization("Felmyst")

L:SetGeneralLocalization{
	name = "菲米丝"
}

L:SetWarningLocalization{
	WarnPhase		= "%s 阶段"
}

L:SetTimerLocalization{
	TimerPhase		= "下一次 %s 阶段"
}

L:SetOptionLocalization{
	WarnPhase		= "警报：下一阶段",
	TimerPhase		= "计时条：下一阶段"
}

L:SetMiscLocalization{
	Air				= "空中",
	Ground			= "地面",
	AirPhase		= "我比以前更强大了！",
	Breath			= "%s 深深地吸了一口气。"
}

-----------------------
--  The Eredar Twins --
-----------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization{
	name = "艾瑞达双子"
}

L:SetMiscLocalization{
	Nova			= "萨洛拉丝女王向 (.+)% 施放暗影新星。",
	Conflag			= "高阶术士奥蕾塞丝向 (.+)% 施放燃烧",
	Sacrolash		= "萨洛拉丝女王",
	Alythess		= "高阶术士奥蕾塞丝"
}

------------
--  M'uru --
------------
L = DBM:GetModLocalization("Muru")

L:SetGeneralLocalization{
	name = "穆鲁"
}

L:SetWarningLocalization{
	WarnHuman		= "暗誓精灵 (%d)",
	WarnVoid		= "虚空戒卫 (%d)",
	WarnFiend		= "黑暗魔出现"
}

L:SetTimerLocalization{
	TimerHuman		= "暗誓精灵 (%s)",
	TimerVoid		= "虚空戒卫 (%s)",
	TimerPhase		= "熵魔"
}

L:SetOptionLocalization{
	WarnHuman		= "警报：暗誓精灵",
	WarnVoid		= "警报：虚空戒卫",
	WarnFiend		= "警报：2阶段黑暗魔",
	TimerHuman		= "计时条：暗誓精灵",
	TimerVoid		= "计时条：虚空戒卫",
	TimerPhase		= "显示阶段转换的过渡时间"
}

L:SetMiscLocalization{
	Entropius		= "熵魔"
}

----------------
--  Kil'jeden --
----------------
L = DBM:GetModLocalization("Kil")

L:SetGeneralLocalization{
	name = "基尔加丹"
}

L:SetWarningLocalization{
	WarnDarkOrb		= "生成的护盾宝珠",
	WarnBlueOrb		= "蓝龙宝珠",
	SpecWarnDarkOrb	= "护盾宝珠出现！",
	SpecWarnBlueOrb	= "蓝龙宝珠已准备好！"
}

L:SetTimerLocalization{
	TimerBlueOrb	= "蓝龙宝珠"
}

L:SetOptionLocalization{
	WarnDarkOrb		= "警报：护盾宝珠 ",
	WarnBlueOrb		= "警报：蓝龙宝珠",
	SpecWarnDarkOrb	= "特殊警报：护盾宝珠",
	SpecWarnBlueOrb	= "特殊警报：蓝龙宝珠",
	TimerBlueOrb	= "计时条：蓝龙宝珠"
}

L:SetMiscLocalization{
	YellPull		= "这个消耗品已经没用了！不管它了！现在我已经做到了连萨格拉斯都没有做到的事情！我要彻底毁灭这个世界，真正成为燃烧军团的主宰者！末日已经到来啦！让这个世界就此支离破碎吧！",
	OrbYell1		= "我会将我的力量导入宝珠中！准备好！",
	OrbYell2		= "我又将能量灌入了另一颗宝珠！快去使用它！",
	OrbYell3		= "又有一颗宝珠准备好了！快点行动！",
	OrbYell4		= "这是我所能做的一切了！力量现在掌握在你们的手中！"
}
