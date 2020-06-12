-- Rank.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/8/2020, 2:16:26 PM

---@type ns
local ns = select(2, ...)

---@type NeteaseWargameRankItem
local Rank = ns.Addon:NewClass('Rank')

Rank.FromProto = ns.GenerateFromProto('rank', 'realm', 'name', 'win', 'lose', 'flagCount', 'faction')
