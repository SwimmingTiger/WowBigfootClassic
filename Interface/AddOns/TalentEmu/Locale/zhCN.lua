--[[--
	alex@0
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;
local L = CT.L;

if GetLocale() ~= "zhCN" then return;end

BINDING_NAME_ALARAIDTOOL_NEWWINDOW = "新建模拟器";
BINDING_NAME_ALARAIDTOOL_QUERY = "查看目标天赋";
BINDING_HEADER_ALATALENTEMU_HEADER = "<|cff00ff00alaTalentEmu|r>天赋模拟器";

L.Locale = "zhCN";

L.Emu = "模拟器";
L.OK = "确定";
L.Cancel = "取消";
L.Search = "搜索";
L.Hide = "隐藏";
L.CurTreePointsLabel = "点数";
L.CurPointsTotal = "总点数";
L.CurPointsRemaining = "剩余";
L.CurPointsUsed = "已用";
L.CurPointsReqLevel = "等级";
L.message = "*聊天信息";
L.import = "导入";
L.me = "我";

L.ReadOnly = "|cffff0000只读|r";
L.NonReadOnly = "|cff00ff00可编辑|r";
L.LabelPointsChanged = "(|cffff0000修改|r)";
L.ResetButton = "重置本栏天赋";
L.ResetAllButton = "重置所有天赋";
L.ResetToSetButton = "重置到初始状态";
L.ReadOnlyButton = "|cff00ff00点击|r设置";
L.CloseButton = "关闭窗口";

L.ClassButton = "\n|cff00ff00左键|r切换职业\n|cff00ff00右键|r加载已保存的天赋\n|cff00ff00子菜单中Shift+左键|r删除保存的天赋";
L.InspectTargetButton = "观察目标天赋";
L.SpellListButton = "技能列表窗口";
L.SpellAvailable = "|cff00ff00技能可用|r";
L.SpellUnavailable = "|cffff0000技能不可用|r";
L.TrainCost = "训练费用 ";
L.ShowAllSpell = "显示所有等级";
L.ApplyTalentsButton = "应用当前天赋模拟";
L.ApplyTalentsButton_Notify = "确定应用当前天赋？";
L.ApplyTalentsFinished = "天赋已应用";
L.ImportButton = "导入字符串或wowhead/nfu/yxrank链接";
L.ExportButton = "|cff00ff00左键|r导出字符串\n|cff00ff00右键|r导出到|cffff0000wowhead/nfu|r网页链接";
L.AllData = "天赋+雕文+装备";
L.SaveButton = "|cff00ff00左键|r保存天赋设置\n|cff00ff00右键|r加载已保存的天赋\n|cff00ff00ALT+右键|r加载其他角色天赋雕文装备\n|cff00ff00子菜单中Shift+左键|r删除天赋";
L.SendButton = "|cff00ff00左键|r发送天赋到聊天\n|cff00ff00右键|r查看最近聊天中的天赋";
L.EquipmentFrameButton = "打开装备查看";

L.TalentFrameCallButton = "打开ala天赋模拟器";
L.TalentFrameCallButtonString = "模拟器";
L.CurRank = "当前等级";
L.NextRank = "下一等级";
L.MaxRank = "最高等级";
L.ReqPoints = "%d/%d点%s";

L.AutoShowEquipmentFrame_TRUE = "自动显示装备列表";
L.AutoShowEquipmentFrame_FALSE = "手动显示装备列表";
L.Minimap_TRUE = "显示小地图图标";
L.Minimap_FALSE = "隐藏小地图图标";
L.ResizableBorder_TRUE = "拖动窗口边缘可改变大小";
L.ResizableBorder_FALSE = "禁止拖动窗口边缘来改变大小";
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
L.InspectButtonOnUnitFrame_TRUE = "开启观察按钮（按住alt/ctrl/shift键在目标头像上显示观察按钮）";
L.InspectButtonOnUnitFrame_FALSE = "关闭观察按钮";
L.InsepctKey_ALT = "按住ALT键显示观察按钮";
L.InsepctKey_CTRLK = "按住CTRL键显示观察按钮";
L.InsepctKey_SHIFT = "按住SHIFT键显示观察按钮";

L.DBIcon_Text = "|cff00ff00左键|r新建模拟器\n|cff00ff00右键|r打开成员检查";
L.SpellListFrameGTTSpellLevel = "技能等级: ";
L.SpellListFrameGTTReqLevel = "需要等级: ";

L.DATA = {
	talent = "天赋",

	DEATHKNIGHT = "死亡骑士",
	DRUID = "德鲁伊",
	HUNTER = "猎人",
	MAGE = "法师",
	PALADIN = "圣骑士",
	PRIEST = "牧师",
	ROGUE = "盗贼",
	SHAMAN = "萨满",
	WARLOCK = "术士",
	WARRIOR = "战士",

	[398] = "鲜血",
	[399] = "冰霜",
	[400] = "邪恶",
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

	H = "|cff00ff00治疗|r",
	D = "|cffff0000输出|r",
	T = "|cffafafff坦克|r",
	P = "|cffff0000PVP|r",
	E = "|cffffff00PVE|r",

};

L.RACE = "种族";
L["HUMAN|DWARF|NIGHTELF|GNOME|DRAENEI"] = "联盟";
L["ORC|SCOURGE|TAUREN|TROLL|BLOODELF"] = "部落";
L["HUMAN"] = "人类";
L["DWARF"] = "矮人";
L["NIGHTELF"] = "暗夜精灵";
L["GNOME"] = "侏儒";
L["DRAENEI"] = "德莱尼";
L["ORC"] = "兽族";
L["SCOURGE"] = "亡灵";
L["TAUREN"] = "牛头人";
L["TROLL"] = "巨魔";
L["BLOODELF"] = "血精灵";


L.RaidToolLableItemLevel = "装等";
L.RaidToolLableMissItem = "装备";
L.RaidToolLableMissEnchant = "附魔";
L.RaidToolLableBossMod = "DBM版本";
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
L.EMTPY_SLOT = "|cffff0000未装备|r";
L.MISS_ENCHANT = "|cffff0000缺少附魔|r";




L["CANNOT APPLY : NEED MORE TALENT POINTS."] = "无法应用天赋: 需要更多天赋点数";
L["CANNOT APPLY : TALENTS IN CONFLICT."] = "无法应用天赋: 与当前天赋冲突";
L["CANNOT APPLY : UNABLE TO GENERATE TALENT MAP."] = "无法应用天赋: 创建天赋映射表发生错误";
L["CANNOT APPLY : TALENT MAP ERROR."] = "无法应用天赋: 读取天赋映射表发生错误";
L["TalentDB Error : DB SIZE IS NOT EQUAL TO TalentFrame SIZE."] = "数据错误: 与天赋面板的天赋数量不一样";


L.PopupQuery = "查询天赋";

--	emulib
L["WOW VERSION"] = "不是当前版本客户端的天赋";
L["NO DECODER"] = "无法解析天赋数据";
