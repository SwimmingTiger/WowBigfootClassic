local AddonName, SAO = ...

local function registerClass(self)
    -- Register Riposte as both an aura and a counter
    -- Rogue does not really have a 'Riposte' aura, but it will be used by RegisterCounter
    local riposteSpellID = 14251;
    self:RegisterAura("riposte", 0, riposteSpellID, "bandits_guile", "Top (CW)", 1, 255, 255, 255, true, { riposteSpellID });
    self:RegisterCounter("riposte"); -- Must match name from above call
end

SAO.Class["ROGUE"] = {
    ["Register"] = registerClass,
}
