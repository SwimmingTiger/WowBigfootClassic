--[[--
	alex@0
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;
local l10n = CT.l10n;

if GetLocale() ~= "zhCN" then return;end

BINDING_NAME_ALARAIDTOOL_NEWWINDOW = "新建模拟器";
BINDING_NAME_ALARAIDTOOL_QUERY = "查看目标天赋";
BINDING_HEADER_ALATALENTEMU_HEADER = "<|cff00ff00alaTalentEmu|r>天赋模拟器";

l10n.Locale = "zhCN";

l10n.Emu = "模拟器";
l10n.OK = "确定";
l10n.Cancel = "取消";
l10n.Search = "搜索";
l10n.Hide = "隐藏";
l10n.CurTreePointsLabel = "点数";
l10n.CurPointsTotal = "总点数";
l10n.CurPointsRemaining = "剩余";
l10n.CurPointsUsed = "已用";
l10n.CurPointsReqLevel = "等级";
l10n.message = "*聊天信息";
l10n.import = "导入";
l10n.me = "我";

l10n.ReadOnly = "|cffff0000只读|r";
l10n.NonReadOnly = "|cff00ff00可编辑|r";
l10n.LabelPointsChanged = "(|cffff0000修改|r)";
l10n.ResetButton = "重置本栏天赋";
l10n.ResetAllButton = "重置所有天赋";
l10n.ResetToSetButton = "重置到初始状态";
l10n.ReadOnlyButton = "|cff00ff00点击|r设置";
l10n.CloseButton = "关闭窗口";

l10n.ClassButton = "\n|cff00ff00左键|r切换职业\n|cff00ff00右键|r加载已保存的天赋\n|cff00ff00子菜单中Shift+左键|r删除保存的天赋";
l10n.InspectTargetButton = "观察目标天赋";
l10n.SpellListButton = "技能列表窗口";
l10n.SpellAvailable = "|cff00ff00技能可用|r";
l10n.SpellUnavailable = "|cffff0000技能不可用|r";
l10n.TrainCost = "训练费用 ";
l10n.ShowAllSpell = "显示所有等级";
l10n.ApplyTalentsButton = "应用当前天赋模拟";
l10n.ApplyTalentsButton_Notify = "确定应用当前天赋？";
l10n.ApplyTalentsFinished = "天赋已应用";
l10n.ImportButton = "导入字符串或wowhead/nfu/yxrank链接";
l10n.ExportButton = "|cff00ff00左键|r导出字符串\n|cff00ff00右键|r导出到|cffff0000wowhead/nfu|r网页链接";
l10n.AllData = "天赋+雕文+装备";
l10n.SaveButton = "|cff00ff00左键|r保存天赋设置\n|cff00ff00右键|r加载已保存的天赋\n|cff00ff00ALT+右键|r加载其他角色天赋雕文装备\n|cff00ff00子菜单中Shift+左键|r删除天赋";
l10n.SendButton = "|cff00ff00左键|r发送天赋到聊天\n|cff00ff00右键|r查看最近聊天中的天赋";
l10n.EquipmentFrameButton = "打开装备查看";

l10n.TalentFrameCallButton = "打开ala天赋模拟器";
l10n.TalentFrameCallButtonString = "模拟器";
l10n.CurRank = "当前等级";
l10n.NextRank = "下一等级";
l10n.MaxRank = "最高等级";
l10n.ReqPoints = "%d/%d点%s";

l10n.AutoShowEquipmentFrame_TRUE = "自动显示装备列表";
l10n.AutoShowEquipmentFrame_FALSE = "手动显示装备列表";
l10n.Minimap_TRUE = "显示小地图图标";
l10n.Minimap_FALSE = "隐藏小地图图标";
l10n.ResizableBorder_TRUE = "拖动窗口边缘可改变大小";
l10n.ResizableBorder_FALSE = "禁止拖动窗口边缘来改变大小";
l10n.SetWinStyle_BLZ = "设置窗口为暴雪风格";
l10n.SetWinStyle_ALA = "设置窗口为扁平化风格";
l10n.SetSingleFrame_True = "设置为单窗口显示";
l10n.SetSingleFrame_False = "设置为多窗口显示";
l10n.SetStyleAllTo1_ThisWin = "设置本窗口为三列显示所有天赋树";
l10n.SetStyleAllTo2_ThisWin = "设置本窗口为单列显示天赋树，通过标签切换";
l10n.SetStyleAllTo1_AlsoSetShownWin = "设置本插件为三列显示所有天赋树（同时更改已显示的窗口）";
l10n.SetStyleAllTo1_LaterWin = "设置本插件为三列显示所有天赋树";
l10n.SetStyleAllTo2_AlsoSetShownWin = "设置本插件为单列显示天赋树，通过标签切换（同时更改已显示的窗口）";
l10n.SetStyleAllTo2_LaterWin = "设置本插件为单列显示天赋树，通过标签切换";
l10n.TalentsInTip_TRUE = "在鼠标提示中显示玩家天赋";
l10n.TalentsInTip_FALSE = "不在鼠标提示中显示玩家天赋";
l10n.TalentsInTipIcon_TRUE = "鼠标提示中使用图标表示天赋树";
l10n.TalentsInTipIcon_FALSE = "鼠标提示中使用文字表示天赋树";
l10n.InspectButtonOnUnitFrame_TRUE = "开启观察按钮（按住alt/ctrl/shift键在目标头像上显示观察按钮）";
l10n.InspectButtonOnUnitFrame_FALSE = "关闭观察按钮";
l10n.InsepctKey_ALT = "按住ALT键显示观察按钮";
l10n.InsepctKey_CTRLK = "按住CTRL键显示观察按钮";
l10n.InsepctKey_SHIFT = "按住SHIFT键显示观察按钮";

l10n.DBIcon_Text = "|cff00ff00左键|r新建模拟器\n|cff00ff00右键|r打开成员检查";
l10n.SpellListFrameGTTSpellLevel = "技能等级: ";
l10n.SpellListFrameGTTReqLevel = "需要等级: ";

l10n.DATA = {
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

l10n.RACE = "种族";
l10n["HUMAN|DWARF|NIGHTELF|GNOME|DRAENEI"] = "联盟";
l10n["ORC|SCOURGE|TAUREN|TROLL|BLOODELF"] = "部落";
l10n["HUMAN"] = "人类";
l10n["DWARF"] = "矮人";
l10n["NIGHTELF"] = "暗夜精灵";
l10n["GNOME"] = "侏儒";
l10n["DRAENEI"] = "德莱尼";
l10n["ORC"] = "兽族";
l10n["SCOURGE"] = "亡灵";
l10n["TAUREN"] = "牛头人";
l10n["TROLL"] = "巨魔";
l10n["BLOODELF"] = "血精灵";


l10n.RaidToolLableItemLevel = "装等";
l10n.RaidToolLableItemSummary = "装备";
l10n.RaidToolLableEnchantSummary = "附魔";
l10n.RaidToolLableGemSummary = "宝石";
l10n.RaidToolLableBossModInfo = "DBM版本";
l10n.guildList = "公会成员";

l10n.SLOT = {
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
l10n.EMTPY_SLOT = "|cffff0000未装备|r";
l10n.MISS_ENCHANT = "|cffff0000缺少附魔|r";

l10n.Gem = {
	Red = "|cffff0000红|r",
	Blue = "|cff007fff蓝|r",
	Yellow = "|cffffcf00黄|r",
	Purple = "|cffff00ff紫|r",
	Green = "|cff00ff00绿|r",
	Orange = "|cffff7f00橙|r",
	Meta = "|cffffffff彩|r",
	Prismatic = "|cffffffff棱|r",
};
l10n.MissGem = {
	["?"] = "|cff7f7f7f？|r",
	Red = "|cff7f7f7f红|r",
	Blue = "|cff7f7f7f蓝|r",
	Yellow = "|cff7f7f7f黄|r",
	Purple = "|cff7f7f7f紫|r",
	Green = "|cff7f7f7f绿|r",
	Orange = "|cff7f7f7f橙|r",
	Meta = "|cff7f7f7f彩|r",
	Prismatic = "|cff7f7f7f棱|r",
};


l10n["CANNOT APPLY : NEED MORE TALENT POINTS."] = "无法应用天赋: 需要更多天赋点数";
l10n["CANNOT APPLY : TALENTS IN CONFLICT."] = "无法应用天赋: 与当前天赋冲突";
l10n["CANNOT APPLY : UNABLE TO GENERATE TALENT MAP."] = "无法应用天赋: 创建天赋映射表发生错误";
l10n["CANNOT APPLY : TALENT MAP ERROR."] = "无法应用天赋: 读取天赋映射表发生错误";
l10n["TalentDB Error : DB SIZE IS NOT EQUAL TO TalentFrame SIZE."] = "数据错误: 与天赋面板的天赋数量不一样";


l10n.PopupQuery = "查询天赋";

--	emulib
l10n["WOW VERSION"] = "不是当前版本客户端的天赋";
l10n["NO DECODER"] = "无法解析天赋数据";
