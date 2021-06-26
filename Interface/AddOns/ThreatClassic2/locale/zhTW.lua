local TC2, C, L, _ = unpack(select(2, ...))
if TC2.locale ~= "zhTW" then return end

-----------------------------
--	zhTW client
-----------------------------
-- main frame
L.gui_threat		= "仇恨"
L.gui_config			= "打開配置"

-- config frame
L.reset					= "重置為默認"

-- messages
L.message_welcome		= "輸入 /tc2 進入設置"
L.message_leader		= "你必須是隊長或者有A"
L.message_outdated		= "|cFFFBB709ThreatClassic2:|r新版本已發布，請去 https://www.curseforge.com/wow/addons/threatclassic2 下載最新版本。"
L.message_incompatible	= "你的 |cFFFBB709ThreatClassic2|r 已過期，因此不兼容，請立即升級。"

L.general				= "一般"
L.general_welcome		= "顯示資訊當你登陸時"
L.general_rawPercent    = "啟用原始威脅百分比 (近戰 110% / 遠程 130% 的仇恨)"   ---
L.general_downscaleThreat = "啟用調整威脅值 (修正後威脅值是1傷害等於1威脅值)"
L.general_downscaleThreatDesc = "暴雪威脅API是每造成1點傷害算100點威脅值。此設置是將威脅API的數字縮減為我們在補丁1.13.5之前使用的數字。"
L.general_updateFreq    = "更新間隔最短時間 (秒)。"   --
L.general_test			= "測試模式."
--L.general_minimap		= "小地圖按鈕."
--L.general_ignorePets	= "忽略玩家寵物的仇恨."

L.visibility			    = "可見性"
L.visibility_hideOOC	    = "當脫戰時隱藏框架"
L.visibility_hideSolo	    = "當不在隊伍中隱藏框架"
L.visibility_hideInPvP	    = "在戰場中隱藏框架"
L.visibility_hideOpenWorld  = "不在團隊中隱藏框架 (也隱藏世界BOSS!)"
L.visibility_hideAlways     = "始終隱藏框架。 /tc2 切換"

L.color					= "顏色"
L.color_good			= "低"
L.color_neutral			= "中"
L.color_bad				= "高"

L.appearance			= "外觀"

L.frame					= "框架"
L.frame_header			= "標題"
L.frame_bg				= "背景"
L.frame_test			= "測試模式"
L.frame_strata			= "層面"
L.frame_scale			= "大小"
L.frame_lock			= "鎖定"
L.frame_headerShow		= "顯示標題"
L.frame_headerColor		= "標題顏色"
L.frame_width			= "寬度"
L.frame_xOffset         = "X 偏移"
L.frame_yOffset         = "Y 偏移"

L.bar					= "仇恨條"
L.bar_descend			= "反向增長"
L.bar_height			= "高度"
L.bar_padding			= "間隔"
L.bar_texture			= "紋理"
L.bar_alpha				= "條透明度 (default colors)"

L.customBarColors 			        = "自定義顏色"
L.customBarColorsPlayer_enabled	    = "啟用自定義玩家顏色"
L.customBarColorsActiveTank_enabled	= "啟用自定義坦克顏色"
L.customBarColorsOtherUnit_enabled 	= "啟用自定義其他玩家顏色"
L.customBarColorsPlayer_color 	    = "玩家顏色"
L.customBarColorsActiveTank_color 	= "主坦克顏色"
L.customBarColorsOtherUnit_color 	= "其他玩家顏色"

L.font					= "字體"
L.font_name			    = "名字"
L.font_size				= "大小"
L.font_style			= "風格"
L.NONE                  = "無"
L.OUTLINE               = "輪廓"
L.THICKOUTLINE          = "粗輪廓"
L.font_shadow			= "字體陰影"

L.warnings				= "警報"
L.warnings_flash        = "啟用屏幕閃爍"
L.warnings_sound		= "啟用聲音"
L.warnings_threshold	= "警報仇恨閾值 (100% = aggro)"
L.warnings_minThreatAmount = "觸發警告的最小威脅"
L.warnings_minThreatAmount_desc = "該值取決於'常規->標定威脅值'設置，並與顯示的威脅相匹配。可以在輸入框中設置更大的數字。"

L.warnings_soundChannel = "聲音通道"
L.warnings_soundFile = "警報音效檔"
L.soundChannel_ambience = "環境"
L.soundChannel_master = "主音"
L.soundChannel_music = "音樂"
L.soundChannel_sfx = "音效"
