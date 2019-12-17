--[[	RealMobHealth Communications Module
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145	]]
------------------------------------------------------------------

--------------------------
--[[	Namespace	]]
--------------------------
local Name,AddOn=...;

----------------------------------
--[[	Local References	]]
----------------------------------
local C_ChatInfo_SendAddonMessage=C_ChatInfo.SendAddonMessage;
local InActiveBattlefield=InActiveBattlefield;
local IsInGroup=IsInGroup;
local IsInGuild=IsInGuild;
local IsInRaid=IsInRaid;
local string_upper=string.upper;
local table_insert=table.insert;
local table_remove=table.remove;
local unpack=unpack;

local LE_PARTY_CATEGORY_HOME=LE_PARTY_CATEGORY_HOME;
local LE_PARTY_CATEGORY_INSTANCE=LE_PARTY_CATEGORY_INSTANCE;

--------------------------
--[[	Local Variables	]]
--------------------------
local MessageQueue={};
local MessageThrottle=0.1;

----------------------------------
--[[	Internal Functions	]]
----------------------------------
local ChannelChecks={--	Channel availability functions
	GUILD=IsInGuild;
	BATTLEGROUND=InActiveBattlefield;
	INSTANCE_CHAT=function() return IsInGroup(LE_PARTY_CATEGORY_INSTANCE); end;
	PARTY=function() return IsInGroup(LE_PARTY_CATEGORY_HOME); end;
	RAID=function() return IsInRaid(LE_PARTY_CATEGORY_HOME); end;
}

local function SendMessage(pre,msg,channel,target)
	channel=string_upper(channel);
	for _,data in ipairs(MessageQueue) do
		local d1,d2,d3,d4=unpack(data);
		if d1==pre and d2==msg and d3==channel and (d4 and string_upper(d4))==(target and string_upper(target)) then return; end
	end
	table_insert(MessageQueue,{pre,msg,channel,target});
end

local function BroadcastMessage(pre,msg)--	Bloadcasts to all available group channels
	if IsInGuild() then SendMessage(pre,msg,"GUILD"); end
	if InActiveBattlefield() then SendMessage(pre,msg,"BATTLEGROUND"); end
	if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then SendMessage(pre,msg,"INSTANCE_CHAT"); end
	if IsInRaid(LE_PARTY_CATEGORY_HOME) then SendMessage(pre,msg,"RAID");
	elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then SendMessage(pre,msg,"PARTY"); end
	SendMessage(pre,msg,"YELL");--	New channel in 1.13.3
end

AddOn.SendMessage=SendMessage;
AddOn.BroadcastMessage=BroadcastMessage;

--------------------------
--[[	Script Handlers	]]
--------------------------
AddOn.RegisterGameEvent("ADDON_LOADED",function(event,name)
	if name==Name then
--		Register AddOn channel
		C_ChatInfo.RegisterAddonMessagePrefix("RMH");
		AddOn.UnregisterGameEvent(event);--	Calling this in here defaults to currently running function
	end
end);

AddOn.SetTimerInterval(MessageThrottle,function()
	if #MessageQueue>0 then
		local data=table_remove(MessageQueue,1);
		local checkfunc=ChannelChecks[data[3]];
		if not checkfunc or checkfunc() then
			C_ChatInfo_SendAddonMessage(unpack(data));
		end
	end
end);
