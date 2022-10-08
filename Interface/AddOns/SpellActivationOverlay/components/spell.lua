local AddonName, SAO = ...

-- List of spell IDs sharing the same name
-- key = spell name, value = list of spell IDs
-- The list is a cache of calls to GetSpellIDsByName
-- The list will evolve automatically when the player learns new spells
SAO.SpellIDsByName = {}

-- Returns the list of spell IDs for a given name
-- Returns an empty list {} if the spell is not found in the spellbook
function SAO.GetSpellIDsByName(self, name)
    local cached = self.SpellIDsByName[name];
    if (cached) then
        return cached;
    end

    self:RefreshSpellIDsByName(name);
    return self.SpellIDsByName[name];
end

-- Force refresh the list of spell IDs for a given name by looking at the spellbook
-- The cache is updated in the process
-- If awaken is true, spellIDs are also added to RegisteredGlowSpellIDs
function SAO.RefreshSpellIDsByName(self, name, awaken)
    local homonyms = self:GetHomonymSpellIDs(name);
    self.SpellIDsByName[name] = homonyms;

    -- Awake dormant buttons associated to these spellIDs
    if (awaken) then
        local counter = self.ActivableCountersByName[name];

        for _, spellID in ipairs(homonyms) do
            -- Glowing Action Buttons (GABs)
            if (not self.RegisteredGlowSpellIDs[spellID]) then
                self.RegisteredGlowSpellIDs[spellID] = true;
                self:AwakeButtonsBySpellID(spellID);
            end

            -- Counters
            if (counter and not self.ActivableCountersBySpellID[spellID]) then
                self.ActivableCountersBySpellID[spellID] = counter;
                self:CheckCounterAction(spellID, unpack(counter));
            end
        end
    end
end

-- Update the spell cache when a new spell is learned
function SAO.LearnNewSpell(self, spellID)
    local name = GetSpellInfo(spellID);
    if (not name) then
        return;
    end

    local cached = self.SpellIDsByName[name];
    if (not cached) then
        -- Not interested in untracked spells
        return;
    end

    for _, id in ipairs(cached) do
        if (id == spellID) then
            -- Spell ID already cached
            return
        end
    end

    -- At this point, the spell ID is not cached yet, just do it!
    table.insert(self.SpellIDsByName[name], spellID);

    -- Also update RegisteredGlowSpellIDs if the name the tracked
    if (self.RegisteredGlowSpellNames[name]) then
        self.RegisteredGlowSpellIDs[spellID] = true;

        -- Awaken dormant buttons associated to this spellID
        self:AwakeButtonsBySpellID(spellID);
    end

    -- Also update ActivableCountersBySpellID if the name the tracked
    local counter = self.ActivableCountersByName[name];
    if (counter and not self.ActivableCountersBySpellID[spellID]) then
        self.ActivableCountersBySpellID[spellID] = counter;

        -- Try to see if action is usable now
        self:CheckCounterAction(spellID, unpack(counter));
    end
end
