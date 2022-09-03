-- author: callmejames @《凤凰之翼》 一区藏宝海湾
-- commit by: yaroot <yaroot AT gmail.com>
-- modified by: Diablohu < 178.com / ngacn.cc / dreamgen.cn >


if GetLocale() ~= "zhCN" then return end

local L

-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name 				= "烈焰巨兽"
}

L:SetTimerLocalization{
}

L:SetMiscLocalization{
	YellPull			= "检测到敌对实体。威胁评定协议启动。向主要目标发动攻击。30秒后重新评估。",
	Emote				= "%%s开始追赶(%S+)%。"
}

L:SetWarningLocalization{
	PursueWarn			= "追踪 -> >%s<",
	warnNextPursueSoon		= "5秒后 更换目标",
	SpecialPursueWarnYou		= "你被追踪 - 快跑",
	warnWardofLife			= "生命结界 出现"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音",
	SpecialPursueWarnYou		= "当你被追踪时显示特别警报",
	PursueWarn			= "提示追踪的目标",
	warnNextPursueSoon		= "为下一次追踪显示提前警报",
	warnWardofLife			= "为生命结界出现显示特别警报"
}

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name 				= "掌炉者伊格尼斯"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name 				= "锋鳞"
}

L:SetWarningLocalization{
	warnTurretsReadySoon		= "20秒后 最后一座炮塔完成",
	warnTurretsReady		= "最后一座炮塔已完成",
	SpecWarnDevouringFlameCast	= "你中了噬体烈焰",
	WarnDevouringFlameCast		= "噬体烈焰 -> >%s<"
}

L:SetTimerLocalization{
	timerTurret1			= "炮塔1",
	timerTurret2			= "炮塔2",
	timerTurret3			= "炮塔3",
	timerTurret4			= "炮塔4",
	timerGrounded			= "地面阶段"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音",
	warnTurretsReadySoon		= "为炮塔显示提前警报",
	warnTurretsReady		= "为炮塔显示警报",
	SpecWarnDevouringFlameCast	= "当你中了$spell:64733时显示特别警报",
	timerTurret1			= "为炮塔1显示计时条",
	timerTurret2			= "为炮塔2显示计时条",
	timerTurret3			= "为炮塔3显示计时条 (25人)",
	timerTurret4			= "为炮塔4显示计时条 (25人)",
	OptionDevouringFlame		= "提示$spell:64733的目标 (不准确)",
	timerGrounded			= "为地面阶段显示计时条"
}

L:SetMiscLocalization{
	YellAir				= "给我们一点时间，做好建筑炮台的准备。",
	YellAir2			= "火灭了！准备重建炮台！",
	YellGround			= "快一点！她马上就要挣脱了！",
	EmotePhase2			= "%%s被永久地禁锢在地面上！",
	FlamecastUnknown		= DBM_COMMON_L.UNKNOWN
}

----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "XT-002拆解者"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音"
}

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "钢铁议会"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音",
	AlwaysWarnOnOverload		= "总是对$spell:63481显示警报(否则只有当目标是唤雷者的时候显示)"
}

L:SetMiscLocalization{
	Steelbreaker			= "断钢者",
	RunemasterMolgeim		= "符文大师莫尔基姆",
	StormcallerBrundir 		= "唤雷者布隆迪尔"
}

----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name 				= "观察者奥尔加隆"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "下一次 坍缩星",
	TimerCombatStart		= "战斗开始"
}

L:SetWarningLocalization{
	WarningPhasePunch		= "相位冲压 -> >%s< - 第%d层",
	WarnPhase2Soon			= "第2阶段 即将到来",
	warnStarLow			= "坍缩星血量低"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音",
	WarningPhasePunch		= "提示相位冲压的目标",
	NextCollapsingStar		= "为下一次坍缩星显示计时条",
	TimerCombatStart		= "为战斗开始显示计时条",
	WarnPhase2Soon			= "为第2阶段显示提前警报 (大约23%)",
	warnStarLow			= "当坍缩星血量低(大约25%)时显示特别警报"
}

L:SetMiscLocalization{
	YellPull			= "你们的行动不合逻辑。这场战斗所有可能产生的结果都已被计算在内。无论结果如何，万神殿都会收到观察者发出的信息。",
	YellKill			= "我曾经看过尘世沉浸在造物者的烈焰之中，众生连一声悲泣都无法呼出，就此凋零。整个星系在弹指之间历经了毁灭与重生。然而在这段历程之中，我的心却无法感受到丝毫的…恻隐之念。我‧感‧受‧不‧到。成千上万的生命就这么消逝。他们是否拥有与你同样坚韧的生命?他们是否与你同样热爱生命?",
	Emote_CollapsingStar		= "%s开始召唤坍缩星！",
	Phase2				= "瞧瞧泰坦造物的能耐吧!",
	PullCheck			= "奥尔加隆发送危险信号的倒计时 = (%d+)分钟。"
}

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name 				= "科隆加恩"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	timerLeftArm			= "左臂重生",
	timerRightArm			= "右臂重生",
	achievementDisarmed		= "成就计时：断其臂膀"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音",
	timerLeftArm			= "为左臂重生显示计时条",
	timerRightArm			= "为右臂重生显示计时条",
	achievementDisarmed		= "为成就：断其臂膀显示计时条",
	YellOnBeam			= "当你中了$spell:63346时大喊"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left		= "不疼不痒！",
	Yell_Trigger_arm_right		= "只是轻伤而已！",
	Health_Body			= "科隆加恩身体",
	Health_Right_Arm		= "右臂",
	Health_Left_Arm			= "左臂",
	FocusedEyebeam			= "在注视着你",
	YellBeam			= "科隆加恩正在注视我！"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name 				= "欧尔莉亚"
}

L:SetMiscLocalization{
	Defender 			= "野性防御者(%d)",
	YellPull 			= "有些东西，最好永远都不去碰！"
}

L:SetTimerLocalization{
	timerDefender			= "野性防御者复活"
}

L:SetWarningLocalization{
	WarnCatDied 			= "野性防御者倒下(剩余%d只)",
	WarnCatDiedOne 			= "野性防御者倒下(剩下最后一只)"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音",
	WarnCatDied			= "当野性防御者死亡时显示警报",
	WarnCatDiedOne			= "当野性防御者剩下最后一只时显示警报",
	timerDefender       		= "当野性防御者准备复活时显示计时条"
}

-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name 				= "霍迪尔"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音",
	YellOnStormCloud		= "当你中了$spell:65133时大喊"
}

L:SetMiscLocalization{
	YellKill			= "我……我终于从他的魔掌中……解脱了。",
	YellCloud			= "我中了风暴雷云 快接近我！"
}

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name 				= "托里姆"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	TimerHardmode			= "困难模式"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音",
	TimerHardmode			= "为困难模式显示计时条",
	AnnounceFails			= "公布中了闪电充能的玩家到团队频道<br/>(需要团长或助理权限)"
}

L:SetMiscLocalization{
	YellPhase1			= "入侵者！你们这些凡人竟敢坏了我的兴致，看我怎么……等等，你们……",
	YellPhase2			= "狂妄的小崽子们，竟敢在我的地盘上挑战我？我要亲自碾碎你们！",
	YellKill			= "住手！我认输了！",
	ChargeOn			= "闪电充能 -> %s",
	Charge				= "中了闪电充能(这一次): %s"
}

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name 				= "弗蕾亚"
}

L:SetMiscLocalization{
	SpawnYell			= "孩子们，帮帮我！",
	WaterSpirit			= "古代水之精魂",
	Snaplasher			= "迅疾鞭笞者",
	StormLasher			= "风暴鞭笞者",
	TreeYell      = "|cFF00FFFF生命缚誓者的礼物|r开始生长！",
	YellKill			= "他对我的控制已经不复存在了。我又一次恢复了理智。谢谢你们，英雄们。",
	TrashRespawnTimer		= "弗蕾亚的小怪重生"
}

L:SetWarningLocalization{
	WarningTree   		= "艾欧娜尔的礼物出现 - 立刻攻击",
	WarnSimulKill			= "第一只元素死亡 - 约12秒后复活"
}

L:SetTimerLocalization{
	TimerSimulKill			= "复活"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音",
	WarningTree   		= "当首领召唤艾欧娜尔的礼物时显示特别警告",
	WarnSimulKill			= "提示第一只元素死亡",
	TimerSimulKill			= "为三元素复活显示计时条"
}

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name 				= "弗蕾亚的长者"
}

L:SetMiscLocalization{
	TrashRespawnTimer		= "弗蕾亚的小怪重生"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音",
	TrashRespawnTimer		= "为弗蕾亚的小怪重生显示计时条"
}

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name 				= "米米尔隆"
}

L:SetWarningLocalization{
	MagneticCore			= ">%s< 拿到了磁核",
	WarningShockBlast		= "震荡冲击 - 立刻跑开",
	WarnBombSpawn			= "炸弹机器人出现了"
}

L:SetTimerLocalization{
	TimerHardmode			= "困难模式 - 自毁程序",
	TimeToPhase2			= "第2阶段开始",
	TimeToPhase3			= "第3阶段开始",
	TimeToPhase4			= "第4阶段开始"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音",
	TimeToPhase2			= "为第2阶段开始显示计时条",
	TimeToPhase3			= "为第3阶段开始显示计时条",
	TimeToPhase4			= "为第4阶段开始显示计时条",
	MagneticCore			= "提示磁核的拾取者",
	WarnBombSpawn			= "为炸弹机器人显示警报",
	TimerHardmode			= "为困难模式显示计时条",
	ShockBlastWarningInP1		= "为第1阶段的$spell:63631显示特别警报",
	ShockBlastWarningInP4		= "为第4阶段的$spell:63631显示特别警报"
}

L:SetMiscLocalization{
	MobPhase1			= "巨兽二型",
	MobPhase2			= "VX-001",
	MobPhase3			= "空中指挥单位",
	YellPull			= "我们时间不多了，朋友们！来帮忙测试一下我所发明的最新型、最强大的机体吧。在你们改变主意之前，请允许我提醒一下，你们把XT-002搞得一团糟，应该算是欠我个人情吧。",
	YellHardPull			= "嘿，你们为什么要这么做啊？没看到上面写着“不要按这个按钮”吗？你们激活了自毁系统，还怎么完成测试呀？",
	LootMsg				= "(.+)获得了物品：.*Hitem:(%d+)"
}

---------------------
--  General Vezax  --
---------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name 				= "维扎克斯将军"
}

L:SetTimerLocalization{
	hardmodeSpawn 			= "萨隆邪铁畸体 出现"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash	= "你中了暗影冲撞 - 立刻跑开",
	SpecialWarningShadowCrashNear	= "你附近有人中暗影冲撞 - 立刻远离",
	SpecialWarningLLNear		= "你附近的%s中了无面者的印记"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音",
	SpecialWarningShadowCrash	= "为$spell:62660显示特别警报(必须至少有一名团队成员设置首领为焦点目标)",
	SpecialWarningShadowCrashNear	= "当你附近的人中了$spell:62660时显示特别警报",
	SpecialWarningLLNear		= "当你附近的人中了$spell:63276时显示特别警报",
	YellOnLifeLeech			= "当你中了$spell:63276时大喊",
	YellOnShadowCrash		= "当你中了$spell:62660时大喊",
	hardmodeSpawn			= "为萨隆邪铁畸体出现显示计时条 (困难模式)",
	CrashArrow			= "当你附近的人中了$spell:62660时显示DBM箭头",
	BypassLatencyCheck		= "不对$spell:62660使用同步延迟查询<br/>(只有出现问题时才使用这个)"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors		= "一团萨隆邪铁蒸汽在附近聚集起来！",
	YellLeech			= "我中了无面者的印记 - 远离我",
	YellCrash			= "我中了暗影冲撞 - 远离我"
}

------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name 				= "尤格萨隆"
}

L:SetMiscLocalization{
	YellPull 			= "攻击这头野兽要害的时刻即将来临！将你们的愤怒和仇恨倾泻到它的爪牙身上！",
	YellPhase2			= "我是清醒的梦境。",
	Sara 				= "萨拉"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 		= "尤格萨隆的卫士 %d 出现了",
	WarningCrusherTentacleSpawned	= "重压触须 出现了",
	WarningSanity 			= "剩余理智：%d",
	SpecWarnSanity 			= "剩余理智：%d",
	SpecWarnGuardianLow		= "停止攻击这只守护者",
	SpecWarnMadnessOutNow		= "疯狂诱导即将结束 - 立刻传送出去",
	WarnBrainPortalSoon		= "3秒后 脑部传送门",
	SpecWarnFervor			= "你中了萨拉的热情",
	SpecWarnFervorCast		= "萨拉的热情正在对你施放",
	specWarnBrainPortalSoon		= "脑部传送门 即将出现"
}

L:SetTimerLocalization{
	NextPortal			= "下一次 脑部传送门"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音",
	WarningGuardianSpawned		= "为尤格萨隆的卫士出现显示警报",
	WarningCrusherTentacleSpawned	= "为重压触须出现显示警报",
	WarningSanity			= "当理智剩下50时显示警报",
	SpecWarnSanity			= "当理智过低(25,15,5)时显示特别警报",
	SpecWarnGuardianLow		= "当尤格萨隆的卫士(第1阶段)血量过低时显示特别警报 (输出职业用)",
	WarnBrainPortalSoon		= "为脑部传送门显示提前警报",
	SpecWarnMadnessOutNow		= "为疯狂诱导结束前显示特别警报",
	SpecWarnFervorCast		= "当萨拉的热情正在对你施放时显示特别警报 (必须至少有一名团队成员设置首领为焦点目标)",
	specWarnBrainPortalSoon		= "为下一次脑部传送门显示特别警报",
	NextPortal			= "为下一次传送门显示计时条",
	MaladyArrow			= "当你附近的人中了$spell:63881时显示DBM箭头"
}
