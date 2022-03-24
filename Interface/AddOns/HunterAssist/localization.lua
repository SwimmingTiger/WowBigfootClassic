
if (GetLocale() == "zhCN") then
	HUNTERASSIST_NAME = "猎人助手";
	HUNTERASSIST_AIMED = "瞄准射击";
	HUNTERASSIST_CAST_BREAK = "被打断";
	HUNTERASSIST_ASPECT_CHEETAH = "猎豹守护";
	HUNTERASSIST_ASPECT_ASPECT_PACK = "豹群守护";
	HUNTERASSIST_ASPECT_DAZED ="眩晕";

	HUNTERASSIST_BEAST = "野兽";
	HUNTERASSIST_HUMANOID = "人型生物";
	HUNTERASSIST_UNDEAD = "亡灵";
	HUNTERASSIST_GIANT = "巨人";
	HUNTERASSIST_ELEMENTAL = "元素生物";
	HUNTERASSIST_DEMON = "恶魔";
	HUNTERASSIST_DRAGONKIN = "龙类";
	HUNTERASSIST_TAUREN = "牛头人";

	MISDIRECT_PATTERN = ">>$player<< 已被误导";

	HUNTERASSIST_OOR = "盲区";
	HUNTERASSIST_FRIEND = "友好目标";
	HUNTERASSIST_NO_TARGET = "无目标";
	HUNTERASSIST_RANGE_TOOLTIP = "shift + 左键移动位置";

	ZF_HUNTER = "猎人";
	ZF_NO_FOOD = "没有提供宠物粮食。\n拖曳物品图标入内可以设定宠物粮食。";
	ZF_HUNGER = "你的宠物饥肠辘辘，对你有些不满";
	ZF_BUTTON_TITLE = "宠物粮食供应";
	ZF_FOODNAME = "食物: ";
	ZF_FOODQUANTITY = "数量: ";
	BINDING_HEADER_ZFEEDER = "猎人助手";
	_G["BINDING_NAME_CLICK zFeederButton:LeftButton"] = "一键喂养";
	ZF_SLASH_HELP = {
		"使用方法： /zf 或者 /zfeeder",
		"/zf reset - 重置按钮于默认位置",
		"/zf free - 将按钮置于屏幕中心，按住CTRL可自由移动",
	};
elseif (GetLocale() == "zhTW") then
	HUNTERASSIST_NAME = "獵人助手";
	HUNTERASSIST_AIMED = "瞄準射擊";
	HUNTERASSIST_CAST_BREAK = "被打斷";
	HUNTERASSIST_ASPECT_CHEETAH = "獵豹守護";
	HUNTERASSIST_ASPECT_ASPECT_PACK = "豹群守護";
	HUNTERASSIST_ASPECT_DAZED = "眩暈";

	HUNTERASSIST_BEAST = "野獸";
	HUNTERASSIST_HUMANOID = "人型生物";
	HUNTERASSIST_UNDEAD = "亡靈";
	HUNTERASSIST_GIANT = "巨人";
	HUNTERASSIST_ELEMENTAL = "元素生物";
	HUNTERASSIST_DEMON = "惡魔";
	HUNTERASSIST_DRAGONKIN = "龍類";
	HUNTERASSIST_TAUREN = "牛頭人";

	MISDIRECT_PATTERN = ">>$player<< 已被誤導";

	HUNTERASSIST_OOR = "盲區";
	HUNTERASSIST_FRIEND = "友好目標";
	HUNTERASSIST_NO_TARGET = "無目標";
	HUNTERASSIST_RANGE_TOOLTIP = "shift + 左鍵移動位置";

	ZF_HUNTER = "獵人";
	ZF_NO_FOOD = "沒有提供寵物糧食";
	ZF_HUNGER = "你的寵物飢腸轆轆，對你有些不滿";
	ZF_BUTTON_TITLE = "宠物糧食供應";
	ZF_FOODNAME = "食物: ";
	ZF_FOODQUANTITY = "數量: ";
	BINDING_HEADER_ZFEEDER = "獵人助手";
	_G["BINDING_NAME_CLICK zFeederButton:LeftButton"] = "一鍵餵養";
	ZF_SLASH_HELP = {
		"用法：/zf 或 /zfeeder",
		"/zf reset - 重置按鈕于默認位置",
		"/zf free - 將按鈕置于屏幕中心，按住CTRL可自由移動",
	};
else
	HUNTERASSIST_NAME = "Hunter Assist";
	HUNTERASSIST_AIMED = "Aimed Shot";
	HUNTERASSIST_CAST_BREAK = "Break";
	HUNTERASSIST_ASPECT_CHEETAH = "Aspect of the Cheetah";
	HUNTERASSIST_ASPECT_ASPECT_PACK = "Aspect of the Pack";
	HUNTERASSIST_ASPECT_DAZED = "Dazed";

	HUNTERASSIST_BEAST = "Beast";
	HUNTERASSIST_HUMANOID = "Humanoid";
	HUNTERASSIST_UNDEAD = "Undead";
	HUNTERASSIST_GIANT = "Giant";
	HUNTERASSIST_ELEMENTAL = "Elemental";
	HUNTERASSIST_DEMON = "Demon";
	HUNTERASSIST_DRAGONKIN = "Dragonkin";
	HUNTERASSIST_TAUREN = "Tauren";

	MISDIRECT_PATTERN = "Misdirect >>$player<<";

	HUNTERASSIST_OOR = "OOR";
	HUNTERASSIST_FRIEND = "Friend";
	HUNTERASSIST_NO_TARGET = "NONE";
	HUNTERASSIST_RANGE_TOOLTIP = "shift + Left click to move frame";

	ZF_HUNTER = "Hunter";
	ZF_NO_FOOD = "No food selected";
	ZF_HUNGER = "Pet is hungery, not very happy";
	ZF_BUTTON_TITLE = "Pet Food Supply";
	ZF_FOODNAME = "Food: ";
	ZF_FOODQUANTITY = "Quantity: ";
	BINDING_HEADER_ZFEEDER = "Hunter Assist";
	_G["BINDING_NAME_CLICK zFeederButton:LeftButton"] = "zFeeder";
	ZF_SLASH_HELP = {
		"Usage: /zf or /zfeeder",
		"/zf reset - reset button position to default",
		"/zf free - center the button, you can move it by hold CTRL key",
	};
end