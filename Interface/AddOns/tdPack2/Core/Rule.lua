-- Rule.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/31/2019, 12:00:28 AM

---@type ns
local ns = select(2, ...)

---- NS
local Addon = ns.Addon
local Item = ns.Item

---- LUA
local pairs, setmetatable = pairs, setmetatable
local format = string.format
local tconcat, sort = table.concat, table.sort or sort

---- ENUM
local SORT_TYPE = ns.SORT_TYPE

---@class Rule
local Rule = Addon:NewModule('Rule', 'AceEvent-3.0')

function Rule:OnInitialize()
    self.nameOrder = Item.GetItemName
    self.typeOrder = Item.GetItemType
    self.subTypeOrder = Item.GetItemSubType
    self.sortingCustomOrder = ns.CustomOrder:New()
    self.levelQualityOrder = function(item)
        local level = 9999 - item:GetItemLevel()
        local quality = 99 - item:GetItemQuality()

        if item:IsEquippable() then
            return format('%04d,%02d', level, quality)
        else
            return format('%02d,%04d', quality, level)
        end
    end

    self.staticOrder = ns.CachableOrder:New({
        GetKey = function(item)
            return item:GetItemId()
        end,
        GetOrder = function(item)
            return tconcat({
                self.sortingCustomOrder(item), --
                self.typeOrder(item), --
                self.subTypeOrder(item), --
                self.levelQualityOrder(item), --
                self.nameOrder(item), --
            }, ',')
        end,
    })

    self.junkOrder = ns.JunkOrder:New()
    self.countOrder = function(item)
        return format('%04d', 9999 - item:GetItemCount())
    end

    self.sortingOrder = ns.CachableOrder:New({
        cache = setmetatable({}, {__mode = 'k'}),
        GetKey = function(item)
            return item
        end,
        GetOrder = function(item)
            return tconcat({
                self.junkOrder(item), --
                self.staticOrder(item), --
                self.countOrder(item), --
            }, ',')
        end,
    })

    self.savingCustomOrder = ns.CustomOrder:New(true)

    self.savingOrder = ns.CachableOrder:New({
        cache = setmetatable({}, {__mode = 'k'}),
        GetKey = function(item)
            return item
        end,
        GetOrder = function(item)
            return tconcat({
                self.savingCustomOrder(item), --
                self.levelQualityOrder(item), --
                self.countOrder(item), --
            })
        end,
    })

    self.compares = {
        [ns.SORT_TYPE.SORTING] = function(lhs, rhs)
            return self.sortingOrder(lhs) < self.sortingOrder(rhs)
        end,
        [ns.SORT_TYPE.SAVING] = function(lhs, rhs)
            return self.savingOrder(lhs) < self.savingOrder(rhs)
        end,
    }

    self:RegisterMessage('TDPACK_SORTING_RULES_UPDATE', 'RebuildSorting')
    self:RegisterMessage('TDPACK_SAVING_RULES_UPDATE', 'RebuildSaving')
    self:RegisterMessage('TDPACK_PROFILE_CHANGED', 'RebuildAll')
end

function Rule:RebuildAll()
    self:RebuildSorting()
    self:RebuildSaving()
end

function Rule:RebuildSorting()
    self.junkOrder:RequestRebuild(Addon:GetRules(SORT_TYPE.SORTING))
    self.sortingCustomOrder:RequestRebuild(Addon:GetRules(SORT_TYPE.SORTING))
    self.staticOrder:RequestRebuild()
end

function Rule:RebuildSaving()
    self.savingCustomOrder:RequestRebuild(Addon:GetRules(SORT_TYPE.SAVING))
end

function Rule:SortItems(items, sortType)
    sortType = sortType or SORT_TYPE.SORTING

    sort(items, self.compares[sortType] or self.compares[SORT_TYPE.SORTING])
end

function Rule:IsItemNeedJump(item)
    return self.savingCustomOrder(item)
end
