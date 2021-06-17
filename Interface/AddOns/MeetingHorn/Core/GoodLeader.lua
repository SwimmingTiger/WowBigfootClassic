---@type ns
local ns = select(2, ...)

local L = ns.L

---@class GoodLeaderUserCache
---@field activeness number
---@field itemWeight number
---@field itemPercent number
---@field code number
---@field msg string
---@field guild string
---@field guildCount number
---@field raids table<number, number>
---@field scores number[]
---@field tags string[]

---@class GoodLeaderAddon
---@field userCache table<string, GoodLeaderUserCache>
local GoodLeader =
    ns.Addon:NewModule('GoodLeader', 'AceEvent-3.0', 'AceBucket-3.0', 'LibClass-2.0', 'LibCommSocket-3.0')

function GoodLeader:OnInitialize()
    self.userCache = {}

    self:ListenSocket('GOODLEADER')
    self:ConnectServer('S1' .. UnitFactionGroup('player'))
    self:RegisterServer('SERVER_CONNECTED')
    self:RegisterServer('SGL')
    self:RegisterServer('SGT')

    self:RegisterEvent('GROUP_ROSTER_UPDATE')
    C_Timer.After(5, function()
        self:GROUP_ROSTER_UPDATE()
    end)

    self.defaultTags = {
        strsplit(',', '幽默风趣,效率,飙车司机,萌妹,磁性嗓音,段子手,欧皇,良心团长'),
    }
end

function GoodLeader:OnEnable()
    self.timeoutTimer = C_Timer.NewTimer(5 * 60, function()
        self:SERVER_CONNECT_TIMEOUT()
    end)
end

function GoodLeader:SERVER_CONNECTED()
    self:SendServer('SLOGIN', ns.ADDON_VERSION, UnitGUID('player'), ns.GetPlayerItemLevel(), UnitLevel('player'),
                    (GetGuildInfo('player')))
    self.timeoutTimer:Cancel()
    self.serverTimeout = nil
    self.serverLogon = true
    self:SendMessage('GOODLEADER_LOGIN')
end

function GoodLeader:SERVER_CONNECT_TIMEOUT()
    self.timeoutTimer = nil
    self.serverTimeout = true
    self:SendMessage('GOODLEADER_CONNECT_TIMEOUT')
end

function GoodLeader:SGL(_, name, code, msg, activeness, itemPercent, raidData, scores, tags)
    local user = self:GetUserCache(name)

    if code ~= 0 then
        user.code = code
        user.msg = msg
    else
        local raids = {}

        for i, v in ipairs(raidData) do
            raids[v[1]] = v[2]
        end

        user.activeness = activeness
        user.itemPercent = itemPercent
        user.raids = raids
        user.scores = scores
        user.tags = tags
    end
    self:GROUP_ROSTER_UPDATE()
    self:SendMessage('GOODLEADER_LEADERINFO_UPDATE')
end

function GoodLeader:SGT(_, tags)
    --[=[@debug@
    dump(tags)
    --@end-debug@]=]
    tags = tags and {strsplit(',', tags)} or nil
    if tags and #tags == 0 then
        tags = nil
    end
    ns.Addon.db.profile.goodleader.tags = tags
end

function GoodLeader:LookupLeader()
    local name, guid = ns.GetGroupLeader()
    if not name then
        return
    end
    wipe(self.userCache)
    self:SendServer('SGL', name, guid)
end

function GoodLeader:GetUserCache(name)
    self.userCache[name] = self.userCache[name] or {}
    return self.userCache[name]
end

function GoodLeader:GROUP_ROSTER_UPDATE()
    local name, guid = ns.GetGroupLeader()
    local guild = GetGuildInfo(name)
    local count = 0

    if guild then
        for unit in ns.IterateGroup() do
            if guild == GetGuildInfo(unit) then
                count = count + 1
            end
        end
    end

    local user = self:GetUserCache(name)
    user.guild = guild
    user.guildCount = count
end

function GoodLeader:INSPECT_READY(_, guid)
    if not InspectFrame then
        return
    end
    local unit = InspectFrame.unit
    if not unit or UnitGUID(unit) ~= guid then
        return
    end

    local itemLevel = ns.GetUnitItemLevel(unit)
    if not itemLevel then
        self.inspectBucket = self:RegisterBucketEvent('GET_ITEM_INFO_RECEIVED', 1)
        self.inspectGuid = guid
        return
    end
end

function GoodLeader:GET_ITEM_INFO_RECEIVED()
    if not self.inspectGuid then
        return
    end

    local guid = self.inspectGuid

    self:UnregisterBucket(self.inspectBucket)
    self.inspectBucket = nil
    self.inspectGuid = nil
    self:INSPECT_READY(nil, guid)
end

function GoodLeader:GetGradeTags()
    return ns.Addon.db.profile.goodleader.tags or self.defaultTags
end

function GoodLeader:IsServerTimeout()
    return self.serverTimeout
end

function GoodLeader:IsServerLogon()
    return self.serverLogon
end
