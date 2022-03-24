-- Battle.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/13/2020, 12:10:30 PM
---@type ns
local ns = select(2, ...)

local Log = ns.Logger

---@class NeteaseWargameBattle
local Battle = ns.Addon:NewModule('Battle', 'AceEvent-3.0', 'AceTimer-3.0')
Battle:Disable()

function Battle:OnEnable()
    self.game = ns.Wargame.game

    if self.game.zone == ns.ZONE.WSG then
        self:RegisterEvent('BATTLEGROUND_POINTS_UPDATE', 'CommitPoints')
        self:ScheduleRepeatingTimer('CommitPoints', 300)
    elseif self.game.zone == ns.ZONE.AB then
        self:ScheduleRepeatingTimer('CommitPoints', 60)
    end
    self:RegisterEvent('UPDATE_BATTLEFIELD_SCORE')

    self:UpdateFaction()

    ns.Wargame:SendStartGameResult(true, 'entered')

    Log:Debug('Battle OnEnable', self.game.zone)
end

function Battle:OnDisable()
    ns.Wargame:SendStartGameResult(true, 'leaved')

    self.game = nil
    self.ally = nil
    self.enemy = nil
    self.done = nil

    Log:Debug('Battle OnDisable')
end

function Battle:UPDATE_BATTLEFIELD_SCORE()
    self:UpdateFaction()
    self:CommitWinner()
end

local function GetPointsFromUI(faction)
    local tooltip = faction == 0 and '部落状态' or '联盟状态'

    for _, frame in pairs(UIWidgetManager.widgetIdToFrame) do
        if frame.tooltip == tooltip then
            local text = frame.Text:GetText()
            local points, max = text:match('(%d+)/(%d+)')
            return tonumber(points), tonumber(max)
        end
    end
end

function Battle:GetBattlegroundPoints(faction)
    local points, max = GetBattlegroundPoints(faction)
    if max > 0 then
        return points, max
    end

    local ok, points, max = pcall(GetPointsFromUI, faction)
    if ok then
        return points or 0, max or 0
    end
    return 0, 0
end

function Battle:CommitPoints(event)
    if self.done then
        return
    end

    local allyPoints, allyMax = self:GetBattlegroundPoints(self.ally)
    local enemyPoints, enemyMax = self:GetBattlegroundPoints(self.enemy)
    local time = ns.time()

    Log:Debug('points', time, allyPoints, allyMax, enemyPoints, enemyMax, UnitInBattleground('player'))

    ns.Client:SendServer('CPOINTS', self.game.id, allyPoints, allyMax, enemyPoints, enemyMax, time, not not event,
                         GetNumGroupMembers(LE_PARTY_CATEGORY_INSTANCE))
end

function Battle:CommitWinner()
    if not self.ally or self.done then
        return
    end

    local winner = GetBattlefieldWinner()
    if winner then
        self:CommitPoints()
        ns.Client:SendServer('CWINNER', self.game.id, winner == self.ally, winner == self.enemy)

        Log:Debug('winner', self.game.id, winner == self.ally, winner == self.enemy)

        self.done = true
    end
end

function Battle:UpdateFaction()
    if self.ally then
        return
    end

    local ally = self:GetPlayerFaction()
    if not ally then
        RequestBattlefieldScoreData()
    else
        self.ally = ally
        self.enemy = ally == 0 and 1 or 0
    end
end

function Battle:GetPlayerFaction()
    for i = 1, GetNumBattlefieldScores() do
        local name, _, _, _, _, faction = GetBattlefieldScore(i)
        if name == UnitName('player') then
            return faction
        end
    end
end
