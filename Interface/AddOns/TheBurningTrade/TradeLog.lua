SLASH_TRADELOGSHOW1 = "/tbtdebug";
SlashCmdList["TRADELOGSHOW"] = function(msg)
	DEFAULT_CHAT_FRAME:AddMessage("(debug)TradeId-"..msg.." |Htradelog:"..msg.."|h[DETAIL]|h:");
	TBT_CURRENT_TRADE = TradeLog_TradesHistory[0+msg];
	TradeLog_OutputLog();
	table.remove(TradeLog_TradesHistory, getn(TradeLog_TradesHistory));
end

TBT_CURRENT_TRADE = nil;

local function curr()
	if(not TBT_CURRENT_TRADE) then
		TBT_CURRENT_TRADE = TradeLog_CreateNewTrade();
	end
	return TBT_CURRENT_TRADE;
end

function TradeLog_CreateNewTrade()
	local trade = {
		id = nil,
		when = nil,
		where = nil,
		who = nil,
		player=UnitName("player"),
		playerMoney = 0,
		targetMoney = 0,
		playerItems = {},
		targetItems = {},
		events = {},  --for analysing cancel reason
		toofar = nil, --for further analysing cancel reason
		result = nil, --[cancelled | complete | error]
		reason = nil, --["self" | "selfrunaway" | "toofar" | "other" | "selfhideui" | ERR_TRADE_BAG_FULL | ERR_TRADE_MAX_COUNT_EXCEEDED | ERR_TRADE_TARGET_BAG_FULL | ERR_TRADE_TARGET_MAX_COUNT_EXCEEDED]
	};
	return trade;
end

function TradeLog_OnLoad(self)

	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("TRADE_SHOW");
	self:RegisterEvent("TRADE_CLOSED");
	self:RegisterEvent("TRADE_REQUEST_CANCEL");
	self:RegisterEvent("PLAYER_TRADE_MONEY");

	self:RegisterEvent("TRADE_MONEY_CHANGED");
	--self:RegisterEvent("TRADE_PLAYER_ITEM_CHANGED"); --this is an uncertain problem, seems TRADE_PLAYER_ITEM_CHANGED always fire 2 times?
	self:RegisterEvent("TRADE_TARGET_ITEM_CHANGED");
	self:RegisterEvent("TRADE_ACCEPT_UPDATE");
	self:RegisterEvent("UI_INFO_MESSAGE");
	self:RegisterEvent("UI_ERROR_MESSAGE");
end

function TradeLog_OnVariableLoad()
	-- local menu = CreateFrame("Frame", "TBT_AnnounceChannelDropDown", TradeFrame, "UIDropDownMenuTemplate");
	-- menu:SetPoint("BOTTOMLEFT", "TradeFrame", "BOTTOMLEFT", 80, 49);
	-- UIDropDownMenu_SetWidth(TBT_AnnounceChannelDropDown, 62, 3);
    -- TBT_AnnounceChannelDropDown:SetScript("OnShow", function(self) self:SetFrameLevel(TradeFrame:GetFrameLevel()) end)

	local cb = CreateFrame("CheckButton", "TBT_AnnounceCB", TradeFrame, "InterfaceOptionsCheckButtonTemplate");
	cb:SetPoint("BOTTOMLEFT", "TradeFrame", "BOTTOMLEFT", 16, 0);
	cb:SetWidth(26);
	cb:SetHeight(26);
	TBT_AnnounceCBText:SetText(TRADE_LOG_ANNOUNCE);
	cb.tooltipText = TRADE_LOG_ANNOUNCE_TIP;
	cb:SetScript("OnClick", function(self) TradeLog_Announce_Checked = self:GetChecked()and true or false; end);

    -- menu:SetPoint('BOTTOMLEFT', cb, 50, -3)
	TradeLog_TradesHistory = TradeLog_TradesHistory or {};

	for k, v in ipairs(TradeLog_TradesHistory) do
		v.id = v.id or k
	end

	TradeLog_AnnounceChannel = TradeLog_AnnounceChannel or "WHISPER";

	-- UIDropDownMenu_Initialize(TBT_AnnounceChannelDropDown, TBT_AnnounceChannelDropDown_Initialize);
	-- UIDropDownMenu_SetSelectedValue(TBT_AnnounceChannelDropDown, TradeLog_AnnounceChannel);

	if(TradeLog_Announce_Checked) then TBT_AnnounceCB:SetChecked(1); end;

	if TradeLogFrame_CreateMinimapButton then TradeLogFrame_CreateMinimapButton() end
end

function TradeLog_OnEvent(self, event, arg1, arg2)
	--local arg1 = ...;
	if (event=="UI_ERROR_MESSAGE") then
		if(arg2==ERR_TRADE_BAG_FULL or arg2==ERR_TRADE_MAX_COUNT_EXCEEDED or arg2==ERR_TRADE_TARGET_BAG_FULL or arg2==ERR_TRADE_TARGET_MAX_COUNT_EXCEEDED) then
			curr().result = "error";
			curr().reason=arg2;
			TradeLog_LogTradeAndReset();
		elseif (arg2==ERR_TRADE_TARGET_DEAD or arg2==ERR_TRADE_TOO_FAR) then
			DEFAULT_CHAT_FRAME:AddMessage(arg2, 1, 0.2, 0.2);
		end
	elseif (event=="UI_INFO_MESSAGE" and ( arg2==ERR_TRADE_CANCELLED or arg2==ERR_TRADE_COMPLETE) ) then
		if(arg2==ERR_TRADE_CANCELLED) then
			curr().result = "cancelled";
		else
			curr().result = "complete";
		end
		TradeLog_LogTradeAndReset();

	elseif (event=="TRADE_CLOSED" or event=="TRADE_REQUEST_CANCEL" or event == "TRADE_SHOW") then
		table.insert(curr().events, event);

	elseif (event=="TRADE_PLAYER_ITEM_CHANGED") then
		TradeLog_UpdateItemInfo(arg1, "Player", curr().playerItems);

	elseif (event=="TRADE_TARGET_ITEM_CHANGED") then
		TradeLog_UpdateItemInfo(arg1, "Target", curr().targetItems);

	elseif (event=="TRADE_MONEY_CHANGED") then
		TradeLog_UpdateMoney();

	elseif (event=="TRADE_ACCEPT_UPDATE") then
		for i = 1, 7 do
			TradeLog_UpdateItemInfo(i, "Player", curr().playerItems);
			TradeLog_UpdateItemInfo(i, "Target", curr().targetItems);
		end
		TradeLog_UpdateMoney();
	elseif (event=="ADDON_LOADED") and arg1 == "TheBurningTrade" then
		TradeLog_OnVariableLoad()
	end

	if (event=="TRADE_REQUEST_CANCEL") then --judge the trade distance for further analysing the cancel reason
		if(UnitName("NPC")) then
			if (CheckInteractDistance("npc", 2)) then
				curr().toofar = "no";
			else
				curr().toofar = "yes";
			end
		end;
	end

	if (event=="TRADE_SHOW") then
		curr().who=TBT_UnitName("NPC");
	end
end

function TradeLog_UpdateItemInfo(id, unit, items)
	local funcInfo = getglobal("GetTrade"..unit.."ItemInfo");
	local funcLink = getglobal("GetTrade"..unit.."ItemLink");

	local name, texture, numItems, quality, isUsable, enchantment;
	--why GetTradePlayerItemInfo and GetTradeTargetItemInfo return different things?
	if(unit=="Target") then
		name, texture, numItems, quality, isUsable, enchantment = funcInfo(id);
	else
		name, texture, numItems, quality, enchantment = funcInfo(id);
	end

	if(not name) then
		items[id] = nil;
		return;
	end

	local itemLink = funcLink(id);

	items[id] = {
		name = name,
		texture = texture,
		numItems = numItems,
		isUsable = isUsable,
		enchantment = enchantment,
		itemLink = itemLink,
	}
end

function TradeLog_UpdateMoney()
	curr().playerMoney = GetPlayerTradeMoney();
	curr().targetMoney = GetTargetTradeMoney();
end

function TradeLog_AnalyseCancelReason()
	local reason = "unknown"; --should be unknown only when no trade window opened.
	local e = curr().events;
	local n = table.getn(e);
	if(n>=3 and e[n]=="TRADE_REQUEST_CANCEL" and e[n-1]=="TRADE_CLOSED" and e[n-2]=="TRADE_CLOSED") then
		reason = "self";
	elseif(n>=3 and e[n]=="TRADE_REQUEST_CANCEL" and e[n-1]=="TRADE_CLOSED" and e[n-2]=="TRADE_SHOW") then
		reason = "selfrunaway";
	elseif(n>=3 and e[n]=="TRADE_CLOSED" and e[n-1]=="TRADE_CLOSED" and e[n-2]=="TRADE_REQUEST_CANCEL") then
		if(curr().toofar == "yes") then
			reason = "toofar";
		elseif(curr().toofar == "no") then
			reason = "other";
		else
			reason = "wrong!!"; --this should not happen, if you see, contact me :p
		end
	elseif(n>=3 and e[n]=="TRADE_REQUEST_CANCEL" and e[n-1]=="TRADE_SHOW" and e[n-2]=="TRADE_CLOSED") then
		reason = "selfhideui";
	end

	curr().events = nil; --reason analyzed, abandon it to release that tiny memory
	return reason;
end

function TradeLog_LogTradeAndReset()
	curr().when = date("%m-%d %H:%M:%S");
	curr().where = GetRealZoneText();
	if( curr().result == "cancelled" ) then
		curr().reason = TradeLog_AnalyseCancelReason();
	elseif( curr().result == "error" ) then
		curr().reason = curr().reason;
	end
	TradeLog_OutputLog();
	TBT_CURRENT_TRADE = nil;
end

local function TBT_nextId(tab)
	local n = 0;
	for k,v in pairs(tab) do
		if(v.id>n) then n=v.id end;
	end
	return n+1;
end

function TradeLog_OutputLog()
	local numPlayer, numTarget, enPlayer, enTarget, msg;
	if(not curr().who) then
		--never show the trade window
		if( curr().reason =="selfhideui" ) then
			DEFAULT_CHAT_FRAME:AddMessage(string.gsub(TRADE_LOG_FAILED_NO_TARGET, "%%r", CANCEL_REASON_TEXT[curr().reason]));
		else
			TBT_debug("debug : no window opened");
		end
		return;
	end
	curr().id = TBT_nextId(TradeLog_TradesHistory);
	table.insert(TradeLog_TradesHistory, curr());
	if(type(TradeListScrollFrame_Update)=="function") then TradeListScrollFrame_Update(); end

	numPlayer = 0; numTarget = 0;
	for i=1,6 do if(curr().playerItems[i]) then numPlayer = numPlayer + 1 end end
	for i=1,6 do if(curr().targetItems[i]) then numTarget = numTarget + 1 end end
	if(curr().playerItems[7] and curr().playerItems[7].name and curr().playerItems[7].enchantment) then enPlayer = curr().playerItems[7].enchantment end;
	if(curr().targetItems[7] and curr().targetItems[7].name and curr().targetItems[7].enchantment) then enTarget = curr().targetItems[7].enchantment end;

	local whoLink = "|Hplayer:"..curr().who.."|h"..curr().who.."|h";
	if(curr().result == "complete") then
		local hasSendAny, hasReceiveAny, strSend, strReceive

		hasSendAny = false;
		strSend = "";
		if(curr().playerMoney > 0) then
			if(hasSendAny) then strSend = strSend..", "; end
			hasSendAny = true;
			strSend = strSend..TradeLog_GetMoneyColorText(curr().playerMoney);
		end
		for i=1,6 do
			if(curr().playerItems[i]) then
				if(hasSendAny) then strSend = strSend..", "; end
				hasSendAny = true;
				strSend = strSend..curr().playerItems[i].itemLink;
				if(curr().playerItems[i].numItems>1) then
					strSend = strSend.."x"..curr().playerItems[i].numItems;
				end
			end
		end
		if(enTarget) then
			if(hasSendAny) then strSend = strSend..", "; end
			hasSendAny = true;
			strSend = strSend..TRADE_LOG_ENCHANT..":"..enTarget
		end

		hasReceiveAny = false;
		strReceive = "";
		if(curr().targetMoney > 0) then
			if(hasReceiveAny) then strReceive = strReceive..", "; end
			hasReceiveAny = true;
			strReceive = strReceive..TradeLog_GetMoneyColorText(curr().targetMoney);
		end
		for i=1,6 do
			if(curr().targetItems[i]) then
				if(hasReceiveAny) then strReceive = strReceive..", "; end
				hasReceiveAny = true;
				strReceive = strReceive..curr().targetItems[i].itemLink;
				if(curr().targetItems[i].numItems>1) then
					strReceive = strReceive.."x"..curr().targetItems[i].numItems;
				end
			end
		end
		if(enPlayer) then
			if(hasReceiveAny) then strReceive = strReceive..", "; end
			hasReceiveAny = true;
			strReceive = strReceive..TRADE_LOG_ENCHANT..":"..enPlayer
		end

		if(not hasSendAny and not hasReceiveAny) then
			DEFAULT_CHAT_FRAME:AddMessage(string.gsub(TRADE_LOG_SUCCESS_NO_EXCHANGE, "%%t", whoLink), 1, 1, 0);
		else
			local linkString = "|CFF00B4FF|Htradelog:"..curr().id.."|h["..TRADE_LOG_DETAIL.."]|h|r";
			if(TradeLogFrame) then
				DEFAULT_CHAT_FRAME:AddMessage(string.gsub(TRADE_LOG_SUCCESS, "%%t", whoLink)..linkString..":", 1, 1, 0);
			else
				DEFAULT_CHAT_FRAME:AddMessage(string.gsub(TRADE_LOG_SUCCESS, "%%t", whoLink)..TRADE_LOG_DETAIL..":", 1, 1, 0);
			end
			if(hasSendAny) then
				DEFAULT_CHAT_FRAME:AddMessage("("..TRADE_LOG_HANDOUT..") "..strSend, 1, 0.8, 0.8);
			end
			if(hasReceiveAny) then
				DEFAULT_CHAT_FRAME:AddMessage("("..TRADE_LOG_RECEIVE..") "..strReceive, 0.8, 1, 0.8);
			end
		end

	elseif(curr().result == "cancelled") then
		msg = string.gsub(TRADE_LOG_CANCELLED, "%%t", whoLink);
		msg = string.gsub(msg, "%%r", CANCEL_REASON_TEXT[curr().reason]);
		DEFAULT_CHAT_FRAME:AddMessage(msg, 1, 0.5, 0.5);
	else
		msg = string.gsub(TRADE_LOG_FAILED, "%%t", whoLink);
		msg = string.gsub(msg, "%%r", curr().reason);
		DEFAULT_CHAT_FRAME:AddMessage(msg, 1, 0.1, 0.1);
	end

	if(TBT_AnnounceCB:GetChecked()) then
		TradeLog_AnnounceTrade(curr());
	end
end

--for saying in channel, so no links. And message can't be too lang
function TradeLog_AnnounceTrade(trade)
	local numPlayer, numTarget, enPlayer, enTarget, msg;
	if(not trade.who) then
		return;
	end

	numPlayer = 0; numTarget = 0;
	for i=1,6 do if(trade.playerItems[i]) then numPlayer = numPlayer + 1 end end
	for i=1,6 do if(trade.targetItems[i]) then numTarget = numTarget + 1 end end
	if(trade.playerItems[7] and trade.playerItems[7].name and trade.playerItems[7].enchantment) then enPlayer = trade.playerItems[7].enchantment end;
	if(trade.targetItems[7] and trade.targetItems[7].name and trade.targetItems[7].enchantment) then enTarget = trade.targetItems[7].enchantment end;

	local whoLink = trade.who;
	if(trade.result == "complete") then
		local hasSendAny, hasReceiveAny, strSend, strReceive

		hasSendAny = false;
		strSend = "";
		if(trade.playerMoney > 0) then
			if(hasSendAny) then strSend = strSend..", "; end
			hasSendAny = true;
			strSend = strSend..TradeLog_GetMoneyPlainText(trade.playerMoney);
		end

		if(numPlayer > 0) then
			if(hasSendAny) then strSend = strSend..", "; end
			hasSendAny = true;
			strSend = strSend..string.gsub(TRADE_LOG_ITEM_NUMBER, "%%d", numPlayer);
		end

		hasReceiveAny = false;
		strReceive = "";
		if(trade.targetMoney > 0) then
			if(hasReceiveAny) then strReceive = strReceive..", "; end
			hasReceiveAny = true;
			strReceive = strReceive..TradeLog_GetMoneyPlainText(trade.targetMoney);
		end

		if(numTarget > 0) then
			if(hasReceiveAny) then strSend = strSend..", "; end
			hasReceiveAny = true;
			strReceive = strReceive..string.gsub(TRADE_LOG_ITEM_NUMBER, "%%d", numTarget);
		end

		if(not hasSendAny and not hasReceiveAny) then
			msg = string.gsub(TRADE_LOG_SUCCESS_NO_EXCHANGE, "%%t", whoLink)
		else
			msg = string.gsub(TRADE_LOG_SUCCESS, "%%t", whoLink);

			if(hasSendAny) then
				msg = msg .."("..TRADE_LOG_HANDOUT..") "..strSend;
			end
			if(hasReceiveAny) then
				msg = msg.."("..TRADE_LOG_RECEIVE..") "..strReceive;
			end
		end

	elseif(trade.result == "cancelled") then
		msg = string.gsub(TRADE_LOG_CANCELLED, "%%t", whoLink);
		msg = string.gsub(msg, "%%r", CANCEL_REASON_TEXT_ANNOUNCE[curr().reason]);
	else
		msg = string.gsub(TRADE_LOG_FAILED, "%%t", whoLink);
		msg = string.gsub(msg, "%%r", trade.reason);
	end

	local channel = TradeLog_FindAnnounceChannel(TradeLog_AnnounceChannel);
	if(channel=="WHISPER")then
		SendChatMessage(msg,channel,nil,trade.who);
	else
		SendChatMessage(msg,channel);
	end
end

function TradeLog_FindAnnounceChannel(channel)
	--channel should be WHISPER, RAID, PARTY, SAY, YELL
	if(channel=="RAID") then
		if (IsInRaid()) then
			return "RAID";
		elseif ( IsInGroup() ) then
			return "PARTY";
		else
			return "SAY";
		end
	elseif(channel=="PARTY") then
		if ( IsInGroup() ) then
			return "PARTY";
		else
			return "SAY";
		end
	end
	return channel;
end

function TradeLog_GetMoneyColorText(money)
	local GSC_GOLD="ffd100"
	local GSC_SILVER="e6e6e6"
	local GSC_COPPER="c8602c"

	local g = math.floor( money / 10000 );
	local s = math.floor( money / 100 ) - g*100 ;
	local c = money - ( g * 100 + s ) * 100;

	local text = ""
	if(g>0) then text = text.."|cffffff00"..g.."|r".."|cff"..GSC_GOLD..TRADE_LOG_MONEY_NAME.gold.."|r"; end
	if(s>0) then text = text.."|cffffff00"..s.."|r".."|cff"..GSC_SILVER..TRADE_LOG_MONEY_NAME.silver.."|r"; end
	if(c>0) then text = text.."|cffffff00"..c.."|r".."|cff"..GSC_COPPER..TRADE_LOG_MONEY_NAME.copper.."|r"; end

	return text;
end

function TradeLog_GetMoneyPlainText(money)
	local g = math.floor( money / 10000 );
	local s = math.floor( money / 100 ) - g*100 ;
	local c = money - ( g * 100 + s ) * 100;

	local text = ""
	if(g>0) then text = text..g..TRADE_LOG_MONEY_NAME.gold; end
	if(s>0) then text = text..s..TRADE_LOG_MONEY_NAME.silver; end
	if(c>0) then text = text..c..TRADE_LOG_MONEY_NAME.copper; end

	return text;
end

--for UI
function TBT_AnnounceChannelDropDown_OnClick(self)
	UIDropDownMenu_SetSelectedValue(TBT_AnnounceChannelDropDown, self.value);
	TBT_AnnounceCB:SetChecked(1);
	TradeLog_AnnounceChannel = self.value;
end

function TBT_AnnounceChannelDropDown_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(getglobal("TBT_AnnounceChannelDropDown"));
	local info;

	info = {};
	info.text = TRADE_LOG_CHANNELS.whisper;
	info.func = TBT_AnnounceChannelDropDown_OnClick;
	info.value = "WHISPER"
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TRADE_LOG_CHANNELS.raid;
	info.func = TBT_AnnounceChannelDropDown_OnClick;
	info.value = "RAID"
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TRADE_LOG_CHANNELS.party;
	info.func = TBT_AnnounceChannelDropDown_OnClick;
	info.value = "PARTY"
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TRADE_LOG_CHANNELS.say;
	info.func = TBT_AnnounceChannelDropDown_OnClick;
	info.value = "SAY"
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TRADE_LOG_CHANNELS.yell;
	info.func = TBT_AnnounceChannelDropDown_OnClick;
	info.value = "YELL"
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);
end

local frame = CreateFrame("Frame");
frame:SetScript("OnEvent", TradeLog_OnEvent);
TradeLog_OnLoad(frame);
