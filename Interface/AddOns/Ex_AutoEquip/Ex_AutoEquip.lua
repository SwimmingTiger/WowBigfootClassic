--[[

Enigma Auto Equip
http://luodan.com

Quickly swap/define your suites with one click.

Code inspired by Bigfoot autoequip, but totally re-wrote.
Thanks to Bigfoot staff.

History
2005.09.13 Version 1.0.1
* Localization string adjusted.

2005.09.07 Version 1.0
* Initial release.

2007-9-12
update 1.1.1 by Bryan

2019-9-9
update 1.1.2 by Isler
]]

-- Consts
ExAE_Version = "1.1.2";

ExAE_Slots = { 
	"HeadSlot", 
	"NeckSlot", 
	"ShoulderSlot", 
	"BackSlot", 
	"ChestSlot", 
	"ShirtSlot", 
	"TabardSlot", 
	"WristSlot", 
	"HandsSlot", 
	"WaistSlot", 
	"LegsSlot", 
	"FeetSlot", 
	"Finger0Slot", 
	"Finger1Slot", 
	"Trinket0Slot", 
	"Trinket1Slot", 
	"MainHandSlot", 
	"SecondaryHandSlot", 
	"RangedSlot", 
	"AmmoSlot", 
}

ExAE_Lock = true;

StaticPopupDialogs["ExAE_SAVE"] = {
	text = ExAE_SAVE_CONFIRM, 
	button1 = YES, 
	button2 = NO, 
	OnAccept = function() ExAE_SavePlayerEquipSet(ExAE_GetCurrentSetId()) end, 
	OnCancel = function(arg1) end, 
	showAlert = 1, 
	timeout = 0, 
}

StaticPopupDialogs["ExAE_NULL"] = {
	text = ExAE_NULL_CONFIRM, 
	button1 = YES, 
	button2 = NO, 
	OnAccept = function() ExAE_Reset() end, 
	OnCancel = function(arg1) end, 
	showAlert = 1, 
	timeout = 0, 
}

-- Events handlers
function ExAE_OnLoad(self)
	-- Register events
	self:RegisterEvent("ADDON_LOADED");

	-- Init data
	if (not ExAE_Config) then
		ExAE_Config = {};
	end;

	ExAE_RealmName = GetCVar("realmName");
	if (not ExAE_RealmName) then
		ExAE_RealmName = "Enigma";
	end;
	ExAE_PlayerName = UnitName("player");
	if (not ExAE_PlayerName) then
		ExAE_PlayerName = "Unknown";
	end;
	ExAE_PlayerId = ExAE_PlayerName .. "@" .. ExAE_RealmName;

	SLASH_ExAE1 = "/exae";
	SlashCmdList["ExAE"] = ExAE_Command;
end 

function ExAE_OnEvent(self, event, ...)
	local name = ...
	if ( event == "ADDON_LOADED" and name == "Ex_AutoEquip" ) then

		setId = ExAE_GetCurrentSetId();

		-- if ( not setId or setId == 0 ) then
		-- --[[
		-- 	ExAE_SetCurrentSetId(1);
		-- 	ExAE_SavePlayerEquipSet(1); 
		-- 	ExAE_FrameSetButton1:SetChecked(1);
		-- ]]
		-- else 
		if ( setId and setId ~= 0 ) then
			--not auto changes
			-- ExAE_LoadPlayerEquipSet(setId, 0);
			local objSetButton = getglobal("ExAE_FrameSetButton" .. setId);
			if (objSetButton) then 
				objSetButton:SetChecked(1);
			end;
		end;

		--Change Texture
		if (EUF_Options) then
			ExAE_FrameTexture:SetTexture("Interface\\AddOns\\Ex_AutoEquip\\Ex_AutoEquip");
		end
	end;
end

function ExAE_SetButton_OnClick(setId)
	if (CursorHasItem() or UnitIsDeadOrGhost("player")) then
		return;
	end;
	if ( setId == 1 ) then 
		ExAE_FrameSetButton1:SetChecked(1); 
		ExAE_FrameSetButton2:SetChecked(nil); 
		ExAE_FrameSetButton3:SetChecked(nil); 
		ExAE_FrameSetButton4:SetChecked(nil);
		ExAE_FrameNakedButton:SetChecked(nil);
		NakedObj.Nakie = false;
	elseif ( setId == 2 ) then 
		ExAE_FrameSetButton1:SetChecked(nil); 
		ExAE_FrameSetButton2:SetChecked(1); 
		ExAE_FrameSetButton3:SetChecked(nil); 
		ExAE_FrameSetButton4:SetChecked(nil); 
		ExAE_FrameNakedButton:SetChecked(nil);
		NakedObj.Nakie = false;
	elseif ( setId == 3 ) then 
		ExAE_FrameSetButton1:SetChecked(nil); 
		ExAE_FrameSetButton2:SetChecked(nil); 
		ExAE_FrameSetButton3:SetChecked(1); 
		ExAE_FrameSetButton4:SetChecked(nil);
		ExAE_FrameNakedButton:SetChecked(nil);
		NakedObj.Nakie = false;
	elseif ( setId == 4 ) then 
		ExAE_FrameSetButton1:SetChecked(nil); 
		ExAE_FrameSetButton2:SetChecked(nil); 
		ExAE_FrameSetButton3:SetChecked(nil); 
		ExAE_FrameSetButton4:SetChecked(1);
		ExAE_FrameNakedButton:SetChecked(nil);
		NakedObj.Nakie = false;
	elseif ( setId == 5 ) then
		ExAE_FrameSetButton1:SetChecked(nil); 
		ExAE_FrameSetButton2:SetChecked(nil); 
		ExAE_FrameSetButton3:SetChecked(nil); 
		ExAE_FrameSetButton4:SetChecked(nil);
		ExAE_FrameNakedButton:SetChecked(1);
		NakedObj.Nakie = false;
	else 
		ExAE_FrameSetButton1:SetChecked(nil); 
		ExAE_FrameSetButton2:SetChecked(nil); 
		ExAE_FrameSetButton3:SetChecked(nil); 
		ExAE_FrameSetButton4:SetChecked(nil);
		ExAE_FrameNakedButton:SetChecked(nil);
	end 

	if (IsAltKeyDown() or IsControlKeyDown()) then 
		ExAE_SetCurrentSetId(setId);
		--if ( setId ~= nil and setId > 0 and setId < 5) then
			--ExAE_FrameNakedButton:SetChecked(nil);
		--end
		return;
	end

--	if ( setId or CursorHasItem() ) then 
--		return 
--	end 
--	if (setId ~= ExAE_GetCurrentSetId()) then 
	if ( setId ~= nil and setId > 0 and setId < 5) then
		ExAE_LoadPlayerEquipSet(setId, 1); 
		-- PlaySound("igChatEmoteButton"); 
	end
end

function ExAE_SaveButton_OnClick(self, button )
	if ( button == "LeftButton" ) then
		local id = ExAE_GetCurrentSetId();
		if ( id < 1 or id > 4) then
			DEFAULT_CHAT_FRAME:AddMessage(BINDING_HEADER_ExAE_TITLE..": "..string.format(ExAE_MSG_NULL_SAVED, setId), 1, 0.75 , 0);
			return
		end
		StaticPopup_Show("ExAE_SAVE");
	elseif ( button == "RightButton" ) then
		StaticPopup_Show("ExAE_NULL");
	end
end

function ExAE_NakedButton_OnClick(self) 
	SlashCmdList.NAKED();
	ExAE_SetButton_OnClick(5);
	ExAE_SetCurrentSetId(5);
	DEFAULT_CHAT_FRAME:AddMessage(ExAE_NAKED_TITLE, 1, 0.75 , 0);
end 

function ExAE_SaveButton_OnEnter(self)
	GameTooltip_AddNewbieTip(self, ExAE_HELP_SAVE_BTN_TITLE, 1, 1, 1, ExAE_HELP_SAVE_BTN_DESC);
end 

function ExAE_NakedButton_OnEnter(self)
	GameTooltip_AddNewbieTip(self, ExAE_HELP_NAKED_BTN_TITLE, 1, 1, 1, ExAE_HELP_NAKED_BTN_DESC);
end 

function ExAE_SetButton_OnEnter(self, arg1)
	GameTooltip_AddNewbieTip(self, string.format(ExAE_HELP_SET_BTN_TITLE, arg1), 1, 1, 1, string.format(ExAE_HELP_SET_BTN_DESC, arg1));
end 

function EAE_SaveButton_OnMouseDown(self, button) 
	if (button == "LeftButton") and	IsShiftKeyDown() then
		EAE_Frame:StartMoving();
		EAE_Frame.isMoving = true;
	end
end 

function EAE_SaveButton_OnMouseUp(self, button) 
--	local _,_,_, x, y = EAE_Frame:GetPoint(1);
--	EAE_SetToolbar(string.format("(%.f, %.f)", x, y));
	EAE_Frame:StopMovingOrSizing();
	EAE_Frame.isMoving = false;
end

function ExAE_Reset() 
	ExAE_Config[ExAE_PlayerId] = {};
	ExAE_SetCurrentSetId(0);
	ExAE_FrameSetButton1:SetChecked(nil); 
	ExAE_FrameSetButton2:SetChecked(nil); 
	ExAE_FrameSetButton3:SetChecked(nil); 
	ExAE_FrameSetButton4:SetChecked(nil);
	ExAE_FrameNakedButton:SetChecked(nil);
end

function ExAE_SavePlayerEquipSet(setId)
	local index, value; 
	local equipSet = ExAE_GetPlayerEquipSet(setId);
	for index, value in pairs(ExAE_Slots) do 
		local itemName, itemLinkId = ExAE_GetItemInfo("inventory", value);
		if (itemName and itemLinkId) then
			equipSet[value] = {name = itemName, link = itemLinkId};
		else
			equipSet[value] = {name = nil, link = nil};
		end 
	end
	DEFAULT_CHAT_FRAME:AddMessage(BINDING_HEADER_ExAE_TITLE..": "..string.format(ExAE_MSG_SET_SAVED, setId), 1, 0.75 , 0);
end 

function ExAE_LoadPlayerEquipSet(setId, showMsg)
	ExAE_GetPlayerItems()
	local equipSet = ExAE_GetPlayerEquipSet(setId) 
	if ( not equipSet ) then 
		ExAE_SetCurrentSetId(setId);
		return 
	end 
	ExAE_LoadSet = {} 
	ExAE_LoadSetFirst = {} 
	
	if (showMsg == 1) then
		DEFAULT_CHAT_FRAME:AddMessage(BINDING_HEADER_ExAE_TITLE..": "..string.format(ExAE_MSG_LOAD_SET, setId), 1, 0.75 , 0);
	end

	local slotName, itemData
	local UnequipItems = {};
	for slotName, itemData in pairs(equipSet) do
		if (itemData.link) then
			local srcSlot = ExAE_PlayerItems[itemData.link]
			if (srcSlot) then 
				local dstSlot = {}
				dstSlot.type = "inventory";
				dstSlot.slotId = GetInventorySlotInfo(slotName);
				if ( ExAE_MustPickUp(srcSlot, dstSlot, setId) ) then
					if (srcSlot.type == "inventory") then
							local index, s, b
							for index,s in pairs(ExAE_LoadSetFirst) do
								if (ExAE_IsSlotEqual(dstSlot, s.srcSlot)) then
									table.remove(ExAE_LoadSetFirst, index)
									ExAE_SaveItemPareToLoadSet(srcSlot, dstSlot, 1)
									b = true;
									break;
								end
							end
						if (not b) then
							ExAE_SaveItemPareToLoadSet(srcSlot, dstSlot, 0)
						end
					elseif( ExAE_IfExist(srcSlot)) then
						local srcSlot2 = ExAE_PlayerItems[itemData.link..":2"];
						if (srcSlot2) then
							if (srcSlot2.type == "inventory") then
								if (not ExAE_IsSlotEqual(srcSlot2, dstSlot)) then
									ExAE_SaveItemPareToLoadSet(srcSlot2, dstSlot, 0)
								end
							else
								ExAE_SaveItemPareToLoadSet(srcSlot2, dstSlot, 1)
							end
						else
							ExAE_SaveItemPareToLoadSet(srcSlot, dstSlot, 1)
						end
					else
						ExAE_SaveItemPareToLoadSet(srcSlot, dstSlot, 1)
					end
				end
			else
				if (showMsg == 1) then
					DEFAULT_CHAT_FRAME:AddMessage(string.format(ExAE_MSG_ITEM_NOTEXISTS, itemData.name), 1, 0.75, 0);
				end;
			end
		elseif (slotName ~= "AmmoSlot" and GetInventorySlotInfo(slotName)) then
			local dstSlot = {}
			dstSlot.type = "inventory";
			dstSlot.slotId = GetInventorySlotInfo(slotName);
			table.insert(UnequipItems, dstSlot);
		end
	end 

	if (ExAE_IsLoadSetLocked() and showMsg == 1 ) then 
		DEFAULT_CHAT_FRAME:AddMessage(ExAE_MSG_ITEM_LOCKED, 1, 0.75, 0);
		return;
	end;

	local index, value, slotPare, slot2
	ExAE_GetBagEmptyNums();

	for index, slotPare in pairs(ExAE_LoadSetFirst) do 
		if (TotalBagEmptyNums == 0 and showMsg == 1 ) then
			DEFAULT_CHAT_FRAME:AddMessage(ExAE_MSG_BAG_FULL, 1, 0.75, 0);
			break;
		end
		ExAE_PickUpItem(slotPare.dstSlot) 
		if ( CursorHasItem() ) then 
			for bag = 0, 4 do
				if (BagEmptyNums[bag] > 0) then
					if (bag == 0) then
						PutItemInBackpack(); 
					else
						PutItemInBag(19+bag);
					end
					BagEmptyNums[bag] = BagEmptyNums[bag] - 1;
					TotalBagEmptyNums = TotalBagEmptyNums - 1;
					break;
				end
			end
		end
		ExAE_PickUpItem(slotPare.srcSlot) 
		if ( CursorHasItem() ) then 
			EquipCursorItem(slotPare.dstSlot.slotId-1) 
		end 
	end

	for index, slotPare in pairs(ExAE_LoadSet) do 
		ExAE_PickUpItem(slotPare.srcSlot) 
		if ( CursorHasItem() ) then 
			ExAE_PickUpItem(slotPare.dstSlot) 
		end 
	end

	for index, slot2 in pairs(UnequipItems) do
		if (TotalBagEmptyNums == 0 and showMsg == 1 ) then
			DEFAULT_CHAT_FRAME:AddMessage(ExAE_MSG_BAG_FULL, 1, 0.75, 0);
			break;
		end
		ExAE_PickUpItem(slot2) 
		if (CursorHasItem()) then
			for bag = 0, 4 do
				if (BagEmptyNums[bag] > 0) then
					if (bag == 0) then
						PutItemInBackpack(); 
					else
						PutItemInBag(19+bag);
					end
					BagEmptyNums[bag] = BagEmptyNums[bag] - 1;
					TotalBagEmptyNums = TotalBagEmptyNums - 1;
					break;
				end
			end
		end
	end
	ExAE_PlayerItems = {};
	ExAE_LoadSet = {};
	ExAE_LoadSetFirst = {};
	ExAE_SetCurrentSetId(setId)
end

function ExAE_IfExist(slot)
	for _,s in pairs(ExAE_LoadSet) do
		if (ExAE_IsSlotEqual(slot, s.srcSlot)) then return true; end
	end
	return false;
end

function ExAE_GetBagEmptyNums()
	local bag, totalSlots, slot;
	BagEmptyNums = {};
	TotalBagEmptyNums = 0;
	for bag = 0, 4 do
		BagEmptyNums[bag] = 0;
		totalSlots = GetContainerNumSlots(bag);
		for slot=1, totalSlots do
			if not GetContainerItemInfo(bag, slot) then
				BagEmptyNums[bag] = BagEmptyNums[bag] + 1;
				TotalBagEmptyNums = TotalBagEmptyNums + 1;
			end
		end
	end
end

function ExAE_MustPickUp(srcSlot, dstSlot, setId)
	if (srcSlot.type == "container") then 
		-- if source slot is in container, return true (from container to inventory);
		return 1;
	else
		if (ExAE_IsSlotEqual(srcSlot, dstSlot)) then 
			-- if source slot equals to destination slot, return false (no pickup needed);
			return;
		end
		return 1;
	end
end

function ExAE_GetSetItemInventorySlot(itemLinkId, setId)
	-- Return a set item's inventory location (where to equip this set item).
	local equipSet = ExAE_GetPlayerEquipSet(setId);
	if ( not equipSet ) then 
		return;
	end 
	local slotName, itemData;
	for slotName, itemData in equipSet do 
		if ( itemData.link == itemLinkId ) then
			local slot = {};
			slot.type = "inventory";
			slot.slotId = GetInventorySlotInfo(slotName);
			return slot; 
		end 
	end 
end

-- Base Functions
function ExAE_SaveItemPareToLoadSet(srceLoc, destLoc, flag) 
	local index, value, TempLoadSet
	if ( flag == 0) then
		TempLoadSet = ExAE_LoadSetFirst;
	else
		TempLoadSet = ExAE_LoadSet;
	end
	-- Check if they are already in load set
	for index, itemPare in pairs(TempLoadSet) do 
		if ( ExAE_IsSlotEqual(itemPare.srcSlot, srceLoc) and ExAE_IsSlotEqual(itemPare.dstSlot, destLoc) ) then 
			return;
		end 
		if ( ExAE_IsSlotEqual(itemPare.srcSlot, destLoc) and ExAE_IsSlotEqual(itemPare.dstSlot, srceLoc)) then
			return;
		end 
	end 

	local itemPare = {} 
	itemPare.srcSlot = srceLoc; 
	itemPare.dstSlot = destLoc; 
	table.insert(TempLoadSet, itemPare); 
end 

function ExAE_IsSlotEqual(slot1, slot2) 
	return (slot1.type == slot2.type and slot1.bagId == slot2.bagId and slot1.slotId == slot2.slotId) 
end 

function ExAE_IsSlotItemLocked(slot) 
	if ( slot.type == "container" ) then 
		local _, _, isLocked, _, _ = GetContainerItemInfo(slot.bagId, slot.slotId);
		return isLocked;
	elseif ( slot.type == "inventory" ) then 
		return IsInventoryItemLocked(slot.slotId);
	end 
end

function ExAE_IsLoadSetLocked() 
	local index, itemPare
	for index, itemPare in pairs(ExAE_LoadSet) do 
		if (ExAE_IsSlotItemLocked(itemPare.srcSlot) or ExAE_IsSlotItemLocked(itemPare.dstSlot)) then 
			return 1; 
		end
	end
end

function ExAE_PickUpItem(slot) 
	if (slot.type == "container") then 
		PickupContainerItem(slot.bagId, slot.slotId) 
	elseif (slot.type == "inventory") then 
		PickupInventoryItem(slot.slotId) 
	end 
end 

function ExAE_GetPlayerItems()
	-- Generate a dataset, index is item linkid, value is item's slotinfo
	ExAE_PlayerItems = {};
	local bagIndex; 
	for bagIndex = 0, NUM_CONTAINER_FRAMES, 1 do 
		local slotIndex; 
		for slotIndex = 1, GetContainerNumSlots(bagIndex), 1 do 
			local itemName, itemLinkId = ExAE_GetItemInfo("container", bagIndex, slotIndex); 
			if (itemName and itemLinkId) then 
				local slot = {}; 
				slot.type = "container"; 
				slot.bagId = bagIndex; 
				slot.slotId = slotIndex; 
				if (ExAE_PlayerItems[itemLinkId]) then
					ExAE_PlayerItems[itemLinkId..":2"] = slot; 
				else
					ExAE_PlayerItems[itemLinkId] = slot; 
				end
			end; 
		end; 
	end; 
	local index, value; 
	for index, slotName in pairs(ExAE_Slots) do 
		local itemName, itemLinkId = ExAE_GetItemInfo("inventory", slotName); 
		if (itemName and itemLinkId) then 
			local slot = {}; 
			slot.type = "inventory"; 
			slot.slotId = GetInventorySlotInfo(slotName); 
			if (ExAE_PlayerItems[itemLinkId]) then
				ExAE_PlayerItems[itemLinkId..":2"] = slot; 
			else
				ExAE_PlayerItems[itemLinkId] = slot; 
			end
		end; 
	end; 
end; 

function ExAE_GetPlayerEquipSet(setId) 
	local numSetId = tonumber(setId) 
	if ( not numSetId ) then 
		return
	end 
	if ( not ExAE_Config[ExAE_PlayerId][numSetId] ) then 
		ExAE_Config[ExAE_PlayerId][numSetId] = {} 
	end 
	return ExAE_Config[ExAE_PlayerId][numSetId] 
end 

function ExAE_GetCurrentSetId()
	if (not ExAE_Config[ExAE_PlayerId]) then
		ExAE_Config[ExAE_PlayerId] = {};
	end;
	if (not ExAE_Config[ExAE_PlayerId].CurrentSetId) then
		ExAE_Config[ExAE_PlayerId].CurrentSetId = 0;
	end;
	return ExAE_Config[ExAE_PlayerId].CurrentSetId;
end;

function ExAE_SetCurrentSetId(setId)
	if (not ExAE_Config[ExAE_PlayerId]) then
		ExAE_Config[ExAE_PlayerId] = {};
	end;
	ExAE_Config[ExAE_PlayerId].CurrentSetId = setId;
end; 

-- Framework Functions
function ExAE_GetInventoryItemLinkId(slotId) 
	local itemLink = GetInventoryItemLink("player", slotId);
	local itemName, itemLinkId = ExAE_GetItemInfoByLink(itemLink);
	return itemLinkId;
end 

function ExAE_GetItemInfoByLink(itemLink) 
	if ( not itemLink or type(itemLink) ~= "string" ) then 
		return;
	end 
	local _, _, itemLinkId, itemName = string.find(itemLink, "^|c%x+|H(.+)|h%[(.+)%]"); 
	if (itemLinkId and itemName) then 
		return itemName, itemLinkId;
	end 
end 

function ExAE_GetItemInfo(itemType, arg1, arg2) 
	if (itemType == "container") then 
		--arg1, 2 for bagId, slotId
		local itemLink = GetContainerItemLink(arg1, arg2) 
		return ExAE_GetItemInfoByLink(itemLink)
	elseif (itemType == "inventory") then
		--arg1 for slotName
		local itemLink = GetInventoryItemLink("player", GetInventorySlotInfo(arg1)) 
		return ExAE_GetItemInfoByLink(itemLink)
	end 
end

function ExAE_DEBUG(arg1,arg2)
	local msg = "";
	if (arg1) then msg = msg .. arg1; end;
	if (arg2) then msg = msg .. "=" .. arg2; end;
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end;

function ExAE_Command(cmd)
	if( cmd == "lock" ) then
		ExAE_Frame:EnableMouse(false);
		ExAE_Lock = true;
	elseif( cmd == "unlock" ) then
		ExAE_Frame:EnableMouse(true);
		ExAE_Lock = false;
	else
		DEFAULT_CHAT_FRAME:AddMessage("Usage /eae [lock][unlock]");
	end
end

function ExAE_MouseUp(self)
	if ( self.isMoving ) then
		self:StopMovingOrSizing();
		self.isMoving = false;
	end
end

function ExAE_MouseDown(self, button)
	if ( ExAE_Lock == false and ( button == "LeftButton" ) ) then
		self:StartMoving();
		self.isMoving = true;
	end
end

function ExAE_OnHide(self)
	if ( self.isMoving ) then
		self:StopMovingOrSizing();
		self.isMoving = false;
	end
end

function AutoEquip_Toggle(switch)
	if (switch) then
		ExAE_Frame:Show();
	else
		ExAE_Frame:Hide();
	end
end

function AutoEquip_KeyBinding()
	BigFoot_ShowKeyBindingFrame("HEADER_ExAE_TITLE");
end
