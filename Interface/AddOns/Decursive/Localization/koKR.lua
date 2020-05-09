--[[
    This file is part of Decursive.

    Decursive (v 2.7.7) add-on for World of Warcraft UI
    Copyright (C) 2006-2019 John Wellesz (Decursive AT 2072productions.com) ( http://www.2072productions.com/to/decursive.php )

    Decursive is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Decursive is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Decursive.  If not, see <https://www.gnu.org/licenses/>.


    Decursive is inspired from the original "Decursive v1.9.4" by Patrick Bohnet (Quu).
    The original "Decursive 1.9.4" is in public domain ( www.quutar.com )

    Decursive is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY.

    This file was last updated on 2019-11-18T13:42:00Z
--]]
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Korean localization
-------------------------------------------------------------------------------

--[=[
--                      YOUR ATTENTION PLEASE
--
--         !!!!!!! TRANSLATORS TRANSLATORS TRANSLATORS !!!!!!!
--
--    Thank you very much for your interest in translating Decursive.
--    Do not edit those files. Use the localization interface available at the following address:
--
--      ################################################################
--      #  http://wow.curseforge.com/projects/decursive/localization/  #
--      ################################################################
--
--    Your translations made using this interface will be automatically included in the next release.
--
--]=]

local addonName, T = ...;
-- big ugly scary fatal error message display function {{{
if not T._FatalError then
-- the beautiful error popup : {{{ -
StaticPopupDialogs["DECURSIVE_ERROR_FRAME"] = {
    text = "|cFFFF0000Decursive Error:|r\n%s",
    button1 = "OK",
    OnAccept = function()
        return false;
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    showAlert = 1,
    preferredIndex = 3,
    }; -- }}}
T._FatalError = function (TheError) StaticPopup_Show ("DECURSIVE_ERROR_FRAME", TheError); end
end
-- }}}
if not T._LoadedFiles or not T._LoadedFiles["enUS.lua"] then
    if not DecursiveInstallCorrupted then T._FatalError("Decursive installation is corrupted! (enUS.lua not loaded)"); end;
    DecursiveInstallCorrupted = true;
    return;
end
T._LoadedFiles["koKR.lua"] = false;

-------------------------------------------------------------------------------
-- Korean localization
-------------------------------------------------------------------------------

local L = LibStub("AceLocale-3.0"):NewLocale("Decursive", "koKR");

if not L then
    T._LoadedFiles["koKR.lua"] = "2.7.7";
    return;
end;

L["ABOLISH_CHECK"] = "해제 전 \"해제 주문\" 검사"
L["ABOUT_AUTHOREMAIL"] = "제작자 이메일"
L["ABOUT_CREDITS"] = "공로자"
L["ABOUT_LICENSE"] = "라이센스"
L["ABOUT_NOTES"] = "솔로, 그룹과 공격대를 위한 고급화된 필터링과 우선순위 시스템으로 피해들의 표시와 제거를 합니다."
L["ABOUT_OFFICIALWEBSITE"] = "공식 웹사이트"
L["ABOUT_SHAREDLIBS"] = "공유된 라이브러리들"
L["ABSENT"] = "(%s) 실패"
L["AFFLICTEDBY"] = "%s에 걸림"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "피해를 입은 수 표시 : "
L["ANCHOR"] = "Decursive 문자 기준"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "작은 유닛프레임 표시/숨김"
L["BINDING_NAME_DCRPRADD"] = "대상을 우선순위 목록에 추가"
L["BINDING_NAME_DCRPRCLEAR"] = "우선순위 목록 지우기"
L["BINDING_NAME_DCRPRLIST"] = "우선순위 목록 출력"
L["BINDING_NAME_DCRPRSHOW"] = "우선순위 목록 표시/숨김"
L["BINDING_NAME_DCRSHOW"] = [=[Decursive 메인바 표시/숨김
(실시간 목록 기준)]=]
L["BINDING_NAME_DCRSHOWOPTION"] = "설정 고정 창 표시"
L["BINDING_NAME_DCRSKADD"] = "대상을 예외 목록에 추가"
L["BINDING_NAME_DCRSKCLEAR"] = "예외 목록 지우기"
L["BINDING_NAME_DCRSKLIST"] = "예외 목록 출력"
L["BINDING_NAME_DCRSKSHOW"] = "예외 목록 표시/숨김"
L["BLACK_LENGTH"] = "블랙리스트 추가 시간(초) : "
L["BLACKLISTED"] = "블랙리스트됨"
L["CHARM"] = "변이"
L["CLASS_HUNTER"] = "사냥꾼"
L["CLEAR_PRIO"] = "C"
L["CLEAR_SKIP"] = "C"
L["COLORALERT"] = "'%s'|1이;가; 필요할 때의 색상 알림을 설정합니다."
L["COLORCHRONOS"] = "중앙 카운터"
L["COLORCHRONOS_DESC"] = "중앙 카운터의 색상을 설정합니다."
L["COLORSTATUS"] = "'%s' 작은 유닛프레임 상태의 색상을 설정합니다."
L["CTRL"] = "Ctrl"
L["CURE_PETS"] = "소환수 탐색과 치료"
L["CURSE"] = "저주"
L["DEBUG_REPORT_HEADER"] = [=[|cFF11FF33<%s>로 이 창의 내용을 이메일로 보내주세요.|r
|cFF009999(CTRL+A키로 모두 선택하고 CTRL+C키로 당신의 클립보드 내 문자를 넣어 사용하세요.)|r
또한 %s의 이상 동작을 발견하면 보고서에 알려주십시오.
]=]
L["DECURSIVE_DEBUG_REPORT"] = "**** |cFFFF0000Decursive 디버그 보고서|r ****"
L["DECURSIVE_DEBUG_REPORT_BUT_NEW_VERSION"] = [=[|cFF11FF33Decursive가 충돌했지만 두려워하지 마세요! 새로운 버전의 Decursive(%s)가 감지되었습니다. 단순히 업데이트만 하면됩니다. curse.com으로 이동해 'Decursive'를 검색하거나 Curse의 클라이언트를 사용하면 애용하는 모든 애드온이 자동으로 업데이트됩니다.|r
|cFFFF1133이 버그는 이미 수정 된 것으로 보고되므로 시간을 낭비하지 마시고 이 문제를 해결하려면 Decursive를 업데이트 하세요!|r
|cFF11FF33읽어주셔서 감사합니다!|r]=]
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
L["DONOT_BL_PRIO"] = "우선순위 목록의 이름을 블랙리스트에 올리지 마세요."
L["DONT_SHOOT_THE_MESSENGER"] = "Decursive는 단지 문제를 보고하는 것입니다. 그래서, 메신저와 주소를 발송하지 않고 실제 문제를 해결합니다."
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
L["HIDESHOW_BUTTONS"] = "버튼 표시/숨김 및 \"Decursive\" 바 고정/고정해제"
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
L["IGNORE_STEALTH"] = "은신한 유닛 무시"
L["IS_HERE_MSG"] = "Decursive가 초기화되었습니다. 기억하는 설정을 확인하세요. (/decursive)"
L["LIST_ENTRY_ACTIONS"] = [=[|cFF33AA33[CTRL]|r 클릭: 이 플레이어 제거
|cFF33AA33좌|r-클릭: 이 플레이어를 위로
|cFF33AA33우|r-클릭: 이 플레이어를 아래로
|cFF33AA33[SHIFT] 좌|r-클릭: 이 플레이어를 최상단에 놓음
|cFF33AA33[SHIFT] 우|r-클릭: 이 플레이어를 맨 최하단에 놓음]=]
L["MACROKEYALREADYMAPPED"] = [=[경고: Decursive 매크로에 지정한 [%s]키는 '%s'|1을;를; 위해 지정되어 있습니다.
당신이 매크로에 다른 키를 지정하면 Decursive는 이전 설정을 복원할 것입니다.]=]
L["MACROKEYMAPPINGFAILED"] = "[%s] 키는 Decursive 매크로로 지정할 수 없습니다!"
L["MACROKEYMAPPINGSUCCESS"] = "[%s] 키가 Decursive 매크로로 성공적으로 지정되었습니다."
L["MACROKEYNOTMAPPED"] = "Decursive 마우스오버 매크로는 지정된 키가 없습니다, '매크로' 설정을 보시면 키를 지정할 수 있습니다!"
L["MAGIC"] = "마법"
L["MAGICCHARMED"] = "마법 정화"
L["MISSINGUNIT"] = "실패한 유닛"
L["NEW_VERSION_ALERT"] = [=[새로운 버전의 Decursive가 발견됨: |cFFEE7722%q|r 배포중 |cFFEE7722%s|r!


|cFFFF0000WoWAce.com|r에 방문하여 다운로드 하세요!
--------]=]
L["NORMAL"] = "정상"
L["NOSPELL"] = "유효한 주문 없음"
L["OPT_ABOLISHCHECK_DESC"] = "'해제' 주문을 가진 유닛을 표시하고 치료할지 선택합니다."
L["OPT_ABOUT"] = "관하여"
L["OPT_ADD_A_CUSTOM_SPELL"] = "사용자정의 주문 / 아이템 추가"
L["OPT_ADD_A_CUSTOM_SPELL_DESC"] = "여기에 주문 또는 사용 가능한 아이템을 끌어다 놓습니다. 그것의 이름, 숫자 ID를 직접 쓰거나 쉬프트-클릭을 사용할 수도 있습니다."
L["OPT_ADDDEBUFF"] = "사용자정의 피해 추가"
L["OPT_ADDDEBUFF_DESC"] = "이 목록에 새로운 피해 추가"
L["OPT_ADDDEBUFF_USAGE"] = "<피해 주문ID> (WoWHead.com에서 주문ID를 찾을 수 있습니다.)"
L["OPT_ADDDEBUFFFHIST"] = "최근 해제한 피해 추가"
L["OPT_ADDDEBUFFFHIST_DESC"] = "최근에 해제한 피해의 기록을 사용하여 피해를 추가합니다."
L["OPT_ADVDISP"] = "고급 표시 설정"
L["OPT_ADVDISP_DESC"] = "각 MUF 사이의 공간을 설정하기 위해 테두리와 중앙의 투명도를 별도로 설정할 수 있습니다."
L["OPT_AFFLICTEDBYSKIPPED"] = "%s|1이;가; %s|1으로;로; 피해를 입으면 예외 처리합니다."
L["OPT_ALLOWMACROEDIT"] = "매크로 편집 허용"
L["OPT_ALLOWMACROEDIT_DESC"] = "Decursive가 매크로를 업데이트하여 원하는대로 편집 할 수 없도록 하려면 이 옵션을 사용합니다."
L["OPT_ALWAYSIGNORE"] = "전투 중이 아닐 때도 무시"
L["OPT_ALWAYSIGNORE_DESC"] = "선택 시 해당 디버프는 전투 중이 아닐때도 무시됩니다."
L["OPT_AMOUNT_AFFLIC_DESC"] = "실시간 목록에 표시 할 저주의 최대 갯수를 정의합니다."
L["OPT_ANCHOR_DESC"] = "사용자정의 메세지 프레임의 기준을 표시합니다."
L["OPT_AUTOHIDEMFS"] = "MUF 숨김 시기:"
L["OPT_AUTOHIDEMFS_DESC"] = "MUF 창을 자동으로 숨길시기를 선택하세요."
L["OPT_BLACKLENTGH_DESC"] = "누군가가 블랙리스트에 머무는 시간을 정의합니다."
L["OPT_BORDERTRANSP"] = "테두리 투명도"
L["OPT_BORDERTRANSP_DESC"] = "테두리의 투명도를 설정합니다."
L["OPT_CENTERTEXT"] = "중앙 카운터:"
L["OPT_CENTERTEXT_DESC"] = [=[각 MUF 중앙에서 가장 높은 우선순위에 따른 정보를 표시합니다.

다음 중 하나:
- 자연 만료 전 남은 시간
- 피해를 받은 후 경과 된 시간
- 중첩 숫자]=]
L["OPT_CENTERTEXT_DISABLED"] = "사용 안 함"
L["OPT_CENTERTEXT_ELAPSED"] = "경과 시간"
L["OPT_CENTERTEXT_STACKS"] = "중첩 수"
L["OPT_CENTERTEXT_TIMELEFT"] = "남은 시간"
L["OPT_CENTERTRANSP"] = "중앙 투명도"
L["OPT_CENTERTRANSP_DESC"] = "가운데의 투명도를 설정합니다."
L["OPT_CHARMEDCHECK_DESC"] = "선택 시 지배에 걸린 대상을 표시하고 변이합니다."
L["OPT_CHATFRAME_DESC"] = "Decursive의 메세지가 기본 대화창에 표시됩니다."
L["OPT_CHECKOTHERPLAYERS"] = "다른 플레이어 확인"
L["OPT_CHECKOTHERPLAYERS_DESC"] = "당신이 현재 속한 길드 또는 그룹 플레이어의 Decursive 버전을 표시합니다. (Decursive 2.4.6 이전 버전은 표시할 수 없습니다.)"
L["OPT_CMD_DISBLED"] = "사용안함"
L["OPT_CMD_ENABLED"] = "사용함"
L["OPT_CREATE_VIRTUAL_DEBUFF"] = "가상 피해 테스트 생성"
L["OPT_CREATE_VIRTUAL_DEBUFF_DESC"] = "피해가 발생하면 Decursive에서 어떻게 보여질 지 봅니다."
L["OPT_CURE_PRIORITY_NUM"] = "우선순위 #%d"
L["OPT_CUREPETS_DESC"] = "소환수를 관리하고 해제합니다."
L["OPT_CURINGOPTIONS"] = "해제 옵션"
L["OPT_CURINGOPTIONS_DESC"] = "각 피해 형식에 대한 우선순위 변경 설정을 포함한 해제 옵션입니다."
L["OPT_CURINGOPTIONS_EXPLANATION"] = [=[치료하려는 피해의 유형을 선택하십시오. 체크되지 않은 유형은 Decursive에서 완전히 무시됩니다.

녹색 숫자는 각 피해 유형과 관련된 우선 순위를 나타냅니다. 이 우선 순위에 따라 다음 옵션이 결정됩니다.:

- 어떤 피해 유형도 Decursive는 플레이어에 몇개의 피해 유형이 있는 경우 먼저 표시됩니다.

- 각 피해 유형과 관련된 색상 및 단축키 지정.

(우선 순위를 변경하려면 모든 확인란의 선택을 취소 한 다음 원하는 우선 순위대로 선택하십시오.)]=]
L["OPT_CURINGORDEROPTIONS"] = "피해 유형과 우선순위"
L["OPT_CURSECHECK_DESC"] = "선택하면 저주에 걸린 대상을 표시하고 치료할 수 있습니다."
L["OPT_CUSTOM_SPELL_ALLOW_EDITING"] = "위 주문에 대해 내부 매크로 편집 허용"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING_DESC"] = [=[Decursive가 사용자 주문을 추가하여 사용할 내부 매크로를 편집하려면 이것을 선택하세요.

참고 : 이것을 체크하면 Decursive가 관리하는 주문을 수정할 수 있습니다.

주문이 이미 목록에 있으면 매크로 편집 사용 전 해당 주문을 제거해야 합니다.

(---고급 사용자 전용---)]=]
L["OPT_CUSTOM_SPELL_CURE_TYPES"] = "피해 유형"
L["OPT_CUSTOM_SPELL_IS_DEFAULT"] = "이 주문은 Decursive 자동 구성설정의 일부입니다. 만약 이 주문이 올바르게 작동하지않으면, Decursive 동작 기본값을 되돌려 삭제 또는 비활성할 수 있습니다."
L["OPT_CUSTOM_SPELL_ISPET"] = "소환수 능력"
L["OPT_CUSTOM_SPELL_ISPET_DESC"] = "만약 이것이 당신의 소환수 중 하나에 속하는 능력이라면 이것을 체크해서 Decursive가 그것을 정확히 감지하고 시전할 수 있도록 합니다."
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
L["OPT_CUSTOM_SPELL_PRIORITY_DESC"] = [=[각각의 주문으로 동일한 피해 유형을 치료할 수 있으면, 높은 우선순위부터 우선 치료하게 됩니다.

Decursive에 의해 관리되는 기본 기능은 0에서 9까지의 우선순위를 가지고 있다는 점에 참고하세요.

따라서, 만약 사용자정의 주문에 낮은 우선순위를 부여하면, 그것은 기본 기능을 사용할 수 없는 경우에만 선택됩니다.]=]
L["OPT_CUSTOM_SPELL_UNAVAILABLE"] = "사용할 수 없음"
L["OPT_CUSTOM_SPELL_UNIT_FILTER"] = "유닛 필터링"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_DESC"] = "이 주문을 쓸 수 있는 유닛을 고릅니다."
L["OPT_CUSTOM_SPELL_UNIT_FILTER_NONE"] = "모든 유닛"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_NONPLAYER"] = "다른 유닛만"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_PLAYER"] = "플레이어만"
L["OPT_CUSTOMSPELLS"] = "사용자 주문 / 아이템"
L["OPT_CUSTOMSPELLS_DESC"] = [=[여기에 Decursive의 자동 구성을 확장하기 위해 주문을 추가 할 수 있습니다.
사용자정의 주문은 항상 높은 우선순위를 갖으며 기본 주문을 재정의하고 대체합니다. (만약 당신 캐릭터가 그 주문을 사용할 수 있으면)
]=]
L["OPT_CUSTOMSPELLS_EFFECTIVE_ASSIGNMENTS"] = "효과적인 주문 할당:"
L["OPT_DEBCHECKEDBYDEF"] = [=[
기본값으로 설정됨]=]
L["OPT_DEBUFFENTRY_DESC"] = "이 피해로 피해를 입을 때 전투 중 무시할 직업을 선택하세요."
L["OPT_DEBUFFFILTER"] = "피해 필터링"
L["OPT_DEBUFFFILTER_DESC"] = "전투 중에 이름과 직업별로 필터링 할 피해를 선택하세요."
L["OPT_DELETE_A_CUSTOM_SPELL"] = "삭제"
L["OPT_DISABLEABOLISH"] = "'무효화' 주문은 사용할 수 없음"
L["OPT_DISABLEABOLISH_DESC"] = "만약 사용시, Decursive는 '무효화'와 동등 이상의 '질병 해제'나 '독 해제'를 선호할 것입니다."
L["OPT_DISABLEMACROCREATION"] = "매크로 생성 사용 안 함"
L["OPT_DISABLEMACROCREATION_DESC"] = "Decursive 매크로를 더 이상 생성 또는 유지할 수 없습니다."
L["OPT_DISEASECHECK_DESC"] = "선택 시 질병에 걸린 대상을 표시하고 치료합니다."
L["OPT_DISPLAYOPTIONS"] = "디스플레이 옵션"
L["OPT_DONOTBLPRIO_DESC"] = "우선순위가 지정된 유닛은 블랙리스트에 포함되지 않습니다."
L["OPT_ENABLE_A_CUSTOM_SPELL"] = "사용"
L["OPT_ENABLE_LIVELIST"] = "실시간 목록 사용"
L["OPT_ENABLE_LIVELIST_DESC"] = [=[피해를 받는 사람들의 유익한 목록을 표시합니다.

Decursive 바를 움직여 이 목록을 이동할 수 있습니다. (/DCRSHOW를 입력해 해당 바를 표시)]=]
L["OPT_ENABLEDEBUG"] = "디버깅 사용"
L["OPT_ENABLEDEBUG_DESC"] = "디버깅 출력 사용"
L["OPT_ENABLEDECURSIVE"] = "Decursive 사용"
L["OPT_FILTERED_DEBUFF_RENAMED"] = "주문ID %d의 필터링된 피해 \"%s\"|1이;가; 자동으로 \"%s\"|1으로;로; 이름이 변경되었습니다."
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
L["OPT_ISNOTVALID_SPELLID"] = "유효한 주문ID가 아닙니다."
L["OPT_LIVELIST"] = "실시간 목록"
L["OPT_LIVELIST_DESC"] = [=[이것은 ""Decursive" 바 아래에 피해받은 유닛의 목록과 관련한 설정입니다.

이 목록을 움직이려면 작은 "Decursive" 프레임을 이동해야 합니다. 아래 설정 중 일부는 이 프레임이 표시될 때만 사용할 수 있습니다. 채팅창에 |cff20CC20/DCRSHOW|r를 입력해 표시합니다.

우선 실시간 목록의 위치, 크기, 투명도를 설정하고 나서 |cff20CC20/DCRHIDE|r를 입력하면 Decursive의 프레임을 안전하게 숨길 수 있습니다.]=]
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
L["OPT_MUFSVERTICALDISPLAY_DESC"] = "작은 유닛프레임 창을 세로로 늘림"
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
L["OPT_SETAFFTYPECOLOR_DESC"] = "\"%s\" 피해 유형의 색상을 설정하십시오. (작은 유닛프레임의 툴팁과 실시간 목록에 나타남)"
L["OPT_SHOW_STEALTH_STATUS"] = "은신 상태 보기"
L["OPT_SHOW_STEALTH_STATUS_DESC"] = "플레이어가 은신중이면, 그 작은 유닛프레임은 특정한 색상 발현함"
L["OPT_SHOWBORDER"] = "직업 색상 테두리 표시"
L["OPT_SHOWBORDER_DESC"] = "작은 유닛프레임에 유닛의 직업에 따른 색상을 테두리로 표시합니다."
L["OPT_SHOWHELP"] = "도움말 표시"
L["OPT_SHOWHELP_DESC"] = "작은 유닛 프레임에 마우스를 올리면 정보 툴팁을 표시합니다."
L["OPT_SHOWMFS"] = "작은 유닛 프레임(MUF) 표시"
L["OPT_SHOWMFS_DESC"] = "클릭으로 해제하려면 반드시 활성화 되어야 합니다."
L["OPT_SHOWMINIMAPICON"] = "미니맵 아이콘"
L["OPT_SHOWMINIMAPICON_DESC"] = "미니맵 아이콘을 표시합니다."
L["OPT_SHOWTOOLTIP_DESC"] = "실시간 목록과 작은 유닛 프레임에 디버프에 대한 자세한 툴팁을 표시합니다."
L["OPT_SPELL_DESCRIPTION_LOADING"] = "설명을 불러오는중... 나중에 다시 시도하세요."
L["OPT_SPELL_DESCRIPTION_UNAVAILABLE"] = "설명을 사용할 수 없음"
L["OPT_SPELLID_MISSING_READD"] = "이 메시지 대신 적절한 설명을 보려면 주문ID를 사용하여 이 피해를 다시 추가해야 합니다."
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
L["OPT_TIEXYSPACING_DESC"] = "작은 유닛프레임의 수평과 수직 간격이 같아 집니다."
L["OPT_UNITPERLINES"] = "한 줄에 표시할 유닛의 갯수"
L["OPT_UNITPERLINES_DESC"] = "한 줄에 표시할 작은 유닛프레임의 최대 갯수를 지정합니다."
L["OPT_USERDEBUFF"] = "해당 디버프는 Decursive의 기본 디버프가 아닙니다."
L["OPT_XSPACING"] = "수평 간격"
L["OPT_XSPACING_DESC"] = "작은 유닛프레임 사이의 수평 공간을 설정합니다."
L["OPT_YSPACING"] = "수직 간격"
L["OPT_YSPACING_DESC"] = "작은 유닛프레임 사이의 수직 공간을 설정합니다."
L["OPTION_MENU"] = "Decursive 설정 메뉴"
L["PLAY_SOUND"] = "치료할 누군가 있으면 소리를 재생합니다."
L["POISON"] = "독"
L["POPULATE"] = "p"
L["POPULATE_LIST"] = "Decursive 목록을 빠르게 채움"
L["PRINT_CHATFRAME"] = "기본 채팅창에 메세지 출력"
L["PRINT_CUSTOM"] = "창에서 메세지 출력"
L["PRINT_ERRORS"] = "오류 메세지 출력"
L["PRIORITY_LIST"] = "Decursive 우선순위 목록"
L["PRIORITY_SHOW"] = "P"
L["RANDOM_ORDER"] = "무작위 순서로 치료"
L["REVERSE_LIVELIST"] = "실시간 목록 표시 반전"
L["SCAN_LENGTH"] = "실시간 탐색 사이의 초 : "
L["SHIFT"] = "Shift"
L["SHOW_MSG"] = "Decursive의 프레임을 표시하려면 /dcrshow을 입력하세요."
L["SHOW_TOOLTIP"] = "피해를 입은 유닛에 툴팁 표시"
L["SKIP_LIST_STR"] = "Decursive 예외 목록"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "%s 주문 발견!"
L["STEALTHED"] = "은신상태"
L["STR_CLOSE"] = "닫기"
L["STR_DCR_PRIO"] = "Decursive 우선순위"
L["STR_DCR_SKIP"] = "Decursive 예외"
L["STR_GROUP"] = "그룹"
L["STR_OPTIONS"] = "Decursive 설정"
L["STR_OTHER"] = "기타"
L["STR_POP"] = "추가 목록"
L["STR_QUICK_POP"] = "빠른 채움"
L["SUCCESSCAST"] = "|cFF22FFFF%s %s|r|1으로;로; %s |cFF00AA00치료 성공!|r"
L["TARGETUNIT"] = "대상 유닛"
L["TIE_LIVELIST"] = "실시간 목록 표시를 DCR 창과 함께 표시"
L["TOC_VERSION_EXPIRED"] = "Decursive 버전이 만료되었습니다. 이 버전의 Decursive는 당신이 사용하고 있는 World of Warcraft의 버전보다 먼저 출시되었습니다. 잠재적인 비호환성 및 런타임 오류를 수정하려면 Decursive를 업데이트해야 합니다. curse.com으로 이동하여 'Decursive'를 검색하거나 Curse의 클라이언트를 사용하여 모든 추가 기능을 한 번에 업데이트하세요. 이 안내는 2일 후에 다시 표시될 것입니다."
L["TOO_MANY_ERRORS_ALERT"] = [=[사용자 인터페이스(%d개의 오류)에 많은 Lua 오류가 있습니다. 당신의 게임 환경이 타락하였습니다. 이 메시지를 해제하려면 실패한 애드온을 비활성화하거나 업데이트하십시오.
Lua 오류를 보고하기 위해 다음의 설정을 할 수 있습니다. (/console scriptErrors 1)]=]
L["TOOFAR"] = "거리 벗어남"
L["UNITSTATUS"] = "유닛 상태: "
L["UNSTABLERELEASE"] = "비안정화판 배포"



T._LoadedFiles["koKR.lua"] = "2.7.7";
