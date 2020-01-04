-- MainPanel.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 12/11/2019, 9:38:00 AM

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

    local GoodLeader = LibStub('AceAddon-3.0'):GetAddon('GoodLeader', true)
    if GoodLeader then
        local L = LibStub('AceLocale-3.0'):GetLocale('GoodLeader')
        local frame = GoodLeader:GetClass('UI.GoodLeader'):New(self)
        frame:ClearAllPoints()
        frame:SetPoint('TOPLEFT', 4, -70)
        frame:SetPoint('BOTTOMRIGHT', -6, 26)
        SetupTab(frame, L.ADDON_NAME)
    end

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

    ns.UI.Browser:Bind(self.Browser)
    ns.UI.Creator:Bind(self.Manage.Creator)
    ns.UI.Applicant:Bind(self.Manage.Applicant)
    ns.UI.Options:Bind(self.Options)

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
