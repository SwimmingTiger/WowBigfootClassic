---@type ns
local ADDON_NAME, ns = ...
local L = ns.L

---@class NeteaseWargameUITeamPanel
---@field private Content NeteaseWargameUIMapCanvas
local TeamPanel = ns.Addon:NewClass('UI.TeamPanel', 'Frame')

function TeamPanel:Constructor()
    self.bgTex = {}
    self.titleTex = {}
    self.gameId = 0

    self.Canvas = self.ContentBg.Canvas

    local alliance = UnitFactionGroup('player') == 'Alliance'
    local tex = alliance and 'nw-icon-alliance' or 'nw-icon-horde'
    local texture = self.Canvas:CreateTexture(nil, 'ARTWORK', tex)
    texture:SetSize(32, 32)
    texture:SetPoint('TOPLEFT', 20, -28)
    texture:SetPoint('BOTTOMRIGHT', -468, 288)

    self.Content.Info.Server:SetText(GetRealmName())
    self.Content.Info.Rename:SetText(L['改名'])
    self.Content.Team.Header1:SetText(L['名字'])
    self.Content.Team.Header2:SetText(L['胜负场'])
    self.Content.Team.Header3:SetText(L['状态'])
    self.Content.Team.Header4:SetText(L['操作'])
    self.Content.Team.Empty.Text:SetText(L.TEAM_CREATE_RULE)
    self.Content.Team.Header1:Disable()
    self.Content.Team.Header2:Disable()
    self.Content.Team.Header3:Disable()
    self.Content.Team.Header4:Disable()

    self.RecentContent.Recent.Header1:SetText(L['名字'])
    self.RecentContent.Recent.Header2:SetText(L['职业'])
    self.RecentContent.Recent.Header3:SetText(L['种族'])
    self.RecentContent.Recent.Header4:SetText(L['操作'])
    self.RecentContent.Recent.Header1:Disable()
    self.RecentContent.Recent.Header2:Disable()
    self.RecentContent.Recent.Header3:Disable()
    self.RecentContent.Recent.Header4:Disable()

    self.RecentContent.Info.Title:SetText(L['最近匹配过的玩家'])
    self.RecentContent.Info.Server:SetText(GetRealmName())

    ns.UI.MapCanvas:Bind(self.Canvas)
    ns.UI.ListView:Bind(self.Content.Team.TeamList)

    self.Content.Info.Rename:SetScript('OnClick', function()
        self:OnRenameClick()
    end)

    self.Content.Team.TeamList:SetItemTemplate('NeteaseWargameTeamMemberTemplate')
    ---@param item NeteaseWargameMember
    self.Content.Team.TeamList:SetCallback('OnItemFormatting', function(_, button, item)
        button.Name:SetText(item.name)
        button.Name:SetTextColor(item:GetClassColor())
        button.Wins:SetText(string.format('%s-%s', item.win, item.lose))
        button.Status:SetText(item:IsOnline() and L['在线'] or '--')
    end)
    ---@param member NeteaseWargameMember
    self.Content.Team.TeamList:SetCallback('OnItemInviteClick', function(_, button, member)
        member:Invite()
    end)

    ns.UI.ListView:Bind(self.RecentContent.Recent.RecentList)

    self.RecentContent.Recent.RecentList:SetItemTemplate('NeteaseWargameTeamMemberTemplate')
    ---@param item NeteaseWargameRecentItem
    self.RecentContent.Recent.RecentList:SetCallback('OnItemFormatting', function(_, button, item)
        button.Name:SetText(item.name)
        button.Name:SetTextColor(ns.GetClassColor(item.class))
        button.Wins:SetText(ns.GetClassName(item.class))
        button.Status:SetText(ns.GetRaceName(item.race))
    end)
    ---@param member NeteaseWargameRecentItem
    self.RecentContent.Recent.RecentList:SetCallback('OnItemInviteClick', function(_, button, item)
        InviteToGroup(item.name)
    end)

    self:RegisterMessage('NETEASE_WARGAME_GAME_SELECTED')
    self:RegisterMessage('NETEASE_WARGAME_TEAM_UPDATE')
    self:RegisterMessage('NETEASE_WARGAME_BATTLE_FINISH')
    self:RegisterMessage('NETEASE_WARGAME_GUILD_MEMBER_UPDATE')
    self:SetScript('OnShow', self.OnShow)
end

function TeamPanel:Clear()
    for _, tex in pairs(self.bgTex) do
        tex:Hide()
    end

    for _, tex in pairs(self.titleTex) do
        tex:Hide()
    end

    self.Canvas:Clear()
    self.Banner.Mode:SetText('')
    self.Banner.Time:SetText('')
    self.Content.Info.TeamName:SetText('')
    self.Content.Info.Progress:SetText('')
    self.Content.Info.Win:SetText('')
    self.gameId = 0
end

function TeamPanel:OnRenameClick()
    ns.InputBox(L['请输入队伍名'], function(text, gameId)
        ns.Wargame:RenameTeam(gameId, text)
    end, 7, self.gameId)
end

function TeamPanel:Update()
    local game = ns.Wargame.games[self.gameId]
    if not game then
        return
    end

    self.Banner.Mode:SetText(string.format(L['比赛模式：%s'], game.mode))
    self.Banner.Time:SetText(game:GetStartTimeText())

    local texName = 'nw-banner-' .. game.zone
    local tex = self.bgTex[texName]
    if not tex then
        tex = self.Banner:CreateTexture(nil, 'BACKGROUND', texName)
        tex:SetAllPoints()
        self.bgTex[texName] = tex
    end
    tex:Show()

    local texName = 'NeteaseWargameSmallTitleTexture' .. game.zone
    local tex = self.titleTex[texName]
    if not tex then
        tex = CreateFrame('Frame', nil, self, texName)
        tex:SetPoint('TOP', 0, 45)
        self.titleTex[texName] = tex
    end
    tex:Show()
    tex.Text:SetText(game.title)

    -- 地图
    self.Canvas:SetMapID(game.zone)

    self.Content.Info.Progress:SetText(string.format(L['完成场次：%s/%s'], game.roundCount or 0,
                                                     game.maxRoundCount or 0))
end

function TeamPanel:UpdateRecent()
    local recents = ns.Recent:GetRecents(self.gameId)
    if recents and #recents > 0 then
        self.RecentContent.Recent.RecentList:SetItemList(recents)
        self.RecentContent.Recent.RecentList:Show()
        self.RecentContent.Recent.Empty:Hide()
    else
        self.RecentContent.Recent.RecentList:Hide()
        self.RecentContent.Recent.Empty:Show()
    end
end

---@param game NeteaseWargameGame
function TeamPanel:NETEASE_WARGAME_GAME_SELECTED(_, game)
    self:Clear()
    self.gameId = game.id
    self:Update()
end

function TeamPanel:NETEASE_WARGAME_TEAM_UPDATE(_, error, gameId)
    if self.gameId ~= gameId then
        return
    end

    ns.Addon:ShowLoading(false)

    local team = ns.Wargame.games[gameId].team
    if not team or not team.members or #team.members == 0 then
        self.Content.Team.Empty:Show()
        self.Content.Info.Rename:Hide()
        self.Content.Team.TeamList:Hide()
        return
    end

    self.Content.Info.TeamName:SetText(team.name)
    self.Content.Info.Win:SetText(string.format(L['|cffffffff%s|r胜 |cffffffff%s|r|cffff0000负|r'], team.win,
                                                team.lose))
    self.Content.Team.TeamList:SetItemList(team.members)
    self.Content.Team.TeamList:Show()
    self.Content.Team.Empty:Hide()
    self.Content.Info.Rename:Show()
    self.Content.Info.Rename:SetEnabled(team:CanRename())
end

function TeamPanel:OnShow()
    local game = ns.Wargame.games[self.gameId]
    if game then
        if game.templateId == ns.TEMPLATE.GUILD_GAME then
            self.RecentContent:Hide()
            self.Content:Show()

            ns.Addon:ShowLoading(L['队伍数据加载中...'], true)
            ns.Wargame:QueryTeam(self.gameId, false)
        else
            self.RecentContent:Show()
            self.Content:Hide()

            self:UpdateRecent()
        end
    end
end

function TeamPanel:NETEASE_WARGAME_BATTLE_FINISH(_, error, gameId, isSameRoom)
    if self.gameId ~= gameId then
        return
    end

    local game = ns.Wargame.games[self.gameId]
    if not game then
        return
    end

    game.team = nil
    if self:IsShown() then
        self:OnShow()
    end
    self:Update()
end

function TeamPanel:NETEASE_WARGAME_GUILD_MEMBER_UPDATE()
    self.Content.Team.TeamList:Refresh()
end
