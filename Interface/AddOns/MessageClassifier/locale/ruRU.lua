local L = LibStub("AceLocale-3.0"):NewLocale(..., "ruRU")
if not L then return end

-------------------------------------------------------------

L = L or {}
-- Browser
L["BROWSER_CLASSIFIED_ALL_MESSAGES"] = "Все сообщения"
L["BROWSER_CLASSIFIED_BY_AUTHOR"] = "По автору/%s"
L["BROWSER_CLASSIFIED_BY_CHANNEL"] = "По каналу/%s"
L["BROWSER_SEARCH"] = "Поиск"
L["BROWSER_SETTING"] = "Настройки"
L["BROWSER_STATUS_BAR"] = "Все сообщения %d, уникальные %d, дубликаты %d, коэффициент дублирования %0.2f%%"
L["BROWSER_TITLE"] = "Браузер сообщений"
L["Left-Click"] = "ЛКМ"
L["MOVE_BUTTON"] = "Перемещать кнопку"
L["Shift-Click"] = "Shift-Клик"

-- Channels
--[[Translation missing --]]
L["CHAN_FULLNAME_BATTLEGROUND"] = "CHAN_FULLNAME_BATTLEGROUND"
--[[Translation missing --]]
L["CHAN_FULLNAME_BIGFOOTCHANNEL"] = "CHAN_FULLNAME_BIGFOOTCHANNEL"
--[[Translation missing --]]
L["CHAN_FULLNAME_GENERAL"] = "CHAN_FULLNAME_GENERAL"
--[[Translation missing --]]
L["CHAN_FULLNAME_GUILD"] = "CHAN_FULLNAME_GUILD"
--[[Translation missing --]]
L["CHAN_FULLNAME_LFGCHANNEL"] = "CHAN_FULLNAME_LFGCHANNEL"
--[[Translation missing --]]
L["CHAN_FULLNAME_LOCALDEFENSE"] = "CHAN_FULLNAME_LOCALDEFENSE"
--[[Translation missing --]]
L["CHAN_FULLNAME_PARTY"] = "CHAN_FULLNAME_PARTY"
--[[Translation missing --]]
L["CHAN_FULLNAME_RAID"] = "CHAN_FULLNAME_RAID"
--[[Translation missing --]]
L["CHAN_FULLNAME_SAY"] = "CHAN_FULLNAME_SAY"
--[[Translation missing --]]
L["CHAN_FULLNAME_TRADE"] = "CHAN_FULLNAME_TRADE"
--[[Translation missing --]]
L["CHAN_FULLNAME_WHISPERFROM"] = "CHAN_FULLNAME_WHISPERFROM"
--[[Translation missing --]]
L["CHAN_FULLNAME_WHISPERTO"] = "CHAN_FULLNAME_WHISPERTO"
--[[Translation missing --]]
L["CHAN_FULLNAME_WORLDDEFENSE"] = "CHAN_FULLNAME_WORLDDEFENSE"
--[[Translation missing --]]
L["CHAN_FULLNAME_YELL"] = "CHAN_FULLNAME_YELL"
--[[Translation missing --]]
L["CHAN_SHORTNAME_BATTLEGROUND"] = "CHAN_SHORTNAME_BATTLEGROUND"
--[[Translation missing --]]
L["CHAN_SHORTNAME_BIGFOOT"] = "CHAN_SHORTNAME_BIGFOOT"
--[[Translation missing --]]
L["CHAN_SHORTNAME_GENERAL"] = "CHAN_SHORTNAME_GENERAL"
--[[Translation missing --]]
L["CHAN_SHORTNAME_GUILD"] = "CHAN_SHORTNAME_GUILD"
--[[Translation missing --]]
L["CHAN_SHORTNAME_LFGCHANNEL"] = "CHAN_SHORTNAME_LFGCHANNEL"
--[[Translation missing --]]
L["CHAN_SHORTNAME_LOCALDEFENSE"] = "CHAN_SHORTNAME_LOCALDEFENSE"
--[[Translation missing --]]
L["CHAN_SHORTNAME_OFFICER"] = "CHAN_SHORTNAME_OFFICER"
--[[Translation missing --]]
L["CHAN_SHORTNAME_PARTY"] = "CHAN_SHORTNAME_PARTY"
--[[Translation missing --]]
L["CHAN_SHORTNAME_RAID"] = "CHAN_SHORTNAME_RAID"
--[[Translation missing --]]
L["CHAN_SHORTNAME_TRADE"] = "CHAN_SHORTNAME_TRADE"
--[[Translation missing --]]
L["CHAN_SHORTNAME_WHISPERFROM"] = "CHAN_SHORTNAME_WHISPERFROM"
--[[Translation missing --]]
L["CHAN_SHORTNAME_WHISPERTO"] = "CHAN_SHORTNAME_WHISPERTO"
--[[Translation missing --]]
L["CHAN_SHORTNAME_WORLDDEFENSE"] = "CHAN_SHORTNAME_WORLDDEFENSE"
--[[Translation missing --]]
L["CHAN_SHORTNAME_YELL"] = "CHAN_SHORTNAME_YELL"
--[[Translation missing --]]
L["CHAT_MSG_YELL"] = "Yell"

-- MessageClassifier
L["DISABLE_TIPS"] = "Дедупликация сообщений общего чата/мирового чата: отключена"
L["ENABLE_TIPS"] = "Дедупликация сообщений общего чата/мирового чата: включена. Вы можете переключить его с помощью команды /msgdd"
L["ENABLE_TIPS_WITH_BIGFOOT"] = "Дедупликация сообщений общего чата/мирового чата: включена. Вы можете отключить его в пакете кнопок BigFoot на мини-карте."
L["RESET_TIPS"] = "Дедупликация сообщений общего чата/мирового чата: фильтр был сброшен"

-- Options
L["CONFIG_PAGE_TITLE"] = "Дедупликация сообщений"
L["OPTION_ADD"] = "Добавить"
L["OPTION_CANCEL"] = "Канал"
L["OPTION_CLASS"] = "Затем добавьте к этому классу"
L["OPTION_CLASS_EDIT_TITLE"] = "Затем добавьте к этому классу (доступные переменные: |cffc586c0{автор}|r и |cffc586c0{канал}|r)"
L["OPTION_CLASS_NO_CONDITIONS"] = "Всегда добавляйте к этому классу"
L["OPTION_COND_CASESENSITIVE"] = "Чувствительный к регистру"
L["OPTION_CONDITION_FIELD"] = "Поле"
L["OPTION_CONDITION_LOGIC"] = "Логика"
L["OPTION_CONDITION_OPERATOR"] = "Оператор"
L["OPTION_CONDITION_VALUE"] = "Значение"
L["OPTION_CONDITIONS"] = "Если"
L["OPTION_DEFAULT_RULE_SETS"] = "Правила по умолчанию"
L["OPTION_EDIT"] = "Редактировать"
L["OPTION_ENABLE"] = "Включить"
L["OPTION_ENABLED"] = "Включить фильтр повторяющихся сообщений"
L["OPTION_ENABLED_TOOLTIP"] = "Не отображать повторяющиеся сообщения в общих каналах/мировых каналах"
L["OPTION_HIDE_FROM_CHAT_WINDOW"] = "Скрыть из окна чата"
L["OPTION_MIN_DUP_INTERVAL"] = "Мин. Секунды для появления повторяющихся сообщений, 0 для скрытия"
L["OPTION_OPEN_MESSAGE_BROWSER"] = "Браузер Сообщений"
L["OPTION_REMOVE"] = "Удалить"
L["OPTION_RESET"] = "Сбросить фильтр"
L["OPTION_RESET_TOOLTIP"] = "Очистить дубликаты записей сообщений, позволяя повторяющимся сообщениям отображаться снова"
L["OPTION_RULE_LOGIC_AND"] = "все условия верны одновременно"
L["OPTION_RULE_LOGIC_OR"] = "одно из условий верно"
L["OPTION_RULE_SETS"] = "Пользовательские правила"
L["OPTION_RULE_SETS_TITLE"] = "Правило классификации"
L["OPTION_SAVE"] = "Сохранить"
L["OPTION_SELECT_ALL"] = "Выбрать Все"

-- Rule Fields
L["author"] = "автор"
L["channel"] = "канал"
L["content"] = "содержание"

-- Rule Operators
L["contain"] = "содержать"
L["equal"] = "равный"
L["match"] = "соответствует"
L["not contain"] = "не содержат"
L["not equal"] = "не равный"
L["not match"] = "не соответствует"

-------------------------------------------------------------

local L = LibStub("AceLocale-3.0"):GetLocale(...)

MessageClassifierDefaultRules = {
    {
        id = 1,
        conditions = {},
        class = L["BROWSER_CLASSIFIED_BY_AUTHOR"]:format("{author}")
    },
    {
        id = 2,
        conditions = {},
        class = L["BROWSER_CLASSIFIED_BY_CHANNEL"]:format("{channel}")
    },
    {
        id = 3,
        conditions = {},
        class = L["BROWSER_CLASSIFIED_ALL_MESSAGES"]
    }
}
