local L = LibStub("AceLocale-3.0"):NewLocale("HandyNotes_TravelGuide (Classic)", "ruRU", false)

if not L then return end
--russian translation by Кеаллах RU-Змейталак https://www.curseforge.com/members/arrogant_dreamer
if L then
--config.options
L["HandyNotes: TravelGuide (Classic)"] = true
L["Icon settings"] = "Настройки значка"
L["These settings control the look and feel of the icon."] = "Эти настройки управляют внешним видом значка"
L["Icon Scale"] = "Размер значка"
L["The scale of the icons"] = "Масштаб значков"
L["Icon Alpha"] = "Прозрачность значка"
L["The alpha transparency of the icons"] = "Прозрачность значков"
L["What to display?"] = "Что отображать?"
L["These settings control what type of icons to be displayed."] = "Эти настройки определяют тип отображаемых значков."
L["Boat"] = "Корабль"
L["Show the boat locations."] = "Показать места швартовки кораблей"
L["Alliance Boat"] = "Корабли Альянса"
L["Show the Alliance boat locations."] = "Показать места швартовки кораблей Альянса"
L["Zeppelin"] = "Дирижабль"
L["Show the Zeppelin locations."] = "Показать воздушные гавани дирижаблей"
L["Horde Zeppelin"] = "Дирижабли Орды"
L["Show the Horde Zeppelin locations."] = "Показать воздушные гавани дирижаблей Орды"
L["Note"] = "Запись"
L["Show the node's additional notes when it's available."] = "Показать дополнительные примечания узла, когда он доступен."
L["Deeprun Tram"] = "Подземный поезд"
L["Show the Deeprun Tram locations in Stormwind and Ironforge."] = "Показать Подземный поезд из Штормград в Стальгорн"

--Plugin_config
L["AddOn Settings"] = "Addon Настройкм"
-- L["Query from server"] = "Запрос с сервера"
-- L["Send query request to server to lookup localized name. May be a little bit slower for the first time lookup but would be very fast once the name is found and cached."] = "Отправьте запрос на сервер для поиска локализованного имени. Может быть немного медленнее при первом поиске, но будет очень быстрым, когда имя найдено и кэшировано."
L["Reset hidden nodes"] = "Cбросить скрытые узлы"
L["Show all nodes that you manually hid by right-clicking on them and choosing \"hide\"."] = "Показать все узлы, которые вы вручную скрыли, щелкнув по ним правой кнопкой мыши и выбрав «скрыть»."

--Handler
L["Shows the boat and zepplin locations on the World Map and the MiniMap."] = "Показывает расположение кораблей и дирижаблей на карте мира и на миникарте."
L["TravelGuide (Classic)"] = true

--DB
L["Eastern Kingdoms"] = "Восточные королевства"
L["Eastern Kingdoms, Wetlands"] = "Восточные королевства, Болотина"
L["Boat to Menethil Harbor"] = "Корабль в Гавань Менетилов"

L["Eastern Kingdoms, Tirisfal Glades"] = "Восточные королевства, Тирисфальские леса"
L["Zeppelin to Undercity"] = "Дирижабль в Подгород"

L["Eastern Kingdoms, Stranglethorn Vale"] = "Восточные королевства, Тернистая долина"
L["Eastern Kingdoms, Grom'gol Base Camp"] = "Восточные королевства, Лагеро Гром'гол"
L["Zeppelin to Stranglethorn Vale"] = "Дирижабль в Тернистую долину"
L["Boat to Booty Bay"] = "Корабль в Пиратскую бухту"

L["Eastern Kingdoms, Elwynn Forest"] = "Восточные королевства, Элвиннский лес"
L["Deeprun Tram to Stormwind"] = "Подземный поезд в Штормград"

L["Eastern Kingdoms, Dun Morogh"] = "Восточные королевства, Дун Морог"
L["Deeprun Tram to Ironforge"] = "Подземный поезд в Стальгорн"

L["Kalimdor"] = "Калимдор"
L["Kalimdor, Durotar"] = "Калимдор, Дуротар"
L["Zeppelin to Orgrimmar"] = "Дирижабль в Оргриммар"

L["Kalimdor, Teldrassil"] = "Калимдор, Тельдрассил"
L["Boat to Darnassus"] = "Корабль в Дарнас"

L["Kalimdor, The Barrens"] = "Калимдор, Степи"
L["Boat to Ratchet"] = "Корабль в Кабестан"

L["Kalimdor, Dustwallow Marsh"] = "Калимдор, Пылевые топи"
L["Boat to Theramore"] = "Корабль на остров Терамор"

L["Kalimdor, Darkshore"] = "Калимдор, Темный берега" 
L["Boat to Auberdine"] = "Корабль в Аубердин"

end