﻿
local L = BLocal("ModConfig")
local masque_t;

if GetLocale()=='zhCN' then
	L["ResetWindow-tooltip"] ="右击重置窗体位置"
	L["Recount"] = "伤害统计"
	L["Skada"] = "战斗统计"
	L["Details"] = "战斗统计"
	L["DBM"] = "首领报警"
	L["Grid"] = "团队框架"
	L["GDKP"] = "金团助手"
	L["Omen"] = "仇恨统计"
	L["Trinkets"] = "饰品管理"
	L["WorldQuestTracker"] = "世界任务"
	L["Search"] = "搜索..."
	L["EnableMove"] ="窗体锁定"
	L["EnableMoveTip"] ="锁定大脚功能界面"
	L["OldTab"] ="旧版Tab"
	L["MeetingStone"]="集合石"
	L["Masque"] ="动作条美化"
	L["Auctionator"] ="拍卖大师"
	L["aux-addon"] ="AUX拍卖"
	L["MonkeyQuestList"] ="任务列表"
	L["MonkeyQuestList-tooltip"] ="右击重置任务列表位置"
	L["aux-addon-enabled"] ="AUX拍卖插件打开后，可点击拍卖行界面上的“暴雪UI”进入原版拍卖行界面。"
	L["ActionNeedReloadUI"] ="该设置将在下次插件载入时生效。"
	L["ClassicThreatMeter"] ="仇恨统计"
	L["MessageClassifier"] ="消息去重"
	L["MessageClassifier-tooltip"] ="不显示公共频道/世界频道中重复的消息\n右击重置过滤器(允许重复消息再次显示)"
	L["Personal Resource Display"] ="个人资源"
	L["Spy"] = "Spy侦测"
	L["AutoInvite"] = "密我进组"
	L["AutoInvite-tooltip"] ="其他人密我即可自动邀请他们进组，左键启用，右键设置密我的内容。"
	L["AutoInvite-message"] = "密我的内容(留空接受任意内容)"
	L["NovaWorldBuffs"] = "世界Buff"
	L["NovaWorldBuffs-tooltip"] ="勾选启用，右击打开世界Buff信息面板。"

	masque_t = {"          默 认          ","     大脚中国风     ","       粗 边 框        ","       无 边 框        ","     无边框放大     ","          雅 黑          ","     圆形白边框     ","       凯 蒂 猫        ","          自 定 义      "}

elseif GetLocale()=='zhTW' then
	L["ResetWindow-tooltip"] ="右擊重置窗體位置"
	L["Recount"] = "傷害統計"
	L["Skada"] = "戰鬥統計"
	L["Details"] = "戰鬥統計"
	L["DBM"] = "首領報警"
	L["Grid"] = "團隊框架"
	L["GDKP"] = "金團助手"
	L["Omen"] = "仇恨統計"
	L["Trinkets"] = "飾品管理"
	L["WorldQuestTracker"] = "世界任務"
	L["Search"] = "搜索..."
	L["EnableMove"]="窗體鎖定"
	L["EnableMoveTip"] ="鎖定大腳功能介面"
	L["OldTab"] ="舊版Tab"
	L["MeetingStone"]="集合石"
	L["Masque"] ="動作條美化"
	L["Auctionator"] ="拍賣大師"
	L["aux-addon"] ="AUX拍賣"
	L["MonkeyQuestList"] ="任務列表"
	L["MonkeyQuestList-tooltip"] ="右擊重置任務列表位置"
	L["aux-addon-enabled"] ="AUX拍賣插件已打開，點擊拍賣行界面上的“暴雪UI”進入原版拍賣行界面。"
	L["ActionNeedReloadUI"] ="該設置將在下次外掛程式載入時生效。"
	L["ClassicThreatMeter"] ="仇恨統計"
	L["MessageClassifier"] ="消息去重"
	L["MessageClassifier-tooltip"] ="不顯示公共頻道/世界頻道中重複的消息\n右擊重置過濾器(允許重復消息再次顯示)"
	L["Personal Resource Display"] ="個人資源"
	L["Spy"] = "Spy偵測"
	L["AutoInvite"] = "密我進組"
	L["AutoInvite-tooltip"] ="其他人密我即可自動邀請他們進組，左鍵啟用，右鍵設置密我的內容。"
	L["AutoInvite-message"] = "密我的內容(留空接受任意內容)"
	L["NovaWorldBuffs"] = "世界Buff"
	L["NovaWorldBuffs-tooltip"] ="勾選啟用，右擊打開世界Buff信息面板。"

	masque_t = {"          默 認          ","     大腳中國風     ","       粗 邊 框        ","       無 邊 框        ","     無邊框放大     ","          雅 黑          ","     圓形白邊框     ","       凱 蒂 貓        ","          自 定 義      "}

else

	L["ResetWindow-tooltip"] ="Right click to reset the window position"
	L["Details"] = "Details"
	L["Auctionator"] ="Auctionator"
	L["aux-addon"] ="AUX Addon"
	L["MonkeyQuestList"] ="Quest List"
	L["MonkeyQuestList-tooltip"] ="Right click to reset list's position"
	L["aux-addon-enabled"] ="The AUX Addon has been enabled, click on the \"Blizzard UI\" on the AUX auction UI to enter the original auction UI."
	L["ActionNeedReloadUI"] ="This setting will be available next time."
	L["ClassicThreatMeter"] ="ThreatMeter"
	L["MessageClassifier"] ="MsgDeDup"
	L["MessageClassifier-tooltip"] ="Do not display duplicate messages in public channel/world channels.\n\nRight click to reset the filter (allow duplicate messages to be displayed again)."
	L["Personal Resource Display"] ="PersonalRes"
	L["Spy"] = "Spy"
	L["AutoInvite"] = "AutoInvite"
	L["AutoInvite-tooltip"] = "Others can be automatically invited to join my team if them whisper to me.\n\nLeft-click to enable, right-click to set the whisper keyword."
	L["AutoInvite-message"] = "Whisper Keyword (Empty to accept any content)"
	L ["NovaWorldBuffs"] = "WorldBuffs"
	L ["NovaWorldBuffs-tooltip"] = "Check to enable NovaWorldBuffs, right-click to open the world buff information panel."

end

local M = LibStub("AceAddon-3.0"):GetAddon("MBB")

local nextCheckIndex = 1
local masque_set = {"Blizzard","ChineseStyle","Caith","Dream","Zoomed","Darion","Serenity","HelloKitty","FreeStyle"}

local Masque,group;

local function masque_Mod_Change(arg)
	if arg and IsConfigurableAddOn("Masque") then
		if not Masque then
			Masque = LibStub("Masque", true)
		end
		if not group then
			group = Masque:Group('默认动作条按钮')
		end
		group:SetOption("SkinID",masque_set[arg])
	end
end

local function MBB_SpinBoxPreButton_OnClick(self)
	local __element = self:GetParent();
	local __text = getglobal(__element:GetName().."Value");
	local __value = __text:GetText();
	if (__element.list) then
		local __count = table.maxn(__element.list);
		for __i = 1, __count-1, 1 do
			if (__value == __element.list[__i]) then
				if (__i - 1 < 1) then
					__text:SetText(__element.list[__count-1]);
					__element.callback(__count-1);
					return;
				else
					__text:SetText(__element.list[__i - 1]);
					__element.callback(__i - 1);
					return;
				end
			end
		end

		__text:SetText(__element.list[1]);
		__element.callback(1);
	end
end

local function MBB_SpinBoxNextButton_OnClick(self)
	local __element = self:GetParent();
	local __text = getglobal(__element:GetName().."Value");
	local __value = __text:GetText();
	if (__element.list) then
		local __count = table.maxn(__element.list);
		for __i = 1, __count-1, 1 do
			if (__value == __element.list[__i]) then
				if (__i + 1 > __count-1) then
					__text:SetText(__element.list[1]);
					__element.callback(1);
					return;
				else
					__text:SetText(__element.list[__i + 1]);
					__element.callback(__i + 1);
					return;
				end
			end
		end

		__text:SetText(__element.list[1]);
		__element.callback(1);
	end
end

local function __CreateSpinBox(text, modName, variableName, text_tip, AddOnName, tableData, defaultValue,callbackFuc)
	local check = CreateFrame("CheckButton","MBBBottomPanel"..nextCheckIndex,UIParent,"OptionsSmallCheckButtonTemplate")
	check:SetFrameLevel(8)
	check:SetHeight(20)
	check:SetWidth(20)
	check:SetHitRectInsets(0, -60, 0,0)
	_G[check:GetName().."Text"]:SetFontObject("NumberFont_Shadow_Med");
	_G[check:GetName().."Text"]:SetTextHeight(12)
	_G[check:GetName().."Text"]:SetText(text)
	check:SetScript("OnShow",function()
		if BFNew_GetNewFrameState and BFNew_GetNewFrameState() then
			check:SetChecked(BFNew_GetCurrentConfig(AddOnName) == 1 and true or false)
		else
			check:SetChecked(BigFoot_GetModVariable(modName,variableName) == 1 and true or false)
		end
		if check:GetChecked() then
			check.__prev_button:Show()
			check.__value:Show()
			check.__next_button:Show()
			if not Masque then
				Masque = LibStub("Masque", true)
				if not group then
					group = Masque:Group('默认动作条按钮')
				end
				local groupId = group.db.SkinID;
				if groupId then
					for i,v in pairs(masque_set) do
						if v == groupId then
							check.__value:SetText(masque_t[i])
							return;
						end
					end
				end
			end
			check.__value:SetText(masque_t[#masque_t])
		else
			check.__prev_button:Hide()
			check.__value:Hide()
			check.__next_button:Hide()
		end
	end)
	check:SetScript("OnClick",function(self)
		local __checked = self:GetChecked();
		if __checked then
			self.__prev_button:Show()
			self.__value:Show()
			self.__next_button:Show()
		else
			self.__prev_button:Hide()
			self.__value:Hide()
			self.__next_button:Hide()
		end
		if BFNew_GetNewFrameState and BFNew_GetNewFrameState() then
			if __checked then
				__checked= true
			else
				__checked= false
			end
			BFNew_SetCurrentConfig(AddOnName,__checked)
		else
			__checked = __checked and 1 or 0;
			BigFoot_SetModVariable(modName, variableName, __checked);
			local _,choice = ModManagement_GetDefaultValue(modName,variableName)
			local callback = choice and choice.callback
			callback(__checked)
			if (choice.adText) and __checked~=0 then
				print(string.format(MOD_MANAGEMENT_AD_TEXT,choice.adText))
			end
		end
	end)
	if text_tip then
		check:SetScript("OnEnter",function(self)
			BFMBB_Tooltip:SetOwner(self)
			BFMBB_Tooltip:AddLine(text_tip,NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
			local x,y = BFMBB_Tooltip:GetSize();
			BFMBB_Tooltip:SetAnchorType("ANCHOR_LEFT",x,0)
			BFMBB_Tooltip:SetScale(0.7)
			BFMBB_Tooltip:Show()
		end)
		check:SetScript("OnLeave",function()
			BFMBB_Tooltip:Hide()
		end)
	end
	nextCheckIndex = nextCheckIndex + 1

	local box_Name = check:GetName()
	check.list = tableData;
	if type(callbackFuc) == "function" then
		check.callback = callbackFuc;
	end
	local __prev_button = CreateFrame("Button", box_Name.."PrevButton", check);
	__prev_button:SetWidth(20);
	__prev_button:SetHeight(20);
	__prev_button:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up");
	__prev_button:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down");
	__prev_button:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled");
	__prev_button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight");
	__prev_button:SetPoint("LEFT", _G[check:GetName().."Text"], "RIGHT", 0, 0);
	__prev_button:RegisterForClicks("LeftButtonUp" ,"RightButtonUp");
	__prev_button:SetScript("OnClick", MBB_SpinBoxPreButton_OnClick);
	check.__prev_button = __prev_button;

	local __value = check:CreateFontString(box_Name.."Value","OVERLAY");
	__value:SetFont(MOD_MANAGEMENT_FONT, 14);
	__value:SetTextColor(1.0, 0.82, 0);
	__value:ClearAllPoints();
	__value:SetPoint("LEFT", __prev_button, "RIGHT", 0, 0);
	__value:SetHeight(24);
	__value:SetJustifyH("CENTER");
	__value:SetJustifyV("CENTER");
	__value:SetNonSpaceWrap(true);
	__value:SetText(defaultValue)
	check.__value = __value

	local __next_button = CreateFrame("Button", box_Name.."NextButton", check);
	__next_button:SetWidth(20);
	__next_button:SetHeight(20);
	__next_button:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up");
	__next_button:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down");
	__next_button:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled");
	__next_button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight");
	__next_button:SetPoint("LEFT", __value, "RIGHT", 0, 0);
	__next_button:RegisterForClicks("LeftButtonUp" ,"RightButtonUp");
	__next_button:SetScript("OnClick", MBB_SpinBoxNextButton_OnClick);
	check.__next_button =__next_button

	return check
end

local function __CreateCheckBox(text,modName,variableName,text_tip,AddOnName)
	local check = CreateFrame("CheckButton","MBBBottomPanel"..nextCheckIndex,UIParent,"OptionsSmallCheckButtonTemplate")
	check:SetFrameLevel(8)
	check:SetHeight(20)
	check:SetWidth(20)
	check:SetHitRectInsets(0, -60, 0,0)
	_G[check:GetName().."Text"]:SetFontObject("NumberFont_Shadow_Med");
	_G[check:GetName().."Text"]:SetTextHeight(12)
	_G[check:GetName().."Text"]:SetText(text)
	check:SetScript("OnShow",function()
		if BFNew_GetNewFrameState and BFNew_GetNewFrameState() then
			check:SetChecked(BFNew_GetCurrentConfig(AddOnName) == 1 and true or false)
		else
			check:SetChecked(BigFoot_GetModVariable(modName,variableName) == 1 and true or false)
		end
	end)
	check:SetScript("OnClick",function()
		local __checked = check:GetChecked() and 1 or 0;
		if BFNew_GetNewFrameState and BFNew_GetNewFrameState() then
			if __checked == 1 then
				__checked= true
			else
				__checked= false
			end
			BFNew_SetCurrentConfig(AddOnName,__checked)
		else
			BigFoot_SetModVariable(modName, variableName, __checked);
			local _,choice = ModManagement_GetDefaultValue(modName,variableName)
			local callback = choice and choice.callback
			callback(__checked)
			if (choice.adText) and __checked~=0 then
				print(string.format(MOD_MANAGEMENT_AD_TEXT,choice.adText))
			end
		end
	end)
	if text_tip then
		check:SetScript("OnEnter",function(self)
			BFMBB_Tooltip:SetOwner(self)
			BFMBB_Tooltip:AddLine(text_tip,NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
			local x,y = BFMBB_Tooltip:GetSize();
			BFMBB_Tooltip:SetAnchorType("ANCHOR_LEFT",x,0)
			BFMBB_Tooltip:SetScale(0.7)
			BFMBB_Tooltip:Show()
		end)
		check:SetScript("OnLeave",function()
			BFMBB_Tooltip:Hide()
		end)
	end
	nextCheckIndex = nextCheckIndex + 1
	return check
end

local function __CreateEnableMoveCheckBox()
	local check = CreateFrame("CheckButton","MBBBottomPanel"..nextCheckIndex,UIParent,"OptionsSmallCheckButtonTemplate")
	check:SetFrameLevel(8)
	check:SetHeight(20)
	check:SetWidth(20)
	check:SetHitRectInsets(0, -60, 0,0)
	_G[check:GetName().."Text"]:SetFontObject("NumberFont_Shadow_Med");
	_G[check:GetName().."Text"]:SetTextHeight(12)
	_G[check:GetName().."Text"]:SetText(L["EnableMove"])
	check:SetScript("OnShow",function()
		check:SetChecked(not BigFoot_BCanMoveFrame())
	end)
	check:SetScript("OnClick",function()
		local __checked = check:GetChecked() and 1 or 0;
		if __checked==1 then
			BigFoot_CanMoveFrame(false)
		else
			BigFoot_CanMoveFrame(true)
		end
	end)
	check:SetScript("OnEnter",function(self)
		BFMBB_Tooltip:SetOwner(self)
		BFMBB_Tooltip:AddLine(L["EnableMoveTip"],NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b,1)
		local x,y = BFMBB_Tooltip:GetSize();
		BFMBB_Tooltip:SetAnchorType("ANCHOR_LEFT",x,0)
		BFMBB_Tooltip:SetScale(0.7)
		BFMBB_Tooltip:Show()
	end)
	check:SetScript("OnLeave",function()
		BFMBB_Tooltip:Hide()
	end)
	nextCheckIndex = nextCheckIndex + 1
	return check
end

local function __CreateOldTabCheckBox()
	local check = CreateFrame("CheckButton","MBBBottomPanel"..nextCheckIndex,UIParent,"OptionsSmallCheckButtonTemplate")
	check:SetFrameLevel(8)
	check:SetHeight(20)
	check:SetWidth(20)
	check:SetHitRectInsets(0, -60, 0,0)
	_G[check:GetName().."Text"]:SetFontObject("NumberFont_Shadow_Med");
	_G[check:GetName().."Text"]:SetTextHeight(12)
	_G[check:GetName().."Text"]:SetText(L["OldTab"])
	check:SetScript("OnShow",function()
		check:SetChecked(BigFoot_GetModVariable("BigFootGadget", "OldTab") == 1)
	end)
	check:SetScript("OnClick",function()
		if check:GetChecked() then
			SetCVar("targetnearestuseold", 0)
			BigFoot_SetModVariable("BigFootGadget", "OldTab", 1);
		else
			SetCVar("targetnearestuseold", 1)
			BigFoot_SetModVariable("BigFootGadget", "OldTab", 0);
		end
		ModManagement_Refresh();
	end)
	nextCheckIndex = nextCheckIndex + 1
	return check
end

local function __CreateEnableAddonCheckBox(addonName, enabledTip, enableByDefault, enableWithoutReload)
	local check = CreateFrame("CheckButton","MBBBottomPanel"..nextCheckIndex,UIParent,"OptionsSmallCheckButtonTemplate")
	check:SetFrameLevel(8)
	check:SetHeight(20)
	check:SetWidth(20)
	check:SetHitRectInsets(0, -60, 0,0)
	_G[check:GetName().."Text"]:SetFontObject("NumberFont_Shadow_Med");
	_G[check:GetName().."Text"]:SetTextHeight(12)
	_G[check:GetName().."Text"]:SetText(L[addonName])
	check:SetScript("OnShow",function()
		check:SetChecked(BigFoot_GetModVariable("SingleAddons", addonName) == 1)
	end) 
	check:SetScript("OnClick",function()
		BigFoot_SetModVariable("SingleAddons", addonName, check:GetChecked() and 1 or 0);
		if check:GetChecked() and enableWithoutReload then
			if not BigFoot_IsAddOnLoaded(addonName) then
				BigFoot_LoadAddOn(addonName);
			end
			if enabledTip ~= nil then
				BigFoot_Print(enabledTip);
			end
		else
			BigFoot_RequestReloadUI(function() BigFoot_Print(L["ActionNeedReloadUI"]); end);
		end
	end)

	if enableByDefault and (BigFoot_GetModVariable("SingleAddons", addonName) == nil) then
		BigFoot_SetModVariable("SingleAddons", addonName, 1);
	end
	
	if (BigFoot_GetModVariable("SingleAddons", addonName) == 1) and (not BigFoot_IsAddOnLoaded(addonName)) then
		BigFoot_LoadAddOn(addonName);
		if enabledTip ~= nil then
			BigFoot_Print(enabledTip);
		end
	end

	nextCheckIndex = nextCheckIndex + 1
	return check
end

local function __CreateCustomCheckBox(varName, toolTip, enableByDefault, onCheck, onUncheck, onRightClick)
	local check = CreateFrame("CheckButton","MBBBottomPanel"..nextCheckIndex,UIParent,"OptionsSmallCheckButtonTemplate")
	check:SetFrameLevel(8)
	check:SetHeight(20)
	check:SetWidth(20)
	check:SetHitRectInsets(0, -60, 0,0)
	_G[check:GetName().."Text"]:SetFontObject("NumberFont_Shadow_Med");
	_G[check:GetName().."Text"]:SetTextHeight(12)
	_G[check:GetName().."Text"]:SetText(L[varName])
	check:SetScript("OnShow",function()
		if type(enableByDefault) == "function" then
			check:SetChecked(enableByDefault())
		else
			check:SetChecked(BigFoot_GetModVariable("CustomCheckBox", varName) == 1)
		end
	end)

	if onRightClick ~= nil then
		check:SetScript("OnMouseUp",function(self, button)
			if button == "RightButton" then
				onRightClick()
				return
			end
		end)
	end

	if toolTip ~= nil then
		check:SetScript("OnEnter",function(self)
			BFMBB_Tooltip:SetOwner(self)
			BFMBB_Tooltip:AddLine(toolTip,NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b,1)
			local x,y = BFMBB_Tooltip:GetSize();
			BFMBB_Tooltip:SetAnchorType("ANCHOR_LEFT",x,0)
			BFMBB_Tooltip:SetScale(0.7)
			BFMBB_Tooltip:Show()
		end)
		check:SetScript("OnLeave",function()
			BFMBB_Tooltip:Hide()
		end)
	end

	check:SetScript("OnClick",function(self, button, donw)
		if type(enableByDefault) ~= "function" then
			BigFoot_SetModVariable("CustomCheckBox", varName, check:GetChecked() and 1 or 0);
		end
		
		if check:GetChecked() then
			onCheck()
		else
			onUncheck()
		end
	end)

	if type(enableByDefault) ~= "function" then
		if enableByDefault and (BigFoot_GetModVariable("CustomCheckBox", varName) == nil) then
			BigFoot_SetModVariable("CustomCheckBox", varName, 1);
		end
		
		if (BigFoot_GetModVariable("CustomCheckBox", varName) == 1) then
			onCheck()
		else
			onUncheck()
		end
	end

	nextCheckIndex = nextCheckIndex + 1
	return check
end

local function __CreateNativeAddOnCheckBox(addonName, tooltip, onRightClick)
	local _, _, _, active, status = GetAddOnInfo(addonName)
	if status ~= 'MISSING' then
		BigFoot_SetModVariable("CustomCheckBox", addonName, IsAddOnLoaded(addonName) and 1 or 0)
		check = __CreateCustomCheckBox(addonName, tooltip, active,
			function()
				if not IsAddOnLoaded(addonName) then
					EnableAddOn(addonName)
					BigFoot_RequestReloadUI()
				end
			end,
			function()
				if IsAddOnLoaded(addonName) then
					DisableAddOn(addonName)
					BigFoot_RequestReloadUI()
				end
			end,
			onRightClick)
		M:AddBottomButton(check)
	end
end

local function __CreateBigFootButtons()
	local bfButton = BLibrary("BFButton", M.panel, 80, 28);
	local logButton = BLibrary("BFButton", M.panel, 80, 28);
	local search = BLibrary("BFSearch", M.panel, 110, 27,L["Search"]);

	bfButton.OnClick = function(bn)
		if BFNew_GetNewFrameState and BFNew_GetNewFrameState()  then
			if not BigfootNewMainFrame:IsShown() then
				ShowUIPanel(BigfootNewMainFrame);
			else
				HideUIPanel(BigfootNewMainFrame);
			end
		else
			if not ModManagementFrame:IsShown() then
				ShowUIPanel(ModManagementFrame);
			else
				HideUIPanel(ModManagementFrame);
			end
		end
	end

	logButton.OnClick = function(bn)
		if (not BigFootReaderFrame:IsVisible()) then
			BigFootReader_ShowBook(BF_CHANGELOG_TEXT);
		else
			HideUIPanel(BigFootReaderFrame);
		end

	end

	search.onEmpty = function() end
	search.callback = function(text)
		if BFNew_GetNewFrameState and BFNew_GetNewFrameState()  then
			search.peek = MbbSearchNewFrame
			ShowUIPanel(BigfootNewMainFrame);
			BF_SearchBox:SetText(text)
		else
			search.peek = ModManageMentFrame_SearchPeek
			ShowUIPanel(ModManagementFrame);
			ModManagementFrame_SearchMod(text)
			ModManagementFrame_SearchEntries(text)
			ModManagementFrameSearchFrameEditBox:SetText(text)
			ModManagementFrameSearchFrameEditBox:SetFontObject("ChatFontNormal")
		end
	end

	search.validation = IsLegalSearchText
	bfButton:SetText(BF_HEADER)
	logButton:SetText(BF_CHANGELOG_TEXT)
	bfButton:Show()
	logButton:Show()
	search:Show()
	return bfButton,logButton,search
end

local function __AddBigFootButtons()
	local bfButton, logButton ,search = __CreateBigFootButtons()
	M:AddFrame(bfButton,"TOPLEFT",M.panel,"TOPLEFT",12,-13)
	M:AddFrame(logButton,"TOPLEFT",M.panel,"TOPLEFT",97,-13)
	M:AddFrame(search,"TOPRIGHT",M.panel,"TOPRIGHT",-13,-15)
end

local function isAddonLoadable(addonName)
	_, _, _, _, loadable, _, _ = GetAddOnInfo(addonName)
	return loadable == 'DEMAND_LOADED'
end

local function __AddBottomFrames()
	local check;

	__CreateNativeAddOnCheckBox('Recount', L["ResetWindow-tooltip"], function()
		if SlashCmdList.ACECONSOLE_RECOUNT then
			SlashCmdList.ACECONSOLE_RECOUNT('show')
			SlashCmdList.ACECONSOLE_RECOUNT('resetpos')
		end
	end)
	__CreateNativeAddOnCheckBox('Skada')
	__CreateNativeAddOnCheckBox('Details')

	if ThreatClassic2BarFrame ~= nil then
		local oriShow = ThreatClassic2BarFrame.Show
		ThreatClassic2BarFrame.Show = function(...)
			if BigFoot_GetModVariable("CustomCheckBox", "ClassicThreatMeter") ~= 1 then
				return false
			end
			oriShow(...)
		end
		check = __CreateCustomCheckBox("ClassicThreatMeter", nil, false,
			function() ThreatClassic2BarFrame:Show() end,
			function() ThreatClassic2BarFrame:Hide() end,
			nil)
		M:AddBottomButton(check)
	end

	if IsConfigurableAddOn("DBM-Core") then
		check = __CreateCheckBox(L["DBM"], "RaidToolkit","EnableDBM",nil,"DBM-Core")
		M:AddBottomButton(check)
	end

	if IsConfigurableAddOn("Grid") then
		check = __CreateCheckBox(L["Grid"],"RaidToolkit","EnableGrid",nil,"Grid")
		M:AddBottomButton(check)
	end

	if IsConfigurableAddOn("GDKP") then
		check = __CreateCheckBox(L["GDKP"],"MiDKP","GDKPEnable",nil,"GDKP")
		M:AddBottomButton(check)
	end

	if IsConfigurableAddOn("Omen") then
		check = __CreateCheckBox(L["Omen"],"RaidToolkit","EnableThreat",nil,"Omen")
		M:AddBottomButton(check)
	end

	if IsConfigurableAddOn("TrinketMenu") then
		check = __CreateCheckBox(L["Trinkets"],"TrinketMenu","EnableTrinketMenu",nil,"TrinketMenu")
		M:AddBottomButton(check)
	end

	if IsConfigurableAddOn("WorldQuestTracker") then
		check = __CreateCheckBox(L["WorldQuestTracker"],"QuestEnhancement","EnableWorldQuestTracker",nil,"WorldQuestTracker")
		M:AddBottomButton(check)
	end

	if BigFoot_CanMoveFrame then	--添加移动窗体解锁位置
		check = __CreateEnableMoveCheckBox()
		M:AddBottomButton(check)
	end

	if IsConfigurableAddOn("MeetingStone") then
		check = __CreateCheckBox(L["MeetingStone"],"RaidToolkit","EnableMeetingStone",nil,"MeetingStone")
		M:AddBottomButton(check)
	end

	if IsConfigurableAddOn("Masque") then
		check = __CreateSpinBox(L["Masque"],"InfoBox","EnableMasque",nil,"Masque",masque_t,masque_t[#masque_t],masque_Mod_Change)
		M:AddBottomButton2(check)
	end

	if MonkeyQuestSlash_CmdOpen ~= nil then
		check = __CreateCustomCheckBox("MonkeyQuestList", L["MonkeyQuestList-tooltip"], true,
			function() MonkeyQuestSlash_CmdOpen(true) end,
			function() MonkeyQuestSlash_CmdOpen(false) end,
			function() MonkeyQuestSlash_CmdReset() end)
		M:AddBottomButton(check)
	end

	if MessageClassifier and MessageClassifier.Enable and MessageClassifier.Disable then
		check = __CreateCustomCheckBox("MessageClassifier", L["MessageClassifier-tooltip"],
			function() return MessageClassifierConfig.enabled end,
			function() MessageClassifier.Toggle(true) end,
			function() MessageClassifier.Toggle(false) end,
			function() MessageClassifier.Reset() end)
		M:AddBottomButton(check)
	end

	__CreateNativeAddOnCheckBox('Auctionator')
	__CreateNativeAddOnCheckBox('aux-addon', L['aux-addon-enabled'])
	__CreateNativeAddOnCheckBox('Personal Resource Display')
	__CreateNativeAddOnCheckBox('Spy')

	if type(SlashCmdList.AUTOINVITE) == 'function' then
		check = __CreateCustomCheckBox("AutoInvite", L["AutoInvite-tooltip"], AutoInviteSettings.AutoInviteEnabled,
			function()
				SlashCmdList.AUTOINVITE("enable")
				print(string.format("密语自动邀请进组已启用，其他人密我%s即可自动进组", AutoInviteSettings.AutoInviteKeyword or ""))
			end,
			function()
				SlashCmdList.AUTOINVITE("disable")
				print("密语自动邀请进组已关闭")
			end,
			function()
				StaticPopupDialogs["AutoInvite_Input_Keywords"] = {
					text = L["AutoInvite-message"],
					button1 = OKAY,
					button2 = CANCEL,
					hasEditBox = 1,
					whileDead = 1,
					hideOnEscape = 1,
					timeout = 0,
					OnShow = function(self)
						self.editBox:SetText(AutoInviteSettings and AutoInviteSettings.AutoInviteKeyword or "")
					end,
					OnAccept = function(self)
						local keywords = self.editBox:GetText() or ""
						SlashCmdList.AUTOINVITE("k "..keywords)
					end
				}
				StaticPopup_Show("AutoInvite_Input_Keywords")
			end)
		M:AddBottomButton(check)
	end

	__CreateNativeAddOnCheckBox('NovaWorldBuffs', L["NovaWorldBuffs-tooltip"], function()
		if SlashCmdList.NWBCMD then
			SlashCmdList.NWBCMD()
		end
	end)

	if pcall(GetCVarDefault, "targetnearestuseold") then
	    check = __CreateOldTabCheckBox()
		M:AddBottomButton(check)
	end
end

local function __AddVolumeBar()
	local bar = _G["BFVolumeSlider"]
	bar:SetParent(M.panel)
	M.volumnBar = bar
	bar:SetPoint("TOPLEFT",M.panel,"TOPRIGHT", -29, -69)
	bar:SetPoint("BOTTOMLEFT",M.panel,"BOTTOMRIGHT", -29, 26)
	bar:Show()
	local mute = _G["BFVolumnMuteButton"]
	mute:SetParent(M.panel)
	mute:SetPoint("BOTTOMLEFT",M.panel,"BOTTOMRIGHT", -37, 5)
	mute:Show()
end

local function __OnMBBEnableFunc()
	if bigfoot_IsEnableDisssabbedAddon then
		__AddBigFootButtons()
		__AddBottomFrames()
		__AddVolumeBar()
	else
		BigFoot_DelayCall(__OnMBBEnableFunc,0.5);
	end
end

hooksecurefunc(M,"OnEnable",function(self)
	__OnMBBEnableFunc()
	-- BigFoot_RegistMoveFrame("EclipseBarFrame")
	BigFoot_RegistMoveFrame("ShardBarFrame")
	-- BigFoot_RegistMoveFrame("PaladinPowerBar")
end)
