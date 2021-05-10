-- Saving.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/10/2019, 11:02:44 AM

----LUA
local tinsert, tremove, wipe = table.insert, table.remove, table.wipe or wipe
local ipairs = ipairs

---@type ns
local ns = select(2, ...)

local BAG_TYPE = ns.BAG_TYPE

local Pack = ns.Pack
local Rule = ns.Rule
local Item = ns.Item

---@class Saving
---@field private slots Slot[]
local Saving = ns.Addon:NewClass('Saving', ns.Task)

function Saving:Constructor()
    self.slots = {}
end

function Saving:Prepare()
    if not Pack:IsOptionSaving() then
        return true
    end

    local bag = Pack:GetBag(BAG_TYPE.BAG)
    local bank = Pack:GetBag(BAG_TYPE.BANK)

    if not bank or not bag then
        return
    end

    ---@type Item[]
    local items = {}
    ---@type table<Item, Slot>
    local itemSlots = {}

    for _, group in bag:IterateGroups() do
        for i = 1, group:GetSlotCount() do
            local slot = group:GetSlot(i)
            if not slot:IsEmpty() then
                local item = Item:New(nil, slot:GetBag(), slot:GetSlot())
                if ns.Rule:IsItemNeedJump(item) then
                    tinsert(items, item)
                    itemSlots[item] = slot
                end
            end
        end
    end

    ns.Rule:SortItems(items, ns.SORT_TYPE.SAVING)

    ---@param group Group
    local function PickItem(group)
        for i, item in ipairs(items) do
            if group:CanPutItem(item) then
                tremove(items, i)
                return item
            end
        end
    end

    local function CheckGroup(group)
        if #items == 0 then
            return
        end

        for i = 1, group:GetSlotCount() do
            local slot = group:GetSlot(i)
            if slot:IsEmpty() then
                local item = PickItem(group)
                if not item then
                    break
                end

                local tarSlot = itemSlots[item]

                tinsert(self.slots, slot)
                tinsert(self.slots, tarSlot)

                tarSlot:MoveTo(slot)
            end
        end
    end

    for _, group in bank:IterateTradeGroups() do
        CheckGroup(group)
    end

    CheckGroup(bank:GetNormalGroup())
end

function Saving:Finish()
    wipe(self.slots)
end

function Saving:Process()
    for _, slot in ipairs(self.slots) do
        if slot:IsLocked() then
            return false
        end
    end
    return true
end

function Saving:IsRunable()
    return Pack:IsOptionSaving()
end
