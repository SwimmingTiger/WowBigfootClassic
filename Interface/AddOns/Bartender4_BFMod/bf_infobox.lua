
if GetLocale()=='zhCN' then
	INFOBOX_TOOLTIP_NEW_WINDOW = "创建新的窗口";
	INFOBOX_TOOLTIP_MOVE_WINDOW = "将所有窗口显示出来方便移动，\n必须为解锁状态";
	INFOBOX_TOOLTIP_LOCK_WINDOW = "锁定所有窗口，使其不能移动及显示";
	INFOBOX_TOOLTIP_UNLOCK_WINDOW = "解锁所有窗口，使其可以移动及显示";
	INFOBOX_TOOLTIP_HIDE_WINDOW = "完全隐藏窗口，包括其内容";
	INFOBOX_TOOLITP_LOAD_THEME = "载入界面方案";
	INFOBOX_TOOLTIP_SAVE_THEME = "保存界面方案";
	INFOBOX_TOOLTIP_DELETE_THEME = "删除界面方案";
	INFOBOX_TOOLTIP_RESET_THEME = "恢复所有界面方案至缺省";
	INFOBOX_HIDE_WINDOW = "隐藏窗口";

	INFOBOX_THEME_1_NAME = "传统型";
	INFOBOX_THEME_1_DESC = "本配置方案采用了简单聊天窗口模式，如果您不喜欢这种方式，请到主菜单下选择界面设置，将<简易聊天模式>一项的设置取消。";
	INFOBOX_THEME_2_NAME = "简约型";
	INFOBOX_THEME_2_DESC = "本配置方案聊天窗口进行了锁定，如果您需要移动聊天窗口，请到主菜单下选择界面设置，将<锁定聊天设置>一项的设置取消。或者通过信息盒2.0工具条的<解锁>来进行移动。";
	INFOBOX_THEME_3_NAME = "现代型";
	INFOBOX_THEME_COMBAT_NAME = "战斗记录";
	INFOBOX_THEME_GENERAL_NAME = "综合";
	MODULE_SLOT_INFO_RESTORE_THEME = "注意！当前所有配置方案将被缺省配置方案取代！你真的要这么做？";
	INFOBOX_MENU_SAVE_THEME = "存储方案"
	INFOBOX_MENU_DELETE_THEME = "刪除方案";
	INFOBOX_MENU_SELECT_THEME = "载入方案";
	INFOBOX_MENU_SAVE_NEW_THEME = "新的方案";

	MODULE_SLOT_NAME_THEME = "请输入配置方案名称";
	MODULE_SLOT_REPLACE_THEME = "配置方案《|cff00ff00%s|r》已经存在，您真的想要覆盖旧的配置方案吗？";
	MODULE_SLOT_DELETE_THEME = "配置方案《|cff00ff00%s|r》将被永久删除，你真的要删除吗？";

elseif GetLocale()=='zhTW' then
	INFOBOX_TOOLTIP_NEW_WINDOW = "創建新的窗口";
	INFOBOX_TOOLTIP_MOVE_WINDOW = "將所有窗口顯示出來方便移動，\n必須爲解鎖狀態";
	INFOBOX_TOOLTIP_LOCK_WINDOW = "鎖定所有窗口，使其不能移動及顯示";
	INFOBOX_TOOLTIP_UNLOCK_WINDOW = "解鎖所有窗口，使其可以移動及顯示";
	INFOBOX_TOOLTIP_HIDE_WINDOW = "完全隱藏窗口，包括其內容";
	INFOBOX_TOOLITP_LOAD_THEME = "載入界面方案";
	INFOBOX_TOOLTIP_SAVE_THEME = "保存界面方案";
	INFOBOX_TOOLTIP_DELETE_THEME = "刪除界面方案";
	INFOBOX_TOOLTIP_RESET_THEME = "恢複所有界面方案至缺省";

	INFOBOX_HIDE_WINDOW = "隱藏窗口";

	INFOBOX_THEME_1_NAME = "傳統型";
	INFOBOX_THEME_1_DESC = "本配置方案采用了簡單聊天窗口模式，如果您不喜歡這種方式，請到主菜單下選擇界面設置，將<簡易聊天模式>一項的設置取消。";
	INFOBOX_THEME_2_NAME = "簡約型";
	INFOBOX_THEME_2_DESC = "本配置方案聊天窗口進行了鎖定，如果您需要移動聊天窗口，請到主菜單下選擇界面設置，將<鎖定聊天設置>一項的設置取消。或者通過信息盒2.0工具條的<解鎖>來進行移動。";
	INFOBOX_THEME_3_NAME = "現代型";
	INFOBOX_THEME_COMBAT_NAME = "戰鬥記錄";
	INFOBOX_THEME_GENERAL_NAME = "綜合";
	MODULE_SLOT_INFO_RESTORE_THEME = "注意！當前所有配置方案將被缺省配置方案取代！你真的要這麽做？";
	INFOBOX_MENU_SAVE_THEME = "存儲方案"
	INFOBOX_MENU_DELETE_THEME = "刪除方案";
	INFOBOX_MENU_SAVE_NEW_THEME = "新的方案";
	INFOBOX_MENU_SELECT_THEME = "載入方案";

	MODULE_SLOT_NAME_THEME = "請輸入配置方案名稱";
	MODULE_SLOT_REPLACE_THEME = "配置方案《|cff00ff00%s|r》已經存在，您真的想要覆蓋舊的配置方案嗎？";
	MODULE_SLOT_DELETE_THEME = "配置方案《|cff00ff00%s|r》將被永久刪除，你真的要刪除嗎？";

else
	INFOBOX_TOOLTIP_NEW_WINDOW = "New Window";
	INFOBOX_TOOLTIP_MOVE_WINDOW = "Show all windows to move，\nMust be unlock status";
	INFOBOX_TOOLTIP_LOCK_WINDOW = "Lock all windows to prevent form moving";
	INFOBOX_TOOLTIP_UNLOCK_WINDOW = "Unlock all window to move";
	INFOBOX_TOOLTIP_HIDE_WINDOW = "Hide window including its content";
	INFOBOX_TOOLITP_LOAD_THEME = "Load Theme";
	INFOBOX_TOOLTIP_SAVE_THEME = "Save Theme";
	INFOBOX_TOOLTIP_DELETE_THEME = "Delete Theme";
	INFOBOX_TOOLTIP_RESET_THEME = "Reset Theme";

	INFOBOX_HIDE_WINDOW = "Hide Window";

	INFOBOX_THEME_1_NAME = "Tradition";
	INFOBOX_THEME_1_DESC = "This theme use simple chat mode. If you do not like this mehto, pleast select interfact settings in main menu and cancel item <Simple Chat Mode>.";
	INFOBOX_THEME_2_NAME = "Compat";
	INFOBOX_THEME_2_DESC = "This theme lock chat window. If you need move chat window, pleast select interface in main menu and cancel lock chat window. Or use 'Unlock' in InfoBox to move it.";
	INFOBOX_THEME_3_NAME = "Popular";
	INFOBOX_THEME_COMBAT_NAME = "Combat Log";
	INFOBOX_THEME_GENERAL_NAME = "General";
	MODULE_SLOT_INFO_RESTORE_THEME = "Caustion! All current themes will be replace with default themes! Are you sure?";
	INFOBOX_MENU_SAVE_THEME = "Save Theme"
	INFOBOX_MENU_DELETE_THEME = "Delete Theme";
	INFOBOX_MENU_SAVE_NEW_THEME = "New Theme";
	INFOBOX_MENU_SELECT_THEME = "Load Theme";
	MODULE_SLOT_NAME_THEME = "Please input the name of theme";
	MODULE_SLOT_REPLACE_THEME = "Theme '|cff00ff00%s|r' already exists, do you really want to replace old theme?";
	MODULE_SLOT_DELETE_THEME = "Theme '|cff00ff00%s|r' will be deleted, are you sure?";

end

local PresetsMod = Bartender4:GetModule("Presets")

local db

local savedProfiles ={}

local L = LibStub("AceLocale-3.0"):GetLocale("Bartender4")

local __defaultThemes = {
	BLIZZARD = L["Blizzard interface"],
	SIMPLE = L["Simple Style"],
	MODERN = L["Modern Style"]
};

local __defaultThemesUiScale = {
	BLIZZARD = 1.0,
	SIMPLE = 0.9,
	MODERN = 0.64
};

__MainUpdate_Elapse = 0;

StaticPopupDialogs["RESTORE_THEME"] = {
	text = MODULE_SLOT_INFO_RESTORE_THEME,
	button1 = YES,
	button2 = CANCEL,
	OnAccept = function(self)
		Bartender4:GetModule("Presets"):MyResetProfile("BLIZZARD")
	end,
	showAlert = 1,
	timeout = 0,
};

StaticPopupDialogs["REPLACE_THEME"] = {
	text = MODULE_SLOT_REPLACE_THEME,
	button1 = YES,
	button2 = CANCEL,
	OnAccept = function(self)
		if ( StaticPopupDialogs["REPLACE_THEME"].theme ) then
			__InfoBox_DoSaveTheme(StaticPopupDialogs["REPLACE_THEME"].theme)
			StaticPopupDialogs["REPLACE_THEME"].theme = nil;
		end
	end,
	showAlert = 1,
	timeout = 0,
};

StaticPopupDialogs["NAME_THEME"] = {
	text = MODULE_SLOT_NAME_THEME,
	button1 = ACCEPT,
	button2 = CANCEL,
	hasEditBox = 1,
	maxLetters = 31,
	whileDead = 1,
	OnAccept = function(self)
		local name = self.editBox:GetText();
		__InfoBox_DoSaveTheme(name)
		StaticPopupDialogs["REPLACE_THEME"].theme = nil;
	end,
	timeout = 0,
	EditBoxOnEnterPressed = function(self)
		local name = self:GetText();
		__InfoBox_DoSaveTheme(name)
		self:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function (self)
		self:GetParent():Hide();
	end
};

StaticPopupDialogs["DELETE_THEME"] = {
	text = MODULE_SLOT_DELETE_THEME,
	button1 = YES,
	button2 = CANCEL,
	OnAccept = function(self)
		if ( StaticPopupDialogs["DELETE_THEME"].theme ) then
			db:DeleteProfile(StaticPopupDialogs["DELETE_THEME"].theme,true)
			StaticPopupDialogs["DELETE_THEME"].theme = nil;
		end
	end,
	showAlert = 1,
	timeout = 0,
};

local function CanDisplayProfile(name)
	return name~=db:GetCurrentProfile() and not name:find(" - ")
end

local function __AddStaticDDItem(text)
	local __info = {};
	__info.text = text;
	__info.isTitle = 1;
	__info.notCheckable = 1;
	BDropDownMenu_AddButton(__info);
end

function __InfoBox_DoSaveTheme(name)
	db:SetProfile(name)
	db:CopyProfile("bf_infobox")
	db:SetProfile("bf_infobox")
end

function InfoBox_OnLoad()
	hooksecurefunc(Bartender4,"Unlock",function()
		InfoBoxButtonLockWindow:Show();
		InfoBoxButtonUnlockWindow:Hide()
	end)
	hooksecurefunc(Bartender4,"Lock",function()
		InfoBoxButtonLockWindow:Hide();
		InfoBoxButtonUnlockWindow:Show()
	end)

	hooksecurefunc(BT4_UnitFrames,"OnInitialize",function()
		db = Bartender4.db
		db:SetProfile("bf_infobox")
	end)
end

function InfoBox_MainUpdate(self, elapsed)
	__MainUpdate_Elapse = __MainUpdate_Elapse + elapsed;

	if (__MainUpdate_Elapse > 0.1) then
		-- Handle hiding and showing chat tabs
		local xPos, yPos = GetCursorPosition();

		if ( yPos > 764) and (MouseIsOver(InfoBoxToolBar, 0, 0, 0, 0) and not InfoBoxToolBar:IsVisible() and not InCombatLockdown() ) then
			PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN);
			InfoBoxToolBar:Show();
		elseif ( yPos < 600 and InfoBoxToolBar:IsVisible() ) then
			InfoBoxToolBar:Hide();
		elseif (InCombatLockdown() and InfoBoxToolBar:IsVisible()) then
			InfoBoxToolBar:Hide();
		end
		if (__MainUpdate_Elapse > 1) then
			__MainUpdate_Elapse = 0;
		end
	end
end

function InfoBoxButton_OnEnter(self)
	local __name = self:GetName();
	local __tooltip;

	if (__name == "InfoBoxButtonNewWindow") then
		__tooltip = INFOBOX_TOOLTIP_NEW_WINDOW;
	elseif ( __name == "InfoBoxButtonMoveWindow" ) then
		__tooltip = INFOBOX_TOOLTIP_MOVE_WINDOW;
	elseif ( __name == "InfoBoxButtonUnlockWindow" ) then
		__tooltip = INFOBOX_TOOLTIP_UNLOCK_WINDOW;
	elseif ( __name == "InfoBoxButtonLockWindow" ) then
		__tooltip = INFOBOX_TOOLTIP_LOCK_WINDOW;
	elseif ( __name == "InfoBoxButtonHideWindow" ) then
		__tooltip = INFOBOX_TOOLTIP_HIDE_WINDOW;
	elseif ( __name == "InfoBoxButtonLoadTheme" ) then
		__tooltip = INFOBOX_TOOLITP_LOAD_THEME;
	elseif ( __name == "InfoBoxButtonSaveTheme" ) then
		__tooltip = INFOBOX_TOOLTIP_SAVE_THEME;
	elseif ( __name == "InfoBoxButtonDeleteTheme" ) then
		__tooltip = INFOBOX_TOOLTIP_DELETE_THEME;
	elseif ( __name == "InfoBoxButtonResetTheme" ) then
		__tooltip = INFOBOX_TOOLTIP_RESET_THEME;
	end

	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT");
	GameTooltip:SetText(__tooltip);
	GameTooltip:Show();
end

function InfoBoxButton_OnLeave(self)
	GameTooltip:Hide();
end

function InfoBoxButton_OnClick(self, button)
	PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);

	if ( button == "LeftButton" ) then
		if ( self:GetName() == "InfoBoxButtonUnlockWindow" ) then
			if Bartender4.Locked then
				Bartender4["Unlock"](Bartender4)
			end
		elseif ( self:GetName() == "InfoBoxButtonLockWindow" ) then
			if not Bartender4.Locked then
				Bartender4["Lock"](Bartender4)
			end

		elseif ( self:GetName() == "InfoBoxButtonResetTheme" ) then
			__ModuleSlot_CommandRestoreTheme();
		else
			BToggleDropDownMenu(1, nil, getglobal(self:GetName().."DropDown"), self:GetName(), 0, -5);
		end
		return;
	end

	BCloseDropDownMenus();
end

function __ModuleSlot_CommandRestoreTheme(self)
	StaticPopup_Show("RESTORE_THEME");
end

function __ModuleSlot_CommandSaveTheme(self)
	if ( not self.value ) then
		return;
	end

	if ( self.value ~= "" ) then
		-- 如果指定的是已经存在的配置方案，弹出“替换”的确认对话框
		StaticPopupDialogs["REPLACE_THEME"].theme = self.value;
		StaticPopup_Show("REPLACE_THEME", self.value);
	else
		-- 如果弹出的是新的配置方案，弹出“输入名称”的对话框
		StaticPopup_Show("NAME_THEME");
	end
	BCloseDropDownMenus();
end

function __ModuleSlot_CommandDeleteTheme(self)
	if ( self.value ) then
		StaticPopupDialogs["DELETE_THEME"].theme = self.value;
		StaticPopup_Show("DELETE_THEME", self.value);
	end
	BCloseDropDownMenus();
end

function __ModuleSlot_CommandSelectDefaultTheme(self)
	PresetsMod:MyResetProfile(self.value)
end

function __ModuleSlot_CommandLoadTheme(self)
	db:CopyProfile(self.value,true)
end

function InfoBoxButtonMenu_LoadTheme()
	local __info;
	__AddStaticDDItem(INFOBOX_MENU_SELECT_THEME);


	local __index, __value;
	for __index, __value in pairs(__defaultThemes) do
		__info = {};
		__info.text = __value;
		__info.value = __index;
		__info.func = __ModuleSlot_CommandSelectDefaultTheme;
		__info.notCheckable = 1;
		BDropDownMenu_AddButton(__info);
	end
	if db then
		db:GetProfiles(savedProfiles)
	end
	for k,v in pairs(savedProfiles) do
		-- can not delete current profile
		if CanDisplayProfile(v) then
			__info = {};
			__info.text = v;
			__info.value = v;
			__info.func = __ModuleSlot_CommandLoadTheme;
			__info.notCheckable = 1;
			BDropDownMenu_AddButton(__info);
		end
	end
end

function InfoBoxButtonMenu_SaveTheme()
	local __info;

	__AddStaticDDItem(INFOBOX_MENU_SAVE_THEME);

	__info = {};
	__info.text = INFOBOX_MENU_SAVE_NEW_THEME;
	__info.textR = 255;
	__info.textG = 1;
	__info.textB = 255;
	__info.value = "";
	__info.notCheckable = 1;
	__info.func = __ModuleSlot_CommandSaveTheme;
	BDropDownMenu_AddButton(__info);
	if db then
		db:GetProfiles(savedProfiles)
	end
	for k,v in pairs(savedProfiles) do
		if CanDisplayProfile(v) then
			__info = {};
			__info.text = v;
			__info.value = v;
			__info.func = __ModuleSlot_CommandSaveTheme;
			__info.notCheckable = 1;
			BDropDownMenu_AddButton(__info);
		end
	end
end

function InfoBoxButtonMenu_DeleteTheme()
	local __info;

	__AddStaticDDItem(INFOBOX_MENU_DELETE_THEME);
	if db then
		db:GetProfiles(savedProfiles)
	end
	for k,v in pairs(savedProfiles) do
	-- can not delete current profile
		if CanDisplayProfile(v) then
			__info = {};
			__info.text = v;
			__info.value = v;
			__info.func = __ModuleSlot_CommandDeleteTheme;
			__info.notCheckable = 1;
			BDropDownMenu_AddButton(__info);
		end
	end
end

function InfoBoxButtonDropDown_OnLoad(self)
	BDropDownMenu_Initialize(self, __InfoBoxButtonDropDown_Initialize, "MENU");
	BDropDownMenu_SetButtonWidth(self, 50);
	BDropDownMenu_SetWidth(self, 50);
end

function __InfoBoxButtonDropDown_GetButtonID()
	return BDropDownMenu_GetCurrentDropDown():GetParent():GetName();
end

function __InfoBoxButtonDropDown_Initialize()
	local __name = __InfoBoxButtonDropDown_GetButtonID();
	if ( __name == "InfoBoxButtonNewWindow" ) then
--		InfoBoxButtonMenu_CreateNewWindow();
	elseif ( __name == "InfoBoxButtonMoveWindow" ) then

	elseif ( __name == "InfoBoxButtonLockWindow" ) then

	elseif ( __name == "InfoBoxButtonHideWindow" ) then
--		InfoBoxButtonMenu_HideWindow();
	elseif ( __name == "InfoBoxButtonLoadTheme" ) then
		InfoBoxButtonMenu_LoadTheme();
	elseif ( __name == "InfoBoxButtonSaveTheme" ) then
		InfoBoxButtonMenu_SaveTheme();
	elseif ( __name == "InfoBoxButtonDeleteTheme" ) then
		InfoBoxButtonMenu_DeleteTheme();
	end
end
