local AddonName, SAO = ...

local function registerClass(self)
    local icyTouch = GetSpellInfo(45477);
    local frostStrike = GetSpellInfo(49143);
    local howlingBlast = GetSpellInfo(49184);
    self:RegisterAura("rime", 0, 59052, "rime", "Top", 1, 255, 255, 255, true, { howlingBlast });
    self:RegisterAura("killing_machine", 0, 51124, "killing_machine", "Left + Right (Flipped)", 1, 255, 255, 255, true, { icyTouch, frostStrike, howlingBlast });

    local runeStrike = 56815;
    self:RegisterAura("rune_strike", 0, runeStrike, nil, "", 0, 0, 0, 0, false, { runeStrike });
    self:RegisterCounter("rune_strike"); -- Must match name from above call
end

local function loadOptions(self)
    local runeStrike = 56815;
    self:AddGlowingOption(nil, runeStrike, runeStrike);

    local rimeBuff = 59052;
    local rimeTalent = 49188;
    local killingMachineBuff = 51124;
    local killingMachineTalent = 51130;
    local icyTouch = 45477;
    local frostStrike = 49143;
    local howlingBlast = 49184;

    self:AddOverlayOption(rimeTalent, rimeBuff);
    self:AddOverlayOption(killingMachineTalent, killingMachineBuff);

    self:AddGlowingOption(rimeTalent, rimeBuff, howlingBlast);
    self:AddGlowingOption(killingMachineTalent, killingMachineBuff, howlingBlast);
    self:AddGlowingOption(killingMachineTalent, killingMachineBuff, icyTouch);
    self:AddGlowingOption(killingMachineTalent, killingMachineBuff, frostStrike);
end

SAO.Class["DEATHKNIGHT"] = {
    ["Register"] = registerClass,
    ["LoadOptions"] = loadOptions,
}
