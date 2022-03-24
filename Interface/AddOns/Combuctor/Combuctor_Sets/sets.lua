--[[
	Sets.lua
		Basic set types for combuctor

		setRule(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
--]]

-- Stolen from OneBag, since my bitflag knowledge could be better
-- BAGTYPE_PROFESSION = Leather + Inscription + Herb + Enchanting + Engineering + Gem + Mining
local BAGTYPE_PROFESSION = 0x0008 + 0x0010 + 0x0020 + 0x0040 + 0x0080 + 0x0200 + 0x0400 + 0x8000

local CombuctorSet = Combuctor:GetModule('Sets')
local L = LibStub('AceLocale-3.0'):GetLocale('Combuctor')

--the all category (player, bagType filters)
CombuctorSet:Register(L.All, 'Interface/Icons/INV_Misc_EngGizmos_17', function() return true end)

CombuctorSet:RegisterSubSet(L.All, L.All, nil, function(player, bagType)
	return bagType and bagType ~= 256
end)

-- CombuctorSet:RegisterSubSet(L.Bank, L.All, nil, function(player, bagType)
	-- return bagType and bagType == 0
-- end)

-- CombuctorSet:RegisterSubSet(REAGENT_BANK, L.All, nil, function(player, bagType)
	-- return bagType and bit.band(bagType, BAGTYPE_PROFESSION) > 0
-- end)

CombuctorSet:RegisterSubSet(L.Bank, ALL, nil, function(player, bag) return bag ~= REAGENTBANK_CONTAINER end)
CombuctorSet:RegisterSubSet(REAGENT_BANK, ALL, nil, function(player, bag) return bag == REAGENTBANK_CONTAINER end)

--equipment filters (armor, weapon, trinket)
local function isEquipment(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return (type == L.Armor or type == L.Weapon)
end
CombuctorSet:Register(L.Equipment, 'Interface/Icons/INV_Chest_Chain_04', isEquipment)
CombuctorSet:RegisterSubSet(L.All, L.Equipment)

local function isArmor(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return type == L.Armor and equipLoc ~= 'INVTYPE_TRINKET'
end
CombuctorSet:RegisterSubSet(L.Armor, L.Equipment, nil, isArmor)

local function isWeapon(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return type == L.Weapon
end
CombuctorSet:RegisterSubSet(L.Weapon, L.Equipment, nil, isWeapon)

local function isTrinket(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return equipLoc == 'INVTYPE_TRINKET'
end
CombuctorSet:RegisterSubSet(L.Trinket, L.Equipment, nil, isTrinket)

--usable items
local function isUsable(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	if type == L.Consumable then
		return true
	elseif type == L.TradeGood then
		-- if subType == L.Devices or subType == L.Explosives then
			-- return true
		-- end
		-- mark
	end
end
CombuctorSet:Register(L.Consumable, 'Interface/Icons/INV_Potion_93', isUsable)
CombuctorSet:RegisterSubSet(L.All, L.Consumable)

local function isConsumable(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return type == L.Consumable
end
CombuctorSet:RegisterSubSet(L.Consumable, L.Consumable, nil, isConsumable)

-- local function isDevice(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	-- return type == L.TradeGood
-- end
-- CombuctorSet:RegisterSubSet(L.Devices, L.Consumable, nil, isDevice)

--quest items
local function isQuestItem(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return type == L.Quest
end
CombuctorSet:Register(L.Quest, 'Interface/QuestFrame/UI-QuestLog-BookIcon', isQuestItem)
CombuctorSet:RegisterSubSet(L.All, L.Quest)

--trade goods + gems
local function isTradeGood(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	if type == L.TradeGood then
		-- return not(subType == L.Devices or subType == L.Explosives) --mark
	end
	return type == L.Recipe or type == L.Gem
end
CombuctorSet:Register(L.TradeGood, 'Interface/Icons/INV_Fabric_Silk_02', isTradeGood)
CombuctorSet:RegisterSubSet(L.All, L.TradeGood)

local function isTradeGood(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return type == L.TradeGood
end
CombuctorSet:RegisterSubSet(L.TradeGood, L.TradeGood, nil, isTradeGood)

local function isGem(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return type == L.Gem
end
CombuctorSet:RegisterSubSet(L.Gem, L.TradeGood, nil, isGem)

local function isRecipe(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return type == L.Recipe
end
CombuctorSet:RegisterSubSet(L.Recipe, L.TradeGood, nil, isRecipe)

--misc
local function isMiscItem(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return type == L.Misc and (link:match('%d+') ~= '6265')
end
CombuctorSet:Register(L.Misc, 'Interface/Icons/INV_Misc_Rune_01', isMiscItem)
CombuctorSet:RegisterSubSet(L.All, L.Misc)
