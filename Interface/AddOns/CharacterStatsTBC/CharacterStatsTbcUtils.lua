-- Returns the combat rating for 1% bonus
function CSC_GetCombatRatingPerUnitBonus(unit, combatRatingType)
    local result = 0;
    local playerLevel = UnitLevel(unit);
    local baseCombatRatingValue = g_CombatRatingBaseValues[combatRatingType];

    if not baseCombatRatingValue then
        baseCombatRatingValue = 1;
    end

    if (playerLevel >= 1 and playerLevel <= 10) then
        result = baseCombatRatingValue / 26;
    elseif (playerLevel > 10 and playerLevel <= 60) then
        result = baseCombatRatingValue * ((playerLevel - 8) / 52);
    elseif (playerLevel > 60 and playerLevel <= 70) then
        result = baseCombatRatingValue * (82 / (262 - 3 * playerLevel));
    end

    return result;
end

-- My own GetSpellHitModifier since Blizzard are breaking their API so often I can't rely on them
function CSC_GetSpellHitModifier(unit)
	local spellHit = 0;
	local unitClassId = select(3, UnitClass(unit));

	if unitClassId == CSC_PALADIN_CLASS_ID then
		local spellRank = select(5, GetTalentInfo(2, 3)); -- Precision
		spellHit = spellRank; -- 1% per rank
	elseif unitClassId == CSC_SHAMAN_CLASS_ID then
		local spellRank = select(5, GetTalentInfo(3, 6)); -- Nature's Guidance
		spellHit = spellRank; -- 1% per rank
	elseif unitClassId == CSC_DRUID_CLASS_ID then
		local spellRank = select(5, GetTalentInfo(1, 16)); -- Balance of power
		spellHit = spellRank * 2; -- 2% per rank
	end

	local spellHitFromAuras = 0;
	local hasInspiringPresenceAura = false;
	
	for i = 1, 40 do
		local spellId = select(10, UnitAura(unit, i, "HELPFUL"));
		if spellId then
			if spellId == 28878 then -- Inspiring Presence
				spellHitFromAuras = spellHitFromAuras + 1;
				hasInspiringPresenceAura = true;
			end

			if spellId == 30708 then -- Totem of Wrath
				spellHitFromAuras = spellHitFromAuras + 3;
			end
		end
	end

	if not hasInspiringPresenceAura and IsSpellKnown(28878) then
		spellHitFromAuras = spellHitFromAuras + 1;
	end

	return spellHit + spellHitFromAuras;
end

-- GENERAL UTIL FUNCTIONS BEGIN--
function CSC_GetAppropriateDamage(unit, category)
	if category == PLAYERSTAT_MELEE_COMBAT then
		return UnitDamage(unit);
	elseif category == PLAYERSTAT_RANGED_COMBAT then
		local attackTime, minDamage, maxDamage, bonusPos, bonusNeg, percent = UnitRangedDamage(unit);
		return minDamage, maxDamage, nil, nil, bonusPos, bonusNeg, percent;
	end
end

function CSC_GetAppropriateAttackSpeed(unit, category)
	if category == PLAYERSTAT_MELEE_COMBAT then
		return UnitAttackSpeed(unit);
	elseif category == PLAYERSTAT_RANGED_COMBAT then
		local attackSpeed = select(1, UnitRangedDamage(unit))
		return attackSpeed, 0;
	end
end

function CSC_GetAppropriateAttackRaiting(unit, category)
	local attackBase = 0;
	local attackModifier = 0;

	if category == PLAYERSTAT_MELEE_COMBAT then
		attackBase, attackModifier = UnitAttackBothHands(unit);
	elseif category == PLAYERSTAT_RANGED_COMBAT then
		attackBase, attackModifier = UnitRangedAttack(unit)
	end

	local attackWithModifier = attackBase + attackModifier;
	return attackWithModifier;
end

function CSC_PaperDollFrame_SetLabelAndText(statFrame, label, text, isPercentage)
	if ( isPercentage ) then
		text = format("%.2f%%", text);
	end
	
	if ( statFrame.Label ) then
		if (statFrame.Value) then
			statFrame.Value:SetText(text);
		end

		statFrame.Label:SetText(format(STAT_FORMAT, label));
		statFrame.Label:SetWidth(statFrame:GetWidth());
		statFrame.Label:SetHeight(statFrame:GetHeight());
		statFrame.Label:SetJustifyH("LEFT");
	end
end

function CSC_PaperDollFormatStat(name, base, posBuff, negBuff)
	local effective = max(0,base + posBuff + negBuff);
	local text = HIGHLIGHT_FONT_COLOR_CODE..name.." "..effective;
	if ( ( posBuff == 0 ) and ( negBuff == 0 ) ) then
		text = text..FONT_COLOR_CODE_CLOSE;
	else 
		if ( posBuff > 0 or negBuff < 0 ) then
			text = text.." ("..base..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 ) then
			text = text..FONT_COLOR_CODE_CLOSE..GREEN_FONT_COLOR_CODE.."+"..posBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( negBuff < 0 ) then
			text = text..RED_FONT_COLOR_CODE.." "..negBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 or negBuff < 0 ) then
			text = text..HIGHLIGHT_FONT_COLOR_CODE..")"..FONT_COLOR_CODE_CLOSE;
		end

		-- if there is a negative buff then show the main number in red, even if there are
		-- positive buffs. Otherwise show the number in green
		if ( negBuff < 0 ) then
			effective = RED_FONT_COLOR_CODE..effective..FONT_COLOR_CODE_CLOSE;
		elseif (posBuff > 0) then
			effective = GREEN_FONT_COLOR_CODE..effective..FONT_COLOR_CODE_CLOSE;
		end
	end
    
    return effective, text;
end

function CSC_HasEnchant(unit, slotId, enchantId)
	local itemLink = GetInventoryItemLink(unit, slotId);
	if itemLink then
		local itemId, enchant = itemLink:match("item:(%d+):(%d*)");
		if enchant then
			if tonumber(enchant) == enchantId then
				return true;
			end
		end
	end

	return false;
end
-- GENERAL UTIL FUNCTIONS END--