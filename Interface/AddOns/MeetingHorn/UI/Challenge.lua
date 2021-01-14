-- Challenge.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 12/8/2020, 10:47:24 AM
--
---@type ns
local ns = select(2, ...)

---@class FormText: Frame
local FormText = ns.Addon:NewClass('FormText', 'Frame')
ns.GUI:Embed(FormText, 'Refresh')

function FormText:Constructor()
    self.labels = {}
    self.texts = {}
    self.count = 0
end

function FormText:Clear()
    self.count = 0
    for i, label in ipairs(self.labels) do
        label:SetText('')
    end
    wipe(self.texts)
end

function FormText:Add(text)
    tinsert(self.texts, text)
    self:Refresh()
end

function FormText:Update()
    local column = ceil(#self.texts / 4)
    local texts = {}

    for i, text in ipairs(self.texts) do
        local col = (i - 1) % column + 1
        texts[col] = texts[col] or {}
        tinsert(texts[col], text)
    end

    for i = 1, column do
        local label = self:GetLabel(i)
        label:SetText(table.concat(texts[i], '\n'))
        label:Show()
    end

    for i = column + 1, #self.labels do
        self.labels[i]:Hide()
    end
end

function FormText:GetLabel(i)
    if not self.labels[i] then
        local label = self:CreateFontString(nil, 'OVERLAY', 'GameFontDisableSmallLeft')
        label:SetTextColor(0.8, 0.8, 0.8)
        if i == 1 then
            label:SetPoint('TOPLEFT')
        else
            label:SetPoint('TOPLEFT', self.labels[i - 1], 'TOPRIGHT', 10, 0)
        end
        self.labels[i] = label
    end
    return self.labels[i]
end

---@class MeetingHornUIChallenge: Frame
---@field FormText FormText
local Challenge = ns.Addon:NewClass('UI.Challenge', 'Frame')
LibStub('AceEvent-3.0'):Embed(Challenge)

function Challenge:Constructor()
    FormText:Bind(self.Body.FormText)
    ns.UI.CountdownButton:Bind(self.Body.UpdateButton)
    ns.UI.CountdownButton:Bind(self.Body.Reward.Exchange)

    self.challengeButtons = {}

    self:RegisterMessage('MEETINGHORN_CHALLENGE_GROUP_UPDATED')
    self:RegisterMessage('MEETINGHORN_CHALLENGE_PROGRESS_UPDATED')
    self:RegisterMessage('MEETINGHORN_CHALLENGE_FETCH_REWARD_RESULT')

    self:RegisterMessage('MEETINGHORN_SERVER_CONNECTED')
    self:RegisterEvent('GET_ITEM_INFO_RECEIVED')

    self.Body.ProgressBar:SetParent(self.Body.AddonFrame)
    self.Body.ProgressLabel:SetParent(self.Body.AddonFrame)
    self.Body.UpdateButton:SetParent(self.Body.AddonFrame)

    self.Body.WebButton:SetParent(self.Body.WebFrame)

    self.Rules.Content:SetText(ns.L.CHALLENGE_RULES)

    self.Body.UpdateButton:SetScript('OnClick', function(button)
        if self.id then
            ns.LFG:RequestChallengeProgress(self.id)
            button:SetCountdown(10)
        end
    end)

    self.Body.Reward.Exchange:SetScript('OnClick', function(button)
        if self.id then
            ns.LFG:FetchChallengeReward(self.id)
            button:SetCountdown(10)
        end
    end)

    self.Body.WebButton:SetScript('OnClick', function()
        if self.item and self.item.content then
            ns.OpenUrlDialog(self.item.content)
        end
    end)

    self.Summary:SetScript('OnHyperlinkClick', function(_, link, text, button)
        if link == 'rules' then
            self.Rules:Show()
            return
        end

        local linkType, content = link:match('([%a]+):(.+)')
        if linkType == 'url' then
            ns.OpenUrlDialog(content)
        end
    end)

    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)
end

function Challenge:MEETINGHORN_SERVER_CONNECTED()
    self.connected = true

    if self:IsVisible() then
        self:OnShow()
    end
end

function Challenge:MEETINGHORN_CHALLENGE_PROGRESS_UPDATED(_, err, id)
    if id == self.id then
        self:UpdateChallenge()
    end
end

function Challenge:MEETINGHORN_CHALLENGE_FETCH_REWARD_RESULT(_, err, id)
    if id == self.id then
        self:UpdateChallenge()
    end
end

function Challenge:GET_ITEM_INFO_RECEIVED(_, itemId, success)
    if success and self.item and self.item.reward and itemId == self.item.reward.itemId then
        self:UpdateChallenge()
    end
end

function Challenge:MEETINGHORN_CHALLENGE_GROUP_UPDATED()
    ns.Addon.MainPanel.Loading:Hide()
    self.requesting = nil
    if self.timer then
        self.timer:Cancel()
        self.timer = nil
    end
    self:UpdateGroup()
end

function Challenge:GetChallengeButton(i)
    if not self.challengeButtons[i] then
        local button = CreateFrame('Button', nil, self.Left, 'MeetingHornAcitivityButtonTemplate')
        if i == 1 then
            button:SetPoint('TOPLEFT', 10, -81)
        else
            button:SetPoint('TOPLEFT', self.challengeButtons[i - 1], 'BOTTOMLEFT', 0, -15)
        end

        button:SetScript('OnClick', function(button)
            self:SetChallenge(button.id)
        end)

        self.challengeButtons[i] = button
    end
    return self.challengeButtons[i]
end

function Challenge:UpdateGroup()
    local group = ns.LFG.challengeGroup
    local found = false
    local firstId

    for i, challenge in ipairs(group.items) do
        local button = self:GetChallengeButton(i)
        local icon = challenge.reward and GetItemIcon(challenge.reward.itemId) or [[Interface\Icons\ability_spy]]

        SetPortraitToTexture(button.icon, icon)

        if challenge.id == self.id then
            found = true
        end
        if not firstId then
            firstId = challenge.id
        end

        button.name:SetText(challenge.title)
        button.id = challenge.id

        if self.id == challenge.id then
            button:LockHighlight()
        else
            button:UnlockHighlight()
        end
        button:Show()
    end

    for i = #group.items + 1, #self.challengeButtons do
        self.challengeButtons[i]:Hide()
    end

    if not found and firstId then
        self:SetChallenge(firstId)
    end
end

function Challenge:SetChallenge(id)
    local group = ns.LFG.challengeGroup

    local item = group.itemMap[id]
    if not item then
        return
    end

    self.id = id
    self.item = item
    self.group = group
    self:UpdateChallenge()
    self:UpdateGroup()
end

function Challenge:UpdateReward()
    self.Body.Reward:Hide()
    self.Body.Reward.Model:Hide()
    self.Body.Reward.Icon:Hide()

    local item = self.item
    if not item.reward then
        return
    end

    self.Body.Reward:Show()

    if item.reward.itemId then
        local name = GetItemInfo(item.reward.itemId)
        self.Body.Reward.Name:SetText(name or UNKNOWN)
    end

    if item.reward.displayId then
        self.Body.Reward.Model:SetDisplayInfo(item.reward.displayId)
        self.Body.Reward.Model:Show()
        return
    end

    if item.reward.itemId then
        SetPortraitToTexture(self.Body.Reward.Icon.Texture, GetItemIcon(item.reward.itemId))
        self.Body.Reward.Icon:Show()
    end
end

function Challenge:UpdateProgress()
    local item = self.item
    if not item then
        return
    end
    if item.type == ns.ChallengeType.KillBoss or item.type == ns.ChallengeType.LeaderKillBoss then
        for i, v in ipairs(item.boss) do
            if item.completedMap[v.id] then
                self.Body.FormText:Add('|cff00ff80' .. ns.GetEncouterBossName(v.id) .. '|r')
            else
                self.Body.FormText:Add(ns.GetEncouterBossName(v.id))
            end
        end

        self.Body.ProgressBar:SetMinMaxValues(0, #item.boss)
        self.Body.ProgressBar:SetValue(#item.completed)
        self.Body.ProgressBar.TextString:SetFormattedText('%d/%d', #item.completed, #item.boss)
    elseif item.type == ns.ChallengeType.KillBossGainExp or item.type == ns.ChallengeType.ExternalWeb then
        local f = item.type == ns.ChallengeType.KillBossGainExp and '%s (%d经验)' or '%s (%d积分)'
        for i, v in ipairs(item.boss) do
            self.Body.FormText:Add(format(f, ns.GetEncouterBossName(v.id), v.exp))
        end

        if item.type == ns.ChallengeType.KillBossGainExp then
            self.Body.ProgressBar:SetMinMaxValues(0, item.totalExp)
            self.Body.ProgressBar:SetValue(item.currentExp)
            self.Body.ProgressBar.TextString:SetFormattedText('%d/%d', item.currentExp, item.totalExp)
        end
    end
end

function Challenge:UpdateSummary()
    local item = self.item
    if not item then
        return
    end
    if item.type == ns.ChallengeType.KillBoss then
        self.Summary.Text:SetFormattedText(
            '成功击杀%s团本的上述BOSS，即可领取相应奖励，同一角色本活动奖励限领一次。\n\n本次活动所有奖励均有集结号插件发放，点击查看|cff00ffff|Hrules|h[详细规则]|h|r',
            ns.GetEncounterRaidName(item.raidId))
    elseif item.type == ns.ChallengeType.KillBossGainExp then
        self.Summary.Text:SetFormattedText(
            '同一角色每成功击杀%s团本的指定首领，即可获得相应经验值。该角色累计获得%s经验值，即可领取相应奖励，同一角色本活动奖励限领一次。\n\n本次活动所有奖励均有集结号插件发放，点击查看|cff00ffff|Hrules|h[详细规则]|h|r',
            ns.GetEncounterRaidName(item.raidId), item.totalExp)
    elseif item.type == ns.ChallengeType.LeaderKillBoss then
        self.Summary.Text:SetFormattedText(
            '带领团队获取全部上述%s个BOSS的击杀，即可领取相应奖励，同一角色本活动奖励限领一次。\n\n本次活动所有奖励均有集结号插件发放，点击查看|cff00ffff|Hrules|h[详细规则]|h|r',
            #item.boss)
    elseif item.type == ns.ChallengeType.ExternalWeb then
        self.Summary.Text:SetFormattedText(
            '带领团队每成功击杀上述BOSS即可获得相应赛事积分，同一战网账号下的角色所获取的积分可以累加，您可以在|cff00ffff|Hurl:%s|h[赛事兑换页链接]|h|r兑换相应奖励。',
            item.content)
    else
        self.Summary.Text:SetText('')
    end
end

function Challenge:UpdateInfo()
    local item = self.item
    local group = self.group
    if not item or not group then
        return
    end
    local isWeb = item.type == ns.ChallengeType.ExternalWeb

    self.Body.WebFrame:SetShown(isWeb)
    self.Body.AddonFrame:SetShown(not isWeb)
    self.Body.FormText:Clear()
    self.Body.Title:SetText(item.title)
    self.Body.SubTitle:SetText(item.summary)
    self.Body.Reward.Exchange:SetEnabled(not item.rewardFetched and item.finished)
    self.Body.Reward.Exchange:SetText(item.rewardFetched and '已领取' or '领取奖励')
    self.Body.UpdateButton:SetShown(not item.finished)
    self.Body.Time:SetFormattedText('活动时间：%s - %s', date('%Y/%m/%d', group.startTime),
                                    date('%Y/%m/%d', group.endTime))

end

function Challenge:UpdateChallenge()
    self:UpdateInfo()
    self:UpdateReward()
    self:UpdateProgress()
    self:UpdateSummary()
end

function Challenge:OnShow()
    if not self.connected then
        ns.Addon.MainPanel.Loading:Show()
        return
    end

    if self.requesting then
        ns.Addon.MainPanel.Loading:Show()
        return
    end

    if not ns.LFG.challengeGroup then
        ns.Addon.MainPanel.Loading:Show()
        ns.LFG:RequestChallengeGroup()
        self.requesting = true
        self.timer = C_Timer.NewTimer(30, function()
            self.requesting = nil
        end)
        return
    end

    ns.Addon.MainPanel.Loading:Hide()
end

function Challenge:OnHide()
    ns.Addon.MainPanel.Loading:Hide()
end
