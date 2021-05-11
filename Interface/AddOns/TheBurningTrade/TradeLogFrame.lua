function TradeLogFrame_OnLoad(self)
	table.insert(UISpecialFrames, self:GetName()); --for esc close frame

	local TradeLog_SetHyperlink_Origin = ItemRefTooltip.SetHyperlink;
	ItemRefTooltip.SetHyperlink = function(self,link)
	   if(strsub(link, 1, 8)=="tradelog") then
		HideUIPanel(self);
	        return;
	   end
	   return TradeLog_SetHyperlink_Origin(self,link);
	end
	hooksecurefunc("SetItemRef", TradeLogFrame_SetItemRef);
end

function TradeLogFrame_SetItemRef(link, text, button)
	if ( strsub(link, 1, 8) == "tradelog" ) then
		local id = 0+gsub(gsub(strsub(link,10),"/2","|"),"/1","/");
		if(id and TradeLog_TradesHistory) then
			for _, v in pairs(TradeLog_TradesHistory) do
				if(v.id==id) then
					TradeLogFrame_FillDetailLog(v);
					TradeLogFrame:Show();
					return;
				end
			end
		end
	end
end;

function TradeLogFrame_FillDetailLog(trade)
	--DEFAULT_CHAT_FRAME:AddMessage("|CFF00B4FF|Htradelog:"..trade.id.."|h[TradeLog]|h|r");
	MoneyFrame_Update("TradeLogRecipientMoneyFrame", trade.targetMoney);
	MoneyFrame_Update("TradeLogPlayerMoneyFrame", trade.playerMoney);

	TradeLogFramePlayerNameText:SetText(trade.player);
	TradeLogFrameRecipientNameText:SetText(trade.who);
	TradeLogFrameWhenWhereText:SetText(trade.when.." - "..trade.where);

	for i=1,7 do
		TradeLogFrame_UpdateItem(getglobal("TradeLogPlayerItem"..i), trade.playerItems[i]);
		TradeLogFrame_UpdateItem(getglobal("TradeLogRecipientItem"..i), trade.targetItems[i]);
	end
end

function TradeLogFrame_UpdateItem(frame, item)
	if(item) then
		TradeLogFrame_UpdateItemDetail(frame, item.name, item.texture, item.numItems, item.isUsable, item.enchantment, item.itemLink);
	else
		TradeLogFrame_UpdateItemDetail(frame);
	end
end

function TradeLogFrame_UpdateItemDetail(frame, name, texture, numItems, isUsable, enchantment, itemLink)
	local frameName = frame:GetName();
	local id = frame:GetID();
	local buttonText = getglobal(frameName.."Name");

	if(itemLink) then
		local found, _, itemString = string.find(itemLink, "^|%x+|H(.+)|h%[.+%]")
		frame.itemLink = itemString;
	else
		frame.itemLink = nil
	end

	--ChatFrame1:AddMessage(itemLink, "\124", "\124\124"))
	-- See if its the enchant slot
	if ( id == 7 ) then
		if ( name ) then
			if ( enchantment ) then
				buttonText:SetText(GREEN_FONT_COLOR_CODE..enchantment..FONT_COLOR_CODE_CLOSE);
			else
				buttonText:SetText(HIGHLIGHT_FONT_COLOR_CODE..TRADEFRAME_NOT_MODIFIED_TEXT..FONT_COLOR_CODE_CLOSE);
			end
		else
			buttonText:SetText("");
		end

	else
		buttonText:SetText(name);
	end
	buttonText:SetTextHeight(12);
	TradeLogRecipientMoneyFrame:SetScale(0.9);
	TradeLogPlayerMoneyFrame:SetScale(0.9);
	local tradeItemButton = getglobal(frameName.."ItemButton");
	local tradeItem = frame;
	SetItemButtonTexture(tradeItemButton, texture);
	SetItemButtonCount(tradeItemButton, numItems);
	if ( isUsable or not name ) then
		SetItemButtonTextureVertexColor(tradeItemButton, 1.0, 1.0, 1.0);
		SetItemButtonNameFrameVertexColor(tradeItem, 1.0, 1.0, 1.0);
		SetItemButtonSlotVertexColor(tradeItem, 1.0, 1.0, 1.0);
	else
		SetItemButtonTextureVertexColor(tradeItemButton, 0.9, 0, 0);
		SetItemButtonNameFrameVertexColor(tradeItem, 0.9, 0, 0);
		SetItemButtonSlotVertexColor(tradeItem, 1.0, 0, 0);
	end
end

function TradeListScrollFrame_Update(self)
	local line,offset,count;

	count=0;
	if(TradeListOnlyCompleteCB:GetChecked()) then
		for _, v in pairs(TradeLog_TradesHistory) do
			if(v.result=="complete")then count=count+1 end
		end
	else
		count = table.getn(TradeLog_TradesHistory);
	end

	FauxScrollFrame_Update(TradeListScrollFrame,count,15,16);

	if(not FauxScrollFrame_GetOffset(TradeListScrollFrame)) then
		offset = 1;
	else
		offset=FauxScrollFrame_GetOffset(TradeListScrollFrame)+1;
		if(TradeListOnlyCompleteCB:GetChecked()) then
			for k, v in pairs(TradeLog_TradesHistory) do
				if(v.result=="complete")then offset = offset - 1 end;
				if(offset == 0) then
					offset = k;
					break;
				end
			end
		end
	end
	line=1
	while line<=15 do
		if offset<=table.getn(TradeLog_TradesHistory) then
			local trade=TradeLog_TradesHistory[offset];
			if(not TradeListOnlyCompleteCB:GetChecked() or trade.result=="complete") then
				local _,_,month,day,hour,min = string.find(trade.when, "(%d+)-(%d+) (%d+):(%d+)")
				getglobal("TradeListFrameButton"..line).offset = offset;

				getglobal("TradeListFrameButton"..line.."Time"):SetText(month..TRADE_LIST_MONTH_SUFFIX..day..TRADE_LIST_DAY_SUFFIX.." "..hour..":"..min);
				getglobal("TradeListFrameButton"..line.."Target"):SetText(trade.who);
				getglobal("TradeListFrameButton"..line.."Zone"):SetText(trade.where);
				getglobal("TradeListFrameButton"..line.."Result"):SetText(TRADE_LIST_RESULT_TEXT_SHORT[trade.result]);
				getglobal("TradeListFrameButton"..line):Show();

				getglobal("TradeListFrameButton"..line.."SendMoneyIcon"):Hide();
				getglobal("TradeListFrameButton"..line.."SendItemIcon"):Hide();
				getglobal("TradeListFrameButton"..line.."SendItemNum"):Hide();
				getglobal("TradeListFrameButton"..line.."ReceiveMoneyIcon"):Hide();
				getglobal("TradeListFrameButton"..line.."ReceiveItemIcon"):Hide();
				getglobal("TradeListFrameButton"..line.."ReceiveItemNum"):Hide();

				if(trade.result=="complete")then
					if(trade.playerMoney>0)then getglobal("TradeListFrameButton"..line.."SendMoneyIcon"):Show(); end
					local numSend = 0;
					for i=1,6 do if(trade.playerItems[i]) then numSend = numSend + 1 end end
					if(numSend>0)then
						getglobal("TradeListFrameButton"..line.."SendItemIcon"):Show();
						getglobal("TradeListFrameButton"..line.."SendItemNum"):Show();
						getglobal("TradeListFrameButton"..line.."SendItemNum"):SetText("x"..numSend);
					end

					if(trade.targetMoney>0)then getglobal("TradeListFrameButton"..line.."ReceiveMoneyIcon"):Show(); end
					local numReceive = 0;
					for i=1,6 do if(trade.targetItems[i]) then numReceive = numReceive + 1 end end
					if(numReceive>0)then
						getglobal("TradeListFrameButton"..line.."ReceiveItemIcon"):Show();
						getglobal("TradeListFrameButton"..line.."ReceiveItemNum"):Show();
						getglobal("TradeListFrameButton"..line.."ReceiveItemNum"):SetText("x"..numReceive);
					end

					getglobal("TradeListFrameButton"..line.."Time"   ):SetTextColor(1.0, .82, 0.0);
					getglobal("TradeListFrameButton"..line.."Target" ):SetTextColor(1.0, 1.0, 1.0);
					getglobal("TradeListFrameButton"..line.."Zone"   ):SetTextColor(1.0, 1.0, 1.0);
					getglobal("TradeListFrameButton"..line.."Result" ):SetTextColor(1.0, 1.0, 1.0);
				elseif(trade.result=="cancelled")then
					getglobal("TradeListFrameButton"..line.."Time"   ):SetTextColor(0.5, 0.3, 0.3);
					getglobal("TradeListFrameButton"..line.."Target" ):SetTextColor(0.5, 0.3, 0.3);
					getglobal("TradeListFrameButton"..line.."Zone"   ):SetTextColor(0.5, 0.3, 0.3);
					getglobal("TradeListFrameButton"..line.."Result" ):SetTextColor(0.5, 0.3, 0.3);
				else
					getglobal("TradeListFrameButton"..line.."Time"   ):SetTextColor(0.8, 0.2, 0.2);
					getglobal("TradeListFrameButton"..line.."Target" ):SetTextColor(0.8, 0.2, 0.2);
					getglobal("TradeListFrameButton"..line.."Zone"   ):SetTextColor(0.8, 0.2, 0.2);
					getglobal("TradeListFrameButton"..line.."Result" ):SetTextColor(0.8, 0.2, 0.2);
				end

				line=line+1
			end
		else
			getglobal("TradeListFrameButton"..line):Hide();
			line=line+1
		end
		offset=offset+1
	end
end

StaticPopupDialogs["TRADE_LOG_CLEAR_HISTORY"] = {
	text = "CLEAR TRADE HISTORY",
	button1 = ACCEPT,
	button2 = CANCEL,
	whileDead = 1,
	OnShow = function(self)
		getglobal(self:GetName().."Text"):SetText(TRADE_LIST_CLEAR_CONFIRM);
	end,
	OnAccept = function(self)
		TradeLog_KeepOnlyToday();
	end,
	timeout = 0,
	hideOnEscape = 1
};

function TradeLog_KeepOnlyToday()
	local today = {
		month = date("%m"),
		day = date("%d"),
	}
	for k, v in pairs(TradeLog_TradesHistory) do
		local _,_,month,day,hour,min = string.find(v.when, "(%d+)-(%d+) (%d+):(%d+)");
		if(month==today.month and day==today.day)then
			local tmp = {}
			for i=k, table.getn(TradeLog_TradesHistory) do
				table.insert(tmp, TradeLog_TradesHistory[i]);
			end
			TradeLog_TradesHistory = nil;
			TradeLog_TradesHistory = tmp;
			TradeListScrollFrame_Update();
			return;
		end
	end

	TradeLog_TradesHistory = nil;
	TradeLog_TradesHistory = {};
	TradeListScrollFrame_Update();
end

function TradeListFrame_TradeTooltip(self, trade)
	GameTooltip_SetDefaultAnchor(GameTooltip, self);
	if(trade.result=="complete")then
		GameTooltip:SetText(TRADE_LIST_RESULT_TEXT.complete, 1, 1, 1);
		GameTooltip:AddLine(TRADE_LIST_COMPLETE_TOOLTIP, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	elseif(trade.result=="cancelled")then
		GameTooltip:SetText(TRADE_LIST_RESULT_TEXT.cancelled, 1, 0.5, 0.5);
		GameTooltip:AddLine(CANCEL_REASON_TEXT[trade.reason], NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	else
		GameTooltip:SetText(TRADE_LIST_RESULT_TEXT.error, 1, 0.1, 0.1);
		GameTooltip:AddLine(trade.reason, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	end
	GameTooltip:Show();
end

function TradeListFrame_ShowDetail(trade)
	TradeLogFrame:Hide();
	if(trade.result=="complete")then
		TradeLogFrame_FillDetailLog(trade);
		TradeLogFrame:Show();
	end;
end;

function InitialMovableMinimapButton(ButtonName, PosVariableName, UseSquareMap)
	local button = getglobal(ButtonName);
	if(not button) then return nil; end

	button["POS"] = PosVariableName;
	button["square"] = UseSquareMap;
	button.updateTimer = 0;
	button:RegisterForDrag("LeftButton");

	button:SetScript("OnDragStart", function(self)
		self:LockHighlight();
		self:StartTimer();
	end)

	button:SetScript("OnDragStop", function(self)
		self:StopTimer();
		self:UnlockHighlight();
	end)

	button.MovingPos = function(self)
		local xpos,ypos
		local IconPos = getglobal(self["POS"]);

		if self["square"] then
			xpos = 110 * cos(IconPos or 0)
			ypos = 110 * sin(IconPos or 0)
			xpos = math.max(-82,math.min(xpos,84))
			ypos = math.max(-86,math.min(ypos,82))
		else
			xpos = 82*cos(IconPos or 0)
			ypos = 82*sin(IconPos or 0)
		end

		button:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-xpos,ypos-52)
	end

	button.Dragging = function(self)
		local xpos,ypos = GetCursorPosition()
		local xmin,ymin = Minimap:GetLeft() or 400, Minimap:GetBottom() or 400
		xpos = xmin-xpos/Minimap:GetEffectiveScale()+70
		ypos = ypos/Minimap:GetEffectiveScale()-ymin-70
		setglobal( self["POS"], math.deg(math.atan2(ypos,xpos)) )
		self:MovingPos();
	end

	button.StartTimer = function(self)
		self:SetScript("OnUpdate", function (self, elapsed)
			self.updateTimer = self.updateTimer + elapsed;
			if(self.updateTimer >= 0) then
				self:Dragging();
				self.updateTimer = 0;
			end
		end )
	end

	button.StopTimer = function(self)
		self:SetScript("OnUpdate", nil);
	end

end

function TradeListFrame_MiniMapToggle(tog)
	if tog then
		if(_G.TradeListFrameButton.POS == nil) then
			setglobal(TradeListFrameButton.POS, 190);
		end
		TradeListFrameButton:MovingPos();
		TradeListFrameButton:Show();
	else
		TradeListFrameButton:Hide();
	end
end
