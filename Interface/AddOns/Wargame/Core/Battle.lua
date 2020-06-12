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
    self:RegisterEvent('BATTLEGROUND_POINTS_UPDATE', 'CommitPoints')
    self:ScheduleRepeatingTimer('CommitPoints', 300)
    self:UpdateFaction()

    ns.Wargame:SendStartGameResult(true, 'entered')

    Log:Debug('Battle OnEnable')
end

function Battle:OnDisable()
    ns.Wargame:SendStartGameResult(true, 'leaved')

    self.game = nil
    self.ally = nil
    self.enemy = nil

    Log:Debug('Battle OnDisable')
end

function Battle:CommitPoints(event)
    local allyPoints, allyMax = GetBattlegroundPoints(self.ally)
    local enemyPoints, enemyMax = GetBattlegroundPoints(self.enemy)
    local time = ns.time()

    Log:Debug('points', time, allyPoints, allyMax, enemyPoints, enemyMax, UnitInBattleground('player'))

    ns.Client:SendServer('CPOINTS', self.game.id, allyPoints, allyMax, enemyPoints, enemyMax, time, not not event,
                         GetNumGroupMembers(LE_PARTY_CATEGORY_INSTANCE))
end

function Battle:UpdateFaction()
    self.ally = self:GetPlayerFaction()

    if not self.ally then
        RequestBattlefieldScoreData()
        self:RegisterEvent('UPDATE_BATTLEFIELD_SCORE', 'UpdateFaction')
    else
        self.enemy = self.ally == 0 and 1 or 0
        self:UnregisterEvent('UPDATE_BATTLEFIELD_SCORE')
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
