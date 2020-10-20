---@type ns
local ADDON_NAME, ns = ...
local L = ns.L

---@class NeteaseWargameUIRankPanel
---@field private Content NeteaseWargameUIMapCanvas
---@field private rankType RankType
local RankPanel = ns.Addon:NewClass('UI.RankPanel', 'Frame')

local FORCE_UPDATE_RANKS = {[ns.RANK.SOLO] = true}
local MAX_LIST_COLUMN_COUNT = 6

function RankPanel:Constructor()
    self.bgTex = {}
    self.titleTex = {}
    self.gameId = 0

    self.More:SetText(L['查看更多'])
    self.More:SetScript('OnClick', function()
        ns.CopyBox(L['请按<|cff00ff00Ctrl+C|r>复制网址到浏览器打开'], 'https://wow.blizzard.cn/rank')
    end)
    self.Content.Rank.Empty.Text:SetText(
        L['排行榜将在第一个比赛日结束后进行数据更新|n更多比赛信息请关注赛事新闻'])

    ns.UI.MapCanvas:Bind(self.Content.Canvas)
    ns.UI.ListView:Bind(self.Content.Rank.RankList)
    ns.GUI:GetClass('Dropdown'):Bind(self.Content.Info.Type)

    self.Content.Info.Type:SetCallback('OnSelectChanged', function(item)
        self.rankType = item.value
        self:UpdateHeader()
        self:RefreshList()
    end)

    self.Content.Rank.RankList:SetItemTemplate('NeteaseWargameRankTeamTemplate')
    self.Content.Rank.RankList:SetCallback('OnItemFormatting', function(_, button, item)
        self:SetButton(button, item)
    end)

    self:RegisterMessage('NETEASE_WARGAME_GAME_SELECTED')
    self:RegisterMessage('NETEASE_WARGAME_RANK_UPDATE')
    self:SetScript('OnShow', self.RefreshList)
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

local Columns = {
    [ns.RANK.SOLO] = {
        {header = L['排名'], width = 50, data = 'rank'}, {
            header = L['角色名称'],
            width = 230,
            data = function(item)
                return string.format('%s-%s', item.name, item.realm)
            end,
            color = function(item)
                return ns.GetClassColor(item.class)
            end,
        }, {
            header = L['种族'],
            width = 50,
            data = function(item)
                return ns.GetRaceName(item.race)
            end,
        }, {
            header = L['职业'],
            width = 60,
            data = function(item)
                return ns.GetClassName(item.class)
            end,
        }, {header = L['积分'], width = 60, data = 'score'},
    },
    [ns.RANK.GUILD] = {
        {header = L['排名'], width = 50, data = 'rank'}, --
        {header = L['服务器'], width = 90, data = 'realm'}, {
            header = L['公会名称'],
            width = 260,
            data = 'name',
            color = function(item)
                return ns.GetFactionColor(item.faction)
            end,
        }, --
        {header = L['积分'], width = 60, data = 'score'},
    },
    [ns.RANK.TEAM] = {
        {header = L['排名'], width = 50, data = 'rank'}, --
        {header = L['服务器'], width = 90, data = 'realm'}, {
            header = L['公会名 - 队伍编号'],
            width = 140,
            data = 'name',
            color = function(item)
                return ns.GetFactionColor(item.faction)
            end,
        }, {
            header = L['胜负场'],
            width = 60,
            data = function(item)
                return string.format('%s-%s', item.win, item.lose)
            end,
        }, {
            header = L['总场次'],
            width = 60,
            data = function(item)
                return item.win + item.lose
            end,
        }, {
            header = function(game)
                return game and game.zone == ns.ZONE.WSG and L['净胜旗'] or L['净胜点']
            end,
            width = 60,
            data = 'flagCount',
        },
    },
}

function RankPanel:UpdateHeader()
    for i = 1, MAX_LIST_COLUMN_COUNT do
        self.Content.Rank['Header' .. i]:Disable()
        self.Content.Rank['Header' .. i]:Hide()
    end

    local game = ns.Wargame:GetGame(self.gameId)
    local columns = Columns[self.rankType]

    for i, v in ipairs(columns) do
        self.Content.Rank['Header' .. i]:SetText(type(v.header) == 'string' and v.header or v.header(game))
        self.Content.Rank['Header' .. i]:SetWidth(v.width or 50)
        self.Content.Rank['Header' .. i]:Show()
    end
end

---@param item NeteaseWargameRankSoloItem|NeteaseWargameRankItem|NeteaseWargameRankGuildItem
function RankPanel:SetButton(button, item)
    local columns = Columns[self.rankType]

    for i = 1, MAX_LIST_COLUMN_COUNT do
        local label = button['Item' .. i]
        local v = columns[i]
        if not v then
            label:Hide()
        else

            if type(v.data) == 'string' then
                label:SetText(item[v.data])
            elseif type(v.data) == 'function' then
                label:SetText(v.data(item))
            else
                label:SetText('')
            end

            if not v.color then
                label:SetTextColor(HIGHLIGHT_FONT_COLOR:GetRGB())
            elseif type(v.color) == 'table' then
                -- label:SetTextColor(ns.rgb)
                error('error')
            elseif type(v.color) == 'function' then
                label:SetTextColor(v.color(item))
            end

            label:SetWidth(v.width)
            label:Show()
        end
    end
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

    -- type
    local types
    if game.templateId == ns.TEMPLATE.GUILD_GAME then
        types = {
            {text = L['队伍排行'], value = ns.RANK.TEAM}, --
            {text = L['公会排行'], value = ns.RANK.GUILD},
        }
    else
        types = {
            {text = L['个人排行'], value = ns.RANK.SOLO}, --
            {text = L['公会排行'], value = ns.RANK.GUILD},
        }
    end

    self.rankType = types[1].value
    self.selectedPage = self.Match
    self.Content.Info.Type:SetMenuTable(types)
    self.Content.Info.Type:SetValue(types[1].value)
    self:UpdateHeader()

    if self:IsVisible() then
        self:RefreshList()
    end
end

---@param game NeteaseWargameGame
function RankPanel:NETEASE_WARGAME_GAME_SELECTED(_, game)
    if self.gameId ~= game.id then
        self:Clear()
        self.gameId = game.id
        self:Update()
    end
end

function RankPanel:UpdateList()
    local list, myScore
    if self.rankType == ns.RANK.GUILD then
        list = ns.Wargame.guildRanks
    else
        local game = ns.Wargame.games[self.gameId]
        if game then
            list = game.ranks
            if self.rankType == ns.RANK.SOLO and game.rankSelf then
                myScore = game.rankSelf.score
            end
        end
    end

    if myScore then
        self.Content.Info.Score:SetText(string.format(L['我的积分：%s'], myScore))
        self.Content.Info.Score:Show()
    else
        self.Content.Info.Score:Hide()
    end

    if list then
        self.Content.Rank.RankList:SetItemList(list)
        self.Content.Rank.Empty:SetShown(#list == 0)
        ns.Addon:ShowLoading(false)
        return true
    end

    return false
end

function RankPanel:NETEASE_WARGAME_RANK_UPDATE(_, gameId)
    if self.gameId == gameId then
        self:UpdateList()
    end
end

function RankPanel:RefreshList()
    if not self:IsVisible() then
        return
    end

    if not FORCE_UPDATE_RANKS[self.rankType] and self:UpdateList() then
        return
    end

    ns.Addon:ShowLoading(L['排行榜数据加载中...'], true)
    ns.Wargame:QueryRank(self.gameId, self.rankType, true)
end
