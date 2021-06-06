local L = LibStub("AceLocale-3.0"):NewLocale(..., "zhTW")
if not L then return end

-------------------------------------------------------------

L = L or {}
-- Browser
L["BROWSER_CLASSIFIED_ALL_MESSAGES"] = "所有訊息"
L["BROWSER_CLASSIFIED_BY_AUTHOR"] = "玩家列表/%s"
L["BROWSER_CLASSIFIED_BY_CHANNEL"] = "頻道列表/%s"
L["BROWSER_SEARCH"] = "搜尋"
L["BROWSER_SETTING"] = "設定"
L["BROWSER_STATUS_BAR"] = "共 %d 則訊息，唯一 %d，重複 %d，重複率 %0.2f%%"
L["BROWSER_TITLE"] = "訊息瀏覽器"
L["Left-Click"] = "左鍵"
L["MOVE_BUTTON"] = "移動按鈕"
L["Shift-Click"] = "Shift-左鍵"

-- Channels
L["CHAN_FULLNAME_BATTLEGROUND"] = "戰場"
L["CHAN_FULLNAME_BIGFOOTCHANNEL"] = "大腳世界頻道"
L["CHAN_FULLNAME_GENERAL"] = "綜合"
L["CHAN_FULLNAME_GUILD"] = "公會"
L["CHAN_FULLNAME_LFGCHANNEL"] = "尋求組隊"
L["CHAN_FULLNAME_LOCALDEFENSE"] = "本地防務"
L["CHAN_FULLNAME_PARTY"] = "隊伍"
L["CHAN_FULLNAME_RAID"] = "團隊"
L["CHAN_FULLNAME_SAY"] = "說"
L["CHAN_FULLNAME_TRADE"] = "交易"
L["CHAN_FULLNAME_WHISPERFROM"] = "密語"
L["CHAN_FULLNAME_WHISPERTO"] = "發送給"
L["CHAN_FULLNAME_WORLDDEFENSE"] = "世界防務"
L["CHAN_FULLNAME_YELL"] = "大喊"
L["CHAN_SHORTNAME_BATTLEGROUND"] = "戰"
L["CHAN_SHORTNAME_BIGFOOT"] = "世"
L["CHAN_SHORTNAME_GENERAL"] = "綜"
L["CHAN_SHORTNAME_GUILD"] = "公"
L["CHAN_SHORTNAME_LFGCHANNEL"] = "尋"
L["CHAN_SHORTNAME_LOCALDEFENSE"] = "本"
L["CHAN_SHORTNAME_OFFICER"] = "官"
L["CHAN_SHORTNAME_PARTY"] = "隊"
L["CHAN_SHORTNAME_RAID"] = "團"
L["CHAN_SHORTNAME_TRADE"] = "交"
L["CHAN_SHORTNAME_WHISPERFROM"] = "密"
L["CHAN_SHORTNAME_WHISPERTO"] = "密"
L["CHAN_SHORTNAME_WORLDDEFENSE"] = "世"
L["CHAN_SHORTNAME_YELL"] = "喊"
L["CHAT_MSG_YELL"] = "喊"

-- MessageClassifier
L["DISABLE_TIPS"] = "公共頻道/世界頻道消息去重：已停用"
L["ENABLE_TIPS"] = "公共頻道/世界頻道消息去重：已啟用，可用 /msgdd 命令進行開關。"
L["ENABLE_TIPS_WITH_BIGFOOT"] = "公共頻道/世界頻道消息去重：已啟用，可在小地圖大腳按鍵包中關閉。"
L["RESET_TIPS"] = "公共頻道/世界頻道訊息去重：過濾方式已重置"

-- Options
L["CONFIG_PAGE_TITLE"] = "聊天訊息分類去重"
L["OPTION_ADD"] = "新增"
L["OPTION_CANCEL"] = "取消"
L["OPTION_CLASS"] = "就加入以下分類"
L["OPTION_CLASS_EDIT_TITLE"] = "就加入以下分類 (可用變數: |cffc586c0{作者}|r 和 |cffc586c0{頻道}|r)"
L["OPTION_CLASS_NO_CONDITIONS"] = "總是加入以下分類"
L["OPTION_COND_CASESENSITIVE"] = "區分大小寫"
L["OPTION_CONDITION_FIELD"] = "字段"
L["OPTION_CONDITION_LOGIC"] = "邏輯關係"
L["OPTION_CONDITION_OPERATOR"] = "操作"
L["OPTION_CONDITION_VALUE"] = "值"
L["OPTION_CONDITIONS"] = "如果"
L["OPTION_DEFAULT_RULE_SETS"] = "預設規則"
L["OPTION_EDIT"] = "編輯"
L["OPTION_ENABLE"] = "啟用"
L["OPTION_ENABLED"] = "啟用訊息分類和過濾重複訊息"
L["OPTION_ENABLED_TOOLTIP"] = "不顯示公共頻道/世界頻道中重複的訊息，並將訊息分類收集到訊息瀏覽器中。"
L["OPTION_HIDE_FROM_CHAT_WINDOW"] = "不在聊天視窗中顯示"
L["OPTION_MIN_DUP_INTERVAL"] = "允許重複訊息出現的最短間隔秒數，設為 0 將永遠禁止重複訊息。"
L["OPTION_OPEN_MESSAGE_BROWSER"] = "打開訊息瀏覽器"
L["OPTION_REMOVE"] = "移除"
L["OPTION_RESET"] = "重置過濾方式"
L["OPTION_RESET_TOOLTIP"] = "清除重複訊息記錄，允許重複訊息再次顯示。"
L["OPTION_RULE_LOGIC_AND"] = "全部條件同時成立"
L["OPTION_RULE_LOGIC_OR"] = "其中一個條件成立"
L["OPTION_RULE_SETS"] = "自訂規則"
L["OPTION_RULE_SETS_TITLE"] = "訊息分類規則"
L["OPTION_SAVE"] = "儲存"
L["OPTION_SELECT_ALL"] = "全選"
L["OPTION_RULE_SETS_FILTER"] = "按分類篩選"
L["OPTION_RULE_SETS_FILTER_ALL"] = "顯示所有分類"

-- Rule Fields
L["author"] = "作者"
L["channel"] = "頻道"
L["content"] = "內容"

-- Rule Operators
L["contain"] = "包含"
L["equal"] = "等於"
L["match"] = "符合"
L["not contain"] = "不包含"
L["not equal"] = "不等於"
L["not match"] = "不符合"

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
        ["class"] = "商業/收皮/{author}",
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
        ["class"] = "商業/收布/{author}",
        ["conditions"] = {
            {
                ["value"] = "丝绸",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "絲綢",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "毛料",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 1102,
        ["class"] = "商業/收布/{author}",
        ["conditions"] = {
            {
                ["value"] = "布",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "布莱德",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
            {
                ["value"] = "布萊德",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
        ["logic"] = "and",
    },
    {
        id = 1003,
        ["class"] = "商業/礦石/{author}",
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
        id = 1103,
        ["class"] = "商業/礦石/{author}",
        ["conditions"] = {
            {
                ["value"] = "礦",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "礦工",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
        ["logic"] = "and",
    },
    {
        id = 1203,
        ["class"] = "商業/礦石/{author}",
        ["conditions"] = {
            {
                ["value"] = "锭",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "錠",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 1004,
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
            {
                ["value"] = "飛",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
        ["class"] = "航空/{author}",
    },
    {
        id = 2001,
        ["class"] = "地城/AA/{author}",
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
        ["class"] = "任務/{author}",
        ["conditions"] = {
            {
                ["value"] = "任务",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "任務",
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
            {
                ["value"] = "世界王",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3001,
        ["class"] = "地城/13-18 怒焰裂谷/{author}",
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
    },
    {
        id = 3002,
        ["class"] = "地城/17-24 哀嚎洞穴/{author}",
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
        ["class"] = "地城/17-26 死亡礦坑/{author}",
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
                ["value"] = "礦坑",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "死礦",
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
        ["class"] = "地城/22-30 影牙城堡/{author}",
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
        ["class"] = "地城/24-32 黑澗深淵/{author}",
        ["conditions"] = {
            {
                ["value"] = "黑暗深渊",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "黑暗深淵",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "黑澗",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3205,
        ["class"] = "地城/24-32 黑澗深淵/{author}",
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
        id = 3305,
        ["class"] = "地城/24-32 黑澗深淵/{author}",
        ["logic"] = "and",
        ["conditions"] = {
            {
                ["value"] = "深淵",
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
        ["class"] = "地城/24-32 監獄/{author}",
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
        id = 3105,
        ["class"] = "地城/24-32 監獄/{author}",
        ["logic"] = "and",
        ["conditions"] = {
            {
                ["value"] = "監獄",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "奴隸",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3006,
        ["class"] = "地城/29-38 諾姆瑞根/{author}",
        ["conditions"] = {
            {
                ["value"] = "诺莫",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "諾姆",
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
        ["class"] = "地城/29-38 剃刀沼澤/{author}",
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
        ["class"] = "地城/29-38 剃刀沼澤/{author}",
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
        id = 3207,
        ["class"] = "地城/29-38 剃刀沼澤/{author}",
        ["conditions"] = {
            {
                ["value"] = "沼澤",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3008,
        ["class"] = "地城/26-45 血色修道院/{author}",
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
        ["class"] = "地城/26-36 血色修道院：墓地/{author}",
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
        ["class"] = "地城/29-39 血色修道院：圖書館/{author}",
        ["conditions"] = {
            {
                ["value"] = "图书馆",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "圖書館",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3011,
        ["class"] = "地城/32-42 血色修道院：軍械庫/{author}",
        ["conditions"] = {
            {
                ["value"] = "军械库",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "軍械庫",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3012,
        ["class"] = "地城/35-45 血色修道院：大教堂/{author}",
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
        ["class"] = "地城/37-46 剃刀高地/{author}",
        ["conditions"] = {
            {
                ["value"] = "剃刀高地",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "TDGD",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3113,
        ["class"] = "地城/37-46 剃刀高地/{author}",
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
            {
                ["value"] = "沼澤",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3213,
        ["class"] = "地城/37-46 剃刀高地/{author}",
        ["logic"] = "and",
        ["conditions"] = {
            {
                ["value"] = "高地",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "太阳",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
            {
                ["value"] = "太陽",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3014,
        ["class"] = "地城/41-51 奧達曼/{author}",
        ["conditions"] = {
            {
                ["value"] = "奥达曼",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "奧達曼",
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
        ["class"] = "地城/44-54 祖爾法拉克/{author}",
        ["conditions"] = {
            {
                ["value"] = "祖尔法拉克",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "祖爾法拉克",
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
        ["class"] = "地城/46-55 瑪拉頓/{author}",
        ["conditions"] = {
            {
                ["value"] = "玛拉顿",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "瑪拉頓",
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
        ["class"] = "地城/50-60 阿塔哈卡神廟/{author}",
        ["conditions"] = {
            {
                ["value"] = "阿塔",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "哈卡",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "神庙",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3117,
        ["class"] = "地城/50-60 阿塔哈卡神廟/{author}",
        ["logic"] = "and",
        ["conditions"] = {
            {
                ["value"] = "神廟",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "黑暗",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
            {
                ["value"] = "安其拉",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3018,
        ["class"] = "地城/52-60 黑石深淵/{author}",
        ["conditions"] = {
            {
                ["value"] = "黑石深渊",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "黑石深淵",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3118,
        ["class"] = "地城/52-60 黑石深淵/{author}",
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
        id = 3218,
        ["class"] = "地城/52-60 黑石深淵/{author}",
        ["logic"] = "and",
        ["conditions"] = {
            {
                ["value"] = "深淵",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "黑暗",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
            {
                ["value"] = "黑澗",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3019,
        ["class"] = "地城/55-60 黑石塔/{author}",
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
        ["class"] = "地城/55-60 黑石塔(下層)/{author}",
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
        ["class"] = "地城/55-60 黑石塔(上層)/{author}",
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
        ["class"] = "地城/55-60 厄運之槌/{author}",
        ["conditions"] = {
            {
                ["value"] = "厄运",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "厄運",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3122,
        ["class"] = "地城/55-60 厄運之槌(東)/{author}",
        ["conditions"] = {
            {
                ["value"] = "厄运东",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "厄運東",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3222,
        ["class"] = "地城/58-60 厄運之槌(西)/{author}",
        ["conditions"] = {
            {
                ["value"] = "厄运东",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "厄運西",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3322,
        ["class"] = "地城/58-60 厄運之槌(北)/{author}",
        ["conditions"] = {
            {
                ["value"] = "厄运东",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "厄運北",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3023,
        ["class"] = "地城/58-60 斯坦索姆/{author}",
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
        ["class"] = "地城/58-60 通靈學院/{author}",
        ["conditions"] = {
            {
                ["value"] = "通灵",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "通靈",
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
        ["class"] = "地城/60 熔火之心/{author}",
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
        ["class"] = "地城/60 奧妮克希亞的巢穴/{author}",
        ["conditions"] = {
            {
                ["value"] = "奥妮克希亚",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "奧妮克希亞",
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
                ["value"] = "黑龍",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "龙妹",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "龍妹",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3027,
        ["class"] = "地城/60 黑翼之巢/{author}",
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
        ["class"] = "地城/55-60 祖爾格拉布/{author}",
        ["conditions"] = {
            {
                ["value"] = "祖尔格拉布",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "祖爾格拉布",
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
        ["class"] = "地城/60 安其拉神殿/{author}",
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
        ["class"] = "地城/60 安其拉廢墟/{author}",
        ["conditions"] = {
            {
                ["value"] = "废墟",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "廢墟",
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
        ["class"] = "地城/60+ 納克薩瑪斯/{author}",
        ["conditions"] = {
            {
                ["value"] = "纳克萨玛斯",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "納克薩瑪斯",
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
        ["class"] = "地城/59-67 地獄火壁壘/{author}",
        ["conditions"] = {
            {
                ["value"] = "城墙",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "壁壘",
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
        ["class"] = "地城/60-68 血熔爐/{author}",
        ["conditions"] = {
            {
                ["value"] = "熔炉",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "熔爐",
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
        ["class"] = "地城/69-70 破碎大廳/{author}",
        ["conditions"] = {
            {
                ["value"] = "破碎",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3134,
        ["class"] = "地城/69-70 破碎大廳/{author}",
        ["conditions"] = {
            {
                ["value"] = "大厅",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "塞泰克",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
        ["logic"] = "and",
    },
    {
        id = 3234,
        ["class"] = "地城/69-70 破碎大廳/{author}",
        ["conditions"] = {
            {
                ["value"] = "大廳",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "塞司克",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
        ["logic"] = "and",
    },
    {
        id = 3035,
        ["class"] = "地城/63-70 法力墓地/{author}",
        ["conditions"] = {
            {
                ["value"] = "陵墓",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "墓地",
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
        ["class"] = "地城/63-70 法力墓地/{author}",
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
        ["class"] = "地城/64-70 奧奇奈地穴/{author}",
        ["conditions"] = {
            {
                ["value"] = "奥金尼",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "奧奇奈",
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
        ["class"] = "地城/66-70 塞司克大廳/{author}",
        ["conditions"] = {
            {
                ["value"] = "塞泰克",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "塞司克",
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
        id = 3137,
        ["class"] = "地城/66-70 塞司克大廳/{author}",
        ["conditions"] = {
            {
                ["value"] = "大厅",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "破碎",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
        ["logic"] = "and",
    },
    {
        id = 3237,
        ["class"] = "地城/66-70 塞司克大廳/{author}",
        ["conditions"] = {
            {
                ["value"] = "大廳",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "破碎",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
        ["logic"] = "and",
    },
    {
        id = 3038,
        ["class"] = "地城/69-70 暗影迷宮/{author}",
        ["conditions"] = {
            {
                ["value"] = "暗影",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "迷宫",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "迷宮",
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
        ["class"] = "地城/61-69 奴隸監獄/{author}",
        ["conditions"] = {
            {
                ["value"] = "奴隶",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "奴隸",
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
        ["class"] = "地城/62-70 深幽泥沼/{author}",
        ["conditions"] = {
            {
                ["value"] = "幽暗沼泽",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "深幽",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "泥沼",
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
        ["class"] = "地城/62-70 深幽泥沼/{author}",
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
        ["class"] = "地城/62-70 深幽泥沼/{author}",
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
        ["class"] = "地城/69-70 蒸汽洞窟/{author}",
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
            {
                ["value"] = "地窟",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "洞窟",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3042,
        ["class"] = "地城/66-70 希爾斯布萊德丘陵舊址/{author}",
        ["conditions"] = {
            {
                ["value"] = "丘陵",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "丘陵",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "舊址",
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
        ["class"] = "地城/68-70 黑色沼澤/{author}",
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
        ["class"] = "地城/68-70 黑色沼澤/{author}",
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
        id = 3243,
        ["logic"] = "and",
        ["class"] = "地城/68-70 黑色沼澤/{author}",
        ["conditions"] = {
            {
                ["value"] = "沼澤",
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
    {
        id = 3044,
        ["class"] = "地城/69-70 亞克崔茲/{author}",
        ["conditions"] = {
            {
                ["value"] = "禁魔",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "亞克崔茲",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3144,
        ["class"] = "地城/69-70 亞克崔茲/{author}",
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
        ["class"] = "地城/69-70 亞克崔茲/{author}",
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
        ["class"] = "地城/69-70 亞克崔茲/{author}",
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
        ["class"] = "地城/68-70 麥克納爾/{author}",
        ["conditions"] = {
            {
                ["value"] = "能源舰",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "麥克納爾",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3046,
        ["class"] = "地城/69-70 波塔尼卡/{author}",
        ["conditions"] = {
            {
                ["value"] = "生态船",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "波塔尼卡",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3047,
        ["class"] = "地城/69-70 博學者殿堂/{author}",
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
            {
                ["value"] = "博學",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "殿堂",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3048,
        ["class"] = "地城/68-70 卡拉贊/{author}",
        ["conditions"] = {
            {
                ["value"] = "卡拉赞",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "卡拉贊",
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
        ["class"] = "地城/68-70 祖阿曼/{author}",
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
        ["class"] = "地城/70 瑪瑟里頓的巢穴/{author}",
        ["conditions"] = {
            {
                ["value"] = "玛瑟里顿",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "瑪瑟里頓",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3150,
        ["logic"] = "and",
        ["class"] = "地城/70 瑪瑟里頓的巢穴/{author}",
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
        ["class"] = "地城/65-70 戈魯爾之巢/{author}",
        ["conditions"] = {
            {
                ["value"] = "格鲁尔",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "戈魯爾",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3151,
        ["logic"] = "and",
        ["class"] = "地城/65-70 戈魯爾之巢/{author}",
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
        ["class"] = "地城/70 毒蛇神殿洞穴/{author}",
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
        ["class"] = "地城/70 毒蛇神殿洞穴/{author}",
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
        ["class"] = "地城/70 風暴核心/{author}",
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
            {
                ["value"] = "風暴",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "核心",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3054,
        ["class"] = "地城/70 海加爾山之戰/{author}",
        ["conditions"] = {
            {
                ["value"] = "海加尔",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "海加爾",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3055,
        ["class"] = "地城/70 黑暗神廟/{author}",
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
        ["class"] = "地城/70 黑暗神廟/{author}",
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
            {
                ["value"] = "安其拉",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3255,
        ["logic"] = "and",
        ["class"] = "地城/70 黑暗神廟/{author}",
        ["conditions"] = {
            {
                ["value"] = "神廟",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "阿塔",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
            {
                ["value"] = "哈卡",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
            {
                ["value"] = "安其拉",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3355,
        ["logic"] = "and",
        ["class"] = "地城/70 黑暗神廟/{author}",
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
        ["class"] = "地城/70 太陽之井高地/{author}",
        ["conditions"] = {
            {
                ["value"] = "太阳",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "太陽",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3156,
        ["logic"] = "and",
        ["class"] = "地城/70 太陽之井高地/{author}",
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
