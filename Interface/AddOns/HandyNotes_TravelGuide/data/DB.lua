----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------

local FOLDER_NAME, private = ...
local L = private.locale

----------------------------------------------------------------------------------------------------
-----------------------------------------------LOCALS-----------------------------------------------
----------------------------------------------------------------------------------------------------

local function GetMapNames(id1, id2)
    if (id1 and id2) then
        return format("%s, %s", C_Map.GetMapInfo(id1).name, C_Map.GetMapInfo(id2).name)
    else
        return C_Map.GetMapInfo(id1).name
    end
end

local GetAreaInfo = C_Map.GetAreaInfo

----------------------------------------------------------------------------------------------------

local EasternKingdoms = GetMapNames(1415)
local Kalimdor = GetMapNames(1414)
local ElwynnForest = GetMapNames(1415, 1429)
local DrTtoIF = L["Deeprun Tram to Ironforge"]

local DunMorogh = GetMapNames(1415, 1426)
local DrTtoSW = L["Deeprun Tram to Stormwind"]

local Durotar = GetMapNames(1414, 1411)
local ZtoOG = L["Zeppelin to Orgrimmar"]

local Tirisfal = GetMapNames(1415, 1420)
local ZtoUC = L["Zeppelin to Undercity"]
local PtoUC = L["Portal to Undercity"]
local Orboftranslocation = L["Orb of translocation"]

local Barrens = GetMapNames(1414, 1413)
local BtoBootyBay = L["Boat to Booty Bay"]

local Wetlands = GetMapNames(1415, 1437)
local BtoMenethilHarbor = L["Boat to Menethil Harbor"]

local StranglethornVale = GetMapNames(1415, 1434)
local GromgolBaseCamp = GetMapNames(1415)..", "..GetAreaInfo(117)
local ZtoStranglethornVale = L["Zeppelin to Stranglethorn Vale"]
local BtoRatchet = L["Boat to Ratchet"]

local DustwallowMarsh = GetMapNames(1414, 1445)
local BtoTheramore = L["Boat to Theramore Isle"]

local Teldrassil = GetMapNames(1414, 1438)
local BtoDarnassus = L["Boat to Darnassus"]

local Darkshore = GetMapNames(1414, 1439)
local BtoAuberdine = L["Boat to Auberdine"]

local EversongWoods = GetMapNames(1415, 1941)
local PtoSM = L["Portal to Silvermoon"]

local Mulgore = GetMapNames(1414, 1412)
local SPtoTB = L["Shattrath Portal to Thunder Bluff"]
local SPtoOG = L["Shattrath Portal to Orgrimmar"]
local SPtoUC = L["Shattrath Portal to Undercity"]
local SPtoSM = L["Shattrath Portal to Silvermoon"]

local AzuremystIsle = GetMapNames(1414, 1943)
local BtoExodar = L["Boat to Exodar"]
local SPtoExodar = L["Shattrath Portal to Exodar"]
local SPtoDarnassus = L["Shattrath Portal to Darnassus"]
local SPtoSW = L["Shattrath Portal to Stormwind"]
local SPtoIF = L["Shattrath Portal to Ironforge"]

local SPtoIoQD = L["Shattrath Portal to Isle of Quel'Danas"]

-- WotLKC--

local CrystalsongForest = GetMapNames(113, 127)
local PtotPurpleParlor = L["Portal to the Purple Parlor"]
local BoreanTundra = GetMapNames(113, 114)
local ZtoBoreanTundra = L["Zeppelin to Borean Tundra"]
local BtoBoreanTundra = L["Boat to Borean Tundra"]
local WarsongHold = GetMapNames(113)..", "..GetAreaInfo(4129)
local ValianceKeep = GetMapNames(113)..", "..GetAreaInfo(4032)
local BtoUnuPe = L["Boat to Unu'Pe"]
local Dragonblight = GetMapNames(113, 115)
local BtoMoaKiHarbor = L["Boat to Moa'Ki Harbor"]
local HowlingFjord = GetMapNames(113, 117)
local VengeanceLanding = GetMapNames(113)..", "..GetAreaInfo(4000)
local BtoHowlingFjord = L["Boat to Howling Fjord"]
local Valgarde = GetMapNames(113)..", "..GetAreaInfo(3981)
local BtoKamagua = L["Boat to Kamagua"]
local Northrend = GetMapNames(113)
local WtoSholazarBasin = L["Waygate to Sholazar Basin"]
local WtoUngoroCrater = L["Waygate to Un'Goro Crater"]
local ZtoTB = L["Zeppelin to Thunder Bluff"]

local PtoSW = L["Portal to Stormwind"]
local BtoSW = L["Boat to Stormwind"]
local PtoOG = L["Portal to Orgrimmar"]
local ZtoHF = L["Zeppelin to Howling Fjord"]
local PtoBL = L["Portal to Blasted Lands"]

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
        [05413058] = { icon="boat", label=BtoAuberdine, note=Darkshore, faction="Alliance" },
        [05413057] = { icon="aboat", label=BtoAuberdine, note=Darkshore, faction="Horde" },
        [03221535] = { icon="boat", label=BtoBoreanTundra, note=ValianceKeep, faction="Alliance" },
        [03221534] = { icon="aboat", label=BtoBoreanTundra, note=ValianceKeep, faction="Horde" },
        [19124614] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Alliance" }
        },
    [1453] = { -- Stormwind
        [69173073] = { icon="tram", label=DrTtoIF, note=DunMorogh },
        [21605625] = { icon="boat", label=BtoAuberdine, note=Darkshore, faction="Alliance" },
        [21605624] = { icon="aboat", label=BtoAuberdine, note=Darkshore, faction="Horde" },
        [17442547] = { icon="boat", label=BtoBoreanTundra, note=ValianceKeep, faction="Alliance" },
        [17222582] = { icon="aboat", label=BtoBoreanTundra, note=ValianceKeep, faction="Horde" },
        [48988734] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Alliance" }
        },
    [1456] = { -- Thunderbluff
        [23151351] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Horde" },
        [14352576] = { icon="zeppelin", label=ZtoOG, note=Durotar, faction="Horde" },
        [14352577] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" }
        },
    [1411] = { -- Durotar
        [34017850] = { icon="boat", label=BtoBootyBay, note=StranglethornVale },
        [50571265] = { icon="zeppelin", label=ZtoStranglethornVale, note=GromgolBaseCamp, faction="Horde" },
        [50581265] = { icon="hzeppelin", label=ZtoStranglethornVale, note=GromgolBaseCamp, faction="Alliance" },
        [50781415] = { icon="zeppelin", label=ZtoUC, note=Tirisfal, faction="Horde" },
        [50781416] = { icon="hzeppelin", label=ZtoUC, note=Tirisfal, faction="Alliance" },
        [41231920] = { icon="zeppelin", label=ZtoTB, note=Mulgore, faction="Horde" },
        [41231921] = { icon="hzeppelin", label=ZtoTB, note=Mulgore, faction="Alliance" },
        [41291746] = { icon="zeppelin", label=ZtoBoreanTundra, note=BoreanTundra, faction="Horde" },
        [41291747] = { icon="hzeppelin", label=ZtoBoreanTundra, note=BoreanTundra, faction="Alliance" },
        [42590954] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Horde" }
        },
    [1412] = { -- Mulgore
        [34511959] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Horde"},
        [32722208] = { icon="zeppelin", label=ZtoOG, note=Durotar, faction="Horde" },
        [32722209] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" }
        },
    [1420] = { -- Tirisfal Glades
        [60695877] = { icon="zeppelin", label=ZtoOG, note=Durotar, faction="Horde" },
        [60695878] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" },
        [61885907] = { icon="zeppelin", label=ZtoStranglethornVale, note=GromgolBaseCamp, faction="Horde" },
        [61885906] = { icon="hzeppelin", label=ZtoStranglethornVale, note=GromgolBaseCamp, faction="Alliance" },
        [59085903] = { icon="zeppelin", label=ZtoHF, note=VengeanceLanding, faction="Horde" },
        [59085904] = { icon="hzeppelin", label=ZtoHF, note=VengeanceLanding, faction="Alliance" },
        [59456744] = { icon="portal", label=PtoSM, note=EversongWoods..")\n("..Orboftranslocation.."", faction="Horde" },
        [65896867] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Horde" }
        },
    [1437] = { -- Wetlands
        [05026348] = { icon="boat", label=BtoTheramore, note=DustwallowMarsh, faction="Alliance" },
        [05026349] = { icon="aboat", label=BtoTheramore, note=DustwallowMarsh, faction="Horde" },
        [04635710] = { icon="boat", label=BtoHowlingFjord, note=Valgarde, faction="Alliance" },
        [04635711] = { icon="aboat", label=BtoHowlingFjord, note=Valgarde, faction="Horde" }
        },
    [1414] = { -- Kalimdor
        [56785623] = { icon="boat", label=BtoBootyBay, note=StranglethornVale },
        [59276854] = { icon="boat", label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
        [59276855] = { icon="aboat", label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
        [43591733] = { icon="boat", label=BtoAuberdine, note=Darkshore, faction="Alliance" },
        [43591734] = { icon="aboat", label=BtoAuberdine, note=Darkshore, faction="Horde" },
        [44292533] = { icon="aboat", multilabel={BtoDarnassus, BtoExodar, BtoSW}, multinote={Teldrassil, AzuremystIsle, ElwynnForest}, faction="Horde" },
        [44262534] = { icon="boat", multilabel={BtoDarnassus, BtoExodar, BtoSW}, multinote={Teldrassil, AzuremystIsle, ElwynnForest}, faction="Alliance" },
        [58994665] = { icon="zeppelin", multilabel={ZtoUC, ZtoStranglethornVale}, multinote={Tirisfal, GromgolBaseCamp}, faction="Horde" },
        [58994666] = { icon="hzeppelin", multilabel={ZtoUC, ZtoStranglethornVale}, multinote={Tirisfal, GromgolBaseCamp}, faction="Alliance" },
        [57644731] = { icon="zeppelin", multilabel={ZtoTB, ZtoBoreanTundra}, multinote={Mulgore, BoreanTundra}, faction="Horde" },
        [57644732] = { icon="hzeppelin", multilabel={ZtoTB, ZtoBoreanTundra}, multinote={Mulgore, BoreanTundra}, faction="Alliance" },
        [45385636] = { icon="zeppelin", label=ZtoOG, note=Durotar, faction="Horde" },
        [45385637] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" },
        [29332792] = { icon="boat", label=BtoAuberdine, note=Darkshore, faction="Alliance" },
        [29332791] = { icon="aboat", label=BtoAuberdine, note=Darkshore, faction="Horde" },
        [49997730] = { icon="portal", label=WtoSholazarBasin, note=Northrend, requirements={quest=12613} },
        [57824617] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Horde" },
        [45625602] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Horde" },
        [39551279] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Alliance" },
        [29942698] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Alliance" }
        },
    [1413] = { -- The Barrens
        [63683862] = { icon="boat", label=BtoBootyBay, note=StranglethornVale }
        },
    [1415] = { -- Eastern Kingdom
        [43839266] = { icon="boat", label=BtoRatchet, note=Barrens },
        [43337195] = { icon="tram", label=DrTtoIF, note=DunMorogh },
        [47835898] = { icon="tram", label=DrTtoSW, note=ElwynnForest },
        [43953355] = { icon="zeppelin", multilabel={ZtoOG, ZtoStranglethornVale, ZtoHF}, multinote={Durotar, GromgolBaseCamp, VengeanceLanding}, faction="Horde" },
        [43953356] = { icon="hzeppelin", multilabel={ZtoOG, ZtoStranglethornVale, ZtoHF}, multinote={Durotar, GromgolBaseCamp, VengeanceLanding}, faction="Alliance" },
        [44098694] = { icon="zeppelin", multilabel={ZtoOG, ZtoUC}, multinote={Durotar, Tirisfal}, faction="Horde" },
        [44098693] = { icon="hzeppelin", multilabel={ZtoOG, ZtoUC}, multinote={Durotar, Tirisfal}, faction="Alliance" },
        [45995488] = { icon="aboat", multilabel={BtoTheramore, BtoHowlingFjord}, multinote={DustwallowMarsh, Valgarde}, faction="Horde" },
        [45995482] = { icon="boat", multilabel={BtoTheramore, BtoHowlingFjord}, multinote={DustwallowMarsh, Valgarde}, faction="Alliance" },
        [56041304] = { icon="portal", multilabel={PtoUC, PtoBL}, multinote={Tirisfal..") ("..Orboftranslocation.."", EasternKingdoms}, faction="Horde" },
        [43753451] = { icon="portal", multilabel={PtoSM, PtoBL}, multinote={EversongWoods..") ("..Orboftranslocation.."", EasternKingdoms}, faction="Horde" },
        [41297301] = { icon="boat", multilabel={BtoAuberdine, BtoBoreanTundra}, multinote={Darkshore, ValianceKeep}, faction="Alliance" },
        [41297302] = { icon="aboat", multilabel={BtoAuberdine, BtoBoreanTundra}, multinote={Darkshore, ValianceKeep}, faction="Horde" },
        [42467434] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Alliance" },
        [46885813] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Alliance" }
        },
    [1434] = { -- Stranglethorn Vale
        [25867311] = { icon="boat", label=BtoRatchet, note=Barrens },
        [31363015] = { icon="zeppelin", label=ZtoOG, note=Durotar, faction="Horde" },
        [31363016] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" },
        [31582911] = { icon="zeppelin", label=ZtoUC, note=Tirisfal, faction="Horde" },
        [31582912] = { icon="hzeppelin", label=ZtoUC, note=Tirisfal, faction="Alliance" }
        },
    [1426] = { -- Dun Morogh
        [63432936] = { icon="tram", label=DrTtoSW, note=ElwynnForest },
        [55452221] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Alliance" }
        },
    [1454] = { -- Orgrimmar
        [38078572] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Horde" }
        },
    [1455] = { -- Ironforge
        [76985153] = { icon="tram", label=DrTtoSW, note=ElwynnForest },
        [27230704] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Alliance" }
        },
    [1445] = { -- Dustwallow Marsh
        [71625648] = { icon="boat", label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
        [71625649] = { icon="aboat", label=BtoMenethilHarbor, note=Wetlands, faction="Horde" }
        },
    [1438] = { -- Teldrassil
        [54859680] = { icon="boat", label=BtoAuberdine, note=Darkshore, faction="Alliance" },
        [54859681] = { icon="aboat", label=BtoAuberdine, note=Darkshore, faction="Horde" },
        [25636392] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Alliance" }

        },
    [1439] = { -- Darkshore
        [33194006] = { icon="boat", label=BtoDarnassus, note=Teldrassil, faction="Alliance" },
        [33194007] = { icon="aboat", label=BtoDarnassus, note=Teldrassil, faction="Horde" },
        [32404384] = { icon="boat", label=BtoSW, note=ElwynnForest, faction="Alliance" },
        [32404383] = { icon="aboat", label=BtoSW, note=ElwynnForest, faction="Horde" },
        [30724098] = { icon="boat", label=BtoExodar, note=AzuremystIsle, faction="Alliance" },
        [30724097] = { icon="aboat", label=BtoExodar, note=AzuremystIsle, faction="Horde" }
        },
    [1457] = { -- Darnassus
        [40528168] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Alliance" }
        },
    [1449] = { -- Un'Goro Crater
        [50520774] = { icon="portal", label=WtoSholazarBasin, note=Northrend, requirements={quest=12613} }
        },

-----------------------------------------------------------BCC-----------------------------------------------------------

    [1941] = { -- Eversong Forest
        [50993068] = { icon="portal", label=PtoUC, note=Tirisfal..")\n("..Orboftranslocation.."", faction="Horde" },
        [53203220] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Horde"}
        },
    [1954] = { -- Silvermoon
        [49391483] = { icon="portal", label=PtoUC, note=Tirisfal..")\n("..Orboftranslocation.."", faction="Horde" },
        [58372100] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Horde"}
        },
    [1458] = { -- Undercity
        [54851125] = { icon="portal", label=PtoSM, note=EversongWoods..")\n("..Orboftranslocation.."", faction="Horde" },
        [85231702] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Horde" }
        },
    [1943] = { -- Azuremyst Isle
        [20355419] = { icon="boat", label=BtoAuberdine, note=Darkshore, faction="Alliance" },
        [20355420] = { icon="aboat", label=BtoAuberdine, note=Darkshore, faction="Horde" },
        [25914587] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Alliance" }
        },
    [1947] = { -- The Exodar
        [46226094] = { icon="portal", label=PtoBL, note=EasternKingdoms, faction="Alliance" }
        },
    [1955] = { -- Shattrath
        [52205290] = { icon="portal", multilabel={SPtoTB, SPtoOG, SPtoUC}, multinote={Mulgore, Durotar, Tirisfal, EversongWoods, EasternKingdoms}, faction="Horde" },
        [55793661] = { icon="portal", multilabel={SPtoDarnassus, SPtoSW, SPtoIF}, multinote={Teldrassil, ElwynnForest, DunMorogh, EasternKingdoms}, faction="Alliance" },
        [59184833] = { icon="portal", label=SPtoSM, note=EversongWoods, faction="Horde" },
        [59554665] = { icon="portal", label=SPtoExodar, note=AzuremystIsle, faction="Alliance" },
        [48584203] = { icon="portal", label=SPtoIoQD, note=EasternKingdoms }
        -- [74803160] = { icon="portal", label=PtoCavernsofTime, note=Tanaris..")\n("..L["Speak with Zephyr"], requirements={reputation={989,7} } } added in patch 2.4
        },
    [1952] = { -- Terokkar Forest
        [30612399] = { icon="portal", multilabel={SPtoTB, SPtoOG, SPtoUC, SPtoSM, SPtoIoQD}, multinote={Mulgore, Durotar, Tirisfal, EversongWoods, EasternKingdoms}, faction="Horde" },
        [30612398] = { icon="portal", multilabel={SPtoDarnassus, SPtoSW, SPtoIF, SPtoExodar, SPtoIoQD}, multinote={Teldrassil, ElwynnForest, DunMorogh, AzuremystIsle, EasternKingdoms}, faction="Alliance" }
        },
    [1944] = { -- Hellfire Peninsula
        [88564769] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [88615281] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" }
        },
    [1945] = { -- Outlands
        [43326601] = { icon="portal", multilabel={SPtoTB, SPtoOG, SPtoUC, SPtoSM, SPtoIoQD}, multinote={Mulgore, Durotar, Tirisfal, EversongWoods, EasternKingdoms}, faction="Horde" },
        [43326600] = { icon="portal", multilabel={SPtoDarnassus, SPtoSW, SPtoIF, SPtoExodar, SPtoIoQD}, multinote={Teldrassil, ElwynnForest, DunMorogh, AzuremystIsle, EasternKingdoms}, faction="Alliance" },
        [68885138] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [68905289] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" }
        },

---------------------------------------------------------WotLKC----------------------------------------------------------

    [125] = { -- Dalaran Northrend
        [40086282] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [55302542] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [25634785] = { icon="portal", label=PtotPurpleParlor }
        },
    [127] = { -- Crystalsong Forest
        [26194278] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [31223174] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" }
        },
    [113] = { -- Northrend
        [47874119] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [48664124] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [80768453] = { icon="aboat", label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
        [80768454] = { icon="boat", label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
        [24607066] = { icon="aboat", label=BtoSW, note=ElwynnForest, faction="Horde" },
        [24607065] = { icon="boat", label=BtoSW, note=ElwynnForest, faction="Alliance" },
        [47106782] = { icon="boat", multilabel={BtoUnuPe, BtoKamagua}, multinote={BoreanTundra, HowlingFjord} },
        [30506590] = { icon="boat", label=BtoMoaKiHarbor, note=Dragonblight },
        [66408188] = { icon="boat", label=BtoMoaKiHarbor, note=Dragonblight },
        [17556488] = { icon="zeppelin", label=ZtoOG, note=Durotar, faction="Horde" },
        [17556489] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" },
        [84057266] = { icon="zeppelin", label=ZtoUC, note=Tirisfal, faction="Horde" },
        [84057267] = { icon="hzeppelin", label=ZtoUC, note=Tirisfal, faction="Alliance" },
        [24364962] = { icon="portal", label=WtoUngoroCrater, note=Kalimdor, requirements={quest=12613} }
        },
    [115] = { -- Dragonblight
        [47797887] = { icon="boat", label=BtoUnuPe, note=BoreanTundra },
        [49847853] = { icon="boat", label=BtoKamagua, note=HowlingFjord }
        },
    [114] = { -- Borean Tundra
        [79015410] = { icon="boat", label=BtoMoaKiHarbor, note=Dragonblight },
        [59946946] = { icon="boat", label=BtoSW, note=ElwynnForest, faction="Alliance" },
        [59946947] = { icon="aboat", label=BtoSW, note=ElwynnForest, faction="Horde" },
        [41255344] = { icon="zeppelin", label=ZtoOG, note=Durotar, faction="Horde" },
        [41255345] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" }
        },
    [117] = { -- Howling Fjord
        [23295769] = { icon="boat", label=BtoMoaKiHarbor, note=Dragonblight },
        [61566268] = { icon="boat", label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
        [61566269] = { icon="aboat", label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
        [77612813] = { icon="zeppelin", label=ZtoUC, note=Tirisfal, faction="Horde" },
        [77612814] = { icon="hzeppelin", label=ZtoUC, note=Tirisfal, faction="Alliance" }
        },
    [119] = { -- Sholazar Basin
        [40348312] = { icon="portal", label=WtoUngoroCrater, note=Kalimdor, requirements={quest=12613} }
        }

}