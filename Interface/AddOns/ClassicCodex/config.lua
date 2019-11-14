local L = LibStub("AceLocale-3.0"):GetLocale("ClassicCodex")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

CodexConfig = {}
CodexColors = {}

DefaultCodexConfig = {
    ["trackingMethod"] = 1, -- 1: All Quests; 2: Tracked Quests; 3: Manual; 4: Hide
    ["autoAccept"] = false, -- Auto-accept quests
    ["autoTurnin"] = false, -- Auto-turnin quests
    ["nameplateIcon"] = false, -- Show quest icon above nameplates
    ["minimapButton"] = true, -- Show button of codex browser on the edge of the minimap
    ["continentIcon"] = false, -- Show quest markers on continent map
    ["allQuestGivers"] = true, -- Show available quest givers
    ["currentQuestGivers"] = true, -- Show current quest giver nodes
    ["alwaysShowId"] = false, -- Display unit/object/item/quest id in non-id search results
    ["showLowLevel"] = false, -- Show low level quest giver nodes
    ["showHighLevel"] = true, -- Show level+3 quest giver nodes
    ["showFestival"] = false, -- Show event quest giver nodes
    ["colorBySpawn"] = true,
    ["questMarkerSize"] = 15,
    ["spawnMarkerSize"] = 15,
    ["bossMarkerSize"] = 25, -- Display a larger icon for the boss or a single target to help you find it.
    ["minimumDropChance"] = 2, -- (%) Hide markers with a drop probability less than this value
}

CodexConfigFrame = CreateFrame("Frame", "CodexConfigFrame", UIParent)

function CodexConfigFrame:LoadConfig()
    if not CodexConfig then CodexConfig = {} end

    for key, val in pairs(DefaultCodexConfig) do
        if CodexConfig[key] == nil then
            if key == "colorList" then
                CodexConfig[key] = {unpack(val)}
            else
                CodexConfig[key] = val
            end
        end
    end

    self:UpdateMinimapButton()

    self.configTable = {
        type = "group",
        name = "ClassicCodex",
        args = {
            autoAccept = {
                order = 101, -- row: 1, column: 1
                type = "toggle",
                width = 1.5, -- make two checkboxes on the same line
                name = L["Auto-Accept Quests"],
                desc = L["Toggle auto-accepting quests"],
                get = function(info)
                    return CodexConfig.autoAccept
                end,
                set = function(info, val)
                    CodexConfig.autoAccept = val
                end
            },
            alwaysShowId = {
                order = 102, -- row: 1, column: 2
                type = "toggle",
                width = 1.5, -- make two checkboxes on the same line
                name = L["Show ID in Codex Browser"],
                desc = L["If selected, the item/object/unit/quest ID will be displayed when you searching something in Codex browser."],
                get = function(info)
                    return CodexConfig.alwaysShowId
                end,
                set = function(info, val)
                    CodexConfig.alwaysShowId = val
                    CodexBrowser.input:Search()
                end
            },
            autoTurnin = {
                order = 201, -- row: 2, column: 1
                type = "toggle",
                width = 1.5, -- make two checkboxes on the same line
                name = L["Auto-Turnin Quests"],
                desc = L["Toggle auto-turning in quests"],
                get = function(info)
                    return CodexConfig.autoTurnin
                end,
                set = function(info, val)
                    CodexConfig.autoTurnin = val
                end
            },
            minimapButton = {
                order = 202, -- row: 2, column: 2
                type = "toggle",
                width = 1.5, -- make two checkboxes on the same line
                name = L["Show Minimap Button"],
                desc = L["Show a button on the edge of the minimap, click to open Codex browser"],
                get = function(info)
                    return CodexConfig.minimapButton
                end,
                set = function(info, val)
                    CodexConfig.minimapButton = val
                    CodexConfigFrame:UpdateMinimapButton()
                end
            },
            nameplateIcon = {
                order = 301,
                type = "toggle",
                width = 1.5,
                name = L["Nameplate Quest Icon"],
                desc = L["Toggle quest icon on top of enemy nameplates"],
                get = function(info)
                    return CodexConfig.nameplateIcon
                end,
                set = function(info, val)
                    CodexConfig.nameplateIcon = val
                end
            },
            continentIcon = {
                order = 302,
                type = "toggle",
                width = 1.5,
                name = L["Show Markers on Continent"],
                desc = L["Show markers at the top level of the world map"],
                get = function(info)
                    return CodexConfig.continentIcon
                end,
                set = function(info, val)
                    CodexConfig.continentIcon = val
                    CodexMap:UpdateNodes()
                end
            },
            allQuestGivers = {
                order = 401, -- row: 4, column: 1
                type = "toggle",
                width = 3, -- make the next checkbox in a new line
                name = L["All Questgivers"],
                desc = L["If selected, this will display all questgivers on the map"],
                get = function(info)
                    return CodexConfig.allQuestGivers
                end,
                set = function(info, val)
                    CodexConfig.allQuestGivers = val
                    CodexQuest:ResetAll()
                end
            },
            currentQuestGivers = {
                order = 501, -- row: 5, column: 1
                type = "toggle", -- make the next checkbox in a new line
                width = 3,
                name = L["Current Questgivers"],
                desc = L["If selected, current quest-ender npcs/objects will be displayed on the map for active quests"],
                get = function(info)
                    return CodexConfig.currentQuestGivers
                end,
                set = function(info, val)
                    CodexConfig.currentQuestGivers = val
                    CodexQuest:ResetAll()
                end
            },
            showLowLevel = {
                order = 601,
                type = "toggle",
                width = 3,
                name = L["Show Low-level Quests"],
                desc = L["If selected, low-level quests will be hidden on the map"],
                get = function(info)
                    return CodexConfig.showLowLevel
                end,
                set = function(info, val)
                    CodexConfig.showLowLevel = val
                    CodexQuest:ResetAll()
                end
            },
            showHighLevel = {
                order = 701,
                type = "toggle",
                width = 3,
                name = L["Show High-level Quests"],
                desc = L["If selected, quests with a level requirement of your level + 3 will be shown on the map"],
                get = function(info)
                    return CodexConfig.showHighLevel
                end,
                set = function(info, val)
                    CodexConfig.showHighLevel = val
                    CodexQuest:ResetAll()
                end
            },
            showFestival = {
                order = 801,
                type = "toggle",
                width = 3,
                name = L["Show Festival/PVP/Misc Quests"],
                desc = L["If selected, quests related to WoW festive seasons or PVP or not available at the current stage will be displayed on the map"],
                get = function(info)
                    return CodexConfig.showFestival
                end,
                set = function(info, val)
                    CodexConfig.showFestival = val
                    CodexQuest:ResetAll()
                end
            },
            colorBySpawn = {
                order = 901,
                type = "toggle",
                width = 3,
                name = L["Color By Spawn"],
                desc = L["If selected, markers' colors will be set per spawn type or per quest if not selected"],
                get = function(info)
                    return CodexConfig.colorBySpawn
                end,
                set = function(info, val)
                    CodexConfig.colorBySpawn = val
                    CodexQuest:ResetAll()
                end
            },
            questMarkerSize = {
                order = 1001,
                type = "range",
                width = 1,
                name = L["Quest Marker Size"],
                min = 0,
                max = 300,
                step = 1,
                softMin = 10,
                softMax = 50,
                bigStep = 1,
                get = function(info)
                    return CodexConfig.questMarkerSize
                end,
                set = function(info, val)
                    CodexConfig.questMarkerSize = tonumber(val)
                    CodexMap:UpdateNodes()
                end
            },
            spawnMarkerSize = {
                order = 1002,
                type = "range",
                width = 1,
                name = L["Spawn Marker Size"],
                min = 0,
                max = 300,
                step = 1,
                softMin = 10,
                softMax = 50,
                bigStep = 1,
                get = function(info)
                    return CodexConfig.spawnMarkerSize
                end,
                set = function(info, val)
                    CodexConfig.spawnMarkerSize = tonumber(val)
                    CodexMap:UpdateNodes()
                end
            },
            bossMarkerSize = {
                order = 1003,
                type = "range",
                width = 1,
                name = L["Boss Marker Size"],
                desc = L["Display a larger icon for the boss or a single target to help you find it"],
                min = 0,
                max = 300,
                step = 1,
                softMin = 10,
                softMax = 50,
                bigStep = 1,
                get = function(info)
                    return CodexConfig.bossMarkerSize
                end,
                set = function(info, val)
                    CodexConfig.bossMarkerSize = tonumber(val)
                    CodexMap:UpdateNodes()
                end
            },
            minimumDropChance = {
                order = 1101,
                type = "range",
                width = 3,
                name = L["Hide items with a drop probability less than (%)"],
                min = 0,
                max = 100,
                step = 1,
                get = function(info)
                    return CodexConfig.minimumDropChance
                end,
                set = function(info, val)
                    CodexConfig.minimumDropChance = tonumber(val)
                    CodexQuest:ResetAll()
                end
            },
            listHiddenQuests = {
                order = 1201,
                type = "execute",
                width = 1.5,
                name = L["List Manually Hidden Quests"],
                func = function(info)
                    if CodexBrowser then
                        CodexBrowser.input:SetText('!')
                        CodexBrowser:OpenView('quests')
                    end
                end,
            },
            listCompletedQuests = {
                order = 1202,
                type = "execute",
                width = 1.5,
                name = L["List Completed Quests"],
                func = function(info)
                    if CodexBrowser then
                        CodexBrowser.input:SetText('@')
                        CodexBrowser:OpenView('quests')
                    end
                end,
            },
            showAllHiddenQuests = {
                order = 1301,
                type = "execute",
                width = 1.5,
                name = L["Show All Quests You Manually Hide Again"],
                desc = L["Show all the quests you have hidden by shift + click."].."\n"..
                       L["Hide a quest by holding the shift key and clicking on the quest icon on the minimap or world map."],
                func = function(info)
                    local size = Codex:tablelen(CodexHiddenQuests)
                    CodexHiddenQuests = {}
                    CodexQuest:ResetAll()
                    if size < 1 then
                        print(L["ClassicCodex: You have no manually hidden quests. You can hold the shift key and click on the quest icon on the minimap or world map to hide it."])
                    else
                        print(string.format(L["ClassicCodex: %d hidden quests will be able to show again."], size))
                    end
                end,
            },
            openCodexBrowser = {
                order = 1302,
                type = "execute",
                width = 1.5,
                name = L["Open Codex Browser"],
                func = function(info)
                    if CodexBrowser then
                        CodexBrowser:Show()
                    end
                end,
            },
        },
    }

    self.registeredOptionsTable = AceConfigRegistry:RegisterOptionsTable("ClassicCodex", self.configTable)
    self.blizOptions = AceConfigDialog:AddToBlizOptions("ClassicCodex", "ClassicCodex")
end

function CodexConfigFrame:UpdateMinimapButton()
    if not CodexBrowserIcon then return end
    if CodexConfig.minimapButton then
        CodexBrowserIcon:Show()
    else
        CodexBrowserIcon:Hide()
    end
end

CodexConfigFrame:RegisterEvent("ADDON_LOADED")
CodexConfigFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "ClassicCodex" then
        self:LoadConfig()
        CodexConfigFrame:UnregisterEvent("ADDON_LOADED")
    end
end)
