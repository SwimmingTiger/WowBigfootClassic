--[[--
	ALA@163UI
--]]--
local __version = 3;

_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __emulib = __ala_meta__.__emulib;
if __emulib ~= nil and __emulib.__minor >= __version then
	return;
end
__emulib = __emulib or CreateFrame('FRAME');
__emulib.__minor = __version;
__ala_meta__.__emulib = __emulib;

local _G = _G;
do
	if __emulib.__fenv == nil then
		__emulib.__fenv = setmetatable({  },
				{
					__index = _G,
					__newindex = function(t, key, value)
						rawset(t, key, value);
						print("emulib assign global", key, value);
						return value;
					end,
				}
			);
	end
	setfenv(1, __emulib.__fenv);
end

-->			upvalue
local tinsert, tremove, next, wipe = tinsert, tremove, next, wipe;
local type, tostring, tonumber = type, tostring, tonumber;
local floor = floor;
local strsub, strfind, strrep = strsub, strfind, strrep;
local bit = bit;
local _ = nil;
local RegisterAddonMessagePrefix = RegisterAddonMessagePrefix or C_ChatInfo.RegisterAddonMessagePrefix;
local IsAddonMessagePrefixRegistered = IsAddonMessagePrefixRegistered or C_ChatInfo.IsAddonMessagePrefixRegistered;
local GetRegisteredAddonMessagePrefixes = GetRegisteredAddonMessagePrefixes or C_ChatInfo.GetRegisteredAddonMessagePrefixes;
local SendAddonMessage = SendAddonMessage or C_ChatInfo.SendAddonMessage;
local Ambiguate = Ambiguate;
local GetNumTalents, GetTalentInfo = GetNumTalents, GetTalentInfo;
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
	for index, class in next, __emulib.classList do
		__emulib.classHash[class] = index;
		__emulib.classHash[strupper(class)] = index;
		__emulib.classHash[strlower(class)] = index;
	end
__emulib.CPlayerFactionGroup = UnitFactionGroup('player');
__emulib.CPlayerClass = UnitClassBase('player');
__emulib.CPlayerClassUpper = strupper(__emulib.CPlayerClass);
__emulib.CPlayerClassLower = strlower(__emulib.CPlayerClass);
__emulib.CPlayerClassIndex = __emulib.classHash[__emulib.CPlayerClassUpper];
__emulib.CPlayerGUID = UnitGUID('player');
__emulib.CPlayerName = UnitName('player');
__emulib.CRealmName = GetRealmName();
__emulib.CPlayerFullName = __emulib.CPlayerName .. "-" .. __emulib.CRealmName;
__emulib.CKnownAddOnPacks = {
	"BigFoot", "ElvUI", "Tukui", "!!!163UI!!!", "Duowan", "rLib", "NDui", "ShestakUI", "!!!EaseAddonController", "_ShiGuang",
};
__emulib.CLocalAddOnPacks = 0;
for index, pack in next, __emulib.CKnownAddOnPacks do
	if select(5, GetAddOnInfo(pack)) ~= "MISSING" then
		__emulib.CLocalAddOnPacks = __emulib.CLocalAddOnPacks + 2 ^ (index - 1);
	end
end
__emulib.ADDON_MSG_CONTROL_CODE_LEN = 6;
__emulib.ADDON_PREFIX = "ATEADD";
__emulib.ADDON_MSG_QUERY_TALENTS = "_q_tal";
__emulib.ADDON_MSG_REPLY_TALENTS = "_r_tal";
__emulib.ADDON_MSG_PUSH = "_push_";
__emulib.ADDON_MSG_PUSH_RECV = "_pushr";
__emulib.ADDON_MSG_PULL = "_pull_";
--
__emulib.ADDON_MSG_QUERY_EQUIPMENTS = "_q_equ";
__emulib.ADDON_MSG_REPLY_EQUIPMENTS = "_r_equ";
__emulib.ADDON_MSG_REPLY_ADDON_PACK = "_r_pak";
----------------
--	old version compatibility
__emulib.ADDON_MSG_QUERY_TALENTS_ = "_query";
__emulib.ADDON_MSG_REPLY_TALENTS_ = "_reply";
__emulib.ADDON_MSG_QUERY_EQUIPMENTS_ = "_queeq";
__emulib.ADDON_MSG_REPLY_EQUIPMENTS_ = "_repeq";
__emulib.ADDON_MSG_REPLY_ADDON_PACK_ = "_reppk";

-->		Talent
	--	return 			UPPER_CLASS, data, level
	function __emulib.GetPlayerTalentData(DEFAULT_LEVEL)
		local data = "";
		local len = 0;
		for specIndex = 1, 3 do
			local numTalents = GetNumTalents(specIndex);
			len = len + numTalents;
			for index = 1, numTalents do
				local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(specIndex, index);
				data = data .. rank;
			end
		end
		return __emulib.CPlayerClassIndex, data, type(DEFAULT_LEVEL) == 'number' and DEFAULT_LEVEL or UnitLevel('player'), len;
	end
	--	arg			code, useCodeLevel
	--	return		class, data, level
	function __emulib.DecodeTalentData(code)
		local data = "";
		local __debase64 = __emulib.__debase64;
		local classIndex = __debase64[strsub(code, 1, 1)];
		if not classIndex then
			_log_("DecodeTalent", 1, code);
			return nil;
		end
		local class = __emulib.classList[classIndex];
		if not class then
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
				magic = bit.lshift(magic, 6);
				nChar = nChar + 1;
			else
				_log_("DecodeTalent", 4, c, index, code);
			end
			if c == ":" or nChar == 5 or index == tail then
				magic = 1;
				nChar = 0;
				local n = 0;
				while raw > 0 do
					data = data .. raw % 6;
					raw = floor(raw / 6);
					n = n + 1;
				end
				if n < 11 then
					data = data .. strrep("0", 11 - n);
				end
			end
		end

		return class, data, __debase64[strsub(code, - 2, - 2)] + bit.lshift(__debase64[strsub(code, - 1, - 1)], 6);
	end
	--	arg			classIndex, level, 'string', n1, n2, n3
	--	arg			classIndex, level, {t1}, {t2}, {t3}, n1, n2, n3
	--	arg			'player'
	--	return		code
	--	6^11 < 64^5 < 2^32
	--	6^11 =   362,797,056		<<
	--	64^5 = 1,073,741,824‬
	--	6^12 = 2,176,782,336
	function __emulib.EncodeTalentData(classIndex, level, D1, D2, D3, N1, N2, N3)
		local data, len = nil, nil;
		if classIndex == 'player' then
			classIndex, data, level, len = __emulib.GetPlayerTalentData(level);
		else
			if type(classIndex) == 'string' then
				classIndex = __emulib.classHash[classIndex];
			elseif type(classIndex) == 'number' and __emulib.classList[classIndex] then
			else
				_log_("EncodeTalentData", 2, classIndex);
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
				_log_("EncodeTalentData", 1, classIndex);
				return nil;
			end
		end
		local __base64 = __emulib.__base64;
		level = level and tonumber(level) or 60;
		local pos = 0;
		local raw = 0;
		local magic = 1;
		local mem = {  };
		for index = 1, len do
			local d = tonumber(data:sub(index, index));			--	table or string
			if not d then
				_G.ala=data;
				_log_("EncodeTalentData", 3, classIndex, data, len);
				return nil;
			end
			pos = pos + 1;
			raw = raw + magic * d;
			magic = magic * 6;
			if pos >= 11 or index == len then
				pos = 0;
				magic = 1;
				local nChar = 0;
				while raw > 0 do
					tinsert(mem, __base64[bit.band(raw, 63)]);
					raw = bit.rshift(raw, 6);
					nChar = nChar + 1;
				end
				if nChar < 5 then
					tinsert(mem, ":");
				end
			end
		end

		for i = #mem, 1, - 1 do
			if mem[i] == ":" then
				mem[i] = nil;
			else
				break;
			end
		end
		local code = __base64[classIndex];
		for i = 1, #mem do
			code = code .. mem[i];
		end
		if level < 64 then
			code = code .. __base64[level] .. "0";
		else
			code = code .. __base64[bit.band(level, 63)] .. __base64[bit.rshift(level, 6)];
		end

		return code;
	end
	--	arg			[mainFrame] or [class, data, level]
	--	return		code
	--	6^11 < 64^5 < 2^32
	--	6^11 =   362,797,056		<<
	--	64^5 = 1,073,741,824‬
	--	6^12 = 2,176,782,336
	function __emulib.GetEncodedPlayerTalentData(DEFAULT_LEVEL)
		return __emulib.EncodeTalentData('player');
	end
-->		Addon Pack
	function __emulib.GetAddonPackData()
		return __emulib.CLocalAddOnPacks;
	end
	function __emulib.DecodeAddonPackData(data, short)
		if data and data ~= "" then
			data = tonumber(data);
			if data then
				local CKnownAddOnPacks = __emulib.CKnownAddOnPacks;
				local info = nil;
				local index = #CKnownAddOnPacks - 1;
				local magic = 2 ^ index;
				while magic >= 1 do
					if data >= magic then
						if short then
							info = info and (info .. " " .. (CKnownAddOnPacks[index + 1] or "???")) or (CKnownAddOnPacks[index + 1] or "???");
						else
							info = info and (info .. " " .. (CKnownAddOnPacks[index + 1] or "???") .. "-" .. index) or ((CKnownAddOnPacks[index + 1] or "???") .. "-" .. index);
						end
						data = data - magic;
					end
					magic = magic / 2;
					index = index - 1;
				end
				return info or "none";
			end
		end
	end
-->		Equipment
	function __emulib.GetEquipmentData(data)
		if data == nil then
			data = {  };
		else
			wipe(data);
		end
		for slot = 0, 19 do
			local link = GetInventoryItemLink('player', slot);
			if link then
				_, _, link = strfind(link, "\124H(item:[%-0-9:]+)\124h");
			end
			link = link or "item:-1";
			data[slot] = link;
		end
		return data;
	end
	function __emulib.EncodeEquipmentData(data)
		if data == nil then
			data = {  };
		else
			wipe(data);
		end
		local msg = "";
		local n = 0;
		for slot = 0, 19 do
			local link = GetInventoryItemLink('player', slot);
			if link then
				_, _, link = strfind(link, "\124H(item:[%-0-9:]+)\124h");
			end
			link = link or "item:-1";
			msg = msg .. "+" .. slot .. "+" .. link;
			n = n + 1;
			if n >= 4 then
				n = 0;
				tinsert(data, msg);
				msg = "";
			end
		end
		if msg ~= "" then
			tinsert(data, msg);
		end
		return data;
	end
	function __emulib.DecodeEquipmentData(cache, code)
		local start, slot, item = 1, nil, nil;
		cache.time_inv = time();
		local got_data = false;
		while true do
			_, start, slot, item = strfind(code, "%+(%d+)%+(item:[%-0-9:]+)", start);
			if slot and item then
				slot = tonumber(slot);
				if slot and slot >= 0 and slot <= 19 then
					local _, _, id = strfind(item, "item:([%-0-9]+)");
					id = tonumber(id);
					if id and id > 0 then
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
			if not start then
				break;
			end
		end
		return got_data, cache;
	end
-->
local function CHAT_MSG_ADDON(prefix, msg, channel, sender)
	local name = Ambiguate(sender, 'none');
	local control_code = strsub(msg, 1, __emulib.ADDON_MSG_CONTROL_CODE_LEN);
	if control_code == __emulib.ADDON_MSG_QUERY_TALENTS then
		if channel == "INSTANCE_CHAT" then
			local target = strsub(msg, __emulib.ADDON_MSG_CONTROL_CODE_LEN + 2, - 1);
			if target ~= __emulib.CPlayerFullName then
				return;
			end
		end
		local code = __emulib.GetEncodedPlayerTalentData(60);
		if code then
			if channel == "INSTANCE_CHAT" then
				SendAddonMessage(prefix, __emulib.ADDON_MSG_REPLY_ADDON_PACK .. __emulib.GetAddonPackData(), "INSTANCE_CHAT");
				SendAddonMessage(prefix, __emulib.ADDON_MSG_REPLY_TALENTS .. code .. "#" .. sender, "INSTANCE_CHAT");
			else--if channel == "WHISPER" then
				SendAddonMessage(prefix, __emulib.ADDON_MSG_REPLY_ADDON_PACK .. __emulib.GetAddonPackData(), "WHISPER", sender);
				SendAddonMessage(prefix, __emulib.ADDON_MSG_REPLY_TALENTS .. code, "WHISPER", sender);
			end
		end
	-- elseif control_code == __emulib.ADDON_MSG_QUERY_TALENTS_ then
	-- 	local code = __emulib.GetEncodedPlayerTalentData(60);
	-- 	if code then
	-- 		SendAddonMessage(prefix, __emulib.ADDON_MSG_REPLY_TALENTS_ .. code, "WHISPER", sender);
	-- 	end
	elseif control_code == __emulib.ADDON_MSG_QUERY_EQUIPMENTS then
		if channel == "INSTANCE_CHAT" then
			local target = strsub(msg, __emulib.ADDON_MSG_CONTROL_CODE_LEN + 2, - 1);
			if target ~= __emulib.CPlayerFullName then
				return;
			end
		end
		local data = __emulib.EncodeEquipmentData();
		for _, msg in next, data do
			if channel == "INSTANCE_CHAT" then
				SendAddonMessage(prefix, __emulib.ADDON_MSG_REPLY_EQUIPMENTS .. msg .. "#" .. sender .. "-" .. __emulib.CRealmName, "INSTANCE_CHAT");
			else--if channel == "WHISPER" then
				SendAddonMessage(prefix, __emulib.ADDON_MSG_REPLY_EQUIPMENTS .. msg, "WHISPER", sender);
			end
		end
	-- elseif control_code == __emulib.ADDON_MSG_QUERY_EQUIPMENTS_ then
	-- 	local data = __emulib.EncodeEquipmentData();
	-- 	for _, msg in next, data do
	-- 		SendAddonMessage(prefix, __emulib.ADDON_MSG_REPLY_EQUIPMENTS_ .. msg, "WHISPER", sender);
	-- 	end
	end
end

__emulib:RegisterEvent("LOADING_SCREEN_DISABLED");
__emulib:SetScript("OnEvent", function(self, event, prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID)
	if event == "CHAT_MSG_ADDON" then
		CHAT_MSG_ADDON(prefix, msg, channel, sender);
	elseif event == "LOADING_SCREEN_DISABLED" then
		__emulib:UnregisterEvent("LOADING_SCREEN_DISABLED");
		if RegisterAddonMessagePrefix(__emulib.ADDON_PREFIX) then
			__emulib:RegisterEvent("CHAT_MSG_ADDON");
		end
	end
end);
