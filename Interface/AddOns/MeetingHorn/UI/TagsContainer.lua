-- TagsContainer.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2/13/2020, 8:45:57 AM

---@type ns
local ns = select(2, ...)

---@class GoodLeaderTagsContainer: Frame
---@field tagLabels GoodLeaderTagLabel[]
local TagsContainer = ns.Addon:NewClass('UI.TagsContainer', 'Frame')

function TagsContainer:Constructor()
    self.tagLabels = {}
end

function TagsContainer:SetTags(tags)
    for i, tagLabel in ipairs(self.tagLabels) do
        tagLabel:Hide()
    end

    if tags then
        for i, tag in ipairs(tags) do
            local tagLabel = self:GetTagLabel(i)
            tagLabel:SetText(tag)
            tagLabel:Show()
        end
    end

    self:OnLayout()
end

function TagsContainer:OnLayout()
    local width = self:GetWidth()
    local x, y = 0, 0

    for i, tagLabel in ipairs(self.tagLabels) do
        tagLabel:SetChecked(false)

        if tagLabel:IsShown() then
            tagLabel:ClearAllPoints()

            local labelWidth = 5 + tagLabel:GetWidth()
            local nextX = x + labelWidth

            if nextX > width then
                x = 0
                y = y + 25

                tagLabel:SetPoint('TOPLEFT', x, -y)

                x = labelWidth
            else
                tagLabel:SetPoint('TOPLEFT', x, -y)

                x = nextX
            end
        end
    end

    self:SetHeight(max(1, x == 0 and y or y + 20))
end

function TagsContainer:GetTagLabel(i)
    if not self.tagLabels[i] then
        local tagLabel = ns.UI.TagLabel:New(self)
        self.tagLabels[i] = tagLabel
    end
    return self.tagLabels[i]
end

function TagsContainer:GetCheckedTags()
    local results = {}
    for i, tagLabel in ipairs(self.tagLabels) do
        if tagLabel:GetChecked() then
            tinsert(results, tagLabel:GetText())
        end
    end
    return results
end
