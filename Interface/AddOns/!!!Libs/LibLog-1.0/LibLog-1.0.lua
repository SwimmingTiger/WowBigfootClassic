-- LibLog-1.0.lua
-- @Author : DengSir (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/18/2018, 9:12:24 PM

local MAJOR,MINOR = "LibLog-1.0", 1
local Log, oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if not Log then return end

Log.embeds = Log.embeds or {}

local Console
local LogMessage

local function LogMessage2(level, depth, ...)
    return Console:Log(level, depth, ...)
end

local function LogMessage(level, depth, ...)
    if tdDevToolsFrame and tdDevToolsFrame.Console then
        Console = tdDevToolsFrame.Console
        LogMessage = LogMessage2
        return LogMessage2(level, depth + 1, ...)
    end
end

local Logger = {}

function Logger:Debug(...)
    return LogMessage('DEBUG', 2, ...)
end

function Logger:Info(...)
    return LogMessage('INFO', 2, ...)
end

function Logger:Warn(...)
    return LogMessage('WARN', 2, ...)
end

function Logger:Error(...)
    return LogMessage('ERROR', 2, ...)
end

function Log:GetLogger()
    return Mixin({}, Logger)
end

local mixins = {
    LogDebug = 'Debug',
    LogInfo  = 'Info',
    LogWarn  = 'Warn',
    LogError = 'Error',
}

function Log:Embed(target)
    for k, v in pairs(mixins) do
        target[k] = Logger[v]
    end
    Log.embeds[target] = true
    return target
end
