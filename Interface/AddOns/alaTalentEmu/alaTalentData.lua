--[[--
	alex@0
--]]--
----------------------------------------------------------------------------------------------------
local ADDON, NS = ...;



----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------main
--------------------------------------------------
--[[
	tier, column, isLearnable = GetTalentPrereqs( tabIndex[1-3] , talentIndex[1,MAX_NUM_TALENTS] );
	local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo( tabIndex[1-3] , talentIndex[1,MAX_NUM_TALENTS] );

]]

NS._indexToClass =
{
	"druid",
	"hunter",
	"mage",
	"paladin",
	"priest",
	"rogue",
	"shaman",
	"warlock",
	"warrior",
};

NS._classTalent =
{
	druid =
	{
		283,	--Balance,平衡
		281,	--Feral,野性战斗
		282,	--Restoration,恢复
	},
	hunter =
	{
		361,	--BeastMastery,野兽控制
		363,	--Marksmanship,射击
		362,	--Survival,生存
	},
	mage =
	{
		81,		--Arcane,奥术
		41,		--Fire,火焰
		61,		--Frost,冰霜
	},
	paladin =
	{
		382,	--Holy,神圣
		383,	--Protection,防护
		381,	--Combat,惩戒
	},
	priest =
	{
		201,	--Discipline,戒律
		202,	--Holy,神圣
		203,	--Shadow,暗影
	},
	rogue =
	{
		182,	--Assassination,刺杀
		181,	--Combat,战斗
		183,	--Subtlety,敏锐
	},
	shaman =
	{
		261,	--Elemental,元素
		263,	--Enhancement,增强
		262,	--Restoration,恢复
	},
	warlock =
	{
		302,	--Curses,痛苦
		303,	--Summoning,恶魔学识
		301,	--Destruction,毁灭
	},
	warrior =
	{
		161,	--Arms,武器
		164,	--Fury,狂怒
		163,	--Protection,防护
	},

};

	--1-----2----3---4---------5--------6-------7------8--------9--------10-------11-------12-------13--------14----------15---------------16--------------17------------------18-------
	--tier, col, id, maxPoint, reqTier, reqCol, reqId, r1Spell, r2Spell, r3Spell, r4Spell, r5Spell, texture, [icon index, req index in db, req icon index, req by index in db, req by icon index](calculated after addon loaded)
	--1-----2----3---4---------5--------6-------7------8---------9--------10-----------11---------------12
	--tier, col, id, maxPoint, reqTier, reqCol, reqId, Spell[5], texture, [icon index, req index in db, req by index in db](calculated after addon loaded)
NS._DB =
{
	mage =
	{
		[41] =
		{
			{ 0, 1,   26, 5, nil, nil,  nil, { 11069, 12338, 12339, 12340, 12341, }, "Interface\\icons\\spell_fire_flamebolt", },
			{ 0, 2,   30, 5, nil, nil,  nil, { 11103, 12357, 12358, 12359, 12360, }, "Interface\\icons\\spell_fire_meteorstorm", },
			{ 1, 0,   34, 5, nil, nil,  nil, { 11119, 11120, 12846, 12847, 12848, }, "Interface\\icons\\spell_fire_incinerate", },
			{ 1, 1,   28, 2, nil, nil,  nil, { 11100, 12353,   nil,   nil,   nil, }, "Interface\\icons\\spell_fire_flare", },
			{ 1, 2,   27, 3, nil, nil,  nil, { 11078, 11080, 12342,   nil,   nil, }, "Interface\\icons\\spell_fire_fireball", },
			{ 2, 0, 1141, 2, nil, nil,  nil, { 18459, 18460,   nil,   nil,   nil, }, "Interface\\icons\\spell_fire_flameshock", },
			{ 2, 1,   31, 3, nil, nil,  nil, { 11108, 12349, 12350,   nil,   nil, }, "Interface\\icons\\spell_fire_selfdestruct", },
			{ 2, 2,   29, 1, nil, nil,  nil, { 11366,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_fire_fireball02", },
			{ 2, 3,   23, 2, nil, nil,  nil, { 11083, 12351,   nil,   nil,   nil, }, "Interface\\icons\\spell_fire_fire", },
			{ 3, 0,   25, 3, nil, nil,  nil, { 11095, 12872, 12873,   nil,   nil, }, "Interface\\icons\\spell_fire_soulburn", },
			{ 3, 1,   24, 2, nil, nil,  nil, { 11094, 13043,   nil,   nil,   nil, }, "Interface\\icons\\spell_fire_firearmor", },
			{ 3, 3, 1639, 3, nil, nil,  nil, { 29074, 29075, 29076,   nil,   nil, }, "Interface\\icons\\spell_fire_masterofelements", },
			{ 4, 1,   33, 3, nil, nil,  nil, { 11115, 11367, 11368,   nil,   nil, }, "Interface\\icons\\spell_nature_wispheal", },
			{ 4, 2,   32, 1,   2,   2,   29, { 11113,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_excorcism_02", },
			{ 5, 2,   35, 5, nil, nil,  nil, { 11124, 12378, 12398, 12399, 12400, }, "Interface\\icons\\spell_fire_immolation", },
			{ 6, 1,   36, 1,   4,   1,   33, { 11129,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_fire_sealoffire", },
		},
		[61] =
		{
			{ 0, 0,   70, 2, nil, nil,  nil, { 11189, 28332,   nil,   nil,   nil, }, "Interface\\icons\\spell_frost_frostward", },
			{ 0, 1,   37, 5, nil, nil,  nil, { 11070, 12473, 16763, 16765, 16766, }, "Interface\\icons\\spell_frost_frostbolt02", },
			{ 0, 2, 1649, 3, nil, nil,  nil, { 29438, 29439, 29440,   nil,   nil, }, "Interface\\icons\\spell_ice_magicdamage", },
			{ 1, 0,   73, 5, nil, nil,  nil, { 11207, 12672, 15047, 15052, 15053, }, "Interface\\icons\\spell_frost_iceshard", },
			{ 1, 1,   38, 3, nil, nil,  nil, { 11071, 12496, 12497,   nil,   nil, }, "Interface\\icons\\spell_frost_frostarmor", },
			{ 1, 2,   62, 2, nil, nil,  nil, { 11165, 12475,   nil,   nil,   nil, }, "Interface\\icons\\spell_frost_freezingbreath", },
			{ 1, 3,   65, 3, nil, nil,  nil, { 11175, 12569, 12571,   nil,   nil, }, "Interface\\icons\\spell_frost_wisp", },
			{ 2, 0,   61, 3, nil, nil,  nil, { 11151, 12952, 12953,   nil,   nil, }, "Interface\\icons\\spell_frost_frostbolt", },
			{ 2, 1,   69, 1, nil, nil,  nil, { 12472,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_frost_wizardmark", },
			{ 2, 3,   63, 3, nil, nil,  nil, { 11185, 12487, 12488,   nil,   nil, }, "Interface\\icons\\spell_frost_icestorm", },
			{ 3, 0,  741, 2, nil, nil,  nil, { 16757, 16758,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_darkritual", },
			{ 3, 1,   66, 3, nil, nil,  nil, { 11160, 12518, 12519,   nil,   nil, }, "Interface\\icons\\spell_frost_stun", },
			{ 3, 2,   67, 5,   1,   2,   62, { 11170, 12982, 12983, 12984, 12985, }, "Interface\\icons\\spell_frost_frostshock", },
			{ 4, 1,   72, 1, nil, nil,  nil, { 11958,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_frost_frost", },
			{ 4, 2,   64, 3, nil, nil,  nil, { 11190, 12489, 12490,   nil,   nil, }, "Interface\\icons\\spell_frost_glacier", },
			{ 5, 2,   68, 5, nil, nil,  nil, { 11180, 28592, 28593, 28594, 28595, }, "Interface\\icons\\spell_frost_chillingblast", },
			{ 6, 1,   71, 1,   4,   1,   72, { 11426,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_ice_lament", },
		},
		[81] =
		{
			--{ 0, 0,   74, 2, nil, nil,  nil, {    66,    66,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_dispelmagic", },	--testing
			{ 0, 0,   74, 2, nil, nil,  nil, { 11210, 12592,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_dispelmagic", },
			{ 0, 1,   76, 5, nil, nil,  nil, { 11222, 12839, 12840, 12841, 12842, }, "Interface\\icons\\spell_holy_devotion", },
			{ 0, 2,   80, 5, nil, nil,  nil, { 11237, 12463, 12464, 16769, 16770, }, "Interface\\icons\\spell_nature_starfall", },
			{ 1, 0,   78, 2, nil, nil,  nil, {  6057,  6085,   nil,   nil,   nil, }, "Interface\\icons\\inv_wand_01", },
			{ 1, 1, 1650, 5, nil, nil,  nil, { 29441, 29444, 29445, 29446, 29447, }, "Interface\\icons\\spell_nature_astralrecalgroup", },
			{ 1, 2,   75, 5, nil, nil,  nil, { 11213, 12574, 12575, 12576, 12577, }, "Interface\\icons\\spell_shadow_manaburn", },
			{ 2, 0,   82, 2, nil, nil,  nil, { 11247, 12606,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_abolishmagic", },
			{ 2, 1,   81, 3, nil, nil,  nil, { 11242, 12467, 12469,   nil,   nil, }, "Interface\\icons\\spell_nature_wispsplode", },
			{ 2, 2,   85, 1, nil, nil,  nil, { 28574,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_arcane_arcaneresilience", },
			{ 3, 0,   83, 2, nil, nil,  nil, { 11252, 12605,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_detectlesserinvisibility", },
			{ 3, 1,   88, 2, nil, nil,  nil, { 11255, 12598,   nil,   nil,   nil, }, "Interface\\icons\\spell_frost_iceshock", },
			{ 3, 3, 1142, 3, nil, nil,  nil, { 18462, 18463, 18464,   nil,   nil, }, "Interface\\icons\\spell_shadow_siphonmana", },
			{ 4, 1,   86, 1, nil, nil,  nil, { 12043,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_enchantarmor", },
			{ 4, 2,   77, 5,   2,   2,   85, { 11232, 12500, 12501, 12502, 12503, }, "Interface\\icons\\spell_shadow_charm", },
			{ 5, 1,  421, 3,   4,   1,   86, { 15058, 15059, 15060,   nil,   nil, }, "Interface\\icons\\spell_shadow_teleport", },
			{ 6, 1,   87, 1,   5,   1,  421, { 12042,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_lightning", },
		},
	},
	warrior =
	{
		[161] =
		{
			{ 0, 0,  124, 3, nil, nil,  nil, { 12282, 12663, 12664,   nil,   nil, }, "Interface\\icons\\ability_rogue_ambush", },
			{ 0, 1,  130, 5, nil, nil,  nil, { 16462, 16463, 16464, 16465, 16466, }, "Interface\\icons\\ability_parry", },
			{ 0, 2,  127, 3, nil, nil,  nil, { 12286, 12658, 12659,   nil,   nil, }, "Interface\\icons\\ability_gouge", },
			{ 1, 0,  126, 2, nil, nil,  nil, { 12285, 12697,   nil,   nil,   nil, }, "Interface\\icons\\ability_warrior_charge", },
			{ 1, 1,  641, 5, nil, nil,  nil, { 12295, 12676, 12677, 12678, 12679, }, "Interface\\icons\\spell_nature_enchantarmor", },
			{ 1, 3,  128, 3, nil, nil,  nil, { 12287, 12665, 12666,   nil,   nil, }, "Interface\\icons\\ability_thunderclap", },
			{ 2, 0,  131, 2, nil, nil,  nil, { 12290, 12963,   nil,   nil,   nil, }, "Interface\\icons\\inv_sword_05", },
			{ 2, 1,  137, 1,   1,   1,  641, { 12296,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_blessingofstamina", },
			{ 2, 2,  121, 3,   0,   2,  127, { 12834, 12849, 12867,   nil,   nil, }, "Interface\\icons\\ability_backstab", },
			{ 3, 1,  136, 5, nil, nil,  nil, { 12163, 12711, 12712, 12713, 12714, }, "Interface\\icons\\inv_axe_09", },
			{ 3, 2,  662, 2,   2,   2,  121, { 16493, 16494,   nil,   nil,   nil, }, "Interface\\icons\\ability_searingarrow", },
			{ 4, 0,  132, 5, nil, nil,  nil, { 12700, 12781, 12783, 12784, 12785, }, "Interface\\icons\\inv_axe_06", },
			{ 4, 1,  133, 1, nil, nil,  nil, { 12292,   nil,   nil,   nil,   nil, }, "Interface\\icons\\ability_rogue_slicedice", },
			{ 4, 2,  125, 5, nil, nil,  nil, { 12284, 12701, 12702, 12703, 12704, }, "Interface\\icons\\inv_mace_01", },
			{ 4, 3,  123, 5, nil, nil,  nil, { 12281, 12812, 12813, 12814, 12815, }, "Interface\\icons\\inv_sword_27", },
			{ 5, 0,  134, 5, nil, nil,  nil, { 12165, 12830, 12831, 12832, 12833, }, "Interface\\icons\\inv_weapon_halbard_01", },
			{ 5, 2,  129, 3, nil, nil,  nil, { 12289, 12668, 23695,   nil,   nil, }, "Interface\\icons\\ability_shockwave", },
			{ 6, 1,  135, 1,   4,   1,  133, { 12294,   nil,   nil,   nil,   nil, }, "Interface\\icons\\ability_warrior_savageblow", },
		},
		[163] =
		{
			{ 0, 1, 1601, 5, nil, nil,  nil, { 12298, 12724, 12725, 12726, 12727, }, "Interface\\icons\\inv_shield_06", },
			{ 0, 2,  138, 5, nil, nil,  nil, { 12297, 12750, 12751, 12752, 12753, }, "Interface\\icons\\spell_nature_mirrorimage", },
			{ 1, 0,  142, 2, nil, nil,  nil, { 12301, 12818,   nil,   nil,   nil, }, "Interface\\icons\\ability_racial_bloodrage", },
			{ 1, 2,  140, 5, nil, nil,  nil, { 12299, 12761, 12762, 12763, 12764, }, "Interface\\icons\\spell_holy_devotion", },
			{ 1, 3,  141, 5, nil, nil,  nil, { 12300, 12959, 12960, 12961, 12962, }, "Interface\\icons\\spell_magic_magearmor", },
			{ 2, 0,  153, 1,   1,   0,  142, { 12975,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_ashestoashes", },
			{ 2, 1,  145, 3,   0,   1, 1601, { 12945, 12307, 12944,   nil,   nil, }, "Interface\\icons\\ability_defend", },
			{ 2, 2,  147, 3, nil, nil,  nil, { 12797, 12799, 12800,   nil,   nil, }, "Interface\\icons\\ability_warrior_revenge", },
			{ 2, 3,  144, 5, nil, nil,  nil, { 12303, 12788, 12789, 12791, 12792, }, "Interface\\icons\\ability_warrior_innerrage", },
			{ 3, 0,  146, 3, nil, nil,  nil, { 12308, 12810, 12811,   nil,   nil, }, "Interface\\icons\\ability_warrior_sunder", },
			{ 3, 1,  151, 3, nil, nil,  nil, { 12313, 12804, 12807,   nil,   nil, }, "Interface\\icons\\ability_warrior_disarm", },
			{ 3, 2,  143, 2, nil, nil,  nil, { 12302, 12765,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_reincarnation", },
			{ 4, 0,  150, 2, nil, nil,  nil, { 12312, 12803,   nil,   nil,   nil, }, "Interface\\icons\\ability_warrior_shieldwall", },
			{ 4, 1,  152, 1, nil, nil,  nil, { 12809,   nil,   nil,   nil,   nil, }, "Interface\\icons\\ability_thunderbolt", },
			{ 4, 2,  149, 2, nil, nil,  nil, { 12311, 12958,   nil,   nil,   nil, }, "Interface\\icons\\ability_warrior_shieldbash", },
			{ 5, 2,  702, 5, nil, nil,  nil, { 16538, 16539, 16540, 16541, 16542, }, "Interface\\icons\\inv_sword_20", },
			{ 6, 1,  148, 1,   4,   1,  152, { 23922,   nil,   nil,   nil,   nil, }, "Interface\\icons\\inv_shield_05", },
		},
		[164] =
		{
			{ 0, 1,  158, 5, nil, nil,  nil, { 12321, 12835, 12836, 12837, 12838, }, "Interface\\icons\\spell_nature_purge", },
			{ 0, 2,  157, 5, nil, nil,  nil, { 12320, 12852, 12853, 12855, 12856, }, "Interface\\icons\\ability_rogue_eviscerate", },
			{ 1, 1,  161, 5, nil, nil,  nil, { 12324, 12876, 12877, 12878, 12879, }, "Interface\\icons\\ability_warrior_warcry", },
			{ 1, 2,  159, 5, nil, nil,  nil, { 12322, 12999, 13000, 13001, 13002, }, "Interface\\icons\\spell_nature_stoneclawtotem", },
			{ 2, 0,  166, 3, nil, nil,  nil, { 12329, 12950, 20496,   nil,   nil, }, "Interface\\icons\\ability_warrior_cleave", },
			{ 2, 1,  160, 1, nil, nil,  nil, { 12323,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_deathscream", },
			{ 2, 2,  661, 3, nil, nil,  nil, { 16487, 16489, 16492,   nil,   nil, }, "Interface\\icons\\spell_shadow_summonimp", },
			{ 2, 3,  154, 5, nil, nil,  nil, { 12318, 12857, 12858, 12860, 12861, }, "Interface\\icons\\ability_warrior_battleshout", },
			{ 3, 0, 1581, 5, nil, nil,  nil, { 23584, 23585, 23586, 23587, 23588, }, "Interface\\icons\\ability_dualwield", },
			{ 3, 1, 1542, 2, nil, nil,  nil, { 20502, 20503,   nil,   nil,   nil, }, "Interface\\icons\\inv_sword_48", },
			{ 3, 2,  155, 5, nil, nil,  nil, { 12317, 13045, 13046, 13047, 13048, }, "Interface\\icons\\spell_shadow_unholyfrenzy", },
			{ 4, 0,  168, 5, nil, nil,  nil, { 12862, 12330, 20497, 20498, 20499, }, "Interface\\icons\\ability_warrior_decisivestrike", },
			{ 4, 1,  165, 1, nil, nil,  nil, { 12328,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_deathpact", },
			{ 4, 3, 1543, 2, nil, nil,  nil, { 20504, 20505,   nil,   nil,   nil, }, "Interface\\icons\\ability_rogue_sprint", },
			{ 5, 0, 1541, 2, nil, nil,  nil, { 20500, 20501,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_ancestralguardian", },
			{ 5, 2,  156, 5,   3,   2,  155, { 12319, 12971, 12972, 12973, 12974, }, "Interface\\icons\\ability_ghoulfrenzy", },
			{ 6, 1,  167, 1,   4,   1,  165, { 23881,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_bloodlust", },
		},
	},
	rogue =
	{
		[181] =
		{
			{ 0, 0,  203, 3, nil, nil,  nil, { 13741, 13793, 13792,   nil,   nil, }, "Interface\\icons\\ability_gouge", },
			{ 0, 1,  201, 2, nil, nil,  nil, { 13732, 13863,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_ritualofsacrifice", },
			{ 0, 2,  186, 5, nil, nil,  nil, { 13712, 13788, 13789, 13790, 13791, }, "Interface\\icons\\spell_nature_invisibilty", },
			{ 1, 0,  202, 3, nil, nil,  nil, { 13733, 13865, 13866,   nil,   nil, }, "Interface\\icons\\ability_backstab", },
			{ 1, 1,  187, 5, nil, nil,  nil, { 13713, 13853, 13854, 13855, 13856, }, "Interface\\icons\\ability_parry", },
			{ 1, 2,  181, 5, nil, nil,  nil, { 13705, 13832, 13843, 13844, 13845, }, "Interface\\icons\\ability_marksmanship", },
			{ 2, 0,  204, 2, nil, nil,  nil, { 13742, 13872,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_shadowward", },
			{ 2, 1,  301, 1,   1,   1,  187, { 14251,   nil,   nil,   nil,   nil, }, "Interface\\icons\\ability_warrior_challange", },
			{ 2, 3,  222, 2, nil, nil,  nil, { 13743, 13875,   nil,   nil,   nil, }, "Interface\\icons\\ability_rogue_sprint", },
			{ 3, 0,  206, 2, nil, nil,  nil, { 13754, 13867,   nil,   nil,   nil, }, "Interface\\icons\\ability_kick", },
			{ 3, 1,  182, 5, nil, nil,  nil, { 13706, 13804, 13805, 13806, 13807, }, "Interface\\icons\\inv_weapon_shortblade_05", },
			{ 3, 2,  221, 5,   1,   2,  181, { 13715, 13848, 13849, 13851, 13852, }, "Interface\\icons\\ability_dualwield", },
			{ 4, 0,  184, 5, nil, nil,  nil, { 13709, 13800, 13801, 13802, 13803, }, "Interface\\icons\\inv_mace_01", },
			{ 4, 1,  223, 1, nil, nil,  nil, { 13877,   nil,   nil,   nil,   nil, }, "Interface\\icons\\ability_warrior_punishingblow", },
			{ 4, 2,  242, 5, nil, nil,  nil, { 13960, 13961, 13962, 13963, 13964, }, "Interface\\icons\\inv_sword_27", },
			{ 4, 3,  183, 5, nil, nil,  nil, { 13707, 13966, 13967, 13968, 13969, }, "Interface\\icons\\inv_gauntlets_04", },
			{ 5, 1, 1703, 2,   4,   1,  223, { 30919, 30920,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_blessingofstrength", },
			{ 5, 2, 1122, 3, nil, nil,  nil, { 18427, 18428, 18429,   nil,   nil, }, "Interface\\icons\\ability_racial_avatar", },
			{ 6, 1,  205, 1, nil, nil,  nil, { 13750,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_shadowworddominate", },
		},
		[182] =
		{
			{ 0, 0,  276, 3, nil, nil,  nil, { 14162, 14163, 14164,   nil,   nil, }, "Interface\\icons\\ability_rogue_eviscerate", },
			{ 0, 1,  272, 2, nil, nil,  nil, { 14144, 14148,   nil,   nil,   nil, }, "Interface\\icons\\ability_fiegndead", },
			{ 0, 2,  270, 5, nil, nil,  nil, { 14138, 14139, 14140, 14141, 14142, }, "Interface\\icons\\ability_racial_bloodrage", },
			{ 1, 0,  273, 3, nil, nil,  nil, { 14156, 14160, 14161,   nil,   nil, }, "Interface\\icons\\ability_druid_disembowel", },
			{ 1, 1,  274, 2, nil, nil,  nil, { 14158, 14159,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_deathscream", },
			{ 1, 3,  277, 3, nil, nil,  nil, { 14165, 14166, 14167,   nil,   nil, }, "Interface\\icons\\ability_rogue_slicedice", },
			{ 2, 0,  281, 1, nil, nil,  nil, { 14179,   nil,   nil,   nil,   nil, }, "Interface\\icons\\ability_warrior_decisivestrike", },
			{ 2, 1,  278, 2, nil, nil,  nil, { 14168, 14169,   nil,   nil,   nil, }, "Interface\\icons\\ability_warrior_riposte", },
			{ 2, 2,  269, 5,   0,   2,  270, { 14128, 14132, 14135, 14136, 14137, }, "Interface\\icons\\ability_criticalstrike", },
			{ 3, 1,  682, 5, nil, nil,  nil, { 16513, 16514, 16515, 16719, 16720, }, "Interface\\icons\\ability_rogue_feigndeath", },
			{ 3, 2,  268, 5, nil, nil,  nil, { 14113, 14114, 14115, 14116, 14117, }, "Interface\\icons\\ability_poisons", },
			{ 4, 1,  280, 1, nil, nil,  nil, { 14177,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_ice_lament", },
			{ 4, 2,  279, 3, nil, nil,  nil, { 14174, 14175, 14176,   nil,   nil, }, "Interface\\icons\\ability_rogue_kidneyshot", },
			{ 5, 1,  283, 5,   4,   1,  280, { 14186, 14190, 14193, 14194, 14195, }, "Interface\\icons\\spell_shadow_chilltouch", },
			{ 6, 1,  382, 1, nil, nil,  nil, { 14983,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_earthbindtotem", },
		},
		[183] =
		{
			{ 0, 1,  241, 5, nil, nil,  nil, { 13958, 13970, 13971, 13972, 13973, }, "Interface\\icons\\spell_shadow_charm", },
			{ 0, 2,  261, 5, nil, nil,  nil, { 14057, 14072, 14073, 14074, 14075, }, "Interface\\icons\\ability_warrior_warcry", },
			{ 1, 0, 1700, 2, nil, nil,  nil, { 30892, 30893,   nil,   nil,   nil, }, "Interface\\icons\\ability_rogue_feint", },
			{ 1, 1,  247, 2, nil, nil,  nil, { 13981, 14066,   nil,   nil,   nil, }, "Interface\\icons\\spell_magic_lesserinvisibilty", },
			{ 1, 2,  244, 5, nil, nil,  nil, { 13975, 14062, 14063, 14064, 14065, }, "Interface\\icons\\ability_stealth", },
			{ 2, 0,  245, 3, nil, nil,  nil, { 13976, 13979, 13980,   nil,   nil, }, "Interface\\icons\\spell_shadow_fumble", },
			{ 2, 1,  303, 1, nil, nil,  nil, { 14278,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_curse", },
			{ 2, 2,  263, 3, nil, nil,  nil, { 14079, 14080, 14081,   nil,   nil, }, "Interface\\icons\\ability_rogue_ambush", },
			{ 3, 0,  246, 3, nil, nil,  nil, { 13983, 14070, 14071,   nil,   nil, }, "Interface\\icons\\spell_nature_mirrorimage", },
			{ 3, 1,  262, 3, nil, nil,  nil, { 14076, 14094, 14095,   nil,   nil, }, "Interface\\icons\\ability_sap", },
			{ 3, 2, 1123, 3, nil, nil,  nil, { 14171, 14172, 14173,   nil,   nil, }, "Interface\\icons\\inv_sword_17", },
			{ 4, 0, 1701, 2, nil, nil,  nil, { 30894, 30895,   nil,   nil,   nil, }, "Interface\\icons\\ability_ambush", },
			{ 4, 1,  284, 1, nil, nil,  nil, { 14185,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_antishadow", },
			{ 4, 2,  265, 2, nil, nil,  nil, { 14082, 14083,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_summonsuccubus", },
			{ 4, 3,  681, 1,   3,   2, 1123, { 16511,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_lifedrain", },
			{ 5, 2, 1702, 5, nil, nil,  nil, { 30902, 30903, 30904, 30905, 30906, }, "Interface\\icons\\inv_weapon_crossbow_11", },
			{ 6, 1,  381, 1,   4,   1,  284, { 14183,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_possession", },
		},
	},
	priest =
	{
		[201] =
		{
			{ 0, 1,  342, 5, nil, nil,  nil, { 14522, 14788, 14789, 14790, 14791, }, "Interface\\icons\\spell_magic_magearmor", },
			{ 0, 2,  345, 5, nil, nil,  nil, { 14524, 14525, 14526, 14527, 14528, }, "Interface\\icons\\inv_wand_01", },
			{ 1, 0,  352, 5, nil, nil,  nil, { 14523, 14784, 14785, 14786, 14787, }, "Interface\\icons\\spell_nature_manaregentotem", },
			{ 1, 1,  344, 2, nil, nil,  nil, { 14749, 14767,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_wordfortitude", },
			{ 1, 2,  343, 3, nil, nil,  nil, { 14748, 14768, 14769,   nil,   nil, }, "Interface\\icons\\spell_holy_powerwordshield", },
			{ 1, 3,  321, 2, nil, nil,  nil, { 14531, 14774,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_tranquility", },
			{ 2, 1,  348, 1, nil, nil,  nil, { 14751,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_frost_windwalkon", },
			{ 2, 2,  347, 3, nil, nil,  nil, { 14521, 14776, 14777,   nil,   nil, }, "Interface\\icons\\spell_nature_sleep", },
			{ 3, 0,  346, 3, nil, nil,  nil, { 14747, 14770, 14771,   nil,   nil, }, "Interface\\icons\\spell_holy_innerfire", },
			{ 3, 1,  341, 5, nil, nil,  nil, { 14520, 14780, 14781, 14782, 14783, }, "Interface\\icons\\ability_hibernation", },
			{ 3, 3,  350, 2, nil, nil,  nil, { 14750, 14772,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_manaburn", },
			{ 4, 1, 1201, 5, nil, nil,  nil, { 18551, 18552, 18553, 18554, 18555, }, "Interface\\icons\\spell_nature_enchantarmor", },
			{ 4, 2,  351, 1,   2,   2,  347, { 14752,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_divinespirit", },
			{ 5, 2, 1202, 5, nil, nil,  nil, { 18544, 18547, 18548, 18549, 18550, }, "Interface\\icons\\spell_nature_slowingtotem", },
			{ 6, 1,  322, 1,   4,   1, 1201, { 10060,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_powerinfusion", },
		},
		[202] =
		{
			{ 0, 0,  410, 2, nil, nil,  nil, { 14913, 15012,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_healingfocus", },
			{ 0, 1,  406, 3, nil, nil,  nil, { 14908, 15020, 17191,   nil,   nil, }, "Interface\\icons\\spell_holy_renew", },
			{ 0, 2,  401, 5, nil, nil,  nil, { 14889, 15008, 15009, 15010, 15011, }, "Interface\\icons\\spell_holy_sealofsalvation", },
			{ 1, 1,  411, 5, nil, nil,  nil, { 27900, 27901, 27902, 27903, 27904, }, "Interface\\icons\\spell_holy_spellwarding", },
			{ 1, 2, 1181, 5, nil, nil,  nil, { 18530, 18531, 18533, 18534, 18535, }, "Interface\\icons\\spell_holy_sealofwrath", },
			{ 2, 0,  442, 1, nil, nil,  nil, { 15237,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_holynova", },
			{ 2, 1, 1636, 3, nil, nil,  nil, { 27811, 27815, 27816,   nil,   nil, }, "Interface\\icons\\spell_holy_blessedrecovery", },
			{ 2, 3,  361, 3, nil, nil,  nil, { 14892, 15362, 15363,   nil,   nil, }, "Interface\\icons\\spell_holy_layonhands", },
			{ 3, 0, 1635, 2, nil, nil,  nil, { 27789, 27790,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_purify", },
			{ 3, 1,  408, 3, nil, nil,  nil, { 14912, 15013, 15014,   nil,   nil, }, "Interface\\icons\\spell_holy_heal02", },
			{ 3, 2,  403, 2,   1,   2, 1181, { 14909, 15017,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_searinglightpriest", },
			{ 4, 0,  413, 2, nil, nil,  nil, { 14911, 15018,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_prayerofhealing02", },
			{ 4, 1, 1561, 1, nil, nil,  nil, { 20711,   nil,   nil,   nil,   nil, }, "Interface\\icons\\inv_enchant_essenceeternallarge", },
			{ 4, 2,  402, 5, nil, nil,  nil, { 14901, 15028, 15029, 15030, 15031, }, "Interface\\icons\\spell_holy_spiritualguidence", },
			{ 5, 2,  404, 5, nil, nil,  nil, { 14898, 15349, 15354, 15355, 15356, }, "Interface\\icons\\spell_nature_moonglow", },
			{ 6, 1, 1637, 1,   4,   1, 1561, { 724,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_summonlightwell", },
		},
		[203] =
		{
			{ 0, 1,  465, 5, nil, nil,  nil, { 15270, 15335, 15336, 15337, 15338, }, "Interface\\icons\\spell_shadow_requiem", },
			{ 0, 2,  464, 5, nil, nil,  nil, { 15268, 15323, 15324, 15325, 15326, }, "Interface\\icons\\spell_shadow_gathershadows", },
			{ 1, 0,  466, 3, nil, nil,  nil, { 15318, 15272, 15320,   nil,   nil, }, "Interface\\icons\\spell_shadow_shadowward", },
			{ 1, 1,  482, 2, nil, nil,  nil, { 15275, 15317,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_shadowwordpain", },
			{ 1, 2,  463, 5, nil, nil,  nil, { 15260, 15327, 15328, 15329, 15330, }, "Interface\\icons\\spell_shadow_burningspirit", },
			{ 2, 0,  542, 2, nil, nil,  nil, { 15392, 15448,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_psychicscream", },
			{ 2, 1,  481, 5, nil, nil,  nil, { 15273, 15312, 15313, 15314, 15316, }, "Interface\\icons\\spell_shadow_unholyfrenzy", },
			{ 2, 2,  501, 1, nil, nil,  nil, { 15407,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_siphonmana", },
			{ 3, 1,  483, 2, nil, nil,  nil, { 15274, 15311,   nil,   nil,   nil, }, "Interface\\icons\\spell_magic_lesserinvisibilty", },
			{ 3, 2,  881, 3, nil, nil,  nil, { 17322, 17323, 17325,   nil,   nil, }, "Interface\\icons\\spell_shadow_chilltouch", },
			{ 3, 3,  461, 5, nil, nil,  nil, { 15257, 15331, 15332, 15333, 15334, }, "Interface\\icons\\spell_shadow_blackplague", },
			{ 4, 0,  541, 1,   2,   0,  542, { 15487,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_impphaseshift", },
			{ 4, 1,  484, 1, nil, nil,  nil, { 15286,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_unsummonbuilding", },
			{ 4, 2, 1638, 2,   4,   1,  484, { 27839, 27840,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_improvedvampiricembrace", },
			{ 5, 2,  462, 5, nil, nil,  nil, { 15259, 15307, 15308, 15309, 15310, }, "Interface\\icons\\spell_shadow_twilight", },
			{ 6, 1,  521, 1,   4,   1,  484, { 15473,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_shadowform", },
		},
	},
	shaman =
	{
		[261] =
		{
			{ 0, 1,  564, 5, nil, nil,  nil, { 16039, 16109, 16110, 16111, 16112, }, "Interface\\icons\\spell_nature_wispsplode", },
			{ 0, 2,  563, 5, nil, nil,  nil, { 16035, 16105, 16106, 16107, 16108, }, "Interface\\icons\\spell_fire_fireball", },
			{ 1, 0,  572, 2, nil, nil,  nil, { 16043, 16130,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_stoneclawtotem", },
			{ 1, 1, 1640, 3, nil, nil,  nil, { 28996, 28997, 28998,   nil,   nil, }, "Interface\\icons\\spell_nature_spiritarmor", },
			{ 1, 2,  561, 3, nil, nil,  nil, { 16038, 16160, 16161,   nil,   nil, }, "Interface\\icons\\spell_fire_immolation", },
			{ 2, 0,  574, 1, nil, nil,  nil, { 16164,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_manaburn", },
			{ 2, 1,  575, 5, nil, nil,  nil, { 16040, 16113, 16114, 16115, 16116, }, "Interface\\icons\\spell_frost_frostward", },
			{ 2, 2,  562, 5, nil, nil,  nil, { 16041, 16117, 16118, 16119, 16120, }, "Interface\\icons\\spell_nature_callstorm", },
			{ 3, 0,  567, 2, nil, nil,  nil, { 16086, 16544,   nil,   nil,   nil, }, "Interface\\icons\\spell_fire_sealoffire", },
			{ 3, 1, 1642, 3, nil, nil,  nil, { 29062, 29064, 29065,   nil,   nil, }, "Interface\\icons\\spell_nature_eyeofthestorm", },
			{ 3, 3, 1645, 3, nil, nil,  nil, { 30160, 29179, 29180,   nil,   nil, }, "Interface\\icons\\spell_fire_elementaldevastation", },
			{ 4, 0, 1641, 2, nil, nil,  nil, { 28999, 29000,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_stormreach", },
			{ 4, 1,  565, 1, nil, nil,  nil, { 16089,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_fire_volcano", },
			{ 5, 2,  721, 5,   2,   2,  562, { 16578, 16579, 16580, 16581, 16582, }, "Interface\\icons\\spell_lightning_lightningbolt01", },
			{ 6, 1,  573, 1,   4,   1,  565, { 16166,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_wispheal", },
		},
		[262] =
		{
			{ 0, 1,  586, 5, nil, nil,  nil, { 16182, 16226, 16227, 16228, 16229, }, "Interface\\icons\\spell_nature_magicimmunity", },
			{ 0, 2,  593, 5, nil, nil,  nil, { 16179, 16214, 16215, 16216, 16217, }, "Interface\\icons\\spell_frost_manarecharge", },
			{ 1, 0,  589, 2, nil, nil,  nil, { 16184, 16209,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_reincarnation", },
			{ 1, 1,  581, 3, nil, nil,  nil, { 16176, 16235, 16240,   nil,   nil, }, "Interface\\icons\\spell_nature_undyingstrength", },
			{ 1, 2,  595, 5, nil, nil,  nil, { 16173, 16222, 16223, 16224, 16225, }, "Interface\\icons\\spell_nature_moonglow", },
			{ 2, 0,  583, 3, nil, nil,  nil, { 16180, 16196, 16198,   nil,   nil, }, "Interface\\icons\\spell_frost_stun", },
			{ 2, 1,  587, 5, nil, nil,  nil, { 16181, 16230, 16232, 16233, 16234, }, "Interface\\icons\\spell_nature_healingwavelesser", },
			{ 2, 2,  582, 1, nil, nil,  nil, { 16189,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_nullward", },
			{ 2, 3, 1646, 3, nil, nil,  nil, { 29187, 29189, 29191,   nil,   nil, }, "Interface\\icons\\spell_nature_healingtouch", },
			{ 3, 1,  588, 5, nil, nil,  nil, { 16187, 16205, 16206, 16207, 16208, }, "Interface\\icons\\spell_nature_manaregentotem", },
			{ 3, 2,  594, 5, nil, nil,  nil, { 16194, 16218, 16219, 16220, 16221, }, "Interface\\icons\\spell_nature_tranquility", },
			{ 4, 0, 1648, 3, nil, nil,  nil, { 29206, 29205, 29202,   nil,   nil, }, "Interface\\icons\\spell_nature_healingway", },
			{ 4, 2,  591, 1, nil, nil,  nil, { 16188,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_ravenform", },
			{ 5, 2,  592, 5, nil, nil,  nil, { 16178, 16210, 16211, 16212, 16213, }, "Interface\\icons\\spell_frost_wizardmark", },
			{ 6, 1,  590, 1,   3,   1,  588, { 16190,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_frost_summonwaterelemental", },
		},
		[263] =
		{
			{ 0, 1,  614, 5, nil, nil,  nil, { 17485, 17486, 17487, 17488, 17489, }, "Interface\\icons\\spell_shadow_grimward", },
			{ 0, 2,  612, 5, nil, nil,  nil, { 16253, 16298, 16299, 16300, 16301, }, "Interface\\icons\\inv_shield_06", },
			{ 1, 0,  609, 2, nil, nil,  nil, { 16258, 16293,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_stoneskintotem", },
			{ 1, 1,  613, 5, nil, nil,  nil, { 16255, 16302, 16303, 16304, 16305, }, "Interface\\icons\\ability_thunderbolt", },
			{ 1, 2,  605, 2, nil, nil,  nil, { 16262, 16287,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_spiritwolf", },
			{ 1, 3,  607, 3, nil, nil,  nil, { 16261, 16290, 16291,   nil,   nil, }, "Interface\\icons\\spell_nature_lightningshield", },
			{ 2, 0,  610, 2, nil, nil,  nil, { 16259, 16295,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_earthbindtotem", },
			{ 2, 2,  617, 1, nil, nil,  nil, { 16269,   nil,   nil,   nil,   nil, }, "Interface\\icons\\inv_axe_10", },
			{ 2, 3,  601, 5, nil, nil,  nil, { 16254, 16271, 16272, 16273, 16274, }, "Interface\\icons\\spell_nature_mirrorimage", },
			{ 3, 1,  602, 5,   1,   1,  613, { 16256, 16281, 16282, 16283, 16284, }, "Interface\\icons\\ability_ghoulfrenzy", },
			{ 3, 2,  615, 5, nil, nil,  nil, { 16252, 16306, 16307, 16308, 16309, }, "Interface\\icons\\spell_holy_devotion", },
			{ 4, 0, 1647, 2, nil, nil,  nil, { 29192, 29193,   nil,   nil,   nil, }, "Interface\\icons\\spell_fire_enchantweapon", },
			{ 4, 1,  611, 3, nil, nil,  nil, { 16266, 29079, 29080,   nil,   nil, }, "Interface\\icons\\spell_fire_flametounge", },
			{ 4, 2,  616, 1, nil, nil,  nil, { 16268,   nil,   nil,   nil,   nil, }, "Interface\\icons\\ability_parry", },
			{ 5, 2, 1643, 5, nil, nil,  nil, { 29082, 29084, 29086, 29087, 29088, }, "Interface\\icons\\ability_hunter_swiftstrike", },
			{ 6, 1,  901, 1,   4,   1,  611, { 17364,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_sealofmight", },
		},
	},
	druid =
	{
		[281] =
		{
			{ 0, 1,  796, 5, nil, nil,  nil, { 16934, 16935, 16936, 16937, 16938, }, "Interface\\icons\\ability_hunter_pet_hyena", },
			{ 0, 2,  795, 5, nil, nil,  nil, { 16858, 16859, 16860, 16861, 16862, }, "Interface\\icons\\ability_druid_demoralizingroar", },
			{ 1, 0,  799, 5, nil, nil,  nil, { 16947, 16948, 16949, 16950, 16951, }, "Interface\\icons\\ability_ambush", },
			{ 1, 1,  797, 2, nil, nil,  nil, { 16940, 16941,   nil,   nil,   nil, }, "Interface\\icons\\ability_druid_bash", },
			{ 1, 2,  794, 5, nil, nil,  nil, { 16929, 16930, 16931, 16932, 16933, }, "Interface\\icons\\inv_misc_pelt_bear_03", },
			{ 2, 0,  807, 2, nil, nil,  nil, { 17002, 24866,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_spiritwolf", },
			{ 2, 1,  804, 1, nil, nil,  nil, { 16979,   nil,   nil,   nil,   nil, }, "Interface\\icons\\ability_hunter_pet_bear", },
			{ 2, 2,  798, 3, nil, nil,  nil, { 16942, 16943, 16944,   nil,   nil, }, "Interface\\icons\\inv_misc_monsterclaw_04", },
			{ 3, 0,  802, 2, nil, nil,  nil, { 16966, 16968,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_vampiricaura", },
			{ 3, 1,  803, 3, nil, nil,  nil, { 16972, 16974, 16975,   nil,   nil, }, "Interface\\icons\\ability_hunter_pet_cat", },
			{ 3, 2,  800, 2,   2,   2,  798, { 16952, 16954,   nil,   nil,   nil, }, "Interface\\icons\\ability_ghoulfrenzy", },
			{ 3, 3,  801, 2,   2,   2,  798, { 16958, 16961,   nil,   nil,   nil, }, "Interface\\icons\\ability_racial_cannibalize", },
			{ 4, 0,  805, 2, nil, nil,  nil, { 16998, 16999,   nil,   nil,   nil, }, "Interface\\icons\\ability_druid_ravage", },
			{ 4, 2, 1162, 1, nil, nil,  nil, { 16857,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_faeriefire", },
			{ 5, 1,  808, 5,   3,   1,  803, { 17003, 17004, 17005, 17006, 24894, }, "Interface\\icons\\spell_holy_blessingofagility", },
			{ 6, 1,  809, 1, nil, nil,  nil, { 17007,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_unyeildingstamina", },
		},
		[282] =
		{
			{ 0, 1,  821, 5, nil, nil,  nil, { 17050, 17051, 17053, 17054, 17055, }, "Interface\\icons\\spell_nature_regeneration", },
			{ 0, 2,  822, 5, nil, nil,  nil, { 17056, 17058, 17059, 17060, 17061, }, "Interface\\icons\\spell_holy_blessingofstamina", },
			{ 1, 0,  824, 5, nil, nil,  nil, { 17069, 17070, 17071, 17072, 17073, }, "Interface\\icons\\spell_nature_healingtouch", },
			{ 1, 1,  823, 5, nil, nil,  nil, { 17063, 17065, 17066, 17067, 17068, }, "Interface\\icons\\spell_nature_healingwavegreater", },
			{ 1, 2,  826, 2, nil, nil,  nil, { 17079, 17082,   nil,   nil,   nil, }, "Interface\\icons\\ability_druid_enrage", },
			{ 2, 1,  829, 3, nil, nil,  nil, { 17106, 17107, 17108,   nil,   nil, }, "Interface\\icons\\spell_frost_windwalkon", },
			{ 2, 2,  827, 1, nil, nil,  nil, {  5570,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_insectswarm", },
			{ 2, 3,  841, 5, nil, nil,  nil, { 17118, 17119, 17120, 17121, 17122, }, "Interface\\icons\\ability_eyeoftheowl", },
			{ 3, 1,  843, 5, nil, nil,  nil, { 24968, 24969, 24970, 24971, 24972, }, "Interface\\icons\\spell_holy_elunesgrace", },
			{ 3, 3,  830, 3, nil, nil,  nil, { 17111, 17112, 17113,   nil,   nil, }, "Interface\\icons\\spell_nature_rejuvenation", },
			{ 4, 0,  831, 1,   1,   0,  824, { 17116,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_ravenform", },
			{ 4, 2,  828, 5,   2,   2,  827, { 17104, 24943, 24944, 24945, 24946, }, "Interface\\icons\\spell_nature_protectionformnature", },
			{ 4, 3,  842, 2, nil, nil,  nil, { 17123, 17124,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_tranquility", },
			{ 5, 2,  825, 5, nil, nil,  nil, { 17074, 17075, 17076, 17077, 17078, }, "Interface\\icons\\spell_nature_resistnature", },
			{ 6, 1,  844, 1,   3,   1,  843, { 18562,   nil,   nil,   nil,   nil, }, "Interface\\icons\\inv_relics_idolofrejuvenation", },
		},
		[283] =
		{
			{ 0, 0,  762, 5, nil, nil,  nil, { 16814, 16815, 16816, 16817, 16818, }, "Interface\\icons\\spell_nature_abolishmagic", },
			{ 0, 1,  761, 1, nil, nil,  nil, { 16689,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_natureswrath", },
			{ 0, 2,  921, 4,   0,   1,  761, { 17245, 17247, 17248, 17249,   nil, }, "Interface\\icons\\spell_nature_natureswrath", },
			{ 1, 0,  787, 3, nil, nil,  nil, { 16918, 16919, 16920,   nil,   nil, }, "Interface\\icons\\spell_nature_stranglevines", },
			{ 1, 1,  763, 5, nil, nil,  nil, { 16821, 16822, 16823, 16824, 16825, }, "Interface\\icons\\spell_nature_starfall", },
			{ 1, 2,  791, 5, nil, nil,  nil, { 16902, 16903, 16904, 16905, 16906, }, "Interface\\icons\\inv_staff_01", },
			{ 1, 3,  781, 3, nil, nil,  nil, { 16833, 16834, 16835,   nil,   nil, }, "Interface\\icons\\spell_nature_wispsplode", },
			{ 2, 0,  782, 3, nil, nil,  nil, { 16836, 16839, 16840,   nil,   nil, }, "Interface\\icons\\spell_nature_thorns", },
			{ 2, 2,  788, 1,   1,   2,  791, { 16864,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_crystalball", },
			{ 2, 3,  764, 2, nil, nil,  nil, { 16819, 16820,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_naturetouchgrow", },
			{ 3, 1,  792, 5,   1,   1,  763, { 16909, 16910, 16911, 16912, 16913, }, "Interface\\icons\\spell_nature_purge", },
			{ 3, 2,  784, 5, nil, nil,  nil, { 16850, 16923, 16924, 16925, 16926, }, "Interface\\icons\\spell_arcane_starfire", },
			{ 4, 1,  789, 1, nil, nil,  nil, { 16880,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_naturesblessing", },
			{ 4, 2,  783, 3, nil, nil,  nil, { 16845, 16846, 16847,   nil,   nil, }, "Interface\\icons\\spell_nature_sentinal", },
			{ 5, 1,  790, 5,   4,   1,  789, { 16896, 16897, 16899, 16900, 16901, }, "Interface\\icons\\spell_nature_moonglow", },
			{ 6, 1,  793, 1, nil, nil,  nil, { 24858,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_forceofnature", },
		},
	},
	warlock =
	{
		[301] =
		{
			{ 0, 1,  944, 5, nil, nil,  nil, { 17793, 17796, 17801, 17802, 17803, }, "Interface\\icons\\spell_shadow_shadowbolt", },
			{ 0, 2,  941, 5, nil, nil,  nil, { 17778, 17779, 17780, 17781, 17782, }, "Interface\\icons\\spell_fire_windsofwoe", },
			{ 1, 1,  943, 5, nil, nil,  nil, { 17788, 17789, 17790, 17791, 17792, }, "Interface\\icons\\spell_shadow_deathpact", },
			{ 1, 2,  982, 5, nil, nil,  nil, { 18119, 18120, 18121, 18122, 18123, }, "Interface\\icons\\spell_fire_fire", },
			{ 2, 0,  983, 2, nil, nil,  nil, { 18126, 18127,   nil,   nil,   nil, }, "Interface\\icons\\spell_fire_firebolt", },
			{ 2, 1,  984, 2, nil, nil,  nil, { 18128, 18129,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_curse", },
			{ 2, 2,  981, 5, nil, nil,  nil, { 18130, 18131, 18132, 18133, 18134, }, "Interface\\icons\\spell_fire_flameshock", },
			{ 2, 3,  963, 1, nil, nil,  nil, { 17877,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_scourgebuild", },
			{ 3, 0,  985, 2, nil, nil,  nil, { 18135, 18136,   nil,   nil,   nil, }, "Interface\\icons\\spell_fire_lavaspawn", },
			{ 3, 1,  964, 2, nil, nil,  nil, { 17917, 17918,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_corpseexplode", },
			{ 3, 3,  965, 5, nil, nil,  nil, { 17927, 17929, 17930, 17931, 17932, }, "Interface\\icons\\spell_fire_soulburn", },
			{ 4, 0,  986, 2,   3,   0,  985, { 18096, 18073,   nil,   nil,   nil, }, "Interface\\icons\\spell_fire_volcano", },
			{ 4, 1,  961, 5, nil, nil,  nil, { 17815, 17833, 17834, 17835, 17836, }, "Interface\\icons\\spell_fire_immolation", },
			{ 4, 2,  967, 1,   2,   2,  981, { 17959,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_shadowwordpain", },
			{ 5, 2,  966, 5, nil, nil,  nil, { 17954, 17955, 17956, 17957, 17958, }, "Interface\\icons\\spell_fire_selfdestruct", },
			{ 6, 1,  968, 1,   4,   1,  961, { 17962,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_fire_fireball", },
		},
		[302] =
		{
			{ 0, 1, 1005, 5, nil, nil,  nil, { 18174, 18175, 18176, 18177, 18178, }, "Interface\\icons\\spell_shadow_unsummonbuilding", },
			{ 0, 2, 1003, 5, nil, nil,  nil, { 17810, 17811, 17812, 17813, 17814, }, "Interface\\icons\\spell_shadow_abominationexplosion", },
			{ 1, 0, 1006, 3, nil, nil,  nil, { 18179, 18180, 18181,   nil,   nil, }, "Interface\\icons\\spell_shadow_curseofmannoroth", },
			{ 1, 1, 1101, 2, nil, nil,  nil, { 18213, 18372,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_haunting", },
			{ 1, 2, 1007, 2, nil, nil,  nil, { 18182, 18183,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_burningspirit", },
			{ 1, 3, 1004, 5, nil, nil,  nil, { 17804, 17805, 17806, 17807, 17808, }, "Interface\\icons\\spell_shadow_lifedrain02", },
			{ 2, 0, 1284, 3, nil, nil,  nil, { 18827, 18829, 18830,   nil,   nil, }, "Interface\\icons\\spell_shadow_curseofsargeras", },
			{ 2, 1, 1001, 5, nil, nil,  nil, { 17783, 17784, 17785, 17786, 17787, }, "Interface\\icons\\spell_shadow_fingerofdeath", },
			{ 2, 2, 1061, 1, nil, nil,  nil, { 18288,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_contagion", },
			{ 3, 0, 1021, 2, nil, nil,  nil, { 18218, 18219,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_callofbone", },
			{ 3, 1, 1002, 2, nil, nil,  nil, { 18094, 18095,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_twilight", },
			{ 3, 3, 1121, 2, nil, nil,  nil, { 17864, 18393,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_siphonmana", },
			{ 4, 1, 1041, 1, nil, nil,  nil, { 18265,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_requiem", },
			{ 4, 2, 1081, 1,   2,   2, 1061, { 18223,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_grimward", },
			{ 4, 3, 1082, 4,   4,   2, 1081, { 18310, 18311, 18312, 18313,   nil, }, "Interface\\icons\\spell_shadow_grimward", },
			{ 5, 1, 1042, 5,   4,   1, 1041, { 18271, 18272, 18273, 18274, 18275, }, "Interface\\icons\\spell_shadow_shadetruesight", },
			{ 6, 1, 1022, 1, nil, nil,  nil, { 18220,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_darkritual", },
		},
		[303] =
		{
			{ 0, 0, 1221, 2, nil, nil,  nil, { 18692, 18693,   nil,   nil,   nil, }, "Interface\\icons\\inv_stone_04", },
			{ 0, 1, 1222, 3, nil, nil,  nil, { 18694, 18695, 18696,   nil,   nil, }, "Interface\\icons\\spell_shadow_summonimp", },
			{ 0, 2, 1223, 5, nil, nil,  nil, { 18697, 18698, 18699, 18700, 18701, }, "Interface\\icons\\spell_shadow_metamorphosis", },
			{ 1, 0, 1224, 2, nil, nil,  nil, { 18703, 18704,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_lifedrain", },
			{ 1, 1, 1225, 3, nil, nil,  nil, { 18705, 18706, 18707,   nil,   nil, }, "Interface\\icons\\spell_shadow_summonvoidwalker", },
			{ 1, 2, 1242, 5, nil, nil,  nil, { 18731, 18743, 18744, 18745, 18746, }, "Interface\\icons\\spell_holy_magicalsentry", },
			{ 2, 0, 1243, 3, nil, nil,  nil, { 18754, 18755, 18756,   nil,   nil, }, "Interface\\icons\\spell_shadow_summonsuccubus", },
			{ 2, 1, 1226, 1, nil, nil,  nil, { 18708,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_removecurse", },
			{ 2, 2, 1241, 5, nil, nil,  nil, { 18748, 18749, 18750, 18751, 18752, }, "Interface\\icons\\spell_shadow_antishadow", },
			{ 3, 1, 1227, 2,   2,   1, 1226, { 18709, 18710,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_impphaseshift", },
			{ 3, 2, 1262, 5, nil, nil,  nil, { 18769, 18770, 18771, 18772, 18773, }, "Interface\\icons\\spell_shadow_shadowworddominate", },
			{ 4, 0, 1283, 5, nil, nil,  nil, { 18821, 18822, 18823, 18824, 18825, }, "Interface\\icons\\spell_shadow_enslavedemon", },
			{ 4, 1, 1281, 1, nil, nil,  nil, { 18788,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_psychicscream", },
			{ 4, 3, 1261, 2, nil, nil,  nil, { 18767, 18768,   nil,   nil,   nil, }, "Interface\\icons\\inv_ammo_firetar", },
			{ 5, 2, 1244, 5,   3,   2, 1262, { 23785, 23822, 23823, 23824, 23825, }, "Interface\\icons\\spell_shadow_shadowpact", },
			{ 6, 1, 1282, 1,   4,   1, 1281, { 19028,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_shadow_gathershadows", },
			{ 6, 2, 1263, 2, nil, nil,  nil, { 18774, 18775,   nil,   nil,   nil, }, "Interface\\icons\\inv_misc_gem_sapphire_01", },
		},
	},
	hunter =
	{
		[361] =
		{
			{ 0, 1, 1382, 5, nil, nil,  nil, { 19552, 19553, 19554, 19555, 19556, }, "Interface\\icons\\spell_nature_ravenform", },
			{ 0, 2, 1389, 5, nil, nil,  nil, { 19583, 19584, 19585, 19586, 19587, }, "Interface\\icons\\spell_nature_reincarnation", },
			{ 1, 0, 1624, 2, nil, nil,  nil, { 19557, 19558,   nil,   nil,   nil, }, "Interface\\icons\\ability_eyeoftheowl", },
			{ 1, 1, 1381, 5, nil, nil,  nil, { 19549, 19550, 19551, 24386, 24387, }, "Interface\\icons\\ability_hunter_aspectofthemonkey", },
			{ 1, 2, 1395, 3, nil, nil,  nil, { 19609, 19610, 19612,   nil,   nil, }, "Interface\\icons\\inv_misc_pelt_bear_03", },
			{ 1, 3, 1625, 2, nil, nil,  nil, { 24443, 19575,   nil,   nil,   nil, }, "Interface\\icons\\ability_hunter_beastsoothe", },
			{ 2, 0, 1384, 2, nil, nil,  nil, { 19559, 19560,   nil,   nil,   nil, }, "Interface\\icons\\ability_mount_jungletiger", },
			{ 2, 1, 1391, 1, nil, nil,  nil, { 19596,   nil,   nil,   nil,   nil, }, "Interface\\icons\\ability_druid_dash", },
			{ 2, 2, 1396, 5, nil, nil,  nil, { 19616, 19617, 19618, 19619, 19620, }, "Interface\\icons\\ability_bullrush", },
			{ 3, 1, 1385, 2, nil, nil,  nil, { 19572, 19573,   nil,   nil,   nil, }, "Interface\\icons\\ability_hunter_mendpet", },
			{ 3, 2, 1393, 5, nil, nil,  nil, { 19598, 19599, 19600, 19601, 19602, }, "Interface\\icons\\inv_misc_monsterclaw_04", },
			{ 4, 0, 1388, 2, nil, nil,  nil, { 19578, 20895,   nil,   nil,   nil, }, "Interface\\icons\\ability_druid_demoralizingroar", },
			{ 4, 1, 1387, 1, nil, nil,  nil, { 19577,   nil,   nil,   nil,   nil, }, "Interface\\icons\\ability_devour", },
			{ 4, 3, 1390, 2, nil, nil,  nil, { 19590, 19592,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_abolishmagic", },
			{ 5, 2, 1397, 5,   3,   2, 1393, { 19621, 19622, 19623, 19624, 19625, }, "Interface\\icons\\inv_misc_monsterclaw_03", },
			{ 6, 1, 1386, 1,   4,   1, 1387, { 19574,   nil,   nil,   nil,   nil, }, "Interface\\icons\\ability_druid_ferociousbite", },
		},
		[362] =
		{
			{ 0, 0, 1623, 3, nil, nil,  nil, { 24293, 24294, 24295,   nil,   nil, }, "Interface\\icons\\inv_misc_head_dragon_black", },
			{ 0, 1, 1301, 3, nil, nil,  nil, { 19151, 19152, 19153,   nil,   nil, }, "Interface\\icons\\spell_holy_prayerofhealing", },
			{ 0, 2, 1311, 5, nil, nil,  nil, { 19295, 19297, 19298, 19301, 19300, }, "Interface\\icons\\ability_parry", },
			{ 1, 0, 1304, 5, nil, nil,  nil, { 19184, 19387, 19388, 19389, 19390, }, "Interface\\icons\\spell_nature_stranglevines", },
			{ 1, 1, 1621, 2, nil, nil,  nil, { 19159, 19160,   nil,   nil,   nil, }, "Interface\\icons\\ability_racial_bloodrage", },
			{ 1, 2, 1305, 5, nil, nil,  nil, { 19228, 19232, 19233, 19234, 19235, }, "Interface\\icons\\ability_rogue_trip", },
			{ 2, 0, 1306, 2, nil, nil,  nil, { 19239, 19245,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_timestop", },
			{ 2, 1, 1622, 5, nil, nil,  nil, { 19255, 19256, 19257, 19258, 19259, }, "Interface\\icons\\spell_shadow_twilight", },
			{ 2, 2, 1308, 1, nil, nil,  nil, { 19263,   nil,   nil,   nil,   nil, }, "Interface\\icons\\ability_whirlwind", },
			{ 3, 0, 1322, 2, nil, nil,  nil, { 19376, 19377,   nil,   nil,   nil, }, "Interface\\icons\\ability_ensnare", },
			{ 3, 1, 1310, 3, nil, nil,  nil, { 19290, 19294, 24283,   nil,   nil, }, "Interface\\icons\\ability_kick", },
			{ 3, 3, 1309, 2, nil, nil,  nil, { 19286, 19287,   nil,   nil,   nil, }, "Interface\\icons\\ability_rogue_feigndeath", },
			{ 4, 1, 1321, 3, nil, nil,  nil, { 19370, 19371, 19373,   nil,   nil, }, "Interface\\icons\\spell_holy_blessingofstamina", },
			{ 4, 2, 1312, 1,   2,   2, 1308, { 19306,   nil,   nil,   nil,   nil, }, "Interface\\icons\\ability_warrior_challange", },
			{ 5, 2, 1303, 5, nil, nil,  nil, { 19168, 19180, 19181, 24296, 24297, }, "Interface\\icons\\spell_nature_invisibilty", },
			{ 6, 1, 1325, 1,   4,   1, 1321, { 19386,   nil,   nil,   nil,   nil, }, "Interface\\icons\\inv_spear_02", },
		},
		[363] =
		{
			{ 0, 1, 1341, 5, nil, nil,  nil, { 19407, 19412, 19413, 19414, 19415, }, "Interface\\icons\\spell_frost_stun", },
			{ 0, 2, 1342, 5, nil, nil,  nil, { 19416, 19417, 19418, 19419, 19420, }, "Interface\\icons\\spell_frost_wizardmark", },
			{ 1, 1, 1343, 5, nil, nil,  nil, { 19421, 19422, 19423, 19424, 19425, }, "Interface\\icons\\ability_hunter_snipershot", },
			{ 1, 2, 1344, 5, nil, nil,  nil, { 19426, 19427, 19429, 19430, 19431, }, "Interface\\icons\\ability_searingarrow", },
			{ 2, 0, 1345, 1, nil, nil,  nil, { 19434,   nil,   nil,   nil,   nil, }, "Interface\\icons\\inv_spear_07", },
			{ 2, 1, 1346, 5, nil, nil,  nil, { 19454, 19455, 19456, 19457, 19458, }, "Interface\\icons\\ability_impalingbolt", },
			{ 2, 3, 1352, 3, nil, nil,  nil, { 19498, 19499, 19500,   nil,   nil, }, "Interface\\icons\\ability_townwatch", },
			{ 3, 1, 1348, 5, nil, nil,  nil, { 19464, 19465, 19466, 19467, 19468, }, "Interface\\icons\\ability_hunter_quickshot", },
			{ 3, 2, 1349, 5,   1,   2, 1344, { 19485, 19487, 19488, 19489, 19490, }, "Interface\\icons\\ability_piercedamage", },
			{ 4, 0, 1353, 1, nil, nil,  nil, { 19503,   nil,   nil,   nil,   nil, }, "Interface\\icons\\ability_golemstormbolt", },
			{ 4, 1, 1347, 3, nil, nil,  nil, { 19461, 19462, 24691,   nil,   nil, }, "Interface\\icons\\ability_upgrademoonglaive", },
			{ 4, 2, 1351, 3, nil, nil,  nil, { 19491, 19493, 19494,   nil,   nil, }, "Interface\\icons\\ability_hunter_criticalshot", },
			{ 5, 2, 1362, 5, nil, nil,  nil, { 19507, 19508, 19509, 19510, 19511, }, "Interface\\icons\\inv_weapon_rifle_06", },
			{ 6, 1, 1361, 1,   4,   1, 1347, { 19506,   nil,   nil,   nil,   nil, }, "Interface\\icons\\ability_trueshot", },
		},
	},
	paladin =
	{
		[381] =
		{
			{ 0, 1, 1401, 5, nil, nil,  nil, { 20042, 20045, 20046, 20047, 20048, }, "Interface\\icons\\spell_holy_fistofjustice", },
			{ 0, 2, 1407, 5, nil, nil,  nil, { 20101, 20102, 20103, 20104, 20105, }, "Interface\\icons\\spell_frost_windwalkon", },
			{ 1, 0, 1631, 2, nil, nil,  nil, { 25956, 25957,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_righteousfury", },
			{ 1, 1, 1464, 3, nil, nil,  nil, { 20335, 20336, 20337,   nil,   nil, }, "Interface\\icons\\spell_holy_holysmite", },
			{ 1, 2, 1403, 5, nil, nil,  nil, { 20060, 20061, 20062, 20063, 20064, }, "Interface\\icons\\ability_parry", },
			{ 2, 0, 1633, 3, nil, nil,  nil, {  9452, 26016, 26021,   nil,   nil, }, "Interface\\icons\\spell_holy_vindication", },
			{ 2, 1, 1411, 5, nil, nil,  nil, { 20117, 20118, 20119, 20120, 20121, }, "Interface\\icons\\spell_holy_retributionaura", },
			{ 2, 2, 1481, 1, nil, nil,  nil, { 20375,   nil,   nil,   nil,   nil, }, "Interface\\icons\\ability_warrior_innerrage", },
			{ 2, 3, 1634, 2, nil, nil,  nil, { 26022, 26023,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_persuitofjustice", },
			{ 3, 0, 1632, 2, nil, nil,  nil, {  9799, 25988,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_eyeforaneye", },
			{ 3, 2, 1405, 2, nil, nil,  nil, { 20091, 20092,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_auraoflight", },
			{ 4, 0, 1410, 3, nil, nil,  nil, { 20111, 20112, 20113,   nil,   nil, }, "Interface\\icons\\inv_hammer_04", },
			{ 4, 2, 1409, 1, nil, nil,  nil, { 20218,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_mindvision", },
			{ 5, 1, 1402, 5,   2,   1, 1411, { 20049, 20056, 20057, 20058, 20059, }, "Interface\\icons\\ability_racial_avatar", },
			{ 6, 1, 1441, 1, nil, nil,  nil, { 20066,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_prayerofhealing", },
		},
		[382] =
		{
			{ 0, 1, 1450, 5, nil, nil,  nil, { 20262, 20263, 20264, 20265, 20266, }, "Interface\\icons\\ability_golemthunderclap", },
			{ 0, 2, 1449, 5, nil, nil,  nil, { 20257, 20258, 20259, 20260, 20261, }, "Interface\\icons\\spell_nature_sleep", },
			{ 1, 1, 1432, 5, nil, nil,  nil, { 20205, 20206, 20207, 20209, 20208, }, "Interface\\icons\\spell_arcane_blink", },
			{ 1, 2, 1463, 5, nil, nil,  nil, { 20224, 20225, 20330, 20331, 20332, }, "Interface\\icons\\ability_thunderbolt", },
			{ 2, 0, 1444, 3, nil, nil,  nil, { 20237, 20238, 20239,   nil,   nil, }, "Interface\\icons\\spell_holy_holybolt", },
			{ 2, 1, 1435, 1, nil, nil,  nil, { 26573,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_innerfire", },
			{ 2, 2, 1443, 2, nil, nil,  nil, { 20234, 20235,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_layonhands", },
			{ 2, 3, 1628, 2, nil, nil,  nil, {  9453, 25836,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_unyieldingfaith", },
			{ 3, 1, 1461, 5, nil, nil,  nil, { 20210, 20212, 20213, 20214, 20215, }, "Interface\\icons\\spell_holy_greaterheal", },
			{ 3, 2, 1446, 2, nil, nil,  nil, { 20244, 20245,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_sealofwisdom", },
			{ 4, 1, 1433, 1,   3,   1, 1461, { 20216,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_heal", },
			{ 4, 2, 1465, 3, nil, nil,  nil, { 20359, 20360, 20361,   nil,   nil, }, "Interface\\icons\\spell_holy_healingaura", },
			{ 5, 2, 1627, 5, nil, nil,  nil, {  5923,  5924,  5925,  5926, 25829, }, "Interface\\icons\\spell_holy_power", },
			{ 6, 1, 1502, 1,   4,   1, 1433, { 20473,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_searinglight", },
		},
		[383] =
		{
			{ 0, 1, 1422, 5, nil, nil,  nil, { 20138, 20139, 20140, 20141, 20142, }, "Interface\\icons\\spell_holy_devotionaura", },
			{ 0, 2, 1421, 5, nil, nil,  nil, { 20127, 20130, 20135, 20136, 20137, }, "Interface\\icons\\ability_defend", },
			{ 1, 0, 1630, 3, nil, nil,  nil, { 20189, 20192, 20193,   nil,   nil, }, "Interface\\icons\\ability_rogue_ambush", },
			{ 1, 1, 1425, 2, nil, nil,  nil, { 20174, 20175,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_sealofprotection", },
			{ 1, 3, 1423, 5, nil, nil,  nil, { 20143, 20144, 20145, 20146, 20147, }, "Interface\\icons\\spell_holy_devotion", },
			{ 2, 0, 1442, 1, nil, nil,  nil, { 20217,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_magic_magearmor", },
			{ 2, 1, 1501, 3, nil, nil,  nil, { 20468, 20469, 20470,   nil,   nil, }, "Interface\\icons\\spell_holy_sealoffury", },
			{ 2, 2, 1424, 3,   0,   2, 1421, { 20148, 20149, 20150,   nil,   nil, }, "Interface\\icons\\inv_shield_06", },
			{ 2, 3, 1629, 5, nil, nil,  nil, { 20096, 20097, 20098, 20099, 20100, }, "Interface\\icons\\spell_magic_lesserinvisibilty", },
			{ 3, 1, 1521, 3, nil, nil,  nil, { 20487, 20488, 20489,   nil,   nil, }, "Interface\\icons\\spell_holy_sealofmight", },
			{ 3, 2, 1626, 3, nil, nil,  nil, { 20254, 20255, 20256,   nil,   nil, }, "Interface\\icons\\spell_holy_mindsooth", },
			{ 4, 1, 1431, 1, nil, nil,  nil, { 20911,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_nature_lightningshield", },
			{ 4, 2, 1426, 5, nil, nil,  nil, { 20177, 20179, 20181, 20180, 20182, }, "Interface\\icons\\spell_holy_blessingofstrength", },
			{ 5, 2, 1429, 5, nil, nil,  nil, { 20196, 20197, 20198, 20199, 20200, }, "Interface\\icons\\inv_sword_20", },
			{ 6, 1, 1430, 1,   4,   1, 1431, { 20925,   nil,   nil,   nil,   nil, }, "Interface\\icons\\spell_holy_blessingofprotection", },
		},
	},
};

NS._classToIndex = {  };
for i = 1, #NS._indexToClass do
	NS._classToIndex[NS._indexToClass[i]] = i;
end

NS._talentTabIcon =
{
	[41] = "Interface\\Icons\\spell_fire_firebolt02",
	[61] = "Interface\\Icons\\spell_frost_frostbolt02",
	[81] = "Interface\\Icons\\inv_misc_rune_03",
	[161] = "Interface\\Icons\\ability_rogue_eviscerate",--
	[163] = "Interface\\Icons\\ability_warrior_defensivestance",
	[164] = "Interface\\Icons\\ability_warrior_innerrage",
	[181] = "Interface\\Icons\\ability_backstab",
	[182] = "Interface\\Icons\\ability_rogue_eviscerate",--
	[183] = "Interface\\Icons\\Ability_Ambush",
	[201] = "Interface\\Icons\\spell_holy_wordfortitude",
	[202] = "Interface\\Icons\\spell_holy_holybolt",
	[203] = "Interface\\Icons\\spell_shadow_shadowwordpain",
	[261] = "Interface\\Icons\\spell_nature_lightning",
	[262] = "Interface\\Icons\\Spell_Nature_HealingWaveGreater",
	[263] = "Interface\\Icons\\spell_nature_lightningshield",
	[281] = "Interface\\Icons\\ability_racial_bearform",
	[282] = "Interface\\Icons\\Spell_Nature_HealingTouch",
	[283] = "Interface\\Icons\\spell_nature_starfall",
	[301] = "Interface\\Icons\\spell_shadow_rainoffire",
	[302] = "Interface\\Icons\\spell_shadow_deathcoil",
	[303] = "Interface\\Icons\\spell_shadow_metamorphosis",
	[361] = "Interface\\Icons\\Ability_Hunter_BeastTaming",
	[362] = "Interface\\Icons\\Ability_Hunter_SwiftStrike",
	[363] = "Interface\\Icons\\Ability_Marksmanship",
	[381] = "Interface\\Icons\\Spell_Holy_AuraOfLight",
	[382] = "Interface\\Icons\\Spell_Holy_HolyBolt",
	[383] = "Interface\\Icons\\Spell_Holy_DevotionAura",
	
	[398] = "Interface\\Icons\\Spell_Deathknight_BloodPresence",
	[399] = "Interface\\Icons\\Spell_Deathknight_FrostPresence",
	[400] = "Interface\\Icons\\Spell_Deathknight_UnholyPresence",
	[409] = "Interface\\Icons\\Ability_Hunter_Pet_Bear",
	[410] = "Interface\\Icons\\Ability_Druid_Swipe",
	[411] = "Interface\\Icons\\Ability_Hunter_CombatExperience",
};

NS._BG = {
		[283] = "Interface\\TalentFrame\\DruidBalance-TopLeft",
		[281] = "Interface\\TalentFrame\\DruidFeralCombat-TopLeft",
		[282] = "Interface\\TalentFrame\\DruidRestoration-TopLeft",
		[361] = "Interface\\TalentFrame\\HunterBeastMastery-TopLeft",
		[363] = "Interface\\TalentFrame\\HunterMarksmanship-TopLeft",
		[362] = "Interface\\TalentFrame\\HunterSurvival-TopLeft",
		[81] = "Interface\\TalentFrame\\MageArcane-TopLeft",
		[41] = "Interface\\TalentFrame\\MageFire-TopLeft",
		[61] = "Interface\\TalentFrame\\MageFrost-TopLeft",
		[382] = "Interface\\TalentFrame\\PaladinHoly-TopLeft",
		[383] = "Interface\\TalentFrame\\PaladinProtection-TopLeft",
		[381] = "Interface\\TalentFrame\\PaladinCombat-TopLeft",
		[201] = "Interface\\TalentFrame\\PriestDiscipline-TopLeft",
		[202] = "Interface\\TalentFrame\\PriestHoly-TopLeft",
		[203] = "Interface\\TalentFrame\\PriestShadow-TopLeft",
		[182] = "Interface\\TalentFrame\\RogueAssassination-TopLeft",
		[181] = "Interface\\TalentFrame\\RogueCombat-TopLeft",
		[183] = "Interface\\TalentFrame\\RogueSubtlety-TopLeft",
		[261] = "Interface\\TalentFrame\\ShamanElementalCombat-TopLeft",
		[263] = "Interface\\TalentFrame\\ShamanEnhancement-TopLeft",
		[262] = "Interface\\TalentFrame\\ShamanRestoration-TopLeft",
		[302] = "Interface\\TalentFrame\\WarlockCurses-TopLeft",
		[303] = "Interface\\TalentFrame\\WarlockSummoning-TopLeft",
		[301] = "Interface\\TalentFrame\\WarlockDestruction-TopLeft",
		[161] = "Interface\\TalentFrame\\WarriorArms-TopLeft",
		[164] = "Interface\\TalentFrame\\WarriorFury-TopLeft",
		[163] = "Interface\\TalentFrame\\WarriorProtection-TopLeft",
};

NS._preset_talent = {
	druid =
	{
		H = {
			E = {
				"https://classic.wowhead.com/talent-calc/druid/5140000302--505203105315051",
				"https://classic.wowhead.com/talent-calc/druid/51000533120013--505103105115",
				"https://classic.wowhead.com/talent-calc/druid/4140050312001--50510310501504",
				"https://classic.wowhead.com/talent-calc/druid/-503050130302215-05501310501",
			},
			P = {
				"https://classic.wowhead.com/talent-calc/druid/0140002-5002321-055103105315011",
				"https://classic.wowhead.com/talent-calc/druid/-500242130320215-05501310231",
			},
		},
		D = {
			E = {
				"https://classic.wowhead.com/talent-calc/druid/0142503002551351--5005031",
				"https://classic.wowhead.com/talent-calc/druid/510050300250135--50502310131",
				"https://classic.wowhead.com/talent-calc/druid/014005301-5500021323202151-05",
			},
			P = {
				"https://classic.wowhead.com/talent-calc/druid/0143503002551351--5005021",
			},
		},
		T = {
			E = {
				"https://classic.wowhead.com/talent-calc/druid/014005001-5050501303022151-05002",
				"https://classic.wowhead.com/talent-calc/druid/014005001-5050301323222151-05",
			},
		},
	},
	hunter =
	{
		D = {
			E = {
				"https://classic.wowhead.com/talent-calc/hunter/2-05251030513051-33202004103",
				"https://classic.wowhead.com/talent-calc/hunter/55000000505-05251030513051",
				"https://classic.wowhead.com/talent-calc/hunter/-05151030501-332020251030315",
			},
			P = {
				"https://classic.wowhead.com/talent-calc/hunter/-5105103051-005025051030315",
				"https://classic.wowhead.com/talent-calc/hunter/5300020150501-51051030513-005",
			},
		}
	},
	mage =
	{
		D = {
			E = {
				"https://classic.wowhead.com/talent-calc/mage/2300450310031531--053500030013",
				"https://classic.wowhead.com/talent-calc/mage/230045200003--05350013122301051",
				"https://classic.wowhead.com/talent-calc/mage/230025-5052023123033151-003",
			},
			P = {
				"https://classic.wowhead.com/talent-calc/mage/20500520102--05053232112051301",
				"https://classic.wowhead.com/talent-calc/mage/-05520201230031-050132301120513",
			},
		},
	},
	paladin =
	{
		H = {
			E = {
				"https://classic.wowhead.com/talent-calc/paladin/05503122521351-503201-5",
				"https://classic.wowhead.com/talent-calc/paladin/05503122521051-50325100003",
				"https://classic.wowhead.com/talent-calc/paladin/0550312152105-503251000131",
			},
			P = {
				"https://classic.wowhead.com/talent-calc/paladin/05503122521051-5032510003",
				"https://classic.wowhead.com/talent-calc/paladin/05503122521051-5002-05205",
			},
		},
		D = {
			E = {
				"https://classic.wowhead.com/talent-calc/paladin/505001-503-542300512003151",
				"https://classic.wowhead.com/talent-calc/paladin/5550010002--552300512003151",
				"https://classic.wowhead.com/talent-calc/paladin/52-503201-552300512003151",
			},
			P = {
				"https://classic.wowhead.com/talent-calc/paladin/505-5032-542000512203151",
				"https://classic.wowhead.com/talent-calc/paladin/1-5032510013005-5420005122031",
			},
		},
		T = {
			E = {
				"https://classic.wowhead.com/talent-calc/paladin/050501-553050335001001-05004",
			},
		},
	},
	priest =
	{
		H = {
			E = {
				"https://classic.wowhead.com/talent-calc/priest/5012301305001-025051031300055",
				"https://classic.wowhead.com/talent-calc/priest/505230130505101-0250510313",
			},
			P = {
				"https://classic.wowhead.com/talent-calc/priest/500232130515051-2150511003",
				"https://classic.wowhead.com/talent-calc/priest/500232133101-225051132300105",
			},
		},
		D = {
			E = {
				"https://classic.wowhead.com/talent-calc/priest/0512301305--5032500103501051",
				"https://classic.wowhead.com/talent-calc/priest/50520013--5032504103501051",
			},
			P = {
				"https://classic.wowhead.com/talent-calc/priest/5002321--0502525103511251",
				"https://classic.wowhead.com/talent-calc/priest/500232132025151-00545100202",
			},
		},
	},
	rogue =
	{
		D = {
			E = {
				"https://classic.wowhead.com/talent-calc/rogue/005323105-3210052020050150231",
				"https://classic.wowhead.com/talent-calc/rogue/00532310505105-320305002001-05",
			},
			P = {
				"https://classic.wowhead.com/talent-calc/rogue/305320115001-3-500253000332121",
				"https://classic.wowhead.com/talent-calc/rogue/005320105-320302002-05024303030012",
			},
		},
	},
	shaman =
	{
		H = {
			E = {
				"https://classic.wowhead.com/talent-calc/shaman/-5-552350510553151",
				"https://classic.wowhead.com/talent-calc/shaman/-5120202-550300510553151",
			},
			P = {
				"https://classic.wowhead.com/talent-calc/shaman/5003215013001--05033301015315",
				"https://classic.wowhead.com/talent-calc/shaman/5003-05002-05035351005315",
			},
		},
		D = {
			E = {
				"https://classic.wowhead.com/talent-calc/shaman/550331050002151--05204301005",
				"https://classic.wowhead.com/talent-calc/shaman/-5025002105023051-0510530105",
			},
			P = {
				"https://classic.wowhead.com/talent-calc/shaman/55000135030215--0523031100501",
				"https://classic.wowhead.com/talent-calc/shaman/05023140003-5015202105023151",
			},
		},
	},
	warlock =
	{
		D = {
			E = {
				"https://classic.wowhead.com/talent-calc/warlock/25002-2050300142301-52500051020001",
				"https://classic.wowhead.com/talent-calc/warlock/5530203012201105--50502051020001",
				"https://classic.wowhead.com/talent-calc/warlock/01-234035010250004-50502051020001",
			},
			P = {
				"https://classic.wowhead.com/talent-calc/warlock/35000232122-2050310152501051",
				"https://classic.wowhead.com/talent-calc/warlock/35-2050310152501051-50500011",
				"https://classic.wowhead.com/talent-calc/warlock/3500023212201135--50520051020001",
				"https://classic.wowhead.com/talent-calc/warlock/35000231122-001-5052005102005141",
			},
		},
	},
	warrior =
	{
		D = {
			E = {
				"https://classic.wowhead.com/talent-calc/warrior/20305011302-05050005525010051",
				"https://classic.wowhead.com/talent-calc/warrior/20305011322-05050005005510051",
				"https://classic.wowhead.com/talent-calc/warrior/20305011332-05052005025010051",
			},
			P = {
				"https://classic.wowhead.com/talent-calc/warrior/023050213320105031-55000131005",

			},
		},
		T = {
			E = {
				"https://classic.wowhead.com/talent-calc/warrior/05005001-05-50250113530211051",
				"https://classic.wowhead.com/talent-calc/warrior/-05050105125010051-5023011053",
			},
		},
	},
}

