local TC2, C, L, _ = unpack(select(2, ...))
if TC2.locale ~= "zhCN" then return end

-----------------------------
-- zhCN client (by Qcat of 60Addons & 阿什坎迪-枫聖)
--  Last update: 2021/08/05
-----------------------------
-- main frame
L.gui_threat                        = "仇恨"
L.gui_config                        = "打开配置"

-- config frame
L.reset                             = "重置为默认"

-- messages
L.message_welcome                   = "输入 /tc2 进入设置"
L.message_leader                    = "你必须是队长或者有权限"
L.message_outdated                  = "|cFFFBB709ThreatClassic2:|r 新版本已发布，请去 https://www.curseforge.com/wow/addons/threatclassic2 下载最新版本。"
L.message_incompatible              = "你的 |cFFFBB709ThreatClassic2|r 已过期，因此不兼容，请立即升级。"

L.general                           = "一般"
L.general_welcome                   = "登录时显示信息。"
L.general_rawPercent                = "启用原始威胁百分比 (近战 110% / 远程 130% 的仇恨)" 
L.general_downscaleThreat           = "启用调整后威胁值 (修正后威胁值是1伤害等于1威胁值)"
L.general_downscaleThreatDesc       = "暴雪威胁API是每造成1点伤害算100点威胁值。 此设置是将威胁API的数字缩减为我们在补丁1.13.5之前使用的数字。"
L.general_updateFreq                = "更新间隔的最短时间（ 秒 ）。" 
L.general_updateFreq_desc           = "这个设置是为了限制tc2更新时的CPU消耗(例如，在targettarget模式下)。一般来说，威胁值不能更新得更快，因为暴雪的API更新速度限制了它们。"
L.general_test                      = "测试模式。"
--L.general_minimap                 = "小地图按钮."  --You can't find this option, you can delete it.
--L.general_ignorePets              = "忽略玩家宠物的仇恨."  --You can't find this option, you can delete it.

L.visibility                        = "可见性"
L.visibility_hideOOC                = "脱战后隐藏"
L.visibility_hideSolo               = "不在队伍时隐藏"
L.visibility_hideInPvP              = "战场中隐藏"
L.visibility_hideOpenWorld          = "不在团队中隐藏 (也隐藏世界BOSS!)。"
L.visibility_hideAlways             = "始终隐藏框架。输入 /tc2 进入设置界面"

L.profiles                          = "配置"

L.color                             = "颜色设置"

L.appearance                        = "外观"

L.frame                             = "框架"
L.frame_header                      = "标题"
L.frame_bg                          = "背景"
L.frame_test                        = "测试模式"
L.frame_strata                      = "层面"
L.frame_scale                       = "大小"
L.frame_growup                      = "向上成长"
L.frame_lock                        = "锁定"
L.frame_headerShow                  = "显示标题"
L.frame_headerColor                 = "标题颜色"  
L.frame_position                    = "位置"
L.frame_width                       = "宽度"
L.frame_height                      = "高度"
L.frame_xOffset                     = "X 偏移"
L.frame_yOffset                     = "Y 偏移"

L.bar                               = "仇恨条"
L.bar_descend                       = "反向增长"  
L.bar_height                        = "高度"
L.bar_padding                       = "间隔"
L.bar_texture                       = "纹理"
L.bar_alpha                         = "透明度 (默认颜色)"
L.bar_textOptions                   = "文本选项"
L.bar_showThreatValue               = "显示威胁值"
L.bar_showThreatPercentage          = "显示威胁比例"
L.bar_showIgniteIndicator           = "显示点燃指示器"
L.bar_showIgniteIndicator_desc      = "在当前拥有“点燃”技能的玩家名字旁边显示一个小的“点燃”图标"

L.backdrop                          = "计时条背景"
L.backdrop_bgTexture                = "背景纹理"
L.backdrop_bgColor                  = "背景颜色"
L.backdrop_edge                     = "计时条边框"
L.backdrop_edgeTexture              = "边框纹理"
L.backdrop_edgeColor                = "边框颜色"
L.backdrop_edgeSize                 = "边框尺寸"

L.igniteIndicator                   = "点燃指示器"
L.igniteIndicator_makeRound         = "圆形图标"
L.igniteIndicator_makeRound_desc    = "启用此的纹理，需要重载界面（/reload）"
L.igniteIndicator_size              = "大小"

L.customBarColors                   = "自定义颜色"
L.customBarColorsPlayer_enabled     = "启用自定义玩家颜色"
L.customBarColorsPlayer_desc        = "这个选项为玩家设置一个固定的颜色，而不考虑其他任何颜色选项。"
L.customBarColorsActiveTank_enabled = "启用自定义坦克颜色"
L.customBarColorsOtherUnit_enabled  = "启用自定义其他玩家颜色"
L.customBarColorsIgnite_enabled     = "启用点燃的颜色"
L.customBarColorsIgnite_desc        = "这将改变状态条的颜色，如果目标上存在该玩家的点燃技能。坦克和玩家颜色有优先级。"
L.customBarColorsPlayer_color       = "玩家颜色"
L.customBarColorsActiveTank_color   = "主坦克颜色"
L.customBarColorsOtherUnit_color    = "其他玩家颜色"
L.customBarColorsIgnite_color       = "点燃玩家颜色"

L.font                              = "字体"
L.font_name                         = "字体选择"
L.font_size                         = "大小"
L.font_style                        = "样式"
L.NONE                              = "无"
L.OUTLINE                           = "轮廓"
L.THICKOUTLINE                      = "粗轮廓"
L.font_shadow                       = "字体阴影"

L.filter                            = "过滤器"
L.filter_outOfMelee                 = "隐藏不在近战范围内的玩家"
L.filter_useTargetList              = "仅针对列出的目标过滤玩家"
L.filter_targetList                 = "过滤目标列表（Shift+Enter键来分隔）"
L.filter_targetList_desc            = "输入要过滤的首领或其他的单位。每行一个。注意:需要添加准确的名称，例如：屠龙者格鲁尔"

L.warnings                          = "警报"
L.warnings_disableWhileTanking      = "坦克时禁用"
L.warnings_disableWhileTanking_desc = "当你启用防御姿态、熊形态或者是开启了正义之怒，你将被认定为坦克。"
L.warnings_flash                    = "启用屏幕闪烁"
L.warnings_sound                    = "启用声音"
L.warnings_threshold                = "警报仇恨阈值 (100% = 仇恨)"
L.warnings_minThreatAmount          = "触发警报的威胁值"
L.warnings_minThreatAmount_desc     = "该值取决于'常规->标定威胁值'设置，并与显示的威胁相匹配。 可以在输入框中设置的数值。"

L.warnings_soundFile                = "设置警报声音"
L.warnings_soundChannel             = "声音通道"

L.soundChannel_master               = "主"
L.soundChannel_sfx                  = "特效"
L.soundChannel_ambience             = "环境"
L.soundChannel_music                = "音乐"
