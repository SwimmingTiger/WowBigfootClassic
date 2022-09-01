-- $Id: Atlas-zhCN.lua 374 2022-01-26 14:33:01Z arithmandar $
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
-- Atlas Localization Data (Simplified Chinese)
-- Initial translation by DiabloHu
-- Maintained by DiabloHu, arith, Ananhaid

local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("Atlas", "zhCN", false);

if ( GetLocale() == "zhCN" ) then
-- Define the leading strings to be ignored while sorting
-- Ex: The Stockade
AtlasSortIgnore = {};

-- Syntax: ["real_zone_name"] = "localized map zone name"
AtlasZoneSubstitutions = {
	["Ahn'Qiraj"] = "安其拉神殿";
	["The Temple of Atal'Hakkar"] = "阿塔哈卡神庙";
};
end


if L then
L[" 1/2"] = "1/2"
L[" 2/2"] = "2/2"
L["%s Dungeons"] = "%s地下城"
L["%s Instances"] = "%s副本"
L["%s Raids"] = "%s团队"
L["Adult"] = "成年"
L["AKA"] = "亦作"
L["Alexston Chrome <Tavern of Time>"] = "阿历克斯顿·克罗姆 <时间旅店>"
L["Alurmi <Keepers of Time Quartermaster>"] = "艾鲁尔米 <时光守护者军需官>"
L["Anachronos <Keepers of Time>"] = "阿纳克洛斯 <时光守护者>"
L["Andormu <Keepers of Time>"] = "安多姆 <时光守护者>"
L["Arazmodu <The Scale of Sands>"] = "阿拉兹姆多 <流沙之鳞>"
L["Arcane Container"] = "奥术容器"
L["Arms Warrior"] = "武器战士"
L["ATLAS_BUTTON_CLOSE"] = "关闭"
L["ATLAS_CLICK_TO_OPEN"] = "点击打开 Atlas 地图窗口。"
L["ATLAS_CLOSE_ATLASLOOT_WINDOW"] = "右击关闭 AtlasLoot 窗口。"
L["ATLAS_COLLAPSE_BUTTON"] = "点击关闭 Atlas 传奇面板。"
L["ATLAS_DDL_CONTINENT"] = "所属大陆"
L["ATLAS_DDL_CONTINENT_BROKENISLES"] = "破碎群岛副本"
L["ATLAS_DDL_CONTINENT_BROKENISLES1"] = "破碎群岛地下城"
L["ATLAS_DDL_CONTINENT_BROKENISLES2"] = "破碎群岛团队"
L["ATLAS_DDL_CONTINENT_DEEPHOLM"] = "深岩之洲副本"
L["ATLAS_DDL_CONTINENT_DRAENOR"] = "德拉诺副本"
L["ATLAS_DDL_CONTINENT_EASTERN"] = "东部王国副本"
L["ATLAS_DDL_CONTINENT_KALIMDOR"] = "卡利姆多副本"
L["ATLAS_DDL_CONTINENT_KULTIRAS"] = "库尔提拉斯副本"
L["ATLAS_DDL_CONTINENT_NAZJATAR"] = "纳沙塔尔副本"
L["ATLAS_DDL_CONTINENT_NORTHREND"] = "诺森德副本"
L["ATLAS_DDL_CONTINENT_OUTLAND"] = "外域副本"
L["ATLAS_DDL_CONTINENT_PANDARIA"] = "潘达利亚副本"
L["ATLAS_DDL_CONTINENT_ZANDALAR"] = "赞达拉副本"
L["ATLAS_DDL_EXPANSION"] = "资料片"
L["ATLAS_DDL_EXPANSION_BC"] = "《燃烧的远征》副本"
L["ATLAS_DDL_EXPANSION_BFA"] = "《争霸艾泽拉斯》副本"
L["ATLAS_DDL_EXPANSION_CATA"] = "《大地的裂变》副本"
L["ATLAS_DDL_EXPANSION_LEGION"] = "《军团再临》副本"
L["ATLAS_DDL_EXPANSION_LEGION1"] = "军团再临地下城"
L["ATLAS_DDL_EXPANSION_LEGION2"] = "军团再临团队"
L["ATLAS_DDL_EXPANSION_MOP"] = "《熊猫人之谜》副本"
L["ATLAS_DDL_EXPANSION_OLD"] = "《经典旧世》副本"
L["ATLAS_DDL_EXPANSION_SHADOWLANDS"] = "《暗影国度》副本"
L["ATLAS_DDL_EXPANSION_WOD"] = "《德拉诺之王》副本"
L["ATLAS_DDL_EXPANSION_WOTLK"] = "《巫妖王之怒》副本"
L["ATLAS_DDL_LEVEL"] = "等级"
L["ATLAS_DDL_LEVEL_100PLUS"] = "100 级以上副本"
L["ATLAS_DDL_LEVEL_100TO110"] = "100-110 级副本"
L["ATLAS_DDL_LEVEL_10TO30"] = "副本等级 10-30"
L["ATLAS_DDL_LEVEL_110PLUS"] = "110 级以上副本"
L["ATLAS_DDL_LEVEL_110TO120"] = "110-120 级副本"
L["ATLAS_DDL_LEVEL_120PLUS"] = "120 级以上副本"
L["ATLAS_DDL_LEVEL_120TO130"] = "120-130 级副本"
L["ATLAS_DDL_LEVEL_130PLUS"] = "130 级以上副本"
L["ATLAS_DDL_LEVEL_30TO35"] = "副本等级 30-35"
L["ATLAS_DDL_LEVEL_35TO40"] = "副本等级 35-40"
L["ATLAS_DDL_LEVEL_40TO45"] = "副本等级 40-45"
L["ATLAS_DDL_LEVEL_45TO50"] = "副本等级 45-50"
L["ATLAS_DDL_LEVEL_45TO60"] = "45-60 级副本"
L["ATLAS_DDL_LEVEL_50TO60"] = "副本等级 50-60"
L["ATLAS_DDL_LEVEL_60PLUS"] = "60 级以上副本"
L["ATLAS_DDL_LEVEL_60TO70"] = "60-70 级副本"
L["ATLAS_DDL_LEVEL_70TO80"] = "70-80 级副本"
L["ATLAS_DDL_LEVEL_80TO85"] = "80-85 级副本"
L["ATLAS_DDL_LEVEL_85TO90"] = "85-90 级以副本"
L["ATLAS_DDL_LEVEL_90TO100"] = "90-100 级以副本"
L["ATLAS_DDL_LEVEL_UNDER30"] = "等级30之下副本"
L["ATLAS_DDL_LEVEL_UNDER45"] = "45 级以下副本"
L["ATLAS_DDL_PARTYSIZE"] = "副本规模"
L["ATLAS_DDL_PARTYSIZE_10"] = "10人副本"
L["ATLAS_DDL_PARTYSIZE_20TO40"] = "20-40人副本"
L["ATLAS_DDL_PARTYSIZE_5"] = "5人副本"
L["ATLAS_DDL_TYPE"] = "类型"
L["ATLAS_DDL_TYPE_ENTRANCE"] = "入口"
L["ATLAS_DDL_TYPE_INSTANCE"] = "副本"
L["ATLAS_DEP_MSG1"] = "检测到过期的 Atlas 扩展/模块/插件。"
L["ATLAS_DEP_MSG2"] = "这些插件在此角色已经被禁用。"
L["ATLAS_DEP_MSG3"] = [=[请从插件目录（AddOns）中将其删除并安装最新的。

过期扩展/模块/插件列表：]=]
L["ATLAS_DEP_MSG4"] = [=[每当安一个装最新的，
别忘了在插件列表里启用它。]=]
L["ATLAS_DEP_OK"] = "确定"
L["ATLAS_ENTRANCE_BUTTON"] = "入口"
L["ATLAS_EXPAND_BUTTON"] = "点击打开 Atlas 传奇面板。"
L["ATLAS_INFO"] = "Atlas 信息"
L["ATLAS_INFO_12200"] = [=[重要提示：

由于增加插件文件大小的关注，我们
移出部分地下城地图和内置插件到单
独模块。　　　　　　　　　　　　

用户可以从各大知名的游戏站点下载
我们的插件可能只包含了 Atlas 核心
功能以及大灾变地图。　　　　　　

用户如果想下载全部旧地下城地图和
全部我们制作的 Atlas 其他模块需要
单独下载。　　　　　　　　　　　

阅读更多信息在下面的论坛主题：
|cff6666ffhttp://www.atlasmod.com/phpBB3/viewtopic.php?t=1522|cffffffff

或访问我们的网站查看下载：
|cff6666ffhttp://www.atlasmod.com/|cffffffff]=]
L["ATLAS_INFO_12201"] = [=[我们最近新增了一个新的 Atlas 插件 - |cff6666ffAtlas 情景战役|cffffffff，用以提供 WoW 5.0 
起新增的情景战役的地图。

请详见我们的网站以取得更详细的信息，并请记得分别下载并安装此插件。
|cff6666ffhttp://www.atlasmod.com/|cffffffff]=]
L["ATLAS_INSTANCE_BUTTON"] = "副本"
L["ATLAS_LDB_HINT"] = [=[单击打开 Atlas。
右击打开 Atlas 选项。]=]
L["ATLAS_MINIMAPLDB_HINT"] = [=[单击打开 Atlas。
右击打开 Atlas 选项。
单击並拖拉可移动这个按钮。]=]
L["ATLAS_MISSING_MODULE"] = [=[Atlas 已侦测到遗失的模块/插件。

它可能是已过期的模块/插件，并被 Atlas 禁用。
如果现在安装全部最新版，到插件列表查看他们是否已被启用。

如果确定不需要这些“缺失”的模块/插件并不希望再次看到此消息，可以到选项面板禁用此提示。

缺失模块/插件列表：
]=]
L["ATLAS_NO_MODULE_OR_PLUGIN"] = [=[|cffff66ff错误：|r
Atlas 不能侦测到安装或启用任何
地图模块或插件。
请注意 Atlas 自身是地图浏览器，
需要安装至少一个地图模块或插
件才能浏览地图。]=]
L["ATLAS_OPEN_ACHIEVEMENT"] = "点击打开成就细节。"
L["ATLAS_OPEN_ADDON_LIST"] = "打开插件列表"
L["ATLAS_OPEN_ADVENTURE"] = "点击打开冒险指南窗口。"
L["ATLAS_OPEN_ATLASLOOT_WINDOW"] = "点击打开 AtlasLoot 窗口。"
L["ATLAS_OPEN_WOWMAP_WINDOW"] = "点击打开冒险指南地图窗口。"
L["ATLAS_OPTIONS_ACRONYMS"] = "显示简称"
L["ATLAS_OPTIONS_ACRONYMS_TIP"] = "在地图的详尽叙述中显示副本的缩写。"
L["ATLAS_OPTIONS_AUTOSEL"] = "自动选择副本地图"
L["ATLAS_OPTIONS_AUTOSEL_TIP"] = "Atlas 可侦测您目前所在的副区域以判定您所在的副本，开启 Atlas 时将会自动选择到该副本地图。"
L["ATLAS_OPTIONS_BOSS_DESC"] = "当首领信息可获取时, 显示该信息"
L["ATLAS_OPTIONS_BOSS_DESC_SCALE"] = "首领信息提示窗口大小比率"
L["ATLAS_OPTIONS_BOSS_DESC_TIP"] = "当鼠标光标移动到地图上首领的标号时, 并且首领信息可获取时, 显示该首领的相关信息."
L["ATLAS_OPTIONS_BOSS_POTRAIT"] = "当可用时显示首领头像"
L["ATLAS_OPTIONS_BUTPOS"] = "图标位置"
L["ATLAS_OPTIONS_BUTRAD"] = "图标半径"
L["ATLAS_OPTIONS_BUTTON"] = "选项"
L["ATLAS_OPTIONS_CATDD"] = "副本地图排序方式："
L["ATLAS_OPTIONS_CHECKMODULE"] = "提醒我是否有遗失的模块或插件"
L["ATLAS_OPTIONS_CHECKMODULE_TIP"] = "勾选以在每次登入 WoW 时检查是否有遗失的 Atlas 模块或插件。"
L["ATLAS_OPTIONS_CLAMPED"] = "不超出游戏画面"
L["ATLAS_OPTIONS_CLAMPED_TIP"] = "使 Atlas 窗口被拖曳时不会超出游戏主画面的边界, 关闭此选项则可将 Atlas 窗口拖曳并超出游戏画面边界。"
L["ATLAS_OPTIONS_COLORINGDROPDOWN"] = "副本以难易度色彩显示"
L["ATLAS_OPTIONS_COLORINGDROPDOWN_TIP"] = "依据副本建议的最低进入等级、以及玩家等级的差异，将副本以难易度色彩显示。"
L["ATLAS_OPTIONS_CTRL"] = "按下 Ctrl 显示弹出工具说明"
L["ATLAS_OPTIONS_CTRL_TIP"] = "勾选后当鼠标移到地图信息字段时，按下 Ctrl 控制键，则会将信息的完整信息以提示型态显示。当信息过长而被截断时很有用。"
L["ATLAS_OPTIONS_DONTSHOWAGAIN"] = "不再显示相同信息。"
L["ATLAS_OPTIONS_HEADER_ADDONCONFIG"] = "插件配置"
L["ATLAS_OPTIONS_HEADER_DISPLAY"] = "显示选项"
L["ATLAS_OPTIONS_LOCK"] = "锁定 Atlas 窗口"
L["ATLAS_OPTIONS_LOCK_TIP"] = "切换锁定/解锁 Atlas 窗口。"
L["ATLAS_OPTIONS_MAXMENUITEMS"] = "菜单物品最大值"
L["ATLAS_OPTIONS_MAXMENUITEMS_TIP"] = "配置下拉菜单可显示的最大数量，超过限制的会分离到下一个菜单类别。"
L["ATLAS_OPTIONS_RCLICK"] = "右击打开世界地图"
L["ATLAS_OPTIONS_RCLICK_TIP"] = "在 Atlas 窗口中右击自动切换到魔兽的世界地图。"
L["ATLAS_OPTIONS_RESETPOS"] = "重置位置"
L["ATLAS_OPTIONS_SCALE"] = "缩放"
L["ATLAS_OPTIONS_SHOWBUT"] = "在小地图周围显示图标"
L["ATLAS_OPTIONS_SHOWBUT_TIP"] = "在小地图旁显示 Atlas 按钮。"
L["ATLAS_OPTIONS_SHOWWMBUT"] = "在世界地图窗口显示按钮。"
L["ATLAS_OPTIONS_TRANS"] = "透明度"
L["ATLAS_REOPEN_LOOT_AGAIN"] = "重载后重新打开拾取窗口。"
L["ATLAS_ROPEN_ATLASLOOT_WINDOW"] = "右击打开 AtlasLoot 窗口。"
L["ATLAS_SEARCH_UNAVAIL"] = "搜索不可用"
L["ATLAS_SLASH"] = "/atlas"
L["ATLAS_SLASH_OPTIONS"] = "options"
L["ATLAS_STRING_CLEAR"] = "重置"
L["ATLAS_STRING_LEVELRANGE"] = "等级跨度"
L["ATLAS_STRING_LOCATION"] = "区域"
L["ATLAS_STRING_MINGEARLEVEL"] = "最低装备等级"
L["ATLAS_STRING_MINLEVEL"] = "需要等级"
L["ATLAS_STRING_PLAYERLIMIT"] = "人数上限"
L["ATLAS_STRING_RECLEVELRANGE"] = "建议等级"
L["ATLAS_STRING_SEARCH"] = "搜索"
L["ATLAS_STRING_SELECT_CAT"] = "选择分类"
L["ATLAS_STRING_SELECT_MAP"] = "选择地图"
L["ATLAS_TITLE"] = "Atlas"
L["ATLAS_TOGGLE_LOOT"] = "右击切换拾取面板。"
L["Attunement Required"] = "需要完成入口任务"
L["Back"] = "后门"
L["Basement"] = "底层"
L["BINDING_HEADER_ATLAS_TITLE"] = "Atlas 绑定"
L["BINDING_NAME_ATLAS_AUTOSEL"] = "自动选择"
L["BINDING_NAME_ATLAS_OPTIONS"] = "切换选项"
L["BINDING_NAME_ATLAS_TOGGLE"] = "切换 Atlas"
L["Blacksmithing Plans"] = "锻造设计图"
L["Bodley"] = "伯德雷"
L["Bortega <Reagents & Poison Supplies>"] = "波特加 <材料与毒药商>"
L["Brewfest"] = "美酒节"
L["Child"] = "幼年"
L["Colon"] = "："
L["Comma"] = "，"
L["Connection"] = "通道"
L["East"] = "东"
L["Elevator"] = "升降梯"
L["End"] = "尾部"
L["Engineer"] = "工程师"
L["Entrance"] = "入口"
L["Event"] = "事件"
L["Exalted"] = "崇拜"
L["Exit"] = "出口"
L["Fourth Stop"] = "第四次止步"
L["Front"] = "前门"
L["Galgrom <Provisioner>"] = "加尔戈罗姆 <供给商人>"
L["Ghost"] = "幽灵"
L["Graveyard"] = "墓地"
L["Hallow's End"] = "万圣节"
L["Heroic"] = "英雄模式"
L["Heroic_Symbol"] = "（英雄）"
L["Holy Paladin"] = "神圣圣骑士"
L["Holy Priest"] = "神圣牧师"
L["Hyphen"] = " - "
L["Imp"] = "小鬼"
L["Key"] = "钥匙"
L["L-DQuote"] = "“"
L["Lothos Riftwaker"] = "洛索斯·天痕"
L["Love is in the Air"] = "情人节"
L["Lower"] = "下层"
L["L-Parenthesis"] = "（"
L["L-SBracket"] = "["
L["Lunar Festival"] = "春节庆典"
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
L["MapsNotFound"] = [=[当前选定的地下城没有
与之相对应的地图图像。

请确认已经安装
相应的 Atlas 地图模块。]=]
L["Meeting Stone"] = "集合石"
L["Middle"] = "中间"
L["Midsummer Festival"] = "仲夏火焰节"
L["Moonwell"] = "月亮井"
L["Mythic"] = "（史诗）"
L["Mythic_Symbol"] = "（史诗）"
L["North"] = "北"
L["Nozari <Keepers of Time>"] = "诺萨莉 <时光守护者>"
L["Optional"] = "可跳过"
L["Orange"] = "橙色"
L["Orb of Command"] = "命令宝珠"
L["Outside"] = "室外"
L["Period"] = "。"
L["Portal"] = "传送"
L["Portal to %s"] = "传送到%s"
L["PossibleMissingModule"] = "它们可能来自以下模块："
L["Profile Options"] = "配置文件选项"
L["Protection Warrior"] = "防护战士"
L["Purple"] = "紫色"
L["Random"] = "随机"
L["Rare"] = "稀有"
L["R-DQuote"] = "”"
L["Repair"] = "修理"
L["Retribution Paladin"] = "惩戒圣骑士"
L["Rewards"] = "奖励"
L["R-Parenthesis"] = "）"
L["R-SBracket"] = "]"
L["Scale and Transparency"] = "缩放和透明度"
L["Scarshield Quartermaster <Scarshield Legion>"] = "裂盾军需官 <裂盾军团>"
L["Second Stop"] = "第二次止步"
L["Semicolon"] = "；"
L["Shadow Priest"] = "暗影牧师"
L["Slash"] = " / "
L["Soridormi <The Scale of Sands>"] = "索莉多米 <流沙之鳞>"
L["South"] = "南"
L["Spawn Point"] = "刷新点"
L["Stairs"] = "楼梯"
L["Stairs to %s"] = "楼梯到%s"
L["Start"] = "起始"
L["Steward of Time <Keepers of Time>"] = "时间管理者 <时光守护者>"
L["Summon"] = "召唤"
L["Teleporter"] = "传送"
L["Teleporter destination"] = "传送目的地"
L["The Behemoth"] = "贝哈默斯"
L["Third Stop"] = "第三次止步"
L["Top"] = "顶层"
L["Transport"] = "传送点"
L["Tunnel"] = "通道"
L["Underwater"] = "水下"
L["Upper"] = "上层"
L["Upper floor"] = "上层"
L["Varies"] = "多个位置"
L["Wanders"] = "游荡"
L["Wave 10"] = "第10波"
L["Wave 12"] = "第12波"
L["Wave 18"] = "第18波"
L["Wave 5"] = "第5波"
L["Wave 6"] = "第6波"
L["West"] = "西"
L["Yarley <Armorer>"] = "亚尔雷 <护甲商>"
L["Zaladormu"] = "扎拉多姆"

end
