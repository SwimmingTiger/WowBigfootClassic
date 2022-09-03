if GetLocale() ~= "ruRU" then return end
local L

---------------
--  Kalecgos --
---------------
L = DBM:GetModLocalization("Kal")

L:SetGeneralLocalization{
	name = "Калесгос"
}

L:SetWarningLocalization{
	WarnPortal			= "Портал #%d : >%s< (Группа %d)",
	SpecWarnWildMagic	= "Дикая магия - %s!"
}

L:SetOptionLocalization{
	WarnPortal			= "Показывать предупреждение для цели $spell:46021",
	SpecWarnWildMagic	= "Показывать спецпредупреждения для Дикой магии",
	ShowFrame			= "Показывать фрейм Призрачного мира",
	FrameClassColor		= "Использовать цвета классов во фрейме Призрачного мира",
	FrameUpwards		= "Расширять фрейм Призрачного мира вверх",
	FrameLocked			= "Закрепить фрейм Призрачного мира на месте",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(10, 46021)
}

L:SetMiscLocalization{
	Demon				= "Сатроварр Осквернитель",
	Heal				= "+100% хила",
	Haste				= "+100% время каста",
	Hit					= "-50% шанс попасть",
	Crit				= "+100% крит урона",
	Aggro				= "+100% угрозы",
	Mana				= "-50% стоимости заклинаний",
	FrameTitle			= "Призрачный мир",
	FrameLock			= "Закрепить рамку",
	FrameClassColor		= "Использовать цвета классов",
	FrameOrientation	= "Расширять вверх",
	FrameHide			= "Скрыть рамку",
	FrameClose			= "Закрыть"
}

----------------
--  Brutallus --
----------------
L = DBM:GetModLocalization("Brutallus")

L:SetGeneralLocalization{
	name				= "Бруталл"
}

L:SetMiscLocalization{
	Pull				= "Аа, новые овечки на заклание?"
}

--------------
--  Felmyst --
--------------
L = DBM:GetModLocalization("Felmyst")

L:SetGeneralLocalization{
	name = "Пророк Скверны"
}

L:SetWarningLocalization{
	WarnPhase		= "%s фаза",
}

L:SetTimerLocalization{
	TimerPhase		= "Следующая %s фаза",
}

L:SetOptionLocalization{
	WarnPhase		= "Показывать предупреждение для следующей фазы",
	TimerPhase		= "Показывать таймер до следующей фазы"

}

L:SetMiscLocalization{
	Air				= "Наземная",
	Ground			= "Воздушная",
	AirPhase		= "Я сильнее, чем когда-либо прежде!",
	Breath			= "%s глубоко вдыхает."
}

-----------------------
--  The Eredar Twins --
-----------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization{
	name = "Близнецы"
}

L:SetMiscLocalization{
	Nova			= "заклинание Кольцо Тьмы на (.+)",
	Conflag			= "направляет \"Воспламенение\" на (.+)",
	Sacrolash		= "Леди Сакролаш",
	Alythess		= "Верховная чернокнижница Алитесса"
}


------------
--  M'uru --
------------
L = DBM:GetModLocalization("Muru")

L:SetGeneralLocalization{
	name = "М'ууру"
}

L:SetWarningLocalization{
	WarnHuman		= "Стража (%d)",
	WarnVoid		= "Часовой Бездны (%d)",
	WarnFiend		= "Исчадия тьмы!"
}

L:SetTimerLocalization{
	TimerHuman		= "Стража (%s)",
	TimerVoid		= "Часовой Бездны (%s)",
	TimerPhase		= "Энтропий"
}

L:SetOptionLocalization{
	WarnHuman		= "Показывать предупреждение о Страже",
	WarnVoid		= "Показывать предупреждение о Часовом бездны",
	WarnFiend		= "Показывать предупреждение об Исчадиях тьмы во второй фазе",
	TimerHuman		= "Показывать таймер до Стражи",
	TimerVoid		= "Показывать таймер до Часового Бездны",
	TimerPhase		= "Показывать таймер до перехода во вторую фазу"
}

L:SetMiscLocalization{
	Entropius		= "Энтропий"
}

----------------
--  Kil'jeden --
----------------
L = DBM:GetModLocalization("Kil")

L:SetGeneralLocalization{
	name = "Кил'джеден"
}

L:SetWarningLocalization{
	WarnDarkOrb		= "Появляется темная сфера",
	WarnBlueOrb		= "Сфера Калесгоса активна",
	SpecWarnDarkOrb	= "Появляется темная сфера!",
	SpecWarnBlueOrb	= "Сфера Калесгоса активна!"
}

L:SetTimerLocalization{
	TimerBlueOrb	= "Активация сфер Калесгоса"
}

L:SetOptionLocalization{
	WarnDarkOrb		= "Показывать предупреждение о темных сферах",
	WarnBlueOrb		= "Показывать предупреждение о сферах Калесгоса",
	SpecWarnDarkOrb	= "Показывать спецпредупреждения о темных сферах",
	SpecWarnBlueOrb	= "Показывать спецпредупреждения о сферах Калесгоса",
	TimerBlueOrb	= "Show timer form Dragon Orbs activate",--Translate
}

L:SetMiscLocalization{
	YellPull		= "Те, кем можно было пожертвовать, мертвы. Так тому и быть! Я добьюсь успеха там, где Саргерас потерпел поражение! Я заставлю этот жалкий мирок истекать кровью и навеки закреплю за собой место повелителя Пылающего Легиона! Пробил последний час этого мира!",
	OrbYell1		= "Я наполню сферы своей энергией! Готовьтесь!",
	OrbYell2		= "I have empowered another orb! Use it quickly!",--Translate
	OrbYell3		= "Готова еще одна сфера! Торопитесь!",
	OrbYell4		= "Я отдал все, что мог. Моя энергия в ваших руках!"
}
