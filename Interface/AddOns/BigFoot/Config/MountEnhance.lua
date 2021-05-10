
function MountEnhanceConfigFunc()
	if (GetLocale() == "zhCN") then
		MOUNT_ENHANCE_MOD_TEXT = {"伙伴增强", "zuoqizengqiang"};

		MOUNT_ENHANCE_ENABLE_TEXT = "启用魔兽达人"
		MOUNT_ENHANCE_ENABLE_TEXT_TOOLTIP=""
		Collector_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚插件>|r 你已经关闭魔兽达人(Collector)模块，该设置将在下次插件载入时生效。";

		PET_ENHANCE_ENABLE_TEXT = "启用宠物助手"

		MasterPlan_ENABLE_TEXT = "启用要塞助手"
		MasterPlan_ENABLE_TEXT_TOOLTIP = "一键设置要塞任务,增强追随者信息"

	elseif (GetLocale() == "zhTW") then
		MOUNT_ENHANCE_MOD_TEXT = {"夥伴增強", "zuoqizengqiang"};

		MOUNT_ENHANCE_ENABLE_TEXT = "啟用魔獸達人"
		MOUNT_ENHANCE_ENABLE_TEXT_TOOLTIP = ""
		Collector_DISABLE_DELAY_TEXT = "|cff00c0c0<大腳插件>|r 你已經關閉魔獸達人(Collector)模組，該設置將在下次外掛程式載入時生效。";

		PET_ENHANCE_ENABLE_TEXT = "啟用寵物助手"

		MasterPlan_ENABLE_TEXT = "啟用要塞助手"
		MasterPlan_ENABLE_TEXT_TOOLTIP = "一鍵設置要塞任務,增強追隨者信息"

	else
		MOUNT_ENHANCE_MOD_TEXT = "Associate Enhance";

		MOUNT_ENHANCE_ENABLE_TEXT = "Enable Collector"
		MOUNT_ENHANCE_ENABLE_TEXT_TOOLTIP=""
		Collector_DISABLE_DELAY_TEXT = "|cff00c0c0<BigFoot>|r Collector is Disable,please reload UI.";

		PET_ENHANCE_ENABLE_TEXT = "Enable Pet Enhance"

		MasterPlan_ENABLE_TEXT = "Enable MasterPlan"
		MasterPlan_ENABLE_TEXT_TOOLTIP=""
	end

	if (IsConfigurableAddOn("Collector") or IsConfigurableAddOn("HPetBattleAny") or IsConfigurableAddOn("MasterPlan")) then
		ModManagement_RegisterMod(
			"BFMount",
			"Interface\\Icons\\ability_mount_charger",
			MOUNT_ENHANCE_MOD_TEXT,
			"",
			nil,
			nil,
			{[7]=true}
		);

		if IsConfigurableAddOn("Collector") then
			ModManagement_RegisterCheckBox(
				"BFMount",
				MOUNT_ENHANCE_ENABLE_TEXT,
				nil,
				"EnableCollector",
				0,
				function (arg)
					if ( arg == 1 ) then
						if (not BigFoot_IsAddOnLoaded("Collector")) then
							BigFoot_LoadAddOn("Collector");
						end
					else
						if (BigFoot_IsAddOnLoadedFromBigFoot("Collector")) then
							BigFoot_RequestReloadUI(function() BigFoot_Print(Collector_DISABLE_DELAY_TEXT); end);
						end
					end
				end
			);
		end

		if IsConfigurableAddOn("HPetBattleAny") then
			ModManagement_RegisterCheckBox(
				"BFMount",
				PET_ENHANCE_ENABLE_TEXT,
				nil,
				"EnableHPetBattleAny",
				1,
				function (arg)
					if ( arg == 1 ) then
						if not BigFoot_IsAddOnLoaded("HPetBattleAny") then
							BigFoot_LoadAddOn("HPetBattleAny");
						end
					else
						if BigFoot_IsAddOnLoaded("HPetBattleAny") then
							BigFoot_RequestReloadUI()
						end
					end
				end
			);
		end

		if IsConfigurableAddOn("MasterPlan") then
			ModManagement_RegisterCheckBox(
				"BFMount",
				MasterPlan_ENABLE_TEXT,
				MasterPlan_ENABLE_TEXT_TOOLTIP,
				"EnableMasterPlan",
				1,
				function (arg)
					if ( arg == 1 ) then
						if not BigFoot_IsAddOnLoaded("MasterPlan") then
							Garrison_LoadUI()
							OrderHall_LoadUI()
							BigFoot_LoadAddOn("MasterPlan");
						end
					else
						if BigFoot_IsAddOnLoaded("MasterPlan") then
							BigFoot_RequestReloadUI()
						end
					end
				end
			);
		end
	end
end

BigFoot_AddCollector(MountEnhanceConfigFunc)