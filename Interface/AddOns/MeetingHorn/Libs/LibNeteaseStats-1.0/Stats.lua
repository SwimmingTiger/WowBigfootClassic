-- Stats.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 4/29/2021, 2:18:21 PM
--
local LibClass = LibStub('LibClass-2.0')
local LibCommSocket = LibStub('LibCommSocket-3.0')

local MAJOR, MINOR = 'LibNeteaseStats-1.0', 1
local Lib = LibStub:NewLibrary(MAJOR, MINOR)
if not Lib then
    return
end

---@class NeteaseStats: Object, NSSocket
local Stats = LibClass:New()
LibCommSocket:Embed(Stats)

function Stats:Constructor(addonName)
    assert(addonName)
    self.addonName = addonName
    self.queue = {}
    self.sended = {}

    self:ListenSocket('NeteaseStats')
    self:ConnectServer('S1' .. UnitFactionGroup('player'))
    self:RegisterServer('SERVER_CONNECTED')
end

function Stats:SERVER_CONNECTED()
    self.connected = true

    for _, v in ipairs(self.queue) do
        self:SendForce(v.event, v.arg1, v.arg2)
    end
end

function Stats:Send(event, arg1, arg2)
    local key = table.concat({tostringall(event, arg1, arg2)}, '\1')
    if self.sended[key] then
        return
    end
    self.sended[key] = true
    self:SendForce(event, arg1, arg2)
end

function Stats:SendForce(event, arg1, arg2)
    if self.connected then
        self:SendServer('NECS', self.addonName, event, MINOR, UnitGUID('player'), select(2, BNGetInfo()), arg1, arg2)
    else
        tinsert(self.queue, {event = event, arg1 = arg1, arg2 = arg2})
    end
end

---@return NeteaseStats
function Lib:New(...)
    return Stats:New(...)
end
