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

    -- Lock and Load: display something on top if there is at least one charge
    self:RegisterAura("lock_and_load_1", 1, 56453, "lock_and_load", "Top", 1, 255, 255, 255, true, lalGlowNames);
    self:RegisterAura("lock_and_load_2", 2, 56453, "lock_and_load", "Top", 1, 255, 255, 255, true, lalGlowNames);

    -- Counterattack, registered as both aura and counter, but only used as counter
    self:RegisterAura("counterattack", 0, counterattack, nil, "", 0, 0, 0, 0, false, { (GetSpellInfo(counterattack)) });
    self:RegisterCounter("counterattack"); -- Must match name from above call

    -- Kill Shot, Execute-like ability for targets at 20% hp or less
    self:RegisterAura("kill_shot", 0, killShot, nil, "", 0, 0, 0, 0, false, { (GetSpellInfo(killShot)) });
    self:RegisterCounter("kill_shot");
end

local function loadOptions(self)
    local killShot = 53351;
    local counterattack = 19306;
    local aimedShot = 19434;
    local arcaneShot = 3044;
    local chimeraShot = 53209;
    local explosiveShot = 53301;

    local improvedSteadyShotBuff = 53220;
    local improvedSteadyShotTalent = 53221;

    local lockAndLoadBuff = 56453;
    local lockAndLoadTalent = 56342;

    self:AddOverlayOption(improvedSteadyShotTalent, improvedSteadyShotBuff);
    self:AddOverlayOption(lockAndLoadTalent, lockAndLoadBuff, 0, nil, nil, 2); -- setup any stacks, test with 2 stacks

    self:AddGlowingOption(nil, killShot, killShot);
    self:AddGlowingOption(nil, counterattack, counterattack);
    self:AddGlowingOption(improvedSteadyShotTalent, improvedSteadyShotBuff, aimedShot);
    self:AddGlowingOption(improvedSteadyShotTalent, improvedSteadyShotBuff, arcaneShot);
    self:AddGlowingOption(improvedSteadyShotTalent, improvedSteadyShotBuff, chimeraShot);
    self:AddGlowingOption(lockAndLoadTalent, lockAndLoadBuff, arcaneShot);
    self:AddGlowingOption(lockAndLoadTalent, lockAndLoadBuff, explosiveShot);
end

SAO.Class["HUNTER"] = {
    ["Register"] = registerClass,
    ["LoadOptions"] = loadOptions,
}
