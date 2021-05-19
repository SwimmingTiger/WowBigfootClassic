
zFeeder = zFeeder or {Link = nil, Texture = nil, Count = nil, Item = "",}

if (GetLocale() == "zhCN") then
	ZFEEDER_MOVE_TOOLTIP = "按住Shift可拖动框体\nShift+右键重置鼠标位置";
elseif (GetLocale() == "zhTW") then
	ZFEEDER_MOVE_TOOLTIP = "按住Shift可拖動框體\nShift+右鍵重置滑鼠位置";
else
	ZFEEDER_MOVE_TOOLTIP = "Hold shift to move frame\nShift + Right click to reset position";
end

--------------------------------------------
--	locals
--------------------------------------------
local __inCombat = false;
local __isMoving = nil;
local __zFeedHooked = false;
local __zWarningPoint = 2;
local __zHappinessMap = { [PET_HAPPINESS1] = 2, [PET_HAPPINESS2] = 3 };

-- Get item id from link
local function __zfParseItemLink(__link)
	if __link then
		for id in string.gmatch(__link, "|%x+|Hitem:(%d+):") do
			return tonumber(id)
		end
	end
end

-- buff effect
local function zHasFeedEffect()
	local i = 1;
	local __name, __rank, __texture, __count, __debuffType, __duration, __expirationTime = UnitAura("pet", i);
	while (__texture and __duration and __expirationTime and __duration > 0) do
		local __timeLeft = __expirationTime - GetTime();
		if ( string.find(__texture, "Ability_Hunter_BeastTraining") ) then
			return true, __duration, __timeLeft;
		end
		i = i + 1;
		__name, __rank, __texture, __count, __debuffType, __duration, __expirationTime = UnitAura("pet", i);
	end
	return nil
end

-- item index
local function __GetItemIndex(__itemlink)
	if (not __itemlink) then
		return nil, nil;
	end
	local __id2 = __zfParseItemLink(__itemlink);
	for __bag = 0, NUM_BAG_FRAMES do
		for __slot = 1, GetContainerNumSlots(__bag) do
			local __link = GetContainerItemLink(__bag, __slot);
			if (__link) then
				local __id1 = __zfParseItemLink(__link);
				if (__id1 and __id2 and __id1 == __id2) then
					return __bag, __slot;
				end
			end
		end
	end
	return nil, nil;
end
--~ updates
local function __zUpdateTexture(__button)
	if(zFeeder.Texture) then
		SetItemButtonTexture(__button, zFeeder.Texture);
	end
end

local function __zUpdateCount(__button)
	if (zFeeder.Link) then
		zFeeder.Count = GetItemCount(zFeeder.Link);
		SetItemButtonCount(__button, zFeeder.Count);
		if(zFeeder.Count and zFeeder.Count == 0) then
			zFeederButtonIconTexture:SetVertexColor(1.0, 0.1, 0.1);
		else
			zFeederButtonIconTexture:SetVertexColor(1.0, 1.0, 1.0);
		end
	end
end
-----------------------------------------
--	OnX
-----------------------------------------
local __ZFeed_Eventer = BLibrary("BEvent");

__ZFeed_Eventer:Init{
	name = "HunterAssist",
	func = function()
		__zUpdateTexture(getglobal("zFeederButton"));
		__zUpdateCount(getglobal("zFeederButton"));
		getglobal("zFeederButton"):SetAttribute("unit", "pet");
		getglobal("zFeederButton"):SetAttribute("type", "target");
	end
};

function ZFeed_Toggle(__switch)
	if (__switch) then
		__ZFeed_Eventer:RegisterEvent("BAG_UPDATE");
		if (not __zFeedHooked) then
			hooksecurefunc("PetFrame_SetHappiness", __zNew_PetFrame_SetHappiness);
			__zFeedHooked = true;
		end
		getglobal("zFeederButton"):Show();
	else
		__ZFeed_Eventer:UnregisterEvent("BAG_UPDATE");
		getglobal("zFeederButton"):Hide();
	end
end

function ZFeed_CHappiness(happiness)
	local happiness = tostring(happiness);
	__zWarningPoint = __zHappinessMap[happiness] or 2;
end

function zfOnLoad(self)
	self:RegisterForDrag("LeftButton", "RightButton");
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	self.time = 0;
end

function __ZFeed_Eventer.BAG_UPDATE()
	__zUpdateCount(getglobal("zFeederButton"));
end

function zfOnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	if (zFeeder.Link) then
		GameTooltip:SetText(ZF_BUTTON_TITLE);
		GameTooltip:AddDoubleLine(ZF_FOODNAME, zFeeder.Link, 1, 1, 1, 1,1,1);
		GameTooltip:AddDoubleLine(ZF_FOODQUANTITY, zFeeder.Count, 1, 1, 1, 1,1,1);
		GameTooltip:AddLine(ZFEEDER_MOVE_TOOLTIP, 0.5, 0.5, 0.5, 1);
	else
		GameTooltip:AddLine(ZF_NO_FOOD, 1, 1, 1);
		GameTooltip:AddLine(ZFEEDER_MOVE_TOOLTIP, 0.5, 0.5, 0.5, 1);
	end
	GameTooltip:Show();
end

function zfOnLeave(self)
	GameTooltip:Hide();
end

function zfPreClick(self, button)
	if (InCombatLockdown()) then	-- 战斗状态下不能动作
		return;
	end

	if (CursorHasItem()) then
		local _, __itemName, __itemLink = GetCursorInfo();
		local __itemTexture = select(10, GetItemInfo(__itemLink));
		if (__itemName and __itemLink and __itemTexture) then
			zFeeder.Item = __itemName;
			zFeeder.Link = __itemLink;
			zFeeder.Texture = __itemTexture;
			__zUpdateTexture(self);
		end
		GameTooltip:Hide();
		ClearCursor();
		__zUpdateCount(self);
	else
		if (IsShiftKeyDown() and button == "RightButton") then
			zFeederButton:ClearAllPoints();
			zFeederButton:SetPoint("LEFT", "PetFrameHappiness", "RIGHT", 4, 0);
		elseif (zFeeder.Link) then
			local __bag, __slot = __GetItemIndex(zFeeder.Link);
			local hasEffect = zHasFeedEffect();
			if (__bag and __slot and not hasEffect) then
				PickupContainerItem(__bag, __slot);
			end
		end
	end
end

function zfOnDragStart(self)
	GameTooltip:Hide();
	if (IsShiftKeyDown()) then
		self:StartMoving();
		__isMoving = true;
		return;
	end
	zFeeder.Link = nil;
	zFeeder.Count = nil;
	zFeeder.Texture = nil;
	zFeeder.Item = "";
	SetItemButtonCount(self, 0);
	SetItemButtonTexture(self, nil);
end

function zfOnDragStop(self)
	if (__isMoving) then
		self:StopMovingOrSizing();
	end
end

function zfOnUpdate(self, elapsed)
	self.time = self.time + elapsed;
	if (self.time > 0.3) then
		local hasEffect, duration, timeleft = zHasFeedEffect();
		if (hasEffect and duration) then
			PetFrameManaBar:SetStatusBarColor(0.0, 1.0, 1.0);
			PetFrameManaBar:SetMinMaxValues(0, duration);
			PetFrameManaBar:SetValue(duration - math.floor(timeleft));
			PetFrameManaBar:UnregisterEvent("UNIT_HAPPINESS");
			self.feeding = true;
		elseif (self.feeding) then
			PetFrameManaBar:RegisterEvent("UNIT_HAPPINESS");
			UnitFrameManaBar_Update(PetFrameManaBar:GetParent());
			self.feeding = false;
		end

		self.time = 0;
	end
end
--------------------------------------
--	Override
--------------------------------------
function __zNew_PetFrame_SetHappiness(...)
	local __happiness = GetPetHappiness();
	if (__happiness and __happiness < __zWarningPoint) then
		UIErrorsFrame:AddMessage(ZF_HUNGER, 1, 1, 0);
	end
end