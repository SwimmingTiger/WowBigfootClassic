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

SAO.Class["DEATHKNIGHT"] = {
    ["Register"] = registerClass,
}
