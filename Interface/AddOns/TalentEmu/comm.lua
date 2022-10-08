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
	local strsub, strsplit, strmatch, gsub = string.sub, string.split, string.match, string.gsub;
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
	--
	--	name, realm, force_update, popup, update_talent(nil means true), update_equipment(nil means true)
	function MT.SendQueryRequest(name, realm, force_update, popup, update_talent, update_glyph, update_equipment)
		if name ~= nil then
			local Tick = MT.GetUnifiedTime();
			local shortname, r2 = strsplit("-", name);
			if r2 ~= nil and r2 ~= "" then
				name = shortname;
				realm = r2;
			elseif realm == nil or realm == "" then
				realm = CT.SELFREALM;
			end
			if realm ~= CT.SELFREALM then
				name = name .. "-" .. realm;
			end
			VT.QuerySent[name] = popup and Tick or VT.QuerySent[name] or nil;
			VT.AutoShowEquipmentFrameOnComm[name] = popup and update_equipment ~= false and Tick or VT.AutoShowEquipmentFrameOnComm[name];
			if name == CT.SELFNAME then
				VT.PrevQueryRequestSentTime[name] = Tick;
				local code = VT.VAR[CT.SELFGUID];
				if code ~= nil then
					return VT.__emulib.CHAT_MSG_ADDON(VT.__emulib.CT.COMM_PREFIX, code, "WHISPER", name);
				end
			end
			-- if VT.__is_inbattleground then
			-- 	local v = VT.TBattlegroundComm[name];
			-- end
			local ready = VT.PrevQueryRequestSentTime[name] == nil or (Tick - VT.PrevQueryRequestSentTime[name] > 0.1);
			local cache = VT.TQueryCache[name];
			local update_tal = update_talent ~= false and
								ready and
								(
									cache == nil or
									cache.TalData.Tick == nil or
									(
										(Tick - (cache.TalData.Tick or -CT.DATA_VALIDITY) > CT.THROTTLE_TALENT_QUERY) and
										(
											force_update or
											(Tick - (cache.TalData.Tick or -CT.DATA_VALIDITY) > CT.DATA_VALIDITY)
										)
									)
								);
			local update_gly = update_glyph ~= false and
								ready and
								(
									cache == nil or
									cache.GlyData.Tick == nil or
									(
										(Tick - (cache.GlyData.Tick or -CT.DATA_VALIDITY) > CT.THROTTLE_GLYPH_QUERY) and
										(
											force_update or
											(Tick - (cache.GlyData.Tick or -CT.DATA_VALIDITY) > CT.DATA_VALIDITY)
										)
									)
								);
			local update_inv = update_equipment ~= false and
								ready and
								(
									cache == nil or
									cache.EquData.Tick == nil or
									(
										(Tick - (cache.EquData.Tick or -CT.DATA_VALIDITY) > CT.THROTTLE_EQUIPMENT_QUERY) and
										(
											force_update or
											(Tick - (cache.EquData.Tick or -CT.DATA_VALIDITY) > CT.DATA_VALIDITY)
										)
									)
								);
			if update_tal or update_gly or update_inv then
				--[[
				MT.Error(
					"MT.SendQueryRequest",
					name,
					force_update == false and "0" or "1",
					popup == false and "0" or "1",
					update_talent == false and "0" or "1",
					update_equipment == false and "0" or "1",
					update_tal == false and "0" or "1",
					update_gly == false and "0" or "1",
					update_inv == false and "0" or "1"
				);
				--]]
				VT.PrevQueryRequestSentTime[name] = Tick;
				VT.__emulib.SendQueryRequest(shortname, realm, update_tal, update_gly, update_inv);
				if not update_tal then
					MT._TriggerCallback("CALLBACK_DATA_RECV", name);
					MT._TriggerCallback("CALLBACK_TALENT_DATA_RECV", name, false);
				end
				if not update_gly then
					MT._TriggerCallback("CALLBACK_DATA_RECV", name);
					MT._TriggerCallback("CALLBACK_GLYPH_DATA_RECV", name, false, popup and update_talent ~= false);
				end
				if not update_inv then
					MT._TriggerCallback("CALLBACK_DATA_RECV", name);
					MT._TriggerCallback("CALLBACK_INVENTORY_DATA_RECV", name, false, popup and update_equipment ~= false);
				end
			else
				MT._TriggerCallback("CALLBACK_DATA_RECV", name);
				MT._TriggerCallback("CALLBACK_TALENT_DATA_RECV", name, false);
				MT._TriggerCallback("CALLBACK_GLYPH_DATA_RECV", name, false);
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
			local T = VT.PrevQueryRequestSentTime[name];
			if T ~= nil and MT.GetUnifiedTime() - T < 4.0 then
				return true, msg, ...;
			end
		end
		return false, msg, ...;
	end
	MT._CommDistributor = {
		OnTalent = function(prefix, name, code, version, Decoder, overheard)
			local class, level, numGroup, activeGroup, data1, data2 = Decoder(code);
			if class ~= nil then
				if version == "V1" and DT.BUILD == "WRATH" then
					class, level, numGroup, activeGroup, data1, data2 = MT.TalentConversion(class, level, numGroup, activeGroup, data1, data2);
				end
				local Tick = MT.GetUnifiedTime();
				local cache = VT.TQueryCache[name];
				if cache == nil then
					cache = { TalData = {  }, EquData = {  }, GlyData = {  }, PakData = {  }, };
					VT.TQueryCache[name] = cache;
				end
				cache.class = class;
				cache.level = level;
				local TalData = cache.TalData;
				TalData[1] = data1;
				TalData[2] = data2;
				TalData.num = numGroup;
				TalData.active = activeGroup;
				TalData.code = code;
				TalData.Tick = Tick;
				if not overheard then
					MT._TriggerCallback("CALLBACK_DATA_RECV", name);
					MT._TriggerCallback("CALLBACK_TALENT_DATA_RECV", name, true);
					if cache.EquData.Tick ~= nil and Tick - cache.EquData.Tick < CT.DATA_VALIDITY then
						MT._TriggerCallback("CALLBACK_INVENTORY_DATA_RECV", name, true);
					end
					if cache.GlyData.Tick ~= nil and Tick - cache.GlyData.Tick < CT.DATA_VALIDITY then
						MT._TriggerCallback("CALLBACK_GLYPH_DATA_RECV", name, true);
					end
				end
			end
		end,
		OnGlyph = function(prefix, name, code, version, Decoder, overheard)
			if DT.BUILD ~= "WRATH" then
				return;
			end
			local data1, data2 = Decoder(code);
			if data1 == nil and data2 == nil then
				-- MT.Error("No GlyphSet 1");
				-- MT.Error("No GlyphSet 2");
				return;
			end
			local Tick = MT.GetUnifiedTime();
			local cache = VT.TQueryCache[name];
			if cache == nil then
				cache = { TalData = {  }, EquData = {  }, GlyData = {  }, PakData = {  }, };
				VT.TQueryCache[name] = cache;
			end
			local GlyData = cache.GlyData;
			GlyData[1] = data1;
			GlyData[2] = data2;
			GlyData.Tick = Tick;
			if not overheard then
				MT._TriggerCallback("CALLBACK_DATA_RECV", name);
				MT._TriggerCallback("CALLBACK_GLYPH_DATA_RECV", name, true);
			end
		end,
		OnEquipment = function(prefix, name, code, version, Decoder, overheard)
			-- #0#item:-1#1#item:123:::::#2#item:444:::::#3#item:-1
			-- #(%d)#(item:[%-0-9:]+)#(%d)#(item:[%-0-9:]+)#(%d)#(item:[%-0-9:]+)#(%d)#(item:[%-0-9:]+)
			local cache = VT.TQueryCache[name];
			if cache == nil then
				cache = { TalData = {  }, EquData = {  }, GlyData = {  }, PakData = {  }, };
				VT.TQueryCache[name] = cache;
			end
			local EquData = cache.EquData;
			if Decoder(EquData, code) then
				EquData.Tick = MT.GetUnifiedTime();
				if not overheard then
					MT._TriggerCallback("CALLBACK_DATA_RECV", name);
					MT._TriggerCallback("CALLBACK_INVENTORY_DATA_RECV", name, true);
				end
			end
		end,
		OnAddOn = function(prefix, name, code, version, Decoder, overheard)
			local cache = VT.TQueryCache[name];
			if cache == nil then
				cache = { TalData = {  }, EquData = {  }, GlyData = {  }, PakData = {  }, };
				VT.TQueryCache[name] = cache;
			end
			local PakData = cache.PakData;
			PakData.Tick = MT.GetUnifiedTime();
			PakData[1] = code;
			MT.SetPack(name);
			-- if VT.SET.inspect_pack then
				-- NS.display_pack(code);
			-- end
			if not overheard then
				MT._TriggerCallback("CALLBACK_DATA_RECV", name);
			end
		end,
		OnPush = function(prefix, name, body, version, channel, isinform)
			local code, GUID, version = strsplit("#", body);
			if code ~= nil and GUID ~= nil and version == nil then
				local class, level, numGroup, activeGroup, data1, data2 = MT.DecodeTalent(code);
				if class ~= nil then
					local title = MT.GenerateTitleFromRawData(data1, class, true);
					if title ~= nil then
						if isinform then
							MT.SimulateChatMessage("WHISPER_INFORM", name, MT.GenerateLink(title, class, code), GUID);
						else
							MT.SimulateChatMessage(channel, name, MT.GenerateLink(title, class, code), GUID);
							if _TempSavedCommTalents[code] == nil then
								local text = MT.GenerateTitleFromRawData(data1, class);
								_TempSavedCommTalents[code] = text;
								VT.SendButtonMenuDefinition.num = VT.SendButtonMenuDefinition.num + 1;
								VT.SendButtonMenuDefinition[VT.SendButtonMenuDefinition.num] = {
									param = { class, level, { data1, data2, num = numGroup, active = activeGroup, }, },
									text = text,
								};
							end
							if channel == "WHISPER" then
								VT.__emulib.PushTalentsInformV1(prefix, code .. "#" .. CT.SELFGUID, "WHISPER", name);
							end
						end
					end
				end
			end
		end,
	};
	local function OnEvent(Driver, event, prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID)
		local meta = VT.ExternalAddOn[prefix];
		if meta ~= nil then
			local name = Ambiguate(sender, 'none');
			if meta.handler(meta, name, msg) then
				MT._TriggerCallback("CALLBACK_DATA_RECV", name);
			end
		end
	end

	local _TChatFrames = {  };
	for i = 1, 10 do
		_TChatFrames[i] = _G["ChatFrame" .. i];
	end
	function MT.SimulateChatMessage(channel, sender, msg, GUID)
		for i = 1, 10 do
			if _TChatFrames[i] ~= nil then
				ChatFrame_MessageEventHandler(_TChatFrames[i], "CHAT_MSG_" .. channel, msg, sender, "", "", sender, "", 0, 0, "", nil, 0, GUID, nil, false, false, false);
			end
		end
	end
	function MT.SendTalents(Frame)
		local code = MT.EncodeTalent(Frame);
		local class, level, numGroup, activeGroup, data1, data2 = MT.DecodeTalent(code);
		local title = MT.GenerateTitleFromRawData(data1, class, true);
		if title ~= nil then
			local link = MT.GenerateLink(title, class, code);
			if link ~= nil then
				local editBox = ChatEdit_ChooseBoxForSend();
				editBox:Show();
				editBox:SetFocus();
				editBox:Insert(link);
			end
		end
	end
	local _SetHyperlink = ItemRefTooltip.SetHyperlink;
	ItemRefTooltip.SetHyperlink = function(Tip, link, ...)
		local code = strmatch(link, "^emu:(.+)");
		if code ~= nil then
			local class, level, numGroup, activeGroup, data1, data2 = MT.DecodeTalent(code);
			if class ~= nil then
				MT.CreateEmulator(nil, class, level, { data1, data2, num = numGroup, active = activeGroup, }, L.message, false, false);
			end
			return true;
		else
			return _SetHyperlink(Tip, link, ...);
		end
	end
	local _CurrentChannel, _CurrentTarget = nil;
	local function ChatFilter_CHAT_Replacer(body, code)
		local class, level, numGroup, activeGroup, data1, data2 = MT.DecodeTalent(code);
		if class ~= nil then
			local title = MT.GenerateTitleFromRawData(data1, class, true);
			if title ~= nil then
				if _TempSavedCommTalents[code] == nil then
					local text = MT.GenerateTitleFromRawData(data1, class);
					_TempSavedCommTalents[code] = text;
					VT.SendButtonMenuDefinition.num = VT.SendButtonMenuDefinition.num + 1;
					VT.SendButtonMenuDefinition[VT.SendButtonMenuDefinition.num] = {
						param = { class, level, { data1, data2, num = numGroup, active = activeGroup, }, },
						text = text,
					};
				end
				return MT.GenerateLink(title, class, code);
			end
		end
		return body;
	end
	local function ChatFilter_CHAT(ChatFrame, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, line, arg12, arg13, arg14, ...)
		if ChatFrame ~= ChatFrame2 then
			arg1 = gsub(arg1, "(%[emu:(![A-Z][a-zA-Z0-9-=:]+)%])", ChatFilter_CHAT_Replacer);
			return false, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, line, arg12, arg13, arg14, ...;
		end
	end
	local function SendFilterRep(code)
		if _CurrentChannel ~= nil then
			if strsub(code, 1, 1) == "!" then
				local class, level, numGroup, activeGroup, code1, code2 = VT.__emulib.DecodeTalentDataV2(code, true);
				if numGroup == 2 then
					if activeGroup == 1 then
						VT.__emulib.PushTalentsV2(class, level, code1, _CurrentChannel, _CurrentTarget);
						VT.__emulib.PushTalentsV2(class, level, code2, _CurrentChannel, _CurrentTarget);
					else
						VT.__emulib.PushTalentsV2(class, level, code2, _CurrentChannel, _CurrentTarget);
						VT.__emulib.PushTalentsV2(class, level, code1, _CurrentChannel, _CurrentTarget);
					end
				else
					VT.__emulib.PushTalentsV2(class, level, code1, _CurrentChannel, _CurrentTarget);
				end
			else
				VT.__emulib.PushTalentsV1(code, _CurrentChannel, _CurrentTarget);
			end
		end
		return "[emu:" .. code .. "]";
	end
	local _ChannelsSupportedByOldVersion = {
		["PARTY"] = true,
		["GUILD"] = true,
		["RAID"] = true,
		["BATTLEGROUND"] = true,
		["WHISPER"] = true,
	};
	local function SendFilter(msg, chatType, languageID, target)
		--"|Hcdxl:([0-9]+)|h|c[0-9a-f]+%[%[(.+)%](.+)%]|r|h"
		--"|Hemu:([0-9a-zA-Z-=]+)|h|c[0-9a-f]+%[(.-)%]|r|h"
		if _ChannelsSupportedByOldVersion[chatType] then
			_CurrentChannel, _CurrentTarget = chatType, target;
		end
		msg = gsub(msg, "|Hemu:([!a-zA-Z0-9-=:][a-zA-Z0-9-=:]+)|h|c[0-9a-f]+%[.-%]|r|h", SendFilterRep);
		_CurrentChannel = nil;
		return msg;
	end

	local __SendChatMessage = nil;
	local function Hooked_SendChatMessage(text, ...)
		__SendChatMessage(SendFilter(text, ...), ...);
	end
	local __BNSendWhisper = nil;
	local function Hooked_BNSendWhisper(presenceID, text, ...)
		__BNSendWhisper(presenceID, SendFilter(text, ...), ...);
	end
	local __BNSendConversationMessage = nil;
	local function Hooked_BNSendConversationMessage(target, text, ...)
		__BNSendConversationMessage(target, SendFilter(text, ...), ...);
	end

	MT.RegisterOnInit('COMM', function(LoggedIn)
		VT.__emulib.RegisterCommmDistributor(MT._CommDistributor);
		local Driver = CreateFrame('FRAME', nil, UIParent);
		Driver:RegisterEvent("CHAT_MSG_ADDON");
		Driver:RegisterEvent("CHAT_MSG_ADDON_LOGGED");
		Driver:SetScript("OnEvent", OnEvent);
		MT._RegisterCallback("CALLBACK_TALENT_DATA_RECV", MT.CALLBACK.OnTalentDataRecv);
		if VT.__support_glyph then
			MT._RegisterCallback("CALLBACK_GLYPH_DATA_RECV", MT.CALLBACK.OnGlyphDataRecv);
		end
		MT._RegisterCallback("CALLBACK_INVENTORY_DATA_RECV", MT.CALLBACK.OnInventoryDataRecv);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", ChatFilter_CHAT_MSG_SYSTEM);
		-- hooksecurefunc("SendChatMessage", function(_msg, _type, _lang, _target)
		-- 	if _type == "WHISPER" then
		-- 		VT.PrevQueryRequestSentTime[_target] = nil;
		-- 	end
		-- end);
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
