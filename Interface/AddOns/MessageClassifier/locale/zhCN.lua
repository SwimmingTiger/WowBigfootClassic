local L = LibStub("AceLocale-3.0"):NewLocale(..., "zhCN")
if not L then return end

-------------------------------------------------------------

L = L or {}
-- Browser
L["BROWSER_CLASSIFIED_BY_AUTHOR"] = "玩家列表/%s"
L["BROWSER_CLASSIFIED_BY_CHANNEL"] = "频道列表/%s"
L["BROWSER_CLASSIFIED_ALL_MESSAGES"] = "全部发言"
L["BROWSER_STATUS_BAR"] = "共 %d 消息, 唯一 %d, 重复 %d, 重复率 %0.2f%%"
L["BROWSER_TITLE"] = "消息浏览器"
L["MOVE_BUTTON"] = "移动按钮"
L["Left-Click"] = "左键"
L["Shift-Click"] = "Shift-左键"
L["BROWSER_SETTING"] = "设置"
L["BROWSER_SEARCH"] = "搜索"

-- MessageClassifier
L["DISABLE_TIPS"] = "公共频道/世界频道消息去重：已停用"
L["ENABLE_TIPS"] = "公共频道/世界频道消息去重：已启用，可用 /msgdd 命令进行开关。"
L["ENABLE_TIPS_WITH_BIGFOOT"] = "公共频道/世界频道消息去重：已启用，可在小地图大脚按键包中关闭"
L["RESET_TIPS"] = "公共频道/世界频道消息去重：过滤器已重置"

-- Options
L["CONFIG_PAGE_TITLE"] = "聊天消息分类去重"
L["OPTION_ENABLED"] = "启用消息分类和重复消息过滤"
L["OPTION_ENABLED_TOOLTIP"] = "不显示公共频道/世界频道中重复的消息，并将消息分类收集到消息浏览器中"
L["OPTION_MIN_DUP_INTERVAL"] = "允许重复消息出现的最短间隔秒数，设为0始终禁止重复消息"
L["OPTION_RESET"] = "重置过滤器"
L["OPTION_RESET_TOOLTIP"] = "清除重复消息记录，允许重复消息再次显示"
L["OPTION_OPEN_MESSAGE_BROWSER"] = "打开消息浏览器"
L["OPTION_RULE_SETS_TITLE"] = "消息分类规则"
L["OPTION_ADD"] = "添加"
L["OPTION_EDIT"] = "编辑"
L["OPTION_SAVE"] = "保存"
L["OPTION_CANCEL"] = "取消"
L["OPTION_REMOVE"] = "移除"
L["OPTION_RULE_SETS"] = "自定义规则"
L["OPTION_DEFAULT_RULE_SETS"] = "默认规则"
L["OPTION_CONDITIONS"] = "如果"
L["OPTION_CONDITION_LOGIC"] = "逻辑关系"
L["OPTION_RULE_LOGIC_OR"] = "其中一个条件成立"
L["OPTION_RULE_LOGIC_AND"] = "全部条件同时成立"
L["OPTION_HIDE_FROM_CHAT_WINDOW"] = "不在聊天窗口显示"
L["OPTION_ENABLE"] = "启用"
L["OPTION_CLASS"] = "就加入以下分类"
L["OPTION_CLASS_NO_CONDITIONS"] = "总是加入以下分类"
L["OPTION_CLASS_EDIT_TITLE"] = "就加入以下分类 (可用变量: |cffc586c0{作者}|r 和 |cffc586c0{频道}|r)"
L["OPTION_CONDITION_FIELD"] = "字段"
L["OPTION_CONDITION_OPERATOR"] = "操作"
L["OPTION_CONDITION_VALUE"] = "值"
L["OPTION_COND_CASESENSITIVE"] = "区分大小写"
L["OPTION_SELECT_ALL"] = "全选"


-- Localized class variable
L["author"] = "作者"
L["channel"] = "频道"
L["content"] = "内容"

-- Rule Operators
L["equal"] = "等于"
L["not equal"] = "不等于"
L["contain"] = "包含"
L["not contain"] = "不包含"
L["match"] = "匹配"
L["not match"] = "不匹配"

-- Channels
L["CHAN_FULLNAME_GUILD"]="公会"
L["CHAN_FULLNAME_RAID"]="团队"
L["CHAN_FULLNAME_PARTY"]="小队"
L["CHAN_FULLNAME_GENERAL"]="综合"
L["CHAN_FULLNAME_TRADE"]="交易"
L["CHAN_FULLNAME_WORLDDEFENSE"]="世界防务"
L["CHAN_FULLNAME_LOCALDEFENSE"]="本地防务"
L["CHAN_FULLNAME_LFGCHANNEL"]="寻求组队"
L["CHAN_FULLNAME_BATTLEGROUND"]="战场"
L["CHAN_FULLNAME_YELL"]="喊道"
L["CHAN_FULLNAME_SAY"]="说"
L["CHAN_FULLNAME_WHISPERTO"]="发送给"
L["CHAN_FULLNAME_WHISPERFROM"]="悄悄地说"
L["CHAN_FULLNAME_BIGFOOTCHANNEL"] = "大脚世界频道"
L["CHAN_SHORTNAME_GUILD"]="公"
L["CHAN_SHORTNAME_RAID"]="团"
L["CHAN_SHORTNAME_PARTY"]="队"
L["CHAN_SHORTNAME_YELL"]="喊"
L["CHAN_SHORTNAME_BATTLEGROUND"]="战"
L["CHAN_SHORTNAME_OFFICER"]="官"
L["CHAN_SHORTNAME_BIGFOOT"]="世"
L["CHAN_SHORTNAME_WHISPERTO"]="密"
L["CHAN_SHORTNAME_WHISPERFROM"]="密"
L["CHAN_SHORTNAME_GENERAL"]="综"
L["CHAN_SHORTNAME_TRADE"]="交"
L["CHAN_SHORTNAME_LOCALDEFENSE"]="本"
L["CHAN_SHORTNAME_LFGCHANNEL"]="寻"
L["CHAN_SHORTNAME_WORLDDEFENSE"]="世"
L["CHAT_MSG_YELL"]="喊"

-------------------------------------------------------------

local L = LibStub("AceLocale-3.0"):GetLocale(...)

MessageClassifierDefaultRules = {
    {
        id = 1,
        conditions = {},
        class = L["BROWSER_CLASSIFIED_BY_AUTHOR"]:format("{author}")
    },
    {
        id = 2,
        conditions = {},
        class = L["BROWSER_CLASSIFIED_BY_CHANNEL"]:format("{channel}")
    },
    {
        id = 3,
        conditions = {},
        class = L["BROWSER_CLASSIFIED_ALL_MESSAGES"]
    },
    {
        id = 1001,
        ["class"] = "商业/收皮/{author}",
        ["conditions"] = {
            {
                ["value"] = "皮",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 1002,
        ["class"] = "商业/收布/{author}",
        ["conditions"] = {
            {
                ["value"] = "丝绸",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "布",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 1102,
        ["class"] = "商业/矿石/{author}",
        ["conditions"] = {
            {
                ["value"] = "矿",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "矿工",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
        ["logic"] = "and",
    },
    {
        id = 1003,
        ["conditions"] = {
            {
                ["value"] = "航",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "飞",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
        ["class"] = "航空/{author}",
    },
    {
        id = 2001,
        ["class"] = "副本/AA/{author}",
        ["conditions"] = {
            {
                ["value"] = "AA",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 2002,
        ["class"] = "任务/{author}",
        ["conditions"] = {
            {
                ["value"] = "任务",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3001,
        ["conditions"] = {
            {
                ["value"] = "怒焰",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "NY",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
        ["class"] = "副本/怒焰裂谷/{author}",
    },
    {
        id = 3002,
        ["class"] = "副本/哀嚎洞穴/{author}",
        ["conditions"] = {
            {
                ["value"] = "哀嚎",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "AH",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3003,
        ["class"] = "副本/死亡矿井/{author}",
        ["conditions"] = {
            {
                ["value"] = "矿井",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "死矿",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "SK",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3004,
        ["class"] = "副本/影牙城堡/{author}",
        ["conditions"] = {
            {
                ["value"] = "影牙",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "YY",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3105,
        ["class"] = "副本/黑暗深渊/{author}",
        ["conditions"] = {
            {
                ["value"] = "黑暗",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3005,
        ["class"] = "副本/监狱/{author}",
        ["conditions"] = {
            {
                ["value"] = "监狱",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3006,
        ["class"] = "副本/诺莫瑞根/{author}",
        ["conditions"] = {
            {
                ["value"] = "诺莫",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "瑞根",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "矮子",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3007,
        ["class"] = "副本/剃刀沼泽/{author}",
        ["conditions"] = {
            {
                ["value"] = "剃刀",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "沼泽",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "ZZ",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3008,
        ["class"] = "副本/血色修道院/{author}",
        ["conditions"] = {
            {
                ["value"] = "血色",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3009,
        ["class"] = "副本/血色修道院：墓地/{author}",
        ["conditions"] = {
            {
                ["value"] = "墓地",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3010,
        ["class"] = "副本/血色修道院：图书馆/{author}",
        ["conditions"] = {
            {
                ["value"] = "图书馆",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3011,
        ["class"] = "副本/血色修道院：军械库/{author}",
        ["conditions"] = {
            {
                ["value"] = "军械库",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3012,
        ["class"] = "副本/血色修道院：大教堂/{author}",
        ["conditions"] = {
            {
                ["value"] = "教堂",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3013,
        ["class"] = "副本/剃刀高地/{author}",
        ["conditions"] = {
            {
                ["value"] = "剃刀",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "高地",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "TDGD",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "GD",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3014,
        ["class"] = "副本/奥达曼/{author}",
        ["conditions"] = {
            {
                ["value"] = "奥达曼",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "ADM",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3015,
        ["class"] = "副本/祖尔法拉克/{author}",
        ["conditions"] = {
            {
                ["value"] = "祖尔",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "zul",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3016,
        ["class"] = "副本/玛拉顿/{author}",
        ["conditions"] = {
            {
                ["value"] = "玛拉顿",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "MLD",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3017,
        ["class"] = "副本/阿塔哈卡神庙/{author}",
        ["conditions"] = {
            {
                ["value"] = "神庙",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3018,
        ["class"] = "副本/黑石深渊/{author}",
        ["conditions"] = {
            {
                ["value"] = "深渊",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3019,
        ["class"] = "副本/黑石塔/{author}",
        ["conditions"] = {
            {
                ["value"] = "黑石塔",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3020,
        ["class"] = "副本/黑石塔(下层)/{author}",
        ["conditions"] = {
            {
                ["value"] = "黑下",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3021,
        ["class"] = "副本/黑石塔(上层)/{author}",
        ["conditions"] = {
            {
                ["value"] = "黑上",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3022,
        ["class"] = "副本/厄运之槌/{author}",
        ["conditions"] = {
            {
                ["value"] = "厄运",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3023,
        ["class"] = "副本/斯坦索姆/{author}",
        ["conditions"] = {
            {
                ["value"] = "斯坦索姆",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "STSM",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3024,
        ["class"] = "副本/通灵学院/{author}",
        ["conditions"] = {
            {
                ["value"] = "通灵",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "TL",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3025,
        ["class"] = "副本/熔火之心/{author}",
        ["conditions"] = {
            {
                ["value"] = "MC",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "熔火",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3026,
        ["class"] = "副本/奥妮克希亚的巢穴/{author}",
        ["conditions"] = {
            {
                ["value"] = "奥妮克希亚",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "巢穴",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "黑龙",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "龙妹",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3027,
        ["class"] = "副本/黑翼之巢/{author}",
        ["conditions"] = {
            {
                ["value"] = "黑翼",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "奈法",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "BWL",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
}
