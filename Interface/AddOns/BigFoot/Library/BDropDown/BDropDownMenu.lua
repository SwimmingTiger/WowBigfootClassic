
BDROPDOWNMENU_MINBUTTONS = 8;
BDROPDOWNMENU_MAXBUTTONS = 8;
BDROPDOWNMENU_MAXLEVELS = 2;
BDROPDOWNMENU_BUTTON_HEIGHT = 16;
BDROPDOWNMENU_BORDER_HEIGHT = 15;
-- The current open menu
BDROPDOWNMENU_OPEN_MENU = nil;
-- The current menu being initialized
BDROPDOWNMENU_INIT_MENU = nil;
-- Current level shown of the open menu
BDROPDOWNMENU_MENU_LEVEL = 1;
-- Current value of the open menu
BDROPDOWNMENU_MENU_VALUE = nil;
-- Time to wait to hide the menu
BDROPDOWNMENU_SHOW_TIME = 2;
-- Default dropdown text height
BDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 14;
-- List of open menus
BOPEN_DROPDOWNMENUS = {};

tinsert(UISpecialFrames, "BDropDownList1");
tinsert(UISpecialFrames, "BDropDownList2");

-------------------------------------------------------------------------
-- ��ʼ��DropDown,һ������OnLoadʱ
-- ����:
--	frame: ������Ϣ��frame,�̳���BDropDownMenuTemplate ȱʡΪthis
--	initFunction: ��������
--	displayerMod: ��ʾ��ʽ,�˵�����..
--	level: ��ʾ���,ȱʡΪ 1
-------------------------------------------------------------------------
function BDropDownMenu_Initialize(frame, initFunction, displayMode, level, menuList)
	assert(frame);
	-- ���������˵�������
	frame.menuList = menuList;

	if ( frame:GetName() ~= BDROPDOWNMENU_OPEN_MENU ) then
		BDROPDOWNMENU_MENU_LEVEL = 1;
	end

	-- Set the frame that's being intialized
	BDROPDOWNMENU_INIT_MENU = frame:GetName();

	-- Hide all the buttons
	local button, dropDownList;
	for i = 1, BDROPDOWNMENU_MAXLEVELS, 1 do
		dropDownList = getglobal("BDropDownList"..i);
		if ( i >= BDROPDOWNMENU_MENU_LEVEL or frame:GetName() ~= BDROPDOWNMENU_OPEN_MENU ) then
			dropDownList.numButtons = 0;
			dropDownList.maxWidth = 0;
			for j=1, BDROPDOWNMENU_MAXBUTTONS, 1 do
				button = getglobal("BDropDownList"..i.."Button"..j);
				button:Hide();
			end
			dropDownList:Hide();
		end
	end
	frame:SetHeight(BDROPDOWNMENU_BUTTON_HEIGHT * 2);

	-- Set the initialize function and call it.  The initFunction populates the dropdown list.
	if ( initFunction ) then
		frame.initialize = initFunction;
		initFunction(frame, level, frame.menuList);
	end

	-- Change appearance based on the displayMode
	if ( frame.displayMode ~= "MENU" and displayMode == "MENU" ) then
		getglobal(frame:GetName().."Left"):Hide();
		getglobal(frame:GetName().."Middle"):Hide();
		getglobal(frame:GetName().."Right"):Hide();
		getglobal(frame:GetName().."ButtonNormalTexture"):SetTexture("");
		getglobal(frame:GetName().."ButtonDisabledTexture"):SetTexture("");
		getglobal(frame:GetName().."ButtonPushedTexture"):SetTexture("");
		getglobal(frame:GetName().."ButtonHighlightTexture"):SetTexture("");
		getglobal(frame:GetName().."Button"):ClearAllPoints();
		getglobal(frame:GetName().."Button"):SetPoint("LEFT", frame:GetName().."Text", "LEFT", -9, 0);
		getglobal(frame:GetName().."Button"):SetPoint("RIGHT", frame:GetName().."Text", "RIGHT", 6, 0);
		frame.displayMode = "MENU";
	end
end

-- If dropdown is visible then see if its timer has expired, if so hide the frame
function BDropDownMenu_OnUpdate(self, elapsed)
	if ( not self.showTimer or not self.isCounting ) then
		return;
	elseif ( self.showTimer < 0 ) then
		self:Hide();
		self.showTimer = nil;
		self.isCounting = nil;
	else
		self.showTimer = self.showTimer - elapsed;
	end
end

-- Start the countdown on a frame
function BDropDownMenu_StartCounting(frame)
	if ( frame.parent ) then
		BDropDownMenu_StartCounting(frame.parent);
	else
		frame.showTimer = BDROPDOWNMENU_SHOW_TIME;
		frame.isCounting = 1;
	end
end

-- Stop the countdown on a frame
function BDropDownMenu_StopCounting(frame)
	if ( frame.parent ) then
		BDropDownMenu_StopCounting(frame.parent);
	else
		frame.isCounting = nil;
	end
end

--[[
List of button attributes
======================================================
info.text = [STRING]  --  The text of the button
info.value = [ANYTHING]  --  The value that BDROPDOWNMENU_MENU_VALUE is set to when the button is clicked
info.func = [function()]  --  The function that is called when you click the button
info.checked = [nil, 1, function]  --  Check the button if true or function returns true
info.isTitle = [nil, 1]  --  If it's a title the button is disabled and the font color is set to yellow
info.disabled = [nil, 1, function]  --  Disable the button and show an invisible button that still traps the mouseover event so menu doesn't time out
info.hasArrow = [nil, 1]  --  Show the expand arrow for multilevel menus
info.hasColorSwatch = [nil, 1]  --  Show color swatch or not, for color selection
info.r = [1 - 255]  --  Red color value of the color swatch
info.g = [1 - 255]  --  Green color value of the color swatch
info.b = [1 - 255]  --  Blue color value of the color swatch
info.textR = [1 - 255]  --  Red color value of the button text
info.textG = [1 - 255]  --  Green color value of the button text
info.textB = [1 - 255]  --  Blue color value of the button text
info.swatchFunc = [function()]  --  Function called by the color picker on color change
info.hasOpacity = [nil, 1]  --  Show the opacity slider on the colorpicker frame
info.opacity = [0.0 - 1.0]  --  Percentatge of the opacity, 1.0 is fully shown, 0 is transparent
info.opacityFunc = [function()]  --  Function called by the opacity slider when you change its value
info.cancelFunc = [function(previousValues)] -- Function called by the colorpicker when you click the cancel button (it takes the previous values as its argument)
info.notClickable = [nil, 1]  --  Disable the button and color the font white
info.notCheckable = [nil, 1]  --  Shrink the size of the buttons and don't display a check box
info.owner = [Frame]  --  Dropdown frame that "owns" the current dropdownlist
info.keepShownOnClick = [nil, 1]  --  Don't hide the dropdownlist after a button is clicked
info.tooltipTitle = [nil, STRING] -- Title of the tooltip shown on mouseover
info.tooltipText = [nil, STRING] -- Text of the tooltip shown on mouseover
info.justifyH = [nil, "CENTER"] -- Justify button text
info.arg1 = [ANYTHING] -- This is the first argument used by info.func
info.arg2 = [ANYTHING] -- This is the second argument used by info.func
info.textHeight = [NUMBER] -- font height for button text
info.subMenu = [TABLE] -- This contains an array of info tables to be displayed as a child menu
]]

local BDropDownMenu_ButtonInfo = {};

-- ���table������
function BDropDownMenu_CreateInfo()
	-- Reuse the same table to prevent memory churn
	local info = BDropDownMenu_ButtonInfo;
	for k,v in pairs(info) do
		info[k] = nil;
	end
	return BDropDownMenu_ButtonInfo;
end

-------------------------------------------------------------------------------
-- �����µĲ˵��Ͱ���
-------------------------------------------------------------------------------
function BDropDownMenu_CreateFrames(level, index)
	while ( level > BDROPDOWNMENU_MAXLEVELS ) do
		BDROPDOWNMENU_MAXLEVELS = BDROPDOWNMENU_MAXLEVELS + 1;
		local newList = CreateFrame("Button", "BDropDownList"..BDROPDOWNMENU_MAXLEVELS, nil, "BDropDownListTemplate");
		newList:SetFrameStrata("FULLSCREEN_DIALOG");
		newList:SetToplevel(1);
		newList:Hide();
		newList:SetID(BDROPDOWNMENU_MAXLEVELS);
		newList:SetWidth(180)
		newList:SetHeight(10)
		for i=BDROPDOWNMENU_MINBUTTONS+1, BDROPDOWNMENU_MAXBUTTONS do
			local newButton = CreateFrame("Button", "BDropDownList"..BDROPDOWNMENU_MAXLEVELS.."Button"..i, newList, "BDropDownMenuButtonTemplate");
			newButton:SetID(i);
		end
	end

	while ( index > BDROPDOWNMENU_MAXBUTTONS ) do
		BDROPDOWNMENU_MAXBUTTONS = BDROPDOWNMENU_MAXBUTTONS + 1;
		for i=1, BDROPDOWNMENU_MAXLEVELS do
			local newButton = CreateFrame("Button", "BDropDownList"..i.."Button"..BDROPDOWNMENU_MAXBUTTONS, getglobal("BDropDownList"..i), "BDropDownMenuButtonTemplate");
			newButton:SetID(BDROPDOWNMENU_MAXBUTTONS);
		end
	end
end

function BDropDownMenu_AddButton(info, level)
	--[[
	Might to uncomment this if there are performance issues
	if ( not BDROPDOWNMENU_OPEN_MENU ) then
		return;
	end
	]]
	if ( not level ) then
		level = 1;
	end

	local listFrame = getglobal("BDropDownList"..level);
	local listFrameName = listFrame:GetName();
	local index = listFrame.numButtons + 1;
	local width;

	BDropDownMenu_CreateFrames(level, index);

	-- Set the number of buttons in the listframe
	listFrame.numButtons = index;

	local button = getglobal(listFrameName.."Button"..index);
	local normalText = getglobal(button:GetName().."NormalText");
	local icon = getglobal(button:GetName().."Icon");
	-- This button is used to capture the mouse OnEnter/OnLeave events if the dropdown button is disabled, since a disabled button doesn't receive any events
	-- This is used specifically for drop down menu time outs
	local invisibleButton = getglobal(button:GetName().."InvisibleButton");

	local disabled;
	-- Default settings
	button:SetDisabledFontObject(GameFontDisableSmallLeft);
	invisibleButton:Hide();
	button:Enable();

	-- If not clickable then disable the button and set it white
	if ( info.notClickable ) then
		disabled = 1;
		button:SetDisabledFontObject(GameFontHighlightSmallLeft);
	end

	-- Set the text color and disable it if its a title
	if ( info.isTitle ) then
		disabled = 1;
		button:SetDisabledFontObject(GameFontNormalSmallLeft);
	end

	if (type(info.disabled) == "function") then
		disabled = info.disabled();
	end

	-- Disable the button if disabled and turn off the color code
	if ( disabled ) then
		button:Disable();
		invisibleButton:Show();
		info.colorCode = nil;
	end

	-- Configure button
	if ( info.text ) then
		-- look for inline color code this is only if the button is enabled
		if ( info.colorCode ) then
			button:SetText(info.colorCode..info.text.."|r");
		else
			button:SetText(info.text);
		end
		-- Determine the width of the button
		width = normalText:GetWidth() + 40;
		-- Add padding if has and expand arrow or color swatch
		if ( info.hasArrow or info.hasColorSwatch ) then
			width = width + 10;
		end
		if ( info.notCheckable ) then
			width = width - 30;
		end
		-- Set icon
		if ( info.icon ) then
			icon:SetTexture(info.icon);
			if ( info.tCoordLeft ) then
				icon:SetTexCoord(info.tCoordLeft, info.tCoordRight, info.tCoordTop, info.tCoordBottom);
			else
				icon:SetTexCoord(0, 1, 0, 1);
			end
			icon:Show();
			-- Add padding for the icon
			width = width + 10;
		else
			icon:Hide();
		end
		-- Set maximum button width
		if ( width > listFrame.maxWidth ) then
			listFrame.maxWidth = width;
		end
		-- Check to see if there is a replacement font
		if ( info.fontObject ) then
			button:SetNormalFontObject(info.fontObject);
			button:SetHighlightFontObject(info.fontObject);
		else
			button:SetNormalFontObject(GameFontHighlightSmallLeft);
			button:SetHighlightFontObject(GameFontHighlightSmallLeft);
		end
	else
		button:SetText("");
		icon:Hide();
	end

	-- Pass through attributes
	button.func = info.func;
	button.owner = info.owner;
	button.hasOpacity = info.hasOpacity;
	button.opacity = info.opacity;
	button.opacityFunc = info.opacityFunc;
	button.cancelFunc = info.cancelFunc;
	button.swatchFunc = info.swatchFunc;
	button.keepShownOnClick = info.keepShownOnClick;
	button.tooltipTitle = info.tooltipTitle;
	button.tooltipText = info.tooltipText;
	button.arg1 = info.arg1;
	button.arg2 = info.arg2;
	button.hasArrow = info.hasArrow;
	button.hasColorSwatch = info.hasColorSwatch;
	button.notCheckable = info.notCheckable;
	button.menuList = info.subMenu;

	if ( info.value ) then
		button.value = info.value;
	elseif ( info.text ) then
		button.value = info.text;
	else
		button.value = nil;
	end

	-- Show the expand arrow if it has one
	if ( info.hasArrow ) then
		getglobal(listFrameName.."Button"..index.."ExpandArrow"):Show();
	else
		getglobal(listFrameName.."Button"..index.."ExpandArrow"):Hide();
	end
	button.hasArrow = info.hasArrow;

	-- If not checkable move everything over to the left to fill in the gap where the check would be
	local xPos = 5;
	local yPos = -((button:GetID() - 1) * BDROPDOWNMENU_BUTTON_HEIGHT) - BDROPDOWNMENU_BORDER_HEIGHT;
	normalText:ClearAllPoints();
	if ( info.notCheckable ) then
		if ( info.justifyH and info.justifyH == "CENTER" ) then
			normalText:SetPoint("CENTER", button, "CENTER", -7, 0);
		else
			normalText:SetPoint("LEFT", button, "LEFT", 0, 0);
		end
		xPos = xPos + 10;

	else
		xPos = xPos + 12;
		normalText:SetPoint("LEFT", button, "LEFT", 20, 0);
	end

	-- Adjust offset if displayMode is menu
	local frame = getglobal(BDROPDOWNMENU_OPEN_MENU);
	if ( frame and frame.displayMode == "MENU" ) then
		if ( not info.notCheckable ) then
			xPos = xPos - 6;
		end
	end

	-- If no open frame then set the frame to the currently initialized frame
	if ( not frame ) then
		frame = getglobal(BDROPDOWNMENU_INIT_MENU);
	end

	button:SetPoint("TOPLEFT", button:GetParent(), "TOPLEFT", xPos, yPos);

	-- See if button is selected by id or name
	if ( frame ) then
		if ( BDropDownMenu_GetSelectedName(frame) ) then
			if ( button:GetText() == BDropDownMenu_GetSelectedName(frame) ) then
				info.checked = 1;
			end
		elseif ( BDropDownMenu_GetSelectedID(frame) ) then
			if ( button:GetID() == BDropDownMenu_GetSelectedID(frame) ) then
				info.checked = 1;
			end
		elseif ( BDropDownMenu_GetSelectedValue(frame) ) then
			if ( button.value == BDropDownMenu_GetSelectedValue(frame) ) then
				info.checked = 1;
			end
		end
	end

	-- Checked can be a function now
	local checked = info.checked;
	if ( type(checked) == "function" ) then
		checked = checked();
	end

	-- Show the check if checked
	if ( checked ) then
		button:LockHighlight();
		getglobal(listFrameName.."Button"..index.."Check"):Show();
	else
		button:UnlockHighlight();
		getglobal(listFrameName.."Button"..index.."Check"):Hide();
	end
	button.checked = info.checked;

	-- If has a colorswatch, show it and vertex color it
	local colorSwatch = getglobal(listFrameName.."Button"..index.."ColorSwatch");
	if ( info.hasColorSwatch ) then
		getglobal("BDropDownList"..level.."Button"..index.."ColorSwatch".."NormalTexture"):SetVertexColor(info.r, info.g, info.b);
		button.r = info.r;
		button.g = info.g;
		button.b = info.b;
		colorSwatch:Show();
	else
		colorSwatch:Hide();
	end

	-- Set the height of the listframe
	listFrame:SetHeight((index * BDROPDOWNMENU_BUTTON_HEIGHT) + (BDROPDOWNMENU_BORDER_HEIGHT * 2));

	button:Show();
end

function BDropDownMenu_Refresh(frame, useValue, dropdownLevel)
	local button, checked, checkImage, normalText, width;
	local maxWidth = 0;
	assert(frame);
	if ( not dropdownLevel ) then
		dropdownLevel = BDROPDOWNMENU_MENU_LEVEL;
	end

	-- Just redraws the existing menu
	for i=1, BDROPDOWNMENU_MAXBUTTONS do
		button = getglobal("BDropDownList"..dropdownLevel.."Button"..i);
		checked = nil;
		-- See if checked or not
		if ( BDropDownMenu_GetSelectedName(frame) ) then
			if ( button:GetText() == BDropDownMenu_GetSelectedName(frame) ) then
				checked = 1;
			end
		elseif ( BDropDownMenu_GetSelectedID(frame) ) then
			if ( button:GetID() == BDropDownMenu_GetSelectedID(frame) ) then
				checked = 1;
			end
		elseif ( BDropDownMenu_GetSelectedValue(frame) ) then
			if ( button.value == BDropDownMenu_GetSelectedValue(frame) ) then
				checked = 1;
			end
		end

		-- If checked show check image
		checkImage = getglobal("BDropDownList"..dropdownLevel.."Button"..i.."Check");
		if ( checked ) then
			if ( useValue ) then
				BDropDownMenu_SetText(frame, button.value);
			else
				BDropDownMenu_SetText(frame, button:GetText());
			end
			button:LockHighlight();
			checkImage:Show();
		else
			button:UnlockHighlight();
			checkImage:Hide();
		end

		if ( button:IsShown() ) then
			normalText = getglobal(button:GetName().."NormalText");
			-- Determine the maximum width of a button
			width = normalText:GetWidth() + 40;
			-- Add padding if has and expand arrow or color swatch
			if ( button.hasArrow or button.hasColorSwatch ) then
				width = width + 10;
			end
			if ( button.notCheckable ) then
				width = width - 30;
			end
			if ( width > maxWidth ) then
				maxWidth = width;
			end
		end
	end
	for i=1, BDROPDOWNMENU_MAXBUTTONS do
		button = getglobal("BDropDownList"..dropdownLevel.."Button"..i);
		button:SetWidth(maxWidth);
	end
	getglobal("BDropDownList"..dropdownLevel):SetWidth(maxWidth+15);
end

function BDropDownMenu_ResetValues ()
	-- This will either taint everything, or clean taint off of everything, so be careful. Calling this while any dropdown menus are open/displayed is not recommended.

	BDROPDOWNMENU_MINBUTTONS = 8;
	BDROPDOWNMENU_MAXBUTTONS = 8;
	BDROPDOWNMENU_MAXLEVELS = 2;
	BDROPDOWNMENU_BUTTON_HEIGHT = 16;
	BDROPDOWNMENU_BORDER_HEIGHT = 15;
	-- The current open menu
	BDROPDOWNMENU_OPEN_MENU = nil;
	-- The current menu being initialized
	BDROPDOWNMENU_INIT_MENU = nil;
	-- Current level shown of the open menu
	BDROPDOWNMENU_MENU_LEVEL = 1;
	-- Current value of the open menu
	BDROPDOWNMENU_MENU_VALUE = nil;
	-- Time to wait to hide the menu
	BDROPDOWNMENU_SHOW_TIME = 2;
	-- Default dropdown text height
	BDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = nil;
	-- List of open menus
	BOPEN_DROPDOWNMENUS = {};
	BDropDownMenu_ButtonInfo = {};
end

function BDropDownMenu_SetSelectedName(frame, name, useValue)
	frame.selectedName = name;
	frame.selectedID = nil;
	frame.selectedValue = nil;
	BDropDownMenu_Refresh(frame, useValue);
end

function BDropDownMenu_SetSelectedValue(frame, value, useValue)
	-- useValue will set the value as the text, not the name
	frame.selectedName = nil;
	frame.selectedID = nil;
	frame.selectedValue = value;
	BDropDownMenu_Refresh(frame, useValue);
end

function BDropDownMenu_SetSelectedID(frame, id, useValue)
	frame.selectedID = id;
	frame.selectedName = nil;
	frame.selectedValue = nil;
	BDropDownMenu_Refresh(frame, useValue);
end

function BDropDownMenu_GetSelectedName(frame)
	return frame.selectedName;
end

function BDropDownMenu_GetSelectedID(frame)
	if ( frame.selectedID ) then
		return frame.selectedID;
	else
		-- If no explicit selectedID then try to send the id of a selected value or name
		local button;
		for i=1, BDROPDOWNMENU_MAXBUTTONS do
			button = getglobal("BDropDownList"..BDROPDOWNMENU_MENU_LEVEL.."Button"..i);
			-- See if checked or not
			if ( BDropDownMenu_GetSelectedName(frame) ) then
				if ( button:GetText() == BDropDownMenu_GetSelectedName(frame) ) then
					return i;
				end
			elseif ( BDropDownMenu_GetSelectedValue(frame) ) then
				if ( button.value == BDropDownMenu_GetSelectedValue(frame) ) then
					return i;
				end
			end
		end
	end
end

function BDropDownMenu_GetSelectedValue(frame)
	return frame.selectedValue;
end

function BDropDownMenuButton_OnClick(self)
	local checked = self.checked;
	if ( type (checked) == "function" ) then
		checked = checked();
	end

	if ( self.keepShownOnClick ) then
		if ( checked ) then
			getglobal(self:GetName().."Check"):Hide();
			checked = false;
		else
			getglobal(self:GetName().."Check"):Show();
			checked = true;
		end
	else
		self:GetParent():Hide();
	end

	if ( type (self.checked) ~= "function" ) then
		self.checked = checked;
	end

	local func = self.func;
	if ( func ) then
		func(self, self.arg1, self.arg2, checked);
	else
		return;
	end

	PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
end

function BHideDropDownMenu(level)
	local listFrame = getglobal("BDropDownList"..level);
	listFrame:Hide();
end

function BToggleDropDownMenu(level, value, dropDownFrame, anchorName, xOffset, yOffset, menuList, button)
	if ( not level ) then
		level = 1;
	end
	BDropDownMenu_CreateFrames(level, 0);
	BDROPDOWNMENU_MENU_LEVEL = level;
	BDROPDOWNMENU_MENU_VALUE = value;
	local listFrame = getglobal("BDropDownList"..level);
	local listFrameName = "BDropDownList"..level;
	local tempFrame;
	local point, relativePoint, relativeTo;
	if ( not dropDownFrame ) then
		tempFrame =button:GetParent();
	else
		tempFrame = dropDownFrame;
	end
	if ( listFrame:IsShown() and (BDROPDOWNMENU_OPEN_MENU == tempFrame:GetName()) ) then
		listFrame:Hide();
	else
		-- Set the dropdownframe scale
		local uiScale;
		local uiParentScale = UIParent:GetScale();
		if ( tempFrame ~= WorldMapContinentDropDown and tempFrame ~= WorldMapZoneDropDown ) then
			if ( GetCVar("useUIScale") == "1" ) then
				uiScale = tonumber(GetCVar("uiscale"));
				if ( uiParentScale < uiScale ) then
					uiScale = uiParentScale;
				end
			else
				uiScale = uiParentScale;
			end
		else
					uiScale = 1;
		end
		listFrame:SetScale(uiScale);

		-- Hide the listframe anyways since it is redrawn OnShow()
		listFrame:Hide();

		-- Frame to anchor the dropdown menu to
		local anchorFrame;

		-- Display stuff
		-- Level specific stuff
		if ( level == 1 ) then
			assert(dropDownFrame);
			BDROPDOWNMENU_OPEN_MENU = dropDownFrame:GetName();
			listFrame:ClearAllPoints();
			-- If there's no specified anchorName then use left side of the dropdown menu
			if ( not anchorName ) then
				-- See if the anchor was set manually using setanchor
				if ( dropDownFrame.xOffset ) then
					xOffset = dropDownFrame.xOffset;
				end
				if ( dropDownFrame.yOffset ) then
					yOffset = dropDownFrame.yOffset;
				end
				if ( dropDownFrame.point ) then
					point = dropDownFrame.point;
				end
				if ( dropDownFrame.relativeTo ) then
					relativeTo = dropDownFrame.relativeTo;
				else
					relativeTo = BDROPDOWNMENU_OPEN_MENU.."Left";
				end
				if ( dropDownFrame.relativePoint ) then
					relativePoint = dropDownFrame.relativePoint;
				end
			elseif ( anchorName == "cursor" ) then
				relativeTo = nil;
				local cursorX, cursorY = GetCursorPosition();
				cursorX = cursorX/uiScale;
				cursorY =  cursorY/uiScale;

				if ( not xOffset ) then
					xOffset = 0;
				end
				if ( not yOffset ) then
					yOffset = 0;
				end
				xOffset = cursorX + xOffset;
				yOffset = cursorY + yOffset;
				if ( dropDownFrame.point ) then
					point = dropDownFrame.point;
				end
			else
				-- See if the anchor was set manually using setanchor
				if ( dropDownFrame.xOffset ) then
					xOffset = dropDownFrame.xOffset;
				end
				if ( dropDownFrame.yOffset ) then
					yOffset = dropDownFrame.yOffset;
				end
				if ( dropDownFrame.point ) then
					point = dropDownFrame.point;
				end
				if ( dropDownFrame.relativeTo ) then
					relativeTo = dropDownFrame.relativeTo;
				else
					relativeTo = anchorName;
				end
				if ( dropDownFrame.relativePoint ) then
					relativePoint = dropDownFrame.relativePoint;
				end
			end
			if ( not xOffset or not yOffset ) then
				xOffset = 8;
				yOffset = 22;
			end
			if ( not point ) then
				point = "TOPLEFT";
			end
			if ( not relativePoint ) then
				relativePoint = "BOTTOMLEFT";
			end
			listFrame:SetPoint(point, relativeTo, relativePoint, xOffset, yOffset);
		else
			if ( not dropDownFrame ) then
				dropDownFrame = getglobal(BDROPDOWNMENU_OPEN_MENU);
			end
			listFrame:ClearAllPoints();
			-- If this is a dropdown button, not the arrow anchor it to itself
			if ( strsub(button:GetParent():GetName(), 0,13) == "BDropDownList" and strlen(button:GetParent():GetName()) == 14 ) then
				anchorFrame = button:GetName();
			else
				anchorFrame = button:GetParent():GetName();
			end
			point = "TOPLEFT";
			relativePoint = "TOPRIGHT";
			listFrame:SetPoint(point, anchorFrame, relativePoint, 0, 0);
		end

		-- Change list box appearance depending on display mode
		if ( dropDownFrame and dropDownFrame.displayMode == "MENU" ) then
			getglobal(listFrameName.."Backdrop"):Hide();
			getglobal(listFrameName.."MenuBackdrop"):Show();
		else
			getglobal(listFrameName.."Backdrop"):Show();
			getglobal(listFrameName.."MenuBackdrop"):Hide();
		end

		menuList = menuList or dropDownFrame.menuList;
		BDropDownMenu_Initialize(dropDownFrame, dropDownFrame.initialize, dropDownFrame.displayMode, level, menuList);
		-- If no items in the drop down don't show it
		if ( listFrame.numButtons == 0 ) then
			return;
		end

		-- Check to see if the dropdownlist is off the screen, if it is anchor it to the top of the dropdown button
		listFrame:Show();
		-- Hack since GetCenter() is returning coords relative to 1024x768
		local x, y = listFrame:GetCenter();
		-- Hack will fix this in next revision of dropdowns
		if ( not x or not y ) then
			listFrame:Hide();
			return;
		end
		-- Determine whether the menu is off the screen or not
		local offscreenY, offscreenX;
		if ( (y - listFrame:GetHeight()/2) < 0 ) then
			offscreenY = 1;
		end
		if ( listFrame:GetRight() > GetScreenWidth() ) then
			offscreenX = 1;
		end

		--  If level 1 can only go off the bottom of the screen
		if ( level == 1 ) then
			if ( offscreenY and offscreenX ) then
				point = gsub(point, "TOP(.*)", "BOTTOM%1");
				point = gsub(point, "(.*)LEFT", "%1RIGHT");
				relativePoint = gsub(relativePoint, "TOP(.*)", "BOTTOM%1");
				relativePoint = gsub(relativePoint, "(.*)RIGHT", "%1LEFT");
			elseif ( offscreenY ) then
				point = gsub(point, "TOP(.*)", "BOTTOM%1");
				relativePoint = gsub(relativePoint, "(.*)RIGHT", "%1LEFT");
			elseif ( offscreenX ) then
				point = gsub(point, "(.*)LEFT", "%1RIGHT");
				relativePoint = gsub(relativePoint, "(.*)RIGHT", "%1LEFT");
			end

			listFrame:ClearAllPoints();
			if ( anchorName == "cursor" ) then
				listFrame:SetPoint(point, relativeTo, "BOTTOMLEFT", xOffset, yOffset);
			else
				listFrame:SetPoint(point, relativeTo, relativePoint, xOffset, yOffset);
			end
		else
			if ( offscreenY and offscreenX ) then
				point = gsub(point, "TOP(.*)", "BOTTOM%1");
				point = gsub(point, "(.*)LEFT", "%1RIGHT");
				relativePoint = gsub(relativePoint, "TOP(.*)", "BOTTOM%1");
				relativePoint = gsub(relativePoint, "(.*)RIGHT", "%1LEFT");
				xOffset = -11;
				yOffset = -14;
			elseif ( offscreenY ) then
				point = gsub(point, "TOP(.*)", "BOTTOM%1");
				relativePoint = gsub(relativePoint, "TOP(.*)", "BOTTOM%1");
				xOffset = 0;
				yOffset = -14;
			elseif ( offscreenX ) then
				point = gsub(point, "(.*)LEFT", "%1RIGHT");
				relativePoint = gsub(relativePoint, "(.*)RIGHT", "%1LEFT");
				xOffset = -11;
				yOffset = 14;
			else
				xOffset = 0;
				yOffset = 14;
			end

			listFrame:ClearAllPoints();
			listFrame:SetPoint(point, anchorFrame, relativePoint, xOffset, yOffset);
		end
	end
end

function BCloseDropDownMenus(level)
	if ( not level ) then
		level = 1;
	end
	for i=level, BDROPDOWNMENU_MAXLEVELS do
		getglobal("BDropDownList"..i):Hide();
	end
end

function BDropDownMenu_OnHide(self)
	local id = self:GetID()
	BCloseDropDownMenus(id+1);
	BOPEN_DROPDOWNMENUS[id] = nil;
end

function BDropDownMenu_SetWidth(frame, width, padding)
	getglobal(frame:GetName().."Middle"):SetWidth(width);
	local defaultPadding = 25;
	if ( padding ) then
		frame:SetWidth(width + padding);
	else
		frame:SetWidth(width + defaultPadding + defaultPadding);
	end
	if ( padding ) then
		getglobal(frame:GetName().."Text"):SetWidth(width);
	else
		getglobal(frame:GetName().."Text"):SetWidth(width - defaultPadding);
	end
	frame.noResize = 1;
end

function BDropDownMenu_SetButtonWidth(frame, width)
	if ( width == "TEXT" ) then
		width = getglobal(frame:GetName().."Text"):GetWidth();
	end

	getglobal(frame:GetName().."Button"):SetWidth(width);
	frame.noResize = 1;
end

function BDropDownMenu_SetText(frame, text)
	local filterText = getglobal(frame:GetName().."Text");
	filterText:SetText(text);
end

function BDropDownMenu_GetText(frame)
	assert(frame);
	local filterText = getglobal(frame:GetName().."Text");
	return filterText:GetText();
end

function BDropDownMenu_ClearAll(frame)
	-- Previous code refreshed the menu quite often and was a performance bottleneck
	frame.selectedID = nil;
	frame.selectedName = nil;
	frame.selectedValue = nil;
	BDropDownMenu_SetText(frame, "");

	local button, checkImage;
	for i=1, BDROPDOWNMENU_MAXBUTTONS do
		button = getglobal("BDropDownList"..BDROPDOWNMENU_MENU_LEVEL.."Button"..i);
		button:UnlockHighlight();

		checkImage = getglobal("BDropDownList"..BDROPDOWNMENU_MENU_LEVEL.."Button"..i.."Check");
		checkImage:Hide();
	end
end

function BDropDownMenu_JustifyText(frame, justification)
	local text = getglobal(frame:GetName().."Text");
	text:ClearAllPoints();
	if ( justification == "LEFT" ) then
		text:SetPoint("LEFT", frame:GetName().."Left", "LEFT", 27, 2);
		text:SetJustifyH("LEFT");
	elseif ( justification == "RIGHT" ) then
		text:SetPoint("RIGHT", frame:GetName().."Right", "RIGHT", -43, 2);
		text:SetJustifyH("RIGHT");
	elseif ( justification == "CENTER" ) then
		text:SetPoint("CENTER", frame:GetName().."Middle", "CENTER", -5, 2);
		text:SetJustifyH("CENTER");
	end
end

function BDropDownMenu_SetAnchor(dropdown, xOffset, yOffset, point, relativeTo, relativePoint)
	dropdown.xOffset = xOffset;
	dropdown.yOffset = yOffset;
	dropdown.point = point;
	dropdown.relativeTo = relativeTo;
	dropdown.relativePoint = relativePoint;
end

function BDropDownMenu_GetCurrentDropDown()
	if ( BDROPDOWNMENU_OPEN_MENU ) then
		return getglobal(BDROPDOWNMENU_OPEN_MENU);
	elseif ( BDROPDOWNMENU_INIT_MENU ) then
		return getglobal(BDROPDOWNMENU_INIT_MENU);
	end

	-- If no dropdown then use this? NOOO~!
	assert(false);
end

function BDropDownMenuButton_GetChecked(self)
	return getglobal(self:GetName().."Check"):IsShown();
end

function BDropDownMenuButton_GetName(self)
	return getglobal(self:GetName().."NormalText"):GetText();
end

function BDropDownMenuButton_OpenColorPicker(self, button)
	BCloseDropDownMenus();
	if ( not button ) then
		button = self;
	end
	BDROPDOWNMENU_MENU_VALUE = button.value;
	OpenColorPicker(button);
end

function BDropDownMenu_DisableButton(level, id)
	getglobal("BDropDownList"..level.."Button"..id):Disable();
end

function BDropDownMenu_EnableButton(level, id)
	getglobal("BDropDownList"..level.."Button"..id):Enable();
end

function BDropDownMenu_SetButtonText(level, id, text, colorCode)
	local button = getglobal("BDropDownList"..level.."Button"..id);
	if ( colorCode) then
		button:SetText(colorCode..text.."|r");
	else
		button:SetText(text);
	end
end

function BDropDownMenu_DisableDropDown(dropDown)
	local label = getglobal(dropDown:GetName().."Label");
	if ( label ) then
		label:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	end
	getglobal(dropDown:GetName().."Text"):SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	getglobal(dropDown:GetName().."Button"):Disable();
	dropDown.isDisabled = 1;
end

function BDropDownMenu_EnableDropDown(dropDown)
	local label = getglobal(dropDown:GetName().."Label");
	if ( label ) then
		label:SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
	getglobal(dropDown:GetName().."Text"):SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	getglobal(dropDown:GetName().."Button"):Enable();
	dropDown.isDisabled = nil;
end

function BDropDownMenu_IsEnabled(dropDown)
	return not dropDown.isDisabled;
end

function BDropDownMenu_GetValue(id)
	--Only works if the dropdown has just been initialized, lame, I know =(
	local button = getglobal("BDropDownList1Button"..id);
	if ( button ) then
		return getglobal("BDropDownList1Button"..id).value;
	else
		return nil;
	end
end

function BOpenColorPicker(info)
	ColorPickerFrame.func = info.swatchFunc;
	ColorPickerFrame.hasOpacity = info.hasOpacity;
	ColorPickerFrame.opacityFunc = info.opacityFunc;
	ColorPickerFrame.opacity = info.opacity;
	ColorPickerFrame.previousValues = {r = info.r, g = info.g, b = info.b, opacity = info.opacity};
	ColorPickerFrame.cancelFunc = info.cancelFunc;
	ColorPickerFrame.extraInfo = info.extraInfo;
	-- This must come last, since it triggers a call to ColorPickerFrame.func()
	ColorPickerFrame:SetColorRGB(info.r, info.g, info.b);
	ShowUIPanel(ColorPickerFrame);
end

function BColorPicker_GetPreviousValues()
	return ColorPickerFrame.previousValues.r, ColorPickerFrame.previousValues.g, ColorPickerFrame.previousValues.b;
end
