--[[--
	ALA@163UI
--]]--
do return end

local __version = 5;

local _G = _G;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __ala_meta__ = _G.__ala_meta__;
local __instlib = __ala_meta__.__instlib
if __instlib ~= nil and __instlib.__minor >= __version then
	return;
end
local __instlib = __instlib or CreateFrame('FRAME');
__instlib.__minor = __version;
__ala_meta__.__instlib = __instlib;


-->			upvalue
local setmetatable, tinsert, next = setmetatable, tinsert, next;
local type, tonumber = type, tonumber;
local strsplit, strsub = strsplit, strsub;
local _ = nil;
local RegisterAddonMessagePrefix = C_ChatInfo ~= nil and C_ChatInfo.RegisterAddonMessagePrefix or RegisterAddonMessagePrefix;
local IsAddonMessagePrefixRegistered = C_ChatInfo ~= nil and C_ChatInfo.IsAddonMessagePrefixRegistered or IsAddonMessagePrefixRegistered;
local GetRegisteredAddonMessagePrefixes = C_ChatInfo ~= nil and C_ChatInfo.GetRegisteredAddonMessagePrefixes or GetRegisteredAddonMessagePrefixes;
local SendAddonMessage = C_ChatInfo ~= nil and C_ChatInfo.SendAddonMessage or SendAddonMessage;
local IsInRaid, IsInGroup, GetNumGroupMembers = IsInRaid, IsInGroup, GetNumGroupMembers;
local UnitName, UnitIsVisible, UnitGUID = UnitName, UnitIsVisible, UnitGUID;
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo;
local IsInInstance, GetInstanceInfo = IsInInstance, GetInstanceInfo;
local GetServerTime = GetServerTime;

local function _log_(...)
	--	tinsert(logfile, { date('\124cff00ff00%H:%M:%S\124r'), ... });
end
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

--[[
	测试结果	60classic, 1.13.6
		32次		+5pary次数、不计算20/40raid次数，影响5party和2raid
		5次			+5party次数+20raid次数、不计算40raid次数，影响5party、20raid
		5pary		受每日32次限制且计入32次内、受每小时5次限制
		40raid		不受任何次数限制
		20raid		受每日32次限制但是不计入32次内、受每小时5次限制【5pary计入5次、40raid待确认】
--]]

--		ContinentID	@//DB//AreaTable		--	https://wow.gamepedia.com/InstanceID/Complete_list
__instlib.InstanceIDHash = {
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

local ADDON_MSG_CONTROL_CODE_LEN = 6;
__instlib.ADDON_PREFIX = "ILTADD";
__instlib.ADDON_MSG_PUSH_ZONEUID = "_push_";
__instlib.ADDON_MSG_QUERY_ZONEUID = "_q_uid";

__instlib.__callbacks = {  };
__instlib.__revokes = {  };
function __instlib.RegInstanceIDCallback(call, revoke)
	tinsert(__instlib.__callbacks, call);
	tinsert(__instlib.__revokes, revoke);
end

function __instlib.SaveZoneUID(serverID, instanceID, zoneUID)			--	save zoneUID & serverID, make it muted and ignore CHAT_MSG_ADDON
	__instlib._var_serverID = serverID;
	__instlib._var_zoneUID = zoneUID;
	if __instlib._var_received_zoneUID ~= nil then
		for _, revoke in next, __instlib.__revokes do
			safe_call(revoke, true, __instlib._var_instanceTime, __instlib._var_instanceType, __instlib._var_maxPlayers, serverID, instanceID, __instlib._var_received_zoneUID);
		end
		__instlib._var_received_zoneUID = nil;
	end
	for _, call in next, __instlib.__callbacks do
		safe_call(call, false, __instlib._var_instanceTime, __instlib._var_instanceType, __instlib._var_maxPlayers, serverID, instanceID, zoneUID);
	end
	if IsInRaid(LE_PARTY_CATEGORY_HOME) then
		local msg = __instlib.ADDON_MSG_PUSH_ZONEUID .. serverID .. "#" .. instanceID .. "#" .. zoneUID;
		for index = 1, GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) do
			local unit = 'raid' .. index;
			if UnitIsVisible(unit) then
				SendAddonMessage(__instlib.ADDON_PREFIX, msg, "WHISPER", UnitName(unit));
			end
		end
	elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
		local msg = __instlib.ADDON_MSG_PUSH_ZONEUID .. serverID .. "#" .. instanceID .. "#" .. zoneUID;
		for index = 1, GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) do
			local unit = 'party' .. index;
			if UnitIsVisible(unit) then
				SendAddonMessage(__instlib.ADDON_PREFIX, msg, "WHISPER", UnitName(unit));
			end
		end
	end
end
function __instlib.ON_GUID_CAPTURED(GUID)
	local _type, _, serverID, instanceID, zoneUID, creatureType, spawnID = strsplit("-", GUID);
	instanceID = tonumber(instanceID);
	_log_('instanceID', instanceID, __instlib._var_instanceID);
	if instanceID == __instlib._var_instanceID then
		__instlib.StopCapturing();
		__instlib.SaveZoneUID(tonumber(serverID), instanceID, tonumber(zoneUID));
	end
end
function __instlib.UNIT_TARGET(unit)
	local GUID = UnitGUID(unit .. 'target');
	if GUID and strsub(GUID, 1, 8) == "Creature" then
		__instlib.ON_GUID_CAPTURED(GUID);
		_log_('T', GUID);
	end
end
function __instlib.UPDATE_MOUSEOVER_UNIT()
	local GUID = UnitGUID('mouseover');
	if GUID and strsub(GUID, 1, 8) == "Creature" then
		__instlib.ON_GUID_CAPTURED(GUID);
		_log_('M', GUID);
	end
end
function __instlib.NAME_PLATE_UNIT_ADDED(unit)
	local GUID = UnitGUID(unit);
	if GUID and strsub(GUID, 1, 8) == "Creature" then
		__instlib.ON_GUID_CAPTURED(GUID);
		_log_('N', GUID);
	end
end
function __instlib.COMBAT_LOG_EVENT_UNFILTERED()
	local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, _12, _13, _14, _15 = CombatLogGetCurrentEventInfo();
	if strsub(sourceGUID, 1, 8) == "Creature" then
		-- --	1	1594694500.953, "SPELL_AURA_APPLIED", false, "Creature-0-4956-1-338-4949-0000063A25", "未知目标", 2600, 0, "Player-4521-010827EA", "战氏", 1297, 0, 
		-- --	12	0, "酋长的祝福", 1, "BUFF",
		-- --	SPELL_AURA	15th ~= "BUFF"
		-- if strsub(destGUID, 1, 6) == "Player" and strsub(event, 1, 10) == "SPELL_AURA" and _15 == "BUFF" then		--	skip world buff		--	check this by instanceID now
		-- 	return;
		-- end
		__instlib.ON_GUID_CAPTURED(sourceGUID);
		_log_('S', sourceGUID);
	elseif strsub(destGUID, 1, 8) == "Creature" then
		__instlib.ON_GUID_CAPTURED(destGUID);
		_log_('D', destGUID);
	end
end
function __instlib.StartCapturing(instanceID, instanceType)
	if UnitInBattleground('player') ~= nil then
		return;
	end
	__instlib._var_muted = false;
	__instlib:RegisterEvent("UNIT_TARGET");
	__instlib:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	__instlib:RegisterEvent("NAME_PLATE_UNIT_ADDED");
	__instlib:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	if IsInRaid(LE_PARTY_CATEGORY_HOME) then
		local msg = __instlib.ADDON_MSG_QUERY_ZONEUID .. instanceID;
		for index = 1, GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) do
			local unit = 'raid' .. index;
			if UnitIsVisible(unit) then
				SendAddonMessage(__instlib.ADDON_PREFIX, msg, "WHISPER", UnitName(unit));
			end
		end
	elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
		local msg = __instlib.ADDON_MSG_QUERY_ZONEUID .. instanceID;
		for index = 1, GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) do
			local unit = 'party' .. index;
			if UnitIsVisible(unit) then
				SendAddonMessage(__instlib.ADDON_PREFIX, msg, "WHISPER", UnitName(unit));
			end
		end
	end
end
function __instlib.StopCapturing()
	__instlib._var_muted = true;
	__instlib:UnregisterEvent("UNIT_TARGET");
	__instlib:UnregisterEvent("UPDATE_MOUSEOVER_UNIT");
	__instlib:UnregisterEvent("NAME_PLATE_UNIT_ADDED");
	__instlib:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
end
function __instlib.LOADING_SCREEN_DISABLED()
	local inInstance, instanceType = IsInInstance();
	local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, LfgDungeonID = GetInstanceInfo();
	_log_('L', inInstance, instanceType, name);
	__instlib._var_instanceTime = GetServerTime();
	__instlib._var_instanceType = instanceType;
	__instlib._var_maxPlayers = maxPlayers;
	__instlib._var_serverID = nil;
	__instlib._var_instanceID = instanceID;
	__instlib._var_zoneUID = nil;
	__instlib._var_received_serverID = nil;
	__instlib._var_received_zoneUID = nil;
	if inInstance then
		__instlib.StartCapturing(tonumber(instanceID), instanceType);
	else
		__instlib.StopCapturing();
	end
end
function __instlib.LOADING_SCREEN_ENABLED()
	__instlib.StopCapturing();
end
function __instlib.CHAT_MSG_ADDON(prefix, msg, channel, sender)
	local control_code = strsub(msg, 1, ADDON_MSG_CONTROL_CODE_LEN);
	if control_code == __instlib.ADDON_MSG_PUSH_ZONEUID then
		if not __instlib._var_muted then
			local code = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 1, - 1);
			local serverID, instanceID, zoneUID = strsplit("#", code);
			serverID = tonumber(serverID);
			instanceID = tonumber(instanceID);
			zoneUID = tonumber(zoneUID);
			if instanceID == __instlib._var_instanceID and zoneUID then
				if __instlib._var_received_zoneUID then
					if __instlib._var_received_zoneUID ~= zoneUID then
						for _, revoke in next, __instlib.__revokes do
							safe_call(revoke, true, __instlib._var_instanceTime, __instlib._var_instanceType, __instlib._var_maxPlayers, serverID, instanceID, __instlib._var_received_zoneUID);
						end
						for _, call in next, __instlib.__callbacks do
							safe_call(call, true, __instlib._var_instanceTime, __instlib._var_instanceType, __instlib._var_maxPlayers, serverID, instanceID, zoneUID);
						end
						__instlib._var_received_serverID = serverID;
						__instlib._var_received_zoneUID = zoneUID;
					end
				else
					for _, call in next, __instlib.__callbacks do
						safe_call(call, true, __instlib._var_instanceTime, __instlib._var_instanceType, __instlib._var_maxPlayers, serverID, instanceID, zoneUID);
					end
					__instlib._var_received_serverID = serverID;
					__instlib._var_received_zoneUID = zoneUID;
				end
			end
		end
	elseif control_code == __instlib.ADDON_MSG_QUERY_ZONEUID then
		local instanceID = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 1, - 1);
		instanceID = tonumber(instanceID);
		if instanceID == __instlib._var_instanceID then
			local serverID = __instlib._var_serverID or __instlib._var_received_serverID;
			local zoneUID = __instlib._var_zoneUID or __instlib._var_received_zoneUID;
			if zoneUID then
				SendAddonMessage(prefix, __instlib.ADDON_MSG_PUSH_ZONEUID .. serverID .. "#" .. __instlib._var_instanceID .. "#" .. zoneUID, "WHISPER", sender);
			end
		end
	end
end

local function OnEvent(self, event, ...)
	__instlib[event](...);
end
__instlib:RegisterEvent("LOADING_SCREEN_DISABLED");
__instlib:SetScript("OnEvent", function(self, event)
	__instlib:UnregisterEvent("LOADING_SCREEN_DISABLED");
	if RegisterAddonMessagePrefix(__instlib.ADDON_PREFIX) then
		__instlib:RegisterEvent("CHAT_MSG_ADDON");
		__instlib:RegisterEvent("LOADING_SCREEN_ENABLED");
		__instlib:RegisterEvent("LOADING_SCREEN_DISABLED");
		__instlib:SetScript("OnEvent", OnEvent);
	end
end);
