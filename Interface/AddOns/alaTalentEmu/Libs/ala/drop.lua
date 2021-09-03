--[[--
	ALA@163UI
--]]--
local __version = 5;

local DropMenu = _G.alaDropMenu;
if DropMenu ~= nil and DropMenu.__minor ~= nil and DropMenu.__minor >= __version then
	return;
end
if DropMenu ~= nil and DropMenu.Halt ~= nil then
	DropMenu:Halt();
else
	DropMenu = {  };
end
DropMenu.__minor = __version;

local type = type;
local unpack = unpack;
local _G = _G;
local _ = nil;


local MenuBackdropColor = { 0.05, 0.05, 0.05, 1.0 };
local MenuBorderColor = { 1.0, 1.0, 1.0, 0.5 };
local COUNTING_DOWN_TIMER_PERIOD = 1.5;
local MenuButtonHeight = 16;
local MenuButtonInterval = 0;
local MenuButtonToHBorder = 2;
local MenuButtonToVBorder = 2;
local toc = select(4, GetBuildInfo());
local isRetail = toc >= 80300;
local isBCC = toc >= 20500 and toc < 30000;

local MenuList = { total = 0, used = 0, prev = nil, };
local frameToMenu = {  };

--[=[
	data
			handler		(function)
			elements[i]	(table)
										handler		(function)optional
										para		(table)for parameter
										text		(string)
										--info		(string)
]=]

local function SetBackdrop(_F, inset, dr, dg, db, da, width, rr, rg, rb, ra)	--	inset > 0 : inner	--	inset < 0 : outter
	local ofs = width + inset;
	local Backdrop = _F:CreateTexture(nil, "BACKGROUND");
	Backdrop:SetPoint("BOTTOMLEFT", _F, "BOTTOMLEFT", ofs, ofs);
	Backdrop:SetPoint("TOPRIGHT", _F, "TOPRIGHT", -ofs, -ofs);
	Backdrop:SetColorTexture(dr or 0.0, dg or 0.0, db or 0.0, da or 1.0);
	local LBorder = _F:CreateTexture(nil, "BACKGROUND", nil, 1);
	local TBorder = _F:CreateTexture(nil, "BACKGROUND", nil, 1);
	local RBorder = _F:CreateTexture(nil, "BACKGROUND", nil, 1);
	local BBorder = _F:CreateTexture(nil, "BACKGROUND", nil, 1);
	if width ~= nil then
		rr, rg, rb, ra = rr or 1.0, rg or 1.0, rb or 1.0, ra or 0.5;
		LBorder:SetWidth(width);
		TBorder:SetHeight(width);
		RBorder:SetWidth(width);
		BBorder:SetHeight(width);
		LBorder:SetColorTexture(rr, rg, rb, ra);
		TBorder:SetColorTexture(rr, rg, rb, ra);
		RBorder:SetColorTexture(rr, rg, rb, ra);
		BBorder:SetColorTexture(rr, rg, rb, ra);
		LBorder:SetPoint("TOPRIGHT", _F, "TOPLEFT", ofs, -ofs);
		LBorder:SetPoint("BOTTOMRIGHT", _F, "BOTTOMLEFT", ofs, inset);
		TBorder:SetPoint("BOTTOMRIGHT", _F, "TOPRIGHT", -ofs, -ofs);
		TBorder:SetPoint("BOTTOMLEFT", _F, "TOPLEFT", inset, -ofs);
		RBorder:SetPoint("BOTTOMLEFT", _F, "BOTTOMRIGHT", -ofs, ofs);
		RBorder:SetPoint("TOPLEFT", _F, "TOPRIGHT", -ofs, -inset);
		BBorder:SetPoint("TOPLEFT", _F, "BOTTOMLEFT", ofs, ofs);
		BBorder:SetPoint("TOPRIGHT", _F, "BOTTOMRIGHT", -inset, ofs);
	end
end
-->		Creator
local MenuOnEvent = nil;
if isRetail then
	function MenuOnEvent(self, event)
		if self.__flag == "show" then
			self.__flag = nil;
		else
			self:SetScript("OnEvent", nil);
			self:Hide();
		end
	end
else
	function MenuOnEvent(self, event)
		self:SetScript("OnEvent", nil);
		self:Hide();
	end
end
local function MenuOnUpdate(self, elasped)
	self.CountingDownTimer = self.CountingDownTimer - elasped;
	if self.CountingDownTimer <= 0 then
		self:Hide();
	end
end
local function MenuOnClick(self, button)
	self:Hide();
end
local function MenuOnEnter(self)
	self:SetScript("OnUpdate", nil);
	self:SetScript("OnEvent", nil);
end
local function MenuOnLeave(self)
	self.CountingDownTimer = COUNTING_DOWN_TIMER_PERIOD;
	self:SetScript("OnUpdate", MenuOnUpdate);
	self:SetScript("OnEvent", MenuOnEvent);
end
local function MenuOnShow(self)
	self.CountingDownTimer = COUNTING_DOWN_TIMER_PERIOD + 1.0;
	self:SetScript("OnUpdate", MenuOnUpdate);
	self:SetScript("OnEvent", MenuOnEvent);
	if MenuList.prev ~= self then
		if MenuList.prev then
			MenuList.prev:Hide();
		end
		MenuList.prev = self;
	end
end
local function MenuOnHide(self)
	self:SetScript("OnUpdate", nil);
	self:SetScript("OnEvent", nil);
	for i = 1, MenuList.used do
		if self == MenuList[i] then
			MenuList[i] = MenuList[MenuList.used]
			MenuList[MenuList.used] = self;
			self.used = MenuList.used - 1;
			frameToMenu[self.parent] = nil;
			break;
		end
	end
	if self == MenuList.prev then
		MenuList.prev = nil;
	end
end
local function CreateMenu()
	Menu = CreateFrame("BUTTON", nil, UIParent);
	Menu:SetFrameStrata("FULLSCREEN_DIALOG");
	Menu:SetClampedToScreen(true);
	Menu:Hide();
	SetBackdrop(Menu, -1, MenuBackdropColor[1], MenuBackdropColor[2], MenuBackdropColor[3], MenuBackdropColor[4], 1, MenuBorderColor[1], MenuBorderColor[2], MenuBorderColor[3], MenuBorderColor[4]);
	Menu:SetScript("OnClick", MenuOnClick);
	Menu:SetScript("OnEnter", MenuOnEnter);
	Menu:SetScript("OnLeave", MenuOnLeave);
	Menu:SetScript("OnShow", MenuOnShow);
	Menu:SetScript("OnHide", MenuOnHide);
	if isRetail then
		Menu:RegisterEvent("GLOBAL_MOUSE_UP");
	elseif isBCC then
		Menu:RegisterEvent("PLAYER_STARTED_LOOKING");
		-- Menu:RegisterEvent("PLAYER_STOPPED_LOOKING");
		Menu:RegisterEvent("PLAYER_STARTED_TURNING");
		-- Menu:RegisterEvent("PLAYER_STOPPED_TURNING");
	else
		Menu:RegisterEvent("CURSOR_UPDATE");
	end
	Menu.buttons = {  };

	return Menu;
end

local function MenuButtonOnClick(self, button)
	if self.handler then
		self.handler(button, unpack(self.para));
	else
		self.Menu.handler(button, unpack(self.para));
	end
	self.Menu:Hide();
end
local function MenuButtonOnEnter(self)
	MenuOnEnter(self.Menu);
end
local function MenuButtonOnLeave(self)
	MenuOnLeave(self.Menu);
end
local function MenuCloseOnClick(button, Menu)
	Menu:Hide();
end
local function CreateMenuButton(Menu, x, y)
	local button = CreateFrame("BUTTON", nil, Menu);
	-- button:SetFrameStrata("FULLSCREEN_DIALOG");
	button:SetHeight(MenuButtonHeight);
	-- button:SetNormalTexture("Interface\\Buttons\\UI-StopButton");
	-- button:SetPushedTexture("Interface\\Buttons\\UI-StopButton");
	-- button:SetHighlightTexture("Interface\\TargetingFrame\\UI-StatusBar");
	-- button:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.0, 0.75);
	local HT = button:CreateTexture(nil, "HIGHLIGHT");
	HT:SetColorTexture(0.0, 0.25, 0.5, 1.0);
	HT:SetBlendMode("ADD");
	HT:SetAllPoints();
	button:SetHighlightTexture(HT);
	button:SetPoint("TOP", Menu, "TOP", x, y);

	local text = button:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
	text:SetPoint("LEFT", 2, 0);
	text:SetTextColor(0.9, 0.9, 0.9, 0.9);
	button.text = text;

	-- local texture = button:CreateTexture(nil, "ARTWORK");
	-- texture:SetSize(MenuButtonHeight / 2, MenuButtonHeight);
	-- texture:SetPoint("RIGHT", -2, 0);
	-- texture:SetTexture("interface\\buttons\\ui-colorpicker-buttons");
	-- texture:SetTexCoord(0.25, 0.375, 0.0, 1.0);
	-- texture:SetVertexColor(1.0, 1.0, 0.25, 1.0);
	-- button.texture = texture;
	
	button:SetScript("OnClick", MenuButtonOnClick);
	button:SetScript("OnEnter", MenuButtonOnEnter);
	button:SetScript("OnLeave", MenuButtonOnLeave);

	button.Menu = Menu;

	return button;
end

-->		Method
local function GetMenu(parent, anchor, useMousePosition)
	local Menu = nil;
	--[[if frameToMenu[parent] then
		Menu = frameToMenu[parent];
	else--]]if MenuList.used < MenuList.total then
		MenuList.used = MenuList.used + 1;
		manu = MenuList[MenuList.used];
	else
		Menu = CreateMenu();
		MenuList.total = MenuList.total + 1;
		MenuList[MenuList.total] = Menu;
		MenuList.used = MenuList.total;
	end
	Menu.parent = parent;
	frameToMenu[parent] = Menu;
	Menu:ClearAllPoints();
	if useMousePosition ~= false then
		local cx, cy = GetCursorPosition();
		local px, py = parent:GetCenter();
		local s = parent:GetEffectiveScale();
		local x = cx / s - px;
		local y = cy / s - py;
		if anchor == "TOPRIGHT" then
			Menu:SetPoint("BOTTOMLEFT", parent, "CENTER", x, y);
		elseif anchor == "TOPLEFT" then
			Menu:SetPoint("BOTTOMRIGHT", parent, "CENTER", x, y);
		elseif anchor == "BOTTOMRIGHT" then
			Menu:SetPoint("TOPLEFT", parent, "CENTER", x, y);
		elseif anchor == "BOTTOMLEFT" then
			Menu:SetPoint("TOPRIGHT", parent, "CENTER", x, y);
		elseif anchor == "TOP" then
			Menu:SetPoint("BOTTOM", parent, "CENTER", x, y);
		elseif anchor == "BOTTOM" then
			Menu:SetPoint("TOP", parent, "CENTER", x, y);
		else
			Menu:SetPoint("BOTTOMLEFT", parent, "CENTER", x, y);
		end
	else
		if anchor == "TOPRIGHT" then
			Menu:SetPoint("BOTTOMLEFT", parent, "TOPRIGHT", 0, 0);
		elseif anchor == "TOPLEFT" then
			Menu:SetPoint("BOTTOMRIGHT", parent, "TOPLEFT", 0, 0);
		elseif anchor == "BOTTOMRIGHT" then
			Menu:SetPoint("TOPLEFT", parent, "BOTTOMRIGHT", 0, 0);
		elseif anchor == "BOTTOMLEFT" then
			Menu:SetPoint("TOPRIGHT", parent, "BOTTOMLEFT", 0, 0);
		elseif anchor == "TOP" then
			Menu:SetPoint("BOTTOM", parent, "TOP", 0, 0);
		elseif anchor == "BOTTOM" then
			Menu:SetPoint("TOP", parent, "BOTTOM", 0, 0);
		else
			Menu:SetPoint("BOTTOMLEFT", parent, "TOPRIGHT", 0, 0);
		end
	end
	return Menu;
end
local function ShowMenu(parent, anchor, data, useMousePosition)
	local Menu = frameToMenu[parent];
	if Menu ~= nil and Menu:IsShown() then
		Menu:Hide();
		frameToMenu[parent] = nil;
		Menu.__flag = nil;
		return;
	end
	if type(data) ~= "table" or type(data.elements) ~= "table" then
		return;
	end
	Menu = GetMenu(parent, anchor, useMousePosition);
	Menu.handler = data.handler;
	local buttons = Menu.buttons;
	local elements = data.elements;
	local numButtons = #elements + 1;
	if #buttons < numButtons then
		for i = #buttons + 1, numButtons do
			buttons[i] = CreateMenuButton(Menu, 0, -((i - 1) * (MenuButtonHeight + MenuButtonInterval) + MenuButtonToVBorder));
		end
	elseif #buttons > numButtons then
		for i = numButtons + 1, #buttons do
			buttons[i]:Hide();
		end
	end

	local width = -1;
	for i = 1, #elements do
		local button = buttons[i];

		button.handler = elements[i].handler;
		button.para = elements[i].para;
		button:Show();

		button.text:SetText(elements[i].text);
		local w = button.text:GetWidth();
		if w > width then
			width = w;
		end
	end
	local button = buttons[numButtons];
	button.handler = MenuCloseOnClick;
	button.para = { Menu, };
	button:Show();
	button.text:SetText("close");
	local w = button.text:GetWidth();
	if w > width then
		width = w;
	end

	width = width + 4;
	for i = 1, numButtons do
		buttons[i]:SetWidth(width);
	end
	Menu:SetWidth(width + MenuButtonToHBorder * 2);
	Menu:SetHeight(MenuButtonHeight * numButtons + MenuButtonInterval * (numButtons - 1) + MenuButtonToVBorder * 2);

	Menu.__flag = "show";
	Menu:Show();
end

-- local function Update()
-- 	for i = 1, #MenuList do
-- 		if not MenuList[i].parent:IsShown() then
-- 			MenuList[i]:Hide();
-- 		end
-- 	end
-- end
-- C_Timer.NewTicker(0.2, Update);

DropMenu.ShowMenu = ShowMenu;
-- DropMenu.HideMenu = HideMenu;

function DropMenu:Halt()
	for index = 1, MenuList.total do
		MenuOnEvent(MenuList[index], isRetail and "GLOBAL_MOUSE_UP" or (isBCC and "PLAYER_STARTED_LOOKING" or "CURSOR_UPDATE"));
		MenuList[index]:SetScript("OnUpdate", nil);
	end
end

_G.alaDropMenu = DropMenu;
_G["ALADROP"] = ShowMenu;
