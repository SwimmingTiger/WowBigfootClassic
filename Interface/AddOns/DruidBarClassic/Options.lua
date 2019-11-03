function DRUIDBAROptions_OnLoad()
	UIPanelWindows['DRUIDBAROptionsFrame'] = {area = 'center', pushable = 0};
end

function DRUIDBAROptionsFrame_Toggle()
	if(DRUIDBAROptionsFrame:IsVisible()) then
		DRUIDBAROptionsFrame:Hide();
	else
		DRUIDBAR_FrameSet();
		DRUIDBAROptionsFrame:Show();
	end
end

function DRUIDBAROptions_CheckWidth(self)
	if ( DRUIDBAROptionsWidthEditBox:GetText() < "1" ) then
		DRUIDBAROptionsWidthEditBox:SetText("170");
		DruidBarKey.xvar = self:GetNumber();
		DruidBarKey.tempW = DruidBarKey.xvar;
	elseif( DRUIDBAROptionsWidthEditBox:GetText() > "9999" ) then
		DRUIDBAROptionsWidthEditBox:SetText("9999");
		DruidBarKey.xvar = self:GetNumber();
		DruidBarKey.tempW = DruidBarKey.xvar;
	else
		DruidBarKey.xvar = self:GetNumber();
		DruidBarKey.tempW = DruidBarKey.xvar;
	end
end

function DRUIDBAROptions_CheckHeight(self)
	if ( DRUIDBAROptionsHeightEditBox:GetText() < "1" ) then
		DRUIDBAROptionsHeightEditBox:SetText("18");
		DruidBarKey.yvar = self:GetNumber();
		DruidBarKey.tempH = DruidBarKey.yvar;
	elseif( DRUIDBAROptionsHeightEditBox:GetText() > "999" ) then
		DRUIDBAROptionsHeightEditBox:SetText("999");
		DruidBarKey.yvar = self:GetNumber();
		DruidBarKey.tempH = DruidBarKey.yvar;
	else
		DruidBarKey.yvar = self:GetNumber();
		DruidBarKey.tempH = DruidBarKey.yvar;
	end
end

function DRUIDBAROptions_Toggle()
	if(DruidBarKey.Enabled) then
		DruidBarKey.Enabled = false;
	else
		DruidBarKey.Enabled = true;
		-- Show DruidBarUpdateFrame if hidden
		-- Incase no other event triggers the redraw, we do this now
		if not DruidBarUpdateFrame:IsVisible() then DruidBarUpdateFrame:Show(); end
	end
	DRUIDBAR_FrameSet();
end

function DRUIDBAROptions_Vis()
	if(DruidBarKey.Graphics) then
		DruidBarKey.Graphics = false;
	else
		DruidBarKey.Graphics = true;
	end
	DRUIDBAR_FrameSet();
end

function DRUIDBAROptions_Minimap()
	if(DruidBarKey.Minimap) then
		DruidBarKey.Minimap = false;
	else
		DruidBarKey.Minimap = true;
	end
	DRUIDBAR_FrameSet();
end

function DRUIDBAROptions_HideInCaster()
	if(DruidBarKey.HideInCaster) then
		DruidBarKey.HideInCaster = false;
	else
		DruidBarKey.HideInCaster = true;
	end
	DRUIDBAR_FrameSet();
end

function DRUIDBAROptions_Full()
	if(DruidBarKey.HideWhenFull) then
		DruidBarKey.HideWhenFull = false;
	else
		DruidBarKey.HideWhenFull = true;
	end
	DRUIDBAR_FrameSet();
end

function DRUIDBAROptions_Replace()
	DruidBarKey.Replace = true;
	DruidBarKey.Player = false;
	DruidBarKey.Custom = false;
	DruidBarKey.Lock = true;
	DRUIDBAR_FrameSet();
end

function DRUIDBAROptions_Player()
	DruidBarKey.Replace = false;
	DruidBarKey.Player = true;
	DruidBarKey.Custom = false;
	--Assign value that default to match player frame
	DruidBarKey.xvar = 125;
	DruidBarKey.yvar = 18;
	DruidBarKey.Lock = true;
	DRUIDBAR_FrameSet();
end

function DRUIDBAROptions_Custom()
	DruidBarKey.Custom = true;
	DruidBarKey.Replace = false;
	DruidBarKey.Player = false;
	DruidBarKey.Lock = false;
	DruidBarKey.xvar = DruidBarKey.tempW;
	DruidBarKey.yvar = DruidBarKey.tempH;
	DRUIDBAR_FrameSet();
end

function DRUIDBAROptions_Lock()
	if(DruidBarKey.Lock) then
		DruidBarKey.Lock = false;
	else
		DruidBarKey.Lock = true;
	end
	DRUIDBAR_FrameSet();
end

function DRUIDBAROptions_Text_Initialize()
	local info;
	for i = 0, 2, 1 do
		info = { };
		info.text = DRUIDBAR_OPTIONS_DROP.Text[i];
		info.func = DRUIDBAROptions_Text_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function DRUIDBAROptions_Text_OnShow()
	-- Construct dropdown
	UIDropDownMenu_Initialize(DRUIDBAROptionsTextDropDown, DRUIDBAROptions_Text_Initialize);

	-- Sets initial value
	if( DruidBarKey.Text == 0 ) then -- ORIGINAL
		UIDropDownMenu_SetSelectedID(DRUIDBAROptionsTextDropDown, 1);
	elseif( DruidBarKey.Text == 1 ) then -- NEW
		UIDropDownMenu_SetSelectedID(DRUIDBAROptionsTextDropDown, 2);
	elseif( DruidBarKey.Text == nil ) then -- NO TEXT
		UIDropDownMenu_SetSelectedID(DRUIDBAROptionsTextDropDown, 3);
	end
	UIDropDownMenu_SetWidth(DRUIDBAROptionsTextDropDown, 100);
end

function DRUIDBAROptions_Text_OnClick(self)
	i = self:GetID();
	UIDropDownMenu_SetSelectedID(DRUIDBAROptionsTextDropDown, i);

	if(i == 1) then
		DruidBarKey.Text = 0;
	elseif(i == 2) then
		DruidBarKey.Text = 1;
	elseif(i == 3) then
		DruidBarKey.Text = nil;
	end
end

function DRUIDBAROptions_Percent_Initialize()
	local info;
	for i = 0, 3, 1 do
		info = { };
		info.text = DRUIDBAR_OPTIONS_DROP.Percent[i];
		info.func = DRUIDBAROptions_Percent_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function DRUIDBAROptions_Percent_OnShow()
	UIDropDownMenu_Initialize(DRUIDBAROptionsPercentDropDown, DRUIDBAROptions_Percent_Initialize);
	if( DruidBarKey.Percent == 0 ) then
		UIDropDownMenu_SetSelectedID(DRUIDBAROptionsPercentDropDown, 1);
	elseif( DruidBarKey.Percent == 1 ) then
		UIDropDownMenu_SetSelectedID(DRUIDBAROptionsPercentDropDown, 2);
	elseif( DruidBarKey.Percent == nil ) then
		UIDropDownMenu_SetSelectedID(DRUIDBAROptionsPercentDropDown, 3);
	elseif( DruidBarKey.Percent == 2 ) then
		UIDropDownMenu_SetSelectedID(DRUIDBAROptionsPercentDropDown, 4);
	end
	UIDropDownMenu_SetWidth(DRUIDBAROptionsPercentDropDown, 100);
end

function DRUIDBAROptions_Percent_OnClick(self)
	i = self:GetID();
	UIDropDownMenu_SetSelectedID(DRUIDBAROptionsPercentDropDown, i);

	if(i == 1) then -- Numbers
		DruidBarKey.Percent = 0;
	elseif(i == 2) then -- Percent
		DruidBarKey.Percent = 1;
	elseif(i == 3) then -- Both
		DruidBarKey.Percent = nil;
	elseif(i == 4) then -- Bliz-like
		DruidBarKey.Percent = 2;
	end
end

function DRUIDBAR_FrameSet()
	-- DruidBarKey is not set, get out
	if not DruidBarKey then return end

	local gold = {1, 0.82, 0}
	local grey = {0.5, 0.5, 0.5}
	local allDisplayStyleTexts = {
		DRUIDBAROptionsVisText,DRUIDBAROptionsReplaceText, DRUIDBAROptionsPlayerText,
		DRUIDBAROptionsCustomText, DRUIDBAROptionsHideText, DRUIDBAROptionsFullText,
		DRUIDBAROptionsLockText, DRUIDBAROptionsTextDropDownText,
		DRUIDBAROptionsPercentDropDownText
	}

	-- Check temp width and temp height
	if not DruidBarKey.tempW then DruidBarKey.tempW = 0; end
	if not DruidBarKey.tempH then DruidBarKey.tempH = 0; end

	-- Toggle Checkboxes/Buttons
	DRUIDBAROptionsToggle:SetChecked(DruidBarKey.Enabled);
	DRUIDBAROptionsVis:SetChecked(DruidBarKey.Graphics);
	DRUIDBAROptionsMinimap:SetChecked(DruidBarKey.Minimap);
	DRUIDBAROptionsReplace:SetChecked(DruidBarKey.Replace);
	DRUIDBAROptionsPlayer:SetChecked(DruidBarKey.Player);
	DRUIDBAROptionsCustom:SetChecked(DruidBarKey.Custom);
	DRUIDBAROptionsLock:SetChecked(DruidBarKey.Lock);
	DRUIDBAROptionsHide:SetChecked(DruidBarKey.HideInCaster);
	DRUIDBAROptionsFull:SetChecked(DruidBarKey.HideWhenFull);
	-- Assign Text Box Values
	DRUIDBAROptionsWidthEditBox:SetText(DruidBarKey.tempW);
	DRUIDBAROptionsHeightEditBox:SetText(DruidBarKey.tempH);

	-- Addon Enabled and Graphics on
	if(DruidBarKey.Enabled and DruidBarKey.Graphics) then
		DRUIDBAROptionsVis:Enable();
		DRUIDBAROptionsReplace:Enable();
		DRUIDBAROptionsPlayer:Enable();
		DRUIDBAROptionsCustom:Enable();
		DRUIDBAROptionsHide:Enable();
		DRUIDBAROptionsFull:Enable();
		DRUIDBAROptionsLock:Enable();
		SetTextColorFor(allDisplayStyleTexts, gold);

	-- Addon Enabled and Graphics off
	elseif DruidBarKey.Enabled and not DruidBarKey.Graphics then
		DRUIDBAROptionsReplace:Disable();
		DRUIDBAROptionsPlayer:Disable();
		DRUIDBAROptionsCustom:Disable();
		DRUIDBAROptionsHide:Disable();
		DRUIDBAROptionsFull:Disable();
		DRUIDBAROptionsLock:Disable();
		SetTextColorFor(allDisplayStyleTexts, grey);
		SetTextColorFor({DRUIDBAROptionsVisText}, gold);

	-- Addon Disabled
	elseif not DruidBarKey.Enabled then
		DRUIDBAROptionsVis:Disable();
		DRUIDBAROptionsReplace:Disable();
		DRUIDBAROptionsPlayer:Disable();
		DRUIDBAROptionsCustom:Disable();
		DRUIDBAROptionsHide:Disable();
		DRUIDBAROptionsFull:Disable();
		DRUIDBAROptionsLock:Disable();
		SetTextColorFor(allDisplayStyleTexts, grey);
	end

	-- Player or Replace is selected
	if(DruidBarKey.Player == true or DruidBarKey.Replace == true) then
		DRUIDBAROptionsLock:Disable();
		DRUIDBAROptionsWidthEditBox:Disable();
		DRUIDBAROptionsHeightEditBox:Disable();
		SetTextColorFor({DRUIDBAROptionsLockText, DRUIDBAROptionsWidthText, DRUIDBAROptionsHeightText}, grey);

	-- Custom is selected
	else
		DRUIDBAROptionsLock:Enable();
		DRUIDBAROptionsWidthEditBox:Enable();
		DRUIDBAROptionsHeightEditBox:Enable();
		SetTextColorFor({DRUIDBAROptionsLockText, DRUIDBAROptionsWidthText, DRUIDBAROptionsHeightText}, gold);
	end
end

function SetTextColorFor(objects, color)
	for k, v in pairs (objects) do
	  v:SetTextColor(unpack(color))
	end
end

function DRUIDBAROptions_GetColor(self)
	if not DruidBarKey then return end
	local info;
	info = self;
	info.hasColorSwatch = 1;
	info.r = DruidBarKey.color[1];
	info.g = DruidBarKey.color[2];
	info.b = DruidBarKey.color[3];
	info.notCheckable = 1;
	info.opacity = 1.0 - DruidBarKey.color[4];
	info.swatchFunc = function() DruidBarKey.color[1], DruidBarKey.color[2], DruidBarKey.color[3] = ColorPickerFrame:GetColorRGB(); end
	info.func = UIDropDownMenuButton_OpenColorPicker;
	info.hasOpacity = 0;
	info.opacityFunc = function() DruidBarKey.color[4] = 1.0 - OpacitySliderFrame:GetValue(); end;
	info.cancelFunc = function()    DruidBarKey.color[1] = ColorPickerFrame.previousValues.r;
									DruidBarKey.color[2] = ColorPickerFrame.previousValues.g;
									DruidBarKey.color[3] = ColorPickerFrame.previousValues.b;
									DruidBarKey.color[4] = 1.0 - ColorPickerFrame.previousValues.opacity; end;
	getglobal(self:GetName().."_SwatchBg"):SetVertexColor(DruidBarKey.color[1], DruidBarKey.color[2], DruidBarKey.color[3]);
end

function DRUIDBAROptions_GetBGColor(self)
	if not DruidBarKey then return end
	local info;
	info = self;
	info.hasColorSwatch = 1;
	info.r = DruidBarKey.bgcolor[1];
	info.g = DruidBarKey.bgcolor[2];
	info.b = DruidBarKey.bgcolor[3];
	info.notCheckable = 1;
	info.opacity = 1.0 - DruidBarKey.bgcolor[4];
	info.swatchFunc = function() DruidBarKey.bgcolor[1], DruidBarKey.bgcolor[2], DruidBarKey.bgcolor[3] = ColorPickerFrame:GetColorRGB(); end
	info.func = UIDropDownMenuButton_OpenColorPicker;
	info.hasOpacity = 0;
	info.opacityFunc = function() DruidBarKey.bgcolor[4] = 1.0 - OpacitySliderFrame:GetValue(); end;
	info.cancelFunc = function()    DruidBarKey.bgcolor[1] = ColorPickerFrame.previousValues.r;
									DruidBarKey.bgcolor[2] = ColorPickerFrame.previousValues.g;
									DruidBarKey.bgcolor[3] = ColorPickerFrame.previousValues.b;
									DruidBarKey.bgcolor[4] = 1.0 - ColorPickerFrame.previousValues.opacity; end;
	getglobal(self:GetName().."_SwatchBg"):SetVertexColor(DruidBarKey.bgcolor[1], DruidBarKey.bgcolor[2], DruidBarKey.bgcolor[3]);
end

function DRUIDBAROptions_GetBorderColor(self)
	if not DruidBarKey then return end
	local info;
	info = self;
	info.hasColorSwatch = 1;
	info.r = DruidBarKey.bordercolor[1];
	info.g = DruidBarKey.bordercolor[2];
	info.b = DruidBarKey.bordercolor[3];
	info.notCheckable = 1;
	info.opacity = 1.0 - DruidBarKey.bordercolor[4];
	info.swatchFunc = function() DruidBarKey.bordercolor[1], DruidBarKey.bordercolor[2], DruidBarKey.bordercolor[3] = ColorPickerFrame:GetColorRGB(); end
	info.func = UIDropDownMenuButton_OpenColorPicker;
	info.hasOpacity = 0;
	info.opacityFunc = function() DruidBarKey.bordercolor[4] = 1.0 - OpacitySliderFrame:GetValue(); end;
	info.cancelFunc = function()    DruidBarKey.bordercolor[1] = ColorPickerFrame.previousValues.r;
									DruidBarKey.bordercolor[2] = ColorPickerFrame.previousValues.g;
									DruidBarKey.bordercolor[3] = ColorPickerFrame.previousValues.b;
									DruidBarKey.bordercolor[4] = 1.0 - ColorPickerFrame.previousValues.opacity; end;
	getglobal(self:GetName().."_SwatchBg"):SetVertexColor(DruidBarKey.bordercolor[1], DruidBarKey.bordercolor[2], DruidBarKey.bordercolor[3]);
end
