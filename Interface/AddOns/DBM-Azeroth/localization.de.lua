if GetLocale() ~= "deDE" then return end
local L

-- Lord Kazzak (Badlands)
L = DBM:GetModLocalization("KazzakClassic")

L:SetGeneralLocalization{
	name = "Lord Kazzak"
}

L:SetMiscLocalization({
	Pull		= "Für die Legion! Für Kil'jaeden!"
})

-- Azuregos (Azshara)
L = DBM:GetModLocalization("Azuregos")

L:SetGeneralLocalization{
	name = "Azuregos"
}

L:SetMiscLocalization({
	Pull		= "Dieser Ort steht unter meinem Schutz. Die Mysterien des Arkanen werden unberührt bleiben."
})

-- Taerar (Ashenvale)
L = DBM:GetModLocalization("Taerar")

L:SetGeneralLocalization{
	name = "Taerar"
}

L:SetMiscLocalization({
	Pull		= "Frieden ist nur ein flüchtiger Traum! Möge der Alptraum herrschen!"
})

-- Ysondre (Feralas)
L = DBM:GetModLocalization("Ysondre")

L:SetGeneralLocalization{
	name = "Ysondre"
}

L:SetMiscLocalization({
	Pull		= "Die Fäden des Lebens wurden durchtrennt! Die Träumer müssen gerächt werden."
})

-- Lethon (Hinterlands)
L = DBM:GetModLocalization("Lethon")

L:SetGeneralLocalization{
	name = "Lethon"
}

L:SetMiscLocalization({
--	Pull		= "Ich spüre die Schatten in Euren Herzen. Die Verdammten werden niemals ruhen!"
})

-- Emeriss (Duskwood)
L = DBM:GetModLocalization("Emeriss")

L:SetGeneralLocalization{
	name = "Smariss"
}

L:SetMiscLocalization({
	Pull		= "Hoffnung ist ein Gebrechen der Seele! Dieses Land wird verdorren und vergehen!"
})
