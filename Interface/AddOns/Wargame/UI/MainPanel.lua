---@type ns
local ADDON_NAME, ns = ...
local L = ns.L

---@class NeteaseWargameUIMainPanel
---@field private Match NeteaseWargameUIMatchPanel
---@field private Team NeteaseWargameUITeamPanel
---@field private Rank NeteaseWargameUIRankPanel
---@field Loading NeteaseWargameUILoadingPanel
local MainPanel = ns.Addon:NewClass('UI.MainPanel', 'Frame')

function MainPanel:Constructor()

    self.TitleText:SetText(L.ADDON_NAME .. ' ' .. ns.ADDON_VERSION)

    ButtonFrameTemplate_HidePortrait(self)

    self:SetAttribute('UIPanelLayout-enabled', true)
    self:SetAttribute('UIPanelLayout-defined', true)
    self:SetAttribute('UIPanelLayout-whileDead', true)
    self:SetAttribute('UIPanelLayout-area', 'left')
    self:SetAttribute('UIPanelLayout-pushable', 1)

    self:RegisterForDrag('LeftButton')
    self:SetScript('OnDragStart', self.StartMoving)
    self:SetScript('OnDragStop', self.StopMovingOrSizing)

    -- binds
    ns.UI.MatchPanel:Bind(self.Match)
    ns.UI.TeamPanel:Bind(self.Team)
    ns.UI.RankPanel:Bind(self.Rank)
    ns.UI.LoadingPanel:Bind(self.Loading)

    local BlockDialog = ns.GUI:GetClass('BlockDialog'):New(self)
    BlockDialog:SetPoint('TOPLEFT', 3, -22)
    BlockDialog:SetPoint('BOTTOMRIGHT', -3, 3)
    BlockDialog:SetFrameLevel(self:GetFrameLevel() + 100)
    self.BlockDialog = BlockDialog

    self.FeedBackButton:SetScript('OnClick', function()
        self.BlockDialog:Open({
            text = L['反馈'],
            acceptText = SUBMIT,
            editBox = true,
            OnAccept = function(_, content)
                ns.Client:Feedback(content)
                ns.Message(L['反馈提交成功'])
            end,
            editText = L.FEEDBACK_TPL,
            maxLetter = 480,
        })
        self.BlockDialog.EditBox:Enable()
    end)
    self.FeedBackButton:SetScript('OnEnter', function(button)
        GameTooltip:SetOwner(button, 'ANCHOR_TOPRIGHT')
        GameTooltip:SetText(L['反馈'])
        GameTooltip:Show()
    end)
    self.FeedBackButton:SetScript('OnLeave', GameTooltip_Hide)
    self.FeedBackButton:Disable()

    self:RegisterMessage('SERVER_CONNECTED')
    self:RegisterMessage('NETEASE_WARGAME_GAMES_UPDATE')
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

function MainPanel:CreateTabButton(id)
    local button = CreateFrame('Button', nil, self, 'NeteaseWargameTabButtonTemplate')
    button:SetPoint('LEFT', self.Tabs[id - 1], 'RIGHT', -18, 0)
    button:SetID(id)
    return button
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

function MainPanel:SERVER_CONNECTED()
    ns.Addon:ShowLoading(L['比赛数据加载中...'], true)
end

function MainPanel:NETEASE_WARGAME_GAMES_UPDATE()
    self.FeedBackButton:Enable()

    ---@type NeteaseWargameGame
    local game = ns.Wargame.gameList[1]
    if not game then
        ns.Addon:ShowLoading(L['暂无赛事'], false)
        return
    end

    -- tab
    self.selectedTab = 1
    self:SetupTabs({
        {L['匹配'], self.Match}, --
        {L['队伍'], self.Team}, --
        {L['排行'], self.Rank}, --
    })

    self:UpdateTabs()
    self:UpdateTabFrames()
    ns.Addon:ShowLoading(false)

    self:SendMessage('NETEASE_WARGAME_GAME_SELECTED', game)
end
