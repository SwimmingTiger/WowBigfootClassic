--[[
	Localization.lua
		Translations for Combuctor

	Traditional Chinese
	01Dec2008	Irene Wang <xares.vossen@gmail.com>
--]]

local L = LibStub("AceLocale-3.0"):NewLocale("Combuctor", "zhTW")
if not L then return end


L.Updated = '更新到%s版'

--frame titles
L.InventoryTitle = "%s的背包"
L.BankTitle = "%s的銀行"

--tooltips
L.Inventory = '背包'
L.Bank = '銀行'
L.TotalOnRealm = '%s的總資金'
L.ClickToPurchase = '<點選>購買'
L.Bags = '容器'
L.BagToggle = '<左鍵點選>顯示或隱藏容器'
L.InventoryToggle = '<右鍵點選>打開或關閉背包視窗'
L.BankToggle = '<右鍵點選>打開或關閉銀行視窗'
L.MoveTip = '<左鍵拖曳>移動'
L.ResetPositionTip = '<Alt-右鍵點選>重設位置'
L.SwitchChar = '<左鍵點選> 切換顯示人物'
L.ScrollToZoom = '<Ctrl-滾輪>進行縮放'

L.Equipment = '裝備'
L.Combuctor = '背包整合'


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

-- L.Devices, L.Explosives = select(10, GetAuctionItemSubClasses(6))