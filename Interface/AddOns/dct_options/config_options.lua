DCT_MAIN_OPTION = "DCT v2.46"

DCT_CHECK_ENABLE_LABEL = ""

DCT_EVENT_OPTION = "Event"
DCT_EVENT2_OPTION = "Event2"
DCT_FRAME_OPTION = "Frame"
DCT_FONT_OPTION = "Font"
DCT_SAVE_OPTION = "Profile"
DCT_MISC_OPTION = "Misc"
DCT_SPEC_OPTION = "Spec"
DCT_SPEC2_OPTION = "Spec2"

DCT_BUTTON_RESET_LABEL = ""
DCT_BUTTON_RESET_TIP= ""
DCT_BUTTON_SAVECUSTOM_LABEL = ""
DCT_BUTTON_LOADCUSTOM_LABEL = ""

DCT_EVENT_TIP1 = ""
DCT_EVENT_TIP2 = ""

DCT_RESET_TIP = "";

DCT_EVENTTYPE = {
"off",
}

DCT_OptionCfg_Base = {
["DCT_ENABLED"] = {x = 20,y = -10, title = "", tooltipText = ""},
};

DCT_OptionCfg_Event = {

	EventFrames = {
		["DCT_SHOWHIT"] = {x = 200,y = -65, title = "", tooltipText = ""},
		["DCT_SHOWHITCRIT"] = {x = 200,y = -95, title = "", tooltipText = ""},
		["DCT_SHOWHEAL"] = {x = 200,y = -125, title = "", tooltipText = ""},
		["DCT_SHOWPERIODICHEAL"] = {x = 200,y = -155, title = "", tooltipText = ""},
		["DCT_SHOWSHIELD"] = {x = 200,y = -185, title = "", tooltipText = ""},
		["DCT_SHOWKILLBLOW"] = {x = 200,y = -215, title = "", tooltipText = ""},
		["DCT_SHOWCOMBAT"] = {x = 200,y = -245, title = "", tooltipText = ""},
		["DCT_SHOWHONOR"] = {x = 200,y = -275, title = "", tooltipText = ""},
		["DCT_SHOWBUFF"] = {x = 200,y = -305, title = "", tooltipText = ""},
		["DCT_SHOWBUFFFADE"] = {x = 200,y = -335, title = "", tooltipText = ""},
		["DCT_SHOWBUFFDOSE"] = {x = 200,y = -365, title = "", tooltipText = ""},
		["DCT_SHOWENVIRONMENTAL"] = {x = 200,y = -395, title = "", tooltipText = ""},
		["DCT_SHOWDISPELLED"] = {x = 200,y = -425, title = "","", tooltipText = ""},
		["DCT_SHOWLOWHEALTH"] = {x = 200,y = -455, title = "", tooltipText = ""},



		["DCT_SHOWSPELL"] = {x = 440,y = -65, title = "", tooltipText = ""},
		["DCT_SHOWSPELLCRIT"] = {x = 440,y = -95, title = "", tooltipText = ""},
		["DCT_SHOWPERIODIC"] = {x = 440,y = -125, title = "", tooltipText = ""},
		["DCT_SHOWACTIVE"] = {x = 440,y = -155, title = "", tooltipText = ""},
		["DCT_SHOWPOWER"] = {x = 440,y = -185, title = "", tooltipText = ""},
		["DCT_SHOWCP"] = {x = 440,y = -215, title = "", tooltipText = ""},
		["DCT_SHOWCOMBATLEAVE"] = {x = 440,y = -245, title = "", tooltipText = ""},
		["DCT_SHOWDRAIN"] = {x = 440,y = -275, title = "", tooltipText = ""},
		["DCT_SHOWDEBUFF"] = {x = 440,y = -305, title = "", tooltipText = ""},
		["DCT_SHOWDEBUFFFADE"] = {x = 440,y = -335, title = "", tooltipText = ""},
		["DCT_SHOWDEBUFFDOSE"] = {x = 440,y = -365, title = "", tooltipText = ""},
		["DCT_SHOWFACTION"] = {x = 440,y = -395, title = "", tooltipText = ""},
		["DCT_SHOWEXTRAATTACKS"] = {x = 440,y = -425, title = "", tooltipText = ""},
		["DCT_SHOWLOWMANA"] = {x = 440,y = -455, title = "", tooltipText = ""},

	},
};

DCT_OptionCfg_Event2 = {

	EventFrames = {
		["DCT_SHOWDODGE"] = {x = 200,y = -65, title = DODGE, tooltipText = ""},
		["DCT_SHOWBLOCK"] = {x=200,y = -95, title = BLOCK, tooltipText = ""},
		["DCT_SHOWABSORB"] = {x = 200,y = -125, title = ABSORB, tooltipText = ""},
		["DCT_SHOWRESIST"] = {x = 200,y = -155, title = RESIST, tooltipText = ""},
		["DCT_SHOWPARRY"] = {x = 200,y = -185, title = PARRY, tooltipText = ""},


		["DCT_SHOWMISS"] = {x = 440,y = -65, title = MISS, tooltipText = ""},
		["DCT_SHOWREFLECT"] = {x = 440,y = -95, title = REFLECT, tooltipText = ""},
		["DCT_SHOWDEFLECT"] = {x = 440,y = -125, title = DEFLECT, tooltipText = ""},
		["DCT_SHOWIMMUNE"] = {x = 440,y = -155, title = IMMUNE, tooltipText = ""},
		["DCT_SHOWEVADE"] = {x = 440,y = -185, title = EVADE, tooltipText = ""},
	},
};

DCT_OptionsColorPickerEx = { };


--options_ex ********************************************************************************************************************************
--******************************************************************************************************************************************
DCT_TEXT_OPEX_FONTENDDC = ""
DCT_TEXT_OPEX_FONTCHDDC = ""
DCT_TEXT_OPEX_FONTEFFDDC = ""
DCT_TEXT_OPEX_CHECK = ""
DCT_TEXT_OPEX_CHECK_TIP = ""

DCT_Opex_FontEffTypeConfig = {"none","outLine1","outLine2","shadow1","shadow2","shadow3"}

DCT_TEXT_OPEX_COLOR = {
	"c1",
	"c2",
}

DCT_Opex_Help = {
	["am"] = "",
	["ic"] = "",
	["sn"] = "",
	["bt"] = "",
	["ba"] = "",
	["ms"] = "",
	["em"] = "",
	["oh"] = "",
	["pt"] = "",
	["ss"] = "",
	["et"] = "",
	["oi"] = "",
	["di"] = "",
	["hp"] = "",
	["mp"] = "",
	["c1"] = "",
	["c2"] = "",
	["ce"] = "",
	["ti"] = "",
	["cs"] = "",
}
--用于预览
DCT_Opex_PreviewSet = {
	["am"] = 567,
	["oh"] = 100,
	["ic"] = "Interface\\Icons\\INV_Misc_QuestionMark",
	["sn"] = "",
	["bt"] = "",
	["ba"] = 15,
	["ms"] = "DODGE",
	["pt"] = "",
	["em"] = "",
	["ss"] = 4,
	["et"] = "FALLING",
	["oi"] = "",
	["di"] = "",
}

DCT_Opex_EditHelp = ""
DCT_Opex_SoundEditTitle = ""

DCT_Opex_MulitEditLabel = {
	["DEFAULT"] = {"",""},
	["DCT_SHOWHEAL"] = {"",""},
	["DCT_SHOWPERIODICHEAL"] = {"",""},
	["DCT_SHOWCP"] = {"",""},
	["DCT_SHOWMISS"] = {"",""},
	["DCT_SHOWDISPELLED"] = {"",""},
	["DCT_SHOWBUFFFADE"] = {"",""},
	["DCT_SHOWSPECBUFF"] = {"",""},
	["DCT_SHOWSPECBUFFFADE"] = {"",""},
	["DCT_SHOWBUFFDOSE"] = {"",""},
	["DCT_SHOWDEBUFFDOSE"] = {"",""},
	["DCT_SHOWFACTION"] = {"",""},
	["DCT_SHOWLOWHEALTH"] = {"",""},
	["DCT_SHOWLOWMANA"] = {"",""},
	["DCT_SHOWSPECTARGETBUFF"] = {"",""},
	["DCT_SHOWSPECTARGETDEBUFF"] = {"",""},
	["DCT_SHOWSPECTARGETBUFFFADE"] = {"",""},
	["DCT_SHOWSPECTARGETDEBUFFFADE"] = {"",""},
}

DCT_Opex_Config = {
	Sliders = {
		["fSizeEn"] = { title = "", minValue = -24, maxValue = 24, valueStep = 1, minText="-24", maxText="24"},
		["fSizeCh"] = { title = "", minValue = -24, maxValue = 24, valueStep = 1, minText="-24", maxText="24"},
		["per"] = { title = "", minValue = 0, maxValue = 9999, valueStep = 25, minText="0", maxText="9999",tooltipText = ""},
	}
}
DCT_Opex_Low_path = { title = "", minValue = 0, maxValue = 100, valueStep = 5, minText="0%", maxText="100%",tooltipText = ""}
DCT_Opex_bufffade_path = { title = "", minValue = 0, maxValue = 10, valueStep = 1, minText="0", maxText="10",tooltipText = ""}


--options_ani ********************************************************************************************************************************
--******************************************************************************************************************************************
DCT_TEXT_OPANI_FRAMEDDC = ""
DCT_TEXT_OPANI_ANITYPEDDC = ""
DCT_TEXT_OPANI_FRAME = ""
DCT_TEXT_OPANI_ANCHORDDC = "Anchor Point:"

DCT_TEXT_OPANI_ADDFRAME = ""
DCT_TEXT_OPANI_DELETEFRAME = ""
DCT_TEXT_OPANI_BATFONT = ""
DCT_TEXT_OPANI_PREVIEW = ""

DCT_TEXT_TEST = "Test"



DCT_Opani_AniTypeConfig = {"1","2","3","4","5","6","7"}
DCT_Opani_AniTypeSimpleConfig = {"a","b","c","d","e","f","d"}
DCT_Opani_AnchorConfig = {"Center","Left","Right"}

DCT_Opani_Config = {
	Sliders = {
		["fSizeEn"] = { title = "", minValue = 10, maxValue = 60, valueStep = 1, minText="10", maxText="60"},
		["fSizeCh"] = { title = "", minValue = 10, maxValue = 60, valueStep = 1, minText="10", maxText="60"},
		["angle"] = { title = "", minValue = 0, maxValue = 355, valueStep = 5, minText="0", maxText="355"},
		["alpha"] = { title = "", minValue = 20, maxValue = 100, valueStep = 5, minText="20%", maxText="100%"},
		["speed"] = { title = "", minValue = 40, maxValue = 200, valueStep = 5, minText="40%", maxText="200%",tooltipText = ""},
		["x"] = { title = "", minValue = -800, maxValue = 800, valueStep = 20, minText="-800", maxText="800"},
		["y"] = { title = "", minValue = -800, maxValue = 800, valueStep = 20, minText="-800", maxText="800"},

	}
}

DCT_AniModeParamsSliders = {
[1] = {
Sliders = {
	["param1"] = {title = "", tooltipText = "",minValue = 0, maxValue = 355, valueStep = 5, minText="0", maxText="355",},
	["param2"] = {title = "", tooltipText = "",minValue = 50, maxValue = 400, valueStep = 10, minText="50", maxText="400",},
	["param3"] = {title = "", tooltipText = "",minValue = 0, maxValue = 355, valueStep = 5, minText="0", maxText="355",},
	["param4"] = {title = "", tooltipText = "",minValue = 0, maxValue = 400, valueStep = 10, minText="0", maxText="400",},
	["param5"] = {title = "", tooltipText = "",minValue = -50, maxValue = 50, valueStep = 5, minText="-50", maxText="+50",},
	["param6"] = {title = "", tooltipText = "",minValue = -100, maxValue = 100, valueStep = 5, minText="-50", maxText="+50",},
	},
Ddc = {
	[1] = {name = "",text = {"",""},param = "param7"},
	}
},

[2] = {
Sliders = {
	["param1"] = {title = "", tooltipText = "",minValue = 65, maxValue = 360, valueStep = 5, minText="65", maxText="360"},
	["param2"] = {title = "", tooltipText = "",minValue = 50, maxValue = 400, valueStep = 20, minText="50", maxText="400"},
	},
Ddc = {
	[1] = {name = "",text = {"",""},param = "param3"},
	[2] = {name = "",text = {"",""},param = "param4"},
	}
},

[3] = {
Sliders = {
	["param1"] = {title = "", tooltipText = "",minValue = 1, maxValue = 20, valueStep = 1, minText="1", maxText="20"},
	["param2"] = {title = "", tooltipText = "",minValue = 1, maxValue = 10, valueStep = 0.5, minText="1", maxText="10"},
	},
Ddc = {
	[1] = {name = "",text = {"",""},param = "param3"},
	[2] = {name = "",text = {"","","",""},param = "param4"},
	}
},

[4] = {
Sliders = {
	["param1"] = {title = "", tooltipText = "",minValue = 0, maxValue = 10, valueStep = 0.25, minText="1", maxText="10"},
	["param2"] = {title = "", tooltipText = "",minValue = 20, maxValue = 200, valueStep = 5, minText="20", maxText="200"},
	},
Ddc = {
	[1] = {name = "",text = {"",""},param = "param3"},
	}
},

[5] = {
Sliders = {
	["param1"] = {title = "", tooltipText = "",minValue = 200, maxValue = 500, valueStep = 10, minText="200", maxText="500"},
	},
Ddc = {
	[1] = {name = "",text = {"",""},param = "param2"},
	}
},

[6] = {
Sliders = {
	["param1"] = {title = "", tooltipText = "",minValue = 80, maxValue = 500, valueStep = 10, minText="80", maxText="500"},
	["param2"] = {title = "", tooltipText = "",minValue = 1, maxValue = 5, valueStep = 0.5, minText="1", maxText="5"},
	["param4"] = {title = "", tooltipText = "",minValue = -400, maxValue = 400, valueStep = 20, minText="-400", maxText="400"},
	},
Ddc = {
	[1] = {name = "",text = {"",""},param = "param3"},
	}
},

[7] = {
Sliders = {
	["param1"] = {title = "", tooltipText = "",minValue = 1, maxValue = 5, valueStep = 0.5, minText="1", maxText="5"},
	},
Ddc = {
	[1] = {name = "",text = {"","",""},param = "param5"},
	}
},
};


--options_font ********************************************************************************************************************************
--******************************************************************************************************************************************
DCT_TEXT_OPFONT_EDIT = ""
DCT_TEXT_OPFONT_NAME = ""
DCT_TEXT_OPFONT_PATH = ""


--options_save ********************************************************************************************************************************
--******************************************************************************************************************************************
DCT_TEXT_OPSAVE_SAVELISTDDC = ""
DCT_TEXT_OPSAVE_LOAD = ""
DCT_TEXT_OPSAVE_SAVE = ""
DCT_TEXT_OPSAVE_DELETE = ""
DCT_TEXT_OPSAVE_ADD = ""
DCT_TEXT_OPSAVE_EDIT = ""
DCT_TEXT_OPSAVE_NONE = ""

DCT_TEXT_OPSAVE_PRESETANILISTDDC = ""
DCT_TEXT_OPSAVE_PRESETTEXTLISTDDC = ""
DCT_TEXT_OPSAVE_PRESETLOAD = ""

DCT_TEXT_OPSAVE_PRESETLOAD_SUCCEED = ""

DCT_TEXT_OPSAVE_LOAD_SUCCEED = ""
DCT_TEXT_OPSAVE_SAVE_SUCCEED = ""
DCT_TEXT_OPSAVE_DELETE_SUCCEED = ""
DCT_TEXT_OPSAVE_ADD_SUCCEED = ""

DCT_TEXT_OPSAVE_LOAD_ERROR = ""
DCT_TEXT_OPSAVE_SAVE_ERROR = ""
DCT_TEXT_OPSAVE_DELETE_ERROR = ""
DCT_TEXT_OPSAVE_ADD_ERROR = ""

--options_misc********************************************************************************************************
--******************************************************************************************************************

DCT_MiscCfg_Event = {
	CheckButtons = {
		["DCT_EnglishInfo"] = {x = 185,y = -60, title = "", tooltipText = ""},
		["DCT_SSC_Number"] = {x = 435,y = -60, title = "", tooltipText = ""},
		["DCT_SSC_SpellSchool"] = {x = 435,y = -90, title = "", tooltipText = ""},
		["DCT_SSC_Spell"] = {x = 435,y = -120, title = "", tooltipText = ""},
		["DCT_HealSelfNoneName"] = {x = 185,y = -90, title = "", tooltipText = ""},
		["DCT_ManaSelfNoneName"] = {x = 185,y = -120, title = "", tooltipText = ""},
		["DCT_ZeroHp_off"] = {x = 185,y = -150, title = "", tooltipText = ""},
		["DCT_ScaleOnCrit"] = {x = 185,y = -180, title = "", tooltipText = ""},
		["DCT_UseCastBar"] = {x = 185,y = -210, title = "", tooltipText = ""},
	},

	ColorPickerExs = {
		["DCT_SSColor1"] = { x = 440,y = -155,title = STRING_SCHOOL_PHYSICAL},--支持size字段来定义大小
		["DCT_SSColor2"] = { x = 440,y = -185,title = STRING_SCHOOL_HOLY},
		["DCT_SSColor4"] = { x = 440,y = -215,title = STRING_SCHOOL_FIRE},
		["DCT_SSColor8"] = { x = 440,y = -245,title = STRING_SCHOOL_NATURE},
		["DCT_SSColor16"] = { x = 555,y = -155,title = STRING_SCHOOL_FROST},
		["DCT_SSColor32"] = { x = 555,y = -185,title = STRING_SCHOOL_SHADOW},
		["DCT_SSColor64"] = { x = 555,y = -215,title = STRING_SCHOOL_ARCANE},
	},
}

--options_spec********************************************************************************************************
--******************************************************************************************************************
DCT_TEXT_OPSPEC_DELETE = ""
DCT_TEXT_OPSPEC_ADD = ""
DCT_TEXT_OPSPEC_ADD_ERROR1 = ""
DCT_TEXT_OPSPEC_ADD_ERROR2 = ""
DCT_TEXT_OPSPEC_ADD_ERROR3 = ""
DCT_TEXT_OPSPEC_ADD_SUCCEED = ""
DCT_TEXT_OPSPEC_BUFFLISTDDC = ""
DCT_TEXT_OPSPEC_SPELLLISTDDC = ""
DCT_SpecCfg_Event = {
	EventFrames = {
		["DCT_SHOWSPECBUFF"] = {x = 200,y = -65, title = "", tooltipText = ""},

		["DCT_SHOWSPECBUFFFADE"] = {x = 200,y = -155, title = "", tooltipText = ""},
		["DCT_SHOWSPECDEBUFFFADE"] = {x = 200,y = -185, title = "", tooltipText = ""},

		["DCT_SHOWSPELLSUCCESS"] = {x = 200,y = -245, title = "", tooltipText = ""},
		["DCT_SHOWSPELLFAILED"] = {x = 200,y = -335, title = "", tooltipText = ""},

		["DCT_SHOWCOOLDOWN"] = {x = 200,y = -425, title = "", tooltipText = ""},
	},
}

DCT_SpecCfg_Event2 = {
	EventFrames = {
		["DCT_SHOWSPECTARGETBUFF"] = {x = 200,y = -65, title = "", tooltipText = ""},
		["DCT_SHOWSPECTARGETDEBUFF"] = {x = 200,y = -95, title = "", tooltipText = ""},

		["DCT_SHOWSPECTARGETBUFFFADE"] = {x = 200,y = -155, title = "", tooltipText = ""},
		["DCT_SHOWSPECTARGETDEBUFFFADE"] = {x = 200,y = -185, title = "", tooltipText = ""},
	},
}
