if GetLocale() ~= "zhTW" then return;end
DCTSA_DEFAULT_CONFIG["DCTSA_SHOW_CASTSTART_YOURTARGET"].show = {"#c1★#ce施放 #c2#sn#ce"}
DCTSA_DEFAULT_CONFIG["DCTSA_SHOW_CASTSTART"].show = {"#c1#oi#ce施放 #c2#sn#ce"}
DCTSA_DEFAULT_CONFIG["DCTSA_SHOW_CASTSTART_FOCUS"].show = {"#c1◇#ce施放 #c2#sn#ce"}
DCTSA_DEFAULT_CONFIG["DCTSA_SHOW_BUFFGET_YOURTARGET"].show = {"#c1★#ce獲得了#c2#sn#ce"}
DCTSA_DEFAULT_CONFIG["DCTSA_SHOW_BUFFGET_FOCUS"].show = {"#c1◇#ce獲得了#c2#sn#ce"}
DCTSA_DEFAULT_CONFIG["DCTSA_SHOW_BUFFGET"].show = {"#c1#oi#ce獲得了#c2#sn#ce"}
DCTSA_DEFAULT_CONFIG["DCTSA_SHOW_BUFFFADE_YOURTARGET"].show = {"#c1★#ce#c2#sn#ce消失了"}
DCTSA_DEFAULT_CONFIG["DCTSA_SHOW_BUFFFADE_FOCUS"].show = {"#c1◇#ce #c2#sn#ce消失了"}
DCTSA_DEFAULT_CONFIG["DCTSA_SHOW_BUFFFADE"].show = {"#c1#oi#ce #c2#sn#ce消失了"}
DCTSA_DEFAULT_CONFIG["DCTSA_SHOW_DISPELLED_YOURTARGET"].show = {"#c1★#ce#c2#sn#ce被驅散"}
DCTSA_DEFAULT_CONFIG["DCTSA_SHOW_DISPELLED_FOCUS"].show = {"#c1◇#ce #c2#sn#ce被驅散"}
DCTSA_DEFAULT_CONFIG["DCTSA_SHOW_DISPELLED"].show = {"#c1#oi#ce #c2#sn#ce被驅散"}
DCTSA_DEFAULT_CONFIG["DCTSA_SHOW_CASTSUCCESS_YOURTARGET"].show = {"#c1★對[#di]#ce施放了 #c2#sn#ce"}
DCTSA_DEFAULT_CONFIG["DCTSA_SHOW_CASTSUCCESS_FOCUS"].show = {"#c1◇ 對[#di]#ce施放了 #c2#sn#ce"}
DCTSA_DEFAULT_CONFIG["DCTSA_SHOW_CASTSUCCESS"].show = {"#c1#oi 對[#di]#ce施放了 #c2#sn#ce"}


DCTSA_PRESET_TEXT = {
	[1] = {
		["DCTSA_SHOW_CASTSTART_YOURTARGET"] = {show = {"#c1★#ce施放 #c2#sn#ce"}},
		["DCTSA_SHOW_CASTSTART_FOCUS"] = {show = {"#c1◇#ce施放 #c2#sn#ce"}},
		["DCTSA_SHOW_CASTSTART"] = {show = {"#c1#oi#ce施放 #c2#sn#ce"}},
		["DCTSA_SHOW_BUFFGET_YOURTARGET"] = {show = {"#c1★#ce獲得了#c2#sn#ce"}},
		["DCTSA_SHOW_BUFFGET_FOCUS"] = {show = {"#c1◇#ce獲得了#c2#sn#ce"}},
		["DCTSA_SHOW_BUFFGET"] = {show = {"#c1#oi#ce獲得了#c2#sn#ce"}},
		["DCTSA_SHOW_BUFFFADE_YOURTARGET"] = {show = {"#c1★#ce#c2#sn#ce消失了"}},
		["DCTSA_SHOW_BUFFFADE_FOCUS"] = {show = {"#c1◇#ce #c2#sn#ce消失了"}},
		["DCTSA_SHOW_BUFFFADE"] = {show = {"#c1#oi#ce #c2#sn#ce消失了"}},
		["DCTSA_SHOW_DISPELLED_YOURTARGET"] = {show = {"#c1★#ce#c2#sn#ce被驅散"}},
		["DCTSA_SHOW_DISPELLED_FOCUS"] = {show = {"#c1◇#ce #c2#sn#ce被驅散"}},
		["DCTSA_SHOW_DISPELLED"] = {show = {"#c1#oi#ce #c2#sn#ce被驅散"}},
		["DCTSA_SHOW_CASTSUCCESS_YOURTARGET"] = {show = {"#c1★對[#di]#ce施放了 #c2#sn#ce"}},
		["DCTSA_SHOW_CASTSUCCESS_FOCUS"] = {show = {"#c1◇ 對[#di]#ce施放了 #c2#sn#ce"}},
		["DCTSA_SHOW_CASTSUCCESS"] = {show = {"#c1#oi 對[#di]#ce施放了 #c2#sn#ce"}},
	},
	[2] = {
		["DCTSA_SHOW_CASTSTART_YOURTARGET"] = {show = {"#ic#c1★#ce施放 #c2#sn#ce"}},
		["DCTSA_SHOW_CASTSTART_FOCUS"] = {show = {"#ic#c1◇#ce施放 #c2#sn#ce"}},
		["DCTSA_SHOW_CASTSTART"] = {show = {"#ic#c1#oi#ce施放 #c2#sn#ce"}},
		["DCTSA_SHOW_BUFFGET_YOURTARGET"] = {show = {"#ic#c1★#ce獲得了#c2#sn#ce"}},
		["DCTSA_SHOW_BUFFGET_FOCUS"] = {show = {"#ic#c1◇#ce獲得了#c2#sn#ce"}},
		["DCTSA_SHOW_BUFFGET"] = {show = {"#ic#c1#oi#ce獲得了#c2#sn#ce"}},
		["DCTSA_SHOW_BUFFFADE_YOURTARGET"] = {show = {"#ic#c1★#ce#c2#sn#ce消失了"}},
		["DCTSA_SHOW_BUFFFADE_FOCUS"] = {show = {"#ic#c1◇#ce #c2#sn#ce消失了"}},
		["DCTSA_SHOW_BUFFFADE"] = {show = {"#ic#c1#oi#ce#c2#sn#ce消失了"}},
		["DCTSA_SHOW_DISPELLED_YOURTARGET"] = {show = {"#ic#c1★#ce#c2#sn#ce被驅散"}},
		["DCTSA_SHOW_DISPELLED_FOCUS"] = {show = {"#ic#c1◇#ce #c2#sn#ce被驅散"}},
		["DCTSA_SHOW_DISPELLED"] = {show = {"#ic#c1#oi#ce#c2#sn#ce被驅散"}},
		["DCTSA_SHOW_CASTSUCCESS_YOURTARGET"] = {show = {"#ic#c1★對[#di]#ce施放了 #c2#sn#ce"}},
		["DCTSA_SHOW_CASTSUCCESS_FOCUS"] = {show = {"#ic#c1◇ 對[#di]#ce施放了 #c2#sn#ce"}},
		["DCTSA_SHOW_CASTSUCCESS"] = {show = {"#ic#c1#oi 對[#di]#ce施放了 #c2#sn#ce"}},

	},
	[3] = {

	},
	[4] = {
		["DCTSA_SHOW_CASTSTART_YOURTARGET"] = {show = {"#c1★#ce施放 #c2#sn#ce#ic"}},
		["DCTSA_SHOW_CASTSTART_FOCUS"] = {show = {"#c1◇#ce施放 #c2#sn#ce#ic"}},
		["DCTSA_SHOW_CASTSTART"] = {show = {"#c1#oi#ce施放 #c2#sn#ce#ic"}},
		["DCTSA_SHOW_BUFFGET_YOURTARGET"] = {show = {"#c1★#ce獲得了#c2#sn#ce#ic"}},
		["DCTSA_SHOW_BUFFGET_FOCUS"] = {show = {"#c1◇#ce獲得了#c2#sn#ce#ic"}},
		["DCTSA_SHOW_BUFFGET"] = {show = {"#c1#oi#ce獲得了#c2#sn#ce#ic"}},
		["DCTSA_SHOW_BUFFFADE_YOURTARGET"] = {show = {"#c1★#ce#c2#sn#ce消失了#ic"}},
		["DCTSA_SHOW_BUFFFADE_FOCUS"] = {show = {"#c1◇#ce #c2#sn#ce消失了#ic"}},
		["DCTSA_SHOW_BUFFFADE"] = {show = {"#c1#oi#ce#c2#sn#ce消失了#ic"}},
		["DCTSA_SHOW_DISPELLED_YOURTARGET"] = {show = {"#c1★#ce#c2#sn#ce被驅散#ic"}},
		["DCTSA_SHOW_DISPELLED_FOCUS"] = {show = {"#c1◇#ce #c2#sn#ce被驅散#ic"}},
		["DCTSA_SHOW_DISPELLED"] = {show = {"#c1#oi#ce#c2#sn#ce被驅散#ic"}},
		["DCTSA_SHOW_CASTSUCCESS_YOURTARGET"] = {show = {"#c1★對[#di]#ce施放了 #c2#sn#ce#ic"}},
		["DCTSA_SHOW_CASTSUCCESS_FOCUS"] = {show = {"#c1◇ 對[#di]#ce施放了 #c2#sn#ce#ic"}},
		["DCTSA_SHOW_CASTSUCCESS"] = {show = {"#c1#oi 對[#di]#ce施放了 #c2#sn#ce#ic"}},
	},

	[5] = {
		["DCTSA_SHOW_CASTSTART_YOURTARGET"] = {show = {"#c1★#ce施放 #c2#sn#ce"}},
		["DCTSA_SHOW_CASTSTART_FOCUS"] = {show = {"#c1◇#ce施放 #c2#sn#ce"}},
		["DCTSA_SHOW_CASTSTART"] = {show = {"#c1#oi#ce施放 #c2#sn#ce"}},
		["DCTSA_SHOW_BUFFGET_YOURTARGET"] = {show = {"#c1★#ce獲得#c2#sn#ce"}},
		["DCTSA_SHOW_BUFFGET_FOCUS"] = {show = {"#c1◇#ce獲得#c2#sn#ce"}},
		["DCTSA_SHOW_BUFFGET"] = {show = {"#c1#oi#ce獲得#c2#sn#ce"}},
		["DCTSA_SHOW_BUFFFADE_YOURTARGET"] = {show = {"#c1★#ce#c2#sn#ce消失"}},
		["DCTSA_SHOW_BUFFFADE_FOCUS"] = {show = {"#c1◇#ce #c2#sn#ce消失"}},
		["DCTSA_SHOW_BUFFFADE"] = {show = {"#c1#oi#ce#c2#sn#ce消失"}},
		["DCTSA_SHOW_DISPELLED_YOURTARGET"] = {show = {"#c1★#ce#c2#sn#ce被驅散"}},
		["DCTSA_SHOW_DISPELLED_FOCUS"] = {show = {"#c1◇#ce #c2#sn#ce被驅散"}},
		["DCTSA_SHOW_DISPELLED"] = {show = {"#c1#oi#ce#c2#sn#ce被驅散"}},
		["DCTSA_SHOW_CASTSUCCESS_YOURTARGET"] = {show = {"#c1★對[#di]#ce施放了 #c2#sn#ce"}},
		["DCTSA_SHOW_CASTSUCCESS_FOCUS"] = {show = {"#c1◇ 對[#di]#ce施放了 #c2#sn#ce"}},
		["DCTSA_SHOW_CASTSUCCESS"] = {show = {"#c1#oi 對[#di]#ce施放了 #c2#sn#ce"}},
	},

	[6] = {

	},
}

