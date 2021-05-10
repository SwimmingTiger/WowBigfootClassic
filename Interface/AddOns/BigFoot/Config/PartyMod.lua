
function PartyModConfigFunc()
	if (GetLocale() == "zhCN") then
		MOD_PARTY_ASSIST = {"组队工具", "zuduigongju",2};

		MOD_PARTY_ASSIST_ENABLE_TEXT = "开启组队施法";
		MOD_PARTY_ASSIST_ENABLE_TEXT_TOOLTIP = "允许你在队友头像旁边设置法术的快捷按钮以方便施放针对队友的增益魔法。";

		MOD_PARTY_ASSIST_8_BUTTONS = "允许放置8种魔法";
		MOD_PARTY_ASSIST_LITE_TIPS = "精简鼠标提示信息";

		MOD_CLIQUE_ENABLE_TEXT = "开启一键施法(Clique)";
		MOD_CLIQUE_ENABLE_TOOLTIP = "开启一键施法后，你可以在法术书上找到一键施法的设置界面。";

		TEAMNOTICE_ENABLE_PARTY_TEXT="开启小队公告"
		TEAMNOTICE_ENABLE_PARTY_TOOLTIP = "当有新队员加入到小队中时自动发送消息。"

		TEAMNOTICE_PARTY_CONFIG="设置小队公告"

		TEAMNOTICE_ENABLE_RAID_TEXT="开启团队公告及密语"
		TEAMNOTICE_ENABLE_RAID_TOOLTIP = "当有新队员加入到团队中时自动发送可设置的消息。"

		TEAMNOTICE_RAID_CONFIG="设置团队公告";

		CLIQUE_DISABLE_DELAY_TEXT = "|cff00c0c0<一键施法>|r 你已经关闭一键施法模块，该设置将在下次插件载入时生效。";

		-- BFGuildBar_Title = "开启公会技能助手"
		-- BFGuildBar_Title_ToolTip = "在组队状态下，大脚提供群体复活、组团出发等快捷技能栏"

	elseif (GetLocale() == "zhTW") then
		MOD_PARTY_ASSIST = {"組隊工具", "zuduigongju",2};

		MOD_PARTY_ASSIST_ENABLE_TEXT = "開啟組隊施法";
		MOD_PARTY_ASSIST_ENABLE_TEXT_TOOLTIP = "允許你在隊友頭像旁邊設置法術的快捷按鈕以方便施放針對隊友的增益魔法。";

		MOD_PARTY_ASSIST_8_BUTTONS = "允許放置8種魔法";
		MOD_PARTY_ASSIST_LITE_TIPS = "精簡滑鼠提示信息";

		MOD_CLIQUE_ENABLE_TEXT = "開啟一鍵施法(Clique)";
		MOD_CLIQUE_ENABLE_TOOLTIP = "開啟一鍵施法後，你可以在法術書上找到一鍵施法的設置介面。";

		TEAMNOTICE_ENABLE_PARTY_TEXT="開啟小隊公告"
		TEAMNOTICE_ENABLE_PARTY_TOOLTIP = "當有新隊員加入到小隊中時自動發送消息"

		TEAMNOTICE_PARTY_CONFIG="設置小隊公告"

		TEAMNOTICE_ENABLE_RAID_TEXT="開啟團隊公告及密語"
		TEAMNOTICE_ENABLE_RAID_TOOLTIP = "當有新隊員加入到團隊中時自動發送可設置的消息"

		TEAMNOTICE_RAID_CONFIG="設置團隊公告";

		CLIQUE_DISABLE_DELAY_TEXT = "|cff00c0c0<一鍵施法>|r 你已經關閉一鍵施法模組，該設置將在下次外掛程式載入時生效。";

		-- BFGuildBar_Title = "開啟公會技能助手"
		-- BFGuildBar_Title_ToolTip = "在組隊狀態下，大腳提供群體復活、組團出發等快捷技能"
	else
		MOD_PARTY_ASSIST = "Party Toolkit";

		MOD_PARTY_ASSIST_ENABLE_TEXT = "Enable PartyAssist";
		MOD_PARTY_ASSIST_ENABLE_TIP_TEXT = "Allow you place some spell on the right of party member portraits.";

		MOD_PARTY_ASSIST_8_BUTTONS = "Set 8 spell buttons";
		MOD_PARTY_ASSIST_LITE_TIPS = "Simple Tips";

		MOD_CLIQUE_ENABLE_TEXT = "Enable Clique";
		MOD_CLIQUE_ENABLE_TOOLTIP = "After clique is enabled, you can find setting interface in your spellbook.";

		TEAMNOTICE_ENABLE_PARTY_TEXT="Open squad announcement"
		TEAMNOTICE_ENABLE_PARTY_TOOLTIP = "When a new players to join squad automatic messaging."

		TEAMNOTICE_PARTY_CONFIG="Set Team announcement"

		TEAMNOTICE_ENABLE_RAID_TEXT="Open raid announcement and code"
		TEAMNOTICE_ENABLE_RAID_TOOLTIP = "When a new players join hitting send messages can be set."

		TEAMNOTICE_RAID_CONFIG="Setting Raid announcement";
		CLIQUE_DISABLE_DELAY_TEXT = "|cff00c0c0<Clique>|r Clique has been disabled. This setting will be available next time.";
	end

	if (IsConfigurableAddOn("PartyAssist") or IsConfigurableAddOn("Clique") or IsConfigurableAddOn("BFQuest") or IsConfigurableAddOn("BFGuildBar")) then
		ModManagement_RegisterMod(
			"PartyToolkit",
			"Interface\\Icons\\trade_engineering",
			MOD_PARTY_ASSIST,
			"",
			nil,
			nil,
			{[4]=true},
			true,
			"230"
		);

		if (IsConfigurableAddOn("PartyAssist")) then
			ModManagement_RegisterCheckBox(
				"PartyToolkit",
				MOD_PARTY_ASSIST_ENABLE_TEXT,
				MOD_PARTY_ASSIST_ENABLE_TEXT_TOOLTIP,
				"EnablePartyAssist",
				0,
				function (arg)
					if ( arg == 1 ) then
						if (not BigFoot_IsAddOnLoaded("PartyAssist")) then
							BigFoot_LoadAddOn("PartyAssist");
						end

						if (BigFoot_IsAddOnLoaded("PartyAssist")) then
							PartyAssist_Toggle(true);
						end
					else
						if (BigFoot_IsAddOnLoaded("PartyAssist")) then
							PartyAssist_Toggle(false);
						end
					end
				end
			);

			ModManagement_RegisterCheckBox(
				"PartyToolkit",
				MOD_PARTY_ASSIST_8_BUTTONS,
				nil,
				"8Buttons",
				0,
				function (arg)
					if (BigFoot_IsAddOnLoaded("PartyAssist")) then
						if (arg == 1) then
							PartyAssist_Toggle8Buttons(true);
						else
							PartyAssist_Toggle8Buttons(false);
						end
					end
				end,
				1
			);

			ModManagement_RegisterCheckBox(
				"PartyToolkit",
				MOD_PARTY_ASSIST_LITE_TIPS,
				nil,
				"LiteTips",
				1,
				function (arg)
					if (BigFoot_IsAddOnLoaded("PartyAssist")) then
						if (arg == 1) then
							PartyAssist_ToggleTipMod(true);
						else
							PartyAssist_ToggleTipMod(false);
						end
					end
				end,
				1
			);
		end

		if (IsConfigurableAddOn("Clique")) then
			ModManagement_RegisterCheckBox(
				"PartyToolkit",
				MOD_CLIQUE_ENABLE_TEXT,
				MOD_CLIQUE_ENABLE_TOOLTIP,
				"EnableClique",
				0,
				function (__arg)
					if (__arg == 1) then
						if (not BigFoot_IsAddOnLoaded("Clique")) then
							BigFoot_LoadAddOn("Clique");
						end
					else
						if (BigFoot_IsAddOnLoadedFromBigFoot("Clique")) then
							BigFoot_RequestReloadUI(function() BigFoot_Print(CLIQUE_DISABLE_DELAY_TEXT); end);
						end
					end
				end
			);
		end

		if (IsConfigurableAddOn("BFQuest")) then
			ModManagement_RegisterCheckBox(
				"PartyToolkit",
				TEAMNOTICE_ENABLE_PARTY_TEXT,
				TEAMNOTICE_ENABLE_PARTY_TOOLTIP,
				"EnableTeamNoticeParty",
				1,
				function (arg)
					if (not BigFoot_IsAddOnLoadedFromBigFoot("BFQuest")) then
						BigFoot_LoadAddOn("BFQuest");
					end
					if (arg == 1) then
						LibStub("AceAddon-3.0"):GetAddon("BFQuest"):EnableModule("TeamNotice")
					else
						LibStub("AceAddon-3.0"):GetAddon("BFQuest"):DisableModule("TeamNotice")
					end
					Auto_TeamNotice_Party(arg);
				end
			);

			ModManagement_RegisterButton(
				"PartyToolkit",
				TEAMNOTICE_PARTY_CONFIG,
				function()
					if (not BigFoot_IsAddOnLoadedFromBigFoot("BFQuest")) then
						BigFoot_LoadAddOn("BFQuest");
					end
					StaticPopup_Show("TEAMNOTICE_PARTY_COMMENT");
					PlaySound(SOUNDKIT.IG_MAINMENU_OPTION);
					HideUIPanel(ModManagementFrame);
				end,
				nil,
				1
			);

			ModManagement_RegisterCheckBox(
				"PartyToolkit",
				TEAMNOTICE_ENABLE_RAID_TEXT,
				TEAMNOTICE_ENABLE_RAID_TOOLTIP,
				"EnableTeamNoticeRaid",
				1,
				function (arg)
					if (not BigFoot_IsAddOnLoadedFromBigFoot("BFQuest")) then
						BigFoot_LoadAddOn("BFQuest");
					end
					if (arg == 1) then
						LibStub("AceAddon-3.0"):GetAddon("BFQuest"):EnableModule("TeamNotice")
					else
						LibStub("AceAddon-3.0"):GetAddon("BFQuest"):DisableModule("TeamNotice")
					end
					Auto_TeamNotice_Raid(arg);
				end
			);

			ModManagement_RegisterButton(
				"PartyToolkit",
				TEAMNOTICE_RAID_CONFIG,
				function()
					if (not BigFoot_IsAddOnLoadedFromBigFoot("BFQuest")) then
						BigFoot_LoadAddOn("BFQuest");
					end
					StaticPopup_Show("TEAMNOTICE_SET_COMMENT");
					PlaySound(SOUNDKIT.IG_MAINMENU_OPTION);
					HideUIPanel(ModManagementFrame);
				end,
				nil,
				1
			);
		end

		-- if (IsConfigurableAddOn("BFGuildBar")) then
			-- ModManagement_RegisterCheckBox(
				-- "PartyToolkit",
				-- BFGuildBar_Title,
				-- BFGuildBar_Title_ToolTip,
				-- "EnableBFGuildBar",
				-- 1,
				-- function (arg)
					-- if ( arg == 1 ) then
						-- if (not BigFoot_IsAddOnLoaded("BFGuildBar")) then
							-- BigFoot_LoadAddOn("BFGuildBar");
						-- end

						-- if (BigFoot_IsAddOnLoaded("BFGuildBar")) then
							-- BFGuildBar_Toggle(true)
						-- end
					-- else
						-- if (BigFoot_IsAddOnLoaded("BFGuildBar")) then
							-- BFGuildBar_Toggle(false)
						-- end
					-- end
				-- end
			-- );
		-- end

	end
end

BigFoot_AddCollector(PartyModConfigFunc)