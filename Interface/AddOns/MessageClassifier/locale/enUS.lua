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
L["OPTION_ENABLED"] = "Enable message classifier duplicate filter"
L["OPTION_ENABLED_TOOLTIP"] = "Don't display duplicate messages in public channel/world channels. And classify and collect messages into a browser."
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
L["OPTION_CONDITIONS"] = "If"
L["OPTION_CONDITION_LOGIC"] = "Logic"
L["OPTION_RULE_LOGIC_OR"] = "one of the conditions is true"
L["OPTION_RULE_LOGIC_AND"] = "all conditions are true at the same time"
L["OPTION_HIDE_FROM_CHAT_WINDOW"] = "Hide from chat window"
L["OPTION_ENABLE"] = "Enable"
L["OPTION_CLASS"] = "Then add to this class"
L["OPTION_CLASS_NO_CONDITIONS"] = "Always add to this class"
L["OPTION_CLASS_EDIT_TITLE"] = "Then add to this class (available variables: |cffc586c0{author}|r and |cffc586c0{channel}|r)"
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
L["equal"] = true
L["not equal"] = true
L["contain"] = true
L["not contain"] = true
L["match"] = true
L["not match"] = true

-- Channels
L["CHAN_FULLNAME_GUILD"] = true
L["CHAN_FULLNAME_RAID"] = true
L["CHAN_FULLNAME_PARTY"] = true
L["CHAN_FULLNAME_GENERAL"] = true
L["CHAN_FULLNAME_TRADE"] = true
L["CHAN_FULLNAME_WORLDDEFENSE"] = true
L["CHAN_FULLNAME_LOCALDEFENSE"] = true
L["CHAN_FULLNAME_LFGCHANNEL"] = true
L["CHAN_FULLNAME_BATTLEGROUND"] = true
L["CHAN_FULLNAME_YELL"] = true
L["CHAN_FULLNAME_SAY"] = true
L["CHAN_FULLNAME_WHISPERTO"] = true
L["CHAN_FULLNAME_WHISPERFROM"] = true
L["CHAN_FULLNAME_BIGFOOTCHANNEL"] = true
L["CHAN_SHORTNAME_GUILD"] = true
L["CHAN_SHORTNAME_RAID"] = true
L["CHAN_SHORTNAME_PARTY"] = true
L["CHAN_SHORTNAME_YELL"] = true
L["CHAN_SHORTNAME_BATTLEGROUND"] = true
L["CHAN_SHORTNAME_OFFICER"] = true
L["CHAN_SHORTNAME_BIGFOOT"] = true
L["CHAN_SHORTNAME_WHISPERTO"] = true
L["CHAN_SHORTNAME_WHISPERFROM"] = true
L["CHAN_SHORTNAME_GENERAL"] = true
L["CHAN_SHORTNAME_TRADE"] = true
L["CHAN_SHORTNAME_LOCALDEFENSE"] = true
L["CHAN_SHORTNAME_LFGCHANNEL"] = true
L["CHAN_SHORTNAME_WORLDDEFENSE"] = true

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
        id = 1002,
        ["class"] = "Sell/{author}",
        ["conditions"] = {
            {
                ["value"] = "sell",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "buy",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 1003,
        ["conditions"] = {
            {
                ["value"] = "%f[%a]air",
                ["operator"] = "match",
                ["field"] = "content",
            },
            {
                ["value"] = "plane%f[%A]",
                ["operator"] = "match",
                ["field"] = "content",
            },
        },
        ["class"] = "Airplane/{author}",
    },
    {
        id = 2001,
        ["class"] = "Instance/Dungeon/{author}",
        ["conditions"] = {
            {
                ["value"] = "dungeon",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 2001,
        ["class"] = "Instance/Raid/{author}",
        ["conditions"] = {
            {
                ["value"] = "raid",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 2002,
        ["class"] = "Quest/{author}",
        ["conditions"] = {
            {
                ["value"] = "quest",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3001,
        ["conditions"] = {
            {
                ["value"] = "ragefire",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "%f[%a]rfc%f[%A]",
                ["operator"] = "match",
                ["field"] = "content",
            },
        },
        ["class"] = "Instance/Ragefire Chasm/{author}",
    },
    {
        id = 3002,
        ["class"] = "Instance/Wailing Caverns/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]wc%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3003,
        ["class"] = "Instance/The Deadmines/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]vc%f[%A]",
                ["operator"] = "match",
                ["field"] = "content",
            },
            {
                ["value"] = "deadmines",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "todesminen",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3103,
        ["class"] = "Instance/The Deadmines/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]dm%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]dm%s+e",
                ["operator"] = "not match",
                ["field"] = "content",
            },
            {
                ["value"] = "%f[%a]dm%s+w",
                ["operator"] = "not match",
                ["field"] = "content",
            },
            {
                ["value"] = "%f[%a]dm%s+n",
                ["operator"] = "not match",
                ["field"] = "content",
            },
        },
        ["logic"] = "and",
    },
    {
        id = 3004,
        ["class"] = "Instance/Shadowfang Keep/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]sfk%f[%A]",
                ["operator"] = "match",
                ["field"] = "content",
            },
            {
                ["value"] = "shadowfang",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "%f[%a]bsf%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3105,
        ["class"] = "Instance/Blackfathom Deeps/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]bfd%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3005,
        ["class"] = "Instance/The Stockades/{author}",
        ["conditions"] = {
            {
                ["value"] = "stockades",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "stocks",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "verlies",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3006,
        ["class"] = "Instance/Gnomeregan/{author}",
        ["conditions"] = {
            {
                ["value"] = "gnome",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3007,
        ["class"] = "Instance/Razorfen Kraul/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]rfk%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "kraul",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3008,
        ["class"] = "Instance/The Scarlet Monastery/{author}",
        ["conditions"] = {
            {
                ["value"] = "scarlet",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "monastery",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3009,
        ["class"] = "Instance/The Scarlet Monastery: Graveyard/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]sm%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]gy%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "friedhof",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3010,
        ["class"] = "Instance/The Scarlet Monastery: Library/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]lib%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "library",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "bücherrei",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3011,
        ["class"] = "Instance/The Scarlet Monastery: Armory/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]arm%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "armory",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "waffenkammer",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "%f[%a]wk%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3012,
        ["class"] = "Instance/The Scarlet Monastery: Cathedral/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]cath%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "cathedral",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "kathe",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "kathedrale",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3013,
        ["class"] = "Instance/Razorfen Downs/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]rfd%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3014,
        ["class"] = "Instance/Uldaman/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]ulda%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "uldaman",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3015,
        ["class"] = "Instance/Zul'Farak/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]zf%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]zul",
                ["operator"] = "match",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3016,
        ["class"] = "Instance/Maraudon/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]mara",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "maraudon",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3017,
        ["class"] = "Instance/Temple of Atal'Hakkar/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]st%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]toa%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]atal",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]temple",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3018,
        ["class"] = "Instance/Blackrock Depths/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]brd%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3019,
        ["class"] = "Instance/Blackrock Spire/{author}",
        ["conditions"] = {
            {
                ["value"] = "blackrock",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "brs%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3020,
        ["class"] = "Instance/Lower Blackrock Spire/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]lbrs%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3021,
        ["class"] = "Instance/Upper Blackrock Spire/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]ubrs%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3022,
        ["class"] = "Instance/Dire Maul/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]dm%s+e",
                ["operator"] = "match",
                ["field"] = "content",
            },
            {
                ["value"] = "%f[%a]dm%s+w",
                ["operator"] = "match",
                ["field"] = "content",
            },
            {
                ["value"] = "%f[%a]dm%s+n",
                ["operator"] = "match",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3023,
        ["class"] = "Instance/Stratholme/{author}",
        ["conditions"] = {
            {
                ["value"] = "strat",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3024,
        ["class"] = "Instance/Scholomance/{author}",
        ["conditions"] = {
            {
                ["value"] = "scholo",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3025,
        ["class"] = "Instance/Molten Core/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]mc%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3026,
        ["class"] = "Instance/Onyxia's Lair/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]ony%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "onyxia",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
}
