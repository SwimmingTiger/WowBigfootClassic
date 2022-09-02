-- QuestItem.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2022/4/18 15:18:34
--
---@type ns
local ns = select(2, ...)

local QuestItem = ns.Addon:NewClass('UI.QuestItem', 'Button')

local function RewardOnClick(self)
    local button = self:GetParent()
    button.scrollFrame:Fire('OnItemRewardClick', button, button.item)
    self:SetCountdown(10)
end

function QuestItem:Constructor()
    for _, button in ipairs(self.Items) do
        button:Disable()
    end

    ns.UI.CountdownButton:Bind(self.Reward)

    self.Reward:SetScript('OnClick', RewardOnClick)
    self.Reward:SetCountdownObject(QuestItem)
end

local SetItem, OnEvent

function OnEvent(button, itemId, ok)
    if itemId == button.itemId and ok then
        button:UnregisterEvent('GET_ITEM_INFO_RECEIVED')
        button:SetScript('OnEvent', nil)

        SetItem(button, button.itemId, button.count)
    end
end

function SetItem(button, itemId, count)
    SetItemButtonTexture(button, GetItemIcon(itemId))
    SetItemButtonCount(button, count)

    button.itemId = itemId
    button.count = count

    local name, link, quality = GetItemInfo(itemId)
    if name then
        if quality >= Enum.ItemQuality.Standard then
            local color = BAG_ITEM_QUALITY_COLORS[quality]
            button.IconBorder:SetTexture([[Interface\Common\WhiteIconFrame]])
            button.IconBorder:SetVertexColor(color.r, color.g, color.b)
            button.IconBorder:Show()
        else
            button.IconBorder:Hide()
        end
    else
        button:RegisterEvent('GET_ITEM_INFO_RECEIVED')
        button:SetScript('OnEvent', OnEvent)
    end
    button:Show()
end

---@param quest Quest
function QuestItem:SetQuest(quest)
    self.Text:SetText(quest:GetTitle())
    self.Reward:SetShown(quest.rewards)
    self.Reward:SetEnabled(quest:IsCompleted() and not quest.rewarded)
    self.Reward:SetText(quest.rewarded and '已领取' or '领取奖励')
    self.Progress:SetFormattedText('%d/%d', quest.progressValue, quest.progressMaxValue)

    local rightButton
    for i, button in ipairs(self.Items) do
        local reward = quest.rewards[i]
        if reward then
            rightButton = button
            SetItem(button, reward.id, reward.count)
        else
            button:Hide()
        end
    end

    self.Text:SetPoint('LEFT', rightButton, 'RIGHT', 5, 0)
end

function QuestItem:SetData(data)
    self.Item:SetItem(data.item)
    self.Text:SetText(data.text)
    self.Reward:Hide()
    self.Progress:SetText('')
end
