local AddonName, SAO = ...

-- List of known ActionButton instances that currently match one of the spell IDs to track
-- This does not mean that buttons are glowing right now, but they could glow at any time
-- key = glowID (= spellID of action), value = list of ActionButton objects for this spell
-- (side note: the sublist of buttons is a table of key = button and a dummy value = true)
-- The list will change each time an action button changes, which may happen very often
-- For example, any macro with [mod:shift] updates the list every time Shift is pressed
SAO.ActionButtons = {}

-- Action buttons that are not tracked but could be tracked in the future
-- This re-track may happen if e.g. a new spell is learned or during delayed loading
SAO.DormantActionButtons = {}

-- List of spell IDs that should be currently glowing
-- key = glowID (= spellID of action), value = spellID of aura which triggered it recently
-- The list will change each time an overlay is triggered with a glowing effect
SAO.GlowingSpells = {}

-- List of spell IDs that should be tracked to glow action buttons
-- The spell ID may differ from the spell ID for the corresponding aura
-- key = glowID (= spell ID/name of the glowing spell), value = true
-- The lists should be setup at start, based on the player class
SAO.RegisteredGlowSpellIDs = {}

-- List of spell names that should be tracked to glow action buttons
-- This helps to fill RegisteredGlowSpellIDs e.g., when a spell is learned
SAO.RegisteredGlowSpellNames = {}

-- Register a list of glow ID
-- Each ID is either a numeric value (spellID) or a string (spellName)
function SAO.RegisterGlowIDs(self, glowIDs)
    for _, glowID in ipairs(glowIDs or {}) do
        if (type(glowID) == "number") then
            self.RegisteredGlowSpellIDs[glowID] = true;
        elseif (type(glowID) == "string") then
            if (not SAO.RegisteredGlowSpellNames[glowID]) then
                SAO.RegisteredGlowSpellNames[glowID] = true;
                local glowSpellIDs = self:GetSpellIDsByName(glowID);
                for _, glowSpellID in ipairs(glowSpellIDs) do
                    self.RegisteredGlowSpellIDs[glowSpellID] = true;
                end
            end
        end
    end
end

-- An action button has been updated
-- Check its old/new action and old/new spell ID, and put it in appropriate lists
-- If forceRefresh is true, refresh even if old spell ID and new spell ID are identical
-- Set forceRefresh if the spell ID of the button may switch from untracked to tracked (or vice versa) in light of recent events
function SAO.UpdateActionButton(self, button, forceRefresh)
    local oldGlowID = button.lastGlowID; -- Set by us, a few lines below
    local newGlowID = button:GetGlowID();
    button.lastGlowID = newGlowID; -- Write button.lastGlowID here, but use oldGlowID/newGlowID for the rest of the function

    if (oldGlowID == newGlowID and not forceRefresh) then
        -- Skip any processing if the glow ID hasn't changed
        return;
    end

    -- Register/unregister button as 'dormant' i.e., not tracked but could be tracked in the future
    if (oldGlowID and not self.RegisteredGlowSpellIDs[oldGlowID] and type(self.DormantActionButtons[oldGlowID]) == 'table') then
        if (self.DormantActionButtons[oldGlowID][button] == button) then
            self.DormantActionButtons[oldGlowID][button] = nil;
        end
    end
    if (newGlowID and not self.RegisteredGlowSpellIDs[newGlowID]) then
        if (type(self.DormantActionButtons[newGlowID]) == 'table') then
            if (self.DormantActionButtons[newGlowID][button] ~= button) then
                self.DormantActionButtons[newGlowID][button] = button;
            end
        else
            self.DormantActionButtons[newGlowID] = { [button] = button };
        end
    end

    if (not self.RegisteredGlowSpellIDs[oldGlowID] and not self.RegisteredGlowSpellIDs[newGlowID]) then
        -- Ignore action if it does not (nor did not) correspond to a tracked glowID
        return;
    end

    -- Untrack previous action button and track the new one
    if (oldGlowID and self.RegisteredGlowSpellIDs[oldGlowID] and type(self.ActionButtons[oldGlowID]) == 'table') then
        -- Detach action button from the former glow ID
        if (self.ActionButtons[oldGlowID][button] == button) then
            self.ActionButtons[oldGlowID][button] = nil;
        end
    end
    if (newGlowID and self.RegisteredGlowSpellIDs[newGlowID]) then
        if (type(self.ActionButtons[newGlowID]) == 'table') then
            -- Attach action button to the current glow ID
            if (self.ActionButtons[newGlowID][button] ~= button) then
                self.ActionButtons[newGlowID][button] = button;
            end
        else
            -- This glow ID has no Action Buttons yet: be the first
            self.ActionButtons[newGlowID] = { [button] = button };
        end
        -- Remove from the 'dormant' table, if it was dormant
        if (type(self.DormantActionButtons[newGlowID]) == 'table' and self.DormantActionButtons[newGlowID][button] == button) then
            self.DormantActionButtons[newGlowID][button] = nil;
        end
    end

    -- Glow or un-glow, if needed
    local wasGlowing = oldGlowID and (self.GlowingSpells[oldGlowID] ~= nil);
    local mustGlow = newGlowID and (self.GlowingSpells[newGlowID] ~= nil);

    if (not wasGlowing and mustGlow) then
        if (not SpellActivationOverlayDB or not SpellActivationOverlayDB.glow or SpellActivationOverlayDB.glow.enabled) then
            button:EnableGlow();
        end
    elseif (wasGlowing and not mustGlow) then
        button:DisableGlow();
    end
end

-- Grab all action button activity that allows us to know which button has which spell
function HookActionButton_Update(button)
    if (button:GetParent() == OverrideActionBar) then
        -- Act on all buttons but the ones from OverrideActionBar, whatever that is
        return;
    end

    if (not button.GetGlowID) then
        button.GetGlowID = function(button)
            if (button.action and HasAction(button.action)) then
                return SAO:GetSpellIDByActionSlot(button.action);
            end
        end
    end
    if (not button.EnableGlow) then
        button.EnableGlow = function(button)
            ActionButton_ShowOverlayGlow(button);
        end
    end
    if (not button.DisableGlow) then
        button.DisableGlow = function(button)
            ActionButton_HideOverlayGlow(button);
        end
    end
    SAO:UpdateActionButton(button);
end
hooksecurefunc("ActionButton_Update", HookActionButton_Update);

-- Also look for specific events for bar swaps when e.g. entering/leaving stealth
-- Not sure if it is really necessary, but in theory it will do nothing at worst
function HookActionButton_OnEvent(self, event)
    if (event == "ACTIONBAR_PAGE_CHANGED" or event == "UPDATE_BONUS_ACTIONBAR") then
        HookActionButton_Update(self);
    end
end
hooksecurefunc("ActionButton_OnEvent", HookActionButton_OnEvent);

-- Awake dormant buttons associated to a spellID
function SAO.AwakeButtonsBySpellID(self, spellID)
    local dormantButtons = {};
    for _, button in pairs(self.DormantActionButtons[spellID] or {}) do
        table.insert(dormantButtons, button);
    end
    for _, button in ipairs(dormantButtons) do
        self:UpdateActionButton(button, true);
    end
end

-- Add a glow effect for action buttons matching the given glow ID
-- @param glowID spell identifier of the glow; must be a number
function SAO.AddGlowNumber(self, spellID, glowID)
    local actionButtons = self.ActionButtons[glowID];
    if (self.GlowingSpells[glowID]) then
        self.GlowingSpells[glowID][spellID] = true;
    else
        self.GlowingSpells[glowID] = { [spellID] = true };
        for _, frame in pairs(actionButtons or {}) do
            if (not SpellActivationOverlayDB or not SpellActivationOverlayDB.glow or SpellActivationOverlayDB.glow.enabled) then
                frame:EnableGlow();
            end
        end
    end
end

-- Add a glow effect for action buttons matching one of the given glow IDs
-- Each glow ID may be a spell identifier (number) or spell name (string)
function SAO.AddGlow(self, spellID, glowIDs)
    if (glowIDs == nil) then
        return;
    end

    local glowingOptions = self:GetGlowingOptions(spellID);

    for _, glowID in ipairs(glowIDs) do

        -- Find if the glow option is enabled
        local glowEnabled = true; -- Enabled by default, in case there is not an option for it
        if (glowingOptions) then
            if (type(glowID) == "number" and type(glowingOptions[glowID]) == "boolean") then
                glowEnabled = glowingOptions[glowID];
            else
                local glowSpellName = (type(glowID) == "number") and GetSpellInfo(glowID) or glowID;
                for optionSpellID, optionEnabled in pairs(glowingOptions) do
                    if (GetSpellInfo(optionSpellID) == glowSpellName) then
                        glowEnabled = optionEnabled;
                        break;
                    end
                end
            end
        end

        -- Let it glow
        if (glowEnabled) then
            if (type(glowID) == "number") then
                -- glowID is a direct spell identifier
                self:AddGlowNumber(spellID, glowID);
            elseif (type(glowID) == "string") then
                -- glowID is a spell name: find spell identifiers and then parse them
                local glowSpellIDs = self:GetSpellIDsByName(glowID);
                for _, glowSpellID in ipairs(glowSpellIDs) do
                    self:AddGlowNumber(spellID, glowSpellID);
                end
            end
        end
    end
end

-- Remove the glow effect for action buttons matching any of the given spell IDs
function SAO.RemoveGlow(self, spellID)
    local consumedGlowSpellIDs = {};

    -- First, gather each glowSpellID attached to spellID
    for glowSpellID, triggerSpellIDs in pairs(self.GlowingSpells) do
        if (triggerSpellIDs[spellID]) then
            -- spellID is attached to this glowSpellID
            -- Gather how many triggers are attached to the same glowSpellID (spellID included)
            local count = 0;
            for _, _  in pairs(triggerSpellIDs) do
                count = count+1;
            end
            consumedGlowSpellIDs[glowSpellID] = count;
        end
    end

    -- Then detach the spellID <-> glowSpellID link
    -- And remove the glow if and only if the trigger was the last one asking to glow
    for glowSpellID, count in pairs(consumedGlowSpellIDs) do
        if (count > 1) then
            -- Only detach
            self.GlowingSpells[glowSpellID][spellID] = nil;
        else
            -- Detach and un-glow
            self.GlowingSpells[glowSpellID] = nil;
            local actionButtons = self.ActionButtons[glowSpellID];
            for _, frame in pairs(actionButtons or {}) do
                frame:DisableGlow();
            end
        end
    end
end

-- Track PLAYER_LOGIN which happens immediately after all ADDON_LOADED events
-- Which means, at this point we know which addons are installed and loaded
local binder = CreateFrame("Frame", "SpellActivationOverlayLABBinder");
binder:RegisterEvent("PLAYER_LOGIN");
binder:SetScript("OnEvent", function()
    if (not LibStub) then
        -- LibStub is a must-have to load libraries required by this binder
        return
    end

    local LAB = LibStub("LibActionButton-1.0", true);
    local LAB_ElvUI = LibStub("LibActionButton-1.0-ElvUI", true);
    local LBG = LibStub("LibButtonGlow-1.0", true);
    local LCG = LibStub("LibCustomGlow-1.0", true);

    local buttonUpdateFunc = function(libGlow, event, self)
        if (self._state_type ~= "action") then
            -- If button is not an "action", then GetSpellId is unusable
            -- This happens for instance with vehicle buttons
            -- They are probably not meant to glow, so it's simpler to just ignore them
            return;
        end
        if (not self.GetGlowID) then
            self.GetGlowID = self.GetSpellId;
        end
        if (not self.EnableGlow) then
            self.EnableGlow = function(button)
                libGlow.ShowOverlayGlow(button);
            end
        end
        if (not self.DisableGlow) then
            self.DisableGlow = function(button)
                libGlow.HideOverlayGlow(button);
            end
        end
        SAO:UpdateActionButton(self);
    end

    local LBGButtonUpdateFunc = function(event, self)
        buttonUpdateFunc(LBG, event, self);
    end

    local LCGButtonUpdateFunc = function(event, self)
        buttonUpdateFunc(LCG, event, self);
    end

    -- Support for LibActionButton e.g., used by Bartender
    if (LAB and LBG) then -- Prioritize LibButtonGlow, if available
        LAB:RegisterCallback("OnButtonUpdate", LBGButtonUpdateFunc);
    elseif (LAB and LCG) then -- Otherwise fall back to LibCustomGlow
        LAB:RegisterCallback("OnButtonUpdate", LCGButtonUpdateFunc);
    end

    -- Support for ElvUI's LibActionButton
    if (LAB_ElvUI and LCG) then -- Prioritize LibCustomGlow, if available
        LAB_ElvUI:RegisterCallback("OnButtonUpdate", LCGButtonUpdateFunc);
    elseif (LAB_ElvUI and LBG) then -- Otherwise fall back to LibButtonGlow
        LAB_ElvUI:RegisterCallback("OnButtonUpdate", LBGButtonUpdateFunc);
    end

    binder:UnregisterEvent("PLAYER_LOGIN");
end);
