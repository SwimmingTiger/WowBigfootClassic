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
		GameTooltip:AddLine(CSC_SYMBOL_SPACE); -- Blank line.
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
	GameTooltip:AddLine(CSC_SYMBOL_SPACE); -- Blank line.
	for i=2, MAX_SPELL_SCHOOLS do
		GameTooltip:AddDoubleLine(getglobal("DAMAGE_SCHOOL"..i), format("%.2F", GetSpellBonusDamage(i)), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddTexture("Interface\\PaperDollInfoFrame\\SpellSchoolIcon"..i);
	end

	if (self.spVsUndead ~= nil and UISettingsCharacter.showStatsFromArgentDawnItems) then
		GameTooltip:AddDoubleLine(DAMAGE.." vs Undead: ", format("%.2F", self.spVsUndead), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end
	GameTooltip:Show();
end

function CSC_CharacterSpellCritFrame_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..COMBAT_RATING_NAME11.." "..GetCombatRating(11)..FONT_COLOR_CODE_CLOSE);
	GameTooltip:AddDoubleLine(getglobal("DAMAGE_SCHOOL"..2), format("%.2F", self.holyCrit).."%", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddTexture("Interface\\PaperDollInfoFrame\\SpellSchoolIcon"..2);
	GameTooltip:AddDoubleLine(getglobal("DAMAGE_SCHOOL"..3), format("%.2F", self.fireCrit).."%", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddTexture("Interface\\PaperDollInfoFrame\\SpellSchoolIcon"..3);
	GameTooltip:AddDoubleLine(getglobal("DAMAGE_SCHOOL"..5), format("%.2F", self.frostCrit).."%", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddTexture("Interface\\PaperDollInfoFrame\\SpellSchoolIcon"..5);
	GameTooltip:AddDoubleLine(getglobal("DAMAGE_SCHOOL"..7), format("%.2F", self.arcaneCrit).."%", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddTexture("Interface\\PaperDollInfoFrame\\SpellSchoolIcon"..7);
	GameTooltip:AddDoubleLine(getglobal("DAMAGE_SCHOOL"..6), format("%.2F", self.shadowCrit).."%", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddTexture("Interface\\PaperDollInfoFrame\\SpellSchoolIcon"..6);
	GameTooltip:AddDoubleLine(getglobal("DAMAGE_SCHOOL"..4), format("%.2F", self.natureCrit).."%", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddTexture("Interface\\PaperDollInfoFrame\\SpellSchoolIcon"..4);

	if self.unitClassId == CSC_SHAMAN_CLASS_ID then
		GameTooltip:AddDoubleLine(CSC_LIGHTNING_TXT, format("%.2F", self.lightningCrit).."%", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end

	GameTooltip:Show();
end

function CSC_CharacterManaRegenFrame_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(format(MANA_REGEN_TOOLTIP, self.mp5NotCasting, self.mp5Casting), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(MANA_REGEN.." (From Gear):", self.mp5FromGear);
	GameTooltip:AddDoubleLine(MANA_REGEN.." (While Casting):", self.mp5Casting);
	GameTooltip:AddDoubleLine(MANA_REGEN.." (While Not Casting):", self.mp5NotCasting);
	GameTooltip:Show();
end

function CSC_CharacterBlock_OnEnter(self)
	
	if UISettingsGlobal.useBlizzardBlockValue then
		self.blockValue = GetShieldBlock();
	else
		self.blockValue = CSC_GetBlockValue("player");
		
		local unitClassId = select(3, UnitClass("player"));
		if (unitClassId == CSC_WARRIOR_CLASS_ID) then
			local blockFromZGEnchants = CSC_GetBlockValueFromWarriorZGEnchants("player");
			if (blockFromZGEnchants > 0) then
				self.blockValue = self.blockValue + blockFromZGEnchants;
			end
		end
	end

	local blockRatingTxt = format(CR_BLOCK_TOOLTIP, GetCombatRating(CR_BLOCK), GetCombatRatingBonus(CR_BLOCK), self.blockValue);
	
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(self.blockChance);
	GameTooltip:AddLine(blockRatingTxt);
	GameTooltip:Show();
end

function CSC_CharacterHitChanceFrame_OnEnter(self)
	local hitChance = self.hitChance;

	local totalWeaponSkill = CSC_GetPlayerWeaponSkill("player", INVSLOT_MAINHAND);
	local missChanceVsNPC, missChanceVsBoss, missChanceVsPlayer, dwMissChanceVsNpc, dwMissChanceVsBoss, dwMissChanceVsPlayer = CSC_GetPlayerMissChances("player", hitChance, totalWeaponSkill);

	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(STAT_HIT_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddLine("Reduces your chance to miss.");

	GameTooltip:AddLine(CSC_SYMBOL_SPACE); -- Blank line.
	GameTooltip:AddLine("Miss Chance vs.");
	GameTooltip:AddDoubleLine(format(CSC_SYMBOL_TAB.."Level 60 NPC: %.2F%%", missChanceVsNPC), format("(Dual wield: %.2F%%)", dwMissChanceVsNpc));
	GameTooltip:AddDoubleLine(format(CSC_SYMBOL_TAB.."Level 60 Player: %.2F%%", missChanceVsPlayer), format("(Dual wield: %.2F%%)", dwMissChanceVsPlayer));
	GameTooltip:AddDoubleLine(format(CSC_SYMBOL_TAB.."Level 63 NPC/Boss: %.2F%%", missChanceVsBoss), format("(Dual wield: %.2F%%)", dwMissChanceVsBoss));
	GameTooltip:Show();
end

function CSC_CharacterRangedHitChanceFrame_OnEnter(self)
	local hitChance = self.hitChance;

	local totalWeaponSkill = CSC_GetPlayerWeaponSkill("player", INVSLOT_RANGED);
	local missChanceVsNPC, missChanceVsBoss, missChanceVsPlayer, _, _, _ = CSC_GetPlayerMissChances("player", hitChance, totalWeaponSkill);

	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(STAT_HIT_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddLine("Reduces your chance to miss.");

	GameTooltip:AddLine(CSC_SYMBOL_SPACE); -- Blank line.
	GameTooltip:AddLine("Miss Chance vs.");
	GameTooltip:AddLine(format(CSC_SYMBOL_TAB.."Level 60 NPC: %.2F%%", missChanceVsNPC));
	GameTooltip:AddLine(format(CSC_SYMBOL_TAB.."Level 60 Player: %.2F%%", missChanceVsPlayer));
	GameTooltip:AddLine(format(CSC_SYMBOL_TAB.."Level 63 NPC/Boss: %.2F%%", missChanceVsBoss));
	GameTooltip:Show();
end

function CSC_CharacterSpellHitChanceFrame_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(format(CSC_SPELL_HIT_TOOLTIP_TXT, self.hitChance), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);

	if self.unitClassId == CSC_MAGE_CLASS_ID then
		GameTooltip:AddLine(CSC_SYMBOL_SPACE); -- Blank line.
		GameTooltip:AddLine(CSC_SPELL_HIT_SUBTOOLTIP_TXT);
		GameTooltip:AddDoubleLine(CSC_SYMBOL_TAB..CSC_ARCANE_SPELL_HIT_TXT, (self.arcaneHit + self.hitChance).."%");
		GameTooltip:AddDoubleLine(CSC_SYMBOL_TAB..CSC_FIRE_SPELL_HIT_TXT, (self.fireHit + self.hitChance).."%");
		GameTooltip:AddDoubleLine(CSC_SYMBOL_TAB..CSC_FROST_SPELL_HIT_TXT, (self.frostHit + self.hitChance).."%");
	elseif self.unitClassId == CSC_WARLOCK_CLASS_ID then
		GameTooltip:AddLine(CSC_SYMBOL_SPACE); -- Blank line.
		GameTooltip:AddLine(CSC_SPELL_HIT_SUBTOOLTIP_TXT);
		GameTooltip:AddDoubleLine(CSC_SYMBOL_TAB..CSC_DESTRUCTION_SPELL_HIT_TXT, self.hitChance.."%");
		GameTooltip:AddDoubleLine(CSC_SYMBOL_TAB..CSC_AFFLICTION_SPELL_HIT_TXT, (self.afflictionHit + self.hitChance).."%");
	elseif self.unitClassId == CSC_SHAMAN_CLASS_ID then
		GameTooltip:SetText(format(CSC_SPELL_HIT_TOOLTIP_2_TXT, self.hitChance), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end
	GameTooltip:Show();
end

function CSC_CharacterHitRatingFrame_OnEnter(self)

	local unit = self.unit;
	local ratingIndex = self.ratingIndex;
	local statName = self.statName;
	local rating = self.rating;
	local ratingBonus = self.ratingBonus;
	local playerLevel = UnitLevel(unit);
	local unitClassId = select(3, UnitClass(unit));

	-- Set the tooltip text
	local tooltip = HIGHLIGHT_FONT_COLOR_CODE..statName.." "..rating..FONT_COLOR_CODE_CLOSE;
	local tooltip2 = " ";

	if ( ratingIndex == CR_HIT_MELEE ) then
		tooltip2 = format(CR_HIT_MELEE_TOOLTIP, playerLevel, ratingBonus, GetArmorPenetration());
	elseif ( ratingIndex == CR_HIT_RANGED ) then
		tooltip2 = format(CR_HIT_RANGED_TOOLTIP, playerLevel, ratingBonus, GetArmorPenetration());
	elseif ( ratingIndex == CR_HIT_SPELL ) then
		-- spell hit from talents
		if unitClassId == CSC_MAGE_CLASS_ID then
			local arcaneHit, frostFireHit = CSC_GetMageSpellHitFromTalents();
			self.arcaneHit = arcaneHit;
			self.frostHit = frostFireHit;
			self.fireHit = frostFireHit;
		elseif unitClassId == CSC_WARLOCK_CLASS_ID then
			self.afflictionHit = CSC_GetWarlockSpellHitFromTalents();
		end
		tooltip2 = format(CR_HIT_SPELL_TOOLTIP, playerLevel, ratingBonus, GetSpellPenetration(), GetSpellPenetration());
	else
		tooltip2 = HIGHLIGHT_FONT_COLOR_CODE..getglobal("COMBAT_RATING_NAME"..ratingIndex).." "..rating;	
	end

	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(tooltip, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddLine(tooltip2);

	if (ratingIndex == CR_HIT_SPELL) then
		if unitClassId == CSC_MAGE_CLASS_ID then
			GameTooltip:AddLine(CSC_SYMBOL_SPACE); -- Blank line.
			GameTooltip:AddLine(CSC_SPELL_HIT_SUBTOOLTIP_TXT);
			GameTooltip:AddDoubleLine(CSC_SYMBOL_TAB..CSC_ARCANE_SPELL_HIT_TXT, (self.arcaneHit + self.spellHitGearTalents).."%");
			GameTooltip:AddDoubleLine(CSC_SYMBOL_TAB..CSC_FIRE_SPELL_HIT_TXT, (self.fireHit + self.spellHitGearTalents).."%");
			GameTooltip:AddDoubleLine(CSC_SYMBOL_TAB..CSC_FROST_SPELL_HIT_TXT, (self.frostHit + self.spellHitGearTalents).."%");
		elseif unitClassId == CSC_WARLOCK_CLASS_ID then
			GameTooltip:AddLine(CSC_SYMBOL_SPACE); -- Blank line.
			GameTooltip:AddLine(CSC_SPELL_HIT_SUBTOOLTIP_TXT);
			GameTooltip:AddDoubleLine(CSC_SYMBOL_TAB..CSC_DESTRUCTION_SPELL_HIT_TXT, self.spellHitGearTalents.."%");
			GameTooltip:AddDoubleLine(CSC_SYMBOL_TAB..CSC_AFFLICTION_SPELL_HIT_TXT, (self.afflictionHit + self.spellHitGearTalents).."%");
		end
	elseif (ratingIndex == CR_HIT_MELEE) then
		local missChanceVsNPC, missChanceVsBoss, missChanceVsPlayer, dwMissChanceVsNpc, dwMissChanceVsBoss, dwMissChanceVsPlayer = CSC_GetPlayerMissChances(unit, ratingBonus);
		GameTooltip:AddLine(CSC_SYMBOL_SPACE); -- Blank line.
		GameTooltip:AddLine("Miss Chance vs.");
		GameTooltip:AddDoubleLine(format(CSC_SYMBOL_TAB.."Level %d NPC: %.2F%%", playerLevel, missChanceVsNPC), format("(Dual wield: %.2F%%)", dwMissChanceVsNpc));
		GameTooltip:AddDoubleLine(format(CSC_SYMBOL_TAB.."Level %d Player: %.2F%%", playerLevel, missChanceVsPlayer), format("(Dual wield: %.2F%%)", dwMissChanceVsPlayer));
		GameTooltip:AddDoubleLine(format(CSC_SYMBOL_TAB.."Level 73 NPC/Boss: %.2F%%", missChanceVsBoss), format("(Dual wield: %.2F%%)", dwMissChanceVsBoss));
	elseif (ratingIndex == CR_HIT_RANGED) then
		local missChanceVsNPC, missChanceVsBoss, missChanceVsPlayer, _, _, _ = CSC_GetPlayerMissChances(unit, ratingBonus);
		GameTooltip:AddLine(CSC_SYMBOL_SPACE); -- Blank line.
		GameTooltip:AddLine("Miss Chance vs.");
		GameTooltip:AddDoubleLine(format(CSC_SYMBOL_TAB.."Level %d NPC: %.2F%%", playerLevel, missChanceVsNPC));
		GameTooltip:AddDoubleLine(format(CSC_SYMBOL_TAB.."Level %d Player: %.2F%%", playerLevel, missChanceVsPlayer));
		GameTooltip:AddDoubleLine(format(CSC_SYMBOL_TAB.."Level 73 NPC/Boss: %.2F%%", missChanceVsBoss));
	end
	
	GameTooltip:Show();
end

function CSC_CharacterMeleeCritFrame_OnEnter(self)
	
	local critChanceTxt = format(PAPERDOLLFRAME_TOOLTIP_FORMAT, MELEE_CRIT_CHANCE).." "..format("%.2F%%", self.critChance);
	local critRatingTxt = format(CR_CRIT_MELEE_TOOLTIP, GetCombatRating(CR_CRIT_MELEE), GetCombatRatingBonus(CR_CRIT_MELEE));

	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(critChanceTxt, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddLine(critRatingTxt);
	
	GameTooltip:AddLine(CSC_SYMBOL_SPACE); -- Blank line.
	GameTooltip:AddLine("Crit cap vs.");
	local critCap, dwCritCap = CSC_GetPlayerCritCap(self.unit, CR_HIT_MELEE);
	
	local CRITCAP_COLOR_CODE = GREEN_FONT_COLOR_CODE;
	if self.critChance > critCap then CRITCAP_COLOR_CODE = ORANGE_FONT_COLOR_CODE end
	local critCapTxt = CRITCAP_COLOR_CODE..format("%.2F%%", critCap)..FONT_COLOR_CODE_CLOSE;

	local offhandItemId = GetInventoryItemID("player", INVSLOT_OFFHAND);
	if (offhandItemId) then
		local DWCRITCAP_COLOR_CODE = GREEN_FONT_COLOR_CODE;
		if self.critChance > dwCritCap then DWCRITCAP_COLOR_CODE = ORANGE_FONT_COLOR_CODE end

		local critCapDwTxt = DWCRITCAP_COLOR_CODE..format("%.2F%%", dwCritCap)..FONT_COLOR_CODE_CLOSE;
		GameTooltip:AddDoubleLine(CSC_SYMBOL_TAB.."Level 73 NPC/Boss: "..critCapTxt, "(Dual wield: "..critCapDwTxt..")");
	else
		GameTooltip:AddDoubleLine(CSC_SYMBOL_TAB.."Level 73 NPC/Boss: "..critCapTxt);
	end

	GameTooltip:Show();
end

function CSC_CharacterRangedCritFrame_OnEnter(self)
	local critChanceTxt = HIGHLIGHT_FONT_COLOR_CODE..RANGED_CRIT_CHANCE.." "..format("%.2F%%", self.critChance)..FONT_COLOR_CODE_CLOSE;
	local critRatingTxt = format(CR_CRIT_RANGED_TOOLTIP, GetCombatRating(CR_CRIT_RANGED), GetCombatRatingBonus(CR_CRIT_RANGED));

	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(critChanceTxt, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddLine(critRatingTxt);

	GameTooltip:AddLine(CSC_SYMBOL_SPACE); -- Blank line.
	GameTooltip:AddLine("Crit cap vs.");
	local critCap, _ = CSC_GetPlayerCritCap(self.unit, CR_HIT_RANGED);
	
	local CRITCAP_COLOR_CODE = GREEN_FONT_COLOR_CODE;
	if self.critChance > critCap then CRITCAP_COLOR_CODE = ORANGE_FONT_COLOR_CODE end
	local critCapTxt = CRITCAP_COLOR_CODE..format("%.2F%%", critCap)..FONT_COLOR_CODE_CLOSE;
	GameTooltip:AddDoubleLine(CSC_SYMBOL_TAB.."Level 73 NPC/Boss: "..critCapTxt);

	GameTooltip:Show();
end

function CSC_CharacterDefenseFrame_OnEnter(self)
	local defensePercent = GetDodgeBlockParryChanceFromDefense();
	local ratingTxt = format(DEFAULT_STATDEFENSE_TOOLTIP, GetCombatRating(CR_DEFENSE_SKILL), GetCombatRatingBonus(CR_DEFENSE_SKILL), defensePercent, defensePercent);

	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(self.defense, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddLine(ratingTxt);
	GameTooltip:Show();
end

-- SIDE FRAME CALLBACKS
function CSC_CharacterMeleeHitChanceSideFrame_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(STAT_HIT_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddLine("Your total hit rating converted to hit chance (including gear and talents)");
	GameTooltip:Show();
end
-- SIDE FRAME CALLBACKS END
-- OnEnter Tooltip functions END
