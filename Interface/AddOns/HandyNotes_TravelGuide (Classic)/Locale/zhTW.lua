local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("HandyNotes_TravelGuide (Classic)", "zhTW");
if not L then return end

if L then

--config.options
L["HandyNotes: TravelGuide (Classic)"] = "HandyNotes: 船和飞艇"
L["Icon settings"] = "图标设置"
L["These settings control the look and feel of the icon."] = "控制图标的外观及风格"
L["Icon Scale"] = "图标缩放"
L["The scale of the icons"] = "对图标进行缩放"
L["Icon Alpha"] = "图标透明度"
L["The alpha transparency of the icons"] = "控制图标的透明程度"
L["What to display?"] = "要显示哪些图标？"
L["These settings control what type of icons to be displayed."] = "控制地图上显示的图标种类"
L["Boat"] = "船"
L["Show the boat locations."] = "显示船的位置"
L["Alliance Boat"] = "联盟船"
L["Show the Alliance boat locations."] = "显示联盟方船的位置"
L["Zeppelin"] = "飞艇"
L["Show the Zeppelin locations."] = "显示飞艇的位置"
L["Horde Zeppelin"] = "部落飞艇"
L["Show the Horde Zeppelin locations."] = "显示部落方飞艇的位置"
L["Note"] = "备注"
L["Show the node's additional notes when it's available."] = "在鼠标提示中显示备注信息"
L["Deeprun Tram"] = "矿道地铁"
L["Show the Deeprun Tram locations in Stormwind and Ironforge."] = "显示暴风城到铁炉堡的矿道地铁"

--Plugin_config
L["AddOn Settings"] = "插件设置"
L["Query from server"] = "向服务器查询"
L["Send query request to server to lookup localized name. May be a little bit slower for the first time lookup but would be very fast once the name is found and cached."] = "向服务器查询标记名称的本地化版本。首次查询时可能比较慢，一但查到了名称并进行了缓存，以后就很快了。"
L["Reset hidden nodes"] = "重置隐藏的标记"
L["Show all nodes that you manually hid by right-clicking on them and choosing \"hide\"."] = "重新显示所有你右击并选择“隐藏”的标记"

--Handler
L["Shows the boat and zepplin locations on the World Map and the MiniMap."] = "在世界地图和小地图上显示船和飞艇的位置"
L["TravelGuide (Classic)"] = "船和飞艇"

--DB
L["Eastern Kingdoms"] = "东部王国"
L["Eastern Kingdoms, Wetlands"] = "东部王国，湿地"
L["Boat to Menethil Harbor"] = "去米奈希尔港的船"

L["Eastern Kingdoms, Tirisfal Glades"] = "东部王国，提瑞斯法林地"
L["Zeppelin to Undercity"] = "去幽暗城的飞艇"

L["Eastern Kingdoms, Stranglethorn Vale"] = "东部王国，荆棘谷"
L["Eastern Kingdoms, Grom'gol Base Camp"] = "东部王国，格罗姆高营地"
L["Zeppelin to Stranglethorn Vale"] = "去荆棘谷的飞艇"
L["Boat to Booty Bay"] = "去藏宝海湾的船"

L["Eastern Kingdoms, Elwynn Forest"] = "东部王国，艾尔文森林"
L["Deeprun Tram to Stormwind"] = "去暴风城的矿道地铁"

L["Eastern Kingdoms, Dun Morogh"] = "东部王国，丹莫罗"
L["Deeprun Tram to Ironforge"] = "去铁炉堡的矿道地铁"

L["Kalimdor"] = "卡利姆多"
L["Kalimdor, Durotar"] = "卡利姆多，杜隆塔尔"
L["Zeppelin to Orgrimmar"] = "去奥格瑞玛的船"

L["Kalimdor, Teldrassil"] = "卡利姆多，泰达希尔"
L["Boat to Darnassus"] = "去达纳苏斯的船"

L["Kalimdor, The Barrens"] = "卡利姆多，贫瘠之地"
L["Boat to Ratchet"] = "去棘齿城的船"

L["Kalimdor, Dustwallow Marsh"] = "卡利姆多，尘泥沼泽"
L["Boat to Theramore"] = "去塞拉摩的船"

L["Kalimdor, Darkshore"] = "卡利姆多，黑海岸"
L["Boat to Auberdine"] = "去奥伯丁的船"

end
