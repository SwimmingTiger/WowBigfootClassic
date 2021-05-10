
function QuestEnhanceConfigFunc()
	if (GetLocale() == "zhCN") then
		MOD_QUEST_ENHANCEMENT_TITLE = {"任务增强", "renwuzengqiang"};

		ENABLE_BIGFOOTQUEST_TEXT_TOOLTIP= "提供任务给予及交付NPC的位置和任务物品获得方式提示";

		ENABLE_QUESTINFO_TEXT = "启用可接任务查询(Wholly)";
		ENABLE_QUESTINFO_TEXT_TOOLTIP = "占用内存较大,请慎重使用";
		ENABLE_Wholly_TEXT = "可接任务提示"
		ENABLE_Wholly_Confirm = "功能开启需几秒加载,占用较高请选择性使用"

		ENABLE_QUEST_FastQuest_TEXT	= "小队任务公告";
		ENABLE_QUEST_FastQuest_TOOLTIP = "在小队模式下公布你的任务进度";

		ENABLE_QUEST_FastQuestInfo_TEXT	= "详细任务进度";
		ENABLE_QUEST_FastQuestInfo_TOOLTIP = "公布具体的任务更新进程";

		ENABLE_TurnIn_TEXT = "自动交接任务";
		ENABLE_TurnIn_Switch= "配置";

		ENABLE_WorldQuestTracker_TEXT = "启用世界任务增强";

		BF_DISABLE_BFQ_TIP = "|cff00c0c0<大脚任务>|r 你已经关闭大脚任务(BigFootQuest)模块，该设置将在下次插件载入时生效。";
		BF_DISABLE_QI_TIP = "|cff00c0c0<任务查询>|r 你已经关闭任务查询(Wholly)模块，该设置将在下次插件载入时生效。";

	elseif (GetLocale() == "zhTW") then
		MOD_QUEST_ENHANCEMENT_TITLE = {"任務增強", "renwuzengqiang"};

		ENABLE_BIGFOOTQUEST_TEXT_TOOLTIP= "提供任務給予及交付NPC的位置和任務物品獲得方式提示";

		ENABLE_QUESTINFO_TEXT = "啟用可接任務查詢(Wholly)";
		ENABLE_QUESTINFO_TEXT_TOOLTIP= "佔用內存較大,請慎重使用";
		ENABLE_Wholly_TEXT = "可接任務提示"
		ENABLE_Wholly_Confirm = "功能开启需几秒加载,占用较高请选择性使用"

		ENABLE_QUEST_FastQuest_TEXT	= "小隊任務公告";
		ENABLE_QUEST_FastQuest_TOOLTIP = "在組隊模式下公佈你的任務進度";

		ENABLE_QUEST_FastQuestInfo_TEXT	= "詳細任務進度";
		ENABLE_QUEST_FastQuestInfo_TOOLTIP = "公佈具體的任務更新進程";

		ENABLE_TurnIn_TEXT = "自动交接任务";
		ENABLE_TurnIn_Switch= "配置";

		ENABLE_WorldQuestTracker_TEXT = "啟用世界任務增強";

		BF_DISABLE_BFQ_TIP = "|cff00c0c0<大腳任務>|r 你已經關閉大腳任務(BigFootQuest)模組，該設置將在下次外掛程式載入時生效。";
		BF_DISABLE_QI_TIP = "|cff00c0c0<任務查詢>|r 你已经關閉任務查詢(Wholly)模块，該設置將在下次外掛程式載入時生效。";
	else
		MOD_QUEST_ENHANCEMENT_TITLE = "Quest Enhance"
		ENABLE_QUESTINFO_TEXT = "Enable Wholly";
		ENABLE_Wholly_TEXT = "Shows quest"
		ENABLE_Wholly_Confirm = ""

		ENABLE_QUEST_FastQuest_TEXT	= "Squad announcement task";
		ENABLE_QUEST_FastQuest_TOOLTIP = "In group mode to publish your task progress.";

		ENABLE_QUEST_FastQuestInfo_TEXT	= "Detailed task progress";
		ENABLE_QUEST_FastQuestInfo_TOOLTIP = "Announce specific mission update process.";

		ENABLE_TurnIn_TEXT = "Automatic handover task";
		ENABLE_TurnIn_Switch= "configuration";

		BF_DISABLE_BFQ_TIP = "|cff00c0c0<Quest Enhancement>|r BigFootQuest has been disabled. This setting will be available next time.";
		BF_DISABLE_QI_TIP ="|cff00c0c0<Quest Enhancement>|r Wholly has been disabled. This setting will be available next time.";

	end

	if (IsConfigurableAddOn("Wholly") or IsConfigurableAddOn("BFQuest") or IsConfigurableAddOn("TurnIn") or IsConfigurableAddOn("WorldQuestTracker") ) then
		ModManagement_RegisterMod(
			"QuestEnhancement",
			"Interface\\Icons\\INV_Misc_Note_02",
			MOD_QUEST_ENHANCEMENT_TITLE,
			"",
			nil,
			nil,
			{[6]=true},
			true,
			"230"
		);
	end

	if IsConfigurableAddOn("Wholly") then
		local needreload;
		local function loadWholly()
			if (not BigFoot_IsAddOnLoaded("Grail")) then
				BigFoot_LoadAddOn("Grail");
			end
			if (not BigFoot_IsAddOnLoaded("Wholly")) then
				BigFoot_LoadAddOn("Wholly");
			end
		end

		StaticPopupDialogs["ENABLE_Wholly_Confirm"] = {
			text = ENABLE_Wholly_Confirm,
			button1 = ACCEPT,
			button2 = CANCEL,
			OnAccept = function(self)
				loadWholly();
				HideUIPanel(WorldMapFrame);
				WhollyDatabase.displaysMapPins = true;
				Wholly.pairedConfigurationButton:SetChecked(true);
				Wholly:_UpdatePins();
			end,
			OnCancel = function(self)
				WhollyLoaderCheckButton:SetChecked(false);
				BigFoot_SetModVariable("QuestEnhancement", "EnableWholly", 0);
				ModManagement_Refresh();
			end,
		};

		local check = CreateFrame("CheckButton", "WhollyLoaderCheckButton", WorldMapFrame.ScrollContainer, "InterfaceOptionsBaseCheckButtonTemplate");
		check:SetWidth(26);
		check:SetHeight(26);
		check:SetPoint("TOPRIGHT", WorldMapFrame.ScrollContainer, "TOPRIGHT", -151, -6);
		check:SetFrameLevel(check:GetFrameLevel()+2);
		-- check:SetChecked(WhollyDatabase.displaysMapPins);
		check.text = check:CreateFontString();
		check.text:SetFont(GameTooltipHeader:GetFont(), 16, "OUTLINE");
		check.text:SetTextColor(1, 1, 1, 1);
		check.text:SetText(ENABLE_Wholly_TEXT);
		check.text:SetPoint("LEFT", check, "RIGHT");
		check:SetScript("OnClick", function(self, button)
			if (self:GetChecked()) then
				BigFoot_SetModVariable("QuestEnhancement", "EnableWholly", 1);
				if not needreload then
					StaticPopup_Show("ENABLE_Wholly_Confirm");
				else
					WhollyDatabase.displaysMapPins = true;
					Wholly.pairedConfigurationButton:SetChecked(true);
					Wholly:_UpdatePins();
				end
			else
				if (BigFoot_IsAddOnLoadedFromBigFoot("Wholly")) then
					if not needreload then
						BigFoot_RequestReloadUI(function()
							BigFoot_Print(BF_DISABLE_QI_TIP);
							WhollyDatabase.displaysMapPins = false;
							Wholly.pairedConfigurationButton:SetChecked(false);
							Wholly:_UpdatePins();
							needreload = true;
						end);
					else
						WhollyDatabase.displaysMapPins = false;
						Wholly.pairedConfigurationButton:SetChecked(false);
						Wholly:_UpdatePins();
					end
				end
				BigFoot_SetModVariable("QuestEnhancement", "EnableWholly", 0);
			end
		end);

		ModManagement_RegisterCheckBox(
			"QuestEnhancement",
			ENABLE_QUESTINFO_TEXT,
			ENABLE_QUESTINFO_TEXT_TOOLTIP,
			"EnableWholly",
			0,
			function (arg)
				if (arg == 1) then
					WhollyLoaderCheckButton:SetChecked(true);
					if not needreload then
						StaticPopup_Show("ENABLE_Wholly_Confirm");
					else
						WhollyDatabase.displaysMapPins = true;
						Wholly.pairedConfigurationButton:SetChecked(true);
						Wholly:_UpdatePins();
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("Wholly")) then
						if not needreload then
							BigFoot_RequestReloadUI(function()
								BigFoot_Print(BF_DISABLE_QI_TIP);
								WhollyDatabase.displaysMapPins = false;
								Wholly.pairedConfigurationButton:SetChecked(false);
								Wholly:_UpdatePins();
								needreload = true;
							end);
						else
							WhollyDatabase.displaysMapPins = false;
							Wholly.pairedConfigurationButton:SetChecked(false);
							Wholly:_UpdatePins();
						end
					end
					WhollyLoaderCheckButton:SetChecked(false);
				end
			end,
			nil,
			function (arg)
				if (arg == 1) then
					loadWholly();
					WhollyDatabase.displaysMapPins = true;
					Wholly.pairedConfigurationButton:SetChecked(true);
					Wholly:_UpdatePins();
					WhollyLoaderCheckButton:SetChecked(true);
				end
			end
		);
	end

	if IsConfigurableAddOn("BFQuest") then
		ModManagement_RegisterCheckBox(
			"QuestEnhancement",
			ENABLE_QUEST_FastQuest_TEXT,
			ENABLE_QUEST_FastQuest_TOOLTIP,
			"EnableQuestBroad",
			1,
			function (arg)
				if (not BigFoot_IsAddOnLoadedFromBigFoot("BFQuest")) then
					BigFoot_LoadAddOn("BFQuest");
				end
				if (arg == 1) then
					LibStub("AceAddon-3.0"):GetAddon("BFQuest"):EnableModule("Broadcast")
				else
					LibStub("AceAddon-3.0"):GetAddon("BFQuest"):DisableModule("Broadcast")
				end
			end
		);

		ModManagement_RegisterCheckBox(
			"QuestEnhancement",
			ENABLE_QUEST_FastQuestInfo_TEXT,
			ENABLE_QUEST_FastQuestInfo_TOOLTIP,
			"EnableQuestBroadInfo",
			nil,
			function (arg)
				if (not BigFoot_IsAddOnLoadedFromBigFoot("BFQuest")) then
					BigFoot_LoadAddOn("BFQuest");
				end
				Auto_FastQuestInfo(arg)
			end,
			1
		);
	end

	if IsConfigurableAddOn("TurnIn") then
		ModManagement_RegisterCheckBox(
			"QuestEnhancement",
			ENABLE_TurnIn_TEXT,
			nil,
			"EnableTurnIn",
			0,
			function (arg)
				if not BigFoot_IsAddOnLoaded("TurnIn") then
					BigFoot_LoadAddOn("TurnIn")
				end
				if (arg == 1) then
					if (BigFoot_IsAddOnLoaded("TurnIn")) then
						bfTI_Check(1)
					end
				else
					if (BigFoot_IsAddOnLoaded("TurnIn")) then
						bfTI_Check(0)
					end
				end
			end
		);

		ModManagement_RegisterButton(
			"QuestEnhancement",
			ENABLE_TurnIn_Switch,
			function()
				if (BigFoot_IsAddOnLoaded("TurnIn")) then
					TI_SlashCmdHandler("window");
				end
			end,
			nil,
			1
		);

	end

	if IsConfigurableAddOn("WorldQuestTracker") then
		ModManagement_RegisterCheckBox(
			"QuestEnhancement",
			ENABLE_WorldQuestTracker_TEXT,
			nil,
			"EnableWorldQuestTracker",
			1,
			function (arg)
				if ( arg == 1 ) then
					if not BigFoot_IsAddOnLoaded("WorldQuestTracker") then
						BigFoot_LoadAddOn("WorldQuestTracker");
					end
				else
					if BigFoot_IsAddOnLoaded("WorldQuestTracker") then
						BigFoot_RequestReloadUI()
					end
				end
			end
		);
	end
end

BigFoot_AddCollector(QuestEnhanceConfigFunc)