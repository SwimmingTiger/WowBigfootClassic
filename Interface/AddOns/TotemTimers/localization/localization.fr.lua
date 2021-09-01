if( GetLocale() == "frFR" ) then
_G["BINDING_HEADER_TOTEMTIMERSHEADER"] = "TotemTimers"
_G["BINDING_NAME_TOTEMTIMERSAIR"] = "Cast totem de l'air activés"
_G["BINDING_NAME_TOTEMTIMERSAIRMENU"] = "Ouvrir le menu de totem de l'air"
_G["BINDING_NAME_TOTEMTIMERSEARTH"] = "lance et active totem de terre"
_G["BINDING_NAME_TOTEMTIMERSEARTHMENU"] = "Ouvrir le menu du totem de terre"
_G["BINDING_NAME_TOTEMTIMERSEARTHSHIELDLEFT"] = "Bouclier de terre clic gauche"
_G["BINDING_NAME_TOTEMTIMERSEARTHSHIELDMIDDLE"] = "Bouclier de terre clic milieu"
_G["BINDING_NAME_TOTEMTIMERSEARTHSHIELDRIGHT"] = "Bouclier de terre clic droit"
_G["BINDING_NAME_TOTEMTIMERSFIRE"] = "lance et active le totem de feu"
_G["BINDING_NAME_TOTEMTIMERSFIREMENU"] = "Ouvrir le menu du Totem de feu"
_G["BINDING_NAME_TOTEMTIMERSWATER"] = "lance et active totem de l'air"
_G["BINDING_NAME_TOTEMTIMERSWATERMENU"] = "Ouvrir le menu totem de l'eau"
_G["BINDING_NAME_TOTEMTIMERSWEAPONBUFF1"] = "Arme Buff 1"
_G["BINDING_NAME_TOTEMTIMERSWEAPONBUFF2"] = "Arme Buff 2"

end


local L = LibStub("AceLocale-3.0"):NewLocale("TotemTimers", "frFR")
if not L then return end

L["Air Button"] = "bouton Totem de l'air"
L["Cooldown"] = "Recharge" -- Needs review
L["Ctrl-Leftclick to remove weapon buffs"] = "Ctrl-clic gauche pour supprimer les améliorations d'armes"
L["Delete Set"] = "Supprimer l'ensemble des Totem %u?"
L["Earth Button"] = "bouton Totem de la Terre"
L["Fire Button"] = "Bouton feu"
L["Leftclick to cast %s"] = "Clic gauche pour lancer %s"
L["Leftclick to cast spell"] = "Clic gauche pour lancer les sorts"
L["Leftclick to load totem set"] = "Clic gauche pour charger le set de vos totems sur %s" -- Needs review
L["Leftclick to open totem set menu"] = "Clic gauche pour ouvrir votre set de totem"
L["Long Cooldown"] = "Recharge longue" -- Needs review
L["Maelstrom Notifier"] = "Maelstrom ready!"
L["Middleclick to cast %s"] = "Clic milieu pour lancer %s"
L["Next leftclick casts %s"] = "Clic gauche suivant lance %s"
L["Reset"] = "Bouton efface"
L["Rightclick to assign both %s and %s to leftclick"] = "Faites un clic droit pour assigner à la fois %s et %s au clic gauche"
L["Rightclick to assign spell to leftclick"] = "Clic droit pour assigner le sort au clic gauche"
L["Rightclick to assign totem to timer button"] = "Rightclick to assign totem to timer button" -- Requires localization
L["Rightclick to cast %s"] = "Clic droit pour lancer %s"
L["Rightclick to delete totem set"] = "Clic droit pour supprimer votre set de Totem"
L["Rightclick to save active totem configuration as set"] = "Clic droit pour enregistrer la configuration de vos totems actifs"
L["Shield removed"] = "%s enlevé"
L["Shift-Rightclick to assign spell to middleclick"] = "Maj-clic droit pour assigner le sort au clic du milieu"
L["Shift-Rightclick to assign spell to rightclick"] = "Maj-clic droit pour assigner le sort au clic droit"
L["Totem Destroyed"] = "%s a été détruit"
L["Totem Expired"] = "%s a expiré"
L["Totem Expiring"] = "%s va expirer"
L["Water Button"] = "bouton Totem de l'eau"
