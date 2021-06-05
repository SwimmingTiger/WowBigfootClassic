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
L["OPTION_RULE_SETS_FILTER"] = "按分类筛选"
L["OPTION_RULE_SETS_FILTER_ALL"] = "显示所有分类"


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
        id = 2003,
        ["class"] = "世界BOSS/{author}",
        ["conditions"] = {
            {
                ["value"] = "世界BOSS",
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
        ["class"] = "副本/13-18 怒焰裂谷/{author}",
    },
    {
        id = 3002,
        ["class"] = "副本/17-24 哀嚎洞穴/{author}",
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
        ["class"] = "副本/17-26 死亡矿井/{author}",
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
        ["class"] = "副本/22-30 影牙城堡/{author}",
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
        ["class"] = "副本/24-32 黑暗深渊/{author}",
        ["conditions"] = {
            {
                ["value"] = "黑暗深渊",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3205,
        ["class"] = "副本/24-32 黑暗深渊/{author}",
        ["logic"] = "and",
        ["conditions"] = {
            {
                ["value"] = "深渊",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "黑石",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3005,
        ["class"] = "副本/24-32 监狱/{author}",
        ["logic"] = "and",
        ["conditions"] = {
            {
                ["value"] = "监狱",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "禁魔",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
            {
                ["value"] = "能源舰",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
            {
                ["value"] = "生态船",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
            {
                ["value"] = "风暴",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3006,
        ["class"] = "副本/29-38 诺莫瑞根/{author}",
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
        ["class"] = "副本/29-38 剃刀沼泽/{author}",
        ["logic"] = "and",
        ["conditions"] = {
            {
                ["value"] = "剃刀",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "高地",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3107,
        ["class"] = "副本/29-38 剃刀沼泽/{author}",
        ["logic"] = "and",
        ["conditions"] = {
            {
                ["value"] = "沼泽",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "幽暗",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
            {
                ["value"] = "黑色",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3008,
        ["class"] = "副本/26-45 血色修道院/{author}",
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
        ["class"] = "副本/26-36 血色修道院：墓地/{author}",
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
        ["class"] = "副本/29-39 血色修道院：图书馆/{author}",
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
        ["class"] = "副本/32-42 血色修道院：军械库/{author}",
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
        ["class"] = "副本/35-45 血色修道院：大教堂/{author}",
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
        ["class"] = "副本/37-46 剃刀高地/{author}",
        ["conditions"] = {
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
        id = 3113,
        ["class"] = "副本/37-46 剃刀高地/{author}",
        ["logic"] = "and",
        ["conditions"] = {
            {
                ["value"] = "剃刀",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "沼泽",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3014,
        ["class"] = "副本/41-51 奥达曼/{author}",
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
        ["class"] = "副本/44-54 祖尔法拉克/{author}",
        ["conditions"] = {
            {
                ["value"] = "祖尔法拉克",
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
        ["class"] = "副本/46-55 玛拉顿/{author}",
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
        ["class"] = "副本/50-60 阿塔哈卡神庙/{author}",
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
        ["class"] = "副本/52-60 黑石深渊/{author}",
        ["conditions"] = {
            {
                ["value"] = "黑石深渊",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3118,
        ["class"] = "副本/52-60 黑石深渊/{author}",
        ["logic"] = "and",
        ["conditions"] = {
            {
                ["value"] = "深渊",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "黑暗",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3019,
        ["class"] = "副本/55-60 黑石塔/{author}",
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
        ["class"] = "副本/55-60 黑石塔(下层)/{author}",
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
        ["class"] = "副本/55-60 黑石塔(上层)/{author}",
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
        ["class"] = "副本/55-60 厄运之槌/{author}",
        ["conditions"] = {
            {
                ["value"] = "厄运",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3122,
        ["class"] = "副本/55-60 厄运之槌(东)/{author}",
        ["conditions"] = {
            {
                ["value"] = "厄运东",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3222,
        ["class"] = "副本/58-60 厄运之槌(西)/{author}",
        ["conditions"] = {
            {
                ["value"] = "厄运东",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3322,
        ["class"] = "副本/58-60 厄运之槌(北)/{author}",
        ["conditions"] = {
            {
                ["value"] = "厄运东",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3023,
        ["class"] = "副本/58-60 斯坦索姆/{author}",
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
        ["class"] = "副本/58-60 通灵学院/{author}",
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
        ["class"] = "副本/60 熔火之心/{author}",
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
        ["class"] = "副本/60 奥妮克希亚的巢穴/{author}",
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
        ["class"] = "副本/60 黑翼之巢/{author}",
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
    {
        id = 3028,
        ["class"] = "副本/55-60 祖尔格拉布/{author}",
        ["conditions"] = {
            {
                ["value"] = "祖尔格拉布",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "祖格",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "zg",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "zug",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3029,
        ["class"] = "副本/60 安其拉神殿/{author}",
        ["conditions"] = {
            {
                ["value"] = "安其拉",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "aql",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "taq",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "aq40",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3030,
        ["class"] = "副本/60 安其拉废墟/{author}",
        ["conditions"] = {
            {
                ["value"] = "废墟",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "fx",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "raq",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "aq20",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3031,
        ["class"] = "副本/60+ 纳克萨玛斯/{author}",
        ["conditions"] = {
            {
                ["value"] = "纳克萨玛斯",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "naxx",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3032,
        ["class"] = "副本/59-67 地狱火城墙/{author}",
        ["conditions"] = {
            {
                ["value"] = "城墙",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "cq",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3033,
        ["class"] = "副本/60-68 鲜血熔炉/{author}",
        ["conditions"] = {
            {
                ["value"] = "熔炉",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "rl",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3034,
        ["class"] = "副本/69-70 破碎大厅/{author}",
        ["conditions"] = {
            {
                ["value"] = "破碎",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3035,
        ["class"] = "副本/63-70 法力陵墓/{author}",
        ["conditions"] = {
            {
                ["value"] = "陵墓",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "fl",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3135,
        ["logic"] = "and",
        ["class"] = "副本/63-70 法力陵墓/{author}",
        ["conditions"] = {
            {
                ["value"] = "法力",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "源生法力",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3036,
        ["class"] = "副本/64-70 奥金尼地穴/{author}",
        ["conditions"] = {
            {
                ["value"] = "奥金尼",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "地穴",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "dx",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3037,
        ["class"] = "副本/66-70 塞泰克大厅/{author}",
        ["conditions"] = {
            {
                ["value"] = "塞泰克",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "stk",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3038,
        ["class"] = "副本/69-70 暗影迷宫/{author}",
        ["conditions"] = {
            {
                ["value"] = "迷宫",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "mg",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3039,
        ["class"] = "副本/61-69 奴隶围栏/{author}",
        ["conditions"] = {
            {
                ["value"] = "奴隶",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "围栏",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "wl",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3040,
        ["class"] = "副本/62-70 幽暗沼泽/{author}",
        ["conditions"] = {
            {
                ["value"] = "幽暗沼泽",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "ub",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3140,
        ["logic"] = "and",
        ["class"] = "副本/62-70 幽暗沼泽/{author}",
        ["conditions"] = {
            {
                ["value"] = "沼泽",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "剃刀",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
            {
                ["value"] = "黑色",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3240,
        ["logic"] = "and",
        ["class"] = "副本/62-70 幽暗沼泽/{author}",
        ["conditions"] = {
            {
                ["value"] = "幽暗",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "幽暗城",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3041,
        ["class"] = "副本/69-70 蒸汽地窖/{author}",
        ["conditions"] = {
            {
                ["value"] = "蒸汽",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "地窖",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3042,
        ["class"] = "副本/66-70 旧希尔斯布莱德丘陵/{author}",
        ["conditions"] = {
            {
                ["value"] = "丘陵",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "%f[%a]ql",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3043,
        ["class"] = "副本/68-70 黑色沼泽/{author}",
        ["conditions"] = {
            {
                ["value"] = "黑色",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3143,
        ["logic"] = "and",
        ["class"] = "副本/68-70 黑色沼泽/{author}",
        ["conditions"] = {
            {
                ["value"] = "沼泽",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "剃刀",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
            {
                ["value"] = "幽暗",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3044,
        ["class"] = "副本/69-70 禁魔监狱/{author}",
        ["conditions"] = {
            {
                ["value"] = "禁魔",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3144,
        ["class"] = "副本/69-70 禁魔监狱/{author}",
        ["logic"] = "and",
        ["conditions"] = {
            {
                ["value"] = "监狱",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "能源舰",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3244,
        ["class"] = "副本/69-70 禁魔监狱/{author}",
        ["logic"] = "and",
        ["conditions"] = {
            {
                ["value"] = "监狱",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "生态船",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3344,
        ["class"] = "副本/69-70 禁魔监狱/{author}",
        ["logic"] = "and",
        ["conditions"] = {
            {
                ["value"] = "监狱",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "风暴",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3045,
        ["class"] = "副本/68-70 能源舰/{author}",
        ["conditions"] = {
            {
                ["value"] = "能源舰",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3046,
        ["class"] = "副本/69-70 生态船/{author}",
        ["conditions"] = {
            {
                ["value"] = "生态船",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3047,
        ["class"] = "副本/69-70 魔导师平台/{author}",
        ["conditions"] = {
            {
                ["value"] = "魔导",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "平台",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3048,
        ["class"] = "副本/68-70 卡拉赞/{author}",
        ["conditions"] = {
            {
                ["value"] = "卡拉赞",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "klz",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3049,
        ["class"] = "副本/68-70 祖阿曼/{author}",
        ["conditions"] = {
            {
                ["value"] = "祖阿曼",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "zam",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3050,
        ["class"] = "副本/70 玛瑟里顿的巢穴/{author}",
        ["conditions"] = {
            {
                ["value"] = "玛瑟里顿",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3150,
        ["logic"] = "and",
        ["class"] = "副本/70 玛瑟里顿的巢穴/{author}",
        ["conditions"] = {
            {
                ["value"] = "巢穴",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "格鲁尔",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3051,
        ["class"] = "副本/65-70 格鲁尔的巢穴/{author}",
        ["conditions"] = {
            {
                ["value"] = "格鲁尔",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3151,
        ["logic"] = "and",
        ["class"] = "副本/65-70 格鲁尔的巢穴/{author}",
        ["conditions"] = {
            {
                ["value"] = "巢穴",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "玛瑟里顿",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3052,
        ["class"] = "副本/70 毒蛇神殿/{author}",
        ["conditions"] = {
            {
                ["value"] = "毒蛇",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3152,
        ["logic"] = "and",
        ["class"] = "副本/70 毒蛇神殿/{author}",
        ["conditions"] = {
            {
                ["value"] = "神殿",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "黑暗",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3053,
        ["class"] = "副本/70 风暴要塞/{author}",
        ["conditions"] = {
            {
                ["value"] = "风暴",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "要塞",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3054,
        ["class"] = "副本/70 海加尔峰/{author}",
        ["conditions"] = {
            {
                ["value"] = "海加尔",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3055,
        ["class"] = "副本/70 黑暗神殿/{author}",
        ["conditions"] = {
            {
                ["value"] = "黑暗神殿",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3155,
        ["logic"] = "and",
        ["class"] = "副本/70 黑暗神殿/{author}",
        ["conditions"] = {
            {
                ["value"] = "神殿",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "毒蛇",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3255,
        ["logic"] = "and",
        ["class"] = "副本/70 黑暗神殿/{author}",
        ["conditions"] = {
            {
                ["value"] = "黑暗",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "深渊",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3056,
        ["class"] = "副本/70 太阳之井高地/{author}",
        ["conditions"] = {
            {
                ["value"] = "太阳井",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "太阳之井",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3156,
        ["logic"] = "and",
        ["class"] = "副本/70 太阳之井高地/{author}",
        ["conditions"] = {
            {
                ["value"] = "高地",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "剃刀",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
}
