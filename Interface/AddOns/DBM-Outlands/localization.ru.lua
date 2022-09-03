if GetLocale() ~= "ruRU" then return end

local L

--Maulgar
L = DBM:GetModLocalization("Maulgar")

L:SetGeneralLocalization{
	name = "Король Молгар"
}


--Gruul the Dragonkiller
L = DBM:GetModLocalization("Gruul")

L:SetGeneralLocalization{
	name = "Груул Драконобой"
}

L:SetWarningLocalization{
	WarnGrowth	= "%s (%d)"
}

L:SetOptionLocalization{
	WarnGrowth		= "Показывать предупреждение для $spell:36300",
	RangeDistance	= "Фрейм дистанции для |cff71d5ff|Hspell:33654|hДробление|h|r",
	Smaller			= "Маленькая дистанция (11)",
	Safe			= "Безопасная дистанция (18)"
}

-- Magtheridon
L = DBM:GetModLocalization("Magtheridon")

L:SetGeneralLocalization{
	name = "Магтеридон"
}

L:SetTimerLocalization{
	timerP2	= "Фаза 2"
}

L:SetOptionLocalization{
	timerP2	= "Показывать таймер начала Фазы 2"
}

L:SetMiscLocalization{
	DBM_MAG_EMOTE_PULL		= "Сдерживающая сила %sа начинает ослабевать!",
	DBM_MAG_YELL_PHASE2		= "Я... свободен!",
	DBM_MAG_YELL_PHASE3		= "Пусть стены темницы содрогнутся... и падут!"
}

-- Doom Lord Kazzak
L = DBM:GetModLocalization("Kazzak")

L:SetGeneralLocalization{
	name = "Владыка судеб Каззак"
}

L:SetMiscLocalization{
	DBM_KAZZAK_EMOTE_ENRAGE		= "%s впадает в бешенство!"--Probalby won't be used, at least not long. Once spellid replaces it
}

-- Doomwalker
L = DBM:GetModLocalization("Doomwalker")

L:SetGeneralLocalization{
	name = "Судьболом"
}

L:SetMiscLocalization{
	DBM_DOOMW_EMOTE_ENRAGE	= "%s впадает в бешенство!"--Probalby won't be used, at least not long. Once spellid replaces it
}

-- Quest
L = DBM:GetModLocalization("Quest")

L:SetGeneralLocalization{
	name = "Квест",
}

L:SetOptionLocalization{
	Timers = "Показывать таймеры для некоторых квестов сопровождений"
}
