
function CombatIndicatorConfigFunc()
	if (GetLocale() == "zhCN") then
		MOD_COMBAT_INDICATOR_TITLE = {"战斗指示", "zhandouzhishi",2};

		COMBAT_INDICATOR_ENABLE_TEXT = "开启战斗指示器";
		COMBAT_INDICATOR_ENABLE_TOOLTIP= "为你提供即时战斗信息显示";

		COMBAT_INDICATOR_SHOW_COMBAT_LEAVE = "开启战斗提示";
		COMBAT_INDICATOR_SHOW_COMBAT_LEAVE_TOOLTIP= "进入或离开战斗时进行提示";

		COMBAT_INDICATOR_SPELL_MOB_TEXT = "开启法术预警";
		COMBAT_INDICATOR_SPELL_MOB_TOOLTIP= "显示敌对目标正在对你释放技能的提示";

		COMBAT_INDICATOR_PLAYER_STATUS = "显示状态信息";
		COMBAT_INDICATOR_PLAYER_STATUS_TOOLTIP= "躲闪/招架/未击中..等等";

		COMBAT_INDICATOR_ENABLE_DCT = "使用DCT";
		COMBAT_INDICATOR_ENABLE_DCT_TOOLTIP= "自定义战斗信息及预警设置";

		COMBAT_INDICATOR_DCT_SETTINGS = "功能设置...";
	elseif (GetLocale() == "zhTW") then
		MOD_COMBAT_INDICATOR_TITLE = {"戰鬥指示器", "zhandouzhishi",2};

		COMBAT_INDICATOR_ENABLE_TEXT = "開啟戰鬥指示器";
		COMBAT_INDICATOR_ENABLE_TOOLTIP= "為你提供即時戰鬥信息顯示";

		COMBAT_INDICATOR_SHOW_COMBAT_LEAVE = "戰鬥提示";
		COMBAT_INDICATOR_SHOW_COMBAT_LEAVE_TOOLTIP= "進入或離開戰鬥時進行提示";

		COMBAT_INDICATOR_SPELL_MOB_TEXT = "開啟法術預警";
		COMBAT_INDICATOR_SPELL_MOB_TOOLTIP= "顯示敵對目標正在對你釋放技能的提示";

		COMBAT_INDICATOR_PLAYER_STATUS = "顯示狀態訊息";
		COMBAT_INDICATOR_PLAYER_STATUS_TOOLTIP= "躲閃/招架/未擊中..等等";

		COMBAT_INDICATOR_ENABLE_DCT = "使用DCT";
		COMBAT_INDICATOR_ENABLE_DCT_TOOLTIP= "自定義戰鬥信息及法術預警設置";

		COMBAT_INDICATOR_DCT_SETTINGS = "功能設置...";
	else
		MOD_COMBAT_INDICATOR_TITLE = "Combat Indicator";
		COMBAT_INDICATOR_ENABLE_TEXT = "Enable Combat Indicator";

		COMBAT_INDICATOR_PLAYER_STATUS = "Show player's status";
		COMBAT_INDICATOR_SHOW_COMBAT_LEAVE = "Notify of Entering and Leaving combat";

		COMBAT_INDICATOR_SPELL_MOB_TEXT = "Enable Mob info";

		COMBAT_INDICATOR_ENABLE_DCT = "USE DCT (...)";
		COMBAT_INDICATOR_ENABLE_DCT_TOOLTIP= "Custom settings combat information and early warning";
		COMBAT_INDICATOR_DCT_SETTINGS = "Options...";
	end

	if (IsConfigurableAddOn("CombatIndicator") or IsConfigurableAddOn("dct")) then
		ModManagement_RegisterMod(
			"CombatIndicator",
			"Interface\\Icons\\Ability_Warrior_PunishingBlow",
			MOD_COMBAT_INDICATOR_TITLE,
			"",
			nil,
			nil,
			{[2]=true}
		);
	end

	if (IsConfigurableAddOn("CombatIndicator")) then
		ModManagement_RegisterCheckBox(
			"CombatIndicator",
			COMBAT_INDICATOR_ENABLE_TEXT,
			COMBAT_INDICATOR_ENABLE_TOOLTIP,
			"EnableCombatIndicator",
			1,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("CombatIndicator")) then
						BigFoot_LoadAddOn("CombatIndicator");
					end

					if (BigFoot_IsAddOnLoaded("CombatIndicator")) then
						CombatIndicator_Enable(true);

						if (BigFoot_GetModVariable("CombatIndicator", "EnableCombatIndicator") ~= 0) then
							BigFoot_SetModVariable("CombatIndicator", "EnableDCT", 0);
							if(DCT_Toggle)then
								DCT_Toggle(false);
							end
						end
						ModManagement_Refresh();
					end
				else
					if (BigFoot_IsAddOnLoaded("CombatIndicator")) then
						CombatIndicator_Enable(false);
					end
				end
			end
		);

		ModManagement_RegisterCheckBox(
			"CombatIndicator",
			COMBAT_INDICATOR_SHOW_COMBAT_LEAVE,
			COMBAT_INDICATOR_SHOW_COMBAT_LEAVE_TOOLTIP,
			"EnableCombatLeave",
			1,
			function (arg)
				if (arg == 1) then
					if (BigFoot_IsAddOnLoaded("CombatIndicator")) then
						CombatIndicator_EnableLeaveCombat(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("CombatIndicator")) then
						CombatIndicator_EnableLeaveCombat(false);
					end
				end
			end
			,
			1
		);

		ModManagement_RegisterCheckBox(
			"CombatIndicator",
			COMBAT_INDICATOR_SPELL_MOB_TEXT,
			COMBAT_INDICATOR_SPELL_MOB_TOOLTIP,
			"EnableShowSpell",
			1,
			function (arg)
				if (arg == 1) then
					if (BigFoot_IsAddOnLoaded("CombatIndicator")) then
						CombatIndicator_EnableShowSpell(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("CombatIndicator")) then
						CombatIndicator_EnableShowSpell(false);
					end
				end
			end
			,
			1
		);

		ModManagement_RegisterCheckBox(
			"CombatIndicator",
			COMBAT_INDICATOR_PLAYER_STATUS,
			COMBAT_INDICATOR_PLAYER_STATUS_TOOLTIP,
			"EnableSpell",
			1,
			function (arg)
				if (arg == 1) then
					if (BigFoot_IsAddOnLoaded("CombatIndicator")) then
						CombatIndicator_EnableStatus(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("CombatIndicator")) then
						CombatIndicator_EnableStatus(false);
					end
				end
			end
			,
			1
		);
	end

	if (IsConfigurableAddOn("dct") and (GetLocale() == "zhCN" or GetLocale() == "zhTW")) then
		ModManagement_RegisterCheckBox(
			"CombatIndicator",
			COMBAT_INDICATOR_ENABLE_DCT,
			COMBAT_INDICATOR_ENABLE_DCT_TOOLTIP,
			"EnableDCT",
			0,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("dct")) then
						BigFoot_LoadAddOn("dct");
					end
					if (BigFoot_IsAddOnLoaded("dct")) then
						if(DCT_Toggle)then
							DCT_Toggle(true);
							if DCTOP_Init then
								BigFoot_DelayCall(DCTOP_Init,3)
							end
							if DCTD_Init then
								BigFoot_DelayCall(DCTD_Init,3)
							end
							if DCTSA_Init then
								BigFoot_DelayCall(DCTSA_Init,3)
							end
						end

						if (BigFoot_GetModVariable("CombatIndicator", "EnableCombatIndicator") ~= 0) then
							BigFoot_SetModVariable("CombatIndicator", "EnableCombatIndicator", 0);
							CombatIndicator_Enable(false);
						end
						ModManagement_Refresh();
					end
				else
					if (BigFoot_IsAddOnLoaded("dct")) then
						if(DCT_Toggle)then
							DCT_Toggle(false);
						end
					end
				end
			end
		);

		ModManagement_RegisterButton(
			"CombatIndicator",
			COMBAT_INDICATOR_DCT_SETTINGS,
			function()
				if (BigFoot_IsAddOnLoaded("dct") and BigFoot_HasAddon("dct_options")) then
					DCT_showMenu();
					PlaySound(SOUNDKIT.IG_MAINMENU_OPTION);
					HideUIPanel(ModManagementFrame);
				end
			end,
			nil,
			1
		);
	end
end

BigFoot_AddCollector(CombatIndicatorConfigFunc)