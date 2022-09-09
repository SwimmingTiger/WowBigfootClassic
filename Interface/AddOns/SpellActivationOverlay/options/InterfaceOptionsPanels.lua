local AddonName, SAO = ...

function SpellActivationOverlayOptionsPanel_Init(self)
    local opacitySlider = SpellActivationOverlayOptionsPanelSpellAlertOpacitySlider;
    opacitySlider.Text:SetText("Spell Alert opacity");
    _G[opacitySlider:GetName().."Low"]:SetText(OFF);
    opacitySlider:SetMinMaxValues(0, 1);
    opacitySlider:SetValueStep(0.05);
    opacitySlider.initialValue = SpellActivationOverlayDB.alert.opacity;
    opacitySlider:SetValue(opacitySlider.initialValue);
    opacitySlider.ApplyValueToEngine = function(self, value)
        SpellActivationOverlayDB.alert.opacity = value;
        SpellActivationOverlayDB.alert.enabled = value > 0;
        SAO:ApplySpellAlertOpacity();
    end

    local scaleSlider = SpellActivationOverlayOptionsPanelSpellAlertScaleSlider;
    scaleSlider.Text:SetText("Spell Alert scale");
    _G[scaleSlider:GetName().."Low"]:SetText(SMALL);
    _G[scaleSlider:GetName().."High"]:SetText(LARGE);
    scaleSlider:SetMinMaxValues(0.25, 2.5);
    scaleSlider:SetValueStep(0.05);
    scaleSlider.initialValue = SpellActivationOverlayDB.alert.scale;
    scaleSlider:SetValue(scaleSlider.initialValue);
    scaleSlider.ApplyValueToEngine = function(self, value)
        SpellActivationOverlayDB.alert.scale = value;
        SAO:ApplySpellAlertGeometry();
    end

    local offsetSlider = SpellActivationOverlayOptionsPanelSpellAlertOffsetSlider;
    offsetSlider.Text:SetText("Spell Alert offset");
    _G[offsetSlider:GetName().."Low"]:SetText(NEAR);
    _G[offsetSlider:GetName().."High"]:SetText(FAR);
    offsetSlider:SetMinMaxValues(-200, 400);
    offsetSlider:SetValueStep(20);
    offsetSlider.initialValue = SpellActivationOverlayDB.alert.offset;
    offsetSlider:SetValue(offsetSlider.initialValue);
    offsetSlider.ApplyValueToEngine = function(self, value)
        SpellActivationOverlayDB.alert.offset = value;
        SAO:ApplySpellAlertGeometry();
    end

    local testButton = SpellActivationOverlayOptionsPanelSpellAlertTestButton;
    testButton:SetText("Toggle Test");
    testButton.fakeSpellID = 42;
    testButton.isTesting = false;
    testButton.StartTest = function(self)
        if (not self.isTesting) then
            self.isTesting = true;
            SAO:ActivateOverlay(0, self.fakeSpellID, SAO.TexName["imp_empowerment"], "Left + Right (Flipped)", 1, 255, 255, 255, false);
            SAO:ActivateOverlay(0, self.fakeSpellID, SAO.TexName["brain_freeze"], "Top", 1, 255, 255, 255, false);
            -- Hack the frame to force full opacity even when out of combat
            SpellActivationOverlayFrame.disableDimOutOfCombat = true;
            SpellActivationOverlayFrame:SetAlpha(1);
        end
    end
    testButton.StopTest = function(self)
        if (self.isTesting) then
            self.isTesting = false;
            SAO:DeactivateOverlay(self.fakeSpellID);
            -- Undo hack
            SpellActivationOverlayFrame.disableDimOutOfCombat = nil;
            if (not InCombatLockdown()) then
                SpellActivationOverlayFrame.combatAnimOut:Play();
            end
        end
    end
    testButton:SetEnabled(SpellActivationOverlayDB.alert.enabled);

    local glowingButtonCheckbox = SpellActivationOverlayOptionsPanelGlowingButtons;
    glowingButtonCheckbox.Text:SetText("Glowing Buttons");
    glowingButtonCheckbox.initialValue = SpellActivationOverlayDB.glow.enabled;
    glowingButtonCheckbox:SetChecked(glowingButtonCheckbox.initialValue);
    glowingButtonCheckbox.ApplyValueToEngine = function(self, checked)
        SpellActivationOverlayDB.glow.enabled = checked;
        SAO:ApplyGlowingButtonsToggle();
    end
end

-- User clicks OK to the options panel
local function okayFunc(self)
    local opacitySlider = SpellActivationOverlayOptionsPanelSpellAlertOpacitySlider;
    opacitySlider.initialValue = opacitySlider:GetValue();

    local scaleSlider = SpellActivationOverlayOptionsPanelSpellAlertScaleSlider;
    scaleSlider.initialValue = scaleSlider:GetValue();

    local offsetSlider = SpellActivationOverlayOptionsPanelSpellAlertOffsetSlider;
    offsetSlider.initialValue = offsetSlider:GetValue();

    local glowingButtonCheckbox = SpellActivationOverlayOptionsPanelGlowingButtons;
    glowingButtonCheckbox.initialValue = glowingButtonCheckbox:GetChecked();
end

-- User clicked Cancel to the options panel
local function cancelFunc(self)
    local opacitySlider = SpellActivationOverlayOptionsPanelSpellAlertOpacitySlider;
    local scaleSlider = SpellActivationOverlayOptionsPanelSpellAlertScaleSlider;
    local offsetSlider = SpellActivationOverlayOptionsPanelSpellAlertOffsetSlider;
    local glowingButtonCheckbox = SpellActivationOverlayOptionsPanelGlowingButtons;

    self:applyAll(
        opacitySlider.initialValue,
        scaleSlider.initialValue,
        offsetSlider.initialValue,
        glowingButtonCheckbox.initialValue
    );
end

-- User reset settings to default values
local function defaultFunc(self)
    self:applyAll(
        1, -- opacity
        1, -- scale
        0, -- offset
        true -- glow
    );
end

local function applyAllFunc(self, opacityValue, scaleValue, offsetValue, isGlowEnabled)
    local opacitySlider = SpellActivationOverlayOptionsPanelSpellAlertOpacitySlider;
    opacitySlider:SetValue(opacityValue);
    if (SpellActivationOverlayDB.alert.opacity ~= opacityValue) then
        SpellActivationOverlayDB.alert.opacity = opacityValue;
        SpellActivationOverlayDB.alert.enabled = opacityValue > 0;
        SAO:ApplySpellAlertOpacity();
    end

    local geometryChanged = false;

    local scaleSlider = SpellActivationOverlayOptionsPanelSpellAlertScaleSlider;
    scaleSlider:SetValue(scaleValue);
    if (SpellActivationOverlayDB.alert.scale ~= scaleValue) then
        SpellActivationOverlayDB.alert.scale = scaleValue;
        geometryChanged = true;
    end

    local offsetSlider = SpellActivationOverlayOptionsPanelSpellAlertOffsetSlider;
    offsetSlider:SetValue(offsetValue);
    if (SpellActivationOverlayDB.alert.offset ~= offsetValue) then
        SpellActivationOverlayDB.alert.offset = offsetValue;
        geometryChanged = true;
    end

    if (geometryChanged) then
        SAO:ApplySpellAlertGeometry();
    end

    local testButton = SpellActivationOverlayOptionsPanelSpellAlertTestButton;
    -- Enable/disable the test button with alert.enabled, which was set/reset a few lines above, alongside opacity
    testButton:SetEnabled(SpellActivationOverlayDB.alert.enabled);

    local glowingButtonCheckbox = SpellActivationOverlayOptionsPanelGlowingButtons;
    glowingButtonCheckbox:SetChecked(isGlowEnabled);
    if (SpellActivationOverlayDB.glow.enabled ~= isGlowEnabled) then
        SpellActivationOverlayDB.glow.enabled = isGlowEnabled;
        SAO:ApplyGlowingButtonsToggle();
    end
end

function SpellActivationOverlayOptionsPanel_OnLoad(self)
    self.name = AddonName;
    self.okay = okayFunc;
    self.cancel = cancelFunc;
    self.default = defaultFunc;
    self.applyAll = applyAllFunc; -- not a callback used by Blizzard's InterfaceOptions_AddCategory, but used by us

    InterfaceOptions_AddCategory(self);

    SAO.OptionsPanel = self;
end
