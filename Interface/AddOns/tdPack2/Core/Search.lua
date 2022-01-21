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
        local searchId = tonumber(search)
        local spellName, spellId = GetItemSpell(item)
        if searchId then
            return searchId == spellId
        else
            return CustomSearch:Find(search, spellName or '')
        end
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

Filters.tdPackBlizzardHasSet = {
    keyword1 = 'bset',

    canSearch = function(self, operator, search)
        return self.keyword1 == search:lower()
    end,

    match = function(self, link, _, search)
        local setId = select(16, GetItemInfo(link))
        return setId
    end,
}

Filters.tdPackBlizzardSet = {
    tags = {'bset'},
    onlyTags = true,

    canSearch = function(self, operator, search)
        return search
    end,

    match = function(self, item, _, search)
        local setId = select(16, GetItemInfo(item))
        if setId and setId ~= 0 then
            local setName = GetItemSetInfo(setId)
            return CustomSearch:Find(search, setName)
        end
    end,
}

Filters.tdPackInvtype = {
    tags = {'inv'},
    onlyTags = true,

    canSearch = function(self, operator, search)
        return search
    end,

    match = function(self, item, _, search)
        local equipLoc = select(9, GetItemInfo(item))
        if not equipLoc then
            return
        end
        local text = CustomSearch:Clean(search)
        if text == equipLoc:lower() then
            return true
        end

        local localeLoc = _G[equipLoc]
        return localeLoc and text == localeLoc:lower()
    end,
}

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
            if ids.locale then
                items[L['ITEM_TAG: ' .. k]] = ids
            end
        end
        return items
    end)(),
}
