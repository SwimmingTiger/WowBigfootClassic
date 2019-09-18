local CTM, C, L, _ = unpack(select(2, ...))
if CTM.locale ~= "zhTW" then return end

-- 老虎会游泳：繁体中文翻译不完整，所以复制了简体中文翻译
-----------------------------
--	zhCN client
-----------------------------
-- main frame
L.gui_threat			= "仇恨"
L.gui_config			= "打开配置"

-- config frame
L.reset					= "重置为默认"

-- messages
L.message_welcome		= "输入 /ctm 进入设置"
L.message_leader		= "你必须是队长或者有A"
L.message_outdated		= "新版本CTM发现! 请下载最新版本."
L.message_incompatible	= "CTM 已过期或不兼容.请立即升级."

-- version check
L.version				= "版本检查"
L.version_check			= "检查过期"
L.version_check_all		= "检查所有"
L.version_notify		= "通知过期的"
L.version_list			= "版本检查: 所有客户端"
L.version_list_outdated	= "版本检查: 过期的客户端"
L.version_divider		= "--------------------------------"
L.version_incompatible	= "不兼容！"

L.general				= "一般"
L.general_welcome		= "显示欢迎信息当你登陆时."
L.general_update		= "更新间隔时间 (秒)"
L.general_test			= "测试模式."
L.general_minimap		= "小地图按钮."
L.general_ignorePets	= "忽略玩家宠物的仇恨."

L.visibility			= "可见性"
L.visibility_hideOOC	= "当脱战时隐藏框架."
L.visibility_hideSolo	= "当不在队伍中隐藏框架"
L.visibility_hideInPvP	= "在战场中隐藏框架"

L.nameplates			= "姓名版"
L.nameplates_enable		= "启用仇恨着色 (仅暴雪默认姓名版)."
L.nameplates_invert		= "颠倒仇恨着色 (便于坦克)."
L.nameplate_colors		= "仇恨颜色"

L.color					= "颜色"
L.color_good			= "低"
L.color_neutral			= "中"
L.color_bad				= "高"

L.appearance			= "外观"

L.frame					= "框架"
L.frame_header			= "标题"
L.frame_bg				= "背景"
L.frame_test			= "测试模式"
L.frame_strata			= "Strata"
L.frame_scale			= "大小"
L.frame_lock			= "锁定"
L.frame_headerShow		= "显示标题"
L.frame_headerColor		= "标题颜色"
L.frame_width			= "宽度"

L.bar					= "仇恨条"
L.bar_count				= "最大数量"
L.bar_descend			= "反向增长"
L.bar_height			= "高度"
L.bar_padding			= "间隔"
L.bar_marker			= "你在条中为红色"
L.bar_texture			= "纹理"
L.bar_classColor		= "使用职业颜色"
L.bar_defaultColor		= "自定义颜色"
L.bar_alpha				= "条透明度"
L.bar_colorMod			= "颜色调节"

L.font					= "字体"
L.font_family			= "名字"
L.font_size				= "大小"
L.font_style			= "风格"
L.font_shadow			= "字体阴影"

L.warnings				= "警报"
L.warnings_visual		= "启用全可视屏幕警报."
L.warnings_sounds		= "启用声音."
L.warnings_threshold	= "警报仇恨阈值 (0-100%)."

L.sound_warningFile		= "警报声音文件."
L.sound_pulledFile		= "获得仇恨警报的声音文件."


-----------------------------
--	zhTW client
-----------------------------
-- main frame
L.gui_threat		= "威脅"

-- config frame
L.default			= "預設值"
