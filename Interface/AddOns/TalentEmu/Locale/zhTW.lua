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

if GetLocale() ~= "zhTW" then return;end

BINDING_NAME_ALARAIDTOOL_NEWWINDOW = "新建模擬器";
BINDING_NAME_ALARAIDTOOL_QUERY = "查看目標天賦";
BINDING_HEADER_ALATALENTEMU_HEADER = "<|cff00ff00alaTalentEmu|r>天賦模拟器";

l10n.Locale = "zhTW";

l10n.Emu = "模擬器";
l10n.OK = "OK";
l10n.Cancel = "Cancel";
l10n.Search = "搜索";
l10n.Hide = "隱藏";
l10n.CurTreePointsLabel = "點數";
l10n.CurPointsTotal = "縂點數";
l10n.CurPointsRemaining = "剩餘";
l10n.CurPointsUsed = "已用";
l10n.CurPointsReqLevel = "等級";
l10n.message = "*聊天訊息";
l10n.import = "導入";
l10n.me = "我";

l10n.ReadOnly = "|cffff0000只讀|r";
l10n.NonReadOnly = "|cff00ff00可編輯|r";
l10n.LabelPointsChanged = "(|cffff0000修改|r)";
l10n.ResetButton = "重置本欄天賦";
l10n.ResetAllButton = "重置所有天賦";
l10n.ResetToSetButton = "重置到初始狀態";
l10n.ReadOnlyButton = "|cff00ff00點擊|r設置";
l10n.CloseButton = "關閉窗體";

l10n.ClassButton = "\n|cff00ff00左鍵|r切換職業\n|cff00ff00右鍵|r加載保存的天賦\n|cff00ff00Shift+左鍵|r刪除保存的天賦";
l10n.InspectTargetButton = "觀察目標天賦";
l10n.SpellListButton = "技能列表窗體";
l10n.SpellAvailable = "|cff00ff00技能可用|r";
l10n.SpellUnavailable = "|cffff0000技能不可用|r";
l10n.TrainCost = "訓練費用 ";
l10n.ShowAllSpell = "显示所有等级";
l10n.ApplyTalentsButton = "應用當前天賦仿真";
l10n.ApplyTalentsButton_Notify = "确定應用當前天賦吗？";
l10n.ApplyTalentsFinished = "天賦已應用";
l10n.ImportButton = "導入字符串或wowhead/nfu/yxrank链接";
l10n.ExportButton = "|cff00ff00左鍵|r导出字符串\n|cff00ff00右鍵|r导出到|cffff0000wowhead/nfu|r网页链接";
l10n.AllData = "天賦+雕紋+裝備";
l10n.SaveButton = "|cff00ff00左鍵|r保存天賦设置\n|cff00ff00右鍵|r加載保存的天賦\n|cff00ff00ALT+右鍵|r加載其它角色天賦雕紋裝備\n|cff00ff00子菜單中Shift+左鍵|r删除天賦";
l10n.SendButton = "|cff00ff00左鍵|r发送天賦到聊天\n|cff00ff00右鍵|r查看最近聊天中的天賦";
l10n.EquipmentFrameButton = "打開裝備查看";

l10n.TalentFrameCallButton = "開啓ala天賦模擬器";
l10n.TalentFrameCallButtonString = "模擬器";
l10n.CurRank = "當前等級";
l10n.NextRank = "下一等級";
l10n.MaxRank = "最高等級";
l10n.ReqPoints = "%d/%d点%s";

l10n.AutoShowEquipmentFrame_TRUE = "自動顯示裝備列表";
l10n.AutoShowEquipmentFrame_FALSE = "手動顯示裝備列表";
l10n.Minimap_TRUE = "顯示小地圖圖標";
l10n.Minimap_FALSE = "隱藏小地圖圖標";
l10n.ResizableBorder_TRUE = "拖動窗口邊緣改變大小";
l10n.ResizableBorder_FALSE = "禁止拖動窗口邊緣改變大小";
l10n.SetWinStyle_BLZ = "設置窗口為暴雪風格";
l10n.SetWinStyle_ALA = "設置窗口為扁平化風格";
l10n.SetSingleFrame_True = "設置爲單個窗體顯示";
l10n.SetSingleFrame_False = "設置爲多個窗體顯示";
l10n.SetStyleAllTo1_ThisWin = "設置本窗體為三列顯示所有天賦";
l10n.SetStyleAllTo2_ThisWin = "設置本窗體為單列顯示天賦樹，通過標簽切換";
l10n.SetStyleAllTo1_AlsoSetShownWin = "設置本插件為三列顯示所有天賦樹（同時更改已顯示的窗體）";
l10n.SetStyleAllTo1_LaterWin = "設置本插件為三列顯示所有天賦樹";
l10n.SetStyleAllTo2_AlsoSetShownWin = "設置本插件為單列顯示天賦樹，通過標簽切換（同時更改已顯示的窗體）";
l10n.SetStyleAllTo2_LaterWin = "設置本插件為單列顯示天賦樹，通過標簽切換";
l10n.TalentsInTip_TRUE = "在鼠標提示中顯示玩家天賦";
l10n.TalentsInTip_FALSE = "不在鼠標提示中顯示玩家天賦";
l10n.TalentsInTipIcon_TRUE = "鼠標提示中使用圖標表示天賦樹";
l10n.TalentsInTipIcon_FALSE = "鼠標提示中使用文字表示天賦樹";
l10n.InspectButtonOnUnitFrame_TRUE = "開啓觀察按鈕（按住alt/ctrl/shift鍵在目標頭像上顯示觀察按鈕）";
l10n.InspectButtonOnUnitFrame_FALSE = "關閉觀察按鈕";
l10n.InsepctKey_ALT = "按住ALT鍵顯示觀察按鈕";
l10n.InsepctKey_CTRLK = "按住CTRL鍵顯示觀察按鈕";
l10n.InsepctKey_SHIFT = "按住SHIFT鍵顯示觀察按鈕";

l10n.DBIcon_Text = "|cff00ff00左鍵|r新建模擬器\n|cff00ff00右鍵|r打開成員檢查";
l10n.SpellListFrameGTTSpellLevel = "技能等級: ";
l10n.SpellListFrameGTTReqLevel = "需要等級: ";

l10n.DATA = {
	talent = "天賦",

	DEATHKNIGHT = "死亡騎士",
	DRUID = "德魯伊",
	HUNTER = "獵人",
	MAGE = "法師",
	PALADIN = "聖騎士",
	PRIEST = "牧師",
	ROGUE = "盜賊",
	SHAMAN = "薩滿",
	WARLOCK = "術士",
	WARRIOR = "戰士",

	[398] = "鮮血",
	[399] = "冰霜",
	[400] = "邪惡",
	[283] = "平衡",
	[281] = "野性戰鬥",
	[282] = "恢復",
	[361] = "野獸控制",
	[363] = "射擊",
	[362] = "生存",
	[81] = "奧術",
	[41] = "火焰",
	[61] = "冰霜",
	[382] = "神聖",
	[383] = "防護",
	[381] = "懲戒",
	[201] = "戒律",
	[202] = "神聖",
	[203] = "暗影",
	[182] = "刺殺",
	[181] = "戰鬥",
	[183] = "敏銳",
	[261] = "元素",
	[263] = "增强",
	[262] = "恢復",
	[302] = "痛苦",
	[303] = "惡魔學識",
	[301] = "毀滅",
	[161] = "武器",
	[164] = "狂怒",
	[163] = "防護",

	H = "|cff00ff00Healer|r",
	D = "|cffff0000DPS|r",
	T = "|cffafafffTANK|r",
	P = "|cffff0000PVP|r",
	E = "|cffffff00PVE|r",

};

l10n.RACE = "种族";
l10n["HUMAN|DWARF|NIGHTELF|GNOME|DRAENEI"] = "聯盟";
l10n["ORC|SCOURGE|TAUREN|TROLL|BLOODELF"] = "部落";
l10n["HUMAN"] = "人類";
l10n["DWARF"] = "矮人";
l10n["NIGHTELF"] = "暗夜精靈";
l10n["GNOME"] = "侏儒";
l10n["DRAENEI"] = "德萊尼";
l10n["ORC"] = "獸族";
l10n["SCOURGE"] = "亡靈";
l10n["TAUREN"] = "牛頭人";
l10n["TROLL"] = "巨魔";
l10n["BLOODELF"] = "血精靈";


l10n.RaidToolLableItemLevel = "裝等";
l10n.RaidToolLableItemSummary = "裝備";
l10n.RaidToolLableEnchantSummary = "附魔";
l10n.RaidToolLableGemSummary = "寶石";
l10n.RaidToolLableBossModInfo = "DBM版本";
l10n.guildList = "公會成員";

l10n.SLOT = {
	[0] = "子彈",
	[1] = "頭部",
	[2] = "頸部",
	[3] = "肩部",
	[4] = "襯衣",
	[5] = "胸甲",
	[6] = "腰帶",
	[7] = "腿部",
	[8] = "靴子",
	[9] = "護腕",
	[10] = "手套",
	[11] = "戒指",
	[12] = "戒指",
	[13] = "飾品",
	[14] = "飾品",
	[15] = "披風",
	[16] = "主手",
	[17] = "副手",
	[18] = "遠程",
	[19] = "戰袍",
};
l10n.EMTPY_SLOT = "|cffff0000未裝備|r";
l10n.MISS_ENCHANT = "|cffff0000缺少附魔|r";

l10n.Gem = {
	Red = "|cffff0000紅|r",
	Blue = "|cff007fff藍|r",
	Yellow = "|cfffcff00黃|r",
	Purple = "|cffff00ff紫|r",
	Green = "|cff00ff00綠|r",
	Orange = "|cffff7f00橙|r",
	Meta = "|cffffffff彩|r",
	Prismatic = "|cffffffff棱|r",
};
l10n.MissGem = {
	["?"] = "|cff7f7f7f？|r",
	Red = "|cff7f7f7f紅|r",
	Blue = "|cff7f7f7f藍|r",
	Yellow = "|cff7f7f7f黃|r",
	Purple = "|cff7f7f7f紫|r",
	Green = "|cff7f7f7f綠|r",
	Orange = "|cff7f7f7f橙|r",
	Meta = "|cff7f7f7f彩|r",
	Prismatic = "|cff7f7f7f棱|r",
};


l10n["CANNOT APPLY : NEED MORE TALENT POINTS."] = "無法應用天賦: 需要更多天賦點數";
l10n["CANNOT APPLY : TALENTS IN CONFLICT."] = "無法應用天賦: 與當前天賦衝突";
l10n["CANNOT APPLY : UNABLE TO GENERATE TALENT MAP."] = "無法應用天賦: 創建天賦映射表發生錯誤";
l10n["CANNOT APPLY : TALENT MAP ERROR."] = "無法應用天賦: 讀取天賦映射表發生錯誤";
l10n["TalentDB Error : DB SIZE IS NOT EQUAL TO TalentFrame SIZE."] = "數據錯誤: 與天賦面板的天賦數量不一致";


l10n.PopupQuery = "查詢天賦";

--	emulib
l10n["WOW VERSION"] = "不是當前版本客戶端的天賦";
l10n["NO DECODER"] = "無法解析天賦數據";
