
DCT_DEFAULT_CFG = {
	["DCT_Enable"] = 1,
	["DCT_SaveVer"] = 2011,
	["DCT_EnglishInfo"] = 0,
	["DCT_HealSelfNoneName"] = 0,
	["DCT_ManaSelfNoneName"] = 0,
	["DCT_ScaleOnCrit"] = 0,
	["DCT_SSC_Number"] = 0,
	["DCT_ZeroHp_off"] = 1,
	["DCT_SSC_SpellSchool"] = 1,
	["DCT_SSC_Spell"] = 0,
	["DCT_SSColor1"] = {color = { 1,1,1}},
	["DCT_SSColor2"] = {color = { 1,1,0}},
	["DCT_SSColor4"] = {color = { 1,0.3,0}},
	["DCT_SSColor8"] = {color = { 0.5,0.7,0.2}},
	["DCT_SSColor16"] = {color = { 0.4,0.6,0.9}},
	["DCT_SSColor32"] = {color = { 1,0.4,1}},
	["DCT_SSColor64"] = {color = { 0,1,1}},
	["DCT_PRETEXTNAME"] = "none",
	["DCT_UseCastBar"] = 1,
	["DCT_CastBarWidth"] = 25,

	["DCT_SHOWHIT"] = {per = 0,frame = 1,color = {1,0,0},colorEx = {{1,1,0},{1,1,1}},},
	["DCT_SHOWSPELL"] = {per = 0,frame = 1,color = {1,1,0},colorEx = {{0,1,1},{1,0,0}},fEff = 2},
	["DCT_SHOWHITCRIT"] = {per = 0,frame = 1,color = {1,0,0},colorEx = {{1,1,0},{1,1,1}},fEff = 2},
	["DCT_SHOWSPELLCRIT"] = {per = 0,frame = 1,color = {1,1,0},colorEx = {{0,1,1},{1,0,0}},fEff = 2},
	["DCT_SHOWPERIODIC"] = {per = 0,frame = 1,color = {1,0,1},colorEx = {{1,1,0},{1,0,0}},},
	["DCT_SHOWHEAL"] = {per = 0,frame = 3,color = {0,1,0},colorEx = {{1,1,0},{1,0,0}},},
	["DCT_SHOWPERIODICHEAL"] = {per = 0,frame = 3,color = {0,1,0},colorEx = {{1,1,0},{1,0,0}},},
	["DCT_SHOWDRAIN"] = {frame = 1,color = {0.2,0.2,1},colorEx = {{1,1,0},{1,0,0}},},
	["DCT_SHOWACTIVE"] = {frame = 4,color = {1,1,1},colorEx = {{1,1,0},{1,0,0}},sound = "",fSizeEn = 4,fSizeCh = 4,fEff = 4},
	["DCT_SHOWFACTION"] = {frame = 5,color = {0.4,0.4,1},colorEx = {{1,1,0},{1,0.4,0.4}},},
	["DCT_SHOWHONOR"] = {frame = 5,color = {1,1,0},colorEx = {{1,1,0},{1,0,0}},},
	["DCT_SHOWCOMBAT"] = {frame = 2,color = {1,0.4,0},colorEx = {{0,1,0},{1,1,1}},fEff = 2,sound = ""},
	["DCT_SHOWCOMBATLEAVE"] = {frame = 2,color = {0.4,1,0},colorEx = {{0,1,0},{1,1,1}},fEff = 2,sound = ""},
	["DCT_SHOWCP"] = {frame = 3,color = {0,1,0},colorEx = {{1,1,0},{1,0,0}},},
	["DCT_SHOWSHIELD"] = {per = 0,frame = 3,color = {1,0.5,1},colorEx = {{1,1,0},{1,0,0}},},
	["DCT_SHOWBUFF"] = {frame = 5,color = {0,1,0},colorEx = {{1,1,0},{1,0,0}},},
	["DCT_SHOWDEBUFF"] = {frame = 5,color = {1,0.2,0},colorEx = {{1,1,0},{1,0,0}},},
	["DCT_SHOWBUFFFADE"] = {per = 3,frame = 5,color = {0,1,0},colorEx = {{1,1,0},{1,0,0}},},
	["DCT_SHOWDEBUFFFADE"] = {frame = 5,color = {1,0.5,0},colorEx = {{1,0.2,0.2},{1,1,1}},},
	["DCT_SHOWBUFFDOSE"] = {frame = 5,color = {0,1,0},colorEx = {{1,1,0},{1,0,0}},},
	["DCT_SHOWDEBUFFDOSE"] = {frame = 5,color = {1,0.2,0},colorEx = {{1,1,0},{1,0,0}},},
	["DCT_SHOWPOWER"] = {per = 0,frame = 3,color = {1,1,0},colorEx = {{1,1,0},{1,0,0}},},

	["DCT_SHOWENVIRONMENTAL"] = {frame = 1,color = {1,0,0},colorEx = {{1,1,0},{1,0,0}},},
	["DCT_SHOWDISPELLED"] = {frame = 1,color = {1,0,0},colorEx = {{1,1,0},{1,0,0}},},
	["DCT_SHOWLOWHEALTH"] = {per = 40,frame = 4,color = {1,0.3,0.3},colorEx = {{1,1,0},{1,0,0}},sound = 568154},
	["DCT_SHOWLOWMANA"] = {per = 40,frame = 4,color = {0.3,0.3,1},colorEx = {{1,1,0},{1,0,0}},sound = 568924},
	["DCT_SHOWEXTRAATTACKS"] = {frame = 5,color = {1,1,1},colorEx = {{1,1,0},{1,0,0}},sound = ""},
	["DCT_SHOWSPECBUFF"] = {frame = 4,color = {0,1,0},colorEx = {{1,0,0},{1,1,0}},sound = ""},
	["DCT_SHOWSPECBUFFFADE"] = {frame = 0,color = {0.8,0.3,0.3},colorEx = {{1,0,0},{1,1,0}},per = 3},
	["DCT_SHOWSPECDEBUFFFADE"] = {frame = 0,color = {0.8,0.3,0.3},colorEx = {{1,0,0},{1,1,0}}},
	["DCT_SHOWSPELLSUCCESS"] = {frame = 0,color = {0,1,0},colorEx = {{1,0,0},{1,1,0}},sound = "",fEff = 2},
	["DCT_SHOWSPELLFAILED"] = {frame = 0,color = {1,0,0},colorEx = {{1,0,0},{1,1,0}},sound = "",fEff = 2},
	["DCT_SHOWSPECTARGETBUFF"] = {frame = 0,color = {1,0,0},colorEx = {{1,0,0},{1,1,0}},sound = "",},
	["DCT_SHOWSPECTARGETDEBUFF"] = {frame = 0,color = {1,0,0},colorEx = {{1,0,0},{1,1,0}},sound = "",},
	["DCT_SHOWSPECTARGETBUFFFADE"] = {frame = 0,color = {1,0,0},colorEx = {{1,0,0},{1,1,0}},sound = "",},
	["DCT_SHOWSPECTARGETDEBUFFFADE"] = {frame = 0,color = {1,0,0},colorEx = {{1,0,0},{1,1,0}},sound = "",},
	["DCT_SHOWKILLBLOW"] = {frame = 0,color = {1,1,0},colorEx = {{1,0,0},{1,1,0}},sound = "",fEff = 3},
	["DCT_SHOWCOOLDOWN"] = {frame = 0,color = {0.5,0.5,1},colorEx = {{1,0,0},{1,1,0}},sound = "",fEff = 3},

	["DCT_SHOWDODGE"] = {frame = 1,color = {1,1,1},colorEx = {{1,1,0},{1,0,0}},sound = "",show = {"#ms","#ms #c1(#sn)#ce"}},
	["DCT_SHOWABSORB"] = {frame = 1,color = {1,1,1},colorEx = {{1,1,0},{1,0,0}},sound = "",show = {"#ms","#ms #c1(#sn)#ce"}},
	["DCT_SHOWRESIST"] = {frame = 1,color = {1,1,1},colorEx = {{1,1,0},{1,0,0}},sound = "",show = {"#ms","#ms #c1(#sn)#ce"}},
	["DCT_SHOWPARRY"] = {frame = 1,color = {1,1,1},colorEx = {{1,1,0},{1,0,0}},sound = "",show = {"#ms","#ms #c1(#sn)#ce"}},
	["DCT_SHOWMISS"] = {frame = 1,color = {1,1,1},colorEx = {{1,1,0},{1,0,0}},sound = "",show = {"#ms","#ms #c1(#sn)#ce"}},
	["DCT_SHOWBLOCK"] = {frame = 1,color = {1,1,1},colorEx = {{1,1,0},{1,0,0}},sound = "",show = {"#ms","#ms #c1(#sn)#ce"}},
	["DCT_SHOWREFLECT"] = {frame = 1,color = {1,1,1},colorEx = {{1,1,0},{1,0,0}},sound = "",show = {"#ms","#ms #c1(#sn)#ce"}},
	["DCT_SHOWDEFLECT"] = {frame = 1,color = {1,1,1},colorEx = {{1,1,0},{1,0,0}},sound = "",show = {"#ms","#ms #c1(#sn)#ce"}},
	["DCT_SHOWIMMUNE"] = {frame = 1,color = {1,1,1},colorEx = {{1,1,0},{1,0,0}},sound = "",show = {"#ms","#ms #c1(#sn)#ce"}},
	["DCT_SHOWEVADE"] = {frame = 1,color = {1,1,1},colorEx = {{1,1,0},{1,0,0}},sound = "",show = {"#ms","#ms #c1(#sn)#ce"}},
	["DCT_FRAME_CONFIG"] = {
		{active = true,name = "",aniType = 1,speed = 100,angle = 0,alpha = 100,x = -20,y = 0,param1 = 175,param2 = 150,param3 = 225,param4 = 50,param5 = -5,param6 = 30,param7 = 1,fEn = 2,fCh = 1,fSizeEn = 20,fSizeCh = 18,fEff = 1},
		{active = true,name = "",aniType = 1,speed = 100,angle = 0,alpha = 100,x = 0,y = 0,param1 = 65,param2 = 100,param3 = 330,param4 = 50,param5 = 0,param6 = 30,param7 = 1,fEn = 2,fCh = 1,fSizeEn = 20,fSizeCh = 18,fEff = 1},
		{active = true,name = "",aniType = 1,speed = 100,angle = 0,alpha = 100,x = 20,y = 0,param1 = 5,param2 = 150,param3 = 330,param4 = 50,param5 = 5,param6 = 30,param7 = 1,fEn = 2,fCh = 1,fSizeEn = 20,fSizeCh = 18,fEff = 1},
		{active = true,name = "",aniType = 3,speed = 100,angle = 0,alpha = 100,x = 0,y = -60,param1 = 3,param2 = 3,param3 = 1,param4 = 2,param5 = 1,fEn = 1,fCh = 1,fSizeEn = 24,fSizeCh = 24,fEff = 2},
		{active = true,name = "",aniType = 3,speed = 100,angle = 0,alpha = 100,x = 0,y = -150,param1 = 3,param2 = 3,param3 = 1,param4 = 1,param5 = 1,fEn = 1,fCh = 1,fSizeEn = 18,fSizeCh = 18,fEff = 2},
		{active = true,name = "",aniType = 3,speed = 100,angle = 0,alpha = 100,x = 0,y = 200,param1 = 3,param2 = 4.5,param3 = 1,param4 = 1,param5 = 1,fEn = 1,fCh = 1,fSizeEn = 15,fSizeCh = 15,fEff = 1},
		{active = true,name = "",aniType = 6,speed = 100,angle = 0,alpha = 100,x = 0,y = 60,param1 = 200,param2 = 2.5,param3 = 1,param4 = 0,param5 = 0,param6 = 0,fEn = 1,fCh = 1,fSizeEn = 18,fSizeCh = 16,fEff = 1},
		{active = true,name = "",aniType = 7,speed = 100,angle = 0,alpha = 100,x = 0,y = 80,param1 = 1.5,param2 = 1,param3 = 1,param4 = 0,param5 = 3,param6 = 0,fEn = 2,fCh = 2,fSizeEn = 26,fSizeCh = 26,fEff = 1},
		{active = true,name = "",aniType = 6,speed = 100,angle = 0,alpha = 100,x = -80,y = 80,param1 = 100,param2 = 2,param3 = 1,param4 = -40,param5 = 0,param6 = 0,fEn = 1,fCh = 1,fSizeEn = 18,fSizeCh = 16,fEff = 1},
		{active = false},
		{active = false},
		{active = false},
	},

	["DCT_SPECBUFF"] = {},
	["DCT_SPECBUFFFADE"] = {},
	["DCT_SPECSPELLSUCCESS"] = {},
	["DCT_SPECSPELLFAILED"] = {},
	["DCT_SPECTARGETBUFF"] = {},
	["DCT_SPECTARGETBUFFFADE"] = {},
	["DCT_SPECCOOLDOWN"] = {},

}

-- Damage types.
local DAMAGETYPE_PHYSICAL = 0x1;
local DAMAGETYPE_HOLY = 0x2;
local DAMAGETYPE_FIRE = 0x4;
local DAMAGETYPE_NATURE = 0x8;
local DAMAGETYPE_FROST = 0x10;
local DAMAGETYPE_SHADOW = 0x20;
local DAMAGETYPE_ARCANE = 0x40;

-- Physical + Magic Damage types.
local DAMAGETYPE_HOLYSTRIKE = DAMAGETYPE_PHYSICAL + DAMAGETYPE_HOLY;
local DAMAGETYPE_FLAMESTRIKE = DAMAGETYPE_PHYSICAL + DAMAGETYPE_FIRE;
local DAMAGETYPE_STORMSTRIKE = DAMAGETYPE_PHYSICAL + DAMAGETYPE_NATURE;
local DAMAGETYPE_FROSTSTRIKE = DAMAGETYPE_PHYSICAL + DAMAGETYPE_FROST;
local DAMAGETYPE_SHADOWSTRIKE = DAMAGETYPE_PHYSICAL + DAMAGETYPE_SHADOW;
local DAMAGETYPE_SPELLSTRIKE = DAMAGETYPE_PHYSICAL + DAMAGETYPE_ARCANE;

-- Two magic damage types.
local DAMAGETYPE_HOLYFIRE = DAMAGETYPE_HOLY + DAMAGETYPE_FIRE;
local DAMAGETYPE_HOLYSTORM = DAMAGETYPE_HOLY + DAMAGETYPE_NATURE;
local DAMAGETYPE_HOLYFROST = DAMAGETYPE_HOLY + DAMAGETYPE_FROST;
local DAMAGETYPE_SHADOWLIGHT = DAMAGETYPE_HOLY + DAMAGETYPE_SHADOW;
local DAMAGETYPE_DIVINE = DAMAGETYPE_HOLY + DAMAGETYPE_ARCANE;
local DAMAGETYPE_FIRESTORM = DAMAGETYPE_FIRE + DAMAGETYPE_NATURE;
local DAMAGETYPE_FROSTFIRE = DAMAGETYPE_FIRE + DAMAGETYPE_FROST;
local DAMAGETYPE_SHADOWFLAME = DAMAGETYPE_FIRE + DAMAGETYPE_SHADOW;
local DAMAGETYPE_SPELLFIRE = DAMAGETYPE_FIRE + DAMAGETYPE_ARCANE;
local DAMAGETYPE_FROSTSTORM = DAMAGETYPE_NATURE + DAMAGETYPE_FROST;
local DAMAGETYPE_SHADOWSTORM = DAMAGETYPE_NATURE + DAMAGETYPE_SHADOW;
local DAMAGETYPE_SPELLSTORM = DAMAGETYPE_NATURE + DAMAGETYPE_ARCANE;
local DAMAGETYPE_SHADOWFROST = DAMAGETYPE_FROST + DAMAGETYPE_SHADOW;
local DAMAGETYPE_SPELLFROST = DAMAGETYPE_FROST + DAMAGETYPE_ARCANE;
local DAMAGETYPE_SPELLSHADOW = DAMAGETYPE_SHADOW + DAMAGETYPE_ARCANE;

-- Three or more damage types.
local DAMAGETYPE_ELEMENTAL = DAMAGETYPE_FIRE + DAMAGETYPE_NATURE + DAMAGETYPE_FROST;
local DAMAGETYPE_CHROMATIC = DAMAGETYPE_FIRE + DAMAGETYPE_NATURE + DAMAGETYPE_FROST + DAMAGETYPE_SHADOW + DAMAGETYPE_ARCANE;
local DAMAGETYPE_MAGIC = DAMAGETYPE_HOLY + DAMAGETYPE_FIRE + DAMAGETYPE_NATURE + DAMAGETYPE_FROST + DAMAGETYPE_SHADOW + DAMAGETYPE_ARCANE;
local DAMAGETYPE_CHAOS = DAMAGETYPE_PHYSICAL + DAMAGETYPE_HOLY + DAMAGETYPE_FIRE + DAMAGETYPE_NATURE + DAMAGETYPE_FROST + DAMAGETYPE_SHADOW + DAMAGETYPE_ARCANE;

DCT_SPELLSCHOOL_TRAN = {
 [DAMAGETYPE_PHYSICAL] = {STRING_SCHOOL_PHYSICAL, "Physical"},
 [DAMAGETYPE_HOLY] = {STRING_SCHOOL_HOLY, "Holy"},
 [DAMAGETYPE_FIRE] = {STRING_SCHOOL_FIRE, "Fire"},
 [DAMAGETYPE_NATURE] = {STRING_SCHOOL_NATURE, "Nature"},
 [DAMAGETYPE_FROST] = {STRING_SCHOOL_FROST, "Frost"},
 [DAMAGETYPE_SHADOW] = {STRING_SCHOOL_SHADOW, "Shadow"},
 [DAMAGETYPE_ARCANE] = {STRING_SCHOOL_ARCANE, "Arcane"},
 [DAMAGETYPE_HOLYSTRIKE] = {STRING_SCHOOL_HOLYSTRIKE, "HolyStrike"},
 [DAMAGETYPE_FLAMESTRIKE] = {STRING_SCHOOL_FLAMESTRIKE, "FlameStrike"},
 [DAMAGETYPE_STORMSTRIKE] = {STRING_SCHOOL_STORMSTRIKE, "StormStrike"},
 [DAMAGETYPE_FLAMESTRIKE] = {STRING_SCHOOL_FLAMESTRIKE, "FlameStrike"},
 [DAMAGETYPE_SHADOWSTRIKE] = {STRING_SCHOOL_SHADOWSTRIKE, "ShadowStrike"},
 [DAMAGETYPE_SPELLSTRIKE] = {STRING_SCHOOL_SPELLSTRIKE, "SpellStrike"},
 [DAMAGETYPE_HOLYFIRE] = {STRING_SCHOOL_HOLYFIRE, "HolyFire"},
 [DAMAGETYPE_HOLYSTORM] = {STRING_SCHOOL_HOLYSTORM, "HolyStorm"},
 [DAMAGETYPE_HOLYFROST] = {STRING_SCHOOL_HOLYFROST, "HolyFrost"},
 [DAMAGETYPE_SHADOWLIGHT] = {STRING_SCHOOL_SHADOWLIGHT, "ShadowLight"},
 [DAMAGETYPE_DIVINE] = {STRING_SCHOOL_DIVINE, "Divine"},
 [DAMAGETYPE_FIRESTORM] = {STRING_SCHOOL_FIRESTORM, "FireStorm"},
 [DAMAGETYPE_FROSTFIRE] = {STRING_SCHOOL_FROSTFIRE, "FrostFire"},
 [DAMAGETYPE_SHADOWFLAME] = {STRING_SCHOOL_SHADOWFLAME, "ShadowFlame"},
 [DAMAGETYPE_SPELLFIRE] = {STRING_SCHOOL_SPELLFIRE, "SpellFire"},
 [DAMAGETYPE_FROSTSTORM] = {STRING_SCHOOL_FROSTSTORM, "FrostStorm"},
 [DAMAGETYPE_SHADOWSTORM] = {STRING_SCHOOL_SHADOWSTORM, "ShadowStorm"},
 [DAMAGETYPE_SPELLSTORM] = {STRING_SCHOOL_SPELLSTORM, "SpellStorm"},
 [DAMAGETYPE_SHADOWFROST] = {STRING_SCHOOL_SHADOWFROST, "ShadowFrost"},
 [DAMAGETYPE_SPELLFROST] = {STRING_SCHOOL_SPELLFROST, "SpellFrost"},
 [DAMAGETYPE_SPELLSHADOW] = {STRING_SCHOOL_SPELLSHADOW, "SpellShadow"},
 [DAMAGETYPE_ELEMENTAL] = {STRING_SCHOOL_ELEMENTAL, "Elemental"},
 [DAMAGETYPE_CHROMATIC] = {STRING_SCHOOL_CHROMATIC, "Chromatic"},
 [DAMAGETYPE_MAGIC] = {STRING_SCHOOL_MAGIC, "Magic"},
 [DAMAGETYPE_CHAOS] = {STRING_SCHOOL_CHAOS, "Chaos"}
}

DCT_POWERTYPE_TRAN = {
	{STRING_POWER_MANA,"Mana"},
	{STRING_POWER_RAGE,"Rage"},
	{STRING_POWER_FOCUS,"Focus"},
	{STRING_POWER_ENERGY,"Energy"},
	{STRING_POWER_HAPPINESS,"Happiness"},
	{STRING_POWER_RUNES,"Runes"},
}
