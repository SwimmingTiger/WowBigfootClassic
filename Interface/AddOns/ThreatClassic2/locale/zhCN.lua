local TC2, C, L, _ = unpack(select(2, ...))
if TC2.locale ~= "zhCN" then return end

-----------------------------
--	zhCN client (by Qcat of 60Addons & 阿什坎迪-枫聖)
--  Last update: 2020/07/09
-----------------------------
-- main frame
L.gui_threat			= "仇恨"
L.gui_config			= "打开配置"

-- config frame
L.reset					= "重置为默认"

-- messages
L.message_welcome		= "输入 /tc2 进入设置"
L.message_leader		= "你必须是队长或者有权限"
L.message_outdated		= "|cFFFBB709ThreatClassic2:|r 新版本已发布，请去 https://www.curseforge.com/wow/addons/threatclassic2 下载最新版本。"
L.message_incompatible	= "你的 |cFFFBB709ThreatClassic2|r 已过期，因此不兼容，请立即升级。"

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
L.general_welcome		= "登录时显示信息。"
L.general_rawPercent    = "显示原始威胁百分比 (近战 110% / 远程 130% 的仇恨)"   ---
L.general_downscaleThreat = "调整威胁值 (因此1伤害等于修正前1威胁值)"
L.general_downscaleThreatDesc = "暴雪威胁API是每造成1点伤害算100点威胁值。 此设置将威胁API的数字缩减为我们在补丁1.13.5之前使用的数字。"
L.general_updateFreq    = "更新间隔的最短时间（以秒为单位）。"   --
L.general_test			= "测试模式。"
--L.general_minimap		= "小地图按钮."  --You can't find this option, you can delete it.
--L.general_ignorePets	= "忽略玩家宠物的仇恨."  --You can't find this option, you can delete it.

L.visibility			= "可见性"
L.visibility_hideOOC	= "当脱战时隐藏框架"
L.visibility_hideSolo	= "当不在队伍中隐藏框架"
L.visibility_hideInPvP	= "在战场中隐藏框架"
L.visibility_hideOpenWorld	= "不在团队中隐藏框架 (也隐藏世界BOSS!)。"
L.visibility_hideAlways	= "始终隐藏框架。输入 /tc2  进入设置界面"

L.profiles              = "配置"

L.color					= "颜色设置"

L.appearance			= "外观"

L.frame					= "框架"
L.frame_header			= "标题"
L.frame_bg				= "背景"
L.frame_test			= "测试模式"
L.frame_strata			= "层面"
L.frame_scale			= "大小"
L.frame_lock			= "锁定"
L.frame_headerShow		= "显示标题"
--L.frame_headerColor		= "标题颜色"  --You can't find this option, you can delete it.
L.frame_position		= "位置"--
L.frame_width			= "宽度"
L.frame_height			= "高度"
L.frame_xOffset         = "X 偏移"
L.frame_yOffset         = "Y 偏移"---

L.bar					= "仇恨条"
--L.bar_descend			= "反向增长"  --You can't find this option, you can delete it.
L.bar_height			= "高度"
L.bar_padding			= "间隔"
L.bar_texture			= "纹理"
L.bar_alpha				= "透明度 (默认颜色)"

L.customBarColors 			        = "自定义颜色"
L.customBarColorsPlayer_enabled	    = "启用自定义玩家颜色"
L.customBarColorsActiveTank_enabled	= "启用自定义坦克颜色"
L.customBarColorsOtherUnit_enabled 	= "启用自定义其他玩家颜色"
L.customBarColorsPlayer_color 	    = "玩家颜色"
L.customBarColorsActiveTank_color 	= "主坦克颜色"
L.customBarColorsOtherUnit_color 	= "其他玩家颜色"

L.font					= "字体"
L.font_name			    = "字体选择"
L.font_size				= "大小"
L.font_style			= "样式"
L.font_shadow			= "字体阴影"

L.warnings				= "警报"
L.warnings_flash		= "启用屏幕闪烁"
L.warnings_sound		= "启用声音"
L.warnings_threshold	= "警报仇恨阈值 (100% = 仇恨)"
L.warnings_minThreatAmount = "触发警告的最小威胁"

L.warnings_soundFile		= "设置警报声音"
L.warnings_soundChannel	= "声音通道"

L.soundChannel_master = "主"
L.soundChannel_sfx = "特效"
L.soundChannel_ambience = "环境"
L.soundChannel_music = "音乐"

