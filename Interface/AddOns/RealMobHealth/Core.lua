--[[	RealMobHealth Core Module
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145	]]
------------------------------------------------------------------

--------------------------
--[[	Namespace	]]
--------------------------
local Name,AddOn=...;
AddOn.API=AddOn.API or {};
AddOn.Options=AddOn.Options or {};
_G[Name]=AddOn.API;--	API Global

--------------------------
--[[	Versioning	]]
--------------------------
AddOn.API.APIVersion=GetAddOnMetadata(Name,"X-APIVersion");
AddOn.API.APIVersionMajor,AddOn.API.APIVersionMinor=(function(major,minor) return tonumber(major),tonumber(minor); end)(AddOn.API.APIVersion:match("^(%d+)%.(%d+)"));

----------------------------------
--[[	Options Defaults	]]
----------------------------------
AddOn.Options.EnablePeerCache=false;

--------------------------
--[[	External Tables	]]
--------------------------
local CreatureOverrides=AddOn.CreatureOverrides or {};--	Blacklisted keys have zero health
AddOn.CreatureOverrides=CreatureOverrides;--	Support adding values after loading

--------------------------
--[[	Saved Variables	]]
--------------------------
local HealthCache={};--	CreatureKey-to-MaxHealth Save Data
local PeerCache={};--	Same as above, received from peers through the AddOn channel
RealMobHealth_CreatureHealthCache=HealthCache;
RealMobHealth_PeerHealthCache=PeerCache;

--------------------------
--[[	Local Variables	]]
--------------------------
local UnitCache={};--	Unit tracking data (by GUID)
local LastHealthQuery={};--	Per-mob query throttle
local EnablePeerCache=AddOn.Options.EnablePeerCache;--	This is referenced often, so it needs to be cached (updated in scripts section)

--	For filtering AddOn channel echos
local PlayerName,PlayerFullName;
local PlayerGUID=UnitGUID("player");

local DamageSyncThreshold=0.02--	Switch to speculative mode if damage gets this far out of sync (As percent)
local ResetDetectionStartDelay=1;--	How long from first damage event when reset detection starts

local HealthQueryThrottle=10;--	How long between sending broadcasts about the same mob
local PurgeTimerInterval=10;--	Time between unit purge checks
local DeathTimeout=300--	How long from death when CreatureKey can be acquired
local DamageTimeout=120--	How long to wait between CLEs
local TargetTimeout=60--	How long to keep CreatureKeys when no damage taken

local UnitHealthNormalizedMax=100;--	Used to blacklist AURA_UPDATEs that don't actually change the max health
local HealthDetectionAuras={--	List of auras that expose mob health
	[1462]=true;--	Beast Lore
};

----------------------------------
--[[	Local References	]]
----------------------------------
local AddOn_HealthOverrides=AddOn.HealthOverrides;

local AddOn_BroadcastMessage=AddOn.BroadcastMessage;
local AddOn_FireAddOnEvent=AddOn.FireAddOnEvent;
local AddOn_GetUnitCreatureKey=AddOn.GetUnitCreatureKey;
local AddOn_IsBlacklistedCreatureKey=AddOn.IsBlacklistedCreatureKey;
local AddOn_IsBlacklistedGUID=AddOn.IsBlacklistedGUID;
local AddOn_SendMessage=AddOn.SendMessage;
local CombatLogGetCurrentEventInfo=CombatLogGetCurrentEventInfo;--	No idea why Blizzard decided to waste CPU resources on making this function
local GetTime=GetTime;
local math_abs=math.abs;
local math_ceil=math.ceil;
local math_max=math.max;
local next=next;
local pairs=pairs;
local rawget=rawget;
local string_format=string.format;
local string_gsub=string.gsub;
local string_match=string.match;
local table_wipe=table.wipe;
local UnitGUID=UnitGUID;
local UnitHealth=UnitHealth;
local UnitHealthMax=UnitHealthMax;
local UnitIsDead=UnitIsDead;
local UnitName=UnitName;

----------------------------------
--[[	Internal Functions	]]
----------------------------------
local function GetHealthCacheCount() local sum=0; for _ in next,HealthCache do sum=sum+1; end return sum; end
local function GetPeerCacheCount() local sum=0; for _ in next,PeerCache do sum=sum+1; end return sum; end

local function QueryCreatureHealth(creaturekey)--	Sends health query to peers
--	Filter disabled, blacklist, and throttle
	if not EnablePeerCache or not creaturekey or AddOn_IsBlacklistedCreatureKey(creaturekey) or LastHealthQuery[creaturekey] then return; end

	AddOn_BroadcastMessage("RMH",string_format("%s:?",creaturekey));--	Send query
	LastHealthQuery[creaturekey]=GetTime();-- Log timestamp
end

--------------------------
--[[	Event Helpers	]]
--------------------------
local function StoreMaxHealth(creaturekey,maxhealth,overwrite)
	if creaturekey and maxhealth and maxhealth>0 then
		local storedhealth=rawget(HealthCache,creaturekey);--	Isolate from metatable defaults
		if maxhealth>(storedhealth or 0) or (overwrite and maxhealth~=storedhealth) then
			HealthCache[creaturekey]=maxhealth;--	Store health
			if rawget(PeerCache,creaturekey) then--	Doesn't make sense to delete something that isn't there (supports metatable too)
				PeerCache[creaturekey]=nil;--	Delete peer data
				AddOn_FireAddOnEvent("PEERCACHE_UPDATE",GetPeerCacheCount());
			end
			AddOn_FireAddOnEvent("HEALTHCACHE_UPDATE",GetHealthCacheCount());
			AddOn_FireAddOnEvent("HEALTH_UPDATE",creaturekey,maxhealth);--	Fire event
		end
		AddOn_BroadcastMessage("RMH",string_format("%s:%d",creaturekey,maxhealth));
	end
end

local function ProcessAuras(unit)
if not UnitIsUnit(unit,"target") then return; end
	local creaturekey=AddOn_GetUnitCreatureKey(unit);-- Can return nil for invalid units
	if not creaturekey or AddOn_IsBlacklistedCreatureKey(creaturekey) then return; end--	Don't process if invalid or blacklisted

	local i=1;
	repeat
		local _,_,_,_,_,_,_,_,_,spellid=UnitDebuff(unit,i,"PLAYER");
		if spellid and HealthDetectionAuras[spellid] then
			local maxhealth=UnitHealthMax(unit);
			if maxhealth~=UnitHealthNormalizedMax then
				StoreMaxHealth(creaturekey,maxhealth,true);
			end
			return;--	Done here
		end
		i=i+1;
	until not spellid
end

local function ProcessUnit(unit)--	Called when we're aware of a new/updated unit
	local guid=UnitGUID(unit);
	local data=guid and UnitCache[guid];
	if AddOn_IsBlacklistedGUID(guid) then--	Don't process if blacklisted (Also checks if mob GUID)
		if data then UnitCache[guid]=nil; end--	If we have data, get rid of it
		return;
	end

	ProcessAuras(unit);--	Run this too before we check to send a query

	local creaturekey=AddOn_GetUnitCreatureKey(unit);-- Can return nil for invalid units
	if creaturekey and not (AddOn_HealthOverrides[creaturekey] or HealthCache[creaturekey] or PeerCache[creaturekey]) then
		QueryCreatureHealth(creaturekey);--	Query if unknown
	end

	if UnitIsDead(unit) then--	Mob is dead, deal with UnitCache data and wipe it
		if data then
			StoreMaxHealth(creaturekey,data.Damage);--	Store damage tally
			UnitCache[guid]=nil;--	Done with this, wipe it
		end
	else--	Mob is alive, update UnitCache
		local now=GetTime();
		if not data then data={}; UnitCache[guid]=data; end--	Create table if it doesn't exist
		if data.Damage and now-(data.FirstEvent or 0)>ResetDetectionStartDelay and UnitHealth(unit)>=UnitHealthMax(unit) then
			data.FirstEvent,data.Damage=nil,nil;--	Health reset, clear damage
		end
		data.CreatureKey=creaturekey;--	Update CreatureKey
		data.LastSeen=now;--	Update Timestamp
	end
end

local function ProcessCLE(...)
	local _,event,_,sourceguid,_,_,_,destguid=...;
	local prefix,suffix=string_match(event,"^([^_]+)_(.-)$");

--	Convert SPELL_PERIODIC and SPELL_BUILDING into just SPELL (Previous line actually puts PERIODIC_ and BUILDING_ in suffix)
	if prefix=="SPELL" then suffix=string_gsub(string_gsub(suffix,"^PERIODIC_",""),"^BUILDING_",""); end

--	Convert these event aliases
	if event=="DAMAGE_SHIELD" or event=="DAMAGE_SPLIT" then prefix,suffix="SPELL","DAMAGE"; end

--	Capture relevant args
	local guid,damage,over;
	if event=="UNIT_DIED" or event=="UNIT_DESTROYED" or event=="UNIT_DISSIPATES" then
		_,_,_,_,_,_,_,guid=...;
		suffix,damage,over="DAMAGE",0,0;--	Unit dead, zero damage and flag overkill
	elseif suffix=="DAMAGE" or suffix=="HEAL" then
		if prefix=="SWING" then			_,_,_,_,_,_,_,guid,_,_,_,damage,over=...;
		elseif prefix=="ENVIRONMENTAL" then	_,_,_,_,_,_,_,guid,_,_,_,_,damage,over=...;
		elseif prefix=="RANGE" then		_,_,_,_,_,_,_,guid,_,_,_,_,_,_,damage,over=...;
		elseif prefix=="SPELL" then		_,_,_,_,_,_,_,guid,_,_,_,_,_,_,damage,over=...;
		end
	end

	local now=GetTime();
	if guid and (suffix=="DAMAGE" or suffix=="HEAL") and not AddOn_IsBlacklistedGUID(guid) then
--		Normalize damage and remove overkill/overheal (over=-1 if not overkill/overheal)
		damage=damage and (suffix=="HEAL" and -1 or 1)*(damage-math_max(over,0)) or 0;

		local data=UnitCache[guid];
		local total=math_max((data and data.Damage or 0)+damage,0);--	Add the damage (Deals with overheal by clamping at zero)
		if over>=0 and damage>=0 then--	If we overkilled, it's a death (damage<0 is overheal)
			local creaturekey=data and data.CreatureKey;
			StoreMaxHealth(creaturekey,total);--	Store damage tally
			if creaturekey then UnitCache[guid]=nil;--	Done with this, wipe it
			elseif data then data.IsDead=true; end--	Not enough info, just flag death
		else--	Unit still alive, store new damage value
			if not data then data={}; UnitCache[guid]=data; end--	Create table if it doesn't exist
			if not data.FirstEvent then data.FirstEvent=now; end--	Log first damage event (Helps prevent race conditions with mob reset detection)
			data.Damage=total;--	Update damage tally
		end
	end

--	Poke all LastSeen timestamps (Refreshes timestamps on all CLEs, not just damage/heal ones)
	local sourcedata,destdata=sourceguid and UnitCache[sourceguid],destguid and UnitCache[destguid];
	if sourcedata then sourcedata.LastSeen=now; end
	if destdata then destdata.LastSeen=now; end
end

--------------------------
--[[	Script Handlers	]]
--------------------------
--	Setup & SavedVar management
AddOn.RegisterGameEvent("ADDON_LOADED",function(event,name)
	if name==Name then
--		Sync SavedVars
		HealthCache=RealMobHealth_CreatureHealthCache;
		PeerCache=RealMobHealth_PeerHealthCache;

		AddOn_FireAddOnEvent("HEALTHCACHE_UPDATE",GetHealthCacheCount());
		AddOn_FireAddOnEvent("PEERCACHE_UPDATE",GetPeerCacheCount());

		AddOn.UnregisterGameEvent(event);--	Calling this in here defaults to currently running function
	end
end);
AddOn.RegisterGameEvent("PLAYER_LOGIN",function()
	local name,server=UnitFullName("player");--	Server is provided for "player" (can also get from GetNormalizedRealmName())
	PlayerName,PlayerFullName=name,string_format("%s-%s",name,server or GetNormalizedRealmName());--	Store for comms echo filtering
end);
AddOn.RegisterGameEvent("PLAYER_LOGOUT",function()--	Cull blacklisted values
	for creaturekey in next,HealthCache do if AddOn_IsBlacklistedCreatureKey(creaturekey) then HealthCache[creaturekey]=nil; end end
	for creaturekey in next,PeerCache do if AddOn_IsBlacklistedCreatureKey(creaturekey) or rawget(HealthCache,creaturekey) then PeerCache[creaturekey]=nil; end end
end);

--	Unit data collection
AddOn.RegisterGameEvent("NAME_PLATE_UNIT_ADDED",function(_,unit) ProcessUnit(unit); end);
AddOn.RegisterGameEvent("UPDATE_MOUSEOVER_UNIT",function() ProcessUnit("mouseover"); ProcessUnit("mouseovertarget"); end);
AddOn.RegisterGameEvent("PLAYER_TARGET_CHANGED",function() ProcessUnit("target"); ProcessUnit("targettarget"); end);
AddOn.RegisterGameEvent("UNIT_TARGET",function(_,unit) ProcessUnit(unit.."target"); end);
AddOn.RegisterGameEvent("UNIT_HEALTH",function(_,unit) ProcessUnit(unit); end);--	Mob reset detection

--	Aura Updates
AddOn.RegisterGameEvent("UNIT_AURA",function(_,unit) return ProcessAuras(unit); end);

--	CombatLog events
AddOn.RegisterGameEvent("COMBAT_LOG_EVENT_UNFILTERED",function() return ProcessCLE(CombatLogGetCurrentEventInfo()); end);

--	Communications
AddOn.RegisterGameEvent("CHAT_MSG_ADDON",function(_,pre,msg,chan,sender)
	if pre=="RMH" and sender~=PlayerName and sender~=PlayerFullName then
		local creaturekey,maxhealth=string_match(msg,"^(%d+%-?%d*):(%d*%??)");
		if creaturekey then
			if maxhealth=="?" then--	Health query
				maxhealth=HealthCache[creaturekey];
				if maxhealth then AddOn_SendMessage("RMH",string_format("%s:%d",creaturekey,maxhealth),"WHISPER",sender); end--	Respond if we have a value
			elseif EnablePeerCache and not HealthCache[creaturekey] then--	Health broadcast
				maxhealth=tonumber(maxhealth);
				if (maxhealth or 0)>(PeerCache[creaturekey] or 0) then
					PeerCache[creaturekey]=maxhealth;
					AddOn_FireAddOnEvent("PEERCACHE_UPDATE",GetPeerCacheCount());
					AddOn_FireAddOnEvent("HEALTH_UPDATE",creaturekey,maxhealth);
				end
			end
		end
	end
end);

AddOn.RegisterAddOnEvent("OPTIONS_UPDATE",function(_,option,value)--	Update our cache
	if option==nil then option,value="EnablePeerCache",AddOn.Options.EnablePeerCache; end
	if option=="EnablePeerCache" then EnablePeerCache=value; end
end);

--	Memory management
AddOn.SetTimerInterval(PurgeTimerInterval,function(elapsed)
	local now=GetTime();
	for creaturekey,timestamp in pairs(LastHealthQuery) do--	Scan LastHealthQuery
		if now-timestamp>HealthQueryThrottle then LastHealthQuery[creaturekey]=nil; end-- Delete if timeout period has elapsed
	end

	for guid,data in pairs(UnitCache) do--	Scan UnitCache
--		Priority-based timeout
		if now-data.LastSeen>(
			data.IsDead and DeathTimeout
		or	(data.Damage and DamageTimeout
		or	(data.CreatureKey and TargetTimeout
		or 0))) then
			UnitCache[guid]=nil;--	Wipe data if mob has reached the end of their timeout
		end
	end
end);

--------------------------
--[[	Debug Commands	]]
--------------------------
--[[	For retesting data collection code
do	local LocalCache={};

	hash_ChatTypeInfoList["/RMHNEW"]="REALMOBHEALTH_NEWCACHE";
	hash_SlashCmdList["/RMHNEW"]=function()
		table.wipe(LocalCache);
		HealthCache=LocalCache;

--		Fire events
		AddOn_FireAddOnEvent("HEALTHCACHE_UPDATE",GetHealthCacheCount());
		AddOn_FireAddOnEvent("HEALTH_UPDATE",nil,nil);

		print("LocalHealthCache created");
	end;

	hash_ChatTypeInfoList["/RMHCLONE"]="REALMOBHEALTH_CLONECACHE";
	hash_SlashCmdList["/RMHCLONE"]=function()
		table.wipe(LocalCache);
		for key,val in pairs(RealMobHealth_CreatureHealthCache) do LocalCache[key]=val; end
		HealthCache=LocalCache;

--		Fire events
		AddOn_FireAddOnEvent("HEALTHCACHE_UPDATE",GetHealthCacheCount());
		AddOn_FireAddOnEvent("HEALTH_UPDATE",nil,nil);

		print("LocalHealthCache cloned");
	end;

	hash_ChatTypeInfoList["/RMHRESTORE"]="REALMOBHEALTH_RESTORECACHE";
	hash_SlashCmdList["/RMHRESTORE"]=function()
		HealthCache=RealMobHealth_CreatureHealthCache;

--		Fire events
		AddOn_FireAddOnEvent("HEALTHCACHE_UPDATE",GetHealthCacheCount());
		AddOn_FireAddOnEvent("HEALTH_UPDATE",nil,nil);

		print("LocalHealthCache deleted");
	end;
end
--]]

--------------------------
--[[	API Functions	]]
--------------------------
local function GetUnitHealth(unit)
	local guid=UnitGUID(unit);
	if guid then--	Need a unit to continue
		local naturalcurrent,naturalmax=UnitHealth(unit),UnitHealthMax(unit);--	Save these as default values if we fail to return anything
		if AddOn_IsBlacklistedGUID(guid) then return naturalcurrent,naturalmax,nil,nil; end--	Check blacklist

		local creaturekey=AddOn_GetUnitCreatureKey(unit);
		if not creaturekey then return naturalcurrent,naturalmax,nil,nil; end-- Need a CreatureKey

		local data=UnitCache[guid];
		local isdead=UnitIsDead(unit);
		local percent=naturalmax>0 and naturalcurrent/naturalmax or 0;--	Right now, health scales 1-100, automaticly adjusts for different scale if this changes
		local damage=data and data.Damage or 0;--	Default to zero damage
		local max=AddOn_HealthOverrides[creaturekey] or HealthCache[creaturekey] or (EnablePeerCache and PeerCache[creaturekey] or nil);--	Sources in order

		if not max then QueryCreatureHealth(creaturekey); end--	Query peers for health if no data found

		if max then--	Data found, no need to speculate that
			if isdead or percent>=1 then return isdead and 0 or max,max,false,false; end--	Unit dead or full health

			local guess=math_ceil(max*percent);--	Calculate from percentage (Less precise)
			if damage<=0 then return guess,max,true,false; end--	No damage recorded

			local current=max-damage;--	Calculate from damage taken
			if math_abs(current-guess)<max*DamageSyncThreshold then return current,max,false,false;--	Damage is within an acceptible range
			else return guess,max,true,false; end--	Damage is out of sync
		elseif damage>0 and percent<1 then--	Requires damage taken
			max=math_ceil(damage/(1-percent));--	Reverse calculation based on percent health and damage taken
			if isdead then return 0,max,false,true;--	Current health can't be more precise than dead
			else return max-damage,max,true,true; end--	Complete speculation here, precision should improve the more damage a unit takes
		end

		return naturalcurrent,naturalmax,nil,nil;--	Fallback to natural values
	end
end

local function DeleteUnitHealthData(unit)
	local creaturekey=AddOn_GetUnitCreatureKey(unit);
	if creaturekey and rawget(HealthCache,creaturekey) then
		HealthCache[creaturekey]=nil;--	Delete value

--		Fire events
		AddOn_FireAddOnEvent("HEALTHCACHE_UPDATE",GetHealthCacheCount());
		AddOn_FireAddOnEvent("HEALTH_UPDATE",creaturekey,nil);

		return true;
	end
	return false;
end

local function UnitHasHealthData(unit)--	Peer data isn't trusted, so this function ignores it
	local creaturekey=AddOn_GetUnitCreatureKey(unit);
	return ((creaturekey and not AddOn_IsBlacklistedCreatureKey(creaturekey)) and (AddOn_HealthOverrides[creaturekey] or rawget(HealthCache,creaturekey))) and true or false;--	Cast to boolean
end

local function WipeHealthData()
	table_wipe(HealthCache);--	Wipe table

	--	Fire events
	AddOn_FireAddOnEvent("HEALTHCACHE_UPDATE",GetHealthCacheCount());
	AddOn_FireAddOnEvent("HEALTH_UPDATE",nil,nil);
end

local function WipePeerData()
	table_wipe(PeerCache);--	Wipe table

	--	Fire events
	AddOn_FireAddOnEvent("PEERCACHE_UPDATE",GetPeerCacheCount());
	AddOn_FireAddOnEvent("HEALTH_UPDATE",nil,nil);
end

AddOn.GetUnitHealth=GetUnitHealth;
AddOn.DeleteUnitHealthData=DeleteUnitHealthData;
AddOn.UnitHasHealthData=UnitHasHealthData;
AddOn.WipeHealthData=WipeHealthData;
AddOn.WipePeerData=WipePeerData;

------------------------------------------
--[[	External API Registration	]]
------------------------------------------
AddOn.API.GetUnitHealth=GetUnitHealth;
AddOn.API.DeleteUnitHealthData=DeleteUnitHealthData;
AddOn.API.UnitHasHealthData=UnitHasHealthData;
AddOn.API.WipeHealthData=WipeHealthData;
