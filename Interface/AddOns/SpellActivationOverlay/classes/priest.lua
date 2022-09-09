local AddonName, SAO = ...

local function registerClass(self)
    local smite = GetSpellInfo(585);
    local flashHeal = GetSpellInfo(2061);
    self:RegisterAura("surge_of_light", 0, 33151, "surge_of_light", "Left + Right (Flipped)", 1, 255, 255, 255, true, { smite, flashHeal });

    local ghAndPoh = { (GetSpellInfo(2060)), (GetSpellInfo(596)) }

    -- Serendipity with 1 talent point out of 3
--    self:RegisterAura("serendipity_low_1", 1, 63731, "serendipity", "Top", 0.25, 255, 255, 255, true, ghAndPoh);
--    self:RegisterAura("serendipity_low_2", 2, 63731, "serendipity", "Top", 0.5, 255, 255, 255, true, ghAndPoh);
    self:RegisterAura("serendipity_low_3", 3, 63731, "serendipity", "Top", 1, 255, 255, 255, true, ghAndPoh);

    -- Serendipity with 2 talent points out of 3
--    self:RegisterAura("serendipity_medium_1", 1, 63735, "serendipity", "Top", 0.25, 255, 255, 255, true, ghAndPoh);
--    self:RegisterAura("serendipity_medium_2", 2, 63735, "serendipity", "Top", 0.5, 255, 255, 255, true, ghAndPoh);
    self:RegisterAura("serendipity_medium_3", 3, 63735, "serendipity", "Top", 1, 255, 255, 255, true, ghAndPoh);

    -- Serendipity with 3 talent points out of 3
--    self:RegisterAura("serendipity_high_1", 1, 63734, "serendipity", "Top", 0.25, 255, 255, 255, true, ghAndPoh);
--    self:RegisterAura("serendipity_high_2", 2, 63734, "serendipity", "Top", 0.5, 255, 255, 255, true, ghAndPoh);
    self:RegisterAura("serendipity_high_3", 3, 63734, "serendipity", "Top", 1, 255, 255, 255, true, ghAndPoh);
end

SAO.Class["PRIEST"] = {
    ["Register"] = registerClass,
}
