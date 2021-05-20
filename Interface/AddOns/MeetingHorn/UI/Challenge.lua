-- Challenge.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 12/8/2020, 10:47:24 AM
--
---@type ns
local ns = select(2, ...)
local L = ns.L

---@class FormText: Frame
local FormText = ns.Addon:NewClass('FormText', 'Frame')
ns.GUI:Embed(FormText, 'Refresh')

function FormText:Constructor()
    self.labels = {}
    self.texts = {}
    self.singleTexts = {}
    self.count = 0
end

function FormText:Clear()
    self.count = 0
    for i, label in ipairs(self.labels) do
        label:SetText('')
    end
    if self.singleLabel then
        self.singleLabel:SetText('')
    end
    wipe(self.singleTexts)
    wipe(self.texts)
end

function FormText:Add(text)
    tinsert(self.texts, text)
    self:Refresh()
end

function FormText:AddSingleLine(text)
    tinsert(self.singleTexts, text)
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

    local singleText = table.concat(self.singleTexts, '\n')
    if singleText ~= '' then
        if not self.singleLabel then
            local label = self:CreateFontString(nil, 'OVERLAY', 'GameFontDisableSmallLeft')
            label:SetTextColor(0.8, 0.8, 0.8)
            label:SetPoint('TOPLEFT', self:GetLabel(1), 'BOTTOMLEFT', 0, -2)
            label:SetWidth(340)
            self.singleLabel = label
        end
        self.singleLabel:SetText(singleText)
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

local function UpdateReward(frame, reward)
    frame:Hide()
    frame.Model:Hide()
    frame.Icon:Hide()

    if not reward then
        return
    end

    frame:Show()
    frame.itemId = reward.itemId

    if reward.itemId then
        local name = GetItemInfo(reward.itemId)
        frame.Name:SetText(name or UNKNOWN)
    end

    if reward.displayId then
        frame.Model:SetDisplayInfo(reward.displayId)
        frame.Model:Show()
    elseif reward.itemId then
        SetPortraitToTexture(frame.Icon.Texture, GetItemIcon(reward.itemId))
        frame.Icon:Show()
    end
end

local MultiRewardItem = ns.Addon:NewClass('UI.MultiRewardItem', ns.GUI:GetClass('ViewItem'))

function MultiRewardItem:Constructor()
    self.Reward = CreateFrame('Frame', nil, self, 'MeetingHornChallengeRewardTemplate')
    self.Reward:SetAllPoints(self)

    local ct = self.Reward:CreateTexture(nil, 'OVERLAY', 'store-card-selected')
    ct:Hide()
    ct:SetBlendMode('ADD')
    ct:SetAllPoints(true)

    local ht = self.Reward:CreateTexture(nil, 'OVERLAY', 'store-card-hover', 1)
    ht:Hide()
    ht:SetBlendMode('ADD')
    ht:SetAllPoints(true)

    self.ct = ct
    self.ht = ht
end

---@class MeetingHornUIChallenge: Frame
---@field FormText FormText
local Challenge = ns.Addon:NewClass('UI.Challenge', 'Frame')
LibStub('AceEvent-3.0'):Embed(Challenge)

function Challenge:Constructor()
    FormText:Bind(self.Body.FormText)
    ns.UI.CountdownButton:Bind(self.Body.UpdateButton)
    ns.UI.CountdownButton:Bind(self.Body.Reward.Exchange)
    ns.UI.CountdownButton:Bind(self.Body.MultiReward.Exchange)
    ns.GUI:GetClass('Dropdown'):Bind(self.Left.Groups)
    ns.GUI:GetClass('GridView'):Bind(self.Body.MultiReward.Rewards)

    local function ShowRewardTooltip(frame, anchor)
        if frame.itemId then
            GameTooltip:SetOwner(frame, anchor or 'ANCHOR_NONE')
            GameTooltip:SetItemByID(frame.itemId)
            if not anchor then
                GameTooltip:SetPoint('RIGHT', frame, 'LEFT')
            end
        end
    end

    self.Body.MultiReward.Rewards.GetScrollBarFixedWidth = function()
        return 0
    end

    self.Body.MultiReward.Rewards:SetSelectMode('RADIO')
    self.Body.MultiReward.Rewards:SetPadding(45, 45, 45, 0)
    self.Body.MultiReward.Rewards:SetItemHeight(120)
    self.Body.MultiReward.Rewards:SetItemClass(MultiRewardItem)
    self.Body.MultiReward.Rewards:SetColumnCount(3)
    self.Body.MultiReward.Rewards:SetItemSpacing(10)
    self.Body.MultiReward.Rewards:SetCallback('OnItemFormatting', function(view, button, info)
        UpdateReward(button.Reward, info)
        button.ct:SetShown(info == view._selectedItem)
    end)
    self.Body.MultiReward.Rewards:SetCallback('OnItemEnter', function(_, button)
        button.ht:Show()
        ShowRewardTooltip(button.Reward, 'ANCHOR_BOTTOM')
    end)
    self.Body.MultiReward.Rewards:SetCallback('OnItemLeave', function(_, button)
        button.ht:Hide()
        GameTooltip_Hide()
    end)
    self.Body.MultiReward.Rewards:SetScript('OnShow', function(view)
        view:SetSelected(nil)
        self:UpdateControls()
    end)
    self.Body.MultiReward.Rewards:SetCallback('OnSelectChanged', function(view)
        if view:IsVisible() then
            self:UpdateControls()
        end
    end)

    self.Body.MultiReward.Rewards.scrollBar:ClearAllPoints()
    self.Body.MultiReward.Rewards.scrollBar:SetPoint('TOPRIGHT', self.Body.MultiReward, 'TOPRIGHT', 0, -18)
    self.Body.MultiReward.Rewards.scrollBar:SetPoint('BOTTOMRIGHT', self.Body.MultiReward, 'BOTTOMRIGHT', 0, 18)

    self.challengeButtons = {}

    self:RegisterMessage('MEETINGHORN_CHALLENGE_GROUP_READY')
    self:RegisterMessage('MEETINGHORN_CHALLENGE_GROUP_UPDATED')
    self:RegisterMessage('MEETINGHORN_CHALLENGE_PROGRESS_UPDATED')
    self:RegisterMessage('MEETINGHORN_SERVER_CONNECTED')
    self:RegisterMessage('MEETINGHORN_CHALLENGE_OUT_OF_DATE')
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

    self.Body.Reward:SetScript('OnEnter', function(frame)
        return ShowRewardTooltip(frame)
    end)
    self.Body.Reward:SetScript('OnLeave', GameTooltip_Hide)

    self.Body.Reward.Exchange:SetScript('OnClick', function(button)
        if self.id then
            local reward = self.challenge and self.challenge.reward and self.challenge.reward[1]
            if reward then
                ns.LFG:FetchChallengeReward(self.id, reward.itemId)
                self.Body.MultiReward.Exchange:SetCountdown(10)
                self.Body.Reward.Exchange:SetCountdown(10)
            end
        end
    end)

    self.Body.MultiReward.Exchange:SetScript('OnClick', function(button)
        if self.id then
            local reward = self.Body.MultiReward.Rewards:GetSelectedItem()
            if reward then
                ns.LFG:FetchChallengeReward(self.id, reward.itemId)
                self.Body.MultiReward.Exchange:SetCountdown(10)
                self.Body.Reward.Exchange:SetCountdown(10)
            end
        end
    end)

    self.Body.Reward.View:SetScript('OnClick', function()
        self.Body.MultiReward:Show()
    end)

    self.Body.WebButton:SetScript('OnClick', function()
        if self.challenge and self.challenge.content then
            ns.OpenUrlDialog(self.challenge.content)
        end
    end)

    local function OnHyperlinkClick(_, link, text, _, font, left, bottom, width, height)
        if link == 'rules' then
            self.Rules:Show()
            return
        end

        local linkType, content = link:match('([%a]+):(.+)')
        if linkType == 'url' then
            ns.OpenUrlDialog(content)
        elseif linkType == 'qrcode' then
            if not self.QRTooltip then
                self.QRTooltip = CreateFrame('Frame', nil, self, 'MeetingHornActivityTooltipTemplate')
                self.QRTooltip:SetScript('OnHide', self.QRTooltip.Hide)
                ns.UI.QRCodeWidget:Bind(self.QRTooltip.QRCode)
            end
            self.QRTooltip:SetPoint('BOTTOMLEFT', font, 'TOPLEFT', left, bottom)
            self.QRTooltip.QRCode:SetValue(content)
            self.QRTooltip.Text:SetText(text:match('|h(.+)|h'):gsub('^%[', ''):gsub('%]$', ''))
            self.QRTooltip:Show()
        end
    end

    self.Summary:SetScript('OnHyperlinkClick', OnHyperlinkClick)
    self.Body.FormText:SetScript('OnHyperlinkClick', OnHyperlinkClick)

    self.Left.Groups.Label:SetText(L['Activities List'])

    self.Left.Groups:SetCallback('OnSelectChanged', function()
        self.challengeGroup = ns.LFG:GetChallengeGroup(self.Left.Groups:GetValue())
        if not self.challengeGroup.progressRequested then
            ns.LFG:RequestChallengeGroupProgress(self.challengeGroup.id)
        else
            self:UpdateGroup()
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

function Challenge:MEETINGHORN_CHALLENGE_OUT_OF_DATE()
    self.addonOutOfDate = true

    if self:IsVisible() then
        self:OnShow()
    end
end

function Challenge:MEETINGHORN_CHALLENGE_PROGRESS_UPDATED(_, id)
    if id == self.id then
        self:UpdateChallenge()
    end
end

function Challenge:GET_ITEM_INFO_RECEIVED(_, itemId, success)
    if success and self:HasReward(itemId) then
        self:UpdateChallenge()
    end
end

function Challenge:HasReward(itemId)
    if not self.challenge or not self.challenge.reward then
        return
    end

    for i, v in ipairs(self.challenge.reward) do
        if itemId == v.itemId then
            return true
        end
    end
end

function Challenge:Refresh()
    self.requesting = nil
    if self.timer then
        self.timer:Cancel()
        self.timer = nil
    end
    self:UpdateGroup()
end

function Challenge:MEETINGHORN_CHALLENGE_GROUP_READY()
    local menu = {}
    for i, v in ipairs(ns.LFG.challengeGroups) do
        tinsert(menu, {
            text = i == 1 and L['Current Activity'] or #ns.LFG.challengeGroups <= 2 and L['Last Activity'] or
                format(L['Last Activity %s'], i),
            value = v.id,
        })
    end

    self.Left.Groups:SetMenuTable(menu)
    self.Left.Groups:SetValue(ns.LFG.challengeGroups[1].id)

    ns.Addon.MainPanel.Loading:Hide()
    self:Refresh()
end

function Challenge:MEETINGHORN_CHALLENGE_GROUP_UPDATED(_, id)
    if self.challengeGroup.id == id then
        self:UpdateGroup()
        self:UpdateChallenge()
    end
end

function Challenge:GetChallengeButton(i)
    if not self.challengeButtons[i] then
        local button = CreateFrame('Button', nil, self.Left, 'MeetingHornAcitivityButtonTemplate')
        if i == 1 then
            button:SetPoint('TOPLEFT', 10, -91)
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
    local group = self.challengeGroup
    local found = false
    local firstId

    for i, challenge in ipairs(group.items) do
        local button = self:GetChallengeButton(i)
        local icon = challenge.reward and GetItemIcon(challenge.reward[1].itemId) or [[Interface\Icons\ability_spy]]

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
    local group = self.challengeGroup
    local challenge = group.itemMap[id]
    if not challenge then
        return
    end

    self.id = id
    self.challenge = challenge
    self.group = group
    self.Body.MultiReward:Hide()
    if self.QRTooltip then
        self.QRTooltip:Hide()
    end
    self:UpdateChallenge()
    self:UpdateGroup()
end

function Challenge:UpdateReward()
    self.Body.Reward.itemId = nil
    self.Body.Reward:Hide()

    local challenge = self.challenge
    if not challenge.reward then
        return
    end

    self.Body.Reward:Show()

    if challenge:HasMultiReward() then
        SetPortraitToTexture(self.Body.Reward.Icon.Texture, [[Interface\ICONS\inv_misc_gift_05]])
        self.Body.Reward.Name:SetFormattedText('%d个奖励可选', #challenge.reward)
        self.Body.Reward.Icon:Show()
        self.Body.Reward.Model:Hide()
        self.Body.MultiReward.Rewards:SetItemList(challenge.reward)
        self.Body.MultiReward.Rewards:Refresh()
    else
        UpdateReward(self.Body.Reward, challenge.reward[1])
    end
end

function Challenge:UpdateProgress()
    local challenge = self.challenge
    if not challenge then
        return
    end
    if challenge.type == ns.ChallengeType.KillBoss or challenge.type == ns.ChallengeType.LeaderKillBoss then
        for i, v in ipairs(challenge.boss) do
            if challenge.completedMap[v.id] then
                self.Body.FormText:Add('|cff00ff80' .. ns.GetEncouterBossName(v.id) .. '|r')
            else
                self.Body.FormText:Add(ns.GetEncouterBossName(v.id))
            end
        end

        self.Body.ProgressBar:SetMinMaxValues(0, #challenge.boss)
        self.Body.ProgressBar:SetValue(#challenge.completed)
        self.Body.ProgressBar.TextString:SetFormattedText('%d/%d', #challenge.completed, #challenge.boss)
    elseif challenge.type == ns.ChallengeType.KillBossGainExp or challenge.type == ns.ChallengeType.ExternalWeb then
        local f = challenge.type == ns.ChallengeType.KillBossGainExp and '%s (%d经验)' or '%s (%d积分)'
        for i, v in ipairs(challenge.boss) do
            self.Body.FormText:Add(format(f, ns.GetEncouterBossName(v.id), v.exp))
        end

        if challenge.type == ns.ChallengeType.KillBossGainExp then
            self.Body.ProgressBar:SetMinMaxValues(0, challenge.totalExp)
            self.Body.ProgressBar:SetValue(challenge.currentExp)
            self.Body.ProgressBar.TextString:SetFormattedText('%d/%d', challenge.currentExp, challenge.totalExp)
        end
    elseif challenge.type == ns.ChallengeType.KillBossEveryWeek then
        for i, v in ipairs(challenge.boss) do
            self.Body.FormText:Add(ns.GetEncouterBossName(v.id))
        end

        self.Body.ProgressBar:SetMinMaxValues(0, challenge.totalExp)
        self.Body.ProgressBar:SetValue(challenge.currentExp)
        self.Body.ProgressBar.TextString:SetFormattedText('%d/%d', challenge.currentExp, challenge.totalExp)
    end

    if challenge.quests then
        for i, id in ipairs(challenge.quests) do
            self.Body.FormText:AddSingleLine(ns.GetChallengeQuest(id))
        end
    end
end

function Challenge:UpdateSummary()
    local challenge = self.challenge
    if not challenge then
        return
    end
    if challenge.type == ns.ChallengeType.KillBoss then
        self.Summary.Text:SetFormattedText(
            '成功击杀%s团本的上述BOSS，即可领取相应奖励，同一角色本活动奖励限领一次。\n\n本次活动所有奖励均有集结号插件发放，点击查看|cff00ffff|Hrules|h[详细规则]|h|r',
            ns.GetEncounterRaidName(challenge.raidId))
    elseif challenge.type == ns.ChallengeType.KillBossGainExp then
        self.Summary.Text:SetFormattedText(
            '同一角色每成功击杀%s团本的指定首领，即可获得相应经验值。该角色累计获得%s经验值，即可领取相应奖励，同一角色本活动奖励限领一次。\n\n本次活动所有奖励均有集结号插件发放，点击查看|cff00ffff|Hrules|h[详细规则]|h|r',
            ns.GetEncounterRaidName(challenge.raidId), challenge.totalExp)
    elseif challenge.type == ns.ChallengeType.LeaderKillBoss then
        self.Summary.Text:SetFormattedText(
            '带领团队获取全部上述%s个BOSS的击杀，即可领取相应奖励，同一角色本活动奖励限领一次。\n\n本次活动所有奖励均有集结号插件发放，点击查看|cff00ffff|Hrules|h[详细规则]|h|r',
            #challenge.boss)
    elseif challenge.type == ns.ChallengeType.ExternalWeb then
        self.Summary.Text:SetFormattedText(
            '带领团队每成功击杀上述BOSS即可获得相应赛事积分，同一战网账号下的角色所获取的积分可以累加，您可以在|cff00ffff|Hurl:%s|h[赛事兑换页链接]|h|r兑换相应奖励。',
            challenge.content)
    elseif challenge.type == ns.ChallengeType.KillBossEveryWeek then
        self.Summary.Text:SetFormattedText(
            '玩家角色成功击杀上述BOSS，即可领取相应奖励。同一角色，每个CD可以领取一次。\n\n本次活动所有奖励均有集结号插件发放，点击查看|cff00ffff|Hrules|h[详细规则]|h|r')
    else
        self.Summary.Text:SetText('')
    end
end

function Challenge:UpdateInfo()
    local challenge = self.challenge
    local group = self.group
    if not challenge or not group then
        return
    end
    local isWeb = challenge.type == ns.ChallengeType.ExternalWeb
    local now = time()

    self.Body.WebFrame:SetShown(isWeb)
    self.Body.AddonFrame:SetShown(not isWeb)
    self.Body.FormText:Clear()
    self.Body.Title:SetText(challenge.title)
    self.Body.SubTitle:SetText(challenge.summary)
    self.Body.UpdateButton:SetShown(challenge:CanRefreshProgress())
    self.Body.Time:SetFormattedText('活动时间：%s - %s', date('%Y/%m/%d', challenge.startTime),
                                    date('%Y/%m/%d', challenge.endTime))
    self.Body.ProgressLabel:SetText(challenge:IsRepeatable() and '完成次数：' or '当前进度：')

    -- if now >= item.startTime and now <= item.endTime then
    --     self.Body.Time:SetTextColor(0, 1, 0)
    -- else
    --     self.Body.Time:SetTextColor(1, 0, 0)
    -- end

    if challenge:IsRepeatable() then
        local text = format('已领取：%d/%d', challenge.rewardCount, challenge.currentExp)
        self.Body.Reward.FetchedCount:SetText(text)
        self.Body.MultiReward.FetchedCount:SetText(text)
    else
        self.Body.Reward.FetchedCount:SetText('')
        self.Body.MultiReward.FetchedCount:SetText('')
    end
end

function Challenge:UpdateControls()
    local challenge = self.challenge
    if not challenge then
        return
    end
    if challenge:HasMultiReward() then
        self.Body.Reward.Exchange:Hide()
        self.Body.Reward.View:Show()
        self.Body.MultiReward.Exchange:SetEnabled(challenge:CanFetch() and self.Body.MultiReward.Rewards:GetSelected())
        -- self.Body.MultiReward.Exchange:SetEnable(challenge:CanFetch())
    else
        self.Body.Reward.View:Hide()
        self.Body.Reward.Exchange:Show()
        self.Body.Reward.Exchange:SetEnabled(challenge:CanFetch())
        self.Body.Reward.Exchange:SetText(challenge.rewardFetched and '已领取' or '领取奖励')
    end
end

function Challenge:UpdateChallenge()
    self:UpdateInfo()
    self:UpdateControls()
    self:UpdateReward()
    self:UpdateProgress()
    self:UpdateSummary()
end

function Challenge:OnShow()
    ns.Addon.MainPanel.Loading:Hide()
    ns.Addon.MainPanel.OutOfDate:Hide()

    if not self.connected then
        ns.Addon.MainPanel.Loading:Show()
        return
    end

    if self.addonOutOfDate then
        ns.Addon.MainPanel.OutOfDate:Show()
        return
    end

    if self.requesting then
        ns.Addon.MainPanel.Loading:Show()
        return
    end

    if not self.challengeGroup then
        ns.Addon.MainPanel.Loading:Show()
        ns.LFG:RequestChallengeGroup()
        self.requesting = true
        self.timer = C_Timer.NewTimer(30, function()
            self.requesting = nil
        end)
        return
    end
end

function Challenge:OnHide()
    ns.Addon.MainPanel.Loading:Hide()
    ns.Addon.MainPanel.OutOfDate:Hide()
end
