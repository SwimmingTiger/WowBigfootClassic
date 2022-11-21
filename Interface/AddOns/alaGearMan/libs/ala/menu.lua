--[[--
	ALA@163UI
--]]--
--[=[
	ALAMENU = __menulib.ShowMenu
	ALAMENU(parent, anchor, data, param, useMousePosition)
	data
			handler		(function)
			param		(any)
			num			(number)
			__onshowprepend	[optional]
			__onshowappend	[optional]
			__onhide		[optional]
			__buttononshow	[optional]
			__buttononhide	[optional]
			__buttononenter	[optional]
			__buttononleave	[optional]
			[]{
										handler		(function)[optional]
										param		(any)parameter
										text		(string)
										--info		(string)
										show/hide
										__onshow	[optional]
										__onhide	[optional]
										__onenter	[optional]
										__onleave	[optional]
			}
]=]

local __version = 220824.0;

local _G = _G;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __ala_meta__ = _G.__ala_meta__;

-->			versioncheck
	local __menulib = __ala_meta__.__menulib;
	if __menulib ~= nil and __menulib.__minor ~= nil and __menulib.__minor >= __version then
		return;
	elseif __menulib == nil or __menulib.Halt == nil then
		__menulib = {  };
		__ala_meta__.__menulib = __menulib;
	else
		__menulib:Halt();
	end
	__menulib.__minor = __version;

-->
local uireimp = __ala_meta__.uireimp;
-- local autostyle = __ala_meta__.autostyle;

-->			upvalue
	local type = type;
	local GetCursorPosition = GetCursorPosition;
	local _ = nil;

-->			constant
	local MenuBackdropColor = { 0.05, 0.05, 0.05, 1.0 };
	local MenuBorderColor = { 1.0, 1.0, 1.0, 0.5 };
	local COUNTING_DOWN_TIMER_PERIOD = 1.5;
	local MenuButtonHeight = 16;
	local MenuButtonInterval = 0;
	local MenuButtonToHBorder = 2;
	local MenuButtonToVBorder = 2;

	local isRetail = __ala_meta__.BUILD == "RETAIL";
	local isBCC = __ala_meta__.BUILD == "BCC";
	local isWLK = __ala_meta__.BUILD == "WRATH";

	local MenuList = { total = 0, used = 0, prev = nil, };
	local frameToMenu = setmetatable({  }, { __mode = 'k', });

-->			Creator
	local MenuOnEvent = nil;
	if isRetail or isWLK then
		function MenuOnEvent(Menu, event)
			if Menu.__flag == "show" then
				Menu.__flag = nil;
			else
				Menu:SetScript("OnEvent", nil);
				Menu:Hide();
			end
		end
	else
		function MenuOnEvent(Menu, event)
			Menu:SetScript("OnEvent", nil);
			Menu:Hide();
		end
	end
	local function MenuOnUpdate(Menu, elasped)
		Menu.CountingDownTimer = Menu.CountingDownTimer - elasped;
		if Menu.CountingDownTimer <= 0 then
			Menu:Hide();
		end
	end
	local function MenuOnClick(Menu, button)
		Menu:Hide();
	end
	local function MenuOnEnter(Menu)
		Menu:SetScript("OnUpdate", nil);
		Menu:SetScript("OnEvent", nil);
	end
	local function MenuOnLeave(Menu)
		Menu.CountingDownTimer = COUNTING_DOWN_TIMER_PERIOD;
		Menu:SetScript("OnUpdate", MenuOnUpdate);
		Menu:SetScript("OnEvent", MenuOnEvent);
	end
	local function MenuOnShow(Menu)
		Menu.CountingDownTimer = COUNTING_DOWN_TIMER_PERIOD + 1.0;
		Menu:SetScript("OnUpdate", MenuOnUpdate);
		Menu:SetScript("OnEvent", MenuOnEvent);
		if MenuList.prev ~= Menu then
			if MenuList.prev then
				MenuList.prev:Hide();
			end
			MenuList.prev = Menu;
		end
	end
	local function MenuOnHide(Menu)
		Menu:SetScript("OnUpdate", nil);
		Menu:SetScript("OnEvent", nil);
		for i = 1, MenuList.used do
			if Menu == MenuList[i] then
				MenuList[i] = MenuList[MenuList.used]
				MenuList[MenuList.used] = Menu;
				Menu.used = MenuList.used - 1;
				frameToMenu[Menu.parent] = nil;
				break;
			end
		end
		if Menu == MenuList.prev then
			MenuList.prev = nil;
		end
		local Buttons = Menu.Buttons;
		for index = 1, Menu.__numbuttons do
			local Button = Buttons[index];
			if Button.__onhide ~= nil then
				Button:__onhide(Menu.param, Button.param);
			end
		end
		if Menu.__onhide ~= nil then
			Menu:__onhide(Menu.param);
		end
	end
	local function SetMenu(Menu)
		uireimp._SetSimpleBackdrop(Menu, -1, 1, MenuBackdropColor[1], MenuBackdropColor[2], MenuBackdropColor[3], MenuBackdropColor[4], MenuBorderColor[1], MenuBorderColor[2], MenuBorderColor[3], MenuBorderColor[4]);
	end
	local function CreateMenu()
		Menu = CreateFrame('BUTTON', nil, UIParent);
		Menu:SetFrameStrata("FULLSCREEN_DIALOG");
		Menu:SetClampedToScreen(true);
		Menu:Hide();
		SetMenu(Menu);
		Menu:SetScript("OnClick", MenuOnClick);
		Menu:SetScript("OnEnter", MenuOnEnter);
		Menu:SetScript("OnLeave", MenuOnLeave);
		Menu:SetScript("OnShow", MenuOnShow);
		Menu:SetScript("OnHide", MenuOnHide);
		if isRetail or isWLK then
			Menu:RegisterEvent("GLOBAL_MOUSE_UP");
		elseif isBCC then
			Menu:RegisterEvent("PLAYER_STARTED_LOOKING");
			-- Menu:RegisterEvent("PLAYER_STOPPED_LOOKING");
			Menu:RegisterEvent("PLAYER_STARTED_TURNING");
			-- Menu:RegisterEvent("PLAYER_STOPPED_TURNING");
		else
			Menu:RegisterEvent("CURSOR_UPDATE");
		end
		Menu.Buttons = {  };

		-- autostyle:AddReskinObject(Menu, "DROPDOWN");

		return Menu;
	end

	local function MenuButtonOnClick(Button, button)
		if Button.handler ~= nil then
			Button.handler(button, Button.Menu.param, Button.param);
		else
			Button.Menu.handler(button, Button.Menu.param, Button.param);
		end
		Button.Menu:Hide();
	end
	local function MenuButtonOnEnter(Button)
		MenuOnEnter(Button.Menu);
		if Button.__onenter ~= nil then
			return Button:__onenter(Button.Menu.param, Button.param);
		end
	end
	local function MenuButtonOnLeave(Button)
		MenuOnLeave(Button.Menu);
		if Button.__onleave ~= nil then
			return Button:__onleave(Button.Menu.param, Button.param);
		end
	end
	local function MenuCloseOnClick(Button, param, Menu)
		Menu:Hide();
	end
	local function SetButton(Button)
		-- Button:SetFrameStrata("FULLSCREEN_DIALOG");
		Button:SetHeight(MenuButtonHeight);
		-- Button:SetNormalTexture("Interface\\Buttons\\UI-StopButton");
		-- Button:SetPushedTexture("Interface\\Buttons\\UI-StopButton");
		-- Button:SetHighlightTexture("Interface\\TargetingFrame\\UI-StatusBar");
		-- Button:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.0, 0.75);
		local HT = Button.HT;
		HT:SetColorTexture(0.0, 0.25, 0.5, 1.0);
		HT:SetBlendMode("ADD");
		HT:SetAllPoints();
		Button:SetHighlightTexture(HT);

		local Text = Button.Text;
		Text:SetPoint("LEFT", 2, 0);
		Text:SetTextColor(0.9, 0.9, 0.9, 0.9);

		-- local Texture = Button.Texture;
		-- Texture:SetSize(MenuButtonHeight / 2, MenuButtonHeight);
		-- Texture:SetPoint("RIGHT", -2, 0);
		-- Texture:SetTexture("interface\\buttons\\ui-colorpicker-buttons");
		-- Texture:SetTexCoord(0.25, 0.375, 0.0, 1.0);
		-- Texture:SetVertexColor(1.0, 1.0, 0.25, 1.0);

	end
	local function CreateMenuButton(Menu, x, y)
		local Button = CreateFrame('BUTTON', nil, Menu);
		Button:SetPoint("TOP", Menu, "TOP", x, y);

		Button.HT = Button:CreateTexture(nil, "HIGHLIGHT");
		Button.Text = Button:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
		-- Button.Texture = Button:CreateTexture(nil, "ARTWORK");

		SetButton(Button);

		Button:SetScript("OnClick", MenuButtonOnClick);
		Button:SetScript("OnEnter", MenuButtonOnEnter);
		Button:SetScript("OnLeave", MenuButtonOnLeave);

		Button.Menu = Menu;

		return Button;
	end

-->			Method
	local function GetMenu(parent, anchor, useMousePosition, sideJustified)
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
				if sideJustified then
					Menu:SetPoint("BOTTOMLEFT", parent, "TOPLEFT", 0, 0);
				else
					Menu:SetPoint("BOTTOMLEFT", parent, "TOPRIGHT", 0, 0);
				end
			elseif anchor == "TOPLEFT" then
				if sideJustified then
					Menu:SetPoint("BOTTOMRIGHT", parent, "TOPRIGHT", 0, 0);
				else
					Menu:SetPoint("BOTTOMRIGHT", parent, "TOPLEFT", 0, 0);
				end
			elseif anchor == "BOTTOMRIGHT" then
				if sideJustified then
					Menu:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", 0, 0);
				else
					Menu:SetPoint("TOPLEFT", parent, "BOTTOMRIGHT", 0, 0);
				end
			elseif anchor == "BOTTOMLEFT" then
				if sideJustified then
					Menu:SetPoint("TOPRIGHT", parent, "BOTTOMRIGHT", 0, 0);
				else
					Menu:SetPoint("TOPRIGHT", parent, "BOTTOMLEFT", 0, 0);
				end
			elseif anchor == "TOP" then
					Menu:SetPoint("BOTTOM", parent, "TOP", 0, 0);
			elseif anchor == "BOTTOM" then
					Menu:SetPoint("TOP", parent, "BOTTOM", 0, 0);
			else
				if sideJustified then
					Menu:SetPoint("BOTTOMLEFT", parent, "TOPLEFT", 0, 0);
				else
					Menu:SetPoint("BOTTOMLEFT", parent, "TOPRIGHT", 0, 0);
				end
			end
		end
		return Menu;
	end
	local function ShowMenu(parent, anchor, data, param, useMousePosition, sideJustified)
		local Menu = frameToMenu[parent];
		if Menu ~= nil and Menu:IsShown() then
			Menu:Hide();
			frameToMenu[parent] = nil;
			Menu.__flag = nil;
			return;
		end
		if type(data) ~= "table" or data[1] == nil then
			return;
		end
		Menu = GetMenu(parent, anchor, useMousePosition, sideJustified);
		Menu.meta = data;
		Menu.handler = data.handler;
		Menu.param = param;

		if data.__onshowprepend ~= nil then
			data.__onshowprepend(Menu, param);
			Menu.__onhide = data.__onhide or SetMenu;
		end

		local Buttons = Menu.Buttons;
		local num = data.num or #data;

		local width = -1;
		local numButtons = 0;
		for i = 1, num do
			local ele = data[i];
			if ele.show ~= false and not ele.hide then
				numButtons = numButtons + 1;
				local Button = Buttons[numButtons];
				if Button == nil then
					Button = CreateMenuButton(Menu, 0, -((numButtons - 1) * (MenuButtonHeight + MenuButtonInterval) + MenuButtonToVBorder));
					Buttons[numButtons] = Button;
				end

				Button.meta = ele;
				Button.handler = ele.handler;
				Button.param = ele.param;
				Button:Show();

				Button.Text:SetText(ele.text);
				local __onshow = ele.__onshow or data.__buttononshow;
				if __onshow ~= nil then
					__onshow(Button, param, ele.param);
					Button.__onhide = ele.__onhide or data.__buttononhide or SetButton;
				end

				Button.__onenter = ele.__onenter or data.__buttononenter or nil;
				Button.__onleave = ele.__onleave or data.__buttononleave or nil;

				local w = Button.Text:GetWidth();
				if w > width then
					width = w;
				end
			end
		end
		numButtons = numButtons + 1;
		local Button = Buttons[numButtons];
		if Button == nil then
			Button = CreateMenuButton(Menu, 0, -((numButtons - 1) * (MenuButtonHeight + MenuButtonInterval) + MenuButtonToVBorder));
			Buttons[numButtons] = Button;
		end
		Button.handler = MenuCloseOnClick;
		Button.param = Menu;
		Button:Show();
		Button.Text:SetText("close");
		local w = Button.Text:GetWidth();
		if w > width then
			width = w;
		end

		Menu.__numbuttons = numButtons;
		if #Buttons > numButtons then
			for i = numButtons + 1, #Buttons do
				Buttons[i]:Hide();
			end
		end

		width = width + 4;
		for i = 1, numButtons do
			Buttons[i]:SetWidth(width);
		end
		Menu:SetWidth(width + MenuButtonToHBorder * 2);
		Menu:SetHeight(MenuButtonHeight * numButtons + MenuButtonInterval * (numButtons - 1) + MenuButtonToVBorder * 2);

		if data.__onshowappend ~= nil then
			data.__onshowappend(Menu, param);
			Menu.__onhide = data.__onhide or SetMenu;
		end

		Menu.__flag = "show";
		Menu:Show();
	end
-->

-- local function Update()
-- 	for i = 1, #MenuList do
-- 		if not MenuList[i].parent:IsShown() then
-- 			MenuList[i]:Hide();
-- 		end
-- 	end
-- end
-- C_Timer.NewTicker(0.2, Update);

__menulib.ShowMenu = ShowMenu;
-- __menulib.HideMenu = HideMenu;

function __menulib:Halt()
	for index = 1, MenuList.total do
		-- MenuOnEvent(MenuList[index], (isRetail or isWLK) and "GLOBAL_MOUSE_UP" or (isBCC and "PLAYER_STARTED_LOOKING" or "CURSOR_UPDATE"));
		MenuList[index]:Hide();
		MenuList[index]:SetScript("OnUpdate", nil);
		MenuList[index]:UnregisterAllEvents();
		MenuList[index]:SetScript("OnEvent", nil);
		wipe(frameToMenu);
	end
end

_G["ALAMENU"] = ShowMenu;
