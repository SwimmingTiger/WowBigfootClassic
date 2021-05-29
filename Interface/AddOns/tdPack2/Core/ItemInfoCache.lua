-- ItemInfoCache.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/27/2019, 6:24:10 PM

local rawget, setmetatable = rawget, setmetatable

---@type ns
local ns = select(2, ...)

---- NS
local ItemInfo = ns.ItemInfo

---@class ItemInfoCache
---@field cache ItemInfo
local ItemInfoCache = ns.Addon:NewModule('ItemInfoCache', 'AceEvent-3.0')

function ItemInfoCache:OnInitialize()
    self.cache = setmetatable({}, {
        __index = function(t, itemId)
            t[itemId] = ItemInfo:New(itemId)
            return t[itemId]
        end,
    })

    self:RegisterEvent('GET_ITEM_INFO_RECEIVED')
end

function ItemInfoCache:Get(itemId)
    return self.cache[itemId]
end

function ItemInfoCache:Build(itemId)
    local info = rawget(self.cache, itemId)
    if info then
        info:Build()
    end
end

function ItemInfoCache:GET_ITEM_INFO_RECEIVED(_, itemId, ok)
    if ok then
        self:Build(itemId)
    end
end
