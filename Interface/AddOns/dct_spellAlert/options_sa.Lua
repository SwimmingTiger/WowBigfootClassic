
local DCTSA_ButtonRegister = false
local DCTSA_DBFixed = false

local DCTSA_FilterPerPageMax = 15
local DCTSA_FilterCurPage = 0
local DCTSA_FilterCurSaType = "DCTSA_FILTER_CASTSTART"

function DCTSA_PreSetLoad(tid)
	if DCTSA_PRESET_TEXT[tid] ~= nil then
		DCT_Merge(DCTSA_DB,DCTSA_PRESET_TEXT[tid])
	end
end

function DCTSA_ProFileLoad(saveName)
	if DCTSA_GDB["PROFILE"][saveName] ~= nil then
		DCTSA_PERCONFIG = nil
		DCTSA_PERCONFIG = DCT_clone(DCTSA_GDB["PROFILE"][saveName])
		DCTSA_DB = DCTSA_PERCONFIG
		DCT_DataFix(DCTSA_DB,DCTSA_DEFAULT_CONFIG)
		DCT_DataShowParamFix(DCTSA_DB,DCTSA_DEFAULT_CONFIG)
	end
end

function DCTSA_ProFileSave(saveName)

	DCTSA_GDB["PROFILE"][saveName] = nil
	DCTSA_GDB["PROFILE"][saveName] = DCT_clone(DCTSA_DB)
end

function DCTSA_ProFileDelete(saveName)
	if DCTSA_GDB["PROFILE"][saveName] ~= nil then
		DCTSA_GDB["PROFILE"][saveName] = nil
	end
end

function DCTSA_AllReset()
	DCTSA_PERCONFIG = nil
	DCTSA_PERCONFIG = DCT_clone(DCTSA_DEFAULT_CONFIG)
	DCTSA_DB = DCTSA_PERCONFIG
end

function DCT_Opsa_RegistButton()
	if not DCTSA_ButtonRegister then
		if DCT_OptionsRegisterButton then
			DCT_RegisterSavePreFixes("DCTSA","DCTSA_DB")

			DCT_OptionsRegisterButton(DCT_SA_OPTION,DCTSAOption,DCT_Opsa_OnClick,10,530,240)
			DCT_OptionsRegisterButtonExBG(DCT_SA_OPTION,0,-300,530,165 )
			DCTSA_ButtonRegister = true
			DCTSAOption:SetParent(DCT_Options)
			DCTSAOption:SetPoint("TOPLEFT", "DCT_Options", "TOPLEFT", 180, -50)

			--注册Options菜单内配置文件存取的函数
			DCT_Opsave_RegisterProFileFunc("dct_spellalert",DCTSA_ProFileLoad,DCTSA_ProFileSave,DCTSA_ProFileDelete)
			--注册Options菜单内的重置函数
			DCT_OptionsRegisterResetFunc("dct_spellalert",DCTSA_AllReset)
			--注册Options菜单内的预设函数
			DCT_Opsave_RegisterLoadPreSetFunc("dct_spellalert",DCTSA_PreSetLoad)

			if DCT_Opex_Help2 then
				DCT_Opex_Help2["DCTSA_SHOW_CASTSTART"] = {"ic","sn","oi","cs"}
				DCT_Opex_Help2["DCTSA_SHOW_BUFFGET"] = {"ic","sn","oi","cs"}
				DCT_Opex_Help2["DCTSA_SHOW_BUFFFADE"] = {"ic","sn","oi","cs"}
				DCT_Opex_Help2["DCTSA_SHOW_DISPELLED"] = {"ic","sn","oi","cs"}
				DCT_Opex_Help2["DCTSA_SHOW_CASTSUCCESS"] = {"ic","sn","di","oi","cs"}

				DCT_Opex_Help2["DCTSA_SHOW_CASTSTART_FOCUS"] = DCT_Opex_Help2["DCTSA_SHOW_CASTSTART"]
				DCT_Opex_Help2["DCTSA_SHOW_BUFFGET_FOCUS"] = DCT_Opex_Help2["DCTSA_SHOW_BUFFGET"]
				DCT_Opex_Help2["DCTSA_SHOW_BUFFFADE_FOCUS"] = DCT_Opex_Help2["DCTSA_SHOW_BUFFFADE"]
				DCT_Opex_Help2["DCTSA_SHOW_DISPELLED_FOCUS"] = DCT_Opex_Help2["DCTSA_SHOW_DISPELLED"]
				DCT_Opex_Help2["DCTSA_SHOW_CASTSUCCESS_FOCUS"] = DCT_Opex_Help2["DCTSA_SHOW_CASTSUCCESS"]

				DCT_Opex_Help2["DCTSA_SHOW_CASTSTART_YOURTARGET"] = DCT_Opex_Help2["DCTSA_SHOW_CASTSTART"]
				DCT_Opex_Help2["DCTSA_SHOW_BUFFGET_YOURTARGET"] = DCT_Opex_Help2["DCTSA_SHOW_BUFFGET"]
				DCT_Opex_Help2["DCTSA_SHOW_BUFFFADE_YOURTARGET"] = DCT_Opex_Help2["DCTSA_SHOW_BUFFFADE"]
				DCT_Opex_Help2["DCTSA_SHOW_DISPELLED_YOURTARGET"] = DCT_Opex_Help2["DCTSA_SHOW_DISPELLED"]
				DCT_Opex_Help2["DCTSA_SHOW_CASTSUCCESS_YOURTARGET"] = DCT_Opex_Help2["DCTSA_SHOW_CASTSUCCESS"]
			end
		end
	end
end

function DCT_Opsa_OnShow(self)
	DCTSA_FilterCurPage = 0
	if not DCTSA_DBFixed then
		DCT_Opsave_CheckModeProfile(DCTSA_GDB["PROFILE"])
		DCTSA_DBFixed = true
	end
	DCT_Opsa_RefreshFilter()
end

function DCT_Opsa_RefreshFilter()
	local i
	for i = 1,15 do
		getglobal("DCTSACheckFilter"..i):Hide()
	end
	local fp = DCTSA_GDB[DCTSA_FilterCurSaType].filt
	local bp = DCTSA_GDB[DCTSA_FilterCurSaType].buffer
	local ifp = DCTSA_GDB[DCTSA_FilterCurSaType.."_SORT"].filt
	local ibp = DCTSA_GDB[DCTSA_FilterCurSaType.."_SORT"].buffer
	local filtC = table.getn(ifp)
	local bufferC = table.getn(ibp)
	--DCT_Debug("filtC:"..filtC.."bufferC"..bufferC)
	local txt
	local x = 15
	local y = -330
	local newLine = 1
	local filterId = DCTSA_FilterCurPage * DCTSA_FilterPerPageMax + 1
	for i = 1,DCTSA_FilterPerPageMax do
		if filterId <= filtC + bufferC then
			if filterId <= filtC then
				txt = select(1,ifp[filterId])
				getglobal("DCTSACheckFilter"..i):SetChecked(fp[ifp[filterId]])
			else
				txt = select(1,ibp[filterId - filtC])
				getglobal("DCTSACheckFilter"..i):SetChecked(bp[ibp[filterId - filtC]])
			end
			getglobal("DCTSACheckFilter"..i.."Text"):SetText(txt)
			getglobal("DCTSACheckFilter"..i):SetPoint("TOPLEFT", "DCTSAOption", "TOPLEFT", x, y)
			getglobal("DCTSACheckFilter"..i):Show()

			y = y - 25
			filterId = filterId + 1
		end
		newLine = newLine + 1
		if newLine > 5 then
			x = x + 170
			y = -330
			newLine = 1
		end
	end


	DCTSAList_Text:SetText((DCTSA_FilterCurPage + 1).."/"..(math.ceil((filtC + bufferC) / DCTSA_FilterPerPageMax))..DCT_TEXT_PAGE)
end

function DCT_Opsa_OnClick()
	DCT_Opex_SetSaveP(DCTSA_DB)
	DCT_OptionsFrame_Load(DCT_SaCfg_Event,DCTSA_DB)

end

function DCT_Opsa_FilterCheckOnClick(self, checkName)
	local id = tonumber(string.sub(checkName,17,string.len(checkName)))

	local fp = DCTSA_GDB[DCTSA_FilterCurSaType].filt
	local bp = DCTSA_GDB[DCTSA_FilterCurSaType].buffer
	local ifp = DCTSA_GDB[DCTSA_FilterCurSaType.."_SORT"].filt
	local ibp = DCTSA_GDB[DCTSA_FilterCurSaType.."_SORT"].buffer
	local filtC = table.getn(ifp)
	local bufferC = table.getn(ibp)

	local filterId = DCTSA_FilterCurPage * DCTSA_FilterPerPageMax + id
	local val = 0
	if self:GetChecked() then val = 1;end
	if filterId <= filtC then
		DCTSA_FiltSet(DCTSA_FilterCurSaType,ifp[filterId],val)
	else
		DCTSA_BufferSet(DCTSA_FilterCurSaType,ibp[filterId - filtC],val)
	end
end

function DCTSA_ButtonToggle(listName,add)
	local ifp = DCTSA_GDB[DCTSA_FilterCurSaType.."_SORT"].filt
	local ibp = DCTSA_GDB[DCTSA_FilterCurSaType.."_SORT"].buffer
	local filtC = table.getn(ifp)
	local bufferC = table.getn(ibp)

	local maxPage = math.ceil((filtC + bufferC) / DCTSA_FilterPerPageMax)
	if maxPage <= 0 then return;end
	DCTSA_FilterCurPage = DCTSA_FilterCurPage + add
	if DCTSA_FilterCurPage >= maxPage then DCTSA_FilterCurPage = maxPage - 1;end
	if DCTSA_FilterCurPage < 0 then DCTSA_FilterCurPage = 0;end
	DCT_Opsa_RefreshFilter()
end

function DCTSA_FilterProc(self)
	local fp = DCTSA_GDB[DCTSA_FilterCurSaType].filt
	local bp = DCTSA_GDB[DCTSA_FilterCurSaType].buffer
	local k,v
	for k,v in pairs(fp) do
		if v == 0 then
			DCTSA_FiltDelete(DCTSA_FilterCurSaType,k)
			DCTSA_BufferSet(DCTSA_FilterCurSaType,k,0)
		end
	end

	for k,v in pairs(bp) do
		if v == 1 then
			DCTSA_BufferDelete(DCTSA_FilterCurSaType,k)
			DCTSA_FiltSet(DCTSA_FilterCurSaType,k,1)
		end
	end

	DCTSA_FilterCurPage = 0
end


function DCT_Opsa_FilterDDC_Initialize()
	local i
	for i = 1,4 do
		info = {
			text = DCTSA_TXT_FilterDDCList[i][1];
			func = DCT_Opsa_FilterDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end
function DCT_Opsa_FilterDDC_OnShow(self)
	local sel = 1
	UIDropDownMenu_Initialize(self, DCT_Opsa_FilterDDC_Initialize)
	local i
	for i = 1,3 do
		if DCTSA_FilterCurSaType == DCTSA_TXT_FilterDDCList[i][2] then
			sel = i
		end
	end
	UIDropDownMenu_SetSelectedID(self, sel)
	UIDropDownMenu_SetWidth(self,150)
end

function DCT_Opsa_FilterDDC_OnClick(self)
	local thisID = self:GetID()
	UIDropDownMenu_SetSelectedID(DCTFliterDDC, thisID)

	DCTSA_FilterProc()

	DCTSA_FilterCurPage = 0
	DCTSA_FilterCurSaType = DCTSA_TXT_FilterDDCList[thisID][2]
	DCT_Opsa_RefreshFilter()
end

function DCT_Opsa_Filter_AddClick(self)
	local txt = DCTSA_Filter_Edit:GetText()
	if string.len(txt) > 0 then
		if DCTSA_FilterAdd(DCTSA_FilterCurSaType,txt) then
			DCTSA_FilterMoveTofilt(DCTSA_FilterCurSaType,txt)
			DCTSAOption:Hide()
			DCTSAOption:Show()
			DCT_Debug(DCT_SA_OPTION_ADD_SUCCESS..txt)
			return
		end
	end
	DCT_Debug(DCT_SA_OPTION_ADD_FAILED..txt)
end
