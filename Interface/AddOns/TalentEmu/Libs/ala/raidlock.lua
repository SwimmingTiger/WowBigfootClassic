--[[--
	ALA@163UI
--]]--

local __version = 2;

local _G = _G;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __ala_meta__ = _G.__ala_meta__;
local __raidlib = __ala_meta__.__raidlib;
if __raidlib ~= nil and __raidlib.__minor >= __version then
	return;
end
if __raidlib ~= nil then
	if __raidlib.Halt ~= nil then
		__raidlib:Halt();
	end
else
	__raidlib = {  };
end
__raidlib.__minor = __version;
__ala_meta__.__raidlib = __raidlib;


-->			upvalue
local GetNumSavedInstances, GetSavedInstanceInfo, GetSavedInstanceEncounterInfo = GetNumSavedInstances, GetSavedInstanceInfo, GetSavedInstanceEncounterInfo;

local __raid_meta = {
	L = {
		zhCN = {
			ONY = "奥妮克希亚的巢穴",
			MC = "熔火之心",
			BWL = "黑翼之巢",
			ZG = "祖尔格拉布",
			RAQ = "安其拉废墟",
			TAQ = "安其拉神殿",
			NAXX = "纳克萨玛斯",
			DarkMoon = "暗月马戏团",
			["DarkMoon: Elwynn"] = "暗月马戏团 \124cff00afff艾尔文森林\124r",
			["DarkMoon: Mulgore"] = "暗月马戏团 \124cffff3f00莫高雷\124r",
			["DarkMoon: Terokkar"] = "暗月马戏团 \124cffffff00泰罗卡森林\124r",
			["Fishing Extravaganza"] = "荆棘谷钓鱼大赛",
			["Warsong Gulch"] = "战歌峡谷节日",
			["Arathi Basin"] = "阿拉希盆地节日",
			["Alterac Valley"] = "奥特兰克山谷节日",
			["Eye of the Storm"] = "风暴之眼节日",
			ala = "ala",
		},
		zhTW = {
			ONY = "奧妮克希亞的巢穴",
			MC = "熔火之心",
			BWL = "黑翼之巢",
			ZG = "祖爾格拉布",
			RAQ = "安其拉廢墟",
			TAQ = "安其拉",
			NAXX = "納克薩瑪斯",
			DarkMoon = "暗月馬戲團",
			["DarkMoon: Elwynn"] = "暗月馬戲團 \124cff00afff艾爾文森林\124r",
			["DarkMoon: Mulgore"] = "暗月馬戲團 \124cffff3f00莫高雷\124r",
			["DarkMoon: Terokkar"] = "暗月馬戲團 \124cffffff00泰羅卡森林\124r",
			["Fishing Extravaganza"] = "荆棘谷釣魚大賽",
			["Warsong Gulch"] = "戰歌峽谷節慶",
			["Arathi Basin"] = "阿拉希盆地節慶",
			["Alterac Valley"] = "奧特蘭克山谷節慶",
			["Eye of the Storm"] = "風暴之眼節慶",
			ala = "ala",
		},
		deDE = {
			ONY = "Onyxias Hort",
			MC = "Geschmolzener Kern",
			BWL = "Pechschwingenhort",
			ZG = "Zul'Gurub",
			RAQ = "Ruinen von Ahn'Qiraj",
			TAQ = "Ahn'Qiraj",
			NAXX = "Naxxramas",
			DarkMoon = "DarkMoon",
			["DarkMoon: Elwynn"] = "DarkMoon \124cff00afffElwynn\124r",
			["DarkMoon: Mulgore"] = "DarkMoon \124cffff3f00Mulgore\124r",
			["DarkMoon: Terokkar"] = "DarkMoon \124cffffff00Terokkar\124r",
			["Fishing Extravaganza"] = "Fishing Extravaganza",
			["Warsong Gulch"] = "Warsong Gulch Holidays",
			["Arathi Basin"] = "Arathi Basin Holidays",
			["Alterac Valley"] = "Alterac Valley Holidays",
			["Eye of the Storm"] = "Eye of the Storm Holidays",
			ala = "ala",
		},
		enUS = {
			ONY = "Onyxia's Lair",
			MC = "Molten Core",
			BWL = "Blackwing Lair",
			ZG = "Zul'Gurub",
			RAQ = "Ruins of Ahn'Qiraj",
			TAQ = "Ahn'Qiraj",
			NAXX = "Naxxramas",
			DarkMoon = "DarkMoon",
			["DarkMoon: Elwynn"] = "DarkMoon \124cff00afffElwynn\124r",
			["DarkMoon: Mulgore"] = "DarkMoon \124cffff3f00Mulgore\124r",
			["DarkMoon: Terokkar"] = "DarkMoon \124cffffff00Terokkar\124r",
			["Fishing Extravaganza"] = "Fishing Extravaganza",
			["Warsong Gulch"] = "Warsong Gulch Holidays",
			["Arathi Basin"] = "Arathi Basin Holidays",
			["Alterac Valley"] = "Alterac Valley Holidays",
			["Eye of the Storm"] = "Eye of the Storm Holidays",
			ala = "ala",
		},
		esES = {
			ONY = "Guarida de Onyxia",
			MC = "Núcleo de Magma",
			BWL = "Guarida Alanegra",
			ZG = "Zul'Gurub",
			RAQ = "Ruinas de Ahn'Qiraj",
			TAQ = "Ahn'Qiraj",
			NAXX = "Naxxramas",
			DarkMoon = "DarkMoon",
			["DarkMoon: Elwynn"] = "DarkMoon \124cff00afffElwynn\124r",
			["DarkMoon: Mulgore"] = "DarkMoon \124cffff3f00Mulgore\124r",
			["DarkMoon: Terokkar"] = "DarkMoon \124cffffff00Terokkar\124r",
			["Fishing Extravaganza"] = "Fishing Extravaganza",
			["Warsong Gulch"] = "Warsong Gulch Holidays",
			["Arathi Basin"] = "Arathi Basin Holidays",
			["Alterac Valley"] = "Alterac Valley Holidays",
			["Eye of the Storm"] = "Eye of the Storm Holidays",
			ala = "ala",
		},
		frFR = {
			ONY = "Repaire d'Onyxia",
			MC = "Cœur du Magma",
			BWL = "Repaire de l'Aile noire",
			ZG = "Zul'Gurub",
			RAQ = "Ruines d'Ahn'Qiraj",
			TAQ = "Ahn'Qiraj",
			NAXX = "Naxxramas",
			DarkMoon = "DarkMoon",
			["DarkMoon: Elwynn"] = "DarkMoon \124cff00afffElwynn\124r",
			["DarkMoon: Mulgore"] = "DarkMoon \124cffff3f00Mulgore\124r",
			["DarkMoon: Terokkar"] = "DarkMoon \124cffffff00Terokkar\124r",
			["Fishing Extravaganza"] = "Fishing Extravaganza",
			["Warsong Gulch"] = "Warsong Gulch Holidays",
			["Arathi Basin"] = "Arathi Basin Holidays",
			["Alterac Valley"] = "Alterac Valley Holidays",
			["Eye of the Storm"] = "Eye of the Storm Holidays",
			ala = "ala",
		},
		ptBR = {
			ONY = "Covil da Onyxia",
			MC = "Núcleo Derretido",
			BWL = "Covil Asa Negra",
			ZG = "Zul'Gurub",
			RAQ = "Ruínas de Ahn'Qiraj",
			TAQ = "Ahn'Qiraj",
			NAXX = "Naxxramas",
			DarkMoon = "DarkMoon",
			["DarkMoon: Elwynn"] = "DarkMoon \124cff00afffElwynn\124r",
			["DarkMoon: Mulgore"] = "DarkMoon \124cffff3f00Mulgore\124r",
			["DarkMoon: Terokkar"] = "DarkMoon \124cffffff00Terokkar\124r",
			["Fishing Extravaganza"] = "Fishing Extravaganza",
			["Warsong Gulch"] = "Warsong Gulch Holidays",
			["Arathi Basin"] = "Arathi Basin Holidays",
			["Alterac Valley"] = "Alterac Valley Holidays",
			["Eye of the Storm"] = "Eye of the Storm Holidays",
			ala = "ala",
		},
		ruRU = {
			ONY = "Логово Ониксии",
			MC = "Огненные Недра",
			BWL = "Логово Крыла Тьмы",
			ZG = "Зул'Гуруб",
			RAQ = "Руины Ан'Киража",
			TAQ = "Ан'Кираж",
			NAXX = "Наксрамас",
			DarkMoon = "DarkMoon",
			["DarkMoon: Elwynn"] = "DarkMoon \124cff00afffElwynn\124r",
			["DarkMoon: Mulgore"] = "DarkMoon \124cffff3f00Mulgore\124r",
			["DarkMoon: Terokkar"] = "DarkMoon \124cffffff00Terokkar\124r",
			["Fishing Extravaganza"] = "Fishing Extravaganza",
			["Warsong Gulch"] = "Warsong Gulch Holidays",
			["Arathi Basin"] = "Arathi Basin Holidays",
			["Alterac Valley"] = "Alterac Valley Holidays",
			["Eye of the Storm"] = "Eye of the Storm Holidays",
			ala = "ala",
		},
		koKR = {
			ONY = "오닉시아의 둥지",
			MC = "화산 심장부",
			BWL = "검은날개 둥지",
			ZG = "줄구룹",
			RAQ = "안퀴라즈 폐허",
			TAQ = "안퀴라즈",
			NAXX = "낙스라마스",
			DarkMoon = "다크문",
			["DarkMoon: Elwynn"] = "다크문 \124cff00afff엘윈숲\124r",
			["DarkMoon: Mulgore"] = "다크문 \124cffff3f00멀고어\124r",
			["DarkMoon: Terokkar"] = "다크문 \124cffffff00Terokkar\124r",
			["Fishing Extravaganza"] = "가시덤불 골짜기 낚시대회",
			["Warsong Gulch"] = "전쟁노래 협곡 사절단",
			["Arathi Basin"] = "아라시 분지 사절단",
			["Alterac Valley"] = "알터렉 계곡 사절단",
			["Eye of the Storm"] = "Eye of the Storm Holidays",
			ala = "ala",
		},
		--itIT
		['*'] = {
			ONY = "Onyxia's Lair",
			MC = "Molten Core",
			BWL = "Blackwing Lair",
			ZG = "Zul'Gurub",
			RAQ = "Ruins of Ahn'Qiraj",
			TAQ = "Ahn'Qiraj",
			NAXX = "Naxxramas",
			DarkMoon = "DarkMoon",
			["DarkMoon: Elwynn"] = "DarkMoon \124cff00afffElwynn\124r",
			["DarkMoon: Mulgore"] = "DarkMoon \124cffff3f00Mulgore\124r",
			["DarkMoon: Terokkar"] = "DarkMoon \124cffffff00Terokkar\124r",
			["Fishing Extravaganza"] = "Fishing Extravaganza",
			["Warsong Gulch"] = "Warsong Gulch Holidays",
			["Arathi Basin"] = "Arathi Basin Holidays",
			["Alterac Valley"] = "Alterac Valley Holidays",
			["Eye of the Storm"] = "Eye of the Storm Holidays",
			ala = "ala",
		},
	},
	hash = {  };
};
local L2 = {
	ONY = 249,
	MC = 409,
	BWL = 469,
	ZG = 309,
	RAQ = 509,
	TAQ = 531,
	NAXX = 533,
	--
	Kara = 532,
	Hyjal = 534,
	Magtheridon = 544,
	Serpent = 548,
	Tempest = 550,
	BT = 564,
	Gruul = 565,
	SW = 580,
	ZAM = 568,
	--
	NAXX = 533,
};
__raid_meta.esMX = __raid_meta.esES;
local to = __raid_meta.L[GetLocale()] or __raid_meta.L['*'];
for key, id in next, L2 do
	to[key] = GetRealZoneText(id) or to[key] or key;
end
for LOC, LIST in next, __raid_meta.L do
	for key, val in next, LIST do
		__raid_meta.hash[val] = key;
	end
end
__raidlib.__raid_meta = __raid_meta;
function __raidlib.GetRaidLockedData(detailed)
	local data = {  };
	for instanceIndex = 1, GetNumSavedInstances() do
		local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(instanceIndex);
		if locked and isRaid then
			local inst = __raid_meta.hash[name];
			if inst then
				local msg = inst .. ":" .. encounterProgress .. ":" .. numEncounters;
				if detailed then
					for encounterIndex = 1, numEncounters do
						local bossName, fileDataID, isKilled, unknown4 = GetSavedInstanceEncounterInfo(instanceIndex, encounterIndex);
						msg = msg .. "#" .. isKilled and "1" or "0";
					end
				end
				-- local t = now + reset;
				-- local var = VAR[inst];
				-- var[1] = id;
				-- var[2] = t;
				-- var[3] = numEncounters;
				-- var[4] = encounterProgress;
				-- earliest = min(earliest, t);
				-- for encounterIndex = 1, numEncounters do
				-- 	local bossName, fileDataID, isKilled, unknown4 = GetSavedInstanceEncounterInfo(instanceIndex, encounterIndex);
				-- 	var[4 + encounterIndex * 2 - 1] = bossName;
				-- 	var[4 + encounterIndex * 2] = isKilled;
				-- end
			else
			end
		end
	end
end
function __raidlib:Halt()
end
