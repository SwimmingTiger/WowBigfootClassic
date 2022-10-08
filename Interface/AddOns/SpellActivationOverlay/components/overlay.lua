local AddonName, SAO = ...

-- List of currently active overlays
-- key = spellID, value = aura config
-- This list will change each time an overlay is triggered or un-triggered
SAO.ActiveOverlays = {}

-- Check if overlay is active
function SAO.GetActiveOverlay(self, spellID)
    return self.ActiveOverlays[spellID] ~= nil;
end

-- Add or refresh an overlay
function SAO.ActivateOverlay(self, stacks, spellID, texture, positions, scale, r, g, b, autoPulse, forcePulsePlay)
    if (texture) then
        if (type(forcePulsePlay) == 'table') then -- Hack to avoid glowIDs to be treated as forcePulsePlay
            forcePulsePlay = false;
        end
        self.ActiveOverlays[spellID] = stacks;
        self.ShowAllOverlays(self.Frame, spellID, texture, positions, scale, r, g, b, autoPulse, forcePulsePlay);
    end
end

-- Remove an overlay
function SAO.DeactivateOverlay(self, spellID)
    self.ActiveOverlays[spellID] = nil;
    self.HideOverlays(self.Frame, spellID);
end
