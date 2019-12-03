-- Addon.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/30/2019, 11:36:34 PM

local select, assert, unpack, wipe = select, assert, table.unpack or unpack, table.wipe or wipe
local pairs = pairs
local CopyTable, tInvert = CopyTable, tInvert

---@type ns
local ADDON, ns = ...
local Addon = LibStub('AceAddon-3.0'):NewAddon(ADDON, 'LibClass-2.0', 'AceEvent-3.0', 'AceConsole-3.0')

ns.Addon = Addon
ns.L = LibStub('AceLocale-3.0'):GetLocale(ADDON)
ns.ICON = [[Interface\AddOns\tdPack2\Resource\INV_Pet_Broom]]
ns.IsRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
ns.UNKNOWN_ICON = 134400
ns.GUI = LibStub('tdGUI-1.0')

function Addon:OnInitialize()
    local defaults = {
        profile = {
            reverse = false,
            console = true,
            applyLibItemSearch = false,
            ruleOptionWindow = {point = 'CENTER', width = 637, height = 637},
            actions = {
                [ns.COMMAND.BAG] = {
                    [ns.CLICK_TOKENS.LEFT] = 'SORT',
                    [ns.CLICK_TOKENS.RIGHT] = 'OPEN_RULE_OPTIONS',
                    [ns.CLICK_TOKENS.CONTROL_LEFT] = 'SORT_BAG',
                    [ns.CLICK_TOKENS.CONTROL_RIGHT] = 'OPEN_OPTIONS',
                    [ns.CLICK_TOKENS.SHIFT_LEFT] = 'SAVE',
                },
                [ns.COMMAND.BANK] = {
                    [ns.CLICK_TOKENS.LEFT] = 'SORT',
                    [ns.CLICK_TOKENS.RIGHT] = 'OPEN_RULE_OPTIONS',
                    [ns.CLICK_TOKENS.CONTROL_LEFT] = 'SORT_BANK',
                    [ns.CLICK_TOKENS.CONTROL_RIGHT] = 'OPEN_OPTIONS',
                    [ns.CLICK_TOKENS.SHIFT_LEFT] = 'SAVE',
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

    self.db:RegisterCallback('OnProfileChanged', function()
        self:OnProfileChanged()
    end)
end

function Addon:OnEnable()
    self:InitOptionFrame()
    self:InitCommands()
    self:OnProfileChanged()
end

function Addon:OnProfileChanged()
    self.db.profile.firstLoad = nil
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
