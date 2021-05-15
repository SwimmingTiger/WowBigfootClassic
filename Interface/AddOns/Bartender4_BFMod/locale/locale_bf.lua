--------修改本地化。创建本地化为NewLocale 不是getLocale 这里可能是之前的笔误-------------------
local L_zhCN = LibStub("AceLocale-3.0"):NewLocale("Bartender4", "zhCN")
if L_zhCN then 
	L_zhCN["Unit Frame"] = "单位框体"
	L_zhCN["Enable the Unit Frame"] = "启用单位框体"
	L_zhCN["Configure the Unit Frame"] = "配置单位框体"
	L_zhCN["PlayerFrame"] = "玩家框体"
	L_zhCN["TargetFrame"] = "目标框体"
	L_zhCN["FocusFrame"] = "焦点框体"
	L_zhCN["BuffFrame"] = "增益框体"
	L_zhCN["MinimapCluster"] = "小地图框体"
	L_zhCN["WatchFrame"] = "任务框体"
	L_zhCN["CastingBarFrame"] = "施法条框体"
	L_zhCN["PartyMemberFrame1"] = "队友框体1"
	L_zhCN["PartyMemberFrame2"] = "队友框体2"
	L_zhCN["PartyMemberFrame3"] = "队友框体3"
	L_zhCN["PartyMemberFrame4"] = "队友框体4"
	L_zhCN["Simple Style"] = "简单风格"
	L_zhCN["Modern Style"] = "现代风格"
end

local L_zhTW = LibStub("AceLocale-3.0"):NewLocale("Bartender4", "zhTW")
if L_zhTW then 
	L_zhTW["Unit Frame"] = "單位框體"
	L_zhTW["Enable the Unit Frame"] = "啟用單位框體"
	L_zhTW["Configure the Unit Frame"] = "配置單位框體"
	L_zhTW["PlayerFrame"] = "玩家框體"
	L_zhTW["TargetFrame"] = "目標框體"
	L_zhTW["FocusFrame"] = "焦點框體"
	L_zhTW["BuffFrame"] = "增益框體"
	L_zhTW["MinimapCluster"] = "小地圖框體"
	L_zhTW["WatchFrame"] = "任務框體"
	L_zhTW["CastingBarFrame"] = "施法條框體"
	L_zhTW["PartyMemberFrame1"] = "隊友框體1"
	L_zhTW["PartyMemberFrame2"] = "隊友框體2"
	L_zhTW["PartyMemberFrame3"] = "隊友框體3"
	L_zhTW["PartyMemberFrame4"] = "隊友框體4"
	L_zhTW["Simple Style"] = "簡單風格"
	L_zhTW["Modern Style"] = "現代風格"
end
