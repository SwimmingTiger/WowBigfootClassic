--[[--
	by ALA @ 163UI
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

-->		upvalue
	local pcall = pcall;
	local type = type;
	local next = next;
	local select = select;
	local concat = table.concat;
	local strupper, strsub, strmatch, format = string.upper, string.sub, string.match, string.format;
	local max = math.max;
	local tonumber = tonumber;
	local random = random;
	local UnitLevel = UnitLevel;
	local GetSpellInfo = GetSpellInfo;
	local GetTalentTabInfo, GetNumTalents, GetTalentInfo, LearnTalent = GetTalentTabInfo, GetNumTalents, GetTalentInfo, LearnTalent;
	local GetItemInfoInstant = GetItemInfoInstant;
	local GetItemInfo = GetItemInfo;
	local CreateFrame = CreateFrame;
	local _G = _G;
	local UIParent = UIParent;
	local GameTooltip = GameTooltip;
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS;

-->
	local l10n = CT.l10n;

-->		constant
-->
MT.BuildEnv('METHOD');
-->		predef
-->		METHOD
	--
	if CT.BUILD == "CLASSIC" then
		local __ala_meta__ = _G.__ala_meta__;
		_G.ALA_GetSpellLink = _G.ALA_GetSpellLink or function(id, name)
			--|cff71d5ff|Hspell:id|h[name]|h|r
			name = name or GetSpellInfo(id);
			if name then
				if __ala_meta__.chat and __ala_meta__.chat.alac_hyperLink and __ala_meta__.chat.alac_hyperLink() then
					return "|cff71d5ff|Hspell:" .. id .. "|h[" .. name .. "]|h|r";
				else
					return name;
				end
			else
				return nil;
			end
		end
	elseif CT.BUILD == "BCC" or CT.BUILD == "WRATH" then
		_G.ALA_GetSpellLink = _G.ALA_GetSpellLink or function(id, name)
			--|cff71d5ff|Hspell:id|h[name]|h|r
			name = name or GetSpellInfo(id);
			if name then
				return "|cff71d5ff|Hspell:" .. id .. "|h[" .. name .. "]|h|r";
			else
				return nil;
			end
		end
	end
	MT.GetSpellLink = _G.ALA_GetSpellLink;

	--		ItemLevel
		local _ItemTryTimes = {  };
		function MT.CalcItemLevel(class, EquData)
			local slots = { 1, 2, 3, 5, 6, 7, 8,9, 10, 11, 12, 13, 14, 15, };
			if class ~= "DRUID" and class ~= "PALADIN" and class ~= "SHAMAN" then
				slots[#slots + 1] = 18;
			end
			slots[#slots + 1] = 16;
			slots[#slots + 1] = 17;		--	make it the last in table
			--	16MainHand, 17OffHand, 18Ranged
			local refresh_again = false;
			local total = 0;
			local num1, num2 = 0, 0;
			for index = 1, #slots do
				num1 = num1 + 1;
				local slot = slots[index];
				local item = EquData[slot];
				if item ~= nil and item ~= "" then
					local _, _, _, level, _, _, _, _, loc = GetItemInfo(item);
					if level ~= nil then
						total = total + level;
						num2 = num2 + 1;
					else
						_ItemTryTimes[item] = (_ItemTryTimes[item] or 0) + 1;
						if _ItemTryTimes[item] < 10 then
							refresh_again = true;
						end
					end
					if slot == 16 and loc == "INVTYPE_2HWEAPON" then
						break;
					end
				end
			end
			if num1 == 0 or num2 == 0 then
				return;
			end
			return total / num1, total / num2, refresh_again;
		end
	-->		Enchant
		--	old
		local enchant_hash = {	--	[enchant] = spell	--	13503, 13693, 20031
			INVTYPE_HEAD = {
				[1483] = 15340,
				[1503] = 15389,
				[1504] = 15391,
				[1505] = 15394,
				[1506] = 15397,
				[1507] = 15400,
				[1508] = 15402,
				[1509] = 15404,
				[1510] = 15406,
				[2543] = 22840,
				[2544] = 22844,
				[2545] = 22846,
				[2583] = 24149,
				[2584] = 24160,
				[2585] = 24161,
				[2586] = 24162,
				[2587] = 24163,
				[2588] = 24164,
				[2589] = 24165,
				[2590] = 24167,
				[2591] = 24168,
				[2681] = 28161,
				[2682] = 28163,
				[2683] = 28165,
				[1523] = 15427,		--	unknow
				[1524] = 15429,		--	unknow
				[1525] = 15439,		--	unknow
				[1526] = 15441,		--	unknow
				[1527] = 15444,		--	unknow
				[1528] = 15446,		--	unknow
				[1529] = 15449,		--	unknow
				[1530] = 15458,		--	unknow
				[1532] = 15463,		--	unknow
				[1543] = 15490,		--	unknow
			},
			INVTYPE_SHOULDER = {
				[2483] = 22593,
				[2484] = 22594,
				[2485] = 22598,
				[2486] = 22597,
				[2487] = 22596,
				[2488] = 22599,
				--
				[2605] = 24421,
				[2606] = 24422,
				[2604] = 24420,
				--
				[2721] = 29467,
				[2715] = 29475,
				[2717] = 29483,
				[2716] = 29480,
				--
				[3755] = 24161,		--	unk
				[3754] = 24162,		--	unk
			},
			INVTYPE_CHEST = {		--	chest
				[850] = 13640,
				[928] = 13941,
				[913] = 13917,
				[1891] = 20025,
				[1503] = 20026,
				[1892] = 20026,
				[1893] = 20028,
				[41] = 7420,
				[44] = 7426,
				[242] = 7748,
				[246] = 7776,
				[254] = 7857,
				[843] = 13607,
				[908] = 13858,
				[24] = 7443,
				[847] = 13626,
				[63] = 13538,
				[866] = 13700,
				[857] = 13663,
				[15] = 2831,
				[16] = 2832,
				[17] = 2833,
				[18] = 10344,
				[1843] = 19057,
				[2503] = 22725,
			},
			INVTYPE_LEGS = {
				[15] = 2831,
				[16] = 2832,
				[17] = 2833,
				[18] = 10344,
				[1843] = 19057,
				[2503] = 22725,
				[1483] = 15340,
				[1503] = 15389,
				[1504] = 15391,
				[1505] = 15394,
				[1506] = 15397,
				[1507] = 15400,
				[1508] = 15402,
				[1509] = 15404,
				[1510] = 15406,
				[2543] = 22840,
				[2544] = 22844,
				[2545] = 22846,
				[2583] = 24149,
				[2584] = 24160,
				[2585] = 24161,
				[2586] = 24162,
				[2587] = 24163,
				[2588] = 24164,
				[2589] = 24165,
				[2590] = 24167,
				[2591] = 24168,
				[2681] = 28161,
				[2682] = 28163,
				[2683] = 28165,
				[1523] = 15427,		--	unknow
				[1524] = 15429,		--	unknow
				[1525] = 15439,		--	unknow
				[1526] = 15441,		--	unknow
				[1527] = 15444,		--	unknow
				[1528] = 15446,		--	unknow
				[1529] = 15449,		--	unknow
				[1530] = 15458,		--	unknow
				[1532] = 15463,		--	unknow
				[1543] = 15490,		--	unknow
			-->		TradeSkill
				[3327] = 60583,	--	冰虫腿甲强化片
				[3328] = 60584,	--	蛛魔腿甲强化片
			},
			INVTYPE_FEET = {		--	boot
				[255] = 13687,
				[849] = 13637,
				[91] = 13935,
				[93] = 20023,
				[64] = 13687,
				[66] = 7863,
				[99] = 20024,
				[103] = 13836,
				[105] = 20020,
				[76] = 13637,
				[84] = 13687,
				[904] = 13935,
				[851] = 20024,
				[852] = 13836,
				[74] = 7867,
				[71] = 7863,
				[73] = 13644,
				[929] = 20020,
				[911] = 13890,
				[247] = 7867,
				[724] = 13644,
				[1887] = 20023,
				[464] = 9783,
				[15] = 2831,
				[16] = 2832,
				[17] = 2833,
				[18] = 10344,
				[1843] = 19057,
				[2503] = 22725,
				-->
				[4726] = 13687,
				--
				[983] = 44589,
			-->		TradeSkill
				[3606] = 55016,	--	硝化甘油推进器
			},
			INVTYPE_WRIST = {		--	wrist
				[1884] = 20009,
				[355] = 20009,
				[1903] = 20009,
				[1886] = 20011,
				[356] = 20011,
				[2698] = 20011,
				[107] = 13661,
				[856] = 13661,
				[95] = 13822,
				[905] = 13822,
				[101] = 13846,
				[907] = 13846,
				[74] = 7779,
				[247] = 7779,
				[4725] = 7779,
				[73] = 13501,
				[724] = 13501,
				[4730] = 13501,
				[103] = 13648,
				[852] = 13648,
				[4737] = 13648,
				--	[112] = 13931,
				[923] = 13931,
				--	[925] = 13931,
				--	[924] = 13646,
				[925] = 13646,
				[111] = 13646,
				[105] = 13945,
				[929] = 13945,
				[4743] = 13945,
				[81] = 13622,
				[723] = 13622,
				[4729] = 13622,
				[97] = 20008,
				[1883] = 20008,
				[66] = 7457,
				[71] = 7457,
				[4721] = 7457,
				[82] = 7766,
				[243] = 7766,
				[70] = 13536,
				[823] = 13536,
				[357] = 20010,
				[1885] = 20010,
				[99] = 13642,
				[851] = 13642,
				[4735] = 13642,
				[68] = 7782,
				[248] = 7782,
				[64] = 7859,
				[84] = 7859,
				[255] = 7859,
				[4727] = 7859,
				[109] = 13939,
				[927] = 13939,
				[110] = 7428,
				[924] = 7428,
				[2371] = 23801,
				[2372] = 23801,
				[2373] = 23801,
				[2565] = 23801,
				[41] = 7418,
				[4720] = 7418,
				[2566] = 23802,		--	24heal		>>	13sp	--	current
				[2608] = 23802,		--	24heal		>>	13sp
				[2319] = 23802,		--	24heal		>>	15sp
				[2609] = 23802,		--	24heal		>>	15sp
				[2650] = 23802,		--	24heal		>>	15sp
				--
				[1593] = 34002,
			-->		TradeSkill
				[3758] = 57691,	--	毛皮衬垫 - 法术强度
				[3757] = 57690,	--	毛皮衬垫 - 耐力
				[3756] = 57683,	--	毛皮衬垫 - 攻击强度
				[3763] = 57701,	--	毛皮衬垫 - 奥数抗性
				[3762] = 57699,	--	毛皮衬垫 - 自然抗性
				[3761] = 57696,	--	毛皮衬垫 - 暗影抗性
				[3760] = 57694,	--	毛皮衬垫 - 冰霜抗性
				[3759] = 57692,	--	毛皮衬垫 - 火焰抗性
			},
			INVTYPE_HAND = {	--	gloves
				[2615] = 25074,
				[2617] = 25079,
				[865] = 13698,
				[91] = 13815,
				[93] = 20012,
				[883] = 25080,
				[930] = 13947,
				[2168] = 25078,
				[931] = 13948,
				[107] = 13887,
				[109] = 20013,
				[846] = 13620,
				[856] = 13887,
				[2244] = 25074,
				[2618] = 25080,
				[904] = 13815,
				[2616] = 25078,
				[927] = 20013,
				[2564] = 25080,
				[906] = 13841,
				[2320] = 25079,
				[845] = 13617,
				[1887] = 20012,
				[2543] = 13948,
				[2614] = 25073,
				[909] = 13868,
				[2130] = 25073,
				[2613] = 25072,
				[844] = 13612,
				[15] = 2831,
				[16] = 2832,
				[17] = 2833,
				[18] = 10344,
				[1843] = 19057,
				[2503] = 22725,
				-->
				[4740] = 13815,
				[4742] = 20013,
				[2603] = 13620,
				[4739] = 13887,
				[684] = 33995,
			-->		TradeSkill
				[3603] = 54998,	--	手部火箭发射器
				[3604] = 54999,	--	超级加速器
				[3860] = 63770,	--	装甲护网
			},
			INVTYPE_CLOAK = {	--	cloak
				[1888] = 20014,
				[1341] = 13657,
				[1349] = 25081,
				[2619] = 25081,
				[247] = 13419,
				[848] = 13635,
				[1436] = 13522,
				[1889] = 20015,
				[2620] = 25082,
				[2463] = 13657,
				[744] = 13421,
				[65] = 7454,
				[2621] = 25084,
				[2078] = 25086,
				[884] = 13746,
				[2488] = 20014,
				[2622] = 25086,
				[1339] = 7861,
				[910] = 25083,
				[849] = 13882,
				[855] = 7861,
				[2545] = 25086,
				[1395] = 25082,
				[804] = 13522,
				[903] = 13794,
				[2483] = 7861,
				[2683] = 13522,
				[256] = 7861,
				[257] = 7771,
				[121] = 13421,
				[74] = 13419,
				[76] = 13882,
				[783] = 7771,
				-->
				[4724] = 13419,
				[4734] = 13882,
				--
				[368] = 34004,
				[983] = 44589,
			-->		--	TradeSkill
				[3859] = 63765,	--	弹力蛛丝（法伤降落伞）
				[3605] = 55002,	--	高弹力衬垫（敏捷降落伞）
				[3730] = 55777,	--	剑刃刺绣（披风裁缝攻强）
				[3728] = 55769,	--	黑光刺绣（披风裁缝回蓝）
				[3722] = 55642,	--	亮纹刺绣（披风裁缝法强）
			},
			INVTYPE_WEAPON = {	--	weapon
				---->		1h		<----
				[883] = 23800,
				[2564] = 23800,
				[2618] = 23800,
				[684] = 23799,
				[2563] = 23799,
				[1900] = 20034,
				[78] = 13693,
				[1125] = 23804,
				[2568] = 23804,
				[67] = 7788,
				[250] = 7788,
				[188] = 7786,
				[864] = 13943,
				[117] = 13943,
				[805] = 13943,
				[1149] = 23803,
				[2567] = 23803,
				[190] = 13653,
				[231] = 21931,
				[2235] = 21931,
				[2443] = 21931,
				[1894] = 20029,
				[2331] = 22750,
				[2505] = 22750,
				[2332] = 22749,
				[2504] = 22749,
				[803] = 13898,
				[1898] = 20032,
				[854] = 13655,
				[912] = 13915,
				[1899] = 20033,
				--	conflicted with 2h
				[77] = 13503,
				[241] = 13503,
				[118] = 20031,
				[1897] = 20031,
				[943] = 13693,
				[34] = 7218,
				[36] = 6296,
				[37] = 7220,
				-->
				[853] = 13653,
				[4745] = 13693,
				[249] = 7786,
			-->		DK
				[3369] = 53341,	--	灰烬冰河
			},
			INVTYPE_2HWEAPON = {
				---->		2h		<----
				[2646] = 27837,
				[1102] = 27837,
				[120] = 13937,
				[963] = 13937,
				[1895] = 20030,
				[1896] = 20030,
				[354] = 20036,
				[1901] = 20036,
				[1904] = 20036,
				[81] = 7793,
				[723] = 7793,
				[78] = 13529,
				--	conflicted with 1h
				[77] = 7745,
				[241] = 7745,
				[118] = 13695,
				[1897] = 13695,
				[943] = 13529,
				--	confilicted with shield
				[64] = 13380,
				[84] = 13380,
				[255] = 13380,
				[355] = 20035,
				[1884] = 20035,
				[1903] = 20035,
				--	>>
				[4723] = 7745,
			},
			INVTYPE_SHIELD = {	--	oh	--	SHIELD
				[926] = 13933,
				[1296] = 13933,
				[99] = 13659,
				[851] = 13659,
				[66] = 13378,
				[71] = 13378,
				[101] = 13905,
				[907] = 13905,
				[103] = 13817,
				[852] = 13817,
				[105] = 20017,
				[929] = 20017,
				[848] = 13464,
				[73] = 13631,
				[724] = 13631,
				[863] = 13689,
				--	conflicted with weapon
				[64] = 13485,
				[84] = 13485,
				[255] = 13485,
				[355] = 20016,
				[1884] = 20016,
				[1903] = 20016,
				[43] = 7216,
				[463] = 9781,
				[1704] = 16623,
				-->
				[4741] = 13905,
				[4738] = 13817,
				[4744] = 20017,
				[1890] = 20016,
				[4733] = 13464,
				[4736] = 13659,
				[4731] = 13631,
				[4722] = 13378,
				[4728] = 13485,
			},
			INVTYPE_RANGED = {
				class = "HUNTER",
				[30] = 4405,	--	3974,	--	c3977i4405	粗制瞄准镜
				[32] = 4406,	--	3975,	--	c3978i4406	普通瞄准镜
				[33] = 4407,	--	3976,	--	c3979i4407	精确瞄准镜
				[663] = 10546,	--	12459,	--	c12597i10546	致命瞄准镜
				[664] = 10548,	--	12460,	--	c12620i10548	狙击瞄准镜
				[2523] = 18283,	--	22779,	--	c22793i18283	比兹尼克247x128精确瞄准镜
				[2722] = 23764,	--	30250,	--	c30332i23764,	--	精金瞄准镜
				[2723] = 23765,	--	30252,	--	c30332i23765,	--	氪金瞄准镜
				[2724] = 23766,	--	30260,	--	c30334i23766,	--	稳定恒金瞄准镜
				[3843] = 44739,	--	61468,	--	c61471i44739,	--	钻石折射瞄准镜
				[3607] = 41146,	--	55076,	--	c56470i41146,	--	太阳瞄准镜
				[3608] = 41167,	--	55135,	--	c56478i41167,	--	觅心瞄准镜
			},
		};
			for eid, sid in next, enchant_hash.INVTYPE_WEAPON do
				if enchant_hash.INVTYPE_2HWEAPON[eid] == nil then
					enchant_hash.INVTYPE_2HWEAPON[eid] = sid;
				end
			end
			enchant_hash.INVTYPE_ROBE = enchant_hash.INVTYPE_CHEST;
			enchant_hash.INVTYPE_WEAPONMAINHAND = enchant_hash.INVTYPE_WEAPON;
			enchant_hash.INVTYPE_WEAPONOFFHAND = enchant_hash.INVTYPE_WEAPON;
			enchant_hash.INVTYPE_RANGEDRIGHT = enchant_hash.INVTYPE_RANGED;
		function MT._GetEnchantInfo(class, slot, item)
			local _, link, _, level, _, _, _, _, loc = GetItemInfo(item);
			local hash = enchant_hash[loc];
			if hash and (hash.class == class or hash.class == nil) then
				local id, enchantId = strmatch(item, "item:(%d+):(%d+):")
				enchantId = tonumber(enchantId);
				if enchantId then
					local enchant = hash[enchantId];
					if enchant then
						return true, true, link or ("item:" .. id), level, loc, GetSpellInfo(enchant) or ("spell: " .. enchant);
					else
						return true, true, link or ("item:" .. id), level, loc, "enchant: " .. enchantId;
					end
				else
					return true, false, link or item, level, loc;
				end
			else
				return false, false, link or item, level, loc;
			end
		end
		--	new
		local EnchantItemDB = {
			[5423] = 128537,
			[5424] = 128538,
			[5425] = 128539,
			[5426] = 128540,
			[5427] = 128541,
			[5428] = 128542,
			[5429] = 128543,
			[5430] = 128544,
			[5431] = 128545,
			[5432] = 128546,
			[5433] = 128547,
			[5434] = 128548,
			[5435] = 128549,
			[5436] = 128550,
			[5437] = 128551,
			[5438] = 128552,
			[5439] = 128553,
			[5444] = 128558,
			[5445] = 128559,
			[5446] = 128560,
			[5447] = 128561,
			[5440] = 128554,
			[5441] = 140213,
			[5442] = 140214,
			[5443] = 140215,
			[5881] = 140217,
			[5882] = 140218,
			[5883] = 140219,
			[5888] = 141861,
			[5889] = 141908,
			[5890] = 141909,
			[5891] = 141910,
			[5896] = 144305,
			[5899] = 144328,
			[5900] = 144346,
			[5931] = 153247,
			[5929] = 153197,
			[5939] = 153439,
			[5943] = 153443,
			[5955] = 158212,
			--那萊矯捷瞄準鏡 158327
			--5957 炙燃火藥
			--6087 韧性法术丝线
			--6088 谨慎法术丝线
			--6089 轻羽法术丝线

			[6108] = 168446,
			[6109] = 168447,
			[6110] = 168448,
			[6111] = 168449,
			[6112] = 168593,
			[6148] = 168596,
			[6149] = 168592,
			[6150] = 168598,
			--戒指 致命 153442
			--戒指 应变 153445
		--
			--
			[30] = 4405,	--	3974,	--	c3977i4405	粗制瞄准镜
			[32] = 4406,	--	3975,	--	c3978i4406	普通瞄准镜
			[33] = 4407,	--	3976,	--	c3979i4407	精确瞄准镜
			[663] = 10546,	--	12459,	--	c12597i10546	致命瞄准镜
			[664] = 10548,	--	12460,	--	c12620i10548	狙击瞄准镜
			[2523] = 18283,	--	22779,	--	c22793i18283	比兹尼克247x128精确瞄准镜
			[2722] = 23764,	--	30250,	--	c30332i23764,	--	精金瞄准镜
			[2723] = 23765,	--	30252,	--	c30332i23765,	--	氪金瞄准镜
			[2724] = 23766,	--	30260,	--	c30334i23766,	--	稳定恒金瞄准镜
			[3843] = 44739,	--	61468,	--	c61471i44739,	--	钻石折射瞄准镜
			[3607] = 41146,	--	55076,	--	c56470i41146,	--	太阳瞄准镜
			[3608] = 41167,	--	55135,	--	c56478i41167,	--	觅心瞄准镜
		};
		local EnchantSpellDB = {
			[15] = 2831,
			[16] = 2832,
			[17] = 2833,
			[18] = 10344,
			[24] = 7443,
			[30] = 3974,
			[32] = 3975,
			[33] = 3976,
			[34] = 7218,
			[36] = 6296,
			[37] = 7220,
			[41] = 7420,
			[43] = 7216,
			[44] = 7426,
			[63] = 13538,
			[66] = 7863,
			[241] = 13503,
			[242] = 7748,
			[243] = 7766,
			[246] = 7776,
			[247] = 7867,
			[248] = 7782,
			[249] = 7786,
			[250] = 7788,
			[254] = 7857,
			[255] = 13380,
			[369] = 34001,
			[463] = 9781,
			[464] = 9783,
			[663] = 12459,
			[664] = 12460,
			[723] = 7793,
			[724] = 13644,
			[744] = 13421,
			[783] = 7771,
			[803] = 13898,
			[805] = 13943,
			[823] = 13536,
			[843] = 13607,
			[844] = 13612,
			[845] = 13617,
			[846] = 24302,
			[847] = 13626,
			[848] = 13635,
			[849] = 13637,
			[850] = 13640,
			[851] = 20024,
			[852] = 13836,
			[853] = 13653,
			[854] = 13655,
			[856] = 13661,
			[857] = 13663,
			[863] = 13689,
			[865] = 13698,
			[866] = 13700,
			[884] = 13746,
			[904] = 13935,
			[905] = 13822,
			[906] = 13841,
			[907] = 13846,
			[908] = 13858,
			[909] = 13868,
			[910] = 25083,
			[911] = 13890,
			[912] = 13915,
			[913] = 13917,
			[923] = 13931,
			[924] = 7428,
			[925] = 13646,
			[927] = 13939,
			[928] = 13941,
			[929] = 20020,
			[930] = 13947,
			[931] = 13948,
			[943] = 13529,
			[963] = 13937,
			[1071] = 34009,
			[1075] = 44528,
			[1099] = 60663,
			[1103] = 44633,
			[1119] = 44555,
			[1128] = 60653,
			[1147] = 44508,
			[1483] = 15340,
			[1503] = 15389,
			[1504] = 15391,
			[1505] = 15394,
			[1506] = 15397,
			[1507] = 15400,
			[1508] = 15402,
			[1509] = 15404,
			[1510] = 15406,
			[1523] = 15427,
			[1524] = 15429,
			[1525] = 15439,
			[1526] = 15441,
			[1527] = 15444,
			[1528] = 15446,
			[1529] = 15449,
			[1530] = 15458,
			[1532] = 15463,
			[1543] = 15490,
			[1597] = 60763,
			[1600] = 60616,
			[1603] = 60668,
			[1606] = 60621,
			[1704] = 16623,
			[1843] = 19057,
			[1883] = 20008,
			[1884] = 20009,
			[1885] = 20010,
			[1886] = 20011,
			[1887] = 20012,
			[1889] = 20015,
			[1890] = 20016,
			[1891] = 20025,
			[1892] = 20026,
			[1893] = 20028,
			[1894] = 20029,
			[1896] = 20030,
			[1897] = 13695,
			[1898] = 20032,
			[1899] = 20033,
			[1900] = 20034,
			[1903] = 20035,
			[1904] = 20036,
			[1951] = 44591,
			[1952] = 44489,
			[1953] = 47766,
			[2322] = 33999,
			[2326] = 44635,
			[2332] = 60767,
			[2343] = 34010,
			[2381] = 44509,
			[2443] = 21931,
			[2483] = 22593,
			[2484] = 22594,
			[2485] = 22598,
			[2486] = 22597,
			[2487] = 22596,
			[2488] = 22599,
			[2503] = 22725,
			[2504] = 22749,
			[2505] = 22750,
			[2523] = 22779,
			[2543] = 22840,
			[2544] = 22844,
			[2545] = 22846,
			[2563] = 23799,
			[2564] = 23800,
			[2565] = 23801,
			[2567] = 23803,
			[2568] = 23804,
			[2583] = 24149,
			[2584] = 24160,
			[2587] = 24163,
			[2588] = 24164,
			[2589] = 24165,
			[2590] = 24167,
			[2591] = 24168,
			[2603] = 13620,
			[2604] = 24420,
			[2605] = 24421,
			[2606] = 24422,
			[2613] = 25072,
			[2614] = 25073,
			[2615] = 25074,
			[2616] = 25078,
			[2617] = 25079,
			[2621] = 25084,
			[2622] = 25086,
			[2646] = 27837,
			[2647] = 27899,
			[2648] = 27906,
			[2649] = 27914,
			[2650] = 23802,
			[2653] = 27944,
			[2654] = 27945,
			[2655] = 27946,
			[2656] = 27948,
			[2657] = 27951,
			[2658] = 27954,
			[2659] = 27957,
			[2661] = 27960,
			[2662] = 27961,
			[2666] = 27968,
			[2667] = 27971,
			[2668] = 27972,
			[2669] = 27975,
			[2670] = 27977,
			[2671] = 27981,
			[2672] = 27982,
			[2673] = 27984,
			[2674] = 28003,
			[2675] = 28004,
			[2679] = 27913,
			[2681] = 28161,
			[2682] = 28163,
			[2683] = 28165,
			[2714] = 29454,
			[2715] = 29475,
			[2716] = 29480,
			[2717] = 29483,
			[2721] = 29467,
			[2722] = 30250,
			[2723] = 30252,
			[2724] = 30260,
			[2745] = 31369,
			[2746] = 31370,
			[2747] = 31371,
			[2748] = 31372,
			[2792] = 32397,
			[2793] = 32398,
			[2794] = 32399,
			[2841] = 44968,
			[2933] = 33992,
			[2934] = 33993,
			[2935] = 33994,
			[2937] = 33997,
			[2938] = 34003,
			[2939] = 34007,
			[2940] = 34008,
			[2977] = 35355,
			[2978] = 35402,
			[2979] = 35403,
			[2980] = 35404,
			[2981] = 35405,
			[2982] = 35406,
			[2983] = 35407,
			[2984] = 35415,
			[2985] = 35416,
			[2986] = 35417,
			[2987] = 35418,
			[2988] = 35419,
			[2989] = 35420,
			[2990] = 35432,
			[2991] = 35433,
			[2992] = 35434,
			[2993] = 35435,
			[2994] = 35436,
			[2995] = 35437,
			[2996] = 35438,
			[2997] = 35439,
			[2998] = 35441,
			[2999] = 35443,
			[3001] = 35445,
			[3002] = 35447,
			[3003] = 35452,
			[3004] = 35453,
			[3005] = 35454,
			[3006] = 35455,
			[3007] = 35456,
			[3008] = 35457,
			[3009] = 35458,
			[3010] = 35488,
			[3011] = 35489,
			[3012] = 35490,
			[3013] = 35495,
			[3095] = 37889,
			[3096] = 37891,
			[3150] = 33991,
			[3222] = 42620,
			[3223] = 42687,
			[3225] = 42974,
			[3228] = 44119,
			[3229] = 44383,
			[3231] = 44484,
			[3232] = 47901,
			[3233] = 27958,
			[3234] = 44488,
			[3236] = 44492,
			[3238] = 44506,
			[3239] = 44524,
			[3241] = 44576,
			[3243] = 44582,
			[3244] = 44584,
			[3245] = 44588,
			[3246] = 44592,
			[3247] = 44595,
			[3249] = 44612,
			[3251] = 44621,
			[3252] = 44623,
			[3253] = 44625,
			[3256] = 44631,
			[3260] = 44769,
			[3269] = 45697,
			[3273] = 46578,
			[3289] = 47103,
			[3294] = 47672,
			[3296] = 47899,
			[3297] = 47900,
			[3315] = 48401,
			[3325] = 50901,
			[3326] = 50902,
			[3329] = 50906,
			[3330] = 50909,
			[3332] = 50913,
			[3366] = 53331,
			[3367] = 53342,
			[3368] = 53344,
			[3370] = 53343,
			[3595] = 54447,
			[3599] = 54736,
			[3601] = 54793,
			[3605] = 55002,
			[3607] = 55076,
			[3608] = 55135,
			[3718] = 55630,
			[3719] = 55631,
			[3720] = 55632,
			[3721] = 55634,
			[3731] = 55836,
			[3748] = 56353,
			[3754] = 24162,
			[3755] = 24161,
			[3775] = 58126,
			[3776] = 58128,
			[3777] = 58129,
			[3788] = 59619,
			[3789] = 59621,
			[3790] = 59625,
			[3793] = 59771,
			[3794] = 59773,
			[3795] = 59777,
			[3796] = 59778,
			[3797] = 59784,
			[3806] = 59927,
			[3807] = 59928,
			[3808] = 59934,
			[3809] = 59936,
			[3810] = 59937,
			[3811] = 59941,
			[3812] = 59944,
			[3813] = 59945,
			[3814] = 59946,
			[3815] = 59947,
			[3816] = 59948,
			[3817] = 59954,
			[3818] = 59955,
			[3819] = 59960,
			[3820] = 59970,
			[3822] = 60581,
			[3823] = 60582,
			[3824] = 60606,
			[3825] = 60609,
			[3826] = 60623,
			[3827] = 60691,
			[3828] = 44630,
			[3829] = 44513,
			[3830] = 44629,
			[3831] = 47898,
			[3832] = 60692,
			[3833] = 60707,
			[3834] = 60714,
			[3835] = 61117,
			[3836] = 61118,
			[3837] = 61119,
			[3838] = 61120,
			[3842] = 61271,
			[3843] = 61468,
			[3844] = 44510,
			[3845] = 44575,
			[3846] = 34010,
			[3847] = 62158,
			[3849] = 62201,
			[3850] = 62256,
			[3851] = 62257,
			[3852] = 62384,
			[3853] = 62447,
			[3854] = 62948,
			[3855] = 62959,
			[3858] = 63746,
			[3869] = 64441,
			[3870] = 64579,
			[3872] = 56039,
			[3873] = 56034,
			[3875] = 59929,
			[3876] = 59932,
			[4061] = 74132,
			[4062] = 74189,
			[4063] = 74191,
			[4064] = 74192,
			[4065] = 74193,
			[4066] = 74195,
			[4067] = 74197,
			[4068] = 74198,
			[4069] = 74199,
			[4070] = 74200,
			[4071] = 74201,
			[4072] = 74202,
			[4073] = 74207,
			[4074] = 74211,
			[4075] = 74212,
			[4076] = 74213,
			[4077] = 74214,
			[4082] = 74220,
			[4083] = 74223,
			[4084] = 74225,
			[4085] = 74226,
			[4086] = 74229,
			[4087] = 74230,
			[4088] = 74231,
			[4089] = 74232,
			[4090] = 74234,
			[4091] = 74235,
			[4092] = 74236,
			[4093] = 74237,
			[4094] = 74238,
			[4095] = 74239,
			[4096] = 74240,
			[4097] = 74242,
			[4098] = 74244,
			[4099] = 74246,
			[4100] = 74247,
			[4101] = 74248,
			[4102] = 74250,
			[4103] = 74251,
			[4104] = 74253,
			[4105] = 74252,
			[4106] = 74254,
			[4107] = 74255,
			[4108] = 74256,
			[4109] = 75149,
			[4110] = 75150,
			[4111] = 75151,
			[4112] = 75152,
			[4113] = 75154,
			[4114] = 75155,
			[4120] = 78165,
			[4121] = 78166,
			[4122] = 78169,
			[4124] = 78170,
			[4126] = 78171,
			[4127] = 78172,
			[4175] = 81932,
			[4176] = 81933,
			[4177] = 81934,
			[4187] = 84424,
			[4188] = 84427,
			[4193] = 86375,
			[4194] = 86401,
			[4195] = 86402,
			[4196] = 86403,
			[4197] = 86847,
			[4198] = 86854,
			[4199] = 86898,
			[4200] = 86899,
			[4201] = 86900,
			[4202] = 86901,
			[4203] = 86906,
			[4204] = 86907,
			[4205] = 86909,
			[4206] = 86931,
			[4207] = 86932,
			[4208] = 86933,
			[4209] = 86934,
			[4214] = 84425,
			[4215] = 92433,
			[4216] = 92437,
			[4217] = 93448,
			[4222] = 67839,
			[4227] = 95471,
			[4245] = 96245,
			[4246] = 96246,
			[4247] = 96247,
			[4248] = 96249,
			[4249] = 96250,
			[4250] = 96251,
			[4256] = 96261,
			[4257] = 96262,
			[4258] = 96264,
			[4259] = 96286,
			[4267] = 99623,
			[4270] = 101598,
			[4411] = 104338,
			[4412] = 104385,
			[4414] = 104389,
			[4415] = 104390,
			[4416] = 104391,
			[4417] = 104392,
			[4418] = 104393,
			[4419] = 104395,
			[4420] = 104397,
			[4421] = 104398,
			[4422] = 104401,
			[4423] = 104403,
			[4424] = 104404,
			[4426] = 104407,
			[4427] = 104408,
			[4428] = 104409,
			[4429] = 104414,
			[4430] = 104416,
			[4431] = 104417,
			[4432] = 104419,
			[4433] = 104420,
			[4434] = 104445,
			[4441] = 104425,
			[4442] = 104427,
			[4443] = 104430,
			[4444] = 104434,
			[4445] = 104440,
			[4446] = 104442,
			[4687] = 108115,
			[4699] = 109086,
			[4700] = 109093,
			[4717] = 110764,
			[4719] = 113011,
			[4720] = 7418,
			[4721] = 7457,
			[4722] = 13378,
			[4723] = 7745,
			[4724] = 13419,
			[4725] = 7779,
			[4726] = 13687,
			[4727] = 7859,
			[4728] = 13485,
			[4729] = 13622,
			[4730] = 13501,
			[4731] = 13631,
			[4732] = 71692,
			[4733] = 13464,
			[4734] = 13882,
			[4735] = 13642,
			[4736] = 13659,
			[4737] = 13648,
			[4738] = 13817,
			[4739] = 13887,
			[4740] = 13815,
			[4741] = 13905,
			[4742] = 20013,
			[4743] = 13945,
			[4744] = 20017,
			[4745] = 13693,
			[4746] = 27967,
			[4747] = 44500,
			[4748] = 44589,
			[4750] = 82200,
			[4803] = 121192,
			[4804] = 121193,
			[4805] = 121194,
			[4806] = 121195,
			[4808] = 121988,
			[4822] = 122387,
			[4823] = 122388,
			[4824] = 122386,
			[4825] = 122392,
			[4826] = 122393,
			[4869] = 124091,
			[4870] = 124116,
			[4871] = 124118,
			[4872] = 124119,
			[4880] = 124559,
			[4881] = 124561,
			[4882] = 124563,
			[4883] = 124564,
			[4884] = 124565,
			[4885] = 124566,
			[4886] = 124567,
			[4887] = 124568,
			[4888] = 124569,
			[4895] = 125496,
			[4896] = 125497,
			[4897] = 126392,
			[4907] = 127015,
			[4908] = 127014,
			[4909] = 127013,
			[4910] = 127012,
			[4912] = 113048,
			[4913] = 113047,
			[4914] = 113046,
			[4915] = 113045,
			[4916] = 113044,
			[4918] = 128286,
			[4992] = 130749,
			[4993] = 130758,
			[5000] = 109099,
			[5001] = 131464,
			[5003] = 131862,
			[5004] = 131863,
			[5035] = 139631,
			[5055] = 141167,
			[5056] = 141168,
			[5057] = 141170,
			[5058] = 141173,
			[5059] = 141174,
			[5060] = 141175,
			[5061] = 141176,
			[5062] = 141177,
			[5063] = 141330,
			[5076] = 141445,
			[5080] = 141862,
			[5081] = 141868,
			[5091] = 141971,
			[5092] = 141973,
			[5093] = 141974,
			[5094] = 141975,
			[5095] = 141976,
			[5096] = 141977,
			[5097] = 141978,
			[5098] = 141981,
			[5099] = 141982,
			[5100] = 141983,
			[5101] = 141984,
			[5110] = 142173,
			[5111] = 142175,
			[5112] = 142177,
			[5113] = 142178,
			[5124] = 142469,
			[5125] = 142468,
			[5183] = 27911,
			[5184] = 27917,
			[5237] = 33990,
			[5250] = 33995,
			[5255] = 33996,
			[5257] = 34002,
			[5258] = 34004,
			[5259] = 44529,
			[5260] = 46594,
			[5274] = 155692,
			[5275] = 156050,
			[5276] = 156061,
			[5281] = 158877,
			[5284] = 158907,
			[5285] = 158892,
			[5292] = 158893,
			[5293] = 158894,
			[5294] = 158895,
			[5295] = 158896,
			[5297] = 158908,
			[5298] = 158878,
			[5299] = 158909,
			[5300] = 158879,
			[5301] = 158910,
			[5302] = 158880,
			[5303] = 158911,
			[5304] = 158881,
			[5310] = 158884,
			[5311] = 158885,
			[5312] = 158886,
			[5313] = 158887,
			[5314] = 158889,
			[5317] = 158899,
			[5318] = 158900,
			[5319] = 158901,
			[5320] = 158902,
			[5321] = 158903,
			[5324] = 158914,
			[5325] = 158915,
			[5326] = 158916,
			[5327] = 158917,
			[5328] = 158918,
			[5330] = 159235,
			[5331] = 159236,
			[5334] = 159672,
			[5335] = 159673,
			[5336] = 159674,
			[5337] = 159671,
			[5352] = 170627,
			[5353] = 170628,
			[5354] = 170629,
			[5355] = 170630,
			[5356] = 170631,
			[5357] = 170886,
			[5383] = 173287,
			[5384] = 173323,
			[5423] = 190866,
			[5424] = 190867,
			[5425] = 190868,
			[5426] = 190869,
			[5427] = 190870,
			[5428] = 190871,
			[5429] = 190872,
			[5430] = 190873,
			[5431] = 190874,
			[5432] = 190875,
			[5433] = 190876,
			[5434] = 190877,
			[5435] = 190878,
			[5436] = 190879,
			[5437] = 190892,
			[5438] = 190893,
			[5439] = 190894,
			[5889] = 228402,
			[5890] = 228405,
			[5891] = 228408,
			[5444] = 190988,
			[5445] = 190989,
			[5446] = 190990,
			[5447] = 190991,
			[5440] = 190954,
			[5441] = 190955,
			[5442] = 190956,
			[5443] = 190957,
			[5881] = 222851,
			[5882] = 222852,
			[5883] = 222853,
			[5888] = 228139,
			--[5898] = , +9致命
			[5899] = 235731,
			[5900] = 235795,
			[5932] = 255035,
			[5933] = 255040,
			[5934] = 255065,
			[5935] = 255066,
			[5936] = 255068,
			[5937] = 255070,
			[5938] = 255071,
			[5939] = 255072,
			[5940] = 255073,
			[5941] = 255074,
			[5942] = 255086,
			[5943] = 255087,
			[5944] = 255088,
			[5945] = 255089,
			[5946] = 255103,
			[5948] = 255110,
			[5949] = 255129,
			[5950] = 255141,
			[5962] = 268852,
			[5963] = 268894,
			[5964] = 268901,
			[5965] = 268907,
			[5966] = 268913,
			[5970] = 271366,
			[5971] = 271433,
		-->	
			[983] = 44589,	--	44500
			[1593] = 34002,
			[684] = 33995,	--	35819
			[368] = 34004,
			[1594] = 33996,
		-->		TradeSkill
			[3327] = 60583,	--	冰虫腿甲强化片
			[3328] = 60584,	--	蛛魔腿甲强化片
			[3606] = 55016,	--	硝化甘油推进器
			[3758] = 57691,	--	毛皮衬垫 - 法术强度
			[3757] = 57690,	--	毛皮衬垫 - 耐力
			[3756] = 57683,	--	毛皮衬垫 - 攻击强度
			[3763] = 57701,	--	毛皮衬垫 - 奥数抗性
			[3762] = 57699,	--	毛皮衬垫 - 自然抗性
			[3761] = 57696,	--	毛皮衬垫 - 暗影抗性
			[3760] = 57694,	--	毛皮衬垫 - 冰霜抗性
			[3759] = 57692,	--	毛皮衬垫 - 火焰抗性
			[3603] = 54998,	--	手部火箭发射器
			[3604] = 54999,	--	超级加速器
			[3860] = 63770,	--	装甲护网
			[3859] = 63765,	--	弹力蛛丝（法伤降落伞）
			[3605] = 55002,	--	高弹力衬垫（敏捷降落伞）
			[3730] = 55777,	--	剑刃刺绣（披风裁缝攻强）
			[3728] = 55769,	--	黑光刺绣（披风裁缝回蓝）
			[3722] = 55642,	--	亮纹刺绣（披风裁缝法强）
		-->		DK
			[3369] = 53341,	--	灰烬冰河
		};
		function MT.GetEnchantInfo(class, slot, item)
			local _, link, _, level, _, _, _, _, loc = GetItemInfo(item);
			local hash = enchant_hash[loc];
			if hash and (hash.class == class or hash.class == nil) then
				local id, enchantId = strmatch(item, "item:(%d+):(%d+):");
				enchantId = tonumber(enchantId);
				if enchantId then
					local enchant = EnchantSpellDB[enchantId];
					if enchant then
						local eitem = EnchantItemDB[enchant];
						if eitem then
							return true, true, link or ("item:" .. id), level, loc, GetItemInfo(eitem) or GetSpellInfo(enchant) or ("item: " .. eitem);
						else
							return true, true, link or ("item:" .. id), level, loc, GetSpellInfo(enchant) or ("spell: " .. enchant);
						end
					else
						return true, true, link or ("item:" .. id), level, loc, "enchant: " .. enchantId;
					end
				else
					return true, false, link or item, level, loc;
				end
			else
				return false, false, link or item, level, loc;
			end
		end
	-->		Gem
	if VT.__support_gem then
		--
		local Enum = _G.Enum;
		local CLASSID_GEM = Enum.ItemClass.Gem;
		local ItemGemSubclass = Enum.ItemGemSubclass;
		--[[
			Red = 0,
			Blue = 1,
			Yellow = 2,
			Purple = 3,
			Green = 4,
			Orange = 5,
			Meta = 6,
			Simple = 7,
			Prismatic = 8,
		--]]
		--
		local ScanTipName = "Emu_ScanTip" .. (MT.GetUnifiedTime() + 1) .. random(1000000, 10000000);
		local ScanTip = CreateFrame('GAMETOOLTIP', ScanTipName, UIParent, "GameTooltipTemplate");
		local ScanTipTextures = {  };
		local ScanTipTexturePrefix = ScanTipName .. "Texture";
		for index = 1, 10 do
			ScanTipTextures[index] = _G[ScanTipTexturePrefix .. index];
		end
		local _GemInfoCache = {  };
		function MT.ScanGemInfo(item, returnStr)
			local v = _GemInfoCache[item];
			if v ~= nil and (v[7] ~= nil or not returnStr) then
				return v[1], v[2], v[3], v[4], v[5], v[6], v[7];
			end
			ScanTip:SetOwner(UIParent, "ANCHOR_RIGHT");
			ScanTip:SetHyperlink(item);
			ScanTip:Show();
			local A = 0;
			local T, M, R, Y, B = 0, 0, 0, 0, 0;
			local S = { strmatch(item, "item:%d+:?[-%d]*:?(%d*):?(%d*):?(%d*):?(%d*)") };
			if returnStr then
				returnStr = "";
			end
			for index = 1, 4 do
				local v = S[index];
				v = v ~= "" and tonumber(v) or nil;
				if v ~= 0 and v ~= nil then
					local id, class, subClass, _, icon, classID, subClassID = GetItemInfoInstant(v);
					if classID == CLASSID_GEM then
						if subClassID == ItemGemSubclass.Red then
							S[index] = l10n.Gem.Red;
						elseif subClassID == ItemGemSubclass.Orange then
							S[index] = l10n.Gem.Orange;
						elseif subClassID == ItemGemSubclass.Yellow then
							S[index] = l10n.Gem.Yellow;
						elseif subClassID == ItemGemSubclass.Green then
							S[index] = l10n.Gem.Green;
						elseif subClassID == ItemGemSubclass.Blue then
							S[index] = l10n.Gem.Blue;
						elseif subClassID == ItemGemSubclass.Purple then
							S[index] = l10n.Gem.Purple;
						elseif subClassID == ItemGemSubclass.Prismatic then
							S[index] = l10n.Gem.Prismatic;
						elseif subClassID == ItemGemSubclass.Meta then
							S[index] = l10n.Gem.Meta;
						else
						end
					else
						S[index] = nil;
					end
				else
					S[index] = nil;
				end
			end
			for index = 1, 10 do
				local Texture = ScanTipTextures[index] or _G[ScanTipTexturePrefix .. index];
				ScanTipTextures[index] = Texture;
				if Texture == nil or not Texture:IsShown() then
					break;
				end
				if S[index] ~= nil then
					A = A + 1;
					if returnStr then
						returnStr = returnStr .. S[index];
					end
				else
					local v = Texture:GetTexture();
					if v == 136256 then			--	B	136256	Inerface\ItemSocketingFrame\UI-EmptySocket-Meta.blp
						T = T + 1;
						B = B + 1;
						if returnStr then
							returnStr = returnStr .. l10n.MissGem.Blue;
						end
					elseif v == 136257 then		--	M	136257	Inerface\ItemSocketingFrame\UI-EmptySocket-Blue.blp
						T = T + 1;
						M = M + 1;
						if returnStr then
							returnStr = returnStr .. l10n.MissGem.Meta;
						end
					elseif v == 136258 then		--	R	136258	Inerface\ItemSocketingFrame\UI-EmptySocket-Red.blp
						T = T + 1;
						R = R + 1;
						if returnStr then
							returnStr = returnStr .. l10n.MissGem.Red;
						end
					elseif v == 136259 then		--	Y	136259	Inerface\ItemSocketingFrame\UI-EmptySocket-Yellow.blp
						T = T + 1;
						Y = Y + 1;
						if returnStr then
							returnStr = returnStr .. l10n.MissGem.Yellow;
						end
					else
						if returnStr then
							returnStr = returnStr .. l10n.MissGem["?"];
						end
					end
				end
			end
			ScanTip:Hide();
			if v ~= nil then
				v[1] = A;
				v[2] = T;
				v[3] = M;
				v[4] = R;
				v[5] = Y;
				v[6] = B;
				v[7] = returnStr or v[7];
			else
				_GemInfoCache[item] = { A, T, M, R, Y, B, returnStr, };
			end
			return A, T, M, R, Y, B, returnStr;
		end
	else
		function MT.ScanGemInfo()
			return 0, 0, 0, 0, 0, 0, "";
		end
	end
	-->

	function MT.GeneralOnEnter(self, motion)
		if self.information then
			GameTooltip:SetOwner(self, "ANCHOR_LEFT");
			GameTooltip:SetText(self.information, 1.0, 1.0, 1.0);
		end
	end
	function MT.GeneralOnLeave(self, motion)
		if GameTooltip:IsOwned(self) then
			GameTooltip:Hide();
		end
	end
	function MT.GetPointsReqLevel(numPoints)
		return max(10, 9 + numPoints);
	end
	function MT.GetLevelAvailablePoints(level)
		return max(0, level - 9);
	end
	function MT.CountTreePoints(data, class)
		local ClassTDB = DT.TalentDB[class];
		local SpecList = DT.ClassSpec[class];
		local pos = 1;
		local len = #data;
		local stats = { 0, 0, 0, };
		for TreeIndex = 1, 3 do
			local total = 0;
			for j = 1, #ClassTDB[SpecList[TreeIndex]] do
				if pos > len then
					break;
				end
				local val = strsub(data, pos, pos);
				total = total + tonumber(val);
				pos = pos + 1;
			end
			stats[TreeIndex] = total;
		end
		return stats;
	end
	function MT.GenerateTitle(class, stats, uncolored)
		local SpecList = DT.ClassSpec[class];
		if uncolored then
			local title = l10n.DATA[class];
			for TreeIndex = 1, 3 do
				title = title .. " " .. l10n.DATA[SpecList[TreeIndex]] .. format("%2d", stats[TreeIndex]);
			end
			return title;
		else
			local title = "|c" .. RAID_CLASS_COLORS[class].colorStr .. l10n.DATA[class] .. "|r-";
			local temp = max(stats[1], stats[2], stats[3]);
			if temp == stats[1] and temp == stats[2] and temp == stats[3] then
				temp = temp + 1023;
			end
			for TreeIndex = 1, 3 do
				if temp == stats[TreeIndex] then
					title = title .. " |cff7fbfff" .. l10n.DATA[SpecList[TreeIndex]] .. format("%2d|r", stats[TreeIndex]);
				else
					title = title .. " " .. l10n.DATA[SpecList[TreeIndex]] .. format("%2d", stats[TreeIndex]);
				end
			end
			return title;
		end
	end
	function MT.GenerateTitleFromRawData(data, class, uncolored)
		local Type = type(data);
		if Type == 'table' then
			local TreeFrames = data.TreeFrames;
			return MT.GenerateTitle(data.class, { TreeFrames[1].TalentSet.Total, TreeFrames[2].TalentSet.Total, TreeFrames[3].TalentSet.Total, }, uncolored);
		elseif Type == 'string' and type(class) == 'string' and DT.TalentDB[class] ~= nil then
			return MT.GenerateTitle(class, MT.CountTreePoints(data, class), uncolored);
		end
	end
	function MT.GenerateLink(title, class, code)
		return "|Hemu:" .. code .. "|h|c" .. RAID_CLASS_COLORS[class].colorStr .. "[" .. title .. "]|r|h";
	end
	function MT.GetTreeNodeIndex(TalentDef)
		return TalentDef[1] * DT.MAX_NUM_COL + TalentDef[2] + 1;
	end

	function MT.TalentConversion(class, level, numGroup, activeGroup, data1, data2)
		if CT.BUILD ~= "WRATH" then
			return class, level, numGroup, activeGroup, data1, data2;
		end
		local ClassTDB = DT.TalentDB[class];
		local SpecList = DT.ClassSpec[class];
		local Map = VT.__emulib.GetTalentMap(class) or VT.MAP[class] or (DT.TalentMap ~= nil and DT.TalentMap[class]) or nil;
		if Map == nil then
			local ofs = 0;
			for SpecIndex = 1, 3 do
				local TreeTDB = ClassTDB[SpecList[SpecIndex]];
				local num = #TreeTDB;
				for TalentSeq = 1, num do
					local val = tonumber(strsub(data1, ofs + TalentSeq, ofs + TalentSeq)) or 0;
					if val > TreeTDB[TalentSeq][4] then
						return nil;
					end
				end
				ofs = ofs + num;
			end
			return class, level, 1, 1, data1;
		end
		local conv = {  };
		local pos = 0;
		local VMap = Map.VMap;
		local ofs = 0;
		local len = #data1;
		for SpecIndex = 1, 3 do
			local TreeTDB = ClassTDB[SpecList[SpecIndex]];
			local VM = VMap[SpecIndex];
			local num = #VM;
			for TalentSeq = 1, num do
				local TalentIndex = VM[TalentSeq];
				local val = tonumber(strsub(data1, ofs + TalentIndex, ofs + TalentIndex)) or 0;
				if val > TreeTDB[TalentSeq][4] then
					return class, level, 1, 1, data1;
				end
				pos = pos + 1;
				conv[pos] = val;
			end
			ofs = ofs + num;
		end
		return class, level, 1, 1, concat(conv);
	end
	--	arg			code, useCodeLevel
	--	return		class, level, data
	function MT.DecodeTalent(code)
		local version, class, level, numGroup, activeGroup, data1, data2 = VT.__emulib.DecodeTalentData(code);
		if version == "V1" and CT.BUILD == "WRATH" and class ~= nil then
			return MT.TalentConversion(class, level, numGroup, activeGroup, data1, data2);
		else
			return class, level, numGroup, activeGroup, data1, data2;
		end
	end
	--	arg			[Frame] or [class, level, data]
	--	return		code
	function MT.EncodeTalent(class, level, data)
		local TypeClass = type(class);
		if TypeClass == 'table' then
			local Frame = class;
			local TreeFrames = Frame.TreeFrames;
			if type(TreeFrames) == 'table' and
						type(TreeFrames[1]) == 'table' and type(TreeFrames[1].TalentSet) == 'table' and
						type(TreeFrames[2]) == 'table' and type(TreeFrames[2].TalentSet) == 'table' and
						type(TreeFrames[3]) == 'table' and type(TreeFrames[3].TalentSet) == 'table'
				then
				--
				local activeGroup = Frame.activeGroup;
				local TalData = Frame.TalData;
				if activeGroup ~= nil and TalData ~= nil and TalData.num ~= nil then
					if TalData.num == 2 then
						local T2 = activeGroup == 1 and TalData[2] or TalData[1];
						if T2 ~= nil then
							local D1, D2, D3, N1, N2, N3 = TreeFrames[1].TalentSet, TreeFrames[2].TalentSet, TreeFrames[3].TalentSet,
										#TreeFrames[1].TreeTDB, #TreeFrames[2].TreeTDB, #TreeFrames[3].TreeTDB
							local T1 = {  };
							local len = 0;
							for index = 1, N1 do len = len + 1; T1[len] = D1[index] or 0; end
							for index = 1, N2 do len = len + 1; T1[len] = D2[index] or 0; end
							for index = 1, N3 do len = len + 1; T1[len] = D3[index] or 0; end
							local code1, data1, lenc1, lend1 = VT.__emulib.EncodeTalentBlock(T1, len);
							local code2, data2, lenc2, lend2 = VT.__emulib.EncodeTalentBlock(T2, #T2);
							if activeGroup == 1 then
							return VT.__emulib.MergeTalentCodeV2(DT.ClassToIndex[Frame.class], Frame.level, activeGroup, 2, T1, len, T2, #T2);
							else
							return VT.__emulib.MergeTalentCodeV2(DT.ClassToIndex[Frame.class], Frame.level, activeGroup, 2, T2, #T2, T1, len);
							end
						else
							return VT.__emulib.EncodeFrameTalentDataV2(DT.ClassToIndex[Frame.class], Frame.level,
										TreeFrames[1].TalentSet, TreeFrames[2].TalentSet, TreeFrames[3].TalentSet,
										#TreeFrames[1].TreeTDB, #TreeFrames[2].TreeTDB, #TreeFrames[3].TreeTDB
									);
						end
					else
							return VT.__emulib.EncodeFrameTalentDataV2(DT.ClassToIndex[Frame.class], Frame.level,
										TreeFrames[1].TalentSet, TreeFrames[2].TalentSet, TreeFrames[3].TalentSet,
										#TreeFrames[1].TreeTDB, #TreeFrames[2].TreeTDB, #TreeFrames[3].TreeTDB
									);
					end
				else
							return VT.__emulib.EncodeFrameTalentDataV2(DT.ClassToIndex[Frame.class], Frame.level,
										TreeFrames[1].TalentSet, TreeFrames[2].TalentSet, TreeFrames[3].TalentSet,
										#TreeFrames[1].TreeTDB, #TreeFrames[2].TreeTDB, #TreeFrames[3].TreeTDB
									);
				end
				--
			else
				MT.Debug("MT.EncodeTalent", 1, "class", 'table');
				return nil;
			end
		else
			local classIndex = nil;
			if TypeClass == 'number' then
				classIndex = class;
				class = DT.IndexToClass[class];
				if classIndex == nil then
					MT.Debug("MT.EncodeTalent", 2, "class", 'number', class);
					return nil;
				end
			elseif TypeClass == 'string' then
				classIndex = DT.ClassToIndex[class];
				if classIndex == nil then
					MT.Debug("MT.EncodeTalent", 3, "class", 'string', class);
					return nil;
				end
			else
				MT.Debug("MT.EncodeTalent", 4, "class", TypeClass, class);
				return nil;
			end
			local TypeData = type(data);
			if TypeData == 'string' then
				local ClassTDB = DT.TalentDB[class];
				local SpecList = DT.ClassSpec[class];
				return VT.__emulib.EncodeFrameTalentDataV2(classIndex, (level ~= nil and tonumber(level)) or DT.MAX_LEVEL,
							data,
							#ClassTDB[SpecList[1]], #ClassTDB[SpecList[2]], #ClassTDB[SpecList[3]]);
			elseif TypeData == 'table' and type(data[1]) == 'table' and type(data[2]) == 'table' and type(data[3]) == 'table' then
				local ClassTDB = DT.TalentDB[class];
				local SpecList = DT.ClassSpec[class];
				return VT.__emulib.EncodeFrameTalentDataV2(classIndex, (level ~= nil and tonumber(level)) or DT.MAX_LEVEL,
							data[1], data[2], data[3],
							#ClassTDB[SpecList[1]], #ClassTDB[SpecList[2]], #ClassTDB[SpecList[3]]);
			else
				MT.Debug("MT.EncodeTalent", 5, "data type", TypeData);
				return nil;
			end
		end
	end
	function MT.EncodeGlyph(Frame)
		local GlyphContainer = Frame.GlyphContainer;
		if GlyphContainer ~= nil then
			local GlyphNodes = GlyphContainer.GlyphNodes;
			local data = {  };
			for index = 1, 6 do
				local Node = GlyphNodes[index];
				if Node.SpellID ~= nil then
					data[index] = { 1, Node.type, Node.SpellID, Node.Glyph:GetTexture(), };
				end
			end
			return VT.__emulib.EncodeGlyphDataV2(1, 1, data);
		end
		return nil;
	end
	function MT.EncodeEquipment(Frame)
		local EquipmentNodes = Frame.EquipmentContainer.EquipmentNodes;
		local DataTable = {  };
		for slot = 1, 19 do
			DataTable[slot] = EquipmentNodes[slot].item;
		end
		return VT.__emulib.EncodeEquipmentDataV2(DataTable);
	end

	local function SetPackIteratorFunc(Frame, name)
		if Frame.name == name then
			MT.UI.FrameSetName(Frame, name);
		end
	end
	function MT.SetPack(name)
		if VT.SET.supreme then
			MT.UI.IteratorFrames(SetPackIteratorFunc, name);
		end
	end

	function MT.ImportSimpleCode(Frame, code, name)
		if type(Frame) == 'string' then
			code = Frame;
			Frame = nil;
		end
		local class, level, numGroup, activeGroup, data1, data2 = MT.DecodeTalent(code);
		if class ~= nil then
			Frame = Frame or MT.UI.GetFrame(VT.SET.singleFrame and 1 or nil);
			if not MT.UI.FrameSetInfo(Frame, class, level, { data1, data2, num = numGroup, active = activeGroup, }, nil, name) then
				Frame:Hide();
				return false;
			end
			return true;
		elseif level ~= nil then
			MT.Notice(l10n[level]);
		end
		return false;
	end
	function MT.ExportSimpleCode(_1, _2, _3)
		if not _1 then
			return nil;
		elseif type(_1) == 'number' then
			if type(_2) == 'string' then
				return MT.EncodeTalent(_1, _2, _3);
			else
				_1 = MT.UI.GetFrame(_1);
				if not _1 then
					return nil;
				end
				return MT.EncodeTalent(_1, _2, _3);
			end
		else
			return MT.EncodeTalent(_1, _2, _3);
		end
	end
	function MT.ImportCode(Frame, code, name)
		local Tick = MT.GetUnifiedTime();
		if name == nil then
			VT.ImportIndex = VT.ImportIndex + 1;
			name = "#" .. l10n.import .. "[" .. VT.ImportIndex .. "]";
		end
		VT.QuerySent[name] = Tick;
		VT.AutoShowEquipmentFrameOnComm[name] = Tick;
		VT.ImportTargetFrame[name] = { Frame, };
		local verkey = strsub(code, 1, 1);
		if verkey ~= "_" and verkey ~= "!" then
			return MT._CommDistributor.OnTalent(name, code, "V1", VT.__emulib.DecodeTalentDataV1, false);
		end
		return VT.__emulib.CHAT_MSG_ADDON(VT.__emulib.CT.COMM_PREFIX, code, "WHISPER", name);
	end
	function MT.ExportCode(Frame)
		if Frame == nil then
			return nil;
		end
		local Type = type(Frame);
		if Type == 'table' and Frame.GetObjectType ~= nil then
			local T = MT.EncodeTalent(Frame);
			local G = MT.EncodeGlyph(Frame);
			local E = MT.EncodeEquipment(Frame);
			if T ~= nil or E ~= nil or G ~= nil then
				return (T or "") .. (G or "") .. (E or "");
			end
		else
			if Type == 'table' then
				Frame = Frame.name;
				Type = 'string';
			end
			if Type == 'string' then
			end
		end
	end

	function MT.QueryTalentSpellID(class, TreeIndex, TalentSeq, level)
		if class ~= nil and TreeIndex ~= nil and TalentSeq ~= nil then
			class = strupper(class);
			local ClassTDB = DT.TalentDB[class];
			if ClassTDB ~= nil then
				local SpecID = DT.ClassSpec[class][TreeIndex];
				if ClassTDB[SpecID] ~= nil then
					local TalentDef = ClassTDB[SpecID][TalentSeq];
					if TalentDef ~= nil then
						if level == nil or level <= 0 or level > 5 then
							level = 1;
						end
						return TalentDef[8][level];
					end
				end
			end
		end
		return nil;
	end
	function MT.QueryTalentInfoBySpellID(SpellID, class, TreeIndex)
		if SpellID == nil then
			return nil;
		end
		SpellID = tonumber(SpellID);
		if SpellID == nil then
			return nil;
		end
		if class ~= nil then
			class = strupper(class);
			local ClassTDB = DT.TalentDB[class];
			local SpecList = DT.ClassSpec[class];
			if ClassTDB ~= nil and SpecList ~= nil then
				if TreeIndex ~= nil then
					local SpecID = SpecList[TreeIndex];
					local TreeTDB = ClassTDB[SpecID];
					for TalentSeq = 1, #TreeTDB do
						local TalentDef = TreeTDB[TalentSeq];
						local SpellIDs = TalentDef[8];
						for j = 1, TalentDef[4] do
							if SpellIDs[j] == SpellID then
								return class, TreeIndex, SpecID, TalentSeq, TalentDef[1], TalentDef[2], j;
							end
						end
					end
				else
					for TreeIndex = 1, 3 do
						local SpecID = SpecList[TreeIndex];
						local TreeTDB = ClassTDB[SpecID];
						for TalentSeq = 1, #TreeTDB do
							local TalentDef = TreeTDB[TalentSeq];
							local SpellIDs = TalentDef[8];
							for j = 1, TalentDef[4] do
								if SpellIDs[j] == SpellID then
									return class, TreeIndex, SpecID, TalentSeq, TalentDef[1], TalentDef[2], j;
								end
							end
						end
					end
				end
			end
		else
			for C, ClassTDB in next, DT.TalentDB do
				if C ~= class then
					local SpecList = DT.ClassSpec[C];
					for TreeIndex = 1, 3 do
						local SpecID = SpecList[TreeIndex];
						local TreeTDB = ClassTDB[SpecID];
						for TalentSeq = 1, #TreeTDB do
							local TalentDef = TreeTDB[TalentSeq];
							local SpellIDs = TalentDef[8];
							for j = 1, TalentDef[4] do
								if SpellIDs[j] == SpellID then
									return C, TreeIndex, SpecID, TalentSeq, TalentDef[1], TalentDef[2], j;
								end
							end
						end
					end
				end
			end
		end
		return nil;
	end

	function MT.CreateEmulator(Frame, class, level, data, name, readOnly, rule, style)
		Frame = Frame or MT.UI.GetFrame(VT.SET.singleFrame and 1 or nil);
		MT.UI.FrameSetStyle(Frame, style or VT.SET.style);
		Frame:Show();
		if class == nil or class == "" then
			class = CT.SELFCLASS;
		end
		if not MT.UI.FrameSetInfo(Frame, class, tonumber(level) or DT.MAX_LEVEL, data, nil, name, readOnly, rule) then
			Frame:Hide();
			return nil;
		end
		return Frame.id;
	end

	function MT.UpdateApplyingTalentsStatus(Frame)
		local Frames = VT.Frames;
		if not VT.ApplyingTalents.Frame ~= not Frame then
			VT.ApplyingTalents.Frame = Frame;
			if Frame ~= nil then
				for i = 1, Frames.num do
					local Frame = Frames[i];
					Frame.ApplyTalentsButton:Disable();
				end
			else
				for i = 1, Frames.num do
					local Frame = Frames[i];
					Frame.ApplyTalentsButton:Enable();
				end
			end
		end
	end
	local function TryLearn(TreeIndex, TalentSeq, TalentSet, TreeTDB)
		local VM = VT.ApplyingTalents.VMap[TreeIndex];
		local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(TreeIndex, VM[TalentSeq]);
		if TalentSet[TalentSeq] > rank then
			local DepTSeq = TreeTDB[TalentSeq][11];
			if DepTSeq ~= nil then
				local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(TreeIndex, VM[DepTSeq]);
				if TalentSet[DepTSeq] > rank then
					LearnTalent(TreeIndex, VM[DepTSeq]);
					return true;
				end
			end
			if TalentSet[TalentSeq] > rank then
				LearnTalent(TreeIndex, VM[TalentSeq]);
				return true;
			end
		end
		return false;
	end
	local function ApplyTalentsTicker()
		local ApplyingTalents = VT.ApplyingTalents;
		local Frame = ApplyingTalents.Frame;
		local TreeFrames = Frame.TreeFrames;
		for TreeIndex = ApplyingTalents.TreeIndex, 3 do
			ApplyingTalents.TreeIndex = TreeIndex;
			local TreeFrame = TreeFrames[TreeIndex];
			local TalentSet = TreeFrame.TalentSet;
			local TreeTDB = TreeFrame.TreeTDB;
			for TalentSeq = ApplyingTalents.TalentSeq, #TreeTDB do
				ApplyingTalents.TalentSeq = TalentSeq;
				if TryLearn(TreeIndex, TalentSeq, TalentSet, TreeTDB) then
					local num = (select(3, GetTalentTabInfo(1)) or 0) + (select(3, GetTalentTabInfo(2)) or 0) + (select(3, GetTalentTabInfo(3)) or 0);
					Frame.ApplyTalentsProgress:SetText(num .. "/" .. ApplyingTalents.Total);
					return;
				end
			end
			ApplyingTalents.TalentSeq = 1;
		end
		--
		MT._TimerHalt(ApplyTalentsTicker);
		MT.Notice(l10n.ApplyTalentsFinished);
		Frame.ApplyTalentsProgress:SetText(nil);
		MT.UpdateApplyingTalentsStatus(nil);
	end
	function MT.ApplyTalents(Frame)
		if CT.SELFCLASS == Frame.class then
			local TalentFrame_Update = _G.TalentFrame_Update;
			if TalentFrame_Update ~= nil then
				pcall(TalentFrame_Update);
			end
			if MT.GetPointsReqLevel(Frame.TotalUsedPoints) > UnitLevel('player') then
				return MT.Notice(l10n["CANNOT APPLY : NEED MORE TALENT POINTS."]);
			end
			local Map = VT.__emulib.GetTalentMap(CT.SELFCLASS);
			if Map == nil then
				return MT.Notice(l10n["CANNOT APPLY : UNABLE TO GENERATE TALENT MAP."]);
			end
			local VMap = Map.VMap;
			local TreeFrames = Frame.TreeFrames;
			local confilicted = false;
			local total = 0;
			for TreeIndex = 1, 3 do
				local VM = VMap[TreeIndex];
				local TreeFrame = TreeFrames[TreeIndex];
				local TalentSet = TreeFrame.TalentSet;
				local TreeTDB = TreeFrame.TreeTDB;
				local NumTalents = #TreeTDB;
				if NumTalents ~= GetNumTalents(TreeIndex, false) then
					return MT.Notice(l10n["TalentDB Error : DB SIZE IS NOT EQUAL TO TalentFrame SIZE."], CT.SELFCLASS, TreeIndex, NumTalents, GetNumTalents(TreeIndex, false));
				end
				for TalentSeq = 1, NumTalents do
					local TalentIndex = VM[TalentSeq];
					if TalentIndex == nil then
						return MT.Notice(l10n["CANNOT APPLY : TALENT MAP ERROR."]);
					end
					local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(TreeIndex, TalentIndex);
					if rank > TalentSet[TalentSeq] then
						confilicted = true;
						break;
					end
					local TalentDef = TreeTDB[TalentSeq];
					if tier ~= TalentDef[1] + 1 or column ~= TalentDef[2] + 1 or maxRank ~= TalentDef[4] then
						confilicted = true;
						break;
					end
					total = total + TalentSet[TalentSeq];
				end
				if confilicted then
					break;
				end
			end
			if confilicted then
				return MT.Notice(l10n["CANNOT APPLY : TALENTS IN CONFLICT."]);
			else
				MT.UpdateApplyingTalentsStatus(Frame);
				VT.ApplyingTalents.VMap = VMap;
				VT.ApplyingTalents.TreeIndex = 1;
				VT.ApplyingTalents.TalentSeq = 1;
				VT.ApplyingTalents.Total = total;
				MT._TimerStart(ApplyTalentsTicker, 0.1);
			end
		end
	end

	local MenuElements = {
		{
			v = "autoShowEquipmentFrame",
			[true] = {
				handler = function(Button)
					VT.SET.autoShowEquipmentFrame = false;
				end,
				param = nil,
				text = l10n.AutoShowEquipmentFrame_FALSE,
			},
			[false] = {
				handler = function(Button)
					VT.SET.autoShowEquipmentFrame = true;
				end,
				param = nil,
				text = l10n.AutoShowEquipmentFrame_TRUE,
			},
		},
		{
			v = "minimap",
			[true] = {
				handler = function(Button)
					VT.SET.minimap = false;
					MT.CALLBACK["minimap"](false);
				end,
				param = nil,
				text = l10n.Minimap_FALSE,
			},
			[false] = {
				handler = function(Button)
					VT.SET.minimap = true;
					MT.CALLBACK["minimap"](true);
				end,
				param = nil,
				text = l10n.Minimap_TRUE,
			},
		},
		{
			v = "resizable_border",
			[true] = {
				handler = function(Button)
					VT.SET.resizable_border = false;
				end,
				param = nil,
				text = l10n.ResizableBorder_FALSE,
			},
			[false] = {
				handler = function(Button)
					VT.SET.resizable_border = true;
				end,
				param = nil,
				text = l10n.ResizableBorder_TRUE,
			},
		},
		{
			v = "singleFrame",
			[true] = {
				handler = function(Button, Frame)
					VT.SET.singleFrame = false;
				end,
				param = nil,
				text = l10n.SetSingleFrame_False,
			},
			[false] = {
				handler = function(Button, Frame)
					VT.SET.singleFrame = true;
					local last = Frame or MT.UI.GetLastFrame();
					MT.UI.ReleaseAllFramesButOne(last and last.id or nil);
				end,
				param = nil,
				text = l10n.SetSingleFrame_True,
			},
		},
		{
			v = "style",
			[1] = {
				handler = function(Button)
					VT.SET.style = 2;
					for i = 1, VT.Frames.used do
						MT.UI.FrameSetStyle(VT.Frames[i], 2);
					end
				end,
				param = nil,
				text = l10n.SetStyleAllTo2_LaterWin,
			},
			[2] = {
				handler = function(Button)
					VT.SET.style = 1;
					for i = 1, VT.Frames.used do
						MT.UI.FrameSetStyle(VT.Frames[i], 1);
					end
				end,
				param = nil,
				text = l10n.SetStyleAllTo1_LaterWin,
			},
			["*"] = {
				{
					handler = function(Button, Frame)
						MT.UI.FrameSetStyle(Frame, 1);
					end,
					param = nil,
					text = l10n.SetStyleAllTo1_ThisWin,
				},
				{
					handler = function(Button, Frame)
						MT.UI.FrameSetStyle(Frame, 2);
					end,
					param = nil,
					text = l10n.SetStyleAllTo2_ThisWin,
				},
			},
		},
		{
			v = "talents_in_tip",
			[true] = {
				handler = function(Button)
					VT.SET.talents_in_tip = false;
				end,
				param = nil,
				text = l10n.TalentsInTip_FALSE,
			},
			[false] = {
				handler = function(Button)
					VT.SET.talents_in_tip = true;
				end,
				param = nil,
				text = l10n.TalentsInTip_TRUE,
			},
		},
		{
			v = "talents_in_tip_icon",
			[true] = {
				handler = function(Button)
					VT.SET.talents_in_tip_icon = false;
				end,
				param = nil,
				text = l10n.TalentsInTipIcon_FALSE,
			},
			[false] = {
				handler = function(Button)
					VT.SET.talents_in_tip_icon = true;
				end,
				param = nil,
				text = l10n.TalentsInTipIcon_TRUE,
			},
		},
	};
	local MenuDefinition = {
		num = 0,
	};
	function MT.ShowMenu(Parent, Frame)
		local SET = VT.SET;
		local pos = 0;
		for index = 1, #MenuElements do
			local Def = MenuElements[index];
			local v = SET[Def.v];
			if Def[v] ~= nil then
				pos = pos + 1;
				MenuDefinition[pos] = Def[v];
				local dim = Def["*"];
				if dim ~= nil then
					for i = 1, #dim do
						pos = pos + 1;
						MenuDefinition[pos] = dim[i];
					end
				end
			end
		end
		MenuDefinition.num = pos;
		VT.__menulib.ShowMenu(Parent, "BOTTOMLEFT", MenuDefinition, Frame);
	end

	function MT.CALLBACK.OnTalentDataRecv(name, iscomm)
		local cache = VT.TQueryCache[name];
		if cache ~= nil then
			local Tick = MT.GetUnifiedTime();
			if VT.QuerySent[name] ~= nil and Tick - VT.QuerySent[name] <= CT.INSPECT_WAIT_TIME then
				MT.Debug("MT.CALLBACK.OnTalentDataRecv", cache.TalData.num);
				local readOnly = false;
				if name ~= CT.SELFNAME then
					readOnly = true;
				end
				local Frames = VT.ImportTargetFrame[name] or MT.UI.FrameGetNameBinding(name);
				if Frames ~= nil and Frames[1] ~= nil then
					local AnyShown = false;
					for i = 1, #Frames do
						if Frames[i]:IsShown() then
							MT.UI.FrameSetInfo(Frames[i], cache.class, DT.MAX_LEVEL, cache.TalData, nil, name, readOnly);
							AnyShown = true;
						end
					end
					if not AnyShown then
						MT.CreateEmulator(nil, cache.class, DT.MAX_LEVEL, cache.TalData, name, readOnly, false);
					end
				else
					MT.CreateEmulator(nil, cache.class, DT.MAX_LEVEL, cache.TalData, name, readOnly, false);
				end
			end
			VT.QuerySent[name] = nil;
		end
	end
	function MT.CALLBACK.OnGlyphDataRecv(name, iscomm, ascomm)
		local cache = VT.TQueryCache[name];
		if cache ~= nil and VT.SET.show_equipment then
			local Frames = VT.ImportTargetFrame[name] or MT.UI.FrameGetNameBinding(name);
			if Frames ~= nil and Frames[1] ~= nil then
				local popup = (iscomm or ascomm) and VT.SET.autoShowEquipmentFrame;
				MT.Debug("EquipFrame", "CALLBACK-G", popup, iscomm, ascomm, VT.SET.autoShowEquipmentFrame);
				if popup then
					local T = VT.AutoShowEquipmentFrameOnComm[name];
					if T ~= nil and MT.GetUnifiedTime() - T < 10 then
						for i = 1, #Frames do
							Frames[i].EquipmentFrameContainer:Show();
						end
					end
					VT.AutoShowEquipmentFrameOnComm[name] = nil;
				end
				for i = 1, #Frames do
					Frames[i].objects.EquipmentFrameButton:Show();
					if Frames[i].EquipmentFrameContainer:IsShown() then
						MT.UI.GlyphFrameUpdate(Frames[i].GlyphContainer, cache.GlyData);
					end
				end
			end
		end
	end
	function MT.CALLBACK.OnInventoryDataRecv(name, iscomm, ascomm)
		local cache = VT.TQueryCache[name];
		if cache ~= nil and VT.SET.show_equipment then
			local Frames = VT.ImportTargetFrame[name] or MT.UI.FrameGetNameBinding(name);
			if Frames ~= nil and Frames[1] ~= nil then
				local popup = (iscomm or ascomm) and VT.SET.autoShowEquipmentFrame;
				MT.Debug("EquipFrame", "CALLBACK-E", popup, iscomm, ascomm, VT.SET.autoShowEquipmentFrame);
				if popup then
					local T = VT.AutoShowEquipmentFrameOnComm[name];
					if T ~= nil and MT.GetUnifiedTime() - T < 10 then
						for i = 1, #Frames do
							Frames[i].EquipmentFrameContainer:Show();
						end
					end
					VT.AutoShowEquipmentFrameOnComm[name] = nil;
				end
				for i = 1, #Frames do
					Frames[i].objects.EquipmentFrameButton:Show();
					if Frames[i].EquipmentFrameContainer:IsShown() then
						MT.UI.EquipmentFrameUpdate(Frames[i].EquipmentContainer, cache.EquData);
					end
				end
			end
		end
	end

-->
