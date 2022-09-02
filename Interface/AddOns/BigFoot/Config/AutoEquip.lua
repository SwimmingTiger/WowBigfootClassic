
function AutoEquipConfigFunc()
	if (GetLocale() == "zhCN") then
		AUTOEQUIP_TITLE = {"一键换装", "zidonghuanzhuang"};

		AUTOEQUIP_ENABLE = "开启一键换装";
		AUTOEQUIP_ENABLE_TOOLTIP="在玩家头像上方显示一个快捷保存及换装的选项条"

		AUTOEQUIP_ENABLE_RAID_AUTOHIDE = "团队隐藏";
		AUTOEQUIP_ENABLE_RAID_AUTOHIDE_TOOLTIP="当玩家在团队中时隐藏换装选项条"

		AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE = "启用增强模式";
		AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE_TOOLTIP="强化一键换装，在屏幕中间显示一个按shift可移动的8套备选方案选项条"

		AUTOEQUIP_KEY_BINDING = "按键绑定";

		-- AutoTabard_Title = "启用自动切换战袍";
		-- AutoTabard_Title_TOOLTIP = "当进入英雄副本时，自动装备已选择的战袍";

		UnrealEquip_Title ="启用幻化助手";
		UnrealEquip_Title_TOOLTIP ="提供快捷的幻化帮助功能";
		UnrealEquip_Set_DISABLE_DELAY_TEXT= "|cff00c0c0<大脚插件>|r 你已禁用幻化助手(UnrealEquip)插件，该设置将在下次插件载入时生效。"
	elseif (GetLocale() == "zhTW") then
		AUTOEQUIP_TITLE = {"一鍵換裝", "zidonghuanzhuang"};

		AUTOEQUIP_ENABLE = "開啟一鍵換裝";
		AUTOEQUIP_ENABLE_TOOLTIP= "在玩家頭像上方顯示一個快捷保存及換裝的選項條";

		AUTOEQUIP_ENABLE_RAID_AUTOHIDE = "團隊隱藏";
		AUTOEQUIP_ENABLE_RAID_AUTOHIDE_TOOLTIP= "當玩家在團隊中時隱藏換裝選項條";

		AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE = "啟用增強模式";
		AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE_TOOLTIP= "強化一鍵換裝，在屏幕中間顯示一個按shift可移動的8套備選方案選項條";

		AUTOEQUIP_KEY_BINDING = "按鍵綁定";

		-- AutoTabard_Title = "啟用自動切換戰袍";
		-- AutoTabard_Title_TOOLTIP = "當進入英雄副本時，自動裝備已選擇的戰袍";

		UnrealEquip_Title="啟用幻化助手"
		UnrealEquip_Title_TOOLTIP="提供快捷的幻化幫助功能"
		UnrealEquip_Set_DISABLE_DELAY_TEXT = "|cff00c0c0<大腳插件>|r 你已禁用幻化助手(UnrealEquip)插件，該設置將在下次插件載入時生效。"
	else
		AUTOEQUIP_TITLE = "Auto Equip";

		AUTOEQUIP_ENABLE = "Enable Auto Equip";
		AUTOEQUIP_ENABLE_RAID_AUTOHIDE = "Hide UI when you are in raid";
		AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE = "Enahcned mode with 8 sets";
		AUTOEQUIP_KEY_BINDING = "Key Binding";

	end

	if (IsConfigurableAddOn("AutoEquip") or IsConfigurableAddOn("AutoTabard") or IsConfigurableAddOn("UnrealEquip") ) then
		ModManagement_RegisterMod(
			"AutoEquip",
			"Interface\\Icons\\INV_Gizmo_04",
			AUTOEQUIP_TITLE,
			"",
			nil,
			nil,
			{[7]=true},
			true,
			"214"
		);
		if IsConfigurableAddOn("AutoEquip") then
			ModManagement_RegisterCheckBox(
				"AutoEquip",
				AUTOEQUIP_ENABLE,
				AUTOEQUIP_ENABLE_TOOLTIP,
				"EnableAutoEquip",
				0,
				function (__arg)
					if (__arg == 1) then
						if (not BigFoot_IsAddOnLoaded("AutoEquip")) then
							BigFoot_LoadAddOn("AutoEquip");
						end

						if (BigFoot_IsAddOnLoaded("AutoEquip")) then
							AutoEquip_Toggle(true);
						end
					else
						if (BigFoot_IsAddOnLoaded("AutoEquip")) then
							AutoEquip_Toggle(false);
						end
					end
				end
			);

			ModManagement_RegisterCheckBox(
				"AutoEquip",
				AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE,
				AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE_TOOLTIP,
				"EnableAdvancedMode",
				0,
				function (__arg)
					if (BigFoot_IsAddOnLoaded("AutoEquip")) then
						if (__arg == 1) then
							AutoEquip_ToggleMode("advance");
						else
							AutoEquip_ToggleMode("normal");
						end
					end
				end,
				1
			);

			ModManagement_RegisterCheckBox(
				"AutoEquip",
				AUTOEQUIP_ENABLE_RAID_AUTOHIDE,
				AUTOEQUIP_ENABLE_RAID_AUTOHIDE_TOOLTIP,
				"EnableAutoHide",
				0,
				function (__arg)
					if (BigFoot_IsAddOnLoaded("AutoEquip")) then
						if (__arg == 1) then
							AutoEquip_EnableAutoHide(true);
						else
							AutoEquip_EnableAutoHide(false);
						end
					end
				end,
				1
			);

			ModManagement_RegisterButton(
				"AutoEquip",
				AUTOEQUIP_KEY_BINDING,
				function ()
					if (BigFoot_IsAddOnLoaded("AutoEquip")) then
						AutoEquip_KeyBinding();
					end
				end,
				nil,
				1
			);
		end

		-- if IsConfigurableAddOn("AutoTabard") then
			-- ModManagement_RegisterCheckBox(
				-- "AutoEquip",
				-- AutoTabard_Title,
				-- AutoTabard_Title_TOOLTIP,
				-- "Enable_AutoTabard",
				-- 1,
				-- function (__arg)
					-- if (__arg == 1) then
						-- if (not BigFoot_IsAddOnLoaded("AutoTabard")) then
							-- BigFoot_LoadAddOn("AutoTabard");
						-- end
						-- if (BigFoot_IsAddOnLoaded("AutoTabard")) then
							-- SmartTabard:OnEnables()
						-- end
					-- else
						-- if (BigFoot_IsAddOnLoaded("AutoTabard")) then
							-- SmartTabard:OnDisable()
						-- end
					-- end
				-- end
			-- );
		-- end

		if IsConfigurableAddOn("UnrealEquip") then
			ModManagement_RegisterCheckBox(
				"AutoEquip",
				UnrealEquip_Title,
				UnrealEquip_Title_TOOLTIP,
				"EnableUnrealEquip",
				0,
				function (__arg)
					if (__arg == 1) then
						if (not BigFoot_IsAddOnLoaded("UnrealEquip")) then
							BigFoot_LoadAddOn("UnrealEquip");
						end
						UnrealEquipFlyoutFrame_OnEnable()
					else
						if (BigFoot_IsAddOnLoaded("UnrealEquip")) then
							BigFoot_RequestReloadUI(function() BigFoot_Print(UnrealEquip_Set_DISABLE_DELAY_TEXT); end);
						end
					end
				end
			);
		end
	end
end

BigFoot_AddCollector(AutoEquipConfigFunc)