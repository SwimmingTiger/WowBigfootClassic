--[[
	Localization.lua
		Translations for Combuctor

	English: Default language
--]]

local L = LibStub("AceLocale-3.0"):NewLocale("Combuctor", "enUS", true)

L.Updated = 'Updated to v%s'

--frame titles
L.InventoryTitle = "%s's Inventory"
L.BankTitle = "%s's Bank"

--tooltips
L.Inventory = 'Inventory'
L.Bank = 'Bank'
L.TotalOnRealm = 'Total on %s'
L.ClickToPurchase = '<Click> to purchase'
L.Bags = 'Bags'
L.BagToggle = '<LeftClick> to toggle the bag display'
L.InventoryToggle = '<RightClick> to toggle displaying the inventory frame'
L.BankToggle = '<RightClick> to toggle displaying the bank frame'
L.MoveTip = '<LeftDrag> to move'
L.ResetPositionTip = '<Alt-RightClick> to make the frame act as an interface panel'
L.SwitchChar = '<Left Click> to switch characters'
L.ScrollToZoom = '<Ctrl-MouseWheel> to Zoom '
L.Equipment = 'Equipment'
L.Combuctor = 'Combuctor'

--default sets (need to be here because of a flaw in how I save things
--these are automatically localized (aka, don't translate them :)

L.All = ALL
L.Weapon = GetItemClassInfo(LE_ITEM_CLASS_WEAPON);
L.Armor = GetItemClassInfo(LE_ITEM_CLASS_ARMOR); 
L.Consumable = GetItemClassInfo(LE_ITEM_CLASS_CONSUMABLE); 
L.TradeGood = GetItemClassInfo(LE_ITEM_CLASS_TRADEGOODS); 
L.Recipe = GetItemClassInfo(LE_ITEM_CLASS_RECIPE);
L.Gem = GetItemClassInfo(LE_ITEM_CLASS_GEM);
L.Misc = GetItemClassInfo(LE_ITEM_CLASS_MISCELLANEOUS);
L.Quest = GetItemClassInfo(LE_ITEM_CLASS_QUESTITEM);

L.Trinket = _G['INVTYPE_TRINKET'];

-- L.Devices, L.Explosives = select(10, GetAuctionItemSubClasses(LE_ITEM_CLASS_TRADEGOODS))
