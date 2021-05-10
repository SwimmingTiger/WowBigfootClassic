
function ArenaModConfigFunc()
	if (GetLocale() == "zhCN") then
		MOD_ARENA_MOD = {"竞技助手", "jingjizhushou"};

		MOD_ARENA_PROXMIO_ENABLE_TEXT = "开启竞技助手(Gladius)";
		MOD_ARENA_PROXMIO_ENABLE_TEXT_TOOLTIP="提供一个监测敌方职业，血量，种族，当前目标，技能提示，低血量报警及徽章使用(冷却)提示的框体";
		MOD_ARENA_PROXMIO = "设置";

		MOD_ARENA_GLADIATORLOSSA_ENABLE_TEXT = "开启竞技技能语音提示";
		MOD_ARENA_GLADIATORLOSSA_ALERTER = "开启被集火提示";

		BattleHapper_ENABLE_TEXT = "开启战场助手";
		BattleHapper_ENABLE_TEXT_TOOLTIP = "显示更多的战场信息";
		BattleHapper_Warning_ENABLE_TEXT = "开启托尔巴拉德开局提示";
		BattleHapper_DYWarning_ENABLE_TEXT = "开启冬拥湖开局提示";

		GLADIUS_DISABLE_DELAY_TEXT = "|cff00c0c0<竞技助手>|r 你已经关闭竞技助手模块，该设置将在下次插件载入时生效。";
	elseif (GetLocale() == "zhTW") then
		MOD_ARENA_MOD = {"競技助手", "jingjizhushou"};

		MOD_ARENA_PROXMIO_ENABLE_TEXT = "開啟競技助手(Gladius)";
		MOD_ARENA_PROXMIO_ENABLE_TEXT_TOOLTIP="提供一個監測敵方職業，血量，種族，當前目標，技能提示，低血量報警及徽章使用(冷卻)提示的框體"
		MOD_ARENA_PROXMIO = "设置";

		MOD_ARENA_GLADIATORLOSSA_ENABLE_TEXT = "開啟競技技能語音提示";
		MOD_ARENA_GLADIATORLOSSA_ALERTER = "開啟被集火提示";

		BattleHapper_ENABLE_TEXT = "開啟戰場助手";
		BattleHapper_ENABLE_TEXT_TOOLTIP = "顯示更多的戰場資訊";
		BattleHapper_Warning_ENABLE_TEXT = "開啟托爾巴拉德開局提示";
		BattleHapper_DYWarning_ENABLE_TEXT = "開啟冬握湖開局提示";

		GLADIUS_DISABLE_DELAY_TEXT = "|cff00c0c0<競技助手>|r 你已經關閉競技助手模組，該設置將在下次外掛程式載入時生效。";
	else
		MOD_ARENA_MOD = "Arena Mod";
		MOD_ARENA_PROXMIO_ENABLE_TEXT = "Enable Gladius";
		MOD_ARENA_PROXMIO_ENABLE_TEXT_TOOLTIP="Provide a monitoring enemy occupation, blood, race, current goals, skills, tips, low blood alarm and badge use (cooling) prompted the frame";
		MOD_ARENA_PROXMIO = "SET";

		MOD_ARENA_GLADIATORLOSSA_ENABLE_TEXT = "Voice prompts on sports skills";
		MOD_ARENA_GLADIATORLOSSA_ALERTER = "Was set on fire prompted";

		BattleHapper_ENABLE_TEXT = "Open battlefield assistant";
		BattleHapper_ENABLE_TEXT_TOOLTIP = "Show more battlefield information";
		BattleHapper_Warning_ENABLE_TEXT = "Open tol barad start hints";
		BattleHapper_DYWarning_ENABLE_TEXT = "Open wintergrasp start hints";

		GLADIUS_DISABLE_DELAY_TEXT = "|cff00c0c0<Gladius>|r Proximo has been disabled. This setting will be available next time.";
	end

	if (IsConfigurableAddOn("Gladius") or IsConfigurableAddOn("GladiatorlosSA") or IsConfigurableAddOn("BattleHapper")) then
		ModManagement_RegisterMod(
			"ArenaMod",
			"Interface\\Icons\\INV_Jewelry_Necklace_14",
			MOD_ARENA_MOD,
			nil,
			nil,
			nil,
			{[2]=true,[4]=true}
		);

		if (IsConfigurableAddOn("Gladius")) then
			ModManagement_RegisterCheckBox(
				"ArenaMod",
				MOD_ARENA_PROXMIO_ENABLE_TEXT,
				MOD_ARENA_PROXMIO_ENABLE_TEXT_TOOLTIP,
				"EnableProximo",
				0,
				function (arg)
					if ( arg == 1 ) then
						if (not BigFoot_IsAddOnLoaded("Gladius")) then
							BigFoot_LoadAddOn("Gladius");
						end
					else
						if (BigFoot_IsAddOnLoadedFromBigFoot("Gladius")) then
							BigFoot_RequestReloadUI(function() BigFoot_Print(GLADIUS_DISABLE_DELAY_TEXT); end);
						end
					end
				end
			);

			ModManagement_RegisterButton(
				"ArenaMod",
				MOD_ARENA_PROXMIO,
				function ()
					if BigFoot_IsAddOnLoaded("Gladius")  then
						OpenGladius();
						PlaySound(SOUNDKIT.IG_MAINMENU_OPTION);
						HideUIPanel(ModManagementFrame);
					end
				end,
				nil,
				1
			);
		end

		if (IsConfigurableAddOn("GladiatorlosSA")) then
			ModManagement_RegisterCheckBox(
				"ArenaMod",
				MOD_ARENA_GLADIATORLOSSA_ENABLE_TEXT,
				nil,
				"EnableGladiatorlosSA",
				0,
				function (arg)
					if ( arg == 1 ) then
						if (not BigFoot_IsAddOnLoaded("GladiatorlosSA")) then
							BigFoot_LoadAddOn("GladiatorlosSA");
						end
						if (BigFoot_IsAddOnLoaded("GladiatorlosSA")) then
							GladiatorlosSA:Toggle(true);
						end
					else
						if (BigFoot_IsAddOnLoaded("GladiatorlosSA")) then
							GladiatorlosSA:Toggle(false);
						end
					end
				end
			);

			ModManagement_RegisterButton(
				"ArenaMod",
				MOD_ARENA_PROXMIO,
				function ()
					if BigFoot_IsAddOnLoaded("GladiatorlosSA")  then
						GladiatorlosSA:ShowConfig();
						HideUIPanel(ModManagementFrame);
					end
				end,
				nil,
				1
			);

		end

		if (IsConfigurableAddOn("BattleHapper")) then
			ModManagement_RegisterCheckBox(
				"ArenaMod",
				BattleHapper_ENABLE_TEXT,
				BattleHapper_ENABLE_TEXT_TOOLTIP,
				"EnableBattleHapper",
				0,
				function (arg)
					if ( arg == 1 ) then
						if (not BigFoot_IsAddOnLoaded("BattleHapper")) then
							BigFoot_LoadAddOn("BattleHapper");
						end
						if (BigFoot_IsAddOnLoadedFromBigFoot("BattleHapper")) then
							BattleHapperToggle(arg)
						end
					else
						if (BigFoot_IsAddOnLoadedFromBigFoot("BattleHapper")) then
							BattleHapperToggle(arg)
						end
					end
				end
			);

			ModManagement_RegisterCheckBox(
				"ArenaMod",
				BattleHapper_Warning_ENABLE_TEXT,
				nil,
				"EnableBattleHapperWarning",
				1,
				function (arg)
					if ( arg == 1 ) then
						if (not BigFoot_IsAddOnLoaded("BattleHapper")) then
							BigFoot_LoadAddOn("BattleHapper");
						end
						if (BigFoot_IsAddOnLoadedFromBigFoot("BattleHapper")) then
							BattleHapperToggle_warning(arg)
						end
					else
						if (BigFoot_IsAddOnLoadedFromBigFoot("BattleHapper")) then
							BattleHapperToggle_warning(arg)
						end
					end
				end
			);

			ModManagement_RegisterCheckBox(
				"ArenaMod",
				BattleHapper_DYWarning_ENABLE_TEXT,
				nil,
				"EnableBattleHapperDYWarning",
				nil,
				function (arg)
					if ( arg == 1 ) then
						if (not BigFoot_IsAddOnLoaded("BattleHapper")) then
							BigFoot_LoadAddOn("BattleHapper");
						end
						if (BigFoot_IsAddOnLoadedFromBigFoot("BattleHapper")) then
							BattleHapperToggle_DYwarning(arg)
						end
					else
						if (BigFoot_IsAddOnLoadedFromBigFoot("BattleHapper")) then
							BattleHapperToggle_DYwarning(arg)
						end
					end
				end
			);
		end
	end
end

BigFoot_AddCollector(ArenaModConfigFunc)