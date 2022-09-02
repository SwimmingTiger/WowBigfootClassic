﻿--[[--
	by ALA @ 163UI
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = {  }; __private.MT = MT;		--	method
local CT = {  }; __private.CT = CT;		--	constant
local VT = {  }; __private.VT = VT;		--	variables
local DT = {  }; __private.DT = DT;		--	data

-->		upvalue
	local setfenv = setfenv;
	local xpcall = xpcall;
	local geterrorhandler = geterrorhandler;
	local print, date = print, date;
	local type = type;
	local setmetatable = setmetatable;
	local rawset = rawset;
	local next = next;
	local tremove = table.remove;
	local strrep = string.rep;
	local IsLoggedIn =IsLoggedIn;
	local _After = C_Timer.After;
	local CreateFrame = CreateFrame;
	local _G = _G;

-->
	local __ala_meta__ = _G.__ala_meta__;
	__ala_meta__.emu = __private;
	VT.__uireimp = __ala_meta__.uireimp;
	VT.__emulib = __ala_meta__.__emulib;
	VT.__autostyle = __ala_meta__.autostyle;
	VT.__menulib = __ala_meta__.__menulib;
	VT.__scrolllib = _G.alaScrollList;
	VT.__popuplib = _G.alaPopup;

-->		Dev
	local _GlobalRef = {  };
	local _GlobalAssign = {  };
	function MT.BuildEnv(category)
		local _G = _G;
		local Ref = _GlobalRef[category] or {  };
		local Assign = _GlobalAssign[category] or {  };
		setfenv(2, setmetatable(
			{  },
			{
				__index = function(tbl, key, val)
					Ref[key] = (Ref[key] or 0) + 1;
					_GlobalRef[category] = Ref;
					return _G[key];
				end,
				__newindex = function(tbl, key, value)
					rawset(tbl, key, value);
					Assign[key] = (Assign[key] or 0) + 1;
					_GlobalAssign[category] = Assign;
					return value;
				end,
			}
		));
	end
	function MT.MergeGlobal(DB)
		local _Ref = DB._GlobalRef;
		if _Ref ~= nil then
			for category, db in next, _Ref do
				local to = _GlobalRef[category];
				if to == nil then
					_GlobalRef[category] = db;
				else
					for key, val in next, db do
						to[key] = (to[key] or 0) + val;
					end
				end
			end
		end
		DB._GlobalRef = _GlobalRef;
		local _Assign = DB._GlobalAssign;
		if _Assign ~= nil then
			for category, db in next, _Assign do
				local to = _GlobalAssign[category];
				if to == nil then
					_GlobalAssign[category] = db;
				else
					for key, val in next, db do
						to[key] = (to[key] or 0) + val;
					end
				end
			end
		end
		DB._GlobalAssign = _GlobalAssign;
	end

-->		constant
	CT.LOCALE = GetLocale();
	CT.BNTAG = select(2, BNGetInfo());
	CT.SELFREALM = GetRealmName();
	CT.SELFGUID = UnitGUID('player');
	CT.SELFLCLASS, CT.SELFCLASS = UnitClass('player');
	CT.SELFNAME = UnitName('player');
	CT.SELFFULLNAME = CT.SELFNAME .. "-" .. CT.SELFREALM;
	CT.SELFFACTION = UnitFactionGroup('player');
	CT.CLIENTVERSION, CT.BUILDNUMBER, CT.BUILDDATE, CT.TOCVERSION = GetBuildInfo();
	CT.ADDONVERSION = GetAddOnMetadata(__addon, "version");
	CT.MEDIAPATH =  [[Interface\AddOns\]] .. __addon .. [[\Media\]];
	CT.TEXTUREPATH =  CT.MEDIAPATH .. [[Textures\]];
	CT.NUM_POINTS_NEXT_TIER = 5;
	CT.THROTTLE_TALENT_QUERY = VT.__emulib.CT.TALENT_REPLY_THROTTLED_INTERVAL + 0.5;
	CT.THROTTLE_GLYPH_QUERY = VT.__emulib.CT.GLYPH_REPLY_THROTTLED_INTERVAL + 0.5;
	CT.THROTTLE_EQUIPMENT_QUERY = VT.__emulib.CT.EQUIPMENT_REPLY_THROTTLED_INTERVAL + 0.5;
	CT.DATA_VALIDITY = 30;
	CT.IndexToClass = VT.__emulib.__classList;
	CT.ClassToIndex = VT.__emulib.__classHash;
	CT.TOOLTIP_UPDATE_DELAY = 0.02;
	CT.INSPECT_WAIT_TIME = 10;
	CT.L = {  };

	CT.TEXTUREICON = CT.TEXTUREPATH .. [[ICON]];
	CT.TEXTUREUNK = [[Interface\Icons\Inv_Misc_QuestionMark]];

	CT.RepeatedZero = setmetatable(
		{
			[0] = "",
			[1] = "0",
		},
		{
			__index = function(tbl, key)
				local str = strrep("0", key);
				tbl[key] = str;
				return str;
			end,
		}
	);

-->
MT.BuildEnv('INIT');
-->		predef
	MT.GetUnifiedTime = _G.GetTimePreciseSec;
	function MT.ErrorDev(...)
		print(date('|cff00ff00%H:%M:%S|r'), ...);
	end
	function MT.ErrorRelease(...)
	end
	function MT.Notice(...)
		print(date('|cffff0000%H:%M:%S|r'), ...);
	end
	local _TimerPrivate = {  };		--	[callback] = { periodic, int, running, halting, limit, };
	function MT._TimerStart(callback, int, limit)
		if callback ~= nil and type(callback) == 'function' then
			local P = _TimerPrivate[callback];
			if P == nil then
				P = {
					[1] = function()	--	periodic
						if P[4] then
							P[3] = false;
						elseif P[5] == nil then
							_After(P[2], P[1]);
							callback();
						elseif P[5] > 1 then
							P[5] = P[5] - 1;
							_After(P[2], P[1]);
							callback();
						elseif P[5] > 0 then
							P[3] = false;
							callback();
						else
							P[3] = false;
						end
					end,
					[2] = int or 1.0,	--	int
					[3] = true,			--	isrunning
					[4] = false,		--	ishalting
					[5] = limit,
				};
				_TimerPrivate[callback] = P;
				return _After(P[2], P[1]);
			elseif not P[3] then
				P[2] = int or 1.0;
				P[3] = true;
				P[4] = false;
				P[5] = limit;
				return _After(P[2], P[1]);
			else
				P[2] = int or P[2];
				P[4] = false;
				P[5] = limit;
			end
		end
	end
	function MT._TimerHalt(callback)
		local P = _TimerPrivate[callback];
		if P ~= nil and P[3] then
			P[4] = true;
		end
	end
	local _CallbackPrivate = {  };
	function MT._RegisterCallback(event, callback)
		if callback ~= nil and type(callback) == 'function' then
			_CallbackPrivate[event] = _CallbackPrivate[event] or {  };
			local E = _CallbackPrivate[event];
			local N = #E;
			for index = 1, N do
				if E[index] == callback then
					return;
				end
			end
			E[N + 1] = callback;
		end
	end
	function MT._UnregisterCallback(event, callback)
		local E = _CallbackPrivate[event];
		if E ~= nil and callback ~= nil and type(callback) == 'function' then
			for index = #E, 1, -1 do
				if E[index] == callback then
					tremove(E, index);
				end
			end
		end
	end
	function MT._TriggerCallback(event, ...)
		local E = _CallbackPrivate[event];
		if E ~= nil then
			for index = #E, 1, -1 do
				E[index](...);
			end
		end
	end

-->
	MT.UI = {  };
	MT.CALLBACK = {  };
	VT.TSpellLevelHash = {  };
	VT.ExternalCodec = {  };
	VT.ExternalAddOn = {  };
	VT.Frames = { num = 0, used = 0, };
	VT.TQueryCache = {  };	--	[GUID] = { [addon] = { data, time, }, }
	VT.QuerySent = {  };
	VT.NameBindingFrame = {  };
	VT.PrevQueryRequestSentTime = {  };
	VT.ApplyingTalents = {  };
	VT.AutoShowEquipmentFrameOnComm = {  };

-->
-->		INIT
	local __oninit = {  };
	local __onlogin = {  };
	local __onquit = {  };
	function MT.RegisterOnInit(key, method)
		if type(key) == 'string' and type(method) == 'function' then
			__oninit[#__oninit + 1] = key;
			__oninit[key] = method;
		end
	end
	function MT.RegisterOnLogin(key, method)
		if type(key) == 'string' and type(method) == 'function' then
			__onlogin[#__onlogin + 1] = key;
			__onlogin[key] = method;
		end
	end
	function MT.RegisterOnQuit(key, method)
		if type(key) == 'string' and type(method) == 'function' then
			__onquit[#__onquit + 1] = key;
			__onquit[key] = method;
		end
	end

	MT.GetUnifiedTime();		--	initialized after call once
	local Driver = CreateFrame('FRAME');
	Driver:RegisterEvent("ADDON_LOADED");
	Driver:RegisterEvent("PLAYER_LOGOUT");
	Driver:RegisterEvent("PLAYER_LOGIN");
	Driver:SetScript("OnEvent", function(Driver, event, addon)
		if event == "ADDON_LOADED" then
			if addon == __addon then
				Driver:UnregisterEvent("ADDON_LOADED");
				VT.__is_loggedin = IsLoggedIn();
				local ErrorHandler = geterrorhandler();
				for index = 1, #__oninit do
					local key = __oninit[index];
					local method = __oninit[key];
					xpcall(method, ErrorHandler, VT.__is_loggedin);
					--[==[local success, message = pcall(method);
					if not success then
						ErrorHandler(message or (__addon .. " INIT SCRIPT [[" .. key .. "]] ERROR."));
					end]==]
				end
				if VT.__is_loggedin then
					return Driver:GetScript("OnEvent")(Driver, "PLAYER_LOGIN");
				end
			end
		elseif event == "PLAYER_LOGIN" then
			Driver:UnregisterEvent("PLAYER_LOGIN");
			VT.__is_loggedin = true;
			local ErrorHandler = geterrorhandler();
			for index = 1, #__onlogin do
				local key = __onlogin[index];
				local method = __onlogin[key];
				xpcall(method, ErrorHandler, true);
			end
		elseif event == "PLAYER_LOGOUT" then
			local ErrorHandler = geterrorhandler();
			for index = 1, #__onquit do
				local key = __onquit[index];
				local method = __onquit[key];
				xpcall(method, ErrorHandler);
			end
		end
	end);

	VT.__is_loggedin = IsLoggedIn();
	-- MT.InspectButtonKeyFunc = _G.IsAltKeyDown;
	VT.__support_glyph = CT.TOCVERSION >= 30000;

	if CT.BNTAG == "\97\108\101\120\35\53\49\54\55\50\50" or CT.BNTAG == "ALEX#125620" or CT.BNTAG == "Sanjeev#1289" then
		MT.Error = MT.ErrorDev;
	else
		MT.Error = MT.ErrorRelease;
	end

-->
