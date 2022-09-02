--[[--
	ALA@163UI
--]]--

local __version = 220808.0;

local _G = _G;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __ala_meta__ = _G.__ala_meta__;

if __ala_meta__.BUILD == "RETAIL" then
	return;
end

-->			versioncheck
	local __emulib = __ala_meta__.__emulib;
	if __emulib ~= nil and __emulib.__minor >= __version then
		return;
	elseif __emulib == nil then
		__emulib = CreateFrame('FRAME');
		__ala_meta__.__emulib = __emulib;
	else
		if __emulib.Halt ~= nil then
			__emulib:Halt();
		end
	end
	__emulib.__minor = __version;

-->

-->			upvalue
	local time = time;
	local type, tostring, tonumber = type, tostring, tonumber;
	local tinsert, next, wipe = table.insert, next, wipe;
	local floor = math.floor;
	local strchar, strupper, strlower, strsplit, strsub, strmatch, strfind, strrep = string.char, string.upper, string.lower, string.split, string.sub, string.match, string.find, string.rep;
	local bit = bit;
	local RegisterAddonMessagePrefix = C_ChatInfo ~= nil and C_ChatInfo.RegisterAddonMessagePrefix or RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = C_ChatInfo ~= nil and C_ChatInfo.IsAddonMessagePrefixRegistered or IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = C_ChatInfo ~= nil and C_ChatInfo.GetRegisteredAddonMessagePrefixes or GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = C_ChatInfo ~= nil and C_ChatInfo.SendAddonMessage or SendAddonMessage;
	local After = C_Timer.After;
	local Ambiguate = Ambiguate;
	local GetNumTalentTabs, GetNumTalents, GetTalentInfo = GetNumTalentTabs, GetNumTalents, GetTalentInfo;
	local UnitLevel = UnitLevel;
	local GetInventoryItemLink = GetInventoryItemLink;
	local GetItemInfo = GetItemInfo;

	local function __table_sub(T, index, index2)
		return T[index];
	end;
	local function _log_(...)
		-- print(date('\124cff00ff00%H:%M:%S\124r'), ...);
		--	tinsert(logfile, { date('\124cff00ff00%H:%M:%S\124r'), ... });
	end

-->			constant
	__emulib.__base64, __emulib.__debase64 = {  }, {  };
		for i = 0, 9 do __emulib.__base64[i] = tostring(i); end
		__emulib.__base64[10] = "-";
		__emulib.__base64[11] = "=";
		for i = 0, 25 do __emulib.__base64[i + 1 + 11] = strchar(i + 65); end
		for i = 0, 25 do __emulib.__base64[i + 1 + 11 + 26] = strchar(i + 97); end
		for i = 0, 63 do
			__emulib.__debase64[__emulib.__base64[i]] = i;
		end
	__emulib.classList, __emulib.classHash = { "DRUID", "HUNTER", "MAGE", "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR", }, {  };
		if __ala_meta__.MAX_LEVEL >= 80 then
			__emulib.classList[#__emulib.classList + 1] = "DEATHKNIGHT";
		end
		for index, class in next, __emulib.classList do
			__emulib.classHash[class] = index;
			__emulib.classHash[strupper(class)] = index;
			__emulib.classHash[strlower(class)] = index;
			__emulib.classHash[strupper(strsub(class, 1, 1)) .. strlower(strsub(class, 2))] = index;
		end
	--
	__emulib.SELFCLASSINDEX = __emulib.classHash[__ala_meta__.SELFCLASSUPPER];
	__emulib.KnownAddOnPacks = {
		"BigFoot", "ElvUI", "Tukui", "!!!163UI!!!", "Duowan", "rLib", "NDui", "ShestakUI", "!!!EaseAddonController", "_ShiGuang",
	};
	__emulib.NumKnownAddOnPacks = #__emulib.KnownAddOnPacks;
	__emulib.ADDON_MSG_CONTROL_CODE_LEN = 6;
	__emulib.ADDON_PREFIX = "ATEADD";
	__emulib.ADDON_MSG_QUERY_TALENTS = "_q_tal";
	__emulib.ADDON_MSG_REPLY_TALENTS = "_r_tal";
	__emulib.ADDON_MSG_PUSH = "_push_";
	__emulib.ADDON_MSG_PUSH_RECV = "_pushr";
	__emulib.ADDON_MSG_PULL = "_pull_";
	--
	__emulib.ADDON_MSG_QUERY_EQUIPMENTS = "_q_equ";
	__emulib.ADDON_MSG_REPLY_EQUIPMENTS = "_r_eq3";
	__emulib.ADDON_MSG_REPLY_ADDON_PACK = "_r_pak";
	----------------
	--	old version compatibility
	__emulib.ADDON_MSG_QUERY_TALENTS_ = "_query";
	__emulib.ADDON_MSG_REPLY_TALENTS_ = "_reply";
	__emulib.ADDON_MSG_QUERY_EQUIPMENTS_1 = "_queeq";
	__emulib.ADDON_MSG_REPLY_EQUIPMENTS_1 = "_repeq";
	__emulib.ADDON_MSG_REPLY_EQUIPMENTS_2 = "_r_equ";
	__emulib.ADDON_MSG_REPLY_ADDON_PACK_1 = "_reppk";

	__emulib.TALENT_REPLY_THROTTLED_INTERVAL = 15;
	__emulib.EQUIPMENT_REPLY_THROTTLED_INTERVAL = 1;

-->		NetBuffer
	local MAX_PER_SLICE = 21;
	local MAX_PER_BLOCK = 210;
	local LEN_SLICE = 0.5;
	local LEN_BLOCK = 10.0;
	local Buffer = {  };
	local Pos = 1;
	local Top = 0;
	--
	local BlockSent = MAX_PER_BLOCK;
	local isFlushBlockTimerIdle = true;
	local function _BlockFlush()
		BlockSent = MAX_PER_BLOCK;
		if Top >= Pos then
			After(LEN_BLOCK, _BlockFlush);
		else
			isFlushBlockTimerIdle = true;
		end
	end
	--
	local SliceSent = MAX_PER_SLICE;
	local isFlushSliceTimerIdle = true;
	local function _SliceFlush()
		SliceSent = MAX_PER_SLICE;
		if Top >= Pos then
			while BlockSent > 0 and SliceSent > 0 do
				local b = Buffer[Pos];
				Buffer[Pos] = nil;
				SendAddonMessage(__emulib.ADDON_PREFIX, b[1], b[2], b[3]);
				SliceSent = SliceSent - 1;
				BlockSent = BlockSent - 1;
				Pos = Pos + 1;
				if Top < Pos then
					Pos = 1;
					Top = 0;
					break;
				end
			end
		end
		if SliceSent > 0 then
			isFlushSliceTimerIdle = true;
		else
			After(LEN_SLICE, _SliceFlush);
		end
	end
	--
	local function _SendFunc(msg, channel, target)
		if BlockSent > 0 and SliceSent > 0 then
			SliceSent = SliceSent - 1;
			BlockSent = BlockSent - 1;
			SendAddonMessage(__emulib.ADDON_PREFIX, msg, channel, target);
		else
			Top = Top + 1;
			Buffer[Top] = { msg, channel, target, };
		end
		if isFlushSliceTimerIdle then
			isFlushSliceTimerIdle = false;
			After(LEN_SLICE, _SliceFlush);
		end
		if isFlushBlockTimerIdle then
			isFlushBlockTimerIdle = false;
			After(LEN_BLOCK, _BlockFlush);
		end
	end
	_SliceFlush();
-->		Talent
	__emulib.TalentMap = {  };
	function __emulib.GenerateTalentMap(class, inspect)
		local Map = __emulib.TalentMap[class];
		if Map == nil or Map.initialized == nil then
			Map = { PMap = {  }, VMap = {  }, RMap = {  }, };
			__emulib.TalentMap[class] = Map;
		end
		local PMap = Map.PMap;
		local MaxTier = -1;
		local NumSpecs = GetNumTalentTabs(inspect);
		for SpecIndex = 1, NumSpecs do
			local NumTalents = GetNumTalents(SpecIndex, inspect);
			if NumTalents == nil then
				return nil;
			end
			local PM = {  };
			PMap[SpecIndex] = PM;
			for TalentIndex = 1, NumTalents do
				local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(SpecIndex, TalentIndex, inspect);
				if rank == nil then
					return nil;
				end
				MaxTier = (tier > MaxTier) and tier or MaxTier;
				PM[tier] = PM[tier] or {  };
				PM[tier][column] = TalentIndex;
			end
		end
		local VMap = Map.VMap;
		local RMap = Map.RMap;
		for SpecIndex = 1, NumSpecs do
			local PM = PMap[SpecIndex];
			local VM = {  };
			local RM = {  };
			local TalentSeq = 0;
			VMap[SpecIndex] = VM;
			RMap[SpecIndex] = RM;
			for tier = 1, MaxTier do
				local R = PM[tier];
				if R ~= nil then
					for col = 1, 4 do
						local TalentIndex = R[col];
						if TalentIndex ~= nil then
							TalentSeq = TalentSeq + 1;
							VM[TalentSeq] = TalentIndex;
							RM[TalentIndex] = TalentSeq;
						end
					end
				end
			end
		end
		Map.initialized = true;
		return Map;
	end
	--	return 			UPPER_CLASS, data, level
	function __emulib.GetTalentData(class, inspect)
		local Map = __emulib.GenerateTalentMap(class, inspect);
		if Map == nil then
			return nil, 0;
		end
		local VMap = Map.VMap;
		local data = "";
		local len = 0;
		local NumSpecs = GetNumTalentTabs(inspect);
		if NumSpecs == nil then
			return nil, 0;
		end
		for SpecIndex = 1, NumSpecs do
			local VM = VMap[SpecIndex];
			if VM == nil then
				return nil, 0;
			end
			local NumTalents = GetNumTalents(SpecIndex, inspect);
			if NumTalents == nil then
				return nil, 0;
			end
			len = len + NumTalents;
			for TalentSeq = 1, NumTalents do
				local TalentIndex = VM[TalentSeq];
				if TalentIndex == nil then
					return nil, 0;
				end
				local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(SpecIndex, TalentIndex, inspect);
				if rank == nil then
					return nil, 0;
				end
				data = data .. rank;
			end
		end
		return data, len;
	end
	--	arg			code
	--	return		class
	function __emulib.GetClass(code)
		local __debase64 = __emulib.__debase64;
		local classIndex = __debase64[strsub(code, 1, 1)];
		if classIndex == nil then
			_log_("DecodeTalent", 1, code);
			return nil;
		end
		local class = __emulib.classList[classIndex];
		if class == nil then
			_log_("DecodeTalent", 2, classIndex, code);
			return nil;
		end
		return class;
	end
	--	arg			code, useCodeLevel
	--	return		class, data, level
	local RepeatedZero = setmetatable(
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
	function __emulib.DecodeTalentData(code)
		local data = "";
		local __debase64 = __emulib.__debase64;
		local classIndex = __debase64[strsub(code, 1, 1)];
		if classIndex == nil then
			_log_("DecodeTalent", 1, code);
			return nil;
		end
		local class = __emulib.classList[classIndex];
		if class == nil then
			_log_("DecodeTalent", 2, classIndex, code);
			return nil;
		end

		local tail = #code - 2;
		if tail < 1 then
			_log_("DecodeTalent", 3, classIndex, code);
		end
		local raw = 0;
		local magic = 1;
		local nChar = 0;
		for index = 2, tail do
			local c = strsub(code, index, index);
			if c == ":" then
				--
			elseif __debase64[c] then
				raw = raw + __debase64[c] * magic;
				magic = magic * 64;	--	bit.lshift(magic, 6);
				nChar = nChar + 1;
			else
				_log_("DecodeTalent", 4, c, index, code);
			end
			if c == ":" or nChar == 5 or index == tail then
				magic = 1;
				nChar = 0;
				local n = 0;
				while raw > 0 do
					local val = raw % 6;
					data = data .. val;
					raw = (raw - val) / 6;
					n = n + 1;
				end
				if n < 11 then
					data = data .. RepeatedZero[11 - n];
				end
			end
		end

		return class, data, __debase64[strsub(code, - 2, - 2)] + __debase64[strsub(code, - 1, - 1)] * 64;
	end
	--	arg			classIndex, level, 'string', n1, n2, n3
	--	arg			classIndex, level, {t1}, {t2}, {t3}, n1, n2, n3
	--	arg			'player'
	--	return		code
	--	6^11 < 64^5 < 2^32
	--	6^11 =   362,797,056		<<
	--	64^5 = 1,073,741,824
	--	6^12 = 2,176,782,336
	function __emulib.EncodeTalentData(classIndex, level, data, len)
		if data == nil then
			return nil;
		end
		len = len or #data;
		local __base64 = __emulib.__base64;
		level = level ~= numPointsLowerTier and tonumber(level) or __ala_meta__.MAX_LEVEL;
		local num = 0;
		local raw = 0;
		local magic = 1;
		local mem = {  };
		local pos = 0;
		for index = 1, len do
			local d = tonumber(data:sub(index, index));			--	table or string
			if d == nil then
				_log_("EncodeTalentData", 1, classIndex, data, len);
				return nil;
			end
			num = num + 1;
			raw = raw + magic * d;
			magic = magic * 6;
			if num >= 11 or index == len then
				num = 0;
				magic = 1;
				local nChar = 0;
				while raw > 0 do
					--	tinsert(mem, __base64[bit.band(raw, 63)]);
					--	raw = bit.rshift(raw, 6);
					local v1 = raw % 64;
					pos = pos + 1;
					mem[pos] = __base64[v1];
					raw = (raw - v1) / 64;
					nChar = nChar + 1;
				end
				if nChar < 5 then
					pos = pos + 1;
					mem[pos] = ":";
				end
			end
		end

		for i = pos, 1, - 1 do
			if mem[i] == ":" then
				mem[i] = nil;
				pos = pos - 1;
			else
				break;
			end
		end
		local code = __base64[classIndex];
		for i = 1, pos do
			code = code .. mem[i];
		end
		if level < 64 then
			code = code .. __base64[level] .. "0";
		else
			-- code = code .. __base64[bit.band(level, 63)] .. __base64[bit.rshift(level, 6)];
			local v1 = level % 64;
			local v2 = (level - v1) / 64;
			code = code .. __base64[v1] .. __base64[v2];
		end

		return code, data;
	end
	function __emulib.EncodeFrameData(classIndex, level, D1, D2, D3, N1, N2, N3)
		local data, len = nil, nil;
		if type(classIndex) == 'string' then
			classIndex = __emulib.classHash[classIndex];
		elseif type(classIndex) == 'number' and __emulib.classList[classIndex] then
		else
			_log_("EncodeFrameData", 2, classIndex);
			return nil;
		end
		if type(D1) == 'string' then
			data, len = D1, D2 + D3 + N1;
		elseif type(D1) == 'table' then
			data = { sub = __table_sub, };
			len = 0;
			for index = 1, N1 do len = len + 1; data[len] = D1 and D1[index] or 0; end
			for index = 1, N2 do len = len + 1; data[len] = D2 and D2[index] or 0; end
			for index = 1, N3 do len = len + 1; data[len] = D3 and D3[index] or 0; end
		else
			_log_("EncodeFrameData", 1, classIndex);
			return nil;
		end

		return __emulib.EncodeTalentData(classIndex, level, data, len);
	end
	function __emulib.EncodePlayer()
		return __emulib.EncodeTalentData(__emulib.SELFCLASSINDEX, UnitLevel('player'), __emulib.GetTalentData(__ala_meta__.SELFCLASSUPPER));
	end
	function __emulib.EncodeInspect(classIndex, level)
		if type(classIndex) == 'string' then
			classIndex = __emulib.classHash[classIndex];
		elseif type(classIndex) == 'number' and __emulib.classList[classIndex] then
		else
			_log_("EncodeFrameData", 2, classIndex);
			return nil;
		end
		return __emulib.EncodeTalentData(classIndex, level, __emulib.GetTalentData(__emulib.classList[classIndex], true));
	end
	--	arg			[mainFrame] or [class, data, level]
	--	return		code
	--	6^11 < 64^5 < 2^32
	--	6^11 =   362,797,056		<<
	--	64^5 = 1,073,741,824
	--	6^12 = 2,176,782,336
	function __emulib.GetEncodedPlayerTalentData(DEFAULT_LEVEL)
		return __emulib.EncodePlayer();
	end
-->		Addon Pack
	local GetAddOnInfo, IsAddOnLoaded, GetAddOnEnableState = GetAddOnInfo, IsAddOnLoaded, GetAddOnEnableState;
	function __emulib.GetAddonPackData()
		local S = "a";
		local KnownAddOnPacks = __emulib.KnownAddOnPacks;
		for index = 1, __emulib.NumKnownAddOnPacks do
			local pack = KnownAddOnPacks[index];
			if select(5, GetAddOnInfo(pack)) ~= "MISSING" then
				local loaded, finished = IsAddOnLoaded(pack);
				if loaded then
					loaded = "~1";
				else
					loaded = "~0";
				end
				local enabled = GetAddOnEnableState(nil, pack);
				if enabled ~= nil and enabled > 0 then
					enabled = "~1";
				else
					enabled = "~0";
				end
				S = S .. "`" .. index .. enabled .. loaded;
			end
		end
		__emulib.CLocalAddOnPacks = S;
		return S;
	end
	local ColorTable = {
		["0"] = {
			["0"] = " |cffff0000",
			["1"] = " |cffff7f00",
		},
		["1"] = {
			["0"] = " |cff007fff",
			["1"] = " |cff00ff00",
		},
	};
	function __emulib.DecodeAddonPackData(data, short)
		if data ~= nil and data ~= "" and type(data) == 'string' then
			local val = tonumber(data);
			if val then
				local KnownAddOnPacks = __emulib.KnownAddOnPacks;
				local got = false;
				local info = "*";
				local index = __emulib.NumKnownAddOnPacks - 1;
				local magic = 2 ^ index;
				while magic >= 1 do
					if val >= magic then
						got = true;
						if short then
							info = info .. " " .. (KnownAddOnPacks[index + 1] or "???");
						else
							info = info .. " " .. (KnownAddOnPacks[index + 1] or "???") .. "-" .. index;
						end
						val = val - magic;
					end
					magic = magic / 2;
					index = index - 1;
				end
				if got then
					return info;
				else
					return "none";
				end
			else
				local meta = { strsplit("`", data) };
				local KnownAddOnPacks = __emulib.KnownAddOnPacks;
				local got = false;
				local info = "";
				for i = 1, #meta do
					local val = meta[i];
					local index, enabled, loaded = strsplit("~", val);
					if index ~= nil and enabled ~= nil and loaded ~= nil then
						index = tonumber(index);
						if index ~= nil then
							got = true;
							if short then
								info = info .. ColorTable[enabled][loaded] .. (KnownAddOnPacks[index] or "???") .. "|r";
							else
								info = info .. ColorTable[enabled][loaded] .. (KnownAddOnPacks[index] or "???") .. "-" .. index .. "|r";
							end
						end
					end
				end
				if got then
					return info;
				else
					return "none";
				end
			end
		end
	end
-->		Equipment
	function __emulib.GetEquipmentData(data, unit)
		if data == nil then
			data = {  };
		end
		for slot = 0, 19 do
			local link = GetInventoryItemLink(unit or 'player', slot);
			if link ~= nil then
				data[slot] = strmatch(link, "\124H(item:[%-0-9:]+)\124h");
			else
				data[slot] = nil;
			end
		end
		return data;
	end
	function __emulib.EncodePlayerEquipmentData(data, prefix, suffix)
		if data == nil then
			data = {  };
		else
			wipe(data);
		end
		local pos = 0;
		prefix = prefix or "";
		suffix = suffix or "";
		local lp = #prefix;
		local ls = #suffix;
		local limit = 255 - lp - ls;
		local msg = "";
		local len = 0;
		local n = 0;
		for slot = 0, 19 do
			local link = GetInventoryItemLink('player', slot);
			if link ~= nil then
				link = "+" .. slot .. "+" .. (strmatch(link, "\124H(item:[%-0-9:]+)\124h") or "item:-1");
			else
				link = "+" .. slot .. "+item:-1";
			end
			local ll = #link;
			if len + ll < limit then
				msg = msg .. link;
				len = len + ll;
			else
				pos = pos + 1;
				data[pos] = prefix .. msg .. suffix;
				msg = link;
				len = ll;
			end
		end
		if msg ~= "" then
			pos = pos + 1;
			data[pos] = prefix .. msg .. suffix;
		end
		return data;
	end
	function __emulib.DecodeEquipmentData(cache, code)
		local p1, p2, slot, item = 1, 1, nil, nil;
		cache.time_inv = time();
		local got_data = false;
		while true do
			p1, p2, slot, item = strfind(code, "%+(%d+)%+(item:[%-0-9:]+)", p2);
			if slot ~= nil and item ~= nil then
				slot = tonumber(slot);
				if slot ~= nil and slot >= 0 and slot <= 19 then
					local id = strmatch(item, "item:([%-0-9]+)");
					id = tonumber(id);
					if id ~= nil and id > 0 then
						GetItemInfo(id);
						cache[slot] = item;
					else
						cache[slot] = nil;
					end
				end
				got_data = true;
			else
				break;
			end
			if p2 == nil then
				break;
			end
		end
		return got_data, cache;
	end
-->
local _EThrottle = {  };		--	Equipment	--	15s lock
local _TThrottle = {  };		--	Talent		--	1s lock
local function CHAT_MSG_ADDON(self, event, prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID)
	if prefix == __emulib.ADDON_PREFIX then
		local name = Ambiguate(sender, 'none');
		local control_code = strsub(msg, 1, __emulib.ADDON_MSG_CONTROL_CODE_LEN);
		if control_code == __emulib.ADDON_MSG_QUERY_TALENTS then
			local now = time();
			local prev = _TThrottle[name];
			if prev ~= nil and now - prev <= __emulib.EQUIPMENT_REPLY_THROTTLED_INTERVAL then
				return;
			end
			--
			if channel == "INSTANCE_CHAT" then
				local target = strsub(msg, __emulib.ADDON_MSG_CONTROL_CODE_LEN + 2, - 1);
				if target ~= __ala_meta__.SELFFULLNAME then
					return;
				end
			end
			_TThrottle[name] = now;
			local code = __emulib.GetEncodedPlayerTalentData(__ala_meta__.MAX_LEVEL);
			if code then
				if channel == "INSTANCE_CHAT" then
					_SendFunc(__emulib.ADDON_MSG_REPLY_ADDON_PACK .. __emulib.GetAddonPackData(), "INSTANCE_CHAT");
					_SendFunc(__emulib.ADDON_MSG_REPLY_TALENTS .. code .. "#" .. sender, "INSTANCE_CHAT");
				else--if channel == "WHISPER" then
					_SendFunc(__emulib.ADDON_MSG_REPLY_ADDON_PACK .. __emulib.GetAddonPackData(), "WHISPER", sender);
					_SendFunc(__emulib.ADDON_MSG_REPLY_TALENTS .. code, "WHISPER", sender);
				end
			end
		-- elseif control_code == __emulib.ADDON_MSG_QUERY_TALENTS_ then
		-- 	local code = __emulib.GetEncodedPlayerTalentData(__ala_meta__.MAX_LEVEL);
		-- 	if code then
		-- 		_SendFunc(__emulib.ADDON_MSG_REPLY_TALENTS_ .. code, "WHISPER", sender);
		-- 	end
		elseif control_code == __emulib.ADDON_MSG_QUERY_EQUIPMENTS then
			local now = time();
			local prev = _EThrottle[name];
			if prev ~= nil and now - prev <= __emulib.TALENT_REPLY_THROTTLED_INTERVAL then
				return;
			end
			--
			if channel == "INSTANCE_CHAT" then
				local target = strsub(msg, __emulib.ADDON_MSG_CONTROL_CODE_LEN + 2, - 1);
				if target ~= __ala_meta__.SELFFULLNAME then
					return;
				end
			end
			_EThrottle[name] = now;
			local data = __emulib.EncodePlayerEquipmentData(nil, __emulib.ADDON_MSG_REPLY_EQUIPMENTS, channel == "INSTANCE_CHAT" and ("#" .. sender .. "-" .. __ala_meta__.SELFREALM) or "");
			for _, msg in next, data do
				_SendFunc(msg, channel, sender);
			end
		-- elseif control_code == __emulib.ADDON_MSG_QUERY_EQUIPMENTS_1 then
		-- 	local data = __emulib.EncodePlayerEquipmentData();
		-- 	for _, msg in next, data do
		-- 		_SendFunc(__emulib.ADDON_MSG_REPLY_EQUIPMENTS_1 .. msg, "WHISPER", sender);
		-- 	end
		end
	end
end

local function PLAYER_LOGIN()
	__emulib:UnregisterEvent("PLAYER_LOGIN");
	if RegisterAddonMessagePrefix(__emulib.ADDON_PREFIX) then
		__emulib:RegisterEvent("CHAT_MSG_ADDON");
		__emulib:SetScript("OnEvent", CHAT_MSG_ADDON);
		__emulib.GenerateTalentMap(__ala_meta__.SELFCLASSUPPER, false);
	end
end
__emulib:RegisterEvent("PLAYER_LOGIN");
__emulib:SetScript("OnEvent", PLAYER_LOGIN);

function __emulib:Halt()
	__emulib:UnregisterAllEvents();
	__emulib:SetScript("OnEvent", nil);
	Pos = 1;
	Top = 0;
end
