-- *****************************************************************************
-- MonkeyQuest
-- *****************************************************************************

-- Set color functions
local MonkeyBuddyQuest_ColourCallback = {
    [1] = function(x) MonkeyBuddyQuest_SetColour(1) end,
    [2] = function(x) MonkeyBuddyQuest_SetColour(2) end,
    [3] = function(x) MonkeyBuddyQuest_SetColour(3) end,
    [4] = function(x) MonkeyBuddyQuest_SetColour(4) end,
    [5] = function(x) MonkeyBuddyQuest_SetColour(5) end,
    [6] = function(x) MonkeyBuddyQuest_SetColour(6) end,
    [7] = function(x) MonkeyBuddyQuest_SetColour(7) end,
    [8] = function(x) MonkeyBuddyQuest_SetColour(8) end,
    [9] = function(x) MonkeyBuddyQuest_SetColour(9) end,
    [10] = function(x) MonkeyBuddyQuest_SetColour(10) end,
    [11] = function(x) MonkeyBuddyQuest_SetColour(11) end,
    [12] = function(x) MonkeyBuddyQuest_SetColour(12) end
};

local MonkeyBuddyQuest_ColourCancleCallback = {
    [1] = function(x) MonkeyBuddyQuest_CancleColour(1) end,
    [2] = function(x) MonkeyBuddyQuest_CancleColour(2) end,
    [3] = function(x) MonkeyBuddyQuest_CancleColour(3) end,
    [4] = function(x) MonkeyBuddyQuest_CancleColour(4) end,
    [5] = function(x) MonkeyBuddyQuest_CancleColour(5) end,
    [6] = function(x) MonkeyBuddyQuest_CancleColour(6) end,
    [7] = function(x) MonkeyBuddyQuest_CancleColour(7) end,
    [8] = function(x) MonkeyBuddyQuest_CancleColour(8) end,
    [9] = function(x) MonkeyBuddyQuest_CancleColour(9) end,
    [10] = function(x) MonkeyBuddyQuest_CancleColour(10) end,
    [11] = function(x) MonkeyBuddyQuest_CancleColour(11) end,
    [12] = function(x) MonkeyBuddyQuest_CancleColour(12) end
};

-- this array is used to init the check buttons
local MonkeyBuddyQuest_CheckButtons = { };
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_OPEN] = {
    id = 1,
    strVar = "m_bDisplay",
    pSlashCommand = MonkeyQuestSlash_CmdOpen
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_SHOWHIDDEN] = {
    id = 2, 
    strVar = "m_bShowHidden",
    pSlashCommand = MonkeyQuestSlash_CmdShowHidden
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_USEOVERVIEWS] = {
    id = 3, 
    strVar = "m_bObjectives",
    pSlashCommand = MonkeyQuestSlash_CmdUseOverviews
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_HIDEHEADERS] = {
    id = 4, 
    strVar = "m_bNoHeaders",
    pSlashCommand = MonkeyQuestSlash_CmdHideHeaders
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_HIDEBORDER] = {
    id = 5, 
    strVar = "m_bNoBorder",
    pSlashCommand = MonkeyQuestSlash_CmdHideBorder
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_GROWUP] = {
    id = 6, 
    strVar = "m_bGrowUp",
    pSlashCommand = MonkeyQuestSlash_CmdGrowUp
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_SHOWNUMQUESTS] = {
    id = 7, 
    strVar = "m_bShowNumQuests",
    pSlashCommand = MonkeyQuestSlash_CmdShowNumQuests
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_LOCK] = {
    id = 8, 
    strVar = "m_bLocked",
    pSlashCommand = MonkeyQuestSlash_CmdLock
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_COLOURTITLEON] = {
    id = 9, 
    strVar = "m_bColourTitle",
    pSlashCommand = MonkeyQuestSlash_CmdColourTitleOn
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_HIDECOMPLETEDQUESTS] = {
    id = 10, 
    strVar = "m_bHideCompletedQuests",
    pSlashCommand = MonkeyQuestSlash_CmdHideCompletedQuests
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_HIDECOMPLETEDOBJECTIVES] = {
    id = 11, 
    strVar = "m_bHideCompletedObjectives",
    pSlashCommand = MonkeyQuestSlash_CmdHideCompletedObjectives
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_SHOWTOOLTIPOBJECTIVES] = {
    id = 12, 
    strVar = "m_bShowTooltipObjectives",
    pSlashCommand = MonkeyQuestSlash_CmdShowTooltipObjectives
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_ALLOWRIGHTCLICK] = {
    id = 13, 
    strVar = "m_bAllowRightClick",
    pSlashCommand = MonkeyQuestSlash_CmdAllowRightClick
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_HIDETITLEBUTTONS] = {
    id = 14, 
    strVar = "m_bHideTitleButtons",
    pSlashCommand = MonkeyQuestSlash_CmdHideTitleButtons
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_HIDETITLE] = {
    id = 15, 
    strVar = "m_bHideTitle",
    pSlashCommand = MonkeyQuestSlash_CmdHideTitle
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_COLOURSUBOBJECTIVES] = {
    id = 16, 
    strVar = "m_bColourSubObjectivesByProgress",
    pSlashCommand = MonkeyQuestSlash_CmdColourObjectives
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_CRASHBORDER] = {
    id = 17, 
    strVar = "m_bCrashBorder",
    pSlashCommand = MonkeyQuestInit_Border
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_SHOWNOOBTIPS] = {
    id = 18,
    strVar = "m_bShowNoobTips",
    pSlashCommand = MonkeyQuestSlash_CmdShowNoobTips
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_SHOWZONEHIGHLIGHT] = {
    id = 19,
    strVar = "m_bShowZoneHighlight",
    pSlashCommand = MonkeyQuestSlash_CmdShowZoneHighlight
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_SHOWQUESTLEVEL] = {
    id = 20,
    strVar = "m_bShowQuestLevel",
    pSlashCommand = MonkeyQuestSlash_CmdShowQuestLevel
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_ALWAYSHEADERS] = {
    id = 21,
    strVar = "m_bAlwaysHeaders",
    pSlashCommand = MonkeyQuestSlash_CmdAlwaysHeaders
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_WORKCOMPLETE] = {
    id = 22,
    strVar = "m_bWorkComplete",
    pSlashCommand = MonkeyQuestSlash_CmdWorkComplete
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_ITEMSENABLED] = {
    id = 23,
    strVar = "m_bItemsEnabled",
    pSlashCommand = MonkeyQuestSlash_CmdItemsEnabled 
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_ITEMSONLEFT] = {
    id = 24,
    strVar = "m_bItemsOnLeft",
    pSlashCommand = MonkeyQuestSlash_CmdItemsOnLeft
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_HIDEHEADER] = {
    id = 25,
    strVar = "m_bHideHeader",
    pSlashCommand = MonkeyQuestSlash_CmdHideHeader
};
MonkeyBuddyQuest_CheckButtons[MONKEYBUDDY_QUEST_HIDEQUESTSENABLED] = {
    id = 26,
    strVar = "m_bHideQuestsEnabled",
    pSlashCommand = MonkeyQuestSlash_CmdHideQuestsEnabled
};

-- this array is used to init the colour buttons
local MonkeyBuddyQuest_ColourButtons = { };
MonkeyBuddyQuest_ColourButtons[MONKEYBUDDY_QUEST_QUESTTITLECOLOUR] = { 
    id = 1,
    strVar = "m_strQuestTitleColour"
};
MonkeyBuddyQuest_ColourButtons[MONKEYBUDDY_QUEST_HEADEROPENCOLOUR] = { 
    id = 2,
    strVar = "m_strHeaderOpenColour"
};
MonkeyBuddyQuest_ColourButtons[MONKEYBUDDY_QUEST_HEADERCLOSEDCOLOUR] = { 
    id = 3,
    strVar = "m_strHeaderClosedColour"
};
MonkeyBuddyQuest_ColourButtons[MONKEYBUDDY_QUEST_OVERVIEWCOLOUR] = { 
    id = 4,
    strVar = "m_strOverviewColour"
};
MonkeyBuddyQuest_ColourButtons[MONKEYBUDDY_QUEST_SPECIALOBJECTIVECOLOUR] = {
    id = 5,
    strVar = "m_strSpecialObjectiveColour"
};
MonkeyBuddyQuest_ColourButtons[MONKEYBUDDY_QUEST_INITIALOBJECTIVECOLOUR] = {
    id = 6,
    strVar = "m_strInitialObjectiveColour"
};
MonkeyBuddyQuest_ColourButtons[MONKEYBUDDY_QUEST_MIDOBJECTIVECOLOUR] = {
    id = 7,
    strVar = "m_strMidObjectiveColour"
};
MonkeyBuddyQuest_ColourButtons[MONKEYBUDDY_QUEST_COMPLETEOBJECTIVECOLOUR] = {
    id = 8,
    strVar = "m_strCompleteObjectiveColour"
};
MonkeyBuddyQuest_ColourButtons[MONKEYBUDDY_QUEST_FINISHOBJECTIVECOLOUR] = {
    id = 9,
    strVar = "m_strFinishObjectiveColour"
};
MonkeyBuddyQuest_ColourButtons[MONKEYBUDDY_QUEST_ZONEHIGHLIGHTCOLOUR] = {
    id = 10,
    strVar = "m_strZoneHighlightColour"
};


local MonkeyBuddyQuest_Sliders = { };

MonkeyBuddyQuest_Sliders[MONKEYBUDDY_QUEST_FRAMEALPHASLIDER] = {
    id = 1,
    strVar = "m_iFrameAlpha",
    pSlashCommand = MonkeyQuest_SetFrameAlpha,
    minValue = 0.0,
    maxValue = 1.0,
    valueStep = .01,
    minText="0%",
    maxText="100%",
};
MonkeyBuddyQuest_Sliders[MONKEYBUDDY_QUEST_ALPHASLIDER] = {
    id = 2,
    strVar = "m_iAlpha",
    pSlashCommand = MonkeyQuest_SetAlpha,
    minValue = 0.0,
    maxValue = 1.0,
    valueStep = .01,
    minText="0%",
    maxText="100%",
};
MonkeyBuddyQuest_Sliders[MONKEYBUDDY_QUEST_HIGHLIGHTALPHASLIDER] = {
    id = 3,
    strVar = "m_iHighlightAlpha",
    pSlashCommand = MonkeyQuest_SetHighlightAlpha,
    minValue = 0.0,
    maxValue = 1.0,
    valueStep = .01,
    minText="0%",
    maxText="100%",
};MonkeyBuddyQuest_Sliders[MONKEYBUDDY_QUEST_WIDTHSLIDER] = {
    id = 4,
    strVar = "m_iFrameWidth",
    pSlashCommand = MonkeyQuestSlash_CmdWidth,
    minValue = 200,
    maxValue = 600,
    valueStep = 1,
    minText="200",
    maxText="600",
};
MonkeyBuddyQuest_Sliders[MONKEYBUDDY_QUEST_FONTSLIDER] = {
    id = 5,
    strVar = "m_iFontHeight",
    pSlashCommand = MonkeyQuestSlash_CmdFontHeight,
    minValue = 8,
    maxValue = 48,
    valueStep = 0.5,
    minText="8",
    maxText="48",
};
MonkeyBuddyQuest_Sliders[MONKEYBUDDY_QUEST_PADDINGSLIDER] = {
    id = 6,
    strVar = "m_iQuestPadding",
    pSlashCommand = MonkeyQuestSlash_CmdSetQuestPadding,
    minValue = 0,
    maxValue = 32,
    valueStep = 1,
    minText="0",
    maxText="32",
};
MonkeyBuddyQuest_Sliders[MONKEYBUDDY_QUEST_FONT] = {
    id = 7,
    strVar = "m_iFont",
    pSlashCommand = MonkeyQuestInit_Font,
    minValue = 0,
    maxValue = 2,
    valueStep = 1,
    minText="Default                               Thin",
    maxText="Blizzard",
};

MonkeyBuddy = {};
MonkeyBuddy.m_strPlayer = "";

function MonkeyBuddy_OnLoad(self)

    -- Add myCockOptionsFrame to the UIPanelWindows list
    UIPanelWindows["MonkeyBuddyFrame"] = {area = "center", pushable = 0};
    
    -- register events
    self:RegisterEvent("VARIABLES_LOADED");
    
    -- register chat slash commands
    
    -- this command hides the MonkeyBuddy Icon
    SlashCmdList["MONKEYBUDDY_DISMISS"] = MonkeyBuddySlash_CmdDismiss;
    SLASH_MONKEYBUDDY_DISMISS1 = "/monkeybuddydismiss";
    SLASH_MONKEYBUDDY_DISMISS2 = "/mbdismiss";
    
    -- this command shows the MonkeyBuddy Icon
    SlashCmdList["MONKEYBUDDY_CALL"] = MonkeyBuddySlash_CmdCall;
    SLASH_MONKEYBUDDY_CALL1 = "/monkeybuddycall";
    SLASH_MONKEYBUDDY_CALL2 = "/mbcall";
    
    MonkeyBuddyFrame_TitleText:SetTextColor(MONKEYLIB_TITLE_COLOUR.r, MONKEYLIB_TITLE_COLOUR.g, MONKEYLIB_TITLE_COLOUR.b);
end

function MonkeyBuddySlash_CmdDismiss()
    MonkeyBuddyConfig[MonkeyBuddy.m_strPlayer].m_bDismissed = true;
    MonkeyBuddyIconButton:Hide();
    --MonkeyBuddyOptionsCheckButton:SetChecked(false)
end

function MonkeyBuddySlash_CmdCall()
    MonkeyBuddyConfig[MonkeyBuddy.m_strPlayer].m_bDismissed = false;
    MonkeyBuddyIconButton:Show();
    --MonkeyBuddyOptionsCheckButton:SetChecked(true)
end

function MonkeyBuddy_OnEvent(self, event, ...)
    
    if (event == "VARIABLES_LOADED") then
        -- Add MonkeyBuddy to myAddOns
        if (myAddOnsList) then
            myAddOnsList[MONKEYBUDDY_TITLE] = {name = MONKEYBUDDY_TITLE, description = MONKEYBUDDY_DESCRIPTION, version = MONKEYBUDDY_VERSION, frame = "MonkeyBuddyIconButton", optionsframe = "MonkeyBuddyFrame"};
        end
        
		--MonkeyBuddy.m_strPlayer = UnitName('player');
		MonkeyBuddy.m_strPlayer = "Global"
	
        if (MonkeyBuddyConfig == nil) then
            MonkeyBuddyConfig = {};
		end
		if (MonkeyBuddyConfig[MonkeyBuddy.m_strPlayer] == nil) then
			MonkeyBuddyConfig[MonkeyBuddy.m_strPlayer] = {};
            MonkeyBuddyConfig[MonkeyBuddy.m_strPlayer].m_bDismissed = true;
            MonkeyBuddyConfig[MonkeyBuddy.m_strPlayer].m_bDailies = false;
        end
        
		--[[
		-- Minimap icon
        if (MonkeyBuddyConfig[MonkeyBuddy.m_strPlayer].m_bDismissed == true) then
            MonkeyBuddyIconButton:Hide();
        else
            MonkeyBuddyIconButton:Show();
        end
        ]]--
		
        -- print out a nice message letting the user know the addon loaded
        --[[
		if (DEFAULT_CHAT_FRAME) then
            DEFAULT_CHAT_FRAME:AddMessage(MONKEYBUDDY_LOADED_MSG);
        end
		--]]
		MonkeyBuddyOptions()
    end
end

function MonkeyBuddyIconButton_OnClick()
    MonkeyBuddy_ToggleDisplay();
end

function MonkeyBuddy_ToggleDisplay()
    if (MonkeyBuddyFrame:IsVisible()) then
        HideUIPanel(MonkeyBuddyFrame);
    else
        if (MonkeyQuest ~= nil) then
            if (MonkeyQuest.m_bLoaded == true) then
                ShowUIPanel(MonkeyBuddyFrame);
            end
       end
    end
end

function MonkeyBuddyQuestFrame_OnShow()
    if (MonkeyQuest ~= nil) then
        if (MonkeyQuest.m_bLoaded == true) then
            MonkeyBuddyQuestFrame_Refresh();
        else
            MonkeyBuddyQuestFrame:Hide();
        end
    else
        MonkeyBuddyQuestTabTexture:Hide();
        MonkeyBuddyQuestFrame:Hide();
    end
end

--Called when option page loads
function MonkeyBuddyQuestFrame_Refresh()
    -- Initial Values
    local button, string, checked, swatch, border, iAlpha, iRed, iGreen, iBlue;
    
    -- Setup check buttons
    for key, value in pairs(MonkeyBuddyQuest_CheckButtons) do
        button = _G["MonkeyBuddyQuestCheck" .. value.id];
        string = _G["MonkeyBuddyQuestCheck" .. value.id .. "Text"];
        checked = nil;
        button.disabled = nil;
        
        --Check Box
        if (MonkeyQuestConfig[MonkeyQuest.m_global][value.strVar] == true) then
            checked = true;
        else
            checked = false;
        end
        
        button:SetChecked(checked);
        string:SetText(key);
        button.pSlashCommand = value.pSlashCommand;
        button.strModName = "MonkeyQuest";
    end
    
    -- Setup colour buttons
    for key, value in pairs(MonkeyBuddyQuest_ColourButtons) do
        button = _G["MonkeyBuddyQuestColour" .. value.id];
        swatch = _G["MonkeyBuddyQuestColour" .. value.id .. "_SwatchTexture"];
        border = _G["MonkeyBuddyQuestColour" .. value.id .. "_BorderTexture"];
        string = _G["MonkeyBuddyQuestColour" .. value.id .. "Text"];
        
        button.disabled = nil;
        
        --Color Swatch
        iAlpha, iRed, iGreen, iBlue = MonkeyLib_ColourStrToARGB(MonkeyQuestConfig[MonkeyQuest.m_global][value.strVar]);
        
        button.a = iAlpha;
        button.r = iRed;
        button.g = iGreen;
        button.b = iBlue;
        button.swatchFunc = MonkeyBuddyQuest_ColourCallback[value.id];
        button.cancelFunc = MonkeyBuddyQuest_ColourCancleCallback[value.id];
        
        swatch:SetVertexColor(iRed, iGreen, iBlue);
        border:SetVertexColor(iRed, iGreen, iBlue);
        
        button.id = value.id;
        button.strVar = value.strVar;
        string:SetText(key);
        
        button.strModName = "MonkeyQuest";
    end
    
    local slider, string, low, high, current;

    -- Setup Sliders
    for key, value in pairs(MonkeyBuddyQuest_Sliders) do
        slider = _G["MonkeyBuddyQuestSlider"..value.id];
        string = _G["MonkeyBuddyQuestSlider"..value.id.."Text"];
        low = _G["MonkeyBuddyQuestSlider"..value.id.."Low"];
        high = _G["MonkeyBuddyQuestSlider"..value.id.."High"];
        
        slider.id = value.id;
        slider.strVar = value.strVar;
        slider.pSlashCommand = value.pSlashCommand;
        
        --OptionsFrame_EnableSlider(slider);
        slider:SetMinMaxValues(value.minValue, value.maxValue);
        slider:SetValueStep(value.valueStep);
        slider:SetValue(MonkeyQuestConfig[MonkeyQuest.m_global][value.strVar]);
        if (MonkeyQuestConfig[MonkeyQuest.m_global][value.strVar] < 1 and MonkeyQuestConfig[MonkeyQuest.m_global][value.strVar] > 0) then
        	current = format("%.2f",MonkeyQuestConfig[MonkeyQuest.m_global][value.strVar])
        else
        	current = MonkeyQuestConfig[MonkeyQuest.m_global][value.strVar]
        end
        
        if (value.strVar == "m_iFont") then
        	if (MonkeyQuestConfig[MonkeyQuest.m_global][value.strVar] == 0) then
				string:SetText(key .. " (Default)");
        	elseif (MonkeyQuestConfig[MonkeyQuest.m_global][value.strVar] == 1) then
				string:SetText(key .. " (Thin)");
        	elseif (MonkeyQuestConfig[MonkeyQuest.m_global][value.strVar] == 2) then
				string:SetText(key .. " (Blizzard)");
        	end
        elseif (value.strVar == "m_iHighlightAlpha" or value.strVar == "m_iAlpha" or value.strVar == "m_iFrameAlpha") then
        	string:SetText(key .. " (" .. current*100 .. "%)");
        else
        	string:SetText(key .. " (" .. current .. ")");
        end
        low:SetText(value.minText);
        high:SetText(value.maxText);
        
        slider.strModName = "MonkeyQuest";
    end
end

function MonkeyBuddyCheckButton_OnClick(self, button, down)
    local bChecked;
    
    if (self:GetChecked()) then
        bChecked = true;
    else
        bChecked = false;
    end
    
    self.pSlashCommand(bChecked);
end

function MonkeyBuddyOptionsCheckButton_OnClick(self, button, down)
	if (self:GetChecked()) then
		MonkeyBuddyConfig[MonkeyBuddy.m_strPlayer].m_bDismissed = false;
		MonkeyBuddyIconButton:Show();
	else
		MonkeyBuddyConfig[MonkeyBuddy.m_strPlayer].m_bDismissed = true;
		MonkeyBuddyIconButton:Hide();
	end
end

function MonkeyQuestDailiesCheckButton_OnClick(self, button, down)
	if (self:GetChecked()) then
		local enable = 1;
		MonkeyBuddyConfig[MonkeyBuddy.m_strPlayer].m_bDailies = true
		MonkeyQuest_Refresh(enable)
	else
		local disable = 0;
		MonkeyBuddyConfig[MonkeyBuddy.m_strPlayer].m_bDailies = false
		MonkeyQuest_Refresh(disable)
	end
end

function MBButton_OnClick()
	MonkeyBuddy_ToggleDisplay()
end

function MBButton_MouseDown()
	--prevent nil error
end

function MBButton_MouseUp()
	--prevent nil error
end

function MonkeyBuddyQuest_SetColour(id)
    local iRed, iGreen, iBlue = ColorPickerFrame:GetColorRGB();
    local swatch, button, border;
    
    
    button = _G["MonkeyBuddyQuestColour" .. id];
    swatch = _G["MonkeyBuddyQuestColour" .. id .. "_SwatchTexture"];
    border = _G["MonkeyBuddyQuestColour" .. id .. "_BorderTexture"];
    
    swatch:SetVertexColor(iRed, iGreen, iBlue);
    border:SetVertexColor(iRed, iGreen, iBlue);
    button.r = iRed;
    button.g = iGreen;
    button.b = iBlue;
    
    -- update MonkeyQuest
    MonkeyQuestConfig[MonkeyQuest.m_global][button.strVar] = MonkeyLib_ARGBToColourStr(1.0, iRed, iGreen, iBlue);
    
    MonkeyQuest_Refresh();
end

function MonkeyBuddyQuest_CancleColour(id)
    local iRed = ColorPickerFrame.previousValues.r;
    local iGreen = ColorPickerFrame.previousValues.g;
    local iBlue = ColorPickerFrame.previousValues.b;
    
    local swatch, button, border;
    
    
    button = _G["MonkeyBuddyQuestColour" .. id];
    swatch = _G["MonkeyBuddyQuestColour" .. id .. "_SwatchTexture"];
    border = _G["MonkeyBuddyQuestColour" .. id .. "_BorderTexture"];
    
    swatch:SetVertexColor(iRed, iGreen, iBlue);
    border:SetVertexColor(iRed, iGreen, iBlue);
    button.r = iRed;
    button.g = iGreen;
    button.b = iBlue;
    
    -- update MonkeyQuest
    MonkeyQuestConfig[MonkeyQuest.m_global][button.strVar] = MonkeyLib_ARGBToColourStr(1.0, iRed, iGreen, iBlue);
    
    MonkeyQuest_Refresh();
end

function MonkeyBuddySlider_OnValueChanged(self, value)

    -- update MonkeyMod
    if (self.strModName == "MonkeyQuest") then
        MonkeyQuestConfig[MonkeyQuest.m_global][self.strVar] = self:GetValue();
    end
    
    self.pSlashCommand(self:GetValue());
    
    -- set the tool tip text
    if (self:GetValue() == floor(self:GetValue())) then
        GameTooltip:SetText(format("%d", self:GetValue()));
    else
        GameTooltip:SetText(format("%.2f", self:GetValue()));
    end
end

function MonkeyBuddyOptions()
--[[
-- Create main frame for information text
local MonkeyBuddyOptions = CreateFrame("FRAME", "MonkeyBuddyOptions")
MonkeyBuddyOptions.name = MONKEYBUDDY_TITLE
InterfaceOptions_AddCategory(MonkeyBuddyOptions)

local MonkeyBuddyOptionsText1 = MonkeyBuddyOptions:CreateFontString(nil, "ARTWORK")
MonkeyBuddyOptionsText1:SetFontObject(GameFontNormalLarge)
MonkeyBuddyOptionsText1:SetJustifyH("LEFT") 
MonkeyBuddyOptionsText1:SetJustifyV("TOP")
MonkeyBuddyOptionsText1:ClearAllPoints()
MonkeyBuddyOptionsText1:SetPoint("TOPLEFT", 16, -16)
MonkeyBuddyOptionsText1:SetText(MONKEYBUDDY_FRAME_TITLE)

local MonkeyBuddyOptionsText2 = MonkeyBuddyOptions:CreateFontString(nil, "ARTWORK")
MonkeyBuddyOptionsText2:SetFontObject(GameFontNormalSmall)
MonkeyBuddyOptionsText2:SetJustifyH("LEFT") 
MonkeyBuddyOptionsText2:SetJustifyV("TOP")
MonkeyBuddyOptionsText2:SetTextColor(1, 1, 1)
MonkeyBuddyOptionsText2:ClearAllPoints()
MonkeyBuddyOptionsText2:SetPoint("TOPLEFT", MonkeyBuddyOptionsText1, "BOTTOMLEFT", 8, -16)
MonkeyBuddyOptionsText2:SetWidth(340)
MonkeyBuddyOptionsText2:SetText(MONKEYBUDDY_GUI_TEXT)

local MonkeyBuddyOptionsText3 = MonkeyBuddyOptions:CreateFontString(nil, "ARTWORK")
MonkeyBuddyOptionsText3:SetFontObject(GameFontNormalLarge)
MonkeyBuddyOptionsText3:SetJustifyH("LEFT") 
MonkeyBuddyOptionsText3:SetJustifyV("TOP")
MonkeyBuddyOptionsText3:SetTextColor(0, 1, 0)
MonkeyBuddyOptionsText3:ClearAllPoints()
MonkeyBuddyOptionsText3:SetPoint("TOPLEFT", MonkeyBuddyOptionsText2, "BOTTOMLEFT", 0, -16)
MonkeyBuddyOptionsText3:SetWidth(340)
MonkeyBuddyOptionsText3:SetText(MONKEYBUDDY_GUI_MBLOADED)

local MonkeyBuddyOptionsTextS= MonkeyBuddyOptions:CreateFontString(nil, "ARTWORK")
MonkeyBuddyOptionsTextS:SetFontObject(GameFontNormalLarge)
MonkeyBuddyOptionsTextS:SetJustifyH("LEFT") 
MonkeyBuddyOptionsTextS:SetJustifyV("TOP")
MonkeyBuddyOptionsTextS:SetTextColor(1, 1, 1)
MonkeyBuddyOptionsTextS:ClearAllPoints()
MonkeyBuddyOptionsTextS:SetPoint("TOPLEFT", MonkeyBuddyOptionsText3, "BOTTOMLEFT", 0, -16)
MonkeyBuddyOptionsTextS:SetWidth(340)
MonkeyBuddyOptionsTextS:SetText(MONKEYBUDDY_GUI_MMINSTALLED)

local MonkeyBuddyStatus = CreateFrame("FRAME", "MBStatus", MonkeyBuddyOptions)
MonkeyBuddyStatus:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 16, edgeSize = 16, 
	insets = { left = 4, right = 4, top = 4, bottom = 4 }})
MonkeyBuddyStatus:SetBackdropBorderColor(1, 1, 1, 1.0);
MonkeyBuddyStatus:SetBackdropColor(0, 0, 0, 0);
MonkeyBuddyStatus:SetWidth(345)
MonkeyBuddyStatus:SetHeight(65)
MonkeyBuddyStatus:ClearAllPoints()
MonkeyBuddyStatus:SetPoint("TOPLEFT", MonkeyBuddyOptionsText3, "BOTTOMLEFT", -6, -36)

local MonkeyBuddyOptionsText4 = MonkeyBuddyOptions:CreateFontString(nil, "ARTWORK")
MonkeyBuddyOptionsText4:SetFontObject(GameFontNormalLarge)
MonkeyBuddyOptionsText4:SetJustifyH("LEFT") 
MonkeyBuddyOptionsText4:SetJustifyV("TOP")
if (GetAddOnDependencies("MonkeyQuest") ~= nil) then 
MonkeyBuddyOptionsText4:SetTextColor(0, 1, 0)
MonkeyBuddyOptionsText4:SetText(GetAddOnMetadata("MonkeyQuest", "title")) else
MonkeyBuddyOptionsText4:SetTextColor(1, 0, 0) 
MonkeyBuddyOptionsText4:SetText("MonkeyQuest") end
MonkeyBuddyOptionsText4:ClearAllPoints()
MonkeyBuddyOptionsText4:SetPoint("TOPLEFT", MonkeyBuddyOptionsText3, "BOTTOMLEFT", 8, -45)
MonkeyBuddyOptionsText4:SetWidth(340)

local MonkeyBuddyOptionsText5 = MonkeyBuddyOptions:CreateFontString(nil, "ARTWORK")
MonkeyBuddyOptionsText5:SetFontObject(GameFontNormalLarge)
MonkeyBuddyOptionsText5:SetJustifyH("LEFT") 
MonkeyBuddyOptionsText5:SetJustifyV("TOP")
if (GetAddOnDependencies("MonkeyQuestLog") ~= nil) then 
MonkeyBuddyOptionsText5:SetTextColor(0, 1, 0)
MonkeyBuddyOptionsText5:SetText(GetAddOnMetadata("MonkeyQuestLog", "title")) else
MonkeyBuddyOptionsText5:SetTextColor(1, 0, 0) 
MonkeyBuddyOptionsText5:SetText("MonkeyQuestLog") end
MonkeyBuddyOptionsText5:ClearAllPoints()
MonkeyBuddyOptionsText5:SetPoint("TOPLEFT", MonkeyBuddyOptionsText4, "BOTTOMLEFT", 0, -14)
MonkeyBuddyOptionsText5:SetWidth(340)


local MonkeyBuddyOptionsText6 = MonkeyBuddyOptions:CreateFontString(nil, "ARTWORK")
MonkeyBuddyOptionsText6:SetFontObject(GameFontNormalLarge)
MonkeyBuddyOptionsText6:SetJustifyH("LEFT") 
MonkeyBuddyOptionsText6:SetJustifyV("TOP")
if (GetAddOnDependencies("MonkeyClock") ~= nil) then 
MonkeyBuddyOptionsText6:SetTextColor(0, 1, 0)
MonkeyBuddyOptionsText6:SetText(GetAddOnMetadata("MonkeyClock", "title")) else
MonkeyBuddyOptionsText6:SetTextColor(1, 0, 0) 
MonkeyBuddyOptionsText6:SetText("MonkeyClock") end
MonkeyBuddyOptionsText6:ClearAllPoints()
MonkeyBuddyOptionsText6:SetPoint("TOPLEFT", MonkeyBuddyOptionsText5, "BOTTOMLEFT", 0, -14)
MonkeyBuddyOptionsText6:SetWidth(340)

local MonkeyBuddyOptionsText7 = MonkeyBuddyOptions:CreateFontString(nil, "ARTWORK")
MonkeyBuddyOptionsText7:SetFontObject(GameFontNormalLarge)
MonkeyBuddyOptionsText7:SetJustifyH("LEFT") 
MonkeyBuddyOptionsText7:SetJustifyV("TOP")
if (GetAddOnDependencies("MonkeySpeed") ~= nil) then 
MonkeyBuddyOptionsText7:SetTextColor(0, 1, 0)
MonkeyBuddyOptionsText7:SetText(GetAddOnMetadata("MonkeySpeed", "title")) else
MonkeyBuddyOptionsText7:SetTextColor(1, 0, 0) 
MonkeyBuddyOptionsText7:SetText("MonkeySpeed") end
MonkeyBuddyOptionsText7:ClearAllPoints()
MonkeyBuddyOptionsText7:SetPoint("TOPLEFT", MonkeyBuddyOptionsText6, "BOTTOMLEFT", 0, -14)
MonkeyBuddyOptionsText7:SetWidth(340)


local MonkeyBuddyOptionsTextB= MonkeyBuddyOptions:CreateFontString(nil, "ARTWORK")
MonkeyBuddyOptionsTextB:SetFontObject(GameFontNormalLarge)
MonkeyBuddyOptionsTextB:SetJustifyH("LEFT") 
MonkeyBuddyOptionsTextB:SetJustifyV("TOP")
MonkeyBuddyOptionsTextB:ClearAllPoints()
MonkeyBuddyOptionsTextB:SetPoint("TOPLEFT", MonkeyBuddyOptionsText7, "BOTTOMLEFT", -8, -14)
MonkeyBuddyOptionsTextB:SetWidth(340)
MonkeyBuddyOptionsTextB:SetText("MonkeyBuddy:")

local MonkeyBuddyStatus = CreateFrame("FRAME", "MBIconOption", MonkeyBuddyOptions)
MonkeyBuddyStatus:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 16, edgeSize = 16, 
	insets = { left = 4, right = 4, top = 4, bottom = 4 }})
MonkeyBuddyStatus:SetBackdropBorderColor(1, 1, 1, 1.0);
MonkeyBuddyStatus:SetBackdropColor(0, 0, 0, 0);
MonkeyBuddyStatus:SetWidth(345)
MonkeyBuddyStatus:SetHeight(35)
MonkeyBuddyStatus:ClearAllPoints()
MonkeyBuddyStatus:SetPoint("TOPLEFT", MonkeyBuddyOptionsTextB, "BOTTOMLEFT", -6, -4)

MonkeyBuddyOptionsCheckButton = CreateFrame("CheckButton", "MBIconCheckButton", MonkeyBuddyOptions, "MonkeyBuddyOptionsCheckButtonTemplate")
MonkeyBuddyOptionsCheckButton:ClearAllPoints()
MonkeyBuddyOptionsCheckButton:SetPoint("TOPLEFT", MonkeyBuddyOptionsTextB, "BOTTOMLEFT", 2, -11)
if (MonkeyBuddyConfig[MonkeyBuddy.m_strPlayer].m_bDismissed == false) then
MonkeyBuddyOptionsCheckButton:SetChecked(true) else
MonkeyBuddyOptionsCheckButton:SetChecked(false) end

local MonkeyBuddyOptionsTextCheck= MonkeyBuddyOptions:CreateFontString(nil, "ARTWORK")
MonkeyBuddyOptionsTextCheck:SetFontObject(GameFontNormal)
MonkeyBuddyOptionsTextCheck:SetJustifyH("LEFT") 
MonkeyBuddyOptionsTextCheck:SetJustifyV("TOP")
MonkeyBuddyOptionsTextCheck:SetTextColor(1, 1, 1)
MonkeyBuddyOptionsTextCheck:ClearAllPoints()
MonkeyBuddyOptionsTextCheck:SetPoint("TOPLEFT", MonkeyBuddyOptionsTextB, "BOTTOMLEFT", 24, -15)
MonkeyBuddyOptionsTextCheck:SetWidth(340)
MonkeyBuddyOptionsTextCheck:SetText(MONKEYBUDDY_GUI_MBMINIMAP)

if (IsAddOnLoaded("MonkeyQuest") ~= nil) then
local MonkeyBuddyOptionsTextM = MonkeyBuddyOptions:CreateFontString(nil, "ARTWORK")
MonkeyBuddyOptionsTextM:SetFontObject(GameFontNormalLarge)
MonkeyBuddyOptionsTextM:SetJustifyH("LEFT") 
MonkeyBuddyOptionsTextM:SetJustifyV("TOP")
MonkeyBuddyOptionsTextM:ClearAllPoints()
MonkeyBuddyOptionsTextM:SetPoint("TOPLEFT", MonkeyBuddyOptionsTextB, "BOTTOMLEFT", 0, -42)
MonkeyBuddyOptionsTextM:SetWidth(340)
MonkeyBuddyOptionsTextM:SetText(MONKEYBUDDY_GUI_MQEXTRA)

local MonkeyQuestDailies = CreateFrame("FRAME", "MQDailiesOption", MonkeyBuddyOptions)
MonkeyQuestDailies:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 16, edgeSize = 16, 
	insets = { left = 4, right = 4, top = 4, bottom = 4 }})
MonkeyQuestDailies:SetBackdropBorderColor(1, 1, 1, 1.0);
MonkeyQuestDailies:SetBackdropColor(0, 0, 0, 0);
MonkeyQuestDailies:SetWidth(345)
MonkeyQuestDailies:SetHeight(35)
MonkeyQuestDailies:ClearAllPoints()
MonkeyQuestDailies:SetPoint("TOPLEFT", MonkeyBuddyOptionsTextM, "BOTTOMLEFT", -6, -4)

MonkeyQuestDailiesCheckButton = CreateFrame("CheckButton", "MQDailiesCheckButton", MonkeyBuddyOptions, "MonkeyQuestDailiesCheckButtonTemplate")
MonkeyQuestDailiesCheckButton:ClearAllPoints()
MonkeyQuestDailiesCheckButton:SetPoint("TOPLEFT", MonkeyBuddyOptionsTextM, "BOTTOMLEFT", 2, -11)
if (MonkeyBuddyConfig[MonkeyBuddy.m_strPlayer].m_bDailies == true) then
MonkeyQuestDailiesCheckButton:SetChecked(true) else
MonkeyQuestDailiesCheckButton:SetChecked(false) end

local MonkeyQuestDailiesTextCheck = MonkeyBuddyOptions:CreateFontString(nil, "ARTWORK")
MonkeyQuestDailiesTextCheck:SetFontObject(GameFontNormal)
MonkeyQuestDailiesTextCheck:SetJustifyH("LEFT") 
MonkeyQuestDailiesTextCheck:SetJustifyV("TOP")
MonkeyQuestDailiesTextCheck:SetTextColor(1, 1, 1)
MonkeyQuestDailiesTextCheck:ClearAllPoints()
MonkeyQuestDailiesTextCheck:SetPoint("TOPLEFT", MonkeyBuddyOptionsTextM, "BOTTOMLEFT", 24, -15)
MonkeyQuestDailiesTextCheck:SetWidth(340)
MonkeyQuestDailiesTextCheck:SetText(MONKEYBUDDY_GUI_MQEDAILY)

end

local MonkeyBuddyOptionsTextMB = MonkeyBuddyOptions:CreateFontString(nil, "ARTWORK")
MonkeyBuddyOptionsTextMB:SetFontObject(GameFontNormal)
MonkeyBuddyOptionsTextMB:SetJustifyH("LEFT") 
MonkeyBuddyOptionsTextMB:SetJustifyV("TOP")
MonkeyBuddyOptionsTextMB:SetTextColor(1, 1, 1)
MonkeyBuddyOptionsTextMB:ClearAllPoints()
MonkeyBuddyOptionsTextMB:SetPoint("TOPLEFT", MonkeyBuddyOptionsTextB, "BOTTOMLEFT", 5, -106)
MonkeyBuddyOptionsTextMB:SetWidth(340)
MonkeyBuddyOptionsTextMB:SetText(MONKEYBUDDY_GUI_MBOPENCFG)

local MonkeyBuddyOptionsMBButton = CreateFrame("Button", "MBOptionsButton", MonkeyBuddyOptions, "UIPanelButtonTemplate")
MonkeyBuddyOptionsMBButton:SetNormalFontObject(GameFontHighlightSmall)
MonkeyBuddyOptionsMBButton:SetHighlightFontObject(GameFontHighlightSmall)
MonkeyBuddyOptionsMBButton:SetWidth(100)
MonkeyBuddyOptionsMBButton:SetHeight(26)
MonkeyBuddyOptionsMBButton:SetText("MonkeyBuddy")
MonkeyBuddyOptionsMBButton:RegisterForClicks("LeftButtonUp")
MonkeyBuddyOptionsMBButton:ClearAllPoints()
MonkeyBuddyOptionsMBButton:SetPoint("TOPLEFT", MonkeyBuddyOptionsTextB, "BOTTOMLEFT", 235, -100)
MonkeyBuddyOptionsMBButton:SetScript("OnClick", MBButton_OnClick)
MonkeyBuddyOptionsMBButton:SetScript("OnMouseDown", MBButton_MouseDown)
MonkeyBuddyOptionsMBButton:SetScript("OnMouseUp", MBButton_MouseUp)
]]--
end