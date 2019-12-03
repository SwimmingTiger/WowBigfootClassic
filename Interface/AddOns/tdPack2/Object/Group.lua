-- Group.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/30/2019, 11:41:51 PM

---@type ns
local ns = select(2, ...)

---- NS
local Slot = ns.Slot
local Item = ns.Item

---- LUA
local ripairs = ns.ripairs
local select, ipairs = select, ipairs
local tinsert, tremove = table.insert, table.remove
local random = fastrandom or math.random

---- WOW
local InCombatLockdown = InCombatLockdown

---@class Group: Base
local Group = ns.Addon:NewClass('Group', ns.Base)

function Group:Constructor(parent, family)
    self.family = family
    ---@type Slot[]
    self.slots = {}
    self.items = {}

    self:InitSlots()
end

function Group:GetFamily()
    return self.family
end

---- slots

function Group:InitSlots()
    local bags = self:GetParent():GetBags()

    if ns.Pack:IsOptionReverse() then
        for _, bag in ripairs(bags) do
            if ns.GetBagFamily(bag) == self.family then
                for slot = ns.GetBagNumSlots(bag), 1, -1 do
                    tinsert(self.slots, Slot:New(self, bag, slot))
                end
            end
        end
    else
        for _, bag in ipairs(bags) do
            if ns.GetBagFamily(bag) == self.family then
                for slot = 1, ns.GetBagNumSlots(bag) do
                    tinsert(self.slots, Slot:New(self, bag, slot))
                end
            end
        end
    end
end

function Group:GetSlotCount()
    return #self.slots
end

function Group:GetSlot(index)
    return self.slots[index]
end

---- items

function Group:InitItems()
    wipe(self.items)

    for _, slot in ipairs(self.slots) do
        if not slot:IsEmpty() then
            tinsert(self.items, Item:New(self, slot:GetBag(), slot:GetSlot()))
        end
    end
end

function Group:SortItems()
    ns.Rule:SortItems(self.items)
end

function Group:GetItemCount()
    return #self.items
end

function Group:GetItem(index)
    return self.items[index]
end

function Group:GetItems()
    return self.items
end

---- pack

function Group:IsPackFinish()
    return #self.items == 0
end

function Group:Pack()
    while not self:IsPackFinish() do
        if InCombatLockdown() then
            return false, 'pack: player in combat'
        end

        local tarSlot, index = self:GetIdleSlot()
        if not tarSlot then
            return false, 'pack: not found slot'
        end

        local item = self.items[index]
        if not tarSlot:IsItemIn(item) then
            local slot = self:GetParent():FindSlot(item, tarSlot)
            if not slot then
                return false, 'pack: not found target slot ' .. item:GetItemName() .. ' goto ' .. tarSlot.bag .. ' ' ..
                           tarSlot.slot
            end

            local success, result = slot:MoveTo(tarSlot)
            if not success then
                return false, 'pack: move fail ' .. result
            end
        end

        tremove(self.items, index)
        tremove(self.slots, index)
    end
    return true
end

---@return Slot
function Group:GetIdleSlot()
    local step = random(0, 1) == 0 and -1 or 1
    local e = random(1, self:GetItemCount())
    local i = e

    repeat
        local slot = self:GetSlot(i)
        if not slot:IsLocked() then
            return slot, i
        end
        i = (i - 1 + step) % self:GetItemCount() + 1
    until i == e
end

function Group:FindSlot(item, tarSlot)
    if not self:CanPutSlot(tarSlot) then
        return
    end
    for _, slot in ripairs(self.slots) do
        if slot:IsItemIn(item) and not slot:IsLocked() then
            return slot
        end
    end
end

function Group:FilterSlots()
    for i = self:GetSlotCount(), self:GetItemCount() + 1, -1 do
        if self:GetSlot(i):IsEmpty() then
            tremove(self.slots, i)
        end
    end

    for i, item in ripairs(self.items) do
        if self:GetSlot(i):IsItemIn(item) then
            tremove(self.slots, i)
            tremove(self.items, i)
        end
    end
end

function Group:IsFull()
    return self:GetItemCount() == self:GetSlotCount()
end

function Group:CanPutItem(item)
    local family = self:GetFamily()
    if family == 0 then
        return true
    end
    return ns.IsFamilyContains(family, item:GetFamily())
end

function Group:CanPutSlot(slot)
    if slot:IsEmpty() then
        return true
    end
    return self:CanPutItem(slot)
end

function Group:ChooseItems(items)
    for i, item in ripairs(items) do
        if self:IsFull() then
            return
        end

        if self:CanPutItem(item) then
            tremove(items, i)
            tinsert(self.items, item)
        end
    end
end

function Group:IsLocked()
    for _, slot in ipairs(self.slots) do
        if slot:IsLocked() then
            return true
        end
    end
    return false
end
