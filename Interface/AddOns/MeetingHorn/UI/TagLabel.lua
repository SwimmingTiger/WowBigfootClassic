-- TagLabel.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2/11/2020, 1:01:23 PM

---@type ns
local ns = select(2, ...)

---@class GoodLeaderTagLabel: CheckButton
---@field Text FontString
local TagLabel = ns.Addon:NewClass('UI.TagLabel', 'CheckButton.GoodLeaderTagLabelTemplate')

function TagLabel:Constructor()
    self:SetScript('OnClick', self.Update)
end

function TagLabel:SetText(text)
    self:SuperCall('SetText', text)
    self:SetWidth(self:GetTextWidth() + 10)
end

function TagLabel:SetChecked(flag)
    self:SuperCall('SetChecked', flag)
    self:Update()
end

function TagLabel:Update()
    self:SetNormalFontObject(self:GetChecked() and 'GameFontNormalSmall' or 'GameFontHighlightSmall')
end
