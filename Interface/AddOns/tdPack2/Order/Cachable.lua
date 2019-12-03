-- Cachable.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/27/2019, 1:04:22 AM

---@type ns
local ns = select(2, ...)

---- LUA
local wipe = table.wipe or wipe

local CachableOrder = ns.Addon:NewClass('CachableOrder', ns.Order)

function CachableOrder:Constructor(opts)
    self.cache = opts.cache or {}
    self.keyHandler = opts.GetKey
    self.orderHandler = opts.GetOrder
end

function CachableOrder:GetOrder(item)
    local key = self.keyHandler(item)
    local order = self.cache[key]

    if not order then
        order = self.orderHandler(item)
        self.cache[key] = order
    end
    return order
end

function CachableOrder:Build()
    wipe(self.cache)
end
