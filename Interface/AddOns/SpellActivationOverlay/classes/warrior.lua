local AddonName, SAO = ...

local function registerClass(self)
    local tasteforBlood = 60503; -- Unused as of now, might be used in the future.
    local overpower = 7384;
    local execute = 5308;
    local revenge = 6572;
    local victoryRush = 34428;
    local slam = 1464;
    local shieldSlam = 23922;

    self:RegisterAura("bloodsurge", 0, 46916, "blood_surge", "Top", 1, 255, 255, 255, true, { GetSpellInfo(slam) });
    self:RegisterAura("sudden_death", 0, 52437, "sudden_death", "Left + Right (Flipped)", 1, 255, 255, 255, true, { GetSpellInfo(execute) });
    self:RegisterAura("sword_and_board", 0, 50227, "sword_and_board", "Left + Right (Flipped)", 1, 255, 255, 255, true, { GetSpellInfo(shieldSlam) });

    -- Overpower
    self:RegisterAura("overpower", 0, overpower, nil, "", 0, 0, 0, 0, false, { GetSpellInfo(overpower) });
    self:RegisterCounter("overpower"); -- Must match name from above call

    -- Execute
    self:RegisterAura("execute", 0, execute, nil, "", 0, 0, 0, 0, false, { GetSpellInfo(execute) });
    self:RegisterCounter("execute"); -- Must match name from above call

    -- Revenge
    self:RegisterAura("revenge", 0, revenge, nil, "", 0, 0, 0, 0, false, { GetSpellInfo(revenge) });
    self:RegisterCounter("revenge"); -- Must match name from above call

    -- Victory Rush
    self:RegisterAura("victory_rush", 0, victoryRush, nil, "", 0, 0, 0, 0, false, { GetSpellInfo(victoryRush) });
    self:RegisterCounter("victory_rush"); -- Must match name from above call
end

local function loadOptions(self)
    local overpower = 7384;
    local execute = 5308;
    local revenge = 6572;
    local victoryRush = 34428;
    local slam = 1464;
    local shieldSlam = 23922;

    local bloodsurgeBuff = 46916;
    local bloodsurgeTalent = 46913;

    local suddenDeathBuff = 52437;
    local suddenDeathTalent = 29723;

    local swordAndBoardBuff = 50227;
    local swordAndBoardTalent = 46951;

    self:AddOverlayOption(suddenDeathTalent, suddenDeathBuff);
    self:AddOverlayOption(bloodsurgeTalent, bloodsurgeBuff);
    self:AddOverlayOption(swordAndBoardTalent, swordAndBoardBuff);

    self:AddGlowingOption(nil, overpower, overpower);
    self:AddGlowingOption(nil, revenge, revenge);
    self:AddGlowingOption(nil, victoryRush, victoryRush);
    self:AddGlowingOption(nil, execute, execute);
    self:AddGlowingOption(suddenDeathTalent, suddenDeathBuff, execute);
    self:AddGlowingOption(bloodsurgeTalent, bloodsurgeBuff, slam);
    self:AddGlowingOption(swordAndBoardTalent, swordAndBoardBuff, shieldSlam);
end

SAO.Class["WARRIOR"] = {
    ["Register"] = registerClass,
    ["LoadOptions"] = loadOptions,
}
