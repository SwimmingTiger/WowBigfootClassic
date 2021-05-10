
function ItemInfoConfigFunc()
	local __L = BLocal("ItemInfo");

	if (GetLocale() == "zhCN") then
		__L["Item Info"]				= {"物品信息", "wupinxinxi"};

		__L["Enable Item Info"]			= "启用物品信息";
		Enable_Item_Info_TOOLTIP="扩展物品的相关信息"

		__L["Show Sell Value"]			= "物品价格";
		Show_Sell_Value_TOOLTIP="显示物品出售价格及可堆叠物品的总价"

		__L["Show Auction Info"]		= "物品AH信息";
		Show_Auction_Info_TOOLTIP="统计物品在拍卖行中的价格"

		__L["Show Additional Info"]		= "物品等级|堆叠";
		Show_Additional_Info_TOOLTIP="显示物品等级，可堆叠的数量"

		__L["Show Gem Info"]			= "宝石信息";
		Show_Gem_Info_TOOLTIP="显示镶嵌在当前装备上的宝石名称"

		__L["Show Item Qulity"]			= "物品质量及颜色";
		Show_Item_Qulity_TOOLTIP="用文字方式说明物品质量及在背包中显示装备颜色"

		__L["Enable Auction Helper"]	= "启用拍卖助手";
		Enable_Auction_Helper_TOOLTIP="开启一些在拍卖行的小功能，如显示可堆叠物品的单价 、右击物品直接拍卖等功能"

		__L["Clear Dada"]					= "清除拍卖信息";

		Enable_AlreadyKnown = "启用已学物品染色"

	elseif (GetLocale() == "zhTW") then
		__L["Item Info"]					= {"物品信息", "wupinxinxi"};

		__L["Enable Item Info"]			= "啟用物品信息";
		Enable_Item_Info_TOOLTIP="擴展物品的相關信息"

		__L["Show Sell Value"]			= "物品價格";
		Show_Sell_Value_TOOLTIP="顯示物品出售價格及可堆疊物品的總價"

		__L["Show Auction Info"]		= "物品AH信息";
		Show_Auction_Info_TOOLTIP="統計物品在拍賣行中的價格"

		__L["Show Additional Info"]	= "物品等級|堆疊";
		Show_Additional_Info_TOOLTIP="顯示物品等級，可堆疊數量"

		__L["Show Gem Info"]			= "寶石信息";
		Show_Gem_Info_TOOLTIP="顯示鑲嵌在當前裝備上的寶石名稱"

		__L["Show Item Qulity"]			= "物品質量及顏色";
		Show_Item_Qulity_TOOLTIP="用文字方式說明物品質量及在背包中顯示裝備顏色"

		__L["Enable Auction Helper"]	= "啟用拍賣助手";
		Enable_Auction_Helper_TOOLTIP="開啟一些在拍賣行的小功能，如顯示可堆疊物品的單價、右擊物品直接拍賣等功能"

		__L["Clear Dada"]					= "清除拍賣資訊";

		Enable_AlreadyKnown = "啟用已學物品染色"
	end

	if (IsConfigurableAddOn("ItemInfo")) then
		ModManagement_RegisterMod(
			"Item Info",
			"Interface\\ICONS\\INV_Relics_LibramofGrace.blp",
			__L["Item Info"],
			"",
			nil,
			nil,
			{[5]=true}
		);

		ModManagement_RegisterCheckBox(
			"Item Info",
			__L["Enable Item Info"],
			Enable_Item_Info_TOOLTIP,
			"EnableItemInfo",
			1,
			function (__arg)
				if (__arg == 1) then
					if (not BigFoot_IsAddOnLoaded("ItemInfo")) then
						BigFoot_LoadAddOn("ItemInfo");
					end

					if (BigFoot_IsAddOnLoaded("ItemInfo")) then
						ItemInfo_Toggle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("ItemInfo")) then
						ItemInfo_Toggle(false);
					end
				end
			end
		);

		ModManagement_RegisterCheckBox(
			"Item Info",
			__L["Show Sell Value"],
			Show_Sell_Value_TOOLTIP,
			"EnableSellValue",
			1,
			function (__arg)
				if (BigFoot_IsAddOnLoaded("ItemInfo")) then
					if (__arg == 1) then
						II_Config['SellValue'] = 1;
					else
						II_Config['SellValue'] = nil;
					end
				end
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"Item Info",
			__L["Show Auction Info"],
			Show_Auction_Info_TOOLTIP,
			"EnableAuctionInfo",
			1,
			function (__arg)
				if (BigFoot_IsAddOnLoaded("ItemInfo")) then
					if (__arg == 1) then
						II_Config['AuctionInfo'] = 1;
					else
						II_Config['AuctionInfo'] = nil;
					end
				end
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"Item Info",
			__L["Show Additional Info"],
			Show_Additional_Info_TOOLTIP,
			"EnableAdditionalInfo",
			1,
			function (__arg)
				if (BigFoot_IsAddOnLoaded("ItemInfo")) then
					if (__arg == 1) then
						II_Config['ItemLevel'] = 1;
						II_Config['StackCount'] = 1;
					else
						II_Config['ItemLevel'] = nil;
						II_Config['StackCount'] = nil;
					end
				end
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"Item Info",
			__L["Show Gem Info"],
			Show_Gem_Info_TOOLTIP,
			"EnableGemInfo",
			1,
			function (__arg)
				if (BigFoot_IsAddOnLoaded("ItemInfo")) then
					if (__arg == 1) then
						II_Config['GemInfo'] = 1;
					else
						II_Config['GemInfo'] = nil;
					end
				end
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"Item Info",
			__L["Show Item Qulity"],
			Show_Item_Qulity_TOOLTIP,
			"EnableItemQulity",
			1,
			function (__arg)
				if (BigFoot_IsAddOnLoaded("ItemInfo")) then
					if (__arg == 1) then
						II_Config['ItemQulity'] = 1;
					else
						II_Config['ItemQulity'] = nil;
					end
				end
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"Item Info",
			__L["Enable Auction Helper"],
			Enable_Auction_Helper_TOOLTIP,
			"EnableAuctionHelper",
			1,
			function (__arg)
				if (__arg == 1) then
					if (not BigFoot_IsAddOnLoaded("ItemInfo")) then
						BigFoot_LoadAddOn("ItemInfo");
					end

					if (BigFoot_IsAddOnLoaded("ItemInfo")) then
						ItemInfo_AuctionToggle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("ItemInfo")) then
						ItemInfo_AuctionToggle(false);
					end
				end
			end
		);

		ModManagement_RegisterButton(
			"Item Info",
			__L["Clear Dada"],
			function ()
				ItemInfo_ClearAcutionInfomation();
			end,
			nil,
			1
		);

		ModManagement_RegisterCheckBox(
			"Item Info",
			Enable_AlreadyKnown,
			nil,
			"EnableAlreadyKnown",
			1,
			function (__arg)
				if (__arg == 1) then
					if (not BigFoot_IsAddOnLoaded("ItemInfo")) then
						BigFoot_LoadAddOn("ItemInfo");
					end

					if (BigFoot_IsAddOnLoaded("ItemInfo")) then
						AlreadyKnown_Toggle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("ItemInfo")) then
						AlreadyKnown_Toggle(false);
					end
				end
			end
		);

	end
end

BigFoot_AddCollector(ItemInfoConfigFunc)