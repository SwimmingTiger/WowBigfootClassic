-- Stacking.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/10/2019, 10:38:31 AM

---- LUA
local pairs = pairs
local tinsert, tremove, wipe = table.insert, table.remove, table.wipe or wipe

---@type ns
local ns = select(2, ...)
local ripairs = ns.ripairs

local BAG_TYPE = ns.BAG_TYPE

---@type Pack
local Pack = ns.Pack

---@class Stacking
---@field private bags table<string, Slot[]>
---@field private stackingSlots table<number, Slot>
local Stacking = ns.Addon:NewClass('Stacking', ns.Task)

function Stacking:Constructor()
    self.bags = {}
    self.stackingSlots = {}
end

function Stacking:Prepare()
    self:InitBag(Pack:GetBag(BAG_TYPE.BAG))
    self:InitBag(Pack:GetBag(BAG_TYPE.BANK))
end

---@param bag Bag
function Stacking:InitBag(bag)
    if not bag then
        return
    end

    local key = ns.Addon:GetOption('stackTogether') and '-' or bag
    self.bags[key] = self.bags[key] or {}

    for _, group in bag:IterateGroups() do
        for i = 1, group:GetSlotCount() do
            tinsert(self.bags[key], group:GetSlot(i))
        end
    end
end

function Stacking:Finish()
    wipe(self.bags)
    wipe(self.stackingSlots)
end

function Stacking:Process()
    local complete = true
    for _, slots in pairs(self.bags) do
        if not self:ProcessSlots(slots) then
            complete = false
        end
    end
    return complete
end

function Stacking:ProcessSlots(slots)
    wipe(self.stackingSlots)

    local complete = true

    for i, slot in ripairs(slots) do
        if slot:IsLocked() then
            complete = false
        else
            if self:IsCanStack(slot) then
                local itemId = slot:GetItemId()
                local stackingSlot = self.stackingSlots[itemId]
                if stackingSlot then
                    slot:MoveTo(stackingSlot)

                    self.stackingSlots[itemId] = nil
                    complete = false
                else
                    self.stackingSlots[itemId] = slot
                end
            else
                tremove(slots, i)
            end
        end
    end
    return complete
end

---@param slot Slot
function Stacking:IsCanStack(slot)
    if slot:IsEmpty() then
        return false
    end

    if not slot:IsFull() then
        return true
    end

    if not ns.Addon:GetOption('stackBankFull') then
        return false
    end

    if not Pack:IsOptionBag(BAG_TYPE.BAG) or not Pack:IsOptionBag(BAG_TYPE.BANK) then
        return false
    end

    local stackingSlot = self.stackingSlots[slot:GetItemId()]
    if not stackingSlot then
        return false
    end

    if stackingSlot:IsBank() and slot:IsBag() then
        return true
    end
    return false
end
