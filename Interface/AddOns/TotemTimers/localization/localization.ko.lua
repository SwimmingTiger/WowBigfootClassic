if (GetLocale() == "koKR") then
_G["BINDING_HEADER_TOTEMTIMERSHEADER"] = "TotemTimers"
_G["BINDING_NAME_TOTEMTIMERSAIR"] = "바람의 토템 시전"
_G["BINDING_NAME_TOTEMTIMERSAIRMENU"] = "바람의 토템 메뉴 열기"
_G["BINDING_NAME_TOTEMTIMERSEARTH"] = "대지의 토템 시전"
_G["BINDING_NAME_TOTEMTIMERSEARTHMENU"] = "대지의 토템 메뉴 열기"
_G["BINDING_NAME_TOTEMTIMERSEARTHSHIELDLEFT"] = "왼쪽 클릭 대지의 보호막"
_G["BINDING_NAME_TOTEMTIMERSEARTHSHIELDMIDDLE"] = "가운데 클릭 대지의 보호막"
_G["BINDING_NAME_TOTEMTIMERSEARTHSHIELDRIGHT"] = "오른쪽 클릭 대지의 보호막"
_G["BINDING_NAME_TOTEMTIMERSFIRE"] = "불의 토템 시전"
_G["BINDING_NAME_TOTEMTIMERSFIREMENU"] = "불의 토템 메뉴 열기"
_G["BINDING_NAME_TOTEMTIMERSWATER"] = "물의 토템 시전"
_G["BINDING_NAME_TOTEMTIMERSWATERMENU"] = "물의 토템 메뉴 열기"
_G["BINDING_NAME_TOTEMTIMERSWEAPONBUFF1"] = "무기 버프 1"
_G["BINDING_NAME_TOTEMTIMERSWEAPONBUFF2"] = "무기 버프 2"

end


local L = LibStub("AceLocale-3.0"):NewLocale("TotemTimers", "koKR")
if not L then return end

L["Air Button"] = "바람 버튼"
L["Cooldown"] = "재사용 대기시간" -- Needs review
L["Ctrl-Leftclick to remove weapon buffs"] = "Ctrl+왼쪽 클릭시 무기 버프 제거"
L["Delete Set"] = "토템 %u 세트를 삭제합니까?"
L["Earth Button"] = "대지 버튼"
L["Fire Button"] = "불 버튼"
L["Leftclick to cast %s"] = "왼쪽 클릭시 %s 시전"
L["Leftclick to cast spell"] = "왼쪽 클릭시 주문 시전"
L["Leftclick to load totem set"] = "왼쪽 클릭시 %s 토템 세트를 불려옵니다." -- Needs review
L["Leftclick to open totem set menu"] = "왼쪽 클릭시 토템 세트 메뉴를 엽니다."
L["Long Cooldown"] = "긴 재사용 대기시간" -- Needs review
L["Maelstrom Notifier"] = "소용돌이치는 무기 준비!"
L["Middleclick to cast %s"] = "가운데 클릭시 %s 시전"
L["Next leftclick casts %s"] = "다음 왼쪽 클릭시 %s 시전"
L["Reset"] = "TotemTimers 초기화!"
L["Rightclick to assign both %s and %s to leftclick"] = "오른쪽 클릭시 주문 지정, 왼쪽 클릭시 %s와 %s 주문 시전"
L["Rightclick to assign spell to leftclick"] = "왼쪽 클릭시 주문 지정, 오른쪽 클릭시 주문 시전"
L["Rightclick to assign totem to timer button"] = "오른쪽 클릭시 타이머 버튼에 토템 할당" -- Needs review
L["Rightclick to cast %s"] = "오른쪽 클릭시 %s 시전"
L["Rightclick to delete totem set"] = "오른쪽 클릭시 토템 세트를 삭제합니다."
L["Rightclick to save active totem configuration as set"] = "오른쪽 클릭시 세트와같은 사용한 토템 구성을 저장합니다."
L["Shield removed"] = "%s 효과가 사라졌습니다."
L["Shift-Rightclick to assign spell to middleclick"] = "Shift-오른쪽 클릭시 주문 지정, 가운데 클릭시 주문 시전"
L["Shift-Rightclick to assign spell to rightclick"] = "Shift-오른쪽 클릭시 주문 지정, 오른쪽 클릭시 주문 시전"
L["Totem Destroyed"] = "%s|1이;가; 파괴되었습니다."
L["Totem Expired"] = "%s의 지속시간이 만료되었습니다."
L["Totem Expiring"] = "%s의 지속시간이 얼마 남지 않았습니다."
L["Water Button"] = "물 버튼"
