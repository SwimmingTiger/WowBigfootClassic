-- script variables not saved
MonkeyQuest = {};
MonkeyQuest.m_bLoaded = false;				-- true when the config variables are loaded
MonkeyQuest.m_bVariablesLoaded = false;
MonkeyQuest.m_iNumQuestButtons = 50;		-- 50 is the max possible entries in the quest log (25 quests and 25 different locations)
MonkeyQuest.m_iMaxTextWidth = 229;			-- wraps the text if it gets too long, mostly needed for objectives
MonkeyQuest.m_strPlayer = "";
MonkeyQuest.m_aQuestList = {};
MonkeyQuest.m_aQuestItemList = {};
MonkeyQuest.m_bGotQuestLogUpdate = false;
MonkeyQuest.m_bNeedRefresh = false;
MonkeyQuest.m_fTimeSinceRefresh = 0.0;
MonkeyQuest.m_bCleanQuestList = true;	-- used to clean up the hidden list on the first questlog update event
MonkeyQuest.m_setCorrectState = 1;
MQWATCHFRAME_NUM_ITEMS = 0;
MQWATCHFRAME_ITEM_WIDTH = 33;

MonkeyQuest.m_colourBorder = { r = TOOLTIP_DEFAULT_COLOR.r, g = TOOLTIP_DEFAULT_COLOR.g, b = TOOLTIP_DEFAULT_COLOR.b };

MonkeyQuestObjectiveTable = {};
MonkeyQuestAllowSounds = false

-- colors --
local CLRED = "|cFFFF8080"
local CLBLUE = "|cFF40FFFF"
local CCYAN = "|cFF68F8FF"
local CLGREEN = "|cFF80FF80"
local CLLGREEN = "|cFFAAFF88"
local CGRAY = "|cFF888888"

function MonkeyQuest_OnLoad(self)
    hooksecurefunc("HideUIPanel", MonkeyQuest_Refresh);
    hooksecurefunc(GameTooltip, "SetBagItem", YourSetBagItem);
    
    -- register events
    self:RegisterEvent('VARIABLES_LOADED');
    self:RegisterEvent('QUEST_LOG_UPDATE');			-- used to know when to refresh the MonkeyQuest text
    self:RegisterEvent('UNIT_NAME_UPDATE');			-- this is the event I use to get per character config settings
    self:RegisterEvent('PLAYER_ENTERING_WORLD');	-- this event gives me a good character name in situations where 'UNIT_NAME_UPDATE' doesn't even trigger
    self:RegisterEvent('PLAYER_LEVEL_UP');			-- when you level up the difficulty of some quests may change

	-- events when zone changes to update the zone highlighting quests
    self:RegisterEvent('ZONE_CHANGED');
	self:RegisterEvent('ZONE_CHANGED_INDOORS');
	self:RegisterEvent('ZONE_CHANGED_NEW_AREA');
    
    -- initialize the border and backdrop of the main frame
    --self:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
    --self:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b, 0);
    
    -- setup the title of the main frame
    MonkeyQuestTitleText:SetText(MONKEYQUEST_TITLE);
    MonkeyQuestTitleText:SetTextColor(MONKEYLIB_TITLE_COLOUR.r, MONKEYLIB_TITLE_COLOUR.g, MONKEYLIB_TITLE_COLOUR.b);
    MonkeyQuestTitleText:Show();
    
    MonkeyQuestSlash_Init();
    MonkeyQuestOptions();

    -- overide af tooltip functions
	MonkeyQuest_OLD_aftt_setName = aftt_setName;
	aftt_setName = MonkeyQuest_NEW_aftt_setName;
    
    -- this will catch mobs needed for quests (not needed anymore)
	-- self:RegisterEvent('UPDATE_MOUSEOVER_UNIT');
end

function MonkeyQuest_OnUpdate(self, elapsed)
	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end
	
	if (MonkeyQuest.m_setCorrectState == 1) then
		MonkeyQuest.m_setCorrectState = 0
		if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideHeader == true) then
			MonkeyQuest_HideDetailedControls();
		else
			MonkeyQuest_ShowDetailedControls();
		end
	end

	-- need to make sure we don't read from the quest list before a QUEST_LOG_UPDATE or we'll get the previous character's data
	if (MonkeyQuest.m_bGotQuestLogUpdate == false) then
		return;
	end

	-- update the timer
	MonkeyQuest.m_fTimeSinceRefresh = MonkeyQuest.m_fTimeSinceRefresh + elapsed;
	
	-- if it's been more than MONKEYQUEST_DELAY seconds and we need to process a dropped QUEST_LOG_UPDATE
	if (MonkeyQuest.m_fTimeSinceRefresh > MONKEYQUEST_DELAY and MonkeyQuest.m_bNeedRefresh == true) then
		MonkeyQuest_Refresh();
	end
	
	if (MonkeyQuest.m_bCleanQuestList == true) then
		if (MonkeyQuest.m_fTimeSinceRefresh > 15.0) then
			MonkeyQuestInit_CleanQuestList();
			MonkeyQuest.m_bCleanQuestList = false;
		end
	end
end

function MonkeyQuest_OnQuestLogUpdate()
	
	-- if everything's been loaded, refresh the Quest Monkey Display
	if (MonkeyQuest.m_bLoaded == true) then
		if (MonkeyQuest.m_bNeedRefresh == true) then
			-- don't process, let the OnUpdate catch it, but reset the timer
			MonkeyQuest.m_fTimeSinceRefresh = 0.0;
		else
			MonkeyQuest.m_bNeedRefresh = true;
			MonkeyQuest.m_fTimeSinceRefresh = 0.0;
		end
	end
end

-- OnEvent Function
function MonkeyQuest_OnEvent(self, event, ...)

    if (event == 'VARIABLES_LOADED') then
        -- this event gets called when the variables are loaded
        -- there's a possible situation where the other events might get a valid
        -- player name BEFORE this event, which resets your config settings :(
        
        MonkeyQuest.m_bVariablesLoaded = true;
        
        -- double check that the mod isn't already loaded
        if (not MonkeyQuest.m_bLoaded) then
        
            MonkeyQuest.m_strPlayer = UnitName('player');
            
            -- if MonkeyQuest.m_strPlayer is UNKNOWNOBJECT get out, need a real name
            if (MonkeyQuest.m_strPlayer ~= nil and MonkeyQuest.m_strPlayer ~= UNKNOWNOBJECT) then
                -- should have a valid player name here
                MonkeyQuestInit_LoadConfig();
            end
        end
        
        -- exit this event
        return;
    
    end -- VARIABLES_LOADED

    if (event == 'UNIT_NAME_UPDATE') then
        -- this event gets called whenever a unit's name changes (supposedly)
        -- Note: Sometimes it gets called when unit's name gets set to
        -- UNKNOWNOBJECT
        
        -- double check that the mod isn't already loaded
        if (not MonkeyQuest.m_bLoaded) then
            -- this is the first place I know that reliably gets the player name
            MonkeyQuest.m_strPlayer = UnitName('player');
            
            -- if MonkeyQuest.m_strPlayer is UNKNOWNOBJECT get out, need a real name
            if (MonkeyQuest.m_strPlayer ~= nil and MonkeyQuest.m_strPlayer ~= UNKNOWNOBJECT) then
                -- should have a valid player name here
                MonkeyQuestInit_LoadConfig();
            end
        end
        
        -- exit this event
        return;
    
    end -- UNIT_NAME_UPDATE

    if (event == 'PLAYER_ENTERING_WORLD') then
        -- this event gets called when the player enters the world
        -- Note: on initial login this event will not give a good player name

        -- double check that the mod isn't already loaded
        if (not MonkeyQuest.m_bLoaded) then
        
            MonkeyQuest.m_strPlayer = UnitName('player');

            -- if MonkeyQuest.m_strPlayer is UNKNOWNOBJECT get out, need a real name
            if (MonkeyQuest.m_strPlayer ~= nil and MonkeyQuest.m_strPlayer ~= UNKNOWNOBJECT) then
                -- should have a valid player name here
                MonkeyQuestInit_LoadConfig();
            end
        end
		-- My (damagepy's) custom init
        -- exit this event
        return;
    
    end -- PLAYER_ENTERING_WORLD

    if (event == 'QUEST_LOG_UPDATE') then
        MonkeyQuest.m_bGotQuestLogUpdate = true;
        MonkeyQuest_OnQuestLogUpdate();
        return;
    end -- QUEST_LOG_UPDATE

	if (event == 'ZONE_CHANGED' or event == 'ZONE_CHANGED_INDOORS' or event == 'ZONE_CHANGED_NEW_AREA') then
		MonkeyQuest_Refresh();
	end -- ZONE_CHANGED
	
	if (event == 'PLAYER_LEVEL_UP') then
		MonkeyQuest_Refresh();
	end -- PLAYER_LEVEL_UP
    
    if (event == 'TOOLTIP_ANCHOR_DEFAULT') then
    
        if (MonkeyQuest_SearchTooltip() == true) then
            GameTooltip:AddLine(MONKEYQUEST_TOOLTIP_QUESTITEM, MONKEYLIB_TITLE_COLOUR.r, MONKEYLIB_TITLE_COLOUR.g, MONKEYLIB_TITLE_COLOUR.b, 1);
            GameTooltip:SetHeight(GameTooltip:GetHeight() + 14);
        end
    end -- TOOLTIP_ANCHOR_DEFAULT

	--not needed anymore
    --if (event == 'UPDATE_MOUSEOVER_UNIT') then
    --    -- check if this is a quest item
    --    MonkeyQuest_SearchTooltip();
    --end -- UPDATE_MOUSEOVER_UNIT
end

-- this function is called when the frame should be dragged around
function MonkeyQuest_OnMouseDown(self, button)
	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end
	
	-- left button moves the frame around
	if (button == "LeftButton" and MonkeyQuestConfig[MonkeyQuest.m_global].m_bLocked == false) then
		MonkeyQuestFrame:StartMoving();
	end
	
	-- right button on the title or frame opens up the MonkeyBuddy, if it's there
	if (button == "RightButton" and MonkeyQuestConfig[MonkeyQuest.m_global].m_bAllowRightClick == true) then
		if (MonkeyBuddyFrame ~= nil) then
			MonkeyBuddy_ToggleDisplay()
		end
	end
end

-- this function is called when the frame is stopped being dragged around
function MonkeyQuest_OnMouseUp(self, button)
	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end
	
	if (button == "LeftButton") then
		MonkeyQuestFrame:StopMovingOrSizing();
		
		-- save the position
		MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameLeft = MonkeyQuestFrame:GetLeft();
		MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameTop = MonkeyQuestFrame:GetTop();
		MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameBottom = MonkeyQuestFrame:GetBottom();
	end
end

function MonkeyQuest_OnEnter()
	MonkeyQuest_ShowDetailedControls();
end

function MonkeyQuest_OnLeave()
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideHeader == true) then
		MonkeyQuest_HideDetailedControls();
	end
end

-- wraith:
function MonkeyQuest_ShowDetailedControls()
	MonkeyQuestTitleText:Show();
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideTitleButtons == false) then
		MonkeyQuestMinimizeButton:Show();
		MonkeyQuestCloseButton:Show();
		MonkeyQuestShowHiddenCheckButton:Show();
	end
end

-- wraith:
function MonkeyQuest_HideDetailedControls()
	MonkeyQuestTitleText:Hide();
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideTitleButtons == false) then
		MonkeyQuestMinimizeButton:Hide();
		MonkeyQuestCloseButton:Hide();
		MonkeyQuestShowHiddenCheckButton:Hide();
	end
end

function MonkeyQuestCloseButton_OnClick()

	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	MonkeyQuest_Hide();
end

function MonkeyQuestCloseButton_OnEnter(self, motion)
	-- no noob tip?
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowNoobTips == false) then
		return;
	end

	-- put the tool tip in the default position
	GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT");

	-- set the tool tip text
	GameTooltip:SetText(MONKEYQUEST_NOOBTIP_HEADER, TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 1);
	GameTooltip:AddLine(MONKEYQUEST_NOOBTIP_CLOSE, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	GameTooltip:AddLine(MONKEYQUEST_HELP_OPEN_MSG, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);


	GameTooltip:Show();
end

function MonkeyQuestMinimizeButton_OnClick()

	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	MonkeyQuestConfig[MonkeyQuest.m_global].m_bMinimized = not MonkeyQuestConfig[MonkeyQuest.m_global].m_bMinimized;
	
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bMinimized == true) then
		MonkeyQuestMinimizeButton:SetNormalTexture("Interface\\AddOns\\MonkeyLibrary\\Textures\\MinimizeButton-Down");
	else
		MonkeyQuestMinimizeButton:SetNormalTexture("Interface\\AddOns\\MonkeyLibrary\\Textures\\MinimizeButton-Up");
	end
	
	MonkeyQuest_Refresh();
end

function MonkeyQuestMinimizeButton_OnEnter(self, motion)
	-- no noob tip?
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowNoobTips == false) then
		return;
	end

	-- put the tool tip in the default position
	GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT");

	-- set the tool tip text
	GameTooltip:SetText(MONKEYQUEST_NOOBTIP_HEADER, TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 1);
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bMinimized) then
		GameTooltip:AddLine(MONKEYQUEST_NOOBTIP_RESTORE, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	else
		GameTooltip:AddLine(MONKEYQUEST_NOOBTIP_MINIMIZE, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	end

	GameTooltip:Show();
end

function MonkeyQuestShowHiddenCheckButton_OnClick(self, button, down)

	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	if (self:GetChecked()) then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowHidden = true;
	else
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
		MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowHidden = false;
	end

	if (MonkeyBuddyFrame ~= nil) then
		MonkeyBuddyQuestCheck2:SetChecked(MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowHidden)
	end

	MonkeyQuest_Refresh();
end

function MonkeyQuestShowHiddenCheckButton_OnEnter(self, motion)

	-- no noob tip?
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowNoobTips == false) then
		return;
	end

	-- put the tool tip in the default position
	GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT");

	-- set the tool tip text
	GameTooltip:SetText(MONKEYQUEST_NOOBTIP_HEADER, TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 1);
	if (self:GetChecked()) then
		GameTooltip:AddLine(MONKEYQUEST_NOOBTIP_HIDEALLHIDDEN, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	else
		GameTooltip:AddLine(MONKEYQUEST_NOOBTIP_SHOWALLHIDDEN, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	end

	GameTooltip:Show();
end

function MonkeyQuest_Show()

	MonkeyQuestConfig[MonkeyQuest.m_global].m_bDisplay = true;
	MonkeyQuestFrame:Show();
	MonkeyQuest_Refresh();
end

function MonkeyQuest_Hide()

	MonkeyQuestConfig[MonkeyQuest.m_global].m_bDisplay = false;
	MonkeyQuestFrame:Hide();
end

function MonkeyQuest_SetAlpha(iAlpha)

	MonkeyQuestConfig[MonkeyQuest.m_global].m_iAlpha = iAlpha;
	MonkeyQuestFrame:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b, iAlpha);

	--MonkeyQuestFrame:SetAlpha(0.5);

	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuest_SetFrameAlpha(iAlpha)

	-- wraith:
	--MonkeyQuestFrame:SetAlpha(iAlpha);
	MonkeyQuestFrame:SetAlpha(1.0);
	
	MonkeyQuestTitleButton:SetAlpha( iAlpha );
	MonkeyQuestCloseButton:SetAlpha( iAlpha );
	MonkeyQuestMinimizeButton:SetAlpha( iAlpha );
	MonkeyQuestShowHiddenCheckButton:SetAlpha( iAlpha );
	for i = 1, MonkeyQuest.m_iNumQuestButtons, 1 do
		_G["MonkeyQuestButton" .. i]:SetAlpha( iAlpha );
		_G["MonkeyQuestHideButton" .. i]:SetAlpha( iAlpha );
	end
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuest_SetHighlightAlpha(iAlpha)

	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowZoneHighlight) then
		MonkeyQuest_Refresh();
	end

	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuest_Refresh(MBDaily)

	-- if not loaded yet, get outta here
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end
	
	if (MBDaily ~= nil) then
		if (MBDaily == 1) then
			MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowDailyNumQuests = true
		elseif (MBDaily == 0) then
			MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowDailyNumQuests = false
		end
	end
	
	-- set the check state of the MonkeyQuestShowHiddenCheckButton
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowHidden == true) then
		MonkeyQuestShowHiddenCheckButton:SetChecked(true);
	else
		MonkeyQuestShowHiddenCheckButton:SetChecked(false);
	end
	
	-- make sure the minimize button has the right texture
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bMinimized == true) then
		MonkeyQuestMinimizeButton:SetNormalTexture("Interface\\AddOns\\MonkeyLibrary\\Textures\\MinimizeButton-Down");
	else
		MonkeyQuestMinimizeButton:SetNormalTexture("Interface\\AddOns\\MonkeyLibrary\\Textures\\MinimizeButton-Up");
	end
	
	local strMonkeyQuestBody = "";
	local colour;
	local strTitleColor;
	local iButtonId = 1;
	local bNextHeader = false;
	
	local objectiveDesc, objectiveType, objectiveComplete;
	local j, k, objectiveName, objectiveNumItems, objectiveNumNeeded;
	
	if (MonkeyQuestObjectiveTable == nil) then
		MonkeyQuestObjectiveTable = {};
	end
	
	if (MonkeyQuestTitleTable == nil) then
		MonkeyQuestTitleTable = {};
	end
	
	-- Remember the currently selected quest log entry
	local tmpQuestLogSelection = GetQuestLogSelection();

	local iNumEntries, iNumQuests = GetNumQuestLogEntries();
	
	local DQCompleted = 0;--GetDailyQuestsCompleted();
	local DQMax;
	
	local v, b, d, t = GetBuildInfo();
	
	if (t >= 50000) then
		DQMax = " Dailies"
	else
		DQMax = "/ 0";
	end

	MonkeyQuestTitleText:SetTextHeight(MonkeyQuestConfig[MonkeyQuest.m_global].m_iFontHeight + 2);
	-- set the title, with or without the number of quests

		if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowNumQuests == true) then
			if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideTitle == false) then
				if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowDailyNumQuests == false) then
					MonkeyQuestTitleText:SetText(MONKEYQUEST_TITLE .. " " .. iNumQuests .. "/" .. MAX_QUESTLOG_QUESTS);
				else
					MonkeyQuestTitleText:SetText(MONKEYQUEST_TITLE .. " " .. iNumQuests .. "/" .. MAX_QUESTLOG_QUESTS .. " (" .. DQCompleted .. DQMax .. ")");
				end
			else
				if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowDailyNumQuests == false) then
					MonkeyQuestTitleText:SetText(iNumQuests .. "/" .. MAX_QUESTLOG_QUESTS);
				else
					MonkeyQuestTitleText:SetText(iNumQuests .. "/" .. MAX_QUESTLOG_QUESTS .. " (" .. DQCompleted .. DQMax .. ")");
				end
			end
		elseif (MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideTitle == false) then
			if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowDailyNumQuests == false) then
				MonkeyQuestTitleText:SetText(MONKEYQUEST_TITLE);
			else
				MonkeyQuestTitleText:SetText(MONKEYQUEST_TITLE .. " (" .. DQCompleted .. DQMax .. ")");
			end
		else
			if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowDailyNumQuests == false) then
				MonkeyQuestTitleText:SetText("");
			else
				MonkeyQuestTitleText:SetText("(" .. DQCompleted .. DQMax .. ")");
			end
		end

	MonkeyQuest.m_iNumEntries = iNumEntries;

	-- hide all the text buttons
	for i = 1, MonkeyQuest.m_iNumQuestButtons, 1 do
		_G["MonkeyQuestButton" .. i .. "Text"]:SetText("");
		_G["MonkeyQuestButton" .. i .. "Text"]:Hide();
		_G["MonkeyQuestButton" .. i]:Hide();
		_G["MonkeyQuestHideButton" .. i]:Hide();
		_G["MonkeyQuestButton" .. i .. "Text"]:SetWidth(MonkeyQuestFrame:GetWidth() - MONKEYQUEST_PADDING - 8);
		_G["MonkeyQuestButton" .. i .. "Text"]:SetTextHeight(MonkeyQuestConfig[MonkeyQuest.m_global].m_iFontHeight);
	end


	MonkeyQuest_RefreshQuestItemList();

	local watchItemIndex = 0;

	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bMinimized == false) then

		for i = 1, iNumEntries, 1 do
			-- strQuestLogTitleText		the title text of the quest, may be a header (ex. Wetlands)
			-- strQuestLevel			the level of the quest
			-- strQuestTag				the tag on the quest (ex. COMPLETED)
			local strQuestLogTitleText, strQuestLevel, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID = GetQuestLogTitle(i);
			
			-- are we looking for the next header?
			if (bNextHeader == true and isHeader) then
				-- no longer skipping quests
				bNextHeader = false;
			end
			
			if (bNextHeader == false) then
				-- no longer looking for the next header
				-- Select the quest log entry for other functions like GetNumQuestLeaderBoards()
				SelectQuestLogEntry(i);
				
				-- since 4.0.1 some strQuestLogTitleText are nil
				if (strQuestLogTitleText == nil) then
					strQuestLogTitleText = MONKEYQUEST_NO_HEADER
				end
				
				-- double check this quest is in the hidden list, if not, it's a new quest
				if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText.." - "..tostring(isHeader)] == nil) then
					MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText.." - "..tostring(isHeader)] = {};
					MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText.." - "..tostring(isHeader)].m_bChecked = true;
				end
					
				if (isHeader) then
					
					if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText.." - "..tostring(isHeader)].m_bChecked == true) then
						if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bNoHeaders == false or
							MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowHidden == true or
							MonkeyQuestConfig[MonkeyQuest.m_global].m_bAlwaysHeaders == true) then

							strMonkeyQuestBody = strMonkeyQuestBody .. 
								format(MonkeyQuestConfig[MonkeyQuest.m_global].m_strHeaderOpenColour .. "%s|r",
									"- " .. strQuestLogTitleText) .. "\n";
								
							_G["MonkeyQuestButton" .. iButtonId .. "Text"]:SetText(strMonkeyQuestBody);
							_G["MonkeyQuestButton" .. iButtonId .. "Text"]:Show();
							_G["MonkeyQuestButton" .. iButtonId]:Show();

							-- set the bg colour
							_G["MonkeyQuestButton" .. iButtonId .. "Texture"]:SetVertexColor(0.0, 0.0, 0.0, 0.0);
			
							_G["MonkeyQuestButton" .. iButtonId].m_iQuestIndex = i;
							_G["MonkeyQuestButton" .. iButtonId].id = iButtonId;
			
							_G["MonkeyQuestHideButton" .. iButtonId]:Hide();
							_G["MonkeyQuestHideButton" .. iButtonId].m_strQuestLogTitleText = strQuestLogTitleText.." - "..tostring(isHeader);
							
							iButtonId = iButtonId + 1;
			
							strMonkeyQuestBody = "";
						end
					else
						if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowHidden == true or
							MonkeyQuestConfig[MonkeyQuest.m_global].m_bAlwaysHeaders == true) then

							strMonkeyQuestBody = strMonkeyQuestBody .. 
								format(MonkeyQuestConfig[MonkeyQuest.m_global].m_strHeaderClosedColour .. "%s|r",
									"+ " .. strQuestLogTitleText) .. "\n";
								
							_G["MonkeyQuestButton" .. iButtonId .. "Text"]:SetText(strMonkeyQuestBody);
							_G["MonkeyQuestButton" .. iButtonId .. "Text"]:Show();
							_G["MonkeyQuestButton" .. iButtonId]:Show();

							-- set the bg colour
							_G["MonkeyQuestButton" .. iButtonId .. "Texture"]:SetVertexColor(0.0, 0.0, 0.0, 0.0);
			
							_G["MonkeyQuestButton" .. iButtonId].m_iQuestIndex = i;
							_G["MonkeyQuestButton" .. iButtonId].id = iButtonId;
							
							_G["MonkeyQuestHideButton" .. iButtonId]:Hide();
							_G["MonkeyQuestHideButton" .. iButtonId].m_strQuestLogTitleText = strQuestLogTitleText.." - "..tostring(isHeader);
			
							iButtonId = iButtonId + 1;
			
							strMonkeyQuestBody = "";
						end
						-- keep looping through the list until we find the next header
						bNextHeader = true;
					end
				else
					-- check if the user even wants this displayed
					if ((MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText.." - "..tostring(isHeader)].m_bChecked == true or 
						MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowHidden) and 
						(MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideCompletedQuests == false or
						(MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideCompletedQuests == true and not isComplete) or
						MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowHidden)) then
						
						-- the user has this quest checked off or he's showing all quests anyways, so we show it
						if ( MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowHidden ) then
							_G["MonkeyQuestHideButton" .. iButtonId]:Show();
						else
							_G["MonkeyQuestHideButton" .. iButtonId]:Hide();
						end
						
						-- update hide quests buttons
						if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText.." - "..tostring(isHeader)].m_bChecked == true) then
							_G["MonkeyQuestHideButton" .. iButtonId]:SetChecked(true);
						else
							_G["MonkeyQuestHideButton" .. iButtonId]:SetChecked(false);
						end
						
						_G["MonkeyQuestHideButton" .. iButtonId].m_strQuestLogTitleText = strQuestLogTitleText.." - "..tostring(isHeader);
						


						colour = GetQuestDifficultyColor(strQuestLevel);

						-- Begin Pkp Changes
						if(MonkeyQuestConfig[MonkeyQuest.m_global].m_bColourTitle) then
							strTitleColor = format("|c%02X%02X%02X%02X", 255, colour.r * 255, colour.g * 255, colour.b * 255);
						else
							strTitleColor = MonkeyQuestConfig[MonkeyQuest.m_global].m_strQuestTitleColour;
						end
						
						-- padding
						strMonkeyQuestBody = strMonkeyQuestBody .. "  ";
						
						-- check if the user wants the quest levels
						if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowQuestLevel == true) then
							local chars = ""
							local tagID, tagName = GetQuestTagInfo(questID);
							if ( tagName ) then
								if ( tagID == QUEST_TAG_GROUP) then
									chars = "G"
								elseif ( tagID == QUEST_TAG_PVP) then
									chars = "P"
								elseif ( tagID == QUEST_TAG_RAID) then
									chars = "R"
								elseif ( tagID == QUEST_TAG_DUNGEON) then
									chars = "D"
								elseif ( tagID == QUEST_TAG_LEGENDARY) then
									chars = "L"
								elseif ( tagID == QUEST_TAG_HEROIC) then
									chars = "H"
								elseif ( tagID == QUEST_TAG_RAID10) then
									chars = "R"
								elseif ( tagID == QUEST_TAG_RAID25) then
									chars = "R"
								elseif ( tagID == QUEST_TAG_SCENARIO) then
									chars = "S"
								elseif ( tagID == QUEST_TAG_ACCOUNT) then
									chars = "A"
								end
							end
							
							--[[
							if suggestedGroup and suggestedGroup > 1 then	
								chars = chars .. suggestedGroup
							end
							
							if ( frequency == LE_QUEST_FREQUENCY_DAILY ) then
								chars = chars.."*"
							elseif ( frequency == LE_QUEST_FREQUENCY_WEEKLY ) then
								chars = chars.."**"
							end
							]]--
							strMonkeyQuestBody = strMonkeyQuestBody ..
								format("|c%02X%02X%02X%02X%s|r", 255, colour.r * 255, colour.g * 255, colour.b * 255,
									"["..strQuestLevel..chars.."] ");
							
						end

						-- add the completed/failed tag, if needed
						local strTitleFailColor = "|cFF995555"
						local strTitleDoneColor = "|cFF22AA22"
						if (isComplete and isComplete < 0) then
							strMonkeyQuestBody = strMonkeyQuestBody .. 
								format(strTitleFailColor .. "%s|r", strQuestLogTitleText) .. CLRED..
								" (" .. MONKEYQUEST_QUEST_FAILED .. ")\n";
						elseif (isComplete and isComplete > 0) then
							strMonkeyQuestBody = strMonkeyQuestBody ..
								format(strTitleDoneColor .. "%s|r", strQuestLogTitleText) .. CLGREEN..
								" (" .. MONKEYQUEST_QUEST_DONE .. ")\n";
						else
							strMonkeyQuestBody = strMonkeyQuestBody ..
								format(strTitleColor .. "%s|r", strQuestLogTitleText) .. "\n";
						end							

						

						local strQuestDescription, strQuestObjectives = GetQuestLogQuestText();
						
						-- wraith: item
						--[[
						local link, item, charges, showItemWhenComplete = GetQuestLogSpecialItemInfo(i);
						if (item and (not isQuestComplete or showItemWhenComplete) and MonkeyQuestConfig[MonkeyQuest.m_global].m_bItemsEnabled == true) then
							watchItemIndex = watchItemIndex + 1;
							local itemButton = _G["MQWatchFrameItem"..watchItemIndex];
							if ( not itemButton ) then
								MQWATCHFRAME_NUM_ITEMS = watchItemIndex;
								itemButton = CreateFrame("BUTTON", "MQWatchFrameItem" .. watchItemIndex, _G["MonkeyQuestFrame"], "QuestObjectiveItemButtonTemplate");
								--SecureActionButtonTemplate
							end

							itemButton.questLogIndex = i;
							itemButton.charges = charges;
							itemButton.rangeTimer = -1;
							SetItemButtonTexture(itemButton, item);
							SetItemButtonCount(itemButton, charges);
							QuestObjectiveItem_UpdateCooldown(itemButton);
							
							--itemButton:SetAttribute("type","item")
							--itemButton:SetAttribute("item",link)
							
							itemButton:ClearAllPoints();
							if ( MonkeyQuestConfig[MonkeyQuest.m_global].m_bItemsOnLeft == true ) then
								if ( MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowHidden == true ) then
									itemButton:SetPoint( "TOPRIGHT", _G["MonkeyQuestHideButton" .. iButtonId], "TOPLEFT", -12, 0);
								else
									itemButton:SetPoint( "TOPRIGHT", _G["MonkeyQuestButton" .. iButtonId], "TOPLEFT" );
								end
							else
								itemButton:SetPoint( "TOPLEFT", _G["MonkeyQuestButton" .. iButtonId], "TOPRIGHT", 12, 0);
							end
							itemButton:SetScale(0.7)
							itemButton:Show();
						end
		]]--
						local strQuestDescription, strQuestObjectives = GetQuestLogQuestText();
						-- DaMaGepy
						if (GetNumQuestLeaderBoards() > 0) then
							for ii=1, GetNumQuestLeaderBoards(), 1 do
								--local string = getglobal("QuestLogObjective"..ii);
								local strLeaderBoardText, strType, iFinished = GetQuestLogLeaderBoard(ii);
								
								MonkeyQuest_AddQuestItemToList(strLeaderBoardText); 
								
								if (strLeaderBoardText) then -- Gepy
									if (not iFinished) then
										strMonkeyQuestBody = strMonkeyQuestBody .. "    " .. MonkeyQuest_GetLeaderboardColorStr(strLeaderBoardText) .. 
											strLeaderBoardText .. "\n";
									elseif (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bHideCompletedObjectives == false
										or MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowHidden) then
										local gqcolor = MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strCompleteObjectiveColour;
										gqcolor = CLLGREEN; --CCYAN;
										strMonkeyQuestBody = strMonkeyQuestBody .. "    " .. 
											gqcolor .. 
											strLeaderBoardText .. "\n";
									end
								end
							end

							-- Work Complete
							if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bWorkComplete == true and strQuestLogTitleText ~= nil) then							
								for ii = 1, GetNumQuestLeaderBoards(), 1 do
									objectiveDesc, objectiveType, objectiveComplete = GetQuestLogLeaderBoard(ii);
									if (objectiveType == "item" or objectiveType == "monster" or objectiveType == "object") then
										if(GetLocale() == "enUS") then
											j, k, objectiveNumItems, objectiveNumNeeded, objectiveName = string.find(objectiveDesc, "([-%d]+)/([-%d]+)%s*(.*)$");
										else
											j, k, objectiveName, objectiveNumItems, objectiveNumNeeded = string.find(objectiveDesc, "(.*):%s*([-%d]+)%s*/%s*([-%d]+)%s*$");
										end										
										if (objectiveName ~= nil and objectiveName ~= "  slain" and objectiveName ~= " ") then										
											local currentObjectiveName = strQuestLogTitleText .. objectiveName;										
											if (MonkeyQuestObjectiveTable[currentObjectiveName] == nil) then
												MonkeyQuestObjectiveTable[currentObjectiveName] = false
											end
											if (objectiveComplete == true and MonkeyQuestObjectiveTable[currentObjectiveName] == false and MonkeyQuestAllowSounds == true) then
												if (isComplete and isComplete > 0) then
													PlaySoundFile("Sound\\Creature\\Peon\\PeonBuildingComplete1.ogg");
												else
													--PlaySoundFile("Sound\\Creature\\Peasant\\PeasantWhat3.ogg");
												end
											end
											MonkeyQuestObjectiveTable[currentObjectiveName] = objectiveComplete
										end
									elseif (objectiveType == "event") then
										if (objectiveDesc ~= nil) then										
											local currentObjectiveDesc = strQuestLogTitleText .. objectiveDesc;										
											if (MonkeyQuestObjectiveTable[currentObjectiveDesc] == nil) then
												MonkeyQuestObjectiveTable[currentObjectiveDesc] = false;
											end
											if (objectiveComplete == true and MonkeyQuestObjectiveTable[currentObjectiveDesc] == false and MonkeyQuestAllowSounds == true) then
												if (isComplete and isComplete > 0) then
													PlaySoundFile("Sound\\Creature\\Peon\\PeonBuildingComplete1.ogg");
												else
													--PlaySoundFile("Sound\\Creature\\Peasant\\PeasantWhat3.ogg");
												end
											end
											MonkeyQuestObjectiveTable[currentObjectiveDesc] = objectiveComplete
										end
									end
								end
							end












						else --if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bObjectives) then    -- DaMaGepy    /script ReloadUI();
							-- this quest has no leaderboard so display the objective instead if the config is set
			
							strMonkeyQuestBody = strMonkeyQuestBody .. "    " .. 
								--gqcolor ..
								CGRAY
								--format(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strOverviewColour .. "%s|r",
									.. strQuestObjectives .. "\n"
									;
								--format("|c%02X%02X%02X%02X%s|r", 255, GRAY_FONT_COLOR.r * 255, GRAY_FONT_COLOR.g * 255, 
								--GRAY_FONT_COLOR.b * 255, strQuestObjectives) .. "\n";
						end
						
						--[[ -- DaMaGepy original start
						if (GetNumQuestLeaderBoards() > 0) then
							for ii=1, GetNumQuestLeaderBoards(), 1 do
								--local string = _G["QuestLogObjective"..ii];
								local strLeaderBoardText, strType, iFinished = GetQuestLogLeaderBoard(ii);
								
								MonkeyQuest_AddQuestItemToList(strLeaderBoardText);
								
								if (strLeaderBoardText) then
									if (not iFinished) then
										if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bColourSubObjectivesByProgress == true) then
											strMonkeyQuestBody = strMonkeyQuestBody .. "    " .. MonkeyQuest_GetLeaderboardColorStr(strLeaderBoardText) .. strLeaderBoardText .. "\n";
										else
											strMonkeyQuestBody = strMonkeyQuestBody .. "    " .. strLeaderBoardText .. "\n";
										end
									elseif (MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideCompletedObjectives == false
										or MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowHidden) then
										strMonkeyQuestBody = strMonkeyQuestBody .. "    " .. 
											MonkeyQuestConfig[MonkeyQuest.m_global].m_strFinishObjectiveColour ..
											strLeaderBoardText .. "\n";
									end
								end
							end
							
							

						elseif (MonkeyQuestConfig[MonkeyQuest.m_global].m_bObjectives) then
							-- this quest has no leaderboard so display the objective instead if the config is set
			
							strMonkeyQuestBody = strMonkeyQuestBody .. "    " .. 
								format(MonkeyQuestConfig[MonkeyQuest.m_global].m_strOverviewColour .. "%s|r",
									strQuestObjectives) .. "\n";
								--format("|c%02X%02X%02X%02X%s|r", 255, GRAY_FONT_COLOR.r * 255, GRAY_FONT_COLOR.g * 255, 
								--GRAY_FONT_COLOR.b * 255, strQuestObjectives) .. "\n";
						end
						]]--
						
						-- finally set the text
						_G["MonkeyQuestButton" .. iButtonId .. "Text"]:SetText(strMonkeyQuestBody);
						_G["MonkeyQuestButton" .. iButtonId .. "Text"]:Show();
						_G["MonkeyQuestButton" .. iButtonId]:Show();

						-- set the bg colour
						_G["MonkeyQuestButton" .. iButtonId .. "Texture"]:SetVertexColor(0.0, 0.0, 0.0, 0.0);

						if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowZoneHighlight) then
							local strSubZoneText = string.lower(GetSubZoneText());
	
							if (strSubZoneText ~= "") then
								if (string.find(string.lower(strQuestDescription), strSubZoneText, 1, true) or 
									string.find(string.lower(strQuestObjectives), strSubZoneText, 1, true)) then
	
									local a, r, g, b = MonkeyLib_ColourStrToARGB(MonkeyQuestConfig[MonkeyQuest.m_global].m_strZoneHighlightColour);
									-- damagepy black background
									r,g,b = 0,0,0;
									
									-- _G["MonkeyQuestButton" .. iButtonId .. "Texture"]:SetVertexColor(r, g, b, MonkeyQuestConfig[MonkeyQuest.m_global].m_iAlpha);
									_G["MonkeyQuestButton" .. iButtonId .. "Texture"]:SetVertexColor(r, g, b, 0.3); -- m_iHighlightAlpha /script ReloadUI();
								end
							end
						end

			
						_G["MonkeyQuestButton" .. iButtonId].m_iQuestIndex = i;
						_G["MonkeyQuestButton" .. iButtonId].m_strQuestObjectives = strQuestObjectives;
			
						iButtonId = iButtonId + 1;
			
						strMonkeyQuestBody = "";
					end
				end
			end
			-- this prevents the "stacked" complete sound after login/loading screen
			if (i == iNumEntries) then
				MonkeyQuestAllowSounds = true
			end
		end
	end

	
	for i = 1, MonkeyQuest.m_iNumQuestButtons, 1 do
		_G["MonkeyQuestButton" .. i .. "Text"]:SetWidth(MonkeyQuestFrame:GetWidth() - MONKEYQUEST_PADDING - 8);
	end
	
	for i = watchItemIndex + 1, MQWATCHFRAME_NUM_ITEMS do
		_G["MQWatchFrameItem" .. i]:Hide();
	end
	
	-- Restore the current quest log selection
	SelectQuestLogEntry(tmpQuestLogSelection);
	
	MonkeyQuest_Resize();
	-- we don't have a dropped QUEST_LOG_UPDATE anymore
	MonkeyQuest.m_bNeedRefresh = false;
	MonkeyQuest.m_fTimeSinceRefresh = 0.0;
end

function MonkeyQuest_RefreshQuestItemList()

	local strQuestLogTitleText, strQuestLevel, strQuestTag, suggestedGroup, isHeader, isCollapsed, isComplete;
	local i;
	local iNumEntries, iNumQuests = GetNumQuestLogEntries();


	MonkeyQuest.m_aQuestItemList = nil;
	MonkeyQuest.m_aQuestItemList = {};

	for i = 1, iNumEntries, 1 do
		-- strQuestLogTitleText		the title text of the quest, may be a header (ex. Wetlands)
		-- strQuestLevel			the level of the quest
		-- strQuestTag				the tag on the quest (ex. COMPLETED)
		strQuestLogTitleText, strQuestLevel, suggestedGroup, isHeader, isCollapsed, isComplete = GetQuestLogTitle(i);
		
		if (not isHeader) then
			-- Select the quest log entry for other functions like GetNumQuestLeaderBoards()
			SelectQuestLogEntry(i);

			if (GetNumQuestLeaderBoards() > 0) then
				for ii=1, GetNumQuestLeaderBoards(), 1 do
					--local string = _G["QuestLogObjective"..ii];
					local strLeaderBoardText, strType, iFinished = GetQuestLogLeaderBoard(ii);
					
					MonkeyQuest_AddQuestItemToList(strLeaderBoardText);

				end
			end
		end
	end
end

-- does a decent job of figuring out if the quest objective is an item and if so adds it to the list
function MonkeyQuest_AddQuestItemToList(strLeaderBoardText)
	if (not strLeaderBoardText) then
		return;
	end
	
	local i, j, iNumItems, iNumNeeded, strItemName;
	
	if(GetLocale() == "enUS") then
		i, j, iNumItems, iNumNeeded, strItemName = string.find(strLeaderBoardText, "([-%d]+)/([-%d]+)%s*(.*)$");
	else
		i, j, strItemName, iNumItems, iNumNeeded = string.find(strLeaderBoardText, "(.*):%s*([-%d]+)%s*/%s*([-%d]+)%s*$");
	end
	
	if (iNumItems == nil) then
		-- not a quest item
		return;
	end

	i, j = string.find(strItemName, MONKEYQUEST_TOOLTIP_SLAIN);

	if (i ~= nil) then
		strItemName = string.sub(strItemName, 1, i - 2);
	end
	
	if (MonkeyQuest.m_aQuestItemList[strItemName] == nil) then
		MonkeyQuest.m_aQuestItemList[strItemName] = {};
	end
	
	MonkeyQuest.m_aQuestItemList[strItemName].m_iNumItems = iNumItems;
	MonkeyQuest.m_aQuestItemList[strItemName].m_iNumNeeded = iNumNeeded;
end

function MonkeyQuest_Resize()
	
	local iHeight = 0;
	local text;
	local button;
	local iTextWidth = 0;
	local iPadding = MonkeyQuestConfig[MonkeyQuest.m_global].m_iQuestPadding;

	
	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	--iTextWidth = MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameWidth - MONKEYQUEST_PADDING - 8;
	iTextWidth = MonkeyQuestFrame:GetWidth() - MONKEYQUEST_PADDING - 8;

	-- make sure the titlebutton is the right size for the title text
	MonkeyQuestTitleButton:SetWidth(MonkeyQuestTitleText:GetWidth());
	MonkeyQuestTitleButton:SetHeight(MonkeyQuestTitleText:GetHeight());

	for i = 1, MonkeyQuest.m_iNumQuestButtons, 1 do
		text = _G["MonkeyQuestButton" .. i .. "Text"];
		button = _G["MonkeyQuestButton" .. i];
		
		if (text:IsVisible()) then
			text:SetWidth(iTextWidth);

			iHeight = iHeight + text:GetHeight() - 10 + iPadding;
			
			button:SetWidth(text:GetWidth());
			button:SetHeight(text:GetHeight() - 10);
		end
	end

	iHeight = iHeight + MonkeyQuestTitleText:GetHeight() + MONKEYQUEST_PADDING;
	
	--MonkeyQuestFrame:SetWidth(MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameWidth);
	MonkeyQuestFrame:SetHeight(iHeight);
	
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameLeft == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameLeft = GetScreenWidth() - MONKEYQUEST_DEFAULT_WIDTH + 10;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameTop == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameTop = GetScreenHeight() - 200;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameBottom == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameBottom = 539;
	end
	


	-- Set the grow direction
	-- Added by Diungo
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bGrowUp == false) then
		MonkeyQuestFrame:ClearAllPoints();
		-- grow down
		MonkeyQuestFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT",
			MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameLeft,
			MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameTop);

		-- check to see if it grew off the screen
		--if (MonkeyQuestFrame:GetBottom() < 0) then
		--	MonkeyQuestFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT",
		--	MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameLeft,
		--	MonkeyQuestFrame:GetHeight() - 2);
		--end
	else
		MonkeyQuestFrame:ClearAllPoints();
		-- grow up
		MonkeyQuestFrame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT",
			MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameLeft,
			MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameBottom);

		-- check to see if it grew off the screen
		--if (MonkeyQuestFrame:GetTop() > 1024) then
		--	MonkeyQuestFrame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT",
		--	MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameLeft,
		--	1024 - (MonkeyQuestFrame:GetHeight() - 2));
		--end
	end

	-- save the position
	if (MonkeyQuestFrame:GetLeft() ~= nil) then
		MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameLeft = MonkeyQuestFrame:GetLeft();
		MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameTop = MonkeyQuestFrame:GetTop();
		MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameBottom = MonkeyQuestFrame:GetBottom();
	end
end

-- Get a colour for the leaderboard item depending on how "done" it is
function MonkeyQuest_GetLeaderboardColorStr(strText)
	local i, j, iNumItems, iNumNeeded, strItemName;

	if(GetLocale() == "enUS") then
		i, j, iNumItems, iNumNeeded, strItemName = string.find(strText, "([-%d]+)/([-%d]+)%s*(.*)$");
	else
		i, j, strItemName, iNumItems, iNumNeeded = string.find(strText, "(.*):%s*([-%d]+)%s*/%s*([-%d]+)%s*$");
	end

	-- wraith:
	if ( MonkeyQuestConfig[MonkeyQuest.m_global].m_bColourSubObjectivesByProgress == true ) then
		if (iNumItems ~= nil) then
			local colour = {a = 1.0, r = 1.0, g = 1.0, b = 1.0};
			colour.a, colour.r, colour.g, colour.b = MonkeyQuest_GetCompletenessColorStr(iNumItems, iNumNeeded);
			return MonkeyLib_ARGBToColourStr(colour.a, colour.r, colour.g, colour.b);
		end
	
		-- it's a quest with no numerical objectives
		local i, j, strItems, strNeeded, strItemName;
		
		if(GetLocale() == "enUS") then
			i, j, strItems, strNeeded, strItemName = string.find(strText, "([-%a]+)/([-%a]+)%s*(.*)$");
		else
			i, j, strItemName, strItems, strNeeded = string.find(strText, "(.*):%s*([-%a]+)%s*/%s*([-%a]+)%s*$");
		end
		
		-- is it a string/string type?
		if (strItems ~= nil) then
			if (strItems == strNeeded) then
				-- strings are equal, completed objective
				return MonkeyQuestConfig[MonkeyQuest.m_global].m_strCompleteObjectiveColour;
			else
				-- strings are not equal, uncompleted objective
				return MonkeyQuestConfig[MonkeyQuest.m_global].m_strInitialObjectiveColour;
			end
		else
			-- special objective
			return MonkeyQuestConfig[MonkeyQuest.m_global].m_strSpecialObjectiveColour;
		end
	else
		return MonkeyQuestConfig[MonkeyQuest.m_global].m_strFinishObjectiveColour;
	end
end
-- Get a colour for the leaderboard item depending on how "done" it is
function MonkeyQuest_GetCompletenessColorStr(iNumItems, iNumNeeded)
	local colour = {a = 1.0, r = 1.0, g = 1.0, b = 1.0};
	local colourInitial = {a = 1.0, r = 1.0, g = 1.0, b = 1.0};
	local colourMid = {a = 1.0, r = 1.0, g = 1.0, b = 1.0};
	local colourComplete = {a = 1.0, r = 1.0, g = 1.0, b = 1.0};
	local colourFinish = {a = 1.0, r = 1.0, g = 1.0, b = 1.0};

	colourInitial.a, colourInitial.r, colourInitial.g, colourInitial.b = MonkeyLib_ColourStrToARGB(MonkeyQuestConfig[MonkeyQuest.m_global].m_strInitialObjectiveColour);
	colourMid.a, colourMid.r, colourMid.g, colourMid.b = MonkeyLib_ColourStrToARGB(MonkeyQuestConfig[MonkeyQuest.m_global].m_strMidObjectiveColour);
	colourComplete.a, colourComplete.r, colourComplete.g, colourComplete.b = MonkeyLib_ColourStrToARGB(MonkeyQuestConfig[MonkeyQuest.m_global].m_strCompleteObjectiveColour);
	colourFinish.a, colourFinish.r, colourFinish.g, colourFinish.b = MonkeyLib_ColourStrToARGB(MonkeyQuestConfig[MonkeyQuest.m_global].m_strFinishObjectiveColour);

	local colourDelta1 = {
		a = (colourMid.a - colourInitial.a),
		r = (colourMid.r - colourInitial.r),
		g = (colourMid.g - colourInitial.g),
		b = (colourMid.b - colourInitial.b)
		};

	local colourDelta2 = {
		a = (colourComplete.a - colourMid.a),
		r = (colourComplete.r - colourMid.r),
		g = (colourComplete.g - colourMid.g),
		b = (colourComplete.b - colourMid.b)
		};

	-- standard x/y type objective
	if (iNumItems + 0 == iNumNeeded + 0) then
		colour.r = colourFinish.r;
		colour.g = colourFinish.g;
		colour.b = colourFinish.b;
	elseif ((iNumItems / iNumNeeded) < 0.5) then
		colour.r = colourInitial.r + ((iNumItems / (iNumNeeded / 2)) * colourDelta1.r);
		colour.g = colourInitial.g + ((iNumItems / (iNumNeeded / 2)) * colourDelta1.g);
		colour.b = colourInitial.b + ((iNumItems / (iNumNeeded / 2)) * colourDelta1.b);
	else
		colour.r = colourMid.r + (((iNumItems - (iNumNeeded / 2)) / (iNumNeeded / 2)) * colourDelta2.r);
		colour.g = colourMid.g + (((iNumItems - (iNumNeeded / 2)) / (iNumNeeded / 2)) * colourDelta2.g);
		colour.b = colourMid.b + (((iNumItems - (iNumNeeded / 2)) / (iNumNeeded / 2)) * colourDelta2.b);
	end

	-- just incase the numbers went slightly out of range
	if (colour.r > 1.0) then
		colour.r = 1.0;
	end
	if (colour.g > 1.0) then
		colour.g = 1.0;
	end
	if (colour.b > 1.0) then
		colour.b = 1.0;
	end
	if (colour.r < 0.0) then
		colour.r = 0.0;
	end
	if (colour.g < 0.0) then
		colour.g = 0.0;
	end
	if (colour.b < 0.0) then
		colour.b = 0.0;
	end

	return colour.a, colour.r, colour.g, colour.b;
end

-- when the mouse goes over the main frame, this gets called
function MonkeyQuestTitle_OnEnter(self, motion)
	-- noob tip?

	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowNoobTips == true) then

		-- put the tool tip in the specified position
		if (MonkeyQuestConfig[MonkeyQuest.m_global].m_strAnchor == "DEFAULT") then
			GameTooltip_SetDefaultAnchor(GameTooltip, self);
		else
			GameTooltip:SetOwner(MonkeyQuestFrame, MonkeyQuestConfig[MonkeyQuest.m_global].m_strAnchor);
		end
	
		-- set the tool tip text
		GameTooltip:SetText(MONKEYQUEST_NOOBTIP_HEADER, TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 1);
		GameTooltip:AddLine(MONKEYQUEST_NOOBTIP_TITLE, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	
		GameTooltip:Show();
		return;
	end


	
	--[[
	-- put the tool tip in the default position
	GameTooltip_SetDefaultAnchor(GameTooltip, self);
	
	-- set the tool tip text
	GameTooltip:SetText(MONKEYQUEST_TITLE_VERSION, MONKEYLIB_TITLE_COLOUR.r, MONKEYLIB_TITLE_COLOUR.g, MONKEYLIB_TITLE_COLOUR.b, 1);
	GameTooltip:AddLine(MONKEYQUEST_DESCRIPTION, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b, 1);
	GameTooltip:Show();]]--

end

function MonkeyQuestButton_OnLoad(self)
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");
end

function MonkeyQuestButton_OnClick(self, button, down)

	--local strQuestLink = GetQuestLink(self.m_iQuestIndex);
	local strQuestLogTitleText, strQuestLevel, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID = GetQuestLogTitle(self.m_iQuestIndex);
	
	local strQuestLogTitleText, strQuestLevel, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID = GetQuestLogTitle(self.m_iQuestIndex);
	
	if (isHeader) then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[_G["MonkeyQuestHideButton" .. self.id].m_strQuestLogTitleText].m_bChecked =
			not MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[_G["MonkeyQuestHideButton" .. self.id].m_strQuestLogTitleText].m_bChecked;
		
		MonkeyQuest_Refresh();
		MonkeyQuestFrame:Show();
		MonkeyQuest_Refresh();

		return;
	end
	
	local activeWindow = ChatEdit_GetActiveWindow();
	
	-- print text to the chat edit frame if shift is down and the 
	-- chat frame edit box is open and it's not a zone header
	if (IsShiftKeyDown() and activeWindow) then
		-- what button was it?
		if (button == "LeftButton") then
			local chars = ""
			local tagID, tagName = GetQuestTagInfo(questID);
			if ( tagName ) then
				if ( tagID == QUEST_TAG_GROUP) then
					chars = "G"
				elseif ( tagID == QUEST_TAG_PVP) then
					chars = "P"
				elseif ( tagID == QUEST_TAG_RAID) then
					chars = "R"
				elseif ( tagID == QUEST_TAG_DUNGEON) then
					chars = "D"
				elseif ( tagID == QUEST_TAG_LEGENDARY) then
					chars = "L"
				elseif ( tagID == QUEST_TAG_HEROIC) then
					chars = "H"
				elseif ( tagID == QUEST_TAG_RAID10) then
					chars = "R"
				elseif ( tagID == QUEST_TAG_RAID25) then
					chars = "R"
				elseif ( tagID == QUEST_TAG_SCENARIO) then
					chars = "S"
				elseif ( tagID == QUEST_TAG_ACCOUNT) then
					chars = "A"
				end
			end
			
			--[[
			if suggestedGroup and suggestedGroup > 1 then	
				chars = chars .. suggestedGroup
			end
			
			if ( frequency == LE_QUEST_FREQUENCY_DAILY ) then
				chars = chars.."*"
			elseif ( frequency == LE_QUEST_FREQUENCY_WEEKLY ) then
				chars = chars.."**"
			end
			]]--
			--activeWindow:Insert("["..strQuestLevel..chars.."] " .. strQuestLink .. " ");
			activeWindow:Insert("["..strQuestLevel..chars.."]" .. strQuestLogTitleText .. " ");
			
		else
			local strChatObjectives = "";

			-- Remember the currently selected quest log entry
			local tmpQuestLogSelection = GetQuestLogSelection();

			-- Select the quest log entry for other functions like GetNumQuestLeaderBoards()
			SelectQuestLogEntry(self.m_iQuestIndex);

			if (GetNumQuestLeaderBoards() > 0) then
				for i=1, GetNumQuestLeaderBoards(), 1 do
					--local string = _G["QuestLogObjective"..ii];
					local strLeaderBoardText, strType, iFinished = GetQuestLogLeaderBoard(i);
					
					if (strLeaderBoardText) then
						strChatObjectives = strChatObjectives .. "{" .. strLeaderBoardText .. "} ";
					end
				end
			elseif (MonkeyQuestConfig[MonkeyQuest.m_global].m_bObjectives) then
				-- this quest has no leaderboard so display the objective instead if the config is set
				local strQuestDescription, strQuestObjectives = GetQuestLogQuestText();

				strChatObjectives = strChatObjectives .. "{" .. strQuestObjectives .. "} ";
			end

			activeWindow:Insert(strChatObjectives);

			-- Restore the currently selected quest log entry
			SelectQuestLogEntry(tmpQuestLogSelection);

		end

		-- the user isn't trying to actually open the real quest log, so just exit here
		return;
	end

	if (IsControlKeyDown()) then
		-- what button was it?
		if (button == "LeftButton") then
			-- Select the quest log entry for other functions like GetNumQuestLeaderBoards()
			SelectQuestLogEntry(self.m_iQuestIndex);
			
			-- try and share this quest with party members
			if (GetQuestLogPushable() and GetNumSubgroupMembers() > 0) then
				QuestLogPushQuest();
			end
			
		else
			-- Remember the currently selected quest log entry
			--local tmpQuestLogSelection = GetQuestLogSelection();

			-- Select the quest log entry for other functions like GetNumQuestLeaderBoards()
			-- SelectQuestLogEntry(self.m_iQuestIndex);
			
			QuestMapQuestOptions_AbandonQuest(questID)
			
			-- Restore the currently selected quest log entry
			--SelectQuestLogEntry(tmpQuestLogSelection);
		end

		-- the user isn't trying to actually open the real quest log, so just exit here
		return;
	end
	
	if (button == "LeftButton") then
		-- if MonkeyQuestLog is installed, open that instead
		if (MkQL_SetQuest ~= nil) then
			if (MkQL_Main_Frame:IsVisible()) then
				if (MkQL_global_iCurrQuest == self.m_iQuestIndex) then
					MkQL_Main_Frame:Hide();
				return;
				end
			end
			MkQL_SetQuest(self.m_iQuestIndex);
			return;
		end

		-- show the real questlog
		-- ShowUIPanel(QuestLogFrame);

		-- actually select the quest entry
		if (QuestMapFrame:IsShown() and QuestMapFrame:IsVisible()) then
			QuestMapFrame_OpenToQuestDetails(questID)
		else
			QuestLogPopupDetailFrame_Show(self.m_iQuestIndex)
		end

		-- update the real quest log
		-- QuestLog_Update();

	elseif (button == "RightButton") then
		if(MonkeyQuestConfig[MonkeyQuest.m_global].m_bHideQuestsEnabled == true or MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowHidden == true) then
			if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText.." - "..tostring(isHeader)].m_bChecked == true) then
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
				MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText.." - "..tostring(isHeader)].m_bChecked = false;
			else
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
				MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText.." - "..tostring(isHeader)].m_bChecked = true;
			end
		end

		MonkeyQuest_Refresh();
		MonkeyQuestFrame:Show();
		MonkeyQuest_Refresh();
	end
end

function MonkeyQuestButton_OnEnter(self, motion)
	
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_strAnchor == "NONE") then
		return;
	end
	
	if (self == nil) then
		return;
	end
	
	if (self.m_iQuestIndex == nil) then
		return;
	end

	local strQuestLogTitleText, strQuestLevel, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID = GetQuestLogTitle(self.m_iQuestIndex);

	if (strQuestLogTitleText == nil) then
		return;
	end

	if (isHeader) then
		-- no noob tip?
		if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowNoobTips == false) then
			return;
		end
		
		-- put the tool tip in the specified position
		if (MonkeyQuestConfig[MonkeyQuest.m_global].m_strAnchor == "DEFAULT") then
			GameTooltip_SetDefaultAnchor(GameTooltip, self);
		else
			GameTooltip:SetOwner(MonkeyQuestFrame, MonkeyQuestConfig[MonkeyQuest.m_global].m_strAnchor);
		end
	
		-- set the tool tip text
		GameTooltip:SetText(MONKEYQUEST_NOOBTIP_HEADER, TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 1);
		GameTooltip:AddLine(MONKEYQUEST_NOOBTIP_QUESTHEADER, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	
		GameTooltip:Show();
		return;
	end
	
	-- put the tool tip in the specified position
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_strAnchor == "DEFAULT") then
		GameTooltip_SetDefaultAnchor(GameTooltip, self);
	else
		GameTooltip:SetOwner(MonkeyQuestFrame, MonkeyQuestConfig[MonkeyQuest.m_global].m_strAnchor);
	end
	
	-- set the tool tip text
--[[	GameTooltip:SetText(strQuestLogTitleText, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	if ( isComplete and isComplete < 0 ) then
        GameTooltip:AddLine(FAILED, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
        GameTooltip:AddTexture("Interface\\QuestFrame\\QuestTypeIcons", unpack(QUEST_TAG_TCOORDS["FAILED"]));   
    end
	GameTooltip:AddLine(self.m_strQuestObjectives, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b, 1);

    local tagID, tagName = GetQuestTagInfo(questID);
    if ( tagName ) then
        local factionGroup = GetQuestFactionGroup(questID);
        -- Faction-specific account quests have additional info in the tooltip
        if ( tagID == QUEST_TAG_ACCOUNT and factionGroup ) then
            local factionString = FACTION_ALLIANCE;
            if ( factionGroup == LE_QUEST_FACTION_HORDE ) then
                factionString = FACTION_HORDE;
            end
            tagName = format("%s (%s)", tagName, factionString);
        end
        GameTooltip:AddLine(tagName, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
        if ( QUEST_TAG_TCOORDS[tagID] ) then
            local questTypeIcon;
            if ( tagID == QUEST_TAG_ACCOUNT and factionGroup ) then
                questTypeIcon = QUEST_TAG_TCOORDS["ALLIANCE"];
                if ( factionGroup == LE_QUEST_FACTION_HORDE ) then
                    questTypeIcon = QUEST_TAG_TCOORDS["HORDE"];
                end
            else
                questTypeIcon = QUEST_TAG_TCOORDS[tagID];
            end
            GameTooltip:AddTexture("Interface\\QuestFrame\\QuestTypeIcons", unpack(questTypeIcon));
        end
    end
    if ( frequency == LE_QUEST_FREQUENCY_DAILY ) then
        GameTooltip:AddLine(DAILY, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
        GameTooltip:AddTexture("Interface\\QuestFrame\\QuestTypeIcons", unpack(QUEST_TAG_TCOORDS["DAILY"]));
    elseif ( frequency == LE_QUEST_FREQUENCY_WEEKLY ) then
        GameTooltip:AddLine(WEEKLY, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
        GameTooltip:AddTexture("Interface\\QuestFrame\\QuestTypeIcons", unpack(QUEST_TAG_TCOORDS["WEEKLY"]));
    end
	
	-- see if any nearby group mates are on this quest
	local iNumPartyMembers;
	
	local v, b, d, t = GetBuildInfo();
	
	if (t >= 50000) then
		iNumPartyMembers = GetNumSubgroupMembers();
	else
		iNumPartyMembers = 0;
	end
	
	local isOnQuest, i;
	
	for i = 1, iNumPartyMembers do
		isOnQuest = IsUnitOnQuest(self.m_iQuestIndex, "party" .. i);
		
		if (isOnQuest and isOnQuest == true) then
			-- this member is on the quest
			GameTooltip:AddLine(MonkeyQuestConfig[MonkeyQuest.m_global].m_strCompleteObjectiveColour .. UnitName("party" .. i));
		else
			-- this member isn't on the quest
			GameTooltip:AddLine(MonkeyQuestConfig[MonkeyQuest.m_global].m_strInitialObjectiveColour .. UnitName("party" .. i));
		end
	end
	]]--
	
	
	
	-- set the tool tip text
-- DaMaGepy's editing --
	local titcol="|cFFFFFF00"; 
	local objcol="|cFFB0D0B0";
	local descol="|cFF888899";	
	--local questLink = GetQuestLink(self.m_iQuestIndex);
	--local _,_, questString = string.split("|", questLink);
	--local linkHeader, QID = string.split(":", questString);
	
	-- /script ReloadUI();
	--GameTooltip_SetDefaultAnchor(GameTooltip, self);
	GameTooltip:SetOwner(MonkeyQuestFrame, MonkeyQuestConfig[MonkeyQuest.m_global].m_strAnchor);
	if (self.m_iQuestIndex~=nil) then
		local QID = self.m_iQuestIndex;
		if (QID==nil) then
			local questLink = GetQuestLink(self.m_iQuestIndex);
			local _,_, questString = string.split("|", questLink);
			local linkHeader, QID = string.split(":", questString);	
		end;
		SelectQuestLogEntry(QID);
		local qtdesc,qtobj = GetQuestLogQuestText();
		local mqhigh = {"Gorgrond","Talador","Nagrand","Shadowmoon Valley","Spires of Arak","Frostfire Ridge","Ashran","Stormshield","Tanaan Jungle","Bloodmaul Slag Mines","Grimrail Depot","Skyreach",
					"The Everbloom","Shadowmoon Burial Grounds","Iron Docks","Auchindoun","Upper Blackrock Spire","Stormwind","Ironforge","Darnassus",
					"Loch Modan","Wetlands","Felwood","Hinterland","Alterac Mountain","Tanaris","Gadgetzan","Desolace","Barrens","Ratchet","Theramore","Booty Bay",
					"Gnomeregan","Elwynn","Darkshore","Ashenvale","Stonetalon Mountains","Feralas","Redridge Mountains","Redridge","Darkshire","Lakeshire","Duskwood","Stranglethorn Vale",
					"Southshore","Hillsbrad","Badlands","Thelsamar","Kharanos","Westfall","Sentinel Hill","Burning Steppes","Menethil Harbor","Menethil","Swamp of Sorrows","Stockade",
					"Auberdine","Astranaar","Winterspring","Everlook","Feathermoon Stronghold","Azshara","Dustwallow Marsh","Thousand Needles","Shimmering Flat",
					"Un'Goro","Silithus","Maraudon","Scarlet Monastery","Plaguelands","Orgrimmar","Undercity","Mulgore","Thunder Bluff","Crossroads","Thalanaar",
					"Nijel's Point","Teldrassil","Dolanaar","Shadowglen","Refuge Pointe","Arathi Highland","Uldaman","Tirisfal Glades","Scholomance","Stratholme",
					"Tabetha","Zul'Farrak","Dire Maul","Blackrock Spire","Blackrock Depths","Dun Modr"};
		for mqff = 1,table.getn(mqhigh) do 
			qtobj=string.gsub(qtobj, mqhigh[mqff], "|cFFFFFF00"..mqhigh[mqff]..objcol); 
			qtdesc=string.gsub(qtdesc, mqhigh[mqff], "|cFFFFFFFF"..mqhigh[mqff]..descol); 
		end -- kiemel
		self.m_strQuestObjectives = "\n"..objcol..qtobj.."\n\n"..descol..qtdesc;
	
		GameTooltip:SetText(strQuestLogTitleText.." |cFF554444("..QID..")", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
		GameTooltip:SetMinimumWidth(400);
	-- modositas vege --		
	
	
		--GameTooltip:SetText(strQuestLogTitleText, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
		GameTooltip:AddLine(self.m_strQuestObjectives, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b, 1);
		GameTooltip:AddLine(strQuestTag, TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 1);
			
		GameTooltip:Show();
-- DaMaGepy End;
	end;	
	
	
	
	--GameTooltip:Show();
end

function MonkeyQuestHideButton_OnLoad()

end

function MonkeyQuestHideButton_OnEnter(self, motion)
	-- no noob tip?
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowNoobTips == false) then
		return;
	end
	
	-- put the tool tip in the specified position
	if (MonkeyQuestConfig[MonkeyQuest.m_global].m_strAnchor == "DEFAULT") then
		GameTooltip_SetDefaultAnchor(GameTooltip, self);
	else
		GameTooltip:SetOwner(MonkeyQuestFrame, MonkeyQuestConfig[MonkeyQuest.m_global].m_strAnchor);
	end

	-- set the tool tip text
	GameTooltip:SetText(MONKEYQUEST_NOOBTIP_HEADER, TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 1);
	GameTooltip:AddLine(MONKEYQUEST_NOOBTIP_HIDEBUTTON, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);

	GameTooltip:Show();

end

function MonkeyQuestHideButton_OnClick(self, button, down)
	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	if (self:GetChecked()) then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
		
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[self.m_strQuestLogTitleText].m_bChecked = true;
		
	else
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
		
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[self.m_strQuestLogTitleText].m_bChecked = false;
	end

	MonkeyQuest_Refresh();
	MonkeyQuestFrame:Show();
	MonkeyQuest_Refresh();
end

function MonkeyQuest_PrintPoints()
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("Left: "..MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameLeft);
		DEFAULT_CHAT_FRAME:AddMessage("Top: "..MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameTop);
		DEFAULT_CHAT_FRAME:AddMessage("Bottom: "..MonkeyQuestConfig[MonkeyQuest.m_global].m_iFrameBottom);
	end
end

function MonkeyQuestOptions()

	if (GetAddOnDependencies("MonkeyBuddy") == nil) then
	
	-- Create main frame for information text
	local MonkeyQuestOptions = CreateFrame("FRAME", "MonkeyQuestOptions")
	MonkeyQuestOptions.name = MONKEYQUEST_TITLE
	InterfaceOptions_AddCategory(MonkeyQuestOptions)
	
	function MonkeyQuestOptions.default()
		MonkeyQuestInit_ResetConfig();
	end

	local MonkeyQuestOptionsText1 = MonkeyQuestOptions:CreateFontString(nil, "ARTWORK")
	MonkeyQuestOptionsText1:SetFontObject(GameFontNormalLarge)
	MonkeyQuestOptionsText1:SetJustifyH("LEFT") 
	MonkeyQuestOptionsText1:SetJustifyV("TOP")
	MonkeyQuestOptionsText1:ClearAllPoints()
	MonkeyQuestOptionsText1:SetPoint("TOPLEFT", 16, -16)
	MonkeyQuestOptionsText1:SetText(MONKEYQUEST_TITLE_VERSION)

	local MonkeyQuestOptionsText2 = MonkeyQuestOptions:CreateFontString(nil, "ARTWORK")
	MonkeyQuestOptionsText2:SetFontObject(GameFontNormalSmall)
	MonkeyQuestOptionsText2:SetJustifyH("LEFT") 
	MonkeyQuestOptionsText2:SetJustifyV("TOP")
	MonkeyQuestOptionsText2:SetTextColor(1, 1, 1)
	MonkeyQuestOptionsText2:ClearAllPoints()
	MonkeyQuestOptionsText2:SetPoint("TOPLEFT", MonkeyQuestOptionsText1, "BOTTOMLEFT", 8, -16)
	MonkeyQuestOptionsText2:SetWidth(340)
	MonkeyQuestOptionsText2:SetText(MONKEYQUEST_OPTIONS1)

	local MonkeyQuestOptionsText3 = MonkeyQuestOptions:CreateFontString(nil, "ARTWORK")
	MonkeyQuestOptionsText3:SetFontObject(GameFontNormalLarge)
	MonkeyQuestOptionsText3:SetJustifyH("LEFT") 
	MonkeyQuestOptionsText3:SetJustifyV("TOP")
	MonkeyQuestOptionsText3:SetTextColor(1, 0.65, 0)
	MonkeyQuestOptionsText3:ClearAllPoints()
	MonkeyQuestOptionsText3:SetPoint("TOPLEFT", MonkeyQuestOptionsText2, "BOTTOMLEFT", 0, -16)
	MonkeyQuestOptionsText3:SetWidth(340)
	MonkeyQuestOptionsText3:SetText(MONKEYQUEST_OPTIONS2)
	
	end

end