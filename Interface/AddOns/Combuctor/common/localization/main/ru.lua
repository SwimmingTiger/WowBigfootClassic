--[[
	Russian Localization
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'ruRU')
if not L then return end

--keybindings
L.ToggleBags = 'Переключить инвентарь'
L.ToggleBank = 'Переключить банк'
L.ToggleGuild = 'Переключить банк гильдии'
L.ToggleVault = 'Переключить Хранилище Бездны'

--terminal
L.Commands = 'Команды:'
L.CmdShowInventory = 'открыть/закрыть инвентарь'
L.CmdShowBank = 'открыть/закрыть банк'
L.CmdShowGuild = 'открыть/закрыть банк гильдии'
L.CmdShowVault = 'открыть/закрыть Хранилище Бездны'
L.CmdShowVersion = 'сообщить текущую версию модификации'
L.CmdShowOptions = 'открыть меню настроек'
L.Updated = 'Обновлено до v%s'

--frame titles
L.TitleBags = 'Инвентарь |3-1(%s)'
L.TitleBank = 'Банк |3-1(%s)'
L.TitleVault = 'Хранилище Бездны |3-1(%s)'

--dropdowns
L.TitleFrames = 'Окна %s'
L.SelectCharacter = 'Выберите персонажа'
L.ConfirmDelete = 'Уверены, что хотите удалить кэшированные данные персонажа %s?'

--interactions
L.Click = 'Клик'
L.Drag = '<Двигать>'
L.LeftClick = '<Левый клик>'
L.RightClick = '<Правый клик>'
L.DoubleClick = '<Двойной клик>'
L.ShiftClick = '<Shift+клик>'

--tooltips
L.Total = 'Всего'
L.GuildFunds = 'Золото гильдии'
L.TipGoldOnRealm = 'Всего золота на %s'
L.NumWithdraw = '%d снять'
L.NumDeposit = '%d внести'
L.NumRemainingWithdrawals = 'Осталось снятий: %d'

--action tooltips
L.TipChangePlayer = '%s — просмотреть предметы другого персонажа.'
L.TipCleanItems = '%s — сортировать предметы.'
L.TipConfigure = '%s — настроить это окно.'
L.TipDepositReagents = '%s — положить реагенты в банк.'
L.TipDeposit = '%s — внести.'
L.TipWithdraw = '%s — снять (осталось: %s).'
L.TipFrameToggle = '%s — переключить на другое окно.'
L.TipHideBag = '%s — скрыть эту сумку.'
L.TipHideBags = '%s — скрыть область сумок.'
L.TipHideSearch = '%s — скрыть поисковую строку.'
L.TipMove = '%s — переместить.'
L.TipPurchaseBag = '%s — приобрести банковскую ячейку.'
L.TipResetPlayer = '%s — вернуться к текущему персонажу.'
L.TipShowBag = '%s — показать эту сумку.'
L.TipShowBags = '%s — показать область сумок.'
L.TipShowBank = '%s — переключить банк.'
L.TipShowInventory = '%s — переключить инвентарь.'
L.TipShowOptions = '%s — открыть настройки.'
L.TipShowSearch = '%s — искать.'

--item tooltips
L.TipCountEquip = 'Надето: %d'
L.TipCountBags = 'Сумки: %d'
L.TipCountBank = 'Банк: %d'
L.TipCountVault = 'Бездна: %d'
L.TipCountGuild = 'Гильдия: %d'
L.TipDelimiter = '|'

--dialogs
L.AskMafia = 'Взять в долг у мафии'
L.ConfirmTransfer = 'Предметы будут лишены всех модификаций. Их нельзя будет вернуть торговцу или выставить на аукцион.|n|nПродолжить?'
L.CannotPurchaseVault = 'У вас недостаточно золота для открытия доступа к Хранилищу Бездны|n|n|cffff2020Стоимость: %s|r'
L.PurchaseVault = 'Хотите открыть доступ к Хранилищу Бездны?|n|n|cffffd200Стоимость:|r %s'
