-- Wargame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/8/2020, 9:39:02 AM

---@type ns
local ns = select(2, ...)

local L = ns.L
local Log = ns.Logger

---@type NeteaseWargameWargame
local Wargame = ns.Addon:NewModule('Wargame', 'AceEvent-3.0', 'AceBucket-3.0', 'AceTimer-3.0')

function Wargame:OnEnable()
    self.games = {}
    self.gameList = {}
    self.guildMembers = {}
    self.currentMatch = {}

    self:RegisterEvent('GROUP_ROSTER_UPDATE')
    self:RegisterEvent('GUILD_ROSTER_UPDATE')
    self:RegisterEvent('UNIT_CONNECTION', 'GROUP_ROSTER_UPDATE')
    self:RegisterMessage('SERVER_CONNECTED', 'StartHourTimer')

    self:RegisterBucketEvent({'PLAYER_ENTERING_BATTLEGROUND', 'PLAYER_ENTERING_WORLD'}, 1, 'PLAYER_ENTERING_WORLD')
end

function Wargame:RefreshGuild()
    GuildRoster()
end

function Wargame:GROUP_ROSTER_UPDATE()
    if self.game and not self.roomId and not IsWargame() then
        if self:SnapshotTeam() ~= self.matchingShot then
            self:CancelMatch(self.game.id, true)
        end
    end
end

function Wargame:GUILD_ROSTER_UPDATE()
    wipe(self.guildMembers)

    local total = GetNumGuildMembers()

    for i = 1, total do
        local _, _, _, _, _, _, _, _, online, _, _, _, _, _, _, _, guid = GetGuildRosterInfo(i)
        if online then
            self.guildMembers[ns.ShortGuid(guid)] = true
        end
    end

    self:SendMessage('NETEASE_WARGAME_GUILD_MEMBER_UPDATE')
end

function Wargame:PLAYER_ENTERING_WORLD()
    Log:Debug('PLAYER_ENTERING_WORLD', self.game)
    if self.zoneCheckTimer then
        self.zoneCheckTimer:Cancel()
    end

    self.zoneCheckTimer = C_Timer.NewTicker(1, function()
        Log:Debug('zoneCheckTimer', IsWargame())
        if IsWargame() then
            ns.Battle:Enable()
        else
            ns.Battle:Disable()
        end
        self.zoneCheckTimer = nil
    end, 20)
end

function Wargame:RecvGames(games)
    wipe(self.games)
    wipe(self.gameList)

    for _, p in ipairs(games) do
        ---@type NeteaseWargameGame
        local game = ns.Game:FromProto(p)
        --[===[@debug@
        game.rules = 2
        --@end-debug@]===]

        self.games[game.id] = game
        tinsert(self.gameList, game)
    end

    self:SendMessage('NETEASE_WARGAME_GAMES_UPDATE')
end

function Wargame:RecvTeam(error, gameId, teamName, win, lose, members)
    local game = self.games[gameId]
    if not game then
        return
    end

    if error == 0 then
        game.team = ns.Team:FromProto(teamName, win, lose, members)
    end

    self:SendMessage('NETEASE_WARGAME_TEAM_UPDATE', error, gameId)
end

function Wargame:RecvRank(gameId, ranks, rankSelf, updateTime)
    local game = self.games[gameId]
    if not game then
        return
    end

    game.rankUpdateTime = updateTime
    game.ranks = {}

    for i, v in ipairs(ranks) do
        tinsert(game.ranks, ns.Rank:FromProto(v))
    end

    game.rankSelf = ns.Rank:FromProto(rankSelf)

    self:SendMessage('NETEASE_WARGAME_RANK_UPDATE', gameId)
end

function Wargame:RecvMatch(error, gameId, battleTag, target, isMaster, errorData, roomId)
    local game = self.games[gameId]
    if not game then
        return
    end

    if error == 0 then
        self.game = game
        self.roomId = roomId

        if isMaster then
            ns.Master:Start(gameId, battleTag, target)
        else
            ns.Minion:Start(gameId, battleTag, target)
        end
    else
        self.game = nil
        self.roomId = nil
        SendChatMessage(L['当前队伍已经离开匹配队列'], 'RAID_WARNING')
    end

    self:SendMessage('NETEASE_WARGAME_MATCH_START', error, gameId, errorData)
end

function Wargame:RecvMatchCancel(error, gameId)
    local game = self.games[gameId]
    if not game then
        return
    end

    if error == 0 then
        self.game = nil
        self.roomId = nil
        SendChatMessage(L['当前队伍已经离开匹配队列'], 'RAID_WARNING')
    end

    self:SendMessage('NETEASE_WARGAME_MATCH_CANCEL', error, gameId)
end

function Wargame:RecvBattleFinish(gameId, error, roomId, teamName)
    local game = self.games[gameId]
    if not game then
        return
    end

    local isSameRoom = not self.roomId or self.roomId == roomId
    if error == 0 then
        game.roundCount = game.roundCount + 1
    end

    if isSameRoom then
        self.game = nil
        self.roomId = nil
    end

    local msg
    if error == 0 then
        if teamName and teamName ~= '' then
            msg = isSameRoom and string.format(
                      L['比赛结束|n本场比赛已经记录战绩，最后获胜的战队为|cff00ff00%s|r，双方现在可以退出战场'],
                      teamName) or
                      string.format(
                          L['比赛结束|n上一场比赛已经记录战绩，最后获胜的战队为|cff00ff00%s|r'],
                          teamName)
        else
            msg = isSameRoom and L['比赛结束|n本场比赛结果为双败，双方现在可以退出战场'] or
                      L['比赛结束|n上一场比赛结果为双败，双方现在可以退出战场']
        end
    else
        msg = ns.GetError(error)
    end

    if isSameRoom then
        ns.MsgBox(msg)
    else
        ns.Message(msg)
    end

    self:SendMessage('NETEASE_WARGAME_BATTLE_FINISH', error, gameId, isSameRoom)
end

function Wargame:Match(gameId)
    if self.game then
        return false, L['正在匹配']
    end

    local game = self.games[gameId]
    if not game then
        return false, L['未找到比赛']
    end

    if BNGetNumFriends() >= 200 then
        return false, L['战网好友列表已满']
    end

    local count = ns.GetNumGroupMembers()
    if count ~= game.combatCount then
        return false, L['参加比赛必须为%d人']:format(game.combatCount)
    end

    if not UnitIsGroupLeader('player') then
        return false, L['你不是队长']
    end

    local isSameGuild = game:HasRule(ns.RULE.SameGuild)
    local isMaxLevel = game:HasRule(ns.RULE.MaxPlayerLevel)
    local members = {}

    for _, unit in ns.IterateGroupUnits() do
        if UnitExists(unit) then
            if not UnitIsConnected(unit) then
                return false, L['队伍不能有离线成员']
            end

            local guid = ns.UnitShortGuid(unit)
            if isSameGuild and not self:IsInGuild(guid) then
                return false, L['所有参赛人员必需相同公会']
            end

            local level = UnitLevel(unit)
            if isMaxLevel and level ~= ns.MAX_PLAYER_LEVEL then
                return false, L['所有参赛人员等级必需为%d']:format(ns.MAX_PLAYER_LEVEL)
            end

            local name = UnitName(unit)
            local class = ns.UnitClass(unit)

            local member = {name, class, nil, nil, guid}

            tinsert(members, member)
        end
    end

    local guildName = GetGuildInfo('player')

    self.game = game
    self.roomId = nil
    self.matchingShot = self:SnapshotTeam()

    SendChatMessage(L['我已开始匹配，请中途不要退队或者离线'], 'RAID_WARNING')

    ns.Client:SendServer('CMATCH', gameId, members, guildName, ns.GetBattleTag())
    return true
end

function Wargame:CancelMatch(gameId, force)
    ns.Client:SendServer('CMATCHCANCEL', gameId, force)
end

function Wargame:IsInGuild(guid)
    return self.guildMembers[guid]
end

function Wargame:QueryTeam(gameId, force)
    local game = self.games[gameId]
    if not game then
        return
    end

    if game.members and not force then
        return
    end

    ns.Client:SendServer('CTEAM', gameId)
end

function Wargame:QueryRank(gameId, force)
    local game = self.games[gameId]
    if not game then
        return
    end

    if game.ranks and not force then
        return
    end

    ns.Client:SendServer('CRANK', gameId)
end

function Wargame:GetGame(gameId)
    return self.games[gameId]
end

function Wargame:SnapshotTeam()
    local members = {}
    local leader

    for i, unit in ns.IterateGroupUnits() do
        if UnitExists(unit) and UnitIsConnected(unit) then
            if UnitIsGroupLeader(unit) then
                leader = ns.UnitShortGuid(unit)
            else
                tinsert(members, ns.UnitShortGuid(unit))
            end
        end
    end

    sort(members)
    if leader then
        tinsert(members, 1, leader)
    end
    return table.concat(members, '/')
end

function Wargame:SendStartGameResult(ok, reason)
    if not self.game then
        return
    end
    if reason == 'leaved' then
        ns.Client:SendServer('CLEAVEBATTLE', self.game.id)
        self.game = nil
        self:SendMessage('NETEASE_WARGAME_LEAVE_BATTLE')
    else
        ns.Client:SendServer('CBATTLE', self.game.id, ok, reason)
    end
end

function Wargame:OnHourTimer()
    local now = ns.time()
    for id, game in pairs(self.games) do
        if game:IsInProgress() then
            ns.Message(L['%s%s正在进行，|cff00ffff%s|r'], game:GetZoneText(), game.title,
                       ns.GameToLink(game.id, L['点击查看']))
        else
            local nextStartTime = game:GetNextStartTime()
            if nextStartTime then
                local diff = nextStartTime - now
                if diff > 0 and diff < game.noticeTime * 3600 + 5 * 60 then
                    ns.Message(L['%s%s将在%s后开启，|cff00ffff%s|r'], game:GetZoneText(), game.title,
                               SecondsToTime(diff, true), ns.GameToLink(game.id, L['点击查看']))
                end
            end
        end
    end
end

function Wargame:StartHourTimer()
    local now = ns.date('*t')
    local nextHour = ns.time{year = now.year, month = now.month, day = now.day, hour = now.hour + 1, min = 0, sec = 0}
    local diff = nextHour - ns.time()

    --[===[@debug@
    print(now)
    print(nextHour)
    print(diff)
    --@end-debug@]===]

    self:ScheduleTimer(function()
        self:OnHourTimer()
        self:StartHourTimer()
    end, diff)
end

---是否正在比赛中
function Wargame:IsInBattle()
    return self.game and self.roomId
end
