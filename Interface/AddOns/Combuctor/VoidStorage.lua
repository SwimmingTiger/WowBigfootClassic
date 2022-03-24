-----------------------
--离线虚空银行
--Aguan@BF 2011-12-08
-----------------------
local VOID_DEPOSIT_MAX = 9;
local VOID_WITHDRAW_MAX = 9;
local VOID_STORAGE_MAX = 80;
local playerName = UnitName("player")
local realName = GetRealmName()
local BUTTON_TYPE_STORAGE = 3;
local VOID_STORAGE_PAGES = 2;
local page = 1
local IsOffline = true
local IsNilDate = false

if GetLocale() == "zhCN" then
	TOOTIP_ITEM_NIL = "正在获取物品信息"
	WARRNINGMESSAGE_NILDATE = "大脚贴心提示：首次使用离线银行，请先与相对应银行职员对话获得物品数据。感谢使用该功能。"
elseif GetLocale() == "zhTW" then
	TOOTIP_ITEM_NIL = "正在獲取物品信息"
	WARRNINGMESSAGE_NILDATE = "大腳貼心提示：首次試用離線銀行，清先與相對應銀行職員對話獲得物品數據。感謝試用該功能。"
end

local currenName = playerName .. "@" .. realName

local BF_VoidTempFrame = CreateFrame("Frame","BFvoidtempframe",UIParent)
BF_VoidTempFrame:RegisterEvent("VOID_STORAGE_CLOSE")
BF_VoidTempFrame:RegisterEvent("VOID_STORAGE_OPEN")
BF_VoidTempFrame:RegisterEvent("VOID_STORAGE_CONTENTS_UPDATE");
BF_VoidTempFrame:RegisterEvent("VOID_TRANSFER_DONE");

BF_VoidTempFrame:SetScript("OnEvent",function (frame,event,...)
	if event == "VOID_STORAGE_OPEN" then
		IsOffline = false
		BigFoot_DelayCall(function ()
			BF_SaveItems()
			BF__VoidStorage_LockButtons()
		end,0.1)
	elseif event == "VOID_STORAGE_CLOSE" then
		IsOffline = true
		BF__VoidStorage_LockButtons()
	else
		BF_SaveItems()
		BF__VoidStorage_ItemsUpdate()
	end
end)

function BF__VoidStorage_LockButtons()
	if IsOffline then
		for i = 1, 9 do
			_G["VoidStorageDepositButton" .. i]:Disable()
			_G["VoidStorageDepositButton" .. i]:SetScript("OnReceiveDrag",function () end)
			_G["VoidStorageWithdrawButton" .. i]:Disable()
			_G["VoidStorageWithdrawButton" .. i]:SetScript("OnReceiveDrag",function () end)
		end
	else
		for i = 1, 9 do
			_G["VoidStorageDepositButton" .. i]:Enable()
			_G["VoidStorageDepositButton" .. i]:SetScript("OnReceiveDrag",function (self)
				VoidStorageItemButton_OnDrag(self)
			end)
			_G["VoidStorageWithdrawButton" .. i]:Enable()
			_G["VoidStorageWithdrawButton" .. i]:SetScript("OnReceiveDrag",function (self)
				VoidStorageItemButton_OnDrag(self)
			end)
		end
	end
end

function BF__VoidStorage_ItemsUpdate()
	local page = VoidStorageFrame.page
	local button;
		if not BF_VoidStorageDB  then
			IsNilDate = true
			BF_VoidStorageDB = {}
		else
			IsNilDate = false
		end
		if not BF_VoidStorageDB[currenName] then
			IsNilDate = true
			BF_VoidStorageDB[currenName] = {}
		else
			IsNilDate = false
		end

		if not BF_VoidStorageDB[currenName][page] then
			IsNilDate = true
			BF_VoidStorageDB[currenName][page] = {}
		else
			IsNilDate = false
		end		
		-- storage
		if IsNilDate then
			print("|cffFF0000" .. WARRNINGMESSAGE_NILDATE)                         ---------首次试用离线虚空银行时提示信息
		end
		BF__VoidStorage_LockButtons()
		for i = 1, VOID_STORAGE_MAX do
			itemID, textureName, locked, recentDeposit, isFiltered ,itemLink = BF_GetVoidItemInfo(page,i);
			button = _G["VoidStorageStorageButton"..i];
			button.icon:SetTexture(textureName);
			button:HookScript("OnEnter",function (self)
				BF_VoidStorageItemButton_OnEnter(self)
			end)
			button:SetScript("OnLeave",BF_VoidStorageItemButton_OnLeave)
			button:SetScript("OnDragStart",function (self)
				if IsOffline then
				else
					VoidStorageItemButton_OnDrag(self)
				end
			end)

			button:SetScript("OnReceiveDrag",function (self)
				if IsOffline then
				else
					VoidStorageItemButton_OnDrag(self)
				end
			end)
			if ( itemID ) then
				button.icon:SetDesaturated(locked);
				button.hasItem = true;
				button.itemLink = itemLink
				button.itemID = itemID
				button.UpdateTooltip = BF_VoidStorageItemButton_OnEnter(button)
			else
				button.UpdateTooltip = VoidStorageItemButton_OnEnter(button)
				button.itemID = nil
				button.hasItem = nil;
				button.itemLink = nil
			end
			button:SetScript("OnClick",function (self,button)
				if IsOffline then
					if IsModifiedClick("DRESSUP")then
						DressUpItemLink(self.itemLink)
					end
				else
					VoidStorageItemButton_OnClick(self,button)
				end
			end)
			if ( recentDeposit ) then
				local antsFrame = button.antsFrame;
				if ( not antsFrame ) then
					antsFrame = VoidStorageFrame_GetAntsFrame();
					antsFrame:SetParent(button);
					antsFrame:SetPoint("CENTER");
					button.antsFrame = antsFrame;
				end
				antsFrame:Show();
			elseif ( button.antsFrame ) then
				button.antsFrame:Hide();
				button.antsFrame = nil;
			end

			if ( isFiltered ) then
				button.searchOverlay:Show();
			else
				button.searchOverlay:Hide();
			end
		end

	if ( VoidStorageFrame.mousedOverButton ) then
		VoidStorageItemButton_OnEnter(VoidStorageFrame.mousedOverButton);
	end
	local hasWarningDialog = StaticPopup_FindVisible("VOID_DEPOSIT_CONFIRM");
	VoidStorage_UpdateTransferButton(hasWarningDialog);
end

function BF_GetVoidItemInfo(page,index)
	if BF_VoidStorageDB and BF_VoidStorageDB[currenName] and BF_VoidStorageDB[currenName][page] then
		if BF_VoidStorageDB[currenName][page][index] then
			local itemID, textureName, locked, recentDeposit, isFiltered
			itemID = BF_VoidStorageDB[currenName][page][index].itemID
			textureName = BF_VoidStorageDB[currenName][page][index].textureName
			locked = BF_VoidStorageDB[currenName][page][index].locked
			recentDeposit = BF_VoidStorageDB[currenName][page][index].recentDeposit
			isFiltered = BF_VoidStorageDB[currenName][page][index].isFiltered
			itemLink = BF_VoidStorageDB[currenName][page][index].itemLink
			return itemID, textureName, locked, recentDeposit, isFiltered,itemLink
		end
	end
end

function BF_SaveItems ()
	if not BF_VoidStorageDB then
		BF_VoidStorageDB = {}
	end
	if not BF_VoidStorageDB[currenName] then
		BF_VoidStorageDB[currenName] = {}
	end
	for i = 1,VOID_STORAGE_PAGES do
		BF_VoidStorageDB[currenName][i] = {}
		for j =1 ,VOID_STORAGE_MAX do
			BF_VoidStorageDB[currenName][i][j] = {}
			local itemID, textureName, locked, recentDeposit, isFiltered = GetVoidItemInfo(i,j)
			if itemID then
				BF_VoidStorageDB[currenName][i][j].itemID = itemID
				BF_VoidStorageDB[currenName][i][j].textureName = textureName
				BF_VoidStorageDB[currenName][i][j].locked = locked
				BF_VoidStorageDB[currenName][i][j].recentDeposit = recentDeposit
				BF_VoidStorageDB[currenName][i][j].isFiltered = isFiltered
				__,BF_VoidStorageDB[currenName][i][j].itemLink = GetItemInfo(itemID)
			elseif (not itemID and IsAddOnLoaded("Blizzard_VoidStorageUI")) then
				BF_VoidStorageDB[currenName][i][j] = {}
			end
		end
	end
end

function BF_VoidStorageItemButton_OnEnter(self)
	if ( IsModifiedClick("DRESSUP") ) then
		ShowInspectCursor();
	else
		ResetCursor();
	end
	if ( self.hasItem ) then
		local x = self:GetRight();
		if ( x >= ( GetScreenWidth() / 2 ) ) then
			GameTooltip:SetOwner(self, "ANCHOR_LEFT");
		else
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		end
		if self.itemLink then
			GameTooltip:SetHyperlink(self.itemLink);
		elseif self.itemID then
			__,self.itemLink = GetItemInfo(self.itemID)
			GameTooltip:SetHyperlink(self.itemLink)
		else
			GameTooltip:SetText(TOOTIP_ITEM_NIL)
		end
		GameTooltip:Show()

	else
		GameTooltip:Hide();
		ResetCursor();
	end
end

function BF_VoidStorageItemButton_OnLeave(self)
	GameTooltip:Hide();
	VoidStorageFrame.mousedOverButton = nil;
end
