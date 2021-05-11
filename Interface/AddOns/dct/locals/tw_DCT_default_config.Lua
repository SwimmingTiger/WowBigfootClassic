if GetLocale() ~= "zhTW" then return;end

DCT_FONT_DEFAULT[1].name = "黑體(中英)"
DCT_FONT_DEFAULT[2].name = "楷體(中英)"
DCT_FONT_DEFAULT[3].name = "隸書(中英)"

DCT_FONT_DEFAULT[1].path = "Fonts\\bHEI00M.TTF"
DCT_FONT_DEFAULT[2].path = "Fonts\\bKAI00M.TTF"
DCT_FONT_DEFAULT[3].path = "Fonts\\blei00d.TTF"

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
DCT_DEFAULT_CFG["DCT_SHOWFACTION"].show = {"+#am #sn 聲望","#c2-#am #sn 聲望#ce"}
DCT_DEFAULT_CFG["DCT_SHOWHONOR"].show = {"+#am 榮譽"}
DCT_DEFAULT_CFG["DCT_SHOWCOMBAT"].show = {"**進入戰鬥**"}
DCT_DEFAULT_CFG["DCT_SHOWCOMBATLEAVE"].show = {"**離開戰鬥**"}
DCT_DEFAULT_CFG["DCT_SHOWCP"].show = {"#am 星","#c1**#ce滿星#c1**#ce"}
DCT_DEFAULT_CFG["DCT_SHOWBUFF"].show = {"獲得: #sn"}
DCT_DEFAULT_CFG["DCT_SHOWDEBUFF"].show = {"不良效果: #sn"}
DCT_DEFAULT_CFG["DCT_SHOWBUFFFADE"].show = {"消失: #sn","#sn"}
DCT_DEFAULT_CFG["DCT_SHOWDEBUFFFADE"].show = {"消失:#c1#sn#ce"}
DCT_DEFAULT_CFG["DCT_SHOWBUFFDOSE"].show = {"疊加: #sn<#am>","減少: #sn<#am>"}
DCT_DEFAULT_CFG["DCT_SHOWDEBUFFDOSE"].show = {"不良疊加: #sn<#am>","不良減少: #sn<#am>"}
DCT_DEFAULT_CFG["DCT_SHOWPOWER"].show = {"+#am #pt"}
DCT_DEFAULT_CFG["DCT_SHOWENVIRONMENTAL"].show = {"-#am #et"}
DCT_DEFAULT_CFG["DCT_SHOWDISPELLED"].show = {"被驅散: #sn","被偷取: #sn"}
DCT_DEFAULT_CFG["DCT_SHOWLOWHEALTH"].show = {"生命過低 #hp"}
DCT_DEFAULT_CFG["DCT_SHOWLOWMANA"].show = {"魔法過低 #mp"}
DCT_DEFAULT_CFG["DCT_SHOWEXTRAATTACKS"].show = {"#sn x#am"}
DCT_DEFAULT_CFG["DCT_SHOWSPECBUFF"].show = {"獲得: #sn","#c1獲得: #sn#ce"}
DCT_DEFAULT_CFG["DCT_SHOWSPECBUFFFADE"].show = {"消失: #sn","#sn"}
DCT_DEFAULT_CFG["DCT_SHOWSPECDEBUFFFADE"].show = {"消失: #sn"}
DCT_DEFAULT_CFG["DCT_SHOWSPELLSUCCESS"].show = {"#sn! 命中!"}
DCT_DEFAULT_CFG["DCT_SHOWSPELLFAILED"].show = {"#sn 未命中!"}
DCT_DEFAULT_CFG["DCT_SHOWKILLBLOW"].show = {"擊殺!"}
DCT_DEFAULT_CFG["DCT_SHOWSPECTARGETBUFF"].show = {"*-#sn-*","O_O #sn"}
DCT_DEFAULT_CFG["DCT_SHOWSPECTARGETDEBUFF"].show = {"*-#sn-*","O_O #sn"}
DCT_DEFAULT_CFG["DCT_SHOWSPECTARGETBUFFFADE"].show = {"*-#sn-*","O_O #sn"}
DCT_DEFAULT_CFG["DCT_SHOWSPECTARGETDEBUFFFADE"].show = {"*-#sn-*","O_O #sn"}
DCT_DEFAULT_CFG["DCT_SHOWCOOLDOWN"].show = {"可用:#sn"}

DCT_DEFAULT_CFG["DCT_SPECBUFF"] = {["暗影冥思"] = 1}
DCT_DEFAULT_CFG["DCT_SPECSPELLSUCCESS"] = {["佯攻"] = 1}

