-- Member.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/8/2020, 1:07:12 PM

---@type ns
local ns = select(2, ...)

---@type NeteaseWargameMember
local Member = ns.Addon:NewClass('Member')

Member.FromProto = ns.GenerateFromProto('name', 'class', 'win', 'lose', 'guid')

function Member:IsOnline()
    return ns.Wargame:IsInGuild(self.guid)
end

function Member:GetClassColor()
    return ns.GetClassColor(self.class)
end

function Member:Invite()
    InviteToGroup(self.name)
end
