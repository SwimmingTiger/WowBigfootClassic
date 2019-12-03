-- ItemInfo.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/27/2019, 12:15:26 AM

---@type ns
local ns = select(2, ...)

---- WOW
local GetItemInfo = GetItemInfo
local GetItemSpell = GetItemSpell
local IsEquippableItem = IsEquippableItem

---@class ItemInfo
local ItemInfo = ns.Addon:NewClass('ItemInfo')

function ItemInfo:Constructor(itemId)
    self.itemId = itemId
    self:Build()
end

function ItemInfo:Build()
    local itemName, itemLink, itemQuality, itemLevel, _, itemType, itemSubType, itemStackCount, itemEquipLoc,
          itemTexture = GetItemInfo(self.itemId)

    if itemName then
        self.notReady = nil
        self.itemName = itemName or ''
        self.itemLink = itemLink or ''
        self.itemType = itemType or ''
        self.itemSubType = itemSubType or ''
        self.itemStackCount = itemStackCount
        self.itemEquipLoc = itemEquipLoc or ''
        self.itemQuality = itemQuality or 1
        self.itemLevel = itemLevel or 0
        self.itemTexture = itemTexture or 0
        self.itemFamily = ns.GetItemFamily(self.itemId) or 0
        self.itemEquippable = IsEquippableItem(self.itemId) or false
    else
        self.notReady = true
    end
end

function ItemInfo:IsReady()
    return not self.notReady
end
