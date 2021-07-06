--[[

  THANK YOU FOR TRYING THIS ADDON!
  
  Mod:        Personal Resource Display
  Descrption: Legion-style Health and Power bars located near the player. Supporting Mana, Rage and Energy.
              Shapeshifting from Druid also supported.
  Author:     Dioporc#2069   @Discord
              GianBzt#2855   @Battle.net
              Ffz            Human Mage @Gandling EU ----- currently unsubbed
  Version:    3.1.2
  Changes:    Check https://www.curseforge.com/wow/addons/personal-resource-display/ for detailed changelogs!
              Added a separate option to toggle extended numeric values in the format of current/max. The default numeric values will only show current value
              The "Opacity while OOC" slider now allows decimal values in steps of 0.5, from 0 to 0.6 for a total of 12 values
  Minor Fix:  Fixed a typo in the class RGB's which resulted in a darker purplish tint for paladins
  Disclaimer: All the textures found inside the AddOn folder are taken/edited from the BlizzardInterfaceArt directory.
              I claim no credits to those.
]]

PRD_settingsConfig = {}

local addonName = GetAddOnMetadata("Personal Resource Display", "Title")
local addonVersion = GetAddOnMetadata("Personal Resource Display", "Version")
local addonNotes = GetAddOnMetadata("Personal Resource Display", "Notes")

local personalResourceBarsEventFrame = CreateFrame("FRAME", "PRD_EventFrame")
personalResourceBarsEventFrame:RegisterUnitEvent("UNIT_POWER_UPDATE", "player")
personalResourceBarsEventFrame:RegisterUnitEvent("UNIT_HEALTH", "player")
personalResourceBarsEventFrame:RegisterUnitEvent("UNIT_MAXHEALTH", "player")
personalResourceBarsEventFrame:RegisterEvent("ADDON_LOADED")
personalResourceBarsEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

local frameStratas = {
  [1] = "BACKGROUND",
  [2] = "LOW",
  [3] = "MEDIUM",
  [4] = "HIGH",
  [5] = "DIALOG",
  [6] = "FULLSCREEN",
  [7] = "FULLSCREEN_DIALOG",
  [8] = "TOOLTIP"
}

local classColors = {
  ["MAGE"] = { ["r"] = 64/255, ["g"] = 199/255, ["b"] = 235/255 },
  ["WARRIOR"] = { ["r"] = 199/255, ["g"] = 156/255, ["b"] = 110/255 },
  ["DEATHKNIGHT"] = { ["r"] = 196/255, ["g"] = 31/255, ["b"] = 59/255 }, -- gonna leave this here, if Blizz rush TBC like they rushed Vanilla, this will happen in 3 months lol
  ["WARLOCK"] = { ["r"] = 135/255, ["g"] = 135, ["b"] = 237/255 },
  ["DRUID"] = { ["r"] = 255/255, ["g"] = 125/255, ["b"] = 10/255 },
  ["HUNTER"] = { ["r"] = 171/255, ["g"] = 212/255, ["b"] = 115/255 },
  ["PRIEST"] = { ["r"] = 255/255, ["g"] = 255/255, ["b"] = 255/255 },
  ["SHAMAN"] = { ["r"] = 0/255, ["g"] = 112/255, ["b"] = 222/255 },
  ["ROGUE"] = { ["r"] = 255/255, ["g"] = 245/255, ["b"] = 105/255 },
  ["PALADIN"] = { ["r"] = 245/255, ["g"] = 140/255, ["b"] = 186/255 }
}

local function ExtractColorValueFromHex(str, index)
	return tonumber(str:sub(index, index + 1), 16) / 255;
end

local playerClass = select(2, UnitClass("player"))
local personalResourceBarHeight = 10
local personalResourceBarWidth = 100
local personalResourceBarBaseTopPadding = -130 -- units of space between center of screen downwards
local manaPercentageTextColor
local minScale = 0.5
local maxScale = 3
local minWidth = 50
local maxWidth = 250
local defaultPercentagePadding = -30
local minPercentagePadding = -70
local maxPercentagePadding = 300
local minVerticalPosition = -350
local maxVerticalPosition = 400
local minOpacityOOC = 0.0
local maxOpacityOOC = 0.6
local defaultOpacityOOC = 0.2
local backgroundSettingsFrameOpacity = 0.2
local playerMaxHealth
local playerMaxHealthReady = false
local PRD_MinimapTexture = "Interface\\AddOns\\Personal Resource Display\\Textures\\PRD_MinimapTexture"
local PRD_InterfaceSettingsTexture = "Interface\\AddOns\\Personal Resource Display\\Textures\\PRD_InterfaceSettingsTexture"


StaticPopupDialogs["PRD_WRONG_SYNTAX"] = {
	preferredIndex = STATICPOPUP_NUMDIALOGS,
  text = "Syntax is: |cff3FD42A/prd <value>|r\nValue must be a number.\nDefault value is: |cff3FD42A"..personalResourceBarBaseTopPadding.."|r\nUse |cff3FD42A/prd reset|r to reset the frames.",
  button1 = OKAY,
  hideOnEscape = 1,
  timeout = 0,
  OnAccept = function(self, data) HideUIPanel(self) end
}

local function PRD_round(num, decimals)
  return (("%%.%df"):format(decimals)):format(num)
end


function PRD_generateHexColor(r, g, b)
  -- returns the RRGGBB string (not passing the alpha value just in case we need different than FF)
  -- r, g, b must be within the interval [0,1]
	return ("%02x%02x%02x"):format(r * 255, g * 255, b * 255);
end

-- Called once at launch
-- no longer a function
--function createPersonalResourceDisplay()
local PRD_personalHealthBar = CreateFrame("StatusBar", "PRD_personalHealthBar", UIParent, BackdropTemplateMixin and "BackdropTemplate")
    PRD_personalHealthBar:SetStatusBarTexture("Interface/TargetingFrame/UI-StatusBar")
    PRD_personalHealthBar:SetHeight(personalResourceBarHeight) -- Width is set after reading the savedVar
    PRD_personalHealthBar:SetHitRectInsets(2, 2, 2, 2)
    -- PRD_personalHealthBar:SetStatusBarColor(0, 1, 0)
    -- Note: Contrarily to what the Doc says, default FillStyle is "CENTER"
    -- "STANDARD" mode requires MinMaxValues to be defined, and the current value (SetValue function) to be kept in between.
    PRD_personalHealthBar:SetFillStyle("STANDARD")
    PRD_personalHealthBar:SetMinMaxValues(0, 100)

local PRD_personalManaBar = CreateFrame("StatusBar", "PRD_personalManaBar", UIParent, BackdropTemplateMixin and "BackdropTemplate")
    PRD_personalManaBar:SetStatusBarTexture("Interface/TargetingFrame/UI-StatusBar")
    PRD_personalManaBar:SetHeight(personalResourceBarHeight) -- Same as HP bar
    PRD_personalManaBar:SetHitRectInsets(2, 2, 2, 2)
    -- PRD_personalManaBar:SetMovable(true)
    PRD_personalManaBar:SetFillStyle("STANDARD")
    PRD_personalManaBar:SetMinMaxValues(0, 100)

local PRD_personalHealthBarBorder = CreateFrame("Frame", "PRD_personalHealthBarBorder", PRD_personalHealthBar, BackdropTemplateMixin and "BackdropTemplate")
    PRD_personalHealthBarBorder:SetBackdrop({ 
      bgFile = "Interface/Tooltips/UI-StatusBar-Border", 
      tile = false, tileSize = personalResourceBarWidth, edgeSize = personalResourceBarHeight, 
      insets = { left = 0, right = 0, top = 0, bottom = 0 },
      backdropBorderColor = { r = 1, g = 1, b = 0, a = 1 },        
      backdropColor = { r = 1, g = 0, b = 0.1, a = 1 },
    })
    PRD_personalHealthBarBorder:SetHeight(personalResourceBarHeight + 5)
    PRD_personalHealthBarBorder:SetWidth(personalResourceBarWidth + 5)
    PRD_personalHealthBarBorder:SetPoint("CENTER", 0, 0) --relative to parent
    
local PRD_personalManaBarBorder = CreateFrame("Frame", "PRD_personalManaBarBorder", PRD_personalManaBar, BackdropTemplateMixin and "BackdropTemplate")
    PRD_personalManaBarBorder:SetBackdrop({
      bgFile = "Interface/Tooltips/UI-StatusBar-Border", 
      tile = false, tileSize = personalResourceBarWidth, edgeSize = personalResourceBarHeight, 
      insets = { left = 0, right = 0, top = 0, bottom = 0 },
      backdropBorderColor = { r = 1, g = 1, b = 0, a = 1 },
      backdropColor = { r = 1, g = 0, b = 0.1, a = 1 },
    });
    PRD_personalManaBarBorder:SetHeight(personalResourceBarHeight + 5)
    PRD_personalManaBarBorder:SetWidth(personalResourceBarWidth + 5)
    PRD_personalManaBarBorder:SetPoint("CENTER", 0, 0)

    PRD_personalManaBar:SetShown(true)
    PRD_personalHealthBar:SetShown(true)

  local PRD_healthPercentageFontString = PRD_personalHealthBar:CreateFontString("PRD_healthPercentageFontString", "ARTWORK", "GameFontHighlightOutline")
    PRD_healthPercentageFontString:SetText("100")
    PRD_healthPercentageFontString:SetJustifyH("RIGHT")
    PRD_healthPercentageFontString:SetJustifyV("MIDDLE")
    -- PRD_healthPercentageFontString:SetPoint("LEFT", -29, 2.5)
  local PRD_manaPercentageFontString = PRD_personalManaBar:CreateFontString("PRD_manaPercentageFontString", "ARTWORK", "GameFontHighlightOutline")    
    PRD_manaPercentageFontString:SetText("100")
    PRD_manaPercentageFontString:SetJustifyH("LEFT")
    PRD_manaPercentageFontString:SetJustifyV("MIDDLE")
    -- PRD_manaPercentageFontString:SetPoint("LEFT", -29, -1)
--end

-- Evaluating the width of the bars according to current HP and MP
local function getCurrentManaBarValuePercentage()
  local maxmana = UnitPowerMax("player")
  local currmana = UnitPower("player")
  local percentmana = currmana/maxmana*100
  return math.min(math.floor(percentmana + 0.5), 100)
end

local function getCurrentManaBarValueNumeric()
  return UnitPower("player")
end

local function getCurrentHealthBarValuePercentage()
  local currhp = UnitHealth("player")
  local percenthp = currhp/playerMaxHealth*100
  if PRD_settingsConfig.dynamicHealthColor then
    if percenthp <= 50 then
      PRD_personalHealthBar:SetStatusBarColor(1, percenthp/100, 0)
    else
      PRD_personalHealthBar:SetStatusBarColor(1-(percenthp/100), 1, 0)
    end

  -- all the following should be irrelevant
  --[[ elseif PRD_settingsConfig.classColorHealthBar then
    PRD_personalHealthBar:SetStatusBarColor(classColors.playerClass["r"], classColors.playerClass["g"], classColors.playerClass["b"])
  else 
    PRD_personalHealthBar:SetStatusBarColor(0, 1, 0) ]]
  end
  return math.min(math.floor(percenthp + 0.5), 100)
end

local function getCurrentHealthBarValueNumeric()
  local currhp = UnitHealth("player")
  local percenthp = currhp/playerMaxHealth*100
  if PRD_settingsConfig.dynamicHealthColor then
    if percenthp <= 50 then
      PRD_personalHealthBar:SetStatusBarColor(1, percenthp/100, 0)
    else
      PRD_personalHealthBar:SetStatusBarColor(1-(percenthp/100), 1, 0)
    end

  -- all the following should be irrelevant
  --[[ elseif PRD_settingsConfig.classColorHealthBar then
    PRD_personalHealthBar:SetStatusBarColor(classColors.playerClass["r"], classColors.playerClass["g"], classColors.playerClass["b"])
  else 
    PRD_personalHealthBar:SetStatusBarColor(0, 1, 0) ]]
  end
  return currhp
end


local function updatePercentageText()
  if PRD_settingsConfig.showReversePercentage then
  -- Reverse percentage mode 
    if PRD_settingsConfig.dynamicHealthColor or PRD_settingsConfig.classColorHealthBar then
      local r, g, b = PRD_personalHealthBar:GetStatusBarColor()
      PRD_healthPercentageFontString:SetText("|cff"..PRD_generateHexColor(r, g, b).."-"..100 - getCurrentHealthBarValuePercentage())
    else
      PRD_healthPercentageFontString:SetText("|cff66ff66-"..100 - getCurrentHealthBarValuePercentage())
    end

    PRD_manaPercentageFontString:SetText("|cff"..manaPercentageTextColor.."-"..100 - getCurrentManaBarValuePercentage())
  elseif PRD_settingsConfig.showPercentage then
  -- Regular percentage mode
    if PRD_settingsConfig.dynamicHealthColor or PRD_settingsConfig.classColorHealthBar then
      local r, g, b = PRD_personalHealthBar:GetStatusBarColor()
      PRD_healthPercentageFontString:SetText("|cff"..PRD_generateHexColor(r, g, b)..getCurrentHealthBarValuePercentage())
    else
      PRD_healthPercentageFontString:SetText("|cff66ff66"..getCurrentHealthBarValuePercentage())
    end

      PRD_manaPercentageFontString:SetText("|cff"..manaPercentageTextColor..getCurrentManaBarValuePercentage())
  elseif PRD_settingsConfig.numericHealthValue then
  -- Numeric health mode
    if PRD_settingsConfig.extendedNumericValue then
      if PRD_settingsConfig.dynamicHealthColor or PRD_settingsConfig.classColorHealthBar then
        local r, g, b = PRD_personalHealthBar:GetStatusBarColor()
        PRD_healthPercentageFontString:SetText("|cff"..PRD_generateHexColor(r, g, b)..getCurrentHealthBarValueNumeric().."/"..UnitHealthMax("player"))
      else
        PRD_healthPercentageFontString:SetText("|cff66ff66"..getCurrentHealthBarValueNumeric().."/"..UnitHealthMax("player"))
      end
        PRD_manaPercentageFontString:SetText("|cff"..manaPercentageTextColor..getCurrentManaBarValueNumeric().."/"..UnitPowerMax("player"))
    else
      if PRD_settingsConfig.dynamicHealthColor or PRD_settingsConfig.classColorHealthBar then
        local r, g, b = PRD_personalHealthBar:GetStatusBarColor()
        PRD_healthPercentageFontString:SetText("|cff"..PRD_generateHexColor(r, g, b)..getCurrentHealthBarValueNumeric())
      else
        PRD_healthPercentageFontString:SetText("|cff66ff66"..getCurrentHealthBarValueNumeric())
      end
        PRD_manaPercentageFontString:SetText("|cff"..manaPercentageTextColor..getCurrentManaBarValueNumeric())
    end
  end
end


local function toggleDynamicHealthColor()
  PRD_settingsConfig.dynamicHealthColor = not PRD_settingsConfig.dynamicHealthColor

  if PRD_settingsConfig.dynamicHealthColor then
    PRD_settingsConfig.classColorHealthBar = false
    classColorHealthBar_checkBox:SetChecked(false)
    getCurrentHealthBarValuePercentage()
  end

  updatePercentageText()
end

-- All the minimap related code
local MinimapButton = CreateFrame("Button", "PRD_MinimapButton", Minimap, BackdropTemplateMixin and "BackdropTemplate")
  PRD_MinimapButton:EnableMouse(true)
  PRD_MinimapButton:SetToplevel(true)
  PRD_MinimapButton:SetWidth(32)
  PRD_MinimapButton:SetHeight(32)
  -- i'm setting button position at PLAYER_ENTERING_WORLD, for being sure the coords variable to be loaded 
  PRD_MinimapButton:SetFrameStrata("MEDIUM")
  PRD_MinimapButton:RegisterForClicks("AnyUp")
  PRD_MinimapButton:RegisterForDrag("LeftButton")
  PRD_MinimapButton:SetMovable(true)
  
	local texture = MinimapButton:CreateTexture(nil, "BACKGROUND")
	texture:SetWidth(24)
	texture:SetHeight(24)
	texture:SetPoint("TOPLEFT", 2, -4)
  texture:SetTexture("Interface\\Minimap\\UI-Minimap-Background")

  local NormalTexture = MinimapButton:CreateTexture("PRD_NormalTexture", "ARTWORK") -- giving these 2 a name for referencing them on toggle func
	NormalTexture:SetWidth(25)
	NormalTexture:SetHeight(25)
	NormalTexture:SetPoint("TOPLEFT", 3, -3.5)
  NormalTexture:SetTexture(PRD_MinimapTexture)
	NormalTexture:SetTexCoord(2/16, 14/16, 1/16, 15/16)
  MinimapButton:SetNormalTexture(NormalTexture)
  
  local PushedTexture = MinimapButton:CreateTexture("PRD_pushedTexture", "ARTWORK") -- same as above
	PushedTexture:SetWidth(23)
	PushedTexture:SetHeight(23)
	PushedTexture:SetPoint("TOPLEFT", 3, -3.5)
	PushedTexture:SetTexture(PRD_MinimapTexture)
	PushedTexture:SetTexCoord(2/16, 14/16, 1/16, 15/16)
	MinimapButton:SetPushedTexture(PushedTexture)

	local HighlightTexture = MinimapButton:CreateTexture(nil, "ARTWORK")
	HighlightTexture:SetPoint("TOPLEFT", 0, 0)
	HighlightTexture:SetPoint("BOTTOMRIGHT", 0, 0)
	HighlightTexture:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
  MinimapButton:SetHighlightTexture(HighlightTexture)

  local function moveMinimapButton()
		local xpos, ypos = 80 * cos(PRD_minimapButtonConfig or 0), 80 * sin(PRD_minimapButtonConfig or 0)
    PRD_MinimapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 54-xpos, ypos-54)
	end

	local function dragMinimapButton()
		local xpos, ypos = GetCursorPosition()
		local xmin, ymin = Minimap:GetLeft() or 400, Minimap:GetBottom() or 400
		local scale = Minimap:GetEffectiveScale()
		xpos = xmin-xpos/scale + 70
		ypos = ypos/scale-ymin - 70
		PRD_minimapButtonConfig = math.deg(math.atan2(ypos, xpos))
		moveMinimapButton()
  end
-- end of minimap related code

local function toggleFrameBorders()
  PRD_personalHealthBarBorder:SetShown(not PRD_settingsConfig.showBorder)
  PRD_personalManaBarBorder:SetShown(not PRD_settingsConfig.showBorder)

  PRD_settingsConfig.showBorder = not PRD_settingsConfig.showBorder
end

local function toggleMinimap(fromMinimap)
  if fromMinimap then hideMinimap_checkBox:SetChecked(not hideMinimap_checkBox:GetChecked()) end

  PRD_MinimapButton:SetShown(not PRD_settingsConfig.showMinimap)

  PRD_settingsConfig.showMinimap = not PRD_settingsConfig.showMinimap
end


local function isModKeyDown()
  return IsAltKeyDown() or IsControlKeyDown() or IsShiftKeyDown()
end

local function toggleHealthBar()
  -- hiding the bar when checking the box, and vice versa
  PRD_settingsConfig.hideHealthBar = not PRD_settingsConfig.hideHealthBar
  PRD_personalHealthBar:SetShown(not PRD_settingsConfig.hideHealthBar)

  if not PRD_personalHealthBar:IsShown() then
    personalResourceBarsEventFrame:UnregisterEvent("UNIT_HEALTH", "player")
    personalResourceBarsEventFrame:UnregisterEvent("UNIT_MAXHEALTH", "player")
  else    
    personalResourceBarsEventFrame:RegisterUnitEvent("UNIT_HEALTH", "player")
    personalResourceBarsEventFrame:RegisterUnitEvent("UNIT_MAXHEALTH", "player")
  end
end

local function toggleClassColorHealthBar()
  PRD_settingsConfig.classColorHealthBar = not PRD_settingsConfig.classColorHealthBar

  if PRD_settingsConfig.classColorHealthBar then
    PRD_personalHealthBar:SetStatusBarColor(classColors[playerClass]["r"], classColors[playerClass]["g"], classColors[playerClass]["b"])
    PRD_settingsConfig.dynamicHealthColor = false
    dynamicHealthColor_checkBox:SetChecked(false)
  else
    PRD_personalHealthBar:SetStatusBarColor(0, 1, 0)
  end

  updatePercentageText()
end

local function togglePercentage()
  PRD_healthPercentageFontString:SetShown(not PRD_settingsConfig.showPercentage)
  PRD_manaPercentageFontString:SetShown(not PRD_settingsConfig.showPercentage)

  PRD_settingsConfig.showPercentage = not PRD_settingsConfig.showPercentage

  showReversePercentage_checkBox:SetEnabled(PRD_settingsConfig.showPercentage)
  _G['percentageTextPadding_Slider']:SetShown(PRD_settingsConfig.showPercentage)
  _G['percentageTextScale_Slider']:SetShown(PRD_settingsConfig.showPercentage)

  if PRD_settingsConfig.showPercentage then
    _G["showReversePercentage_checkBoxText"]:SetText("Use reverse percentage")
    PRD_settingsConfig.numericHealthValue = false
    _G["numericHealthValue_checkBox"]:SetChecked(false)
    _G["extendedNumericValues_checkBoxText"]:SetText("|cff8e8e8cExtended numeric values")
    _G["extendedNumericValues_checkBox"]:SetEnabled(false)
  else
    -- can't use reference to table "set" as it is initiated later
    _G["showReversePercentage_checkBoxText"]:SetText("|cff8e8e8cUse reverse percentage")
    
  end

  updatePercentageText()
end

local function toggleReversePercentage()
  PRD_settingsConfig.showReversePercentage = not PRD_settingsConfig.showReversePercentage
  updatePercentageText()
end

local function toggleExtendedNumericValues()
  PRD_settingsConfig.extendedNumericValue = not PRD_settingsConfig.extendedNumericValue

  if PRD_settingsConfig.extendedNumericValue then
    if PRD_settingsConfig.dynamicHealthColor or PRD_settingsConfig.classColorHealthBar then
      local r, g, b = PRD_personalHealthBar:GetStatusBarColor()
      PRD_healthPercentageFontString:SetText("|cff"..PRD_generateHexColor(r, g, b)..getCurrentHealthBarValueNumeric().."/"..UnitHealthMax("player"))
    else
      PRD_healthPercentageFontString:SetText("|cff66ff66"..getCurrentHealthBarValueNumeric().."/"..UnitHealthMax("player"))
    end
    PRD_manaPercentageFontString:SetText("|cff"..manaPercentageTextColor..getCurrentManaBarValueNumeric().."/"..UnitPowerMax("player"))
  else
    if PRD_settingsConfig.dynamicHealthColor or PRD_settingsConfig.classColorHealthBar then
      local r, g, b = PRD_personalHealthBar:GetStatusBarColor()
      PRD_healthPercentageFontString:SetText("|cff"..PRD_generateHexColor(r, g, b)..getCurrentHealthBarValueNumeric())
    else
      PRD_healthPercentageFontString:SetText("|cff66ff66"..getCurrentHealthBarValueNumeric())
    end
    PRD_manaPercentageFontString:SetText("|cff"..manaPercentageTextColor..getCurrentManaBarValueNumeric())
  end
end

local function toggleNumericHealthValue()
  PRD_settingsConfig.numericHealthValue = not PRD_settingsConfig.numericHealthValue

  PRD_healthPercentageFontString:SetShown(PRD_settingsConfig.numericHealthValue)
  PRD_manaPercentageFontString:SetShown(PRD_settingsConfig.numericHealthValue)
  _G["extendedNumericValues_checkBox"]:SetEnabled(PRD_settingsConfig.numericHealthValue)


  if PRD_settingsConfig.numericHealthValue then
    PRD_settingsConfig.showPercentage = false
    _G["extendedNumericValues_checkBoxText"]:SetText("Extended numeric values")
    _G['percentageTextPadding_Slider']:Show()
    _G['percentageTextScale_Slider']:Show()
    _G['showPercentage_checkBox']:SetChecked(false)
    _G["showReversePercentage_checkBoxText"]:SetText("|cff8e8e8cUse reverse percentage")
    PRD_healthPercentageFontString:Show()
    PRD_manaPercentageFontString:Show()
    if PRD_settingsConfig.extendedNumericValue then
      -- holy shit what a mess. First check for EXTENDED values, if enabled THEN check for the COLORS and output the larger strings
      if PRD_settingsConfig.dynamicHealthColor or PRD_settingsConfig.classColorHealthBar then
        local r, g, b = PRD_personalHealthBar:GetStatusBarColor()
        PRD_healthPercentageFontString:SetText("|cff"..PRD_generateHexColor(r, g, b)..getCurrentHealthBarValueNumeric().."/"..UnitHealthMax("player"))
      else
        PRD_healthPercentageFontString:SetText("|cff66ff66"..getCurrentHealthBarValueNumeric().."/"..UnitHealthMax("player"))
      end
      PRD_manaPercentageFontString:SetText("|cff"..manaPercentageTextColor..getCurrentManaBarValueNumeric().."/"..UnitPowerMax("player"))
    else
      -- if EXTENDED is not enabled, THEN check for the COLORS anyway but output the shorter strings
      if PRD_settingsConfig.dynamicHealthColor or PRD_settingsConfig.classColorHealthBar then
        local r, g, b = PRD_personalHealthBar:GetStatusBarColor()
        PRD_healthPercentageFontString:SetText("|cff"..PRD_generateHexColor(r, g, b)..getCurrentHealthBarValueNumeric())
      else
        PRD_healthPercentageFontString:SetText("|cff66ff66"..getCurrentHealthBarValueNumeric())
      end
      PRD_manaPercentageFontString:SetText("|cff"..manaPercentageTextColor..getCurrentManaBarValueNumeric())
    end
  else
    _G['percentageTextPadding_Slider']:Hide()
    _G['percentageTextScale_Slider']:Hide()
    _G["extendedNumericValues_checkBoxText"]:SetText("|cff8e8e8cExtended numeric values")
  end
end

local function PRD_resetFramesToDefault()
  PRD_personalHealthBar:SetScale(1)
  PRD_personalManaBar:SetScale(1)
  PRD_personalHealthBarBorder:SetScale(1)
  PRD_personalManaBarBorder:SetScale(1)

  PRD_personalHealthBar:SetWidth(personalResourceBarWidth)
  PRD_personalManaBar:SetWidth(personalResourceBarWidth)
  PRD_personalHealthBarBorder:SetWidth(personalResourceBarWidth + 5)
  PRD_personalManaBarBorder:SetWidth(personalResourceBarWidth + 5)

  scale_Slider:SetValue(1)
  PRD_settingsConfig.scale = 1
  width_Slider:SetValue(personalResourceBarWidth)
  PRD_settingsConfig.width = personalResourceBarWidth
  verticalPosition_Slider:SetValue(personalResourceBarBaseTopPadding)
  PRD_settingsConfig.verticalPosition = personalResourceBarBaseTopPadding

  PRD_healthPercentageFontString:SetPoint("LEFT", defaultPercentagePadding, 1)
  PRD_manaPercentageFontString:SetPoint("LEFT", defaultPercentagePadding, -1)
  percentageTextPadding_Slider:SetValue(defaultPercentagePadding)
  percentageTextScale_Slider:SetValue(1)
  PRD_healthPercentageFontString:SetScale(1)
  PRD_manaPercentageFontString:SetScale(1)
end

local function PRD_moveVertically(toValue)
  PRD_personalHealthBar:SetPoint("CENTER", 0, toValue)
  PRD_personalManaBar:SetPoint("CENTER", 0, (toValue)-personalResourceBarHeight)
  PRD_settingsConfig.verticalPosition = toValue
  _G[verticalPosition_Slider:GetName() .. 'Text']:SetText("PRD Y position: |cfffdf457"..math.floor((ceil(toValue - .5)*100)/100))
  verticalPosition_Slider:SetValue(toValue)
  if toValue == personalResourceBarBaseTopPadding then
    _G[verticalPosition_Slider:GetName() .. 'Low']:SetText("|cff66ff33"..minVerticalPosition)
    _G[verticalPosition_Slider:GetName() .. 'High']:SetText("|cff66ff33"..maxVerticalPosition)
  else
    _G[verticalPosition_Slider:GetName() .. 'Low']:SetText(minVerticalPosition)
    _G[verticalPosition_Slider:GetName() .. 'High']:SetText(maxVerticalPosition)
  end
end

-- Settings code (in the client interface tab)
local set = {}
  set.InterfaceOptions = CreateFrame("Frame", "PRD_InterfaceOptions", UIParent, BackdropTemplateMixin and "BackdropTemplate") --Parent frame for all the settings frames
  set.InterfaceOptions.name = "PRD\n("..addonName..")"
  set.InterfaceOptions:SetBackdrop({
    bgFile = PRD_InterfaceSettingsTexture,
    insets = { left = 5, right = 5, top = 3, bottom = 4 }
  })
  set.InterfaceOptions:SetBackdropColor(1, 204/255, 204/255, 1)

  set.InterfaceOptions.Title = set.InterfaceOptions:CreateFontString(nil, "ARTWORK", "GameFontNormalHugeOutline2")
    set.InterfaceOptions.Title:SetText(addonName)
    set.InterfaceOptions.Title:SetJustifyH("LEFT")
    set.InterfaceOptions.Title:SetJustifyV("TOP")
    set.InterfaceOptions.Title:SetPoint("TOPLEFT", 16, -16)

  set.InterfaceOptions.Version = set.InterfaceOptions:CreateFontString(nil, "ARTWORK", "GameFontNormalOutline")
    set.InterfaceOptions.Version:SetText("ver. "..addonVersion.."\n"..addonNotes)
    set.InterfaceOptions.Version:SetJustifyH("LEFT")
    set.InterfaceOptions.Version:SetJustifyV("TOP")
    set.InterfaceOptions.Version:SetPoint("TOPLEFT", 16, -(set.InterfaceOptions.Version:GetStringHeight()+15))

  
  local function PRD_DropDown_onClick(self, arg1, arg2, checked)
    -- we are passing 1, 5 or 7 as arg1
    PRD_settingsConfig.strataLevel = arg1
    -- then we store it in our config
    PRD_personalManaBar:SetFrameStrata(frameStratas[arg1])
    PRD_personalHealthBar:SetFrameStrata(frameStratas[arg1])
    PRD_personalManaBarBorder:SetFrameStrata(frameStratas[arg1])
    PRD_personalHealthBarBorder:SetFrameStrata(frameStratas[arg1])
    UIDropDownMenu_SetText(PRD_editStrataDropDown, frameStratas[arg1])
  end

  function PRD_DropDown_init(frame, level, menuList)
    local info = UIDropDownMenu_CreateInfo()
    info.func = PRD_DropDown_onClick
    info.tooltipTitle = "Set the strata level of the PRD frames.\n|cffffcc00"..frameStratas[1]..":|r Below every other UI element. Only visible above the WorldFrame.\n|cffffcc00"..frameStratas[5]..":|r Above most of the UI elements of other AddOns and Blizzard interface, but not visible through fullscreen frames.\n|cffffcc00"..frameStratas[7]..":|r Above all other UI elements including fullscreen, such as the World Map."
    info.text, info.arg1, info.checked = frameStratas[1], 1, (PRD_settingsConfig.strataLevel == 1)
    UIDropDownMenu_AddButton(info)
    info.text, info.arg1, info.checked = frameStratas[5], 5, (PRD_settingsConfig.strataLevel == 5)
    UIDropDownMenu_AddButton(info)
    info.text, info.arg1, info.checked = frameStratas[7], 7, (PRD_settingsConfig.strataLevel == 7)
    UIDropDownMenu_AddButton(info)
  end

  local dropDown = CreateFrame("Frame", "PRD_editStrataDropDown", set.InterfaceOptions, "UIDropDownMenuTemplate")
    dropDown:SetPoint("TOPLEFT", set.InterfaceOptions, "TOPLEFT", 90, -120);
    dropDown.shouldRefresh = true
    UIDropDownMenu_SetWidth(dropDown, 140)
    -- UIDropDownMenu_SetText(dropDown, frameStratas[PRD_settingsConfig.strataLevel])
    UIDropDownMenu_Initialize(dropDown, PRD_DropDown_init)

  set.InterfaceOptions.editStrataFontString = set.InterfaceOptions:CreateFontString(nil, "ARTWORK", "GameFontNormalLargeOutline")
    set.InterfaceOptions.editStrataFontString:SetText("Strata level:")
    set.InterfaceOptions.editStrataFontString:SetJustifyH("LEFT")
    set.InterfaceOptions.editStrataFontString:SetJustifyV("TOP")
    set.InterfaceOptions.editStrataFontString:SetPoint("TOPLEFT", PRD_editStrataDropDown, "TOPLEFT", 17, 15)

  set.InterfaceOptions.showBorder_checkBox = CreateFrame("CheckButton", "showBorder_checkBox", set.InterfaceOptions, "ChatConfigCheckButtonTemplate")
    showBorder_checkBox:SetPoint("TOPLEFT", set.InterfaceOptions, "TOPLEFT", 105, -155);
    _G[set.InterfaceOptions.showBorder_checkBox:GetName().."Text"]:SetText("Show borders");
    showBorder_checkBox.tooltip = "Show the borders of both health and resource bars."
    showBorder_checkBox:SetScript("OnClick", toggleFrameBorders)

  set.InterfaceOptions.hideMinimap_checkBox = CreateFrame("CheckButton", "hideMinimap_checkBox", set.InterfaceOptions, "ChatConfigCheckButtonTemplate")
    hideMinimap_checkBox:SetPoint("TOPLEFT", set.InterfaceOptions, "TOPLEFT", 105, -180);
    _G[set.InterfaceOptions.hideMinimap_checkBox:GetName().."Text"]:SetText("Enable Minimap");
    hideMinimap_checkBox.tooltip = "Show the minimap button."
    hideMinimap_checkBox:SetScript("OnClick", function() toggleMinimap(false) end)

  set.InterfaceOptions.extendedNumericValues_checkBox = CreateFrame("CheckButton", "extendedNumericValues_checkBox", set.InterfaceOptions, "ChatConfigCheckButtonTemplate")
    extendedNumericValues_checkBox:SetPoint("TOPLEFT", set.InterfaceOptions, "TOPLEFT", 300, -230);
    _G["extendedNumericValues_checkBoxText"]:SetText("Extended numeric values");
    extendedNumericValues_checkBox.tooltip = "Show the numeric values in the format current/max."
    extendedNumericValues_checkBox:SetScript("OnClick", function() toggleExtendedNumericValues() end)

  set.InterfaceOptions.hideInCombat_checkBox = CreateFrame("CheckButton", "hideInCombat_checkBox", set.InterfaceOptions, "ChatConfigCheckButtonTemplate")
    hideInCombat_checkBox:SetPoint("TOPLEFT", set.InterfaceOptions, "TOPLEFT", 105, -255);
    _G[set.InterfaceOptions.hideInCombat_checkBox:GetName().."Text"]:SetText("Hide while OOC");
    hideInCombat_checkBox.tooltip = "Severely lower the opacity of the frames while out of combat. It is not affected by environmental damage such as fire or drowning."
    hideInCombat_checkBox:SetScript("OnClick", function() 
      PRD_settingsConfig.hideInCombat = not PRD_settingsConfig.hideInCombat
      _G['opacity_Slider']:SetShown(PRD_settingsConfig.hideInCombat)

      if PRD_settingsConfig.hideInCombat then
        personalResourceBarsEventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
        personalResourceBarsEventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
        local playerIsInCombat = UnitAffectingCombat("player")
        if playerIsInCombat == false then
          PRD_personalManaBar:SetAlpha(PRD_settingsConfig.opacityOOC)
          PRD_personalHealthBar:SetAlpha(PRD_settingsConfig.opacityOOC)
        end
      else
        personalResourceBarsEventFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
        personalResourceBarsEventFrame:UnregisterEvent("PLAYER_REGEN_DISABLED")
        PRD_personalManaBar:SetAlpha(1.0)
        PRD_personalHealthBar:SetAlpha(1.0)
      end
    end)

  set.InterfaceOptions.hideHealthBar_checkBox = CreateFrame("CheckButton", "hideHealthBar_checkBox", set.InterfaceOptions, "ChatConfigCheckButtonTemplate")
    hideHealthBar_checkBox:SetPoint("TOPLEFT", set.InterfaceOptions, "TOPLEFT", 300, -155);
    _G[set.InterfaceOptions.hideHealthBar_checkBox:GetName().."Text"]:SetText("Hide HP bar");
    hideHealthBar_checkBox.tooltip = "Hide the health bar."
    hideHealthBar_checkBox:SetScript("OnClick", toggleHealthBar)

  set.InterfaceOptions.showPercentage_checkBox = CreateFrame("CheckButton", "showPercentage_checkBox", set.InterfaceOptions, "ChatConfigCheckButtonTemplate")
    showPercentage_checkBox:SetPoint("TOPLEFT", set.InterfaceOptions, "TOPLEFT", 105, -205);
    _G[set.InterfaceOptions.showPercentage_checkBox:GetName().."Text"]:SetText("Show percentage");
    showPercentage_checkBox.tooltip = "Enable percentage status text next to the bars."
    showPercentage_checkBox:SetScript("OnClick", togglePercentage)

  set.InterfaceOptions.showReversePercentage_checkBox = CreateFrame("CheckButton", "showReversePercentage_checkBox", set.InterfaceOptions, "ChatConfigCheckButtonTemplate")
    showReversePercentage_checkBox:SetPoint("TOPLEFT", set.InterfaceOptions, "TOPLEFT", 105, -230);
    -- _G[set.InterfaceOptions.showReversePercentage_checkBox:GetName().."Text"]:SetText("Show reverse percentage")
    showReversePercentage_checkBox.tooltip = "Show the percentage as the amount of health/mana missing instead."
    showReversePercentage_checkBox:SetScript("OnClick", toggleReversePercentage)

    set.InterfaceOptions.dynamicHealthColor_checkBox = CreateFrame("CheckButton", "dynamicHealthColor_checkBox", set.InterfaceOptions, "ChatConfigCheckButtonTemplate")
    dynamicHealthColor_checkBox:SetPoint("TOPLEFT", set.InterfaceOptions, "TOPLEFT", 105, -280);
    _G[set.InterfaceOptions.dynamicHealthColor_checkBox:GetName().."Text"]:SetText("Dynamic HP color");
    dynamicHealthColor_checkBox.tooltip = "Change the color tint of the health bar according to the percentage of health. This will automatically disable the 'Class color health bar' feature."
    dynamicHealthColor_checkBox:SetScript("OnClick", toggleDynamicHealthColor)

  set.InterfaceOptions.numericHealthValue_checkBox = CreateFrame("CheckButton", "numericHealthValue_checkBox", set.InterfaceOptions, "ChatConfigCheckButtonTemplate")
    numericHealthValue_checkBox:SetPoint("TOPLEFT", set.InterfaceOptions, "TOPLEFT", 300, -205);
    _G[set.InterfaceOptions.numericHealthValue_checkBox:GetName().."Text"]:SetText("Numeric values");
    numericHealthValue_checkBox.tooltip = "Turn the percentage texts into numeric values."
    numericHealthValue_checkBox:SetScript("OnClick", toggleNumericHealthValue)

  set.InterfaceOptions.percentageTextPadding_Slider = CreateFrame("Slider", "percentageTextPadding_Slider", set.InterfaceOptions, "OptionsSliderTemplate")
    percentageTextPadding_Slider:SetMinMaxValues(minPercentagePadding, maxPercentagePadding)
    percentageTextPadding_Slider:SetOrientation("HORIZONTAL")
    percentageTextPadding_Slider:SetStepsPerPage(1)
    percentageTextPadding_Slider:SetValueStep(1)
    percentageTextPadding_Slider:SetObeyStepOnDrag(true)
    percentageTextPadding_Slider:SetWidth(200)
    percentageTextPadding_Slider:SetHeight(20)
    percentageTextPadding_Slider:SetPoint("TOPLEFT", set.InterfaceOptions, "TOPLEFT", 335, -335);
    percentageTextPadding_Slider.tooltipText = "Control the X position of the percentage texts. Default value |cff66ff33("..defaultPercentagePadding..")|r is highlighted with green."
    _G[percentageTextPadding_Slider:GetName() .. 'Low']:SetText(""..minPercentagePadding)
    _G[percentageTextPadding_Slider:GetName() .. 'High']:SetText("+"..maxPercentagePadding)
    percentageTextPadding_Slider:SetScript("OnValueChanged", function(self, value)
      PRD_healthPercentageFontString:SetPoint("LEFT", value, 1)
      PRD_manaPercentageFontString:SetPoint("LEFT", value, -1)
      PRD_settingsConfig.percentagePadding = value

      --_G[percentageTextPadding_Slider:GetName().."Text"]:SetText("% Placement: |cfffdf457"..PRD_round(PRD_settingsConfig.percentagePadding, 1))
      _G[percentageTextPadding_Slider:GetName().."Text"]:SetText("Text placement: |cfffdf457"..math.floor((ceil(value - .5)*100)/100))

      if value == defaultPercentagePadding then
        _G[percentageTextPadding_Slider:GetName() .. 'Low']:SetText("|cff66ff33"..minPercentagePadding)
        _G[percentageTextPadding_Slider:GetName() .. 'High']:SetText("|cff66ff33"..maxPercentagePadding)
      else
        _G[percentageTextPadding_Slider:GetName() .. 'Low']:SetText(minPercentagePadding)
        _G[percentageTextPadding_Slider:GetName() .. 'High']:SetText(maxPercentagePadding)
      end
    end)
    percentageTextPadding_Slider:RegisterForDrag("LeftButton")
    percentageTextPadding_Slider:SetScript("OnDragStart", function(self, button) InterfaceOptionsFrame:SetAlpha(backgroundSettingsFrameOpacity) end)
    percentageTextPadding_Slider:SetScript("OnDragStop", function(self, button) InterfaceOptionsFrame:SetAlpha(1.0) end)
    percentageTextPadding_Slider:Show()

  set.InterfaceOptions.percentageTextScale_Slider = CreateFrame("Slider", "percentageTextScale_Slider", set.InterfaceOptions, "OptionsSliderTemplate")
    percentageTextScale_Slider:SetMinMaxValues(minScale, maxScale)
    percentageTextScale_Slider:SetOrientation("HORIZONTAL")
    percentageTextScale_Slider:SetStepsPerPage(0.1)
    percentageTextScale_Slider:SetValueStep(0.1)
    percentageTextScale_Slider:SetObeyStepOnDrag(true)
    percentageTextScale_Slider:SetWidth(200)
    percentageTextScale_Slider:SetHeight(20)
    percentageTextScale_Slider:SetPoint("TOPLEFT", set.InterfaceOptions, "TOPLEFT", 335, -375);
    percentageTextScale_Slider.tooltipText = "Control the font size of the percentage texts. Default value |cff66ff33(1)|r is highlighted with green."
    _G[percentageTextScale_Slider:GetName() .. 'Low']:SetText(minScale)
    _G[percentageTextScale_Slider:GetName() .. 'High']:SetText(maxScale)
    percentageTextScale_Slider:SetScript("OnValueChanged", function(self, value)
      PRD_healthPercentageFontString:SetScale(value)
      PRD_manaPercentageFontString:SetScale(value)
      PRD_settingsConfig.percentageScale = value

      _G[percentageTextScale_Slider:GetName().."Text"]:SetText("Text scale: |cfffdf457"..PRD_round(value, 1))

      if value == 1 then
        _G[percentageTextScale_Slider:GetName() .. 'Low']:SetText("|cff66ff33"..minScale)
        _G[percentageTextScale_Slider:GetName() .. 'High']:SetText("|cff66ff33"..maxScale)
      else
        _G[percentageTextScale_Slider:GetName() .. 'Low']:SetText(minScale)
        _G[percentageTextScale_Slider:GetName() .. 'High']:SetText(maxScale)
      end
    end)
    percentageTextScale_Slider:RegisterForDrag("LeftButton")
    percentageTextScale_Slider:SetScript("OnDragStart", function(self, button) InterfaceOptionsFrame:SetAlpha(backgroundSettingsFrameOpacity) end)
    percentageTextScale_Slider:SetScript("OnDragStop", function(self, button) InterfaceOptionsFrame:SetAlpha(1.0) end)
    percentageTextScale_Slider:Show()
  
  set.InterfaceOptions.scale_Slider = CreateFrame("Slider", "scale_Slider", set.InterfaceOptions, "OptionsSliderTemplate")
    scale_Slider:SetMinMaxValues(minScale, maxScale)
    scale_Slider:SetOrientation("HORIZONTAL")
    scale_Slider:SetStepsPerPage(0.1)
    scale_Slider:SetValueStep(0.1)
    scale_Slider:SetObeyStepOnDrag(true)
    scale_Slider:SetWidth(200)
    scale_Slider:SetHeight(20)
    scale_Slider:SetPoint("TOPLEFT", set.InterfaceOptions, "TOPLEFT", 110, -335);
    scale_Slider.tooltipText = "Control the scale of the frames. Default value |cff66ff33(1)|r is highlighted with green."
    _G[scale_Slider:GetName() .. 'Low']:SetText(""..minScale)
    _G[scale_Slider:GetName() .. 'High']:SetText(""..maxScale)
    scale_Slider:SetScript("OnValueChanged", function(self, value)
      PRD_personalHealthBar:SetScale(value)
      PRD_personalManaBar:SetScale(value)
      PRD_settingsConfig.scale = value
      _G[scale_Slider:GetName() .. 'Text']:SetText("PRD scale: |cfffdf457"..math.floor(value*100)/100)
      if value == 1 then
        _G[scale_Slider:GetName() .. 'Low']:SetText("|cff66ff33"..minScale)
        _G[scale_Slider:GetName() .. 'High']:SetText("|cff66ff33"..maxScale)
      else
        _G[scale_Slider:GetName() .. 'Low']:SetText(minScale)
        _G[scale_Slider:GetName() .. 'High']:SetText(maxScale)
      end
    end)
    scale_Slider:RegisterForDrag("LeftButton")
    scale_Slider:SetScript("OnDragStart", function(self, button) InterfaceOptionsFrame:SetAlpha(backgroundSettingsFrameOpacity) end)
    scale_Slider:SetScript("OnDragStop", function(self, button) InterfaceOptionsFrame:SetAlpha(1.0) end)
    scale_Slider:Show()
  
  set.InterfaceOptions.width_Slider = CreateFrame("Slider", "width_Slider", set.InterfaceOptions, "OptionsSliderTemplate")
    width_Slider:SetMinMaxValues(minWidth, maxWidth)
    width_Slider:SetOrientation("HORIZONTAL")
    width_Slider:SetStepsPerPage(1)
    width_Slider:SetValueStep(10)
    width_Slider:SetObeyStepOnDrag(true)
    width_Slider:SetWidth(200)
    width_Slider:SetHeight(20)
    width_Slider:SetPoint("TOPLEFT", set.InterfaceOptions, "TOPLEFT", 110, -375);
    width_Slider.tooltipText = "Control the width of the frames. Default value |cff66ff33("..personalResourceBarWidth..")|r is highlighted with green."
    _G[width_Slider:GetName() .. 'Low']:SetText(""..minWidth)
    _G[width_Slider:GetName() .. 'High']:SetText(""..maxWidth)
    width_Slider:SetScript("OnValueChanged", function(self, value)
      PRD_personalHealthBar:SetWidth(value)
      PRD_personalManaBar:SetWidth(value)
      PRD_personalHealthBarBorder:SetWidth(value + 5)
      PRD_personalManaBarBorder:SetWidth(value + 5)
      _G[width_Slider:GetName() .. 'Text']:SetText("PRD frames width |cfffdf457"..math.floor((ceil(value - .5)*100)/100))
      PRD_settingsConfig.width = value
      if value == personalResourceBarWidth then
        _G[width_Slider:GetName() .. 'Low']:SetText("|cff66ff33"..minWidth)
        _G[width_Slider:GetName() .. 'High']:SetText("|cff66ff33"..maxWidth)
      else
        _G[width_Slider:GetName() .. 'Low']:SetText(minWidth)
        _G[width_Slider:GetName() .. 'High']:SetText(maxWidth)
      end
    end)
    width_Slider:RegisterForDrag("LeftButton")
    width_Slider:SetScript("OnDragStart", function(self, button) InterfaceOptionsFrame:SetAlpha(backgroundSettingsFrameOpacity) end)
    width_Slider:SetScript("OnDragStop", function(self, button) InterfaceOptionsFrame:SetAlpha(1.0) end)
    width_Slider:Show() 

  set.InterfaceOptions.verticalPosition_Slider = CreateFrame("Slider", "verticalPosition_Slider", set.InterfaceOptions, "OptionsSliderTemplate")
    verticalPosition_Slider:SetMinMaxValues(minVerticalPosition, maxVerticalPosition)
    verticalPosition_Slider:SetOrientation("HORIZONTAL")
    verticalPosition_Slider:SetStepsPerPage(0.5)
    verticalPosition_Slider:SetValueStep(0.5)
    verticalPosition_Slider:SetObeyStepOnDrag(true)
    verticalPosition_Slider:SetWidth(200)
    verticalPosition_Slider:SetHeight(20)
    verticalPosition_Slider:SetPoint("TOPLEFT", set.InterfaceOptions, "TOPLEFT", 110, -415);
    verticalPosition_Slider.tooltipText = "Move the frames along the Y axis. Default value |cff66ff33("..personalResourceBarBaseTopPadding..")|r is highlighted with green."
    _G[verticalPosition_Slider:GetName() .. 'Low']:SetText(""..minVerticalPosition)
    _G[verticalPosition_Slider:GetName() .. 'High']:SetText(""..maxVerticalPosition)
    verticalPosition_Slider:SetScript("OnValueChanged", function(self, value)
      PRD_moveVertically(value)
    end)
    verticalPosition_Slider:RegisterForDrag("LeftButton")
    verticalPosition_Slider:SetScript("OnDragStart", function(self, button) InterfaceOptionsFrame:SetAlpha(backgroundSettingsFrameOpacity) end)
    verticalPosition_Slider:SetScript("OnDragStop", function(self, button) InterfaceOptionsFrame:SetAlpha(1.0) end)
    verticalPosition_Slider:Show()

  set.InterfaceOptions.opacity_Slider = CreateFrame("Slider", "opacity_Slider", set.InterfaceOptions, "OptionsSliderTemplate")
    opacity_Slider:SetMinMaxValues(minOpacityOOC, maxOpacityOOC)
    opacity_Slider:SetOrientation("HORIZONTAL")
    opacity_Slider:SetStepsPerPage(0.05)
    opacity_Slider:SetValueStep(0.05)
    opacity_Slider:SetObeyStepOnDrag(true)
    opacity_Slider:SetWidth(200)
    opacity_Slider:SetHeight(20)
    opacity_Slider:SetPoint("TOPLEFT", set.InterfaceOptions, "TOPLEFT", 335, -415);
    opacity_Slider.tooltipText = "Modify the value of opacity for the frames while out of combat. Default value: |cff66ff33"..defaultOpacityOOC
    _G[opacity_Slider:GetName() .. 'Low']:SetText(""..minOpacityOOC)
    _G[opacity_Slider:GetName() .. 'High']:SetText(""..maxOpacityOOC)
    opacity_Slider:SetScript("OnValueChanged", function(self, value)
      _G[opacity_Slider:GetName() .. 'Text']:SetText("Opacity while OOC: |cfffdf457"..PRD_round(value, 2))
      PRD_settingsConfig.opacityOOC = value
      local playerIsInCombat = UnitAffectingCombat("player")
        if playerIsInCombat == false and PRD_settingsConfig.hideInCombat then
          PRD_personalManaBar:SetAlpha(PRD_settingsConfig.opacityOOC)
          PRD_personalHealthBar:SetAlpha(PRD_settingsConfig.opacityOOC)
        end
    end)
    -- opacity_Slider:RegisterForDrag("LeftButton") -- now registered and unregistered according to the enabled status
    opacity_Slider:SetScript("OnDragStart", function(self, button) InterfaceOptionsFrame:SetAlpha(backgroundSettingsFrameOpacity) end)
    opacity_Slider:SetScript("OnDragStop", function(self, button) InterfaceOptionsFrame:SetAlpha(1.0) end)
    opacity_Slider:Show()

  set.InterfaceOptions.classColorHealthBar = CreateFrame("CheckButton", "classColorHealthBar_checkBox", set.InterfaceOptions, "ChatConfigCheckButtonTemplate")
    classColorHealthBar_checkBox:SetPoint("TOPLEFT", set.InterfaceOptions, "TOPLEFT", 300, -180);
    _G[classColorHealthBar_checkBox:GetName().."Text"]:SetText("Class color health bar");
    classColorHealthBar_checkBox.tooltip = "Set health bar tint to Class color. This will automatically disable the 'Dynamic HP color' feature."
    classColorHealthBar_checkBox:SetScript("OnClick", function()
      toggleClassColorHealthBar()
    end)

  set.InterfaceOptions.resetButtonText = set.InterfaceOptions:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    set.InterfaceOptions.resetButtonText:SetText("Reset")
    set.InterfaceOptions.resetButtonText:SetJustifyH("CENTER")
    set.InterfaceOptions.resetButtonText:SetJustifyV("CENTER")
    set.InterfaceOptions.resetButtonText:SetPoint("CENTER")

  local resetToDefault_button = CreateFrame("Button", "resetToDefault_button", set.InterfaceOptions)
    resetToDefault_button:SetWidth(90)
    resetToDefault_button:SetHeight(35)
    resetToDefault_button:SetNormalTexture("Interface\\BUTTONS\\UI-DialogBox-Button-Up")
    resetToDefault_button:SetPushedTexture("Interface\\BUTTONS\\UI-DialogBox-Button-Down")
    resetToDefault_button:SetHighlightTexture("Interface\\BUTTONS\\UI-DialogBox-Button-Highlight")
    resetToDefault_button:SetDisabledTexture("Interface\\BUTTONS\\UI-DialogBox-Button-Disabled")
    resetToDefault_button:SetPoint("TOPLEFT", set.InterfaceOptions, "CENTER", 0, 165);
    resetToDefault_button:SetNormalFontObject("GameFontNormalLarge")
    resetToDefault_button:SetFontString(set.InterfaceOptions.resetButtonText)
    resetToDefault_button:SetText("Reset")
    resetToDefault_button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:AddLine("Reset all the width, scale and position values to default.", 1, 0.79, 0.1, 1)
        GameTooltip:Show()
    end)
    resetToDefault_button:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
    resetToDefault_button:SetScript("OnClick", PRD_resetFramesToDefault)
    resetToDefault_button:RegisterForClicks("AnyUp")
    resetToDefault_button:Enable()

    set.InterfaceOptions.resetButtonText:SetPoint("CENTER", resetToDefault_button, "CENTER", 0, 4)
-- end of settings code

local function handleResourceBarType()
  if playerClass == "ROGUE" then
    PRD_personalManaBar:SetStatusBarColor(1, 1, 0)
    manaPercentageTextColor = "ffff00"
  elseif playerClass == "WARRIOR" then
    PRD_personalManaBar:SetStatusBarColor(1, 0, 0)
    manaPercentageTextColor = "ff1a1a"
  else
    PRD_personalManaBar:SetStatusBarColor(0, 0.2, 1)
    manaPercentageTextColor = "66c2ff"
  end

  PRD_personalManaBar:SetValue(getCurrentManaBarValuePercentage())
  updatePercentageText()
end


local function PRD_preloadInterfaceOptionsFrame()
  -- ! UNUSED ! Read for more info.
  -- until the addon settings have been opened at least once, the OpenToCategory will only bring to the generic interface settings frame.
  -- but from the second time on, it will actually load the specific addon settings frame.
  -- so programmatically "opening" (and closing) it in the addon loading cycle will actually load the page, effectively allowing the user to skip the first step.

  -- WARNING! This method has been reported on the addon CurseForge page to mess with the actual client interface settings, specifically disabling extra action bars upon login.
  -- So I think I'll rather give the 'shortcut' up and avoid messing with the bars.
  InterfaceOptionsFrame_OpenToCategory(set.InterfaceOptions)
  HideUIPanel(InterfaceOptionsFrame) 
end

function PRD_onPlayerResourceChange(self, event, ...)
  if (event == "UNIT_HEALTH") then
    PRD_personalHealthBar:SetValue(getCurrentHealthBarValuePercentage())
    updatePercentageText()
  elseif (event == "UNIT_POWER_UPDATE") then
    PRD_personalManaBar:SetValue(getCurrentManaBarValuePercentage())
    updatePercentageText()
  elseif (event == "UNIT_MAXHEALTH") then
    playerMaxHealthReady = true
    playerMaxHealth = UnitHealthMax("player")
  elseif (event == "UPDATE_SHAPESHIFT_FORM") then
    -- could actually do this part along with the handleResourceBarType() but I would keep that for login and this for druids only
    -- since Warriors stances are treated as shapeshifts too, I will only register for this event when the player is playing a druid.
    -- ported from my 5.4.8 original version
    local formId = GetShapeshiftFormID()
    if formId == 1 then
      -- should be Cat form
      PRD_personalManaBar:SetStatusBarColor(1, 1, 0)
      manaPercentageTextColor = "ffff00"
    elseif formId == 5 then
      -- and Bear form
      PRD_personalManaBar:SetStatusBarColor(1, 0, 0)
      manaPercentageTextColor = "ff1a1a"
    else
      PRD_personalManaBar:SetStatusBarColor(0, 0.2, 1)
      manaPercentageTextColor = "66c2ff"
    end
  elseif (event == "PLAYER_REGEN_DISABLED") then
    PRD_personalManaBar:SetAlpha(1.0)
    PRD_personalHealthBar:SetAlpha(1.0)
  elseif (event == "PLAYER_REGEN_ENABLED") then
    PRD_personalManaBar:SetAlpha(PRD_settingsConfig.opacityOOC)
    PRD_personalHealthBar:SetAlpha(PRD_settingsConfig.opacityOOC)
  elseif (event == "ADDON_LOADED") then
    -- In this phase we are also sure that SavedVars have been read and are stored in memory already.
    if select(1, ...) == "Personal Resource Display" then
      if not PRD_logCount then
        -- first launch, create default values in the table.
        print("Welcome to |cff66ff33"..addonName.."|r - "..addonNotes..".\nFirst launch detected, using default settings.");
        PRD_settingsConfig["strataLevel"] = 1
        PRD_settingsConfig["showBorder"] = true
        PRD_settingsConfig["showMinimap"] = true
        PRD_settingsConfig["hideInCombat"] = false
        PRD_settingsConfig["opacityOOC"] = defaultOpacityOOC
        PRD_settingsConfig["scale"] = 1
        PRD_settingsConfig["percentageScale"] = 1
        PRD_settingsConfig["percentagePadding"] = defaultPercentagePadding
        PRD_settingsConfig["width"] = personalResourceBarWidth
        PRD_settingsConfig["verticalPosition"] = personalResourceBarBaseTopPadding
        PRD_settingsConfig["numericHealthValue"] = false
        PRD_settingsConfig["extendedNumericValue"] = false
        PRD_settingsConfig["showPercentage"] = false
        PRD_settingsConfig["showReversePercentage"] = false
        PRD_settingsConfig["dynamicHealthColor"] = true
        PRD_settingsConfig["hideHealthBar"] = false
        PRD_settingsConfig["classColorHealthBar"] = false

        -- this is actually the angle in degrees for the minimap button, cba renaming
        PRD_minimapButtonConfig = 0

        PRD_logCount = 1
      end

      -- minimap position
      local xpos, ypos = 80 * cos(PRD_minimapButtonConfig), 80 * sin(PRD_minimapButtonConfig)
      PRD_MinimapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 54-xpos, ypos-54)

      -- placing the bars
      PRD_personalHealthBar:SetPoint("CENTER", 0, PRD_settingsConfig.verticalPosition)
      PRD_personalManaBar:SetPoint("CENTER", 0, PRD_settingsConfig["verticalPosition"] - personalResourceBarHeight)

      InterfaceOptions_AddCategory(set.InterfaceOptions)  
      
      -- setting the strata
      UIDropDownMenu_SetText(dropDown, frameStratas[PRD_settingsConfig.strataLevel])
      PRD_personalHealthBar:SetFrameStrata(frameStratas[PRD_settingsConfig.strataLevel])
      PRD_personalManaBar:SetFrameStrata(frameStratas[PRD_settingsConfig.strataLevel])

      -- ..width
      PRD_personalHealthBar:SetWidth(PRD_settingsConfig.width)
      PRD_personalManaBar:SetWidth(PRD_settingsConfig.width)

      -- ..opacity
      _G['opacity_Slider']:SetShown(PRD_settingsConfig.hideInCombat)
      if PRD_settingsConfig.hideInCombat then
        personalResourceBarsEventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
        personalResourceBarsEventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
        local playerIsInCombat = UnitAffectingCombat("player")
        if playerIsInCombat == false then
          PRD_personalManaBar:SetAlpha(PRD_settingsConfig.opacityOOC)
          PRD_personalHealthBar:SetAlpha(PRD_settingsConfig.opacityOOC)
        end
      else 
        personalResourceBarsEventFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
        personalResourceBarsEventFrame:UnregisterEvent("PLAYER_REGEN_DISABLED")
        PRD_personalManaBar:SetAlpha(1.0)
        PRD_personalHealthBar:SetAlpha(1.0)
      end
      
      -- ..percentage padding and scale
      PRD_healthPercentageFontString:SetPoint("LEFT", PRD_settingsConfig.percentagePadding, 1)
      PRD_manaPercentageFontString:SetPoint("LEFT", PRD_settingsConfig.percentagePadding, -1)
      PRD_healthPercentageFontString:SetScale(PRD_settingsConfig.percentageScale)
      PRD_manaPercentageFontString:SetScale(PRD_settingsConfig.percentageScale)

      -- ..and bar scale
      PRD_personalHealthBar:SetScale(PRD_settingsConfig.scale)
      PRD_personalManaBar:SetScale(PRD_settingsConfig.scale)

      -- showing all the frames at launch
      PRD_personalHealthBar:SetShown(not PRD_settingsConfig.hideHealthBar)
      PRD_personalHealthBarBorder:SetShown(PRD_settingsConfig.showBorder)
      PRD_personalManaBarBorder:SetShown(PRD_settingsConfig.showBorder)
      PRD_MinimapButton:SetShown(PRD_settingsConfig.showMinimap)
      PRD_healthPercentageFontString:SetShown(PRD_settingsConfig.showPercentage or PRD_settingsConfig.numericHealthValue)
      PRD_manaPercentageFontString:SetShown(PRD_settingsConfig.showPercentage or PRD_settingsConfig.numericHealthValue)

      -- setting all the slider values according to SavedVars
      scale_Slider:SetValue(PRD_settingsConfig.scale)
      _G[scale_Slider:GetName() .. 'Text']:SetText("PRD frames scale |cfffdf457"..math.floor(PRD_settingsConfig.scale*100)/100)

      width_Slider:SetValue(PRD_settingsConfig.width)
      _G[width_Slider:GetName() .. 'Text']:SetText("PRD frames width |cfffdf457"..math.floor(PRD_settingsConfig.width*100)/100)

      verticalPosition_Slider:SetValue(PRD_settingsConfig.verticalPosition)
      _G[verticalPosition_Slider:GetName() .. 'Text']:SetText("PRD y position: |cfffdf457"..math.floor(PRD_settingsConfig.verticalPosition*100)/100)

      opacity_Slider:SetValue(PRD_settingsConfig.opacityOOC)
      -- _G[opacity_Slider:GetName().."Text"]:SetText("Opacity while OOC:|cfffdf457"..PRD_round(PRD_settingsConfig.opacityOOC, 1)) -- handled via checkbox
      
      percentageTextPadding_Slider:SetValue(PRD_settingsConfig.percentagePadding)
      _G[percentageTextPadding_Slider:GetName().."Text"]:SetText("Text placement: |cfffdf457"..math.floor((ceil(PRD_settingsConfig.percentagePadding - .5)*100)/100))

      percentageTextScale_Slider:SetValue(PRD_settingsConfig.percentageScale)
      _G[percentageTextScale_Slider:GetName().."Text"]:SetText("Text scale: |cfffdf457"..math.floor((ceil(PRD_settingsConfig.percentageScale - .5)*100)/100))

      percentageTextPadding_Slider:SetShown(PRD_settingsConfig.showPercentage or PRD_settingsConfig.numericHealthValue)
      percentageTextScale_Slider:SetShown(PRD_settingsConfig.showPercentage or PRD_settingsConfig.numericHealthValue)
      showReversePercentage_checkBox:SetEnabled(PRD_settingsConfig.showPercentage)
      if PRD_settingsConfig.showPercentage then
        _G[set.InterfaceOptions.showReversePercentage_checkBox:GetName().."Text"]:SetText("Use reverse percentage")
      else
        _G[set.InterfaceOptions.showReversePercentage_checkBox:GetName().."Text"]:SetText("|cff8e8e8cUse reverse percentage")
      end

      if not PRD_settingsConfig.numericHealthValue then
        _G["extendedNumericValues_checkBoxText"]:SetText("|cff8e8e8cExtended numeric values")
      end
      extendedNumericValues_checkBox:SetEnabled(PRD_settingsConfig.numericHealthValue)

      if PRD_settingsConfig.classColorHealthBar then
        PRD_personalHealthBar:SetStatusBarColor(classColors[playerClass]["r"], classColors[playerClass]["g"], classColors[playerClass]["b"])
        PRD_settingsConfig.dynamicHealthColor = false
      else
        PRD_personalHealthBar:SetStatusBarColor(0, 1, 0)
      end
      
      -- and the checkboxes too.
      showBorder_checkBox:SetChecked(PRD_settingsConfig.showBorder)
      hideMinimap_checkBox:SetChecked(PRD_settingsConfig.showMinimap)
      hideInCombat_checkBox:SetChecked(PRD_settingsConfig.hideInCombat)
      showPercentage_checkBox:SetChecked(PRD_settingsConfig.showPercentage)
      showReversePercentage_checkBox:SetChecked(PRD_settingsConfig.showReversePercentage)
      dynamicHealthColor_checkBox:SetChecked(PRD_settingsConfig.dynamicHealthColor)
      hideHealthBar_checkBox:SetChecked(PRD_settingsConfig.hideHealthBar)
      classColorHealthBar_checkBox:SetChecked(PRD_settingsConfig.classColorHealthBar)
      numericHealthValue_checkBox:SetChecked(PRD_settingsConfig.numericHealthValue)
      extendedNumericValues_checkBox:SetChecked(PRD_settingsConfig.extendedNumericValue)

      -- PRD_preloadInterfaceOptionsFrame()
    end
  elseif (event == "PLAYER_ENTERING_WORLD") then
    --[[ because of either retarded limitations or code flaws, UnitMaxHealth is returning 0 upon login until the health gets modified by damage/regen
    therefore, as calculating the percentage involves dividing by MaxHealth, it would return infinite as long as it is zero.
    a couple frames will occurr at launch, in which the health bar and percentage are shown as full/100, because I set MaxHP equal to the CurrentHP
    this is noticeable if the player logs in with some health already missing but it will fix itself with the first regen tick
    You can tell it by printing the UNIT_MAXHEALTH event in the chat, when it gets fired it means the correct MaxHealth has been retrieved.
    ]]
    if playerMaxHealthReady == false then
      playerMaxHealth = UnitHealth("player")
    end

    -- PLAYER_ENTERING_WORLD is the only phase of the loading cycle in which the mana amount is already loaded.
    -- Anything prior to that will return NaN, and the bar will not fill up until /reloaded.
    handleResourceBarType()
  end
end

-- Procedural code
-- also add widgets handlers here
if playerClass == "DRUID" then
  personalResourceBarsEventFrame:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
end

-- Adding scripts to UI
personalResourceBarsEventFrame:SetScript("OnEvent", PRD_onPlayerResourceChange)

MinimapButton:SetScript("OnEnter", function(self)
  GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
  GameTooltip:AddLine("|cffff4d4d"..addonName.." ("..addonVersion..")|r")
  GameTooltip:AddLine("|cff66ff33LMB|r - toggle the health and mana frames on/off\n|cff66ff33Mod LMB|r - hide this minimap button (can be shown through interface options)\n|cff66ff33Drag LMB|r - move this button")
  GameTooltip:AddLine("|cff66ff33RMB|r - toggle the addon settings frame on/off\n|cff66ff33Mod RMB|r - reset the frame to default values")
  GameTooltip:AddLine("|cff66ff33/prd <value>|r command moves the bars vertically\n<value> is the units of distance from the middle of the screen\nDefault value is: |cffff4d4d"..personalResourceBarBaseTopPadding.."|r")
  GameTooltip:AddLine("|cff66ff33/prd reset|r also resets the frame to default")
  GameTooltip:AddLine("|cff66ff33/prd|r opens the settings tab")
  GameTooltip:Show()
end)

MinimapButton:SetScript("OnLeave", function(self)
  GameTooltip:Hide()
end)
  
MinimapButton:SetScript("OnClick", function(self, button)
  -- These alone would suffice to toggle the bars on/off, but i'd rather unregister as many listeners as possible cause I don't like wasting resources
  -- PRD_personalManaBar:SetShown(not PRD_personalManaBar:IsShown())
  -- PRD_personalHealthBar:SetShown(not PRD_personalHealthBar:IsShown())

  if button == "LeftButton" then
    if isModKeyDown() then
      toggleMinimap(true)
    else
      if PRD_personalManaBar:IsShown() then
        PRD_personalManaBar:SetShown(false)
        PRD_personalHealthBar:SetShown(false)
        personalResourceBarsEventFrame:UnregisterEvent("UNIT_POWER_UPDATE", "player")
        personalResourceBarsEventFrame:UnregisterEvent("UNIT_HEALTH", "player")
        personalResourceBarsEventFrame:UnregisterEvent("UNIT_MAXHEALTH", "player")
        personalResourceBarsEventFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
      else
        PRD_personalHealthBar:SetShown(true)
        PRD_personalManaBar:SetShown(true)
        personalResourceBarsEventFrame:RegisterUnitEvent("UNIT_POWER_UPDATE", "player")
        personalResourceBarsEventFrame:RegisterUnitEvent("UNIT_HEALTH", "player")
        personalResourceBarsEventFrame:RegisterUnitEvent("UNIT_MAXHEALTH", "player")
        personalResourceBarsEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
      end
    end
  elseif button == "RightButton" then
    if isModKeyDown() then PRD_resetFramesToDefault() else
      if InterfaceOptionsFrame:IsVisible() then HideUIPanel(InterfaceOptionsFrame) else InterfaceOptionsFrame_OpenToCategory(set.InterfaceOptions) end
    end    
  end
  
end)

MinimapButton:SetScript("OnDragStart", function(self) self:SetScript("OnUpdate", dragMinimapButton) end)
MinimapButton:SetScript("OnDragStop", function(self) self:SetScript("OnUpdate", nil) end)

-- no longer a function
--createPersonalResourceDisplay() 

SLASH_PERSONALRESOURCEDISPLAY1 = "/prd"
SlashCmdList["PERSONALRESOURCEDISPLAY"] = function(cmd)  
  if not cmd or cmd == "" then
    InterfaceOptionsFrame_OpenToCategory(set.InterfaceOptions)
  elseif cmd == "reset" then
    PRD_resetFramesToDefault()
  else
    local newPadding = tonumber(cmd, 10)
    if not newPadding then
      StaticPopup_Show("PRD_WRONG_SYNTAX");
      return
    end
    --PRD_personalHealthBar:SetPoint("CENTER", 0, newPadding)
    --PRD_personalManaBar:SetPoint("CENTER", 0, newPadding-personalResourceBarHeight)
    PRD_moveVertically(newPadding)
  end
end


-- Thank you for your interest in using this mod! 
