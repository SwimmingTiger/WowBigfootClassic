
function TrinketMenuConfigFunc()
	if (GetLocale() == "zhCN") then
		TRINKET_MENU_MOD_TEXT = {"饰品管理", "shipinguanli"};
		TRINKET_MENU_ENABLE_TEXT = "开启饰品管理";
		TRINKET_MENU_SETTINGS_TEXT = "设置饰品管理";
		TRINKET_MENU_KEY_BINDING_TEXT = "按键绑定";
	elseif (GetLocale() == "zhTW") then
		TRINKET_MENU_MOD_TEXT = {"飾品管理", "shipinguanli"};
		TRINKET_MENU_ENABLE_TEXT = "開啟飾品管理";
		TRINKET_MENU_SETTINGS_TEXT = "設置飾品管理";
		TRINKET_MENU_KEY_BINDING_TEXT = "按鍵綁定";
	else
		TRINKET_MENU_MOD_TEXT = "TrinketMenu";
		TRINKET_MENU_ENABLE_TEXT = "Enable TrinketMenu";
		TRINKET_MENU_SETTINGS_TEXT = "TrinketMenu Settings";
		TRINKET_MENU_KEY_BINDING_TEXT = "Binding Keyboard";
	end

	if (IsConfigurableAddOn("TrinketMenu")) then
		local factionGroup, factionName = UnitFactionGroup("player");
		if (factionGroup == "Alliance") then
			icon = "Interface\\Icons\\INV_Jewelry_TrinketPVP_01";
		else
			icon = "Interface\\Icons\\INV_Jewelry_TrinketPVP_02";
		end

		ModManagement_RegisterMod(
			"TrinketMenu",
			icon,
			TRINKET_MENU_MOD_TEXT,
			"",
			nil,
			nil,
			{[2]=true}
		);

		ModManagement_RegisterCheckBox(
			"TrinketMenu",
			TRINKET_MENU_ENABLE_TEXT,
			nil,
			"EnableTrinketMenu",
			0,
			function (arg)
				if ( arg == 1 ) then
					if (not BigFoot_IsAddOnLoaded("TrinketMenu")) then
						BigFoot_LoadAddOn("TrinketMenu");
					end

					if (BigFoot_IsAddOnLoaded("TrinketMenu")) then
						TrinketMenu_Toggle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("TrinketMenu")) then
						TrinketMenu_Toggle(false);
					end
				end
			end
		);

		ModManagement_RegisterButton(
			"TrinketMenu",
			TRINKET_MENU_SETTINGS_TEXT,
			function ()
				if (BigFoot_IsAddOnLoaded("TrinketMenu")) then
					HideUIPanel(ModManagementFrame);
					TrinketMenu.ToggleFrame(TrinketMenu_OptFrame);
				end
			end,
			nil,
			1
		);

		ModManagement_RegisterButton(
			"TrinketMenu",
			TRINKET_MENU_KEY_BINDING_TEXT,
			function ()
				if (BigFoot_IsAddOnLoaded("TrinketMenu")) then
					BigFoot_ShowKeyBindingFrame("HEADER_TRINKETMENU");
				end
			end,
			nil,
			1
		);
	end
end

BigFoot_AddCollector(TrinketMenuConfigFunc)
