local L = LibStub("AceLocale-3.0"):NewLocale("Spy", "zhCN") -- Simplified Chinese
if not L then return end
-- TOC Note: "检测并提醒您附近有敌方玩家。"
 
-- Configuration
L["Spy"] = "Spy 侦测敌方玩家"
L["Version"] = "版本"
L["Spy Option"] = "Spy 侦测敌方玩家"
L["Profiles"] = "Profiles 配置文件"
 
-- About
L["About"] = "信息"
L["SpyDescription1"] = [[
Spy 侦测敌方玩家 插件可以提醒您附近有敌对玩家出现。
]]
L["SpyDescription2"] = [[
|cffffd000附近列表|cffffffff
附近列表会显示已经被侦测到的任何敌方玩家。 在非战斗状态下，点击列表姓名可快速选定目标。 如果在一定时间内未再次侦测到的玩家会被从列表中移除。
 
|cffffd000近一小时内清单|cffffffff
显示最近1小时内出现的所有敌方玩家。
 
|cffffd000忽略列表|cffffffff
被加入忽略列表的敌对玩家将不会在列表中显示。你可以通过鼠标右键菜单或按住Ctrl点击从列表中添加或删除敌对玩家。
 
|cffffd000KOS即视击杀列表|cffffffff
在该列表中的敌对玩家一旦被侦测会出警报。您可以通过鼠标右键菜单或按住Shift点击从列表中添加或删除敌对玩家。
 
右键菜单也可以添加将某人加入此列表的原因。如果你希望添加不在列表中的说明，可以通过其他列表“自行输入原因...”。

|cffffd000Statistics Window|cffffffff
The Statistics Window contains a list of all enemy encounters which can be sorted by name, level, guild, wins, losses and the last time an enemy was detected. It also provides the ability to search for a specific enemy by name or guild and has filters to show only enemies that are marked as Kill on Sight, with a Win/Loss or entered Reasons. 

|cffffd000Kill On Sight Button|cffffffff
If enabled, this button will be located on the enemy players target frame. Clicking on this button will add/remove the enemy target to/from the Kill On Sight list. Right clicking on the button will allow you to enter Kill on Sight reasons.

|cffffd000作者: Slipjack|cffffffff
]]

-- General Settings
L["GeneralSettings"] = "一般配置"
L["GeneralSettingsDescription"] = [[
启用或禁用Spy时的选项。
]] 
L["EnableSpy"] = "开启Spy"
L["EnableSpyDescription"] = "启用或禁用Spy。"
L["EnabledInBattlegrounds"] = "战场中启用Spy"
L["EnabledInBattlegroundsDescription"] = "在战场中启用或禁用Spy。"
L["EnabledInArenas"] = "竞技场中启用Spy"
L["EnabledInArenasDescription"] = "在竞技场中启用或禁用Spy。"
L["EnabledInWintergrasp"] = "世界战斗区域中启用Spy"
L["EnabledInWintergraspDescription"] = "在世界战斗区域中启用或禁用Spy，例如诺森德的冬握湖。"
L["DisableWhenPVPUnflagged"] = "非PVP状态时禁用Spy"
L["DisableWhenPVPUnflaggedDescription"] = "根据PVP状态启用或禁用Spy。"
L["DisabledInZones"] = "在这些位置时禁用Spy"
L["DisabledInZonesDescription"]	= "选择将禁用Spy的位置"
L["Booty Bay"] = "藏宝海湾"
L["Everlook"] = "永望镇"						
L["Gadgetzan"] = "加基森"
L["Ratchet"] = "棘齿城"
L["The Salty Sailor Tavern"] = "水手之家旅店"
L["Shattrath City"] = "沙塔斯城"
L["Area 52"] = "52区"
L["Dalaran"] = "达拉然"
L["Dalaran (Northrend)"] = "达拉然（诺森德）"
L["Bogpaddle"] = "沼桨镇"
L["The Vindicaar"] = "维迪卡尔"
L["Krasus' Landing"] = "克拉苏斯平台"
L["The Violet Gate"] = "紫罗兰之门"
L["Magni's Encampment"] = "麦格尼的营地"
L["Silithus"] = "希利苏斯"
L["Chamber of Heart"] = "心之秘室"
L["Hall of Ancient Paths"] = "远古通路大厅"
L["Sanctum of the Sages"] = "贤者圣殿"
 
-- Display
L["DisplayOptions"] = "显示"
L["DisplayOptionsDescription"] = [[
Spy 窗口的选项和工具提示。
]]
L["ShowOnDetection"] = "侦测到敌对玩家时显示Spy"
L["ShowOnDetectionDescription"] = "当侦测到敌对玩家时，自动显示隐藏的Spy菜单和附近列表。"
L["HideSpy"] = "未侦测到敌对玩家时隐藏"
L["HideSpyDescription"] = "当附近列表为空列表时隐藏Spy，手动清空列表不会隐藏Spy。"
L["ShowOnlyPvPFlagged"] = "只显示PVP状态的敌对玩家"
L["ShowOnlyPvPFlaggedDescription"] = "在附近列表中只显示PVP状态的敌对玩家。"
L["ShowKoSButton"] = "在敌对玩家头像上显示KOS按钮"
L["ShowKoSButtonDescription"] = "设置敌对玩家头像上显示KOS按钮。"
L["Alpha"] = "透明度"
L["AlphaDescription"] = "设置Spy窗口的透明度。"
L["AlphaBG"] = "战场上的透明度"
L["AlphaBGDescription"] = "在战场中设置Spy窗口的透明度。"
L["LockSpy"] = "锁定Spy窗口"
L["LockSpyDescription"] = "锁定Spy窗口无法移动。"
L["ClampToScreen"] = "屏幕锁定"
L["ClampToScreenDescription"] = "控制是否可以将Spy的窗口拖出屏幕。"
L["InvertSpy"] = "翻转Spy窗口"
L["InvertSpyDescription"] = "上下翻转Spy窗口。"
L["Reload"] = "重新载入"
L["ReloadDescription"] = "调整Spy窗口大小后需重新载入。"
L["ResizeSpy"] = "自动调整Spy窗口大小"
L["ResizeSpyDescription"] = "新增或删除敌对玩家时自动调整窗口大小。"
L["ResizeSpyLimit"] = "列表限制"
L["ResizeSpyLimitDescription"] = "限制窗口中显示的敌对玩家数量。"
L["DisplayTooltipNearSpyWindow"] = "在Spy窗口附近显示工具提示"
L["DisplayTooltipNearSpyWindowDescription"] = "进行设置以在“间谍”窗口附近显示工具提示。"
L["SelectTooltipAnchor"] = "工具提示锚"
L["SelectTooltipAnchorDescription"] = "如果选择了以上选项，请选择工具提示的锚点"
L["ANCHOR_CURSOR"] = "光标"
L["ANCHOR_TOP"] = "上面的"
L["ANCHOR_BOTTOM"] = "下"
L["ANCHOR_LEFT"] = "左"			
L["ANCHOR_RIGHT"] = "右"
L["TooltipDisplayWinLoss"] = "鼠标提示中显示胜率统计"
L["TooltipDisplayWinLossDescription"] = "设置鼠标提示中显示胜率统计。"
L["TooltipDisplayKOSReason"] = "在鼠标提示中显示KOS原因"
L["TooltipDisplayKOSReasonDescription"] = "设置在鼠标提示中显示KOS原因。"
L["TooltipDisplayLastSeen"] = "在鼠标提示中显示上次遇到的详情"
L["TooltipDisplayLastSeenDescription"] = "设置在鼠标提示中显示上次遇到的详情。"
L["DisplayListData"] = "选择要显示的敌人数据"
L["Name"] = "名称"
L["Class"] = "职业"
L["SelectFont"] = "选择字体"
L["SelectFontDescription"] = "为Spy选择字体。"
L["RowHeight"] = "选择列高"
L["RowHeightDescription"] = "为Spy设置列高度。"
L["Texture"] = "质地"
L["TextureDescription"] = "选择Spy窗口的纹理"
 
-- Alerts
L["AlertOptions"] = "警告设置"
L["AlertOptionsDescription"] = [[
当检测到敌方玩家时的警报，公告和警告选项。
]]
L["SoundChannel"] = "选择声音通道"
L["Master"] = "主音量"
L["SFX"] = "音效音量"
L["Music"] = "音乐音量"
L["Ambience"] = "环境音量"
L["Announce"] = "通报到:"
L["None"] = "无"
L["NoneDescription"] = "侦测到敌对玩家时不通报。"
L["Self"] = "自己"
L["SelfDescription"] = "侦测到敌对玩家时通报给自己。"
L["Party"] = "队伍"
L["PartyDescription"] = "侦测到敌对玩家时通报到队伍频道。"
L["Guild"] = "公会"
L["GuildDescription"] = "侦测到敌对玩家时通报到公会频道。"
L["Raid"] = "团队"
L["RaidDescription"] = "侦测到敌对玩家时通报到团队频道。"
L["LocalDefense"] = "本地防务"
L["LocalDefenseDescription"] = "侦测到敌对玩家时通报到本地防务频道。"
L["OnlyAnnounceKoS"] = "只通报在KOS列表中的敌对玩家"
L["OnlyAnnounceKoSDescription"] = "设置只通报在KOS列表中的敌对玩家。"
L["WarnOnStealth"] = "潜行侦测警告"
L["WarnOnStealthDescription"] = "设置敌对玩家潜行侦测警告。"
L["WarnOnKOS"] = "KOS列表玩家侦测警告"
L["WarnOnKOSDescription"] = "设置KOS列表玩家侦测警告"
L["WarnOnKOSGuild"] = "KOS公家侦测警告"
L["WarnOnKOSGuildDescription"] = "设置侦测与KOS列表中的玩家在同一公会时警告。"
L["WarnOnRace"] = "种家侦测警告"
L["WarnOnRaceDescription"] = "设置侦测到设定种族时警告。"
L["SelectWarnRace"] = "选家侦测的种族"
L["SelectWarnRaceDescription"] = "选择特定种族发出警告。"
L["WarnRaceNote"] = "提示：您必须选择过该敌对玩家至少一次该种族信息才会被添加，在下次侦测时才会发出警告。与侦测附近敌对玩家一样，在战斗中无法进行设置。"
L["DisplayWarningsInErrorsFrame"] = "以错误信息提示显示警告"
L["DisplayWarningsInErrorsFrameDescription"] = "设置错误信息提示来取代图形化弹出窗口。"
L["DisplayWarnings"] = "选择警告消息的位置"
L["Default"] = "默认位置"
L["ErrorFrame"] = "错误框"
L["Moveable"] = "可移动的"
L["EnableSound"] = "启用声音警告"
L["EnableSoundDescription"] = "设置当检测到敌对玩家时声音警告。 潜行或者KOS列表中的敌对玩家会有不同的声音提示。"
L["OnlySoundKoS"] = "仅开启KOS列表中敌对玩家的声音警告"
L["OnlySoundKoSDescription"] = "设置仅开启KOS列表中敌对玩家的声音警告。"
L["StopAlertsOnTaxi"] = "在飞行路线上关闭警报"
L["StopAlertsOnTaxiDescription"] = "在飛行路線上停止所有新的警報和警告."
 
-- Nearby List
L["ListOptions"] = "附近列表选项"
L["ListOptionsDescription"] = [[
关于如何添加和删除敌方玩家的选项。
]]
L["RemoveUndetected"] = "多久后删除附近列表中的敌对玩家："
L["1Min"] = "1 分钟"
L["1MinDescription"] = "删除1分钟内未被检测的敌对玩家。"
L["2Min"] = "2 分钟"
L["2MinDescription"] = "删除2分钟内未被检测的敌对玩家。"
L["5Min"] = "5 分钟"
L["5MinDescription"] = "删除5分钟内未被检测的敌对玩家。"
L["10Min"] = "10 分钟"
L["10MinDescription"] = "删除10分钟内未被检测的敌对玩家。"
L["15Min"] = "15 分钟"
L["15MinDescription"] = "删除15分钟内未被检测的敌对玩家。"
L["Never"] = "永不删除"
L["NeverDescription"] = "永不删除敌对玩家。但附近列表仍然可以被手动清除。"
L["ShowNearbyList"] = "遭遇敌对玩家时自动切换至附近列表。"
L["ShowNearbyListDescription"] = "设置侦测到敌对玩家时显示附近列表，如果原本没有显示。"
L["PrioritiseKoS"] = "在附近列表中优先显示KOS列表中的敌对玩家"
L["PrioritiseKoSDescription"] = "设置总在附近列表中优先显示KOS列表中的敌对玩家。"
 
-- Map
L["MapOptions"] = "小地图选项"
L["MapOptionsDescription"] = [[
世界地图和小地图的选项，包括图标和工具提示。
]]
L["MinimapDetection"] = "启用小地图检测"
L["MinimapDetectionDescription"] = "将光标移到在小地图上检测到的已知敌方玩家上，会将他们添加到“附近”列表中。"
L["MinimapNote"] = "          注意：仅适用于可以追踪人形生物的玩家。"
L["MinimapDetails"] = "在鼠标提示中显示等级/职业信息"
L["MinimapDetailsDescription"] = "设置更新小地图的提示信息，显示敌对玩家名字时显示等级/职业信息。"
L["DisplayOnMap"] = "在地图上显示图标"
L["DisplayOnMapDescription"] = "Display map icons for the location of other Spy users in your party, raid and guild when they detect enemies."
L["SwitchToZone"] = "侦测到敌对玩家时切换到当前区域地图"
L["SwitchToZoneDescription"] = "当检测到敌人时，将地图更改为玩家当前区域地图。"
L["MapDisplayLimit"] = "限制地图标记显示:"
L["LimitNone"] = "任何地方"
L["LimitNoneDescription"] = "无视自己当前位置，在地图上显示所有侦测到的敌对玩家。"
L["LimitSameZone"] = "相同区域"
L["LimitSameZoneDescription"] = "只显示和自己在相同区域中的侦测到的敌对玩家。"
L["LimitSameContinent"] = "相同大陆"
L["LimitSameContinentDescription"] = "只显示和自己在相同大陆中的侦测到的敌对玩家。"
 
 -- Data Management
L["DataOptions"] = "数据管理选项"
L["DataOptionsDescription"] = [[
关于 Spy 如何维护和收集数据的选项。
]]
L["PurgeData"] = "多久后删除未被侦测的敌对玩家信息:"
L["OneDay"] = "1 天"
L["OneDayDescription"] = "删除超过1天未被侦测的敌对玩家信息。"
L["FiveDays"] = "5 天"
L["FiveDaysDescription"] = "删除超过5天未被侦测的敌对玩家信息。"
L["TenDays"] = "10 天"
L["TenDaysDescription"] = "删除超过10天未被侦测的敌对玩家信息。"
L["ThirtyDays"] = "30 天"
L["ThirtyDaysDescription"] = "删除超过30天未被侦测的敌对玩家信息。"
L["SixtyDays"] = "60 天"
L["SixtyDaysDescription"] = "删除超过60天未被侦测的敌对玩家信息。"
L["NinetyDays"] = "90 天"
L["NinetyDaysDescription"] = "删除超过90天未被侦测的敌对玩家信息。"
L["PurgeKoS"] = "同时删除KOS列表中敌对玩家信息。"
L["PurgeKoSDescription"] = "设置相同时间未被侦测时，删除KOS列表中的敌对玩家。"
L["PurgeWinLossData"] = "同时删除胜率统计数据"
L["PurgeWinLossDataDescription"] = "设置相同时间未被侦测时，删除胜率统计数据。"
L["ShareData"] = "与其他Spy用户分享数据"
L["ShareDataDescription"] = "设置与队伍、团队或公会中的其他Spy用户分享数据。"
L["UseData"] = "使用其他Spy用户的数据"
L["UseDataDescription"] = "使用队伍、团队或公会中的其他Spy用户的数据。"
L["ShareKOSBetweenCharacters"] = "在您的角色中共享KOS敌对玩家列表"
L["ShareKOSBetweenCharactersDescription"] = "设置在相同服务器和阵营的角色共享KOS敌对玩家列表。"
 
 -- Commands
L["SlashCommand"] = "聊天窗口命令"
L["SpySlashDescription"] = "这些按钮会执行在聊天窗口中输入/spy 命令一样的功能。"
L["Enable"] = "启用"
L["EnableDescription"] = "启用Spy并显示窗口。"
L["Show"] = "显示"
L["ShowDescription"] = "显示Spy主窗口"
L["Hide"] = "隐藏"
L["HideDescription"] = "隐藏主窗口"
L["Reset"] = "重置"
L["ResetDescription"] = "恢复Spy窗口和外观默认设置"
L["ClearSlash"] = "清除"
L["ClearSlashDescription"] = "删除被侦测敌对玩家的列表"
L["Config"] = "配置"
L["ConfigDescription"] = "打开Spy窗口的配置菜单"
L["KOS"] = "KOS即视击杀"
L["KOSDescription"] = "从KOS敌对玩家列表中添加或删除敌对玩家"
L["InvalidInput"] = "输入错误"
L["Ignore"] = "忽略"
L["IgnoreDescription"] = "从忽略列表中添加或删除敌对玩家"
L["Test"] = "Test"
L["TestDescription"] = "显示警告，以便您可以重新放置它。"
 
-- Lists
L["Nearby"] = "附近"
L["LastHour"] = "最近"
L["Ignore"] = "忽略"
L["KillOnSight"] = "KOS即视击杀"
 
--Stats
L["Won"] = "胜"
L["Lost"] = "负"
L["Time"] = "时间"   
L["List"] = "列表"
L["Filter"] = "过滤"
L["Show Only"] = "仅显示"
L["KOS"] = "KOS即视击杀"
L["Won/Lost"] = "胜/负"
L["Reason"] = "原因"   
L["HonorKills"] = "荣誉击杀"
L["PvPDeaths"] = "PvP 死亡"
 
-- Output Messages
L["VersionCheck"] = "|cffc41e3a警告！ 安装了错误的Spy版本。 删除此版本并安装Spy Classic。"
L["SpyEnabled"] = "|cff9933ffSpy 侦测敌方玩家插件已启动。"
L["SpyDisabled"] = "|cff9933ffSpy 侦测敌方玩家插件已关闭。 输入 |cffffffff/spy show|cff9933ff 启动插件。"
L["UpgradeAvailable"] = "|cff9933ff新版Spy 侦测敌方玩家 已有新的版本。 可以从这里下载新版本：\n|cffffffffhttps://www.curseforge.com/wow/addons/spy-classic"
L["AlertStealthTitle"] = "侦测到潜行敌人！"
L["AlertKOSTitle"] = "侦测到KOS敌对玩家！"
L["AlertKOSGuildTitle"] = "侦测到KOS敌对公会！"
L["AlertTitle_kosaway"] = "KOS敌对玩家被发现，由 "
L["AlertTitle_kosguildaway"] = "KOS敌对工会被发现，由 "
L["StealthWarning"] = "|cff9933ff侦测到潜行敌人：|cffffffff"
L["KOSWarning"] = "|cffff0000侦测到KOS敌对玩家：|cffffffff"
L["KOSGuildWarning"] = "|cffff0000侦测到KOS敌对公会：|cffffffff"
L["SpySignatureColored"] = "|cff9933ff[Spy] "
L["PlayerDetectedColored"] = "侦测到敌对玩家：|cffffffff"
L["PlayersDetectedColored"] = "侦测到敌对玩家：|cffffffff"
L["KillOnSightDetectedColored"] = "侦测到KOS敌对玩家：|cffffffff"
L["PlayerAddedToIgnoreColored"] = "添加玩家到忽略列表：|cffffffff"
L["PlayerRemovedFromIgnoreColored"] = "从忽略列表中删除玩家：|cffffffff"
L["PlayerAddedToKOSColored"] = "添加玩家到KOS列表：|cffffffff"
L["PlayerRemovedFromKOSColored"] = "从KOS列表中删除玩家：|cffffffff"
L["PlayerDetected"] = "[Spy] 侦测到的玩家："
L["KillOnSightDetected"] = "[Spy] 侦测到的KOS敌对玩家："
L["Level"] = "等级"
L["LastSeen"] = "上次遇到"
L["LessThanOneMinuteAgo"] = "1分钟前"
L["MinutesAgo"] = "分钟前"
L["HoursAgo"] = "小时前"
L["DaysAgo"] = "天前"
L["Close"] = "关闭"
L["CloseDescription"] = "|cffffffff隐藏Spy窗口。默认在下次侦测到敌对玩家时显示。"
L["Left/Right"] = "左/右"
L["Left/RightDescription"] = "|cffffffff在附近，最近，忽略和KOS列表切换。"
L["Clear"] = "清除"
L["ClearDescription"] = "|cffffffff清楚已就侦测敌对玩家列表。Ctrl+左键单击以启动或停止 Spy。 按住Shift并单击可打开/关闭声音。"
L["SoundEnabled"] = "启用音频警报"
L["SoundDisabled"] = "音频警报已禁用"
L["NearbyCount"] = "附近数量统计"
L["NearbyCountDescription"] = "|cffffffff统计附近敌对玩家数量。"
L["Statistics"] = "数据统计"
L["StatsDescription"] = "|cffffffff显示遇到过的敌对玩家，胜/负记录以及上次遇到的位置。"
L["AddToIgnoreList"] = "添加到忽略列表"
L["AddToKOSList"] = "添加到KOS列表"
L["RemoveFromIgnoreList"] = "从忽略列表中删除"
L["RemoveFromKOSList"] = "从KOS列表中删除"
L["RemoveFromStatsList"] = "从数据统计列表中删除"   --++
L["AnnounceDropDownMenu"] = "通报"
L["KOSReasonDropDownMenu"] = "设置KOS原因"
L["PartyDropDownMenu"] = "队伍"
L["RaidDropDownMenu"] = "团队"
L["GuildDropDownMenu"] = "公会"
L["LocalDefenseDropDownMenu"] = "本地防务"
L["Player"] = " （玩家）"
L["KOSReason"] = "KOS即视击杀"
L["KOSReasonIndent"] = "    "
L["KOSReasonOther"] = "自行输入原因..."
L["KOSReasonClear"] = "清除"
L["StatsWins"] = "|cff40ff00获胜："
L["StatsSeparator"] = "  "
L["StatsLoses"] = "|cff0070dd失败："
L["Located"] = "位置："
L["Yards"] = "码"
L["LocalDefenseChannelName"] = "本地防務"
 
Spy_KOSReasonListLength = 6
Spy_KOSReasonList = {
    [1] = {
        ["title"] = "战斗起因";
        ["content"] = {
            "毫无理由攻击我",
            "接任务时攻击我",
            "和NPC战斗时攻击我",
            "副本门口攻击我",
            "暂离时攻击我",
            "在我骑马或者飞行时攻击我",
            "在我低血量或低魔法时攻击我",
        };
    },
    [2] = {
        ["title"] = "战斗方式";
        ["content"] = {
            "偷袭我",
            "见我就打",
            "用高等级人物杀我",
            "一群人蹂躏我",
            "没人支援就不打我",
            "总叫人帮忙",
            "频繁使用控场技能",
        };
    },
    [3] = {
        ["title"] = "守尸";
        ["content"] = {
            "守我尸体",
            "小号守我",
            "守低等级玩家",
            "潜行守尸",
            "工会成员一起守",
            "守游戏NPC或者任务点和怪",
            "在城市或者一片区域守",
        };
    },
    [4] = {
        ["title"] = "阻碍任务";
        ["content"] = {
            "做任务的时候攻击我",
            "帮忙做任务后攻击我",
            "破坏任务物品和npc",
            "抢我的任务",
            "杀我方阵营npc",
            "杀任务npv",
        };
    },
    [5] = {
        ["title"] = "偷抢资源";
        ["content"] = {
            "抢我草药",
            "抢我矿",
            "抢我资源",
            "杀我然后抢我的东西/稀有怪",
            "抢我的剥皮",
            "偷我的怪",
            "抢我的钓鱼点",
        };
    },
    [6] = {
        ["title"] = "其他";
        ["content"] = {
            "就是喜欢pvp",
            "把我推下悬崖",
            "用工程物品",
            "总是逃跑",
            "使用物品或技能逃跑",
            "乱用游戏bug",
            "自行输入原因...",
        };
    },
}
 
StaticPopupDialogs["Spy_SetKOSReasonOther"] = {
    preferredIndex=STATICPOPUPS_NUMDIALOGS,  -- http://forums.wowace.com/showthread.php?p=320956
    text = "输入 %s 的KOS原因:",
    button1 = "设置",
    button2 = "取消",
    timeout = 120,
    hasEditBox = 1,
    editBoxWidth = 260,
    whileDead = 1,
    hideOnEscape = 1,
    OnShow = function(self)
        self.editBox:SetText("");
    end,
    OnAccept = function(self)
        local reason = self.editBox:GetText()
        Spy:SetKOSReason(self.playerName, "自行输入原因...", reason)
    end,
};

-- Class descriptions
L["UNKNOWN"] = "未知"
L["DRUID"] = "德魯伊"
L["HUNTER"] = "獵人"
L["MAGE"] = "法師"
L["PALADIN"] = "聖騎士"
L["PRIEST"] = "牧師"
L["ROGUE"] = "盜賊"
L["SHAMAN"] = "薩滿"
L["WARLOCK"] = "術士"
L["WARRIOR"] = "戰士"
L["DEATHKNIGHT"] = "死亡騎士"
L["MONK"] = "武僧"
L["DEMONHUNTER"] = "惡魔獵人"

-- Race descriptions
L["Human"] = "人类"
L["Orc"] = "兽人"
L["Dwarf"] = "矮人"
L["Tauren"] = "牛头人"
L["Troll"] = "巨魔"
L["Night Elf"] = "暗夜精灵"
L["Undead"] = "亡灵"
L["Gnome"] = "侏儒"
L["Blood Elf"] = "血精灵"
L["Draenei"] = "德莱尼"
L["Goblin"] = "地精"
L["Worgen"] = "狼人"
L["Pandaren"] = "熊猫人"
L["Highmountain Tauren"] = "至高岭牛头人"
L["Lightforged Draenei"] = "光铸德莱尼"
L["Nightborne"] = "夜之子"
L["Void Elf"] = "虚空精灵"
L["Dark Iron Dwarf"] = "黑铁矮人"
L["Mag'har Orc"] = "玛格汉兽人"
L["Kul Tiran"] = "库尔提拉斯人"
L["Zandalari Troll"] = "赞达拉巨魔"
L["Mechagnome"] = "机械侏儒"
L["Vulpera"] = "狐人"

-- Stealth abilities
L["Stealth"] = "潜行"
L["Prowl"] = "潛行"

-- Minimap color codes
L["MinimapGuildText"] = "|cffffffff"
L["MinimapClassTextUNKNOWN"] = "|cff191919"
L["MinimapClassTextDRUID"] = "|cffff7c0a"
L["MinimapClassTextHUNTER"] = "|cffaad372"
L["MinimapClassTextMAGE"] = "|cff68ccef"
L["MinimapClassTextPALADIN"] = "|cfff48cba"
L["MinimapClassTextPRIEST"] = "|cffffffff"
L["MinimapClassTextROGUE"] = "|cfffff468"
L["MinimapClassTextSHAMAN"] = "|cff2359ff"
L["MinimapClassTextWARLOCK"] = "|cff9382c9"
L["MinimapClassTextWARRIOR"] = "|cffc69b6d"
L["MinimapClassTextDEATHKNIGHT"] = "|cffc41e3a"
L["MinimapClassTextMONK"] = "|cff00ff96"
L["MinimapClassTextDEMONHUNTER"] = "|cffa330c9"

Spy_AbilityList = {
-----------------------------------------------------------
-- Allows an estimation of the race, class and level of a
-- player based on the abilities observed in the combat log.
-----------------------------------------------------------

--++ Racial Traits ++	
	["影遁"]={ race = "Night Elf", level = 1, },
	["血性狂暴"]={ race = "Orc", level = 1, },
	["被遗忘者的意志"]={ race = "Undead", level = 1, },
	["石像形态"]={ race = "Dwarf", level = 1, },
	["狂暴"]={ race = "Troll", level = 1, },
	["坚韧"]={ race = "Orc", level = 1, },
	["剑类武器专精"]={ race = "Human", level = 1, },
	["逃命专家"]={ race = "Gnome", level = 1, },
	["人类精魂"]={ race = "Human", level = 1, },
	["再生"]={ race = "Troll", level = 1, },
	["感知"]={ race = "Human", level = 1, },
	["耐久"]={ race = "Tauren", level = 1, },
	["弓专精"]={ race = "Troll", level = 1, },
	["栽培"]={ race = "Tauren", level = 1, },
	["工程学专精"]={ race = "Gnome", level = 1, },
	["战争践踏"]={ race = "Tauren", level = 1, },
	["野兽杀手"]={ race = "Troll", level = 1, },
	["寻找财宝"]={ race = "Dwarf", level = 1, },
	["斧专精"]={ race = "Orc", level = 1, },
	["食尸"]={ race = "Undead", level = 1, },
	["外交"]={ race = "Human", level = 1, },
	["迅捷"]={ race = "Night Elf", level = 1, },
	["投掷专精"]={ race = "Troll", level = 1, },
	["锤类武器专精"]={ race = "Human", level = 1, },
	["枪械专精"]={ race = "Dwarf", level = 1, },
	["水下呼吸"]={ race = "Undead", level = 1, },
	["命令"]={ race = "Orc", level = 1, },
	["自然抗性"]={ race = "Night Elf", level = 1, },
	["冰霜抗性"]={ race = "Dwarf", level = 1, },
	["暗影抗性"]={ race = "Undead", level = 1, },
	["奥术抗性"]={ race = "Gnome", level = 1, },
	["精灵之魂"]={ race = "Night Elf", level = 1, },
	
--++ Druid Abilities ++	
	["治疗之触"]={ class = "DRUID", level = 1, },
	["愤怒"]={ class = "DRUID", level = 1, },
	["月火术"]={ class = "DRUID", level = 4, },
	["纠缠根须"]={ class = "DRUID", level = 8, },
	["熊形态"]={ class = "DRUID", level = 10, },
	["挫志咆哮"]={ class = "DRUID", level = 10, },
	["低吼"]={ class = "DRUID", level = 10, },
	["槌击"]={ class = "DRUID", level = 10, },
	["传送：月光林地"]={ class = "DRUID", level = 10, },
	["狂怒"]={ class = "DRUID", level = 12, },
	["愈合"]={ class = "DRUID", level = 12, },
	["重击"]={ class = "DRUID", level = 14, },
	["水栖形态"]={ class = "DRUID", level = 16, },
	["挥击"]={ class = "DRUID", level = 16, },
	["精灵之火"]={ class = "DRUID", level = 18, },
	["休眠"]={ class = "DRUID", level = 18, },
	["猎豹形态"]={ class = "DRUID", level = 20, },
	["爪击"]={ class = "DRUID", level = 20, },
	["潜行"]={ class = "DRUID", level = 20, },
	["复生"]={ class = "DRUID", level = 20, },
	["撕扯"]={ class = "DRUID", level = 20, },
	["星火术"]={ class = "DRUID", level = 20, },
	["撕碎"]={ class = "DRUID", level = 22, },
	["安抚动物"]={ class = "DRUID", level = 22, },
	["扫击"]={ class = "DRUID", level = 24, },
	["解除诅咒"]={ class = "DRUID", level = 24, },
	["猛虎之怒"]={ class = "DRUID", level = 24, },
	["驱毒术"]={ class = "DRUID", level = 26, },
	["急奔"]={ class = "DRUID", level = 26, },
	["挑战咆哮"]={ class = "DRUID", level = 28, },
	["畏缩"]={ class = "DRUID", level = 28, },
	["旅行形态"]={ class = "DRUID", level = 30, },
	["凶猛撕咬"]={ class = "DRUID", level = 32, },
	["毁灭"]={ class = "DRUID", level = 32, },
	["狂暴回复"]={ class = "DRUID", level = 36, },
	["突袭"]={ class = "DRUID", level = 36, },
	["巨熊形态"]={ class = "DRUID", level = 40, },
--++ Druid Talents ++	
	["自然之握"]={ class = "DRUID", level = 10, },
	["野性冲锋"]={ class = "DRUID", level = 20, },
	["虫群"]={ class = "DRUID", level = 20, },
	["清晰预兆"]={ class = "DRUID", level = 20, },
	["精灵之火（野性）"]={ class = "DRUID", level = 30, },
--++ Hunter Abilities ++	
	["准备就绪"]={ class = "HUNTER", level = 1, },
	["自动射击"]={ class = "HUNTER", level = 1, },
	["猛禽一击"]={ class = "HUNTER", level = 1, },
	["追踪野兽"]={ class = "HUNTER", level = 1, },
	["灵猴守护"]={ class = "HUNTER", level = 4, },
	["毒蛇钉刺"]={ class = "HUNTER", level = 4, },
	["奥术射击"]={ class = "HUNTER", level = 6, },
	["猎人印记"]={ class = "HUNTER", level = 6, },
	["震荡射击"]={ class = "HUNTER", level = 8, },
	["雄鹰守护"]={ class = "HUNTER", level = 10, },
	["召唤宠物"]={ class = "HUNTER", level = 10, },
	["解散野兽"]={ class = "HUNTER", level = 10, },
	["喂养宠物"]={ class = "HUNTER", level = 10, },
	["复活宠物"]={ class = "HUNTER", level = 10, },
	["驯服野兽"]={ class = "HUNTER", level = 10, },
	["扰乱射击"]={ class = "HUNTER", level = 12, },
	["治疗宠物"]={ class = "HUNTER", level = 12, },
	["摔绊"]={ class = "HUNTER", level = 12, },
	["鹰眼术"]={ class = "HUNTER", level = 14, },
	["野兽之眼"]={ class = "HUNTER", level = 14, },
	["恐吓野兽"]={ class = "HUNTER", level = 14, },
	["献祭陷阱"]={ class = "HUNTER", level = 16, },
	["猫鼬撕咬"]={ class = "HUNTER", level = 16, },
	["多重射击"]={ class = "HUNTER", level = 18, },
	["追踪亡灵"]={ class = "HUNTER", level = 18, },
	["猎豹守护"]={ class = "HUNTER", level = 20, },
	["逃脱"]={ class = "HUNTER", level = 20, },
	["冰冻陷阱"]={ class = "HUNTER", level = 20, },
	["毒蝎钉刺"]={ class = "HUNTER", level = 22, },
	["野兽知识"]={ class = "HUNTER", level = 24, },
	["追踪隐藏生物"]={ class = "HUNTER", level = 24, },
	["急速射击"]={ class = "HUNTER", level = 26, },
	["追踪元素生物"]={ class = "HUNTER", level = 26, },
	["冰霜陷阱"]={ class = "HUNTER", level = 28, },
	["野兽守护"]={ class = "HUNTER", level = 30, },
	["假死"]={ class = "HUNTER", level = 30, },
	["照明弹"]={ class = "HUNTER", level = 32, },
	["追踪恶魔"]={ class = "HUNTER", level = 32, },
	["爆炸陷阱"]={ class = "HUNTER", level = 34, },
	["蝰蛇钉刺"]={ class = "HUNTER", level = 36, },
	["豹群守护"]={ class = "HUNTER", level = 40, },
	["追踪巨人"]={ class = "HUNTER", level = 40, },
	["乱射"]={ class = "HUNTER", level = 40, },
	["野性守护"]={ class = "HUNTER", level = 46, },
	["追踪龙类"]={ class = "HUNTER", level = 50, },
	["宁神射击"]={ class = "HUNTER", level = 60, },
--++ Hunter Talents ++	
	["瞄准射击"]={ class = "HUNTER", level = 20, },
	["威慑"]={ class = "HUNTER", level = 20, },
	["反击"]={ class = "HUNTER", level = 30, },
	["胁迫"]={ class = "HUNTER", level = 30, },
	["驱散射击"]={ class = "HUNTER", level = 30, },
	["狂野怒火"]={ class = "HUNTER", level = 40, },
	["翼龙钉刺"]={ class = "HUNTER", level = 40, },
--++ Mage Abilities ++	
	["火球术"]={ class = "MAGE", level = 1, },
	["霜甲术"]={ class = "MAGE", level = 1, },
	["寒冰箭"]={ class = "MAGE", level = 4, },
	["造水术"]={ class = "MAGE", level = 4, },
	["火焰冲击"]={ class = "MAGE", level = 6, },
	["造食术"]={ class = "MAGE", level = 6, },
	["奥术飞弹"]={ class = "MAGE", level = 8, },
	["变形术"]={ class = "MAGE", level = 8, },
	["冰霜新星"]={ class = "MAGE", level = 10, },
	["魔爆术"]={ class = "MAGE", level = 14, },
	["侦测魔法"]={ class = "MAGE", level = 16, },
	["烈焰风暴"]={ class = "MAGE", level = 16, },
	["解除次级诅咒"]={ class = "MAGE", level = 18, },
	["闪现术"]={ class = "MAGE", level = 20, },
	["暴风雪"]={ class = "MAGE", level = 20, },
	["唤醒"]={ class = "MAGE", level = 20, },
	["防护火焰结界"]={ class = "MAGE", level = 20, },
	["法力护盾"]={ class = "MAGE", level = 20, },
	["传送：铁炉堡"]={ class = "MAGE", level = 20, },
	["传送：奥格瑞玛"]={ class = "MAGE", level = 20, },
	["传送：暴风城"]={ class = "MAGE", level = 20, },
	["传送：幽暗城"]={ class = "MAGE", level = 20, },
	["防护冰霜结界"]={ class = "MAGE", level = 22, },
	["灼烧"]={ class = "MAGE", level = 22, },
	["法术反制"]={ class = "MAGE", level = 24, },
	["冰锥术"]={ class = "MAGE", level = 26, },
	["制造魔法玛瑙"]={ class = "MAGE", level = 28, },
	["冰甲术"]={ class = "MAGE", level = 30, },
	["传送：达纳苏斯"]={ class = "MAGE", level = 30, },
	["传送：雷霆崖"]={ class = "MAGE", level = 30, },
	["魔甲术"]={ class = "MAGE", level = 34, },
	["制造魔法翡翠"]={ class = "MAGE", level = 38, },
	["传送门：铁炉堡"]={ class = "MAGE", level = 40, },
	["传送门：奥格瑞玛"]={ class = "MAGE", level = 40, },
	["传送门：暴风城"]={ class = "MAGE", level = 40, },
	["传送门：幽暗城"]={ class = "MAGE", level = 40, },
	["制造魔法黄水晶"]={ class = "MAGE", level = 48, },
	["传送门：达纳苏斯"]={ class = "MAGE", level = 50, },
	["传送门：雷霆崖"]={ class = "MAGE", level = 50, },
	["奥术光辉"]={ class = "MAGE", level = 56, },
	["制造魔法红宝石"]={ class = "MAGE", level = 58, },
	["变形术：奶牛"]={ class = "MAGE", level = 60, },
	["变形术"]={ class = "MAGE", level = 60, },
	["变形术"]={ class = "MAGE", level = 60, },
--++ Mage Talents ++	
	["急速冷却"]={ class = "MAGE", level = 20, },
	["炎爆术"]={ class = "MAGE", level = 20, },
	["冲击波"]={ class = "MAGE", level = 30, },
	["寒冰屏障"]={ class = "MAGE", level = 30, },
	["气定神闲"]={ class = "MAGE", level = 30, },
	["奥术强化"]={ class = "MAGE", level = 40, },
	["燃烧"]={ class = "MAGE", level = 40, },
	["寒冰护体"]={ class = "MAGE", level = 40, },
--++ Paladin Abilities ++	
	["圣光术"]={ class = "PALADIN", level = 1, },
	["正义圣印"]={ class = "PALADIN", level = 1, },
	["审判"]={ class = "PALADIN", level = 4, },
	["圣佑术"]={ class = "PALADIN", level = 6, },
	["十字军圣印"]={ class = "PALADIN", level = 6, },
	["制裁之锤"]={ class = "PALADIN", level = 8, },
	["纯净术"]={ class = "PALADIN", level = 8, },
	["圣疗术"]={ class = "PALADIN", level = 10, },
	["救赎"]={ class = "PALADIN", level = 12, },
	["正义之怒"]={ class = "PALADIN", level = 16, },
	["驱邪术"]={ class = "PALADIN", level = 20, },
	["圣光闪现"]={ class = "PALADIN", level = 20, },
	["感知亡灵"]={ class = "PALADIN", level = 20, },
	["公正圣印"]={ class = "PALADIN", level = 22, },
	["超度亡灵"]={ class = "PALADIN", level = 24, },
	["拯救祝福"]={ class = "PALADIN", level = 26, },
	["神圣干涉"]={ class = "PALADIN", level = 30, },
	["光明圣印"]={ class = "PALADIN", level = 30, },
	["圣盾术"]={ class = "PALADIN", level = 34, },
	["智慧圣印"]={ class = "PALADIN", level = 38, },
	["光明祝福"]={ class = "PALADIN", level = 40, },
	["召唤军马"]={ class = "PALADIN", level = 40, },
	["清洁术"]={ class = "PALADIN", level = 42, },
	["愤怒之锤"]={ class = "PALADIN", level = 44, },
	["神圣愤怒"]={ class = "PALADIN", level = 50, },
	["召唤战马"]={ class = "PALADIN", level = 60, },
--++ Paladin Talents ++	
	["奉献"]={ class = "PALADIN", level = 20, },
	["命令圣印"]={ class = "PALADIN", level = 20, },
	["神恩术"]={ class = "PALADIN", level = 30, },
	["神圣之盾"]={ class = "PALADIN", level = 40, },
	["神圣震击"]={ class = "PALADIN", level = 40, },
	["忏悔"]={ class = "PALADIN", level = 40, },
--++ Priest Abilities ++	
	["次级治疗术"]={ class = "PRIEST", level = 1, },
	["惩击"]={ class = "PRIEST", level = 1, },
	["暗言术：痛"]={ class = "PRIEST", level = 4, },
	["渐隐术"]={ class = "PRIEST", level = 8, },
	["绝望祷言"]={ class = "PRIEST", level = 10, },
	["虚弱妖术"]={ class = "PRIEST", level = 10, },
	["心灵震爆"]={ class = "PRIEST", level = 10, },
	["复活术"]={ class = "PRIEST", level = 10, },
	["星辰碎片"]={ class = "PRIEST", level = 10, },
	["虚弱之触"]={ class = "PRIEST", level = 10, },
	["心灵之火"]={ class = "PRIEST", level = 12, },
	["心灵尖啸"]={ class = "PRIEST", level = 14, },
	["治疗术"]={ class = "PRIEST", level = 16, },
	["驱散魔法"]={ class = "PRIEST", level = 18, },
	["噬灵瘟疫"]={ class = "PRIEST", level = 20, },
	["艾露恩的赐福"]={ class = "PRIEST", level = 20, },
	["回馈"]={ class = "PRIEST", level = 20, },
	["快速治疗"]={ class = "PRIEST", level = 20, },
	["神圣之火"]={ class = "PRIEST", level = 20, },
	["安抚心灵"]={ class = "PRIEST", level = 20, },
	["束缚亡灵"]={ class = "PRIEST", level = 20, },
	["暗影守卫"]={ class = "PRIEST", level = 20, },
	["心灵视界"]={ class = "PRIEST", level = 22, },
	["法力燃烧"]={ class = "PRIEST", level = 24, },
	["精神控制"]={ class = "PRIEST", level = 30, },
	["治疗祷言"]={ class = "PRIEST", level = 30, },
	["驱除疾病"]={ class = "PRIEST", level = 32, },
	["漂浮术"]={ class = "PRIEST", level = 34, },
	["强效治疗术"]={ class = "PRIEST", level = 40, },
--++ Priest Talents ++	
	["神圣新星"]={ class = "PRIEST", level = 20, },
	["心灵专注"]={ class = "PRIEST", level = 20, },
	["精神鞭笞"]={ class = "PRIEST", level = 20, },
	["沉默"]={ class = "PRIEST", level = 30, },
	["光明之泉"]={ class = "PRIEST", level = 40, },
	["暗影形态"]={ class = "PRIEST", level = 40, },
--++ Rogue Abilities ++	
	["刺骨"]={ class = "ROGUE", level = 1, },
	["开锁"]={ class = "ROGUE", level = 1, },
	["邪恶攻击"]={ class = "ROGUE", level = 1, },
	["潜行"]={ class = "ROGUE", level = 1, },
	["背刺"]={ class = "ROGUE", level = 4, },
	["搜索"]={ class = "ROGUE", level = 4, },
	["凿击"]={ class = "ROGUE", level = 6, },
	["闪避"]={ class = "ROGUE", level = 8, },
	["闷棍"]={ class = "ROGUE", level = 10, },
	["切割"]={ class = "ROGUE", level = 10, },
	["疾跑"]={ class = "ROGUE", level = 10, },
	["脚踢"]={ class = "ROGUE", level = 12, },
	["破甲"]={ class = "ROGUE", level = 14, },
	["绞喉"]={ class = "ROGUE", level = 14, },
	["佯攻"]={ class = "ROGUE", level = 16, },
	["伏击"]={ class = "ROGUE", level = 18, },
	["毒药"]={ class = "ROGUE", level = 20, },
	["割裂"]={ class = "ROGUE", level = 20, },
	["致残毒药"]={ class = "ROGUE", level = 20, },
	["速效毒药"]={ class = "ROGUE", level = 20, },
	["扰乱"]={ class = "ROGUE", level = 22, },
	["消失"]={ class = "ROGUE", level = 22, },
	["侦测陷阱"]={ class = "ROGUE", level = 24, },
	["麻痹毒药"]={ class = "ROGUE", level = 24, },
	["偷袭"]={ class = "ROGUE", level = 26, },
	["解除陷阱"]={ class = "ROGUE", level = 30, },
	["肾击"]={ class = "ROGUE", level = 30, },
	["致命毒药"]={ class = "ROGUE", level = 30, },
	["致伤毒药"]={ class = "ROGUE", level = 32, },
	["致盲"]={ class = "ROGUE", level = 34, },
	["致盲粉"]={ class = "ROGUE", level = 34, },
	["安全降落"]={ class = "ROGUE", level = 40, },
--++ Rogue Talents ++	
	["鬼魅攻击"]={ class = "ROGUE", level = 20, },
	["还击"]={ class = "ROGUE", level = 20, },
	["剑刃乱舞"]={ class = "ROGUE", level = 30, },
	["冷血"]={ class = "ROGUE", level = 30, },
	["出血"]={ class = "ROGUE", level = 30, },
	["伺机待发"]={ class = "ROGUE", level = 30, },
	["冲动"]={ class = "ROGUE", level = 40, },
	["预谋"]={ class = "ROGUE", level = 40, },
--++ Shaman Abilities ++	
	["治疗波"]={ class = "SHAMAN", level = 1, },
	["闪电箭"]={ class = "SHAMAN", level = 1, },
	["石化武器"]={ class = "SHAMAN", level = 1, },
	["地震术"]={ class = "SHAMAN", level = 4, },
	["石肤图腾"]={ class = "SHAMAN", level = 4, },
	["地缚图腾"]={ class = "SHAMAN", level = 6, },
	["闪电之盾"]={ class = "SHAMAN", level = 8, },
	["石爪图腾"]={ class = "SHAMAN", level = 8, },
	["烈焰震击"]={ class = "SHAMAN", level = 10, },
	["火舌武器"]={ class = "SHAMAN", level = 10, },
	["灼热图腾"]={ class = "SHAMAN", level = 10, },
	["大地之力图腾"]={ class = "SHAMAN", level = 10, },
	["先祖之魂"]={ class = "SHAMAN", level = 12, },
	["火焰新星图腾"]={ class = "SHAMAN", level = 12, },
	["净化术"]={ class = "SHAMAN", level = 12, },
	["战栗图腾"]={ class = "SHAMAN", level = 18, },
	["冰霜震击"]={ class = "SHAMAN", level = 20, },
	["冰封武器"]={ class = "SHAMAN", level = 20, },
	["幽魂之狼"]={ class = "SHAMAN", level = 20, },
	["治疗之泉图腾"]={ class = "SHAMAN", level = 20, },
	["次级治疗波"]={ class = "SHAMAN", level = 20, },
	["清毒图腾"]={ class = "SHAMAN", level = 22, },
	["抗寒图腾"]={ class = "SHAMAN", level = 24, },
	["视界术"]={ class = "SHAMAN", level = 26, },
	["熔岩图腾"]={ class = "SHAMAN", level = 26, },
	["法力之泉图腾"]={ class = "SHAMAN", level = 26, },
	["抗火图腾"]={ class = "SHAMAN", level = 28, },
	["火舌图腾"]={ class = "SHAMAN", level = 28, },
	["星界传送"]={ class = "SHAMAN", level = 30, },
	["根基图腾"]={ class = "SHAMAN", level = 30, },
	["自然抗性图腾"]={ class = "SHAMAN", level = 30, },
	["复生"]={ class = "SHAMAN", level = 30, },
	["风怒武器"]={ class = "SHAMAN", level = 30, },
	["闪电链"]={ class = "SHAMAN", level = 32, },
	["风怒图腾"]={ class = "SHAMAN", level = 32, },
	["岗哨图腾"]={ class = "SHAMAN", level = 34, },
	["风墙图腾"]={ class = "SHAMAN", level = 36, },
	["祛病图腾"]={ class = "SHAMAN", level = 38, },
	["治疗链"]={ class = "SHAMAN", level = 40, },
	["风之优雅图腾"]={ class = "SHAMAN", level = 42, },
	["宁静之风图腾"]={ class = "SHAMAN", level = 50, },
--++ Shaman Talents ++	
	["招架"]={ class = "SHAMAN", level = 30, },
	["元素掌握"]={ class = "SHAMAN", level = 40, },
	["法力之潮图腾"]={ class = "SHAMAN", level = 40, },
	["风暴打击"]={ class = "SHAMAN", level = 40, },
--++ Warlock Abilities ++	
	["恶魔皮肤"]={ class = "WARLOCK", level = 1, },
	["献祭"]={ class = "WARLOCK", level = 1, },
	["暗影箭"]={ class = "WARLOCK", level = 1, },
	["召唤小鬼"]={ class = "WARLOCK", level = 1, },
	["腐蚀术"]={ class = "WARLOCK", level = 4, },
	["虚弱诅咒"]={ class = "WARLOCK", level = 4, },
	["生命分流"]={ class = "WARLOCK", level = 6, },
	["痛苦诅咒"]={ class = "WARLOCK", level = 8, },
	["恐惧术"]={ class = "WARLOCK", level = 8, },
	["制造初级治疗石"]={ class = "WARLOCK", level = 10, },
	["吸取灵魂"]={ class = "WARLOCK", level = 10, },
	["召唤虚空行者"]={ class = "WARLOCK", level = 10, },
	["生命通道"]={ class = "WARLOCK", level = 12, },
	["鲁莽诅咒"]={ class = "WARLOCK", level = 14, },
	["吸取生命"]={ class = "WARLOCK", level = 14, },
	["魔息术"]={ class = "WARLOCK", level = 16, },
	["灼热之痛"]={ class = "WARLOCK", level = 18, },
	["制造初级灵魂石"]={ class = "WARLOCK", level = 18, },
	["魔甲术"]={ class = "WARLOCK", level = 20, },
	["火焰之雨"]={ class = "WARLOCK", level = 20, },
	["召唤仪式"]={ class = "WARLOCK", level = 20, },
	["召唤魅魔"]={ class = "WARLOCK", level = 20, },
	["制造次级治疗石"]={ class = "WARLOCK", level = 22, },
	["基尔罗格之眼"]={ class = "WARLOCK", level = 22, },
	["吸取法力"]={ class = "WARLOCK", level = 24, },
	["感知恶魔"]={ class = "WARLOCK", level = 24, },
	["语言诅咒"]={ class = "WARLOCK", level = 26, },
	["侦测次级隐形"]={ class = "WARLOCK", level = 26, },
	["放逐术"]={ class = "WARLOCK", level = 28, },
	["制造次级火焰石"]={ class = "WARLOCK", level = 28, },
	["奴役恶魔"]={ class = "WARLOCK", level = 30, },
	["地狱烈焰"]={ class = "WARLOCK", level = 30, },
	["召唤地狱猎犬"]={ class = "WARLOCK", level = 30, },
	["制造次级灵魂石"]={ class = "WARLOCK", level = 30, },
	["元素诅咒"]={ class = "WARLOCK", level = 32, },
	["防护暗影结界"]={ class = "WARLOCK", level = 32, },
	["制造治疗石"]={ class = "WARLOCK", level = 34, },
	["制造火焰石"]={ class = "WARLOCK", level = 36, },
	["制造法术石"]={ class = "WARLOCK", level = 36, },
	["侦测隐形"]={ class = "WARLOCK", level = 38, },
	["恐惧嚎叫"]={ class = "WARLOCK", level = 40, },
	["召唤地狱战马"]={ class = "WARLOCK", level = 40, },
	["制造灵魂石"]={ class = "WARLOCK", level = 40, },
	["死亡缠绕"]={ class = "WARLOCK", level = 42, },
	["暗影诅咒"]={ class = "WARLOCK", level = 44, },
	["制造强效治疗石"]={ class = "WARLOCK", level = 46, },
	["制造强效火焰石"]={ class = "WARLOCK", level = 46, },
	["灵魂之火"]={ class = "WARLOCK", level = 48, },
	["制造强效法术石"]={ class = "WARLOCK", level = 48, },
	["侦测强效隐形"]={ class = "WARLOCK", level = 50, },
	["地狱火"]={ class = "WARLOCK", level = 50, },
	["制造强效灵魂石"]={ class = "WARLOCK", level = 50, },
	["制造特效火焰石"]={ class = "WARLOCK", level = 56, },
	["制造特效治疗石"]={ class = "WARLOCK", level = 58, },
	["厄运诅咒"]={ class = "WARLOCK", level = 60, },
	["末日仪式"]={ class = "WARLOCK", level = 60, },
	["召唤恐惧战马"]={ class = "WARLOCK", level = 60, },
	["制造特效灵魂石"]={ class = "WARLOCK", level = 60, },
	["制造特效法术石"]={ class = "WARLOCK", level = 60, },
--++ Warlock Talents ++	
	["诅咒增幅"]={ class = "WARLOCK", level = 20, },
	["恶魔支配"]={ class = "WARLOCK", level = 20, },
	["暗影灼烧"]={ class = "WARLOCK", level = 20, },
	["疲劳诅咒"]={ class = "WARLOCK", level = 30, },
	["恶魔牺牲"]={ class = "WARLOCK", level = 30, },
	["生命虹吸"]={ class = "WARLOCK", level = 30, },
	["燃烧"]={ class = "WARLOCK", level = 40, },
	["黑暗契约"]={ class = "WARLOCK", level = 40, },
	["灵魂链接"]={ class = "WARLOCK", level = 40, },
--++ Warrior Abilities ++	
	["战斗姿态"]={ class = "WARRIOR", level = 1, },
	["英勇打击"]={ class = "WARRIOR", level = 1, },
	["强化拳击"]={ class = "WARRIOR", level = 1, },
	["冲锋"]={ class = "WARRIOR", level = 4, },
	["撕裂"]={ class = "WARRIOR", level = 4, },
	["雷霆一击"]={ class = "WARRIOR", level = 6, },
	["断筋"]={ class = "WARRIOR", level = 8, },
	["血性狂暴"]={ class = "WARRIOR", level = 10, },
	["防御姿态"]={ class = "WARRIOR", level = 10, },
	["破甲攻击"]={ class = "WARRIOR", level = 10, },
	["嘲讽"]={ class = "WARRIOR", level = 10, },
	["压制"]={ class = "WARRIOR", level = 12, },
	["盾击"]={ class = "WARRIOR", level = 12, },
	["挫志怒吼"]={ class = "WARRIOR", level = 14, },
	["复仇"]={ class = "WARRIOR", level = 14, },
	["惩戒痛击"]={ class = "WARRIOR", level = 16, },
	["盾牌格挡"]={ class = "WARRIOR", level = 16, },
	["缴械"]={ class = "WARRIOR", level = 18, },
	["顺劈斩"]={ class = "WARRIOR", level = 20, },
	["反击风暴"]={ class = "WARRIOR", level = 20, },
	["破胆怒吼"]={ class = "WARRIOR", level = 22, },
	["斩杀"]={ class = "WARRIOR", level = 24, },
	["挑战怒吼"]={ class = "WARRIOR", level = 26, },
	["盾墙"]={ class = "WARRIOR", level = 28, },
	["狂暴姿态"]={ class = "WARRIOR", level = 30, },
	["拦截"]={ class = "WARRIOR", level = 30, },
	["猛击"]={ class = "WARRIOR", level = 30, },
	["狂暴之怒"]={ class = "WARRIOR", level = 32, },
	["旋风斩"]={ class = "WARRIOR", level = 36, },
	["拳击"]={ class = "WARRIOR", level = 38, },
	["鲁莽"]={ class = "WARRIOR", level = 50, },
--++ Warrior Talents ++	
	["破釜沉舟"]={ class = "WARRIOR", level = 20, },
	["刺耳怒吼"]={ class = "WARRIOR", level = 20, },
	["震荡猛击"]={ class = "WARRIOR", level = 30, },
	["死亡之愿"]={ class = "WARRIOR", level = 30, },
	["横扫攻击"]={ class = "WARRIOR", level = 30, },
	["嗜血"]={ class = "WARRIOR", level = 40, },
	["致死打击"]={ class = "WARRIOR", level = 40, },
	["盾牌猛击"]={ class = "WARRIOR", level = 40, },
};

Spy_IgnoreList = {
	["邮箱"]=true, 
	["Treasure Chest"]=true,
	["Small Treasure Chest"]=true,
};