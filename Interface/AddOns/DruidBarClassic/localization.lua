DRUIDBAR_CHAT_COMMAND_USAGE	= "Commands: /DruidBar or /dbar.\n/dbar function to see behavioral parameters\n/dbar cosmetic to see cosmetic parameters.";
DRUIDBAR_CHAT_FUNCTIONAL_USAGE 	= "Functional Parameters: [Toggle/Update/Lock/Hide/Replace/shift/EZShift/best/message]";
DRUIDBAR_CHAT_COSMETIC_USAGE	= "Cosmetic Parameters: [barcolor/ShowText/Percent/Changex (1-??)/Changey (1-??)/PlayerFrame/Color/TextType/TextColor]\ntype /dbar textcolor for more info on it";
DRUIDBAR_CHAT_TEXTCOLOR_USE	= "TextColor use: /dbar textcolor -color- (\"original, red, orange, yellow, green, blue, purple, black, white\")\n/dbar textcolor [r/g/b] (0.00 to 1.00)\n/dbar textcolor set # # #";
DRUIDBAR_DRUIDCLASS	= "Druid";
DRUIDBAR_INNERVATE	= "Innervate";
DRUIDBAR_FORM = "Form";
DRUIDBAR_FORMX = "Aquatic";
DRUIDBAR_FORMX2 = "Travel";
BINDING_HEADER_DRUIDBAR = "Druid Bar";
BINDING_NAME_DruidBarBest = "Best Form";
DRUIDBAR_REGEN1 = "Equip: Restores %d+ mana per 5 sec.";
DRUIDBAR_REGEN2 = "Mana Regen %d+ per 5 sec.";
DRUIDBAR_REGEN3 = "Equip: Restores (%d+) mana per 5 sec."
DRUIDBAR_REGEN4 = "Mana Regen (%d+) per 5 sec.";
DRUIDBAR_CAT_FORM = "cat form";

DRUIDBAR_BEAR_FORM = "bear form";

DRUIDBAR_MANA_DELIM = " ";

DRUIDBAR_META = "Metamorphosis Rune";
DRUIDBAR_AQ1 = "Ahn'Qiraj";
DRUIDBAR_AQ2 = "Gates of Ahn'Qiraj";
DRUIDBAR_AQ3 = "Ruins of Ahn'Qiraj";
DRUIDBAR_CHARGER = "Summon Charger";
DRUIDBAR_DREAD = "Summon Dreadsteed";
DRUIDBAR_FEL = "Summon Felsteed";
DRUIDBAR_GHOST = "Ghost Wolf";
DRUIDBAR_WAR = "Summon Warhorse";

DRUIDBAR_OPTIONS_TITLE = "Druid Bar Options";
DRUIDBAR_OPTIONS_Bar = "Bar Options";
DRUIDBAR_OPTIONS_Style = "Display Style"
DRUIDBAR_OPTIONS_MessageO = "Shapeshift Message Options";
DRUIDBAR_OPTIONS_MessageTT = "Allows you to send messages in the channel you choose when shifted.";
DRUIDBAR_OPTIONS_MiscO = "Misc";
DRUIDBAR_OPTIONS_Toggle = "Enable";
DRUIDBAR_OPTIONS_Vis = "Graphics";
DRUIDBAR_OPTIONS_VisTT = "Enable or disable any and all graphical stuff.\nIf you use with other addons like StatusBars or Linoleum, turn it off. If not, leave it on.";
DRUIDBAR_OPTIONS_Minimap = "Show Minimap Button"
DRUIDBAR_OPTIONS_Replace = "Replace";
DRUIDBAR_OPTIONS_ReplaceTT = "Replace the Player Frame's mana bar, splitting it into two when shifted.";
DRUIDBAR_OPTIONS_Player = "Player Frame";
DRUIDBAR_OPTIONS_PlayerTT = "Make the bar show up directly under the Player Frame.";
DRUIDBAR_OPTIONS_Custom = "Custom";
DRUIDBAR_OPTIONS_Width = "Width";
DRUIDBAR_OPTIONS_Height = "Height";
DRUIDBAR_OPTIONS_Lock = "Lock";
DRUIDBAR_OPTIONS_Hide = "Hide when in caster form";
DRUIDBAR_OPTIONS_Full = "Hide when mana is full";
DRUIDBAR_OPTIONS_Message = "Enable";
DRUIDBAR_OPTIONS_Close = "Close";
DRUIDBAR_OPTIONS_Text = "Text Style";
DRUIDBAR_OPTIONS_Percent = "Number Style";
DRUIDBAR_OPTIONS_DROP = {
	["Text"] = {
		[0] = "Original";
		[1] = "New";
		[2] = "Mouseover";
	};
	["Percent"] = {
		[0] = "Raw numbers";
		[1] = "Percentages";
		[2] = "Both";
		[3] = "Bliz-like";
	};
	["Message"] = {
		[0] = "SAY";
		[1] = "PARTY";
		[2] = "RAID";
		[3] = "EMOTE";
	};
	["Strata"] = {
		[0] = "BACKGROUND";
		[1] = "BORDER";
		[2] = "ARTWORK";
		[3] = "OVERLAY";
	};
};
DRUIDBAR_OPTIONS_Message_Bear = "Bear Form";
DRUIDBAR_OPTIONS_Message_Aqua = "Aqua Form";
DRUIDBAR_OPTIONS_Message_Cat = "Cat Form";
DRUIDBAR_OPTIONS_Message_Trav = "Trav Form";
DRUIDBAR_OPTIONS_Message_Oom = "Moonkin";
DRUIDBAR_OPTIONS_Shift = "Shifting to caster using any form";
DRUIDBAR_OPTIONS_EZShift = "Easy Shifting";
DRUIDBAR_OPTIONS_Debug = "Debug Mode";
DRUIDBAR_OPTIONS_ColorBar = "Bar Color";
DRUIDBAR_OPTIONS_ColorBack = "Bg Color";
DRUIDBAR_OPTIONS_ColorBorder = "Border Color";
DRUIDBAR_OPTIONS_Message_Mana = "Mana Bar";
DRUIDBAR_OPTIONS_Message_border = "Bar Border";
DRUIDBAR_OPTIONS_Version = "|cff9d9d9dDruid Bar Classic\nby Tek|r";


if ( GetLocale() == "frFR" ) then
	DRUIDBAR_DRUIDCLASS	= "Druide";
	DRUIDBAR_INNERVATE = "Innervation";
	DRUIDBAR_FORM = "Forme";
	DRUIDBAR_FORMX = "aquatique";
	DRUIDBAR_FORMX2 = "voyage";
	BINDING_NAME_DruidBarBest = "Meilleure Forme";
	DRUIDBAR_REGEN1 = "Equip\195\169 : Rend %d+ points de mana toutes les 5 secondes."
	DRUIDBAR_REGEN2 = "R\195\169cup. mana %d+/5 sec."
	DRUIDBAR_REGEN3 = "Equip\195\169 : Rend (%d+) points de mana toutes les 5 secondes."
	DRUIDBAR_REGEN4 = "R\195\169cup. mana (%d+)/5 sec.";
	DRUIDBAR_CAT_FORM = "f\195\169lin";
	DRUIDBAR_BEAR_FORM = "d'ours";
	DRUIDBAR_MANA_DELIM = ":";
elseif ( GetLocale() == "deDE" ) then
	DRUIDBAR_DRUIDCLASS	= "Druide";
	DRUIDBAR_INNERVATE = "Anregen";
	DRUIDBAR_FORM = "gestalt"
	DRUIDBAR_FORMX = "Wasser";
	DRUIDBAR_FORMX2 = "Reise";
	DRUIDBAR_REGEN1 = "Anlegen: Stellt alle 5 Sek. %d+ Punkt(e) Mana wieder her.";
	DRUIDBAR_REGEN2 = "Manaregeneration %d+ per 5 Sek.";
	DRUIDBAR_REGEN3 = "Anlegen: Stellt alle 5 Sek. (%d+) Punkt(e) Mana wieder her.";
	DRUIDBAR_REGEN4 = "Manaregeneration (%d+) per 5 Sek.";
	DRUIDBAR_CAT_FORM = "rengestalt";
	DRUIDBAR_BEAR_FORM = "katzengestalt";
	DRUIDBAR_MANA_DELIM = " ";
elseif GetLocale() == "zhTW" then
	DRUIDBAR_DRUIDCLASS	= "德魯伊";
	DRUIDBAR_INNERVATE = "啟動";
	DRUIDBAR_FORM = "形態"
	DRUIDBAR_FORMX = "水棲";
	DRUIDBAR_FORMX2 = "旅行";
	BINDING_NAME_DruidBarBest = "最佳形態";
	DRUIDBAR_REGEN1 = "裝備︰ 每5秒恢復%d+點法力值。";
	DRUIDBAR_REGEN2 = "每5秒恢復%d+點法力值。";
	DRUIDBAR_REGEN3 = "裝備︰ 每5秒恢復(%d+)點法力值。"
	DRUIDBAR_REGEN4 = "每5秒恢復(%d+)點法力值。";
	DRUIDBAR_CAT_FORM = "獵豹形態";
	DRUIDBAR_BEAR_FORM = "熊形態";
	DRUIDBAR_MANA_DELIM = "法力";

	DRUIDBAR_META = "變形符文";
	DRUIDBAR_AQ1 = "安其拉";
	DRUIDBAR_AQ2 = "安其拉之門";
	DRUIDBAR_AQ3 = "安其拉廢墟";
	DRUIDBAR_CHARGER = "召喚戰馬";
	DRUIDBAR_DREAD = "召喚恐懼戰馬";
	DRUIDBAR_FEL = "召喚地獄戰馬";
	DRUIDBAR_GHOST = "幽魂之狼";
	DRUIDBAR_WAR = "召喚戰馬";

	DRUIDBAR_OPTIONS_TITLE = "Druid Bar設定";
	DRUIDBAR_OPTIONS_Bar = "狀態條設定";
	DRUIDBAR_OPTIONS_MessageO = "變形訊息設定";
	DRUIDBAR_OPTIONS_MessageTT = "允許你在變形時在指定的頻道送出訊息。";
	DRUIDBAR_OPTIONS_MiscO = "其它";
	DRUIDBAR_OPTIONS_Toggle = "啟用";
	DRUIDBAR_OPTIONS_Vis = "變示";
	DRUIDBAR_OPTIONS_VisTT = "開啟或是關閉任一個，或是全部的顯示。\n如果你和其他的插件(如StatusBars或是Linoleum)一起使用的話，關掉它，不然請保持在開啟狀態。";
	DRUIDBAR_OPTIONS_Replace = "取代";
	DRUIDBAR_OPTIONS_ReplaceTT = "取代玩家的法力條，變形時狀態條會變成二條分別顯示法力和能量/怒氣。";
	DRUIDBAR_OPTIONS_Player = "玩家圖像";
	DRUIDBAR_OPTIONS_PlayerTT = "將DruidBar直接顯示在圖像下方";
	DRUIDBAR_OPTIONS_Custom = "自訂";
	DRUIDBAR_OPTIONS_Width = "寛度";
	DRUIDBAR_OPTIONS_Height = "高度";
	DRUIDBAR_OPTIONS_Lock = "鎖定";
	DRUIDBAR_OPTIONS_Hide = "人型狀態時隱藏";
	DRUIDBAR_OPTIONS_Full = "法力全滿時隱藏";
	DRUIDBAR_OPTIONS_Message = "啟用";
	DRUIDBAR_OPTIONS_Close = "關閉";
	DRUIDBAR_OPTIONS_Text = "文字格式";
	DRUIDBAR_OPTIONS_Percent = "數值格式";
	DRUIDBAR_OPTIONS_DROP = {
		["Text"] = {
			[0] = "原始樣式";
			[1] = "新樣式";
			[2] = "不顯示文字";
		};
		["Percent"] = {
			[0] = "數值";
			[1] = "百分比";
			[2] = "數值/百分比";
		};
		["Message"] = {
			[0] = "SAY";
			[1] = "PARTY";
			[2] = "RAID";
			[3] = "EMOTE";
		}
	};
	DRUIDBAR_OPTIONS_Message_Bear = "態形態";
	DRUIDBAR_OPTIONS_Message_Aqua = "水棲形態";
	DRUIDBAR_OPTIONS_Message_Cat = "獵豹形態";
	DRUIDBAR_OPTIONS_Message_Trav = "旅行形態";
	DRUIDBAR_OPTIONS_Shift = "由任何形態變回人型";
	DRUIDBAR_OPTIONS_EZShift = "簡易變形";
	DRUIDBAR_OPTIONS_Debug = "除錯模式";
elseif GetLocale() == "zhCN" then
	DRUIDBAR_DRUIDCLASS	= "德鲁伊";
	DRUIDBAR_INNERVATE	= "激活";
	DRUIDBAR_FORM = "形态";
	DRUIDBAR_FORMX = "水栖";
	DRUIDBAR_FORMX2 = "旅行";
	DRUIDBAR_REGEN1 = "装备： 每5秒恢复%d+点法力值。";
	DRUIDBAR_REGEN2 = "每5秒恢复%d+点法力值。";
	DRUIDBAR_REGEN3 = "装备： 每5秒恢复(%d+)点法力值。"
	DRUIDBAR_REGEN4 = "每5秒恢复(%d+)点法力值。";
	DRUIDBAR_CAT_FORM = "猎豹形态";

	DRUIDBAR_BEAR_FORM = "熊形态";

	DRUIDBAR_MANA_DELIM = "法力值";
	DRUIDBAR_META = "变形符文";
	DRUIDBAR_OPTIONS_TITLE = "Druid Bar 设置";
	DRUIDBAR_OPTIONS_Toggle = "启用";
	DRUIDBAR_OPTIONS_Bar = "法力条设置";
	DRUIDBAR_OPTIONS_MessageO = "变形信息设置";
	DRUIDBAR_OPTIONS_MessageTT = "在变形时向指定的频道内发送消息。";
	DRUIDBAR_OPTIONS_MiscO = "其他设置";
	DRUIDBAR_OPTIONS_Vis = "显示";
	DRUIDBAR_OPTIONS_VisTT = "开启或关闭法力槽显示。\n如果你使用 StatusBars 等 Linoleum 等插件，请将该选项关闭。反之，请打开。";
	DRUIDBAR_OPTIONS_Replace = "整合";
	DRUIDBAR_OPTIONS_ReplaceTT = "变形后将玩家框架内的法力槽分成两部分分别显示怒气/精力和法力。";
	DRUIDBAR_OPTIONS_Player = "玩家框架";
	DRUIDBAR_OPTIONS_PlayerTT = "将 Druid Bar 显示在玩家框架下方。";
	DRUIDBAR_OPTIONS_Custom = "自定义";
	DRUIDBAR_OPTIONS_Width = "宽度";
	DRUIDBAR_OPTIONS_Height = "高度";
	DRUIDBAR_OPTIONS_Lock = "锁定";
	DRUIDBAR_OPTIONS_Hide = "施法者形态下隐藏";
	DRUIDBAR_OPTIONS_Full = "法力值为满时隐藏";
	DRUIDBAR_OPTIONS_Message = "启用";
	DRUIDBAR_OPTIONS_Close = "关闭";
	DRUIDBAR_OPTIONS_Text = "文本样式";
	DRUIDBAR_OPTIONS_Percent = "数字样式";
	DRUIDBAR_OPTIONS_DROP = {
		["Text"] = {
			[0] = "原样式";
			[1] = "新样式";
			[2] = "无文本";
		};
		["Percent"] = {
			[0] = "具体数字";
			[1] = "百分比";
			[2] = "显示两者";
		};
		["Message"] = {
			[0] = "说";
			[1] = "小队";
			[2] = "团队";
			[3] = "表情";
		}
	};
	DRUIDBAR_OPTIONS_Message_Bear = "熊形态";
	DRUIDBAR_OPTIONS_Message_Aqua = "水栖形态";
	DRUIDBAR_OPTIONS_Message_Cat = "猎豹形态";
	DRUIDBAR_OPTIONS_Message_Trav = "旅行形态";
	DRUIDBAR_OPTIONS_Message_Oom = "枭兽形态";
	DRUIDBAR_OPTIONS_Shift = "使用任意形态即可变回人形";
	DRUIDBAR_OPTIONS_EZShift = "简易变形";
	DRUIDBAR_OPTIONS_Debug = "Debug 模式";
	DRUIDBAR_AQ1 = "安其拉"
	DRUIDBAR_AQ2 = "安其拉之门";
	DRUIDBAR_AQ3 = "安其拉废墟";
	DRUIDBAR_CHARGER = "召唤战马";
	DRUIDBAR_DREAD = "召唤恐惧战马";
	DRUIDBAR_FEL = "召唤地狱战马";
	DRUIDBAR_GHOST = "幽魂之狼";
	DRUIDBAR_WAR =  "召唤军马";
	DRUIDBAR_OPTIONS_ColorBar = "颜色";
elseif ( GetLocale() == "koKR" ) then
	DRUIDBAR_DRUIDCLASS	= "드루이드";
	DRUIDBAR_INNERVATE = "정신 자극";
	DRUIDBAR_FORM = "변신";
	DRUIDBAR_FORMX = "바다표범";
	DRUIDBAR_FORMX2 = "치타";
--	BINDING_NAME_DruidBarBest = "Best Form";
	DRUIDBAR_REGEN1 = "착용 효과: 매 5초마다 %d+의 마나가 회복됩니다.";
	DRUIDBAR_REGEN2 = "5초당 마나 회복 %d+";
	DRUIDBAR_REGEN3 = "착용 효과: 매 5초마다 (%d+)의 마나가 회복됩니다.";
	DRUIDBAR_REGEN4 = "5초당 마나 회복 (%d+)";
	DRUIDBAR_CAT_FORM = "표범 변신";
	DRUIDBAR_BEAR_FORM = "곰 변신";
	DRUIDBAR_MANA_DELIM = " ";
	DRUIDBAR_AQ1 = "안퀴라즈";
	DRUIDBAR_AQ2 = "안퀴라즈 성문";
	DRUIDBAR_AQ3 = "안퀴라즈 폐허";
	DRUIDBAR_CHARGER = "준마 소환";
	DRUIDBAR_DREAD = "공포마 소환";
	DRUIDBAR_FEL = "지옥마 소환";
	DRUIDBAR_GHOST = "늑대 정령";
	DRUIDBAR_WAR = "군마 소환";
end
