-- Class ids
CSC_WARRIOR_CLASS_ID 		= 1;
CSC_PALADIN_CLASS_ID 		= 2;
CSC_HUNTER_CLASS_ID 		= 3;
CSC_ROGUE_CLASS_ID 			= 4;
CSC_PRIEST_CLASS_ID 		= 5;
CSC_DEATHKNIGHT_CLASS_ID 	= 6;
CSC_SHAMAN_CLASS_ID 		= 7;
CSC_MAGE_CLASS_ID 			= 8;
CSC_WARLOCK_CLASS_ID 		= 9;
CSC_MONK_CLASS_ID 			= 10;
CSC_DRUID_CLASS_ID 			= 11;
CSC_DEMONHUNTER_CLASS_ID 	= 12;

g_WeaponStringByWeaponId = {
	[LE_ITEM_WEAPON_AXE1H] 		= CSC_WEAPON_AXE1H_TXT,
	[LE_ITEM_WEAPON_AXE2H] 		= CSC_WEAPON_AXE2H_TXT,
	[LE_ITEM_WEAPON_MACE1H] 	= CSC_WEAPON_MACE1H_TXT,
	[LE_ITEM_WEAPON_MACE2H] 	= CSC_WEAPON_MACE2H_TXT,
	[LE_ITEM_WEAPON_POLEARM] 	= CSC_WEAPON_POLEARM_TXT,
	[LE_ITEM_WEAPON_SWORD1H] 	= CSC_WEAPON_SWORD1H_TXT,
	[LE_ITEM_WEAPON_SWORD2H] 	= CSC_WEAPON_SWORD2H_TXT,
	[LE_ITEM_WEAPON_STAFF] 		= CSC_WEAPON_STAFF_TXT,
	[LE_ITEM_WEAPON_UNARMED] 	= CSC_WEAPON_UNARMED_TXT,
    [LE_ITEM_WEAPON_DAGGER] 	= CSC_WEAPON_DAGGER_TXT,
    [LE_ITEM_WEAPON_BOWS]       = CSC_WEAPON_BOW_TXT,
    [LE_ITEM_WEAPON_CROSSBOW]   = CSC_WEAPON_CROSSBOW_TXT,
    [LE_ITEM_WEAPON_GUNS]       = CSC_WEAPON_GUN_TXT
};

-- Class set items IDs
g_BattlegearOfMightIds = { 
    [16861] = 16861, 
    [16862] = 16862, 
    [16863] = 16863, 
    [16864] = 16864, 
    [16865] = 16865, 
    [16866] = 16866, 
    [16867] = 16867, 
    [16868] = 16868
};

g_VestmentsOfTranscendenceIds = {
    [16925] = 16925, 
    [16926] = 16926, 
    [16919] = 16919, 
    [16921] = 16921, 
    [16920] = 16920, 
    [16922] = 16922, 
    [16924] = 16924, 
    [16923] = 16923,
};

g_StormrageRaimentIds = {
    [16897] = 16897, 
    [16898] = 16898, 
    [16899] = 16899, 
    [16900] = 16900, 
    [16901] = 16901, 
    [16902] = 16902, 
    [16903] = 16903, 
    [16904] = 16904,
};

g_TheTenStormsIds = {
    [16943] = 16943, 
    [16944] = 16944, 
    [16945] = 16945, 
    [16946] = 16946, 
    [16947] = 16947, 
    [16948] = 16948, 
    [16949] = 16949, 
    [16950] = 16950
};

g_AuraIdToMp5 = {
	-- BOW
	[19742] = 10,
	[19850] = 15,
	[19852] = 20,
	[19853] = 25,
	[19854] = 30,
	[25290] = 33,
	-- GBOW
	[25894] = 30,
	[25918] = 33,
	-- Mana Spring Totem
	[5675] = 10,
	[10495] = 15,
	[10496] = 20,
	[10497] = 25,
	-- Mageblood potion
	[24363] = 12,
	--Nightfin Soup
	[18194] = 8
};
  
g_CombatManaRegenSpellIdToModifier = {
    -- Mage Armor
    [6117] = 0.3,
    [22782] = 0.3,
    [22783] = 0.3
};

CSC_SYMBOL_TAB   = "    "; -- for some reason "\t" doesn't work
CSC_SYMBOL_SPACE = " ";
                                