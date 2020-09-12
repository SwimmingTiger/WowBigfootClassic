--------------------
--Nova World Buffs--
--Novaspark-Arugal OCE (classic).
--https://www.curseforge.com/members/venomisto/projects
--Note: Server restarts will cause the timers to be inaccurate because the NPC's reset.

NWB = LibStub("AceAddon-3.0"):NewAddon("NovaWorldBuffs", "AceComm-3.0");
NWB.LSM = LibStub("LibSharedMedia-3.0");
NWB.dragonLib = LibStub("HereBeDragons-2.0");
NWB.dragonLibPins = LibStub("HereBeDragons-Pins-2.0");
NWB.commPrefix = "NWB";
NWB.hasAddon = {};
NWB.realm = GetRealmName();
NWB.faction = UnitFactionGroup("player");
NWB.loadTime = 0;
NWB.limitLayerCount = 99;
NWB.sharedLayerBuffs = true;
NWB.doLayerMsg = false;
NWB.noGUID = false;
NWB.serializer = LibStub:GetLibrary("LibSerialize");
NWB.serializerOld = LibStub:GetLibrary("AceSerializer-3.0");
NWB.libDeflate = LibStub:GetLibrary("LibDeflate");
NWB.acr = LibStub:GetLibrary("AceConfigRegistry-3.0");
local L = LibStub("AceLocale-3.0"):GetLocale("NovaWorldBuffs");
local LDB = LibStub:GetLibrary("LibDataBroker-1.1");
NWB.LDBIcon = LibStub("LibDBIcon-1.0");
local version = GetAddOnMetadata("NovaWorldBuffs", "Version") or 9999;
NWB.latestRemoteVersion = version;
NWB.prefixColor = "|cFFFF6900";

--Some notes on the change Blizzard just implemented to make layers share buffs.
--The buff drop only works on both layers if each layer NPC is reset.
--If a NPC dies on one layer and drop a buff it breaks thr sync for the rest of the week or until no buffs are dropped for a long time on both.
--We're still tracking drops for both layers incase a NPC is killed.

function NWB:OnInitialize()
	self:setLayered();
	self:setLayeredSongflowers();
	self:setLayerLimit();
	self:loadSpecificOptions();
    self.db = LibStub("AceDB-3.0"):New("NWBdatabase", NWB.optionDefaults, "Default");
    LibStub("AceConfig-3.0"):RegisterOptionsTable("NovaWorldBuffs", NWB.options);
	self.NWBOptions = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("NovaWorldBuffs", "NovaWorldBuffs");
	self.chatColor = "|cff" .. self:RGBToHex(self.db.global.chatColorR, self.db.global.chatColorG, self.db.global.chatColorB);
	self.prefixColor = "|cff" .. self:RGBToHex(self.db.global.prefixColorR, self.db.global.prefixColorG, self.db.global.prefixColorB);
	self.mmColor = "|cff" .. self:RGBToHex(self.db.global.mmColorR, self.db.global.mmColorG, self.db.global.mmColorB);
	self:RegisterComm(self.commPrefix);
	self:registerSounds();
	self.loadTime = GetServerTime();
	self:registerOtherAddons();
	self:buildRealmFactionData();
	self:setRegionFont();
	self:fixAllLayers();
	self:timerCleanup();
	self:setSongFlowers();
	self:createSongflowerMarkers();
	self:createTuberMarkers();
	self:createDragonMarkers();
	self:refreshFelwoodMarkers();
	self:createWorldbuffMarkersTable();
	self:createWorldbuffMarkers();
	self:getDmfData();
	self:createDmfMarkers();
	self:resetSongFlowers();
	self:resetLayerData();
	self:resetLayerMaps();
	self:removeOldLayers();
	self:ticker();
	self:yellTicker();
	self:createBroker();
	self:convertSettings();
	self:setLoggingState();
	self:trimTimerLog();
	self:createLayerFrameTimerLogButton();
end

--Set font used in fontstrings on frames.
NWB.regionFont = "Fonts\\ARIALN.ttf";
function NWB:setRegionFont()
	if (LOCALE_koKR) then
     	NWB.regionFont = "Fonts\\2002.TTF";
    elseif (LOCALE_zhCN) then
     	NWB.regionFont = "Fonts\\ARKai_T.ttf";
    elseif (LOCALE_zhTW) then
     	NWB.regionFont = "Fonts\\blei00d.TTF";
    elseif (LOCALE_ruRU) then
    	--ARIALN seems to work in RU.
     	--NWB.regionFont = "Fonts\\FRIZQT___CYR.TTF";
    end
end
NWB:setRegionFont();

--Print current buff timers to chat window.
function NWB:printBuffTimers(isLogon)
	local msg;
	if (NWB.faction == "Horde" or NWB.db.global.allianceEnableRend) then
		if (NWB.data.rendTimer > (GetServerTime() - NWB.db.global.rendRespawnTime)) then
			msg = L["rend"] .. ": " .. NWB:getTimeString(NWB.db.global.rendRespawnTime - (GetServerTime() - NWB.data.rendTimer), true) .. ".";
			if (NWB.db.global.showTimeStamp) then
				local timeStamp = NWB:getTimeFormat(NWB.data.rendTimer + NWB.db.global.rendRespawnTime);
				msg = msg .. " (" .. timeStamp .. ")";
			end
		else
			msg = L["rend"] .. ": " .. L["noCurrentTimer"] .. ".";
		end
		if ((not isLogon or NWB.db.global.logonRend) and not NWB.isLayered) then
			NWB:print("|HNWBCustomLink:timers|h" .. msg .. "|h");
		end
	end
	if ((NWB.data.onyNpcDied > NWB.data.onyTimer) and
			(NWB.data.onyNpcDied > (GetServerTime() - NWB.db.global.onyRespawnTime))) then
		if (NWB.faction == "Horde") then
			msg = string.format(L["onyxiaNpcKilledHordeWithTimer"], NWB:getTimeString(GetServerTime() - NWB.data.onyNpcDied, true));
		else
			msg = string.format(L["onyxiaNpcKilledAllianceWithTimer"], NWB:getTimeString(GetServerTime() - NWB.data.onyNpcDied, true));
		end
	elseif (NWB.data.onyTimer > (GetServerTime() - NWB.db.global.onyRespawnTime)) then
		msg = L["onyxia"] .. ": " .. NWB:getTimeString(NWB.db.global.onyRespawnTime - (GetServerTime() - NWB.data.onyTimer), true) .. ".";
		if (NWB.db.global.showTimeStamp) then
			local timeStamp = NWB:getTimeFormat(NWB.data.onyTimer + NWB.db.global.onyRespawnTime);
			msg = msg .. " (" .. timeStamp .. ")";
		end
	else
		msg = L["onyxia"] .. ": " .. L["noCurrentTimer"] .. ".";
	end
	if ((not isLogon or NWB.db.global.logonOny) and not NWB.isLayered) then
		NWB:print("|HNWBCustomLink:timers|h" .. msg .. "|h");
	end
	if ((NWB.data.nefNpcDied > NWB.data.nefTimer) and
			(NWB.data.nefNpcDied > (GetServerTime() - NWB.db.global.nefRespawnTime))) then
		if (NWB.faction == "Horde") then
			msg = string.format(L["nefarianNpcKilledHordeWithTimer"], NWB:getTimeString(GetServerTime() - NWB.data.nefNpcDied, true));
		else
			msg = string.format(L["nefarianNpcKilledAllianceWithTimer"], NWB:getTimeString(GetServerTime() - NWB.data.nefNpcDied, true));
		end
	elseif (NWB.data.nefTimer > (GetServerTime() - NWB.db.global.nefRespawnTime)) then
		msg = L["nefarian"] .. ": " .. NWB:getTimeString(NWB.db.global.nefRespawnTime - (GetServerTime() - NWB.data.nefTimer), true) .. ".";
		if (NWB.db.global.showTimeStamp) then
			local timeStamp = NWB:getTimeFormat(NWB.data.nefTimer + NWB.db.global.nefRespawnTime);
			msg = msg .. " (" .. timeStamp .. ")";
		end
	else
		msg = L["nefarian"] .. ": " .. L["noCurrentTimer"] .. ".";
	end
	if ((not isLogon or NWB.db.global.logonNef) and not NWB.isLayered) then
		NWB:print("|HNWBCustomLink:timers|h" .. msg .. "|h");
	end
	if (NWB.isLayered) then
		NWB:print("|HNWBCustomLink:timers|h"..L["You are on a layered realm."].."|h");
		NWB:print("|HNWBCustomLink:timers|h"..L["Click here to view current timers."].."|h");
	end
	local timestamp, timeLeft, type = NWB:getDmfData();
	--if ((NWB.db.global.showDmfLogon and isLogon) or NWB.db.global.showDmfWb
	--		or (NWB.db.global.showDmfWhenClose and (timeLeft > 0 and timeLeft < 43200))) then
	if ((isLogon and NWB.db.global.logonDmfSpawn and (timeLeft > 0 and timeLeft < 21600)) or
		(not isLogon and NWB.db.global.showDmfWb)) then	
		local zone;
		if (NWB.dmfZone == "Mulgore") then
			zone = L["mulgore"];
		else
			zone = L["elwynnForest"];
		end
		msg = NWB:getDmfTimeString() .. " (" .. zone .. ")";
		NWB:print("|HNWBCustomLink:timers|h" .. msg .. "|h", nil, "[DMF]");
	end
	if (NWB.isDmfUp and NWB.data.myChars[UnitName("player")].buffs) then
		for k, v in pairs(NWB.data.myChars[UnitName("player")].buffs) do
			if (v.type == "dmf" and (v.timeLeft + 7200) > 0) then
				msg = string.format(L["dmfBuffCooldownMsg"], NWB:getTimeString(v.timeLeft + 7200, true));
				if ((not isLogon and NWB.db.global.showDmfBuffWb) or NWB.db.global.logonDmfBuffCooldown) then
					NWB:print("|HNWBCustomLink:timers|h" .. msg .. "|h", nil, "[DMF]");
				end
				break;
			end
		end
	end
end

--Single line buff timers.
function NWB:getShortBuffTimers(channel, layerNum)
	local msg = "";
	local dataPrefix, layer;
	local count = 0;
	local doShortestPerBuff;
	if (NWB.isLayered) then
		for k, v in NWB:pairsByKeys(NWB.data.layers) do
			count = count + 1;
			if (not layerNum and count == 1) then
				--If there's no layer specified then get the shortest timer for each buff separately.
				doShortestPerBuff = true;
				--Get first layer if no layer specified (as a backup).
				layer = k;
				break;
			elseif (count == tonumber(layerNum)) then
				layer = k;
			end
		end
		--if (not layerNum and NWB.isLayered and NWB:GetLayerCount() == 2 and NWB.lastKnownLayerMapID and NWB.lastKnownLayerMapID > 0
		--		and NWB.lastKnownLayer and NWB.lastKnownLayer > 0) then
		--	layerNum = NWB.lastKnownLayer;
		--	layer = NWB.lastKnownLayerID;
		--end
		--if (channel == "guildCommand" and not layerNum) then
		--	layer, layerNum = NWB:getShortestTimerLayer("city");
		--end
		if (layerNum and not layer) then
			return "That layer wasn't found or has no valid timers.";
		end
		dataPrefix = NWB.data.layers[layer];
		if (not dataPrefix and not layerNum) then
			msg = "(" .. L["rend"] .. ": " .. L["noTimer"] .. ") ";
			msg = msg .. "(" .. L["onyxia"] .. ": " .. L["noTimer"] .. ") ";
			msg = msg .. "(" .. L["nefarian"] .. ": " .. L["noTimer"] .. ") ";
			msg = msg .. L["(No layers found)"];
			return msg;
		end
	else
		dataPrefix = NWB.data;
	end
	if (not dataPrefix and not doShortestPerBuff) then
		return L["No timers found."]
	end
	local shortLayerMsg = "";
	--[[if (doShortestPerBuff) then
		local layer, layerNum = NWB:getShortestTimerLayerBuff("rend");
		if (layer > 0) then
			dataPrefix = NWB.data.layers[layer];
			--shortLayerMsg = " [L" .. layerNum .. "]";
		end
	end]]
	if (NWB.faction == "Horde" or NWB.db.global.allianceEnableRend) then
		if (dataPrefix.rendTimer > (GetServerTime() - NWB.db.global.rendRespawnTime)) then
			msg = "(" .. L["rend"] .. ": " .. NWB:getTimeString(NWB.db.global.rendRespawnTime - (GetServerTime() - dataPrefix.rendTimer), true) .. shortLayerMsg .. ") ";
		else
			msg = "(" .. L["rend"] .. ": " .. L["noTimer"] .. shortLayerMsg .. ") ";
		end
	end
	shortLayerMsg = "";
	if (doShortestPerBuff) then
		local layer, layerNum = NWB:getShortestTimerLayerBuff("ony");
		if (layer > 0) then
			dataPrefix = NWB.data.layers[layer];
			shortLayerMsg = " [L" .. layerNum .. "]";
		end
	end
	if ((dataPrefix.onyNpcDied > dataPrefix.onyTimer) and
			(dataPrefix.onyNpcDied > (GetServerTime() - NWB.db.global.onyRespawnTime))) then
		if (NWB.faction == "Horde") then
			msg = msg .. L["(Onyxia: NPC (Runthak) was killed "] .. NWB:getTimeString(GetServerTime() - dataPrefix.onyNpcDied, true) 
					.. L[" ago no buff recorded since"] .. shortLayerMsg .. ") ";
		else
			msg = msg .. L["(Onyxia: NPC (Mattingly) was killed "] .. NWB:getTimeString(GetServerTime() - dataPrefix.onyNpcDied, true) 
					.. L[" ago no buff recorded since"] .. shortLayerMsg .. ") ";
		end
	elseif (dataPrefix.onyTimer > (GetServerTime() - NWB.db.global.onyRespawnTime)) then
		msg = msg .. "(" .. L["onyxia"] .. ": " .. NWB:getTimeString(NWB.db.global.onyRespawnTime - (GetServerTime() - dataPrefix.onyTimer), true) .. shortLayerMsg .. ") ";
	else
		msg = msg .. "(" .. L["onyxia"] .. ": " .. L["noTimer"] .. shortLayerMsg .. ") ";
	end
	shortLayerMsg = "";
	if (doShortestPerBuff) then
		local layer, layerNum = NWB:getShortestTimerLayerBuff("nef");
		if (layer > 0) then
			dataPrefix = NWB.data.layers[layer];
			shortLayerMsg = " [L" .. layerNum .. "]";
		end
	end
	if ((dataPrefix.nefNpcDied > dataPrefix.nefTimer) and
			(dataPrefix.nefNpcDied > (GetServerTime() - NWB.db.global.nefRespawnTime))) then
		if (NWB.faction == "Horde") then
			msg = msg .. L["(Nefarian: NPC (Saurfang) was killed "] .. NWB:getTimeString(GetServerTime() - dataPrefix.nefNpcDied, true) 
					.. L[" ago no buff recorded since"] .. shortLayerMsg .. ")";
		else
			msg = msg .. L["(Nefarian: NPC (Afrasiabi) was killed "] .. NWB:getTimeString(GetServerTime() - dataPrefix.nefNpcDied, true) 
					.. L[" ago no buff recorded since"] .. shortLayerMsg .. ")";
		end
	elseif (dataPrefix.nefTimer > (GetServerTime() - NWB.db.global.nefRespawnTime)) then
		msg = msg .. "(" .. L["nefarian"] .. ": " .. NWB:getTimeString(NWB.db.global.nefRespawnTime - (GetServerTime() - dataPrefix.nefTimer), true) .. ")";
	else
		msg = msg .. "(" .. L["nefarian"] .. ": " .. L["noTimer"] .. shortLayerMsg .. ")";
	end
	if (layerNum and not doShortestPerBuff) then
		return msg .. L[" (Layer "] .. layerNum .. L[" of "] .. count .. ")";
	elseif (NWB.isLayered and not doShortestPerBuff) then
		return msg .. L[" (Layer 1 of "] .. count .. ")";
	end
	return msg;
end

--Prefixes are clickable in chat to open buffs frame.
function NWB.addClickLinks(self, event, msg, author, ...)
	local types;
	if (NWB.db.global.colorizePrefixLinks) then
		types = {
			["%[WorldBuffs%]"] = NWB.prefixColor .. "|HNWBCustomLink:buffs|h[WorldBuffs]|h|r",
			["%[NovaWorldBuffs%]"] = NWB.prefixColor .. "|HNWBCustomLink:buffs|h[NovaWorldBuffs]|h|r",
			["%[DMF%]"] = NWB.prefixColor .. "|HNWBCustomLink:buffs|h[DMF]|h|r",
		}
	else
		types = {
			["%[WorldBuffs%]"] = "|HNWBCustomLink:buffs|h[WorldBuffs]|h",
			["%[NovaWorldBuffs%]"] = "|HNWBCustomLink:buffs|h[NovaWorldBuffs]|h",
			["%[DMF%]"] = "|HNWBCustomLink:buffs|h[DMF]|h",
		}
	end
	for k, v in pairs(types) do
		local match = string.match(msg, k);
		--if (NWB.isLayered) then
			if (match) then
				--If layered make the whole msg clickable to open buffs frame.
				msg = string.gsub(msg, k .. " (.+)", v .. " |HNWBCustomLink:timers|h%1|h");
				return false, msg, author, ...;
			end
		--else
			--if (match) then
			--	msg = string.gsub(msg, k, v);
			--	return false, msg, author, ...;
			--end
		--end
	end
	return false, msg, author, ...;
	--if (NWB.isLayered and channel == "guild") then
	--	msg = "|HNWBCustomLink:timers|h" .. msg .. "|h";
	--end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", NWB.addClickLinks);
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", NWB.addClickLinks);
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", NWB.addClickLinks);
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", NWB.addClickLinks);
ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND", NWB.addClickLinks);
ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND_LEADER", NWB.addClickLinks);
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", NWB.addClickLinks);
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", NWB.addClickLinks);
ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", NWB.addClickLinks);
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", NWB.addClickLinks);
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", NWB.addClickLinks);
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", NWB.addClickLinks);
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", NWB.addClickLinks);
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", NWB.addClickLinks);
--Hook the chat link click func.
hooksecurefunc("ChatFrame_OnHyperlinkShow", function(...)
	local chatFrame, link, text, button = ...;
    if (link == "NWBCustomLink:buffs") then
		NWB:openBuffListFrame();
	end
	--if (link == "NWBCustomLink:timers" and NWB.isLayered) then
	if (link == "NWBCustomLink:timers") then
		NWB:openLayerFrame();
	end
end)

--Insert our custom link type into blizzards SetHyperlink() func.
local OriginalSetHyperlink = ItemRefTooltip.SetHyperlink
function ItemRefTooltip:SetHyperlink(link, ...)
	if (link and link:sub(0, 13) == "NWBCustomLink") then
		return;
	end
	return OriginalSetHyperlink(self, link, ...);
end

--Add prefix and colors from db then print.
local printPrefix;
function NWB:print(msg, channel, prefix)
	if (prefix) then
		printPrefix = NWB.prefixColor .. prefix .. "|r";
	end
	if (channel) then
		channel = string.lower(channel);
	end
	if (channel == "group" or channel == "team") then
		channel = "party";
	end
	if (channel == "gchat" or channel == "gmsg") then
		channel = "guild";
	end
	local channelWhisper, name;
	if (channel) then
		channelWhisper, name = strsplit(" ", channel, 2);
	end
	if (channelWhisper == "tell" or channelWhisper == "whisper" or channelWhisper == "msg") then
		if (not prefix) then
			printPrefix = "[NovaWorldBuffs]";
		end
		if (name and name ~= "") then
			SendChatMessage(printPrefix .. " " .. msg, "WHISPER", nil, name);
		else
			print(NWB.chatColor .. L["No whisper target found."]);
		end
	elseif (channel == "r" or channel == "reply") then
		if (not prefix) then
			printPrefix = "[NovaWorldBuffs]";
		end
		if (NWB.lastWhisper and NWB.lastWhisper ~= "") then
			if (NWB.lastWhisperType == "bnet") then
				BNSendWhisper(NWB.lastWhisper, printPrefix .. " " .. msg);
			else
				SendChatMessage(printPrefix .. " " .. msg, "WHISPER", nil, NWB.lastWhisper);
			end
		else
			print(NWB.chatColor .. "No last whisper target found.");
		end
	elseif (channel == "say" or channel == "yell" or channel == "party" or channel == "guild" or channel == "officer" or channel == "raid") then
		--If posting to a specifed channel then advertise addon name in prefix, more people that have the addon then more accurate the data is.
		if (not prefix) then
			printPrefix = "[NovaWorldBuffs]";
			if (channel == "guild") then
				printPrefix = "[WorldBuffs]";
			end
		end
		SendChatMessage(printPrefix .. " " .. msg, channel);
	elseif (tonumber(channel)) then
		--Send to numbered channel by number.
		local id, name = GetChannelName(channel);
		if (id == 0) then
			print(NWB.chatColor .. L["No channel with id "] .. NWB.prefixColor .. channel .. NWB.chatColor .. L[" exists."]);
			print(NWB.chatColor .. L["Type \"/wb\" to print world buff timers to yourself."]);
			print(NWB.chatColor .. L["Type \"/wb config\" to open options."]);
			print(NWB.chatColor .. L["Type \"/wb guild\" to post buff timers to the specified chat channel (accepts channel names and numbers)."]);
			print(NWB.chatColor .. L["Use \"/sf\" in the same way for songflowers."]);
			print(NWB.chatColor .. L["Type \"/dmf\" for your Darkmoon Faire buff cooldown."]);
			print(NWB.chatColor .. L["Type \"/buffs\" to view all your alts world buffs."]);
			return;
		end
		if (not prefix) then
			printPrefix = "[NovaWorldBuffs]";
		end
		SendChatMessage(printPrefix .. " " .. NWB:stripColors(msg), "CHANNEL", nil, id);
	elseif (channel ~= nil and channel ~= "print") then
		--Send to numbered channel by name.
		local id, name = GetChannelName(channel);
		if (id == 0) then
			print(NWB.chatColor .. L["No channel with id "] .. NWB.prefixColor .. channel .. NWB.chatColor .. L[" exists."]);
			print(NWB.chatColor .. L["Type \"/wb\" to print world buff timers to yourself."]);
			print(NWB.chatColor .. L["Type \"/wb config\" to open options."]);
			print(NWB.chatColor .. L["Type \"/wb guild\" to post buff timers to the specified chat channel (accepts channel names and numbers)."]);
			print(NWB.chatColor .. L["Use \"/sf\" in the same way for songflowers."]);
			print(NWB.chatColor .. L["Type \"/dmf\" for your Darkmoon Faire buff cooldown."]);
			print(NWB.chatColor .. L["Type \"/buffs\" to view all your alts world buffs."]);
			return;
		end
		if (not prefix) then
			printPrefix = "[NovaWorldBuffs]";
		end
		SendChatMessage(printPrefix .. " " .. NWB:stripColors(msg), "CHANNEL", nil, id);
	else
		if (not prefix) then
			printPrefix = NWB.prefixColor .. "|HNWBCustomLink:buffs|h[WorldBuffs]|h|r";
		end
		if (prefix == "[DMF]") then
			printPrefix = NWB.prefixColor .. "|HNWBCustomLink:buffs|h[DMF]|h|r";
		end
		if (NWB.isLayered) then
			msg = "|HNWBCustomLink:timers|h" .. msg .. "|h";
		end
		print(printPrefix .. " " .. NWB.chatColor .. msg);
	end
end

NWB.types = {
	[1] = "rend",
	[2] = "ony",
	[3] = "nef",
	--[4] = "zan"
};

--1 second looping function for timer warning msgs.
NWB.played = 0;
local lastDmfTick = 0;
function NWB:ticker()
	for k, v in pairs(NWB.types) do
		local offset = 0;
		if (v == "rend") then
			offset = NWB.db.global.rendRespawnTime;
		elseif (v == "ony") then
			offset = NWB.db.global.onyRespawnTime;
		elseif (v == "nef") then
			offset = NWB.db.global.nefRespawnTime;
		--elseif (v == "zan") then
		--	offset = NWB.db.global.zanRespawnTime;
		end
		if (NWB.isLayered) then
			for layer, value in NWB:pairsByKeys(NWB.data.layers) do
				local secondsLeft = (NWB.data.layers[layer][v .. "Timer"] + offset) - GetServerTime();
				--This looks messy but when checking (secondsLeft == 0) it would sometimes skip, not sure why.
				--This gives it a 2 second window instead of 1.
				if (NWB.data.layers[layer][v .. "0"] and secondsLeft <= 0 and secondsLeft >= -1) then
					NWB.data.layers[layer][v .. "0"] = nil;
					NWB:doWarning(v, 0, secondsLeft, layer);
				elseif (NWB.data.layers[layer][v .. "1"] and secondsLeft <= 60 and secondsLeft >= 59) then
					NWB.data.layers[layer][v .. "1"] = nil;
					NWB:doWarning(v, 1, secondsLeft, layer);
					NWB:playSound("soundsOneMinute", "timer");
				elseif (NWB.data.layers[layer][v .. "5"] and secondsLeft <= 300  and secondsLeft >= 299) then
					NWB.data.layers[layer][v .. "5"] = nil;
					NWB:doWarning(v, 5, secondsLeft, layer);
				elseif (NWB.data.layers[layer][v .. "10"] and secondsLeft <= 600  and secondsLeft >= 599) then
					NWB.data.layers[layer][v .. "10"] = nil;
					NWB:doWarning(v, 10, secondsLeft, layer);
				elseif (NWB.data.layers[layer][v .. "15"] and secondsLeft <= 900 and secondsLeft >= 899) then
					NWB.data.layers[layer][v .. "15"] = nil;
					NWB:doWarning(v, 15, secondsLeft, layer);
				elseif (NWB.data.layers[layer][v .. "30"] and secondsLeft <= 1800 and secondsLeft >= 1799) then
					NWB.data.layers[layer][v .. "30"] = nil;
					NWB:doWarning(v, 30, secondsLeft, layer);
				end
			end
		else
			local secondsLeft = (NWB.data[v .. "Timer"] + offset) - GetServerTime();
			--This looks messy but when checking (secondsLeft == 0) it would sometimes skip, not sure why.
			--This gives it a 2 second window instead of 1.
			if (NWB.data[v .. "0"] and secondsLeft <= 0 and secondsLeft >= -1) then
				NWB.data[v .. "0"] = nil;
				NWB:doWarning(v, 0, secondsLeft);
			elseif (NWB.data[v .. "1"] and secondsLeft <= 60 and secondsLeft >= 59) then
				NWB.data[v .. "1"] = nil;
				NWB:doWarning(v, 1, secondsLeft);
				NWB:playSound("soundsOneMinute", "timer");
			elseif (NWB.data[v .. "5"] and secondsLeft <= 300  and secondsLeft >= 299) then
				NWB.data[v .. "5"] = nil;
				NWB:doWarning(v, 5, secondsLeft);
			elseif (NWB.data[v .. "10"] and secondsLeft <= 600  and secondsLeft >= 599) then
				NWB.data[v .. "10"] = nil;
				NWB:doWarning(v, 10, secondsLeft);
			elseif (NWB.data[v .. "15"] and secondsLeft <= 900 and secondsLeft >= 899) then
				NWB.data[v .. "15"] = nil;
				NWB:doWarning(v, 15, secondsLeft);
			elseif (NWB.data[v .. "30"] and secondsLeft <= 1800 and secondsLeft >= 1799) then
				NWB.data[v .. "30"] = nil;
				NWB:doWarning(v, 30, secondsLeft);
			end
		end
	end
	if (NWB.played > 0) then
		NWB.played = NWB.played + 1;
	end
	if (NWB.data.myChars[UnitName("player")].buffs) then
		for k, v in pairs(NWB.data.myChars[UnitName("player")].buffs) do
			--Correct a rare bug.
			if (not v.timeLeft) then
				NWB.data.myChars[UnitName("player")].buffs[k] = nil;
			else
				v.timeLeft = v.timeLeft - 1;
				if (v.type == "dmf") then
					if ((lastDmfTick + 7200) >= 1 and (v.timeLeft + 7200) <= 0) then
						if (NWB.isDmfUp) then
							NWB:print(L["dmfBuffReset"]);
						end
						lastDmfTick = -99999;
						NWB.data.myChars[UnitName("player")].buffs[k] = nil;
					else
						lastDmfTick = v.timeLeft;
					end
				end
			end
		end
	end
	C_Timer.After(1, function()
		NWB:ticker();
	end)
end

--Filter addon comm warnings from yell for 5 seconds after sending a yell.
--Even though we only send 1 msg every few minutes I think it can still trigger this msg if a large amount of people are in 1 spot.
--Even if it triggers this msg the data still got out there to most people, it will spread just fine over time.
--Server side limit depends on how many people are close by when you send maybe?
--NWB.doFilterAddonChatMsg = false;
local function filterAddonChatMsg(self, event, msg, author, ...)
	if (NWB.loaded and event == "CHAT_MSG_SYSTEM") then
		--Filter if any data sent in the last 30 seconds.
		--But always filter on CN realms, they still get msgs even though we're filtering 30 seconds after.
		--I think CN have some other addon issues over there.
		if (string.find(msg, "The number of messages that can be sent is limited")) then
			NWB:debug("System msg:", GetServerTime() - NWB.lastDataSent);
		end
		if ((GetServerTime() - NWB.lastDataSent) < 30 or NWB.cnRealms[NWB.realm]) then
			--On some clients something is making ERR_CHAT_THROTTLED an empty string (maybe another addon?).
			--So we have to check for that not block all system msgs if it is.
			if (ERR_CHAT_THROTTLED and string.find(msg, ERR_CHAT_THROTTLED) and ERR_CHAT_THROTTLED ~= "") then
				--The number of messages that can be sent is limited, please wait to send another message.
				return true;
			end
			--Backup check of the actual string incase the first fails because of that empty string bug.
			if (string.find(msg, "The number of messages that can be sent is limited")
					or string.find(msg, "可发送的信息数量受限") or string.find(msg, "本頻道可傳送的訊息數量有限")) then
				return true;
	    	end
	    end
    elseif (event == "CHAT_MSG_WHISPER") then
    	--Filtering spam trying to force users into changing their personal settings.
    	local text = string.char(37) .. string.char(91) .. string.char(105) .. string.char(83) .. string.char(112)
    			.. string.char(97) .. string.char(109) .. string.char(37) .. string.char(93);
    	if (string.find(msg, text)) then
    		return true;
    	end
    end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", filterAddonChatMsg);
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", filterAddonChatMsg);

--Send warnings to channels selected in options
local warningThroddle = {
	["rend"] = 0,
	["ony"] = 0,
	["nef"] = 0,
	["zan"] = 0,
};
function NWB:doWarning(type, num, secondsLeft, layer)
	local throddleTime = 3;
	--Thoddle longer if buff are shared across layers (hotfix just added to layered realms).
	if (NWB.sharedLayerBuffs) then
		throddleTime = 30;
	end
	if (warningThroddle[type] and (GetServerTime() - warningThroddle[type]) < throddleTime) then
		return;
	end
	warningThroddle[type] = GetServerTime();
	local layerMsg = "";
	if ((type ~= "rend" or NWB.doLayerMsg) and layer) then
		local count = 0;
		for k, v in NWB:pairsByKeys(NWB.data.layers) do
			count = count + 1;
			if (k == tonumber(layer)) then
				layerMsg = L[" (Layer "] .. count .. ")";
			end
		end
	end
	local send = true;
	local buff;
	if (type == "rend") then
		buff = L["rend"];
		if (NWB.faction ~= "Horde" and not NWB.db.global.allianceEnableRend) then
			--We only send rend timer warnings to alliance if they have enabled it.
			send = nil;
		end
	elseif (type == "ony") then
		buff = L["onyxia"];
	elseif (type == "nef") then
		buff = L["nefarian"];
	elseif (type == "zan") then
		buff = L["zan"];
	end
	local msg;
	if (num == 0) then
		msg = string.format(L["newBuffCanBeDropped"], buff);
	else
		msg = string.format(L["buffResetsIn"], buff, NWB:getTimeString(secondsLeft, true));
	end
	if ((type == "ony" and NWB.data.onyNpcDied > NWB.data.onyTimer)
			or (type == "nef" and (NWB.data.nefNpcDied > NWB.data.nefTimer))) then
		--If npc killed timestamp is newer than last set time then don't send any warnings.
		return;	
	end
	local period = ".";
	if (LOCALE_zhCN or LOCALE_zhTW) then
		period = "";
	end
	msg = msg .. layerMsg .. period;
	--Chat.
	if (NWB.db.global.chat30 and num == 30 and send) then
		NWB:print(msg);
	elseif (NWB.db.global.chat15 and num == 15 and send) then
		NWB:print(msg);
	elseif (NWB.db.global.chat10 and num == 10 and send) then
		NWB:print(msg);
	elseif (NWB.db.global.chat5 and num == 5 and send) then
		NWB:print(msg);
	elseif (NWB.db.global.chat1 and num == 1 and send) then
		NWB:print(msg);
	elseif (NWB.db.global.chat0 and num == 0 and send) then
		NWB:print(msg);
	end
	--Guild.
	local loadWait = GetServerTime() - NWB.loadTime;
	if (loadWait > 5 and NWB.db.global.guild10 == 1 and num == 10 and send) then
		NWB:sendGuildMsg(msg, "guild10");
	elseif (loadWait > 5 and NWB.db.global.guild1 == 1 and num == 1 and send) then
		NWB:sendGuildMsg(msg, "guild1");
	end
	if (num == 1) then
		NWB:startFlash("flashOneMin");
	end
	--Middle of the screen.
	if (InCombatLockdown() and NWB.db.global.middleHideCombat) then
		return;
	end
	local inInstance, instanceType = IsInInstance();
	if (inInstance and instanceType == "raid" and NWB.db.global.middleHideRaid) then
		return;
	end
	if (UnitInBattleground("player") and NWB.db.global.middleHideBattlegrounds) then
		return;
	end
	local colorTable = {r = self.db.global.middleColorR, g = self.db.global.middleColorG, 
			b = self.db.global.middleColorB, id = 41, sticky = 0};
	if (NWB.db.global.middle30 and num == 30 and send) then
		RaidNotice_AddMessage(RaidWarningFrame, NWB:stripColors(msg), colorTable, 5);
	elseif (NWB.db.global.middle15 and num == 15 and send) then
		RaidNotice_AddMessage(RaidWarningFrame, NWB:stripColors(msg), colorTable, 5);
	elseif (NWB.db.global.middle10 and num == 10 and send) then
		RaidNotice_AddMessage(RaidWarningFrame, NWB:stripColors(msg), colorTable, 5);
	elseif (NWB.db.global.middle5 and num == 5 and send) then
		RaidNotice_AddMessage(RaidWarningFrame, NWB:stripColors(msg), colorTable, 5);
	elseif (NWB.db.global.middle1 and num == 1 and send) then
		RaidNotice_AddMessage(RaidWarningFrame, NWB:stripColors(msg), colorTable, 5);
	elseif (NWB.db.global.middle0 and num == 0 and send) then
		RaidNotice_AddMessage(RaidWarningFrame, NWB:stripColors(msg), colorTable, 5);
	end
end

--Only one person online at a time sends guild msgs so there's no spam, chosen by alphabetical order.
--Can also specify zone so only 1 person from that zone will send the msg (like orgrimmar when npc yell goes out).
--BUG: sometimes a user doesn't register as having addon, checked table they don't exist when this happens.
--Must be some reason they don't send a guild addon msg at logon.
function NWB:sendGuildMsg(msg, type, zoneName)
	if (NWB.db.global.disableAllGuildMsgs == 1) then
		return;
	end
	if (not IsInGuild()) then
		return;
	end
	--Disable guild msg if GM has it disabled in their public note.
	if (NWB:checkGuildMasterSetting(type)) then
		return;
	end
	GuildRoster();
	local shortSettingsKeys = {
		--Check the short keys we use for sending smaller data also.
		--Just incase there wern't converted back properly on data received for some reason.
		["disableAllGuildMsgs"] = "a",
		["guildBuffDropped"] = "b",
		["guildNpcDialogue"] = "c",
		["guildZanDialogue"] = "d",
		["guildNpcKilled"] = "e",
		["guildSongflower"] = "f",
		["guildCommand"] = "g",
		["guild30"] = "h",
		["guild15"] = "i",
		["guild10"] = "j",
		["guild5"] = "k",
		["guild1"] = "l",
		["guild0"] = "m",
	};
	local numTotalMembers = GetNumGuildMembers();
	local onlineMembers = {};
	local me = UnitName("player") .. "-" .. GetNormalizedRealmName();
	for i = 1, numTotalMembers do
		local name, _, _, _, _, zone, _, _, online, _, _, _, _, isMobile = GetGuildRosterInfo(i);
		if (zoneName) then
			if (name and zone == zoneName and online and NWB.hasAddon[name] and not isMobile) then
				--If guild member is in zone specified and online and has addon installed add to temp table.
				--Not currently used anywhere, was removed.
				onlineMembers[name] = true;
			end
		elseif (type) then
			--If type then check our db for other peoples settings to ignore them in online list if they have this type disabled.
			if (name and online and NWB.hasAddon[name] and not isMobile) then
				if (NWB.data[name]) then
					--If this is another guild member then check their settings.	
					--A few different checks for backwards compatability.
					if ((NWB.data[name][type] == true or NWB.data[name][type] == 1
							or NWB.data[name][shortSettingsKeys[type]] == true or NWB.data[name][shortSettingsKeys[type]] == 1)
							and NWB.data[name].disableAllGuildMsgs ~= true and NWB.data[name].disableAllGuildMsgs ~= 1
							and NWB.data[name].a ~= true and NWB.data[name].a ~= 1) then
						--Has addon and has this type of msg type option enabled.
						onlineMembers[name] = true;
					end
				elseif (name == me) then
					--If myself check my settings.
					if ((NWB.db.global[type] == true or NWB.db.global[type] == 1)
							and NWB.db.global.disableAllGuildMsgs ~= true and NWB.db.global.disableAllGuildMsgs ~= 1) then
						onlineMembers[name] = true;
					end
				end
			end
		else
			if (name and online and NWB.hasAddon[name] and not isMobile) then
				--If guild member is online and has addon installed add to temp table.
				onlineMembers[name] = true;
			end
		end
	end
	--Check temp table to see if we're first in alphabetical order.
	for k, v in NWB:pairsByKeys(onlineMembers) do
		if (k == me) then
			SendChatMessage("[WorldBuffs] " .. NWB:stripColors(msg), "guild");
		end
		return;
	end
end

--Setting to allow guild masters to disable msgs in chat.
NWB.guildMasterSettings = {};
function NWB:checkGuildMasterSetting(type)
	if (not IsInGuild()) then
		return;
	end
	local note = "";
	local name, rank, rankIndex;
	local numTotalMembers = GetNumGuildMembers();
	for i = 1, numTotalMembers do
		name, rank, rankIndex, _, _, _, note = GetGuildRosterInfo(i);
		if (rankIndex == 0) then
			--Guild Master.
			break;
		end
	end
	local settings = {
		--Disable certain guild msgs based on guild masters note.
		["#nwb1"] = 1, --1 = Disable All msgs.
		["#nwb2"] = 2, --2 = Disable timers msgs.
		["#nwb3"] = 3, --3 = Disable buff dropped msgs.
		["#nwb4"] = 4, --4 = Disable !wb command.
		["#nwb5"] = 5, --5 = Disable Songflowers msgs.
	}
	local found;
	NWB.guildMasterSettings = {};
	for k, v in pairs(settings) do
		if (note and string.find(string.lower(note), k)) then
			--NWB:debug("Guild master setting found:", k);
			NWB.guildMasterSettings[v] = true;
			if (v == 1) then
				found = true;
			elseif (v == 2) then
				if (type == "guild30" or type == "guild15" or type == "guild10"
					 or type == "guild5" or type == "guild1" or type == "guild0") then
					found = true;
				end
			elseif (v == 3) then
				if (type == "guildBuffDropped" or type == "guildNpcDialogue" or type == "guildZanDialogue") then
					found = true;
				end
			elseif (v == 4) then
				if (type == "guildCommand") then
					found = true;
				end
			elseif (v == 5) then
				if (type == "guildSongflower") then
					found = true;
				end
			end
		end
	end
	if (found) then
		return true;
	end
end

--Guild chat msg event.
local guildWbCmdCooldown, guildDmfCmdCooldown = 0, 0;
function NWB:chatMsgGuild(...)
	local msg = ...;
	msg = string.lower(msg);
	local cmd, arg = strsplit(" ", msg, 2);
	if (string.match(msg, "^!wb") and NWB.db.global.guildCommand == 1 and (GetServerTime() - guildWbCmdCooldown) > 5) then
		guildWbCmdCooldown = GetServerTime();
		NWB:sendGuildMsg(NWB:getShortBuffTimers("guildCommand", arg), "guildCommand");
	end
	if (string.match(msg, "^!dmf") and NWB.db.global.guildCommand == 1 and (GetServerTime() - guildDmfCmdCooldown) > 5) then
		guildDmfCmdCooldown = GetServerTime();
		local output = NWB:getDmfTimeString();
		if (output) then
			NWB:sendGuildMsg(output, "guildCommand");
		end
	end
end

function NWB:monsterYell(...)
	local layerNum;
	if (NWB.isLayered and NWB:GetLayerCount() == 2 and NWB.lastKnownLayerMapID and NWB.lastKnownLayerMapID > 0
			and NWB.lastKnownLayer and NWB.lastKnownLayer > 0) then
		layerNum = NWB.lastKnownLayer;
	end
	--Skip strict string matching yell msgs for regions we haven't localized yet.
	--This could result in less accurate timers but better than no timers at all.
	local locale = GetLocale();
	local skipStringCheck;
	if (NWB.faction == "Horde") then
		if (locale == "ptBR" or locale == "esES" or locale == "esMX" or locale == "itIT") then
			skipStringCheck = true;
		end
	end
	if (NWB.faction == "Alliance") then
		if (locale == "frFR" or locale == "ptBR" or locale == "esES" or locale == "esMX" or locale == "itIT"
				or locale == "zhCN") then
			skipStringCheck = true;
		end
	end
	local msg, name = ...;
	if ((name == L["Thrall"] or (name == L["Herald of Thrall"] and (not NWB.isLayered or NWB.faction == "Alliance")))
			and (string.match(msg, L["Rend Blackhand, has fallen"]) or skipStringCheck)) then
		--6 seconds between first rend yell and buff applied.
		NWB.data.rendYell = GetServerTime();
		NWB:doFirstYell("rend", layerNum);
		--Send first yell msg to guild so people in org see it, needed because 1 person online only will send msg.
		NWB:sendYell("GUILD", "rend", nil, layerNum);
		if  (name == L["Herald of Thrall"] and not NWB.isLayered) then
			--If it was herald we may we in the barrens but not in crossraods to receive buff, set buff timer.
			if (not NWB.isLayered) then
				C_Timer.After(5, function()
					NWB:setRendBuff("self", UnitName("player"));
				end)
			end
		end
		if (tonumber(NWB.rendHandIn) and NWB.rendHandInTime > (GetServerTime() - 20)) then
			NWB:timerLog("q", GetServerTime(), NWB.rendHandIn, UnitName("player"));
			NWB:sendTimerLogData("YELL");
			NWB.rendHandIn = nil
			NWB.rendHandInTime = 0;
			--Send it again hopefully after they left Thrall room and are near more people.
			C_Timer.After(120, function()
				NWB:sendTimerLogData("YELL");
			end)
		end
	elseif ((name == L["Thrall"] or (name == L["Herald of Thrall"] and (not NWB.isLayered or NWB.faction == "Alliance")))
			and string.match(msg, "Be bathed in my power")) then
		--Second yell right before drops "Be bathed in my power! Drink in my might! Battle for the glory of the Horde!".
		NWB.data.rendYell2 = GetServerTime();
		if (tonumber(NWB.rendHandIn) and NWB.rendHandInTime > (GetServerTime() - 20)) then
			NWB:timerLog("q", GetServerTime(), NWB.rendHandIn, UnitName("player"));
			NWB:sendTimerLogData("YELL");
			NWB.rendHandIn = nil
			NWB.rendHandInTime = 0;
			--Send it again hopefully after they left Thrall room and are near more people.
			C_Timer.After(120, function()
				NWB:sendTimerLogData("YELL");
			end)
		end
	elseif ((name == L["Overlord Runthak"] and (string.match(msg, L["Onyxia, has been slain"]) or skipStringCheck))
			or (name == L["Major Mattingly"] and (string.match(msg, L["history has been made"]) or skipStringCheck))) then
		--14 seconds between first ony yell and buff applied.
		NWB.data.onyYell = GetServerTime();
		NWB:doFirstYell("ony", layerNum);
		--Send first yell msg to guild so people in org see it, needed because 1 person online only will send msg.
		NWB:sendYell("GUILD", "ony", nil, layerNum);
	elseif ((name == L["Overlord Runthak"] and string.match(msg, L["Be lifted by the rallying cry"]))
			or (name == L["Major Mattingly"] and string.match(msg, L["Onyxia, hangs from the arches"]))) then
		--Second yell right before drops "Be lifted by the rallying cry of your dragon slayers".
		NWB.data.onyYell2 = GetServerTime();
	elseif ((name == L["High Overlord Saurfang"] and (string.match(msg, L["NEFARIAN IS SLAIN"]) or skipStringCheck))
		 	or (name == L["Field Marshal Afrasiabi"] and (string.match(msg, L["the Lord of Blackrock is slain"]) or skipStringCheck))) then
		--15 seconds between first nef yell and buff applied.
		NWB.data.nefYell = GetServerTime();
		NWB:doFirstYell("nef", layerNum);
		--Send first yell msg to guild so people in org see it, needed because 1 person online only will send msg.
		NWB:sendYell("GUILD", "nef", nil, layerNum);
	elseif ((name == L["High Overlord Saurfang"] and string.match(msg, L["Revel in his rallying cry"]))
			or (name == L["Field Marshal Afrasiabi"] and string.match(msg, L["Revel in the rallying cry"]))) then
		--Second yell right before drops "Be lifted by PlayerName's accomplishment! Revel in his rallying cry!".
		NWB.data.nefYell2 = GetServerTime();
	elseif ((name == L["Molthor"] or name == L["Zandalarian Emissary"])
			and (string.match(msg, L["Begin the ritual"]) or string.match(msg, L["The Blood God"]) or skipStringCheck)) then
		--27ish seconds between first zan yell and buff applied if on island.
		--45ish seconds between first zan yell and buff applied if in booty bay.
		--Booty Bay yell (Zandalarian Emissary yells: The Blood God, the Soulflayer, has been defeated!  We are imperiled no longer!)
		NWB.data.zanYell = GetServerTime();
		NWB:doFirstYell("zan", layerNum);
		NWB:sendYell("GUILD", "zan", nil, layerNum);
	elseif ((name == L["Molthor"] or name == L["Zandalarian Emissary"]) and string.match(msg, L["slayer of Hakkar"])) then
		--Second yell right before drops "All Hail <name>, slayer of Hakkar, and hero of Azeroth!".
		--Booty Bay yell (Zandalarian Emissary yells: All Hail <name>, slayer of Hakkar, and hero of Azeroth!)
		NWB.data.zanYell2 = GetServerTime();
	end
end

--Post first yell warning to guild chat, shared by all different addon comms so no overlap.
local rendFirstYell, onyFirstYell, nefFirstYell, zanFirstYell = 0, 0, 0, 0;
function NWB:doFirstYell(type, layer, source)
	local layerMsg = "";
	if (NWB.isLayered and tonumber(layer) and NWB.doLayerMsg) then
		layerMsg = L[" (Layer "] .. layer .. ")";
	end
	--NWB:debug("layerMsg", layerMsg);
	local colorTable = {r = self.db.global.middleColorR, g = self.db.global.middleColorG, 
			b = self.db.global.middleColorB, id = 41, sticky = 0};
	if (type == "rend") then
		if ((GetServerTime() - rendFirstYell) > 40) then
			--6 seconds from rend first yell to buff drop.
			if (source == "self") then
				NWB.data.rendYell = GetServerTime();
			end
			if (NWB.db.global.guildNpcDialogue == 1 and (NWB.faction == "Horde" or NWB.db.global.allianceEnableRend)) then
				NWB:sendGuildMsg(L["rendFirstYellMsg"] .. layerMsg, "guildNpcDialogue");
			end
			rendFirstYell = GetServerTime();
			NWB:startFlash("flashFirstYell");
			if (NWB.db.global.middleBuffWarning) then
				RaidNotice_AddMessage(RaidWarningFrame, L["rendFirstYellMsg"] .. layerMsg, colorTable, 5);
			end
			NWB:playSound("soundsFirstYell", "rend");
		end
	elseif (type == "ony") then
		if ((GetServerTime() - onyFirstYell) > 40) then
			--14 seconds from ony first yell to buff drop.
			if (source == "self") then
				NWB.data.onyYell = GetServerTime();
			end
			if (NWB.db.global.guildNpcDialogue == 1) then
				NWB:sendGuildMsg(L["onyxiaFirstYellMsg"] .. layerMsg, "guildNpcDialogue");
			end
			onyFirstYell = GetServerTime();
			NWB:startFlash("flashFirstYell");
			if (NWB.db.global.middleBuffWarning) then
				RaidNotice_AddMessage(RaidWarningFrame, L["onyxiaFirstYellMsg"] .. layerMsg, colorTable, 5);
			end
			NWB:playSound("soundsFirstYell", "ony");
		end
	elseif (type == "nef") then
		if ((GetServerTime() - nefFirstYell) > 40) then
			--15 seconds from nef first yell to buff drop.
			if (source == "self") then
				NWB.data.nefYell = GetServerTime();
			end
			if (NWB.db.global.guildNpcDialogue == 1) then
				NWB:sendGuildMsg(L["nefarianFirstYellMsg"] .. layerMsg, "guildNpcDialogue");
			end
			nefFirstYell = GetServerTime();
			NWB:startFlash("flashFirstYell");
			if (NWB.db.global.middleBuffWarning) then
				RaidNotice_AddMessage(RaidWarningFrame, L["nefarianFirstYellMsg"] .. layerMsg, colorTable, 5);
			end
			NWB:playSound("soundsFirstYell", "nef");
		end
	elseif (type == "zan") then
		if ((GetServerTime() - zanFirstYell) > 120) then
			--27ish seconds between first zan yell and buff applied if on island.
			--45ish seconds between first zan yell and buff applied if in booty bay.
			if (source == "self") then
				NWB.data.zanYell = GetServerTime();
			end
			if (NWB.db.global.chatZan) then
				NWB:print(L["zanFirstYellMsg"]);
			end
			if (NWB.db.global.guildZanDialogue == 1) then
				NWB:sendGuildMsg(L["zanFirstYellMsg"] .. layerMsg, "guildZanDialogue");
			end
			NWB:debug(L["zanFirstYellMsg"]);
			zanFirstYell = GetServerTime();
			NWB:startFlash("flashFirstYellZan");
			if (NWB.db.global.middleBuffWarning) then
				RaidNotice_AddMessage(RaidWarningFrame, L["zanFirstYellMsg"] .. layerMsg, colorTable, 5);
			end
			NWB:playSound("soundsFirstYell", "zan");
		end
	end
end

--Post drop msg to guild chat, shared by all different addon comms so no overlap.
local rendDropMsg, onyDropMsg, nefDropMsg = 0, 0, 0;
function NWB:doBuffDropMsg(type, layer)
	local layerMsg = "";
	if (NWB.isLayered and tonumber(layer) and NWB.doLayerMsg) then
		layerMsg = L[" (Layer "] .. layer .. ")";
	end
	if (type == "rend") then
		if ((GetServerTime() - rendDropMsg) > 40) then
			if (NWB.db.global.guildBuffDropped == 1) then
				NWB:sendGuildMsg(L["rendBuffDropped"] .. layerMsg, "guildBuffDropped");
			end
			rendDropMsg = GetServerTime();
		end
	elseif (type == "ony") then
		if ((GetServerTime() - onyDropMsg) > 40) then
			if (NWB.db.global.guildBuffDropped == 1) then
				NWB:sendGuildMsg(L["onyxiaBuffDropped"] .. layerMsg, "guildBuffDropped");
			end
			onyDropMsg = GetServerTime();
		end
	elseif (type == "nef") then
		if ((GetServerTime() - nefDropMsg) > 40) then
			if (NWB.db.global.guildBuffDropped == 1) then
				NWB:sendGuildMsg(L["nefarianBuffDropped"] .. layerMsg, "guildBuffDropped");
			end
			nefDropMsg = GetServerTime();
		end
	end
end

local onyNpcKill, nefNpcKill = 0, 0;
function NWB:doNpcKilledMsg(type, layer)
	local layerMsg = "";
	if (NWB.isLayered and tonumber(layer)) then
		layerMsg = L[" (Layer "] .. layer .. ")";
	end
	if (type == "ony") then
		if ((GetServerTime() - onyNpcKill) > 40) then
			if (NWB.db.global.guildNpcKilled == 1) then
				if (NWB.faction == "Horde") then
					NWB:sendGuildMsg(L["onyxiaNpcKilledHorde"] .. layerMsg, "guildNpcKilled");
				else
					NWB:sendGuildMsg(L["onyxiaNpcKilledAlliance"] .. layerMsg, "guildNpcKilled");
				end
			end
			onyNpcKill = GetServerTime();
		end
	elseif (type == "nef") then
		if ((GetServerTime() - nefNpcKill) > 40) then
			if (NWB.db.global.guildNpcKilled == 1) then
				if (NWB.faction == "Horde") then
					NWB:sendGuildMsg(L["nefarianNpcKilledHorde"] .. layerMsg, "guildNpcKilled");
				else
					NWB:sendGuildMsg(L["nefarianNpcKilledAlliance"] .. layerMsg, "guildNpcKilled");
				end
			end
			nefNpcKill = GetServerTime();
		end
	end
end

--Buffs seem to have changed yet again, they no longer land with full duration.
--Now buffs are missing the lag duration from drop to land depending on aount of people in city.
--Basically is lands missing 10 or so seconds on my realm.
local yellOneOffset = 30;
local yellTwoOffset = 30;
local buffLag = 15;
local lastZanBuffGained = 0;
function NWB:combatLogEventUnfiltered(...)
	local timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, 
			destName, destFlags, destRaidFlags, _, spellName = CombatLogGetCurrentEventInfo();
	if (subEvent == "UNIT_DIED") then
		local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
		local _, _, _, _, zoneID, npcID = strsplit("-", destGUID);
		zoneID = tonumber(zoneID);
		if ((zone == 1454 or zone == 1411) and destName == L["Overlord Runthak"]) then
			if (NWB.faction ~= "Horde") then
				return;
			end
			local layerNum;
			if (NWB.isLayered and NWB:GetLayerCount() == 2 and NWB.lastKnownLayerMapID and NWB.lastKnownLayerMapID > 0
					and NWB.lastKnownLayer and NWB.lastKnownLayer > 0) then
				layerNum = NWB.lastKnownLayer;
			end
			if (NWB.isLayered and zoneID and NWB.data.layers[zoneID]) then
				NWB.data.layers[zoneID].onyNpcDied = GetServerTime();
			end
			NWB.data.onyNpcDied = GetServerTime();
			NWB:doNpcKilledMsg("ony", layerNum);
			NWB:sendNpcKilled("GUILD", "ony", nil, layerNum);
			NWB:print(L["onyxiaNpcKilledHorde"]);
			NWB:timerCleanup();
			NWB:sendData("GUILD");
			NWB:sendData("YELL"); --Yell is further than npc view range.
		elseif ((zone == 1454 or zone == 1411) and destName == L["High Overlord Saurfang"]) then
			if (NWB.faction ~= "Horde") then
				return;
			end
			local layerNum;
			if (NWB.isLayered and NWB:GetLayerCount() == 2 and NWB.lastKnownLayerMapID and NWB.lastKnownLayerMapID > 0
					and NWB.lastKnownLayer and NWB.lastKnownLayer > 0) then
				layerNum = NWB.lastKnownLayer;
			end
			if (NWB.isLayered and zoneID and NWB.data.layers[zoneID]) then
				NWB.data.layers[zoneID].nefNpcDied = GetServerTime();
			end
			NWB.data.nefNpcDied = GetServerTime();
			NWB:doNpcKilledMsg("nef", layerNum);
			NWB:sendNpcKilled("GUILD", "nef", nil, layerNum);
			NWB:print(L["nefarianNpcKilledHorde"]);
			NWB:timerCleanup();
			NWB:sendData("GUILD");
			NWB:sendData("YELL"); --Yell is further than npc view range.
		elseif ((zone == 1453 or zone == 1429) and destName == L["Major Mattingly"]) then
			if (NWB.faction ~= "Alliance") then
				return;
			end
			local layerNum;
			if (NWB.isLayered and NWB:GetLayerCount() == 2 and NWB.lastKnownLayerMapID and NWB.lastKnownLayerMapID > 0
					and NWB.lastKnownLayer and NWB.lastKnownLayer > 0) then
				layerNum = NWB.lastKnownLayer;
			end
			if (NWB.isLayered and zoneID and NWB.data.layers[zoneID]) then
				NWB.data.layers[zoneID].onyNpcDied = GetServerTime();
			end
			NWB.data.onyNpcDied = GetServerTime();
			NWB:doNpcKilledMsg("ony", layerNum);
			NWB:sendNpcKilled("GUILD", "ony", nil, layerNum);
			NWB:print(L["onyxiaNpcKilledAlliance"]);
			NWB:timerCleanup();
			NWB:sendData("GUILD");
			NWB:sendData("YELL"); --Yell is further than npc view range.
		elseif ((zone == 1453 or zone == 1429) and destName == L["Field Marshal Afrasiabi"]) then
			if (NWB.faction ~= "Alliance") then
				return;
			end
			local layerNum;
			if (NWB.isLayered and NWB:GetLayerCount() == 2 and NWB.lastKnownLayerMapID and NWB.lastKnownLayerMapID > 0
					and NWB.lastKnownLayer and NWB.lastKnownLayer > 0) then
				layerNum = NWB.lastKnownLayer;
			end
			if (NWB.isLayered and zoneID and NWB.data.layers[zoneID]) then
				NWB.data.layers[zoneID].nefNpcDied = GetServerTime();
			end
			NWB.data.nefNpcDied = GetServerTime();
			NWB:doNpcKilledMsg("nef", layerNum);
			NWB:sendNpcKilled("GUILD", "nef", nil, layerNum);
			NWB:print(L["nefarianNpcKilledAlliance"]);
			NWB:timerCleanup();
			NWB:sendData("GUILD");
			NWB:sendData("YELL"); --Yell is further than npc view range.
		end
	elseif (subEvent == "SPELL_AURA_APPLIED" or subEvent == "SPELL_AURA_REFRESH") then
		local unitType, _, _, _, zoneID, npcID = strsplit("-", sourceGUID);
		local destUnitType, _, _, _, destZoneID, destNpcID = strsplit("-", destGUID);
		zoneID = tonumber(zoneID);
		if (NWB.isDebug) then
			local expirationTime = NWB:getBuffDuration(spellName);
			if (destName == UnitName("player") and (spellName == L["Rallying Cry of the Dragonslayer"] or spellName == L["Warchief's Blessing"])) then
				NWB:debug("buff", expirationTime, sourceGUID);
			end
			if (destName == UnitName("player") and spellName == L["Rallying Cry of the Dragonslayer"] and expirationTime >= (7199.5 - buffLag)) then
				NWB:debug("bufftest", spellName, unitType, zoneID, npcID, GetServerTime() - NWB.data.onyYell, expirationTime);
				NWB:debug("bufftest2 source", sourceGUID, "dest", destGUID);
				NWB:debug("ony yell", GetServerTime() - NWB.data.onyYell, "nef yell", GetServerTime() - NWB.data.nefYell);
			end
			if (destName == UnitName("player") and spellName == L["Warchief's Blessing"] and expirationTime >= (3599.5 - buffLag)) then
				NWB:debug("bufftest", spellName, unitType, zoneID, npcID, GetServerTime() - NWB.data.rendYell, expirationTime);
				NWB:debug("bufftest3 source", sourceGUID, "dest", destGUID);
				NWB:debug("rend yell", GetServerTime() - NWB.data.rendYell);
			end
		end
		if (destName == UnitName("player") and spellName == L["Warchief's Blessing"]) then
			local expirationTime = NWB:getBuffDuration(L["Warchief's Blessing"], 1);
			local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
			--If layered then you must be in org to set the right layer id, the barrens is disabled.
			--if (expirationTime >= 3599.5 and (zone == 1454 or not NWB.isLayered) and unitType == "Creature") then
				if (expirationTime >= (3599.5 - buffLag) and (zone == 1454 or not NWB.isLayered) and unitType == "Creature"
				and ((GetServerTime() - NWB.data.rendYell2) < yellTwoOffset or (GetServerTime() - NWB.data.rendYell) < yellOneOffset)) then
			NWB:trackNewBuff(spellName, "rend");
				NWB:playSound("soundsRendDrop", "rend");
				if (NWB.isLayered and zone ~= 1454) then
					--Testing tracking rend for alliance here by attaching it to the new layermap.
					if (NWB.lastKnownLayerMapID and NWB.lastKnownLayerMapID > 0) then
						if (NWB.faction == "Alliance") then
							NWB:setRendBuff("self", UnitName("player"), NWB.lastKnownLayerMapID, sourceGUID, true);
						end
					end
					return;
				end
				if (NWB.isLayered and (not npcID or npcID ~= "4949" or zone ~= 1454) and NWB.faction ~= "Alliance") then
					--Some parts on the edges of orgrimmar seem to give the buff from Herald instead of Thrall, even while on map 1454.
					--This creates a false 3rd layer with the barrens zoneid, took way too long to figure this out...
					NWB:debug("bad rend buff source on layered realm", sourceGUID);
					return;
				end
				if (NWB.isLayered and NWB.faction == "Alliance") then
					NWB:setRendBuff("self", UnitName("player"), zoneID, sourceGUID, true);
				else
					NWB:setRendBuff("self", UnitName("player"), zoneID, sourceGUID);
				end
			end
		elseif (destName == UnitName("player") and spellName == L["Spirit of Zandalar"] and (GetServerTime() - lastZanBuffGained) > 1) then
			--Zan buff has no sourceName or sourceGUID, not sure why.
			local expirationTime = NWB:getBuffDuration(L["Spirit of Zandalar"], 4);
			if (expirationTime >= 7199.5) then
				NWB:setZanBuff("self", UnitName("player"), zoneID, sourceGUID);
				NWB:trackNewBuff(spellName, "zan");
				--Not sure why this triggers 4 times on PTR, needs more testing once it's on live server but for now we do a 1 second cooldown.
				lastZanBuffGained = GetServerTime();
				NWB:playSound("soundsZanDrop", "zan");
			end
		--[[elseif (((NWB.faction == "Horde" and npcID == "14720") or (NWB.faction == "Alliance" and npcID == "14721"))
				and destName == UnitName("player") and spellName == L["Rallying Cry of the Dragonslayer"]
				and ((GetServerTime() - NWB.data.nefYell2) < 60 or (GetServerTime() - NWB.data.nefYell) < 60)
				and unitType == "Creature") then]]
				elseif (((NWB.faction == "Horde" and (npcID == "14720" or npcID == "173758" or NWB.noGUID))
				or (NWB.faction == "Alliance" and (npcID == "14721" or npcID == "173754" or NWB.noGUID)))
				and destName == UnitName("player") and spellName == L["Rallying Cry of the Dragonslayer"]
				and ((GetServerTime() - NWB.data.nefYell2) < yellTwoOffset or (GetServerTime() - NWB.data.nefYell) < yellOneOffset)
				and (unitType == "Creature" or NWB.noGUID)) then
			--What a shitshow this is now, thanks Blizzard for removing the GUID for no good reason.
			local expirationTime = NWB:getBuffDuration(L["Rallying Cry of the Dragonslayer"], 2);
			local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
			if (expirationTime >= (7199.5  - buffLag)) then
				if (((not NWB.noGUID or NWB.currentZoneID > 0) and (zone == 1453 or zone == 1454))
						or not NWB.isLayered) then
					if (NWB.noGUID) then
						NWB:debug("bufftest4", "self", UnitName("player"), NWB.currentZoneID, "noSourceGUID");
						NWB:setNefBuff("self", UnitName("player"), NWB.currentZoneID, "noSourceGUID");
					elseif ((GetServerTime() - NWB.lastJoinedGroup) > 180) then
						NWB:setNefBuff("self", UnitName("player"), zoneID, sourceGUID);
					end
				end
				NWB:trackNewBuff(spellName, "nef");
				NWB:playSound("soundsNefDrop", "nef");
			end
		--[[elseif (((NWB.faction == "Horde" and npcID == "14392") or (NWB.faction == "Alliance" and npcID == "14394"))
				and destName == UnitName("player") and spellName == L["Rallying Cry of the Dragonslayer"]
				and ((GetServerTime() - NWB.data.onyYell2) < 60 or (GetServerTime() - NWB.data.onyYell) < 60)
				and ((GetServerTime() - NWB.data.nefYell2) > 60)
				and unitType == "Creature") then]]
				elseif (((NWB.faction == "Horde" and (npcID == "14392" or npcID == "173758" or NWB.noGUID))
				or (NWB.faction == "Alliance" and (npcID == "14394" or npcID == "173754" or NWB.noGUID)))
				and destName == UnitName("player") and spellName == L["Rallying Cry of the Dragonslayer"]
				and ((GetServerTime() - NWB.data.onyYell2) < yellTwoOffset or (GetServerTime() - NWB.data.onyYell) < yellOneOffset)
				and ((GetServerTime() - NWB.data.nefYell2) > 30)
				and (unitType == "Creature" or NWB.noGUID)) then
			local expirationTime = NWB:getBuffDuration(L["Rallying Cry of the Dragonslayer"], 2);
			local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
			if (expirationTime >= (7199.5 - buffLag)) then
				if (((not NWB.noGUID or NWB.currentZoneID > 0) and (zone == 1453 or zone == 1454))
					or not NWB.isLayered) then
					if (NWB.noGUID) then
						NWB:debug("bufftest4", "self", UnitName("player"), NWB.currentZoneID, "noSourceGUID");
						NWB:setOnyBuff("self", UnitName("player"), NWB.currentZoneID, "noSourceGUID");
					elseif ((GetServerTime() - NWB.lastJoinedGroup) > 180) then
						NWB:setOnyBuff("self", UnitName("player"), zoneID, sourceGUID);
					end
				end
				NWB:trackNewBuff(spellName, "ony");
				NWB:playSound("soundsOnyDrop", "ony");
			end
		elseif (((NWB.faction == "Horde" and destNpcID == "14392") or (NWB.faction == "Alliance" and destNpcID == "14394"))
				and spellName == L["Sap"] and ((GetServerTime() - NWB.data.onyYell2) < 30 or (GetServerTime() - NWB.data.onyYell) < 30)) then
			--Yell timestamp is only recorded to non-layered data (NWB.data.onyYell) first because there's is no GUID attached.
			--Then it's copied from there to the right layer once the buff drops in setOnyBuff().
			--For this reason we just check against the non-layered yell timestamp even for layered realms.
			--Using destGUID instead of sourceGUID for sap target instead of buff gained from source.
			--[[Sapping breaking the buff was fixed by blizzard.
			local unitType, _, _, _, zoneID, npcID = strsplit("-", destGUID);
			zoneID = tonumber(zoneID);
			local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
			if ((zone == 1453 or zone == 1454) or not NWB.isLayered) then
				NWB:debug("Onyxia buff NPC sapped by", sourceName, zoneID, destGUID);
				if (sourceName) then
					NWB:print("Onyxia buff NPC sapped by " .. sourceName .. ", setting backup timer.");
					if (not NWB.data.sapped) then
						NWB.data.sapped = {};
					end
					NWB.data.sapped[sourceName] = GetServerTime();
				else
					NWB:print("Onyxia buff NPC sapped, setting backup timer.");
				end
				NWB:setOnyBuff("self", UnitName("player"), zoneID, destGUID, true);
			end]]
		elseif (destName == UnitName("player") and (spellName == L["Sayge's Dark Fortune of Agility"]
				or spellName == L["Sayge's Dark Fortune of Spirit"] or spellName == L["Sayge's Dark Fortune of Stamina"]
				or spellName == L["Sayge's Dark Fortune of Strength"] or spellName == L["Sayge's Dark Fortune of Armor"]
				or spellName == L["Sayge's Dark Fortune of Resistance"] or spellName == L["Sayge's Dark Fortune of Damage"]
				 or spellName == L["Sayge's Dark Fortune of Intelligence"])) then
			local expirationTime = NWB:getBuffDuration(spellName, 0);
			if (expirationTime >= 7199) then
				NWB:trackNewBuff(spellName, "dmf");
			end
		elseif (destName == UnitName("player") and npcID == "14822") then
			--Backup checking Sayge NPC ID until all localizations are done properly.
			--Maybe this is a better way of doing it overall but I have to test when DMF is actually up first.
			local expirationTime = NWB:getBuffDuration(spellName, 0);
			if (expirationTime >= 7199) then
				NWB:trackNewBuff(spellName, "dmf");
			end
		elseif ((NWB.noGUID or (npcID == "14720" or npcID == "14721" or npcID == "173758")) and destName == UnitName("player")
				and spellName == L["Rallying Cry of the Dragonslayer"]) then
			--Fallback ony/nef buff tracking incase no yell msgs seen abive.
			local expirationTime = NWB:getBuffDuration(L["Rallying Cry of the Dragonslayer"], 2);
			if (expirationTime >= 7199.5) then
				NWB:trackNewBuff(spellName, "ony");
			end
		end
		--Check new nef/ony buffs for tracking durations seperately than the buff timer checks with validation above.
		--This was used when the npc id's were different for the buffs, now we check above instead.
		--[[if ((NWB.noGUID or (npcID == "14720" or npcID == "14721")) and destName == UnitName("player")
				and spellName == L["Rallying Cry of the Dragonslayer"]) then
			local expirationTime = NWB:getBuffDuration(L["Rallying Cry of the Dragonslayer"], 2);
			if (expirationTime >= 7199.5) then
				NWB:trackNewBuff(spellName, "nef");
			end
		elseif ((NWB.noGUID or (npcID == "14392" or npcID == "14394")) and destName == UnitName("player")
				and spellName == L["Rallying Cry of the Dragonslayer"]) then
			local expirationTime = NWB:getBuffDuration(L["Rallying Cry of the Dragonslayer"], 2);
			if (expirationTime >= 7199.5) then
				NWB:trackNewBuff(spellName, "ony");
			end
		elseif (destName == UnitName("player") and spellName == L["Songflower Serenade"]) then]]
		if (destName == UnitName("player") and spellName == L["Songflower Serenade"]) then
				local expirationTime = NWB:getBuffDuration(L["Songflower Serenade"], 3);
			if (expirationTime >= 3599) then
				NWB:trackNewBuff(spellName, "songflower");
			end
		elseif (npcID == "14326" and destName == UnitName("player")) then
			--Mol'dar's Moxie.
			local expirationTime = NWB:getBuffDuration(spellName, 0);
			if (expirationTime >= 7199) then
				NWB:trackNewBuff(spellName, "moxie");
			end
		elseif (npcID == "14321" and destName == UnitName("player")) then
			--Fengus' Ferocity.
			local expirationTime = NWB:getBuffDuration(spellName, 0);
			if (expirationTime >= 7199) then
				NWB:trackNewBuff(spellName, "ferocity");
			end
		elseif (npcID == "14323" and destName == UnitName("player")) then
			--Slip'kik's Savvy.
			local expirationTime = NWB:getBuffDuration(spellName, 0);
			if (expirationTime >= 7199) then
				NWB:trackNewBuff(spellName, "savvy");
			end
		elseif (NWB.isDebugg and destName == UnitName("player") and spellName == "Ice Armor") then
			local expirationTime = NWB:getBuffDuration("Ice Armor", 0);
			if (expirationTime >= 1799) then
				NWB:trackNewBuff(spellName, "ice");
			end
		elseif (destName == UnitName("player")
				and (spellName == L["Flask of Supreme Power"] or spellName == L["Supreme Power"])) then
			local expirationTime = NWB:getBuffDuration(spellName, 0);
			if (expirationTime >= 7199) then
				NWB:trackNewBuff(spellName, "flaskPower");
			end
		elseif (destName == UnitName("player") and spellName == L["Flask of the Titans"]) then
			--This is the only flask spell with "Flask" in the name it seems.
			local expirationTime = NWB:getBuffDuration(spellName, 0);
			if (expirationTime >= 7199) then
				NWB:trackNewBuff(spellName, "flaskTitans");
			end
		elseif (destName == UnitName("player")
				and (spellName == L["Flask of Distilled Wisdom"] or spellName == L["Distilled Wisdom"])) then
			local expirationTime = NWB:getBuffDuration(spellName, 0);
			if (expirationTime >= 7199) then
				NWB:trackNewBuff(spellName, "flaskWisdom");
			end
		elseif (destName == UnitName("player")
				and (spellName == L["Flask of Chromatic Resistance"] or spellName == L["Chromatic Resistance"])) then
			local expirationTime = NWB:getBuffDuration(spellName, 0);
			if (expirationTime >= 7199) then
				NWB:trackNewBuff(spellName, "flaskResistance");
			end
		elseif (destName == UnitName("player") and spellName == L["Resist Fire"]) then
			local expirationTime = NWB:getBuffDuration(spellName, 0);
			if (expirationTime >= 3599) then
				NWB:trackNewBuff(spellName, "resistFire");
			end
		elseif (destName == UnitName("player") and spellName == L["Blessing of Blackfathom"]) then
			local expirationTime = NWB:getBuffDuration(spellName, 0);
			if (expirationTime >= 3599) then
				NWB:trackNewBuff(spellName, "blackfathom");
			end
		elseif (destName == UnitName("player") and spellName == L["Fire Festival Fortitude"]) then
			local expirationTime = NWB:getBuffDuration(spellName, 0);
			if (expirationTime >= 3599) then
				NWB:trackNewBuff(spellName, "festivalFortitude");
			end
		elseif (destName == UnitName("player") and spellName == L["Fire Festival Fury"]) then
			local expirationTime = NWB:getBuffDuration(spellName, 0);
			if (expirationTime >= 3599) then
				NWB:trackNewBuff(spellName, "festivalFury");
			end
		elseif (destName == UnitName("player") and spellName == L["Ribbon Dance"]) then
			local expirationTime = NWB:getBuffDuration(spellName, 0);
			if (expirationTime >= 3599) then
				NWB:trackNewBuff(spellName, "ribbonDance");
			end
		elseif (destName == UnitName("player") and spellName == L["Traces of Silithyst"]) then
			local expirationTime = NWB:getBuffDuration(spellName, 0);
			if (expirationTime >= 1799) then
				NWB:trackNewBuff(spellName, "silithyst");
			end
		end
	elseif (subEvent == "SPELL_AURA_REMOVED" and destName == UnitName("player")) then
		NWB:untrackBuff(spellName);
	elseif (subEvent == "SPELL_DISPEL") then
		if (not NWB.db.global.dispelsMine and not NWB.db.global.dispelsMineWBOnly
				and not NWB.db.global.dispelsAll and not NWB.db.global.dispelsAllWBOnly) then
			return;
		end
		local timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, 
			destName, destFlags, destRaidFlags, _, spellName, _, _, extraSpellName, _, auraType = CombatLogGetCurrentEventInfo();
		--if (auraType == "BUFF") then
			--NWB:debug(CombatLogGetCurrentEventInfo());
		--end
		if (not string.match(destGUID, "Player") or UnitInBattleground("player")
				or (not string.match(sourceGUID, "Player") and not string.match(sourceGUID, "Pet"))) then
			return;
		end
		if (auraType == "BUFF" and bit.band(sourceFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE) then
			local dispellableWorldBuffs = {
				[L["Songflower Serenade"]] = true,
				[L["Resist Fire"]] = true,
				[L["Mol'dar's Moxie"]] = true,
				[L["Fengus' Ferocity"]] = true,
				[L["Slip'kik's Savvy"]] = true,
			}
			if (dispellableWorldBuffs[extraSpellName] and not NWB.cnRealms[NWB.realm] and not NWB.twRealms[NWB.realm]
					and not NWB.krRealms[NWB.realm] and not string.match(destGUID, "Pet")) then
				--Only record world buff dispels and not other buffs.
				--Disabled on high layer regions, don't want to add any extra data to sync there.
			end
			local _, sourceClass = GetPlayerInfoByGUID(sourceGUID);
			local _, _, _, sourceHex = GetClassColor(sourceClass);
			local sourceWho = "|c" .. sourceHex .. sourceName .. "|r"
			local _, destClass = GetPlayerInfoByGUID(destGUID);
			local _, _, _, destHex = GetClassColor(destClass);
			local destWho = "|c" .. destHex .. destName .. "|r"
			local spell = "|cff71d5ff[" .. extraSpellName .. "]|r";
			if (string.match(sourceGUID, "Pet")) then
				sourceWho = sourceName .. " (Pet)";
			end
			if (destName == UnitName("player")) then
				if (NWB.db.global.dispelsMine and NWB.db.global.dispelsMineWBOnly and dispellableWorldBuffs[spellName]) then
					NWB:print(sourceWho .. NWB.chatColor .. " dispelled your " .. spell .. NWB.chatColor .. L["."]);
					NWB:playSound("soundsDispelsMine", "dispelsMine");
				elseif (NWB.db.global.dispelsMine) then
					NWB:print(sourceWho .. NWB.chatColor .. " dispelled your " .. spell .. NWB.chatColor .. L["."]);
					NWB:playSound("soundsDispelsMine", "dispelsMine");
				end
			else
				if (NWB.db.global.dispelsAll and NWB.db.global.dispelsAllWBOnly and dispellableWorldBuffs[spellName]) then
					NWB:print(sourceWho .. NWB.chatColor .. L[" dispelled "] .. destWho .. " " .. spell .. NWB.chatColor .. L["."]);
					NWB:playSound("soundsDispelsAll", "dispelsAll");
				elseif (NWB.db.global.dispelsAll) then
					NWB:print(sourceWho .. NWB.chatColor .. L[" dispelled "] .. destWho .. " " .. spell .. NWB.chatColor .. L["."]);
					NWB:playSound("soundsDispelsAll", "dispelsAll");
				end
			end
			
		end
	end
end

local rendLastSet, onyLastSet, nefLastSet, zanLastSet = 0, 0, 0, 0;
function NWB:setRendBuff(source, sender, zoneID, GUID, isAllianceAndLayered)
	--Check if this addon has already set a timer a few seconds before another addon's comm.
	if (source ~= "self" and (GetServerTime() - NWB.data.rendTimer) < 10) then
		return;
	end
	local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
	if (NWB.faction == "Horde" and zone ~= 1454 and zone ~= 1413) then
		NWB:debug("not in a valid zone to set rend timer");
		return;
	end
	if (NWB.faction == "Alliance" and zone ~= 1453 and zone ~= 1413) then
		NWB:debug("not in a valid zone to set rend timer");
		return;
	end
	if (not NWB:validateNewTimer("rend", source)) then
		NWB:debug("failed rend timer validation", source);
		return;
	end
	if (NWB.isLayered and tonumber(zoneID)) then
		local count = 0;
		for k, v in pairs(NWB.data.layers) do
			count = count + 1;
		end
		if (count <= NWB.limitLayerCount) then
			if (isAllianceAndLayered) then
				if (not NWB.data.layers[NWB.lastKnownLayerMapID]) then
					NWB:print(L["Got rend buff but no layer ID was found."]);
					return;
				elseif (NWB.lastKnownLayerMapID > 0) then
					zoneID = NWB.lastKnownLayerMapID;
					if (NWB.data.layers[zoneID]) then
						NWB.data.layers[zoneID].rendTimer = GetServerTime();
						NWB.data.layers[zoneID].rendTimerWho = sender;
						NWB.data.layers[zoneID].rendSource = source;
						NWB.data.layers[zoneID].rendYell = NWB.data.rendYell;
						NWB.data.layers[zoneID].rendYell2 = NWB.data.rendYell2;
						NWB:timerLog("rendTimer", GetServerTime(), zoneID);
					end
				else
					return;
				end
			else
				if (not NWB.data.layers[zoneID]) then
					NWB:createNewLayer(zoneID, GUID);
				end
				if (NWB.data.layers[zoneID]) then
					NWB.data.layers[zoneID].rendTimer = GetServerTime();
					NWB.data.layers[zoneID].rendTimerWho = sender;
					NWB.data.layers[zoneID].rendSource = source;
					NWB.data.layers[zoneID].rendYell = NWB.data.rendYell;
					NWB.data.layers[zoneID].rendYell2 = NWB.data.rendYell2;
					NWB:timerLog("rendTimer", GetServerTime(), zoneID);
				end
			end
		end
	end
	--Keep recording older non layered data for now.
	NWB.data.rendTimer = GetServerTime();
	NWB.data.rendTimerWho = sender;
	NWB.data.rendSource = source;
	NWB:resetWarningTimers("rend", zoneID);
	NWB:sendData("GUILD");
	if (not NWB.isLayered) then
		NWB:timerLog("rendTimer", GetServerTime());
	end
	local count = 0;
	--Once per drop one guild member will say in chat it dropped.
	--Throddle the drop msg for when we get multiple sources at the same drop time.
	if ((GetServerTime() - rendLastSet) > 60) then
		if (NWB.db.global.guildBuffDropped == 1 and (NWB.faction == "Horde" or NWB.db.global.allianceEnableRend)) then
			if (zoneID) then
				for k, v in NWB:pairsByKeys(NWB.data.layers) do
					count = count + 1;
					if (k == zoneID) then
						break;
					end
				end
			end
			--NWB:sendGuildMsg(L["rendBuffDropped"] .. layerMsg, "guildBuffDropped");
		end
		if (NWB.isLayered and count > 0) then
			NWB:sendBuffDropped("GUILD", "rend", nil, count);
			--NWB:doBuffDropMsg("rend " .. count);
			NWB:doBuffDropMsg("rend", count);
		else
			NWB:sendBuffDropped("GUILD", "rend");
			NWB:doBuffDropMsg("rend");
		end
	end
	rendLastSet = GetServerTime();
	NWB:debug("set rend buff", source);
	--NWB.data.myChars[UnitName("player")].rendCount = NWB.data.myChars[UnitName("player")].rendCount + 1;
	NWB:debug("zoneid drop", zoneID, count, GUID);
end

function NWB:setZanBuff(source, sender, zoneID, GUID)
	--Disabled, there is no cooldown, will remove all the zand timer code at a later point.
	--[[if (not NWB.zand) then
		return;
	end
	NWB:debug("6");
	if (source ~= "self" and (GetServerTime() - NWB.data.zanTimer) < 10) then
		return;
	end
	if (not NWB:validateNewTimer("zan", source)) then
		NWB:debug("failed zan timer validation", source);
		return;
	end
	NWB:debug("7");
	NWB.data.zanTimer = GetServerTime();
	NWB.data.zanTimerWho = sender;
	NWB.data.zanSource = source;
	NWB:resetWarningTimers("zan", zoneID);
	NWB:sendData("GUILD");
	--Once per drop one guild member will say in chat it dropped.
	--Throddle the drop msg for when we get multiple sources at the same drop time.
	if ((GetServerTime() - zanLastSet) > 120) then
		if (NWB.db.global.guildBuffDropped == 1) then
			NWB:sendGuildMsg(L["zanBuffDropped"], "guildBuffDropped");
		end
	end
	zanLastSet = GetServerTime();
	NWB:debug("set zan buff", source);]]
	--NWB.data.myChars[UnitName("player")].zanCount = NWB.data.myChars[UnitName("player")].zanCount + 1;
	NWB:debug("zoneid drop", zoneID, GUID);
end

function NWB:setOnyBuff(source, sender, zoneID, GUID, isSapped)
	--Ony and nef share a last set cooldown to prevent any bugs with both being set at once.
	if ((GetServerTime() - nefLastSet) < 20) then
		return;
	end
	local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
	if (NWB.faction == "Horde" and zone ~= 1454 and zone ~= 1413) then
		NWB:debug("not in a valid zone to set rend timer");
		return;
	end
	if (NWB.faction == "Alliance" and zone ~= 1453 and zone ~= 1413) then
		NWB:debug("not in a valid zone to set rend timer");
		return;
	end
	if (source ~= "self" and (GetServerTime() - NWB.data.onyTimer) < 10) then
		return;
	end
	if (not NWB:validateNewTimer("ony", source)) then
		NWB:debug("failed ony timer validation", source);
		return;
	end
	if (NWB.isLayered and tonumber(zoneID)) then
		local count = 0;
		for k, v in pairs(NWB.data.layers) do
			count = count + 1;
		end
		if (count <= NWB.limitLayerCount) then
			if (not NWB.data.layers[zoneID]) then
				NWB:createNewLayer(zoneID, GUID);
			end
			if (NWB.data.layers[zoneID]) then
				NWB.data.layers[zoneID].onyTimer = GetServerTime();
				NWB.data.layers[zoneID].onyTimerWho = sender;
				NWB.data.layers[zoneID].onyNpcDied = 0;
				NWB.data.layers[zoneID].onySource = source;
				NWB.data.layers[zoneID].onyYell = NWB.data.onyYell;
				NWB.data.layers[zoneID].onyYell2 = NWB.data.onyYell2;
				NWB:timerLog("onyTimer", GetServerTime(), zoneID);
			end
		end
	end
	NWB.data.onyTimer = GetServerTime();
	NWB.data.onyTimerWho = sender;
	NWB.data.onyNpcDied = 0;
	NWB.data.onySource = source;
	NWB:resetWarningTimers("ony", zoneID);
	NWB:sendData("GUILD");
	if (not NWB.isLayered) then
		NWB:timerLog("onyTimer", GetServerTime());
	end
	local count = 0;
	if ((GetServerTime() - onyLastSet) > 60) then
		local count = 0;
		if (NWB.db.global.guildBuffDropped == 1) then
			if (zoneID) then
				for k, v in NWB:pairsByKeys(NWB.data.layers) do
					count = count + 1;
					if (k == zoneID) then
						break;
					end
				end
			end
			--NWB:sendGuildMsg(L["onyxiaBuffDropped"] .. layerMsg, "guildBuffDropped");
		end
		if (NWB.isLayered and count > 0 and not isSapped) then
			NWB:sendBuffDropped("GUILD", "ony", nil, count);
			--NWB:doBuffDropMsg("ony " .. count);
			NWB:doBuffDropMsg("ony", count);
		elseif (not isSapped) then
			NWB:sendBuffDropped("GUILD", "ony");
			NWB:doBuffDropMsg("ony");
		end
	end
	onyLastSet = GetServerTime();
	NWB:debug("set ony buff", source);
	--NWB.data.myChars[UnitName("player")].onyCount = NWB.data.myChars[UnitName("player")].onyCount + 1;
	NWB:debug("zoneid drop", zoneID, count, GUID);
	if (isSapped) then
		NWB:sendData("YELL");
	end
end

function NWB:setNefBuff(source, sender, zoneID, GUID)
	--Ony and nef share a last set cooldown to prevent any bugs with both being set at once.
	if ((GetServerTime() - onyLastSet) < 20) then
		return;
	end
	if (source ~= "self" and (GetServerTime() - NWB.data.nefTimer) < 10) then
		return;
	end
	local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
	if (NWB.faction == "Horde" and zone ~= 1454 and zone ~= 1413) then
		NWB:debug("not in a valid zone to set rend timer");
		return;
	end
	if (NWB.faction == "Alliance" and zone ~= 1453 and zone ~= 1413) then
		NWB:debug("not in a valid zone to set rend timer");
		return;
	end
	if (not NWB:validateNewTimer("nef", source)) then
		NWB:debug("failed nef timer validation", source);
		return;
	end
	if (NWB.isLayered and tonumber(zoneID)) then
		local count = 0;
		for k, v in pairs(NWB.data.layers) do
			count = count + 1;
		end
		if (count <= NWB.limitLayerCount) then
			if (not NWB.data.layers[zoneID]) then
				NWB:createNewLayer(zoneID, GUID);
			end
			if (NWB.data.layers[zoneID]) then
				NWB.data.layers[zoneID].nefTimer = GetServerTime();
				NWB.data.layers[zoneID].nefTimerWho = sender;
				NWB.data.layers[zoneID].nefNpcDied = 0;
				NWB.data.layers[zoneID].nefSource = source;
				NWB.data.layers[zoneID].nefYell = NWB.data.nefYell;
				NWB.data.layers[zoneID].nefYell2 = NWB.data.nefYell2;
				NWB:timerLog("nefTimer", GetServerTime(), zoneID);
			end
		end
	end
	NWB.data.nefTimer = GetServerTime();
	NWB.data.nefTimerWho = sender;
	NWB.data.nefNpcDied = 0;
	NWB.data.nefSource = source;
	NWB:resetWarningTimers("nef", zoneID);
	NWB:sendData("GUILD");
	if (not NWB.isLayered) then
		NWB:timerLog("nefTimer", GetServerTime());
	end
	local count = 0;
	if ((GetServerTime() - nefLastSet) > 60) then
		local count = 0;
		if (NWB.db.global.guildBuffDropped == 1) then
			if (zoneID) then
				for k, v in NWB:pairsByKeys(NWB.data.layers) do
					count = count + 1;
					if (k == zoneID) then
						break;
					end
				end
			end
			--NWB:sendGuildMsg(L["nefarianBuffDropped"] .. layerMsg, "guildBuffDropped");
		end
		if (NWB.isLayered and count > 0) then
			NWB:sendBuffDropped("GUILD", "nef", nil, count);
			--NWB:doBuffDropMsg("nef " .. count);
			NWB:doBuffDropMsg("nef", count);
		else
			NWB:sendBuffDropped("GUILD", "nef");
			NWB:doBuffDropMsg("nef");
		end
	end
	nefLastSet = GetServerTime();
	NWB:debug("set nef buff", source);
	--NWB.data.myChars[UnitName("player")].nefCount = NWB.data.myChars[UnitName("player")].nefCount + 1;
	NWB:debug("zoneid drop", zoneID, count, GUID);
end

--Validate new timer, mostly used for testing blanket fixes for timers.
function NWB:validateNewTimer(type, source, timestamp)
	if (type == "rend") then
		return true;
	elseif (type == "ony") then
		if (source == "dbm") then
			local timer = NWB.data.onyTimer;
			local respawnTime = NWB.db.global.onyRespawnTime;
			if ((timer - 30) > (GetServerTime() - respawnTime) and not (NWB.data.onyNpcDied > timer)) then
				--Don't set dbm timers if valid timer already exists (current bug).
				NWB:debug("trying to set timer from dbm when timer already exists");
				return;
			end
		end
		if (NWB.data.nefTimer == timestamp or NWB.data.nefTimer == GetServerTime()) then
			NWB:debug("ony trying to set exact same timer as nef", source);
			--Make sure ony never syncs with nef time stamp (current bug).
			return;
		end
	elseif (type == "nef") then
		if (NWB.data.onyTimer == timestamp or NWB.data.onyTimer == GetServerTime()) then
			NWB:debug("nef trying to set exact same timer as ony", source);
			--Make sure nef never syncs with ony time stamp (current bug).
			return;
		end
	end
	--If this is a realm with layering still (TW/CN) then don't overwrite timers ever, atleast 1 layer will be correct then.
	--Really not sure why Blizzard still have layering in these asian regions.
	--if (NWB.isLayered and NWB.data[type .. "Timer"]
		--Disabled for now for new layer tracking method.
	--		and (NWB.data[type .. "Timer"] > (GetServerTime() - NWB.db.global[type .. "RespawnTime"]))) then
	--	return;
	--end
	return true;
end

function NWB:validateTimestamp(timestamp)
	local currentTime = GetServerTime();
	if (not tonumber(timestamp)) then
		return;
	end
	if (timestamp > 2585912598) then
		return;
	end
	if (timestamp > (currentTime + 30000)) then
		return;
	end
	return true;
end

--Track our current buff durations across all chars.
local gotPlayedData;
function NWB:trackNewBuff(spellName, type)
	if (not NWB.data.myChars[UnitName("player")].buffs[spellName]) then
		NWB.data.myChars[UnitName("player")].buffs[spellName] = {};
	end
	if (not NWB.data.myChars[UnitName("player")].buffs[spellName].setTime) then
		NWB.data.myChars[UnitName("player")].buffs[spellName].setTime = 0;
	end
	if (not NWB.data.myChars[UnitName("player")].buffs[spellName].timeLeft) then
		NWB.data.myChars[UnitName("player")].buffs[spellName].timeLeft = 0;
	end
	if (not NWB.data.myChars[UnitName("player")][type .. "Count"]) then
		NWB.data.myChars[UnitName("player")][type .. "Count"] = 0;
	end
	NWB.data.myChars[UnitName("player")][type .. "Count"] = NWB.data.myChars[UnitName("player")][type .. "Count"] + 1;
	NWB.data.myChars[UnitName("player")].buffs[spellName].type = type;
	--Set timestamp as a backup to calc from when dmf buff is got.
	NWB.data.myChars[UnitName("player")].buffs[spellName].setTime = GetServerTime();
	NWB.data.myChars[UnitName("player")].buffs[spellName].track = true;
	--Request played data when getting new buff drops to calc from as primary.
	--Use local cache if we have a valid number from RequestTimePlayed() at logon, otherwise request new data.
	if (NWB.played > 600) then
		NWB.data.myChars[UnitName("player")].buffs[spellName].playedCacheSetAt = NWB.played;
		NWB:syncBuffsWithCurrentDuration();
		NWB:recalcBuffTimers();
	else
		NWB.currentTrackBuff = NWB.data.myChars[UnitName("player")].buffs[spellName];
		--Hide the msg from chat.
		if (not gotPlayedData) then
			DEFAULT_CHAT_FRAME:UnregisterEvent("TIME_PLAYED_MSG");
			gotPlayedData = true;
			RequestTimePlayed();
		end
	end
	if (type == "dmf") then
		NWB:print(string.format(L["dmfBuffDropped"], spellName));
	end
	NWB:debug("Tracking new buff", type, spellName);
	NWB:recalcBuffListFrame();
end

function NWB:untrackBuff(spellName)
	if (NWB.data.myChars[UnitName("player")].buffs and NWB.data.myChars[UnitName("player")].buffs[spellName]) then
		NWB.data.myChars[UnitName("player")].buffs[spellName].track = false;
		NWB:recalcBuffListFrame();
	end
end

--Recalc time left on buffs we track.
--We recalc it from current total played time vs total played we recorded at time of buff drop.
function NWB:recalcBuffTimers()
	if (NWB.data.myChars[UnitName("player")].buffs) then
		for k, v in pairs(NWB.data.myChars[UnitName("player")].buffs) do
			if (not v.timeLeft or not v.setTime) then
				NWB.data.myChars[UnitName("player")].buffs[k] = nil;
			else
				if (not gotPlayedData) then
					NWB:debug("no played data found");
					return
				end
				if (not v.playedCacheSetAt) then
					v.playedCacheSetAt = 0;
				end
				--Calc the difference between current total played time and the played time we record when buff was gotten.
				v.timeLeft = NWB.db.global[v.type .. "BuffTime"] - (NWB.played - v.playedCacheSetAt);
				--NWB.data.myChars[UnitName("player")].buffs[k].timeLeft = NWB.db.global[v.type .. "BuffTime"] - (NWB.played - v.playedCacheSetAt);
			end
		end
	end
	NWB:recalcBuffListFrame();
end

--/played can sometimes drift a bit with buff durations, probably due to loads times and such.
--Here we resync the buff tracking with current buff durations.
--And pick up any buffs not being tracked already for whenever reason.
local spellTypes = {			
	[16609] = "rend",
	[22888] = "ony",
	--[22888] = "nef",
	[24425] = "zan",
	[23768] = "dmf", --Sayge's Dark Fortune of Damage
	[23769] = "dmf", --Sayge's Dark Fortune of Resistance
	[23767] = "dmf", --Sayge's Dark Fortune of Armor
	[23766] = "dmf", --Sayge's Dark Fortune of Intelligence
	[23738] = "dmf", --Sayge's Dark Fortune of Spirit
	[23737] = "dmf", --Sayge's Dark Fortune of Stamina
	[23735] = "dmf", --Sayge's Dark Fortune of Strength
	[23736] = "dmf", --Sayge's Dark Fortune of Agility
	[22818] = "moxie",
	[22817] = "ferocity",
	[22820] = "savvy",
	[17628] = "flaskPower", --Supreme Power.
	[17626] = "flaskTitans", --Flask of the Titans (only flask spell with Flask in the name, dunno why).
	[17627] = "flaskWisdom", --Distilled Wisdom.
	[17629] = "flaskResistance", --Chromatic Resistance.
	[15366] = "songflower",
	[15123] = "resistFire", --LBRS fire resist buff.
	[8733] = "blackfathom", --Blessing of Blackfathom
	[29235] = "festivalFortitude", --Fire Festival Fortitude
	[29846] = "festivalFury", --Fire Festival Fury
	[29338] = "festivalFury", --Fire Festival Fury 2 diff types? aoe and single version possibly?
	[29175] = "ribbonDance", --Fire Festival Fortitude
	[29534] = "silithyst", --Traces of Silithyst
};
function NWB:syncBuffsWithCurrentDuration()
	for i = 1, 32 do
		local spellName, _, _, _, _, expirationTime, _, _, _, spellID = UnitBuff("player", i);
		if (NWB.data.myChars[UnitName("player")].buffs and NWB.data.myChars[UnitName("player")].buffs[spellName]) then
			if (NWB.played > 600) then
				if (not spellTypes[spellID]) then
					return;
				end
				local type = NWB.data.myChars[UnitName("player")].buffs[spellName].type;
				local timeLeft = expirationTime - GetTime();
				local maxDuration = NWB.db.global[type .. "BuffTime"] or 0;
				local elapsedDuration = maxDuration - timeLeft;
				local newPlayedCache = NWB.played - elapsedDuration;
				if (timeLeft > 0) then
					NWB.data.myChars[UnitName("player")].buffs[spellName].track = true;
				end
				--Change the played seconds this was buff was set at to match the current time elapsed on our current buff.
				NWB.data.myChars[UnitName("player")].buffs[spellName].playedCacheSetAt = math.floor(newPlayedCache);
				--NWB:debug("resyncing tracked buff", spellName);
				if (not NWB.data.myChars[UnitName("player")][spellTypes[spellID] .. "Count"]
						or NWB.data.myChars[UnitName("player")][spellTypes[spellID] .. "Count"] == 0) then
					NWB.data.myChars[UnitName("player")][spellTypes[spellID] .. "Count"] = 1;
				end
			end
		elseif (spellTypes[spellID]) then
			if (NWB.played > 600) then
				local type = spellTypes[spellID];
				NWB.data.myChars[UnitName("player")].buffs[spellName] = {};
				NWB.data.myChars[UnitName("player")].buffs[spellName].type = type;
				local timeLeft = expirationTime - GetTime();
				local maxDuration = NWB.db.global[type .. "BuffTime"] or 0;
				local elapsedDuration = maxDuration - timeLeft;
				local newPlayedCache = NWB.played - elapsedDuration;
				NWB.data.myChars[UnitName("player")].buffs[spellName].timeLeft = timeLeft;
				NWB.data.myChars[UnitName("player")].buffs[spellName].setTime = GetServerTime();
				NWB.data.myChars[UnitName("player")].buffs[spellName].track = true;
				--Change the played seconds this was buff was set at to match the current time elapsed on our current buff.
				NWB.data.myChars[UnitName("player")].buffs[spellName].playedCacheSetAt = math.floor(newPlayedCache);
				NWB:debug("resyncing2 tracked buff", spellName);
				if (not NWB.data.myChars[UnitName("player")][spellTypes[spellID] .. "Count"]
						or NWB.data.myChars[UnitName("player")][spellTypes[spellID] .. "Count"] == 0) then
					NWB.data.myChars[UnitName("player")][spellTypes[spellID] .. "Count"] = 1;
				end
			end
		end
	end
	NWB:recalcBuffTimers();
end

--Played time data received, update local cache.
function NWB:timePlayedMsg(...)
	local totalPlayed = ...;
	--Update played cache for ticker when /played data received.
	if (totalPlayed > 0) then
		NWB.played = totalPlayed;
	end
	--Only set the total played seconds at time of a new buff drop we track.
	if (totalPlayed > 0 and NWB.currentTrackBuff ~= nil) then
		NWB.currentTrackBuff.playedCacheSetAt = totalPlayed;
		--NWB:recalcBuffTimers();
		NWB.currentTrackBuff = nil;
	end
	--Reregister the chat frame event after we're done.
	--C_Timer.After(5, function()
		DEFAULT_CHAT_FRAME:RegisterEvent("TIME_PLAYED_MSG");
	--end)
	NWB:syncBuffsWithCurrentDuration();
	NWB:recalcBuffTimers();
end

--This only runs once at load time.
function NWB:setLayered()
	--This needs to be changed to a table later.
	--TW realms.
	if (NWB.usRealms[NWB.realm] or NWB.euRealms[NWB.realm] or NWB.krRealms[NWB.realm] or NWB.twRealms[NWB.realm]
			or NWB.cnRealms[NWB.realm]) then
		NWB.isLayered = true;
	end
end

function NWB:setLayerLimit()
	if (fsdfsfs) then
		NWB.limitLayerCount = 2;
	end
end

--Make sure warning msg values are correct for the current time left on each timer.
function NWB:timerCleanup()
	local types = {
		[1] = "rend",
		[2] = "ony",
		[3] = "nef",
		--[4] = "zan"
	};
	for k, v in pairs(types) do
		local offset = 0;
		if (NWB.isLayered) then
			for layer, value in NWB:pairsByKeys(NWB.data.layers) do
				if (v == "rend") then
					offset = NWB.db.global.rendRespawnTime;
					NWB:resetWarningTimers("rend", layer);
				elseif (v == "ony") then
					offset = NWB.db.global.onyRespawnTime;
					NWB:resetWarningTimers("ony", layer);
				elseif (v == "nef") then
					offset = NWB.db.global.nefRespawnTime;
					NWB:resetWarningTimers("nef", layer);
				--elseif (v == "zan") then
				--	offset = NWB.db.global.zanRespawnTime;
				--	NWB:resetWarningTimers("zan", layer);
				end
				--Clear warning timers that ended while we were offline or if NPC was killed since last buff.
				if (NWB.data.layers[layer][v .. "NpcDied"]
						and NWB.data.layers[layer][v .. "NpcDied"] > (GetServerTime() - NWB.db.global[v .. "RespawnTime"])) then
					NWB.data.layers[layer][v .. "30"] = nil;
					NWB.data.layers[layer][v .. "15"] = nil;
					NWB.data.layers[layer][v .. "10"] = nil;
					NWB.data.layers[layer][v .. "5"] = nil;
					NWB.data.layers[layer][v .. "1"] = nil;
					NWB.data.layers[layer][v .. "0"] = nil;
				elseif (NWB.data.layers[layer][v .. "Timer"]
						and ((NWB.data.layers[layer][v .. "Timer"] + offset) - GetServerTime()) < 0) then
					NWB.data.layers[layer][v .. "30"] = nil;
					NWB.data.layers[layer][v .. "15"] = nil;
					NWB.data.layers[layer][v .. "10"] = nil;
					NWB.data.layers[layer][v .. "5"] = nil;
					NWB.data.layers[layer][v .. "1"] = nil;
					NWB.data.layers[layer][v .. "0"] = nil;
				elseif (NWB.data.layers[layer][v .. "Timer"]
						and ((NWB.data.layers[layer][v .. "Timer"] + offset) - GetServerTime()) < 60) then
					NWB.data.layers[layer][v .. "30"] = nil;
					NWB.data.layers[layer][v .. "15"] = nil;
					NWB.data.layers[layer][v .. "10"] = nil;
					NWB.data.layers[layer][v .. "5"] = nil;
					NWB.data.layers[layer][v .. "1"] = nil;
				elseif (NWB.data.layers[layer][v .. "Timer"]
						and ((NWB.data.layers[layer][v .. "Timer"] + offset) - GetServerTime()) < 300) then
					NWB.data.layers[layer][v .. "30"] = nil;
					NWB.data.layers[layer][v .. "15"] = nil;
					NWB.data.layers[layer][v .. "10"] = nil;
					NWB.data.layers[layer][v .. "5"] = nil;
				elseif (NWB.data.layers[layer][v .. "Timer"]
						and ((NWB.data.layers[layer][v .. "Timer"] + offset) - GetServerTime()) < 600) then
					NWB.data.layers[layer][v .. "30"] = nil;
					NWB.data.layers[layer][v .. "15"] = nil;
					NWB.data.layers[layer][v .. "10"] = nil;
				elseif (NWB.data.layers[layer][v .. "Timer"]
						and ((NWB.data.layers[layer][v .. "Timer"] + offset) - GetServerTime()) < 900) then
					NWB.data.layers[layer][v .. "30"] = nil;
					NWB.data.layers[layer][v .. "15"] = nil;
				elseif (NWB.data.layers[layer][v .. "Timer"]
						and ((NWB.data.layers[layer][v .. "Timer"] + offset) - GetServerTime()) < 1800) then
					NWB.data.layers[layer][v .. "30"] = nil;
				end
			end
		else
			if (v == "rend") then
				offset = NWB.db.global.rendRespawnTime;
				NWB:resetWarningTimers("rend");
			elseif (v == "ony") then
				offset = NWB.db.global.onyRespawnTime;
				NWB:resetWarningTimers("ony");
			elseif (v == "nef") then
				offset = NWB.db.global.nefRespawnTime;
				NWB:resetWarningTimers("nef");
			--elseif (v == "zan") then
			--	offset = NWB.db.global.zanRespawnTime;
			--	NWB:resetWarningTimers("zan");
			end
			--Clear warning timers that ended while we were offline or if NPC was killed since last buff.
			if (NWB.data[v .. "NpcDied"] and NWB.data[v .. "NpcDied"] > (GetServerTime() - NWB.db.global[v .. "RespawnTime"])) then
				NWB.data[v .. "30"] = nil;
				NWB.data[v .. "15"] = nil;
				NWB.data[v .. "10"] = nil;
				NWB.data[v .. "5"] = nil;
				NWB.data[v .. "1"] = nil;
				NWB.data[v .. "0"] = nil;
			elseif (((NWB.data[v .. "Timer"] + offset) - GetServerTime()) < 0) then
				NWB.data[v .. "30"] = nil;
				NWB.data[v .. "15"] = nil;
				NWB.data[v .. "10"] = nil;
				NWB.data[v .. "5"] = nil;
				NWB.data[v .. "1"] = nil;
				NWB.data[v .. "0"] = nil;
			elseif (((NWB.data[v .. "Timer"] + offset) - GetServerTime()) < 60) then
				NWB.data[v .. "30"] = nil;
				NWB.data[v .. "15"] = nil;
				NWB.data[v .. "10"] = nil;
				NWB.data[v .. "5"] = nil;
				NWB.data[v .. "1"] = nil;
			elseif (((NWB.data[v .. "Timer"] + offset) - GetServerTime()) < 300) then
				NWB.data[v .. "30"] = nil;
				NWB.data[v .. "15"] = nil;
				NWB.data[v .. "10"] = nil;
				NWB.data[v .. "5"] = nil;
			elseif (((NWB.data[v .. "Timer"] + offset) - GetServerTime()) < 600) then
				NWB.data[v .. "30"] = nil;
				NWB.data[v .. "15"] = nil;
				NWB.data[v .. "10"] = nil;
			elseif (((NWB.data[v .. "Timer"] + offset) - GetServerTime()) < 900) then
				NWB.data[v .. "30"] = nil;
				NWB.data[v .. "15"] = nil;
			elseif (((NWB.data[v .. "Timer"] + offset) - GetServerTime()) < 1800) then
				NWB.data[v .. "30"] = nil;
			end
		end
	end
end

--Reset and enable all warning msgs for specified timer.
function NWB:resetWarningTimers(type, layer)
	if (NWB.isLayered and layer) then
		NWB.data.layers[layer][type .. "30"] = true;
		NWB.data.layers[layer][type .. "15"] = true;
		NWB.data.layers[layer][type .. "10"] = true;
		NWB.data.layers[layer][type .. "5"] = true;
		NWB.data.layers[layer][type .. "1"] = true;
		NWB.data.layers[layer][type .. "0"] = true;
	else
		NWB.data[type .. "30"] = true;
		NWB.data[type .. "15"] = true;
		NWB.data[type .. "10"] = true;
		NWB.data[type .. "5"] = true;
		NWB.data[type .. "1"] = true;
		NWB.data[type .. "0"] = true;
	end
end

local f = CreateFrame("Frame");
f:RegisterEvent("PLAYER_ENTERING_WORLD");
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
f:RegisterEvent("CHAT_MSG_MONSTER_YELL");
f:RegisterEvent("GROUP_JOINED");
f:RegisterEvent("TIME_PLAYED_MSG");
f:RegisterEvent("PLAYER_LOGIN");
f:RegisterEvent("CHAT_MSG_WHISPER");
f:RegisterEvent("CHAT_MSG_BN_WHISPER");
f:RegisterEvent("CHAT_MSG_SYSTEM");
f:RegisterEvent("CHAT_MSG_ADDON");
f:RegisterEvent("GUILD_ROSTER_UPDATE");
local doLogon = true;
f:SetScript("OnEvent", function(self, event, ...)
	if (event == "PLAYER_LOGIN") then
		--Testing this here instead of PLAYER_ENTERING_WORLD, maybe it fires slightly faster enough to stop duplicate msgs.
		NWB.loadTime = GetServerTime();
		--if (IsInGuild()) then
			--C_ChatInfo.SendAddonMessage(NWB.commPrefix, NWB.serializer:Serialize("ping " .. version), "GUILD");
		--end
		NWB:requestData("GUILD", nil, "ALERT");
		self:RegisterEvent("CHAT_MSG_GUILD");
		C_Timer.After(30, function()
			NWB:syncBuffsWithCurrentDuration();
		end)
	elseif (event == "PLAYER_ENTERING_WORLD") then
		if (doLogon) then
			--Refresh map stuff after login, loading them at initialize creates a bug with them not showing up until you move sometimes.
			C_Timer.After(5, function()
				NWB:refreshFelwoodMarkers();
				NWB:refreshWorldbuffMarkers();
			end)
			GuildRoster();
			if (NWB.db.global.logonPrint) then
				C_Timer.After(10, function()
					GuildRoster(); --Attempting to fix slow guild roster update at logon.
					NWB:printBuffTimers(true);
				end);
			end
			--If WorldBuffTimers isn't installed then send it's data request to guild.
			--if (not WorldBuffTracker_HandleSync and IsInGuild()) then
			--	C_ChatInfo.SendAddonMessage("WBT-0", 11326, "GUILD");
			--end
			--First request after logon is high prio so gets sent right away, need to register addon users asap so no duplicate guild msgs.
			--NWB:requestData("GUILD", nil, "ALERT");
			C_Timer.After(5, function()
				--Only request played data at logon if we didn't get it already for some reason.
				if (not gotPlayedData) then
					gotPlayedData = true;
					DEFAULT_CHAT_FRAME:UnregisterEvent("TIME_PLAYED_MSG");
					RequestTimePlayed();
				end
			end)
			doLogon = nil;
		end
		C_Timer.After(2, function()
			--Ghost check, no need to spam addon comms when a 40 man raid wipes.
			if (not UnitIsGhost("player")) then
				NWB:sendData("YELL");
			end
		end);
	elseif (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		NWB:combatLogEventUnfiltered(...);
	elseif (event == "CHAT_MSG_MONSTER_YELL") then
		NWB:monsterYell(...);
	elseif (event == "GROUP_JOINED") then
		--Skip party sync close to logon, no need to fill up the addon comm bandwidth further.
		--This event fires at logon if grouped already.
		if (GetServerTime() - NWB.loadTime > 60) then
			C_Timer.After(5, function()
				if (UnitInBattleground("player")) then
					return;
				end
				if (IsInRaid()) then
	  				NWB:sendData("RAID");
	  			elseif (IsInGroup()) then
	  				NWB:sendData("PARTY");
	  			end
	  		end)
  		end
  	elseif (event == "CHAT_MSG_GUILD") then
  		NWB:chatMsgGuild(...);
	elseif (event == "TIME_PLAYED_MSG") then
		gotPlayedData = true;
		NWB:timePlayedMsg(...);
	elseif (event == "CHAT_MSG_WHISPER") then
		local _, name = ...;
		NWB.lastWhisper = name;
		NWB.lastWhisperType = "whisper";
	elseif (event == "CHAT_MSG_BN_WHISPER") then
		local _, name, _, _, _, _, _, _, _, _, _, _, presenceID = ...;
		NWB.lastWhisper = presenceID;
		NWB.lastWhisperType = "bnet";
	elseif (event == "CHAT_MSG_SYSTEM") then
		local text = ...;
		local who = string.match(text, string.gsub(ERR_GUILD_JOIN_S, "%%s", "(.+)"));
		if (who == UnitName("player")) then
			--Register ourself to other addon users when joining a guild.
			NWB:requestData("GUILD", nil, "ALERT");
		end
	elseif (event == "CHAT_MSG_ADDON") then
		local commPrefix, string, distribution, sender = ...;
		if (commPrefix == NWB.commPrefix and distribution == "GUILD") then
			local normalizedWho = string.gsub(sender, " ", "");
			normalizedWho = string.gsub(normalizedWho, "'", "");
			if (not string.match(normalizedWho, "-")) then
				--Sometimes it comes through without realm in classic?
				normalizedWho = normalizedWho .. "-" .. GetNormalizedRealmName();
			end
			if (not NWB.hasAddon[normalizedWho]) then
				NWB.hasAddon[normalizedWho] = "0";
			end
		end
	elseif (event == "GUILD_ROSTER_UPDATE") then
		NWB:checkGuildMasterSetting("set");
	end
end)

--Flight paths.
local doCheckLeaveFlghtPath = false;
hooksecurefunc("TakeTaxiNode", function(...)
	doCheckLeaveFlghtPath = true;
    --Give it a few seconds to get on the taxi.
    C_Timer.After(5, function()
		NWB.checkLeaveFlghtPath();
		--Wipe felwood songflower detected players when leaving.
		NWB.detectedPlayers = {};
	end)
	NWB:sendData("YELL");
end)

--Loop this func till flight path is left.
function NWB.checkLeaveFlghtPath()
    local isOnFlightPath = UnitOnTaxi("player");
    if (not isOnFlightPath) then
    	doCheckLeaveFlghtPath = false;
    	--Send data to people close when dismounting a flightpath.
    	NWB:sendData("YELL");
    end
    if (doCheckLeaveFlghtPath) then
    	C_Timer.After(2, function()
			NWB.checkLeaveFlghtPath();
		end)
	end
end

--Convert seconds to a readable format.
--[[function NWB:getTimeString(seconds, countOnly, short)
	local timecalc = 0;
	if (countOnly) then
		timecalc = seconds;
	else
		timecalc = seconds - time();
	end
	local d = math.floor((timecalc % (86400*365)) / 86400);
	local h = math.floor((timecalc % 86400) / 3600);
	local m = math.floor((timecalc % 3600) / 60);
	local s = math.floor((timecalc % 60));
	local space = "";
	if (LOCALE_koKR or LOCALE_zhCN or LOCALE_zhTW) then
		space = "";
	end
	if (short) then
		if (d == 1 and h == 0) then
			return d .. L["dayShort"];
		elseif (d == 1) then
			return d .. L["dayShort"] .. space .. h .. L["hourShort"];
		end
		if (d > 1 and h == 0) then
			return d .. L["dayShort"];
		elseif (d > 1) then
			return d .. L["dayShort"] .. space .. h .. L["hourShort"];
		end
		if (h == 1 and m == 0) then
			return h .. L["hourShort"];
		elseif (h == 1) then
			return h .. L["hourShort"] .. space .. m .. L["minuteShort"];
		end
		if (h > 1 and m == 0) then
			return h .. L["hourShort"];
		elseif (h > 1) then
			return h .. L["hourShort"] .. space .. m .. L["minuteShort"];
		end
		if (m == 1 and s == 0) then
			return m .. L["minuteShort"];
		elseif (m == 1) then
			return m .. L["minuteShort"] .. space .. s .. L["secondShort"];
		end
		if (m > 1 and s == 0) then
			return m .. L["minuteShort"];
		elseif (m > 1) then
			return m .. L["minuteShort"] .. space .. s .. L["secondShort"];
		end
		--If no matches it must be seconds only.
		return s .. L["secondShort"];
	else
		if (d == 1 and h == 0) then
			return d .. "" .. L["day"];
		elseif (d == 1) then
			return d .. "" .. L["day"] .. "" .. h .. "" .. L["hours"];
		end
		if (d > 1 and h == 0) then
			return d .. "" .. L["days"];
		elseif (d > 1) then
			return d .. "" .. L["days"] .. "" .. h .. "" .. L["hours"];
		end
		if (h == 1 and m == 0) then
			return h .. "" .. L["hour"];
		elseif (h == 1) then
			return h .. "" .. L["hour"] .. "" .. m .. "" .. L["minutes"];
		end
		if (h > 1 and m == 0) then
			return h .. "" .. L["hours"];
		elseif (h > 1) then
			return h .. "" .. L["hours"] .. "" .. m .. "" .. L["minutes"];
		end
		if (m == 1 and s == 0) then
			return m .. "" .. L["minute"];
		elseif (m == 1) then
			return m .. "" .. L["minute"] .. "" .. s .. "" .. L["seconds"];
		end
		if (m > 1 and s == 0) then
			return m .. "" .. L["minutes"];
		elseif (m > 1) then
			return m .. "" .. L["minutes"] .. "" .. s .. "" .. L["seconds"];
		end
		--If no matches it must be seconds only.
		return s .. "" .. L["seconds"];
	end
end]]

--Convert seconds to a readable format.
function NWB:getTimeString(seconds, countOnly, type, space)
	local timecalc = 0;
	if (countOnly) then
		timecalc = seconds;
	else
		timecalc = seconds - time();
	end
	local d = math.floor((timecalc % (86400*365)) / 86400);
	local h = math.floor((timecalc % 86400) / 3600);
	local m = math.floor((timecalc % 3600) / 60);
	local s = math.floor((timecalc % 60));
	if (space or LOCALE_koKR or LOCALE_zhCN or LOCALE_zhTW) then
		space = " ";
	else
		space = "";
	end
	if (type == "short") then
		if (d == 1 and h == 0) then
			return d .. L["dayShort"];
		elseif (d == 1) then
			return d .. L["dayShort"] .. space .. h .. L["hourShort"];
		end
		if (d > 1 and h == 0) then
			return d .. L["dayShort"];
		elseif (d > 1) then
			return d .. L["dayShort"] .. space .. h .. L["hourShort"];
		end
		if (h == 1 and m == 0) then
			return h .. L["hourShort"];
		elseif (h == 1) then
			return h .. L["hourShort"] .. space .. m .. L["minuteShort"];
		end
		if (h > 1 and m == 0) then
			return h .. L["hourShort"];
		elseif (h > 1) then
			return h .. L["hourShort"] .. space .. m .. L["minuteShort"];
		end
		if (m == 1 and s == 0) then
			return m .. L["minuteShort"];
		elseif (m == 1) then
			return m .. L["minuteShort"] .. space .. s .. L["secondShort"];
		end
		if (m > 1 and s == 0) then
			return m .. L["minuteShort"];
		elseif (m > 1) then
			return m .. L["minuteShort"] .. space .. s .. L["secondShort"];
		end
		--If no matches it must be seconds only.
		return s .. L["secondShort"];
	elseif (type == "medium") then
		if (d == 1 and h == 0) then
			return d .. " " .. L["dayMedium"];
		elseif (d == 1) then
			return d .. " " .. L["dayMedium"] .. " " .. h .. " " .. L["hoursMedium"];
		end
		if (d > 1 and h == 0) then
			return d .. " " .. L["daysMedium"];
		elseif (d > 1) then
			return d .. " " .. L["daysMedium"] .. " " .. h .. " " .. L["hoursMedium"];
		end
		if (h == 1 and m == 0) then
			return h .. " " .. L["hourMedium"];
		elseif (h == 1) then
			return h .. " " .. L["hourMedium"] .. " " .. m .. " " .. L["minutesMedium"];
		end
		if (h > 1 and m == 0) then
			return h .. " " .. L["hoursMedium"];
		elseif (h > 1) then
			return h .. " " .. L["hoursMedium"] .. " " .. m .. " " .. L["minutesMedium"];
		end
		if (m == 1 and s == 0) then
			return m .. " " .. L["minuteMedium"];
		elseif (m == 1) then
			return m .. " " .. L["minuteMedium"] .. " " .. s .. " " .. L["secondsMedium"];
		end
		if (m > 1 and s == 0) then
			return m .. " " .. L["minutesMedium"];
		elseif (m > 1) then
			return m .. " " .. L["minutesMedium"] .. " " .. s .. " " .. L["secondsMedium"];
		end
		--If no matches it must be seconds only.
		return s .. " " .. L["secondsMedium"];
	else
		if (d == 1 and h == 0) then
			return d .. " " .. L["day"];
		elseif (d == 1) then
			return d .. " " .. L["day"] .. " " .. h .. " " .. L["hours"];
		end
		if (d > 1 and h == 0) then
			return d .. " " .. L["days"];
		elseif (d > 1) then
			return d .. " " .. L["days"] .. " " .. h .. " " .. L["hours"];
		end
		if (h == 1 and m == 0) then
			return h .. " " .. L["hour"];
		elseif (h == 1) then
			return h .. " " .. L["hour"] .. " " .. m .. " " .. L["minutes"];
		end
		if (h > 1 and m == 0) then
			return h .. " " .. L["hours"];
		elseif (h > 1) then
			return h .. " " .. L["hours"] .. " " .. m .. " " .. L["minutes"];
		end
		if (m == 1 and s == 0) then
			return m .. " " .. L["minute"];
		elseif (m == 1) then
			return m .. " " .. L["minute"] .. " " .. s .. " " .. L["seconds"];
		end
		if (m > 1 and s == 0) then
			return m .. " " .. L["minutes"];
		elseif (m > 1) then
			return m .. " " .. L["minutes"] .. " " .. s .. " " .. L["seconds"];
		end
		--If no matches it must be seconds only.
		return s .. " " .. L["seconds"];
	end
end

--Returns am/pm and lt/st format.
--[[function NWB:getTimeFormat(timeStamp, fullDate)
	if (NWB.db.global.timeStampZone == "server") then
		--This is ugly and shouldn't work, and probably doesn't work on some time difference.
		--Need a better solution but all I can get from the wow client in server time is hour:mins, not date or full timestamp.
		local data = date("*t", GetServerTime());
		local localHour, localMin = data.hour, data.min;
		local serverHour, serverMin = GetGameTime();
		local localSecs = (localMin*60) + ((localHour*60)*60);
		local serverSecs = (serverMin*60) + ((serverHour*60)*60);
		local diff = localSecs - serverSecs;
		--local diff = difftime(localSecs - serverSecs);
		local serverTime = 0;
		--if (localHour < serverHour) then
		--	timeStamp = timeStamp - (diff + 86400);
		--else
			timeStamp = timeStamp - diff;
		--end
	end
	if (NWB.db.global.timeStampFormat == 12) then
		--Strip leading zero and convert to lowercase am/pm.
		if (fullDate) then
			return date("%a %b %d", timeStamp) .. " " .. gsub(string.lower(date("%I:%M%p", timeStamp)), "^0", "");
		else
			return gsub(string.lower(date("%I:%M%p", timeStamp)), "^0", "");
		end
	else
		if (fullDate) then
			local dateFormat = NWB:getRegionTimeFormat();
			return date(dateFormat .. " %H:%M:%S", timeStamp);
		else
		 return date("%H:%M:%S", timeStamp);
		end
	end
end]]

--Returns am/pm and lt/st format.
function NWB:getTimeFormat(timeStamp, fullDate, abbreviate)
	if (NWB.db.global.timeStampZone == "server") then
		--This is ugly and shouldn't work, and probably doesn't work on some time difference.
		--Need a better solution but all I can get from the wow client in server time is hour:mins, not date or full timestamp.
		local data = date("*t", GetServerTime());
		local localHour, localMin = data.hour, data.min;
		local serverHour, serverMin = GetGameTime();
		local localSecs = (localMin*60) + ((localHour*60)*60);
		local serverSecs = (serverMin*60) + ((serverHour*60)*60);
		local diff = localSecs - serverSecs;
		--local diff = difftime(localSecs - serverSecs);
		local serverTime = 0;
		--if (localHour < serverHour) then
		--	timeStamp = timeStamp - (diff + 86400);
		--else
			timeStamp = timeStamp - diff;
		--end
	end
	if (NWB.db.global.timeStampFormat == 12) then
		--Strip leading zero and convert to lowercase am/pm.
		if (fullDate) then
			if (abbreviate) then
				local string = date("%a %b %d", timeStamp);
				--print(date("%c", timeStamp))
				--print(date("%c", GetServerTime()))
				--if (string) then
				--	return;
				--end
				if (date("%x", timeStamp) == date("%x", GetServerTime())) then
					string = "Today";
				elseif (date("%x", timeStamp) == date("%x", GetServerTime() - 86400)) then
					string = "Yesterday";
				end
				return string .. " " .. gsub(string.lower(date("%I:%M%p", timeStamp)), "^0", "");
			else
				return date("%a %b %d", timeStamp) .. " " .. gsub(string.lower(date("%I:%M%p", timeStamp)), "^0", "");
			end
		else
			return gsub(string.lower(date("%I:%M%p", timeStamp)), "^0", "");
		end
	else
		if (fullDate) then
			local dateFormat = NWB:getRegionTimeFormat();
			return date(dateFormat .. " %H:%M:%S", timeStamp);
		else
		 return date("%H:%M:%S", timeStamp);
		end
	end
end

--Date 24h string format based on region, won't be 100% accurate but better than %x returning US format for every region like it does now.
function NWB:getRegionTimeFormat()
	local dateFormat = "%x";
	local region = GetCurrentRegion();
	if (NWB.realm == "Arugal" or NWB.realm == "Felstriker" or NWB.realm == "Remulos" or NWB.realm == "Yojamba") then
		--OCE
		dateFormat = "%d/%m/%y";
	elseif (NWB.realm == "Sulthraze" or NWB.realm == "Loatheb") then
		--Brazil/Latin America.
		dateFormat = "%d/%m/%y";
	elseif (region == 1) then
		--US.
		dateFormat = "%m/%d/%y";
	elseif (region == 2 or region == 4 or region == 5) then
		--Korea, Taiwan, Chinda all same format.
		dateFormat = "%y/%m/%d";
	elseif (region == 3) then
		--EU.
		dateFormat = "%d/%m/%y";
	end
	return dateFormat;
end

--Get which layer has the shortest timer that will end first checking all buffs.
function NWB:getShortestTimerLayer(type)
	local timers = {};
	if (type == "city") then
		timers["rendTimer"] = NWB.db.global.rendRespawnTime;
		timers["onyTimer"] = NWB.db.global.onyRespawnTime;
		timers["nefTimer"] = NWB.db.global.nefRespawnTime;
	end
	local count, lowest = 0, 99999999999;
	local lowestLayerID, lowestLayerNum = 0, 0;
	for k, v in NWB:pairsByKeys(NWB.data.layers) do
		count = count + 1;
		for kk, vv in pairs(timers) do
			local timeLeft = (NWB.data.layers[k][kk] + vv) - GetServerTime();
			if (timeLeft < lowest) then
				lowest = timeLeft;
				lowestLayerID = k;
				lowestLayerNum = count;
			end
		end
	end
	return lowestLayerID, lowestLayerNum;
end

--Get which layer has the shortest timer that will end first for a specific buff type.
function NWB:getShortestTimerLayerBuff(type)
	local count, lowest = 0, 99999999999;
	local lowestLayerID, lowestLayerNum = 0, 0;
	for k, v in NWB:pairsByKeys(NWB.data.layers) do
		count = count + 1;
		if (v[type .. "Timer"]) then
			local timeLeft = (v[type .. "Timer"] + NWB.db.global[type .. "RespawnTime"]) - GetServerTime();
			if (timeLeft < lowest) then
				lowest = timeLeft;
				lowestLayerID = k;
				lowestLayerNum = count;
			end
		end
	end
	return lowestLayerID, lowestLayerNum;
end

local lastFlash = 0;
function NWB:startFlash(type)
	if (NWB.db.global[type]) then
		if (lastFlash < (GetServerTime() - 4)) then
			FlashClientIcon();
			lastFlash = GetServerTime();
		end
	end
end

function NWB:playSound(sound, type)
	if (NWB.db.global.disableAllSounds) then
		return;
	end
	if (IsInInstance() and NWB.db.global.soundsDisableInInstances) then
		return;
	end
	if (UnitInBattleground("player") and NWB.db.global.soundsDisableInBattlegrounds) then
		return;
	end
	if (NWB.db.global.soundOnlyInCity) then
		local play;
		local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
		if (zone == 1453 and NWB.faction == "Alliance" and (type == "ony" or type == "nef" or type == "timer")) then
			play = true;
		elseif (zone == 1454 and NWB.faction == "Horde" and (type == "ony" or type == "nef" or type == "rend" or type == "timer")) then
			play = true;
		elseif (zone == 1434 and type == "zan") then
			play = true;
		end
		if (not play) then
			return;
		end
	end
	if (NWB.db.global[sound] and NWB.db.global[sound] ~= "None") then
		if (sound == "soundsRendDrop" and NWB.db.global.soundsRendDrop == "NWB - Rend Voice") then
			PlaySoundFile("Interface\\AddOns\\NovaWorldBuffs\\Media\\RendDropped.ogg", "Master");
		elseif (sound == "soundsOnyDrop" and NWB.db.global.soundsOnyDrop == "NWB - Ony Voice") then
			PlaySoundFile("Interface\\AddOns\\NovaWorldBuffs\\Media\\OnyxiaDropped.ogg", "Master");
		elseif (sound == "soundsNefDrop" and NWB.db.global.soundsOnyDrop == "NWB - Nef Voice") then
			PlaySoundFile("Interface\\AddOns\\NovaWorldBuffs\\Media\\NefarianDropped.ogg", "Master");
		elseif (sound == "soundsNefDrop" and NWB.db.global.soundsNefDrop == "NWB - Ony Voice") then
			PlaySoundFile("Interface\\AddOns\\NovaWorldBuffs\\Media\\OnyxiaDropped.ogg", "Master");
		elseif (sound == "soundsZanDrop" and NWB.db.global.soundsZanDrop == "NWB - Zan Voice") then
			PlaySoundFile("Interface\\AddOns\\NovaWorldBuffs\\Media\\ZandalarDropped.ogg", "Master");
		else
			local soundFile = NWB.LSM:Fetch("sound", NWB.db.global[sound]);
			PlaySoundFile(soundFile, "Master");
		end
	end
end

--Accepts both types of RGB.
function NWB:RGBToHex(r, g, b)
	r = tonumber(r);
	g = tonumber(g);
	b = tonumber(b);
	--Check if whole numbers.
	if (r == math.floor(r) and g == math.floor(g) and b == math.floor(b)
			and (r> 1 or g > 1 or b > 1)) then
		r = r <= 255 and r >= 0 and r or 0;
		g = g <= 255 and g >= 0 and g or 0;
		b = b <= 255 and b >= 0 and b or 0;
		return string.format("%02x%02x%02x", r, g, b);
	else
		return string.format("%02x%02x%02x", r*255, g*255, b*255);
	end
end

--English buff names, we check both english and locale names for buff durations just to be sure in untested locales.
local englishBuffs = {
	[0] = "NoNe",
	[1] = "Warchief's Blessing",
	[2] = "Rallying Cry of the Dragonslayer",
	[3] = "Songflower Serenade",
	[4] = "Spirit of Zandalar"
}

--Get seconds left on a buff by name.
function NWB:getBuffDuration(buff, englishID)
	for i = 1, 32 do
		local name, _, _, _, _, expirationTime = UnitBuff("player", i);
		if ((name and name == buff) or (englishID and name == englishBuffs[englishID])) then
			return expirationTime - GetTime();
		end
	end
	return 0;
end

--Check if player is in guild, accepts full realm name and normalized.
function NWB:isPlayerInGuild(who, onlineOnly)
	if (not IsInGuild()) then
		return;
	end
	GuildRoster();
	local numTotalMembers = GetNumGuildMembers();
	local normalizedWho = string.gsub(who, " ", "");
	normalizedWho = string.gsub(normalizedWho, "'", "");
	local me = UnitName("player") .. "-" .. GetRealmName();
	local normalizedMe = UnitName("player") .. "-" .. GetNormalizedRealmName();
	if (who == me or who == normalizedMe) then
		return true;
	end
	for i = 1, numTotalMembers do
		local name, _, _, _, _, _, _, _, online, _, _, _, _, isMobile = GetGuildRosterInfo(i);
		if (onlineOnly) then
			if (name and (name == who or name == normalizedWho) and online and not isMobile) then
				return true;
			end
		else
			if (name and (name == who or name == normalizedWho)) then
				return true;
			end
		end
	end
end

--PHP explode type function.
function NWB:explode(div, str, count)
	if (div == '') then
		return false;
	end
	local pos,arr = 0,{};
	local index = 0;
	for st, sp in function() return string.find(str, div, pos, true) end do
		index = index + 1;
 		table.insert(arr, string.sub(str, pos, st-1));
		pos = sp + 1;
		if (count and index == count) then
			table.insert(arr, string.sub(str, pos));
			return arr;
		end
	end
	table.insert(arr, string.sub(str, pos));
	return arr;
end

--Iterate table keys in alphabetical order.
function NWB:pairsByKeys(t, f)
	local a = {};
	for n in pairs(t) do
		table.insert(a, n);
	end
	table.sort(a, f);
	local i = 0;
	local iter = function()
		i = i + 1;
		if (a[i] == nil) then
			return nil;
		else
			return a[i], t[a[i]];
		end
	end
	return iter;
end

--Strip escape strings from chat msgs.
function NWB:stripColors(str)
	local escapes = {
    	["|c%x%x%x%x%x%x%x%x"] = "", --Color start.
    	["|r"] = "", --Color end.
    	--["|H.-|h(.-)|h"] = "%1", --Links.
    	["|T.-|t"] = "", --Textures.
    	["{.-}"] = "", --Raid target icons.
	};
	if (str) then
    	for k, v in pairs(escapes) do
        	str = gsub(str, k, v);
    	end
    end
    return str;
end

function NWB:GetLayerCount()
	local count = 0;
	for k, v in pairs(NWB.data.layers) do
		count = count + 1;
	end
	return count;
end

function NWB:GetLayerNum(zoneID)
	local count = 0;
	local found;
	for k, v in NWB:pairsByKeys(NWB.data.layers) do
		count = count + 1;
		if (k == zoneID) then
			found = true;
			break;
		end
	end
	if (found) then
		return count;
	else
		return 0;
	end
end

function NWB:debug(...)
	if (NWB.isDebug) then
		if (type(...) == "table") then
			UIParentLoadAddOn('Blizzard_DebugTools');
			--DevTools_Dump(...);
    		DisplayTableInspectorWindow(...);
    	else
			print("NWBDebug:", ...);
		end
	end
end

SLASH_NWBCMD1, SLASH_NWBCMD2, SLASH_NWBCMD3, SLASH_NWBCMD4, SLASH_NWBCMD5, SLASH_NWBCMD6 
		= '/nwb', '/novaworldbuff', '/novaworldbuffs', '/wb', '/worldbuff', '/worldbuffs';
function SlashCmdList.NWBCMD(msg, editBox)
	local cmd, arg;
	local whisper, whisperArg = "", "";
	if (msg) then
		msg = string.lower(msg);
		cmd, arg = strsplit(" ", msg, 2);
		if (arg) then
			msg = cmd;
		end
		if (msg == "tell" or msg == "whisper" or msg == "msg") then
			local isWhisper, isWhisper2 = strsplit(" ", arg, 2);
			if (isWhisper2) then
				arg = isWhisper2;
				msg = msg .. " " .. isWhisper;
			else
				msg = msg .. " " .. arg;
				arg = nil;
			end
		end
	end
	if (msg == "resetold" or msg == "removeold") then
		NWB:removeOldLayersNoTimer();
		return;
	end
	if (msg == "reset") then
		NWB:resetTimerData();
		return;
	end
	if (msg == "layermap") then
		NWB:openLayerMapFrame();
		return;
	end
	if (msg == "version" or msg == "versions" or msg == "ver" or msg == "vers") then
		NWB:openVersionFrame();
		return;
	end
	if (msg == "show" or msg == "buff" or msg == "buffs") then
		NWB:openBuffListFrame();
		return;
	end
	if (msg == "group" or msg == "team") then
		msg = "party";
	end
	if (msg == "map") then
		WorldMapFrame:Show();
		if (NWB.faction == "Alliance") then
			WorldMapFrame:SetMapID(1453);
		else
			WorldMapFrame:SetMapID(1454);
		end
		return;
	end
	if (msg == "options" or msg == "option" or msg == "config" or msg == "menu") then
		NWB:openConfig();
	elseif (msg ~= nil and msg ~= "") then
		NWB:print(NWB:getShortBuffTimers(nil, arg), msg);
	else
		NWB:printBuffTimers();
		if (NWB.isLayered) then
			NWB:openLayerFrame();
		end
	end
end

function NWB:openConfig()
	--Opening the frame needs to be run twice to avoid a bug.
	InterfaceOptionsFrame_OpenToCategory("NovaWorldBuffs");
	--Hack to fix the issue of interface options not opening to menus below the current scroll range.
	--This addon name starts with N and will always be closer to the middle so just scroll to the middle when opening.
	local min, max = InterfaceOptionsFrameAddOnsListScrollBar:GetMinMaxValues();
	if (min < max) then
		InterfaceOptionsFrameAddOnsListScrollBar:SetValue(math.floor(max/2));
	end
	InterfaceOptionsFrame_OpenToCategory("NovaWorldBuffs");
end

function NWB:resetTimerData()
	--NWB:resetBuffData();
	for k, v in pairs(NWB.songFlowers) do
		NWB.data[k] = 0;
	end
	for k, v in pairs(NWB.tubers) do
		NWB.data[k] = 0;
	end
	for k, v in pairs(NWB.dragons) do
		NWB.data[k] = 0;
	end
	NWB.data.layers = {};
	NWB.data.rendTimer = 0;
	NWB.data.rendYell = 0;
	NWB.data.rendYell2 = 0;
	NWB.data.onyTimer = 0;
	NWB.data.onyYell = 0;
	NWB.data.onyYell2 = 0;
	NWB.data.onyNpcDied = 0;
	NWB.data.nefTimer = 0;
	NWB.data.nefYell = 0;
	NWB.data.nefYell2 = 0;
	NWB.data.nefNpcDied = 0;
	--zanTimer = 0;
	NWB.data.zanYell = 0;
	NWB.data.zanYell2 = 0;
	NWB:print("All timer data has been reset.");
end

--I do not know wtf I am doing with data broker stuff.
--I'm not using any panel and this probably looks all wrong, seems to work though.
local NWBLDB, doUpdateMinimapButton;
function NWB:createBroker()
	local data = {
		type = "launcher",
		label = "NWB",
		text = "NovaWorldBuffs",
		icon = "Interface\\Icons\\inv_misc_head_dragon_01",
		OnClick = function(self, button)
			if (button == "LeftButton" and IsShiftKeyDown()) then
				if (WorldMapFrame and WorldMapFrame:IsShown()) then
					WorldMapFrame:Hide();
				else
					WorldMapFrame:Show();
					WorldMapFrame:SetMapID(1448);
				end
			elseif (button == "LeftButton") then
				NWB:openLayerFrame();
			elseif (button == "RightButton" and IsShiftKeyDown()) then
				if (InterfaceOptionsFrame and InterfaceOptionsFrame:IsShown()) then
					InterfaceOptionsFrame:Hide();
				else
					NWB:openConfig();
				end
			elseif (button == "RightButton") then
				NWB:openBuffListFrame();
			end
		end,
		OnLeave = function(self, button)
			doUpdateMinimapButton = nil;
		end,
		OnTooltipShow = function(tooltip)
			doUpdateMinimapButton = true;
			NWB:updateMinimapButton(tooltip);
		end,
		OnEnter = function(self, button)
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
			doUpdateMinimapButton = true;
			NWB:updateMinimapButton(GameTooltip, true);
			GameTooltip:Show()
		end,
	};
	NWBLDB = LDB:NewDataObject("NWB", data);
	NWB.LDBIcon:Register("NovaWorldBuffs", NWBLDB, NWB.db.global.minimapIcon);
end

function NWB:updateMinimapButton(tooltip, usingPanel)
	local _, relativeTo = tooltip:GetPoint();
	if (doUpdateMinimapButton and (usingPanel or relativeTo and relativeTo:GetName() == "LibDBIcon10_NovaWorldBuffs")) then
		tooltip:ClearLines()
		tooltip:AddLine("NovaWorldBuffs");
		if (not NWB.isLayered) then
			local msg = "";
			if (NWB.faction == "Horde" or NWB.db.global.allianceEnableRend) then
				if (NWB.data.rendTimer > (GetServerTime() - NWB.db.global.rendRespawnTime)) then
					msg = L["rend"] .. ": " .. NWB:getTimeString(NWB.db.global.rendRespawnTime - (GetServerTime() - NWB.data.rendTimer), true) .. ".";
					if (NWB.db.global.showTimeStamp) then
						local timeStamp = NWB:getTimeFormat(NWB.data.rendTimer + NWB.db.global.rendRespawnTime);
						msg = msg .. " (" .. timeStamp .. ")";
					end
				else
					msg = L["rend"] .. ": " .. L["noCurrentTimer"] .. ".";
				end
				if ((not isLogon or NWB.db.global.logonRend) and not NWB.isLayered) then
					tooltip:AddLine(NWB.chatColor .. msg);
				end
			end
			if ((NWB.data.onyNpcDied > NWB.data.onyTimer) and
					(NWB.data.onyNpcDied > (GetServerTime() - NWB.db.global.onyRespawnTime))) then
				if (NWB.faction == "Horde") then
					msg = string.format(L["onyxiaNpcKilledHordeWithTimer"], NWB:getTimeString(GetServerTime() - NWB.data.onyNpcDied, true));
				else
					msg = string.format(L["onyxiaNpcKilledAllianceWithTimer"], NWB:getTimeString(GetServerTime() - NWB.data.onyNpcDied, true));
				end
			elseif (NWB.data.onyTimer > (GetServerTime() - NWB.db.global.onyRespawnTime)) then
				msg = L["onyxia"] .. ": " .. NWB:getTimeString(NWB.db.global.onyRespawnTime - (GetServerTime() - NWB.data.onyTimer), true) .. ".";
				if (NWB.db.global.showTimeStamp) then
					local timeStamp = NWB:getTimeFormat(NWB.data.onyTimer + NWB.db.global.onyRespawnTime);
					msg = msg .. " (" .. timeStamp .. ")";
				end
			else
				msg = L["onyxia"] .. ": " .. L["noCurrentTimer"] .. ".";
			end
			if ((not isLogon or NWB.db.global.logonOny) and not NWB.isLayered) then
				tooltip:AddLine(NWB.chatColor .. msg);
			end
			if ((NWB.data.nefNpcDied > NWB.data.nefTimer) and
					(NWB.data.nefNpcDied > (GetServerTime() - NWB.db.global.nefRespawnTime))) then
				if (NWB.faction == "Horde") then
					msg = string.format(L["nefarianNpcKilledHordeWithTimer"], NWB:getTimeString(GetServerTime() - NWB.data.nefNpcDied, true));
				else
					msg = string.format(L["nefarianNpcKilledAllianceWithTimer"], NWB:getTimeString(GetServerTime() - NWB.data.nefNpcDied, true));
				end
			elseif (NWB.data.nefTimer > (GetServerTime() - NWB.db.global.nefRespawnTime)) then
				msg = L["nefarian"] .. ": " .. NWB:getTimeString(NWB.db.global.nefRespawnTime - (GetServerTime() - NWB.data.nefTimer), true) .. ".";
				if (NWB.db.global.showTimeStamp) then
					local timeStamp = NWB:getTimeFormat(NWB.data.nefTimer + NWB.db.global.nefRespawnTime);
					msg = msg .. " (" .. timeStamp .. ")";
				end
			else
				msg = L["nefarian"] .. ": " .. L["noCurrentTimer"] .. ".";
			end
			if ((not isLogon or NWB.db.global.logonNef) and not NWB.isLayered) then
				tooltip:AddLine(NWB.chatColor .. msg);
			end
		end
		tooltip:AddLine("|cFF9CD6DELeft-Click|r Timers");
		tooltip:AddLine("|cFF9CD6DERight-Click|r Buffs");
		tooltip:AddLine("|cFF9CD6DEShift Left-Click|r Felwood Map");
		tooltip:AddLine("|cFF9CD6DEShift Right-Click|r Config");
		C_Timer.After(0.1, function()
			NWB:updateMinimapButton(tooltip, usingPanel);
		end)
	end
end

---===== Most of these are now disabled, only DBM is left =====---
---Parse other world buff addons for increased accuracy and to spread more data around.
---Thanks to all authors for their work.
---If any of these authors ask me to stop parsing their comms I'll remove it.
function NWB:registerOtherAddons()
	--Register with AceComm.
	self:RegisterComm("D4C");
	--Register without AceComm so it doesn't come through our lib funcs.
	C_ChatInfo.RegisterAddonMessagePrefix("NIT");
end

--For NovaInstanceTracker, this is shared compatability with my anoher of my addons.
--Basically this just tells the instance tracker if an instance is reset to increase accuracy across groups.
local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_SYSTEM")
f:SetScript('OnEvent', function(self, event, msg)
	if (IsAddOnLoaded("NovaInstanceTracker")) then
		return;
	end
	local instance;
	if (string.match(msg, string.gsub(INSTANCE_RESET_SUCCESS, "%%s", ".+"))) then
		instance = string.match(msg, string.gsub(INSTANCE_RESET_FAILED, "%%s", "(.+)"));
	elseif (string.match(msg, string.gsub(INSTANCE_RESET_FAILED, "%%s", ".+"))) then
		instance = string.match(msg, string.gsub(INSTANCE_RESET_FAILED, "%%s", "(.+)"));
	end
	if (instance) then
		local string = "instanceResetOther 0 " .. instance;
		--Even though it's a small string run it through the same compression so it matches the rest of the data comms in both addons.
		local serialized = NWB.serializer:Serialize(string);
		local compressed = NWB.libDeflate:CompressDeflate(serialized, {level = 9});
		local data = NWB.libDeflate:EncodeForWoWAddonChannel(compressed);
		if (UnitIsGroupLeader("player")) then
			if (IsInRaid()) then
	  			C_ChatInfo.SendAddonMessage("NIT", data, "RAID");
	  		elseif (IsInGroup()) then
	  			C_ChatInfo.SendAddonMessage("NIT", data, "PARTY");
	  		end
	  	end
	end
end)

--DBM.
local dbmLastRend, dbmLastOny, dbmLastNef, dbmLastZan = 0, 0, 0, 0;
function NWB:parseDBM(prefix, msg, channel, sender)
	if (NWB.isLayered) then
		--We need the NPC GUIDs for buff setting on layered realms so exclude DBM from those realms.
		return;
	end
	--Strings.
	--D4C WBA	rendBlackhand	Horde	Warchief's Blessing	59 GUILD
	--D4C WBA	Onyxia	Horde	Rallying Cry of the Dragonslayer	15 GUILD
	--D4C WBA	Nefarian	Horde	Rallying Cry of the Dragonslayer	17 GUILD
	--Same exact string comes from DBM for both yell msgs so disabled timer delay for now. SendWorldSync(self, "WBA", "Zandalar\tBoth\t"..spellName.."\t12")
	if (string.match(msg, "rendBlackhand") 
			and (string.match(msg, "Warchief's Blessing") or string.match(msg, L["Warchief's Blessing"]))) then
		NWB:doFirstYell("rend");
		--6 seconds between DBM comm (first npc yell) and rend buff drop.
		if (GetServerTime() - dbmLastRend > 30) then
			C_Timer.After(7, function()
				NWB:setRendBuff("dbm", sender);
			end)
			dbmLastRend = GetServerTime();
		end
	end
	--I think maybe DBM is sending ony buff msg sometimes for nef, needs more testing.
	if (string.match(msg, "Onyxia") 
			and (string.match(msg, "Rallying Cry of the Dragonslayer") or string.match(msg, L["Rallying Cry of the Dragonslayer"]))) then
		NWB:doFirstYell("ony");
		--14 seconds between DBM comm (first npc yell) and buff drop.
		if (GetServerTime() - dbmLastOny > 30) then
			C_Timer.After(15, function()
				NWB:setOnyBuff("dbm", sender);
			end)
			dbmLastOny = GetServerTime();
		end
	end
	if (string.match(msg, "Nefarian") 
			and (string.match(msg, "Rallying Cry of the Dragonslayer") or string.match(msg, L["Rallying Cry of the Dragonslayer"]))) then
		NWB:doFirstYell("nef");
		--15 seconds between DBM comm (first npc yell) and buff drop.
		if (GetServerTime() - dbmLastNef > 30) then
			C_Timer.After(16, function()
				NWB:setNefBuff("dbm", sender);
			end)
			dbmLastNef = GetServerTime();
		end
	end
	if (string.match(msg, "Zandalar") 
			and (string.match(msg, "Spirit of Zandalar") or string.match(msg, L["Spirit of Zandalar"]))) then
		NWB:doFirstYell("zan");
		NWB:debug("dbm doing zand");
		--27ish seconds between first zan yell and buff applied if on island.
		--45ish seconds between first zan yell and buff applied if in booty bay.
		--Call it 30.
		if (GetServerTime() - dbmLastRend > 50) then
			C_Timer.After(30, function()
				NWB:setZanBuff("dbm", sender);
			end)
			dbmLastZan = GetServerTime();
		end
	end
end

---=======---
---Felwood---
---=======---

function NWB:setSongFlowers()
	NWB.songFlowers = {
		--Songflowers in order from north to south.						--Coords taken from NWB.dragonLib:GetPlayerZonePosition().
		["flower1"] = {x = 63.9, y = 6.1, subZone = L["North Felpaw Village"]}, --x 63.907248382611, y 6.0921582958694
		["flower2"] = {x = 55.8, y = 10.4, subZone = L["West Felpaw Village"]}, --x 55.80811845313, y 10.438248169009
		["flower3"] = {x = 50.6, y = 13.9, subZone = L["North of Irontree Woods"]}, --x 50.575074328086, y 13.918245916971
		["flower4"] = {x = 63.3, y = 22.6, subZone = L["Talonbranch Glade"]}, -- x 63.336814849559, y 22.610425663249
		["flower5"] = {x = 40.1, y = 44.4, subZone = L["Shatter Scar Vale"]}, --x 40.142029982253, y 44.353905770542
		["flower6"] = {x = 34.3, y = 52.2, subZone = L["Bloodvenom Post"]}, --x 34.345508209303, y 52.179993391643
		["flower7"] = {x = 40.1, y = 56.5, subZone = L["East of Jaedenar"]}, --x 40.142029982253, y 56.523472021355
		["flower8"] = {x = 48.3, y = 75.7, subZone = L["North of Emerald Sanctuary"]}, -- x 48.260292045699, y 75.650435262435
		["flower9"] = {x = 45.9, y = 85.2, subZone = L["West of Emerald Sanctuary"]}, --x 45.942030228517, y 85.219126632059
		["flower10"] = {x = 52.9, y = 87.8, subZone = L["South of Emerald Sanctuary"]}, --x 52.893336145267, y 87.825217631218
	}
	if (NWB.faction == "Horde") then
		NWB.songFlowers.flower6.subZone = L["Bloodvenom Post"] .. " FP";
	end
end

NWB.tubers = {
	--Whipper root in order from north to south.
	--Taken from wowhead, could be some missing.
	["tuber1"] = {x = 49.5, y = 12.2, subZone = L["North of Irontree Woods"]},
	["tuber2"] = {x = 50.6, y = 18.2, subZone = L["Irontree Woods"]},
	["tuber3"] = {x = 40.7, y = 19.2, subZone = L["West of Irontree Woods"]},
	["tuber4"] = {x = 43.0, y = 46.9, subZone = L["Bloodvenom Falls"]},
	["tuber5"] = {x = 34.1, y = 60.3, subZone = L["Jaedenar"]},
	["tuber6"] = {x = 40.2, y = 85.2, subZone = L["West of Emerald Sanctuary"]},
};

NWB.dragons = {
	--Night dragon in order from north to south.
	--Taken from wowhead, could be some missing.
	["dragon1"] = {x = 42.5, y = 13.9, subZone = L["North-West of Irontree Woods"]},
	["dragon2"] = {x = 50.6, y = 30.5, subZone = L["South of Irontree Woods"]},
	["dragon3"] = {x = 35.1, y = 59.0, subZone = L["Jaedenar"]},
	["dragon4"] = {x = 40.7, y = 78.3, subZone = L["West of Emerald Sanctuary"]},
};

--Debug.
function NWB:resetSongFlowers()
	if (NWB.db.global.resetSongflowers) then
		for k, v in pairs(NWB.songFlowers) do
			NWB.data[k] = 0;
		end
		NWB.db.global.resetSongflowers = false;
	end
end

SLASH_NWBSFCMD1, SLASH_NWBSFCMD2, SLASH_NWBSFCMD3, SLASH_NWBSFCMD4 = '/sf', '/sfs', '/songflower', '/songflowers';
function SlashCmdList.NWBSFCMD(msg, editBox)
	if (msg) then
		msg = string.lower(msg);
	end
	if (msg == "map") then
		WorldMapFrame:Show();
		WorldMapFrame:SetMapID(1448);
		return;
	end
	if (msg == "options" or msg == "option" or msg == "config" or msg == "menu") then
		NWB:openConfig();
		return;
	end
	local dataPrefix, layer, layerNum;
	local layerMsg = "";
	--Show timers for our current layer.
	if (NWB.isLayered and NWB.layeredSongflowers and NWB:GetLayerCount() == 2 and NWB.lastKnownLayerMapID and NWB.lastKnownLayerMapID > 0
			and NWB.lastKnownLayer and NWB.lastKnownLayer > 0) then
		layerNum = NWB.lastKnownLayer;
		layer = NWB.lastKnownLayerID;
		dataPrefix = NWB.data.layers[layer];
		layerMsg = L[" (Layer "] .. layerNum .. ")";
	else
		dataPrefix = NWB.data;
	end
	local string = L["Songflower"] .. ":";
	local found;
	for k, v in pairs(NWB.songFlowers) do
		local time = (dataPrefix[k] + 1500) - GetServerTime();
		if (time > 0) then
			local minutes = string.format("%02.f", math.floor(time / 60));
    		local seconds = string.format("%02.f", math.floor(time - minutes * 60));
			string = string .. " (" .. v.subZone .. " " .. minutes .. "m" .. seconds .. "s)";
			found = true;
  		end
	end
	if (not found) then
		string = string .. " " .. L["noActiveTimers"] .. ".";
	end
	if (msg ~= nil and msg ~= "") then
		NWB:print(string .. layerMsg, msg);
	else
		NWB:print(string .. layerMsg);
	end
end

NWB.detectedPlayers = {};
local f = CreateFrame("Frame");
f:RegisterEvent("PLAYER_TARGET_CHANGED");
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
f:RegisterEvent("PLAYER_ENTERING_WORLD");
f:RegisterEvent("CHAT_MSG_LOOT");
f:SetScript('OnEvent', function(self, event, ...)
	if (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
		local timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, 
				destName, destFlags, destRaidFlags, _, spellName = CombatLogGetCurrentEventInfo();
		if ((subEvent == "SPELL_AURA_APPLIED" or subEvent == "SPELL_AURA_REFRESH")) then
			--Can't check for buffs here because often songflower won't be the first buff in combat log when someone logs in.
			--Then the player could be NWB.detectedPlayers right before their logon songflower buff is seen, triggering a false timer.
			--Other combat events we can use to check for players around us.
			--if (zone == 1448 and subEvent ~= "SPELL_AURA_APPLIED" and subEvent ~= "SPELL_AURA_REFRESH") then
			if (zone == 1448) then
				if (sourceName) then
					NWB:addDetectedPlayer(sourceName, true);
				elseif (destName) then
					NWB:addDetectedPlayer(destName, true);
				end
			end
			if (spellName == L["Songflower Serenade"]) then
				if (destName == UnitName("player")) then
					--If buff is ours we'll validate it's a new buff incase we logon beside a songflower with the buff.
					local expirationTime = NWB:getBuffDuration(L["Songflower Serenade"], 3)
					if (expirationTime >= 3599) then
						local closestFlower = NWB:getClosestSongflower();
						if (NWB.data[closestFlower]) then
							NWB:songflowerPicked(closestFlower);
						end
					end
				elseif (not NWB.db.global.mySongflowerOnly) then
					local pvpType = GetZonePVPInfo();
					if (bit.band(destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE
							and pvpType == "contested") then
						return;
					end
					local closestFlower = NWB:getClosestSongflower();
					if (NWB.data[closestFlower]) then
						NWB:songflowerPicked(closestFlower, destName);
					end
				end
			end
		else
			if (zone == 1448) then
				if (sourceName) then
					NWB:addDetectedPlayer(sourceName);
				elseif (destName) then
					NWB:addDetectedPlayer(destName);
				end
			end
		end
	elseif (event == "PLAYER_TARGET_CHANGED") then
		local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
		if (zone == 1448) then
			local name = UnitName("target");
			if (name) then
				NWB:addDetectedPlayer(UnitName("target"));
			end
		end
	elseif (event == "PLAYER_ENTERING_WORLD") then
		--Wipe felwood songflower detected players when leaving, it costs very little to just wipe this on every zone.
		NWB.detectedPlayers = {};
	elseif (event == "CHAT_MSG_LOOT") then
		local msg = ...;
		local name, otherPlayer;
		--Self receive multiple loot "You receive loot: [Item]x2"
		local itemLink, amount = string.match(msg, string.gsub(string.gsub(LOOT_ITEM_SELF_MULTIPLE, "%%s", "(.+)"), "%%d", "(%%d+)"));
    	if (not itemLink) then
    		--Self receive single loot "You receive loot: [Item]"
    		itemLink = msg:match(LOOT_ITEM_SELF:gsub("%%s", "(.+)"));
    		if (not itemLink) then
    			--Self receive multiple item "You receive item: [Item]x2"
    			itemLink, amount = string.match(msg, string.gsub(string.gsub(LOOT_ITEM_PUSHED_SELF_MULTIPLE, "%%s", "(.+)"), "%%d", "(%%d+)"));
    			--itemLink = msg:match(LOOT_ITEM_SELF:gsub("%%s", "(.+)"));
    			if (not itemLink) then
    	 			--Self receive single item "You receive item: [Item]"
    				itemLink = msg:match(LOOT_ITEM_PUSHED_SELF:gsub("%%s", "(.+)"));
    			end
    		end
    	end
		--If no matches for self loot then check other player loot msgs.
		if (not itemLink) then
    		--Other player receive multiple loot "Otherplayer receives loot: [Item]x2"
    		otherPlayer, itemLink, amount = string.match(msg, string.gsub(string.gsub(LOOT_ITEM_MULTIPLE, "%%s", "(.+)"), "%%d", "(%%d+)"));
    		if (not itemLink) then
    			--Other player receive single loot "Otherplayer receives loot: [Item]"
    			otherPlayer, itemLink = msg:match("^" .. LOOT_ITEM:gsub("%%s", "(.+)"));
    			if (not itemLink) then
    				--Other player loot multiple item "Otherplayer receives item: [Item]x2"
    				otherPlayer, itemLink, amount = string.match(msg, string.gsub(string.gsub(LOOT_ITEM_PUSHED_MULTIPLE, "%%s", "(.+)"), "%%d", "(%%d+)"));
    				if (not itemLink) then
    	 				--Other player receive single item "Otherplayer receives item: [Item]"
    					otherPlayer, itemLink = msg:match("^" .. LOOT_ITEM_PUSHED:gsub("%%s", "(.+)"));
    				end
    			end
    		end
    	end
    	--otherPlayer is basically a waste of time here, since it's a pushed item not a looted item the team doesn't see it be looted.
    	--But I'll keep my looted item function in tact anyway, maybe I'll track some other item here in the future.
    	local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
    	--Some uers seem to have an addon that repaces the Item global so we have to check for Item.CreateFromItemLink.
		if (zone == 1448 and itemLink and Item.CreateFromItemLink) then
			local item = Item:CreateFromItemLink(itemLink);
			if (item) then
				local itemID = item:GetItemID();
				if (itemID and itemID == 11951) then
					local closestTuber = NWB:getClosestTuber();
					if (NWB.data[closestTuber]) then
						NWB:tuberPicked(closestTuber, otherPlayer);
					end
				elseif (itemID and itemID == 11952) then
					local closestDragon = NWB:getClosestDragon();
					if (NWB.data[closestDragon]) then
						NWB:dragonPicked(closestDragon, otherPlayer);
					end
				end
			end
    	end
	end
end)

--Check tooltips for players while waiting at the songflower, doesn't really matter if it adds non-player stuff, it gets wiped when leaving.
--This shouldn't be done OnUpdate but it will do for now and only happens in felwood.
--Not sure how to detect tooltip changed, OnShow doesn't work when tooltip changes before fading out.
--This whole thing is pretty ugly right now.
GameTooltip:HookScript("OnUpdate", function()
	--This may need some more work to handle custom tooltip addons like elvui etc.
	local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
	if (zone == 1448) then
		for i = 1, GameTooltip:NumLines() do
			local line =_G["GameTooltipTextLeft"..i];
			local text = line:GetText();
			if (text and text ~= nil and text ~= "") then
				local name;
				if (string.match(text, " ")) then
					name = NWB:stripColors(string.match(text, "%s(%S+)$"));
				else
					name = NWB:stripColors(text);
				end
				if (name) then
					NWB:addDetectedPlayer(name);
				end
			end
			--Iterate first line only.
			return;
		end
	end
end)

function NWB:addDetectedPlayer(name, skipTimeCheck)
	--Skip time check if it's a SPELL_AURA_APPLIED so we always update timestamp for people logging in with buffs beside us.
	--We check in NWB:setLayeredSongflowers() so we don't set a timer if it was a buff and player was seen less than 1 second ago (login).
	if (NWB.detectedPlayers[name] and (GetServerTime() - NWB.detectedPlayers[name]) < 180) then
		return;
	end
	NWB.detectedPlayers[name] = GetServerTime();
end

function NWB:setLayeredSongflowers()
	--No layered songflowers on the regions with 4+ layers, it's too much data to sync.
	--if (NWB.isLayered and not NWB.cnRealms[NWB.realm] and not NWB.twRealms[NWB.realm]
	--		and not NWB.krRealms[NWB.realm]) then
	--Enabled songflowers in all regions now, using better data compression.
	if (NWB.isLayered) then
		NWB.layeredSongflowers = true;
	end
end

--I record some data to try and make sure if another player picked flower infront of us it's valid and not an old buff.
--Check if player has been seen before (avoid logon buff aura gained events).
--Check if there is already a valid timer for the songflower (they should never be reset except server restart?)
local pickedTime = 0;
function NWB:songflowerPicked(type, otherPlayer)
	local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
	if (zone ~= 1448) then
		--We're not in felwood.
		return;
	end
	if (IsShiftKeyDown()) then
		print("|cFFFFFF00Shift key held down, songflower not being recorded.");
		return;
	end
	--If other player has not been seen before it may be someone logging in with the buff.
	if (otherPlayer and not NWB.detectedPlayers[otherPlayer]) then
		NWB:debug("Previously unseen player with buff:", otherPlayer);
		return;
	end
	if (otherPlayer and (GetServerTime() - NWB.detectedPlayers[otherPlayer] > 1500)) then
		NWB:debug("Player seen too long ago:", otherPlayer);
		return;
	end
	if (otherPlayer and (GetServerTime() - NWB.detectedPlayers[otherPlayer] < 1)) then
		--We're using auras to detect players, this will make sure logging in with a SF buff won't trigger a timer.
		--It will cycle all their buffs in combat log in he first second, after that we consider them valid to pick.
		NWB:debug("Player got SF buff too soon after seen:", otherPlayer);
		return;
	end
	if ((GetServerTime() - pickedTime) > 5) then
		--SetCVar("nameplateShowFriends", 1);
		--NWB:setCurrentLayerText("nameplate1");
		--SetCVar("nameplateShowFriends", 0)
		local layer, layerNum;
		if (NWB.isLayered and NWB:GetLayerCount() >= 2 and NWB.lastKnownLayerMapID and NWB.lastKnownLayerMapID > 0
				and NWB.lastKnownLayer and NWB.lastKnownLayer > 0) then
		--if (NWB.isLayered and NWB:GetLayerCount() >= 2 and NWB.lastKnownLayerMapID and NWB.lastKnownLayerMapID > 0) then
			layer = NWB.lastKnownLayerMapID;
			layerNum = NWB.lastKnownLayer;
		end
		NWB:debug(NWB.lastKnownLayerMapID, NWB.lastKnownLayer);
		if (not layer or layer == 0) then
			layer = NWB.lastKnownLayerMapIDBackup;
		end
		NWB:debug(NWB.isLayered, NWB.layeredSongflowers, layer, layerNum, NWB:GetLayerCount(), NWB.lastKnownLayerMapID, NWB.lastKnownLayer);
		if (NWB.isLayered and NWB.layeredSongflowers and layer and layer > 0) then
			if (not layer or layer < 1) then
				NWB:debug("no known felwood layer");
				return;
			end
			if (not NWB.data.layers[layer]) then
				NWB:debug("felwood layer table is missing");
				return;
			end
			if (not NWB.data.layers[layer][type]) then
				NWB.data.layers[layer][type] = 0;
			end
			--Validate only if another player, we already check ours is valid by duration check.
			local timestamp = GetServerTime();
			if (otherPlayer and NWB.data.layers[layer][type] > (timestamp - 1440)) then
				NWB:debug("Trying to overwrite a layered valid songflower timer.", otherPlayer);
			else
				if (NWB:validateTimestamp(timestamp)) then
					NWB:debug("layered songflower picked2", otherPlayer);
					NWB.data.layers[layer][type] = timestamp;
					if (NWB.db.global.guildSongflower == true or NWB.db.global.guildSongflower == 1) then
						NWB:doFlowerMsg(type, layerNum);
						NWB:sendFlower("GUILD", type, nil, layerNum);
					end
					NWB:sendData("GUILD");
					NWB:sendData("YELL");
				end
			end
			--Set the non-layered timer also, we may use this later and it's not included in syncing data with others anyway.
			if (otherPlayer and NWB.data[type] > (timestamp - 1440)) then
				NWB:debug("Trying to overwrite a valid songflower timer.", otherPlayer);
				return;
			end
			if (NWB:validateTimestamp(timestamp)) then
				NWB.data[type] = timestamp;
				NWB:doFlowerMsg(type, layerNum);
			end
			pickedTime = timestamp;
		else
			local timestamp = GetServerTime();
			--Validate only if another player, we already check ours is valid by duration check.
			if (otherPlayer and NWB.data[type] > (timestamp - 1440)) then
				NWB:debug("Trying to overwrite a valid songflower timer.", otherPlayer);
				return;
			end
			if (NWB:validateTimestamp(timestamp)) then
				NWB:debug("songflower picked2", otherPlayer);
				NWB.data[type] = timestamp;
				if (NWB.db.global.guildSongflower == true or NWB.db.global.guildSongflower == 1) then
					NWB:doFlowerMsg(type, layerNum);
				NWB:sendFlower("GUILD", type);
			end
			NWB:sendData("GUILD");
				NWB:sendData("YELL");
				if (NWB.isLayered and NWB:GetLayerCount() >= 2 and NWB.layeredSongflowers
						and (GetServerTime() - NWB.lastJoinedGroup) > NWB.lastJoinedGroupCooldown) then
					NWB:print(L["flowerWarning"]);
				end
			end
			pickedTime = timestamp;
		end
	end
end

local flowerMsg = 0;
function NWB:doFlowerMsg(type, layer)
	local layerMsg = "";
	if (NWB.isLayered and tonumber(layer) and NWB.doLayerMsg) then
		layerMsg = L[" (Layer "] .. layer .. ")";
	end
	if (type and (GetServerTime() - flowerMsg) > 10) then
		if (NWB.db.global.guildSongflower == true or NWB.db.global.guildSongflower == 1) then
			NWB:sendGuildMsg(string.format(L["songflowerPicked"], NWB.songFlowers[type].subZone) .. layerMsg, "guildSongflower");
		end
		flowerMsg = GetServerTime();
	end
end

local tuberPickedTime = 0;
function NWB:tuberPicked(type, otherPlayer)
	local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
	if (zone ~= 1448) then
		--We're not in felwood.
		return;
	end
	if ((GetServerTime() - tuberPickedTime) > 5) then
		if (NWB.data[type] > (GetServerTime() - 1500)) then
			NWB:debug("Trying to overwrite a valid tuber timer.");
			return;
		end
		local timestamp = GetServerTime();
		if (NWB:validateTimestamp(timestamp)) then
			NWB.data[type] = timestamp;
			NWB:sendData("GUILD");
			NWB:sendData("YELL");
		end
		tuberPickedTime = timestamp;
	end
end

local dragonPickedTime = 0;
function NWB:dragonPicked(type, otherPlayer)
	local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
	if (zone ~= 1448) then
		--We're not in felwood.
		return;
	end
	if ((GetServerTime() - dragonPickedTime) > 5) then
		if (NWB.data[type] > (GetServerTime() - 1500)) then
			NWB:debug("Trying to overwrite a valid dragon timer.");
			return;
		end
		local timestamp = GetServerTime();
		if (NWB:validateTimestamp(timestamp)) then
			NWB.data[type] = timestamp;
			NWB:sendData("GUILD");
			NWB:sendData("YELL");
		end
		dragonPickedTime = timestamp;
	end
end

--Gets which songflower we are closest to, if we are actually beside one.
function NWB:getClosestSongflower()
	local x, y, zone = NWB.dragonLib:GetPlayerZonePosition();
	if (zone ~= 1448) then
		--We're not in felwood.
		return;
	end
	for k, v in pairs(NWB.songFlowers) do
		--The distance returned by this is actually much further than yards like is specifed on the addon page.
		--It returns 2 yards when I'm more like 50 yards away, it's good enough for this check anyway, songflowers aren't close together.
		--Seems it returns the distance in coords you are away not the distance in yards? 1 yard is smaller than x = 1.0 coord?
		local distance = NWB.dragonLib:GetWorldDistance(zone, x*100, y*100, v.x, v.y);
		if (distance <= 2) then
			return k;
		end
	end
end

function NWB:getClosestTuber()
	local x, y, zone = NWB.dragonLib:GetPlayerZonePosition();
	if (zone ~= 1448) then
		return;
	end
	for k, v in pairs(NWB.tubers) do
		local distance = NWB.dragonLib:GetWorldDistance(zone, x*100, y*100, v.x, v.y);
		if (distance <= 2) then
			return k;
		end
	end
end

function NWB:getClosestDragon()
	local x, y, zone = NWB.dragonLib:GetPlayerZonePosition();
	if (zone ~= 1448) then
		return;
	end
	for k, v in pairs(NWB.dragons) do
		local distance = NWB.dragonLib:GetWorldDistance(zone, x*100, y*100, v.x, v.y);
		if (distance <= 2) then
			return k;
		end
	end
end

--Update timers for Felwood worldmap when the map is open.
local mapSFFrames = {};
function NWB:updateFelwoodWorldmapMarker(type)
	if (NWB.isLayered and NWB.layeredSongflowers and string.match(type, "flower")) then
		--Flowers are only updated once per second not every frame, and only when an icon is visible.
		local count = 0;
		local tooltipText = "";
		local hasTimer;
		for k, v in pairs(mapSFFrames) do
			--Remove any frames for any layer has been removed from db.
			--Note that layer1 frame is never added to the mapSFFrames table, only extra layer frames are.
			--Layer 1 frame is the same frame non-layered realms use and will always be shown if any layer has a timer.
			for kk, vv in pairs(v) do
				if (not NWB.data.layers[tonumber(kk)]) then
					_G[k .. "NWB"]["timerFrame" .. vv]:Hide();
					_G[k .. "NWB"]["timerFrame" .. vv] = nil;
					mapSFFrames[k][kk] = nil;
				end
			end
		end
		for k, v in NWB:pairsByKeys(NWB.data.layers) do
			count = count + 1;
			local frame;
			if (count == 1) then
				frame = _G[type .. "NWB"].timerFrame;
				if (not _G[type .. "NWB"]["timerFrame"].fs2) then
					_G[type .. "NWB"]["timerFrame"].fs2 = _G[type .. "NWB"]["timerFrame"]:CreateFontString(k .. "NWBTimerFrameFS2", "ARTWORK");
					_G[type .. "NWB"]["timerFrame"].fs2:SetPoint("RIGHT", 17, 1);
					_G[type .. "NWB"]["timerFrame"].fs2:SetFont(NWB.regionFont, 13);
					_G[type .. "NWB"]["timerFrame"].fs2:SetText("|cff00ff00[L" .. count .. "]");
				end
			else
				if (_G[type .. "NWB"]["timerFrame" .. count]) then
					frame = _G[type .. "NWB"]["timerFrame" .. count];
				else
					--Create frame if doesn't exist.
					_G[type .. "NWB"]["timerFrame" .. count] = CreateFrame("Frame", k.. "TimerFrame" .. count, _G[type .. "NWB"], "TooltipBorderedFrameTemplate");
					_G[type .. "NWB"]["timerFrame" .. count]:SetFrameStrata("FULLSCREEN");
					_G[type .. "NWB"]["timerFrame" .. count]:SetFrameLevel(9);
					_G[type .. "NWB"]["timerFrame" .. count].fs = _G[type .. "NWB"]["timerFrame" .. count]:CreateFontString(k .. "NWBTimerFrameFS" .. count, "ARTWORK");
					_G[type .. "NWB"]["timerFrame" .. count].fs:SetPoint("CENTER", 0, 0.5);
					_G[type .. "NWB"]["timerFrame" .. count].fs:SetFont(NWB.regionFont, 12);
					_G[type .. "NWB"]["timerFrame" .. count].fs:SetText("00:00");
					--Outside frame layer text.
					_G[type .. "NWB"]["timerFrame" .. count].fs2 = _G[type .. "NWB"]["timerFrame" .. count]:CreateFontString(k .. "NWBTimerFrameFS2" .. count, "ARTWORK");
					_G[type .. "NWB"]["timerFrame" .. count].fs2:SetPoint("RIGHT", 17, 1);
					_G[type .. "NWB"]["timerFrame" .. count].fs2:SetFont(NWB.regionFont, 13);
					_G[type .. "NWB"]["timerFrame" .. count].fs2:SetText("|cff00ff00[L" .. count .. "]");
					_G[type .. "NWB"]["timerFrame" .. count]:SetWidth(_G[type .. "NWB"]["timerFrame" .. count].fs:GetStringWidth() + 14);
					_G[type .. "NWB"]["timerFrame" .. count]:SetHeight(_G[type .. "NWB"]["timerFrame" .. count].fs:GetStringHeight() + 9);
					frame = _G[type .. count .. "NWB"];
					if (not mapSFFrames[type]) then
						mapSFFrames[type] = {};
					end
					mapSFFrames[type][k] = count;
				end
			end
			if (frame) then
				local time = (NWB.data.layers[k][type] + 1500) - GetServerTime();
				if (NWB.db.global.showExpiredTimers and time < 1 and time > (0 - (60 * NWB.db.global.expiredTimersDuration))) then
					--Convert seconds left to positive.
					time = time * -1;
			    	local minutes = string.format("%02.f", math.floor(time / 60));
			    	local seconds = string.format("%02.f", math.floor(time - minutes * 60));
					--tooltipText = tooltipText .. "\n|Cffff2500"
					--		.. NWB:getTimeFormat(NWB.data[type] + 1500) .. " " .. L["spawn"] .. " (expired) (Layer " .. count .. ")|r";
					tooltipText = "|Cffff2500"
							.. NWB:getTimeFormat(NWB.data.layers[k][type] + 1500) .. " " .. L["spawn"] .. L[" (expired) (Layer "] .. count .. ")|r\n" .. tooltipText
					frame.fs:SetText("|Cffff2500-" .. minutes .. ":" .. seconds);
					frame:SetWidth(42);
					frame:SetHeight(24);
					hasTimer = count;
			  	elseif (time > 0) then
					--If timer is less than 25 minutes old then return time left.
			    	local minutes = string.format("%02.f", math.floor(time / 60));
			    	local seconds = string.format("%02.f", math.floor(time - minutes * 60));
			    	--tooltipText = tooltipText .. "\n" .. NWB:getTimeFormat(NWB.data[type] + 1500)
			    	--		.. "" .. L["spawn"] .. " (Layer " .. count .. ")";
			    	tooltipText = NWB:getTimeFormat(NWB.data.layers[k][type] + 1500)
			    			.. " " .. L["spawn"] .. L[" (Layer "] .. count .. ")\n" .. tooltipText
					frame.fs:SetText(minutes .. ":" .. seconds);
					frame:SetWidth(42);
					frame:SetHeight(24);
					hasTimer = count;
			  	else
			  		--tooltipText = tooltipText .. "\n" .. L["noTimer"] .. " (Layer " .. count .. ")";
			  		tooltipText = L["noTimer"] .. L[" (Layer "] .. count .. ")\n" .. tooltipText
					frame:Hide();
					frame.fs:SetText(L["noTimer"]);
					frame:SetWidth(54);
					frame:SetHeight(22);
				end
			end
		end
		if (hasTimer) then
			--Show all frames if any have an active timer.
			for i = 1, count do
				if (i == 1) then
					_G[type .. "NWB"]["timerFrame"]:Show();
				elseif (_G[type .. "NWB"]["timerFrame" .. i]) then
					_G[type .. "NWB"]["timerFrame" .. i]:SetPoint("CENTER", 0, i * 18.5);
					_G[type .. "NWB"]["timerFrame" .. i]:Show();
				end
			end
			--_G[type .. "NWB"].tooltip.fs:SetText("|CffDEDE42" .. _G[type .. "NWB"].name .. "|r\n" .. _G[type .. "NWB"].subZone .. tooltipText);
			_G[type .. "NWB"].tooltip.fs:SetText("|CffDEDE42" .. _G[type .. "NWB"].name .. "|r\n" .. _G[type .. "NWB"].subZone .. "\n" .. tooltipText);
		else
			_G[type .. "NWB"].tooltip.fs:SetText("|CffDEDE42" .. _G[type .. "NWB"].name .. "|r\n" .. _G[type .. "NWB"].subZone);
			_G[type .. "NWBMini"].timerFrame:Hide();
		end
		_G[type .. "NWB"].tooltip:SetWidth(_G[type .. "NWB"].tooltip.fs:GetStringWidth() + 9);
		_G[type .. "NWB"].tooltip:SetHeight(_G[type .. "NWB"].tooltip.fs:GetStringHeight() + 9);
	else
		--Seconds left.
		local time = (NWB.data[type] + 1500) - GetServerTime();
		if (NWB.db.global.showExpiredTimers and time < 1 and time > (0 - (60 * NWB.db.global.expiredTimersDuration))) then
			--Convert seconds left to positive.
			time = time * -1;
	    	local minutes = string.format("%02.f", math.floor(time / 60));
	    	local seconds = string.format("%02.f", math.floor(time - minutes * 60));
	    	_G[type .. "NWB"].timerFrame:Show();
	    	local tooltipText = "|CffDEDE42" .. _G[type .. "NWB"].name .. "|r\n" .. _G[type .. "NWB"].subZone .. "\n"
					.. "|Cffff2500" .. NWB:getTimeFormat(NWB.data[type] + 1500) .. " " .. L["spawn"] .. L[" (expired)"];
	    	_G[type .. "NWB"].tooltip.fs:SetText(tooltipText);
			_G[type .. "NWB"].tooltip:SetWidth(_G[type .. "NWB"].tooltip.fs:GetStringWidth() + 18);
			_G[type .. "NWB"].tooltip:SetHeight(_G[type .. "NWB"].tooltip.fs:GetStringHeight() + 12);
			_G[type .. "NWB"].timerFrame.fs:SetText("|Cffff2500-" .. minutes .. ":" .. seconds);
	  	elseif (time > 0) then
			--If timer is less than 25 minutes old then return time left.
	    	local minutes = string.format("%02.f", math.floor(time / 60));
	    	local seconds = string.format("%02.f", math.floor(time - minutes * 60));
	    	_G[type .. "NWB"].timerFrame:Show();
	    	local tooltipText = "|CffDEDE42" .. _G[type .. "NWB"].name .. "|r\n" .. _G[type .. "NWB"].subZone .. "\n"
	    			.. NWB:getTimeFormat(NWB.data[type] + 1500) .. " " .. L["spawn"];
	    	_G[type .. "NWB"].tooltip.fs:SetText(tooltipText);
			_G[type .. "NWB"].tooltip:SetWidth(_G[type .. "NWB"].tooltip.fs:GetStringWidth() + 18);
			_G[type .. "NWB"].tooltip:SetHeight(_G[type .. "NWB"].tooltip.fs:GetStringHeight() + 12);
			_G[type .. "NWB"].timerFrame.fs:SetText(minutes .. ":" .. seconds);
	  	else
		  	_G[type .. "NWB"].tooltip.fs:SetText("|CffDEDE42" .. _G[type .. "NWB"].name .. "|r\n" .. _G[type .. "NWB"].subZone);
			_G[type .. "NWB"].tooltip:SetWidth(_G[type .. "NWB"].tooltip.fs:GetStringWidth() + 18);
			_G[type .. "NWB"].tooltip:SetHeight(_G[type .. "NWB"].tooltip.fs:GetStringHeight() + 12);
		  	_G[type .. "NWB"].timerFrame:Hide();
		  	_G[type .. "NWB"].timerFrame.fs:SetText("");
		end
	end
end

--Update timer for minimap.
local minimapSFFrames = {};
function NWB:updateFelwoodMinimapMarker(type)
	if (NWB.layeredSongflowers and string.match(type, "flower")) then
		--Flowers are only updated once per second, not every frame.
		local count = 0;
		local tooltipText = "";
		local hasTimer;
		for k, v in pairs(minimapSFFrames) do
			--Remove any frames for any layer has been removed from db.
			--Note that layer1 frame is never added to the minimapSFFrames table, only extra layer frames are.
			--Layer 1 frame is the same frame non-layered realms use and will always be shown if any layer has a timer.
			for kk, vv in pairs(v) do
				if (not NWB.data.layers[tonumber(kk)]) then
					_G[k .. "NWBMini"]["timerFrame" .. vv]:Hide();
					_G[k .. "NWBMini"]["timerFrame" .. vv] = nil;
					minimapSFFrames[k][kk] = nil;
				end
			end
		end
		for k, v in NWB:pairsByKeys(NWB.data.layers) do
			count = count + 1;
			local frame;
			if (count == 1) then
				frame = _G[type .. "NWBMini"].timerFrame;
				if (not _G[type .. "NWBMini"]["timerFrame"].fs2) then
					_G[type .. "NWBMini"]["timerFrame"].fs2 = _G[type .. "NWBMini"]["timerFrame"]:CreateFontString(k .. "NWBMiniTimerFrameFS2", "ARTWORK");
					_G[type .. "NWBMini"]["timerFrame"].fs2:SetPoint("RIGHT", 17, 1);
					_G[type .. "NWBMini"]["timerFrame"].fs2:SetFont(NWB.regionFont, 11);
					_G[type .. "NWBMini"]["timerFrame"].fs2:SetText("|cff00ff00[L" .. count .. "]");
				end
			else
				if (_G[type .. "NWBMini"]["timerFrame" .. count]) then
					frame = _G[type .. "NWBMini"]["timerFrame" .. count];
				else
					--Create frame if doesn't exist.
					_G[type .. "NWBMini"]["timerFrame" .. count] = CreateFrame("Frame", k.. "TimerFrameMini" .. count, _G[type .. "NWBMini"], "TooltipBorderedFrameTemplate");
					_G[type .. "NWBMini"]["timerFrame" .. count]:SetFrameStrata("FULLSCREEN");
					_G[type .. "NWBMini"]["timerFrame" .. count]:SetFrameLevel(9);
					_G[type .. "NWBMini"]["timerFrame" .. count].fs = _G[type .. "NWBMini"]["timerFrame" .. count]:CreateFontString(k .. "NWBMiniTimerFrameFS" .. count, "ARTWORK");
					_G[type .. "NWBMini"]["timerFrame" .. count].fs:SetPoint("CENTER", 0, 0.5);
					_G[type .. "NWBMini"]["timerFrame" .. count].fs:SetFont(NWB.regionFont, 12);
					_G[type .. "NWBMini"]["timerFrame" .. count].fs:SetText("00:00");
					--Outside frame layer text.
					_G[type .. "NWBMini"]["timerFrame" .. count].fs2 = _G[type .. "NWBMini"]["timerFrame" .. count]:CreateFontString(k .. "NWBMiniTimerFrameFS2" .. count, "ARTWORK");
					_G[type .. "NWBMini"]["timerFrame" .. count].fs2:SetPoint("RIGHT", 17, 1);
					_G[type .. "NWBMini"]["timerFrame" .. count].fs2:SetFont(NWB.regionFont, 11);
					_G[type .. "NWBMini"]["timerFrame" .. count].fs2:SetText("|cff00ff00[L" .. count .. "]");
					_G[type .. "NWBMini"]["timerFrame" .. count]:SetWidth(_G[type .. "NWBMini"]["timerFrame" .. count].fs:GetStringWidth() + 14);
					_G[type .. "NWBMini"]["timerFrame" .. count]:SetHeight(_G[type .. "NWBMini"]["timerFrame" .. count].fs:GetStringHeight() + 9);
					frame = _G[type .. count .. "NWBMini"];
					if (not minimapSFFrames[type]) then
						minimapSFFrames[type] = {};
					end
					minimapSFFrames[type][k] = count;
				end
			end
			if (frame) then
				local time = 0
				local time = (NWB.data.layers[k][type] + 1500) - GetServerTime();
				if (NWB.db.global.showExpiredTimers and time < 1 and time > (0 - (60 * NWB.db.global.expiredTimersDuration))) then
					--Convert seconds left to positive.
					time = time * -1;
			    	local minutes = string.format("%02.f", math.floor(time / 60));
			    	local seconds = string.format("%02.f", math.floor(time - minutes * 60));
					--tooltipText = tooltipText .. "\n|Cffff2500"
					--		.. NWB:getTimeFormat(NWB.data.layers[k][type] + 1500) .. " " .. L["spawn"] .. " (expired) (Layer " .. count .. ")|r";
					tooltipText = "|Cffff2500"
							.. NWB:getTimeFormat(NWB.data.layers[k][type] + 1500) .. " " .. L["spawn"] .. L[" (expired) (Layer "] .. count .. ")|r\n" .. tooltipText;
					frame.fs:SetText("|Cffff2500-" .. minutes .. ":" .. seconds);
					frame:SetWidth(frame.fs:GetStringWidth() + 14);
					frame:SetHeight(frame.fs:GetStringHeight() + 9);
					hasTimer = count;
			  	elseif (time > 0) then
					--If timer is less than 25 minutes old then return time left.
			    	local minutes = string.format("%02.f", math.floor(time / 60));
			    	local seconds = string.format("%02.f", math.floor(time - minutes * 60));
			    	--tooltipText = tooltipText .. "\n" .. NWB:getTimeFormat(NWB.data.layers[k][type] + 1500)
			    	--		.. " " .. L["spawn"] .. " (Layer " .. count .. ")";
			    	tooltipText =  NWB:getTimeFormat(NWB.data.layers[k][type] + 1500)
			    			.. " " .. L["spawn"] .. L[" (Layer "] .. count .. ")\n" .. tooltipText;
					frame.fs:SetText(minutes .. ":" .. seconds);
					frame:SetWidth(frame.fs:GetStringWidth() + 14);
					frame:SetHeight(frame.fs:GetStringHeight() + 9);
					hasTimer = count;
			  	else
			  		--tooltipText = tooltipText .. "\n" .. L["noTimer"] .. " (Layer " .. count .. ")";
			  		tooltipText = L["noTimer"] .. L[" (Layer "] .. count .. ")\n" .. tooltipText;
					frame:Hide();
					frame.fs:SetText(L["noTimer"]);
					frame:SetWidth(frame.fs:GetStringWidth() + 14);
					frame:SetHeight(frame.fs:GetStringHeight() + 9);
				end
			end
		end
		if (hasTimer) then
			--Show all frames if any have an active timer.
			for i = 1, count do
				if (i == 1) then
					_G[type .. "NWBMini"]["timerFrame"]:Show();
				elseif (_G[type .. "NWBMini"]["timerFrame" .. i]) then
					_G[type .. "NWBMini"]["timerFrame" .. i]:SetPoint("CENTER", 0, i * 18);
					_G[type .. "NWBMini"]["timerFrame" .. i]:Show();
				end
			end
			--_G[type .. "NWBMini"].tooltip.fs:SetText("|CffDEDE42" .. _G[type .. "NWB"].name .. "|r\n" .. _G[type .. "NWB"].subZone .. tooltipText);
			_G[type .. "NWBMini"].tooltip.fs:SetText("|CffDEDE42" .. _G[type .. "NWB"].name .. "|r\n" .. _G[type .. "NWB"].subZone .. "\n" .. tooltipText);
		else
			_G[type .. "NWBMini"].tooltip.fs:SetText("|CffDEDE42" .. _G[type .. "NWB"].name .. "|r\n" .. _G[type .. "NWB"].subZone);
			_G[type .. "NWBMini"].timerFrame:Hide();
		end
		_G[type .. "NWBMini"].tooltip:SetWidth(_G[type .. "NWBMini"].tooltip.fs:GetStringWidth() + 9);
		_G[type .. "NWBMini"].tooltip:SetHeight(_G[type .. "NWBMini"].tooltip.fs:GetStringHeight() + 9);
	else
		--Seconds left.
		local time = (NWB.data[type] + 1500) - GetServerTime();
		if (NWB.db.global.showExpiredTimers and time < 1 and time > (0 - (60 * NWB.db.global.expiredTimersDuration))) then
			--Convert seconds left to positive.
			time = time * -1;
	    	local minutes = string.format("%02.f", math.floor(time / 60));
	    	local seconds = string.format("%02.f", math.floor(time - minutes * 60));
	    	_G[type .. "NWBMini"].timerFrame:Show();
			local tooltipText = "|CffDEDE42" .. _G[type .. "NWB"].name .. "|r\n" .. _G[type .. "NWB"].subZone .. "\n"
					.. "|Cffff2500" .. NWB:getTimeFormat(NWB.data[type] + 1500) .. " " .. L["spawn"] .. " (expired)";
	    	_G[type .. "NWBMini"].tooltip.fs:SetText(tooltipText);
	    	_G[type .. "NWBMini"].tooltip:SetWidth(_G[type .. "NWBMini"].tooltip.fs:GetStringWidth() + 9);
			_G[type .. "NWBMini"].tooltip:SetHeight(_G[type .. "NWBMini"].tooltip.fs:GetStringHeight() + 9);
			_G[type .. "NWBMini"].timerFrame.fs:SetText("|Cffff2500-" .. minutes .. ":" .. seconds);
	  	elseif (time > 0) then
			--If timer is less than 25 minutes old then return time left.
	    	local minutes = string.format("%02.f", math.floor(time / 60));
	    	local seconds = string.format("%02.f", math.floor(time - minutes * 60));
	    	_G[type .. "NWBMini"].timerFrame:Show();
	    	local tooltipText = "|CffDEDE42" .. _G[type .. "NWB"].name .. "|r\n" .. _G[type .. "NWB"].subZone .. "\n"
	    			.. NWB:getTimeFormat(NWB.data[type] + 1500) .. " " .. L["spawn"];
	    	_G[type .. "NWBMini"].tooltip.fs:SetText(tooltipText);
	    	_G[type .. "NWBMini"].tooltip:SetWidth(_G[type .. "NWBMini"].tooltip.fs:GetStringWidth() + 9);
			_G[type .. "NWBMini"].tooltip:SetHeight(_G[type .. "NWBMini"].tooltip.fs:GetStringHeight() + 9);
			_G[type .. "NWBMini"].timerFrame.fs:SetText(minutes .. ":" .. seconds);
	  	else
			_G[type .. "NWBMini"].tooltip.fs:SetText("|CffDEDE42" .. _G[type .. "NWB"].name .. "|r\n" .. _G[type .. "NWB"].subZone);
			_G[type .. "NWBMini"].tooltip:SetWidth(_G[type .. "NWBMini"].tooltip.fs:GetStringWidth() + 9);
			_G[type .. "NWBMini"].tooltip:SetHeight(_G[type .. "NWBMini"].tooltip.fs:GetStringHeight() + 9);
			_G[type .. "NWBMini"].timerFrame:Hide();
			_G[type .. "NWBMini"].timerFrame.fs:SetText(L["noTimer"]);
		end
	end
end

function NWB:createSongflowerMarkers()
	local iconLocation = "Interface\\Icons\\spell_holy_mindvision";
	for k, v in pairs(NWB.songFlowers) do
		--Worldmap marker.
		local obj = CreateFrame("Frame", k .. "NWB", WorldMapFrame);
		obj.type = k;
		obj.name = L["Songflower"];
		obj.subZone = v.subZone;
		local bg = obj:CreateTexture(nil, "MEDIUM");
		bg:SetTexture(iconLocation);
		bg:SetAllPoints(obj);
		obj.texture = bg;
		obj:SetSize(15, 15);
		--World map tooltip.
		obj.tooltip = CreateFrame("Frame", k.. "Tooltip", WorldMapFrame, "TooltipBorderedFrameTemplate");
		obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, -36);
		obj.tooltip:SetFrameStrata("TOOLTIP");
		obj.tooltip:SetFrameLevel(9);
		obj.tooltip.fs = obj.tooltip:CreateFontString(k .. "NWBTooltipFS", "ARTWORK");
		obj.tooltip.fs:SetPoint("CENTER", 0, 0);
		obj.tooltip.fs:SetFont(NWB.regionFont, 12);
		obj.tooltip.fs:SetText("|CffDEDE42" .. L["Songflower"] .. "|r\n" .. v.subZone);
		obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 18);
		obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 12);
		obj:SetScript("OnEnter", function(self)
			obj.tooltip:Show();
		end)
		obj:SetScript("OnLeave", function(self)
			obj.tooltip:Hide();
		end)
		obj.tooltip:Hide();
		--Timer frame that sits above the icon when an active timer is found.
		obj.timerFrame = CreateFrame("Frame", k.. "TimerFrame", WorldMapFrame, "TooltipBorderedFrameTemplate");
		obj.timerFrame:SetPoint("CENTER", obj, "CENTER", 0, 20);
		obj.timerFrame:SetFrameStrata("FULLSCREEN");
		obj.timerFrame:SetFrameLevel(9);
		obj.timerFrame.fs = obj.timerFrame:CreateFontString(k .. "NWBTimerFrameFS", "ARTWORK");
		obj.timerFrame.fs:SetPoint("CENTER", 0, 0);
		obj.timerFrame.fs:SetFont(NWB.regionFont, 13);
		obj.timerFrame:SetWidth(42);
		obj.timerFrame:SetHeight(24);
		obj.lastUpdate = 0;
		obj:SetScript("OnUpdate", function(self)
			if (GetServerTime() - obj.lastUpdate < 1) then
				--1 second throddle.
				return;
			end
			--Update timer when map is open.
			NWB:updateFelwoodWorldmapMarker(obj.type);
			obj.lastUpdate = GetServerTime();
		end)
		--Make it act like pin is the parent and not WorldMapFrame.
		obj:SetScript("OnHide", function(self)
			obj.timerFrame:Hide();
		end)
		obj:SetScript("OnShow", function(self)
			obj.timerFrame:Show();
		end)
		obj:SetScript("OnMouseDown", function(self, button)
			if (IsShiftKeyDown()) then
				local time = (NWB.data[obj.type] + 1500) - GetServerTime();
				if (NWB.isLayered and NWB.layeredSongflowers and NWB:GetLayerCount() >= 2 and NWB.lastKnownLayerMapID and NWB.lastKnownLayerMapID > 0
							and NWB.lastKnownLayer and NWB.lastKnownLayer > 0) then
					time = (NWB.data.layers[NWB.lastKnownLayerMapID][obj.type] + 1500) - GetServerTime();
				end
				if (time > 0) then
					local msg = string.format(L["singleSongflowerMsg"], NWB.songFlowers[obj.type].subZone, NWB:getTimeString(time, true));
					if (NWB.isLayered and NWB.layeredSongflowers and NWB:GetLayerCount() >= 2 and NWB.lastKnownLayerMapID and NWB.lastKnownLayerMapID > 0
							and NWB.lastKnownLayer and NWB.lastKnownLayer > 0) then
						msg = msg .. L[" (Layer "] .. NWB.lastKnownLayer .. ")";
					elseif (NWB.isLayered and NWB.layeredSongflowers) then
						NWB:print(L["No layer currently known for Felwood, try targetting a NPC."]);
						return;
					end
					if (button == "RightButton") then
						SendChatMessage("[NovaWorldBuffs] " .. msg, "say");
					else
						SendChatMessage("[WorldBuffs] " .. msg .. " (" .. NWB.songFlowers[obj.type].x .. ", " .. NWB.songFlowers[obj.type].y .. ")", "guild");
					end
				else
					NWB:print(L["noTimer"] .. " (" .. NWB.songFlowers[obj.type].subZone .. ").");
				end
			else
				NWB:openBuffListFrame();
			end
		end)
		
		--Minimap marker.
		local obj = CreateFrame("FRAME", k .. "NWBMini");
		obj.type = k;
		obj.name = L["Songflower"];
		obj.subZone = v.subZone;
		local bg = obj:CreateTexture(nil, "MEDIUM");
		bg:SetTexture(iconLocation);
		bg:SetAllPoints(obj);
		obj.texture = bg;
		obj:SetSize(12, 12);
		--Minimap tooltip.
		obj.tooltip = CreateFrame("Frame", k.. "Tooltip", MinimMapFrame, "TooltipBorderedFrameTemplate");
		obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, 18);
		obj.tooltip:SetFrameStrata("TOOLTIP");
		obj.tooltip:SetFrameLevel(9);
		obj.tooltip.fs = obj.tooltip:CreateFontString(k .. "NWBTooltipFS", "ARTWORK");
		obj.tooltip.fs:SetPoint("CENTER", 0, 0);
		obj.tooltip.fs:SetFont(NWB.regionFont, 8.5);
		obj.tooltip.fs:SetText("00:00");
		obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 9);
		obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 9);
		obj:SetScript("OnEnter", function(self)
			obj.tooltip:Show();
		end)
		obj:SetScript("OnLeave", function(self)
			obj.tooltip:Hide();
		end)
		--Timer frame that sits above the icon when an active timer is found.
		obj.timerFrame = CreateFrame("Frame", k.. "TimerFrameMini", obj, "TooltipBorderedFrameTemplate");
		obj.timerFrame:SetPoint("CENTER", 0, 18);
		obj.timerFrame:SetFrameStrata("FULLSCREEN");
		obj.timerFrame:SetFrameLevel(9);
		obj.timerFrame.fs = obj.timerFrame:CreateFontString(k .. "NWBTimerFrameFS", "ARTWORK");
		obj.timerFrame.fs:SetPoint("CENTER", 0, 0.5);
		obj.timerFrame.fs:SetFont(NWB.regionFont, 12);
		obj.timerFrame.fs:SetText("00:00");
		obj.timerFrame:SetWidth(obj.timerFrame.fs:GetStringWidth() + 14);
		obj.timerFrame:SetHeight(obj.timerFrame.fs:GetStringHeight() + 9);
		obj.lastUpdate = 0;
		obj:SetScript("OnUpdate", function(self)
			if (GetServerTime() - obj.lastUpdate < 1) then
				--1 second throddle.
				return;
			end
			--Update timer when minimap icon is in range.
			NWB:updateFelwoodMinimapMarker(obj.type);
			obj.timerFrame:SetWidth(obj.timerFrame.fs:GetStringWidth() + 14);
			obj.timerFrame:SetHeight(obj.timerFrame.fs:GetStringHeight() + 9);
			obj.lastUpdate = GetServerTime();
		end)
		obj.tooltip:Hide();
		obj:SetScript("OnMouseDown", function(self, button)
			if (IsShiftKeyDown()) then
				local time = (NWB.data[obj.type] + 1500) - GetServerTime();
				if (NWB.isLayered and NWB.layeredSongflowers and NWB:GetLayerCount() >= 2 and NWB.lastKnownLayerMapID and NWB.lastKnownLayerMapID > 0
							and NWB.lastKnownLayer and NWB.lastKnownLayer > 0) then
					time = (NWB.data.layers[NWB.lastKnownLayerMapID][obj.type] + 1500) - GetServerTime();
				end
				if (time > 0) then
					local msg = string.format(L["singleSongflowerMsg"], NWB.songFlowers[obj.type].subZone, NWB:getTimeString(time, true));
					if (NWB.isLayered and NWB.layeredSongflowers and NWB:GetLayerCount() >= 2 and NWB.lastKnownLayerMapID and NWB.lastKnownLayerMapID > 0
							and NWB.lastKnownLayer and NWB.lastKnownLayer > 0) then
						msg = msg .. L[" (Layer "] .. NWB.lastKnownLayer .. ")";
					elseif (NWB.isLayered and NWB.layeredSongflowers) then
						NWB:print(L["No layer currently known for Felwood, try targetting a NPC."]);
						return;
					end
					if (button == "RightButton") then
						SendChatMessage("[NovaWorldBuffs] " .. msg, "say");
					else
						SendChatMessage("[WorldBuffs] " .. msg .. " (" .. NWB.songFlowers[obj.type].x .. ", " .. NWB.songFlowers[obj.type].y .. ")", "guild");
					end
				else
					NWB:print(L["noTimer"] .. " (" .. NWB.songFlowers[obj.type].subZone .. ").");
				end
			else
				NWB:openBuffListFrame();
			end
		end)
	end
end

function NWB:createTuberMarkers()
	local iconLocation = "Interface\\Icons\\inv_misc_food_55";
	for k, v in pairs(NWB.tubers) do
		--Worldmap marker.
		local obj = CreateFrame("Frame", k .. "NWB", WorldMapFrame);
		obj.type = k;
		obj.name = L["Whipper Root Tuber"];
		obj.subZone = v.subZone;
		local bg = obj:CreateTexture(nil, "MEDIUM");
		bg:SetTexture(iconLocation);
		bg:SetAllPoints(obj);
		obj.texture = bg;
		obj:SetSize(12, 12);
		--World map tooltip.
		obj.tooltip = CreateFrame("Frame", k.. "Tooltip", WorldMapFrame, "TooltipBorderedFrameTemplate");
		obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, -36);
		obj.tooltip:SetFrameStrata("TOOLTIP");
		obj.tooltip:SetFrameLevel(9);
		obj.tooltip.fs = obj.tooltip:CreateFontString(k .. "NWBTooltipFS", "ARTWORK");
		obj.tooltip.fs:SetPoint("CENTER", 0, 0);
		obj.tooltip.fs:SetFont(NWB.regionFont, 12);
		obj.tooltip.fs:SetText("|CffDEDE42" .. L["Songflower"] .. "|r\n" .. v.subZone);
		obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 18);
		obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 12);
		obj:SetScript("OnEnter", function(self)
			obj.tooltip:Show();
		end)
		obj:SetScript("OnLeave", function(self)
			obj.tooltip:Hide();
		end)
		obj.tooltip:Hide();
		--Timer frame that sits above the icon when an active timer is found.
		obj.timerFrame = CreateFrame("Frame", k.. "TimerFrame", WorldMapFrame, "TooltipBorderedFrameTemplate");
		obj.timerFrame:SetPoint("CENTER", obj, "CENTER", 0, 17);
		obj.timerFrame:SetFrameStrata("FULLSCREEN");
		obj.timerFrame:SetFrameLevel(9);
		obj.timerFrame.fs = obj.timerFrame:CreateFontString(k .. "NWBTimerFrameFS", "ARTWORK");
		obj.timerFrame.fs:SetPoint("CENTER", 0, 0);
		obj.timerFrame.fs:SetFont(NWB.regionFont, 11);
		obj.timerFrame:SetWidth(38);
		obj.timerFrame:SetHeight(20);
		obj:SetScript("OnUpdate", function(self)
			--Update timer when map is open.
			NWB:updateFelwoodWorldmapMarker(obj.type);
			--obj.timerFrame:SetWidth(obj.timerFrame.fs:GetStringWidth() + 15);
			--obj.timerFrame:SetHeight(obj.timerFrame.fs:GetStringHeight() + 9);
		end)
		--Make it act like pin is the parent and not WorldMapFrame.
		obj:SetScript("OnHide", function(self)
			obj.timerFrame:Hide();
		end)
		obj:SetScript("OnShow", function(self)
			obj.timerFrame:Show();
		end)
		obj:SetScript("OnMouseDown", function(self)
			NWB:openBuffListFrame();
		end)
		
		--Minimap marker.
		local obj = CreateFrame("FRAME", k .. "NWBMini");
		obj.type = k;
		obj.name = L["Whipper Root Tuber"];
		obj.subZone = v.subZone;
		local bg = obj:CreateTexture(nil, "MEDIUM");
		bg:SetTexture(iconLocation);
		bg:SetAllPoints(obj);
		obj.texture = bg;
		obj:SetSize(12, 12);
		--Minimap tooltip.
		obj.tooltip = CreateFrame("Frame", k.. "Tooltip", MinimMapFrame, "TooltipBorderedFrameTemplate");
		obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, 18);
		obj.tooltip:SetFrameStrata("TOOLTIP");
		obj.tooltip:SetFrameLevel(9);
		obj.tooltip.fs = obj.tooltip:CreateFontString(k .. "NWBTooltipFS", "ARTWORK");
		obj.tooltip.fs:SetPoint("CENTER", 0, 0);
		obj.tooltip.fs:SetFont(NWB.regionFont, 8.5);
		obj.tooltip.fs:SetText("00:00");
		obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 9);
		obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 9);
		obj:SetScript("OnEnter", function(self)
			obj.tooltip:Show();
		end)
		obj:SetScript("OnLeave", function(self)
			obj.tooltip:Hide();
		end)
		--Timer frame that sits above the icon when an active timer is found.
		obj.timerFrame = CreateFrame("Frame", k.. "TimerFrameMini", obj, "TooltipBorderedFrameTemplate");
		obj.timerFrame:SetPoint("CENTER", 0, 18);
		obj.timerFrame:SetFrameStrata("FULLSCREEN");
		obj.timerFrame:SetFrameLevel(9);
		obj.timerFrame.fs = obj.timerFrame:CreateFontString(k .. "NWBTimerFrameFS", "ARTWORK");
		obj.timerFrame.fs:SetPoint("CENTER", 0, 0.5);
		obj.timerFrame.fs:SetFont(NWB.regionFont, 12);
		obj.timerFrame.fs:SetText("00:00");
		obj.timerFrame:SetWidth(obj.timerFrame.fs:GetStringWidth() + 14);
		obj.timerFrame:SetHeight(obj.timerFrame.fs:GetStringHeight() + 9);
		--Changed to show minimap timer awlways instead of on hover (if timer is active).
		obj:SetScript("OnUpdate", function(self)
			--Update timer when minimap icon is in range.
			NWB:updateFelwoodMinimapMarker(obj.type);
			obj.timerFrame:SetWidth(obj.timerFrame.fs:GetStringWidth() + 14);
			obj.timerFrame:SetHeight(obj.timerFrame.fs:GetStringHeight() + 9);
		end)
		obj.tooltip:Hide();
		obj:SetScript("OnMouseDown", function(self)
			NWB:openBuffListFrame();
		end)
	end
end

function NWB:createDragonMarkers()
	local iconLocation = "Interface\\Icons\\inv_misc_food_45";
	for k, v in pairs(NWB.dragons) do
		--Worldmap marker.
		local obj = CreateFrame("Frame", k .. "NWB", WorldMapFrame);
		obj.type = k;
		obj.name = L["Night Dragon's Breath"];
		obj.subZone = v.subZone;
		local bg = obj:CreateTexture(nil, "MEDIUM");
		bg:SetTexture(iconLocation);
		bg:SetAllPoints(obj);
		obj.texture = bg;
		obj:SetSize(12, 12);
		--World map tooltip.
		obj.tooltip = CreateFrame("Frame", k.. "Tooltip", WorldMapFrame, "TooltipBorderedFrameTemplate");
		obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, -36);
		obj.tooltip:SetFrameStrata("TOOLTIP");
		obj.tooltip:SetFrameLevel(9);
		obj.tooltip.fs = obj.tooltip:CreateFontString(k .. "NWBTooltipFS", "ARTWORK");
		obj.tooltip.fs:SetPoint("CENTER", 0, 0);
		obj.tooltip.fs:SetFont(NWB.regionFont, 12);
		obj.tooltip.fs:SetText("|CffDEDE42" .. L["Songflower"] .. "|r\n" .. v.subZone);
		obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 18);
		obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 12);
		obj:SetScript("OnEnter", function(self)
			obj.tooltip:Show();
		end)
		obj:SetScript("OnLeave", function(self)
			obj.tooltip:Hide();
		end)
		obj.tooltip:Hide();
		--Timer frame that sits above the icon when an active timer is found.
		obj.timerFrame = CreateFrame("Frame", k.. "TimerFrame", WorldMapFrame, "TooltipBorderedFrameTemplate");
		obj.timerFrame:SetPoint("CENTER", obj, "CENTER", 0, 17);
		obj.timerFrame:SetFrameStrata("FULLSCREEN");
		obj.timerFrame:SetFrameLevel(9);
		obj.timerFrame.fs = obj.timerFrame:CreateFontString(k .. "NWBTimerFrameFS", "ARTWORK");
		obj.timerFrame.fs:SetPoint("CENTER", 0, 0);
		obj.timerFrame.fs:SetFont(NWB.regionFont, 11);
		obj.timerFrame:SetWidth(38);
		obj.timerFrame:SetHeight(20);
		obj:SetScript("OnUpdate", function(self)
			--Update timer when map is open.
			NWB:updateFelwoodWorldmapMarker(obj.type);
			--obj.timerFrame:SetWidth(obj.timerFrame.fs:GetStringWidth() + 15);
			--obj.timerFrame:SetHeight(obj.timerFrame.fs:GetStringHeight() + 9);
		end)
		--Make it act like pin is the parent and not WorldMapFrame.
		obj:SetScript("OnHide", function(self)
			obj.timerFrame:Hide();
		end)
		obj:SetScript("OnShow", function(self)
			obj.timerFrame:Show();
		end)
		obj:SetScript("OnMouseDown", function(self)
			NWB:openBuffListFrame();
		end)
		
		--Minimap marker.
		local obj = CreateFrame("FRAME", k .. "NWBMini");
		obj.type = k;
		obj.name = L["Night Dragon's Breath"];
		obj.subZone = v.subZone;
		local bg = obj:CreateTexture(nil, "MEDIUM");
		bg:SetTexture(iconLocation);
		bg:SetAllPoints(obj);
		obj.texture = bg;
		obj:SetSize(12, 12);
		--Minimap tooltip.
		obj.tooltip = CreateFrame("Frame", k.. "Tooltip", MinimMapFrame, "TooltipBorderedFrameTemplate");
		obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, 18);
		obj.tooltip:SetFrameStrata("TOOLTIP");
		obj.tooltip:SetFrameLevel(9);
		obj.tooltip.fs = obj.tooltip:CreateFontString(k .. "NWBTooltipFS", "ARTWORK");
		obj.tooltip.fs:SetPoint("CENTER", 0, 0);
		obj.tooltip.fs:SetFont(NWB.regionFont, 8.5);
		obj.tooltip.fs:SetText("00:00");
		obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 9);
		obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 9);
		obj:SetScript("OnEnter", function(self)
			obj.tooltip:Show();
		end)
		obj:SetScript("OnLeave", function(self)
			obj.tooltip:Hide();
		end)
		--Timer frame that sits above the icon when an active timer is found.
		obj.timerFrame = CreateFrame("Frame", k.. "TimerFrameMini", obj, "TooltipBorderedFrameTemplate");
		obj.timerFrame:SetPoint("CENTER", 0, 18);
		obj.timerFrame:SetFrameStrata("FULLSCREEN");
		obj.timerFrame:SetFrameLevel(9);
		obj.timerFrame.fs = obj.timerFrame:CreateFontString(k .. "NWBTimerFrameFS", "ARTWORK");
		obj.timerFrame.fs:SetPoint("CENTER", 0, 0.5);
		obj.timerFrame.fs:SetFont(NWB.regionFont, 12);
		obj.timerFrame.fs:SetText("00:00");
		obj.timerFrame:SetWidth(obj.timerFrame.fs:GetStringWidth() + 14);
		obj.timerFrame:SetHeight(obj.timerFrame.fs:GetStringHeight() + 9);
		--Changed to show minimap timer awlways instead of on hover (if timer is active).
		obj:SetScript("OnUpdate", function(self)
			--Update timer when minimap icon is in range.
			NWB:updateFelwoodMinimapMarker(obj.type);
			obj.timerFrame:SetWidth(obj.timerFrame.fs:GetStringWidth() + 14);
			obj.timerFrame:SetHeight(obj.timerFrame.fs:GetStringHeight() + 9);
		end)
		obj.tooltip:Hide();
		obj:SetScript("OnMouseDown", function(self)
			NWB:openBuffListFrame();
		end)
	end
end

function NWB:refreshFelwoodMarkers()
	for k, v in pairs(NWB.songFlowers) do
		NWB.dragonLibPins:RemoveWorldMapIcon(k .. "NWB", _G[k .. "NWB"]);
		NWB.dragonLibPins:RemoveMinimapIcon(k .. "NWBMini", _G[k .. "NWBMini"]);
		if (NWB.db.global.showSongflowerWorldmapMarkers) then
			NWB.dragonLibPins:AddWorldMapIconMap(k .. "NWB", _G[k .. "NWB"], 1448, v.x/100, v.y/100);
		end
		if (NWB.db.global.showSongflowerMinimapMarkers) then
			NWB.dragonLibPins:AddMinimapIconMap(k .. "NWBMini", _G[k .. "NWBMini"], 1448, v.x/100, v.y/100);
		end
	end
	for k, v in pairs(NWB.tubers) do
		NWB.dragonLibPins:RemoveWorldMapIcon(k .. "NWB", _G[k .. "NWB"]);
		NWB.dragonLibPins:RemoveMinimapIcon(k .. "NWBMini", _G[k .. "NWBMini"]);
		if (NWB.db.global.showTuberWorldmapMarkers) then
			NWB.dragonLibPins:AddWorldMapIconMap(k .. "NWB", _G[k .. "NWB"], 1448, v.x/100, v.y/100);
		end
		if (NWB.db.global.showTuberMinimapMarkers) then
			NWB.dragonLibPins:AddMinimapIconMap(k .. "NWBMini", _G[k .. "NWBMini"], 1448, v.x/100, v.y/100);
		end
	end
	for k, v in pairs(NWB.dragons) do
		NWB.dragonLibPins:RemoveWorldMapIcon(k .. "NWB", _G[k .. "NWB"]);
		NWB.dragonLibPins:RemoveMinimapIcon(k .. "NWBMini", _G[k .. "NWBMini"]);
		if (NWB.db.global.showDragonWorldmapMarkers) then
			NWB.dragonLibPins:AddWorldMapIconMap(k .. "NWB", _G[k .. "NWB"], 1448, v.x/100, v.y/100);
		end
		if (NWB.db.global.showDragonMinimapMarkers) then
			NWB.dragonLibPins:AddMinimapIconMap(k .. "NWBMini", _G[k .. "NWBMini"], 1448, v.x/100, v.y/100);
		end
	end
end

---====================---
---Worldbuff Map Frames---
---====================---

--Update timers for worldmap when the map is open.
function NWB:updateWorldbuffMarkers(type, layer)
	--Seconds left.
	local time = 0;
	if (NWB.isLayered and layer) then
		--I've adapted this to show all layers at once on the world map.
		--Its ugly here so I don't have to change a lot of code elsewhere and it can keep using most of the non-layered stuff.
		if (type == "ony") then
			local count = 0;
			local layerZoneID = 0;
			for k, v in NWB:pairsByKeys(NWB.data.layers) do
				count = count + 1;
				if (k == tonumber(layer)) then
					layerZoneID = k;
					break;
				end
			end
			_G[type .. layer .. "NWBWorldMap"].fsLayer:SetText(L["|cff00ff00[Layer "] .. count.. "] |cFFB5E0E6(" .. layerZoneID .. ")");
		end
		if (NWB.data.layers[layer]) then
			time = (NWB.data.layers[layer][type .. "Timer"] + NWB.db.global[type .. "RespawnTime"]) - GetServerTime() or 0;
		else
			time = 0;
		end
		local npcKilled;
		if (type == "ony" or type == "nef") then
			if (NWB.data.layers[layer] and NWB.data.layers[layer][type .. "NpcDied"] and NWB.data.layers[layer][type .. "Timer"]
					and (NWB.data.layers[layer][type .. "NpcDied"] > NWB.data.layers[layer][type .. "Timer"])) then
				local killedAgo = NWB:getTimeString(GetServerTime() - NWB.data.layers[layer][type .. "NpcDied"], true) 
				local tooltipString = "|CffDEDE42" .. _G[type .. layer .. "NWBWorldMap"].name .. "\n"
	    				.. L["noTimer"] .. "\n"
	    				.. string.format(L["anyNpcKilledWithTimer"], killedAgo);
	    		_G[type .. layer .. "NWBWorldMap"].tooltip.fs:SetText(tooltipString);
	    		_G[type .. layer .. "NWBWorldMap"].tooltip:SetWidth(_G[type .. layer .. "NWBWorldMap"].tooltip.fs:GetStringWidth() + 18);
				_G[type .. layer .. "NWBWorldMap"].tooltip:SetHeight(_G[type .. layer .. "NWBWorldMap"].tooltip.fs:GetStringHeight() + 12);
				npcKilled = true;
			end
		end
		local timeStringShort;
		if (NWB.data.layers[layer] and _G[type .. layer .. "NWBWorldMap"] and time > 0 and not npcKilled) then
	    	local timeString = NWB:getTimeString(time, true);
	    	timeStringShort = NWB:getTimeString(time, true, "short");
	    	local timeStamp = NWB:getTimeFormat(NWB.data.layers[layer][type .. "Timer"] + NWB.db.global[type .. "RespawnTime"]);
	    	local tooltipString = "|CffDEDE42" .. _G[type .. layer .. "NWBWorldMap"].name .. "\n"
	    			.. timeString .. "\n"
	    			.. timeStamp;
	    	_G[type .. layer .. "NWBWorldMap"].tooltip.fs:SetText(tooltipString);
	    	_G[type .. layer .. "NWBWorldMap"].tooltip:SetWidth(_G[type .. layer .. "NWBWorldMap"].tooltip.fs:GetStringWidth() + 18);
			_G[type .. layer .. "NWBWorldMap"].tooltip:SetHeight(_G[type .. layer .. "NWBWorldMap"].tooltip.fs:GetStringHeight() + 12);
	  	elseif (not npcKilled) then
	  		_G[type .. layer .. "NWBWorldMap"].tooltip.fs:SetText("|CffDEDE42" .. _G[type .. layer .. "NWBWorldMap"].name);
	  	end
		local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
		if (_G["nef" .. layer .. "NWBWorldMap"] and _G["nef" .. layer .. "NWBWorldMap"].noLayerFrame) then
			if (NWB.faction == "Horde" and zone == 1454) then
				if (NWB.currentLayer > 0) then
					local layerMsg = L["cityMapLayerMsgHorde"];
					local layerString = L["|cff00ff00[Layer "] .. NWB.currentLayer .. "]|cff9CD6DE";
					_G["nef" .. layer .. "NWBWorldMap"].fs2:SetText("|cff9CD6DE" .. string.format(layerMsg, layerString));
					_G["nef" .. layer .. "NWBWorldMap"].noLayerFrame:Hide();
				else
					_G["nef" .. layer .. "NWBWorldMap"].fs2:SetText("");
					_G["nef" .. layer .. "NWBWorldMap"].noLayerFrame:Show();
				end
			elseif (NWB.faction == "Alliance" and zone == 1453) then
				if (NWB.currentLayer > 0) then
					local layerMsg = L["cityMapLayerMsgAlliance"];
					local layerString = L["|cff00ff00[Layer "] .. NWB.currentLayer .. "]|cff9CD6DE";
					_G["nef" .. layer .. "NWBWorldMap"].fs2:SetText("|cff9CD6DE" .. string.format(layerMsg, layerString));
					_G["nef" .. layer .. "NWBWorldMap"].noLayerFrame:Hide();
				else
					_G["nef" .. layer .. "NWBWorldMap"].fs2:SetText("");
					_G["nef" .. layer .. "NWBWorldMap"].noLayerFrame:Show();
				end
			else
				_G["nef" .. layer .. "NWBWorldMap"].noLayerFrame:Show();
			end
		end
		if (time > 0 and not npcKilled) then
	    	return timeStringShort;
	  	end
	  	if (not npcKilled) then
			_G[type .. layer .. "NWBWorldMap"].tooltip.fs:SetText("|CffDEDE42" .. _G[type .. layer .. "NWBWorldMap"].name);
		end
	  return L["noTimer"];
	else
		time = (NWB.data[type .. "Timer"] + NWB.db.global[type .. "RespawnTime"]) - GetServerTime();
		if (type == "ony" or type == "nef") then
			if (NWB.data[type .. "NpcDied"] > NWB.data[type .. "Timer"]) then
				local killedAgo = NWB:getTimeString(GetServerTime() - NWB.data[type .. "NpcDied"], true) 
				local tooltipString = "|CffDEDE42" .. _G[type .. "NWBWorldMap"].name .. "\n"
	    				.. L["noTimer"] .. "\n"
	    				.. string.format(L["anyNpcKilledWithTimer"], killedAgo);
	    		_G[type .. "NWBWorldMap"].tooltip.fs:SetText(tooltipString);
	    		_G[type .. "NWBWorldMap"].tooltip:SetWidth(_G[type .. "NWBWorldMap"].tooltip.fs:GetStringWidth() + 18);
				_G[type .. "NWBWorldMap"].tooltip:SetHeight(_G[type .. "NWBWorldMap"].tooltip.fs:GetStringHeight() + 12);
				return L["noTimer"];
			end
		end
		if (time > 0) then
	    	local timeString = NWB:getTimeString(time, true);
	    	local timeStringShort = NWB:getTimeString(time, true, "short");
	    	local timeStamp = 0;
	    	if (type == "zanCity" or type == "zanStv") then
	    		timeStamp = NWB:getTimeFormat(NWB.data["zanTimer"] + NWB.db.global["zanRespawnTime"]);
	    	else
	    		timeStamp = NWB:getTimeFormat(NWB.data[type .. "Timer"] + NWB.db.global[type .. "RespawnTime"]);
	    	end
	    	local tooltipString = "|CffDEDE42" .. _G[type .. "NWBWorldMap"].name .. "\n"
	    			.. timeString .. "\n"
	    			.. timeStamp;
	    	_G[type .. "NWBWorldMap"].tooltip.fs:SetText(tooltipString);
	    	_G[type .. "NWBWorldMap"].tooltip:SetWidth(_G[type .. "NWBWorldMap"].tooltip.fs:GetStringWidth() + 18);
			_G[type .. "NWBWorldMap"].tooltip:SetHeight(_G[type .. "NWBWorldMap"].tooltip.fs:GetStringHeight() + 12);
	    	return timeStringShort;
	  	end
	  	_G[type .. "NWBWorldMap"].tooltip.fs:SetText("|CffDEDE42" .. _G[type .. "NWBWorldMap"].name);
		return L["noTimer"];
	end
end

function NWB:createWorldbuffMarkersTable()
	if (LOCALE_koKR or LOCALE_zhCN or LOCALE_zhTW) then
		--Adjust for icon position non-english fonts in the timer frame.
    	if (NWB.faction == "Alliance") then
			NWB.worldBuffMapMarkerTypes = {
				["rend"] = {x = 71.5, y = 73.0, mapID = 1453, icon = "Interface\\Icons\\spell_arcane_teleportorgrimmar", name = L["rend"]},
				["ony"] = {x = 79.5, y = 73.0, mapID = 1453, icon = "Interface\\Icons\\inv_misc_head_dragon_01", name = L["onyxia"]},
				["nef"] = {x = 87.5, y = 73.0, mapID = 1453, icon = "Interface\\Icons\\inv_misc_head_dragon_black", name = L["nefarian"]},
				--["zanCity"] = {x = 95.5, y = 73.0, mapID = 1453, icon = "Interface\\Icons\\ability_creature_poison_05", name = L["Zandalar"]},
				--["zanStv"] = {x = 11.0, y = 20.5, mapID = 1434, icon = "Interface\\Icons\\ability_creature_poison_05", name = L["Zandalar"]},
			};
		else
			NWB.worldBuffMapMarkerTypes = {
				["rend"] = {x = 60.0, y = 79.0, mapID = 1454, icon = "Interface\\Icons\\spell_arcane_teleportorgrimmar", name = L["rend"]},
				["ony"] = {x = 68, y = 79.0, mapID = 1454, icon = "Interface\\Icons\\inv_misc_head_dragon_01", name = L["onyxia"]},
				["nef"] = {x = 76.0, y = 79.0, mapID = 1454, icon = "Interface\\Icons\\inv_misc_head_dragon_black", name = L["nefarian"]},
				--["zanCity"] = {x = 84.0, y = 79.0, mapID = 1454, icon = "Interface\\Icons\\ability_creature_poison_05", name = L["Zandalar"]},
				--["zanStv"] = {x = 11.0, y = 20.5, mapID = 1434, icon = "Interface\\Icons\\ability_creature_poison_05", name = L["Zandalar"]},
			};
		end
	else
		if (NWB.faction == "Alliance") then
			NWB.worldBuffMapMarkerTypes = {
				["rend"] = {x = 74.0, y = 73.0, mapID = 1453, icon = "Interface\\Icons\\spell_arcane_teleportorgrimmar", name = L["rend"]},
				["ony"] = {x = 79.5, y = 73.0, mapID = 1453, icon = "Interface\\Icons\\inv_misc_head_dragon_01", name = L["onyxia"]},
				["nef"] = {x = 85.0, y = 73.0, mapID = 1453, icon = "Interface\\Icons\\inv_misc_head_dragon_black", name = L["nefarian"]},
				--["zanCity"] = {x = 90.5, y = 73.0, mapID = 1453, icon = "Interface\\Icons\\ability_creature_poison_05", name = L["Zandalar"]},
				--["zanStv"] = {x = 11.0, y = 20.5, mapID = 1434, icon = "Interface\\Icons\\ability_creature_poison_05", name = L["Zandalar"]},
			};
		else
			NWB.worldBuffMapMarkerTypes = {
				["rend"] = {x = 59.0, y = 79.0, mapID = 1454, icon = "Interface\\Icons\\spell_arcane_teleportorgrimmar", name = L["rend"]},
				["ony"] = {x = 64.5, y = 79.0, mapID = 1454, icon = "Interface\\Icons\\inv_misc_head_dragon_01", name = L["onyxia"]},
				["nef"] = {x = 70.0, y = 79.0, mapID = 1454, icon = "Interface\\Icons\\inv_misc_head_dragon_black", name = L["nefarian"]},
				--["zanCity"] = {x = 75.5, y = 79.0, mapID = 1454, icon = "Interface\\Icons\\ability_creature_poison_05", name = L["Zandalar"]},
				--["zanStv"] = {x = 11.0, y = 20.5, mapID = 1434, icon = "Interface\\Icons\\ability_creature_poison_05", name = L["Zandalar"]},
			};
		end
	end
end

function NWB:createWorldbuffMarkers()
	if (NWB.isLayered) then
		local count = 0;
		for layer, data in NWB:pairsByKeys(NWB.data.layers) do
			count = count + 1;
			for k, v in pairs(NWB.worldBuffMapMarkerTypes) do
				if (not _G[k .. layer .. "NWBWorldMap"]) then
					NWB:createWorldbuffMarker(k, v, layer, count);
				end
			end
		end
	end
	--Create non layered icons also on layered realms, they are shown when no layers found.
	for k, v in pairs(NWB.worldBuffMapMarkerTypes) do
		NWB:createWorldbuffMarker(k, v);
	end
	NWB:refreshWorldbuffMarkers();
end

local mapMarkers = {};
function NWB:createWorldbuffMarker(type, data, layer, count)
	if (layer) then
		if (not _G[type .. layer .. "NWBWorldMap"]) then
			--Worldmap marker.
			local obj = CreateFrame("Frame", type .. layer .. "NWBWorldMap", WorldMapFrame);
			obj.name = data.name;
			local bg = obj:CreateTexture(nil, "MEDIUM");
			bg:SetTexture(data.icon);
			bg:SetAllPoints(obj);
			obj.texture = bg;
			obj:SetSize(23, 23);
			--Worldmap tooltip.
			obj.tooltip = CreateFrame("Frame", type .. layer .. "WorldMapTooltip", WorldMapFrame, "TooltipBorderedFrameTemplate");
			obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, -46);
			--obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, -26);
			obj.tooltip:SetFrameStrata("TOOLTIP");
			obj.tooltip:SetFrameLevel(9999);
			obj.tooltip.fs = obj.tooltip:CreateFontString(type .. layer .. "NWBWorldMapTooltipFS", "ARTWORK");
			obj.tooltip.fs:SetPoint("CENTER", 0, 0);
			obj.tooltip.fs:SetFont(NWB.regionFont, 14);
			obj.tooltip.fs:SetText("|CffDEDE42" .. data.name);
			obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 18);
			obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 12);
			--obj.tooltip:SetParent(WorldMapFrame); --Make tooltip float on top of other pins.
			obj:SetScript("OnEnter", function(self)
				obj.tooltip:Show();
			end)
			obj:SetScript("OnLeave", function(self)
				obj.tooltip:Hide();
			end)
			obj.tooltip:Hide();
			--Timer frame that sits above the icon when an active timer is found.
			obj.timerFrame = CreateFrame("Frame", type .. layer .. "WorldMapTimerFrame", WorldMapFrame, "TooltipBorderedFrameTemplate");
			obj.timerFrame:SetPoint("CENTER", obj, "CENTER",  0, 21);
			obj.timerFrame:SetFrameStrata("FULLSCREEN");
			obj.timerFrame:SetFrameLevel(9);
			obj.timerFrame.fs = obj.timerFrame:CreateFontString(type .. "NWBWorldMapTimerFrameFS", "ARTWORK");
			obj.timerFrame.fs:SetPoint("CENTER", 0, 0);
			obj.timerFrame.fs:SetFont(NWB.regionFont, 13);
			obj.timerFrame:SetWidth(54);
			obj.timerFrame:SetHeight(24);
			obj:SetScript("OnUpdate", function(self)
				--Update timer when map is open.
				obj.timerFrame.fs:SetText(NWB:updateWorldbuffMarkers(type, layer));
				--Adjust for non-english fonts.
				if (LOCALE_koKR or LOCALE_zhCN or LOCALE_zhTW or LOCALE_ruRU) then
					obj.timerFrame:SetWidth(obj.timerFrame.fs:GetStringWidth() + 18);
					obj.timerFrame:SetHeight(obj.timerFrame.fs:GetStringHeight() + 12);
				end
			end)
			--Make it act like pin is the parent and not WorldMapFrame.
			obj:SetScript("OnHide", function(self)
				obj.timerFrame:Hide();
			end)
			obj:SetScript("OnShow", function(self)
				obj.timerFrame:Show();
			end)
			if (type == "nef" and count == 1) then
				--/buffs text below the city map icons.
				obj.fs = obj:CreateFontString(type .. "NWBWorldMapBuffCmdFS", "ARTWORK");
				obj.fs:SetFont(NWB.regionFont, 14);
				obj.fs:SetText("|CffDEDE42" .. L["worldMapBuffsMsg"]);
				--Layer info text above the city map icons.
				obj.noLayerFrame = CreateFrame("Frame", type.. "WorldMapNoLayerFrame", obj, "TooltipBorderedFrameTemplate");
				obj.noLayerFrame:SetFrameStrata("FULLSCREEN");
				obj.noLayerFrame:SetFrameLevel(9);
				obj.noLayerFrame:SetAlpha(.85);
				obj.noLayerFrame.fs = obj.noLayerFrame:CreateFontString(type .. "NWBWorldMapNoLayerFS", "ARTWORK");
				obj.noLayerFrame.fs:SetPoint("CENTER", 0, 0);
				obj.noLayerFrame.fs:SetFont(NWB.regionFont, 14);
				obj.fs2 = obj:CreateFontString(type .. "NWBWorldMapBuffCmdFS", "ARTWORK");
				obj.fs2:SetFont(NWB.regionFont, 14);
				if (NWB.faction == "Horde") then
					obj.fs:SetPoint("RIGHT", -180, 20);
					obj.noLayerFrame:SetPoint("CENTER", obj, "CENTER",  -255, 70);
					obj.fs2:SetPoint("CENTER", -260, 80);
					obj.noLayerFrame.fs:SetText("|cff9CD6DE" .. L["noLayerYetHorde"]);
				else
					obj.fs:SetPoint("RIGHT", -70, -35);
					obj.noLayerFrame:SetPoint("CENTER", obj, "CENTER",  -195, 20);
					obj.fs2:SetPoint("CENTER", -195, 20);
					obj.noLayerFrame.fs:SetText("|cff9CD6DE" .. L["noLayerYetAlliance"]);
				end
				obj.noLayerFrame:SetWidth(obj.noLayerFrame.fs:GetStringWidth() + 4);
				obj.noLayerFrame:SetHeight(obj.noLayerFrame.fs:GetStringHeight() + 12);
				obj.noLayerFrame:Hide();
			end
			if (type == "ony") then
				--Attach layer text to ony frame.
				obj.fsLayer = obj:CreateFontString(type .. "NWBWorldMapBuffCmdFS", "ARTWORK");
				obj.fsLayer:SetPoint("TOP", 0, 35);
				obj.fsLayer:SetFont(NWB.regionFont, 14);
			end
			obj:SetScript("OnMouseDown", function(self)
				NWB:openBuffListFrame();
			end)
			mapMarkers[type .. layer .. "NWBWorldMap"] = true;
		end
	else
		--Worldmap marker.
		local obj = CreateFrame("Frame", type .. "NWBWorldMap", WorldMapFrame);
		obj.name = data.name;
		local bg = obj:CreateTexture(nil, "MEDIUM");
		bg:SetTexture(data.icon);
		bg:SetAllPoints(obj);
		obj.texture = bg;
		obj:SetSize(23, 23);
		--Worldmap tooltip.
		obj.tooltip = CreateFrame("Frame", type.. "WorldMapTooltip", WorldMapFrame, "TooltipBorderedFrameTemplate");
		obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, -46);
		obj.tooltip:SetFrameStrata("TOOLTIP");
		obj.tooltip:SetFrameLevel(9999);
		obj.tooltip.fs = obj.tooltip:CreateFontString(type .. "NWBWorldMapTooltipFS", "ARTWORK");
		obj.tooltip.fs:SetPoint("CENTER", 0, 0);
		obj.tooltip.fs:SetFont(NWB.regionFont, 14);
		obj.tooltip.fs:SetText("|CffDEDE42" .. data.name);
		obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 18);
		obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 12);
		--obj.tooltip:SetParent(WorldMapFrame); --Make tooltip float on top of other pins.
		obj:SetScript("OnEnter", function(self)
			obj.tooltip:Show();
		end)
		obj:SetScript("OnLeave", function(self)
			obj.tooltip:Hide();
		end)
		obj.tooltip:Hide();
		--Timer frame that sits above the icon when an active timer is found.
		obj.timerFrame = CreateFrame("Frame", type.. "WorldMapTimerFrame", WorldMapFrame, "TooltipBorderedFrameTemplate");
		obj.timerFrame:SetPoint("CENTER", obj, "CENTER",  0, 21);
		obj.timerFrame:SetFrameStrata("FULLSCREEN");
		obj.timerFrame:SetFrameLevel(9);
		obj.timerFrame.fs = obj.timerFrame:CreateFontString(type .. "NWBWorldMapTimerFrameFS", "ARTWORK");
		obj.timerFrame.fs:SetPoint("CENTER", 0, 0);
		obj.timerFrame.fs:SetFont(NWB.regionFont, 13);
		obj.timerFrame:SetWidth(54);
		obj.timerFrame:SetHeight(24);
		obj:SetScript("OnUpdate", function(self)
			--Update timer when map is open.
			obj.timerFrame.fs:SetText(NWB:updateWorldbuffMarkers(type));
			--Adjust for non-english fonts.
			if (LOCALE_koKR or LOCALE_zhCN or LOCALE_zhTW or LOCALE_ruRU) then
				obj.timerFrame:SetWidth(obj.timerFrame.fs:GetStringWidth() + 18);
				obj.timerFrame:SetHeight(obj.timerFrame.fs:GetStringHeight() + 12);
			end
		end)
		--Make it act like pin is the parent and not WorldMapFrame.
		obj:SetScript("OnHide", function(self)
			obj.timerFrame:Hide();
		end)
		obj:SetScript("OnShow", function(self)
			obj.timerFrame:Show();
		end)
		
		if (type == "nef") then
			--/buffs text below the city map icons.
			obj.fs = obj:CreateFontString(type .. "NWBWorldMapBuffCmdFS", "ARTWORK");
			obj.fs:SetPoint("RIGHT", 40, -40);
			obj.fs:SetFont(NWB.regionFont, 14);
			obj.fs:SetText("|CffDEDE42" .. L["worldMapBuffsMsg"]);
			--Layer info text above the city map icons.
			obj.noLayerFrame = CreateFrame("Frame", type.. "WorldMapNoLayerFrame", obj, "TooltipBorderedFrameTemplate");
			obj.noLayerFrame:SetPoint("CENTER", obj, "CENTER",  10, 70);
			obj.noLayerFrame:SetFrameStrata("FULLSCREEN");
			obj.noLayerFrame:SetFrameLevel(9);
			obj.noLayerFrame:SetAlpha(.85);
			obj.noLayerFrame.fs = obj.noLayerFrame:CreateFontString(type .. "NWBWorldMapNoLayerFS", "ARTWORK");
			obj.noLayerFrame.fs:SetPoint("CENTER", 0, 0);
			obj.noLayerFrame.fs:SetFont(NWB.regionFont, 14);
			obj.noLayerFrame:SetWidth(54);
			obj.noLayerFrame:SetHeight(24);
			obj.noLayerFrame:Hide();
			obj.fs2 = obj:CreateFontString(type .. "NWBWorldMapBuffCmdFS", "ARTWORK");
			obj.fs2:SetPoint("CENTER", -10, 60);
			obj.fs2:SetFont(NWB.regionFont, 14);
		end
		obj:SetScript("OnMouseDown", function(self)
			NWB:openBuffListFrame();
		end)
	end
end

function NWB:refreshWorldbuffMarkers()
	if (NWB.isLayered) then
		local count = 0;
		local offset = 0;
		local foundLayers;
		for layer, data in NWB:pairsByKeys(NWB.data.layers) do
			--[[for k, v in pairs(NWB.worldBuffMapMarkerTypes) do
				--if (not NWB.data.layers[layer] and _G[k .. layer .. "NWBWorldMap"]) then
				if (_G[k .. layer .. "NWBWorldMap"]) then
					--Remove all icons first so it fixes any layer changes or data reset after server restart etc.
					NWB.dragonLibPins:RemoveWorldMapIcon(k .. layer .. "NWBWorldMap", _G[k .. layer .. "NWBWorldMap"]);
				end
			end]]
			for k, v in pairs(mapMarkers) do
				--Remove all icons first so it fixes any layer changes or data reset after server restart etc.
				NWB.dragonLibPins:RemoveWorldMapIcon(k, _G[k]);
			end
		end
		for layer, data in NWB:pairsByKeys(NWB.data.layers) do
			foundLayers = true;
			count = count + 1;
			for k, v in pairs(NWB.worldBuffMapMarkerTypes) do
				--Change position to bottom corner of map so they can be stacked on top of each other for layered realms.
				NWB.dragonLibPins:RemoveWorldMapIcon(k .. layer .. "NWBWorldMap", _G[k .. "NWBWorldMap"]);
				if (NWB.db.global.showWorldMapMarkers and _G[k .. layer .. "NWBWorldMap"]) then
					if (NWB.faction == "Horde") then
						NWB.dragonLibPins:AddWorldMapIconMap(k .. layer .. "NWBWorldMap", _G[k .. layer .. "NWBWorldMap"], 
								v.mapID, (v.x + 22) / 100, (v.y + 9 + offset) / 100, HBD_PINS_WORLDMAP_SHOW_PARENT);
					else
						NWB.dragonLibPins:AddWorldMapIconMap(k .. layer .. "NWBWorldMap", _G[k .. layer .. "NWBWorldMap"], 
								v.mapID, (v.x + 8) / 100, (v.y + 15 + offset) / 100, HBD_PINS_WORLDMAP_SHOW_PARENT);
					end
					if (NWB.faction == "Alliance" and k == "rend") then
						if (not NWB.db.global.allianceEnableRend) then
							NWB.dragonLibPins:RemoveWorldMapIcon(k .. layer .. "NWBWorldMap", _G[k .. layer .. "NWBWorldMap"]);
						end
					end
					if (string.match(k, "zan") and not NWB.zand) then
						--Temp debug.
						NWB.dragonLibPins:RemoveWorldMapIcon(k .. "NWBWorldMap", _G[k .. "NWBWorldMap"]);
					end
				end
				if (NWB.faction == "Alliance" and k == "nef" and count == 1 and NWB.db.global.allianceEnableRend
						--These need more adjusting, if layer 1 timers run out I think the new layer 1 won't have the noLayerFrame attached.
						--Maybe I'll remove the count check when creating nef frames and just attach one to all layers nef frame.
						--Anyway it's a kinda rare case issue when the first layer has no timers for over 6 hours.
						and _G[k .. layer .. "NWBWorldMap"].noLayerFrame) then
					_G[k .. layer .. "NWBWorldMap"].noLayerFrame:SetPoint("CENTER", _G[k .. layer .. "NWBWorldMap"], "CENTER",  -245, 20);
					_G[k .. layer .. "NWBWorldMap"].fs2:SetPoint("CENTER", -245, 15);
				elseif (NWB.faction == "Alliance" and k == "nef" and count == 1
						and _G[k .. layer .. "NWBWorldMap"].noLayerFrame) then
					_G[k .. layer .. "NWBWorldMap"].noLayerFrame:SetPoint("CENTER", _G[k .. layer .. "NWBWorldMap"], "CENTER",  -195, 20);
					_G[k .. layer .. "NWBWorldMap"].fs2:SetPoint("CENTER", -195, 20);
				end
			end
			offset = offset - 10;
		end
		--This will add layer icons and remove default non-layer icons when we go from having no timer info to got new layers timer info.
		if (not foundLayers) then
			for k, v in pairs(NWB.worldBuffMapMarkerTypes) do
				NWB.dragonLibPins:RemoveWorldMapIcon(k .. "NWBWorldMap", _G[k .. "NWBWorldMap"]);
				if (NWB.db.global.showWorldMapMarkers and _G[k .. "NWBWorldMap"]) then
					NWB.dragonLibPins:AddWorldMapIconMap(k .. "NWBWorldMap", _G[k .. "NWBWorldMap"], v.mapID,
							v.x / 100, v.y / 100, HBD_PINS_WORLDMAP_SHOW_PARENT);
					if (NWB.faction == "Alliance" and k == "rend") then
						if (not NWB.db.global.allianceEnableRend) then
							NWB.dragonLibPins:RemoveWorldMapIcon(k .. "NWBWorldMap", _G[k .. "NWBWorldMap"]);
						end
					end
					if (string.match(k, "zan") and not NWB.zand) then
						--Temp debug.
						NWB.dragonLibPins:RemoveWorldMapIcon(k .. "NWBWorldMap", _G[k .. "NWBWorldMap"]);
					end
				end
			end
		else
			for k, v in pairs(NWB.worldBuffMapMarkerTypes) do
				NWB.dragonLibPins:RemoveWorldMapIcon(k .. "NWBWorldMap", _G[k .. "NWBWorldMap"]);
			end
		end
	else
		for k, v in pairs(NWB.worldBuffMapMarkerTypes) do
			NWB.dragonLibPins:RemoveWorldMapIcon(k .. "NWBWorldMap", _G[k .. "NWBWorldMap"]);
			if (NWB.db.global.showWorldMapMarkers and _G[k .. "NWBWorldMap"]) then
				NWB.dragonLibPins:AddWorldMapIconMap(k .. "NWBWorldMap", _G[k .. "NWBWorldMap"], v.mapID,
						v.x / 100, v.y / 100, HBD_PINS_WORLDMAP_SHOW_PARENT);
				if (NWB.faction == "Alliance" and k == "rend") then
					if (not NWB.db.global.allianceEnableRend) then
						NWB.dragonLibPins:RemoveWorldMapIcon(k .. "NWBWorldMap", _G[k .. "NWBWorldMap"]);
					end
				end
				if (string.match(k, "zan") and not NWB.zand) then
					--Temp debug.
					NWB.dragonLibPins:RemoveWorldMapIcon(k .. "NWBWorldMap", _G[k .. "NWBWorldMap"]);
				end
			end
		end
	end
end

---=============---
---Darkoon Faire---
---=============---

SLASH_NWBDMFCMD1 = '/dmf';
function SlashCmdList.NWBDMFCMD(msg, editBox)
	if (msg) then
		msg = string.lower(msg);
	end
	if (msg == "map") then
		WorldMapFrame:Show();
		if (NWB.dmfZone == "Mulgore") then
			WorldMapFrame:SetMapID(1412); 
		else
			WorldMapFrame:SetMapID(1429);
		end
		return;
	end
	if (msg == "options" or msg == "option" or msg == "config" or msg == "menu") then
		NWB:openConfig();
		return;
	end
	local output, zone, dmfFound;
	if (NWB.dmfZone == "Mulgore") then
		zone = L["mulgore"];
	else
		zone = L["elwynnForest"];
	end
	output = NWB:getDmfTimeString() .. " (" .. zone .. ")";
	if (output) then
		if (msg ~= nil and msg ~= "") then
			NWB:print(output, msg);
		else
			NWB:print(output);
		end
	end
	
	if (NWB.data.myChars[UnitName("player")].buffs) then
		for k, v in pairs(NWB.data.myChars[UnitName("player")].buffs) do
			--if (v.type == "dmf" and v.timeLeft > 0) then
			if (v.type == "dmf" and (v.timeLeft + 7200) > 0) then
				--output = string.format(L["dmfBuffCooldownMsg"],  NWB:getTimeString(v.timeLeft, true));
				output = string.format(L["dmfBuffCooldownMsg"],  NWB:getTimeString(v.timeLeft + 7200, true));
				dmfFound = true;
				break;
			end
		end
	end
	if (not dmfFound) then
		output = L["dmfBuffReady"];
	end
	if (msg == nil or msg == "") then
		NWB:print(output);
	end
end

function NWB:getDmfTimeString()
	local timestamp, timeLeft, type = NWB:getDmfData();
	local msg, dateString;
	if (timestamp) then
 		if (NWB.db.global.timeStampFormat == 12) then
			dateString = date("%a %b %d", timestamp) .. " " .. gsub(string.lower(date("%I:%M%p", timestamp)), "^0", "");
		else
			dateString = date("%x %X", timestamp);
		end
		dateString = NWB:getTimeFormat(timestamp, true);
		if (type == "start") then
			msg = string.format(L["dmfSpawns"], NWB:getTimeString(timeLeft, true), dateString);
		else
			msg = string.format(L["dmfEnds"],NWB:getTimeString(timeLeft, true), dateString);
		end
		return msg;
	end
end

--DMF spawns the following monday after first friday of the month at daily reset time.
--Whole region shares time of day for spawn (I think).
--Realms within the region possibly don't all spawn at same moment though, realms may wait for their own monday.
--(Bug: US player reported it showing 1 day late DMF end time while on OCE realm, think this whole thing needs rewriting tbh).
function NWB:getDmfStartEnd(month, nextYear)
	local startOffset, endOffset, validRegion, isDst;
	local  minOffset, hourOffset, dayOffset = 0, 0, 0;
	local region = GetCurrentRegion();
	--I may change this to realm names later instead, region may be unreliable with US client on EU region if that issue still exists.
	if (NWB.realm == "Arugal" or NWB.realm == "Felstriker" or NWB.realm == "Remulos" or NWB.realm == "Yojamba") then
		--OCE Sunday 12pm UTC reset time (4am server time).
		dayOffset = 2; --2 days after friday (sunday).
		hourOffset = 18; -- 6pm.
		validRegion = true;
	elseif (NWB.realm == "Arcanite Reaper" or NWB.realm == "Old Blanchy" or NWB.realm == "Anathema" or NWB.realm == "Azuresong"
			or NWB.realm == "Kurinnaxx" or NWB.realm == "Myzrael" or NWB.realm == "Rattlegore" or NWB.realm == "Smolderweb"
			or NWB.realm == "Thunderfury" or NWB.realm == "Atiesh" or NWB.realm == "Bigglesworth" or NWB.realm == "Blaumeux"
			or NWB.realm == "Fairbanks" or NWB.realm == "Grobbulus" or NWB.realm == "Whitemane") then
		--US west Sunday 11am UTC reset time (4am server time).
		dayOffset = 3; --3 days after friday (monday).
		hourOffset = 11; -- 11am.
		validRegion = true;
	elseif (region == 1) then
		--US east + Latin Monday 8am UTC reset time (4am server time).
		dayOffset = 3; --3 days after friday (monday).
		hourOffset = 8; -- 8am.
		validRegion = true;
	elseif (region == 2) then
		--Korea 1am UTC monday (9am monday local) reset time.
		--(TW seems to be region 2 for some reason also? Hopefully they have same DMF spawn).
		--I can change it to server name based if someone from KR says this spawn time is wrong.
		dayOffset = 3;
		hourOffset = 1;
		validRegion = true;
	elseif (region == 3) then
		--EU Monday 4am UTC reset time.
		dayOffset = 3; --3 days after friday (monday).
		hourOffset = 4; -- 4am.
		validRegion = true;
	elseif (region == 4) then
		--Taiwan 1am UTC monday (9am monday local) reset time.
		dayOffset = 3;
		hourOffset = 1;
		validRegion = true;
	elseif (region == 5) then
		--China 8pm UTC sunday (4am monday local) reset time.
		dayOffset = 2;
		hourOffset = 20;
		validRegion = true;
	end
	--Create current UTC date table.
	local data = date("!*t", GetServerTime());
	--If month is specified then use that month instead (next dmf spawn is next month);
	if (month) then
		data.month = month;
	end
	--If nextYear is true then next dmf spawn is next year (we're in december right now).
	if (nextYear) then
		data.year = data.year + 1;
	end
	local dmfStartDay;
	for i = 1, 7 do
		--Iterate the first 7 days in the month to find first friday.
		local time = date("!*t", time({year = data.year, month = data.month, day = i}));
		if (time.wday == 6) then
			--If day of the week (wday) is 6 (friday) then set this as first friday of the month.
			dmfStartDay = i;
		end
	end
	local timeTable = {year = data.year, month = data.month, day = dmfStartDay + dayOffset, hour = hourOffset, min = minOffset, sec = 0};
	local utcdate   = date("!*t", GetServerTime());
	local localdate = date("*t", GetServerTime());
	localdate.isdst = false;
	local secondsDiff = difftime(time(utcdate), time(localdate));
	local dmfStart = time(timeTable) - secondsDiff;
	if (date("%w", dmfStart) == "0") then
		--Not sure if whole region spawns at the same moment or if each realm waits for their own monday.
		--All realms spawn same time of day, but possibly not same UTC day depending on timezone.
		--Just incase each realm waits for monday we can add a day here.
		dmfStart = dmfStart + 86400;
	end
	--Add 7 days to get end timestamp.
	local dmfEnd = dmfStart + 604800;
	--Only return if we have set daily reset offsets for this region.
	if (validRegion) then
		return dmfStart, dmfEnd;
	end
end

function NWB:getDmfData()
	local dmfStart, dmfEnd = NWB:getDmfStartEnd();
	local timestamp, timeLeft, type;
	--local locale = GetLocale();
	--OCE region only just for now.
	if (dmfStart and dmfEnd) then
		if (GetServerTime() < dmfStart) then
			--It's before the start of dmf.
			timestamp = dmfStart;
			type = "start";
			timeLeft = dmfStart - GetServerTime();
			NWB.isDmfUp = nil;
		elseif (GetServerTime() < dmfEnd) then
			--It's after dmf started and before the end.
			timestamp = dmfEnd;
			type = "end";
			timeLeft = dmfEnd - GetServerTime();
			NWB.isDmfUp = true;
		elseif (GetServerTime() > dmfEnd) then
			--It's after dmf ended so calc next months dmf instead.
			local data = date("!*t", GetServerTime());
			if (data.month == 12) then
				dmfStart, dmfEnd = NWB:getDmfStartEnd(1, true);
			else
				dmfStart, dmfEnd = NWB:getDmfStartEnd(data.month + 1);
			end
			timestamp = dmfStart;
			type = "start";
			timeLeft = dmfStart - GetServerTime();
			NWB.isDmfUp = nil;
		end
		local zone;
		if (date("%m", dmfStart) % 2 == 0) then
    		zone = "Mulgore";
		else
    		zone = "Elwynn Forest";
		end
		NWB.dmfZone = zone;
		--Timestamp of next start or end event, seconds left untill that event, and type of event.
		return timestamp, timeLeft, type;
	end
end

function NWB:updateDmfMarkers(type)
	local timestamp, timeLeft, type = NWB:getDmfData();
	local text = "";
	if (not timestamp or timestamp < 1) then
		text = text .. L["noTimer"];
	else
		if (type == "start") then
			text = text .. string.format(L["startsIn"], NWB:getTimeString(timeLeft, true, "short"));
		else
			text = text .. string.format(L["endsIn"], NWB:getTimeString(timeLeft, true, "short"));
		end
	end
	if (timeLeft > 0) then
		local tooltipText = "|Cff00ff00" .. L["Darkmoon Faire"] .. "|CffDEDE42\n";
		if (type == "start") then
			tooltipText = tooltipText .. string.format(L["startsIn"], NWB:getTimeString(timeLeft, true)) .. "\n";
		else
			tooltipText = tooltipText .. string.format(L["endsIn"], NWB:getTimeString(timeLeft, true)) .. "\n";
		end
    	tooltipText = tooltipText .. NWB:getTimeFormat(timestamp, true);
    	local dmfFound;
    	local buffText = "";
    	if (NWB.isDmfUp) then
    		if (NWB.data.myChars[UnitName("player")].buffs) then
				for k, v in pairs(NWB.data.myChars[UnitName("player")].buffs) do
					if (v.type == "dmf" and (v.timeLeft + 7200) > 0) then
						buffText = "\n" .. string.format(L["dmfBuffCooldownMsg"],  NWB:getTimeString((v.timeLeft + 7200), true));
						dmfFound = true;
						break;
					end
				end
			end
    		if (not dmfFound) then
    			buffText = "\n" .. L["dmfBuffReady"];
    		end
    	end
    	tooltipText = tooltipText .. buffText;
    	_G["NWBDMF"].tooltip.fs:SetText(tooltipText);
    	_G["NWBDMF"].tooltip:SetWidth(_G["NWBDMF"].tooltip.fs:GetStringWidth() + 18);
		_G["NWBDMF"].tooltip:SetHeight(_G["NWBDMF"].tooltip.fs:GetStringHeight() + 12);
		_G["NWBDMFContinent"].tooltip.fs:SetText(tooltipText);
    	_G["NWBDMFContinent"].tooltip:SetWidth(_G["NWBDMFContinent"].tooltip.fs:GetStringWidth() + 12);
		_G["NWBDMFContinent"].tooltip:SetHeight(_G["NWBDMFContinent"].tooltip.fs:GetStringHeight() + 12);
  	end
	return text;
end

function NWB:createDmfMarkers()
	--Darkmoon Faire zone map marker.
	local icon = "Interface\\AddOns\\NovaWorldBuffs\\Media\\dmf";
	local obj = CreateFrame("Frame", "NWBDMF", WorldMapFrame);
	local bg = obj:CreateTexture(nil, "MEDIUM");
	bg:SetTexture(icon);
	bg:SetAllPoints(obj);
	obj.texture = bg;
	obj:SetSize(23, 23);
	--Worldmap tooltip.
	obj.tooltip = CreateFrame("Frame", "NWBDMFTooltip", WorldMapFrame, "TooltipBorderedFrameTemplate");
	obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, 46);
	obj.tooltip:SetFrameStrata("TOOLTIP");
	obj.tooltip:SetFrameLevel(9);
	obj.tooltip.fs = obj.tooltip:CreateFontString("NWBDMFTooltipFS", "ARTWORK");
	obj.tooltip.fs:SetPoint("CENTER", 0, 0);
	obj.tooltip.fs:SetFont(NWB.regionFont, 14);
	obj.tooltip.fs:SetText(L["|Cff00ff00Darkmoon Faire"]);
	obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 18);
	obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 12);
	obj:SetScript("OnEnter", function(self)
		obj.tooltip:Show();
	end)
	obj:SetScript("OnLeave", function(self)
		obj.tooltip:Hide();
	end)
	obj.tooltip:Hide();
	--Timer frame that sits above the icon when an active timer is found.
	obj.timerFrame = CreateFrame("Frame", "NWBDMFTimerFrame", WorldMapFrame, "TooltipBorderedFrameTemplate");
	obj.timerFrame:SetPoint("CENTER", obj, "CENTER", 0, -21);
	obj.timerFrame:SetFrameStrata("FULLSCREEN");
	obj.timerFrame:SetFrameLevel(9);
	obj.timerFrame.fs = obj.timerFrame:CreateFontString("NWBDMFTimerFrameFS", "ARTWORK");
	obj.timerFrame.fs:SetPoint("CENTER", 0, 0);
	obj.timerFrame.fs:SetFont(NWB.regionFont, 13);
	obj.timerFrame:SetWidth(54);
	obj.timerFrame:SetHeight(24);
	obj:SetScript("OnUpdate", function(self)
		--Update timer when map is open.
		obj.timerFrame.fs:SetText(NWB:updateDmfMarkers());
		obj.timerFrame:SetWidth(obj.timerFrame.fs:GetStringWidth() + 10);
		obj.timerFrame:SetHeight(obj.timerFrame.fs:GetStringHeight() + 10);
	end)
	--Make it act like pin is the parent and not WorldMapFrame.
	obj:SetScript("OnHide", function(self)
		obj.timerFrame:Hide();
	end)
	obj:SetScript("OnShow", function(self)
		obj.timerFrame:Show();
	end)
	obj:SetScript("OnMouseDown", function(self)
		NWB:openBuffListFrame();
	end)
	
	--Darkmoon Faire continent marker.
	local obj = CreateFrame("Frame", "NWBDMFContinent", WorldMapFrame);
	local bg = obj:CreateTexture(nil, "MEDIUM");
	bg:SetTexture(icon);
	bg:SetAllPoints(obj);
	obj.texture = bg;
	obj:SetSize(14, 14);
	obj:SetFrameStrata("High");
	obj:SetFrameLevel(9);
	--Worldmap tooltip.
	obj.tooltip = CreateFrame("Frame", "NWBDMFContinentTooltip", WorldMapFrame, "TooltipBorderedFrameTemplate");
	obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, 46);
	obj.tooltip:SetFrameStrata("TOOLTIP");
	obj.tooltip:SetFrameLevel(9);
	obj.tooltip.fs = obj.tooltip:CreateFontString("NWBDMFContinentTooltipFS", "HIGH");
	obj.tooltip.fs:SetPoint("CENTER", 0, 0);
	obj.tooltip.fs:SetFont(NWB.regionFont, 14);
	obj.tooltip.fs:SetText(L["|Cff00ff00Darkmoon Faire"]);
	obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 18);
	obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 12);
	obj:SetScript("OnEnter", function(self)
		obj.tooltip:Show(); --5:34 2h4m
	end)
	obj:SetScript("OnLeave", function(self)
		obj.tooltip:Hide();
	end)
	obj.tooltip:Hide();
	obj:SetScript("OnUpdate", function(self)
		--Updatetooltip  timer when map is open.
		NWB:updateDmfMarkers();
	end)
	obj:SetScript("OnMouseDown", function(self)
		NWB:openBuffListFrame();
	end)
	NWB:refreshDmfMarkers();
end

function NWB:refreshDmfMarkers()
	local x, y, mapID, worldX, worldY, worldMapID;
	if (NWB.dmfZone == "Mulgore") then
		x, y, mapID = 36.8, 37.6, 1412;
		worldX, worldY, worldMapID = 46, 63, 1414;
	else
		x, y, mapID = 42, 70, 1429;
		worldX, worldY, worldMapID = 45.7, 71.4, 1415;
	end
	NWB.dragonLibPins:RemoveWorldMapIcon("NWBDMF", _G["NWBDMF"]);
	if (NWB.db.global.showDmfMap) then
		NWB.dragonLibPins:AddWorldMapIconMap("NWBDMF", _G["NWBDMF"], mapID, x/100, y/100, HBD_PINS_WORLDMAP_SHOW_PARENT);
		NWB.dragonLibPins:AddWorldMapIconMap("NWBDMFContinent", _G["NWBDMFContinent"], worldMapID, worldX/100, worldY/100, HBD_PINS_WORLDMAP_SHOW_WORLD, "TOOLTIP");
	end
end

WorldMapFrame:HookScript("OnShow", function()
	NWB:refreshDmfMarkers();
	NWB:refreshWorldbuffMarkers();
end)

function NWB:fixMapMarkers()
	--Fix a bug with tooltips not showing first time opening the map.
	--Running this twice taints the blizzard raid frames (wtf?)
	--WorldMapFrame:Show();
	--WorldMapFrame:SetMapID(1448);
	--WorldMapFrame:Hide();
end

---===================---
---Buff tracking frame---
---===================---

local NWBbuffListFrame = CreateFrame("ScrollFrame", "NWBbuffListFrame", UIParent, "InputScrollFrameTemplate");
NWBbuffListFrame:Hide();
NWBbuffListFrame:SetToplevel(true);
NWBbuffListFrame:SetMovable(true);
NWBbuffListFrame:EnableMouse(true);
tinsert(UISpecialFrames, "NWBbuffListFrame");
NWBbuffListFrame:SetPoint("CENTER", UIParent, 20, 120);
NWBbuffListFrame:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8",insets = {top = 0, left = 0, bottom = 0, right = 0}});
NWBbuffListFrame:SetBackdropColor(0,0,0,.6);
NWBbuffListFrame.CharCount:Hide();
--NWBbuffListFrame:SetFrameLevel(128);
NWBbuffListFrame:SetFrameStrata("MEDIUM");
NWBbuffListFrame.EditBox:SetAutoFocus(false);
NWBbuffListFrame.EditBox:SetScript("OnKeyDown", function(self, arg)
	--If control key is down keep focus for copy/paste to work.
	--Otherwise remove focus so "enter" can be used to open chat and not have a stuck cursor on this edit box.
	if (not IsControlKeyDown()) then
		NWBbuffListFrame.EditBox:ClearFocus();
	end
end)
NWBbuffListFrame.EditBox:SetScript("OnShow", function(self, arg)
	NWBbuffListFrame:SetVerticalScroll(0);
end)
local buffUpdateTime = 0;
NWBbuffListFrame:HookScript("OnUpdate", function(self, arg)
	--Only update once per second.
	if (GetServerTime() - buffUpdateTime > 0 and self:GetVerticalScrollRange() == 0) then
		NWB:recalcBuffListFrame();
		buffUpdateTime = GetServerTime();
	end
end)
NWBbuffListFrame.fs = NWBbuffListFrame.EditBox:CreateFontString("NWBbuffListFrameFS", "HIGH");
NWBbuffListFrame.fs:SetPoint("TOP", 0, 0);
NWBbuffListFrame.fs:SetFont(NWB.regionFont, 14);
NWBbuffListFrame.fs:SetText("|cffffff00" .. L["Your Current World Buffs"]);

local NWBbuffListDragFrame = CreateFrame("Frame", "NWBbuffListDragFrame", NWBbuffListFrame);
--NWBbuffListDragFrame:SetToplevel(true);
NWBbuffListDragFrame:EnableMouse(true);
NWBbuffListDragFrame:SetWidth(205);
NWBbuffListDragFrame:SetHeight(38);
NWBbuffListDragFrame:SetPoint("TOP", 0, 4);
NWBbuffListDragFrame:SetFrameLevel(131);
NWBbuffListDragFrame.tooltip = CreateFrame("Frame", "NWBbuffListDragTooltip", NWBbuffListDragFrame, "TooltipBorderedFrameTemplate");
NWBbuffListDragFrame.tooltip:SetPoint("CENTER", NWBbuffListDragFrame, "TOP", 0, 12);
NWBbuffListDragFrame.tooltip:SetFrameStrata("TOOLTIP");
NWBbuffListDragFrame.tooltip:SetFrameLevel(9);
NWBbuffListDragFrame.tooltip:SetAlpha(.8);
NWBbuffListDragFrame.tooltip.fs = NWBbuffListDragFrame.tooltip:CreateFontString("NWBbuffListDragTooltipFS", "HIGH");
NWBbuffListDragFrame.tooltip.fs:SetPoint("CENTER", 0, 0.5);
NWBbuffListDragFrame.tooltip.fs:SetFont(NWB.regionFont, 12);
NWBbuffListDragFrame.tooltip.fs:SetText(L["Hold to drag"]);
NWBbuffListDragFrame.tooltip:SetWidth(NWBbuffListDragFrame.tooltip.fs:GetStringWidth() + 16);
NWBbuffListDragFrame.tooltip:SetHeight(NWBbuffListDragFrame.tooltip.fs:GetStringHeight() + 10);
NWBbuffListDragFrame:SetScript("OnEnter", function(self)
	NWBbuffListDragFrame.tooltip:Show();
end)
NWBbuffListDragFrame:SetScript("OnLeave", function(self)
	NWBbuffListDragFrame.tooltip:Hide();
end)
NWBbuffListDragFrame.tooltip:Hide();
NWBbuffListDragFrame:SetScript("OnMouseDown", function(self, button)
	if (button == "LeftButton" and not self:GetParent().isMoving) then
		self:GetParent().EditBox:ClearFocus();
		self:GetParent():StartMoving();
		self:GetParent().isMoving = true;
		--self:GetParent():SetUserPlaced(false);
	end
end)
NWBbuffListDragFrame:SetScript("OnMouseUp", function(self, button)
	if (button == "LeftButton" and self:GetParent().isMoving) then
		self:GetParent():StopMovingOrSizing();
		self:GetParent().isMoving = false;
	end
end)
NWBbuffListDragFrame:SetScript("OnHide", function(self)
	if (self:GetParent().isMoving) then
		self:GetParent():StopMovingOrSizing();
		self:GetParent().isMoving = false;
	end
end)

--Top right X close button.
local NWBbuffListFrameClose = CreateFrame("Button", "NWBbuffListFrameClose", NWBbuffListFrame, "UIPanelCloseButton");
NWBbuffListFrameClose:SetPoint("TOPRIGHT", -5, 8.6);
NWBbuffListFrameClose:SetWidth(31);
NWBbuffListFrameClose:SetHeight(31);
NWBbuffListFrameClose:SetScript("OnClick", function(self, arg)
	NWBbuffListFrame:Hide();
end)

--Config button.
local NWBbuffListFrameConfButton = CreateFrame("Button", "NWBbuffListFrameConfButton", NWBbuffListFrameClose, "UIPanelButtonTemplate");
NWBbuffListFrameConfButton:SetPoint("CENTER", -58, 1);
NWBbuffListFrameConfButton:SetWidth(90);
NWBbuffListFrameConfButton:SetHeight(17);
NWBbuffListFrameConfButton:SetText(L["Options"]);
NWBbuffListFrameConfButton:SetNormalFontObject("GameFontNormalSmall");
NWBbuffListFrameConfButton:SetScript("OnClick", function(self, arg)
	NWB:openConfig();
end)
NWBbuffListFrameConfButton:SetScript("OnMouseDown", function(self, button)
	if (button == "LeftButton" and not self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent().EditBox:ClearFocus();
		self:GetParent():GetParent():StartMoving();
		self:GetParent():GetParent().isMoving = true;
	end
end)
NWBbuffListFrameConfButton:SetScript("OnMouseUp", function(self, button)
	if (button == "LeftButton" and self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent():StopMovingOrSizing();
		self:GetParent():GetParent().isMoving = false;
	end
end)
NWBbuffListFrameConfButton:SetScript("OnHide", function(self)
	if (self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent():StopMovingOrSizing();
		self:GetParent():GetParent().isMoving = false;
	end
end)

local NWBbufflistFrameTimersButton = CreateFrame("Button", "NWBbufflistFrameTimersButton", NWBbuffListFrameClose, "UIPanelButtonTemplate");
NWBbufflistFrameTimersButton:SetPoint("CENTER", -58, -13);
NWBbufflistFrameTimersButton:SetWidth(90);
NWBbufflistFrameTimersButton:SetHeight(17);
NWBbufflistFrameTimersButton:SetText(L["Timers"]);
NWBbufflistFrameTimersButton:SetNormalFontObject("GameFontNormalSmall");
NWBbufflistFrameTimersButton:SetScript("OnClick", function(self, arg)
	NWB:openLayerFrame();
end)
NWBbufflistFrameTimersButton:SetScript("OnMouseDown", function(self, button)
	if (button == "LeftButton" and not self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent().EditBox:ClearFocus();
		self:GetParent():GetParent():StartMoving();
		self:GetParent():GetParent().isMoving = true;
	end
end)
NWBbufflistFrameTimersButton:SetScript("OnMouseUp", function(self, button)
	if (button == "LeftButton" and self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent():StopMovingOrSizing();
		self:GetParent():GetParent().isMoving = false;
	end
end)
NWBbufflistFrameTimersButton:SetScript("OnHide", function(self)
	if (self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent():StopMovingOrSizing();
		self:GetParent():GetParent().isMoving = false;
	end
end)
NWBbufflistFrameTimersButton:Hide();

--Wipe data button.
local NWBbuffListFrameWipeButton = CreateFrame("Button", "NWBbuffListFrameWipeButton", NWBbuffListFrame, "UIPanelButtonTemplate");
NWBbuffListFrameWipeButton:SetPoint("BOTTOMRIGHT", -34, -1);
NWBbuffListFrameWipeButton:SetWidth(90);
NWBbuffListFrameWipeButton:SetHeight(17);
NWBbuffListFrameWipeButton:SetFrameLevel(3);
NWBbuffListFrameWipeButton:SetText(L["Reset Data"]);
NWBbuffListFrameWipeButton:SetNormalFontObject("GameFontNormalSmall");
NWBbuffListFrameWipeButton:SetScript("OnClick", function(self, arg)
	NWB:resetBuffData();
end)
NWBbuffListFrameWipeButton.tooltip = CreateFrame("Frame", "NWBbuffListResetButtonTooltip", NWBbuffListFrameWipeButton, "TooltipBorderedFrameTemplate");
NWBbuffListFrameWipeButton.tooltip:SetPoint("CENTER", NWBbuffListFrameWipeButton, "TOP", 0, 14);
NWBbuffListFrameWipeButton.tooltip.fs = NWBbuffListFrameWipeButton.tooltip:CreateFontString("NWBbuffListDragTooltipFS", "HIGH");
NWBbuffListFrameWipeButton.tooltip.fs:SetPoint("CENTER", 0, 0.5);
NWBbuffListFrameWipeButton.tooltip.fs:SetFont(NWB.regionFont, 12);
NWBbuffListFrameWipeButton.tooltip.fs:SetText("|cFFFFFF00" .. L["buffResetButtonTooltip"]);
NWBbuffListFrameWipeButton.tooltip:SetWidth(NWBbuffListFrameWipeButton.tooltip.fs:GetStringWidth() + 16);
NWBbuffListFrameWipeButton.tooltip:SetHeight(NWBbuffListFrameWipeButton.tooltip.fs:GetStringHeight() + 10);
NWBbuffListFrameWipeButton:SetScript("OnEnter", function(self)
	NWBbuffListFrameWipeButton.tooltip:Show();
end)
NWBbuffListFrameWipeButton:SetScript("OnLeave", function(self)
	NWBbuffListFrameWipeButton.tooltip:Hide();
end)
NWBbuffListFrameWipeButton.tooltip:Hide();

function NWB:openBuffListFrame()
	NWBbuffListFrame.fs:SetFont(NWB.regionFont, 14);
	if (NWBbuffListFrame:IsShown()) then
		NWBbuffListFrame:Hide();
	else
		if (NWB.isLayered) then
			NWBbufflistFrameTimersButton:Show();
		end
		NWB:syncBuffsWithCurrentDuration();
		NWBbuffListFrame:SetHeight(300);
		if (NWB.db.global.showBuffStats) then
			--A little wider to fit the buff count.
			NWBbuffListFrame:SetWidth(475);
		else
			NWBbuffListFrame:SetWidth(450);
		end
		local fontSize = false
		NWBbuffListFrame.EditBox:SetFont(NWB.regionFont, 14);
		NWB:recalcBuffListFrame();
		NWBbuffListFrame.EditBox:SetWidth(NWBbuffListFrame:GetWidth() - 30);
		NWBbuffListFrame:Show();
		--Changing scroll position requires a slight delay.
		--Second delay is a backup.
		C_Timer.After(0.05, function()
			NWBbuffListFrame:SetVerticalScroll(0);
		end)
		C_Timer.After(0.3, function()
			NWBbuffListFrame:SetVerticalScroll(0);
		end)
		--So interface options and this frame will open on top of each other.
		if (InterfaceOptionsFrame:IsShown()) then
			NWBbuffListFrame:SetFrameStrata("DIALOG")
		else
			NWBbuffListFrame:SetFrameStrata("HIGH")
		end
	end
end

function NWB:recalcBuffListFrame()
	--local scroll = NWBbuffListFrame:GetVerticalScroll();
	if (NWB.db.global.showBuffStats) then
		--A little wider to fit the buff count.
		NWBbuffListFrame:SetWidth(475);
	else
		NWBbuffListFrame:SetWidth(450);
	end
	if (NWB.isDmfUp) then
		local buffText, dmfFound;
		if (NWB.data.myChars[UnitName("player")].buffs) then
			for k, v in pairs(NWB.data.myChars[UnitName("player")].buffs) do
				if (v.type == "dmf" and (v.timeLeft + 7200) > 0) then
					buffText = string.format(L["dmfBuffCooldownMsg2"],  NWB:getTimeString(v.timeLeft + 7200, true))
							.. "\n" .. L["dmfBuffCooldownMsg3"];
					dmfFound = true;
					break;
				end
			end
		end
    	if (not dmfFound) then
    		buffText = L["dmfBuffReady"];
    	end
		NWBbuffListFrame.EditBox:SetText("\n" .. buffText .. "\n");
	else
		NWBbuffListFrame.EditBox:SetText("\n\n");
	end
	local count = 0;
	local foundChars;
	for k, v in NWB:pairsByKeys(NWB.db.global) do --Iterate realms.
		local msg = "";
		if (type(v) == "table" and k ~= "minimapIcon") then --The only tables in db.global are realm names.
			local realm = k;
			for k, v in NWB:pairsByKeys(v) do --Iterate factions.
				local msg2 = "";
				local coloredFaction = "";
				--if (k == "Horde") then
				--	coloredFaction = "|cffe50c11" .. k .. "|r";
				--else
				--	coloredFaction = "|cff4954e8" .. k .. "|r";
				--end
				msg2 = "|cff00ff00[" .. realm .. "]|r\n";
				--Have to check if the myChars table exists here.
				--There was a lua error when much older versions upgraded to the buff tracking version.
				--They had realmdata in thier db file without the myChars table and it won't create it until they log on that realm.
				local foundAnyBuff;
				if (v.myChars) then
					local foundActiveBuff;
					for k, v in NWB:pairsByKeys(v.myChars) do --Iterate characters.
						foundActiveBuff = nil;
						local msg3 = "";
						local _, _, _, classColor = GetClassColor(v.englishClass);
						msg3 = msg3 .. "  -|c" .. classColor .. k .. "|r\n";
						local charName = k;
						for k, v in NWB:pairsByKeys(v.buffs) do --Iterate buffs.
							if (v.track and v.timeLeft > 0) then
								local icon = "";
								if (v.type == "rend") then
									icon = "|TInterface\\Icons\\spell_arcane_teleportorgrimmar:12:12:0:0|t";
								elseif (v.type == "ony") then
									icon = "|TInterface\\Icons\\inv_misc_head_dragon_01:12:12:0:0|t";
								elseif (v.type == "nef") then
									icon = "|TInterface\\Icons\\inv_misc_head_dragon_01:12:12:0:0|t";
								elseif (v.type == "dmf") then
									icon = "|TInterface\\Icons\\inv_misc_orb_02:12:12:0:0|t";
								elseif (v.type == "zan") then
									icon = "|TInterface\\Icons\\ability_creature_poison_05:12:12:0:0|t";
								elseif (v.type == "moxie") then
									icon = "|TInterface\\Icons\\spell_nature_massteleport:12:12:0:0|t";
								elseif (v.type == "ferocity") then
									icon = "|TInterface\\Icons\\spell_nature_undyingstrength:12:12:0:0|t";
								elseif (v.type == "savvy") then
									icon = "|TInterface\\Icons\\spell_holy_lesserheal02:12:12:0:0|t";
								elseif (v.type == "flaskPower") then
									icon = "|TInterface\\Icons\\inv_potion_41:12:12:0:0|t";
								elseif (v.type == "flaskTitans") then
									icon = "|TInterface\\Icons\\inv_potion_62:12:12:0:0|t";
								elseif (v.type == "flaskWisdom") then
									icon = "|TInterface\\Icons\\inv_potion_97:12:12:0:0|t";
								elseif (v.type == "flaskResistance") then
									icon = "|TInterface\\Icons\\inv_potion_48:12:12:0:0|t";
								elseif (v.type == "songflower") then
									icon = "|TInterface\\Icons\\spell_holy_mindvision:12:12:0:0|t";
								elseif (v.type == "resistFire") then
									icon = "|TInterface\\Icons\\spell_fire_firearmor:12:12:0:0|t";
								elseif (v.type == "blackfathom") then
									icon = "|TInterface\\Icons\\spell_frost_frostward:12:12:0:0|t";
								elseif (v.type == "festivalFortitude") then
									icon = "|TInterface\\Icons\\inv_summerfest_firespirit:12:12:0:0|t";
								elseif (v.type == "festivalFury") then
									icon = "|TInterface\\Icons\\inv_misc_summerfest_brazierorange:12:12:0:0|t";
								elseif (v.type == "ribbonDance") then
									icon = "|TInterface\\Icons\\inv_summerfest_symbol_medium:12:12:0:0|t";
								elseif (v.type == "silithyst") then
									icon = "|TInterface\\Icons\\spell_nature_timestop:12:12:0:0|t";
								end
								local buffName = k;
								if (k == "Supreme Power") then
									buffName = "Flask of Supreme Power";
								elseif (k == "Distilled Wisdom") then
									buffName = "Flask of Distilled Wisdom";
								end
								msg3 = msg3 .. "        " .. icon .. " |cFFFFAE42" .. buffName .. "  ";
								if (NWB.db.global.showBuffStats and NWB.data.myChars[charName]
										and NWB.data.myChars[charName][v.type .. "Count"] and NWB.data.myChars[charName][v.type .. "Count"] > 0) then
									msg3 = msg3 .. "|cFF9CD6DE" .. NWB:getTimeString(v.timeLeft, true) .. "|r";
									local buffCount = NWB.data.myChars[charName][v.type .. "Count"];
									if (v.type == "ony" or v.type == "nef") then
										--If ony or nef then add them together, same buff.
										local onyBuffCount, nefBuffCount = 0, 0;
										if (NWB.data.myChars[charName]["onyCount"]) then
											onyBuffCount = NWB.data.myChars[charName]["onyCount"];
										end
										if (NWB.data.myChars[charName]["nefCount"]) then
											nefBuffCount = NWB.data.myChars[charName]["nefCount"];
										end
										buffCount = onyBuffCount + nefBuffCount;
									end
									if (buffCount == 1) then
										msg3 = msg3 .. " |cFFA0A0A0(" .. buffCount .. " " .. L["time"] .. ")|r|cFF9CD6DE.|r\n";
									else
										msg3 = msg3 .. " |cFFA0A0A0(" .. buffCount .. " " .. L["times"] .. ")|r|cFF9CD6DE.|r\n";
									end
								else
									msg3 = msg3 .. "|cFF9CD6DE" .. NWB:getTimeString(v.timeLeft, true) .. ".|r\n";
								end
								foundActiveBuff = true;
							end
						end
						if (NWB.db.global.showAllAlts or foundActiveBuff) then
						 	msg2 = msg2 .. msg3;
						 	foundChars = true;
						 	foundAnyBuff = true;
						end
					end
					if (NWB.db.global.showAllAlts or foundAnyBuff) then
						 msg = msg .. msg2;
						 foundChars = true;
					end
				end
			end
		end
		NWBbuffListFrame.EditBox:Insert(msg);
	end
	if (not foundChars) then
		NWBbuffListFrame.EditBox:Insert(L["|cffffff00No characters with buffs found."]);
	end
	--NWBbuffListFrame:SetVerticalScroll(scroll);
end

--Reset data if name changes, server xfer etc.
function NWB:resetBuffData()
	for k, v in NWB:pairsByKeys(NWB.db.global) do --Iterate realms.
		local msg = "";
		if (type(v) == "table" and k ~= "minimapIcon") then --The only tables in db.global are realm names.
			local realm = k;
			for k, v in NWB:pairsByKeys(v) do --Iterate factions.
				local f = k;
				if (v.myChars) then
					for k, v in NWB:pairsByKeys(v.myChars) do --Iterate characters.
						NWB.db.global[realm][f].myChars[k].buffs = {};
					end
				end
			end
		end
	end
	NWB:print(L["Buff records have been reset."]);
	C_Timer.After(3, function()
		NWB:syncBuffsWithCurrentDuration();
	end)
end

SLASH_NWBDMFBUFFSCMD1, SLASH_NWBDMFBUFFSCMD2 = '/buff', '/buffs';
function SlashCmdList.NWBDMFBUFFSCMD(msg, editBox)
	NWB:openBuffListFrame();
end

---====================---
---Layer tracking frame---
---====================---

--This is actually the timers frame, it was orginally only used on layered servers hence the name.
local NWBlayerFrame = CreateFrame("ScrollFrame", "NWBlayerFrame", UIParent, "InputScrollFrameTemplate");
NWBlayerFrame:Hide();
NWBlayerFrame:SetToplevel(true);
NWBlayerFrame:SetMovable(true);
NWBlayerFrame:EnableMouse(true);
tinsert(UISpecialFrames, "NWBlayerFrame");
NWBlayerFrame:SetPoint("CENTER", UIParent, 0, 100);
NWBlayerFrame:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8",insets = {top = 0, left = 0, bottom = 0, right = 0}});
NWBlayerFrame:SetBackdropColor(0,0,0,.5);
NWBlayerFrame.CharCount:Hide();
NWBlayerFrame:SetFrameStrata("HIGH");
NWBlayerFrame.EditBox:SetAutoFocus(false);
NWBlayerFrame.EditBox:SetScript("OnKeyDown", function(self, arg)
	--If control key is down keep focus for copy/paste to work.
	--Otherwise remove focus so "enter" can be used to open chat and not have a stuck cursor on this edit box.
	if (not IsControlKeyDown()) then
		NWBlayerFrame.EditBox:ClearFocus();
	end
end)
NWBlayerFrame.EditBox:SetScript("OnShow", function(self, arg)
	NWBlayerFrame:SetVerticalScroll(0);
end)
local layerFrameUpdateTime = 0;
NWBlayerFrame:HookScript("OnUpdate", function(self, arg)
	--Only update once per second.
	if (GetServerTime() - layerFrameUpdateTime > 0 and self:GetVerticalScrollRange() == 0) then
		NWB:recalclayerFrame();
		layerFrameUpdateTime = GetServerTime();
	end
end)
NWBlayerFrame.fs = NWBlayerFrame.EditBox:CreateFontString("NWBlayerFrameFS", "HIGH");
NWBlayerFrame.fs:SetPoint("TOP", 0, -0);
NWBlayerFrame.fs:SetFont(NWB.regionFont, 14);
NWBlayerFrame.fs:SetText(NWB.prefixColor .. "NovaWorldBuffs v" .. version .. "|r");
NWBlayerFrame.fs2 = NWBlayerFrame.EditBox:CreateFontString("NWBlayerFrameFS", "HIGH");
NWBlayerFrame.fs2:SetPoint("TOPLEFT", 0, -14);
NWBlayerFrame.fs2:SetFont(NWB.regionFont, 14);
NWBlayerFrame.fs2:SetText(L["|cFF9CD6DETarget any NPC to see your current layer.|r"]);
NWBlayerFrame.fs3 = NWBlayerFrame:CreateFontString("NWBbuffListFrameFS", "HIGH");
--NWBlayerFrame.fs3 = NWBlayerFrame.EditBox:CreateFontString("NWBbuffListFrameFS", "HIGH");
NWBlayerFrame.fs3:SetPoint("BOTTOM", 0, 2);
NWBlayerFrame.fs3:SetFont(NWB.regionFont, 14);
NWBlayerFrame.fs3:SetText("|cFFDEDE42" .. L["layerFrameMsgOne"] .. "\n" .. L["layerFrameMsgTwo"]);

local NWBlayerDragFrame = CreateFrame("Frame", "NWBlayerDragFrame", NWBlayerFrame);
NWBlayerDragFrame:SetToplevel(true);
NWBlayerDragFrame:EnableMouse(true);
NWBlayerDragFrame:SetWidth(205);
NWBlayerDragFrame:SetHeight(38);
NWBlayerDragFrame:SetPoint("TOP", 0, 4);
NWBlayerDragFrame:SetFrameLevel(131);
NWBlayerDragFrame.tooltip = CreateFrame("Frame", "NWBlayerDragTooltip", NWBlayerDragFrame, "TooltipBorderedFrameTemplate");
NWBlayerDragFrame.tooltip:SetPoint("CENTER", NWBlayerDragFrame, "TOP", 0, 12);
NWBlayerDragFrame.tooltip:SetFrameStrata("TOOLTIP");
NWBlayerDragFrame.tooltip:SetFrameLevel(9);
NWBlayerDragFrame.tooltip:SetAlpha(.8);
NWBlayerDragFrame.tooltip.fs = NWBlayerDragFrame.tooltip:CreateFontString("NWBlayerDragTooltipFS", "HIGH");
NWBlayerDragFrame.tooltip.fs:SetPoint("CENTER", 0, 0.5);
NWBlayerDragFrame.tooltip.fs:SetFont(NWB.regionFont, 12);
NWBlayerDragFrame.tooltip.fs:SetText(L["Hold to drag"]);
NWBlayerDragFrame.tooltip:SetWidth(NWBlayerDragFrame.tooltip.fs:GetStringWidth() + 16);
NWBlayerDragFrame.tooltip:SetHeight(NWBlayerDragFrame.tooltip.fs:GetStringHeight() + 10);
NWBlayerDragFrame:SetScript("OnEnter", function(self)
	NWBlayerDragFrame.tooltip:Show();
end)
NWBlayerDragFrame:SetScript("OnLeave", function(self)
	NWBlayerDragFrame.tooltip:Hide();
end)
NWBlayerDragFrame.tooltip:Hide();
NWBlayerDragFrame:SetScript("OnMouseDown", function(self, button)
	if (button == "LeftButton" and not self:GetParent().isMoving) then
		self:GetParent().EditBox:ClearFocus();
		self:GetParent():StartMoving();
		self:GetParent().isMoving = true;
		--self:GetParent():SetUserPlaced(false);
	end
end)
NWBlayerDragFrame:SetScript("OnMouseUp", function(self, button)
	if (button == "LeftButton" and self:GetParent().isMoving) then
		self:GetParent():StopMovingOrSizing();
		self:GetParent().isMoving = false;
	end
end)
NWBlayerDragFrame:SetScript("OnHide", function(self)
	if (self:GetParent().isMoving) then
		self:GetParent():StopMovingOrSizing();
		self:GetParent().isMoving = false;
	end
end)

--Top right X close button.
local NWBlayerFrameClose = CreateFrame("Button", "NWBlayerFrameClose", NWBlayerFrame, "UIPanelCloseButton");
NWBlayerFrameClose:SetPoint("TOPRIGHT", -5, 8.6);
NWBlayerFrameClose:SetWidth(31);
NWBlayerFrameClose:SetHeight(31);
NWBlayerFrameClose:SetScript("OnClick", function(self, arg)
	NWBlayerFrame:Hide();
end)

--Config button.
local NWBlayerFrameConfButton = CreateFrame("Button", "NWBlayerFrameConfButton", NWBlayerFrameClose, "UIPanelButtonTemplate");
NWBlayerFrameConfButton:SetPoint("CENTER", -58, 1);
NWBlayerFrameConfButton:SetWidth(90);
NWBlayerFrameConfButton:SetHeight(17);
NWBlayerFrameConfButton:SetText(L["Options"]);
NWBlayerFrameConfButton:SetNormalFontObject("GameFontNormalSmall");
NWBlayerFrameConfButton:SetScript("OnClick", function(self, arg)
	NWB:openConfig();
end)
NWBlayerFrameConfButton:SetScript("OnMouseDown", function(self, button)
	if (button == "LeftButton" and not self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent().EditBox:ClearFocus();
		self:GetParent():GetParent():StartMoving();
		self:GetParent():GetParent().isMoving = true;
	end
end)
NWBlayerFrameConfButton:SetScript("OnMouseUp", function(self, button)
	if (button == "LeftButton" and self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent():StopMovingOrSizing();
		self:GetParent():GetParent().isMoving = false;
	end
end)
NWBlayerFrameConfButton:SetScript("OnHide", function(self)
	if (self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent():StopMovingOrSizing();
		self:GetParent():GetParent().isMoving = false;
	end
end)

--Buffs button.
local NWBlayerFrameBuffsButton = CreateFrame("Button", "NWBlayerFrameBuffsButton", NWBlayerFrameClose, "UIPanelButtonTemplate");
NWBlayerFrameBuffsButton:SetPoint("CENTER", -58, -14);
NWBlayerFrameBuffsButton:SetWidth(90);
NWBlayerFrameBuffsButton:SetHeight(17);
NWBlayerFrameBuffsButton:SetText(L["Buffs"]);
NWBlayerFrameBuffsButton:SetNormalFontObject("GameFontNormalSmall");
NWBlayerFrameBuffsButton:SetScript("OnClick", function(self, arg)
	NWB:openBuffListFrame();
end)
NWBlayerFrameBuffsButton:SetScript("OnMouseDown", function(self, button)
	if (button == "LeftButton" and not self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent().EditBox:ClearFocus();
		self:GetParent():GetParent():StartMoving();
		self:GetParent():GetParent().isMoving = true;
	end
end)
NWBlayerFrameBuffsButton:SetScript("OnMouseUp", function(self, button)
	if (button == "LeftButton" and self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent():StopMovingOrSizing();
		self:GetParent():GetParent().isMoving = false;
	end
end)
NWBlayerFrameBuffsButton:SetScript("OnHide", function(self)
	if (self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent():StopMovingOrSizing();
		self:GetParent():GetParent().isMoving = false;
	end
end)

--LayerMap button.
local NWBlayerFrameMapButton = CreateFrame("Button", "NWBlayerFrameMapButton", NWBlayerFrameClose, "UIPanelButtonTemplate");
NWBlayerFrameMapButton:SetPoint("CENTER", -58, -28);
NWBlayerFrameMapButton:SetWidth(90);
NWBlayerFrameMapButton:SetHeight(17);
NWBlayerFrameMapButton:SetText(L["Layer Map"]);
NWBlayerFrameMapButton:SetNormalFontObject("GameFontNormalSmall");
NWBlayerFrameMapButton:SetScript("OnClick", function(self, arg)
	NWB:openLayerMapFrame();
end)
NWBlayerFrameMapButton:SetScript("OnMouseDown", function(self, button)
	if (button == "LeftButton" and not self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent().EditBox:ClearFocus();
		self:GetParent():GetParent():StartMoving();
		self:GetParent():GetParent().isMoving = true;
	end
end)
NWBlayerFrameMapButton:SetScript("OnMouseUp", function(self, button)
	if (button == "LeftButton" and self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent():StopMovingOrSizing();
		self:GetParent():GetParent().isMoving = false;
	end
end)
NWBlayerFrameMapButton:SetScript("OnHide", function(self)
	if (self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent():StopMovingOrSizing();
		self:GetParent():GetParent().isMoving = false;
	end
end)

function NWB:openLayerFrame()
	NWBlayerFrame.fs:SetText(NWB.prefixColor .. "NovaWorldBuffs v" .. version .. "|r");
	--Quick fix to re-set the region font since the frames are created before we set region font.
	NWBlayerFrame.fs2:SetFont(NWB.regionFont, 14);
	NWBlayerFrame.fs3:SetFont(NWB.regionFont, 14);
	if (not NWB.isLayered) then
		NWBlayerFrameMapButton:Hide();
		NWBlayerFrame.fs2:Hide();
		NWBlayerFrame.fs3:SetText("");
		--On non-layered realms move the button on the main frame up to where layermap button would usually be.
		if (NWBlayerFrameTimerLogButton) then
			NWBlayerFrameTimerLogButton:SetPoint("CENTER", -58, -28);
		end
	end
	NWB:setLayerFrameTimerLogButtonText();
	NWB:removeOldLayers();
	NWB:checkGuildMasterSetting("set");
	NWBlayerFrame.fs:SetFont(NWB.regionFont, 14);
	if (NWBlayerFrame:IsShown()) then
		NWBlayerFrame:Hide();
	else
		NWB:syncBuffsWithCurrentDuration();
		NWBlayerFrame:SetHeight(300);
		NWBlayerFrame:SetWidth(450);
		local fontSize = false
		NWBlayerFrame.EditBox:SetFont(NWB.regionFont, 14);
		NWB:recalclayerFrame();
		NWBlayerFrame.EditBox:SetWidth(NWBlayerFrame:GetWidth() - 30);
		NWBlayerFrame:Show();
		--Changing scroll position requires a slight delay.
		--Second delay is a backup.
		C_Timer.After(0.05, function()
			NWBlayerFrame:SetVerticalScroll(0);
		end)
		C_Timer.After(0.3, function()
			NWBlayerFrame:SetVerticalScroll(0);
		end)
		--So interface options and this frame will open on top of each other.
		if (InterfaceOptionsFrame:IsShown()) then
			NWBlayerFrame:SetFrameStrata("DIALOG")
		else
			NWBlayerFrame:SetFrameStrata("HIGH")
		end
	end
end

function NWB:createNewLayer(zoneID, GUID, isFromNpc)
	if (tonumber(zoneID) == 0) then
		return;
	end
	zoneID = tonumber(zoneID);
	local count, remoteCount = 0, 0;
	for k, v in pairs(NWB.data.layers) do
		count = count + 1;
	end
	if (count >= NWB.limitLayerCount) then
		NWB:debug("Could not create new layer", zoneID, "already at limit", NWB.limitLayerCount);
		return;
	end
	if (GUID and GUID ~= "other" and GUID ~= "none") then
		--Creating layers anywhere but from other users data requires npc validation here.
		local unitType, _, _, _, zoneID, npcID = strsplit("-", GUID);
		if (NWB.faction == "Horde") then
			if (not NWB.orgrimmarCreatures[tonumber(npcID)] or unitType ~= "Creature") then
				NWB:debug("bad layer detected", unitType, zoneID, npcID);
				return;
			end
		elseif (NWB.faction == "Alliance") then
			if (not NWB.stormwindCreatures[tonumber(npcID)] or unitType ~= "Creature") then
				NWB:debug("bad layer detected", unitType, zoneID, npcID);
				return;
			end
		end
		--Don' record layers for alliance if the NPC is attached to Elwynn Forest in the layermap, disabled for now for more testing.
		--[[for k, v in pairs(NWB.data.layers) do
			if (v.layerMap) then
				for zID, mID in pairs(v.layerMap) do
					if (zoneID == zID and mID == 1429) then
						return;
					end
				end
			end
		end]]
	end
	if (NWB:validateLayer(zoneID)) then
		NWB.data.layers[zoneID] = {
			rendTimer = 0,
			rendYell = 0,
			rendYell2 = 0,
			onyTimer = 0,
			onyYell = 0,
			onyYell2 = 0,
			onyNpcDied = 0,
			nefTimer = 0,
			nefYell = 0,
			nefYell2 = 0,
			nefNpcDied = 0,
			created = GetServerTime(),
			GUID = GUID or "none",
			lastSeenNPC = 0,
			flower1 = 0,
			flower2 = 0,
			flower3 = 0,
			flower4 = 0,
			flower5 = 0,
			flower6 = 0,
			flower7 = 0,
			flower8 = 0,
			flower9 = 0,
			flower10 = 0,
		};
		if (NWB.data.layerMapBackups and NWB.data.layerMapBackups[zoneID]
				and (GetServerTime() - NWB.data.layerMapBackups[zoneID].created) < 518400) then
			--Restore layermap backup if less than 6 days old.
			if (not NWB.data.layers[zoneID].layerMap) then
				NWB.data.layers[zoneID].layerMap = {};
			end
			--NWB.data.layers[zoneID].layerMap = NWB.data.layerMapBackups[zoneID];
			--Create a copy instead of refrence and ignore timestamp.
			for k, v in pairs(NWB.data.layerMapBackups[zoneID]) do
				--Ignore created timestamp, it's not needed in the layermap, only in the backup.
				if (k ~= "created") then
					NWB.data.layers[zoneID].layerMap[k] = v;
				end
			end
		end
		--if (NWB.data.layerMapBackups[zoneID]) then
			--Delete layermap on the off chance we get the same city id 2 weeks in a row.
			--NWB.data.layerMapBackups[zoneID] = nil;
		--end
		if (isFromNpc and NWB.data.layersDisabled[zoneID]) then
			NWB.data.layersDisabled[zoneID] = nil;
			NWB:recalclayerFrame();
			NWB:refreshWorldbuffMarkers();
			NWB:print("Detected valid layer that you have disabled, re-enabling layer ID " .. zoneID .. ".");
		end
		NWB:debug("created new layer", zoneID);
		NWB:createWorldbuffMarkers();
	end
end

function NWB:removeOldLayers()
	local expireTime = 21600;
	local removed;
	if (NWB.data.layers and next(NWB.data.layers)) then
		for k, v in pairs(NWB.data.layers) do
			--Check if this layer has any current timers old than an hour expired.
			local validTimer = nil;
			if (v.rendTimer and (v.rendTimer + expireTime) > (GetServerTime() - NWB.db.global.rendRespawnTime)) then
				validTimer = true;
			end
			if (v.onyNpcDied and (v.onyNpcDied > v.onyTimer) and
					(v.onyNpcDied > (GetServerTime() - NWB.db.global.onyRespawnTime))) then
				validTimer = true;
			elseif (v.onyTimer and (v.onyTimer + expireTime) > (GetServerTime() - NWB.db.global.onyRespawnTime)) then
				validTimer = true;
			end
			if (v.nefNpcDied and (v.nefNpcDied > v.nefTimer) and
					(v.nefNpcDied > (GetServerTime() - NWB.db.global.nefRespawnTime))) then
				validTimer = true;
			elseif (v.nefTimer and (v.nefTimer + expireTime) > (GetServerTime() - NWB.db.global.nefRespawnTime)) then
				validTimer = true;
			end
			if (not v.created) then
				--For older layers created before this version update and missing this field.
				v.created = 0;
			end
			if (not validTimer and v.created < GetServerTime() - expireTime) then
				if (v.layerMap and next(v.layerMap)) then
					if (not NWB.data.layerMapBackups) then
						NWB.data.layerMapBackups = {};
					end
					NWB.data.layerMapBackups[k] = v.layerMap;
					NWB.data.layerMapBackups[k].created = v.created or GetServerTime();
				end
				NWB.data.layers[k] = nil;
				removed = true;
				NWB:debug("Removed old layer", k);
			end
		end
	end
	--Check disabled layer also.
	if (NWB.data.layersDisabled and next(NWB.data.layersDisabled)) then
		for k, v in pairs(NWB.data.layersDisabled) do
			--Check if this layer has any current timers old than an hour expired.
			local validTimer = nil;
			if (v.rendTimer and (v.rendTimer + expireTime) > (GetServerTime() - NWB.db.global.rendRespawnTime)) then
				validTimer = true;
			end
			if (v.onyNpcDied and (v.onyNpcDied > v.onyTimer) and
					(v.onyNpcDied > (GetServerTime() - NWB.db.global.onyRespawnTime))) then
				validTimer = true;
			elseif (v.onyTimer and (v.onyTimer + expireTime) > (GetServerTime() - NWB.db.global.onyRespawnTime)) then
				validTimer = true;
			end
			if (v.nefNpcDied and (v.nefNpcDied > v.nefTimer) and
					(v.nefNpcDied > (GetServerTime() - NWB.db.global.nefRespawnTime))) then
				validTimer = true;
			elseif (v.nefTimer and (v.nefTimer + expireTime) > (GetServerTime() - NWB.db.global.nefRespawnTime)) then
				validTimer = true;
			end
			if (not v.created) then
				--For older layers created before this version update and missing this field.
				v.created = 0;
			end
			if (not validTimer and v.created < GetServerTime() - expireTime) then
				NWB.data.layersDisabled[k] = nil;
				removed = true;
				NWB:debug("Removed old disabled layer", k);
			end
		end
	end
	if (NWB.data.layerMapBackups and NWB.data.layers and next(NWB.data.layers)) then
		for k, v in pairs(NWB.data.layerMapBackups) do
			--Remove layermap backups older than 6 days.
			--These backups are just there to be restored when a layer disappears because no timers for a long time (like overnight).
			if (not v.created or (GetServerTime() - v.created) > 518400) then
				--NWB:debug("removed layermap", GetServerTime() - v.created)
				NWB.data.layerMapBackups[k] = nil;
			end
		end
	end
	if (removed) then
		NWB:refreshWorldbuffMarkers();
	end
end

--Remove any old layers with no timers (/wb removeold).
--Can be used after server restarts.
function NWB:removeOldLayersNoTimer()
	NWB:print("Looking for old layers with no timers to remove.");
	local timers = {};
	timers["rendTimer"] = NWB.db.global.rendRespawnTime;
	timers["onyTimer"] = NWB.db.global.onyRespawnTime;
	timers["nefTimer"] = NWB.db.global.nefRespawnTime;
	local count = 0;
	local noRemove;
	for k, v in NWB:pairsByKeys(NWB.data.layers) do
		count = count + 1;
		for kk, vv in pairs(timers) do
			local timeLeft = (NWB.data.layers[k][kk] + vv) - GetServerTime();
			if (timeLeft > 0) then
				noRemove = true;
			end
		end
		if (not noRemove) then
			NWB:print(L["Removing old layer:"], k);
			NWB.data.layers[k] = nil;
		end
	end
end

function NWB:disableLayer(layer)
	if (NWB.data.layers[layer]) then
		NWB.data.layers[layer].disabled = true;
		NWB:print(string.format(L["layerHasBeenDisabled"], layer));
		--Simulate a group join to ignore layer mapping new data after chaning layer stuff.
		NWB.lastJoinedGroup = GetServerTime();
		NWB:recalcDisabledLayers();
		NWB:recalcMinimapLayerFrame(0);
	else
		NWB:print(string.format(L["layerDoesNotExist"], layer));
	end
end

function NWB:enableLayer(layer)
	if (NWB.data.layersDisabled[layer]) then
		NWB.data.layersDisabled[layer].disabled = nil;
		NWB:print(string.format(L["layerHasBeenEnabled"], layer));
		--Simulate a group join to ignore layer mapping new data after chaning layer stuff.
		NWB.lastJoinedGroup = GetServerTime();
		NWB:recalcDisabledLayers();
		NWB:recalcMinimapLayerFrame(0);
	else
		NWB:print(string.format(L["layerDoesNotExist"], layer));
	end
end

function NWB:recalcDisabledLayers()
	local removed, added;
 	for k, v in pairs(NWB.data.layers) do
		--Check if any layer has been disabled manually.
		if (v.disabled) then
			NWB.data.layersDisabled[k] = v;
			NWB.data.layers[k] = nil;
			removed = true;
		end
	end
	for k, v in pairs(NWB.data.layersDisabled) do
		--Check if any layer has been disabled manually.
		if (not v.disabled) then
			NWB.data.layers[k] = v;
			NWB.data.layersDisabled[k] = nil;
			added = true;
		end
	end
	if (removed or added) then
		NWB:recalclayerFrame();
		NWB:refreshWorldbuffMarkers();
	end
		end

		function NWB:createDisableLayerButton(count)
			NWB["NWBDisableLayerButton" .. count] = CreateFrame("Button", "NWBDisableLayerButton" .. count, NWBlayerFrame.EditBox, "UIPanelButtonTemplate");
			NWB["NWBDisableLayerButton" .. count]:SetWidth(90);
			NWB["NWBDisableLayerButton" .. count]:SetHeight(14);
			NWB["NWBDisableLayerButton" .. count]:SetText(L["disableLayerButton"]);
			NWB["NWBDisableLayerButton" .. count]:SetNormalFontObject("GameFontNormalSmall");
			NWB["NWBDisableLayerButton" .. count].layer = 0;
			NWB["NWBDisableLayerButton" .. count]:SetScript("OnClick", function(self, arg)
				NWB:disableLayer(NWB["NWBDisableLayerButton" .. count].layer);
				NWB["NWBDisableLayerButton" .. count]:Hide();
			end)
			NWB["NWBDisableLayerButton" .. count].tooltip = CreateFrame("Frame", "NWBDisableLayerButtonTooltip" .. count, NWB["NWBDisableLayerButton" .. count], "TooltipBorderedFrameTemplate");
			NWB["NWBDisableLayerButton" .. count].tooltip:SetPoint("BOTTOM", NWB["NWBDisableLayerButton" .. count], "CENTER", -100, 5);
			NWB["NWBDisableLayerButton" .. count].tooltip:SetFrameStrata("HIGH");
			NWB["NWBDisableLayerButton" .. count].tooltip:SetFrameLevel(3);
			NWB["NWBDisableLayerButton" .. count].tooltip.fs = NWB["NWBDisableLayerButton" .. count].tooltip:CreateFontString("NWBDisableLayerButtonTooltipFS" .. count, "ARTWORK");
			NWB["NWBDisableLayerButton" .. count].tooltip.fs:SetPoint("CENTER", -0, 0);
			NWB["NWBDisableLayerButton" .. count].tooltip.fs:SetFont(NWB.regionFont, 13);
			NWB["NWBDisableLayerButton" .. count].tooltip.fs:SetJustifyH("LEFT");
			NWB["NWBDisableLayerButton" .. count].tooltip.fs:SetText(L["disableLayerButtonTooltip"]);
			NWB["NWBDisableLayerButton" .. count].tooltip:SetWidth(NWB["NWBDisableLayerButton" .. count].tooltip.fs:GetStringWidth() + 18);
			NWB["NWBDisableLayerButton" .. count].tooltip:SetHeight(NWB["NWBDisableLayerButton" .. count].tooltip.fs:GetStringHeight() + 12);
			NWB["NWBDisableLayerButton" .. count]:SetScript("OnEnter", function(self)
				NWB["NWBDisableLayerButton" .. count].tooltip:Show();
			end)
			NWB["NWBDisableLayerButton" .. count]:SetScript("OnLeave", function(self)
				NWB["NWBDisableLayerButton" .. count].tooltip:Hide();
			end)
			NWB["NWBDisableLayerButton" .. count].tooltip:Hide();
		end
		
		function NWB:createEnabledLayerButton(count)
			NWB["NWBEnableLayerButton" .. count] = CreateFrame("Button", "NWBEnableLayerButton" .. count, NWBlayerFrame.EditBox, "UIPanelButtonTemplate");
			NWB["NWBEnableLayerButton" .. count]:SetWidth(90);
			NWB["NWBEnableLayerButton" .. count]:SetHeight(14);
			NWB["NWBEnableLayerButton" .. count]:SetText(L["enableLayerButton"]);
			NWB["NWBEnableLayerButton" .. count]:SetNormalFontObject("GameFontNormalSmall");
			NWB["NWBEnableLayerButton" .. count].layer = 0;
			NWB["NWBEnableLayerButton" .. count]:SetScript("OnClick", function(self, arg)
				NWB:enableLayer(NWB["NWBEnableLayerButton" .. count].layer);
				NWB["NWBEnableLayerButton" .. count]:Hide();
			end)
			NWB["NWBEnableLayerButton" .. count].tooltip = CreateFrame("Frame", "NWBEnableLayerButtonTooltip" .. count, NWB["NWBEnableLayerButton" .. count], "TooltipBorderedFrameTemplate");
			NWB["NWBEnableLayerButton" .. count].tooltip:SetPoint("BOTTOM", NWB["NWBEnableLayerButton" .. count], "CENTER", -100, 5);
			NWB["NWBEnableLayerButton" .. count].tooltip:SetFrameStrata("HIGH");
			NWB["NWBEnableLayerButton" .. count].tooltip:SetFrameLevel(3);
			NWB["NWBEnableLayerButton" .. count].tooltip.fs = NWB["NWBEnableLayerButton" .. count].tooltip:CreateFontString("NWBEnableLayerButtonTooltipFS" .. count, "ARTWORK");
			NWB["NWBEnableLayerButton" .. count].tooltip.fs:SetPoint("CENTER", -0, 0);
			NWB["NWBEnableLayerButton" .. count].tooltip.fs:SetFont(NWB.regionFont, 13);
			NWB["NWBEnableLayerButton" .. count].tooltip.fs:SetJustifyH("LEFT");
			NWB["NWBEnableLayerButton" .. count].tooltip.fs:SetText(L["enableLayerButtonTooltip"]);
			NWB["NWBEnableLayerButton" .. count].tooltip:SetWidth(NWB["NWBEnableLayerButton" .. count].tooltip.fs:GetStringWidth() + 18);
			NWB["NWBEnableLayerButton" .. count].tooltip:SetHeight(NWB["NWBEnableLayerButton" .. count].tooltip.fs:GetStringHeight() + 12);
			NWB["NWBEnableLayerButton" .. count]:SetScript("OnEnter", function(self)
				NWB["NWBEnableLayerButton" .. count].tooltip:Show();
			end)
			NWB["NWBEnableLayerButton" .. count]:SetScript("OnLeave", function(self)
				NWB["NWBEnableLayerButton" .. count].tooltip:Hide();
			end)
			NWB["NWBEnableLayerButton" .. count].tooltip:Hide();
		end
		
function NWB:recalclayerFrame()
	NWBlayerFrame.EditBox:SetText("\n\n");
	local count = 0;
	local foundTimers;
	table.sort(NWB.data.layers);
	if (NWB.isLayered) then
		for k, v in NWB:pairsByKeys(NWB.data.layers) do
			foundTimers = true;
			count = count + 1;
			NWBlayerFrame.EditBox:Insert(L["\n|cff00ff00[Layer "] .. count .. L["]|r  |cFF989898(zone "] .. k .. ")|r\n");
			if (not _G["NWBDisableLayerButton" .. count]) then
				NWB:createDisableLayerButton(count);
			end
			--Make sure right button is shown.
			if (_G["NWBEnableLayerButton" .. count]) then
				_G["NWBEnableLayerButton" .. count]:Hide();
			end
			_G["NWBDisableLayerButton" .. count]:Show();
			--Set the button beside the layer text, count the lines in the edit box to find right position.
			local _, lineCount = string.gsub(NWBlayerFrame.EditBox:GetText(), "\n", "");
			lineCount = lineCount - 1;
			NWB["NWBDisableLayerButton" .. count]:SetPoint("TOPLEFT", 215, -(lineCount * 14.25));
			--Set the layer ID this button will disable.
			NWB["NWBDisableLayerButton" .. count].layer = k;
			local msg = "";
			if (NWB.faction == "Horde" or NWB.db.global.allianceEnableRend) then
				if (v.rendTimer > (GetServerTime() - NWB.db.global.rendRespawnTime)) then
					msg = msg .. L["rend"] .. ": " .. NWB:getTimeString(NWB.db.global.rendRespawnTime - (GetServerTime() - v.rendTimer), true) .. ".";
					if (NWB.db.global.showTimeStamp) then
						local timeStamp = NWB:getTimeFormat(v.rendTimer + NWB.db.global.rendRespawnTime);
						msg = msg .. " (" .. timeStamp .. ")";
					end
				else
					msg = msg .. L["rend"] .. ": " .. L["noCurrentTimer"] .. ".";
				end
				NWBlayerFrame.EditBox:Insert(NWB.chatColor .. msg .. "\n");
			end
			msg = "";
			if ((v.onyNpcDied > v.onyTimer) and
					(v.onyNpcDied > (GetServerTime() - NWB.db.global.onyRespawnTime))) then
				if (NWB.faction == "Horde") then
					msg = msg .. string.format(L["onyxiaNpcKilledHordeWithTimer"], NWB:getTimeString(GetServerTime() - v.onyNpcDied, true));
				else
					msg = msg .. string.format(L["onyxiaNpcKilledAllianceWithTimer"], NWB:getTimeString(GetServerTime() - v.onyNpcDied, true));
				end
			elseif (v.onyTimer > (GetServerTime() - NWB.db.global.onyRespawnTime)) then
				msg = msg .. L["onyxia"] .. ": " .. NWB:getTimeString(NWB.db.global.onyRespawnTime - (GetServerTime() - v.onyTimer), true) .. ".";
				if (NWB.db.global.showTimeStamp) then
					local timeStamp = NWB:getTimeFormat(v.onyTimer + NWB.db.global.onyRespawnTime);
					msg = msg .. " (" .. timeStamp .. ")";
				end
			else
				msg = msg .. L["onyxia"] .. ": " .. L["noCurrentTimer"] .. ".";
			end
			NWBlayerFrame.EditBox:Insert(NWB.chatColor .. msg .. "\n");
			msg = "";
			if ((v.nefNpcDied > v.nefTimer) and
					(v.nefNpcDied > (GetServerTime() - NWB.db.global.nefRespawnTime))) then
				if (NWB.faction == "Horde") then
					msg = msg .. string.format(L["nefarianNpcKilledHordeWithTimer"], NWB:getTimeString(GetServerTime() - v.nefNpcDied, true));
				else
					msg = msg .. string.format(L["nefarianNpcKilledAllianceWithTimer"], NWB:getTimeString(GetServerTime() - v.nefNpcDied, true));
				end
			elseif (v.nefTimer > (GetServerTime() - NWB.db.global.nefRespawnTime)) then
				msg = L["nefarian"] .. ": " .. NWB:getTimeString(NWB.db.global.nefRespawnTime - (GetServerTime() - v.nefTimer), true) .. ".";
				if (NWB.db.global.showTimeStamp) then
					local timeStamp = NWB:getTimeFormat(v.nefTimer + NWB.db.global.nefRespawnTime);
					msg = msg .. " (" .. timeStamp .. ")";
				end
			else
				msg = msg .. L["nefarian"] .. ": " .. L["noCurrentTimer"] .. ".";
			end
			NWBlayerFrame.EditBox:Insert(NWB.chatColor .. msg .. "\n");
			if ((v.rendTimer + 3600) > (GetServerTime() - NWB.db.global.rendRespawnTime)
					or (v.onyTimer + 3600) > (GetServerTime() - NWB.db.global.onyRespawnTime)
					or (v.nefTimer + 3600) > (GetServerTime() - NWB.db.global.nefRespawnTime)) then
				NWB:removeOldLayers();
			end
		end
		--Disabled layers in grey after the enabled layers.
		for k, v in NWB:pairsByKeys(NWB.data.layersDisabled) do
			foundTimers = true;
			count = count + 1;
			NWBlayerFrame.EditBox:Insert(L["\n|cFF989898[Layer Disabled]  (zone "] .. k .. ")|r\n");
			if (not _G["NWBEnableLayerButton" .. count]) then
				NWB:createEnabledLayerButton(count);
			end
			--Make sure right button is shown.
			if (_G["NWBDisableLayerButton" .. count]) then
				_G["NWBDisableLayerButton" .. count]:Hide();
			end
			_G["NWBEnableLayerButton" .. count]:Show();
			--Set the button beside the layer text, count the lines in the edit box to find right position.
			local _, lineCount = string.gsub(NWBlayerFrame.EditBox:GetText(), "\n", "");
			lineCount = lineCount - 1;
			NWB["NWBEnableLayerButton" .. count]:SetPoint("TOPLEFT", 215, -(lineCount * 14.25));
			--Set the layer ID this button will enable.
			NWB["NWBEnableLayerButton" .. count].layer = k;
			local msg = "|cFF989898";
			if (NWB.faction == "Horde" or NWB.db.global.allianceEnableRend) then
				if (v.rendTimer > (GetServerTime() - NWB.db.global.rendRespawnTime)) then
					msg = msg .. L["rend"] .. ": " .. NWB:getTimeString(NWB.db.global.rendRespawnTime - (GetServerTime() - v.rendTimer), true) .. ".";
					if (NWB.db.global.showTimeStamp) then
						local timeStamp = NWB:getTimeFormat(v.rendTimer + NWB.db.global.rendRespawnTime);
						msg = msg .. " (" .. timeStamp .. ")";
					end
				else
					msg = msg .. L["rend"] .. ": " .. L["noCurrentTimer"] .. ".";
				end
				NWBlayerFrame.EditBox:Insert(msg .. "\n");
			end
			msg = "";
			if ((v.onyNpcDied > v.onyTimer) and
					(v.onyNpcDied > (GetServerTime() - NWB.db.global.onyRespawnTime))) then
				if (NWB.faction == "Horde") then
					msg = msg .. string.format(L["onyxiaNpcKilledHordeWithTimer"], NWB:getTimeString(GetServerTime() - v.onyNpcDied, true));
				else
					msg = msg .. string.format(L["onyxiaNpcKilledAllianceWithTimer"], NWB:getTimeString(GetServerTime() - v.onyNpcDied, true));
				end
			elseif (v.onyTimer > (GetServerTime() - NWB.db.global.onyRespawnTime)) then
				msg = msg .. L["onyxia"] .. ": " .. NWB:getTimeString(NWB.db.global.onyRespawnTime - (GetServerTime() - v.onyTimer), true) .. ".";
				if (NWB.db.global.showTimeStamp) then
					local timeStamp = NWB:getTimeFormat(v.onyTimer + NWB.db.global.onyRespawnTime);
					msg = msg .. " (" .. timeStamp .. ")";
				end
			else
				msg = msg .. L["onyxia"] .. ": " .. L["noCurrentTimer"] .. ".";
			end
			NWBlayerFrame.EditBox:Insert(msg .. "\n");
			msg = "";
			if ((v.nefNpcDied > v.nefTimer) and
					(v.nefNpcDied > (GetServerTime() - NWB.db.global.nefRespawnTime))) then
				if (NWB.faction == "Horde") then
					msg = msg .. string.format(L["nefarianNpcKilledHordeWithTimer"], NWB:getTimeString(GetServerTime() - v.nefNpcDied, true));
				else
					msg = msg .. string.format(L["nefarianNpcKilledAllianceWithTimer"], NWB:getTimeString(GetServerTime() - v.nefNpcDied, true));
				end
			elseif (v.nefTimer > (GetServerTime() - NWB.db.global.nefRespawnTime)) then
				msg = L["nefarian"] .. ": " .. NWB:getTimeString(NWB.db.global.nefRespawnTime - (GetServerTime() - v.nefTimer), true) .. ".";
				if (NWB.db.global.showTimeStamp) then
					local timeStamp = NWB:getTimeFormat(v.nefTimer + NWB.db.global.nefRespawnTime);
					msg = msg .. " (" .. timeStamp .. ")";
				end
			else
				msg = msg .. L["nefarian"] .. ": " .. L["noCurrentTimer"] .. ".";
			end
			NWBlayerFrame.EditBox:Insert(msg .. "\n");
			if ((v.rendTimer + 3600) > (GetServerTime() - NWB.db.global.rendRespawnTime)
					or (v.onyTimer + 3600) > (GetServerTime() - NWB.db.global.onyRespawnTime)
					or (v.nefTimer + 3600) > (GetServerTime() - NWB.db.global.nefRespawnTime)) then
				NWB:removeOldLayers();
			end
		end
	else
		foundTimers = true;
		local msg = "";
		NWBlayerFrame.EditBox:Insert("\n");
		if (NWB.faction == "Horde" or NWB.db.global.allianceEnableRend) then
			if (NWB.data.rendTimer > (GetServerTime() - NWB.db.global.rendRespawnTime)) then
				msg = L["rend"] .. ": " .. NWB:getTimeString(NWB.db.global.rendRespawnTime - (GetServerTime() - NWB.data.rendTimer), true) .. ".";
				if (NWB.db.global.showTimeStamp) then
					local timeStamp = NWB:getTimeFormat(NWB.data.rendTimer + NWB.db.global.rendRespawnTime);
					msg = msg .. " (" .. timeStamp .. ")";
				end
			else
				msg = L["rend"] .. ": " .. L["noCurrentTimer"] .. ".";
			end
			if ((not isLogon or NWB.db.global.logonRend) and not NWB.isLayered) then
				NWBlayerFrame.EditBox:Insert(NWB.chatColor .. msg .. "\n");
			end
		end
		if ((NWB.data.onyNpcDied > NWB.data.onyTimer) and
				(NWB.data.onyNpcDied > (GetServerTime() - NWB.db.global.onyRespawnTime))) then
			if (NWB.faction == "Horde") then
				msg = string.format(L["onyxiaNpcKilledHordeWithTimer"], NWB:getTimeString(GetServerTime() - NWB.data.onyNpcDied, true));
			else
				msg = string.format(L["onyxiaNpcKilledAllianceWithTimer"], NWB:getTimeString(GetServerTime() - NWB.data.onyNpcDied, true));
			end
		elseif (NWB.data.onyTimer > (GetServerTime() - NWB.db.global.onyRespawnTime)) then
			msg = L["onyxia"] .. ": " .. NWB:getTimeString(NWB.db.global.onyRespawnTime - (GetServerTime() - NWB.data.onyTimer), true) .. ".";
			if (NWB.db.global.showTimeStamp) then
				local timeStamp = NWB:getTimeFormat(NWB.data.onyTimer + NWB.db.global.onyRespawnTime);
				msg = msg .. " (" .. timeStamp .. ")";
			end
		else
			msg = L["onyxia"] .. ": " .. L["noCurrentTimer"] .. ".";
		end
		if ((not isLogon or NWB.db.global.logonOny) and not NWB.isLayered) then
			NWBlayerFrame.EditBox:Insert(NWB.chatColor .. msg .. "\n");
		end
		if ((NWB.data.nefNpcDied > NWB.data.nefTimer) and
				(NWB.data.nefNpcDied > (GetServerTime() - NWB.db.global.nefRespawnTime))) then
			if (NWB.faction == "Horde") then
				msg = string.format(L["nefarianNpcKilledHordeWithTimer"], NWB:getTimeString(GetServerTime() - NWB.data.nefNpcDied, true));
			else
				msg = string.format(L["nefarianNpcKilledAllianceWithTimer"], NWB:getTimeString(GetServerTime() - NWB.data.nefNpcDied, true));
			end
		elseif (NWB.data.nefTimer > (GetServerTime() - NWB.db.global.nefRespawnTime)) then
			msg = L["nefarian"] .. ": " .. NWB:getTimeString(NWB.db.global.nefRespawnTime - (GetServerTime() - NWB.data.nefTimer), true) .. ".";
			if (NWB.db.global.showTimeStamp) then
				local timeStamp = NWB:getTimeFormat(NWB.data.nefTimer + NWB.db.global.nefRespawnTime);
				msg = msg .. " (" .. timeStamp .. ")";
			end
		else
			msg = L["nefarian"] .. ": " .. L["noCurrentTimer"] .. ".";
		end
		if ((not isLogon or NWB.db.global.logonNef) and not NWB.isLayered) then
			NWBlayerFrame.EditBox:Insert(NWB.chatColor .. msg .. "\n");
		end
	end
	if (not foundTimers) then
		NWBlayerFrame.EditBox:Insert(NWB.chatColor .. "\nNo current timers found.");
	end
	NWB:setCurrentLayerText();
	local found;
	local gmText = "";
	if (next(NWB.guildMasterSettings)) then
		for k, v in NWB:pairsByKeys(NWB.guildMasterSettings) do
			if (k == 1) then
				gmText = gmText ..  L["\n -All NWB guild msgs disabled (#nwb1)."];
				found = true;
			elseif (k == 2) then
				gmText = gmText ..  L["\n -Timer guild msgs disabled (#nwb2)."];
				found = true;
			elseif (k == 3) then
				gmText = gmText ..  L["\n -Buff dropped guild msgs disabled (#nwb3)."];
				found = true;
			elseif (k == 4) then
				gmText = gmText ..  L["\n -!wb guild command disabled (#nwb4)."];
				found = true;
			elseif (k == 5) then
				gmText = gmText ..  L["\n -Songflower guild msgs disabled (#nwb5)."];
				found = true;
			end
		end
	end
	if (found) then
		NWBlayerFrame.EditBox:Insert(L["\n\n|cFF9CD6DEYour guild master has the following public guild note settings enabled:"] .. gmText);
	end
	if (NWB.latestRemoteVersion and tonumber(NWB.latestRemoteVersion) > tonumber(version)) then
		NWBlayerFrame.fs3:SetText(L["Out of date version "] .. version .. L[" (New version: "]
				.. NWB.latestRemoteVersion .. L[")\nPlease update so your timers are accurate."]);
	end
	--Add 2 extra blank lines to you can scroll layer data up past text at bottom of the frame.
	NWBlayerFrame.EditBox:Insert("\n\n\n");
	--Set the bottom text position depending on if there's a scrollable area or not.
	if (NWBlayerFrame.EditBox:GetHeight() > (NWBlayerFrame:GetHeight() - NWBlayerFrame.fs3:GetHeight())) then
		NWBlayerFrame.fs3:SetPoint("BOTTOM", NWBlayerFrame.EditBox, 0, 2);
		NWBlayerFrame.fs3:SetParent(NWBlayerFrame.EditBox);
	else
		NWBlayerFrame.fs3:SetPoint("BOTTOM", NWBlayerFrame, 0, 2);
		NWBlayerFrame.fs3:SetParent(NWBlayerFrame);
	end
end

local f = CreateFrame("Frame");
f:RegisterEvent("UNIT_TARGET");
f:RegisterEvent("PLAYER_TARGET_CHANGED");
f:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
f:RegisterEvent("GROUP_JOINED");
f:RegisterEvent("ZONE_CHANGED_NEW_AREA");
f:RegisterEvent("PLAYER_ENTERING_WORLD");
f:RegisterEvent("PLAYER_LEAVING_WORLD");
f:RegisterEvent("UNIT_PHASE");
f:RegisterEvent("PLAYER_LOGIN");
NWB.lastJoinedGroup = 0;
NWB.lastJoinedGroupCooldown = 180;
NWB.lastZoneChange = 0;
NWB.validLayer = false;
local logonEnteringWorld = 0;
f:SetScript('OnEvent', function(self, event, ...)
	if (event == "UNIT_TARGET" or event == "PLAYER_TARGET_CHANGED") then
		--These 2 funcs need to be merged after testing.
		NWB:setCurrentLayerText("target");
		NWB:mapCurrentLayer("target");
	elseif (event == "UPDATE_MOUSEOVER_UNIT") then
		NWB:setCurrentLayerText("mouseover");
		NWB:mapCurrentLayer("mouseover");
	elseif (event == "GROUP_JOINED") then
		NWB.lastKnownLayerMapID = 0;
		NWB.currentZoneID = 0;
		--Block a new zoneid from being set for longer than the team join block is if it's the same zoneid they got earlier.
		--IE not changed layer yet after joining group because of layer swap cooldown.
		--This time should be a longer duration than lastJoinedGrop lockout below.
		--if (NWB.validZoneIDTimer) then
		--	NWB.validZoneIDTimer:Cancel();
		--end
		--NWB.validZoneIDTimer = C_Timer.NewTimer(600, function()
		--	NWB.lastCurrentZoneID = nil;
		--end)
		NWB.lastJoinedGroup = GetServerTime();
		if ((GetServerTime() - logonEnteringWorld) > 5) then
			--NWB.lastKnownLayerMapIDBackup is used for songflowers only.
			--It's a way to attach SF timers to a layer even if you logon in a group or join a group right after logon.
			--NWB.lastKnownLayerMapID is wiped on joining group for layer changinging reasons so that's why this backup exists only for songflowers.
			--Here we allow NWB.lastKnownLayerMapIDBackup to be valid for 3 minutes after logging in if al;ready in a group.
			--Or valid for up to 1 minute after logon if you join a group after logon.
			local sinceLogon = GetServerTime() - logonEnteringWorld;
			local buffer = 60 - sinceLogon;
			if (buffer > 0) then
				C_Timer.After(buffer, function()
					NWB.lastKnownLayerMapIDBackup = nil;
				end)
			else
				NWB.lastKnownLayerMapIDBackup = nil;
			end
		end
	elseif (event == "PLAYER_LOGIN") then
		logonEnteringWorld = GetServerTime();
		if (IsInGroup()) then
			NWB.lastKnownLayerMapID = 0;
			NWB.currentZoneID = 0;
			--NWB.lastJoinedGroup = GetServerTime();
		end
		C_Timer.After(NWB.lastKnownLayerMapIDBackupValidFor, function()
			NWB.lastKnownLayerMapIDBackup = nil;
		end)
	elseif (event == "ZONE_CHANGED_NEW_AREA") then
		NWB:recalcMinimapLayerFrame();
		--Check if we just logged on so as not to block setting a new currentZoneID.
		if ((GetServerTime() - logonEnteringWorld) > 5) then
			--NWB:debug("zone change");
			NWB.lastZoneChange = GetServerTime();
		end
		NWB.currentZoneID = 0;
		NWB.lastCurrentZoneID = 0;
	elseif (event == "PLAYER_ENTERING_WORLD") then
		local isLogon, isReload = ...;
		NWB:recalcMinimapLayerFrame();
		if ((not isLogon and not isReload) or IsInGroup()) then
			NWB.lastZoneChange = GetServerTime();
		end
		NWB.currentZoneID = 0;
		NWB.lastCurrentZoneID = 0;
	elseif (event == "PLAYER_LEAVING_WORLD") then
		NWB.lastZoneChange = GetServerTime();
		NWB.currentZoneID = 0;
	elseif (event == "UNIT_PHASE") then
		local unit = ...;
		--This event fires for team members not for self.
		--But seems ok way to find if you join a team to phase.
		--Seems to fire even when you are in the same phase, guess it will still do for now to reset the phase frame and make user retarget a npc.
		if (UnitIsGroupLeader(unit)) then
			NWB.currentLayer = 0;
			NWB.currentZoneID = 0;
			NWB:recalcMinimapLayerFrame();
		end
	end
end)

function NWB:guidFromClosestNameplate()
	if (GetCVar("nameplateShowFriends") ~= "1") then
		SetCVar("nameplateShowFriends", 1);
		NWB:setCurrentLayerText("nameplate1");
		SetCVar("nameplateShowFriends", 0);
	else
		NWB:setCurrentLayerText("nameplate1");
	end
end

--There are a few different types here because they set/reset on different things for different functions.
NWB.lastKnownLayer = 0;
NWB.lastKnownLayerID = 0;
NWB.lastKnownLayerMapID = 0;
NWB.lastKnownLayerMapIDBackup = 0; --Only used for songflowers if logging on in a group.
NWB.lastKnownLayerMapIDBackupValidFor = 120; --How long after logon this can be valid for.
NWB.currentZoneID = 0;
NWB.lastCurrentZoneID = 0;
NWB.validZoneIDTimer = nil;
NWB.AllowCurrentZoneID = true;
function NWB:setCurrentLayerText(unit)
	if (not NWB.isLayered or not unit) then
		return;
	end
	local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
	local GUID = UnitGUID(unit);
	local unitType, zoneID, npcID;
	if (GUID) then
		unitType, _, _, _, zoneID, npcID = strsplit("-", GUID);
	end
	if (not zoneID) then
		--NWBlayerFrame.fs2:SetText("|cFF9CD6DETarget any NPC in Orgrimmar to see your current layer.|r");
		return;
	end
	--NWB:debug("Layer:", GUID);
	if (NWB.faction == "Horde" and (zone ~= 1454 or not npcID)) then
		NWBlayerFrame.fs2:SetText(L["|cFF9CD6DETarget any NPC in Orgrimmar to see your current layer.|r"]);
		return;
	end
	if (NWB.faction == "Alliance" and (zone ~= 1453 or not npcID)) then
		NWBlayerFrame.fs2:SetText(L["|cFF9CD6DETarget any NPC in Stormwind to see your current layer.|r"]);
		return;
	end
	if (unitType ~= "Creature" or NWB.companionCreatures[tonumber(npcID)]) then
		if (NWB.faction == "Horde") then
			NWBlayerFrame.fs2:SetText(L["|cFF9CD6DETarget any NPC in Orgrimmar to see your current layer.|r"]);
		else
			NWBlayerFrame.fs2:SetText(L["|cFF9CD6DETarget any NPC in Stormwind to see your current layer.|r"]);
		end
		return;
	end
	local count = 0;
	for k, v in NWB:pairsByKeys(NWB.data.layers) do
		count = count + 1;
		if (k == tonumber(zoneID)) then
			NWBlayerFrame.fs2:SetText("|cFF9CD6DE" .. L["You are currently on"] .. " |cff00ff00[Layer " .. count .. "]|cFF9CD6DE.|r");
			NWB.currentLayer = count;
			NWB.lastKnownLayer = count;
			NWB.lastKnownLayerID = k;
			if ((GetServerTime() - NWB.lastJoinedGroup) > NWB.lastJoinedGroupCooldown) then
				NWB.lastKnownLayerMapID = tonumber(k);
			end
			NWB.lastKnownLayerTime = GetServerTime();
			NWB:recalcMinimapLayerFrame();
			--Update layer created time any time we target a NPC on this layer in capital city.
			--To help layers persist better overnight but not after server restarts.
			--But only if the layer has had a valid timer previously.
			--This may create problems with false layers being shared around if a layer is created by some not valid city NPC.
			--Will see how this goes, I need layers to be shared without timers, hotfixes lately have broken world buff NPCs.
			--if (v.rendTimer > 0 or v.onyTimer > 0 or v.nefTimer > 0) then
				--NWB.data.layers[k].lastSeenNPC = GetServerTime();
			--end
			if (((NWB.faction == "Alliance" and zone == 1453 and NWB.stormwindCreatures[tonumber(npcID)])
					or (NWB.faction == "Horde" and zone == 1454 and NWB.orgrimmarCreatures[tonumber(npcID)]))
					and (GetServerTime() - NWB.lastJoinedGroup) > 300
					and (GetServerTime() - NWB.lastZoneChange) > 30
					) then
					--and NWB.lastCurrentZoneID ~= tonumber(zoneID)) then
				NWB.currentZoneID = tonumber(zoneID);
				--NWB:debug("NWB.currentZoneID update", NWB.currentZoneID);
				--NWB.lastCurrentZoneID is not reset when joining group.
				--So when you join a group you can't get another valid zoneID from the same layer and then phase over after it bringing the wrong zoneID with you.
				NWB.lastCurrentZoneID = tonumber(zoneID);
				NWB.data.layers[k].lastSeenNPC = GetServerTime();
			end
			return;
		end
	end
	if (((NWB.faction == "Alliance" and zone == 1453 and NWB.stormwindCreatures[tonumber(npcID)])
			or (NWB.faction == "Horde" and zone == 1454 and NWB.orgrimmarCreatures[tonumber(npcID)]))
			and tonumber(zoneID) and not NWB.data.layers[tonumber(zoneID)]) then
		NWB:createNewLayer(tonumber(zoneID), GUID, true);
	end
	--I was going to let it create layers from layermap backups out in the world when timers aren't dropped for a while.
	--Needs more thought though how to handle old layermap data after server restarts.
	--[[if (tonumber(zoneID) and not NWB.data.layers[tonumber(zoneID)]) then
		for k, v in pairs(NWB.data.layerMapBackups) do
			for layerMap, data in pairs(v) do
				if (data == tonumber(zoneID)) then
					--/run NWB.data.layers[45].nefTimer = 0; NWB.data.layers[45].created = GetServerTime() - 318400
					break;
				end
			end
		end
	end]]
	NWBlayerFrame.fs2:SetText("|cFF9CD6DECan't find current layer or no timers active for this layer.|r");
end

NWB.layerMapWhitelist = {
	--[947] = "Azeroth",
	[1411] = "Durotar",
	[1412] = "Mulgore",
	[1413] = "The Barrens",
	--[1414] = "Kalimdor 	Continent 	Azeroth
	--[1415] = "Eastern Kingdoms 	Continent 	Azeroth
	[1416] = "Alterac Mountains",
	[1417] = "Arathi Highlands",
	[1418] = "Badlands",
	[1419] = "Blasted Lands",
	[1420] = "Tirisfal Glades",
	[1421] = "Silverpine Forest",
	[1422] = "Western Plaguelands",
	[1423] = "Eastern Plaguelands",
	[1424] = "Hillsbrad Foothills",
	[1425] = "The Hinterlands",
	[1426] = "Dun Morogh",
	[1427] = "Searing Gorge",
	[1428] = "Burning Steppes",
	[1429] = "Elwynn Forest",
	[1430] = "Deadwind Pass",
	[1431] = "Duskwood",
	[1432] = "Loch Modan",
	[1433] = "Redridge Mountains",
	[1434] = "Stranglethorn Vale",
	[1435] = "Swamp of Sorrows",
	[1436] = "Westfall",
	[1437] = "Wetlands",
	[1438] = "Teldrassil",
	[1439] = "Darkshore",
	[1440] = "Ashenvale",
	[1441] = "Thousand Needles",
	[1442] = "Stonetalon Mountains",
	[1443] = "Desolace",
	[1444] = "Feralas",
	[1445] = "Dustwallow Marsh",
	[1446] = "Tanaris",
	[1447] = "Azshara",
	[1448] = "Felwood",
	[1449] = "Un'Goro Crater",
	[1450] = "Moonglade",
	[1451] = "Silithus",
	[1452] = "Winterspring",
	[1453] = "Stormwind City",
	[1454] = "Orgrimmar",
	[1455] = "Ironforge",
	[1456] = "Thunder Bluff",
	[1457] = "Darnassus",
	[1458] = "Undercity",
	--[1459] = "Alterac Valley 	Zone 	Azeroth
	--[1460] = "Warsong Gulch 	Zone 	Azeroth
	--[1461] = "Arathi Basin 	Zone 	Azeroth
};

--This relys on a few things.
--[[If you cross a zone border but can still see mobs from the previous zone and target them it could map the previous zoneid
	to the new zone, it won't overwrite an already known id so this should be fine aslong as the previous zone was
	shared by someone else or we mouseovered any mob in the previous zone and recorded our own data.
	On rare occasions it could map the wrong id if previous zone we came from is completly unknown,
	but with the data being shared around the server, most of the time after server restarts it will just
	get mapped one time by a few early players and shared around, so the chances of this bug happening is pretty low.]]
	
function NWB:mapCurrentLayer(unit)
	if (not NWB.isLayered or not unit or UnitOnTaxi("player") or IsInInstance() or UnitInBattleground("player")) then
		return;
	end
	local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
	if ((NWB.faction == "Alliance" and zone == 1453) or (NWB.faction == "Horde" and zone == 1454)) then
		return;
	end
	local GUID = UnitGUID(unit);
	local unitType, zoneID, npcID;
	if (GUID) then
		unitType, _, _, _, zoneID, npcID = strsplit("-", GUID);
	end
	if (unitType ~= "Creature" or NWB.companionCreatures[tonumber(npcID)]) then
		--NWB:debug("not a creature");
		return;
	end
	if (not zoneID) then
		NWB:debug("no zone id");
		return;
	end
	zoneID = tonumber(zoneID);
	--If in Felwood and within the first few minutes after logon set the backup zoneID for songflowers.
	if (zone == 1448 and (GetServerTime() - logonEnteringWorld) < NWB.lastKnownLayerMapIDBackupValidFor) then
		--Most people logon at the songflower in the last few seconds, if they are grouped it will fail before because they had no lastKnownLayerMapID.
		--If we log on at a songflower and target a npc then skip the group join check and set this backup layermap zoneid to only use for songflowers.
		--This way we can set a songflower timer within the logon cooldown before you can change layers.
		--We set NWB.lastKnownLayerMapIDBackup to nil shortly after logon so it can't be used again.
		if (NWB.lastKnownLayerMapIDBackup == 0) then
			for k, v in pairs(NWB.data.layers) do
				if (v.layerMap and next(v.layerMap)) then
					for zID, map in pairs(v.layerMap) do
						--Check both zoneid and mapid, so we don't get data from old layers after server restart both must match.
						if (zID == zoneID and zone == map) then
							--Only set this backup for songflowers if they were already in a group at logon.
							--Joining a group right after logon should ignore this player for setting a songflower timer for the next few mins for layer swapping
							--if ((NWB.lastJoinedGroup - logonEnteringWorld) < 5) then
								NWB.lastKnownLayerMapIDBackup = k;
							--end
						end
					end
				end
			end
		end
	end
	if ((GetServerTime() - NWB.lastJoinedGroup) < NWB.lastJoinedGroupCooldown) then
		--Still recalc layer frame to display layer, just don't record any new stuff.
		NWB:recalcMinimapLayerFrame(zoneID);
		--NWB:debug("recently joined group, not recording");
		return;
	end
	--Only start mapping if we have come from org/stormwind and know our layer already.
	--And only start mapping if we haven't joined a group since leaving org.
	if (NWB.lastKnownLayerMapID < 1) then
		local foundOldID;
		--if ((GetServerTime() - NWB.lastJoinedGroup) > 180) then
			for k, v in pairs(NWB.data.layers) do
				if (v.layerMap and next(v.layerMap)) then
					for zID, map in pairs(v.layerMap) do
						--if (zone == zoneID) then
						--Check both zoneid and mapid, so we don't get data from old layers after server restart both must match.
						--if (zID == zoneID and zone == map) then
						if (zID == zoneID and (zone == map or GetZoneText() == L["Blackrock Mountain"])) then
							--Also can start mapping if we pickup our current layer from an already known id.
							--NWB:debug("found mapped id");
							NWB.lastKnownLayerMapID = k;
							foundOldID = true;
						end
					end
				end
			end
		--end
		if (not foundOldID or NWB.lastKnownLayerMapID < 1) then
			return;
		end
	end
	--Don't map a new zone if it's a guard outside capital city with the city zoneid.
	if (zoneID == NWB.lastKnownLayerMapID) then
		NWB:debug("trying to map zone to already known layer");
		return;
	end
	if ((NWB.faction == "Horde" and npcID == "68") or
			(NWB.faction == "Alliance" and npcID == "3296")) then
		--Guards outside opposite factions city can record the wrong mapid if targeting before you enter.
		return;
	end
	if (NWB.data.layers[NWB.lastKnownLayerMapID]) then
		if (not NWB.data.layers[NWB.lastKnownLayerMapID].layerMap) then
			--Create layer map if doesn't exist.
			NWB.data.layers[NWB.lastKnownLayerMapID].layerMap = {};
			NWB.data.layers[NWB.lastKnownLayerMapID].layerMap.created = GetServerTime();
		end
		if (not NWB.data.layers[NWB.lastKnownLayerMapID].layerMap[zoneID]) then
			for k, v in pairs(NWB.data.layers) do
				--if (v.layerMap and v.layerMap[zoneID]) then
				if (v.layerMap) then
					for kk, vv in pairs(v.layerMap) do
						if (kk == zoneID) then
							--If we already have this zoneid in any layer then don't overwrite it.
							if (k == NWB.lastKnownLayerMapID) then
								NWB:debug("zoneid already known for another layer", k);
							else
								NWB:debug("zoneid already known for this layer");
							end
							return;
						end
					end
				end
			end
			for k, v in pairs(NWB.data.layers[NWB.lastKnownLayerMapID].layerMap) do
				if (v == zone) then
					--If we already have a zoneid with this mapid then don't overwrite it.
					--NWB:debug("mapid already known");
					return;
				end
			end
			if (NWB.layerMapWhitelist[zone] and NWB:validateZoneID(zoneID, NWB.lastKnownLayerMapID, zone)) then
				--If zone is not mapped yet since server restart then add it.
				NWB:debug("mapped new zone to layer id", NWB.lastKnownLayerMapID, "zoneid:", zoneID, "zone:", zone);
				NWB.data.layers[NWB.lastKnownLayerMapID].layerMap[zoneID] = zone;
				NWB:sendData("GUILD");
			end
		else
			--NWB:debug("zoneid already known");
		end
	end
	NWB:recalcMinimapLayerFrame();
end

function NWB:validateZoneID(zoneID, layerID, mapID)
	local blackList = {
	};
	--Doing some tests on my realm to allow these higher zoneid's.
	--if (NWB.realm ~= "Arugal" and tonumber(zoneID) and tonumber(zoneID) > 10000) then
		--Azshara (128144) I don't know where tf a zoneid this high came from, but it was recorded.
		--Edit same number recorded again in Azshara after data reset (same week though).
		--Some kinda subzone there with same mapid? Seen this in a few different zones now.
		--Blasted Lands (814) Feralas (966) Mulgore (12138) Durotar (101136)
		--Legit layers can appear with higher than 10,000 zoneid if created later in the week.
		--Need a better way to handle these fake layers so I can allow legit high layers at some point.
		--return;
	--end
	if (layerID) then
		for k, v in pairs(NWB.data.layers[layerID].layerMap) do
			if (mapID and mapID == v) then
				--If we already have a zoneid with this mapid then don't overwrite it.
				--NWB:debug("mapid already known");
				return;
			end
		end
	end
	if (NWB.data.layers[zoneID]) then
		--Found a bug where layer 2 mapped Durotar to org zoneid from layer 1.
		--Not sure why it happened but now we'll check if the capital city id's already exist.
		return;
	end
	return true;
end

--Remove duplicate higher zones, see notes on above function validateZoneID().
	function NWB:fixLayermaps()

	end
	
	function NWB:resetLayerMaps()
	if (NWB.db.global.resetLayerMaps) then
		if (next(NWB.data.layers)) then
			for k, v in pairs(NWB.data.layers) do
				NWB.data.layers[k].layerMap = nil;
			end
		end
		NWB.db.global.resetLayerMaps = false;
	end
	--Theres a less than 1% chance each week to get the same layer id as last week.
	--If it happe then a layermap not reset and last weeks layermap will be kept for this week.
	--This just a fix for certain realms sometimes until I work out a way to auto deal with this issue.
	--[[if (NWB.db.global.wipeSingleLayer) then
		if (GetRealmName() == "Arugal" and NWB.data.layers and NWB.data.layers[130]) then
			NWB.data.layers[130].layerMap = nil;
		end
		NWB.db.global.wipeSingleLayer = false;
	end]]
end

--Version guild display.
local NWBLayerMapFrame = CreateFrame("ScrollFrame", "NWBLayerMapFrame", UIParent, "InputScrollFrameTemplate");
NWBLayerMapFrame:Hide();
NWBLayerMapFrame:SetToplevel(true);
NWBLayerMapFrame:SetMovable(true);
NWBLayerMapFrame:EnableMouse(true);
tinsert(UISpecialFrames, "NWBLayerMapFrame");
NWBLayerMapFrame:SetPoint("CENTER", UIParent, 0, 100);
NWBLayerMapFrame:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8",insets = {top = 0, left = 0, bottom = 0, right = 0}});
NWBLayerMapFrame:SetBackdropColor(0,0,0,.6);
NWBLayerMapFrame.CharCount:Hide();
NWBLayerMapFrame:SetFrameStrata("HIGH");
NWBLayerMapFrame.EditBox:SetAutoFocus(false);
NWBLayerMapFrame.EditBox:SetScript("OnKeyDown", function(self, arg)
	--If control key is down keep focus for copy/paste to work.
	--Otherwise remove focus so "enter" can be used to open chat and not have a stuck cursor on this edit box.
	if (not IsControlKeyDown()) then
		NWBLayerMapFrame.EditBox:ClearFocus();
	end
end)
NWBLayerMapFrame.EditBox:SetScript("OnShow", function(self, arg)
	NWBLayerMapFrame:SetVerticalScroll(0);
end)
local layerMapUpdateTime = 0;
NWBLayerMapFrame:HookScript("OnUpdate", function(self, arg)
	--Only update once per second.
	if (GetServerTime() - layerMapUpdateTime > 0 and self:GetVerticalScrollRange() == 0) then
		NWB:recalclayerFrame();
		layerMapUpdateTime = GetServerTime();
	end
end)
NWBLayerMapFrame.fs = NWBLayerMapFrame:CreateFontString("NWBLayerMapFrameFS", "HIGH");
NWBLayerMapFrame.fs:SetPoint("TOP", 0, -0);
NWBLayerMapFrame.fs:SetFont(NWB.regionFont, 14);
NWBLayerMapFrame.fs:SetText(L["|cFFFFFF00Layer Mapping for "] .. GetRealmName() .. "|r");

local NWBLayerMapDragFrame = CreateFrame("Frame", "NWBLayerMapDragFrame", NWBLayerMapFrame);
NWBLayerMapDragFrame:SetToplevel(true);
NWBLayerMapDragFrame:EnableMouse(true);
NWBLayerMapDragFrame:SetWidth(205);
NWBLayerMapDragFrame:SetHeight(38);
NWBLayerMapDragFrame:SetPoint("TOP", 0, 4);
NWBLayerMapDragFrame:SetFrameLevel(131);
NWBLayerMapDragFrame.tooltip = CreateFrame("Frame", "NWBLayerMapDragTooltip", NWBLayerMapDragFrame, "TooltipBorderedFrameTemplate");
NWBLayerMapDragFrame.tooltip:SetPoint("CENTER", NWBLayerMapDragFrame, "TOP", 0, 12);
NWBLayerMapDragFrame.tooltip:SetFrameStrata("TOOLTIP");
NWBLayerMapDragFrame.tooltip:SetFrameLevel(9);
NWBLayerMapDragFrame.tooltip:SetAlpha(.8);
NWBLayerMapDragFrame.tooltip.fs = NWBLayerMapDragFrame.tooltip:CreateFontString("NWBLayerMapDragTooltipFS", "HIGH");
NWBLayerMapDragFrame.tooltip.fs:SetPoint("CENTER", 0, 0.5);
NWBLayerMapDragFrame.tooltip.fs:SetFont(NWB.regionFont, 12);
NWBLayerMapDragFrame.tooltip.fs:SetText(L["Hold to drag"]);
NWBLayerMapDragFrame.tooltip:SetWidth(NWBLayerMapDragFrame.tooltip.fs:GetStringWidth() + 16);
NWBLayerMapDragFrame.tooltip:SetHeight(NWBLayerMapDragFrame.tooltip.fs:GetStringHeight() + 10);
NWBLayerMapDragFrame:SetScript("OnEnter", function(self)
	NWBLayerMapDragFrame.tooltip:Show();
end)
NWBLayerMapDragFrame:SetScript("OnLeave", function(self)
	NWBLayerMapDragFrame.tooltip:Hide();
end)
NWBLayerMapDragFrame.tooltip:Hide();
NWBLayerMapDragFrame:SetScript("OnMouseDown", function(self, button)
	if (button == "LeftButton" and not self:GetParent().isMoving) then
		self:GetParent().EditBox:ClearFocus();
		self:GetParent():StartMoving();
		self:GetParent().isMoving = true;
		--self:GetParent():SetUserPlaced(false);
	end
end)
NWBLayerMapDragFrame:SetScript("OnMouseUp", function(self, button)
	if (button == "LeftButton" and self:GetParent().isMoving) then
		self:GetParent():StopMovingOrSizing();
		self:GetParent().isMoving = false;
	end
end)
NWBLayerMapDragFrame:SetScript("OnHide", function(self)
	if (self:GetParent().isMoving) then
		self:GetParent():StopMovingOrSizing();
		self:GetParent().isMoving = false;
	end
end)

--Top right X close button.
local NWBLayerMapFrameClose = CreateFrame("Button", "NWBLayerMapFrameClose", NWBLayerMapFrame, "UIPanelCloseButton");
NWBLayerMapFrameClose:SetPoint("TOPRIGHT", -5, 8.6);
NWBLayerMapFrameClose:SetWidth(31);
NWBLayerMapFrameClose:SetHeight(31);
NWBLayerMapFrameClose:SetScript("OnClick", function(self, arg)
	NWBLayerMapFrame:Hide();
end)

function NWB:openLayerMapFrame()
	if (not NWB.isLayered) then
		return;
	end
	NWBLayerMapFrame.fs:SetFont(NWB.regionFont, 14);
	if (NWBLayerMapFrame:IsShown()) then
		NWBLayerMapFrame:Hide();
	else
		NWBLayerMapFrame:SetHeight(300);
		NWBLayerMapFrame:SetWidth(450);
		local fontSize = false
		NWBLayerMapFrame.EditBox:SetFont(NWB.regionFont, 14);
		NWBLayerMapFrame.EditBox:SetWidth(NWBLayerMapFrame:GetWidth() - 30);
		NWBLayerMapFrame:Show();
		NWB:recalcLayerMapFrame()
		--Changing scroll position requires a slight delay.
		--Second delay is a backup.
		C_Timer.After(0.05, function()
			NWBLayerMapFrame:SetVerticalScroll(0);
		end)
		C_Timer.After(0.3, function()
			NWBLayerMapFrame:SetVerticalScroll(0);
		end)
		--So interface options and this frame will open on top of each other.
		if (InterfaceOptionsFrame:IsShown()) then
			NWBLayerMapFrame:SetFrameStrata("DIALOG")
		else
			NWBLayerMapFrame:SetFrameStrata("HIGH")
		end
	end
end

function NWB:recalcLayerMapFrame()
	NWBLayerMapFrame.EditBox:SetText("\n");
	if (not NWB.data.layers or type(NWB.data.layers) ~= "table" or not next(NWB.data.layers)) then
		NWBLayerMapFrame.EditBox:Insert(L["|cffFFFF00No zones have been mapped yet since server restart.\n"]);
	else
		local count = 0;
		for k, v in NWB:pairsByKeys(NWB.data.layers) do
			count = count + 1;
			local zoneCount = 0;
			local text = "";
			if (v.layerMap and next(v.layerMap)) then
				if (v.layerMap.created) then
					--Remove "created" timestamp from layerMap, it's imported from layerMapBackups.
					--I'll change it so the timestamp isn't imported and this check can be removed later.
					v.layerMap.created = nil;
				end
				for kk, vv in NWB:pairsByKeys(v.layerMap) do
					zoneCount = zoneCount + 1;
					local mapInfo = C_Map.GetMapInfo(vv);
					local zoneInfo = "Unknown";
					if (mapInfo and next(mapInfo)) then
						zoneInfo = mapInfo.name;
					end
					---NWBLayerMapFrame.EditBox:Insert("  -|cffFFFF00" .. zoneInfo .. " ".. kk .. " |cff9CD6DE" .. vv .. "\n");
					text = text .. "  -|cffFFFF00" .. zoneInfo .. " |cFF989898(" .. kk .. ")|r\n";
				end
			else --C_Map.GetAreaInfo(
			--C_Map.GetMapInfoAtPosition(1434, 1, 1)
			text = text .. L["  -|cffFFFF00No zones mapped for this layer yet.\n"];
			end
			if (NWB.faction == "Horde") then
				NWBLayerMapFrame.EditBox:Insert(L["\n|cff00ff00[Layer "] .. count .. L["]|r  |cff9CD6DE(Orgrimmar "] .. k .. ")|r  "
						.. NWB.prefixColor .. "(" .. zoneCount .. L[" zones mapped)|r\n"] .. text);
			else
				NWBLayerMapFrame.EditBox:Insert(L["\n|cff00ff00[Layer "] .. count .. L["]|r  |cff9CD6DE(Stormwind "] .. k .. ")|r  "
						.. NWB.prefixColor .. "(" .. zoneCount .. L[" zones mapped)|r\n"] .. text);
			end
		end
	end
end

--Reset layers one time, needed when upgrading from old version.
--Old version copys over the whole table from new version users and prevents a proper new layer being created with that id.
function NWB:resetLayerData()
	if (NWB.db.global.resetLayers4) then
		NWB:debug("resetting layer data");
		NWB.data.layers = {};
		NWB.db.global.resetLayers4 = false;
	end
end

function NWB:fixAllLayers()
	for k, v in pairs(NWB.data.layers) do
		if (type(k) == "number") then
			NWB:fixLayer(k);
		else
			--On very rare occasions the layer id is saved as a string not a number, fix it here.
			--I found why this happens and fixed it, but this check stays here to fix existing databases.
			NWB.data.layers[k] = nil;
		end
	end
end

function NWB:fixLayer(layer)
	if (not tonumber(NWB.data.layers[layer]['rendTimer'])) then
		NWB.data.layers[layer]['rendTimer'] = 0;
	end
	if (not tonumber(NWB.data.layers[layer]['rendYell'])) then
		NWB.data.layers[layer]['rendYell'] = 0;
	end
	if (not tonumber(NWB.data.layers[layer]['rendYell2'])) then
		NWB.data.layers[layer]['rendYell2'] = 0;
	end
	if (not tonumber(NWB.data.layers[layer]['onyTimer'])) then
		NWB.data.layers[layer]['onyTimer'] = 0;
	end
	if (not tonumber(NWB.data.layers[layer]['onyYell'])) then
		NWB.data.layers[layer]['onyYell'] = 0;
	end
	if (not tonumber(NWB.data.layers[layer]['onyYell2'])) then
		NWB.data.layers[layer]['onyYell2'] = 0;
	end
	if (not tonumber(NWB.data.layers[layer]['nefTimer'])) then
		NWB.data.layers[layer]['rendTimer'] = 0;
	end
	if (not tonumber(NWB.data.layers[layer]['nefYell'])) then
		NWB.data.layers[layer]['nefYell'] = 0;
	end
	if (not tonumber(NWB.data.layers[layer]['nefYell2'])) then
		NWB.data.layers[layer]['nefYell2'] = 0;
	end
	if (not tonumber(NWB.data.layers[layer]['lastSeenNPC'])) then
		NWB.data.layers[layer]['lastSeenNPC'] = 0;
	end
	if (not tonumber(NWB.data.layers[layer]['flower1'])) then
		NWB.data.layers[layer]['flower1'] = 0;
	end
	if (not tonumber(NWB.data.layers[layer]['flower2'])) then
		NWB.data.layers[layer]['flower2'] = 0;
	end
	if (not tonumber(NWB.data.layers[layer]['flower3'])) then
		NWB.data.layers[layer]['flower3'] = 0;
	end
	if (not tonumber(NWB.data.layers[layer]['flower4'])) then
		NWB.data.layers[layer]['flower4'] = 0;
	end
	if (not tonumber(NWB.data.layers[layer]['flower5'])) then
		NWB.data.layers[layer]['flower5'] = 0;
	end
	if (not tonumber(NWB.data.layers[layer]['flower6'])) then
		NWB.data.layers[layer]['flower6'] = 0;
	end
	if (not tonumber(NWB.data.layers[layer]['flower7'])) then
		NWB.data.layers[layer]['flower7'] = 0;
	end
	if (not tonumber(NWB.data.layers[layer]['flower8'])) then
		NWB.data.layers[layer]['flower8'] = 0;
	end
	if (not tonumber(NWB.data.layers[layer]['flower9'])) then
		NWB.data.layers[layer]['flower9'] = 0;
	end
	if (not tonumber(NWB.data.layers[layer]['flower10'])) then
		NWB.data.layers[layer]['flower10'] = 0;
	end
end

function NWB:validateLayer(layer)
	--Temp fix till I work out why sometimes the NPC zoneid is different by a few integers, it's strange....
	--In testing the zoneid's had the same last and first number, but middle numbers sometimes changed depending on person.
	--107 and 127 from same NPC by different people, --9914 and 9924 from same NPC by different people.
	--Ignore new data if it's within close numeric range of an ID we already have.
	--No 2 valid layers should ever have close together id's?
	--EDIT: From a user on curse layer numbers on Auberdine for this week are 315 and 326.
	--[[for localLayer, localV in pairs(NWB.data.layers) do
		if ((layer > (localLayer - 30)) and (layer < (localLayer + 30)) and localLayer ~= layer
				--Some realms seem to have legit layers close together.
				--Each fake close together layer I've seen so far has the same last number, it's always multiples of 10.
				--Removing the strict 30 closeness check and try this instead to accomodate those close together realms.
				--If it works it should atleast lower the chance of a false positive to 1 in 10.
				--Can't create new chars on these locked layered realms to test so all I can do is ake these small changes and hope...
				and (string.sub(layer, -1) == string.sub(localLayer, -1))) then
			NWB:debug("close range layer found old:", localLayer, "new:", layer);
			return;
		end
	end]]
	return true;
end

--Function to move first layer data to non-layered data when Blizzard removes layering on a realm.
--Not currently used anywhere but can be /run after updating to new version that removes layering for your realm.
function NWB:convertLayerToNonLayer()
	print(L["|cFFFFFF00Looking for layered timers to convert."])
	local found;
	if (NWB.data.layers) then
		for k, v in NWB:pairsByKeys(NWB.data.layers) do
			if (v.rendTimer and v.rendTimer > (GetServerTime() - NWB.db.global.rendRespawnTime)) then
				NWB.data.rendTimer = v.rendTimer;
				NWB.data.rendYell = v.rendYell or 0;
				print(L["|cFFFFFF00Found current Rend timer, converting."])
				found = true;
			end
			if (v.onyTimer and v.onyTimer > (GetServerTime() - NWB.db.global.onyRespawnTime)) then
				NWB.data.onyTimer = v.onyTimer;
				NWB.data.onyYell = v.onyYell or 0;
				NWB.data.onyNpcDied = v.onyNpcDied or 0;
				print(L["|cFFFFFF00Found current Onyxia timer, converting."])
				found = true;
			end
			if (v.nefTimer and v.nefTimer > (GetServerTime() - NWB.db.global.nefRespawnTime)) then
				NWB.data.nefTimer = v.nefTimer;
				NWB.data.nefYell = v.nefYell or 0;
				NWB.data.nefNpcDied = v.nefNpcDied or 0;
				print(L["|cFFFFFF00Found current Nefarian timer, converting."])
				found = true;
			end
			if (found) then
				print(L["|cFFFFFF00Done."])
			else
				print(L["|cFFFFFF00Done, found no timers on old layer 1."])
			end
			return;
		end
	end
end

--This pushes non-layered timers into the first layer we know.
--It's a debug only function and requires targeting a NPC in city first to create the layer.
--This is only so I can test layered stuff on my non-layered server.
function NWB:convertNonLayerToLayer()
	print(L["|cFFFFFF00Looking for layered timers to convert."])
	local found;
	if (NWB.data.layers) then
		for k, v in NWB:pairsByKeys(NWB.data.layers) do
			if (NWB.data.rendTimer and NWB.data.rendTimer > (GetServerTime() - NWB.db.global.rendRespawnTime)) then
				NWB.data.layers[k].rendTimer = NWB.data.rendTimer;
				NWB.data.layers[k].rendYell = NWB.data.rendYell or 0;
				print(L["|cFFFFFF00Found current Rend timer, converting."])
				found = true;
			end
			if (NWB.data.onyTimer and NWB.data.onyTimer > (GetServerTime() - NWB.db.global.onyRespawnTime)) then
				NWB.data.layers[k].onyTimer = NWB.data.onyTimer;
				NWB.data.layers[k].onyYell = NWB.data.onyYell or 0;
				NWB.data.layers[k].onyNpcDied = NWB.data.onyNpcDied or 0;
				print(L["|cFFFFFF00Found current Onyxia timer, converting."])
				found = true;
			end
			if (NWB.data.nefTimer and NWB.data.nefTimer > (GetServerTime() - NWB.db.global.nefRespawnTime)) then
				NWB.data.layers[k].nefTimer = NWB.data.nefTimer;
				NWB.data.layers[k].nefYell = NWB.data.nefYell or 0;
				NWB.data.layers[k].nefNpcDied = NWB.data.nefNpcDied or 0;
				print(L["|cFFFFFF00Found current Nefarian timer, converting."])
				found = true;
			end
			if (found) then
				print(L["|cFFFFFF00Done."])
			else
				print(L["|cFFFFFF00Done, found no timers on old layer 1."])
			end
			return;
		end
	end
end

--function NWB:validateLayer(layer)
--	return true;
--end
	
local MinimapLayerFrame = CreateFrame("Frame", "MinimapLayerFrame", Minimap, "ThinGoldEdgeTemplate");
MinimapLayerFrame:SetPoint("BOTTOM", 0, -21);
MinimapLayerFrame:SetFrameStrata("HIGH");
MinimapLayerFrame:SetFrameLevel(9);
MinimapLayerFrame:SetMovable(true);
MinimapLayerFrame.fs = MinimapLayerFrame:CreateFontString("MinimapLayerFrameFS", "ARTWORK");
MinimapLayerFrame.fs:SetPoint("CENTER", 0, 0);
MinimapLayerFrame.fs:SetFont(NWB.regionFont, 10); --No region font here, "Layer" in english always.
MinimapLayerFrame.fs:SetText(L["No Layer"]);
MinimapLayerFrame:SetWidth(46);
MinimapLayerFrame:SetHeight(17);
MinimapLayerFrame:Hide();
MinimapLayerFrame.tooltip = CreateFrame("Frame", "NWBVersionDragTooltip", MinimapLayerFrame, "TooltipBorderedFrameTemplate");
MinimapLayerFrame.tooltip:SetPoint("TOP", MinimapLayerFrame, "BOTTOM", 0, 0);
MinimapLayerFrame.tooltip:SetFrameStrata("TOOLTIP");
MinimapLayerFrame.tooltip:SetFrameLevel(9);
--MinimapLayerFrame.tooltip:SetAlpha(.9);
MinimapLayerFrame.tooltip.fs = MinimapLayerFrame.tooltip:CreateFontString("NWBVersionDragTooltipFS", "HIGH");
MinimapLayerFrame.tooltip.fs:SetPoint("CENTER", 0, 0.5);
MinimapLayerFrame.tooltip.fs:SetFont(NWB.regionFont, 10);
MinimapLayerFrame.tooltip.fs:SetText(L["Target a NPC to\nupdate your layer"]);
MinimapLayerFrame.tooltip:SetWidth(MinimapLayerFrame.tooltip.fs:GetStringWidth() + 10);
MinimapLayerFrame.tooltip:SetHeight(MinimapLayerFrame.tooltip.fs:GetStringHeight() + 10);
MinimapLayerFrame:SetScript("OnEnter", function(self)
	MinimapLayerFrame.tooltip:Show();
	if (NWB.db.global.minimapLayerHover) then
		MinimapLayerFrame:Show();
	end
end)
MinimapLayerFrame:SetScript("OnLeave", function(self)
	MinimapLayerFrame.tooltip:Hide();
	if (NWB.db.global.minimapLayerHover) then
		MinimapLayerFrame:Hide();
	end
end)
MinimapLayerFrame.tooltip:Hide();
MinimapLayerFrame:SetScript("OnMouseDown", function(self, button)
	if (button == "LeftButton" and not self.isMoving and IsShiftKeyDown()) then
		self:StartMoving();
		self.isMoving = true;
		--self:SetUserPlaced(false);
	else
		NWB:openLayerFrame();
	end
end)
MinimapLayerFrame:SetScript("OnMouseUp", function(self, button)
	if (button == "LeftButton" and self.isMoving) then
		self:StopMovingOrSizing();
		self.isMoving = false;
	end
end)
MinimapLayerFrame:SetScript("OnHide", function(self)
	if (self.isMoving) then
		self:StopMovingOrSizing();
		self.isMoving = false;
	end
end)
	
--zoneID only get passed to this function when we're on team join cooldown from NWB:mapCurrentLayer().
	NWB.currentLayer = 0;
	function NWB:recalcMinimapLayerFrame(zoneID)
		if ((GetServerTime() - NWB.lastJoinedGroup) < 5) then
			--Don't update minimap frame for a few seconds after joining group.
			NWB:toggleMinimapLayerFrame("hide");
			MinimapLayerFrame.fs:SetText("No Layer");
				return;
		end
		if (not NWB.db.global.minimapLayerFrame or not NWB.isLayered) then
			NWB:toggleMinimapLayerFrame("hide");
			MinimapLayerFrame.fs:SetText("No Layer");
			return;
	end
	local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
	local foundOldID, foundLayer;
	local count, layerNum = 0, 0;
	if (NWB.lastKnownLayerMapID > 0) then
		for k, v in NWB:pairsByKeys(NWB.data.layers) do
			count = count + 1;
			if (k == NWB.lastKnownLayerMapID) then
				NWBlayerFrame.fs2:SetText("|cFF9CD6DE" .. L["You are currently on"] .. " |cff00ff00[Layer " .. count .. "]|cFF9CD6DE.|r");
				NWB.currentLayer = count;
				NWB.lastKnownLayer = count;
				NWB.lastKnownLayerID = k;
				NWB.lastKnownLayerTime = GetServerTime();
				layerNum = count;
				foundLayer = true;
			end
		end
	end
	if (foundLayer or (NWB.faction == "Horde" and zone == 1454)
			or (NWB.faction == "Alliance" and zone == 1453)) then
		if (NWB.currentLayer > 0) then
			MinimapLayerFrame.fs:SetText(NWB.mmColor .. L["Layer "] .. NWB.lastKnownLayer);
			MinimapLayerFrame.fs:SetFont(NWB.regionFont, 12);
		elseif (layerNum > 0) then
			MinimapLayerFrame.fs:SetText(NWB.mmColor .. L["Layer "] .. layerNum);
			MinimapLayerFrame.fs:SetFont(NWB.regionFont, 12);
		else
			MinimapLayerFrame.fs:SetText(NWB.mmColor .. L["No Layer"]);
			MinimapLayerFrame.fs:SetFont(NWB.regionFont, 10);
		end
		--MinimapLayerFrame:SetWidth(MinimapLayerFrame.fs:GetStringWidth() + 12);
		--MinimapLayerFrame:SetHeight(MinimapLayerFrame.fs:GetStringHeight() + 12);
		MinimapLayerFrame:Show();
	else
		--If we just joined group and we're not currently recording NWB.lastKnownLayerMapID then use this as a backup to find the layer.
		--All this does is change the minimap layer frame text, this doesn't effect anything else or change any of the mapping variables.
		--This is a bit of a hacky fix to just tag a recalc on the end of the layer mapping system when on team join cooldown.
		--But layer mapping is working basically perfect right now and I don't want to rewrite it quite yet.
		local foundBackup;
		if (zoneID) then
			local backupCount = 0;
			for k, v in NWB:pairsByKeys(NWB.data.layers) do
				backupCount = backupCount + 1;
				if (v.layerMap and next(v.layerMap)) then
					for zone, map in pairs(v.layerMap) do
						if (zone == zoneID) then
							MinimapLayerFrame.fs:SetText(L["Layer "] .. backupCount);
							MinimapLayerFrame.fs:SetFont(NWB.regionFont, 12);
							foundBackup = true;
						end
					end
				end
			end
		end
		NWB.currentLayer = 0;
		if (foundBackup) then
			NWB:toggleMinimapLayerFrame("show");
		else
			NWB:toggleMinimapLayerFrame("hide");
		end
	end
end

--Minimap will show only when a layer is known,
--If user has minimapLayerHover enabled then it will only show when they hover the minimap with mouse.
--It will still only show when a layer is known on mouseover for the minimapLayerHover setting.
NWB.minimapLayerFrameState = nil;
function NWB:toggleMinimapLayerFrame(type)
	if (type == "show") then
		if (not NWB.db.global.minimapLayerHover) then
			MinimapLayerFrame:Show();
		end
		NWB.minimapLayerFrameState = true;
		else
			if (not NWB.db.global.minimapLayerHover) then
				MinimapLayerFrame:Hide();
		end
		NWB.minimapLayerFrameState = nil;
	end
end

Minimap:HookScript("OnEnter", function(self, arg)
	if (NWB.db.global.minimapLayerHover) then
		MinimapLayerFrame:Show();
	end
end)

Minimap:HookScript("OnLeave", function(self, arg)
	if (NWB.db.global.minimapLayerHover) then
		MinimapLayerFrame:Hide();
	end
end)

SLASH_NWBLAYERSCMD1, SLASH_NWBLAYERSCMD2 = '/layer', '/layers';
function SlashCmdList.NWBLAYERSCMD(msg, editBox)
	NWB:openLayerFrame();
end

--Version guild display.
local NWBVersionFrame = CreateFrame("ScrollFrame", "NWBVersionFrame", UIParent, "InputScrollFrameTemplate");
NWBVersionFrame:Hide();
NWBVersionFrame:SetToplevel(true);
NWBVersionFrame:SetMovable(true);
NWBVersionFrame:EnableMouse(true);
tinsert(UISpecialFrames, "NWBVersionFrame");
NWBVersionFrame:SetPoint("CENTER", UIParent, 0, 100);
NWBVersionFrame:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8",insets = {top = 0, left = 0, bottom = 0, right = 0}});
NWBVersionFrame:SetBackdropColor(0,0,0,.5);
NWBVersionFrame.CharCount:Hide();
NWBVersionFrame:SetFrameStrata("HIGH");
NWBVersionFrame.EditBox:SetAutoFocus(false);
NWBVersionFrame.EditBox:SetScript("OnKeyDown", function(self, arg)
	--If control key is down keep focus for copy/paste to work.
	--Otherwise remove focus so "enter" can be used to open chat and not have a stuck cursor on this edit box.
	if (not IsControlKeyDown()) then
		NWBVersionFrame.EditBox:ClearFocus();
	end
end)
NWBVersionFrame.EditBox:SetScript("OnShow", function(self, arg)
	NWBVersionFrame:SetVerticalScroll(0);
end)
local versionUpdateTime = 0;
NWBVersionFrame:HookScript("OnUpdate", function(self, arg)
	--Only update once per second.
	if (GetServerTime() - versionUpdateTime > 0 and self:GetVerticalScrollRange() == 0) then
		NWB:recalclayerFrame();
		versionUpdateTime = GetServerTime();
	end
end)
NWBVersionFrame.fs = NWBVersionFrame:CreateFontString("NWBVersionFrameFS", "HIGH");
NWBVersionFrame.fs:SetPoint("TOP", 0, -0);
NWBVersionFrame.fs:SetFont(NWB.regionFont, 14);
NWBVersionFrame.fs:SetText(L["|cFFFFFF00Guild versions seen since logon|r"]);

local NWBVersionDragFrame = CreateFrame("Frame", "NWBVersionDragFrame", NWBVersionFrame);
NWBVersionDragFrame:SetToplevel(true);
NWBVersionDragFrame:EnableMouse(true);
NWBVersionDragFrame:SetWidth(205);
NWBVersionDragFrame:SetHeight(38);
NWBVersionDragFrame:SetPoint("TOP", 0, 4);
NWBVersionDragFrame:SetFrameLevel(131);
NWBVersionDragFrame.tooltip = CreateFrame("Frame", "NWBVersionDragTooltip", NWBVersionDragFrame, "TooltipBorderedFrameTemplate");
NWBVersionDragFrame.tooltip:SetPoint("CENTER", NWBVersionDragFrame, "TOP", 0, 12);
NWBVersionDragFrame.tooltip:SetFrameStrata("TOOLTIP");
NWBVersionDragFrame.tooltip:SetFrameLevel(9);
NWBVersionDragFrame.tooltip:SetAlpha(.8);
NWBVersionDragFrame.tooltip.fs = NWBVersionDragFrame.tooltip:CreateFontString("NWBVersionDragTooltipFS", "HIGH");
NWBVersionDragFrame.tooltip.fs:SetPoint("CENTER", 0, 0.5);
NWBVersionDragFrame.tooltip.fs:SetFont(NWB.regionFont, 12);
NWBVersionDragFrame.tooltip.fs:SetText(L["Hold to drag"]);
NWBVersionDragFrame.tooltip:SetWidth(NWBVersionDragFrame.tooltip.fs:GetStringWidth() + 16);
NWBVersionDragFrame.tooltip:SetHeight(NWBVersionDragFrame.tooltip.fs:GetStringHeight() + 10);
NWBVersionDragFrame:SetScript("OnEnter", function(self)
	NWBVersionDragFrame.tooltip:Show();
end)
NWBVersionDragFrame:SetScript("OnLeave", function(self)
	NWBVersionDragFrame.tooltip:Hide();
end)
NWBVersionDragFrame.tooltip:Hide();
NWBVersionDragFrame:SetScript("OnMouseDown", function(self, button)
	if (button == "LeftButton" and not self:GetParent().isMoving) then
		self:GetParent().EditBox:ClearFocus();
		self:GetParent():StartMoving();
		self:GetParent().isMoving = true;
		--self:GetParent():SetUserPlaced(false);
	end
end)
NWBVersionDragFrame:SetScript("OnMouseUp", function(self, button)
	if (button == "LeftButton" and self:GetParent().isMoving) then
		self:GetParent():StopMovingOrSizing();
		self:GetParent().isMoving = false;
	end
end)
NWBVersionDragFrame:SetScript("OnHide", function(self)
	if (self:GetParent().isMoving) then
		self:GetParent():StopMovingOrSizing();
		self:GetParent().isMoving = false;
	end
end)

--Top right X close button.
local NWBVersionFrameClose = CreateFrame("Button", "NWBVersionFrameClose", NWBVersionFrame, "UIPanelCloseButton");
NWBVersionFrameClose:SetPoint("TOPRIGHT", -5, 8.6);
NWBVersionFrameClose:SetWidth(31);
NWBVersionFrameClose:SetHeight(31);
NWBVersionFrameClose:SetScript("OnClick", function(self, arg)
	NWBVersionFrame:Hide();
end)

function NWB:openVersionFrame()
	NWBVersionFrame.fs:SetFont(NWB.regionFont, 14);
	if (NWBVersionFrame:IsShown()) then
		NWBVersionFrame:Hide();
	else
		NWBVersionFrame:SetHeight(300);
		NWBVersionFrame:SetWidth(450);
		local fontSize = false
		NWBVersionFrame.EditBox:SetFont(NWB.regionFont, 14);
		NWBVersionFrame.EditBox:SetWidth(NWBVersionFrame:GetWidth() - 30);
		NWBVersionFrame:Show();
		NWB:recalcVersionFrame();
		--Changing scroll position requires a slight delay.
		--Second delay is a backup.
		C_Timer.After(0.05, function()
			NWBVersionFrame:SetVerticalScroll(0);
		end)
		C_Timer.After(0.3, function()
			NWBVersionFrame:SetVerticalScroll(0);
		end)
		--So interface options and this frame will open on top of each other.
		if (InterfaceOptionsFrame:IsShown()) then
			NWBVersionFrame:SetFrameStrata("DIALOG")
		else
			NWBVersionFrame:SetFrameStrata("HIGH")
		end
	end
end

function NWB:recalcVersionFrame()
	NWBVersionFrame.EditBox:SetText("\n\n");
	if (not IsInGuild()) then
		NWBVersionFrame.EditBox:Insert(L["|cffFFFF00You have no guild, this command shows guild members only.\n"]);
	else
		GuildRoster();
		local numTotalMembers = GetNumGuildMembers();
		local onlineMembers = {};
		local me = UnitName("player") .. "-" .. GetNormalizedRealmName();
		local sorted = {};
		local guild = {};
		for i = 1, numTotalMembers do
			local name, _, _, _, _, zone, _, _, online, _, _, _, _, isMobile = GetGuildRosterInfo(i);
			name = string.gsub(string.gsub(name, "'", ""), " ", "");
			guild[name] = true;
		end
		for k, v in pairs(NWB.hasAddon) do
			if (not sorted[v]) then
				sorted[v] = {};
			end
			if (guild[k]) then
				local who, realm = strsplit("-", k, 2);
				sorted[v][who] = true;
			end
		end
		for k, v in NWB:pairsByKeys(sorted) do
			for kk, vv in NWB:pairsByKeys(v) do
				if (tonumber(k) > 0 or NWB.isDebug) then
					NWBVersionFrame.EditBox:Insert("|cffFFFF00" .. k .. " |cff9CD6DE" .. kk .. "\n");
				end
			end
		end
	end
end

--NPC events
local f = CreateFrame("Frame");
f:RegisterEvent("GOSSIP_SHOW");
f:SetScript('OnEvent', function(self, event, ...)
	if (event == "GOSSIP_SHOW") then
		local g1, type1, g2, type2, g3, type3, g4, type4, g5, type5, g6, type6, g7, type7, g8, type8 = GetGossipOptions();
		local npcGUID = UnitGUID("npc");
		local npcID;
		if (npcGUID) then
			_, _, _, _, _, npcID = strsplit("-", npcGUID);
		end
		if (not g1 or not npcID) then
			return;
		end
		if (npcID == "14822" and NWB.db.global.autoDmfBuff) then --Sayge NPC.
			--This string check was added first for english clients then the non-string check version further down added later.
			--I'll keep this string check version for english here anyway though because it's 100% accurate.
			--The non-string check version is new and in testing, but should work fine.
			if (GetLocale() == "enUS") then
				--Make this an option to skip the fortune cookie later.
				--[[if (string.match(g1, "I'd love to get one of those written fortunes you mentioned")) then
					return
				end
				if (string.match(g1, "I am ready to discover where my fortune lies!")) then
					SelectGossipOption(1);
					return;
				end]]
				if (g1 and not g2) then
					--Pages with only 1 option.
					SelectGossipOption(1);
				end
			if (NWB.db.global.autoDmfBuffType == "Damage") then
				--Sayge's Dark Fortune of Damage: +10% Damage (1, 1).
				SelectGossipOption(1);
				--No need for string checks for dmg, it's 1, 1.
				--[[if (string.match(g1, "I slay the man on the spot as my liege would expect me to do")) then
					SelectGossipOption(1);
				elseif (string.match(g1, "and do it in such a manner that he suffers painfully before he dies")) then
					SelectGossipOption(1);
				end]]
				return;
			end
			if (NWB.db.global.autoDmfBuffType == "Agility") then
				--Sayge's Dark Fortune of Agility: +10% Agility (3, 3).
				if (g3 and string.match(g3, "I confiscate the corn he has stolen, warn him that stealing is a path towards doom")) then
					SelectGossipOption(3);
				elseif (g3 and string.match(g3, "I would create some surreptitious means to keep my brother out of the order")) then
					SelectGossipOption(3);
				end
				return;
			end
			if (NWB.db.global.autoDmfBuffType == "Intelligence") then
				--Sayge's Dark Fortune of Intelligence: +10% Intelligence (2, 2).
				if (g2 and string.match(g2, "I turn over the man to my liege for punishment, as he has broken the law of the land")) then
					SelectGossipOption(2);
				elseif (g2 and string.match(g2, "ignore the insult, hoping to instill a fear in the ruler that he may have gaffed")) then
					SelectGossipOption(2);
				end
				return;
			end
			if (NWB.db.global.autoDmfBuffType == "Spirit") then
				--Sayge's Dark Fortune of Spirit: +10% Spirit (2, 1).
				if (g2 and string.match(g2, "I turn over the man to my liege for punishment, as he has broken the law of the land")) then
					SelectGossipOption(2);
				elseif (string.match(g1, "I confront the ruler on his malicious behavior, upholding my")) then
					SelectGossipOption(1);
				end
				return;
			end
			if (NWB.db.global.autoDmfBuffType == "Stamina") then
				--Sayge's Dark Fortune of Stamina: +10% Stamina (3, 1).
				if (g3 and string.match(g3, "I confiscate the corn he has stolen, warn him that stealing is a path towards doom")) then
					SelectGossipOption(3);
				elseif (string.match(g1, "I would speak against my brother joining the order, rushing a permanent breech")) then
					SelectGossipOption(1);
				end
				return;
			end
			if (NWB.db.global.autoDmfBuffType == "Strength") then
				--Sayge's Dark Fortune of Strength: +10% Strength (3, 2).
				if (g3 and string.match(g3, "I confiscate the corn he has stolen, warn him that stealing is a path towards doom")) then
					SelectGossipOption(3);
				elseif (g2 and string.match(g2, "I would speak for my brother joining the order, potentially risking the safety of the order")) then
					SelectGossipOption(2);
				end
				return;
			end
			if (NWB.db.global.autoDmfBuffType == "Armor") then
				--Sayge's Dark Fortune of Armor: +10% Armor (1, 3).
				if (string.match(g1, "I slay the man on the spot as my liege would expect me to do")) then
					SelectGossipOption(1);
				elseif (string.match(g3 and g3, "I risk my own life and free him so that he may prove his innocence")) then
					SelectGossipOption(3);
				end
				return;
			end
		if (NWB.db.global.autoDmfBuffType == "Resistance") then
				--Sayge's Dark Fortune of Resistance: +25 All Resistances (1, 2).
				if (string.match(g1, "I slay the man on the spot as my liege would expect me to do")) then
					SelectGossipOption(1);
				elseif (g2 and string.match(g2, "I execute him as per my liege's instructions, but doing so in as painless")) then
					SelectGossipOption(2);
				end
				return;
			end
		else
			--This should probably be done with a table instead of if statements, but it's small and only ran twice a month so whatever.
			if (g4) then
				--First buff selection page has 4 options, if there's 4 it can only be this page.
				if (NWB.db.global.autoDmfBuffType == "Damage") then
					--Sayge's Dark Fortune of Damage: +10% Damage (1, 1).
					SelectGossipOption(1);
					return;
				end
				if (NWB.db.global.autoDmfBuffType == "Agility") then
					--Sayge's Dark Fortune of Agility: +10% Agility (3, 3).
					SelectGossipOption(3);
					return;
				end
				if (NWB.db.global.autoDmfBuffType == "Intelligence") then
					--Sayge's Dark Fortune of Intelligence: +10% Intelligence (2, 2).
					SelectGossipOption(2);
					return;
				end
				if (NWB.db.global.autoDmfBuffType == "Spirit") then
					--Sayge's Dark Fortune of Spirit: +10% Spirit (2, 1).
					SelectGossipOption(2);
					return;
				end
				if (NWB.db.global.autoDmfBuffType == "Stamina") then
					--Sayge's Dark Fortune of Stamina: +10% Stamina (3, 1).
					SelectGossipOption(3);
					return;
				end
				if (NWB.db.global.autoDmfBuffType == "Strength") then
					--Sayge's Dark Fortune of Strength: +10% Strength (3, 2).
					SelectGossipOption(3);
					return;
				end
				if (NWB.db.global.autoDmfBuffType == "Armor") then
					--Sayge's Dark Fortune of Armor: +10% Armor (1, 3).
					SelectGossipOption(1);
					return;
				end
				if (NWB.db.global.autoDmfBuffType == "Resistance") then
					--Sayge's Dark Fortune of Resistance: +25 All Resistances (1, 2).
					SelectGossipOption(1);
					return;
				end
			elseif (g3) then
				--Second buff selection page has 3 options, if there's 3 it can only be this page.
				if (NWB.db.global.autoDmfBuffType == "Damage") then
					--Sayge's Dark Fortune of Damage: +10% Damage (1, 1).
					SelectGossipOption(1);
					return;
				end
				if (NWB.db.global.autoDmfBuffType == "Agility") then
					--Sayge's Dark Fortune of Agility: +10% Agility (3, 3).
					SelectGossipOption(3);
					return;
				end
				if (NWB.db.global.autoDmfBuffType == "Intelligence") then
					SelectGossipOption(2);
					return;
				end
				if (NWB.db.global.autoDmfBuffType == "Spirit") then
					--Sayge's Dark Fortune of Spirit: +10% Spirit (2, 1).
					SelectGossipOption(1);
					return;
				end
				if (NWB.db.global.autoDmfBuffType == "Stamina") then
					--Sayge's Dark Fortune of Stamina: +10% Stamina (3, 1).
					SelectGossipOption(1);
					return;
				end
				if (NWB.db.global.autoDmfBuffType == "Strength") then
					--Sayge's Dark Fortune of Strength: +10% Strength (3, 2).
					SelectGossipOption(2);
					return;
				end
				if (NWB.db.global.autoDmfBuffType == "Armor") then
					--Sayge's Dark Fortune of Armor: +10% Armor (1, 3).
					SelectGossipOption(3);
					return;
				end
				if (NWB.db.global.autoDmfBuffType == "Resistance") then
					--Sayge's Dark Fortune of Resistance: +25 All Resistances (1, 2).
					SelectGossipOption(2);
					return;
				end
			elseif (g1 and not g2) then
				--Pages with only 1 option.
				SelectGossipOption(1);
			end
			--NWB:print("Auto DMF buff selection only works for English client sorry, other languages coming soon.");
		end
	end
		---I have removed string checks for everything below here to make it work for all regions from the start.
		---They only ever have the 1 chat option so it should be safe.
		if (NWB.db.global.autoDireMaulBuff) then
			--if (npcID == "14326" and string.match(g1, "What have you got for me")) then --Guard Mol'dar.
			if (npcID == "14326") then --Guard Mol'dar.
				SelectGossipOption(1);
				return;
			--elseif (npcID == "14321" and string.match(g1, "Well what have you got for the new big dog of Gordok")) then --Guard Fengus.
			elseif (npcID == "14321") then --Guard Fengus.
				SelectGossipOption(1);
				return;
			--elseif (npcID == "14323" and string.match(g1, "Yeah, you're a real brainiac")) then --Guard Slip'kik.
			elseif (npcID == "14323") then --Guard Slip'kik.
				SelectGossipOption(1);
				return;
			--elseif (npcID == "14353" and string.match(g1, "I'm the new king")) then --Mizzle the Crafty.
			elseif (npcID == "14353") then --Mizzle the Crafty.
				SelectGossipOption(1);
				return;
			elseif (npcID == "14325" and string.match(g1, "Um, I'm taking some prisoners")) then --Captain Komcrush.
				--This needs string check because he can give you a quest afterwards also.
				--elseif (npcID == "14325") then --Captain Komcrush.
					SelectGossipOption(1);
					return;
				end
		end
		if (NWB.db.global.autoBwlPortal) then
			--Orb of command GameObject-0-4671-0-29-179879-00005F974A
			--if (npcID == "179879" and string.match(g1, "Place my hand on the orb")) then
			if (npcID == "179879") then
				SelectGossipOption(1);
				return;
			end
		end
	end
end)