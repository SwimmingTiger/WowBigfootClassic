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
L.message_outdated		= "Доступна новая версия TC2/LibThreatClassic2! Пожалуйста, загрузите последнюю версию."
L.message_incompatible	= "TC2/LibThreatClassic2 устарела и не будет совместима с этой группой. Пожалуйста, обновите немедленно."

-- version check
L.version				= "Проверка версии"
L.version_check			= "Проверить устаревший"
L.version_check_all		= "Проверить все"
L.version_notify		= "Уведомлять о устаревании"
L.version_list			= "Проверка версии: все клиенты"
L.version_list_outdated	= "Проверка версии: устаревшие клиенты"
L.version_divider		= "--------------------------------"
L.version_incompatible	= "Не совместимы!"

L.general				= "Общие"
L.general_welcome		= "Отображать приветственное сообщение при входе в игру."
L.general_update		= "Время (в секундах) между обновлениями."
L.general_test			= "Включить тестовый режим."
L.general_minimap		= "Переключить значок миникарты."
L.general_ignorePets	= "Игнорировать угрозу от питомцев игрока."

L.visibility			= "Видимость"
L.visibility_hideOOC	= "Скрыть рамку, когда вне боя."
L.visibility_hideSolo	= "Скрыть рамку, когда не в группе."
L.visibility_hideInPvP	= "Скрыть рамку, когда на полях боя."

L.nameplates			= "Индикаторы"
L.nameplates_enable		= "Включить раскраску угроз (только для индикаторов Blizzard)."
L.nameplates_invert		= "Инвертирующая угроза окраски (предназначена для танков)."
L.nameplates_colors		= "Цвета угрозы"

L.color					= "Цвета"
L.color_good			= "Хорошо"
L.color_neutral			= "Нейтрально"
L.color_bad				= "Плохо"

L.appearance			= "Вид"

L.frame					= "Рамка"
L.frame_header			= "Заголовок"
L.frame_bg				= "Фон"
L.frame_test			= "Тестовый режим"
L.frame_strata			= "Слои"
L.frame_scale			= "Масштаб"
L.frame_lock			= "Замок"
L.frame_headerShow		= "Показать заголовок"
L.frame_headerColor		= "Цвет заголовка"
L.frame_width			= "Ширина"

L.bar					= "Панели"
L.bar_count				= "Максимальное количество"
L.bar_descend			= "Уменьшение"
L.bar_height			= "Высота"
L.bar_padding			= "Фон Панели"
L.bar_marker			= "Угроза игрока красным"
L.bar_texture			= "Текстура"
L.bar_classColor		= "Использовать цвет класса"
L.bar_defaultColor		= "Пользовательский цвет"
L.bar_alpha				= "Прозрачность Панели (default colors)"
L.bar_colorMod			= "Модификатор цвета"

L.font					= "Шрифт"
L.font_name			= "Имя"
L.font_size				= "Размер"
L.font_style			= "Стиль"
L.font_shadow			= "Тень"

L.warnings				= "Предупреждения"
L.warnings_sound		= "Включить звуки."
L.warnings_threshold	= "Порог предупреждения (100% = aggro)."

L.warnings_soundFile		= "Звук предупреждения."
L.sound_pulledFile		= "Звук при Агро."
