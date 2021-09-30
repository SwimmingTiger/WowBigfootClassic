local TC2, C, L, _ = unpack(select(2, ...))
if TC2.locale ~= "zhTW" then return end

-----------------------------
--    zhTW client (奇樂-[三皈依-暗影之月]補完)
--  Last update: 2021/08/06
-----------------------------
-- main frame
L.gui_threat                         = "仇恨"
L.gui_config                         = "開啟設定選項"

-- config frame
L.reset                              = "重置為預設"

-- messages
L.message_welcome                    = "輸入 /tc2 進入設置"
L.message_leader                     = "你必須是隊長或者有權限"
L.message_outdated                   = "|cFFFBB709ThreatClassic2:|r新版本已發布，請去 https://www.curseforge.com/wow/addons/threatclassic2 下載最新版本。"
L.message_incompatible               = "你的 |cFFFBB709ThreatClassic2|r 已過期，因此不兼容，請立即升級。"

L.general                            = "一般"
L.general_welcome                    = "顯示資訊當你登入時"
L.general_rawPercent                 = "啟用原始威脅百分比 (近戰 110% / 遠程 130% 的仇恨)" 
L.general_downscaleThreat            = "啟用調整威脅值 (修正後威脅值是1傷害等於1威脅值)"
L.general_downscaleThreatDesc        = "暴雪威脅API是每造成1點傷害算100點威脅值。此設置是將威脅API的數字縮減為我們在補丁1.13.5之前使用的數字。"
L.general_updateFreq                 = "更新間隔最短時間 (秒)。" 
L.general_updateFreq_desc            = "這個設置是為了限制tc2更新時的CPU消耗(例如，在targettarget模式下)。一般來說，威脅值不能更新得更快，因為暴雪的API更新速度限制了它們。"
L.general_test                       = "測試模式。"
--L.general_minimap                    = "小地图按钮."  --You can't find this option, you can delete it.
--L.general_ignorePets                 = "忽略玩家寵物的仇恨。"  --You can't find this option, you can delete it.

L.visibility                         = "可見性"
L.visibility_hideOOC                 = "脫戰時隱藏"
L.visibility_hideSolo                = "不在隊伍中隱藏"
L.visibility_hideInPvP               = "戰場中隱藏"
L.visibility_hideOpenWorld           = "不在團隊中隱藏 (也隱藏世界BOSS!)。"
L.visibility_hideAlways              = "始終隱藏。 /tc2 切換"

L.profiles                           = "設定檔"

L.color                              = "顏色"

L.appearance                         = "外觀"

L.frame                              = "框架"
L.frame_header                       = "標題"
L.frame_bg                           = "背景"
L.frame_test                         = "測試模式"
L.frame_strata                       = "層級"
L.frame_scale                        = "大小"
L.frame_lock                         = "鎖定"
L.frame_headerShow                   = "顯示標題"
L.frame_headerColor                  = "標題顏色"  
L.frame_position                     = "位置"
L.frame_width                        = "寬度"
L.frame_height                       = "高度"
L.frame_xOffset                      = "X 偏移"
L.frame_yOffset                      = "Y 偏移"

L.bar                                = "仇恨條"
L.bar_descend                        = "反向增長"  
L.bar_height                         = "高度"
L.bar_padding                        = "間隔"
L.bar_texture                        = "材質"
L.bar_alpha                          = "透明度 (預設顏色)"
L.bar_textOptions                    = "文本選項"
L.bar_showThreatValue                = "顯示威脅值"
L.bar_showThreatPercentage           = "顯示威脅比例"
L.bar_showIgniteIndicator            = "顯示點燃指示器"
L.bar_showIgniteIndicator_desc       = "在當前擁有“點燃”的玩家名字旁邊顯示一個小的“點燃”圖標"

L.backdrop                           = "計時條背景"
L.backdrop_bgTexture                 = "背景材質"
L.backdrop_bgColor                   = "背景顏色"
L.backdrop_edge                      = "計時條邊框"
L.backdrop_edgeTexture               = "邊框材質"
L.backdrop_edgeColor                 = "邊框顏色"
L.backdrop_edgeSize                  = "邊框尺寸"

L.igniteIndicator                    = "點燃指示器"
L.igniteIndicator_makeRound          = "圓形圖標"
L.igniteIndicator_makeRound_desc     = "使用圓形圖標，需要重新載入"
L.igniteIndicator_size               = "大小"

L.customBarColors                    = "自定義顏色"
L.customBarColorsPlayer_enabled      = "啟用自定義玩家顏色"
L.customBarColorsPlayer_desc         = "這個選項為玩家設置一個固定的顏色，而不考慮其他任何顏色選項。"
L.customBarColorsActiveTank_enabled  = "啟用自定義坦克顏色"
L.customBarColorsOtherUnit_enabled   = "啟用自定義其他玩家顏色"
L.customBarColorsIgnite_enabled      = "啟用點燃的顏色"
L.customBarColorsIgnite_desc         = "這將改變狀態條的顏色，如果目標上存在該玩家的點燃技能。坦克和玩家顏色有優先級。"
L.customBarColorsPlayer_color        = "玩家顏色"
L.customBarColorsActiveTank_color    = "主坦克顏色"
L.customBarColorsOtherUnit_color     = "其他玩家顏色"
L.customBarColorsIgnite_color        = "點燃玩家顏色"

L.font                               = "字體"
L.font_name                          = "字體選擇"
L.font_size                          = "大小"
L.font_style                         = "風格"
L.NONE                               = "無"
L.OUTLINE                            = "輪廓"
L.THICKOUTLINE                       = "粗輪廓"
L.font_shadow                        = "字體陰影"

L.filter                             = "過濾器"
L.filter_outOfMelee                  = "隱藏不在近戰範圍內的玩家"
L.filter_useTargetList               = "僅針對列出的目標過濾玩家"
L.filter_targetList                  = "過濾目標列表（Shift+Enter鍵來分隔）"
L.filter_targetList_desc             = "輸入要過濾的首領或其他的單位。每行一個。注意:需要添加準確的名稱，例如：屠龍者格魯爾"

L.warnings                           = "警報"
L.warnings_disableWhileTanking       = "坦克時禁用"
L.warnings_disableWhileTanking_desc  = "當你啟用防御姿態或熊形態或啟用了正義之怒時，你被認定為坦克。"
L.warnings_flash                     = "啟用螢幕閃爍"
L.warnings_sound                     = "啟用聲音"
L.warnings_threshold                 = "警報仇恨閥值 (100% = 仇恨)"
L.warnings_minThreatAmount           = "觸發警告的威脅值"
L.warnings_minThreatAmount_desc      = "該值取決於'常規->標定威脅值'設置，並與顯示的威脅相匹配。可以在輸入框中設置更大的數字。"

L.warnings_soundFile                 = "警報音效檔"
L.warnings_soundChannel              = "聲音通道"

L.soundChannel_master                = "主要"
L.soundChannel_sfx                   = "音效"
L.soundChannel_ambience              = "環境"
L.soundChannel_music                 = "音樂"
