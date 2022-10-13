local AddonName, SAO = ...

-- List of spell names or IDs of actions that can trigger as 'counter'
-- key = spellName / spellID, value = { auraID, talent }
SAO.ActivableCountersByName = {};
SAO.ActivableCountersBySpellID = {};

-- List of spell IDs currently activated
-- key = spellID, value = true
SAO.ActivatedCounters = {};

-- List of timer objects for checking cooldown of activated counters
-- key = spellID, value = timer object
SAO.CounterRetryTimers = {};

-- Track an action that becomes usable by itself, without knowing it with an aura
-- If the action is triggered by an aura, it will already activate during buff
-- The spellID is taken from the aura's table
-- @param auraID name of the aura registered to SAO.RegisterAura
-- @param talent talent object { tab, index } to check when counter triggers; may be nil
function SAO.RegisterCounter(self, auraID, talent)
    local aura = self.RegisteredAurasByName[auraID];
    if (not aura) then
        return;
    end

    local counter = { auraID, talent };

    local glowIDs = select(11,unpack(aura));
    for _, glowID in ipairs(glowIDs or {}) do
        if (type(glowID) == "number") then
            self.ActivableCountersBySpellID[glowID] = counter;
        elseif (type(glowID) == "string") then
            self.ActivableCountersByName[glowID] = counter;
            local glowSpellIDs = self:GetSpellIDsByName(glowID);
            for _, glowSpellID in ipairs(glowSpellIDs) do
                self.ActivableCountersBySpellID[glowSpellID] = counter;
            end
        end
    end
end

-- Check if an action counter became either activated or deactivated
function SAO.CheckCounterAction(self, spellID, auraID, talent)
    if (talent) then
        local rank = select(5, GetTalentInfo(talent[1], talent[2]));
        if (not (rank > 0)) then
            -- 0 points spent in the required Talent
            return;
        end
    end

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
    local auraSpellID = aura[3];

    local isCounterUsable, notEnoughPower = IsUsableSpell(spellID);

    local _, gcdDuration, _, _ = GetSpellCooldown(61304); -- GCD SpellID
    local isGCD = duration <= gcdDuration; -- We check against gcdDuration because it's not always 1.5s
    local isCounterOnCD = start > 0 and not isGCD;

    -- Non-mana spells should always glow, regardless of player's current resources.
    local costsMana = false
    for _, spellCost in ipairs(GetSpellPowerCost(spellID) or {}) do
        if spellCost.name == "MANA" then
            costsMana = true;
            break;
        end
    end

    local counterMustBeActivated = not isCounterOnCD and (isCounterUsable or (notEnoughPower and not costsMana));

    if (not self.ActivatedCounters[spellID] and counterMustBeActivated) then
        -- Counter triggered but not shown yet: just do it!
        self.ActivatedCounters[spellID] = true;
        self:ActivateOverlay(select(2, unpack(aura)));
        self:AddGlow(auraSpellID, {spellID});
    elseif (self.ActivatedCounters[spellID] and not counterMustBeActivated) then
        -- Counter not triggered but still shown: hide it
        self.ActivatedCounters[spellID] = nil;
        self:DeactivateOverlay(auraSpellID);
        self:RemoveGlow(auraSpellID);
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
            local retryFunc = function() self:CheckCounterAction(spellID, auraID, talent); end;
            self.CounterRetryTimers[spellID] = C_Timer.NewTimer(remainingTime+delta, retryFunc);
            self.CounterRetryTimers[spellID].endTime = endTime;
        end
    end
end

function SAO.CheckAllCounterActions(self)
    for spellID, counter in pairs(self.ActivableCountersBySpellID) do
        self:CheckCounterAction(spellID, unpack(counter));
    end
end
