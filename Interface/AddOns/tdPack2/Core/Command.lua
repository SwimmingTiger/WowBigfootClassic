-- Command.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/27/2019, 10:59:50 PM

---- LUA
local unpack, select = unpack, select
local tInvert = tInvert

---@type ns
local ns = select(2, ...)

---- NS
local Addon = ns.Addon
local Pack = ns.Pack
local BAG_TYPE = ns.BAG_TYPE
local COMMAND = ns.COMMAND
local EXTRA_COMMAND = ns.EXTRA_COMMAND
local ORDER = ns.ORDER

---- LOCAL
local COMMAND_KEYS = tInvert{COMMAND.ALL, COMMAND.BAG, COMMAND.BANK}
local ORDER_KEYS = tInvert{ORDER.ASC, ORDER.DESC}
local EXTRA_COMMANDS_KEYS = tInvert{EXTRA_COMMAND.SAVE}

function Addon:InitCommands()
    self:RegisterChatCommand('tdp', 'OnChatSlash')

    local function optTrue()
        return true
    end

    local function optFalse()
        return false
    end

    self.optOrders = {
        [ORDER.ASC] = optFalse,
        [ORDER.DESC] = optTrue,
        AUTO = function()
            return self:GetOption('reverse')
        end,
    }

    self.optSavings = {
        [EXTRA_COMMAND.SAVE] = optTrue,
        AUTO = function()
            return self:GetOption('saving')
        end,
    }

    self.commands = {
        SORT = self:Generate(),
        SORT_BAG = self:Generate(COMMAND.BAG),
        SORT_BAG_ASC = self:Generate(COMMAND.BAG, ORDER.ASC),
        SORT_BAG_DESC = self:Generate(COMMAND.BAG, ORDER.DESC),
        SORT_BANK = self:Generate(COMMAND.BANK),
        SORT_BANK_ASC = self:Generate(COMMAND.BANK, ORDER.ASC),
        SORT_BANK_DESC = self:Generate(COMMAND.BANK, ORDER.DESC),
        SORT_ASC = self:Generate(ORDER.ASC),
        SORT_DESC = self:Generate(ORDER.DESC),
        SAVE = self:Generate(EXTRA_COMMAND.SAVE),

        OPEN_RULE_OPTIONS = function()
            ns.UI.RuleOption:Show()
        end,
        OPEN_OPTIONS = function()
            self:OpenOption()
        end,
    }
end

function Addon:OnChatSlash(text)
    local args = {}
    local cmd, offset
    while true do
        cmd, offset = self:GetArgs(text, nil, offset)
        if not cmd then
            break
        end

        tinsert(args, cmd)
    end

    Pack:Start(self:ParseArgs(unpack(args)))
end

function Addon:ParseArgs(...)
    local command, order, extra
    local opts = {}

    for i = 1, select('#', ...) do
        local cmd = tostring(select(i, ...)):lower()
        if COMMAND_KEYS[cmd] then
            command = cmd
        end
        if ORDER_KEYS[cmd] then
            order = cmd
        end
        if EXTRA_COMMANDS_KEYS[cmd] then
            extra = cmd
        end
    end

    if not command and not extra then
        command = COMMAND.ALL
    end

    if command == COMMAND.ALL then
        opts[BAG_TYPE.BANK] = true
        opts[BAG_TYPE.BAG] = true
    elseif command == COMMAND.BAG then
        opts[BAG_TYPE.BAG] = true
    elseif command == COMMAND.BANK then
        opts[BAG_TYPE.BANK] = true
    end

    if not order then
        opts.reverse = self.optOrders.AUTO
    else
        opts.reverse = self.optOrders[order]
    end

    if not extra then
        opts.save = self.optSavings.AUTO
    else
        opts.save = self.optSavings[extra]
    end

    return opts
end

function Addon:Pack(...)
    Pack:Start(self:ParseArgs(...))
end

function Addon:Generate(...)
    local opts = Addon:ParseArgs(...)
    return function()
        Pack:Start(opts)
    end
end

function Addon:RunCommand(bagType, token)
    local command = self:GetBagClickOption(bagType, token)
    if not command then
        return
    end
    local func = self.commands[command]
    if func then
        func()
    end
end
