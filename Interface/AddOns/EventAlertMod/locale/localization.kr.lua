-- Prevent tainting global _.
local _
local _G = _G

if GetLocale() == "koKR" then 


EA_TTIP_DOALERTSOUND = "주문 발동시 효과음을 재생합니다."
EA_TTIP_ALERTSOUNDSELECT = "이벤트 발동시 들려줄 효과음을 선택합니다."
EA_TTIP_LOCKFRAME = "경보 창이 움직이지 않도록 잠급니다."
EA_TTIP_SHARESETTINGS = "All classes share the same settings for alert frame positions."
EA_TTIP_SHOWFRAME = "애드온을 사용하거나 사용하지 않습니다."
EA_TTIP_SHOWNAME = "주문 발동시 주문의 이름을 표시합니다."
EA_TTIP_SHOWFLASH = "주문 발동시 전체 화면 반짝임 효과를 표시합니다."
EA_TTIP_SHOWTIMER = "주문 발동시 주문 지속시간을 표시합니다."
EA_TTIP_CHANGETIMER = "글꼴과 남은 시간의 위치를 변경합니다."
EA_TTIP_ICONSIZE = "경보 아이콘의 크기를 변경합니다."
-- EA_TTIP_ICONSPACE = "경보 아이콘의 특성을 변경합니다."
-- EA_TTIP_ICONDROPDOWN = "아이콘의 방향을 변경합니다."
EA_TTIP_ALLOWESC = "경보 창을 ESC 키로 닫을 수 있도록 변경합니다. (노트: UI 재시작이 필요합니다.)"
EA_TTIP_ALTALERTS = "활성화류 버프 경보를 표시합니다."

EA_TTIP_ICONXOFFSET = "경보 아이콘의 수평 간격을 변경합니다."
EA_TTIP_ICONYOFFSET = "경보 아이콘의 수직 간격을 변경합니다."
EA_TTIP_ICONREDDEBUFF = "붉은색의 디버프 아이콘의 밝기를 변경합니다."
EA_TTIP_ICONGREENDEBUFF = "녹색의 대상 디버프 아이콘의 밝기를 변경합니다."
EA_TTIP_ICONEXECUTION = "경보 실행을 위한 우두머리 생명력 백분율을 변경합니다."
EA_TTIP_PLAYERLV2BOSS = "대상의 레벨이 플레이어보다 2레벨 높다면, 우두머리 실행으로 전환합니다."
EA_TTIP_SCD_USECOOLDOWN = "Skill Cooldown frames can use cooldown style or normal style (must reload UI to take effect)."
EA_TTIP_TAR_NEWLINE = "새로운 라인에 대상의 디버프 표시 상태를 전환합니다."
EA_TTIP_TAR_ICONXOFFSET = "경보 창과의 수평 간격을 조절합니다."
EA_TTIP_TAR_ICONYOFFSET = "경보 창과의 수직 간격을 조절합니다."
EA_TTIP_TARGET_MYDEBUFF = "플레이어가 대상에 시전한 디버프만 표시합니다."
EA_TTIP_SPELLCOND_STACK = "중첩이 >= n (최소:2) 일때 주문 경고를 표시합니다."
EA_TTIP_SPELLCOND_SELF = "자신이 시전한 주문을 표시합니다."
EA_TTIP_SPELLCOND_OVERGROW = "중첩이 >= n (최소:1) 일때 주문 경고를 강조합니다."
EA_TTIP_SPELLCOND_REDSECTEXT = "재사용 대기시간이 <= n (최소:1) 일때 붉은색 문자로 초단위를 표시합니다."
EA_TTIP_SPELLCOND_ORDERWTD = "아이콘의 순서(1-20)를 설정합니다. 큰 숫자의 위치는 내부입니다."


EA_TTIP_SPECFLAG_CHECK_MANA = "자기 버프의 왼쪽 첫번째 위치에 마나 힘을 표시합니다."
EA_TTIP_SPECFLAG_CHECK_HOLYPOWER = "자기 버프의 왼쪽 첫번째 위치에 성스러운 힘을 표시합니다."
EA_TTIP_SPECFLAG_CHECK_RUNICPOWER = "자기 버프의 왼쪽 첫번째 위치에 룬 파워를 표시합니다"
EA_TTIP_SPECFLAG_CHECK_RUNES = "Show DK's Runes in the left 1st position of Self-Buffs"	
EA_TTIP_SPECFLAG_CHECK_SOULSHARDS = "자기 버프의 왼쪽 첫번째 위치에 영혼석을 표시합니다"
EA_TTIP_SPECFLAG_CHECK_LUNARPOWER = "자기 버프의 왼쪽 첫번째 위치에 월식을 표시합니다"
EA_TTIP_SPECFLAG_CHECK_COMBOPOINT = "대상의 디버프 왼쪽 첫번째 위치에 연계포인트를 표시합니다."
EA_TTIP_SPECFLAG_CHECK_LIFEBLOOM = "자기 버프의 왼쪽 첫번째 위치에 피어나는 생명 지속시간과 중첩을 표시합니다."
EA_TTIP_SPECFLAG_CHECK_RAGE = "Show Rage in the left 1st position of Self-Buffs"						
EA_TTIP_SPECFLAG_CHECK_FOCUS = "Show Focus in the left 1st position of Self-Buffs"						
EA_TTIP_SPECFLAG_CHECK_FOCUS_PET = "Show Pet's Focus in the left 2nd position of Self-Buffs"						
EA_TTIP_SPECFLAG_CHECK_ENERGY = "Show Energy in the left 1st position of Self-Buffs"			
EA_TTIP_SPECFLAG_CHECK_CHI = "Show Chi of Monk in the left 1st position of Self-Buffs"	
EA_TTIP_SPECFLAG_CHECK_INSANITY = "Show Insanity in the left 1st position of Self-Buffs"	
EA_TTIP_SPECFLAG_CHECK_DEMONICFURY = "Show Demonic Fury in the left 1st position of Self-Buffs"	
EA_TTIP_SPECFLAG_CHECK_BURNINGEMBERS = "Show Burning Embers in the left 1st position of Self-Buffs"	
EA_TTIP_SPECFLAG_CHECK_ARCANECHARGES = "Show Mage's Arcane Charges in the left 1st position of Self-Buffs"	
EA_TTIP_SPECFLAG_CHECK_MAELSTROM = "Show Shaman's Maelstrom Charges in the left 1st position of Self-Buffs"	
EA_TTIP_SPECFLAG_CHECK_FURY = "Show Demonhunter's Fury  in the left 1st position of Self-Buffs"	
EA_TTIP_SPECFLAG_CHECK_PAIN = "Show Demonhunter's Pain  in the left 1st position of Self-Buffs"	

EA_TTIP_GRPCFG_ICONALPHA = "이 아이콘의 투명도를 변경합니다."
EA_TTIP_GRPCFG_TALENT = "이 특성에만 활성화 합니다."
EA_TTIP_GRPCFG_HIDEONLEAVECOMBAT = "비 전투 상태일때 숨깁니다."
EA_TTIP_GRPCFG_HIDEONLOSTTARGET = "대상이 없을때 숨깁니다."

EA_TTIP_GRPCFG_GLOWWHENTRUE = "조건이 참일 때 빛납니다."

EA_XOPT_ICONPOSOPT = "아이콘 위치 옵션"
EA_XOPT_SHOW_ALTFRAME = "경보 창 표시"
EA_XOPT_SHOW_BUFFNAME = "버프 이름 표시"
EA_XOPT_SHOW_TIMER = "타이머 표시"
EA_XOPT_SHOW_OMNICC = "창에 타이머 표시"
EA_XOPT_SHOW_FULLFLASH = "전체 화면 반짝임 경보 표시"
EA_XOPT_PLAY_SOUNDALERT = "효과음 사용"
EA_XOPT_ESC_CLOSEALERT = "ESC 키로 경보 창 닫기"
EA_XOPT_SHOW_ALTERALERT = "활성화류 버프 경보 사용"
EA_XOPT_SHOW_CHECKLISTALERT = "사용"
EA_XOPT_SHOW_CLASSALERT = "직업 경보 표시"
EA_XOPT_SHOW_OTHERALERT = "기타 경보 표시"
EA_XOPT_SHOW_TARGETALERT = "대상 경보 표시"
EA_XOPT_SHOW_SCDALERT = "대기시간 경보 표시"
EA_XOPT_SHOW_GROUPALERT = "그룹 경보 표시"
EA_XOPT_OKAY = "확인"
EA_XOPT_SAVE = "저장"
EA_XOPT_CANCEL = "취소"
EA_XOPT_VERURLTEXT = "EAM 업데이트 사이트:"
EA_XOPT_VERBTN1 = "Gamer"
EA_XOPT_VERURL1 = "http://forum.gamer.com.tw/Co.php?bsn=05219&sn=5125122&subbsn=0"
EA_XOPT_SPELLCOND_STACK = "중첩일때 주문 표시 (중첩 >=)"
EA_XOPT_SPELLCOND_SELF = "자신의 주문 시전"
EA_XOPT_SPELLCOND_OVERGROW = "주문 강조 (중첩 >=)"
EA_XOPT_SPELLCOND_REDSECTEXT = "붉은색 재사용 대기시간 문자 (초<=)"
EA_XOPT_SPELLCOND_ORDERWTD = "우선 순위 (1-20):"

EA_XICON_LOCKFRAME = "창 잠금"
EA_XICON_LOCKFRAMETIP = "창의 위치를 이동하려면 창 잠금을 해제하셔야 합니다."
EA_XICON_SHARESETTING = "Share alert frame positions"
EA_XICON_ICONSIZE = "아이콘 크기"
-- EA_XICON_ICONSIZE2 = "대상 아이콘 크기"
-- EA_XICON_ICONSIZE3 = "재사용 대기시간 아이콘 크기"
EA_XICON_LARGE = "크게"
EA_XICON_SMALL = "작게"
EA_XICON_HORSPACE = "수평 간격"
EA_XICON_VERSPACE = "수직 간격"
-- EA_XICON_ICONSPACE1 = "자신 아이콘 간격"
-- EA_XICON_ICONSPACE2 = "대상 아이콘 간격"
-- EA_XICON_ICONSPACE3 = "재사용 대기시간 아이콘 간격"
EA_XICON_MORE = "넓게"
EA_XICON_LESS = "좁게"
EA_XICON_REDDEBUFF = "붉은색의 디버프 아이콘"
EA_XICON_GREENDEBUFF = "녹색의 대상 디버프 아이콘"
EA_XICON_DEEP = "어둡게"
EA_XICON_LIGHT = "밟게"
-- EA_XICON_DIRECTION = "방향"
-- EA_XICON_DIRUP = "위"
-- EA_XICON_DIRDOWN = "아래"
-- EA_XICON_DIRLEFT = "왼쪽"
-- EA_XICON_DIRRIGHT = "오른쪽"
EA_XICON_TAR_NEWLINE = "새로운 라인에 대상의 디버프"
EA_XICON_TAR_HORSPACE = "경보 창과의 수평 간격"
EA_XICON_TAR_VERSPACE = "경보 창과의 수직 간격"
EA_XICON_TOGGLE_ALERTFRAME = "경보 샘플 표시"
EA_XICON_RESET_FRAMEPOS = "창 위치 초기화"
EA_XICON_SELF_BUFF = "자신의 버프"
EA_XICON_SELF_SPBUFF = "자신의 디버프(1)\n또는 특성 창"
EA_XICON_SELF_DEBUFF = "자신의 디버프"
EA_XICON_TARGET_BUFF = "대상의 버프"
EA_XICON_TARGET_SPBUFF = "대상의 버프(1)\n또는 특성 창"
EA_XICON_TARGET_DEBUFF = "대상의 디버프"
EA_XICON_SCD = "지속시간"
EA_XICON_EXECUTION = "실행을 위한 우두머리 생명력 백분율"
EA_XICON_EXEFULL = "50%"
EA_XICON_EXECLOSE = "닫기"
EA_TTIP_SCD_USECOOLDOWN = "Use cooldown countdown (must reload UI)."

EX_XCLSALERT_SELALL = "모두 선택"
EX_XCLSALERT_CLRALL = "모두 제거"
EX_XCLSALERT_LOADDEFAULT = "기본값 불려오기"
EX_XCLSALERT_REMOVEALL = "Del All"
EX_XCLSALERT_SPELL = "주문ID:"
EX_XCLSALERT_ADDSPELL = "추가"
EX_XCLSALERT_DELSPELL = "삭제"
EX_XCLSALERT_HELP1 = "주문은 ID 순서로 정렬됩니다."
EX_XCLSALERT_HELP2 = "주문 ID 는 [] 기호 안쪽에 표시됩니다."
EX_XCLSALERT_HELP3 = "주문 ID를 찾으려면 아래 주소를 참고하세요:"
EX_XCLSALERT_HELP4 = "특정 조건 만족시"
EX_XCLSALERT_HELP5 = "활성화 되는 주문입니다."
EX_XCLSALERT_HELP6 = "예: 적의 낮은 생명력, 회피...기타."
EX_XCLSALERT_SPELLURL = "http://www.wowhead.com/spells"

EA_XTARALERT_TARGET_MYDEBUFF = "자신이 시전한 디버프만"

EA_XGRPALERT_ICONALPHA = "아이콘 투명도"
EA_XGRPALERT_GRPID = "그룹ID:"
EA_XGRPALERT_TALENT1 = "특성1"
EA_XGRPALERT_TALENT2 = "특성2"
EA_XGRPALERT_TALENT3 = "특성3"
EA_XGRPALERT_TALENT4 = "특성4"
EA_XGRPALERT_HIDEONLEAVECOMBAT = "비 전투시 숨김"
EA_XGRPALERT_HIDEONLOSTTARGET = "대상 없을때 숨김"

EA_XGRPALERT_GLOWWHENTRUE = "광선 아이콘"

EA_XGRPALERT_TALENTS = "모든 특성"
EA_XGRPALERT_NEWSPELLBTN = "주문 추가"
EA_XGRPALERT_NEWCHECKBTN = "체크 추가"
EA_XGRPALERT_NEWSUBCHECKBTN = "하위 체크 추가"
EA_XGRPALERT_SPELLNAME = "주문 이름:"
EA_XGRPALERT_SPELLICON = "주문 아이콘:"
EA_XGRPALERT_TITLECHECK = "체크:"
EA_XGRPALERT_TITLESUBCHECK = "하위 체크:"
EA_XGRPALERT_TITLEORDERUP = "순서 위로"
EA_XGRPALERT_TITLEORDERDOWN = "순서 아래로"
EA_XGRPALERT_LOGICS = {
	[1]={text="그리고", value=1},
	[2]={text="또는", value=0}, }
EA_XGRPALERT_EVENTTYPE = "이벤트 형태:"
EA_XGRPALERT_EVENTTYPES = {
	[1]={text="유닛 파워 변경", value="UNIT_POWER_UPDATE"},
	[2]={text="유닛 생명력 변경", value="UNIT_HEALTH"},
	[3]={text="유닛 오라 변경", value="UNIT_AURA"},
	[4]={text="연계 포인트 변경", value="UNIT_COMBO_POINTS"}, }
EA_XGRPALERT_UNITTYPE = "유닛 형태:"
EA_XGRPALERT_UNITTYPES = {
	[1]={text="플레이어", value="player"},
	[2]={text="대상", value="target"},
	[3]={text="주시 대상", value="focus"},
	[4]={text="소환수", value="pet"},
	[5]={text="보스 1", value="boss1"},
	[6]={text="보스 2", value="boss2"},
	[7]={text="보스 3", value="boss3"},
	[8]={text="보스 4", value="boss4"},
	[9]={text="파티원 1", value="party1"},
	[10]={text="파티원 2", value="party2"},
	[11]={text="파티원 3", value="party3"},
	[12]={text="파티원 4", value="party4"},
	[13]={text="Raid 1", value="raid1"},
	[14]={text="Raid 2", value="raid2"},
	[15]={text="Raid 3", value="raid3"},
	[16]={text="Raid 4", value="raid4"},
	[17]={text="Raid 5", value="raid5"},
	[18]={text="Raid 6", value="raid6"},
	[19]={text="Raid 7", value="raid7"},
	[20]={text="Raid 8", value="raid8"},
	[21]={text="Raid 9", value="raid9"},
}

EA_XGRPALERT_CHECKCD = "대기시간 체크:"

EA_XGRPALERT_HEALTH = "생명력:"

EA_XGRPALERT_COMPARETYPES = {
	[1]={text="값", value=1},
	[2]={text="백분율", value=2},
}
EA_XGRPALERT_CHECKAURA = "오라:"
EA_XGRPALERT_CHECKAURAS = {
	[1]={text="존재", value=1},
	[2]={text="존재 하지 않음", value=2},
}
EA_XGRPALERT_AURATIME = "시간:"
EA_XGRPALERT_AURASTACK = "중첩:"
EA_XGRPALERT_CASTBYPLAYER = "자신의 시전"
EA_XGRPALERT_COMBOPOINT = "연계 포인트:"

EA_XLOOKUP_START1 = "주문 이름 검색"
EA_XLOOKUP_START2 = "전체 검색"
EA_XLOOKUP_RESULT1 = "검색 결과"
EA_XLOOKUP_RESULT2 = "개 검색"
EA_XLOAD_LOAD = "\124cffFFFF00EventAlertMod\124r:특정 이벤트 경보기를 불려옵니다. 버전:\124cff00FFFF"

EA_XLOAD_FIRST_LOAD = "\124cffFF0000EventAlertMod first load detected. Load the default settings.\124r\n\n"..
"Use \124cffFFFF00/eam opt\124r to set all settings for your using.\n\n"

EA_XLOAD_NEWVERSION_LOAD = "Use \124cffFFFF00/eam help\124r to read the command usages.\n\n\n"..
"\124cff00FFFF- Update New Features -\124r\n\n"..
"1.Five Alert-Types: Class, Target, Other(X-Class), Spell CD, and Group Alerts. "..
	"Players can adjust all spell-list of all alert-types in the WOW. "..
	"All adjusts will be apply immediately when you save. Needn't to relogin WOW. "..
	"The Group Alerts can provide you multi-spells show in one frame. "..
	"And each spells can set it's own conditions to determine show/hide.\n\n"..
"2.More Commands: For players to find out self buff/debuff, target's buff/debuff, "..
	"boss skills...etc in game. And also can use Spell-Name to find out the spells. "..
	"Please use [/eam help] to read more helps about EAM commands.\n\n"..
"3.Class Special Alert: Combo Points, Holy Power, Eclipse, Soul Shards, Runic Power. "..
	"These Special Alert will auto-display for the class in the WOW. "..
	"You can toggle this on or off in the Icon Position Setting.\n\n"..
"4.Colours: The debuffs of self/target will display in red/green color. "..
	"Player can change it dynamically in [/eam opt].\n\n"..
"" -- END OF NEWVERSION

EA_XCMD_VER = " \124cff00FFFFBy ACDACD@TW-REALM\124r 버전: "
EA_XCMD_DEBUG = " 디버그 모드: "
EA_XCMD_SELFLIST = " 플레이어 버프 및 디버프 표시: "
EA_XCMD_TARGETLIST = " 대상의 디버프 표시: "
EA_XCMD_CASTSPELL = " 시전한 주문 ID 표시: "
EA_XCMD_AUTOADD_SELFLIST = " 자동으로 모든 플레이어의 버프 및 디버프 추가: "
EA_XCMD_ENVADD_SELFLIST = " 자동으로 모든 플레이어의 버프 및 디버프 추가 (공격대 제외): "
EA_XCMD_DEBUG_P0 = "경보 주문 목록"
EA_XCMD_DEBUG_P1 = "주문"
EA_XCMD_DEBUG_P2 = "주문-ID"
EA_XCMD_DEBUG_P3 = "중첩"
EA_XCMD_DEBUG_P4 = "지속시간"

EA_XCMD_CMDHELP = {
	["TITLE"] = "\124cffFFFF00EventAlertMod\124r \124cff00FF00명령어\124r(/eventalertmod 또는 /eam):",
	["OPT"] = "\124cff00FF00/eam options(/eam opt)\124r - 옵션 창을 열거나 닫습니다.",
	["HELP"] = "\124cff00FF00/eam help\124r - 고급 명령어 도움말을 표시합니다.",
	["SHOW"] = {
		"\124cff00FF00/eam show [초]\124r -",
		"모드를 켜거나 끕니다. 플레이어에게 시전된 지속시간[초]이 있는 모든 버프 및 디버프의 목록을 표시합니다.",
	},
	["SHOWT"] = {
		"\124cff00FF00/eam showtarget(/eam showt) [초]\124r -",
		"모드를 켜거나 끕니다. 대상에게 시전된 지속시간[초]이 있는 모든 디버프의 목록을 표시합니다.",
	},
	["SHOWC"] = {
		"\124cff00FF00/eam showcast(/eam showc)\124r -",
		"모드를 켜거나 끕니다. 성공적으로 시전한 주문 ID|1을를 표시합니다.",
	},
	["SHOWA"] = {
		"\124cff00FF00/eam showautoadd(/eam showa) [초]\124r -",
		"모드를 켜거나 끕니다. 자동으로 지속시간[초(기본 60)]이 있는 플레이어의 모든 버프 및 디버프를 추가합니다.",
	},
	["SHOWE"] = {
		"\124cff00FF00/eam showenvadd(/eam showe) [초]\124r -",
		"모드를 켜거나 끕니다. 자동으로 지속시간[초(기본 60)]이 있는 플레이어의 모든 버프 및 디버프를 추가합니다. (파티 및 공격대 버프 및 디버프 제외)",
	},
	["LIST"] = {
		"\124cff00FF00/eam list\124r - EA의 명령 출력을 표시합니다.",
		"다음 명령어의 목록을 표시하거나 숨깁니다: showc, showt, lookup, lookupfull.",
	},
	["LOOKUP"] = {
		"\124cff00FF00/eam lookup(/eam l) 주문이름\124r - 주문 이름 검색이 부분 일치하면 표시합니다.",
		"WOW의 모든 주문을 검색합니다. 주문 이름이 부분 일치하면 주문 목록을 표시합니다.",
	},
	["LOOKUPFULL"] = {
		"\124cff00FF00/eam lookupfull(/eam lf) 주문이름\124r - 주문 이름 검색이 모두 일치하면 표시합니다.",
		"WOW의 모든 주문을 검색합니다. 주문 이름이 모두 일치하면 주문 목록을 표시합니다.",
	},
}
EA_XSPECINFO_MANA = "마나"
EA_XSPECINFO_COMBOPOINT = "연계 포인트"
EA_XSPECINFO_RUNICPOWER = "룬 파워"
EA_XSPECINFO_RUNES	= "룬"
EA_XSPECINFO_SOULSHARDS = "영혼석"
EA_XSPECINFO_LUNARPOWER = "음력 전원"
EA_XSPECINFO_HOLYPOWER = "성스러운 힘"
EA_XSPECINFO_INSANITY= "정신 이상"
EA_XSPECINFO_ENERGY= "에너지"
EA_XSPECINFO_RAGE= "격노"
EA_XSPECINFO_FOCUS= "집중하다"
EA_XSPECINFO_FOCUS_PET= "애완 동물 포커스"
EA_XSPECINFO_CHI= "가스"
EA_XSPECINFO_ARCANECHARGES= "비전 요금"			
EA_XSPECINFO_MAELSTROM= "큰 소용돌이"	
EA_XSPECINFO_FURY= "격노"	
EA_XSPECINFO_PAIN= "고통(9.0제거됨)"	


EA_XOPT_SPECFLAG_MANA = EA_XSPECINFO_MANA
EA_XOPT_SPECFLAG_HOLYPOWER = EA_XSPECINFO_HOLYPOWER
EA_XOPT_SPECFLAG_RUNICPOWER = EA_XSPECINFO_RUNICPOWER
EA_XOPT_SPECFLAG_RUNES = EA_XSPECINFO_RUNES
EA_XOPT_SPECFLAG_SOULSHARDS = EA_XSPECINFO_SOULSHARDS
EA_XOPT_SPECFLAG_LUNARPOWER = EA_XSPECINFO_LUNARPOWER
EA_XOPT_SPECFLAG_COMBOPOINT = EA_XSPECINFO_COMBOPOINT
EA_XOPT_SPECFLAG_LIFEBLOOM = "피어나는 생명"
EA_XOPT_SPECFLAG_INSANITY = EA_XSPECINFO_INSANITY									
EA_XOPT_SPECFLAG_RAGE = EA_XSPECINFO_RAGE
EA_XOPT_SPECFLAG_ENERGY = EA_XSPECINFO_ENERGY
EA_XOPT_SPECFLAG_FOCUS = EA_XSPECINFO_FOCUS
EA_XOPT_SPECFLAG_FOCUS_PET = EA_XSPECINFO_FOCUS_PET
EA_XOPT_SPECFLAG_CHI = EA_XSPECINFO_CHI		
EA_XOPT_SPECFLAG_ARCANECHARGES = EA_XSPECINFO_ARCANECHARGES
EA_XOPT_SPECFLAG_MAELSTROM = EA_XSPECINFO_MAELSTROM
EA_XOPT_SPECFLAG_FURY = EA_XSPECINFO_FURY
EA_XOPT_SPECFLAG_PAIN = EA_XSPECINFO_PAIN

EA_XGRPALERT_POWERTYPE = "파워 형태:"
EA_XGRPALERT_POWERTYPES = {
	[1]={text=EA_XSPECINFO_MANA, value=EA_SPELL_POWER_MANA},
	[2]={text=EA_XSPECINFO_RAGE, value=EA_SPELL_POWER_RAGE},
	[3]={text=EA_XSPECINFO_FOCUS, value=EA_SPELL_POWER_FOCUS},
	[4]={text=EA_XSPECINFO_COMBOPOINT, value=EA_SPELL_POWER_COMBO_POINT},
	[5]={text=EA_XSPECINFO_ENERGY, value=EA_SPELL_POWER_ENERGY},
	[6]={text=EA_XSPECINFO_RUNES, value=EA_SPELL_POWER_RUNES},
	[7]={text=EA_XSPECINFO_RUNICPOWER, value=EA_SPELL_POWER_RUNIC_POWER},
	[8]={text=EA_XSPECINFO_SOULSHARDS, value=EA_SPELL_POWER_SOUL_SHARDS},
	[9]={text=EA_XSPECINFO_LUNARPOWER, value=EA_SPELL_POWER_LUNAR_POWER},
	[10]={text=EA_XSPECINFO_HOLYPOWER, value=EA_SPELL_POWER_HOLY_POWER},
	[11]={text=EA_XSPECINFO_CHI, value=EA_SPELL_POWER_CHI},		
	[12]={text=EA_XSPECINFO_INSANITY, value=EA_SPELL_POWER_INSANITY},			
	[13]={text=EA_XSPECINFO_ARCANECHARGES, value=EA_SPELL_POWER_ARCANE_CHARGES},
	[14]={text=EA_XSPECINFO_MAELSTROM, value=EA_SPELL_POWER_MAELSTROM},
	[15]={text=EA_XSPECINFO_FURY, value=EA_SPELL_POWER_FURY},
	[16]={text=EA_XSPECINFO_PAIN, value=EA_SPELL_POWER_PAIN},	
}
end		--End Of If