if GetLocale() ~= "koKR" then return end
local L

-- Lord Kazzak (Badlands)
L = DBM:GetModLocalization("KazzakClassic")

L:SetGeneralLocalization{
	name = "군주 카자크"
}

L:SetMiscLocalization({
	Pull		= "불타는 군단과 킬제덴을 위하여!"
})

-- Azuregos (Azshara)
L = DBM:GetModLocalization("Azuregos")

L:SetGeneralLocalization{
	name = "아주어고스"
}

L:SetMiscLocalization({
	Pull		= "여기는 내가 지킨다. 어느 누구도 비전술의 신비를 건드리지 못할 것이다."
})

-- Taerar (Ashenvale)
L = DBM:GetModLocalization("Taerar")

L:SetGeneralLocalization{
	name = "타에라"
}

L:SetMiscLocalization({
	Pull		= "평화란 부질없는 꿈일 뿐! 이 세상은 악몽이 지배할 것이다!"
})

-- Ysondre (Feralas)
L = DBM:GetModLocalization("Ysondre")

L:SetGeneralLocalization{
	name = "이손드레"
}

L:SetMiscLocalization({
	Pull		= "생명의 끈이 끊어졌다! 꿈꾸는 자들이 복수하는 것이 틀림없다!"
})

-- Lethon (Hinterlands)
L = DBM:GetModLocalization("Lethon")

L:SetGeneralLocalization{
	name = "레손"
}

L:SetMiscLocalization({
--	Pull		= "The strands of LIFE have been severed! The Dreamers must be avenged!"--Does not have one :\
})

-- Emeriss (Duskwood)
L = DBM:GetModLocalization("Emeriss")

L:SetGeneralLocalization{
	name = "에메리스"
}

L:SetMiscLocalization({
	Pull		= "희망은 영혼의 병! 이 땅은 말라 죽을 것이다!"
})
