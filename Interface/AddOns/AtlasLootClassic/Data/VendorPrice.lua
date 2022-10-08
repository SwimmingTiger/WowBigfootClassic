local ALName, ALPrivate = ...

local AtlasLoot = _G.AtlasLoot
local VendorPrice = {}
AtlasLoot.Data.VendorPrice = VendorPrice
local AL = AtlasLoot.Locales

local PRICE_INFO_LIST = {
	--- Classic
	-- items
	["burningblossom"] 	= { itemID = 23247 }, -- Burning Blossom
	["ancestrycoin"] 	= { itemID = 21100 }, -- Coin of Ancestry
    ["NecroticRune"] 	= { itemID = 22484 }, -- Necrotic Rune

	-- others
	["money"] 			= { func = GetCoinTextureString },

	--- BC
	["holydust"] = { itemID = 29735 }, -- Holy Dust (Aldor)
	["arcanerune"] = { itemID = 29736 }, -- Holy Dust (Scryers)
	["SpiritShard"] = { itemID = 28558 }, -- Spirit Shard
	["HalaaRT"] = { itemID = 26044 }, -- Halaa Research Token
	["HalaaBT"] = { itemID = 26045 }, -- Halaa Battle Token
	["MarkOfThrallmar"] = { itemID = 24581 }, -- Mark of Thrallmar
	["MarkOfHonorHold"] = { itemID = 24579 }, -- Mark of Honor Hold
	["BoJ"] = { itemID = 29434 }, -- Badge of Justice
	["glowcap"] = { itemID = 24245 }, -- Glowcap
	["ApexisC"] = { itemID = 32572 }, -- Apexis Crystal
	["ApexisS"] = { itemID = 32569 }, -- Apexis Shard
	["Brewfest"] = { itemID = 37829 }, -- Brewfest Prize Token
    ["sunmote"] = { itemID = 34664 }, -- Sunmote
	-- pvp
	["honor"] = { currencyID = 1901 }, -- Honor
	["arena"] = { currencyID = 1900 },  -- Arena
	--["honorH"] = { currencyID = 1901 }, -- Honor / Horde
	--["honorA"] = { currencyID = 1901 }, -- Honor / Alli
	["pvpAlterac"] = { itemID = 20560 }, -- Alterac Valley Mark of Honor
	["pvpWarsong"] = { itemID = 20558 }, -- Warsong Gulch Mark of Honor
	["pvpArathi"] = { itemID = 20559 }, -- Arathi Basin Mark of Honor
	["pvpEye"] = { itemID = 29024 }, -- Eye of the Storm Mark of Honor

    --- Wrath
    ["epicurean"] = { currencyID = 81 }, -- Epicurean's Award

    ["championsSeal"] = { currencyID = 241 }, -- Champion's Seal
    ["EmblemOfHeroism"] = { currencyID = 101 }, -- Emblem of Heroism
    ["EmblemOfValor"] = { currencyID = 102 }, -- Emblem of Valor
    ["EmblemOfTriumph"] = { currencyID = 301 }, -- Emblem of Triumph
    ["EmblemOfConquest"] = { currencyID = 221 }, -- Emblem of Conquest
    ["EmblemOfFrost"] = { currencyID = 341 }, -- Emblem of Frost

    ["cpvpAlterac"] = { currencyID = 121 }, -- Alterac Valley Mark of Honor
	["cpvpWarsong"] = { currencyID = 125 }, -- Warsong Gulch Mark of Honor
	["cpvpArathi"] = { currencyID = 122 }, -- Arathi Basin Mark of Honor
	["cpvpEye"] = { currencyID = 123 }, -- Eye of the Storm Mark of Honor
	["cpvpWintergrasp"] = { currencyID = 126 }, -- Wintergrasp Mark of Honor
	["cpvpIsle"] = { currencyID = 321 }, -- Isle of Conquest Mark of Honor
	["cpvpStrand"] = { currencyID = 124 }, -- Strand of the Ancients Mark of Honor
}

local VENDOR_PRICE_FORMAT = {}
for k, v in pairs(PRICE_INFO_LIST) do
    if v.itemID then
        VENDOR_PRICE_FORMAT[v.itemID] = k..":%d"
    elseif v.currencyID and C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo then
        local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(v.currencyID)
        if currencyInfo and currencyInfo.iconFileID then
            VENDOR_PRICE_FORMAT[currencyInfo.iconFileID] = k..":%d"
        end
    end
end

-- updated with script
local VENDOR_PRICES, VENDOR_PRICES_RAW = AtlasLoot:GetGameVersionDataTable()
VENDOR_PRICES_RAW.CLASSIC = {

}

if AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM) then
    VENDOR_PRICES_RAW.BCC = {
        [15196] = "pvpArathi:3:pvpWarsong:3",
        [15197] = "pvpArathi:3:pvpWarsong:3",
        [15198] = "pvpAlterac:20:pvpArathi:20:pvpWarsong:20",
        [15199] = "pvpAlterac:20:pvpArathi:20:pvpWarsong:20",
        [17348] = "money:1000",
        [17349] = "money:500",
        [17351] = "money:1000",
        [17352] = "money:500",
        [18839] = "money:900:honor:1",
        [18841] = "money:900:honor:1",
        [19029] = "pvpAlterac:50",
        [19030] = "pvpAlterac:50",
        [19031] = "pvpAlterac:60",
        [19032] = "pvpAlterac:60",
        [19045] = "pvpAlterac:30",
        [19046] = "pvpAlterac:30",
        [19060] = "money:2000",
        [19061] = "money:1500",
        [19062] = "money:1000",
        [19066] = "money:2000",
        [19067] = "money:1500",
        [19068] = "money:1000",
        [19301] = "money:7000",
        [19307] = "money:8000",
        [19316] = "money:6000",
        [19317] = "money:6000",
        [19318] = "money:5000",
        [19505] = "pvpWarsong:60",
        [19506] = "pvpWarsong:60",
        [20222] = "money:2000",
        [20223] = "money:1000",
        [20224] = "money:1500",
        [20225] = "money:2000",
        [20226] = "money:1000",
        [20227] = "money:1500",
        [20232] = "money:1500",
        [20234] = "money:2000",
        [20235] = "money:1000",
        [20237] = "money:1500",
        [20243] = "money:2000",
        [20244] = "money:1000",
        [22906] = "glowcap:30",
        [22916] = "glowcap:25",
        [22917] = "money:76000",
        [22918] = "money:64000",
        [22922] = "money:80000",
        [23572] = "BoJ:10",
        [23618] = "money:48000",
        [23814] = "money:48000",
        [24183] = "money:96000",
        [24417] = "money:1600",
        [24429] = "money:6400",
        [24539] = "glowcap:2",
        [25526] = "money:48000",
        [25548] = "glowcap:1",
        [25550] = "glowcap:1",
        [25735] = "money:128000",
        [25736] = "money:112000",
        [25737] = "money:112000",
        [25741] = "money:114000",
        [25742] = "money:114000",
        [25743] = "money:114000",
        [25827] = "glowcap:25",
        [25828] = "glowcap:15",
        [25835] = "money:358386",
        [25836] = "money:359704",
        [25838] = "money:181153",
        [25869] = "money:64000",
        [27689] = "glowcap:2",
        [28271] = "money:64000",
        [28553] = "SpiritShard:50",
        [28555] = "SpiritShard:50",
        [28556] = "SpiritShard:8",
        [28557] = "SpiritShard:8",
        [28559] = "SpiritShard:18",
        [28560] = "SpiritShard:18",
        [28561] = "SpiritShard:18",
        [28574] = "SpiritShard:18",
        [28575] = "SpiritShard:18",
        [28576] = "SpiritShard:18",
        [28577] = "SpiritShard:18",
        [28632] = "money:48000",
        [28758] = "SpiritShard:18",
        [28759] = "SpiritShard:18",
        [28760] = "SpiritShard:18",
        [28761] = "SpiritShard:18",
        [29102] = "money:950000",
        [29103] = "money:950000",
        [29104] = "money:950000",
        [29105] = "money:950000",
        [29135] = "money:196078",
        [29136] = "money:207130",
        [29137] = "money:496240",
        [29138] = "money:524391",
        [29139] = "money:120013",
        [29140] = "money:130313",
        [29141] = "money:218003",
        [29142] = "money:196936",
        [29143] = "money:100000",
        [29144] = "money:100000",
        [29145] = "money:167154",
        [29146] = "money:175951",
        [29147] = "money:158775",
        [29148] = "money:150969",
        [29149] = "glowcap:20",
        [29150] = "glowcap:45",
        [29170] = "money:632090",
        [29171] = "money:2125454",
        [29172] = "money:632090",
        [29173] = "money:140762",
        [29174] = "money:101897",
        [29192] = "money:800000",
        [29194] = "money:800000",
        [29217] = "money:108000",
        [29218] = "money:108000",
        [29219] = "money:108000",
        [29227] = "money:900000",
        [29229] = "money:900000",
        [29230] = "money:900000",
        [29231] = "money:900000",
        [29266] = "BoJ:33",
        [29267] = "BoJ:33",
        [29268] = "BoJ:33",
        [29269] = "BoJ:25",
        [29270] = "BoJ:25",
        [29271] = "BoJ:25",
        [29272] = "BoJ:25",
        [29273] = "BoJ:25",
        [29274] = "BoJ:25",
        [29275] = "BoJ:50",
        [29367] = "BoJ:25",
        [29368] = "BoJ:25",
        [29369] = "BoJ:25",
        [29370] = "BoJ:41",
        [29373] = "BoJ:25",
        [29374] = "BoJ:25",
        [29375] = "BoJ:25",
        [29376] = "BoJ:41",
        [29379] = "BoJ:25",
        [29381] = "BoJ:25",
        [29382] = "BoJ:25",
        [29383] = "BoJ:41",
        [29384] = "BoJ:25",
        [29385] = "BoJ:25",
        [29386] = "BoJ:25",
        [29387] = "BoJ:41",
        [29388] = "BoJ:15",
        [29389] = "BoJ:15",
        [29390] = "BoJ:15",
        [29465] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [29466] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [29467] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [29468] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [29469] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [29470] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [29471] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [29472] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [29664] = "money:47500",
        [29720] = "money:48000",
        [29721] = "money:96000",
        [30156] = "glowcap:1",
        [30183] = "BoJ:15",
        [30443] = "money:72000",
        [30444] = "money:45000",
        [30623] = "money:80000",
        [30761] = "BoJ:30",
        [30762] = "BoJ:30",
        [30763] = "BoJ:20",
        [30764] = "BoJ:20",
        [30766] = "BoJ:30",
        [30767] = "BoJ:20",
        [30768] = "BoJ:20",
        [30769] = "BoJ:30",
        [30770] = "BoJ:20",
        [30772] = "BoJ:30",
        [30773] = "BoJ:30",
        [30774] = "BoJ:20",
        [30776] = "BoJ:30",
        [30778] = "BoJ:30",
        [30779] = "BoJ:20",
        [30780] = "BoJ:20",
        [31356] = "money:32000",
        [31390] = "money:192000",
        [31391] = "money:192000",
        [31392] = "money:192000",
        [31402] = "money:96000",
        [31773] = "money:9500",
        [31774] = "money:9000",
        [31775] = "glowcap:10",
        [31804] = "money:8000",
        [31829] = "money:665000",
        [31830] = "money:630000",
        [31831] = "money:665000",
        [31832] = "money:630000",
        [31833] = "money:665000",
        [31834] = "money:630000",
        [31835] = "money:665000",
        [31836] = "money:630000",
        [31838] = "pvpArathi:2",
        [31839] = "pvpAlterac:2",
        [31840] = "pvpArathi:2",
        [31841] = "pvpAlterac:2",
        [31852] = "pvpEye:2",
        [31853] = "money:3200:honor:50",
        [31854] = "pvpEye:2",
        [31855] = "money:3200:honor:50",
        [31949] = "money:4000",
        [32070] = "money:32000",
        [32083] = "BoJ:50",
        [32084] = "BoJ:50",
        [32085] = "BoJ:50",
        [32086] = "BoJ:50",
        [32087] = "BoJ:50",
        [32088] = "BoJ:50",
        [32089] = "BoJ:50",
        [32090] = "BoJ:50",
        [32227] = "BoJ:15",
        [32228] = "BoJ:15",
        [32229] = "BoJ:15",
        [32230] = "BoJ:15",
        [32231] = "BoJ:15",
        [32233] = "money:5000",
        [32249] = "BoJ:15",
        [32314] = "money:2000000",
        [32316] = "money:2000000",
        [32317] = "money:2000000",
        [32318] = "money:2000000",
        [32319] = "money:2000000",
        [32445] = "money:10000",
        [32453] = "money:2000:honor:2",
        [32455] = "money:1080:honor:1",
        [32538] = "money:137691",
        [32539] = "money:138166",
        [32645] = "ApexisC:4:ApexisS:100",
        [32647] = "ApexisC:4:ApexisS:100",
        [32648] = "ApexisC:4:ApexisS:100",
        [32650] = "ApexisC:1:ApexisS:50",
        [32651] = "ApexisC:4:ApexisS:100",
        [32652] = "ApexisC:1:ApexisS:50",
        [32653] = "ApexisC:1:ApexisS:50",
        [32654] = "ApexisC:1:ApexisS:50",
        [32721] = "money:4500",
        [32722] = "money:4000",
        [32770] = "money:41230",
        [32771] = "money:41230",
        [32783] = "ApexisS:3",
        [32784] = "ApexisS:2",
        [32828] = "ApexisS:10",
        [32947] = "SpiritShard:2",
        [32948] = "SpiritShard:2",
        [33047] = "Brewfest:100",
        [33149] = "money:80000",
        [33192] = "BoJ:25",
        [33207] = "BoJ:60",
        [33222] = "BoJ:60",
        [33279] = "BoJ:60",
        [33280] = "BoJ:60",
        [33287] = "BoJ:60",
        [33291] = "BoJ:60",
        [33296] = "BoJ:35",
        [33304] = "BoJ:60",
        [33324] = "BoJ:60",
        [33325] = "BoJ:35",
        [33331] = "BoJ:60",
        [33333] = "BoJ:60",
        [33334] = "BoJ:35",
        [33386] = "BoJ:60",
        [33484] = "BoJ:60",
        [33501] = "BoJ:75",
        [33502] = "BoJ:20",
        [33503] = "BoJ:20",
        [33504] = "BoJ:20",
        [33505] = "BoJ:20",
        [33506] = "BoJ:20",
        [33507] = "BoJ:20",
        [33508] = "BoJ:20",
        [33509] = "BoJ:20",
        [33510] = "BoJ:20",
        [33512] = "BoJ:60",
        [33513] = "BoJ:35",
        [33514] = "BoJ:60",
        [33515] = "BoJ:75",
        [33516] = "BoJ:35",
        [33517] = "BoJ:60",
        [33518] = "BoJ:75",
        [33519] = "BoJ:60",
        [33520] = "BoJ:35",
        [33522] = "BoJ:75",
        [33523] = "BoJ:60",
        [33524] = "BoJ:60",
        [33527] = "BoJ:75",
        [33528] = "BoJ:60",
        [33529] = "BoJ:35",
        [33530] = "BoJ:75",
        [33531] = "BoJ:60",
        [33532] = "BoJ:35",
        [33534] = "BoJ:60",
        [33535] = "BoJ:35",
        [33536] = "BoJ:60",
        [33537] = "BoJ:60",
        [33538] = "BoJ:75",
        [33539] = "BoJ:60",
        [33540] = "BoJ:35",
        [33552] = "BoJ:75",
        [33557] = "BoJ:35",
        [33559] = "BoJ:60",
        [33566] = "BoJ:75",
        [33577] = "BoJ:60",
        [33578] = "BoJ:35",
        [33579] = "BoJ:75",
        [33580] = "BoJ:35",
        [33582] = "BoJ:60",
        [33583] = "BoJ:60",
        [33584] = "BoJ:75",
        [33585] = "BoJ:75",
        [33586] = "BoJ:60",
        [33587] = "BoJ:60",
        [33588] = "BoJ:35",
        [33589] = "BoJ:35",
        [33593] = "BoJ:35",
        [33810] = "BoJ:75",
        [33832] = "BoJ:75",
        [33862] = "Brewfest:200",
        [33863] = "Brewfest:200",
        [33864] = "Brewfest:50",
        [33868] = "Brewfest:100",
        [33927] = "Brewfest:100",
        [33934] = "money:3400:ApexisS:50",
        [33935] = "money:3400:ApexisS:50",
        [33965] = "BoJ:75",
        [33966] = "Brewfest:100",
        [33967] = "Brewfest:50",
        [33968] = "Brewfest:50",
        [33969] = "Brewfest:50",
        [33970] = "BoJ:60",
        [33972] = "BoJ:75",
        [33973] = "BoJ:60",
        [33974] = "BoJ:60",
        [33978] = "Brewfest:600",
        [33999] = "money:16000000",
        [34008] = "Brewfest:100",
        [34028] = "Brewfest:600",
        [34049] = "BoJ:75",
        [34050] = "BoJ:75",
        [34129] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [34162] = "BoJ:75",
        [34163] = "BoJ:75",
        [34172] = "money:152000",
        [34173] = "money:144000",
        [34174] = "money:152000",
        [34175] = "money:144000",
        [34478] = "glowcap:30",
        [34887] = "BoJ:60",
        [34888] = "BoJ:60",
        [34889] = "BoJ:60",
        [34890] = "BoJ:60",
        [34891] = "BoJ:150",
        [34892] = "BoJ:150",
        [34893] = "BoJ:105",
        [34894] = "BoJ:105",
        [34895] = "BoJ:150",
        [34896] = "BoJ:150",
        [34898] = "BoJ:150",
        [34900] = "BoJ:100",
        [34901] = "BoJ:100",
        [34902] = "BoJ:75",
        [34903] = "BoJ:100",
        [34904] = "BoJ:75",
        [34905] = "BoJ:100",
        [34906] = "BoJ:100",
        [34910] = "BoJ:100",
        [34911] = "BoJ:75",
        [34912] = "BoJ:100",
        [34914] = "BoJ:100",
        [34916] = "BoJ:75",
        [34917] = "BoJ:100",
        [34918] = "BoJ:100",
        [34919] = "BoJ:75",
        [34921] = "BoJ:100",
        [34922] = "BoJ:100",
        [34923] = "BoJ:75",
        [34924] = "BoJ:100",
        [34925] = "BoJ:100",
        [34926] = "BoJ:75",
        [34927] = "BoJ:100",
        [34928] = "BoJ:100",
        [34929] = "BoJ:75",
        [34930] = "BoJ:100",
        [34931] = "BoJ:100",
        [34932] = "BoJ:75",
        [34933] = "BoJ:100",
        [34934] = "BoJ:100",
        [34935] = "BoJ:75",
        [34936] = "BoJ:100",
        [34937] = "BoJ:100",
        [34938] = "BoJ:75",
        [34939] = "BoJ:100",
        [34940] = "BoJ:100",
        [34941] = "BoJ:75",
        [34942] = "BoJ:100",
        [34943] = "BoJ:100",
        [34944] = "BoJ:75",
        [34945] = "BoJ:100",
        [34946] = "BoJ:100",
        [34947] = "BoJ:75",
        [34949] = "BoJ:45",
        [34950] = "BoJ:45",
        [34951] = "BoJ:45",
        [34952] = "BoJ:45",
        [35321] = "BoJ:60",
        [35324] = "BoJ:60",
        [35326] = "BoJ:75",
        [35329] = "money:104726",
        [35336] = "money:127597",
        [35342] = "money:173807",
        [35347] = "money:164580",
        [35358] = "money:202894",
        [35365] = "money:201430",
        [35367] = "money:146143",
        [35374] = "money:149973",
        [35379] = "money:226822",
        [35385] = "money:184540",
        [35387] = "money:123397",
        [35394] = "money:259883",
        [35403] = "money:127598",
        [35408] = "money:145302",
        [35415] = "money:272224",
        [35906] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [37736] = "Brewfest:200",
        [37737] = "Brewfest:200",
        [37750] = "Brewfest:2",
        [37816] = "Brewfest:20",
        [38229] = "glowcap:25",
        [38628] = "money:400000",
        [39476] = "Brewfest:5",
        [39477] = "Brewfest:5",
        [185690] = "money:80000",
        [185923] = "money:144000",
        [185924] = "money:144000",
        [187048] = "money:152000",
        [187049] = "money:152000",
    }
end

if AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM) then
    VENDOR_PRICES_RAW.WRATH = {
        [39728] = "EmblemOfValor:25",
        [39757] = "EmblemOfValor:25",
        [40191] = "EmblemOfValor:25",
        [40207] = "EmblemOfValor:25",
        [40267] = "EmblemOfValor:25",
        [40268] = "EmblemOfValor:25",
        [40321] = "EmblemOfValor:25",
        [40322] = "EmblemOfValor:25",
        [40337] = "EmblemOfValor:25",
        [40342] = "EmblemOfValor:25",
        [40612] = "EmblemOfHeroism:80",
        [40615] = "EmblemOfHeroism:60",
        [40636] = "EmblemOfValor:75",
        [40639] = "EmblemOfValor:60",
        [40678] = "EmblemOfHeroism:25",
        [40679] = "EmblemOfHeroism:25",
        [40680] = "EmblemOfHeroism:25",
        [40681] = "EmblemOfHeroism:25",
        [40682] = "EmblemOfHeroism:40",
        [40683] = "EmblemOfHeroism:40",
        [40684] = "EmblemOfHeroism:40",
        [40685] = "EmblemOfHeroism:40",
        [40688] = "EmblemOfHeroism:40",
        [40689] = "EmblemOfHeroism:40",
        [40691] = "EmblemOfHeroism:40",
        [40692] = "EmblemOfHeroism:40",
        [40693] = "EmblemOfHeroism:40",
        [40694] = "EmblemOfHeroism:40",
        [40695] = "EmblemOfHeroism:40",
        [40696] = "EmblemOfHeroism:40",
        [40697] = "EmblemOfHeroism:40",
        [40698] = "EmblemOfHeroism:25",
        [40699] = "EmblemOfHeroism:25",
        [40700] = "EmblemOfHeroism:35",
        [40701] = "EmblemOfHeroism:35",
        [40702] = "EmblemOfHeroism:50",
        [40703] = "EmblemOfHeroism:50",
        [40704] = "EmblemOfHeroism:50",
        [40711] = "EmblemOfHeroism:15",
        [40712] = "EmblemOfHeroism:15",
        [40713] = "EmblemOfHeroism:15",
        [40716] = "EmblemOfHeroism:15",
        [40717] = "EmblemOfValor:25",
        [40718] = "EmblemOfValor:25",
        [40719] = "EmblemOfValor:25",
        [40720] = "EmblemOfValor:25",
        [40721] = "EmblemOfValor:25",
        [40722] = "EmblemOfValor:25",
        [40723] = "EmblemOfValor:25",
        [40724] = "EmblemOfValor:25",
        [40733] = "EmblemOfValor:60",
        [40734] = "EmblemOfValor:60",
        [40735] = "EmblemOfValor:60",
        [40736] = "EmblemOfValor:60",
        [40737] = "EmblemOfValor:60",
        [40738] = "EmblemOfValor:60",
        [40739] = "EmblemOfValor:60",
        [40740] = "EmblemOfValor:60",
        [40741] = "EmblemOfValor:60",
        [40742] = "EmblemOfValor:40",
        [40743] = "EmblemOfValor:40",
        [40745] = "EmblemOfValor:40",
        [40746] = "EmblemOfValor:40",
        [40747] = "EmblemOfValor:40",
        [40748] = "EmblemOfValor:40",
        [40749] = "EmblemOfValor:40",
        [40750] = "EmblemOfValor:40",
        [40751] = "EmblemOfValor:40",
        [41268] = "EmblemOfHeroism:30",
        [41269] = "EmblemOfHeroism:45",
        [41270] = "EmblemOfHeroism:45",
        [41271] = "EmblemOfHeroism:30",
        [41272] = "EmblemOfHeroism:45",
        [41273] = "EmblemOfValor:30",
        [41278] = "EmblemOfHeroism:30",
        [41279] = "EmblemOfValor:30",
        [41284] = "EmblemOfValor:30",
        [41290] = "EmblemOfHeroism:30",
        [41291] = "EmblemOfValor:30",
        [41296] = "EmblemOfValor:45",
        [41301] = "EmblemOfHeroism:45",
        [41302] = "EmblemOfValor:45",
        [41308] = "EmblemOfValor:45",
        [41313] = "EmblemOfHeroism:45",
        [41314] = "EmblemOfValor:45",
        [41319] = "EmblemOfValor:45",
        [41324] = "EmblemOfHeroism:45",
        [41325] = "EmblemOfValor:45",
        [41643] = "EmblemOfHeroism:30",
        [41644] = "EmblemOfHeroism:45",
        [41645] = "EmblemOfHeroism:45",
        [41646] = "EmblemOfHeroism:30",
        [41647] = "EmblemOfHeroism:45",
        [41648] = "EmblemOfValor:45",
        [41653] = "EmblemOfValor:45",
        [41658] = "EmblemOfHeroism:45",
        [41659] = "EmblemOfValor:45",
        [41664] = "EmblemOfHeroism:45",
        [41665] = "EmblemOfValor:45",
        [41670] = "EmblemOfValor:45",
        [41675] = "EmblemOfHeroism:45",
        [41676] = "EmblemOfValor:45",
        [41681] = "EmblemOfValor:30",
        [41712] = "EmblemOfHeroism:30",
        [41713] = "EmblemOfValor:30",
        [41765] = "EmblemOfValor:30",
        [41770] = "EmblemOfHeroism:30",
        [41771] = "EmblemOfValor:30",
        [42943] = "EmblemOfHeroism:65",
        [42944] = "EmblemOfHeroism:40",
        [42945] = "EmblemOfHeroism:40",
        [42946] = "EmblemOfHeroism:65",
        [42947] = "EmblemOfHeroism:65",
        [42948] = "EmblemOfHeroism:50",
        [42949] = "EmblemOfHeroism:40",
        [42950] = "EmblemOfHeroism:40",
        [42951] = "EmblemOfHeroism:40",
        [42952] = "EmblemOfHeroism:40",
        [42984] = "EmblemOfHeroism:40",
        [42985] = "EmblemOfHeroism:40",
        [42991] = "EmblemOfHeroism:50",
        [42992] = "EmblemOfHeroism:50",
        [43007] = "epicurean:1",
        [43017] = "epicurean:5",
        [43018] = "epicurean:3",
        [43019] = "epicurean:3",
        [43020] = "epicurean:3",
        [43021] = "epicurean:3",
        [43022] = "epicurean:3",
        [43023] = "epicurean:3",
        [43024] = "epicurean:3",
        [43025] = "epicurean:3",
        [43026] = "epicurean:3",
        [43027] = "epicurean:3",
        [43028] = "epicurean:3",
        [43029] = "epicurean:3",
        [43030] = "epicurean:3",
        [43031] = "epicurean:3",
        [43032] = "epicurean:3",
        [43033] = "epicurean:3",
        [43034] = "epicurean:3",
        [43035] = "epicurean:3",
        [43036] = "epicurean:3",
        [43037] = "epicurean:3",
        [43102] = "EmblemOfHeroism:10",
        [43505] = "epicurean:3",
        [43506] = "epicurean:3",
        [44231] = "EmblemOfHeroism:200",
        [44954] = "epicurean:3",
        [46349] = "epicurean:100",
        [47661] = "EmblemOfTriumph:25",
        [47662] = "EmblemOfTriumph:25",
        [47664] = "EmblemOfTriumph:25",
        [47665] = "EmblemOfTriumph:25",
        [47666] = "EmblemOfTriumph:25",
        [47667] = "EmblemOfTriumph:25",
        [47668] = "EmblemOfTriumph:25",
        [47670] = "EmblemOfTriumph:25",
        [47671] = "EmblemOfTriumph:25",
        [47672] = "EmblemOfTriumph:25",
        [47673] = "EmblemOfTriumph:25",
        [47734] = "EmblemOfTriumph:50",
        [47735] = "EmblemOfTriumph:50",
        [48677] = "EmblemOfHeroism:40",
        [48683] = "EmblemOfHeroism:40",
        [48685] = "EmblemOfHeroism:40",
        [48687] = "EmblemOfHeroism:40",
        [48689] = "EmblemOfHeroism:40",
        [48691] = "EmblemOfHeroism:40",
        [48716] = "EmblemOfHeroism:40",
        [48718] = "EmblemOfHeroism:65",
        [48722] = "EmblemOfTriumph:50",
        [48724] = "EmblemOfTriumph:50",
        [50355] = "EmblemOfFrost:60",
        [50356] = "EmblemOfFrost:60",
        [50357] = "EmblemOfFrost:60",
        [50358] = "EmblemOfFrost:60",
        [50454] = "EmblemOfFrost:30",
        [50455] = "EmblemOfFrost:30",
        [50456] = "EmblemOfFrost:30",
        [50457] = "EmblemOfFrost:30",
        [50458] = "EmblemOfFrost:30",
        [50459] = "EmblemOfFrost:30",
        [50460] = "EmblemOfFrost:30",
        [50461] = "EmblemOfFrost:30",
        [50462] = "EmblemOfFrost:30",
        [50463] = "EmblemOfFrost:30",
        [50464] = "EmblemOfFrost:30",
        [50466] = "EmblemOfFrost:50",
        [50467] = "EmblemOfFrost:50",
        [50468] = "EmblemOfFrost:50",
        [50469] = "EmblemOfFrost:50",
        [50470] = "EmblemOfFrost:50",
        [54637] = "cpvpWarsong:1",
        [40492] = "NecroticRune:40",
        [40593] = "NecroticRune:30",
        [40601] = "NecroticRune:8",
        [23122] = "NecroticRune:8",
        [23123] = "NecroticRune:8",
        [22999] = "NecroticRune:8",
        [43530] = "NecroticRune:20",
        [43531] = "NecroticRune:20",
        [43074] = "NecroticRune:15",
        [43073] = "NecroticRune:15",
        [43077] = "NecroticRune:15",
        [43078] = "NecroticRune:15",
        [43081] = "NecroticRune:15",
        [43082] = "NecroticRune:15",
        [43070] = "NecroticRune:15",
        [43068] = "NecroticRune:15",
    }
end

local function GetItemPriceString(itemID)
    return AtlasLoot.dbGlobal.VendorPrice[itemID] or VENDOR_PRICES[itemID]
end

function VendorPrice.ItemHasVendorPrice(itemID)
    return GetItemPriceString(itemID) ~= nil
end

function VendorPrice.GetVendorPriceForItem(itemID)
    return GetItemPriceString(itemID)
end

function VendorPrice.GetPriceInfoList()
    return PRICE_INFO_LIST
end

--################################
-- Vendor scan
--################################
local VendorLockList = {}
local SourcesAddon
local UnitGUID, GetMerchantNumItems, GetMerchantItemID, GetMerchantItemCostInfo, GetMerchantItemCostItem, GetItemInfoInstant =
      UnitGUID, GetMerchantNumItems, GetMerchantItemID, GetMerchantItemCostInfo, GetMerchantItemCostItem, GetItemInfoInstant

local function GetNpcIDFromGuid(guid)
	local npcID = select(6,strsplit("-",guid))
	if npcID then
		return tonumber(npcID)
	end
end

function VendorPrice.ScanShownVendor()
    local targetGUID = UnitGUID("target")
    if not targetGUID then return end
    local npcID = GetNpcIDFromGuid(targetGUID)
    if not npcID or VendorLockList[npcID] then return end
    if not SourcesAddon then SourcesAddon = AtlasLoot.Addons:GetAddon("Sources") end

    for itemNum = 1, GetMerchantNumItems() do
        local vItemID = GetMerchantItemID(itemNum)
        local itemCost = ""
        for costNum = 1, GetMerchantItemCostInfo(itemNum) do
            local itemTexture, itemValue, itemLink, currencyName = GetMerchantItemCostItem(itemNum, costNum)
            if itemLink then
                local costItemID = GetItemInfoInstant(itemLink)
                local formatString
                if VENDOR_PRICE_FORMAT[costItemID] then
                    formatString = VENDOR_PRICE_FORMAT[costItemID]
                elseif VENDOR_PRICE_FORMAT[itemTexture] then
                    formatString = VENDOR_PRICE_FORMAT[itemTexture]
                else
                    break -- end here as there is a unknown currency
                end
                if formatString then
                    if itemCost == "" then
                        itemCost = format(formatString, itemValue or 0)
                    else
                        itemCost = itemCost..":"..format(formatString, itemValue or 0)
                    end
                end
            end
        end

        if itemCost ~= "" then
            AtlasLoot.dbGlobal.VendorPrice[vItemID] = itemCost
        end
        if SourcesAddon then
            SourcesAddon:ItemSourcesUpdated(vItemID)
        end
    end

    VendorLockList[npcID] = true
end

VendorPrice.EventFrame = CreateFrame("FRAME")
local function EventFrame_OnEvent(frame, event, arg1, arg2)
	if event == "MERCHANT_SHOW" then
		VendorPrice.ScanShownVendor()
	end
end
VendorPrice.EventFrame:SetScript("OnEvent", EventFrame_OnEvent)
VendorPrice.EventFrame:RegisterEvent("MERCHANT_SHOW")

