
function PorEnhanceConfigFunc()
	if ( GetLocale() == "zhCN" ) then
		MOD_ENHANCEMENT_TITLE={"头像增强", "touxiangzengqiang"};
		PORTRAIT_ENHANCEMENT_ENABLE_TEXT = "开启玩家头像额外信息";
		PORTRAIT_ENHANCEMENT_ENABLE_XP_BAR = "显示经验条";
		PORTRAIT_ENHANCEMENT_COLORIZE_TEXT = "根据血量改变颜色";
		PORTRAIT_ENHANCEMENT_ENABLE_PARTY_TEXT = "开启队友头像额外信息";
		PORTRAIT_ENHANCEMENT_ENABLE_PARTY_TARGET = "开启队友目标";
		PORTRAIT_ENHANCEMENT_ENABLE_PARTY_CASTBAR = "开启队友施法条";
		PORTRAIT_ENHANCEMENT_SHOW_PARTY_TEXT = "显示队友血量数值";
		PORTRAIT_ENHANCEMENT_FORMAT_TEXT = "以万为单位计算血量";
		PORTRAIT_ENHANCEMENT_ENABLE_TARGET_CLASS_INFO = "开启目标职业显示";
		PORTRAIT_ENHANCEMENT_SHOW_3D_PORTRAIT = "显示3D头像";
		PORTRAIT_ENHANCEMENT_Enable_EasyFrames = "开启简易头像框"
	elseif (GetLocale() == "zhTW") then
		MOD_ENHANCEMENT_TITLE={"頭像增強", "touxiangzengqiang"};
		PORTRAIT_ENHANCEMENT_ENABLE_TEXT = "開啟頭像訊息顯示";
		PORTRAIT_ENHANCEMENT_ENABLE_XP_BAR = "顯示經驗條";
		PORTRAIT_ENHANCEMENT_COLORIZE_TEXT = "根據血量改變血條顏色";
		PORTRAIT_ENHANCEMENT_ENABLE_PARTY_TEXT = "開啟隊友信息顯示";
		PORTRAIT_ENHANCEMENT_ENABLE_PARTY_TARGET = "開啟隊友目標";
		PORTRAIT_ENHANCEMENT_ENABLE_PARTY_CASTBAR = "開啟隊友施法條";

		PORTRAIT_ENHANCEMENT_SHOW_PARTY_TEXT = "顯示隊友血量數值";
		PORTRAIT_ENHANCEMENT_FORMAT_TEXT = "以萬為單位計算血量";

		PORTRAIT_ENHANCEMENT_ENABLE_TARGET_CLASS_INFO = "開啓目標職業顯示";
		PORTRAIT_ENHANCEMENT_SHOW_3D_PORTRAIT = "顯示3D頭像";

		PORTRAIT_ENHANCEMENT_Enable_EasyFrames = "開啟簡易頭像框"
	else
		MOD_ENHANCEMENT_TITLE="Portrait Enhancment";
		PORTRAIT_ENHANCEMENT_ENABLE_XP_BAR = "Show XP bar";
		PORTRAIT_ENHANCEMENT_ENABLE_TEXT="Enable expand portrait";
		PORTRAIT_ENHANCEMENT_COLORIZE_TEXT="Colorize health bar";
		PORTRAIT_ENHANCEMENT_ENABLE_PARTY_TEXT = "Enable party Info panel";
		PORTRAIT_ENHANCEMENT_ENABLE_PARTY_TARGET = "Enable party target frame";
		PORTRAIT_ENHANCEMENT_ENABLE_PARTY_CASTBAR = "Enable party cast bar";
		PORTRAIT_ENHANCEMENT_SHOW_PARTY_TEXT = "Show party members' hp and mp";
		PORTRAIT_ENHANCEMENT_FORMAT_TEXT = "Show formatted number";

		PORTRAIT_ENHANCEMENT_ENABLE_TARGET_CLASS_INFO = "Show class information";
		PORTRAIT_ENHANCEMENT_SHOW_3D_PORTRAIT = "Show 3D portrait";

		PORTRAIT_ENHANCEMENT_Enable_EasyFrames = "Enable EasyFrames"
	end

	if IsConfigurableAddOn("TUnitFrame") or IsConfigurableAddOn("EasyFrames") then
		ModManagement_RegisterMod(
			"PortraitEnhancement",
			"Interface\\Icons\\Ability_Ambush",
			MOD_ENHANCEMENT_TITLE,
			"",
			nil,
			nil,
			{[3]=true}
		)

		ModManagement_RegisterCheckBox(
			"PortraitEnhancement",
			PORTRAIT_ENHANCEMENT_Enable_EasyFrames,
			nil,
			"EnableEasyFrames",
			1,
			function(arg)
				if arg == 1 then
					if not BigFoot_IsAddOnLoadedFromBigFoot("EasyFrames") then
						BigFoot_LoadAddOn("EasyFrames")
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("EasyFrames")) then
						BigFoot_RequestReloadUI();
					end
				end
			end,
			nil,
			function(arg)
				if (arg == 1) then
					if not BigFoot_IsAddOnLoadedFromBigFoot("EasyFrames") then
						BigFoot_LoadAddOn("EasyFrames")
					end

					if (BigFoot_IsAddOnLoaded("MobHealth") and BigFoot_IsAddOnLoadedFromBigFoot("EasyFrames")) then
						MobHealth_Toggle();
					end
				end
			end
		)

		ModManagement_RegisterButton(
			"PortraitEnhancement",
			SETTINGS,
			function()
				if (BigFoot_IsAddOnLoadedFromBigFoot("EasyFrames")) then
					local EasyFrames = LibStub("AceAddon-3.0"):GetAddon("EasyFrames");
					InterfaceOptionsFrame_OpenToCategory(EasyFrames.optFrames.Profiles)
					InterfaceOptionsFrame_OpenToCategory(EasyFrames.optFrames.EasyFrames)
					HideUIPanel(ModManagementFrame);
				end
			end,
			nil,
			1
		);

		ModManagement_RegisterCheckBox(
			"PortraitEnhancement",
			PORTRAIT_ENHANCEMENT_ENABLE_TEXT,
			nil,
			"EnablePorEnhance",
			1,
			function(arg)
				if arg == 1 then
					if not BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						BigFoot_LoadAddOn("TUnitFrame")
					end
					if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						TUnitFrame_SwitchPlayerInfoPane(true)
					end
				else
					if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						TUnitFrame_SwitchPlayerInfoPane(false)
					end
				end
			end
		)

		-- ModManagement_RegisterCheckBox(
			-- "PortraitEnhancement",
			-- PORTRAIT_ENHANCEMENT_ENABLE_XP_BAR,
			-- nil,
			-- "ShowXPBar",
			-- 1,
			-- function(arg)
				-- if arg == 1 then
					-- if not BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						-- BigFoot_LoadAddOn("TUnitFrame")
					-- end
					-- if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						-- TUnitFrame_SwitchExpBar(true)
					-- end
				-- else
					-- if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						-- TUnitFrame_SwitchExpBar(false)
					-- end
				-- end
			-- end,
			-- 1
		-- )

		ModManagement_RegisterCheckBox(
			"PortraitEnhancement",
			PORTRAIT_ENHANCEMENT_ENABLE_PARTY_TEXT,
			nil,
			"EnablePartyPor",
			1,
			function(arg)
				if arg == 1 then
					if not BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						BigFoot_LoadAddOn("TUnitFrame")
					end
					if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						TUnitFrame_SwitchMemberInfoPane(true)
					end
				else
					if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						TUnitFrame_SwitchMemberInfoPane(false)
					end
				end
			end
		)

		ModManagement_RegisterCheckBox(
			"PortraitEnhancement",
			PORTRAIT_ENHANCEMENT_ENABLE_PARTY_CASTBAR,
			nil,
			"EnablePartyCastBar",
			1,
			function(arg)
				if arg == 1 then
					if not BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						BigFoot_LoadAddOn("TUnitFrame")
					end
					if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						TUnitFrame_SwitchPartyCastBar(true)
					end
				else
					if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						TUnitFrame_SwitchPartyCastBar(false)
					end
				end
			end,
			1
		)

		ModManagement_RegisterCheckBox(
			"PortraitEnhancement",
			PORTRAIT_ENHANCEMENT_FORMAT_TEXT,
			nil,
			"EnableFormatText",
			nil,
			function(arg)
				if arg == 1 then
					if not BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						BigFoot_LoadAddOn("TUnitFrame")
					end
					if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						TUnitFrame_SwitchFormat(true)
					end
				else
					if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						TUnitFrame_SwitchFormat(false)
					end
				end
			end
		)

		-- ModManagement_RegisterCheckBox(
			-- "PortraitEnhancement",
			-- PORTRAIT_ENHANCEMENT_COLORIZE_TEXT,
			-- nil,
			-- "EnableColorize",
			-- 1,
			-- function(arg)
				-- if arg == 1 then
					-- if not BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						-- BigFoot_LoadAddOn("TUnitFrame")
					-- end
					-- if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						-- TUnitFrame_SwitchColorize(true)
					-- end
				-- else
					-- if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						-- TUnitFrame_SwitchColorize(false)
					-- end
				-- end
			-- end
		-- )

		ModManagement_RegisterCheckBox(
			"PortraitEnhancement",
			PORTRAIT_ENHANCEMENT_ENABLE_PARTY_TARGET,
			nil,
			"EnablePartyTarget",
			1,
			function(arg)
				if arg == 1 then
					if not BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						BigFoot_LoadAddOn("TUnitFrame")
					end
					if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						TUnitFrame_SwitchPartyTarget(true)
					end
				else
					if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						TUnitFrame_SwitchPartyTarget(false)
					end
				end
			end
		)

		ModManagement_RegisterCheckBox(
			"PortraitEnhancement",
			PORTRAIT_ENHANCEMENT_ENABLE_TARGET_CLASS_INFO,
			nil,
			"EnableTargetClassInfo",
			1,
			function(arg)
				if arg == 1 then
					if not BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						BigFoot_LoadAddOn("TUnitFrame")
					end
					if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						TUnitFrame_SwitchClassInfo(true)
					end
				else
					if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						TUnitFrame_SwitchClassInfo(false)
					end
				end
			end

		);

		ModManagement_RegisterCheckBox(
			"PortraitEnhancement",
			PORTRAIT_ENHANCEMENT_SHOW_3D_PORTRAIT,
			nil,
			"Show3DPortrait",
			nil,
			function(arg)
				if arg == 1 then
					if not BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						BigFoot_LoadAddOn("TUnitFrame")
					end
					if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						TUnitFrame_Switch3DPor(true)
					end

				else
					if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
						TUnitFrame_Switch3DPor(false)
					end
				end
			end
		);

	end
	----------这句加载再所有config load 之后-----------------
end

BigFoot_AddCollector(PorEnhanceConfigFunc)
BigFoot_DisableAllAddons()
