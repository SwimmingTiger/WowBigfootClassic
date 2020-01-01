---
--- 由60addons创建并汉化(https://60addons.com)

if (GetLocale() ~= "zhCN") then
    return
end

local L = WebDKP.translations

--中文职业简称
L.CLASS_ALIAS_TO_ENG_MAP["LR"] = "hunter"
L.CLASS_ALIAS_TO_ENG_MAP["QS"] = "paladin"
L.CLASS_ALIAS_TO_ENG_MAP["ZS"] = "warrior"
L.CLASS_ALIAS_TO_ENG_MAP["FS"] = "mage"
L.CLASS_ALIAS_TO_ENG_MAP["SS"] = "warlock"
L.CLASS_ALIAS_TO_ENG_MAP["SM"] = "shaman"
L.CLASS_ALIAS_TO_ENG_MAP["DZ"] = "rogue"
L.CLASS_ALIAS_TO_ENG_MAP["MS"] = "priest"
L.CLASS_ALIAS_TO_ENG_MAP["XD"] = "druid"

--小地图右键

L.WEBDKP_MINIMAPDROPDOWN_OPTIONS = "设置"
L.WEBDKP_MINIMAPDROPDOWN_HELP = "新手帮助"

--DKP表标头
L.WEBDKP_HEADER = "DKP 表:"
L.WEBDKP_FRAME_NAME_COLUMN = "名字"
L.WEBDKP_FRAME_CLASS_COLUMN = "职业"
L.WEBDKP_FRAME_DKP_COLUMN = "DKP"
L.WEBDKP_FRAME_GUILDRANK_COLUMN = "状态"

--DKP表选项卡
L.TAB_FILTER = "过滤"
L.TAB_AWARD_DKP = "奖惩"
L.TAB_AWARD_ITEM = "物品"
L.TAB_STANDBY = "替补"

--DKP表过滤项
L.FILTER_HEADER = "过滤:"
L.FILTER_CLASS_WARLOCK = "|cff9482C9术士|r"
L.FILTER_CLASS_WARRIOR = "|cffC79C6E战士|r"
L.FILTER_CLASS_HUNTER = "|cffABD473猎人|r"
L.FILTER_CLASS_MAGE = "|cff69CCF0法师|r"
L.FILTER_CLASS_PRIEST = "|cffFFFFFF牧师|r"
L.FILTER_CLASS_DRUID = "|cffFF7D0A德鲁伊|r"
L.FILTER_CLASS_PALADIN = "|cffF58CBA圣骑士|r"
L.FILTER_CLASS_SHAMAN = "|cff0099FF萨满祭司|r"
L.FILTER_CLASS_ROGUE = "|cffFFF569潜行者|r"

L.FILTER_CLASS_CASTERS = "远程法术"
L.FILTER_CLASS_MELEE = "物理近战"
L.FILTER_CLASS_HEALER = "治疗"
L.FILTER_CLASS_CHAIN = "锁甲"
L.FILTER_CLASS_CLOTH = "布甲"
L.FILTER_CLASS_LEATHER = "皮甲"
L.FILTER_CLASS_PLATE = "板甲"

L.FILTER_CHECK_ALL = "选取所有"
L.FILTER_UNCHECK_ALL = "取消所有"
L.FILTER_PLAYERS_IN_GROUP = "团内"
L.FILTER_STANDBY_PLAYERS = "替补"
L.FILTER_OTHERS_PLAYERS = "其他"

L.DKP_TABLE_SELECT_ALL = "选取所有"
L.DKP_TABLE_DESELECT_ALL = "取消所有"
L.DKP_TABLE_SAVE_LOG = "|cFF0dea38>保存数据文档<|r"
L.DKP_TABLE_Refresh = "刷新"

--奖惩选项卡
L.AWARD_DKP_HEADER = "奖惩DKP:"
L.AWARD_DKP_INFO1 = "先选取左侧的玩家\n然后输入DKP奖惩"
L.AWARD_DKP_DECAY_HEADER = "DKP百分比衰减:\n(仅适用于实施了\nDKP衰减制度的公会)"
L.AWARD_DKP_INFO3 = ""
L.AWARD_DKP_REASON_LABEL = "原因:"
L.AWARD_DKP_POINTS_LABEL = "点数: (使用负数为扣分)"
L.AWARD_DKP_AWARD_POINTS = "奖惩!"
L.AWARD_DKP_DECAY_LABEL = "衰减值:如(|cFF0dea38.4|r) 为衰减40%"
L.AWARD_DKP_DECAY_BUTTON = "衰减"

--奖惩物品选项卡
L.AWARD_ITEM_HEADER = "奖惩物品:"
L.AWARD_ITEM_INFO1 = "左边选取要奖惩的玩家\n 下放输入DKP信息"
L.AWARD_ITEM_ITEM_NAME_LABEL = "物品名:"
L.AWARD_ITEM_ITEM_COST_LABEL = "物品DKP: (只允许正数)"
L.AWARD_ITEM_ITEM_COST_LABEL2 = ""
L.AWARD_ITEM_AWARD_ITEM = "奖惩!"

--替补选项卡
L.STANDBY_HEADER = "替补玩家:"
L.STANDBY_INFO1 = "替补人员输入命令:|cFF0dea38我要替补|r\n或者:|cFF0dea38退出替补|r"
L.STANDBY_ADD_STANDBY_LABEL = "玩家名:"
L.STANDBY_ADD_TO_STANDBY = "添加"
L.STANDBY_DEL_STANDBY = "删除"
L.STANDBY_RESET_STANDBY = "重置"
L.STANDBY_ENABLE_STANDBY_ZEROSUM = "为替补玩家启用零和规则"
L.STANDBY_ENABLE_STANDBY_TIMED = "为替补玩家启用时间分奖励"

--竞拍页
L.BID_TITLE = "WebDKP 竞拍"
L.BID_ITEM_LABEL = "物品:"
L.BID_STARTING_BID_LABEL = "起始DKP:"
L.BID_TIME_LABEL = "竞拍/Roll时间:"
L.BID_TIME_HINT = "(秒 - 0为无限制)"
L.BID_BID_BUTTON = "开始竞拍!"
L.BID_ROLL_BUTTON = "开始Roll!"
L.BID_TOP3_BUTTON = "通知竞拍前3名"
L.Fiveseconds = "倒数5秒"
L.BIDCountdown = "竞拍倒数: "
L.BIDCountdowncancel = "取消倒数"
L.BID_TABLE_HEADER = "收到的竞拍/Rolls:"
L.BID_TABLE_COLUMN_NAME_LABEL = "名字"
L.BID_TABLE_COLUMN_BID_LABEL = "竞拍"
L.BID_TABLE_COLUMN_DKP_LABEL = "DKP"
L.BID_TABLE_COLUMN_POST_LABEL = "DKP - 竞拍"
L.BID_TABLE_COLUMN_ROLL_LABEL = "Rolls"
L.BID_TABLE_COLUMN_SPEC_LABEL = "主/副"
L.BID_TABLE_COLUMN_GUILD_RANK_LABEL = "公会会阶"
L.BID_AWARD = "奖惩装备"
L.FORMAT_MSG_ROLLING_PATTERN = "(.+)掷出(%d+)%（(%d+)%-(%d+)%）"


--时间分页
L.WEBDKP_TIMEDAWARDFRAME_TITLE = "时间分奖励"
L.WEBDKP_TIMEDAWARDFRAME_TEXT = "时间分奖励允许你为 DKP 设置一个时间自动奖励分"
L.WEBDKP_TIMEDAWARDFRAME_DKP_LABEL = "DKP:"
L.WEBDKP_TIMEDAWARDFRAME_TIME_LABEL = "时间:"
L.WEBDKP_TIMEDAWARDFRAME_TIME_HINT = "(分钟)"
L.WEBDKP_TIMEDAWARDFRAME_LOOPTIMER_LABEL = "重复奖励:"
L.WEBDKP_TIMEDAWARDFRAME_RESETBUTTON = "重置"
L.STANDBY_RESET_STANDBY_LABEL = "重置所有替补玩家:"
L.WEBDKP_TIMEDAWARDFRAME_STARTSTOPBUTTON = "开始"
L.WEBDKP_TIMEDAWARDFRAME_MINIBUTTON = "迷你计时器"

--设置页
L.WEBDKP_OPTIONSFRAME_TITLE = "WebDKP 设置"
--WebDKP_GeneralOptions_Frame
L.WEBDKP_GENERALOPTIONS_FRAME_TITLE = "一般设置:"
L.WEBDKP_GENERALOPTIONS_FRAME_INFO1 = "自动填充物品设置:"
L.WEBDKP_GENERALOPTIONS_FRAME_INFO2 = "零和DKP:"
L.WEBDKP_GENERALOPTIONS_FRAME_INFO3 = "自动Boss击杀奖励:(单个Boss分)"
L.WEBDKP_GENERALOPTIONS_FRAME_INFO4 = "启用/禁用WebDKP"
L.WEBDKP_GENERALOPTIONS_FRAME_INFO5 = "启用或禁用Alt+左键，弹出竞价窗口"
L.WEBDKP_GENERALOPTIONS_FRAME_INFO6 = "非队伍/团队玩家屏蔽私聊"
L.WEBDKP_GENERALOPTIONS_FRAME_INFO7 = "指定一个DKP封顶(任何到了该DKP的玩家将无法获得DKP)"
L.WEBDKP_GENERALOPTIONS_FRAME_INFO8 = "EP / GP:"
L.WEBDKP_GENERALOPTIONS_FRAME_TOGGLEAUTOFILLENABLED_LABEL = "自动填充物品名"
L.WEBDKP_GENERALOPTIONS_FRAME_TOGGLEAUTOAWARDENABLED_LABEL = "自动弹框启用"
L.WEBDKP_GENERALOPTIONS_FRAME_TOGGLEZEROSUMENABLED_LABEL = "零和模式启用"
L.WEBDKP_GENERALOPTIONS_FRAME_TOGGLEAWARDBOSSDKP_LABEL = "启用/禁用"
L.WEBDKP_GENERALOPTIONS_FRAME_TOGGLEALTCLICK_LABEL = "Alt+左键 启用"
L.WEBDKP_GENERALOPTIONS_FRAME_TOGGLEIGNWHISPERS_LABEL = "屏蔽 启用"
L.WEBDKP_GENERALOPTIONS_FRAME_TOGGLEDKPCAP_LABEL = "DKP封顶 启用"
L.WEBDKP_GENERALOPTIONS_FRAME_DKPCAPLIMIT_LABEL = "封顶限制:"
L.WEBDKP_GENERALOPTIONS_FRAME_BOSSDKP_LABEL = "DKP 数:"
L.WEBDKP_GENERALOPTIONS_FRAME_TOGGLEENABLED_LABEL = "WebDKP 启用"
L.WEBDKP_GENERALOPTIONS_FRAME_TOGGLEENABLED_LABEL = "WebDKP 启用"
--WebDKP_BiddingOptions_Frame
L.WEBDKP_BIDDINGOPTIONS_FRAME_INFO1 = "竞拍选项:"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLEBIDANNOUNCERAID_LABEL = "通告在团队警报"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLEBIDCONFIRMPOPUP_LABEL = "配置竞拍奖惩弹出"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLEBIDALLOWNEGATIVEBIDS_LABEL1 = "允许负DKP竞拍"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLEBIDALLOWNEGATIVEBIDS_LABEL2 = "(允许人们负数竞拍)"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLEBIDFIXEDBIDDING_LABEL1 = "使用固定DKP分数竞拍"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLEBIDFIXEDBIDDING_LABEL2 = "(从固定DKP列表中决定DKP分数)"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLEBIDNOTIFYLOWBIDS_LABEL1 = "当DKP低了通知竞拍者"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLEBIDNOTIFYLOWBIDS_LABEL2 = "(告诉他们现在你不是最高竞拍者了)"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLEAUTOGIVE_LABEL1 = "自动给予装备"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLEAUTOGIVE_LABEL2 = "(谨慎使用！自动给予装备)"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLETURNBASE_LABEL1 = "all in(梭哈)DKP"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLETURNBASE_LABEL2 = "同时启用在固定竞拍上"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLESILENTBIDDING_LABEL1 = "静默"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLESILENTBIDDING_LABEL2 = "不会宣布谁赢了"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLEBIDANDROLL_LABEL1 = "竞拍中监视Roll"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLEBIDANDROLL_LABEL2 = "专为副天赋装备检查"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLEALLNEED_LABEL1 = "启用需求百分比"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLEALLNEED_LABEL2 = "为'需求'启用用户定义的百分比"
L.WEBDKP_BIDDINGOPTIONS_FRAME_NEEDDKP_LABEL = "'需求' DKP %:"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLEFIFTYGREED_LABEL1 = "启用贪婪百分比"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLEFIFTYGREED_LABEL2 = "为'贪婪'启用用户定义的百分比"
L.WEBDKP_BIDDINGOPTIONS_FRAME_GREEDDKP_LABEL = "'贪婪' DKP %:"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLEDISABLEBID_LABEL1 = "禁用'出价'命令"
L.WEBDKP_BIDDINGOPTIONS_FRAME_TOGGLEDISABLEBID_LABEL2 = "用户禁用'出价', 强制使用'主天赋''副天赋'命令"
--WebDKP_AnnouncementsOptions_Frame
L.WEBDKP_ANNOUNCEMENTSOPTIONS_FRAME_INFO12 = "通告选项:"
L.WEBDKP_ANNOUNCEMENTSOPTIONS_FRAME_INFO13 = "自定义信息 - 开始竞拍"
L.WEBDKP_ANNOUNCEMENTSOPTIONS_FRAME_INFO14 = "自定义信息 - 竞拍期间"
L.WEBDKP_ANNOUNCEMENTSOPTIONS_FRAME_INFO15 = "自定义信息 - 结束竞拍"
L.WEBDKP_ANNOUNCEMENTSOPTIONS_FRAME_INFO16 = "自定义信息 - 开始Roll"
L.WEBDKP_ANNOUNCEMENTSOPTIONS_FRAME_INFO17 = "自定义信息 - Roll期间"
L.WEBDKP_ANNOUNCEMENTSOPTIONS_FRAME_INFO18 = "自定义信息 - 结束Roll"
L.WEBDKP_ANNOUNCEMENTSOPTIONS_FRAME_TOGGLEANNOUNCEMENTS_LABEL = "禁用所有公告"
L.WEBDKP_ANNOUNCEMENTSOPTIONS_FRAME_EDITSTARTANNOUNCE_LABEL = "$item = 物品, $time = 时间, $bid = 起始DKP"
L.WEBDKP_ANNOUNCEMENTSOPTIONS_FRAME_EDITDURINGANNOUNCE_LABEL = "$item = 物品, $time = 时间, $name = 名字, $dkp = DKP"
L.WEBDKP_ANNOUNCEMENTSOPTIONS_FRAME_EDITENDANNOUNCE_LABEL = "$item = 物品, $name = 名字, $dkp = DKP, $totbid = Tot. Bids"
L.WEBDKP_ANNOUNCEMENTSOPTIONS_FRAME_EDITSROLLANNOUNCE_LABEL = "$item = 物品, $time = 时间"
L.WEBDKP_ANNOUNCEMENTSOPTIONS_FRAME_EDITROLLANNOUNCE_LABEL = "$item = 物品, $time = 时间, $name = 名字, $roll = Roll"
L.WEBDKP_ANNOUNCEMENTSOPTIONS_FRAME_EDITEROLLANNOUNCE_LABEL = "$item = 物品, $name = 名字, $roll = Roll, $roltot = Tot. Rolls"

--设置页选项卡
L.WEBDKP_OPTIONSFRAME_TAB1 = "一般"
L.WEBDKP_OPTIONSFRAME_TAB2 = "竞拍"
L.WEBDKP_OPTIONSFRAME_TAB3 = "公告"

--Announcments.lua
L.FORMAT_WEBDKP_ITEMAWARD = "WebDKP: $player 给予装备: $item ,被扣了: $cost DKP"
L.FORMAT_WEBDKP_ITEMAWARDZEROSUM = "WebDKP: $dkp 点DKP被奖惩给所有玩家, 零和规则: $item"
L.FORMAT_WEBDKP_DKPAWARDALL = "WebDKP: $dkp 点DKP给予了所有玩家, 原因: $reason."
L.FORMAT_WEBDKP_DKPAWARDSOME = "WebDKP: $dkp 点DKP给予了所有被选择的玩家, 原因: $reason \n接收到的玩家都被密语了"
L.FORMAT_WEBDKP_BIDSTART = "WebDKP: 竞拍已开始 $item! $time "
L.FORMAT_WEBDKP_BIDEND = "WebDKP: $item 竞拍已结束, 胜利者为 $name , $dkp dkp"
L.FORMAT_WEBDKP_BIDENDSILENT = "WebDKP: 竞拍已结束 $item"
L.FORMAT_WEBDKP_ROLLEND = "WebDKP: Roll点已结束 $item , $name 是最高点, 为 $roll"
L.FORMAT_WEBDKP_TIMEDAWARD = "WebDKP: $minutes 分钟奖励分, 已给予 $dkp dkp"
L.FORMAT_WEBDKP_BOSSAWARDNUM = "WebDKP: 干得漂亮! Boss奖励分: $dkp 已自动给予"
L.FORMAT_WEBDKP_SENDWHISPER_PLUS = "你被奖励了 "
L.FORMAT_WEBDKP_SENDWHISPER_REDUCE = "你被扣除了 "

--AutoFill.lua
L.FORMAT_FIND_ITEM_LOOT = "获得了物品"

--WebDKP.lua
L.IgnoreItems1 = "连结水晶"
L.IgnoreItems2 = "源质矿石"
L.Multipleplayers = "多个玩家"

L.AwardFrameTitle = "Award ZeddZorandor thisisareallylongitemname for 10000 dkp?"
L.AwardFrameTitleYES = "是"
L.AwardFrameTitleNO = "不"
L.BidConfirmFrameCost = "DKP:"
L.BidConfirmFrameYes = "是"
L.BidConfirmFrameNo = "不"
L.CharRaidInfoFrameTitle = "角色出勤日志"
L.CharRaidInfoFrameHeaderLogTable = "仅显示在本地,网站无任何相关数据,出勤查询命令:|cFF0dea38出勤|r"
L.CharRaidInfoFrameHeaderAttended = "参与过的Raid:"
L.CharRaidInfoFrameFilterDaysLabel = "输入开始日期以筛选当前日期之前的数据:(如:11-10-2019)"
L.CharRaidInfoFrameCharRaidNameLabel = "角色名"
L.CharRaidInfoFrameCharRaidAttendedLabel = "出席过"
L.CharRaidInfoFrameCharRaidPercentLabel = "百分比"
L.CharRaidInfoFrameCharRaidTotRaidsLabel = "总次数"
L.CharRaidInfoFrameCharRaidLocationLabel = "地点"
L.CharRaidInfoFrameCharRaidDateLabel = "日期"
L.CharRaidInfoFrameRemChar = "删除角色"
L.CharRaidInfoFrameInGroupLabel = "只显示当前团队中的用户"
L.CharRaidInfoFrameFilterDateLabel = "开始日期:"
L.CharRaidInfoFrameApplyFilterDateLabel = "应用过滤"
L.FrameTitle = "WebDKP v13.7 Fixed by Wowcat"
L.FrameZoneColumn = "区域"
L.FrameWebsiteLabel = "http://webdkp.wowcat.net/"
L.FrameAnnounceDKPLimitToGroupText = "仅团队内"
L.FrameAnnounceDKP = "发送职业DKP"
L.FrameSelectAllText = "|cFF33FF00全选|r"
L.FrameDeselectAllText = "取消全选"
L.HelpFrameTitle = "WebDKP 帮助"
L.Help_DropDownLabel = "帮助类别:"
L.LogFrameTitle = "WebDKP 奖惩日志"
L.LogFrameHeaderLogTable = "本次游戏奖惩日志表:(同步后将会清空)"
L.LogFrameHeaderAwardedTo = "名字:"
L.LogFrameDirChar = "添加或删除一个角色"
L.LogFrameDirFilter = "查询角色"
L.LogFrameAwardedtoLabel = "名字"
L.LogFrameAmountLabel = "DKP"
L.LogFrameReasonLabel = "原因"
L.LogFrameDateLabel = "日期"
L.LogFrameCharChangeLabel = "名字:"
L.LogFrameDelChar = "删除"
L.LogFrameAddChar = "添加"
L.LogFramePlayerFilterLabel = "名字:"
L.LogFramePlayerFilterOK = "查询"
L.LogFramePlayerFilterCancel = "取消"
L.LogFrameSaveLog = "|cFF0dea38>保存数据文档<|r"
L.GeneralOptions_FrameAutofillDropDownLabel = "自动弹框品质"
L.GeneralOptions_FrameToggleAwardBossDKPIgnoreZeroLabel = "忽略0分"
L.GeneralOptions_FrameBossDKPMCAndOLLabel = "MC|ONY:"
L.GeneralOptions_FrameBossDKPBWLLabel = "BWL:"
L.GeneralOptions_FrameBossDKPTAQLabel = "TAQ:"
L.GeneralOptions_FrameBossDKPNAXXLabel = "NAXX:"
L.RaidInfoFrameTitle = "WebDKP 团队日志"
L.RaidInfoFrameHeaderLog = "本地团队日志表:(手动功能,仅在本地显示,网站无任何相关数据)"
L.RaidInfoFrameHeaderAttended = "参与者:"
L.RaidInfoFrameHeaderDirTime = "如果忘记结束Raid，请在此处输入总的Raid时间（以小时为单位）"
L.RaidInfoFrameHeaderDirChar = "你可以在此处添加或删除Raid出勤的角色"
L.RaidInfoFrameRaidLocationLabel = "Raid 地点"
L.RaidInfoFramedateLabel = "日期"
L.RaidInfoFramestartTimeLabel = "开始时间"
L.RaidInfoFrameendTimeLabel = "结束时间"
L.RaidInfoFrametotaltimeLabel = "总时间"
L.RaidInfoFrameStartRaid = "开始"
L.RaidInfoFrameStopRaid = "结束"
L.RaidInfoFrameDeleteRaid = "删除"
L.RaidInfoFrameEndTimeLabel = "时间（小时）:"
L.RaidInfoFrameAdjustTime = "调整时间"
L.RaidInfoFrameCharChangeLabel = "玩家名:"
L.RaidInfoFrameAddChar = "添加玩家"
L.RaidInfoFrameDelChar = "删除玩家"
L.SynchFrameTitle = "WebDKP - 游戏内同步"
L.SynchFrameText = "游戏内同步允许用户在游戏中共享数据,双方输入对方名字,相同密码,一个人按同步"
L.SynchFrameUsers = "接受的用户-您将接受来自的以下列表的人的数据"
L.SynchFrameNameLabel = "名字"
L.SynchFrameEnableSynchLabel = "启用(勾选), 禁用(不勾选)"
L.SynchFramePasswordLabel = "密码:"
L.SynchFrameSynchFromLabel = "与玩家同步:"
L.SynchFrameSynchronize = "仅同步DKP"
L.SynchFrameSynchAll = "同步DKP和日志"
L.SynchFrameAddSynchUserLabel = "添加或删除接受的用户"
L.SynchFrameAddUser = "添加"
L.SynchFrameDelUser = "删除"
L.TimedAward_MiniFrameTimeLeft = "00:00"
L.WinTabFrameTab1 = "DKP"
L.WinTabFrameTab2 = "竞拍"
L.WinTabFrameTab3 = "时间分"
L.WinTabFrameTab4 = "同步"
L.WinTabFrameTab5 = "日志"
L.WinTabFrameTab6 = "Raid"
L.WinTabFrameTab7 = "出勤"

--Announcments.lua
L.AnnounceBidstarting = "如果要出价,就在团队/小队/私聊里输入: 出价 分数 "
L.Announceinstructions = "(如: 出价 50)，或者直接输入分数！"
L.BidFixedBidding = "如果要出价,就在团队/小队/私聊里输入：需求"
L.startingBidText = "拍卖底价: "
L.time_second = "秒)"
L.Userdefined = "用户自定义"
L.startingBidvalue = "无底价"
L.TimeFlag = "剩余时间:"
L.Rollsstart1 = "Roll点开始： $item 请输入 /roll"
L.Rollsstart2 = "Roll点开始： $item 请输入 /roll 剩余时间: $time"
L.NOone = "无人"
L.AnnounceTop3 = "WebDKP: 前三名的竞拍者是:"
L.AnnounceTop3BID = " 出价: "

--AutoFill.lua
L.ShowAwardtext = "授予 "
L.ShowAwardtext2 = " ? \r\n (在下面输入DKP，仅限正数)"
L.Noinput_Print = "未输入值，因此dkp默认为0"
L.Noplayer_Print = "没有选择要授予的玩家"

--Awards.lua
L.ItemName_Print = "必须输入物品名称"
L.Noreasonspecified = "未指定"
L.RewardPoints_Print = "你必须输入奖励点数"
L.Nochoice_Print = "未选择任何玩家"
L.reasonZerosum = "零和: "
L.reasondecay = "衰减_"
L.hasapplieddecay = "已应用衰减"

--Bidding.lua
L.triggerBID = "出价 "
L.triggerBID2 = "出价"
L.triggerSH = "sh"
L.triggerMAINTLENT = "主天赋"
L.triggerOFFTLENT = "副天赋"
L.triggerBIDDINGTOSTART = "开拍"
L.triggerBIDDINGTOSTOP = "停拍"
L.triggerNEED = "需求"
L.triggerGREED = "贪婪"
L.framestopbinding = "停止竞拍"
L.framestartbinding = "开始竞拍!"
L.framestartrolling = "Roll点开始!"
L.framestoprolling = "停止Roll点!"
L.framelefttimetext = "剩余时间: "
L.framelefttimesecondtext = "秒"
L.defaultBIPmsg = "WebDKP: $name 以 $dkp 的高价获得竞拍. 还有 $time 秒可以竞拍 $item!"
L.defaultSBIPmsg = "WebDKP: 还剩 $time 秒， $item!"
L.defaultRIPmsg = "WebDKP: $name 以 $roll 点，为最高Roll点. 还有 $time 秒可以Roll $item"
L.SendAnnouncement = "竞拍开始!"
L.ShowAwardtextfor = " 为： "
L.ShowAwardtext3 = "? |cFFFF0000(物品不在战利品表中)|r"
L.ShowAwardtext4 = " dkp?(取自战利品列表)"
L.ShowAwardtext5 = " dkp? (百分比，如：50%)"
L.SendWhisper1 = "你出价不当, 输入'出价 分数'，或者直接输入分数"
L.SendWhisper2 = "没有正在进行的竞拍"
L.SendWhisper3 = "你没有指定竞拍金额"
L.SendWhisper4 = "竞拍不接受. 最低出价是 "
L.SendWhisper5 = "因为DKP管理者启用了固定分竞拍，所以竞拍不接受，你必须输入'需求'"
L.SendWhisper6 = "因为DKP管理者禁用了“出价”命令，所以竞拍不接受. 请输入 ‘主天赋’ 或者 ‘副天赋’"
L.SendWhisper7 = "竞拍： "
L.SendWhisper8 = " dkp ，已接受"
L.SendWhisper9 = "竞拍不接受, 你没有足够的 DKP. 最低出价是 "
L.SendWhisper10 = "竞拍不接受. 你必须输入'需求'"
L.SendWhisper11 = "你的主天赋需求已经被接受!"
L.SendWhisper12 = "主天赋竞拍: "
L.SendWhisper13 = "竞拍不接受, 你没有足够的 DKP. 最低竞拍是: "
L.SendWhisper14 = "你的副天赋需求已被接受."
L.SendWhisper15 = "副天赋竞拍: "
L.SendWhisper16 = "竞拍不接受. 你必须输入'贪婪'"
L.SendWhisper17 = "已经有一个竞拍在进行中-你不能开始另一个竞拍"
L.SendWhisper18 = "必须指定要竞拍的物品. 如: 开拍 [龙牙]"
L.SendWhisper19 = "竞拍被拒绝 - 你不能出价超过你当前DKP"
L.SendWhisper20 = "你的最高出价是 "
L.SendWhisper21 = "竞拍被拒绝 - 赢得此物品的最低dkp是 "
L.SendWhisper22 = "你是目前出价最高的人"
L.SendWhisper23 = "你不是出价高的人. 目前的最高价是  "
L.SendWhisper24 = "竞拍已收到!"
L.startrolling_Print = "你必须输入一个装备才能开始ROll"
L.showhandannounce = " Show hand了他全部的DKP: "

--Options.lua
L.itemquality = "灰色物品"
L.itemquality2 = "白色物品"
L.itemquality3 = "绿色物品"
L.itemquality4 = "蓝色物品"
L.itemquality5 = "紫色物品"
L.itemquality6 = "橙色物品"
L.Bossrewardenable_Print = "自动Boss击杀奖励已启用"
L.Bossrewarddisable_Print = "自动Boss击杀奖励已禁用"

--Standby.lua
L.Standby_Print = "你必须输入一个名字或选择一个玩家才能将其添加或删除到替补列表中"
L.Standby_Print2 = "此玩家不在你的替补名单上!"
L.Standby_SendWhisper = "你现在被列为替补玩家!请遵守本公会替补规则!"
L.Standby_SendWhisper2 = "你已从替补名单上被移除!"

--TimedAward.lua
L.AwardBossDKPIgnoreZero_Print = "%s:%s 自动击杀增加的dkp为0，已忽略"
L.AddDKPReason_BOSS = "自动Boss击杀奖励: "
L.StartStopButtonText = "开始"
L.StartStopButtonText2 = "停止"
L.ReasonTimedAward = "时间分自动奖励"
L.FrameToggleAwardBossDKP_Include_StandbyLabel = "包含替补"
--WhisperDKP.lua
L.WhisperDKP1 = "你没有DKP,查不到你的DKP历史记录"
L.WhisperDKP2 = "更多明细请微信搜索小程序'webdkp'查看哦!"
L.WhisperDKP3 = "当前DKP: "
L.WhisperDKP4 = "你出勤过 : "
L.WhisperDKP5 = "次团本,总计: "
L.WhisperDKP6 = " 次团本. 你的出勤百分比是 "
L.WhisperDKP7 = "你当前没有参与过团队/团本"
L.triggerWhisperDKP = "mydkp"
L.triggerWhisperDKP1 = "查询"
L.triggerWhisperDKP2 = "我要替补"
L.triggerWhisperDKP3 = "退出替补"
L.triggerWhisperDKP4 = "出勤"

L.DB_DUNGEON_ENCOUNTER = {
    --"Molten Core"
    [663] = "鲁西弗隆",
    [664] = "玛格曼达",
    [665] = "基赫纳斯",
    [666] = "加尔",
    [667] = "沙斯拉尔",
    [668] = "迦顿男爵",
    [669] = "萨弗隆先驱者",
    [670] = "焚化者古雷曼格",
    [671] = "管理者埃克索图斯",
    [672] = "拉格纳罗斯",
    --"Onyxia's Lair"
    [1084] = "奥妮克希亚",
    --"Blackwing Lair"
    [610] = "狂野的拉佐格尔",
    [611] = "堕落的瓦拉斯塔兹",
    [612] = "勒什雷尔",
    [613] = "费尔默",
    [614] = "埃博诺克",
    [615] = "弗莱格尔",
    [616] = "克洛玛古斯",
    [617] = "奈法利安",
    --"Temple of Ahn'Qiraj"
    [709] = "预言者斯克拉姆",
    [710] = "克利勋爵和亚尔基公主",
    [711] = "沙尔图拉",
    [712] = "顽强的范克瑞斯",
    [713] = "维希度斯",
    [714] = "哈霍兰公主",
    [715] = "双子皇帝",
    [716] = "奥罗",
    [717] = "克苏恩",
    --"Naxxramas"
    [1107] = "阿努布雷坎",
    [1108] = "格拉斯",
    [1109] = "收割者戈提克",
    [1110] = "黑女巫法琳娜",
    [1111] = "格罗布鲁斯",
    [1112] = "肮脏的希尔盖",
    [1113] = "教官拉苏维奥斯",
    [1114] = "克尔苏加德",
    [1115] = "洛欧塞布",
    [1116] = "迈克斯纳",
    [1117] = "瘟疫使者诺斯",
    [1118] = "帕奇维克",
    [1119] = "萨菲隆",
    [1120] = "塔迪乌斯",
    [1121] = "四骑士",
}