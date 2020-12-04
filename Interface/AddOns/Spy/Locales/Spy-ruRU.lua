local L = LibStub("AceLocale-3.0"):NewLocale("Spy", "ruRU")
if not L then return end
-- TOC Note: Обнаруживает и предупреждает вас о присутствии ближайших вражеских игроков.

-- Configuration
L["Spy"] = "Spy"
L["Version"] = "Версия"
L["Spy Option"] = "Spy"
L["Profiles"] = "Профили"

-- About
L["About"] = "Info"
L["SpyDescription1"] = [[
Spy это аддон, который будет предупреждать вас о присутствии рядом вражеских игроков..
]]
L["SpyDescription2"] = [[
|cffffd000Nearby list|cffffffff
показывает всех встреченных врагов.  Игроки убираются из этого списка, если они более не встречались некоторое время.

|cffffd000список последних час|cffffffff
отображаются все враги, обнаруженные за последний час

|cffffd000список игнорируемых|cffffffff
Игроки, добавленные в список игнорируемых, не будут отслеживаться аддоном. Вы можете добавлять и удалять игроков из этого списка, используя выпадающее меню зажав Ctrl во время нажатия на кнопку.

|cffffd000Kill On Sight list|cffffffff
При обнаружении игрока из вашего списка Kill On Sight вы услышите сигнал. Вы можете добавлять и удалять игроков из этого списка, используя выпадающее меню зажав Shift во время нажатия на кнопку.

Выпадающее меню также можно использовать для добавления причины, по которой вы добавили кого-либо в список Kill On Sight. Если вы хотите ввести конкретную причину, которой нет в списке, используйте «Введите собственную причину ...» в списке Другие..

|cffffd000Statistics Window|cffffffff
Окно статистики содержит список всех встреч врагов, которые можно отсортировать по имени, уровню, гильдии, победам, потерям и времени последнего обнаружения врага. Он также предоставляет возможность поиска конкретного врага по имени или гильдии и имеет фильтры, показывающие только тех врагов, которые отмечены как Kill on Sight, с победой / поражением или введенными причинами.

|cffffd000Kill On Sight Button|cffffffff
Если эта кнопка включена, она будет расположена на целевом кадре врага. Нажатие на эту кнопку добавит / удалит вражескую цель в / из списка Kill on Sight. Правый клик по кнопке позволит вам ввести причины Kill on Sight.

|cffffd000автор: Slipjack|cffffffff
]]

-- General Settings
L["GeneralSettings"] = "Общие настройки"
L["GeneralSettingsDescription"] = [[
Параметры, когда шпион включен или отключен.
]]
L["EnableSpy"] = "Включить Spy"
L["EnableSpyDescription"] = "Включить либо отключить Spy."
L["EnabledInBattlegrounds"] = "Включить Spy на полях боя"
L["EnabledInBattlegroundsDescription"] = "Включить либо отключить Spy пока вы на поле боя."
L["EnabledInArenas"] = "Включить Spy на аренах"
L["EnabledInArenasDescription"] = "Включить либо отключить Spy пока вы на арене."
L["EnabledInWintergrasp"] = "Включить Spy в мировой боевой зоне"
L["EnabledInWintergraspDescription"] = "Включить либо отключить Spy когда вы в мировой боевой зоне, например Озеро Ледяных Оков в Нордсколе."
L["DisableWhenPVPUnflagged"] = "Отключить Spy если у вас выключен PVP режим"
L["DisableWhenPVPUnflaggedDescription"] = "Включить либо отключить Spy в зависимости от вашего PVP статуса."
L["DisabledInZones"] = "Отключить Spy, находясь в этих местах"
L["DisabledInZonesDescription"]	= "Выберите места, где Spy будет отключен."
L["Booty Bay"] = "Пиратская Бухта"
L["Everlook"] = "Круговзор"						
L["Gadgetzan"] = "Прибамбасск"
L["Ratchet"] = "Кабестан"
L["The Salty Sailor Tavern"] = "Таверна \"Старый моряк\""
L["Shattrath City"] = "Шаттрат"
L["Area 52"] = "Зона 52"
L["Dalaran"] = "Даларан"
L["Dalaran (Northrend)"] = "Даларан (Нордскол)"
L["Bogpaddle"] = "Веслотопь"
L["The Vindicaar"] = "Виндикар"
L["Krasus' Landing"] = "Площадка Краса"
L["The Violet Gate"] = "Аметистовые врата"
L["Magni's Encampment"] = "Лагерь Магни"
L["Silithus"] = "Силитус"
L["Chamber of Heart"] = "Зал Сердца"
L["Hall of Ancient Paths"] = "Зал Древних Путей"
L["Sanctum of the Sages"] = "Святилище жрецов"

-- Display
L["DisplayOptions"] = "дисплей"
L["DisplayOptionsDescription"] = [[
Опции для окна SPY и всплывающих подсказок.
]]
L["ShowOnDetection"] = "Показать Spy, если вражеские игроки обнаружены"
L["ShowOnDetectionDescription"] = "SОтображение окна Spy и Nearby list, если Spy скрыт во время обнаружения врага."
L["HideSpy"] = "Скрыть Spy, если вражеские игроки не обнаружены"
L["HideSpyDescription"] = "Скрыть Spy если Nearby list включен для показа и пуст. Spy не будет скрыт, если вы очистите список вручную."
L["ShowOnlyPvPFlagged"] = "Показать только вражеских игроков, помеченных для PvP"
L["ShowOnlyPvPFlaggedDescription"] = "Показывать в Nearby list только врагов с включенным PvP флагом."
L["ShowKoSButton"] = "Показывать Kill On Sight кнопку на фрейме врага"
L["ShowKoSButtonDescription"] = "Установите это, чтобы показать кнопку Kill on Sight на целевом кадре вражеского игрока."
L["Alpha"] = "прозрачность"
L["AlphaDescription"] = "Установите прозрачность окна Spy."
L["AlphaBG"] = "Прозрачность на полях сражений"
L["AlphaBGDescription"] = "Установите прозрачность окна Spy на полях сражений."
L["LockSpy"] = "Зафиксировать окно Spy"
L["LockSpyDescription"] = "Блокирует окно Spy, чтобы оно не двигалось."
L["ClampToScreen"] = "Прикрепить к экрану"
L["ClampToScreenDescription"] = "Управляет возможностью перемещения окна Spy с экрана."
L["InvertSpy"] = "Инвертировать окно Spy"
L["InvertSpyDescription"] = "Переворачивает окно Spy вверх дном."
L["Reload"] = "Перезагрузить UI"
L["ReloadDescription"] = "Требуется при изменении окна Spy."
L["ResizeSpy"] = "Изменять размер окна Spy автоматически"
L["ResizeSpyDescription"] = "Автоматически измененять размер окна Spy, когда вражеские игроки добавляются и удаляются."
L["ResizeSpyLimit"] = "Предел списка"
L["ResizeSpyLimitDescription"] = "Ограничьте количество вражеских игроков, отображаемых в окне Spy."
L["DisplayTooltipNearSpyWindow"] = "Отображать всплывающую подсказку возле окна Spy"
L["DisplayTooltipNearSpyWindowDescription"] = "Выберите это, чтобы отобразить всплывающую подсказку рядом с окном SPY."
L["SelectTooltipAnchor"] = "Точка привязки всплывающей подсказки"
L["SelectTooltipAnchorDescription"] = "Выберите точку привязки для всплывающей подсказки, если предыдущая опция была включена."
L["ANCHOR_CURSOR"] = "Курсор"
L["ANCHOR_TOP"] = "Вверх"
L["ANCHOR_BOTTOM"] = "Низ"
L["ANCHOR_LEFT"] = "Лево"			
L["ANCHOR_RIGHT"] = "Право"
L["TooltipDisplayWinLoss"] = "Показывать статистику убийства/смертей в всплывающей подсказке"
L["TooltipDisplayWinLossDescription"] = "Выберите это, чтобы показать статистику убийств / смертей во всплывающей подсказке."
L["TooltipDisplayKOSReason"] = "Показывать причину Kill On Sight в всплывающей подсказке"
L["TooltipDisplayKOSReasonDescription"] = "Выберите это, чтобы показать причину Kill On Sight в подсказке."
L["TooltipDisplayLastSeen"] = "Показывать детали последней встречи"
L["TooltipDisplayLastSeenDescription"] = "Показывать время и местоположение о последней встречи в всплывающей подсказке."
L["DisplayListData"] = "Выберите данные противника для отображения"
L["Name"] = "имя"
L["Class"] = "Класс"
L["SelectFont"] = "Выберите Шрифт"
L["SelectFontDescription"] = "Выберите Шрифт для окна Spy."
L["RowHeight"] = "Выберите высоту строки"
L["RowHeightDescription"] = "Выберите высоту строки для окна Spy."
L["Texture"] = "текстура"
L["TextureDescription"] = "Выберите текстуру для окна шпиона."

-- Alerts
L["AlertOptions"] = "Оповещения"
L["AlertOptionsDescription"] = [[
Варианты оповещений, объявлений и предупреждений при обнаружении вражеских игроков.
]]
L["SoundChannel"] = "Выберите звуковой канал"
L["Master"] = "Общая громкость"
L["SFX"] = "Звук"
L["Music"] = "Музыка"
L["Ambience"] = "Мир"
L["Announce"] = "Отправить сообщать на:"
L["None"] = "Не сообщать"
L["NoneDescription"] = "Не предупреждать о встреченных врагах."
L["Self"] = "Для себя"
L["SelfDescription"] = "Сообщать о встреченных врагах только для игрока."
L["Party"] = "Группу"
L["PartyDescription"] = "Сообщать о встреченных врагах в канал группы."
L["Guild"] = "Гильдия"
L["GuildDescription"] = "Сообщать о встреченных врагах в канал гильдии."
L["Raid"] = "Рейд"
L["RaidDescription"] = "Сообщать о встреченных врагах в канал рейда."
L["LocalDefense"] = "Канал обороны"
L["LocalDefenseDescription"] = "Сообщать о встреченных врагах в канал обороны."
L["OnlyAnnounceKoS"] = "Только сообщать врагов в списке Kill on Sight"
L["OnlyAnnounceKoSDescription"] = "Выберите это, чтобы сообщать только о врагах в списке Kill On Sight."
L["WarnOnStealth"] = "Предупреждать о применении Незаметности"
L["WarnOnStealthDescription"] = "Предупреждать о входе врагов в Незаметность с помощью сообщения и звукового сигнала."
L["WarnOnKOS"] = "Предупреждать о обнаружении врага из списка Kill On Sight"
L["WarnOnKOSDescription"] = "Отображать предупреждение и подавать звуковой сигнал при обнаружении вражеского игрока в вашем списке Kill On Sight."
L["WarnOnKOSGuild"] = "Предупредить об обнаружении гильдии Kill On Sight"
L["WarnOnKOSGuildDescription"] = "Отображать предупреждение и подавать сигнал тревоги, когда обнаружен вражеский игрок из той же гильдии, что и кто-то из вашего списка Kill On Sight."
L["WarnOnRace"] = "Предупреждать об обнаружении нужной расы"
L["WarnOnRaceDescription"] = "Проигрывать сигнал тревоги при обнаружении выбранной расы"
L["SelectWarnRace"] = "Выберите расу для отслеживания"
L["SelectWarnRaceDescription"] = "Выберите расу для звукового предупреждения."
L["WarnRaceNote"] = "Примечание: Вы должны поразить врага хотя бы один раз, чтобы его раса могла быть добавлена в базу данных. При следующем обнаружении прозвучит предупреждение. Это не работает так же, как обнаружение ближайших врагов в бою."
L["DisplayWarningsInErrorsFrame"] = "Отображать предупреждения в рамке ошибок"
L["DisplayWarningsInErrorsFrameDescription"] = "Использовать фрейм ошибок для отображения предупреждений вместо использования графических всплывающих фреймов."
L["DisplayWarnings"] = "Выберите местоположение сообщения с предупреждением"
L["Default"] = "умолчанию"
L["ErrorFrame"] = "Ошибка кадра"
L["Moveable"] = "подвижной"
L["EnableSound"] = "Включить звуковые оповещения"
L["EnableSoundDescription"] = "Включить звуковые оповещения при обнаружении вражеских игроков. Разные оповещения звучат, если вражеский игрок получает скрытность или если вражеский игрок находится в списке Kill On Sight."
L["OnlySoundKoS"] = "Оповещать о враге из списка Kill On Sight только звуком"
L["OnlySoundKoSDescription"] = "Воспроизводить звуковые оповещения только при обнаружении вражеских игроков из списка Kill on Sight."
L["StopAlertsOnTaxi"] = "отключить оповещения, когда на пути полета"
L["StopAlertsOnTaxiDescription"] = "отключить все новые оповещения, когда на пути полета."

-- Nearby List
L["ListOptions"] = "Nearby List"
L["ListOptionsDescription"] = [[
Опции о том, как вражеские игроки добавляются и удаляются.
]]
L["RemoveUndetected"] = "Удалить вражеских игроков из Nearby List после:"
L["1Min"] = "1 минуты"
L["1MinDescription"] = "Удалять игрока из Nearby List если его видели более 1 минуты назад."
L["2Min"] = "2 минут"
L["2MinDescription"] = "Удалять игрока из Nearby List если его видели более 2 минуты назад."
L["5Min"] = "5 минут"
L["5MinDescription"] = "Удалять игрока из Nearby List если его видели более 5 минуты назад."
L["10Min"] = "10 минут"
L["10MinDescription"] = "Удалять игрока из Nearby List если его видели более 10 минуты назад."
L["15Min"] = "15 минут"
L["15MinDescription"] = "Удалять игрока из Nearby List если его видели более 15 минуты назад."
L["Never"] = "Никогда не удалять"
L["NeverDescription"] = "Никогда не удалять игроков. Nearby list может быть очищен вручную."
L["ShowNearbyList"] = "Переключаться на Nearby list при обнаружении противника"
L["ShowNearbyListDescription"] = "Отображать Nearby list если в нём ниодного врага."
L["PrioritiseKoS"] = "Расставьте приоритеты врагов Kill on Sight в Списке поблизости"
L["PrioritiseKoSDescription"] = "Всегда показывать врагов из Kill On Sight списка в верху Nearby List."

-- Map
L["MapOptions"] = "Карта"
L["MapOptionsDescription"] = [[
Параметры карты мира и миникарты, включая значки и всплывающие подсказки.
]]
L["MinimapDetection"] = "Включить обнаружение мини-карты"
L["MinimapDetectionDescription"] = "Если навести курсор на известных вражеских игроков, обнаруженных на миникарте, они будут добавлены в список «Ближайшие»."
L["MinimapNote"] = "          Примечание: работает только для игроков, которые могут отслеживать гуманоидов."
L["MinimapDetails"] = "Отображать уровень/класс в подсказках"
L["MinimapDetailsDescription"] = "Установите это, чтобы обновить всплывающие подсказки карты, чтобы детали уровня / класса отображались вместе с именами врагов."
L["DisplayOnMap"] = "Отображать значки на карте"
L["DisplayOnMapDescription"] = "Отображать значки карты для определения местоположения других пользователей Spy в вашей группе, рейде и гильдии, когда они обнаруживают врагов."
L["SwitchToZone"] = "Переключить карту на текущую зону при обнаружении врага"
L["SwitchToZoneDescription"] = "Если открыта карта мира зона просмотра автоматически переключится на текущую локацию при обнаружении врага."
L["MapDisplayLimit"] = "Ограничение отображения иконок на карте:"
L["LimitNone"] = "Везде"
L["LimitNoneDescription"] = "Отображает обнаруженных врагов вне зависимости от того в какой локации вы находитесь."
L["LimitSameZone"] = "Текущая зона"
L["LimitSameZoneDescription"] = "Отображает обнаруженных врагов только в пределах вашей текущей зоны."
L["LimitSameContinent"] = "Текущий континент"
L["LimitSameContinentDescription"] = "Отображает обнаруженных врагов только в пределах вашей текущего континента."

-- Data Management
L["DataOptions"] = "Управление данными"
L["DataOptionsDescription"] = [[
Варианты того, как Spy поддерживает и собирает данные.
]]
L["PurgeData"] = "Очистить запись игрока, если вы не видели их после:"
L["OneDay"] = "1 день"
L["OneDayDescription"] = "Очищать запись об игроке, если вы не встречали его 1 день."
L["FiveDays"] = "5 дней"
L["FiveDaysDescription"] = "Очищать запись об игроке, если вы не встречали его 5 дней."
L["TenDays"] = "10 дней"
L["TenDaysDescription"] = "Очищать запись об игроке, если вы не встречали его 10 дней."
L["ThirtyDays"] = "30 дней"
L["ThirtyDaysDescription"] = "Очищать запись об игроке, если вы не встречали его 30 дней."
L["SixtyDays"] = "60 дней"
L["SixtyDaysDescription"] = "Очищать запись об игроке, если вы не встречали его 60 дней."
L["NinetyDays"] = "90 дней"
L["NinetyDaysDescription"] = "Очищать запись об игроке, если вы не встречали его 90 дней."
L["PurgeKoS"] = "Очистить игроков Kill on Sight на основе необнаруженного времени"
L["PurgeKoSDescription"] = "Установите это, чтобы очистить игроков Kill on Sight, которые не были обнаружены, основываясь на настройках времени для необнаруженных игроков."
L["PurgeWinLossData"] = "Очистить данные о выигрышах / проигрышах на основе необнаруженного времени"
L["PurgeWinLossDataDescription"] = "Установите это, чтобы очистить данные о выигрышах / поражениях ваших вражеских столкновений на основе настроек времени для необнаруженных игроков."
L["ShareData"] = "Делиться данными с другими пользователями аддона Spy"
L["ShareDataDescription"] = "Установите это, чтобы поделиться информацией о встречах вашего вражеского игрока с другими пользователями Spy в вашей группе, рейде и гильдии."
L["UseData"] = "Использовать данные других пользователей Spy"
L["UseDataDescription"] = "Установите это, чтобы использовать данные, собранные другими пользователями Spy в вашей группе, рейде и гильдии."
L["ShareKOSBetweenCharacters"] = "Использовать общий список Kill On Sight для ваших персонажей"
L["ShareKOSBetweenCharactersDescription"] = "Использовать общий список Kill On Sight для ваших персонажей на этом сервере и фракции."

-- Commands
L["SlashCommand"] = "Слэш команды"
L["SpySlashDescription"] = "Эти кнопки выполняют те же функции, что и команды слэша /spy"
L["Enable"] = "Enable"
L["EnableDescription"] = "Включить Spy и показать главное окно."
L["Show"] = "Show"
L["ShowDescription"] = "Показать главное окно."
L["Hide"] = "Hide"
L["HideDescription"] = "Скрывает главное окно."
L["Reset"] = "Reset"
L["ResetDescription"] = "Сбросить позицию и показ главного окна."
L["ClearSlash"] = "Clear"
L["ClearSlashDescription"] = "Очистить Nearby List."
L["Config"] = "Config"
L["ConfigDescription"] = "Открыть окно настроек аддона Spy."
L["KOS"] = "KOS"
L["KOSDescription"] = "Добавить/удалить игрока в/из список Kill On Sight."
L["InvalidInput"] = "Неверный Ввод"
L["Ignore"] = "Ignore"
L["IgnoreDescription"] = "Добавить/удалить игрока в/из список игнорируемых."
L["Test"] = "Test"
L["TestDescription"] = "Отображает предупреждение, чтобы вы могли изменить его положение."

-- Lists
L["Nearby"] = "Nearby"
L["LastHour"] = "Последний час"
L["Ignore"] = "Игнорировать"
L["KillOnSight"] = "Kill On Sight"

--Stats
L["Won"] = "Побед"
L["Lost"] = "Поражений"
L["Time"] = "Время"	
L["List"] = "В списке"
L["Filter"] = "Фильтр"
L["Show Only"] = "Показывать только"
L["KOS"] = "KOS"
L["Won/Lost"] = "Побед/Поражений"
L["Reason"] = "Причина"	 
L["HonorKills"] = "Почетные убийства"
L["PvPDeaths"] = "Смерти в PvP"

-- Output messages
L["VersionCheck"] = "|cffc41e3aПредупреждение! Неправильная версия Spy установлена. Удалите эту версию и установите Spy Classic."
L["SpyEnabled"] = "|cff9933ffSpy аддон включен."
L["SpyDisabled"] = "|cff9933ffSpy аддон отключен. Напишите |cffffffff/spy show|cff9933ff  для включения."
L["UpgradeAvailable"] = "|cff9933ffA Новая версия Spy доступна для скачивания. Вы можете загрузить её тут:\n|cffffffffhttps://www.curseforge.com/wow/addons/spy-classic"
L["AlertStealthTitle"] = "Обнаружен игрок в невидимости!"
L["AlertKOSTitle"] = "Обнаружен враг из списка Kill On Sight!"
L["AlertKOSGuildTitle"] = "Обнаружен враг из гильдии в списке Kill On Sight!"
L["AlertTitle_kosaway"] = "Враг из списка Kill On Sight был замечен "
L["AlertTitle_kosguildaway"] = "Враг из гильдии в списке Kill On Sight был замечен "
L["StealthWarning"] = "|cff9933ffОбнаружен игрок в невидимости: |cffffffff"
L["KOSWarning"] = "|cffff0000Обнаружен враг из списка Kill On Sight: |cffffffff"
L["KOSGuildWarning"] = "|cffff0000Обнаружен враг из гильдии в списке Kill On Sight: |cffffffff"
L["SpySignatureColored"] = "|cff9933ff[Spy] "
L["PlayerDetectedColored"] = "Обнаружен враг: |cffffffff"
L["PlayersDetectedColored"] = "Обнаружены враги: |cffffffff"
L["KillOnSightDetectedColored"] = "Обнаружен враг из списка Kill On Sight: |cffffffff"
L["PlayerAddedToIgnoreColored"] = "Игрок добавлен в список игнорируемых: |cffffffff"
L["PlayerRemovedFromIgnoreColored"] = "Игрок удален из списка игнорируемых: |cffffffff"
L["PlayerAddedToKOSColored"] = "Игрок добавлен в список Kill On Sight: |cffffffff"
L["PlayerRemovedFromKOSColored"] = "Игрок удален из списка Kill On Sight: |cffffffff"
L["PlayerDetected"] = "[Spy] Обнаружен враг: "
L["KillOnSightDetected"] = "[Spy] Обнаружен враг из списка Kill On Sight: "
L["Level"] = "Уровень"
L["LastSeen"] = "Последняя встреча"
L["LessThanOneMinuteAgo"] = "меньше минуты назад"
L["MinutesAgo"] = "минут назад"
L["HoursAgo"] = "часов назад"
L["DaysAgo"] = "дней назад"
L["Close"] = "Закрыть"
L["CloseDescription"] = "|cffffffffПрячёт окно Spy. По умолчанию оно появится снова когда вы обнаружете врага."
L["Left/Right"] = "Влево/Вправо"
L["Left/RightDescription"] = "|cffffffffПерещает между списками Nearby, Встреченно за последний час, Игнорирования и Kill On Sight."
L["Clear"] = "Очистить"
L["ClearDescription"] = "|cffffffffОчищает список обнаруженных игроков. CTRL-Клик включит/отключит Spy. Shift-Клик влючит/отключит все звук."
L["SoundEnabled"] = "Звуковые оповещения включены"
L["SoundDisabled"] = "Звуковые оповещения отключены"
L["NearbyCount"] = "Враги поблизости"
L["NearbyCountDescription"] = "|cffffffffЧисло врагов поблизости."
L["Statistics"] = "Статистика"
L["StatsDescription"] = "|cffffffffПоказывает список встреченных врагов, победы/поражения и где вы их последний раз видели."
L["AddToIgnoreList"] = "Добавить в список игнорируемых"
L["AddToKOSList"] = "Добавить в список Kill On Sight"
L["RemoveFromIgnoreList"] = "Удалить из списка игнорируемых"
L["RemoveFromKOSList"] = "Удалить из списка Kill On Sight"
L["RemoveFromStatsList"] = "Удалить из списка статистики"   
L["AnnounceDropDownMenu"] = "Сообщить в канал"
L["KOSReasonDropDownMenu"] = "Добавить причину добавления в список Kill On Sight"
L["PartyDropDownMenu"] = "Группу"
L["RaidDropDownMenu"] = "Рейд"
L["GuildDropDownMenu"] = "Гильдию"
L["LocalDefenseDropDownMenu"] = "Локальную Оборону"
L["Player"] = " (Игрок)"
L["KOSReason"] = "Kill On Sight"
L["KOSReasonIndent"] = "    "
L["KOSReasonOther"] = "Введите собственную причину ..."
L["KOSReasonClear"] = "Очистить"
L["StatsWins"] = "|cff40ff00Победы: "
L["StatsSeparator"] = "  "
L["StatsLoses"] = "|cff0070ddпроигрыши: "
L["Located"] = "обнаруженный:"
L["Yards"] = "метры"
L["LocalDefenseChannelName"] = "ОборонаЛокальный" 

Spy_KOSReasonListLength = 6
Spy_KOSReasonList = {
	[1] = {
		["title"] = "Начал сражение";
		["content"] = {
			"Атаковал меня без причины",
			"Атаковал меня у квестодателя", 
			"Атаковал меня когда я сражался с НПЦ",
			"Атаковал меня около подземелья",
			"Атаковал меня когда я был АФК",
			"Атаковал меня когда я бы на маунте/в полёте",
			"Атаковал меня когда я бы с низким запасом ХП/маны",
		};
	},
	[2] = {
		["title"] = "Стиль сражения";
		["content"] = {
			"Напал из засады",
			"Всегда атакует меня при встрече",
			"Убил меня персонажем высокого уровня",
			"Убил меня с группой врагов",
			"Не атакует без поддержки",
			"Всегда зовёт помощь",
			"Использует слишком много эффектов контроля",
		};
	},
	[3] = {
		["title"] = "Засада";
		["content"] = {
			"Устроил мне засаду",
			"Устроил засаду альту",
			"Устроил засаду малышам",
			"Устроил засаду из невидимости",
			"Устроил засаду на члена гильдии",
			"Устроил засаду на НПЦ/объект задания",
			"Устроил засаду в городе/поселении",
		};
	},
	[4] = {
		["title"] = "При выполнении заданий";
		["content"] = {
			"Атаковал меня когда я делал задания",
			"Атаковал меня после того как я помог с заданием",
			"Вмешался в выполнение задания",
			"начал квест, который я хотел сделать",
			"Убил НПЦ моей фракции",
			"Убил квестового НПЦ",
		};
	},
	[5] = {
		["title"] = "Украл ресурсы";
		["content"] = {
			"Собрал нужную мне траву",
			"Собрал нужную мне руду",
			"Собрал нужные мне ресурсы",
			"Убил меня и забрал себе мою цель/редкого НПЦ",
			"Снимал шкуры с убитых мною животных",
			"Забрал мою награду",
			"Рыбачил в моей лунке",
		};
	},
	[6] = {
		["title"] = "Прочее";
		["content"] = {
			"Влючил ПВП флаг",
			"Столкнул меня со скалы",
			"Использовал инженерские фишки",
			"Всегда старается сбежать",
			"Использовал предметы и способности для побега",
			"Использует эксплоиты игровой механики",
			"Введите собственную причину ...",
		};
	},
}

StaticPopupDialogs["Spy_SetKOSReasonOther"] = {
	preferredIndex=STATICPOPUPS_NUMDIALOGS,  -- http://forums.wowace.com/showthread.php?p=320956
	text = "Введите причину Kill on Sight для %s:",
	button1 = "Введите",
	button2 = "Отмена",
	timeout = 120,
	hasEditBox = 1,
	editBoxWidth = 260,	
	whileDead = 1,
	hideOnEscape = 1,
	OnShow = function(self)
		self.editBox:SetText("");
	end,
    OnAccept = function(self)
		local reason = self.editBox:GetText()
		Spy:SetKOSReason(self.playerName, "Введите собственную причину ...", reason)
	end,
};

-- Class descriptions
L["UNKNOWN"] = "Неизвестный"
L["DRUID"] = "Друид"
L["HUNTER"] = "Охотник"
L["MAGE"] = "Маг"
L["PALADIN"] = "Паладин"
L["PRIEST"] = "Жрец"
L["ROGUE"] = "Разбойник"
L["SHAMAN"] = "Шаман"
L["WARLOCK"] = "Чернокнижник"
L["WARRIOR"] = "Воин"
L["DEATHKNIGHT"] = "рыцарь смерти"
L["MONK"] = "Монах"
L["DEMONHUNTER"] = "Охотник на демонов"

-- Race descriptions
L["Human"] = "Человек"
L["Orc"] = "Орк"
L["Dwarf"] = "Дворф"
L["Tauren"] = "Таурен"
L["Troll"] = "Тролль"
L["Night Elf"] = "Ночной эльф"
L["Undead"] = "Нежить"
L["Gnome"] = "Гном"
L["Blood Elf"] = "Эльф крови"
L["Draenei"] = "Дреней"
L["Goblin"] = "Гоблин"
L["Worgen"] = "Ворген"
L["Pandaren"] = "Пандарен"
L["Highmountain Tauren"] = "Таурен Крутогорья"
L["Lightforged Draenei"] = "Озаренный дреней"
L["Nightborne"] = "Ночнорожденный"
L["Void Elf"] = "Эльф Бездны"
L["Dark Iron Dwarf"] = "Дворф из клана Черного Железа"
L["Mag'har Orc"] = "Маг'хар"
L["Kul Tiran"] = "Култирасец"
L["Zandalari Troll"] = "Зандалар"
L["Mechagnome"] = "Механогном"
L["Vulpera"] = "Вульпера"
 
-- Stealth abilities
L["Stealth"] = "Незаметность"
L["Prowl"] = "Крадущийся зверь"
 
-- Minimap color codes
L["MinimapGuildText"] = "|cffffffff"
L["MinimapClassTextUNKNOWN"] = "|cff191919"
L["MinimapClassTextDRUID"] = "|cffff7c0a"
L["MinimapClassTextHUNTER"] = "|cffaad372"
L["MinimapClassTextMAGE"] = "|cff68ccef"
L["MinimapClassTextPALADIN"] = "|cfff48cba"
L["MinimapClassTextPRIEST"] = "|cffffffff"
L["MinimapClassTextROGUE"] = "|cfffff468"
L["MinimapClassTextSHAMAN"] = "|cff2359ff"
L["MinimapClassTextWARLOCK"] = "|cff9382c9"
L["MinimapClassTextWARRIOR"] = "|cffc69b6d"
L["MinimapClassTextDEATHKNIGHT"] = "|cffc41e3a"
L["MinimapClassTextMONK"] = "|cff00ff96"
L["MinimapClassTextDEMONHUNTER"] = "|cffa330c9"

Spy_AbilityList = {
-----------------------------------------------------------
-- Allows an estimation of the race, class and level of a
-- player based on the abilities observed in the combat log.
-----------------------------------------------------------

--++ Racial Traits ++	
	["Уход в тень"]={ class = "Night Elf", level = 1, },
	["Кровавое неистовство"]={ class = "Orc", level = 1, },
	["Воля Отрекшихся"]={ class = "Undead", level = 1, },
	["Каменная форма"]={ class = "Dwarf", level = 1, },
	["Боевое исступление"]={ class = "Troll", level = 1, },
	["Твердость"]={ class = "Orc", level = 1, },
	["Специализация на владении мечами"]={ class = "Human", level = 1, },
	["Мастер побега"]={ class = "Gnome", level = 1, },
	["Человеческий дух"]={ class = "Human", level = 1, },
	["Регенерация"]={ class = "Troll", level = 1, },
	["Внимательность"]={ class = "Human", level = 1, },
	["Закалка"]={ class = "Tauren", level = 1, },
	["Специализация на луке"]={ class = "Troll", level = 1, },
	["Проращивание"]={ class = "Tauren", level = 1, },
	["Инженерное дело, специализация"]={ class = "Gnome", level = 1, },
	["Громовая поступь"]={ class = "Tauren", level = 1, },
	["Убийство животных"]={ class = "Troll", level = 1, },
	["Поиск сокровища"]={ class = "Dwarf", level = 1, },
	["Специализация на владении топором"]={ class = "Orc", level = 1, },
	["Каннибализм"]={ class = "Undead", level = 1, },
	["Дипломатия"]={ class = "Human", level = 1, },
	["Расторопность"]={ class = "Night Elf", level = 1, },
	["Специализация - броски"]={ class = "Troll", level = 1, },
	["Специализация на ударном оружии"]={ class = "Human", level = 1, },
	["Специализация по стрелковому оружию"]={ class = "Dwarf", level = 1, },
	["Подводное дыхание"]={ class = "Undead", level = 1, },
	["Властность"]={ class = "Orc", level = 1, },
	["Сопротивление силам природы"]={ class = "Night Elf", level = 1, },
	["Сопротивление магии льда"]={ class = "Dwarf", level = 1, },
	["Сопротивление темной магии"]={ class = "Undead", level = 1, },
	["Сопротивление тайной магии"]={ class = "Gnome", level = 1, },
	["Дух огонька"]={ class = "Night Elf", level = 1, },
	
--++ Druid Abilities ++	
	["Целительное прикосновение"]={ class = "DRUID", level = 1, },
	["Гнев"]={ class = "DRUID", level = 1, },
	["Лунный огонь"]={ class = "DRUID", level = 4, },
	["Гнев деревьев"]={ class = "DRUID", level = 8, },
	["Облик медведя"]={ class = "DRUID", level = 10, },
	["Устрашающий рев"]={ class = "DRUID", level = 10, },
	["Рык"]={ class = "DRUID", level = 10, },
	["Трепка"]={ class = "DRUID", level = 10, },
	["Телепортация: Лунная поляна"]={ class = "DRUID", level = 10, },
	["Исступление"]={ class = "DRUID", level = 12, },
	["Восстановление"]={ class = "DRUID", level = 12, },
	["Оглушить"]={ class = "DRUID", level = 14, },
	["Водный облик"]={ class = "DRUID", level = 16, },
	["Размах"]={ class = "DRUID", level = 16, },
	["Волшебный огонь"]={ class = "DRUID", level = 18, },
	["Спячка"]={ class = "DRUID", level = 18, },
	["Облик кошки"]={ class = "DRUID", level = 20, },
	["Когти"]={ class = "DRUID", level = 20, },
	["Крадущийся зверь"]={ class = "DRUID", level = 20, },
	["Возрождение"]={ class = "DRUID", level = 20, },
	["Разорвать"]={ class = "DRUID", level = 20, },
	["Звездный огонь"]={ class = "DRUID", level = 20, },
	["Полоснуть"]={ class = "DRUID", level = 22, },
	["Умиротворение зверя"]={ class = "DRUID", level = 22, },
	["Глубокая рана"]={ class = "DRUID", level = 24, },
	["Снятие проклятья"]={ class = "DRUID", level = 24, },
	["Тигриное неистовство"]={ class = "DRUID", level = 24, },
	["Выведение яда"]={ class = "DRUID", level = 26, },
	["Порыв"]={ class = "DRUID", level = 26, },
	["Вызывающий рев"]={ class = "DRUID", level = 28, },
	["Попятиться"]={ class = "DRUID", level = 28, },
	["Походный облик"]={ class = "DRUID", level = 30, },
	["Свирепый укус"]={ class = "DRUID", level = 32, },
	["Накинуться"]={ class = "DRUID", level = 32, },
	["Неистовое восстановление"]={ class = "DRUID", level = 36, },
	["Наскок"]={ class = "DRUID", level = 36, },
	["Облик лютого медведя"]={ class = "DRUID", level = 40, },
--++ Druid Talents ++	
	["Природный захват"]={ class = "DRUID", level = 10, },
	["Звериная атака"]={ class = "DRUID", level = 20, },
	["Рой насекомых"]={ class = "DRUID", level = 20, },
	["Знамение ясности"]={ class = "DRUID", level = 20, },
	["Волшебный огонь (сила зверя)"]={ class = "DRUID", level = 30, },
--++ Hunter Abilities ++	
	["Готовность"]={ class = "HUNTER", level = 1, },
	["Автоматическая стрельба"]={ class = "HUNTER", level = 1, },
	["Удар ящера"]={ class = "HUNTER", level = 1, },
	["Выслеживание животных"]={ class = "HUNTER", level = 1, },
	["Дух обезьяны"]={ class = "HUNTER", level = 4, },
	["Укус змеи"]={ class = "HUNTER", level = 4, },
	["Чародейский выстрел"]={ class = "HUNTER", level = 6, },
	["Метка охотника"]={ class = "HUNTER", level = 6, },
	["Шокирующий выстрел"]={ class = "HUNTER", level = 8, },
	["Дух ястреба"]={ class = "HUNTER", level = 10, },
	["Призыв питомца"]={ class = "HUNTER", level = 10, },
	["Прогнать питомца"]={ class = "HUNTER", level = 10, },
	["Кормление питомца"]={ class = "HUNTER", level = 10, },
	["Воскрешение питомца"]={ class = "HUNTER", level = 10, },
	["Приручение зверя"]={ class = "HUNTER", level = 10, },
	["Отвлекающий выстрел"]={ class = "HUNTER", level = 12, },
	["Лечение питомца"]={ class = "HUNTER", level = 12, },
	["Подрезать крылья"]={ class = "HUNTER", level = 12, },
	["Орлиный глаз"]={ class = "HUNTER", level = 14, },
	["Звериный глаз"]={ class = "HUNTER", level = 14, },
	["Отпугивание зверя"]={ class = "HUNTER", level = 14, },
	["Обжигающая ловушка"]={ class = "HUNTER", level = 16, },
	["Укус мангуста"]={ class = "HUNTER", level = 16, },
	["Залп"]={ class = "HUNTER", level = 18, },
	["Выслеживание нежити"]={ class = "HUNTER", level = 18, },
	["Дух гепарда"]={ class = "HUNTER", level = 20, },
	["Отрыв"]={ class = "HUNTER", level = 20, },
	["Замораживающая ловушка"]={ class = "HUNTER", level = 20, },
	["Жало скорпида"]={ class = "HUNTER", level = 22, },
	["Знание зверя"]={ class = "HUNTER", level = 24, },
	["Выслеживание скрытого"]={ class = "HUNTER", level = 24, },
	["Быстрая стрельба"]={ class = "HUNTER", level = 26, },
	["Выслеживание элементалей"]={ class = "HUNTER", level = 26, },
	["Ледяная ловушка"]={ class = "HUNTER", level = 28, },
	["Дух зверя"]={ class = "HUNTER", level = 30, },
	["Притвориться мертвым"]={ class = "HUNTER", level = 30, },
	["Осветительная ракета"]={ class = "HUNTER", level = 32, },
	["Выслеживание демонов"]={ class = "HUNTER", level = 32, },
	["Взрывная ловушка"]={ class = "HUNTER", level = 34, },
	["Жало гадюки"]={ class = "HUNTER", level = 36, },
	["Дух стаи"]={ class = "HUNTER", level = 40, },
	["Выслеживание великанов"]={ class = "HUNTER", level = 40, },
	["Град стрел"]={ class = "HUNTER", level = 40, },
	["Дух дикой природы"]={ class = "HUNTER", level = 46, },
	["Выслеживание драконов"]={ class = "HUNTER", level = 50, },
	["Усмиряющий выстрел"]={ class = "HUNTER", level = 60, },
--++ Hunter Talents ++	
	["Прицельный выстрел"]={ class = "HUNTER", level = 20, },
	["Сдерживание"]={ class = "HUNTER", level = 20, },
	["Контратака"]={ class = "HUNTER", level = 30, },
	["Устрашение"]={ class = "HUNTER", level = 30, },
	["Дезориентирующий выстрел"]={ class = "HUNTER", level = 30, },
	["Звериный гнев"]={ class = "HUNTER", level = 40, },
	["Жало виверны"]={ class = "HUNTER", level = 40, },
--++ Mage Abilities ++	
	["Огненный шар"]={ class = "MAGE", level = 1, },
	["Морозный доспех"]={ class = "MAGE", level = 1, },
	["Ледяная стрела"]={ class = "MAGE", level = 4, },
	["Сотворение воды"]={ class = "MAGE", level = 4, },
	["Огненный взрыв"]={ class = "MAGE", level = 6, },
	["Сотворение пищи"]={ class = "MAGE", level = 6, },
	["Чародейские снаряды"]={ class = "MAGE", level = 8, },
	["Превращение"]={ class = "MAGE", level = 8, },
	["Кольцо льда"]={ class = "MAGE", level = 10, },
	["Чародейский взрыв"]={ class = "MAGE", level = 14, },
	["Распознавание магии"]={ class = "MAGE", level = 16, },
	["Огненный столб"]={ class = "MAGE", level = 16, },
	["Снятие малого проклятия"]={ class = "MAGE", level = 18, },
	["Скачок"]={ class = "MAGE", level = 20, },
	["Снежная буря"]={ class = "MAGE", level = 20, },
	["Прилив сил"]={ class = "MAGE", level = 20, },
	["Защита от огня"]={ class = "MAGE", level = 20, },
	["Щит маны"]={ class = "MAGE", level = 20, },
	["Телепортация: Стальгорн"]={ class = "MAGE", level = 20, },
	["Телепортация: Оргриммар"]={ class = "MAGE", level = 20, },
	["Телепортация: Штормград"]={ class = "MAGE", level = 20, },
	["Телепортация:Подгород"]={ class = "MAGE", level = 20, },
	["Защита от магии льда"]={ class = "MAGE", level = 22, },
	["Ожог"]={ class = "MAGE", level = 22, },
	["Антимагия"]={ class = "MAGE", level = 24, },
	["Конус холода"]={ class = "MAGE", level = 26, },
	["Сотворение агата маны"]={ class = "MAGE", level = 28, },
	["Ледяной доспех"]={ class = "MAGE", level = 30, },
	["Телепортация: Дарнасс"]={ class = "MAGE", level = 30, },
	["Телепортация: Громовой Утес"]={ class = "MAGE", level = 30, },
	["Магический доспех"]={ class = "MAGE", level = 34, },
	["Сотворение нефрита маны"]={ class = "MAGE", level = 38, },
	["Портал в Стальгорн"]={ class = "MAGE", level = 40, },
	["Портал в Оргриммар"]={ class = "MAGE", level = 40, },
	["Портал в Штормград"]={ class = "MAGE", level = 40, },
	["Портал в Подгород"]={ class = "MAGE", level = 40, },
	["Сотворение цитрина маны"]={ class = "MAGE", level = 48, },
	["Портал: Дарнасс"]={ class = "MAGE", level = 50, },
	["Портал в Громовой Утес"]={ class = "MAGE", level = 50, },
	["Чародейская гениальность"]={ class = "MAGE", level = 56, },
	["Сотворение рубина маны"]={ class = "MAGE", level = 58, },
	["Превращение в корову"]={ class = "MAGE", level = 60, },
	["Превращение"]={ class = "MAGE", level = 60, },
	["Превращение"]={ class = "MAGE", level = 60, },
--++ Mage Talents ++	
	["Холодная хватка"]={ class = "MAGE", level = 20, },
	["Огненная глыба"]={ class = "MAGE", level = 20, },
	["Взрывная волна"]={ class = "MAGE", level = 30, },
	["Ледяная глыба"]={ class = "MAGE", level = 30, },
	["Присутствие разума"]={ class = "MAGE", level = 30, },
	["Мощь тайной магии"]={ class = "MAGE", level = 40, },
	["Возгорание"]={ class = "MAGE", level = 40, },
	["Ледяная преграда"]={ class = "MAGE", level = 40, },
--++ Paladin Abilities ++	
	["Свет небес"]={ class = "PALADIN", level = 1, },
	["Печать праведности"]={ class = "PALADIN", level = 1, },
	["Правосудие"]={ class = "PALADIN", level = 4, },
	["Божественная защита"]={ class = "PALADIN", level = 6, },
	["Печать воина Cвета"]={ class = "PALADIN", level = 6, },
	["Молот правосудия"]={ class = "PALADIN", level = 8, },
	["Очищение"]={ class = "PALADIN", level = 8, },
	["Возложение рук"]={ class = "PALADIN", level = 10, },
	["Искупление"]={ class = "PALADIN", level = 12, },
	["Праведное неистовство"]={ class = "PALADIN", level = 16, },
	["Экзорцизм"]={ class = "PALADIN", level = 20, },
	["Вспышка Света"]={ class = "PALADIN", level = 20, },
	["Чутье на нежить"]={ class = "PALADIN", level = 20, },
	["Печать справедливости"]={ class = "PALADIN", level = 22, },
	["Изгнание нежити"]={ class = "PALADIN", level = 24, },
	["Благословение спасения"]={ class = "PALADIN", level = 26, },
	["Божественное вмешательство"]={ class = "PALADIN", level = 30, },
	["Печать Cвета"]={ class = "PALADIN", level = 30, },
	["Божественный щит"]={ class = "PALADIN", level = 34, },
	["Печать мудрости"]={ class = "PALADIN", level = 38, },
	["Благословение Света"]={ class = "PALADIN", level = 40, },
	["Вызов боевого коня"]={ class = "PALADIN", level = 40, },
	["Очищение"]={ class = "PALADIN", level = 42, },
	["Молот гнева"]={ class = "PALADIN", level = 44, },
	["Гнев небес"]={ class = "PALADIN", level = 50, },
	["Призыв скакуна"]={ class = "PALADIN", level = 60, },
--++ Paladin Talents ++	
	["Освящение"]={ class = "PALADIN", level = 20, },
	["Печать повиновения"]={ class = "PALADIN", level = 20, },
	["Божественное одобрение"]={ class = "PALADIN", level = 30, },
	["Щит небес"]={ class = "PALADIN", level = 40, },
	["Шок небес"]={ class = "PALADIN", level = 40, },
	["Покаяние"]={ class = "PALADIN", level = 40, },
--++ Priest Abilities ++	
	["Малое исцеление"]={ class = "PRIEST", level = 1, },
	["Кара"]={ class = "PRIEST", level = 1, },
	["Слово Тьмы: Боль"]={ class = "PRIEST", level = 4, },
	["Уход в тень"]={ class = "PRIEST", level = 8, },
	["Молитва отчаяния"]={ class = "PRIEST", level = 10, },
	["Обессиливающий сглаз"]={ class = "PRIEST", level = 10, },
	["Взрыв разума"]={ class = "PRIEST", level = 10, },
	["Воскрешение"]={ class = "PRIEST", level = 10, },
	["Звездные осколки"]={ class = "PRIEST", level = 10, },
	["Прикосновение слабости"]={ class = "PRIEST", level = 10, },
	["Внутренний огонь"]={ class = "PRIEST", level = 12, },
	["Ментальный крик"]={ class = "PRIEST", level = 14, },
	["Исцеление"]={ class = "PRIEST", level = 16, },
	["Рассеивание заклинаний"]={ class = "PRIEST", level = 18, },
	["Всепожирающая чума"]={ class = "PRIEST", level = 20, },
	["Благодать Элуны"]={ class = "PRIEST", level = 20, },
	["Ответная реакция"]={ class = "PRIEST", level = 20, },
	["Быстрое исцеление"]={ class = "PRIEST", level = 20, },
	["Священный огонь"]={ class = "PRIEST", level = 20, },
	["Усмирение"]={ class = "PRIEST", level = 20, },
	["Сковывание нежити"]={ class = "PRIEST", level = 20, },
	["Страж Тьмы"]={ class = "PRIEST", level = 20, },
	["Внутреннее зрение"]={ class = "PRIEST", level = 22, },
	["Сожжение маны"]={ class = "PRIEST", level = 24, },
	["Контроль над разумом"]={ class = "PRIEST", level = 30, },
	["Молитва исцеления"]={ class = "PRIEST", level = 30, },
	["Снятие болезни"]={ class = "PRIEST", level = 32, },
	["Левитация"]={ class = "PRIEST", level = 34, },
	["Большее исцеление"]={ class = "PRIEST", level = 40, },
--++ Priest Talents ++	
	["Кольцо света"]={ class = "PRIEST", level = 20, },
	["Внутреннее сосредоточение"]={ class = "PRIEST", level = 20, },
	["Пытка разума"]={ class = "PRIEST", level = 20, },
	["Молчание"]={ class = "PRIEST", level = 30, },
	["Колодец Света"]={ class = "PRIEST", level = 40, },
	["Облик Тьмы"]={ class = "PRIEST", level = 40, },
--++ Rogue Abilities ++	
	["Потрошение"]={ class = "ROGUE", level = 1, },
	["Взлом замка"]={ class = "ROGUE", level = 1, },
	["Коварный удар"]={ class = "ROGUE", level = 1, },
	["Незаметность"]={ class = "ROGUE", level = 1, },
	["Удар в спину"]={ class = "ROGUE", level = 4, },
	["Обшаривание карманов"]={ class = "ROGUE", level = 4, },
	["Парализующий удар"]={ class = "ROGUE", level = 6, },
	["Ускользание"]={ class = "ROGUE", level = 8, },
	["Ошеломление"]={ class = "ROGUE", level = 10, },
	["Мясорубка"]={ class = "ROGUE", level = 10, },
	["Спринт"]={ class = "ROGUE", level = 10, },
	["Пинок"]={ class = "ROGUE", level = 12, },
	["Ослабление доспеха"]={ class = "ROGUE", level = 14, },
	["Гаррота"]={ class = "ROGUE", level = 14, },
	["Ложный выпад"]={ class = "ROGUE", level = 16, },
	["Внезапный удар"]={ class = "ROGUE", level = 18, },
	["Яды"]={ class = "ROGUE", level = 20, },
	["Рваная рана"]={ class = "ROGUE", level = 20, },
	["Калечащий яд"]={ class = "ROGUE", level = 20, },
	["Быстродействующий яд"]={ class = "ROGUE", level = 20, },
	["Отвлечение"]={ class = "ROGUE", level = 22, },
	["Исчезновение"]={ class = "ROGUE", level = 22, },
	["Обнаружение ловушек"]={ class = "ROGUE", level = 24, },
	["Дурманящий яд"]={ class = "ROGUE", level = 24, },
	["Подлый трюк"]={ class = "ROGUE", level = 26, },
	["Обезвреживание ловушки"]={ class = "ROGUE", level = 30, },
	["Удар по почкам"]={ class = "ROGUE", level = 30, },
	["Смертельный яд"]={ class = "ROGUE", level = 30, },
	["Нейтрализующий яд"]={ class = "ROGUE", level = 32, },
	["Ослепление"]={ class = "ROGUE", level = 34, },
	["Ослепляющий порошок"]={ class = "ROGUE", level = 34, },
	["Безопасное падение"]={ class = "ROGUE", level = 40, },
--++ Rogue Talents ++	
	["Призрачный удар"]={ class = "ROGUE", level = 20, },
	["Ответный удар"]={ class = "ROGUE", level = 20, },
	["Шквал клинков"]={ class = "ROGUE", level = 30, },
	["Хладнокровие"]={ class = "ROGUE", level = 30, },
	["Кровоизлияние"]={ class = "ROGUE", level = 30, },
	["Подготовка"]={ class = "ROGUE", level = 30, },
	["Выброс адреналина"]={ class = "ROGUE", level = 40, },
	["Умысел"]={ class = "ROGUE", level = 40, },
--++ Shaman Abilities ++	
	["Волна исцеления"]={ class = "SHAMAN", level = 1, },
	["Молния"]={ class = "SHAMAN", level = 1, },
	["Оружие Камнедробителя"]={ class = "SHAMAN", level = 1, },
	["Земной шок"]={ class = "SHAMAN", level = 4, },
	["Тотем каменной кожи"]={ class = "SHAMAN", level = 4, },
	["Тотем оков земли"]={ class = "SHAMAN", level = 6, },
	["Щит молний"]={ class = "SHAMAN", level = 8, },
	["Тотем каменного когтя"]={ class = "SHAMAN", level = 8, },
	["Огненный шок"]={ class = "SHAMAN", level = 10, },
	["Оружие языка пламени"]={ class = "SHAMAN", level = 10, },
	["Опаляющий тотем"]={ class = "SHAMAN", level = 10, },
	["Тотем силы земли"]={ class = "SHAMAN", level = 10, },
	["Дух предков"]={ class = "SHAMAN", level = 12, },
	["Тотем кольца огня"]={ class = "SHAMAN", level = 12, },
	["Развеяние магии"]={ class = "SHAMAN", level = 12, },
	["Тотем трепета"]={ class = "SHAMAN", level = 18, },
	["Ледяной шок"]={ class = "SHAMAN", level = 20, },
	["Оружие ледяного клейма"]={ class = "SHAMAN", level = 20, },
	["Призрачный волк"]={ class = "SHAMAN", level = 20, },
	["Тотем исцеляющего потока"]={ class = "SHAMAN", level = 20, },
	["Малая волна исцеления"]={ class = "SHAMAN", level = 20, },
	["Тотем противоядия"]={ class = "SHAMAN", level = 22, },
	["Тотем сопротивления льду"]={ class = "SHAMAN", level = 24, },
	["Дальнее зрение"]={ class = "SHAMAN", level = 26, },
	["Тотем магмы"]={ class = "SHAMAN", level = 26, },
	["Тотем источника маны"]={ class = "SHAMAN", level = 26, },
	["Тотем сопротивления огню"]={ class = "SHAMAN", level = 28, },
	["Тотем языка пламени"]={ class = "SHAMAN", level = 28, },
	["Астральное возвращение"]={ class = "SHAMAN", level = 30, },
	["Тотем заземления"]={ class = "SHAMAN", level = 30, },
	["Тотем сопротивления силам природы"]={ class = "SHAMAN", level = 30, },
	["Восстание из мертвых"]={ class = "SHAMAN", level = 30, },
	["Оружие неистовства ветра"]={ class = "SHAMAN", level = 30, },
	["Цепная молния"]={ class = "SHAMAN", level = 32, },
	["Тотем неистовства ветра"]={ class = "SHAMAN", level = 32, },
	["Сторожевой тотем"]={ class = "SHAMAN", level = 34, },
	["Тотем стены ветра"]={ class = "SHAMAN", level = 36, },
	["Тотем очищения от болезней"]={ class = "SHAMAN", level = 38, },
	["Цепное исцеление"]={ class = "SHAMAN", level = 40, },
	["Тотем легкости воздуха"]={ class = "SHAMAN", level = 42, },
	["Тотем безветрия"]={ class = "SHAMAN", level = 50, },
--++ Shaman Talents ++	
	["Парирование"]={ class = "SHAMAN", level = 30, },
	["Покорение стихий"]={ class = "SHAMAN", level = 40, },
	["Тотем прилива маны"]={ class = "SHAMAN", level = 40, },
	["Удар бури"]={ class = "SHAMAN", level = 40, },
--++ Warlock Abilities ++	
	["Шкура демона"]={ class = "WARLOCK", level = 1, },
	["Жертвенный огонь"]={ class = "WARLOCK", level = 1, },
	["Стрела Тьмы"]={ class = "WARLOCK", level = 1, },
	["Призыв беса"]={ class = "WARLOCK", level = 1, },
	["Порча"]={ class = "WARLOCK", level = 4, },
	["Проклятие слабости"]={ class = "WARLOCK", level = 4, },
	["Жизнеотвод"]={ class = "WARLOCK", level = 6, },
	["Проклятие агонии"]={ class = "WARLOCK", level = 8, },
	["Страх"]={ class = "WARLOCK", level = 8, },
	["Создание слабого камня здоровья"]={ class = "WARLOCK", level = 10, },
	["Похищение души"]={ class = "WARLOCK", level = 10, },
	["Призыв демона Бездны"]={ class = "WARLOCK", level = 10, },
	["Канал здоровья"]={ class = "WARLOCK", level = 12, },
	["Проклятие безрассудства"]={ class = "WARLOCK", level = 14, },
	["Похищение жизни"]={ class = "WARLOCK", level = 14, },
	["Нескончаемое дыхание"]={ class = "WARLOCK", level = 16, },
	["Жгучая боль"]={ class = "WARLOCK", level = 18, },
	["Создание крошечного камня души"]={ class = "WARLOCK", level = 18, },
	["Демонический доспех"]={ class = "WARLOCK", level = 20, },
	["Огненный ливень"]={ class = "WARLOCK", level = 20, },
	["Ритуал призывания"]={ class = "WARLOCK", level = 20, },
	["Призыв суккуба"]={ class = "WARLOCK", level = 20, },
	["Создание малого камня здоровья"]={ class = "WARLOCK", level = 22, },
	["Око Килрогга"]={ class = "WARLOCK", level = 22, },
	["Похищение маны"]={ class = "WARLOCK", level = 24, },
	["Чутье на демонов"]={ class = "WARLOCK", level = 24, },
	["Проклятие косноязычия"]={ class = "WARLOCK", level = 26, },
	["Обнаружение обычной невидимости"]={ class = "WARLOCK", level = 26, },
	["Изгнание"]={ class = "WARLOCK", level = 28, },
	["Создание малого камня огня"]={ class = "WARLOCK", level = 28, },
	["Порабощение демона"]={ class = "WARLOCK", level = 30, },
	["Адское Пламя"]={ class = "WARLOCK", level = 30, },
	["Призыв охотника Скверны"]={ class = "WARLOCK", level = 30, },
	["Создание малого камня души"]={ class = "WARLOCK", level = 30, },
	["Проклятие стихий"]={ class = "WARLOCK", level = 32, },
	["Защита от темной магии"]={ class = "WARLOCK", level = 32, },
	["Создание камня здоровья"]={ class = "WARLOCK", level = 34, },
	["Создание камня огня"]={ class = "WARLOCK", level = 36, },
	["Создание камня чар"]={ class = "WARLOCK", level = 36, },
	["Обнаружение невидимости"]={ class = "WARLOCK", level = 38, },
	["Вой ужаса"]={ class = "WARLOCK", level = 40, },
	["Призывание коня Скверны"]={ class = "WARLOCK", level = 40, },
	["Создание камня души"]={ class = "WARLOCK", level = 40, },
	["Лик смерти"]={ class = "WARLOCK", level = 42, },
	["Проклятие Тьмы"]={ class = "WARLOCK", level = 44, },
	["Создание большого камня здоровья"]={ class = "WARLOCK", level = 46, },
	["Создание большого камня огня"]={ class = "WARLOCK", level = 46, },
	["Ожог души"]={ class = "WARLOCK", level = 48, },
	["Создание большого камня чар"]={ class = "WARLOCK", level = 48, },
	["Обнаружение большей невидимости"]={ class = "WARLOCK", level = 50, },
	["Инфернал"]={ class = "WARLOCK", level = 50, },
	["Создание большого камня души"]={ class = "WARLOCK", level = 50, },
	["Создание крупного камня огня"]={ class = "WARLOCK", level = 56, },
	["Создание крупного камня здоровья"]={ class = "WARLOCK", level = 58, },
	["Проклятие рока"]={ class = "WARLOCK", level = 60, },
	["Ритуал Рока"]={ class = "WARLOCK", level = 60, },
	["Призыв коня погибели"]={ class = "WARLOCK", level = 60, },
	["Создание крупного камня души"]={ class = "WARLOCK", level = 60, },
	["Создание крупного камня чар"]={ class = "WARLOCK", level = 60, },
--++ Warlock Talents ++	
	["Усиление проклятия"]={ class = "WARLOCK", level = 20, },
	["Господство Скверны"]={ class = "WARLOCK", level = 20, },
	["Ожог Тьмы"]={ class = "WARLOCK", level = 20, },
	["Проклятие изнеможения"]={ class = "WARLOCK", level = 30, },
	["Демоническое жертвоприношение"]={ class = "WARLOCK", level = 30, },
	["Вытягивание жизни"]={ class = "WARLOCK", level = 30, },
	["Поджигание"]={ class = "WARLOCK", level = 40, },
	["Темный союз"]={ class = "WARLOCK", level = 40, },
	["Связка души"]={ class = "WARLOCK", level = 40, },
--++ Warrior Abilities ++	
	["Боевая стойка"]={ class = "WARRIOR", level = 1, },
	["Удар героя"]={ class = "WARRIOR", level = 1, },
	["Улучшенная зуботычина"]={ class = "WARRIOR", level = 1, },
	["Рывок"]={ class = "WARRIOR", level = 4, },
	["Кровопускание"]={ class = "WARRIOR", level = 4, },
	["Удар грома"]={ class = "WARRIOR", level = 6, },
	["Подрезать сухожилия"]={ class = "WARRIOR", level = 8, },
	["Кровавая ярость"]={ class = "WARRIOR", level = 10, },
	["Оборонительная стойка"]={ class = "WARRIOR", level = 10, },
	["Раскол брони"]={ class = "WARRIOR", level = 10, },
	["Провокация"]={ class = "WARRIOR", level = 10, },
	["Превосходство"]={ class = "WARRIOR", level = 12, },
	["Удар щитом"]={ class = "WARRIOR", level = 12, },
	["Деморализующий крик"]={ class = "WARRIOR", level = 14, },
	["Реванш"]={ class = "WARRIOR", level = 14, },
	["Дразнящий удар"]={ class = "WARRIOR", level = 16, },
	["Блок щитом"]={ class = "WARRIOR", level = 16, },
	["Разоружение"]={ class = "WARRIOR", level = 18, },
	["Рассекающий удар"]={ class = "WARRIOR", level = 20, },
	["Возмездие"]={ class = "WARRIOR", level = 20, },
	["Устрашающий крик"]={ class = "WARRIOR", level = 22, },
	["Казнь"]={ class = "WARRIOR", level = 24, },
	["Вызывающий крик"]={ class = "WARRIOR", level = 26, },
	["Глухая оборона"]={ class = "WARRIOR", level = 28, },
	["Стойка берсерка"]={ class = "WARRIOR", level = 30, },
	["Перехват"]={ class = "WARRIOR", level = 30, },
	["Сокрушение"]={ class = "WARRIOR", level = 30, },
	["Ярость берсерка"]={ class = "WARRIOR", level = 32, },
	["Вихрь"]={ class = "WARRIOR", level = 36, },
	["Зуботычина"]={ class = "WARRIOR", level = 38, },
	["Безрассудство"]={ class = "WARRIOR", level = 50, },
--++ Warrior Talents ++	
	["Ни шагу назад"]={ class = "WARRIOR", level = 20, },
	["Пронзительный вой"]={ class = "WARRIOR", level = 20, },
	["Оглушающий удар"]={ class = "WARRIOR", level = 30, },
	["Инстинкт смерти"]={ class = "WARRIOR", level = 30, },
	["Размашистые удары"]={ class = "WARRIOR", level = 30, },
	["Кровожадность"]={ class = "WARRIOR", level = 40, },
	["Смертельный удар"]={ class = "WARRIOR", level = 40, },
	["Сокрушение щитом"]={ class = "WARRIOR", level = 40, },
};

Spy_IgnoreList = {

};
 
