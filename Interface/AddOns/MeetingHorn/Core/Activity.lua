-- Activity.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https:..dengsir.github.io
-- @Date   : 12.11.2019, 9:45:00 AM

---@type ns
local ns = select(2, ...)

local L = ns.L

local ADDON_TAG = ns.ADDON_TAG
local PATTERNS = { --
    ['^' .. ADDON_TAG .. '(.+)$'] = 1,
    ['^(.+)' .. ADDON_TAG .. '$'] = 2,
}

local function ParseProto(text)
    for p, v in pairs(PATTERNS) do
        local body = text:match(p)
        if body and body:trim() ~= '' then
            return v, body
        end
    end
end

---@class MeetingHornActivity
---@field private leader string
---@field private leaderLower string
---@field private leaderClass string
---@field private guid string
---@field private id number
---@field private modeId number
---@field private comment string
---@field private commentLower string
---@field private channel string
---@field private tick number
---@field private data MeetingHornActivityData
---@field private start number
---@field private duration number
local Activity = ns.Addon:NewClass('Activity')

function Activity:Constructor(id, modeId, comment)
    if id then
        self:SetActivityId(id)
    end
    self.modeId = modeId
    self:SetComment(comment or '')
end

---@return MeetingHornActivity
function Activity:FromProto(proto, leader, guid, channelName)
    local activity = Activity:New()
    if activity:Update(proto, leader, guid, channelName) then
        return activity
    end
end

function Activity:Update(proto, leader, guid, channelName)
    local version, body = ParseProto(proto)
    local id, modeId, comment, name, mode
    if version == 1 then
        name, mode, comment = body:match('^([^.]+)%.([^.]+)%.%.%.%.%.%.%.%.(.+)$')
    elseif version == 2 then
        name, comment, mode = body:match('^([^.]+)%.([^.]+)%.%.%.%.%.%.%.%.(.+)$')
    end

    if not name then
        return
    end

    id = ns.NameToId(name)
    modeId = ns.ModeToId(mode)
    if not id or not modeId then
        return
    end

    local data = ns.GetActivityData(id)
    if channelName ~= data.category.channel then
        return
    end

    self.modeId = modeId
    self:SetActivityId(id)
    self:SetLeaderGUID(guid)
    self:SetLeader(leader)
    self:SetComment(comment)
    self:UpdateTick()
    return true
end

function Activity:ToProto()
    return format('%s.%s........%s', self:GetShortName(), self:GetComment(), self:GetMode()) .. ADDON_TAG
end

function Activity:GetMode()
    return ns.IdToMode(self.modeId) or ''
end

function Activity:GetModeId()
    return self.modeId
end

function Activity:GetLeader()
    return self.leader
end

function Activity:GetLeaderGUID()
    return self.guid
end

function Activity:GetLeaderClass()
    return self.leaderClass
end

function Activity:GetActivityId()
    return self.id
end

function Activity:GetName()
    return self.data.name
end

function Activity:GetTitle()
    if self:IsActivity() then
        return self.data.name
    else
        return format('%s(%s)', self.data.name, self.channel)
    end
end

function Activity:GetShortName()
    return self.data.shortName or self.data.name
end

function Activity:GetComment()
    return self.comment
end

function Activity:GetChannelName()
    return self.data.category.channel
end

function Activity:GetChannelId()
    local id = GetChannelName(self:GetChannelName())
    if id and id ~= 0 then
        return id
    end
end

function Activity:GetInterval()
    return self.data.category.interval
end

function Activity:GetPath()
    return self.data.path
end

function Activity:IsSelf()
    return self.leader == UnitName('player')
end

function Activity:IsTimeOut()
    return time() - self.tick > self.data.category.timeout
end

function Activity:IsActivity()
    return self.id ~= 0
end

local function Search(text, pattern)
    if not text then
        return false
    end
    return text:find(pattern, nil, true)
end

function Activity:Match(path, activityId, modeId, search)
    if path and path ~= self:GetPath() then
        return false
    end
    if activityId and activityId ~= self.id then
        return false
    end
    if modeId and modeId ~= self.modeId then
        return false
    end
    if search and (not Search(self.data.nameLower, search) and not Search(self.data.shortNameLower, search) and
        not Search(self.commentLower, search) and not Search(self.leaderLower, search)) then
        return false
    end
    return true
end

function Activity:UpdateTick()
    self.tick = time()
end

function Activity:SetActivityId(id)
    self.id = id
    self.data = ns.GetActivityData(id)
end

function Activity:SetLeaderGUID(guid)
    self.guid = guid
    self.leaderClass = guid and select(2, GetPlayerInfoByGUID(guid)) or 'PRIEST'
end

function Activity:SetLeader(leader)
    self.leader = Ambiguate(leader, 'none')
    self.leaderLower = self.leader:lower()
end

function Activity:SetComment(comment)
    self.comment = comment
    self.commentLower = comment:lower()
end

function Activity:SetChannelName(channel)
    self.channel = ns.ShortChannelName(channel)
end

function Activity:StartCooldown()
    self.start = time()
    self.duration = 60
end

function Activity:GetCooldown()
    if not self.start then
        return 0
    end
    return self.start + self.duration - time()
end

function Activity:ResetCooldown()
    self.start = nil
    self.duration = nil
end
