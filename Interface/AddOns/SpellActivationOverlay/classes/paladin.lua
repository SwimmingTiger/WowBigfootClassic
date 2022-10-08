local AddonName, SAO = ...

local function registerClass(self)
    local flashOfLight = GetSpellInfo(19750);
    local exorcism = GetSpellInfo(879);
    local holyLight = GetSpellInfo(635);
    local how = GetSpellInfo(24275);

    -- Hammer of Wrath, Execute-like ability for targets at 20% hp or less
    self:RegisterAura("how", 0, how, nil, "", 0, 0, 0, 0, false, { how });
    self:RegisterCounter("how");

    -- Art of War
    self:RegisterAura("art_of_war", 0, 59578, "art_of_war", "Left + Right (Flipped)", 1, 255, 255, 255, true, { flashOfLight, exorcism });
    self:RegisterAura("art_of_war_mini", 0, 53489, "art_of_war", "Left + Right (Flipped)", 0.6, 255, 255, 255, false, { flashOfLight, exorcism }); -- 1 point out of 2, displayed smaller, does not pulse

    -- Infusion of Light, 1/2 talent points
    self:RegisterAura("infusion_of_light_low", 0, 53672, "daybreak", "Left + Right (Flipped)", 1, 255, 255, 255, true, { flashOfLight, holyLight });

    -- Infusion of Light, 2/2 talent points
    self:RegisterAura("infusion_of_light_high", 0, 54149, "daybreak", "Left + Right (Flipped)", 1, 255, 255, 255, true, { flashOfLight, holyLight });
end

SAO.Class["PALADIN"] = {
    ["Register"] = registerClass,
}
