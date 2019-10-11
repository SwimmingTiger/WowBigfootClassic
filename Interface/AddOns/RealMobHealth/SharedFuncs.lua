--[[	RealMobHealth Shared Functions
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
local ipairs=ipairs;
local pairs=pairs;
local select=select;
local string_format=string.format;
local string_match=string.match;
local table_concat=table.concat;
local tonumber=tonumber;
local tostring=tostring;
local type=type;
local UnitClassification=UnitClassification;
local UnitGUID=UnitGUID;
local UnitLevel=UnitLevel;

----------------------------------
--[[	Lua Extension Functions	]]
----------------------------------
function AddOn.table_ifind(tbl,val) for k,v in ipairs(tbl) do if v==val then return k; end end end--	Find value in sequential table
function AddOn.table_find(tbl,val) for k,v in pairs(tbl) do if v==val then return k; end end end--	Find value in associative table

----------------------------------
--[[	Argument Check Function	]]
----------------------------------
--	Note:	Since this is computationally expensive to do everywhere, only some functions exposed to the external API should use this
function AddOn.ArgumentCheck(funcname,level,checktype,...)
	level=(level or 1)+1; if level<=1 then level=0; end--	Prevent error level from pointing to this function (Zero adds no position; Stack trace will still point here)
	if type(checktype)~="table" then--	Single argument check
		local argtype=type((...));
		if argtype~=checktype then return error(string_format("bad argument #%d to '%s()' (%s expected got %s)",1,funcname,checktype,argtype),level); end--	Tail call
	else--	Multiple argument check
		local arglen=select("#",...);
		for index,checktype in ipairs(checktype) do--	Iterate through arguments
			local argtype=index>arglen and "no value" or type((select(index,...)));--	Change to 'nil' to 'no value' if we passed the number of arguments
			if type(checktype)~="table" then--	Single type check
				if argtype~=checktype then return error(string_format("bad argument #%d to '%s()' (%s expected got %s)",index,funcname,checktype,argtype),level); end--	Tail call
			else--	Multiple type check
--				Form wanted string
				local wanted;
				if checklen==1 then wanted=checktype[1];--	Single entry
				elseif checklen==2 then wanted=table_concat(checktype," or ");--	Two entries
				else wanted=string_format("%s, or %s",table_concat(checktype,", ",1,checklen-1),checktype[checklen]); end--	More entries

--				Iterate and try to match any in list
				local pass=false;
				for _,checktype in ipairs(checktype) do if argtype==checktype then pass=true; break; end end

				if not pass then return error(string_format("bad argument #%d to '%s()' (%s expected got %s)",index,funcname,checktype,argtype),level); end--	Tail call
			end
		end
	end
--	If we made it here, we win the game, no errors
end

----------------------------------
--[[	Creature Functions	]]
----------------------------------
--	GUID Format
--	[Unit type]-0-[server ID]-[instance ID]-[zone UID]-[ID]-[spawn UID]
--	Unit Types:	Creature, GameObject, Pet, Vehicle, Vignette
--	Player:	Player-[server ID]-[player UID]

local MobUnitTypes={--	Lookup of mob unit types from GUID
	Creature=true;--	Mob/NPC
	Vignette=true;--	Rares
}

local function IsMobGUID(guid)--	Is GUID from a mob?
	if not guid then return false; end
	local utype=string_match(guid,"^(.-)%-0%-%d+%-%d+%-%d+%-%d+%-%x+$");
	return (utype and MobUnitTypes[utype]) or false;
end

local function IsUnitMob(unit) return IsMobGUID(UnitGUID(unit)); end

local function GetCreatureIDFromGUID(guid)--	Extracts CreatureID from GUID (Mobs only)
	if not guid then return; end--	Needs GUID
	local utype,creatureid=string_match(guid,"^(.-)%-0%-%d+%-%d+%-%d+%-(%d+)%-%x+$");
	return (utype and MobUnitTypes[utype]) and (creatureid and tonumber(creatureid));--	Return CreatureID if mob
end

local function GetCreatureIDFromKey(creaturekey)--	Extracts CreatureID from CreatureKey
	local creatureid=string_match(creaturekey,"^%d+");
	return creatureid and tonumber(creatureid);
end

local function GetUnitCreatureID(unit) return GetCreatureIDFromGUID(UnitGUID(unit)); end

local function GetUnitCreatureKey(unit)--	Generates CreatureKey from CreatureID (from GUID) and level
	local creatureid=GetUnitCreatureID(unit);
	if not creatureid then return; end--	Unit not mob

	if UnitClassification(unit)=="worldboss" then return tostring(creatureid);--	World Bosses have no level, return as raw CreatureID
	else
		local level=UnitLevel(unit);--	UnitLevel() returns -1 for units with hidden levels (Skull/??)
		if level and level>0 then return string_format("%d-%d",creatureid,level); end
	end
end

AddOn.IsMobGUID=IsMobGUID;
AddOn.IsUnitMob=IsUnitMob;
AddOn.GetCreatureIDFromGUID=GetCreatureIDFromGUID;
AddOn.GetCreatureIDFromKey=GetCreatureIDFromKey;
AddOn.GetUnitCreatureID=GetUnitCreatureID;
AddOn.GetUnitCreatureKey=GetUnitCreatureKey;

------------------------------------------
--[[	External API Registration	]]
------------------------------------------
AddOn.API.IsMobGUID=IsMobGUID;
AddOn.API.IsUnitMob=IsUnitMob;
AddOn.API.GetCreatureIDFromGUID=GetCreatureIDFromGUID;
AddOn.API.GetCreatureIDFromKey=GetCreatureIDFromKey;
AddOn.API.GetUnitCreatureID=GetUnitCreatureID;
AddOn.API.GetUnitCreatureKey=GetUnitCreatureKey;
