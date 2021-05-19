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
    GoodLeader:SetPoint('TOPLEFT', 4, -65)
    GoodLeader:SetPoint('BOTTOMRIGHT', -6, 6)

    local FeedBack = ns.GUI:GetClass('BlockDialog'):New(self)
    FeedBack:SetPoint('TOPLEFT', 3, -22)
    FeedBack:SetPoint('BOTTOMRIGHT', -3, 3)
    FeedBack:SetFrameLevel(self:GetFrameLevel() + 100)
    FeedBack.EditBox:SetMaxLetters(128)

    self.FeedBackButton:SetScript('OnClick', function()
        self.FeedBack:Open({
            text = L['Feedback'],
            acceptText = SUBMIT,
            editBox = true,
            OnAccept = function(_, content)
                ns.Addon:SendServer('SFEEDBACK', content, ns.ADDON_VERSION)
                ns.Message(L['Feedback was submitted successfully.'])
            end,
        })
    end)
    self.FeedBackButton:SetScript('OnEnter', function(button)
        GameTooltip:SetOwner(button, 'ANCHOR_TOPRIGHT')
        GameTooltip:SetText(L['Feedback'])
        GameTooltip:Show()
    end)
    self.FeedBackButton:SetScript('OnLeave', GameTooltip_Hide)

    self.FeedBack = FeedBack
end

function MainPanel:SetTitleShown(flag)
    if flag then
        self.Title:Show()
        self.TextBackground:Show()
    else
        self.Title:Hide()
        self.TextBackground:Hide()
    end
end
