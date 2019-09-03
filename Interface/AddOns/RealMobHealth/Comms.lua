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
local IsInGroup=IsInGroup;
local IsInGuild=IsInGuild;
local IsInRaid=IsInRaid;
local string_upper=string.upper;
local table_insert=table.insert;
local table_remove=table.remove;
local unpack=unpack;

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
	RAID=IsInRaid;
	PARTY=IsInGroup;
}

local function SendMessage(pre,msg,channel,target) table_insert(MessageQueue,{pre,msg,string_upper(channel),target}); end
local function BroadcastMessage(pre,msg)--	Bloadcasts to all available group channels
	if IsInGuild() then SendMessage(pre,msg,"GUILD"); end
	if IsInRaid() then SendMessage(pre,msg,"RAID");
	elseif IsInGroup() then SendMessage(pre,msg,"PARTY"); end
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
