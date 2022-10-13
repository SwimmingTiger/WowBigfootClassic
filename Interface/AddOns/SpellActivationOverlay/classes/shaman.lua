local AddonName, SAO = ...

local function registerClass(self)
    -- Elemental Focus
    self:RegisterAura("elemental_focus_1", 1, 16246, "echo_of_the_elements", "Left", 1, 255, 255, 255, true);
    self:RegisterAura("elemental_focus_2", 2, 16246, "echo_of_the_elements", "Left + Right (Flipped)", 1, 255, 255, 255, true);

    -- Maelstrom Weapon
    local lightningBolt = 403;
    local chainLightning = 421;
    local lesserHealingWave = 8004;
    local healingWave = 331;
    local chainHeal = 1064;
    local hex = 51514;
    local maelstromSpells = {
        GetSpellInfo(lightningBolt),
        GetSpellInfo(chainLightning),
        GetSpellInfo(lesserHealingWave),
        GetSpellInfo(healingWave),
        GetSpellInfo(chainHeal),
        GetSpellInfo(hex),
    }
    self:RegisterAura("maelstrom_weapon_1", 1, 53817, "maelstrom_weapon_1", "Top", 1, 255, 255, 255, false);
    self:RegisterAura("maelstrom_weapon_2", 2, 53817, "maelstrom_weapon_2", "Top", 1, 255, 255, 255, false);
    self:RegisterAura("maelstrom_weapon_3", 3, 53817, "maelstrom_weapon_3", "Top", 1, 255, 255, 255, false);
    self:RegisterAura("maelstrom_weapon_4", 4, 53817, "maelstrom_weapon_4", "Top", 1, 255, 255, 255, false);
    self:RegisterAura("maelstrom_weapon_5", 5, 53817, "maelstrom_weapon", "Top", 1, 255, 255, 255, true, maelstromSpells);
end

local function loadOptions(self)
    local lightningBolt = 403;
    local chainLightning = 421;
    local lesserHealingWave = 8004;
    local healingWave = 331;
    local chainHeal = 1064;
    local hex = 51514;

    local maelstromWeaponBuff = 53817;
    local maelstromWeaponTalent = 51528;

    local elementalFocusBuff = 16246;
    local elementalFocusTalent = 16164;

    local oneToFourStacks = string.format(CALENDAR_TOOLTIP_DATE_RANGE, "1", string.format(STACKS, 4));
    local fiveStacks = string.format(STACKS, 5);

    self:AddOverlayOption(elementalFocusTalent, elementalFocusBuff);
    self:AddOverlayOption(maelstromWeaponTalent, maelstromWeaponBuff, 0, oneToFourStacks);
    self:AddOverlayOption(maelstromWeaponTalent, maelstromWeaponBuff, 5);

    self:AddGlowingOption(maelstromWeaponTalent, maelstromWeaponBuff, lightningBolt, fiveStacks);
    self:AddGlowingOption(maelstromWeaponTalent, maelstromWeaponBuff, chainLightning, fiveStacks);
    self:AddGlowingOption(maelstromWeaponTalent, maelstromWeaponBuff, lesserHealingWave, fiveStacks);
    self:AddGlowingOption(maelstromWeaponTalent, maelstromWeaponBuff, healingWave, fiveStacks);
    self:AddGlowingOption(maelstromWeaponTalent, maelstromWeaponBuff, chainHeal, fiveStacks);
    self:AddGlowingOption(maelstromWeaponTalent, maelstromWeaponBuff, hex, fiveStacks);
end

SAO.Class["SHAMAN"] = {
    ["Register"] = registerClass,
    ["LoadOptions"] = loadOptions,
}
