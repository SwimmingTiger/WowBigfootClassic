local ADDON_NAME = ...
local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

MessageClassifierConfig = {}

--[[
-- Fields and values of classificationRules:
{
    id = <integer> -- Only for default rules. Don't change it once assigned.
    
    logic = "and"
            "or"
            Default: "or"

    conditions = { -- Matches any message if conditions is an empty array
        {
            field: "author",
                "channel"
                "content"
            operator: "equal"
                    "not equal"
                    "contain"
                    "not contain"
                    "match"
                    "not match"
            value: <string>
                <regular expression>
                Example: "molten"
                            " AA "
                            "15g"
                            "%bAA%b"
                            "%d+g%b"
            
            caseSensitive: true
                        false
                        Default: false
        }, ...
    }

    class: <string>,
            Available variables: {author}
                                 {channel},
            Example: "RAID"
                     "Sell"
                     "Quest"
                     "The Molten Core"
                     "By Author/{author}"
                     "By Channel/{channel}"
    
    hideFromChatWindow: true
                        false
                        Default: false
    
    enabled: true
             false
             Default: true
}, ...
]]
MessageClassifierDefaultRules = MessageClassifierDefaultRules or {}

local defaultConfig = {
    ["enabled"] = true,
    ["minDupInterval"] = 0,
    ["classificationRules"] = {},
    ["enabledDefaultRules"] = {},
    ["defRulHideFromChatWindow"] = {},
}

local classPathLocales = {
    ["{author}"] = string.format("{%s}", L["author"]),
    ["{channel}"] = string.format("{%s}", L["channel"]),
}

local function localizeClassPath(class)
    for k,v in pairs(classPathLocales) do
        class = class:gsub(k, v)
    end
    return class
end

local function localizeClassPathWithColor(class)
    class = class:gsub('/', '|cffdb800a/|r')
    for k,v in pairs(classPathLocales) do
        class = class:gsub(k, string.format("|cffc586c0%s|r", v))
    end
    return class
end

local function delocalizeClassPath(class)
    for k,v in pairs(classPathLocales) do
        class = class:gsub(v, k)
    end
    return class
end

local function ruleToText(ruleSet)
    local text = ""
    if #ruleSet.conditions == 0 then
        text = text..string.format("%s:\n    %s", L["OPTION_CLASS_NO_CONDITIONS"], localizeClassPathWithColor(ruleSet.class))
    else
        if #ruleSet.conditions == 1 then
            text = text..string.format("%s", L["OPTION_CONDITIONS"])

            local rule = ruleSet.conditions[1]
            text = text..string.format(" |cffdcdcaa%s|r |cff569cd6%s|r |cffce9178%s|r", L[rule.field], L[rule.operator], rule.value)
            if rule.caseSensitive then
                text = text..string.format(" (%s)", L["OPTION_COND_CASESENSITIVE"])
            end
        else
            local logicOr = ruleSet.logic ~= "and"
            text = text..string.format("%s |cffc586c0%s|r:", L["OPTION_CONDITIONS"], logicOr and L["OPTION_RULE_LOGIC_OR"] or L["OPTION_RULE_LOGIC_AND"])

            for _, rule in ipairs(ruleSet.conditions) do
                text = text..string.format("\n    |cffdcdcaa%s|r |cff569cd6%s|r |cffce9178%s|r", L[rule.field], L[rule.operator], rule.value)
                if rule.caseSensitive then
                    text = text..string.format(" (%s)", L["OPTION_COND_CASESENSITIVE"])
                end
            end
        end

        text = text..string.format("\n\n%s:\n    %s", L["OPTION_CLASS"], localizeClassPathWithColor(ruleSet.class))
    end
    return text
end

local function deepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepCopy(orig_key)] = deepCopy(orig_value)
        end
        setmetatable(copy, deepCopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

MessageClassifierConfigFrame = CreateFrame("Frame", "MessageClassifierConfigFrame", UIParent)
MessageClassifierConfigFrame.ruleEditCache = {}

function MessageClassifierConfigFrame:loadConfig()
    if not MessageClassifierConfig then MessageClassifierConfig = {} end

    for key, val in pairs(defaultConfig) do
        if MessageClassifierConfig[key] == nil then
            MessageClassifierConfig[key] = val
        end
    end

    self.configTable = {
        type = "group",
        name = L["CONFIG_PAGE_TITLE"],
        args = {
            enabled = {
                order = 1,
                type = "toggle",
                width = "full",
                name = L["OPTION_ENABLED"], 
                desc = L["OPTION_ENABLED_TOOLTIP"],
                get = function(info)
                    return MessageClassifierConfig.enabled
                end,
                set = function(info, val)
                    MessageClassifier.Toggle(val)
                end
            },
            minDupInterval = {
                order = 2,
                type = "range",
                width = 3,
                name = L["OPTION_MIN_DUP_INTERVAL"],
                min = 0,
                max = 86400,
                softMin = 0,
                softMax = 3600,
                bigStep = 10,
                get = function(info)
                    return MessageClassifierConfig.minDupInterval
                end,
                set = function(info, val)
                    MessageClassifierConfig.minDupInterval = val
                end
            },
            reset = {
                order = 3,
                type = "execute",
                name = L["OPTION_RESET"],
                desc = L["OPTION_RESET_TOOLTIP"],
                func = function(info)
                    MessageClassifier.Reset()
                end
            },
            openBrowser = {
                order = 4,
                type = "execute",
                name = L["OPTION_OPEN_MESSAGE_BROWSER"],
                func = function(info)
                    MessageClassifierBrowser:Show()
                end
            },
            ruleSetsTitle = {
                order = 5,
                type = "header",
                name = L["OPTION_RULE_SETS_TITLE"],
            },
            ruleSets = {
                order = 10,
                type = "group",
                inline = true,
                name = L["OPTION_RULE_SETS"],
                args = {
                    actionBar = {
                        order = 0, -- at the top
                        type = "group",
                        inline = true,
                        name = "",
                        args = {
                            enabledAll = {
                                order = 1,
                                type = "toggle",
                                name = L["OPTION_SELECT_ALL"],
                                width = 0.5,
                                get = function(info)
                                    local ruleSets = MessageClassifierConfig.classificationRules
                                    for _, rule in ipairs(ruleSets) do
                                        if rule.enabled == false then
                                            return false
                                        end
                                    end
                                    return true                                    
                                end,
                                set = function(info, val)
                                    local ruleSets = MessageClassifierConfig.classificationRules
                                    for _, rule in ipairs(ruleSets) do
                                        rule.enabled = val
                                    end
                                    MessageClassifierBrowser:updateAllMessages()
                                end,
                            },
                            hideFromChatWindowAll = {
                                order = 2,
                                type = "toggle",
                                name = L["OPTION_SELECT_ALL"],
                                width = 1.5,
                                get = function(info)
                                    local ruleSets = MessageClassifierConfig.classificationRules
                                    for _, rule in ipairs(ruleSets) do
                                        if rule.hideFromChatWindow ~= true then
                                            return false
                                        end
                                    end
                                    return true                                    
                                end,
                                set = function(info, val)
                                    local ruleSets = MessageClassifierConfig.classificationRules
                                    for _, rule in ipairs(ruleSets) do
                                        rule.hideFromChatWindow = val
                                    end
                                    MessageClassifierBrowser:updateAllMessages()
                                end,
                            },
                            bottomLine = {
                                order = 99,
                                type = "header",
                                name = "",
                            },
                        }
                    },
                    addRuleSet = {
                        order = 999999, -- at the end
                        type = "execute",
                        name = L["OPTION_ADD"],
                        func = function(info)
                            MessageClassifierConfigFrame:addRuleSet()
                        end
                    },
                },
            },
            defaultRuleSets = {
                order = 20,
                type = "group",
                inline = true,
                name = L["OPTION_DEFAULT_RULE_SETS"],
                args = {
                    actionBar = {
                        order = 0, -- at the top
                        type = "group",
                        inline = true,
                        name = "",
                        args = {
                            enabledAll = {
                                order = 1,
                                type = "toggle",
                                name = L["OPTION_SELECT_ALL"],
                                width = 0.5,
                                get = function(info)
                                    local ruleSets = MessageClassifierDefaultRules
                                    for _, rule in ipairs(ruleSets) do
                                        if MessageClassifierConfig.enabledDefaultRules[rule.id] == false then
                                            return false
                                        end
                                    end
                                    return true                                    
                                end,
                                set = function(info, val)
                                    local ruleSets = MessageClassifierDefaultRules
                                    for _, rule in ipairs(ruleSets) do
                                        MessageClassifierConfig.enabledDefaultRules[rule.id] = val
                                    end
                                    MessageClassifierBrowser:updateAllMessages()
                                end,
                            },
                            hideFromChatWindowAll = {
                                order = 2,
                                type = "toggle",
                                name = L["OPTION_SELECT_ALL"],
                                width = 1.5,
                                get = function(info)
                                    local ruleSets = MessageClassifierDefaultRules
                                    for _, rule in ipairs(ruleSets) do
                                        if MessageClassifierConfig.defRulHideFromChatWindow[rule.id] ~= true then
                                            return false
                                        end
                                    end
                                    return true                                    
                                end,
                                set = function(info, val)
                                    local ruleSets = MessageClassifierDefaultRules
                                    for _, rule in ipairs(ruleSets) do
                                        MessageClassifierConfig.defRulHideFromChatWindow[rule.id] = val
                                    end
                                    MessageClassifierBrowser:updateAllMessages()
                                end,
                            },
                            bottomLine = {
                                order = 99,
                                type = "header",
                                name = "",
                            },
                        }
                    },
                },
            }
        }
    }

    for k,v in pairs(MessageClassifierConfig.classificationRules) do
        self:addRuleSetToView(k, v)
    end

    for k,v in pairs(MessageClassifierDefaultRules) do
        self:addDefaultRuleSetToView(k, v)
    end


    self.registeredOptionsTable = AceConfigRegistry:RegisterOptionsTable(ADDON_NAME, self.configTable)
    self.blizOptions = AceConfigDialog:AddToBlizOptions(ADDON_NAME, L["CONFIG_PAGE_TITLE"])
end

function MessageClassifierConfigFrame:updateRuleSetView()
    self.configTable.args.ruleSets.args = {
        actionBar = self.configTable.args.ruleSets.args.actionBar,
        addRuleSet = self.configTable.args.ruleSets.args.addRuleSet,
    }
    for k,v in pairs(MessageClassifierConfig.classificationRules) do
        self:addRuleSetToView(k, v)
    end
    MessageClassifierBrowser:updateAllMessages()
end

function MessageClassifierConfigFrame:updateDefaultRuleSetView()
    self.configTable.args.defaultRuleSets.args = {}
    for k,v in pairs(MessageClassifierDefaultRules) do
        self:addDefaultRuleSetToView(k, v)
    end
end

function MessageClassifierConfigFrame:addRuleSet()
    local index = #MessageClassifierConfig.classificationRules + 1
    MessageClassifierConfig.classificationRules[index] = {
        conditions = {
            {
                operator = "contain",
                field = "content",
                value = "xxx",
            },
        },
        class = "xxx/{author}",
        tmp = true,
        enabled = false,
    }
    self:editRuleSet(index)
    --AceConfigRegistry:NotifyChange(ADDON_NAME)
end

function MessageClassifierConfigFrame:removeRuleSet(index)
    table.remove(MessageClassifierConfig.classificationRules, index)

    self.configTable.args.ruleSets.args = {
        actionBar = self.configTable.args.ruleSets.args.actionBar,
        addRuleSet = self.configTable.args.ruleSets.args.addRuleSet,
    }
    for k,v in pairs(MessageClassifierConfig.classificationRules) do
        self:addRuleSetToView(k, v)
    end
    MessageClassifierBrowser:updateAllMessages()
    --AceConfigRegistry:NotifyChange(ADDON_NAME)
end

function MessageClassifierConfigFrame:addRuleSetToView(index, ruleSet)
    local group = self.configTable.args.ruleSets
    local option = {
        type = "group",
        inline = true,
        order = index,
        name = "",
        args = {
            enabled = {
                order = 1,
                type = "toggle",
                name = L["OPTION_ENABLE"],
                width = 0.5,
                get = function(info)
                    return ruleSet.enabled ~= false
                end,
                set = function(info, val)
                    ruleSet.enabled = val
                    MessageClassifierBrowser:updateAllMessages()
                end,
            },
            hideFromChatWindow = {
                order = 2,
                type = "toggle",
                name = L["OPTION_HIDE_FROM_CHAT_WINDOW"],
                width = 1.5,
                get = function(info)
                    return ruleSet.hideFromChatWindow == true
                end,
                set = function(info, val)
                    ruleSet.hideFromChatWindow = val
                    MessageClassifierBrowser:updateAllMessages()
                end,
            },
            editRuleSet = {
                order = 3,
                type = "execute",
                name = L["OPTION_EDIT"],
                width = 0.5,
                func = function(info)
                    MessageClassifierConfigFrame:editRuleSet(index)
                end
            },
            removeRuleSet = {
                order = 4,
                type = "execute",
                name = L["OPTION_REMOVE"],
                width = 0.5,
                func = function(info)
                    MessageClassifierConfigFrame:removeRuleSet(index)
                end
            },
            conditions = {
                order = 11,
                type = "description",
                name = ruleToText(ruleSet),
                width = "full",
            },
            bottomLine = {
                order = 99,
                type = "header",
                name = "",
            },
        }
    }
    group.args[tostring(index)] = option
end

function MessageClassifierConfigFrame:editRuleSet(index)
    local group = self.configTable.args.ruleSets
    local ruleSet = MessageClassifierConfig.classificationRules[index]

    if self.ruleEditCache[index] == nil then
        self.ruleEditCache[index] = deepCopy(ruleSet)
    end

    local cache = self.ruleEditCache[index]
    if cache.tmp then
        cache.enabled = nil
    end

    local option = {
        type = "group",
        inline = true,
        order = index,
        name = "",
        args = {
            enabled = {
                order = 1,
                type = "toggle",
                name = L["OPTION_ENABLE"],
                width = 0.5,
                get = function(info)
                    return cache.enabled ~= false
                end,
                set = function(info, val)
                    cache.enabled = val
                    MessageClassifierBrowser:updateAllMessages()
                end,
            },
            hideFromChatWindow = {
                order = 2,
                type = "toggle",
                name = L["OPTION_HIDE_FROM_CHAT_WINDOW"],
                width = 1.5,
                get = function(info)
                    return cache.hideFromChatWindow == true
                end,
                set = function(info, val)
                    cache.hideFromChatWindow = val
                    MessageClassifierBrowser:updateAllMessages()
                end,
            },
            saveRuleSet = {
                order = 3,
                type = "execute",
                name = L["OPTION_SAVE"],
                width = 0.5,
                func = function(info)
                    MessageClassifierConfigFrame:saveRuleSet(index)
                end
            },
            cancelEditRuleSet = {
                order = 3,
                type = "execute",
                name = L["OPTION_CANCEL"],
                width = 0.5,
                func = function(info)
                    MessageClassifierConfigFrame:cancelEditRuleSet(index)
                end
            },
            logic = {
                order = 10,
                type = "select",
                width = 2,
                name = L["OPTION_CONDITIONS"],
                values = {
                    ["or"] = L["OPTION_RULE_LOGIC_OR"],
                    ["and"] = L["OPTION_RULE_LOGIC_AND"],
                },
                get = function(info)
                    return cache.logic == "and" and "and" or "or"
                end,
                set = function(info, val)
                    cache.logic = val
                end
            },
            conditions = {
                order = 11,
                type = "group",
                inline = true,
                name = "",
                args = {
                    actionBar = {
                        order = 999999, -- at the end
                        type = "group",
                        inline = true,
                        name = "",
                        args = {
                            addCondition = {
                                order = 1,
                                type = "execute",
                                name = L["OPTION_ADD"],
                                width = 0.5,
                                func = function(info)
                                    MessageClassifierConfigFrame:addCondition(index)
                                end
                            },
                        }
                    }
                }
            },
            class = {
                order = 21,
                type = "input",
                name = L["OPTION_CLASS_EDIT_TITLE"],
                width = "full",
                get = function(info)
                    return localizeClassPath(cache.class)
                end,
                set = function(info, val)
                    cache.class = delocalizeClassPath(val)
                end,
            },
            bottomLine = {
                order = 99,
                type = "header",
                name = "",
            },
        }
    }

    for conditionIndex, condition in ipairs(cache.conditions) do
        self:addConditionToView(index, conditionIndex, condition, option.args.conditions)
    end
    
    group.args[tostring(index)] = option
end

function MessageClassifierConfigFrame:addCondition(ruleSetIndex)
    local group = self.configTable.args.ruleSets.args[tostring(ruleSetIndex)].args.conditions
    local conditions = self.ruleEditCache[ruleSetIndex].conditions
    local index = #conditions + 1

    conditions[index] = {
        operator = "contain",
        field = "content",
        value = "xxx",
    }

    self:addConditionToView(ruleSetIndex, index, conditions[index], group)
end

function MessageClassifierConfigFrame:removeCondition(ruleSetIndex, index)
    local group = self.configTable.args.ruleSets.args[tostring(ruleSetIndex)].args.conditions
    local conditions = self.ruleEditCache[ruleSetIndex].conditions
    
    table.remove(conditions, index)

    local actionBar = group.args.actionBar
    group.args = {
        actionBar = actionBar
    }

    for i, v in ipairs(conditions) do
        self:addConditionToView(ruleSetIndex, i, v, group)
    end
end

function MessageClassifierConfigFrame:addConditionToView(ruleSetIndex, index, condition, group)
    local option = {
        type = "group",
        inline = true,
        order = index,
        name = "",
        args = {
            field = {
                order = 11,
                type = "select",
                width = 0.7,
                name = "",
                values = {
                    ["author"] = L["author"],
                    ["channel"] = L["channel"],
                    ["content"] = L["content"],
                },
                get = function(info)
                    return condition.field
                end,
                set = function(info, val)
                    condition.field = val
                end
            },
            operator = {
                order = 12,
                type = "select",
                width = 0.8,
                name = "",
                values = {
                    ["equal"] = L["equal"],
                    ["not equal"] = L["not equal"],
                    ["contain"] = L["contain"],
                    ["not contain"] = L["not contain"],
                    ["match"] = L["match"],
                    ["not match"] = L["not match"],
                },
                get = function(info)
                    return condition.operator
                end,
                set = function(info, val)
                    condition.operator = val
                end
            },
            value = {
                order = 13,
                type = "input",
                width = 1.67,
                name = "",
                get = function(info)
                    return condition.value
                end,
                set = function(info, val)
                    condition.value = val
                end
            },
            actionBar = {
                order = 30,
                type = "group",
                inline = true,
                name = "",
                args = {
                    caseSensitive = {
                        order = 1,
                        type = "toggle",
                        name = L["OPTION_COND_CASESENSITIVE"],
                        get = function(info)
                            return condition.caseSensitive == true
                        end,
                        set = function(info, val)
                            condition.caseSensitive = val
                        end,
                    },
                    removeCondition = {
                        order = 2,
                        type = "execute",
                        name = L["OPTION_REMOVE"],
                        width = 0.5,
                        func = function(info)
                            MessageClassifierConfigFrame:removeCondition(ruleSetIndex, index)
                        end
                    },
                }
            },
            bottomLine = {
                order = 99,
                type = "header",
                name = "",
            },
        }
    }
    group.args[tostring(index)] = option
end

function MessageClassifierConfigFrame:cancelEditRuleSet(index)
    local tmp = self.ruleEditCache[index].tmp
    self.ruleEditCache[index] = nil
    if tmp then
       self:removeRuleSet(index) 
    else
        self:addRuleSetToView(index, MessageClassifierConfig.classificationRules[index])
    end
end

function MessageClassifierConfigFrame:saveRuleSet(index)
    if self.ruleEditCache[index].tmp then
        self.ruleEditCache[index].tmp = nil
    end
    MessageClassifierConfig.classificationRules[index] = self.ruleEditCache[index]
    self.ruleEditCache[index] = nil
    self:addRuleSetToView(index, MessageClassifierConfig.classificationRules[index])
    MessageClassifierBrowser:updateAllMessages()
end

function MessageClassifierConfigFrame:addDefaultRuleSetToView(index, ruleSet)
    local group = self.configTable.args.defaultRuleSets
    local option = {
        type = "group",
        inline = true,
        order = index,
        name = "",
        args = {
            enabled = {
                order = 1,
                type = "toggle",
                name = L["OPTION_ENABLE"],
                width = 0.5,
                get = function(info)
                    return MessageClassifierConfig.enabledDefaultRules[ruleSet.id] ~= false
                end,
                set = function(info, val)
                    MessageClassifierConfig.enabledDefaultRules[ruleSet.id] = val
                    MessageClassifierBrowser:updateAllMessages()
                end,
            },
            hideFromChatWindow = {
                order = 2,
                type = "toggle",
                name = L["OPTION_HIDE_FROM_CHAT_WINDOW"],
                width = 1.5,
                get = function(info)
                    return MessageClassifierConfig.defRulHideFromChatWindow[ruleSet.id] == true
                end,
                set = function(info, val)
                    MessageClassifierConfig.defRulHideFromChatWindow[ruleSet.id] = val
                    MessageClassifierBrowser:updateAllMessages()
                end,
            },
            conditions = {
                order = 11,
                type = "description",
                name = ruleToText(ruleSet),
            },
            bottomLine = {
                order = 99,
                type = "header",
                name = "",
            },
        }
    }
    group.args[tostring(index)] = option
end

MessageClassifierConfigFrame:RegisterEvent("ADDON_LOADED")
MessageClassifierConfigFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == ADDON_NAME then
        self:loadConfig()
    end
    self:UnregisterEvent("ADDON_LOADED")
end)
