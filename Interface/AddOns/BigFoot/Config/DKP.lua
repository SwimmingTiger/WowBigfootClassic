
function DKPConfigFunc()
	local ADDON_TITLE
	if GetLocale()=='zhCN' then
		ADDON_TITLE = "团队记录"
		GDKP_ADDON_TITLE = "使用大脚金团助手"
		RAIDLEDGER_ADDON_TITLE = "使用金团账本 (RaidLedger)"
		RAIDLEDGER_ADDON_SHOW = "打开主界面"
		RAIDLEDGER_ADDON_TOOLTIP = "金团账本已启用，可通过 /gtuan 命令打开主界面"
	elseif GetLocale()=='zhTW' then
		ADDON_TITLE = "团队記錄"
		GDKP_ADDON_TITLE = "使用大腳金團助手"
		RAIDLEDGER_ADDON_TITLE = "使用金團賬本 (RaidLedger)"
		RAIDLEDGER_ADDON_SHOW = "打開主界面"
		RAIDLEDGER_ADDON_TOOLTIP = "金團賬本已啟用，可通過 /gtuan 命令打開主界面"
	else
		ADDON_TITLE = "Raid Records"
		GDKP_ADDON_TITLE = "Use GDKP"
		RAIDLEDGER_ADDON_TITLE = "Use RaidLedger"
		RAIDLEDGER_ADDON_SHOW = "Show Main Window"
		RAIDLEDGER_ADDON_TOOLTIP = "RaidLedger is enabled, you can open its main window through the /gtuan command"
	end

	if IsConfigurableAddOn("GDKP") or IsConfigurableAddOn("MiDKP") then
		ModManagement_RegisterMod(
			"MiDKP",
			"Interface\\Icons\\INV_Misc_Toy_05",
			{ADDON_TITLE,"tuanduiDKP",2},
			"",
			nil,
			nil,
			{[4]=true},
			true,
			"243"
		);

		if IsConfigurableAddOn("GDKP") then
			ModManagement_RegisterCheckBox(
				"MiDKP",
				GDKP_ADDON_TITLE,
				nil,
				"GDKPEnable",
				0,
				function (arg)
					if arg == 1 then
						if (not BigFoot_IsAddOnLoaded("GDKP")) then
							BigFoot_LoadAddOn("GDKP");
						end
						if BigFoot_IsAddOnLoaded("GDKP") then
							GDKP:Enable()
						end
					else
						if BigFoot_IsAddOnLoaded("GDKP") then
							GDKP:Disable()
						end
					end
				end
			);
		end

		if IsConfigurableAddOn("RaidLedger") then
			ModManagement_RegisterCheckBox(
				"MiDKP",
				RAIDLEDGER_ADDON_TITLE,
				nil,
				"RaidLedgerEnable",
				0,
				function (arg)
					if arg == 1 then
						if (not BigFoot_IsAddOnLoaded("RaidLedger")) then
							BigFoot_LoadAddOn("RaidLedger")
							print(RAIDLEDGER_ADDON_TOOLTIP)
						end
					else
						if (BigFoot_IsAddOnLoaded("RaidLedger")) then
							BigFoot_RequestReloadUI()
						end
					end
				end
			);

			ModManagement_RegisterButton(
				"MiDKP",
				RAIDLEDGER_ADDON_SHOW,
				function ()
					SlashCmdList["RAIDLEDGER"]("")
				end,
				nil,
				1
			);
		end
	end
end

BigFoot_AddCollector(DKPConfigFunc)