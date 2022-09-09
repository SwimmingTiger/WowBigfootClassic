local AddonName, SAO = ...

local function registerClass(self)
    local aimedShot = 19434;
    local arcaneShot = 3044;
    local killShot  = 53351;
    local chimeraShot = 53209;
    local explosiveShot = 53301;
    local counterattack = 19306;

    local issGlowNames = { (GetSpellInfo(aimedShot)), (GetSpellInfo(arcaneShot)), (GetSpellInfo(chimeraShot)) };
    local lalGlowNames = { (GetSpellInfo(arcaneShot)), (GetSpellInfo(explosiveShot)) };

    -- Improved Steady Shot, formerly Master Marksman
    self:RegisterAura("improved_steady_shot", 0, 53220, "master_marksman", "Top", 1, 255, 255, 255, true, issGlowNames);

    -- Lock and Load, option 1: display something on top if there is at least one charge
    -- Advantage: easier to see
    -- Disadvantages: doesn't show the number of charges, may conflict with Improved Steady Shot
    self:RegisterAura("lock_and_load_1", 1, 56453, "lock_and_load", "Top", 1, 255, 255, 255, true, lalGlowNames);
    self:RegisterAura("lock_and_load_2", 2, 56453, "lock_and_load", "Top", 1, 255, 255, 255, true, lalGlowNames);

    -- Lock and Load, option 2: display the first charge on top-left and second charge on top-right
    -- Advantages: displays two charges, doesn't conflict with Improved Steady Shot
    -- Disadvantage: weird place to put them (smaller, away from the center)
    -- self:RegisterAura("lock_and_load", 1, 56453, "lock_and_load", "TopLeft", 1, 255, 255, 255, true, lalGlowNames);
    -- self:RegisterAura("lock_and_load_2left", 2, 56453, "lock_and_load", "TopLeft", 1, 255, 255, 255, true, lalGlowNames);
    -- self:RegisterAura("lock_and_load_2right", 2, 56453, "lock_and_load", "TopRight", 1, 255, 255, 255, true, lalGlowNames);

    -- Counterattack, registered as both aura and counter, but only used as counter
    self:RegisterAura("counterattack", 0, counterattack, nil, "", 0, 0, 0, 0, false, { (GetSpellInfo(counterattack)) });
    self:RegisterCounter("counterattack"); -- Must match name from above call

    -- Kill Shot, Execute-like ability for targets at 20% hp or less
    self:RegisterAura("kill_shot", 0, killShot, nil, "", 0, 0, 0, 0, false, { (GetSpellInfo(killShot)) });
    self:RegisterCounter("kill_shot");
end

SAO.Class["HUNTER"] = {
    ["Register"] = registerClass,
}
