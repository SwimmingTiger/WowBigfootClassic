if GetLocale() ~= "zhCN" then return end
local L

-----------------
--  Razorgore  --
-----------------
L = DBM:GetModLocalization("Razorgore")

L:SetGeneralLocalization{
	name = "狂野的拉佐格尔"
}
L:SetTimerLocalization{
	TimerAddsSpawn	= "小怪重生"
}
L:SetOptionLocalization{
	TimerAddsSpawn	= "为第一次小怪重生显示计时器"
}
L:SetMiscLocalization{
	Phase2Emote	= "失去能量，停止运作!",
	YellPull 	= "入侵者闯入孵化室了!警报!不惜一切代价保护蛋!"
}
-------------------
--  Vaelastrasz  --
-------------------
L = DBM:GetModLocalization("Vaelastrasz")

L:SetGeneralLocalization{
	name	= "堕落的瓦拉斯塔茲"
}

L:SetMiscLocalization{
	Event	= "太迟了，朋友! 奈法利斯的腐化已经掌握了我...我已经无法...控制我自己了。"
}
-----------------
--  Broodlord  --
-----------------
L = DBM:GetModLocalization("Broodlord")

L:SetGeneralLocalization{
	name	= "勒什雷尔"
}

L:SetMiscLocalization{
	Pull	= "你怎么进来的?你们这种生物不能进来!我要毁灭你们!"
}

---------------
--  Firemaw  --
---------------
L = DBM:GetModLocalization("Firemaw")

L:SetGeneralLocalization{
	name = "费尔默"
}

---------------
--  Ebonroc  --
---------------
L = DBM:GetModLocalization("Ebonroc")

L:SetGeneralLocalization{
	name = "埃博诺克"
}

----------------
--  Flamegor  --
----------------
L = DBM:GetModLocalization("Flamegor")

L:SetGeneralLocalization{
	name = "弗莱格尔"
}

------------------
--  Chromaggus  --
------------------
L = DBM:GetModLocalization("Chromaggus")

L:SetGeneralLocalization{
	name = "克洛玛古斯"
}
L:SetWarningLocalization{
	WarnBreath		= "%s"
}
L:SetTimerLocalization{
	TimerBreathCD	= "%s冷却"
}
L:SetOptionLocalization{
	WarnBreath		= "为克洛玛古斯其中一格吐息显示警告",
	TimerBreathCD	= "显示吐息冷却"
}
L:SetMiscLocalization{
	Breath1	= "第一次吐息",
	Breath2	= "第二次吐息"
}

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-Classic")

L:SetGeneralLocalization{
	name = "奈法利安"
}
L:SetWarningLocalization{
	WarnClassCall		= "%s呼喊",
	WarnPhase			= "第%s阶段"
}
L:SetTimerLocalization{
	TimerClassCall		= "%s呼喊"
}
L:SetOptionLocalization{
	TimerClassCall		= "为职业呼喊持续时间显示计时器",
	WarnClassCall		= "提示职业呼喊",
	WarnPhase			= "提示转换阶段"
}
L:SetMiscLocalization{
	YellP2		= "干得好，我的手下。凡人的勇气开始消退!现在，现在让我们看看他们如何应对黑石之王的力量!!!",
	YellP3		= "不可能!出现吧，我的仆人!再次为我的主人服务!",
	YellShaman	= "萨满，让我看看",
	YellPaladin	= "圣骑士...听说你有无数条命。让我看看到底是怎么样的吧。",
	YellDruid	= "德鲁伊和你们愚蠢的变身术。让我们看看什么会发生吧!",
	YellPriest	= "牧师!如果你要继续像那样治疗，我们还不如让它看起来更有趣!",
	YellWarrior	= "战士，我知道你的力量不只如此!让我们来见识一下吧!",
	YellRogue	= "潜行者?不要躲了，面对我吧!",
	YellWarlock	= "术士，不要随便去玩那些你不理解的法术。看看会发生什么吧?",
	YellHunter	= "猎人和你那讨厌的豌豆射击!",
	YellMage	= "还有法师?你应该小心使用你的魔法...",
	YellDK		= "死亡骑士士们...来这。",
	YellMonk	= "武僧???...又是什么???"
}