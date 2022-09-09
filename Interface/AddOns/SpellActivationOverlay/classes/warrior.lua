local AddonName, SAO = ...

local function registerClass(self)
    local tasteforBlood = GetSpellInfo(60503); -- Unused as of now, might be used in the future.
    local overpower = GetSpellInfo(7384);
    local execute = GetSpellInfo(5308);
    local revenge = GetSpellInfo(6572);
    local victoryRush = GetSpellInfo(34428);

    self:RegisterAura("bloodsurge", 0, 46916, "blood_surge", "Top", 1, 255, 255, 255, true, { GetSpellInfo(1464) });
    self:RegisterAura("sudden_death", 0, 52437, "sudden_death", "Left + Right (Flipped)", 1, 255, 255, 255, true, { execute });
    self:RegisterAura("sword_and_board", 0, 50227, "sword_and_board", "Left + Right (Flipped)", 1, 255, 255, 255, true, { GetSpellInfo(23922) });

    -- Overpower
    self:RegisterAura("overpower", 0, overpower, nil, "", 0, 0, 0, 0, false, { overpower });
    self:RegisterCounter("overpower"); -- Must match name from above call
	
    -- Execute
    self:RegisterAura("execute", 0, execute, nil, "", 0, 0, 0, 0, false, { execute });
    self:RegisterCounter("execute"); -- Must match name from above call

    -- Revenge
    self:RegisterAura("revenge", 0, revenge, nil, "", 0, 0, 0, 0, false, { revenge });
    self:RegisterCounter("revenge"); -- Must match name from above call

    -- Victory Rush
    self:RegisterAura("victory_rush", 0, victoryRush, nil, "", 0, 0, 0, 0, false, { victoryRush });
    self:RegisterCounter("victory_rush"); -- Must match name from above call
end

SAO.Class["WARRIOR"] = {
    ["Register"] = registerClass,
}
