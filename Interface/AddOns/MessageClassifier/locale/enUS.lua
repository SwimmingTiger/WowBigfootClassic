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
            }, -- [1]
            {
                ["value"] = "buy",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [2]
        },
    }, -- [2]
    {
        id = 1003,
        ["conditions"] = {
            {
                ["value"] = " air",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [1]
            {
                ["value"] = "plane",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
        },
        ["class"] = "Airplane/{author}",
    }, -- [3]
    {
        id = 2001,
        ["class"] = "Instance/Dungeon/{author}",
        ["conditions"] = {
            {
                ["value"] = "dungeon",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [4]
    {
        id = 2001,
        ["class"] = "Instance/Raid/{author}",
        ["conditions"] = {
            {
                ["value"] = "raid",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [4]
    {
        id = 2002,
        ["class"] = "Quest/{author}",
        ["conditions"] = {
            {
                ["value"] = "quest",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [5]
    {
        id = 3001,
        ["conditions"] = {
            {
                ["value"] = "ragefire",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [1]
            {
                ["value"] = " rfc ",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
        },
        ["class"] = "Instance/Ragefire Chasm/{author}",
    }, -- [6]
    {
        id = 3002,
        ["class"] = "Instance/Wailing Caverns/{author}",
        ["conditions"] = {
            {
                ["value"] = " wc ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [7]
    {
        id = 3003,
        ["class"] = "Instance/The Deadmines/{author}",
        ["conditions"] = {
            {
                ["value"] = " vc ",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
            {
                ["value"] = "deadmines",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [3]
            {
                ["value"] = "todesminen",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [4]
        },
    }, -- [8]
    {
        id = 3103,
        ["class"] = "Instance/The Deadmines/{author}",
        ["conditions"] = {
            {
                ["value"] = " dm ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = " dm e",
                ["operator"] = "not contain",
                ["field"] = "content",
            }, -- [2]
            {
                ["value"] = " dm w",
                ["operator"] = "not contain",
                ["field"] = "content",
            }, -- [3]
            {
                ["value"] = " dm n",
                ["operator"] = "not contain",
                ["field"] = "content",
            }, -- [4]
        },
        ["logic"] = "and",
    }, -- [8]
    {
        id = 3004,
        ["class"] = "Instance/Shadowfang Keep/{author}",
        ["conditions"] = {
            {
                ["value"] = " sfk ",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [1]
            {
                ["value"] = "shadowfang",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [2]
            {
                ["value"] = " bsf ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [3]
        },
    }, -- [9]
    {
        id = 3105,
        ["class"] = "Instance/Blackfathom Deeps/{author}",
        ["conditions"] = {
            {
                ["value"] = " bfd ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [10]
    {
        id = 3005,
        ["class"] = "Instance/The Stockades/{author}",
        ["conditions"] = {
            {
                ["value"] = "stockades",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "stocks",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [2]
            {
                ["value"] = "verlies",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [3]
        },
    }, -- [10]
    {
        id = 3006,
        ["class"] = "Instance/Gnomeregan/{author}",
        ["conditions"] = {
            {
                ["value"] = "gnome",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [11]
    {
        id = 3007,
        ["class"] = "Instance/Razorfen Kraul/{author}",
        ["conditions"] = {
            {
                ["value"] = " rfk ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "kraul",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
        },
    }, -- [12]
    {
        id = 3008,
        ["class"] = "Instance/The Scarlet Monastery/{author}",
        ["conditions"] = {
            {
                ["value"] = "scarlet",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "monastery",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [13]
    {
        id = 3009,
        ["class"] = "Instance/The Scarlet Monastery: Graveyard/{author}",
        ["conditions"] = {
            {
                ["value"] = " sm ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = " gy ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "friedhof",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [14]
    {
        id = 3010,
        ["class"] = "Instance/The Scarlet Monastery: Library/{author}",
        ["conditions"] = {
            {
                ["value"] = " lib ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "library",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "bücherrei",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [15]
    {
        id = 3011,
        ["class"] = "Instance/The Scarlet Monastery: Armory/{author}",
        ["conditions"] = {
            {
                ["value"] = " arm ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "armory",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "waffenkammer",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = " wk ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [16]
    {
        id = 3012,
        ["class"] = "Instance/The Scarlet Monastery: Cathedral/{author}",
        ["conditions"] = {
            {
                ["value"] = " cath ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "cathedral",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "kathe",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "kathedrale",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [17]
    {
        id = 3013,
        ["class"] = "Instance/Razorfen Downs/{author}",
        ["conditions"] = {
            {
                ["value"] = " rfd ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [18]
    {
        id = 3014,
        ["class"] = "Instance/Uldaman/{author}",
        ["conditions"] = {
            {
                ["value"] = " ulda ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "uldaman",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
        },
    }, -- [19]
    {
        id = 3015,
        ["class"] = "Instance/Zul'Farak/{author}",
        ["conditions"] = {
            {
                ["value"] = " zf ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = " zul",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
        },
    }, -- [20]
    {
        id = 3016,
        ["class"] = "Instance/Maraudon/{author}",
        ["conditions"] = {
            {
                ["value"] = " mara",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "maraudon",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
        },
    }, -- [21]
    {
        id = 3017,
        ["class"] = "Instance/Temple of Atal'Hakkar/{author}",
        ["conditions"] = {
            {
                ["value"] = " st ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = " toa ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = " atal",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = " temple",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [22]
    {
        id = 3018,
        ["class"] = "Instance/Blackrock Depths/{author}",
        ["conditions"] = {
            {
                ["value"] = " brd ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [23]
    {
        id = 3019,
        ["class"] = "Instance/Blackrock Spire/{author}",
        ["conditions"] = {
            {
                ["value"] = "blackrock",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "brs ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [24]
    {
        id = 3020,
        ["class"] = "Instance/Lower Blackrock Spire/{author}",
        ["conditions"] = {
            {
                ["value"] = " lbrs ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [25]
    {
        id = 3021,
        ["class"] = "Instance/Upper Blackrock Spire/{author}",
        ["conditions"] = {
            {
                ["value"] = " ubrs ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [26]
    {
        id = 3022,
        ["class"] = "Instance/Dire Maul/{author}",
        ["conditions"] = {
            {
                ["value"] = " dm e",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = " dm w",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = " dm n",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [27]
    {
        id = 3023,
        ["class"] = "Instance/Stratholme/{author}",
        ["conditions"] = {
            {
                ["value"] = "strat",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [28]
    {
        id = 3024,
        ["class"] = "Instance/Scholomance/{author}",
        ["conditions"] = {
            {
                ["value"] = "scholo",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [29]
    {
        id = 3025,
        ["class"] = "Instance/Molten Core/{author}",
        ["conditions"] = {
            {
                ["value"] = "mc",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
        },
    }, -- [30]
    {
        id = 3026,
        ["class"] = "Instance/Onyxia's Lair/{author}",
        ["conditions"] = {
            {
                ["value"] = " ony ",
                ["field"] = "content",
                ["operator"] = "contain",
            }, -- [1]
            {
                ["value"] = "onyxia",
                ["operator"] = "contain",
                ["field"] = "content",
            }, -- [2]
        },
    }, -- [31]
}
