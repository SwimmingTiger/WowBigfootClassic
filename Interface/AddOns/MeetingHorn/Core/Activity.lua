
---@type ns
local ns = select(2, ...)

local L = ns.L

local ADDON_TAG = ns.ADDON_TAG
local PATTERNS = { --
    ['^' .. ADDON_TAG .. '(.+)$'] = 1,
    ['^(.+)' .. ADDON_TAG .. '$'] = 2,
    ['^(.+)@@'] = 3,
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
---@field private lineId number
---@field private members number
---@field private leaderLevel number
local Activity = ns.Addon:NewClass('Activity')

function Activity:Constructor(id, modeId, comment)
    if id then
        self:SetActivityId(id)
    end
    self.modeId = modeId
    self:SetComment(comment or '')
end

---@return MeetingHornActivity
function Activity:FromProto(proto, leader, guid, channelName, lineId)
    local activity = Activity:New()
    if activity:Update(proto, leader, guid, channelName, lineId) then
        return activity
    end
end

function Activity:Update(proto, leader, guid, channelName, lineId)
    local version, body = ParseProto(proto)
    local id, modeId, comment, name, mode, members, leaderLevel
    if version == 1 then
        name, mode, comment = body:match('^([^.]+)%.([^.]+)%.%.%.%.%.%.%.%.(.+)$')
    elseif version == 2 then
        name, comment, mode = body:match('^([^.]+)%.([^.]+)%.%.%.%.%.%.%.%.(.+)$')
    elseif version == 3 then
        name, comment, members, leaderLevel, mode = body:match('^([^.]+)%.([^.]+)%.([^.]+)%.([^.]+)%.%.%.%.%.%.(.+)$')
    end

    if not name then
        return
    end

    id = ns.NameToId(name)
    modeId = ns.ModeToId(mode)
    if not id or not modeId then
        return
    end

    members = tonumber(members)
    leaderLevel = tonumber(leaderLevel)

    local data = ns.GetActivityData(id)
    if not data.category.channels[channelName] then
        return
    end

    self.modeId = modeId
    self:SetActivityId(id)
    self:SetLeaderGUID(guid)
    self:SetLeader(leader)
    self:SetLeaderLevel(leaderLevel)
    self:SetComment(comment)
    self:SetMembers(members)
    self:SetLineId(lineId)
    self:UpdateTick()
    return true
end

function Activity:ToProto()
    return format('%s.%s.%s.%s......%s', self:GetShortName(), self:GetComment(), ns.GetNumGroupMembers(),
                  UnitLevel('player'), self:GetMode()) .. '@@'
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
    local id = ns.Channel:GetSendChannelId(self:GetChannelName())
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

function Activity:SetMembers(members)
    self.members = members
end

function Activity:GetMembers()
    return self.members
end

function Activity:SetLeaderLevel(level)
    self.leaderLevel = level
end

function Activity:GetLeaderLevel()
    return self.leaderLevel
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
    if ns.Addon.db.profile.options.activityfilter and ns.LFG:IsFilter(self.commentLower) then
        return false
    end
    return true
end

function Activity:UpdateTick()
    self.tick = time()
end

function Activity:GetTick()
    return self.tick
end

function Activity:SetActivityId(id)
    self.id = id
    self.data = ns.GetActivityData(id)
end

function Activity:SetLineId(lineId)
    self.lineId = lineId
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

function Activity:GetLeaderPlayerLocation()
    if C_ChatInfo.IsValidChatLine(self.lineId) then
        return PlayerLocation:CreateFromChatLineID(self.lineId)
    else
        return PlayerLocation:CreateFromGUID(self.guid)
    end
end
