-- Rank.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/8/2020, 2:16:26 PM

---@type ns
local ns = select(2, ...)

ns.NewProto('Rank', {'rank', 'realm', 'name', 'win', 'lose', 'flagCount', 'faction'})
ns.NewProto('RankSolo', {'rank', 'realm', 'name', 'guild', 'class', 'race', 'faction', 'score'})
ns.NewProto('RankGuild', {'rank', 'realm', 'name', 'faction', 'score'})
