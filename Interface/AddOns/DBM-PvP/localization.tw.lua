if GetLocale() ~= "zhTW" then return end
local L
--Last update: 2020/07/03 （重新整理）
--------------------------
--  General BG Options  --
--------------------------
L = DBM:GetModLocalization("PvPGeneral")

L:SetGeneralLocalization({
	name	= "基本選項"
})

L:SetTimerLocalization({
	TimerCap		= "%s",
	TimerFlag		= "旗幟重生",
	TimerInvite		= "%s",
	TimerRemaining	= "剩餘時間: ",
	TimerShadow		= "暗影視界"
})

L:SetOptionLocalization({
	AutoSpirit			= "自動釋放靈魂",
	ColorByClass		= "在得分視窗中設置玩家名為職業顏色",
	HideBossEmoteFrame	= "在戰場時隱藏團隊首領表情框架&要塞/公會提示",
	ShowBasesToWin		= "顯示勝利需要的基地數量",
	ShowEstimatedPoints	= "顯示戰鬥結束時雙方資源預計值",
	ShowFlagCarrier		= "顯示旗幟攜帶者",
	TimerCap			= "顯示奪取計時器",
	TimerFlag			= "顯示旗幟重生計時器",
	TimerInvite			= "顯示戰場組隊計時器",
	TimerRemaining		= "顯示比賽開始和比賽結束的剩餘時間",
	TimerShadow			= "顯示暗影視界計時器",
	TimerWin			= "顯示勝利計時器",
	ShowRelativeGameTime= "相對於BG開始時間的獲勝計時器（如果禁用，則欄總是看起來滿了）"
})

L:SetMiscLocalization({
	BgStart60           = "戰鬥將在1分鐘內開始。",
	BgStart30           = "戰鬥將在30秒鐘內開始。做好準備!",
	ArenaInvite			= "競技場邀請",
	BasesToWin			= "勝利需要基地: %d",
	WinBarText			= "%s 勝利",
	-- TODO: Implement the flag carrying system
	FlagReset			= "旗幟已重置！",
	FlagTaken			= "(.+) 佔據了旗幟！",
	FlagCaptured		= " .+ ha%w+ 佔據旗幟！",
	FlagDropped			= "旗幟已經掉落！",
	--
	ExprFlagPickUp		= " (%w+) 的旗幟。被 (.+) 拔掉了！",
	ExprFlagCaptured	= "(.+) 佔據了 (%w+) 的旗幟！",
	ExprFlagReturn		= " (%w+) 的旗幟，被 (.+) 還到了它的基地",
	Vulnerable1			= "旗幟攜帶者變得脆弱了！",
	Vulnerable2			= "旗幟攜帶者變得更加的脆弱了！"
})

----------------------
--  Seething Shore  --
----------------------
L = DBM:GetModLocalization("z1803")

L:SetOptionLocalization({
	TimerSpawn	= "顯示戰場計時器"
})

----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("z30")

L:SetOptionLocalization({
	AutoTurnIn	= "自動繳交任務物品"
})

--------------
--  Ashran  --
--------------
L = DBM:GetModLocalization("z1191")

L:SetOptionLocalization({
	AutoTurnIn	= "自動繳交任務物品"
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("z628")

L:SetWarningLocalization({
	WarnSiegeEngine		= "攻城機具準備好了！",
	WarnSiegeEngineSoon	= "0秒後 攻城機具"
})

L:SetTimerLocalization({
	TimerSiegeEngine	= "攻城機具修復"
})

L:SetOptionLocalization({
	TimerSiegeEngine	= "為攻城機具的修復顯示計時器",
	WarnSiegeEngine		= "當攻城機具準備好時顯示警告",
	WarnSiegeEngineSoon	= "當攻城機具接近準備好時顯示警告",
	ShowGatesHealth		= "顯示受損大門的耐久值(當加入一個正在進行的戰場大門耐久值可能會不準確！)"
})

L:SetMiscLocalization({
	GatesHealthFrame		= "受損的大門",
	SiegeEngine				= "攻城機具",
	GoblinStartAlliance		= "看到那些爆鹽炸彈了嗎?當我維修攻城機具的時候用它們來轟破大門！",
	GoblinStartHorde		= "修理攻城機具的工作就交給我，幫我看著點就夠了。如果你想要轟破大門的話，儘管把那些爆鹽炸彈拿去用吧！",
	GoblinHalfwayAlliance	= "我已經修好一半了!別讓部落靠近。工程學院可沒有教我們如何作戰喔！",
	GoblinHalfwayHorde		= "我已經修好一半了!別讓聯盟靠近 - 我的合約裡可沒有作戰這一條！",
	GoblinFinishedAlliance	= "我有史以來最得意的作品!這台攻城機具已經可以上場囉！",
	GoblinFinishedHorde		= "這台攻城機具已經可以上場啦！",
	GoblinBrokenAlliance	= "這麼快就壞啦?!別擔心，再壞的情況我都可以修得好。",
	GoblinBrokenHorde		= "又壞掉了嗎?!讓我來修理吧…但別指望產品的保固會幫你支付這一切。"
})

-------------------------
--  Silvershard Mines  --
-------------------------
L = DBM:GetModLocalization("z727")

L:SetTimerLocalization({
	TimerRespawn	= "礦坑推車"
})

L:SetOptionLocalization({
	TimerRespawn	= "礦坑推車重生",
	TimerCart		= "顯示礦坑推車重生計時器"
})

L:SetMiscLocalization({
	Capture	= "奪走了",
	Arrived	= "到達了",
	Begun	= "開始了"
})

-------------------------
--  Temple of Kotmogu  --
-------------------------
L = DBM:GetModLocalization("z998")

L:SetOptionLocalization({
	ShowOrbCarriers	= "顯示資源"
})

L:SetMiscLocalization({
	OrbTaken	= "(%S+) 奪走了 (%S+) 異能球！",
	OrbReturn	= " (%S+) 異能球已回到初始位置！"
})
