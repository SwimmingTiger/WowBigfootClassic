-- Game.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/7/2020, 11:01:13 AM

---@type ns
local ns = select(2, ...)
local L = ns.L

---@type NeteaseWargameGame
local Game = ns.Addon:NewClass('Game')

Game.FromProto = ns.GenerateFromProto('id', 'templateId', 'title', 'mode', 'zone', 'rules', 'combatCount',
                                      'backupCount', 'startTime', 'endTime', 'startMonment', 'endMonment', 'roundCount',
                                      'maxRoundCount', 'noticeTime')

function Game:OnProto()
    self.noticeTime = self.noticeTime or 3
    self.timeList = {}

    if self.endMonment - self.startMonment >= 86400 then
        tinsert(self.timeList, {start = self.startTime + self.startMonment, finish = self.endTime + self.endMonment})
    else
        for t = self.startTime, self.endTime, 86400 do
            tinsert(self.timeList, {start = t + self.startMonment, finish = t + self.endMonment})
        end
    end

    self.maxMemberCount = self.combatCount + self.backupCount
end

function Game:HasRule(rule)
    return self.rules and bit.band(self.rules, rule) > 0
end

function Game:GetZoneText()
    return C_Map.GetMapInfo(self.zone).name
end

function Game:IsInQueue()
    for i = 1, GetMaxBattlefieldID() do
        local status, name, _, _, _, _, battleType = GetBattlefieldStatus(i)
        if battleType == 'WARGAME' and name == self:GetZoneText() then
            return true
        end
    end
end

function Game:GetStartTimeText()
    local m = 60 * 60
    return string.format(L['时间：%s~%s %s~%s'], date(L['%m月%d日'], self.startTime),
                         date(L['%m月%d日'], self.endTime),
                         string.format('%02d:%02d', self.startMonment / m, self.startMonment % m),
                         string.format('%02d:%02d', self.endMonment / m, self.endMonment % m))
end

function Game:IsInProgress()
    local now = ns.time()
    for _, v in ipairs(self.timeList) do
        if now > v.start and now <= v.finish then
            return true
        end
    end
end

function Game:GetNextStartTime()
    local now = ns.time()
    for _, v in ipairs(self.timeList) do
        if now <= v.start then
            return v.start
        end
    end
end
