-- Namespaces
-- core - table (namespace) shared between every lua file
local addonName, core = ...;
core.UIConfig = {};

-- Defaults
UISettingsGlobal = {
    useBlizzardBlockValue = false;
    statsPanelHidden = false;
}

UISettingsCharacter = {
    selectedLeftStatsCategory = 1;
    selectedRightStatsCategory = 2;
    showStatsFromArgentDawnItems = true;
    -- side panel stats options
    sideStatsFrameHidden = false;
    showSideStatsMelee = true;
    showSideStatsRanged = true;
    showSideStatsSpell = true;
    showSideStatsDefense = true;
}

-- for easier referencing the core config
local UIConfig = core.UIConfig;
local CSC_UIFrame = core.UIConfig;
local CSC_ConfigFrame = { };

local statsDropdownList = {
    PLAYERSTAT_BASE_STATS,
    PLAYERSTAT_MELEE_COMBAT,
    PLAYERSTAT_RANGED_COMBAT,
    PLAYERSTAT_SPELL_COMBAT,
    PLAYERSTAT_DEFENSES
}

local NUM_STATS_TO_SHOW = 6;
local LeftStatsTable = { }
local RightStatsTable = { }

local SideCategoryStatsMelee = { 
    frames = { };
    numFrames = 7;
    frameLabel = "Melee";
};
local SideCategoryStatsRanged = {
    frames = { };
    numFrames = 7;
    frameLabel = "Ranged";
};
local SideCategoryStatsSpell = { 
    frames = { };
    numFrames = 5;
    frameLabel = "Spell";
};
local SideCategoryStatsDefense = {
    frames = { };
    numFrames = 5;
    frameLabel = "Defense";
};

local function CSC_ResetStatFrames(statFrames)

    for i=1, NUM_STATS_TO_SHOW, 1 do
        statFrames[i]:Hide();
        statFrames[i]:SetScript("OnEnter", statFrames[i].OnEnterCallback);
        statFrames[i].tooltip = nil;
        statFrames[i].tooltip2 = nil;
        statFrames[i].tooltip3 = nil;
    end
end

local function CSC_ShowStatFrames(statFrames, category)
    local statsToShow = NUM_STATS_TO_SHOW;

    if (category == PLAYERSTAT_RANGED_COMBAT) then
        statsToShow = statsToShow - 1;
    end

    for i=1, statsToShow, 1 do
        statFrames[i]:Show();
    end
end

function UIConfig:InitializeStatsFrames(leftParentFrame, rightParentFrame)
    local offsetStepY = 15;
    local accumulatedOffsetY = 0;
    
    for i = 1, NUM_STATS_TO_SHOW do
        accumulatedOffsetY = accumulatedOffsetY + offsetStepY;
        local actualOffset = accumulatedOffsetY;
        
        if i == 1 then 
            actualOffset = 32;
            accumulatedOffsetY = 32;
        end

        LeftStatsTable[i] = CreateFrame("Frame", nil, leftParentFrame, "StatFrameTemplate");
        LeftStatsTable[i]:SetPoint("LEFT", leftParentFrame, "TOPLEFT", 20, -actualOffset);
        LeftStatsTable[i]:SetWidth(110);
        LeftStatsTable[i].OnEnterCallback = LeftStatsTable[i]:GetScript("OnEnter");
        LeftStatsTable[i].Value = LeftStatsTable[i]:CreateFontString(nil, "BACKGROUND", "GameFontHighlightSmall");
        LeftStatsTable[i].Value:SetPoint("RIGHT", LeftStatsTable[i].Label, "RIGHT", 0, 0);
        LeftStatsTable[i].Value:SetJustifyH("RIGHT");
        LeftStatsTable[i]:SetScript("OnMouseDown", function()
            UIConfig:ToggleSideStatsFrame();
        end)

        RightStatsTable[i] = CreateFrame("Frame", nil, rightParentFrame, "StatFrameTemplate");
        RightStatsTable[i]:SetPoint("LEFT", rightParentFrame, "TOPLEFT", 20, -actualOffset);
        RightStatsTable[i]:SetWidth(110);
        RightStatsTable[i].OnEnterCallback = RightStatsTable[i]:GetScript("OnEnter");
        RightStatsTable[i].Value = RightStatsTable[i]:CreateFontString(nil, "BACKGROUND", "GameFontHighlightSmall");
        RightStatsTable[i].Value:SetPoint("RIGHT", RightStatsTable[i].Label, "RIGHT", 0, 0);
        RightStatsTable[i].Value:SetJustifyH("RIGHT");
        RightStatsTable[i]:SetScript("OnMouseDown", function()
            UIConfig:ToggleSideStatsFrame();
        end)
    end
end

function UIConfig:SetCharacterStats(statsTable, category)

    CSC_ResetStatFrames(statsTable);

    local unit = "player";

    if category == PLAYERSTAT_BASE_STATS then
        CSC_PaperDollFrame_SetPrimaryStats(statsTable, unit);
        CSC_PaperDollFrame_SetArmor(statsTable[6], unit);
    elseif category == PLAYERSTAT_DEFENSES then
        CSC_PaperDollFrame_SetArmor(statsTable[1], unit);
        CSC_PaperDollFrame_SetDefense(statsTable[2], unit);
        CSC_PaperDollFrame_SetDodge(statsTable[3]);
        CSC_PaperDollFrame_SetParry(statsTable[4]);
        CSC_PaperDollFrame_SetBlock(statsTable[5], unit);
        CSC_PaperDollFrame_SetResilience(statsTable[6]);
    elseif category == PLAYERSTAT_MELEE_COMBAT then
        if (UISettingsCharacter.showStatsFromArgentDawnItems) then
            CSC_CacheAPFromADItems(unit);
        end
        
        CSC_PaperDollFrame_SetDamage(statsTable[1], unit, category);
        CSC_PaperDollFrame_SetMeleeAttackPower(statsTable[2], unit);
        CSC_PaperDollFrame_SetAttackSpeed(statsTable[3], unit);
        CSC_PaperDollFrame_SetCritChance(statsTable[4], unit);
        CSC_PaperDollFrame_SetHitRating(statsTable[5], unit, CR_HIT_MELEE);
        CSC_PaperDollFrame_SetExpertise(statsTable[6], unit);
    elseif category == PLAYERSTAT_RANGED_COMBAT then
        if (UISettingsCharacter.showStatsFromArgentDawnItems) then
            CSC_CacheAPFromADItems(unit);
        end
        CSC_PaperDollFrame_SetDamage(statsTable[1], unit, category);
        CSC_PaperDollFrame_SetRangedAttackPower(statsTable[2], unit);
        CSC_PaperDollFrame_SetRangedAttackSpeed(statsTable[3], unit);
        CSC_PaperDollFrame_SetRangedCritChance(statsTable[4], unit);
        CSC_PaperDollFrame_SetHitRating(statsTable[5], unit, CR_HIT_RANGED);
    elseif category == PLAYERSTAT_SPELL_COMBAT then
        CSC_PaperDollFrame_SetSpellPower(statsTable[1], unit);
        CSC_PaperDollFrame_SetHealing(statsTable[2], unit);
        CSC_PaperDollFrame_SetManaRegen(statsTable[3], unit);
        CSC_PaperDollFrame_SetSpellCritChance(statsTable[4], unit);
        CSC_PaperDollFrame_SetHitRating(statsTable[5], unit, CR_HIT_SPELL);
        CSC_PaperDollFrame_SetSpellHaste(statsTable[6]);
    end

    CSC_ShowStatFrames(statsTable, category);
end

function UIConfig:InitializeSideStatsCategory(frameObject, accumulatedOffsetY, offsetStepY)
    local accumulatedOffset = accumulatedOffsetY;
    local numFrames = frameObject.numFrames;

    for i = 1, numFrames do
        accumulatedOffset = accumulatedOffset + offsetStepY;
        local actualOffset = accumulatedOffset;

        frameObject.frames[i] = CreateFrame("Frame", nil, CSC_UIFrame.SideStatsFrame.ScrollChild, "StatFrameTemplate");
        frameObject.frames[i]:SetPoint("LEFT", CSC_UIFrame.SideStatsFrame.ScrollChild, "TOPLEFT", 50, -actualOffset);
        frameObject.frames[i]:SetWidth(140);
        frameObject.frames[i].Value = frameObject.frames[i]:CreateFontString(nil, "BACKGROUND", "GameFontHighlightSmall");
        frameObject.frames[i].Value:SetPoint("RIGHT", frameObject.frames[i].Label, "RIGHT", 0, 0);
        frameObject.frames[i].Value:SetJustifyH("RIGHT");
        
        if i == 1 then
            frameObject.frames[i].Label = frameObject.frames[i]:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            frameObject.frames[i].Label:SetText(frameObject.frameLabel)
            frameObject.frames[i].Label:SetTextColor(1, 1, 1)
            frameObject.frames[i].Label:SetPoint("CENTER", 0, 0)

            frameObject.frames[i].BackgroundTex = frameObject.frames[i]:CreateTexture(nil, "ARTWORK");
            frameObject.frames[i].BackgroundTex:SetAllPoints(frameObject.frames[i]);
            frameObject.frames[i].BackgroundTex:SetTexture("Interface\\PaperDollInfoFrame\\PaperDollInfoPart1");
            frameObject.frames[i].BackgroundTex:SetTexCoord(0, 0.193359375, 0.69921875, 0.736328125);
        else
            frameObject.frames[i].BackgroundTex = frameObject.frames[i]:CreateTexture(nil, "BACKGROUND");
            frameObject.frames[i].BackgroundTex:SetAllPoints(frameObject.frames[i]);
            local alpha = 0;
            if i % 2 == 0 then alpha = 0.3 end
            frameObject.frames[i].BackgroundTex:SetColorTexture(0.3, 0.2, 0, alpha);
        end
    end
    accumulatedOffset = accumulatedOffset + 10;
    
    return accumulatedOffset;
end

function UIConfig:InitializeSideStatsCategories()
    local offsetStepY = 15;
    local accumulatedOffsetY = 0;
    
    if UISettingsCharacter.showSideStatsMelee then
        accumulatedOffsetY = UIConfig:InitializeSideStatsCategory(SideCategoryStatsMelee, accumulatedOffsetY, offsetStepY);
    end

    if UISettingsCharacter.showSideStatsRanged then
        accumulatedOffsetY = UIConfig:InitializeSideStatsCategory(SideCategoryStatsRanged, accumulatedOffsetY, offsetStepY);
    end

    if UISettingsCharacter.showSideStatsSpell then
        accumulatedOffsetY = UIConfig:InitializeSideStatsCategory(SideCategoryStatsSpell, accumulatedOffsetY, offsetStepY);
    end

    if UISettingsCharacter.showSideStatsDefense then
        accumulatedOffsetY = UIConfig:InitializeSideStatsCategory(SideCategoryStatsDefense, accumulatedOffsetY, offsetStepY);
    end
end

function UIConfig:SetCharacterSideStats()
    local unit = "player";

    -- frames[1] is reserved for the category label

    if UISettingsCharacter.showSideStatsMelee and SideCategoryStatsMelee.frames[1] then
        CSC_SideFrame_SetMeleeHitChance(SideCategoryStatsMelee.frames[2], unit);
        CSC_SideFrame_SetMissChance(SideCategoryStatsMelee.frames[3], unit, CR_HIT_MELEE);
        CSC_SideFrame_SetCritCap(SideCategoryStatsMelee.frames[4], unit, CR_HIT_MELEE);
        CSC_SideFrame_SetMeleeCritRating(SideCategoryStatsMelee.frames[5], unit);
        CSC_SideFrame_SetMeleeHasteRating(SideCategoryStatsMelee.frames[6], unit);
        CSC_SideFrame_SetArmorPenetration(SideCategoryStatsMelee.frames[7], unit);
    end

    if UISettingsCharacter.showSideStatsRanged and SideCategoryStatsRanged.frames[1] then
        CSC_SideFrame_SetRangedHitChance(SideCategoryStatsRanged.frames[2], unit);
        CSC_SideFrame_SetMissChance(SideCategoryStatsRanged.frames[3], unit, CR_HIT_RANGED);
        CSC_SideFrame_SetCritCap(SideCategoryStatsRanged.frames[4], unit, CR_HIT_RANGED);
        CSC_SideFrame_SetRangedCritRating(SideCategoryStatsRanged.frames[5], unit);
        CSC_SideFrame_SetRangedHasteRating(SideCategoryStatsRanged.frames[6], unit);
        CSC_SideFrame_SetArmorPenetration(SideCategoryStatsRanged.frames[7], unit);
    end

    if UISettingsCharacter.showSideStatsSpell and SideCategoryStatsSpell.frames[1] then
        CSC_SideFrame_SetSpellHitChance(SideCategoryStatsSpell.frames[2], unit);
        CSC_SideFrame_SetSpellCritRating(SideCategoryStatsSpell.frames[3], unit);
        CSC_SideFrame_SetSpellHastePercent(SideCategoryStatsSpell.frames[4], unit);
        CSC_SideFrame_SetSpellPenetration(SideCategoryStatsSpell.frames[5], unit);
    end

    if UISettingsCharacter.showSideStatsDefense and SideCategoryStatsDefense.frames[1] then
        CSC_SideFrame_SetDefenseRating(SideCategoryStatsDefense.frames[2], unit);
        CSC_SideFrame_SetDodgeRating(SideCategoryStatsDefense.frames[3], unit);
        CSC_SideFrame_SetParryRating(SideCategoryStatsDefense.frames[4], unit);
        CSC_SideFrame_SetBlockRating(SideCategoryStatsDefense.frames[5], unit);
    end
end

function UIConfig:InitializeSideStatsFrame()

    CSC_UIFrame.SideStatsFrame = CreateFrame("Frame", "CSC_SideStatsFrame", PaperDollItemsFrame, "BasicFrameTemplateWithInset");
    CSC_UIFrame.SideStatsFrame:SetSize(190, 423);
    CSC_UIFrame.SideStatsFrame:SetPoint("LEFT", PaperDollItemsFrame, "RIGHT", -30,  30);
    CSC_UIFrame.SideStatsFrame.title = CSC_UIFrame.SideStatsFrame:CreateFontString(nil, "OVERLAY");
    CSC_UIFrame.SideStatsFrame.title:SetFontObject("GameFontHighlight");
    CSC_UIFrame.SideStatsFrame.title:SetPoint("CENTER", CSC_UIFrame.SideStatsFrame.TitleBg, "CENTER", 0,  0);
    CSC_UIFrame.SideStatsFrame.title:SetText("CharacterStatsTBC");

    CSC_UIFrame.SideStatsFrame.ScrollFrame = CreateFrame("ScrollFrame", nil, CSC_UIFrame.SideStatsFrame, "UIPanelScrollFrameTemplate");
    CSC_UIFrame.SideStatsFrame.ScrollFrame:SetPoint("TOPLEFT", CSC_UIFrame.SideStatsFrame, "TOPLEFT", -35, -30);
    CSC_UIFrame.SideStatsFrame.ScrollFrame:SetPoint("BOTTOMRIGHT", CSC_UIFrame.SideStatsFrame, "BOTTOMRIGHT", -35, 10);

    CSC_UIFrame.SideStatsFrame.ScrollChild = CreateFrame("Frame", nil, CSC_UIFrame.SideStatsFrame.ScrollFrame);
    CSC_UIFrame.SideStatsFrame.ScrollChild:SetSize(200, 420);
    CSC_UIFrame.SideStatsFrame.ScrollFrame:SetScrollChild(CSC_UIFrame.SideStatsFrame.ScrollChild);
    --CSC_UIFrame.SideStatsFrame.ScrollFrame:SetScript("OnMouseWheel", function() end);

    CSC_UIFrame.SideStatsFrame.CloseButton:HookScript("OnClick", function()
        UISettingsCharacter.sideStatsFrameHidden = true;
    end)

    PaperDollItemsFrame:HookScript("OnShow", function()
       if UISettingsCharacter.sideStatsFrameHidden then
            CSC_UIFrame.SideStatsFrame:Hide();
       end
    end)

    UIConfig:InitializeSideStatsCategories();
end

function UIConfig:CreateMenu()
    if not __DEBUG__ then
        -- Hide the default stats
        CharacterAttributesFrame:Hide();
    end

    local offsetX = 50;
    local offsetY = 85;

    if __DEBUG__ then
        offsetY = -120;
    end

    CSC_UIFrame.CharacterStatsPanel = CreateFrame("Frame", nil, CharacterFrame); --CharacterFrameInsetRight
	CSC_UIFrame.CharacterStatsPanel:SetPoint("LEFT", CharacterFrame, "BOTTOMLEFT", offsetX, offsetY);
	CSC_UIFrame.CharacterStatsPanel:SetHeight(320);
    CSC_UIFrame.CharacterStatsPanel:SetWidth(200);

    UIConfig:SetupDropdown();
    UIConfig:SetupConfigInterface();

    UIConfig:InitializeStatsFrames(CSC_UIFrame.CharacterStatsPanel.leftStatsDropDown, CSC_UIFrame.CharacterStatsPanel.rightStatsDropDown);
    UIConfig:InitializeSideStatsFrame();
    UIConfig:UpdateStats();
    UIConfig:UpdateSideStats();
end

function UIConfig:UpdateStats()
    UIConfig:SetCharacterStats(LeftStatsTable, statsDropdownList[UISettingsCharacter.selectedLeftStatsCategory]);
    UIConfig:SetCharacterStats(RightStatsTable, statsDropdownList[UISettingsCharacter.selectedRightStatsCategory]);
end

function UIConfig:UpdateSideStats()
    if UISettingsCharacter.sideStatsFrameHidden or not CharacterFrame:IsVisible() then return end;
    UIConfig:SetCharacterSideStats();
end

local function OnClickLeftStatsDropdown(self)
    UISettingsCharacter.selectedLeftStatsCategory = self:GetID();
    UIDropDownMenu_SetSelectedID(CSC_UIFrame.CharacterStatsPanel.leftStatsDropDown, UISettingsCharacter.selectedLeftStatsCategory);
    UIConfig:SetCharacterStats(LeftStatsTable, statsDropdownList[UISettingsCharacter.selectedLeftStatsCategory]);
end

local function OnClickRightStatsDropdown(self)
    UISettingsCharacter.selectedRightStatsCategory = self:GetID();
    UIDropDownMenu_SetSelectedID(CSC_UIFrame.CharacterStatsPanel.rightStatsDropDown, UISettingsCharacter.selectedRightStatsCategory);
    UIConfig:SetCharacterStats(RightStatsTable, statsDropdownList[UISettingsCharacter.selectedRightStatsCategory]);
end

function UIConfig:InitializeLeftStatsDropdown(self, level)
    local info = UIDropDownMenu_CreateInfo();
    for k,v in pairs(statsDropdownList) do
        info.text = v;
        info.func = OnClickLeftStatsDropdown;
        info.checked = false;
        UIDropDownMenu_AddButton(info, level);
     end
end

function UIConfig:InitializeRightStatsDropdown(self, level)
    local info = UIDropDownMenu_CreateInfo();
    for k,v in pairs(statsDropdownList) do
        info.text = v;
        info.func = OnClickRightStatsDropdown;
        info.checked = false;
        UIDropDownMenu_AddButton(info, level);
     end
end

function UIConfig:SetupDropdown()

    CSC_UIFrame.CharacterStatsPanel.leftStatsDropDown = CreateFrame("Frame", nil, CSC_UIFrame.CharacterStatsPanel, "UIDropDownMenuTemplate");
    CSC_UIFrame.CharacterStatsPanel.leftStatsDropDown:SetPoint("TOPLEFT", CSC_UIFrame.CharacterStatsPanel, "TOPLEFT", 0, 0);

    CSC_UIFrame.CharacterStatsPanel.rightStatsDropDown = CreateFrame("Frame", nil, CSC_UIFrame.CharacterStatsPanel, "UIDropDownMenuTemplate");
    CSC_UIFrame.CharacterStatsPanel.rightStatsDropDown:SetPoint("TOPLEFT", CSC_UIFrame.CharacterStatsPanel, "TOPLEFT", 115, 0);

    UIDropDownMenu_Initialize(CSC_UIFrame.CharacterStatsPanel.leftStatsDropDown, UIConfig.InitializeLeftStatsDropdown);
    UIDropDownMenu_SetSelectedID(CSC_UIFrame.CharacterStatsPanel.leftStatsDropDown, UISettingsCharacter.selectedLeftStatsCategory);
    UIDropDownMenu_SetWidth(CSC_UIFrame.CharacterStatsPanel.leftStatsDropDown, 99);
    UIDropDownMenu_JustifyText(CSC_UIFrame.CharacterStatsPanel.leftStatsDropDown, "LEFT");

    UIDropDownMenu_Initialize(CSC_UIFrame.CharacterStatsPanel.rightStatsDropDown, UIConfig.InitializeRightStatsDropdown);
    UIDropDownMenu_SetSelectedID(CSC_UIFrame.CharacterStatsPanel.rightStatsDropDown, UISettingsCharacter.selectedRightStatsCategory);
    UIDropDownMenu_SetWidth(CSC_UIFrame.CharacterStatsPanel.rightStatsDropDown, 99);
    UIDropDownMenu_JustifyText(CSC_UIFrame.CharacterStatsPanel.rightStatsDropDown, "LEFT");
end

function UIConfig:ToggleSideStatsFrame()
    if CSC_UIFrame.SideStatsFrame:IsVisible() then
        CSC_UIFrame.SideStatsFrame:Hide();
        UISettingsCharacter.sideStatsFrameHidden = true;
    else 
        CSC_UIFrame.SideStatsFrame:Show();
        UISettingsCharacter.sideStatsFrameHidden = false;
        CSC_UIFrame:UpdateSideStats();
    end
end

function UIConfig:SetupConfigInterface()

    CSC_ConfigFrame = CreateFrame("Frame", "CSC_InterfaceOptionsPanel", UIParent);
    CSC_ConfigFrame.name = "CharacterStatsTBC";
    InterfaceOptions_AddCategory(CSC_ConfigFrame);

    -- Title and font
    CSC_ConfigFrame.title = CreateFrame("Frame", CSC_ConfigFrame.name, CSC_ConfigFrame);
    CSC_ConfigFrame.title:SetPoint("TOPLEFT", CSC_ConfigFrame, "TOPLEFT", 10, -10);
    CSC_ConfigFrame.title:SetWidth(300);
    CSC_ConfigFrame.titleString = CSC_ConfigFrame.title:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    CSC_ConfigFrame.titleString:SetPoint("TOPLEFT", CSC_ConfigFrame, "TOPLEFT", 10, -10);
    CSC_ConfigFrame.titleString:SetText('|cff00c0ffCharacterStatsTBC|r');
    CSC_ConfigFrame.titleString:SetFont("Fonts\\FRIZQT__.tff", 20, "OUTLINE");

    -- Checkboxes
    CSC_ConfigFrame.chkBtnUseBlizzardBlockValue = CreateFrame("CheckButton", "default", CSC_ConfigFrame, "UICheckButtonTemplate");
    CSC_ConfigFrame.chkBtnUseBlizzardBlockValue:SetPoint("TOPLEFT", 20, -30);
    CSC_ConfigFrame.chkBtnUseBlizzardBlockValue.text:SetText("Use alternative Block Value calculation (Blizzard function)");
    CSC_ConfigFrame.chkBtnUseBlizzardBlockValue:SetChecked(UISettingsGlobal.useBlizzardBlockValue);
    CSC_ConfigFrame.chkBtnUseBlizzardBlockValue:SetScript("OnClick", 
    function()
        UISettingsGlobal.useBlizzardBlockValue = not UISettingsGlobal.useBlizzardBlockValue;
    end);

    CSC_ConfigFrame.chkBtnShowADStats = CreateFrame("CheckButton", "default", CSC_ConfigFrame, "UICheckButtonTemplate");
    CSC_ConfigFrame.chkBtnShowADStats:SetPoint("TOPLEFT", 20, -55);
    CSC_ConfigFrame.chkBtnShowADStats.text:SetText("Show AP and SP stats from Argent Dawn items.");
    CSC_ConfigFrame.chkBtnShowADStats:SetChecked(UISettingsCharacter.showStatsFromArgentDawnItems);
    CSC_ConfigFrame.chkBtnShowADStats:SetScript("OnClick", 
    function()
        UISettingsCharacter.showStatsFromArgentDawnItems = not UISettingsCharacter.showStatsFromArgentDawnItems;
    end);

    -- Side Stats frame options
    CSC_ConfigFrame.chkBtnShowSideStatsMelee = CreateFrame("CheckButton", "default", CSC_ConfigFrame, "UICheckButtonTemplate");
    CSC_ConfigFrame.chkBtnShowSideStatsMelee:SetPoint("TOPLEFT", 20, -110);
    CSC_ConfigFrame.chkBtnShowSideStatsMelee.text:SetText("Show Melee Category in the side stats window (Requires UI reload)");
    CSC_ConfigFrame.chkBtnShowSideStatsMelee:SetChecked(UISettingsCharacter.showSideStatsMelee);
    CSC_ConfigFrame.chkBtnShowSideStatsMelee:SetScript("OnClick", 
    function()
        UISettingsCharacter.showSideStatsMelee = not UISettingsCharacter.showSideStatsMelee;
    end);
    CSC_ConfigFrame.chkBtnShowSideStatsRanged = CreateFrame("CheckButton", "default", CSC_ConfigFrame, "UICheckButtonTemplate");
    CSC_ConfigFrame.chkBtnShowSideStatsRanged:SetPoint("TOPLEFT", 20, -135);
    CSC_ConfigFrame.chkBtnShowSideStatsRanged.text:SetText("Show Ranged Category in the side stats window (Requires UI reload)");
    CSC_ConfigFrame.chkBtnShowSideStatsRanged:SetChecked(UISettingsCharacter.showSideStatsRanged);
    CSC_ConfigFrame.chkBtnShowSideStatsRanged:SetScript("OnClick", 
    function()
        UISettingsCharacter.showSideStatsRanged = not UISettingsCharacter.showSideStatsRanged;
    end);
    CSC_ConfigFrame.chkBtnShowSideStatsSpell = CreateFrame("CheckButton", "default", CSC_ConfigFrame, "UICheckButtonTemplate");
    CSC_ConfigFrame.chkBtnShowSideStatsSpell:SetPoint("TOPLEFT", 20, -160);
    CSC_ConfigFrame.chkBtnShowSideStatsSpell.text:SetText("Show Spell Category in the side stats window (Requires UI reload)");
    CSC_ConfigFrame.chkBtnShowSideStatsSpell:SetChecked(UISettingsCharacter.showSideStatsSpell);
    CSC_ConfigFrame.chkBtnShowSideStatsSpell:SetScript("OnClick", 
    function()
        UISettingsCharacter.showSideStatsSpell = not UISettingsCharacter.showSideStatsSpell;
    end);
    CSC_ConfigFrame.chkBtnShowSideStatsDefense = CreateFrame("CheckButton", "default", CSC_ConfigFrame, "UICheckButtonTemplate");
    CSC_ConfigFrame.chkBtnShowSideStatsDefense:SetPoint("TOPLEFT", 20, -185);
    CSC_ConfigFrame.chkBtnShowSideStatsDefense.text:SetText("Show Defense Category in the side stats window (Requires UI reload)");
    CSC_ConfigFrame.chkBtnShowSideStatsDefense:SetChecked(UISettingsCharacter.showSideStatsDefense);
    CSC_ConfigFrame.chkBtnShowSideStatsDefense:SetScript("OnClick", 
    function()
        UISettingsCharacter.showSideStatsDefense = not UISettingsCharacter.showSideStatsDefense;
    end);
    
end

function UIConfig:SetStatsPanelVisibile(isVisible)
    UISettingsGlobal.statsPanelHidden = not isVisible;
end

-- Hook a custom function in order to extend the functionality of the default ToggleCharacter function
local function CSC_ToggleCharacterPostHook(tab, onlyShow)
    if (tab == "PaperDollFrame") then
        if (not UISettingsGlobal.statsPanelHidden) then
            CSC_UIFrame.CharacterStatsPanel:Show();
            CSC_UIFrame:UpdateStats();
        end
        CSC_UIFrame:UpdateSideStats();
    else
        CSC_UIFrame.CharacterStatsPanel:Hide();
    end
end
hooksecurefunc("ToggleCharacter", CSC_ToggleCharacterPostHook);

-- Serializing the DB
local function SerializeGlobalDatabase()
    if (CharacterStatsTbcDB == nil) then
        CharacterStatsTbcDB = UISettingsGlobal;
    end

    if (CharacterStatsTbcDB.useBlizzardBlockValue == nil) then
        CharacterStatsTbcDB.useBlizzardBlockValue = UISettingsGlobal.useBlizzardBlockValue;
    else
        UISettingsGlobal.useBlizzardBlockValue = CharacterStatsTbcDB.useBlizzardBlockValue;
    end

    -- Stats frame visibility
    if (CharacterStatsTbcDB.statsPanelHidden == nil) then
        CharacterStatsTbcDB.statsPanelHidden = UISettingsGlobal.statsPanelHidden;
    else
        UISettingsGlobal.statsPanelHidden = CharacterStatsTbcDB.statsPanelHidden;
    end
end

local function SerializeCharacterDatabase()
    if (CharacterStatsTbcCharacterDB == nil) then
        CharacterStatsTbcCharacterDB = UISettingsCharacter;
    end

    -- Left dropdown category
    if (CharacterStatsTbcCharacterDB.selectedLeftStatsCategory == nil) then
        CharacterStatsTbcCharacterDB.selectedLeftStatsCategory = UISettingsCharacter.selectedLeftStatsCategory;
    else
        UISettingsCharacter.selectedLeftStatsCategory = CharacterStatsTbcCharacterDB.selectedLeftStatsCategory;
    end

    -- Right dropdown category
    if (CharacterStatsTbcCharacterDB.selectedRightStatsCategory == nil) then
        CharacterStatsTbcCharacterDB.selectedRightStatsCategory = UISettingsCharacter.selectedRightStatsCategory;
    else
        UISettingsCharacter.selectedRightStatsCategory = CharacterStatsTbcCharacterDB.selectedRightStatsCategory;
    end

    -- Stats from AD items checkbox
    if (CharacterStatsTbcCharacterDB.showStatsFromArgentDawnItems == nil) then
        CharacterStatsTbcCharacterDB.showStatsFromArgentDawnItems = UISettingsCharacter.showStatsFromArgentDawnItems;
    else
        UISettingsCharacter.showStatsFromArgentDawnItems = CharacterStatsTbcCharacterDB.showStatsFromArgentDawnItems;
    end

    -- Side Stats frame status
    if (CharacterStatsTbcCharacterDB.sideStatsFrameHidden == nil) then
        CharacterStatsTbcCharacterDB.sideStatsFrameHidden = UISettingsCharacter.sideStatsFrameHidden;
    else
        UISettingsCharacter.sideStatsFrameHidden = CharacterStatsTbcCharacterDB.sideStatsFrameHidden;
    end

    -- Side Stats frame category visibilities
    if (CharacterStatsTbcCharacterDB.showSideStatsMelee == nil) then
        CharacterStatsTbcCharacterDB.showSideStatsMelee = UISettingsCharacter.showSideStatsMelee;
    else
        UISettingsCharacter.showSideStatsMelee = CharacterStatsTbcCharacterDB.showSideStatsMelee;
    end
    if (CharacterStatsTbcCharacterDB.showSideStatsRanged == nil) then
        CharacterStatsTbcCharacterDB.showSideStatsRanged = UISettingsCharacter.showSideStatsRanged;
    else
        UISettingsCharacter.showSideStatsRanged = CharacterStatsTbcCharacterDB.showSideStatsRanged;
    end
    if (CharacterStatsTbcCharacterDB.showSideStatsSpell == nil) then
        CharacterStatsTbcCharacterDB.showSideStatsSpell = UISettingsCharacter.showSideStatsSpell;
    else
        UISettingsCharacter.showSideStatsSpell = CharacterStatsTbcCharacterDB.showSideStatsSpell;
    end
    if (CharacterStatsTbcCharacterDB.showSideStatsDefense == nil) then
        CharacterStatsTbcCharacterDB.showSideStatsDefense = UISettingsCharacter.showSideStatsDefense;
    else
        UISettingsCharacter.showSideStatsDefense = CharacterStatsTbcCharacterDB.showSideStatsDefense;
    end
end

local dbLoader = CreateFrame("Frame");
dbLoader:RegisterEvent("ADDON_LOADED");
dbLoader:RegisterEvent("PLAYER_LOGOUT");

-- ADDON_LOADED is called after the code of the addon is being executed
-- Therefore I have to call any setup-functions dependent on the DB after the event (UIConfig:SetupDropdown())
function dbLoader:OnEvent(event, arg1)
    if (event == "ADDON_LOADED" and arg1 == "CharacterStatsTBC") then
        SerializeGlobalDatabase();
        SerializeCharacterDatabase();
        UIConfig:CreateMenu();
    elseif (event == "PLAYER_LOGOUT") then
        CharacterStatsTbcDB = UISettingsGlobal;
        CharacterStatsTbcCharacterDB = UISettingsCharacter;
    end
end

dbLoader:SetScript("OnEvent", dbLoader.OnEvent);
-- Serializing the DB