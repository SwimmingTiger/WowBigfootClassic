
function ChatEnhanceConfigFunc()
	if (GetLocale() == "zhCN") then
		CHAT_ENHANCEMENT_TITLE = {"聊天增强", "liaotianzengqiang",2};

		BFC_ENABLE_TEXT = "启用大脚聊天快捷条";
		BFC_ENABLE_TEXT_TOOLTIP= "添加聊天快捷条，如使用大脚表情，快捷频道切换等";

		WP_ENABLE_TEXT = "启用密语管理";
		WP_ENABLE_TEXT_TOOLTIP= "记录并提示玩家密语聊天信息";

		Enable_ItemLinkLevel_TEXT = "启用装备等级提示";
		Enable_ItemLinkLevel_TEXT_TOOLTIP= "提示优秀品质以上的装备等级及部位";

		QuickCompare_AchievementEnable_Text= "启用成就对比";

		PLAYER_LINK_ENABLE_TEXT = "启用链接增强";
		PLAYER_LINK_ENABLE_TEXT_TOOLTIP= "增强聊天窗口中玩家姓名右键菜单";

		BFC_CONFIG="聊天配置"
		BFC_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚聊天>|r 你已经关闭大脚聊天(BigFootChat)模块，该设置将在下次插件载入时生效。";
	elseif (GetLocale() == "zhTW") then
		CHAT_ENHANCEMENT_TITLE = {"聊天增強", "liaotianzengqiang",2};

		BFC_ENABLE_TEXT = "啟用大腳聊天快捷條"
		BFC_ENABLE_TEXT_TOOLTIP= "添加聊天快捷條，如使用大腳表情，快捷頻道切換等"

		WP_ENABLE_TEXT = "啟用密語管理";
		WP_ENABLE_TEXT_TOOLTIP= "記錄并提示玩家密語聊天信息";

		Enable_ItemLinkLevel_TEXT = "启用装备等级提示";
		Enable_ItemLinkLevel_TEXT_TOOLTIP= "提示优秀品质以上的装备等级及部位";

		QuickCompare_AchievementEnable_Text= "啟用成就對比";

		PLAYER_LINK_ENABLE_TEXT = "啟用鏈接增強";
		PLAYER_LINK_ENABLE_TEXT_TOOLTIP= "增強聊天窗口的玩家的鏈接功能";

		BFC_CONFIG="聊天配置"
		BFC_DISABLE_DELAY_TEXT = "|cff00c0c0<大腳聊天>|r 妳已經關閉大腳聊天(BigFootChat)模塊，該設置將在下次插件載入時生效。";
	else
		CHAT_ENHANCEMENT_TITLE = "Chat Enhancement";
		SCROLL_CHATFRAME_TEXT = "Allow using mouse wheel to scroll chat window";
		BFC_ENABLE_TEXT = "Enable BigFootChat"
		WP_ENABLE_TEXT = "Enable WhisperPop";
		PLAYER_LINK_ENABLE_TEXT = "Enhance player linke in chat window";
		BFC_CONFIG="Config BFC"

		Enable_ItemLinkLevel_TEXT = "Enable_ItemLinkLevel";
		Enable_ItemLinkLevel_TEXT_TOOLTIP= "";
	end

	if (IsConfigurableAddOn("QuickCompare") or IsConfigurableAddOn("BFGadgets") or IsConfigurableAddOn("PlayerLink") or IsConfigurableAddOn("WhisperPop") or IsConfigurableAddOn("BigFootChat")) then
		ModManagement_RegisterMod(
			"ChatEnhancement",
			"Interface\\Icons\\Spell_Magic_PolymorphChicken",
			CHAT_ENHANCEMENT_TITLE,
			"",
			nil,
			nil,
			{[3]=true,[7]=true}
		);
	end

	if (IsConfigurableAddOn("QuickCompare")) then
		ModManagement_RegisterCheckBox(
		"ChatEnhancement",
		QuickCompare_AchievementEnable_Text,
		nil,
		"EnableAchievementCompare",
		1,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("QuickCompare")) then
					BigFoot_LoadAddOn("QuickCompare");
				end
				if (BigFoot_IsAddOnLoaded("QuickCompare")) then
					QuickCompare_Toggle(true,2);
				end
			else
				if (BigFoot_IsAddOnLoaded("QuickCompare")) then
					QuickCompare_Toggle(false,2);
				end
			end
		end
		);
	end

	if (IsConfigurableAddOn("BFGadgets")) then
		ModManagement_RegisterCheckBox(
		"ChatEnhancement",
		Enable_ItemLinkLevel_TEXT,
		Enable_ItemLinkLevel_TEXT_TOOLTIP,
		"EnableItemLinkLevel",
		1,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("BFGadgets")) then
					BigFoot_LoadAddOn("BFGadgets");
				end
				if (BigFoot_IsAddOnLoaded("BFGadgets")) then
					bf_ItemLinkLevel_Toggle(true)
				end
			else
				if (BigFoot_IsAddOnLoaded("BFGadgets")) then
					bf_ItemLinkLevel_Toggle(false)
				end
			end
		end
		);
	end

	if (IsConfigurableAddOn("PlayerLink")) then
		ModManagement_RegisterCheckBox(
			"ChatEnhancement",
			PLAYER_LINK_ENABLE_TEXT,
			PLAYER_LINK_ENABLE_TEXT_TOOLTIP,
			"EnablePlayerLink",
			1,
			function(arg1)
				if (arg1 == 1) then
					if (not BigFoot_IsAddOnLoaded("PlayerLink")) then
						BigFoot_LoadAddOn("PlayerLink");
					end

					if (BigFoot_IsAddOnLoaded("PlayerLink")) then
						PlayerLink_Toggle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("PlayerLink")) then
						PlayerLink_Toggle(false);
					end
				end
			end
		);
	end

	if (IsConfigurableAddOn("WhisperPop")) then
		ModManagement_RegisterCheckBox(
			"ChatEnhancement",
			WP_ENABLE_TEXT,
			WP_ENABLE_TEXT_TOOLTIP,
			"EnableWhisperPop",
			1,
			function(arg1)
				if (arg1 == 1) then
					if (not BigFoot_IsAddOnLoaded("WhisperPop")) then
						BigFoot_LoadAddOn("WhisperPop");
					end

					if (BigFoot_IsAddOnLoaded("WhisperPop")) then
						WhisperPop_Toggle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("WhisperPop")) then
						WhisperPop_Toggle(false);
					end
				end
			end,
			nil,
			function(arg1)
				if (arg1 == 1) then
					if (not BigFoot_IsAddOnLoaded("WhisperPop")) then
						BigFoot_LoadAddOn("WhisperPop");
					end

					if (BigFoot_IsAddOnLoaded("WhisperPop")) then
						WhisperPop_Toggle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("WhisperPop")) then
						WhisperPop_Toggle(false);
					end
				end
			end
		);
	end

	if (IsConfigurableAddOn("BigFootChat")) then
		ModManagement_RegisterCheckBox(
			"ChatEnhancement",
			BFC_ENABLE_TEXT,
			BFC_ENABLE_TEXT_TOOLTIP,
			"EnableBFC",
			1,
			function(arg1)
				if (arg1 == 1) then
					if (not BigFoot_IsAddOnLoaded("BigFootChat")) then
						BigFoot_LoadAddOn("BigFootChat");
					end

					if (BigFoot_IsAddOnLoaded("BigFootChat")) then
						BigFootChat:Enable();
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("BigFootChat")) then
						BigFootChat:Disable();
						BigFoot_RequestReloadUI(function() BigFoot_Print(BFC_DISABLE_DELAY_TEXT); end);
					end
				end
			end,
			nil,
			function(arg1)
				if (arg1 == 1) then
					if (not BigFoot_IsAddOnLoaded("BigFootChat")) then
						BigFoot_LoadAddOn("BigFootChat");
					end

					if (BigFoot_IsAddOnLoaded("BigFootChat")) then
						BigFootChat:Enable();
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("BigFootChat")) then
						BigFootChat:Disable();
						BigFoot_RequestReloadUI(function() BigFoot_Print(BFC_DISABLE_DELAY_TEXT); end);
					end
				end
			end
		);

		ModManagement_RegisterButton(
			"ChatEnhancement",
			BFC_CONFIG,
			function()
				if BigFoot_IsAddOnLoaded("BigFootChat")  then
					BigFootChat:ShowOptions()
					PlaySound(SOUNDKIT.IG_MAINMENU_OPTION);
					HideUIPanel(ModManagementFrame);
				end
			end,
			nil,
			1
		);
	end
end

BigFoot_AddCollector(ChatEnhanceConfigFunc)
