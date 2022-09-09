local AddonName, SAO = ...

-- This script file is not a 'component' per se, but its functions are used across components

-- Utility aura function, one of the many that Blizzard could've done better years ago...
function SAO.FindPlayerAuraByID(self, id)
    local i = 1
    local name, icon, count, dispelType, duration, expirationTime,
        source, isStealable, nameplateShowPersonal, spellId,
        canApplyAura, isBossDebuff, castByPlayer = UnitBuff("player", i);
    while name do
        if (spellId == id) then
            return name, icon, count, dispelType, duration, expirationTime,
                source, isStealable, nameplateShowPersonal, spellId,
                canApplyAura, isBossDebuff, castByPlayer;
        end
        i = i+1
        name, icon, count, dispelType, duration, expirationTime,
            source, isStealable, nameplateShowPersonal, spellId,
            canApplyAura, isBossDebuff, castByPlayer = UnitBuff("player", i);
    end
end

--[[
    Utility function to know how many talent points the player has spent on a specific talent

    If the talent is found, returns:
    - the number of points spent for this talent
    - the total number of points possible for this talent
    - the tabulation in which the talent was found
    - the index in which the talent was found
    Tabulation and index can be re-used in GetTalentInfo to avoid re-parsing all talents

    Returns nil if no talent is found with this name e.g., in the wrong expansion
]]
function SAO.GetTalentByName(self, talentName)
    for tab = 1, GetNumTalentTabs() do
        for index = 1, GetNumTalents(tab) do
            local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(tab, index);
            if (name == talentName) then
                return rank, maxRank, tab, index;
            end
        end
    end
end

-- Utility function to get the spell ID associated to an action
function SAO.GetSpellIDByActionSlot(self, actionSlot)
    local actionType, id, subType = GetActionInfo(actionSlot);
    if (actionType == "spell") then
        return id;
    elseif (actionType == "macro") then
        return GetMacroSpell(id);
    end
end

-- Utility function to return the list spellIDs for spells in the spellbook matching the same of a given spell
-- Spells are searched into the *current* spellbook, not through all available spells ever
-- This means the returned list will be obsolete if e.g. new spells are learned afterwards or if the player re-specs
-- @param spell Either the spell name (as string) or the spell ID (as number)
function SAO.GetHomonymSpellIDs(self, spell)
    local spellName;
    if (type(spell) == "string") then
        spellName = spell;
    elseif (type(spell) == "number") then
        spellName = GetSpellInfo(spell);
    end
    if (not spellName) then
        return {};
    end

    local homonyms = {};

    for tab = 1, GetNumSpellTabs() do
        local offset, numSlots = select(3, GetSpellTabInfo(tab));
        for index = offset+1, offset+numSlots do
            local name, _, id = GetSpellBookItemName(index, BOOKTYPE_SPELL);
            if (name == spellName) then
                table.insert(homonyms, id);
            end
        end
    end

    return homonyms;
end
