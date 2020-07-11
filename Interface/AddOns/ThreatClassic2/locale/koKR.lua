local TC2, C, L, _ = unpack(select(2, ...))
if TC2.locale ~= "koKR" then return end

-----------------------------
--	koKR client (by dudme9)
-----------------------------
-- main frame
L.gui_threat			= "위협"
L.gui_config			= "설정 열기"

-- config frame
L.reset					= "기본값으로 재설정"

-- messages
L.message_welcome		= "명령어 /tc2 입력하여 설정하세요."
L.message_leader		= "그룹리더 이거나 도움이 필요합니다."
L.message_outdated		= "새버전의 LibThreatClassic2 사용 가능! 최신 버전을 다운로드하십시오. 최신 버전은 ThreatClassic2에서 항상 사용할 수 있으며 DBM, Details 및 기타 애드온에서 곧 사용 가능합니다."
L.message_incompatible	= "TC2/LibThreatClassic2가 오래되어 이 그룹과 호환되지 않습니다. 즉시 업그레이드 하세요."

-- version check
L.version				= "버전 점검"
L.version_check			= "구버전 점검"
L.version_check_all		= "모두 점검"
L.version_notify		= "구버전 알림"
L.version_list			= "버전 점검: 모든 클라이언트"
L.version_list_outdated	= "버전 점검: 오래된 클라이언트"
L.version_divider		= "--------------------------------"
L.version_incompatible	= "미호환!"

L.general				= "일반"
L.general_welcome		= "로그인 시 환영 메제시를 표시합니다."
L.general_rawPercent    = "무가공 위협 백분률 표시 (근접 110% 근접 / 원거리 130% 에 어그로)"
L.general_updateFreq    = "업데이트 소요 시간 (초)."
L.general_test			= "테스트 모드 활성화."
L.general_minimap		= "미니맵 아이콘 보기/숨김."
L.general_ignorePets	= "플레이어 펫의 위협을 무시합니다."

L.visibility			= "가시성"
L.visibility_hideOOC	= "전투중이 아닐 때 프레임 숨김."
L.visibility_hideSolo	= "그룹이 아닐 때 프레임 숨김."
L.visibility_hideInPvP	= "전장에서 프레임 숨김."
L.visibility_hideOpenWorld	= "인스턴스 또는 월드보스가 아닐 때 프레임 숨김."
L.visibility_hideAlways	= "항상 프레임 숨김. /tc2 보기/숨김"

L.nameplates			= "이름표"
L.nameplates_enable		= "위협 색상표시 활성화 (블리자드 이름표만 해당)."
L.nameplates_invert		= "위협 색상표시 반전 (탱커 전용)."
L.nameplates_colors		= "위협 색상"

L.profiles              = "프로필"

L.color					= "색상"
L.color_good			= "안전"
L.color_neutral			= "중립"
L.color_bad				= "위험"

L.appearance			= "외형"

L.frame					= "프레임"
L.frame_header			= "제목"
L.frame_bg				= "배경"
L.frame_test			= "테스트 모드"
L.frame_strata			= "계층"
L.frame_scale			= "비율"
L.frame_lock			= "잠김"
L.frame_headerShow		= "제목 표시"
L.frame_headerColor		= "제목 색상"
L.frame_position		= "위치"
L.frame_width			= "너비"
L.frame_height			= "높이"
L.frame_xOffset         = "X 간격"
L.frame_yOffset         = "Y 간격"

L.bar					= "바"
L.bar_count				= "최대 개수"
L.bar_descend			= "증가 반전"
L.bar_height			= "높이"
L.bar_padding			= "간격"
L.bar_marker			= "플레이어 위협 빨간색"
L.bar_texture			= "질감"
L.bar_classColor		= "직업색상 사용"
L.bar_defaultColor		= "사용자정의 색상"
L.bar_alpha				= "바 투명도 (기본 색상)"
L.bar_colorMod			= "색상 조정"

L.customBarColors 			        = "사용자정의 바 색상"
L.customBarColorsPlayer_enabled	    = "사용자정의 플레이어 색상 사용"
L.customBarColorsActiveTank_enabled	= "사용자정의 활성 탱커 색상 사용"
L.customBarColorsOtherUnit_enabled 	= "사용자정의 다른 유닛 색상 사용"
L.customBarColorsPlayer_color 	    = "플레이어 색상"
L.customBarColorsActiveTank_color 	= "활성 탱커 색상"
L.customBarColorsOtherUnit_color 	= "다른 유닛 색상"

L.font					= "글꼴"
L.font_name			    = "이름"
L.font_size				= "크기"
L.font_style			= "스타일"
L.font_shadow			= "그림자"

L.warnings				= "경보"
L.warnings_flash		= "화면 번쩍임 사용."
L.warnings_sound		= "경보음 활성화."
L.warnings_threshold	= "경보 한계점 (100% = 어그로)."
L.warnings_minThreatAmount = "경보를 유발하는 최소 위협값."

L.warnings_soundFile	= "경보음 파일"
L.warnings_soundChannel	= "경보음 채널"

L.soundChannel_master = "주 소리"
L.soundChannel_sfx = "효과음"
L.soundChannel_ambience = "환경 소리"
L.soundChannel_music = "음악"
