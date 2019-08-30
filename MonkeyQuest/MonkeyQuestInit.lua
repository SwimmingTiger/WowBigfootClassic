function MonkeyQuestInit_LoadConfig()

	-- double check that we aren't already loaded
	if (MonkeyQuest.m_bLoaded == true) then
		-- how did it even get here?
		return;
	end
	
	-- double check that variables loaded event triggered, if not, exit
	if (MonkeyQuest.m_bVariablesLoaded == false) then
		return;
	end
	
	-- 停用自動更新任務進度，避免顯示出內建的任務清單
	SetCVar("autoQuestProgress", 0)
		
	-- add the realm to the "player's name" for the config settings
	MonkeyQuest.m_strPlayer = GetRealmName().."|"..MonkeyQuest.m_strPlayer;
	
	-- set this to MonkeyQuest.m_strPlayer to enable per character
	MonkeyQuest.m_global = "Global"
	
	-- check if the variable needs initializing
	if (not MonkeyQuestConfig) then
		MonkeyQuestConfig = {};
	end
	
	-- if there's not an entry for this
	if (not MonkeyQuestConfig[MonkeyQuest.m_strPlayer]) then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer] = {};
	end	
	if (not MonkeyQuestConfig[MonkeyQuest.m_global]) then
		MonkeyQuestConfig[MonkeyQuest.m_global] = {};
	end	
	
	-- set the defaults if the variables don't exist
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bDisplay == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bDisplay = MONKEYQUEST_DEFAULT_DISPLAY;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_strAnchor == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_strAnchor = MONKEYQUEST_DEFAULT_ANCHOR;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bObjectives == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bObjectives = MONKEYQUEST_DEFAULT_OBJECTIVES;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_iAlpha == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_iAlpha = MONKEYQUEST_DEFAULT_ALPHA;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_iHighlightAlpha == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_iHighlightAlpha = MONKEYQUEST_DEFAULT_HIGHLIGHT_ALPHA;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameAlpha == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameAlpha = MONKEYQUEST_DEFAULT_FRAME_ALPHA;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bMinimized == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bMinimized = MONKEYQUEST_DEFAULT_MINIMIZED;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList = {};
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameWidth == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameWidth = MONKEYQUEST_DEFAULT_WIDTH;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowHidden == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowHidden = MONKEYQUEST_DEFAULT_SHOWHIDDEN;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bNoHeaders == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bNoHeaders = MONKEYQUEST_DEFAULT_NOHEADERS;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bAlwaysHeaders == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bAlwaysHeaders = MONKEYQUEST_DEFAULT_ALWAYSHEADERS;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bNoBorder == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bNoBorder = MONKEYQUEST_DEFAULT_NOBORDER;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bGrowUp == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bGrowUp = MONKEYQUEST_DEFAULT_GROWUP;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowNumQuests == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowNumQuests = MONKEYQUEST_DEFAULT_SHOWNUMQUESTS;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowDailyNumQuests == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowDailyNumQuests = MONKEYQUEST_DEFAULT_SHOWDAILYNUMQUESTS;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bLocked == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bLocked = MONKEYQUEST_DEFAULT_LOCKED;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideCompletedQuests == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideCompletedQuests = MONKEYQUEST_DEFAULT_HIDECOMPLETEDQUESTS;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideCompletedObjectives == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideCompletedObjectives = MONKEYQUEST_DEFAULT_HIDECOMPLETEDOBJECTIVES;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bAllowRightClick == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bAllowRightClick = MONKEYQUEST_DEFAULT_ALLOWRIGHTCLICK;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowTooltipObjectives == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowTooltipObjectives = MONKEYQUEST_DEFAULT_SHOWTOOLTIPOBJECTIVES;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideTitleButtons == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideTitleButtons = MONKEYQUEST_DEFAULT_HIDETITLEBUTTONS;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideTitle == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideTitle = MONKEYQUEST_DEFAULT_HIDETITLE;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bWorkComplete == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bWorkComplete = MONKEYQUEST_DEFAULT_WORKCOMPLETE;
	end

	-- colour config vars
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bColourTitle == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bColourTitle = MONKEYQUEST_DEFAULT_COLOURTITLE;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_strQuestTitleColour == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_strQuestTitleColour = MONKEYQUEST_DEFAULT_QUESTTITLECOLOUR;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_strHeaderOpenColour == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_strHeaderOpenColour = MONKEYQUEST_DEFAULT_HEADEROPENCOLOUR;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_strHeaderClosedColour == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_strHeaderClosedColour = MONKEYQUEST_DEFAULT_HEADERCLOSEDCOLOUR;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_strOverviewColour == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_strOverviewColour = MONKEYQUEST_DEFAULT_OVERVIEWCOLOUR;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_strSpecialObjectiveColour == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_strSpecialObjectiveColour = MONKEYQUEST_DEFAULT_SPECIALOBJECTIVECOLOUR;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_strInitialObjectiveColour == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_strInitialObjectiveColour = MONKEYQUEST_DEFAULT_INITIALOBJECTIVECOLOUR;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_strMidObjectiveColour == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_strMidObjectiveColour = MONKEYQUEST_DEFAULT_MIDOBJECTIVECOLOUR;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_strCompleteObjectiveColour == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_strCompleteObjectiveColour = MONKEYQUEST_DEFAULT_COMPLETEOBJECTIVECOLOUR;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_strFinishObjectiveColour == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_strFinishObjectiveColour = MONKEYQUEST_DEFAULT_FINISHOBJECTIVECOLOUR;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_strZoneHighlightColour == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_strZoneHighlightColour = MONKEYQUEST_DEFAULT_ZONEHILIGHTCOLOUR;
	end
	
	-- font configs
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_iFontHeight == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_iFontHeight = MONKEYQUEST_DEFAULT_FONTHEIGHT;
	end

	-- Skinny font
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_iFont == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_iFont = MONKEYQUEST_DEFAULT_FONT;
	end

	-- Golden border
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bCrashBorder == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bCrashBorder = MONKEYQUEST_DEFAULT_CRASHBORDER;
	end

	-- Noob tips
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowNoobTips == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowNoobTips = MONKEYQUEST_DEFAULT_SHOWNOOBTIPS;
	end

	-- quest padding
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_iQuestPadding == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_iQuestPadding = MONKEYQUEST_DEFAULT_QUESTPADDING;
	end
	
	-- show zone highlight
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowZoneHighlight == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowZoneHighlight = MONKEYQUEST_DEFAULT_SHOWZONEHIGHLIGHT;
	end
	
	-- show quest levels in MonkeyQuest frame
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowQuestLevel == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowQuestLevel = MONKEYQUEST_DEFAULT_SHOWQUESTLEVEL;
	end
	
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bColourSubObjectivesByProgress == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bColourSubObjectivesByProgress = MONKEYQUEST_DEFAULT_COLOURSUBOBJECTIVES;
	end
	
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bItemsEnabled == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bItemsEnabled = MONKEYQUEST_DEFAULT_ITEMSENABLED;
	end
	
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bItemsOnLeft == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bItemsOnLeft = MONKEYQUEST_DEFAULT_ITEMSONLEFT;
	end
	
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideHeader == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideHeader = MONKEYQUEST_DEFAULT_HIDEHEADER;
	end
	
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideQuestsEnabled == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideQuestsEnabled = MONKEYQUEST_DEFAULT_HIDEQUESTSENABLED;
	end

	-- All variables are loaded now
	MonkeyQuest.m_bLoaded = true;
	
	-- finally apply the settings
	MonkeyQuestInit_ApplySettings();

	-- Let the user know the mod is loaded
	--[[
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_LOADED_MSG);
	end
	--]]
end

function MonkeyQuestInit_CleanQuestList()
	-- make sure the hidden array is ready to go
	local iNumEntries, iNumQuests = GetNumQuestLogEntries();

	-- Remember the currently selected quest log entry
	local tmpQuestLogSelection = GetQuestLogSelection();	

	MonkeyQuest.m_iNumEntries = iNumEntries;

	-- go through the quest list and m_aQuestList is initialized
	for i = 1, iNumEntries, 1 do
		-- strQuestLogTitleText		the title text of the quest, may be a header (ex. Wetlands)
		-- strQuestLevel			the level of the quest
		local strQuestLogTitleText, strQuestLevel, suggestedGroup, isHeader, isCollapsed, isComplete = GetQuestLogTitle(i);
		
		-- since 4.0.1 some strQuestLogTitleText are nil
		if (strQuestLogTitleText == nil) then
			strQuestLogTitleText = MONKEYQUEST_NO_HEADER
		end
		
		MonkeyQuest.m_aQuestList[strQuestLogTitleText.." - "..tostring(isHeader)] = {};
		
		-- put the entry in the hidden list if it's not there already
		if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText.." - "..tostring(isHeader)] == nil) then
			MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText.." - "..tostring(isHeader)] = {};
			MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText.." - "..tostring(isHeader)].m_bChecked = true;
		end
			
		MonkeyQuest.m_aQuestList[strQuestLogTitleText.." - "..tostring(isHeader)].m_bChecked = MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText.." - "..tostring(isHeader)].m_bChecked;
	end
	
	-- clean up the config hidden list
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList = nil;
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList = {};
	
	
	-- delete the objective list, we're about to rebuild it
	MonkeyQuest.m_aQuestItemList = nil;
	MonkeyQuest.m_aQuestItemList = {};
	
	
	-- go through the quest list one more time and copy the entries from the temp list to the real list.
	--  this gets rid of any list entries for quests the user doesn't have
	for i = 1, iNumEntries, 1 do
		-- strQuestLogTitleText		the title text of the quest, may be a header (ex. Wetlands)
		-- strQuestLevel			the level of the quest
		local strQuestLogTitleText, strQuestLevel, suggestedGroup, isHeader, isCollapsed, isComplete = GetQuestLogTitle(i);
		
		-- since 4.0.1 some strQuestLogTitleText are nil
		if (strQuestLogTitleText == nil) then
			strQuestLogTitleText = MONKEYQUEST_NO_HEADER
		end
		
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText.." - "..tostring(isHeader)] = {};
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText.." - "..tostring(isHeader)].m_bChecked = MonkeyQuest.m_aQuestList[strQuestLogTitleText.." - "..tostring(isHeader)].m_bChecked;
			
		
		-- Select the quest log entry for other functions like GetNumQuestLeaderBoards()
		SelectQuestLogEntry(i);
		
		-- here's a good place to create the objective list
		if (GetNumQuestLeaderBoards() > 0) then
			for ii = 1, GetNumQuestLeaderBoards(), 1 do
				--local string = _G["QuestLogObjective"..ii];
				local strLeaderBoardText, strType, iFinished = GetQuestLogLeaderBoard(ii);
				
				MonkeyQuest_AddQuestItemToList(strLeaderBoardText);
			end
		end
	end
	
	-- Restore the currently quest log selection
	SelectQuestLogEntry(tmpQuestLogSelection);
	
	-- kill it
	MonkeyQuest.m_aQuestList = nil;
end

function MonkeyQuestInit_ResetConfig()

	-- reset all the config variables to the defaults, but keep the hidden list intact
	MonkeyQuestConfig[MonkeyQuest.m_global].m_iAlpha = MONKEYQUEST_DEFAULT_ALPHA;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bNoBorder = MONKEYQUEST_DEFAULT_NOBORDER;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_iFontHeight = MONKEYQUEST_DEFAULT_FONTHEIGHT;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameWidth = MONKEYQUEST_DEFAULT_WIDTH;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bGrowUp = MONKEYQUEST_DEFAULT_GROWUP;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bObjectives = MONKEYQUEST_DEFAULT_OBJECTIVES; -- use overviews
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowNumQuests = MONKEYQUEST_DEFAULT_SHOWNUMQUESTS;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideCompletedQuests = MONKEYQUEST_DEFAULT_HIDECOMPLETEDQUESTS;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideCompletedObjectives = MONKEYQUEST_DEFAULT_HIDECOMPLETEDOBJECTIVES;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideTitleButtons = MONKEYQUEST_DEFAULT_HIDETITLEBUTTONS;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideTitle = MONKEYQUEST_DEFAULT_HIDETITLE;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bColourSubObjectivesByProgress = MONKEYQUEST_DEFAULT_COLOURSUBOBJECTIVES;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_iQuestPadding = MONKEYQUEST_DEFAULT_QUESTPADDING;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowZoneHighlight = MONKEYQUEST_DEFAULT_SHOWZONEHIGHLIGHT;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowQuestLevel = MONKEYQUEST_DEFAULT_SHOWQUESTLEVEL;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bWorkComplete = MONKEYQUEST_DEFAULT_WORKCOMPLETE;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_iFont = MONKEYQUEST_DEFAULT_FONT;
	
	MonkeyQuestConfig[MonkeyQuest.m_global].m_iHighlightAlpha = MONKEYQUEST_DEFAULT_HIGHLIGHT_ALPHA;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameAlpha = MONKEYQUEST_DEFAULT_FRAME_ALPHA;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameLeft = MONKEYQUEST_DEFAULT_LEFT;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameTop = MONKEYQUEST_DEFAULT_TOP;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameBottom = MONKEYQUEST_DEFAULT_BOTTOM;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bDisplay = MONKEYQUEST_DEFAULT_DISPLAY;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bDefaultAnchor = MONKEYQUEST_DEFAULT_DEFAULTANCHOR;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_strAnchor = MONKEYQUEST_DEFAULT_ANCHOR;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bMinimized = MONKEYQUEST_DEFAULT_MINIMIZED;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowHidden = MONKEYQUEST_DEFAULT_SHOWHIDDEN;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bNoHeaders = MONKEYQUEST_DEFAULT_NOHEADERS;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bAlwaysHeaders = MONKEYQUEST_DEFAULT_ALWAYSHEADERS;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowDailyNumQuests = MONKEYQUEST_DEFAULT_SHOWDAILYNUMQUESTS;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bLocked = MONKEYQUEST_DEFAULT_LOCKED;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bAllowRightClick = MONKEYQUEST_DEFAULT_ALLOWRIGHTCLICK;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowTooltipObjectives = MONKEYQUEST_DEFAULT_SHOWTOOLTIPOBJECTIVES;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bColourTitle = MONKEYQUEST_DEFAULT_COLOURTITLE;

	MonkeyQuestConfig[MonkeyQuest.m_global].m_bCrashBorder = MONKEYQUEST_DEFAULT_CRASHBORDER;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bItemsOnLeft = MONKEYQUEST_DEFAULT_ITEMSONLEFT;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideHeader = MONKEYQUEST_DEFAULT_HIDEHEADER;
	
	-- noob tips
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowNoobTips = MONKEYQUEST_DEFAULT_SHOWNOOBTIPS;

	-- colours
	MonkeyQuestConfig[MonkeyQuest.m_global].m_strQuestTitleColour = MONKEYQUEST_DEFAULT_QUESTTITLECOLOUR;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_strHeaderOpenColour = MONKEYQUEST_DEFAULT_HEADEROPENCOLOUR;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_strHeaderClosedColour = MONKEYQUEST_DEFAULT_HEADERCLOSEDCOLOUR;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_strOverviewColour = MONKEYQUEST_DEFAULT_OVERVIEWCOLOUR;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_strSpecialObjectiveColour = MONKEYQUEST_DEFAULT_SPECIALOBJECTIVECOLOUR;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_strMidObjectiveColour = MONKEYQUEST_DEFAULT_MIDOBJECTIVECOLOUR;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_strInitialObjectiveColour = MONKEYQUEST_DEFAULT_INITIALOBJECTIVECOLOUR;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_strCompleteObjectiveColour = MONKEYQUEST_DEFAULT_COMPLETEOBJECTIVECOLOUR;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_strFinishObjectiveColour = MONKEYQUEST_DEFAULT_FINISHOBJECTIVECOLOUR;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_strZoneHighlightColour = MONKEYQUEST_DEFAULT_ZONEHILIGHTCOLOUR;

	-- finally apply the settings
	MonkeyQuestInit_ApplySettings();
	
	MonkeyQuest_ShowDetailedControls();
end

-- This resets your config to make MonkeyQuest DaMaGepy Style
function MonkeyQuestInit_ResetConfigToDaMaGepyStyle()
	MonkeyQuestInit_ResetConfig();	
	-- apply DaMaGepy style
	MonkeyQuestConfig[MonkeyQuest.m_global].m_iAlpha = MONKEYQUEST_DEFAULT_ALPHA;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bNoBorder = MONKEYQUEST_DEFAULT_NOBORDER;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_iFontHeight = MONKEYQUEST_DEFAULT_FONTHEIGHT;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameWidth = MONKEYQUEST_DEFAULT_WIDTH;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bGrowUp = MONKEYQUEST_DEFAULT_GROWUP;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bObjectives = MONKEYQUEST_DEFAULT_OBJECTIVES; -- use overviews
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowNumQuests = MONKEYQUEST_DEFAULT_SHOWNUMQUESTS;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideCompletedQuests = MONKEYQUEST_DEFAULT_HIDECOMPLETEDQUESTS;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideCompletedObjectives = MONKEYQUEST_DEFAULT_HIDECOMPLETEDOBJECTIVES;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideTitleButtons = MONKEYQUEST_DEFAULT_HIDETITLEBUTTONS;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideTitle = MONKEYQUEST_DEFAULT_HIDETITLE;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bColourSubObjectivesByProgress = MONKEYQUEST_DEFAULT_COLOURSUBOBJECTIVES;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_iQuestPadding = MONKEYQUEST_DEFAULT_QUESTPADDING;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowZoneHighlight = MONKEYQUEST_DEFAULT_SHOWZONEHIGHLIGHT;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowQuestLevel = MONKEYQUEST_DEFAULT_SHOWQUESTLEVEL;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bWorkComplete = MONKEYQUEST_DEFAULT_WORKCOMPLETE;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_iFont = MONKEYQUEST_DEFAULT_FONT;
	-- finally apply the settings
	MonkeyQuestInit_ApplySettings();	
	MonkeyQuest_HideDetailedControls();
end


-- This resets your config to make MonkeyQuest look like the Blizzard quest tracker
function MonkeyQuestInit_ResetConfigToBlizzardStyle()
	MonkeyQuestInit_ResetConfig();
	
	-- apply blizzard style
	MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameAlpha = MONKEYQUEST_BLIZZARD_FRAME_ALPHA;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_iAlpha = MONKEYQUEST_BLIZZARD_ALPHA;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_iQuestPadding = MONKEYQUEST_BLIZZARD_QUESTPADDING;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowQuestLevel = MONKEYQUEST_BLIZZARD_SHOWQUESTLEVEL;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bObjectives = MONKEYQUEST_BLIZZARD_OBJECTIVES;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bNoBorder = MONKEYQUEST_BLIZZARD_NOBORDER;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowNumQuests = MONKEYQUEST_BLIZZARD_SHOWNUMQUESTS;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bWorkComplete = MONKEYQUEST_BLIZZARD_WORKCOMPLETE;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_strQuestTitleColour = MONKEYQUEST_BLIZZARD_QUESTTITLECOLOUR;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_strCompleteObjectiveColour = MONKEYQUEST_BLIZZARD_COMPLETEOBJECTIVECOLOUR;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_strFinishObjectiveColour = MONKEYQUEST_BLIZZARD_FINISHOBJECTIVECOLOUR;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_iFont = MONKEYQUEST_BLIZZARD_FONT;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bColourSubObjectivesByProgress = MONKEYQUEST_BLIZZARD_COLOURSUBOBJECTIVES;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bItemsOnLeft = MONKEYQUEST_BLIZZARD_ITEMSONLEFT;
	MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideHeader = MONKEYQUEST_BLIZZARD_HIDEHEADER;

	-- finally apply the settings
	MonkeyQuestInit_ApplySettings();
	
	MonkeyQuest_HideDetailedControls();
end

function MonkeyQuestInit_Font(iFont)

	MonkeyQuestConfig[MonkeyQuest.m_global].m_iFont = iFont;

	if (iFont == 0) then
		-- Default look
		
		-- change the fonts
		MonkeyQuestInit_SetButtonFonts(STANDARD_TEXT_FONT, MonkeyQuestConfig[MonkeyQuest.m_global].m_iFontHeight);
		--MonkeyQuestTitleText:SetFont("Fonts\\bLEI00D.TTF", MonkeyQuestConfig[MonkeyQuest.m_global].m_iFontHeight + 2);

	elseif ( iFont == 1 ) then 
		-- crash font
		
		--MonkeyQuestTitleText:SetFont("Interface\\AddOns\\MonkeyLibrary\\Fonts\\adventure.ttf", MonkeyQuestConfig[MonkeyQuest.m_global].m_iFontHeight + 2);
		MonkeyQuestInit_SetButtonFonts("Fonts\\bHEI01B.TTF", MonkeyQuestConfig[MonkeyQuest.m_global].m_iFontHeight);

	elseif ( iFont == 2 ) then
		-- Blizzard style
		
		MonkeyQuestInit_SetButtonFonts("Fonts\\bKAI00M.TTF", MonkeyQuestConfig[MonkeyQuest.m_global].m_iFontHeight);
	end

	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
	
	MonkeyQuest_Refresh();

end

function MonkeyQuestInit_Border(bCrashBorder)

	MonkeyQuestConfig[MonkeyQuest.m_global].m_bCrashBorder = bCrashBorder;

	if (bCrashBorder) then

		-- change the border colour
		MonkeyQuest.m_colourBorder.r = MONKEYQUEST_DEFAULT_CRASHCOLOUR.r;
		MonkeyQuest.m_colourBorder.g = MONKEYQUEST_DEFAULT_CRASHCOLOUR.g;
		MonkeyQuest.m_colourBorder.b = MONKEYQUEST_DEFAULT_CRASHCOLOUR.b;

	else
		-- Default look
		-- change the border colour
		MonkeyQuest.m_colourBorder.r = TOOLTIP_DEFAULT_COLOR.r;
		MonkeyQuest.m_colourBorder.g = TOOLTIP_DEFAULT_COLOR.g;
		MonkeyQuest.m_colourBorder.b = TOOLTIP_DEFAULT_COLOR.b;

	end

	-- set the border
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bNoBorder == true) then
		MonkeyQuestFrame:SetBackdropBorderColor(0.0, 0.0, 0.0, 0.0);
	else
		MonkeyQuestFrame:SetBackdropBorderColor(MonkeyQuest.m_colourBorder.r, MonkeyQuest.m_colourBorder.g, MonkeyQuest.m_colourBorder.b, 1.0);
	end

	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestInit_SetButtonFonts(strFontName, iFontHeight)

	local i = 0;

	-- set the font for all buttons
	for i = 1, MonkeyQuest.m_iNumQuestButtons, 1 do
		_G["MonkeyQuestButton" .. i .. "Text"]:SetFont(strFontName, iFontHeight);
	end
end

function MonkeyQuestInit_ApplySettings()

	-- init the look
	MonkeyQuestInit_Font(MonkeyQuestConfig[MonkeyQuest.m_global].m_iFont);
	MonkeyQuestInit_Border(MonkeyQuestConfig[MonkeyQuest.m_global].m_bCrashBorder);
	
	-- show or hide the main frame
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bDisplay == true) then
		MonkeyQuestFrame:Show();
	else
		MonkeyQuestFrame:Hide();
	end
	
	-- make sure the minimize button has the right texture
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bMinimized == true) then
		MonkeyQuestMinimizeButton:SetNormalTexture("Interface\\AddOns\\MonkeyLibrary\\Textures\\MinimizeButton-Down");
	else
		MonkeyQuestMinimizeButton:SetNormalTexture("Interface\\AddOns\\MonkeyLibrary\\Textures\\MinimizeButton-Up");
	end
	
	-- show or hide the title buttons
	MonkeyQuestSlash_CmdHideTitleButtons(MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideTitleButtons);
	
	-- set the alpha
	MonkeyQuest_SetAlpha(MonkeyQuestConfig[MonkeyQuest.m_global].m_iAlpha);
	MonkeyQuest_SetFrameAlpha(MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameAlpha);

	-- set the border
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bNoBorder == true) then
		MonkeyQuestFrame:SetBackdropBorderColor(0.0, 0.0, 0.0, 0.0);
	else
		MonkeyQuestFrame:SetBackdropBorderColor(MonkeyQuest.m_colourBorder.r, MonkeyQuest.m_colourBorder.g, MonkeyQuest.m_colourBorder.b, 1.0);
	end

	-- set the width
	MonkeyQuestFrame:SetWidth(MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameWidth);
	
	-- set the quest padding
	MonkeyQuestSlash_CmdSetQuestPadding(MonkeyQuestConfig[MonkeyQuest.m_global].m_iQuestPadding);
	
	-- finally refresh the quest list
	MonkeyQuest_Refresh();
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end