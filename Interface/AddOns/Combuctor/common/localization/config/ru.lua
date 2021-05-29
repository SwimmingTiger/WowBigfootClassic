--[[
	Russian Localization
--]]

local CONFIG = ...
local L = LibStub('AceLocale-3.0'):NewLocale(CONFIG, 'ruRU')
if not L then return end

-- general
L.GeneralOptionsDesc = 'Общие функции, которые вы можете настроить в соответствии со своими предпочтениями.'
L.Locked = 'Закрепить окна'
L.Fading = 'Включить эффект затухания'
L.TipCount = 'Показывать в подсказках количество предметов'
L.CountGuild = 'Учитывать банк гильдии'
L.FlashFind = 'Включить мгновенный поиск'
L.DisplayBlizzard = 'Использовать стандартные окна для скрытых сумок'
L.DisplayBlizzardTip = 'Если настройка включена, скрытые сумки инвентаря или банка будут использовать стандартный интерфейс Blizzard.\n\n|cffff1919Потребуется перезагрузка интерфейса.|r'
L.ConfirmGlobals = 'Уверены, что хотите отключить использование индивидуальных настроек для этого персонажа? Все индивидуальные настройки будут потеряны.'
L.CharacterSpecific = 'Использовать отдельные настройки для текущего персонажа'

-- frame
L.FrameOptions = 'Настройки окна'
L.FrameOptionsDesc = 'Настройки окон %s.'
L.Frame = 'Окно'
L.Enabled = 'Включить окно'
L.EnabledTip = 'Если настройка отключена, Bagnon не станет заменять это стандартное окно Blizzard своим собственным.\n\n|cffff1919Потребуется перезагрузка интерфейса.|r'
L.ActPanel = 'Поведение, как у стандартных панелей'
L.ActPanelTip = [[
Если настройка включена, эта панель будет вести себя, как стандартные панели (например, |cffffffffКнига заклинаний|r
или |cffffffffПоиск подземелий|r), и станет неподвижной.]]

L.BagToggle = 'Кнопка сумок'
L.Money = 'Золото'
L.Broker = 'DataBroker'
L.Sort = 'Кнопка сортировки'
L.Search = 'Кнопка поиска'
L.Options = 'Кнопка настроек'
L.ExclusiveReagent = 'Банк материалов отдельно'
L.LeftTabs = 'Категории слева'
L.LeftTabsTip = [[
Если настройка включена, боковые вкладки будут размещены слева от окна.]]

L.Appearance = 'Внешний вид'
L.Layer = 'Слой'
L.BagBreak = 'Каждая сумка с новой строки'
L.ReverseBags = 'Обратный порядок сумок'
L.ReverseSlots = 'Обратный порядок ячеек'

L.Color = 'Цвет фона окна'
L.BorderColor = 'Цвет границы окна'

L.Strata = 'Слой окна'
L.Columns = 'Столбцы'
L.Scale = 'Масштаб'
L.ItemScale = 'Масштаб предметов'
L.Spacing = 'Промежуток'
L.Alpha = 'Прозрачность'

-- auto display
L.DisplayOptions = 'Автопоявление'
L.DisplayOptionsDesc = 'Эти настройки позволяют автоматически открывать или закрывать окно инвентаря в зависимости от игровых событий.'
L.DisplayInventory = 'Открывать сумки'
L.CloseInventory = 'Закрывать сумки'

L.DisplayBank = 'При посещении банка'
L.DisplayGuildbank = 'При посещении банка гильдии'
L.DisplayAuction = 'При посещении аукциона'
L.DisplayMail = 'При проверке почты'
L.DisplayTrade = 'При обмене предметами'
L.DisplayScrapping = 'При утилизации экипировки'
L.DisplayGems = 'При вставке камней в предметы'
L.DisplayCraft = 'При изготовлении предметов'
L.DisplayPlayer = 'При открытии окна персонажа'

L.CloseCombat = 'При начале боя'
L.CloseVehicle = 'При посадке на средство передвижения'
L.CloseBank = 'При закрытии окна банка'
L.CloseVendor = 'При закрытии окна торговца'
L.CloseMap = 'При открытии карты мира'

-- colors
L.ColorOptions = 'Настройки окраски'
L.ColorOptionsDesc = 'Эти настройки позволяют изменять цвет ячеек в %s для облегчения идентификации предметов.'
L.GlowQuality = 'Цвет рамок зависит от качества'
L.GlowQuest = 'Выделять цветом квестовые'
L.GlowUnusable = 'Выделять цветом непригодные'
L.GlowSets = 'Выделять цветом комплекты'
L.GlowNew = 'Подсвечивать новые'
L.GlowPoor = 'Помечать барахло'
L.GlowAlpha = 'Яркость подсветки'

L.EmptySlots = 'Показывать фон'
L.ColorSlots = 'Цвет фона зависит от сумки'
L.NormalColor = 'Обычная сумка'
L.KeyColor = 'Ключница'
L.QuiverColor = 'Колчан'
L.SoulColor = 'Сумка душ'
L.ReagentColor = 'Банк материалов'
L.LeatherColor = 'Сумка кожевника'
L.InscribeColor = 'Сумка начертателя'
L.HerbColor = 'Сумка травника'
L.EnchantColor = 'Сумка зачарователя'
L.EngineerColor = 'Сумка инженера'
L.GemColor = 'Сумка ювелира'
L.MineColor = 'Сумка горняка'
L.TackleColor = 'Сумка рыбака'
L.FridgeColor = 'Сумка кулинара'

-- rulesets
L.RuleOptions = 'Категории предметов'
L.RuleOptionsDesc = 'Эти настройки позволяют выбрать категории предметов и порядок их следования.'
