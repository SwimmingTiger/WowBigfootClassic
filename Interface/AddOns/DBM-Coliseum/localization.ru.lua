if GetLocale() ~= "ruRU" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Чудовища Нордскола"
}

L:SetMiscLocalization{
	Charge		= "^%%s глядит на (%S+) и испускает гортанный вой!",
	CombatStart	= "Из самых глубоких и темных пещер Грозовой Гряды был призван Гормок Пронзающий Бивень! В бой, герои!",
	Phase2		= "Приготовьтесь к схватке с близнецами-чудовищами, Кислотной Утробой и Жуткой Чешуей!",
	Phase3		= "В воздухе повеяло ледяным дыханием следующего бойца: на арену выходит Ледяной Рев! Сражайтесь или погибните, чемпионы!",
	Gormok		= "Гормок Пронзающий Бивень",
	Acidmaw		= "Кислотная Утроба",
	Dreadscale	= "Жуткая Чешуя",
	Icehowl		= "Ледяной Рев"
}

L:SetOptionLocalization{
	WarningSnobold				= "Предупреждение о призыве Снобольда-вассала",
	ClearIconsOnIceHowl			= "Снимать все иконки перед Топотом",
	TimerNextBoss				= "Отсчет времени до появления следующего противника",
	TimerEmerge					= "Отсчет времени до появления",
	TimerSubmerge				= "Отсчет времени до зарывания",
	IcehowlArrow				= "Показывать стрелку, когда Ледяной Рев готовится сделать рывок на цель рядом с вами"
}

L:SetTimerLocalization{
	TimerNextBoss		= "Прибытие следующего босса",
	TimerEmerge			= "Появление",
	TimerSubmerge		= "Зарывание"
}

L:SetWarningLocalization{
	WarningSnobold				= "Призыв Снобольда-вассала"
}

---------------------
--  Lord Jaraxxus  --
---------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "Лорд Джараксус"
}

L:SetOptionLocalization{
	IncinerateShieldFrame		= "Показать здоровье босса с индикатором здоровья для Испепеления плоти"
}

L:SetMiscLocalization{
	IncinerateTarget	= "Испепеление плоти: %s",
	FirstPull	= "Сейчас великий чернокнижник Вилфред Непопамс призовет вашего нового противника. Готовьтесь к бою!"
}

-------------------------
--  Faction Champions  --
-------------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "Чемпионы фракций"
}

L:SetMiscLocalization{
	AllianceVictory		= "СЛАВА АЛЬЯНСУ!",
	HordeVictory		= "Не щадите никого, герои Орды! ЛОК'ТАР ОГАР!",
	YellKill			= "Пустая и горькая победа. После сегодняшних потерь мы стали слабее как целое. Кто еще, кроме Короля-лича, выиграет от подобной глупости? Пали великие воины. И ради чего? Истинная опасность еще впереди – нас ждет битва с  Королем-личом."
}

---------------------
--  Val'kyr Twins  --
---------------------
L = DBM:GetModLocalization("ValkTwins")

L:SetGeneralLocalization{
	name = "Валь'киры-близнецы"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "Следующая спецспособность"
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "Скоро спецспособность",
	SpecWarnSpecial				= "Смена цвета",
	SpecWarnSwitchTarget		= "Смена цели",
	SpecWarnKickNow				= "Прерывание",
	WarningTouchDebuff			= "Отрицательный эффект на |3-5(>%s<)",
	WarningPoweroftheTwins2		= "Сила близнецов - больше исцеления на |3-3(>%s<)",
	SpecWarnPoweroftheTwins		= "Сила близнецов"
}

L:SetMiscLocalization{
	Fjola		= "Фьола Погибель Света",
	Eydis		= "Эйдис Погибель Тьмы"
}

L:SetOptionLocalization{
	TimerSpecialSpell			= "Отсчет времени до перезарядки спецспособности",
	WarnSpecialSpellSoon		= "Предупреждение о следующуюей спецспособность",
	SpecWarnSpecial				= "Спецпредупреждение для смены цветов",
	SpecWarnSwitchTarget		= "Спецпредупреждение для других, когда босс читает заклинание",
	SpecWarnKickNow				= "Спецпредупреждение, когда Вы должы прервать заклинание",
	SpecialWarnOnDebuff			= "Спецпредупреждение, когда отрицательный эффект",
	SetIconOnDebuffTarget		= "Установить метку на получившего отрицательный эффект (героический режим)",
	WarningTouchDebuff			= "Объявлять цели, получившие отрицательный эффект",
	WarningPoweroftheTwins2		= "Объявлять цель под воздействем Силы близнецов",
	SpecWarnPoweroftheTwins		= "Спецпредупреждение, когда на Вас Сила близнецов"
}

-----------------
--  Anub'arak  --
-----------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 					= "Ануб'арак"
}

L:SetTimerLocalization{
	TimerEmerge				= "Появление через",
	TimerSubmerge			= "Зарывание через",
	timerAdds				= "Призыв помощников через"
}

L:SetWarningLocalization{
	WarnEmerge				= "Ануб'арак появляется",
	WarnEmergeSoon			= "Появление через 10 сек",
	WarnSubmerge			= "Ануб'арак закапывается",
	WarnSubmergeSoon		= "Зарывание через 10 сек",
	specWarnSubmergeSoon	= "Зарывание через 10 сек!",
	warnAdds				= "Новые помощники"
}

L:SetMiscLocalization{
	Emerge				= "вылезает на поверхность!",
	Burrow				= "зарывается в землю!",
	PcoldIconSet		= "Метка холода {rt%d} установлена на: %s",
	PcoldIconRemoved	= "Метка холода снята с: %s"
}

L:SetOptionLocalization{
	WarnEmerge				= "Предупреждение о появлении",
	WarnEmergeSoon			= "Предупреждать заранее о появлении",
	WarnSubmerge			= "Предупреждение о закапывании",
	WarnSubmergeSoon		= "Предупреждать заранее о закапывании",
	specWarnSubmergeSoon	= "Спецпредупреждение о скором закапывании",
	warnAdds				= "Предупреждение о призыве помощников",
	timerAdds				= "Отсчет времени до призыва помощников",
	TimerEmerge				= "Отсчет времени до появления",
	TimerSubmerge			= "Отсчет времени до закапывания",
	AnnouncePColdIcons		= "Объявлять метки целей заклинания $spell:68510 в рейд-чат<br/>(требуются права лидера или помощника)",
	AnnouncePColdIconsRemoved	= "Объявлять также о снятии меток с целей заклинания $spell:68510<br/>(требуется предыдущая опция)"
}
