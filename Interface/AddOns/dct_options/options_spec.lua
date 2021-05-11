local DCT_specBuffC = 0
local DCT_specBuffFadeC = 0
local DCT_specSpellSuccessC = 0
local DCT_specSpellFailedC = 0
local DCT_specTargetBuffC = 0

--UIDropDownMenu_GetSelectedName
function DCT_Opspec_OnShow()	
	DCT_Opex_SetSaveP(DCT_Player)
	DCT_OptionsFrame_Load(DCT_SpecCfg_Event)
	DCTSpecOptionBuffListEdit:SetText("")
end

function DCT_Opspec_SpecBuffListDDC_Initialize()
	local k,v
	local specbuffP = DCT_Get("DCT_SPECBUFF")
	if not specbuffP then return;end
	DCT_specBuffC = 0

	for k,v in pairs(specbuffP) do
		info = {
			text = k;
			func = DCT_Opspec_SpecBuffListDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
		DCT_specBuffC = DCT_specBuffC + 1
	end	
	if DCT_specBuffC == 0 then
		info = {
			text = "none";
			func = DCT_Opspec_SpecBuffListDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end
function DCT_Opspec_SpecBuffListDDC_OnShow(self)
	local k,v
	local i = 1
	local specbuffP = DCT_Get("DCT_SPECBUFF")
	UIDropDownMenu_Initialize(self, DCT_Opspec_SpecBuffListDDC_Initialize)
	UIDropDownMenu_SetSelectedID(self, 1)
	UIDropDownMenu_SetWidth(self,120)
	for k,v in pairs(specbuffP) do
		if i == 1 then
			UIDropDownMenu_SetSelectedName(DCTSpecOptionSpecBuffListDDC, k)
		end
		i = i + 1
	end	
	getglobal(self:GetName().."Label"):SetText(DCT_TEXT_OPSPEC_BUFFLISTDDC)
end

function DCT_Opspec_SpecBuffListDDC_OnClick(self)
	local thisID = self:GetID()	
	UIDropDownMenu_SetSelectedID(DCTSpecOptionSpecBuffListDDC, thisID)
	local thisText = self:GetText()
	UIDropDownMenu_SetSelectedName(DCTSpecOptionSpecBuffListDDC, thisText)
	
end

function DCT_Opspec_DeleteClick()
	local name = UIDropDownMenu_GetSelectedName(DCTSpecOptionSpecBuffListDDC)
	if name == "none" then return;end
	
	local specbuffP = DCT_Get("DCT_SPECBUFF")
	if specbuffP[name] then
		specbuffP[name] = nil
		DCTSpecOption:Hide()
		DCTSpecOption:Show()
	end
end

function DCT_Opspec_AddClick()	
	if DCT_specBuffC >= 30 then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR3)
		return
	end	
	local name = DCTSpecOptionBuffListEdit:GetText()
	if string.len(name) < 1 then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR1)
		return
	end
	local specbuffP = DCT_Get("DCT_SPECBUFF")
	if specbuffP[name] then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR2)
		return
	else
		specbuffP[name] = 1
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_SUCCEED)
		DCTSpecOption:Hide()
		DCTSpecOption:Show()
	end
end


function DCT_Opspec_BuffFadeListDDC_Initialize()
	local k,v
	local specbuffP = DCT_Get("DCT_SPECBUFFFADE")
	if not specbuffP then return;end
	DCT_specBuffFadeC = 0

	for k,v in pairs(specbuffP) do
		info = {
			text = k;
			func = DCT_Opspec_BuffFadeListDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
		DCT_specBuffFadeC = DCT_specBuffFadeC + 1
	end	
	if DCT_specBuffFadeC == 0 then
		info = {
			text = "none";
			func = DCT_Opspec_BuffFadeListDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end
function DCT_Opspec_BuffFadeListDDC_OnShow(self)
	local k,v
	local i = 1
	local specbuffP = DCT_Get("DCT_SPECBUFFFADE")
	UIDropDownMenu_Initialize(self, DCT_Opspec_BuffFadeListDDC_Initialize)
	UIDropDownMenu_SetSelectedID(self, 1)
	UIDropDownMenu_SetWidth(self,120)
	for k,v in pairs(specbuffP) do
		if i == 1 then
			UIDropDownMenu_SetSelectedName(DCTSpecOptionBuffFadeListDDC, k)
		end
		i = i + 1
	end	
	getglobal(self:GetName().."Label"):SetText(DCT_TEXT_OPSPEC_BUFFLISTDDC)
end

function DCT_Opspec_BuffFadeListDDC_OnClick(self)
	local thisID = self:GetID()	
	UIDropDownMenu_SetSelectedID(DCTSpecOptionBuffFadeListDDC, thisID)
	local thisText = self:GetText()
	UIDropDownMenu_SetSelectedName(DCTSpecOptionBuffFadeListDDC, thisText)	
end

function DCT_Opspec_BuffFadeDeleteClick()
	local name = UIDropDownMenu_GetSelectedName(DCTSpecOptionBuffFadeListDDC)
	if name == "none" then return;end
	
	local specbuffP = DCT_Get("DCT_SPECBUFFFADE")
	if specbuffP[name] then
		specbuffP[name] = nil
		DCTSpecOption:Hide()
		DCTSpecOption:Show()
	end
end

function DCT_Opspec_BuffFadeAddClick()	
	if DCT_specBuffFadeC >= 30 then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR3)
		return
	end	
	local name = DCTSpecOptionBuffFadeEdit:GetText()
	if string.len(name) < 1 then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR1)
		return
	end
	local specbuffP = DCT_Get("DCT_SPECBUFFFADE")
	if specbuffP[name] then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR2)
		return
	else
		specbuffP[name] = 1
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_SUCCEED)
		DCTSpecOption:Hide()
		DCTSpecOption:Show()
	end
end


function DCT_Opspec_SpellSuccessListDDC_Initialize()
	local k,v
	local specbuffP = DCT_Get("DCT_SPECSPELLSUCCESS")
	if not specbuffP then return;end
	DCT_specSpellSuccessC = 0

	for k,v in pairs(specbuffP) do
		info = {
			text = k;
			func = DCT_Opspec_SpellSuccessListDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
		DCT_specSpellSuccessC = DCT_specSpellSuccessC + 1
	end	
	if DCT_specSpellSuccessC == 0 then
		info = {
			text = "none";
			func = DCT_Opspec_SpellSuccessListDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end
function DCT_Opspec_SpellSuccessListDDC_OnShow(self)
	local k,v
	local i = 1
	local specbuffP = DCT_Get("DCT_SPECSPELLSUCCESS")
	UIDropDownMenu_Initialize(self, DCT_Opspec_SpellSuccessListDDC_Initialize)
	UIDropDownMenu_SetSelectedID(self, 1)
	UIDropDownMenu_SetWidth(self,120)
	for k,v in pairs(specbuffP) do
		if i == 1 then
			UIDropDownMenu_SetSelectedName(DCTSpecOptionSpellSuccessListDDC, k)
		end
		i = i + 1
	end	
	getglobal(self:GetName().."Label"):SetText(DCT_TEXT_OPSPEC_SPELLLISTDDC)
end

function DCT_Opspec_SpellSuccessListDDC_OnClick(self)
	local thisID = self:GetID()	
	UIDropDownMenu_SetSelectedID(DCTSpecOptionSpellSuccessListDDC, thisID)
	local thisText = self:GetText()
	UIDropDownMenu_SetSelectedName(DCTSpecOptionSpellSuccessListDDC, thisText)	
end

function DCT_Opspec_SpellSuccessDeleteClick()
	local name = UIDropDownMenu_GetSelectedName(DCTSpecOptionSpellSuccessListDDC)
	if name == "none" then return;end
	
	local specbuffP = DCT_Get("DCT_SPECSPELLSUCCESS")
	if specbuffP[name] then
		specbuffP[name] = nil
		DCTSpecOption:Hide()
		DCTSpecOption:Show()
	end
end

function DCT_Opspec_SpellSuccessAddClick()	
	if DCT_specSpellSuccessC >= 30 then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR3)
		return
	end	
	local name = DCTSpecOptionSpellSuccessEdit:GetText()
	if string.len(name) < 1 then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR1)
		return
	end
	local specbuffP = DCT_Get("DCT_SPECSPELLSUCCESS")
	if specbuffP[name] then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR2)
		return
	else
		specbuffP[name] = 1
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_SUCCEED)
		DCTSpecOption:Hide()
		DCTSpecOption:Show()
	end
end

function DCT_Opspec_SpellFailedListDDC_Initialize()
	local k,v
	local specbuffP = DCT_Get("DCT_SPECSPELLFAILED")
	if not specbuffP then return;end
	DCT_specSpellFailedC = 0

	for k,v in pairs(specbuffP) do
		info = {
			text = k;
			func = DCT_Opspec_SpellFailedListDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
		DCT_specSpellFailedC = DCT_specSpellFailedC + 1
	end	
	if DCT_specSpellFailedC == 0 then
		info = {
			text = "none";
			func = DCT_Opspec_SpellFailedListDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end
function DCT_Opspec_SpellFailedListDDC_OnShow(self)
	local k,v
	local i = 1
	local specbuffP = DCT_Get("DCT_SPECSPELLFAILED")
	UIDropDownMenu_Initialize(self, DCT_Opspec_SpellFailedListDDC_Initialize)
	UIDropDownMenu_SetSelectedID(self, 1)
	UIDropDownMenu_SetWidth(self,120)
	for k,v in pairs(specbuffP) do
		if i == 1 then
			UIDropDownMenu_SetSelectedName(DCTSpecOptionSpellFailedListDDC, k)
		end
		i = i + 1
	end	
	getglobal(self:GetName().."Label"):SetText(DCT_TEXT_OPSPEC_SPELLLISTDDC)
end

function DCT_Opspec_SpellFailedListDDC_OnClick(self)
	local thisID = self:GetID()	
	UIDropDownMenu_SetSelectedID(DCTSpecOptionSpellFailedListDDC, thisID)
	local thisText = self:GetText()
	UIDropDownMenu_SetSelectedName(DCTSpecOptionSpellFailedListDDC, thisText)	
end

function DCT_Opspec_SpellFailedDeleteClick()
	local name = UIDropDownMenu_GetSelectedName(DCTSpecOptionSpellFailedListDDC)
	if name == "none" then return;end
	
	local specbuffP = DCT_Get("DCT_SPECSPELLFAILED")
	if specbuffP[name] then
		specbuffP[name] = nil
		DCTSpecOption:Hide()
		DCTSpecOption:Show()
	end
end

function DCT_Opspec_SpellFailedAddClick()	
	if DCT_specSpellFailedC >= 30 then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR3)
		return
	end	
	local name = DCTSpecOptionSpellFailedEdit:GetText()
	if string.len(name) < 1 then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR1)
		return
	end
	local specbuffP = DCT_Get("DCT_SPECSPELLFAILED")
	if specbuffP[name] then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR2)
		return
	else
		specbuffP[name] = 1
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_SUCCEED)
		DCTSpecOption:Hide()
		DCTSpecOption:Show()
	end
end

function DCT_Opspec_CoolDownListDDC_Initialize()
	local k,v
	local specbuffP = DCT_Get("DCT_SPECCOOLDOWN")
	if not specbuffP then return;end
	DCT_specCoolDownC = 0

	for k,v in pairs(specbuffP) do
		info = {
			text = k;
			func = DCT_Opspec_CoolDownListDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
		DCT_specCoolDownC = DCT_specCoolDownC + 1
	end	
	if DCT_specCoolDownC == 0 then
		info = {
			text = "none";
			func = DCT_Opspec_CoolDownListDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end
function DCT_Opspec_CoolDownListDDC_OnShow(self)
	local k,v
	local i = 1
	local specbuffP = DCT_Get("DCT_SPECCOOLDOWN")
	UIDropDownMenu_Initialize(self, DCT_Opspec_CoolDownListDDC_Initialize)
	UIDropDownMenu_SetSelectedID(self, 1)
	UIDropDownMenu_SetWidth(self,120)
	for k,v in pairs(specbuffP) do
		if i == 1 then
			UIDropDownMenu_SetSelectedName(DCTSpecOptionCoolDownListDDC, k)
		end
		i = i + 1
	end	
	getglobal(self:GetName().."Label"):SetText(DCT_TEXT_OPSPEC_SPELLLISTDDC)
end

function DCT_Opspec_CoolDownListDDC_OnClick(self)
	local thisID = self:GetID()	
	UIDropDownMenu_SetSelectedID(DCTSpecOptionCoolDownListDDC, thisID)
	local thisText = self:GetText()
	UIDropDownMenu_SetSelectedName(DCTSpecOptionCoolDownListDDC, thisText)	
end

function DCT_Opspec_CoolDownDeleteClick()
	local name = UIDropDownMenu_GetSelectedName(DCTSpecOptionCoolDownListDDC)
	if name == "none" then return;end
	
	local specbuffP = DCT_Get("DCT_SPECCOOLDOWN")
	if specbuffP[name] then
		specbuffP[name] = nil
		DCTSpecOption:Hide()
		DCTSpecOption:Show()
	end
end

function DCT_Opspec_CoolDownAddClick()	
	if DCT_specCoolDownC >= 30 then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR3)
		return
	end	
	local name = DCTSpecOptionCoolDownEdit:GetText()
	if string.len(name) < 1 then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR1)
		return
	end
	local specbuffP = DCT_Get("DCT_SPECCOOLDOWN")
	if specbuffP[name] then
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_ERROR2)
		return
	else
		specbuffP[name] = 1
		DCT_Debug(DCT_TEXT_OPSPEC_ADD_SUCCEED)
		DCTSpecOption:Hide()
		DCTSpecOption:Show()
	end
end
