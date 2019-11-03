local L = LibStub("AceLocale-3.0"):NewLocale(..., "enUS", true, nil)
if not L then return end

-------------------------------------------------------------

L = L or {}
-- Browser
L["BROWSER_CLASSIFIED_BY_AUTHOR"] = "By Author/%s"
L["BROWSER_CLASSIFIED_BY_CHANNEL"] = "By Channel/%s"
L["BROWSER_CLASSIFIED_ALL_MESSAGES"] = "All Messages"
L["BROWSER_STATUS_BAR"] = "All messages %d, unique %d, duplicate %d, duplicate rate %0.2f%%"
L["BROWSER_TITLE"] = "Message Browser"
L["MOVE_BUTTON"] = "Move Button"
L["Left-Click"] = true
L["Shift-Click"] = true
L["BROWSER_SETTING"] = "Settings"
L["BROWSER_SEARCH"] = "Search"

-- MessageClassifier
L["DISABLE_TIPS"] = "Public channel/World channel message deduplication: Disabled"
L["ENABLE_TIPS"] = "Public channel/World channel message deduplication: Enabled. You can toggle it with command /msgdd"
L["ENABLE_TIPS_WITH_BIGFOOT"] = "Public channel/World channel message deduplication: Enabled. You can turn it off in the minimap BigFoot button package."
L["RESET_TIPS"] = "Public channel/World channel message deduplication: Filter has been reset"

-- Options
L["CONFIG_PAGE_TITLE"] = "Message Classifier"
L["OPTION_ENABLED"] = "Enable duplicate message filter"
L["OPTION_ENABLED_TOOLTIP"] = "Do not display duplicate messages in public channel/world channels"
L["OPTION_MIN_DUP_INTERVAL"] = "Min seconds for duplicate messages appear, 0 to always hide"
L["OPTION_RESET"] = "Reset filter"
L["OPTION_RESET_TOOLTIP"] = "Clear duplicate message records, allowing duplicate messages to be displayed again"
L["OPTION_OPEN_MESSAGE_BROWSER"] = "Message Browser"
L["OPTION_RULE_SETS_TITLE"] = "Classification Rules"
L["OPTION_ADD"] = "Add"
L["OPTION_EDIT"] = "Edit"
L["OPTION_SAVE"] = "Save"
L["OPTION_CANCEL"] = "Cancel"
L["OPTION_REMOVE"] = "Remove"
L["OPTION_RULE_SETS"] = "Custom Rules"
L["OPTION_DEFAULT_RULE_SETS"] = "Default Rules"
L["OPTION_CONDITIONS"] = "Conditions"
L["OPTION_CONDITION_LOGIC"] = "Logic"
L["OPTION_RULE_LOGIC_OR"] = "One of the conditions is true"
L["OPTION_RULE_LOGIC_AND"] = "All conditions are true at the same time"
L["OPTION_HIDE_FROM_CHAT_WINDOW"] = "Hide from chat window"
L["OPTION_ENABLE"] = "Enable"
L["OPTION_CLASS"] = "Class"
L["OPTION_CLASS_EDIT_TITLE"] = "Class (available variables: |cffc586c0{author}|r and |cffc586c0{channel}|r)"
L["OPTION_CONDITION_FIELD"] = "Field"
L["OPTION_CONDITION_OPERATOR"] = "Operator"
L["OPTION_CONDITION_VALUE"] = "Value"
L["OPTION_COND_CASESENSITIVE"] = "Case Sensitive"
L["OPTION_SELECT_ALL"] = "Select All"

-- Rule Fields
L["author"] = true
L["channel"] = true
L["content"] = true

-- Rule Operators
L["unconditional"] = true
L["equal"] = true
L["not equal"] = true
L["contain"] = true
L["not contain"] = true
L["match"] = true
L["not match"] = true

-- Channels
L["CHAN_FULLNAME_Guild"] = true
L["CHAN_FULLNAME_Raid"] = true
L["CHAN_FULLNAME_Party"] = true
L["CHAN_FULLNAME_General"] = true
L["CHAN_FULLNAME_Trade"] = true
L["CHAN_FULLNAME_WorldDefense"] = true
L["CHAN_FULLNAME_LocalDefense"] = true
L["CHAN_FULLNAME_LFGChannel"] = true
L["CHAN_FULLNAME_BattleGround"] = true
L["CHAN_FULLNAME_Yell"] = true
L["CHAN_FULLNAME_Say"] = true
L["CHAN_FULLNAME_WhisperTo"] = true
L["CHAN_FULLNAME_WhisperFrom"] = true
L["CHAN_FULLNAME_BigFootChannel"] = true
L["CHAN_SHORTNAME_Guild"] = true
L["CHAN_SHORTNAME_Raid"] = true
L["CHAN_SHORTNAME_Party"] = true
L["CHAN_SHORTNAME_Yell"] = true
L["CHAN_SHORTNAME_BattleGround"] = true
L["CHAN_SHORTNAME_Officer"] = true
L["CHAN_SHORTNAME_BigFoot"] = true
L["CHAN_SHORTNAME_WhisperTo"] = true
L["CHAN_SHORTNAME_WhisperFrom"] = true
L["CHAN_SHORTNAME_General"] = true
L["CHAN_SHORTNAME_Trade"] = true
L["CHAN_SHORTNAME_LocalDefense"] = true
L["CHAN_SHORTNAME_LFGChannel"] = true
L["CHAN_SHORTNAME_WorldDefense"] = true

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
