
function DKPConfigFunc()
	local ADDON_TITLE
	if GetLocale()=='zhCN' then
		ADDON_TITLE = "团队记录"
		GDKP_ADDON_TITLE = "使用大脚金团助手"
	elseif GetLocale()=='zhTW' then
		ADDON_TITLE = "团队記錄"
		GDKP_ADDON_TITLE = "使用大腳金團助手"
	else
		ADDON_TITLE = "Raid Records"
		GDKP_ADDON_TITLE = "Use GDKP"
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
	end
end

BigFoot_AddCollector(DKPConfigFunc)