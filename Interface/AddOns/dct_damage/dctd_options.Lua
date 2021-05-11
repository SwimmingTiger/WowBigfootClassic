local DCTD_ButtonRegister = false
local DCTD_DBFixed = false

function DCTD_PreSetLoad(tid)
	if DCTD_PRESET_CONFIG[tid] ~= nil then
		DCT_Merge(DCTD_DB,DCTD_PRESET_CONFIG[tid])
	end
end

function DCTD_ProFileLoad(saveName)
	if DCTD_GDB[saveName] ~= nil then
		DCTD_PERCONFIG = nil
		DCTD_PERCONFIG = DCT_clone(DCTD_GDB[saveName])
		DCTD_DB = DCTD_PERCONFIG

		DCT_DataFix(DCTD_DB,DCTD_DEFAULT_CONFIG)
		DCT_DataShowParamFix(DCTD_DB,DCTD_DEFAULT_CONFIG)
	end
end

function DCTD_ProFileSave(saveName)
	DCTD_GDB[saveName] = nil
	DCTD_GDB[saveName] = DCT_clone(DCTD_DB)
end

function DCTD_ProFileDelete(saveName)
	if DCTD_GDB[saveName] ~= nil then
		DCTD_GDB[saveName] = nil
	end
end

function DCTD_AllReset()
	DCTD_PERCONFIG = nil
	DCTD_PERCONFIG = DCT_clone(DCTD_DEFAULT_CONFIG)
	DCTD_DB = DCTD_PERCONFIG
end

function DCTD_RegistButton()
	if not DCTD_ButtonRegister then
		DCT_RegisterSavePreFixes("DCTD","DCTD_DB")
		--注册Options菜单按钮
		DCT_OptionsRegisterButton(DCTD_TEXT_BUTTON,DCTDOption,DCTD_ButtonOnClick,11,490,380)
		--注册Options菜单内配置文件存取的函数
		DCT_Opsave_RegisterProFileFunc("dct_damage",DCTD_ProFileLoad,DCTD_ProFileSave,DCTD_ProFileDelete)
		--注册Options菜单内的重置函数
		DCT_OptionsRegisterResetFunc("dct_damage",DCTD_AllReset)
		--注册Options菜单内的预设函数
		DCT_Opsave_RegisterLoadPreSetFunc("dct_damage",DCTD_PreSetLoad)

		DCTD_ButtonRegister = true
		if DCT_Opex_Help2 then
			DCT_Opex_Help2["DCTD_SHOWHIT"] = {"am","bt"}
			DCT_Opex_Help2["DCTD_SHOWSPELL"] = {"am","ic","sn","ss","bt","ba","cs"}
			DCT_Opex_Help2["DCTD_SHOWHITCRIT"] = {"am","bt"}
			DCT_Opex_Help2["DCTD_SHOWCOMBOHIT"] = {"am","ic","sn","ss"}
			DCT_Opex_Help2["DCTD_SHOWCOMBOHITCRIT"] = {"am","ic","sn","ss"}
			DCT_Opex_Help2["DCTD_SHOWSPELLCRIT"] = {"am","ic","sn","ss","bt","ba","cs"}
			DCT_Opex_Help2["DCTD_SHOWPERIODIC"] = {"am","ic","sn","ss","bt","ba","cs"}
			DCT_Opex_Help2["DCTD_SHOWHEAL"] = {"am","oh","ic","sn","di"}
			DCT_Opex_Help2["DCTD_SHOWHEALCRIT"] = {"am","oh","ic","sn","di"}
			DCT_Opex_Help2["DCTD_SHOWPERIODICHEAL"] = {"am","oh","ic","sn","cs"}
			DCT_Opex_Help2["DCTD_SHOWMISS"] = {"ms","ic","sn","cs"}
			DCT_Opex_Help2["DCTD_SHOWHIT_PET"] = {"am","bt"}
			DCT_Opex_Help2["DCTD_SHOWSPELL_PET"] = {"am","ic","sn","ss","bt","ba","cs"}
			DCT_Opex_Help2["DCTD_SHOWHITCRIT_PET"] = {"am","bt"}
			DCT_Opex_Help2["DCTD_SHOWSPELLCRIT_PET"] = {"am","ic","sn","ss","bt","ba","cs"}
			DCT_Opex_Help2["DCTD_SHOWMISS_PET"] = {"ms","ic","sn","cs"}
			DCT_Opex_Help2["DCTD_SHOWPERIODIC_PET"] = {"am","ic","sn","ss","bt","ba","cs"}
			DCT_Opex_Help2["DCTD_SHOWAOE"] = {"am","ht","ic","sn","ss","cs"}
			DCT_Opex_Help2["DCTD_SHOWAOEHEAL"] = {"am","ht","ic","sn","ss","cs"}
			DCT_Opex_Help2["DCTD_SHOWSHIELD"] = {"am","ic","sn","oi","cs"}
			DCT_Opex_Help2["DCTD_SHOWINTERRUPT"] = {"ic","sn","ss","cs"}
		end

		if DCT_Opex_MulitEditLabel then
			local k,v
			for k,v in pairs(DCTD_MulitEditLabel) do
				DCT_Opex_MulitEditLabel[k] = v
			end
		end
	end
end

function DCTD_ButtonOnClick(self)
	DCT_Opex_SetSaveP(DCTD_DB)
	DCT_OptionsFrame_Load(DCTD_Config_Event,DCTD_DB)
end

function DCTDOption_OnShow(self)
	if not DCTD_DBFixed then
		DCT_Opsave_CheckModeProfile(DCTD_GDB)
		DCTD_DBFixed = true
	end

	if not DCT_Opex_Help["ht"] then
		DCT_Opex_Help["ht"] = DCTD_OPEX_HELP_HT
	end
end

function DCTDOption_OnEvent(self, event, ...)
	local addon = ...;
	if (event == "VARIABLES_LOADED") or ( event == "ADDON_LOADED" and string.lower(addon) == "dct_damage" ) then
		DCTD_Init(self, event);
	end
end

