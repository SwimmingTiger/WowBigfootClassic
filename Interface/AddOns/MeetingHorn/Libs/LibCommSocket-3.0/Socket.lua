
local MAJOR, MINOR = 'LibCommSocket-3.0', 2

---@class NSSocket
---@field contexts table<string, NSSocketContext>
local Lib = LibStub:NewLibrary(MAJOR, MINOR)
if not Lib then
    return
end

local AceSerializer = LibStub('AceSerializer-3.0')
local CallbackHandler = LibStub('CallbackHandler-1.0')

local SERVER_METHODS = {'RegisterServer', 'UnregisterServer', 'UnregisterAllServer'}
local SOCKET_METHODS = {'RegisterSocket', 'UnregisterSocket', 'UnregisterAllSocket'}

---@class NSSocketContext
---@field connectKey string
---@field prefix string
---@field timer any
---@field status number
---@field target string
---@field rawTarget string

Lib.comm = LibStub('AceComm-3.0'):Embed(Lib.comm or {})
Lib.contexts = Lib.contexts or {}
Lib.prefixes = Lib.prefixes or {}

Lib.servers = setmetatable(Lib.servers or {}, {
    __index = function(t, prefix)
        t[prefix] = {}
        t[prefix].Fire = CallbackHandler:New(t[prefix], unpack(SERVER_METHODS)).Fire
        return t[prefix]
    end,
})
Lib.sockets = setmetatable(Lib.sockets or {}, {
    __index = function(t, prefix)
        t[prefix] = {}
        t[prefix].Fire = CallbackHandler:New(t[prefix], unpack(SOCKET_METHODS)).Fire
        return t[prefix]
    end,
})

local comm = Lib.comm
local servers = Lib.servers
local sockets = Lib.sockets
local contexts = Lib.contexts
local prefixes = Lib.prefixes

local error = error
local ipairs = ipairs
local tostring = tostring
local random = fastrandom or math.random

local SOCKET_NORMAL = 1
local SOCKET_CONNECT = 2
local SOCKET_READY = 3

local SOCKET_BASE_CMD = {COMMSOCKET_CONNECT_SUCCESS = true, COMMSOCKET_CHANNEL_OWNER = true}

local NOT_FOUND_MATCH = ERR_CHAT_PLAYER_NOT_FOUND_S:format('(.+)')

local function getContextByPrefix(prefix)
    if not prefix then
        return
    end
    if not contexts[prefix] then
        local ctx = {status = SOCKET_NORMAL, prefix = prefix}
        contexts[prefix] = ctx
    end
    return contexts[prefix]
end

local function getContext(self)
    return getContextByPrefix(prefixes[self])
end

function comm:OnComm(prefix, text, distribution, sender)
    return self:Packet(prefix, distribution, sender, AceSerializer:Deserialize(text))
end

function comm:IsServer(prefix, sender)
    local ctx = getContextByPrefix(prefix)
    return ctx.target == sender
end

function comm:PreServer(prefix, cmd, distribution, sender, ...)
    if distribution ~= 'WHISPER' then
        return
    end
    if cmd == 'COMMSOCKET_CONNECT_SUCCESS' then
        local key = ...
        local ctx = getContextByPrefix(prefix)
        if ctx.connectKey and ctx.connectKey == key then
            ctx.timer:Cancel()
            ctx.timer = nil
            ctx.connectKey = nil
            ctx.status = SOCKET_READY
            ctx.target = Ambiguate(sender, 'none')
            servers[prefix]:Fire('SERVER_CONNECTED')
        end
    elseif cmd == 'COMMSOCKET_CHANNEL_OWNER' then
        if self:IsServer(prefix, sender) then
            SetChannelOwner(..., sender)
        end
    end
end

function comm:Packet(prefix, distribution, sender, ok, cmd, ...)
    if not ok then
        return
    end

    sender = Ambiguate(sender, 'none')

    if SOCKET_BASE_CMD[cmd] then
        return self:PreServer(prefix, cmd, distribution, sender, ...)
    end

    if self:IsServer(prefix, sender) then
        return servers[prefix]:Fire(cmd, ...)
    else
        return sockets[prefix]:Fire(cmd, sender, distribution, ...)
    end
end

function Lib:ListenSocket(prefix)
    if prefixes[self] then
        error('Listened prefix', 2)
    end
    prefixes[self] = prefix
    comm:RegisterComm(prefix, 'OnComm')

    for i, method in ipairs(SERVER_METHODS) do
        self[method] = servers[prefix][method]
    end

    for i, method in ipairs(SOCKET_METHODS) do
        self[method] = sockets[prefix][method]
    end

    self.SendSocket = Lib.SendSocket
    self.SendServer = Lib.SendServer
end

function Lib:ConnectServer(target)
    if not prefixes[self] then
        error('Not found prefix', 2)
    end

    local ctx = getContext(self)
    if ctx.status ~= SOCKET_NORMAL then
        return
    end

    ctx.rawTarget = target
    ctx.connectKey = tostring(random(0x100000, 0xFFFFFF))
    ctx.timer = C_Timer.NewTicker(30, function()
        return self:SendServer('COMMSOCKET_CONNECT', ctx.connectKey)
    end)
end

function Lib:SendSocket(cmd, sender, distribution, ...)
    return comm:SendCommMessage(Lib.prefixes[self], AceSerializer:Serialize(cmd, ...), distribution, sender)
end

function Lib:SendServer(cmd, ...)
    local ctx = getContext(self)
    return self:SendSocket(cmd, ctx.rawTarget or ctx.target, 'WHISPER', ...)
end

function Lib:Embed(target)
    target.ListenSocket = self.ListenSocket
    target.ConnectServer = self.ConnectServer
    return target
end

do
    local chatFilter = function(_, _, msg)
        local name = msg:match(NOT_FOUND_MATCH)
        if not name then
            return
        end

        name = Ambiguate(name, 'none')

        for _, ctx in pairs(contexts) do
            if name == ctx.target or name == ctx.rawTarget then
                return true
            end
        end
    end

    if Lib.chatFilter then
        ChatFrame_RemoveMessageEventFilter('CHAT_MSG_SYSTEM', Lib.chatFilter)
    end
    ChatFrame_AddMessageEventFilter('CHAT_MSG_SYSTEM', chatFilter)
    Lib.chatFilter = chatFilter
end
