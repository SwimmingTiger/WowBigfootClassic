---@type ns
local ns = select(2, ...)

local L = ns.L

---@class MeetingHornChallengeBoss 挑战任务BOSS配置
---@field public id number Boss id
---@field public exp number 经验值

---@class MeetingHornChallengeReward 挑战任务奖励配置
---@field public itemId number 物品ID
---@field public displayId number 模型ID

---@class MeetingHornChallengeType
ns.ChallengeType = {
    KillBoss = 1, -- 团员击杀指定BOSS
    KillBossGainExp = 2, -- 团员击杀指定BOSS获得经验
    LeaderKillBoss = 3, -- 团长击杀指定BOSS
    ExternalWeb = 4, -- Web任务
    KillBossEveryWeek = 5, -- 奖励每周重置的任务
}

---@class MeetingHornChallenge 挑战任务
---@field public id number ID
---@field public type number 类型
---@field public title string 标题
---@field public summary string 简介
---@field public content string 描述
---@field public isLeader boolean 是否团长任务
---@field public raidId number 副本ID
---@field public boss MeetingHornChallengeBoss[] BOSS配置
---@field public totalExp number 总经验
---@field public startTime number 开始时间戳（单位：秒）
---@field public endTime number 结束时间戳
---@field public reward MeetingHornChallengeReward[] 奖励
---@field public finished boolean 是否完成
---@field public rewardFetched boolean 是否已领取奖励
---@field public currentExp number 当前经验值
---@field public rewardCount number 领取奖励的次数
---@field public completed number[] 已完成的boss id
local Challenge = ns.Addon:NewClass('Challenge')

---@class MeetingHornChallengeGroup 挑战任务组
---@field public id number 任务组ID
---@field public startTime number 开始时间戳（单位：秒）
---@field public endTime number 结束时间戳
---@field public rewardTime number 领奖结束时间戳
---@field public items MeetingHornChallenge[] 任务列表
---@field private itemMap table<number, MeetingHornChallenge> 任务列表map
---@field public progressRequested boolean 是否获取过进度列表
local ChallengeGroup = ns.Addon:NewClass('ChallengeGroup')

---@param proto table
function ChallengeGroup:Constructor(proto)
    local t = type(proto)
    if t == 'table' then
        self:UpdateProto(proto)
    elseif t == 'number' then
        self.id = proto
    end
end

function ChallengeGroup:UpdateProto(proto)
    if type(proto) ~= 'table' then
        return
    end

    self.id = proto[1]
    self.startTime = proto[2]
    self.endTime = proto[3]
    self.rewardTime = proto[4]
    self.items = {}
    self.itemMap = {}

    if type(proto[5]) == 'table' then
        for i, v in ipairs(proto[5]) do
            local item = Challenge:New(v)

            item.startTime = item.startTime or self.startTime
            item.endTime = item.endTime or self.endTime

            table.insert(self.items, item)
            self.itemMap[item.id] = item
        end
    end
end

---@param proto table
function ChallengeGroup:UpdateProgresses(proto)
    if type(proto) ~= 'table' then
        return
    end

    for i, v in ipairs(proto) do
        local item = self:Get(v[1])
        if item then
            item:UpdateProgress(v)
        end
    end

    self.progressRequested = true
end

---@return MeetingHornChallenge
function ChallengeGroup:Get(id)
    return self.itemMap[id]
end

---@param proto table
function Challenge:Constructor(proto)
    if type(proto) ~= 'table' then
        return
    end

    --[[@debug@
    dump(proto)
    --@end-debug@]]

    self.id = proto[1]
    self.type = proto[2]
    self.title = proto[3]
    self.summary = proto[4]
    self.content = proto[5]
    self.isLeader = proto[6]
    self.raidId = proto[7]

    self.boss = {}
    if proto[8] then
        for i, v in ipairs(proto[8]) do
            table.insert(self.boss, {id = v, exp = proto[9] and proto[9][i] or 0});
        end
    end

    self.totalExp = proto[10]
    self.startTime = proto[11]
    self.endTime = proto[12]
    self.quests = proto[14]

    if proto[13] then
        self.reward = {}
        for i, v in ipairs(proto[13]) do
            table.insert(self.reward, {itemId = v[1], displayId = v[2]})
        end
    end

    self.completed = {}
    self.completedMap = {}
    self.currentExp = 0
end

---@param proto table
function Challenge:UpdateProgress(proto)
    if type(proto) ~= 'table' then
        return
    end

    --[[@debug@
    dump(proto)
    --@end-debug@]]

    self.finished = proto[2]
    self.rewardFetched = proto[3]
    self.rewardCount = proto[6] or 0

    if self.finished then
        self.completed = {}
        self.completedMap = {}
        self.currentExp = self.totalExp

        for i, v in ipairs(self.boss) do
            self.completed[i] = v.id
            self.completedMap[v.id] = true
        end
    else
        self.currentExp = proto[4] or 0
        self.completed = proto[5] or {}
        self.completedMap = tInvert(self.completed)
    end
end

function Challenge:Fetched()
    if self:IsRepeatable() then
        self.rewardCount = self.rewardCount + 1

        if self.rewardCount >= self.currentExp then
            self.rewardFetched = true
        end
    else
        self.rewardFetched = true
    end
end

function Challenge:CanFetch()
    if not self:IsRepeatable() then
        return self.finished and not self.rewardFetched
    else
        return self.rewardCount < self.currentExp
    end
end

function Challenge:CanRefreshProgress()
    if not self:IsRepeatable() then
        return not self.finished
    else
        return self.rewardCount < self.totalExp
    end
end

function Challenge:HasMultiReward()
    return self.reward and #self.reward > 1
end

function Challenge:IsRepeatable()
    return self.type == ns.ChallengeType.KillBossEveryWeek
end
