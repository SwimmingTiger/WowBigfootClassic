-- Compat.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/20/2019, 1:24:08 AM

if true then
    return
end

---@type ns
local ns = select(2, ...)
local Addon = ns.Addon

_G.SortBags = Addon:Generate(ns.COMMAND.BAG)
_G.SortBankBags = Addon:Generate(ns.COMMAND.BANK)
