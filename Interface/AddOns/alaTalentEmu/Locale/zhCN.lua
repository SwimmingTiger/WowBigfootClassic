--[[--
	alex@0
--]]--
----------------------------------------------------------------------------------------------------
local ADDON, NS = ...;
NS.L = NS.L or {  };
local L = NS.L;

if GetLocale() ~= "zhCN" then return;end

BINDING_NAME_ALARAIDTOOL_NEWWINDOW = "新建模拟器";
BINDING_NAME_ALARAIDTOOL_QUERY = "查看目标天赋";

L.Locale = "zhCN";

L.Emu = "模拟器";
L.OK = "确定";
L.Cancel = "取消";
L.curTabPointsLabel = "点数";
L.curPointsTotal = "总点数";
L.curPointsRemaining = "剩余";
L.curPointsUsed = "已用";
L.curPointsReqLevel = "等级";
L.readOnly = "\124cffff0000只读\124r";
L.notReadOnly = "\124cff00ff00可编辑\124r";
L.labelPointsChanged = "(\124cffff0000修改\124r)";
L.resetButton = "重置本栏天赋";
L.resetAllButton = "重置所有天赋";
L.resetToSetButton = "重置到初始状态";
L.readOnlyButton = "\124cff00ff00左键\124r切换禁止编辑\n\124cff00ff00右键\124r设置窗口风格";
L.closeButton = "关闭窗口";
L.classTabButton = "\n\124cff00ff00左键\124r切换职业\n\124cff00ff00右键\124r载入预设天赋树\n    (拷自\124cffff0000wowhead\124r)";
L.inspectTargetButton = "观察目标天赋";
L.applyTalentsButton = "应用当前天赋模拟";
L.applyTalentsButton_Notify = "确定应用当前天赋？";
L.importButton = "导入字符串";
L.exportButton = "\124cff00ff00左键\124r导出字符串\n\124cff00ff00右键\124r导出到\124cffff0000wowhead/nfu\124r网页链接";
L.saveButton = "\124cff00ff00左键\124r点击保存天赋设置\n\124cff00ff00右键\124r点击加载已保存的天赋\n\124cff00ff00Shift+左键\124r删除天赋";
L.TalentFrameCallButton = "打开ala天赋模拟器";
L.TalentFrameCallButtonFontString = "模拟器";
L.curRank = "当前等级";
L.nextRank = "下一等级";
L.maxRank = "最高等级";
L.SetSingleFrame_True = "设置为单窗口显示";
L.SetSingleFrame_False = "设置为多窗口显示";
L.SetStyleAllTo1_ThisWin = "设置本窗口为三列显示所有天赋树";
L.SetStyleAllTo2_ThisWin = "设置本窗口为单列显示天赋树，通过标签切换";
L.SetStyleAllTo1_AlsoSetShownWin = "设置本插件为三列显示所有天赋树（同时更改已显示的窗口）";
L.SetStyleAllTo1_LaterWin = "设置本插件为三列显示所有天赋树";
L.SetStyleAllTo2_AlsoSetShownWin = "设置本插件为单列显示天赋树，通过标签切换（同时更改已显示的窗口）";
L.SetStyleAllTo2_LaterWin = "设置本插件为单列显示天赋树，通过标签切换";
L.inspectButtonOnUnitFrame_Enable = "开启观察按钮（按住alt/ctrl/shift键在目标头像上显示观察按钮）";
L.inspectButtonOnUnitFrame_Disable = "关闭观察按钮";
L.insepctALTKEY = "按住ALT键显示观察按钮";
L.insepctCTRLKEY = "按住CTRL键显示观察按钮";
L.insepctSHIFTKEY = "按住SHIFT键显示观察按钮";
L.DBIcon_Text = "\124cff00ff00左键\124r新建模拟器\n\124cff00ff00右键\124r设置窗口风格";

L.DATA = {
	talent = "天赋",

	druid = "德鲁伊",
	hunter = "猎人",
	mage = "法爷",
	paladin = "圣骑士",
	priest = "牧师",
	rogue = "盗贼",
	shaman = "傻馒",
	warlock = "术士",
	warrior = "屌丝战",

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





