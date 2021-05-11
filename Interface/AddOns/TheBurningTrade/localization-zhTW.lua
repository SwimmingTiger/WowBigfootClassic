local _
if(GetLocale() == "zhTW") then

-- ===================== Part for TradeFrameEnchanced ==================
TBT_SPELL_RANK_PATTERN = "等級 (%d)";
TBT_SPELL_PORTAL = "傳送門"
TBT_UNLOCK_SKILL_NAME="开鎖";
_,_,TBT_GAMETOOLTIP_MADE_BY=string.find(string.gsub(ITEM_CREATED_BY,"%%s","(.+)"),"(<.+>)"); --TBT_GAMETOOLTIP_MADE_BY="<由(.+)製造>"
TBT_SPELL_TABLE = {
	water = {
		{ name="造水術", rank=1, level=0,  item="魔法水" },
		{ name="造水術", rank=2, level=5,  item="魔法淡水" },
		{ name="造水術", rank=3, level=15, item="魔法純淨水" },
		{ name="造水術", rank=4, level=25, item="魔法泉水" },
		{ name="造水術", rank=5, level=35, item="魔法礦泉水" },
		{ name="造水術", rank=6, level=45, item="魔法蘇打水" },
		{ name="造水術", rank=7, level=55, item="魔法晶水" },
		{ name="造水術", rank=8, level=60, item="魔法山泉水" },
		{ name="造水術", rank=9, level=65, item="魔法冰河水" },
	},

	food = {
		{ name="造食術", rank=1, level=0,  item="魔法鬆餅" },
		{ name="造食術", rank=2, level=5,  item="魔法麵包" },
		{ name="造食術", rank=3, level=15, item="魔法黑麵包" },
		{ name="造食術", rank=4, level=25, item="魔法粗麵包" },
		{ name="造食術", rank=5, level=35, item="魔法發酵麵包" },
		{ name="造食術", rank=6, level=45, item="魔法甜麵包" },
		{ name="造食術", rank=7, level=55, item="魔法肉桂麵包" },
		{ name="造食術", rank=8, level=65, item="魔法可頌" },
	},

	stone = {
		{ name="製造治療石", rank=1, level=0,  item="初級治療石" },
		{ name="製造治療石", rank=2, level=12, item="次級治療石" },
		{ name="製造治療石", rank=3, level=24, item="治療石" },
		{ name="製造治療石", rank=4, level=36, item="強效治療石" },
		{ name="製造治療石", rank=5, level=48, item="極效治療石" },
		{ name="製造治療石", rank=6, level=60, item="極強效治療石" },
	}
}
-- =============== just localizate the above, the addon will function ok ========================= 

TBT_PORTAL_1 = "傳送門:斯通納德"
TBT_PORTAL_2 = "傳送門:塞拉摩"
TBT_PORTAL_3 = "傳送門:艾克索達"
TBT_PORTAL_4 = "傳送門:鐵爐堡"
TBT_PORTAL_5 = "傳送門:奧格瑪"
TBT_PORTAL_6 = "傳送門:銀月城"
TBT_PORTAL_7 = "傳送門:暴風城"
TBT_PORTAL_8 = "傳送門:幽暗城"
TBT_PORTAL_9 = "傳送門:達納蘇斯"
TBT_PORTAL_10 = "傳送門:雷霆崖"
TBT_PORTAL_11 = "傳送門:撒塔斯"
TBT_PORTAL_12 = "傳送門:達拉然"

TBT_LEFT_BUTTON = {
	water		= "水",
	food		= "食",
	stone		= "糖",
	unlock		= "鎖",
}

TBT_RIGHT_BUTTON = {
	whisper		= "密",
	ask		= "要",
	thank		= "謝",
}
-- ===================== Part for TradeLog ==================
TRADE_LOG_MONEY_NAME = {
	gold = "g",
	silver = "s",
	copper = "c",
}

CANCEL_REASON_TEXT = {
	self = "你取消了交易",
	other = "對方取消了交易",
	toofar = "雙方距離過遠",
	selfrunaway = "你超出了距離",
	selfhideui = "你隱藏了界面,交易窗口關閉",
	unknown = "未知原因",
}

CANCEL_REASON_TEXT_ANNOUNCE = {
	self = "我取消了交易",
	other = "對方取消了交易",
	toofar = "雙方距離過遠",
	selfrunaway = "我超出了距離",
	selfhideui = "我隱藏了界面,交易窗口關閉",
	unknown = "未知原因",
}

TRADE_LOG_SUCCESS_NO_EXCHANGE = "與[%t]交易成功, 但是沒有做任何交換。";
TRADE_LOG_SUCCESS = "與[%t]交易成功。";
TRADE_LOG_DETAIL = "詳情";
TRADE_LOG_CANCELLED = "與[%t]交易取消: %r。";
TRADE_LOG_FAILED = "與[%t]交易失敗: %r。";
TRADE_LOG_FAILED_NO_TARGET = "交易失敗: %r。";
TRADE_LOG_HANDOUT = "交出";
TRADE_LOG_RECEIVE = "收到";
TRADE_LOG_ENCHANT = "附魔";
TRADE_LOG_ITEM_NUMBER = "%d件物品";
TRADE_LOG_CHANNELS = {
	whisper = "密語",
	raid = "團隊",
	party = "小隊",
	say = "說",
	yell = "喊",
}
TRADE_LOG_ANNOUNCE = "通告";
TRADE_LOG_ANNOUNCE_TIP = "選中就會將交易信息發送到指定的頻道"

-- ===================== Part for TradeList ==================
TRADE_LIST_CLEAR_HISTORY = "清除記錄"
TRADE_LIST_SCALE = "詳情窗口縮放"
TRADE_LIST_FILTER = "僅列出成功交易"

TRADE_LIST_HEADER_WHEN = "交易時間"
TRADE_LIST_HEADER_WHO = "交易對象"
TRADE_LIST_HEADER_WHERE = "交易地點"
TRADE_LIST_HEADER_SEND = "交出"
TRADE_LIST_HEADER_RECEIVE = "獲得"
TRADE_LIST_HEADER_RESULT = "結果"

TRADE_LIST_RESULT_TEXT_SHORT = { 
	cancelled = "取消", 
	complete = "成功", 
	error = "失敗", 
}

TRADE_LIST_RESULT_TEXT = { 
	cancelled = "交易取消", 
	complete = "交易成功", 
	error = "交易失敗", 
}

TRADE_LIST_MONTH_SUFFIX = "月"
TRADE_LIST_DAY_SUFFIX = "日"

TRADE_LIST_COMPLETE_TOOLTIP = "點擊鼠標左鍵查看交易的詳細信息";

TRADE_LIST_CLEAR_CONFIRM = "今天以外的紀錄都將被清除!";

TBT_MINIMAP_TOOLTIP1 = "交易助手"
TBT_MINIMAP_TOOLTIP2 = "點擊顯示交易詳情面板"

end