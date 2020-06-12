---@type ns
local ADDON_NAME, ns = ...
local L = ns.L

---@class NeteaseWargameUIRankPanel
---@field private Content NeteaseWargameUIMapCanvas
local RankPanel = ns.Addon:NewClass('UI.RankPanel', 'Frame')

function RankPanel:Constructor()
    self.bgTex = {}
    self.titleTex = {}
    self.gameId = 0

    self.Content.Rank.Header1:SetText(L['排名'])
    self.Content.Rank.Header2:SetText(L['服务器'])
    self.Content.Rank.Header3:SetText(L['公会名 - 队伍编号'])
    self.Content.Rank.Header4:SetText(L['胜负场'])
    self.Content.Rank.Header5:SetText(L['总场次'])
    self.Content.Rank.Header6:SetText(L['净胜旗'])
    self.Content.Rank.Header1:Disable()
    self.Content.Rank.Header2:Disable()
    self.Content.Rank.Header3:Disable()
    self.Content.Rank.Header4:Disable()
    self.Content.Rank.Header5:Disable()
    self.Content.Rank.Header6:Disable()

    self.More:SetText(L['查看更多'])
    self.More:SetScript('OnClick', function()
        ns.InputBox(L['请按<|cff00ff00Ctrl+C|r>复制网址到浏览器打开'], 'https://wow.blizzard.cn/rank')
    end)
    self.Content.Rank.Empty.Text:SetText(
        L['排行榜将在第一个比赛日结束后进行数据更新|n更多比赛信息请关注赛事新闻'])

    ns.UI.MapCanvas:Bind(self.Content.Canvas)
    ns.UI.ListView:Bind(self.Content.Rank.RankList)

    self.Content.Rank.RankList:SetItemTemplate('NeteaseWargameRankTeamTemplate')

    ---@param item NeteaseWargameRankItem
    self.Content.Rank.RankList:SetCallback('OnItemFormatting', function(_, button, item)
        button.Rank:SetText(item.rank)
        button.Realm:SetText(item.realm)
        button.Team:SetText(item.name)
        button.Team:SetTextColor(GetFactionColor(item.faction):GetRGB())
        button.Score:SetText(string.format('%s-%s', item.win, item.lose))
        button.Total:SetText(item.win + item.lose)
        button.Wins:SetText(item.flagCount)
    end)

    self:RegisterMessage('NETEASE_WARGAME_GAME_SELECTED')
    self:RegisterMessage('NETEASE_WARGAME_RANK_UPDATE')
    self:SetScript('OnShow', self.OnShow)
end

function RankPanel:Clear()
    for _, tex in pairs(self.bgTex) do
        tex:Hide()
    end

    for _, tex in pairs(self.titleTex) do
        tex:Hide()
    end

    self.Content.Canvas:Clear()
    self.Banner.Mode:SetText('')
    self.Banner.Time:SetText('')
    self.gameId = 0
end

function RankPanel:Update()
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
    self.Content.Canvas:SetMapID(game.zone)
end

---@param game NeteaseWargameGame
function RankPanel:NETEASE_WARGAME_GAME_SELECTED(_, game)
    self:Clear()
    self.gameId = game.id
    self:Update()
end

function RankPanel:NETEASE_WARGAME_RANK_UPDATE(_, gameId)
    local game = ns.Wargame.games[self.gameId]
    if not game or not game.ranks then
        return
    end

    self.Content.Rank.RankList:SetItemList(game.ranks)
    self.Content.Rank.Empty:SetShown(#game.ranks == 0)
    ns.Addon:ShowLoading(false)
end

function RankPanel:OnShow()
    local game = ns.Wargame.games[self.gameId]
    if game and game.ranks then
        ns.Addon:ShowLoading(false)
    else
        ns.Addon:ShowLoading(L['排行榜数据加载中...'], true)
        ns.Wargame:QueryRank(self.gameId, false)
    end
end
