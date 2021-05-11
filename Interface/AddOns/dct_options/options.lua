--The Options Page variables and functions

DCT_EventC = 1;
DCT_CheckC = 1;
DCT_SliderC = 1;
DCT_ColorPickerExC = 1;
DCT_ListFrameC = 1;

DCT_OptionCurButton = nil

DCT_previewBak = nil


--Set color functions

--主菜单列表
DCT_ButtonList = {
}

DCT_SavePreFixesList = {

}
--用于等级其他Mod的Reset函数
DCT_OptionsResetFuncList = {
}


DCT_OptionInitOK = false

function DCT_OptionsGetSaveP(name)
	local f = string.find(name,"_")
	local prename = string.sub(name,1,f - 1)
	local p = DCT_Player
	if DCT_SavePreFixesList[prename] then
		p = getglobal(DCT_SavePreFixesList[prename])
	end
	return p
end

function DCTOP_Init()
	if DCT_OptionInitOK then return;end
	if not DCTOP_SAVE or type(DCTOP_SAVE) ~= "table" then
		DCTOP_SAVE = {};
	end
	local k,v
	for k,v in pairs(DCTOP_SAVE) do
		if not v["DCT_SaveVer"] or v["DCT_SaveVer"] < DCT_DEFAULT_CFG["DCT_SaveVer"] then
			DCT_Debug("Delete profile:"..k)
			DCTOP_SAVE[k] = nil
		end
	end
	DCT_OptionInitOK = true
end

function DCT_OptionsRegisterResetFunc(modname,func)
	if not DCT_OptionsResetFuncList[modname] then
		DCT_OptionsResetFuncList[modname] = func
	end
end

function DCT_OptionsResetFuncRun()
	local k,v
	for k,v in pairs(DCT_OptionsResetFuncList) do
		v()
	end
end

function DCT_OptionsButtonClick(bp)
	DCT_HideAllBG()
	DCT_OptionsFrame_Clear()
	if bp.frame then bp.frame:Show();end
	if bp.funcOnClick then bp.funcOnClick();end
	DCT_Options_Title_Text:SetText( (getglobal(bp:GetName().."_Text")):GetText() )
	DCT_OptionCurButton	= bp
	DCT_ShowBG(1,180,-50,bp.bgw,bp.bgh)
	if bp.exbgw then
		local c = table.getn(bp.exbgw)
		local i
		for i = 1,c do
			DCT_ShowBG(i + 1,180 + bp.exbgx[i],-50 + bp.exbgy[i],bp.exbgw[i],bp.exbgh[i])
		end
	end
end
function DCT_OptionsGetRegisterButton(text)
	return DCT_ButtonList[text]
end
--向主菜单添加一个按钮
function DCT_OptionsRegisterButton(text,frame,funcOnClick,y,bgw,bgh)
	if DCT_ButtonList[text] then return;end

	local maxy = 0
	local k,v
	for k,v in pairs(DCT_ButtonList) do
		if v.y > maxy then maxy = v.y;end
		if v.y == y then
			y = -1
		end
	end
	if y == -1 then y = maxy + 1;end
	DCT_ButtonList[text] = {}

	local obj = CreateFrame("Button", "DCT_RegisterB"..y, DCT_Options, "DCT_OptionsButtonTemplate2")
	obj:SetPoint("TOPLEFT", "DCT_Options", "TOPLEFT", 25, -60 - y * 20)
	--obj:SetText(text)
	getglobal(obj:GetName().."_Text"):SetText(text)
	obj.funcOnClick = funcOnClick
	obj.frame = frame
	if bgw then
		obj.bgw = bgw
	else
		obj.bgw = 530
	end
	if bgh then
		obj.bgh = bgh
	else
		obj.bgh = 465
	end
	--obj:SetScript("OnClick", function() Reset() end)
	DCT_ButtonList[text].obj = obj
	DCT_ButtonList[text].frame = frame
	DCT_ButtonList[text].y = y
end

--向已添加的按钮追加BG框体
function DCT_OptionsRegisterButtonExBG(text,bgx1,bgy1,bgw1,bgh1,bgx2,bgy2,bgw2,bgh2,bgx3,bgy3,bgw3,bgh3,bgx4,bgy4,bgw4,bgh4)
	if not DCT_ButtonList[text] then return;end
	local obj = DCT_ButtonList[text].obj
	obj.exbgx = {bgx1,bgx2,bgx3,bgx4}
	obj.exbgy = {bgy1,bgy2,bgy3,bgy4}
	obj.exbgw = {bgw1,bgw2,bgw3,bgw4}
	obj.exbgh = {bgh1,bgh2,bgh3,bgh4}
end

function DCT_OptionsEventButtonOnClick()
	DCT_Opex_SetSaveP(DCT_Player)
	DCT_OptionsFrame_Load(DCT_OptionCfg_Event)
end

function DCT_OptionsEventButtonOnClick2()
	DCT_Opex_SetSaveP(DCT_Player)
	DCT_OptionsFrame_Load(DCT_OptionCfg_Event2)
end

function DCT_OptionsOnLoad(self)
	DCT_OptionsRegisterButton(DCT_EVENT_OPTION,nil,DCT_OptionsEventButtonOnClick,0)
	DCT_OptionsRegisterButton(DCT_EVENT2_OPTION,nil,DCT_OptionsEventButtonOnClick2,1)
	DCT_OptionCurButton = DCT_OptionsGetRegisterButton(DCT_EVENT_OPTION).obj

	self:RegisterEvent("VARIABLES_LOADED")
	self:RegisterEvent("ADDON_LOADED")
end










--==================================================================================================================================

function DCT_ConfigSlider(obj,curValue,paramP)
	local objname = obj:GetName()
	if paramP.title then
		obj.titlebak = paramP.title
		getglobal(objname.."Text"):SetText(obj.titlebak)
	end
	if paramP.tooltipText then	obj.tooltipText = paramP.tooltipText;end

	obj:SetMinMaxValues(paramP.minValue, paramP.maxValue)
	obj:SetValueStep(paramP.valueStep)

	if paramP.minText then
		getglobal(objname.."Low"):SetText(paramP.minText)
	else
		getglobal(objname.."Low"):SetText(paramP.minValue)
	end
	if paramP.maxText then
		getglobal(objname.."High"):SetText(paramP.maxText)
	else
		getglobal(objname.."High"):SetText(paramP.maxValue)
	end


	if curValue then
		getglobal(objname.."EditBox"):SetText(curValue)
		obj.missOnValue = true
		obj:SetValue(curValue)
	else
		getglobal(objname.."EditBox"):SetText("")
	end
end

function DCT_ConfigColorPicker(objname,saveP)
	if saveP == nil then saveP = DCT_Player;end
	local frame,swatch,sRed,sGreen,sBlue,sColor;

	frame = getglobal(objname);
	swatch = getglobal(objname.."_ColorSwatchNormalTexture");

	sColor = saveP[frame.saveName].color
	sRed = sColor[1]
	sGreen = sColor[2]
	sBlue = sColor[3]

	frame.r = sRed;
	frame.g = sGreen;
	frame.b = sBlue;

	frame.swatchFunc = function(x) DCT_OptionsFrame_SetColor(frame:GetName()) end;
	frame.cancelFunc = function(x) DCT_OptionsFrame_CancelColor(frame:GetName(),x) end;
	swatch:SetVertexColor(sRed,sGreen,sBlue);
end
function DCT_RefreshColorPickerEx(objname)
	DCT_ConfigColorPicker(objname);
end

function DCT_RefreshEventFrames(objname,saveP)
	if saveP == nil then saveP = DCT_Player;end
	local button = getglobal(objname.."_Button_Text")
	local saveName = getglobal(objname).saveName
	local val = saveP[saveName].frame

	if val > DCT_Ani_MaxFrame then val = DCT_Ani_MaxFrame;end
	if val < 0 then val = 0;end

	getglobal(objname).curFrame = val

	if val == 0 or (val > 0 and not DCT_Ani_FrameIsActive(val)) then
		getglobal(objname.."_Text"):SetTextColor(0.4,0.4,0.4)
		button:SetText(DCT_GetEventIDString(val + 1))
	else
		getglobal(objname.."_Text"):SetTextColor(1.0,0.82,0)
		button:SetText(DCT_GetEventIDString(val + 1)..DCT_Opani_AniTypeSimpleConfig[DCT_Get("DCT_FRAME_CONFIG")[val].aniType])
	end

	if saveP[saveName].fEn or saveP[saveName].fCh or saveP[saveName].fSizeEn or saveP[saveName].fSizeCh or saveP[saveName].fEff then
		getglobal(objname.."_ButtonEx_Text"):SetText("A")
		getglobal(objname.."_ButtonEx_Text"):SetTextColor(1,1,0)
	else
		getglobal(objname.."_ButtonEx_Text"):SetText("e")
		getglobal(objname.."_ButtonEx_Text"):SetTextColor(1,1,1)
	end

	--Color Swatch
	DCT_ConfigColorPicker(objname,saveP);
end



function DCT_OptionsFrame_Clear()
	local id = 1;
	DCT_EventC = 1;
	DCT_CheckC = 1;
	DCT_SliderC = 1;
	DCT_ColorPickerExC = 1;
	DCT_ListFrameC = 1;

	for id = 1,30 do
		local obj = getglobal("DCT_Event"..id);
		obj:Hide();
	end
	for id = 1,20 do
		local obj = getglobal("DCT_Check"..id);
		obj:Hide();
	end
	for id = 1,20 do
		getglobal("DCT_ColorPickerEx"..id):Hide()
	end
end

function DCT_OptionsFrame_Load(cfg,saveP)
	if saveP == nil then saveP = DCT_Player;end
	local key,value,size
	DCT_EventC = 1
	if cfg.EventFrames then
		for key, value in pairs(cfg.EventFrames) do
			local objname = "DCT_Event"..DCT_EventC;
			local obj = getglobal(objname);
			getglobal(objname.."_Button").Func = DCT_Event_Button_Click
			getglobal(objname).tooltipText = value.tooltipText;
			obj.saveName = key;
			obj:SetPoint("TOPLEFT", "DCT_Options", "TOPLEFT", value.x, value.y);
			getglobal(objname.."_Text"):SetText(value.title);
			DCT_RefreshEventFrames(objname,saveP);
			DCT_EventC = DCT_EventC + 1;
			obj:Show();
		end
	end
	-- Set CheckButton states
	DCT_CheckC = 1
	if cfg.CheckButtons then
		for key, value in pairs(cfg.CheckButtons) do
			local objname = "DCT_Check"..DCT_CheckC;
			local obj = getglobal(objname)

			size = 30
			if value.size then size = value.size;end
			obj:SetWidth(size)
			obj:SetHeight(size * 1.1)

			obj.tooltipText = value.tooltipText
			obj.saveName = key
			obj:SetPoint("TOPLEFT", "DCT_Options", "TOPLEFT", value.x, value.y)
			getglobal(objname.."Text"):SetText(value.title)
			OptionsFrame_EnableCheckBox(obj);
			if ( saveP[obj.saveName] == 1 ) then
				checked = 1;
				obj:SetChecked(true);
			else
				obj:SetChecked(false);
			end

			DCT_CheckC = DCT_CheckC + 1;
			obj:Show();
		end
	end

	DCT_ColorPickerExC = 1
	if cfg.ColorPickerExs then
		for key, value in pairs(cfg.ColorPickerExs) do
			local objname = "DCT_ColorPickerEx"..DCT_ColorPickerExC;
			local obj = getglobal(objname)

			local colorObj = getglobal(objname.."_ColorSwatch")
			local colorBGObj = getglobal(objname.."_ColorSwatch_SwatchBg")
			size = 18
			if value.size then size = value.size;end
			colorObj:SetWidth(size)
			colorObj:SetHeight(size)
			colorBGObj:SetWidth(size - 2)
			colorBGObj:SetHeight(size - 2)

			if value.tooltipText then obj.tooltipText = value.tooltipText;end
			obj.saveName = key;
			obj:SetPoint("TOPLEFT", "DCT_Options", "TOPLEFT", value.x, value.y);

			if value.title then getglobal(objname.."_Text"):SetText(value.title);end
			DCT_ConfigColorPicker(objname);
			DCT_ColorPickerExC = DCT_ColorPickerExC + 1;
			obj:Show();
		end
	end

end
--Called when option page loads
function DCT_OptionsFrame_OnShow(self)
	--support for EU_Fonts
	DCT_HideAllBG();
	DCT_ShowBG(1,180,-50,490,360);
	DCT_OptionsFrame_Clear();
	DCT_OptionsButtonClick(DCT_OptionCurButton)
end

function DCT_SetColor(name,r,g,b)
	local p = DCT_OptionsGetSaveP(name)

	p[name].color[1] = r
	p[name].color[2] = g
	p[name].color[3] = b
end

--例如DCT_RegisterSavePreFixes("DCTD","DCTD_DB")
function DCT_RegisterSavePreFixes(pre,saveName)
	if not DCT_SavePreFixesList[pre] then
		DCT_SavePreFixesList[pre] = saveName
	end
end

function DCT_OptionsCheckButtonOnClick(name,checkboxname)
	local button = getglobal(checkboxname);
	local p = DCT_OptionsGetSaveP(button.saveName)
	local val;
	if button:GetChecked() then val = 1;else val = 0;end
	if button.saveName then
		p[button.saveName] = val
	end
end

----------------------
--Sets the colors of the config from a color swatch
function DCT_OptionsFrame_SetColor(name)
	local r,g,b = ColorPickerFrame:GetColorRGB();
	local swatch,frame;
	swatch = getglobal(name.."_ColorSwatchNormalTexture");
	frame = getglobal(name);
	swatch:SetVertexColor(r,g,b);
	frame.r = r;
	frame.g = g;
	frame.b = b;
	--update back to config
	DCT_SetColor(frame.saveName, r, g, b)
end

----------------------
-- Cancels the color selection
function DCT_OptionsFrame_CancelColor(name, prev)
	local r = prev.r;
	local g = prev.g;
	local b = prev.b;
	local swatch, frame;
	swatch = getglobal(name.."_ColorSwatchNormalTexture");
	frame = getglobal(name);
	swatch:SetVertexColor(r, g, b);
	frame.r = r;
	frame.g = g;
	frame.b = b;
	-- Update back to config
	DCT_SetColor(frame.saveName, r, g, b)
end

function DCT_Event_Button_Click(name,button)
	for name in string.gmatch( name, "(.+)_Button" ) do
		local saveName = getglobal(name).saveName
		local p = DCT_OptionsGetSaveP(saveName)
		local val = p[saveName].frame;
		local ne
		if button == "LeftButton" then
			ne = DCT_Ani_FrameGetNextActiveFID(val)
			if val > ne then
				val = 0
			else
				val = ne
			end
		else
			if val <= 0 then
				val = DCT_Ani_FrameGetLastActiveFID()
			else
				ne = DCT_Ani_FrameGetPrevActiveFID(val)
				if val <= ne then
					val = 0
				else
					val = ne
				end
			end
		end


		local txt = DCT_GetEventIDString(val + 1)
		if val > 0 then
			txt = txt..DCT_Opani_AniTypeSimpleConfig[DCT_Get("DCT_FRAME_CONFIG")[val].aniType]
		end
		getglobal(name.."_Button_Text"):SetText(txt);

		p[saveName].frame = val

		DCT_RefreshEventFrames(name,p);

		if DCT_previewBak then
			if DCT_previewBak.active then DCT_previewBak.active = false;end
		end
		DCT_SetPreviewParam()
		DCT_previewBak = DCT_AddText(saveName,1,false,p)
	end
end

function DCTSlider_EditBoxEnterPressed(self, newVal)
	local tmin,tmax = (self:GetParent()):GetMinMaxValues();
	if newVal < tmin then newVal = tmin;end
	if newVal > tmax then newVal = tmax;end
	(self:GetParent()):SetValue(newVal);
	self:ClearFocus();
end

----------------------
--Open the color selector using show/hide
function DCT_OpenColorPicker(self,button)
	CloseMenus();
	if ( not button ) then
		button = self;
	end
	ColorPickerFrame.func = button.swatchFunc;
	ColorPickerFrame:SetColorRGB(button.r, button.g, button.b);
	ColorPickerFrame.previousValues = {r = button.r, g = button.g, b = button.b, opacity = button.opacity};
	ColorPickerFrame.cancelFunc = button.cancelFunc;
	ColorPickerFrame:Show();
end

function DCT_MouseUp(self)
	if ( self.isMoving ) then
		self:StopMovingOrSizing();
		self.isMoving = false;
	end
end

function DCT_MouseDown(self, button)
	if button == "LeftButton" then
		self:StartMoving();
		self.isMoving = true;
	end
end


function DCT_HideAllBG()
	DCT_Options_BG1:Hide();
	DCT_Options_BG2:Hide();
	DCT_Options_BG3:Hide();
	DCT_Options_BG4:Hide();
	DCT_Options_BG5:Hide();
	for key,val in pairs(DCT_ButtonList) do
		if val.frame then
			val.frame:Hide()
		end
	end

end

function DCT_ShowBG(id,x,y,w,h)
	local obj = getglobal("DCT_Options_BG"..id);
	obj:Show();
	obj:SetPoint("TOPLEFT","DCT_Options","TOPLEFT",x,y);
	obj:SetWidth(w);
	obj:SetHeight(h);
end

function DCT_GetEventIDString(id)
	if id <= 1 then return "Off";end
	return tostring(id - 1)
end

function DCT_Options_OnEvent(self, event, ...)
	local arg1 = ...;
	if event == "VARIABLES_LOADED" or ( event == "ADDON_LOADED" and string.lower(arg1) == "dct_options" ) then
		DCTOP_Init();
	end
end

