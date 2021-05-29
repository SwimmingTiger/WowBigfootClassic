-- Search.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/26/2019, 2:09:42 AM
---@type ns
local ns = select(2, ...)

local L = ns.L

---- LUA
local _G = _G
local select, pairs, ipairs = select, pairs, ipairs
local tonumber = tonumber
local pcall = pcall

---- WOW
local GetItemInfo = GetItemInfo
local GetItemSpell = GetItemSpell
local IsEquippableItem = IsEquippableItem
local GetItemInfoInstant = GetItemInfoInstant

---- LIBS
local CustomSearch = LibStub('CustomSearch-1.0')
local ItemSearch = LibStub('LibItemSearch-1.2')
local Filters = {}

local Search = ns.Addon:NewModule('Search', 'AceEvent-3.0')

function Search:OnInitialize()
    self.filters = {}

    for k, v in pairs(ItemSearch.Filters) do
        self.filters[k] = v
    end

    for k, v in pairs(Filters) do
        self.filters[k] = v
    end
end

function Search:OnEnable()
    self:RegisterMessage('TDPACK_OPTION_CHANGED_applyLibItemSearch', 'UpdateLib')
    self:UpdateLib()
end

function Search:UpdateLib()
    local flag = ns.Addon:GetOption('applyLibItemSearch')

    for k, v in pairs(Filters) do
        ItemSearch.Filters[k] = flag and v or nil
    end
end

function Search:Matches(link, search)
    return CustomSearch:Matches(link, search, self.filters)
end

Filters.tdpackSpell = {
    keyword = 'spell',

    canSearch = function(self, operator, search)
        return search:lower() == self.keyword
    end,

    match = function(self, item, _, search)
        return not not GetItemSpell(item)
    end,
}

Filters.tdpackSpellName = {
    tags = {'p', 'spell'},
    onlyTags = true,

    canSearch = function(self, operator, search)
        return search
    end,

    match = function(self, item, _, search)
        local spellName, spellId = GetItemSpell(item)
        return CustomSearch:Find(search, spellName or '')
    end,
}

Filters.tdPackEquippable = {
    keyword1 = 'equip',
    keyword2 = EQUIPSET_EQUIP:lower(),

    exclude = tInvert {'INVTYPE_BAG', 'INVTYPE_AMMO'},

    canSearch = function(self, operator, search)
        return self.keyword1 == search or self.keyword2 == search:lower()
    end,

    match = function(self, link, ...)
        if not IsEquippableItem(link) then
            return false
        end
        return not self.exclude[select(9, GetItemInfo(link))]
    end,
}

--[=[@classic@
Filters.tdPackTags = {
    tags = {'tag'},

    canSearch = function(self, _, search)
        if #search < 2 then
            return
        end
        for k, v in pairs(self.items) do
            if k:find(search) == 1 then
                return k
            end
        end
    end,

    match = function(self, link, _, search)
        local items = self.items[search]
        if items then
            local id = tonumber(link:match('item:(%d+)'))
            return id and items[id]
        end
    end,

    items = (function()
        local items = {}
        for k, v in pairs(ns.ITEM_TAGS) do
            local ids = {}
            for _, id in ipairs(v) do
                ids[id] = true
            end
            items[k:lower()] = ids
            items[L['ITEM_TAG: ' .. k]] = ids
        end
        return items
    end)(),
}
--@end-classic@]=]
