------------------------------------------------------------
-- Localization.lua
--
-- Abin
-- 2010-9-28
------------------------------------------------------------

-- Default(English)
WHISPERPOP_LOCALE = {
	["title"] = "WhisperPop",
	["receive only"] = "Show received messages only",
	["sound notifying"] = "Sound notifying",
	["time"] = "Show time stamp",
	["receive only tooltip"] = "If checked, sent messages will not be displayed in the list.",
	["sound notifying tooltip"] = "If checked, you will be notifyed with a sound alert every time a new message comes in.",
	["time tooltip"] = "If checked, a time stamp will be displayed in front of every message text.",
	["delete message"] = "|cff00ff00Click:|r Delete all messages from/to %s",
	["delete messages"] = "Delete all messages",
	["delete messages tooltip"] = "Click to delete all existing messages.",
	["keep messages"] = "Keep all messages",
	["keep messages tooltip"] = "Keep all existing messages.",
	["toggle frame"] = "Toggle WhisperPop frame",
	["help tip"] = "Help-tip",
	["show help tip"] = "Show help tip",
	["show help tip tooltip"] = "If checked, a |cffffd200Help-tip|r appears when mouse hovers a player button or a message text line.",
	["player help tip text 1"] = "|cff00ff00Click:|r Open whisper chat with %s",
	["player help tip text 2"] = "|cff00ff00Shift-click:|r Query %s's character information",
	["player help tip text 3"] = "|cff00ff00Alt-click:|r Invite %s to join your party",
	["player help tip text 4"] = "|cff00ff00Right-click:|r Open %s's player menu",
}

WHISPER_POP_LABEL = "WhisperPop"
WHISPER_POP_DESC = ""

if GetLocale() == "zhCN" then
	-- 简体中文
	WHISPERPOP_LOCALE = {
		["title"] = "密语聊天",
		["receive only"] = "仅显示接收到的消息",
		["sound notifying"] = "声音提示",
		["time"] = "显示时间标签",
		["receive only tooltip"] = "如果选中，你发的消息将不会显示在列表中。",
		["sound notifying tooltip"] = "如果选中，每次接收到新消息时将发出声音提示。",
		["time tooltip"] = "如果选中，时间标签将被添加到每一行消息文字前面。",
		["delete messages"] = "删除所有消息",
		["delete messages tooltip"] = "点击删除所有现有的消息。",
		["delete message"] = "|cff00ff00点击:|r 删除所有收发于 %s 的消息",
		["keep messages"] = "保留历史记录",
		["keep messages tooltip"] = "保留九天以内的消息，同帐号的各个角色均可查看。\n \n|cffff3333严重警告：因密语记录可以通过打开魔兽存档随意查看，因此请不要在网吧等公共环境开启此选项，以免信息泄漏。|r",
		["toggle frame"] = "打开/关闭密语聊天框体",
		["help tip"] = "操作提示",
		["show help tip"] = "显示操作提示",
		["show help tip tooltip"] = "如果选中，当鼠标移动到某个玩家按钮或消息文本行时，一个|cffffd200操作提示|r标签会显示出来。",
		["player help tip text 1"] = "|cff00ff00点击:|r 打开与 %s 的密聊通话",
		["player help tip text 2"] = "|cff00ff00Shift-点击:|r 查询 %s 的角色信息",
		["player help tip text 3"] = "|cff00ff00Alt-点击:|r 邀请 %s 加入你的队伍",
		["player help tip text 4"] = "|cff00ff00右键点击:|r 打开 %s 的角色菜单",
	}

	WHISPER_POP_LABEL = "密语聊天"
	WHISPER_POP_DESC = "记录玩家密语聊天信息"

elseif GetLocale() == "zhTW" then
	-- 繁體中文
	WHISPERPOP_LOCALE = {
		["title"] = "密語聊天",
		["receive only"] = "僅顯示接收到的消息",
		["sound notifying"] = "聲音提示",
		["time"] = "顯示時間標簽",
		["receive only tooltip"] = "如果選中，你發的消息將不會顯示在列表中。",
		["sound notifying tooltip"] = "如果選中，每次接收到新消息時將發出聲音提示。",
		["time tooltip"] = "如果选中，時間標簽將被添加到每一行消息文字前面。",
		["delete messages"] = "刪除所有消息",
		["delete messages tooltip"] = "點擊刪除所有現有的消息。",
		["delete message"] = "|cff00ff00點擊:|r 刪除所有收發於 %s 的消息",
		["keep messages"] = "保留历史记录",
		["keep messages tooltip"] = "保留九天以内的消息，而且同帐号的各个角色均可查看。\n \n|cffff3333严重警告：因密语记录可以打开魔兽存档随意查看，因此请不要在网吧等公共环境开启此选项，以免信息泄漏。|r",
		["toggle frame"] = "打開/關閉密语聊天框體",
		["help tip"] = "操作提示",
		["show help tip"] = "顯示操作提示",
		["show help tip tooltip"] = "如果選中，當鼠標移動到某個玩家按鈕或消息文本行時，一個|cffffd200操作提示|r標簽會顯示出來。",
		["player help tip text 1"] = "|cff00ff00點擊:|r 打開與 %s 的密聊通話",
		["player help tip text 2"] = "|cff00ff00Shift-點擊:|r 查詢 %s 的角色信息",
		["player help tip text 3"] = "|cff00ff00Alt-點擊:|r 邀請 %s 加入你的隊伍",
		["player help tip text 4"] = "|cff00ff00右鍵點擊:|r 打開 %s 的角色菜單",
	};

	WHISPER_POP_LABEL = "密語聊天"
	WHISPER_POP_DESC = "記錄玩家的密語聊天信息"

end