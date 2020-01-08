
---@type ns
local ADDON_NAME, ns = ...
local L = ns.L

---@class MeetingHornUIMainPanel
---@field private Browser MeetingHornUIBrowser
---@field private Manage MeetingHornManage
local MainPanel = ns.Addon:NewClass('UI.MainPanel', 'Frame')

local function TabOnClick(self)
    self:GetParent():UpdateTabFrames()
end

function MainPanel:Constructor()
    self.selectedTab = 1
    self.TitleText:SetText(L.ADDON_NAME .. ' ' .. ns.ADDON_VERSION)

    local function UpdateTabs()
        self:UpdateTabs()
        self:UpdateTabFrames()
    end

    local tabIndex = 0
    local function SetupTab(frame, text)
        tabIndex = tabIndex + 1
        local tab = self['Tab' .. tabIndex]
        tab:SetText(text)
        tab.frame = frame
        tab:HookScript('OnClick', UpdateTabs)
        tab:Show()
    end

    SetupTab(self.Browser, SEARCH)
    SetupTab(self.Manage, L['Manage'])

    pcall(function()
        local name = '\071\111\111\100\076\101\097\100\101\114'
        local addon = LibStub('AceAddon-3.0'):GetAddon(name, true)
        if addon then
            local L = LibStub('AceLocale-3.0'):GetLocale(name)
            local Frame = addon:GetClass('UI.' .. name):New(self)
            Frame:SetPoint('TOPLEFT', 4, -70)
            Frame:SetPoint('BOTTOMRIGHT', -6, 26)
            SetupTab(Frame, L.ADDON_NAME)
        end
    end)

    SetupTab(self.Options, L['Options'])

    self.portrait:SetTexture([[Interface\AddOns\MeetingHorn\Media\Logo]])

    self:SetAttribute('UIPanelLayout-enabled', true)
    self:SetAttribute('UIPanelLayout-defined', true)
    self:SetAttribute('UIPanelLayout-whileDead', true)
    self:SetAttribute('UIPanelLayout-area', 'left')
    self:SetAttribute('UIPanelLayout-pushable', 1)

    self:RegisterForDrag('LeftButton')
    self:SetScript('OnDragStart', self.StartMoving)
    self:SetScript('OnDragStop', self.StopMovingOrSizing)
    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)

    ns.UI.Browser:Bind(self.Browser)
    ns.UI.Creator:Bind(self.Manage.Creator)
    ns.UI.Applicant:Bind(self.Manage.Applicant)
    ns.UI.Options:Bind(self.Options.Options)
    ns.UI.Filters:Bind(self.Options.Filters)

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
                ns.LFG:SendServer('SFEEDBACK', content, ns.ADDON_VERSION)
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

    local PortraitParent = CreateFrame('Frame', nil, self)
    self.portrait:SetParent(PortraitParent)
    self.PortraitFrame:SetParent(PortraitParent)
    PortraitParent:SetFrameLevel(FeedBack:GetFrameLevel() + 10)

    self.FeedBack = FeedBack

    self:UpdateTabs()
    self:UpdateTabFrames()
    self:SetScript('OnClick', ns.FireHardWare)
end

function MainPanel:OnShow()
    self:SendMessage('MEETINGHORN_SHOW')
end

function MainPanel:OnHide()
    self:SendMessage('MEETINGHORN_HIDE')
end

function MainPanel:UpdateTabs()
    PanelTemplates_SetNumTabs(self, #self.Tabs)
    PanelTemplates_UpdateTabs(self)
end

function MainPanel:UpdateTabFrames()
    local current = PanelTemplates_GetSelectedTab(self)
    for i, tab in ipairs(self.Tabs) do
        if tab.frame then
            tab.frame:SetShown(i == current)
        end
    end
end

function MainPanel:SetTab(n)
    PanelTemplates_SetTab(self, n)
    self:UpdateTabFrames()
end
