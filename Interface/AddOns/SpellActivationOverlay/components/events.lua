local AddonName, SAO = ...

-- Events starting with SPELL_AURA e.g., SPELL_AURA_APPLIED
-- This should be invoked only if the buff is done on the player i.e., UnitGUID("player") == destGUID
function SAO.SPELL_AURA(self, ...)
    local timestamp, event, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = CombatLogGetCurrentEventInfo();
    local spellID, spellName, spellSchool, auraType, amount = select(12, CombatLogGetCurrentEventInfo());
    local auraApplied = event:sub(0,18) == "SPELL_AURA_APPLIED";
    local auraRemoved = event:sub(0,18) == "SPELL_AURA_REMOVED";

    local auras = self.RegisteredAurasBySpellID[spellID];
    if auras and (auraApplied or auraRemoved) then
        local count = 0;
        if (not auras[0]) then
            -- If there is no aura with stacks == 0, this must mean that this aura is stackable
            -- To handle stackable auras, we must find the aura (ugh!) to get its number of stacks
            -- In an ideal world, we'd use the 'amount' which, unfortunately, is unreliable
            count = select(3, self:FindPlayerAuraByID(spellID));
        end

        local currentlyActiveOverlay = self:GetActiveOverlay(spellID);
        if (
            -- Aura not visible yet
            (not currentlyActiveOverlay)
        and
            -- Aura is there, either because it was added or upgraded or downgraded but still visible
            (auraApplied or (auraRemoved and count and count > 0))
        and
            -- The number of stacks is supported
            (auras[count])
        ) then
            -- Activate aura
            for _, aura in ipairs(auras[count]) do
                self:ActivateOverlay(count, select(3,unpack(aura)));
                self:AddGlow(spellID, select(11,unpack(aura)));
            end
        elseif (
            -- Aura is already visible but its number of stack changed
            (currentlyActiveOverlay and currentlyActiveOverlay ~= count)
        and
            -- The new stack count allows it to be visible
            (count and count > 0)
        and
            -- The number of stacks is supported
            (auras[count])
        ) then
            -- Deactivate old aura and activate the new one
            self:DeactivateOverlay(spellID);
            self:RemoveGlow(spellID);
            for _, aura in ipairs(auras[count]) do
                local texture, positions, scale, r, g, b, autoPulse = select(4,unpack(aura));
                local forcePulsePlay = autoPulse;
                self:ActivateOverlay(count, spellID, texture, positions, scale, r, g, b, autoPulse, forcePulsePlay);
                self:AddGlow(spellID, select(11,unpack(aura)));
            end
        elseif (
            -- Aura is already visible and its number of stacks changed
            (currentlyActiveOverlay and currentlyActiveOverlay ~= count)
        and
            ((count and count > 0) or auraRemoved)
            -- If condition end up here, it means the previous 'if' was false
            -- Which means either there is no stacks, or the number of stacks is not supported
        ) then
            -- Aura just disappeared or is not supported for this number of stacks
            self:DeactivateOverlay(spellID);
            self:RemoveGlow(spellID);
        end
    end
end

-- The (in)famous CLEU event
function SAO.COMBAT_LOG_EVENT_UNFILTERED(self, ...)
    local _, event, _, _, _, _, _, destGUID = CombatLogGetCurrentEventInfo();

    if ( (event:sub(0,11) == "SPELL_AURA_") and (destGUID == UnitGUID("player")) ) then
        self:SPELL_AURA(...);
    end
end

-- Check if auras are still there after a loading screen
-- This circumvents a limitation of the CLEU which may not trigger during a loading screen
function SAO.LOADING_SCREEN_DISABLED(self, ...)
    for spellID, stacks in pairs(self.ActiveOverlays) do
        if (not self:FindPlayerAuraByID(spellID)) then
            self:DeactivateOverlay(spellID);
            self:RemoveGlow(spellID);
        end
    end
end

function SAO.SPELL_UPDATE_USABLE(self, ...)
    self:CheckAllCounterActions();
end

-- Specific spellbook update
function SAO.SPELLS_CHANGED(self, ...)
    for glowID, _ in pairs(self.RegisteredGlowSpellNames) do
        self:RefreshSpellIDsByName(glowID, true);
    end
end

-- Specific spell learned
function SAO.LEARNED_SPELL_IN_TAB(self, ...)
    local spellID, skillInfoIndex, isGuildPerkSpell = ...;
    self:LearnNewSpell(spellID);
end

-- Event receiver
function SAO.OnEvent(self, event, ...)
    if self[event] then
        self[event](self, ...);
    end
    self:InvokeClassEvent(event, ...)
end
