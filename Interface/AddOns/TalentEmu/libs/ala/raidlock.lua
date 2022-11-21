--[[--
	ALA@163UI
--]]--

local __version = 221012.0;

local _G = _G;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __ala_meta__ = _G.__ala_meta__;
local __raidlib = __ala_meta__.__raidlib;
if __raidlib ~= nil and __raidlib.__minor >= __version then
	return;
end
if __raidlib ~= nil then
	if __raidlib.Halt ~= nil then
		__raidlib:Halt();
	end
else
	__raidlib = {  };
end
__raidlib.__minor = __version;
__ala_meta__.__raidlib = __raidlib;


-->			upvalue
local GetNumSavedInstances, GetSavedInstanceInfo, GetSavedInstanceEncounterInfo = GetNumSavedInstances, GetSavedInstanceInfo, GetSavedInstanceEncounterInfo;

local __raid_meta = {
	L = {  },
	hash = {  };
};
local InstList = {
	["Onyxia's Lair"] = 249,
	["Molten Core"] = 409,
	["Blackwing Lair"] = 469,
	["Zul'Gurub"] = 309,
	["Ruins of Ahn'Qiraj"] = 509,
	["Temple of Ahn'Qiraj"] = 531,
	-- ["Naxxramas"] = 533,
	--
	["Karazhan"] = 532,
	["Magtheridon's Lair"] = 544,
	["Gruul's Lair"] = 565,
	["Serpentshrine Cavern"] = 548,
	["Tempest Keep"] = 550,
	["Hyjal Summit"] = 534,
	["Black Temple"] = 564,
	["Zul'Aman"] = 568,
	["Sunwell Plateau"] = 580,
	--
	["Vault of Archavon"] = 624,
	["Naxxramas"] = 533,
	["The Eye of Eternity"] = 616,
	["The Obsidian Sanctum"] = 615,
	["Ulduar"] = 603,
	["Trial of the Crusader"] = 649,
	-- ["Onyxia's Lair"] = 249,
	["Icecrown Citadel"] = 631,
	["The Ruby Sanctum"] = 724,
	--
	["Baradin Hold"] = 757,
	["Blackwing Descent"] = 669,
	["Dragon Soul"] = 967,
	["Firelands"] = 720,
	["The Bastion of Twilight"] = 671,
	["Throne of the Four Winds"] = 754,
};
__raid_meta.esMX = __raid_meta.esES;
for key, id in next, InstList do
	__raid_meta.hash[key] = key;
	local val = GetRealZoneText(id) or key;
	__raid_meta.L[key] = val;
	__raid_meta.hash[val] = key;
end
__raidlib.__raid_meta = __raid_meta;
function __raidlib.GetRaidLockedData(data, detailed)
	data = data or {  };
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
function __raidlib:Halt()
end
