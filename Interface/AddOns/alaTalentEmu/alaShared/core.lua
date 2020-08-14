--[[--
	ALA@163UI
--]]--
local ADDON, NS = ...;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
__ala_meta__.ADDON_MSG_CONTROL_CODE_LEN = __ala_meta__.ADDON_MSG_CONTROL_CODE_LEN or 6;
if __ala_meta__.__rt then
	return;
end
local __ns = {  };
NS.__rt = __ns;
__ala_meta__.__rt = __ns;

local _G = _G;
do
	if __ns.__fenv == nil then
		__ns.__fenv = setmetatable({  },
				{
					__index = _G,
					__newindex = function(t, key, value)
						rawset(t, key, value);
						print("art assign global", key, value);
						return value;
					end,
				}
			);
	end
	setfenv(1, __ns.__fenv);
end

local LOCALE = GetLocale();
-->			upvalue
	local setmetatable, tinsert, tremove, unpack, next = setmetatable, tinsert, tremove, unpack, next;
	local type, tostring = type, tostring;
	local strsplit, strsub, strfind, format = strsplit, strsub, strfind, format;
	local bit = bit;
	local _ = nil;
	local RegisterAddonMessagePrefix = RegisterAddonMessagePrefix or C_ChatInfo.RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = IsAddonMessagePrefixRegistered or C_ChatInfo.IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = GetRegisteredAddonMessagePrefixes or C_ChatInfo.GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = SendAddonMessage or C_ChatInfo.SendAddonMessage;
-->
local function _noop_()
	return true;
end
local function _log_(...)
	--	tinsert(logfile, { date('\124cff00ff00%H:%M:%S\124r'), ... });
end

local _EventHandler = CreateFrame('FRAME');
-->		--	EventHandler
	local function _EventHandler_OnEvent(self, event, ...)
		return __ns[event](...);
	end
	function _EventHandler:FireEvent(event, ...)
		local func = __ns[event];
		if func then
			return func(...);
		end
	end
	function _EventHandler:RegEvent(event)
		__ns[event] = __ns[event] or _noop_;
		self:RegisterEvent(event);
		self:SetScript('OnEvent', _EventHandler_OnEvent);
	end
	function _EventHandler:UnregEvent(event)
		self:UnregisterEvent(event);
	end
-->

local function safe_call(func, ...)
	local success, result = xpcall(func,
		function(msg)
			geterrorhandler()(msg);
		end,
		...
	);
	if success then
		return true, result;
	else
		return false;
	end
end

__ns.prefixHandler = {  };
local ADDON_MSG_CONTROL_CODE_LEN = __ala_meta__.ADDON_MSG_CONTROL_CODE_LEN;
-->		Data
	__ns.__base64, __ns.__debase64 = {  }, {  };
		for i = 0, 9 do __ns.__base64[i] = tostring(i); end
		__ns.__base64[10] = "-";
		__ns.__base64[11] = "=";
		for i = 0, 25 do __ns.__base64[i + 1 + 11] = strchar(i + 65); end
		for i = 0, 25 do __ns.__base64[i + 1 + 11 + 26] = strchar(i + 97); end
		for i = 0, 63 do
			__ns.__debase64[__ns.__base64[i]] = i;
		end
	__ns.classList, __ns.classHash = {
		"DRUID",
		"HUNTER",
		"MAGE",
		"PALADIN",
		"PRIEST",
		"ROGUE",
		"SHAMAN",
		"WARLOCK",
		"WARRIOR",
	}, {  };
		for index, class in next, __ns.classList do
			__ns.classHash[class] = index;
			__ns.classHash[strupper(class)] = index;
			__ns.classHash[strlower(class)] = index;
		end
	__ns.playerFactionGroup = UnitFactionGroup('player');
	__ns.PlayerClass = UnitClassBase('player');
	__ns.playerClassUpper = strupper(__ns.PlayerClass);
	__ns.playerClassLower = strlower(__ns.PlayerClass);
	__ns.playerClassIndex = __ns.classHash[__ns.playerClassUpper];
	__ns.playerGUID = UnitGUID('player');
	__ns.playerName = UnitName('player');
	__ns.realm = GetRealmName();
	__ns.playerFullName = __ns.playerName .. "-" .. __ns.realm;
	__ns.knownAddonPacks = {
		"BigFoot", "ElvUI", "Tukui", "!!!163UI!!!", "Duowan", "rLib", "NDui", "ShestakUI", "!!!EaseAddonController", "_ShiGuang",
	};
	__ns.addonPacks = 0;
	for index, pack in next, __ns.knownAddonPacks do
		if select(5, GetAddOnInfo(pack)) ~= "MISSING" then
			__ns.addonPacks = __ns.addonPacks + 2 ^ (index - 1);
		end
	end
	-->		TalentEmu
		local __emu_meta = {
			ADDON_PREFIX = "ATEADD",
			ADDON_MSG_QUERY_TALENTS = "_q_tal",
			ADDON_MSG_REPLY_TALENTS = "_r_tal",
			ADDON_MSG_PUSH = "_push_",
			ADDON_MSG_PUSH_RECV = "_pushr",
			ADDON_MSG_PULL = "_pull_",
			--
			ADDON_MSG_QUERY_EQUIPMENTS = "_q_equ",
			ADDON_MSG_REPLY_EQUIPMENTS = "_r_equ",
			ADDON_MSG_REPLY_ADDON_PACK = "_r_pak",
			----------------
			ADDON_MSG_QUERY_TALENTS_ = "_query",
			ADDON_MSG_REPLY_TALENTS_ = "_reply",
			--	old version compatibility
			ADDON_MSG_QUERY_EQUIPMENTS_ = "_queeq",
			ADDON_MSG_REPLY_EQUIPMENTS_ = "_repeq",
			ADDON_MSG_REPLY_ADDON_PACK_ = "_reppk",	
			__table_sub = function(T, index, index2)
				return T[index];
			end,
		};
		__ns.__emu_meta = __emu_meta;
		-->		Talent
			--	return 			UPPER_CLASS, data, level
			function __ns.GetPlayerTalentData(DEFAULT_LEVEL)
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
				return __ns.playerClassIndex, data, type(DEFAULT_LEVEL) == 'number' and DEFAULT_LEVEL or UnitLevel('player'), len;
			end
			--	arg			code, useCodeLevel
			--	return		class, data, level
			function __ns.DecodeTalentData(code)
				local data = "";
				local __debase64 = __ns.__debase64;
				local classIndex = __debase64[strsub(code, 1, 1)];
				if not classIndex then
					_log_("DecodeTalent", 1, code);
					return nil;
				end
				local class = __ns.classList[classIndex];
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
							for i = n + 1, 11 do
								data = data .. "0";
							end
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
			function __ns.EncodeTalentData(classIndex, level, D1, D2, D3, N1, N2, N3)
				local data, len = nil, nil;
				if classIndex == 'player' then
					classIndex, data, level, len = __ns.GetPlayerTalentData(level);
				else
					if type(classIndex) == 'string' then
						classIndex = __ns.classHash[classIndex];
					elseif type(classIndex) == 'number' and __ns.classList[classIndex] then
					else
						_log_("EmuCore_Encoder", 2, classIndex);
						return nil;
					end
					if type(D1) == 'string' then
						data, len = D1, D2 + D3 + N1;
					elseif type(D1) == 'table' then
						data = { sub = __emu_meta.__table_sub, };
						len = 0;
						for index = 1, N1 do len = len + 1; data[len] = D1 and D1[index] or 0; end
						for index = 1, N2 do len = len + 1; data[len] = D2 and D2[index] or 0; end
						for index = 1, N3 do len = len + 1; data[len] = D3 and D3[index] or 0; end
					else
						_log_("EmuCore_Encoder", 1, classIndex);
						return nil;
					end
				end
				local __base64 = __ns.__base64;
				level = level and tonumber(level) or 60;
				local pos = 0;
				local raw = 0;
				local magic = 1;
				local mem = {  };
				for index = 1, len do
					local d = tonumber(data:sub(index, index));			--	table or string
					if not d then
						_log_("EncodeTalent", 3, classIndex, data, p);
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
			function __ns.GetEncodedPlayerTalentData(DEFAULT_LEVEL)
				return __ns.EncodeTalentData('player');
			end
		-->		Addon Pack
			function __ns.GetAddonPackData()
				return __ns.addonPacks;
			end
			function __ns.DecodeAddonPackData(data, short)
				if data and data ~= "" then
					data = tonumber(data);
					if data then
						local knownAddonPacks = __ns.knownAddonPacks;
						local info = nil;
						local index = #knownAddonPacks - 1;
						local magic = 2 ^ index;
						while magic >= 1 do
							if data >= magic then
								if short then
									info = info and (info .. " " .. (knownAddonPacks[index + 1] or "???")) or (knownAddonPacks[index + 1] or "???");
								else
									info = info and (info .. " " .. (knownAddonPacks[index + 1] or "???") .. "-" .. index) or ((knownAddonPacks[index + 1] or "???") .. "-" .. index);
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
			function __ns.GetEquipmentData(data)
				if data == nil then
					data = {  };
				else
					wipe(data);
				end
				local _;
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
			function __ns.EncodeEquipmentData(data)
				if data == nil then
					data = {  };
				else
					wipe(data);
				end
				local _;
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
			function __ns.DecodeEquipmentData(cache, code)
				local start, slot, item = 1, nil, nil;
				local _ = nil;
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
		__ns.prefixHandler[__emu_meta.ADDON_PREFIX] = function(prefix, msg, channel, sender)
			local name = Ambiguate(sender, 'none');
			local control_code = strsub(msg, 1, ADDON_MSG_CONTROL_CODE_LEN);
			if control_code == __emu_meta.ADDON_MSG_QUERY_TALENTS then
				if channel == "INSTANCE_CHAT" then
					local target = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 2, - 1);
					if target ~= __ns.playerFullName then
						return;
					end
				end
				local code = __ns.GetEncodedPlayerTalentData(60);
				if code then
					if channel == "INSTANCE_CHAT" then
						SendAddonMessage(prefix, __emu_meta.ADDON_MSG_REPLY_ADDON_PACK .. __ns.GetAddonPackData(), "INSTANCE_CHAT");
						SendAddonMessage(prefix, __emu_meta.ADDON_MSG_REPLY_TALENTS .. code .. "#" .. sender, "INSTANCE_CHAT");
					else--if channel == "WHISPER" then
						SendAddonMessage(prefix, __emu_meta.ADDON_MSG_REPLY_ADDON_PACK .. __ns.GetAddonPackData(), "WHISPER", sender);
						SendAddonMessage(prefix, __emu_meta.ADDON_MSG_REPLY_TALENTS .. code, "WHISPER", sender);
					end
				end
			elseif control_code == __emu_meta.ADDON_MSG_QUERY_TALENTS_ then
				local code = __ns.GetEncodedPlayerTalentData(60);
				if code then
					SendAddonMessage(prefix, __emu_meta.ADDON_MSG_REPLY_TALENTS_ .. code, "WHISPER", sender);
				end
			elseif control_code == __emu_meta.ADDON_MSG_QUERY_EQUIPMENTS then
				if channel == "INSTANCE_CHAT" then
					local target = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 2, - 1);
					if target ~= __ns.playerFullName then
						return;
					end
				end
				local data = __ns.EncodeEquipmentData();
				for _, msg in next, data do
					if channel == "INSTANCE_CHAT" then
						SendAddonMessage(prefix, __emu_meta.ADDON_MSG_REPLY_EQUIPMENTS .. msg .. "#" .. sender .. "-" .. __ns.realm, "INSTANCE_CHAT");
					else--if channel == "WHISPER" then
						SendAddonMessage(prefix, __emu_meta.ADDON_MSG_REPLY_EQUIPMENTS .. msg, "WHISPER", sender);
					end
				end
			elseif control_code == __emu_meta.ADDON_MSG_QUERY_EQUIPMENTS_ then
				local data = __ns.EncodeEquipmentData();
				for _, msg in next, data do
					SendAddonMessage(prefix, __emu_meta.ADDON_MSG_REPLY_EQUIPMENTS_ .. msg, "WHISPER", sender);
				end
			end
		end
		function __ns.initializeTalentEmu()
			RegisterAddonMessagePrefix(__emu_meta.ADDON_PREFIX);
		end
	-->
	-->		InstanceLock
		-->
			--[[
				测试结果
					32次		+5pary次数、不计算20/40raid次数，影响5party和2raid
					5次			+5party次数+20raid次数、不计算40raid次数，影响5party、20raid
					5pary		受每日32次限制且计入32次内、受每小时5次限制
					40raid		不受任何次数限制
					20raid		受每日32次限制但是不计入32次内、受每小时5次限制【5pary计入5次、40raid待确认】
			--]]
		local __inst_meta = CreateFrame('FRAME');
		__ns.__inst_meta = __inst_meta;
		-->
			--		ContinentID	@//DB//AreaTable		--	https://wow.gamepedia.com/InstanceID/Complete_list
			__inst_meta.InstanceIDHash = {
				-->		Continents / Zones
					[0] = false,		--	Eastern Kingdoms
					[1] = false,		--	Kalimdor
					[530] = false,		--	The Burning Crusade	Outland
					[571] = false,		--	Wrath of the Lich King	Northrend
					[646] = false,		--	Cataclysm	Deepholm
					[730] = false,		--	Cataclysm	Maelstrom Zone
					[732] = false,		--	Cataclysm	Tol Barad
					[860] = false,		--	Mists of Pandaria	The Wandering Isle
					[870] = false,		--	Mists of Pandaria	Pandaria
					[1064] = false,		--	Mists of Pandaria	Isle of Thunder
					[1116] = false,		--	Warlords of Draenor	Draenor
					[1191] = false,		--	Warlords of Draenor	Ashran
					[1464] = false,		--	Warlords of Draenor	Tanaan Jungle
					[1220] = false,		--	Legion	Broken Isles
					[1669] = false,		--	Legion	Argus
					[1642] = false,		--	Battle for Azeroth	Zandalar
					[1643] = false,		--	Battle for Azeroth	Kul Tiras
					[1718] = false,		--	Battle for Azeroth	Nazjatar
				-->		Battlegrounds
					[30] = false,		--	Alterac Valley
					[529] = false,		--	Arathi Basin (Classic)
					[1681] = false,		--	Arathi Basin (Winter)
					[2107] = false,		--	Arathi Basin
					[2177] = false,		--	Arathi Basin Comp Stomp
					[1105] = false,		--	Deepwind Gorge
					[566] = false,		--	Eye of the Storm
					[968] = false,		--	Eye of the Storm (Rated)
					[628] = false,		--	Isle of Conquest
					[1803] = false,		--	Seething Shore
					[727] = false,		--	Silvershard Mines
					[607] = false,		--	Strand of the Ancients
					[998] = false,		--	Temple of Kotmogu
					[761] = false,		--	The Battle for Gilneas
					[726] = false,		--	Twin Peaks
					[489] = false,		--	Warsong Gulch
				-->		Arenas
					[562] = false,		--	Blade's Edge Arena
					[617] = false,		--	Dalaran Arena
					[559] = false,		--	Nagrand Arena
					[572] = false,		--	Ruins of Lordaeron
					[618] = false,		--	The Ring of Valor
					[1134] = false,		--	Tiger's Peak
					[980] = false,		--	Tol'Viron Arena
					[2167] = false,		--	The Robodrome
				-->		Dungeons
					--	Vanilla
						[389] = true,		--	Ragefire Chasm
						[43] = true,		--	Wailing Caverns
						[36] = true,		--!	The Deadmines
						[33] = true,		--	Shadowfang Keep
						[48] = true,		--	Blackfathom Deeps
						[34] = true,		--!	The Stockade
						[47] = true,		--	Razorfen Kraul
						[90] = true,		--!	Gnomeregan
						[189] = true,		--!	Scarlet Monastery
						[129] = true,		--	Razorfen Downs
						[70] = true,		--!	Uldaman
						[349] = true,		--	Maraudon
						[209] = true,		--	Zul'Farrak
						[109] = true,		--	The Temple of Atal'Hakkar	--	Sunken Temple
						[230] = true,		--!	Blackrock Depths
						[429] = true,		--	Dire Maul
						[329] = true,		--!	Stratholme
						[229] = true,		--!	Blackrock Spire
						[289] = true,		--!	Scholomance
						--	refored CTM
						[1001] = true,		--[CTM]	Scarlet Halls
						[1004] = true,		--[CTM]	Scarlet Monastery
						[1007] = true,		--[CTM]	Scholomance
					--	Burning Crusade
						[558] = true,		--	Auchenai Crypts
						[543] = true,		--	Hellfire Ramparts
						[585] = true,		--	Magisters' Terrace
						[557] = true,		--	Mana-Tombs
						[560] = true,		--	Old Hillsbrad Foothills
						[556] = true,		--	Sethekk Halls
						[555] = true,		--	Shadow Labyrinth
						[552] = true,		--	The Arcatraz
						[269] = true,		--	The Black Morass
						[542] = true,		--	The Blood Furnace
						[553] = true,		--	The Botanica
						[554] = true,		--	The Mechanar
						[540] = true,		--	The Shattered Halls
						[547] = true,		--	The Slave Pens
						[545] = true,		--	The Steamvault
						[546] = true,		--	The Underbog
					--	Wrath
						[619] = true,		--	Ahn'kahet: The Old Kingdom
						[601] = true,		--	Azjol-Nerub
						[600] = true,		--	Drak'Tharon Keep
						[604] = true,		--	Gundrak
						[602] = true,		--	Halls of Lightning
						[668] = true,		--	Halls of Reflection
						[599] = true,		--	Halls of Stone
						[658] = true,		--	Pit of Saron
						[595] = true,		--	The Culling of Stratholme
						[632] = true,		--	The Forge of Souls
						[576] = true,		--	The Nexus
						[578] = true,		--	The Oculus
						[608] = true,		--	The Violet Hold
						[650] = true,		--	Trial of the Champion
						[574] = true,		--	Utgarde Keep
						[575] = true,		--	Utgarde Pinnacle
					--	Cataclysm
						[645] = true,		--	Blackrock Caverns
						[938] = true,		--	End Time
						[670] = true,		--	Grim Batol
						[644] = true,		--	Halls of Origination
						[940] = true,		--	Hour of Twilight
						[755] = true,		--	Lost City of the Tol'vir
						[725] = true,		--	The Stonecore
						[657] = true,		--	The Vortex Pinnacle
						[643] = true,		--	Throne of the Tides
						[939] = true,		--	Well of Eternity
						[568] = true,		--	Zul'Aman
						[859] = true,		--	Zul'Gurub
					--	Pandaria
						[962] = true,		--	Gate of the Setting Sun
						[994] = true,		--	Mogu'Shan Palace
						[959] = true,		--	Shado-pan Monastery
						[1011] = true,		--	Siege of Niuzao Temple
						[961] = true,		--	Stormstout Brewery
						[960] = true,		--	Temple of the Jade Serpent
					--	Warlords
						[1182] = true,		--	Auchindoun
						[1175] = true,		--	Bloodmaul Slag Mines
						[1208] = true,		--	Grimrail Depot
						[1195] = true,		--	Iron Docks
						[1176] = true,		--	Shadowmoon Burial Grounds
						[1209] = true,		--	Skyreach
						[1279] = true,		--	The Everbloom
						[1358] = true,		--	Upper Blackrock Spire
					--	Legion
						[1501] = true,		--	Black Rook Hold
						[1677] = true,		--	Cathedral of Eternal Night
						[1571] = true,		--	Court of Stars
						[1466] = true,		--	Darkheart Thicket
						[1456] = true,		--	Eye of Azshara
						[1477] = true,		--	Halls of Valor
						[1492] = true,		--	Maw of Souls
						[1458] = true,		--	Neltharion's Lair
						[1651] = true,		--	Return to Karazhan
						[1753] = true,		--	Seat of the Triumvirate
						[1516] = true,		--	The Arcway
						[1493] = true,		--	Vault of the Wardens
						[1544] = true,		--	Violet Hold
					--	BFA
						[1763] = true,		--	Atal'Dazar
						[1754] = true,		--	Freehold
						[1762] = true,		--	Kings' Rest
						[1864] = true,		--	Shrine of the Storm
						[1822] = true,		--	Siege of Boralus
						[1877] = true,		--	Temple of Sethraliss
						[1594] = true,		--	The MOTHERLODE!!
						[1841] = true,		--	The Underrot
						[1771] = true,		--	Tol Dagor
						[1862] = true,		--	Waycrest Manor
						[2097] = true,		--	Operation: Mechagon
				-->		Raids
					--	Vanilla
						[309] = true,		--!	Zul'Gurub
						[509] = true,		--	Ruins of Ahn'Qiraj
						[409] = true,		--!	Molten Core
						[249] = true,		--!	Onyxia's Lair			--	seem to be the same with the Wrath copy
						[469] = true,		--!	Blackwing Lair
						[531] = true,		--	Temple of Ahn'Qiraj
						[533] = true,		--	Naxxramas??
					--	Burning Crusade
						[564] = true,		--	Black Temple
						[565] = true,		--	Gruul's Lair
						[534] = true,		--	Hyjal Summit
						[532] = true,		--	Karazhan
						[544] = true,		--	Magtheridon's Lair
						[548] = true,		--	Serpentshrine Cavern
						[580] = true,		--	Sunwell Plateau
						[550] = true,		--	Tempest Keep
					--	Wrath
						[631] = true,		--	Icecrown Citadel
						[533] = true,		--	Naxxramas
						[249] = true,		--	Onyxia's Lair
						[616] = true,		--	The Eye of Eternity
						[615] = true,		--	The Obsidian Sanctum
						[724] = true,		--	The Ruby Sanctum
						[649] = true,		--	Trial of the Crusader
						[603] = true,		--	Ulduar
						[624] = true,		--	Vault of Archavon
					--	Cataclysm
						[757] = true,		--	Baradin Hold
						[669] = true,		--	Blackwing Descent
						[967] = true,		--	Dragon Soul
						[720] = true,		--	Firelands
						[671] = true,		--	The Bastion of Twilight
						[754] = true,		--	Throne of the Four Winds
					--	Pandaria
						[1009] = true,		--	Heart of Fear
						[1008] = true,		--	Mogu'shan Vaults
						[1136] = true,		--	Siege of Orgrimmar
						[996] = true,		--	Terrace of Endless Spring
						[1098] = true,		--	Throne of Thunder
					--	Warlords
						[1228] = true,		--	Highmaul
						[1205] = true,		--	Blackrock Foundry
						[1448] = true,		--	Hellfire Citadel
					--	Legion
						[1520] = true,		--	The Emerald Nightmare
						[1648] = true,		--	Trial of Valor
						[1530] = true,		--	The Nighthold
						[1676] = true,		--	Tomb of Sargeras
						[1712] = true,		--	Antorus, the Burning Throne
					--	BFA
						[1861] = true,		--	Uldir
						[2070] = true,		--	Battle of Dazar'alor
						[2096] = true,		--	Crucible of Storms
						[2164] = true,		--	The Eternal Palace
						[2217] = true,		--	Ny’alotha
			};
		-->
		-->		--	EventHandler
			local function __inst_meta_OnEvent(self, event, ...)
				return self[event](...);
			end
			function __inst_meta:FireEvent(event, ...)
				local func = self[event];
				if func then
					return func(...);
				end
			end
			function __inst_meta:RegEvent(event)
				self[event] = self[event] or _noop_;
				self:RegisterEvent(event);
				self:SetScript('OnEvent', __inst_meta_OnEvent);
			end
			function __inst_meta:UnregEvent(event)
				self:UnregisterEvent(event);
			end
		-->
		Mixin(__inst_meta, {
			ADDON_PREFIX = "ILTADD",
			ADDON_MSG_PUSH_ZONEUID = "_push_",
			ADDON_MSG_QUERY_ZONEUID = "_q_uid",
		});
		-->		Private method
			__inst_meta.__callbacks = {  };
			__inst_meta.__revokes = {  };
			function __inst_meta.SaveZoneUID(serverID, instanceID, zoneUID)			--	save zoneUID & serverID, make it muted and ignore CHAT_MSG_ADDON
				__inst_meta._var_serverID = serverID;
				__inst_meta._var_zoneUID = zoneUID;
				if __inst_meta._var_received_zoneUID ~= nil then
					for _, revoke in next, __inst_meta.__revokes do
						safe_call(revoke, true, __inst_meta._var_instanceTime, __inst_meta._var_instanceType, __inst_meta._var_maxPlayers, serverID, instanceID, __inst_meta._var_received_zoneUID);
					end
					__inst_meta._var_received_zoneUID = nil;
				end
				for _, call in next, __inst_meta.__callbacks do
					safe_call(call, false, __inst_meta._var_instanceTime, __inst_meta._var_instanceType, __inst_meta._var_maxPlayers, serverID, instanceID, zoneUID);
				end
				if IsInRaid(LE_PARTY_CATEGORY_HOME) then
					local msg = __inst_meta.ADDON_MSG_PUSH_ZONEUID .. serverID .. "#" .. instanceID .. "#" .. zoneUID;
					for index = 1, GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) do
						local unit = 'raid' .. index;
						if UnitIsVisible(unit) then
							SendAddonMessage(__inst_meta.ADDON_PREFIX, msg, "WHISPER", UnitName(unit));
						end
					end
				elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
					local msg = __inst_meta.ADDON_MSG_PUSH_ZONEUID .. serverID .. "#" .. instanceID .. "#" .. zoneUID;
					for index = 1, GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) do
						local unit = 'party' .. index;
						if UnitIsVisible(unit) then
							SendAddonMessage(__inst_meta.ADDON_PREFIX, msg, "WHISPER", UnitName(unit));
						end
					end
				end
			end
			function __inst_meta.ON_GUID_CAPTURED(GUID)
				local _type, _, serverID, instanceID, zoneUID, creatureType, spawnID = strsplit("-", GUID);
				instanceID = tonumber(instanceID);
				_log_('instanceID', instanceID, __inst_meta._var_instanceID);
				if instanceID == __inst_meta._var_instanceID then
					__inst_meta.StopCapturing();
					__inst_meta.SaveZoneUID(tonumber(serverID), instanceID, tonumber(zoneUID));
				end
			end
			function __inst_meta.UNIT_TARGET(unit)
				local GUID = UnitGUID(unit .. 'target');
				if GUID and strsub(GUID, 1, 8) == "Creature" then
					__inst_meta.ON_GUID_CAPTURED(GUID);
					_log_('T', GUID);
				end
			end
			function __inst_meta.UPDATE_MOUSEOVER_UNIT()
				local GUID = UnitGUID('mouseover');
				if GUID and strsub(GUID, 1, 8) == "Creature" then
					__inst_meta.ON_GUID_CAPTURED(GUID);
					_log_('M', GUID);
				end
			end
			function __inst_meta.NAME_PLATE_UNIT_ADDED(unit)
				local GUID = UnitGUID(unit);
				if GUID and strsub(GUID, 1, 8) == "Creature" then
					__inst_meta.ON_GUID_CAPTURED(GUID);
					_log_('N', GUID);
				end
			end
			function __inst_meta.COMBAT_LOG_EVENT_UNFILTERED()
				local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, _12, _13, _14, _15 = CombatLogGetCurrentEventInfo();
				if strsub(sourceGUID, 1, 8) == "Creature" then
					-- --	1	1594694500.953, "SPELL_AURA_APPLIED", false, "Creature-0-4956-1-338-4949-0000063A25", "未知目标", 2600, 0, "Player-4521-010827EA", "战氏", 1297, 0, 
					-- --	12	0, "酋长的祝福", 1, "BUFF",
					-- --	SPELL_AURA	15th ~= "BUFF"
					-- if strsub(destGUID, 1, 6) == "Player" and strsub(event, 1, 10) == "SPELL_AURA" and _15 == "BUFF" then		--	skip world buff		--	check this by instanceID now
					-- 	return;
					-- end
					__inst_meta.ON_GUID_CAPTURED(sourceGUID);
					_log_('S', sourceGUID);
				elseif strsub(destGUID, 1, 8) == "Creature" then
					__inst_meta.ON_GUID_CAPTURED(destGUID);
					_log_('D', destGUID);
				end
			end
			function __inst_meta.StartCapturing(instanceID, instanceType)
				__inst_meta._var_muted = false;
				__inst_meta:RegEvent("UNIT_TARGET");
				__inst_meta:RegEvent("UPDATE_MOUSEOVER_UNIT");
				__inst_meta:RegEvent("NAME_PLATE_UNIT_ADDED");
				__inst_meta:RegEvent("COMBAT_LOG_EVENT_UNFILTERED");
				if IsInRaid(LE_PARTY_CATEGORY_HOME) then
					local msg = __inst_meta.ADDON_MSG_QUERY_ZONEUID .. instanceID;
					for index = 1, GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) do
						local unit = 'raid' .. index;
						if UnitIsVisible(unit) then
							SendAddonMessage(__inst_meta.ADDON_PREFIX, msg, "WHISPER", UnitName(unit));
						end
					end
				elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
					local msg = __inst_meta.ADDON_MSG_QUERY_ZONEUID .. instanceID;
					for index = 1, GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) do
						local unit = 'party' .. index;
						if UnitIsVisible(unit) then
							SendAddonMessage(__inst_meta.ADDON_PREFIX, msg, "WHISPER", UnitName(unit));
						end
					end
				end
			end
			function __inst_meta.StopCapturing()
				__inst_meta._var_muted = true;
				__inst_meta:UnregEvent("UNIT_TARGET");
				__inst_meta:UnregEvent("UPDATE_MOUSEOVER_UNIT");
				__inst_meta:UnregEvent("NAME_PLATE_UNIT_ADDED");
				__inst_meta:UnregEvent("COMBAT_LOG_EVENT_UNFILTERED");
			end
			function __inst_meta.LOADING_SCREEN_DISABLED()
				local inInstance, instanceType = IsInInstance();
				local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, LfgDungeonID = GetInstanceInfo();
				_log_('L', inInstance, instanceType, name);
				__inst_meta._var_instanceTime = GetServerTime();
				__inst_meta._var_instanceType = instanceType;
				__inst_meta._var_maxPlayers = maxPlayers;
				__inst_meta._var_serverID = nil;
				__inst_meta._var_instanceID = instanceID;
				__inst_meta._var_zoneUID = nil;
				__inst_meta._var_received_serverID = nil;
				__inst_meta._var_received_zoneUID = nil;
				if inInstance then
					__inst_meta.StartCapturing(tonumber(instanceID), instanceType);
				else
					__inst_meta.StopCapturing();
				end
			end
			function __inst_meta.LOADING_SCREEN_ENABLED()
				__inst_meta.StopCapturing();
			end
		function __ns.RegInstanceIDCallback(call, revoke)
			tinsert(__inst_meta.__callbacks, call);
			tinsert(__inst_meta.__revokes, revoke);
		end
		__ns.prefixHandler[__inst_meta.ADDON_PREFIX] = function(prefix, msg, channel, sender)
			local control_code = strsub(msg, 1, ADDON_MSG_CONTROL_CODE_LEN);
			if control_code == __inst_meta.ADDON_MSG_PUSH_ZONEUID then
				if not __inst_meta._var_muted then
					local code = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 1, - 1);
					local serverID, instanceID, zoneUID = strsplit("#", code);
					serverID = tonumber(serverID);
					instanceID = tonumber(instanceID);
					zoneUID = tonumber(zoneUID);
					if instanceID == __inst_meta._var_instanceID and zoneUID then
						if __inst_meta._var_received_zoneUID then
							if __inst_meta._var_received_zoneUID ~= zoneUID then
								for _, revoke in next, __inst_meta.__revokes do
									safe_call(revoke, true, __inst_meta._var_instanceTime, __inst_meta._var_instanceType, __inst_meta._var_maxPlayers, serverID, instanceID, __inst_meta._var_received_zoneUID);
								end
								for _, call in next, __inst_meta.__callbacks do
									safe_call(call, true, __inst_meta._var_instanceTime, __inst_meta._var_instanceType, __inst_meta._var_maxPlayers, serverID, instanceID, zoneUID);
								end
								__inst_meta._var_received_serverID = serverID;
								__inst_meta._var_received_zoneUID = zoneUID;
							end
						else
							for _, call in next, __inst_meta.__callbacks do
								safe_call(call, true, __inst_meta._var_instanceTime, __inst_meta._var_instanceType, __inst_meta._var_maxPlayers, serverID, instanceID, zoneUID);
							end
							__inst_meta._var_received_serverID = serverID;
							__inst_meta._var_received_zoneUID = zoneUID;
						end
					end
				end
			elseif control_code == __inst_meta.ADDON_MSG_QUERY_ZONEUID then
				local instanceID = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 1, - 1);
				instanceID = tonumber(instanceID);
				if instanceID == __inst_meta._var_instanceID then
					local serverID = __inst_meta._var_serverID or __inst_meta._var_received_serverID;
					local zoneUID = __inst_meta._var_zoneUID or __inst_meta._var_received_zoneUID;
					if zoneUID then
						SendAddonMessage(prefix, __inst_meta.ADDON_MSG_PUSH_ZONEUID .. serverID .. "#" .. __inst_meta._var_instanceID .. "#" .. zoneUID, "WHISPER", sender);
					end
				end
			end
		end
		function __ns.initializeInstanceCapture()
			__inst_meta.LOADING_SCREEN_DISABLED();
			RegisterAddonMessagePrefix(__inst_meta.ADDON_PREFIX);
			__inst_meta:RegEvent("LOADING_SCREEN_ENABLED");
			__inst_meta:RegEvent("LOADING_SCREEN_DISABLED");
		end
	-->
	-->		RaidLock
		local __raid_meta = {
			ADDON_PREFIX = "RLTADD",
			ADDON_MSG_QUERY_RAIDLOCK = "_q_rlk",
			ADDON_MSG_REPLY_RAIDLOCK = "_r_rlk",
			L = {
				zhCN = {
					ONY = "奥妮克希亚的巢穴",
					MC = "熔火之心",
					BWL = "黑翼之巢",
					ZG = "祖尔格拉布",
					RAQ = "安其拉废墟",
					TAQ = "安其拉",
					NAXX = "纳克萨玛斯",
					DarkMoon = "暗月马戏团",
					["DarkMoon: Elwynn"] = "暗月马戏团 \124cff00afff艾尔文森林\124r",
					["DarkMoon: Mulgore"] = "暗月马戏团 \124cffff3f00莫高雷\124r",
					["Fishing Extravaganza"] = "荆棘谷钓鱼大赛",
					["Warsong Gulch"] = "战歌峡谷节日",
					["Arathi Basin"] = "阿拉希盆地节日",
					["Alterac Valley"] = "奥特兰克山谷节日",
					ala = "ala",
				},
				zhTW = {
					ONY = "奧妮克希亞的巢穴",
					MC = "熔火之心",
					BWL = "黑翼之巢",
					ZG = "祖爾格拉布",
					RAQ = "安其拉廢墟",
					TAQ = "安其拉",
					NAXX = "納克薩瑪斯",
					DarkMoon = "暗月馬戲團",
					["DarkMoon: Elwynn"] = "暗月馬戲團 \124cff00afff艾爾文森林\124r",
					["DarkMoon: Mulgore"] = "暗月馬戲團 \124cffff3f00莫高雷\124r",
					["Fishing Extravaganza"] = "荆棘谷釣魚大賽",
					["Warsong Gulch"] = "戰歌峽谷節慶",
					["Arathi Basin"] = "阿拉希盆地節慶",
					["Alterac Valley"] = "奧特蘭克山谷節慶",
					ala = "ala",
				},
				deDE = {
					ONY = "Onyxias Hort",
					MC = "Geschmolzener Kern",
					BWL = "Pechschwingenhort",
					ZG = "Zul'Gurub",
					RAQ = "Ruinen von Ahn'Qiraj",
					TAQ = "Ahn'Qiraj",
					NAXX = "Naxxramas",
					DarkMoon = "DarkMoon",
					["DarkMoon: Elwynn"] = "DarkMoon \124cff00afffElwynn\124r",
					["DarkMoon: Mulgore"] = "DarkMoon \124cffff3f00Mulgore\124r",
					["Fishing Extravaganza"] = "Fishing Extravaganza",
					["Warsong Gulch"] = "Warsong Gulch Holidays",
					["Arathi Basin"] = "Arathi Basin Holidays",
					["Alterac Valley"] = "Alterac Valley Holidays",
					ala = "ala",
				},
				enUS = {
					ONY = "Onyxia's Lair",
					MC = "Molten Core",
					BWL = "Blackwing Lair",
					ZG = "Zul'Gurub",
					RAQ = "Ruins of Ahn'Qiraj",
					TAQ = "Ahn'Qiraj",
					NAXX = "Naxxramas",
					DarkMoon = "DarkMoon",
					["DarkMoon: Elwynn"] = "DarkMoon \124cff00afffElwynn\124r",
					["DarkMoon: Mulgore"] = "DarkMoon \124cffff3f00Mulgore\124r",
					["Fishing Extravaganza"] = "Fishing Extravaganza",
					["Warsong Gulch"] = "Warsong Gulch Holidays",
					["Arathi Basin"] = "Arathi Basin Holidays",
					["Alterac Valley"] = "Alterac Valley Holidays",
					ala = "ala",
				},
				esES = {
					ONY = "Guarida de Onyxia",
					MC = "Núcleo de Magma",
					BWL = "Guarida Alanegra",
					ZG = "Zul'Gurub",
					RAQ = "Ruinas de Ahn'Qiraj",
					TAQ = "Ahn'Qiraj",
					NAXX = "Naxxramas",
					DarkMoon = "DarkMoon",
					["DarkMoon: Elwynn"] = "DarkMoon \124cff00afffElwynn\124r",
					["DarkMoon: Mulgore"] = "DarkMoon \124cffff3f00Mulgore\124r",
					["Fishing Extravaganza"] = "Fishing Extravaganza",
					["Warsong Gulch"] = "Warsong Gulch Holidays",
					["Arathi Basin"] = "Arathi Basin Holidays",
					["Alterac Valley"] = "Alterac Valley Holidays",
					ala = "ala",
				},
				frFR = {
					ONY = "Repaire d'Onyxia",
					MC = "Cœur du Magma",
					BWL = "Repaire de l'Aile noire",
					ZG = "Zul'Gurub",
					RAQ = "Ruines d'Ahn'Qiraj",
					TAQ = "Ahn'Qiraj",
					NAXX = "Naxxramas",
					DarkMoon = "DarkMoon",
					["DarkMoon: Elwynn"] = "DarkMoon \124cff00afffElwynn\124r",
					["DarkMoon: Mulgore"] = "DarkMoon \124cffff3f00Mulgore\124r",
					["Fishing Extravaganza"] = "Fishing Extravaganza",
					["Warsong Gulch"] = "Warsong Gulch Holidays",
					["Arathi Basin"] = "Arathi Basin Holidays",
					["Alterac Valley"] = "Alterac Valley Holidays",
					ala = "ala",
				},
				ptBR = {
					ONY = "Covil da Onyxia",
					MC = "Núcleo Derretido",
					BWL = "Covil Asa Negra",
					ZG = "Zul'Gurub",
					RAQ = "Ruínas de Ahn'Qiraj",
					TAQ = "Ahn'Qiraj",
					NAXX = "Naxxramas",
					DarkMoon = "DarkMoon",
					["DarkMoon: Elwynn"] = "DarkMoon \124cff00afffElwynn\124r",
					["DarkMoon: Mulgore"] = "DarkMoon \124cffff3f00Mulgore\124r",
					["Fishing Extravaganza"] = "Fishing Extravaganza",
					["Warsong Gulch"] = "Warsong Gulch Holidays",
					["Arathi Basin"] = "Arathi Basin Holidays",
					["Alterac Valley"] = "Alterac Valley Holidays",
					ala = "ala",
				},
				ruRU = {
					ONY = "Логово Ониксии",
					MC = "Огненные Недра",
					BWL = "Логово Крыла Тьмы",
					ZG = "Зул'Гуруб",
					RAQ = "Руины Ан'Киража",
					TAQ = "Ан'Кираж",
					NAXX = "Наксрамас",
					DarkMoon = "DarkMoon",
					["DarkMoon: Elwynn"] = "DarkMoon \124cff00afffElwynn\124r",
					["DarkMoon: Mulgore"] = "DarkMoon \124cffff3f00Mulgore\124r",
					["Fishing Extravaganza"] = "Fishing Extravaganza",
					["Warsong Gulch"] = "Warsong Gulch Holidays",
					["Arathi Basin"] = "Arathi Basin Holidays",
					["Alterac Valley"] = "Alterac Valley Holidays",
					ala = "ala",
				},
				koKR = {
					ONY = "오닉시아의 둥지",
					MC = "화산 심장부",
					BWL = "검은날개 둥지",
					ZG = "줄구룹",
					RAQ = "안퀴라즈 폐허",
					TAQ = "안퀴라즈",
					NAXX = "낙스라마스",
					DarkMoon = "다크문",
					["DarkMoon: Elwynn"] = "다크문 \124cff00afff엘윈숲\124r",
					["DarkMoon: Mulgore"] = "다크문 \124cffff3f00멀고어\124r",
					["Fishing Extravaganza"] = "가시덤불 골짜기 낚시대회",
					["Warsong Gulch"] = "전쟁노래 협곡 사절단",
					["Arathi Basin"] = "아라시 분지 사절단",
					["Alterac Valley"] = "알터렉 계곡 사절단",
					ala = "ala",
				},
				--itIT
				['*'] = {
					ONY = "Onyxia's Lair",
					MC = "Molten Core",
					BWL = "Blackwing Lair",
					ZG = "Zul'Gurub",
					RAQ = "Ruins of Ahn'Qiraj",
					TAQ = "Ahn'Qiraj",
					NAXX = "Naxxramas",
					DarkMoon = "DarkMoon",
					["DarkMoon: Elwynn"] = "DarkMoon \124cff00afffElwynn\124r",
					["DarkMoon: Mulgore"] = "DarkMoon \124cffff3f00Mulgore\124r",
					["Fishing Extravaganza"] = "Fishing Extravaganza",
					["Warsong Gulch"] = "Warsong Gulch Holidays",
					["Arathi Basin"] = "Arathi Basin Holidays",
					["Alterac Valley"] = "Alterac Valley Holidays",
					ala = "ala",
				},
			},
			hash = {  };
		};
		__raid_meta.esMX = __raid_meta.esES;
		for LOC, LIST in next, __raid_meta.L do
			for key, val in next, LIST do
				__raid_meta.hash[val] = key;
			end
		end
		__ns.__raid_meta = __raid_meta;
		function __ns.GetRaidLockedData(detailed)
			local data = {  };
			for instanceIndex = 1, GetNumSavedInstances() do
				local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(instanceIndex);
				if locked and isRaid then
					local inst = __raid_meta.hash[name];
					if inst then
						local msg = inst .. ":" .. encounterProgress .. ":" .. numEncounters;
						if detailed then
							for encounterIndex = 1, numEncounters do
								local bossName, fileDataID, isKilled, unknown4 = GetSavedInstanceEncounterInfo(instanceIndex, encounterIndex);
								msg = msg .. "#" .. isKilled and "1" or "0";
							end
						end
						-- local t = now + reset;
						-- local var = VAR[inst];
						-- var[1] = id;
						-- var[2] = t;
						-- var[3] = numEncounters;
						-- var[4] = encounterProgress;
						-- earliest = min(earliest, t);
						-- for encounterIndex = 1, numEncounters do
						-- 	local bossName, fileDataID, isKilled, unknown4 = GetSavedInstanceEncounterInfo(instanceIndex, encounterIndex);
						-- 	var[4 + encounterIndex * 2 - 1] = bossName;
						-- 	var[4 + encounterIndex * 2] = isKilled;
						-- end
					else
					end
				end
			end
		end
	-->
-->		Core
	function __ns.CHAT_MSG_ADDON(prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID)
		local handler = __ns.prefixHandler[prefix];
		if handler then
			handler(prefix, msg, channel, sender);
		end
	end
	function __ns.initializeAddonAlternate()
		_EventHandler:RegEvent("CHAT_MSG_ADDON");
		__ns.initializeTalentEmu();
		__ns.initializeInstanceCapture();
	end
-->
-->		Initialize
	function __ns.initialize()
		_EventHandler:UnregEvent("LOADING_SCREEN_DISABLED");
		__ns.initializeAddonAlternate();
	end
	__ns.LOADING_SCREEN_DISABLED = __ns.initialize;
	_EventHandler:RegEvent("LOADING_SCREEN_DISABLED");
-->

