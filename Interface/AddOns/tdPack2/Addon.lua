-- Addon.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/30/2019, 11:36:34 PM
--
local assert, wipe = assert, table.wipe or wipe
local pairs = pairs

local CopyTable = CopyTable

---@type ns
local ADDON, ns = ...

---@class Addon: AceAddon-3.0, LibClass-2.0, AceEvent-3.0
local Addon = LibStub('AceAddon-3.0'):NewAddon(ADDON, 'LibClass-2.0', 'AceEvent-3.0', 'AceConsole-3.0')

ns.Addon = Addon
ns.L = LibStub('AceLocale-3.0'):GetLocale(ADDON)
ns.ICON = [[Interface\AddOns\tdPack2\Resource\INV_Pet_Broom]]
ns.UNKNOWN_ICON = 134400

local L = ns.L

function Addon:OnInitialize()
    local defaults = {
        profile = {
            reverse = false,
            console = true,
            stackTogether = true,
            -- 老虎会游泳：防止背包内物品意外保存到银行
            stackBankFull = false,
            applyLibItemSearch = false,
            ruleOptionWindow = {point = 'CENTER', width = 637, height = 637},
            actions = {
                [ns.COMMAND.BAG] = {
                    [ns.CLICK_TOKENS.LEFT] = 'SORT_BAG',
                    [ns.CLICK_TOKENS.RIGHT] = 'OPEN_RULE_OPTIONS',
                    [ns.CLICK_TOKENS.CONTROL_LEFT] = 'SORT',
                    [ns.CLICK_TOKENS.CONTROL_RIGHT] = 'OPEN_OPTIONS',
                    -- 老虎会游泳：防止背包内物品意外保存到银行
                    --[ns.CLICK_TOKENS.SHIFT_LEFT] = 'SAVE',
                },
                [ns.COMMAND.BANK] = {
                    [ns.CLICK_TOKENS.LEFT] = 'SORT_BANK',
                    [ns.CLICK_TOKENS.RIGHT] = 'OPEN_RULE_OPTIONS',
                    [ns.CLICK_TOKENS.CONTROL_LEFT] = 'SORT',
                    [ns.CLICK_TOKENS.CONTROL_RIGHT] = 'OPEN_OPTIONS',
                    -- 老虎会游泳：防止背包内物品意外保存到银行
                    --[ns.CLICK_TOKENS.SHIFT_LEFT] = 'SAVE',
                },
            },
            rules = {},
        },
    }

    self.defaultRules = {
        sorting = ns.DEFAULT_SORTING_RULES, --
        saving = ns.DEFAULT_SAVING_RULES, --
    }

    self.db = LibStub('AceDB-3.0'):New('TDDB_PACK2', defaults, true)

    local function SetupProfile()
        self:SetupProfile()
    end

    local function CleanRules()
        self:CleanRules()
    end

    self.db:RegisterCallback('OnProfileChanged', SetupProfile)
    self.db:RegisterCallback('OnProfileReset', SetupProfile)
    self.db:RegisterCallback('OnProfileShutdown', CleanRules)
    self.db:RegisterCallback('OnDatabaseShutdown', CleanRules)
end

function Addon:OnEnable()
    self:InitOptionFrame()
    self:InitCommands()
    self:SetupProfile()
end

function Addon:SetupProfile()
    self.db.profile.firstLoad = nil
    self:UpgradeRules()
    self:SetupRules()
    self:SendMessage('TDPACK_PROFILE_CHANGED')
end

function Addon:SetupRules()
    local profile = self.db.profile.rules
    for key, rules in pairs(self.defaultRules) do
        if not profile[key] then
            profile[key] = CopyTable(rules)
        end
    end
end

local function compare(lhs, rhs)
    if type(lhs) ~= type(rhs) then
        return false
    end
    if type(lhs) ~= 'table' then
        return false
    end
    return tCompare(lhs, rhs, 10)
end

function Addon:CleanRules()
    local profile = self.db.profile.rules
    for key, rules in pairs(self.defaultRules) do
        if compare(rules, profile[key]) then
            profile[key] = nil
        end
    end
end

function Addon:UpgradeRules()
    if self.db.profile.version then
        if self.db.profile.version < 20000 then
    wipe(self.db.profile.rules)
    self:Print(L['Rules restore to default.'])
        elseif self.db.profile.version < 20004 then

            if self.db.profile.rules.saving or self.db.profile.rules.sorting then
                if not StaticPopupDialogs['TDPACK2_UPDATE_RULES'] then
                    StaticPopupDialogs['TDPACK2_UPDATE_RULES'] = {
                        button1 = ACCEPT,
                        button2 = CANCEL,
                        text = L.UPDATE_RULES_CONFIRM,
                        OnAccept = function()
                            self:ResetRules(ns.SORT_TYPE.SORTING)
                            self:ResetRules(ns.SORT_TYPE.SAVING)
                        end,
                        preferredIndex = STATICPOPUP_NUMDIALOGS,
                    }
                end

                StaticPopup_Show('TDPACK2_UPDATE_RULES')
            end
        end
    end
    self.db.profile.version = ns.VERSION
end

function Addon:OnModuleCreated(module)
    local name = module:GetName()
    assert(not ns[name])
    ns[name] = module
end

function Addon:OnClassCreated(class, name)
    assert(not ns[name])
    ns[name] = class
end

function Addon:GetBagClickOption(bagType, token)
    return self.db.profile.actions[bagType][token] or nil
end

function Addon:SetBagClickOption(bagType, token, action)
    self.db.profile.actions[bagType][token] = action
end

function Addon:ResetRules(sortType)
    if sortType == ns.SORT_TYPE.SORTING then
        ns.CopyFrom(wipe(self.db.profile.rules.sorting), ns.DEFAULT_SORTING_RULES)
        self:SendMessage('TDPACK_SORTING_RULES_UPDATE')
    elseif sortType == ns.SORT_TYPE.SAVING then
        ns.CopyFrom(wipe(self.db.profile.rules.saving), ns.DEFAULT_SAVING_RULES)
        self:SendMessage('TDPACK_SAVING_RULES_UPDATE')
    end
end

function Addon:GetRules(sortType)
    if sortType == ns.SORT_TYPE.SORTING then
        return self.db.profile.rules.sorting
    elseif sortType == ns.SORT_TYPE.SAVING then
        return self.db.profile.rules.saving
    else
        assert(false)
    end
end

function Addon:GetOption(key)
    return self.db.profile[key]
end

function Addon:SetOption(key, value)
    self.db.profile[key] = value
    self:SendMessage('TDPACK_OPTION_CHANGED_' .. key, key, value)
end
