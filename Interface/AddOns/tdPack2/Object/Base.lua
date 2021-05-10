-- Base.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/30/2019, 11:42:31 PM

---@type ns
local ns = select(2, ...)

---@class Base
local Base = ns.Addon:NewClass('Base')

function Base:SetParent(parent)
    self.parent = parent
end

function Base:GetParent()
    return self.parent
end

Base.Constructor = Base.SetParent
