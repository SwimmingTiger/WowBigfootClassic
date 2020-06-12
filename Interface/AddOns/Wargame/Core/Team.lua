-- Team.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/8/2020, 2:06:25 PM

---@type ns
local ns = select(2, ...)

---@type NeteaseWargameTeam
local Team = ns.Addon:NewClass('Team')

function Team:FromProto(name, win, lose, members)
    local team = Team:New()
    team.name = name
    team.win = win
    team.lose = lose
    team.members = {}

    for i, v in ipairs(members) do
        local member = ns.Member:FromProto(v)
        tinsert(team.members, member)
    end
    return team
end
