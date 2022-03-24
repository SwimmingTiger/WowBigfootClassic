--if GetLocale() ~= "zhCN" then return;end

DCT_CHECK_ENABLE_LABEL = "激活战斗指示器"

DCT_EVENT_OPTION = "受到的事件";
DCT_EVENT2_OPTION = "受到的事件2";
DCT_FRAME_OPTION = "动画框架";
DCT_FONT_OPTION = "字体自定义";
DCT_SAVE_OPTION = "预设和配置文件"
DCT_MISC_OPTION = "其它设置"
DCT_SPEC_OPTION = "特定事件1"
DCT_SPEC_OPTION2 = "特定事件2"

DCT_BUTTON_RESET_LABEL = "恢复默认设置";
DCT_BUTTON_RESET_TIP= "恢复默认设置";
DCT_BUTTON_SAVECUSTOM_LABEL = "保存个性设置"
DCT_BUTTON_LOADCUSTOM_LABEL = "读取个性设置"

DCT_EVENT_TIP1 = "点击选择输出动画框架，数字代表动画框架的编号"
DCT_EVENT_TIP2 = "点击编辑具体显示文字及其他一些相关的详细设置"

DCT_RESET_TIP = "已载入默认设置";

DCT_OptionCfg_Base["DCT_ENABLED"].title = "激活战斗指示器"
DCT_OptionCfg_Base["DCT_ENABLED"].tooltipText = "激活战斗指示器"



DCT_OptionCfg_Event.EventFrames["DCT_SHOWHIT"].title = "伤害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWHIT"].tooltipText = "显示你受到的伤害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWHITCRIT"].title = "伤害(爆击)"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWHITCRIT"].tooltipText = "显示你受到的爆击伤害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWHEAL"].title = "治疗"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWHEAL"].tooltipText = "显示你受到的治疗"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWPERIODICHEAL"].title = "持续治疗"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWPERIODICHEAL"].tooltipText = "显示你受到的持续性治疗"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWCOMBAT"].title = "进入战斗"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWCOMBAT"].tooltipText = "显示进入状态"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWCOMBATLEAVE"].title = "离开战斗"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWCOMBATLEAVE"].tooltipText = "显示进入状态"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWHONOR"].title = "荣誉获得"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWHONOR"].tooltipText = "显示你的荣誉获得"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWBUFF"].title = "有益效果获得"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWBUFF"].tooltipText = "显示你获得的有益效果"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWBUFFFADE"].title = "有益效果消失"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWBUFFFADE"].tooltipText = "显示你消失的有益效果"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWBUFFDOSE"].title = "有益效果叠加"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWBUFFDOSE"].tooltipText = "显示你的有益效果叠加及减少"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWENVIRONMENTAL"].title = "环境伤害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWENVIRONMENTAL"].tooltipText = "比如溺水掉落等"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDISPELLED"].title = "被驱散,偷取"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDISPELLED"].tooltipText = "被驱散，偷取"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWLOWHEALTH"].title = "生命过低"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWLOWHEALTH"].tooltipText = "生命值低于设定的百分比则显示"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWSHIELD"].title = "反射伤害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWSHIELD"].tooltipText = "反射伤害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWKILLBLOW"].title = "击杀"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWKILLBLOW"].tooltipText = "如果因为你的攻击杀死了目标，则显示击杀字样"


DCT_OptionCfg_Event.EventFrames["DCT_SHOWSPELL"].title = "技能伤害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWSPELL"].tooltipText = "显示你受到的技能伤害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWSPELLCRIT"].title = "技能伤害(爆击)"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWSPELLCRIT"].tooltipText = "显示你受到的技能爆击伤害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWPERIODIC"].title = "持续伤害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWPERIODIC"].tooltipText = "显示你受到的来自当前目标的持续伤害"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWACTIVE"].title = "技能激活"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWACTIVE"].tooltipText = "显示你的某技能激活"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWPOWER"].title = "能量获得"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWPOWER"].tooltipText = "显示获得的能量，魔法值等"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWCP"].title = "连击点"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWCP"].tooltipText = "显示你获得的连击点"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDRAIN"].title = "法力流失"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDRAIN"].tooltipText = "显示你被流失的法力"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDEBUFF"].title = "不良效果获得"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDEBUFF"].tooltipText = "显示你获得的不良效果"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDEBUFFFADE"].title = "不良效果消失"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDEBUFFFADE"].tooltipText = "显示你消失的不良效果"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDEBUFFDOSE"].title = "不良效果叠加"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWDEBUFFDOSE"].tooltipText = "显示你的不良效果叠加及减少"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWFACTION"].title = "声望获得"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWFACTION"].tooltipText = "显示你获得的声望"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWLOWMANA"].title = "魔法过低"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWLOWMANA"].tooltipText = "魔法值低于设定的百分比则显示"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWEXTRAATTACKS"].title = "获得额外攻击"
DCT_OptionCfg_Event.EventFrames["DCT_SHOWEXTRAATTACKS"].tooltipText = "获得额外攻击"

--options_ex ********************************************************************************************************************************
--******************************************************************************************************************************************
DCT_TEXT_OPEX_FONTENDDC = "英文字体:"
DCT_TEXT_OPEX_FONTCHDDC = "中文字体:"
DCT_TEXT_OPEX_FONTEFFDDC = "字体效果:"
DCT_TEXT_OPEX_CHECK = "继承自框架"
DCT_TEXT_OPEX_CHECK_TIP = "选中则继承所属动画框架的设定，否则将特别指定"

DCT_Opex_FontEffTypeConfig = {"无","描边-细","描边-粗","阴影-极细","阴影-细","阴影-粗"}

DCT_TEXT_OPEX_COLOR[1] = "1号色"
DCT_TEXT_OPEX_COLOR[2] = "2号色"

DCT_Opex_Help["am"] = "数值"
DCT_Opex_Help["ic"] = "技能图标"
DCT_Opex_Help["sn"] = "技能名"
DCT_Opex_Help["bt"] = "被抵消伤害"
DCT_Opex_Help["ba"] = "被抵消伤害(仅数值)"
DCT_Opex_Help["ms"] = "未击中"
DCT_Opex_Help["em"] = "怪物表情"
DCT_Opex_Help["oh"] = "过量治疗数值"
DCT_Opex_Help["pt"] = "能量类型"
DCT_Opex_Help["ss"] = "伤害类型"
DCT_Opex_Help["et"] = "环境类型"
DCT_Opex_Help["oi"] = "来自誰"
DCT_Opex_Help["di"] = "目标誰"
DCT_Opex_Help["hp"] = "当前生命值"
DCT_Opex_Help["mp"] = "当前魔法值"
DCT_Opex_Help["c1"] = "使用1号色(开始)"
DCT_Opex_Help["c2"] = "使用2号色(开始)"
DCT_Opex_Help["ce"] = "指定颜色(结束)"
DCT_Opex_Help["ti"] = "战斗时间(秒)"
DCT_Opex_Help["cs"] = "使用法术类型色(开始)"

--用于预览
DCT_Opex_PreviewSet["sn"] = "技能名"
DCT_Opex_PreviewSet["bt"] = "20 抵抗"
DCT_Opex_PreviewSet["pt"] = "法力"
DCT_Opex_PreviewSet["em"] = "怪物表情"
DCT_Opex_PreviewSet["oi"] = "来自誰"
DCT_Opex_PreviewSet["di"] = "誰"


DCT_Opex_EditHelp = "(按回车才确认)"
DCT_Opex_SoundEditTitle = "声音文件:"

DCT_Opex_MulitEditLabel["DEFAULT"] = {"正常伤害","不完全伤害"}
DCT_Opex_MulitEditLabel["DCT_SHOWHEAL"] = {"完全治疗","过量治疗"}
DCT_Opex_MulitEditLabel["DCT_SHOWPERIODICHEAL"] = {"完全治疗","过量治疗"}
DCT_Opex_MulitEditLabel["DCT_SHOWCP"] = {"连击点未满","连击点满"}
DCT_Opex_MulitEditLabel["DCT_SHOWMISS"] = {"普通未击中","技能未击中"}
DCT_Opex_MulitEditLabel["DCT_SHOWDISPELLED"] = {"被驱散","被偷取"}
DCT_Opex_MulitEditLabel["DCT_SHOWBUFFFADE"] = {"消失时","消失前倒计时"}
DCT_Opex_MulitEditLabel["DCT_SHOWSPECBUFF"] = {"增益效果","不良效果"}
DCT_Opex_MulitEditLabel["DCT_SHOWSPECBUFFFADE"] = {"增益效果","消失前倒计时"}
DCT_Opex_MulitEditLabel["DCT_SHOWBUFFDOSE"] = {"增加","减少"}
DCT_Opex_MulitEditLabel["DCT_SHOWDEBUFFDOSE"] = {"增加","减少"}
DCT_Opex_MulitEditLabel["DCT_SHOWFACTION"] = {"声望增加","声望减少"}
DCT_Opex_MulitEditLabel["DCT_SHOWLOWHEALTH"] = {"","声音文件"}
DCT_Opex_MulitEditLabel["DCT_SHOWLOWMANA"] = {"","声音文件"}
DCT_Opex_MulitEditLabel["DCT_SHOWSPECTARGETBUFF"] = {"目标","焦点"}
DCT_Opex_MulitEditLabel["DCT_SHOWSPECTARGETDEBUFF"] = {"目标","焦点"}
DCT_Opex_MulitEditLabel["DCT_SHOWSPECTARGETBUFFFADE"] = {"目标","焦点"}
DCT_Opex_MulitEditLabel["DCT_SHOWSPECTARGETDEBUFFFADE"] = {"目标","焦点"}

DCT_Opex_Config.Sliders["fSizeEn"].title = "数字大小修正"
DCT_Opex_Config.Sliders["fSizeCh"].title = "文字大小修正"
DCT_Opex_Config.Sliders["per"].title = "低伤害过滤"
DCT_Opex_Config.Sliders["per"].tooltipText = "低于此数值将不显示"

DCT_Opex_Low_path.title = "百分比"
DCT_Opex_Low_path.tooltipText = "低于此百分比将显示"
DCT_Opex_bufffade_path.title = "消失前计时(秒)"
DCT_Opex_bufffade_path.tooltipText = "低于设定时间将显示消失倒计时，此功能只对３分钟以内的Buff计时"


--options_ani ********************************************************************************************************************************
--******************************************************************************************************************************************
DCT_TEXT_OPANI_FRAMEDDC = "操作框架:"
DCT_TEXT_OPANI_ANITYPEDDC = "动画类型:"
DCT_TEXT_OPANI_FRAME = "框架"
DCT_TEXT_OPANI_ANCHORDDC = "对齐方式:"

DCT_TEXT_OPANI_ADDFRAME = "增加框架"
DCT_TEXT_OPANI_DELETEFRAME = "删除框架"
DCT_TEXT_OPANI_BATFONT = "应用当前字体到所有框架"
DCT_TEXT_OPANI_PREVIEW = "预览"

DCT_TEXT_TEST = "123 测试"



DCT_Opani_AniTypeConfig = {"弹出","Hud","静态","抛物线","水平","垂直","静态分散式"}
DCT_Opani_AniTypeSimpleConfig = {"弹","H","静","抛","水","垂","静"}--动画名称简写
DCT_Opani_AnchorConfig = {"中间","左边","右边"}

DCT_Opani_Config.Sliders["fSizeEn"].title = "英文字体大小"
DCT_Opani_Config.Sliders["fSizeCh"].title = "中文字体大小"
DCT_Opani_Config.Sliders["angle"].title = "旋转动画轨迹(度)"
DCT_Opani_Config.Sliders["alpha"].title = "透明度"
DCT_Opani_Config.Sliders["speed"].title = "动画速度"
DCT_Opani_Config.Sliders["x"].title = "框架x坐标"
DCT_Opani_Config.Sliders["y"].title = "框架y坐标"



DCT_AniModeParamsSliders[1].Sliders["param1"].title = "第一段角度"
DCT_AniModeParamsSliders[1].Sliders["param1"].tooltipText = "第一段角度"
DCT_AniModeParamsSliders[1].Sliders["param2"].title = "第一段距离"
DCT_AniModeParamsSliders[1].Sliders["param2"].tooltipText = "第一段距离"
DCT_AniModeParamsSliders[1].Sliders["param3"].title = "第二段角度"
DCT_AniModeParamsSliders[1].Sliders["param3"].tooltipText = "第二段角度"
DCT_AniModeParamsSliders[1].Sliders["param4"].title = "第二段距离"
DCT_AniModeParamsSliders[1].Sliders["param4"].tooltipText = "第二段距离"
DCT_AniModeParamsSliders[1].Sliders["param5"].title = "防重叠角度修正"
DCT_AniModeParamsSliders[1].Sliders["param5"].tooltipText = "防重叠角度修正"
DCT_AniModeParamsSliders[1].Sliders["param6"].title = "防重叠距离修正"
DCT_AniModeParamsSliders[1].Sliders["param6"].tooltipText = "防重叠距离修正"
DCT_AniModeParamsSliders[1].Ddc[1].name = "抖动"
DCT_AniModeParamsSliders[1].Ddc[1].text = {"开","关"}


DCT_AniModeParamsSliders[2].Sliders["param1"].title = "角度范围"
DCT_AniModeParamsSliders[2].Sliders["param1"].tooltipText = "角度范围"
DCT_AniModeParamsSliders[2].Sliders["param2"].title = "半径"
DCT_AniModeParamsSliders[2].Sliders["param2"].tooltipText = "半径,影响到弯曲度"

DCT_AniModeParamsSliders[2].Ddc[1].name = "开口方向"
DCT_AniModeParamsSliders[2].Ddc[1].text = {"向左","向右"}
DCT_AniModeParamsSliders[2].Ddc[2].name = "移动方向"
DCT_AniModeParamsSliders[2].Ddc[2].text = {"顺时针","逆时针"}


DCT_AniModeParamsSliders[3].Sliders["param1"].title = "条目数"
DCT_AniModeParamsSliders[3].Sliders["param1"].tooltipText = "最大条目数"
DCT_AniModeParamsSliders[3].Sliders["param2"].title = "显示时间(秒)"
DCT_AniModeParamsSliders[3].Sliders["param2"].tooltipText = "显示时间(秒)"

DCT_AniModeParamsSliders[3].Ddc[1].name = "推送方向"
DCT_AniModeParamsSliders[3].Ddc[1].text = {"向上","向下"}
DCT_AniModeParamsSliders[3].Ddc[2].name = "显示方式"
DCT_AniModeParamsSliders[3].Ddc[2].text = {"正常","缩放","抖动","缩放+抖动"}




DCT_AniModeParamsSliders[4].Sliders["param1"].title = "射出强度"
DCT_AniModeParamsSliders[4].Sliders["param1"].tooltipText = "抛物线射出力量强度"
DCT_AniModeParamsSliders[4].Sliders["param2"].title = "坠落深度"
DCT_AniModeParamsSliders[4].Sliders["param2"].tooltipText = "抛物线射出后坠落的深度"
DCT_AniModeParamsSliders[4].Ddc[1].name = "方向"
DCT_AniModeParamsSliders[4].Ddc[1].text = {"向左","向右"}



DCT_AniModeParamsSliders[5].Sliders["param1"].title = "移动距离"
DCT_AniModeParamsSliders[5].Sliders["param1"].tooltipText = "设定移动距离"
DCT_AniModeParamsSliders[5].Ddc[1].name = "方向"
DCT_AniModeParamsSliders[5].Ddc[1].text = {"向左","向右"}



DCT_AniModeParamsSliders[6].Sliders["param1"].title = "移动距离"
DCT_AniModeParamsSliders[6].Sliders["param1"].tooltipText = "设定移动距离"
DCT_AniModeParamsSliders[6].Sliders["param2"].title = "时间(秒)"
DCT_AniModeParamsSliders[6].Sliders["param2"].tooltipText = "设定移动这些距离需要用多少秒"
DCT_AniModeParamsSliders[6].Sliders["param4"].title = "水平偏移"
DCT_AniModeParamsSliders[6].Sliders["param4"].tooltipText = "设定水平上要偏移的距离，非0将造成斜向移动效果"
DCT_AniModeParamsSliders[6].Ddc[1].name = "方向"
DCT_AniModeParamsSliders[6].Ddc[1].text = {"向上","向下"}


DCT_AniModeParamsSliders[7].Sliders["param1"].title = "显示时间(秒)"
DCT_AniModeParamsSliders[7].Sliders["param1"].tooltipText = "显示时间(秒)"
DCT_AniModeParamsSliders[7].Ddc[1].name = "显示方式"
DCT_AniModeParamsSliders[7].Ddc[1].text = {"正常","弹性缩放","缩放"}

--options_font ********************************************************************************************************************************
--******************************************************************************************************************************************
DCT_TEXT_OPFONT_EDIT = "编辑当前选中字体: (输入完请按回车)"
DCT_TEXT_OPFONT_NAME = "名称"
DCT_TEXT_OPFONT_PATH = "路径"


--options_save ********************************************************************************************************************************
--******************************************************************************************************************************************
DCT_TEXT_OPSAVE_SAVELISTDDC = "当前已存在的配置:"
DCT_TEXT_OPSAVE_LOAD = "读取"
DCT_TEXT_OPSAVE_SAVE = "保存"
DCT_TEXT_OPSAVE_DELETE = "删除"
DCT_TEXT_OPSAVE_ADD = "添加配置"
DCT_TEXT_OPSAVE_EDIT = "指定添加的配置名:"
DCT_TEXT_OPSAVE_NONE = "无配置"

DCT_TEXT_OPSAVE_PRESETANILISTDDC = "预设的动画:"
DCT_TEXT_OPSAVE_PRESETTEXTLISTDDC = "预设的输出文字:"
DCT_TEXT_OPSAVE_PRESETLOAD = "读取预设"

DCT_TEXT_OPSAVE_PRESETLOAD_SUCCEED = "读取预设:"

DCT_TEXT_OPSAVE_LOAD_SUCCEED = "读取配置成功:"
DCT_TEXT_OPSAVE_SAVE_SUCCEED = "保存配置成功:"
DCT_TEXT_OPSAVE_DELETE_SUCCEED = "删除配置成功:"
DCT_TEXT_OPSAVE_ADD_SUCCEED = "添加配置成功:"

DCT_TEXT_OPSAVE_LOAD_ERROR = "读取配置失败"
DCT_TEXT_OPSAVE_SAVE_ERROR = "保存配置失败"
DCT_TEXT_OPSAVE_DELETE_ERROR = "删除配置失败:"
DCT_TEXT_OPSAVE_ADD_ERROR = "添加配置失败:"

--options_misc********************************************************************************************************
--******************************************************************************************************************


DCT_MiscCfg_Event.CheckButtons["DCT_EnglishInfo"].title = "使用英文信息"
DCT_MiscCfg_Event.CheckButtons["DCT_EnglishInfo"].tooltipText = "将法力，技能系别，闪躲，未击中等用英文表示，其他如进入战斗等字样请自行编辑更改"
DCT_MiscCfg_Event.CheckButtons["DCT_SSC_Number"].title = "自动伤害数字着色"
DCT_MiscCfg_Event.CheckButtons["DCT_SSC_Number"].tooltipText = "自动将伤害数字(#am)根据法术类型着色,将会覆盖事件设定颜色"
DCT_MiscCfg_Event.CheckButtons["DCT_SSC_SpellSchool"].title = "自动法系类别名着色"
DCT_MiscCfg_Event.CheckButtons["DCT_SSC_SpellSchool"].tooltipText = "自动将伤害类型字样(#ss)根据法术类型着色,将会覆盖事件设定颜色"
DCT_MiscCfg_Event.CheckButtons["DCT_SSC_Spell"].title = "自动技能名着色"
DCT_MiscCfg_Event.CheckButtons["DCT_SSC_Spell"].tooltipText = "自动将技能名(#sn)根据法术类型着色,将会覆盖事件设定颜色"
DCT_MiscCfg_Event.CheckButtons["DCT_HealSelfNoneName"].title = "自己治疗自己不显示技能名"
DCT_MiscCfg_Event.CheckButtons["DCT_HealSelfNoneName"].tooltipText = "当自己给自己治疗的时候，变量(技能名)#sn将为空"
DCT_MiscCfg_Event.CheckButtons["DCT_ManaSelfNoneName"].title = "自己对自己恢复不显示姓名"
DCT_MiscCfg_Event.CheckButtons["DCT_ManaSelfNoneName"].tooltipText = "当自己给自己恢复(HP,MP)的时候，变量(来自誰)#oi将为空"
DCT_MiscCfg_Event.CheckButtons["DCT_ZeroHp_off"].title = "满血不显示治疗"
DCT_MiscCfg_Event.CheckButtons["DCT_ZeroHp_off"].tooltipText = "满血不显示治疗"
DCT_MiscCfg_Event.CheckButtons["DCT_ScaleOnCrit"].title = "被爆击时使用缩放"
DCT_MiscCfg_Event.CheckButtons["DCT_ScaleOnCrit"].tooltipText = "当你受到的攻击为爆击的时候，使用缩放效果"
DCT_MiscCfg_Event.CheckButtons["DCT_UseCastBar"].title = "计时器使用进度条"
DCT_MiscCfg_Event.CheckButtons["DCT_UseCastBar"].tooltipText = "计时器使用进度条"


--options_spec********************************************************************************************************
--******************************************************************************************************************
DCT_TEXT_OPSPEC_DELETE = "删除"
DCT_TEXT_OPSPEC_ADD = "添加"
DCT_TEXT_OPSPEC_ADD_ERROR1 = "添加失败: 此Buff或Debuff不存在"
DCT_TEXT_OPSPEC_ADD_ERROR2 = "添加失败: 已存在"
DCT_TEXT_OPSPEC_ADD_ERROR3 = "超过上限(30个)"
DCT_TEXT_OPSPEC_ADD_SUCCEED = "添加成功!"
DCT_TEXT_OPSPEC_BUFFLISTDDC = "已添加效果:"
DCT_TEXT_OPSPEC_SPELLLISTDDC = "已添加技能:"

DCT_SpecCfg_Event.EventFrames["DCT_SHOWSPECBUFF"].title = "自己特定效果获得"
DCT_SpecCfg_Event.EventFrames["DCT_SHOWSPECBUFF"].tooltipText = "显示你特别指定的Buff/Debuff获得"
DCT_SpecCfg_Event.EventFrames["DCT_SHOWSPECBUFFFADE"].title = "自己特定增益效果消失"
DCT_SpecCfg_Event.EventFrames["DCT_SHOWSPECDEBUFFFADE"].title = "自己特定不良效果消失"
DCT_SpecCfg_Event.EventFrames["DCT_SHOWSPELLSUCCESS"].title = "特定瞬发技能命中"
DCT_SpecCfg_Event.EventFrames["DCT_SHOWSPELLSUCCESS"].tooltipText = "当你特别指定的瞬发技能命中时显示"
DCT_SpecCfg_Event.EventFrames["DCT_SHOWSPELLFAILED"].title = "特定技能未命中"
DCT_SpecCfg_Event.EventFrames["DCT_SHOWSPELLFAILED"].tooltipText = "当你特别指定的技能未命中时显示"
DCT_SpecCfg_Event.EventFrames["DCT_SHOWCOOLDOWN"].title = "特定技能冷却完成"

DCT_SpecCfg_Event2.EventFrames["DCT_SHOWSPECTARGETBUFF"].title = "目标/焦点特定有益效果获得"
DCT_SpecCfg_Event2.EventFrames["DCT_SHOWSPECTARGETDEBUFF"].title = "目标/焦点特定不良效果获得"
DCT_SpecCfg_Event2.EventFrames["DCT_SHOWSPECTARGETBUFFFADE"].title = "目标/焦点特定有益效果消失"
DCT_SpecCfg_Event2.EventFrames["DCT_SHOWSPECTARGETDEBUFFFADE"].title = "目标/焦点特定不良效果消失"

