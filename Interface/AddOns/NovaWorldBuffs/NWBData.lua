-------------------------------------------
---NovaWorldBuffs data and communications--
-------------------------------------------
---This file has links with functions in other files, it's not a standalone module.
---It's also a work in progress with quite a bit of mess that needs to be tidied up later.

---Explanation of how data syncing works here (data size and frequency has been cut down a lot in the past couple weeks (30th/may/2020).
---GUILD
---Player logs on and shares their data + settings to the guild.
---Only a couple of people online will reply with their current timer data + settings (top in alphabetic order online with addon installed).
---The rest of people online reply with only their settings (settings are small enough to be one single msg).
---Settings are important because they decide which one person online will send guild chat msgs in NWB:sendGuildMsg() for timers etc.
---Layermaps are only sent on every second sync.
---Data is compressed for party/raid/guild but cannot be compressed for yell because of a Blizzard filter blocking yell special characters.
---When sending our data table for any channel I replace all the keys with single character strings to reduce size, see shortKeys below.
---Also when sending over yell channel I replace epoch timestamps with a shorter hash before sending.
---The timestamp hash is only used on yell, on other channels we let LibDeflate compress them.
---Party/RAID
---Data is sent one time only when we join a group ourself, not when others join.
---YELL
---Yell data is sent on entering world, or when taking/landing at a flightpath.
---Yell data is also sent on a looping timer, 10 minutes for most realms, 20 minutes for high pop realms with higher layers.
---All China/Taiwan/Korean realms are 20 minutes per yell because of their high population and layer count.
--
local version = GetAddOnMetadata("NovaWorldBuffs", "Version") or 9999;
local L = LibStub("AceLocale-3.0"):GetLocale("NovaWorldBuffs");

function NWB:OnCommReceived(commPrefix, string, distribution, sender)
	--if (NWB.isDebug) then
	--	return;
	--end
	if (UnitName("player") == "Delvara") then
		return;
	end
	if (distribution == "GUILD" and commPrefix == NWB.commPrefix) then
		--Temp bug fix test.
		local tempSender = sender;
		if (not string.match(tempSender, "-")) then
			tempSender = tempSender .. "-" .. GetNormalizedRealmName();
		end
		if (not NWB.hasAddon[tempSender]) then
			NWB.hasAddon[tempSender] = "0";
		end
	end
	if (UnitInBattleground("player") and distribution ~= "GUILD") then
		return;
	end
	--AceComm doesn't supply realm name if it's on the same realm as player.
	--Not sure if it provives GetRealmName() or GetNormalizedRealmName() for crossrealm.
	--For now we'll check all 3 name types just to be sure until tested.
	local me = UnitName("player") .. "-" .. GetRealmName();
	local meNormalized = UnitName("player") .. "-" .. GetNormalizedRealmName();
	if (sender == UnitName("player") or sender == me or sender == meNormalized) then
		NWB.hasAddon[meNormalized] = tostring(version);
		return;
	end
	local _, realm = strsplit("-", sender, 2);
	--If realm found then it's not my realm, but just incase acecomm changes and starts supplying realm also check if realm exists.
	if (realm ~= nil or (realm and realm ~= GetRealmName() and realm ~= GetNormalizedRealmName())) then
		--Ignore data from other realms (in bgs).
		return;
	end
	if (commPrefix == "D4C") then
		--Parse DBM.
		NWB:parseDBM(commPrefix, string, distribution, sender);
		return;
	end
	--If no realm in name it must be our realm so add it.
	if (not string.match(sender, "-")) then
		--Add normalized realm since roster checks use this.
		sender = sender .. "-" .. GetNormalizedRealmName();
	end
	local decoded;
	if (distribution == "YELL" or distribution == "SAY") then
		decoded = NWB.libDeflate:DecodeForWoWChatChannel(string);
	else
		decoded = NWB.libDeflate:DecodeForWoWAddonChannel(string);
	end
	if (not decoded) then
		--NWB:debug("Old version of yell data ignored", sender);
		return;
	end
	local decompressed = NWB.libDeflate:DecompressDeflate(decoded);
	local deserializeResult, deserialized = NWB.serializer:Deserialize(decompressed);
	if (not deserializeResult) then
		--Fall back to old deserializer if it's an old version.
		if (not decompressed) then
			--NWB:debug("decompression failed found from", sender);
			return;
		end
		deserializeResult, deserialized = NWB.serializerOld:Deserialize(decompressed);
	end
	if (not deserializeResult) then
		NWB:debug("Error deserializing:", distribution);
		return;
	end
	local args = NWB:explode(" ", deserialized, 2);
	local cmd = args[1]; --Cmd (first arg) so we know where to send the data.
	local remoteVersion = args[2]; --Version number.
	local data = args[3]; --Data (everything after version arg).
	if (data == nil and cmd ~= "ping") then
		--Temp fix for people with old version data structure sending incompatable data.
		--Only effects a few of the early testers.
		data = args[2]; --Data (everything after version arg).
		remoteVersion = "0";
	end
	NWB.hasAddon[sender] = remoteVersion or "0";
	--Trying to fix double guild msg bug, extract settings from data first even if the rest fails for some reason.
	NWB:extractSettings(data, sender, distribution);
	if (not tonumber(remoteVersion)) then
		--Trying to catch a lua error and find out why.
		NWB:debug("version missing", sender, cmd, data);
		return;
	end
	--Ignore all commands but settings requests for much older versions.
	if (tonumber(remoteVersion) < 1.50) then
		--Ignore all commands but settings requests.
		if (cmd == "requestData" and distribution == "GUILD") then
			if (not NWB:getGuildDataStatus()) then
				NWB:sendSettings("GUILD");
			else
				NWB:sendData("GUILD");
				--Temporary send old serializer type settings, remove in a week or 2 after enough people update to new serializer.
				--To avoid duplicate guild msgs.
				--NWB:sendSettings("GUILD");
			end
		end
		return;
	end
	if (cmd == "drop" and not (NWB.db.global.receiveGuildDataOnly and distribution ~= "GUILD")) then
		--NWB:debug("drop inc", sender, data);
		--Buff drop seen by someone in org.
		local type, layer = strsplit(" ", data, 2);
		NWB:doBuffDropMsg(type, layer);
	elseif ((cmd == "yell" or cmd == "yell2") and not (NWB.db.global.receiveGuildDataOnly and distribution ~= "GUILD")) then
		--NWB:debug("yell inc", sender, data);
		--Yell msg seen by someone in org.
		local type, layer = strsplit(" ", data, 2);
		NWB:doFirstYell(type, layer);
	elseif ((cmd == "npcKilled" or cmd == "npcKilled2") and not (NWB.db.global.receiveGuildDataOnly and distribution ~= "GUILD")) then
		--NWB:debug("npc killed inc", sender, data);
		--Npc killed seen by someone in org.
		local type, layer = strsplit(" ", data, 2);
		NWB:doNpcKilledMsg(type, layer);
	elseif ((cmd == "flower" or cmd == "flower2") and not (NWB.db.global.receiveGuildDataOnly and distribution ~= "GUILD")) then
		--NWB:debug("flower inc", sender, data);
		--Flower picked.
		local type, layer = strsplit(" ", data, 2);
		NWB:doFlowerMsg(type, layer);
	end
	--Ignore data syncing for some recently out of date versions.
	if (tonumber(remoteVersion) < 1.76) then
		if (cmd == "requestData" and distribution == "GUILD") then
			if (not NWB:getGuildDataStatus()) then
				NWB:sendSettings("GUILD");
			else
				NWB:sendData("GUILD");
				--Temporary send old serializer type settings, remove in a week or 2 after enough people update to new serializer.
				--To avoid duplicate guild msgs.
				--NWB:sendSettings("GUILD");
			end
		end
		return;
	end
	if (cmd == "data" or cmd == "settings") then
		NWB:receivedData(data, sender, distribution);
	elseif (cmd == "requestData") then
		--Other addon users request data when they log on.
		NWB:receivedData(data, sender, distribution);
		if (not NWB:getGuildDataStatus()) then
			NWB:sendSettings("GUILD");
		else
			NWB:sendData("GUILD");
			--Temporary send old serializer type settings, remove in a week or 2 after enough people update to new serializer.
			--To avoid duplicate guild msgs.
			--NWB:sendSettings("GUILD");
		end
	elseif (cmd == "requestSettings") then
		--Only used once per logon.
		NWB:receivedData(data, sender, distribution);
		NWB:sendSettings("GUILD");
	end
	NWB:versionCheck(remoteVersion);
end

--Send to specified addon channel.
function NWB:sendComm(distribution, string, target, useOldSerializer)
	--if (NWB.isDebug) then
	--	return;
	--end
	if (target == UnitName("player")) then
		return;
	end
	if (distribution == "GUILD" and not IsInGuild()) then
		return;
	end
	if (UnitInBattleground("player") and distribution ~= "GUILD") then
		return;
	end
	if (distribution == "CHANNEL") then
		--Get channel ID number.
		local addonChannelId = GetChannelName(target);
		--Not sure why this only accepts a string and not an int.
		--Addon channels are disabled in classic but I'll leave this here anyway.
		target = tostring(addonChannelId);
	elseif (distribution ~= "WHISPER") then
		target = nil;
	end
	local data, serialized;
	if (useOldSerializer) then
		--For settings to older versions.
		serialized = NWB.serializerOld:Serialize(string);
	else
		serialized = NWB.serializer:Serialize(string);
	end
	local compressed = NWB.libDeflate:CompressDeflate(serialized, {level = 9});
	if (distribution == "YELL" or distribution == "SAY") then
		data = NWB.libDeflate:EncodeForWoWChatChannel(compressed);
	else
		data = NWB.libDeflate:EncodeForWoWAddonChannel(compressed);
	end
	--NWB:debug("Serialized length:", string.len(serialized));
	--NWB:debug("Compressed length:", string.len(compressed));
	NWB:SendCommMessage(NWB.commPrefix, data, distribution, target);
end

--Send full data.
NWB.lastDataSent = 0;
local enableLogging = true;
local includeTimerLog = true;
local logRendOnly = true;
local logLayeredServersOnly = true;
function NWB:sendData(distribution, target, prio, noLayerMap, noLogs)
	--if (NWB.isDebug) then
	--	return;
	--end
	local inInstance, instanceType = IsInInstance();
	if (distribution == "YELL" and inInstance) then
		return;
	end
	if (not prio) then
		prio = "NORMAL";
	end
	local data;
	if (NWB.isLayered) then
		data = NWB:createDataLayered(distribution, noLayerMap, noLogs);
	else
		data = NWB:createData(distribution, noLogs);
	end
	--NWB:debug(data);
	if (next(data) ~= nil) then
		data = NWB.serializer:Serialize(data);
		NWB.lastDataSent = GetServerTime();
		NWB:sendComm(distribution, "data " .. version .. " " .. data, target, prio);
	end
end

--Send timer log only.
--Sorry Blizzard for the extra log data but only the person handing in the quest knows which layer rend dropped on after the last hotfix.
--So now we have to share this data around along with rend drop history it's only way to have any idea which layer we can drop rend on. :/
--I've tried my best to keep the data short and only send the first few log entries at a time.
--I will remove this log system if the rend drop is ever fixed so it can work like ony/nef and not send the yell msgs on every layer.
function NWB:sendTimerLogData(distribution, entries)
	if (not enableLogging) then
		return;
	end
	if (logLayeredServersOnly and not NWB.isLayered) then
		return;
	end
	local inInstance, instanceType = IsInInstance();
	if (distribution == "YELL" and inInstance) then
		return;
	end
	local data = {};
	data.timerLog = NWB:createTimerLogData(distribution, entries);
	if (next(data) ~= nil) then
		data = NWB:convertKeys(data, true, distribution);
		--NWB:debug(data);
		data = NWB.serializer:Serialize(data);
		NWB.lastDataSent = GetServerTime();
		NWB:sendComm(distribution, "data " .. version .. " " .. data, target, prio);
	end
end

--Check if we should send guild data, first 2 online only will send data to not spam addon comms.
function NWB:getGuildDataStatus()
	if (not IsInGuild()) then
		return;
	end
	GuildRoster();
	local numTotalMembers = GetNumGuildMembers();
	local onlineMembers = {};
	local me = UnitName("player") .. "-" .. GetNormalizedRealmName();
	for i = 1, numTotalMembers do
		local name, _, _, _, _, zone, _, _, online, _, _, _, _, isMobile = GetGuildRosterInfo(i);
		if (name and online and NWB.hasAddon[name] and not isMobile) then
			--If guild member is online and has addon installed add to temp table.
			onlineMembers[name] = true;
		end
	end
	--Check temp table to see if we're first in alphabetical order.
	local count = 0;
	local limit = 2;
	for k, v in NWB:pairsByKeys(onlineMembers) do
		count = count + 1;
		if (count > limit) then
			--NWB:debug("Not first in line for guild data");
			return;
		end
		if (k == me) then
			--NWB:debug("First in line for guild data");
			return true;
		end
	end
end

--Send settings only.
function NWB:sendSettings(distribution, target, prio)
	if (UnitInBattleground("player") and distribution ~= "GUILD") then
		return data;
	end
	if (not prio) then
		prio = "NORMAL";
	end
	local data = NWB:createSettings(distribution);
	if (next(data) ~= nil) then
		data = NWB.serializer:Serialize(data);
		NWB.lastDataSent = GetServerTime();
		NWB:sendComm(distribution, "settings " .. version .. " " .. data, target, prio);
	end
end

--Temporary send old serializaton type, remove in later version when more people are on the new serializer.
--Removed, no longer in use.
function NWB:sendSettingsOld(distribution, target, prio)
	if (UnitInBattleground("player") and distribution ~= "GUILD") then
		return data;
	end
	if (not prio) then
		prio = "NORMAL";
	end
	local data = NWB:createSettings(distribution);
	if (next(data) ~= nil) then
		NWB.lastDataSent = GetServerTime();
		data = NWB.serializerOld:Serialize(data);
		NWB:sendComm(distribution, "settings " .. version .. " " .. data, target, prio, true);
	end
end

--Send buff dropped msg.
function NWB:sendBuffDropped(distribution, type, target, layer)
	if (tonumber(layer)) then
		NWB:sendComm(distribution, "drop " .. version .. " " .. type .. " " .. layer, target);
	else
		NWB:sendComm(distribution, "drop " .. version .. " " .. type, target);
	end
end

--Send first yell msg.
function NWB:sendYell(distribution, type, target, layer)
	if (NWB.sharedLayerBuffs) then
		layer = nil;
	end
	if (tonumber(layer)) then
		NWB:sendComm(distribution, "yell2 " .. version .. " " .. type .. " " .. layer, target);
		--Temporary send both msgs until next version so people don't get lua error on old versions.
		--The yell2 msg will be changed to yell and the 2nd msg without layer will be removed.
		NWB:sendComm(distribution, "yell " .. version .. " " .. type, target);
	else
		NWB:sendComm(distribution, "yell " .. version .. " " .. type, target);
	end
end

--Send npc killed msg.
function NWB:sendNpcKilled(distribution, type, target, layer)
	if (tonumber(layer)) then
		NWB:sendComm(distribution, "npcKilled2 " .. version .. " " .. type .. " " .. layer, target);
		NWB:sendComm(distribution, "npcKilled " .. version .. " " .. type, target);
	else
		NWB:sendComm(distribution, "npcKilled " .. version .. " " .. type, target);
	end
end

--Send flower msg.
function NWB:sendFlower(distribution, type, target, layer)
	NWB:debug("sending flower", type, layer);
	if (tonumber(layer)) then
		NWB:sendComm(distribution, "flower2 " .. version .. " " .. type .. " " .. layer, target);
		NWB:sendComm(distribution, "flower " .. version .. " " .. type, target);
	else
		NWB:sendComm(distribution, "flower " .. version .. " " .. type, target);
	end
end

--Send full data and also request other users data back, used at logon time.
function NWB:requestData(distribution, target, prio)
	--if (NWB.isDebug) then
	--	return;
	--end
	if (not prio) then
		prio = "NORMAL";
	end
	local data;
	if (NWB.isLayered) then
		data = NWB:createDataLayered(distribution);
	else
		data = NWB:createData(distribution);
	end
	data = NWB.serializer:Serialize(data);
	NWB.lastDataSent = GetServerTime();
	NWB:sendComm(distribution, "requestData " .. version .. " " .. data, target, prio);
	--Temporary send old serializer type settings, remove in a week or 2 after enough people update to new serializer.
	--To avoid duplicate guild msgs.
	--NWB:sendSettings("GUILD");
end

--Send settings only and also request other users settings back.
function NWB:requestSettings(distribution, target, prio)
	if (not prio) then
		prio = "NORMAL";
	end
	local data = NWB:createSettings(distribution);
	if (next(data) ~= nil) then
		local dataNew = NWB.serializer:Serialize(data);
		NWB.lastDataSent = GetServerTime();
		NWB:sendComm(distribution, "requestSettings " .. version .. " " .. dataNew, target, prio);
		--Temorary send both types so less duplicate guikd chat msgs, remove in next version when more people are on the new serializer.
		local dataOld = NWB.serializerOld:Serialize(data);
		NWB:sendComm(distribution, "requestSettings " .. version .. " " .. dataOld, target, prio, true);
	end
	--data = NWB.serializer:Serialize(data);
	--NWB.lastDataSent = GetServerTime();
	--NWB:sendComm(distribution, "requestSettings " .. version .. " " .. data, target, prio);
end

--Create data table for sending.
function NWB:createData(distribution, noLogs)
	local data = {};
	if (UnitInBattleground("player") and distribution ~= "GUILD") then
		return data;
	end
	if (NWB.data.rendTimer > (GetServerTime() - NWB.db.global.rendRespawnTime)) then
		data['rendTimer'] = NWB.data.rendTimer;
		data['rendTimerWho'] = NWB.data.rendTimerWho;
		data['rendYell'] = NWB.data.rendYell or 0;
		data['rendYell2'] = NWB.data.rendYell2 or 0;
		data['rendSource'] = NWB.data.rendSource;
	end
	if (NWB.data.onyTimer > (GetServerTime() - NWB.db.global.onyRespawnTime)) then
		data['onyTimer'] = NWB.data.onyTimer;
		data['onyTimerWho'] = NWB.data.onyTimerWho;
		data['onyYell'] = NWB.data.onyYell or 0;
		data['onyYell2'] = NWB.data.onyYell2 or 0;
		data['onySource'] = NWB.data.onySource;
	end
	if (NWB.data.nefTimer > (GetServerTime() - NWB.db.global.nefRespawnTime)) then
		data['nefTimer'] = NWB.data.nefTimer;
		data['nefTimerWho'] = NWB.data.nefTimerWho;
		data['nefYell'] = NWB.data.nefYell or 0;
		data['nefYell2'] = NWB.data.nefYell2 or 0;
		data['nefSource'] = NWB.data.nefSource;
	end
	if ((NWB.data.onyNpcDied > NWB.data.onyTimer) and
			(NWB.data.onyNpcDied > (GetServerTime() - NWB.db.global.onyRespawnTime))) then
		data['onyNpcDied'] = NWB.data.onyNpcDied;
	end
	if ((NWB.data.nefNpcDied > NWB.data.nefTimer) and
			(NWB.data.nefNpcDied > (GetServerTime() - NWB.db.global.nefRespawnTime))) then
		data['nefNpcDied'] = NWB.data.nefNpcDied;
	end
	for k, v in pairs(NWB.songFlowers) do
		--Add currently active songflower timers.
		if (NWB.data[k] > GetServerTime() - 1500) then
			data[k] = NWB.data[k];
		end
	end
	for k, v in pairs(NWB.tubers) do
		--Add currently active tuber timers.
		if (NWB.data[k] > GetServerTime() - 1500) then
			data[k] = NWB.data[k];
		end
	end
	for k, v in pairs(NWB.dragons) do
		--Add currently active dragon timers.
		if (NWB.data[k] > GetServerTime() - 1500) then
			data[k] = NWB.data[k];
		end
	end
	if (distribution == "GUILD") then
		--Include settings with timer data for guild.
		local settings = NWB:createSettings(distribution);
		local me = UnitName("player") .. "-" .. GetNormalizedRealmName();
		data[me] = settings[me];
	end
	if (enableLogging and not noLogs and includeTimerLog and (not logLayeredServersOnly or NWB.isLayered)) then
		local timerLog = NWB:createTimerLogData(distribution);
		if (next(timerLog)) then
			data.timerLog = timerLog;
		end
	end
	--data['faction'] = NWB.faction;
	--NWB:debug("Before key convert:", string.len(NWB.serializer:Serialize(data)));
	data = NWB:convertKeys(data, true, distribution);
	--NWB:debug("After key convert:", string.len(NWB.serializer:Serialize(data)));
	--NWB:debug(data);
	return data;
end

local lastSendLayerMap = {};
function NWB:createDataLayered(distribution, noLayerMap, noLogs)
	local data = {};
	if (UnitInBattleground("player") and distribution ~= "GUILD") then
		return data;
	end
	if (not lastSendLayerMap[distribution]) then
		lastSendLayerMap[distribution] = 0;
	end
	--Send layer info only every 2nd yell to lower data sent.
	local sendLayerMapDelay = 640;
	if (NWB.cnRealms[NWB.realm] or NWB.twRealms[NWB.realm] or NWB.krRealms[NWB.realm]) then
		sendLayerMapDelay = 1260;
	end
	local sendLayerMap, foundTimer;
	if (not noLayerMap and (GetServerTime() - lastSendLayerMap[distribution]) > sendLayerMapDelay
			and distribution ~= "PARTY" and distribution ~= "RAID") then
		--Layermap data data won't change much except right after a server restart.
		--So there's no need to use the addon bandwidth every time we send.
		--Also don't send layermap data with group joins.
		sendLayerMap = true;
	end
	for layer, v in NWB:pairsByKeys(NWB.data.layers) do
		--Reset foundTimer with each loop so we don't send layermap data for layers with no timers later in the loop.
		foundTimer = nil;
		if (NWB.data.layers[layer].rendTimer > (GetServerTime() - NWB.db.global.rendRespawnTime)) then
			--Only create layers table if we have valid timers so we don't waste addon bandwidth with useless data.
			--This was always done on non-layered realms but wasn't working right on layered realms, now it is.
			--The data table is checked for empty when sending comms.
			if (not data.layers) then
				data.layers = {};
			end
			if (not data.layers[layer]) then
				data.layers[layer] = {};
			end
			data.layers[layer]['rendTimer'] = NWB.data.layers[layer].rendTimer;
			--data.layers[layer]['rendTimerWho'] = NWB.data.layers[layer].rendTimerWho;
			data.layers[layer]['rendYell'] = NWB.data.layers[layer].rendYell;
			--data.layers[layer]['rendYell2'] = NWB.data.layers[layer].rendYell2;
			--data.layers[layer]['rendSource'] = NWB.data.layers[layer].rendSource;
			--if (NWB.data.layers[layer].GUID and not NWB.cnRealms[NWB.realm] and not NWB.twRealms[NWB.realm]
			--		and not NWB.krRealms[NWB.realm]) then
			--	data.layers[layer]['GUID'] = NWB.data.layers[layer].GUID;
			--end
			foundTimer = true;
		end
		if (NWB.data.layers[layer].onyTimer > (GetServerTime() - NWB.db.global.onyRespawnTime)) then
			if (not data.layers) then
				data.layers = {};
			end
			if (not data.layers[layer]) then
				data.layers[layer] = {};
			end
			--NWB:validateCloseTimestamps(layer, "onyTimer");
			--NWB:validateCloseTimestamps(layer, "onyYell");
			data.layers[layer]['onyTimer'] = NWB.data.layers[layer].onyTimer;
			--data.layers[layer]['onyTimerWho'] = NWB.data.layers[layer].onyTimerWho;
			data.layers[layer]['onyYell'] = NWB.data.layers[layer].onyYell;
			--data.layers[layer]['onyYell2'] = NWB.data.layers[layer].onyYell2;
			--data.layers[layer]['onySource'] = NWB.data.layers[layer].onySource;
			--if (NWB.data.layers[layer].GUID and not NWB.cnRealms[NWB.realm] and not NWB.twRealms[NWB.realm]
			--		and not NWB.krRealms[NWB.realm]) then
			--	data.layers[layer]['GUID'] = NWB.data.layers[layer].GUID;
			--end
			foundTimer = true;
		end
		if (NWB.data.layers[layer].nefTimer > (GetServerTime() - NWB.db.global.nefRespawnTime)) then
			if (not data.layers) then
				data.layers = {};
			end
			if (not data.layers[layer]) then
				data.layers[layer] = {};
			end
			data.layers[layer]['nefTimer'] = NWB.data.layers[layer].nefTimer;
			--data.layers[layer]['nefTimerWho'] = NWB.data.layers[layer].nefTimerWho;
			data.layers[layer]['nefYell'] = NWB.data.layers[layer].nefYell;
			--data.layers[layer]['nefYell2'] = NWB.data.layers[layer].nefYell2;
			--data.layers[layer]['nefSource'] = NWB.data.layers[layer].nefSource;
			--if (NWB.data.layers[layer].GUID and not NWB.cnRealms[NWB.realm] and not NWB.twRealms[NWB.realm]
			--		and not NWB.krRealms[NWB.realm]) then
			--	data.layers[layer]['GUID'] = NWB.data.layers[layer].GUID;
			--end
			foundTimer = true;
		end
		if ((NWB.data.layers[layer].onyNpcDied > NWB.data.layers[layer].onyTimer) and
				(NWB.data.layers[layer].onyNpcDied > (GetServerTime() - NWB.db.global.onyRespawnTime))) then
			if (not data.layers) then
				data.layers = {};
			end
			if (not data.layers[layer]) then
				data.layers[layer] = {};
			end
			data.layers[layer]['onyNpcDied'] = NWB.data.layers[layer].onyNpcDied;
			--if (NWB.data.layers[layer].GUID and not NWB.cnRealms[NWB.realm] and not NWB.twRealms[NWB.realm]
			--		and not NWB.krRealms[NWB.realm]) then
			--	data.layers[layer]['GUID'] = NWB.data.layers[layer].GUID;
			--end
			foundTimer = true;
		end
		if ((NWB.data.layers[layer].nefNpcDied > NWB.data.layers[layer].nefTimer) and
				(NWB.data.layers[layer].nefNpcDied > (GetServerTime() - NWB.db.global.nefRespawnTime))) then
			if (not data.layers) then
				data.layers = {};
			end
			if (not data.layers[layer]) then
				data.layers[layer] = {};
			end
			data.layers[layer]['nefNpcDied'] = NWB.data.layers[layer].nefNpcDied;
			--if (NWB.data.layers[layer].GUID and not NWB.cnRealms[NWB.realm] and not NWB.twRealms[NWB.realm]
			--		and not NWB.krRealms[NWB.realm]) then
			--	data.layers[layer]['GUID'] = NWB.data.layers[layer].GUID;
			--end
			foundTimer = true;
		end
		if (NWB.layeredSongflowers) then
			for k, v in pairs(NWB.songFlowers) do
				--Add currently active songflower timers.
				if (NWB.data.layers[layer][k] and (NWB.data.layers[layer][k] > GetServerTime() - 1500)) then
					if (not data.layers) then
						data.layers = {};
					end
					if (not data.layers[layer]) then
						data.layers[layer] = {};
					end
					data.layers[layer][k] = NWB.data.layers[layer][k];
					foundTimer = true;
				end
			end
		end
		if (sendLayerMap and foundTimer) then
			if (NWB.data.layers[layer].layerMap and next(NWB.data.layers[layer].layerMap)) then
				lastSendLayerMap[distribution] = GetServerTime();
				if (not data.layers) then
					data.layers = {};
				end
				if (not data.layers[layer]) then
					data.layers[layer] = {};
				end
				--NWB:debug("sending layer map data", distribution);
				data.layers[layer].layerMap = NWB.data.layers[layer].layerMap;
				--Don't share created time for now.
				data.layers[layer].layerMap.created = nil;
			end
		end
		if (not foundTimer and NWB.data.layers[layer].lastSeenNPC
				and NWB.data.layers[layer].lastSeenNPC > GetServerTime() - 7200) then
			--If no timer data to share then check when we last saw a valid NPC in city for this layer.
			--Trying to keep layers valid after long periods overnight when no timers drop, but not persist too long after server restarts.
			if (not data.layers) then
				data.layers = {};
			end
			if (not data.layers[layer]) then
				data.layers[layer] = {};
			end
			data.layers[layer]['lastSeenNPC'] = NWB.data.layers[layer].lastSeenNPC;
			if (NWB.data.layers[layer].GUID and not NWB.cnRealms[NWB.realm] and not NWB.twRealms[NWB.realm]
					and not NWB.krRealms[NWB.realm]) then
				data.layers[layer]['GUID'] = NWB.data.layers[layer].GUID;
			end
		end
	end
	if (not NWB.layeredSongflowers) then
		for k, v in pairs(NWB.songFlowers) do
			--Add currently active songflower timers.
			if (NWB.data[k] > GetServerTime() - 1500) then
				data[k] = NWB.data[k];
			end
		end
	end
	--Tubers and dragons aren't shared in layered realms anymore, trying to cut down on data.
	--They still work as personal timers for farming, which is really all they are good for anyway.
	--[[for k, v in pairs(NWB.tubers) do
		--Add currently active tuber timers.
		if (NWB.data[k] > GetServerTime() - 1500) then
			data[k] = NWB.data[k];
		end
	end
	for k, v in pairs(NWB.dragons) do
		--Add currently active dragon timers.
		if (NWB.data[k] > GetServerTime() - 1500) then
			data[k] = NWB.data[k];
		end
	end]]
	if (distribution == "GUILD") then
		--Include settings with timer data for guild.
		local settings = NWB:createSettings(distribution);
		local me = UnitName("player") .. "-" .. GetNormalizedRealmName();
		data[me] = settings[me];
	end
	if (enableLogging and not noLogs and includeTimerLog and (not logLayeredServersOnly or NWB.isLayered)) then
		local timerLog = NWB:createTimerLogData(distribution);
		if (next(timerLog)) then
			data.timerLog = timerLog;
		end
	end
	--data['faction'] = NWB.faction;
	data = NWB:convertKeys(data, true, distribution);
	--NWB:debug(data);
	return data;
end

function NWB:createTimerLogData(distribution, entries)
	local data = {};
	if (UnitInBattleground("player") and distribution ~= "GUILD") then
		return data;
	end
	if (not entries) then
		--7 log entries by default, 3 per layer and one for a rend drop msg, the minimum needed to be reliable on 2 layer servers.
		if (logRendOnly) then
			--If logging rend only then do 6, last 2 timers per layer, plus 2 drop msg.
			entries = 6;
		else
			entries = 7;
		end
	end
	local count = 0;
	local sorted = {}
	if (next(NWB.data.timerLog)) then
		for k, v in ipairs(NWB.data.timerLog) do
			if (not logRendOnly or v.type == "r" or v.type == "q") then
				count = count + 1;
				if (v.timestamp and v.timestamp > (GetServerTime() - 86400)) then
			    	table.insert(sorted, v);
			    end
			    --Remove layerNum, it's local only. 
			    v.layerNum = nil;
			    --Create a bigger table than we send for sorting by timestamp and getting the last entries from.
				if (count >= entries * 2) then
					break;
				end
			end
		end
		table.sort(sorted, function(a, b) return a.timestamp > b.timestamp end);
		count = 0;
		--Get last few entries.
		for k, v in ipairs(sorted) do
			count = count + 1;
			data[k] = v;
			if (count >= entries) then
				break;
			end
		end
		local extra = {};
		for k, v in ipairs(data) do
			--Check if we left out any timers that didn't make it in the entries limit
			--but are a diff layer with matching type and close to matching timestamp
			--so we send pairs of matching layers as data.
			count = 0;
			for kk, vv in ipairs(sorted) do
				count = count + 1;
				--If count > entries then the data wasn't checked in sorted above so it's safe to check here.
				if (count > entries and v.timestamp < (vv.timestamp + 30) and v.timestamp > (vv.timestamp - 30)
						and v.layerID ~= vv.layerID) then
					table.insert(extra, vv);
				end
			end
		end
		if (next(extra)) then
			for k, v in ipairs(extra) do
				table.insert(data, v);
			end
		end
	end
	return data;
end

--For some reason timestamps sometimes get synced from 1 layer to another.
--Until I find why I'm going to check for this happening before sending and accepting data.
--This is not an ideal solution because maybe on rare occasions the same buff may drop on more than 1 layer at the same time.
function NWB:validateCloseTimestamps(layer, key, timestamp)
	if (NWB.sharedLayerBuffs and key == "rendTimer") then
		--If buffs are syncing on both layers then skip this check for rend (Blizzard hotfix enabled 23/7/2020).
		return true;
	end
	local offset = 30;
	if (string.match(key, "flower")) then
		offset = 10;
	end
	if (not timestamp) then
		--If no timestamp then we're creating data and just check them against out own timers.
		timestamp = NWB.data.layers[layer][key];
		for k, v in pairs(NWB.data.layers) do
			--Check other layers only.
			if (k ~= layer) then
				local diff = v[key] - timestamp;
				--Error reported this somehow was a string, very rare case but adding a check anyway, probably corrupted data.
				if (not tonumber(diff)) then
					NWB:debug("close tmestamp number fail", layer, key, timestamp);
					return;
				end
				--NWB:debug(k, diff);
				if (diff < offset and diff > -offset) then
					NWB:debug("Found matching timestamp", key, k, v[key], layer, timestamp);
					return;
				end
			end
		end
	else
		--If there is a timestamp then we're checking against the time we received from another player.
		for k, v in pairs(NWB.data.layers) do
			--Unlike above we have to check all layers here.
			local diff = v[key] - timestamp;
			if (diff < offset and diff > -offset) then
				--NWB:debug("Found matching timestamp2", key, k, v[key], layer, timestamp);
				return;
			end
		end
	end
	--NWB:debug("Passed validation", layer, key, timestamp);
	return true;
end

--Create settings for sending.
function NWB:createSettings(distribution)
	local data = {};
	if (UnitInBattleground("player") and distribution ~= "GUILD") then
		return data;
	end
	if (distribution == "GUILD") then
		local me = UnitName("player") .. "-" .. GetNormalizedRealmName();
		data[me] = {
			--["lastUpdate"] = GetServerTime(), 
			["disableAllGuildMsgs"] = NWB.db.global.disableAllGuildMsgs,
			["guildBuffDropped"] = NWB.db.global.guildBuffDropped,
			["guildNpcDialogue"] = NWB.db.global.guildNpcDialogue,
			["guildZanDialogue"] = NWB.db.global.guildZanDialogue,
			["guildNpcKilled"] = NWB.db.global.guildNpcKilled,
			["guildSongflower"] = NWB.db.global.guildSongflower,
			["guildCommand"] = NWB.db.global.guildCommand,
			["guild10"] = NWB.db.global.guild10,
			["guild1"] = NWB.db.global.guild1,
		};
	end
	--data['faction'] = NWB.faction;
	data = NWB:convertKeys(data, true, distribution);
	return data;
end

local validKeys = {
	["rendTimer"] = true,
	["rendTimerWho"] = true,
	["rendYell"] = true,
	["rendYell2"] = true,
	["rendSource"] = true,
	["onyTimer"] = true,
	["onyTimerWho"] = true,
	["onyYell"] = true,
	["onyYell2"] = true,
	["onySource"] = true,
	["onyNpcDied"] = true,
	["nefTimer"] = true,
	["nefTimerWho"] = true,
	["nefYell"] = true,
	["nefYell2"] = true,
	["nefSource"] = true,
	["nefNpcDied"] = true,
	["zanTimer"] = true,
	["zanTimerWho"] = true,
	["zanYell"] = true,
	["zanYell2"] = true,
	["zanSource"] = true,
	["flower1"] = true,
	["flower2"] = true,
	["flower3"] = true,
	["flower4"] = true,
	["flower5"] = true,
	["flower6"] = true,
	["flower7"] = true,
	["flower8"] = true,
	["flower9"] = true,
	["flower10"] = true,
	["tuber1"] = true,
	["tuber2"] = true,
	["tuber3"] = true,
	["tuber4"] = true,
	["tuber5"] = true,
	["tuber6"] = true,
	["dragon1"] = true,
	["dragon2"] = true,
	["dragon3"] = true,
	["dragon4"] = true,
	["faction"] = true,
	["GUID"] = true,
	["lastSeenNPC"] = true,
	["timerLog"] = true,
};

function NWB:extractSettings(dataReceived, sender, distribution)
	if (distribution ~= "GUILD") then
		return;
	end
	if (not dataReceived) then
		--NWB:debug("extractSettings no data received from:", sender);
		return;
	end
	local deserializeResult, data = NWB.serializer:Deserialize(dataReceived);
	if (not deserializeResult) then
		--Fall back to old deserializer if it's an old version.
		deserializeResult, data = NWB.serializerOld:Deserialize(dataReceived);
	end
	if (not deserializeResult) then
		--NWB:debug("Failed to deserialize extractSettings data.");
		return;
	end
	data = NWB:convertKeys(data, nil, distribution);
	local nameOnly, realm = strsplit("-", sender, 2);
	for k, v in pairs(data) do
		if (type(v) == "table" and string.match(k, nameOnly) and string.match(k, "%-") and next(v)) then
			--NWB:debug("Extracted settings from:", sender);
			NWB.data[k] = v;
		end
	end
end

--Add received data to our database.
--This is super ugly for layered stuff, but it's meant to work with all diff versions at once, will be cleaned up later.
function NWB:receivedData(dataReceived, sender, distribution)
	local deserializeResult, data = NWB.serializer:Deserialize(dataReceived);
	if (not deserializeResult) then
		--Fall back to old deserializer if it's an old version.
		deserializeResult, data = NWB.serializerOld:Deserialize(dataReceived);
	end
	if (not deserializeResult) then
		NWB:debug("Failed to deserialize data.");
		return;
	end
	--NWB:debug(data);
	data = NWB:convertKeys(data, nil, distribution);
	--NWB:debug(data);
	if (not data) then
		NWB:debug("bad hash result.");
		return;
	end
	--A faction check should not be needed but who knows what funky stuff can happen with the new yell channel and mind control etc.
	--if (not data['faction'] or data['faction'] ~= faction) then
	--	NWB:debug("data from opposite faction received", sender, distribution);
	--	return;
	--end
	if (not NWB:validateData(data)) then
		NWB:debug("invalid data received.");
		--NWB:debug(data);
		return;
	end
	if (data["rendTimer"] and tonumber(data["rendTimer"]) and (data["rendTimer"] < NWB.data["rendTimer"] or 
			(data["rendYell"] and data["rendYell"] < (data["rendTimer"] - 120)
			and data["rendYell2"] and data["rendYell2"] < (data["rendTimer"] - 120)))) then
		--Don't overwrite any data for this timer type if it's an old timer.
		if (data["rendYell"] < (data["rendTimer"] - 120) and data["rendYell2"] < (data["rendTimer"] - 120)) then
			--NWB:debug("invalid rend timer from", sender, "npcyell:", data["rendYell"], "buffdropped:", data["rendTimer"]);
		end
		data['rendTimer'] = nil;
		data['rendTimerWho'] = nil;
		data['rendYell'] = nil;
		data['rendYell2'] = nil;
		data['rendSource'] = nil;
	end
	if (data["onyTimer"] and tonumber(data["onyTimer"]) and (data["onyTimer"] < NWB.data["onyTimer"] or
			(data["onyYell"] and data["onyYell"] < (data["onyTimer"] - 120)
			and data["onyYell2"] and data["onyYell2"] < (data["onyTimer"] - 120)))) then
		if (data["onyYell"] < (data["onyTimer"] - 120) and data["onyYell2"] < (data["onyTimer"] - 120)) then
			--NWB:debug("invalid ony timer from", sender, "npcyell:", data["onyYell"], "buffdropped:", data["onyTimer"]);
		end
		data['onyTimer'] = nil;
		data['onyTimerWho'] = nil;
		data['onyYell'] = nil;
		data['onyYell2'] = nil;
		data['onySource'] = nil;
	end
	if (data["nefTimer"] and tonumber(data["nefTimer"]) and (data["nefTimer"] < NWB.data["nefTimer"] or
			(data["nefYell"] and data["nefYell"] < (data["nefTimer"] - 120)
			and data["nefYell2"] and data["nefYell2"] < (data["nefTimer"] - 120)))) then
		if (data["nefYell"] < (data["nefTimer"] - 120) and data["nefYell2"] < (data["nefTimer"] - 120)) then
			--NWB:debug("invalid nef timer from", sender, "npcyell:", data["nefYell"], "buffdropped:", data["nefTimer"]);
		end
		data['nefTimer'] = nil;
		data['nefTimerWho'] = nil;
		data['nefYell'] = nil;
		data['nefYell2'] = nil;
		data['nefSource'] = nil;
	end
	local hasNewData, newFlowerData;
	--Insert our layered data here.
	if (NWB.isLayered and data.layers) then
		--There's a lot of ugly shit in this function trying to quick fix timer bugs for this layered stuff...
		for layer, vv in NWB:pairsByKeys(data.layers) do
			--Temp fix, this can be removed soon.
			if (type(vv) ~= "table" or (((not vv["rendTimer"] or vv["rendTimer"] == 0) and (not vv["onyTimer"] or vv["onyTimer"] == 0)
					 and (not vv["nefTimer"] or vv["nefTimer"] == 0) and (not vv["onyNpcDied"] or vv["onyNpcDied"] == 0)
					  and (not vv["nefNpcDied"] or vv["nefNpcDied"] == 0) and (not vv["lastSeenNPC"] or vv["lastSeenNPC"] == 0))
					  or NWB.data.layersDisabled[layer])) then
				--Do nothing if all timers are 0, this is to fix a bug in last version with layerMaps causing old layer data
				--to bounce back and forth between users, making it so layers with no timers keep being created after server
				--restart and won't disappear.
				--Usually layers with no timers would not be sent, but because they contain the new layermaps now the table
				--isn't empty and gets sent, this has been corrected but old versions can still send data so we ignore it here.
				--This can be removed when we next ignore older versions.
			else
				if (type(vv) == "table" and next(vv)) then
					for localLayer, localV in pairs(NWB.data.layers) do
						--Quick fix for timestamps sometimes syncing between layers.
						--I think this may happen when someone is mid layer changing when the buff drops.
						--They get the buff in new layer but get old layers NPC GUID? Has to be tested.
						if (vv["rendTimer"] and localV["rendTimer"] and vv["rendTimer"] == localV["rendTimer"]
								and layer ~= localLayer) then
							--NWB:debug("ignoring duplicate rend timstamp", layer, vv["rendTimer"], localLayer, localV["rendTimer"]);
							vv['rendTimer'] = nil;
							vv['rendTimerWho'] = nil;
							vv['rendYell'] = nil;
							vv['rendYell2'] = nil;
							vv['rendSource'] = nil;
						end
						if (vv["onyTimer"] and localV["onyTimer"] and vv["onyTimer"] == localV["onyTimer"]
								and layer ~= localLayer) then
							--NWB:debug("ignoring duplicate ony timstamp", layer, vv["onyTimer"], localLayer, localV["onyTimer"]);
							vv['onyTimer'] = nil;
							vv['onyTimerWho'] = nil;
							vv['onyYell'] = nil;
							vv['onyYell2'] = nil;
							vv['onySource'] = nil;
							vv['onyNpcDied'] = nil;
						end
						if (vv["nefTimer"] and localV["nefTimer"] and vv["nefTimer"] == localV["nefTimer"]
								and layer ~= localLayer) then
							--NWB:debug("ignoring duplicate nef timstamp", layer, vv["nefTimer"], localLayer, localV["nefTimer"]);
							vv['nefTimer'] = nil;
							vv['nefTimerWho'] = nil;
							vv['nefYell'] = nil;
							vv['nefYell2'] = nil;
							vv['nefSource'] = nil;
							vv['nefNpcDied'] = nil;
						end
					end
					if (NWB:validateLayer(layer)) then
						if (not NWB.data.layers[layer]) then
							if (vv['GUID']) then
								NWB:createNewLayer(layer, vv['GUID']);
							else
								NWB:createNewLayer(layer, "other");
							end
							--NWB:debug(data.layers);
						end
						if (NWB.data.layers[layer]) then
							NWB:fixLayer(layer);
							--NWB:debug(data);
							if (vv["rendTimer"] and tonumber(data["rendTimer"]) 
									and (vv["rendTimer"] < (GetServerTime() - NWB.db.global.rendRespawnTime)
									--or not vv["rendYell"] or not vv["rendYell2"]
									--or (vv["rendYell"] < (vv["rendTimer"] - 120) and vv["rendYell2"] < (vv["rendTimer"] - 120)))) then
									or not vv["rendYell"]
									or (vv["rendYell"] < (vv["rendTimer"] - 120)))) then
								--Don't overwrite any data for this timer type if it's an old timer.
								--if (vv["rendYell"] < (vv["rendTimer"] - 120) and vv["rendYell2"] < (vv["rendTimer"] - 120)) then
									--NWB:debug("invalid rend timer from", sender, "npcyell:", vv["rendYell"], "npcyell2:", vv["rendYell2"], "buffdropped:", vv["rendTimer"]);
								--end
								vv['rendTimer'] = nil;
								vv['rendTimerWho'] = nil;
								vv['rendYell'] = nil;
								vv['rendYell2'] = nil;
								vv['rendSource'] = nil;
							end
							if (vv["onyTimer"] and tonumber(data["onyTimer"])
									and (vv["onyTimer"] < (GetServerTime() - NWB.db.global.onyRespawnTime)
									--or not vv["onyYell"] or not vv["onyYell2"]
									--or (vv["onyYell"] < (vv["onyTimer"] - 120) and vv["onyYell2"] < (vv["onyTimer"] - 120)))) then
									or not vv["onyYell"]
									or (vv["onyYell"] < (vv["onyTimer"] - 120)))) then
								--if (vv["onyYell"] < (vv["onyTimer"] - 120) and vv["onyYell2"] < (vv["onyTimer"] - 120)) then
									--NWB:debug("invalid ony timer from", sender, "npcyell:", vv["onyYell"], "npcyell2:", vv["onyYell2"], "buffdropped:", vv["onyTimer"]);
								--end
								vv['onyTimer'] = nil;
								vv['onyTimerWho'] = nil;
								vv['onyYell'] = nil;
								vv['onyYell2'] = nil;
								vv['onySource'] = nil;
								vv['onyNpcDied'] = nil;
							end
							if (vv["nefTimer"] and tonumber(data["nefTimer"])
									and (vv["nefTimer"] < (GetServerTime() - NWB.db.global.nefRespawnTime)
									--or not vv["nefYell"] or not vv["nefYell2"]
									--or (vv["nefYell"] < (vv["nefTimer"] - 120) and vv["nefYell2"] < (vv["nefTimer"] - 120)))) then
									or not vv["nefYell"]
									or (vv["nefYell"] < (vv["nefTimer"] - 120)))) then
								--if (vv["nefYell"] < (vv["nefTimer"] - 120) and vv["nefYell2"] < (vv["nefTimer"] - 120)) then
									--NWB:debug("invalid nef timer from", sender, "npcyell:", vv["nefYell"], "npcyell2:", vv["nefYell2"], "buffdropped:", vv["nefTimer"]);
								--end
								vv['nefTimer'] = nil;
								vv['nefTimerWho'] = nil;
								vv['nefYell'] = nil;
								vv['nefYell2'] = nil;
								vv['nefSource'] = nil;
								vv['nefNpcDied'] = nil;
							end
							for k, v in pairs(vv) do
								if (type(k) == "string" and (string.match(k, "flower") and NWB.db.global.syncFlowersAll)
										or (not NWB.db.global.receiveGuildDataOnly)
										or (NWB.db.global.receiveGuildDataOnly and distribution == "GUILD")) then
									if (validKeys[k] and tonumber(v)) then
										--If data is numeric (a timestamp) then check it's newer than our current timer.
										if (v ~= nil) then
											if (not NWB.data.layers[layer][k] or not tonumber(NWB.data.layers[layer][k])) then
												--Rare bug someone has corrupt data (not sure how and it's never happened to me, but been reported).
												--This will correct it by resetting thier timestamp to 0.
												NWB:debug("Local data error:", k, NWB.data[k]);
												NWB.data.layers[layer][k] = 0;
											end
											if (enableLogging) then
												NWB:timerLog(k, v, layer, nil, nil, distribution);
											end
											--Make sure the key exists, stop a lua error in old versions if we add a new timer type.
											if (NWB.data.layers[layer][k] and v ~= 0 and v > NWB.data.layers[layer][k] and NWB:validateTimestamp(v)) then
												--NWB:debug("new data", sender, distribution, k, v, "old:", NWB.data.layers[layer][k]);
												if (NWB.isLayered and string.match(k, "flower") and NWB.data.layers[layer][k]
														and (GetServerTime() - NWB.data.layers[layer][k]) < 1500) then
													--Don't overwrite songflower timers on layered realms.
												else
													if (string.match(k, "flower") and not (distribution == "GUILD"
														and (GetServerTime() - NWB.data.layers[layer][k]) > 15)) then
														newFlowerData = true;
													end
													NWB:timerLog(k, v, layer);
													if (NWB:validateCloseTimestamps(layer, k, v)) then
														NWB.data.layers[layer][k] = v;
														if (not string.match(k, "lastSeenNPC")) then
															hasNewData = true;
														end
														if (string.match(k, "flower")) then
															--Flowers can help layers persist when no other timers drop.
															--Update created timestamp for the removeOldLayers() func.
															NWB.data.layers[layer].created = GetServerTime();
														end
													else
														--NWB:debug("Rejecting data ", layer, k, v);
													end
												end
											end
										end
									elseif (k == "layerMap") then
										if (not NWB.data.layers[layer].layerMap) then
											NWB.data.layers[layer].layerMap = {};
										end
										for zoneID, mapID in pairs(v) do
											if (not NWB.data.layers[layer].layerMap[zoneID] and NWB.layerMapWhitelist[mapID]) then
												local skip;
												for k, v in pairs(NWB.data.layers) do
													if (v.layerMap and v.layerMap[zoneID]) then
														--If we already have this zoneid in any layer then don't overwrite it.
														skip = true;
													end
												end
												if (NWB:validateZoneID(zoneID, layer, mapID) and not skip) then
													NWB.data.layers[layer].layerMap[zoneID] = mapID;
												end
											end
										end
									elseif (v ~= nil and k ~= "layers") then
										if (not validKeys[k]) then
											--NWB:debug(data)
											NWB:debug("Invalid key received:", k, v);
										end
										--if (not validKeys[k] and not next(v)) then
										if (not validKeys[k] and type(v) ~= "table") then
											NWB:debug("Invalid key received2:", k, v);
										else
											NWB.data.layers[layer][k] = v;
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	for k, v in pairs(data) do
		--Not sure how it's possible for k to be anything but a string here but a rare error was reported.
		--bad argument #1 to 'match' (string expected, got table)
		if (type(k) == "string" and (string.match(k, "flower") and NWB.db.global.syncFlowersAll)
				or (not NWB.db.global.receiveGuildDataOnly)
				or (NWB.db.global.receiveGuildDataOnly and distribution == "GUILD")) then
			if (validKeys[k] and tonumber(v)) then
				--If data is numeric (a timestamp) then check it's newer than our current timer.
				if (v ~= nil) then
					if (not NWB.data[k] or not tonumber(NWB.data[k])) then
						--Rare bug someone has corrupt data (not sure how and it's never happened to me, but been reported).
						--This will correct it by resetting thier timestamp to 0.
						NWB:debug("Local data error:", k, NWB.data[k])
						NWB.data[k] = 0;
					end
					--Make sure the key exists, stop a lua error in old versions if we add a new timer type.
					if (NWB.data[k] and v ~= 0 and v > NWB.data[k] and NWB:validateTimestamp(v)) then
						if (NWB.isLayered and string.match(k, "flower") and (GetServerTime() - NWB.data[k]) < 1500) then
							--Don't overwrite songflower timers on layered realms.
						else
							--NWB:debug("new data", sender, distribution, k, v, "old:", NWB.data[k]);
							if (string.match(k, "flower") and not (distribution == "GUILD" and (GetServerTime() - NWB.data[k]) > 15)) then
								newFlowerData = true;
							end
							NWB.data[k] = v;
							hasNewData = true;
							if (not NWB.isLayered) then
								NWB:timerLog(k, v, nil, nil, nil, distribution);
							end
						end
					end
				end
			elseif (k == "timerLog") then
				if (enableLogging) then
					if (NWB:validateTimerLogData(v)) then
						--Sort from oldest to newest so we don't insert newer entries before old or some inserts may fail the time check.
						table.sort(v, function(a, b) return a.timestamp < b.timestamp end);
						for kk, vv in pairs(v) do
							NWB:timerLog(vv.type, vv.timestamp, vv.layerID, vv.who, nil, distribution);
						end
					end
				end
			elseif (v ~= nil and k ~= "layers") then
				if (not validKeys[k] and type(v) ~= "table") then
					NWB:debug("Invalid key received:", k, v);
				else
					NWB.data[k] = v;
				end
			end
		end
	end
	NWB:timerCleanup();
	--If we get newer data from someone outside the guild then share it with the guild.
	if (hasNewData and not NWB.cnRealms[NWB.realm] and not NWB.twRealms[NWB.realm] and not NWB.krRealms[NWB.realm]) then
		NWB.data.lastSyncBy = sender;
		--NWB:debug("new data received", sender, distribution, NWB:isPlayerInGuild(sender));
		if (distribution ~= "GUILD" and not NWB:isPlayerInGuild(sender)) then
			--NWB:debug("sending new data");
			--Don't send layermap or logs when sharing these new timers.
			NWB:sendData("GUILD", nil, nil, true, true);
		end
	end
	--If new flower data received and not freshly picked by guild member (that sends a msg to guild chat already)
	if (newFlowerData and NWB.db.global.showNewFlower) then
		--local string = "New songflower timer received:";
		local string = L["newSongflowerReceived"] .. ":";
		local found;
		for k, v in pairs(NWB.songFlowers) do
			local time = (NWB.data[k] + 1500) - GetServerTime();
			if (time > 60) then
				local minutes = string.format("%02.f", math.floor(time / 60));
    			local seconds = string.format("%02.f", math.floor(time - minutes * 60));
				string = string .. " (" .. v.subZone .. " " .. minutes .. L["minuteShort"] .. seconds .. L["secondShort"] .. ")";
				found = true;
  			end
		end
		if (not found) then
			string = string .. " " .. L["noActiveTimers"] .. ".";
		end
		NWB:print(string);
	end
end

function NWB:validateData(data)
	--For some reason on rare occasions a timer is received without the yell msg timetsamps (not even a default 0);
	--if (tonumber(data["rendTimer"]) and (not tonumber(data["rendYell"]) or not tonumber(data["rendYell2"]))) then
	if (tonumber(data["rendTimer"]) and (not tonumber(data["rendYell"]))) then
		return;
	end
	--if (tonumber(data["onyTimer"]) and (not tonumber(data["onyYell"]) or not tonumber(data["onyYell2"]))) then
	if (tonumber(data["onyTimer"]) and (not tonumber(data["onyYell"]))) then
		return;
	end
	--if (tonumber(data["nefTimer"]) and (not tonumber(data["nefYell"]) or not tonumber(data["nefYell2"]))) then
	if (tonumber(data["nefTimer"]) and (not tonumber(data["nefYell"]))) then
		return;
	end
	return true;
end

--Make sure each log entry has a valid timestamp so there's no lua errors when sorting data.
function NWB:validateTimerLogData(data)
	for k, v in pairs(data) do
		if (not v.timestamp or not tonumber(v.timestamp)) then
			return false;
		end
	end
	return true;
end

function NWB:versionCheck(remoteVersion)
	local lastVersionMsg = NWB.db.global.lastVersionMsg;
	if (tonumber(remoteVersion) > tonumber(version) and (GetServerTime() - lastVersionMsg) > 14400) then
		print(NWB.prefixColor .. L["versionOutOfDate"]);
		NWB.db.global.lastVersionMsg = GetServerTime();
	end
	if (tonumber(remoteVersion) > tonumber(version)) then
		NWB.latestRemoteVersion = remoteVersion;
	end
end

--Please Blizzard let us use compression libs for yell msgs, they get blocked by some filter only on the yell/say channel.
function NWB:yellTicker()
	local yellDelay = 600;
	if (NWB.cnRealms[NWB.realm] or NWB.twRealms[NWB.realm] or NWB.krRealms[NWB.realm]) then
		--If this is a Chinese realm then longer yell delay, chinese servers having issues because more layers, too much data sending.
		--I have plans to fix this, making db smaller etc.
		--Trying a lower yell interval on asian servers, we compress data much more now so it should be fine
		--Also this shorter interval may help a songflower timer issue there.
		yellDelay = 900;
	end
	--if (NWB.isLayered) then
		--Longer yell delay on high pop servers, no need for as many.
		--Increased to 10 minutes on layered realms.
		--yellDelay = 600;
	--end
	C_Timer.After(yellDelay, function()
		--Msg inside the timer so it doesn't send first tick at logon, player entering world does that.
		NWB:removeOldLayers();
		local inInstance, instanceType = IsInInstance();
		if (not UnitInBattleground("player") and not inInstance) then
			NWB:sendData("YELL");
		end
		NWB:yellTicker();
	end)
end

---Below are some functions to further compress the data we send.
---We convert the table keys into single character strings before sending and convert them back when receiving.
---We also hash the timestamps for yell channel where compression libs can't be used.
---Blizzard has some extra filter that blocks compression libs on yell channel.
---Not sure why there is this extra filtering on yell channels and not the other channels, possibly unintended?


--Key map to shorten with.
local shortKeys = {
	["a"] = "disableAllGuildMsgs",
	["b"] = "guildBuffDropped",
	["c"] = "guildNpcDialogue",
	["d"] = "guildZanDialogue",
	["e"] = "guildNpcKilled",
	["f"] = "guildSongflower",
	["g"] = "guildCommand",
	["h"] = "guild30",
	["i"] = "guild15",
	["j"] = "guild10",
	["k"] = "guild5",
	["l"] = "guild1",
	["m"] = "guild0",
	["n"] = "rendTimer",
	["o"] = "rendYell",
	["p"] = "rendYell2",
	["q"] = "rendTimerWho",
	["r"] = "rendSource",
	["s"] = "onyTimer",
	["t"] = "onyYell",
	["u"] = "onyYell2",
	["v"] = "onyTimerWho",
	["w"] = "onySource",
	["x"] = "onyNpcDied",
	["y"] = "nefTimer",
	["z"] = "nefYell",
	["A"] = "nefYell2",
	["B"] = "nefTimerWho",
	["C"] = "nefSource",
	["D"] = "nefNpcDied",
	["E"] = "lastSeenNPC",
	["F"] = "timerLog",
	["G"] = "type",
	["H"] = "timestamp",
	["I"] = "layerID",
	["J"] = "who",
	["f1"] = "flower1",
	["f2"] = "flower2",
	["f3"] = "flower3",
	["f4"] = "flower4",
	["f5"] = "flower5",
	["f6"] = "flower6",
	["f7"] = "flower7",
	["f8"] = "flower8",
	["f9"] = "flower9",
	["f10"] = "flower10",
	["t1"] = "tuber1",
	["t2"] = "tuber2",
	["t3"] = "tuber3",
	["t4"] = "tuber4",
	["t5"] = "tuber5",
	["t6"] = "tuber6",
	["d1"] = "dragon1",
	["d2"] = "dragon2",
	["d3"] = "dragon3",
	["d4"] = "dragon4",
};
local shortKeysReversed = {};
for k,v in pairs(shortKeys) do
	shortKeysReversed[v] = k;
end

--Huge thanks to Meowrawr for this.
local hashchars = "0123456789abcdefghijklmnopqrstuvwxyz"

local function tindex(t, v)
    for i = 1, #t do
        if t[i] == v then
            return i
        end
    end
end

local function epochToHash(n)
    local hash = ""
    while n > 0 do
        local i = math.floor(n % #hashchars) + 1
        hash = string.sub(hashchars, i, i) .. hash
        n = math.floor(n / #hashchars)
    end
    return hash
end

local function epochFromHash(s)
    local epoch = 0
    for i = 1, #s do
        local ch = string.sub(s, #s - i + 1, #s - i + 1)
        epoch = epoch + ((string.find(hashchars, ch) - 1) * ((#hashchars) ^ (i - 1)))
    end
    return epoch
end

--Keys with valid epoch tmestamps to convert.
local hashKeys = {
	["rendTimer"] = true,
	["rendYell"] = true,
	["rendYell2"] = true,
	["onyTimer"] = true,
	["onyYell"] = true,
	["onyYell2"] = true,
	["onyNpcDied"] = true,
	["nefTimer"] = true,
	["nefYell"] = true,
	["nefYell2"] = true,
	["nefNpcDied"] = true,
	["zanYell"] = true,
	["zanYell2"] = true,
	["lastSeenNPC"] = true,
	["flower1"] = true,
	["flower2"] = true,
	["flower3"] = true,
	["flower4"] = true,
	["flower5"] = true,
	["flower6"] = true,
	["flower7"] = true,
	["flower8"] = true,
	["flower9"] = true,
	["flower10"] = true,
	["tuber1"] = true,
	["tuber2"] = true,
	["tuber3"] = true,
	["tuber4"] = true,
	["tuber5"] = true,
	["tuber6"] = true,
	["dragon1"] = true,
	["dragon2"] = true,
	["dragon3"] = true,
	["dragon4"] = true,
};
local hashKeysReversed = {};
for k,v in pairs(hashKeys) do
	hashKeysReversed[v] = k;
end

--Recursively convert keys to small strings for sending over addon comms.
--And convert timestamps to a short hash (yell channel only because you can't use compression libs there).
--Set shorten to true for sending, false to expand after receiving.
--This shrinks my data by about 45%.
function NWB:convertKeys(table, shorten, distribution)
	if (type(table) ~= "table") then
		NWB:debug("no convertKeys table", table);
		return;
	end
	local keys = shortKeys;
	if (shorten) then
		keys = shortKeysReversed;
	end
	local data = {};
	for k, v in pairs(table) do
		if (type(v) == "table") then
			v = NWB:convertKeys(v, shorten, distribution);
		end
		if (distribution == "YELL") then
			if (shorten and hashKeys[k] and tonumber(v)) then
				---Hashing timestamps will be enabled in the next version once enough people have updated.
				---This will create errors on older versons.
				--If yell then convert timestamps to a smaller hash also.
				---(This should no longer be needed to be enabled in later version, now we have working compression for yell channel).
				--v = epochToHash(v);
			elseif (not shorten and hashKeys[keys[k]]) then
				--Convert back from hash if not shorten and is valid key.
				--Must be in both hashKeys and keys.
				if (not tonumber(v)) then
					--This double tonumber() check is here just to be compatable with the next version with hashing enabled.
					v = epochFromHash(v);
				end
				if (not tonumber(v)) then
					--If conversion fails for some reason return false.
					return;
				end
			end
		end
		if (keys[k]) then
			data[keys[k]] = v;
		else
			data[k] = v;
		end
	end
	return data;
end


---New log testing so rend history can be seen after the hotfix that broke timers.
--Timers are just inserted into the log so they are often out of order by timestamp.
--There are only a max of 3 timers per layer so as long as the total timers active on the server are less than the log trim it's fine.

--This was originally written to log all buffs, but I think only rend matters.
--There is a variable above logRendOnly enabled for now.
function NWB:timerLog(type, timestamp, layer, who, forceSend, distribution)
	if (not enableLogging) then
		return;
	end
	if (logLayeredServersOnly and not NWB.isLayered) then
		return;
	end
	--Logging directly from timers received come as the full rendTimer after convertKeys converts them to full name.
	--Logging pulled from other peoples logs comes as shorter keys to make data transmission smaller.
	if (type == "r") then
		type = "rendTimer";
	elseif (type == "o") then
		type = "onyTimer";
	elseif (type == "n") then
		type = "nefTimer";
	end
	--Allow through if rend timer, or if layered realm and other times are enabled, or any timer if non-layered realm.
	if (((type == "rendTimer" or type == "q") or ((not logRendOnly or not NWB.isLayered) and (type == "onyTimer" or type == "nefTimer")))
			and tonumber(timestamp)) then
		local newQuestHandIn;
		local shortKey;
		--Use short keys for data storage and data sharing.
		if (type == "rendTimer") then
			shortKey = "r";
		elseif (type == "onyTimer") then
			shortKey = "o";
		elseif (type == "nefTimer") then
			shortKey = "n";
		else
			shortKey = type;
		end
		local lastEntry = 0;
		for k, v in ipairs(NWB.data.timerLog) do
			--Get the last log entry for this type so we can make sure to not get any duplicate timestamps within a minute.
			if (v.type == shortKey and v.layerID == layer) then
				lastEntry = v.timestamp;
				break;
			end
		end
		local cooldown = 60;
		--if (type == "q") then
			--If it's a hand in make don't overwrite for almost as long as the 3h rend cooldown 10800 seconds.
		--	cooldown = 10600
		--end
		if (((NWB.data.layers[layer] and (NWB.data.layers[layer][type] or type == "q")) or (not NWB.isLayered and NWB.data[type]))
				--The data received isn't ordered by timestamp so we have to check if it's within cooldown both ways.
				--and (timestamp > (lastEntry + cooldown) or timestamp < (lastEntry - cooldown))
				--Ignore above, this was changed to sort when received instead.
				--and timestamp > (lastEntry + cooldown)
				and NWB:validateCloseLogEntries(shortKey, timestamp, layer, cooldown)
				and NWB:validateTimestamp(timestamp)) then
			local t = {
				type = shortKey,
				timestamp = timestamp,
			};
			if (who) then
				t.who = who;
			end
			if (layer) then
				t.layerID = layer;
			end
			if (NWB:GetLayerCount() > 1) then
				t.layerNum = NWB:GetLayerNum(layer);
			end
			table.insert(NWB.data.timerLog, 1, t);
			NWB:debug("logging", type, timestamp);
			if (type == "q") then
				--New quest hand in received, share with guild.
				newQuestHandIn = true;
			end
		end
		if ((distribution ~= "GUILD" and newQuestHandIn) or forceSend) then
			--Gather all the new log entries from a single receivedData event before pushing to guild.
			NWB:throddleEventByFunc("newLogData", 2, "sendNewTimeLogData");
			--NWB:sendTimerLogData("GUILD");
		end
	end
end

function NWB:validateCloseLogEntries(shortKey, timestamp, layer, cooldown)
	local count = 0;
	for k, v in ipairs(NWB.data.timerLog) do
		--Check the last few logs entry for this type so we can make sure to not get any duplicate timestamps within a minute.
		if (v.type == shortKey and (v.layerID == layer or not layer)) then
			count = count + 1;
			if (timestamp > (v.timestamp + cooldown) or timestamp < (v.timestamp - cooldown)) then
				--NWB:debug("safe");
			else
				--NWB:debug("unsafe")
				return false;
			end
			if (count >= 20) then
				break;
			end
		end
	end
	return true;
end

function NWB:sendNewTimeLogData()
	NWB:sendTimerLogData("GUILD");
end

--Run at logon.
function NWB:trimTimerLog()
	for i, v in pairs(NWB.data.timerLog) do
		if (i > 200) then
			table.remove(NWB.data.timerLog, i);
		elseif (not v.type or not v.timestamp or not v.layerID) then
			table.remove(NWB.data.timerLog, i);
		end
	end
end

function NWB:resetTimerLog()
	NWB.data.timerLog = {};
end

local NWBTimerLogFrame = CreateFrame("ScrollFrame", "NWBTimerLogFrame", UIParent, "InputScrollFrameTemplate");
NWBTimerLogFrame:Hide();
NWBTimerLogFrame:SetToplevel(true);
NWBTimerLogFrame:SetMovable(true);
NWBTimerLogFrame:EnableMouse(true);
tinsert(UISpecialFrames, "NWBTimerLogFrame");
NWBTimerLogFrame:SetPoint("CENTER", UIParent, 0, 100);
NWBTimerLogFrame:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8",insets = {top = 0, left = 0, bottom = 0, right = 0}});
NWBTimerLogFrame:SetBackdropColor(0,0,0,.5);
NWBTimerLogFrame.CharCount:Hide();
NWBTimerLogFrame:SetFrameStrata("HIGH");
NWBTimerLogFrame.EditBox:SetAutoFocus(false);
NWBTimerLogFrame.EditBox:SetScript("OnKeyDown", function(self, arg)
	--If control key is down keep focus for copy/paste to work.
	--Otherwise remove focus so "enter" can be used to open chat and not have a stuck cursor on this edit box.
	if (not IsControlKeyDown()) then
		NWBTimerLogFrame.EditBox:ClearFocus();
	end
end)
NWBTimerLogFrame.EditBox:SetScript("OnShow", function(self, arg)
	NWBTimerLogFrame:SetVerticalScroll(0);
end)
local versionUpdateTime = 0;
NWBTimerLogFrame:HookScript("OnUpdate", function(self, arg)
	--Only update once per second.
	if (GetServerTime() - versionUpdateTime > 0 and self:GetVerticalScrollRange() == 0) then
		NWB:recalclayerFrame();
		versionUpdateTime = GetServerTime();
	end
end)
NWBTimerLogFrame.fs = NWBTimerLogFrame:CreateFontString("NWBTimerLogFrameFS", "HIGH");
NWBTimerLogFrame.fs:SetPoint("TOP", 0, -0);
NWBTimerLogFrame.fs:SetFont(NWB.regionFont, 14);
NWBTimerLogFrame.fs:SetText("|cFFFFFF00NovaWorldBuffs Timer Log|r");

local NWBTimerLogDragFrame = CreateFrame("Frame", "NWBTimerLogDragFrame", NWBTimerLogFrame);
NWBTimerLogDragFrame:SetToplevel(true);
NWBTimerLogDragFrame:EnableMouse(true);
NWBTimerLogDragFrame:SetWidth(205);
NWBTimerLogDragFrame:SetHeight(18);
NWBTimerLogDragFrame:SetPoint("TOP", 0, 4);
NWBTimerLogDragFrame:SetFrameLevel(131);
NWBTimerLogDragFrame.tooltip = CreateFrame("Frame", "NWBTimerLogDragTooltip", NWBTimerLogDragFrame, "TooltipBorderedFrameTemplate");
NWBTimerLogDragFrame.tooltip:SetPoint("CENTER", NWBTimerLogDragFrame, "TOP", 0, 12);
NWBTimerLogDragFrame.tooltip:SetFrameStrata("TOOLTIP");
NWBTimerLogDragFrame.tooltip:SetFrameLevel(9);
NWBTimerLogDragFrame.tooltip:SetAlpha(.8);
NWBTimerLogDragFrame.tooltip.fs = NWBTimerLogDragFrame.tooltip:CreateFontString("NWBTimerLogDragTooltipFS", "HIGH");
NWBTimerLogDragFrame.tooltip.fs:SetPoint("CENTER", 0, 0.5);
NWBTimerLogDragFrame.tooltip.fs:SetFont(NWB.regionFont, 12);
NWBTimerLogDragFrame.tooltip.fs:SetText("Hold to drag");
NWBTimerLogDragFrame.tooltip:SetWidth(NWBTimerLogDragFrame.tooltip.fs:GetStringWidth() + 16);
NWBTimerLogDragFrame.tooltip:SetHeight(NWBTimerLogDragFrame.tooltip.fs:GetStringHeight() + 10);
NWBTimerLogDragFrame:SetScript("OnEnter", function(self)
	NWBTimerLogDragFrame.tooltip:Show();
end)
NWBTimerLogDragFrame:SetScript("OnLeave", function(self)
	NWBTimerLogDragFrame.tooltip:Hide();
end)
NWBTimerLogDragFrame.tooltip:Hide();
NWBTimerLogDragFrame:SetScript("OnMouseDown", function(self, button)
	if (button == "LeftButton" and not self:GetParent().isMoving) then
		self:GetParent().EditBox:ClearFocus();
		self:GetParent():StartMoving();
		self:GetParent().isMoving = true;
	end
end)
NWBTimerLogDragFrame:SetScript("OnMouseUp", function(self, button)
	if (button == "LeftButton" and self:GetParent().isMoving) then
		self:GetParent():StopMovingOrSizing();
		self:GetParent().isMoving = false;
	end
end)
NWBTimerLogDragFrame:SetScript("OnHide", function(self)
	if (self:GetParent().isMoving) then
		self:GetParent():StopMovingOrSizing();
		self:GetParent().isMoving = false;
	end
end)

--Top right X close button.
local NWBTimerLogFrameClose = CreateFrame("Button", "NWBTimerLogFrameClose", NWBTimerLogFrame, "UIPanelCloseButton");
NWBTimerLogFrameClose:SetPoint("TOPRIGHT", -5, 8.6);
NWBTimerLogFrameClose:SetWidth(31);
NWBTimerLogFrameClose:SetHeight(31);
NWBTimerLogFrameClose:SetScript("OnClick", function(self, arg)
	NWBTimerLogFrame:Hide();
end)

--Config button.
local NWBTimerLogRefreshButton = CreateFrame("Button", "NWBTimerLogRefreshButton", NWBTimerLogFrameClose, "UIPanelButtonTemplate");
NWBTimerLogRefreshButton:SetPoint("CENTER", -68, -1);
NWBTimerLogRefreshButton:SetWidth(90);
NWBTimerLogRefreshButton:SetHeight(17);
NWBTimerLogRefreshButton:SetText(L["Refresh"]);
NWBTimerLogRefreshButton:SetNormalFontObject("GameFontNormalSmall");
NWBTimerLogRefreshButton:SetScript("OnClick", function(self, arg)
	NWB:recalcTimerLogFrame();
	NWBTimerLogFrame:SetVerticalScroll(0);
	C_Timer.After(0.05, function()
		NWBTimerLogFrame:SetVerticalScroll(0);
	end)
	C_Timer.After(0.2, function()
		NWBTimerLogFrame:SetVerticalScroll(0);
	end)
end)
NWBTimerLogRefreshButton:SetScript("OnMouseDown", function(self, button)
	if (button == "LeftButton" and not self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent().EditBox:ClearFocus();
		self:GetParent():GetParent():StartMoving();
		self:GetParent():GetParent().isMoving = true;
	end
end)
NWBTimerLogRefreshButton:SetScript("OnMouseUp", function(self, button)
	if (button == "LeftButton" and self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent():StopMovingOrSizing();
		self:GetParent():GetParent().isMoving = false;
	end
end)
NWBTimerLogRefreshButton:SetScript("OnHide", function(self)
	if (self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent():StopMovingOrSizing();
		self:GetParent():GetParent().isMoving = false;
	end
end)

function NWB:openTimerLogFrame()
	if (not enableLogging) then
		return;
	end
	if (logLayeredServersOnly and not NWB.isLayered) then
		return;
	end
	NWBTimerLogFrame.fs:SetFont(NWB.regionFont, 14);
	if (NWBTimerLogFrame:IsShown()) then
		NWBTimerLogFrame:Hide();
	else
		if (not logRendOnly or not NWB.isLayered) then
			NWB:createTimerLogCheckboxes();
		else
			NWBTimerLogFrame.fs:SetText("|cFFFFFF00NovaWorldBuffs Rend Log|r");
		end
		NWB:createTimerLogMergeLayersCheckbox();
		NWBTimerLogFrame:SetHeight(300);
		NWBTimerLogFrame:SetWidth(590);
		local fontSize = false
		NWBTimerLogFrame.EditBox:SetFont(NWB.regionFont, 14);
		NWBTimerLogFrame.EditBox:SetWidth(NWBTimerLogFrame:GetWidth() - 30);
		NWBTimerLogFrame:Show();
		NWB:recalcTimerLogFrame();
		--Changing scroll position requires a slight delay.
		--Second delay is a backup.
		C_Timer.After(0.05, function()
			NWBTimerLogFrame:SetVerticalScroll(0);
		end)
		C_Timer.After(0.3, function()
			NWBTimerLogFrame:SetVerticalScroll(0);
		end)
		--So interface options and this frame will open on top of each other.
		if (InterfaceOptionsFrame:IsShown()) then
			NWBTimerLogFrame:SetFrameStrata("DIALOG")
		else
			NWBTimerLogFrame:SetFrameStrata("HIGH")
		end
	end
end

function NWB:setLayerFrameTimerLogButtonText()
	if (not NWBlayerFrameTimerLogButton) then
		return;
	end
	if (not logRendOnly or not NWB.isLayered) then
		NWBlayerFrameTimerLogButton:SetText("Timer Log");
	else
		NWBlayerFrameTimerLogButton:SetText("Rend Log");
	end
end

function NWB:recalcTimerLogFrame()
	NWBTimerLogFrame.EditBox:SetText("\n\n\n");
	if (type(NWB.data.timerLog) ~= "table" or not next(NWB.data.timerLog)) then
		NWBTimerLogFrame.EditBox:Insert("|cffFFFF00No timer logs found.\n");
	else
		local sorted = {}
		for k, v in ipairs(NWB.data.timerLog) do
		    table.insert(sorted, v)
		end
		table.sort(sorted, function(a, b) return a.timestamp > b.timestamp end);
		local text = "";
		local layers = {};
		local lineCount = 0;
		for k, v in ipairs(sorted) do
			if ((NWB.db.global.timerLogShowRend and (v.type == "r" or v.type == "q")) or
					(NWB.db.global.timerLogShowOny and v.type == "o" and (not logRendOnly or not NWB.isLayered)) or
					(NWB.db.global.timerLogShowNef and v.type == "n" and (not logRendOnly or not NWB.isLayered))) then
				local line = "";
				local layerText = "";
				local layerNumText = "";
				local layerNum = 0;
				if (NWB.isLayered) then
					layerNum = NWB:GetLayerNum(v.layerID);
				end
				if (layerNum == 0 and v.layerNum) then
					layerNum = v.layerNum;
				end
				local keyText = "unknownTimer";
				if (v.type == "r") then
					keyText = "|cffFFFF00Rend|r";
				elseif (v.type == "o") then
					keyText = "|cffFFFF00Onyxia|r";
				elseif (v.type == "n") then
					keyText = "|cffFFFF00Nefarian|r";
				elseif (v.type == "q") then
					keyText = "|cffFFFF00Rend handed in by " .. v.who .. "|r";
				end
				local timeText = NWB:getTimeFormat(v.timestamp, true, true);
				local space = "";
				local _, n = string.gsub(timeText, "%d", " ");
				if (n < 4) then
					--Make things line up a little better with shorter times.
					space = "  ";
				end
				local agoText = " |cff9CD6DE(Dropped "
						.. NWB:getTimeString(GetServerTime() - v.timestamp, true, NWB.db.global.timeStringType) .. " ago)|r";
				if (v.type == "q") then
					agoText = " |cff9CD6DE("
							.. NWB:getTimeString(GetServerTime() - v.timestamp, true, NWB.db.global.timeStringType) .. " ago)|r";
				end
				--If the next line is the same time within a few seconds and same drop type then merge the msgs together.
				if (NWB.db.global.timerLogMergeLayers and sorted[k + 1] and sorted[k + 1].timestamp
						and sorted[k + 1].layerID and sorted[k + 1].type == v.type
						and (sorted[k + 1].timestamp < (v.timestamp + 30) and sorted[k + 1].timestamp > (v.timestamp - 30))) then
					layers[layerNum] = true;
					layers[NWB:GetLayerNum(sorted[k + 1].layerID)] = true;
				elseif (NWB.db.global.timerLogMergeLayers and sorted[k + 2] and sorted[k + 2].timestamp
						and sorted[k + 2].layerID and sorted[k + 2].type == v.type
						and (sorted[k + 2].timestamp < (v.timestamp + 30) and sorted[k + 2].timestamp > (v.timestamp - 30))) then
					--Check the 2nd next in line also incase the first in line is a rend quest hand in event
					--in between the 2 diff layer rend drop timers.
					layers[layerNum] = true;
					layers[NWB:GetLayerNum(sorted[k + 2].layerID)] = true;
				else
					if (next(layers) and v.type ~= "q") then
						--Decided to scrap showing which layers it dropped on and just call it "All Layers".
						--[[local layerString = "";
						local layerStringCount = 0;
						for k, v in NWB:pairsByKeys(layers) do
							layerStringCount = layerStringCount + 1;
							if (layerStringCount == 1) then
								layerString = layerString .. k .. "";
							else
								layerString = layerString .. "+" .. k;
							end
						end
						layerText = "|cff00ff00[Layers " .. layerString .. "]|r ";]]
						layerText = "|cff00ff00[All Layers]|r ";
						layers = {};
					elseif (NWB.isLayered) then
						layerText = "|cff00ff00[Layer " .. layerNum .. "]|r ";
					end
					local timeLeftString = "";
					if (v.type == "r") then
						local timeLeft = NWB.db.global.rendRespawnTime - (GetServerTime() - v.timestamp);
						if (timeLeft > 0) then
							timeLeftString = " |cFFB0B0B0(Cooldown " .. NWB:getTimeString(timeLeft, true, "short", true) .. ")|r";
						end
					end
					if (v.type == "q") then
						layerNumText = "|cFF989898(zone " .. v.layerID .. ")|r ";
					end
					lineCount = lineCount + 1;
					line = lineCount .. ") |cFFFFAE42" .. timeText .. space .. "|r " .. layerText .. layerNumText .. keyText
						.. agoText .. timeLeftString .. "\n";
					text = text .. line;
					--layers = {};
				end
			end
		end
		NWBTimerLogFrame.EditBox:Insert(text);
	end
end

local f = CreateFrame("Frame");
NWB.rendHandIn = nil;
NWB.rendHandInTime = 0;
f:RegisterEvent("QUEST_TURNED_IN");
f:SetScript('OnEvent', function(self, event, ...)
	if (event == "QUEST_TURNED_IN") then
		--if (logLayeredServersOnly and not NWB.isLayered) then
		--No need to log hand in data on non-layered realms.
		if (not enableLogging or not NWB.isLayered) then
			return;
		end
		local questID = ...;
		if (questID == 4974) then
			local GUID = UnitGUID("npc");
			local unitType, zoneID, npcID;
			if (GUID) then
				unitType, _, _, _, zoneID, npcID = strsplit("-", GUID);
			end
			zoneID = tonumber(zoneID);
			if (zoneID) then
				NWB.rendHandIn = zoneID;
				NWB.rendHandInTime = GetServerTime();
				--If we hand in and a yell comes within the next 15 seconds record an entry.
				C_Timer.After(20, function()
					NWB:debug("clearing quest hand in data", NWB.rendHandIn, NWB.rendHandInTime);
					NWB.rendHandIn = nil
					NWB.rendHandInTime = 0;
				end)
			end
		end
	end
end)

function NWB:createTimerLogCheckboxes()
	if (not NWB.timerLogShowRendButton) then
		NWB.timerLogShowRendButton = CreateFrame("CheckButton", "NWBtimerLogShowRendButton", NWBTimerLogFrame.EditBox, "ChatConfigCheckButtonTemplate");
		NWB.timerLogShowRendButton:SetPoint("TOPLEFT", 5, -16);
		--So strange the way to set text is to append Text to the global frame name.
		NWBtimerLogShowRendButtonText:SetText("Show Rend");
		NWB.timerLogShowRendButton.tooltip = "Show Rend drops?";
		NWB.timerLogShowRendButton:SetFrameStrata("HIGH");
		NWB.timerLogShowRendButton:SetFrameLevel(3);
		NWB.timerLogShowRendButton:SetWidth(24);
		NWB.timerLogShowRendButton:SetHeight(24);
		NWB.timerLogShowRendButton:SetChecked(NWB.db.global.timerLogShowRend);
		NWB.timerLogShowRendButton:SetScript("OnClick", function()
			local value = NWB.timerLogShowRendButton:GetChecked();
			NWB.db.global.timerLogShowRend = value;
			NWB:recalcTimerLogFrame()
			--Refresh the config page.
			NWB.acr:NotifyChange("NovaWorldBuffs");
		end)
	end
	if (not NWB.timerLogShowOnyButton) then
		NWB.timerLogShowOnyButton = CreateFrame("CheckButton", "NWBtimerLogShowOnyButton", NWBTimerLogFrame.EditBox, "ChatConfigCheckButtonTemplate");
		NWB.timerLogShowOnyButton:SetPoint("TOPLEFT", 110, -16);
		--So strange the way to set text is to append Text to the global frame name.
		NWBtimerLogShowOnyButtonText:SetText("Show Ony");
		NWB.timerLogShowOnyButton.tooltip = "Show Onyxia drops?";
		NWB.timerLogShowOnyButton:SetFrameStrata("HIGH");
		NWB.timerLogShowOnyButton:SetFrameLevel(4);
		NWB.timerLogShowOnyButton:SetWidth(24);
		NWB.timerLogShowOnyButton:SetHeight(24);
		NWB.timerLogShowOnyButton:SetChecked(NWB.db.global.timerLogShowOny);
		NWB.timerLogShowOnyButton:SetScript("OnClick", function()
			local value = NWB.timerLogShowOnyButton:GetChecked();
			NWB.db.global.timerLogShowOny = value;
			NWB:recalcTimerLogFrame()
			--Refresh the config page.
			NWB.acr:NotifyChange("NovaWorldBuffs");
		end)
	end
	if (not NWB.timerLogShowNefButton) then
		NWB.timerLogShowNefButton = CreateFrame("CheckButton", "NWBtimerLogShowNefButton", NWBTimerLogFrame.EditBox, "ChatConfigCheckButtonTemplate");
		NWB.timerLogShowNefButton:SetPoint("TOPLEFT", 215, -16);
		--So strange the way to set text is to append Text to the global frame name.
		NWBtimerLogShowNefButtonText:SetText("Show Nef");
		NWB.timerLogShowNefButton.tooltip = "Show Nefarian drops?";
		NWB.timerLogShowNefButton:SetFrameStrata("HIGH");
		NWB.timerLogShowNefButton:SetFrameLevel(5);
		NWB.timerLogShowNefButton:SetWidth(24);
		NWB.timerLogShowNefButton:SetHeight(24);
		NWB.timerLogShowNefButton:SetChecked(NWB.db.global.timerLogShowNef);
		NWB.timerLogShowNefButton:SetScript("OnClick", function()
			local value = NWB.timerLogShowNefButton:GetChecked();
			NWB.db.global.timerLogShowNef = value;
			NWB:recalcTimerLogFrame()
			--Refresh the config page.
			NWB.acr:NotifyChange("NovaWorldBuffs");
		end)
	end
end

function NWB:createTimerLogMergeLayersCheckbox()
	if (not NWB.timerLogMergeLayersButton) then
		NWB.timerLogMergeLayersButton = CreateFrame("CheckButton", "NWBtimerLogMergeLayersButton", NWBTimerLogFrame.EditBox, "ChatConfigCheckButtonTemplate");
		NWB.timerLogMergeLayersButton:SetPoint("TOPLEFT", 5, 0);
		--So strange the way to set text is to append Text to the global frame name.
		NWBtimerLogMergeLayersButtonText:SetText("Merge Layers");
		NWB.timerLogMergeLayersButton.tooltip = "If multiple layers have the same timer this will merge them into [All Layers] instead of showing them separately.";
		NWB.timerLogMergeLayersButton:SetFrameStrata("HIGH");
		NWB.timerLogMergeLayersButton:SetFrameLevel(3);
		NWB.timerLogMergeLayersButton:SetWidth(24);
		NWB.timerLogMergeLayersButton:SetHeight(24);
		NWB.timerLogMergeLayersButton:SetChecked(NWB.db.global.timerLogMergeLayers);
		NWB.timerLogMergeLayersButton:SetScript("OnClick", function()
			local value = NWB.timerLogMergeLayersButton:GetChecked();
			NWB.db.global.timerLogMergeLayers = value;
			NWB:recalcTimerLogFrame()
			--Refresh the config page.
			NWB.acr:NotifyChange("NovaWorldBuffs");
		end)
	end
end

function NWB:createLayerFrameTimerLogButton()
	if (enableLogging and (not logLayeredServersOnly or NWB.isLayered)) then
		--Timer log button.
		local NWBlayerFrameTimerLogButton = CreateFrame("Button", "NWBlayerFrameTimerLogButton", NWBlayerFrameClose, "UIPanelButtonTemplate");
		NWBlayerFrameTimerLogButton:SetPoint("CENTER", -58, -42);
		NWBlayerFrameTimerLogButton:SetWidth(90);
		NWBlayerFrameTimerLogButton:SetHeight(17);
		NWBlayerFrameTimerLogButton:SetText("Timer Log");
		NWBlayerFrameTimerLogButton:SetNormalFontObject("GameFontNormalSmall");
		NWBlayerFrameTimerLogButton:SetScript("OnClick", function(self, arg)
			NWB:openTimerLogFrame();
		end)
		NWBlayerFrameTimerLogButton:SetScript("OnMouseDown", function(self, button)
			if (button == "LeftButton" and not self:GetParent():GetParent().isMoving) then
				self:GetParent():GetParent().EditBox:ClearFocus();
				self:GetParent():GetParent():StartMoving();
				self:GetParent():GetParent().isMoving = true;
			end
		end)
		NWBlayerFrameTimerLogButton:SetScript("OnMouseUp", function(self, button)
			if (button == "LeftButton" and self:GetParent():GetParent().isMoving) then
				self:GetParent():GetParent():StopMovingOrSizing();
				self:GetParent():GetParent().isMoving = false;
			end
		end)
		NWBlayerFrameTimerLogButton:SetScript("OnHide", function(self)
			if (self:GetParent():GetParent().isMoving) then
				self:GetParent():GetParent():StopMovingOrSizing();
				self:GetParent():GetParent().isMoving = false;
			end
		end)
	end
end

--Throddle by function name, delays functions being run until it's finished being called within a time period.
--Used mostly to supress data syncing until all data is gathered and ready to be sent in one go.
local throddle = true;
NWB.currentThroddles = {};
function NWB:throddleEventByFunc(event, time, func, ...)
	if (throddle and NWB.currentThroddles[func] == nil) then
		--Must be false and not nil.
		NWB.currentThroddles[func] = ... or false;
		C_Timer.After(time, function()
			self[func](self, NWB.currentThroddles[func]);
			NWB.currentThroddles[func] = nil;
		end)
	elseif (not throddle) then
		self[func](...);
	end
end

--Disabled on asian realms with higher layer counts until this is tested properly on the US/EU 2 layer limit realms.
function NWB:setLoggingState()
	if (NWB.cnRealms[NWB.realm] or NWB.twRealms[NWB.realm] or NWB.krRealms[NWB.realm]) then
		enableLogging = false;
	end
end