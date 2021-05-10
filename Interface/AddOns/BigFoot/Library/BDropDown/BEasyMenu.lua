
--==================================================
-- �ļ���: BEasyMenu.lua
-- ����: 2008��5��21��
-- ����: ���°�ѩ
-- ����: �ṩ��table��ʽ���������˵��Ĺ���.
-- ��Ȩ����: ������˹���ҵ���
--===================================================

--[[
	�� ��Ҫ����:
		BEasyMenu�������Ĳ˵��������������΢��, ����Ҫ����������ȫ����������ַ�
	�뿪��, ���ڿ�����ά��.

	�� �����ĵ�:
		1. ԭ��: BEasyMenu_Register(parent, menuList)
		    ����:
				parent     - <Button> ��Ҫ�����Ҽ��˵��Ŀ��
				menuList - <table>  �����˵�����Ҫ�ı��(�����������)
			����: �÷����ṩ��һ�ּ򵥵ĸ�Ŀ���ܴ����Ҽ��˵��Ĺ���.

		2. ԭ��: BEasyMenu(menuList, menuFrame, anchor, x, y, displayMode)
			����:
				menuList	  - <table>	�����˵�����Ҫ�ı��
				menuFrame - <Frame>	�̳���"BDropDownMenuTemplate"���
				anchor		  - <string>	��Ϊ"cursor"
				x				  - <number> x��ƫ��, ��anchorΪ"cursor"ʱ��Ч
				y				  - <number> y��ƫ��, ��anchorΪ"cursor"ʱ��Ч
				displayMode - <string>	 ��Ϊ"MENU"
			����: �÷����ṩ�˰��ձ�����ݴ��������˵��Ĺ���. ����ʹ��BEasyMenu_Register��������
					 �Ҽ��˵�.

	�� һ���򵥵Ĳ˵�����(�Ҳ���֤����������������, ����������Ӳμ�[���°�ѩ]<<������˾����>>Options.lua)

	local DemoMenu = {
		{
			text = "����Ѿ",
			func = function()
				message("�������͵㰡!");
			end,
		},
		{
			text = "�����¼��˵�",
			hasArrow = 1,
			value = "menu2",	-- [����, �ñ�������ʶ���Ӳ˵�]
			subMenu = {			-- [����]
				{
					text = "�ҵĶ����˵�",
					level = 2,				-- [����]
					func = function()
						message("����Ҳ�ǲ˵���");
					end
				},
				{
					text = "�ҿ���ѡ��ɫŶ",
					level = 2,				-- [����]
					hasColorSwatch = 1, -- ������
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
