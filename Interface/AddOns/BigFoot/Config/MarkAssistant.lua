
function MarkAssistantConifgFunc()
	if (GetLocale() == "zhCN") then
		MarkAssistant_TITLE ={"大脚标记","dajiaobiaoji"}

		wMarker_ENABLE_TEXT = "启用标记助手"
		wMarker_ENABLE_TOOLTIP = "启用此选项以后你可以快速放置光柱标记,当你身为队长时还可以使用团队标记"
		wMarker_Set_Text = "配置"

		EZICON_ENABLE_TEXT="启用双击标记"
		EZICON_ENABLE_TOOLTIP = "启用此选项以后你可以通过左键双击目标来为其指定团队标记"
	elseif (GetLocale() == "zhTW") then
		MarkAssistant_TITLE ={"大腳標記","dajiaobiaoji"}

		wMarker_ENABLE_TEXT = "啟用標記助手"
		wMarker_ENABLE_TOOLTIP = "啟用此選項以後你可以快速放置光柱標記,當你身為隊長時還可以使用團隊標記"
		wMarker_Set_Text = "配置"

		EZICON_ENABLE_TEXT="啟用團隊標記"
		EZICON_ENABLE_TOOLTIP = "啟用此選項以後你可以通過左鍵雙擊目標來為其指定團隊目標"
	else
		MarkAssistant_TITLE ={"Bigfoot Mark","dajiaobiaoji"}

		wMarker_ENABLE_TEXT = "Enable wMarker"
		wMarker_ENABLE_TOOLTIP = "Enable this option later you can quickly placed column mark, when you're a captain also can be use team mark"
		wMarker_Set_Text = "Set"

		EZICON_ENABLE_TEXT="Enable ezIcon"
		EZICON_ENABLE_TOOLTIP = "ezIcon allows you to double click on a target and set a raid icon。"
	end

	if (IsConfigurableAddOn("ezIcons") or IsConfigurableAddOn("wMarker")) then
		ModManagement_RegisterMod(
			"MarkAssistant",
			"Interface\\AddOns\\BigFoot\\Media\\Mod_MarkAssistant.tga",
			MarkAssistant_TITLE,
			"",
			nil,
			nil,
			{[1]=true}
		);
	end

	if (IsConfigurableAddOn("ezIcons")) then
		ModManagement_RegisterCheckBox(
			"MarkAssistant",
			EZICON_ENABLE_TEXT,
			EZICON_ENABLE_TOOLTIP,
			"EnableezIcon",
			1,
			function (__arg)
				if (__arg == 1) then
					if (not BigFoot_IsAddOnLoaded("ezIcons")) then
						BigFoot_LoadAddOn("ezIcons");
					end
					if (BigFoot_IsAddOnLoaded("ezIcons")) then
						ezIcons:OnEnable();
						ezIcons:ToggleActive(true)
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("ezIcons")) then
						ezIcons:OnDisable();
						ezIcons:ToggleActive(false)
					end
				end
			end
		);
	end

	if (IsConfigurableAddOn("wMarker")) then
		ModManagement_RegisterCheckBox(
			"MarkAssistant",
			wMarker_ENABLE_TEXT,
			wMarker_ENABLE_TOOLTIP,
			"EnablewMarker",
			0,
			function (__arg)
				if (__arg == 1) then
					if (not BigFoot_IsAddOnLoaded("wMarker")) then
						BigFoot_LoadAddOn("wMarker");
					end
					if (BigFoot_IsAddOnLoaded("wMarker")) then
						bf_wMarker_Toggle(1)
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("wMarker")) then
						bf_wMarker_Toggle();
					end
				end
			end,
			nil,
			function (__arg)
				if (__arg == 1) then
					if (not BigFoot_IsAddOnLoaded("wMarker")) then
						BigFoot_LoadAddOn("wMarker");
					end
					if (BigFoot_IsAddOnLoaded("wMarker")) then
						bf_wMarker_Toggle(1)
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("wMarker")) then
						bf_wMarker_Toggle();
					end
				end
			end
		);

		ModManagement_RegisterButton(
			"MarkAssistant",
			wMarker_Set_Text,
			function()
				if (BigFoot_IsAddOnLoadedFromBigFoot("wMarker")) then
					InterfaceOptionsFrame_OpenToCategory("wMarker");
					InterfaceOptionsFrame_OpenToCategory("wMarker");
					HideUIPanel(ModManagementFrame);
				end
			end,
			nil,
			1
		);
	end
end

BigFoot_AddCollector(MarkAssistantConifgFunc)