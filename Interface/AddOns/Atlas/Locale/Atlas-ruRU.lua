-- $Id: Atlas-ruRU.lua 374 2022-01-26 14:33:01Z arithmandar $
--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 ~ 2010 - Dan Gilbert <dan.b.gilbert at gmail dot com>
	Copyright 2010 - Lothaer <lothayer at gmail dot com>, Atlas Team
	Copyright 2011 ~ 2022 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("Atlas", "ruRU", false);

-- Atlas Russian Localization
-- Compiled by Eugene Filatov, bigoblin, StingerSoft
-- Last Update: 23.01.2011
-- $Date: 2022-01-26 14:33:01 +0000 (Wed, 26 Jan 2022) $
-- $Revision: 374 $

if ( GetLocale() == "ruRU" ) then
-- Define the leading strings to be ignored while sorting
-- Ex: The Stockade
AtlasSortIgnore = {"(.+)"};

-- Syntax: ["real_zone_name"] = "localized map zone name"
AtlasZoneSubstitutions = {
	["Ahn'Qiraj"] = "Ан'Кираж";
	["The Temple of Atal'Hakkar"] = "Храм Атал'Хаккара";
--	["Throne of Tides"] = "Бездонная пучина: Трон Приливов";
};
end


if L then
L[" 1/2"] = "1/2"
L[" 2/2"] = "2/2"
L["%s Dungeons"] = "%s подземелья"
L["%s Instances"] = "%s подземелья"
L["%s Raids"] = "%s рейды"
L["Adult"] = "Взрослый"
L["AKA"] = "ИК"
L["Alexston Chrome <Tavern of Time>"] = "Алекстон Хром <Таверна Времени>"
L["Alurmi <Keepers of Time Quartermaster>"] = "Алурми <Начальник снабжения Хранителей Времени>"
L["Anachronos <Keepers of Time>"] = "Анахронос <Хранители Времени>"
L["Andormu <Keepers of Time>"] = "Андорму <Хранители Времени>"
L["Arazmodu <The Scale of Sands>"] = "Аразмоду <Песчаная Чешуя>"
L["Arcane Container"] = "Волшебный контейнер"
L["Arms Warrior"] = "Воин-Оружия"
L["ATLAS_BUTTON_CLOSE"] = "Закрыть"
L["ATLAS_CLICK_TO_OPEN"] = "[ЛКМ] - открывает карту Atlas."
L["ATLAS_CLOSE_ATLASLOOT_WINDOW"] = "Щелкните правой кнопкой мыши, чтобы закрыть окно AtlasLoot."
L["ATLAS_COLLAPSE_BUTTON"] = "Кликните, чтобы закрыть окно подсказок"
L["ATLAS_DDL_CONTINENT"] = "Континенту"
L["ATLAS_DDL_CONTINENT_BROKENISLES"] = "Подземелья Расколотых островов"
L["ATLAS_DDL_CONTINENT_BROKENISLES1"] = "Подземелья Расколотых островов"
L["ATLAS_DDL_CONTINENT_BROKENISLES2"] = "Рейды Расколотых островов"
L["ATLAS_DDL_CONTINENT_DEEPHOLM"] = "Подземелья Подземья"
L["ATLAS_DDL_CONTINENT_DRAENOR"] = "Подземелья Дренора"
L["ATLAS_DDL_CONTINENT_EASTERN"] = "Подземелья Восточных королевств"
L["ATLAS_DDL_CONTINENT_KALIMDOR"] = "Подземелья Калимдора"
L["ATLAS_DDL_CONTINENT_KULTIRAS"] = "Кул-Тирас подземелья"
L["ATLAS_DDL_CONTINENT_NAZJATAR"] = "Назжатар подземелья"
L["ATLAS_DDL_CONTINENT_NORTHREND"] = "Подземелья Нордскола"
L["ATLAS_DDL_CONTINENT_OUTLAND"] = "Подземелья Запределья"
L["ATLAS_DDL_CONTINENT_PANDARIA"] = "Подземелья Пандарии"
L["ATLAS_DDL_CONTINENT_ZANDALAR"] = "Зандалар подземелья"
L["ATLAS_DDL_EXPANSION"] = "Дополнению"
L["ATLAS_DDL_EXPANSION_BC"] = "Подземелья Burning Crusade"
L["ATLAS_DDL_EXPANSION_BFA"] = "Битва за Азерот подземелья"
L["ATLAS_DDL_EXPANSION_CATA"] = "Подземелья Cataclysm"
L["ATLAS_DDL_EXPANSION_LEGION"] = "Подземелья Legion"
L["ATLAS_DDL_EXPANSION_LEGION1"] = "Подземелья Легиона"
L["ATLAS_DDL_EXPANSION_LEGION2"] = "Рейды Легиона"
L["ATLAS_DDL_EXPANSION_MOP"] = "Подземелья Mists of Pandaria"
L["ATLAS_DDL_EXPANSION_OLD"] = "Подземелья Старого Мира"
L["ATLAS_DDL_EXPANSION_SHADOWLANDS"] = "Подземелья и рейды Shadowlands"
L["ATLAS_DDL_EXPANSION_WOD"] = "Подземелья Warlords of Draenor"
L["ATLAS_DDL_EXPANSION_WOTLK"] = "Подземелья Wrath of the Lich King"
L["ATLAS_DDL_LEVEL"] = "Уровню"
L["ATLAS_DDL_LEVEL_100PLUS"] = "Подземелья уровня 100+"
L["ATLAS_DDL_LEVEL_100TO110"] = "Подземелья уровня 100-110"
L["ATLAS_DDL_LEVEL_10TO20"] = "Подземелья и рейды 10-20 уровня"
L["ATLAS_DDL_LEVEL_10TO30"] = "Подземелья и рейды 10-30 уровня"
L["ATLAS_DDL_LEVEL_110PLUS"] = "Подземелья уровня 110+"
L["ATLAS_DDL_LEVEL_110TO120"] = "Уровень подземелья 110-120"
L["ATLAS_DDL_LEVEL_120PLUS"] = "Уровень подземелья 120+"
L["ATLAS_DDL_LEVEL_120TO130"] = "Уровень подземелья 120-130"
L["ATLAS_DDL_LEVEL_130PLUS"] = "Уровень подземелья 130+"
L["ATLAS_DDL_LEVEL_20TO40"] = "Подземелья и рейды 20-40 уровня"
L["ATLAS_DDL_LEVEL_30TO35"] = "Подземелья и рейды 30-35 уровня"
L["ATLAS_DDL_LEVEL_35TO40"] = "Подземелья и рейды 35-40 уровня"
L["ATLAS_DDL_LEVEL_40TO45"] = "Подземелья и рейды 40-45 уровня"
L["ATLAS_DDL_LEVEL_40TO60"] = "Подземелья и рейды 40-60 уровня"
L["ATLAS_DDL_LEVEL_45TO50"] = "Подземелья и рейды 45-50 уровня"
L["ATLAS_DDL_LEVEL_45TO60"] = "Подземелья уровня 45-60"
L["ATLAS_DDL_LEVEL_50TO60"] = "Подземелья и рейды 50-60 уровня"
L["ATLAS_DDL_LEVEL_60PLUS"] = "Подземелья и рейды уровня 60+"
L["ATLAS_DDL_LEVEL_60TO70"] = "Подземелья уровня 60-70"
L["ATLAS_DDL_LEVEL_70TO80"] = "Подземелья уровня 70-80"
L["ATLAS_DDL_LEVEL_80TO85"] = "Подземелья уровня 80-85"
L["ATLAS_DDL_LEVEL_85TO90"] = "Подземелья уровня 85-90"
L["ATLAS_DDL_LEVEL_90TO100"] = "Подземелья уровня 90-100"
L["ATLAS_DDL_LEVEL_UNDER30"] = "Подземелья и рейды ниже 30 уровня"
L["ATLAS_DDL_LEVEL_UNDER45"] = "Подземелья уровня ниже 45"
L["ATLAS_DDL_PARTYSIZE"] = "Размер группы"
L["ATLAS_DDL_PARTYSIZE_10"] = "Подземелья на 10 игроков"
L["ATLAS_DDL_PARTYSIZE_20TO40"] = "Подземелья на 20-40 игроков"
L["ATLAS_DDL_PARTYSIZE_5"] = "Подземелья на 5 игроков"
L["ATLAS_DDL_TYPE"] = "Типу"
L["ATLAS_DDL_TYPE_ENTRANCE"] = "Входы"
L["ATLAS_DDL_TYPE_INSTANCE"] = "Подземелья"
L["ATLAS_DEP_MSG1"] = "Atlas обнаружил устаревшие плагин(ы)/модуль(и)/аддон(ы)."
L["ATLAS_DEP_MSG2"] = "Оно / они были отключены для этого персонажа."
L["ATLAS_DEP_MSG3"] = [=[Удалите это из вашей папки AddOns и установите последнюю версию.

Список устаревших плагин(ов)/модуль(ей)/аддон(ов):]=]
L["ATLAS_DEP_MSG4"] = [=[Если у вас есть последние из установленных,
не забудьте включить их из списка списка аддонов.]=]
L["ATLAS_DEP_OK"] = "ОК"
L["ATLAS_ENTRANCE_BUTTON"] = "Вход"
L["ATLAS_EXPAND_BUTTON"] = "Кликните, чтобы открыть окно подсказок"
L["ATLAS_INFO"] = "Информация об Atlas"
L["ATLAS_INFO_12200"] = [=[Важное уведомление:

Из-за увеличения размеров файлов модификации, мы разделили
 модификацию на отдельные модули подземелий.

Пользователи, которые загружают нашу модификацию с известных веб-сайтов,
 получают только основное ядро, которое включает в себя все
 функции ядра Atlas и карты подземелий Cataclysm.

Пользователи, которые хотят загрузить все старые карты подземелий и все
 модули Atlas, сделанные нами, могут их загрузить по отдельности.

Для получения дополнительной информации прочтите следующий топик:
|cff6666ffhttp://www.atlasmod.com/phpBB3/viewtopic.php?t=1522|cffffffff

Или посетите наш сайт, чтобы узнать где загрузить:
|cff6666ffhttp://www.atlasmod.com/|cffffffff]=]
L["ATLAS_INFO_12201"] = [=[Обратите внимание, что мы создали новый плагин - |cff6666ffAtlas Сценарии|cffffffff, который 
обеспечивает картами сценарии, добавленные в 5.0. 

Для более подробной информации посетите наш веб-сайт, и не забудьте загрузить / 
установить его отдельно.
|cff6666ffhttp://www.atlasmod.com/|cffffffff]=]
L["ATLAS_INSTANCE_BUTTON"] = "Подземелье"
L["ATLAS_LDB_HINT"] = [=[[ЛКМ] - открывает Atlas.
[ПКМ] - открывает настройки Atlas.]=]
L["ATLAS_MINIMAPLDB_HINT"] = [=[[ЛКМ] - открывает Atlas.
[ПКМ] + открывает настройки Atlas.
[ЛКМ] + [перемещение] - изменяет положение кнопки.]=]
L["ATLAS_MISSING_MODULE"] = [=[Atlas обнаружил отсутствующие модули / плагины: 

Возможно, у вас установлены устаревшие модули / плагины, которые Atlas отключил. 
Если вы установили свежие версии, убедитесь, что они включены в списке модификаций. 

Если вы уверены, что не нуждаетесь в этих "отсутствующих" модулях / плагинах, и не хотите больше видеть это сообщение, то отключите уведомление в панели настроек. 

Список отсутствующих модулей / плагинов: ]=]
L["ATLAS_NO_MODULE_OR_PLUGIN"] = [=[|cffff66ffОшибка:|r
Atlas не может обнаружить какой-либо модуль карты
или плагин установлен и включен.
Отметим, что сам Atlas представляет собой браузер карты 
вам придется устанавливать как минимум один 
картографический модуль или плагин, чтобы просматривать карты.]=]
L["ATLAS_OPEN_ACHIEVEMENT"] = "Щелкните, чтобы открыть подробную информацию о достижениях."
L["ATLAS_OPEN_ADDON_LIST"] = "Открыть список аддона"
L["ATLAS_OPEN_ADVENTURE"] = "[ЛКМ] - открывает журнал подземелий."
L["ATLAS_OPEN_ATLASLOOT_WINDOW"] = "Щелкните, чтобы открыть окно AtlasLoot."
L["ATLAS_OPEN_WOWMAP_WINDOW"] = "[ЛКМ] - открывает карту из журнала подземелий."
L["ATLAS_OPTIONS_ACRONYMS"] = "Сокращать названия"
L["ATLAS_OPTIONS_ACRONYMS_TIP"] = "Показывает сокращённые названия подземелий в сведениях о карте."
L["ATLAS_OPTIONS_AUTOSEL"] = "Автоматически выбирать подземелья"
L["ATLAS_OPTIONS_AUTOSEL_TIP"] = "Atlas определит ваше местоположение, чтобы выбрать подходящую карту подземелья."
L["ATLAS_OPTIONS_BOSS_DESC"] = "Показать описание босса (если доступно)"
L["ATLAS_OPTIONS_BOSS_DESC_SCALE"] = "Размер подсказки описания босса на карте"
L["ATLAS_OPTIONS_BOSS_DESC_TIP"] = "При наведении курсора на номер босса, будет показано описание босса, если эта информация доступна."
L["ATLAS_OPTIONS_BOSS_POTRAIT"] = "Показывать портрет босса, когда возможно"
L["ATLAS_OPTIONS_BUTPOS"] = "Расположение кнопки"
L["ATLAS_OPTIONS_BUTRAD"] = "Радиус расположения кнопки"
L["ATLAS_OPTIONS_BUTTON"] = "Настройки"
L["ATLAS_OPTIONS_CATDD"] = "Сортировать подземелья по:"
L["ATLAS_OPTIONS_CHECKMODULE"] = "Напоминать об отсутствующих модулях / плагинах."
L["ATLAS_OPTIONS_CHECKMODULE_TIP"] = "Выполнение проверки после загрузки WoW, на наличие отсутствующих модулей / плагинов Atlas."
L["ATLAS_OPTIONS_CLAMPED"] = "Не заходить за пределы экрана"
L["ATLAS_OPTIONS_CLAMPED_TIP"] = "Помещает окно Atlas в пределах, отключение позволит перемещать окно за пределы игрового экрана."
L["ATLAS_OPTIONS_COLORINGDROPDOWN"] = "Показать подземелья в выпадающим цветах"
L["ATLAS_OPTIONS_COLORINGDROPDOWN_TIP"] = "Основываясь на подземелий, рекомендуемого минимального уровня, и уровня игрока, чтобы показать подземелье с цветами сложности."
L["ATLAS_OPTIONS_CTRL"] = "Удерживать клавишу Ctrl для подсказок"
L["ATLAS_OPTIONS_CTRL_TIP"] = "Включает/отключает показ подсказки при удерживании клавиши Ctrl и наведении курсора на информационной карте. Полезно, когда текст слишком длинный для показа в окне."
L["ATLAS_OPTIONS_DONTSHOWAGAIN"] = "Не показывать одну и ту же информацию повторно."
L["ATLAS_OPTIONS_HEADER_ADDONCONFIG"] = "Конфигурации аддона"
L["ATLAS_OPTIONS_HEADER_DISPLAY"] = "Параметры отображения"
L["ATLAS_OPTIONS_LOCK"] = "Закрепить окно Atlas"
L["ATLAS_OPTIONS_LOCK_TIP"] = "Закрепляет / освобождает окно Atlas."
L["ATLAS_OPTIONS_MAXMENUITEMS"] = "Максимальное число пунктов меню"
L["ATLAS_OPTIONS_MAXMENUITEMS_TIP"] = "Настройте максимальное количество выпадающих меню, которые будут отображаться перед разбиением на другую категорию меню."
L["ATLAS_OPTIONS_RCLICK"] = "[ПКМ] для показа карты мира"
L["ATLAS_OPTIONS_RCLICK_TIP"] = "Включает показ карты мира при нажатии правой кнопки мыши в окне Atlas."
L["ATLAS_OPTIONS_RESETPOS"] = "Сбросить положение"
L["ATLAS_OPTIONS_SCALE"] = "Размер"
L["ATLAS_OPTIONS_SHOWBUT"] = "Показывать кнопку возле миникарты"
L["ATLAS_OPTIONS_SHOWBUT_TIP"] = "Показывает кнопку Atlas возле миникарты."
L["ATLAS_OPTIONS_SHOWWMBUT"] = "Показать кнопку в окне карты мира."
L["ATLAS_OPTIONS_TRANS"] = "Прозрачность"
L["ATLAS_REOPEN_LOOT_AGAIN"] = "Пожалуйста, откройте заново окно добычи для перезагрузки."
L["ATLAS_ROPEN_ATLASLOOT_WINDOW"] = "Щелкните правой кнопкой мыши, чтобы открыть окно AtlasLoot."
L["ATLAS_SEARCH_UNAVAIL"] = "Поиск недоступен"
L["ATLAS_SLASH"] = "/atlas"
L["ATLAS_SLASH_OPTIONS"] = "options"
L["ATLAS_STRING_CLEAR"] = "Сбросить"
L["ATLAS_STRING_LEVELRANGE"] = "Уровень"
L["ATLAS_STRING_LOCATION"] = "Расположение"
L["ATLAS_STRING_MINGEARLEVEL"] = "Минимальный уровень вещей"
L["ATLAS_STRING_MINLEVEL"] = "Минимальный уровень"
L["ATLAS_STRING_PLAYERLIMIT"] = "Лимит игроков"
L["ATLAS_STRING_RECLEVELRANGE"] = "Реком. уровень"
L["ATLAS_STRING_SEARCH"] = "Поиск"
L["ATLAS_STRING_SELECT_CAT"] = "Выбор категории"
L["ATLAS_STRING_SELECT_MAP"] = "Выбор карты"
L["ATLAS_TITLE"] = "Atlas"
L["ATLAS_TOGGLE_LOOT"] = "Щелкните правой кнопкой мыши для переключения на панель добычи."
L["Attunement Required"] = "Необходима подготовка"
L["Back"] = "Назад"
L["Basement"] = "Подвал"
L["BINDING_HEADER_ATLAS_TITLE"] = "Сопоставления кнопок"
L["BINDING_NAME_ATLAS_AUTOSEL"] = "Авто-выбор подземелья"
L["BINDING_NAME_ATLAS_OPTIONS"] = "Настройки Atlas"
L["BINDING_NAME_ATLAS_TOGGLE"] = "Atlas"
L["Blacksmithing Plans"] = "Чертежи кузнечного дела"
L["Bodley"] = "Бодли"
L["Bortega <Reagents & Poison Supplies>"] = "Бортега <Реагенты и яды>"
L["Brewfest"] = "Праздника пива"
L["Child"] = "Ребенок"
L["Colon"] = ": "
L["Comma"] = ", "
L["Connection"] = "Связан"
L["East"] = "Восток"
L["Elevator"] = "Лифт"
L["End"] = "Конец"
L["Engineer"] = "Инженер"
L["Entrance"] = "Вход"
L["Event"] = "Событие"
L["Exalted"] = "Превознесение"
L["Exit"] = "Выход"
L["Fourth Stop"] = "Четвертая остановка"
L["Front"] = "Передний"
L["Galgrom <Provisioner>"] = "Гальгром <Поставщик>"
L["Ghost"] = "Призрак"
L["Graveyard"] = "Кладбище"
L["Hallow's End"] = "Тыква"
L["Heroic"] = "Героический"
L["Heroic_Symbol"] = "(Героик)"
L["Holy Paladin"] = "Паладин-Света"
L["Holy Priest"] = "Жрец-Света"
L["Hyphen"] = " - "
L["Imp"] = "Бес"
L["Key"] = "Ключ"
L["L-DQuote"] = "\""
L["Lothos Riftwaker"] = "Лотос Хранитель Портала"
L["Love is in the Air"] = "Любовная лихорадка"
L["Lower"] = "Нижний"
L["L-Parenthesis"] = " ("
L["L-SBracket"] = "["
L["Lunar Festival"] = "Лунный фестиваль"
L["MapA"] = " [A]"
L["MapB"] = " [B]"
L["MapC"] = " [C]"
L["MapD"] = " [D]"
L["MapE"] = " [E]"
L["MapF"] = " [F]"
L["MapG"] = " [G]"
L["MapH"] = " [H]"
L["MapI"] = " [I]"
L["MapJ"] = " [J]"
L["MapsNotFound"] = [=[Текущее выбранное подземелье не имеет 
связанные с соответствующее изображения карты. 

Пожалуйста, убедитесь, что у вас установлены
соответствующие модуль(и) карт Atlas.]=]
L["Meeting Stone"] = "Камень встреч"
L["Middle"] = "Центр"
L["Midsummer Festival"] = "Огненный солнцеворот"
L["Moonwell"] = "Лунный колодец"
L["Mythic"] = "Эпохальный"
L["Mythic_Symbol"] = "(Мифик)"
L["North"] = "Север"
L["Nozari <Keepers of Time>"] = "Нозари <Хранители Времени>"
L["Optional"] = "Необяз."
L["Orange"] = "Оранжевый"
L["Orb of Command"] = "Сфера Приказа"
L["Outside"] = "Снаружи"
L["Period"] = ". "
L["Portal"] = "Портал"
L["Portal to %s"] = "Портал на %s"
L["PossibleMissingModule"] = "Вполне вероятно, что эта карта из этого модуля: "
L["Profile Options"] = "Настройки профиля"
L["Protection Warrior"] = "Воин-Защиты"
L["Purple"] = "Пурпурный"
L["Random"] = "Случайный"
L["Rare"] = "Редкий"
L["R-DQuote"] = "\""
L["Repair"] = "Починка"
L["Retribution Paladin"] = "Паладин-Возмездия"
L["Rewards"] = "Награды"
L["R-Parenthesis"] = ") "
L["R-SBracket"] = "]"
L["Scale and Transparency"] = "Масштаб и прозрачность"
L["Scarshield Quartermaster <Scarshield Legion>"] = "Интендант из легиона Изрубленного Щита"
L["Second Stop"] = "Вторая остановка"
L["Semicolon"] = "; "
L["Shadow Priest"] = "Жрец-Темной магии"
L["Slash"] = " / "
L["Soridormi <The Scale of Sands>"] = "Соридорми <Песчаная Чешуя>"
L["South"] = "Юг"
L["Spawn Point"] = "Точка рождения"
L["Stairs"] = "Лестница"
L["Stairs to %s"] = "Лестница на %s"
L["Start"] = "Начало"
L["Steward of Time <Keepers of Time>"] = "Распорядитель времени <Хранители Времени>"
L["Summon"] = "Вызов"
L["Teleporter"] = "Телепорт"
L["Teleporter destination"] = "Назначение телепорта"
L["The Behemoth"] = "Чудище"
L["Third Stop"] = "Третья остановка"
L["Top"] = "Верхний"
L["Transport"] = "Транспорт"
L["Tunnel"] = "Туннель"
L["Underwater"] = "Подводный"
L["Upper"] = "Верхний"
L["Upper floor"] = "Верхний этаж"
L["Varies"] = "Изменяется"
L["Wanders"] = "Странник"
L["Wave 10"] = "10-ая волна"
L["Wave 12"] = "12-ая волна"
L["Wave 18"] = "18-ая волна"
L["Wave 5"] = "5-ая волна"
L["Wave 6"] = "6-ая волна"
L["West"] = "Запад"
L["Yarley <Armorer>"] = "Ярли <Бронник>"
L["Zaladormu"] = "Заладорму"


end
