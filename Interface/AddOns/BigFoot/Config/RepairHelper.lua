
function RepairHelperConfigFunc()
	if (GetLocale() == "zhCN") then
		MOD_REPAIR_HELPER_TITLE = {"修理助手", "xiulizhushou"}

		REPAIRHELPER_ENABLE_TEXT = "开启修理助手"
		REPAIRHELPER_REPAIR_ALL_TEXT_TOOLTIP="与可修理的NPC对话自动修理所有的破损装备"

		REPAIRHELPER_USE_GUILD_MONEY_TEXT = "优先使用公会资金"
		REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO ="超过限额使用玩家金币"
		REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO_TIP ="超过公会限额之后使用玩家金币自动修理"
	elseif (GetLocale() == "zhTW") then
		MOD_REPAIR_HELPER_TITLE = {"修理助手", "xiulizhushou"}

		REPAIRHELPER_ENABLE_TEXT = "開啓修理助手"
		REPAIRHELPER_REPAIR_ALL_TEXT_TOOLTIP= "開啟與可修理的NPC對話自動修理當所有的破損裝備"

		REPAIRHELPER_USE_GUILD_MONEY_TEXT = "優先使用公會資金"
		REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO ="超過限額使用自動修理"
		REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO_TIP="超过公会限额之后使用玩家金币自动修理"
	else
		MOD_REPAIR_HELPER_TITLE = "Repair Helper"

		REPAIRHELPER_ENABLE_TEXT = "Enable Repair Helper"

		REPAIRHELPER_USE_GUILD_MONEY_TEXT = "Use Guild Gold"
		REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO ="REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO"
		REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO_TIP ="REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO_TIP"
	end

	if (IsConfigurableAddOn("RepairHelper")) then
		ModManagement_RegisterMod(
			"RepairHelper",
			"Interface\\Icons\\trade_blacksmithing",
			MOD_REPAIR_HELPER_TITLE,
			"",
			nil,
			nil,
			{[5]=true}
		);

		ModManagement_RegisterCheckBox(
			"RepairHelper",
			REPAIRHELPER_ENABLE_TEXT,
			REPAIRHELPER_REPAIR_ALL_TEXT_TOOLTIP,
			"EnableRepairHelper",
			1,
			function (__arg)
				if (__arg == 1) then
					if (not BigFoot_IsAddOnLoaded("RepairHelper")) then
						BigFoot_LoadAddOn("RepairHelper");
					end
				end
				if (BigFoot_IsAddOnLoaded("RepairHelper")) then
					RepairHelper_ToggleEnable(__arg);
				end
			end
		);

		ModManagement_RegisterCheckBox(
			"RepairHelper",
			REPAIRHELPER_USE_GUILD_MONEY_TEXT,
			nil,																	-- tooltip
			"RepairHelper_UseGuildMoney",
			1,																		-- default
			function (__arg)														-- callback
				if (BigFoot_IsAddOnLoaded("RepairHelper")) then
					RepairHelper_ToggleUseGuild(__arg);
				end
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"RepairHelper",
			REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO,
			REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO_TIP,																	-- tooltip
			"RepairHelper_Enable_Used_SelfMoney_Auto",
			1,																		-- default
			function (__arg)														-- callback
				if (BigFoot_IsAddOnLoaded("RepairHelper")) then
					RepairHelper_ToggleUseSelfMoneyAuto(__arg);
				end
			end,
			2
		);
	end
end

BigFoot_AddCollector(RepairHelperConfigFunc)