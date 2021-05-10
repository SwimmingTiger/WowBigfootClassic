-- Order.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/31/2019, 3:01:06 AM

---@type ns
local ns = select(2, ...)

---@class Order
local Order = ns.Addon:NewClass('Order')

function Order:Constructor(profile)
    self:RequestRebuild(profile)
end

function Order:GetOrder(item)
    error('Not implemented')
end

function Order._Meta:__call(item)
    if self.isDirty then
        self:Build()
        self.isDirty = nil
    end
    return self:GetOrder(item)
end

function Order:RequestRebuild(profile)
    profile = profile or self.profile

    if not self.isDirty or self.profile ~= profile then
        self.profile = profile
        self.isDirty = true
    end
end

function Order:Build()
    error('Not implemented')
end
