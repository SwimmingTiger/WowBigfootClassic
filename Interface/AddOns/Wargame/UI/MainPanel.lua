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
    self.maxTabWidth = 200

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
    ns.GUI:GetClass('Dropdown'):Bind(self.Page)

    local BlockDialog = ns.GUI:GetClass('BlockDialog'):New(self)
    BlockDialog:SetPoint('TOPLEFT', 3, -22)
    BlockDialog:SetPoint('BOTTOMRIGHT', -3, 3)
    BlockDialog:SetFrameStrata('FULLSCREEN_DIALOG')
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

    local pages = {
        {text = L['匹配'], value = self.Match}, --
        {text = L['队伍'], value = self.Team}, --
        {text = L['排行'], value = self.Rank},
    }

    self.Page:SetMenuTable(pages)
    self.Page:SetDefaultText(pages[1].text)
    self.Page:SetCallback('OnSelectChanged', function(item)
        for _, v in ipairs(pages) do
            v.value:SetShown(item.value == v.value)
        end
    end)
    self:SetPage(pages[1].value)

    self:RegisterMessage('SERVER_CONNECTED')
    self:RegisterMessage('NETEASE_WARGAME_GAMES_UPDATE')
end

function MainPanel:UpdateTabs()
    PanelTemplates_SetNumTabs(self, #self.Tabs)
    PanelTemplates_UpdateTabs(self)
end

function MainPanel:SetPage(page)
    self.Page:SetValue(page)
end

function MainPanel:ReturnMatch()
    self:SetPage(self.Match)
end

function MainPanel:CreateTabButton(id)
    local button = CreateFrame('Button', nil, self, 'NeteaseWargameTabButtonTemplate')
    button:SetPoint('LEFT', self.Tabs[id - 1], 'RIGHT', -18, 0)
    button:SetID(id)
    button:Hide()
    return button
end

---@param gameList NeteaseWargameGame[]
function MainPanel:SetupTabs(gameList)

    local function UpdateTabs(tab)
        self:UpdateTabs()
        self:ReturnMatch()
        self:SendMessage('NETEASE_WARGAME_GAME_SELECTED', tab.game)
    end

    local tabIndex = 1
    for i, game in ipairs(gameList) do
        local tab = self.Tabs[i] or self:CreateTabButton(tabIndex)
        tab:SetText(game.tabName)
        tab.game = game
        tab:HookScript('OnClick', UpdateTabs)
        tab:Show()
        tabIndex = tabIndex + 1
    end

    for i = tabIndex, #self.Tabs do
        self.Tabs[i]:Hide()
    end

    self.selectedTab = 1
    UpdateTabs(self.Tabs[1])
end

function MainPanel:SERVER_CONNECTED()
    ns.Addon:ShowLoading(L['比赛数据加载中...'], true)
end

function MainPanel:NETEASE_WARGAME_GAMES_UPDATE()
    self.FeedBackButton:Enable()

    if #ns.Wargame.gameList == 0 then
        ns.Addon:ShowLoading(L['暂无赛事'], false)
        return
    end

    -- tab
    self:SetupTabs(ns.Wargame.gameList)

    ns.Addon:ShowLoading(false)
end
