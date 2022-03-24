
function BFTooltipConfigFucn()
	if (GetLocale() == "zhCN") then
		BIGFOOT_TOOLTIP = {"鼠标提示", "shubiaotishi"};

		ENABLE_NEWTYPE_BIGFOOT_TOOLTIP = "启用新版大脚鼠标提示";
		ENABLE_NEWTYPE_BIGFOOT_TOOLTIP_TOOLTIP= "在原有功能基础上美化了界面";

		ENABLE_BIGFOOT_TOOLTIP = "启用旧版大脚鼠标提示";
		ENABLE_BIGFOOT_TOOLTIP_TOOLTIP= "扩展增强了普通鼠标提示信息";

		BIGFOOT_TOOLTIP_OPTION = {
			[1] = { "BigFootTooltipPosition", "提示位置:", {NONE, "鼠标", "左上", "顶部", "右上", "左侧", "中心", "右侧", "左下", "底部", "右下"}, nil, NONE },
			[2] = { "BigFootTooltipPositionX", "X轴偏移:", nil, {-300, 300, 5}, -20 },
			[3] = { "BigFootTooltipPositionY", "Y轴偏移:", nil, {-300, 300, 5}, -25 },
			[4] = { "BigFootTooltipFade", "渐隐提示:", {"否", "是"}, nil,  "是"},
			[5] = { "BigFootTooltipTalent", "天赋信息:", {"隐藏", "显示"}, nil, "显示" },
			[6] = { "BigFootTooltipItemLevel", "当前装等:", {"隐藏", "显示"}, nil, "显示" },
			[7] = { "BigFootTooltipToT", "目标的目标:", {"隐藏", "显示"}, nil, "显示" },
			[8] = { "BigFootTooltipActor", "头衔:", {"显示", "隐藏"}, nil, "隐藏" },
			[9] = { "BigFootTooltipGuildRank", "公会阶级:", {"显示", "隐藏"}, nil, "隐藏" },
		};

	elseif (GetLocale() == "zhTW") then
		BIGFOOT_TOOLTIP = {"鼠標提示", "shubiaotishi"};

		ENABLE_NEWTYPE_BIGFOOT_TOOLTIP = "啟用舊版大腳鼠標提示";
		ENABLE_NEWTYPE_BIGFOOT_TOOLTIP_TOOLTIP= "在原有功能基礎上美化了界面";

		ENABLE_BIGFOOT_TOOLTIP = "啟用大腳鼠標提示";
		ENABLE_BIGFOOT_TOOLTIP_TOOLTIP= "擴展增強了普通鼠標提示信息";

		BIGFOOT_TOOLTIP_OPTION = {
			[1] = { "BigFootTooltipPosition", "提示位置:", {NONE, "鼠標", "左上", "頂部", "右上", "左側", "中心", "右側", "左下", "底部", "右下"}, nil, NONE },
			[2] = { "BigFootTooltipPositionX", "X軸偏移:", nil, {-300, 300, 5}, -20 },
			[3] = { "BigFootTooltipPositionY", "Y軸偏移:", nil, {-300, 300, 5}, -25 },
			[4] = { "BigFootTooltipFade", "漸隱提示:", {"否", "是"}, nil, "是" },
			[5] = { "BigFootTooltipTalent", "天賦信息:", {"隱藏", "顯示"}, nil, "顯示" },
			[6] = { "BigFootTooltipItemLevel", "當前裝等:", {"隱藏", "顯示"}, nil, "顯示" },
			[7] = { "BigFootTooltipToT", "目標的目標:", {"隱藏", "顯示"}, nil, "顯示" },
			[8] = { "BigFootTooltipActor", "頭銜:", {"顯示", "隱藏"}, nil, "隱藏" },
			[9] = { "BigFootTooltipGuildRank", "公會階級:", {"顯示", "隱藏"}, nil, "隱藏" },
		};

	else
		BIGFOOT_TOOLTIP = "BigFoot Tooltip";

		ENABLE_NEWTYPE_BIGFOOT_TOOLTIP = "Enable new Bigfoot Tooltip";

		ENABLE_BIGFOOT_TOOLTIP = "Enable BigFoot Tooltip";
		BIGFOOT_TOOLTIP_OPTION = {
			[1] = { "BigFootTooltipPosition", "Position:", {NONE, "Following Mouse", "Top Left", "Top", "Top Right", "Left", "Center", "Right", "Bottom Left", "Bottom", "Bottom Right"}, nil, NONE },
			[2] = { "BigFootTooltipPositionX", "PositionX:", nil, {-300, 300, 5}, -20 },
			[3] = { "BigFootTooltipPositionY", "PositionY:", nil, {-300, 300, 5}, -25 },
			[4] = { "BigFootTooltipFade", "Fade:", {"No", "Yes"}, nil, "Yes" },
			[5] = { "BigFootTooltipTalent", "Talent:", {"Hide", "Show"}, nil, "Show" },
			[6] = { "BigFootTooltipItemLevel", "ItemLevel:", {"Hide", "Show"}, nil, "Show" },
			[7] = { "BigFootTooltipToT", "ToT:", { "Hide", "Show"}, nil, "Show" },
			[8] = { "BigFootTooltipActor", "Actor:", {"Show", "Hide"}, nil, "Hide" },
			[9] = { "BigFootTooltipGuildRank", "Guild Rank", {"Show", "Hide"}, nil, "Hide" },
		};
	end

	if (IsConfigurableAddOn("BFTooltip")) then
		ModManagement_RegisterMod(
			"BFTT",
			"Interface\\Icons\\INV_Misc_Coin_09",
			BIGFOOT_TOOLTIP,
			"",
			nil,
			nil,
			{[3]=true}

		);
		--[[if not IsAddOnLoaded("FreebTip") then
			ModManagement_RegisterCheckBox(
				"BFTT",
				ENABLE_NEWTYPE_BIGFOOT_TOOLTIP,
				ENABLE_NEWTYPE_BIGFOOT_TOOLTIP_TOOLTIP,
				"EnableNewTypeBFTooltip",
				0,
				function (arg)
					if (arg == 1) then
						if (not BigFoot_IsAddOnLoaded("BFTooltip")) then
							BigFoot_LoadAddOn("BFTooltip");
						end
						if (BigFoot_GetModVariable("BFTT", "EnableBFTooltip") ~= 0) then	--若旧版勾选
							BigFoot_SetModVariable("BFTT", "EnableBFTooltip", 0);
							ModManagement_Refresh();
							--提示重载
							BigFoot_RequestReloadUI(function()
								BigFoot_SetModVariable("BFTT", "EnableBFTooltip", 1);
								BigFoot_SetModVariable("BFTT", "EnableNewTypeBFTooltip", 0);
								ModManagement_Refresh();
							end);
						else	--若旧版未勾选
							--不用重载直接启用
							BFTT_Toggle(true, 2);
						end
					else
						if (BigFoot_IsAddOnLoaded("BFTooltip")) then
							--提示重载
							BigFoot_RequestReloadUI(function()
								BigFoot_SetModVariable("BFTT", "EnableNewTypeBFTooltip", 1);
								ModManagement_Refresh();
							end);
						end
					end
				end,
				nil,
				function (arg)	--Init函数
					if (arg == 1) then
						if (not BigFoot_IsAddOnLoaded("BFTooltip")) then
							BigFoot_LoadAddOn("BFTooltip");
						end
						BFTT_Toggle(true, 2);
					else
						if (BigFoot_IsAddOnLoaded("BFTooltip")) then
							if (BigFoot_GetModVariable("BFTT", "EnableBFTooltip") == 1) then
								BFTT_Toggle(true, 1);
							else
								BFTT_Toggle(false, 2);
							end
						end
					end
				end
			);
		end]]

		ModManagement_RegisterCheckBox(
			"BFTT",
			ENABLE_BIGFOOT_TOOLTIP,
			ENABLE_BIGFOOT_TOOLTIP_TOOLTIP,
			"EnableBFTooltip",
			1,
			function (arg)
				if (arg == 1) then		--旧勾选
					if (not BigFoot_IsAddOnLoaded("BFTooltip")) then
						BigFoot_LoadAddOn("BFTooltip");
					end

					if (BigFoot_GetModVariable("BFTT", "EnableNewTypeBFTooltip") ~= 0) then		--新版勾
						BigFoot_SetModVariable("BFTT", "EnableNewTypeBFTooltip", 0);
						ModManagement_Refresh();
						--提示重载
						BigFoot_RequestReloadUI(function()
							BigFoot_SetModVariable("BFTT", "EnableNewTypeBFTooltip", 1);
							BigFoot_SetModVariable("BFTT", "EnableBFTooltip", 0);
							ModManagement_Refresh();
						end);
					else	--新版未勾
						--不用重载直接启用
						BFTT_Toggle(true, 1);
					end
				else		--旧取消勾选
					if (BigFoot_IsAddOnLoaded("BFTooltip")) then
						--提示重载
						BigFoot_RequestReloadUI(function()
							BigFoot_SetModVariable("BFTT", "EnableBFTooltip", 1);
							ModManagement_Refresh();
						end);
					end
				end
			end,
			nil,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("BFTooltip")) then
						BigFoot_LoadAddOn("BFTooltip");
					end
					BFTT_Toggle(true, 1);
				else
					if (BigFoot_IsAddOnLoaded("BFTooltip")) then
						if (BigFoot_GetModVariable("BFTT", "EnableNewTypeBFTooltip") == 1) then
							BFTT_Toggle(true, 2);
						else
							BFTT_Toggle(false, 1);
						end
					end
				end
			end
		);

		for i, info in ipairs(BIGFOOT_TOOLTIP_OPTION) do
			if (info[4]) then
				ModManagement_RegisterSpinBox(
					"BFTT",
					info[2],
					nil,
					info[1],
					"range",
					info[4],
					info[5],
					function(arg)
						if not BigFoot_IsAddOnLoaded("BFTooltip") then
							BigFoot_LoadAddOn("BFTooltip");
						end
						if (BigFoot_IsAddOnLoaded("BFTooltip")) then
							BFTT_OPTION_FUNC[i](arg);
						end
					end
				);
			else
				ModManagement_RegisterSpinBox(
					"BFTT",
					info[2],
					nil,
					info[1],
					"list",
					info[3],
					info[5],
					function(arg)
						if not BigFoot_IsAddOnLoaded("BFTooltip") then
							BigFoot_LoadAddOn("BFTooltip");
						end
						if (BigFoot_IsAddOnLoaded("BFTooltip")) then
							BFTT_OPTION_FUNC[i](arg);
						end
					end
				);
			end
		end
	end
end

BigFoot_AddCollector(BFTooltipConfigFucn)