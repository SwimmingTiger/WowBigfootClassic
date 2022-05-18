-- QuestPanel.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2022/4/18 15:05:00
--
---@type ns
local ns = select(2, ...)

---@class QuestPanel: Object, Frame
local QuestPanel = ns.Addon:NewClass('UI.QuestPanel', 'Frame')
LibStub('AceEvent-3.0'):Embed(QuestPanel)

function QuestPanel:Constructor()
    self.Quests = ns.UI.ListView:Bind(self.Body.Quests)

    self.Quests:SetCallback('OnItemCreated', function(_, button)
        ns.UI.QuestItem:Bind(button)
    end)
    self.Quests:SetCallback('OnItemFormatting', function(_, button, item)
        button:SetQuest(item)
    end)
    ---@param item Quest
    self.Quests:SetCallback('OnItemRewardClick', function(_, button, item)
        if item:IsCompleted() and not item.rewarded then
            ns.QuestServies:SendServer('QCF', UnitGUID('player'), item.id)
        end
    end)

    self.Quests:SetItemTemplate('MeetingHornQuestItemTemplate')

    ns.UI.CountdownButton:Bind(self.Body.Refresh)

    self.Body.Refresh:SetScript('OnClick', function(button)
        ns.QuestServies:QueryQuestProgress()
        button:SetCountdown(10)
    end)

    self.Summary.Text:SetText([[1.玩家可自由组队或单人完成“全民周常挑战”；
2.玩家完成任意符合挑战要求的内容即可参与挑战并累计进度；
3.战场挑战面向61级及以上角色开放，日常任务挑战面向70级角色开放；
4.周常进度和奖励领取将在每周副本CD更新时重置，请及时领取奖励，未领取则视作放弃，为避免进度更新失败，请尽量避免临近CD更新时（每周四凌晨7:00）完成挑战内容；]])

    self:RegisterMessage('MEETINGHORN_QUEST_FETCHED')
    self:RegisterMessage('MEETINGHORN_QUEST_UPDATE', 'MEETINGHORN_QUEST_FETCHED')
    self:RegisterMessage('MEETINGHORN_QUEST_CONNECTED')

    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)
end

function QuestPanel:OnShow()
    ns.Addon.MainPanel.Loading:Hide()
    ns.Addon.MainPanel.OutOfDate:Hide()

    if not ns.QuestServies:IsConnected() then
        ns.Addon.MainPanel.Loading:Show()
        return
    end
    if ns.QuestServies:IsQuering() then
        ns.Addon.MainPanel.Loading:Show()
        return
    end

    if not ns.QuestServies:IsReady() then
        ns.Addon.MainPanel.Loading:Show()
        ns.QuestServies:QueryQuestList()
        return
    end

    if not ns.QuestServies:IsActive() then
        ns.Addon.MainPanel.OutOfDate:Show()
        return
    end
end

function QuestPanel:OnHide()
    ns.Addon.MainPanel.Loading:Hide()
    ns.Addon.MainPanel.OutOfDate:Hide()
end

function QuestPanel:MEETINGHORN_QUEST_CONNECTED()
    if self:IsVisible() then
        self:OnShow()
    end
end

function QuestPanel:MEETINGHORN_QUEST_FETCHED()
    if not self:IsVisible() then
        return
    end

    self:OnShow()

    local questGroup = ns.QuestServies.questGroup

    self.Body.Time:SetFormattedText('活动时间：%s - %s', date('%Y/%m/%d %H:%M', questGroup.startTime),
                                    date('%Y/%m/%d %H:%M', questGroup.endTime))
    self.Quests:SetItemList(questGroup.quests)
    self.Quests:Refresh()
end
