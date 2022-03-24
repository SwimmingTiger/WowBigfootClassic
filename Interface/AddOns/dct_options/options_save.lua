
DCT_Opsave_ModFuncList = {
}

--UIDropDownMenu_GetSelectedName
function DCT_Opsave_OnShow()	
	DCTSaveOptionEdit.EnterPressFunc = DCT_Opsave_EditPress
	DCTSaveOptionEdit:SetText("")
	getglobal("DCTSaveOptionEditLabel"):SetText(DCT_TEXT_OPSAVE_EDIT)
end

function DCT_Opsave_EditPress()

end
--其他插件用来注册各自的配置文件操作函数
function DCT_Opsave_RegisterProFileFunc(modname,loadFunc,saveFunc,deleteFunc)
	if not DCT_Opsave_ModFuncList[modname] then
		DCT_Opsave_ModFuncList[modname] = {}
	end
	DCT_Opsave_ModFuncList[modname]["Load"] = loadFunc
	DCT_Opsave_ModFuncList[modname]["Save"] = saveFunc
	DCT_Opsave_ModFuncList[modname]["Delete"] = deleteFunc
end

function DCT_Opsave_ModFuncRun(runkey,param)
	local k,v
	for k,v in pairs(DCT_Opsave_ModFuncList) do
		v[runkey](param)
	end
end

function DCT_Opsave_RegisterLoadPreSetFunc(modname,func)
	if not DCT_Opsave_ModFuncList[modname] then
		DCT_Opsave_ModFuncList[modname] = {}
	end
	DCT_Opsave_ModFuncList[modname]["LoadPreSet"] = func
end
--检查其他Mod内的预设文件名字，再Options中是否存在，不存在则删除
function DCT_Opsave_CheckModeProfile(profiletable)
	if type(profiletable) ~= "table" then return;end
	local k,v
	for k,v in pairs(profiletable) do
		if not DCTOP_SAVE[k] then
			profiletable[k] = nil
		end
	end
end

function DCT_Opsave_Load()
	curName = UIDropDownMenu_GetSelectedName(DCTSaveOptionSaveListDDC)
	if curName == DCT_TEXT_OPSAVE_NONE then
		DCT_Debug(DCT_TEXT_OPSAVE_LOAD_ERROR)
		return
	end
	if DCTOP_SAVE[curName] then
		DCT_Config_Load(DCTOP_SAVE[UIDropDownMenu_GetSelectedName(DCTSaveOptionSaveListDDC)])
		DCT_Opsave_ModFuncRun("Load",UIDropDownMenu_GetSelectedName(DCTSaveOptionSaveListDDC))
		DCT_Debug(DCT_TEXT_OPSAVE_LOAD_SUCCEED..UIDropDownMenu_GetSelectedName(DCTSaveOptionSaveListDDC))
	else
		DCT_Debug(DCT_TEXT_OPSAVE_LOAD_ERROR)
	end
	DCT_Opani_CurFrameID = 1
end

function DCT_Opsave_Save()
	curName = UIDropDownMenu_GetSelectedName(DCTSaveOptionSaveListDDC)
	if curName == DCT_TEXT_OPSAVE_NONE then
		DCT_Debug(DCT_TEXT_OPSAVE_SAVE_ERROR)
		return
	end
	DCTOP_SAVE[curName] = nil
	DCTOP_SAVE[curName] = DCT_clone(DCT_Player)
	DCT_Opsave_ModFuncRun("Save",curName)
	DCT_Debug(DCT_TEXT_OPSAVE_SAVE_SUCCEED..curName)
end

function DCT_Opsave_Add()
	saveName = DCTSaveOptionEdit:GetText()
	if saveName == DCT_TEXT_OPSAVE_NONE then
		DCT_Debug(DCT_TEXT_OPSAVE_ADD_ERROR)
		return
	end
	if string.len(saveName) > 0 and not DCTOP_SAVE[saveName] then		
		DCTOP_SAVE[saveName] = DCT_clone(DCT_Player)	
		DCTSaveOption:Hide()
		DCTSaveOption:Show()
		DCT_Opsave_ModFuncRun("Save",saveName)
		DCT_Debug(DCT_TEXT_OPSAVE_ADD_SUCCEED..saveName)
	else
		DCT_Debug(DCT_TEXT_OPSAVE_ADD_ERROR)
	end
end

function DCT_Opsave_Delete()
	curName = UIDropDownMenu_GetSelectedName(DCTSaveOptionSaveListDDC)
	if curName == DCT_TEXT_OPSAVE_NONE then
		DCT_Debug(DCT_TEXT_OPSAVE_DELETE_ERROR)
		return
	end
	if string.len(curName) > 0 and DCTOP_SAVE[curName] then
		DCTOP_SAVE[curName] = nil;
		DCTSaveOption:Hide()
		DCTSaveOption:Show()
		DCT_Opsave_ModFuncRun("Delete",curName)
		DCT_Debug(DCT_TEXT_OPSAVE_DELETE_SUCCEED..curName)
	else
		DCT_Debug(DCT_TEXT_OPSAVE_DELETE_ERROR)
	end	
end

function DCT_Opsave_SaveListDDC_Initialize()
	local i;
	local buttonC = 0
	for key,val in pairs(DCTOP_SAVE) do
		info = {
			text = key;
			func = DCT_Opsave_SaveListDDC_OnClick;
		};
		buttonC = buttonC + 1
		UIDropDownMenu_AddButton(info);
	end
	if buttonC == 0 then
		info = {
			text = DCT_TEXT_OPSAVE_NONE;
			func = DCT_Opsave_SaveListDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);		
	end
end
function DCT_Opsave_SaveListDDC_OnShow(self)
	UIDropDownMenu_Initialize(self, DCT_Opsave_SaveListDDC_Initialize)
	UIDropDownMenu_SetSelectedID(self, 1)
	local id = 0
	for key,val in pairs(DCTOP_SAVE) do	
		id = id + 1
		if id == 1 then
			UIDropDownMenu_SetSelectedName(self, key)
		end		
	end
	if id == 0 then
		UIDropDownMenu_SetSelectedName(self, DCT_TEXT_OPSAVE_NONE)
	end
	UIDropDownMenu_SetWidth(self,180)
	getglobal(self:GetName().."Label"):SetText(DCT_TEXT_OPSAVE_SAVELISTDDC)
end
function DCT_Opsave_SaveListDDC_OnClick(self)
	local thisID = self:GetID()
	local thisText = self:GetText()
	UIDropDownMenu_SetSelectedID(DCTSaveOptionSaveListDDC, thisID)
	UIDropDownMenu_SetSelectedName(DCTSaveOptionSaveListDDC, thisText)
end


function DCT_Opsave_PreSetAniLoad()
	if not DCT_PRESET_ANI then return;end
	preId = UIDropDownMenu_GetSelectedID(DCTSaveOptionPreSetAniListDDC)
	DCT_Config_LoadPreSetAni(preId)
	DCT_Opani_CurFrameID = 1
	DCT_Debug(DCT_TEXT_OPSAVE_PRESETLOAD_SUCCEED..DCT_PRESET_ANI[preId]["DCT_PREANINAME"])
end

function DCT_Opsave_PreSetAniListDDC_Initialize()
	local i;
	local c;
	if not DCT_PRESET_ANI then return;end
	c = table.getn(DCT_PRESET_ANI)
	for i = 1,c do
		info = {
			text = DCT_PRESET_ANI[i]["DCT_PREANINAME"];
			func = DCT_Opsave_PreSetAniListDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end	
end
function DCT_Opsave_PreSetAniListDDC_OnShow(self)
	local sel = 1
	if DCT_Player["DCT_PREANINAME"] ~= nil then		
		local c = table.getn(DCT_PRESET_ANI)
		local i
		for i = 1, c do
			if DCT_PRESET_ANI[i]["DCT_PREANINAME"] == DCT_Player["DCT_PREANINAME"] then
				sel = i
			end
		end
	end
	
	UIDropDownMenu_Initialize(self, DCT_Opsave_PreSetAniListDDC_Initialize)
	UIDropDownMenu_SetSelectedID(self, sel)
	UIDropDownMenu_SetWidth(self,180)
	getglobal(self:GetName().."Label"):SetText(DCT_TEXT_OPSAVE_PRESETANILISTDDC)
end
function DCT_Opsave_PreSetAniListDDC_OnClick(self)
	local thisID = self:GetID()	
	UIDropDownMenu_SetSelectedID(DCTSaveOptionPreSetAniListDDC, thisID)
	--local thisText = self:GetText()
	--UIDropDownMenu_SetSelectedName(DCTSaveOptionPreSetAniListDDC, thisText)
end

function DCT_Opsave_PreSetTextLoad()
	if not DCT_PRESET_ANI then return;end
	preId = UIDropDownMenu_GetSelectedID(DCTSaveOptionPreSetTextListDDC)
	DCT_Config_LoadPreSetText(preId)
	DCT_Debug(DCT_TEXT_OPSAVE_PRESETLOAD_SUCCEED..DCT_PRESET_TEXT[preId]["DCT_PRETEXTNAME"])
	DCT_Opsave_ModFuncRun("LoadPreSet",preId)
end

function DCT_Opsave_PreSetTextListDDC_Initialize()
	local i;
	local c;
	if not DCT_PRESET_ANI then return;end
	c = table.getn(DCT_PRESET_TEXT)
	for i = 1,c do
		info = {
			text = DCT_PRESET_TEXT[i]["DCT_PRETEXTNAME"];
			func = DCT_Opsave_PreSetTextListDDC_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end	
end
function DCT_Opsave_PreSetTextListDDC_OnShow(self)
	local sel = 1
	if DCT_Player["DCT_PRETEXTNAME"] then		
		local c = table.getn(DCT_PRESET_TEXT)
		local i
		for i = 1, c do
			if DCT_PRESET_TEXT[i]["DCT_PRETEXTNAME"] == DCT_Player["DCT_PRETEXTNAME"] then
				sel = i
			end
		end
	end
	
	UIDropDownMenu_Initialize(self, DCT_Opsave_PreSetTextListDDC_Initialize)
	UIDropDownMenu_SetSelectedID(self, sel)
	UIDropDownMenu_SetWidth(self,180)
	getglobal(self:GetName().."Label"):SetText(DCT_TEXT_OPSAVE_PRESETTEXTLISTDDC)
end
function DCT_Opsave_PreSetTextListDDC_OnClick(self)
	local thisID = self:GetID()	
	UIDropDownMenu_SetSelectedID(DCTSaveOptionPreSetTextListDDC, thisID)
	--local thisText = self:GetText()
	--UIDropDownMenu_SetSelectedName(DCTSaveOptionPreSetTextListDDC, thisText)
end

function DCT_Config_LoadPreSetAni(preId)
	if not DCT_PRESET_ANI then return;end	
	
	if DCT_PRESET_ANI[preId] then	
		DCT_Merge(DCT_Player,DCT_PRESET_DEFAULT)
		if DCT_PRESET_ANI[preId]["DCT_BASE_CONFIG"] then
			local tmp = DCT_clone(getglobal(DCT_PRESET_ANI[preId]["DCT_BASE_CONFIG"]))			
			DCT_Merge(tmp,DCT_PRESET_ANI[preId])
			DCT_Merge(DCT_Player,tmp)			
		else
			DCT_Merge(DCT_Player,DCT_PRESET_ANI[preId])
		end
		local i
		for i =1,DCT_Ani_MaxFrame do
			if not DCT_Player["DCT_FRAME_CONFIG"][i] then
				DCT_Player["DCT_FRAME_CONFIG"][i] = {}
				DCT_Player["DCT_FRAME_CONFIG"][i].active = false
			end
		end
		
		DCT_ReLoadFrame()
	end	
end

function DCT_Config_LoadPreSetText(preId)
	if not DCT_PRESET_TEXT then return;end
	if DCT_PRESET_TEXT[preId] then
		DCT_Merge(DCT_Player,DCT_PRESET_TEXT[preId])
		DCT_ReLoadFrame()
	end	
end
