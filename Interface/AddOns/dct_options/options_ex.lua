--The Options Page variables and functions


--Set color functions

local DCT_Spec_default = {
	["fEn"] = 2,
	["fCh"] = 1,
	["fSizeEn"] = 0,
	["fSizeCh"] = 0,
	["fEff"] = 2,
}

local DCT_opex_saveP
DCT_CurrentEditEventName = nil

dct_opex_preview1 = nil
dct_opex_preview2 = nil

DCT_Opex_Help2 = {
	["DCT_SHOWHIT"] = {"am","bt","ba","oi"},
	["DCT_SHOWSPELL"] = {"am","ic","sn","ss","bt","ba","oi","cs"},
	["DCT_SHOWHITCRIT"] = {"am","bt","ba","oi"},
	["DCT_SHOWSPELLCRIT"] = {"am","ic","sn","ss","bt","ba","oi","cs"},
	["DCT_SHOWPERIODIC"] = {"am","ic","sn","ss","bt","ba","oi","cs"},
	["DCT_SHOWHITCRIT"] = {"am","bt","ba","oi"},
	["DCT_SHOWSHIELD"] = {"am","ic","sn","ss","oi"},
	["DCT_SHOWDRAIN"] = {"am","pt","sn","ic","oi"},
	["DCT_SHOWHEAL"] = {"am","oh","ic","sn","oi"},
	["DCT_SHOWPERIODICHEAL"] = {"am","oh","ic","sn","oi"},
	["DCT_SHOWACTIVE"] = {"ic","sn"},
	["DCT_SHOWFACTION"] = {"am"},
	["DCT_SHOWHONOR"] = {"am"},
	["DCT_SHOWCOMBAT"] = {},
	["DCT_SHOWCOMBATLEAVE"] = {"ti"},
	["DCT_SHOWCP"] = {"am"},
	["DCT_SHOWBUFF"] = {"ic","sn","oi"},
	["DCT_SHOWDEBUFF"] = {"ic","sn"},
	["DCT_SHOWBUFFFADE"] = {"ic","sn","oi"},
	["DCT_SHOWDEBUFFFADE"] = {"ic","sn"},
	["DCT_SHOWBUFFDOSE"] = {"ic","am","sn","oi"},
	["DCT_SHOWDEBUFFDOSE"] = {"ic","am","sn","oi"},
	["DCT_SHOWSPECBUFF"] = {"ic","sn","oi"},
	["DCT_SHOWSPECBUFFFADE"] = {"ic","sn"},
	["DCT_SHOWSPECDEBUFFFADE"] = {"ic","sn"},
	["DCT_SHOWPOWER"] = {"am","pt","sn","ic","oi"},	
	["DCT_SHOWDISPELLED"] = {"sn","ic","oi"},
	["DCT_SHOWLOWHEALTH"] = {"hp"},
	["DCT_SHOWLOWMANA"] = {"mp"},
	["DCT_SHOWENVIRONMENTAL"] = {"am","et"},
	["DCT_SHOWEXTRAATTACKS"] = {"am","ic","sn"},
	["DCT_SHOWSPELLSUCCESS"] = {"ic","sn"},		
	["DCT_SHOWSPELLFAILED"] = {"ic","sn"},
	["DCT_SHOWSPECTARGETBUFF"] = {"ic","sn","oi"},
	["DCT_SHOWSPECTARGETDEBUFF"] = {"ic","sn","oi"},
	["DCT_SHOWSPECTARGETBUFFFADE"] = {"ic","sn","oi"},
	["DCT_SHOWSPECTARGETDEBUFFFADE"] = {"ic","sn","oi"},
	["DCT_SHOWCOOLDOWN"] = {"ic","sn"},
	["DCT_SHOWKILLBLOW"] = {"di"},

	["DCT_SHOWDODGE"] = {"ms","ic","sn","oi","cs"},
	["DCT_SHOWABSORB"] = {"ms","ic","sn","oi","cs"},
	["DCT_SHOWRESIST"] = {"ms","ic","sn","oi","cs"},
	["DCT_SHOWPARRY"] = {"ms","ic","sn","oi","cs"},
	["DCT_SHOWMISS"] = {"ms","ic","sn","oi","cs"},
	["DCT_SHOWBLOCK"] = {"ms","ic","sn","oi","cs"},
	["DCT_SHOWREFLECT"] = {"ms","ic","sn","oi","cs"},
	["DCT_SHOWDEFLECT"] = {"ms","ic","sn","oi","cs"},
	["DCT_SHOWIMMUNE"] = {"ms","ic","sn","oi","cs"},
	["DCT_SHOWEVADE"] = {"ms","ic","sn","oi","cs"},
}

function DCT_SetPreviewParam()
	dct_amount = DCT_Opex_PreviewSet["am"]
	dct_icon = DCT_Opex_PreviewSet["ic"]
	dct_spellName = DCT_Opex_PreviewSet["sn"]
	dct_patch_block = DCT_Opex_PreviewSet["bt"]
	dct_missType = DCT_Opex_PreviewSet["ms"]
	dct_powerType = DCT_Opex_PreviewSet["pt"]
	dct_spellSchool = DCT_Opex_PreviewSet["ss"]
	dct_environmentalType = DCT_Opex_PreviewSet["et"]
	dct_auraType = DCT_Opex_PreviewSet["at"]
	dct_patch_oi  = DCT_Opex_PreviewSet["oi"]
	dct_patch_oh = DCT_Opex_PreviewSet["oh"]
	dct_patch_em  = DCT_Opex_PreviewSet["em"]
	dct_patch_di  = DCT_Opex_PreviewSet["di"]
	dct_combatTime = GetTime()
end

function DCT_PreviewUpdata(arg1)
	local param = DCT_opex_saveP[DCT_CurrentEditEventName]
	
	local fParam = DCT_Get("DCT_FRAME_CONFIG")[param.frame]
	local fEn,fCh,fSizeEn,fSizeCh,fEff
	
	if param.fEn then	fEn = param.fEn; else fEn = fParam.fEn;end
	if param.fCh then	fCh = param.fCh; else fCh = fParam.fCh;end
	if param.fSizeEn then	fSizeEn = fParam.fSizeEn + param.fSizeEn; else fSizeEn = fParam.fSizeEn;end
	if param.fSizeCh then	fSizeCh = fParam.fSizeCh + param.fSizeCh; else fSizeCh = fParam.fSizeCh;end
	if param.fEff then fEff = param.fEff; else fEff = fParam.fEff;end
	
	
	if dct_opex_preview1 and param.show[1] then
		DCT_Ani_ObjSetText(dct_opex_preview1,DCT_Format(DCTEventShowEdit1:GetText(),param.colorEx),fEn,fCh,fSizeEn,fSizeCh,fEff,param.color)
		if dct_opex_preview2 and param.show[2] then
			DCT_Ani_ObjPos(dct_opex_preview1,0,305)
			
			DCT_Ani_ObjSetText(dct_opex_preview2,DCT_Format(DCTEventShowEdit2:GetText(),param.colorEx),fEn,fCh,fSizeEn,fSizeCh,fEff,param.color)
			DCT_Ani_ObjPos(dct_opex_preview2,0,280)
			DCT_Ani_ObjAlpha(dct_opex_preview2,1)
		else
			DCT_Ani_ObjPos(dct_opex_preview1,0,290)
			DCT_Ani_ObjAlpha(dct_opex_preview2,0)
		end
		DCT_Ani_ObjAlpha(dct_opex_preview1,1)
	end
end

function DCT_Opex_SetSaveP(saveP)
	DCT_opex_saveP = saveP
end

function DCT_Opex_RefreshSpecSlider()
	for key, val in pairs(DCT_Opex_Config.Sliders) do
		objname = "DCTEventOptionsExtra".."Slider_"..key
		obj = getglobal(objname)
		if obj then
			if key == "per" and DCT_opex_saveP[DCT_CurrentEditEventName][key] then
				DCTEventOptionsExtraSlider_per:Show()
				if DCT_CurrentEditEventName == "DCT_SHOWLOWHEALTH" or DCT_CurrentEditEventName == "DCT_SHOWLOWMANA" then
					val = DCT_Opex_Low_path
				end
				if DCT_CurrentEditEventName == "DCT_SHOWBUFFFADE" or DCT_CurrentEditEventName == "DCT_SHOWSPECBUFFFADE" then
					val = DCT_Opex_bufffade_path
				end
			end
			
			if DCT_opex_saveP[DCT_CurrentEditEventName][key] then
				DCT_ConfigSlider(obj,DCT_opex_saveP[DCT_CurrentEditEventName][key],val)
			else
				DCT_ConfigSlider(obj,nil,val)
			end
		end
	end
end

function DCT_Opex_OnShow()
	--DCT_opex_saveP[DCT_CurrentEditEventName] = DCT_opex_saveP[DCT_CurrentEditEventName]
	local key,val
	DCT_SetPreviewParam()
	dct_opex_preview1 = DCT_Ani_ObjGet()
	dct_opex_preview2 = DCT_Ani_ObjGet()	

	DCTEventShowEdit1.EnterPressFunc = DCT_Opex_EditPress
	DCTEventShowEdit2.EnterPressFunc = DCT_Opex_EditPress
	DCTEventShowEdit1.TextChangedFunc = DCT_PreviewUpdata
	DCTEventShowEdit2.TextChangedFunc = DCT_PreviewUpdata
	DCTEventSoundEdit.EnterPressFunc = DCT_Opex_SoundEditPress
	DCTEventShowEdit1:SetWidth(360)
	DCTEventShowEdit2:SetWidth(360)

	DCTEventSoundEdit:SetWidth(195)
	DCTEventSoundEdit:Hide()
	
	if DCT_CurrentEditEventName then
		local tmp = DCT_opex_saveP[DCT_CurrentEditEventName]
		local c = table.getn(tmp.show)
		local i,cp
		--sound
		if tmp.sound then
			DCTEventSoundEdit:SetText(tmp.sound)
			DCTEventSoundEdit:Show()
			DCTEventSoundEdit:SetCursorPosition(1)
			DCTEventSoundEditLabel:SetText(DCT_Opex_SoundEditTitle)
		end
		for i = 1,2 do
			getglobal("DCTEventShowEdit"..i):Hide()
		end
		i = 1
		for i = 1,c do
			if c > 1 then
				local txt
				if DCT_Opex_MulitEditLabel[DCT_CurrentEditEventName] then
					txt = DCT_Opex_MulitEditLabel[DCT_CurrentEditEventName][i]
				else
					txt = DCT_Opex_MulitEditLabel["DEFAULT"][i]
				end
				getglobal("DCTEventShowEdit"..i.."Label"):SetText(txt..":   "..DCT_Opex_EditHelp)
			else
				getglobal("DCTEventShowEdit"..i.."Label"):SetText(DCT_Opex_EditHelp)
			end
			getglobal("DCTEventShowEdit"..i):SetText(tmp.show[i])
			getglobal("DCTEventShowEdit"..i):SetCursorPosition(1)
			getglobal("DCTEventShowEdit"..i):Show()
		end
		i = 1
		for i = 1,2 do
			cp = getglobal("DCTEventOptionsExtra_ColorPickerEx"..i)
			cp.swatchFunc = function(x) DCT_Opex_SetColor(getglobal("DCTEventOptionsExtra_ColorPickerEx"..i):GetName()) end;
			cp.cancelFunc = function(x) DCT_Open_CancelColor(getglobal("DCTEventOptionsExtra_ColorPickerEx"..i):GetName(),x) end;
			cp.r = tmp.colorEx[i][1]
			cp.g = tmp.colorEx[i][2]
			cp.b = tmp.colorEx[i][3]
			getglobal("DCTEventOptionsExtra_ColorPickerEx"..i.."_Text"):SetText(DCT_TEXT_OPEX_COLOR[i])
			getglobal("DCTEventOptionsExtra_ColorPickerEx"..i.."_ColorSwatchNormalTexture"):SetVertexColor(cp.r,cp.g,cp.b)
		end		
	end
	DCT_Options:SetAlpha(0.35)
	DCT_Options:EnableMouse(false)
	
	local obj,objname
	DCTEventOptionsExtraSlider_per:Hide()
	DCT_Opex_RefreshSpecSlider()
	

	for key,val in pairs(DCT_Spec_default) do
		if DCT_opex_saveP[DCT_CurrentEditEventName][key] == nil then
			getglobal("DCTOPEXICB_"..key):SetChecked(true)
		else
			getglobal("DCTOPEXICB_"..key):SetChecked(false)
		end
		getglobal("DCTOPEXICB_"..key.."Text"):SetText(DCT_TEXT_OPEX_CHECK)
	end
	
	DCT_Opex_RefreshSepcOption()
	
	--刷新帮助信息...
	local x,y,f
	local k
	local globalHelp = {"c1","c2","ce"}
	local hc = 0
	if DCT_Opex_Help2[DCT_CurrentEditEventName] then hc = table.getn(DCT_Opex_Help2[DCT_CurrentEditEventName]);end
	x = 0; y = -18;f = 0
	for i = 1,10 do
		k = nil
		obj = getglobal("DCTEventOptionsExtraHelp"..i)
		if i <= hc then
			k = DCT_Opex_Help2[DCT_CurrentEditEventName][i]
		elseif i <= hc + 3 then
			k = globalHelp[i - hc]
		end
		if k then
			obj:SetText("|cffffffff#"..k.."|r: "..DCT_Opex_Help[k])
			obj:SetPoint("LEFT", "DCTEventShowEdit2", "LEFT", x, y)
			if f == 0 then
				x = x + 175
				f = 1
			else
				y = y - 18
				x = 0
				f = 0
			end
			obj:Show()
		else
			obj:Hide()
		end
	end
	DCT_Opex_RefreshSepcOption()
	DCT_PreviewUpdata()
end

function DCT_Opex_RefreshSepcOption()	
	local p = DCT_opex_saveP[DCT_CurrentEditEventName]
	if not p["fEn"] then
		UIDropDownMenu_DisableDropDown(DCTEventOptionsExtraFontEnDDC)
	else
		UIDropDownMenu_EnableDropDown(DCTEventOptionsExtraFontEnDDC)
		DCTEventOptionsExtraFontEnDDC:Hide()
		DCTEventOptionsExtraFontEnDDC:Show()
	end
	if not p["fCh"] then
		UIDropDownMenu_DisableDropDown(DCTEventOptionsExtraFontChDDC)
	else
		UIDropDownMenu_EnableDropDown(DCTEventOptionsExtraFontChDDC)
		DCTEventOptionsExtraFontChDDC:Hide()
		DCTEventOptionsExtraFontChDDC:Show()
	end
	if not p["fEff"] then
		UIDropDownMenu_DisableDropDown(DCTEventOptionsExtraFontEffDDC)
	else
		UIDropDownMenu_EnableDropDown(DCTEventOptionsExtraFontEffDDC)
		DCTEventOptionsExtraFontEffDDC:Hide()
		DCTEventOptionsExtraFontEffDDC:Show()
	end
	if not p["fSizeEn"] then
		OptionsFrame_DisableSlider(DCTEventOptionsExtraSlider_fSizeEn)
	else
		OptionsFrame_EnableSlider(DCTEventOptionsExtraSlider_fSizeEn)
		DCTEventOptionsExtraSlider_fSizeEn:SetValue( DCT_opex_saveP[DCT_CurrentEditEventName].fSizeEn )
	end
	if not p["fSizeCh"] then
		OptionsFrame_DisableSlider(DCTEventOptionsExtraSlider_fSizeCh)
	else
		OptionsFrame_EnableSlider(DCTEventOptionsExtraSlider_fSizeCh)
		DCTEventOptionsExtraSlider_fSizeCh:SetValue( DCT_opex_saveP[DCT_CurrentEditEventName].fSizeCh )
	end
	
	
end

function DCT_Opex_EditPress(self)
	local c = string.len(self:GetName())
	DCT_opex_saveP[DCT_CurrentEditEventName].show[tonumber(string.sub(self:GetName(),c,c))] = self:GetText()
end

function DCT_Opex_SoundEditPress(self)
	local c = string.len(self:GetName())
	DCT_opex_saveP[DCT_CurrentEditEventName].sound = self:GetText()
end


function DCT_SetColorEx(p,id,r,g,b)
	p.colorEx[id][1] = r
	p.colorEx[id][2] = g
	p.colorEx[id][3] = b
	DCT_PreviewUpdata()
end

function DCT_Opex_SetColor(name)
	local r,g,b = ColorPickerFrame:GetColorRGB();
	local swatch,frame;
	swatch = getglobal(name.."_ColorSwatchNormalTexture");
	frame = getglobal(name);
	swatch:SetVertexColor(r,g,b);
	frame.r = r;
	frame.g = g;
	frame.b = b;

	DCT_SetColorEx(DCT_opex_saveP[DCT_CurrentEditEventName], tonumber(string.sub(name,string.len(name),string.len(name))),r, g, b)
end

function DCT_Open_CancelColor(name, prev)
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
	DCT_SetColorEx(DCT_opex_saveP[DCT_CurrentEditEventName], tonumber(string.sub(name,string.len(name),string.len(name))),r, g, b)
end


function DCT_Opex_FontEnDDC_Initialize()
	local i;
	local c;
	c = table.getn(DCT_Font)
	for i = 1, c do
		info = {
			text = i..". "..(DCT_Font[i].name);
			func = DCT_Opex_FontEnDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
		if not DCT_Font[i].active then
			UIDropDownMenu_DisableButton(1, i)
		end
	end	
end
function DCT_Opex_FontEnDDC_OnShow(self)
	UIDropDownMenu_Initialize(self, DCT_Opex_FontEnDDC_Initialize)
	UIDropDownMenu_SetSelectedID(self, DCT_opex_saveP[DCT_CurrentEditEventName].fEn)
	UIDropDownMenu_SetWidth(self,150)
	getglobal(self:GetName().."Label"):SetText(DCT_TEXT_OPEX_FONTENDDC)
end
function DCT_Opex_FontEnDDC_OnClick(self)
	local thisID = self:GetID()
	UIDropDownMenu_SetSelectedID(DCTEventOptionsExtraFontEnDDC, thisID)
	DCT_opex_saveP[DCT_CurrentEditEventName].fEn = thisID
	DCT_PreviewUpdata()
end

function DCT_Opex_FontChDDC_Initialize()
	local i;
	c = table.getn(DCT_Font)
	for i = 1, c do
		info = {
			text = i..". "..(DCT_Font[i].name);
			func = DCT_Opex_FontChDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
		if not DCT_Font[i].active then
			UIDropDownMenu_DisableButton(1, i)
		end
	end	
end
function DCT_Opex_FontChDDC_OnShow(self)
	UIDropDownMenu_Initialize(self, DCT_Opex_FontChDDC_Initialize)
	UIDropDownMenu_SetSelectedID(self, DCT_opex_saveP[DCT_CurrentEditEventName].fCh)
	UIDropDownMenu_SetWidth(self,150)
	getglobal(self:GetName().."Label"):SetText(DCT_TEXT_OPEX_FONTCHDDC)
end
function DCT_Opex_FontChDDC_OnClick(self)
	local thisID = self:GetID()
	UIDropDownMenu_SetSelectedID(DCTEventOptionsExtraFontChDDC, thisID)
	DCT_opex_saveP[DCT_CurrentEditEventName].fCh = thisID
	DCT_PreviewUpdata()
end

function DCT_Opex_FontEffDDC_Initialize()
	local key,val
	for key,val in pairs(DCT_Opex_FontEffTypeConfig) do
		info = {
			text = val;
			func = DCT_Opex_FontEffDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end	
end
function DCT_Opex_FontEffDDC_OnShow(self)
	UIDropDownMenu_Initialize(self, DCT_Opex_FontEffDDC_Initialize)
	UIDropDownMenu_SetSelectedID(self, DCT_opex_saveP[DCT_CurrentEditEventName].fEff)
	UIDropDownMenu_SetWidth(self,150)
	getglobal(self:GetName().."Label"):SetText(DCT_TEXT_OPEX_FONTEFFDDC)
end
function DCT_Opex_FontEffDDC_OnClick(self)
	local thisID = self:GetID()
	UIDropDownMenu_SetSelectedID(DCTEventOptionsExtraFontEffDDC, thisID)
	DCT_opex_saveP[DCT_CurrentEditEventName].fEff = thisID
	DCT_PreviewUpdata()
end

function DCT_Opex_SliderOnValue(self,objname,value)	
	local c = string.len(self:GetName())
	local f = string.find(self:GetName(),"_")
	local key = string.sub(objname,f + 1,c)
	if DCT_opex_saveP[DCT_CurrentEditEventName][key] then
		DCT_opex_saveP[DCT_CurrentEditEventName][key] = value
		DCT_PreviewUpdata()
	end	
end

function DCT_Opex_InheritsCheckBoxClick(self)
	local name = self:GetName()
	local  s = string.find(name,"_")
	name = string.sub(name,s + 1,string.len(name))
	val = self:GetChecked()
	if not val then
		DCT_opex_saveP[DCT_CurrentEditEventName][name] = DCT_Spec_default[name]
	else
		DCT_opex_saveP[DCT_CurrentEditEventName][name] = nil
	end
	DCT_Opex_RefreshSepcOption()
	DCT_Opex_RefreshSpecSlider()
	DCT_PreviewUpdata()
end
