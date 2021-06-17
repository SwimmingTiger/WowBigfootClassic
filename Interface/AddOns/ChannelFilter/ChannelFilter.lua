local _
local ChannelFilter_a025bf316dae1633b9c38db34e565b5f, login
local ChannelFilter_76d6f12ba3810515a6368ac18850ddac, ChannelFilter_f6fa3c07b3d3d1066da321072c9f8b53
local good, maybe, filterTable, maybeGood = {}, {}, {}
local ChannelFilter_6871a3b1763bbc925b1adeb8fade8acb = {}
local fullLevel = 100
local ChannelFilter_49a34e51f5b777fb9f2d3ec8bfc169f2 = UnitName("player")
local Symbols = {
    "`",
    "~",
    "@",
    "#",
    "^",
    "*",
    "=",
    "|",
    " ",
    "，",
    "。",
    "、",
    "？",
    "！",
    "：",
    "；",
    "’",
    "‘",
    "“",
    "”",
    "【",
    "】",
    "『",
    "』",
    "《",
    "》",
    "<",
    ">",
    "（",
    "）"
}
local ChatFrame1EditBox = ChatFrame1EditBox or ChatFrameEditBox
if (GetLocale() == "zhCN") then
    CHANNEL_FILTER_MSG_ALREADY_EXIST = '|cff00adef[聊天优化]|r 关键字"|cffff0000%s|r"已经存在于文字列表中。'
    CHANNEL_FILTER_MSG_ADDED = '|cff00adef[聊天优化]|r 关键字"|cffff0000%s|r"已经被加入至文字列表中。'
    CHANNEL_FILTER_MSG_REMOVED = '|cff00adef[聊天优化]|r 关键字"|cffff0000%s|r"已经从文字列表中删除。'
    CHANNEL_FILTER_MSG_KEY_NOT_FOUND = '|cff00adef[聊天优化]|r 没有找到关键字"|cffff0000%s|r"。'
    CHANNEL_FILTER_MSG_OUT_OF_BOUND = "|cff00adef[聊天优化]|r 过滤列表中不存在该序号。"
    CHANNEL_FILTER_MSG_ALL_CLEAR = "|cff00adef[聊天优化]|r 过滤列表中的所有数据已经删除。"
    CHANNEL_FILTER_MSG_ENABLE = "|cff00adef[聊天优化]|r 开启聊天优化功能。"
    CHANNEL_FILTER_MSG_DISABLE = "|cff00adef[聊天优化]|r 关闭聊天优化功能。"
    CHANNEL_FILTER_MSG_RESET = "|cff00adef[聊天优化]|r 过滤列表已经被重置为缺省设置。"
    CHANNEL_FILTER_MSG_ORDERRESET = "|cff00adef[聊天优化]|r 查找列表已经被重置为缺省设置。"
    CHANNEL_FILTER_MSG_USAGE_PINGBI_FUNCTION = "\n功能：将某条文字加入到屏蔽文字列表中，凡是出现该文字字眼的频道消息将被自动屏蔽掉。"
    CHANNEL_FILTER_MSG_USAGE_PINGBI_USAGE = "使用格式：/guolv|cff00ff00[空格]|r+|cff00ff00[空格]|r<屏蔽文字>"
    CHANNEL_FILTER_MSG_USAGE_PINGBI_EXAMPLE = "样例：/guolv + 出售外挂"
    CHANNEL_FILTER_MSG_EMPTY_LIST = "|cffff0000不存在数据。|r"
    CHANNEL_FILTER_MSG_LIST_TITLE = "|cffffffff屏蔽文字列表中包括如下：|r"
    CHANNEL_FILTER_MSG_SELECT = '请输入"/guolv - <序号>"来删除列表中的屏蔽文字。'
    CHANNEL_HELP_TEXT1 = "\n|cffffffff聊天优化命令使用帮助：|r"
    CHANNEL_HELP_TEXT2 = "/guolv + <过滤字眼> |cff00ff00增加过滤关键字|r"
    CHANNEL_HELP_TEXT3 = "/guolv - <序号> |cff00ff00删除列表中的关键字|r"
    CHANNEL_HELP_TEXT4 = "/guolv - * |cff00ff00删除列表中的所有关键字|r"
    CHANNEL_HELP_TEXT5 = "/guolv * |cff00ff00显示过滤列表中的关键字|r"
    CHANNEL_HELP_TEXT6 = "/guolv on |cff00ff00开启聊天优化功能|r"
    CHANNEL_HELP_TEXT7 = "/guolv off |cff00ff00关闭聊天优化功能|r"
    CHANNEL_FILTER_ENABLE_TEXT = "开启聊天过滤功能"
    CHANNEL_FILTER_BAN_TEXT = "启用关键词过滤"
    CHANNEL_FILTER_BAN_TEXT_TOOLTIP = "对主聊天窗口的大脚世界频道进行信息过滤,可自定义增加过滤内容关键词。"
    CHANNEL_FILTER_ORDER_TEXT = "启用关键词查找"
    CHANNEL_FILTER_ORDER_TEXT_TOOLTIP = "为主聊天窗口的大脚世界频道提供关键词白名单,在接收信息时筛选出仅含该关键词的信息显示。"
    CHANNEL_FILTER_LEVEL = "屏蔽等级："
    CHANNEL_FILTER_LEVEL_TEXT = "启用密语等级过滤"
    CHANNEL_FILTER_LEVEL_TEXT_TOOLTIP = "屏蔽低于设置等级的账号密语,死亡骑士为58级"
    CHANNEL_FILTER_whisp = "[大脚聊天优化]: 你起码要达到 %d 级才能和我讲话。"
    CHANNEL_FILTER_TITLE = {"聊天优化", "pindaoguolv"}
    CHANNEL_FILTER_ADD_TEXT = "增加"
    CHANNEL_FILTER_REMOVE_TEXT = "删除"
    CHANNEL_FILTER_REST_TEXT = "重置"
    CHANNEL_FILTER_ADD_WORD_TEXT = "请输入你想要屏蔽的文字："
    CHANNEL_FILTER_ADD_ORDERWORD_TEXT = "请输入你想要查找的文字："
    ChannelFilter_NewIgnoreWords_Default = {"付款", "代练"}
    ChannelFilter_NewOrderWords_Default = {"成就", "幻化"}
    CHANNEL_FILTER_MUTE_LABEL = "频道消息"
    CHANNEL_FILTER_MUTE_DESC = "点击按钮进行切换是否屏蔽频道信息"
    CHANNEL_FILTER_MSG_BLOCKED = "|cff00adef[聊天优化]|r 停止接收公共频道信息。"
    CHANNEL_FILTER_MSG_UNBLOCKED = "|cff00adef[聊天优化]|r 继续接收公共频道信息。"
    CHANNEL_FILTER_MSG_ERR = "你的好友列表满了,聊天优化(ChannelFilter)插件需要你腾出2个好友空位!"
elseif (GetLocale() == "zhTW") then
    CHANNEL_FILTER_MSG_ALREADY_EXIST = '|cff00adef[聊天優化]|r 關鍵字"|cffff0000%s|r"已經存在于文字列表中。'
    CHANNEL_FILTER_MSG_ADDED = '|cff00adef[聊天優化]|r 關鍵字"|cffff0000%s|r"已經被加入至文字列表中。'
    CHANNEL_FILTER_MSG_REMOVED = '|cff00adef[聊天優化]|r 關鍵字"|cffff0000%s|r"已經從文字列表中刪除。'
    CHANNEL_FILTER_MSG_KEY_NOT_FOUND = '|cff00adef[聊天優化]|r 沒有找到關鍵字"|cffff0000%s|r"。'
    CHANNEL_FILTER_MSG_OUT_OF_BOUND = "|cff00adef[聊天優化]|r 過濾列表中不存在該序號。"
    CHANNEL_FILTER_MSG_ALL_CLEAR = "|cff00adef[聊天優化]|r 過濾列表中的所有數據已經刪除。"
    CHANNEL_FILTER_MSG_ENABLE = "|cff00adef[聊天優化]|r 開啓聊天優化功能。"
    CHANNEL_FILTER_MSG_DISABLE = "|cff00adef[聊天優化]|r 關閉聊天優化功能。"
    CHANNEL_FILTER_MSG_USAGE_PINGBI_FUNCTION = "\n功能：將某條文字加入到屏蔽文字列表中，凡是出現該文字字眼的頻道消息將被自動屏蔽掉。"
    CHANNEL_FILTER_MSG_USAGE_PINGBI_USAGE = "使用格式：/guolv|cff00ff00[空格]|r+|cff00ff00[空格]|r<屏蔽文字>"
    CHANNEL_FILTER_MSG_USAGE_PINGBI_EXAMPLE = "樣例：/guolv + 出售外挂"
    CHANNEL_FILTER_MSG_EMPTY_LIST = "|cffff0000不存在數據。|r"
    CHANNEL_FILTER_MSG_LIST_TITLE = "|cffffffff屏蔽文字列表中包括如下：|r"
    CHANNEL_FILTER_MSG_SELECT = '請輸入"/guolv - <序號>"來刪除列表中的屏蔽文字。'
    CHANNEL_HELP_TEXT1 = "\n|cffffffff聊天優化命令使用幫助：|r"
    CHANNEL_HELP_TEXT2 = "/guolv + <過濾字眼> |cff00ff00增加過濾關鍵字|r"
    CHANNEL_HELP_TEXT3 = "/guolv - <序號> |cff00ff00刪除列表中的關鍵字|r"
    CHANNEL_HELP_TEXT4 = "/guolv - * |cff00ff00刪除列表中的所有關鍵字|r"
    CHANNEL_HELP_TEXT5 = "/guolv * |cff00ff00顯示過濾列表中的關鍵字|r"
    CHANNEL_HELP_TEXT6 = "/guolv on |cff00ff00開啓聊天優化功能|r"
    CHANNEL_HELP_TEXT7 = "/guolv off |cff00ff00關閉聊天優化功能|r"
    CHANNEL_FILTER_ENABLE_TEXT = "開啓聊天優化功能"
    CHANNEL_FILTER_BAN_TEXT = "啟用關鍵字過濾"
    CHANNEL_FILTER_BAN_TEXT_TOOLTIP = "對大腳世界頻道進行信息過濾，可自定義增加過濾內容關鍵字。"
    CHANNEL_FILTER_ORDER_TEXT = "啟用關鍵字查找"
    CHANNEL_FILTER_ORDER_TEXT_TOOLTIP = "為大腳世界頻道提供關鍵字白名單，在過量信息中篩選出僅含該關鍵字的信息。"
    CHANNEL_FILTER_LEVEL = "屏蔽等級："
    CHANNEL_FILTER_LEVEL_TEXT = "啟用等級過濾"
    CHANNEL_FILTER_TITLE = {"聊天優化", "pindaoguolv"}
    CHANNEL_FILTER_ADD_TEXT = "增加"
    CHANNEL_FILTER_REMOVE_TEXT = "刪除"
    CHANNEL_FILTER_REST_TEXT = "重置"
    CHANNEL_FILTER_ADD_WORD_TEXT = "請輸入你想要屏蔽的文字："
    CHANNEL_FILTER_ADD_ORDERWORD_TEXT = "請輸入你想要查詢的文字："
    ChannelFilter_NewIgnoreWords_Default = {"付款", "代練"}
    ChannelFilter_NewOrderWords_Default = {"幻化", "成就"}
    CHANNEL_FILTER_MUTE_LABEL = "頻道消息"
    CHANNEL_FILTER_MUTE_DESC = "點擊按鈕進行切換是否屏蔽頻道信息"
    CHANNEL_FILTER_MSG_BLOCKED = "|cff00adef[聊天优化]|r 已屏蔽公共頻道信息。"
    CHANNEL_FILTER_MSG_UNBLOCKED = "|cff00adef[聊天优化]|r 已停止屏蔽公共頻道信息。"
    CHANNEL_FILTER_MSG_ERR = "你的好友列表滿了，ChannelFilter需要你騰出2個好友空位!"
else
    CHANNEL_FILTER_MSG_ALREADY_EXIST = '|cff00adef[ChannelFilter]|r Keyword "|cffff0000%s|r" is already exist in list.'
    CHANNEL_FILTER_MSG_ADDED = '|cff00adef[ChannelFilter]|r Keyword "|cffff0000%s|r" has been added into list.'
    CHANNEL_FILTER_MSG_REMOVED = '|cff00adef[ChannelFilter]|r Keyword "|cffff0000%s|r" has been removed from list.'
    CHANNEL_FILTER_MSG_KEY_NOT_FOUND = '|cff00adef[ChannelFilter]|r Can not find keyword "|cffff0000%s|r"。'
    CHANNEL_FILTER_MSG_OUT_OF_BOUND = "|cff00adef[ChannelFilter]|r The number does not exist in ignore list."
    CHANNEL_FILTER_MSG_ALL_CLEAR = "|cff00adef[ChannelFilter]|r All data in ignore list has been removed."
    CHANNEL_FILTER_MSG_ENABLE = "|cff00adef[ChannelFilter]|r Channel Filter On."
    CHANNEL_FILTER_MSG_DISABLE = "|cff00adef[ChannelFilter]|r Channel Filter Off"
    CHANNEL_FILTER_MSG_USAGE_PINGBI_FUNCTION =
        "\nFunction: Add words into ignore list to prevent from being shown in channel."
    CHANNEL_FILTER_MSG_USAGE_PINGBI_USAGE = "Usage: /guolv|cff00ff00[space]|r+|cff00ff00[space]|r<Ignore words>"
    CHANNEL_FILTER_MSG_USAGE_PINGBI_EXAMPLE = "Sample: /guolv + Sell Gold"
    CHANNEL_FILTER_MSG_EMPTY_LIST = "|cffff0000The data does not exist.|r"
    CHANNEL_FILTER_MSG_LIST_TITLE = "|cffffffffThe follwing are included in ignore list:|r"
    CHANNEL_FILTER_MSG_SELECT = 'Please input "/guolv - <No.>" to delete item in ignore list.'
    CHANNEL_HELP_TEXT1 = "\n|cffffffffChannel Filter Help:|r"
    CHANNEL_HELP_TEXT2 = "/guolv + <words> |cff00ff00Add words into ignore list.|r"
    CHANNEL_HELP_TEXT3 = "/guolv - <No.> |cff00ff00Delete keywords.|r"
    CHANNEL_HELP_TEXT4 = "/guolv - * |cff00ff00Delete all keywords in ignore list.|r"
    CHANNEL_HELP_TEXT5 = "/guolv * |cff00ff00Show keywords in ignore list.|r"
    CHANNEL_HELP_TEXT6 = "/guolv on |cff00ff00Enable Channel Filter|r"
    CHANNEL_HELP_TEXT7 = "/guolv off |cff00ff00Close Channel Filter|r"
    CHANNEL_FILTER_ENABLE_TEXT = "Enable Channel Filter"
    CHANNEL_FILTER_BAN_TEXT = "Enable keywords filtering"
    CHANNEL_FILTER_BAN_TEXT_TOOLTIP =
        "The world of bigfoot channels of information filtering, can be defined increase filter content keywords."
    CHANNEL_FILTER_ORDER_TEXT = "Enable keywords to search"
    CHANNEL_FILTER_ORDER_TEXT_TOOLTIP =
        "For bigfoot world channel to provide key words white list, were in excess it only contains the key words of information."
    CHANNEL_FILTER_LEVEL = "Filter Level:"
    CHANNEL_FILTER_LEVEL_TEXT = "Enable Filter Level:"
    CHANNEL_FILTER_TITLE = "Channel Filter"
    CHANNEL_FILTER_ADD_TEXT = "Add"
    CHANNEL_FILTER_REMOVE_TEXT = "Delete"
    CHANNEL_FILTER_REST_TEXT = "Reset"
    CHANNEL_FILTER_ADD_WORD_TEXT = "Please type the word you want to ban:"
    CHANNEL_FILTER_ADD_ORDERWORD_TEXT = "Please type the word you want to order:"
    ChannelFilter_NewIgnoreWords_Default = {}
    ChannelFilter_NewOrderWords_Default = {}
    CHANNEL_FILTER_MUTE_LABEL = "Channel Messages"
    CHANNEL_FILTER_MUTE_DESC = "Click to toggle showing channel messages"
    CHANNEL_FILTER_MSG_BLOCKED = "|cff00adefPublic Channels have been blocked。"
    CHANNEL_FILTER_MSG_UNBLOCKED = "|cff00adefPublic Channels have been unblocked。"
    CHANNEL_FILTER_MSG_ERR =
        "You have reached the maximum amount of friends, remove 2 for ChannelFilter to function properly!"
end
local addMsg, hookFunc
do
    local addFrnd = ERR_FRIEND_ADDED_S:gsub("%%s", "([^ ]+)")
    local rmvFrnd = ERR_FRIEND_REMOVED_S:gsub("%%s", "([^ ]+)")
    local info = ChatTypeInfo.SYSTEM
    hookFunc = function(f, msg, r, g, b, ...)
        if r == info.r and g == info.g and b == info.b then
            local _, _, player = msg:find(addFrnd)
            if not player then
                _, _, player = msg:find(rmvFrnd)
            end
            if player and filterTable[player] then
                return
            end
        end
        return addMsg(f, msg, r, g, b, ...)
    end
end
local function ChannelFilter_cca6e81523d4253f35038608e9e1dae1(ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88)
    ChatFrame1:AddMessage(ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88, 1.0, 1.0, 0.0)
end
local function ChannelFilter_0900e4822400fb50cfa421dc6b6a0106()
    ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_HELP_TEXT1)
    ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_HELP_TEXT2)
    ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_HELP_TEXT3)
    ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_HELP_TEXT4)
    ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_HELP_TEXT5)
    ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_HELP_TEXT6)
    ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_HELP_TEXT7)
end
local function ChannelFilter_d9a31f63708362057d280f4e78db3ea3(ChannelFilter_413bf9c15ce77baa8ebf1cda4cbf4887)
    table.insert(ChannelFilter_Config.IgnoreWords, ChannelFilter_413bf9c15ce77baa8ebf1cda4cbf4887)
end
local function ChannelFilter_64a0cf1bf3d70800780391512ec16e8a(ChannelFilter_413bf9c15ce77baa8ebf1cda4cbf4887)
    table.insert(ChannelFilter_Config.OrderWords, ChannelFilter_413bf9c15ce77baa8ebf1cda4cbf4887)
end
local function ChannelFilter_31d2b1f6c943bbb6272644a023663342(ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)
    local ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88
    if (not ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae or ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae == "") then
        ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_FILTER_MSG_USAGE_PINGBI_FUNCTION)
        ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_FILTER_MSG_USAGE_PINGBI_USAGE)
        ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_FILTER_MSG_USAGE_PINGBI_EXAMPLE)
        return
    end
    for __index = 1, #ChannelFilter_Config.IgnoreWords, 1 do
        if (ChannelFilter_Config.IgnoreWords[__index] == ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae) then
            ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88 =
                string.format(CHANNEL_FILTER_MSG_ALREADY_EXIST, ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)
            ChannelFilter_cca6e81523d4253f35038608e9e1dae1(ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88)
            return
        end
    end
    ChannelFilter_d9a31f63708362057d280f4e78db3ea3(ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)
    ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88 =
        string.format(CHANNEL_FILTER_MSG_ADDED, ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)
    ChannelFilter_cca6e81523d4253f35038608e9e1dae1(ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88)
end
local function ChannelFilter_497b6c3a9fa37cdb095d6f39ba0adf2d(ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)
    local ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88
    for __index = 1, #ChannelFilter_Config.OrderWords, 1 do
        if (ChannelFilter_Config.OrderWords[__index] == ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae) then
            ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88 =
                string.format(CHANNEL_FILTER_MSG_ALREADY_EXIST, ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)
            ChannelFilter_cca6e81523d4253f35038608e9e1dae1(ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88)
            return
        end
    end
    ChannelFilter_64a0cf1bf3d70800780391512ec16e8a(ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)
    ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88 =
        string.format(CHANNEL_FILTER_MSG_ADDED, ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)
    ChannelFilter_cca6e81523d4253f35038608e9e1dae1(ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88)
end
local function ChannelFilter_ff376af5724fd739f29ed8014d542a7b(__index)
    return ChannelFilter_76d6f12ba3810515a6368ac18850ddac
end
local function ChannelFilter_d0051d21b741a038fff5c35e3d912fd7(__index)
    return ChannelFilter_f6fa3c07b3d3d1066da321072c9f8b53
end
local function ChannelFilter_UpdateOption()
    local ChannelFilter_99f3cf2c6f1fdfadb0fd4ab6e0843bf5, ChannelFilter_e6955c64cf39bdb23dc86de1a9ec2117
    if (ChannelFilter_Config.Enabled) then
        ChannelFilterEnable:SetChecked(true)
        MobElement_Enable(ChannelFilterBanCheckButton)
        if ChannelFilter_Config.BanEnabled then
            ChannelFilterBanCheckButton:SetChecked(true)
            for i = 1, 2, 1 do
                ChannelFilter_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 = getglobal("ChannelFilterWordButton" .. i)
                ChannelFilter_e6955c64cf39bdb23dc86de1a9ec2117 =
                    getglobal("ChannelFilterWordButton" .. i .. "ButtonTextName")
                ChannelFilter_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:Enable()
                ChannelFilter_e6955c64cf39bdb23dc86de1a9ec2117:SetTextColor(1.0, 0.82, 0)
            end
            ChannelFilterAddButton:Enable()
            if (ChannelFilter_ff376af5724fd739f29ed8014d542a7b()) then
                ChannelFilterRemoveButton:Enable()
            end
            ChannelFilterResetButton:Enable()
        else
            for i = 1, 2, 1 do
                ChannelFilter_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 = getglobal("ChannelFilterWordButton" .. i)
                ChannelFilter_e6955c64cf39bdb23dc86de1a9ec2117 =
                    getglobal("ChannelFilterWordButton" .. i .. "ButtonTextName")
                ChannelFilter_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:Disable()
                ChannelFilter_e6955c64cf39bdb23dc86de1a9ec2117:SetTextColor(0.5, 0.5, 0.5)
            end
            ChannelFilterAddButton:Disable()
            ChannelFilterRemoveButton:Disable()
            ChannelFilterResetButton:Disable()
        end
        MobElement_Enable(ChannelFilterOrderCheckButton)
        if ChannelFilter_a025bf316dae1633b9c38db34e565b5f then
            ChannelFilterOrderCheckButton:SetChecked(true)
            for i = 1, 2, 1 do
                ChannelFilter_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 = getglobal("BFIsOrderWordButton" .. i)
                ChannelFilter_e6955c64cf39bdb23dc86de1a9ec2117 =
                    getglobal("BFIsOrderWordButton" .. i .. "ButtonTextName")
                ChannelFilter_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:Enable()
                ChannelFilter_e6955c64cf39bdb23dc86de1a9ec2117:SetTextColor(1.0, 0.82, 0)
            end
            ChannelFilterOrderAddButton:Enable()
            if (ChannelFilter_d0051d21b741a038fff5c35e3d912fd7()) then
                ChannelFilterOrderRemoveButton:Enable()
            end
            ChannelFilterOrderResetButton:Enable()
        else
            for i = 1, 2, 1 do
                ChannelFilter_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 = getglobal("BFIsOrderWordButton" .. i)
                ChannelFilter_e6955c64cf39bdb23dc86de1a9ec2117 =
                    getglobal("BFIsOrderWordButton" .. i .. "ButtonTextName")
                ChannelFilter_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:Disable()
                ChannelFilter_e6955c64cf39bdb23dc86de1a9ec2117:SetTextColor(0.5, 0.5, 0.5)
            end
            ChannelFilterOrderAddButton:Disable()
            ChannelFilterOrderRemoveButton:Disable()
            ChannelFilterOrderResetButton:Disable()
        end
        MobElement_Enable(ChannelFilterLevelCheckButton)
        if ChannelFilter_Config.FilterLevel then
            ChannelFilterLevelCheckButton:SetChecked(true)
            ChannelFilterLevelSpinBoxTitle:SetTextColor(1.0, 0.82, 0)
            ChannelFilterLevelSpinBoxPrevButton:Enable()
            ChannelFilterLevelSpinBoxEditBox:Enable()
            ChannelFilterLevelSpinBoxNextButton:Enable()
        else
            ChannelFilterLevelSpinBoxTitle:SetTextColor(0.5, 0.5, 0.5)
            ChannelFilterLevelSpinBoxPrevButton:Disable()
            ChannelFilterLevelSpinBoxEditBox:Disable()
            ChannelFilterLevelSpinBoxNextButton:Disable()
        end
    else
        ChannelFilterEnable:SetChecked(false)
        MobElement_Disable(ChannelFilterBanCheckButton)
        for i = 1, 2, 1 do
            ChannelFilter_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 = getglobal("ChannelFilterWordButton" .. i)
            ChannelFilter_e6955c64cf39bdb23dc86de1a9ec2117 =
                getglobal("ChannelFilterWordButton" .. i .. "ButtonTextName")
            ChannelFilter_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:Disable()
            ChannelFilter_e6955c64cf39bdb23dc86de1a9ec2117:SetTextColor(0.5, 0.5, 0.5)
        end
        ChannelFilterAddButton:Disable()
        ChannelFilterRemoveButton:Disable()
        ChannelFilterResetButton:Disable()
        MobElement_Disable(ChannelFilterOrderCheckButton)
        for i = 1, 2, 1 do
            ChannelFilter_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 = getglobal("BFIsOrderWordButton" .. i)
            ChannelFilter_e6955c64cf39bdb23dc86de1a9ec2117 = getglobal("BFIsOrderWordButton" .. i .. "ButtonTextName")
            ChannelFilter_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:Disable()
            ChannelFilter_e6955c64cf39bdb23dc86de1a9ec2117:SetTextColor(0.5, 0.5, 0.5)
        end
        ChannelFilterOrderAddButton:Disable()
        ChannelFilterOrderRemoveButton:Disable()
        ChannelFilterOrderResetButton:Disable()
        MobElement_Disable(ChannelFilterLevelCheckButton)
        ChannelFilterLevelSpinBoxTitle:SetTextColor(0.5, 0.5, 0.5)
        ChannelFilterLevelSpinBoxPrevButton:Disable()
        ChannelFilterLevelSpinBoxEditBox:Disable()
        ChannelFilterLevelSpinBoxNextButton:Disable()
    end
    ChannelFilterList_Update()
end
local function ChannelFilter_ReportStatus()
    if (ChannelFilter_Config.Enabled) then
        ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_FILTER_MSG_ENABLE)
    else
        ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_FILTER_MSG_DISABLE)
    end
end
local function ChannelFilter_f4a7ca345e4ea814dd44abaab06a1761(ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)
    if (ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae) then
        ChannelFilter_Config.Enabled = 1
        BigFoot_SetModVariable("InfoEnhancement", "EnableChannelFilter", 1)
    else
        ChannelFilter_Config.Enabled = nil
        BigFoot_SetModVariable("InfoEnhancement", "EnableChannelFilter", 0)
    end
    ChannelFilter_UpdateOption()
    ChannelFilter_ReportStatus()
end
local function ChannelFilter_bfda630401df06fcd17a268bf2416b36()
    if (ChannelFilter_Config.mute) then
        ChannelFilterMuteButtonMute:Show()
    else
        ChannelFilterMuteButtonMute:Hide()
    end
end
local function ChannelFilter_924f23bc0b2494d114e61b77931c2730(ChannelFilter_eed0be1c2d5f65980b06b5094460c3c5)
    if type(ChannelFilter_Config.IgnoreWords) == "table" then
        for _, symbol in ipairs(Symbols) do
            ChannelFilter_eed0be1c2d5f65980b06b5094460c3c5 =
                gsub(ChannelFilter_eed0be1c2d5f65980b06b5094460c3c5, symbol, "")
        end
        for k, v in pairs(ChannelFilter_Config.IgnoreWords) do
            if type(v) == "string" and string.find(ChannelFilter_eed0be1c2d5f65980b06b5094460c3c5:lower(), v:lower()) then
                if ChannelFilter_Config.debug then
                    print(ChannelFilter_eed0be1c2d5f65980b06b5094460c3c5)
                    print(">" .. v .. "<")
                end
                return true
            end
        end
    end
end
local function IsOrderMessage(ChannelFilter_eed0be1c2d5f65980b06b5094460c3c5)
    if type(ChannelFilter_Config.OrderWords) == "table" then
        for k, v in pairs(ChannelFilter_Config.OrderWords) do
            if type(v) == "string" and string.find(ChannelFilter_eed0be1c2d5f65980b06b5094460c3c5:lower(), v:lower()) then
                return true
            end
        end
        return
    end
end
local function ChannelFilter_36b3da8059b22d2587b9522bc0159d52()
    local ChannelFilter_3f50417fb16be9b1078eb68d24fa9c26 = #ChannelFilter_Config.IgnoreWords
    ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_FILTER_MSG_LIST_TITLE)
    if (ChannelFilter_3f50417fb16be9b1078eb68d24fa9c26 == 0) then
        ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_FILTER_MSG_EMPTY_LIST)
        return
    end
    for __index = 1, ChannelFilter_3f50417fb16be9b1078eb68d24fa9c26, 1 do
        ChannelFilter_cca6e81523d4253f35038608e9e1dae1(
            __index .. ": |cffff0000" .. ChannelFilter_Config.IgnoreWords[__index] .. "|r"
        )
    end
end
local function ChannelFilter_87504618c605f6b2ac5fdbaf8810af00()
    ChannelFilter_Config.IgnoreWords = {}
end
local function ChannelFilter_2a41ecab72c2fee97a7e4a32a2a402ca()
    ChannelFilter_Config.OrderWords = {}
end
local function ChannelFilter_893e84a2fc9c86694109792079e8cb68(__index)
    table.remove(ChannelFilter_Config.IgnoreWords, __index)
end
local function ChannelFilter_13513cc1ff10b8987c5805d20619c3cb(__index)
    table.remove(ChannelFilter_Config.OrderWords, __index)
end
local function ChannelFilter_074e10d4da0144099cc8ca2f67cd7a97(ChannelFilter_413bf9c15ce77baa8ebf1cda4cbf4887)
    local ChannelFilter_3f50417fb16be9b1078eb68d24fa9c26 = #ChannelFilter_Config.IgnoreWords
    for __index = 1, ChannelFilter_3f50417fb16be9b1078eb68d24fa9c26, 1 do
        if (ChannelFilter_413bf9c15ce77baa8ebf1cda4cbf4887 == ChannelFilter_Config.IgnoreWords[__index]) then
            ChannelFilter_893e84a2fc9c86694109792079e8cb68(__index)
            return 1
        end
    end
end
local function ChannelFilter_6fe12d89627450702aba2e09824efef9(ChannelFilter_413bf9c15ce77baa8ebf1cda4cbf4887)
    local ChannelFilter_3f50417fb16be9b1078eb68d24fa9c26 = #ChannelFilter_Config.OrderWords
    for __index = 1, ChannelFilter_3f50417fb16be9b1078eb68d24fa9c26, 1 do
        if (ChannelFilter_413bf9c15ce77baa8ebf1cda4cbf4887 == ChannelFilter_Config.OrderWords[__index]) then
            ChannelFilter_13513cc1ff10b8987c5805d20619c3cb(__index)
            return 1
        end
    end
end
local function ChannelFilter_0a3b0cbda5450bd05d7c2955e018fd9b(ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)
    if (not ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae or ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae == "") then
        ChannelFilter_36b3da8059b22d2587b9522bc0159d52()
        ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_FILTER_MSG_SELECT)
        return
    end
    if (ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae == "*") then
        ChannelFilter_87504618c605f6b2ac5fdbaf8810af00()
        ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_FILTER_MSG_ALL_CLEAR)
        return
    end
    local __index = tonumber(ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)
    if (not __index) then
        if (not ChannelFilter_074e10d4da0144099cc8ca2f67cd7a97(ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)) then
            local ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88 =
                string.format(CHANNEL_FILTER_MSG_KEY_NOT_FOUND, ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)
            ChannelFilter_cca6e81523d4253f35038608e9e1dae1(ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88)
        else
            local ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88 =
                string.format(CHANNEL_FILTER_MSG_REMOVED, ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)
            ChannelFilter_cca6e81523d4253f35038608e9e1dae1(ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88)
        end
        return
    end
    if (__index > #ChannelFilter_Config.IgnoreWords) then
        ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_FILTER_MSG_OUT_OF_BOUND)
        return
    end
    local ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88 =
        string.format(CHANNEL_FILTER_MSG_REMOVED, ChannelFilter_Config.IgnoreWords[__index])
    ChannelFilter_cca6e81523d4253f35038608e9e1dae1(ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88)
    ChannelFilter_893e84a2fc9c86694109792079e8cb68(__index)
end
local function ChannelFilter_aa39b6e6d0c0f9203c8dfa63593baabe(ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)
    if (ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae == "*") then
        ChannelFilter_2a41ecab72c2fee97a7e4a32a2a402ca()
        return
    end
    local __index = tonumber(ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)
    if (not __index) then
        if (not ChannelFilter_6fe12d89627450702aba2e09824efef9(ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)) then
            local ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88 =
                string.format(CHANNEL_FILTER_MSG_KEY_NOT_FOUND, ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)
            ChannelFilter_cca6e81523d4253f35038608e9e1dae1(ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88)
        else
            local ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88 =
                string.format(CHANNEL_FILTER_MSG_REMOVED, ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)
            ChannelFilter_cca6e81523d4253f35038608e9e1dae1(ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88)
        end
        return
    end
    if (__index > #ChannelFilter_Config.OrderWords) then
        ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_FILTER_MSG_OUT_OF_BOUND)
        return
    end
    local ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88 =
        string.format(CHANNEL_FILTER_MSG_REMOVED, ChannelFilter_Config.OrderWords[__index])
    ChannelFilter_cca6e81523d4253f35038608e9e1dae1(ChannelFilter_c9bd86bc8bc59457d49315cf5b8c5b88)
    ChannelFilter_13513cc1ff10b8987c5805d20619c3cb(__index)
end
local function ChannelFilter_b2f123d7517af7a7d51eca4375d01d8c(ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae)
    if (not ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae or ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae == "") then
        ChannelFilter_0900e4822400fb50cfa421dc6b6a0106()
        return
    end
    local ChannelFilter_6e4d0db7491d6883f86de390d20dbe5b,
        ChannelFilter_a2f3972c23a0aa3bd7fb0e9823d918f2,
        ChannelFilter_934b29c1721e73eb148dc0580ccfb0b6,
        ChannelFilter_f622c4931a4714cc787b533eaaab65e7,
        ChannelFilter_7ae7f2ee67d777af9a48ac82a1cdd27b =
        string.find(ChannelFilter_7739b813d90aed43ab9d0eb84ec1c1ae, "([^%s]+)(%s*)(.*)")
    if (not ChannelFilter_6e4d0db7491d6883f86de390d20dbe5b) then
        ChannelFilter_0900e4822400fb50cfa421dc6b6a0106()
        return
    end
    if
        (ChannelFilter_934b29c1721e73eb148dc0580ccfb0b6 == "+" or
            ChannelFilter_934b29c1721e73eb148dc0580ccfb0b6 == "add")
     then
        ChannelFilter_31d2b1f6c943bbb6272644a023663342(ChannelFilter_7ae7f2ee67d777af9a48ac82a1cdd27b)
    elseif
        (ChannelFilter_934b29c1721e73eb148dc0580ccfb0b6 == "-" or
            ChannelFilter_934b29c1721e73eb148dc0580ccfb0b6 == "remove")
     then
        ChannelFilter_0a3b0cbda5450bd05d7c2955e018fd9b(ChannelFilter_7ae7f2ee67d777af9a48ac82a1cdd27b)
    elseif
        (ChannelFilter_934b29c1721e73eb148dc0580ccfb0b6 == "*" or
            ChannelFilter_934b29c1721e73eb148dc0580ccfb0b6 == "list")
     then
        ChannelFilter_36b3da8059b22d2587b9522bc0159d52()
    elseif (ChannelFilter_934b29c1721e73eb148dc0580ccfb0b6 == "on") then
        ChannelFilter_f4a7ca345e4ea814dd44abaab06a1761(1)
    elseif (ChannelFilter_934b29c1721e73eb148dc0580ccfb0b6 == "off") then
        ChannelFilter_f4a7ca345e4ea814dd44abaab06a1761()
    else
        ChannelFilter_0900e4822400fb50cfa421dc6b6a0106()
    end
end
local function ChannelFilter_36e4b551303d04c14eb2146a9605928c()
    return #ChannelFilter_Config.IgnoreWords
end
local function ChannelFilter_6dd3dc592a99bd644ef45b590dda7fc0()
    return #ChannelFilter_Config.OrderWords
end
local function ChannelFilter_351c17201185fce926ef0bd074ab66d8()
    ChannelFilter_Config.IgnoreWords = {}
    for i, v in pairs(ChannelFilter_NewIgnoreWords_Default) do
        ChannelFilter_Config.IgnoreWords[i] = v
    end
end
local function ChannelFilter_947aa4aef03a38b2737ce8e17a854519()
    ChannelFilter_Config.OrderWords = {}
    for i, v in pairs(ChannelFilter_NewOrderWords_Default) do
        ChannelFilter_Config.OrderWords[i] = v
    end
end
local function ChannelFilter_83db3bfe22406ceb77f6b9fa06ae4142(__index)
    return ChannelFilter_Config.IgnoreWords[__index]
end
local function ChannelFilter_3fc08f96feeb7a0757d43d3c0b586a37(__index)
    return ChannelFilter_Config.OrderWords[__index]
end
local function ChannelFilter_3afa8f44bbcebd4466f2606a4e264c54(__index)
    ChannelFilter_76d6f12ba3810515a6368ac18850ddac = __index
end
local function ChannelFilter_36a37a281a17004aebf6f45123f905ef(__index)
    ChannelFilter_f6fa3c07b3d3d1066da321072c9f8b53 = __index
end
local id, msg, player, channel_name, channel_id, now
local function ChannelFilter_ChatFrame_OnEvent(ChannelFilter_7c151c5e4af573821a13320cffbe335b, self, event, arg1, ...)
    if (ChannelFilter_Config.Enabled) then
        id = self:GetID()
        if (id == SELECTED_CHAT_FRAME:GetID()) then
            msg, player, _, channel_name, _, _, _, channel_id = arg1, ...
            if (player and Ambiguate(player, "none") ~= ChannelFilter_49a34e51f5b777fb9f2d3ec8bfc169f2) then
                if (event == "CHAT_MSG_TRADESKILLS" and ChannelFilter_Config.mute) then
                    return
                end
                if (event == "CHAT_MSG_CHANNEL" or event == "CHAT_MSG_YELL") then
                    if channel_name then
                        if not channel_name:find("世") then
                            if ChannelFilter_Config.mute then
                                return
                            end
                        else
                            if ChannelFilter_Config.BanEnabled and ChannelFilter_924f23bc0b2494d114e61b77931c2730(msg) then
                                return
                            end
                        end
                    end
                    now = time()
                    if (now - ChannelFilterFrame.last_updated > 60) then
                        ChannelFilterFrame.last_updated = now
                        for k1, v1 in pairs(ChannelFilter_6871a3b1763bbc925b1adeb8fade8acb) do
                            for k2, v2 in ipairs(v1) do
                                if (now - v2["time"] > 60) then
                                    table.remove(v2, k2)
                                end
                            end
                        end
                    end
                    if (msg and player) then
                        if (ChannelFilter_6871a3b1763bbc925b1adeb8fade8acb[player]) then
                            for k1, v1 in ipairs(ChannelFilter_6871a3b1763bbc925b1adeb8fade8acb[player]) do
                                if (channel_id and channel_id ~= 0 and now - v1["time"] < 1) then
                                    return
                                end
                                if ((v1["msg"] == msg) and (now - v1["time"] <= 10)) then
                                    return
                                end
                            end
                        end
                        if (not ChannelFilter_6871a3b1763bbc925b1adeb8fade8acb[player]) then
                            ChannelFilter_6871a3b1763bbc925b1adeb8fade8acb[player] = {}
                        end
                        table.insert(
                            ChannelFilter_6871a3b1763bbc925b1adeb8fade8acb[player],
                            {["msg"] = msg, ["time"] = now}
                        )
                    end
                    if
                        ChannelFilter_a025bf316dae1633b9c38db34e565b5f and channel_name and channel_name:find("世") and
                            not IsOrderMessage(msg)
                     then
                        return
                    end
                end
            end
        end
    end
    ChannelFilter_7c151c5e4af573821a13320cffbe335b(self, event, arg1, ...)
end
function ChannelFilterWordButton_OnClick(self, ChannelFilter_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
    ChannelFilter_3afa8f44bbcebd4466f2606a4e264c54(self:GetID())
    ChannelFilterList_Update()
end
function ChannelFilterOrderWordButton_OnClick(self, ChannelFilter_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
    ChannelFilter_36a37a281a17004aebf6f45123f905ef(self:GetID())
    ChannelFilterList_Update()
end
function ChannelFilterRemoveButton_OnClick(self)
    local __index = ChannelFilter_ff376af5724fd739f29ed8014d542a7b()
    ChannelFilter_0a3b0cbda5450bd05d7c2955e018fd9b(__index)
    ChannelFilterList_Update()
end
function ChannelFilterOrderRemoveButton_OnClick(self)
    local __index = ChannelFilter_d0051d21b741a038fff5c35e3d912fd7()
    ChannelFilter_aa39b6e6d0c0f9203c8dfa63593baabe(__index)
    ChannelFilterList_Update()
end
function ChannelFilterResetButton_OnClick(self)
    ChannelFilter_351c17201185fce926ef0bd074ab66d8()
    ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_FILTER_MSG_RESET)
    ChannelFilterList_Update()
end
function ChannelFilterOrderResetButton_OnClick(self)
    ChannelFilter_947aa4aef03a38b2737ce8e17a854519()
    ChannelFilter_cca6e81523d4253f35038608e9e1dae1(CHANNEL_FILTER_MSG_ORDERRESET)
    ChannelFilterList_Update()
end
function ChannelFilterEnable_OnClick(self)
    if (self:GetChecked()) then
        ChannelFilter_Config.Enabled = 1
    else
        ChannelFilter_Config.Enabled = nil
    end
    ChannelFilter_UpdateOption()
end
function ChannelFilterBanCheckButton_OnClick(self)
    if (self:GetChecked()) then
        ChannelFilter_Config.BanEnabled = 1
    else
        ChannelFilter_Config.BanEnabled = nil
    end
    ChannelFilter_UpdateOption()
end
function ChannelFilterOrderCheckButton_OnClick(self)
    if (self:GetChecked()) then
        ChannelFilter_a025bf316dae1633b9c38db34e565b5f = 1
    else
        ChannelFilter_a025bf316dae1633b9c38db34e565b5f = nil
    end
    ChannelFilter_UpdateOption()
end
function ChannelFilterLevelCheckButton_OnClick(self)
    if (self:GetChecked()) then
        ChannelFilter_Config.FilterLevel = 1
    else
        ChannelFilter_Config.FilterLevel = nil
    end
    ChannelFilter_UpdateOption()
end
function ChannelFilterLevelSpinBoxPrevButton_OnClick(self)
    local ChannelFilter_2361bab8b48b1041ad740bb561b21aee = ChannelFilterLevelSpinBoxEditBox:GetNumber()
    ChannelFilterLevelSpinBoxEditBox:SetNumber(ChannelFilter_2361bab8b48b1041ad740bb561b21aee - 1)
end
function ChannelFilterLevelSpinBoxNextButton_OnClick(self)
    local ChannelFilter_2361bab8b48b1041ad740bb561b21aee = ChannelFilterLevelSpinBoxEditBox:GetNumber()
    ChannelFilterLevelSpinBoxEditBox:SetNumber(ChannelFilter_2361bab8b48b1041ad740bb561b21aee + 1)
end
function ChannelFilterLevelSpinBoxEditBox_OnShow(self)
    if ChannelFilter_Config.SetFliterLv then
        self:SetNumber(ChannelFilter_Config.SetFliterLv)
    end
end
function ChannelFilterLevelSpinBoxEditBox_OnTextChange(self)
    local ChannelFilter_2361bab8b48b1041ad740bb561b21aee = self:GetNumber()
    if ChannelFilter_2361bab8b48b1041ad740bb561b21aee <= 1 then
        self:SetNumber(1)
    elseif ChannelFilter_2361bab8b48b1041ad740bb561b21aee >= fullLevel - 1 then
        self:SetNumber(fullLevel - 1)
    else
        self:SetNumber(ChannelFilter_2361bab8b48b1041ad740bb561b21aee)
    end
    ChannelFilter_Config.SetFliterLv = ChannelFilter_2361bab8b48b1041ad740bb561b21aee
end
function ChannelFilterMuteButton_OnClick()
    if (ChannelFilter_Config.mute) then
        ChannelFilter_Config.mute = false
        SELECTED_CHAT_FRAME:AddMessage(CHANNEL_FILTER_MSG_UNBLOCKED)
    else
        ChannelFilter_Config.mute = true
        SELECTED_CHAT_FRAME:AddMessage(CHANNEL_FILTER_MSG_BLOCKED)
    end
    ChannelFilter_bfda630401df06fcd17a268bf2416b36()
end
function ChannelFilter_OnLoad(self)
    self:RegisterEvent("ADDON_LOADED")
    self:RegisterEvent("FRIENDLIST_UPDATE")
    BLibrary("BHook"):Hook("ChatFrame_MessageEventHandler", ChannelFilter_ChatFrame_OnEvent)
    SlashCmdList["GUOLV"] = ChannelFilter_b2f123d7517af7a7d51eca4375d01d8c
    SLASH_GUOLV1 = "/guolv"
    SLASH_GUOLV2 = "/gl"
    SLASH_GUOLV3 = "/过滤"
    SLASH_GUOLV4 = "/channelfilter"
    SLASH_GUOLV5 = "/filter"
    ChannelFilterFrame.last_updated = 0
    ModManagement_RegisterMod(
        "ChannelFilter",
        [[Interface\Icons\Ability_Rogue_Disguise]],
        CHANNEL_FILTER_TITLE,
        "",
        nil,
        {["frame"] = "ChannelFilterOptionFrame", ["offsetx"] = 313, ["offsety"] = -108},
        {[7] = true}
    )
end
function ChannelFilter_OnEvent(self, event, ...)
    if (event == "ADDON_LOADED" and select(1, ...) == "ChannelFilter") then
        if not ChannelFilter_Config then
            ChannelFilter_Config = {}
            ChannelFilter_Config.Enabled = 1
            ChannelFilter_Config.NewConfig = 2
            ChannelFilter_Config.BanEnabled = 1
            ChannelFilter_Config.FilterLevel = 1
            ChannelFilter_Config.SetFliterLv = 5
        elseif not ChannelFilter_Config.NewConfig then
            ChannelFilter_Config.Enabled = 1
            ChannelFilter_Config.BanEnabled = 1
            ChannelFilter_Config.NewConfig = 2
            ChannelFilter_Config.FilterLevel = 1
            ChannelFilter_Config.SetFliterLv = 5
        end
        if ChannelFilter_Config.NewConfig < 2 then
            ChannelFilter_Config.NewConfig = 2
            ChannelFilter_Config.FilterLevel = 1
            ChannelFilter_Config.SetFliterLv = 5
        end
        ChannelFilter_Config.OrderWords = ChannelFilter_Config.OrderWords or ChannelFilter_NewOrderWords_Default
        ChannelFilter_Config.IgnoreWords = ChannelFilter_Config.IgnoreWords or ChannelFilter_NewIgnoreWords_Default
        ChannelFilter_bfda630401df06fcd17a268bf2416b36()
        C_FriendList.ShowFriends()
        good[UnitName("player")] = true --[[暂时移除等级过滤功能 ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", function(...) if not ChannelFilter_Config.FilterLevel then return end local f, _, _, player, _, _, _, flag, _, _, _, _, id, guid = ... if flag == "GM" or flag == "DEV" then return end local trimmedPlayer = Ambiguate(player, "none") if good[trimmedPlayer] or UnitIsInMyGuild(trimmedPlayer) then return end local _, num = BNGetNumFriends() for i=1, num do local toon = BNGetNumFriendGameAccounts(i) for j=1, toon do local _, rName, rGame, rServer = BNGetFriendGameAccountInfo(i, j) if rName == trimmedPlayer and rGame == "WoW" and rServer == GetRealmName() then good[trimmedPlayer] = true return end end end if not addMsg then addMsg = ChatFrame1.AddMessage ChatFrame1.AddMessage = hookFunc end f = f:GetName() if not f then f = "?" end if f == "WIM3_HistoryChatFrame" then return end if IsAddOnLoaded("WIM") and f ~= "WIM_workerFrame" then return true end if IsAddOnLoaded("Cellular") and f ~= "Cellular" then return true end if not maybe[trimmedPlayer] then maybe[trimmedPlayer] = {} end if not maybe[trimmedPlayer][f] then maybe[trimmedPlayer][f] = {} end maybe[trimmedPlayer][f][id] = {} for i = 1, select("#", ...) do maybe[trimmedPlayer][f][id][i] = select(i, ...) end local _, englishClass = GetPlayerInfoByGUID(guid) local level = ChannelFilter_Config.SetFliterLv and tonumber(ChannelFilter_Config.SetFliterLv)+1 or 2 if englishClass == "DEATHKNIGHT" and level < 58 then level = 58 end if not filterTable[trimmedPlayer] or filterTable[trimmedPlayer] ~= level then filterTable[trimmedPlayer] = level maybeGood = trimmedPlayer; C_FriendList.AddFriend(trimmedPlayer) end return true end) ]]
        ChatFrame_AddMessageEventFilter(
            "CHAT_MSG_SYSTEM",
            function(_, _, msg)
                if not ChannelFilter_Config.FilterLevel then
                    return
                end
                if msg == ERR_FRIEND_LIST_FULL then
                    SELECTED_CHAT_FRAME:AddMessage(CHANNEL_FILTER_MSG_ERR)
                    return true
                end
                if msg == ERR_FRIEND_NOT_FOUND then
                    local filter = maybeGood
                    maybeGood = nil
                    if filter and maybe[filter] then
                        good[filter] = true
                        for _, v in pairs(maybe[filter]) do
                            for _, p in pairs(v) do
                                if IsAddOnLoaded("WIM") then
                                    WIM.modules.WhisperEngine:CHAT_MSG_WHISPER(select(3, unpack(p)))
                                elseif IsAddOnLoaded("Cellular") then
                                    local _, _, a1, a2, _, _, _, a6, _, _, _, _, a11, a12 = unpack(p)
                                    Cellular:IncomingMessage(a2, a1, a6, nil, a11, a12)
                                else
                                    ChatFrame_MessageEventHandler(unpack(p))
                                end
                                wipe(p)
                            end
                            wipe(v)
                        end
                        wipe(maybe[filter])
                        maybe[filter] = nil
                        return true
                    end
                end
            end
        )
        self:UnregisterEvent("ADDON_LOADED")
    elseif event == "FRIENDLIST_UPDATE" then
        if not ChannelFilter_Config.FilterLevel then
            return
        end
        local num = C_FriendList.GetNumFriends()
        if not login then
            login = true
            for i = 1, num do
                local n = C_FriendList.GetFriendInfoByIndex(i).name
                if n then
                    good[n] = true
                end
            end
            return
        end
        for i = 1, num do
            local info = C_FriendList.GetFriendInfoByIndex(i)
            local player, level = info.name, info.level
            if not player then
                C_FriendList.ShowFriends()
            else
                if maybe[player] then
                    C_FriendList.RemoveFriend(player)
                    if level < filterTable[player] then
                        for _, v in pairs(maybe[player]) do
                            for _, p in pairs(v) do
                                wipe(p)
                            end
                            wipe(v)
                        end
                    else
                        good[player] = true
                        for _, v in pairs(maybe[player]) do
                            for _, p in pairs(v) do
                                if IsAddOnLoaded("WIM") then
                                    WIM.modules.WhisperEngine:CHAT_MSG_WHISPER(select(3, unpack(p)))
                                elseif IsAddOnLoaded("Cellular") then
                                    local _, _, a1, a2, _, _, _, a6, _, _, _, _, a11, a12 = unpack(p)
                                    Cellular:IncomingMessage(a2, a1, a6, nil, a11, a12)
                                else
                                    ChatFrame_MessageEventHandler(unpack(p))
                                end
                                wipe(p)
                            end
                            wipe(v)
                        end
                    end
                    wipe(maybe[player])
                    maybe[player] = nil
                end
            end
        end
        if maybeGood then
            maybeGood = nil
        end
    end
end
function ChannelFilterList_Update()
    local ChannelFilter_6a6e9e50c54c6dd20e3a8c58f5cd1de2 = ChannelFilter_36e4b551303d04c14eb2146a9605928c()
    local ChannelFilter_6b538e337e77d6490b0a402f4d47e002 = ChannelFilter_6dd3dc592a99bd644ef45b590dda7fc0()
    local ChannelFilter_47eefd9873494a7ac112542867e34eda = FauxScrollFrame_GetOffset(ChannelFilterScrollFrame)
    local ChannelFilter_a053f19281d0e89960b324eb13316e5f = FauxScrollFrame_GetOffset(ChannelFilterOrderScrollFrame)
    local ChannelFilter_48666c3db4d9f4d39e05d6ea45236773 = ChannelFilter_ff376af5724fd739f29ed8014d542a7b()
    local ChannelFilter_48246f1cbee24a582e957998166d9f9b = ChannelFilter_d0051d21b741a038fff5c35e3d912fd7()
    local ChannelFilter_910e55c928d53443ec341f365a151493,
        ChannelFilter_653ea955459e0e801c4f1325b13556b4,
        ChannelFilter_e6955c64cf39bdb23dc86de1a9ec2117
    if
        (ChannelFilter_48666c3db4d9f4d39e05d6ea45236773 and ChannelFilter_Config.Enabled and
            ChannelFilter_Config.BanEnabled and
            ChannelFilter_48666c3db4d9f4d39e05d6ea45236773 <= ChannelFilter_6a6e9e50c54c6dd20e3a8c58f5cd1de2)
     then
        ChannelFilterRemoveButton:Enable()
    else
        ChannelFilterRemoveButton:Disable()
    end
    if
        (ChannelFilter_48246f1cbee24a582e957998166d9f9b and ChannelFilter_Config.Enabled and
            ChannelFilter_a025bf316dae1633b9c38db34e565b5f and
            ChannelFilter_48246f1cbee24a582e957998166d9f9b <= ChannelFilter_6b538e337e77d6490b0a402f4d47e002)
     then
        ChannelFilterOrderRemoveButton:Enable()
    else
        ChannelFilterOrderRemoveButton:Disable()
    end
    for ChannelFilter_e914904fab9d05d3f54d52bfc31a0f3f = 1, 2, 1 do
        ChannelFilter_910e55c928d53443ec341f365a151493 =
            ChannelFilter_47eefd9873494a7ac112542867e34eda + ChannelFilter_e914904fab9d05d3f54d52bfc31a0f3f
        ChannelFilter_e6955c64cf39bdb23dc86de1a9ec2117 =
            ChannelFilter_83db3bfe22406ceb77f6b9fa06ae4142(ChannelFilter_910e55c928d53443ec341f365a151493)
        getglobal("ChannelFilterWordButton" .. ChannelFilter_e914904fab9d05d3f54d52bfc31a0f3f .. "ButtonTextName"):SetText(
            ChannelFilter_e6955c64cf39bdb23dc86de1a9ec2117
        )
        ChannelFilter_653ea955459e0e801c4f1325b13556b4 =
            getglobal("ChannelFilterWordButton" .. ChannelFilter_e914904fab9d05d3f54d52bfc31a0f3f)
        ChannelFilter_653ea955459e0e801c4f1325b13556b4:SetID(ChannelFilter_910e55c928d53443ec341f365a151493)
        if
            (ChannelFilter_910e55c928d53443ec341f365a151493 == ChannelFilter_48666c3db4d9f4d39e05d6ea45236773 and
                ChannelFilter_Config.Enabled and
                ChannelFilter_Config.BanEnabled)
         then
            ChannelFilter_653ea955459e0e801c4f1325b13556b4:LockHighlight()
        else
            ChannelFilter_653ea955459e0e801c4f1325b13556b4:UnlockHighlight()
        end
        if (ChannelFilter_910e55c928d53443ec341f365a151493 > ChannelFilter_6a6e9e50c54c6dd20e3a8c58f5cd1de2) then
            ChannelFilter_653ea955459e0e801c4f1325b13556b4:Hide()
        else
            ChannelFilter_653ea955459e0e801c4f1325b13556b4:Show()
        end
    end
    for ChannelFilter_e914904fab9d05d3f54d52bfc31a0f3f = 1, 2, 1 do
        ChannelFilter_910e55c928d53443ec341f365a151493 =
            ChannelFilter_a053f19281d0e89960b324eb13316e5f + ChannelFilter_e914904fab9d05d3f54d52bfc31a0f3f
        ChannelFilter_e6955c64cf39bdb23dc86de1a9ec2117 =
            ChannelFilter_3fc08f96feeb7a0757d43d3c0b586a37(ChannelFilter_910e55c928d53443ec341f365a151493)
        getglobal("BFIsOrderWordButton" .. ChannelFilter_e914904fab9d05d3f54d52bfc31a0f3f .. "ButtonTextName"):SetText(
            ChannelFilter_e6955c64cf39bdb23dc86de1a9ec2117
        )
        ChannelFilter_653ea955459e0e801c4f1325b13556b4 =
            getglobal("BFIsOrderWordButton" .. ChannelFilter_e914904fab9d05d3f54d52bfc31a0f3f)
        ChannelFilter_653ea955459e0e801c4f1325b13556b4:SetID(ChannelFilter_910e55c928d53443ec341f365a151493)
        if
            (ChannelFilter_910e55c928d53443ec341f365a151493 == ChannelFilter_48246f1cbee24a582e957998166d9f9b and
                ChannelFilter_Config.Enabled and
                ChannelFilter_a025bf316dae1633b9c38db34e565b5f)
         then
            ChannelFilter_653ea955459e0e801c4f1325b13556b4:LockHighlight()
        else
            ChannelFilter_653ea955459e0e801c4f1325b13556b4:UnlockHighlight()
        end
        if (ChannelFilter_910e55c928d53443ec341f365a151493 > ChannelFilter_6b538e337e77d6490b0a402f4d47e002) then
            ChannelFilter_653ea955459e0e801c4f1325b13556b4:Hide()
        else
            ChannelFilter_653ea955459e0e801c4f1325b13556b4:Show()
        end
    end
    if (ChannelFilter_Config.Enabled and ChannelFilter_Config.BanEnabled) then
        FauxScrollFrame_Update(ChannelFilterScrollFrame, ChannelFilter_6a6e9e50c54c6dd20e3a8c58f5cd1de2, 2, 16)
    else
        FauxScrollFrame_Update(ChannelFilterScrollFrame, 1, 2, 16)
    end
    if (ChannelFilter_Config.Enabled and ChannelFilter_a025bf316dae1633b9c38db34e565b5f) then
        FauxScrollFrame_Update(ChannelFilterOrderScrollFrame, ChannelFilter_6b538e337e77d6490b0a402f4d47e002, 2, 16)
    else
        FauxScrollFrame_Update(ChannelFilterOrderScrollFrame, 1, 2, 16)
    end
end
StaticPopupDialogs["CHANNEL_FILTER_ADD_WORD"] = {
    preferredIndex = STATICPOPUP_NUMDIALOGS,
    text = CHANNEL_FILTER_ADD_WORD_TEXT,
    button1 = ACCEPT,
    button2 = CANCEL,
    hasEditBox = 1,
    maxLetters = 12,
    OnAccept = function(self)
        ChannelFilter_31d2b1f6c943bbb6272644a023663342(self.editBox:GetText())
        ChannelFilterList_Update()
    end,
    OnShow = function(self)
        getglobal(self:GetName() .. "EditBox"):SetFocus()
    end,
    OnHide = function(self)
        if (ChatFrame1EditBox:IsVisible()) then
            ChatFrame1EditBox:SetFocus()
        end
        getglobal(self:GetName() .. "EditBox"):SetText("")
    end,
    EditBoxOnEnterPressed = function(self)
        local text = self:GetParent().editBox:GetText()
        ChannelFilter_31d2b1f6c943bbb6272644a023663342(text)
        ChannelFilterList_Update()
        self:GetParent():Hide()
    end,
    EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide()
    end,
    timeout = 0,
    exclusive = 1,
    whileDead = 1,
    hideOnEscape = 1
}
StaticPopupDialogs["CHANNEL_FILTER_ADD_ORDERWORD"] = {
    preferredIndex = STATICPOPUP_NUMDIALOGS,
    text = CHANNEL_FILTER_ADD_ORDERWORD_TEXT,
    button1 = ACCEPT,
    button2 = CANCEL,
    hasEditBox = 1,
    maxLetters = 12,
    OnAccept = function(self)
        ChannelFilter_497b6c3a9fa37cdb095d6f39ba0adf2d(self.editBox:GetText())
        ChannelFilterList_Update()
    end,
    OnShow = function(self)
        getglobal(self:GetName() .. "EditBox"):SetFocus()
    end,
    OnHide = function(self)
        if (ChatFrame1EditBox:IsVisible()) then
            ChatFrame1EditBox:SetFocus()
        end
        getglobal(self:GetName() .. "EditBox"):SetText("")
    end,
    EditBoxOnEnterPressed = function(self)
        local text = self:GetParent().editBox:GetText()
        ChannelFilter_497b6c3a9fa37cdb095d6f39ba0adf2d(text)
        ChannelFilterList_Update()
        self:GetParent():Hide()
    end,
    EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide()
    end,
    timeout = 0,
    exclusive = 1,
    whileDead = 1,
    hideOnEscape = 1
}
function ChannelFilterAddButton_OnClick(self)
    StaticPopup_Show("CHANNEL_FILTER_ADD_WORD")
end
function ChannelFilterOrderAddButton_OnClick(self)
    StaticPopup_Show("CHANNEL_FILTER_ADD_ORDERWORD")
end
function ChannelFilterOptionFrame_OnHide(self)
    StaticPopup_Hide("CHANNEL_FILTER_ADD_WORD")
    StaticPopup_Hide("CHANNEL_FILTER_ADD_ORDERWORD")
end
function ChannelFilterOptionFrame_OnShow(self)
    ChannelFilterEnableText:SetText(CHANNEL_FILTER_ENABLE_TEXT)
    ChannelFilterBanCheckButtonText:SetText(CHANNEL_FILTER_BAN_TEXT)
    ChannelFilterBanCheckButton.tooltip = CHANNEL_FILTER_BAN_TEXT_TOOLTIP
    ChannelFilterOrderCheckButtonText:SetText(CHANNEL_FILTER_ORDER_TEXT)
    ChannelFilterOrderCheckButton.tooltip = CHANNEL_FILTER_ORDER_TEXT_TOOLTIP
    ChannelFilterLevelCheckButtonText:SetText(CHANNEL_FILTER_LEVEL_TEXT)
    ChannelFilterLevelCheckButton.tooltip = CHANNEL_FILTER_LEVEL_TEXT_TOOLTIP
    ChannelFilterLevelSpinBoxTitle:SetText(CHANNEL_FILTER_LEVEL)
    ChannelFilter_UpdateOption()
end
function ChannelFilterButton_OnEnter(self)
    if (self.tooltip) then
        ModManagementTooltip:SetOwner(self, "ANCHOR_TOPRIGHT", -5)
        if (self.caption) then
            ModManagementTooltip:SetText(self.caption, 1.0, 1.0, 1.0)
            ModManagementTooltip:AddLine(self.tooltip, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
        else
            ModManagementTooltip:SetText(
                self.tooltip,
                NORMAL_FONT_COLOR.r,
                NORMAL_FONT_COLOR.g,
                NORMAL_FONT_COLOR.b,
                1,
                1
            )
        end
        ModManagementTooltip:Show()
    end
end
