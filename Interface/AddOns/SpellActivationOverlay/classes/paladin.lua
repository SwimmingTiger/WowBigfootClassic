local AddonName, SAO = ...

local function registerClass(self)
    local flashOfLight = GetSpellInfo(19750);
    local exorcism = GetSpellInfo(879);
    local holyLight = GetSpellInfo(635);

    local how = 24275;

    local infusionOfLightBuff1 = 53672;
    local infusionOfLightBuff2 = 54149;
    local artOfWarBuff1 = 53489;
    local artOfWarBuff2 = 59578;

    -- Add option links during registerClass(), not because loadOptions() which would be loaded only when the options panel is opened
    -- Add option links before RegisterAura() calls, so that options they are used by initial triggers, if any
    self:AddOverlayLink(infusionOfLightBuff2, infusionOfLightBuff1);
    self:AddOverlayLink(artOfWarBuff2, artOfWarBuff1);
    self:AddGlowingLink(infusionOfLightBuff2, infusionOfLightBuff1);
    self:AddGlowingLink(artOfWarBuff2, artOfWarBuff1);

    -- Hammer of Wrath, Execute-like ability for targets at 20% hp or less
    self:RegisterAura("how", 0, how, nil, "", 0, 0, 0, 0, false, { GetSpellInfo(how) });
    self:RegisterCounter("how");

    -- Art of War, 1/2 talent points
    self:RegisterAura("art_of_war_low", 0, artOfWarBuff1, "art_of_war", "Left + Right (Flipped)", 0.6, 255, 255, 255, false, { flashOfLight, exorcism }); -- Smaller, does not pulse

    -- Art of War, 2/2 talent points
    self:RegisterAura("art_of_war_high", 0, artOfWarBuff2, "art_of_war", "Left + Right (Flipped)", 1, 255, 255, 255, true, { flashOfLight, exorcism });

    -- Infusion of Light, 1/2 talent points
    self:RegisterAura("infusion_of_light_low", 0, infusionOfLightBuff1, "daybreak", "Left + Right (Flipped)", 1, 255, 255, 255, true, { flashOfLight, holyLight });

    -- Infusion of Light, 2/2 talent points
    self:RegisterAura("infusion_of_light_high", 0, infusionOfLightBuff2, "daybreak", "Left + Right (Flipped)", 1, 255, 255, 255, true, { flashOfLight, holyLight });
end

local function loadOptions(self)
    local how = 24275;
    local flashOfLight = 19750;
    local exorcism = 879;
    local holyLight = 635;

--    local infusionOfLightBuff1 = 53672;
    local infusionOfLightBuff2 = 54149;
    local infusionOfLightTalent = 53569;

--    local artOfWarBuff1 = 53489;
    local artOfWarBuff2 = 59578;
    local artOfWarTalent = 53486;

    self:AddOverlayOption(infusionOfLightTalent, infusionOfLightBuff2);
    self:AddOverlayOption(artOfWarTalent, artOfWarBuff2);

    self:AddGlowingOption(nil, how, how);
    self:AddGlowingOption(infusionOfLightTalent, infusionOfLightBuff2, flashOfLight);
    self:AddGlowingOption(infusionOfLightTalent, infusionOfLightBuff2, holyLight);
    self:AddGlowingOption(artOfWarTalent, artOfWarBuff2, exorcism);
    self:AddGlowingOption(artOfWarTalent, artOfWarBuff2, flashOfLight);
end

SAO.Class["PALADIN"] = {
    ["Register"] = registerClass,
    ["LoadOptions"] = loadOptions,
}
