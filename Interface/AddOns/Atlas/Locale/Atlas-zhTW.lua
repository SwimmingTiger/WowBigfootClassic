-- $Id: Atlas-zhTW.lua 374 2022-01-26 14:33:01Z arithmandar $
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
local L = AceLocale:NewLocale("Atlas", "zhTW", false);

if ( GetLocale() == "zhTW" ) then
	-- Define the leading strings to be ignored while sorting
	-- Ex: The Stockade
	AtlasSortIgnore = {};

	-- Syntax: ["real_zone_name"] = "localized map zone name"
	AtlasZoneSubstitutions = {
		["安其拉"] = "安其拉：安其拉神廟";
		["卡拉贊"] = "卡拉贊 - 1.開始";
		["悲傷沼澤"] = "沉沒的神廟";
	};
end


if L then
L[" 1/2"] = " 1/2"
L[" 2/2"] = " 2/2"
L["%s Dungeons"] = "%s地城"
L["%s Instances"] = "%s副本"
L["%s Raids"] = "%s團隊副本"
L["Adult"] = "成年"
L["AKA"] = "又稱"
L["Alexston Chrome <Tavern of Time>"] = "艾力克斯頓·科洛米 <時間酒館>"
L["Alurmi <Keepers of Time Quartermaster>"] = "阿勒米 <時光守望者軍需官>"
L["Anachronos <Keepers of Time>"] = "安納克羅斯 <時光守望者>"
L["Andormu <Keepers of Time>"] = "安杜姆 <時光守望者>"
L["Arazmodu <The Scale of Sands>"] = "阿拉斯莫杜 <流沙之鱗>"
L["Arcane Container"] = "秘法容器"
L["Arms Warrior"] = "武戰"
L["ATLAS_BUTTON_CLOSE"] = "關閉"
L["ATLAS_CLICK_TO_OPEN"] = "按下以開啟 Atlas 地圖視窗。"
L["ATLAS_CLOSE_ATLASLOOT_WINDOW"] = "右鍵點擊以關閉 AtlasLoot 視窗。"
L["ATLAS_COLLAPSE_BUTTON"] = "按下以收起 Atlas 的地圖說明窗格。"
L["ATLAS_DDL_CONTINENT"] = "依不同大陸分類"
L["ATLAS_DDL_CONTINENT_BROKENISLES"] = "破碎群島副本"
L["ATLAS_DDL_CONTINENT_BROKENISLES1"] = "破碎群島地城"
L["ATLAS_DDL_CONTINENT_BROKENISLES2"] = "破碎群島團隊副本"
L["ATLAS_DDL_CONTINENT_DEEPHOLM"] = "地深之源副本"
L["ATLAS_DDL_CONTINENT_DRAENOR"] = "德拉諾副本"
L["ATLAS_DDL_CONTINENT_EASTERN"] = "東部王國副本"
L["ATLAS_DDL_CONTINENT_KALIMDOR"] = "卡林多副本"
L["ATLAS_DDL_CONTINENT_KULTIRAS"] = "庫爾提拉斯副本"
L["ATLAS_DDL_CONTINENT_NAZJATAR"] = "納沙塔爾副本"
L["ATLAS_DDL_CONTINENT_NORTHREND"] = "北裂境副本"
L["ATLAS_DDL_CONTINENT_OUTLAND"] = "外域副本"
L["ATLAS_DDL_CONTINENT_PANDARIA"] = "潘達利亞副本"
L["ATLAS_DDL_CONTINENT_ZANDALAR"] = "贊達拉副本"
L["ATLAS_DDL_EXPANSION"] = "依資料片分類"
L["ATLAS_DDL_EXPANSION_BC"] = "燃燒的遠征副本"
L["ATLAS_DDL_EXPANSION_BFA"] = "決戰艾澤拉斯副本"
L["ATLAS_DDL_EXPANSION_CATA"] = "浩劫與重生副本"
L["ATLAS_DDL_EXPANSION_LEGION"] = "軍臨天下副本"
L["ATLAS_DDL_EXPANSION_LEGION1"] = "軍臨天下地城"
L["ATLAS_DDL_EXPANSION_LEGION2"] = "軍臨天下團隊副本"
L["ATLAS_DDL_EXPANSION_MOP"] = "潘達利亞之謎副本"
L["ATLAS_DDL_EXPANSION_OLD"] = "舊世界副本"
L["ATLAS_DDL_EXPANSION_SHADOWLANDS"] = "暗影之境副本"
L["ATLAS_DDL_EXPANSION_WOD"] = "德拉諾之霸副本"
L["ATLAS_DDL_EXPANSION_WOTLK"] = "巫妖王之怒副本"
L["ATLAS_DDL_LEVEL"] = "依等級分類"
L["ATLAS_DDL_LEVEL_100PLUS"] = "副本等級大於 100"
L["ATLAS_DDL_LEVEL_100TO110"] = "副本等級介於 100-110"
L["ATLAS_DDL_LEVEL_10TO30"] = "副本等級介於 10-30"
L["ATLAS_DDL_LEVEL_110PLUS"] = "副本等級大於 110"
L["ATLAS_DDL_LEVEL_110TO120"] = "副本等級介於 110-120"
L["ATLAS_DDL_LEVEL_120PLUS"] = "副本等級大於 120"
L["ATLAS_DDL_LEVEL_120TO130"] = "副本等級介於 120-130"
L["ATLAS_DDL_LEVEL_130PLUS"] = "副本等級大於 130"
L["ATLAS_DDL_LEVEL_30TO35"] = "副本等級介於 30-35"
L["ATLAS_DDL_LEVEL_35TO40"] = "副本等級介於 35-40"
L["ATLAS_DDL_LEVEL_40TO45"] = "副本等級介於 40-45"
L["ATLAS_DDL_LEVEL_45TO50"] = "副本等級介於 45-50"
L["ATLAS_DDL_LEVEL_45TO60"] = "副本等級介於 45-60"
L["ATLAS_DDL_LEVEL_50TO60"] = "副本等級介於 50-60"
L["ATLAS_DDL_LEVEL_60PLUS"] = "副本等級大於 60"
L["ATLAS_DDL_LEVEL_60TO70"] = "副本等級介於 60-70"
L["ATLAS_DDL_LEVEL_70TO80"] = "副本等級介於 70-80"
L["ATLAS_DDL_LEVEL_80TO85"] = "副本等級介於 80-85"
L["ATLAS_DDL_LEVEL_85TO90"] = "副本等級介於 85-90"
L["ATLAS_DDL_LEVEL_90TO100"] = "副本等級介於 90-100"
L["ATLAS_DDL_LEVEL_UNDER30"] = "副本等級低於 30"
L["ATLAS_DDL_LEVEL_UNDER45"] = "副本等級低於 45"
L["ATLAS_DDL_PARTYSIZE"] = "依隊伍人數分類"
L["ATLAS_DDL_PARTYSIZE_10"] = "10 人團隊副本"
L["ATLAS_DDL_PARTYSIZE_20TO40"] = "20-40 人團隊副本"
L["ATLAS_DDL_PARTYSIZE_5"] = "5 人地城"
L["ATLAS_DDL_TYPE"] = "依地圖類型分類"
L["ATLAS_DDL_TYPE_ENTRANCE"] = "副本入口"
L["ATLAS_DDL_TYPE_INSTANCE"] = "副本"
L["ATLAS_DEP_MSG1"] = "Atlas 偵測到過期的模組/相依插件。"
L["ATLAS_DEP_MSG2"] = "這個/這些模組已從這個角色被停用。"
L["ATLAS_DEP_MSG3"] = [=[請將這個/這些模組從 AddOns 目錄移除，
然後再去取得最新的版本並加以安裝。

以下是過期的模組/相依插件列表：]=]
L["ATLAS_DEP_MSG4"] = [=[當您將過期的模組/相依插件替換並安裝成新版之後，
請別忘記在插件列表裡啟用它(們)。]=]
L["ATLAS_DEP_OK"] = "OK"
L["ATLAS_ENTRANCE_BUTTON"] = "入口"
L["ATLAS_EXPAND_BUTTON"] = "按下以展開 Atlas 的地圖說明窗格。"
L["ATLAS_INFO"] = "Atlas 訊息"
L["ATLAS_INFO_12200"] = [=[重要提示：

由於副本插件檔案大小日益增加，我們已獨立出部分副本地圖和內建插件
到單獨的模組。

您從各大遊戲插件網站所下載的 Atlas 插件，可能只包含了主要的核心功能
與最新資料片裡的副本地圖。

若您想要取得包含舊的資料片的所有地圖，以及 Atlas 團隊所開發的其他
模組，您必須分別下載這些獨立模組的壓縮檔並分別進行安裝。

請詳讀我們論壇的這個討論串以了解更多詳情：
|cff6666ffhttp://www.atlasmod.com/phpBB3/viewtopic.php?t=1522|cffffffff
或造訪我們的首頁：
|cff6666ffhttp://www.atlasmod.com/|cffffffff]=]
L["ATLAS_INFO_12201"] = [=[我們最近新增了一個新的 Atlas 插件 - |cff6666ffAtlas 情境地圖|cffffffff，用以提供 WoW 5.0 
起新增的情境事件的地圖。

請參見我們的網站以取得更詳細的資訊，並請記得分別下載並安裝此插件。
|cff6666ffhttp://www.atlasmod.com/|cffffffff]=]
L["ATLAS_INSTANCE_BUTTON"] = "副本"
L["ATLAS_LDB_HINT"] = [=[左鍵開啟 Atlas。
中鍵開啟 Atlas 選項。
右鍵打開顯示選單。"]=]
L["ATLAS_MINIMAPLDB_HINT"] = [=[左鍵開啟 Atlas。
右鍵開啟 Atlas 選項。
左鍵並拖曳以移動圖示按鈕位置。]=]
L["ATLAS_MISSING_MODULE"] = [=[Atlas 已偵測到遺失的模組／插件。

這有可能是因為先前您有過期的模組／插件而被 Atlas 停用。
如果您現在已經將所有的模組／插件安裝到最新版，請到插件列表裡確認是否所有的項目都已被啟用。

如果您確認您不需要這些「遺失」的插件並且不想繼續看到這樣的通知，您可以到選項視窗去關閉通知。

以下是遺失的模組／插件列表：
]=]
L["ATLAS_NO_MODULE_OR_PLUGIN"] = [=[|cffff66ff錯誤：|r
Atlas 無法偵測到任何的地圖
模組或插件被安裝且啟用。
提醒您，Atlas 本身只是個地圖
瀏覽器，您將必須至少安裝一個
地圖模組或插件以瀏覽地圖。]=]
L["ATLAS_OPEN_ACHIEVEMENT"] = "按下以開啟成就細節。"
L["ATLAS_OPEN_ADDON_LIST"] = "開啟插件列表"
L["ATLAS_OPEN_ADVENTURE"] = "按下以開啟冒險指南視窗。"
L["ATLAS_OPEN_ATLASLOOT_WINDOW"] = "按下以開啟 AtlasLoot 視窗。"
L["ATLAS_OPEN_WOWMAP_WINDOW"] = "按下以開啟冒險指南地圖視窗。"
L["ATLAS_OPTIONS_ACRONYMS"] = "顯示副本縮寫"
L["ATLAS_OPTIONS_ACRONYMS_TIP"] = "在地圖的詳盡敘述中顯示副本的縮寫"
L["ATLAS_OPTIONS_AUTOSEL"] = "自動選擇副本地圖"
L["ATLAS_OPTIONS_AUTOSEL_TIP"] = "Atlas 可偵測您目前所在的副區域以顯示一個最佳的副本地圖"
L["ATLAS_OPTIONS_BOSS_DESC"] = "當首領資訊可獲取時，顯示該資訊"
L["ATLAS_OPTIONS_BOSS_DESC_SCALE"] = "首領資訊提示視窗大小比率"
L["ATLAS_OPTIONS_BOSS_DESC_TIP"] = "當滑鼠游標移動到地圖上首領的標號時，並且首領資訊可獲取時，顯示該首領的相關資訊。"
L["ATLAS_OPTIONS_BOSS_POTRAIT"] = "當首領頭像可獲取時，顯示首領頭像"
L["ATLAS_OPTIONS_BUTPOS"] = "按鈕位置"
L["ATLAS_OPTIONS_BUTRAD"] = "按鈕半徑範圍"
L["ATLAS_OPTIONS_BUTTON"] = "選項"
L["ATLAS_OPTIONS_CATDD"] = "副本地圖分類方式:"
L["ATLAS_OPTIONS_CHECKMODULE"] = "提醒我是否有遺失的模組或插件"
L["ATLAS_OPTIONS_CHECKMODULE_TIP"] = "勾選以在每次登入 WoW 時檢查是否有遺失的 Atlas 模組或插件。"
L["ATLAS_OPTIONS_CLAMPED"] = "使 Atlas 視窗不超出遊戲畫面"
L["ATLAS_OPTIONS_CLAMPED_TIP"] = "使 Atlas 視窗被拖曳時不會超出遊戲主畫面的邊界，關閉此選項則可將 Atlas 視窗拖曳並超出遊戲畫面邊界"
L["ATLAS_OPTIONS_COLORINGDROPDOWN"] = "副本清單以難易度色彩顯示"
L["ATLAS_OPTIONS_COLORINGDROPDOWN_TIP"] = "依據副本建議的最低進入等級、以及玩家現今等級的差異，將副本清單以難易度色彩顯示。"
L["ATLAS_OPTIONS_CTRL"] = "按住 Ctrl 鍵以顯示工具提示"
L["ATLAS_OPTIONS_CTRL_TIP"] = "勾選後，當滑鼠移到地圖資訊欄位時，按下 Ctrl 控制鍵，則會將資訊的完整資訊以提示型態顯示。當資訊過長而被截斷時很有用。"
L["ATLAS_OPTIONS_DONTSHOWAGAIN"] = "不再顯示相同訊息。"
L["ATLAS_OPTIONS_HEADER_ADDONCONFIG"] = "插件設定"
L["ATLAS_OPTIONS_HEADER_DISPLAY"] = "顯示選項"
L["ATLAS_OPTIONS_LOCK"] = "鎖定 Atlas 視窗位置"
L["ATLAS_OPTIONS_LOCK_TIP"] = "設定將 Atlas 視窗位置鎖定或不鎖定"
L["ATLAS_OPTIONS_MAXMENUITEMS"] = "選單最大值"
L["ATLAS_OPTIONS_MAXMENUITEMS_TIP"] = "設定下拉選單最大可顯示的地圖數量，超過後才分割至下一個地圖類別。"
L["ATLAS_OPTIONS_RCLICK"] = "滑鼠右鍵開啟世界地圖"
L["ATLAS_OPTIONS_RCLICK_TIP"] = "啟用在 Atlas 視窗中按下滑鼠右鍵自動切換到魔獸的世界地圖"
L["ATLAS_OPTIONS_RESETPOS"] = "重設位置"
L["ATLAS_OPTIONS_SCALE"] = "Atlas 視窗大小比率"
L["ATLAS_OPTIONS_SHOWBUT"] = "在小地圖旁顯示 Atlas 按鈕"
L["ATLAS_OPTIONS_SHOWBUT_TIP"] = "在小地圖旁顯示 Atlas 按鈕"
L["ATLAS_OPTIONS_SHOWWMBUT"] = "在世界地圖上顯示 Atlas 按鈕"
L["ATLAS_OPTIONS_TRANS"] = "透明度"
L["ATLAS_REOPEN_LOOT_AGAIN"] = "請重新開啟首領戰利品視窗以重新載入物品資訊。"
L["ATLAS_ROPEN_ATLASLOOT_WINDOW"] = "右鍵點擊以開啟 AtlasLoot 視窗。"
L["ATLAS_SEARCH_UNAVAIL"] = "搜尋功能停用"
L["ATLAS_SLASH"] = "/atlas"
L["ATLAS_SLASH_OPTIONS"] = "options"
L["ATLAS_STRING_CLEAR"] = "清除"
L["ATLAS_STRING_LEVELRANGE"] = "等級範圍"
L["ATLAS_STRING_LOCATION"] = "所在位置"
L["ATLAS_STRING_MINGEARLEVEL"] = "最低裝備等級"
L["ATLAS_STRING_MINLEVEL"] = "最低等級"
L["ATLAS_STRING_PLAYERLIMIT"] = "人數上限"
L["ATLAS_STRING_RECLEVELRANGE"] = "建議等級"
L["ATLAS_STRING_SEARCH"] = "搜尋"
L["ATLAS_STRING_SELECT_CAT"] = "選擇類別"
L["ATLAS_STRING_SELECT_MAP"] = "選擇地圖"
L["ATLAS_TITLE"] = "Atlas 地圖集"
L["ATLAS_TOGGLE_LOOT"] = "右鍵點擊以開啟首領戰利品視窗。"
L["Attunement Required"] = "需完成傳送門/鑰匙前置任務"
L["Back"] = "後方"
L["Basement"] = "地下室"
L["BINDING_HEADER_ATLAS_TITLE"] = "Atlas 按鍵設定"
L["BINDING_NAME_ATLAS_AUTOSEL"] = "自動選擇"
L["BINDING_NAME_ATLAS_OPTIONS"] = "切換設定"
L["BINDING_NAME_ATLAS_TOGGLE"] = "開啟/關閉 Atlas"
L["Blacksmithing Plans"] = "黑鐵鍛造圖樣"
L["Bodley"] = "布德利"
L["Bortega <Reagents & Poison Supplies>"] = "伯特卡 <施法材料和毒藥供應商>"
L["Brewfest"] = "啤酒節"
L["Child"] = "幼年"
L["Colon"] = "："
L["Comma"] = "，"
L["Connection"] = "通道"
L["East"] = "東"
L["Elevator"] = "電梯"
L["End"] = "結束"
L["Engineer"] = "工程師"
L["Entrance"] = "入口"
L["Event"] = "事件"
L["Exalted"] = "崇拜"
L["Exit"] = "出口"
L["Fourth Stop"] = "第四停留點"
L["Front"] = "前方"
L["Galgrom <Provisioner>"] = "卡葛隆姆 <物資供應者>"
L["Ghost"] = "鬼魂"
L["Graveyard"] = "墓地"
L["Hallow's End"] = "萬鬼節"
L["Heroic"] = "英雄"
L["Heroic_Symbol"] = "（英雄）"
L["Holy Paladin"] = "神聖聖騎"
L["Holy Priest"] = "神聖牧師"
L["Hyphen"] = "－"
L["Imp"] = "小鬼"
L["Key"] = "鑰匙"
L["L-DQuote"] = "「"
L["Lothos Riftwaker"] = "洛索斯·天痕"
L["Love is in the Air"] = "愛就在身邊"
L["Lower"] = "下層"
L["L-Parenthesis"] = "（"
L["L-SBracket"] = "【"
L["Lunar Festival"] = "新年慶典"
L["MapA"] = " [1]"
L["MapB"] = " [2]"
L["MapC"] = " [3]"
L["MapD"] = " [4]"
L["MapE"] = " [5]"
L["MapF"] = " [6]"
L["MapG"] = " [7]"
L["MapH"] = " [8]"
L["MapI"] = " [9]"
L["MapJ"] = " [10]"
L["MapsNotFound"] = [=[目前的副本找不到對應的地圖影像檔。

請確認您是否有安裝 Atlas 相關的副本地圖模組。]=]
L["Meeting Stone"] = "集合石"
L["Middle"] = "中間"
L["Midsummer Festival"] = "仲夏節慶"
L["Moonwell"] = "月井"
L["Mythic"] = "傳奇"
L["Mythic_Symbol"] = "（傳奇）"
L["North"] = "北"
L["Nozari <Keepers of Time>"] = "諾札瑞 <時光守望者>"
L["Optional"] = "可選擇"
L["Orange"] = "橙"
L["Orb of Command"] = "命令寶珠"
L["Outside"] = "戶外"
L["Period"] = "。"
L["Portal"] = "傳送門"
L["Portal to %s"] = "到%s的傳送門"
L["PossibleMissingModule"] = "遺失的地圖應是來自以下的模組："
L["Profile Options"] = "設定檔選項"
L["Protection Warrior"] = "防戰"
L["Purple"] = "紫"
L["Random"] = "隨機"
L["Rare"] = "稀有"
L["R-DQuote"] = "」"
L["Repair"] = "修理"
L["Retribution Paladin"] = "懲戒聖騎"
L["Rewards"] = "獎勵"
L["R-Parenthesis"] = "）"
L["R-SBracket"] = "】"
L["Scale and Transparency"] = "大小與透明度"
L["Scarshield Quartermaster <Scarshield Legion>"] = "裂盾軍需官 <裂盾軍團>"
L["Second Stop"] = "第二停留點"
L["Semicolon"] = "；"
L["Shadow Priest"] = "暗影牧師"
L["Slash"] = "／"
L["Soridormi <The Scale of Sands>"] = "索芮朵蜜 <流沙之鱗>"
L["South"] = "南"
L["Spawn Point"] = "生成點"
L["Stairs"] = "階梯"
L["Stairs to %s"] = "通往%s的階梯"
L["Start"] = "開始"
L["Steward of Time <Keepers of Time>"] = "時間服務員 <時光守望者>"
L["Summon"] = "召喚"
L["Teleporter"] = "傳送"
L["Teleporter destination"] = "傳送目的地"
L["The Behemoth"] = "貝希摩斯"
L["Third Stop"] = "第三停留點"
L["Top"] = "上方"
L["Transport"] = "傳送"
L["Tunnel"] = "通道"
L["Underwater"] = "水下"
L["Upper"] = "上層"
L["Upper floor"] = "上層"
L["Varies"] = "多處"
L["Wanders"] = "徘徊"
L["Wave 10"] = "第 10 波"
L["Wave 12"] = "第 12 波"
L["Wave 18"] = "第 18 波"
L["Wave 5"] = "第 5 波"
L["Wave 6"] = "第 6 波"
L["West"] = "西"
L["Yarley <Armorer>"] = "亞利 <護甲商>"
L["Zaladormu"] = "薩拉多姆"

end
