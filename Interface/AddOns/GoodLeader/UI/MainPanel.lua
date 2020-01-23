---@type ns
local ns = select(2, ...)
local L = ns.L

local MainPanel = ns.Addon:NewClass('UI.MainPanel', 'Frame.GoodLeaderMainPanelTemplate')

function MainPanel:Constructor()
    ButtonFrameTemplate_HidePortrait(self)
    self:SetAttribute('UIPanelLayout-enabled', true)
    self:SetAttribute('UIPanelLayout-defined', true)
    self:SetAttribute('UIPanelLayout-whileDead', true)
    self:SetAttribute('UIPanelLayout-area', 'left')
    self:SetAttribute('UIPanelLayout-pushable', 1)

    self:RegisterForDrag('LeftButton')
    self:SetScript('OnDragStart', self.StartMoving)
    self:SetScript('OnDragStop', self.StopMovingOrSizing)

    self.Title:SetText(L.ADDON_TITLE)

    local GoodLeader = ns.UI.GoodLeaderFrame:New(self)
    GoodLeader:SetPoint('TOPLEFT', 4, -85)
    GoodLeader:SetPoint('BOTTOMRIGHT', -6, 26)
end
