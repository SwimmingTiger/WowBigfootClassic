local TC2, C, L, _ = unpack(select(2, ...))
if TC2.locale ~= "ruRU" then return end

-----------------------------
--	ruRU client (by Hubbotu)
-----------------------------
-- main frame
L.gui_threat			= "Угроза"
L.gui_config			= "Открыть Настройки"

-- config frame
L.reset					= "Сбросить до значений по умолчанию"

-- messages
L.message_welcome		= "Введите /tc2 для настройки."
L.message_leader		= "Вы должны быть лидером группы или иметь статус помощника, чтобы сделать это."
L.message_outdated		= "|cFFFBB709ThreatClassic2:|r Доступна новая версия! Пожалуйста, загрузите последнюю версию."
L.message_incompatible	= "|cFFFBB709ThreatClassic2|r устарел и не будет совместим c новыми версиями. Пожалуйста, обновите немедленно!"

L.general				= "Общие"
L.general_welcome		= "Отображать приветственное сообщение при входе в игру."
L.general_rawPercent	= "Использовать исходный процент угрозы (аггро при 110% у мили / 130% ренджей)"
L.general_downscaleThreat = "Скалировать значение угрозы (1 урон равен 1 угрозе до модификаторов)"
L.general_downscaleThreatDesc = "Blizzard API угрозы использует показатель 100 за 1 урон. Эта настройка позваляет скалировать значения угрозы к тому что использовался до патча 1.13.5"
L.general_updateFreq	= "Время (в секундах) между обновлениями."
L.general_test			= "Включить тестовый режим."
L.general_minimap		= "Вкл/Выкл значок миникарты."
L.general_ignorePets	= "Игнорировать угрозу от питомцев игрока."

L.visibility			= "Видимость"
L.visibility_hideOOC	= "Скрыть рамку, когда вне боя."
L.visibility_hideSolo	= "Скрыть рамку, когда не в группе."
L.visibility_hideInPvP	= "Скрыть рамку, когда на полях боя."
L.visibility_hideOpenWorld	= "Скрыть рамку, когда не в подземелье (так же скрывает на мировых боссах!)."
L.visibility_hideAlways	= "Скрывать всегда. Команда /tc2 toggle для включения"

L.color					= "Цвета"

L.appearance			= "Вид"

L.frame					= "Рамка"
L.frame_header			= "Заголовок"
L.frame_bg				= "Фон"
L.frame_test			= "Тестовый режим"
L.frame_strata			= "Слои"
L.frame_scale			= "Масштаб"
L.frame_lock			= "Закрепить"
L.frame_headerShow		= "Показать заголовок"
L.frame_headerColor		= "Цвет заголовка"
L.frame_position		= "Расположение"
L.frame_width			= "Ширина"
L.frame_height			= "Высота"
L.frame_xOffset         = "X-Смещение"
L.frame_yOffset         = "Y-Смещение"

L.bar					= "Панели"
L.bar_descend			= "Уменьшение"
L.bar_height			= "Высота"
L.bar_padding			= "Фон Панели"
L.bar_texture			= "Текстура"
L.bar_alpha				= "Прозрачность Панели(только стандартные цвета)"

L.customBarColors 			        = "Пользовательские Цвета Панелей"
L.customBarColorsPlayer_enabled	    = "Включить для Игрока"
L.customBarColorsActiveTank_enabled	= "Включить для Активного Танка"
L.customBarColorsOtherUnit_enabled 	= "Включить для Остальных"
L.customBarColorsPlayer_color 	    = "Цвет Игрока"
L.customBarColorsActiveTank_color 	= "Цвет Активного Танка"
L.customBarColorsOtherUnit_color 	= "Цвет Остальных"

L.font					= "Шрифт"
L.font_name				= "Тип"
L.font_size				= "Размер"
L.font_style			= "Стиль"
L.font_shadow			= "Тень"

L.warnings				= "Предупреждения"
L.warnings_flash		= "Включить мигание экрана."
L.warnings_sound		= "Включить звуки."
L.warnings_threshold	= "Порог предупреждения (100% = аггро)."
L.warnings_minThreatAmount = "Минимальное значение для предупреждения"
L.warnings_minThreatAmount_desc = "Значение зависит от 'Общие -> Скалировать значение угрозы' настройки и совпадает с отображаемой угрозой. Большие значения могут быть заданы через окно ввода."

L.warnings_soundFile	= "Звук предупреждения."
L.warnings_soundChannel	= "Канал вывода"

L.soundChannel_master	= "Главный"
L.soundChannel_sfx		= "Звуковые эфекты"
L.soundChannel_ambience	= "Фоновые звуки"
L.soundChannel_music	= "Музыка"
