DCT_Opani_CurFrameID = 1
DCT_Opani_AniParamDDC1_buttonC = 0

function DCT_InitSliders(obj,objname,key,val)
	DCT_ConfigSlider(obj,DCT_Player["DCT_FRAME_CONFIG"][DCT_Opani_CurFrameID][key],val)
end

function DCT_Opani_Refresh()
	DCTAniOptionparam1DDC:Hide()
	DCTAniOptionparam2DDC:Hide()
	DCTAniOption:Hide()
	DCTAniOption:Show()	
end

function DCT_Opani_FrameBoxRefresh()
	local i
	local obj
	local tp = DCT_Get("DCT_FRAME_CONFIG")
	for i = 1,DCT_Ani_MaxFrame do
		obj = getglobal("DCTAniOptionFrameBox"..i)
		obj:SetAlpha(0.7)
		if tp[i].active then
			obj:SetPoint("CENTER", "UIParent", "CENTER", DCT_Get("DCT_FRAME_CONFIG")[i].x, DCT_Get("DCT_FRAME_CONFIG")[i].y)
			getglobal("DCTAniOptionFrameBox"..i.."_Title2"):SetText(DCT_Opani_AniTypeConfig[tp[i].aniType])
			obj:Show()
			if i == DCT_Opani_CurFrameID then
				obj:SetBackdropColor(0, 0, 1)
			else
				obj:SetBackdropColor(.8, .8, .8)
			end
		else
			obj:Hide()
		end
	end
end

function DCT_Opani_FrameBoxHide()
	local i
	for i = 1,DCT_Ani_MaxFrame do
		getglobal("DCTAniOptionFrameBox"..i):Hide()
	end
end

function DCT_Opani_OnShow()
    local obj,objname
	local key,val
	if not DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].active then DCT_Opani_CurFrameID = 1;end
	for key, val in pairs(DCT_Opani_Config.Sliders) do	
		objname = "DCTAniOption".."Slider_"..key
		obj = getglobal(objname)
		if obj then			
			DCT_InitSliders(obj,objname,key,val)
		end
	end
	--根据当前动画类型，刷新动画相关参数
	DCTAniOptionSlider_param1:Hide()
	DCTAniOptionSlider_param2:Hide()
	DCTAniOptionSlider_param3:Hide()
	DCTAniOptionSlider_param4:Hide()
	DCTAniOptionSlider_param5:Hide()
	DCTAniOptionSlider_param6:Hide()
	
	local startY = -60
	local p = DCT_AniModeParamsSliders[DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].aniType].Sliders
	if p then
		for i = 1,6 do			
			if p["param"..i] then
				key = "param"..i
				objname = "DCTAniOption".."Slider_"..key
				obj = getglobal(objname)
				
				obj:SetPoint("TOPLEFT", "DCTAniOptionAniTypeDDC", "TOPLEFT", 20, startY)
				
				startY = startY - 50
				obj:Show()
				
				DCT_InitSliders(obj,objname,key,p[key])
			end
		end
	end

	if DCT_AniModeParamsSliders[DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].aniType].Ddc then
		local c = table.getn(DCT_AniModeParamsSliders[DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].aniType].Ddc)
		local i
		for i = 1,c do
			getglobal("DCTAniOptionparam"..i.."DDC"):Show()
			getglobal("DCTAniOptionparam"..i.."DDC"):SetPoint("TOPLEFT", "DCTAniOptionAniTypeDDC", "TOPLEFT", 0, startY)			
			startY = startY - 40
		end
	end
	
	for i = 1,DCT_Ani_MaxFrame do
		getglobal("DCTAniOptionFrameBox"..i.."_Title1"):SetText(DCT_TEXT_OPANI_FRAME.." "..i)
	end
	
	DCT_Opani_FrameBoxRefresh()
end

function DCT_Opani_AddFrame()
	local newId = DCT_Ani_FrameGetFreeFID()

	if newId > 0 then
		local tp = DCT_Get("DCT_FRAME_CONFIG")
		tp[newId].active = true
		tp[newId].name = ""
		tp[newId].aniType = 1
		tp[newId].speed = 100
		tp[newId].angle = 1
		tp[newId].alpha = 100
		tp[newId].x = 0
		tp[newId].y = 0
		tp[newId].fEn = 2		
		tp[newId].fCh = 2
		tp[newId].fSizeEn = 18		
		tp[newId].fSizeCh = 18
		tp[newId].fEff = 1
		DCT_SetFrameAniDefault(newId)
		DCT_Opani_CurFrameID = newId
		DCT_ReLoadFrame()
		DCT_Opani_Refresh()
	end
end

--应用当前字体设置到所有框架
function DCT_Opani_BatFont()
	local p = DCT_Get("DCT_FRAME_CONFIG")
	for i = 1, DCT_Ani_MaxFrame do
		if i ~= DCT_Opani_CurFrameID and DCT_Ani_FrameIsActive(i) then
			p[i].fEn = p[DCT_Opani_CurFrameID].fEn
			p[i].fCh = p[DCT_Opani_CurFrameID].fCh
		end
	end	
end

function DCT_Opani_DeleteFrame()
	local tp = DCT_Get("DCT_FRAME_CONFIG")
	
	if DCT_Opani_CurFrameID ~= 1 then
		tp[DCT_Opani_CurFrameID].active = false
		DCT_ReLoadFrame()
		local i = DCT_Opani_CurFrameID
		while not tp[i].active do
			i = i - 1
		end
		DCT_Opani_CurFrameID = i
		DCT_Opani_Refresh()
	end
end

function DCT_Opani_FrameDDC_Initialize()
	local i;
	for i = 1, DCT_Ani_MaxFrame do
		info = {
			text = DCT_TEXT_OPANI_FRAME..i;
			func = DCT_Opani_FrameDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
		if not DCT_Ani_FrameIsActive(i) then
			UIDropDownMenu_DisableButton(1, i)
		end
	end	
end
function DCT_Opani_FrameDDC_OnShow(self)
	UIDropDownMenu_Initialize(self, DCT_Opani_FrameDDC_Initialize)
	UIDropDownMenu_SetSelectedID(self, DCT_Opani_CurFrameID)
	UIDropDownMenu_SetWidth(self,120)
	getglobal(self:GetName().."Label"):SetText(DCT_TEXT_OPANI_FRAMEDDC)
end
function DCT_Opani_FrameDDC_OnClick(self)
	local thisID = self:GetID()
	UIDropDownMenu_SetSelectedID(DCTAniOptionFrameDDC, thisID)
	DCT_Opani_CurFrameID = thisID
	
	DCT_Opani_Refresh()
end


function DCT_Opani_FontEnDDC_Initialize()
	local i;
	c = table.getn(DCT_Font)
	for i = 1, c do
		info = {
			text = i..". "..(DCT_Font[i].name);
			func = DCT_Opani_FontEnDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
		if not DCT_Font[i].active then
			UIDropDownMenu_DisableButton(1, i)
		end
	end	
end
function DCT_Opani_FontEnDDC_OnShow(self)
	UIDropDownMenu_Initialize(self, DCT_Opani_FontEnDDC_Initialize)
	UIDropDownMenu_SetSelectedID(self, DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].fEn)
	UIDropDownMenu_SetWidth(self,180)
	getglobal(self:GetName().."Label"):SetText(DCT_TEXT_OPEX_FONTENDDC)
end
function DCT_Opani_FontEnDDC_OnClick(self)
	local thisID = self:GetID()
	UIDropDownMenu_SetSelectedID(DCTAniOptionFontEnDDC, thisID)
	DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].fEn = thisID
end

function DCT_Opani_FontChDDC_Initialize()
	local i;
	c = table.getn(DCT_Font)
	for i = 1, c do
		info = {
			text = i..". "..(DCT_Font[i].name);
			func = DCT_Opani_FontChDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
		if not DCT_Font[i].active then
			UIDropDownMenu_DisableButton(1, i)
		end
	end	
end
function DCT_Opani_FontChDDC_OnShow(self)
	UIDropDownMenu_Initialize(self, DCT_Opani_FontChDDC_Initialize)
	UIDropDownMenu_SetSelectedID(self, DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].fCh)
	UIDropDownMenu_SetWidth(self,180)
	getglobal(self:GetName().."Label"):SetText(DCT_TEXT_OPEX_FONTCHDDC)
end
function DCT_Opani_FontChDDC_OnClick(self)
	local thisID = self:GetID()
	UIDropDownMenu_SetSelectedID(DCTAniOptionFontChDDC, thisID)
	DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].fCh = thisID
end

function DCT_Opani_FontEffDDC_Initialize()
	local key,val
	for key,val in pairs(DCT_Opex_FontEffTypeConfig) do
		info = {
			text = val;
			func = DCT_Opani_FontEffDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end	
end
function DCT_Opani_FontEffDDC_OnShow(self)
	UIDropDownMenu_Initialize(self, DCT_Opani_FontEffDDC_Initialize)
	UIDropDownMenu_SetSelectedID(self, DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].fEff)
	UIDropDownMenu_SetWidth(self,180)
	getglobal(self:GetName().."Label"):SetText(DCT_TEXT_OPEX_FONTEFFDDC)
end
function DCT_Opani_FontEffDDC_OnClick(self)
	local thisID = self:GetID()
	UIDropDownMenu_SetSelectedID(DCTAniOptionFontEffDDC, thisID)
	DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].fEff = thisID
end


function DCT_Opani_AnchorDDC_Initialize()
	local key,val
	for key,val in pairs(DCT_Opani_AnchorConfig) do
		info = {
			text = val;
			func = DCT_Opani_AnchorDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end	
end
function DCT_Opani_AnchorDDC_OnShow(self)
	UIDropDownMenu_Initialize(self, DCT_Opani_AnchorDDC_Initialize)
	if DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].anchor then
		UIDropDownMenu_SetSelectedID(self, DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].anchor)
	else
		UIDropDownMenu_SetSelectedID(self, 1)
	end
	UIDropDownMenu_SetWidth(self,60)
	getglobal(self:GetName().."Label"):SetText(DCT_TEXT_OPANI_ANCHORDDC)
end
function DCT_Opani_AnchorDDC_OnClick(self)
	local thisID = self:GetID()
	UIDropDownMenu_SetSelectedID(DCTAniOptionAnchorDDC, thisID)
	DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].anchor = thisID
end

function DCT_Opani_AniTypeDDC_Initialize()
	local i;
	local c = table.getn(DCT_Opani_AniTypeConfig)
	for i = 1, c do
		info = {
			text = DCT_Opani_AniTypeConfig[i];
			func = DCT_Opani_AniTypeDDC_OnClick;
		}
		UIDropDownMenu_AddButton(info)
	end	
end
function DCT_Opani_AniTypeDDC_OnShow(self)
	UIDropDownMenu_Initialize(self, DCT_Opani_AniTypeDDC_Initialize)
	UIDropDownMenu_SetSelectedID(self, DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].aniType)
	UIDropDownMenu_SetWidth(self,80)
	getglobal(self:GetName().."Label"):SetText(DCT_TEXT_OPANI_ANITYPEDDC)
end
function DCT_Opani_AniTypeDDC_OnClick(self)
	local thisID = self:GetID()
	UIDropDownMenu_SetSelectedID(DCTAniOptionAniTypeDDC, thisID)
	DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].aniType = thisID
	
	DCT_SetFrameAniDefault(DCT_Opani_CurFrameID)
	DCT_Opani_Refresh()
end

function DCT_Opani_param1DDC_Initialize()
	local i,c
	local ddcl = DCT_AniModeParamsSliders[DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].aniType].Ddc[1].text
	for i = 1, table.getn(ddcl) do
		info = {
			text = ddcl[i];
			func = DCT_Opani_param1DDC_OnClick;
		};			
		UIDropDownMenu_AddButton(info);
	end	
end
function DCT_Opani_param1DDC_OnShow(self)
	local ddcp = DCT_AniModeParamsSliders[DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].aniType].Ddc[1]
	if not ddcp then
		DCTAniOptionparam1DDC:Hide()
		return
	end
	DCTAniOptionparam1DDC:Show()
	UIDropDownMenu_Initialize(self, DCT_Opani_param1DDC_Initialize)	
	UIDropDownMenu_SetSelectedID(self, DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID][ddcp.param])
	UIDropDownMenu_SetWidth(self,120)
	getglobal(self:GetName().."Label"):SetText(ddcp.name)
end
function DCT_Opani_param1DDC_OnClick(self)
	local thisID = self:GetID()
	UIDropDownMenu_SetSelectedID(DCTAniOptionparam1DDC, thisID)
	local key = DCT_AniModeParamsSliders[DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].aniType].Ddc[1].param
	DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID][key] = thisID
end

function DCT_Opani_param2DDC_Initialize()
	local i;
	local ddcl = DCT_AniModeParamsSliders[DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].aniType].Ddc[2].text
	for i = 1, table.getn(ddcl) do
		info = {
			text = ddcl[i];
			func = DCT_Opani_param2DDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end	
end
function DCT_Opani_param2DDC_OnShow(self)
	local ddcp = DCT_AniModeParamsSliders[DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].aniType].Ddc[2]
	if not ddcp then
		DCTAniOptionparam2DDC:Hide()
		return
	end
	DCTAniOptionparam2DDC:Show()
	UIDropDownMenu_Initialize(self, DCT_Opani_param2DDC_Initialize)	
	UIDropDownMenu_SetSelectedID(self, DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID][ddcp.param])
	UIDropDownMenu_SetWidth(self,120)
	getglobal(self:GetName().."Label"):SetText(ddcp.name)
end
function DCT_Opani_param2DDC_OnClick(self)
	local thisID = self:GetID()
	UIDropDownMenu_SetSelectedID(DCTAniOptionparam2DDC, thisID)
	local key = DCT_AniModeParamsSliders[DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID].aniType].Ddc[2].param
	DCT_Get("DCT_FRAME_CONFIG")[DCT_Opani_CurFrameID][key] = thisID
end

--Sets the silder values in the config

function DCT_Opani_SliderValueChange(self,objname,val)
	local c = string.len(objname)
	local f = string.find(objname,"_")
	local key = string.sub(objname,f + 1,c)

	local theval
	if val == 0 then
		theval = 0
	else
		theval = floor(val * 10) / 10
	end
	
	DCT_Player["DCT_FRAME_CONFIG"][DCT_Opani_CurFrameID][key] = theval
	if key == "angle" then
		DCT_Ani_FrameSetAngle(DCT_Opani_CurFrameID,theval)
	end
	if key == "x" or key == "y" then
		DCT_Opani_FrameBoxRefresh()
		DCT_Ani_FramePos(DCT_Opani_CurFrameID,DCT_Player["DCT_FRAME_CONFIG"][DCT_Opani_CurFrameID].x,DCT_Player["DCT_FRAME_CONFIG"][DCT_Opani_CurFrameID].y)
	end
end


function DCTFrameBoxMouseDown(self, button)	
	local c = string.len(self:GetName())
	local fId = tonumber(string.sub(self:GetName(),21,c))
	if button == "RightButton" then		
		DCT_Opani_CurFrameID = fId
		DCT_Opani_Refresh()
	elseif button == "LeftButton" then
		DCT_Opani_PreView(self, fId)
	end
end

function DCT_Opani_PreView(self, fId)
	local param = {frame = 1,color = {1,0,0},specdef = false}
	DCT_Ani_FrameAddObject(fId,DCT_TEXT_TEST,param)
end
