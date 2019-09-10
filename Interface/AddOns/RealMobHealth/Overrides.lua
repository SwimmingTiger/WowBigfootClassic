--[[	RealMobHealth Overrides Module
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
local assert=assert;
local string_find=string.find;

----------------------------------
--[[	Internal Functions	]]
----------------------------------
local HealthOverrides={};

local function AddHealthOverride(creaturekey,maxhealth)
	AddOn_ArgumentCheck("AddHealthOverride",2,{"string","number"},creaturekey,maxhealth);
	assert(string_find(creaturekey,"^%d+%-?%d*$"),"invalid CreatureKey");
	assert(maxhealth>0,"MaxHealth must be greater than zero");

	HealthOverrides[creaturekey]=maxhealth;
	AddOn_FireAddOnEvent("OVERRIDE_ADDED",creaturekey,maxhealth);
	AddOn_FireAddOnEvent("HEALTH_UPDATE",creaturekey,maxhealth);
end

local function HasHealthOverride(creaturekey) return HealthOverrides[creaturekey] and true or false; end

AddOn.HealthOverrides=HealthOverrides;
AddOn.AddHealthOverride=AddHealthOverride;
AddOn.HasHealthOverride=HasHealthOverride;

------------------------------------------
--[[	External API Registration	]]
------------------------------------------
AddOn.API.AddHealthOverride=AddHealthOverride;
AddOn.API.HasHealthOverride=HasHealthOverride;
