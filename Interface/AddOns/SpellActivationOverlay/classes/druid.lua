local AddonName, SAO = ...

local omenSpellID = 16870;
local lunarSpellID = 48518;
local solarSpellID = 48517;

local feralCache = false;
local clarityCache = false;
local lunarCache = false;
local solarCache = false;

local leftTexture = '';
local rightTexture = '';

local glowingWrath = false;
local glowingStarfire = false;

-- Assign fake spell IDs for left and right textures, and make sure they are different
-- If we used the 'real' spell IDs instead of fake IDs, we would see weird transitions
-- If spell IDs were identical, hiding the left or right SAO could also hide the other
-- (the latter is a limitation, some would say a feature, of Blizzard's original code)
local leftFakeSpellID  = 0xD001D001;
local rightFakeSpellID = 0xD001D002;

local function isFeral(self)
    local shapeshift = GetShapeshiftForm()
    return (shapeshift == 1) or (shapeshift == 3);
end

local function hasClarity(self)
    return self:FindPlayerAuraByID(omenSpellID) ~= nil;
end

local function hasLunar(self)
    return self:FindPlayerAuraByID(lunarSpellID) ~= nil;
end

local function hasSolar(self)
    return self:FindPlayerAuraByID(solarSpellID) ~= nil;
end

local function updateOneSAO(self, position, spellID, texture)
    if (texture == "") then
        self:DeactivateOverlay(spellID);
    else
        self:ActivateOverlay(0, spellID, self.TexName[texture], position, 1, 255, 255, 255, true);
    end
end

local function updateLeftSAO(self, texture)
    if (leftTexture ~= texture) then
        leftTexture = texture;
        updateOneSAO(self, "Left", leftFakeSpellID, texture);
    end
end

local function updateRightSAO(self, texture)
    if (rightTexture ~= texture) then
        rightTexture = texture;
        updateOneSAO(self, "Right (Flipped)", rightFakeSpellID, texture);
    end
end

local function updateSAOs(self)
    local omenTexture = feralCache and "feral_omenofclarity" or "natures_grace";
    local lunarTexture = "eclipse_moon";
    local solarTexture = "eclipse_sun";

    local omenOptions = self:GetOverlayOptions(omenSpellID);
    local lunarOptions = self:GetOverlayOptions(lunarSpellID);
    local solarOptions = self:GetOverlayOptions(solarSpellID);

    local mayActivateOmen = clarityCache and (not omenOptions or type(omenOptions[0]) == "nil" or omenOptions[0]);
    local mustActivateLunar = lunarCache and (not lunarOptions or type(lunarOptions[0]) == "nil" or lunarOptions[0]);
    local mustActivateSolar = solarCache and (not solarOptions or type(solarOptions[0]) == "nil" or solarOptions[0]);

    if (mustActivateLunar) then
        -- Lunar Eclipse
        updateLeftSAO (self, lunarTexture); -- Left is always Lunar Eclipse
        updateRightSAO(self, mayActivateOmen and omenTexture or ''); -- Right is either Omen or nothing
    elseif (mustActivateSolar) then
        -- Solar Eclipse
        updateLeftSAO (self, mayActivateOmen and omenTexture or ''); -- Left is either Omen or nothing
        updateRightSAO(self, solarTexture); -- Right is always Solar Eclipse
    else
        -- No Eclipse: either both SAOs are Omen of Clarity, or both are nothing
        if (mayActivateOmen) then
            updateLeftSAO (self, omenTexture);
            updateRightSAO(self, omenTexture);
        else
            updateLeftSAO (self, '');
            updateRightSAO(self, '');
        end
    end
end

local function updateGABs(self)
    if (lunarCache ~= glowingStarfire) then
        local starfireSpellID = 2912;
        if (lunarCache) then
            self:AddGlow(starfireSpellID, { (GetSpellInfo(starfireSpellID)) });
            glowingStarfire = true;
        else
            self:RemoveGlow(starfireSpellID);
            glowingStarfire = false;
        end
    end

    if (solarCache ~= glowingWrath) then
        local wrathSpellID = 5176;
        if (solarCache) then
            self:AddGlow(wrathSpellID, { (GetSpellInfo(wrathSpellID)) });
            glowingWrath = true;
        else
            self:RemoveGlow(wrathSpellID);
            glowingWrath = false;
        end
    end
end

local function customLoad(self)
    feralCache = isFeral(self);
    clarityCache = hasClarity(self);
    lunarCache = hasLunar(self);
    solarCache = hasSolar(self);
    updateSAOs(self);
    updateGABs(self);
end

local function updateShapeshift(self)
    local newIsFeral = isFeral(self)
    if (feralCache ~= newIsFeral) then
        feralCache = newIsFeral;
        updateSAOs(self);
    end
end

local function customCLEU(self, ...)
    local timestamp, event, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = CombatLogGetCurrentEventInfo() -- For all events

    -- Accept only certain events, and only when done by the player
    if (event ~= "SPELL_AURA_APPLIED" and event ~= "SPELL_AURA_REMOVED") then return end
    if (sourceGUID ~= UnitGUID("player")) then return end

    local spellID, spellName, spellSchool = select(12, CombatLogGetCurrentEventInfo()) -- For SPELL_*

    if (event == "SPELL_AURA_APPLIED") then
        if (spellID == omenSpellID) then
            clarityCache = true;
            updateSAOs(self);
        elseif (spellID == lunarSpellID) then
            lunarCache = true;
            updateSAOs(self);
            updateGABs(self);
        elseif (spellID == solarSpellID) then
            solarCache = true;
            updateSAOs(self);
            updateGABs(self);
        end
        return;
    elseif (event == "SPELL_AURA_REMOVED") then
        if (spellID == omenSpellID) then
            clarityCache = false;
            updateSAOs(self);
        elseif (spellID == lunarSpellID) then
            lunarCache = false;
            updateSAOs(self);
            updateGABs(self);
        elseif (spellID == solarSpellID) then
            solarCache = false;
            updateSAOs(self);
            updateGABs(self);
        end
        return;
    end
end

local function registerClass(self)
    -- Track Eclipses with a custom CLEU function, so that eclipses can coexist with Omen of Clarity
    -- self:RegisterAura("eclipse_lunar", 0, lunarSpellID, "eclipse_moon", "Left", 1, 255, 255, 255, true);
    -- self:RegisterAura("eclipse_solar", 0, solarSpellID, "eclipse_sun", "Right (Flipped)", 1, 255, 255, 255, true);

    -- Track Omen of Clarity with a custom CLEU function, to be able to switch between feral and non-feral texture
    -- self:RegisterAura("omen_of_clarity", 0, 16870, "natures_grace", "Left + Right (Flipped)", 1, 255, 255, 255, true);

    -- Register glow IDs for glowing buttons, namely Starfire and Wrath
    local starfire = GetSpellInfo(2912);
    local wrath = GetSpellInfo(5176);
    self:RegisterGlowIDs({ starfire, wrath });

    -- Predatory Strikes, inspired by Predatory Swiftness
    local regrowth = GetSpellInfo(8936);
    local healingTouch = GetSpellInfo(5185);
    local nourish = GetSpellInfo(50464);
    local rebirth = GetSpellInfo(20484);
    -- local wrath = GetSpellInfo(5176);
    local entanglingRoots = GetSpellInfo(339);
    local cyclone = GetSpellInfo(33786);
    local hibernate = GetSpellInfo(2637);
    local predatoryStrikesSpells = {
        regrowth,
        healingTouch,
        nourish,
        rebirth,
        wrath,
        entanglingRoots,
        cyclone,
        hibernate,
    }
    self:RegisterAura("predatory_strikes", 0, 69369, "predatory_swiftness", "Top", 1, 255, 255, 255, true, predatoryStrikesSpells);
end

local function loadOptions(self)
    local starfire = 2912;
    local wrath = 5176;

    -- Predatory Strikes candidates
    local regrowth = 8936;
    local healingTouch = 5185;
    local nourish = 50464;
    local rebirth = 20484;
    -- local wrath = 5176;
    local entanglingRoots = 339;
    local cyclone = 33786;
    local hibernate = 2637;

    local omenOfClarityTalent = 16864;
--    local eclipseTalent = 48516;
    -- Cheat with fake talents, to tell explicitly which type of eclipse is involved
    -- Otherwise the player would always see a generic "Eclipse" text
    local lunarEclipseTalent = lunarSpellID; -- Not really a talent
    local solarEclipseTalent = solarSpellID; -- Not really a talent

    local predatoryStrikesTalent = 16972;
    local predatoryStrikesBuff = 69369;

    self:AddOverlayOption(omenOfClarityTalent, omenSpellID); -- Spell ID not used by ActivateOverlay like typical overlays
    self:AddOverlayOption(lunarEclipseTalent, lunarSpellID); -- Spell ID not used by ActivateOverlay like typical overlays
    self:AddOverlayOption(solarEclipseTalent, solarSpellID); -- Spell ID not used by ActivateOverlay like typical overlays
    self:AddOverlayOption(predatoryStrikesTalent, predatoryStrikesBuff);

    self:AddGlowingOption(lunarEclipseTalent, starfire, starfire);
    self:AddGlowingOption(solarEclipseTalent, wrath, wrath);
    self:AddGlowingOption(predatoryStrikesTalent, predatoryStrikesBuff, regrowth);
    self:AddGlowingOption(predatoryStrikesTalent, predatoryStrikesBuff, healingTouch);
    self:AddGlowingOption(predatoryStrikesTalent, predatoryStrikesBuff, nourish);
    self:AddGlowingOption(predatoryStrikesTalent, predatoryStrikesBuff, rebirth);
    self:AddGlowingOption(predatoryStrikesTalent, predatoryStrikesBuff, wrath);
    self:AddGlowingOption(predatoryStrikesTalent, predatoryStrikesBuff, entanglingRoots);
    self:AddGlowingOption(predatoryStrikesTalent, predatoryStrikesBuff, cyclone);
    self:AddGlowingOption(predatoryStrikesTalent, predatoryStrikesBuff, hibernate);
end

SAO.Class["DRUID"] = {
    ["Register"] = registerClass,
    ["LoadOptions"] = loadOptions,
    ["COMBAT_LOG_EVENT_UNFILTERED"] = customCLEU,
    ["UPDATE_SHAPESHIFT_FORM"] = updateShapeshift,
    ["PLAYER_ENTERING_WORLD"] = customLoad,
}
