-- Option.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/2/2019, 12:35:41 PM

---@type ns
local ADDON, ns = ...
local Addon = ns.Addon
local L = ns.L

function Addon:InitOptionFrame()
    local index = 0
    local function orderGen()
        index = index + 1
        return index
    end

    local function toggle(text, disabled)
        return {type = 'toggle', name = text, width = 'full', order = orderGen(), disabled = disabled}
    end

    local function execute(text, ...)
        local confirm, func
        local t = type(...)
        if t == 'function' then
            func = ...
        else
            confirm, func = ...
        end

        return {
            type = 'execute',
            name = text,
            width = 'full',
            order = orderGen(),
            confirm = not not confirm,
            confirmText = confirm,
            func = func,
        }
    end

    local function drop(opts)
        local values = opts.values

        opts.values = {}
        opts.sorting = {}

        for i, v in ipairs(values) do
            opts.values[v.value] = v.name
            opts.sorting[i] = v.value
        end

        opts.type = 'select'
        opts.order = orderGen()

        return opts
    end

    local function generateButton(bagType, name)
        local g = {
            type = 'group',
            name = name,
            args = {},
            order = orderGen(),
            get = function(item)
                return Addon:GetBagClickOption(bagType, tonumber(item[#item]))
            end,
            set = function(item, value)
                Addon:SetBagClickOption(bagType, tonumber(item[#item]), value)
            end,
        }

        for _, v in ipairs(ns.CLICK_LIST) do
            g.args[tostring(v.token)] = drop{
                name = v.name,
                order = orderGen(),
                values = {
                    {name = L['None'], value = false}, --
                    {name = L.SORT, value = 'SORT'}, --
                    {name = L.SORT_ASC, value = 'SORT_ASC'}, --
                    {name = L.SORT_DESC, value = 'SORT_DESC'}, --
                    {name = L.SORT_BAG, value = 'SORT_BAG'}, --
                    {name = L.SORT_BAG_ASC, value = 'SORT_BAG_ASC'}, --
                    {name = L.SORT_BAG_DESC, value = 'SORT_BAG_DESC'}, --
                    {name = L.SORT_BANK, value = 'SORT_BANK'}, --
                    {name = L.SORT_BANK_ASC, value = 'SORT_BANK_ASC'}, --
                    {name = L.SORT_BANK_DESC, value = 'SORT_BANK_DESC'}, --
                    {name = L.SAVE, value = 'SAVE'}, --
                    {name = L.OPEN_RULE_OPTIONS, value = 'OPEN_RULE_OPTIONS'}, --
                    {name = L.OPEN_OPTIONS, value = 'OPEN_OPTIONS'}, --
                },
            }
        end

        return g
    end

    local charProfileKey = format('%s - %s', UnitName('player'), GetRealmName())

    local options = {
        type = 'group',
        name = ADDON,

        get = function(item)
            return self:GetOption(item[#item])
        end,
        set = function(item, value)
            self:SetOption(item[#item], value)
        end,

        args = {
            profile = {
                type = 'toggle',
                name = L['Character Specific Settings'],
                width = 'double',
                order = orderGen(),
                set = function(_, checked)
                    self.db:SetProfile(checked and charProfileKey or 'Default')
                end,
                get = function()
                    return self.db:GetCurrentProfile() == charProfileKey
                end,
            },
            reset = {
                type = 'execute',
                name = L['Restore default Settings'],
                order = orderGen(),
                confirm = true,
                confirmText = L['Are you sure you want to restore the current Settings?'],
                func = function()
                    self.db:ResetProfile()
                end,
            },
            line = {type = 'header', name = ''},
            general = {
                type = 'group',
                name = GENERAL,
                order = orderGen(),
                args = {
                    default = {
                        type = 'group',
                        name = L.SORT,
                        order = orderGen(),
                        inline = true,
                        args = { --
                            reverse = toggle(L['Reverse pack']),
                            saving = toggle(L['Save to bank when default packing']),
                            stackTogether = toggle(L['Bank and bag stacking together']),
                            stackBankFull = toggle(L['Keep bank items stack full'], function()
                                return not self:GetOption('stackTogether')
                            end),
                        },
                    },
                    global = {
                        type = 'group',
                        name = L['Global'],
                        order = orderGen(),
                        inline = true,
                        args = {
                            console = toggle(L['Enable chat message']),
                            resetSorting = execute(L['Reset sorting rules'],
                                                   L['Are you sure to |cffff1919RESET|r sorting rules?'], function()
                                Addon:ResetRules(ns.SORT_TYPE.SORTING)
                            end),
                            resetSaving = execute(L['Reset saving rules'],
                                                  L['Are you sure to |cffff1919RESET|r saving rules?'], function()
                                Addon:ResetRules(ns.SORT_TYPE.SAVING)
                            end),
                        },
                    },
                    help = {
                        type = 'group',
                        name = L['Help'],
                        order = orderGen(),
                        inline = true,
                        args = { --
                            applyLibItemSearch = toggle(L['Add extension filter to LibItemSearch-1.2']),
                        },
                    },
                },
            },
            [ns.BAG_TYPE.BAG] = generateButton(ns.BAG_TYPE.BAG, L['Bag button features']),
            [ns.BAG_TYPE.BANK] = generateButton(ns.BAG_TYPE.BANK, L['Bank button features']),
        },
    }

    local registry = LibStub('AceConfigRegistry-3.0')
    registry:RegisterOptionsTable(ADDON, options)

    local dialog = LibStub('AceConfigDialog-3.0')
    self.options = dialog:AddToBlizOptions(ADDON, ADDON)
end

local function OpenToCategory(options)
    InterfaceOptionsFrame_OpenToCategory(options)
    InterfaceOptionsFrame_OpenToCategory(options)
    OpenToCategory = InterfaceOptionsFrame_OpenToCategory
end

function Addon:OpenOption()
    OpenToCategory(self.options)
end
