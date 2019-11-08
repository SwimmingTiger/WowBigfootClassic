local L = LibStub("AceLocale-3.0"):NewLocale(..., "ruRU")
if not L then return end

-------------------------------------------------------------

L = L or {}
-- MessageClassifier
L["DISABLE_TIPS"] = "Дедупликация сообщений общего чата/мирового чата: отключена"
L["ENABLE_TIPS"] = "Дедупликация сообщений общего чата/мирового чата: включена. Вы можете переключить его с помощью команды /msgdd"
L["ENABLE_TIPS_WITH_BIGFOOT"] = "Дедупликация сообщений общего чата/мирового чата: включена. Вы можете отключить его в пакете кнопок BigFoot на мини-карте."
L["RESET_TIPS"] = "Дедупликация сообщений общего чата/мирового чата: фильтр был сброшен"

-- Options
L["CONFIG_PAGE_TITLE"] = "Дедупликация сообщений"
L["OPTION_ENABLED"] = "Включить фильтр повторяющихся сообщений"
L["OPTION_ENABLED_TOOLTIP"] = "Не отображать повторяющиеся сообщения в общих каналах/мировых каналах"
L["OPTION_MIN_DUP_INTERVAL"] = "Мин. Секунды для появления повторяющихся сообщений, 0 для скрытия"
L["OPTION_RESET"] = "Сбросить фильтр"
L["OPTION_RESET_TOOLTIP"] = "Очистить дубликаты записей сообщений, позволяя повторяющимся сообщениям отображаться снова"

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
