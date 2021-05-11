local _
if(GetLocale() == "enUS" or true) then

-- ===================== Part for TradeFrameEnchanced ==================
TBT_SPELL_RANK_PATTERN = "Rank (%d)";
TBT_SPELL_PORTAL = "Portal"
TBT_UNLOCK_SKILL_NAME="Pick Lock";
_,_,TBT_GAMETOOLTIP_MADE_BY=string.find(string.gsub(ITEM_CREATED_BY,"%%s","(.+)"),"(<.+>)"); --TBT_GAMETOOLTIP_MADE_BY="<Made by (.+)>"
TBT_SPELL_TABLE = {
	water = {
		{ name="Conjure Water", rank=1, level=0,  item="Conjured Water" },
		{ name="Conjure Water", rank=2, level=5,  item="Conjured Fresh Water" },
		{ name="Conjure Water", rank=3, level=15, item="Conjured Purified Water" },
		{ name="Conjure Water", rank=4, level=25, item="Conjured Spring Water" },
		{ name="Conjure Water", rank=5, level=35, item="Conjured Mineral Water" },
		{ name="Conjure Water", rank=6, level=45, item="Conjured Sparkling Water" },
		{ name="Conjure Water", rank=7, level=55, item="Conjured Crystal Water" },
		{ name="Conjure Water", rank=8, level=60, item="Conjured Glacier Water" },
		{ name="Conjure Water", rank=9, level=65, item="Conjured Glacier Water" },
	},

	food = {
		{ name="Conjure Food", rank=1, level=0,  item="Conjured Muffin" },
		{ name="Conjure Food", rank=2, level=5,  item="Conjured Bread" },
		{ name="Conjure Food", rank=3, level=15, item="Conjured Rye" },
		{ name="Conjure Food", rank=4, level=25, item="Conjured Pumpernickel" },
		{ name="Conjure Food", rank=5, level=35, item="Conjured Sourdough" },
		{ name="Conjure Food", rank=6, level=45, item="Conjured Sweet Roll" },
		{ name="Conjure Food", rank=7, level=55, item="Conjured Cinnamon Roll" },
		{ name="Conjure Food", rank=8, level=65, item="Conjured Croissant" },
	},

	stone = {
		{ name="Create Healthstone", rank=1, level=0,  item="Minor Healthstone" },
		{ name="Create Healthstone", rank=2, level=12, item="Lesser Healthstone" },
		{ name="Create Healthstone", rank=3, level=24, item="Healthstone" },
		{ name="Create Healthstone", rank=4, level=36, item="Greater Healthstone" },
		{ name="Create Healthstone", rank=5, level=48, item="Major Healthstone" },
		{ name="Create Healthstone", rank=6, level=60, item="Master Healthstone" },
	}
}
-- =============== just localizate the above, the addon will function ok ========================= 

TBT_PORTAL_1 = "Portal: Stonard"
TBT_PORTAL_2 = "Portal: Theramore"
TBT_PORTAL_3 = "Portal: Exodar"
TBT_PORTAL_4 = "Portal: Ironforge"
TBT_PORTAL_5 = "Portal: Orgrimmar"
TBT_PORTAL_6 = "Portal: Silvermoon"
TBT_PORTAL_7 = "Portal: Stormwind"
TBT_PORTAL_8 = "Portal: Undercity"
TBT_PORTAL_9 = "Portal: Darnassus"
TBT_PORTAL_10 = "Portal: Thunder Bluff"
TBT_PORTAL_11 = "Portal: Shattrath"
TBT_PORTAL_12 = "Portal: Dalaran"

TBT_LEFT_BUTTON = {
	water		= "Water",
	food		= "Food",
	stone		= "Stone",
	unlock		= "Lock",
}

TBT_RIGHT_BUTTON = {
	whisper		= "tel",
	ask		= "ask",
	thank		= "thx",
}
-- ===================== Part for TradeLog ==================
TRADE_LOG_MONEY_NAME = {
	gold = "g",
	silver = "s",
	copper = "c",
}

CANCEL_REASON_TEXT = {
	self = "you cancelled",
	other = "recipient cancelled",
	toofar = "too faraway",
	selfrunaway = "you moved away",
	selfhideui = "you hid ui",
	unknown = "unknown reason",
}

CANCEL_REASON_TEXT_ANNOUNCE = {
	self = "I cancelled it",
	other = "(s)he cancelled it",
	toofar = "we are too faraway",
	selfrunaway = "I moved away",
	selfhideui = "I hid ui",
	unknown = "unknown reason",
}

TRADE_LOG_SUCCESS_NO_EXCHANGE = "Trade with [%t] was COMPLETED, but no exchange made.";
TRADE_LOG_SUCCESS = "Trade with [%t] was COMPLETED.";
TRADE_LOG_DETAIL = "Detail";
TRADE_LOG_CANCELLED = "Trade with [%t] was CANCELLED: %r.";
TRADE_LOG_FAILED = "Trade with [%t] was FAILED: %r.";
TRADE_LOG_FAILED_NO_TARGET = "Trade FAILED: %r.";
TRADE_LOG_HANDOUT = "lost";
TRADE_LOG_RECEIVE = "got";
TRADE_LOG_ENCHANT = "enchant";
TRADE_LOG_ITEM_NUMBER = "%d items";
TRADE_LOG_CHANNELS = {
	whisper = "Whisper",
	raid = "Raid",
	party = "Party",
	say = "Say",
	yell = "Yell",
}
TRADE_LOG_ANNOUNCE = "NOTIFY";
TRADE_LOG_ANNOUNCE_TIP = "Check this to automatically announce after trading."

-- ===================== Part for TradeList ==================
TRADE_LIST_CLEAR_HISTORY = "CLEAR"
TRADE_LIST_SCALE = "Detail Scale"
TRADE_LIST_FILTER = "Completed Only"

TRADE_LIST_HEADER_WHEN = "Time"
TRADE_LIST_HEADER_WHO = "Recipent"
TRADE_LIST_HEADER_WHERE = "Location"
TRADE_LIST_HEADER_SEND = "Lost"
TRADE_LIST_HEADER_RECEIVE = "Got"
TRADE_LIST_HEADER_RESULT = "Result"

TRADE_LIST_RESULT_TEXT_SHORT = { 
	cancelled = "cancel", 
	complete = "ok", 
	error = "failed", 
}

TRADE_LIST_RESULT_TEXT = {
	cancelled = "Trade Cancelled", 
	complete = "Trade Completed", 
	error = "Trade Failed", 
}

TRADE_LIST_MONTH_SUFFIX = "-"
TRADE_LIST_DAY_SUFFIX = ""

TRADE_LIST_COMPLETE_TOOLTIP = "Click to show detail";

TRADE_LIST_CLEAR_CONFIRM = "Records before today will be totally cleared!";

TBT_MINIMAP_TOOLTIP1 = "The Burning Trade"
TBT_MINIMAP_TOOLTIP2 ="Click to Show Trade Log Panel"

end