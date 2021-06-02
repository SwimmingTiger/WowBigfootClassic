--[[
    Util functions that wrap my interface and the Blizzard's WoW Classic lua API code for ease of use
]]

local CSC_ScanTooltip = CreateFrame("GameTooltip", "CSC_ScanTooltip", nil, "GameTooltipTemplate");
CSC_ScanTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
local CSC_ScanTooltipPrefix = "CSC_ScanTooltip";

local g_lastSeenBaseManaRegen = 0;
local g_lastSeenCastingManaRegen = 0;
g_APFromADItems = 0;

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

	local unitClassId = select(3, UnitClass(unit));
	if (unitClassId == CSC_PRIEST_CLASS_ID) then
		local zgEnchantMp5 = CSC_GetMp5FromPriestZGEnchants(unit);
		if (zgEnchantMp5 > 0) then
			mp5 = mp5 + zgEnchantMp5;
		end
	end

	if (CSC_HasEnchant(unit, INVSLOT_WRIST, 2565)) then -- Mana Regen
		mp5 = mp5 + 4;
	end

	if (CSC_HasEnchant(unit, INVSLOT_SHOULDER, 2715)) then -- Resilience of the Scourge
		mp5 = mp5 + 5;
	end

	local tempMHEnchantId = select(4, GetWeaponEnchantInfo());
	if (tempMHEnchantId == 2629) then -- Brilliant Mana Oil
		mp5 = mp5 + 12;
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

function CSC_GetPlayerWeaponSkill(unit, weaponSlotId)
	local totalWeaponSkill = nil;

	local unitClassId = select(3, UnitClass(unit));
	-- Druid checks
	local shapeIndex = -1;
	if (unitClassId == CSC_DRUID_CLASS_ID) then
		shapeIndex = CSC_GetShapeshiftForm();
	end

	if (unitClassId == CSC_DRUID_CLASS_ID) and (shapeIndex > 0) then
		totalWeaponSkill = UnitLevel(unit) * 5;
	else
		local itemId = GetInventoryItemID(unit, weaponSlotId);
		if (itemId) then
			local itemSubtypeId = select(7, GetItemInfoInstant(itemId));
			if itemSubtypeId then
				local weaponString = g_WeaponStringByWeaponId[itemSubtypeId];
				if weaponString then
					local skillRank, skillModifier = CSC_GetSkillRankAndModifier(CSC_WEAPON_SKILLS_HEADER, weaponString);
					if skillRank and skillModifier then
						-- Weapon skill from racials should be already in skillRank
						totalWeaponSkill = skillRank + skillModifier;
					end
				end
			end
		end
	end

	return totalWeaponSkill;
end

function CSC_GetPlayerMissChances(unit, playerHitChance)
	local missChanceVsNPC = 5;
	local missChanceVsBoss = 9;
	local missChanceVsPlayer = 5;
	
	local hitChance = playerHitChance;
	local level = UnitLevel(unit);
	local bossLevel = 73;
	local playerWeaponSkill = level * 5;
	local bossDefense = bossLevel * 5;

	-- Boss (level 73)
	if (bossDefense - playerWeaponSkill >= 11) then
		missChanceVsBoss = 5 + (bossDefense - playerWeaponSkill) * 0.2;
	end
	if (bossDefense - playerWeaponSkill <= 10) then
		missChanceVsBoss = 5 + (bossDefense - playerWeaponSkill) * 0.1;
	end

	local dwMissChanceVsNpc = math.max(missChanceVsNPC + 19 - hitChance);
	local dwMissChanceVsBoss = math.max(missChanceVsBoss + 19 - hitChance);
	local dwMissChanceVsPlayer = math.max(missChanceVsPlayer + 19 - hitChance);

	missChanceVsNPC = math.max(0, missChanceVsNPC - hitChance);
	missChanceVsBoss = math.max(0, missChanceVsBoss - hitChance);
	missChanceVsPlayer = math.max(0, missChanceVsPlayer - hitChance);

	return missChanceVsNPC, missChanceVsBoss, missChanceVsPlayer, dwMissChanceVsNpc, dwMissChanceVsBoss, dwMissChanceVsPlayer;
end

function CSC_GetPlayerCritCap(unit, ratingIndex)
	local hitChance = GetHitModifier();
	
	if not hitChance then
		hitChance = 0;
	end

	local hitRatingBonus = GetCombatRatingBonus(ratingIndex); -- hit rating in % (hit chance) (from gear sources, doesn't seem to include talents);
	local totalHit = hitChance + hitRatingBonus;
	local missChanceVsNPC, missChanceVsBoss, missChanceVsPlayer, dwMissChanceVsNpc, dwMissChanceVsBoss, dwMissChanceVsPlayer = CSC_GetPlayerMissChances(unit, totalHit);
	
	local playerWeaponSkill = UnitLevel(unit) * 5;
	local bossDefense = 73 * 5;
	local critSuppression = 4.8;
	local dodgeChance = 5 + (bossDefense - playerWeaponSkill) * 0,1;
	local glancingChance = math.max(0, 6 + (bossDefense - playerWeaponSkill) * 1.2);

	local critCap = 100 - missChanceVsBoss - dodgeChance - glancingChance + critSuppression;
	local dwCritCap = 100 - dwMissChanceVsBoss - dodgeChance - glancingChance + critSuppression;

	return critCap, dwCritCap;
end

function CSC_GetAttackPowerFromArgentDawnItems(unit)
	local chestId = GetInventoryItemID(unit, INVSLOT_CHEST);
	local glovesId = GetInventoryItemID(unit, INVSLOT_HAND);
	local bracerId = GetInventoryItemID(unit, INVSLOT_WRIST);
	local trinketFirst = GetInventoryItemID(unit, INVSLOT_TRINKET1);
	local trinketSecond = GetInventoryItemID(unit, INVSLOT_TRINKET2);

	local apVsUndead = 0;
	
	if (g_ArgentDawnAPItems[chestId] ~= nil) then
		apVsUndead = apVsUndead + g_ArgentDawnAPItems[chestId];
	end

	if (g_ArgentDawnAPItems[glovesId] ~= nil) then
		apVsUndead = apVsUndead + g_ArgentDawnAPItems[glovesId];
	end

	if (g_ArgentDawnAPItems[bracerId] ~= nil) then
		apVsUndead = apVsUndead + g_ArgentDawnAPItems[bracerId];
	end

	if (g_ArgentDawnAPItems[trinketFirst] ~= nil) then
		apVsUndead = apVsUndead + g_ArgentDawnAPItems[trinketFirst];
	end

	if (g_ArgentDawnAPItems[trinketSecond] ~= nil) then
		apVsUndead = apVsUndead + g_ArgentDawnAPItems[trinketSecond];
	end

	local tempMHEnchantId = select(4, GetWeaponEnchantInfo());
	if (tempMHEnchantId == 2684) then -- Consecrated Sharpening Stone
		apVsUndead = apVsUndead + 100;
	end

	local tempOHEnchantId = select(8, GetWeaponEnchantInfo());
	if (tempOHEnchantId == 2684) then -- Consecrated Sharpening Stone
		apVsUndead = apVsUndead + 100;
	end

	return apVsUndead;
end

function CSC_GetSpellkPowerFromArgentDawnItems(unit)
	local chestId = GetInventoryItemID(unit, INVSLOT_CHEST);
	local glovesId = GetInventoryItemID(unit, INVSLOT_HAND);
	local bracerId = GetInventoryItemID(unit, INVSLOT_WRIST);
	local trinketFirst = GetInventoryItemID(unit, INVSLOT_TRINKET1);
	local trinketSecond = GetInventoryItemID(unit, INVSLOT_TRINKET2);

	local spVsUndead = 0;
	
	if (g_ArgentDawnSPItems[chestId] ~= nil) then
		spVsUndead = spVsUndead + g_ArgentDawnSPItems[chestId];
	end

	if (g_ArgentDawnSPItems[glovesId] ~= nil) then
		spVsUndead = spVsUndead + g_ArgentDawnSPItems[glovesId];
	end

	if (g_ArgentDawnSPItems[bracerId] ~= nil) then
		spVsUndead = spVsUndead + g_ArgentDawnSPItems[bracerId];
	end

	if (g_ArgentDawnSPItems[trinketFirst] ~= nil) then
		spVsUndead = spVsUndead + g_ArgentDawnSPItems[trinketFirst];
	end

	if (g_ArgentDawnSPItems[trinketSecond] ~= nil) then
		spVsUndead = spVsUndead + g_ArgentDawnSPItems[trinketSecond];
	end

	local tempMHEnchantId = select(4, GetWeaponEnchantInfo());
	if (tempMHEnchantId == 2685) then -- Blessed Wizard Oil
		spVsUndead = spVsUndead + 60;
	end

	local tempOHEnchantId = select(8, GetWeaponEnchantInfo());
	if (tempOHEnchantId == 2685) then -- Blessed Wizard Oil
		spVsUndead = spVsUndead + 60;
	end

	return spVsUndead;
end

function CSC_CacheAPFromADItems(unit)
	g_APFromADItems = CSC_GetAttackPowerFromArgentDawnItems(unit);
end

function CSC_GetDefense(unit)
	local numSkills = GetNumSkillLines();
	local skillIndex = 0;
	local currentHeader = nil;
	local playerLevel = UnitLevel(unit);

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

	return skillRank, skillModifier, playerLevel;
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
		
		local statIndex = i;
		local frameText;
		local stat;
		local effectiveStat;
		local posBuff;
		local negBuff;
		stat, effectiveStat, posBuff, negBuff = UnitStat(unit, statIndex);
		local statName = getglobal("SPELL_STAT"..statIndex.."_NAME");
		
		-- Set the tooltip text
		local tooltipText = HIGHLIGHT_FONT_COLOR_CODE..statName.." ";

		if ( ( posBuff == 0 ) and ( negBuff == 0 ) ) then
			frameText = effectiveStat;
			statFrames[statIndex].tooltip = tooltipText..effectiveStat..FONT_COLOR_CODE_CLOSE;
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
			statFrames[statIndex].tooltip = tooltipText;

			-- If there are any negative buffs then show the main number in red even if there are
			-- positive buffs. Otherwise show in green.
			if ( negBuff < 0 ) then
				frameText = RED_FONT_COLOR_CODE..effectiveStat..FONT_COLOR_CODE_CLOSE;
			else
				frameText = GREEN_FONT_COLOR_CODE..effectiveStat..FONT_COLOR_CODE_CLOSE;
			end
		end

		statFrames[statIndex].tooltip2 = getglobal("DEFAULT_STAT"..statIndex.."_TOOLTIP");

		if ( statIndex == 1 ) then
			local attackPower = GetAttackPowerForStat(statIndex,effectiveStat);
			statFrames[statIndex].tooltip2 = format(statFrames[statIndex].tooltip2, attackPower);

			local unitClassId = select(3, UnitClass(unit));
			if ( unitClassId == CSC_WARRIOR_CLASS_ID or unitClassId == CSC_SHAMAN_CLASS_ID or unitClassId == CSC_PALADIN_CLASS_ID ) then
				statFrames[statIndex].tooltip2 = statFrames[statIndex].tooltip2 .. "\n" .. format( STAT_BLOCK_TOOLTIP, effectiveStat*BLOCK_PER_STRENGTH );
			end
		elseif ( statIndex == 3 ) then
			local baseStam = min(20, effectiveStat);
			local moreStam = effectiveStat - baseStam;
			statFrames[statIndex].tooltip2 = format(statFrames[statIndex].tooltip2, (baseStam + (moreStam*HEALTH_PER_STAMINA))*GetUnitMaxHealthModifier(unit));
			local petStam = ComputePetBonus("PET_BONUS_STAM", effectiveStat );
			if( petStam > 0 ) then
				statFrames[statIndex].tooltip2 = statFrames[statIndex].tooltip2 .. "\n" .. format(PET_BONUS_TOOLTIP_STAMINA,petStam);
			end
		elseif ( statIndex == 2 ) then
			local attackPower = GetAttackPowerForStat(statIndex,effectiveStat);
			if ( attackPower > 0 ) then
				statFrames[statIndex].tooltip2 = format(STAT_ATTACK_POWER, attackPower) .. format(statFrames[statIndex].tooltip2, GetCritChanceFromAgility(unit), effectiveStat*ARMOR_PER_AGILITY);
			else
				statFrames[statIndex].tooltip2 = format(statFrames[statIndex].tooltip2, GetCritChanceFromAgility(unit), effectiveStat*ARMOR_PER_AGILITY);
			end
		elseif ( statIndex == 4 ) then
			local baseInt = min(20, effectiveStat);
			local moreInt = effectiveStat - baseInt
			if ( UnitHasMana(unit) ) then
				statFrames[statIndex].tooltip2 = format(statFrames[statIndex].tooltip2, baseInt + moreInt*MANA_PER_INTELLECT, GetSpellCritChanceFromIntellect(unit));
			else
				statFrames[statIndex].tooltip2 = nil;
			end
			local petInt = ComputePetBonus("PET_BONUS_INT", effectiveStat );
			if( petInt > 0 ) then
				if ( not statFrames[statIndex].tooltip2 ) then
					statFrames[statIndex].tooltip2 = "";
				end
				statFrames[statIndex].tooltip2 = statFrames[statIndex].tooltip2 .. "\n" .. format(PET_BONUS_TOOLTIP_INTELLECT,petInt);
			end
		elseif ( statIndex == 5 ) then
			-- All mana regen stats are displayed as mana/5 sec.
			statFrames[statIndex].tooltip2 = format(statFrames[statIndex].tooltip2, GetUnitHealthRegenRateFromSpirit(unit));
			if ( UnitHasMana(unit) ) then
				local regen = GetUnitManaRegenRateFromSpirit(unit);
				regen = floor( regen * 5.0 );
				statFrames[statIndex].tooltip2 = statFrames[statIndex].tooltip2.."\n"..format(MANA_REGEN_FROM_SPIRIT, regen);
			end
		end

		CSC_PaperDollFrame_SetLabelAndText(statFrames[i], statName, frameText, false);
	end
end

-- DAMAGE --
function CSC_PaperDollFrame_SetDamage(statFrame, unit, category)

	if (category == PLAYERSTAT_RANGED_COMBAT) and not IsRangedWeapon() then
		CSC_PaperDollFrame_SetLabelAndText(statFrame, DAMAGE, NOT_APPLICABLE, false);
		return;
	end

    statFrame:SetScript("OnEnter", CSC_CharacterDamageFrame_OnEnter)
	statFrame:SetScript("OnLeave", function()
		GameTooltip:Hide()
    end)

    local speed, offhandSpeed = CSC_GetAppropriateAttackSpeed(unit, category);
	local minDamage, maxDamage, minOffHandDamage, maxOffHandDamage, physicalBonusPos, physicalBonusNeg, percentMod = CSC_GetAppropriateDamage(unit, category);
	
	-- sometimes this is wrongly reported as 0
	if percentMod == nil or percentMod == 0 then
		percentMod = 1;
	end

	if speed == nil or speed == 0 then
		speed = 1;
	end

	if (UISettingsCharacter.showStatsFromArgentDawnItems) then
		local bonusDPS = g_APFromADItems / ATTACK_POWER_MAGIC_NUMBER;
		local bonusDmgMainHand = speed * bonusDPS;
		minDamage = minDamage + bonusDmgMainHand;
		maxDamage = maxDamage + bonusDmgMainHand;
	end
    
    local displayMin = max(floor(minDamage),1);
	local displayMax = max(ceil(maxDamage),1);
    
    minDamage = (minDamage / percentMod) - physicalBonusPos - physicalBonusNeg;
	maxDamage = (maxDamage / percentMod) - physicalBonusPos - physicalBonusNeg;
	
    local baseDamage = (minDamage + maxDamage) * 0.5;
	local fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percentMod;
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
		if ( percentMod > 1 ) then
			damageTooltip = damageTooltip..colorPos.." x"..floor(percentMod*100+0.5).."%|r";
		elseif ( percentMod < 1 ) then
			damageTooltip = damageTooltip..colorNeg.." x"..floor(percentMod*100+0.5).."%|r";
		end
    end
    
    CSC_PaperDollFrame_SetLabelAndText(statFrame, DAMAGE, damageText, false);

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
		if offhandSpeed == 0 then
			offhandSpeed = 1;
		end

		if (UISettingsCharacter.showStatsFromArgentDawnItems) then
			local bonusDPS = g_APFromADItems / ATTACK_POWER_MAGIC_NUMBER;
			local bonusDmgOffHand = offhandSpeed * bonusDPS;
			minOffHandDamage = minOffHandDamage + bonusDmgOffHand;
			maxOffHandDamage = maxOffHandDamage + bonusDmgOffHand;
		end

		minOffHandDamage = (minOffHandDamage / percentMod) - physicalBonusPos - physicalBonusNeg;
		maxOffHandDamage = (maxOffHandDamage / percentMod) - physicalBonusPos - physicalBonusNeg;

		local offhandBaseDamage = (minOffHandDamage + maxOffHandDamage) * 0.5;
		local offhandFullDamage = (offhandBaseDamage + physicalBonusPos + physicalBonusNeg) * percentMod;
		local offhandDamagePerSecond = (max(offhandFullDamage,1) / offhandSpeed);
		local offhandDamageTooltip = max(floor(minOffHandDamage),1).." - "..max(ceil(maxOffHandDamage),1);
		if ( physicalBonusPos > 0 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorPos.." +"..physicalBonusPos.."|r";
		end
		if ( physicalBonusNeg < 0 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorNeg.." "..physicalBonusNeg.."|r";
		end
		if ( percentMod > 1 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorPos.." x"..floor(percentMod*100+0.5).."%|r";
		elseif ( percentMod < 1 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorNeg.." x"..floor(percentMod*100+0.5).."%|r";
		end
		statFrame.offhandDamage = offhandDamageTooltip;
		statFrame.offhandAttackSpeed = offhandSpeed;
		statFrame.offhandDps = offhandDamagePerSecond;
	else
		statFrame.offhandAttackSpeed = nil;
    end
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

	CSC_PaperDollFrame_SetLabelAndText(statFrame, DAMAGE, attackText, false);

	statFrame.tooltip = ATTACK_TOOLTIP;
	statFrame.tooltip2 = ATTACK_TOOLTIP_SUBTEXT;
end

function CSC_PaperDollFrame_SetMeleeAttackPower(statFrame, unit)
    
	local base, posBuff, negBuff = UnitAttackPower(unit);

	if (UISettingsCharacter.showStatsFromArgentDawnItems) then
		posBuff = posBuff + g_APFromADItems;
	end
    
    local valueText, tooltipText = CSC_PaperDollFormatStat(MELEE_ATTACK_POWER, base, posBuff, negBuff);
    local valueNum = max(0, base + posBuff + negBuff);
    CSC_PaperDollFrame_SetLabelAndText(statFrame, ATTACK_POWER, valueText, false);
    statFrame.tooltip = tooltipText;
	statFrame.tooltip2 = format(MELEE_ATTACK_POWER_TOOLTIP, max((base+posBuff+negBuff), 0)/ATTACK_POWER_MAGIC_NUMBER);
end

function CSC_PaperDollFrame_SetRangedAttackPower(statFrame, unit)
	
	if not IsRangedWeapon() then
		CSC_PaperDollFrame_SetLabelAndText(statFrame, ATTACK_POWER, NOT_APPLICABLE, false);
		return;
	end

	if ( HasWandEquipped() ) then
		CSC_PaperDollFrame_SetLabelAndText(statFrame, ATTACK_POWER, NOT_APPLICABLE, false);
		statFrame.tooltip = nil;
		return;
	end

	local base, posBuff, negBuff = UnitRangedAttackPower(unit);

	if (UISettingsCharacter.showStatsFromArgentDawnItems) then
		posBuff = posBuff + g_APFromADItems;
	end
	
    local valueText, tooltipText = CSC_PaperDollFormatStat(RANGED_ATTACK_POWER, base, posBuff, negBuff);
    local valueNum = max(0, base + posBuff + negBuff);
    CSC_PaperDollFrame_SetLabelAndText(statFrame, ATTACK_POWER, valueText, false);
	statFrame.tooltip = tooltipText;
    statFrame.tooltip2 = format(RANGED_ATTACK_POWER_TOOLTIP, valueNum/ATTACK_POWER_MAGIC_NUMBER);
end

-- SECONDARY STATS --
function CSC_PaperDollFrame_SetCritChance(statFrame, unit)
	
	statFrame:SetScript("OnEnter", CSC_CharacterMeleeCritFrame_OnEnter)
	statFrame:SetScript("OnLeave", function()
		GameTooltip:Hide()
    end)
	
	local critChance = GetCritChance();

	CSC_PaperDollFrame_SetLabelAndText(statFrame, MELEE_CRIT_CHANCE, critChance, true);
	statFrame.critChance = critChance;
	statFrame.unit = unit;
end

function CSC_PaperDollFrame_SetRangedCritChance(statFrame, unit)

	if not IsRangedWeapon() then
		CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_CRITICAL_STRIKE, NOT_APPLICABLE, false);
		return;
	end

	statFrame:SetScript("OnEnter", CSC_CharacterRangedCritFrame_OnEnter)
	statFrame:SetScript("OnLeave", function()
		GameTooltip:Hide()
    end)

	local critChance = GetRangedCritChance();
	statFrame.critChance = critChance;
	statFrame.unit = unit;

	CSC_PaperDollFrame_SetLabelAndText(statFrame, RANGED_CRIT_CHANCE, critChance, true);
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

	local unitClassId = select(3, UnitClass(unit));
	if (unitClassId == CSC_PRIEST_CLASS_ID) then
		local priestHolyCrit = CSC_GetPriestCritStatsFromTalents();
		priestHolyCrit = priestHolyCrit + CSC_GetHolyCritFromBenediction(unit);
		
		if (priestHolyCrit > 0) then
			statFrame.holyCrit = statFrame.holyCrit + priestHolyCrit;
			-- set the new maximum
			maxSpellCrit = max(maxSpellCrit, statFrame.holyCrit);
		end
	elseif (unitClassId == CSC_WARLOCK_CLASS_ID) then
		local destructionCrit = CSC_GetWarlockCritStatsFromTalents();
		if (destructionCrit > 0) then
			statFrame.shadowCrit = statFrame.shadowCrit + destructionCrit;
			statFrame.fireCrit = statFrame.fireCrit + destructionCrit;
			local tmpMax = max(statFrame.shadowCrit, statFrame.fireCrit);
			-- set the new maximum
			maxSpellCrit = max(maxSpellCrit, tmpMax);
		end
	elseif (unitClassId == CSC_SHAMAN_CLASS_ID) then
		statFrame.lightningCrit = statFrame.natureCrit;
		
		local callOfThunderCrit = CSC_GetShamanCallOfThunderCrit();
		if callOfThunderCrit > 0 then
			statFrame.lightningCrit = statFrame.lightningCrit + callOfThunderCrit;
		end

		local tidalMastery = CSC_GetShamanTidalMasteryCrit();
		if tidalMastery > 0 then
			statFrame.lightningCrit = statFrame.lightningCrit + tidalMastery;
			statFrame.natureCrit = statFrame.natureCrit + tidalMastery;
		end

		local tmpMax = max(statFrame.lightningCrit, statFrame.natureCrit);
		-- set the new maximum
		maxSpellCrit = max(maxSpellCrit, tmpMax);
	end
	statFrame.unitClassId = unitClassId;

	CSC_PaperDollFrame_SetLabelAndText(statFrame, SPELL_CRIT_CHANCE, maxSpellCrit, true);
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
	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_HIT_CHANCE, hitChanceText, true);
	statFrame.hitChance = hitChance;
end

function CSC_PaperDollFrame_SetHitRating(statFrame, unit, ratingIndex)

	statFrame:SetScript("OnEnter", CSC_CharacterHitRatingFrame_OnEnter)
	statFrame:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)

	local statName = getglobal("COMBAT_RATING_NAME"..ratingIndex);
	local rating = GetCombatRating(ratingIndex);
	local ratingBonus = GetCombatRatingBonus(ratingIndex); -- hit rating in % (hit chance) (from gear sources, doesn't seem to include talents)

	if ( ratingIndex == CR_HIT_MELEE ) then
		local hitChance = GetHitModifier(); -- includes talents, doesn't include hit raiting from gear
		local combatRatingMult = CSC_GetCombatRatingPerUnitBonus(unit, CSC_COMBAT_RATING_HIT);

		if not hitChance then
			hitChance = 0;
		end
		
		ratingBonus = ratingBonus + hitChance;
		rating = rating + (combatRatingMult*hitChance);
	elseif ( ratingIndex == CR_HIT_SPELL ) then
		local spellHitChance = GetSpellHitModifier();
		local combatRatingMult = CSC_GetCombatRatingPerUnitBonus(unit, CSC_COMBAT_RATING_SPELL_HIT);

		if not spellHitChance then
			spellHitChance = 0;
		end

		spellHitChance = spellHitChance / 7; -- BUG ON BLIZZARD's side. returns 7 for each 1% hit. Dirty fix for now
		
		ratingBonus = ratingBonus + spellHitChance;
		statFrame.spellHitGearTalents = ratingBonus;
		rating = rating + (combatRatingMult*spellHitChance);
	end

	rating = format("%.2f", rating);

	statFrame.unit = unit;
	statFrame.ratingIndex = ratingIndex;
	statFrame.statName = statName;
	statFrame.rating = rating;
	statFrame.ratingBonus = ratingBonus;
	CSC_PaperDollFrame_SetLabelAndText(statFrame, statName, rating);
end

function CSC_PaperDollFrame_SetExpertise(statFrame, unit)
	
	local expertise, offhandExpertise = GetExpertise();
	local speed, offhandSpeed = UnitAttackSpeed(unit);
	local text;
	if( offhandSpeed ) then
		text = expertise.." / "..offhandExpertise;
	else
		text = expertise;
	end
	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_EXPERTISE, text);
	
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..getglobal("COMBAT_RATING_NAME"..CR_EXPERTISE).." "..text..FONT_COLOR_CODE_CLOSE;
	
	local expertisePercent, offhandExpertisePercent = GetExpertisePercent();
	expertisePercent = format("%.2f", expertisePercent);
	if( offhandSpeed ) then
		offhandExpertisePercent = format("%.2f", offhandExpertisePercent);
		text = expertisePercent.."% / "..offhandExpertisePercent.."%";
	else
		text = expertisePercent.."%";
	end
	statFrame.tooltip2 = format(CR_EXPERTISE_TOOLTIP, text, GetCombatRating(CR_EXPERTISE), GetCombatRatingBonus(CR_EXPERTISE));
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
				hitFromScope = 3;
			end
		end
	end

	return hitFromScope;
end

function CSC_PaperDollFrame_SetRangedHitChance(statFrame, unit)
	
	if not IsRangedWeapon() then
		CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_HIT_CHANCE, NOT_APPLICABLE, false);
		return;
	end

	statFrame:SetScript("OnEnter", CSC_CharacterRangedHitChanceFrame_OnEnter)
	statFrame:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)
	
	local hitChance = GetHitModifier();
	
	if not hitChance then
		hitChance = 0;
	end

	local hitFromScope = CSC_GetHitFromBiznicksAccurascope(unit);
	if (hitFromScope > 0) then
		hitChance = hitChance + hitFromScope;
	end

	local hitChanceText = hitChance;
	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_HIT_CHANCE, hitChanceText, true);
	statFrame.hitChance = hitChance;
end

function CSC_PaperDollFrame_SetSpellHitChance(statFrame, unit)
	
	statFrame:SetScript("OnEnter", CSC_CharacterSpellHitChanceFrame_OnEnter)
	statFrame:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)

	local hitChance = GetSpellHitModifier();
	
	if not hitChance then
		hitChance = 0;
	end

	local unitClassId = select(3, UnitClass(unit));

	if unitClassId == CSC_MAGE_CLASS_ID then
		local arcaneHit, frostFireHit = CSC_GetMageSpellHitFromTalents();
		statFrame.arcaneHit = arcaneHit;
		statFrame.frostHit = frostFireHit;
		statFrame.fireHit = frostFireHit;
	elseif unitClassId == CSC_WARLOCK_CLASS_ID then
		statFrame.afflictionHit = CSC_GetWarlockSpellHitFromTalents();
	end

	local hitChanceText = hitChance;
	statFrame.hitChance = hitChance;
	statFrame.unitClassId = unitClassId;
	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_HIT_CHANCE, hitChanceText, true);
end

function CSC_PaperDollFrame_SetAttackSpeed(statFrame, unit)
	local speed, offhandSpeed = UnitAttackSpeed(unit);

	local displaySpeed = format("%.2F", speed);
	if ( offhandSpeed ) then
		offhandSpeed = format("%.2F", offhandSpeed);
	end
	if ( offhandSpeed ) then
		displaySpeed =  displaySpeed.." / ".. offhandSpeed;
	else
		displaySpeed =  displaySpeed;
	end

	CSC_PaperDollFrame_SetLabelAndText(statFrame, WEAPON_SPEED, displaySpeed, false);
	statFrame.tooltip = format(PAPERDOLLFRAME_TOOLTIP_FORMAT, ATTACK_SPEED).." "..displaySpeed;
	statFrame.tooltip2 = format(CR_HASTE_RATING_TOOLTIP, GetCombatRating(CR_HASTE_MELEE), GetCombatRatingBonus(CR_HASTE_MELEE));
end

function CSC_PaperDollFrame_SetRangedAttackSpeed(statFrame, unit)
	
	if not IsRangedWeapon() then
		CSC_PaperDollFrame_SetLabelAndText(statFrame, WEAPON_SPEED, NOT_APPLICABLE, false);
		return;
	end

	local attackSpeed, minDamage, maxDamage, bonusPos, bonusNeg, percent = UnitRangedDamage(unit);
	local displaySpeed = format("%.2F", attackSpeed);

	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..ATTACK_SPEED.." "..displaySpeed..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(CR_HASTE_RATING_TOOLTIP, GetCombatRating(CR_HASTE_RANGED), GetCombatRatingBonus(CR_HASTE_RANGED));
	CSC_PaperDollFrame_SetLabelAndText(statFrame, WEAPON_SPEED, displaySpeed, false);
end

-- DEFENSES --
function CSC_PaperDollFrame_GetArmorReduction(armor, attackerLevel)
	local levelModifier = attackerLevel;
	if ( levelModifier > 59 ) then
		levelModifier = levelModifier + (4.5 * (levelModifier-59));
	end
	local temp = 0.1*armor/(8.5*levelModifier + 40);
	temp = temp/(1+temp);

	if ( temp > 0.75 ) then
		return 75;
	end

	if ( temp < 0 ) then
		return 0;
	end

	return format("%.2f", (temp*100));
end

function CSC_PaperDollFrame_SetArmor(statFrame, unit)

	local base, effectiveArmor, armor, posBuff, negBuff = UnitArmor(unit);
	local armorReduction = PaperDollFrame_GetArmorReduction(effectiveArmor, UnitLevel(unit));

	local valueText, tooltipText = CSC_PaperDollFormatStat(ARMOR, base, posBuff, negBuff);
	local valueNum = max(0, base + posBuff + negBuff);

	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_ARMOR, valueText, false);
	statFrame.tooltip = tooltipText;
	statFrame.tooltip2 = format(DEFAULT_STATARMOR_TOOLTIP, armorReduction);
	
	local petBonus = ComputePetBonus("PET_BONUS_ARMOR", effectiveArmor );
	if( petBonus > 0 ) then
		statFrame.tooltip2 = statFrame.tooltip2 .. "\n" .. format(PET_BONUS_TOOLTIP_ARMOR, petBonus);
	end
end

function CSC_PaperDollFrame_SetDefense(statFrame, unit)

	statFrame:SetScript("OnEnter", CSC_CharacterDefenseFrame_OnEnter)
	statFrame:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)

	local base, modifier = UnitDefense(unit);

	local posBuff = 0;
	local negBuff = 0;
	local posBuff = 0;
	local negBuff = 0;

	if ( modifier > 0 ) then
		posBuff = modifier;
	elseif ( modifier < 0 ) then
		negBuff = modifier;
	end

	local valueText, defenseText = CSC_PaperDollFormatStat(DEFENSE, base, posBuff, negBuff);
	local valueNum = max(0, base + posBuff + negBuff);
	statFrame.defense = defenseText;
	CSC_PaperDollFrame_SetLabelAndText(statFrame, CSC_DEFENSE, valueText, false);
end

function CSC_PaperDollFrame_SetDodge(statFrame)
	local chance = GetDodgeChance();
	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_DODGE, chance, true);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..getglobal("DODGE_CHANCE").." "..string.format("%.02f", chance).."%"..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(CR_DODGE_TOOLTIP, GetCombatRating(CR_DODGE), GetCombatRatingBonus(CR_DODGE));
end

function CSC_PaperDollFrame_SetParry(statFrame)
	local chance = GetParryChance();
	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_PARRY, chance, true);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..getglobal("PARRY_CHANCE").." "..string.format("%.02f", chance).."%"..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(CR_PARRY_TOOLTIP, GetCombatRating(CR_PARRY), GetCombatRatingBonus(CR_PARRY));
end

function CSC_GetBlockValue(unit)
	CSC_ScanTooltip:ClearLines();

	local blockValueFromItems = 0;
	local firstItemslotIndex = 1;
	local lastItemslotIndex = 18;

	local blockValueIDs = { ITEM_MOD_BLOCK_RATING_SHORT, ITEM_MOD_BLOCK_RATING, ITEM_MOD_BLOCK_VALUE };
	local equippedMightSetItems = 0;

	for itemslot=firstItemslotIndex, lastItemslotIndex do
		local hasItem = CSC_ScanTooltip:SetInventoryItem(unit, itemslot);
		if hasItem then
			local itemId = GetInventoryItemID(unit, itemslot);
			if (itemId == g_BattlegearOfMightIds[itemId]) then
				equippedMightSetItems = equippedMightSetItems + 1;
			else
				local maxLines = CSC_ScanTooltip:NumLines();
				for line=1, maxLines do
					local leftText = getglobal(CSC_ScanTooltipPrefix.."TextLeft"..line);
					if leftText:GetText() then
						for blockValueID=1, 3 do
							local valueTxt = string.match(leftText:GetText(), "%d+ "..blockValueIDs[blockValueID]);
							if not valueTxt then
								valueTxt = string.match(leftText:GetText(), string.sub( blockValueIDs[blockValueID], 1, -5).." %d+");
							end
							if valueTxt then
								valueTxt = string.match(valueTxt, "%d+");
								if valueTxt then
									local numValue = tonumber(valueTxt);
									if numValue then
										blockValueFromItems = blockValueFromItems + numValue;
									end
								end
							end
						end
					end
				end
			end
		end
	end

	local strStatIndex = 1;
	local strength = select(2, UnitStat(unit, strStatIndex));
	local blockValue = blockValueFromItems + (strength / 20);
	
	local requiredMightSetItems = 3;
	if (equippedMightSetItems >= requiredMightSetItems) then
		blockValue = blockValue + 30; -- Set bonus reached
	end

	return blockValue;
end

function CSC_PaperDollFrame_SetBlock(statFrame, unit)

	statFrame:SetScript("OnEnter", CSC_CharacterBlock_OnEnter)
	statFrame:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)
	
	local blockChance = GetBlockChance();
	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_BLOCK, blockChance, true);

	statFrame.blockChance = HIGHLIGHT_FONT_COLOR_CODE..getglobal("BLOCK_CHANCE").." "..string.format("%.02f", blockChance).."%"..FONT_COLOR_CODE_CLOSE;
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

	if (UISettingsCharacter.showStatsFromArgentDawnItems) then
		local spFromAD = CSC_GetSpellkPowerFromArgentDawnItems(unit);
		maxSpellDmg = maxSpellDmg + spFromAD;
		statFrame.spVsUndead = maxSpellDmg;
	end

	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_SPELLPOWER, BreakUpLargeNumbers(maxSpellDmg), false);
end

local function CSC_GetMP5FromAuras()
	local mp5FromAuras = 0;
	local mp5CombatModifier = 0;

	for i = 0, 40 do
		--local name = select(1, UnitAura("player", i, "HELPFUL", "PLAYER"));
		local spellId = select(10, UnitAura("player", i, "HELPFUL", "PLAYER"));
		if spellId then
			if g_AuraIdToMp5[spellId] then
				local auraMp5 = g_AuraIdToMp5[spellId];
				
				local unitClassId = select(3, UnitClass("player"));
				if (unitClassId == CSC_PALADIN_CLASS_ID and CSC_IsBoWSpellId(spellId)) then
					local improvedBoWModifier = CSC_GetPaladinImprovedBoWModifier();
					
					if (improvedBoWModifier > 0) then
						auraMp5 = auraMp5 + auraMp5 * improvedBoWModifier;
					end
				end

				mp5FromAuras = mp5FromAuras + auraMp5;
			elseif g_CombatManaRegenSpellIdToModifier[spellId] then
				mp5CombatModifier = mp5CombatModifier + g_CombatManaRegenSpellIdToModifier[spellId];
			end
			--print(name.." "..spellId);
		end
	end

	return mp5FromAuras, mp5CombatModifier;
end

function CSC_PaperDollFrame_SetManaRegen(statFrame, unit)

	if ( not UnitHasMana(unit) ) then
		CSC_PaperDollFrame_SetLabelAndText(statFrame, MANA_REGEN, NOT_APPLICABLE, false);
		statFrame.tooltip = nil;
		return;
	end

	statFrame:SetScript("OnEnter", CSC_CharacterManaRegenFrame_OnEnter)
	statFrame:SetScript("OnLeave", function()
		GameTooltip:Hide()
    end)

	-- There is a bug in GetManaRegen() so I have to manually calculate mp5
	-- base == casting always and this is wrong
	local base, casting = GetManaRegen();
	
	-- to avoid the wrongly reported "0" regen after an update
	if base < 1 then base = g_lastSeenBaseManaRegen end
	if casting < 1 then casting = g_lastSeenBaseManaRegen end
	g_lastSeenBaseManaRegen = base;
	g_lastSeenCastingManaRegen = casting;

	local mp5FromGear = CSC_GetMP5FromGear(unit) + CSC_GetMP5FromSetBonus(unit);
	local mp5ModifierCasting = CSC_GetMP5ModifierFromTalents(unit);

	local mp5FromAuras, mp5CombatModifier = CSC_GetMP5FromAuras();
	if mp5CombatModifier > 0 then
		mp5ModifierCasting = mp5ModifierCasting + mp5CombatModifier;
	end
	
	-- All mana regen stats are displayed as mana/5 sec.
	local regenWhenNotCasting = (base * 5.0) + mp5FromGear + mp5FromAuras;
	casting = mp5FromGear + mp5FromAuras; -- if GetManaRegen() gets fixed ever, this should be changed

	if mp5ModifierCasting > 0 then
		casting = casting + base * mp5ModifierCasting * 5.0;
	end

	local regenWhenNotCastingText = BreakUpLargeNumbers(regenWhenNotCasting);
	local castingText = BreakUpLargeNumbers(casting);
	-- While Casting mana regen is most important to the player, so we display it as the main value
	CSC_PaperDollFrame_SetLabelAndText(statFrame, MANA_REGEN, castingText, false);
	statFrame.mp5FromGear = BreakUpLargeNumbers(mp5FromGear);
	statFrame.mp5Casting = castingText;
	statFrame.mp5NotCasting = regenWhenNotCastingText;
end

function CSC_PaperDollFrame_SetHealing(statFrame, unit)
	local unitClassId = select(3, UnitClass(unit));
	local healing = GetSpellBonusHealing();

	local healingText = healing;
	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_SPELLHEALING, healingText, false);
	statFrame.tooltip = STAT_SPELLHEALING.." "..healing;
	statFrame.tooltip2 = STAT_SPELLHEALING_TOOLTIP;
end

function CSC_PaperDollFrame_SetSpellHaste(statFrame)
	local spellHaste = GetCombatRating(CR_HASTE_SPELL);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. SPELL_HASTE .. FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(SPELL_HASTE_TOOLTIP, GetCombatRatingBonus(CR_HASTE_SPELL));
	CSC_PaperDollFrame_SetLabelAndText(statFrame, SPELL_HASTE, spellHaste);
end

function CSC_PaperDollFrame_SetResilience(statFrame)
	local resilience = GetCombatRating(CR_RESILIENCE_CRIT_TAKEN);
	local bonus = GetCombatRatingBonus(CR_RESILIENCE_CRIT_TAKEN);

	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_RESILIENCE, resilience);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..STAT_RESILIENCE.." "..resilience..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(RESILIENCE_TOOLTIP, bonus, min(bonus * 2, 25.00), bonus);
end

-- SIDE STATS FRAME ================================================================================================================================================================
function CSC_SideFrame_SetMissChance(statFrame, unit, ratingIndex)
	local playerLevel = UnitLevel(unit);
	local hitChance = GetHitModifier();
	
	if not hitChance then
		hitChance = 0;
	end

	local hitRatingBonus = GetCombatRatingBonus(ratingIndex); -- hit rating in % (hit chance) (from gear sources, doesn't seem to include talents);
	local totalHit = hitChance + hitRatingBonus;
	local missChanceVsNPC, missChanceVsBoss, missChanceVsPlayer, dwMissChanceVsNpc, dwMissChanceVsBoss, dwMissChanceVsPlayer = CSC_GetPlayerMissChances(unit, totalHit);

	if (ratingIndex == CR_HIT_MELEE) then
		statFrame.tooltip = format("Miss Chance vs Level 73 NPC/Boss: %.2F%%", missChanceVsBoss)..CSC_SYMBOL_TAB..format("(Dual wield: %.2F%%)", dwMissChanceVsBoss);
		local missChanceNPCLineOne = format("Miss Chance vs Level %d NPC:     %.2F%%", playerLevel, missChanceVsNPC);
		local missChanceNPCLineTwo = format("(Dual wield: %.2F%%)", dwMissChanceVsNpc);

		local missChancePlayerLineOne = format("Miss Chance vs Level %d Player:  %.2F%%", playerLevel, missChanceVsPlayer);
		local missChancePlayerLineTwo = format("(Dual wield: %.2F%%)", dwMissChanceVsPlayer);
		statFrame.tooltip2 = missChanceNPCLineOne..CSC_SYMBOL_TAB..missChanceNPCLineTwo.."\n"..missChancePlayerLineOne..CSC_SYMBOL_TAB..missChancePlayerLineTwo;
	else
		statFrame.tooltip = format("Miss Chance vs Level 73 NPC/Boss: %.2F%%", missChanceVsBoss);
		statFrame.tooltip2 = format("Miss Chance vs Level %d NPC: %.2F%%", playerLevel, missChanceVsNPC).."\n"..format("Miss Chance vs Level %d Player: %.2F%%", playerLevel, missChanceVsPlayer);
	end

	CSC_PaperDollFrame_SetLabelAndText(statFrame, "Miss Chance", missChanceVsBoss, true);
end

function CSC_SideFrame_SetCritCap(statFrame, unit, ratingIndex)
	local critCap, dwCritCap = CSC_GetPlayerCritCap(unit, ratingIndex);

	statFrame.tooltip = format("Crit cap vs Level 73 NPC/Boss: %.2F%%", critCap);
	if (ratingIndex == CR_HIT_MELEE) then
		local offhandItemId = GetInventoryItemID(unit, INVSLOT_OFFHAND);
		if (offhandItemId) then
			statFrame.tooltip2 = format("Dual wield crit cap: %.2F%%", dwCritCap);
		end
	end

	CSC_PaperDollFrame_SetLabelAndText(statFrame, "Crit Cap", critCap, true);
end

-- Melee
function CSC_SideFrame_SetMeleeHitChance(statFrame, unit)
	
	statFrame:SetScript("OnEnter", CSC_CharacterMeleeHitChanceSideFrame_OnEnter)
	statFrame:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)
	
	local hitChance = GetHitModifier();
	
	if not hitChance then
		hitChance = 0;
	end

	local hitRatingBonus = GetCombatRatingBonus(CR_HIT_MELEE); -- hit rating in % (hit chance) (from gear sources, doesn't seem to include talents);
	local totalHit = hitChance + hitRatingBonus;
	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_HIT_CHANCE, totalHit, true);
end

function CSC_SideFrame_SetMeleeCritRating(statFrame, unit)
	local critRating = GetCombatRating(CR_CRIT_MELEE);
	statFrame.tooltip = "Your crit rating.";
	CSC_PaperDollFrame_SetLabelAndText(statFrame, COMBAT_RATING_NAME9, critRating, false);
end

function CSC_SideFrame_SetMeleeHasteRating(statFrame, unit)
	local hasteRating = GetCombatRating(CR_HASTE_MELEE);
	statFrame.tooltip = format(CR_HASTE_RATING_TOOLTIP, GetCombatRating(CR_HASTE_MELEE), GetCombatRatingBonus(CR_HASTE_MELEE));
	CSC_PaperDollFrame_SetLabelAndText(statFrame, SPELL_HASTE, hasteRating, false);
end

function CSC_SideFrame_SetArmorPenetration(statFrame, unit)
	local armorPen = GetArmorPenetration();
	statFrame.tooltip = format(ITEM_MOD_ARMOR_PENETRATION_RATING, armorPen);
	CSC_PaperDollFrame_SetLabelAndText(statFrame, "Armor Penetration", armorPen, false);
end

-- Ranged
function CSC_SideFrame_SetRangedHitChance(statFrame, unit)
	if not IsRangedWeapon() then
		CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_HIT_CHANCE, NOT_APPLICABLE, false);
		return;
	end

	-- TODO: change this in the future with a dedicated function
	statFrame:SetScript("OnEnter", CSC_CharacterMeleeHitChanceSideFrame_OnEnter)
	statFrame:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)
	
	local hitChance = GetHitModifier();
	
	if not hitChance then
		hitChance = 0;
	end

	local hitFromScope = CSC_GetHitFromBiznicksAccurascope(unit);
	if (hitFromScope > 0) then
		hitChance = hitChance + hitFromScope;
	end

	local hitRatingBonus = GetCombatRatingBonus(CR_HIT_RANGED); -- hit rating in % (hit chance) (from gear sources, doesn't seem to include talents);
	local totalHit = hitChance + hitRatingBonus;
	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_HIT_CHANCE, totalHit, true);
end

function CSC_SideFrame_SetRangedCritRating(statFrame, unit)
	if not IsRangedWeapon() then
		CSC_PaperDollFrame_SetLabelAndText(statFrame, COMBAT_RATING_NAME9, NOT_APPLICABLE, false);
		return;
	end

	local critRating = GetCombatRating(CR_CRIT_RANGED);
	statFrame.tooltip = "Your crit rating.";
	CSC_PaperDollFrame_SetLabelAndText(statFrame, COMBAT_RATING_NAME9, critRating, false);
end

function CSC_SideFrame_SetRangedHasteRating(statFrame, unit)
	if not IsRangedWeapon() then
		CSC_PaperDollFrame_SetLabelAndText(statFrame, SPELL_HASTE, NOT_APPLICABLE, false);
		return;
	end

	local hasteRating = GetCombatRating(CR_HASTE_RANGED);
	statFrame.tooltip = format(CR_HASTE_RATING_TOOLTIP, GetCombatRating(CR_HASTE_RANGED), GetCombatRatingBonus(CR_HASTE_RANGED));
	CSC_PaperDollFrame_SetLabelAndText(statFrame, SPELL_HASTE, hasteRating, false);
end

-- Spell
function CSC_SideFrame_SetSpellHitChance(statFrame, unit)
	-- TODO: change this in the future with a dedicated function
	statFrame:SetScript("OnEnter", CSC_CharacterMeleeHitChanceSideFrame_OnEnter)
	statFrame:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)
	
	local spellHitChance = GetSpellHitModifier();
	if not spellHitChance then
		spellHitChance = 0;
	end

	spellHitChance = spellHitChance / 7; -- BUG ON BLIZZARD's side. returns 7 for each 1% hit. Dirty fix for now

	local hitRatingBonus = GetCombatRatingBonus(CR_HIT_SPELL); -- hit rating in % (hit chance) (from gear sources, doesn't seem to include talents)
	local totalHit = spellHitChance + hitRatingBonus;
	CSC_PaperDollFrame_SetLabelAndText(statFrame, STAT_HIT_CHANCE, totalHit, true);
end

function CSC_SideFrame_SetSpellCritRating(statFrame, unit)
	local critRating = GetCombatRating(CR_CRIT_SPELL);
	statFrame.tooltip = "Your crit rating.";
	CSC_PaperDollFrame_SetLabelAndText(statFrame, COMBAT_RATING_NAME11, critRating, false);
end

function CSC_SideFrame_SetSpellHastePercent(statFrame, unit)
	local hastePercent = GetCombatRatingBonus(CR_HASTE_SPELL);
	statFrame.tooltip = format("Increases your spell haste by %d%%", hastePercent);
	CSC_PaperDollFrame_SetLabelAndText(statFrame, "Haste", hastePercent, true);
end

function CSC_SideFrame_SetSpellPenetration(statFrame, unit)
	local spellPen = GetSpellPenetration();
	statFrame.tooltip = format(SPELL_PENETRATION_TOOLTIP, spellPen, spellPen);
	CSC_PaperDollFrame_SetLabelAndText(statFrame, "Spell Penetration", spellPen, false);
end

-- Defense
function CSC_SideFrame_SetDefenseRating(statFrame, unit)
	local defensePercent = GetDodgeBlockParryChanceFromDefense();
	local defenseRating = GetCombatRating(CR_DEFENSE_SKILL);
	local defense = GetCombatRatingBonus(CR_DEFENSE_SKILL);

	statFrame.tooltip = format(DEFAULT_STATDEFENSE_TOOLTIP, defenseRating, defense, defensePercent, defensePercent);
	CSC_PaperDollFrame_SetLabelAndText(statFrame, "Defense Rating", defenseRating, false);
end

function CSC_SideFrame_SetDodgeRating(statFrame, unit)
	local dodgeRating = GetCombatRating(CR_DODGE);
	local dodgeChance = GetCombatRatingBonus(CR_DODGE);
	statFrame.tooltip = format(CR_DODGE_TOOLTIP, dodgeRating, dodgeChance);
	CSC_PaperDollFrame_SetLabelAndText(statFrame, "Dodge Rating", dodgeRating, false);
end

function CSC_SideFrame_SetParryRating(statFrame, unit)
	local parryRating = GetCombatRating(CR_PARRY)
	local parryChance = GetCombatRatingBonus(CR_PARRY);
	statFrame.tooltip = format(CR_PARRY_TOOLTIP, parryRating, parryChance);
	CSC_PaperDollFrame_SetLabelAndText(statFrame, "Parry Rating", parryRating, false);
end

function CSC_SideFrame_SetBlockRating(statFrame, unit)
	local blockRating = GetCombatRating(CR_BLOCK)
	local blockChance = GetCombatRatingBonus(CR_BLOCK);
	CSC_PaperDollFrame_SetLabelAndText(statFrame, "Block Rating", blockRating, false);
end

-- SIDE STATS FRAME END ================================================================================================================================================================