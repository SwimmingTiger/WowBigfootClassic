local AddonName, SAO = ...

local function customLogin(self, ...)
    -- Initialization on PLAYER_LOGIN event because the talent tree may not be available before

    local riposteSpellID = 14251;
    local riposteSpellName = GetSpellInfo(riposteSpellID);

    local _, _, tab, index = self:GetTalentByName(riposteSpellName);
    local talent;
    if (type(tab) == "number" and type(index) == "number") then
        talent = { tab, index };
    end

    self:RegisterCounter("riposte", talent); -- 1st arguement must match 1st argument passed to RegisterAura
end

local function registerClass(self)
    -- Register Riposte as both an aura and a counter
    -- Rogue does not really have a 'Riposte' aura, but it will be used by RegisterCounter in customLogin()

    -- The aura must be registered as soon as possible, because it registers the glowID before parsing action buttons
    -- The counter must be registered as late as possible, because it requires the talent tree, which is not available now
    local riposteSpellID = 14251;
    self:RegisterAura("riposte", 0, riposteSpellID, "bandits_guile", "Top (CW)", 1, 255, 255, 255, true, { riposteSpellID });
end

local function loadOptions(self)
    local riposte = 14251;
    self:AddOverlayOption(riposte, riposte);
    self:AddGlowingOption(nil, riposte, riposte);
end

SAO.Class["ROGUE"] = {
    ["Register"] = registerClass,
    ["LoadOptions"] = loadOptions,
    ["PLAYER_LOGIN"] = customLogin,
}
