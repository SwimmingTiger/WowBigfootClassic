﻿--[[--
	alex@0
--]]--
----------------------------------------------------------------------------------------------------
local ADDON, NS = ...;
NS.L = NS.L or {  };
local L = NS.L;

if GetLocale() ~= "zhCN" then return;end

BINDING_NAME_ALARAIDTOOL_NEWWINDOW = "新建模拟器";
BINDING_NAME_ALARAIDTOOL_QUERY = "查看目标天赋";
BINDING_HEADER_ALATALENTEMU_HEADER = "<\124cff00ff00alaTalentEmu\124r>天赋模拟器";

L.Locale = "zhCN";

L.Emu = "模拟器";
L.OK = "确定";
L.Cancel = "取消";
L.Search = "搜索";
L.Hide = "隐藏";
L.curTabPointsLabel = "点数";
L.curPointsTotal = "总点数";
L.curPointsRemaining = "剩余";
L.curPointsUsed = "已用";
L.curPointsReqLevel = "等级";
L.message = "信息: ";
L.me = "我";

L.readOnly = "\124cffff0000只读\124r";
L.notReadOnly = "\124cff00ff00可编辑\124r";
L.labelPointsChanged = "(\124cffff0000修改\124r)";
L.resetButton = "重置本栏天赋";
L.resetAllButton = "重置所有天赋";
L.resetToSetButton = "重置到初始状态";
L.readOnlyButton = "\124cff00ff00点击\124r设置";
L.closeButton = "关闭窗口";

L.classTabButton = "\n\124cff00ff00左键\124r切换职业\n\124cff00ff00";
L.inspectTargetButton = "观察目标天赋";
L.spellTabButton = "技能列表窗口";
L.spellAvailable = "\124cff00ff00技能可用\124r";
L.spellNotAvailable = "\124cffff0000技能不可用\124r";
L.showAllSpell = "显示所有等级";
L.applyTalentsButton = "应用当前天赋模拟";
L.applyTalentsButton_Notify = "确定应用当前天赋？";
L.importButton = "导入字符串或wowhead/nfu/yxrank链接";
L.exportButton = "\124cff00ff00左键\124r导出字符串\n\124cff00ff00右键\124r导出到\124cffff0000wowhead/nfu/yxrank\124r网页链接";
L.saveButton = "\124cff00ff00左键\124r点击保存天赋设置\n\124cff00ff00右键\124r点击加载已保存的天赋\n\124cff00ff00Shift+左键\124r删除天赋";
L.sendButton = "\124cff00ff00左键\124r点击发送天赋到聊天\n\124cff00ff00右键\124r点击查看最近聊天中的天赋";
L.equipmentButton = "打开装备查看";

L.TalentFrameCallButton = "打开ala天赋模拟器";
L.TalentFrameCallButtonFontString = "模拟器";
L.curRank = "当前等级";
L.nextRank = "下一等级";
L.maxRank = "最高等级";
L.reqPoints = "%d/%d点%s";

L.level_60 = "切换到60级天赋 |cffff0000自动重载插件|r";
L.level_70 = "切换到70级天赋 |cffff0000自动重载插件|r";
L.resizable_border_TRUE = "拖动窗口边缘可改变大小";
L.resizable_border_FALSE = "禁止拖动窗口边缘来改变大小";
L.SetWinStyle_BLZ = "设置窗口为暴雪风格";
L.SetWinStyle_ALA = "设置窗口为扁平化风格";
L.SetSingleFrame_True = "设置为单窗口显示";
L.SetSingleFrame_False = "设置为多窗口显示";
L.SetStyleAllTo1_ThisWin = "设置本窗口为三列显示所有天赋树";
L.SetStyleAllTo2_ThisWin = "设置本窗口为单列显示天赋树，通过标签切换";
L.SetStyleAllTo1_AlsoSetShownWin = "设置本插件为三列显示所有天赋树（同时更改已显示的窗口）";
L.SetStyleAllTo1_LaterWin = "设置本插件为三列显示所有天赋树";
L.SetStyleAllTo2_AlsoSetShownWin = "设置本插件为单列显示天赋树，通过标签切换（同时更改已显示的窗口）";
L.SetStyleAllTo2_LaterWin = "设置本插件为单列显示天赋树，通过标签切换";
L.TalentsInTip_TRUE = "在鼠标提示中显示玩家天赋";
L.TalentsInTip_FALSE = "不在鼠标提示中显示玩家天赋";
L.TalentsInTipIcon_TRUE = "鼠标提示中使用图标表示天赋树";
L.TalentsInTipIcon_FALSE = "鼠标提示中使用文字表示天赋树";
L.inspectButtonOnUnitFrame_Enable = "开启观察按钮（按住alt/ctrl/shift键在目标头像上显示观察按钮）";
L.inspectButtonOnUnitFrame_Disable = "关闭观察按钮";
L.insepctALTKEY = "按住ALT键显示观察按钮";
L.insepctCTRLKEY = "按住CTRL键显示观察按钮";
L.insepctSHIFTKEY = "按住SHIFT键显示观察按钮";

L.DBIcon_Text = "\124cff00ff00左键\124r新建模拟器\n\124cff00ff00右键\124r设置窗口风格";
L.spellTabGTTSpellLevel = "技能等级: ";
L.spellTabGTTReqLevel = "需要等级: ";

L.DATA = {
	talent = "天赋",

	DRUID = "德鲁伊",
	HUNTER = "猎人",
	MAGE = "法爷",
	PALADIN = "圣骑士",
	PRIEST = "牧师",
	ROGUE = "盗贼",
	SHAMAN = "傻馒",
	WARLOCK = "术士",
	WARRIOR = "屌丝战",

	[283] = "平衡",
	[281] = "野性战斗",
	[282] = "恢复",
	[361] = "野兽控制",
	[363] = "射击",
	[362] = "生存",
	[81] = "奥术",
	[41] = "火焰",
	[61] = "冰霜",
	[382] = "神圣",
	[383] = "防护",
	[381] = "惩戒",
	[201] = "戒律",
	[202] = "神圣",
	[203] = "暗影",
	[182] = "刺杀",
	[181] = "战斗",
	[183] = "敏锐",
	[261] = "元素",
	[263] = "增强",
	[262] = "恢复",
	[302] = "痛苦",
	[303] = "恶魔学识",
	[301] = "毁灭",
	[161] = "武器",
	[164] = "狂怒",
	[163] = "防护",

	H = "\124cff00ff00治疗\124r",
	D = "\124cffff0000输出\124r",
	T = "\124cffafafff坦克\124r",
	P = "\124cffff0000PVP\124r",
	E = "\124cffffff00PVE\124r",

};

L.RACE = "种族";
L.HUMAN = "人类";
L.DWARF = "矮人";
L["HUMAN|DWARF"] = "人类|矮人";
L.NIGHTELF = "暗夜精灵";
L.SCOURGE = "亡灵";
L.TROLL = "巨魔";


L.label_itemLevel = "装等";
L.label_missItem = "装备";
L.label_missEnchant = "附魔";
L.label_DBM = "DBM版本";
L.guildList = "公会成员";

L.SLOT = {
	[0] = "子弹",
	[1] = "头部",
	[2] = "颈部",
	[3] = "肩部",
	[4] = "衬衣",
	[5] = "胸甲",
	[6] = "腰带",
	[7] = "腿部",
	[8] = "靴子",
	[9] = "护腕",
	[10] = "手套",
	[11] = "戒指",
	[12] = "戒指",
	[13] = "饰品",
	[14] = "饰品",
	[15] = "披风",
	[16] = "主手",
	[17] = "副手",
	[18] = "远程",
	[19] = "战袍",
};
L.EMTPY_SLOT = "\124cffff0000未装备\124r";
L.MISS_ENCHANT = "\124cffff0000缺少附魔\124r";






L.POWERTYPE = {
	[-2] = "生命值",
	[0] = "法力值",
	[1] = "怒气",
	[2] = "集中值",
	[3] = "能量",
};
L.POWERPERCENT = "%d%%基础%s";
L.POWERPOINT = "%d点%s";
L.POWERPOINTPERSECOND = "%d点%s每秒";
L.RANGEYARD = "%d码";
L.RANGEYARD2 = "%d至%d码";
L.RANGE0 = "近战范围";
L.CASTINGTIME = "%d秒施法时间";
L.CASTINGTIMEINSTANT = "瞬发技能";
L.CDSECOND = "%d秒冷却时间";
L.CDMINUTE = "%d分钟冷却时间";
