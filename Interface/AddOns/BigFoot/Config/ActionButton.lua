
function ActionButtonConfigFunc ()
	if (GetLocale() == "zhCN") then
		BF_ACTION_BUTTON_TITLE = {"冷却监控", "lengquejiankong"};

		BFCD_COOLDOWN_COUNT = "显示冷却时间";
		BFCD_COOLDOWN_COUNT_TOOLTIP="在自己技能图标上显示详细的冷却时间";

		BFCD_SHINE_TYPE_TITLE = "闪光类型：";
		BFCD_SHINE_TYPE = {"标准","图标", "大闪光", "雷达","收缩"};
		BFCD_SHINE_TYPE_TITLE_TOOLTIP="在自己的技能冷却结束时，选择显示的类型：标准(系统默认效果)，图标(技能图标扩大)，大闪光(技能图标高亮闪)，雷达(技能图标高亮微缩)，收缩(技能图标闪烁微缩)";

		BFCD_COOLDOWN_SHAMAN_CD = "显示图腾时间";
		BFCD_COOLDOWN_SHAMAN_CD_TOOLTIP="在玩家头像下的图腾图标上显示剩余时间";

		BFCD_COOLDOWN_DK_CD = "显示符文冷却时间";
		BFCD_COOLDOWN_DK_CD_TOOLTIP="在玩家头像下的符文图标上显示剩余时间";

		BFCD_COOLDOWN_SHOW_MIDDLE = "显示冷却提示";
		BFCD_COOLDOWN_SHOW_MIDDLE_TOOLTIP="在技能冷却结束时屏幕中央闪出技能图标效果";

		BFCD_COOLDOWN_SHOW_BAR = "显示冷却计时条";
		BFCD_COOLDOWN_SHOW_BAR_TOOLTIP="提供一个显示技能名称及冷却时间的面板";

		BFCD_CoolLine_SHOW_BAR = "启用流线型法术冷却";
		BFCD_CoolLine_SHOW_BAR_TOOLTIP="在一个有时间刻度的计时条上显示冷却中的法术";

	elseif (GetLocale() == "zhTW") then
		BF_ACTION_BUTTON_TITLE = {"冷卻監控", "lengquejiankong"};

		BFCD_COOLDOWN_COUNT = "顯示冷卻時間";
		BFCD_COOLDOWN_COUNT_TOOLTIP= "在自己技能圖標上顯示詳細的冷卻時間";

		BFCD_SHINE_TYPE_TITLE = "閃光類型：";
		BFCD_SHINE_TYPE = {"標準", "圖標","大閃光", "雷達","收縮"};
		BFCD_SHINE_TYPE_TITLE_TOOLTIP= "在自己的技能冷卻結束時，選擇顯示的類型：標準(系統默認效果)，圖標(技能圖標擴大)，大閃光(技能圖標高亮閃)，雷達(技能圖標高亮微縮)，收縮(技能圖標閃爍微縮)";

		BFCD_COOLDOWN_SHAMAN_CD = "顯示圖騰時間";
		BFCD_COOLDOWN_SHAMAN_CD_TOOLTIP= "在玩家頭像下的圖騰圖標上顯示剩餘時間";

		BFCD_COOLDOWN_DK_CD = "顯示符文冷卻時間";
		BFCD_COOLDOWN_DK_CD_TOOLTIP= "在玩家頭像下的符文圖標上顯示剩餘時間";

		BFCD_COOLDOWN_SHOW_MIDDLE = "顯示冷卻提示";
		BFCD_COOLDOWN_SHOW_MIDDLE_TOOLTIP= "在技能冷卻結束時屏幕中央閃出技能圖標效果";

		BFCD_COOLDOWN_SHOW_BAR = "顯示冷卻計時條";
		BFCD_COOLDOWN_SHOW_BAR_TOOLTIP= "提供一個顯示技能名稱及冷卻時間的面板";

		BFCD_CoolLine_SHOW_BAR = "啟用流線型法術冷卻";
		BFCD_CoolLine_SHOW_BAR_TOOLTIP="在一個有時間刻度的計時條上顯示冷卻中的法術";
	else
		BF_ACTION_BUTTON_TITLE = "CoolDown Monitor";
		BFCD_COOLDOWN_COUNT = "Show detail of cooldown";
		BFCD_COOLDOWN_SHAMAN_CD = "Show Totem remaining time";
		BFCD_COOLDOWN_DK_CD = "Show Rune Cool down";
		BFCD_SHINE_TYPE_TITLE = "Shine type:";
		BFCD_SHINE_TYPE = {"Standard", "Icon","Big Shine", "Radar","Collapse"};
		BFCD_COOLDOWN_SHOW_MIDDLE = "Show Cooldown at Center";
		BFCD_COOLDOWN_SHOW_SOUND = "Play Sound When Cooldown";
		BFCD_COOLDOWN_SHOW_BAR = "Display Cooldown Bar";
	end

	if (IsConfigurableAddOn("BFCooldown") or IsConfigurableAddOn("CoolLine")) then
		ModManagement_RegisterMod(
			"ActionButton",
			"Interface\\Icons\\inv_trinket_naxxramas06",
			BF_ACTION_BUTTON_TITLE,
			"",
			nil,
			nil,
			{[2]=true,[3]=true}

		);
		if (IsConfigurableAddOn("BFCooldown")) then
			ModManagement_RegisterCheckBox(
				"ActionButton",
				BFCD_COOLDOWN_COUNT,
				BFCD_COOLDOWN_COUNT_TOOLTIP,
				"EnableCooldownCount2",
				1,
				function (arg)
					if (arg == 1) then
						if (not BigFoot_IsAddOnLoaded("BFCooldown")) then
							BigFoot_LoadAddOn("BFCooldown");
						end
						if (BigFoot_IsAddOnLoaded("BFCooldown")) then
							BFCooldown:ToggleSec(true,"ACTION");
						end
					else
						if (BigFoot_IsAddOnLoaded("BFCooldown")) then
							BFCooldown:ToggleSec(false,"ACTION");
						end
					end
				end
			);

			ModManagement_RegisterSpinBox(
				"ActionButton",
				BFCD_SHINE_TYPE_TITLE,
				BFCD_SHINE_TYPE_TITLE_TOOLTIP,
				"ShineType",
				"list",
				BFCD_SHINE_TYPE,
				BFCD_SHINE_TYPE[1],
				function (arg)
					if arg and BigFoot_IsAddOnLoaded("BFCooldown") then
						for _i,_val in pairs(BFCD_SHINE_TYPE) do
							if _val == arg then
								BFCooldown:SwitchActionStyle(_i-2);
								return
							end
						end
					end
				end,
				1
			);

			if select(2,UnitClass('player') )=='SHAMAN' then
				ModManagement_RegisterCheckBox(
					"ActionButton",
					BFCD_COOLDOWN_SHAMAN_CD,
					BFCD_COOLDOWN_SHAMAN_CD_TOOLTIP,
					"ShowTotem",
					0,
					function (arg)
						if (arg == 1) then
							if (not BigFoot_IsAddOnLoaded("BFCooldown")) then
								BigFoot_LoadAddOn("BFCooldown");
							end
							if (BigFoot_IsAddOnLoaded("BFCooldown")) then
								BFCooldown:ToggleSpecial(true)
							end
						else
							if (BigFoot_IsAddOnLoaded("BFCooldown")) then
								BFCooldown:ToggleSpecial(false)
							end
						end
					end
				);
			end

			if select(2,UnitClass('player') )=='DEATHKNIGHT' then
				ModManagement_RegisterCheckBox(
					"ActionButton",
					BFCD_COOLDOWN_DK_CD,
					BFCD_COOLDOWN_DK_CD_TOOLTIP,
					"ShowRune",
					0,
					function (arg)
						if (arg == 1) then
							if (not BigFoot_IsAddOnLoaded("BFCooldown")) then
								BigFoot_LoadAddOn("BFCooldown");
							end
							if (BigFoot_IsAddOnLoaded("BFCooldown")) then
								BFCooldown:ToggleSpecial(true)
							end
						else
							if (BigFoot_IsAddOnLoaded("BFCooldown")) then
								BFCooldown:ToggleSpecial(false)
							end
						end
					end
				);
			end

			ModManagement_RegisterCheckBox(
				"ActionButton",
				BFCD_COOLDOWN_SHOW_MIDDLE,
				BFCD_COOLDOWN_SHOW_MIDDLE_TOOLTIP,
				"ShowCenter",
				0,
				function (arg)
					if (arg == 1) then
						if (not BigFoot_IsAddOnLoaded("BFCooldown")) then
							BigFoot_LoadAddOn("BFCooldown");
						end
						if (BigFoot_IsAddOnLoaded("BFCooldown")) then
							BFCooldown:ToggleMiddle(true)
						end
						if (BigFoot_IsAddOnLoaded("CoolLine")) then
							if (BigFoot_GetModVariable("ActionButton", "EnableCoolLine") ~= 0) then
								BigFoot_SetModVariable("ActionButton", "EnableCoolLine", 0);
								CoolLine:Hide();
							end
							ModManagement_Refresh();
						end
					else
						if (BigFoot_IsAddOnLoaded("BFCooldown")) then
							BFCooldown:ToggleMiddle(false)
						end
					end
				end
			)

			ModManagement_RegisterCheckBox(
				"ActionButton",
				BFCD_COOLDOWN_SHOW_BAR,
				BFCD_COOLDOWN_SHOW_BAR_TOOLTIP,
				"ToggleBar",
				0,
				function (arg)
					if (arg == 1) then
						if (not BigFoot_IsAddOnLoaded("BFCooldown")) then
							BigFoot_LoadAddOn("BFCooldown");
						end
						if (BigFoot_IsAddOnLoaded("BFCooldown")) then
							BFCooldown:ToggleBar(true)
						end
						if (BigFoot_IsAddOnLoaded("CoolLine")) then
							if (BigFoot_GetModVariable("ActionButton", "EnableCoolLine") ~= 0) then
								BigFoot_SetModVariable("ActionButton", "EnableCoolLine", 0);
								CoolLine:Hide();
							end
							ModManagement_Refresh();
						end
					else
						if (BigFoot_IsAddOnLoaded("BFCooldown")) then
							BFCooldown:ToggleBar(false)
						end
					end
				end
			)
		end
		if (IsConfigurableAddOn("CoolLine")) then
			ModManagement_RegisterCheckBox(
				"ActionButton",
				BFCD_CoolLine_SHOW_BAR,
				BFCD_CoolLine_SHOW_BAR_TOOLTIP,
				"EnableCoolLine",
				nil,
				function (arg)
					if (arg == 1) then
						if (not BigFoot_IsAddOnLoaded("CoolLine")) then
							BigFoot_LoadAddOn("CoolLine");
						end
						CoolLine:Show();
						if (BigFoot_IsAddOnLoaded("CoolLine")) then
							if (BigFoot_IsAddOnLoaded("BFCooldown")) then
								if (BigFoot_GetModVariable("ActionButton", "ShowCenter") ~= 0) then
									BigFoot_SetModVariable("ActionButton", "ShowCenter", 0);
									BFCooldown:ToggleMiddle(false)
								end
								if (BigFoot_GetModVariable("ActionButton", "ToggleBar") ~= 0) then
									BigFoot_SetModVariable("ActionButton", "ToggleBar", 0);
									BFCooldown:ToggleBar(false)
								end
							end
							ModManagement_Refresh();
						end
					else
						if (BigFoot_IsAddOnLoaded("CoolLine")) then
							CoolLine:Hide();
						end
					end
				end
			)
		end
	end
end

BigFoot_AddCollector(ActionButtonConfigFunc)
