if GetLocale() ~= "zhTW" then return;end

DCT_CHECK_ENABLE_LABEL = "啟動戰鬥指示器"

DCT_EVENT_OPTION = "受到的事件";
DCT_EVENT2_OPTION = "受到的事件2";
DCT_FRAME_OPTION = "動畫框架";
DCT_FONT_OPTION = "字體自定義";
DCT_SAVE_OPTION = "預設和配置檔"
DCT_MISC_OPTION = "其他設置"
DCT_SPEC_OPTION = "特定事件1"
DCT_SPEC_OPTION2 = "特定事件2"

DCT_BUTTON_RESET_LABEL = "恢復默認設置";
DCT_BUTTON_RESET_TIP= "恢復默認設置";
DCT_BUTTON_SAVECUSTOM_LABEL = "保存個性設置"
DCT_BUTTON_LOADCUSTOM_LABEL = "讀取個性設置"

DCT_EVENT_TIP1 = "點擊選擇輸出動畫框架，數位代表動畫框架的編號"
DCT_EVENT_TIP2 = "點擊編輯具體顯示文字及其他一些相關的詳細設置"

DCT_RESET_TIP = "已載入默認設置";

DCT_OptionCfg_Base["DCT_ENABLED"].title = "啟動戰鬥指示器"
DCT_OptionCfg_Base["DCT_ENABLED"].tooltipText = "啟動戰鬥指示器"



DCT_OptionCfg_Event.EventFrames["DCT_SHOWHIT"].title = "傷害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWHIT"].tooltipText = "顯示你受到的傷害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWHITCRIT"].title = "傷害(爆擊)"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWHITCRIT"].tooltipText = "顯示你受到的爆擊傷害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWHEAL"].title = "治療"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWHEAL"].tooltipText = "顯示你受到的治療"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWPERIODICHEAL"].title = "持續治療"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWPERIODICHEAL"].tooltipText = "顯示你受到的持續性治療"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWCOMBAT"].title = "進入戰鬥"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWCOMBAT"].tooltipText = "顯示進入狀態"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWCOMBATLEAVE"].title = "離開戰鬥"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWCOMBATLEAVE"].tooltipText = "顯示進入狀態"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWHONOR"].title = "榮譽獲得"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWHONOR"].tooltipText = "顯示你的榮譽獲得"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWBUFF"].title = "有益效果獲得"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWBUFF"].tooltipText = "顯示你獲得的有益效果"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWBUFFFADE"].title = "有益效果消失"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWBUFFFADE"].tooltipText = "顯示你消失的有益效果"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWBUFFDOSE"].title = "有益效果疊加"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWBUFFDOSE"].tooltipText = "顯示你的有益效果疊加及減少"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWENVIRONMENTAL"].title = "環境傷害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWENVIRONMENTAL"].tooltipText = "比如溺水掉落等"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDISPELLED"].title = "被驅散,偷取"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDISPELLED"].tooltipText = "被驅散，偷取"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWLOWHEALTH"].title = "生命過低"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWLOWHEALTH"].tooltipText = "生命值低於設定的百分比則顯示"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWSHIELD"].title = "反射傷害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWSHIELD"].tooltipText = "反射傷害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWKILLBLOW"].title = "擊殺"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWKILLBLOW"].tooltipText = "如果因為你的攻擊殺死了目標，則顯示擊殺字樣"


DCT_OptionCfg_Event.EventFrames["DCT_SHOWSPELL"].title = "技能傷害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWSPELL"].tooltipText = "顯示你受到的技能傷害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWSPELLCRIT"].title = "技能傷害(爆擊)"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWSPELLCRIT"].tooltipText = "顯示你受到的技能爆擊傷害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWPERIODIC"].title = "持續傷害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWPERIODIC"].tooltipText = "顯示你受到的來自當前目標的持續傷害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWACTIVE"].title = "技能啟動"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWACTIVE"].tooltipText = "顯示你的某技能啟動"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWPOWER"].title = "能量獲得"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWPOWER"].tooltipText = "顯示獲得的能量，魔法值等"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWCP"].title = "連擊點"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWCP"].tooltipText = "顯示你獲得的連擊點"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDRAIN"].title = "法力流失"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDRAIN"].tooltipText = "顯示你被流失的法力"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDEBUFF"].title = "不良效果獲得"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDEBUFF"].tooltipText = "顯示你獲得的不良效果"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDEBUFFFADE"].title = "不良效果消失"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDEBUFFFADE"].tooltipText = "顯示你消失的不良效果"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDEBUFFDOSE"].title = "不良效果疊加"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDEBUFFDOSE"].tooltipText = "顯示你的不良效果疊加及減少"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWFACTION"].title = "聲望獲得"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWFACTION"].tooltipText = "顯示你獲得的聲望"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWLOWMANA"].title = "魔法過低"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWLOWMANA"].tooltipText = "魔法值低於設定的百分比則顯示"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWEXTRAATTACKS"].title = "獲得額外攻擊"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWEXTRAATTACKS"].tooltipText = "獲得額外攻擊"

--options_ex ********************************************************************************************************************************
--******************************************************************************************************************************************
DCT_TEXT_OPEX_FONTENDDC = "英文字體:"
DCT_TEXT_OPEX_FONTCHDDC = "中文字體:"
DCT_TEXT_OPEX_FONTEFFDDC = "字體效果:"
DCT_TEXT_OPEX_CHECK = "繼承自框架"
DCT_TEXT_OPEX_CHECK_TIP = "選中則繼承所屬動畫框架的設定，否則將特別指定"

DCT_Opex_FontEffTypeConfig = {"無","描邊-細","描邊-粗","陰影-極細","陰影-細","陰影-粗"}

DCT_TEXT_OPEX_COLOR[1] = "1號色"
DCT_TEXT_OPEX_COLOR[2] = "2號色"

DCT_Opex_Help["am"] = "數值"
DCT_Opex_Help["ic"] = "技能圖示"
DCT_Opex_Help["sn"] = "技能名"
DCT_Opex_Help["bt"] = "被抵消傷害"
DCT_Opex_Help["ba"] = "被抵消傷害(僅數值)"
DCT_Opex_Help["ms"] = "未擊中"
DCT_Opex_Help["em"] = "怪物表情"
DCT_Opex_Help["oh"] = "過量治療數值"
DCT_Opex_Help["pt"] = "能量類型"
DCT_Opex_Help["ss"] = "傷害類型"
DCT_Opex_Help["et"] = "環境類型"
DCT_Opex_Help["oi"] = "來自誰"
DCT_Opex_Help["di"] = "目標誰"
DCT_Opex_Help["hp"] = "當前生命值"
DCT_Opex_Help["mp"] = "當前魔法值"
DCT_Opex_Help["c1"] = "使用1號色(開始)"
DCT_Opex_Help["c2"] = "使用2號色(開始)"
DCT_Opex_Help["ce"] = "指定顏色(結束)"
DCT_Opex_Help["ti"] = "戰鬥時間(秒)"
DCT_Opex_Help["cs"] = "使用法術類型色(開始)"

--用於預覽
DCT_Opex_PreviewSet["sn"] = "技能名"
DCT_Opex_PreviewSet["bt"] = "20 抵抗"
DCT_Opex_PreviewSet["pt"] = "法力"
DCT_Opex_PreviewSet["em"] = "怪物表情"
DCT_Opex_PreviewSet["oi"] = "來自誰"
DCT_Opex_PreviewSet["di"] = "誰"


DCT_Opex_EditHelp = "(按回車才確認)"
DCT_Opex_SoundEditTitle = "音效檔案:"

DCT_Opex_MulitEditLabel["DEFAULT"] = {"正常傷害","不完全傷害"}
DCT_Opex_MulitEditLabel["DCT_SHOWHEAL"] = {"完全治療","過量治療"}
DCT_Opex_MulitEditLabel["DCT_SHOWPERIODICHEAL"] = {"完全治療","過量治療"}
DCT_Opex_MulitEditLabel["DCT_SHOWCP"] = {"連擊點未滿","連擊點滿"}
DCT_Opex_MulitEditLabel["DCT_SHOWMISS"] = {"普通未擊中","技能未擊中"}
DCT_Opex_MulitEditLabel["DCT_SHOWDISPELLED"] = {"被驅散","被偷取"}
DCT_Opex_MulitEditLabel["DCT_SHOWBUFFFADE"] = {"消失時","消失前倒計時"}
DCT_Opex_MulitEditLabel["DCT_SHOWSPECBUFF"] = {"增益效果","不良效果"}
DCT_Opex_MulitEditLabel["DCT_SHOWSPECBUFFFADE"] = {"增益效果","消失前倒計時"}
DCT_Opex_MulitEditLabel["DCT_SHOWBUFFDOSE"] = {"增加","減少"}
DCT_Opex_MulitEditLabel["DCT_SHOWDEBUFFDOSE"] = {"增加","減少"}
DCT_Opex_MulitEditLabel["DCT_SHOWFACTION"] = {"聲望增加","聲望減少"}
DCT_Opex_MulitEditLabel["DCT_SHOWLOWHEALTH"] = {"","音效檔案"}
DCT_Opex_MulitEditLabel["DCT_SHOWLOWMANA"] = {"","音效檔案"}
DCT_Opex_MulitEditLabel["DCT_SHOWSPECTARGETBUFF"] = {"目標","焦點"}
DCT_Opex_MulitEditLabel["DCT_SHOWSPECTARGETDEBUFF"] = {"目標","焦點"}
DCT_Opex_MulitEditLabel["DCT_SHOWSPECTARGETBUFFFADE"] = {"目標","焦點"}
DCT_Opex_MulitEditLabel["DCT_SHOWSPECTARGETDEBUFFFADE"] = {"目標","焦點"}

DCT_Opex_Config.Sliders["fSizeEn"].title = "數位大小修正"
DCT_Opex_Config.Sliders["fSizeCh"].title = "文字大小修正"
DCT_Opex_Config.Sliders["per"].title = "低傷害過濾"
DCT_Opex_Config.Sliders["per"].tooltipText = "低於此數值將不顯示"

DCT_Opex_Low_path.title = "百分比"
DCT_Opex_Low_path.tooltipText = "低於此百分比將顯示"
DCT_Opex_bufffade_path.title = "消失前計時(秒)"
DCT_Opex_bufffade_path.tooltipText = "低於設定時間將顯示消失倒計時，此功能只對３分鐘以內的Buff計時"


--options_ani ********************************************************************************************************************************
--******************************************************************************************************************************************
DCT_TEXT_OPANI_FRAMEDDC = "操作框架:"
DCT_TEXT_OPANI_ANITYPEDDC = "動畫類型:"
DCT_TEXT_OPANI_FRAME = "框架"
DCT_TEXT_OPANI_ANCHORDDC = "對齊方式:"

DCT_TEXT_OPANI_ADDFRAME = "增加框架"
DCT_TEXT_OPANI_DELETEFRAME = "刪除框架"
DCT_TEXT_OPANI_BATFONT = "應用當前字體到所有框架"
DCT_TEXT_OPANI_PREVIEW = "預覽"

DCT_TEXT_TEST = "123 測試"



DCT_Opani_AniTypeConfig = {"彈出","Hud","靜態","抛物線","水準","垂直","靜態分散式"}
DCT_Opani_AniTypeSimpleConfig = {"彈","H","靜","拋","水","垂","靜"}--動畫名稱簡寫
DCT_Opani_AnchorConfig = {"中間","左邊","右邊"}

DCT_Opani_Config.Sliders["fSizeEn"].title = "英文字體大小"
DCT_Opani_Config.Sliders["fSizeCh"].title = "中文字體大小"
DCT_Opani_Config.Sliders["angle"].title = "旋轉動畫軌跡(度)"
DCT_Opani_Config.Sliders["alpha"].title = "透明度"
DCT_Opani_Config.Sliders["speed"].title = "動畫速度"
DCT_Opani_Config.Sliders["x"].title = "框架x座標"
DCT_Opani_Config.Sliders["y"].title = "框架y座標"



DCT_AniModeParamsSliders[1].Sliders["param1"].title = "第一段角度"
DCT_AniModeParamsSliders[1].Sliders["param1"].tooltipText = "第一段角度"
DCT_AniModeParamsSliders[1].Sliders["param2"].title = "第一段距離"
DCT_AniModeParamsSliders[1].Sliders["param2"].tooltipText = "第一段距離"
DCT_AniModeParamsSliders[1].Sliders["param3"].title = "第二段角度"
DCT_AniModeParamsSliders[1].Sliders["param3"].tooltipText = "第二段角度"
DCT_AniModeParamsSliders[1].Sliders["param4"].title = "第二段距離"
DCT_AniModeParamsSliders[1].Sliders["param4"].tooltipText = "第二段距離"
DCT_AniModeParamsSliders[1].Sliders["param5"].title = "防重疊角度修正"
DCT_AniModeParamsSliders[1].Sliders["param5"].tooltipText = "防重疊角度修正"
DCT_AniModeParamsSliders[1].Sliders["param6"].title = "防重疊距離修正"
DCT_AniModeParamsSliders[1].Sliders["param6"].tooltipText = "防重疊距離修正"
DCT_AniModeParamsSliders[1].Ddc[1].name = "抖動"
DCT_AniModeParamsSliders[1].Ddc[1].text = {"開","關"}


DCT_AniModeParamsSliders[2].Sliders["param1"].title = "角度範圍"
DCT_AniModeParamsSliders[2].Sliders["param1"].tooltipText = "角度範圍"
DCT_AniModeParamsSliders[2].Sliders["param2"].title = "半徑"
DCT_AniModeParamsSliders[2].Sliders["param2"].tooltipText = "半徑,影響到彎曲度"

DCT_AniModeParamsSliders[2].Ddc[1].name = "開口方向"
DCT_AniModeParamsSliders[2].Ddc[1].text = {"向左","向右"}
DCT_AniModeParamsSliders[2].Ddc[2].name = "移動方向"
DCT_AniModeParamsSliders[2].Ddc[2].text = {"順時針","逆時針"}


DCT_AniModeParamsSliders[3].Sliders["param1"].title = "條目數"
DCT_AniModeParamsSliders[3].Sliders["param1"].tooltipText = "最大條目數"
DCT_AniModeParamsSliders[3].Sliders["param2"].title = "顯示時間(秒)"
DCT_AniModeParamsSliders[3].Sliders["param2"].tooltipText = "顯示時間(秒)"

DCT_AniModeParamsSliders[3].Ddc[1].name = "推送方向"
DCT_AniModeParamsSliders[3].Ddc[1].text = {"向上","向下"}
DCT_AniModeParamsSliders[3].Ddc[2].name = "顯示方式"
DCT_AniModeParamsSliders[3].Ddc[2].text = {"正常","縮放","抖動","縮放+抖動"}




DCT_AniModeParamsSliders[4].Sliders["param1"].title = "射出強度"
DCT_AniModeParamsSliders[4].Sliders["param1"].tooltipText = "抛物線射出力量強度"
DCT_AniModeParamsSliders[4].Sliders["param2"].title = "墜落深度"
DCT_AniModeParamsSliders[4].Sliders["param2"].tooltipText = "抛物線射出後墜落的深度"
DCT_AniModeParamsSliders[4].Ddc[1].name = "方向"
DCT_AniModeParamsSliders[4].Ddc[1].text = {"向左","向右"}



DCT_AniModeParamsSliders[5].Sliders["param1"].title = "移動距離"
DCT_AniModeParamsSliders[5].Sliders["param1"].tooltipText = "設定移動距離"
DCT_AniModeParamsSliders[5].Ddc[1].name = "方向"
DCT_AniModeParamsSliders[5].Ddc[1].text = {"向左","向右"}



DCT_AniModeParamsSliders[6].Sliders["param1"].title = "移動距離"
DCT_AniModeParamsSliders[6].Sliders["param1"].tooltipText = "設定移動距離"
DCT_AniModeParamsSliders[6].Sliders["param2"].title = "時間(秒)"
DCT_AniModeParamsSliders[6].Sliders["param2"].tooltipText = "設定移動這些距離需要用多少秒"
DCT_AniModeParamsSliders[6].Sliders["param4"].title = "水準偏移"
DCT_AniModeParamsSliders[6].Sliders["param4"].tooltipText = "設定水準上要偏移的距離，非0將造成斜向移動效果"
DCT_AniModeParamsSliders[6].Ddc[1].name = "方向"
DCT_AniModeParamsSliders[6].Ddc[1].text = {"向上","向下"}


DCT_AniModeParamsSliders[7].Sliders["param1"].title = "顯示時間(秒)"
DCT_AniModeParamsSliders[7].Sliders["param1"].tooltipText = "顯示時間(秒)"
DCT_AniModeParamsSliders[7].Ddc[1].name = "顯示方式"
DCT_AniModeParamsSliders[7].Ddc[1].text = {"正常","彈性縮放","縮放"}

--options_font ********************************************************************************************************************************
--******************************************************************************************************************************************
DCT_TEXT_OPFONT_EDIT = "編輯當前選中字體: (輸入完請按回車)"
DCT_TEXT_OPFONT_NAME = "名稱"
DCT_TEXT_OPFONT_PATH = "路徑"


--options_save ********************************************************************************************************************************
--******************************************************************************************************************************************
DCT_TEXT_OPSAVE_SAVELISTDDC = "當前已存在的配置:"
DCT_TEXT_OPSAVE_LOAD = "讀取"
DCT_TEXT_OPSAVE_SAVE = "保存"
DCT_TEXT_OPSAVE_DELETE = "刪除"
DCT_TEXT_OPSAVE_ADD = "添加配置"
DCT_TEXT_OPSAVE_EDIT = "指定添加的配置名:"
DCT_TEXT_OPSAVE_NONE = "無配置"

DCT_TEXT_OPSAVE_PRESETANILISTDDC = "預設的動畫:"
DCT_TEXT_OPSAVE_PRESETTEXTLISTDDC = "預設的輸出文字:"
DCT_TEXT_OPSAVE_PRESETLOAD = "讀取預設"

DCT_TEXT_OPSAVE_PRESETLOAD_SUCCEED = "讀取預設:"

DCT_TEXT_OPSAVE_LOAD_SUCCEED = "讀取配置成功:"
DCT_TEXT_OPSAVE_SAVE_SUCCEED = "保存配置成功:"
DCT_TEXT_OPSAVE_DELETE_SUCCEED = "刪除配置成功:"
DCT_TEXT_OPSAVE_ADD_SUCCEED = "添加配置成功:"

DCT_TEXT_OPSAVE_LOAD_ERROR = "讀取配置失敗"
DCT_TEXT_OPSAVE_SAVE_ERROR = "保存配置失敗"
DCT_TEXT_OPSAVE_DELETE_ERROR = "刪除配置失敗:"
DCT_TEXT_OPSAVE_ADD_ERROR = "添加配置失敗:"

--options_misc********************************************************************************************************
--******************************************************************************************************************


DCT_MiscCfg_Event.CheckButtons["DCT_EnglishInfo"].title = "使用英文資訊"
DCT_MiscCfg_Event.CheckButtons["DCT_EnglishInfo"].tooltipText = "將法力，技能系別，閃躲，未擊中等用英文表示，其他如進入戰鬥等字樣請自行編輯更改"
DCT_MiscCfg_Event.CheckButtons["DCT_SSC_Number"].title = "自動傷害數位著色"
DCT_MiscCfg_Event.CheckButtons["DCT_SSC_Number"].tooltipText = "自動將傷害數位(#am)根據法術類型著色,將會覆蓋事件設定顏色"
DCT_MiscCfg_Event.CheckButtons["DCT_SSC_SpellSchool"].title = "自動法系類別名著色"
DCT_MiscCfg_Event.CheckButtons["DCT_SSC_SpellSchool"].tooltipText = "自動將傷害類型字樣(#ss)根據法術類型著色,將會覆蓋事件設定顏色"
DCT_MiscCfg_Event.CheckButtons["DCT_SSC_Spell"].title = "自動技能名著色"
DCT_MiscCfg_Event.CheckButtons["DCT_SSC_Spell"].tooltipText = "自動將技能名(#sn)根據法術類型著色,將會覆蓋事件設定顏色"
DCT_MiscCfg_Event.CheckButtons["DCT_HealSelfNoneName"].title = "自己治療自己不顯示技能名"
DCT_MiscCfg_Event.CheckButtons["DCT_HealSelfNoneName"].tooltipText = "當自己給自己治療的時候，變數(技能名)#sn將為空"
DCT_MiscCfg_Event.CheckButtons["DCT_ManaSelfNoneName"].title = "自己對自己恢復不顯示姓名"
DCT_MiscCfg_Event.CheckButtons["DCT_ManaSelfNoneName"].tooltipText = "當自己給自己恢復(HP,MP)的時候，變數(來自誰)#oi將為空"
DCT_MiscCfg_Event.CheckButtons["DCT_ZeroHp_off"].title = "滿血不顯示治療"
DCT_MiscCfg_Event.CheckButtons["DCT_ZeroHp_off"].tooltipText = "滿血不顯示治療"
DCT_MiscCfg_Event.CheckButtons["DCT_ScaleOnCrit"].title = "被爆擊時使用縮放"
DCT_MiscCfg_Event.CheckButtons["DCT_ScaleOnCrit"].tooltipText = "當你受到的攻擊為爆擊的時候，使用縮放效果"
DCT_MiscCfg_Event.CheckButtons["DCT_UseCastBar"].title = "計時器使用進度條"
DCT_MiscCfg_Event.CheckButtons["DCT_UseCastBar"].tooltipText = "計時器使用進度條"


--options_spec********************************************************************************************************
--******************************************************************************************************************
DCT_TEXT_OPSPEC_DELETE = "刪除"
DCT_TEXT_OPSPEC_ADD = "添加"
DCT_TEXT_OPSPEC_ADD_ERROR1 = "添加失敗: 此Buff或Debuff不存在"
DCT_TEXT_OPSPEC_ADD_ERROR2 = "添加失敗: 已存在"
DCT_TEXT_OPSPEC_ADD_ERROR3 = "超過上限(30個)"
DCT_TEXT_OPSPEC_ADD_SUCCEED = "添加成功!"
DCT_TEXT_OPSPEC_BUFFLISTDDC = "已添加效果:"
DCT_TEXT_OPSPEC_SPELLLISTDDC = "已添加技能:"

DCT_SpecCfg_Event.EventFrames["DCT_SHOWSPECBUFF"].title = "自己特定效果獲得"
DCT_SpecCfg_Event.EventFrames["DCT_SHOWSPECBUFF"].tooltipText = "顯示你特別指定的Buff/Debuff獲得"
DCT_SpecCfg_Event.EventFrames["DCT_SHOWSPECBUFFFADE"].title = "自己特定增益效果消失"
DCT_SpecCfg_Event.EventFrames["DCT_SHOWSPECDEBUFFFADE"].title = "自己特定不良效果消失"
DCT_SpecCfg_Event.EventFrames["DCT_SHOWSPELLSUCCESS"].title = "特定瞬發技能命中"
DCT_SpecCfg_Event.EventFrames["DCT_SHOWSPELLSUCCESS"].tooltipText = "當你特別指定的瞬發技能命中時顯示"
DCT_SpecCfg_Event.EventFrames["DCT_SHOWSPELLFAILED"].title = "特定技能未命中"
DCT_SpecCfg_Event.EventFrames["DCT_SHOWSPELLFAILED"].tooltipText = "當你特別指定的技能未命中時顯示"
DCT_SpecCfg_Event.EventFrames["DCT_SHOWCOOLDOWN"].title = "特定技能冷卻完成"

DCT_SpecCfg_Event2.EventFrames["DCT_SHOWSPECTARGETBUFF"].title = "目標/焦點特定有益效果獲得"
DCT_SpecCfg_Event2.EventFrames["DCT_SHOWSPECTARGETDEBUFF"].title = "目標/焦點特定不良效果獲得"
DCT_SpecCfg_Event2.EventFrames["DCT_SHOWSPECTARGETBUFFFADE"].title = "目標/焦點特定有益效果消失"
DCT_SpecCfg_Event2.EventFrames["DCT_SHOWSPECTARGETDEBUFFFADE"].title = "目標/焦點特定不良效果消失"

