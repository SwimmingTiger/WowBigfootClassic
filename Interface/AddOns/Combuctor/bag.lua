
--[[
	ba.lua
		A bag button object
--]]

local Bag = Combuctor:NewClass('Button')
Combuctor.Bag = Bag

--local bindings
local L = LibStub('AceLocale-3.0'):GetLocale('Combuctor')
local InvData = Combuctor:GetModule('InventoryData')

--[[ Constructor/Destructor ]]--
local g_currAPIBagID = nil;	--暂存当前点击的背包系统ID，用于右键呼出背包菜单
local g_currBagID = nil;		--暂存当前点击的背包顺序ID，用于右键呼出背包菜单
local SIZE = 30
local NORMAL_TEXTURE_SIZE = 64 * (SIZE/36)

local unused = {}
local id = 1

function Bag:New(systemID)
	local bag = self:Bind(CreateFrame('Button', format('CombuctorBag%d', id)))
	local name = bag:GetName()
	bag.bagID = id;
	bag.bagName = name;
	bag:SetWidth(SIZE);
	bag:SetHeight(SIZE);

	local icon = bag:CreateTexture(name .. 'IconTexture', 'BORDER')
	icon:SetAllPoints(bag)

	local count = bag:CreateFontString(name .. 'Count', 'OVERLAY')
	count:SetFontObject('NumberFontNormalSmall')
	count:SetJustifyH('RIGHT')
	count:SetPoint('BOTTOMRIGHT', -2, 2)

	local nt = bag:CreateTexture(name .. 'NormalTexture')
	nt:SetTexture('Interface/Buttons/UI-Quickslot2')
	nt:SetWidth(NORMAL_TEXTURE_SIZE)
	nt:SetHeight(NORMAL_TEXTURE_SIZE)
	nt:SetPoint('CENTER', 0, -1)
	bag:SetNormalTexture(nt)

	local pt = bag:CreateTexture()
	pt:SetTexture('Interface/Buttons/UI-Quickslot-Depress')
	pt:SetAllPoints(bag)
	bag:SetPushedTexture(pt)

	local ht = bag:CreateTexture()
	ht:SetTexture('Interface/Buttons/ButtonHilight-Square')
	ht:SetAllPoints(bag)
	bag:SetHighlightTexture(ht)

	local typeIcon = bag:CreateTexture(nil, 'OVERLAY')
	typeIcon:SetSize(24, 24)
	typeIcon:SetPoint('BOTTOMRIGHT', bag, 'BOTTOMRIGHT',2,-2)
	typeIcon:Hide();
	if ( systemID > 0 and not IsInventoryItemProfessionBag("player", ContainerIDToInventoryID(systemID)) ) then
		for i = LE_BAG_FILTER_FLAG_EQUIPMENT, NUM_LE_BAG_FILTER_FLAGS do
			local active = false;
			if ( systemID > NUM_BAG_SLOTS ) then
				active = GetBankBagSlotFlag(systemID - NUM_BAG_SLOTS, i);
			else
				active = GetBagSlotFlag(systemID, i);
			end
			if ( active ) then
				typeIcon:SetAtlas(BAG_FILTER_ICONS[i], true);
				typeIcon:Show();
				break;
			end
		end
	end
	bag.typeIcon = typeIcon;

	bag:RegisterForClicks('anyUp')
	bag:RegisterForDrag('LeftButton')

	bag:SetScript('OnEnter', self.OnEnter)
	bag:SetScript('OnLeave', self.OnLeave)
	bag:SetScript('OnClick', self.OnClick)
	bag:SetScript('OnDragStart', self.OnDrag)
	bag:SetScript('OnReceiveDrag', self.OnClick)
	bag:SetScript('OnEvent', self.OnEvent)

	id = id + 1
	return bag
end

--sequenceID为背包的顺序ID，systemID为系统查询背包状态所用的背包ID
function Bag:Get(sequenceID, systemID)
	for val,id in pairs(unused)do
		if id and id == sequenceID then
			unused[val] = nil
			return val;
		end
	end
	return self:New(systemID)
end

function Bag:Set(parent, id)
	self:SetID(id)
	self:SetParent(parent)

	if id == BACKPACK_CONTAINER or id == BANK_CONTAINER then
		SetItemButtonTexture(self, 'Interface/Buttons/Button-Backpack-Up')
		SetItemButtonTextureVertexColor(self, 1, 1, 1)
	elseif id == REAGENTBANK_CONTAINER then
		SetItemButtonTexture(self, 'Interface/Icons/Achievement_GuildPerk_BountifulBags')
		if IsReagentBankUnlocked() then
			SetItemButtonTextureVertexColor(self, 1, 1, 1)
		else
			SetItemButtonTextureVertexColor(self, 1, 0.1, 0.1)
		end
	else
		self:Update()

		self:RegisterEvent('ITEM_LOCK_CHANGED')
		self:RegisterEvent('CURSOR_UPDATE')
		self:RegisterEvent('BAG_UPDATE')
		self:RegisterEvent('PLAYERBANKSLOTS_CHANGED')

		if InvData:IsBankBag(self:GetID()) then
			self:RegisterEvent('BANKFRAME_OPENED')
			self:RegisterEvent('BANKFRAME_CLOSED')
			self:RegisterEvent('PLAYERBANKBAGSLOTS_CHANGED')
			-- self:RegisterEvent('REAGENTBANK_PURCHASED')
		end
	end
end

function Bag:Release()
	unused[self] = self.bagID;

	self.cached = nil
	self.hasItem = nil
	self:SetParent(nil)
	self:Hide()
	self:UnregisterAllEvents()
	_G[self:GetName() .. 'Count']:Hide()
end


--[[ Events ]]--

function Bag:OnEvent(event)
	if event == 'BANKFRAME_OPENED' or event == 'BANKFRAME_CLOSED' then
		self:Update()
	elseif not InvData:IsCachedBag(self:GetID(), self:GetParent():GetPlayer()) then
		if event == 'ITEM_LOCK_CHANGED' then
			self:UpdateLock()
		elseif event == 'CURSOR_UPDATE' then
			self:UpdateCursor()
		elseif event == 'BAG_UPDATE' or event == 'PLAYERBANKSLOTS_CHANGED' or event == 'REAGENTBANK_PURCHASED' then
			self:Update()
		elseif event == 'PLAYERBANKBAGSLOTS_CHANGED' then
			self:Update()
		end
	end
end


--[[ Update ]]--

function Bag:Update()
	self:UpdateLock()
	self:UpdateTexture()

	-- Update repair all button status
	if MerchantRepairAllIcon then
		local repairAllCost, canRepair = GetRepairAllCost()
		if canRepair then
			SetDesaturation(MerchantRepairAllIcon, nil)
			MerchantRepairAllButton:Enable()
		else
			SetDesaturation(MerchantRepairAllIcon, true)
			MerchantRepairAllButton:Disable()
		end
	end
end

function Bag:UpdateLock()
	local id = self:GetID()
	local player = self:GetParent():GetPlayer()

	if IsInventoryItemLocked(InvData:GetInvSlot(id)) and not InvData:IsCachedBag(id, player) then
		_G[self:GetName() .. 'IconTexture']:SetDesaturated(true)
	else
		_G[self:GetName() .. 'IconTexture']:SetDesaturated(false)
	end
end

function Bag:UpdateCursor()
	local invSlot = InvData:GetInvSlot(self:GetID())
	if CursorCanGoInSlot(invSlot) then
		self:LockHighlight()
	else
		self:UnlockHighlight()
	end
end

--actually, update texture and count
function Bag:UpdateTexture()
	local id = self:GetID()
	if id > 0 or id == REAGENTBANK_CONTAINER then
		if InvData:IsCachedBag(id, self:GetParent():GetPlayer()) then
			if BagnonDB then
				self:UpdateTextureFromCache()
			end
		else
			self:UpdateTextureFromLive()
		end
	end
end

function Bag:UpdateTextureFromLive()
	local id = self:GetID()
	local texture = GetInventoryItemTexture('player', InvData:GetInvSlot(id))

	if texture then
		self.hasItem = true
		SetItemButtonTexture(self, texture)
		SetItemButtonTextureVertexColor(self, 1, 1, 1)
	else
		self.hasItem = nil
		if id == REAGENTBANK_CONTAINER then
			SetItemButtonTexture(self, 'Interface/Icons/Achievement_GuildPerk_BountifulBags')
			if IsReagentBankUnlocked() then
				SetItemButtonTextureVertexColor(self, 1, 1, 1)
			else
				SetItemButtonTextureVertexColor(self, 1, 0.1, 0.1)
			end
		else
			--color red if the bag can be purchased
			SetItemButtonTexture(self, 'Interface/PaperDoll/UI-PaperDoll-Slot-Bag')
			if id > (GetNumBankSlots() + 4) then
				SetItemButtonTextureVertexColor(self, 1, 0.1, 0.1)
			else
				SetItemButtonTextureVertexColor(self, 1, 1, 1)
			end
		end
	end

	--update count
	self:SetCount(GetInventoryItemCount('player', InvData:GetInvSlot(id)))
end

function Bag:UpdateTextureFromCache()
	local id = self:GetID()
	local player = self:GetParent():GetPlayer()

	local size, link, count, texture = BagnonDB:GetBagData(id, player)
	if link then
		self.hasItem = true
		SetItemButtonTexture(self, texture)
		SetItemButtonTextureVertexColor(self, 1, 1, 1)
	else
		if id == REAGENTBANK_CONTAINER then
			SetItemButtonTexture(self, 'Interface/Icons/Achievement_GuildPerk_BountifulBags')
			if IsReagentBankUnlocked() then
				SetItemButtonTextureVertexColor(self, 1, 1, 1)
			else
				SetItemButtonTextureVertexColor(self, 1, 0.1, 0.1)
			end
		else
			--color red if the bag can be purchased
			SetItemButtonTexture(self, 'Interface/PaperDoll/UI-PaperDoll-Slot-Bag')
			if id > (GetNumBankSlots() + 4) then
				SetItemButtonTextureVertexColor(self, 1, 0.1, 0.1)
			else
				SetItemButtonTextureVertexColor(self, 1, 1, 1)
			end
		end
		self.hasItem = nil
	end

	--update count
	self:SetCount(count)
end

function Bag:SetCount(count)
	local text = _G[self:GetName() .. 'Count']
	local count = count or 0
	if count > 1 then
		if count > 999 then
			text:SetFormattedText('%.1fk', count/1000)
		else
			text:SetText(count)
		end
		text:Show()
	else
		text:Hide()
	end
end

--[[ Frame Events ]]--

function Bag:OnClick(button)
	local parent = self:GetParent()
	local player = parent:GetPlayer()
	local bagID = self:GetID()
	local link = InvData:GetBagLink(bagID, player)

	if button == "RightButton" then
		g_currAPIBagID = bagID;
		g_currBagID = self.bagID;
		ToggleDropDownMenu(1, nil, bfCtFilterDropDown, self:GetName(), 32, 10);
	else
		if not((link and HandleModifiedItemClick(link)) or InvData:IsCachedBag(bagID, player)) then
			if CursorHasItem() and not InvData:IsCachedBag(bagID, player) then
				if bagID == BACKPACK_CONTAINER then
					PutItemInBackpack()
				-- elseif bagID == KEYRING_CONTAINER then
					-- PutKeyInKeyRing()
				elseif bagID == REAGENTBANK_CONTAINER then		--
					PutItemInBackpack()
				else
					PutItemInBag(ContainerIDToInventoryID(bagID))
				end
			elseif bagID == REAGENTBANK_CONTAINER or bagID > (GetNumBankSlots() + 4) then
				self:PurchaseSlot()
			elseif bagID > 0 then
				-- PlaySound('BAGMENUBUTTONPRESS')
				PickupBagFromSlot(InvData:GetInvSlot(bagID))
			end
		end
	end
end

function Bag:OnDrag()
	local parent = self:GetParent()
	local player = parent:GetPlayer()
	local bagID = self:GetID()

	if not(InvData:IsCachedBag(bagID, player) or bagID <= 0) then
		-- PlaySound('BAGMENUBUTTONPRESS')
		PickupBagFromSlot(InvData:GetInvSlot(bagID))
	end
end

--drop down menu
function CombuctorFilterDropDown_OnLoad()
	if not g_currAPIBagID or not g_currBagID then return end
	local id = g_currAPIBagID;	--系统所需的背包id
	local CFDD_currBag = _G["CombuctorBag"..g_currBagID];

	if (id > NUM_BAG_SLOTS + NUM_BANKBAGSLOTS) then
		return;
	end

	local info = UIDropDownMenu_CreateInfo();

	if (id > 0 and not IsInventoryItemProfessionBag("player", ContainerIDToInventoryID(id))) then -- The actual bank has ID -1, backpack has ID 0, we want to make sure we're looking at a regular or bank bag
		info.text = BAG_FILTER_ASSIGN_TO;
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);

		info.isTitle = nil;
		info.notCheckable = nil;
		info.tooltipWhileDisabled = 1;
		info.tooltipOnButton = 1;

		for i = LE_BAG_FILTER_FLAG_EQUIPMENT, NUM_LE_BAG_FILTER_FLAGS do
			if ( i ~= LE_BAG_FILTER_FLAG_JUNK ) then
				info.text = BAG_FILTER_LABELS[i];
				info.func = function(_, _, _, value)	--value表示当前选项之前是否已被选中
					value = not value;
					if (id > NUM_BAG_SLOTS) then
						SetBankBagSlotFlag(id - NUM_BAG_SLOTS, i, value);
					else
						SetBagSlotFlag(id, i, value);
					end
					if (value) then		--若当前操作是想开启该功能
						CFDD_currBag.localFlag = i;
						CFDD_currBag.typeIcon:SetAtlas(BAG_FILTER_ICONS[i]);
						CFDD_currBag.typeIcon:Show();
					else				--若是想关闭
						CFDD_currBag.typeIcon:Hide();
						CFDD_currBag.localFlag = -1;
					end
				end;
				if (CFDD_currBag.localFlag) then
					info.checked = CFDD_currBag.localFlag == i;
				else
					if (id > NUM_BAG_SLOTS) then
						info.checked = GetBankBagSlotFlag(id - NUM_BAG_SLOTS, i);
					else
						info.checked = GetBagSlotFlag(id, i);
					end
				end
				info.disabled = nil;
				info.tooltipTitle = nil;
				UIDropDownMenu_AddButton(info);
			end
		end
	end

	info.text = BAG_FILTER_CLEANUP;
	info.isTitle = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);

	info.isTitle = nil;
	info.notCheckable = nil;
	info.isNotRadio = true;
	info.disabled = nil;

	info.text = BAG_FILTER_IGNORE;
	info.func = function(_, _, _, value)
		if (id == -1) then
			SetBankAutosortDisabled(not value);
		elseif (id == 0) then
			SetBackpackAutosortDisabled(not value);
		elseif (id > NUM_BAG_SLOTS) then
			SetBankBagSlotFlag(id - NUM_BAG_SLOTS, LE_BAG_FILTER_FLAG_IGNORE_CLEANUP, not value);
		else
			SetBagSlotFlag(id, LE_BAG_FILTER_FLAG_IGNORE_CLEANUP, not value);
		end
	end;
	if (id == -1) then
		info.checked = GetBankAutosortDisabled();
	elseif (id == 0) then
		info.checked = GetBackpackAutosortDisabled();
	elseif (id > NUM_BAG_SLOTS) then
		info.checked = GetBankBagSlotFlag(id - NUM_BAG_SLOTS, LE_BAG_FILTER_FLAG_IGNORE_CLEANUP);
	else
		info.checked = GetBagSlotFlag(id, LE_BAG_FILTER_FLAG_IGNORE_CLEANUP);
	end
	UIDropDownMenu_AddButton(info);
end

--tooltip functions
function Bag:OnEnter()
	local frame = self:GetParent()
	local player = frame:GetPlayer()
	local bagID = self:GetID()

	self:AnchorTooltip()

	--backpack tooltip
	if bagID == BACKPACK_CONTAINER then
		GameTooltip:SetText(BACKPACK_TOOLTIP, 1, 1, 1)
	--bank specific code
	elseif bagID == BANK_CONTAINER then
		GameTooltip:SetText(L.Bank, 1, 1, 1)
	--keyring specific code...again
	-- elseif bagID == KEYRING_CONTAINER then
		-- GameTooltip:SetText(KEYRING, 1, 1, 1)
	--cached bags
	elseif InvData:IsCachedBag(bagID, player) then
		if BagnonDB then
			local link = select(2, BagnonDB:GetBagData(bagID, player))
			if link then
				GameTooltip:SetHyperlink(link)
			else
				local numBankSlots = BagnonDB:GetNumBankSlots(player);
				if bagID == REAGENTBANK_CONTAINER then
					GameTooltip:SetText(REAGENT_BANK, 1, 1, 1)
					if player == UnitName('player') then
						SetTooltipMoney(GameTooltip, GetReagentBankCost())
					end
				elseif numBankSlots and bagID > (numBankSlots + 4) then
					GameTooltip:SetText(BANK_BAG_PURCHASE, 1, 1, 1)
					if player == UnitName('player') then
						SetTooltipMoney(GameTooltip, GetBankSlotCost(GetNumBankSlots()))
					end
				else
					GameTooltip:SetText(EQUIP_CONTAINER, 1, 1, 1)
				end
			end
		end
	--non cached bags
	else
		if bagID == REAGENTBANK_CONTAINER then
			GameTooltip:SetText(REAGENT_BANK, 1, 1, 1)
			if not IsReagentBankUnlocked() then
				GameTooltip:AddLine(L.ClickToPurchase)
				SetTooltipMoney(GameTooltip, GetReagentBankCost())
			end
		else
			--if we don't set a tooltip (meaning there's an item) then determine if the slot is just empty, or an unpurchased bank slot
			--show the purchase cost if its unpurchased
			if not GameTooltip:SetInventoryItem('player', InvData:GetInvSlot(bagID)) then
				if bagID > (GetNumBankSlots() + 4) then
					GameTooltip:SetText(BANK_BAG_PURCHASE, 1, 1, 1)
					GameTooltip:AddLine(L.ClickToPurchase)
					SetTooltipMoney(GameTooltip, GetBankSlotCost(GetNumBankSlots()));
				else
					GameTooltip:SetText(EQUIP_CONTAINER, 1, 1, 1)
				end
			end
		end
	end
	GameTooltip:Show()

	self:GetParent().itemFrame:HighlightBag(bagID)
end

Bag.UpdateTooltip = Bag.OnEnter

function Bag:OnLeave()
	GameTooltip:Hide()
	self:GetParent().itemFrame:HighlightBag(nil)
end


--[[ InvDataity Functions ]]--

--place the tooltip
function Bag:AnchorTooltip()
	if self:GetRight() > (GetScreenWidth()/2) then
		GameTooltip:SetOwner(self, 'ANCHOR_LEFT')
	else
		GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
	end
end

--show the purchase slot dialog
function Bag:PurchaseSlot()
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION)
	if self:GetID() == REAGENTBANK_CONTAINER then
		if not IsReagentBankUnlocked() then
			StaticPopup_Show('CONFIRM_BUY_REAGENTBANK_TAB')
		end
	else
		if not StaticPopupDialogs['CONFIRM_BUY_BANK_SLOT_COMBUCTOR'] then
			StaticPopupDialogs['CONFIRM_BUY_BANK_SLOT_COMBUCTOR'] = {
				text = CONFIRM_BUY_BANK_SLOT,
				button1 = YES,
				button2 = NO,

				OnAccept = function(self) PurchaseSlot() end,

				OnShow = function(self) MoneyFrame_Update(self:GetName().. 'MoneyFrame', GetBankSlotCost(GetNumBankSlots())) end,

				hasMoneyFrame = 1,
				timeout = 0,
				hideOnEscape = 1,
			}
		end
		StaticPopup_Show('CONFIRM_BUY_BANK_SLOT_COMBUCTOR')
	end
end