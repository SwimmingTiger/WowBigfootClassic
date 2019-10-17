
function MerInspectConfigFunc()
	if (GetLocale() == "zhCN") then
		MOD_INFO_STAT_TITLE = {"装备信息", "zhuangbeixinxi"};

		MOD_INFO_COMPARISON_STAT_COMPARE = "开启装备属性统计";

		MOD_INFO_COMPARISON_TIPFRAME = "开启装备统计面板";

		MDO_INFO_ENABLE_DURABILITY = "显示装备耐久度";
		MDO_INFO_ENABLE_DURABILITY_TOOLTIP= "在人物装备图标右下角显示装备剩余耐久度";

		MDO_INFO_ENABLE_HIGHLIGHT = "高亮装备栏边框";
		MDO_INFO_ENABLE_HIGHLIGHT_TOOLTIP= "根据装备品质高亮显示装备栏边框";

		QUICK_COMPARE_ENABLE = "启用装备比较";

		ReforgeLite_Title = "启用重铸助手"
		ReforgeLite_Title_TOOLTIP = "根据提供的属性参数计算优化人物当前的装备属性"

		ReforgeLite_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚插件>|r 你已禁用重铸助手(ReforgeLite)插件，该设置将在下次插件载入时生效。"

	elseif (GetLocale() == "zhTW") then
		MOD_INFO_STAT_TITLE = {"裝備信息", "zhuangbeixinxi"};

		MOD_INFO_COMPARISON_STAT_COMPARE = "啟用裝備屬性統計";

		MOD_INFO_COMPARISON_TIPFRAME = "開啟裝備統計面板";

		MDO_INFO_ENABLE_DURABILITY = "顯示裝備耐久度";
		MDO_INFO_ENABLE_DURABILITY_TOOLTIP= "在人物裝備圖標右下角顯示裝備剩餘耐久度";

		MDO_INFO_ENABLE_HIGHLIGHT = "高亮裝備欄邊框";
		MDO_INFO_ENABLE_HIGHLIGHT_TOOLTIP= "根據裝備品質高亮顯示裝備欄邊框";

		QUICK_COMPARE_ENABLE = "開啟裝備比較";

		ReforgeLite_Title = "啟用重鑄助手"
		ReforgeLite_Title_TOOLTIP = "根據提供的屬性參數計算優化人物當前的裝備屬性"

		ReforgeLite_DISABLE_DELAY_TEXT = "|cff00c0c0<大腳插件>|r 你已禁用重鑄助手(ReforgeLite)插件，該設置將在下次插件載入時生效。"

	else
		MOD_INFO_STAT_TITLE = "Info Stat";

		MOD_INFO_COMPARISON_STAT_COMPARE = "Enable Equitment Stat";
		MDO_INFO_ENABLE_DURABILITY = "Display Durability";
		MDO_INFO_ENABLE_HIGHLIGHT = "High light border";
		MOD_INFO_RATING_BUSTER = "Enable Rating Buster"
		QUICK_COMPARE_ENABLE = "Enable Quick Compare";
	end

	if (IsConfigurableAddOn("QuickCompare") or IsConfigurableAddOn("GearStatsSummary") or IsConfigurableAddOn("ReforgeLite")) then
		ModManagement_RegisterMod(
			"InfoStat",
			"Interface\\Icons\\INV_Jewelry_Necklace_22",
			MOD_INFO_STAT_TITLE,
			"",
			nil,
			nil,
			{[3]=true,[5]=true}
		);

		-- if (IsConfigurableAddOn("AutoEquip") ) then
			-- ModManagement_RegisterCheckBox(
				-- "InfoStat",
				-- MOD_INFO_COMPARISON_STAT_COMPARE,
				-- nil,
				-- "EnableMerInspect",
				-- 1,
				-- function (arg)
					-- if ( arg == 1 ) then
						-- if (not BigFoot_IsAddOnLoaded("MerInspect")) then
							-- BigFoot_LoadAddOn("MerInspect");
						-- end

						-- if (BigFoot_IsAddOnLoaded("MerInspect")) then
							-- MerInspect_Toggle(true);
						-- end
					-- else
						-- if (BigFoot_IsAddOnLoaded("MerInspect")) then
							-- MerInspect_Toggle(false);
						-- end
					-- end
				-- end
			-- );

			-- ModManagement_RegisterCheckBox(
				-- "InfoStat",
				-- MDO_INFO_ENABLE_DURABILITY,
				-- MDO_INFO_ENABLE_DURABILITY_TOOLTIP,
				-- "DisplayDurability",
				-- 1,
				-- function (arg)
					-- if ( arg == 1 ) then
						-- if (not BigFoot_IsAddOnLoaded("AutoEquip")) then
							-- BigFoot_LoadAddOn("AutoEquip");
						-- end
						-- if (BigFoot_IsAddOnLoaded("AutoEquip")) then
							-- MerInspect_ToogleD(true);
						-- end
					-- else
						-- if (BigFoot_IsAddOnLoaded("AutoEquip")) then
							-- MerInspect_ToogleD(false);
						-- end
					-- end
				-- end
			-- );

			-- ModManagement_RegisterCheckBox(
				-- "InfoStat",
				-- MDO_INFO_ENABLE_HIGHLIGHT,
				-- MDO_INFO_ENABLE_HIGHLIGHT_TOOLTIP,
				-- "DisplayItemQulity",
				-- 1,
				-- function (arg)
					-- if ( arg == 1 ) then
						-- if (BigFoot_IsAddOnLoaded("MerInspect")) then
							-- MerInspect_ToogleH(true);
						-- end
					-- else
						-- if (BigFoot_IsAddOnLoaded("MerInspect")) then
							-- MerInspect_ToogleH(false);
						-- end
					-- end
				-- end,
				-- 1
			-- );
		-- end

		if (IsConfigurableAddOn("QuickCompare")) then
			ModManagement_RegisterCheckBox(
			"InfoStat",
			QUICK_COMPARE_ENABLE,
			nil,
			"EnableQuickCompare",
			1,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("QuickCompare")) then
						BigFoot_LoadAddOn("QuickCompare");
					end
					if (BigFoot_IsAddOnLoaded("QuickCompare")) then
						QuickCompare_Toggle(true,1);
					end
				else
					if (BigFoot_IsAddOnLoaded("QuickCompare")) then
						QuickCompare_Toggle(false,1);
					end
				end
			end
			);
		end

		if IsConfigurableAddOn("GearStatsSummary") then
			ModManagement_RegisterCheckBox(
				"InfoStat",
				MOD_INFO_COMPARISON_TIPFRAME,
				nil,
				"DisplayStatistics",
				1,
				function (arg)
					if ( arg == 1 ) then
						if (not BigFoot_IsAddOnLoaded("GearStatsSummary")) then
							BigFoot_LoadAddOn("GearStatsSummary");
							GearStatsSummary_Toogle(true)
						end
					else
						if (BigFoot_IsAddOnLoaded("GearStatsSummary")) then
							GearStatsSummary_Toogle(false);
						end
					end
				end
			);
		end

		if IsConfigurableAddOn("ReforgeLite") then
			ModManagement_RegisterCheckBox(
				"InfoStat",
				ReforgeLite_Title,
				ReforgeLite_Title_TOOLTIP,
				"EnableReforgeLite",
				1,
				function (arg)
					if ( arg == 1 ) then
						if (not BigFoot_IsAddOnLoaded("ReforgeLite")) then
							BigFoot_LoadAddOn("ReforgeLite");
						end
					else
						if (BigFoot_IsAddOnLoaded("ReforgeLite")) then
							BigFoot_RequestReloadUI(function() BigFoot_Print(ReforgeLite_DISABLE_DELAY_TEXT); end);
						end
					end
				end,
				nil,
				function (arg)
					if ( arg == 1 ) then
						if (not BigFoot_IsAddOnLoaded("ReforgeLite")) then
							BigFoot_LoadAddOn("ReforgeLite");
						end
					else
						if (BigFoot_IsAddOnLoaded("ReforgeLite")) then
							BigFoot_RequestReloadUI(function() BigFoot_Print(ReforgeLite_DISABLE_DELAY_TEXT); end);
						end
					end
				end
			)
		end
	end
end

BigFoot_AddCollector(MerInspectConfigFunc)