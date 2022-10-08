local AddonName, SAO = ...

local function registerMolenCore(self, baseName, spellID, glowIDs)
    self:RegisterAura(baseName.."_1", 1, spellID, "molten_core", "Left", 1, 255, 255, 255, true, glowIDs);
    self:RegisterAura(baseName.."_2", 2, spellID, "molten_core", "Left + Right (Flipped)", 1, 255, 255, 255, true, glowIDs);
    self:RegisterAura(baseName.."_3", 3, spellID, "molten_core", "Left + Right (Flipped)", 1, 255, 255, 255, true, glowIDs); -- Same as 2 charges
end

local function registerClass(self)
    local shadowBolt = GetSpellInfo(686);
    local incinerate = GetSpellInfo(29722);
    local soulFire = GetSpellInfo(6353);
    local incinerateAndSoulFire = { incinerate, soulFire };

    -- Backlash
    self:RegisterAura("backlash", 0, 34936, "backlash", "Top", 1, 255, 255, 255, true, { shadowBolt, incinerate });

    -- Empowered Imp
    self:RegisterAura("empowered_imp", 0, 47283, "imp_empowerment", "Left + Right (Flipped)", 1, 255, 255, 255, true);

    -- Molten Core
    registerMolenCore(self, "molten_core_low", 47383, incinerateAndSoulFire); -- 1/3 talent point
    registerMolenCore(self, "molten_core_medium", 71162, incinerateAndSoulFire); -- 2/3 talent points
    registerMolenCore(self, "molten_core_high", 71165, incinerateAndSoulFire); -- 3/3 talent points

    -- Decimation
    self:RegisterAura("decimation_low", 0, 63165, "impact", "Top", 0.8, 255, 255, 255, true, { soulFire }); -- 1/2 talent point
    self:RegisterAura("decimation_high", 0, 63167, "impact", "Top", 0.8, 255, 255, 255, true, { soulFire }); -- 2/2 talent point

    -- Nightfall / Shadow Trance
    self:RegisterAura("nightfall", 0, 17941, "nightfall", "Left + Right (Flipped)", 1, 255, 255, 255, true, { shadowBolt });
end

SAO.Class["WARLOCK"] = {
    ["Register"] = registerClass,
}
