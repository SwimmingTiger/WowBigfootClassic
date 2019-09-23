local L = LibStub("AceLocale-3.0"):NewLocale("ClassicCodex", "enUS", true, nil)
if not L then return end


L = L or {}

-- browser.lua
L["Quest Start"] = true
L["Quest End"] = true
L["Quest Level"] = true
L["Required Level"] = true
L["Hostile"] = true
L["Friendly"] = true
L["Reaction"] = true
L["Alliance"] = true
L["Horde"] = true
L["Location"] = true
L["Looted from"] = true
L["Sold by"] = true
L["and %d others"] = true
L["Too many entries. Results shown: %d"] = true
L["Units"] = true
L["Objects"] = true
L["Items"] = true
L["Quests"] = true
L["Left-Click"] = true
L["Open Browser"] = true
L["Shift-Click"] = true
L["Move Button"] = true
L["ClassicCodex"] = true
L["Clean Map"] = true
L["Search"] = true

-- command.lua
L["|cff33ffcc/codex|cffffffff show |cffcccccc - Show database interface"] = true
L["|cff33ffcc/codex|cffffffff unit <unit> |cffcccccc - Search units"] = true
L["|cff33ffcc/codex|cffffffff object <gameObject> |cffcccccc - Search objects"] = true
L["|cff33ffcc/codex|cffffffff item <item> |cffcccccc - Search items"] = true
L["|cff33ffcc/codex|cffffffff vendor <item> |cffcccccc - Search vendors for item"] = true
L["|cff33ffcc/codex|cffffffff quest <questName> |cffcccccc - Show specific quest giver"] = true
L["|cff33ffcc/codex|cffffffff quests |cffcccccc - Show all quests on the map"] = true
L["|cff33ffcc/codex|cffffffff meta <relation> [min, [max]] |cffcccccc - Show related objects on the map"] = true
L["|cff33ffcc/codex|cffffffff clean |cffcccccc - Clean map"] = true
L["|cff33ffcc/codex|cffffffff reset |cffcccccc - Reset map"] = true
L["|cff33ffcc ->|cffffffff Available relations:  |cff33ffccchests|r, |cff33ffccherbs|r, |cff33ffccmines|r"] = true

-- config.lua
L["CONFIG_TEXT_FONT"] = "Fonts/FRIZQT__.ttf"
L["Auto-Accept Quests"] = true
L["Toggle auto-accepting quests"] = true
L["Auto-Turnin Quests"] = true
L["Toggle auto-turning in quests"] = true
L["Nameplate Quest Icon"] = true
L["Toggle quest icon on top of enemy nameplates"] = true
L["All Questgivers"] = true
L["If selected, this will display all questgivers on the map"] = true
L["Current Questgivers"] = true
L["If selected, current quest-ender npcs/objects will be displayed on the map for active quests"] = true
L["Show Low-level Quests"] = true
L["If selected, low-level quests will be hidden on the map"] = true
L["Show High-level Quests"] = true
L["If selected, quests with a level requirement of your level + 3 will be shown on the map"] = true
L["Show Festival Quests"] = true
L["If selected, quests related to WoW festive seasons will be displayed on the map"] = true
L["Color By Spawn"] = true
L["If selected, markers' colors will be set per spawn type or per quest if not selected"] = true
L["Quest Marker Size"] = true
L["Spawn Marker Size"] = true
L["Hide items with a drop probability less than (%)"] = true
L["Show All Quests You Manually Hide"] = true
L["Show all the quests you have hidden by shift + click."] = true
L["Hide a quest by holding the shift key and clicking on the quest icon on the minimap or world map."] = true
L["ClassicCodex: You have no manually hidden quests. You can hold the shift key and click on the quest icon on the minimap or world map to hide it."] = true
L["ClassicCodex: %d hidden quests will be able to show again."] = true

-- map.lua
L["Buy"] = true
L["Required"] = true
L["Loot"] = true
L["Vendor"] = true
L["Level"] = true

-- quest.lua
L["QUEST_STATE_SPLIT_REGEXP"] = "(.*):%s*([%d]+)%s*/%s*([%d]+)"
L["Show"] = true
L["Hide"] = true
L["Reset"] = true
L["All Quests"] = true
L["Tracked Quests"] = true
L["Manual Selection"] = true
L["Hide Quests"] = true

-- ui.lua
L["DEFAULT_FONT"] = "Fonts\\ARIALN.TTF"
