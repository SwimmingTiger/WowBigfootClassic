local L = LibStub("AceLocale-3.0"):NewLocale(..., "zhTW")
if not L then return end

-------------------------------------------------------------

L = L or {}
-- Browser
L["BROWSER_CLASSIFIED_BY_AUTHOR"] = "玩家列表/%s"
L["BROWSER_CLASSIFIED_BY_CHANNEL"] = "頻道列表/%s"
L["BROWSER_CLASSIFIED_ALL_MESSAGES"] = "全部發言"
L["BROWSER_STATUS_BAR"] = "共 %d 消息, 唯一 %d, 重複 %d, 重複率 %0.2f%%"
L["BROWSER_TITLE"] = "消息瀏覽器"
L["MOVE_BUTTON"] = "移動按鈕"
L["Left-Click"] = "左鍵"
L["Shift-Click"] = "Shift-左鍵"
L["BROWSER_SETTING"] = "設置"
L["BROWSER_SEARCH"] = "搜索"

-- MessageClassifier
L["DISABLE_TIPS"] = "公共頻道/世界頻道消息去重：已停用"
L["ENABLE_TIPS"] = "公共頻道/世界頻道消息去重：已啟用，可用 /msgdd 命令進行開關。"
L["ENABLE_TIPS_WITH_BIGFOOT"] = "公共頻道/世界頻道消息去重：已啟用，可在小地圖大腳按鍵包中關閉"
L["RESET_TIPS"] = "公共頻道/世界頻道消息去重：過濾器已重置"

-- Options
L["CONFIG_PAGE_TITLE"] = "聊天消息分類去重"
L["OPTION_ENABLED"] = "啟用消息分類和重複消息過濾"
L["OPTION_ENABLED_TOOLTIP"] = "不顯示公共頻道/世界頻道中重複的消息，並將消息分類收集到消息瀏覽器中"
L["OPTION_MIN_DUP_INTERVAL"] = "允許重複消息出現的最短間隔秒數，設為0始終禁止重複消息"
L["OPTION_RESET"] = "重置過濾器"
L["OPTION_RESET_TOOLTIP"] = "清除重複消息記錄，允許重複消息再次顯示"
L["OPTION_OPEN_MESSAGE_BROWSER"] = "打開消息瀏覽器"
L["OPTION_RULE_SETS_TITLE"] = "消息分類規則"
L["OPTION_ADD"] = "添加"
L["OPTION_EDIT"] = "編輯"
L["OPTION_SAVE"] = "保存"
L["OPTION_CANCEL"] = "取消"
L["OPTION_REMOVE"] = "移除"
L["OPTION_RULE_SETS"] = "自定義規則"
L["OPTION_DEFAULT_RULE_SETS"] = "默認規則"
L["OPTION_CONDITIONS"] = "如果"
L["OPTION_CONDITION_LOGIC"] = "邏輯關係"
L["OPTION_RULE_LOGIC_OR"] = "其中一個條件成立"
L["OPTION_RULE_LOGIC_AND"] = "全部條件同時成立"
L["OPTION_HIDE_FROM_CHAT_WINDOW"] = "不在聊天窗口顯示"
L["OPTION_ENABLE"] = "啟用"
L["OPTION_CLASS"] = "就加入以下分類"
L["OPTION_CLASS_NO_CONDITIONS"] = "總是加入以下分類"
L["OPTION_CLASS_EDIT_TITLE"] = "就加入以下分類 (可用變量: |cffc586c0{作者}|r 和 |cffc586c0{頻道}|r)"
L["OPTION_CONDITION_FIELD"] = "字段"
L["OPTION_CONDITION_OPERATOR"] = "操作"
L["OPTION_CONDITION_VALUE"] = "值"
L["OPTION_COND_CASESENSITIVE"] = "區分大小寫"
L["OPTION_SELECT_ALL"] = "全選"

-- Localized class variable
L["author"] = "作者"
L["channel"] = "頻道"
L["content"] = "內容"

-- Rule Operators
L["equal"] = "等於"
L["not equal"] = "不等於"
L["contain"] = "包含"
L["not contain"] = "不包含"
L["match"] = "匹配"
L["not match"] = "不匹配"

-- Channels
L["CHAN_FULLNAME_GUILD"]="公會"
L["CHAN_FULLNAME_RAID"]="團隊"
L["CHAN_FULLNAME_PARTY"]="小隊"
L["CHAN_FULLNAME_GENERAL"]="綜合"
L["CHAN_FULLNAME_TRADE"]="交易"
L["CHAN_FULLNAME_WORLDDEFENSE"]="世界防務"
L["CHAN_FULLNAME_LOCALDEFENSE"]="本地防務"
L["CHAN_FULLNAME_LFGCHANNEL"]="尋求組隊"
L["CHAN_FULLNAME_BATTLEGROUND"]="戰場"
L["CHAN_FULLNAME_YELL"]="喊道"
L["CHAN_FULLNAME_SAY"]="說"
L["CHAN_FULLNAME_WHISPERTO"]="發送給"
L["CHAN_FULLNAME_WHISPERFROM"]="悄悄地說"
L["CHAN_FULLNAME_BIGFOOTCHANNEL"] = "大腳世界頻道"
L["CHAN_SHORTNAME_GUILD"]="公"
L["CHAN_SHORTNAME_RAID"]="團"
L["CHAN_SHORTNAME_PARTY"]="隊"
L["CHAN_SHORTNAME_YELL"]="喊"
L["CHAN_SHORTNAME_BATTLEGROUND"]="戰"
L["CHAN_SHORTNAME_OFFICER"]="官"
L["CHAN_SHORTNAME_BIGFOOT"]="世";
L["CHAN_SHORTNAME_WHISPERTO"]="密"
L["CHAN_SHORTNAME_WHISPERFROM"]="密"
L["CHAN_SHORTNAME_GENERAL"]="綜"
L["CHAN_SHORTNAME_TRADE"]="交"
L["CHAN_SHORTNAME_LOCALDEFENSE"]="本"
L["CHAN_SHORTNAME_LFGCHANNEL"]="尋"
L["CHAN_SHORTNAME_WORLDDEFENSE"]="世"

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
        ["class"] = "收皮/{author}",
        ["conditions"] = {
            {
                ["value"] = "厚皮",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [1]
        },
    }, -- [1]
    {
        id = 1002,
        ["class"] = "收布/{author}",
        ["conditions"] = {
            {
                ["value"] = "絲綢",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "紋布",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
        },
    }, -- [2]
    {
        id = 1003,
        ["conditions"] = {
            {
                ["value"] = "航空",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [1]
        },
        ["class"] = "航空/{author}",
    }, -- [3]
    {
        id = 2001,
        ["class"] = "地城/AA/{author}",
        ["conditions"] = {
            {
                ["value"] = "AA",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [4]
    {
        id = 2002,
        ["class"] = "任務/{author}",
        ["conditions"] = {
            {
                ["value"] = "任務",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [5]
    {
        id = 3001,
        ["conditions"] = {
            {
                ["value"] = "怒焰",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [1]
            {
                ["value"] = "NY",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
        },
        ["class"] = "地城/怒焰裂谷/{author}",
    }, -- [6]
    {
        id = 3002,
        ["class"] = "地城/哀嚎洞穴/{author}",
        ["conditions"] = {
            {
                ["value"] = "哀嚎",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "AH",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
        },
    }, -- [7]
    {
        id = 3003,
        ["class"] = "地城/死亡礦坑/{author}",
        ["conditions"] = {
            {
                ["value"] = "礦坑",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "死礦",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
            {
                ["value"] = "SK",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [3]
        },
    }, -- [8]
    {
        id = 3004,
        ["class"] = "地城/影牙城堡/{author}",
        ["conditions"] = {
            {
                ["value"] = "影牙",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [1]
            {
                ["value"] = "YY",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [2]
        },
    }, -- [9]
    {
        id = 3105,
        ["class"] = "地城/黑澗深淵/{author}",
        ["conditions"] = {
            {
                ["value"] = "黑澗",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [10]
    {
        id = 3005,
        ["class"] = "地城/監獄/{author}",
        ["conditions"] = {
            {
                ["value"] = "監獄",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [10]
    {
        id = 3006,
        ["class"] = "地城/諾姆瑞根/{author}",
        ["conditions"] = {
            {
                ["value"] = "諾姆",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "瑞根",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [2]
            {
                ["value"] = "矮子",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [3]
        },
    }, -- [11]
    {
        id = 3007,
        ["class"] = "地城/剃刀沼澤/{author}",
        ["conditions"] = {
            {
                ["value"] = "剃刀",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "沼澤",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
            {
                ["value"] = "ZZ",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [3]
        },
    }, -- [12]
    {
        id = 3008,
        ["class"] = "地城/血色修道院/{author}",
        ["conditions"] = {
            {
                ["value"] = "血色",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [13]
    {
        id = 3009,
        ["class"] = "地城/血色修道院：墓地/{author}",
        ["conditions"] = {
            {
                ["value"] = "墓地",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [14]
    {
        id = 3010,
        ["class"] = "地城/血色修道院：圖書館/{author}",
        ["conditions"] = {
            {
                ["value"] = "圖書館",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [15]
    {
        id = 3011,
        ["class"] = "地城/血色修道院：軍械庫/{author}",
        ["conditions"] = {
            {
                ["value"] = "軍械庫",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [16]
    {
        id = 3012,
        ["class"] = "地城/血色修道院：大教堂/{author}",
        ["conditions"] = {
            {
                ["value"] = "教堂",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [17]
    {
        id = 3013,
        ["class"] = "地城/剃刀高地/{author}",
        ["conditions"] = {
            {
                ["value"] = "剃刀",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "高地",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
            {
                ["value"] = "TDGD",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [3]
            {
                ["value"] = "GD",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [4]
        },
    }, -- [18]
    {
        id = 3014,
        ["class"] = "地城/奧達曼/{author}",
        ["conditions"] = {
            {
                ["value"] = "奧達曼",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "ADM",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
        },
    }, -- [19]
    {
        id = 3015,
        ["class"] = "地城/祖爾法拉克/{author}",
        ["conditions"] = {
            {
                ["value"] = "祖爾",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "zul",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
        },
    }, -- [20]
    {
        id = 3016,
        ["class"] = "地城/瑪拉頓/{author}",
        ["conditions"] = {
            {
                ["value"] = "瑪拉頓",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "MLD",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
        },
    }, -- [21]
    {
        id = 3017,
        ["class"] = "地城/阿塔哈卡神廟/{author}",
        ["conditions"] = {
            {
                ["value"] = "神廟",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [22]
    {
        id = 3018,
        ["class"] = "地城/黑石深淵/{author}",
        ["conditions"] = {
            {
                ["value"] = "深淵",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [23]
    {
        id = 3019,
        ["class"] = "地城/黑石塔/{author}",
        ["conditions"] = {
            {
                ["value"] = "黑石塔",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [24]
    {
        id = 3020,
        ["class"] = "地城/黑石塔(下層)/{author}",
        ["conditions"] = {
            {
                ["value"] = "黑下",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [25]
    {
        id = 3021,
        ["class"] = "地城/黑石塔(上層)/{author}",
        ["conditions"] = {
            {
                ["value"] = "黑上",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [26]
    {
        id = 3022,
        ["class"] = "地城/厄運之槌/{author}",
        ["conditions"] = {
            {
                ["value"] = "厄運",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [27]
    {
        id = 3023,
        ["class"] = "地城/斯坦索姆/{author}",
        ["conditions"] = {
            {
                ["value"] = "斯坦索姆",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "STSM",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
        },
    }, -- [28]
    {
        id = 3024,
        ["class"] = "地城/通靈學院/{author}",
        ["conditions"] = {
            {
                ["value"] = "通靈",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "TL",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
        },
    }, -- [29]
    {
        id = 3025,
        ["class"] = "地城/熔火之心/{author}",
        ["conditions"] = {
            {
                ["value"] = "MC",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "熔火",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
        },
    }, -- [30]
    {
        id = 3026,
        ["class"] = "地城/奧妮克希亞的巢穴/{author}",
        ["conditions"] = {
            {
                ["value"] = "黑龍",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "巢穴",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [3]
            {
                ["value"] = "龍妹",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [31]
}
