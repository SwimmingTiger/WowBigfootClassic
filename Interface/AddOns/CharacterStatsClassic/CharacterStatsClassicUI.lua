-- Namespaces
-- core - table (namespace) shared between every lua file
local addonName, core = ...;
core.UIConfig = {};

-- Defaults
local UISettingsGlobal = {
    shouldAddWeaponSkillToHit = false;
}

local UISettingsCharacter = {
    selectedLeftStatsCategory = 1;
    selectedRightStatsCategory = 2;
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

local NUM_STATS_TO_SHOW = 5;
local LeftStatsTable = { }
local RightStatsTable = { }

local function CSC_ResetStatFrames(statFrames)
    for i=1, NUM_STATS_TO_SHOW, 1 do
        statFrames[i]:Hide();
        statFrames[i]:SetScript("OnEnter", statFrames[i].OnEnterCallback);
        statFrames[i].tooltip = nil;
        statFrames[i].tooltip2 = nil;
        statFrames[i].tooltip3 = nil;
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

        LeftStatsTable[i] = CreateFrame("Frame", nil, leftParentFrame, "CharacterStatFrameTemplate");
        LeftStatsTable[i]:SetPoint("LEFT", leftParentFrame, "TOPLEFT", 10, -actualOffset);
        LeftStatsTable[i]:SetWidth(130);
        LeftStatsTable[i].OnEnterCallback = LeftStatsTable[i]:GetScript("OnEnter");

        RightStatsTable[i] = CreateFrame("Frame", nil, rightParentFrame, "CharacterStatFrameTemplate");
        RightStatsTable[i]:SetPoint("LEFT", rightParentFrame, "TOPLEFT", 10, -actualOffset);
        RightStatsTable[i]:SetWidth(130);
        RightStatsTable[i].OnEnterCallback = RightStatsTable[i]:GetScript("OnEnter");
    end
end

function UIConfig:SetCharacterStats(statsTable, category)

    CSC_ResetStatFrames(statsTable);

    if category == PLAYERSTAT_BASE_STATS then
        -- str, agility, stamina, intelect, spirit
        CSC_PaperDollFrame_SetPrimaryStats(statsTable, "player");
    elseif category == PLAYERSTAT_DEFENSES then
        -- armor, defense, dodge, parry, block
        CSC_PaperDollFrame_SetArmor(statsTable[1], "player");
        CSC_PaperDollFrame_SetDefense(statsTable[2], "player");
        CSC_PaperDollFrame_SetDodge(statsTable[3], "player");
        CSC_PaperDollFrame_SetParry(statsTable[4], "player");
        CSC_PaperDollFrame_SetBlock(statsTable[5], "player");
    elseif category == PLAYERSTAT_MELEE_COMBAT then
        -- damage, Att Power, speed, hit raiting, crit chance
        CSC_PaperDollFrame_SetDamage(statsTable[1], "player", category);
        CSC_PaperDollFrame_SetMeleeAttackPower(statsTable[2], "player");
        CSC_PaperDollFrame_SetAttackSpeed(statsTable[3], "player");
        CSC_PaperDollFrame_SetCritChance(statsTable[4], "player", category);
        CSC_PaperDollFrame_SetHitChance(statsTable[5], "player");
    elseif category == PLAYERSTAT_RANGED_COMBAT then
        CSC_PaperDollFrame_SetDamage(statsTable[1], "player", category);
        CSC_PaperDollFrame_SetRangedAttackPower(statsTable[2], "player");
        CSC_PaperDollFrame_SetRangedAttackSpeed(statsTable[3], "player");
        CSC_PaperDollFrame_SetCritChance(statsTable[4], "player", category);
        CSC_PaperDollFrame_SetRangedHitChance(statsTable[5], "player");
    elseif category == PLAYERSTAT_SPELL_COMBAT then
        -- bonus dmg, bonus healing, crit chance, mana regen, hit
        CSC_PaperDollFrame_SetSpellPower(statsTable[1], "player");
        CSC_PaperDollFrame_SetHealing(statsTable[2], "player");
        CSC_PaperDollFrame_SetManaRegen(statsTable[3], "player");
        CSC_PaperDollFrame_SetSpellCritChance(statsTable[4], "player");
        CSC_PaperDollFrame_SetSpellHitChance(statsTable[5], "player");
    end
end

function UIConfig:CreateMenu()
    -- Hide the default stats
    CharacterAttributesFrame:Hide();

    CSC_UIFrame.CharacterStatsPanel = CreateFrame("Frame", nil, CharacterFrame); --CharacterFrameInsetRight
	CSC_UIFrame.CharacterStatsPanel:SetPoint("LEFT", CharacterFrame, "BOTTOMLEFT", 50, 75); --85 for 6 stats
	CSC_UIFrame.CharacterStatsPanel:SetHeight(320);
    CSC_UIFrame.CharacterStatsPanel:SetWidth(200);

    UIConfig:SetupDropdown();
    UIConfig:SetupConfigInterface();

    UIConfig:InitializeStatsFrames(CSC_UIFrame.CharacterStatsPanel.leftStatsDropDown, CSC_UIFrame.CharacterStatsPanel.rightStatsDropDown);
    UIConfig:UpdateStats();
end

function UIConfig:UpdateStats()
    UIConfig:SetCharacterStats(LeftStatsTable, statsDropdownList[UISettingsCharacter.selectedLeftStatsCategory]);
    UIConfig:SetCharacterStats(RightStatsTable, statsDropdownList[UISettingsCharacter.selectedRightStatsCategory]);
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

function UIConfig:SetupConfigInterface()

    CSC_ConfigFrame = CreateFrame("Frame", "CSC_InterfaceOptionsPanel", UIParent);
    CSC_ConfigFrame.name = "CharacterStatsClassic";
    InterfaceOptions_AddCategory(CSC_ConfigFrame);

    -- Title and font
    CSC_ConfigFrame.title = CreateFrame("Frame", "CharacterStatsClassic", CSC_ConfigFrame);
    CSC_ConfigFrame.title:SetPoint("TOPLEFT", CSC_ConfigFrame, "TOPLEFT", 10, -10);
    CSC_ConfigFrame.title:SetWidth(300);
    CSC_ConfigFrame.titleString = CSC_ConfigFrame.title:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    CSC_ConfigFrame.titleString:SetPoint("TOPLEFT", CSC_ConfigFrame, "TOPLEFT", 10, -10);
    CSC_ConfigFrame.titleString:SetText('|cff00c0ffCharacterStatsClassic|r');
    CSC_ConfigFrame.titleString:SetFont("Fonts\\FRIZQT__.tff", 20, "OUTLINE");

    -- Checkboxes
    CSC_ConfigFrame.chkBtnAddWeaponSkillToHit = CreateFrame("CheckButton", "default", CSC_ConfigFrame, "UICheckButtonTemplate");
    CSC_ConfigFrame.chkBtnAddWeaponSkillToHit:SetPoint("TOPLEFT", 20, -30);
    CSC_ConfigFrame.chkBtnAddWeaponSkillToHit.text:SetText("Count Hit from Weapon Skill in Hit Chance. (Works only for melee weapons and level 60 players)");
    CSC_ConfigFrame.chkBtnAddWeaponSkillToHit:SetChecked(UISettingsGlobal.shouldAddWeaponSkillToHit);
    CSC_ConfigFrame.chkBtnAddWeaponSkillToHit:SetScript("OnClick", 
    function()
        UISettingsGlobal.shouldAddWeaponSkillToHit = not UISettingsGlobal.shouldAddWeaponSkillToHit;
    end);
end

-- Hook a custom function in order to extend the functionality of the default ToggleCharacter function
local function CSC_ToggleCharacterPostHook(tab, onlyShow)
    if (tab == "PaperDollFrame") then
        CSC_UIFrame.CharacterStatsPanel:Show();
        CSC_UIFrame:UpdateStats();
    else
        CSC_UIFrame.CharacterStatsPanel:Hide();
    end
end
hooksecurefunc("ToggleCharacter", CSC_ToggleCharacterPostHook);

-- Serializing the DB
local dbLoader = CreateFrame("Frame");
dbLoader:RegisterEvent("ADDON_LOADED");
dbLoader:RegisterEvent("PLAYER_LOGOUT");

-- ADDON_LOADED is called after the code of the addon is being executed
-- Therefore I have to call any setup-functions dependent on the DB after the event (UIConfig:SetupDropdown())
function dbLoader:OnEvent(event, arg1)
    if (event == "ADDON_LOADED" and arg1 == "CharacterStatsClassic") then
        -- Global DB
        if (CharacterStatsClassicDB == nil) then
            CharacterStatsClassicDB = UISettingsGlobal;
        else
            UISettingsGlobal = CharacterStatsClassicDB;
        end
        
        -- Character DB
        if (CharacterStatsClassicCharacterDB == nil) then
            CharacterStatsClassicCharacterDB = UISettingsCharacter;
        else
            UISettingsCharacter = CharacterStatsClassicCharacterDB;
        end

        UIConfig:CreateMenu();
    elseif (event == "PLAYER_LOGOUT") then
        CharacterStatsClassicDB = UISettingsGlobal;
        CharacterStatsClassicCharacterDB = UISettingsCharacter;
    end
end

dbLoader:SetScript("OnEvent", dbLoader.OnEvent);