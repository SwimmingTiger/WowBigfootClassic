local AddonName, SAO = ...

local function registerClass(self)
    -- Elemental Focus
    self:RegisterAura("elemental_focus_1", 1, 16246, "echo_of_the_elements", "Left", 1, 255, 255, 255, true);
    self:RegisterAura("elemental_focus_2", 2, 16246, "echo_of_the_elements", "Left + Right (Flipped)", 1, 255, 255, 255, true);

    -- Maelstrom Weapon
    self:RegisterAura("maelstrom_weapon_1", 1, 53817, "maelstrom_weapon_1", "Top", 1, 255, 255, 255, false);
    self:RegisterAura("maelstrom_weapon_2", 2, 53817, "maelstrom_weapon_2", "Top", 1, 255, 255, 255, false);
    self:RegisterAura("maelstrom_weapon_3", 3, 53817, "maelstrom_weapon_3", "Top", 1, 255, 255, 255, false);
    self:RegisterAura("maelstrom_weapon_4", 4, 53817, "maelstrom_weapon_4", "Top", 1, 255, 255, 255, false);
    self:RegisterAura("maelstrom_weapon_5", 5, 53817, "maelstrom_weapon", "Top", 1, 255, 255, 255, true);
end

SAO.Class["SHAMAN"] = {
    ["Register"] = registerClass,
}
