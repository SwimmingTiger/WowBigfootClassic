--if GetLocale() ~= "zhCN" then return;end

DCT_FONT_DEFAULT[1].name = "黑体(中英)"
DCT_FONT_DEFAULT[2].name = "楷体C(中英)"
DCT_FONT_DEFAULT[3].name = "楷体T(中英)"

DCT_FONT_DEFAULT[1].path = "Fonts\\ARHei.TTF"
DCT_FONT_DEFAULT[2].path = "Fonts\\ARKai_C.TTF"
DCT_FONT_DEFAULT[3].path = "Fonts\\ARKai_T.TTF"

DCT_DEFAULT_CFG["DCT_SHOWHIT"].show = {"-#am","-#am (#bt)"}
DCT_DEFAULT_CFG["DCT_SHOWSPELL"].show = {"-#am #c1#sn#ce","-#am #c1#sn#ce (#bt)"}
DCT_DEFAULT_CFG["DCT_SHOWHITCRIT"].show = {"-#am","-#am (#bt)"}
DCT_DEFAULT_CFG["DCT_SHOWSPELLCRIT"].show = {"-#am #c1#sn#ce","-#am #c1#sn#ce (#bt)"}
DCT_DEFAULT_CFG["DCT_SHOWPERIODIC"].show = {"-#am #sn","-#am #sn (#bt)"}
DCT_DEFAULT_CFG["DCT_SHOWHEAL"].show = {"+#am #sn","+#am {#oh} #sn"}
DCT_DEFAULT_CFG["DCT_SHOWPERIODICHEAL"].show = {"+#am #sn","+#am {#oh} #sn"}
DCT_DEFAULT_CFG["DCT_SHOWSHIELD"].show = {"-#am #sn"}
DCT_DEFAULT_CFG["DCT_SHOWDRAIN"].show = {"-#am #pt"}
DCT_DEFAULT_CFG["DCT_SHOWACTIVE"].show = {"→#sn"}
DCT_DEFAULT_CFG["DCT_SHOWFACTION"].show = {"+#am #sn 声望","#c2-#am #sn 声望#ce"}
DCT_DEFAULT_CFG["DCT_SHOWHONOR"].show = {"+#am 荣誉"}
DCT_DEFAULT_CFG["DCT_SHOWCOMBAT"].show = {"**进入战斗**"}
DCT_DEFAULT_CFG["DCT_SHOWCOMBATLEAVE"].show = {"**离开战斗**"}
DCT_DEFAULT_CFG["DCT_SHOWCP"].show = {"#am 星","#c1**#ce满星#c1**#ce"}
DCT_DEFAULT_CFG["DCT_SHOWBUFF"].show = {"获得: #sn"}
DCT_DEFAULT_CFG["DCT_SHOWDEBUFF"].show = {"不良效果: #sn"}
DCT_DEFAULT_CFG["DCT_SHOWBUFFFADE"].show = {"消失: #sn","#sn"}
DCT_DEFAULT_CFG["DCT_SHOWDEBUFFFADE"].show = {"消失:#c1#sn#ce"}
DCT_DEFAULT_CFG["DCT_SHOWBUFFDOSE"].show = {"叠加: #sn<#am>","减少: #sn<#am>"}
DCT_DEFAULT_CFG["DCT_SHOWDEBUFFDOSE"].show = {"不良叠加: #sn<#am>","不良减少: #sn<#am>"}
DCT_DEFAULT_CFG["DCT_SHOWPOWER"].show = {"+#am #pt"}
DCT_DEFAULT_CFG["DCT_SHOWENVIRONMENTAL"].show = {"-#am #et"}
DCT_DEFAULT_CFG["DCT_SHOWDISPELLED"].show = {"被驱散: #sn","被偷取: #sn"}
DCT_DEFAULT_CFG["DCT_SHOWLOWHEALTH"].show = {"生命过低 #hp"}
DCT_DEFAULT_CFG["DCT_SHOWLOWMANA"].show = {"魔法过低 #mp"}
DCT_DEFAULT_CFG["DCT_SHOWEXTRAATTACKS"].show = {"#sn x#am"}
DCT_DEFAULT_CFG["DCT_SHOWSPECBUFF"].show = {"获得: #sn","#c1获得: #sn#ce"}
DCT_DEFAULT_CFG["DCT_SHOWSPECBUFFFADE"].show = {"消失: #sn","#sn"}
DCT_DEFAULT_CFG["DCT_SHOWSPECDEBUFFFADE"].show = {"消失: #sn"}
DCT_DEFAULT_CFG["DCT_SHOWSPELLSUCCESS"].show = {"#sn! 命中!"}
DCT_DEFAULT_CFG["DCT_SHOWSPELLFAILED"].show = {"#sn 未命中!"}
DCT_DEFAULT_CFG["DCT_SHOWKILLBLOW"].show = {"击杀!"}
DCT_DEFAULT_CFG["DCT_SHOWSPECTARGETBUFF"].show = {"*-#sn-*","O_O #sn"}
DCT_DEFAULT_CFG["DCT_SHOWSPECTARGETDEBUFF"].show = {"*-#sn-*","O_O #sn"}
DCT_DEFAULT_CFG["DCT_SHOWSPECTARGETBUFFFADE"].show = {"*-#sn-*","O_O #sn"}
DCT_DEFAULT_CFG["DCT_SHOWSPECTARGETDEBUFFFADE"].show = {"*-#sn-*","O_O #sn"}
DCT_DEFAULT_CFG["DCT_SHOWCOOLDOWN"].show = {"可用:#sn"}

DCT_DEFAULT_CFG["DCT_SPECBUFF"] = {["暗影冥思"] = 1}
DCT_DEFAULT_CFG["DCT_SPECSPELLSUCCESS"] = {["佯攻"] = 1}

