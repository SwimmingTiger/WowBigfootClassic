--[[
	Russian Localization
		***
--]]

local CONFIG, Config = ...
local L = LibStub('AceLocale-3.0'):NewLocale(CONFIG, 'ruRU')
if not L then return end

-- general
L.GeneralDesc = 'Общие функции, которые могут быть переключены в зависимости от ваших предпочтений.'
L.Locked = 'Закрепить позицию окна'
L.Fading = 'Включить затухание окна'
L.TipCount = 'Показывать в подсказках количество предметов'
L.FlashFind = 'Включить вспышку поиска'
L.EmptySlots = 'Отображать фон пустых ячеек'
L.DisplayBlizzard = 'Открывать стандартные окна Blizzard для скрытых сумок.'

-- frame
L.FrameSettings = 'Настройки окна'
L.FrameSettingsDesc = 'Параметры конфигурации для конкретного окна ADDON.'
L.Frame = 'Окно'
L.Enabled = 'Включить окна'
L.CharacterSpecific = 'Настройки для текущего персонажа'
L.ExclusiveReagent = 'Отдельный банк материалов'

L.BagToggle = 'Кнопка сумок'
L.Money = 'Золото'
L.Broker = 'DataBroker'
L.Sort = 'Кнопка Сортировки'
L.Search = 'Кнопка поиска'
L.Options = 'Кнопка настройки'

L.Appearance = 'Внешний вид'
L.Layer = 'Слой окна'
L.BagBreak = 'Прерывание размещения сумок'
L.ReverseBags = 'Обратный порядок сумок'
L.ReverseSlots = 'Обратный порядок ячеек'

L.Color = 'Цвет окна'
L.BorderColor = 'Цвет границы окна'

L.Strata = 'Слой окна'
L.Columns = 'Колонок'
L.Scale = 'Масштаб'
L.ItemScale = 'Масштаб предметов'
L.Spacing = 'Промежуток'
L.Alpha = 'Прозрачность'

-- auto display
L.DisplaySettings = 'Автопоявление'
L.DisplaySettingsDesc = 'Эти параметры позволяют настроить ваш инвентарь. Автоматически открывается или закрывается из-за игровых событий.'
L.DisplayInventory = 'Открывать сумку'
L.CloseInventory = 'Закрывать сумку'

L.DisplayBank = 'При посещении банка'
L.DisplayAuction = 'При посещении аукциона'
L.DisplayTrade = 'При обмене предметами'
L.DisplayCraft = 'Во время изготовления'
L.DisplayMail = 'При проверке почты'
L.DisplayGuildbank = 'При посещении банка гильдии'
L.DisplayPlayer = 'При открытии окна персонажа'
L.DisplayGems = 'При вставке камней в предметы'

L.CloseCombat = 'При начале боя'
L.CloseVehicle = 'При посадке на средство передвижения'
L.CloseBank = 'При закрытии окна банка'
L.CloseVendor = 'При закрытии окна продавца'

-- colors
L.ColorSettings = 'Настройка окраски'
L.ColorSettingsDesc = 'Эти параметры позволяют изменять рамки ячеек предметов в ADDON для удобной идентификации.'
L.GlowQuality = 'Подсвечивать рамки предметов по их качеству' 
L.GlowNew = 'Подсвечивать рамки новых предметов' 
L.GlowQuest = 'Подсвечивать рамки предметов для заданий'
L.GlowUnusable = 'Подсвечивать рамки непригодных предметов'
L.GlowSets = 'Подсвечивать рамки комплектов экипировки'
L.ColorSlots = 'Цвет пустых ячеек по типу сумки'

L.NormalColor = 'Обычная сумка'
L.LeatherColor = 'Сумка кожевника'
L.InscribeColor = 'Сумка начертателя'
L.HerbColor = 'Сумка травника'
L.EnchantColor = 'Сумка зачарователя'
L.EngineerColor = 'Сумка инженера'
L.GemColor = 'Сумка ювелира'
L.MineColor = 'Сумка шахтера'
L.TackleColor = 'Сумка рыбака'
L.RefrigeColor = 'Сумка кулинара'
L.ReagentColor = 'Банк материалов'
L.GlowAlpha = 'Яркость подсветки'
