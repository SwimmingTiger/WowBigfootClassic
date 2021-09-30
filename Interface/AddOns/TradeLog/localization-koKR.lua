if(GetLocale() == "koKR") then

-- ===================== Part for TradeLog ==================
TRADE_LOG_MONEY_NAME = {
    gold = "골드",
    silver = "실버",
    copper = "쿠퍼",
}

CANCEL_REASON_TEXT = {
    self = "당신이 취소했습니다",
    other = "상대방이 취소했습니다",
    toofar = "거리가 너무 멉니다",
    selfrunaway = "당신이 멀리 움직임",
    selfhideui = "당신이 UI를 숨김",
    unknown = "알수없는 이유",
}

TRADE_LOG_SUCCESS_NO_EXCHANGE = "[%t]님과 거래완료. 거래품목이 없음.";
TRADE_LOG_SUCCESS = "[%t]님과의 거래완료.";
TRADE_LOG_DETAIL = "세부사항";
TRADE_LOG_CANCELLED = "[%t]님과의 거래취소: %r.";
TRADE_LOG_FAILED = "[%t]님과의 거래실패: %r.";
TRADE_LOG_FAILED_NO_TARGET = "거래실패: %r.";
TRADE_LOG_HANDOUT = "건네줌";
TRADE_LOG_RECEIVE = "받음";
TRADE_LOG_ENCHANT = "마부";
TRADE_LOG_ITEM_NUMBER = "%d 가지";
TRADE_LOG_CHANNELS = {
    whisper = "귓속말",
    raid = "공격대",
    party = "파티",
    say = "일반",
    yell = "외침",
}
TRADE_LOG_ANNOUNCE = "알림";
TRADE_LOG_ANNOUNCE_TIP = "거래 후 자동으로 알립니다."

TRADE_LOG_RESULT_TEXT_SHORT = { 
    cancelled = "취소됨", 
    complete = "완료됨", 
    error = "실패함", 
}

TRADE_LOG_RESULT_TEXT = { 
    cancelled = "거래가 취소되었습니다", 
    complete = "거래가 완료되었습니다", 
    error = "거래가 실패했습니다", 
}

TRADE_LOG_MONTH_SUFFIX = "-"
TRADE_LOG_DAY_SUFFIX = ""

TRADE_LOG_COMPLETE_TOOLTIP = "Click to show detail";


RECENT_TRADE_TIME = "%d %s 전"
RECENT_TRADE_TITLE = "최근 거래"

-- ===================== Part for TradeList ==================
TRADE_LIST_CLEAR_HISTORY = "삭제"
TRADE_LIST_SCALE = "거래품목 창크기"
TRADE_LIST_FILTER = "완료된 거래만 보기"

TRADE_LIST_HEADER_WHEN = "시간"
TRADE_LIST_HEADER_WHO = "상대방"
TRADE_LIST_HEADER_WHERE = "위치"
TRADE_LIST_HEADER_SEND = "준것"
TRADE_LIST_HEADER_RECEIVE = "받은것"
TRADE_LIST_HEADER_RESULT = "결과"

TRADE_LIST_CLEAR_CONFIRM = "어제까지의 거래기록이 모두 삭제됩니다!";

end
