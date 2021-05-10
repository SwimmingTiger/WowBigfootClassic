
function BuffMasterConfigFunc()
	if (GetLocale() == "zhCN") then
		BM_ACTION_BUTTON_TITLE = {"增益法术", "zengyifashu"};

		COOLDOWN_HELPER_ADJ_BUFF_SIZE = "调整目标Buff尺寸";
		COOLDOWN_HELPER_ADJ_BUFF_SIZE_TOOLTIP= "设置一个你喜欢的目标BUFF大小，使你施放的BUFF与其他BUFF区分开"

		COOLDOWN_HELPER_MYBUFF_SIZE = "你释放的";			--目标头像下你施放技能图标的大小
		COOLDOWN_HELPER_OTHERBUFF_SIZE = "其他人的";		--目标头像下其他图标的大小

		BUFFMASTER_SHOW_BUFF_INFO = "显示自身BUFF信息"
		BUFFMASTER_SHOW_DETAIL_TIMELEFT = "时间精确到秒";


		BFCD_COOLDOWN_SHOW_TARGET = "显示目标时间";
		BFCD_COOLDOWN_SHOW_TARGET_TOOLTIP="显示目标头像下各种(DE)BUFF的持续(剩余)时间";

		BUFFMASTER_SHOW_PARTY_BUFF = "增强显示队友BUFF";
		BUFFMASTER_SHOW_PARTY_BUFF_TOOLTIP= "在小队成员头像下显示其身上的BUFF";

		BUFFMASTER_SHOW_MY_BUFF = "仅显示我施放的增益"

	elseif (GetLocale() == "zhTW") then
		BM_ACTION_BUTTON_TITLE = {"增益法術", "zengyifashu"};

		COOLDOWN_HELPER_ADJ_BUFF_SIZE = "調整目標Buff尺寸";
		COOLDOWN_HELPER_ADJ_BUFF_SIZE_TOOLTIP= "設置一個你喜歡的目標BUFF大小，使你釋放的BUFF與其他BUFF區分開";

		COOLDOWN_HELPER_MYBUFF_SIZE = "你釋放的";
		COOLDOWN_HELPER_OTHERBUFF_SIZE = "其他人的";

		BUFFMASTER_SHOW_BUFF_INFO = "顯示自身BUFF信息"
		BUFFMASTER_SHOW_DETAIL_TIMELEFT = "時間精確到秒";

		BFCD_COOLDOWN_SHOW_TARGET = "顯示目標時間";
		BFCD_COOLDOWN_SHOW_TARGET_TOOLTIP= "顯示目標頭像下各種(DE)BUFF的持續(剩餘)時間";

		BUFFMASTER_SHOW_PARTY_BUFF = "增強顯示隊友BUFF";
		BUFFMASTER_SHOW_PARTY_BUFF_TOOLTIP= "在小隊成員頭像下顯示其身上的BUFF";
		BUFFMASTER_SHOW_MY_BUFF = "僅顯示我施放的增益"
	else
		BM_ACTION_BUTTON_TITLE = "Buff Adjustments";

		COOLDOWN_HELPER_ADJ_BUFF_SIZE = "Adjust Buff Size"
		COOLDOWN_HELPER_MYBUFF_SIZE = "My Buff Size";
		COOLDOWN_HELPER_OTHERBUFF_SIZE = "Other Buff Size";
		BUFFMASTER_SHOW_BUFF_INFO = "Show player's buff info"
		BUFFMASTER_SHOW_DETAIL_TIMELEFT = "Show time left of buff";
		BFCD_COOLDOWN_SHOW_TARGET = "Show small icon cooldown";
		BUFFMASTER_SHOW_PARTY_BUFF = "Show party members' buffs";
		BUFFMASTER_SHOW_MY_BUFF = "Only show my buffs"
	end

	if IsConfigurableAddOn("TUnitFrame") or IsConfigurableAddOn("BuffMaster") or IsConfigurableAddOn("BFCooldown") then
		ModManagement_RegisterMod(
			"BuffMaster",
			"Interface\\Icons\\trade_engineering",
			BM_ACTION_BUTTON_TITLE,
			"",
			nil,
			nil,
			{[3]=true}
		);
	end

	if (IsConfigurableAddOn("TUnitFrame")) then
		ModManagement_RegisterCheckBox(
			"BuffMaster",
			COOLDOWN_HELPER_ADJ_BUFF_SIZE,
			COOLDOWN_HELPER_ADJ_BUFF_SIZE_TOOLTIP,
			"AdjustBuffSize",
			1,
			function (arg)
				if (arg == 1) then
					if not  BigFoot_IsAddOnLoaded("TUnitFrame") then
						BigFoot_LoadAddOn("TUnitFrame")
					end
					if (BigFoot_IsAddOnLoaded("TUnitFrame")) then
						LibStub("AceAddon-3.0"):GetAddon("TUnitFrame"):Enable()
					end
				else
					if (BigFoot_IsAddOnLoaded("TUnitFrame")) then
						TUnitFrame_ResetBuffSize()
					end
				end
			end
		)

		ModManagement_RegisterSpinBox(
			"BuffMaster",
			COOLDOWN_HELPER_MYBUFF_SIZE,
			nil,
			"BFCH_MYBUFF_SIZE",
			"range",
			{23, 40, 1},
			23,
			function(arg)
				if (BigFoot_IsAddOnLoaded("TUnitFrame")) then
					TUnitFrame_AdjustBuffSize(true,arg)
				end
			end,
			1
		);
		ModManagement_RegisterSpinBox(
			"BuffMaster",
			COOLDOWN_HELPER_OTHERBUFF_SIZE,
			nil,
			"BFCH_OTHERBUFF_SIZE",
			"range",
			{12, 20, 1},
			17,
			function(arg)
				if (BigFoot_IsAddOnLoaded("TUnitFrame")) then
					TUnitFrame_AdjustBuffSize(false,arg)
				end
			end,
			1
		);
	end

	if (IsConfigurableAddOn("BuffMaster")) then
		ModManagement_RegisterCheckBox(
			"BuffMaster",
			BUFFMASTER_SHOW_PARTY_BUFF,
			BUFFMASTER_SHOW_PARTY_BUFF_TOOLTIP,
			"EnablePartyBuffer",
			1,
			function (__arg)
				if (__arg == 1) then
					if (not BigFoot_IsAddOnLoaded("BuffMaster")) then
						BigFoot_LoadAddOn("BuffMaster");
					end
				end
				if (BigFoot_IsAddOnLoaded("BuffMaster")) then									-- callback
					BuffMaster_ToggleShowParty(__arg)
				end
			end
		);

		ModManagement_RegisterCheckBox(
			"BuffMaster",
			BUFFMASTER_SHOW_MY_BUFF,
			"",
			"EnablePartyShortBuffer",
			1,
			function (__arg)
				if (__arg == 1) then
					if (not BigFoot_IsAddOnLoaded("BuffMaster")) then
						BigFoot_LoadAddOn("BuffMaster");
					end
				end
				if (BigFoot_IsAddOnLoaded("BuffMaster")) then									-- callback
					BuffMaster_ToggleMyBuffs(__arg)
				end
			end,
			1
		);



		ModManagement_RegisterCheckBox(
			"BuffMaster",
			BUFFMASTER_SHOW_BUFF_INFO,	-- text
			nil,															-- tooltip
			"BuffMasterShowTimeLeft",								-- variable
			1,																-- default
			function (__arg)
				if (__arg == 1) then
					if (not BigFoot_IsAddOnLoaded("BuffMaster")) then
						BigFoot_LoadAddOn("BuffMaster");
					end
				end
				if (BigFoot_IsAddOnLoaded("BuffMaster")) then									-- callback
					BuffMaster_ToggleBuffInfo(__arg)
				end
			end
		);
		ModManagement_RegisterCheckBox(
			"BuffMaster",
			BUFFMASTER_SHOW_DETAIL_TIMELEFT,	-- text
			nil,															-- tooltip
			"BuffMasterShowDetailTimeLeft",								-- variable
			nil,																-- default
			function (__arg)
				if (__arg == 1) then
					if (not BigFoot_IsAddOnLoaded("BuffMaster")) then
						BigFoot_LoadAddOn("BuffMaster");
					end
				end
				if (BigFoot_IsAddOnLoaded("BuffMaster")) then									-- callback
					BuffMaster_ToggleDetailTimeLeft(__arg)
				end
			end,
			1
		);

	end

	if (IsConfigurableAddOn("BFCooldown")) then
		ModManagement_RegisterCheckBox(
			"BuffMaster",
			BFCD_COOLDOWN_SHOW_TARGET,
			BFCD_COOLDOWN_SHOW_TARGET_TOOLTIP,
			"ShowTargetCooldown2",
			1,
			function (arg)
				if (not BigFoot_IsAddOnLoadedFromBigFoot("BFCooldown")) then
					BigFoot_LoadAddOn("BFCooldown");
				end
				if (arg == 1) then
					BFCooldown:ToggleSec(true,"BUFF")
				else
					BFCooldown:ToggleSec(false,"BUFF")
				end
			end
		);
	end
end

BigFoot_AddCollector(BuffMasterConfigFunc)