
function SpellTimerConfigFunc()
	local SPELL_TIMER;
	local SPELL_TIMER_ENABLE;
	if (GetLocale() == "zhCN") then
		SPELL_TIMER = {"技能计时器", "fashujishiqi"};
		SPELL_TIMER_ENABLE = "启用技能计时器";
	elseif (GetLocale() == "zhTW") then
		SPELL_TIMER = {"技能計時器", "fashujishiqi"};
		SPELL_TIMER_ENABLE = "啟用技能計時器";
	else
		SPELL_TIMER = "Spell Timer";
		SPELL_TIMER_ENABLE = "Enable Spell Timer";
	end

	local function SpellTimer_DelayShow()
		if (SPELL_TIMER_LOADED) then
			SpellTimer_Toggle(1);
			ModManagement_Refresh();
		else
			BigFoot_DelayCall(SpellTimer_DelayShow, 0.1);
		end
	end

	if (IsConfigurableAddOn("SpellTimer")) then
		ModManagement_RegisterMod(
			"SpellTimer",
			"Interface\\Icons\\INV_Misc_PocketWatch_01",
			SPELL_TIMER,
			"",
			nil,
			{["frame"] = "SpellTimerOptionFrame", ["offsetx"] = 313, ["offsety"] = -108},
			{[2]=true,[3]=true}

		);
		ModManagement_RegisterCheckBox(
			"SpellTimer",
			SPELL_TIMER_ENABLE,
			nil,
			"EnableSpellTimer",
			1,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("SpellTimer")) then
						BigFoot_LoadAddOn("SpellTimer");
					end
					if (BigFoot_IsAddOnLoaded("SpellTimer")) then
						SpellTimer_DelayShow();
					end
				else
					if (BigFoot_IsAddOnLoaded("SpellTimer")) then
						SpellTimer_Toggle(false);
					end
				end
			end
		);
	end
end

BigFoot_AddCollector(SpellTimerConfigFunc)


