-- ScoreWidget.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2/10/2020, 10:50:35 AM

---@type ns
local ns = select(2, ...)

---@class GoodLeaderScoreWidget: Frame
---@field buttons Button[]
local ScoreWidget = ns.Addon:NewClass('UI.ScoreWidget', 'Frame')

function ScoreWidget:Constructor()
    self.buttons = {}
    self.value = 0

    local function OnEnter(button)
        self:SetValue(button:GetID(), true)
    end
    local function OnLeave(button)
        self:SetValue(self.value)
    end
    local function OnClick(button)
        self:SetValue(button:GetID())
    end

    for i = 1, 5 do
        ---@type CheckButton
        local button = CreateFrame('Button', nil, self)
        button:SetID(i)
        button:SetSize(19, 19)
        button:SetPoint('TOPLEFT', (i - 1) * 20, 0)
        button:SetScript('OnEnter', OnEnter)
        button:SetScript('OnLeave', OnLeave)
        button:SetScript('OnClick', OnClick)

        local nt = button:CreateTexture(nil, 'ARTWORK')
        nt:SetSize(25, 25)
        nt:SetPoint('TOPLEFT', -3, 3)
        nt:SetAtlas('PetJournal-FavoritesIcon')
        nt:SetVertexColor(0.3, 0.3, 0.3)
        nt:SetDesaturated(true)

        local ct = button:CreateTexture(nil, 'OVERLAY')
        ct:SetSize(25, 25)
        ct:SetPoint('TOPLEFT', -3, 3)
        ct:SetAtlas('PetJournal-FavoritesIcon')

        -- local texture, _, _, left, right, top, bottom = GetAtlasInfo('PetJournal-FavoritesIcon')

        -- local ctHalf = button:CreateTexture(nil, 'OVELAY')
        -- ctHalf:SetSize(12.5, 25)
        -- ctHalf:SetPoint('TOPLEFT', -3, 3)
        -- ctHalf:SetTexture(texture)
        -- ctHalf:SetTexCoord(left, left + (right - left) * 0.5, top, bottom)

        button:SetNormalTexture(nt)

        button.nt = nt
        button.ct = ct
        -- button.ctHalf = ctHalf

        self.buttons[i] = button
    end

    self:SetSize(100, 20)

    local Overlay = CreateFrame('Button', nil, self)
    Overlay:SetAllPoints(true)
    Overlay:Hide()
    Overlay:SetFrameLevel(self:GetFrameLevel() + 10)
    self.Overlay = Overlay
end

function ScoreWidget:SetValue(value, temp)
    for i, button in ipairs(self.buttons) do
        -- local v = (value + 1) % i
        -- if value >= i then
        --     button.ct:SetWidth(WIDTH)
        --     button.ct:SetTexCoord(LEFT, RIGHT, TOP, BOTTOM)
        --     button.ct:Show()
        -- elseif v > 1 then
        --     button.ct:SetWidth(WIDTH)
        --     button.ct:SetTexCoord(LEFT, RIGHT, TOP, BOTTOM)
        --     button:SetChecked(v == 0)
        -- else
        --     print(v)
        --     button.ct:SetWidth(WIDTH * v)
        --     button.ct:SetTexCoord(LEFT, LEFT + 0.1 + (RIGHT - LEFT - 0.2) * v, TOP, BOTTOM)
        --     button:SetChecked(true)
        -- end
        button.ct:SetShown(value >= i)
    end

    if not temp then
        self.value = value
    end
end

function ScoreWidget:GetValue()
    return self.value
end

function ScoreWidget:SetReadOnly(flag)
    self.Overlay:SetShown(flag)
end

function ScoreWidget:IsReadyOnly()
    return self.Overlay:IsShown()
end

-- local w = ScoreWidget:New(UIParent)
-- w:SetPoint('CENTER')
-- w:SetValue(4.2)
-- w:SetReadOnly(true)

-- function _G.GG(v)
--     w:SetValue(v)
-- end

-- local w = CreateFrame('Frame', nil, UIParent, 'GoodLeaderGradePanelTemplate')
-- w:SetPoint('CENTER')
-- w.Title:SetText('团长评价')
-- w.Leader:SetText('假牙')
-- w.Leader:Disable()
-- w.Score1.Text:SetText('公正：')
-- w.Score2.Text:SetText('公正：')
-- w.Score3.Text:SetText('公正：')
-- w.Tags:SetTags{'幽默风趣', '好团长', '效率', '飙车司机', '公正', '磁性嗓音', '段子手', '欧皇'}
