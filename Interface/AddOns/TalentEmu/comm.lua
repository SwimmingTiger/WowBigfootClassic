--[[--
	by ALA @ 163UI
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

-->		upvalue
	local time = time;
	local type = type;
	local strsub, strsplit, strmatch, gsub = string.sub, string.split, string.match, string.gsub;
	local UnitInBattleground = UnitInBattleground;
	local RegisterAddonMessagePrefix = RegisterAddonMessagePrefix or C_ChatInfo.RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = IsAddonMessagePrefixRegistered or C_ChatInfo.IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = GetRegisteredAddonMessagePrefixes or C_ChatInfo.GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = SendAddonMessage or C_ChatInfo.SendAddonMessage;
	local SendAddonMessageLogged = SendAddonMessageLogged or C_ChatInfo.SendAddonMessageLogged;
	local Ambiguate = Ambiguate;
	local CreateFrame = CreateFrame;
	local _G = _G;
	local ChatFrame_AddMessageEventFilter = ChatFrame_AddMessageEventFilter;
	local ChatEdit_ChooseBoxForSend = ChatEdit_ChooseBoxForSend;
	local ChatFrame_MessageEventHandler = ChatFrame_MessageEventHandler;
	local UIParent = UIParent;
	local ItemRefTooltip = ItemRefTooltip;
	local ChatFrame2 = ChatFrame2;

-->
	local L = CT.L;

-->		constant
-->
MT.BuildEnv('COMM');
-->		predef
	local _TempSavedCommTalents = {  };
-->		COMM
	local ADDON_PREFIX = VT.__emulib.ADDON_PREFIX;
	local ADDON_MSG_CONTROL_CODE_LEN = VT.__emulib.ADDON_MSG_CONTROL_CODE_LEN;
	--
	local ADDON_MSG_QUERY_TALENTS = VT.__emulib.ADDON_MSG_QUERY_TALENTS;
	local ADDON_MSG_REPLY_TALENTS = VT.__emulib.ADDON_MSG_REPLY_TALENTS;
	--
	local ADDON_MSG_QUERY_EQUIPMENTS = VT.__emulib.ADDON_MSG_QUERY_EQUIPMENTS;
	local ADDON_MSG_REPLY_EQUIPMENTS = VT.__emulib.ADDON_MSG_REPLY_EQUIPMENTS;
	local ADDON_MSG_REPLY_ADDON_PACK = VT.__emulib.ADDON_MSG_REPLY_ADDON_PACK;
	--
	local ADDON_MSG_PUSH = VT.__emulib.ADDON_MSG_PUSH;
	local ADDON_MSG_PUSH_RECV = VT.__emulib.ADDON_MSG_PUSH_RECV;
	-- local ADDON_MSG_PULL = VT.__emulib.ADDON_MSG_PULL;
	--
	-- local ADDON_MSG_QUERY_TALENTS_ = VT.__emulib.ADDON_MSG_QUERY_TALENTS_;
	local ADDON_MSG_REPLY_TALENTS_ = VT.__emulib.ADDON_MSG_REPLY_TALENTS_;
	--	old version compatibility
	-- local ADDON_MSG_QUERY_EQUIPMENTS_1 = VT.__emulib.ADDON_MSG_QUERY_EQUIPMENTS_1;
	local ADDON_MSG_REPLY_EQUIPMENTS_1 = VT.__emulib.ADDON_MSG_REPLY_EQUIPMENTS_1;
	local ADDON_MSG_REPLY_EQUIPMENTS_2 = VT.__emulib.ADDON_MSG_REPLY_EQUIPMENTS_2;
	local ADDON_MSG_REPLY_ADDON_PACK_1 = VT.__emulib.ADDON_MSG_REPLY_ADDON_PACK_1;

	function MT.SendQueryRequest(name, realm, mute, force_update, talent, equitment)
		if name ~= nil then
			local n, r = strsplit("-", name);
			if r ~= nil and r ~= "" then
				name = n;
				realm = r;
			elseif realm == nil or realm == "" then
				realm = CT.SELFREALM;
			end
			local target = name .. "-" .. realm;
			if realm ~= CT.SELFREALM then
				name = name .. "-" .. realm;
			end
			VT.QuerySent[name] = not mute;
			local Tick = MT.GetUnifiedTime();
			local ready = VT.PrevQueryRequestSentTime[name] == nil or (Tick - VT.PrevQueryRequestSentTime[name] > 1);
			local cache = VT.TQueryCache[name];
			local update_tal = talent ~= false and
								ready and
								(
									cache == nil or
									cache.time_tal == nil or
									(
										(Tick - (cache.time_tal or -CT.DATA_VALIDITY) > CT.THROTTLE_TALENT_QUERY) and
										(
											force_update or
											(Tick - (cache.time_tal or -CT.DATA_VALIDITY) > CT.DATA_VALIDITY)
										)
									)
								);
			local update_inv = equitment ~= false and
								ready and
								(
									cache == nil or
									cache.time_inv == nil or
									(
										(Tick - (cache.time_inv or -CT.DATA_VALIDITY) > CT.THROTTLE_EQUIPMENT_QUERY) and
										(
											force_update or
											(Tick - (cache.time_inv or -CT.DATA_VALIDITY) > CT.DATA_VALIDITY)
										)
									)
								);
			if update_tal or update_inv then
				VT.PrevQueryRequestSentTime[name] = Tick;
				if UnitInBattleground('player') and realm ~= CT.SELFREALM then
					if update_tal then
						SendAddonMessage(ADDON_PREFIX, ADDON_MSG_QUERY_TALENTS .. "#" .. target, "INSTANCE_CHAT");
					end
					if update_inv then
						SendAddonMessage(ADDON_PREFIX, ADDON_MSG_QUERY_EQUIPMENTS .. "#" .. target, "INSTANCE_CHAT");
					end
				else
					if update_tal then
						SendAddonMessage(ADDON_PREFIX, ADDON_MSG_QUERY_TALENTS, "WHISPER", target);
						-- SendAddonMessage(ADDON_PREFIX, ADDON_MSG_QUERY_TALENTS_, "WHISPER", target);
					end
					if update_inv then
						SendAddonMessage(ADDON_PREFIX, ADDON_MSG_QUERY_EQUIPMENTS, "WHISPER", target);
						-- SendAddonMessage(ADDON_PREFIX, ADDON_MSG_QUERY_EQUIPMENTS_1, "WHISPER", target);
					end
				end
				-- for _, val in next, VT.ExternalAddOn do
				-- 	if UnitInBattleground('player') and realm ~= CT.SELFREALM then
				-- 	else
				-- 		if val.msg then
				-- 			SendAddonMessage(val.prefix, val.msg, "WHISPER", target);
				-- 		end
				-- 	end
				-- end
				if not update_inv then
					MT._TriggerCallback("CALLBACK_DATA_RECV", name);
					MT._TriggerCallback("CALLBACK_INVENTORY_DATA_RECV", name, false);
				end
				if not update_tal then
					MT._TriggerCallback("CALLBACK_DATA_RECV", name);
					MT._TriggerCallback("CALLBACK_TALENT_DATA_RECV", name, false);
				end
			else
				MT._TriggerCallback("CALLBACK_DATA_RECV", name);
				MT._TriggerCallback("CALLBACK_TALENT_DATA_RECV", name, false);
				MT._TriggerCallback("CALLBACK_INVENTORY_DATA_RECV", name, false);
			end
		end
		return name;
	end

	local bak_ERR_CHAT_PLAYER_NOT_FOUND_S = nil;
	local pattern_ERR_CHAT_PLAYER_NOT_FOUND_S = nil;
	local function ChatFilter_CHAT_MSG_SYSTEM(self, event, msg, ...)
		--	ERR_CHAT_PLAYER_NOT_FOUND_S
		local ERR_CHAT_PLAYER_NOT_FOUND_S = _G.ERR_CHAT_PLAYER_NOT_FOUND_S;
		if bak_ERR_CHAT_PLAYER_NOT_FOUND_S ~= ERR_CHAT_PLAYER_NOT_FOUND_S then
			bak_ERR_CHAT_PLAYER_NOT_FOUND_S = ERR_CHAT_PLAYER_NOT_FOUND_S;
			pattern_ERR_CHAT_PLAYER_NOT_FOUND_S = gsub(bak_ERR_CHAT_PLAYER_NOT_FOUND_S, "%%s", "(.+)");
		end
		local name = strmatch(msg, pattern_ERR_CHAT_PLAYER_NOT_FOUND_S);
		if name ~= nil then
			name = Ambiguate(name, 'none');
			if VT.PrevQueryRequestSentTime[name] ~= nil then
				return true, msg, ...;
			end
		end
		return false, msg, ...;
	end
	local function OnEvent(Driver, event, prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID)
		local name = Ambiguate(sender, 'none');
		if prefix == ADDON_PREFIX then
			local Tick = MT.GetUnifiedTime();
			local control_code = strsub(msg, 1, ADDON_MSG_CONTROL_CODE_LEN);
			if control_code == ADDON_MSG_REPLY_TALENTS or control_code == ADDON_MSG_REPLY_TALENTS_ then
				local code = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 1, - 1);
				if code and code ~= "" then
					local _1, _2 = strsplit("#", code);
					if _2 == nil or _2 == CT.SELFNAME or _2 == CT.SELFFULLNAME or strsub(_2, 1, CT.SELFFULLNAME_LEN) == CT.SELFFULLNAME then	-- OLDVERSION
						code = _1;
					else
						return;
					end
					local class, data, level = MT.Decode(code);
					if class ~= nil and data ~= nil and level ~= nil then
						local cache = VT.TQueryCache[name];
						if cache == nil then
							cache = {  };
							VT.TQueryCache[name] = cache;
						end
						cache.time_tal = Tick;
						cache.talent = code;
						cache.class = class;
						cache.data = data;
						cache.level = level;
						MT._TriggerCallback("CALLBACK_DATA_RECV", name);
						MT._TriggerCallback("CALLBACK_TALENT_DATA_RECV", name, true);
						if cache.time_inv ~= nil and Tick - cache.time_inv < CT.DATA_VALIDITY then
							MT._TriggerCallback("CALLBACK_INVENTORY_DATA_RECV", name, true);
						end
					end
				end
			elseif control_code == ADDON_MSG_REPLY_EQUIPMENTS or control_code == ADDON_MSG_REPLY_EQUIPMENTS_1 or control_code == ADDON_MSG_REPLY_EQUIPMENTS_2 then
				local code = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 1, - 1);
				-- queryCache
				if code ~= nil and code ~= "" then
					local _1, _2 = strsplit("#", code);
					if not _2 or _2 == CT.SELFNAME or _2 == CT.SELFFULLNAME or strsub(_2, 1, CT.SELFFULLNAME_LEN) == CT.SELFFULLNAME then	-- OLDVERSION
						code = _1;
					else
						return;
					end
					-- #0#item:-1#1#item:123:::::#2#item:444:::::#3#item:-1
					-- #(%d)#(item:[%-0-9:]+)#(%d)#(item:[%-0-9:]+)#(%d)#(item:[%-0-9:]+)#(%d)#(item:[%-0-9:]+)
					local cache = VT.TQueryCache[name];
					if cache == nil then
						cache = {  };
						VT.TQueryCache[name] = cache;
					end
					if VT.__emulib.DecodeEquipmentData(cache, code) then
						MT._TriggerCallback("CALLBACK_DATA_RECV", name);
						MT._TriggerCallback("CALLBACK_INVENTORY_DATA_RECV", name, true);
					end
				end
			elseif control_code == ADDON_MSG_REPLY_ADDON_PACK or control_code == ADDON_MSG_REPLY_ADDON_PACK_1 then
				local cache = VT.TQueryCache[name];
				if cache == nil then
					cache = {  };
					VT.TQueryCache[name] = cache;
				end
				cache.time_pak = Tick;
				local code = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 1, - 1);
				local _1, _2 = strsplit("#", code);	-- OLD VERSION
				if _2 ~= nil then
					code = _1;
				end
				cache.pack = code;
				MT.SetPack(name);
				if VT.SET.inspect_pack then
					-- NS.display_pack(code);
				end
				MT._TriggerCallback("CALLBACK_DATA_RECV", name);
			elseif control_code == ADDON_MSG_PUSH or control_code == ADDON_MSG_PUSH_RECV then
				local body = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 1, - 1);
				local code, GUID = strsplit("#", body);
				if code ~= nil and GUID ~= nil then
					local class, data, level = MT.Decode(code);
					if class ~= nil and data ~= nil and level ~= nil then
						local title = MT.GenerateTitleFromRawData(data, class, true);
						if title ~= nil then
							if control_code == ADDON_MSG_PUSH then
								MT.SimulateChatMessage(channel, name, MT.GenerateLink(title, class, code), zoneChannelID, GUID);
								if _TempSavedCommTalents[code] == nil then
									local text = MT.GenerateTitleFromRawData(data, class);
									_TempSavedCommTalents[code] = text;
									VT.SendButtonMenuDefinition.num = VT.SendButtonMenuDefinition.num + 1;
									VT.SendButtonMenuDefinition[VT.SendButtonMenuDefinition.num] = {
										param = { class, data, level, },
										text = text,
									};
								end
								if channel == "WHISPER" then
									SendAddonMessage(ADDON_PREFIX, ADDON_MSG_PUSH_RECV .. code .. "#" .. CT.SELFGUID, "WHISPER", sender);
								end
							elseif control_code == ADDON_MSG_PUSH_RECV then
								MT.SimulateChatMessage("WHISPER_INFORM", name, MT.GenerateLink(title, class, code), zoneChannelID, GUID);
							end
						end
					end
				end
			-- elseif control_code == ADDON_MSG_PULL then
			end
		else
			local meta = VT.ExternalAddOn[prefix];
			if meta ~= nil then
				if meta.handler(meta, name, msg) then
					MT._TriggerCallback("CALLBACK_DATA_RECV", name);
				end
			end
			-- local msg = _detalhes:Serialize (CONST_ANSWER_TALENTS, CT.SELFNAME, CT.SELFREALM, _detalhes.realversion, UnitGUID ("player"), 0, compressedTalents, Details.CPlayerClassUppericSpec.specs)
			-- local msg = CONST_ANSWER_TALENTS .. CT.SELFNAME .. CT.SELFREALM .. _detalhes.realversion .. UnitGUID ("player") .. 0 .. compressedTalents .. Details.CPlayerClassUppericSpec.specs
			-- (CONST_DETAILS_PREFIX, msg, "WHISPER", targetPlayer)
		end
	end

	local _TChatFrames = {  };
	for i = 1, 10 do
		_TChatFrames[i] = _G["ChatFrame" .. i];
	end
	function MT.SimulateChatMessage(channel, sender, msg, zoneChannelID, GUID)
		for i = 1, 10 do
			if _TChatFrames[i] ~= nil then
				ChatFrame_MessageEventHandler(_TChatFrames[i], "CHAT_MSG_" .. channel, msg, sender, "", "", sender, "", zoneChannelID, 0, "", nil, 0, GUID, nil, false, false, false);
			end
		end
	end
	function MT.SendTalents(Frame)
		local code = MT.Encode(Frame);
		local editBox = ChatEdit_ChooseBoxForSend();
		editBox:Show();
		editBox:SetFocus();
		editBox:Insert("[emu:" .. code .. "]");
	end
	function MT.PushTalents(channel, target, _1, _2, _3)	--	old version, unused now
		local code = MT.Encode(_1, _2, _3);
		if code then
			local GUID = CT.SELFGUID;
			SendAddonMessage(ADDON_PREFIX, ADDON_MSG_PUSH .. code .. "#" .. GUID, channel, target);
		end
	end
	local _SetHyperlink = ItemRefTooltip.SetHyperlink;
	ItemRefTooltip.SetHyperlink = function(Tip, link, ...)
		local code = strmatch(link, "^emu:(.+)");
		if code ~= nil then
			local class, data, level = MT.Decode(code);
			if class ~= nil and data ~= nil and level ~= nil then
				MT.CreateEmulator(nil, class, data, level, false, L.message, false);
			end
			return true;
		else
			return _SetHyperlink(Tip, link, ...);
		end
	end
	local function ChatFilter_CHAT_Replacer(body, code)
		local class, data, level = MT.Decode(code);
		if class ~= nil and data ~= nil and level ~= nil then
			local title = MT.GenerateTitleFromRawData(data, class, true);
			if title ~= nil then
				if _TempSavedCommTalents[code] == nil then
					local text = MT.GenerateTitleFromRawData(data, class);
					_TempSavedCommTalents[code] = text;
					VT.SendButtonMenuDefinition.num = VT.SendButtonMenuDefinition.num + 1;
					VT.SendButtonMenuDefinition[VT.SendButtonMenuDefinition.num] = {
						param = { class, data, level, },
						text = text,
					};
				end
				return MT.GenerateLink(title, class, code);
			end
		end
		return body;
	end
	local _FilterCache = {  };
	local function ChatFilter_CHAT(ChatFrame, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, line, arg12, arg13, arg14, ...)
		if _FilterCache[line] ~= nil then
			return false, _FilterCache[line], arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, line, arg12, arg13, arg14, ...;
		end
		if ChatFrame ~= ChatFrame2 then
			arg1 = gsub(arg1, "(%[emu:([a-zA-Z0-9-=:]+)%])", ChatFilter_CHAT_Replacer);
			_FilterCache[line] = arg1;
			return false, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, line, arg12, arg13, arg14, ...;
		end
	end
	local function SendFilterRep(code)
		return "[emu:" .. code .. "]";
	end
	local function SendFilter(msg)
		--"|Hcdxl:([0-9]+)|h|c[0-9a-f]+%[%[(.+)%](.+)%]|r|h"
		--"|Hemu:([0-9a-zA-Z-=]+)|h|c[0-9a-f]+%[(.-)%]|r|h"
		return gsub(msg, "|Hemu:([a-zA-Z0-9-=:]+)|h|c[0-9a-f]+%[.-%]|r|h", SendFilterRep);
	end

	local __SendChatMessage = nil;
	local function Hooked_SendChatMessage(text, ...)
		__SendChatMessage(SendFilter(text), ...);
	end
	local __BNSendWhisper = nil;
	local function Hooked_BNSendWhisper(presenceID, text, ...)
		__BNSendWhisper(presenceID, SendFilter(text), ...);
	end
	local __BNSendConversationMessage = nil;
	local function Hooked_BNSendConversationMessage(target, text, ...)
		__BNSendConversationMessage(target, SendFilter(text), ...);
	end

	MT.RegisterOnInit('COMM', function(LoggedIn)
		local Driver = CreateFrame('FRAME', nil, UIParent);
		if IsAddonMessagePrefixRegistered(ADDON_PREFIX) or RegisterAddonMessagePrefix(ADDON_PREFIX) then
			Driver:RegisterEvent("CHAT_MSG_ADDON");
			Driver:RegisterEvent("CHAT_MSG_ADDON_LOGGED");
			Driver:SetScript("OnEvent", OnEvent);
			MT._RegisterCallback("CALLBACK_TALENT_DATA_RECV", MT.CALLBACK.OnTalentDataRecv);
			MT._RegisterCallback("CALLBACK_INVENTORY_DATA_RECV", MT.CALLBACK.OnInventoryDataRecv);
			ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", ChatFilter_CHAT_MSG_SYSTEM);
			-- hooksecurefunc("SendChatMessage", function(_msg, _type, _lang, _target)
			-- 	if _type == "WHISPER" then
			-- 		VT.PrevQueryRequestSentTime[_target] = nil;
			-- 	end
			-- end);
		else
			MT.Log("Init", "RegisterAddonMessagePrefix", ADDON_PREFIX);
		end
		ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", ChatFilter_CHAT);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", ChatFilter_CHAT);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", ChatFilter_CHAT);		
		ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", ChatFilter_CHAT);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", ChatFilter_CHAT);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", ChatFilter_CHAT);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", ChatFilter_CHAT);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_BN", ChatFilter_CHAT);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", ChatFilter_CHAT);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", ChatFilter_CHAT);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", ChatFilter_CHAT);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", ChatFilter_CHAT);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", ChatFilter_CHAT);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", ChatFilter_CHAT);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", ChatFilter_CHAT);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", ChatFilter_CHAT);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", ChatFilter_CHAT);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", ChatFilter_CHAT);
		__SendChatMessage = _G.SendChatMessage;
		_G.SendChatMessage = Hooked_SendChatMessage;
		__BNSendWhisper = _G.BNSendWhisper;
		_G.BNSendWhisper = Hooked_BNSendWhisper;
		__BNSendConversationMessage = _G.BNSendConversationMessage;
		_G.BNSendConversationMessage = Hooked_BNSendConversationMessage;
	end);
	MT.RegisterOnLogin('COMM', function(LoggedIn)
	end);

-->
