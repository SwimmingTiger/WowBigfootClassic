-- Client.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/7/2020, 9:57:40 AM
---@type ns
local ns = select(2, ...)

---@type NeteaseWargameClient
local Client = ns.Addon:NewModule('Client', 'AceEvent-3.0', 'LibCommSocket-3.0')

function Client:OnEnable()
    self:ListenSocket('NeteaseWargame')
    self:ConnectServer('S1' .. UnitFactionGroup('player'))

    self:RegisterServer('SERVER_CONNECTED')
    self:RegisterServer('SLOGIN')
    self:RegisterServer('SGAMES')
    self:RegisterServer('STEAM')
    self:RegisterServer('SRANK')
    self:RegisterServer('SMATCHCANCEL')
    self:RegisterServer('SMATCH')
    self:RegisterServer('SBATTLEFINISH')
    self:RegisterServer('SRANKGUILD')
    self:RegisterServer('SRANKSOLO')
    self:RegisterServer('STEAMRENAME')
    self:RegisterServer('SNEWVERSION')
end

function Client:SERVER_CONNECTED()
    self:SendMessage('SERVER_CONNECTED')
    self:SendServer('CLOGIN', ns.ADDON_VERSION, ns.UnitShortGuid('player'), UnitLevel('player'), ns.UnitClass('player'),
                    ns.GetBattleTag(), ns.UnitRace('player'), (GetGuildInfo('player')))
end

function Client:SLOGIN(_, id)
    self.serverId = id
    local sendServer = self.SendServer
    self.SendServer = function(s, cmd, ...)
        if self.serverId then
            cmd = cmd .. '.' .. self.serverId
        end
        ns.Logger:Debug('Send', cmd, ...)
        sendServer(s, cmd, ...)
    end
end

function Client:SNEWVERSION(_, version, updateType)
    return ns.Wargame:RecvNewVersion(version, updateType ~= 2)
end

function Client:SGAMES(_, games)
    return ns.Wargame:RecvGames(games)
end

function Client:SMATCH(_, error, gameId, battleTag, target, isMaster, ...)
    ns.Wargame:RecvMatch(error, gameId, battleTag, target, isMaster, ...)
end

function Client:STEAM(_, error, gameId, teamName, members, win, lose, renameCount)
    ns.Wargame:RecvTeam(error, gameId, teamName, win, lose, members, renameCount)
end

function Client:SRANK(_, error, gameId, ranks, rankSelf, updateTime)
    if error ~= 0 then
        return
    end

    ns.Wargame:RecvRank(gameId, ranks, rankSelf, updateTime)
end

function Client:SRANKSOLO(_, error, gameId, ranks, rankSelf, updateTime)
    if error ~= 0 then
        return
    end

    ns.Wargame:RecvRankSolo(gameId, ranks, rankSelf, updateTime)
end

function Client:SRANKGUILD(_, error, gameId, ranks, rankSelf, updateTime)
    if error ~= 0 then
        return
    end

    ns.Wargame:RecvRankGuild(gameId, ranks, rankSelf, updateTime)
end

function Client:SMATCHCANCEL(_, error, gameId)
    ns.Wargame:RecvMatchCancel(error, gameId)
end

function Client:Feedback(content)
    self:SendServer('CFEEDBACK', ns.ADDON_VERSION, content)
end

function Client:SBATTLEFINISH(_, gameId, error, roomId, teamName)
    ns.Wargame:RecvBattleFinish(gameId, error, roomId, teamName)
end

function Client:STEAMRENAME(_, gameId, error, teamName)
    ns.Wargame:RecvTeamRename(gameId, error, teamName)
end
