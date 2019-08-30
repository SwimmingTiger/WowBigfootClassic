--[[
	Localization.lua
	简体中文 zhCN
		Translations for Combuctor
--]]


local L = LibStub("AceLocale-3.0"):NewLocale("Combuctor", "zhCN")
if not L then return end

L.Updated = '更新至v%s'

--frame titles
L.InventoryTitle = "%s的背包"
L.BankTitle = "%s的银行"

--tooltips
L.Inventory = '整合背包'
L.Bank = '银行'
L.TotalOnRealm = '总计 %s'
L.ClickToPurchase = '<点击> 购买'
L.Bags = '背包'
L.BagToggle = '<左键点击> 切换是否显示背包'
L.InventoryToggle = '<右键点击> 显示整合背包'
L.BankToggle = '<右键点击> 显示银行'
L.MoveTip = '<左键拖拽> 移动'
L.ResetPositionTip = '<Alt+右键点击> 恢复初始位置'
L.SwitchChar = '<左键点击> 切换显示人物'
L.ScrollToZoom = '<Ctrl+滚轮>进行缩放'

L.Equipment = '装备'
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
