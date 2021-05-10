
function SpellMonitorConfigFunc()
	local SPELL_MONITOR,SPELL_TRIGGER_ENABLE,EVENTALERT_TIPS,SPELL_TRIGGER_CONFIG;

	if (GetLocale() == "zhCN") then
		SPELL_MONITOR = {"技能触发", "jinengchufa"};
		SPELL_TRIGGER_ENABLE = "启用技能触发(EventAlertMod)";
		BigDebuffs_ENABLE = "启用控制技能提示(BigDebuffs)";
		EVENTALERT_TIPS = "关闭系统技能触发提示";
		SPELL_TRIGGER_CONFIG = "配置";

	elseif (GetLocale() == "zhTW") then
		SPELL_MONITOR = {"技能觸發", "jinengchufa"};
		SPELL_TRIGGER_ENABLE = "啟用技能觸發(EventAlertMod)";
		BigDebuffs_ENABLE = "啟用控制技能提示(BigDebuffs)";
		EVENTALERT_TIPS = "關閉系統機能觸發提示";
		SPELL_TRIGGER_CONFIG = "配置";
	else
		SPELL_MONITOR = "Spell Trigger";
		SPELL_TRIGGER_ENABLE = "Enable Event Alerter";
		BigDebuffs_ENABLE = "Enable BigDebuffs";
		EVENTALERT_TIPS = "Closed system skills trigger hints";
		SPELL_TRIGGER_CONFIG = "Config";
	end

	if IsConfigurableAddOn("EventAlertMod") or IsConfigurableAddOn("BigDebuffs") then
		ModManagement_RegisterMod(
			"SpellMonitor",
			"Interface\\Icons\\trade_engineering",
			SPELL_MONITOR,
			"",
			nil,
			nil,
			{[2]=true,[3]=true},
			nil,
			"296"
		);

		ModManagement_RegisterCheckBox(
			"SpellMonitor",
			SPELL_TRIGGER_ENABLE,
			nil,
			"EnableEventAlert",
			1,
			function (arg)
				if (arg == 1) then
					if not BigFoot_IsAddOnLoadedFromBigFoot("EventAlertMod") then
						BigFoot_LoadAddOn("EventAlertMod")
					end
					if (BigFoot_IsAddOnLoadedFromBigFoot("EventAlertMod")) then
						EventAlert_Toggle(true)
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("EventAlertMod")) then
						EventAlert_Toggle(false)
					end
				end
			end
		);

		ModManagement_RegisterButton(
			"SpellMonitor",
			SPELL_TRIGGER_CONFIG,
			function()
				if (BigFoot_IsAddOnLoadedFromBigFoot("EventAlertMod")) then
					if not EA_Options_Frame:IsVisible() then
						EA_Options_Frame:Show();
						HideUIPanel(ModManagementFrame);
					end
				end
			end,
			nil,
			1
		);
		
		ModManagement_RegisterCheckBox(
			"SpellMonitor",
			BigDebuffs_ENABLE,
			nil,
			"EnableBigDebuffs",
			1,
			function (arg)
				if (arg == 1) then
					if not BigFoot_IsAddOnLoadedFromBigFoot("BigDebuffs") then
						BigFoot_LoadAddOn("BigDebuffs")
					end
				end
			end
		);

		ModManagement_RegisterButton(
			"SpellMonitor",
			SPELL_TRIGGER_CONFIG,
			function()
				if (BigFoot_IsAddOnLoadedFromBigFoot("BigDebuffs")) then
					InterfaceOptionsFrame_OpenToCategory("BigDebuffs")
					InterfaceOptionsFrame_OpenToCategory("BigDebuffs")
				end
			end,
			nil,
			1
		);

		-- local defaultValue = GetCVarBool("displaySpellActivationOverlays") == 1 or 0;
		-- ModManagement_RegisterCheckBox(
			-- "SpellMonitor",
			-- EVENTALERT_TIPS,
			-- nil,
			-- "DisableTips",
			-- defaultValue,
			-- function (arg)
				-- if(arg==1)then
					-- if (GetCVar("displaySpellActivationOverlays") == "1") then
						-- SetCVar("displaySpellActivationOverlays", "0");
					-- end
				-- else
					-- if (GetCVar("displaySpellActivationOverlays") == "0") then
						-- SetCVar("displaySpellActivationOverlays", "1");
					-- end
				-- end
			-- end,
			-- 1
		-- );
		-- InterfaceOptionsCombatPanelShowSpellAlerts:SetScript("PostClick", function(self)
			-- if (self:GetChecked()) then
				-- BigFoot_SetModVariable("SpellMonitor", "DisableTips", 0);
			-- else
				-- BigFoot_SetModVariable("SpellMonitor", "DisableTips", 1);
			-- end
		-- end);
	end
end

BigFoot_AddCollector(SpellMonitorConfigFunc)