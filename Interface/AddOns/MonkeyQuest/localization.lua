-- Not translations
MONKEYQUEST_TITLE						= "MonkeyQuest"
MONKEYQUEST_VERSION						= "CY 汉化"
MONKEYQUEST_TITLE_VERSION				= MONKEYQUEST_TITLE .. " - " .. MONKEYQUEST_VERSION
MONKEYQUEST_INFO_COLOUR					= "|cffffff00"
MONKEYQUEST_CHAT_COLOUR					= "|cff00ff00"
BINDING_HEADER_MONKEYQUEST				= MONKEYQUEST_TITLE

-- English, the default
MONKEYQUEST_DESCRIPTION					= "查看任務快速又方便"
MONKEYQUEST_LOADED_MSG					= MONKEYQUEST_INFO_COLOUR .. MONKEYQUEST_TITLE .. " v" .. MONKEYQUEST_VERSION .. " 已載入"
MONKEYQUEST_OPTIONS1					= "Please install MonkeyBuddy to configure your MonkeyQuest easily."
MONKEYQUEST_OPTIONS2					= "\124TInterface\\Icons\\Trade_Engineering:0\124t MonkeyBuddy is currently not installed."

MONKEYQUEST_NO_HEADER					= "没有标题"
MONKEYQUEST_QUEST_DONE					= "完成"
MONKEYQUEST_QUEST_FAILED				= "失败"
MONKEYQUEST_CONFIRM_RESET				= "是否确认要重置 " .. MONKEYQUEST_TITLE .. " 的设定，恢复为预设值？"
MONKEYQUEST_CONFIRM_RESET_TO_BLIZZARD_STYLE				= "是否要将 " .. MONKEYQUEST_TITLE .. " 设定为暴雪任务清单风格？"
MONKEYQUEST_CONFIRM_GEPY_STYLE							= "是否要将 " .. MONKEYQUEST_TITLE .. " 设定为 'DaMaGepy' 风格？"

MONKEYQUEST_SET_WIDTH_MSG				= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": You may need to '/console reloadui' to see the changes in width."
MONKEYQUEST_RESET_MSG					= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": Settings reset."
MONKEYQUEST_RESET_TO_BLIZZARD_STYLE_MSG	= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": Settings set to Blizzard quest tracker style."
MONKEYQUEST_RESET_GEPY_STYLE_MSG		= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": Settings set to 'DaMaGepy' style."

MONKEYQUEST_HELP_MSG					= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest help <command>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Where <command> is any of the following: \n" ..
										  "reset, open, close, showhidden, hidehidden, useoverviews, nooverviews, " ..
										  "tipanchor, alpha, width, hideheaders, showheaders, hideborder, showborder, " ..
										  "growup, growdown, hidenumquests, shownumquests, lock, unlock, colourtitleon, " ..
										  "colourtitleoff, hidecompletedquests, showcompletedquests, hidecompletedobjectives, " ..
										  "showcompletedobjectives, fontheight, showtooltipobjectives, hidetootipobjectives, " ..
										  "allowrightclick, disallowrightclick, hidetitlebuttons, showtitlebuttons, allowworkcomplete, disallowworkcomplete, " ..
										  "colourobjectiveson, colourobjectivesoff, showitems, hideitems, itemsonleft, itemsonright, hideviaclick, nohideviaclick."
MONKEYQUEST_HELP_RESET_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest reset\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Displays the reset config variables dialog.\n"
MONKEYQUEST_HELP_OPEN_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest open\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Shows the main " .. MONKEYQUEST_TITLE .. " frame.\n"
MONKEYQUEST_HELP_CLOSE_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest close\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hides the main " .. MONKEYQUEST_TITLE .. " frame.\n"
MONKEYQUEST_HELP_SHOWHIDDEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showhidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Shows collapsed zone headers and hidden quests.\n"
MONKEYQUEST_HELP_HIDEHIDDEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidehidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hides collapsed zone headers and hidden quests.\n"
MONKEYQUEST_HELP_USEOVERVIEWS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest useoverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Displays the quest overview for quests without objectives.\n"
MONKEYQUEST_HELP_NOOVERVIEWS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest nooverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Don't display the quest overview for quests without objectives.\n"
MONKEYQUEST_HELP_TIPANCHOR_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest tipanchor=<anchor position>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the anchor point of the tooltip where <anchor position> " .. 
										  "can be any of the following:\nANCHOR_TOPLEFT, ANCHOR_TOPRIGHT, ANCHOR_TOP, ANCHOR_LEFT, " ..
										  "ANCHOR_RIGHT, ANCHOR_BOTTOMLEFT, ANCHOR_BOTTOMRIGHT, ANCHOR_BOTTOM, ANCHOR_CURSOR, " .. 
										  "DEFAULT, NONE"
MONKEYQUEST_HELP_ALPHA_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest alpha=<0 - 255>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the backdrop alpha to the specified value.\n"
MONKEYQUEST_HELP_WIDTH_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest width=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the width to the specified value, the default is 255.\n"
MONKEYQUEST_HELP_HIDEHEADERS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hideheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Never display any zone headers.\n"
MONKEYQUEST_HELP_SHOWHEADERS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Display zone headers.\n"
MONKEYQUEST_HELP_HIDEBORDER_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hideborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hide the border around the main " .. MONKEYQUEST_TITLE .. " frame.\n"
MONKEYQUEST_HELP_SHOWBORDER_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Show the border around the main " .. MONKEYQUEST_TITLE .. " frame.\n"
MONKEYQUEST_HELP_GROWUP_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest growup\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Makes the main " .. MONKEYQUEST_TITLE .. " frame expand upwards.\n"
MONKEYQUEST_HELP_GROWDOWN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest growdown\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Makes the main " .. MONKEYQUEST_TITLE .. " frame expand downwards.\n"
MONKEYQUEST_HELP_HIDENUMQUESTS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidenumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hide the number of quests next to the title.\n"
MONKEYQUEST_HELP_SHOWNUMQUESTS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest shownumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Show the number of quests next to the title.\n"
MONKEYQUEST_HELP_LOCK_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest lock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Locks the " .. MONKEYQUEST_TITLE .. " frame in place.\n"
MONKEYQUEST_HELP_UNLOCK_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest unlock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Unlocks the " .. MONKEYQUEST_TITLE .. " frame, making it movable.\n"
MONKEYQUEST_HELP_COLOURTITLEON_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest colourtitleon\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Uses the difficulty to colour the entier quest title.\n"
MONKEYQUEST_HELP_COLOURTITLEOFF_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest colourtitleoff\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Doesn't colour the entier quest title by difficulty.\n"
MONKEYQUEST_HELP_HIDECOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidecompletedquests\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Hides completed quests.\n"
MONKEYQUEST_HELP_SHOWCOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showcompletedquests\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Shows completed quests.\n"
MONKEYQUEST_HELP_HIDECOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidecompletedobjectives\n" ..
												  MONKEYQUEST_CHAT_COLOUR .. "Hides completed objectives.\n"
MONKEYQUEST_HELP_SHOWCOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showcompletedobjectives\n" ..
												  MONKEYQUEST_CHAT_COLOUR .. "Shows completed objectives.\n"
MONKEYQUEST_HELP_FONTHEIGHT_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest fontheight=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the font height to the specified value, the default is 12.\n"
MONKEYQUEST_HELP_SHOWTOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showtooltipobjectives\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Adds a line to the tooltip which shows the completeness of that quest objective.\n"
MONKEYQUEST_HELP_HIDETOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidetooltipobjectives\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Does not add a line to the tooltip about the completeness of that quest objective.\n"
MONKEYQUEST_HELP_ALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest allowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Allows you to right-click to open MonkeyBuddy.\n"
MONKEYQUEST_HELP_DISALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest disallowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Disallows you from right-clicking to open MonkeyBuddy.\n"
MONKEYQUEST_HELP_HIDETITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidetitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hides the title buttons.\n"
MONKEYQUEST_HELP_SHOWTITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showtitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Shows the title buttons.\n"
MONKEYQUEST_HELP_ALLOWWORKCOMPLETE_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest allowworkcomplete\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Enables >work complete< sound.\n"
MONKEYQUEST_HELP_DISALLOWWORKCOMPLETE_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest disallowworkcomplete\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Disables >work complete< sound.\n"

-- tooltip strings
MONKEYQUEST_TOOLTIP_QUESTITEM			= "任务物品"					-- as it appears in the tooltip of unique quest items
MONKEYQUEST_TOOLTIP_QUEST				= "任务"
MONKEYQUEST_TOOLTIP_SLAIN				= "杀死"						-- as it appears in the objective text

-- misc quest strings
MONKEYQUEST_DUNGEON						= "地下城"
MONKEYQUEST_PVP							= "PvP"

-- noob tips
MONKEYQUEST_NOOBTIP_HEADER				= "小提示:"

MONKEYQUEST_NOOBTIP_CLOSE				= "点一下这里关闭清单，要恢复请:"
MONKEYQUEST_NOOBTIP_MINIMIZE			= "点一下这里最小化清单"
MONKEYQUEST_NOOBTIP_RESTORE				= "点一下这里恢复清单"
MONKEYQUEST_NOOBTIP_SHOWALLHIDDEN		= "点一下这里显示所有隐藏项目"
MONKEYQUEST_NOOBTIP_HIDEALLHIDDEN		= "点一下这里隐藏所有隐藏项目"
MONKEYQUEST_NOOBTIP_HIDEBUTTON			= "点一下这里隐藏这个任务。要再次看到这个任务，请启用'显示所有隐藏项目'"
MONKEYQUEST_NOOBTIP_TITLE				= "右键点一下这里开启设定选项\n拖曳这里移动任务清单位置"
MONKEYQUEST_NOOBTIP_QUESTHEADER			= "点一下这里来隐藏/显示这个区域内的所有任务。要显示已被隐藏的区域标题，请启用'显示所有隐藏项目'"

-- bindings
BINDING_NAME_MONKEYQUEST_CLOSE			= "关闭/打开"
BINDING_NAME_MONKEYQUEST_MINIMIZE		= "最小化/恢复"
BINDING_NAME_MONKEYQUEST_HIDDEN			= "隐藏/显示所有隐藏项目"
BINDING_NAME_MONKEYQUEST_NOHEADERS		= "切换显示标题"

if ( GetLocale() == "zhTW" ) then

MONKEYQUEST_TITLE						= "MQ 任務清單"
MONKEYQUEST_DESCRIPTION					= "查看任務快速又方便。"
MONKEYQUEST_LOADED_MSG					= MONKEYQUEST_INFO_COLOUR .. MONKEYQUEST_TITLE .. " v" .. MONKEYQUEST_VERSION .. " 已載入"
MONKEYQUEST_OPTIONS1					= "請安裝 MonkeyBuddy (MQ 任務清單-設定選項) 以方便設定 MQ 任務清單。"
MONKEYQUEST_OPTIONS2					= "\124TInterface\\Icons\\Trade_Engineering:0\124t 尚未安裝 MonkeyBuddy (MQ 任務清單-設定選項)。"

MONKEYQUEST_NO_HEADER					= "沒有標題"
MONKEYQUEST_QUEST_DONE					= "完成"
MONKEYQUEST_QUEST_FAILED				= "失敗"
MONKEYQUEST_CONFIRM_RESET				= "是否確定要重置 " .. MONKEYQUEST_TITLE .. " 的設定，恢復成預設值?"
MONKEYQUEST_CONFIRM_RESET_TO_BLIZZARD_STYLE				= "是否要將 " .. MONKEYQUEST_TITLE .. " 設定為暴雪任務清單風格?"
MONKEYQUEST_CONFIRM_GEPY_STYLE							= "是否要將 " .. MONKEYQUEST_TITLE .. " 設定為 'DaMaGepy' 風格?"

MONKEYQUEST_SET_WIDTH_MSG				= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": 你可能需要輸入 '/console reloadui' 才能看到寬度的更改。"
MONKEYQUEST_RESET_MSG					= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": 設定重置。"
MONKEYQUEST_RESET_TO_BLIZZARD_STYLE_MSG	= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": 設定為暴雪任務清單風格。"
MONKEYQUEST_RESET_GEPY_STYLE_MSG		= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": 設定為 'DaMaGepy' 風格。"

MONKEYQUEST_HELP_MSG					= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest help <command>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Where <command> is any of the following: \n" ..
										  "reset, open, close, showhidden, hidehidden, useoverviews, nooverviews, " ..
										  "tipanchor, alpha, width, hideheaders, showheaders, hideborder, showborder, " ..
										  "growup, growdown, hidenumquests, shownumquests, lock, unlock, colourtitleon, " ..
										  "colourtitleoff, hidecompletedquests, showcompletedquests, hidecompletedobjectives, " ..
										  "showcompletedobjectives, fontheight, showtooltipobjectives, hidetootipobjectives, " ..
										  "allowrightclick, disallowrightclick, hidetitlebuttons, showtitlebuttons, allowworkcomplete, disallowworkcomplete, " ..
										  "colourobjectiveson, colourobjectivesoff, showitems, hideitems, itemsonleft, itemsonright, hideviaclick, nohideviaclick."
MONKEYQUEST_HELP_RESET_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest reset\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Displays the reset config variables dialog.\n"
MONKEYQUEST_HELP_OPEN_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest open\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Shows the main " .. MONKEYQUEST_TITLE .. " frame.\n"
MONKEYQUEST_HELP_CLOSE_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest close\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hides the main " .. MONKEYQUEST_TITLE .. " frame.\n"
MONKEYQUEST_HELP_SHOWHIDDEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showhidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Shows collapsed zone headers and hidden quests.\n"
MONKEYQUEST_HELP_HIDEHIDDEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidehidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hides collapsed zone headers and hidden quests.\n"
MONKEYQUEST_HELP_USEOVERVIEWS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest useoverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Displays the quest overview for quests without objectives.\n"
MONKEYQUEST_HELP_NOOVERVIEWS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest nooverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Don't display the quest overview for quests without objectives.\n"
MONKEYQUEST_HELP_TIPANCHOR_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest tipanchor=<anchor position>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the anchor point of the tooltip where <anchor position> " .. 
										  "can be any of the following:\nANCHOR_TOPLEFT, ANCHOR_TOPRIGHT, ANCHOR_TOP, ANCHOR_LEFT, " ..
										  "ANCHOR_RIGHT, ANCHOR_BOTTOMLEFT, ANCHOR_BOTTOMRIGHT, ANCHOR_BOTTOM, ANCHOR_CURSOR, " .. 
										  "DEFAULT, NONE"
MONKEYQUEST_HELP_ALPHA_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest alpha=<0 - 255>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the backdrop alpha to the specified value.\n"
MONKEYQUEST_HELP_WIDTH_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest width=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the width to the specified value, the default is 255.\n"
MONKEYQUEST_HELP_HIDEHEADERS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hideheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Never display any zone headers.\n"
MONKEYQUEST_HELP_SHOWHEADERS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Display zone headers.\n"
MONKEYQUEST_HELP_HIDEBORDER_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hideborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hide the border around the main " .. MONKEYQUEST_TITLE .. " frame.\n"
MONKEYQUEST_HELP_SHOWBORDER_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Show the border around the main " .. MONKEYQUEST_TITLE .. " frame.\n"
MONKEYQUEST_HELP_GROWUP_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest growup\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Makes the main " .. MONKEYQUEST_TITLE .. " frame expand upwards.\n"
MONKEYQUEST_HELP_GROWDOWN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest growdown\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Makes the main " .. MONKEYQUEST_TITLE .. " frame expand downwards.\n"
MONKEYQUEST_HELP_HIDENUMQUESTS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidenumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hide the number of quests next to the title.\n"
MONKEYQUEST_HELP_SHOWNUMQUESTS_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest shownumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Show the number of quests next to the title.\n"
MONKEYQUEST_HELP_LOCK_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest lock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Locks the " .. MONKEYQUEST_TITLE .. " frame in place.\n"
MONKEYQUEST_HELP_UNLOCK_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest unlock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Unlocks the " .. MONKEYQUEST_TITLE .. " frame, making it movable.\n"
MONKEYQUEST_HELP_COLOURTITLEON_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest colourtitleon\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Uses the difficulty to colour the entier quest title.\n"
MONKEYQUEST_HELP_COLOURTITLEOFF_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest colourtitleoff\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Doesn't colour the entier quest title by difficulty.\n"
MONKEYQUEST_HELP_HIDECOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidecompletedquests\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Hides completed quests.\n"
MONKEYQUEST_HELP_SHOWCOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showcompletedquests\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Shows completed quests.\n"
MONKEYQUEST_HELP_HIDECOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidecompletedobjectives\n" ..
												  MONKEYQUEST_CHAT_COLOUR .. "Hides completed objectives.\n"
MONKEYQUEST_HELP_SHOWCOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showcompletedobjectives\n" ..
												  MONKEYQUEST_CHAT_COLOUR .. "Shows completed objectives.\n"
MONKEYQUEST_HELP_FONTHEIGHT_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest fontheight=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the font height to the specified value, the default is 12.\n"
MONKEYQUEST_HELP_SHOWTOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showtooltipobjectives\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Adds a line to the tooltip which shows the completeness of that quest objective.\n"
MONKEYQUEST_HELP_HIDETOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidetooltipobjectives\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Does not add a line to the tooltip about the completeness of that quest objective.\n"
MONKEYQUEST_HELP_ALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest allowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Allows you to right-click to open MonkeyBuddy.\n"
MONKEYQUEST_HELP_DISALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest disallowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Disallows you from right-clicking to open MonkeyBuddy.\n"
MONKEYQUEST_HELP_HIDETITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidetitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hides the title buttons.\n"
MONKEYQUEST_HELP_SHOWTITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showtitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Shows the title buttons.\n"
MONKEYQUEST_HELP_ALLOWWORKCOMPLETE_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest allowworkcomplete\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Enables >work complete< sound.\n"
MONKEYQUEST_HELP_DISALLOWWORKCOMPLETE_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest disallowworkcomplete\n" ..
											  MONKEYQUEST_CHAT_COLOUR .. "Disables >work complete< sound.\n"

-- tooltip strings
MONKEYQUEST_TOOLTIP_QUESTITEM			= "任務物品"					-- as it appears in the tooltip of unique quest items
MONKEYQUEST_TOOLTIP_QUEST				= "任務"
MONKEYQUEST_TOOLTIP_SLAIN				= "殺死"						-- as it appears in the objective text

-- misc quest strings
MONKEYQUEST_DUNGEON						= "地城"
MONKEYQUEST_PVP							= "PvP"

-- noob tips
MONKEYQUEST_NOOBTIP_HEADER				= "小提示:"

MONKEYQUEST_NOOBTIP_CLOSE				= "點一下這裡關閉清單，要恢復請:"
MONKEYQUEST_NOOBTIP_MINIMIZE			= "點一下這裡最小化清單"
MONKEYQUEST_NOOBTIP_RESTORE				= "點一下這裡恢復清單"
MONKEYQUEST_NOOBTIP_SHOWALLHIDDEN		= "點一下這裡顯示所有隱藏項目"
MONKEYQUEST_NOOBTIP_HIDEALLHIDDEN		= "點一下這裡隱藏所有隱藏項目"
MONKEYQUEST_NOOBTIP_HIDEBUTTON			= "點一下這裡隱藏這個任務。要再次看到這個任務，請啟用 '顯示所有隱藏項目'。"
MONKEYQUEST_NOOBTIP_TITLE				= "右鍵點一下這裡開啟設定選項\n拖曳這裡移動任務清單位置"
MONKEYQUEST_NOOBTIP_QUESTHEADER			= "點一下這裡來隱藏/顯示這個區域內的所有任務。要顯示已被隱藏的區域標題，請啟用 '顯示所有隱藏項目'。"

-- bindings
BINDING_NAME_MONKEYQUEST_CLOSE			= "關閉/打開"
BINDING_NAME_MONKEYQUEST_MINIMIZE		= "最小化/恢復"
BINDING_NAME_MONKEYQUEST_HIDDEN			= "隱藏/顯示所有隱藏項目"
BINDING_NAME_MONKEYQUEST_NOHEADERS		= "切換顯示標題"

end
