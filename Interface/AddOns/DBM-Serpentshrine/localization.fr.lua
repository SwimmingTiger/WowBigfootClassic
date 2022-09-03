if GetLocale() ~= "frFR" then return end
local L

---------------------------
--  Hydross the Unstable --
---------------------------
--L = DBM:GetModLocalization("Hydross")

-----------------------
--  The Lurker Below --
-----------------------
L = DBM:GetModLocalization("LurkerBelow")

L:SetGeneralLocalization({
	name = "Le Rôdeur d'En bas"
})

--------------------------
--  Leotheras the Blind --
--------------------------
--L = DBM:GetModLocalization("Leotheras")

-----------------------------
--  Fathom-Lord Karathress --
-----------------------------
--L = DBM:GetModLocalization("Fathomlord")

--------------------------
--  Morogrim Tidewalker --
--------------------------
--L = DBM:GetModLocalization("Tidewalker")

-----------------
--  Lady Vashj --
-----------------
L = DBM:GetModLocalization("Vashj")

L:SetMiscLocalization({
	DBM_VASHJ_YELL_PHASE2	= "L'heure est venue ! N'épargnez personne !",
	DBM_VASHJ_YELL_PHASE3	= "Il faudrait peut-être vous mettre à l'abri.",
	LootMsg					= "([^%s]+).*Hitem:(%d+)"
})
