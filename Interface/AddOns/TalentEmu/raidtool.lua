--[[--
	by ALA @ 163UI
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

--		upvalue
	local next = next;
	local wipe = table.wipe;
	local strmatch, format = string.match, string.format;
	local tonumber = tonumber;
	local UnitName = UnitName;
	local UnitLevel = UnitLevel;
	local UnitClassBase = UnitClassBase;
	local UnitExists = UnitExists;
	local UnitIsConnected = UnitIsConnected;
	local IsInGroup = IsInGroup;
	local IsInRaid = IsInRaid;
	local CheckInteractDistance = CheckInteractDistance;
	local CanInspect, NotifyInspect = CanInspect, NotifyInspect;
	local GuildRoster = GuildRoster;
	local GetNumGuildMembers = GetNumGuildMembers;
	local GetGuildRosterInfo = GetGuildRosterInfo;
	local GetItemInfo = GetItemInfo;
	local GetSpellInfo = GetSpellInfo;
	local Ambiguate = Ambiguate;
	local GetMouseFocus = GetMouseFocus;
	local CreateFrame = CreateFrame;
	local _G = _G;
	local UIParent = UIParent;
	local GameTooltip = GameTooltip;
	local GameFontHighlight = GameFontHighlight;
	local UISpecialFrames = UISpecialFrames;
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
	local CLASS_ICON_TCOORDS = CLASS_ICON_TCOORDS;

-->
	local L = CT.L;

-->		constant
	local TUISTYLE = {
		RaidToolUIFrameXSize = 640,
		RaidToolUIFrameYSize = 320,
		RaidToolUIFrameButtonHeight = 24,
		RaidToolUIFont = SystemFont_Shadow_Med1:GetFont(),--=="Fonts\ARKai_T.ttf"
		RaidToolUIFontSize = 14,
		RaidToolUIFontOutline = "NORMAL",
	};
	local TTEXTURESET = {
		UNK = CT.TEXTUREUNK,
		CONTROL_NORMAL_COLOR = { 1.0, 1.0, 1.0, 1.0, },
		CONTROL_PUSHED_COLOR = { 0.5, 0.5, 0.5, 1.0, },
		CONTROL_DISABLED_COLOR = { 0.25, 0.25, 0.25, 1.0, },
		CONTROL_HIGHLIGHT_COLOR = { 0.25, 0.25, 0.5, 0.5, },
		CLASS = CT.TEXTUREPATH .. [[UI-Classes-Circles]],
	};
-->
MT.BuildEnv('RAIDTOOL');
-->		predef
-->		RAIDTOOL
	--
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
			[30] = 3974,
			[32] = 3975,
			[33] = 3976,
			[663] = 12459,
			[664] = 12460,
			[2523] = 22779,
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
	local IGNORE_SLOT18 = {
		DRUID = 1,
		PALADIN = 1,
		SHAMAN = 1,
	};
	local function _GetEnchantInfo(class, slot, item)
		local _, link, _, level, _, _, _, _, loc = GetItemInfo(item);
		local hash = enchant_hash[loc];
		if hash and (hash.class == class or hash.class == nil) then
			local id, enchantId = strmatch(item, "item:(%d+):(%d+):")
			enchantId = tonumber(enchantId);
			if enchantId then
				local enchant = hash[enchantId];
				if enchant then
					return true, true, link or ("item:" .. id), GetSpellInfo(enchant) or ("spell: " .. enchant);
				else
					return true, true, link or ("item:" .. id), "enchant: " .. enchantId;
				end
			else
				return true, false, link or item;
			end
		else
			return false, false, link or item;
		end
	end
	--
	local _ItemTryTimes = {  };
	local function CalcItemLevel(class, EquData)
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
			num1 = num1 + 1;
		end
		if num1 == 0 or num2 == 0 then
			return;
		end
		return total / num1, total / num2, refresh_again;
	end
	--	LibItemEnchant
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
		[4223] = 55016,
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

	};

	local function GetEnchantInfo(class, slot, item)
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
						return true, true, link or ("item:" .. id), GetItemInfo(eitem) or GetSpellInfo(enchant) or ("item: " .. eitem);
					else
						return true, true, link or ("item:" .. id), GetSpellInfo(enchant) or ("spell: " .. enchant);
					end
				else
					return true, true, link or ("item:" .. id), "enchant: " .. enchantId;
				end
			else
				return true, false, link or item;
			end
		else
			return false, false, link or item;
		end
	end
	local function SummaryItems(class, EquData)
		if EquData then
			local missItems, missEnchants, items, enchants = 0, 0, 0, 0;
			for slot = 1, 18 do
				if slot ~= 4 then
					local item = EquData[slot];
					if item then
						items = items + 1;
						local enchantable, enchanted, link, str = GetEnchantInfo(class, slot, item);
						if enchantable then
							if enchanted then
								enchants = enchants + 1;
							else
								missEnchants = missEnchants + 1;
							end
						end
					else
						if slot == 17 and EquData[16] then
							local _, _, _, _, _, _, _, _, loc = GetItemInfo(EquData[16]);
							if loc ~= "INVTYPE_2HWEAPON" then
								missItems = missItems + 1;
							end
						elseif slot == 18 and IGNORE_SLOT18[class] then
						else
							missItems = missItems + 1;
						end
					end
				end
			end
			return missItems, missEnchants, items, enchants;
		end
	end
	local function RaidNode_OnEnter(Node)
		local data_index = Node:GetDataIndex();
		local RosterList = Node.RosterList;
		if data_index <= #RosterList then
			GameTooltip:SetOwner(Node, "ANCHOR_LEFT");
			local RosterInfo = Node.RosterInfo;
			local name = RosterList[data_index];
			local class = RosterInfo[name][1];
			local cache = VT.TQueryCache[name];
			if class == nil and cache ~= nil then
				class = cache.class;
			end
			if class then
				GameTooltip:SetText("|c" .. RAID_CLASS_COLORS[class].colorStr .. RosterList[data_index] .. "|r");
			else
				GameTooltip:SetText(RosterList[data_index]);
			end
			local EquData = cache ~= nil and cache.EquData;
			if EquData ~= nil then
				for slot = 1, 18 do
					if slot ~= 4 then
						local item = EquData[slot];
						if item then
							local enchantable, enchanted, link, str = GetEnchantInfo(class, slot, item);
							if enchantable then
								if enchanted then
									GameTooltip:AddDoubleLine(L.SLOT[slot] .. link, str);
								else
									GameTooltip:AddDoubleLine(L.SLOT[slot] .. link, L.MISS_ENCHANT);
								end
							else
								GameTooltip:AddLine(L.SLOT[slot] .. link);
							end
						else
							if slot == 17 and EquData[16] then
								local _, _, _, _, _, _, _, _, loc = GetItemInfo(EquData[16]);
								if loc == "INVTYPE_2HWEAPON" then
									GameTooltip:AddLine(L.SLOT[slot] .. "-");
								else
									GameTooltip:AddLine(L.SLOT[slot] .. L.EMTPY_SLOT);
								end
							elseif slot == 18 and IGNORE_SLOT18[class] then
								GameTooltip:AddLine(L.SLOT[slot] .. "-");
							else
								GameTooltip:AddLine(L.SLOT[slot] .. L.EMTPY_SLOT);
							end
						end
					end
				end
			end
			GameTooltip:Show();
		end
	end
	local function RaidNode_OnLeave(Node)
		if GameTooltip:IsOwned(Node) then
			GameTooltip:Hide();
		end
	end
	local function RaidNode_OnClick(Node)
	end
	local function CreateRaidNode(Parent, index, buttonHeight)
		local Node = CreateFrame('BUTTON', nil, Parent);
		Node:SetHeight(buttonHeight);
		VT.__uireimp._SetSimpleBackdrop(Node, 0, 1, 0.0, 0.0, 0.0, 0.75, 0.0, 0.0, 0.0, 1.0);
		Node:SetHighlightTexture([[Interface\FriendsFrame\UI-FriendsFrame-HighlightBar]]);
		Node:EnableMouse(true);
		Node:Show();

		local Icon = Node:CreateTexture(nil, "OVERLAY");
		Icon:SetTexture(TTEXTURESET.UNK);
		Icon:SetSize(buttonHeight - 4, buttonHeight - 4);
		Icon:SetPoint("LEFT", 4, 0);
		Icon:SetTexture(TTEXTURESET.CLASS);
		Node.Icon = Icon;

		local Title = Node:CreateFontString(nil, "OVERLAY");
		Title:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
		Title:SetPoint("LEFT", Icon, "RIGHT", 4, 0);
		Title:SetJustifyH("LEFT");
		Title:SetWidth(136);
		Title:SetMaxLines(1);
		Node.Title = Title;

		local Specs = {  };
		for TreeIndex = 1, 3 do
			local SpecIcon = Node:CreateTexture(nil, "OVERLAY");
			SpecIcon:SetSize(buttonHeight - 4, buttonHeight - 4);
			local SpecText = Node:CreateFontString(nil, "OVERLAY");
			SpecText:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
			SpecText:SetPoint("LEFT", SpecIcon, "RIGHT", 4, 0);
			SpecText:SetJustifyH("LEFT");
			SpecIcon.Name = SpecText;
			Specs[TreeIndex] = SpecIcon;
		end
		Specs[1]:SetPoint("LEFT", Node, "LEFT", 160, 0);
		Specs[2]:SetPoint("LEFT", Specs[1], "RIGHT", 24, 0);
		Specs[3]:SetPoint("LEFT", Specs[2], "RIGHT", 24, 0);
		Node.Specs = Specs;

		local ItemLevel = Node:CreateFontString(nil, "OVERLAY");
		ItemLevel:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
		ItemLevel:SetPoint("RIGHT", Specs[3], "RIGHT", 68, 0);
		Node.ItemLevel = ItemLevel;

		local MissItem = Node:CreateFontString(nil, "OVERLAY");
		MissItem:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
		MissItem:SetPoint("LEFT", ItemLevel, "RIGHT", 4, 0);
		Node.MissItem = MissItem;

		local MissEnchant = Node:CreateFontString(nil, "OVERLAY");
		MissEnchant:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
		MissEnchant:SetPoint("LEFT", MissItem, "LEFT", 60, 0);
		Node.MissEnchant = MissEnchant;

		local BossMod = Node:CreateFontString(nil, "OVERLAY");
		BossMod:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
		BossMod:SetPoint("LEFT", MissEnchant, "LEFT", 60, 0);
		BossMod:SetWidth(120);
		BossMod:SetMaxLines(1);
		Node.BossMod = BossMod;

		Node:SetScript("OnEnter", RaidNode_OnEnter);
		Node:SetScript("OnLeave", RaidNode_OnLeave);
		Node:SetScript("OnClick", RaidNode_OnClick);

		local Frame = Parent:GetParent():GetParent();
		Node.Frame = Frame;
		Node.RosterList = Frame.RosterList;
		Node.RosterInfo = Frame.RosterInfo;

		return Node;
	end
	local function SetRaidNode(Node, data_index)
		local RosterList = Node.RosterList;
		if data_index <= #RosterList then
			local RosterInfo = Node.RosterInfo;
			local name = RosterList[data_index];
			local cache = VT.TQueryCache[name];
			local info = RosterInfo[name];
			local class = info[1] or (cache ~= nil and cache.class);
			local level = info[2] or (cache ~= nil and cache.level);
			if level ~= nil then
				Node.Title:SetText(format("%2d: ", level) .. name);
			else
				Node.Title:SetText("**: " .. name);
			end
			if class ~= nil then
				local color = RAID_CLASS_COLORS[class];
				Node.Title:SetVertexColor(color.r, color.g, color.b, 1.0);
				local coord = CLASS_ICON_TCOORDS[class];
				if coord ~= nil then
					Node.Icon:SetTexCoord(coord[1] + 1 / 256, coord[2] - 1 / 256, coord[3] + 1 / 256, coord[4] - 1 / 256);
				else
					Node.Icon:SetTexCoord(0.75, 1.00, 0.75, 1.00);
				end
			else
				Node.Title:SetVertexColor(1.0, 1.0, 1.0, 1.0);
				Node.Icon:SetTexCoord(0.75, 1.00, 0.75, 1.00);
			end
			if class ~= nil and cache ~= nil then
				local TalData = cache.TalData;
				if TalData ~= nil then
					local stats = MT.CountTreePoints(TalData[TalData.active], class);
					local Specs = Node.Specs;
					local SpecList = DT.ClassSpec[class];
					for TreeIndex = 1, 3 do
						local SpecIcon = Specs[TreeIndex];
						local SpecID = SpecList[TreeIndex];
						SpecIcon:SetTexture(DT.TalentSpecIcon[SpecID] or TTEXTURESET.UNK);
						SpecIcon.Name:SetText(stats[TreeIndex]);
					end
				else
					local Specs = Node.Specs;
					for TreeIndex = 1, 3 do
						local SpecIcon = Specs[TreeIndex];
						SpecIcon:SetTexture(TTEXTURESET.UNK);
						SpecIcon.Name:SetText("*");
					end
				end
				local itemLevel1, itemLevel2, refresh_again = CalcItemLevel(class, cache.EquData);
				if itemLevel1 then
					Node.ItemLevel:SetText(format("%.1f", itemLevel1));
				else
					Node.ItemLevel:SetText(nil);
				end
				if refresh_again then
					MT._TimerStart(Node.Frame.UpdateScrollList, 0.2, 1);
				end
				local missItems, missEnchants, items, enchants = SummaryItems(class, cache.EquData);
				if missItems then
					if missItems > 0 then
						Node.MissItem:SetText(" |cff00ff00" .. items .. "|r / |cffff0000-" .. missItems .. "|r");
					else
						Node.MissItem:SetText(" |cff00ff00" .. items .. "|r");
					end
					if missEnchants > 0 then
						Node.MissEnchant:SetText(" |cff00ff00" .. enchants .. "|r / |cffff0000-" .. missEnchants .. "|r");
					else
						Node.MissEnchant:SetText(" |cff00ff00" .. enchants .. "|r");
					end
				else
					Node.MissItem:SetText(nil);
					Node.MissEnchant:SetText(nil);
				end
			else
				local Specs = Node.Specs;
				for TreeIndex = 1, 3 do
					local SpecIcon = Specs[TreeIndex];
					SpecIcon:SetTexture(TTEXTURESET.UNK);
					SpecIcon.Name:SetText("*");
				end
				Node.ItemLevel:SetText(nil);
				Node.MissItem:SetText(nil);
				Node.MissEnchant:SetText(nil);
			end
			local BossMod = VT.ExternalAddOn["D4C"].list[name] or VT.ExternalAddOn["D4BC"].list[name] or VT.ExternalAddOn["BigWigs"].list[name];
			if BossMod then
				Node.BossMod:SetText(BossMod[1]);
			else
				Node.BossMod:SetText(nil);
			end
			Node:Show();
			if GetMouseFocus() == Node then
				RaidNode_OnEnter(Node);
			end
		else
			Node:Hide();
		end
	end
	local function OnEvent(Frame, event)
		if event == "GROUP_ROSTER_UPDATE" then
			MT._TimerStart(Frame.UpdateGroupRosterList, 0.2, 1);
		elseif event == "GUILD_ROSTER_UPDATE" then
			MT._TimerStart(Frame.UpdateGuildRosterList, 0.2, 1);
		end
	end
	local TPartyUnit = { 'player', };
	for index = 1, 4 do
		TPartyUnit[index + 1] = 'party' .. index;
	end
	local TRaidUnit = {  };
	for index = 1, 40 do
		TRaidUnit[index] = 'raid' .. index;
	end
	local function UpdateGuildRosterList(Frame, force_update)
		if Frame.guild then
			local RosterList = Frame.RosterList;
			local RosterInfo = Frame.RosterInfo;
			wipe(RosterList);
			local num = 0;
			for index = 1, GetNumGuildMembers() do
				local name, rankName, rankId, level, classLocale, zone, note, officerNote, online, _, class, _, _, _, _, _, GUID = GetGuildRosterInfo(index);
				name = Ambiguate(name, 'none');
				if online then
					num = num + 1;
					RosterList[num] = name;
				end
				RosterInfo[name] = RosterInfo[name] or {  };
				local info = RosterInfo[name];
				info[1] = class;
				info[2] = level;
				info[3] = online;
				info[4] = nil;
				if online then
					MT.SendQueryRequest(name, nil, force_update, false);
				end
			end
		end
	end
	local function UpdateRaidRosterList(Frame, force_update)
		if not Frame.guild then
			local RosterList = Frame.RosterList;
			local RosterInfo = Frame.RosterInfo;
			wipe(RosterList);
			local num = 0;
			if IsInRaid() then
				for i = 1, 40 do
					local unit = TRaidUnit[i];
					if UnitExists(unit) then
						local name, realm = UnitName(unit);
						if realm ~= nil and realm ~= "" and realm ~= CT.SELFREALM then
							name = name .. "-" .. realm;
						end
						local level = UnitLevel(unit);
						local class = UnitClassBase(unit);
						local online = not not UnitIsConnected(unit);
						num = num + 1;
						RosterList[num] = name;
						RosterInfo[name] = RosterInfo[name] or {  };
						local info = RosterInfo[name];
						info[1] = class;
						info[2] = level;
						info[3] = online;
						info[4] = unit;
						if online then
							MT.SendQueryRequest(name, nil, force_update, false);
						end
					end
				end
			elseif IsInGroup() then
				for i = 1, 5 do
					local unit = TPartyUnit[i];
					if UnitExists(unit) then
						local name, realm = UnitName(unit);
						if realm ~= nil and realm ~= "" and realm ~= CT.SELFREALM then
							name = name .. "-" .. realm;
						end
						local level = UnitLevel(unit);
						local class = UnitClassBase(unit);
						local online = not not UnitIsConnected(unit);
						num = num + 1;
						RosterList[num] = name;
						RosterInfo[name] = RosterInfo[name] or {  };
						local info = RosterInfo[name];
						info[1] = class;
						info[2] = level;
						info[3] = online;
						info[4] = unit;
						if online then
							MT.SendQueryRequest(name, nil, force_update, false);
						end
					end
				end
			end
		end
	end
	local function CreateRaidToolUI()
		--	Frame
			local Frame = CreateFrame('FRAME', "ALA_RAID_TOOL_UI", UIParent);
			UISpecialFrames[#UISpecialFrames + 1] = "ALA_RAID_TOOL_UI";
			VT.__uireimp._SetSimpleBackdrop(Frame, 0, 1, 0.0, 0.0, 0.0, 0.75, 0.0, 0.0, 0.0, 1.0);
			Frame:SetSize(TUISTYLE.RaidToolUIFrameXSize, TUISTYLE.RaidToolUIFrameYSize);
			Frame:SetFrameStrata("HIGH");
			Frame:SetPoint("CENTER", 0, 0);
			Frame:EnableMouse(true);
			Frame:SetMovable(true);
			Frame:RegisterForDrag("LeftButton");
			Frame:SetScript("OnDragStart", function(self)
				self:StartMoving();
			end);
			Frame:SetScript("OnDragStop", function(self)
				self:StopMovingOrSizing();
			end);
			Frame:SetScript("OnShow", function(self)
				if self.guild then
					GuildRoster();
				end
				Frame.Update();
			end);
			Frame:Hide();
			local RosterList = {  };
			local RosterInfo = {  };
			Frame.RosterList = RosterList;
			Frame.RosterInfo = RosterInfo;
			--[[
				RosterList = { group, guild, };
				RosterInfo = { class, level, online, rank }
			]]

			local ScrollList = VT.__scrolllib.CreateScrollFrame(Frame, nil, nil, TUISTYLE.RaidToolUIFrameButtonHeight, CreateRaidNode, SetRaidNode);
			ScrollList:SetPoint("BOTTOMLEFT", 4, 24);
			ScrollList:SetPoint("TOPRIGHT", -4, -24);
			Frame.ScrollList = ScrollList;

			local Close = CreateFrame('BUTTON', nil, Frame);
			Close:SetSize(16, 16);
			Close:SetNormalTexture("interface\\buttons\\ui-stopbutton");
			Close:SetPushedTexture("interface\\buttons\\ui-stopbutton");
			Close:GetPushedTexture():SetVertexColor(TTEXTURESET.CONTROL_PUSHED_COLOR[1], TTEXTURESET.CONTROL_PUSHED_COLOR[2], TTEXTURESET.CONTROL_PUSHED_COLOR[3], TTEXTURESET.CONTROL_PUSHED_COLOR[4]);
			Close:SetHighlightTexture("interface\\buttons\\ui-stopbutton");
			Close:GetHighlightTexture():SetVertexColor(TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[1], TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[2], TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[3], TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[4]);
			Close:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -4, -4);
			Close:SetScript("OnClick", function()
				Frame:Hide();
			end);
			Frame.Close = Close;

			local Refresh = CreateFrame('BUTTON', nil, Frame);
			Refresh:SetSize(16, 16);
			Refresh:SetNormalTexture("interface\\buttons\\ui-refreshbutton");
			Refresh:SetPushedTexture("interface\\buttons\\ui-refreshbutton");
			Refresh:GetPushedTexture():SetVertexColor(TTEXTURESET.CONTROL_PUSHED_COLOR[1], TTEXTURESET.CONTROL_PUSHED_COLOR[2], TTEXTURESET.CONTROL_PUSHED_COLOR[3], TTEXTURESET.CONTROL_PUSHED_COLOR[4]);
			Refresh:SetHighlightTexture("interface\\buttons\\ui-refreshbutton");
			Refresh:GetHighlightTexture():SetVertexColor(TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[1], TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[2], TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[3], TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[4]);
			Refresh:SetPoint("RIGHT", Close, "LEFT", -4, 0);
			Refresh:SetScript("OnClick", function()
				Frame.Update(true);
			end);
			Frame.Refresh = Refresh;

			--	LAYERS
				local RaidToolLableItemLevel = Frame:CreateFontString(nil, "OVERLAY");
				RaidToolLableItemLevel:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
				RaidToolLableItemLevel:SetPoint("BOTTOMLEFT", ScrollList, "TOPLEFT", 164 + (TUISTYLE.RaidToolUIFrameButtonHeight - 4 + 24) * 3 + 12, 4);
				RaidToolLableItemLevel:SetText(L.RaidToolLableItemLevel);
				Frame.LableItemLevel = RaidToolLableItemLevel;
				local RaidToolLableMissItem = Frame:CreateFontString(nil, "OVERLAY");
				RaidToolLableMissItem:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
				RaidToolLableMissItem:SetPoint("LEFT", RaidToolLableItemLevel, "LEFT", 36, 0);
				RaidToolLableMissItem:SetText(L.RaidToolLableMissItem);
				Frame.LableMissItem = RaidToolLableMissItem;
				local RaidToolLableMissEnchant = Frame:CreateFontString(nil, "OVERLAY");
				RaidToolLableMissEnchant:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
				RaidToolLableMissEnchant:SetPoint("LEFT", RaidToolLableMissItem, "LEFT", 60, 0);
				RaidToolLableMissEnchant:SetText(L.RaidToolLableMissEnchant);
				Frame.LableMissEnchant = RaidToolLableMissEnchant;
				local RaidToolLableBossMod = Frame:CreateFontString(nil, "OVERLAY");
				RaidToolLableBossMod:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
				RaidToolLableBossMod:SetPoint("LEFT", RaidToolLableMissEnchant, "LEFT", 60, 0);
				RaidToolLableBossMod:SetWidth(120);
				RaidToolLableBossMod:SetText(L.RaidToolLableBossMod);
				Frame.LableBossMod = RaidToolLableBossMod;
			--

			local GuildList = CreateFrame('CHECKBUTTON', nil, Frame, "OptionsBaseCheckButtonTemplate");
			GuildList:SetSize(16, 16);
			GuildList:SetHitRectInsets(0, 0, 0, 0);
			GuildList:ClearAllPoints();
			GuildList:Show();
			GuildList:SetChecked(false);
			GuildList:SetPoint("BOTTOMRIGHT", -4, 2);
			GuildList:SetScript("OnClick", function(self)
				Frame.guild = self:GetChecked();
				if self.guild then
					GuildRoster();
				end
				Frame.Update();
			end);
			Frame.GuildList = GuildList;

			local GuildListLabel = Frame:CreateFontString(nil, "ARTWORK");
			GuildListLabel:SetFont(GameFontHighlight:GetFont(), 12, TUISTYLE.RaidToolUIFontOutline);
			GuildListLabel:SetText(L.GuildList);
			GuildList.Name = GuildListLabel;
			GuildListLabel:SetPoint("RIGHT", GuildList, "LEFT", 0, 0);
		--	Script
			MT._RegisterCallback("CALLBACK_DATA_RECV", function()
				if Frame:IsShown() then
					MT._TimerStart(Frame.UpdateScrollList, 0.2, 1);
				end
			end);
			function Frame.Update(force_update)
				if Frame:IsShown() then
					if Frame.guild then
						UpdateGuildRosterList(Frame, force_update);
					else
						UpdateRaidRosterList(Frame, force_update);
					end
					Frame.UpdateScrollList();
				end
			end
			function Frame.UpdateScrollList()
				if Frame:IsShown() then
					ScrollList:SetNumValue(#RosterList);
					ScrollList:Update();
				end
			end
			function Frame.UpdateGroupRosterList(force_update)
				if Frame:IsShown() and not Frame.guild then
					UpdateRaidRosterList(Frame, force_update);
				end
			end
			function Frame.UpdateGuildRosterList(force_update)
				if Frame:IsShown() and Frame.guild then
					UpdateGuildRosterList(Frame, force_update);
				end
			end
			Frame:SetScript("OnEvent", OnEvent);
			Frame:RegisterEvent("GROUP_ROSTER_UPDATE");
			--	Frame:RegisterEvent("RAID_ROSTER_UPDATE");	--	not triggered in classic
			Frame:RegisterEvent("GUILD_ROSTER_UPDATE");
			MT._TimerStart(function()
				for index = 1, #RosterList do
					local name = RosterList[index];
					if VT.TQueryCache[name] == nil and RosterInfo[name][3] then
						MT.SendQueryRequest(name, nil, false, false);
						local unit = RosterInfo[name][4];
						if unit and CheckInteractDistance(unit, 4) and CanInspect(unit) then
							NotifyInspect(unit);
						end
					end
				end
			end, 1.0);
		--
		return Frame;
	end
	function MT.ToggleRaidToolUI()
		local RaidToolUI = VT.RaidToolUI;
		if RaidToolUI:IsShown() then
			RaidToolUI:Hide();
		else
			RaidToolUI:Show();
		end
	end

	MT.RegisterOnInit('RAIDTOOL', function(LoggedIn)
		VT.RaidToolUI = CreateRaidToolUI();
		if IsInGroup() then
			MT._TriggerCallback("GROUP_ROSTER_UPDATE");
		end
	end);
	MT.RegisterOnLogin('RAIDTOOL', function(LoggedIn)
	end);

-->
