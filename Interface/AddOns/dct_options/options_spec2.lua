local DCT_specCoolDownC = 0
local DCT_specTargetBuffFadeC = 0

function DCT_Opspec_OnShow2()	
	DCT_Opex_SetSaveP(DCT_Player)
	DCT_OptionsFrame_Load(DCT_SpecCfg_Event2)
	DCTSpecOptionBuffListEdit:SetText("")
end


function DCT_Opspec_TargetBuffListDDC_Initialize()
	local k,v
	local specbuffP = DCT_Get("DCT_SPECTARGETBUFF")
	if not specbuffP then return;end
	DCT_specTargetBuffC = 0

	for k,v in pairs(specbuffP) do
		info = {
			text = k;
			func = DCT_Opspec_TargetBuffListDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
		DCT_specTargetBuffC = DCT_specTargetBuffC + 1
	end	
	if DCT_specTargetBuffC == 0 then
		info = {
			text = "none";
			func = DCT_Opspec_TargetBuffListDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end
function DCT_Opspec_TargetBuffListDDC_OnShow(self)
	local k,v
	local i = 1
	local specbuffP = DCT_Get("DCT_SPECTARGETBUFF")
	UIDropDownMenu_Initialize(self, DCT_Opspec_TargetBuffListDDC_Initialize)
	UIDropDownMenu_SetSelectedID(self, 1)
	UIDropDownMenu_SetWidth(self,120)
	for k,v in pairs(specbuffP) do
		if i == 1 then
			UIDropDownMenu_SetSelectedName(DCTSpecOption2TargetBuffListDDC, k)
		end
		i = i + 1
	end	
	getglobal(self:GetName().."Label"):SetText(DCT_TEXT_OPSPEC_BUFFLISTDDC)
end

function DCT_Opspec_TargetBuffListDDC_OnClick(self)
	local thisID = self:GetID()	
	UIDropDownMenu_SetSelectedID(DCTSpecOption2TargetBuffListDDC, thisID)
	local thisText = self:GetText()
	UIDropDownMenu_SetSelectedName(DCTSpecOption2TargetBuffListDDC, thisText)	
end

function DCT_Opspec_TargetBuffDeleteClick()
	local name = UIDropDownMenu_GetSelectedName(DCTSpecOption2TargetBuffListDDC)
	if name == "none" then return;end
	
	local specbuffP = DCT_Get("DCT_SPECTARGETBUFF")
	if specbuffP[name] then
		specbuffP[name] = nil
		DCTSpecOption2:Hide()
		DCTSpecOption2:Show()
	end
end

function DCT_Opspec_TargetBuffAddClick()	
	if DCT_specTargetBuffC >= 30 then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR3)
		return
	end	
	local name = DCTSpecOption2TargetBuffEdit:GetText()
	if string.len(name) < 1 then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR1)
		return
	end
	local specbuffP = DCT_Get("DCT_SPECTARGETBUFF")
	if specbuffP[name] then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR2)
		return
	else
		specbuffP[name] = 1
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_SUCCEED)
		DCTSpecOption2:Hide()
		DCTSpecOption2:Show()
	end
end




function DCT_Opspec_TargetBuffFadeListDDC_Initialize()
	local k,v
	local specbuffP = DCT_Get("DCT_SPECTARGETBUFFFADE")
	if not specbuffP then return;end
	DCT_specTargetBuffFadeC = 0

	for k,v in pairs(specbuffP) do
		info = {
			text = k;
			func = DCT_Opspec_TargetBuffFadeListDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
		DCT_specTargetBuffFadeC = DCT_specTargetBuffFadeC + 1
	end	
	if DCT_specTargetBuffFadeC == 0 then
		info = {
			text = "none";
			func = DCT_Opspec_TargetBuffFadeListDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end
function DCT_Opspec_TargetBuffFadeListDDC_OnShow(self)
	local k,v
	local i = 1
	local specbuffP = DCT_Get("DCT_SPECTARGETBUFFFADE")
	UIDropDownMenu_Initialize(self, DCT_Opspec_TargetBuffFadeListDDC_Initialize)
	UIDropDownMenu_SetSelectedID(self, 1)
	UIDropDownMenu_SetWidth(self,120)
	for k,v in pairs(specbuffP) do
		if i == 1 then
			UIDropDownMenu_SetSelectedName(DCTSpecOption2TargetBuffFadeListDDC, k)
		end
		i = i + 1
	end	
	getglobal(self:GetName().."Label"):SetText(DCT_TEXT_OPSPEC_BUFFLISTDDC)
end

function DCT_Opspec_TargetBuffFadeListDDC_OnClick(self)
	local thisID = self:GetID()	
	UIDropDownMenu_SetSelectedID(DCTSpecOption2TargetBuffFadeListDDC, thisID)
	local thisText = self:GetText()
	UIDropDownMenu_SetSelectedName(DCTSpecOption2TargetBuffFadeListDDC, thisText)	
end

function DCT_Opspec_TargetBuffFadeDeleteClick()
	local name = UIDropDownMenu_GetSelectedName(DCTSpecOption2TargetBuffFadeListDDC)
	if name == "none" then return;end
	
	local specbuffP = DCT_Get("DCT_SPECTARGETBUFFFADE")
	if specbuffP[name] then
		specbuffP[name] = nil
		DCTSpecOption2:Hide()
		DCTSpecOption2:Show()
	end
end

function DCT_Opspec_TargetBuffFadeAddClick()	
	if DCT_specTargetBuffFadeC >= 30 then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR3)
		return
	end	
	local name = DCTSpecOption2TargetBuffFadeEdit:GetText()
	if string.len(name) < 1 then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR1)
		return
	end
	local specbuffP = DCT_Get("DCT_SPECTARGETBUFFFADE")
	if specbuffP[name] then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR2)
		return
	else
		specbuffP[name] = 1
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_SUCCEED)
		DCTSpecOption2:Hide()
		DCTSpecOption2:Show()
	end
end
