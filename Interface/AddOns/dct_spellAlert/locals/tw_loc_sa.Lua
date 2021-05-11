if GetLocale() ~= "zhTW" then return;end

DCT_TEXT_PAGE = " 頁"

DCT_SA_FAILED = "失敗!"
DCT_SA_SUCCESS = "成功!"

DCT_SA_YOU = "你"
DCT_SA_SELF = "自己"


DCT_SA_OPTION = "法術預警模組"

DCT_SA_OPTION_ADD_SUCCESS = "篩選技能添加成功: "
DCT_SA_OPTION_ADD_FAILED = "篩選技能添加失敗,可能的原因為已存在: "


DCTSA_TXT_FilterDDCList[1][1] = "開始施放/施放了-篩選","DCTSA_FILTER_CASTSTART"
DCTSA_TXT_FilterDDCList[2][1] = "效果獲得/消失-篩選","DCTSA_FILTER_BUFF"
DCTSA_TXT_FilterDDCList[3][1] = "被驅散-篩選","DCTSA_FILTER_DISPELLED"
DCTSA_TXT_FilterDDCList[4][1] = "施放了-篩選","DCTSA_FILTER_CASTSUCCESS"



DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_CASTSTART_YOURTARGET"].title = "開始施放(目標)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_CASTSTART_YOURTARGET"].tooltipText = "顯示你當前目標開始施放某個需要施放時間的法術"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_BUFFGET_YOURTARGET"].title = "獲得效果(目標)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_BUFFGET_YOURTARGET"].tooltipText = "顯示你當前目標獲得某個效果"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_BUFFFADE_YOURTARGET"].title = "效果消失(目標)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_BUFFFADE_YOURTARGET"].tooltipText = "顯示你當前目標消失了某個效果"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_DISPELLED_YOURTARGET"].title = "被驅散(目標)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_DISPELLED_YOURTARGET"].tooltipText = "顯示你當前目標某個效果被驅散"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_CASTSUCCESS_YOURTARGET"].title = "施放了(目標)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_CASTSUCCESS_YOURTARGET"].tooltipText = "顯示你當前目標施放了某個瞬發法術，不建議打開"

DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_CASTSTART_FOCUS"].title = "(集中)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_BUFFGET_FOCUS"].title = "(集中)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_BUFFFADE_FOCUS"].title = "(集中)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_DISPELLED_FOCUS"].title = "(集中)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_CASTSUCCESS_FOCUS"].title = "(集中)"

DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_CASTSTART"].title = "(非目標)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_BUFFGET"].title = "(非目標)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_BUFFFADE"].title = "(非目標)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_DISPELLED"].title = "(非目標)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_CASTSUCCESS"].title = "(非目標)"



DCT_SaCfg_Event.CheckButtons["DCTSA_ENABLE"].title = "開啟法術預警"
DCT_SaCfg_Event.CheckButtons["DCTSA_ENABLE"].tooltipText = "開啟法術預警"
DCT_SaCfg_Event.CheckButtons["DCTSA_ENABLE_ONPVP"].title = "在友善或中立區禁用"
DCT_SaCfg_Event.CheckButtons["DCTSA_ENABLE_ONPVP"].tooltipText = "在友善或中立區禁用"
DCT_SaCfg_Event.CheckButtons["DCTSA_ENABLE_ONCOMBAT"].title = "只在戰鬥狀態中預警"
DCT_SaCfg_Event.CheckButtons["DCTSA_ENABLE_ONCOMBAT"].tooltipText = "開啟法術預警"
DCT_SaCfg_Event.CheckButtons["DCTSA_CASTSUCCESS_ONLYTOYOU"].title =  "\"施放了\"只顯示對你的"
DCT_SaCfg_Event.CheckButtons["DCTSA_CASTSUCCESS_ONLYTOYOU"].tooltipText =  "此功能對\"開始施放\"無效"
DCT_SaCfg_Event.CheckButtons["DCTSA_MERGE_CASTSUCCESS_AND_BUFFGET"].title = "合併(施放了,獲得了)同名技能"
DCT_SaCfg_Event.CheckButtons["DCTSA_MERGE_CASTSUCCESS_AND_BUFFGET"].tooltipText = "當對某目標\"施放了\"某技能，而那目標也同時獲得了一個同名的技能，則只顯示一次預警"
DCT_SaCfg_Event.CheckButtons["DCTSA_FILTER_ENABLE"].title = "開啟法術篩選程式"
DCT_SaCfg_Event.CheckButtons["DCTSA_FILTER_MODE"].title = "篩選模式改為\"只顯示選中的技能\""
DCT_SaCfg_Event.CheckButtons["DCTSA_FILTER_MODE"].tooltipText = "當此項為關閉狀態，被選中的技能將不顯示。當此項為打開狀態，那麼只有被選中的技能才顯示"
DCT_SaCfg_Event.CheckButtons["DCTSA_SSC_Spell"].title = "技能名著色"
DCT_SaCfg_Event.CheckButtons["DCTSA_SSC_Spell"].tooltipText = "使用技能名著色"
DCT_SaCfg_Event.CheckButtons["DCTSA_CASTTIME"].title = "啟用\"開始施放\"計時"
