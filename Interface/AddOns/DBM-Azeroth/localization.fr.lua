if GetLocale() ~= "frFR" then return end
local L

-- Lord Kazzak (Badlands)
L = DBM:GetModLocalization("KazzakClassic")

L:SetGeneralLocalization{
	name = "Seigneur Kazzak"
}

L:SetMiscLocalization({
	Pull		= "For the Legion! For Kil'Jaeden!"
})

-- Azuregos (Azshara)
L = DBM:GetModLocalization("Azuregos")

L:SetGeneralLocalization{
	name = "Azuregos"
}

L:SetMiscLocalization({
	Pull		= "This place is under my protection. The mysteries of the arcane shall remain inviolate."
})

-- Taerar (Ashenvale)
L = DBM:GetModLocalization("Taerar")

L:SetGeneralLocalization{
	name = "Taerar"
}

L:SetMiscLocalization({
	Pull		= "Peace is but a fleeting dream! Let the NIGHTMARE reign!"
})

-- Ysondre (Feralas)
L = DBM:GetModLocalization("Ysondre")

L:SetGeneralLocalization{
	name = "Ysondre"
}

L:SetMiscLocalization({
	Pull		= "Les fils de la VIE ont été coupés ! Les Rêveurs doivent être vengés !"
})

-- Lethon (Hinterlands)
L = DBM:GetModLocalization("Lethon")

L:SetGeneralLocalization{
	name = "Léthon"
}

L:SetMiscLocalization({
	Pull		= "Je sens l'OMBRE dans vos cœurs. Il ne peut y avoir de repos pour les vilains !"
})

-- Emeriss (Duskwood)
L = DBM:GetModLocalization("Emeriss")

L:SetGeneralLocalization{
	name = "Emeriss"
}

L:SetMiscLocalization({
	Pull		= "L'espoir est une MALADIE de l'âme ! Ces terres vont flétrir et mourir !"
})
