
function BUnitFrameConfigFunc()
	if (GetLocale() == "zhCN") then
		BF_UNITFRAME_TEXT = {"大脚头像", "dajiaotouxiang"};

		ENABLE_BF_UNITFRAME = "开启目标头像增强";

		ENABLE_FOCUS_UNITFRAME = "简单模式焦点目标";

		ENABLE_TARGETTARGET_UNITFRAME = "显示目标的目标头像";
		ENABLE_TARGETTARGET_UNITFRAME_TOOLTIP= "在目标头像或焦点目标下显示其目标的小框体，与系统自带的目标的目标冲突";

		ENABLE_TARGETTARGETTARGET_UNITFRAME = "目标的目标的目标头像";
		ENABLE_TARGETTARGETTARGET_UNITFRAME_TOOLTIP= "在目标的目标或焦点目标的目标头像下显示其目标的小框体";

		ENABLE_CASTING_SHINING = "开启施法闪光";
		ENABLE_CASTING_SHINING_TOOLTIP = "头像增强框体目标施法时头像高亮闪光";

		ENABLE_CASTING_ICON = "开启法术提示";
		ENABLE_CASTING_ICON_TOOLTIP = "头像增强框体目标施法时头像变为法术图标";
	elseif (GetLocale() == "zhTW") then
		BF_UNITFRAME_TEXT = {"大腳頭像", "dajiaotouxiang"};

		ENABLE_BF_UNITFRAME = "開啟目標頭像增強";

		ENABLE_FOCUS_UNITFRAME = "簡單模式焦點頭像";

		ENABLE_TARGETTARGET_UNITFRAME = "顯示目標的目標頭像";
		ENABLE_TARGETTARGET_UNITFRAME_TOOLTIP= "在目標頭像或焦點目標下顯示其目標的小框體，與系統自帶的目標的目標衝突";

		ENABLE_TARGETTARGETTARGET_UNITFRAME = "目標的目標的目標頭像";
		ENABLE_TARGETTARGETTARGET_UNITFRAME_TOOLTIP= "在目標的目標或焦點目標的目標頭像下顯示其目標的小框體";

		ENABLE_CASTING_SHINING = "開啟施法閃光";
		ENABLE_CASTING_SHINING_TOOLTIP = "頭像增強框體目標施法時頭像高亮閃光";

		ENABLE_CASTING_ICON = "開啟法術圖示";
		ENABLE_CASTING_ICON_TOOLTIP = "頭像增強框體目標施法時頭像變為法術圖標";
	else
		BF_UNITFRAME_TEXT = "BigFoot UnitFrame";

		ENABLE_BF_UNITFRAME = "Enable Unit Frame";
		ENABLE_FOCUS_UNITFRAME = "Simple model focus Avatar";
		ENABLE_TARGETTARGET_UNITFRAME = "ToT Frame";
		ENABLE_TARGETTARGETTARGET_UNITFRAME = "ToToT Frame";
		ENABLE_CASTING_SHINING = "Shining when casting";
		ENABLE_CASTING_ICON = "Show spell icon when casting";
	end

	if (IsConfigurableAddOn("TUnitFrame")) then
		ModManagement_RegisterMod(
			"BUnitFrame",
			"Interface\\Icons\\ABILITY_SEAL",
			BF_UNITFRAME_TEXT,
			"",
			nil,
			nil,
			{[3]=true}
		);

		ModManagement_RegisterCheckBox(
			"BUnitFrame",
			ENABLE_BF_UNITFRAME,
			nil,
			"EnableBUnitFrame",
			1,
			function (arg)
				if (arg == 1) then
					if (BigFoot_LoadAddOn("TUnitFrame")) then
						BUnitFrame_Toggle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("TUnitFrame")) then
						BUnitFrame_Toggle(false);
					end
				end
			end
		);

		-- ModManagement_RegisterCheckBox(
			-- "BUnitFrame",
			-- ENABLE_FOCUS_UNITFRAME,
			-- nil,
			-- "EnableEasyFocusFrame",
			-- 0,
			-- function (arg)
				-- if (arg == 1) then
					-- if (BigFoot_LoadAddOn("TUnitFrame")) then
						-- BUnitFrame_FocusFrame_Toggle(true);
					-- end
				-- else
					-- if (BigFoot_IsAddOnLoaded("TUnitFrame")) then
						-- BUnitFrame_FocusFrame_Toggle(false);
					-- end
				-- end
			-- end,
			-- 1
		-- );

		ModManagement_RegisterCheckBox(
			"BUnitFrame",
			ENABLE_TARGETTARGET_UNITFRAME,
			ENABLE_TARGETTARGET_UNITFRAME_TOOLTIP,
			"EnableTargetTarget",
			0,
			function (arg)
				if (arg == 1) then
					if (BigFoot_LoadAddOn("TUnitFrame")) then
						BUnitFrame_TargetTargetFrame_Toggle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("TUnitFrame")) then
						BUnitFrame_TargetTargetFrame_Toggle(false);
					end
				end
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"BUnitFrame",
			ENABLE_TARGETTARGETTARGET_UNITFRAME,
			ENABLE_TARGETTARGETTARGET_UNITFRAME_TOOLTIP,
			"EnableTargetTargetTarget",
			0,
			function (arg)
				if (arg == 1) then
					if (BigFoot_LoadAddOn("TUnitFrame")) then
						BUnitFrame_TargetTargetTargetFrame_Toggle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("TUnitFrame")) then
						BUnitFrame_TargetTargetTargetFrame_Toggle(false);
					end
				end
			end,
			2
		);

		ModManagement_RegisterCheckBox(
			"BUnitFrame",
			ENABLE_CASTING_SHINING,
			ENABLE_CASTING_SHINING_TOOLTIP,
			"EnableCastingShining",
			1,
			function (arg)
				if (arg == 1) then
					if (BigFoot_LoadAddOn("TUnitFrame")) then
						BUnitFrame_CastingShining_Toggle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("TUnitFrame")) then
						BUnitFrame_CastingShining_Toggle(false);
					end
				end
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"BUnitFrame",
			ENABLE_CASTING_ICON,
			ENABLE_CASTING_ICON_TOOLTIP,
			"EnableCastingIcon",
			1,
			function (arg)
				if (arg == 1) then
					if (BigFoot_LoadAddOn("TUnitFrame")) then
						BUnitFrame_CastingIcon_Toggle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("TUnitFrame")) then
						BUnitFrame_CastingIcon_Toggle(false);
					end
				end
			end,
			1
		);
	end
end

BigFoot_AddCollector(BUnitFrameConfigFunc)