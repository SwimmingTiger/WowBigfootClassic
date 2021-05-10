-- Sorting.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/10/2019, 11:02:51 AM

local tinsert, wipe = table.insert, table.wipe or wipe
local ipairs = ipairs

---@type ns
local ns = select(2, ...)

local Pack = ns.Pack

---@class Sorting: Task
---@field private bags Bag[]
local Sorting = ns.Addon:NewClass('Sorting', ns.Task)

function Sorting:Constructor()
    self.bags = {}
end

function Sorting:Prepare()
    for _, bagType in ipairs(ns.BAG_TYPES) do
        if Pack:IsOptionBag(bagType) then
            local bag = Pack:GetBag(bagType)
            tinsert(self.bags, bag)
            bag:Sort()
        end
    end
    return #self.bags == 0
end

function Sorting:Finish()
    wipe(self.bags)
end

function Sorting:Process()
    local complete = true
    for _, bag in ipairs(self.bags) do
        if not bag:Pack() then
            complete = false
        end
    end
    return complete
end
