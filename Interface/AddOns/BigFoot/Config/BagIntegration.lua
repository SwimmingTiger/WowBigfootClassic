
function BagIntegrationConfigFunc()
	if (GetLocale() == "zhCN") then
		MOD_BAG_INTEGRATION_TITLE = {"背包整合", "beibaozhenghe"};

		Enable_Combuctor = "启用背包整合(Combuctor)"

		MYBANK_ENABLE = "整合银行背包";
		MYBANK_ENABLE_TOOLTIP= "用一个物品框体整合银行中的所有栏位";

		MYINVENTORY_ENABLE_BACKPACK = "整合角色背包"
		MYINVENTORY_ENABLE_BACKPACK_TOOLTIP= "用一个物品框体整合角色背包中的所有栏位";

		MYBANK_CONFIG = "设置参数";

		PUI_ENABLE_TEXT = "背包整理";
		PUI_ENABLE_TEXT_TOOLTIP = "将你背包里的物品按种类整理好。";

		PUI_REVERSE_TEXT = "反序整理";
		PUI_REVERSE_TEXT_TOOLTIP = "按照相反的顺序整理背包里的物品。";

		COMBUCTOR_DISABLE_DELAY_TEXT ="|cff00c0c0<背包整合>|r 你已经关闭背包整合(Combuctor)模块，该设置将在下次插件载入时生效。";
	elseif (GetLocale()=="zhTW") then
		MOD_BAG_INTEGRATION_TITLE = {"背包整合", "beibaozhenghe"};

		Enable_Combuctor = "启用背包整合(Combuctor)"

		MYBANK_ENABLE = "整合銀行背包";
		MYBANK_ENABLE_TOOLTIP= "用一個物品框體整合銀行中的所有欄位";

		MYINVENTORY_ENABLE_BACKPACK = "整合角色背包"
		MYINVENTORY_ENABLE_BACKPACK_TOOLTIP= "用一個物品框體整合角色背包中的所有欄位"

		MYBANK_CONFIG = "設置參數";

		PUI_ENABLE_TEXT = "背包整理";
		PUI_ENABLE_TOOLTIP = "將你背包裏的物品按種類整理好";

		PUI_REVERSE_TEXT = "反序整理";
		PUI_REVERSE_TOOLTIP = "按照相反的順序整理背包裏的物品";

		COMBUCTOR_DISABLE_DELAY_TEXT ="|cff00c0c0<背包整合>|r 你已經關閉背包整合(Combuctor)模塊，該設置將在下次插件載入時生效。";
	else
		MOD_BAG_INTEGRATION_TITLE = "Bag Integratation";

		MYBANK_ENABLE = "Enable MyBank";
		MYBANK_CONFIG = "Settings";
		PUI_ENABLE_TEXT = "Enable Tidy Inventory";
		PUI_ENABLE_TOOLTIP = "Pack up items in your bags/bank automatically.";
		PUI_REVERSE_TEXT = "Reverse";
		PUI_REVERSE_TOOLTIP = "Pack up items with reverse order.";
	end

	if IsConfigurableAddOn("Combuctor") then
		ModManagement_RegisterMod(
			"BagIntegration",
			"Interface\\Icons\\INV_Misc_Bag_13",
			MOD_BAG_INTEGRATION_TITLE,
			"",
			nil,
			nil,
			{[5]=true}
		);
	end

	if IsConfigurableAddOn("Combuctor") then
		ModManagement_RegisterCheckBox(
			"BagIntegration",
			Enable_Combuctor,
			nil,
			"Enable_Combuctor",
			1,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("Combuctor")) then
						BigFoot_LoadAddOn("Combuctor");
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("Combuctor")) then
						BigFoot_RequestReloadUI(function() BigFoot_Print(COMBUCTOR_DISABLE_DELAY_TEXT); end);
					end
				end
			end
		);

		ModManagement_RegisterCheckBox(
			"BagIntegration",
			MYBANK_ENABLE,
			MYBANK_ENABLE_TOOLTIP,
			"Enable_Bank_Integration",
			1,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("Combuctor")) then
						BigFoot_LoadAddOn("Combuctor");
					end
					Combuctor:HookBagEvents(1,BigFoot_Config["BagIntegration"]["Enable_BackPack_Integration"] or 1)
				else
					if BigFoot_IsAddOnLoaded("Combuctor") then
						Combuctor:HookBagEvents(0,BigFoot_Config["BagIntegration"]["Enable_BackPack_Integration"] or 1)
					end
				end
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"BagIntegration",
			MYINVENTORY_ENABLE_BACKPACK,
			MYINVENTORY_ENABLE_BACKPACK_TOOLTIP,
			"Enable_BackPack_Integration",
			1,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("Combuctor")) then
						BigFoot_LoadAddOn("Combuctor");
					end
					Combuctor:HookBagEvents(BigFoot_Config["BagIntegration"]["Enable_Bank_Integration"] or 1,1)
				else
					if BigFoot_IsAddOnLoaded("Combuctor") then
						Combuctor:HookBagEvents(BigFoot_Config["BagIntegration"]["Enable_Bank_Integration"] or 1,0)
					end
				end
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"BagIntegration",
			PUI_ENABLE_TEXT,
			PUI_ENABLE_TEXT_TOOLTIP,
			"Enable_PUI",
			1,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("Combuctor")) then
						BigFoot_LoadAddOn("Combuctor");
					end
					if (BigFoot_IsAddOnLoaded("Combuctor")) then
						PUI_Toggle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("Combuctor")) then
						PUI_Toggle(false);
					end
				end
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"BagIntegration",
			PUI_REVERSE_TEXT,
			PUI_REVERSE_TEXT_TOOLTIP,
			"ReverseMode",
			0,
			function (arg)
				if (arg == 1) then
					if (BigFoot_IsAddOnLoaded("Combuctor")) then
						PUI_SetOrder("desc");
					end
				else
					if (BigFoot_IsAddOnLoaded("Combuctor")) then
						PUI_SetOrder("asc");
					end
				end
			end,
			2
		);

		ModManagement_RegisterButton(
			"BagIntegration",
			MYBANK_CONFIG,
			function()
				if BigFoot_IsAddOnLoaded("Combuctor")  then
					Combuctor:ShowOptions()
					PlaySound(SOUNDKIT.IG_MAINMENU_OPTION);
					HideUIPanel(ModManagementFrame);
				end
			end,
			nil,
			1
		);
	end
end

BigFoot_AddCollector(BagIntegrationConfigFunc)