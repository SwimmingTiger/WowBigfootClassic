--if GetLocale() ~= "zhCN" then return;end

DCT_TEXT_PAGE = " 页"

DCT_SA_FAILED = "失败!"
DCT_SA_SUCCESS = "成功!"

DCT_SA_YOU = "你"
DCT_SA_SELF = "自己"


DCT_SA_OPTION = "法术预警模块"

DCT_SA_OPTION_ADD_SUCCESS = "过滤技能添加成功: "
DCT_SA_OPTION_ADD_FAILED = "过滤技能添加失败,可能的原因为已存在: "


DCTSA_TXT_FilterDDCList[1][1] = "开始施放/施放了-过滤","DCTSA_FILTER_CASTSTART"
DCTSA_TXT_FilterDDCList[2][1] = "效果获得/消失-过滤","DCTSA_FILTER_BUFF"
DCTSA_TXT_FilterDDCList[3][1] = "被驱散-过滤","DCTSA_FILTER_DISPELLED"
DCTSA_TXT_FilterDDCList[4][1] = "施放了-过滤","DCTSA_FILTER_CASTSUCCESS"



DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_CASTSTART_YOURTARGET"].title = "开始施放(目标)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_CASTSTART_YOURTARGET"].tooltipText = "显示你当前目标开始施放某个需要施放时间的法术"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_BUFFGET_YOURTARGET"].title = "获得效果(目标)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_BUFFGET_YOURTARGET"].tooltipText = "显示你当前目标获得某个效果"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_BUFFFADE_YOURTARGET"].title = "效果消失(目标)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_BUFFFADE_YOURTARGET"].tooltipText = "显示你当前目标消失了某个效果"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_DISPELLED_YOURTARGET"].title = "被驱散(目标)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_DISPELLED_YOURTARGET"].tooltipText = "显示你当前目标某个效果被驱散"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_CASTSUCCESS_YOURTARGET"].title = "施放了(目标)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_CASTSUCCESS_YOURTARGET"].tooltipText = "显示你当前目标施放了某个瞬发法术，不建议打开"

DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_CASTSTART_FOCUS"].title = "(焦点)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_BUFFGET_FOCUS"].title = "(焦点)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_BUFFFADE_FOCUS"].title = "(焦点)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_DISPELLED_FOCUS"].title = "(焦点)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_CASTSUCCESS_FOCUS"].title = "(焦点)"

DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_CASTSTART"].title = "(非目标)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_BUFFGET"].title = "(非目标)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_BUFFFADE"].title = "(非目标)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_DISPELLED"].title = "(非目标)"
DCT_SaCfg_Event.EventFrames["DCTSA_SHOW_CASTSUCCESS"].title = "(非目标)"



DCT_SaCfg_Event.CheckButtons["DCTSA_ENABLE"].title = "开启法术预警"
DCT_SaCfg_Event.CheckButtons["DCTSA_ENABLE"].tooltipText = "开启法术预警"
DCT_SaCfg_Event.CheckButtons["DCTSA_ENABLE_ONPVP"].title = "在友善或中立区禁用"
DCT_SaCfg_Event.CheckButtons["DCTSA_ENABLE_ONPVP"].tooltipText = "在友善或中立区禁用"
DCT_SaCfg_Event.CheckButtons["DCTSA_ENABLE_ONCOMBAT"].title = "只在战斗状态中预警"
DCT_SaCfg_Event.CheckButtons["DCTSA_ENABLE_ONCOMBAT"].tooltipText = "开启法术预警"
DCT_SaCfg_Event.CheckButtons["DCTSA_CASTSUCCESS_ONLYTOYOU"].title =  "\"施放了\"只显示对你的"
DCT_SaCfg_Event.CheckButtons["DCTSA_CASTSUCCESS_ONLYTOYOU"].tooltipText =  "此功能对\"开始施放\"无效"
DCT_SaCfg_Event.CheckButtons["DCTSA_MERGE_CASTSUCCESS_AND_BUFFGET"].title = "合并(施放了,获得了)同名技能"
DCT_SaCfg_Event.CheckButtons["DCTSA_MERGE_CASTSUCCESS_AND_BUFFGET"].tooltipText = "当对某目标\"施放了\"某技能，而那目标也同时获得了一个同名的技能，则只显示一次预警"
DCT_SaCfg_Event.CheckButtons["DCTSA_FILTER_ENABLE"].title = "开启法术过滤器"
DCT_SaCfg_Event.CheckButtons["DCTSA_FILTER_MODE"].title = "过滤模式改为\"只显示选中的技能\""
DCT_SaCfg_Event.CheckButtons["DCTSA_FILTER_MODE"].tooltipText = "当此项为关闭状态，被选中的技能将不显示。当此项为打开状态，那么只有被选中的技能才显示"
DCT_SaCfg_Event.CheckButtons["DCTSA_SSC_Spell"].title = "技能名着色"
DCT_SaCfg_Event.CheckButtons["DCTSA_SSC_Spell"].tooltipText = "使用技能名着色"
DCT_SaCfg_Event.CheckButtons["DCTSA_CASTTIME"].title = "启用\"开始施放\"计时"
