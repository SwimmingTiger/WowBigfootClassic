--[[--
	alex@0
--]]--
----------------------------------------------------------------------------------------------------
local ADDON, NS = ...;
NS.L = NS.L or {  };
local L = NS.L;

if GetLocale() ~= "zhTW" then return;end

BINDING_NAME_ALARAIDTOOL_NEWWINDOW = "新建仿真器";
BINDING_NAME_ALARAIDTOOL_QUERY = "查看目標天賦";
BINDING_HEADER_ALATALENTEMU_HEADER = "<\124cff00ff00alaTalentEmu\124r>天赋模拟器";

L.Locale = "zhTW";

L.Emu = "仿真器";
L.OK = "OK";
L.Cancel = "Cancel";
L.Search = "搜索";
L.Hide = "隐藏";
L.curTabPointsLabel = "點數";
L.curPointsTotal = "縂點數";
L.curPointsRemaining = "剩餘";
L.curPointsUsed = "已用";
L.curPointsReqLevel = "等級";

L.readOnly = "\124cffff0000只讀\124r";
L.notReadOnly = "\124cff00ff00可編輯\124r";
L.labelPointsChanged = "(\124cffff0000修改\124r)";
L.resetButton = "重置本欄天賦";
L.resetAllButton = "重置所有天賦";
L.resetToSetButton = "重置到初始狀態";
L.readOnlyButton = "\124cff00ff00左鍵\124r切換禁止編輯\n\124cff00ff00右鍵\124r設置窗口風格";
L.closeButton = "關閉窗體";

L.classTabButton = "\n\124cff00ff00左键\124r切换职业\n\124cff00ff00右键\124r载入预设天赋树\n    (拷自\124cffff0000wowhead\124r)";
L.inspectTargetButton = "觀察目標天賦";
L.spellTabButton = "技能列表窗口";
L.spellAvailable = "\124cff00ff00技能可用\124r";
L.spellNotAvailable = "\124cffff0000技能不可用\124r";
L.showAllSpell = "显示所有等级";
L.applyTalentsButton = "應用當前天賦仿真";
L.applyTalentsButton_Notify = "确定應用當前天賦吗？";
L.importButton = "導入字符串或wowhead/nfu链接";
L.exportButton = "\124cff00ff00左键\124r导出字符串\n\124cff00ff00右鍵\124r导出到\124cffff0000wowhead/nfu\124r网页链接";
L.saveButton = "\124cff00ff00左键\124r点击保存天赋设置\n\124cff00ff00右鍵\124r点击加载已保存的天赋\n\124cff00ff00Shift+左键\124r删除天赋";
L.equipmentButton = "打开装备查看";

L.TalentFrameCallButton = "開啓ala天賦仿真器";
L.TalentFrameCallButtonFontString = "仿真器";
L.curRank = "當前等級";
L.nextRank = "下一等級";
L.maxRank = "最高等級";

L.SetSingleFrame_True = "設置爲單個窗體顯示";
L.SetSingleFrame_False = "設置爲多個窗體顯示";
L.SetStyleAllTo1_ThisWin = "設置本窗體為三列顯示所有天賦";
L.SetStyleAllTo2_ThisWin = "設置本窗體為單列顯示天賦樹，通過標簽切換";
L.SetStyleAllTo1_AlsoSetShownWin = "設置本插件為三列顯示所有天賦樹（同時更改已顯示的窗體）";
L.SetStyleAllTo1_LaterWin = "設置本插件為三列顯示所有天賦樹";
L.SetStyleAllTo2_AlsoSetShownWin = "設置本插件為單列顯示天賦樹，通過標簽切換（同時更改已顯示的窗體）";
L.SetStyleAllTo2_LaterWin = "設置本插件為單列顯示天賦樹，通過標簽切換";
L.inspectButtonOnUnitFrame_Enable = "开启观察按钮（按住alt/ctrl/shift键在目标头像上显示观察按钮）";
L.inspectButtonOnUnitFrame_Disable = "关闭观察按钮";
L.insepctALTKEY = "按住ALT键显示观察按钮";
L.insepctCTRLKEY = "按住CTRL键显示观察按钮";
L.insepctSHIFTKEY = "按住SHIFT键显示观察按钮";

L.DBIcon_Text = "\124cff00ff00左鍵\124r新建仿真器\n\124cff00ff00右鍵\124r設置窗體風格";
L.spellTabGTTSpellLevel = "技能等级: ";
L.spellTabGTTReqLevel = "需要等级: ";

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

	H = "\124cff00ff00Healer\124r",
	D = "\124cffff0000DPS\124r",
	T = "\124cffafafffTANK\124r",
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





