--[[	RealMobHealth Blacklist Module
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145	]]
------------------------------------------------------------------

--------------------------
--[[	Namespace	]]
--------------------------
local AddOn=select(2,...);
AddOn.API=AddOn.API or {};

----------------------------------
--[[	Local References	]]
----------------------------------
local AddOn_ArgumentCheck=AddOn.ArgumentCheck;
local AddOn_FireAddOnEvent=AddOn.FireAddOnEvent;
local AddOn_GetCreatureIDFromGUID=AddOn.GetCreatureIDFromGUID;
local AddOn_GetCreatureIDFromKey=AddOn.GetCreatureIDFromKey;
local assert=assert;
local UnitGUID=UnitGUID;

----------------------------------
--[[	Internal Functions	]]
----------------------------------
local CreatureBlacklist={};

local function BlacklistCreatureID(creatureid)
	AddOn_ArgumentCheck("BlacklistCreatureID",2,"number",creatureid);

	CreatureBlacklist[creatureid]=true;
	AddOn_FireAddOnEvent("BLACKLIST_ADDED",creatureid);
	AddOn_FireAddOnEvent("HEALTH_UPDATE",nil,nil);
end

local function IsBlacklistedCreatureID(creatureid)
	AddOn_ArgumentCheck("IsBlacklistedCreatureID",2,"number",creatureid);
	return CreatureBlacklist[creatureid] or false;
end

local function IsBlacklistedCreatureKey(creaturekey)
	AddOn_ArgumentCheck("IsBlacklistedCreatureKey",2,"string",creaturekey);
	return IsBlacklistedCreatureID(assert(AddOn_GetCreatureIDFromKey(creaturekey),"invalid CreatureKey"));
end

local function IsBlacklistedGUID(guid)--	Returns true for nil and non-mob GUIDs
	local creatureid=AddOn_GetCreatureIDFromGUID(guid);
	if creatureid then return IsBlacklistedCreatureID(creatureid);
	else return true; end
end

local function IsBlacklistedUnit(unit) IsBlacklistedGUID(UnitGUID(unit)); end

AddOn.BlacklistCreatureID=BlacklistCreatureID;
AddOn.IsBlacklistedCreatureID=IsBlacklistedCreatureID;
AddOn.IsBlacklistedCreatureKey=IsBlacklistedCreatureKey;
AddOn.IsBlacklistedGUID=IsBlacklistedGUID;
AddOn.IsBlacklistedUnit=IsBlacklistedUnit;

------------------------------------------
--[[	External API Registration	]]
------------------------------------------
AddOn.API.BlacklistCreatureID=BlacklistCreatureID;
AddOn.API.IsBlacklistedCreatureID=IsBlacklistedCreatureID;
AddOn.API.IsBlacklistedCreatureKey=IsBlacklistedCreatureKey;
AddOn.API.IsBlacklistedGUID=IsBlacklistedGUID;
AddOn.API.IsBlacklistedUnit=IsBlacklistedUnit;
