if GetLocale() ~= "frFR" then return end
local L

-------------------
--  Venoxis  --
-------------------
L = DBM:GetModLocalization("Venoxis")

L:SetGeneralLocalization{
	name = "Grand prêtre Venoxis"
}

-------------------
--  Jeklik  --
-------------------
L = DBM:GetModLocalization("Jeklik")

L:SetGeneralLocalization{
	name = "Grande prêtresse Jeklik"
}

-------------------
--  Marli  --
-------------------
L = DBM:GetModLocalization("Marli")

L:SetGeneralLocalization{
	name = "Grande prêtresse Mar'li"
}

-------------------
--  Thekal  --
-------------------
L = DBM:GetModLocalization("Thekal")

L:SetGeneralLocalization{
	name = "Grand prêtre Thekal"
}

L:SetWarningLocalization({
	WarnSimulKill	= "Premier séide mort - Résurrection en ~ 15 secondes"
})

L:SetTimerLocalization({
	TimerSimulKill	= "Résurrection"
})

L:SetOptionLocalization({
	WarnSimulKill	= "Annoncez le premier séide mort",
	TimerSimulKill	= "Montre le timer pour la résurrection des prêtres"
})

L:SetMiscLocalization({
	PriestDied	= "%s muere.",
	YellPhase2	= "Shirvallah, ¡lléname de IRA!",
	YellKill	= "¡Hakkar ya no me controla! ¡Por fin algo de paz!",
	Thekal		= "Grand prêtre Thekal",
	Zath		= "Zélote Zath",
	LorKhan		= "Zélote Lor'Khan"
})

-------------------
--  Arlokk  --
-------------------
L = DBM:GetModLocalization("Arlokk")

L:SetGeneralLocalization{
	name = "Grande prêtresse Arlokk"
}

-------------------
--  Hakkar  --
-------------------
L = DBM:GetModLocalization("Hakkar")

L:SetGeneralLocalization{
	name = "Hakkar"
}

-------------------
--  Bloodlord  --
-------------------
L = DBM:GetModLocalization("Bloodlord")

L:SetGeneralLocalization{
	name = "Seigneur sanglant Mandokir"
}
L:SetMiscLocalization{
	Bloodlord 	= "Seigneur sanglant Mandokir",
	Ohgan		= "Ohgan",
	GazeYell	= "I'm watching you"
}

-------------------
--  Edge of Madness  --
-------------------
L = DBM:GetModLocalization("EdgeOfMadness")

L:SetGeneralLocalization{
	name = "Frontière de la folie"
}
L:SetMiscLocalization{
	Hazzarah = "Hazza'rah",
	Renataki = "Renataki",
	Wushoolay = "Wushoolay",
	Grilek = "Gri'lek"
}

-------------------
--  Gahz'ranka  --
-------------------
L = DBM:GetModLocalization("Gahzranka")

L:SetGeneralLocalization{
	name = "Gahz'ranka"
}

-------------------
--  Jindo  --
-------------------
L = DBM:GetModLocalization("Jindo")

L:SetGeneralLocalization{
	name = "Jin'do le Maléficieur"
}
