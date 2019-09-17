
function RaidToolkitConfigFunc()
	local RaString ={}
	local DBMString ={}
	local GridString ={}
	local SkadaString ={}
	local ThreatString ={}
	local RecountString ={}
	local DecursiveString ={}
	local playerClass = select(2, UnitClass("player"));

	RecountString.colorText = "(|cff808080Recount|r)"
	SkadaString.colorText = "(|cff808080Skada|r)"
	DBMString.colorText = "(|cff808080DBM|r)"
	GridString.colorText = "(|cff808080Grid|r)"
	DecursiveString.colorText = "(|cff808080Decursive|r)"
	ThreatString.colorText = "(|cff808080Omen3|r)"
	RaString.colorText = "(|cff808080RaidAlerter|r)"

	local OPEN
	if (GetLocale() == "zhCN") then
		RAID_TOOLKIT_TITLE = {"团队工具", "tuanduigongju",2};

		OPEN = "开启"

		RecountString.Name = "伤害统计";
		SkadaString.Name = "战斗统计";
		DBMString.Name = "首领报警 ";
		GridString.Name = "团队框架 ";
		DecursiveString.Name = "一键驱散";
		ThreatString.Name = "仇恨统计 ";
		RaString.Name = "团队报警 ";
		MeetingStone_ENABLE_TEXT = "开启集合石";
		AngryKeystones_ENABLE_TEXT = "开启秘境增强";
		skadaFormatNumber = "数值显示方式改为中式";

		DBM_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚插件>|r 你已经关闭首领报警(DBM)模块，该设置将在下次插件载入时生效。";
		GRID_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚插件>|r 你已经关闭团队框架(Grid)模块，该设置将在下次插件载入时生效。";
		DECURSIVE_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚插件>|r 你已经关闭一键驱散(Decursive)模块，该设置将在下次插件载入时生效。";
		RECOUNT_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚插件>|r 你已经关闭伤害统计(Recount)模块，该设置将在下次插件载入时生效。";
		Skada_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚插件>|r 你已经关闭伤害统计(Skada)模块，该设置将在下次插件载入时生效。";
		THREAT_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚插件>|r 你已经关闭仇恨统计(Omen3)模块，该设置将在下次插件载入时生效。";
		RAIDALERT_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚插件>|r 你已经关闭团队报警(RaidAlerter)模块，该设置将在下次插件载入时生效。";
		MeetingStone_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚插件>|r 你已经关闭集合石(MeetingStone)模块，该设置将在下次插件载入时生效。";
		AngryKeystones_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚插件>|r 你已经关闭秘境增强(AngryKeystones)模块，该设置将在下次插件载入时生效。";
	elseif (GetLocale() == "zhTW") then
		RAID_TOOLKIT_TITLE = {"團隊工具", "tuanduigongju",2};

		OPEN = "開啟"

		RecountString.Name = "傷害統計";
		SkadaString.Name = "戰鬥統計";
		DBMString.Name = "首領報警 ";
		GridString.Name = "團隊框架 ";
		DecursiveString.Name = "一鍵驅散";
		ThreatString.Name = "仇恨統計 ";
		RaString.Name = "團隊報警 ";
		MeetingStone_ENABLE_TEXT = "開啟組隊系統";
		AngryKeystones_ENABLE_TEXT = "開啟秘境增強";
		skadaFormatNumber = "數值顯示方式改為中式";

		DBM_DISABLE_DELAY_TEXT = "|cff00c0c0<首領報警>|r 你已經關閉首領報警(DBM)模組，該設置將在下次外掛程式載入時生效。";
		GRID_DISABLE_DELAY_TEXT = "|cff00c0c0<團隊框架>|r 你已經關閉團隊框架(Grid)模組，該設置將在下次外掛程式載入時生效。";
		DECURSIVE_DISABLE_DELAY_TEXT = "|cff00c0c0<一鍵驅散>|r 你已經關閉一鍵驅散(Decursive)模組，該設置將在下次外掛程式載入時生效。";
		RECOUNT_DISABLE_DELAY_TEXT = "|cff00c0c0<傷害統計>|r 你已經關閉傷害統計(Recount)模組，該設置將在下次外掛程式載入時生效。";
		Skada_DISABLE_DELAY_TEXT = "|cff00c0c0<傷害統計>|r 你已經關閉傷害統計(Skada)模組，該設置將在下次外掛程式載入時生效。";
		THREAT_DISABLE_DELAY_TEXT = "|cff00c0c0<仇恨統計>|r 你已經關閉仇恨統計(Omen3)模組，該設置將在下次外掛程式載入時生效。";
		RAIDALERT_DISABLE_DELAY_TEXT = "|cff00c0c0<團隊報警>|r 你已經關閉團隊報警(RaidAlerter)模組，該設置將在下次外掛程式載入時生效。";
		MeetingStone_DISABLE_DELAY_TEXT = "|cff00c0c0<組隊系統>|r 你已經關閉組隊系統(MeetingStone)模組，該設置將在下次外掛程式載入時生效。";
		AngryKeystones_DISABLE_DELAY_TEXT = "|cff00c0c0<大腳插件>|r 你已經關閉秘境增強(AngryKeystones)模組，該設置將在下次外掛程式載入時生效。";

	else
		RAID_TOOLKIT_TITLE = "Raid Toolkit";

		OPEN = "Enable"

		DBM_DISABLE_DELAY_TEXT = "|cff00c0c0<DBM>|r DBM has been disabled. This setting will be available next time.";
		GRID_DISABLE_DELAY_TEXT = "|cff00c0c0<Grid>|r Grid has been disabled. This setting will be available next time.";
		DECURSIVE_DISABLE_DELAY_TEXT = "|cff00c0c0<Descursive>|r Descursive has been disabled. This setting will be available next time.";
		RECOUNT_DISABLE_DELAY_TEXT = "|cff00c0c0<Recount>|r Recount has been disabled. This setting will be available next time.";
		THREAT_DISABLE_DELAY_TEXT = "|cff00c0c0<Omen3>|r Omen3 has been disabled. This setting will be available next time.";
		RAIDALERT_DISABLE_DELAY_TEXT = "|cff00c0c0<RaidAlerter>|r RaidAlerter has been disabled. This setting will be available next time.";
	end

	RECOUNT_ENABLE_TEXT = OPEN..(RecountString.Name or "")..RecountString.colorText;
	Skada_ENABLE_TEXT = OPEN..(SkadaString.Name or "")..SkadaString.colorText;
	DBM_ENABLE_TEXT = OPEN..(DBMString.Name or "")..DBMString.colorText;
	GRID_ENABLE_TEXT = OPEN..(GridString.Name or "")..GridString.colorText;
	DECURSIVE_ENABLE_TEXT = OPEN..(DecursiveString.Name or "")..DecursiveString.colorText;
	THREAT_ENABLE_TEXT = OPEN..(ThreatString.Name or "")..ThreatString.colorText;
	RAIDALERT_ENABLE_TEXT = OPEN..(RaString.Name or "")..RaString.colorText;

	local function loadRecount()
		if (not BigFoot_IsAddOnLoaded("Recount")) then
			BigFoot_LoadAddOn("Recount");
			BigFoot_DelayCall(function ()
				SlashCmdList["ACECONSOLE_RECOUNT"]("show")
			end,1)
		end
	end

	local function loadSkada()
		if (not BigFoot_IsAddOnLoaded("Skada")) then
			BigFoot_LoadAddOn("Skada");
			Skada.originFormatNumber = Skada.FormatNumber;
		end
	end

	local function bf_SkadaFormatNumber()
		Skada.FormatNumber = function(self, number)
			if number then
				if Skada.db.profile.numberformat == 1 then
					if number >= 100000000 then
						return ("%02.2f亿"):format(number / 100000000)
					elseif number >= 10000 then
						return ("%02.2f万"):format(number / 10000)
					elseif number >= 1000 then
						return ("%02.1f千"):format(number / 1000)
					else
						return math.floor(number)
					end
				else
					return math.floor(number)
				end
			end
		end
	end

	if ( IsConfigurableAddOn("Recount") or IsConfigurableAddOn("DBM-Core") or IsConfigurableAddOn("Grid") or IsConfigurableAddOn("RaidAlerter") or IsConfigurableAddOn("Skada") or IsConfigurableAddOn("MeetingStone") or IsConfigurableAddOn("AngryKeystones") or IsConfigurableAddOn("Omen") or (IsConfigurableAddOn("Decursive") and (playerClass ~= "WARRIOR" and playerClass ~= "ROGUE" and playerClass ~= "DEATHKNIGHT") ) ) then
		ModManagement_RegisterMod(
			"RaidToolkit",
			"Interface\\Icons\\INV_Bijou_Orange",
			RAID_TOOLKIT_TITLE,
			nil,
			nil,
			nil,
			{[4]=true},
			true,
			"292"
		);
	end

	if (IsConfigurableAddOn("Recount")) then
		ModManagement_RegisterCheckBox(
			"RaidToolkit",
			RECOUNT_ENABLE_TEXT,
			nil,
			"EnableRecount2",
			0,
			function (arg)
				if (arg == 1) then
					if (IsConfigurableAddOn("Skada")) then
						if (BigFoot_GetModVariable("RaidToolkit", "EnableSkada") ~= 0) then
							BigFoot_SetModVariable("RaidToolkit", "EnableSkada", 0);
							ModManagement_Refresh();
							BigFoot_RequestReloadUI(function() BigFoot_Print(Skada_DISABLE_DELAY_TEXT); end);
						else
							if (not BigFoot_IsAddOnLoaded("Skada")) then
								loadRecount();
							end
						end
					else
						if (not BigFoot_IsAddOnLoaded("Skada")) then
							loadRecount();
						end
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("Recount")) then
						BigFoot_RequestReloadUI(function() BigFoot_Print(RECOUNT_DISABLE_DELAY_TEXT); end);
					end
				end
			end,
			nil,
			function(arg)
				if (arg == 1) then
					loadRecount();
				end
			end,
			RecountString.Name or RecountString.colorText
		);

	end

	if (IsConfigurableAddOn("Skada")) then
		ModManagement_RegisterCheckBox(
			"RaidToolkit",
			Skada_ENABLE_TEXT,
			nil,
			"EnableSkada",
			0,
			function (arg)
				if (arg == 1) then
					if (IsConfigurableAddOn("Recount")) then
						if (BigFoot_GetModVariable("RaidToolkit", "EnableRecount2") ~= 0) then
							BigFoot_SetModVariable("RaidToolkit", "EnableRecount2", 0);
							ModManagement_Refresh();
							BigFoot_RequestReloadUI(function() BigFoot_Print(RECOUNT_DISABLE_DELAY_TEXT); end);
						else
							if (not BigFoot_IsAddOnLoaded("Recount")) then
								loadSkada();
							end
						end
					else
						if (not BigFoot_IsAddOnLoaded("Recount")) then
							loadSkada();
						end
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("Skada")) then
						BigFoot_RequestReloadUI(function() BigFoot_Print(Skada_DISABLE_DELAY_TEXT); end);
					end
				end
			end,
			nil,
			function(arg)
				if (arg == 1) then
					loadSkada();
				end
			end,
			SkadaString.Name or SkadaString.colorText
		);

		ModManagement_RegisterCheckBox(
			"RaidToolkit",
			skadaFormatNumber,
			nil,
			"skadaFormatNumber",
			1,
			function (arg)
				if BigFoot_IsAddOnLoaded("Skada") then
					if (arg == 1) then
						bf_SkadaFormatNumber();
					else
						Skada.FormatNumber = Skada.originFormatNumber;
					end
				end
			end,
			1
		);

	end

	if (IsConfigurableAddOn("DBM-Core")) then
		ModManagement_RegisterCheckBox(
			"RaidToolkit",
			DBM_ENABLE_TEXT,
			nil,
			"EnableDBM",
			1,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("DBM-StatusBarTimers")) then
						BigFoot_LoadAddOn("DBM-StatusBarTimers");
					end
					if (not BigFoot_IsAddOnLoaded("DBM-Core")) then
						BigFoot_LoadAddOn("DBM-Core");
						BigFoot_DelayCall(function() if DBM then DBM.Options.SettingsMessageShown = true end end,5)
					end
					if (not BigFoot_IsAddOnLoaded("DBM-RaidLeadTools")) then
						BigFoot_LoadAddOn("DBM-RaidLeadTools");
					end
					if (not BigFoot_IsAddOnLoaded("DBM-SpellTimers")) then
						BigFoot_LoadAddOn("DBM-SpellTimers");
					end
					if (not BigFoot_IsAddOnLoaded("DBM-DefaultSkin")) then
						BigFoot_LoadAddOn("DBM-DefaultSkin");
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("DBM-Core")) then
						BigFoot_RequestReloadUI(function() BigFoot_Print(DBM_DISABLE_DELAY_TEXT); end);
					end
				end
			end,
			nil,
			nil,
			DBMString.Name or DBMString.colorText

		);
	end

	if (IsConfigurableAddOn("Grid")) then
		ModManagement_RegisterCheckBox(
			"RaidToolkit",
			GRID_ENABLE_TEXT,
			nil,
			"EnableGrid",
			0,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("Grid")) then
						BigFoot_LoadAddOn("Grid");
					end

					if (BigFoot_IsAddOnLoaded("Grid")) then
						Grid:Toggle(true);
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("Grid")) then
						Grid:Toggle(false);
						BigFoot_RequestReloadUI(function() BigFoot_Print(GRID_DISABLE_DELAY_TEXT); end);
					end
				end
			end,
			nil,
			nil,
			GridString.Name or GridString.colorText

		);
	end

	if ( IsConfigurableAddOn("Decursive") ) then
		ModManagement_RegisterCheckBox(
			"RaidToolkit",
			DECURSIVE_ENABLE_TEXT,
			nil,
			"EnableDecursive",
			0,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("Decursive")) then
						BigFoot_LoadAddOn("Decursive");
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("Decursive")) then
						BigFoot_RequestReloadUI(function() BigFoot_Print(DECURSIVE_DISABLE_DELAY_TEXT); end);
					end
				end
			end,
			nil,
			nil,
			DecursiveString.Name or DecursiveString.colorText
		);
	end

	if (IsConfigurableAddOn("Omen")) then
		ModManagement_RegisterCheckBox(
			"RaidToolkit",
			THREAT_ENABLE_TEXT,
			nil,
			"EnableThreat",
			0,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("Omen")) then
						BigFoot_LoadAddOn("Omen");
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("Omen")) then
						BigFoot_RequestReloadUI(function() BigFoot_Print(THREAT_DISABLE_DELAY_TEXT); end);
					end
				end
			end,
			nil,
			nil,
			ThreatString.Name or ThreatString.colorText

		);
	end

	if (IsConfigurableAddOn("RaidAlerter")) then
		ModManagement_RegisterCheckBox(
			"RaidToolkit",
			RAIDALERT_ENABLE_TEXT,
			nil,
			"EnableRaidAlerter",
			0,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("RaidAlerter")) then
						BigFoot_LoadAddOn("RaidAlerter");
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("RaidAlerter")) then
						BigFoot_RequestReloadUI(function() BigFoot_Print(RAIDALERT_DISABLE_DELAY_TEXT); end);
					end
				end
			end,
			nil,
			nil,
			RaString.Name or RaString.colorText
		);
	end

	if (IsConfigurableAddOn("MeetingStone")) then
		ModManagement_RegisterCheckBox(
			"RaidToolkit",
			MeetingStone_ENABLE_TEXT,
			nil,
			"EnableMeetingStone",
			1,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("MeetingStone")) then
						BigFoot_LoadAddOn("MeetingStone");
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("MeetingStone")) then
						BigFoot_RequestReloadUI(function() BigFoot_Print(MeetingStone_DISABLE_DELAY_TEXT); end);
					end
				end
			end
		);
	end

	if (IsConfigurableAddOn("AngryKeystones")) then
		ModManagement_RegisterCheckBox(
			"RaidToolkit",
			AngryKeystones_ENABLE_TEXT,
			nil,
			"EnableAngryKeystones",
			1,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("AngryKeystones")) then
						BigFoot_LoadAddOn("AngryKeystones");
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("AngryKeystones")) then
						BigFoot_RequestReloadUI(function() BigFoot_Print(AngryKeystones_DISABLE_DELAY_TEXT); end);
					end
				end
			end
		);
	end
end

BigFoot_AddCollector(RaidToolkitConfigFunc)