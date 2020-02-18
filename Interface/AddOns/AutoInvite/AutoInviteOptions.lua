local addonName, addonTable = ...
AutoInvite = addonTable

AutoInvite.optionsFrame = CreateFrame("Frame", addonName .. "Config", InterfaceOptionsFramePanelContainer)
AutoInvite.optionsFrame.name = "密语自动邀请进组" --addonName
InterfaceOptions_AddCategory(AutoInvite.optionsFrame)

-- Start Title Section

AutoInvite.title = AutoInvite.optionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
AutoInvite.title:SetPoint("TOP", 0, -16)
AutoInvite.title:SetText(addonName)

--End Title Section

-- Start Enable/Disable CheckButton Section

AutoInvite.optionsEnable = CreateFrame("CheckButton", nil, AutoInvite.optionsFrame, "ChatConfigCheckButtonTemplate")
AutoInvite.optionsEnable:SetPoint("TOPLEFT", 16, -32);
AutoInvite.optionsEnable:SetText("启用/停用自动邀请")
AutoInvite.optionsEnable.tooltip = "启用/停用"
AutoInvite.optionsEnable:SetScript("OnClick", 
	function()
		AutoInvite:SetEnableDisable(AutoInvite.optionsEnable:GetChecked())
	end
);

AutoInvite.optionsEnableLabel= AutoInvite.optionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
AutoInvite.optionsEnableLabel:SetPoint("TOPLEFT", 42, -38)
AutoInvite.optionsEnableLabel:SetText("启用自动邀请")

function AutoInvite:SetEnableDisable(enabled)
	AutoInviteSettings.AutoInviteEnabled = enabled
	AutoInvite.optionsEnable:SetChecked(enabled)
end

-- End Enable/Disable CheckButton Section

-- Start Invite Keyword Section

AutoInvite.optionsInviteKeywordLabel = AutoInvite.optionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
AutoInvite.optionsInviteKeywordLabel:SetPoint("TOPLEFT", 20, -64)
AutoInvite.optionsInviteKeywordLabel:SetText("邀请关键词")

AutoInvite.optionsInviteKeyword = CreateFrame("EditBox", nil, AutoInvite.optionsFrame, "InputBoxTemplate")
AutoInvite.optionsInviteKeyword:SetAutoFocus(false)
AutoInvite.optionsInviteKeyword:SetWidth(250)
AutoInvite.optionsInviteKeyword:SetHeight(20)
AutoInvite.optionsInviteKeyword:SetPoint("TOPLEFT", 20, -80)
AutoInvite.optionsInviteKeyword:SetScript("OnTextChanged", 
	function()
		local keyword = AutoInvite.optionsInviteKeyword:GetText():gsub("^%s*(.-)%s*$", "%1")
		AutoInvite:SetInviteKeyword(keyword, AutoInvite.optionsInviteKeyword:GetCursorPosition())
	end
);

function AutoInvite:SetInviteKeyword(inviteKeyword, cursorPosition)
	AutoInviteSettings.AutoInviteKeyword = inviteKeyword:gsub("^%s*(.-)%s*$", "%1")
	AutoInvite.optionsInviteKeyword:SetText(inviteKeyword)
	AutoInvite.optionsInviteKeyword:SetCursorPosition(cursorPosition)
end

-- End Invite Keyword Section

-- Start Channel Section

AutoInvite.optionsInviteChannelLabel = AutoInvite.optionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
AutoInvite.optionsInviteChannelLabel:SetPoint("TOPLEFT", 20, -106)
AutoInvite.optionsInviteChannelLabel:SetText("可选，设置使用“/autoinvite b”命令把邀请关键词发送到的频道，\n可设为 'SAY', 'YELL', 'PARTY', 'GUILD', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'")

AutoInvite.optionsInviteChannel = CreateFrame("EditBox", nil, AutoInvite.optionsFrame, "InputBoxTemplate")
AutoInvite.optionsInviteChannel:SetAutoFocus(false)
AutoInvite.optionsInviteChannel:SetWidth(250)
AutoInvite.optionsInviteChannel:SetHeight(20)
AutoInvite.optionsInviteChannel:SetPoint("TOPLEFT", 20, -142)
AutoInvite.optionsInviteChannel:SetScript("OnTextChanged", 
	function()
		local keyword = AutoInvite.optionsInviteChannel:GetText():gsub("^%s*(.-)%s*$", "%1")
		AutoInvite:SetInviteChannel(keyword, AutoInvite.optionsInviteChannel:GetCursorPosition())
	end
);

function AutoInvite:SetInviteChannel(inviteChannel, cursorPosition)
	AutoInviteSettings.AutoInviteChannel = inviteChannel:gsub("^%s*(.-)%s*$", "%1")
	AutoInvite.optionsInviteChannel:SetText(inviteChannel)
	AutoInvite.optionsInviteChannel:SetCursorPosition(cursorPosition)
end

-- End Channel Section