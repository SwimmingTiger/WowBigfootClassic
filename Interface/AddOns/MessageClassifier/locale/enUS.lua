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
L["OPTION_RULE_SETS_FILTER"] = "Filter by Class"
L["OPTION_RULE_SETS_FILTER_ALL"] = "Show All Classes"

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
L["CHAT_MSG_YELL"] = _G["CHAT_MSG_YELL"]

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
        id = 1004,
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
        id = 2002,
        ["class"] = "Group/Quest/{author}",
        ["conditions"] = {
            {
                ["value"] = "quest",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 2003,
        ["class"] = "Group/World Boss/{author}",
        ["conditions"] = {
            {
                ["value"] = "world%s+boss",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 2004,
        ["class"] = "Group/Dungeon/{author}",
        ["conditions"] = {
            {
                ["value"] = "dungeon",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "instance",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 2005,
        ["class"] = "Group/Raid/{author}",
        ["conditions"] = {
            {
                ["value"] = "raid",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3001,
        ["class"] = "Instance/13-18 Ragefire Chasm/{author}",
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
    },
    {
        id = 3002,
        ["class"] = "Instance/17-24 Wailing Caverns/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]wc%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]wailing%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3003,
        ["class"] = "Instance/17-26 The Deadmines/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]vc%f[%A]",
                ["operator"] = "match",
                ["field"] = "content",
            },
            {
                ["value"] = "%f[%a]dmvc%f[%A]",
                ["operator"] = "match",
                ["field"] = "content",
            },
            {
                ["value"] = "deadmine",
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
        ["class"] = "Instance/17-26 The Deadmines/{author}",
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
        ["class"] = "Instance/22-30 Shadowfang Keep/{author}",
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
        ["class"] = "Instance/24-32 Blackfathom Deeps/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]bfd%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "blackfathom",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3005,
        ["class"] = "Instance/24-32 The Stockades/{author}",
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
        ["class"] = "Instance/29-38 Gnomeregan/{author}",
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
        ["class"] = "Instance/29-38 Razorfen Kraul/{author}",
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
        ["class"] = "Instance/26-45 The Scarlet Monastery/{author}",
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
        ["class"] = "Instance/26-36 The Scarlet Monastery: Graveyard/{author}",
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
            {
                ["value"] = "graveyard",
                ["field"] = "content",
                ["operator"] = "contain",
            },
        },
    },
    {
        id = 3010,
        ["class"] = "Instance/29-39 The Scarlet Monastery: Library/{author}",
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
        ["class"] = "Instance/32-42 The Scarlet Monastery: Armory/{author}",
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
        ["class"] = "Instance/35-45 The Scarlet Monastery: Cathedral/{author}",
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
        ["class"] = "Instance/37-46 Razorfen Downs/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]rfd%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "razorfen%s+downs",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3014,
        ["class"] = "Instance/41-51 Uldaman/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]uld%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
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
        ["class"] = "Instance/44-54 Zul'Farrak/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]zf%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]zul%f[%A]",
                ["operator"] = "match",
                ["field"] = "content",
            },
            {
                ["value"] = "farak",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "farrak",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3016,
        ["class"] = "Instance/46-55 Maraudon/{author}",
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
        ["class"] = "Instance/50-60 Temple of Atal'Hakkar/{author}",
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
                ["value"] = "hakkar%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3117,
        ["class"] = "Instance/50-60 Temple of Atal'Hakkar/{author}",
        ["logic"] = "and",
        ["conditions"] = {
            {
                ["value"] = "temple",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "ahn",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
            {
                ["value"] = "qiraj",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
            {
                ["value"] = "black",
                ["field"] = "content",
                ["operator"] = "not contain",
            },
        },
    },
    {
        id = 3018,
        ["class"] = "Instance/52-60 Blackrock Depths/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]brd%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "blackrock%s+depth",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3019,
        ["class"] = "Instance/55-60 Blackrock Spire/{author}",
        ["conditions"] = {
            {
                ["value"] = "blackrock",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "spire",
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
        ["class"] = "Instance/55-60 Lower Blackrock Spire/{author}",
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
        ["class"] = "Instance/55-60 Upper Blackrock Spire/{author}",
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
        ["class"] = "Instance/55-60 Dire Maul/{author}",
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
            {
                ["value"] = "dire maul",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3122,
        ["class"] = "Instance/55-60 Dire Maul (East)/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]dm%s+e",
                ["operator"] = "match",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3222,
        ["class"] = "Instance/58-60 Dire Maul (West)/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]dm%s+w",
                ["operator"] = "match",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3322,
        ["class"] = "Instance/58-60 Dire Maul (North)/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]dm%s+n",
                ["operator"] = "match",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3023,
        ["class"] = "Instance/58-60 Stratholme/{author}",
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
        ["class"] = "Instance/58-60 Scholomance/{author}",
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
        ["class"] = "Instance/60 Molten Core/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]mc%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "molten%s+core",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3026,
        ["class"] = "Instance/60 Onyxia's Lair/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]ony%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]onx%f[%A]",
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
    {
        id = 3027,
        ["class"] = "Instance/60 Blackwing Lair/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]bwl%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "blackwing",
                ["operator"] = "contain",
                ["field"] = "content",
            },
            {
                ["value"] = "nefarian",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3028,
        ["class"] = "Instance/55-60 Zul'Gurub/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]zg%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]zug%f[%A]",
                ["operator"] = "match",
                ["field"] = "content",
            },
            {
                ["value"] = "gurub",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3029,
        ["class"] = "Instance/60 The Temple of Ahn'Qiraj/{author}",
        ["conditions"] = {
            {
                ["value"] = "aq40",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "%f[%a]taq%f[%A]",
                ["operator"] = "match",
                ["field"] = "content",
            },
            {
                ["value"] = "%f[%a]ahn",
                ["operator"] = "match",
                ["field"] = "content",
            },
            {
                ["value"] = "qiraj",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3030,
        ["class"] = "Instance/60 Ruins of Ahn'Qiraj/{author}",
        ["conditions"] = {
            {
                ["value"] = "aq20",
                ["field"] = "content",
                ["operator"] = "contain",
            },
            {
                ["value"] = "%f[%a]raq%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]ahn",
                ["operator"] = "match",
                ["field"] = "content",
            },
            {
                ["value"] = "qiraj",
                ["operator"] = "contain",
                ["field"] = "content",
            },
        },
    },
    {
        id = 3031,
        ["class"] = "Instance/60+ Naxxramas/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]naxx",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },{
        id = 3032,
        ["class"] = "Instance/59-67 Hellfire Ramparts/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]ramp",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3033,
        ["class"] = "Instance/60-68 The Blood Furnace/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]bf%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]furnace%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3034,
        ["class"] = "Instance/69-70 The Shattered Halls/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]sh%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
        {
            ["value"] = "%f[%a]shattered%s+hall",
            ["field"] = "content",
            ["operator"] = "match",
        },
    },
    {
        id = 3035,
        ["class"] = "Instance/63-70 Mana-Tombs/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]mt%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]tombs%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3036,
        ["class"] = "Instance/64-70 Auchenai Crypts/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]ac%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]crypts%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3037,
        ["class"] = "Instance/66-70 Sethekk Halls/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]seth",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3038,
        ["class"] = "Instance/69-70 Shadow Labyrinth/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]sl%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]shadow%s+lab",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]lab%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]slab",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3039,
        ["class"] = "Instance/61-69 The Slave Pens/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]sp%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]slave%s+pen",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3040,
        ["class"] = "Instance/62-70 The Underbog/{author}",
        ["conditions"] = {
            {
                ["value"] = "bog%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]ub%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3041,
        ["class"] = "Instance/69-70 The Steamvault/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]sv%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]vault",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]steam%s*vault",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3042,
        ["class"] = "Instance/66-70 Old Hillsbrad Foothills/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]ohf%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]old%s+hills",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3043,
        ["class"] = "Instance/68-70 The Black Morass/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]bm%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]morass%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3044,
        ["class"] = "Instance/69-70 The Arcatraz/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]arca",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]az%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3045,
        ["class"] = "Instance/68-70 The Mechanar/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]mech",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3046,
        ["class"] = "Instance/69-70 The Botanica/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]bot",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3047,
        ["class"] = "Instance/69-70 Magisters' Terrace/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]terrace%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]mgt%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]mst%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]magterr%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]mt%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]qt5%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3048,
        ["class"] = "Instance/68-70 Karazhan/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]kara",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3049,
        ["class"] = "Instance/68-70 Zul'Aman/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]zul'?%s*aman%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3050,
        ["class"] = "Instance/70 Magtheridon's Lair/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]mag",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3051,
        ["class"] = "Instance/65-70 Gruul's Lair/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]gruul",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3052,
        ["class"] = "Instance/70 Serpentshrine Cavern/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]ssc%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]serpentshrine",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3053,
        ["class"] = "Instance/70 The Eye/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]the%s+eye%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]te%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]tk%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3054,
        ["class"] = "Instance/70 The Battle for Mount Hyjal/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]hyjal%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3055,
        ["class"] = "Instance/70 Black Temple/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]black%s+temple%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]bt%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
    {
        id = 3056,
        ["class"] = "Instance/70 Sunwell Plateau/{author}",
        ["conditions"] = {
            {
                ["value"] = "%f[%a]qd25%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]swp%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
            {
                ["value"] = "%f[%a]sunwell%f[%A]",
                ["field"] = "content",
                ["operator"] = "match",
            },
        },
    },
}
