----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------

local FOLDER_NAME, private = ...
local L = private.locale

----------------------------------------------------------------------------------------------------
-----------------------------------------------LOCALS-----------------------------------------------
----------------------------------------------------------------------------------------------------

local function GetMapNames(id1, id2)
    if id1 and id2 then
        return format("%s, %s", C_Map.GetMapInfo(id1).name, C_Map.GetMapInfo(id2).name)
    end
    return C_Map.GetMapInfo(id1).name
end

----------------------------------------------------------------------------------------------------

local ElwynnForest = GetMapNames(1415, 1429)
local DrTtoIF = L["Deeprun Tram to Ironforge"]

local DunMorogh = GetMapNames(1415, 1426)
local DrTtoSW = L["Deeprun Tram to Stormwind"]

local Durotar = GetMapNames(1414, 1411)
local ZtoOG = L["Zeppelin to Orgrimmar"]

local Tirisfal = GetMapNames(1415, 1420)
local ZtoUC = L["Zeppelin to Undercity"]

local Barrens = GetMapNames(1414, 1413)
local BtoBootyBay = L["Boat to Booty Bay"]

local Wetlands = GetMapNames(1415, 1437)
local BtoMenethilHarbor = L["Boat to Menethil Harbor"]

local StranglethornVale = GetMapNames(1415, 1434)
local GromgolBaseCamp = GetMapNames(1415)..", "..C_Map.GetAreaInfo(117)
local ZtoStranglethornVale = L["Zeppelin to Stranglethorn Vale"]
local BtoRatchet = L["Boat to Ratchet"]

local DustwallowMarsh = GetMapNames(1414, 1445)
local BtoTheramore = L["Boat to Theramore"]

local Teldrassil = GetMapNames(1414, 1438)
local BtoDarnassus = L["Boat to Darnassus"]

local Darkshore = GetMapNames(1414, 1439)
local BtoAuberdine = L["Boat to Auberdine"]

----------------------------------------------------------------------------------------------------
----------------------------------------------DATABASE----------------------------------------------
----------------------------------------------------------------------------------------------------

local DB = {}

private.DB = DB

DB.points = {
-- MAPID from https://wow.gamepedia.com/UiMapID/Classic
-- or collected with /dump WorldMapFrame:GetMapID()

--[[ structure:
    [UiMapID] = { -- "_terrain1" etc will be stripped from attempts to fetch this
        [coord] = {
            icon          = ["STRING"],         -- specific icon for nodes
            label         = ["STRING"],         -- label for singel destination nodes
            multilabel    = {TABLE},            -- label for multi destination nodes
            note          = ["STRING"],         -- additional destination notes
            multinote     = {TABLE},            -- additional notes for multi destination nodes
            faction       = ["FACTION"],        -- shows only for selected faction
            class         = [CLASS NAME],       -- shows only for selected class
        },
    },
]]

---------------------------------------------------------Vanilla---------------------------------------------------------

    [1429] = { -- Elwynn Forest
        [29201782] = { icon="tram", label=DrTtoIF, note=DunMorogh },
        },
    [1453] = { -- Stormwind
        [63910817] = { icon="tram", label=DrTtoIF, note=DunMorogh },
        },
        [1411] = { -- Durotar
        [34017850] = { icon="boat", label=BtoBootyBay, note=StranglethornVale },
        [50571265] = { icon="zeppelin", label=ZtoStranglethornVale, note=GromgolBaseCamp, faction="Horde" },
        [50581265] = { icon="hzeppelin", label=ZtoStranglethornVale, note=GromgolBaseCamp, faction="Alliance"},
        [50821385] = { icon="zeppelin", label=ZtoUC, note=Tirisfal, faction="Horde" },
        [50831385] = { icon="hzeppelin", label=ZtoUC, note=Tirisfal, faction="Alliance" },
        },
    [1420] = { -- Trisfal Glades
        [60695877] = { icon="zeppelin", label=ZtoOG, note=Durotar, faction="Horde" },
        [60695878] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" },
        [61885907] = { icon="zeppelin", label=ZtoStranglethornVale, note=GromgolBaseCamp, faction="Horde" },
        [61885906] = { icon="hzeppelin", label=ZtoStranglethornVale, note=GromgolBaseCamp, faction="Alliance" },
        },
    [1437] = { -- Wetlands
        [05026348] = { icon="boat", label=BtoTheramore, note=DustwallowMarsh, faction="Alliance" },
        [05026349] = { icon="aboat", label=BtoTheramore, note=DustwallowMarsh, faction="Horde" },
        [04635710] = { icon="boat", label=BtoAuberdine, note=Darkshore, faction="Alliance" },
        [04635711] = { icon="aboat", label=BtoAuberdine, note=Darkshore, faction="Horde" },
        },
    [1414] = { -- Kalimdor
        [56785623] = { icon="boat", label=BtoBootyBay, note=StranglethornVale },
        [59276854] = { icon="boat", label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
        [59276855] = { icon="aboat", label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
        [43591733] = { icon="boat", label=BtoAuberdine, note=Darkshore, faction="Alliance" },
        [43591734] = { icon="aboat", label=BtoAuberdine, note=Darkshore, faction="Horde" },
--        [44292533] = { icon="boat", label=BtoDarnassus, note=Teldrassil, faction="Alliance" },
--        [44292534] = { icon="aboat", label=BtoDarnassus, note=Teldrassil, faction="Horde" },
--        [44152600] = { icon="boat", label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
--        [44152601] = { icon="aboat", label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
        [44292533] = { icon="aboat", multilabel={BtoDarnassus, BtoMenethilHarbor}, multinote={Teldrassil, Wetlands}, faction="Horde" },
        [44262534] = { icon="boat", multilabel={BtoDarnassus, BtoMenethilHarbor}, multinote={Teldrassil, Wetlands}, faction="Alliance" },
        [58994665] = { icon="zeppelin", multilabel={ZtoUC, ZtoStranglethornVale}, multinote={Tirisfal, GromgolBaseCamp}, faction="Horde" },
        [58994666] = { icon="hzeppelin", multilabel={ZtoUC, ZtoStranglethornVale}, multinote={Tirisfal, GromgolBaseCamp}, faction="Alliance" },
        },
    [1413] = { -- The Barrens
        [63683862] = { icon="boat", label=BtoBootyBay, note=StranglethornVale },
        },
    [1415] = { -- Eastern Kingdom
        [43839266] = { icon="boat", label=BtoRatchet, note=Barrens },
        [43976740] = { icon="tram", label=DrTtoIF, note=DunMorogh },
        [49215244] = { icon="tram", label=DrTtoSW, note=ElwynnForest, },
        [44702303] = { icon="zeppelin", multilabel={ZtoOG, ZtoStranglethornVale}, multinote={Durotar, GromgolBaseCamp}, faction="Horde" },
        [44702304] = { icon="hzeppelin", multilabel={ZtoOG, ZtoStranglethornVale}, multinote={Durotar, GromgolBaseCamp}, faction="Alliance" },
        [44868478] = { icon="zeppelin", multilabel={ZtoOG, ZtoUC}, multinote={Durotar, Tirisfal}, faction="Horde" },
        [44868479] = { icon="hzeppelin", multilabel={ZtoOG, ZtoUC}, multinote={Durotar, Tirisfal}, faction="Alliance" },

        [47544793] = { icon="aboat", multilabel={BtoAuberdine, BtoTheramore}, multinote={Darkshore, DustwallowMarsh}, faction="Horde" },
        [47544794] = { icon="boat", multilabel={BtoAuberdine, BtoTheramore}, multinote={Darkshore, DustwallowMarsh}, faction="Alliance" },
        },
    [1434] = { -- Stranglethorn Vale
        [25867311] = { icon="boat", label=BtoRatchet, note=Barrens },
        [31363015] = { icon="zeppelin", label=ZtoOG, note=Durotar, faction="Horde" },
        [31363016] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" },
        [31582911] = { icon="zeppelin", label=ZtoUC, note=Tirisfal, faction="Horde" },
        [31582912] = { icon="hzeppelin", label=ZtoUC, note=Tirisfal, faction="Alliance" },
        },
    [1426] = { -- Dun Morogh
        [63432936] = { icon="tram", label=DrTtoSW, note=ElwynnForest, },
        },
    [1455] = { -- Ironforge
        [76985153] = { icon="tram", label=DrTtoSW, note=ElwynnForest, },
        },
    [1445] = { -- Dustwallow Marsh
        [71625648] = { icon="boat", label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
        [71625649] = { icon="aboat", label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
        },
    [1438] = { -- Teldrassil
        [54859680] = { icon="boat", label=BtoAuberdine, note=Darkshore, faction="Alliance" },
        [54859681] = { icon="aboat", label=BtoAuberdine, note=Darkshore, faction="Horde" },
        },
    [1439] = { -- Darkshore
        [33194006] = { icon="boat", label=BtoDarnassus, note=Teldrassil, faction="Alliance" },
        [33194007] = { icon="aboat", label=BtoDarnassus, note=Teldrassil, faction="Horde" },
        [32404584] = { icon="boat", label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
        [32404585] = { icon="aboat", label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
        },
}