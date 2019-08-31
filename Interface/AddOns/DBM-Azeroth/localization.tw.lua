if GetLocale() ~= "zhTW" then return end
local L

-- Lord Kazzak (Badlands)
L = DBM:GetModLocalization("KazzakClassic")

L:SetGeneralLocalization{
	name = "卡札克領主"
}

L:SetMiscLocalization({
	Pull		= "為了軍團!為了基爾加德!"
})

-- Azuregos (Azshara)
L = DBM:GetModLocalization("Azuregos")

L:SetGeneralLocalization{
	name = "艾索雷苟斯"
}

L:SetMiscLocalization({
	Pull		= "我保護著這個地方。神秘的秘法不能受到褻瀆。"
})

-- Taerar (Ashenvale)
L = DBM:GetModLocalization("Taerar")

L:SetGeneralLocalization{
	name = "泰拉爾"
}

L:SetMiscLocalization({
	Pull		= "和平不過是短暫的夢想!讓夢魘統治整個世界吧!"
})

-- Ysondre (Feralas)
L = DBM:GetModLocalization("Ysondre")

L:SetGeneralLocalization{
	name = "伊索德雷"
}

L:SetMiscLocalization({
	Pull		= "生命的希冀已被切斷!夢遊者要展開報復!"
})

-- Lethon (Hinterlands)
L = DBM:GetModLocalization("Lethon")

L:SetGeneralLocalization{
	name = "雷索"
}

-- Emeriss (Duskwood)
L = DBM:GetModLocalization("Emeriss")

L:SetGeneralLocalization{
	name = "艾莫莉絲"
}

L:SetMiscLocalization({
	Pull		= "希望是靈魂染上的疾病!這片土地應該枯竭，從此死氣騰騰!"
})
