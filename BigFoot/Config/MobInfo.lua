
function MobInfoConfigFunc()
	if (GetLocale() == "zhCN") then
		MOD_MOB_HEALTH_TITLE = {"目标信息", "guaiwuxinxi"};

		MOB_HEALTH_ENABLE_TEXT = "开启目标生命";
		MOB_HEALTH_ENABLE_TEXT_TOOLTIP = "设置目标生命及魔法值的显示模式";

		MOB_HEALTH_SHOW_HEALTH_PPT = "生命值";
		MOB_HEALTH_SHOW_HEALTH_PPT_TOOLTIP = "显示目标生命值";

		MOB_HEALTH_SHOW_HEALTH_FORMAT = "以万为单位计算血量";
		MOB_HEALTH_SHOW_HEALTH_FORMAT_TOOLTIP = "目标血量大于百万时，以万为单位显示数值";

		MOB_HEALTH_SHOW_MANA_POINT = "魔法值";
		MOB_HEALTH_SHOW_MANA_POINT_TOOLTIP = "显示目标魔法值";

		MOB_HEALTH_SHOW_HEALTH_PERCENT = "生命值百分比";
		MOB_HEALTH_SHOW_HEALTH_PERCENT_TOOLTIP = "同时显示生命值的数字与百分比";

		MOB_HEALTH_TRANSPARENT_MODE = "半透明模式";
		MOB_HEALTH_TRANSPARENT_MODE_TOOLTIP = "将显示的值透明化";

	elseif (GetLocale() == "zhTW") then
		MOD_MOB_HEALTH_TITLE = {"目標信息", "guaiwuxinxi"};

		MOB_HEALTH_ENABLE_TEXT = "開啟目標生命";
		MOB_HEALTH_ENABLE_TEXT_TOOLTIP= "設置目標生命及魔法值的顯示模式";

		MOB_HEALTH_SHOW_HEALTH_PPT = "生命值";
		MOB_HEALTH_SHOW_HEALTH_PPT_TOOLTIP= "顯示目標生命值";

		MOB_HEALTH_SHOW_HEALTH_FORMAT = "以萬為單位計算血量";
		MOB_HEALTH_SHOW_HEALTH_FORMAT_TOOLTIP = "目標血量大於百萬時，以萬為單位顯示數值";

		MOB_HEALTH_SHOW_MANA_POINT = "魔法值";
		MOB_HEALTH_SHOW_MANA_POINT_TOOLTIP= "顯示目標魔法值";

		MOB_HEALTH_SHOW_HEALTH_PERCENT = "生命值百分比";
		MOB_HEALTH_SHOW_HEALTH_PERCENT_TOOLTIP= "同時顯示生命值的數值與百分比";

		MOB_HEALTH_TRANSPARENT_MODE = "半透明模式";
		MOB_HEALTH_TRANSPARENT_MODE_TOOLTIP= "將顯示的值透明化";
	else
		MOD_MOB_HEALTH_TITLE = "Mob Health";

		MOB_HEALTH_ENABLE_TEXT = "Enable Mob Health";
		MOB_HEALTH_SHOW_HEALTH_PPT = "Show mob health";
		MOB_HEALTH_SHOW_HEALTH_FORMAT = "Calculate HP using W"
		MOB_HEALTH_SHOW_HEALTH_FORMAT_TOOLTIP = "Million greater than the target blood volume, the value of thousands of display units";
		MOB_HEALTH_SHOW_MANA_POINT = "Show target mana";
		MOB_HEALTH_SHOW_HEALTH_PERCENT = "Show mob health percentage";
		MOB_HEALTH_TRANSPARENT_MODE = "Transparent mode";
	end

	if IsConfigurableAddOn("MobHealth") then
		ModManagement_RegisterMod(
			"MobHealth",
			"Interface\\Icons\\Spell_Shadow_BloodBoil",
			MOD_MOB_HEALTH_TITLE,
			"",
			nil,
			nil,
			{[3]=true}
		);

		ModManagement_RegisterCheckBox(
			"MobHealth",
			MOB_HEALTH_ENABLE_TEXT,
			nil,
			"MobHealthEnable",
			1,
			function(arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("MobHealth")) then
						BigFoot_LoadAddOn("MobHealth");
					end
				end

				if (BigFoot_IsAddOnLoaded("MobHealth")) then
					MobHealth_Toggle(arg);
				end
			end
		);

		ModManagement_RegisterCheckBox(
			"MobHealth",
			MOB_HEALTH_SHOW_HEALTH_PPT,
			MOB_HEALTH_SHOW_HEALTH_PPT_TOOLTIP,
			"ShowHealthPPT",
			1,
			function(arg)
				if (arg == 1) then
					MobHealth_ShowHealth = true;
				else
					MobHealth_ShowHealth = nil;
				end
				if (not BigFoot_IsAddOnLoaded("MobHealth")) then
					BigFoot_LoadAddOn("MobHealth");
				end
				MobHealth_Display();
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"MobHealth",
			MOB_HEALTH_SHOW_HEALTH_FORMAT,
			MOB_HEALTH_SHOW_HEALTH_FORMAT_TOOLTIP,
			"ShowHealthFormat",
			1,
			function(arg)
				if (arg == 1) then
					MobHealth_UseFormatted = true;
				else
					MobHealth_UseFormatted = nil;
				end
				if (not BigFoot_IsAddOnLoaded("MobHealth")) then
					BigFoot_LoadAddOn("MobHealth");
				end

				MobHealth_Display();

			end,
			2
		);

		ModManagement_RegisterCheckBox(
			"MobHealth",
			MOB_HEALTH_SHOW_MANA_POINT,
			MOB_HEALTH_SHOW_MANA_POINT_TOOLTIP,
			"ShowManaPoint",
			1,
			function(arg)
				if (arg == 1) then
					MobHealth_ShowMana = true;
				else
					MobHealth_ShowMana = nil;
				end
				if (not BigFoot_IsAddOnLoaded("MobHealth")) then
					BigFoot_LoadAddOn("MobHealth");
				end
				MobHealth_Display();
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"MobHealth",
			MOB_HEALTH_SHOW_HEALTH_PERCENT,
			MOB_HEALTH_SHOW_HEALTH_PERCENT_TOOLTIP,
			"ShowHealthPercentv2",
			nil,
			function(arg)
				if (arg == 1) then
					MobHealth_ShowHealthPercent = true;
				else
					MobHealth_ShowHealthPercent = nil;
				end
				if (not BigFoot_IsAddOnLoaded("MobHealth")) then
					BigFoot_LoadAddOn("MobHealth");
				end
				MobHealth_Display();
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"MobHealth",
			MOB_HEALTH_TRANSPARENT_MODE,
			MOB_HEALTH_TRANSPARENT_MODE_TOOLTIP,
			"TransparentMode",
			nil,
			function(arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("MobHealth")) then
						BigFoot_LoadAddOn("MobHealth");
					end
					MobHealthFrame:SetAlpha(0.7);
				else
					if (not BigFoot_IsAddOnLoaded("MobHealth")) then
						BigFoot_LoadAddOn("MobHealth");
					end
					MobHealthFrame:SetAlpha(1.0);
				end
			end,
			1
		);
	end
end

BigFoot_AddCollector(MobInfoConfigFunc)