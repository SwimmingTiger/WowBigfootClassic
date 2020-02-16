--[[
    Util functions that wrap my interface and the Blizzard's WoW Classic lua API code for ease of use
]]

local function DebugBreakPrint()
    print("ERROR");
end

local CSC_ScanTooltip = CreateFrame("GameTooltip", "CSC_ScanTooltip", nil, "GameTooltipTemplate");
CSC_ScanTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
local CSC_ScanTooltipPrefix = "CSC_ScanTooltip";

local weaponStringByWeaponId = {
	[LE_ITEM_WEAPON_AXE1H] 		= CSC_WEAPON_AXE1H_TXT,
	[LE_ITEM_WEAPON_AXE2H] 		= CSC_WEAPON_AXE2H_TXT,
	[LE_ITEM_WEAPON_MACE1H] 	= CSC_WEAPON_MACE1H_TXT,
	[LE_ITEM_WEAPON_MACE2H] 	= CSC_WEAPON_MACE2H_TXT,
	[LE_ITEM_WEAPON_POLEARM] 	= CSC_WEAPON_POLEARM_TXT,
	[LE_ITEM_WEAPON_SWORD1H] 	= CSC_WEAPON_SWORD1H_TXT,
	[LE_ITEM_WEAPON_SWORD2H] 	= CSC_WEAPON_SWORD2H_TXT,
	[LE_ITEM_WEAPON_STAFF] 		= CSC_WEAPON_STAFF_TXT,
	[LE_ITEM_WEAPON_UNARMED] 	= CSC_WEAPON_UNARMED_TXT,
	[LE_ITEM_WEAPON_DAGGER] 	= CSC_WEAPON_DAGGER_TXT
};

-- GENERAL UTIL FUNCTIONS --
local function CSC_GetAppropriateDamage(unit, category)
	if category == PLAYERSTAT_MELEE_COMBAT then
		return UnitDamage(unit);
	elseif category == PLAYERSTAT_RANGED_COMBAT then
		local attackTime, minDamage, maxDamage, bonusPos, bonusNeg, percent = UnitRangedDamage(unit);
		return minDamage, maxDamage, nil, nil, bonusPos, bonusNeg, percent;
	end
end

local function CSC_GetAppropriateAttackSpeed(unit, category)
	if category == PLAYERSTAT_MELEE_COMBAT then
		return UnitAttackSpeed(unit);
	elseif category == PLAYERSTAT_RANGED_COMBAT then
		local attackSpeed = select(1, UnitRangedDamage(unit))
		return attackSpeed, 0;
	end
end

local function CSC_GetAppropriateAttackRaiting(unit, category)
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

local function CSC_PaperDollFrame_SetLabelAndText(statFrame, label, text, isPercentage, numericValue)
	if ( isPercentage ) then
		statFrame.Value:SetText(format("%.1F%%", numericValue));
	else
		statFrame.Value:SetText(text);
	end
	statFrame.numericValue = numericValue;

	if ( statFrame.Label ) then
		statFrame.Label:SetText(format(STAT_FORMAT, label));
		statFrame.Label:SetWidth(statFrame:GetWidth() - statFrame.Value:GetWidth() - 20);
		statFrame.Label:SetHeight(statFrame:GetHeight());
		statFrame.Label:SetJustifyH("LEFT");
	end
end

local function CSC_PaperDollFormatStat(name, base, posBuff, negBuff)
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

local function CSC_GetMP5FromGear(unit)
	local mp5 = 0;
	for i=1,18 do
		local itemLink = GetInventoryItemLink(unit, i);
		if itemLink then
			local stats = GetItemStats(itemLink);
			if stats then
				-- For some reason this returns (mp5 - 1) so I have to add 1 to the result
				local statMP5 = stats["ITEM_MOD_POWER_REGEN0_SHORT"];
				if (statMP5) then
					mp5 = mp5 + statMP5 + 1;
				end
			end
		end
	end

	return mp5;
end

local function CSC_GetSkillRankAndModifier(skillHeader, skillName)
	local numSkills = GetNumSkillLines();
	local skillIndex = 0;
	local currentHeader = nil;

	for i = 1, numSkills do
		local currentSkillName = select(1, GetSkillLineInfo(i));
		local isHeader = select(2, GetSkillLineInfo(i));

		if isHeader ~= nil and isHeader then
			currentHeader = currentSkillName;
		else
			if (currentHeader == skillHeader and currentSkillName == skillName) then
				skillIndex = i;
				break;
			end
		end
	end

	local skillRank = nil;
	local skillModifier = nil;
	if (skillIndex > 0) then
		skillRank = select(4, GetSkillLineInfo(skillIndex));
		skillModifier = select(6, GetSkillLineInfo(skillIndex));
	end

	return skillRank, skillModifier;
end

local function CSC_GetPlayerMissChances(unit, playerHit)
	local hitChance = playerHit;
	local missChanceVsNPC = 5; -- Level 60 npcs with 300 def
	local missChanceVsBoss = 9;
	local missChanceVsPlayer = 5; -- Level 60 player def is 300 base

	local mainHandItemId = 16;

	local itemId = GetInventoryItemID(unit, mainHandItemId);
	if (itemId) then
		local itemSubtypeId = select(7, GetItemInfoInstant(itemId));
		if itemSubtypeId then
			local weaponString = weaponStringByWeaponId[itemSubtypeId];
			if weaponString then
				local skillRank, skillModifier = CSC_GetSkillRankAndModifier(CSC_WEAPON_SKILLS_HEADER, weaponString);
				if skillRank and skillModifier then
					-- Weapon skill from racials should be already in skillRank
					local totalWeaponSkill = skillRank + skillModifier;
					local bossDefense = 315; -- level 63
					
					local playerBossDeltaSkill = bossDefense - totalWeaponSkill;
					
					if (playerBossDeltaSkill > 10) then
						if (hitChance >= 1) then
							hitChance = hitChance - 1;
						end

						missChanceVsBoss = 5 + (playerBossDeltaSkill * 0.2);
					else
						missChanceVsBoss = 5 + (playerBossDeltaSkill * 0.1);
					end
				end
			end
		end
	end

	local dwMissChanceVsNpc = math.max(0, (missChanceVsNPC*0.8 + 20) - hitChance);
	local dwMissChanceVsBoss = math.max(0, (missChanceVsBoss*0.8 + 20) - hitChance);
	local dwMissChanceVsPlayer = math.max(0, (missChanceVsPlayer*0.8 + 20) - hitChance);

	missChanceVsNPC = math.max(0, missChanceVsNPC - hitChance);
	missChanceVsBoss = math.max(0, missChanceVsBoss - hitChance);
	missChanceVsPlayer = math.max(0, missChanceVsPlayer - hitChance);

	return missChanceVsNPC, missChanceVsBoss, missChanceVsPlayer, dwMissChanceVsNpc, dwMissChanceVsBoss, dwMissChanceVsPlayer;
end
-- GENERAL UTIL FUNCTIONS END --

-- PRIMARY STATS --
function CSC_PaperDollFrame_SetPrimaryStats(statFrames, unit)
	
	local statIndexTable = {
		"STRENGTH",
		"AGILITY",
		"STAMINA",
		"INTELLECT",
		"SPIRIT",
	}

	-- Fix for classic (NUM_STATS instead of NUM_STATS-1)
	for i=1, NUM_STATS, 1 do
		local frameText;

		local stat;
		local effectiveStat;
		local posBuff;
		local negBuff;
		stat, effectiveStat, posBuff, negBuff = UnitStat(unit, i);
		
		-- Set the tooltip text
		local tooltipText = HIGHLIGHT_FONT_COLOR_CODE.._G["SPELL_STAT"..i.."_NAME"].." ";

		-- Get class specific tooltip for that stat
		local temp, classFileName = UnitClass(unit);
		local classStatText = _G[strupper(classFileName).."_"..statIndexTable[i].."_".."TOOLTIP"];
		-- If can't find one use the default
		if ( not classStatText ) then
			classStatText = _G["DEFAULT".."_"..statIndexTable[i].."_".."TOOLTIP"];
		end

		if ( ( posBuff == 0 ) and ( negBuff == 0 ) ) then
			--text:SetText(effectiveStat);
			frameText = effectiveStat;
			statFrames[i].tooltip = tooltipText..effectiveStat..FONT_COLOR_CODE_CLOSE;
			statFrames[i].tooltip2 = classStatText;
		else 
			tooltipText = tooltipText..effectiveStat;
			if ( posBuff > 0 or negBuff < 0 ) then
				tooltipText = tooltipText.." ("..(stat - posBuff - negBuff)..FONT_COLOR_CODE_CLOSE;
			end
			if ( posBuff > 0 ) then
				tooltipText = tooltipText..FONT_COLOR_CODE_CLOSE..GREEN_FONT_COLOR_CODE.."+"..posBuff..FONT_COLOR_CODE_CLOSE;
			end
			if ( negBuff < 0 ) then
				tooltipText = tooltipText..RED_FONT_COLOR_CODE.." "..negBuff..FONT_COLOR_CODE_CLOSE;
			end
			if ( posBuff > 0 or negBuff < 0 ) then
				tooltipText = tooltipText..HIGHLIGHT_FONT_COLOR_CODE..")"..FONT_COLOR_CODE_CLOSE;
			end
			statFrames[i].tooltip = tooltipText;
			statFrames[i].tooltip2= classStatText;

			-- If there are any negative buffs then show the main number in red even if there are
			-- positive buffs. Otherwise show in green.
			if ( negBuff < 0 ) then
				frameText = RED_FONT_COLOR_CODE..effectiveStat..FONT_COLOR_CODE_CLOSE;
			else
				frameText = GREEN_FONT_COLOR_CODE..effectiveStat..FONT_COLOR_CODE_CLOSE;
			end
		end
		CSC_PaperDollFrame_SetLabelAndText(statFrames[i], _G["SPELL_STAT"..i.."_NAME"], frameText, false, effectiveStat);
		statFrames[i]:Show();
	end
end

-- DAMAGE --
function CSC_PaperDollFrame_SetDamage(statFrame, unit, category)

	if (category == PLAYERSTAT_RANGED_COMBAT) and not IsRangedWeapon() then
		CSC_PaperDollFrame_SetLabelAndText(statFrame, DAMAGE, NOT_APPLICABLE, false, 0);
		statFrame:Show();
		return;
	end

    statFrame:SetScript("OnEnter", CSC_CharacterDamageFrame_OnEnter)
	statFrame:SetScript("OnLeave", function()
		GameTooltip:Hide()
    end)

    local speed, offhandSpeed = CSC_GetAppropriateAttackSpeed(unit, category);
    local minDamage, maxDamage, minOffHandDamage, maxOffHandDamage, physicalBonusPos, physicalBonusNeg, percent = CSC_GetAppropriateDamage(unit, category);
    
    local displayMin = max(floor(minDamage),1);
    local displayMax = max(ceil(maxDamage),1);
    
    minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
    maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;
    
    local baseDamage = (minDamage + maxDamage) * 0.5;
	local fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
	local totalBonus = (fullDamage - baseDamage);
	local damagePerSecond = (max(fullDamage,1) / speed);
    local damageTooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
    
    local colorPos = "|cff20ff20";
    local colorNeg = "|cffff2020";
	
    -- epsilon check
	if ( totalBonus < 0.1 and totalBonus > -0.1 ) then
		totalBonus = 0.0;
    end
    
    local damageText;

    if ( totalBonus == 0 ) then
		if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
			damageText = displayMin.." - "..displayMax;
		else
			damageText = displayMin.."-"..displayMax;
		end
	else
		-- set bonus color and display
		local color;
		if ( totalBonus > 0 ) then
			color = colorPos;
		else
			color = colorNeg;
		end
		if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
			damageText = color..displayMin.." - "..displayMax.."|r";
		else
			damageText = color..displayMin.."-"..displayMax.."|r";
		end
		if ( physicalBonusPos > 0 ) then
			damageTooltip = damageTooltip..colorPos.." +"..physicalBonusPos.."|r";
		end
		if ( physicalBonusNeg < 0 ) then
			damageTooltip = damageTooltip..colorNeg.." "..physicalBonusNeg.."|r";
		end
		if ( percent > 1 ) then
			damageTooltip = damageTooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
		elseif ( percent < 1 ) then
			damageTooltip = damageTooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
		end
    end
    
    CSC_PaperDollFrame_SetLabelAndText(statFrame, DAMAGE, damageText, false, displayMax);

    statFrame.damage = damageTooltip;
	statFrame.attackSpeed = speed;
    statFrame.dps = damagePerSecond;
	statFrame.attackRating = CSC_GetAppropriateAttackRaiting(unit, category);
	statFrame.TooltipMainTxt = INVTYPE_WEAPONMAINHAND;

	if (category == PLAYERSTAT_RANGED_COMBAT) and IsRangedWeapon() then
		statFrame.TooltipMainTxt = INVTYPE_RANGED;
	end

    -- If there's an offhand speed then add the offhand info to the tooltip
	if ( offhandSpeed and category == PLAYERSTAT_MELEE_COMBAT) then
		minOffHandDamage = (minOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;
		maxOffHandDamage = (maxOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;

		local offhandBaseDamage = (minOffHandDamage + maxOffHandDamage) * 0.5;
		local offhandFullDamage = (offhandBaseDamage + physicalBonusPos + physicalBonusNeg) * percent;
		local offhandDamagePerSecond = (max(offhandFullDamage,1) / offhandSpeed);
		local offhandDamageTooltip = max(floor(minOffHandDamage),1).." - "..max(ceil(maxOffHandDamage),1);
		if ( physicalBonusPos > 0 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorPos.." +"..physicalBonusPos.."|r";
		end
		if ( physicalBonusNeg < 0 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorNeg.." "..physicalBonusNeg.."|r";
		end
		if ( percent > 1 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
		elseif ( percent < 1 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
		end
		statFrame.offhandDamage = offhandDamageTooltip;
		statFrame.offhandAttackSpeed = offhandSpeed;
		statFrame.offhandDps = offhandDamagePerSecond;
	else
		statFrame.offhandAttackSpeed = nil;
    end

	statFrame:Show();
end

-- Note: while this function was historically named "BothHands",
-- it looks like it only ever displayed attack rating for the main hand.
function CSC_PaperDollFrame_SetAttackBothHands(statFrame, unit)

	local mainHandAttackBase, mainHandAttackMod = UnitAttackBothHands(unit);
	local attackWithModifier = mainHandAttackBase + mainHandAttackMod;
	local attackText;

	if( mainHandAttackMod == 0 ) then
		attackText = mainHandAttackBase;
	else
		local color = RED_FONT_COLOR_CODE;
		if( mainHandAttackMod > 0 ) then
			color = GREEN_FONT_COLOR_CODE;
		end
		attackText = color..attackWithModifier..FONT_COLOR_CODE_CLOSE;
	end

	CSC_PaperDollFrame_SetLabelAndText(statFrame, DAMAGE, attackText, false, attackWithModifier);

	statFrame.tooltip = ATTACK_TOOLTIP;
	statFrame.tooltip2 = ATTACK_TOOLTIP_SUBTEXT;
	statFrame:Show();
end

function CSC_PaperDollFrame_SetMeleeAttackPower(statFrame, unit)
    
	local base, posBuff, negBuff = UnitAttackPower(unit);
    
    local valueText, tooltipText = CSC_PaperDollFormatStat(MELEE_ATTACK_POWER, base, posBuff, negBuff);
    local valueNum = max(0, base + posBuff + negBuff);
    CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_ATTACK_POWER, valueText, false, valueNum);
    statFrame.tooltip = tooltipText;
    statFrame.tooltip2 = format(MELEE_ATTACK_POWER_TOOLTIP, max((base+posBuff+negBuff), 0)/ATTACK_POWER_MAGIC_NUMBER);
	statFrame:Show();
end

function CSC_PaperDollFrame_SetRangedAttackPower(statFrame, unit)
	
	if not IsRangedWeapon() then
		CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_ATTACK_POWER, NOT_APPLICABLE, false, 0);
		statFrame:Show();
		return;
	end

	if ( HasWandEquipped() ) then
		CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_ATTACK_POWER, NOT_APPLICABLE, false, 0);
		statFrame.tooltip = nil;
		statFrame:Show();
		return;
	end

	local base, posBuff, negBuff = UnitRangedAttackPower(unit);
    local valueText, tooltipText = CSC_PaperDollFormatStat(RANGED_ATTACK_POWER, base, posBuff, negBuff);
    local valueNum = max(0, base + posBuff + negBuff);
    CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_ATTACK_POWER, valueText, false, valueNum);
	statFrame.tooltip = tooltipText;
    statFrame.tooltip2 = format(RANGED_ATTACK_POWER_TOOLTIP, valueNum/ATTACK_POWER_MAGIC_NUMBER);
    statFrame:Show();
end

-- SECONDARY STATS --
function CSC_PaperDollFrame_SetCritChance(statFrame, unit, category)
    local critChance;

    if category == PLAYERSTAT_MELEE_COMBAT then
        critChance = GetCritChance();
	elseif category == PLAYERSTAT_RANGED_COMBAT then
		if not IsRangedWeapon() then
			CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_CRITICAL_STRIKE, NOT_APPLICABLE, false, 0);
			statFrame:Show();
			return;
		end
        critChance = GetRangedCritChance();
    end

    CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_CRITICAL_STRIKE, critChance, true, critChance);
	statFrame.tooltip = format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_CRITICAL_STRIKE).." "..format("%.2F%%", critChance);
    statFrame:Show();
end

function CSC_PaperDollFrame_SetSpellCritChance(statFrame, unit)

	statFrame:SetScript("OnEnter", CSC_CharacterSpellCritFrame_OnEnter)
	statFrame:SetScript("OnLeave", function()
		GameTooltip:Hide()
    end)
	
	local MAX_SPELL_SCHOOLS = 7;
	local holySchool = 2;

	-- Start at 2 to skip physical damage
	local maxSpellCrit = GetSpellCritChance(holySchool);
	for i=holySchool, MAX_SPELL_SCHOOLS do
		local bonusCrit = GetSpellCritChance(i);
		maxSpellCrit = max(maxSpellCrit, bonusCrit);
	end

	statFrame.holyCrit = GetSpellCritChance(2);
	statFrame.fireCrit = GetSpellCritChance(3);
	statFrame.natureCrit = GetSpellCritChance(4);
	statFrame.frostCrit = GetSpellCritChance(5);
	statFrame.shadowCrit = GetSpellCritChance(6);
	statFrame.arcaneCrit = GetSpellCritChance(7);

	local unitClassLoc = select(2, UnitClass(unit));
	if (unitClassLoc == "MAGE") then
		local arcaneInstabilityCrit, criticalMassCrit = CSC_GetMageCritStatsFromTalents();
		if (arcaneInstabilityCrit > 0) then
			-- increases the crit of all spell schools
			statFrame.holyCrit = statFrame.holyCrit + arcaneInstabilityCrit;
			statFrame.fireCrit = statFrame.fireCrit + arcaneInstabilityCrit;
			statFrame.natureCrit = statFrame.natureCrit + arcaneInstabilityCrit;
			statFrame.frostCrit = statFrame.frostCrit + arcaneInstabilityCrit;
			statFrame.shadowCrit = statFrame.shadowCrit + arcaneInstabilityCrit;
			statFrame.arcaneCrit = statFrame.arcaneCrit + arcaneInstabilityCrit;
			-- set the new maximum
			maxSpellCrit = maxSpellCrit + arcaneInstabilityCrit;
		end
		if (criticalMassCrit > 0) then
			statFrame.fireCrit = statFrame.fireCrit + criticalMassCrit;
			-- set the new maximum
			maxSpellCrit = max(maxSpellCrit, statFrame.fireCrit);
		end
	elseif (unitClassLoc == "PRIEST") then
		local priestHolyCrit = CSC_GetPriestCritStatsFromTalents();
		if (priestHolyCrit > 0) then
			statFrame.holyCrit = statFrame.holyCrit + priestHolyCrit;
			-- set the new maximum
			maxSpellCrit = max(maxSpellCrit, statFrame.holyCrit);
		end
	elseif (unitClassLoc == "PALADIN") then
		--[[local paladinHolyCrit = CSC_GetPaladinCritStatsFromTalents();
		if (paladinHolyCrit > 0) then
			statFrame.holyCrit = statFrame.holyCrit + paladinHolyCrit;
			-- set the new maximum
			maxSpellCrit = max(maxSpellCrit, statFrame.holyCrit);
		end]]
	end

	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_CRITICAL_STRIKE, maxSpellCrit, true, maxSpellCrit);

    statFrame:Show();
end

function CSC_PaperDollFrame_SetHitChance(statFrame, unit)
	
	statFrame:SetScript("OnEnter", CSC_CharacterHitChanceFrame_OnEnter)
	statFrame:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)
	
	local hitChance = GetHitModifier();
	
	if not hitChance then
		hitChance = 0;
	end

	local hitChanceText = hitChance;
	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_HIT_CHANCE, hitChanceText, true, hitChance);
	statFrame.hitChance = hitChance;
	statFrame:Show();
end

local function CSC_GetHitFromBiznicksAccurascope(unit)
	CSC_ScanTooltip:ClearLines();

	local hitFromScope = 0;
	local rangedIndex = 18;

	local itemLink = GetInventoryItemLink(unit, rangedIndex);
	if itemLink then
		local itemId, enchantId = itemLink:match("item:(%d+):(%d*)");
		if enchantId then
			if tonumber(enchantId) == 2523 then
				hitFromScope = hitFromScope + 3;
			end
		end
	end

	return hitFromScope;
end

function CSC_PaperDollFrame_SetRangedHitChance(statFrame, unit)
	
	if not IsRangedWeapon() then
		CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_HIT_CHANCE, NOT_APPLICABLE, false, 0);
		statFrame:Show();
		return;
	end
	
	local hitChance = GetHitModifier();
	
	if not hitChance then
		hitChance = 0;
	end

	local hitFromScope = CSC_GetHitFromBiznicksAccurascope(unit);
	if (hitFromScope > 0) then
		hitChance = hitChance + hitFromScope;
	end

	local hitChanceText = hitChance;
	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_HIT_CHANCE, hitChanceText, true, hitChance);
	statFrame.tooltip = STAT_HIT_CHANCE.." "..hitChanceText;
	statFrame.tooltip2 = format(CR_HIT_RANGED_TOOLTIP, UnitLevel(unit), hitChance);
	statFrame:Show();
end

function CSC_PaperDollFrame_SetSpellHitChance(statFrame, unit)
	local hitChance = GetSpellHitModifier();
	
	if not hitChance then
		hitChance = 0;
	end

	local hitChanceText = hitChance;
	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_HIT_CHANCE, hitChanceText, true, hitChance);
	statFrame.tooltip = STAT_HIT_CHANCE.." "..hitChanceText;
	statFrame.tooltip2 = format(CR_HIT_SPELL_TOOLTIP, UnitLevel(unit), hitChance);
	statFrame:Show();
end

function CSC_PaperDollFrame_SetAttackSpeed(statFrame, unit)
	local speed, offhandSpeed = UnitAttackSpeed(unit);
	local speedLabel = WEAPON_SPEED;

	local displaySpeed = format("%.2F", speed);
	if ( offhandSpeed ) then
		offhandSpeed = format("%.2F", offhandSpeed);
	end
	if ( offhandSpeed ) then
		displaySpeed =  displaySpeed.." / ".. offhandSpeed;
	else
		displaySpeed =  displaySpeed;
	end
	CSC_PaperDollFrame_SetLabelAndText(statFrame, speedLabel, displaySpeed, false, speed);
	statFrame.tooltip = format(PAPERDOLLFRAME_TOOLTIP_FORMAT, ATTACK_SPEED).." "..displaySpeed;
	statFrame:Show();
end

function CSC_PaperDollFrame_SetRangedAttackSpeed(statFrame, unit)
	
	if not IsRangedWeapon() then
		CSC_PaperDollFrame_SetLabelAndText(statFrame, WEAPON_SPEED, NOT_APPLICABLE, false, 0);
		statFrame:Show();
		return;
	end

	local attackSpeed, minDamage, maxDamage, bonusPos, bonusNeg, percent = UnitRangedDamage(unit);
	local displaySpeed = format("%.2F", attackSpeed);

	CSC_PaperDollFrame_SetLabelAndText(statFrame, WEAPON_SPEED, displaySpeed, false, attackSpeed);
	statFrame.tooltip = format(PAPERDOLLFRAME_TOOLTIP_FORMAT, ATTACK_SPEED).." "..displaySpeed;
	statFrame:Show();
end

-- DEFENSES --
function CSC_PaperDollFrame_SetArmor(statFrame, unit)

	local base, effectiveArmor, armor, posBuff, negBuff = UnitArmor(unit);
	--negBuff = 0; -- Remove for Classic

	if (unit ~= "player") then
		--[[ In 1.12.0, UnitArmor didn't report positive / negative buffs for units that weren't the active player.
			 This hack replicates that behavior for the UI. ]]
		base = effectiveArmor;
		armor = effectiveArmor;
		posBuff = 0;
		negBuff = 0;
	end

	local playerLevel = UnitLevel(unit);
	local armorReduction = effectiveArmor/((85 * playerLevel) + 400);
	armorReduction = 100 * (armorReduction/(armorReduction + 1));

	local valueText, tooltipText = CSC_PaperDollFormatStat(ARMOR, base, posBuff, negBuff);
	local valueNum = max(0, base + posBuff + negBuff);
	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_ARMOR, valueText, false, valueNum);
	statFrame.tooltip = tooltipText;
    statFrame.tooltip2 = format(ARMOR_TOOLTIP, playerLevel, armorReduction);
	statFrame:Show();
end

function CSC_PaperDollFrame_SetDefense(statFrame, unit)

	local numSkills = GetNumSkillLines();
	local skillIndex = 0;
	local currentHeader = nil;

	for i = 1, numSkills do
		local skillName = select(1, GetSkillLineInfo(i));
		local isHeader = select(2, GetSkillLineInfo(i));

		if isHeader ~= nil and isHeader then
			currentHeader = skillName;
		else
			if (currentHeader == CSC_WEAPON_SKILLS_HEADER and skillName == CSC_DEFENSE) then
				skillIndex = i;
				break;
			end
		end
	end

	local skillRank, skillModifier;
	if (skillIndex > 0) then
		skillRank = select(4, GetSkillLineInfo(skillIndex));
		skillModifier = select(6, GetSkillLineInfo(skillIndex));
	else
		-- Use this as a backup, just in case something goes wrong
		skillRank, skillModifier = UnitDefense(unit); --Not working properly
	end

	local posBuff = 0;
	local negBuff = 0;
	if ( skillModifier > 0 ) then
		posBuff = skillModifier;
	elseif ( skillModifier < 0 ) then
		negBuff = skillModifier;
	end
	local valueText, tooltipText = CSC_PaperDollFormatStat(DEFENSE_COLON, skillRank, posBuff, negBuff);
	local valueNum = max(0, skillRank + posBuff + negBuff);
	CSC_PaperDollFrame_SetLabelAndText(statFrame, CSC_DEFENSE, valueText, false, valueNum);
	statFrame.tooltip = tooltipText;
	tooltipText = format(DEFAULT_STATDEFENSE_TOOLTIP, valueNum, 0, valueNum*0.04, valueNum*0.04);
	tooltipText = tooltipText:gsub('.-\n', '', 1);
	tooltipText = tooltipText:gsub('%b()', '');
	statFrame.tooltip2 = tooltipText;
	statFrame:Show();
end

function CSC_PaperDollFrame_SetDodge(statFrame, unit)
	local chance = GetDodgeChance();
	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_DODGE, chance, true, chance);
	statFrame.tooltip = format(PAPERDOLLFRAME_TOOLTIP_FORMAT, DODGE_CHANCE).." "..string.format("%.2F", chance).."%";
	--statFrame.tooltip2 = format(CR_DODGE_TOOLTIP, GetCombatRating(CR_DODGE), GetCombatRatingBonus(CR_DODGE));
	statFrame:Show();
end

function CSC_PaperDollFrame_SetParry(statFrame, unit)
	local chance = GetParryChance();
	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_PARRY, chance, true, chance);
	statFrame.tooltip = format(PAPERDOLLFRAME_TOOLTIP_FORMAT, PARRY_CHANCE).." "..string.format("%.2F", chance).."%";
	--statFrame.tooltip2 = format(CR_PARRY_TOOLTIP, GetCombatRating(CR_PARRY), GetCombatRatingBonus(CR_PARRY));
	statFrame:Show();
end

local function CSC_GetBlockValue(unit)
	CSC_ScanTooltip:ClearLines();

	local blockFromShield = 0;
	local offHandIndex = 17;

	local hasItem = CSC_ScanTooltip:SetInventoryItem(unit, offHandIndex);
	if hasItem then
		local maxLines = CSC_ScanTooltip:NumLines();
		for line=1, maxLines do
			local leftText = getglobal(CSC_ScanTooltipPrefix.."TextLeft"..line);
			if leftText:GetText() then
				local valueTxt = string.match(leftText:GetText(), "%d+ "..ITEM_MOD_BLOCK_RATING_SHORT);
				if valueTxt then
					valueTxt = string.match(valueTxt, "%d+");
					if valueTxt then
						local numValue = tonumber(valueTxt);
						if numValue then
							blockFromShield = numValue;
							break;
						end
					end
				end
			end
		end
	end

	local strStatIndex = 1;
	local strength = select(2, UnitStat(unit, strStatIndex));
	local blockValue = blockFromShield + (strength / 20);

	return blockValue;
end

function CSC_PaperDollFrame_SetBlock(statFrame, unit)

	statFrame:SetScript("OnEnter", CSC_CharacterBlock_OnEnter)
	statFrame:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)
	
	local blockChance = GetBlockChance();
	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_BLOCK, blockChance, true, blockChance);

	statFrame.blockChance = string.format("%.2F", blockChance).."%";
	if CharacterStatsClassicDB.useBlizzardBlockValue then
		statFrame.blockValue = GetShieldBlock();
	else
		statFrame.blockValue = CSC_GetBlockValue(unit);
	end

	statFrame:Show();
end

-- SPELL --
function CSC_PaperDollFrame_SetSpellPower(statFrame, unit)

	statFrame:SetScript("OnEnter", CSC_CharacterSpellDamageFrame_OnEnter)
	statFrame:SetScript("OnLeave", function()
		GameTooltip:Hide()
    end)

	local MAX_SPELL_SCHOOLS = 7;
	local holySchool = 2;

	-- Start at 2 to skip physical damage
	local maxSpellDmg = GetSpellBonusDamage(holySchool);
	for i=holySchool, MAX_SPELL_SCHOOLS do
		local bonusDamage = GetSpellBonusDamage(i);
		maxSpellDmg = max(maxSpellDmg, bonusDamage);
	end

	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_SPELLPOWER, BreakUpLargeNumbers(maxSpellDmg), false, maxSpellDmg);
	statFrame.holyDmg = GetSpellBonusDamage(2);
	statFrame.fireDmg = GetSpellBonusDamage(3);
	statFrame.natureDmg = GetSpellBonusDamage(4);
	statFrame.frostDmg = GetSpellBonusDamage(5);
	statFrame.shadowDmg = GetSpellBonusDamage(6);
	statFrame.arcaneDmg = GetSpellBonusDamage(7);
	statFrame:Show();
end

function CSC_PaperDollFrame_SetManaRegen(statFrame, unit)

	if ( not UnitHasMana(unit) ) then
		CSC_PaperDollFrame_SetLabelAndText(statFrame, MANA_REGEN, NOT_APPLICABLE, false, 0);
		statFrame.tooltip = nil;
		statFrame:Show();
		return;
	end

	statFrame:SetScript("OnEnter", CSC_CharacterManaRegenFrame_OnEnter)
	statFrame:SetScript("OnLeave", function()
		GameTooltip:Hide()
    end)

	-- There is a bug in GetManaRegen() so I have to manually calculate mp5
	local base, combat = GetManaRegen();
	local mp5 = CSC_GetMP5FromGear(unit);
	
	-- All mana regen stats are displayed as mana/5 sec.
	base = floor(base * 5.0) + mp5;
	combat = mp5; --floor(combat * 5.0);

	local baseText = BreakUpLargeNumbers(base);
	local combatText = BreakUpLargeNumbers(combat);
	-- Combat mana regen is most important to the player, so we display it as the main value
	CSC_PaperDollFrame_SetLabelAndText(statFrame, MANA_REGEN, combatText, false, combat);
	statFrame.mp5Casting = combatText;
	statFrame.mp5NotCasting = baseText;
	statFrame:Show();
end

function CSC_PaperDollFrame_SetHealing(statFrame, unit)
	local healing = GetSpellBonusHealing();
	local healingText = healing;
	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_SPELLHEALING, healingText, false, healing);
	statFrame.tooltip = STAT_SPELLHEALING.." "..healing;
	statFrame.tooltip2 = STAT_SPELLHEALING_TOOLTIP;
	statFrame:Show();
end

-- OnEnter Tooltip functions
function CSC_CharacterDamageFrame_OnEnter(self)
	-- Main hand weapon
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(self.TooltipMainTxt, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(ATTACK_SPEED_COLON, format("%.2F", self.attackSpeed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(DAMAGE_COLON, self.damage, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(DAMAGE_PER_SECOND, format("%.1F", self.dps), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(ATTACK_TOOLTIP..":", self.attackRating, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	-- Check for offhand weapon
	if ( self.offhandAttackSpeed ) then
		GameTooltip:AddLine(" "); -- Blank line.
		GameTooltip:AddLine(INVTYPE_WEAPONOFFHAND, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddDoubleLine(ATTACK_SPEED_COLON, format("%.2F", self.offhandAttackSpeed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddDoubleLine(DAMAGE_COLON, self.offhandDamage, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddDoubleLine(DAMAGE_PER_SECOND, format("%.1F", self.offhandDps), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end
	GameTooltip:Show();
end

function CSC_CharacterSpellDamageFrame_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(STAT_SPELLPOWER, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(STAT_SPELLPOWER_TOOLTIP);
	GameTooltip:AddLine(" "); -- Blank line.
	GameTooltip:AddDoubleLine(SPELL_SCHOOL1_CAP.." "..DAMAGE..": ", format("%.2F", self.holyDmg), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(SPELL_SCHOOL2_CAP.." "..DAMAGE..": ", format("%.2F", self.fireDmg), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(SPELL_SCHOOL4_CAP.." "..DAMAGE..": ", format("%.2F", self.frostDmg), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(SPELL_SCHOOL6_CAP.." "..DAMAGE..": ", format("%.2F", self.arcaneDmg), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(SPELL_SCHOOL5_CAP.." "..DAMAGE..": ", format("%.2F", self.shadowDmg), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(SPELL_SCHOOL3_CAP.." "..DAMAGE..": ", format("%.2F", self.natureDmg), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:Show();
end

function CSC_CharacterSpellCritFrame_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(STAT_CRITICAL_STRIKE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddLine(" "); -- Blank line.
	GameTooltip:AddDoubleLine(SPELL_SCHOOL1_CAP.." "..CRIT_ABBR..": ", format("%.2F", self.holyCrit).."%", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(SPELL_SCHOOL2_CAP.." "..CRIT_ABBR..": ", format("%.2F", self.fireCrit).."%", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(SPELL_SCHOOL4_CAP.." "..CRIT_ABBR..": ", format("%.2F", self.frostCrit).."%", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(SPELL_SCHOOL6_CAP.." "..CRIT_ABBR..": ", format("%.2F", self.arcaneCrit).."%", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(SPELL_SCHOOL5_CAP.." "..CRIT_ABBR..": ", format("%.2F", self.shadowCrit).."%", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(SPELL_SCHOOL3_CAP.." "..CRIT_ABBR..": ", format("%.2F", self.natureCrit).."%", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:Show();
end

function CSC_CharacterManaRegenFrame_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(MANA_REGEN_TOOLTIP, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine("!!! Currently detects MP5 from gear only !!!", "", 1, 0, 0);
	GameTooltip:AddLine(" "); -- Blank line.
	GameTooltip:AddDoubleLine(MANA_REGEN.." (While Casting):", self.mp5Casting);
	GameTooltip:AddDoubleLine(MANA_REGEN.." (While Not Casting):", self.mp5NotCasting);
	GameTooltip:Show();
end

function CSC_CharacterBlock_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(" ", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(BLOCK_CHANCE..": ", self.blockChance);
	GameTooltip:AddDoubleLine(ITEM_MOD_BLOCK_VALUE_SHORT..": ", self.blockValue);
	GameTooltip:Show();
end

function CSC_CharacterHitChanceFrame_OnEnter(self)
	local hitChance = self.hitChance;

	local missChanceVsNPC, missChanceVsBoss, missChanceVsPlayer, dwMissChanceVsNpc, dwMissChanceVsBoss, dwMissChanceVsPlayer = CSC_GetPlayerMissChances("player", hitChance);

	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(STAT_HIT_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddLine("Reduces your chance to miss.");

	GameTooltip:AddLine(" "); -- Blank line.
	GameTooltip:AddLine("Miss Chance vs.");
	GameTooltip:AddDoubleLine(format("    Level 60 NPC: %.2F%%", missChanceVsNPC), format("(Dual wield: %.2F%%)", dwMissChanceVsNpc));
	GameTooltip:AddDoubleLine(format("    Level 60 Player: %.2F%%", missChanceVsPlayer), format("(Dual wield: %.2F%%)", dwMissChanceVsPlayer));
	GameTooltip:AddDoubleLine(format("    Level 63 NPC/Boss: %.2F%%", missChanceVsBoss), format("(Dual wield: %.2F%%)", dwMissChanceVsBoss));
	GameTooltip:Show();
end
-- OnEnter Tooltip functions END
