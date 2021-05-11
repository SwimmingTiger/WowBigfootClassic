
local _
if(Skinner and 	Skinner.initialized) then Skinner.initialized.TradeFrame = true; end;

TBT_PORTAL_MAPPING = {
	[TBT_PORTAL_1]="Interface\\AddOns\\TheBurningTrade\\icons\\9.tga",
	[TBT_PORTAL_2]="Interface\\AddOns\\TheBurningTrade\\icons\\11.tga",
	[TBT_PORTAL_3]="Interface\\AddOns\\TheBurningTrade\\icons\\4.tga",
	[TBT_PORTAL_4]="Interface\\AddOns\\TheBurningTrade\\icons\\5.tga",
	[TBT_PORTAL_5]="Interface\\AddOns\\TheBurningTrade\\icons\\6.tga",
	[TBT_PORTAL_6]="Interface\\AddOns\\TheBurningTrade\\icons\\8.tga",
	[TBT_PORTAL_7]="Interface\\AddOns\\TheBurningTrade\\icons\\10.tga",
	[TBT_PORTAL_8]="Interface\\AddOns\\TheBurningTrade\\icons\\13.tga",
	[TBT_PORTAL_9]="Interface\\AddOns\\TheBurningTrade\\icons\\3.tga",
	[TBT_PORTAL_10]="Interface\\AddOns\\TheBurningTrade\\icons\\12.tga",
	[TBT_PORTAL_11]="Interface\\AddOns\\TheBurningTrade\\icons\\7.tga",
	[TBT_PORTAL_12]="Interface\\AddOns\\TheBurningTrade\\icons\\2.tga",
}
local function SetOrHookScript(frame, scriptName, func)
	if( frame:GetScript(scriptName) ) then
		frame:HookScript(scriptName, func);
	else
		frame:SetScript(scriptName, func);
	end
end

function TBTFrame_OnLoad(self)
	self:RegisterEvent("LOOT_READY");

	--display the trade recepient info
	local targetInfoText = TradeFrame:CreateFontString("TradeFrameTargetInfoText", "ARTWORK", "GameFontNormal");
	targetInfoText:SetWidth(100);
	targetInfoText:SetHeight(12);
	targetInfoText:SetJustifyH("RIGHT");
	targetInfoText:SetPoint("TOPLEFT", "TradeFrameRecipientNameText", "BOTTOMLEFT", 0, -8);
	hooksecurefunc("TradeFrame_OnShow", function(self)if(UnitExists("NPC"))then TradeFrameTargetInfoText:SetText(UnitClass("NPC").." - "..UnitLevel("NPC"));end end);

	--button for whisper
	local button = CreateFrame("Button", "TradeFrameTargetWhisperButton", TradeFrame, "UIPanelButtonTemplate");
	button:SetWidth(30);
	button:SetHeight(21);
	button:SetPoint("TOPLEFT", "TradeFrameTargetInfoText", "BOTTOMLEFT", 0, -2);
	button:SetText(TBT_RIGHT_BUTTON.whisper);
	button:SetScript("OnClick", function(self)
		ChatFrame_SendTell(TBT_UnitName("NPC"));
	end)

	--button for emote1
	button = CreateFrame("Button", "TradeFrameTargetEmote1Button", TradeFrame, "UIPanelButtonTemplate");
	button:SetWidth(30);
	button:SetHeight(21);
	button:SetPoint("LEFT", "TradeFrameTargetWhisperButton", "RIGHT", 5, 0);
	button:SetText(TBT_RIGHT_BUTTON.ask);
	button:SetScript("OnClick", function(self) DoEmote("hungry", "NPC") end);

	--button for emote2
	button = CreateFrame("Button", "TradeFrameTargetEmote2Button", TradeFrame, "UIPanelButtonTemplate");
	button:SetWidth(30);
	button:SetHeight(21);
	button:SetPoint("LEFT", "TradeFrameTargetEmote1Button", "RIGHT", 5, 0);
	button:SetText(TBT_RIGHT_BUTTON.thank);
	button:SetScript("OnClick", function(self) DoEmote("thank", "NPC") end);

	--button for click-targetting, positioned at portrait.
	button = CreateFrame("Button", "TradeFrameTargetRecipientButton", TradeFrame, "SecureActionButtonTemplate")
	button:SetAttribute("type", "target");
	button:SetAttribute("unit", "NPC");
	button:SetWidth(60)
	button:SetHeight(70)
	button:SetPoint("CENTER", "TradeFrame", "TOPLEFT", 210, -35);

	--for rightclick quick trade


	--for alt+leftclick quick trade
	hooksecurefunc("ContainerFrameItemButton_OnModifiedClick", function(self, button)
		if(button == "LeftButton" and IsAltKeyDown() ) then
			if(InboxFrame and InboxFrame:IsVisible()) then
				MailFrameTab_OnClick(nil, 2);
			end
			if(SendMailAttachment1 and SendMailAttachment1:IsVisible()) then
				UseContainerItem(self:GetParent():GetID(), self:GetID());
			elseif(AuctionsItemButton and AuctionsItemButton:IsVisible()) then
				PickupContainerItem(self:GetParent():GetID(), self:GetID());
				ClickAuctionSellItemButton();
				AuctionsFrameAuctions_ValidateAuction();
				if(CursorHasItem()) then ClearCursor(); end;
			end
		end

		--for shift+leftclick start auction search directly.
		if(button == "LeftButton" and IsShiftKeyDown() and AuctionFrame and AuctionFrame:IsVisible()) then
			--[[
			AuctionFrameTab_OnClick(nil, 1);
			if(BrowseMinLevel and BrowseMaxLevel and BrowseDropDown and IsUsableCheckButton) then
				BrowseMinLevel:SetText("")
				BrowseMaxLevel:SetText("")
				UIDropDownMenu_SetText("",BrowseDropDown)
				UIDropDownMenu_SetSelectedName(BrowseDropDown)
				AuctionFrameBrowse.selectedClassIndex = nil;
				AuctionFrameBrowse.selectedClass = nil;
				IsUsableCheckButton:SetChecked(false);
				AuctionFrameFilters_Update();
			end
			]]
			ChatEdit_InsertLink(GetContainerItemLink(self:GetParent():GetID(), self:GetID()));
			AuctionFrameBrowse_Search();
		end

		if(button=="RightButton" and IsControlKeyDown() and IsAltKeyDown() and AuctionsItemButton and AuctionsItemButton:IsVisible()) then
			PickupContainerItem(self:GetParent():GetID(), self:GetID());
			ClickAuctionSellItemButton();
			AuctionsFrameAuctions_ValidateAuction();
			AuctionsCreateAuctionButton_OnClick();
		end
	end)
	TBTFrame_OnPlayerEnter()
end

function TBTFrame_SetButtonSpell(button, spell)
	if not InCombatLockdown() then
		button:SetAttribute("type", "spell");
		button:SetAttribute("spell", spell);
		button.spellName = spell
	end
end

function TBT_TradeItem(self, type)
	local item, quantity,spell,maxRank,spells,i;
	maxRank = TBT_MaxSpellRank[type];
	if(maxRank) then
		TBTFrame_SetButtonSpell(self, "");
		local spells, npcLevel;
		spells = TBT_SPELL_TABLE[type];
		npcLevel = UnitLevel("npc");

		for i=maxRank, 1,-1 do
			if(spells[i].level <= npcLevel) then
				item = spells[i].item;
				spell = TBT_GetSpellName(spells[i].name, spells[i].rank); --localization
				break;
			end
		end

		if(type=="water" or type=="food") then
			quantity=15;
		else
			quantity=1;
		end

		local bag, slot = TBT_FindItem(item, quantity, type)
		if(slot) then
			local emptySlot = false;
			for i=1,6 do
				if(not GetTradePlayerItemInfo(i)) then
					emptySlot = true;
				end;
			end
			if(emptySlot) then
				PickupContainerItem(bag, slot);
				StackSplitFrame:Hide();
				TradeFrame_OnMouseUp();
				return;
			end
		end
		TBTFrame_SetButtonSpell(self, spell);
	end
end

function GetCurrentMageSpell()
	if not TBT_CurrentPortal then return end
	return TBT_CurrentPortal[1],TBT_CurrentPortal[2]
end

local function GetPortalTexture(spellName)
	if not spellName then return "" end
	return TBT_PORTAL_MAPPING[spellName]
end

function CreatePortalButtons(cbutton)
	TBT_MagePortalButtons = {}
	local radius = 45
	local angle = 22.5

	local button =CreateFrame("Button", "TradeFramePortalButtonCenter", TradeFrame, "TBTButtonTemplate");
	button:SetWidth(35);
	button:SetHeight(35);
	button:SetPoint("CENTER",cbutton,"CENTER")
	button:SetFrameStrata("DIALOG")
	TBTFrame_SetButtonSpell(button,TBT_CurrentPortal[1])
	button:Hide()
	button:SetScript("OnEnter",function(self)
		cbutton.stats='showed'
		TBTTooltip:ClearLines()
		TBTTooltip:SetOwner(self, "ANCHOR_LEFT");
		TBTTooltip:AddLine(self.spellName)
		TBTTooltip:Show()
	end)
	button:SetScript("OnLeave",function()
		TBTTooltip:Hide()
	end)

	button:SetScript("PreClick",function()
		cbutton.stats ='hidden'
	end)

	for _i,_spellInfo in pairs(TBT_MagePortals) do
		xoff = radius* cos(angle)
		yoff = radius* sin(angle)
		local button = CreateFrame("Button", "TradeFramePortalButton".._i, TradeFrame, "TBTButtonTemplate");
		button:SetWidth(26);
		button:SetHeight(26);
		button:SetNormalTexture(GetPortalTexture(_spellInfo[1]))
		button:SetFrameStrata("DIALOG")
		TBTFrame_SetButtonSpell(button,_spellInfo[1])
		button:SetPoint("CENTER",cbutton,"CENTER",-xoff,yoff)
		button:SetScript("OnLeave",function(button)
			TBTTooltip:Hide()
		end)
		button:SetScript("PreClick",function(button)
			TBT_CurrentPortal=_spellInfo
			TBTFrame_SetButtonSpell(cbutton,TBT_CurrentPortal[1])
			cbutton:SetNormalTexture(TBT_CurrentPortal[2]);
			cbutton.stats='hidden'
		end)
		button:SetScript("OnEnter",function(button)
			cbutton.stats='showed'
			TBTTooltip:ClearLines()
			TBTTooltip:SetOwner(button, "ANCHOR_LEFT");
			TBTTooltip:AddLine(button.spellName)
			TBTTooltip:Show()
		end)
		button:Hide()
		tinsert(TBT_MagePortalButtons,button)
		angle = angle + 45
	end
end

function TogglePortalPanel(tog)
	if tog == TBT_portalShown then return end

	_G.TBTPortalPanel:SetPoint("CENTER",TradeFramePlayerSpell3Button,"CENTER")
	_G.TBTPortalPanel:SetAlpha(0.7)
	_G.TBTPortalPanel:SetFrameStrata("HIGH")
	TBTFrame_SetButtonSpell(TradeFramePortalButtonCenter,TBT_CurrentPortal[1])
	TradeFramePortalButtonCenter:SetNormalTexture(GetPortalTexture(TBT_CurrentPortal[1]))
	if tog then
		TBTPortalPanel:Show()
		TradeFramePortalButtonCenter:Show()
		for _,_button in pairs(TBT_MagePortalButtons) do
			_button:Show()
		end
	else
		TBTPortalPanel:Hide()
		TradeFramePortalButtonCenter:Hide()
		for _,_button in pairs(TBT_MagePortalButtons) do
			_button:Hide()
		end
	end
	TBT_portalShown= tog

end

function TBTFrame_CreateLeftButton(class)
	if(getglobal("TradeFramePlayerSpell1Button")~=nil)then return end; --already created

	local button = nil;
	if(class=="MAGE") then
		--for make water button
		button = CreateFrame("Button", "TradeFramePlayerSpell1Button", TradeFrame, "TBTButtonTemplate");
		button:SetWidth(26);
		button:SetHeight(26);
		button:SetNormalTexture("Interface\\Icons\\inv_drink_18");
		button:SetPoint("TOPLEFT", "TradeFrame", "TOPLEFT", 60, -30);
		button:SetScript("PreClick", function(self) TBT_TradeItem(self, "water") end);
		button:SetScript("PostClick", function(self) TBTFrame_SetButtonSpell(self,"") end);

		button = CreateFrame("Button", "TradeFramePlayerSpell2Button", TradeFrame, "TBTButtonTemplate");
		button:SetWidth(26);
		button:SetHeight(26);
		button:SetNormalTexture("Interface\\Icons\\inv_misc_food_33");
		button:SetPoint("LEFT", "TradeFramePlayerSpell1Button", "RIGHT", 5, 0);
		button:SetScript("PreClick", function(self) TBT_TradeItem(self, "food") end);
		button:SetScript("PostClick", function(self) TBTFrame_SetButtonSpell(self,"") end);

		local spell,texture = GetCurrentMageSpell()
		if not spell then return end
		button = CreateFrame("Button", "TradeFramePlayerSpell3Button", TradeFrame, "TBTButtonTemplate");
		button:SetWidth(26);
		button:SetHeight(26);
		TBTFrame_SetButtonSpell(button,spell)
		button:SetNormalTexture(texture);
		button:SetPoint("LEFT", "TradeFramePlayerSpell2Button", "RIGHT", 5, 0);
		button:SetScript("PreClick", function(self) self.stats = 'hidden' end);
		button:SetScript("OnEnter", function(self)
			if not self.stats or self.stats =='hidden' then
				self.stats = 'entered'
				self.entertime = 0
			elseif self.stats =='left' then
				self.stats= 'showed'
			end
			--wait a second and pop up
			--pop up here
		end)

		button:SetScript("OnUpdate",function(self,elapsed)
			if not self.stats then return end
			if self.stats=='entered' then
				self.entertime = self.entertime + elapsed
			end
			if self.stats=='left' then
				self.lefttime = self.lefttime + elapsed
			end
			if self.stats=='entered' and self.entertime >=0.5 then
				self.stats='showed'
			end
			if self.stats=='left' and self.lefttime >=0.2 then
				self.stats='hidden'
			end
			if self.stats=='entered' or self.stats=='hidden' then
				TogglePortalPanel(false)
			elseif self.stats=='showed' or self.stats=='left' then
				TogglePortalPanel(true)
			end
		end)

		button:SetScript("OnLeave",function(self)
			if self.stats=='entered' then
				self.stats='hidden'
			end
		end)

		CreatePortalButtons(button)
	--	button:Hide()
		TBT_portalShown= false
	elseif (class=="WARLOCK") then
		button = CreateFrame("Button", "TradeFramePlayerSpell1Button", TradeFrame, "TBTButtonTemplate");
		button:SetWidth(26);
		button:SetHeight(26);
		button:SetNormalTexture("Interface\\Icons\\inv_stone_04");
		button:SetPoint("TOPLEFT", "TradeFrame", "TOPLEFT", 70, -30);
		button:SetScript("PreClick", function(self) TBT_TradeItem(self, "stone") end);
		button:SetScript("PostClick", function(self) TBTFrame_SetButtonSpell(self,"") end);
	elseif (class=="ROGUE") then
		button = CreateFrame("Button", "TradeFramePlayerSpell1Button", TradeFrame, "TBTButtonTemplate");
		button:SetWidth(30);
		button:SetHeight(30);
		button:SetNormalTexture("Interface\\Icons\\spell_nature_moonkey");
		button:SetPoint("TOPLEFT", "TradeFrame", "TOPLEFT", 70, -30);
		button:SetAttribute("type","spell");
		button:SetAttribute("spell", TBT_UNLOCK_SKILL_NAME);
		button:SetScript("PostClick", function(self) ClickTargetTradeButton(7); end);
	end
end

TBT_MaxSpellRank = nil;

function TBTFrame_OnPlayerEnter()
	local _,class = UnitClass("player")


	if(TBT_MaxSpellRank==nil) then
		TBT_MaxSpellRank = {};
		if(class=="MAGE")then
			TBT_MagePortals= {}
		end
		--look through player's spell book
		local i = 1
		local spellName, spellRank,spellIcon;
		while true do
			spellName, spellRank,spellIcon =nil,nil,nil;
			local function f()
				spellName, spellRank,spellIcon= GetSpellInfo(i, BOOKTYPE_SPELL);
			end
			pcall(f);
			local spellRankNum;
			if(spellRank) then _,_,spellRankNum = string.find(spellRank, TBT_SPELL_RANK_PATTERN); end
			if(spellRankNum) then spellRankNum = spellRankNum + 0; end

			if not spellName then
				do break end
			end



			if(class=="MAGE")then
				--collect portals

				if string.find(spellName,TBT_SPELL_PORTAL) then
					tinsert(TBT_MagePortals,{spellName,spellIcon})
				end
				UpdateMaxRank("water", spellName, spellRankNum);
				UpdateMaxRank("food", spellName, spellRankNum);
			elseif(class=="WARLOCK")then
				UpdateMaxRank("stone", spellName, spellRankNum);
			end
			i = i + 1
		end
		if(class=="MAGE")then
			TBT_CurrentPortal = TBT_CurrentPortal or TBT_MagePortals and TBT_MagePortals[1]
		end
	end
	TBTFrame_CreateLeftButton(class);
end

function TBTFrame_OnEvent(self, event, ...)
	if(GetNumLootItems() == 1) then
		local iconPath, _, _, _ = GetLootSlotInfo(1);
		if(string.find(iconPath, "Interface\\Icons\\INV_Enchant_") == 1) then
			LootSlot(1);
		end
	end
end

function UpdateMaxRank(type, spellName, spellRankNum)

	local spells = TBT_SPELL_TABLE[type];
	local j;
	for j = 1, table.getn(spells), 1 do
		if(spells[j].name==spellName and (not spells[j].rank or spells[j].rank==spellRankNum)) then
			TBT_debug(spellName, spellRankNum);
			if(not TBT_MaxSpellRank[type] or j > TBT_MaxSpellRank[type]) then
				TBT_MaxSpellRank[type] = j;
			end
		end
	end
end

function TBT_FindItem(item,quantity,type)
	local bag,slog,i;
	for bag=0,NUM_CONTAINER_FRAMES do
		for slot=1,GetContainerNumSlots(bag) do
			local _, count, locked, _ = GetContainerItemInfo(bag, slot)
			if (count and not locked and count >= quantity ) then
				local itemLink = GetContainerItemLink(bag, slot);
				local found, _, name = string.find(itemLink, "^|%x+|H.+|h%[(.+)%]")
				if item == name then
					TBT_debug("item==name",name);
					--to distinguish the healthstone made by other warlock
					if(type=="stone")then
						GameTooltip:SetOwner(UIParent,"ANCHOR_LEFT");
						GameTooltip:SetBagItem(bag,slot);
						for i=1,GameTooltip:NumLines(),1 do
							local text = getglobal("GameTooltipTextLeft"..i):GetText();
							if(text) then
								local _,_,name = string.find(text,TBT_GAMETOOLTIP_MADE_BY);
								if(name) then
									TBT_debug("name=",name);
									if(name==UnitName("player"))then
										GameTooltip:Hide();
										return bag,slot
									end
									break;
								end
							end
						end
						GameTooltip:Hide();
					else
						return bag, slot;
					end
				end
			end
		end
	end
	return nil,nil
end

function TBT_GetSpellName(name, rank)
	if(rank) then
		rank, _ = string.gsub(TBT_SPELL_RANK_PATTERN,"%(%%d%)", rank)
		return name.."("..rank..")";
	else
		return name;
	end
end

--for {name, server} return "name-server"
function TBT_UnitName(unit)
	local name,server = UnitName(unit);
	if(server) then
		return name.."-"..server;
	else
		return name;
	end
end

function TBT_debug(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	if(1) then return; end
	local msg = "";
	if(arg1) then msg = msg..arg1.."," else msg = msg.." ," end
	if(arg2) then msg = msg..arg2.."," else msg = msg.." ," end
	if(arg3) then msg = msg..arg3.."," else msg = msg.." ," end
	if(arg4) then msg = msg..arg4.."," else msg = msg.." ," end
	if(arg5) then msg = msg..arg5.."," else msg = msg.." ," end
	if(arg6) then msg = msg..arg6.."," else msg = msg.." ," end
	if(arg7) then msg = msg..arg7.."," else msg = msg.." ," end
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

