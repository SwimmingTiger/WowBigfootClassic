--[[
Copyright (c) 2009-2020, Hendrik "Nevcairiel" Leppkes < h.leppkes@gmail.com >
All rights reserved.
]]

local WoWClassic = (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE)
if not WoWClassic then return end

-- data
-- [MapArtID] = {
--   key: w + h + x + y, 12-bits each for 48 total, value = string list of file data IDs
-- }
MapsterFogClearData =
{
	[1194] = {
		[70376129953825] = "271427",
		[87968986669532] = "2212659",
		[87973684789632] = "271426",
		[104465688019230] = "271440",
		[104467029090364] = "271439",
		[109967273402795] = "271437",
		[115459461832782] = "271428",
		[118211931300160] = "271443",
		[120961717633194] = "271421",
		[126459274698941] = "271422",
		[244652076597248] = "271435,271442",
	},
	[1200] = {
		[70376801116420] = "272185",
		[70379149156594] = "272178",
		[70382503977267] = "272176",
		[93467082047857] = "272180",
		[101713417887744] = "272172",
		[112708535017472] = "272179",
		[112715380998160] = "272169",
		[115460802601174] = "272181",
		[118213609619536] = "272177",
		[123710833066222] = "272186",
		[140750243324260] = "272170",
		[140750913134895] = "272173",
		[153947736055867] = "272187,272171",
		[258401542193577] = "272168,272165",
	},
	[1202] = {
		[52233517965559] = "270573",
		[54986658971700] = "270569",
		[63229304725798] = "852702",
		[65978084188160] = "270553",
		[65979089420403] = "270560",
		[68727198285887] = "270584",
		[68727869898941] = "270585",
		[68730553319722] = "852696",
		[70375458439168] = "852705",
		[70375794040895] = "270554",
		[70377336619138] = "852699",
		[70377336906265] = "852704",
		[70377337643487] = "852694",
		[76974407958647] = "270574",
		[79722984612190] = "852697",
		[82471429464371] = "852701",
		[85219872006697] = "852703",
		[85220743832014] = "852695",
		[85220745027795] = "270565",
		[85222556557430] = "270559",
		[93466545160192] = "270564",
		[96219685560497] = "852700",
		[109960896159773] = "270572",
		[109963580702954] = "852693",
		[115458790154642] = "852698",
	},
	[1205] = {
		[87972676116958] = "768731",
		[90722932310487] = "768752",
		[104465015742836] = "768732",
		[107221714329980] = "768721,768722",
		[109964587876631] = "768730",
		[120965071143043] = "768738,769205",
		[129206041821261] = "768753",
		[140204847513797] = "768739",
		[140209211162931] = "768744,768745",
		[153947736752290] = "768723,769200",
		[156695844257792] = "768728,768729",
		[164946877038854] = "769201,769202,769203,769204",
		[181437202792851] = "768734,768735,768736,768737",
		[192439370268925] = "768717,768718,768719,768720",
		[203429788295273] = "768748,768749,768750,768751",
	},
	[1206] = {
		[87976369832048] = "270360",
		[93468893667621] = "2212546",
		[96222369956026] = "270352",
		[98970143228069] = "270350",
		[104467698630710] = "270347",
		[104469711478922] = "2212539",
		[109965929636252] = "270348",
		[112716724428920] = "270336",
		[115461138399542] = "270346",
		[118211597427021] = "270353",
		[118213274108266] = "270342",
		[126456927772948] = "270343",
		[126459944894554] = "270351",
		[131956831256863] = "270358",
		[134706617974929] = "270349",
		[140751918162344] = "270361",
	},
	[1207] = {
		[107215808143508] = "270543",
		[109964252651640] = "270532",
		[120961047519280] = "270530",
		[126459275092224] = "2212608",
		[131958508093588] = "2212593",
		[134703934906375] = "2212606",
		[134703935799505] = "2212592",
		[140201489998134] = "270529",
		[140202496590252] = "270520",
		[140206527127893] = "270540,270527",
		[145703412900229] = "270522,270550,270528,270536",
		[148452525990087] = "270525,270521,2212603,2212605",
		[156696514298240] = "2212599,2212601",
		[203440190677102] = "270534,270551,270546,270535",
	},
	[1209] = {
		[93468222464123] = "391431",
		[93471914000393] = "391433",
		[101715229982853] = "391425",
		[101717580832798] = "391432",
		[107214466261007] = "391435",
		[123706470736012] = "391430",
		[134703263588547] = "391434",
		[145700058341635] = "391437,391436",
		[211136433258674] = "391429,391428,391427,391426",
	},
	[1210] = {
		[70379351777579] = "273015",
		[82471965901127] = "273016",
		[95116351422753] = "273000",
		[95672279638161] = "273020",
		[96223848964200] = "272996",
		[102263174553877] = "2213434",
		[110520250753163] = "273009,273002",
		[116011166417021] = "2213425",
		[118759273447750] = "273006",
		[126457600229738] = "2213418",
		[130306495389901] = "272999",
		[133604020412765] = "273003",
		[134703933579592] = "273001",
		[140747959296250] = "273017",
		[140751583961227] = "273019",
		[173188855751017] = "2213428,2213430",
	},
	[1211] = {
		[76974205755838] = "2213067",
		[87972342579461] = "272598",
		[90722127560956] = "272616",
		[96218343686209] = "2213080",
		[98964639080576] = "2213065",
		[98968465383568] = "2213082",
		[101715900874789] = "272610",
		[115459461218472] = "272620",
		[115463152427455] = "272609",
		[120957019455847] = "272613",
		[131953478951329] = "272599",
		[131957505507590] = "272614",
		[137453386735690] = "272600",
		[140748229582848] = "2213063",
		[140752256065549] = "2213084",
	},
	[1212] = {
		[87969321287991] = "273113",
		[87974356631750] = "273121",
		[93469566239132] = "273107",
		[93471242740035] = "273102",
		[98969808077050] = "273094",
		[112722763694166] = "273122,273103",
		[120956348506377] = "2212523",
		[120958361780388] = "273114",
		[123707474387237] = "273120",
		[156695844127075] = "2212522,2212521",
		[164940571501006] = "273108,273101",
		[186936306589712] = "273095,273111,273100,273090",
		[203427774660951] = "273119,273092,273112,273093",
	},
	[1213] = {
		[90720451109231] = "271544",
		[96223714967851] = "271533",
		[98966788767985] = "271542",
		[101714893308381] = "271512",
		[104467362603106] = "271522",
		[104467367035008] = "271520",
		[107220843725091] = "271543,271530",
		[109964921373032] = "271551",
		[112711017193873] = "271548",
		[112711019839518] = "271554",
		[112716722413913] = "2212700",
		[115460735934953] = "271514",
		[115462815998213] = "271536",
		[120970438303975] = "2212705,2212706",
		[123709492445350] = "271537",
		[126453906980900] = "271535",
		[126459611398343] = "271523",
		[131954485305453] = "271521",
		[131954818695177] = "271529",
		[134701588783575] = "271553",
		[137450701922767] = "271532",
		[197930213777491] = "271518,271527,2212703,2212704",
	},
	[1214] = {
		[68726188515810] = "271904",
		[90723132498195] = "2212736",
		[112710347112602] = "271897",
		[118213610545388] = "2212742",
		[120967086972928] = "271894,2212744",
		[126465316323667] = "2212737,2212738",
		[129210739081417] = "271905,2212743",
		[131959855489318] = "271885,271877",
		[156690810536304] = "2212746,2212747",
		[158344773910720] = "271876,271881",
		[167693979795611] = "271883,271892,2212739,2212740",
		[211130732224587] = "271872,271898,271882,271891",
	},
	[1215] = {
		[79729358258325] = "271927",
		[87970665201896] = "271933",
		[93469899481390] = "271934",
		[93479297786159] = "271938,271916",
		[98967458349316] = "271929",
		[101717913739449] = "271928",
		[107214800814467] = "271937",
		[109962238796141] = "271922",
		[112713031139492] = "271910",
		[123708481298738] = "770218",
		[129211746427213] = "271912,271920",
		[140201489965301] = "271917",
		[151201307926547] = "271908,271935,271936,271909",
		[153945389883631] = "271915,271921",
	},
	[1216] = {
		[63229638181113] = "2212640",
		[68727867121951] = "271398",
		[70376803729687] = "2212654",
		[70377338806552] = "271389",
		[70379821252829] = "2212651",
		[70379823358125] = "2212653",
		[70380826075303] = "271392",
		[70381497704611] = "271418",
		[82471964434817] = "271406",
		[85220745363778] = "271401",
		[85223565345041] = "271409",
		[90720787235107] = "271408",
		[98964638679336] = "2212641",
		[98967120822456] = "2212644",
		[109963580490039] = "271400",
		[109964587712806] = "271417",
		[131953811743123] = "2212639",
		[173186506399907] = "271410,271396",
	},
	[1220] = {
		[151198620033390] = "254503,254504",
		[167690291233068] = "2201968,2201949",
		[167690962739607] = "254527,254528",
		[197930885505412] = "2201972,2201970,2201969,2201971",
		[222679962132510] = "254509,254510,254511,254512",
		[233668033331370] = "254529,254530,254531,254532",
		[252912172580872] = "254505,254506,254507,254508",
	},
	[1224] = {
		[120961384341672] = "270927",
		[123709822369901] = "270938",
		[134707960987762] = "270912,270909",
		[140756280254565] = "270919,270911",
		[148453199978595] = "270922,270934,270923,270937",
		[148454878322967] = "270920,270914,270908,270929",
		[153955457450030] = "270944,270910,270935,270945",
		[161646334476599] = "270906,270918,270936,270942",
		[175939982926109] = "270933,270943,270921,270928",
		[228169802514690] = "270941,270925,270926,270917",
	},
	[1228] = {
		[123709825532236] = "271560",
		[131956161331470] = "271567",
		[140204514271524] = "271573",
		[140751586984266] = "271578",
		[140753396638127] = "271582",
		[140753596432812] = "271576",
		[140754203189667] = "271559",
		[140754671345811] = "271572",
		[140760373494087] = "2212708,2212709",
		[168240921117107] = "271557,271583",
		[170441486983358] = "271584,271565",
		[266658748825600] = "2212713,2212714,2212715,2212716",
	},
	[1233] = {
		[148452192633131] = "271092,271085,271086,271089",
		[164943188042065] = "271095,271079",
		[208931706052684] = "271075,271076,271080,271081",
	},
	[1235] = {
		[87983076302980] = "271453,271454",
		[107212115329326] = "2212669",
		[109962912178296] = "271466",
		[120961048658273] = "2212676",
		[120969100198005] = "271470,271477",
		[129209396674942] = "271449",
		[137454392926577] = "271455",
		[140206860558684] = "271448,271456",
		[151199626486102] = "271444,271483",
		[173191877025954] = "271471,271461,271450,271451",
		[192434668216469] = "271473,271463,271467,271464",
		[197940281163855] = "2212678,2212679,2212680,2212681",
		[500291884228639] = "271481,271460,271474,271468",
	},
	[1236] = {
		[107219161817458] = "252899",
		[126463970877452] = "252882,252883",
		[129210737532939] = "252884,2212852",
		[140206860329308] = "252886,252887",
		[140752925171915] = "252898",
		[159440932855819] = "2212855,2212856",
		[162201992601910] = "252862,252863,2212828,2212829",
		[173188856397872] = "252880,252881",
		[175949377962071] = "252894,252895,252896,252897",
		[189682939609409] = "252866,252867",
		[203429452726471] = "252890,252891,252892,252893",
	},
	[1237] = {
		[129210738925697] = "272334,2212936",
		[137455736045729] = "272372",
		[140207869296855] = "2212977,2212978",
		[151200030957568] = "272357,272342",
		[175935958180160] = "272347,272371",
		[186930063630533] = "272351,272340",
		[200677314732104] = "272362,272356",
		[200684360171804] = "272364,272348,272358,272359",
		[236414463074637] = "272344,272354,272350,272339",
		[255653570183529] = "272369,272363",
		[294137816457456] = "272335,272343,2212940,2212942,2212943,2212945",
	},
	[1238] = {
		[49483393933404] = "2213143",
		[49485742498151] = "2213164",
		[52233180110936] = "2213154",
		[52233180528975] = "2213170",
		[57731744981123] = "2213161",
		[57732752236608] = "2213191",
		[60480188088452] = "2213150",
		[60480524009773] = "2213171",
		[60482537808001] = "2213145",
		[63229637394474] = "2213197",
		[65978753556756] = "2213148",
		[68727532372461] = "2213152",
		[68727867638128] = "2213159",
		[68728873582595] = "2213173",
		[70377135497275] = "2213158",
		[70377135767783] = "2213194",
		[70380491767902] = "2213162",
		[76973198123034] = "2213165",
		[79723184611761] = "2213147",
		[85222220660736] = "2213156",
		[90721454932252] = "2213146",
		[90722461852070] = "2213192",
		[93464530485248] = "2213168",
		[93466880196820] = "2213174",
		[104465349935194] = "2213188",
		[109963579842749] = "2213187",
		[134704942309384] = "2213196",
	},
	[1239] = {
		[118222000652408] = "272739,272746",
		[129206374981777] = "272736",
		[131957837005062] = "2213206",
		[134710642606220] = "272759,272750",
		[140782323187712] = "272756,272737,272769",
		[151198956003564] = "272747,272763",
		[164945203732698] = "272772,272760,2213215,2213216",
		[173188854300782] = "272768,272770",
		[189682537529722] = "272740,272773",
		[197933234577645] = "272742,272751,272752,272764",
		[200681344303104] = "2213200,2213202,2213203,2213204",
	},
	[1240] = {
		[90723135062016] = "273143",
		[107218493456625] = "273137",
		[109963579621751] = "273142",
		[109967273197820] = "273125",
		[115463152492555] = "273145",
		[118211930906653] = "2212528",
		[120959703425355] = "273130",
		[123708818129044] = "273126",
		[123709154746473] = "273146",
		[123712239796326] = "273149",
		[140749235184034] = "273124",
		[153944380252627] = "273141,2212527",
		[158345449267577] = "273131,273134",
		[167689617768708] = "273129,273133",
	},
	[1243] = {
		[96215857471802] = "273156",
		[101720935432317] = "2212531",
		[104464347201712] = "273181",
		[107214800871629] = "273155",
		[109963580776563] = "273173",
		[109967270846505] = "2212533",
		[112712024727573] = "273164",
		[112716387836168] = "273177",
		[123707476107482] = "273159",
		[123707809538190] = "273171",
		[126456591729011] = "273174",
		[131953140015349] = "273163",
		[140754269724787] = "2212535",
		[164942851047506] = "273178,273167",
		[192438699057382] = "2213613,2213614,2212532,2212534",
	},
	[1244] = {
		[70375459111460] = "2213328",
		[70381497606457] = "272807",
		[87975026213145] = "272826",
		[93474596716671] = "272830",
		[98973229457501] = "272822",
		[101713418518971] = "272814",
		[104462198358339] = "2213323",
		[109964589146404] = "272815",
		[123710161641625] = "272811",
		[140749907067260] = "272810",
		[173190262071543] = "272806,272812",
	},
	[1247] = {
		[82477803094178] = "769206",
		[93471578423381] = "769211",
		[96217873326590] = "271044",
		[96219550228965] = "769210",
		[98969135718581] = "769207",
		[104467364610354] = "271045",
		[107216816291840] = "271043",
		[109962573783452] = "769209",
		[126456590950494] = "769208",
	},
	[1248] = {
		[70381831479433] = "270380",
		[80277777612951] = "270387",
		[85222219612533] = "270398",
		[90721454891332] = "2212540",
		[98972492431598] = "270402",
		[109961906716983] = "270390",
		[109964923306202] = "2212541",
		[112712359215355] = "270386",
		[115461139849357] = "270400",
		[118217969868838] = "2212542,2212543",
		[120959366136067] = "2212548",
		[123712175776002] = "270401",
		[129206378062250] = "270375",
		[134706616229916] = "270376",
		[134707293004120] = "270405",
		[140200820433054] = "270389",
		[151198957863259] = "2212544,2212545",
		[156692827783393] = "270388,2212547",
	},
	[1249] = {
		[104466355576987] = "272968",
		[112713030197379] = "272962",
		[115460802191430] = "272963",
		[115461474525448] = "272954",
		[115461810348224] = "2213363",
		[131956163313914] = "2213395",
		[137455061065928] = "2213369",
		[167696326983680] = "2213348,2213349,2213351,2213352",
		[175946360176940] = "2213371,2213372,2213374,2213375",
	},
	[1250] = {
		[68725253530182] = "272650",
		[68727869235633] = "2213093",
		[79721778348593] = "272628",
		[82473441599808] = "272646",
		[104460120080955] = "2213087",
		[109965594378385] = "272624",
		[123703116661251] = "2213088",
		[126467662561514] = "272633,272647",
		[148447829090304] = "272632,272641",
		[158353501790490] = "272648,272634,272635,272623",
		[175940319912133] = "272630,272649,272642,272636",
	},
	[1251] = {
		[54982294249478] = "2212638",
		[93469230325941] = "2212635",
		[104468372250726] = "271111",
		[107218626453930] = "271122",
		[109967944531968] = "271114",
		[112709676163072] = "271126",
		[112713033728444] = "271105",
		[112716721610813] = "2212632",
		[112719072706925] = "2212636,2212637",
		[120961047978199] = "2212634",
		[126459273601413] = "271125",
		[134709302165719] = "271106,271129",
		[151199629205748] = "271127,2212633",
		[156696853749793] = "271104,271124",
		[156699200708988] = "271108,271112,271113,271109",
	},
	[1252] = {
		[60480525541446] = "2212732",
		[60484551950722] = "2212728",
		[63229640098121] = "2212726",
		[65983788998823] = "2212729",
		[76976892559501] = "271696",
		[79736071160064] = "271700,271682",
		[82471764410368] = "2212721",
		[85222894215401] = "271675",
		[98968127799530] = "2212734",
		[104464009011200] = "2212733",
		[104470386278720] = "271699",
		[118217164456311] = "2212730,2212731",
		[123707143872710] = "271680",
		[126456927142089] = "271687",
		[131956164346154] = "2212735",
		[156696851243083] = "271705,271686",
	},
	[1253] = {
		[109964254412821] = "271494",
		[126457598886112] = "271500",
		[137460096221184] = "271507,271504",
		[140204511863097] = "2212689",
		[153949749166080] = "2212685,2212686,2212687,2212688",
		[156696516092285] = "271503,271509",
		[219919440273597] = "2212683,2212684",
	},
	[1254] = {
		[60482539774099] = "2213315",
		[60485222998250] = "272800",
		[65979761729640] = "2213275",
		[82474111885746] = "2213311",
		[85222222078208] = "272789",
		[85222222331979] = "2213281",
		[87970999787866] = "272798",
		[87973686059228] = "2213273",
		[90721793056936] = "2213313",
		[96218343841883] = "272774",
		[98969470337223] = "272792",
		[101721604448542] = "272781",
		[107214130208868] = "272776",
		[107216479215975] = "272784",
		[112709675295009] = "272782",
		[112710481584639] = "272801",
		[115460467048448] = "272788",
		[118209248125221] = "272795",
		[118209582555330] = "272799",
		[120960375595380] = "272805",
	},
	[1259] = {
		[65981106241643] = "270434",
		[79729024876639] = "2212573",
		[87975026393282] = "270412",
		[104467031990425] = "2212567",
		[109961229738315] = "2212555",
		[118209244725477] = "2212574",
		[120963393380721] = "2212554",
		[123707138007462] = "2212564",
		[129202015420460] = "2212560",
		[129210737705066] = "2212571,2212572",
		[131949788463603] = "270410",
		[131951801294967] = "2212568",
		[134702594818088] = "270432",
		[145704083112157] = "270414,2212561,2212562,2212563",
		[148454206333129] = "2212550,2212551,2212552,2212553",
		[173186505572781] = "270409,2212559",
		[203424418275681] = "2212565,2212566",
		[217162139664924] = "2212569,2212570",
		[313372225421312] = "2212556,2212557,2212558",
	},
	[1260] = {
		[79725267386877] = "271657",
		[87970665496666] = "271653",
		[90720113885649] = "271663",
		[96216330469909] = "271658",
		[101715566305709] = "271659",
		[107213794918429] = "271652",
		[118211931832374] = "271673",
		[129202349441287] = "271666",
		[129203020571005] = "271664",
		[129206040551547] = "271665",
		[131951130075136] = "271660",
		[134698766557515] = "271669",
	},
	[1261] = {
		[156699537752131] = "273051,2213483,2213484,2213486",
		[162196087496882] = "273042,273065,273050,273036",
		[170448130539760] = "273072,273039,273037,273063",
		[173196234924183] = "273043,273075,273069,273061",
		[189684883112304] = "273046,273053,273071,273047",
		[189684884824444] = "273059,273066,273073,273054",
		[313378599075846] = "273052,273062,273057,273058,2213490,2213491",
	},
	[1263] = {
		[305148704227417] = "252844,252845,252846,252847,2212870,2212872",
	},
	[1264] = {
		[158346855219613] = "272564,272553",
		[175939043131589] = "272573,272545",
		[175941255757848] = "272581,272562,2213052,2213053",
		[211132006432833] = "272580,272544,2213048,2213049",
		[211140593066128] = "272559,272543,272574,272575",
		[281496453718028] = "272565,272566,272577,272546",
		[281500748521757] = "272567,272547,272555,272548",
	},
	[1266] = {
		[68730554704114] = "273206",
		[79722986676382] = "273200",
		[90719109390676] = "273199",
		[90723135234155] = "273191",
		[96219687116827] = "273203",
		[101715566198921] = "273207",
		[101716909203714] = "273185",
		[109961904480632] = "273198",
		[118209918410950] = "273192",
		[126451892134131] = "273187",
		[131950792392876] = "273202",
		[137451036082183] = "273184",
		[140201493520825] = "2213650",
	},
	[1273] = {
		[129212081103223] = "270314,270315",
		[148450178727949] = "270331,270325",
		[164946879570092] = "270320,270321,270322,270323",
	},
}
