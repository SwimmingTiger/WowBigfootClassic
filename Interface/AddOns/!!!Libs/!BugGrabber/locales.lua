local _, parentAddonTable = ...
local addon = parentAddonTable.BugGrabber
-- Bail out in case we didn't load up for some reason, which
-- happens for example when an embedded BugGrabber finds a
-- standalone !BugGrabber addon.
if not addon then return end

-- We don't need to bail out here if BugGrabber has been loaded from
-- some other embedding addon already, because :LoadTranslations is
-- only invoked on login. All we do is replace the method with a new
-- one that will never be invoked.

function addon:LoadTranslations(locale, L)
	if locale == "koKR" then
L["ABOLISH_CHECK"] = "해제 전 \"해제 주문\" 검사"
L["ABOUT_AUTHOREMAIL"] = "제작자 이메일"
L["ABOUT_CREDITS"] = "공로자"
L["ABOUT_LICENSE"] = "라이센스"
L["ABOUT_NOTES"] = "쏠로, 파티, 공격대를 위한 고급화된 필터링과 시스템 우선권으로 고통들의 표시와 제거를 합니다."
L["ABOUT_OFFICIALWEBSITE"] = "공식 웹사이트"
L["ABOUT_SHAREDLIBS"] = "공유된 라이브러리들"
L["ABSENT"] = "(%s) 자리비움"
L["AFFLICTEDBY"] = "%s에 걸림"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "표시할 대상의 수 : "
L["ANCHOR"] = "Decursive 글자 위치"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "작은 유닛 프레임 표시/숨김"
L["BINDING_NAME_DCRPRADD"] = "대상을 우선순위 목록에 추가"
L["BINDING_NAME_DCRPRCLEAR"] = "우선순위 목록 초기화"
L["BINDING_NAME_DCRPRLIST"] = "우선순위 목록 출력"
L["BINDING_NAME_DCRPRSHOW"] = "우선순위 목록 표시/숨김"
L["BINDING_NAME_DCRSHOW"] = [=[Decursive 메인바 표시/숨김
(실시간 목록 고정위치)]=]
L["BINDING_NAME_DCRSHOWOPTION"] = "고정 창 설정 표시"
L["BINDING_NAME_DCRSKADD"] = "대상을 제외 목록에 추가"
L["BINDING_NAME_DCRSKCLEAR"] = "제외 목록 초기화"
L["BINDING_NAME_DCRSKLIST"] = "제외 목록 출력"
L["BINDING_NAME_DCRSKSHOW"] = "제외 목록 표시/숨김"
L["BLACK_LENGTH"] = "블랙리스트 추가 시간(초) : "
L["BLACKLISTED"] = "블랙리스트됨"
L["CHARM"] = "변이"
L["CLASS_HUNTER"] = "사냥꾼"
L["CLEAR_PRIO"] = "C"
L["CLEAR_SKIP"] = "C"
L["COLORALERT"] = "'%s'|1이;가; 필요할때의 알림 색상을 설정합니다."
L["COLORCHRONOS"] = "중앙 카운터"
L["COLORCHRONOS_DESC"] = "중앙 카운터의 색상을 설정합니다."
L["COLORSTATUS"] = "MUF 상태가 '%s'일때 색상을 설정합니다."
L["CTRL"] = "Ctrl"
L["CURE_PETS"] = "소환수 탐색과 해제"
L["CURSE"] = "저주"
L["DEBUG_REPORT_HEADER"] = [=[|cFF11FF33<%s>로 이 창의 내용을 보고해 주십시오|r
|cFF009999(CTRL+A키로 모두 선택하고 CTRL+C키로 당신의 클립보드 내 문자를 넣어 사용하십시오)|r
또한 당신이 눈치챈 %s의 어떠한 이상 증상도 보고서에 알리십시오.
]=]
L["DECURSIVE_DEBUG_REPORT"] = "**** |cFFFF0000Decursive 디버그 보고서|r ****"
L["DECURSIVE_DEBUG_REPORT_BUT_NEW_VERSION"] = "|cFF11FF33Decursive가 충돌했지만 두렵지 않어! 새로운 버전의 Decursive가 발견됐거든 (%s). 당신은 업데이트만 하면돼.  curse.com으로 가서 'Decursive'를 검색하거나 Curse의 클라이언트를 사용하면 네가 좋아하는 애드온, 모두 자동적으로 업데이트 할 수 있을거야.|r |cFFFF1133그러니 이 버그는 이미 고쳐졌으니 보고하는 데 시간을 낭비하지 마. 이 문제를 없애기 위해 Decursive를 업데이트하기만 하면 돼!|r |cFF11FF33읽어줘서 고마워!|r"
L["DECURSIVE_DEBUG_REPORT_NOTIFY"] = [=[디버그 보고서가 유효합니다!
|cFFFF0000/DCRREPORT|r를 입력해 그것을 확인합니다.]=]
L["DECURSIVE_DEBUG_REPORT_SHOW"] = "디버그 보고서 유효함!"
L["DECURSIVE_DEBUG_REPORT_SHOW_DESC"] = "개발자의 확인이 필요한 디버그 보고서 보기..."
L["DEFAULT_MACROKEY"] = "NONE"
L["DEV_VERSION_ALERT"] = [=[당신은 Decursive의 개발자 버전을 사용 중입니다.

만약 당신이 새로운 기능/수정 테스트, 게임 중 디버그 보고서 받기, 개발자에게 문제점 보내기에 참여하고 싶지 않다면 '이 버전을 사용하지 마세요.' 그리고 curse.com이나 wowace.com에서 최신 '안정' 버전을 내려받으세요.

이 메시지는 버전마다 한 번씩만 표시됩니다.

Decursive의 개발자 버전은 플레이어가 게임을 시작할 때 경고가 표시됩니다.]=]
L["DEV_VERSION_EXPIRED"] = [=[본 Decursive의 개발자 버전은 만료되었습니다.
마지막 개발자 버전을 다운로드하거나 CURSE.COM 또는 WOWACE.COM에서 현재 안정화 배포판을 사용해 주십시오.
이 경고는 2일간 항상 표시됩니다.

알림: Decursive의 만료된 개발 버전으로 접속 시 사용자에게 매번 표시됩니다.]=]
L["DEWDROPISGONE"] = "거기엔 Ace3에 대해 상응하는 DewDrop이 없습니다. Alt+우-클릭으로 설정판을 여십시오."
L["DISABLEWARNING"] = [=[Decursive 사용이 중지되었습니다!

다시 사용하려면, |cFFFFAA44/DCR ENABLE|r를 입력하세요.]=]
L["DISEASE"] = "질병"
L["DONOT_BL_PRIO"] = "우선순위 블랙리스트 제외"
L["DONT_SHOOT_THE_MESSENGER"] = "Decursive가 문제를 간략히 알립니다. 그래서, 메신저와 주소를 쏘지 않도록 문제를 해결합니다."
L["FAILEDCAST"] = [=[|cFF22FFFF%s %s|r|1으로;로; %s |cFFAA0000치료 실패|r
|cFF00AAAA%s|r]=]
L["FOCUSUNIT"] = "주시대상"
L["FUBARMENU"] = "FuBar 메뉴"
L["FUBARMENU_DESC"] = "FuBar 아이콘에 관련된 옵션을 설정합니다."
L["GLOR1"] = "Glorfindal의 추억속에"
L["GLOR2"] = [=[Decursive는 돌아올 수 없는 길을 떠난 Bertrand의 추억에 바칩니다.
그는 언제나 기억될 것입니다.]=]
L["GLOR3"] = [=[Bertrand Sense를 기억하며
1969 - 2007]=]
L["GLOR4"] = [=[사랑과 우정은 그들은 언제 어디에서나 얻을 수 있습니다, World of Warcraft에서 Glorfindal을 만났던 사람들은 훌륭히 책임감있고 카리스마 넘치는 지도자로 알고 있었습니다.

그는 게임 속 삶에 있어서, 모든 이들과 그의 친구들에게 헌신적이고, 사심없고, 관대하였고, 열정적인 사람이었습니다.

그는 가상 세계 속의 단지 익명 플레이어로써 훗날 38의 나이에 떠나갔지만, 진정한 친구들이라면 그를 영원히 그리워 할 것입니다.]=]
L["GLOR5"] = "그는 언제나 기억될 것입니다..."
L["HANDLEHELP"] = "작은 유닛 프레임(MUFs) 모두 이동"
L["HIDE_MAIN"] = "Decursive 창 숨김"
L["HIDESHOW_BUTTONS"] = "버튼 표시/숨김"
L["HLP_LEFTCLICK"] = "좌-클릭"
L["HLP_LL_ONCLICK_TEXT"] = [=[실시간 목록이 클릭되는 것은 아닙니다. 이 애드온의 추가 기능을 사용하는 방법을 알아보려면 설명서를 읽으십시오. WoWAce.com에서 'Decursive'를 검색하세요.
(이 목록에서 Decursive 바를 이동하려면 /dcrshow 및 왼쪽-Alt-클릭으로 이동)]=]
L["HLP_MIDDLECLICK"] = "가운데-클릭"
L["HLP_MOUSE4"] = "4번 마우스 버튼"
L["HLP_MOUSE5"] = "5번 마우스 버튼"
L["HLP_NOTHINGTOCURE"] = "치료할 것이 없습니다!"
L["HLP_RIGHTCLICK"] = "우-클릭"
L["HLP_USEXBUTTONTOCURE"] = "해당 디버프를 치료하려면 \"%s\" 버튼을 사용하세요"
L["HLP_WRONGMBUTTON"] = "잘못된 마우스 버튼입니다!"
L["IGNORE_STEALTH"] = "은신 대상 무시"
L["IS_HERE_MSG"] = "초기화되었습니다. 옵션(/decursive)을 확인하세요."
L["LIST_ENTRY_ACTIONS"] = [=[|cFF33AA33[CTRL]|r 클릭: 해당 플레이어 제거
|cFF33AA33좌|r-클릭: 해당 플레이어를 위로
|cFF33AA33우|r-클릭: 해당 플레이어를 아래로
|cFF33AA33[SHIFT] 좌|r-클릭: 해당 플레이어를 최상위로
|cFF33AA33[SHIFT] 우|r-클릭: 해당 플레이어를 최하위로]=]
L["MACROKEYALREADYMAPPED"] = [=[경고: Decursive 매크로에 지정한 [%s]키는 '%s'|1을;를; 위해 지정되어 있습니다.
당신이 매크로에 다른 키를 지정하면 Decursive는 이전 설정을 복원할 것입니다.]=]
L["MACROKEYMAPPINGFAILED"] = "[%s] 키는 Decursive 매크로로 지정할 수 없습니다!"
L["MACROKEYMAPPINGSUCCESS"] = "[%s] 키가 Decursive 매크로로 성공적으로 지정되었습니다."
L["MACROKEYNOTMAPPED"] = "Decursive 마우스오버 매크로는 지정된 키가 없습니다, '매크로' 설정을 보시면 키를 지정할 수 있습니다!"
L["MAGIC"] = "마법"
L["MAGICCHARMED"] = "마법 정화"
L["MISSINGUNIT"] = "잘못된 대상"
L["NEW_VERSION_ALERT"] = [=[새로운 버전의 Decursive가 발견됨: |cFFEE7722%q|r 배포중 |cFFEE7722%s|r!


|cFFFF0000WoWAce.com|r에 방문하여 다운로드 하세요!]=]
L["NORMAL"] = "정상"
L["NOSPELL"] = "이용가능한 주문이 없습니다."
L["OPT_ABOLISHCHECK_DESC"] = "'해제' 주문을 가진 대상을 표시하고 치유 할 지를 선택합니다."
L["OPT_ABOUT"] = "관하여"
L["OPT_ADD_A_CUSTOM_SPELL"] = "사용자 주문 / 아이템 추가"
L["OPT_ADD_A_CUSTOM_SPELL_DESC"] = "여길 클릭하고 마법책의 주문에 쉬프트-클릭합니다. 이름 또는 숫자ID로 직접 작성할 수 있습니다."
L["OPT_ADDDEBUFF"] = "목록에 디버프 추가"
L["OPT_ADDDEBUFF_DESC"] = "이 목록에 새로운 디버프 추가"
L["OPT_ADDDEBUFF_USAGE"] = "<디버프명>"
L["OPT_ADDDEBUFFFHIST"] = "최근의 디버프 추가"
L["OPT_ADDDEBUFFFHIST_DESC"] = "예전에 사용된 디버프를 추가합니다."
L["OPT_ADVDISP"] = "고급 표시 설정"
L["OPT_ADVDISP_DESC"] = "각 MUF 사이 간격 설정을 위해 테두리와 가운데 구분의 투명도를 설정할 수 있습니다."
L["OPT_AFFLICTEDBYSKIPPED"] = "%s - %s에 걸리면 무시합니다."
L["OPT_ALLOWMACROEDIT"] = "매크로 편집 허용"
L["OPT_ALLOWMACROEDIT_DESC"] = "당신이 원하는 편집할 수 있도록 해당 매크로가 Decursive로부터 업데이트되지 않도록 설정할 수 있습니다."
L["OPT_ALWAYSIGNORE"] = "비전투시에도 항상 무시"
L["OPT_ALWAYSIGNORE_DESC"] = "선택 시 해당 디버프는 전투 중이 아닐때도 무시됩니다."
L["OPT_AMOUNT_AFFLIC_DESC"] = "실시간 목록에 표시할 유닛의 최대 수를 지정합니다."
L["OPT_ANCHOR_DESC"] = "사용자 정의 메세지창의 고정위치를 표시합니다."
L["OPT_AUTOHIDEMFS"] = "MUF 자동 숨기기:"
L["OPT_AUTOHIDEMFS_DESC"] = "언제 MUF 창을 자동으로 숨길지를 선택합니다."
L["OPT_BLACKLENTGH_DESC"] = "블랙리스트에 등록할 시간을 지정합니다."
L["OPT_BORDERTRANSP"] = "테두리 투명도"
L["OPT_BORDERTRANSP_DESC"] = "테두리의 투명도를 설정합니다."
L["OPT_CENTERTEXT"] = "중앙 카운터:"
L["OPT_CENTERTEXT_DISABLED"] = "사용 안 함"
L["OPT_CENTERTEXT_ELAPSED"] = "경과 시간"
L["OPT_CENTERTEXT_STACKS"] = "중첩 수"
L["OPT_CENTERTEXT_TIMELEFT"] = "남은 시간"
L["OPT_CENTERTRANSP"] = "가운데 투명도"
L["OPT_CENTERTRANSP_DESC"] = "가운데의 투명도를 설정합니다."
L["OPT_CHARMEDCHECK_DESC"] = "선택 시 지배에 걸린 대상을 표시하고 변이합니다."
L["OPT_CHATFRAME_DESC"] = "Decursive의 메세지가 기본 대화창에 표시됩니다."
L["OPT_CHECKOTHERPLAYERS"] = "다른 플레이어 확인"
L["OPT_CHECKOTHERPLAYERS_DESC"] = "당신이 현재 속한 길드 또는 그룹 플레이어의 Decursive 버전을 표시합니다. (Decursive 2.4.6 이전 버전은 표시할 수 없습니다.)"
L["OPT_CMD_DISBLED"] = "사용안함"
L["OPT_CMD_ENABLED"] = "사용함"
L["OPT_CREATE_VIRTUAL_DEBUFF"] = "가상 테스트 디버프 생성"
L["OPT_CREATE_VIRTUAL_DEBUFF_DESC"] = "피해가 발생하면 Decursive에서 어떻게 보여질 지 봅니다."
L["OPT_CURE_PRIORITY_NUM"] = "우선순위 #%d"
L["OPT_CUREPETS_DESC"] = "소환수를 관리하고 해제합니다."
L["OPT_CURINGOPTIONS"] = "해제 옵션"
L["OPT_CURINGOPTIONS_DESC"] = "각 피해 형식에 대한 우선순위 변경 설정을 포함한 해제 옵션입니다."
L["OPT_CURINGOPTIONS_EXPLANATION"] = [=[당신이 치료를 원하는 재난의 유형을 선택, 선택하지 않은 유형은 Decursive에서 완전히 무시될 것입니다.

재난의 우선 순위는 녹색 숫자로 정의됩니다. 이것은 몇 가지 영향을 미칠 것입니다:
- 플레이어에 여러 종류의 디버프가 걸려있으면 Decursive가 먼저 표시 할 지.
- 당신이 디버프를 치료하려 어떤 마우스 버튼을 클릭 할 지.(첫째 주문은 좌-클릭, 둘째는 우-클릭, 등...)

여기에 모든 설명이 기술되어 있습니다(참조 요망):
http://www.wowace.com/addons/decursive/]=]
L["OPT_CURINGORDEROPTIONS"] = "피해 형식과 우선순위"
L["OPT_CURSECHECK_DESC"] = "체크 시 저주에 걸린 대상을 표시하고 치료합니다."
L["OPT_CUSTOM_SPELL_ALLOW_EDITING"] = "위 주문에 대해 내부 매크로 편집 허용"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING_DESC"] = "사용자 주문의 Decursive에서 사용하기 위해 내부 매크로를 편집하기 원하면 이것을 선택하세요."
L["OPT_CUSTOM_SPELL_CURE_TYPES"] = "피해 형식"
L["OPT_CUSTOM_SPELL_IS_DEFAULT"] = "이 주문은 Decursive 자동 구성설정의 일부입니다. 만약 이 주문이 올바르게 작동하지않으면, Decursive 동작 기본값을 되돌려 삭제 또는 비활성할 수 있습니다."
L["OPT_CUSTOM_SPELL_ISPET"] = "소환수 능력"
L["OPT_CUSTOM_SPELL_MACRO_MISSING_NOMINAL_SPELL"] = "경고: 당신 매크로 상 %q 주문은 존재하지 않음, 거리와 대기시간 정보와 일치하지 않음..."
L["OPT_CUSTOM_SPELL_MACRO_MISSING_UNITID_KEYWORD"] = "유닛ID 키워드가 누락됨."
L["OPT_CUSTOM_SPELL_MACRO_TEXT"] = "매크로 문자:"
L["OPT_CUSTOM_SPELL_MACRO_TEXT_DESC"] = [=[기본 매크로 문자 편집:
|cFFFF0000오직 2 제한:|r


- 당신이 지정한 대상에 유닛ID 키워드를 사용해 각 작은 유닛프레임의 유닛ID를 자동으로 대체합니다.

- 매크로에 사용된 주문이 무엇이든, Decursive는 남은 재사용 대기시간/추적과 거리를 위해 원래 이름을 계속 사용합니다.
(조건문과 함께 다른 주문을 사용할 경우를 염두해둘 것)]=]
L["OPT_CUSTOM_SPELL_MACRO_TOO_LONG"] = "당신의 매크로가 길어서 %d 문자를 제거해야 합니다."
L["OPT_CUSTOM_SPELL_PRIORITY"] = "주문 우선순위"
L["OPT_CUSTOM_SPELL_PRIORITY_DESC"] = "동일 피해 형식을 여러가지 주문으로 치료하려면, 원하는 주문의 우선순위가 높아야 합니다."
L["OPT_CUSTOM_SPELL_UNAVAILABLE"] = "사용할 수 없음"
L["OPT_CUSTOM_SPELL_UNIT_FILTER"] = "유닛 필터링"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_DESC"] = "이 주문을 쓸 수 있는 유닛을 고릅니다."
L["OPT_CUSTOM_SPELL_UNIT_FILTER_NONE"] = "모든 유닛"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_NONPLAYER"] = "다른 유닛만"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_PLAYER"] = "플레이어만"
L["OPT_CUSTOMSPELLS"] = "사용자 주문 / 아이템"
L["OPT_CUSTOMSPELLS_DESC"] = "여기 당신의 주문을 추가해 Decursive의 자동 구성설정을 확장할 수 있습니다."
L["OPT_CUSTOMSPELLS_EFFECTIVE_ASSIGNMENTS"] = "효과적인 주문 할당:"
L["OPT_DEBCHECKEDBYDEF"] = [=[
기본값으로 설정됨]=]
L["OPT_DEBUFFENTRY_DESC"] = "해당 디버프에 걸렸을 때 전투 중 무시할 직업을 선택하세요."
L["OPT_DEBUFFFILTER"] = "디버프 필터링"
L["OPT_DEBUFFFILTER_DESC"] = "이름과 직업에 의해 필터링 할 디버프를 선택합니다."
L["OPT_DELETE_A_CUSTOM_SPELL"] = "삭제"
L["OPT_DISABLEABOLISH"] = "'무효화' 주문은 사용할 수 없음"
L["OPT_DISABLEABOLISH_DESC"] = "만약 사용시, Decursive는 '무효화'와 동등 이상의 '질병 해제'나 '독 해제'를 선호할 것입니다."
L["OPT_DISABLEMACROCREATION"] = "매크로 생성 사용 안 함"
L["OPT_DISABLEMACROCREATION_DESC"] = "Decursive 매크로를 더 이상 생성 또는 유지할 수 없습니다."
L["OPT_DISEASECHECK_DESC"] = "선택 시 질병에 걸린 대상을 표시하고 치료합니다."
L["OPT_DISPLAYOPTIONS"] = "디스플레이 옵션"
L["OPT_DONOTBLPRIO_DESC"] = "우선순위에 등록된 유닛은 블랙리스트에 추가하지 않습니다."
L["OPT_ENABLE_A_CUSTOM_SPELL"] = "사용"
L["OPT_ENABLE_LIVELIST"] = "실시간 목록 사용"
L["OPT_ENABLEDEBUG"] = "디버깅 사용"
L["OPT_ENABLEDEBUG_DESC"] = "디버깅 출력 사용"
L["OPT_ENABLEDECURSIVE"] = "Decursive 사용"
L["OPT_FILTEROUTCLASSES_FOR_X"] = "%q|1은;는; 전투 중 지정된 클래스에서 무시됩니다."
L["OPT_GENERAL"] = "기본 설정"
L["OPT_GROWDIRECTION"] = "MUF 표시 반전"
L["OPT_GROWDIRECTION_DESC"] = "MUF를 하단에서 상단으로 표시합니다."
L["OPT_HIDEMFS_GROUP"] = "솔로 또는 파티"
L["OPT_HIDEMFS_GROUP_DESC"] = "MUF 창을 공격대에 속해있지 않을 때 숨겨둡니다."
L["OPT_HIDEMFS_NEVER"] = "자동숨김 사용안함"
L["OPT_HIDEMFS_NEVER_DESC"] = "MUF 창의 자동숨김을 사용하지 않습니다."
L["OPT_HIDEMFS_SOLO"] = "솔로"
L["OPT_HIDEMFS_SOLO_DESC"] = "MUF 창을 파티나 공격대가 아니면 숨겨둡니다."
L["OPT_HIDEMUFSHANDLE"] = "MUF 핸들 숨김"
L["OPT_HIDEMUFSHANDLE_DESC"] = [=[마이크로-유닛 프레임(MUF) 핸들을 숨기고 이동할 가능성을 해제합니다.
동일한 명령으로 다시 되돌릴 수 있습니다.]=]
L["OPT_IGNORESTEALTHED_DESC"] = "은신한 대상을 무시합니다."
L["OPT_INPUT_SPELL_BAD_INPUT_ALREADY_HERE"] = "주문이 이미 나열됨!"
L["OPT_INPUT_SPELL_BAD_INPUT_DEFAULT_SPELL"] = "Decursive가 이 주문을 이미 관리함. 특별한 순위 추가는 해당 ID 또는 주문을 쉬프트-클릭으로 입력하세요."
L["OPT_INPUT_SPELL_BAD_INPUT_ID"] = "주문ID가 올바르지 않음!"
L["OPT_INPUT_SPELL_BAD_INPUT_NOT_SPELL"] = "마법책에서 주문을 찾을 수 없음!"
L["OPT_LIVELIST"] = "실시간 목록"
L["OPT_LIVELIST_DESC"] = "실시간 목록에 대한 설정입니다."
L["OPT_LLALPHA"] = "실시간 목록 투명도"
L["OPT_LLALPHA_DESC"] = "Decursive 메인바와 실시간 목록의 투명도를 변경합니다. (메인바가 표시되어 있어야 함)"
L["OPT_LLSCALE"] = "실시간 목록 크기"
L["OPT_LLSCALE_DESC"] = "Decursive 메인바와 실시간 목록의 크기를 설정합니다. (메인바가 표시되어 있어야 함)"
L["OPT_LVONLYINRANGE"] = "범위 내 대상"
L["OPT_LVONLYINRANGE_DESC"] = "해제 범위 내 대상만 실시간 목록에 표시합니다."
L["OPT_MACROBIND"] = "매크로 단축키 설정"
L["OPT_MACROBIND_DESC"] = [=['Decursive' 매크로를 호출 할 키를 지정합니다.

키를 누르고 키보드의 'Enter'키를 누르면 새롭게 지정된 키가 저장됩니다.(당신의 마우스 커서가 편집 구역내에 있어야 합니다)]=]
L["OPT_MACROOPTIONS"] = "매크로 설정"
L["OPT_MACROOPTIONS_DESC"] = "Decursive가 생성한 'mouseover' 매크로의 동작을 설정합니다."
L["OPT_MAGICCHARMEDCHECK_DESC"] = "체크 시 지배에 걸린 대상을 표시하고 치료합니다."
L["OPT_MAGICCHECK_DESC"] = "체크 시 마법에 걸린 대상을 표시하고 치료합니다."
L["OPT_MAXMFS"] = "표시할 최대 유닛"
L["OPT_MAXMFS_DESC"] = "표시할 작은 유닛 프레임의 최대 갯수를 지정합니다."
L["OPT_MESSAGES"] = "메시지"
L["OPT_MESSAGES_DESC"] = "메시지 표시에 대한 설정입니다."
L["OPT_MFALPHA"] = "투명도"
L["OPT_MFALPHA_DESC"] = "디버프의 걸린 대상이 없을 때 MUF의 투명도를 지정합니다."
L["OPT_MFPERFOPT"] = "성능 설정"
L["OPT_MFREFRESHRATE"] = "갱신 주기"
L["OPT_MFREFRESHRATE_DESC"] = "갱신할 시간 간격(한번에 1 혹은 그 이상 작은 유닛 프레임을 갱신할 수 있습니다.)"
L["OPT_MFREFRESHSPEED"] = "갱신 속도"
L["OPT_MFREFRESHSPEED_DESC"] = "한번에 갱신할 작은 유닛 프레임의 갯수"
L["OPT_MFSCALE"] = "작은 유닛 프레임의 크기"
L["OPT_MFSCALE_DESC"] = "작은 유닛 프레임의 크기를 설정합니다."
L["OPT_MFSETTINGS"] = "작은 유닛프레임 설정"
L["OPT_MFSETTINGS_DESC"] = "작은 유닛프레임에 대한 설정입니다."
L["OPT_MUFFOCUSBUTTON"] = "주시대상 버튼:"
L["OPT_MUFHANDLE_HINT"] = "작은 유닛프레임을 이동하려면: 첫번째 작은 유닛프레임 상단 위의 보이지 않는 핸들을 ALT+클릭합니다. "
L["OPT_MUFMOUSEBUTTONS"] = "마우스 단축버튼"
L["OPT_MUFMOUSEBUTTONS_DESC"] = [=[MUF에서 대상 또는 주시대상 그룹원, 치료에 사용되는 단축키를 변경합니다.

각 우선순위 숫자는 '|cFFFF5533치료 설정|r' 창의 명시된 것처럼 다른 재난의 유형을 나타냅니다.

각 재난 유형에 사용되는 주문은 기본값으로 설정되어 있지만 '|cFF00DDDD사용자 주문|r'창에서 변경해 사용할 수 있습니다.]=]
L["OPT_MUFSCOLORS"] = "색상"
L["OPT_MUFSCOLORS_DESC"] = "작은 유닛프레임의 색상을 변경합니다."
L["OPT_MUFSVERTICALDISPLAY"] = "세로 표시"
L["OPT_MUFSVERTICALDISPLAY_DESC"] = "작은 유닛프레임 창을 세로로 늘임"
L["OPT_MUFTARGETBUTTON"] = "대상 버튼:"
L["OPT_NEWVERSIONBUGMENOT"] = "새로운 버전 알림"
L["OPT_NEWVERSIONBUGMENOT_DESC"] = "새로운 버전의 Decursive가 발견되면 매 7일간 팝업으로 알림을 표시합니다."
L["OPT_NOKEYWARN"] = "키 없음 경고"
L["OPT_NOKEYWARN_DESC"] = "지정된 키가 없다면 경고 문구를 표시합니다."
L["OPT_NOSTARTMESSAGES"] = "환영 메시지 사용 안 함"
L["OPT_NOSTARTMESSAGES_DESC"] = "접속할 때마다 Decursive가 대화창에 출력하는 메시지 2개를 제거합니다."
L["OPT_OPTIONS_DISABLED_WHILE_IN_COMBAT"] = "이 옵션은 전투 중에는 사용할 수 없습니다."
L["OPT_PERFOPTIONWARNING"] = "경고: 당신이 뭘 하는지 정확히 모른다면 값을 바꾸지 마세요. 이 설정은 게임 성능에 큰 영향을 줄 수 있습니다. 사용자 대부분은 기본값인 0.1과 10을 쓰셔야 합니다."
L["OPT_PLAYSOUND_DESC"] = "해제 가능한 디버프 발견시 효과음을 재생합니다."
L["OPT_POISONCHECK_DESC"] = "체크 시 독에 걸린 대상을 표시하고 치료합니다."
L["OPT_PRINT_CUSTOM_DESC"] = "Decursive의 메세지가 사용자 정의 대화창에 표시됩니다."
L["OPT_PRINT_ERRORS_DESC"] = "오류를 표시합니다."
L["OPT_PROFILERESET"] = "프로필 초기화..."
L["OPT_RANDOMORDER_DESC"] = "대상을 무작위로 표시하고 치료합니다.(비추천)"
L["OPT_READDDEFAULTSD"] = "기본 디버프 재추가"
L["OPT_READDDEFAULTSD_DESC1"] = [=[해당 목록에 누락된 Decursive의 기본 디버프를 추가합니다.
설정은 변하지 않습니다.]=]
L["OPT_READDDEFAULTSD_DESC2"] = "Decursive의 모든 기본 디버프는 해당 목록에 있습니다."
L["OPT_REMOVESKDEBCONF"] = [=[정말로 Decursive의 디버프 제외 목록에서
'%s'|1을;를; 제거 하시겠습니까?]=]
L["OPT_REMOVETHISDEBUFF"] = "해당 디버프 제거"
L["OPT_REMOVETHISDEBUFF_DESC"] = "제외 목록에서 '%s' 제거"
L["OPT_RESETDEBUFF"] = "해당 디버프 초기화"
L["OPT_RESETDTDCRDEFAULT"] = "'%s' Decursive 기본으로 초기화"
L["OPT_RESETMUFMOUSEBUTTONS"] = "초기화"
L["OPT_RESETMUFMOUSEBUTTONS_DESC"] = "기본값으로 할당된 마우스 버튼을 초기화합니다."
L["OPT_RESETOPTIONS"] = "기본값으로 설정 초기화"
L["OPT_RESETOPTIONS_DESC"] = "현재 프로필을 기본값으로 초기화합니다."
L["OPT_RESTPROFILECONF"] = [=[정말로 '(%s) %s'
프로필을 기본 설정으로
초기화할까요?]=]
L["OPT_REVERSE_LIVELIST_DESC"] = "실시간 목록을 아래에서 위로 채웁니다."
L["OPT_SCANLENGTH_DESC"] = "각 탐색의 시간 간격을 지정합니다."
L["OPT_SHOW_STEALTH_STATUS"] = "은신 상태 보기"
L["OPT_SHOW_STEALTH_STATUS_DESC"] = "플레이어가 은신중이면, 그 MUF는 특정한 색상을 갖게 될 것임"
L["OPT_SHOWBORDER"] = "직업 색상 테두리 표시"
L["OPT_SHOWBORDER_DESC"] = "MUF에 유닛의 직업에 따른 색상을 테두리로 표시합니다."
L["OPT_SHOWHELP"] = "도움말 표시"
L["OPT_SHOWHELP_DESC"] = "작은 유닛 프레임에 마우스를 올리면 정보 툴팁을 표시합니다."
L["OPT_SHOWMFS"] = "작은 유닛 프레임(MUF) 표시"
L["OPT_SHOWMFS_DESC"] = "클릭으로 해제하려면 반드시 활성화 되어야 합니다."
L["OPT_SHOWMINIMAPICON"] = "미니맵 아이콘"
L["OPT_SHOWMINIMAPICON_DESC"] = "미니맵 아이콘을 표시합니다."
L["OPT_SHOWTOOLTIP_DESC"] = "실시간 목록과 작은 유닛 프레임에 디버프에 대한 자세한 툴팁을 표시합니다."
L["OPT_STICKTORIGHT"] = "MUF창 우측 정렬"
L["OPT_STICKTORIGHT_DESC"] = "MUF창은 오른쪽에서 왼쪽으로 생기며 동작은 자동적으로 이루어질 것입니다."
L["OPT_TESTLAYOUT"] = "레이아웃 테스트"
L["OPT_TESTLAYOUT_DESC"] = [=[레이아웃을 보고 테스트할 수 있도록 가짜 유닛을 생성합니다.
(클릭 후 몇 초간 기다려야 함.)]=]
L["OPT_TESTLAYOUTUNUM"] = "유닛 갯수"
L["OPT_TESTLAYOUTUNUM_DESC"] = "생성하려면 가짜 유닛의 갯수를 설정."
L["OPT_TIE_LIVELIST_DESC"] = "실시간 목록을 아래에서 위로 생성합니다."
L["OPT_TIECENTERANDBORDER"] = "가운데와 테두리의 투명도"
L["OPT_TIECENTERANDBORDER_OPT"] = "체크 시 테두리의 투명도가 가운데 투명도의 절반이 됩니다."
L["OPT_TIEXYSPACING"] = "수평/수직 간격"
L["OPT_TIEXYSPACING_DESC"] = "MUF의 수평과 수직 간격이 같아 집니다."
L["OPT_UNITPERLINES"] = "한 줄에 표시할 유닛의 갯수"
L["OPT_UNITPERLINES_DESC"] = "한 줄에 표시할 작은 유닛프레임의 최대 갯수를 지정합니다."
L["OPT_USERDEBUFF"] = "해당 디버프는 Decursive의 기본 디버프가 아닙니다."
L["OPT_XSPACING"] = "수평 간격"
L["OPT_XSPACING_DESC"] = "MUF 사이의 수평 간격을 설정합니다."
L["OPT_YSPACING"] = "수직 간격"
L["OPT_YSPACING_DESC"] = "MUF 사이의 수직 간격을 설정합니다."
L["OPTION_MENU"] = "Decursive 설정 메뉴"
L["PLAY_SOUND"] = "효과음 재생"
L["POISON"] = "독"
L["POPULATE"] = "p"
L["POPULATE_LIST"] = "Decursive 목록에 빠른 추가"
L["PRINT_CHATFRAME"] = "기본 대화창에 메세지 표시"
L["PRINT_CUSTOM"] = "Decursive 창에 메세지 표시"
L["PRINT_ERRORS"] = "오류 메세지 출력"
L["PRIORITY_LIST"] = "Decursive 우선순위 목록"
L["PRIORITY_SHOW"] = "P"
L["RANDOM_ORDER"] = "무작위 해제"
L["REVERSE_LIVELIST"] = "실시간 목록 표시 반전"
L["SCAN_LENGTH"] = "실시간 탐색 시간(초) : "
L["SHIFT"] = "Shift"
L["SHOW_MSG"] = "Decursive 창 표시, /dcrshow 명령어를 입력하세요."
L["SHOW_TOOLTIP"] = "디버프 걸린 대상의 툴팁 표시"
L["SKIP_LIST_STR"] = "Decursive 제외 목록"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "%s 주문 발견!"
L["STEALTHED"] = "은신상태"
L["STR_CLOSE"] = "닫기"
L["STR_DCR_PRIO"] = "Decursive 우선순위"
L["STR_DCR_SKIP"] = "Decursive 제외"
L["STR_GROUP"] = "파티 "
L["STR_OPTIONS"] = "Decursive 설정"
L["STR_OTHER"] = "기타"
L["STR_POP"] = "추가 목록"
L["STR_QUICK_POP"] = "빠른 추가"
L["SUCCESSCAST"] = "|cFF22FFFF%s %s|r|1으로;로; %s |cFF00AA00치료 성공!|r"
L["TARGETUNIT"] = "대상"
L["TIE_LIVELIST"] = "실시간 목록 표시를 DCR 창과 함께 표시"
L["TOC_VERSION_EXPIRED"] = "Decursive 버전이 만료되었습니다. 이 버전의 Decursive는 당신이 사용하고 있는 World of Warcraft의 버전보다 먼저 출시되었습니다. 잠재적인 비호환성 및 런타임 오류를 수정하려면 Decursive를 업데이트해야 합니다. curse.com으로 이동하여 'Decursive'를 검색하거나 Curse의 클라이언트를 사용하여 모든 추가 기능을 한 번에 업데이트하세요. 이 안내는 2일 후에 다시 표시될 것입니다."
L["TOO_MANY_ERRORS_ALERT"] = [=[사용자 인터페이스(%d)에 많은 Lua 오류가 있습니다. 당신의 게임 성능을 현재 저하시킵니다. 오류 애드온의 사용을 중지하여 적절한 프레임 속도를 향상시키도록 업데이트 또는 비활성합니다.
당신은 식별된 문제있는 애드온의 Lua 오류를 보고하기(/console scriptErrors 1) 위해 설정할 수 있습니다.]=]
L["TOOFAR"] = "거리 벗어남"
L["UNITSTATUS"] = "상태: "
L["UNSTABLERELEASE"] = "비안정화판 배포"

	elseif locale == "deDE" then
L["ABOLISH_CHECK"] = "Zuvor überprüfen ob Reinigung nötig"
L["ABOUT_AUTHOREMAIL"] = "E-MAIL DES ENTWICKLERS"
L["ABOUT_CREDITS"] = "VERDIENST"
L["ABOUT_LICENSE"] = "LIZENZ"
L["ABOUT_NOTES"] = "Anzeige und Reinigung von Gebrechen für Solo, Gruppe und Schlachtzug mit erweitertem Filter- und Prioritäten-System."
L["ABOUT_OFFICIALWEBSITE"] = "OFFIZIELLE WEBSEITE"
L["ABOUT_SHAREDLIBS"] = "GEMEINSAM GENUTZTE SAMMLUNGEN"
L["ABSENT"] = "Fehlt (%s)"
L["AFFLICTEDBY"] = "%s leidend"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "Die Anzahl der Befallenen anzeigen: "
L["ANCHOR"] = "Anker des Decursive-Textfensters"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "Micro-Einheiten-Rahmen anzeigen oder verbergen"
L["BINDING_NAME_DCRPRADD"] = "Ziel der Prioritätenliste hinzufügen"
L["BINDING_NAME_DCRPRCLEAR"] = "Prioritätenliste leeren"
L["BINDING_NAME_DCRPRLIST"] = "Prioritätenliste ausgeben"
L["BINDING_NAME_DCRPRSHOW"] = "Die Prioritätenliste anzeigen/verbergen"
L["BINDING_NAME_DCRSHOW"] = [=[Decursive-Hauptleiste anzeigen/verbergen
(Anker der aktuellen Liste)]=]
L["BINDING_NAME_DCRSHOWOPTION"] = "Feststehendes Optionsfeld anzeigen"
L["BINDING_NAME_DCRSKADD"] = "Ziel der Ignorierliste hinzufügen"
L["BINDING_NAME_DCRSKCLEAR"] = "Ignorierliste leeren"
L["BINDING_NAME_DCRSKLIST"] = "Ignorierliste ausgeben"
L["BINDING_NAME_DCRSKSHOW"] = "Die Ignorierliste anzeigen/verbergen"
L["BLACK_LENGTH"] = "Sekunden auf der schwarzen Liste: "
L["BLACKLISTED"] = "Auf schwarzer Liste"
L["CHARM"] = "Gedankenkontrolle"
L["CLASS_HUNTER"] = "Jäger"
L["CLEAR_PRIO"] = "C"
L["CLEAR_SKIP"] = "C"
L["COLORALERT"] = "Warnfarbe einstellen, wenn ein '%s' benötigt wird."
L["COLORCHRONOS"] = "Counter zentriert"
L["COLORCHRONOS_DESC"] = "Einstellung der Farbe für den zentrierten Counter"
L["COLORSTATUS"] = "Farbe für '%s' MUF-Status einstellen."
L["CTRL"] = "Strg"
L["CURE_PETS"] = "Begleiter scannen und reinigen"
L["CURSE"] = "Fluch"
L["DEBUG_REPORT_HEADER"] = [=[|cFF11FF33Bitte sende den Inhalt dieses Fensters an <%s>|r
|cFF009999(Benutze Strg+A, um alles zu markieren, und dann Strg+C, um den Text in deine Zwischenablage zu kopieren)|r
Bitte berichte ebenfalls, ob du merkwürdiges Verhalten von %s bemerkt hast.
]=]
L["DECURSIVE_DEBUG_REPORT"] = " **** |cFFFF0000Decursive-Debug-Bericht|r ****"
L["DECURSIVE_DEBUG_REPORT_NOTIFY"] = [=[Ein Debug-Bericht ist vorhanden!
Gib |cFFFF0000/DCRREPORT|r ein, um ihn zu sehen.]=]
L["DECURSIVE_DEBUG_REPORT_SHOW"] = "Debug-Bericht verfügbar!"
L["DECURSIVE_DEBUG_REPORT_SHOW_DESC"] = "Einen Debug-Bericht anzeigen, den der Autor sehen sollte..."
L["DEFAULT_MACROKEY"] = "`"
L["DEV_VERSION_ALERT"] = [=[Du benutzt eine Entwickler-Version von Decursive.

Falls du nicht teilhaben willst am Testen neuer Features/Fehlerbehebungen, Erhalten von Fehlerbehebungsberichten im Spiel, Probleme oder Anfragen senden möchtest an den Entwickler, dann VERWENDE DIESE VERSION NICHT und lade die letzte stabile Version herunter bei curse.com oder wowace.com.

Diese Mitteilunge wird nur einmal pro Version in den Chat ausgegeben.]=]
L["DEV_VERSION_EXPIRED"] = [=[Diese Entwickler-Version von Decursive ist abgelaufen.
Du solltest die neueste Entwickler-Version herunterladen oder zurückgehen zur aktuellen stabilen Release-Version, die du bei CURSE.COM oder WAWACE.COM findest.
Diese Warnung wird alle zwei Tage angezeigt.]=]
L["DEWDROPISGONE"] = "Es gibt kein Äquivalent zu DewDrop für Ace3. Alt-Rechts-Klicken, um das Optionsfeld zu öffnen."
L["DISABLEWARNING"] = [=[Decursive wurde ausgeschaltet!

Um es erneut zu aktivieren, gib |cFFFFAA44/DCR ENABLE|r ein.]=]
L["DISEASE"] = "Krankheit"
L["DONOT_BL_PRIO"] = "Namen der Prioritätenliste nicht auf schwarze Liste setzen"
L["FAILEDCAST"] = [=[|cFF22FFFF%s %s|r |cFFAA0000gescheitert bei|r %s
|cFF00AAAA%s|r]=]
L["FOCUSUNIT"] = "Focus Einheit"
L["FUBARMENU"] = "FuBar-Menü"
L["FUBARMENU_DESC"] = "Optionen relativ zum FuBar-Symbol einstellen"
L["GLOR1"] = "In Gedenken an Glorfindal"
L["GLOR2"] = [=[Decursive ist Bertrand gewidmet, der uns viel zu früh verlassen hat.
Er wird immer in Erinnerung bleiben.]=]
L["GLOR3"] = [=[In Gedenken an Bertrand Sense
1969 - 2007]=]
L["GLOR4"] = [=[Freundschaft und Zuneigung können ihre Wurzeln in alle Richtungen und überall hin wachsen lassen. Jene, die Glorfindal in World of Warcraft getroffen haben, kannten einen Mann mit großem Engagement und einen charismatischen Führer.

In seinem Leben war er wie im Spiel - selbstlos, großzügig, treu und hingebungsvoll seinen Freunden gegenüber und vor allem ein leidenschaftlicher Mann.

Er verließ uns im Alter von 38 Jahren; er ließ nicht bloß anonyme Spieler in einer virtuellen Welt zurück, sondern eine Gruppe treuer Freunde, die ihn für immer vermissen werden.]=]
L["GLOR5"] = "Er wird immer in Erinnerung bleiben..."
L["HANDLEHELP"] = "Alle Mikro-Einheiten-Rahmen (MUFs) bewegen"
L["HIDE_MAIN"] = "Decursive-Fenster verbergen"
L["HIDESHOW_BUTTONS"] = "Verbergen/Anzeigen-Schaltflächen und (ent)sperre die \"Decursive\" Leiste."
L["HLP_LEFTCLICK"] = "Linksklick"
L["HLP_LL_ONCLICK_TEXT"] = [=[Lies bitte die Dokumentation, um den Umgang mit diesem Addon zu lernen. Suche nach "Decursive" auf WoWAce.com
(Um diese Liste zu bewegen, bewege die Decursive-Leiste, /dcrshow und Links-Alt-Klick zum Bewegen)]=]
L["HLP_MIDDLECLICK"] = "Mittlere Maustaste"
L["HLP_NOTHINGTOCURE"] = "Es gibt nichts zu heilen!"
L["HLP_RIGHTCLICK"] = "Rechtsklick"
L["HLP_USEXBUTTONTOCURE"] = "Benutze \"%s\", um dieses Gebrechen zu heilen!"
L["HLP_WRONGMBUTTON"] = "Falscher Mausknopf!"
L["IGNORE_STEALTH"] = "Ignoriere getarnte Einheiten"
L["IS_HERE_MSG"] = "Decursive wurde geladen, kontrolliere bitte die Einstellungen"
L["LIST_ENTRY_ACTIONS"] = [=[|cFF33AA33[Strg]|r-Klick: Diesen Spieler entfernen
|cFF33AA33LINKS|r-Klick: Diesen Spieler höher setzen
|cFF33AA33RECHTS|r-Klick: Diesen Spieler herabsetzen
|cFF33AA33[SHIFT] LINKS|r-Klick: Diesen Spieler ganz nach oben setzen
|cFF33AA33[SHIFT] RECHTS|r-Klick: Diesen Spieler ganz nach unten setzen]=]
L["MACROKEYALREADYMAPPED"] = [=[WARNUNG: Die an das Decursive-Makro [%s] gebundene Taste war bereits an die Aktion '%s' gebunden.
Decursive wird die vorherige Tastenbindung wiederherstellen, falls du eine andere Taste für das Makro einstellst.]=]
L["MACROKEYMAPPINGFAILED"] = "Die Taste [%s] konnte nicht an das Decursive-Makro gebunden werden!"
L["MACROKEYMAPPINGSUCCESS"] = "Die Taste [%s] wurde erfolgreich an das Decursive-Makro gebunden."
L["MACROKEYNOTMAPPED"] = "Das Decursive-Makro zum Darüberlegen der Maus ist nicht an eine Taste gebunden; wirf einen Blick auf die \"Makro\"-Optionen!"
L["MAGIC"] = "Magie"
L["MAGICCHARMED"] = "Magische Verzauberung"
L["MISSINGUNIT"] = "Fehlende Einheit"
L["NEW_VERSION_ALERT"] = [=[Eine neue Version von Decursive wurde ermittelt: |cFFEE7722%q|r veröffentlicht am |cFFEE7722%s|r!


Gehe zu |cFFFF0000WoWAce.com|r, um es zu holen!
--------]=]
L["NORMAL"] = "Normal"
L["NOSPELL"] = "Kein Zauber verfügbar"
L["OPT_ABOLISHCHECK_DESC"] = "Wähle, ob Einheiten mit einem aktiven \"Aufheben\"-Zauber angezeigt und geheilt werden sollen."
L["OPT_ABOUT"] = "Über"
L["OPT_ADD_A_CUSTOM_SPELL"] = "Füge eigenen Spell/Item hinzu"
L["OPT_ADD_A_CUSTOM_SPELL_DESC"] = "Spell oder benutzbares Item per Ziehen und Ablegen hier hinzufügen. Du kannst auch direkt seinen Namen rein schreiben, seine ID, oder Shift-Klick verwenden."
L["OPT_ADDDEBUFF"] = "Ein Gebrechen manuell hinzufügen"
L["OPT_ADDDEBUFF_DESC"] = "Ein neues Gebrechen wird der Liste hinzugefügt"
L["OPT_ADDDEBUFF_USAGE"] = "<Name des Gebrechens>"
L["OPT_ADDDEBUFFFHIST"] = "Erneuertes Gebrechen hinzufügen."
L["OPT_ADDDEBUFFFHIST_DESC"] = "Ein Gebrechen aus der Vergangenheit hinzufügen"
L["OPT_ADVDISP"] = "Fortgeschrittene Anzeige-Optionen"
L["OPT_ADVDISP_DESC"] = "Erlauben, die Transparenz des Rands und der Mitte getrennt einzustellen, den Abstand zwischen jedem MUF einzustellen."
L["OPT_AFFLICTEDBYSKIPPED"] = "%s befallen von %s, wird jedoch übergangen."
L["OPT_ALLOWMACROEDIT"] = "Makro-Bearbeitung zulassen"
L["OPT_ALLOWMACROEDIT_DESC"] = "Aktivieren, um Decursive an der Aktualisierung seines Makros zu hindern, und dir die Bearbeitung zu ermöglichen."
L["OPT_ALWAYSIGNORE"] = "Auch außerhalb des Kampfes ignorieren"
L["OPT_ALWAYSIGNORE_DESC"] = "Falls Markiert, wird dieses Gebrechen auch dann ignoriert, wenn du dich nicht im Kampf befindest."
L["OPT_AMOUNT_AFFLIC_DESC"] = "Definiert die maximale Anzahl der anzuzeigenden Verfluchten in der aktuellen Liste"
L["OPT_ANCHOR_DESC"] = "Zeigt Anker des Rahmens der allgemeinen Mitteilungen an"
L["OPT_AUTOHIDEMFS"] = "MUFs verbergen, wenn: "
L["OPT_AUTOHIDEMFS_DESC"] = "Wähle, wann das MUF-Fenster automatisch verborgen werden soll."
L["OPT_BLACKLENTGH_DESC"] = "Definiert, wie lange jemand auf der schwarzen Liste verbleibt."
L["OPT_BORDERTRANSP"] = "Transparenz der Umrandung"
L["OPT_BORDERTRANSP_DESC"] = "Transparenz der Umrandung einstellen"
L["OPT_CENTERTEXT_DISABLED"] = "Deaktiviert"
L["OPT_CENTERTEXT_ELAPSED"] = "Verstrichene Zeit"
L["OPT_CENTERTEXT_STACKS"] = "Anzahl Stacks"
L["OPT_CENTERTEXT_TIMELEFT"] = "Verbleibende Zeit"
L["OPT_CENTERTRANSP"] = "Transparenz Mitte"
L["OPT_CENTERTRANSP_DESC"] = "Transparenz der Mitte einstellen"
L["OPT_CHARMEDCHECK_DESC"] = "Wenn markiert, bist du in der Lage, bezauberte Einheiten zu sehen und zu behandeln."
L["OPT_CHATFRAME_DESC"] = "Decursive-Mitteilungen werden im Standard-Chat-Rahmen ausgegeben."
L["OPT_CHECKOTHERPLAYERS"] = "Andere Spieler überprüfen"
L["OPT_CHECKOTHERPLAYERS_DESC"] = "Zeigt Decursive-Version den Spielern in deiner aktuellen Gruppe oder Gilde an (kann nicht Versionen vor Decursive 2.4.6 anzeigen)."
L["OPT_CMD_DISBLED"] = "Deaktiviert"
L["OPT_CMD_ENABLED"] = "Aktiviert"
L["OPT_CREATE_VIRTUAL_DEBUFF"] = "Ein virtuelles Gebrechen zum Testen erzeugen."
L["OPT_CREATE_VIRTUAL_DEBUFF_DESC"] = "Lässt dich sehen, wie es aussieht, wenn ein Gebrechen gefunden wurde."
L["OPT_CURE_PRIORITY_NUM"] = "Priorität #%d"
L["OPT_CUREPETS_DESC"] = "Begleiter werden bearbeitet und geheilt"
L["OPT_CURINGOPTIONS"] = "Optionen zur Heilung"
L["OPT_CURINGOPTIONS_DESC"] = "Verschiedene Aspekte des Heilungsprozesses einstellen"
L["OPT_CURINGOPTIONS_EXPLANATION"] = [=[Wähle die Arten von Gebrechen, die du heilen möchtest. Nicht markierte Typen werden komplett von Decursive ignoriert.

Die grüne Zahl legt die Priorität des Gebrechens fest. Diese Priorität beeinflußt mehrere Aspekte:
- Was Decursive als erstes anzeigt, wenn ein Spieler an verschiedenen Debuff-Typen leidet.
- Welche Maus-Schaltfläche du klicken mußt, um den jeweiligen Debuff zu heilen (Erster Zauber ist Linksklick, zweiter ist Rechtsklick, etc...).

All dies wird in der Dokumentation genau erklärt (muß gelesen werden):
http://www.wowace.com/addons/decursive/
]=]
L["OPT_CURINGORDEROPTIONS"] = "Optionen zur Rehenfolge der Heilungen"
L["OPT_CURSECHECK_DESC"] = "Falls markiert, bist du in der Lage, verfluchte Einheiten zu sehen und zu heilen."
L["OPT_CUSTOM_SPELL_ISPET"] = "Pet-Fähigkeit"
L["OPT_CUSTOM_SPELL_MACRO_TEXT"] = "Macro Text:"
L["OPT_CUSTOM_SPELL_MACRO_TOO_LONG"] = "Dein Macro ist zu lang, du musst %d Zeichen entfernen."
L["OPT_CUSTOM_SPELL_PRIORITY"] = "Zauber-Priorität"
L["OPT_CUSTOM_SPELL_UNAVAILABLE"] = "Nicht verfügbar"
L["OPT_CUSTOMSPELLS"] = "Eigene Zauber/Items"
L["OPT_DEBCHECKEDBYDEF"] = [=[

Standardmäßig markiert]=]
L["OPT_DEBUFFENTRY_DESC"] = "Wähle welche Klasse im Kampf ignoriert werden soll,  wenn jemand von diesem Leiden betroffen ist."
L["OPT_DEBUFFFILTER"] = "Gebrechen-Filter"
L["OPT_DEBUFFFILTER_DESC"] = "Gebrechen wählen, die nach Name und Klasse gefiltert werden sollen, während du dich im Kampf befindest."
L["OPT_DELETE_A_CUSTOM_SPELL"] = "Entfernen"
L["OPT_DISABLEABOLISH"] = "\"Aufheben\"-Zauber nicht verwenden"
L["OPT_DISABLEABOLISH_DESC"] = "Wenn aktiviert, bevorzugt Decursive \"Krankheit heilen\" und \"Gift heilen\" gegenüber den entsprechenden \"Aufheben\"-Zaubern."
L["OPT_DISABLEMACROCREATION"] = "Makro-Erstellung ausschalten"
L["OPT_DISABLEMACROCREATION_DESC"] = "Decursive-Makro wird nicht mehr kreiert oder erhalten"
L["OPT_DISEASECHECK_DESC"] = "Falls markiert, wirst du in der Lage sein, erkrankte Einheiten zu sehen und zu heilen."
L["OPT_DISPLAYOPTIONS"] = "Anzeigeoptionen"
L["OPT_DONOTBLPRIO_DESC"] = "Priorisierte Einheiten werden nicht auf die schwarze Liste gesetzt."
L["OPT_ENABLE_A_CUSTOM_SPELL"] = "Aktivieren"
L["OPT_ENABLEDEBUG"] = "Fehlersuche zulassen"
L["OPT_ENABLEDEBUG_DESC"] = "Ausgabe der Fehlersuche zulassen"
L["OPT_ENABLEDECURSIVE"] = "Decursive aktivieren"
L["OPT_FILTEROUTCLASSES_FOR_X"] = "%q wird bei den spezifizierten Klassen ignoriert während du dich im Kampf befindest."
L["OPT_GENERAL"] = "Allgemeine Optionen"
L["OPT_GROWDIRECTION"] = "Anzeige der MUFs umkehren"
L["OPT_GROWDIRECTION_DESC"] = "Die MUFs werden von unten nach oben angezeigt."
L["OPT_HIDEMFS_GROUP"] = "im Solo- oder Gruppenspiel"
L["OPT_HIDEMFS_GROUP_DESC"] = "Das MUF-Fenster verbergen, wenn du nicht in einem Schlachtzug bist."
L["OPT_HIDEMFS_NEVER"] = "Niemals autom. verbergen"
L["OPT_HIDEMFS_NEVER_DESC"] = "Das MUF-Fenster nie automatisch verbergen."
L["OPT_HIDEMFS_SOLO"] = "im Solospiel"
L["OPT_HIDEMFS_SOLO_DESC"] = "Das MUF-Fenster verbergen, wenn du nicht in irgendeiner Art von Gruppe bist."
L["OPT_HIDEMUFSHANDLE"] = "MUF-Handhabung verbergen"
L["OPT_HIDEMUFSHANDLE_DESC"] = [=[Verbirgt die Handhabung der Mikro-Einheiten-Rahmen und schaltet die Möglichkeit aus, diese zu bewegen.
Benutze denselben Befehl, um diese wiederherzustellen.]=]
L["OPT_IGNORESTEALTHED_DESC"] = "Getarnte Einheiten werden ignoriert"
L["OPT_INPUT_SPELL_BAD_INPUT_ALREADY_HERE"] = "Zauber bereits gelistet!"
L["OPT_INPUT_SPELL_BAD_INPUT_DEFAULT_SPELL"] = "Decursive managed diesen Zauber bereits. Shift-Klick auf diesen Zauber, oder gebe seine ID ein, um einen speziellen Rang hinzuzufügen."
L["OPT_INPUT_SPELL_BAD_INPUT_ID"] = "Ungültige Zauber-ID!"
L["OPT_INPUT_SPELL_BAD_INPUT_NOT_SPELL"] = "Zauber wurde in deinem Zauberbuch nicht gefunden!"
L["OPT_LIVELIST"] = "Aktuelle Liste"
L["OPT_LIVELIST_DESC"] = "Optionen für die aktuelle Liste"
L["OPT_LLALPHA"] = "Transparenz Lder aktuellen Liste"
L["OPT_LLALPHA_DESC"] = "Verändert die Transparenz der Decursive-Hauptleiste und der aktuellen Liste (Haupotleiste muß dabei angezeigt werden)"
L["OPT_LLSCALE"] = "Skalierung der aktuellen Liste"
L["OPT_LLSCALE_DESC"] = "Die Größe der Decursive-Hauptleiste und der aktuellen Liste einstellen (die Hauptleiste muß dabei angezeigt werden)."
L["OPT_LVONLYINRANGE"] = "Nur Einheiten in Reichweite"
L["OPT_LVONLYINRANGE_DESC"] = "Nur Einheiten in Heilungsreichweite werden in der aktuellen Liste angezeigt."
L["OPT_MACROBIND"] = "Die an das Makro gebundene Taste festlegen"
L["OPT_MACROBIND_DESC"] = [=[Definiert die Taste, mit der das "Decursive"-Makro aufgerufen wird.

Drücke die Taste und bestätige die Eingabe mit "Enter", um die neue Zuweisung zu speichern (mit deinem Mauszeiger über dem Bearbeitungsfeld)]=]
L["OPT_MACROOPTIONS"] = "Makro-Optionen"
L["OPT_MACROOPTIONS_DESC"] = "Das Verhalten des von Decursive erstellten Mouseover-Makros festlegen."
L["OPT_MAGICCHARMEDCHECK_DESC"] = "Falls markiert, wirst du in der Lage sein, magisch verzauberte Einheiten zu sehen und zu heilen."
L["OPT_MAGICCHECK_DESC"] = "Falls markiert, wirst du in der Lage sein, mit magischen Gebrechen behaftete Einheiten zu sehen und zu heilen."
L["OPT_MAXMFS"] = "Maximale Anzahl der Einheiten, die angezeigt werden sollen"
L["OPT_MAXMFS_DESC"] = "Definiert die maximale Anzahl an Mikro-Einheitsrahmen, die angezeigt werden sollen"
L["OPT_MESSAGES"] = "Mitteilungen"
L["OPT_MESSAGES_DESC"] = "Anzeige-Optionen für Mitteilungen"
L["OPT_MFALPHA"] = "Transparenz"
L["OPT_MFALPHA_DESC"] = "Definiert die Transparenz der MUFs, wenn Einheiten nicht befallen sind"
L["OPT_MFPERFOPT"] = "Leistungs-Optionen"
L["OPT_MFREFRESHRATE"] = "Aktualisierungsrate"
L["OPT_MFREFRESHRATE_DESC"] = "Zeitlicher Abstand zwischen den Erneuerungsabfragen ( 1 oder mehrere Mikro-Einheiten-Rahmen können gleichzeitig erneuert werden)."
L["OPT_MFREFRESHSPEED"] = "Aktualisierungsgeschwindigkeit"
L["OPT_MFREFRESHSPEED_DESC"] = "Anzahl der Mikro-Einheiten-Rahmen, die bei jedem Aktualisierungsabruf auf einmal erneuert werden sollen."
L["OPT_MFSCALE"] = "Skalierung der Mikro-Einheiten-Rahmen (MUFs)"
L["OPT_MFSCALE_DESC"] = "Die Größe der Mikro-Einheiten-Rahmen (MUFs) festlegen"
L["OPT_MFSETTINGS"] = "Einstellungen der Mikro-Einheiten-Rahmen (MUFs)"
L["OPT_MFSETTINGS_DESC"] = "Die Fenster-Optionen der Mikro-Einheiten-Rahmen (MUF) deinen Bedürfnissen anpassen."
L["OPT_MUFFOCUSBUTTON"] = "Fokus-Schaltfläche:"
L["OPT_MUFHANDLE_HINT"] = "Um die Micro-Unit-Frames zu bewegen: ALT-Klick auf das unsichtbare Icon über dem ersten Micro-Unit-Frame Icon."
L["OPT_MUFMOUSEBUTTONS"] = "Maus-Schaltflächen"
L["OPT_MUFMOUSEBUTTONS_DESC"] = "Bestimme die Maustasten, die Du für die verschiedenen Warnfarben der Mikroeinheiten Anzeige (MUF) benutzen möchtest. "
L["OPT_MUFSCOLORS"] = "Farben"
L["OPT_MUFSCOLORS_DESC"] = "Die Farben der Mikro-Einheiten-Rahmen verändern"
L["OPT_MUFSVERTICALDISPLAY"] = "Vertikale Anzeige"
L["OPT_MUFSVERTICALDISPLAY_DESC"] = "MUF's Fenster wächst senkrecht an"
L["OPT_MUFTARGETBUTTON"] = "Tiel-Schaltfläche:"
L["OPT_NEWVERSIONBUGMENOT"] = "Warnung bei neuer Version"
L["OPT_NEWVERSIONBUGMENOT_DESC"] = "Falls eine neuere Version von Decursive ermittelt wird, erscheint einmal alle sieben Tage eine Pop-Up-Meldung dazu."
L["OPT_NOKEYWARN"] = "Warnen, falls keine Tastenbelegung vorhanden"
L["OPT_NOKEYWARN_DESC"] = "Eine Warnmeldung ausgeben, wenn keine Taste zugeordnet wurde."
L["OPT_NOSTARTMESSAGES"] = "Begrüssungsmitteilungen ausschalten"
L["OPT_NOSTARTMESSAGES_DESC"] = "Die Mitteilungen entfernen, die Decursive bei jedem Einloggen im Chat-Fenster ausgibt."
L["OPT_OPTIONS_DISABLED_WHILE_IN_COMBAT"] = "Während du dich im Kampf befindest, sind diese Optionen gesperrt."
L["OPT_PERFOPTIONWARNING"] = "WANUNG: Verändere niemals diese Werte, ausser Du weißt genau was Du machst! Diese Einstellung können massive Auswirkungen auf die Lesitungsfähigkeit des Spiels haben. Für die meisten Spieler genügen die Grundeinstellungen von 0.1 und 10."
L["OPT_PLAYSOUND_DESC"] = "Einen Ton abspielen, wenn jemand mit einem Fluch belegt worden ist."
L["OPT_POISONCHECK_DESC"] = "Falls markiert, wirst du in der Lage sein, vergiftete Einheiten zu sehen und zu heilen."
L["OPT_PRINT_CUSTOM_DESC"] = "Decursive-Mitteilungen werden in einem eigenen Chat-Rahmen ausgegeben"
L["OPT_PRINT_ERRORS_DESC"] = "Fehler werden angezeigt"
L["OPT_PROFILERESET"] = "Profil wird zurückgesetzt...."
L["OPT_RANDOMORDER_DESC"] = "Einheiten werden willkürlich angezeigt und geheilt (nicht empfohlen)"
L["OPT_READDDEFAULTSD"] = "Standard-Gebrechen erneut hinzufügen"
L["OPT_READDDEFAULTSD_DESC1"] = [=[Fehlende Decursive-Standard-Gebrechen dieser Liste hinzufügen.
Deine Einstellungen werden hiermit nicht verändert.]=]
L["OPT_READDDEFAULTSD_DESC2"] = "Alle Decursive-Standard-Gebrechen befinden sich in der Liste."
L["OPT_REMOVESKDEBCONF"] = [=[Bist du dir sicher, dass du
 '%s'
von der Decursive-Liste der zu übergehenden Gebrechen entfernen möchtest?]=]
L["OPT_REMOVETHISDEBUFF"] = "Dieses Gebrechen entfernen"
L["OPT_REMOVETHISDEBUFF_DESC"] = "Entfernt '%s' von der Liste der zu übergehenden Gebrechen."
L["OPT_RESETDEBUFF"] = "Dieses Gebrechen zurücksetzen"
L["OPT_RESETDTDCRDEFAULT"] = "'%s'  wird auf Decursives Standard zurückgesetzt"
L["OPT_RESETMUFMOUSEBUTTONS"] = "Zurücksetzen"
L["OPT_RESETMUFMOUSEBUTTONS_DESC"] = "Zuordnungen der Maus-Schaltflächen auf Standard zurücksetzen."
L["OPT_RESETOPTIONS"] = "Optionen auf Standard zurücksetzen"
L["OPT_RESETOPTIONS_DESC"] = "Aktuelles Profil auf die Standardwerte zurücksetzen."
L["OPT_RESTPROFILECONF"] = [=[Bist du dir sicher, dass du das Profil
'(%s) %s'
auf die Standardoptionen zurücksetzen möchtest?]=]
L["OPT_REVERSE_LIVELIST_DESC"] = "Die aktuelle Liste wird von unten nach oben ausgefüllt"
L["OPT_SCANLENGTH_DESC"] = "Definiert den Zeitabstand zwischen jedem Scanvorgang"
L["OPT_SHOW_STEALTH_STATUS"] = "Verborgenheitsstatus anzeigen"
L["OPT_SHOW_STEALTH_STATUS_DESC"] = "Wenn sich ein Spieler in Verborgenheit befindet, nimmt sein MUF eine spezielle Farbe an."
L["OPT_SHOWBORDER"] = "Umrandung in Klassenfarben anzeigen"
L["OPT_SHOWBORDER_DESC"] = "Eine farbige Umrandung wird um die MUFs angezeigt, die der Klasse der Einheiten entspricht."
L["OPT_SHOWHELP"] = "Hilfe anzeigen"
L["OPT_SHOWHELP_DESC"] = "Zeigt einen detaillierten Tooltip an, wenn du die Maus über einen Mikro-Einheiten-Rahmen legst."
L["OPT_SHOWMFS"] = "Mikro-Einheiten-Rahmen anzeigen"
L["OPT_SHOWMFS_DESC"] = "Dies muss eingeschaltet sein, wenn du mit Mausklicks heilen möchtest."
L["OPT_SHOWMINIMAPICON"] = "Symbol an der Minikarte"
L["OPT_SHOWMINIMAPICON_DESC"] = "Symbol an der Minikarte anzeigen/verbergen."
L["OPT_SHOWTOOLTIP_DESC"] = "Zeigt einen detaillierten Tooltip über Flüche in der aktuellen Liste und in den MUFs an."
L["OPT_STICKTORIGHT"] = "MUF-Fenster rechtsbündig ausrichten"
L["OPT_STICKTORIGHT_DESC"] = "Das MUF-Fenster wächst von rechts nach links. Falls notwendig, wird der Halter bewegt."
L["OPT_TESTLAYOUT"] = "Test-Layout"
L["OPT_TESTLAYOUT_DESC"] = [=[Erschaffe simulierte Einheiten, so dass du das Anzeige-Layout testen kannst.
(Warte ein paar Sekunden nach dem Klicken!)]=]
L["OPT_TESTLAYOUTUNUM"] = "Einheitsnummer"
L["OPT_TESTLAYOUTUNUM_DESC"] = "Anzahl der zu erschaffenden simulierten Einheiten einstellen."
L["OPT_TIE_LIVELIST_DESC"] = "Die Anzeige der aktuellen Liste ist verbunden mit der Anzeige der Decursive-Leisten."
L["OPT_TIECENTERANDBORDER"] = "Transparenz der Mitte und des Rands miteinander verbinden."
L["OPT_TIECENTERANDBORDER_OPT"] = "Falls markiert, ist die Transparenz des Rands die Hälfte der Transparenz der Mitte."
L["OPT_TIEXYSPACING"] = "Horizontalen und vertikalen Abstand an einander binden"
L["OPT_TIEXYSPACING_DESC"] = "Der horizontale und vertikale Abstand zwischen MUFs sind gleich."
L["OPT_UNITPERLINES"] = "Anzahl der Einheiten pro Zeile"
L["OPT_UNITPERLINES_DESC"] = "Definiert die max. Anzahl an Mikro-Einheitenrahmen, die pro Zeile angezeigt werden sollen."
L["OPT_USERDEBUFF"] = "Dieses Leiden gehört nicht zu Decursives standardmässigen Leiden."
L["OPT_XSPACING"] = "Horizontaler Abstand"
L["OPT_XSPACING_DESC"] = "Den horizontalen Abstand zwischen MUFs einstellen."
L["OPT_YSPACING"] = "Vertikaler Abstand"
L["OPT_YSPACING_DESC"] = "Den vertikalen Abstand zwischen MUFs einstellen."
L["OPTION_MENU"] = "Decursive-Optionsmenü"
L["PLAY_SOUND"] = "Akustische Warnung, falls jemand eine Reinigung benötigt"
L["POISON"] = "Gift"
L["POPULATE"] = "P"
L["POPULATE_LIST"] = "Decursive-Liste schnell bestücken"
L["PRINT_CHATFRAME"] = "Mitteilungen im Standard-Chat ausgeben"
L["PRINT_CUSTOM"] = "Mitteilungen im Fenster ausgeben"
L["PRINT_ERRORS"] = "Fehlermitteilungen ausgeben"
L["PRIORITY_LIST"] = "Decursive-Prioritätenliste"
L["PRIORITY_SHOW"] = "P"
L["RANDOM_ORDER"] = "Reinige in zufälliger Reihenfolge"
L["REVERSE_LIVELIST"] = "Aktuelle Liste umgekehrt anzeigen"
L["SCAN_LENGTH"] = "Sekunden zwischen Live-Scans: "
L["SHIFT"] = "SHIFT"
L["SHOW_MSG"] = "Um den Decursive-Rahmen anzuzeigen, /dcrshow eingeben"
L["SHOW_TOOLTIP"] = "Tooltips bei befallenen Einheiten anzeigen"
L["SKIP_LIST_STR"] = "Decursive-Ignorierliste"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "Zauber %s gefunden!"
L["STEALTHED"] = "getarnt"
L["STR_CLOSE"] = "Schließen"
L["STR_DCR_PRIO"] = "Decursive-Prioritätenliste"
L["STR_DCR_SKIP"] = "Decursive-Ignorierliste"
L["STR_GROUP"] = "Gruppe "
L["STR_OPTIONS"] = "Decursive-Optionen"
L["STR_OTHER"] = "Sonstige"
L["STR_POP"] = "Bestückungsliste"
L["STR_QUICK_POP"] = "Schnellbestücken"
L["SUCCESSCAST"] = "|cFF22FFFF%s %s|r |cFF00AA00Erfolgreich bei|r %s"
L["TARGETUNIT"] = "Zieleinheit"
L["TIE_LIVELIST"] = "Sichtbarkeit der aktuellen Liste an DCR-Fenster binden"
L["TOOFAR"] = "Zu weit entfernt"
L["UNITSTATUS"] = "Einheitenstatus:"
L["UNSTABLERELEASE"] = "Instabile Veröffentlichung"

	elseif locale == "esES" then
L["ABOLISH_CHECK"] = "Comprobar \"Abolido\" antes de curar"
L["ABSENT"] = "Falta (%s)"
L["AFFLICTEDBY"] = "%s Afectado"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "Cantidad de afectados a mostrar:"
L["ANCHOR"] = "Anclaje del Texto de Decursive"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "Mostrar u ocultar los micro-unit frames"
L["BINDING_NAME_DCRPRADD"] = "Añadir objetivo a la lista de prioridad"
L["BINDING_NAME_DCRPRCLEAR"] = "Limpiar la lista de prioridad"
L["BINDING_NAME_DCRPRLIST"] = "Imprimir la lista de prioridad"
L["BINDING_NAME_DCRPRSHOW"] = "Mostrar u ocultar la lista de prioridad"
L["BINDING_NAME_DCRSHOW"] = [=[Mostrar u ocultar la barra principal de Decursive
(live-list anchor)]=]
L["CLASS_HUNTER"] = "Cazador"
L["CURSE"] = "Maldición"
L["DEFAULT_MACROKEY"] = "NONE"
L["DISEASE"] = "Enfermedad"
L["MAGIC"] = "Magia"
L["OPT_UNITPERLINES_DESC"] = "Define el número máximo de micro-marcos de unidades a mostrar por línea"
L["OPT_XSPACING"] = "Espaciado horizontal"
L["OPT_YSPACING"] = "Espaciado vertical"
L["PLAY_SOUND"] = "Reproducir un sonido cuando hay alguien a quien curar"
L["POISON"] = "Veneno"
L["POPULATE"] = "p"
L["PRINT_CHATFRAME"] = "Mostrar mensajes en el chat predeterminado"
L["RANDOM_ORDER"] = "Curar en orden aleatorio"
L["SCAN_LENGTH"] = "Segundos entre escaneos en vivo :"
L["SHIFT"] = "Shift"
L["SHOW_MSG"] = "Para mostrar la ventana de Decursive, escribe /dcrshow"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "¡%s hechizo encontrado!"
L["STR_CLOSE"] = "Cerrar"
L["STR_DCR_PRIO"] = "Prioridad decursive"
L["STR_DCR_SKIP"] = "No decursear"
L["STR_GROUP"] = "Grupo"
L["STR_OPTIONS"] = "Opciones"
L["STR_OTHER"] = "Otro"
L["TOOFAR"] = "Muy lejos"

	elseif locale == "zhTW" then
L["ABOLISH_CHECK"] = "施法前檢查是否需要淨化"
L["ABOUT_AUTHOREMAIL"] = "作者 E-Mail"
L["ABOUT_CREDITS"] = "貢獻者"
L["ABOUT_LICENSE"] = "許可"
L["ABOUT_NOTES"] = "當單獨、小隊和團隊時清除有害狀態，並可使用高級過濾和優先等級系統。"
L["ABOUT_OFFICIALWEBSITE"] = "官方網站"
L["ABOUT_SHAREDLIBS"] = "共享庫"
L["ABSENT"] = "不存在 (%s)"
L["AFFLICTEDBY"] = "受 %s 影響"
L["ALT"] = "ALt"
L["AMOUNT_AFFLIC"] = "即時清單顯示人數: "
L["ANCHOR"] = "Decursive 文字定位點"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "顯示或隱藏 MUF"
L["BINDING_NAME_DCRPRADD"] = "添加目標至優先名單"
L["BINDING_NAME_DCRPRCLEAR"] = "清空優先名單"
L["BINDING_NAME_DCRPRLIST"] = "顯示優先名單至聊天視窗"
L["BINDING_NAME_DCRPRSHOW"] = "開/關優先名單"
L["BINDING_NAME_DCRSHOW"] = "顯示或隱藏 Decursive 工作條"
L["BINDING_NAME_DCRSHOWOPTION"] = "顯示靜態設定選單"
L["BINDING_NAME_DCRSKADD"] = "添加目標至忽略名單"
L["BINDING_NAME_DCRSKCLEAR"] = "清空忽略名單"
L["BINDING_NAME_DCRSKLIST"] = "顯示忽略名單至聊天視窗"
L["BINDING_NAME_DCRSKSHOW"] = "開/關忽略名單"
L["BLACK_LENGTH"] = "停留在排除名單的時間: "
L["BLACKLISTED"] = "在排除名單"
L["CHARM"] = "魅惑"
L["CLASS_HUNTER"] = "獵人"
L["CLEAR_PRIO"] = "C"
L["CLEAR_SKIP"] = "C"
L["COLORALERT"] = "設定按鍵警示'%s'的顏色"
L["COLORCHRONOS"] = "秒錶"
L["COLORCHRONOS_DESC"] = "設定秒錶顏色"
L["COLORSTATUS"] = "設定當玩家狀態是 '%s' 時的 MUF 顏色."
L["CTRL"] = "Ctrl"
L["CURE_PETS"] = "檢測並淨化寵物"
L["CURSE"] = "詛咒"
L["DEBUG_REPORT_HEADER"] = [=[|cFF11FF33請報告此視窗的內容給 <%s>|r
|cFF009999（使用 CTRL+A 選擇所有 CTRL+C 復制文本到剪切板）|r
如果發現 %s 任何奇怪的行為也一并報告。
]=]
L["DECURSIVE_DEBUG_REPORT"] = "**** |cFFFF0000Decursive 除錯報告|r ****"
L["DECURSIVE_DEBUG_REPORT_BUT_NEW_VERSION"] = [=[|cFF11FF33Decursive 啟動失敗但請勿擔心! 一個新版本的Decursive已經被偵測到 (%s)。你只需要執行更新。前往curse.com並搜索"Decursive" 或使用Curse Client，此服務會自動更新所有您最愛的UI。|r
|cFFFF1133 所以請不要浪費你的時間回報此錯誤，因為它也許已被修正。安裝新更新並排除問題! |r
|cFF11FF33 感謝你閱讀此訊息! |r
]=]
L["DECURSIVE_DEBUG_REPORT_NOTIFY"] = [=[一個出錯報告可用！
輸入 |cFFFF0000/DCRREPORT|r 查看]=]
L["DECURSIVE_DEBUG_REPORT_SHOW"] = "除錯報告可用！"
L["DECURSIVE_DEBUG_REPORT_SHOW_DESC"] = "顯示作者需要看到的除錯報告…"
L["DEFAULT_MACROKEY"] = "`"
L["DEV_VERSION_ALERT"] = [=[您正在使用的是開發版本的 Decursive 。

如果不想參加測試新功能與修復，得到遊戲中的除錯報告后發送問題給作者，請“不要使用此版本”並從 curse.com 和 wowace.com 下載最新的“穩定”版本。

這條消息只將在版本更新中顯示一次]=]
L["DEV_VERSION_EXPIRED"] = [=[此開發版 Decursive 已過期。
請從 CURSE.COM 和 WOWACE.COM 下載最新的開發版或使用當前穩定版。謝謝！ ^_^
此提示每兩天顯示一次。]=]
L["DEWDROPISGONE"] = "沒有等同于 Ace3 的 DewDrop。Alt+點擊右鍵打開選項面板。"
L["DISABLEWARNING"] = [=[Decursive 已停用！

如欲啟用, 輸入 |cFFFFAA44/DCR ENABLE|r]=]
L["DISEASE"] = "疾病"
L["DONOT_BL_PRIO"] = "不添加優先名單的玩家到排除名單"
L["DONT_SHOOT_THE_MESSENGER"] = "Decursive僅提供事件報告。問題並非Decursive產生，請尋找真正錯誤來源。"
L["FAILEDCAST"] = [=[|cFF22FFFF%s %s|r |cFFAA0000對|r %s釋放失敗
|cFF00AAAA%s|r]=]
L["FOCUSUNIT"] = "監控單位"
L["FUBARMENU"] = "Fubar 選單"
L["FUBARMENU_DESC"] = "Fubar 圖示相關設定"
L["GLOR1"] = "紀念 Glorfindal"
L["GLOR2"] = [=[Decursive 獻給匆匆離我們而去的 Bertrand
他將永遠被我們所銘記。]=]
L["GLOR3"] = [=[紀念 Bertrand 
1969 - 2007]=]
L["GLOR4"] = [=[對於那些在魔獸世界裡遇見過 Glorfindal 的人來說，他是一個重承諾的男人，也是一個有超凡魅力的領袖。

友誼和慈愛將永植於他們的心中。他在遊戲中就如同在他生活中一樣的無私，彬彬有禮，樂於奉獻，最重要的是他對生活充滿熱情。

他離開我們的時候才僅僅38歲，隨他離去的絕不會是虛擬世界匿名的角色；在這裡還有一群忠實的朋友在永遠想念他。]=]
L["GLOR5"] = "他將永遠被我們所銘記。"
L["HANDLEHELP"] = "拖曳移動所有的 Micro-UnitFrames (MUFs)"
L["HIDE_MAIN"] = "隱藏 Decursive 視窗"
L["HIDESHOW_BUTTONS"] = "顯示/隱藏按鈕和鎖定/解鎖“Decursive”條"
L["HLP_LEFTCLICK"] = "左-鍵"
L["HLP_LL_ONCLICK_TEXT"] = [=[實時列表不代表能被點擊。請先閱讀此文檔來學習如何使用此插件。在 WoWAce.com 網站搜索“Decursive”
（從 Decursive 計時條移除此列表，/dcrshow 命令並左Alt+點擊移除）]=]
L["HLP_MIDDLECLICK"] = "中-鍵"
L["HLP_NOTHINGTOCURE"] = "沒有可處理的負面效果！"
L["HLP_RIGHTCLICK"] = "右-鍵"
L["HLP_USEXBUTTONTOCURE"] = "用 \"%s\" 來淨化這個負面效果！"
L["HLP_WRONGMBUTTON"] = "錯誤的滑鼠按鍵！"
L["IGNORE_STEALTH"] = "忽略潛行的玩家"
L["IS_HERE_MSG"] = "Decursive 已經啟動，請核對設定選項。"
L["LIST_ENTRY_ACTIONS"] = [=[|cFF33AA33[CTRL]|r-左鍵: 移除該玩家
 |cFF33AA33左|r-鍵: 提升該玩家順序
 |cFF33AA33右|r-鍵: 降低該玩家順序
 |cFF33AA33[SHIFT] 左|r-鍵: 將該玩家置頂
 |cFF33AA33[SHIFT] 右|r-鍵: 將該玩家置底]=]
L["MACROKEYALREADYMAPPED"] = [=[警告: Decursive 巨集對應按鍵 [%s] 先前對應到 '%s' 動作。
當你設定別的巨集按鍵後 Decursive 會回復此按鍵原有的對應動作。]=]
L["MACROKEYMAPPINGFAILED"] = "按鍵 [%s] 不能被對應到 Decursive 巨集！"
L["MACROKEYMAPPINGSUCCESS"] = "按鍵 [%s] 已成功對應到 Decursive 巨集。"
L["MACROKEYNOTMAPPED"] = "Decursive 巨集未對應到一個按鍵，你可以透過設定選單來設定此一按鍵。(別錯過這個神奇的功能)"
L["MAGIC"] = "魔法"
L["MAGICCHARMED"] = "魔法誘惑"
L["MISSINGUNIT"] = "找不到的單位"
L["NEW_VERSION_ALERT"] = [=[已檢測到新版本的 Decursive：|cFFEE7722%q|r 發佈於 |cFFEE7722%s|r！


請前往|cFFFF0000WoWAce.com|r下載！
--------]=]
L["NORMAL"] = "一般"
L["NOSPELL"] = "沒有可用法術"
L["OPT_ABOLISHCHECK_DESC"] = "檢查玩家身上是否有淨化法術在運作。"
L["OPT_ABOUT"] = "關於"
L["OPT_ADD_A_CUSTOM_SPELL"] = "添加一個自訂法術"
L["OPT_ADD_A_CUSTOM_SPELL_DESC"] = "點擊這裡並 Shift+點擊技能書上的一個法術。也可以直接寫法術名稱或數字 ID。"
L["OPT_ADDDEBUFF"] = "添加一負面效果到清單中"
L["OPT_ADDDEBUFF_DESC"] = "將一個新的負面效果新增到清單中。"
L["OPT_ADDDEBUFF_USAGE"] = "<Debuff name>"
L["OPT_ADDDEBUFFFHIST"] = "新增一個最近受到的負面效果"
L["OPT_ADDDEBUFFFHIST_DESC"] = "從歷史紀錄中新增一個負面效果"
L["OPT_ADVDISP"] = "進階顯示選項"
L["OPT_ADVDISP_DESC"] = "可設定邊框與中央色塊各自的透明度，以及 MUFs 之間的距離。"
L["OPT_AFFLICTEDBYSKIPPED"] = "%s 受到 %s 的影響，但將被忽略。"
L["OPT_ALLOWMACROEDIT"] = "允許巨集版本"
L["OPT_ALLOWMACROEDIT_DESC"] = "啟用此項以防止 Decursive 更新巨集，可自行編輯所需的巨集。"
L["OPT_ALWAYSIGNORE"] = "即使不在戰鬥中也忽略之"
L["OPT_ALWAYSIGNORE_DESC"] = "如果選取該選項，即使脫離戰鬥也忽略該負面效果而不解除"
L["OPT_AMOUNT_AFFLIC_DESC"] = "設定即時清單最多顯示幾人。"
L["OPT_ANCHOR_DESC"] = "顯示自訂視窗的文字定位點。"
L["OPT_AUTOHIDEMFS"] = "隱藏 MUFs："
L["OPT_AUTOHIDEMFS_DESC"] = "選擇何時自動隱藏 MUF 視窗"
L["OPT_BLACKLENTGH_DESC"] = "設定一個人停留在排除名單中的時間。"
L["OPT_BORDERTRANSP"] = "邊框透明度"
L["OPT_BORDERTRANSP_DESC"] = "設定邊框的透明度。"
L["OPT_CENTERTEXT"] = "中央計數器:"
L["OPT_CENTERTEXT_DESC"] = [=[顯示每個MUF的中心最上面的（根據你的優先次序）受影響信息。

其中之一：
- 剩餘時間直至結束
- 從過去時間的影響量(Time elapsed since the affliction hit)
- 距離數]=]
L["OPT_CENTERTEXT_DISABLED"] = "關閉"
L["OPT_CENTERTEXT_ELAPSED"] = "經過時間"
L["OPT_CENTERTEXT_STACKS"] = "距離數"
L["OPT_CENTERTEXT_TIMELEFT"] = "剩餘時間"
L["OPT_CENTERTRANSP"] = "中央透明度"
L["OPT_CENTERTRANSP_DESC"] = "設定中間色塊的透明度"
L["OPT_CHARMEDCHECK_DESC"] = "選取後你可以看見並處理被媚惑的玩家。"
L["OPT_CHATFRAME_DESC"] = "顯示到預設的聊天視窗。"
L["OPT_CHECKOTHERPLAYERS"] = "檢查其他玩家"
L["OPT_CHECKOTHERPLAYERS_DESC"] = "顯示當前小隊或團隊玩家 Decursive 版本（不能顯示 Decursive 2.4.6之前的版本）。"
L["OPT_CMD_DISBLED"] = "已禁用"
L["OPT_CMD_ENABLED"] = "啟用"
L["OPT_CREATE_VIRTUAL_DEBUFF"] = "建立虛擬負面效果測試"
L["OPT_CREATE_VIRTUAL_DEBUFF_DESC"] = "讓你看到當負面效果發生時Decursive的樣子。"
L["OPT_CURE_PRIORITY_NUM"] = "優先級 #%d"
L["OPT_CUREPETS_DESC"] = "寵物會被顯示出來也可淨化。"
L["OPT_CURINGOPTIONS"] = "淨化選項"
L["OPT_CURINGOPTIONS_DESC"] = "淨化的選項包含更改每種負面效果與順序的選項。"
L["OPT_CURINGOPTIONS_EXPLANATION"] = [=[選擇你想要治療的傷害類型，未經檢查的類型將被 Decursive 完全忽略。

綠色數字確定優先的傷害。這一優先事項將影響幾方面：

- 如果一個玩家獲得許多類型的減益效果，Decursive 將優先顯示。

- 滑鼠按鈕點擊將治療減益（第一法術是左鍵點擊，第二法術是右鍵點擊，等等…）

所有這一切的說明文檔（請見）：
http://www.wowace.com/addons/decursive/]=]
L["OPT_CURINGORDEROPTIONS"] = "淨化順序設定"
L["OPT_CURSECHECK_DESC"] = "選取後你可以看見並解除被詛咒的玩家。"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING"] = "允許巨集編輯（僅限進階使用者）"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING_DESC"] = [=[如果要編輯內部巨集請勾選此項，Decursive 將使用您的自訂法術。

注意：勾選此項將允許你編輯由 Decursive 所管理的法術。

If a spell is already listed you'll need to remove it first to enable macro editing.

（--- 僅限進階使用者 ---）]=]
L["OPT_CUSTOM_SPELL_CURE_TYPES"] = "傷害類型"
L["OPT_CUSTOM_SPELL_IS_DEFAULT"] = "此法術是 Decursive 自動配置的一部份，如果此法術無法正常運作，移除或禁用此項以回復預設的 Decursive 設定。"
L["OPT_CUSTOM_SPELL_ISPET"] = "寵物能力"
L["OPT_CUSTOM_SPELL_ISPET_DESC"] = "檢查此技能是否屬於你的寵物，使Decursive能正確偵測並且使用該技能。"
L["OPT_CUSTOM_SPELL_MACRO_MISSING_NOMINAL_SPELL"] = "警告：法術 %q 未出現在巨集中，範圍及冷卻資訊將無法符合。"
L["OPT_CUSTOM_SPELL_MACRO_MISSING_UNITID_KEYWORD"] = "缺少結合關鍵字。"
L["OPT_CUSTOM_SPELL_MACRO_TEXT"] = "巨集文字："
L["OPT_CUSTOM_SPELL_MACRO_TEXT_DESC"] = [=[編輯預設的巨集文字。
|cFFFF0000有兩項限制：|r

- 必須指定目標使用 UNITID 關鍵字，將自動被每個 MUF 的單位 ID 取代。

- 無論法術在巨集中如何使用， Decursive 將保持顯示左方的原始名稱，以利範圍及冷卻的顯示 / 追蹤。
（如果你計畫要使用不同的法術名稱的話，請注意這一點）]=]
L["OPT_CUSTOM_SPELL_MACRO_TOO_LONG"] = "你的巨集過長，需移除 %d 個字元。"
L["OPT_CUSTOM_SPELL_PRIORITY"] = "法術優先級"
L["OPT_CUSTOM_SPELL_PRIORITY_DESC"] = [=[當有多個法術可以治療相同類型的傷害，將選擇優先級高的。

注意Decursive預設管理的能力，優先程度設定範圍為0到9。

因此如果你將自行設定之施法能力的優先程度設為負值，此能力只有在預設施法能力無法使用時才會被選用。]=]
L["OPT_CUSTOM_SPELL_UNAVAILABLE"] = "不可用"
L["OPT_CUSTOMSPELLS"] = "自訂法術"
L["OPT_CUSTOMSPELLS_DESC"] = [=[這裡添加法術以擴展Decursive的自動配置。
您的自訂法術總是會有高優先權，並且將蓋過與替代預設的法術(只有在你的角色可以使用這些法術的時候)。
]=]
L["OPT_CUSTOMSPELLS_EFFECTIVE_ASSIGNMENTS"] = "有效法術分配"
L["OPT_DEBCHECKEDBYDEF"] = [=[

Checked by default]=]
L["OPT_DEBUFFENTRY_DESC"] = "選擇戰鬥中要忽略受到此負面效果影響的職業。"
L["OPT_DEBUFFFILTER"] = "負面效果過濾設定"
L["OPT_DEBUFFFILTER_DESC"] = "設定戰鬥中要忽略的職業與負面效果"
L["OPT_DELETE_A_CUSTOM_SPELL"] = "移除"
L["OPT_DISABLEABOLISH"] = "不使用\"驅散\"法術"
L["OPT_DISABLEABOLISH_DESC"] = "如啟用，Decursive 將為“無效”減益選擇使用“淨化疾病”和“淨化中毒”。"
L["OPT_DISABLEMACROCREATION"] = "禁止創建巨集"
L["OPT_DISABLEMACROCREATION_DESC"] = "Decursive 巨集將不再創建和保留"
L["OPT_DISEASECHECK_DESC"] = "選取後你可以看見並治療生病的玩家。"
L["OPT_DISPLAYOPTIONS"] = "顯示設定"
L["OPT_DONOTBLPRIO_DESC"] = "設定到優先清單的玩家不會被移入排除清單中。"
L["OPT_ENABLE_A_CUSTOM_SPELL"] = "啟用"
L["OPT_ENABLE_LIVELIST"] = "啟用直播列表"
L["OPT_ENABLE_LIVELIST_DESC"] = [=[顯示信息列表受影響玩家。

您可以將這個名單通過移動decursive的欄位 (或者輸入 /DCRSHOW 顯示該欄位).]=]
L["OPT_ENABLEDEBUG"] = "啟用除錯"
L["OPT_ENABLEDEBUG_DESC"] = "啟用除錯輸出"
L["OPT_ENABLEDECURSIVE"] = "啟用 Decursive"
L["OPT_FILTEROUTCLASSES_FOR_X"] = "在戰鬥中指定的職業%q將被忽略。"
L["OPT_GENERAL"] = "一般選項"
L["OPT_GROWDIRECTION"] = "反向顯示 MUFs"
L["OPT_GROWDIRECTION_DESC"] = "MUFs 會從尾巴開始顯示。"
L["OPT_HIDEMFS_GROUP"] = "單獨或小隊"
L["OPT_HIDEMFS_GROUP_DESC"] = "當不在團隊中的時隱藏 MUF 視窗。"
L["OPT_HIDEMFS_NEVER"] = "從不自動隱藏"
L["OPT_HIDEMFS_NEVER_DESC"] = "從不自動隱藏 MUF 視窗。"
L["OPT_HIDEMFS_SOLO"] = "單獨"
L["OPT_HIDEMFS_SOLO_DESC"] = "當不在團隊中或隊伍中的時隱藏 MUF 視窗。"
L["OPT_HIDEMUFSHANDLE"] = "隱藏 MUF 表頭"
L["OPT_HIDEMUFSHANDLE_DESC"] = [=[隱藏微單元面板（MUF）表頭並禁止移動。
Use the same command to get it back.]=]
L["OPT_IGNORESTEALTHED_DESC"] = "忽略潛行的玩家。"
L["OPT_INPUT_SPELL_BAD_INPUT_ALREADY_HERE"] = "法術已在列表中！"
L["OPT_INPUT_SPELL_BAD_INPUT_DEFAULT_SPELL"] = "Decursive 已經包含此法術。Shift+點擊此法術或輸入它的 ID 添加一個特殊等級。"
L["OPT_INPUT_SPELL_BAD_INPUT_ID"] = "法術 ID 不可用！"
L["OPT_INPUT_SPELL_BAD_INPUT_NOT_SPELL"] = "不能在技能書中找到法術！"
L["OPT_LIVELIST"] = "即時清單"
L["OPT_LIVELIST_DESC"] = [=[These are the settings concerning the list of afflicted units displayed beneath the "Decursive" bar.

To move this list you need to move the little "Decursive" frame. Some of the settings below are available only when this frame is displayed. You can display it by typing |cff20CC20/DCRSHOW|r in your chat window.

Once you have set the position, scale and transparency of the live-list you can safely hide Decursive's frame by typing |cff20CC20/DCRHIDE|r.]=]
L["OPT_LLALPHA"] = "實況清單的透明度"
L["OPT_LLALPHA_DESC"] = "變更 Decursive 工作條及實況清單的透明度(工作條必須設定為顯示)"
L["OPT_LLSCALE"] = "縮放即時列表"
L["OPT_LLSCALE_DESC"] = "設定 Decursive 狀態條以及其即時列表的大小（狀態條必須顯示）"
L["OPT_LVONLYINRANGE"] = "只顯示法術有效範圍內的目標"
L["OPT_LVONLYINRANGE_DESC"] = "即時清單只顯示淨化法術有效範圍內的目標。"
L["OPT_MACROBIND"] = "設定巨集按鍵"
L["OPT_MACROBIND_DESC"] = [=[定義呼叫 Decursive 巨集的按鍵。

按你想設定的按鍵然後按 'Enter' 鍵儲存設定(滑鼠要移動到編輯區域)]=]
L["OPT_MACROOPTIONS"] = "巨集設定選項"
L["OPT_MACROOPTIONS_DESC"] = "設定 Decursive 產生的巨集如何動作"
L["OPT_MAGICCHARMEDCHECK_DESC"] = "選取後你可以看見並處理被魔法媚惑的玩家。"
L["OPT_MAGICCHECK_DESC"] = "選取後你可以看見並處理受魔法影響的玩家。"
L["OPT_MAXMFS"] = "最多顯示幾個"
L["OPT_MAXMFS_DESC"] = "設定在螢幕上最多顯示幾個 micro unit frames。"
L["OPT_MESSAGES"] = "訊息設定"
L["OPT_MESSAGES_DESC"] = "設定訊息顯示。"
L["OPT_MFALPHA"] = "透明度"
L["OPT_MFALPHA_DESC"] = "設定無 debuff 時 MUFs 的透明度。"
L["OPT_MFPERFOPT"] = "效能設定選項"
L["OPT_MFREFRESHRATE"] = "刷新頻率"
L["OPT_MFREFRESHRATE_DESC"] = "設定多久刷新一次(一次可刷新一個或數個 micro-unit-frames)。"
L["OPT_MFREFRESHSPEED"] = "刷新速度"
L["OPT_MFREFRESHSPEED_DESC"] = "設定每次刷新多少個 micro-unit-frames。"
L["OPT_MFSCALE"] = "micro-unit-frames 大小"
L["OPT_MFSCALE_DESC"] = "設定螢幕上 micro-unit-frames 的大小。"
L["OPT_MFSETTINGS"] = "微單位框格(MUF)設定選項"
L["OPT_MFSETTINGS_DESC"] = "設定 MUF 框格以顯示不同的負面類型與順序。"
L["OPT_MUFFOCUSBUTTON"] = "監控按鈕："
L["OPT_MUFHANDLE_HINT"] = "移動 MUFs：在第一個 MUF 之上 Alt+點擊的不可見表頭。"
L["OPT_MUFMOUSEBUTTONS"] = "滑鼠綁定"
L["OPT_MUFMOUSEBUTTONS_DESC"] = [=[設定每個 MUF 滑鼠按鈕的警報顏色。

Each priority number represents a different affliction type as specified in the '|cFFFF5533Curing Options|r' panel.

The spell used for each affliction type is set by default but can be changed in the '|cFF00DDDDCustom Spells|r' panel.]=]
L["OPT_MUFSCOLORS"] = "顏色"
L["OPT_MUFSCOLORS_DESC"] = [=[設定MUF不同負面類型的顏色與順序的選項。"

Each priority represents a different affliction type as specified in the '|cFFFF5533Curing Options|r' panel.]=]
L["OPT_MUFSVERTICALDISPLAY"] = "垂直顯示"
L["OPT_MUFSVERTICALDISPLAY_DESC"] = "MUFs 視窗將垂直增長"
L["OPT_MUFTARGETBUTTON"] = "目標按鈕："
L["OPT_NEWVERSIONBUGMENOT"] = "新版本通知"
L["OPT_NEWVERSIONBUGMENOT_DESC"] = "如果有較新版本的 Decursive 被檢測到，每七天將顯示一個彈出警報。"
L["OPT_NOKEYWARN"] = "當沒有設定按鍵時警告"
L["OPT_NOKEYWARN_DESC"] = "當巨集按鍵沒有設定時顯示警告"
L["OPT_NOSTARTMESSAGES"] = "禁用歡迎訊息"
L["OPT_NOSTARTMESSAGES_DESC"] = "移除每次登入時在聊天框架顯示的兩個 Decursive 訊息。"
L["OPT_OPTIONS_DISABLED_WHILE_IN_COMBAT"] = "此選項戰鬥中被禁用。"
L["OPT_PERFOPTIONWARNING"] = "警告：不要更改這些值，除非你確切知道你在做什麼。這些設置可以對遊戲性能影響很大。大多數用戶應當使用0.1和10的默認值。"
L["OPT_PLAYSOUND_DESC"] = "有玩家中了負面效果時發出音效。"
L["OPT_POISONCHECK_DESC"] = "選取後你可以看見並清除中毒的玩家。"
L["OPT_PRINT_CUSTOM_DESC"] = "顯示到自訂的聊天視窗。"
L["OPT_PRINT_ERRORS_DESC"] = "顯示錯誤訊息。"
L["OPT_PROFILERESET"] = "重置設定檔..."
L["OPT_RANDOMORDER_DESC"] = "隨機顯示與淨化玩家(不推薦使用)。"
L["OPT_READDDEFAULTSD"] = "回復預設負面效果"
L["OPT_READDDEFAULTSD_DESC1"] = [=[添加被移除的預設負面效果
你的設定不會被改變。]=]
L["OPT_READDDEFAULTSD_DESC2"] = "所有的預設負面效果都在此清單中。"
L["OPT_REMOVESKDEBCONF"] = [=[你確定要把
 '%s' 
 從負面效果忽略清單中移除？]=]
L["OPT_REMOVETHISDEBUFF"] = "移除此負面效果"
L["OPT_REMOVETHISDEBUFF_DESC"] = "將 '%s' 從忽略清單移除。"
L["OPT_RESETDEBUFF"] = "重置此負面效果"
L["OPT_RESETDTDCRDEFAULT"] = "重置 '%s' 為 Decursive 預設值。"
L["OPT_RESETMUFMOUSEBUTTONS"] = "重置"
L["OPT_RESETMUFMOUSEBUTTONS_DESC"] = "重置滑鼠按鈕指派為默認。"
L["OPT_RESETOPTIONS"] = "重置為原始設定"
L["OPT_RESETOPTIONS_DESC"] = "回復目前的設定檔為原始設定"
L["OPT_RESTPROFILECONF"] = [=[你確定要重置
 '(%s) %s'
 為原始設定?]=]
L["OPT_REVERSE_LIVELIST_DESC"] = "由下到上填滿即時清單。"
L["OPT_SCANLENGTH_DESC"] = "設定掃描時間間隔。"
L["OPT_SHOW_STEALTH_STATUS"] = "顯示潛行狀態"
L["OPT_SHOW_STEALTH_STATUS_DESC"] = "當玩家前行時，他的 MUF 將有一個特殊的顏色"
L["OPT_SHOWBORDER"] = "顯示職業顏色邊框"
L["OPT_SHOWBORDER_DESC"] = "MUFs 邊框會顯示出該玩家的職業代表顏色。"
L["OPT_SHOWHELP"] = "顯示小提示"
L["OPT_SHOWHELP_DESC"] = "當滑鼠移到一個 micro-unit-frame 上時顯示小提示。"
L["OPT_SHOWMFS"] = "在螢幕上顯示 micro units Frame (MUF)"
L["OPT_SHOWMFS_DESC"] = "如果你要在螢幕上按按鍵清除就必須點選這個設定。"
L["OPT_SHOWMINIMAPICON"] = "迷你地圖圖標"
L["OPT_SHOWMINIMAPICON_DESC"] = "啟用迷你地圖小圖示。"
L["OPT_SHOWTOOLTIP_DESC"] = "在即時清單跟 MUFs 上顯示負面效果的小提示。"
L["OPT_STICKTORIGHT"] = "將 MUF 視窗向右對齊"
L["OPT_STICKTORIGHT_DESC"] = "設定這個選項將會使 MUF 視窗由右邊向左邊成長"
L["OPT_TESTLAYOUT"] = "測試布局"
L["OPT_TESTLAYOUT_DESC"] = [=[新建測試單位以測試顯示布局。
（點擊後稍等片刻）]=]
L["OPT_TESTLAYOUTUNUM"] = "單位數字"
L["OPT_TESTLAYOUTUNUM_DESC"] = "設定新建測試單位數字。"
L["OPT_TIE_LIVELIST_DESC"] = "即時清單顯示與否取決於 \"Decursive\" 工作條是否顯示。"
L["OPT_TIECENTERANDBORDER"] = "固定 MUF 中央與邊框的透明度"
L["OPT_TIECENTERANDBORDER_OPT"] = "選取時邊界的透明度固定為中央的一半。"
L["OPT_TIEXYSPACING"] = "固定水平與垂直距離。"
L["OPT_TIEXYSPACING_DESC"] = "固定 MUFs 之間的水平與垂直距離(空白)。"
L["OPT_UNITPERLINES"] = "每一行單位數"
L["OPT_UNITPERLINES_DESC"] = "設定每行最多顯示幾個 MUF。"
L["OPT_USERDEBUFF"] = "這項負面效果不是 Decursive 預設的效果之一"
L["OPT_XSPACING"] = "水平距離"
L["OPT_XSPACING_DESC"] = "設定 MUFs 之間的水平距離。"
L["OPT_YSPACING"] = "垂直距離"
L["OPT_YSPACING_DESC"] = "設定 MUFs 之間的垂直距離。"
L["OPTION_MENU"] = "Decursive 選項"
L["PLAY_SOUND"] = "有玩家需要淨化時發出音效"
L["POISON"] = "中毒"
L["POPULATE"] = "p"
L["POPULATE_LIST"] = "Decursive 名單快速添加介面"
L["PRINT_CHATFRAME"] = "在聊天視窗顯示訊息"
L["PRINT_CUSTOM"] = "在遊戲畫面中顯示訊息"
L["PRINT_ERRORS"] = "顯示錯誤訊息"
L["PRIORITY_LIST"] = "Decursive 優先名單"
L["PRIORITY_SHOW"] = "P"
L["RANDOM_ORDER"] = "隨機淨化玩家"
L["REVERSE_LIVELIST"] = "反向顯示即時清單"
L["SCAN_LENGTH"] = "即時檢測時間間隔(秒): "
L["SHIFT"] = "Shift"
L["SHOW_MSG"] = "要顯示 Decursive 視窗，請輸入 /dcrshow。"
L["SHOW_TOOLTIP"] = "在即時清單顯示簡要說明"
L["SKIP_LIST_STR"] = "Decursive 忽略名單"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "找到 %s 法術"
L["STEALTHED"] = "已潛行"
L["STR_CLOSE"] = "關閉"
L["STR_DCR_PRIO"] = "Decursive 優先選單"
L["STR_DCR_SKIP"] = "Decursive 忽略選單"
L["STR_GROUP"] = "隊伍 "
L["STR_OPTIONS"] = "Decursive 設定選項"
L["STR_OTHER"] = "其他"
L["STR_POP"] = "快速添加清單"
L["STR_QUICK_POP"] = "快速添加介面"
L["SUCCESSCAST"] = "|cFF22FFFF%s %s|r |cFF00AA00成功淨化|r %s"
L["TARGETUNIT"] = "選取目標"
L["TIE_LIVELIST"] = "即時清單顯示與 DCR 視窗連結"
L["TOC_VERSION_EXPIRED"] = [=[你的Decursive版本已經過期。當前魔獸世界版本比你的Decursive版本新。
你需要更新Decursive以修正潛在的錯誤。

前往curse.com搜索Decursive，或使用Curse's client軟體更新您所有的使用者外掛。

此訊息將每兩天提示一次。]=]
L["TOO_MANY_ERRORS_ALERT"] = [=[你的UI有太多LUA錯誤 (%d)。你的遊戲體驗正受到影響。關閉或更新產生錯誤的UI以關閉此訊息並重新取得正常的禎數。
你可開啟LUA錯誤報告來辨別產生錯誤的UI (/console scriptErrors 1)。]=]
L["TOOFAR"] = "太遠"
L["UNITSTATUS"] = "玩家狀態: "
L["UNSTABLERELEASE"] = "不穩定釋出版"

	elseif locale == "zhCN" then
L["ABOLISH_CHECK"] = "净化前检查“无效”减益"
L["ABOUT_AUTHOREMAIL"] = "作者 E-MAIL"
L["ABOUT_CREDITS"] = "贡献者"
L["ABOUT_LICENSE"] = "许可"
L["ABOUT_NOTES"] = "当单独、小队和团队时清除有害状态，并可使用高级过滤和优先等级系统。"
L["ABOUT_OFFICIALWEBSITE"] = "官方网站"
L["ABOUT_SHAREDLIBS"] = "共享库"
L["ABSENT"] = "不存在（%s）"
L["AFFLICTEDBY"] = "受%s影响"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "实时列表显示人数："
L["ANCHOR"] = "Decursive 文字锚点"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "显示或隐藏微单元框体"
L["BINDING_NAME_DCRPRADD"] = "将目标加入优先列表"
L["BINDING_NAME_DCRPRCLEAR"] = "清空优先列表"
L["BINDING_NAME_DCRPRLIST"] = "显示优先列表明细条目"
L["BINDING_NAME_DCRPRSHOW"] = "显示/隐藏优先列表"
L["BINDING_NAME_DCRSHOW"] = [=[显示或隐藏 Decursive 状态条
（实时列表锚点）]=]
L["BINDING_NAME_DCRSHOWOPTION"] = "显示选项设置面板"
L["BINDING_NAME_DCRSKADD"] = "将目标加入忽略列表"
L["BINDING_NAME_DCRSKCLEAR"] = "清空忽略列表"
L["BINDING_NAME_DCRSKLIST"] = "显示忽略列表明细条目"
L["BINDING_NAME_DCRSKSHOW"] = "显示/隐藏忽略列表"
L["BLACK_LENGTH"] = "黑名单持续时间："
L["BLACKLISTED"] = "黑名单"
L["CHARM"] = "魅惑"
L["CLASS_HUNTER"] = "猎人"
L["CLEAR_PRIO"] = "C"
L["CLEAR_SKIP"] = "C"
L["COLORALERT"] = "当“%s”需要时设置预警颜色。"
L["COLORCHRONOS"] = "中央计数器"
L["COLORCHRONOS_DESC"] = "设置中央计数器颜色"
L["COLORSTATUS"] = "设定“%s”时微单元框体的颜色。"
L["CTRL"] = "Ctrl"
L["CURE_PETS"] = "检测并净化宠物"
L["CURSE"] = "诅咒"
L["DEBUG_REPORT_HEADER"] = "|cFF11FF33请电邮此窗口的内容给 <%s>|r |cFF009999（使用 Ctrl+A 选择所有 Ctrl+C 复制文本到剪切板）|r 如果发现 %s 任何奇怪的行为也一并报告。"
L["DECURSIVE_DEBUG_REPORT"] = "**** |cFFFF0000Decursive 除错报告|r ****"
L["DECURSIVE_DEBUG_REPORT_BUT_NEW_VERSION"] = [=[|cFF11FF33Decursive 崩溃了但是别怕！新版本的 Decursive 已经被检测到了（%s）。只需简单更新。请到 curse.com 并查询“Decursive”'或使用 Curse 客户端，将自动更新全部插件。|r
|cFFFF1133别浪费时间在汇报臭虫上了，因为可能已被修复了。只需更新 Decursive 来摆脱这些问题！|r
|cFF11FF33谢谢阅读此消息！|r
]=]
L["DECURSIVE_DEBUG_REPORT_NOTIFY"] = [=[一个除错报告可用！
输入|cFFFF0000/DCRREPORT|r 查看]=]
L["DECURSIVE_DEBUG_REPORT_SHOW"] = "除错报告可用！"
L["DECURSIVE_DEBUG_REPORT_SHOW_DESC"] = "显示作者需要看到的除错报告…"
L["DEFAULT_MACROKEY"] = "`"
L["DEV_VERSION_ALERT"] = [=[您正在使用的是开发版本的 Decursive。

如果不想参加测试新功能与修复、得到游戏中的除错报告后发送问题给作者的话，请“不要使用此版本”并从 curse.com 和 wowace.com 下载最新的“稳定”版本。

这条消息只将在每次版本更新中显示一次]=]
L["DEV_VERSION_EXPIRED"] = [=[此开发版 Decursive 已过期。
请从 CURSE.COM 或 WOWACE.COM 下载最新的开发版或使用当前稳定版。
此提示每两天显示一次。]=]
L["DEWDROPISGONE"] = "没有等同于 Ace3 的 DewDrop。Alt+右键点击打开选项面板。"
L["DISABLEWARNING"] = [=[Decursive 已被禁用！

要重新启用，输入 |cFFFFAA44/DCR ENABLE|r]=]
L["DISEASE"] = "疾病"
L["DONOT_BL_PRIO"] = "不将优先列表中的玩家加入黑名单"
L["DONT_SHOOT_THE_MESSENGER"] = "Decursive 只是报告这些问题。所以，不要斩杀信使并解决实际问题。"
L["FAILEDCAST"] = [=[|cFF22FFFF%s %s|r |cFFAA0000未能施放于|r %s
|cFF00AAAA%s|r]=]
L["FOCUSUNIT"] = "焦点单位"
L["FUBARMENU"] = "FuBar 选项"
L["FUBARMENU_DESC"] = "对于 FuBar 图标设置选项"
L["GLOR1"] = "纪念 Glorfindal"
L["GLOR2"] = [=[Decursive 献给匆匆离我们而去的 Bertrand。
他将永远被我们所铭记。]=]
L["GLOR3"] = [=[纪念 Bertrand
1969 - 2007]=]
L["GLOR4"] = [=[对于那些在魔兽世界里遇见过 Glorfindal 的人来说，他是一个重承诺的男人，也是一个有超凡魅力的领袖。

友谊和慈爱将永植于他们的心中。他在游戏中就如同在他生活中一样的无私，彬彬有礼，乐于奉献，最重要的是他对生活充满热情。

他离开我们的时候才仅仅38岁，随他离去的绝不会是虚拟世界匿名的角色；在这里还有一群忠实的朋友在永远想念他。]=]
L["GLOR5"] = "他将永远被我们所铭记……"
L["HANDLEHELP"] = "拖动所有微单位框体"
L["HIDE_MAIN"] = "隐藏 Decursive 窗口"
L["HIDESHOW_BUTTONS"] = "显示/隐藏按钮和锁定/解锁“Decursive”条"
L["HLP_LEFTCLICK"] = "鼠标左键"
L["HLP_LL_ONCLICK_TEXT"] = [=[实时列表不代表能被点击。请先阅读此文档来学习如何使用此插件。在 WoWAce.com 网站搜索“Decursive”
（从 Decursive 计时条移除此列表，/dcrshow 命令并左Alt+点击移除）]=]
L["HLP_MIDDLECLICK"] = "鼠标中键"
L["HLP_MOUSE4"] = "鼠标按键4"
L["HLP_MOUSE5"] = "鼠标按键5"
L["HLP_NOTHINGTOCURE"] = "没有可处理的负面效果！"
L["HLP_RIGHTCLICK"] = "鼠标右键"
L["HLP_USEXBUTTONTOCURE"] = "用“%s”来净化这个负面效果！"
L["HLP_WRONGMBUTTON"] = "错误的鼠标按键！"
L["IGNORE_STEALTH"] = "忽略潜行的单位"
L["IS_HERE_MSG"] = "Decursive 已经初始化，请核对相关选项。（/decursive）"
L["LIST_ENTRY_ACTIONS"] = [=[|cFF33AA33[Ctrl]+点击|r：删除此玩家
|cFF33AA33点击|r：上移此玩家
|cFF33AA33右击|r：下移此玩家
|cFF33AA33[Shift]+点击|r：移动此玩家到顶端
|cFF33AA33[Shift]+右击|r：移动此玩家到底端]=]
L["MACROKEYALREADYMAPPED"] = [=[警告：Decursive 宏绑定按键[%s]先前绑定到“%s”。
当你设置別的宏按键后 Decursive 会恢复此按键原有的动作。]=]
L["MACROKEYMAPPINGFAILED"] = "按键[%s]不能绑定到 Decursive 宏！"
L["MACROKEYMAPPINGSUCCESS"] = "按键[%s]已成功绑定到 Decursive 宏。"
L["MACROKEYNOTMAPPED"] = "未绑定 Decursive 宏按键，你可以通过设置选项来设置该功能。"
L["MAGIC"] = "魔法"
L["MAGICCHARMED"] = "魔法魅惑"
L["MISSINGUNIT"] = "丢失单位"
L["NEW_VERSION_ALERT"] = [=[检测到 Decursive 新版本：|cFFEE7722%q|r 发布于|cFFEE7722%s|r！


到 |cFFFF0000WoWAce.com|r 下载！
--------]=]
L["NORMAL"] = "一般"
L["NOSPELL"] = "没有相关技能"
L["OPT_ABOLISHCHECK_DESC"] = "设置是否显示和净化带有“驱毒术”增益效果的玩家"
L["OPT_ABOUT"] = "关于"
L["OPT_ADD_A_CUSTOM_SPELL"] = "添加一个自定义法术/物品"
L["OPT_ADD_A_CUSTOM_SPELL_DESC"] = "拖动一个法术或可用物品到这里。也可以直接写它们的名称或数字 ID，或者使用Shift+点击。"
L["OPT_ADDDEBUFF"] = "新增自定义减益"
L["OPT_ADDDEBUFF_DESC"] = "向列表中新增一个减益。"
L["OPT_ADDDEBUFF_USAGE"] = "<减益名称>"
L["OPT_ADDDEBUFFFHIST"] = "新增一个最近受到的减益"
L["OPT_ADDDEBUFFFHIST_DESC"] = "从历史记录中新增一个减益"
L["OPT_ADVDISP"] = "高级显示选项"
L["OPT_ADVDISP_DESC"] = "允许分别设置面板和边框的透明度，以及微单元框体的间距。"
L["OPT_AFFLICTEDBYSKIPPED"] = "%s受到%s的影响，但将被忽略。"
L["OPT_ALLOWMACROEDIT"] = "允许使用宏编辑"
L["OPT_ALLOWMACROEDIT_DESC"] = "启用此项以防止 Decursive 更新宏，让你自己编辑你所需的宏。"
L["OPT_ALWAYSIGNORE"] = "不在战斗状态时也忽略"
L["OPT_ALWAYSIGNORE_DESC"] = "选中后不在状态时此减益也会被忽略。"
L["OPT_AMOUNT_AFFLIC_DESC"] = "设置实时列表显示的最大玩家数目"
L["OPT_ANCHOR_DESC"] = "显示自定义信息框体锚点"
L["OPT_AUTOHIDEMFS"] = "隐藏微单元框体："
L["OPT_AUTOHIDEMFS_DESC"] = "选择何时自动隐藏微单元框体。"
L["OPT_BLACKLENTGH_DESC"] = "设置被暂时加入黑名单的玩家在名单中停留的时间"
L["OPT_BORDERTRANSP"] = "边框透明度"
L["OPT_BORDERTRANSP_DESC"] = "设置边框的透明度"
L["OPT_CENTERTEXT"] = "中央计数器："
L["OPT_CENTERTEXT_DESC"] = [=[显示每个微单元中央最上面（根据你的优先级）受影响信息。

其中之一：
- 剩余时间直到结束
- 过去时间所受到影响的次数
- 堆叠次数]=]
L["OPT_CENTERTEXT_DISABLED"] = "已禁用"
L["OPT_CENTERTEXT_ELAPSED"] = "已用时间"
L["OPT_CENTERTEXT_STACKS"] = "层数"
L["OPT_CENTERTEXT_TIMELEFT"] = "剩余时间"
L["OPT_CENTERTRANSP"] = "面板透明度"
L["OPT_CENTERTRANSP_DESC"] = "设置面板的透明度"
L["OPT_CHARMEDCHECK_DESC"] = "选中后你将可以查看和处理被诱惑的玩家"
L["OPT_CHATFRAME_DESC"] = "Decursive 提示信息将显示在默认聊天框体中"
L["OPT_CHECKOTHERPLAYERS"] = "检查其他玩家"
L["OPT_CHECKOTHERPLAYERS_DESC"] = "显示当前小队或团队玩家 Decursive 版本（不能显示 Decursive 2.4.6之前的版本）。"
L["OPT_CMD_DISBLED"] = "已禁用"
L["OPT_CMD_ENABLED"] = "已启用"
L["OPT_CREATE_VIRTUAL_DEBUFF"] = "创建一个虚拟的测试用减益"
L["OPT_CREATE_VIRTUAL_DEBUFF_DESC"] = "让你看看出现减益时的 Decursive 是什么样子。"
L["OPT_CURE_PRIORITY_NUM"] = "优先级 #%d"
L["OPT_CUREPETS_DESC"] = "宠物也会被检查和净化"
L["OPT_CURINGOPTIONS"] = "净化选项"
L["OPT_CURINGOPTIONS_DESC"] = "净化选项包含更改每个负面类型的的优先级"
L["OPT_CURINGOPTIONS_EXPLANATION"] = [=[选择你想要治疗的伤害类型，未经检查的类型将被 Decursive 完全忽略。

绿色数字确定优先的伤害。这一优先事项将影响几方面：

- 如果一个玩家获得许多类型的减益效果，Decursive 将优先显示。

- 每个伤害类型会有颜色和绑定。

（如要更改顺序，反选所有类型并再次检查所需顺序）]=]
L["OPT_CURINGORDEROPTIONS"] = "净化类型和优先级"
L["OPT_CURSECHECK_DESC"] = "选中后你将可以查看和净化受到诅咒效果影响的单位"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING"] = "允许编辑以上法术内部宏"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING_DESC"] = [=[勾选此项如想编辑内置宏 Decursive 将使用自定义法术。

注意：检查此项允许 Decursive 管理修改法术。

如果一个法术已经在列表之中了需要先移除它之后再进行宏编辑。

（---只限高级用户---）]=]
L["OPT_CUSTOM_SPELL_CURE_TYPES"] = "伤害类型"
L["OPT_CUSTOM_SPELL_IS_DEFAULT"] = "这个法术是 Decursive 自动配置的一部分。如果这个法术不再正常工作，可以删除或禁用它恢复预设 Decursive 行为。"
L["OPT_CUSTOM_SPELL_ISPET"] = "宠物技能"
L["OPT_CUSTOM_SPELL_ISPET_DESC"] = "如果检测到这是一个属于宠物的技能，Decursive 可以检测并施放它。"
L["OPT_CUSTOM_SPELL_MACRO_MISSING_NOMINAL_SPELL"] = "提示：法术%q没有出现在宏之中，范围和冷却信息将不会匹配……"
L["OPT_CUSTOM_SPELL_MACRO_MISSING_UNITID_KEYWORD"] = "UNITID 键值缺失。"
L["OPT_CUSTOM_SPELL_MACRO_TEXT"] = "宏文本："
L["OPT_CUSTOM_SPELL_MACRO_TEXT_DESC"] = [=[编辑预设的宏文本。
|cFFFF0000只有2限制：|r

- 必须指定目标使用 UNITID 键值，将自动由每个微单元框体的单位 ID 取代。

- 可能不会改变宏使用的法术，另外 Decursive 将无法追踪其冷却时间或范围状态。
（记住，如果你打算使用条件不同的法术）]=]
L["OPT_CUSTOM_SPELL_MACRO_TOO_LONG"] = "宏过长，需要移除%d字符。"
L["OPT_CUSTOM_SPELL_PRIORITY"] = "法术优先级"
L["OPT_CUSTOM_SPELL_PRIORITY_DESC"] = [=[当有多个法术可以治疗相同类型的伤害，将选择优先级高的。

请注意，Decursive 所管理的默认技能有优先级，取值范围从0到9。

因此，如果您给您的自定义法术过低的优先级，它只会选择默认的技能。]=]
L["OPT_CUSTOM_SPELL_UNAVAILABLE"] = "不可用"
L["OPT_CUSTOM_SPELL_UNIT_FILTER"] = "单位过滤中"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_DESC"] = "选择可受益于此法术的单位"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_NONE"] = "全部单位"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_NONPLAYER"] = "只限其它"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_PLAYER"] = "只限玩家"
L["OPT_CUSTOMSPELLS"] = "自定义法术/物品"
L["OPT_CUSTOMSPELLS_DESC"] = [=[这里添加法术扩展 Decursive 的自动配置。
自定义法术永远拥有更高的优先级并覆盖和替换默认法术（当且仅当你的角色可以使用这些法术）。
]=]
L["OPT_CUSTOMSPELLS_EFFECTIVE_ASSIGNMENTS"] = "有效法术分配："
L["OPT_DEBCHECKEDBYDEF"] = [=[

默认被选中]=]
L["OPT_DEBUFFENTRY_DESC"] = "选择在战斗中哪些受到此减益影响的职业将被忽略"
L["OPT_DEBUFFFILTER"] = "减益过滤"
L["OPT_DEBUFFFILTER_DESC"] = "根据名称和职业选择在战斗中要过滤掉的减益"
L["OPT_DELETE_A_CUSTOM_SPELL"] = "移除"
L["OPT_DISABLEABOLISH"] = "不使用“无效”减益技能"
L["OPT_DISABLEABOLISH_DESC"] = "如启用，Decursive 将为“无效”减益选择使用“净化疾病”和“净化中毒”。"
L["OPT_DISABLEMACROCREATION"] = "禁止创建宏"
L["OPT_DISABLEMACROCREATION_DESC"] = "Decursive 宏将不再创建和保留"
L["OPT_DISEASECHECK_DESC"] = "选中后你将可以查看和净化受到疾病效果影响的单位"
L["OPT_DISPLAYOPTIONS"] = "显示选项"
L["OPT_DONOTBLPRIO_DESC"] = "优先列表中的玩家不会被加入黑名单"
L["OPT_ENABLE_A_CUSTOM_SPELL"] = "启用"
L["OPT_ENABLE_LIVELIST"] = "启用实时列表"
L["OPT_ENABLE_LIVELIST_DESC"] = [=[显示受影响玩家的信息列表。

可以通过 Decursive 条移动此列表Y（输入 /DCRSHOW 显示此条）。]=]
L["OPT_ENABLEDEBUG"] = "启用除错"
L["OPT_ENABLEDEBUG_DESC"] = "启用除错输出"
L["OPT_ENABLEDECURSIVE"] = "启用 Decursive"
L["OPT_FILTEROUTCLASSES_FOR_X"] = "在战斗中指定的职业%q将被忽略。"
L["OPT_GENERAL"] = "一般选项"
L["OPT_GROWDIRECTION"] = "反向显示微单元框体"
L["OPT_GROWDIRECTION_DESC"] = "微单元框体将从下向上显示"
L["OPT_HIDEMFS_GROUP"] = "单人或小队"
L["OPT_HIDEMFS_GROUP_DESC"] = "不在团队中时隐藏微单元框体"
L["OPT_HIDEMFS_NEVER"] = "从不自动隐藏"
L["OPT_HIDEMFS_NEVER_DESC"] = "从不隐藏微单元框体窗口。"
L["OPT_HIDEMFS_SOLO"] = "单人"
L["OPT_HIDEMFS_SOLO_DESC"] = "在没有组队或者团队时隐藏微单元框体。"
L["OPT_HIDEMUFSHANDLE"] = "隐藏微单元框体表头"
L["OPT_HIDEMUFSHANDLE_DESC"] = [=[隐藏微单元框体表头并禁止移动。
使用同样命令还原。]=]
L["OPT_IGNORESTEALTHED_DESC"] = "处于潜行状态的单位会被忽略。"
L["OPT_INPUT_SPELL_BAD_INPUT_ALREADY_HERE"] = "法术已在列表中！"
L["OPT_INPUT_SPELL_BAD_INPUT_DEFAULT_SPELL"] = "Decursive 已经包含此法术。Shift+点击此法术或输入它的 ID 添加一个特殊等级。"
L["OPT_INPUT_SPELL_BAD_INPUT_ID"] = "法术 ID 不可用！"
L["OPT_INPUT_SPELL_BAD_INPUT_NOT_SPELL"] = "不能在技能书中找到法术！"
L["OPT_LIVELIST"] = "实时列表"
L["OPT_LIVELIST_DESC"] = [=[这是显示在 Decursive 条下面受影响目标的相关设置列表。

要移动这个列表，你需要移动小型 Decursive 框体。下面有些设置只有在框体显示时可用，你可以通过在聊天窗口里输入 |cff20CC20/DCRSHOW|r 来显示它。

一旦你设定好了实时列表的位置、缩放及透明度，你可以通过输入 |cff20CC20/DCRHIDE|r 来安全地隐藏 Decursive 框体。]=]
L["OPT_LLALPHA"] = "实时列表透明度"
L["OPT_LLALPHA_DESC"] = "改变 Decursive 状态条面和实时列表的透明度（状态条必须可见）"
L["OPT_LLSCALE"] = "实时列表缩放"
L["OPT_LLSCALE_DESC"] = "设置状态条以及其实时列表的大小（状态条必须显示）"
L["OPT_LVONLYINRANGE"] = "只显示法术有效范围内的目标"
L["OPT_LVONLYINRANGE_DESC"] = "实时列表将只显示法术有效范围内的目标,超出范围的目标将被忽略"
L["OPT_MACROBIND"] = "设置宏绑定按键"
L["OPT_MACROBIND_DESC"] = [=[Decursive 宏的按键。

按你想設定的按键后按 'Enter' 键保存设置(鼠标需要移动到编辑区域之外)]=]
L["OPT_MACROOPTIONS"] = "宏选项"
L["OPT_MACROOPTIONS_DESC"] = "有关 Decursive 创建“鼠标指向”宏的选项设置"
L["OPT_MAGICCHARMEDCHECK_DESC"] = "选中后你将可以查看和净化受到魔法诱惑效果影响的玩家"
L["OPT_MAGICCHECK_DESC"] = "选中后你将可以查看和净化受到不良魔法效果影响的玩家"
L["OPT_MAXMFS"] = "最大单位显示"
L["OPT_MAXMFS_DESC"] = "设置在屏幕上显示的微单元框体的个数"
L["OPT_MESSAGES"] = "信息"
L["OPT_MESSAGES_DESC"] = "提示信息显示选项"
L["OPT_MFALPHA"] = "透明度"
L["OPT_MFALPHA_DESC"] = "定义玩家没有受到减益影响时微单元框体的透明度"
L["OPT_MFPERFOPT"] = "性能选项"
L["OPT_MFREFRESHRATE"] = "刷新率"
L["OPT_MFREFRESHRATE_DESC"] = "每两次刷新之间的时间间隔（一次可以刷新一个或多个微单元框体）"
L["OPT_MFREFRESHSPEED"] = "刷新速度"
L["OPT_MFREFRESHSPEED_DESC"] = "设置每次刷新多少个微单元框体"
L["OPT_MFSCALE"] = "微单元框体缩放"
L["OPT_MFSCALE_DESC"] = "设置微单元框体的大小"
L["OPT_MFSETTINGS"] = "微单元框体选项"
L["OPT_MFSETTINGS_DESC"] = "设置各种微单元框体负面类型优先相关的显示选项"
L["OPT_MUFFOCUSBUTTON"] = "焦点按钮："
L["OPT_MUFHANDLE_HINT"] = "移动微单元框体：在第一个微单元框体之上 Alt+点击不可见表头。"
L["OPT_MUFMOUSEBUTTONS"] = "鼠标绑定"
L["OPT_MUFMOUSEBUTTONS_DESC"] = [=[更改净化使用的绑定，通过目标或者焦点微单元框体。

每个优先级代表着不同的特定伤害类型位于“|cFFFF5533净化选项|r”面板。

每个伤害类型所使用的法术为默认配置并可以在“|cFF00DDDD自定义法术|r”面板更改。 ]=]
L["OPT_MUFSCOLORS"] = "颜色"
L["OPT_MUFSCOLORS_DESC"] = [=[更改每个微单元框体状态负面类型优先相关的颜色选项。

在特定的“|cFFFF5533净化选项|r”面板每个优先级代表着不同的负面类型。]=]
L["OPT_MUFSVERTICALDISPLAY"] = "垂直显示"
L["OPT_MUFSVERTICALDISPLAY_DESC"] = "微单元框体窗体将垂直增长"
L["OPT_MUFTARGETBUTTON"] = "目标按钮："
L["OPT_NEWVERSIONBUGMENOT"] = "新版本提示"
L["OPT_NEWVERSIONBUGMENOT_DESC"] = "如过检测到 Decursive 新的版本，每七天会显示一个弹出提示。"
L["OPT_NOKEYWARN"] = "当没有按键时发出警报"
L["OPT_NOKEYWARN_DESC"] = "当没有映射案件时发出警报。"
L["OPT_NOSTARTMESSAGES"] = "禁用欢迎信息"
L["OPT_NOSTARTMESSAGES_DESC"] = "移除每次登陆时在聊天框体显示的两个 Decursive 信息。"
L["OPT_OPTIONS_DISABLED_WHILE_IN_COMBAT"] = "此选项战斗中被禁用。"
L["OPT_PERFOPTIONWARNING"] = "警告：不要更改这些值，除非你确切知道你在做什么。这些设置可以对游戏性能影响很大。大多数用户应当使用0.1和10的默认值。"
L["OPT_PLAYSOUND_DESC"] = "有玩家受到减益时播放音效"
L["OPT_POISONCHECK_DESC"] = "选中后你将可以查看和净化受到中毒效果影响的单位"
L["OPT_PRINT_CUSTOM_DESC"] = "Decursive 提示信息将显示在自定义聊天框体"
L["OPT_PRINT_ERRORS_DESC"] = "错误信息将被显示"
L["OPT_PROFILERESET"] = "重置配置文件…"
L["OPT_RANDOMORDER_DESC"] = "随机显示和净化单位（不推荐使用）"
L["OPT_READDDEFAULTSD"] = "重新加入默认减益"
L["OPT_READDDEFAULTSD_DESC1"] = [=[向列表中加入所有缺失的 Decursive 默认减益
你的设置不会更改]=]
L["OPT_READDDEFAULTSD_DESC2"] = "所有 Decursive 默认减益都已加入列表"
L["OPT_REMOVESKDEBCONF"] = [=[你确定要将
“%s”
从 Decursive 减益忽略列表中删除吗？]=]
L["OPT_REMOVETHISDEBUFF"] = "删除此减益"
L["OPT_REMOVETHISDEBUFF_DESC"] = "从忽略列表中删除“%s”"
L["OPT_RESETDEBUFF"] = "重置此减益"
L["OPT_RESETDTDCRDEFAULT"] = "将“%s”重置 Decursive 默认"
L["OPT_RESETMUFMOUSEBUTTONS"] = "重置"
L["OPT_RESETMUFMOUSEBUTTONS_DESC"] = "重置鼠标按钮指派为默认。"
L["OPT_RESETOPTIONS"] = "恢复到默认选项"
L["OPT_RESETOPTIONS_DESC"] = "重置当前配置文件到默认值"
L["OPT_RESTPROFILECONF"] = [=[你确定要重置配置文件
“(%s) %s”
为默认选项？]=]
L["OPT_REVERSE_LIVELIST_DESC"] = "实时列表将从下往上显示"
L["OPT_SCANLENGTH_DESC"] = "设置实时检测的时间间隔"
L["OPT_SHOW_STEALTH_STATUS"] = "显示潜行状态"
L["OPT_SHOW_STEALTH_STATUS_DESC"] = "当玩家潜行时，他的微单位框体将有一个特殊的颜色"
L["OPT_SHOWBORDER"] = "显示职业彩色边框"
L["OPT_SHOWBORDER_DESC"] = "微单元框体边框将会显示出代表该单位职业的颜色"
L["OPT_SHOWHELP"] = "显示帮助"
L["OPT_SHOWHELP_DESC"] = "当鼠标移动到微单元框体上时显示信息提示窗口"
L["OPT_SHOWMFS"] = "在屏幕上显示微单元框体"
L["OPT_SHOWMFS_DESC"] = "如果要点击净化必须启用此项"
L["OPT_SHOWMINIMAPICON"] = "小地图图标"
L["OPT_SHOWMINIMAPICON_DESC"] = "切换小地图图标"
L["OPT_SHOWTOOLTIP_DESC"] = "在实时列表以及微单元框体上显示信息提示"
L["OPT_STICKTORIGHT"] = "将微单元框体向右对齐"
L["OPT_STICKTORIGHT_DESC"] = "这个选项将会使微单元框体向右对齐。"
L["OPT_TESTLAYOUT"] = "测试布局"
L["OPT_TESTLAYOUT_DESC"] = [=[新建测试单位以测试显示布局。
（点击后稍等片刻）]=]
L["OPT_TESTLAYOUTUNUM"] = "单位数字"
L["OPT_TESTLAYOUTUNUM_DESC"] = "设置新建测试单位数字。"
L["OPT_TIE_LIVELIST_DESC"] = "实时列表将和 Decursive 状态条一起显示。"
L["OPT_TIECENTERANDBORDER"] = "绑定面板和边框的透明度"
L["OPT_TIECENTERANDBORDER_OPT"] = "选中时边框的透明度为面板的一半"
L["OPT_TIEXYSPACING"] = "绑定水平和垂直间距"
L["OPT_TIEXYSPACING_DESC"] = "微单元框体之间的水平和垂直间距相同。"
L["OPT_UNITPERLINES"] = "每行单位数"
L["OPT_UNITPERLINES_DESC"] = "设置每行最多可显示微单元框体的个数。"
L["OPT_USERDEBUFF"] = "该减益不是 Decursive 默认的减益之一"
L["OPT_XSPACING"] = "水平间距"
L["OPT_XSPACING_DESC"] = "设置微单元框体间的水平距离"
L["OPT_YSPACING"] = "垂直间距"
L["OPT_YSPACING_DESC"] = "设置微单元框体间的垂直距离"
L["OPTION_MENU"] = "Decursive 选项菜单"
L["PLAY_SOUND"] = "有玩家需要净化时播放音效"
L["POISON"] = "中毒"
L["POPULATE"] = "p"
L["POPULATE_LIST"] = "Decursive 列表快速添加器"
L["PRINT_CHATFRAME"] = "在默认聊天窗口显示信息"
L["PRINT_CUSTOM"] = "在游戏画面显示信息"
L["PRINT_ERRORS"] = "显示错误信息"
L["PRIORITY_LIST"] = "Decursive 优先列表"
L["PRIORITY_SHOW"] = "P"
L["RANDOM_ORDER"] = "随机净化"
L["REVERSE_LIVELIST"] = "反向显示实时列表"
L["SCAN_LENGTH"] = "实时检测时间间隔（秒）："
L["SHIFT"] = "Shift"
L["SHOW_MSG"] = "如需显示 Decursive 框体，请输入 /dcrshow"
L["SHOW_TOOLTIP"] = "在减益单位显示提示"
L["SKIP_LIST_STR"] = "Decursive 忽略列表"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "找到%s法术！"
L["STEALTHED"] = "已潜行"
L["STR_CLOSE"] = "关闭"
L["STR_DCR_PRIO"] = "Decursive 优先"
L["STR_DCR_SKIP"] = "Decursive 忽略"
L["STR_GROUP"] = "小队"
L["STR_OPTIONS"] = "Decursive 选项"
L["STR_OTHER"] = "其它"
L["STR_POP"] = "快速添加列表"
L["STR_QUICK_POP"] = "快速添加器"
L["SUCCESSCAST"] = "|cFF22FFFF%s %s|r |cFF00AA00成功施放于|r %s"
L["TARGETUNIT"] = "目标单位"
L["TIE_LIVELIST"] = "根据 Decursive 窗口是否可见实时列表"
L["TOC_VERSION_EXPIRED"] = [=[Decursive 版本已过期。此版本的 Decursive 是在当前魔兽世界版本之前发布的。
需要更新 Decursive 来解决潜在的不兼容和运行时错误。

到 curse.com 搜寻“Decursive”或使用 Curse 客户端立刻更新你的全部插件。

此消息2天内会重复显示。]=]
L["TOO_MANY_ERRORS_ALERT"] = [=[你的用户界面（%d）有太多的 Lua 错误。当前游戏体验被弱化。禁用或者更新失效的插件关闭信息并重新获得适当的帧数频率。
如果想打开 Lua 错误报告（/console scriptErrors 1）来找出可能出问题的插件。]=]
L["TOOFAR"] = "太远"
L["UNITSTATUS"] = "单位状态："
L["UNSTABLERELEASE"] = "不稳定版本"

	elseif locale == "ruRU" then
L["ABOLISH_CHECK"] = "Проверять на наличие \"Лечащего заклинания\" яда/болезни перед лечением"
L["ABOUT_AUTHOREMAIL"] = "E-mail автора"
L["ABOUT_CREDITS"] = "РАЗРАБОТЧИКИ"
L["ABOUT_LICENSE"] = "ПРАВА"
L["ABOUT_NOTES"] = "Отображение и инструменты для развеивания дебаффов для одиночной игры, игры в группе и рейде, с развитой системой фильтрации и приоритетов."
L["ABOUT_OFFICIALWEBSITE"] = "ОФИЦИАЛЬНЫЙ САЙТ"
L["ABOUT_SHAREDLIBS"] = "ОБЩИЕ БИБЛИОТЕКИ"
L["ABSENT"] = "Отсутствует (%s)"
L["AFFLICTEDBY"] = "%s заражен"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "Количество отображаемых заражений : "
L["ANCHOR"] = "Якорь окна сообщений Decursive"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "Показать или скрыть микро-фреймы игроков"
L["BINDING_NAME_DCRPRADD"] = "Добавить цель в список приоритетов"
L["BINDING_NAME_DCRPRCLEAR"] = "Очистить список приоритетов"
L["BINDING_NAME_DCRPRLIST"] = "Вывести список приоритетов"
L["BINDING_NAME_DCRPRSHOW"] = "Показать или скрыть список приоритета"
L["BINDING_NAME_DCRSHOW"] = [=[Показать/скрыть главную панель Decursive
(якорь активного списка)]=]
L["BINDING_NAME_DCRSHOWOPTION"] = "Отображать опции панели"
L["BINDING_NAME_DCRSKADD"] = "Добавить цель в список пропусков"
L["BINDING_NAME_DCRSKCLEAR"] = "Очистить список пропусков"
L["BINDING_NAME_DCRSKLIST"] = "Распечатка списка пропусков"
L["BINDING_NAME_DCRSKSHOW"] = "Показать или скрыть список пропусков"
L["BLACK_LENGTH"] = "Секунд в чёрном списке : "
L["BLACKLISTED"] = "В чёрном списке"
L["CHARM"] = "Подчинение"
L["CLASS_HUNTER"] = "Охотник"
L["CLEAR_PRIO"] = "О"
L["CLEAR_SKIP"] = "О"
L["COLORALERT"] = "Установить предупреждающий цвет, когда требуется '%s'."
L["COLORCHRONOS"] = "Центральный счётчик"
L["COLORCHRONOS_DESC"] = "Установить цвет центрального счётчика"
L["COLORSTATUS"] = "Установить цвет для статуса МФИ: '%s'."
L["CTRL"] = "Ctrl"
L["CURE_PETS"] = "Скан и лечение питомцев"
L["CURSE"] = "Проклятие"
L["DEBUG_REPORT_HEADER"] = [=[|cFF11FF33Пожайлуйста, отправьте содержимое этого окна по адресу <%s>|r
|cFF009999(Нажмите CTRL+A, чтобы выделить всё содержимое, а затем CTRL+C, чтобы переместить его в буфер обмена)|r
В своём отчёте также сообщите о неполадках в работе %s, если таковые имеются.]=]
L["DECURSIVE_DEBUG_REPORT"] = "**** |cFFFF0000Отчёт об отладке Decursive|r ****"
L["DECURSIVE_DEBUG_REPORT_NOTIFY"] = [=[Отчёт об отладке доступен!
Введите |cFFFF0000/DCRREPORT|r, чтобы увидеть его.]=]
L["DECURSIVE_DEBUG_REPORT_SHOW"] = "Отчёт об отладке доступен!"
L["DECURSIVE_DEBUG_REPORT_SHOW_DESC"] = "Показать отчет о поиске ошибок, который необходимо представить автору..."
L["DEFAULT_MACROKEY"] = "NONE"
L["DEV_VERSION_ALERT"] = [=[Вы используете тестовую версию Decursive.

Если вы не желаете участвовать в тестировании новых функций и исправлении ошибок, получать внутриигровые отчеты об ошибках, посылать отчеты автору, тогда НЕ ИСПОЛЬЗУЙТЕ ЭТУ ВЕРСИЮ и скачайте последнюю СТАБИЛЬНУЮ версию с curse.com или wowace.com.

Это сообщение будет отображаться каждый раз при установке каждой новой тестовой версии.]=]
L["DEV_VERSION_EXPIRED"] = [=[Эта тестовая версия Decursive устарела.
Пожалуйста, скачайте последнюю тестовую версию или используйте текущую стабильную версию с CURSE.COM или WOWACE.COM.

Спасибо :-)]=]
L["DEWDROPISGONE"] = "Для Ace3 не существует эквивалента DewDrop. Alt+Правый щелчок, чтобы открыть настройки."
L["DISABLEWARNING"] = [=[Decursive отключен!

Чтобы включить его снова, введите |cFFFFAA44/DCR ENABLE|r]=]
L["DISEASE"] = "Болезни"
L["DONOT_BL_PRIO"] = "Не вносить в чёрный список имена из списка приоритетов"
L["DONT_SHOOT_THE_MESSENGER"] = "Decursive просто сообщает о проблеме. Так, что не убивайте гонца и сообщите о актуальной ошибке."
L["FAILEDCAST"] = [=[|cFF22FFFF%s %s|r |cFFAA0000неудачно на|r %s
|cFF00AAAA%s|r]=]
L["FOCUSUNIT"] = "Фокус"
L["FUBARMENU"] = "Меню FuBarа"
L["FUBARMENU_DESC"] = "Настройка иконки FuBarа"
L["GLOR1"] = "В память о Glorfindal'е"
L["GLOR2"] = [=[Decursive посвящён памяти о Бертране, который оставил нас слишком рано.
Его всегда будут помнить.]=]
L["GLOR3"] = [=[В память о Bertrand Sense
1969 - 2007]=]
L["GLOR4"] = [=[Дружба и привязанность могут пустить свои корни где угодно. Те, кто встретился с Glorfindal в World of Warcraft, знали его как человека с великими обязательствами, и харизматического лидера.

В жизни он был таким же, как и в игре: самоотверженным, щедрым, преданным своим друзьям и, прежде всего всего, страстным человеком.

Он оставил нас в возрасте 38 лет, оставив не только игроков в виртуальном мире, но и группу истинных друзей, которые будут тосковать без него всегда.]=]
L["GLOR5"] = "Его всегда будут помнить..."
L["HANDLEHELP"] = "Тащить все микро-фреймы игроков (МФИ)"
L["HIDE_MAIN"] = "Скрыть окно Decursive"
L["HIDESHOW_BUTTONS"] = "Скрыть/Показать кнопки"
L["HLP_LEFTCLICK"] = "Левый клик"
L["HLP_LL_ONCLICK_TEXT"] = [=[Щелканье по активному списку является бесполезным после WoW 2.0. Вы должны прочитать файл "Readme.txt", находящийся в папке Decursive...
(Для перемещения этого списка переместите панель Decursive, /dcrshow и alt+клик левой кнопкой для изменения положения)]=]
L["HLP_MIDDLECLICK"] = "Центральный клик"
L["HLP_NOTHINGTOCURE"] = "Нечего лечить!"
L["HLP_RIGHTCLICK"] = "Правый клик"
L["HLP_USEXBUTTONTOCURE"] = "Используйте \"%s\" для излечения данного заражения!"
L["HLP_WRONGMBUTTON"] = "Неверная кнопка мыши!"
L["IGNORE_STEALTH"] = "Игнорировать невидимых игроков"
L["IS_HERE_MSG"] = "Decursive инициализирован, не забудьте проверить настройки"
L["LIST_ENTRY_ACTIONS"] = [=[|cFF33AA33[CTRL]|r клик: Удалить данного игрока
|cFF33AA33ЛЕВЫЙ|r клик: Повысить данного игрока
|cFF33AA33ПРАВЫЙ|r клик:Понизить данного игрока
|cFF33AA33[SHIFT]ЛЕВЫЙ|r клик: Поместить данного игрока вверх
|cFF33AA33[SHIFT]ПРАВЫЙ|r клик: Поместить данного игрока вниз]=]
L["MACROKEYALREADYMAPPED"] = [=[ПРЕДУПРЕЖДЕНИЕ: Клавиша, назначенная для макроса Decursive [%s], уже назначена на '%s'.
Decursive восстановит предыдущее назначение, если вы назначите другую клавишу для этого макроса.]=]
L["MACROKEYMAPPINGFAILED"] = "Клавиша [%s] не может быть назначена для макроса Decursive!"
L["MACROKEYMAPPINGSUCCESS"] = "Клавиша [%s] успешно назначена для макроса Decursive."
L["MACROKEYNOTMAPPED"] = "Макросу Decursive не назначена клавиша, проверьте настройки макросов!"
L["MAGIC"] = "Магия"
L["MAGICCHARMED"] = "Магическое очарования"
L["MISSINGUNIT"] = "Потеря игрока"
L["NEW_VERSION_ALERT"] = [=[Обнаружена новая версия Decursive: |cFFEE7722%q|r выпуск |cFFEE7722%s|r!


скачайте с сайта |cFFFF0000WoWAce.com|r!
--------]=]
L["NORMAL"] = "Нормальное"
L["NOSPELL"] = "Нет доступных заклинаний"
L["OPT_ABOLISHCHECK_DESC"] = "выберите, отображать ли игроков с активным на них заклинанием 'Устранение', делая их доступными для лечения"
L["OPT_ABOUT"] = "О проекте"
L["OPT_ADD_A_CUSTOM_SPELL"] = "Добавить пользовательское заклинание"
L["OPT_ADD_A_CUSTOM_SPELL_DESC"] = "Щелкните тут и щелкните с Shift по заклинанию в своей книге заклинаний. Вы также можете прямо написать название или номер ID заклинания."
L["OPT_ADDDEBUFF"] = "Добавить недуг"
L["OPT_ADDDEBUFF_DESC"] = "Добавить новый недуг в данный список"
L["OPT_ADDDEBUFF_USAGE"] = "<Название недуга>"
L["OPT_ADDDEBUFFFHIST"] = "Добавить недавнее заражение"
L["OPT_ADDDEBUFFFHIST_DESC"] = "Добавить заражение, используя историю"
L["OPT_ADVDISP"] = "Доп. настройки отображения"
L["OPT_ADVDISP_DESC"] = "Позволяет установить прозрачность краёв и центра раздельно, а также установить расстояние между МФИ"
L["OPT_AFFLICTEDBYSKIPPED"] = "%s пораженный %s будет пропущен"
L["OPT_ALLOWMACROEDIT"] = "Разрешить редактирование макроса"
L["OPT_ALLOWMACROEDIT_DESC"] = "Включить для предотвращения изменения макроса аддоном, оставить изменения на усмотрение пользователя"
L["OPT_ALWAYSIGNORE"] = "Также игнорировать вне боя"
L["OPT_ALWAYSIGNORE_DESC"] = "Если отмечено, данный недуг будет также игнорироваться, когда вы находитесь вне боя"
L["OPT_AMOUNT_AFFLIC_DESC"] = "Установить максимальное количество отображаемых в активном списке заражений"
L["OPT_ANCHOR_DESC"] = "Отображать указатель пользовательского фрейма ошибок"
L["OPT_AUTOHIDEMFS"] = "Автоскрытие"
L["OPT_AUTOHIDEMFS_DESC"] = "Выберите, когда автоматически скрывать микро-фреймы."
L["OPT_BLACKLENTGH_DESC"] = "Установить продолжительность нахождения кого-либо в чёрном списке"
L["OPT_BORDERTRANSP"] = "Прозрачность краёв"
L["OPT_BORDERTRANSP_DESC"] = "Установка прозрачности краёв"
L["OPT_CENTERTRANSP"] = "Прозрачность центра"
L["OPT_CENTERTRANSP_DESC"] = "Установка прозрачности центра"
L["OPT_CHARMEDCHECK_DESC"] = "Если отмечено, то вы сможете видеть и излечивать очарованных игроков"
L["OPT_CHATFRAME_DESC"] = "Сообщения Decursive будут выводиться в стандартное окно чата"
L["OPT_CHECKOTHERPLAYERS"] = "Проверить других игроков"
L["OPT_CHECKOTHERPLAYERS_DESC"] = "Отображать версию Decursive других игроков вашей группы или гильдии (отображает только версии Decursive свыше 2.4.6)."
L["OPT_CMD_DISBLED"] = "Отключен"
L["OPT_CMD_ENABLED"] = "Включен"
L["OPT_CREATE_VIRTUAL_DEBUFF"] = "Создать виртуальный тест заражения"
L["OPT_CREATE_VIRTUAL_DEBUFF_DESC"] = "Позволяет вам увидеть, как будет всё это выглядеть, когда будет обнаружено заражение"
L["OPT_CURE_PRIORITY_NUM"] = "Приоритет #%d"
L["OPT_CUREPETS_DESC"] = "Питомцы будут отображаться и излечиваться"
L["OPT_CURINGOPTIONS"] = "Настройки лечения"
L["OPT_CURINGOPTIONS_DESC"] = "Настроить различные аспекты процесса лечения"
L["OPT_CURINGOPTIONS_EXPLANATION"] = [=[Выберите типы колдовства, которые вы желаете развеивать, невыбранные типы будут игнорироваться Decursive.

Зеленый номер определяет приоритет колдовства. Этот приоритет будет влиять на несколько аспектов:
- Что Decursive показывает Вам в первую очередь, если на игрока наложено несколько типов дебаффов.
- Какую кнопку мыши Вы должны будете нажать, чтобы развеять дебафф (Первое заклинание развеивается Левым щелчком, второе Правым, и т.д...)

Все это описано в документации (необходимо прочесть):
http://www.wowace.com/addons/decursive/]=]
L["OPT_CURINGORDEROPTIONS"] = "Настройки порядка лечения"
L["OPT_CURSECHECK_DESC"] = "Если отмечено, то вы сможете видеть и излечивать проклятых игроков"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING"] = "Разрешить изменение макросов (только для опытных пользователей)"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING_DESC"] = [=[Отметить, если хотите редактировать внутренний макрос Decursive для вашего заклинания.

Заметка: Включение разрешит вам модифицировать заклинания управляемые Decursive .
(--- Только для опытных пользователей ---)]=]
L["OPT_CUSTOM_SPELL_CURE_TYPES"] = "Типы недугов"
L["OPT_CUSTOM_SPELL_IS_DEFAULT"] = "Это заклинания часть автоматической настройки Decursive. Если это заклинание больше не работает правильно, вы можете удалить или отключить его для восстановления настроек по умолчанию."
L["OPT_CUSTOM_SPELL_MACRO_MISSING_NOMINAL_SPELL"] = "ВНИМАНИЕ: Заклинание %q не используется в вашем макросе, информация о дистанции и времени перезарядки может не совпадать..."
L["OPT_CUSTOM_SPELL_MACRO_MISSING_UNITID_KEYWORD"] = "Ключевое слово UNITID отсутствует"
L["OPT_CUSTOM_SPELL_MACRO_TEXT"] = "Текст макроса:"
L["OPT_CUSTOM_SPELL_MACRO_TOO_LONG"] = "Ваш макрос слишком длинный, необходимо удалить %d символов."
L["OPT_CUSTOM_SPELL_PRIORITY"] = "Приоритеты заклинаний"
L["OPT_CUSTOM_SPELL_PRIORITY_DESC"] = "Когда несколько заклинаний могут вылечить те же типы недугов, какое из них будет с более высоким приоритетом тому и будет отдаваться предпочтение."
L["OPT_CUSTOM_SPELL_UNAVAILABLE"] = "недоступно"
L["OPT_CUSTOMSPELLS"] = "Пользовательские заклинания"
L["OPT_CUSTOMSPELLS_DESC"] = "Здесь Вы можете добавлять заклинания для расширения автоматического конфигурирования Decursive"
L["OPT_CUSTOMSPELLS_EFFECTIVE_ASSIGNMENTS"] = "Эффективные задания заклинаний:"
L["OPT_DEBCHECKEDBYDEF"] = [=[
Назначен на стандарт]=]
L["OPT_DEBUFFENTRY_DESC"] = "Выберите класс, который будет игнорироваться в бою при поражении данным недугом"
L["OPT_DEBUFFFILTER"] = "Фильтрование недугов"
L["OPT_DEBUFFFILTER_DESC"] = "Выберите недуги для фильтрации по имени и классу, когда вы находитесь в бою"
L["OPT_DELETE_A_CUSTOM_SPELL"] = "Убрать"
L["OPT_DISABLEABOLISH"] = "Не использовать \"Лечащие заклинания\""
L["OPT_DISABLEABOLISH_DESC"] = "Если включено, аддон предпочтет 'Излечение болезни' и \"Излечение ядов\" другим \"Лечащим заклинаниям\""
L["OPT_DISABLEMACROCREATION"] = "Отключить создание макроса"
L["OPT_DISABLEMACROCREATION_DESC"] = "Макрос Decursive больше не будет создаваться или поддерживаться"
L["OPT_DISEASECHECK_DESC"] = "Если отмечено, то вы сможете видеть и излечивать заболевших игроков"
L["OPT_DISPLAYOPTIONS"] = "Настройки отображения"
L["OPT_DONOTBLPRIO_DESC"] = "Приоритетный игрок не может быть в чёрном списке"
L["OPT_ENABLE_A_CUSTOM_SPELL"] = "Включить"
L["OPT_ENABLEDEBUG"] = "Включить поиск ошибок"
L["OPT_ENABLEDEBUG_DESC"] = "Включить вывод информации при поиске ошибок"
L["OPT_ENABLEDECURSIVE"] = "Включить Decursive"
L["OPT_FILTEROUTCLASSES_FOR_X"] = "%q будет игнорироваться для указаных классов, пока вы находитесь в режиме боя."
L["OPT_GENERAL"] = "Основные настройки"
L["OPT_GROWDIRECTION"] = "Перевернуть отображение МФИ"
L["OPT_GROWDIRECTION_DESC"] = "МФИ будет отображаться снизу вверх"
L["OPT_HIDEMFS_GROUP"] = "Один/в группе"
L["OPT_HIDEMFS_GROUP_DESC"] = "Скрывать микро-фреймы, когда вы не находитесь в рейде"
L["OPT_HIDEMFS_NEVER"] = "Никогда не скрывать"
L["OPT_HIDEMFS_NEVER_DESC"] = "Никогда не скрывать микро-фреймы автоматически."
L["OPT_HIDEMFS_SOLO"] = "Один"
L["OPT_HIDEMFS_SOLO_DESC"] = "Скрывать микро-фреймы, когда вы не находитесь в группе или в рейде"
L["OPT_HIDEMUFSHANDLE"] = "Скрыть поддержку микро-фреймов игроков."
L["OPT_HIDEMUFSHANDLE_DESC"] = [=[Скрыть заголовок микро-фреймов игроков и отключить возможность их перемещения.
Используйте такую же команду, чтобы вернуть её назад.]=]
L["OPT_IGNORESTEALTHED_DESC"] = "Скрывающиеся игроки будут игнорироваться"
L["OPT_INPUT_SPELL_BAD_INPUT_ALREADY_HERE"] = "Заклинание уже присутствует в списке!"
L["OPT_INPUT_SPELL_BAD_INPUT_DEFAULT_SPELL"] = "Decursive уже работает с этим заклинанием. Щелкните с Shift по заклинанию или введите его ID для добавления специального ранга."
L["OPT_INPUT_SPELL_BAD_INPUT_ID"] = "Неверный ID заклинания!"
L["OPT_INPUT_SPELL_BAD_INPUT_NOT_SPELL"] = "Заклинание не найдено в Вашей книге заклинаний!"
L["OPT_LIVELIST"] = "Активный список"
L["OPT_LIVELIST_DESC"] = "Настройки активного списка"
L["OPT_LLALPHA"] = "Прозрачность активного списка"
L["OPT_LLALPHA_DESC"] = "Изменение прозрачности главной панели Decursive и активного списка (Главная панель должна быть включена)"
L["OPT_LLSCALE"] = "Масштаб активного списка"
L["OPT_LLSCALE_DESC"] = "Установка размера главной панели Decursive и активного списка (Главная панель должна быть включена)"
L["OPT_LVONLYINRANGE"] = "Только игроки в пределах досягаемости"
L["OPT_LVONLYINRANGE_DESC"] = "В активном списке будут отображаться только те игроки, которые находятся в радиусе рассеивания"
L["OPT_MACROBIND"] = "Назначить клавишу для макроса"
L["OPT_MACROBIND_DESC"] = [=[Установка клавиши, с помощью которой будет вызываться макрос 'Decursive'.

Выберите клавишу и нажмите 'Enter' для сохранения нового назначения (установив курсор мыши над областью редактирования)]=]
L["OPT_MACROOPTIONS"] = "Настройки макросов"
L["OPT_MACROOPTIONS_DESC"] = "Установка поведения макросов, созданных Decursive"
L["OPT_MAGICCHARMEDCHECK_DESC"] = "Если отмечено, то вы сможете видеть и излечивать магически очарованных игроков"
L["OPT_MAGICCHECK_DESC"] = "Если отмечено, то вы сможете видеть и излечивать пораженных магией игроков"
L["OPT_MAXMFS"] = "Всего игроков"
L["OPT_MAXMFS_DESC"] = "Установить максимальное количество игроков, отображаемых на микро-фреймах"
L["OPT_MESSAGES"] = "Сообщения"
L["OPT_MESSAGES_DESC"] = "Настройки отображения сообщений"
L["OPT_MFALPHA"] = "Прозрачность"
L["OPT_MFALPHA_DESC"] = "Установка прозрачности МФИ, когда игроки не поражены"
L["OPT_MFPERFOPT"] = "Настройки быстродействия"
L["OPT_MFREFRESHRATE"] = "Частота обновления"
L["OPT_MFREFRESHRATE_DESC"] = "Время между запросами (один или несколько МФИ могут быть обновлены одновременно)"
L["OPT_MFREFRESHSPEED"] = "Скорость обновления"
L["OPT_MFREFRESHSPEED_DESC"] = "Количество микро-фреймов игроков, обновляемых в однократном прохождении"
L["OPT_MFSCALE"] = "Масштаб микро-фреймов игроков"
L["OPT_MFSCALE_DESC"] = "Установка размера микро-фреймов игроков"
L["OPT_MFSETTINGS"] = "Настройки микро-фреймов игроков"
L["OPT_MFSETTINGS_DESC"] = "Настройка микро-фреймов игроков"
L["OPT_MUFFOCUSBUTTON"] = "Кнопка фокуса:"
L["OPT_MUFHANDLE_HINT"] = "Для перемещения микро-фреймов: нажмите ALT+клик по невидимому квадратику, расположенному немного выше первого микро-фрейма."
L["OPT_MUFMOUSEBUTTONS"] = "Кнопки мыши"
L["OPT_MUFMOUSEBUTTONS_DESC"] = [=[Задать кнопки мыши для использования с каждым цветом оповещения микро-фреймов игроков.
Перед изменением этой вкладки вы должны проверить '|cFFFF5533Настройки лечения|r'!]=]
L["OPT_MUFSCOLORS"] = "Цвета"
L["OPT_MUFSCOLORS_DESC"] = "Изменить цвета микро-фреймов игроков."
L["OPT_MUFSVERTICALDISPLAY"] = "Вертикальное отображение"
L["OPT_MUFSVERTICALDISPLAY_DESC"] = "Окно микро-фреймов игроков будет расти вертикально"
L["OPT_MUFTARGETBUTTON"] = "Кнопка цели:"
L["OPT_NEWVERSIONBUGMENOT"] = "Напоминание новой версии"
L["OPT_NEWVERSIONBUGMENOT_DESC"] = "Если обнаружена новая версия Decursive, всплывающее напоминание будет появляться каждые 7 дней"
L["OPT_NOKEYWARN"] = "Известить, если нет клавиши"
L["OPT_NOKEYWARN_DESC"] = "Показать предупреждение, если нет назначенной клавиши."
L["OPT_NOSTARTMESSAGES"] = "Отключить приветствие"
L["OPT_NOSTARTMESSAGES_DESC"] = "Отключает выводимые сообщения Decursivа в окно чата при каждом подключении."
L["OPT_OPTIONS_DISABLED_WHILE_IN_COMBAT"] = "Эти настройки отключаются во время боя."
L["OPT_PERFOPTIONWARNING"] = "ВНИМАНИЕ: Не изменяйте эти значения если не знаете точно что делаете. Эти настройки могуть оказать огромное влияние на производительность игры. Большинству пользователей рекомендуется использовать стандартные значения 0.1 и 10. "
L["OPT_PLAYSOUND_DESC"] = "Проигрывать звук при заражении кого-либо"
L["OPT_POISONCHECK_DESC"] = "Если отмечено, то вы сможете видеть и излечивать отравленных игроков"
L["OPT_PRINT_CUSTOM_DESC"] = "Сообщения Decursive будут выводиться в пользовательское окно чата"
L["OPT_PRINT_ERRORS_DESC"] = "Выводить сообщения об ошибках"
L["OPT_PROFILERESET"] = "Сброс профиля..."
L["OPT_RANDOMORDER_DESC"] = "Игроки будут отображаться и излечиваться в случайном порядке (не рекомендуется)"
L["OPT_READDDEFAULTSD"] = "Повторно добавить стандартный недуг"
L["OPT_READDDEFAULTSD_DESC1"] = [=[Добавить утерянные стандартные недуги Decursive в данный список
Ваши настройки не будут изменены]=]
L["OPT_READDDEFAULTSD_DESC2"] = "Все стандартные недуги Decursive уже существуют в данном списке"
L["OPT_REMOVESKDEBCONF"] = [=[Вы уверены, что хотите удалить
 '%s' 
из списка пропусков?]=]
L["OPT_REMOVETHISDEBUFF"] = "Удалить данный недуг"
L["OPT_REMOVETHISDEBUFF_DESC"] = "Удалить '%s' из списка пропусков"
L["OPT_RESETDEBUFF"] = "Сброс данного недуга"
L["OPT_RESETDTDCRDEFAULT"] = "Сброс '%s' на стандарт Decursive"
L["OPT_RESETMUFMOUSEBUTTONS"] = "Сброс"
L["OPT_RESETMUFMOUSEBUTTONS_DESC"] = "Сброс назначений кнопок мыши на значения по умолчанию."
L["OPT_RESETOPTIONS"] = "Сброс настроек на стандартные"
L["OPT_RESETOPTIONS_DESC"] = "Сброс текущих настроек профиля на стандартные значения"
L["OPT_RESTPROFILECONF"] = [=[Вы уверены, что хотите сбросить настройки профиля
 '(%s) %s'
на стандартные?]=]
L["OPT_REVERSE_LIVELIST_DESC"] = "Активный список будет заполняться снизу вверх"
L["OPT_SCANLENGTH_DESC"] = "Установите промежуток времени между сканированием"
L["OPT_SHOW_STEALTH_STATUS"] = "Показать статус скрытности"
L["OPT_SHOW_STEALTH_STATUS_DESC"] = "Когда игрок использует скрытность, его МЮФ будет окрашен в особый цвет"
L["OPT_SHOWBORDER"] = "Показать края по цвету класса"
L["OPT_SHOWBORDER_DESC"] = "Края МФИ будут отображаться в соответствии с предназначенным для класса цветом"
L["OPT_SHOWHELP"] = "Вызов справки"
L["OPT_SHOWHELP_DESC"] = "Отображать детализированные подсказки при наведении курсора мыши на микро-фреймы игроков"
L["OPT_SHOWMFS"] = "Показать микро-фреймы игроков"
L["OPT_SHOWMFS_DESC"] = "Эта опция должна быть отмечена, если вы хотите лечить с помощью кликов"
L["OPT_SHOWMINIMAPICON"] = "Иконка у миникарты"
L["OPT_SHOWMINIMAPICON_DESC"] = "Показать/скрыть иконку и миникарты."
L["OPT_SHOWTOOLTIP_DESC"] = "Показывать детализированные подсказки о заражениях в активном списке и МФИ"
L["OPT_STICKTORIGHT"] = "Выравнять МФИ вправо"
L["OPT_STICKTORIGHT_DESC"] = "МФИ будет расти справа налево, якорь будет перемещён по мере необходимости."
L["OPT_TESTLAYOUT"] = "Тест отображения"
L["OPT_TESTLAYOUT_DESC"] = [=[Создать 'липовые' элементы для тестирования отображения.
(Необходимо подождать пару секунд после нажатия)]=]
L["OPT_TESTLAYOUTUNUM"] = "Количество игроков"
L["OPT_TESTLAYOUTUNUM_DESC"] = "Укажите количество создаваемых 'липовых' элементов"
L["OPT_TIE_LIVELIST_DESC"] = "Отображение активного списка связано с отображением панели \"Decursive\" "
L["OPT_TIECENTERANDBORDER"] = "Объединить прозрачность центра и краёв"
L["OPT_TIECENTERANDBORDER_OPT"] = "Если отмечено, то прозрачность краёв будет соответствовать прозрачности центра"
L["OPT_TIEXYSPACING"] = "Объединить гориз. и вертик. расстояние"
L["OPT_TIEXYSPACING_DESC"] = "Если отмечено, то горизонтальное и вертикальное расстояния между МФИ будут равны"
L["OPT_UNITPERLINES"] = "Элементов в линии"
L["OPT_UNITPERLINES_DESC"] = "Установить максимальное число элементов, отображаемых на одной строке микрофреймов"
L["OPT_USERDEBUFF"] = "Данный недуг не является стандартным недугом Decursive"
L["OPT_XSPACING"] = "Расстояние по горизонтали"
L["OPT_XSPACING_DESC"] = "Установка расстояния по горизонтали между МФИ"
L["OPT_YSPACING"] = "Расстояние по вертикали"
L["OPT_YSPACING_DESC"] = "Установка расстояния по вертикали между МФИ"
L["OPTION_MENU"] = "Меню настроек Decursive"
L["PLAY_SOUND"] = "Проиграть звук, если есть кого лечить"
L["POISON"] = "Яды"
L["POPULATE"] = "зп"
L["POPULATE_LIST"] = "Быстро заполнить список Decursive"
L["PRINT_CHATFRAME"] = "Выводить сообщения в стандартный чат"
L["PRINT_CUSTOM"] = "Выводить сообщения в окно"
L["PRINT_ERRORS"] = "Выводить сообщения об ошибках"
L["PRIORITY_LIST"] = "Список приоритетов"
L["PRIORITY_SHOW"] = "ПР"
L["RANDOM_ORDER"] = "Лечить в случайном порядке"
L["REVERSE_LIVELIST"] = "Перевернуть отображение активного списка"
L["SCAN_LENGTH"] = "Секунд между активными скан.: "
L["SHIFT"] = "Shift"
L["SHOW_MSG"] = "Для отображения фрейма Decursive введите /dcrshow"
L["SHOW_TOOLTIP"] = "Отображать всплывающие подсказки к зараженным игрокам"
L["SKIP_LIST_STR"] = "Список пропусков"
L["SKIP_SHOW"] = "П"
L["SPELL_FOUND"] = "Заклинание %s найдено!"
L["STEALTHED"] = "Скрывается"
L["STR_CLOSE"] = "Закрыть"
L["STR_DCR_PRIO"] = "Приоритеты Decursive"
L["STR_DCR_SKIP"] = "Пропуски Decursive"
L["STR_GROUP"] = "Группа "
L["STR_OPTIONS"] = "Настройки Decursive"
L["STR_OTHER"] = "Другое"
L["STR_POP"] = "Список заполнений"
L["STR_QUICK_POP"] = "Быстрое заполнение"
L["SUCCESSCAST"] = "|cFF22FFFF%s %s|r |cFF00AA00успешно на|r %s"
L["TARGETUNIT"] = "Цель"
L["TIE_LIVELIST"] = "Привязка обзора активного списка к окну DCR"
L["TOOFAR"] = "Слишком далеко"
L["UNITSTATUS"] = "Состояние: "
L["UNSTABLERELEASE"] = "Нестабильный релиз"

	elseif locale == "frFR" then
L["ABOLISH_CHECK"] = "Voir si \"Abolir\" sur la cible avant de guérir"
L["ABOUT_AUTHOREMAIL"] = "CONTACTER L'AUTEUR"
L["ABOUT_CREDITS"] = "REMERCIEMENTS"
L["ABOUT_LICENSE"] = "LICENCE"
L["ABOUT_NOTES"] = "Affichage et guérison des affections avec un système évolué de filtrage et de priorité."
L["ABOUT_OFFICIALWEBSITE"] = "SITE OFFICIEL"
L["ABOUT_SHAREDLIBS"] = "LIBRAIRIES PARTAGÉES"
L["ABSENT"] = "Absente (%s)"
L["AFFLICTEDBY"] = "Affecté par %s"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "Nombre d'affectés à afficher : "
L["ANCHOR"] = "Ancre du texte"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "Afficher ou masquer les micro-portraits"
L["BINDING_NAME_DCRPRADD"] = "Ajouter la cible à la liste de priorités"
L["BINDING_NAME_DCRPRCLEAR"] = "Effacer la liste de priorités"
L["BINDING_NAME_DCRPRLIST"] = "Afficher la liste de priorités"
L["BINDING_NAME_DCRPRSHOW"] = "Afficher ou Cacher la liste de priorités"
L["BINDING_NAME_DCRSHOW"] = [=[Afficher ou Cacher la barre Decursive
(Ancre de la liste des affectés)]=]
L["BINDING_NAME_DCRSHOWOPTION"] = "Affiche le panneau des options"
L["BINDING_NAME_DCRSKADD"] = "Ajouter la cible à la liste des exceptions"
L["BINDING_NAME_DCRSKCLEAR"] = "Effacer la liste des exceptions"
L["BINDING_NAME_DCRSKLIST"] = "Afficher la liste des exceptions"
L["BINDING_NAME_DCRSKSHOW"] = "Afficher ou Cacher la liste des exceptions"
L["BLACK_LENGTH"] = "Délais (Secs) sur la *blacklist* : "
L["BLACKLISTED"] = "Sur liste noire"
L["CHARM"] = "Possession"
L["CLASS_HUNTER"] = "Chasseur"
L["CLEAR_PRIO"] = "E"
L["CLEAR_SKIP"] = "E"
L["COLORALERT"] = "Règle la couleur d'alerte quand un '%s' est requis."
L["COLORCHRONOS"] = "Compteur central"
L["COLORCHRONOS_DESC"] = "Règle la couleur du compteur au centre de chaque micro-portrait"
L["COLORSTATUS"] = "Règle la couleur du statut '%s'."
L["CTRL"] = "Ctrl"
L["CURE_PETS"] = "Contrôler et guérir les familiers"
L["CURSE"] = "Malédiction"
L["DEBUG_REPORT_HEADER"] = [=[|cFF11FF33Merci d'envoyer par email le contenu de cette fenêtre à <%s>|r
|cFF009999(Faire CTRL+A pour tout sélectionner et CTRL+C pour le copier dans votre "presse papier")|r
Dîtes également dans votre rapport si vous avez remarqué un comportement étrange de %s.
]=]
L["DECURSIVE_DEBUG_REPORT"] = "**** |cFFFF0000Rapport de debuggage de Decursive|r ****"
L["DECURSIVE_DEBUG_REPORT_BUT_NEW_VERSION"] = [=[|cFF11FF33Decursive s'est planté ! Mais n'ayez crainte ! Une NOUVELLE version de Decursive a été détectée (%s). Il suffit simplement de vous mettre à jour. Aller sur Curse.com et chercher 'Decursive' ou utilisez le client de Curse.com, Il mettra à jour tous vos add-ons préférés automatiquement.|r
|cFFFF1133Ne perdez donc pas votre temps en rapportant ce problème, ce bug à probablement déjà été corrigé. Mettez simplement Decursive à jour pour vous débarrasser de ce problème. !|r
|cFF11FF33Merci d'avoir lu ce message !|r]=]
L["DECURSIVE_DEBUG_REPORT_NOTIFY"] = [=[Un rapport de debuggage est disponible !
Taper |cFFFF0000/DCRREPORT|r pour le voir.]=]
L["DECURSIVE_DEBUG_REPORT_SHOW"] = "Rapport de debuggage disponible !"
L["DECURSIVE_DEBUG_REPORT_SHOW_DESC"] = "Affiche un rapport de debuggage que l'auteur doit voir..."
L["DEFAULT_MACROKEY"] = "NONE"
L["DEV_VERSION_ALERT"] = [=[Vous  utilisez une version de développement de Decursive.

Si vous ne voulez pas participer au test des nouvelles fonctionnalités/corrections, recevoir des rapports de débuggage pendant le jeu, rapporter les problèmes à l'auteur alors N'UTILISEZ PAS CETTE VERSION et télécharger la dernière version STABLE sur curse.com ou wowace.com.

Ce message ne sera affiché qu'une seule fois par version.

]=]
L["DEV_VERSION_EXPIRED"] = [=[Cette version de développement de Decursive a expiré.
Vous devriez télécharger la dernière version de développement ou retourner à la version stable courante disponible sur CURSE.COM ou WOWACE.COM]=]
L["DEWDROPISGONE"] = "Il n'y a pas d'équivalent à DewDrop pour Ace3. Faire Alt-clique-droit pour ouvrir le panneau des options."
L["DISABLEWARNING"] = [=[Decursive a été désactivé !
Pour le réactiver, tapper |cFFFFAA44/DCR ENABLE|r]=]
L["DISEASE"] = "Maladie"
L["DONOT_BL_PRIO"] = "Ne pas *blacklister* les gens prioritaires"
L["DONT_SHOOT_THE_MESSENGER"] = "Decursive ne fait que rapporter le problème. Alors, ne tirez pas sur le messager et adressez le vrai problème."
L["FAILEDCAST"] = [=[|cFF22FFFF%s %s|r sur %s |cFFAA0000échoué !|r
|cFF00AAAA%s|r]=]
L["FOCUSUNIT"] = "Focalise l'unité"
L["FUBARMENU"] = "Menu de Fubar"
L["FUBARMENU_DESC"] = "Règles les options relatives à l'icône de FuBar"
L["GLOR1"] = "À la mémoire de Glorfindal"
L["GLOR2"] = "Decursive est dédié à la mémoire de Bertrand qui nous a quitté bien trop tôt. On se souviendra toujours de lui."
L["GLOR3"] = [=[En souvenir de Bertrand Sense
1969 - 2007]=]
L["GLOR4"] = [=[L'amitié et l'affection peuvent prendre naissance n'importe où, ceux qui ont rencontré Glorfindal dans World Of Warcraft ont connu un homme engagé et un leader charismatique.

Il était dans la vie comme dans le jeux, désintéressé, généreux, dévoué envers les siens et surtout un homme passionné.

Il nous a quitté à l'âge de 38 ans laissant derrière lui pas seulement des joueurs anonymes dans un monde virtuel, mais un groupe de véritables amis à qui il manquera éternellement.]=]
L["GLOR5"] = "On ne l'oubliera jamais..."
L["HANDLEHELP"] = "Déplacer tous les micro-portraits"
L["HIDE_MAIN"] = "Cacher la fenêtre \"Decursive\""
L["HIDESHOW_BUTTONS"] = "Cacher/Afficher les boutons et Verrouiller/Déverrouiller la barre \"Decursive\""
L["HLP_LEFTCLICK"] = "Clic Gauche"
L["HLP_LL_ONCLICK_TEXT"] = [=[Cette liste n'est pas cliquable. Merci de lire la documentation pour apprendre à utiliser cet add-on. Cherchez 'Decursive' sur WoWAce.com
(Pour bouger cette liste, bougez la barre de Decursive, /dcrshow et alt-clic-gauche pour déplacer)]=]
L["HLP_MIDDLECLICK"] = "Clic Milieu"
L["HLP_MOUSE4"] = "Souris 4"
L["HLP_MOUSE5"] = "Souris 5"
L["HLP_NOTHINGTOCURE"] = "Il n'y a rien à guérir !"
L["HLP_RIGHTCLICK"] = "Clic Droit"
L["HLP_USEXBUTTONTOCURE"] = "Utilisez \"%s\" pour guérir cette affection !"
L["HLP_WRONGMBUTTON"] = "Mauvais clique !"
L["IGNORE_STEALTH"] = "Ignorer les unités camouflées"
L["IS_HERE_MSG"] = "Decursive est initialisé, n'oubliez pas de contrôler les options disponibles (/decursive)"
L["LIST_ENTRY_ACTIONS"] = [=[|cFF33AA33[CTRL]|r Click : Efface ce joueur
Click |cFF33AA33GAUCHE|r : Monte ce joueur
Click |cFF33AA33DROIT|r: Descend ce joueur
|cFF33AA33[MAJ]|r Click |cFF33AA33GAUCHE|r : Met ce joueur en haut
|cFF33AA33[MAJ]|r Click |cFF33AA33DROIT|r : Met ce joueur en bas]=]
L["MACROKEYALREADYMAPPED"] = [=[ATTENTION: La touche affectée à la macro de Decursive [%s] était affectée à l'action '%s'.
Decursive restaurera l'action originale si vous affectez une autre touche à la macro.]=]
L["MACROKEYMAPPINGFAILED"] = "La touche [%s] n'a pas pu être affectée à la macro de Decursive"
L["MACROKEYMAPPINGSUCCESS"] = "La touche [%s] a été correctement affectée à la macro de Decursive."
L["MACROKEYNOTMAPPED"] = "Aucune touche n'est affectée à la macro de Decursive, reportez-vous aux options concernant la macro !"
L["MAGIC"] = "Magie"
L["MAGICCHARMED"] = "Contrôle magique"
L["MISSINGUNIT"] = "Unité absente"
L["NEW_VERSION_ALERT"] = [=[Une nouvelle version de Decursive a été détectée: |cFFEE7722%q|r sortie le |cFFEE7722%s|r!


Allez sur |cFFFF0000WoWAce.com|r pour l'obtenir !
--------]=]
L["NORMAL"] = "Normal"
L["NOSPELL"] = "Aucun sort disponible"
L["OPT_ABOLISHCHECK_DESC"] = "Définit si les unités avec un sort 'Abolir' actif sont affichées et soignées"
L["OPT_ABOUT"] = "À propos"
L["OPT_ADD_A_CUSTOM_SPELL"] = "Ajouter un sort / objet personnalisé"
L["OPT_ADD_A_CUSTOM_SPELL_DESC"] = "Glissez-déposez un sort ou un objet utilisable ici. Vous pouvez aussi directement taper son nom, son identifiant numérique ou utiliser MAJ+Clique."
L["OPT_ADDDEBUFF"] = "Ajouter une affection"
L["OPT_ADDDEBUFF_DESC"] = "Ajoute une nouvelle affection à cette liste"
L["OPT_ADDDEBUFF_USAGE"] = "<Nom de l'affection>"
L["OPT_ADDDEBUFFFHIST"] = "Ajouter une affection récente"
L["OPT_ADDDEBUFFFHIST_DESC"] = "Ajouter une affection depuis l'historique"
L["OPT_ADVDISP"] = "Options avancées"
L["OPT_ADVDISP_DESC"] = "Permet de régler la transparence de la bordure et du centre séparément, permet de régler l'espace entre les micro-portraits"
L["OPT_AFFLICTEDBYSKIPPED"] = "%s affecté(e) par %s sera ignoré"
L["OPT_ALLOWMACROEDIT"] = "Autoriser l'édition de la macro"
L["OPT_ALLOWMACROEDIT_DESC"] = "Activer cette option empêche Decursive de mettre à jour sa macro, vous permettant de la modifier."
L["OPT_ALWAYSIGNORE"] = "Ignorer aussi hors combat"
L["OPT_ALWAYSIGNORE_DESC"] = "Si cochée, cette affection sera aussi ignorée en dehors des combats"
L["OPT_AMOUNT_AFFLIC_DESC"] = "Définit le nombre max d'affectés affichés dans la liste des affectés."
L["OPT_ANCHOR_DESC"] = "Montre l'ancre de la fenêtre de discussion spéciale"
L["OPT_AUTOHIDEMFS"] = "Masquer les MUFs quand :"
L["OPT_AUTOHIDEMFS_DESC"] = "Choisissez quand la fenêtre des micro-portraits doit être masquée automatiquement."
L["OPT_BLACKLENTGH_DESC"] = "Définit combien de temps quelqu'un reste sur liste noire"
L["OPT_BORDERTRANSP"] = "Transparence de la bordure"
L["OPT_BORDERTRANSP_DESC"] = "Règle la transparence de la bordure"
L["OPT_CENTERTEXT"] = "Compteur central :"
L["OPT_CENTERTEXT_DESC"] = [=[Affiche des informations concernant l'affliction la plus importante (selon vos priorités) au centre de chaque micro-portrait.

Soit:
- Le temps restant avant l'expiration naturelle
- Le temps écoulé depuis l'infection
- Le nombre d'applications]=]
L["OPT_CENTERTEXT_DISABLED"] = "Désactivé"
L["OPT_CENTERTEXT_ELAPSED"] = "Temps écoulé"
L["OPT_CENTERTEXT_STACKS"] = "Nombre d'applications"
L["OPT_CENTERTEXT_TIMELEFT"] = "Temps restant"
L["OPT_CENTERTRANSP"] = "Transparence du centre"
L["OPT_CENTERTRANSP_DESC"] = "Règle la transparence du centre"
L["OPT_CHARMEDCHECK_DESC"] = "Si cochée, vous pourrez voir et guérir les unités possédées"
L["OPT_CHATFRAME_DESC"] = "Les messages de Decursive seront affichés dans la fenêtre de discussion par défaut"
L["OPT_CHECKOTHERPLAYERS"] = "Vérifier les autres joueurs"
L["OPT_CHECKOTHERPLAYERS_DESC"] = "Affiche la version de Decursive utilisée par les joueurs de votre groupe ou de votre guilde (Ne fonctionne qu'à partir de la version 2.4.6 de Decursive)."
L["OPT_CMD_DISBLED"] = "Désactivé"
L["OPT_CMD_ENABLED"] = "Activé"
L["OPT_CREATE_VIRTUAL_DEBUFF"] = "Créer une affection virtuelle de test"
L["OPT_CREATE_VIRTUAL_DEBUFF_DESC"] = "Permet de voir ce qu'il se passe lorsqu'une affection est détectée"
L["OPT_CURE_PRIORITY_NUM"] = "Priorité #%d"
L["OPT_CUREPETS_DESC"] = "Les familiers seront affichés et guéris"
L["OPT_CURINGOPTIONS"] = "Options de guérison"
L["OPT_CURINGOPTIONS_DESC"] = "Définit les différents aspects du processus de guérison (Types d'affections, et priorités)"
L["OPT_CURINGOPTIONS_EXPLANATION"] = [=[Sélectionnez les types d'affection que vous souhaitez guérir. Les types non sélectionnés seront complètement ignorés par Decursive.

Les chiffres en vert indiquent la priorité du type d'affections. Cette priorité affecte plusieurs aspects de Decursive :

- Quelle affection Decursive vous montre en premier lorsqu'un joueur souffre de plusieurs types affections.

- Quelle sera la couleur du micro-portrait et donc sur quel bouton de la souris vous devrez cliquer pour guérir ce type d'affections (clique gauche pour le premier sort, clique droit pour le second, etc...).

(Pour changer l'ordre, dé-sélectionnez tous les types et cochez-les dans l'ordre souhaité)]=]
L["OPT_CURINGORDEROPTIONS"] = "Types d'affections et priorités"
L["OPT_CURSECHECK_DESC"] = "Si cochée, vous pourrez voir et guérir les unités maudites"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING"] = "Autoriser la modification de la macro interne pour le sort ci-dessus"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING_DESC"] = [=[Cochez cela si vous voulez modifier la macro interne que Decursive utilisera pour le sort personnalisé que vous êtes en train d'ajouter.

Note: En cochant cela vous pourrez modifier les sorts gérés par Decursive.

Si un sort est déjà listé, il faudra d'abord le retirer pour activer cette option.

(---Seulement pour les utilisateurs avancés---)]=]
L["OPT_CUSTOM_SPELL_CURE_TYPES"] = "Types d'afflictions"
L["OPT_CUSTOM_SPELL_IS_DEFAULT"] = "Ce sort fait partie de la configuration automatique de Decursive. Si le sort ne fonctionne plus correctement, vous pouvez l'effacer pour retrouver le comportement par défaut de Decursive."
L["OPT_CUSTOM_SPELL_ISPET"] = "Capacité de familier"
L["OPT_CUSTOM_SPELL_ISPET_DESC"] = "Cocher cette option si c'est une capacité appartenant à l'un de vos familiers afin que Decursive puisse la détecter et l'utiliser correctement."
L["OPT_CUSTOM_SPELL_MACRO_MISSING_NOMINAL_SPELL"] = "Attention: le sort %q n’apparaît pas dans votre macro, les informations de cooldown et de portée ne correspondront pas... "
L["OPT_CUSTOM_SPELL_MACRO_MISSING_UNITID_KEYWORD"] = "Le mot-clé UNITID est manquant."
L["OPT_CUSTOM_SPELL_MACRO_TEXT"] = "Texte de la macro :"
L["OPT_CUSTOM_SPELL_MACRO_TEXT_DESC"] = [=[Modifiez le texte original de la macro.
|cFFFF0000Seulement 2 restrictions:|r

- Vous devez spécifier la cible en utilisant le mot-clé UNITID qui sera automatiquement remplacé par l'identifiant d'unité de chaque micro-portrait.

- Quel que soit le sort utilisé dans la macro, Decursive utilisera le nom originel indiqué à gauche pour récupérer et afficher les informations de portée et de cooldown.
(Gardez cela à l'esprit si vous comptez utiliser différents sorts avec des conditions)]=]
L["OPT_CUSTOM_SPELL_MACRO_TOO_LONG"] = "Votre macro est trop longue, vous devez enlever %d caractères."
L["OPT_CUSTOM_SPELL_PRIORITY"] = "Priorité du sort"
L["OPT_CUSTOM_SPELL_PRIORITY_DESC"] = [=[Quand plusieurs sorts peuvent guérir les mêmes types d'afflictions, ceux ayant la priorité la plus élevée seront préférés.

Notez que les sorts par défaut gérés par Decursive ont une priorité allant de 0 à 9.

Ainsi, si vous donnez une priorité négative à l'un de vos sort, il ne sera choisi que si le sort par défaut n'est pas disponible.]=]
L["OPT_CUSTOM_SPELL_UNAVAILABLE"] = "indisponible"
L["OPT_CUSTOM_SPELL_UNIT_FILTER"] = "Filtrage"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_DESC"] = "Sélectionnez les unités qui peuvent bénéficier de cette technique"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_NONE"] = "Toutes les unités"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_NONPLAYER"] = "Les autres seulement"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_PLAYER"] = "Seulement sois-même"
L["OPT_CUSTOMSPELLS"] = "Sorts / objets personnalisés"
L["OPT_CUSTOMSPELLS_DESC"] = [=[Ici vous pouvez ajouter des sorts pour étendre la configuration automatique de Decursive.
Vos sorts personnalisés auront toujours une priorité plus élevée et remplaceront systématiquement les sorts par défaut (si et seulement si votre personnage peut utiliser ces sorts)]=]
L["OPT_CUSTOMSPELLS_EFFECTIVE_ASSIGNMENTS"] = "Assignations effectives des sorts :"
L["OPT_DEBCHECKEDBYDEF"] = [=[

Cochée par défaut]=]
L["OPT_DEBUFFENTRY_DESC"] = "Sélectionnez quelle classe doit être ignorée pour cette affection"
L["OPT_DEBUFFFILTER"] = "Filtrage des affections"
L["OPT_DEBUFFFILTER_DESC"] = "Sélectionner les affections à filtrer par nom et par classe pendant les combat"
L["OPT_DELETE_A_CUSTOM_SPELL"] = "Supprimer"
L["OPT_DISABLEABOLISH"] = "Ne pas utiliser les sorts 'Abolir'"
L["OPT_DISABLEABOLISH_DESC"] = "Si activée, Decursive préfèrera 'Guérison des maladies' et 'Guérison du poison' à la place de leur équivalent en 'Abolir'"
L["OPT_DISABLEMACROCREATION"] = "Ne pas créer de macro"
L["OPT_DISABLEMACROCREATION_DESC"] = "La macro de Decursive ne sera plus créée ni mis à jour."
L["OPT_DISEASECHECK_DESC"] = "Si cochée, vous pourrez voir et guérir les unités malade"
L["OPT_DISPLAYOPTIONS"] = "Options d'affichage"
L["OPT_DONOTBLPRIO_DESC"] = "Les unités prioritaires ne seront pas blacklistées"
L["OPT_ENABLE_A_CUSTOM_SPELL"] = "Activer"
L["OPT_ENABLE_LIVELIST"] = "Activer la liste des affligés"
L["OPT_ENABLE_LIVELIST_DESC"] = [=[Affiche une liste des gens affligés.

vous pouvez déplacer cette liste en déplaçant la barre de Decursive (tapper /DCRSHOW pour afficher cette barre)]=]
L["OPT_ENABLEDEBUG"] = "Debug"
L["OPT_ENABLEDEBUG_DESC"] = "Activer les informations de debuggage"
L["OPT_ENABLEDECURSIVE"] = "Activer Decursive"
L["OPT_FILTEROUTCLASSES_FOR_X"] = "%q sera ignoré sur les classes spécifiées pendant que vous êtes en combat."
L["OPT_GENERAL"] = "Options générales"
L["OPT_GROWDIRECTION"] = "Inverser l'affichage des micro-portraits"
L["OPT_GROWDIRECTION_DESC"] = "Les micro-portraits seront affichés de bas en haut"
L["OPT_HIDEMFS_GROUP"] = "en solo ou en groupe"
L["OPT_HIDEMFS_GROUP_DESC"] = "Masque la fenêtre lorsque vous n'êtes pas dans un groupe de raid."
L["OPT_HIDEMFS_NEVER"] = "Ne jamais masquer"
L["OPT_HIDEMFS_NEVER_DESC"] = "Ne jamais masquer la fenêtre automatiquement."
L["OPT_HIDEMFS_SOLO"] = "en solo"
L["OPT_HIDEMFS_SOLO_DESC"] = "Masque la fenêtre lorsque vous jouez en solo."
L["OPT_HIDEMUFSHANDLE"] = "Chacher la poignée des Micro-Portraits"
L["OPT_HIDEMUFSHANDLE_DESC"] = [=[Cache la poignée des Micro-Portraits et désactive la possibilité de les bouger.
Utilisez la même commande pour la retrouver.]=]
L["OPT_IGNORESTEALTHED_DESC"] = "Les unités camouflées seront ignorées"
L["OPT_INPUT_SPELL_BAD_INPUT_ALREADY_HERE"] = "Le sort est déjà dans la liste !"
L["OPT_INPUT_SPELL_BAD_INPUT_DEFAULT_SPELL"] = "Decursive gère déjà ce sort. MAJ-cliquez sur le sort ou tapez son ID pour ajouter un rang spécial."
L["OPT_INPUT_SPELL_BAD_INPUT_ID"] = "ID de sort invalide !"
L["OPT_INPUT_SPELL_BAD_INPUT_NOT_SPELL"] = "Ce sort ne se trouve pas dans votre grimoire !"
L["OPT_LIVELIST"] = "Liste des affligés"
L["OPT_LIVELIST_DESC"] = [=[Ce sont les options concernant la liste des affligés affichée en dessous de la barre "Decursive".

Pour déplacer cette liste il faut bouger cette barre. Certains des réglages ci-dessous ne sont accessibles que lorsque cette barre est affichée. Vous pouvez l'afficher en tapant |cff20CC20/DCRSHOW|r dans votre fenêtre de discussion.

Une fois que vous avez réglé la position, l'échelle et la transparence vous pouvez cacher cette barre sans problème en tapant  |cff20CC20/DCRHIDE|r.]=]
L["OPT_LLALPHA"] = "Transparence"
L["OPT_LLALPHA_DESC"] = [=[Définit la transparence de la barre principale de Decursive et de la liste des affligés
(la barre principale doit être affichée)]=]
L["OPT_LLSCALE"] = "Échelle de la liste des affectés"
L["OPT_LLSCALE_DESC"] = [=[Définit la taille de la barre principale de Decursive et de la liste des affectés
(la barre principale doit être affichée)]=]
L["OPT_LVONLYINRANGE"] = "Unités à portée seulement"
L["OPT_LVONLYINRANGE_DESC"] = "Si cette option est activée, uniquement les unités à portée de sorts seront affichées dans la liste"
L["OPT_MACROBIND"] = "Définit la touche liée à la macro"
L["OPT_MACROBIND_DESC"] = [=[Définit la touche à partir de laquelle la macro 'Decursive' sera appelée.

Appuyer sur la touche puis sur 'Entrée' pour sauvegarder la nouvelle affectation.]=]
L["OPT_MACROOPTIONS"] = "Options de la macro"
L["OPT_MACROOPTIONS_DESC"] = "Définit le comportement de la macro 'mouseover' créée par Decursive"
L["OPT_MAGICCHARMEDCHECK_DESC"] = "Si cochée, vous pourrez voir et guérir les unités contrôlées par magie"
L["OPT_MAGICCHECK_DESC"] = "Si cochée, vous pourrez voir et guérir les unités affectées par la magie"
L["OPT_MAXMFS"] = "Nombre maximum d'unités affichées"
L["OPT_MAXMFS_DESC"] = "Définit le nombre maximum de micro-portraits à afficher"
L["OPT_MESSAGES"] = "Messages"
L["OPT_MESSAGES_DESC"] = "Options sur les messages affichés"
L["OPT_MFALPHA"] = "Transparence"
L["OPT_MFALPHA_DESC"] = "Définit la transparence des micro-portraits, lorsque l'unité n'est pas affectée."
L["OPT_MFPERFOPT"] = "Options de performance"
L["OPT_MFREFRESHRATE"] = "Taux de rafraîchissement"
L["OPT_MFREFRESHRATE_DESC"] = "Période de rafraîchissement (1 ou plusieurs micro-portraits peuvent être rafraîchis en même temps)"
L["OPT_MFREFRESHSPEED"] = "Rapidité de rafraîchissement"
L["OPT_MFREFRESHSPEED_DESC"] = "Nombre de micro-portraits à rafraîchir à chaque passage"
L["OPT_MFSCALE"] = "Échelle des micro-portraits"
L["OPT_MFSCALE_DESC"] = "Définit la taille des micro-portraits"
L["OPT_MFSETTINGS"] = "Options des micro-portraits"
L["OPT_MFSETTINGS_DESC"] = "Règle divers options d'affichage des micro-portraits et des priorités de guérison"
L["OPT_MUFFOCUSBUTTON"] = "Bouton de focalisation"
L["OPT_MUFHANDLE_HINT"] = "Pour déplacer les micro-portraits : ALT-cliquez sur la poignée invisible située au dessus du premier micro-portrait."
L["OPT_MUFMOUSEBUTTONS"] = "Boutons de la souris"
L["OPT_MUFMOUSEBUTTONS_DESC"] = [=[Ici vous pouvez changer le bouton de la souris correspondant à chacune des actions possibles sur les micro-portraits (guérison, ciblage et focalisation).

À chacune des différentes priorités correspond un certain type d'affection, comme indiqué dans le panneau "|cFFFF5533Options de guérison|r".

Les sorts utilisés pour chaque type d'affection sont réglés automatiquement, vous pouvez changer ces sorts dans le panneau '|cFF00DDDDSorts personnalisés|r'.]=]
L["OPT_MUFSCOLORS"] = "Couleurs"
L["OPT_MUFSCOLORS_DESC"] = [=[Options pour changer la couleur de chaque priorité de guérison et des différents statuts des micro-portraits.

À chacune des différentes priorités correspond un certain type d'affection, comme indiqué dans le panneau "|cFFFF5533Options de guérison|r".]=]
L["OPT_MUFSVERTICALDISPLAY"] = "Affichage vertical"
L["OPT_MUFSVERTICALDISPLAY_DESC"] = "La fenêtre des micro-portraits s'agrandira verticalement"
L["OPT_MUFTARGETBUTTON"] = "Bouton de ciblage"
L["OPT_NEWVERSIONBUGMENOT"] = "Alertes de mise à jour"
L["OPT_NEWVERSIONBUGMENOT_DESC"] = "Si une nouvelle version de Decursive est détectée, une alerte sera affichée une fois tous les sept jours."
L["OPT_NOKEYWARN"] = "Avertir si aucune touche"
L["OPT_NOKEYWARN_DESC"] = "Affiche un avertissement si aucune touche n'est affectée à la macro."
L["OPT_NOSTARTMESSAGES"] = "Désactiver les messages de bienvenue"
L["OPT_NOSTARTMESSAGES_DESC"] = "Enlève les deux messages que Decursive écrit dans le chat à chaque connexion."
L["OPT_OPTIONS_DISABLED_WHILE_IN_COMBAT"] = "Ces options sont désactivées lorsque vous combattez."
L["OPT_PERFOPTIONWARNING"] = "ATTENTION : Ne changez pas ces réglages sauf si vous savez parfaitement ce que vous faites. Ces réglages peuvent affecter grandement les performances du jeux. La plus part des utilisateurs devrait utiliser les valeurs par défaut de 0,1 et 10."
L["OPT_PLAYSOUND_DESC"] = "Joue un son si quelqu'un est affecté."
L["OPT_POISONCHECK_DESC"] = "Si cochée, vous pourrez voir et guérir les unités empoisonnées"
L["OPT_PRINT_CUSTOM_DESC"] = "Les messages de Decursive seront affichés dans une fenêtre de discussion spéciale"
L["OPT_PRINT_ERRORS_DESC"] = "Les erreurs seront affichées"
L["OPT_PROFILERESET"] = "Remise à zéro du profil..."
L["OPT_RANDOMORDER_DESC"] = "Les unités seront affichées et guéries au hasard (non recommandé)"
L["OPT_READDDEFAULTSD"] = "Ré-ajouter les affections par défaut"
L["OPT_READDDEFAULTSD_DESC1"] = [=[Ajoute les affections de Decursive manquant à cette liste
Votre configuration ne sera pas changée]=]
L["OPT_READDDEFAULTSD_DESC2"] = "Toutes les affections par défaut de Decursive sont dans cette liste"
L["OPT_REMOVESKDEBCONF"] = [=[Êtes-vous sûr de vouloir enlever 
 '%s' 
de la liste des exceptions ?]=]
L["OPT_REMOVETHISDEBUFF"] = "Enlever cette affection"
L["OPT_REMOVETHISDEBUFF_DESC"] = "Supprime '%s' de la liste d'exception"
L["OPT_RESETDEBUFF"] = "Remettre à zéro cette affection"
L["OPT_RESETDTDCRDEFAULT"] = "Met '%s' aux valeurs par défaut de Decursive"
L["OPT_RESETMUFMOUSEBUTTONS"] = "Réinitialiser"
L["OPT_RESETMUFMOUSEBUTTONS_DESC"] = "Réinitialise les affectations des boutons de la souris aux valeurs par défaut."
L["OPT_RESETOPTIONS"] = "Remet les options par défaut"
L["OPT_RESETOPTIONS_DESC"] = "Met les options du profil courant aux valeurs par défaut"
L["OPT_RESTPROFILECONF"] = [=[Êtes-vous sûr de vouloir remettre votre profil
 '(%s) %s'
 aux valeurs par défaut ?]=]
L["OPT_REVERSE_LIVELIST_DESC"] = "La liste des affectés se remplit de bas en haut"
L["OPT_SCANLENGTH_DESC"] = "Définit le temps entre chaque scan"
L["OPT_SHOW_STEALTH_STATUS"] = "Montrer le camouflage"
L["OPT_SHOW_STEALTH_STATUS_DESC"] = "Lorsqu'un joueur est camouflé, son micro-portrait prendra une couleur spéciale."
L["OPT_SHOWBORDER"] = "Afficher la bordure colorée des classes"
L["OPT_SHOWBORDER_DESC"] = "Une bordure colorée représentant la classe de l'unité est affichée autour des micro-portraits"
L["OPT_SHOWHELP"] = "Affiche l'aide"
L["OPT_SHOWHELP_DESC"] = "Affiche une bulle d'aide lorsque la souris passe au-dessus d'un micro-portrait"
L["OPT_SHOWMFS"] = "Affiche la fenêtre de micro-portraits"
L["OPT_SHOWMFS_DESC"] = "Cette option doit être activée, si vous voulez guérir en cliquant avec la souris"
L["OPT_SHOWMINIMAPICON"] = "Icône Minicarte"
L["OPT_SHOWMINIMAPICON_DESC"] = "Active/Désactive l'icône de la minicarte"
L["OPT_SHOWTOOLTIP_DESC"] = "Affiche une bulle d'informations détaillées à propos des affections sur les micro-portraits et dans la liste des affectés."
L["OPT_STICKTORIGHT"] = "Aligner la fenêtre à droite"
L["OPT_STICKTORIGHT_DESC"] = "La fenêtre des micro-portrait se développera de la droite vers la gauche, la poignée sera déplacée automatiquement."
L["OPT_TESTLAYOUT"] = "Tester la disposition"
L["OPT_TESTLAYOUT_DESC"] = [=[Créé des unités virtuelles permettant de tester leur disposition.
(Attendre quelques secondes après avoir cliqué)]=]
L["OPT_TESTLAYOUTUNUM"] = "Nombre d'unité"
L["OPT_TESTLAYOUTUNUM_DESC"] = "Règle le nombre d'unité virtuelles à créer."
L["OPT_TIE_LIVELIST_DESC"] = "L'affichage de la liste des affectés est lié à celui de la barre \"Decursive\""
L["OPT_TIECENTERANDBORDER"] = "Lier le centre et la bordure"
L["OPT_TIECENTERANDBORDER_OPT"] = "Quand activée, la transparence de la bordure vaut la moitié de celle du centre"
L["OPT_TIEXYSPACING"] = "Lier l'espacement horizontale et verticale"
L["OPT_TIEXYSPACING_DESC"] = "L'espacement horizontale et verticale entre les micro-portraits sont identiques"
L["OPT_UNITPERLINES"] = "Nombre d'unités par rangée"
L["OPT_UNITPERLINES_DESC"] = "Définit le nombre maximum de micro-portraits à afficher par rangée"
L["OPT_USERDEBUFF"] = "Cette affection ne fait pas partie de la liste des affections par défaut de Decursive"
L["OPT_XSPACING"] = "Espacement horizontal"
L["OPT_XSPACING_DESC"] = "Règle l'espacement horizontal entre les micro-portraits"
L["OPT_YSPACING"] = "Espacement vertical"
L["OPT_YSPACING_DESC"] = "Règle l'espacement vertical entre les micro-portraits"
L["OPTION_MENU"] = "Menu options"
L["PLAY_SOUND"] = "Jouer un son quand il y a quelqu'un à guérir"
L["POISON"] = "Poison"
L["POPULATE"] = "R"
L["POPULATE_LIST"] = "Remplir rapidement la liste"
L["PRINT_CHATFRAME"] = "Afficher les messages dans le canal par défaut"
L["PRINT_CUSTOM"] = "Afficher les messages dans la fenêtre"
L["PRINT_ERRORS"] = "Afficher les messages d'erreurs"
L["PRIORITY_LIST"] = "Liste des priorités"
L["PRIORITY_SHOW"] = "P"
L["RANDOM_ORDER"] = "Guérir aléatoirement"
L["REVERSE_LIVELIST"] = "Inverser l'affichage de la liste"
L["SCAN_LENGTH"] = "Délai (secs) entre les scans : "
L["SHIFT"] = "Maj"
L["SHOW_MSG"] = "Pour afficher la fenêtre \"Decursive\", tapez /dcrshow."
L["SHOW_TOOLTIP"] = "Afficher les infos-bulles sur les unités affectées"
L["SKIP_LIST_STR"] = "Liste des exceptions"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "%s trouvé !"
L["STEALTHED"] = "Camouflée"
L["STR_CLOSE"] = "Fermer"
L["STR_DCR_PRIO"] = "Liste de priorités"
L["STR_DCR_SKIP"] = "Liste des exceptions"
L["STR_GROUP"] = "Groupe "
L["STR_OPTIONS"] = "Options de Decursive"
L["STR_OTHER"] = "Autre"
L["STR_POP"] = "Remplir la liste"
L["STR_QUICK_POP"] = "Remplir rapidement"
L["SUCCESSCAST"] = "|cFF22FFFF%s %s|r sur %s |cFF00AA00réussi !|r"
L["TARGETUNIT"] = "Cible l'unité"
L["TIE_LIVELIST"] = "Lier la visibilité de la liste à \"Decursive\""
L["TOC_VERSION_EXPIRED"] = [=[Votre version de Decursive est périmée. Cette version de Decursive est plus ancienne que la version de World of Warcraft que vous utilisez.
Vous devez mettre à jour Decursive pour corriger d'éventuelles incompatibilités ou erreurs.

Allez sur curse.com et cherchez "Decursive" ou utilisez le client de Curse.com pour mettre tous vos add-ons à jour.

Cette note sera affichée de nouveau dans deux jours.]=]
L["TOO_MANY_ERRORS_ALERT"] = [=[Il y a trop d'erreurs Lua dans votre interface utilisateur (%d erreurs). Votre expérience de jeu peut être dégradée. Désactivez ou mettez à jour les add-ons en erreur pour stopper ce message.
Vous devriez activer les rapports d'erreur Lua (/console scriptErrors 1).]=]
L["TOOFAR"] = "Hors de portée"
L["UNITSTATUS"] = "Statut de l'unité : "
L["UNSTABLERELEASE"] = "Version instable"

	elseif locale == "esMX" then

	elseif locale == "ptBR" then
L["ABOLISH_CHECK"] = "Verifique se há \"Abolir\" antes de curar"
L["ABOUT_LICENSE"] = "Licensa"
L["ABOUT_OFFICIALWEBSITE"] = "WEBSITE OFFICIAL"
L["ABSENT"] = "Faltando (%s)"
L["AFFLICTEDBY"] = "%s Afligido"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "A quantidade afligida para exibir"
L["ANCHOR"] = "Âncora de texto do Decursive"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "Mostrar ou esconder os micro quadros de unidades."
L["BINDING_NAME_DCRPRADD"] = "Adicionar alvo na lista de prioridades"
L["BINDING_NAME_DCRPRCLEAR"] = "Limpar a lista de prioridades"
L["BINDING_NAME_DCRPRLIST"] = "Imprimir a lista de prioridades"
L["BINDING_NAME_DCRPRSHOW"] = "Mostrar ou esconder a lista de prioridade"
L["BINDING_NAME_DCRSHOW"] = [=[Mostrar ou esconder a Barra Principal do Decursive
(âncora de lista ao vivo)]=]
L["BINDING_NAME_DCRSHOWOPTION"] = "Mostrar opção de painel estático"
L["BINDING_NAME_DCRSKADD"] = "Adiciona alvo à lista de passe"
L["BINDING_NAME_DCRSKCLEAR"] = "Limpar a lista de passe"
L["BINDING_NAME_DCRSKLIST"] = "Mostrar a lista de passe"
L["BINDING_NAME_DCRSKSHOW"] = "Mostra ou oculta a lista de passe"
L["BLACK_LENGTH"] = "Segundos na lista negra"
L["BLACKLISTED"] = "Lista negra"
L["CHARM"] = "Encantar"
L["CLASS_HUNTER"] = "Caçador"
L["COLORCHRONOS"] = "Cronometros"
L["CTRL"] = "Ctrl"
L["CURSE"] = "Maldição"
L["GLOR1"] = "Em memoria de Glorfindal"
L["GLOR2"] = [=[Decursive é dedicado a memoria de Bertrand que nós deixou muito cedo.
Ele sempre sera lembrado.]=]
L["GLOR3"] = [=[Em memoria de Bertrand Sense
1969-2007]=]
L["HIDESHOW_BUTTONS"] = "Mostrar/Esconder Buttoes"
L["OPT_NOSTARTMESSAGES"] = "Desativar mensagens de iniciar"
L["SHIFT"] = "Shift"
L["SHOW_MSG"] = "Para amostrar a janela do Decursive, escreve /dcrshow"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "%s feitiço nao foi encontrado"
L["STR_CLOSE"] = "Fechar"
L["STR_DCR_PRIO"] = "Prioridade do Decursive"

	elseif locale == "itIT" then

	end
end

