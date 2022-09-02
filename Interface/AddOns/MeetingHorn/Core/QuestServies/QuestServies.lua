-- QuestServies.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2022/4/18 14:03:24
--
---@type ns
local ns = select(2, ...)

---@class QuestServies: AceAddon-3.0, AceEvent-3.0, LibCommSocket-1.0
local QuestServies = ns.Addon:NewModule('QuestServies', 'LibCommSocket-3.0', 'AceEvent-3.0')
local QuestType = {Raid = 1, Quest = 3, Battleground = 2}

function QuestServies:OnInitialize()
    self:ListenSocket('MEETINGHORN')
    self:ConnectServer('S1' .. UnitFactionGroup('player'))
end

function QuestServies:OnEnable()
    self:RegisterServer('QSQ')
    self:RegisterServer('QSP')
    self:RegisterServer('QSF')
    self:RegisterServer('SERVER_CONNECTED')
end

function QuestServies:SERVER_CONNECTED()
    self.connected = true
    self:SendMessage('MEETINGHORN_QUEST_CONNECTED')

    --[[@debug@
    print('QuestServies connected')
    --@end-debug@]]
end

function QuestServies:IsReady()
    return self.fetched
end

function QuestServies:IsConnected()
    return self.connected
end

function QuestServies:IsQuering()
    return self.quering
end

function QuestServies:IsActive()
    return self.active
end

function QuestServies:QSQ(_, active, questGroupData, progressData)
    self.active = active
    self.questGroup = questGroupData and ns.QuestGroup:FromProto(questGroupData)
    if self.questGroup then
        if self.questGroup.id ~= QuestType.GoldLeader then
            if progressData then
                self:QSP(nil, progressData)
            else
                self:SendMessage('MEETINGHORN_QUEST_UPDATE')
            end
        else
            self:QueryScore()
        end
    end
    self.fetched = true
    self.quering = nil
    if self.queringTimer then
        self.queringTimer:Cancel()
        self.queringTimer = nil
    end

    self:SendMessage('MEETINGHORN_QUEST_FETCHED')
end

function QuestServies:QSP(_, progress)
    for _, p in ipairs(progress) do
        local quest = self.questGroup:GetQuest(p[1])
        quest:UpdateProgress(unpack(p, 2))
    end

    self:SendMessage('MEETINGHORN_QUEST_UPDATE')
end

function QuestServies:QSF(_, err, id)
    if err == 0 then
        local quest = self.questGroup.questMap[id]
        if quest then
            quest.rewarded = true
            self:SendMessage('MEETINGHORN_QUEST_UPDATE')
        end
    end
end

function QuestServies:QueryQuestList()
    if not self.connected or self.fetched or self.quering then
        return
    end

    self.quering = true
    self.queringTimer = C_Timer.NewTimer(10, function()
        self.quering = nil
        self.queringTimer = nil
    end)

    self:SendServer('QCQ', UnitGUID('player'), ns.ADDON_VERSION)
end

function QuestServies:QueryQuestProgress()
    self:SendServer('QCP', UnitGUID('player'))
end

QuestServies.QuestType = QuestType
