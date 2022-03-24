if GetLocale() ~= "zhCN" then return end
local L
--Last update: 2022/01/31（重新整理）
--------------------------
--  General BG Options  --
--------------------------
L = DBM:GetModLocalization("PvPGeneral")

L:SetGeneralLocalization({
	name	= "常规设置"
})

L:SetTimerLocalization({
	TimerCap		= "%s",
	TimerFlag		= "重置",
	TimerInvite		= "%s",
	TimerRemaining	= "剩余时间: ",
	TimerShadow		= "暗影之眼"
})

L:SetOptionLocalization({
	AutoSpirit			= "自动释放灵魂",
	ColorByClass		= "得分板上玩家按职业着色",
	HideBossEmoteFrame	= "在战场时隐藏团队首领表情框体/公会信息等",
	ShowBasesToWin		= "显示获胜需要占领的资源点",
	ShowEstimatedPoints	= "显示战斗开始/结束时双方资源统计",
	ShowFlagCarrier		= "显示旗帜携带者",
	TimerCap			= "计时条：占领资源",
	TimerFlag			= "计时条：旗帜重置",
	TimerInvite			= "计时条：进入战场",
	TimerRemaining		= "计时条：比赛开始和结束的剩余时间",
	TimerShadow			= "计时条：暗影之眼",
	TimerWin			= "计时条：胜利时间",
	ShowRelativeGameTime= "计时条：战场开始到获胜的计时（如果禁用，则计时条总是看起来满了）"
})

L:SetMiscLocalization({
	BgStart60           = "战斗将在1分钟内开始。",
	BgStart30           = "战斗将在30秒钟内开始。做好准备！",
	ArenaInvite			= "竞技场邀请",
	BasesToWin			= "胜利需要占领资源点: %d",
	WinBarText			= "%s 获胜",
	-- TODO: Implement the flag carrying system
	FlagReset			= "旗帜被重新放置了！",
	FlagTaken			= "(.+) 夺走了旗帜！",
	FlagCaptured		= " .+ ha%w+ 夺得了旗帜！",
	FlagDropped			= "旗帜被扔掉了！",
	--
	ExprFlagPickUp		= " (%w+) 的旗帜。被 (.+) 拔起了！",
	ExprFlagCaptured	= "(.+) 夺取了 (%w+) 的旗帜！",
	ExprFlagReturn		= " (%w+) 的旗帜！被 (.+) 还到了它的基地中！",
	Vulnerable1			= "旗帜携带者已变的容易受到攻击！",
	Vulnerable2			= "旗帜携带者越来越容易受到攻击！"
})

----------------------
--  Seething Shore  --
----------------------
L = DBM:GetModLocalization("z1803")

L:SetTimerLocalization({
	TimerSpawn		= "%s"
})

L:SetOptionLocalization({
	TimerSpawn	= "显示艾泽里特矿产计时器"
})

----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("z30")

L:SetOptionLocalization({
	AutoTurnIn	= "自动递交任务物品"
})

--------------
--  Ashran  --
--------------
L = DBM:GetModLocalization("z1191")

L:SetOptionLocalization({
	AutoTurnIn	= "自动递交任务物品"
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("z628")

L:SetWarningLocalization({
	WarnSiegeEngine		= "攻城机具准备好了！",
	WarnSiegeEngineSoon	= "10秒后 攻城机具就绪"
})

L:SetTimerLocalization({
	TimerSiegeEngine	= "攻城机具修复"
})

L:SetOptionLocalization({
	TimerSiegeEngine	= "计时条：攻城器的建造",
	WarnSiegeEngine		= "警报：攻城器准备就绪",
	WarnSiegeEngineSoon	= "预警：攻城器准备就绪",
	ShowGatesHealth		= "生命值框：城门破损状况（中途加入战场，该数据可能不准确）"
})

L:SetMiscLocalization({
	GatesHealthFrame		= "城门破损状况",
	SiegeEngine				= "攻城器",
	GoblinStartAlliance		= "看到那些爆盐炸弹了吗？当我维修攻城机具的时候用它们来轰破大门！",
	GoblinStartHorde		= "修理攻城机具的工作就交给我，帮我看着点就够了。如果你想要轰破大门的话，尽管把那些爆盐炸弹拿去用吧！",
	GoblinHalfwayAlliance	= "我已经修好一半了！别让部落靠近。工程学院可没有教我们如何作战喔！",
	GoblinHalfwayHorde		= "我已经修好一半了！别让联盟靠近 - 我的合约里可没有作战这一条！",
	GoblinFinishedAlliance	= "我有史以来最得意的作品！这台攻城机具已经可以上场啰！",
	GoblinFinishedHorde		= "这台攻城机具已经可以上场啦！",
	GoblinBrokenAlliance	= "这么快就坏啦？！别担心，再坏的情况我都可以修得好。",
	GoblinBrokenHorde		= "又坏掉了吗？！让我来修理吧……但别指望产品的保固会帮你支付这一切。"
})

-------------------------
--  Silvershard Mines  --
-------------------------
L = DBM:GetModLocalization("z727")

L:SetTimerLocalization({
	TimerRespawn	= "矿车刷新",
	TimerCart		= "%s"
})

L:SetOptionLocalization({
	TimerRespawn	= "显示矿车刷新计时",
	TimerCart		= "计时条：矿车刷新"
})

L:SetMiscLocalization({
	Capture	= "已控制",
	Arrived	= "已到达",
	Begun	= "已经开始"
})

-------------------------
--  Temple of Kotmogu  --
-------------------------
L = DBM:GetModLocalization("z998")

L:SetOptionLocalization({
	ShowOrbCarriers	= "显示框体"
})

L:SetMiscLocalization({
	OrbTaken	= "(%S+) 取走了 (%S+) 的球！",
	OrbReturn	= " (%S+) 宝珠被放回了！"
})
