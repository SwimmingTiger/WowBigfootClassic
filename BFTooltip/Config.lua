--------------------------------------------------------------------------------------
-- BigFootTooltip 1.02
-- 日期: 2008-1-21
-- 作者: 独孤傲雪
-- 描述: 插件配置
-- 版权所有: 艾泽拉斯国家地理
---------------------------------------------------------------------------------------
local BFTT_ANCHOR_MAP, BFTT_RANK_MAP, BFTT_SHOW_MAP, BFTT_YESNO_MAP;

if (GetLocale() == "zhCN") then
	BFTT_ANCHOR_MAP = {
		 [NONE] = 1,
		["鼠标"] = 2,
		["左上"] = 3,
		["顶部"] = 4,
		["右上"] = 5,
		["左侧"] = 6,
		["中心"] = 7,
		["右侧"] = 8,
		["左下"] = 9,
		["底部"] = 10,
		["右下"] = 11,
	};
	BFTT_RANK_MAP = {
		["文字"] = 1,
		["图标"] = 2,
	};
	BFTT_SHOW_MAP = {
		["显示"] = 1,
		["隐藏"] = 2,
	};
	BFTT_YESNO_MAP = {
		["是"] = 1,
		["否"] = 2,
	};
elseif (GetLocale() == "zhTW") then
	BFTT_ANCHOR_MAP = {
		 [NONE] = 1,
		["鼠標"] = 2,
		["左上"] = 3,
		["頂部"] = 4,
		["右上"] = 5,
		["左側"] = 6,
		["中心"] = 7,
		["右側"] = 8,
		["左下"] = 9,
		["底部"] = 10,
		["右下"] = 11,
	};
	BFTT_RANK_MAP = {
		["文字"] = 1,
		["圖標"] = 2,
	};
	BFTT_SHOW_MAP = {
		["顯示"] = 1,
		["隱藏"] = 2,
	};
	BFTT_YESNO_MAP = {
		["是"] = 1,
		["否"] = 2,
	};	
else
	BFTT_ANCHOR_MAP = {
		 [NONE] = 1,
		["Following Mouse"] = 2,
		["Top Left"] = 3,
		["Top"] = 4,
		["Top Right"] = 5,
		["Left"] = 6,
		["Center"] = 7,
		["Right"] = 8,
		["Bottom Left"] = 9,
		["Bottom"] = 10,
		["Bottom Right"] = 11,
	};
	BFTT_RANK_MAP = {
		["Text"] = 1,
		["Texture"] = 2,
	};
	BFTT_SHOW_MAP = {
		["Show"] = 1,
		["Hide"] = 2,
	};
	BFTT_YESNO_MAP = {
		["Yes"] = 1,
		["No"] = 2,
	};
end
---------------------------------------------------------------------------------------
-- 配置部分
---------------------------------------------------------------------------------------
BFTT_OPTION_FUNC = {
	[1] = function (arg1)		
		BFTT_Config["Anchor"] = BFTT_ANCHOR_MAP[arg1] or BFTT_Config["Anchor"];			
	end,
	[2] = function (arg1)		
		BFTT_Config["PositionX"] = arg1 or BFTT_Config["PositionX"];
	end,
	[3] = function (arg1)
		BFTT_Config["PositionY"] = arg1 or BFTT_Config["PositionY"];
	end,
	[4] = function (arg1)		
		BFTT_Config["Fade"] = BFTT_YESNO_MAP[arg1] or BFTT_Config["Fade"];
	end,
	[5] = function (arg1)
		BFTT_Config["Talent"] = BFTT_SHOW_MAP[arg1] or BFTT_Config["Talent"];
	end,
	[6] = function (arg1)
		BFTT_Config["ItemLevel"] = BFTT_SHOW_MAP[arg1] or BFTT_Config["ItemLevel"];
	end,
	[7] = function (arg1)
		BFTT_Config["TOT"] = BFTT_SHOW_MAP[arg1] or BFTT_Config["TOT"];		
	end,
	[8] = function (arg1)
		BFTT_Config["Actor"] = BFTT_SHOW_MAP[arg1] or BFTT_Config["Actor"];
	end,
	[9] = function (arg1)
		BFTT_Config["GuildRank"] = BFTT_SHOW_MAP[arg1] or BFTT_Config["GuildRank"];
	end
};