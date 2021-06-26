-- Prevent tainting global _.
local _
local _G = _G

if GetLocale() == "zhCN" then 
EA_SPELL_POWER_NAME =	{
	Health			=	"生命",
	Mana			=	"法力",
	Happiness		=	"快乐值",
	Energy			=	"能量",
	Rage			=	"怒气",
	Focus			=	"集中值",
	FocusPet		=	"宠物集中",
	RunicPower		=	"符能",
	Runes			=	"符文",
	Pain			=	"痛苦值",
	Fury			=	"魔怒",
	ComboPoints		=	"连击数",
	LunarPower		=	"星界能量",
	HolyPower		=	"圣能",
	ArcaneCharges	=	"奥术充能",
	Insanity		=	"狂乱",
	Maelstrom		=	"漩涡值",
	SoulShards		=	"灵魂碎片",
	Chi				=	"真气",	
	DemonicFury		=	"恶魔之怒",
	BurningEmbers	=	"燃火餘燼",
	LifeBloom		=	"生命之花",
	}
	
EA_TTIP_SPECFLAG_CHECK = {}
for k,v in pairs(EA_SPELL_POWER_NAME) do
	EA_TTIP_SPECFLAG_CHECK[k]="開啟/關閉, 於本身BUFF框架側顯示"..v
end		

EA_XGRPALERT_POWERTYPE = "能量別:"
EA_XGRPALERT_POWERTYPES = {}
for k,v in pairs(EA_SPELL_POWER_NAME) do
	EA_XGRPALERT_POWERTYPES[#EA_XGRPALERT_POWERTYPES + 1]={}
	EA_XGRPALERT_POWERTYPES[#EA_XGRPALERT_POWERTYPES].text  = v
	EA_XGRPALERT_POWERTYPES[#EA_XGRPALERT_POWERTYPES].value = Enum.PowerType[k]	
end
		
EA_TTIP_DOALERTSOUND = "事件发生时是否播放音效."
EA_TTIP_ALERTSOUNDSELECT = "选择事件发生时所播放的音效."
EA_TTIP_LOCKFRAME = "锁定提示框架，避免被滑鼠拖拉移动."
EA_TTIP_SHARESETTINGS = "所有职业共用相同的框架位置设定."
EA_TTIP_SHOWFRAME = "显示/关闭 事件发生时的提示框架."
EA_TTIP_SHOWNAME = "显示/关闭 事件发生时的法术名称."
EA_TTIP_SHOWFLASH = "显示/关闭 事件发生时的全荧幕闪烁."
EA_TTIP_SHOWTIMER = "显示/关闭 事件发生时的法术剩余时间."
EA_TTIP_CHANGETIMER = "变更法术剩余时间的字体大小、位置."
EA_TTIP_ICONSIZE = "变更提示的图示大小."
-- EA_TTIP_ICONSPACE = "变更提示的图示间距."
-- EA_TTIP_ICONDROPDOWN = "变更提示的图示延展方向."
EA_TTIP_ALLOWESC = "变更是否可用ESC键关闭提示框架. (附注: 需重新载入UI)"
EA_TTIP_ALTALERTS = "开启/关闭 EventAlertMod 提示额外事件(非增减益的触发型技能)."

EA_TTIP_ICONXOFFSET = "调整提示框架的水平间距."
EA_TTIP_ICONYOFFSET = "调整提示框架的垂直间距."
EA_TTIP_ICONREDDEBUFF = "调整本身 Debuff 图示的红色深度."
EA_TTIP_ICONGREENDEBUFF = "调整目标 Debuff 图示的绿色深度."
EA_TTIP_ICONEXECUTION = "调整首领血量百分比的斩杀期(0%代表关闭斩杀提示)"
EA_TTIP_PLAYERLV2BOSS = "比玩家等级高2级者(如5人副本首领)也套用首领级斩杀提示"
EA_TTIP_SCD_USECOOLDOWN = "技能冷却使用倒数阴影（需重载UI才会生效）"
EA_TTIP_TAR_NEWLINE = "调整目标Debuff，是否另以单独一行显示"
EA_TTIP_TAR_ICONXOFFSET = "调整目标Debuff行与提醒框架水平间距"
EA_TTIP_TAR_ICONYOFFSET = "调整目标Debuff行与提醒框架垂直间距"
EA_TTIP_TARGET_MYDEBUFF = "调整目标Debuff行，是否仅显示玩家所施放之Debuff"
EA_TTIP_SPELLCOND_STACK = "开启/关闭, 当法术堆叠大于等于几层时才显示框架\n(可以输入的最小值由2开始)"
EA_TTIP_SPELLCOND_SELF = "开启/关闭, 只限制为玩家施放的法术, 避免监控到他人施放的相同法术"
EA_TTIP_SPELLCOND_OVERGROW = "开启/关闭, 当法术堆叠大于等于几层时以高亮显示\n(可以输入的最小值由1开始)"
EA_TTIP_SPELLCOND_REDSECTEXT = "开启/关闭, 当倒数秒数小于等于几秒时，以加大红色字体显示\n(可以输入的最小值由1开始)"
EA_TTIP_SPELLCOND_ORDERWTD = "开启/关闭, 设定显示顺序的优先比重，数字越大者，越优先显示于最内圈(可输入1至20)"

EA_TTIP_GRPCFG_ICONALPHA = "变更图示的透明度"
EA_TTIP_GRPCFG_TALENT = "限定此專精时才作用"
EA_TTIP_GRPCFG_HIDEONLEAVECOMBAT = "离开战斗后,隐藏图示"
EA_TTIP_GRPCFG_HIDEONLOSTTARGET = "没有目标时,隐藏图示"
EA_TTIP_GRPCFG_GLOWWHENTRUE = "满足条件时,高亮图示"

EA_XOPT_ICONPOSOPT = "图示位置&副资源"
EA_XOPT_SHOW_ALTFRAME = "显示主提示框架"
EA_XOPT_SHOW_BUFFNAME = "显示法术名称"
EA_XOPT_SHOW_TIMER = "显示倒数秒数"
EA_XOPT_SHOW_OMNICC = "秒数显示于框架内"
EA_XOPT_SHOW_FULLFLASH = "显示全荧幕闪烁提示"
EA_XOPT_PLAY_SOUNDALERT = "播放声音提示"
EA_XOPT_ESC_CLOSEALERT = "ESC 关闭提示"
EA_XOPT_SHOW_ALTERALERT = "显示额外提示"
EA_XOPT_SHOW_CHECKLISTALERT = "启用"
EA_XOPT_SHOW_CLASSALERT = "本职业-增减益提示"
EA_XOPT_SHOW_OTHERALERT = "跨职业-增减益提示"
EA_XOPT_SHOW_TARGETALERT = "目标的-增减益提示"
EA_XOPT_SHOW_SCDALERT = "本职业-技能CD提示"
EA_XOPT_SHOW_GROUPALERT = "本职业-条件技能提示"
EA_XOPT_OKAY = "关闭"
EA_XOPT_SAVE = "储存"
EA_XOPT_CANCEL = "取消"
EA_XOPT_VERURLTEXT = "EAM发布网址：https://reurl.cc/7r0jlD"
EA_XOPT_VERBTN1 = "GitHub"
EA_XOPT_VERURL1 = "https://github.com/ziyuefan/EventAlertMod-Classic"
EA_XOPT_SPELLCOND_STACK = "法术堆叠>=几层时显示框架:"
EA_XOPT_SPELLCOND_SELF = "只限制为玩家施放的法术"
EA_XOPT_SPELLCOND_OVERGROW = "法术堆叠>=几层时显示高亮:"
EA_XOPT_SPELLCOND_REDSECTEXT = "倒数秒数<=几秒时显示红字:"
EA_XOPT_SPELLCOND_ORDERWTD   = "显示顺序的优先比重(1-20):"

EA_XICON_LOCKFRAME = "锁定范例框架"
EA_XICON_LOCKFRAMETIP = "若要移动‘提示框架’或‘重设框架位置’时，请将‘锁定范例框架’的打勾取消"
EA_XICON_SHARESETTING = "共用框架位置设定"
EA_XICON_ICONSIZE = "图示大小"
-- EA_XICON_ICONSIZE2 = "目标图示大小"
-- EA_XICON_ICONSIZE3 = "CD图示大小"
EA_XICON_LARGE = "大"
EA_XICON_SMALL = "小"
EA_XICON_HORSPACE = "水平间距"
EA_XICON_VERSPACE = "垂直间距"
-- EA_XICON_ICONSPACE1 = "自身图示间距"
-- EA_XICON_ICONSPACE2 = "目标图示间距"
-- EA_XICON_ICONSPACE3 = "CD图示间距"
EA_XICON_MORE = "多"
EA_XICON_LESS = "少"
EA_XICON_REDDEBUFF = "本身Debuff图示红色深度"
EA_XICON_GREENDEBUFF = "目标Debuff图示绿色深度"
EA_XICON_DEEP = "深"
EA_XICON_LIGHT = "淡"
-- EA_XICON_DIRECTION = "延展方向"
-- EA_XICON_DIRUP = "上"
-- EA_XICON_DIRDOWN = "下"
-- EA_XICON_DIRLEFT = "左"
-- EA_XICON_DIRRIGHT = "右"
EA_XICON_TAR_NEWLINE = "目标Debuff以另一行显示"
EA_XICON_TAR_HORSPACE = "与提醒框架水平间距"
EA_XICON_TAR_VERSPACE = "与提醒框架垂直间距"
EA_XICON_TOGGLE_ALERTFRAME = "移动框架"
EA_XICON_RESET_FRAMEPOS = "重设框架位置"
EA_XICON_SELF_BUFF = "本身Buff"
EA_XICON_SELF_SPBUFF = "本身DeBuff(1)\n或特殊框架"
EA_XICON_SELF_DEBUFF = "本身Debuff"
EA_XICON_TARGET_BUFF = "目标Buff"
EA_XICON_TARGET_SPBUFF = "目标Buff(1)\n或特殊框架"
EA_XICON_TARGET_DEBUFF = "目标Debuff"
EA_XICON_SCD = "技能CD"
EA_XICON_EXECUTION = "提示首领级目标血量斩杀期"
EA_XICON_EXEFULL = "50%"
EA_XICON_EXECLOSE = "关闭"
EA_XICON_SCD_USECOOLDOWN = "技能冷却使用倒数阴影（需重载UI）"

EX_XCLSALERT_SELALL = "全选"
EX_XCLSALERT_CLRALL = "全不选"
EX_XCLSALERT_LOADDEFAULT = "预设"
EX_XCLSALERT_REMOVEALL = "全删"
EX_XCLSALERT_SPELL = "法术ID:"
EX_XCLSALERT_ADDSPELL = "新增"
EX_XCLSALERT_DELSPELL = "删除"
EX_XCLSALERT_HELP1 = "上面列表以[法术ID]作为排列顺序"
EX_XCLSALERT_HELP2 = "若想查询法术ID，建议输入 /eam help 指令"
EX_XCLSALERT_HELP3 = "了解在游戏中[查询法术]的各种指令。"
EX_XCLSALERT_HELP4 = "额外提醒区为非Buff类型之条件式技能"
EX_XCLSALERT_HELP5 = "例如:敌人血量进入斩杀期,或招架后使用"
EX_XCLSALERT_HELP6 = ",不会额外显示Buff,却能使用的技能。"
EX_XCLSALERT_SPELLURL = "http://www.wowhead.com/spells"

EA_XTARALERT_TARGET_MYDEBUFF = "仅限玩家施放减益"

EA_XGRPALERT_ICONALPHA = "图示透明度"
EA_XGRPALERT_GRPID = "群组ID:"
EA_XGRPALERT_TALENT1 = "专精1"
EA_XGRPALERT_TALENT2 = "专精2"
EA_XGRPALERT_TALENT3 = "专精3"
EA_XGRPALERT_TALENT4 = "专精4"
EA_XGRPALERT_HIDEONLEAVECOMBAT = "无战斗时隐藏"
EA_XGRPALERT_HIDEONLOSTTARGET = "无目标时隐藏"

EA_XGRPALERT_GLOWWHENTRUE = "满足条件时高亮"

EA_XGRPALERT_TALENTS = "不限专精"
EA_XGRPALERT_NEWSPELLBTN = "新增法术"
EA_XGRPALERT_NEWCHECKBTN = "新增父条件"
EA_XGRPALERT_NEWSUBCHECKBTN = "新增子条件"
EA_XGRPALERT_SPELLNAME = "法术名称:"
EA_XGRPALERT_SPELLICON = "法术图示:"
EA_XGRPALERT_TITLECHECK = "父条件:"
EA_XGRPALERT_TITLESUBCHECK = "子条件:"
EA_XGRPALERT_TITLEORDERUP = "提升优先度"
EA_XGRPALERT_TITLEORDERDOWN = "降低优先度"
EA_XGRPALERT_LOGICS = {
	[1]={text="并且", value=1},
	[2]={text="或者", value=0}, }
EA_XGRPALERT_EVENTTYPE = "事件类型:"
EA_XGRPALERT_EVENTTYPES = {
	[1]={text="对象能量异动类", value="UNIT_POWER_UPDATE"},
	[2]={text="对象血量异动类", value="UNIT_HEALTH"},
	[3]={text="对象增减益异动类", value="UNIT_AURA"},
	[4]={text="连击数异动类", value="UNIT_COMBO_POINTS"}, }
EA_XGRPALERT_UNITTYPE = "对象别:"
EA_XGRPALERT_UNITTYPES = {
	[1]={text="玩家", value="player"},
	[2]={text="目标", value="target"},
	[3]={text="专注目标", value="focus"},
	[4]={text="宠物", value="pet"},
	[5]={text="首领1", value="boss1"},
	[6]={text="首领2", value="boss2"},
	[7]={text="首领3", value="boss3"},
	[8]={text="首领4", value="boss4"}, 
	[9]={text="队友1", value="party1"},
	[10]={text="队友2", value="party2"},
	[11]={text="队友3", value="party3"},
	[12]={text="队友4", value="party4"},
	[13]={text="团队1", value="raid1"},
	[14]={text="团队2", value="raid2"},
	[15]={text="团队3", value="raid3"},
	[16]={text="团队4", value="raid4"},
	[17]={text="团队5", value="raid5"},
	[18]={text="团队6", value="raid6"},
	[19]={text="团队7", value="raid7"},
	[20]={text="团队8", value="raid8"},
	[21]={text="团队9", value="raid9"},
}

EA_XGRPALERT_CHECKCD = "检测法术CD:"

EA_XGRPALERT_HEALTH = "血量:"

EA_XGRPALERT_COMPARES = {
	[1]={text="<", value=1},
	[2]={text="<=", value=2},
	[3]={text="=", value=3},
	[4]={text=">=", value=4},
	[5]={text=">", value=5}, 
	[6]={text="<>", value=6}, 
	[7]={text="*", value=7}, 		--any	
}

EA_XGRPALERT_COMPARETYPES = {
	[1]={text="数值", value=1},
	[2]={text="百分比", value=2},
}
EA_XGRPALERT_CHECKAURA = "增减益:"
EA_XGRPALERT_CHECKAURAS = {
	[1]={text="存在", value=1},
	[2]={text="不存在", value=2},
}
EA_XGRPALERT_AURATIME = "时间:"
EA_XGRPALERT_AURASTACK = "堆叠:"
EA_XGRPALERT_CASTBYPLAYER = "限玩家施放"
EA_XGRPALERT_COMBOPOINT = "连击数:"

EA_XLOOKUP_START1 = "查询法术名称"
EA_XLOOKUP_START2 = "完整符合"
EA_XLOOKUP_RESULT1 = "查询法术结果"
EA_XLOOKUP_RESULT2 = "项符合"
EA_XLOAD_LOAD = "\124cffFFFF00EventAlertMod\124r:法术监控触发提示,已载入版本:\124cff00FFFF"

EA_XLOAD_FIRST_LOAD = "\124cffFF0000首次载入 EventAlertMod 特效触发提示UI，载入预设参数\124r。\n\n"..
"请使用 \124cffFFFF00/eam opt\124r 来进行参数设定、监控法术设定、调整位置。\n\n"

EA_XLOAD_NEWVERSION_LOAD = "请使用 \124cffFFFF00/eam help\124r 查阅详细指令说明。\n\n\n"..
"\124cff00FFFF- 主要更新项目 -\124r\n\n"..
"*功能新增：群组式多判断条件的事件提示功能。\n\n"..
"目前支援侦测事件为：\n"..
"1.'对象'的'能量'，'大于等于'或'小于等于'一定'值或比例'时发动\n"..
"2.'对象'的'血量'，'大于等于'或'小于等于'一定'值或比例'时发动\n"..
"3.'对象'的'Buff/Debuff'，'含有特定法术ID'(可另以层数或秒数过滤)，或'不含有特定法术ID'时发动\n"..
"4.'玩家'对于'目标'的连击点数，'大于等于'或'小于等于'一定'值'时发动\n"..
"以上所有条件可以用 AND 或 OR，一个或以上的条件来筛选。\n"..
"筛选结果为真时，则提示所指定的图案。\n"..
"" -- END OF NEWVERSION



EA_XCMD_VER = " \124cff00FFFFBy Whitep@雷鳞\124r 版本: "
EA_XCMD_DEBUG = " 模式: "
EA_XCMD_SELFLIST = " 显示自身Buff/Debuff: "
EA_XCMD_TARGETLIST = " 显示目标Debuff: "
EA_XCMD_CASTSPELL = " 显示施放法术ID: "
EA_XCMD_AUTOADD_SELFLIST = " 自动新增本身全增减益: "
EA_XCMD_ENVADD_SELFLIST = " 自动新增本身环境增减益: "
EA_XCMD_DEBUG_P0 = "触发法术清单"
EA_XCMD_DEBUG_P1 = "法术"
EA_XCMD_DEBUG_P2 = "法术ID"
EA_XCMD_DEBUG_P3 = "堆叠"
EA_XCMD_DEBUG_P4 = "持续秒数"


EA_XCMD_CMDHELP = {
	["TITLE"] = "\124cffFFFF00EventAlertMod\124r \124cff00FF00指令\124r说明(/eventalertmod or /eam):",
	["OPT"] = "\124cff00FF00/eam options(或opt)\124r - 显示/关闭 主设定视窗.",
	["HELP"] = "\124cff00FF00/eam help\124r - 显示进一步指令说明.",
	["SHOW"] = {
		"\124cff00FF00/eam show [sec]\124r -",
		"开始/停止, 持续列出 >玩家< 身上所有 Buff/Debuff 的法术ID. 并且持续时间为 sec 秒之内的法术",
	},
	["SHOWT"] = {
		"\124cff00FF00/eam showtarget(或showt) [sec]\124r -",
		"开始/停止, 持续列出 >目标< 身上所有 Debuff 的法术ID. 并且持续时间为 sec 秒之内的法术",
	},
	["SHOWC"] = {
		"\124cff00FF00/eam showcast(或showc)\124r -",
		"开始/停止, 成功施放法术之后, 列出所施放的法术ID",
	},
	["SHOWA"] = {
		"\124cff00FF00/eam showautoadd(或showa) [sec]\124r -",
		"开始/停止, 自动将 >玩家< 身上所有 Buff/Debuff 的法术加入监测清单. 并且持续时间为 sec 秒(预设为60秒)之内的法术",
	},
	["SHOWE"] = {
		"\124cff00FF00/eam showenvadd(或showe) [sec]\124r -",
		"开始/停止, 自动将 >玩家< 身上 Buff/Debuff 的法术(但排除来自团队与队伍的)加入监测清单. 并且持续时间为 sec 秒(预设为60秒)之内的法术",
	},
	["LIST"] = {
		"\124cff00FF00/eam list\124r - 显示触发法术清单",
		"显示/隐藏 show, showc, showt, lookup, lookupfull 指令的输出结果",
	},
	["LOOKUP"] = {
		"\124cff00FF00/eam lookup(或l) 查询名称\124r - 部份名称查询法术ID",
		"查询游戏中所有法术，并列出所有[部份符合]查询名称的法术ID",
	},
	["LOOKUPFULL"] = {
		"\124cff00FF00/eam lookupfull(或lf) 查询名称\124r - 完整名称查询法术ID",
		"查询游戏中所有法术，并列出所有[完整符合]查询名称的法术ID",
	},
}

end