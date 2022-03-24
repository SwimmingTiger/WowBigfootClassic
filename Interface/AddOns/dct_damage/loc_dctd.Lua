if GetCVar("locale") ~= "zhCN" and DCTD_TEXT_BUTTON then return;end

DCTD_TEXT_BUTTON = ""
DCTD_TEXT_AOECOUNT = ""
DCTD_OPEX_HELP_HT = ""

DCTD_Config_Event = {
	EventFrames = {
		["DCTD_SHOWHIT"] = {x = 200,y = -65, title = "", tooltipText = ""},
		["DCTD_SHOWSPELL"] = {x = 200,y = -95, title = "", tooltipText = ""},
		["DCTD_SHOWCOMBOHIT"] = {x = 200,y = -125, title = "", tooltipText = ""},
		["DCTD_SHOWAOE"] = {x = 200,y = -155, title = "", tooltipText = ""},
		["DCTD_SHOWHEAL"] = {x = 200,y = -185, title = "", tooltipText = ""},
		["DCTD_SHOWPERIODICHEAL"] = {x = 200,y = -215, title = "", tooltipText = ""},
		["DCTD_SHOWMISS"] = {x = 200,y = -245, title = "", tooltipText = ""},
		["DCTD_SHOWINTERRUPT"] = {x = 200,y = -275, title = "", tooltipText = ""},

		["DCTD_SHOWHIT_PET"] = {x = 200,y = -305, title = "", tooltipText = ""},
		["DCTD_SHOWSPELL_PET"] = {x = 200,y = -335, title = "", tooltipText = ""},
		["DCTD_SHOWMISS_PET"] = {x = 200,y = -365, title = "", tooltipText = ""},
		["DCTD_SHOWINTERRUPT_PET"] = {x = 200,y = -395, title = "Interrupt(pet)", tooltipText = ""},

		["DCTD_SHOWHITCRIT"] = {x = 440,y = -65, title = "", tooltipText = ""},
		["DCTD_SHOWSPELLCRIT"] = {x = 440,y = -95, title = "", tooltipText = ""},
		["DCTD_SHOWCOMBOHITCRIT"] = {x = 440,y = -125, title = "", tooltipText = ""},
		["DCTD_SHOWAOEHEAL"] = {x = 440,y = -155, title = "", tooltipText = ""},
		["DCTD_SHOWHEALCRIT"] = {x = 440,y = -185, title = "", tooltipText = ""},
		["DCTD_SHOWPERIODIC"] = {x = 440,y = -215, title = "", tooltipText = ""},
		["DCTD_SHOWSHIELD"] = {x = 440,y = -245, title = "", tooltipText = ""},


		["DCTD_SHOWHITCRIT_PET"] = {x = 440,y = -305, title = "", tooltipText = ""},
		["DCTD_SHOWSPELLCRIT_PET"] = {x = 440,y = -335, title = "", tooltipText = ""},
		["DCTD_SHOWPERIODIC_PET"] = {x = 440,y = -365, title = "", tooltipText = ""},
	},

	CheckButtons = {
		["DCTD_ENABLE"] = {x = 195,y = -25, title = "Enable DCTD", tooltipText = ""},

		["DCTD_SSC_Number"] = {x = 195,y = -425, title = "", tooltipText = ""},
		["DCTD_SSC_SpellSchool"] = {x = 195,y = -455, title = "", tooltipText = ""},
		["DCTD_SSC_Spell"] = {x = 195,y = -485, title = "", tooltipText = ""},

		["DCTD_CritScale"] = {x = 435,y = -425, title = "", tooltipText = ""},
		["DCTD_AvgMulitHit"] = {x = 435,y = -455, title = "", tooltipText = ""},
	},
}

DCTD_MulitEditLabel = {
	["DCTD_SHOWHEAL"] = {"",""},
	["DCTD_SHOWPERIODICHEAL"] = {"",""},
	["DCTD_SHOWMISS"] = {"",""},
}