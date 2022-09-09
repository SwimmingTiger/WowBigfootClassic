--[[--
	by ALA @ 163UI
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

-->		upvalue
	local next = next;
	local select = select;
	local strsplit, strlower, strsub, strmatch = string.split, string.lower, string.sub, string.match;
	local setmetatable = setmetatable;
	local _G = _G;
	local SlashCmdList = SlashCmdList;

-->
	local L = CT.L;

-->		constant
	CT.DefaultSetting = {
		resizable_border = false,
		singleFrame = true,
		style = 1,
		talents_in_tip = true,
		talents_in_tip_icon = true,
		inspectButtonOnUnitFrame = false,
		show_equipment = true,
		inspect_pack = false,
		max_recv_msg = 16,
		minimap = true,
		minimapPos = 185,
		autoShowEquipmentFrame = true,
	};
-->
MT.BuildEnv('SETTING');
-->		predef
-->		SETTING
	function MT.SetConfig(key, value)
		VT.SET[key] = value;
		local func = MT.CALLBACK[key];
		if func ~= nil then
			func(value);
		end
	end
	function MT.GetConfig(key)
		return VT.SET[key];
	end

	_G.SLASH_ALATALENTEMU1 = "/TalentEmu";
	_G.SLASH_ALATALENTEMU2 = "/emu";
	local acceptedCommandSeq = { "\ ", "\,", "\;", "\:", "\-", "\+", "\_", "\=", "\/", "\\", "\"", "\'", "\|", "\，", "\。", "\；", "\：", "\、", "\’", "\“", };
	SlashCmdList["ALATALENTEMU"] = function(msg)
		if strlower(strsub(msg, 1, 3)) == "set" then
			for _, seq in next, acceptedCommandSeq do
				if strmatch(msg, seq) then
					MT.SetConfig(select(2, strsplit(seq, msg)));
					return;
				end
			end
			return;
		end
		for _, seq in next, acceptedCommandSeq do
			if strmatch(msg, seq) then
				MT.CreateEmulator(nil, strsplit(seq, msg));
				return;
			end
		end
		MT.CreateEmulator(nil, msg);
	end

	local function DBIcon_OnClick(self, button)
		if button == "LeftButton" then
			MT.CreateEmulator();
		elseif button == "RightButton" then
			MT.ToggleRaidToolUI();
		end
	end
	MT.RegisterOnInit('SETTING', function(LoggedIn)
		local DB = _G.TalentEmuSV;
		if DB == nil or DB._version < 200615.0 then
			DB = {
				set = {  },
				var = { savedTalent = {  }, },
			};
			_G.TalentEmuSV = DB;
		elseif DB._version < 220801.0 then
			local SET = DB.set;
			local VAR = DB.var;
			VAR.savedTalent = VAR.savedTalent or {  };
			DB = {
				set = SET or {  },
				var = VAR or { savedTalent = {  }, },
			};
			_G.TalentEmuSV = DB;
		end
		DB._version = 220811.0;
		VT.DB = DB;
		VT.SET = setmetatable(DB.set, { __index = CT.DefaultSetting, });
		VT.VAR = DB.var;
		if DT.BUILD == "WRATH" then
			DB.map = DB.map or {  };
			DB.map[DT.BUILD] = DB.map[DT.BUILD] or {  };
			VT.MAP = DB.map[DT.BUILD];
		else
			DB.map = nil;
		end
		VT.LOOT = DB.loot;
		MT.MergeGlobal(DB);
	end);
	MT.RegisterOnLogin('SETTING', function(LoggedIn)
		local LibStub = _G.LibStub;
		if LibStub ~= nil then
			--	DBICON
				local LDI = LibStub("LibDBIcon-1.0", true);
				if LDI ~= nil then
					LDI:Register("TalentEmu",
					{
						icon = CT.TEXTUREICON,
						OnClick = DBIcon_OnClick,
						text = L.DBIcon_Text,
						OnTooltipShow = function(tt)
								tt:AddLine("TalentEmu");
								tt:AddLine(" ");
								tt:AddLine(L.DBIcon_Text);
								tt:Show();
							end
					},
					{
						minimapPos = VT.SET.minimapPos,
					}
					);
					local mb = LDI:GetMinimapButton("TalentEmu");
					mb:RegisterEvent("PLAYER_LOGOUT");
					mb:HookScript("OnEvent", function(self)
						VT.SET.minimapPos = self.minimapPos or self.db.minimapPos;
					end);
					mb:HookScript("OnDragStop", function(self)
						VT.SET.minimapPos = self.minimapPos or self.db.minimapPos;
					end);
					if VT.SET.minimap then
						LDI:Show("TalentEmu");
					else
						LDI:Hide("TalentEmu");
					end
					MT.CALLBACK["minimap"] = function(on)
						if on then
							LDI:Show("TalentEmu");
						else
							LDI:Hide("TalentEmu");
						end
					end
				end
			--	LDB
				local LDB = LibStub:GetLibrary("LibDataBroker-1.1");
				if LDB ~= nil then
					local obj = LDB:NewDataObject("TalentEmu", {
						type = "launcher",
						icon = CT.TEXTUREICON,
						OnClick = DBIcon_OnClick,
						OnTooltipShow = function(tt)
							tt:AddLine("TalentEmu");
							tt:AddLine(" ");
							tt:AddLine(L.DBIcon_Text);
							-- for _, text in next, L.TooltipLines do
							-- 	tt:AddLine(text);
							-- end
							tt:Show();
						end,
					});
				end
		end
	end);

-->
