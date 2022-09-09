local AddonName, SAO = ...

-- List of spell names or IDs of actions that can trigger as 'counter'
-- key = spellName / spellID, value = auraID
SAO.ActivableCountersByName = {};
SAO.ActivableCountersBySpellID = {};

-- List of spell IDs currently
-- key = spellID, value = true
SAO.ActivatedCounters = {};

-- List of timer objects for checking cooldown of activated counters
-- key = spellID, value = timer object
SAO.CounterRetryTimers = {};

-- Track an action that becomes usable by itself, without knowing it with an aura
-- If the action is triggered by an aura, it will already activate during buff
-- The spellID is taken from the aura's table
-- @param auraID name of the aura registered to SAO.RegisterAura
function SAO.RegisterCounter(self, auraID)
    local aura = self.RegisteredAurasByName[auraID];
    if (not aura) then
        return;
    end

    local glowIDs = select(11,unpack(aura));
    for _, glowID in ipairs(glowIDs or {}) do
        if (type(glowID) == "number") then
            self.ActivableCountersBySpellID[glowID] = auraID;
        elseif (type(glowID) == "string") then
            self.ActivableCountersByName[glowID] = auraID;
            local glowSpellIDs = self:GetSpellIDsByName(glowID);
            for _, glowSpellID in ipairs(glowSpellIDs) do
                self.ActivableCountersBySpellID[glowSpellID] = auraID;
            end
        end
    end
end

-- Check if an action counter became either activated or deactivated
function SAO.CheckCounterAction(self, spellID, auraID)
    local start, duration, enabled, modRate = GetSpellCooldown(spellID);
    if (type(start) ~= "number") then
        -- Spell not available
        return;
    end

    local aura = self.RegisteredAurasByName[auraID];
    if (not aura) then
        -- Unknown aura. Should never happen.
        return;
    end

    local isCounterUsable = IsUsableSpell(spellID);
    local counterMustBeActivated = isCounterUsable and start == 0;

    if (not self.ActivatedCounters[spellID] and counterMustBeActivated) then
        -- Counter triggered but not shown yet: just do it!
        self.ActivatedCounters[spellID] = true;
        self:ActivateOverlay(select(2, unpack(aura)));
        self:AddGlow(spellID, {spellID}); -- Same spell ID, because there is no 'aura'
    elseif (self.ActivatedCounters[spellID] and not counterMustBeActivated) then
        -- Counter not triggered but still shown: hide it
        self.ActivatedCounters[spellID] = nil;
        self:DeactivateOverlay(spellID);
        self:RemoveGlow(spellID);
    end

    if (isCounterUsable and start > 0) then
        -- Counter could be usable, but CD prevents us to: try again in a few seconds
        local endTime = start+duration;

        if (not self.CounterRetryTimers[spellID] or self.CounterRetryTimers[spellID].endTime ~= endTime) then
            if (self.CounterRetryTimers[spellID]) then
                self.CounterRetryTimers[spellID]:Cancel();
            end

            local remainingTime = endTime-GetTime();
            local delta = 0.05; -- Add a small delay to account for lags and whatnot
            local retryFunc = function() self:CheckCounterAction(spellID, auraID); end;
            self.CounterRetryTimers[spellID] = C_Timer.NewTimer(remainingTime+delta, retryFunc);
            self.CounterRetryTimers[spellID].endTime = endTime;
        end
    end
end

function SAO.CheckAllCounterActions(self)
    for spellID, auraID in pairs(self.ActivableCountersBySpellID) do
        self:CheckCounterAction(spellID, auraID);
    end
end
