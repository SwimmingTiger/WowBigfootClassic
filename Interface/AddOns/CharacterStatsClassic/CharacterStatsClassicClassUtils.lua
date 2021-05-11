--[[
    Util functions specific for Classes
]]

-- returns additional crit % stats from Arcane instability and Critical Mass if any
function CSC_GetMageCritStatsFromTalents()

	local arcaneInstabilityCrit = 0;
	local criticalMassCrit = 0;

	-- Arcane Instability (1, 2, 3)%
	local arcaneInstabilityTable = { 1, 2, 3 };
	local spellRank = select(5, GetTalentInfo(1, 15));
	if (spellRank > 0) and (spellRank <= 3) then
		arcaneInstabilityCrit = arcaneInstabilityTable[spellRank];
	end

	-- Critical Mass (2, 4, 6)%
	local criticalMassTable = { 2, 4, 6 };
	spellRank = select(5, GetTalentInfo(2, 13));
	if (spellRank > 0) and (spellRank <= 3) then
		criticalMassCrit = criticalMassTable[spellRank];
    end

	return arcaneInstabilityCrit, criticalMassCrit;
end

-- returns the spell hit from Arcane Focus and Elemental Precision talents
function CSC_GetMageSpellHitFromTalents()
	local arcaneHit = 0;
	local frostFireHit = 0;

	-- Arcane Focus
	local spellRank = select(5, GetTalentInfo(1, 2));
	arcaneHit = spellRank * 2; -- 2% for each point

	-- Elemental Precision
	spellRank = select(5, GetTalentInfo(3, 3));
	frostFireHit = spellRank * 2; -- 2% for each point

	return arcaneHit, frostFireHit;
end

-- returns the spell hit from Suppression talent
function CSC_GetWarlockSpellHitFromTalents()
	local afflictionHit = 0;

	-- Suppression
	local spellRank = select(5, GetTalentInfo(1, 1));
	afflictionHit = spellRank * 2; -- 2% for each point

	return afflictionHit;
end

-- returns the spell crit from Devastation talent
function CSC_GetWarlockCritStatsFromTalents()
	-- the spell rank is equal to the value
	local devastationCrit = select(5, GetTalentInfo(3, 7));

	return devastationCrit;
end

-- returns the combined crit stats from Holy Specialization and Force of Will
function CSC_GetPriestCritStatsFromTalents()
	
	local holySpecializationCrit = 0;
	local forceOfWillCrit = 0;

	local critTable = { 1, 2, 3, 4, 5 };
	-- Holy Specialization (1, 2, 3, 4, 5)%
	local spellRank = select(5, GetTalentInfo(2, 3));
	if (spellRank > 0) and (spellRank <= 5) then
		holySpecializationCrit = critTable[spellRank];
	end

	-- Force of Will (1, 2, 3, 4, 5)%
	spellRank = select(5, GetTalentInfo(1, 14));
	if (spellRank > 0) and (spellRank <= 5) then
		forceOfWillCrit = critTable[spellRank];
	end

    local critCombined = holySpecializationCrit + forceOfWillCrit;
	return critCombined;
end

-- returns the healing modifier from Spiritual Healing talent for Priests
function CSC_GetPriestBonusHealingModifierFromTalents()
	-- Spiritual Healing
	local spellRank = select(5, GetTalentInfo(2, 15));
	return spellRank * 0.02;
end

-- returns the crit bonus from Holy Power
function CSC_GetPaladinCritStatsFromTalents()
	-- Holy Power (1, 2, 3, 4, 5)%
	local spellRank = select(5, GetTalentInfo(1, 13));

	return spellRank;
end

-- returns the defense bonus from the Anticipation Prot talent
local function CSC_GetPaladinDefenseFromTalents()

    local defense = 0;
    local defenseTable = { 2, 4, 6, 8, 10 };

    -- Anticipation (2, 4, 6, 8, 10)%
    local spellRank = select(5, GetTalentInfo(2, 9));
    if (spellRank > 0) and (spellRank <=5) then
        defense = defenseTable[spellRank];
    end

    return defense;
end

-- returns the modifier from Improved Blessing of Wisdom Holy talent
function CSC_GetPaladinImprovedBoWModifier()
	-- Improved Blessing of Wisdom
	local spellRank = select(5, GetTalentInfo(1, 10));

	return spellRank * 0.1;
end

-- Checks if spellId is Blessing of Wisdom
function CSC_IsBoWSpellId(spellId)

	if (spellId == 19742 or spellId == 19850 or spellId == 19852 or spellId == 19853 or spellId == 19854 or spellId == 25290 or spellId == 25894 or spellId == 25918) then
		return true;
	end

	return false;
end

-- returns the defense bonus from the Anticipation Prot talent
local function CSC_GetWarriorDefenseFromTalents()
    
    local defense = 0;
    local defenseTable = { 2, 4, 6, 8, 10 };

    -- Anticipation (2, 4, 6, 8, 10)%
    local spellRank = select(5, GetTalentInfo(3, 2));
    if (spellRank > 0) and (spellRank <=5) then
		defense = defenseTable[spellRank];
	end

    return defense;
end

function CSC_GetDefenseFromTalents(unit)
    
	local defense = 0;
	local unitClassId = select(3, UnitClass(unit));

    if (unitClassId == CSC_PALADIN_CLASS_ID) then
        defense = CSC_GetPaladinDefenseFromTalents();
    elseif (unitClassId == CSC_WARRIOR_CLASS_ID) then
        defense = CSC_GetWarriorDefenseFromTalents();
    end

    return defense;
end

-- returns the shapeshift form index for druids
function CSC_GetShapeshiftForm()
	local shapeIndex = 0;

	for possibleForm=1, GetNumShapeshiftForms() do
		if select(2, GetShapeshiftFormInfo(possibleForm)) then
			shapeIndex = possibleForm;
		end
	end

	return shapeIndex;
end

-- returns the bonus hit from Nature's Guidance talent (counts as melee and spell hit)
function CSC_GetShamanHitFromTalents()
	-- Nature's Guidance
	local spellRank = select(5, GetTalentInfo(3, 6));
	return spellRank;
end

-- returns the bonus crit from the Call of Thunder talent for Shamans
function CSC_GetShamanCallOfThunderCrit()
	local bonusCrit = 0;
	local talentTable = { 1, 2, 3, 4, 6 };

	-- Call of Thunder (Lightning)
	local spellRank = select(5, GetTalentInfo(1, 8));

    if (spellRank > 0) and (spellRank <=5) then
		bonusCrit = talentTable[spellRank];
	end

	return bonusCrit;
end

-- returns the bonus crit from the Tidal Mastery telent for Shamans
function CSC_GetShamanTidalMasteryCrit()
	-- Tidal Mastery (Nature/Lightning)
	local spellRank = select(5, GetTalentInfo(3, 11));
	return spellRank;
end

-- ITEMS AND ENCHANTS RELATED
function CSC_GetMP5ModifierFromTalents(unit)
    local unitClassId = select(3, UnitClass(unit));
	local spellRank = 0;

	if unitClassId == CSC_PRIEST_CLASS_ID then
		-- Meditation
        spellRank = select(5, GetTalentInfo(1, 8));
	elseif unitClassId == CSC_MAGE_CLASS_ID then
		-- Arcane Meditation
		spellRank = select(5, GetTalentInfo(1, 12));
	elseif unitClassId == CSC_DRUID_CLASS_ID then
		-- Reflection
        spellRank = select(5, GetTalentInfo(3, 6));
	end
	
	local modifier = spellRank * 0.05;

    return modifier;
end

function CSC_GetMP5ModifierFromSetBonus(unit)
	local unitClassId = select(3, UnitClass(unit));
	local modifier = 0;
	
	-- not Druid or Priest
	if unitClassId ~= CSC_DRUID_CLASS_ID and unitClassId ~= CSC_PRIEST_CLASS_ID then
		return modifier;
	end
	
	local firstItemslotIndex = 1;
	local lastItemslotIndex = 18;

	local equippedSetItems = 0;
    for itemSlot = firstItemslotIndex, lastItemslotIndex do
        local itemId = GetInventoryItemID(unit, itemSlot);
		
		if (itemId) then
			if (itemId == g_VestmentsOfTranscendenceIds[itemId] or itemId == g_StormrageRaimentIds[itemId]) then
				equippedSetItems = equippedSetItems + 1;
			end
		end
    end

    if equippedSetItems >= 3 then
        modifier = 0.15;
	end

    return modifier;
end

function CSC_GetShamanT2SpellCrit(unit)
	local spellCritFromSet = 0;
	local firstItemslotIndex = 1;
	local lastItemslotIndex = 18;

	local equippedSetItems = 0;
    for itemSlot = firstItemslotIndex, lastItemslotIndex do
        local itemId = GetInventoryItemID(unit, itemSlot);
		
		if (itemId) then
			if (itemId == g_TheTenStormsIds[itemId]) then
				equippedSetItems = equippedSetItems + 1;
			end
		end
    end

    if equippedSetItems >= 5 then
        spellCritFromSet = 3;
	end

    return spellCritFromSet;
end

function CSC_GetHolyCritFromBenediction(unit)
	local benedictionCrit = 0;
	local itemId = GetInventoryItemID(unit, INVSLOT_MAINHAND);
	
	if itemId == 18608 then
		benedictionCrit = 2;
	end

	return benedictionCrit;
end

function CSC_GetBlockValueFromWarriorZGEnchants(unit)
	local blockValue = 0;

	if CSC_HasEnchant(unit, INVSLOT_HEAD, 2583) then
		blockValue = blockValue + 15;
	end

	if CSC_HasEnchant(unit, INVSLOT_LEGS, 2583) then
		blockValue = blockValue + 15;
	end

	return blockValue;
end

function CSC_GetMp5FromPriestZGEnchants(unit)
	local mp5 = 0;

	if CSC_HasEnchant(unit, INVSLOT_HEAD, 2590) then
		mp5 = mp5 + 4;
	end

	if CSC_HasEnchant(unit, INVSLOT_LEGS, 2590) then
		mp5 = mp5 + 4;
	end

	return mp5;
end
