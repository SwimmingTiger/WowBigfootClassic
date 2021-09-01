if( GetLocale() == "ptBR" ) then
_G["BINDING_HEADER_TOTEMTIMERSHEADER"] = "TotemTimers" -- Requires localization
_G["BINDING_NAME_TOTEMTIMERSAIR"] = "Cast active air totem" -- Requires localization
_G["BINDING_NAME_TOTEMTIMERSAIRMENU"] = "Open air totem menu" -- Requires localization
_G["BINDING_NAME_TOTEMTIMERSEARTH"] = "Cast active earth totem" -- Requires localization
_G["BINDING_NAME_TOTEMTIMERSEARTHMENU"] = "Open earth totem menu" -- Requires localization
_G["BINDING_NAME_TOTEMTIMERSEARTHSHIELDLEFT"] = "Earth Shield Leftclick" -- Requires localization
_G["BINDING_NAME_TOTEMTIMERSEARTHSHIELDMIDDLE"] = "Earth Shield Middleclick" -- Requires localization
_G["BINDING_NAME_TOTEMTIMERSEARTHSHIELDRIGHT"] = "Earth Shield Rightclick" -- Requires localization
_G["BINDING_NAME_TOTEMTIMERSFIRE"] = "Cast active fire totem" -- Requires localization
_G["BINDING_NAME_TOTEMTIMERSFIREMENU"] = "Open fire totem menu" -- Requires localization
_G["BINDING_NAME_TOTEMTIMERSWATER"] = "Cast active water totem" -- Requires localization
_G["BINDING_NAME_TOTEMTIMERSWATERMENU"] = "Open water totem menu" -- Requires localization
_G["BINDING_NAME_TOTEMTIMERSWEAPONBUFF1"] = "Weapon Buff 1" -- Requires localization
_G["BINDING_NAME_TOTEMTIMERSWEAPONBUFF2"] = "Weapon Buff 2" -- Requires localization

end

local L = LibStub("AceLocale-3.0"):NewLocale("TotemTimers", "ptBR")
if not L then return end

L["Air Button"] = "Air Button" -- Requires localization
L["Cooldown"] = "Cooldown" -- Requires localization
L["Ctrl-Leftclick to remove weapon buffs"] = "Crtl-botão esquerdo para remover buffs das armas" -- Needs review
L["Delete Set"] = "Delete Totem Set %u?" -- Requires localization
L["Earth Button"] = "Earth Button" -- Requires localization
L["Fire Button"] = "Fire Button" -- Requires localization
L["Leftclick to cast %s"] = "Leftclick to cast %s" -- Requires localization
L["Leftclick to cast spell"] = "Leftclick to cast spell" -- Requires localization
L["Leftclick to load totem set"] = "Leftclick to load totem set" -- Requires localization
L["Leftclick to open totem set menu"] = "Leftclick to open totem set menu" -- Requires localization
L["Long Cooldown"] = "Long Cooldown" -- Requires localization
L["Maelstrom Notifier"] = "Maelstrom ready!" -- Requires localization
L["Middleclick to cast %s"] = "Middleclick to cast %s" -- Requires localization
L["Next leftclick casts %s"] = "Next leftclick casts %s" -- Requires localization
L["Reset"] = "TotemTimers has been reset!" -- Requires localization
L["Rightclick to assign both %s and %s to leftclick"] = "Rightclick to assign both %s and %s to leftclick" -- Requires localization
L["Rightclick to assign spell to leftclick"] = "clique com o botão direito para atribuir feitiço ao botão direito" -- Needs review
L["Rightclick to assign totem to timer button"] = "Rightclick to assign totem to timer button" -- Requires localization
L["Rightclick to cast %s"] = "clique com o botão direito para ativar " -- Needs review
L["Rightclick to delete totem set"] = "Rightclick to delete totem set" -- Requires localization
L["Rightclick to save active totem configuration as set"] = "Rightclick to save active totem configuration as set" -- Requires localization
L["Shield removed"] = "%s removed" -- Requires localization
L["Shift-Rightclick to assign spell to middleclick"] = "shift-botão direito para atribuir feitiço ao botão do meio." -- Needs review
L["Shift-Rightclick to assign spell to rightclick"] = "Shift-Rightclick to assign spell to rightclick" -- Requires localization
L["Totem Destroyed"] = "%s has been destroyed." -- Requires localization
L["Totem Expired"] = "%s has expired" -- Requires localization
L["Totem Expiring"] = "%s about to expire" -- Requires localization
L["Water Button"] = "Water Button" -- Requires localization
