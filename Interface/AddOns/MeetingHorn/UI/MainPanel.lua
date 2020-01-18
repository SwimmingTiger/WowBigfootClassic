
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

    self:SetupTabs({
        {L['Search Activity'], self.Browser}, --
        {L['Create Activity'], self.Manage}, --
        {L['Help'], self.Help}, --
        {L['Options'], self.Options}, --
    })

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

    self.Help.Text:SetText(L.HELP_COMMENT)

    ns.UI.Browser:Bind(self.Browser)
    ns.UI.Creator:Bind(self.Manage.Creator)
    -- ns.UI.Applicant:Bind(self.Manage.Applicant)
    ns.UI.Options:Bind(self.Options.Options)
    ns.UI.Filters:Bind(self.Options.Filters)
    ns.UI.Chat:Bind(self.Manage.Chat)

    self.Manage.Applicant:Hide()

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

    self:RegisterMessage('MEETINGHORN_CURRENT_CREATED')
    self:RegisterMessage('MEETINGHORN_CURRENT_CLOSED')
end

function MainPanel:OnShow()
    self:SendMessage('MEETINGHORN_SHOW')
end

function MainPanel:OnHide()
    self:SendMessage('MEETINGHORN_HIDE')
end

function MainPanel:MEETINGHORN_CURRENT_CREATED()
    self.Tabs[2]:SetText(L['Manage Activity'])
    PanelTemplates_UpdateTabs(self)
end

function MainPanel:MEETINGHORN_CURRENT_CLOSED()
    self.Tabs[2]:SetText(L['Create Activity'])
    PanelTemplates_UpdateTabs(self)
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

function MainPanel:SetupTabs(tabs)
    local function UpdateTabs()
        self:UpdateTabs()
        self:UpdateTabFrames()
    end

    local tabIndex = 0
    for i, v in ipairs(tabs) do
        tabIndex = tabIndex + 1
        local tab = self.Tabs[i] or self:CreateTabButton(tabIndex)
        tab:SetText(v[1])
        tab.frame = v[2]
        tab:HookScript('OnClick', UpdateTabs)
        tab:Show()
    end
end

function MainPanel:CreateTabButton(id)
    local button = CreateFrame('Button', nil, self, 'MeetingHornTabButtonTemplate')
    button:SetPoint('LEFT', self.Tabs[id - 1], 'RIGHT', -18, 0)
    button:SetID(id)
    return button
end
