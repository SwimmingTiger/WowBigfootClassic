
function BagManagementConfigFunc()
	if (GetLocale() == "zhCN") then
		MOD_BAG_MANAGEMENT_TITLE = {"背包管理", "beibaoguanli"};

		BF_BANK_OPEN_ALL_BAGS = "显示银行界面时打开所有背包";
		BF_TRADE_OPEN_ALL_BAGS = "与玩家交易时自动打开背包";
		BF_MORE_BAG_SETTINGS = "更多背包设置";
		BF_MORE_BAG_DISPLAYOPTIONS = '自动显示';

	elseif (GetLocale() == "zhTW") then
		MOD_BAG_MANAGEMENT_TITLE = {"背包管理", "beibaoguanli"};

		BF_BANK_OPEN_ALL_BAGS = "顯示銀行界面時打開所有背包";
		BF_TRADE_OPEN_ALL_BAGS = "與玩家交易時自動打開背包";
		BF_MORE_BAG_SETTINGS = "更多背包設定";
		BF_MORE_BAG_DISPLAYOPTIONS = '自動顯示';

	else
		MOD_BAG_MANAGEMENT_TITLE = "Bag Management";

		BF_BANK_OPEN_ALL_BAGS = "Open all bags while talking with banker";
		BF_TRADE_OPEN_ALL_BAGS = "Open all bags while trading with player";
		BF_MORE_BAG_SETTINGS = "More Settings";
		BF_MORE_BAG_DISPLAYOPTIONS = 'Automatic Display';
	end

	ModManagement_RegisterMod(
		"BagManagement",
		"Interface\\Icons\\INV_Misc_Bag_16",
		MOD_BAG_MANAGEMENT_TITLE,
		"",
		nil,
		nil,
		{[5]=true}
	);

	ModManagement_RegisterCheckBox(
		"BagManagement",
		BF_BANK_OPEN_ALL_BAGS,
		nil,
		"EnabelOpenAllBagsOnBank",
		1,
		BagManage_BankOpenAll
	);

	ModManagement_RegisterCheckBox(
		"BagManagement",
		BF_TRADE_OPEN_ALL_BAGS,
		nil,
		"EnabelOpenAllBagsOnTrading",
		1,
		BagManage_TradeOpenAll
	);

	ModManagement_RegisterButton(
		"BagManagement",
		BF_MORE_BAG_SETTINGS,
		function ()
			InterfaceOptionsFrame:Show()
			InterfaceOptionsFrame_OpenToCategory('Combuctor')
			InterfaceOptionsFrame_OpenToCategory('Combuctor')
			InterfaceOptionsFrame_OpenToCategory(BF_MORE_BAG_DISPLAYOPTIONS..' |A:poi-town:0:0:0:0|a')
			InterfaceOptionsFrame_OpenToCategory(BF_MORE_BAG_DISPLAYOPTIONS..' |A:poi-town:0:0:0:0|a')
		end,
		nil,
		0
	);
end

BigFoot_AddCollector(BagManagementConfigFunc)