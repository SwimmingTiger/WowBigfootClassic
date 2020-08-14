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
	
	self.holyDmg = GetSpellBonusDamage(2);
	self.fireDmg = GetSpellBonusDamage(3);
	self.natureDmg = GetSpellBonusDamage(4);
	self.frostDmg = GetSpellBonusDamage(5);
	self.shadowDmg = GetSpellBonusDamage(6);
	self.arcaneDmg = GetSpellBonusDamage(7);

	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(STAT_SPELLPOWER, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(STAT_SPELLPOWER_TOOLTIP);
	GameTooltip:AddLine(CSC_SYMBOL_SPACE); -- Blank line.
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
	GameTooltip:AddLine(CSC_SYMBOL_SPACE); -- Blank line.
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
	GameTooltip:AddDoubleLine(MANA_REGEN.." (From Gear):", self.mp5FromGear);
	GameTooltip:AddDoubleLine(MANA_REGEN.." (While Casting):", self.mp5Casting);
	GameTooltip:AddDoubleLine(MANA_REGEN.." (While Not Casting):", self.mp5NotCasting);
	GameTooltip:Show();
end

function CSC_CharacterBlock_OnEnter(self)
	
	if CharacterStatsClassicDB.useBlizzardBlockValue then
		self.blockValue = GetShieldBlock();
	else
		self.blockValue = CSC_GetBlockValue("player");
	end
	
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(" ", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(BLOCK_CHANCE..": ", self.blockChance);
	GameTooltip:AddDoubleLine(ITEM_MOD_BLOCK_VALUE_SHORT..": ", self.blockValue);
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
	end
	GameTooltip:Show();
end

function CSC_CharacterMeleeCritFrame_OnEnter(self)
	local hitChance = GetHitModifier();
	local totalWeaponSkill = CSC_GetPlayerWeaponSkill("player", INVSLOT_MAINHAND);
	local missChanceVsNPC, missChanceVsBoss, missChanceVsPlayer, dwMissChanceVsNpc, dwMissChanceVsBoss, dwMissChanceVsPlayer = CSC_GetPlayerMissChances("player", hitChance, totalWeaponSkill);

	-- no weapon equipped, not supported localization or something else went wrong
	if not totalWeaponSkill then totalWeaponSkill = 300 end

	local critSuppression = 4.8;
	local glancingChance = 40;

	local extraWeaponSkill = totalWeaponSkill - 300;
	local bossDefense = 315; -- level 63
	local skillBossDelta = bossDefense - totalWeaponSkill;
	local dodgeChance = 5 + (skillBossDelta * 0.1);	
	local critCap = 100 - missChanceVsBoss - dodgeChance - glancingChance + critSuppression + (extraWeaponSkill * 0.04);

	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(self.criticalStrikeTxt, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddLine(CSC_SYMBOL_SPACE); -- Blank line.
	GameTooltip:AddLine("Crit cap vs.");
	
	local critChance = GetCritChance();
	local CRITCAP_COLOR_CODE = GREEN_FONT_COLOR_CODE;
	if critChance > critCap then CRITCAP_COLOR_CODE = ORANGE_FONT_COLOR_CODE end
	local critCapTxt = CRITCAP_COLOR_CODE..format("%.2F%%", critCap)..FONT_COLOR_CODE_CLOSE;

	local offhandItemId = GetInventoryItemID("player", INVSLOT_OFFHAND);
	if offhandItemId then
		local critCapDw = 100 - dwMissChanceVsBoss - dodgeChance - glancingChance + critSuppression + (extraWeaponSkill * 0.04);
		
		local DWCRITCAP_COLOR_CODE = GREEN_FONT_COLOR_CODE;
		if critChance > critCapDw then DWCRITCAP_COLOR_CODE = ORANGE_FONT_COLOR_CODE end

		local critCapDwTxt = DWCRITCAP_COLOR_CODE..format("%.2F%%", critCapDw)..FONT_COLOR_CODE_CLOSE;
		GameTooltip:AddDoubleLine(CSC_SYMBOL_TAB.."Level 63 NPC/Boss: "..critCapTxt, "(Dual wield: "..critCapDwTxt..")");
	else
		GameTooltip:AddDoubleLine(CSC_SYMBOL_TAB.."Level 63 NPC/Boss: "..critCapTxt);
	end

	GameTooltip:Show();
end
-- OnEnter Tooltip functions END