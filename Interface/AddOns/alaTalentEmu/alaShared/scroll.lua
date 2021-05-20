﻿--[[--
	alex@0
--]]--
--[[
	scroll = ALASCR(parent, width, height, buttonHeight, funcToCreateButton(parent, index, buttonHeight), functToSetButton(button, data_index))
	scroll:SetNumValue(num)
	scroll:HandleButtonByDataIndex(index, func, ...)		func(button, ...)
	scroll:HandleButtonByRawIndex(index, func, ...)			func(button, ...)
	scroll:CallButtonFuncByRawIndex(index, func, ...)		button:func(...)
	scroll:CallButtonFuncByDataIndex(index, func, ...)		button:func(...)
	button:GetDataIndex()
]]

----------------------------------------------------------------------------------------------------
local ADDON, NS = ...;
----------------------------------------------------------------------------------------------------upvalue LUA
local type, tonumber, tostring = type, tonumber, tostring;
local getmetatable, setmetatable, rawget, rawset = getmetatable, setmetatable, rawget, rawset;
local getfenv, setfenv, pcall, xpcall, assert, error, loadstring = getfenv, setfenv, pcall, xpcall, assert, error, loadstring;
local ceil, floor, max, min = ceil, floor, max, min;
----------------------------------------------------------------------------------------------------
local _G = _G;
local _ = nil;
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------main
if alaScrollList then return; end
alaScrollList = {};
local function _error_(key, msg, ...)
	print("\124cffff0000" .. key .. "\124r", msg and "\124cffff0000" .. msg .. "\124r", ...);
end
--------------------------------------------------
--------------------------------------------------

local def_inner_size = 64;

function alaScrollList.CreateScrollFrame(parent, width, height, buttonHeight, funcToCreateButton, functToSetButton)
	width = width and max(width, def_inner_size) or def_inner_size;
	height = height and max(height, def_inner_size) or def_inner_size;

	local scrollFrame = CreateFrame("SCROLLFRAME", nil, parent, BackdropTemplateMixin ~= nil and "BackdropTemplate" or nil);
	local scrollChild = CreateFrame("FRAME", nil, scrollFrame, BackdropTemplateMixin ~= nil and "BackdropTemplate" or nil);
	local scrollBar = CreateFrame("SLIDER", nil, scrollFrame, BackdropTemplateMixin ~= nil and "BackdropTemplate" or nil);
	local buttons = {};
	local nButtonsShown = 0;
	local ofsIndex = 0;
	local numValue = -1;

	local sbWidth = 20;
	local sfWidth = width - sbWidth;

	scrollFrame:Show();
	scrollFrame:EnableMouse(true);
	scrollFrame:SetMovable(true);
	scrollFrame:RegisterForDrag("LeftButton");
	scrollFrame:SetVerticalScroll(0);
	scrollFrame:SetScrollChild(scrollChild);
	scrollFrame:SetScript("OnMouseWheel", function(self, delta, stepSize)
		stepSize = stepSize or buttonHeight;
		local minVal, maxVal = scrollBar:GetMinMaxValues();
		scrollBar:SetValue(min(maxVal, max(minVal, scrollBar:GetValue() - delta * stepSize)));
	end);
	function scrollFrame:OnSizeChanged(width, height)
		-- width = width or scrollFrame:GetWidth();
		height = height or scrollFrame:GetHeight();
		scrollChild:SetHeight(height);
		--scrollBar:SetValue(mscrollBar:GetValue());
		scrollChild:CreateScrollChildButtons();
		scrollFrame:Update();
	end
	function scrollFrame:SetButtonHeight(height)
		if buttonHeight == height then
			return;
		end
		buttonHeight = height;
		scrollFrame:OnSizeChanged();
	end
	-- scrollFrame._SetSize = scrollFrame.SetSize;
	-- function scrollFrame:SetSize(...)
	-- 	scrollFrame:_SetSize(...);
	-- 	scrollFrame:OnSizeChanged(...);
	-- end
	-- scrollFrame._SetHeight = scrollFrame.SetHeight;
	-- function scrollFrame:SetHeight(...)
	-- 	scrollFrame:_SetHeight(...);
	-- 	scrollFrame:OnSizeChange(scrollFrame:GetWidth(), ...);
	-- end
	-- scrollFrame._SetWidth = scrollFrame.SetWidth;
	-- function scrollFrame:SetWidth(...)
	-- 	scrollFrame:_SetWidth(...);
	-- 	scrollChild:SetWidth(...);
	-- end
	scrollFrame:SetScript("OnSizeChanged", scrollFrame.OnSizeChanged);
	scrollFrame:SetScript("OnDragStart", function(self, button)
			if parent:IsMovable() then
				parent:StartMoving();
			end
		end
	);
	scrollFrame:SetScript("OnDragStop", function(self, button)
			parent:StopMovingOrSizing();
		end
	);
	scrollFrame:SetScript("OnShow", function(self)
		scrollFrame:Update();
	end);
	function scrollFrame:UpdateButtons()
		if scrollFrame:IsVisible() then
			for i = 1, nButtonsShown do
				functToSetButton(buttons[i], i + ofsIndex);
			end
		end
	end
	function scrollFrame:Update()
		if scrollFrame:IsVisible() then
			local maxVal = max(numValue - nButtonsShown + 2, 0) * buttonHeight;
			local val = min(scrollBar:GetValue(), maxVal);
			scrollBar:SetMinMaxValues(0, maxVal);
			scrollBar:SetValue(val);
			if nButtonsShown - 1 > numValue then
				scrollBar:Hide();
				scrollChild:SetWidth(scrollFrame:GetWidth());
			else
				scrollBar:Show();
				scrollChild:SetWidth(scrollFrame:GetWidth() - sbWidth);
			end
			scrollFrame:UpdateButtons();
		end
	end
	function scrollFrame:SetNumValue(n)
		if n >= 0 and numValue ~= n then
			numValue = n;
			scrollFrame:Update();
		end
	end
	function scrollFrame:HandleButtonByDataIndex(index, func, ...)
		return scrollFrame:HandleButtonByRawIndex(index - ofsIndex, func, ...);
	end
	function scrollFrame:HandleButtonByRawIndex(index, func, ...)
		if index >= 1 and index <= #buttons then
			return func(buttons[index], ...);
		else
			-- _error_("HandleButtonByRawIndex", index);
			return nil;
		end
	end
	function scrollFrame:CallButtonFuncByRawIndex(index, func, ...)
		if index >= 1 and index <= #buttons then
			func = buttons[index][func];
			if func then
				return func(buttons[index], ...);
			else
				_error_("CallButtonFuncByRawIndex", index);
				return nil;
			end
		else
			-- _error_("CallButtonFuncByRawIndex", index);
			return nil;
		end
		return nil;
	end
	function scrollFrame:CallButtonFuncByDataIndex(index, func, ...)
		return scrollFrame:CallButtonFuncByRawIndex(index - ofsIndex, func, ...);
	end


	scrollChild:Show();
	scrollChild:SetPoint("LEFT", scrollFrame);
	local function GetDataIndex(self)
		return self.id + ofsIndex;
	end
	function scrollChild:CreateScrollChildButtons()
		local num = ceil(scrollChild:GetHeight() / buttonHeight) + 1;
		if num == nButtonsShown then
			return;
		end
		if not buttons[1] then
			local button = funcToCreateButton(scrollChild, 1, buttonHeight);
			button.id = 1;
			buttons[1] = button;
			button:SetPoint("TOPLEFT");
			button:SetPoint("TOPRIGHT");
			button:Show();
			nButtonsShown = 1;
			button.GetDataIndex = GetDataIndex;
		end
		if num < nButtonsShown then
			for i = num + 1, nButtonsShown do
				buttons[i]:Hide();
			end
		else
			for i = nButtonsShown + 1, num do
				local button = funcToCreateButton(scrollChild, i, buttonHeight);
				button.id = i;
				buttons[i] = button;
				button:SetPoint("TOPLEFT", buttons[i - 1], "BOTTOMLEFT", 0, 0);
				button:SetPoint("TOPRIGHT", buttons[i - 1], "BOTTOMRIGHT", 0, 0);
				buttons[i]:Show();
				button.GetDataIndex = GetDataIndex;
			end
		end
		nButtonsShown = num;
		--scrollChild:SetHeight(buttonHeight * nButtonsShown);
		scrollBar:SetStepsPerPage(nButtonsShown - 2);
	end


	scrollBar:SetWidth(sbWidth);
	scrollBar:SetPoint("TOPRIGHT", scrollFrame, "TOPRIGHT", 0, 0);
	scrollBar:SetPoint("BOTTOMRIGHT", scrollFrame, "BOTTOMRIGHT", 0, 0);
	scrollBar:Show();
	scrollBar:EnableMouse(true);
	scrollBar:SetValueStep(buttonHeight);
	scrollBar:SetMinMaxValues(0, 0);
	scrollBar:SetValue(0);
	-- local top = scrollBar:CreateTexture(nil, "ARTWORK");
	-- top:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar");
	-- top:SetSize(27, 24);
	-- top:SetTexCoord(0.0, 0.484375, 0.0, 0.10);
	-- top:SetPoint("TOPLEFT", -4, 17);
	-- local bot = scrollBar:CreateTexture(nil, "ARTWORK");
	-- bot:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar");
	-- bot:SetSize(27, 24);
	-- bot:SetTexCoord(0.515625, 1.0, 0.3140625, 0.4140625);
	-- bot:SetPoint("BOTTOMLEFT", -4, -15);
	-- local mid = scrollBar:CreateTexture(nil, "ARTWORK");
	-- mid:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar");
	-- mid:SetTexCoord(0.0, 0.484375, 0.1640625, 1.0);
	-- mid:SetPoint("TOPLEFT", top, "BOTTOMLEFT", 0, 0);
	-- mid:SetPoint("BOTTOMRIGHT", bot, "TOPRIGHT", 0, 0);
	do
		local left = scrollBar:CreateTexture(nil, "ARTWORK");
		left:SetWidth(2);
		left:SetPoint("TOPLEFT");
		left:SetPoint("BOTTOMLEFT");
		left:SetColorTexture(0.0, 0.0, 0.0, 1.0);
		local right = scrollBar:CreateTexture(nil, "ARTWORK");
		right:SetWidth(2);
		right:SetPoint("TOPRIGHT");
		right:SetPoint("BOTTOMRIGHT");
		right:SetColorTexture(0.0, 0.0, 0.0, 1.0);
		local top = scrollBar:CreateTexture(nil, "ARTWORK");
		top:SetHeight(2);
		top:SetPoint("TOPLEFT");
		top:SetPoint("TOPRIGHT");
		top:SetColorTexture(0.0, 0.0, 0.0, 1.0);
		local bot = scrollBar:CreateTexture(nil, "ARTWORK");
		bot:SetHeight(2);
		bot:SetPoint("BOTTOMLEFT");
		bot:SetPoint("BOTTOMRIGHT");
		bot:SetColorTexture(0.0, 0.0, 0.0, 1.0);
	end
	scrollBar:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob");
	local thumb = scrollBar:GetThumbTexture();
	thumb:SetSize(sbWidth - 2, 24);
	thumb:SetTexCoord(0.20, 0.80, 0.125, 0.875);
	thumb:SetColorTexture(0.25, 0.25, 0.25, 1.0);

	scrollBar:SetScript("OnValueChanged", function(self, value)
		value = value or scrollBar:GetValue();
		local index = value / buttonHeight;
		local ofs = (index - floor(index)) * buttonHeight;
		scrollFrame:SetVerticalScroll(ofs);
		ofsIndex = floor(index);
		scrollFrame:UpdateButtons();
	end);

	if width and height then
		scrollFrame:SetSize(width, height);
	end

	scrollFrame:SetNumValue(0);
	return scrollFrame;
end


_G["ALASCR"] = alaScrollList.CreateScrollFrame;

