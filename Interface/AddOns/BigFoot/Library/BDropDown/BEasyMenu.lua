
--==================================================
-- 文件名: BEasyMenu.lua
-- 日期: 2008年5月21日
-- 作者: 独孤傲雪
-- 描述: 提供按table方式创建下拉菜单的功能.
-- 版权所有: 艾泽拉斯国家地理
--===================================================

--[[
	● 简要介绍:
		BEasyMenu将繁琐的菜单创建工作变得稍微简单, 最重要的是我们完全将数据与表现分
	离开来, 便于开发和维护.

	● 开发文档:
		1. 原型: BEasyMenu_Register(parent, menuList)
		    参数:
				parent     - <Button> 需要设置右键菜单的框架
				menuList - <table>  创建菜单所需要的表格(具体参数见后)
			描述: 该方法提供了一种简单的给目标框架创建右键菜单的功能.

		2. 原型: BEasyMenu(menuList, menuFrame, anchor, x, y, displayMode)
			参数:
				menuList	  - <table>	创建菜单所需要的表格
				menuFrame - <Frame>	继承自"BDropDownMenuTemplate"框架
				anchor		  - <string>	可为"cursor"
				x				  - <number> x轴偏移, 当anchor为"cursor"时无效
				y				  - <number> y轴偏移, 当anchor为"cursor"时无效
				displayMode - <string>	 可为"MENU"
			描述: 该方法提供了按照表格数据创建下拉菜单的功能. 建议使用BEasyMenu_Register方法创建
					 右键菜单.

	● 一个简单的菜单例子(我不保证该例子能正常工作, 更具体的例子参见[独孤傲雪]<<萨满祭司助手>>Options.lua)

	local DemoMenu = {
		{
			text = "点我丫",
			func = function()
				message("让你点你就点啊!");
			end,
		},
		{
			text = "我有下级菜单",
			hasArrow = 1,
			value = "menu2",	-- [必须, 该变量用于识别子菜单]
			subMenu = {			-- [必须]
				{
					text = "我的二级菜单",
					level = 2,				-- [必须]
					func = function()
						message("二级也是菜单啊");
					end
				},
				{
					text = "我可以选颜色哦",
					level = 2,				-- [必须]
					hasColorSwatch = 1, -- 不可用
				},
			},
		},
	};

	BEasyMenu_Register(parent, DemoMenu);
]]

BEASY_MENU_INDEX = 1;

function BEasyMenu(menuList, menuFrame, anchor, x, y, displayMode)
	BDropDownMenu_Initialize(menuFrame, BEasyMenu_Initialize, displayMode, nil, menuList);
	--BToggleDropDownMenu(1, nil, menuFrame, anchor, x, y, menuList);
end

function BEasyMenu_Initialize(frame, level, menuList)
	if (type(menuList) == "table") then
		local info =BDropDownMenu_CreateInfo();
		for index = 1, #(menuList) do
			info = menuList[index];
			if (info.text) then
				info.index = index;
				info.level = info.level or 1;
				if (level == info.level) then
					BDropDownMenu_AddButton(info, level);
				else
					if (info.hasArrow and info.subMenu and BDROPDOWNMENU_MENU_VALUE == info.value) then
						BEasyMenu_Initialize(info.subMenu, level);
						return;
					end
				end
			end
		end
	end
end

function BEasyMenu_Register(parent, menuList)
	parent:RegisterForClicks("LeftButtonDown", "LeftButtonUp", "RightButtonUp");
	local name = parent:GetName() and parent:GetName() .. "MenuFrame" or "BigFootEasyMenu" .. BEASY_MENU_INDEX;
	parent.menuFrame = parent.menuFrame or CreateFrame("Frame", name, parent, "UIDropDownMenuTemplate");
	parent.menuFrame:Hide();
	BEasyMenu(menuList, parent.menuFrame, "cursor", nil, nil, "MENU");
	if (parent:GetScript("OnClick")) then
		parent:HookScript("OnClick", function(self, button)
			if (button == "RightButton") then
				BToggleDropDownMenu(nil, nil, self.menuFrame, "cursor",  nil, nil, menuList);
			end
		end);
	else
		parent:SetScript("OnClick", function(self, button)
			if (button == "RightButton") then
				BToggleDropDownMenu(nil, nil, self.menuFrame, "cursor", nil, nil, menuList);
			end
		end);
	end
	BEASY_MENU_INDEX = BEASY_MENU_INDEX + 1;
end
