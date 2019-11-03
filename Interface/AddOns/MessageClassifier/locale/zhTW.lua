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
L["DISABLE_TIPS"] = "Public channel/World channel message deduplication: Disabled"
L["ENABLE_TIPS"] = "Public channel/World channel message deduplication: Enabled. You can toggle it with command /msgdd"
L["ENABLE_TIPS_WITH_BIGFOOT"] = "Public channel/World channel message deduplication: Enabled. You can turn it off in the minimap BigFoot button package."
L["RESET_TIPS"] = "Public channel/World channel message deduplication: Filter has been reset"

-- Options
L["CONFIG_PAGE_TITLE"] = "聊天消息分類去重"
L["OPTION_ENABLED"] = "啓用重複消息過濾"
L["OPTION_ENABLED_TOOLTIP"] = "不顯示公共頻道/世界頻道中重複的消息"
L["OPTION_MIN_DUP_INTERVAL"] = "允許重復消息出現的最短間隔秒數，設為0始終禁止重複消息"
L["OPTION_RESET"] = "重置過濾器"
L["OPTION_RESET_TOOLTIP"] = "清除重復消息記錄，允許重復消息再次顯示"
L["OPTION_OPEN_MESSAGE_BROWSER"] = "打開消息瀏覽器"
L["OPTION_RULE_SETS_TITLE"] = "消息分類規則"
L["OPTION_ADD"] = "添加"
L["OPTION_EDIT"] = "編輯"
L["OPTION_SAVE"] = "保存"
L["OPTION_CANCEL"] = "取消"
L["OPTION_REMOVE"] = "移除"
L["OPTION_RULE_SETS"] = "自定義規則"
L["OPTION_DEFAULT_RULE_SETS"] = "默認規則"
L["OPTION_CONDITIONS"] = "條件"
L["OPTION_CONDITION_LOGIC"] = "邏輯關係"
L["OPTION_RULE_LOGIC_OR"] = "其中一個條件成立"
L["OPTION_RULE_LOGIC_AND"] = "全部條件同時成立"
L["OPTION_HIDE_FROM_CHAT_WINDOW"] = "不在聊天窗口顯示"
L["OPTION_ENABLE"] = "啓用"
L["OPTION_CLASS"] = "分類"
L["OPTION_CLASS_EDIT_TITLE"] = "分類 (可用變量: |cffc586c0{作者}|r 和 |cffc586c0{頻道}|r)"
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
L["unconditional"] = "無條件"
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
        conditions = {
            { operator = "unconditional" },
        },
        class = L["BROWSER_CLASSIFIED_BY_AUTHOR"]:format("{author}")
    },
    {
        id = 2,
        conditions = {
            { operator = "unconditional" },
        },
        class = L["BROWSER_CLASSIFIED_BY_CHANNEL"]:format("{channel}")
    },
    {
        id = 3,
        conditions = {
            { operator = "unconditional" },
        },
        class = L["BROWSER_CLASSIFIED_ALL_MESSAGES"]
    }
}
