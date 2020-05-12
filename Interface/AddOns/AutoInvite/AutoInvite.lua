local addonName, addonTable = ...
AutoInvite = addonTable

AutoInvite.autoInviteFrame = CreateFrame("Frame", "AutoInvite", UIParent)
AutoInvite.autoInviteFrame:RegisterEvent("PLAYER_LOGIN")
AutoInvite.autoInviteFrame:RegisterEvent("CHAT_MSG_WHISPER")
AutoInvite.autoInviteFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		AutoInvite:Initialize()
	end

	if event == "CHAT_MSG_WHISPER" then
		AutoInvite:ProcessWhisper(...)
	end
end)

function AutoInvite:Initialize()
	if AutoInviteSettings == nil then
		AutoInvite:LoadDefaults()
	else
		AutoInvite:ApplySavedVariables()
	end
end

function AutoInvite:ApplySavedVariables()
	AutoInvite:SetEnableDisable(AutoInviteSettings.AutoInviteEnabled)
	AutoInvite:SetInviteKeyword(AutoInviteSettings.AutoInviteKeyword, 0)
	AutoInvite:SetInviteChannel(AutoInviteSettings.AutoInviteChannel, 0)
end

function AutoInvite:ProcessWhisper(text, playerName)
	if not AutoInviteSettings.AutoInviteEnabled then
		return
	end

	-- 老虎会游泳：允许空白密语关键字
	if AutoInvite:StringIsNullOrEmpty(AutoInviteSettings.AutoInviteKeyword) or (text == AutoInviteSettings.AutoInviteKeyword) then
		InviteUnit(playerName)
	end
end

SLASH_AUTOINVITE1 = "/autoinvite"
SLASH_AUTOINVITE2 = "/autoinvite help"
SLASH_AUTOINVITE3 = "/autoinvite enable"
SLASH_AUTOINVITE4 = "/autoinvite disable"
SLASH_AUTOINVITE5 = "/autoinvite b"
SLASH_AUTOINVITE6 = "/autoinvite broadcast"
SLASH_AUTOINVITE7 = "/autoinvite k"
SLASH_AUTOINVITE8 = "/autoinvite keyword"
SLASH_AUTOINVITE9 = "/autoinvite c"
SLASH_AUTOINVITE10 = "/autoinvite channel"

SlashCmdList["AUTOINVITE"] = function(msg)
	if AutoInvite:StringIsNullOrEmpty(msg) then
		AutoInvite:PrintHelpInformation()
	end

	local slashCommandMsg = AutoInvite:SplitString(msg, " ")
	local subCommand = slashCommandMsg[1]
	local subCommandMsg = nil

	if table.getn(slashCommandMsg) > 1 then
		subCommandMsg = slashCommandMsg[2]
	end

	if subCommand == "help" then
		AutoInvite:PrintHelpInformation()
	end

	if subCommand == "enable" then
		AutoInvite:SetEnableDisable(true)
	end

	if subCommand == "disable" then
		AutoInvite:SetEnableDisable(false)
	end

	if subCommand == "broadcast" or subCommand == "b" then
		AutoInvite:ProcessBroadcast(subCommandMsg, AutoInviteSettings.AutoInviteChannel)
	end

	if subCommand == "keyword" or subCommand == "k" then
		AutoInvite:ProcessKeyword(subCommandMsg)
	end

	if subCommand == "channel" or subCommand == "c" then
		AutoInvite:ProcessChannel(subCommandMsg)
	end
end

function AutoInvite:PrintHelpInformation()
	print("密语自动邀请进组")
	print("/autoinvite, /autoinvite help -- 显示帮助信息")
	print("/autoinvite enable -- 启用自动邀请")
	print("/autoinvite disable -- 停用自动邀请")
	print("/autoinvite broadcast [keyword], /autoinvite b [keyword] -- 把邀请关键词发送到指定的公共频道并启用自动邀请")
	print("/autoinvite keyword [keyword], /autoinvite k [keyword] -- 更改邀请关键词")
	print("/autoinvite channel [channel], /autoinvite c [channel] -- 更改上面说的“指定的公共频道”，可设为 'SAY', 'YELL', 'PARTY', 'GUILD', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'")
end

function AutoInvite:ProcessBroadcast(subCommandMsg, chatChannel)
	AutoInvite:SetEnableDisable(true)

	if not AutoInvite:StringIsNullOrEmpty(subCommandMsg) then
		AutoInvite:SetInviteKeyword(subCommandMsg, 0)	
	end

	if AutoInvite:StringIsNullOrEmpty(AutoInviteSettings.AutoInviteKeyword) then
		-- 老虎会游泳：允许空白密语关键字
		AutoInviteSettings.AutoInviteKeyword = ''
		--print("自动邀请关键词未设置")
		--return
	end

	if AutoInvite:StringIsNullOrEmpty(AutoInviteSettings.AutoInviteChannel) then
		print("自动邀请频道未设置")
		return
	end

	SendChatMessage("密我" .. AutoInviteSettings.AutoInviteKeyword .. "进组", chatChannel)
end

function AutoInvite:ProcessKeyword(keyword)
	-- 老虎会游泳：允许空白密语关键字
	if AutoInvite:StringIsNullOrEmpty(keyword) then keyword = '' end
	AutoInvite:SetInviteKeyword(keyword, 0)
	print("自动邀请关键词已设为 '" .. AutoInviteSettings.AutoInviteKeyword .. "'")
end

function AutoInvite:ProcessChannel(channel)
	if not AutoInvite:StringIsNullOrEmpty(channel) then
		AutoInvite:SetInviteChannel(channel, 0)
	end

	if AutoInvite:StringIsNullOrEmpty(AutoInviteSettings.AutoInviteChannel) then
		print("自动邀请频道未设置")
	else
		print("自动邀请频道已设为 '" .. AutoInviteSettings.AutoInviteChannel .. "'")
	end
end

function AutoInvite:StringIsNullOrEmpty(s)
	if s == nil or s == '' then
		return true
	end
end

function AutoInvite:SplitString(slashCommand, delimiter)
	result = {}

	for match in (slashCommand .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match)
	end

	return result
end