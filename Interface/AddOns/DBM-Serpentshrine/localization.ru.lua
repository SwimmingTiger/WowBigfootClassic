if GetLocale() ~= "ruRU" then return end
local L

---------------------------
--  Hydross the Unstable --
---------------------------
L = DBM:GetModLocalization("Hydross")

L:SetGeneralLocalization{
	name = "Гидросс Нестабильный"
}

L:SetWarningLocalization{
	WarnMark 		= "%s : %s",
	WarnPhase		= "Фаза %s",
	SpecWarnMark	= "%s : %s"
}

L:SetTimerLocalization{
	TimerMark	= "Следующий %s : %s"
}

L:SetOptionLocalization{
	WarnMark		= "Показывать предупреждения о Знаках",
	WarnPhase		= "Показывать предупреждение о следующей фазе",
	SpecWarnMark	= "Показывать предупреждение о 100% уроне от Знака",
	TimerMark		= "Показывать таймер о следующих Знаках"
}

L:SetMiscLocalization{
	Frost	= "Льда",
	Nature	= "Природы"
}

-----------------------
--  The Lurker Below --
-----------------------
L = DBM:GetModLocalization("LurkerBelow")

L:SetGeneralLocalization{
	name = "Скрытень из глубин"
}

L:SetWarningLocalization{
	WarnSubmerge		= "Погружение",
	WarnEmerge			= "Появление"
}

L:SetTimerLocalization{
	TimerSubmerge		= "Погружение КД",
	TimerEmerge			= "Появление КД"
}

L:SetOptionLocalization{
	WarnSubmerge		= "Показывать предупреждение о погружении",
	WarnEmerge			= "Показывать предупреждение о появлении",
	TimerSubmerge		= "Показывать таймер о погружении",
	TimerEmerge			= "Показывать таймер о появлении"
}

--------------------------
--  Leotheras the Blind --
--------------------------
L = DBM:GetModLocalization("Leotheras")

L:SetGeneralLocalization{
	name = "Леотерас Слепец"
}

L:SetWarningLocalization{
	WarnPhase		= "Фаза %s"
}

L:SetTimerLocalization{
	TimerPhase	= "Следующая Фаза %s"
}

L:SetOptionLocalization{
	WarnPhase		= "Показывать предупреждение о следующей фазе",
	TimerPhase		= "Показывать таймер о следующей фазе"
}

L:SetMiscLocalization{
	Human		= "Человека",
	Demon		= "Демона",
	YellDemon	= "Прочь, жалкий эльф. Настало мое время!",
	YellPhase2	= "Нет... нет! Что вы наделали? Я — главный! Слышишь меня? Я... Ааааах! Мне его... не удержать."
}

-----------------------------
--  Fathom-Lord Karathress --
-----------------------------
L = DBM:GetModLocalization("Fathomlord")

L:SetGeneralLocalization{
	name = "Повелитель глубин Каратресс"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	Caribdis	= "Хранительница глубин Карибдис",
	Tidalvess	= "Хранитель глубин Волниис",
	Sharkkis	= "Хранитель глубин Шарккис"
}

--------------------------
--  Morogrim Tidewalker --
--------------------------
L = DBM:GetModLocalization("Tidewalker")

L:SetGeneralLocalization{
	name = "Морогрим Волноступ"
}

L:SetWarningLocalization{
	SpecWarnMurlocs	= "Мурлоки идут!"
}

L:SetTimerLocalization{
	TimerMurlocs	= "Мурлоки"
}

L:SetOptionLocalization{
	SpecWarnMurlocs	= "Показывать специальное предупреждение о появлении Мурлоков",
	TimerMurlocs	= "Показывать таймер о появлении Мурлоков",
	GraveIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(38049)
}

L:SetMiscLocalization{
}

-----------------
--  Lady Vashj --
-----------------
L = DBM:GetModLocalization("Vashj")

L:SetGeneralLocalization{
	name = "Леди Вайш"
}

L:SetWarningLocalization{
	WarnElemental		= "Нечистый элементаль скоро (%s)",
	WarnStrider			= "Странник скоро (%s)",
	WarnNaga			= "Гвардеец скоро (%s)",
	WarnShield			= "Деактивировано %d/4 щита",
	WarnLoot			= "Ядро порчи на >%s<",
	SpecWarnElemental	= "Нечистый элементаль - Смени цель!",
	SpecWarnCore		= "Ядро порчи на тебе!"
}

L:SetTimerLocalization{
	TimerElementalActive	= "Элементаль активный",
	TimerElemental			= "Элементаль КД (%d)",
	TimerStrider			= "Следующий Странник (%d)",
	TimerNaga				= "Следующий Гвардеец (%d)"
}

L:SetOptionLocalization{
	WarnElemental		= "Показывать предупреждение о следующем Нечистом элементале",
	WarnStrider			= "Показывать предупреждение о следующем Страннике",
	WarnNaga			= "Показывать предупреждение о следующем Гвардейце",
	WarnShield			= "Показывать предупреждения о щите на Фазе 2",
	WarnLoot			= "Показывать предупреждение о добыче Ядра порчи",
	TimerElementalActive	= "Показывать таймер активности Нечистого элементаля",
	TimerElemental		= "Показывать таймер КД для Нечистого элементаля",
	TimerStrider		= "Показывать таймер о следующем Страннике",
	TimerNaga			= "Показывать таймер о следующем Гвардейце",
	SpecWarnElemental	= "Показывать специальное предупреждение о появлении Нечистого элементаля",
	SpecWarnCore		= "Показывать специальное предупреждение когда Ядро порчи на тебе"
}

L:SetMiscLocalization{
	DBM_VASHJ_YELL_PHASE2	= "Время пришло! Не щадите никого!",
	DBM_VASHJ_YELL_PHASE3	= "Вам не пора прятаться?",
	LootMsg					= "([^%s]+).*Hitem:(%d+)"
}
