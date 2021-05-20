
function InfoBoxConfigFunc()
	local _G = _G

	local frameList = {
		PlayerFrame,
		TargetFrame,
		FocusFrame
	}

	local function getFramePoint(frame)
		local point,anchor,refPoint,x,y = frame:GetPoint()
		anchor = anchor and anchor:GetName() or "UIParent"
		return point,anchor,refPoint,x,y
	end

	local function setFramePoint(frame,...)
		if InCombatLockdown() then return end
		frame:SetUserPlaced(true)
		local point,anchor,refPoint,x,y = ...
		frame:ClearAllPoints()
		frame:SetPoint(point,_G[anchor]or UIParent,refPoint,x,y)
	end

	local function BigFoot_SaveUIFrames()
		BigFoot_Config = BigFoot_Config or {}
		BigFoot_Config.useUiScale = GetCVar("useUiScale")
		BigFoot_Config.uiscale = GetCVar("uiscale")
		local frameLoc = {}
		for _,frame in ipairs(frameList) do
			frameLoc[frame:GetName()]={getFramePoint(frame)}
		end
		BigFoot_Config.frameLoc = frameLoc
	end

	local function BigFoot_ResetUIFrames()
		if BigFoot_Config.useUiScale then
			SetCVar("useUiScale",BigFoot_Config.useUiScale)
			BigFoot_Config.useUiScale = nil
		end
		if BigFoot_Config.uiscale then
			SetCVar("uiscale",BigFoot_Config.uiscale)
			BigFoot_Config.uiscale = nil
		end

		if BigFoot_Config.frameLoc then
			if CompactRaidFrameManager then
				PartyMemberFrame1:SetPoint("TOPLEFT", CompactRaidFrameManager, "TOPRIGHT", 0, -20);
			else
				PartyMemberFrame1:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 10, -128);
			end
			PartyMemberFrame2:SetPoint("TOPLEFT",PartyMemberFrame1PetFrame,"BOTTOMLEFT",-23,-10)
			PartyMemberFrame3:SetPoint("TOPLEFT",PartyMemberFrame2PetFrame,"BOTTOMLEFT",-23,-10)
			PartyMemberFrame4:SetPoint("TOPLEFT",PartyMemberFrame3PetFrame,"BOTTOMLEFT",-23,-10)
			--load other frames locations
			local frameLoc = BigFoot_Config.frameLoc
			for _,frame in ipairs(frameList) do
				setFramePoint(frame,unpack(frameLoc[frame:GetName()]))
			end
			BigFoot_Config.frameLoc = nil;
		end
	end

	if (GetLocale() == "zhCN") then
		MOD_INFOBOX_TITLE = {"界面调整", "jiemiantiaozheng"};

		INFOBOX_ENABLE_TITLE = "开启界面调整";
		INFOBOX_ENABLE_TITLE_TOOLTIP = "当鼠标移动到屏幕顶端弹出界面调整主菜单，通过该菜单你可以调整你所需要的界面";
		BT4_CONFIG_PANEL = "配置界面调整";

		BT4_MOVE_BUFF_BAR = "通过界面调整拖动Buff栏";
		BT4_MOVE_BUFF_BAR_TOOLTIP = "开启后“目标的目标”功能将出现问题，在战斗中不能正确更新，请谨慎选择";

		BT4_MOVE_UINT_FRAME = "通过界面调整拖动单位框体";
		BT4_MOVE_UINT_FRAME_TOOLTIP = "开启后玩家和目标框体可在界面解锁时拖动。\n但其实不需要开启该功能，直接在框体上右击，选择“移动框体”，再选择“解锁框体”即可拖动。\n注意：开启该功能后，一键换装可能无法正常点击，并且框体位置将由界面调整接管，只有在界面调整里拖动的位置可以保存。";


		BLIZZMOVE_ENABLE_TITLE = "开启窗体移动";
		BLIZZMOVE_ENABLE_TITLE_TOOLTIP = "任意拖动任意窗体，并通过Ctrl+滚轮对当前窗体进行缩放。";

		BFGOLDFRAME_ENABLE_TITLE = "开启金币统计"
		BFGOLDFRAME_ENABLE_TITLE_TOOLTIP= "快捷监视当前金币的框体，并可记录金币变化信息"

		BLIZZMOVE_DISABLE_DELAY_TEXT ="|cff00c0c0<窗体移动>|r 你已经关闭窗体移动模块，该设置将在下次插件载入时生效。";
		BARTENDER4_DISABLE_DELAY_TEXT = "|cff00c0c0<界面调整>|r 你已经关闭界面调整模块，该设置将在下次插件载入时生效。";

		MASQUEENABLE = "开启界面美化"
		MASQUEENABLEOPTION = "配置界面美化"
		BUFFDISABLE = "禁用默认BUFF按钮组美化"

	elseif (GetLocale() == "zhTW") then
		MOD_INFOBOX_TITLE = {"介面調整", "jiemiantiaozheng"};

		INFOBOX_ENABLE_TITLE = "開啟介面調整";
		INFOBOX_ENABLE_TITLE_TOOLTIP = "當鼠標移動到屏幕頂端彈出介面調整菜單，通過該菜單你可以調整你所需要的介面";
		BT4_CONFIG_PANEL = "配置介面調整";

		BT4_MOVE_BUFF_BAR = "通過界面調整拖動Buff欄";
		BT4_MOVE_BUFF_BAR_TOOLTIP = "開啟後“目標的目標”功能將出現問題，在戰鬥中不能正確更新，請謹慎選擇";

		BT4_MOVE_UINT_FRAME = "通過界面調整拖動單位框體";
		BT4_MOVE_UINT_FRAME_TOOLTIP = "開啟後玩家和小隊成員框體將可在界面解鎖時拖動。\n但其實不需要開啟該功能，直接在框體上右擊，選擇“移動框體”，再選擇“解鎖框體”即可拖動。\n註意：開啟該功能後，一鍵換裝可能無法正常點擊，並且框體位置將由界面調整接管，只有在界面調整裡拖動的位置可以保存。";

		BLIZZMOVE_ENABLE_TITLE = "開啟窗體移動";
		BLIZZMOVE_ENABLE_TITLE_TOOLTIP = "任意拖動任意窗體，並通過Ctrl+滾輪對當前窗體進行縮放。";

		BFGOLDFRAME_ENABLE_TITLE = "開啟金幣統計"
		BFGOLDFRAME_ENABLE_TITLE_TOOLTIP= "快捷監視當前金幣的框體，并可記錄金幣變化信息"

		BLIZZMOVE_DISABLE_DELAY_TEXT = "|cff00c0c0<窗體移動>|r 你已經關閉窗體移動模組，該設置將在下次插件載入時生效。";
		BARTENDER4_DISABLE_DELAY_TEXT = "|cff00c0c0<介面調整>|r 你已經關閉窗介面調整模組，該設置將在下次插件載入時生效。";

		MASQUEENABLE = "開啟界面美化"
		MASQUEENABLEOPTION = "配置介面美化"
		BUFFDISABLE = "禁用默認BUFF按鈕組美化"

	else
		MOD_INFOBOX_TITLE = "InfoBox";
		INFOBOX_ENABLE_TITLE = "Enable InfoBox";
		BT4_CONFIG_PANEL = "Config Infobox";

		BT4_MOVE_BUFF_BAR = "Allow BT4 to move the buff/debuff bar";
		BT4_MOVE_BUFF_BAR_TOOLTIP = "After enabling this feature, the \"Target of Target\" cannot be updated correctly during the battle. Please choose carefully";

		BT4_MOVE_UINT_FRAME = "Allow BT4 to move unit frames";
		BT4_MOVE_UINT_FRAME_TOOLTIP = "After enabling, the player and target frames will be able to move when the interface is unlocked via BT4.\nHowever, you don't need to enable this feature, you can right-click on the frame and unlock it to move.\nNote: Once the feature is enabled, the frame of AutoEquip may not be able to click, and the position of the frame will be taken over by BT4, so only the position moved via BT4 can be saved.";

		BLIZZMOVE_ENABLE_TITLE = "Enable BlizzMove";
		BFGOLDFRAME_ENABLE_TITLE = "Enable GoldFrame"
		BFGOLDFRAME_ENABLE_TOOLTIP = "Enable GoldFrame"
		BLIZZMOVE_DISABLE_DELAY_TEXT = "|cff00c0c0<BlizzMove>|r has been disabled. This setting will be available next time.";
		BLIZZMOVE_DISABLE_DELAY_TEXT = "|cff00c0c0<Bartender4>|r has been disabled. This setting will be available next time.";

	end

	if (IsConfigurableAddOn("Bartender4_BFMod") or IsConfigurableAddOn("BFGoldFrame") or IsConfigurableAddOn("BlizzMove") or IsConfigurableAddOn("Masque")) then
		ModManagement_RegisterMod(
			"InfoBox",
			"Interface\\Icons\\INV_Misc_StoneTablet_11",
			MOD_INFOBOX_TITLE,
			"",
			nil,
			nil,
			{[3]=true}
		);
	end

	if (IsConfigurableAddOn("Masque")) then
		ModManagement_RegisterCheckBox(
			"InfoBox",
			MASQUEENABLE,
			nil,
			"EnableMasque",
			nil,
			function (__arg)
				if ( __arg == 1 ) then
					if not BigFoot_IsAddOnLoadedFromBigFoot("Masque") then
						BigFoot_LoadAddOn("Masque")
					end
					if not BigFoot_IsAddOnLoadedFromBigFoot("ButtonFacade") then
						BigFoot_LoadAddOn("ButtonFacade")
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("Masque")) then
						BigFoot_RequestReloadUI();
					end
				end
			end,
			nil
		);

		ModManagement_RegisterCheckBox(
			"InfoBox",
			BUFFDISABLE,
			nil,
			"Masque_BuffDisable",
			1,
			function (__arg)
				if ( __arg == 1 ) then
					if BigFoot_IsAddOnLoadedFromBigFoot("ButtonFacade") then
						BF_EnableBuffGroup(false)
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("ButtonFacade")) then
						BF_EnableBuffGroup(true)
					end
				end
			end,
			1
		);

		ModManagement_RegisterButton(
			"InfoBox",
			MASQUEENABLEOPTION,
			function ()
				if (BigFoot_IsAddOnLoaded("Masque")) then
					InterfaceOptionsFrame_OpenToCategory("Masque")
				end
			end,
			nil,
			1
		);
	end

	if (IsConfigurableAddOn("Bartender4_BFMod")) then
		ModManagement_RegisterCheckBox(
			"InfoBox",
			INFOBOX_ENABLE_TITLE,
			INFOBOX_ENABLE_TITLE_TOOLTIP,
			"EnableInfoBoxV2",
			0,
			function (__arg)
				if ( __arg == 1 ) then
					if (not BigFoot_IsAddOnLoaded("Bartender4")) then
						Bartender4DB = Bartender4DB or {};
						BigFoot_LoadAddOn("Bartender4");
					end
					if (not BigFoot_IsAddOnLoaded("Bartender4_BFMod")) then
						BigFoot_SaveUIFrames()
						BigFoot_LoadAddOn("Bartender4_BFMod");
					end

				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("Bartender4_BFMod")) then
						BigFoot_RequestReloadUI(function() BigFoot_Print(BARTENDER4_DISABLE_DELAY_TEXT); end);
					end
				end
			end,
			nil,
			function (__arg)
				if ( __arg == 1 ) then
					if (not BigFoot_IsAddOnLoaded("Bartender4")) then
						Bartender4DB = Bartender4DB or {};
						BigFoot_LoadAddOn("Bartender4");
					end
					if (not BigFoot_IsAddOnLoaded("Bartender4_BFMod")) then
						BigFoot_LoadAddOn("Bartender4_BFMod");
					end

				else
					---------插件没有载入的时候重置已设置的窗体-------------
					BigFoot_ResetUIFrames()
				end
			end
		);

		ModManagement_RegisterButton(
			"InfoBox",
			BT4_CONFIG_PANEL,
			function ()
				if (BigFoot_IsAddOnLoaded("Bartender4_BFMod")) then
					LibStub("AceConfigDialog-3.0"):Open("Bartender4")
					HideUIPanel(ModManagementFrame);
				end
			end,
			nil,
			1
		);

		-- 增加Buff栏和单位框体移动功能的开关
		-- Buff栏移动有副作用，会导致“目标的目标”在战斗中不能更新
		-- 单位框体移动则没有必要启用，因为暴雪已允许用户解锁并移动框体。并且开启该功能会导致用户(不通过BT4)直接拖动框体位置后不能保存
		Bartender4Features = Bartender4Features or {};

		ModManagement_RegisterCheckBox(
			"InfoBox",
			BT4_MOVE_BUFF_BAR,
			BT4_MOVE_BUFF_BAR_TOOLTIP,
			"EnableBT4MoveBuffBar",
			0,
			function (__arg)
				Bartender4Features.moveBuffBar = (__arg == 1)
				if IsAddOnLoaded("Bartender4_BFMod") then
					BigFoot_RequestReloadUI();
				end
			end,
			nil,
			function (__arg)
				Bartender4Features.moveBuffBar = (__arg == 1)
			end
		);

		ModManagement_RegisterCheckBox(
			"InfoBox",
			BT4_MOVE_UINT_FRAME,
			BT4_MOVE_UINT_FRAME_TOOLTIP,
			"EnableBT4MoveUintFrame",
			0,
			function (__arg)
				Bartender4Features.moveUintFrame = (__arg == 1)
				if IsAddOnLoaded("Bartender4_BFMod") then
					BigFoot_RequestReloadUI();
				end
			end,
			nil,
			function (__arg)
				Bartender4Features.moveUintFrame = (__arg == 1)
			end
		);
	end

	if (IsConfigurableAddOn("BlizzMove")) then
		ModManagement_RegisterCheckBox(
			"InfoBox",
			BLIZZMOVE_ENABLE_TITLE,
			BLIZZMOVE_ENABLE_TITLE_TOOLTIP,
			"EnableBlizzMove",
			1,
			function (__arg)
				if ( __arg == 1 ) then
					if (not BigFoot_IsAddOnLoaded("BlizzMove")) then
						BigFoot_LoadAddOn("BlizzMove");
						BigFoot_RequestReloadUI(function() BigFoot_Print(BLIZZMOVE_DISABLE_DELAY_TEXT); end);
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("BlizzMove")) then
						BigFoot_RequestReloadUI(function() BigFoot_Print(BLIZZMOVE_DISABLE_DELAY_TEXT); end);
					end
				end
			end,
			nil,
			function(__arg)
				if (__arg == 1) then
					if (not BigFoot_IsAddOnLoaded("BlizzMove")) then
						BigFoot_LoadAddOn("BlizzMove");
					end
				end
			end
		);
	end

	if (IsConfigurableAddOn("BFGoldFrame")) then
		ModManagement_RegisterCheckBox(
			"InfoBox",
			BFGOLDFRAME_ENABLE_TITLE,
			BFGOLDFRAME_ENABLE_TITLE_TOOLTIP,
			"EnableBFGoldFrame",
			nil,
			function (__arg)
				if ( __arg == 1 ) then
					if (not BigFoot_IsAddOnLoaded("BFGoldFrame")) then
						BigFoot_LoadAddOn("BFGoldFrame");
					end
					BFGoldFrame_Toggle(true)
				else
					if ( BigFoot_IsAddOnLoaded("BFGoldFrame")) then
						BFGoldFrame_Toggle(false)
					end
				end
			end,
			nil
		);
	end
end

BigFoot_AddCollector(InfoBoxConfigFunc)