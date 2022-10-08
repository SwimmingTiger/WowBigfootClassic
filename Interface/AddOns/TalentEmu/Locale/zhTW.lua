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

if GetLocale() ~= "zhTW" then return;end

BINDING_NAME_ALARAIDTOOL_NEWWINDOW = "新建模擬器";
BINDING_NAME_ALARAIDTOOL_QUERY = "查看目標天賦";
BINDING_HEADER_ALATALENTEMU_HEADER = "<|cff00ff00alaTalentEmu|r>天賦模拟器";

L.Locale = "zhTW";

L.Emu = "模擬器";
L.OK = "OK";
L.Cancel = "Cancel";
L.Search = "搜索";
L.Hide = "隱藏";
L.CurTreePointsLabel = "點數";
L.CurPointsTotal = "縂點數";
L.CurPointsRemaining = "剩餘";
L.CurPointsUsed = "已用";
L.CurPointsReqLevel = "等級";
L.message = "*聊天訊息";
L.import = "導入";
L.me = "我";

L.ReadOnly = "|cffff0000只讀|r";
L.NonReadOnly = "|cff00ff00可編輯|r";
L.LabelPointsChanged = "(|cffff0000修改|r)";
L.ResetButton = "重置本欄天賦";
L.ResetAllButton = "重置所有天賦";
L.ResetToSetButton = "重置到初始狀態";
L.ReadOnlyButton = "|cff00ff00點擊|r設置";
L.CloseButton = "關閉窗體";

L.ClassButton = "\n|cff00ff00左鍵|r切換職業\n|cff00ff00右鍵|r加載保存的天賦\n|cff00ff00Shift+左鍵|r刪除保存的天賦";
L.InspectTargetButton = "觀察目標天賦";
L.SpellListButton = "技能列表窗體";
L.SpellAvailable = "|cff00ff00技能可用|r";
L.SpellUnavailable = "|cffff0000技能不可用|r";
L.TrainCost = "訓練費用 ";
L.ShowAllSpell = "显示所有等级";
L.ApplyTalentsButton = "應用當前天賦仿真";
L.ApplyTalentsButton_Notify = "确定應用當前天賦吗？";
L.ApplyTalentsFinished = "天賦已應用";
L.ImportButton = "導入字符串或wowhead/nfu/yxrank链接";
L.ExportButton = "|cff00ff00左鍵|r导出字符串\n|cff00ff00右鍵|r导出到|cffff0000wowhead/nfu|r网页链接";
L.AllData = "天賦+雕紋+裝備";
L.SaveButton = "|cff00ff00左鍵|r保存天賦设置\n|cff00ff00右鍵|r加載保存的天賦\n|cff00ff00ALT+右鍵|r加載其它角色天賦雕紋裝備\n|cff00ff00子菜單中Shift+左鍵|r删除天賦";
L.SendButton = "|cff00ff00左鍵|r发送天賦到聊天\n|cff00ff00右鍵|r查看最近聊天中的天賦";
L.EquipmentFrameButton = "打開裝備查看";

L.TalentFrameCallButton = "開啓ala天賦模擬器";
L.TalentFrameCallButtonString = "模擬器";
L.CurRank = "當前等級";
L.NextRank = "下一等級";
L.MaxRank = "最高等級";
L.ReqPoints = "%d/%d点%s";

L.AutoShowEquipmentFrame_TRUE = "自動顯示裝備列表";
L.AutoShowEquipmentFrame_FALSE = "手動顯示裝備列表";
L.Minimap_TRUE = "顯示小地圖圖標";
L.Minimap_FALSE = "隱藏小地圖圖標";
L.ResizableBorder_TRUE = "拖動窗口邊緣改變大小";
L.ResizableBorder_FALSE = "禁止拖動窗口邊緣改變大小";
L.SetWinStyle_BLZ = "設置窗口為暴雪風格";
L.SetWinStyle_ALA = "設置窗口為扁平化風格";
L.SetSingleFrame_True = "設置爲單個窗體顯示";
L.SetSingleFrame_False = "設置爲多個窗體顯示";
L.SetStyleAllTo1_ThisWin = "設置本窗體為三列顯示所有天賦";
L.SetStyleAllTo2_ThisWin = "設置本窗體為單列顯示天賦樹，通過標簽切換";
L.SetStyleAllTo1_AlsoSetShownWin = "設置本插件為三列顯示所有天賦樹（同時更改已顯示的窗體）";
L.SetStyleAllTo1_LaterWin = "設置本插件為三列顯示所有天賦樹";
L.SetStyleAllTo2_AlsoSetShownWin = "設置本插件為單列顯示天賦樹，通過標簽切換（同時更改已顯示的窗體）";
L.SetStyleAllTo2_LaterWin = "設置本插件為單列顯示天賦樹，通過標簽切換";
L.TalentsInTip_TRUE = "在鼠標提示中顯示玩家天賦";
L.TalentsInTip_FALSE = "不在鼠標提示中顯示玩家天賦";
L.TalentsInTipIcon_TRUE = "鼠標提示中使用圖標表示天賦樹";
L.TalentsInTipIcon_FALSE = "鼠標提示中使用文字表示天賦樹";
L.InspectButtonOnUnitFrame_TRUE = "開啓觀察按鈕（按住alt/ctrl/shift鍵在目標頭像上顯示觀察按鈕）";
L.InspectButtonOnUnitFrame_FALSE = "關閉觀察按鈕";
L.InsepctKey_ALT = "按住ALT鍵顯示觀察按鈕";
L.InsepctKey_CTRLK = "按住CTRL鍵顯示觀察按鈕";
L.InsepctKey_SHIFT = "按住SHIFT鍵顯示觀察按鈕";

L.DBIcon_Text = "|cff00ff00左鍵|r新建模擬器\n|cff00ff00右鍵|r打開成員檢查";
L.SpellListFrameGTTSpellLevel = "技能等級: ";
L.SpellListFrameGTTReqLevel = "需要等級: ";

L.DATA = {
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

L.RACE = "种族";
L["HUMAN|DWARF|NIGHTELF|GNOME|DRAENEI"] = "聯盟";
L["ORC|SCOURGE|TAUREN|TROLL|BLOODELF"] = "部落";
L["HUMAN"] = "人類";
L["DWARF"] = "矮人";
L["NIGHTELF"] = "暗夜精靈";
L["GNOME"] = "侏儒";
L["DRAENEI"] = "德萊尼";
L["ORC"] = "獸族";
L["SCOURGE"] = "亡靈";
L["TAUREN"] = "牛頭人";
L["TROLL"] = "巨魔";
L["BLOODELF"] = "血精靈";


L.RaidToolLableItemLevel = "裝等";
L.RaidToolLableMissItem = "裝備";
L.RaidToolLableMissEnchant = "附魔";
L.RaidToolLableBossMod = "DBM版本";
L.guildList = "公會成員";

L.SLOT = {
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
L.EMTPY_SLOT = "|cffff0000未裝備|r";
L.MISS_ENCHANT = "|cffff0000缺少附魔|r";




L["CANNOT APPLY : NEED MORE TALENT POINTS."] = "無法應用天賦: 需要更多天賦點數";
L["CANNOT APPLY : TALENTS IN CONFLICT."] = "無法應用天賦: 與當前天賦衝突";
L["CANNOT APPLY : UNABLE TO GENERATE TALENT MAP."] = "無法應用天賦: 創建天賦映射表發生錯誤";
L["CANNOT APPLY : TALENT MAP ERROR."] = "無法應用天賦: 讀取天賦映射表發生錯誤";
L["TalentDB Error : DB SIZE IS NOT EQUAL TO TalentFrame SIZE."] = "數據錯誤: 與天賦面板的天賦數量不一致";


L.PopupQuery = "查詢天賦";

--	emulib
L["WOW VERSION"] = "不是當前版本客戶端的天賦";
L["NO DECODER"] = "無法解析天賦數據";
