----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------

local FOLDER_NAME, private = ...
local L = private.locale

----------------------------------------------------------------------------------------------------
-----------------------------------------------LOCALS-----------------------------------------------
----------------------------------------------------------------------------------------------------

local ElwynnForest = L["Eastern Kingdoms, Elwynn Forest"]
local DrTtoIF = L["Deeprun Tram to Ironforge"]

local DunMorogh = L["Eastern Kingdoms, Dun Morogh"]
local DrTtoSW = L["Deeprun Tram to Stormwind"]

local Durotar = L["Kalimdor, Durotar"]
local ZtoOG = L["Zeppelin to Orgrimmar"]

local Tirisfal = L["Eastern Kingdoms, Tirisfal Glades"]
local ZtoUC = L["Zeppelin to Undercity"]

local Barrens = L["Kalimdor, The Barrens"]
local BtoBootyBay = L["Boat to Booty Bay"]

local Wetlands = L["Eastern Kingdoms, Wetlands"]
local BtoMenethilHarbor = L["Boat to Menethil Harbor"]

local StranglethornVale = L["Eastern Kingdoms, Stranglethorn Vale"]
local GromgolBaseCamp = L["Eastern Kingdoms, Grom'gol Base Camp"]
local ZtoStranglethornVale = L["Zeppelin to Stranglethorn Vale"]
local BtoRatchet = L["Boat to Ratchet"]

local DustwallowMarsh = L["Kalimdor, Dustwallow Marsh"]
local BtoTheramore = L["Boat to Theramore"]

local Teldrassil = L["Kalimdor, Teldrassil"]
local BtoDarnassus = L["Boat to Darnassus"]

local Darkshore = L["Kalimdor, Darkshore"]
local BtoAuberdine = L["Boat to Auberdine"]

----------------------------------------------------------------------------------------------------
----------------------------------------------DATABASE----------------------------------------------
----------------------------------------------------------------------------------------------------

local DB = {}

private.DB = DB

DB.points = {
-- MAPID from https://wow.gamepedia.com/UiMapID/Classic
    --[[ structure:
    [UiMapID] = { -- "_terrain1" etc will be stripped from attempts to fetch this
        [coord] = {
            label=[string],         -- label: text that'll be the label, optional
            npc=[id],                 -- related npc id, used to display names in tooltip
            type=[string],             -- the pre-define icon type which can be found in Constant.lua
            class=[CLASS NAME],        -- specified the class name so that this node will only be available for this class
            faction="FACTION",      -- shows only for selected faction
            note=[string],            -- additional notes for this node
            level=[number]            -- map level from dropdown
        },
    },
--]]

--Vanilla-------------------------------------------------------------------------------------------------------------------------------------------------------
    [1429] = { -- Elwynn Forest
        [29201782] = { tram=true, label=DrTtoIF, note=DunMorogh },
        },
    [1453] = { -- Stormwind
        [63910817] = { tram=true, label=DrTtoIF, note=DunMorogh },
        },
        [1411] = { -- Durotar
        [34017850] = { boat=true, label=BtoBootyBay, note=StranglethornVale },
        [50571265] = { zeppelin=true, label=ZtoStranglethornVale, note=GromgolBaseCamp, faction="Horde" },
        [50581265] = { hzeppelin=true, label=ZtoStranglethornVale, note=GromgolBaseCamp, faction="Alliance"},
        [50821385] = { zeppelin=true, label=ZtoUC, note=Tirisfal, faction="Horde" },
        [50831385] = { hzeppelin=true, label=ZtoUC, note=Tirisfal, faction="Alliance" },
        },
    [1420] = { -- Trisfal Glades
        [60695877] = { zeppelin=true, label=ZtoOG, note=Durotar, faction="Horde" },
        [60695878] = { hzeppelin=true, label=ZtoOG, note=Durotar, faction="Alliance" },
        [61885907] = { zeppelin=true, label=ZtoStranglethornVale, note=GromgolBaseCamp, faction="Horde" },
        [61885906] = { hzeppelin=true, label=ZtoStranglethornVale, note=GromgolBaseCamp, faction="Alliance" },
        },
    [1437] = { -- Wetlands
        [05026348] = { boat=true, label=BtoTheramore, note=DustwallowMarsh, faction="Alliance" },
        [05026349] = { aboat=true, label=BtoTheramore, note=DustwallowMarsh, faction="Horde" },
        [04635710] = { boat=true, label=BtoAuberdine, note=Darkshore, faction="Alliance" },
        [04635711] = { aboat=true, label=BtoAuberdine, note=Darkshore, faction="Horde" },
        },
    [1414] = { -- Kalimdor
        [56785623] = { boat=true, label=BtoBootyBay, note=StranglethornVale },
        [59276854] = { boat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
        [59276855] = { aboat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
        [43591733] = { boat=true, label=BtoAuberdine, note=Darkshore, faction="Alliance" },
        [43591734] = { aboat=true, label=BtoAuberdine, note=Darkshore, faction="Horde" },
--        [44292533] = { boat=true, label=BtoDarnassus, note=Teldrassil, faction="Alliance" },
--        [44292534] = { aboat=true, label=BtoDarnassus, note=Teldrassil, faction="Horde" },
--        [44152600] = { boat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
--        [44152601] = { aboat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
        [44292533] = { aboat=true, label1= BtoDarnassus.." ("..Teldrassil..")\n"..format(BtoMenethilHarbor.." ("..Wetlands..")"),
                                  label2= BtoDarnassus.."\n"..format(BtoMenethilHarbor..""), faction="Horde"},
        [44262534] = { boat=true, label1= BtoDarnassus.." ("..Teldrassil..")\n"..format(BtoMenethilHarbor.." ("..Wetlands..")"),
                                    label2= BtoDarnassus.."\n"..format(BtoMenethilHarbor..""), faction="Alliance" },
        [58994665] = { zeppelin=true, label1= ZtoUC.." ("..Tirisfal..")\n"..format(ZtoStranglethornVale.." ("..GromgolBaseCamp..")"),
                                  label2= ZtoUC.."\n"..format(ZtoStranglethornVale..""), faction="Horde"},
        [58994666] = { hzeppelin=true, label1= ZtoUC.." ("..Tirisfal..")\n"..format(ZtoStranglethornVale.." ("..GromgolBaseCamp..")"),
                                    label2= ZtoUC.."\n"..format(ZtoStranglethornVale..""), faction="Alliance" },
        },
    [1413] = { -- The Barrens
        [63683862] = { boat=true, label=BtoBootyBay, note=StranglethornVale },
        },
    [1415] = { -- Eastern Kingdom
        [43839266] = { boat=true, label=BtoRatchet, note=Barrens },
        [43976740] = { tram=true, label=DrTtoIF, note=DunMorogh },
        [49215244] = { tram=true, label=DrTtoSW, note=ElwynnForest, },
        [44702303] = { zeppelin=true, label1= ZtoOG.." ("..Durotar..")\n"..format(ZtoStranglethornVale.." ("..GromgolBaseCamp..")"),
                                  label2= ZtoOG.."\n"..format(ZtoStranglethornVale..""), faction="Horde"},
        [44712303] = { hzeppelin=true, label1= ZtoOG.." ("..Durotar..")\n"..format(ZtoStranglethornVale.." ("..GromgolBaseCamp..")"),
                                    label2= ZtoOG.."\n"..format(ZtoStranglethornVale..""), faction="Alliance" },
        [44868478] = { zeppelin=true, label1= ZtoOG.." ("..Durotar..")\n"..format(ZtoUC.." ("..Tirisfal..")"),
                                  label2= ZtoOG.."\n"..format(ZtoUC..""), faction="Horde"},
        [44868479] = { hzeppelin=true, label1= ZtoOG.." ("..Durotar..")\n"..format(ZtoUC.." ("..Tirisfal..")"),
                                    label2= ZtoOG.."\n"..format(ZtoUC..""), faction="Alliance" },
    
        [47544793] = { aboat=true, label1= BtoAuberdine.." ("..Darkshore..")\n"..format(BtoTheramore.." ("..DustwallowMarsh..")"),
                                  label2= BtoAuberdine.."\n"..format(BtoTheramore..""), faction="Horde"},
        [47544794] = { boat=true, label1= BtoAuberdine.." ("..Darkshore..")\n"..format(BtoTheramore.." ("..DustwallowMarsh..")"),
                                    label2= BtoAuberdine.."\n"..format(BtoTheramore..""), faction="Alliance" },
        },
    [1434] = { -- Stranglethorn Vale
        [25867311] = { boat=true, label=BtoRatchet, note=Barrens },
        [31363015] = { zeppelin=true, label=ZtoOG, note=Durotar, faction="Horde" },
        [31363016] = { hzeppelin=true, label=ZtoOG, note=Durotar, faction="Alliance" },
        [31582911] = { zeppelin=true, label=ZtoUC, note=Tirisfal, faction="Horde" },
        [31582912] = { hzeppelin=true, label=ZtoUC, note=Tirisfal, faction="Alliance" },
        },
    [1426] = { -- Dun Morogh
        [63432936] = { tram=true, label=DrTtoSW, note=ElwynnForest, },
        },
    [1455] = { -- Ironforge
        [76985153] = { tram=true, label=DrTtoSW, note=ElwynnForest, },
        },
    [1445] = { -- Dustwallow Marsh
        [71625648] = { boat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
        [71625649] = { aboat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
        },
    [1438] = { -- Teldrassil
        [54859680] = { boat=true, label=BtoAuberdine, note=Darkshore, faction="Alliance" },
        [54859681] = { aboat=true, label=BtoAuberdine, note=Darkshore, faction="Horde" },
        },
    [1439] = { -- Darkshore
        [33194006] = { boat=true, label=BtoDarnassus, note=Teldrassil, faction="Alliance" },
        [33194007] = { aboat=true, label=BtoDarnassus, note=Teldrassil, faction="Horde" },
        [32404584] = { boat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
        [32404585] = { aboat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
        },
}