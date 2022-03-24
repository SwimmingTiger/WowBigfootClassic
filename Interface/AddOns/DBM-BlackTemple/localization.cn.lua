-- yleaf(yaroot@gmail.com)
-- Mini Dragon(projecteurs@gmail.com)
-- Last update: 2022/01/21

if GetLocale() ~= "zhCN" then return end
local L

-----------------
--  Najentus  --
-----------------
L = DBM:GetModLocalization("Najentus")

L:SetGeneralLocalization{
	name = "高阶督军纳因图斯"
}

L:SetMiscLocalization{
	HealthInfo	= "血量信息"
}

----------------
-- Supremus --
----------------
L = DBM:GetModLocalization("Supremus")

L:SetGeneralLocalization{
	name = "苏普雷姆斯"
}

L:SetWarningLocalization{
	WarnPhase		= "%s 阶段",
}

L:SetTimerLocalization{
	TimerPhase		= "下一次 %s 阶段"
}

L:SetOptionLocalization{
	WarnPhase		= "为下一次阶段显示警告",
	TimerPhase		= "为下一次阶段显示计时器",
	KiteIcon		= "为注视的目标设置标记"
}

L:SetMiscLocalization{
	PhaseTank		= "苏普雷姆斯愤怒地击打着地面！",
	PhaseKite		= "地面崩裂了！",
	ChangeTarget	= "锁定了一个新目标！",
	Kite			= "风筝",
	Tank			= "坦克"
}

-------------------------
--  Shape of Akama  --
-------------------------
L = DBM:GetModLocalization("Akama")

L:SetGeneralLocalization{
	name = "阿卡玛之影"
}

-------------------------
--  Teron Gorefiend  --
-------------------------
L = DBM:GetModLocalization("TeronGorefiend")

L:SetGeneralLocalization{
	name = "塔隆·血魔"
}

L:SetTimerLocalization{
	TimerVengefulSpirit		= "死亡之影 : %s"
}

L:SetOptionLocalization{
	TimerVengefulSpirit		= "为死亡之影显示持续时间"
}

L:SetMiscLocalization{
}

----------------------------
--  Gurtogg Bloodboil  --
----------------------------
L = DBM:GetModLocalization("Bloodboil")

L:SetGeneralLocalization{
	name = "古尔图格·血沸"
}

--------------------------
--  Essence Of Souls  --
--------------------------
L = DBM:GetModLocalization("Souls")

L:SetGeneralLocalization{
	name = "灵魂之匣"
}

L:SetWarningLocalization{
	WarnMana		= "30秒后法力消耗殆尽"
}

L:SetTimerLocalization{
	TimerMana		= "法力吸取"
}

L:SetOptionLocalization{
	WarnMana		= "在第2阶段显示法力吸取警告",
	TimerEnrage		= "显示法力吸取计时器"
}

L:SetMiscLocalization{
	Suffering		= "苦痛精华",
	Desire			= "欲望精华",
	Anger			= "愤怒精华",
	Phase1End		= "我不想回去！",
	Phase2End		= "我不会离开太远！"
}

-----------------------
--  Mother Shahraz --
-----------------------
L = DBM:GetModLocalization("Shahraz")

L:SetGeneralLocalization{
	name = "莎赫拉丝主母"
}

L:SetTimerLocalization{
	timerAura	= "%s"
}

L:SetOptionLocalization{
	timerAura	= "为致命吸引显示计时器"
}

----------------------
--  Illidari Council  --
----------------------
L = DBM:GetModLocalization("Council")

L:SetGeneralLocalization{
	name = "伊利达雷议会"
}

L:SetWarningLocalization{
	Immune			= "玛兰德 - %s 免疫15秒"
}

L:SetOptionLocalization{
	Immune			= "当玛兰德法术和近战免疫时显示警告"
}

L:SetMiscLocalization{
	Gathios			= "击碎者加西奥斯",
	Malande			= "女公爵玛兰德",
	Zerevor			= "高阶灵术师塞勒沃尔",
	Veras			= "薇尔莱丝·深影",
	Melee			= "近战",
	Spell			= "法术"
}

-------------------------
--  Illidan Stormrage --
-------------------------
L = DBM:GetModLocalization("Illidan")

L:SetGeneralLocalization{
	name = "伊利丹·怒风"
}

L:SetWarningLocalization{
	WarnHuman		= "人形阶段",
	WarnDemon		= "恶魔阶段"
}

L:SetTimerLocalization{
	TimerNextHuman		= "下一次人形阶段",
	TimerNextDemon		= "下一次恶魔阶段"
}

L:SetOptionLocalization{
	WarnHuman		= "为人形阶段显示警告",
	WarnDemon		= "为恶魔阶段显示警告",
	TimerNextHuman	= "显示下一次人形阶段计时器",
	TimerNextDemon	= "显示下一次恶魔阶段计时器",
	RangeFrame		= "为3阶段和4阶段显示10码距离提示"
}

L:SetMiscLocalization{
	Pull			= "阿卡玛。你的两面三刀并没有让我感到意外。我早就应该把你和你那些畸形的同胞全部杀掉。",
	Eyebeam			= "直视背叛者的双眼吧！",
	Demon			= "感受我体内的恶魔之力吧！",
	Phase4			= "你们就这点本事吗？这就是你们全部的能耐？"
}
