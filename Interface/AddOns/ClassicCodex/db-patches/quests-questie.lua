-- A script to merge Questie questDB to ClassicCodex
-- ClassicCodex version: v1.4.0, quest num: 6515
-- Questie version: 6.3.11, quest num: 6533
if select(4, GetAddOnInfo('MergeQuestieToCodexDB')) then return end
local D = CodexDB.quests.data
D[2].start.U={12676} --old: nil
D[2].obj={}
D[2].obj.I={16305} --old: nil
D[5].pre=nil --old: 163
D[8].obj={}
D[8].obj.I={7628} --old: nil
D[23].start.U={12678} --old: nil
D[23].obj={}
D[23].obj.I={16303} --old: nil
D[24].start.U={12677} --old: nil
D[24].obj={}
D[24].obj.I={16304} --old: nil
D[26].lvl=nil --old: -1
D[27].lvl=nil --old: -1
D[28].lvl=nil --old: -1
D[29].lvl=nil --old: -1
D[30].lvl=nil --old: -1
D[31].obj={}
D[31].obj.I={15885} --old: nil
D[31].lvl=nil --old: -1
D[32].obj={}
D[32].obj.I={8594} --old: nil
D[33].pre=nil --old: 5261
D[36].obj={}
D[36].obj.I={2832} --old: nil
D[46].pre=39 --old: nil
D[54].obj={}
D[54].obj.I={745} --old: nil
D[55].obj.I={7297} --old: nil
D[55].race=1101 --old: nil
D[59].obj={}
D[59].obj.I={748} --old: nil
D[61].obj={}
D[61].obj.I={957} --old: nil
D[63].obj.I={7811,7812} --old: {7812}
D[63].lvl=nil --old: -1
D[68].obj={}
D[68].obj.I={889} --old: nil
D[71].obj={}
D[71].obj.I={735} --old: nil
D[74].obj={}
D[74].obj.I={916} --old: nil
D[78].obj={}
D[78].obj.I={921} --old: nil
D[79].obj={}
D[79].obj.I={938} --old: nil
D[80].obj={}
D[80].obj.I={939} --old: nil
D[81].obj={}
D[81].obj.I={8685} --old: nil
D[84].obj={}
D[84].obj.I={962} --old: nil
D[90].skill={id=185,min=50} --old: id=nil
D[94].obj={}
D[94].obj.I={1083} --old: nil
D[96].obj={}
D[96].obj.I={7813} --old: nil
D[96].excl={972} --old: nil
D[96].lvl=nil --old: -1
D[99].race=690 --old: nil
D[100].lvl=nil --old: -1
D[106].obj={}
D[106].obj.I={1208} --old: nil
D[107].obj={}
D[107].obj.I={1252} --old: nil
D[109].start.U={233,237,240,261,294,963} --old: {233,237,240,261,963}
D[113].obj={}
D[113].obj.I={8594} --old: nil
D[114].obj={}
D[114].obj.I={1257} --old: nil
D[118].obj={}
D[118].obj.I={1283} --old: nil
D[118].race=1101 --old: nil
D[119].obj={}
D[119].obj.I={1284} --old: nil
D[119].race=1101 --old: nil
D[120].obj={}
D[120].obj.I={1293} --old: nil
D[121].obj={}
D[121].obj.I={1294} --old: nil
D[122].race=1101 --old: nil
D[123].start.U={100} --old: nil
D[123].obj={}
D[123].obj.I={1307,2223} --old: nil
D[124].race=1101 --old: nil
D[126].race=1101 --old: nil
D[129].obj={}
D[129].obj.I={5534} --old: nil
D[131].obj={}
D[131].obj.I={1325} --old: nil
D[132].obj={}
D[132].obj.I={1327} --old: nil
D[135].obj={}
D[135].obj.I={1327} --old: nil
D[136].obj={}
D[136].obj.I={1357} --old: nil
D[138].obj={}
D[138].obj.I={1358} --old: nil
D[139].obj={}
D[139].obj.I={1361} --old: nil
D[140].obj={}
D[140].obj.I={1362} --old: nil
D[141].obj={}
D[141].obj.I={1353} --old: nil
D[143].obj={}
D[143].obj.I={1407} --old: nil
D[144].obj={}
D[144].obj.I={1408} --old: nil
D[145].obj={}
D[145].obj.I={1409} --old: nil
D[146].obj={}
D[146].obj.I={1410} --old: nil
D[148].pre=nil --old: 165
D[149].obj={}
D[149].obj.I={1453} --old: nil
D[154].obj={}
D[154].obj.I={1518} --old: nil
D[157].obj={}
D[157].obj.I={1596} --old: nil
D[159].obj={}
D[159].obj.I={1451} --old: nil
D[160].obj={}
D[160].obj.I={1637} --old: nil
D[161].obj={}
D[161].obj.I={2563} --old: nil
D[162].obj={}
D[162].obj.I={8594} --old: nil
D[163].excl={5} --old: nil
D[164].obj={}
D[164].obj.I={1922} --old: nil
D[164].excl={95} --old: nil
D[165].excl={148} --old: nil
D[171].preg={558,4822} --old: nil
D[171].hide=true --old: nil
D[172].obj={}
D[172].obj.I={18597} --old: nil
D[172].hide=true --old: nil
D[178].obj={}
D[178].obj.I={1956,1962} --old: nil
D[184].obj={}
D[184].obj.I={1971,1972} --old: nil
D[198].obj={}
D[198].obj.I={2252} --old: nil
D[199].obj={}
D[199].obj.I={2563} --old: nil
D[206].preg={202,205} --old: nil
D[207].preg={203,204} --old: nil
D[208].preg={188,193,197} --old: nil
D[210].obj={}
D[210].obj.I={4085} --old: nil
D[220].obj={}
D[220].obj.I={7810} --old: nil
D[220].lvl=nil --old: -1
D[223].obj={}
D[223].obj.I={2113} --old: nil
D[223].race=1101 --old: nil
D[228].race=1101 --old: nil
D[230].obj={}
D[230].obj.I={2161} --old: nil
D[231].obj={}
D[231].obj.I={2162} --old: nil
D[232].obj={}
D[232].obj.I={8525} --old: nil
D[233].obj={}
D[233].obj.I={2187} --old: nil
D[234].obj={}
D[234].obj.I={2188} --old: nil
D[235].excl={742,6382,6383} --old: nil
D[238].obj={}
D[238].obj.I={8523} --old: nil
D[240].obj={}
D[240].obj.I={2250} --old: nil
D[243].obj={}
D[243].obj.I={8523} --old: nil
D[247].preg={2,23,24} --old: nil
D[248].obj={}
D[248].obj.I={1083} --old: nil
D[251].obj={}
D[251].obj.I={1637} --old: nil
D[252].obj={}
D[252].obj.I={1656} --old: nil
D[254].pre=252 --old: -253
D[254].excl={253} --old: nil
D[262].obj={}
D[262].obj.I={2161} --old: nil
D[264].obj={}
D[264].obj.I={6145} --old: nil
D[265].obj={}
D[265].obj.I={2161} --old: nil
D[266].obj={}
D[266].obj.I={2161} --old: nil
D[268].obj={}
D[268].obj.I={2560} --old: nil
D[269].obj={}
D[269].obj.I={2560} --old: nil
D[272].lvl=nil --old: -1
D[274].obj={}
D[274].obj.I={2609} --old: nil
D[280].obj={}
D[280].obj.I={2610} --old: nil
D[282].obj={}
D[282].obj.I={2619} --old: nil
D[282].race=1101 --old: nil
D[286].obj={}
D[286].obj.I={2625} --old: nil
D[291].obj={}
D[291].obj.I={2628} --old: nil
D[292].obj={}
D[292].obj.I={2944} --old: nil
D[293].obj={}
D[293].obj.I={2944} --old: nil
D[298].obj={}
D[298].obj.I={2637} --old: nil
D[301].obj={}
D[301].obj.I={2637} --old: nil
D[306].obj={}
D[306].obj.I={2639} --old: nil
D[308].excl={311} --old: nil
D[310].obj={}
D[310].obj.I={2548} --old: nil
D[311].obj={}
D[311].obj.I={2666} --old: nil
D[320].obj={}
D[320].obj.I={2696} --old: nil
D[321].race=1101 --old: nil
D[322].obj={}
D[322].obj.I={2712} --old: nil
D[322].race=1101 --old: nil
D[325].obj.I={7297} --old: nil
D[325].race=1101 --old: nil
D[328].obj={}
D[328].obj.I={2719} --old: nil
D[329].obj={}
D[329].obj.I={2720} --old: nil
D[332].obj={}
D[332].obj.I={2722} --old: nil
D[333].obj={}
D[333].obj.I={2724} --old: nil
D[334].obj={}
D[334].obj.I={2760} --old: nil
D[336].obj={}
D[336].obj.I={2788} --old: nil
D[337].obj={}
D[337].obj.I={2794} --old: nil
D[346].obj={}
D[346].obj.I={2795} --old: nil
D[351].obj={}
D[351].obj.I={8623} --old: nil
D[353].obj={}
D[353].obj.I={2806} --old: nil
D[353].pre=nil --old: 1097
D[361].obj={}
D[361].obj.I={2837,2839} --old: nil
D[364].pre=nil --old: 363
D[366].obj={}
D[366].obj.I={3016} --old: nil
D[367].race=690 --old: 16
D[368].race=690 --old: 16
D[369].race=690 --old: 16
D[373].start.U={639} --old: nil
D[373].obj={}
D[373].obj.I={2874} --old: nil
D[374].pre=427 --old: nil
D[383].obj={}
D[383].obj.I={2885} --old: nil
D[392].obj={}
D[392].obj.I={8687} --old: nil
D[393].obj={}
D[393].obj.I={8687} --old: nil
D[396].obj={}
D[396].obj.I={2956} --old: nil
D[400].obj={}
D[400].obj.I={2999} --old: nil
D[402].hide=true --old: nil
D[405].obj={}
D[405].obj.I={3017} --old: nil
D[407].obj={}
D[407].obj.I={3035} --old: nil
D[409].obj.I={3080} --old: nil
D[410].pre=366 --old: -409
D[410].excl={411} --old: nil
D[411].obj={}
D[411].obj.I={3081} --old: nil
D[413].obj={}
D[413].obj.I={3085} --old: nil
D[414].obj={}
D[414].obj.I={3086} --old: nil
D[415].excl={413} --old: nil
D[417].obj.I={3117,3183} --old: {3183}
D[420].obj={}
D[420].obj.I={2619} --old: nil
D[421].race=690 --old: nil
D[422].race=690 --old: nil
D[423].race=690 --old: nil
D[424].race=690 --old: nil
D[425].race=690 --old: nil
D[428].excl={429} --old: nil
D[428].race=690 --old: nil
D[429].pre=nil --old: 428
D[429].race=690 --old: nil
D[430].obj={}
D[430].obj.I={3165} --old: nil
D[430].race=690 --old: nil
D[431].pre=366 --old: -409
D[431].excl={411} --old: nil
D[435].race=690 --old: nil
D[436].excl={297} --old: nil
D[437].race=690 --old: nil
D[438].race=690 --old: nil
D[439].obj={}
D[439].obj.I={3234} --old: nil
D[440].obj={}
D[440].obj.I={3234} --old: nil
D[440].race=690 --old: nil
D[441].obj={}
D[441].obj.I={3234} --old: nil
D[441].race=690 --old: nil
D[442].race=690 --old: nil
D[443].race=690 --old: nil
D[444].obj={}
D[444].obj.I={3237} --old: nil
D[444].race=690 --old: nil
D[445].obj={}
D[445].obj.I={3238} --old: nil
D[446].obj={}
D[446].obj.I={3250} --old: nil
D[446].race=690 --old: nil
D[447].race=690 --old: nil
D[448].race=690 --old: nil
D[449].obj={}
D[449].obj.I={3252} --old: nil
D[449].race=690 --old: nil
D[450].race=690 --old: nil
D[451].race=690 --old: nil
D[453].obj={}
D[453].obj.I={2161} --old: nil
D[455].pre=nil --old: 468
D[456].race=1101 --old: nil
D[457].race=1101 --old: nil
D[458].race=1101 --old: nil
D[459].race=1101 --old: nil
D[460].start.U={1939} --old: nil
D[460].obj={}
D[460].obj.I={3317} --old: nil
D[460].race=690 --old: nil
D[461].obj={}
D[461].obj.I={3318} --old: nil
D[463].excl={276} --old: nil
D[464].pre=nil --old: 473
D[465].obj={}
D[465].obj.I={3339} --old: nil
D[466].pre=nil --old: 467
D[467].start.U={1340,2092} --old: {1340}
D[467].excl={466} --old: nil
D[468].excl={455} --old: nil
D[469].obj={}
D[469].obj.I={3347} --old: nil
D[470].race=1101 --old: nil
D[472].race=1101 --old: nil
D[473].pre=455 --old: nil
D[473].excl={464} --old: nil
D[476].race=1101 --old: nil
D[477].race=690 --old: nil
D[478].obj={}
D[478].obj.I={3353} --old: nil
D[479].race=690 --old: nil
D[480].race=690 --old: nil
D[481].obj={}
D[481].obj.I={3353} --old: nil
D[481].race=690 --old: nil
D[482].race=690 --old: nil
D[483].race=1101 --old: nil
D[484].repu={id=72,min=0} --old: id=nil
D[485].obj={}
D[485].obj.I={8704} --old: nil
D[486].race=1101 --old: nil
D[487].race=1101 --old: nil
D[488].race=1101 --old: nil
D[489].race=1101 --old: nil
D[491].obj={}
D[491].obj.I={3425} --old: nil
D[492].obj={}
D[492].obj.I={3460} --old: nil
D[493].obj={}
D[493].obj.I={3468} --old: nil
D[493].race=690 --old: nil
D[495].excl={518} --old: nil
D[499].obj={}
D[499].obj.I={3495} --old: nil
D[502].obj={}
D[502].obj.I={3497} --old: nil
D[506].race=690 --old: nil
D[508].obj={}
D[508].obj.I={3498} --old: nil
D[510].start.O={1740} --old: {1740,186420}
D[510].obj={}
D[510].obj.I={3718} --old: nil
D[511].start.O={1740} --old: {1740,186420}
D[511].obj={}
D[511].obj.I={3521} --old: nil
D[513].obj={}
D[513].obj.I={3506} --old: nil
D[514].obj={}
D[514].obj.I={3521} --old: nil
D[515].obj.I={3388,3508,3509,3510} --old: {3388,3509,3510}
D[515].race=690 --old: nil
D[516].race=690 --old: nil
D[518].pre=nil --old: 495
D[521].obj={}
D[521].obj.I={3554} --old: nil
D[522].start.U={2434} --old: nil
D[522].obj={}
D[522].obj.I={3668} --old: nil
D[524].obj={}
D[524].obj.I={3520} --old: nil
D[525].obj={}
D[525].obj.I={3518} --old: nil
D[526].excl={322,324} --old: nil
D[530].race=690 --old: nil
D[531].obj={}
D[531].obj.I={2713} --old: nil
D[535].race=690 --old: nil
D[542].obj={}
D[542].obj.I={3660} --old: nil
D[549].next=566 --old: nil
D[550].obj={}
D[550].obj.I={3701} --old: nil
D[551].start.O={1765} --old: nil
D[551].obj={}
D[551].obj.I={3706} --old: nil
D[553].obj.I={3710} --old: nil
D[554].obj={}
D[554].obj.I={3706} --old: nil
D[558].preg={1479,1558,1687} --old: nil
D[558].race=1101 --old: nil
D[558].hide=true --old: nil
D[560].obj={}
D[560].obj.I={3717} --old: nil
D[561].race=1101 --old: nil
D[563].obj={}
D[563].obj.I={3721} --old: nil
D[566].pre=549 --old: nil
D[574].preg={203,204} --old: nil
D[578].obj.I={3898} --old: nil
D[588].preg={585,586} --old: nil
D[592].obj.I={3912,3913} --old: {3913}
D[594].start.O={2560} --old: nil
D[594].obj={}
D[594].obj.I={4098} --old: nil
D[598].pre=nil --old: 596
D[598].preg={596,629} --old: nil
D[602].obj={}
D[602].obj.I={3960} --old: nil
D[607].obj={}
D[607].obj.I={3922} --old: nil
D[611].obj.I={4027,4034} --old: {4034}
D[614].hide=true --old: nil
D[615].hide=true --old: nil
D[618].hide=true --old: nil
D[620].obj={}
D[620].obj.I={3985} --old: nil
D[622].obj={}
D[622].obj.I={1987} --old: nil
D[623].obj={}
D[623].obj.I={4028} --old: nil
D[624].start.O={2554} --old: nil
D[624].obj={}
D[624].obj.I={4056} --old: nil
D[632].obj={}
D[632].obj.I={4429} --old: nil
D[635].obj={}
D[635].obj.I={4614} --old: nil
D[636].hide=true --old: nil
D[637].start.O={2656} --old: nil
D[637].obj={}
D[637].obj.I={4432,4433} --old: nil
D[638].excl={639} --old: nil
D[639].pre=nil --old: 638
D[641].obj={}
D[641].obj.I={4453} --old: nil
D[645].obj={}
D[645].obj.I={4467} --old: nil
D[646].obj={}
D[646].obj.I={4468} --old: nil
D[647].obj={}
D[647].obj.I={4441} --old: nil
D[649].race=690 --old: nil
D[650].race=690 --old: nil
D[654].obj.I={8523,8524,9437,9438,9439,9440,9441,9442} --old: {8523,9437,9438,9439,9440,9441,9442}
D[656].obj.I={4472,4473} --old: {4473}
D[657].race=1101 --old: nil
D[658].race=1101 --old: nil
D[660].race=1101 --old: nil
D[663].min=35 --old: 31
D[666].obj.I={4491,4492} --old: {4492}
D[668].obj={}
D[668].obj.I={4493} --old: nil
D[669].obj={}
D[669].obj.I={4502} --old: nil
D[670].obj={}
D[670].obj.I={4494} --old: nil
D[674].obj={}
D[674].obj.I={4526} --old: nil
D[676].excl={677} --old: nil
D[677].pre=nil --old: 676
D[681].race=1101 --old: nil
D[683].obj={}
D[683].obj.I={4514} --old: nil
D[687].pre={653,688} --old: nil
D[690].excl={691} --old: nil
D[691].pre=nil --old: 690
D[695].obj.I={4529} --old: nil
D[697].obj={}
D[697].obj.I={4533} --old: nil
D[702].obj={}
D[702].obj.I={4528} --old: nil
D[707].excl={738} --old: nil
D[708].obj={}
D[708].obj.I={4613} --old: nil
D[708].hide=true --old: nil
D[715].skill={id=0,min=0} --old: id=171
D[717].obj.I={4615,4640,4645,4843,4844,4845} --old: {4615,4645}
D[723].obj={}
D[723].obj.I={4635} --old: nil
D[724].obj={}
D[724].obj.I={4635} --old: nil
D[725].obj={}
D[725].obj.I={4622} --old: nil
D[727].obj={}
D[727].obj.I={4648} --old: nil
D[728].obj={}
D[728].obj.I={4648} --old: nil
D[729].race=1101 --old: nil
D[730].excl={729} --old: nil
D[730].race=1101 --old: nil
D[731].race=1101 --old: nil
D[734].preg={712,714} --old: nil
D[735].obj.I={4641,4644,4646,4649} --old: {4641,4644,4646}
D[736].obj.I={4639,4641,4644,4646,4650} --old: {4641,4644,4646}
D[737].obj={}
D[737].obj.I={4647} --old: nil
D[737].pre={735,736} --old: nil
D[738].pre=nil --old: 707
D[741].obj={}
D[741].obj.I={4654} --old: nil
D[741].race=1101 --old: nil
D[742].excl={235,6382,6383} --old: nil
D[743].race=690 --old: nil
D[745].race=690 --old: nil
D[746].race=690 --old: nil
D[748].race=32 --old: nil
D[749].race=690 --old: nil
D[750].race=690 --old: nil
D[751].obj={}
D[751].obj.I={4834} --old: nil
D[752].race=690 --old: nil
D[753].race=690 --old: nil
D[754].obj.I={5411} --old: nil
D[755].race=690 --old: nil
D[756].race=690 --old: nil
D[757].race=690 --old: nil
D[758].obj.I={5415} --old: nil
D[759].race=690 --old: nil
D[760].obj.I={5416} --old: nil
D[761].race=690 --old: nil
D[763].obj={}
D[763].obj.I={4783} --old: nil
D[763].race=690 --old: nil
D[764].race=690 --old: nil
D[765].race=690 --old: nil
D[766].race=690 --old: nil
D[767].race=690 --old: nil
D[768].skill={id=393,min=1} --old: id=393
D[769].skill={id=165,min=10} --old: id=nil
D[770].start.U={3056} --old: nil
D[770].obj={}
D[770].obj.I={4854} --old: nil
D[771].race=690 --old: nil
D[772].obj.I={4823} --old: nil
D[772].race=690 --old: nil
D[773].race=690 --old: nil
D[775].race=690 --old: nil
D[777].obj={}
D[777].obj.I={4846} --old: nil
D[780].race=690 --old: nil
D[781].start.O={3076} --old: nil
D[781].obj={}
D[781].obj.I={4850,4851} --old: nil
D[785].hide=true --old: nil
D[787].race=690 --old: nil
D[787].hide=true --old: nil
D[790].race=690 --old: nil
D[793].obj.I={4615,4640,4645,4843,4844,4845} --old: {4615,4645}
D[794].pre={792,1499} --old: nil
D[804].race=690 --old: nil
D[819].start.O={3238} --old: nil
D[819].obj={}
D[819].obj.I={4926} --old: nil
D[824].obj={}
D[824].obj.I={16408} --old: nil
D[829].obj={}
D[829].obj.I={6658} --old: nil
D[830].start.O={3239} --old: nil
D[830].obj={}
D[830].obj.I={4881,4883} --old: nil
D[831].obj={}
D[831].obj.I={4883} --old: nil
D[832].start.U={3204} --old: nil
D[832].obj={}
D[832].obj.I={4903} --old: nil
D[833].race=690 --old: nil
D[834].race=2047 --old: 690
D[835].race=2047 --old: 690
D[840].obj={}
D[840].obj.I={4992} --old: nil
D[841].excl={654} --old: nil
D[842].obj={}
D[842].obj.I={4995} --old: nil
D[849].obj.I={5021} --old: nil
D[853].obj={}
D[853].obj.I={5027} --old: nil
D[854].excl={871} --old: nil
D[860].excl={844} --old: nil
D[861].next=860 --old: nil
D[861].excl={844,860} --old: nil
D[862].skill={id=185,min=76} --old: id=185
D[864].obj={}
D[864].obj.I={8527} --old: nil
D[866].skill={id=182,min=1} --old: id=182
D[868].obj.I={5058,5059} --old: {5058}
D[877].obj.I={5068} --old: nil
D[881].obj.I={5100,10327} --old: {5100}
D[883].start.U={3474} --old: nil
D[883].obj={}
D[883].obj.I={5099} --old: nil
D[884].start.U={3473} --old: nil
D[884].obj={}
D[884].obj.I={5102} --old: nil
D[885].start.U={3472} --old: nil
D[885].obj={}
D[885].obj.I={5103} --old: nil
D[886].excl={870} --old: nil
D[890].obj={}
D[890].obj.I={5080} --old: nil
D[892].obj={}
D[892].obj.I={5080} --old: nil
D[894].obj={}
D[894].obj.I={5088} --old: nil
D[897].start.U={3253} --old: nil
D[897].obj={}
D[897].obj.I={5138} --old: nil
D[902].obj={}
D[902].obj.I={5054} --old: nil
D[906].obj={}
D[906].obj.I={5072} --old: nil
D[909].obj={}
D[909].obj.I={16782} --old: nil
D[909].hide=true --old: nil
D[910].hide=true --old: nil
D[911].hide=true --old: nil
D[915].hide=true --old: nil
D[916].race=1101 --old: nil
D[917].race=1101 --old: nil
D[918].pre=nil --old: 997
D[918].race=1101 --old: nil
D[919].race=1101 --old: nil
D[920].race=1101 --old: nil
D[921].obj.I={5184,5185} --old: {5184}
D[921].race=1101 --old: nil
D[922].obj={}
D[922].obj.I={5168} --old: nil
D[922].race=1101 --old: nil
D[923].race=1101 --old: nil
D[924].obj.I={4986} --old: nil
D[925].preg={910,911,1800} --old: nil
D[925].hide=true --old: nil
D[926].pre=809 --old: -924
D[926].excl={924} --old: nil
D[927].start.U={3535} --old: nil
D[927].obj={}
D[927].obj.I={5179} --old: nil
D[927].race=1101 --old: nil
D[928].obj={}
D[928].obj.I={5186} --old: nil
D[928].race=1101 --old: nil
D[929].obj.I={5619,5639} --old: {5639}
D[929].race=1101 --old: nil
D[930].obj={}
D[930].obj.I={5189} --old: nil
D[930].pre=918 --old: nil
D[931].obj={}
D[931].obj.I={5190} --old: nil
D[931].pre=918 --old: nil
D[932].race=1101 --old: nil
D[933].obj.I={5621,5645} --old: {5645}
D[933].race=1101 --old: nil
D[934].obj.I={5623,5646} --old: {5646}
D[934].hide=true --old: nil
D[935].obj={}
D[935].obj.I={5188} --old: nil
D[935].race=1101 --old: nil
D[936].excl={3761,3762,3784} --old: nil
D[937].race=1101 --old: nil
D[938].race=1101 --old: nil
D[939].start.U={10648} --old: nil
D[939].obj.I={11668,11674} --old: {11674}
D[940].obj={}
D[940].obj.I={5219} --old: nil
D[940].race=1101 --old: nil
D[941].obj={}
D[941].obj.I={5217} --old: nil
D[942].obj={}
D[942].obj.I={4654} --old: nil
D[942].race=1101 --old: nil
D[943].race=1101 --old: nil
D[944].obj.I={5251} --old: nil
D[944].race=1101 --old: nil
D[945].race=1101 --old: nil
D[947].race=1101 --old: nil
D[948].race=1101 --old: nil
D[950].obj={}
D[950].obj.I={5272} --old: nil
D[951].race=1101 --old: nil
D[952].obj={}
D[952].obj.I={5390} --old: nil
D[952].race=1101 --old: nil
D[953].race=1101 --old: nil
D[954].race=1101 --old: nil
D[955].race=1101 --old: nil
D[956].race=1101 --old: nil
D[957].obj.I={5338} --old: nil
D[957].race=1101 --old: nil
D[958].race=1101 --old: nil
D[961].pre=944 --old: nil
D[961].excl={950} --old: nil
D[961].race=1101 --old: nil
D[963].race=1101 --old: nil
D[965].race=1101 --old: nil
D[966].race=1101 --old: nil
D[967].obj={}
D[967].obj.I={5354} --old: nil
D[967].race=1101 --old: nil
D[968].start.U={2338,2339} --old: nil
D[968].obj={}
D[968].obj.I={5352} --old: nil
D[968].race=1101 --old: nil
D[970].race=1101 --old: nil
D[972].excl={96} --old: nil
D[972].lvl=nil --old: -1
D[973].race=1101 --old: nil
D[974].obj.I={12472} --old: nil
D[981].race=1101 --old: nil
D[982].race=1101 --old: nil
D[983].race=1101 --old: nil
D[984].race=1101 --old: nil
D[985].race=1101 --old: nil
D[986].race=1101 --old: nil
D[990].pre={994,995} --old: nil
D[990].excl={10752} --old: nil
D[992].obj.I={8584,8585} --old: {8585}
D[993].obj.I={5387} --old: nil
D[993].race=1101 --old: nil
D[994].excl={995} --old: nil
D[994].race=1101 --old: nil
D[995].excl={994} --old: nil
D[995].race=1101 --old: nil
D[996].hide=true --old: nil
D[997].obj={}
D[997].obj.I={5391} --old: nil
D[997].race=1101 --old: nil
D[998].hide=true --old: nil
D[999].hide=true --old: nil
D[1000].excl={1004,1018} --old: nil
D[1004].excl={1000,1018} --old: nil
D[1005].hide=true --old: nil
D[1006].hide=true --old: nil
D[1011].pre=nil --old: 4581
D[1014].race=690 --old: nil
D[1015].excl={1019,1047} --old: nil
D[1016].obj.I={5455,5456,12220} --old: {5455,12220}
D[1018].excl={1000,1004} --old: nil
D[1019].excl={1015,1047} --old: nil
D[1020].obj={}
D[1020].obj.I={5460} --old: nil
D[1023].obj.I={5463,5505} --old: {5463}
D[1024].obj={}
D[1024].obj.I={5463} --old: nil
D[1026].obj.I={5464,5475} --old: {5464}
D[1028].obj={}
D[1028].obj.I={5547} --old: nil
D[1029].obj={}
D[1029].obj.I={5462} --old: nil
D[1030].obj={}
D[1030].obj.I={5462} --old: nil
D[1036].repu={id=87,min=3000} --old: id=nil
D[1038].obj.I={5520,5521} --old: {5520}
D[1045].obj.I={5388,5462} --old: {5388}
D[1046].obj.I={5388,5462} --old: {5462}
D[1047].excl={1015,1019} --old: nil
D[1052].obj={}
D[1052].obj.I={5539} --old: nil
D[1056].excl={1057} --old: nil
D[1060].obj={}
D[1060].obj.I={5594} --old: nil
D[1061].excl={1062} --old: nil
D[1065].obj={}
D[1065].obj.I={5628} --old: nil
D[1065].race=690 --old: nil
D[1067].obj={}
D[1067].obj.I={5588} --old: nil
D[1074].obj={}
D[1074].obj.I={5732} --old: nil
D[1077].obj={}
D[1077].obj.I={5731} --old: nil
D[1079].obj.I={5718,5738} --old: {5718}
D[1079].pre={1074,1077} --old: 1074
D[1080].obj.I={5717,5738} --old: {5717}
D[1080].pre={1074,1077} --old: 1077
D[1082].preg={1083,1084} --old: nil
D[1085].pre=1070 --old: nil
D[1086].obj.I={5638} --old: nil
D[1091].obj={}
D[1091].obj.I={5717} --old: nil
D[1091].preg={1079,1080} --old: nil
D[1092].obj={}
D[1092].obj.I={5733} --old: nil
D[1094].obj={}
D[1094].obj.I={5735} --old: nil
D[1097].excl={353} --old: nil
D[1098].race=690 --old: nil
D[1099].hide=true --old: nil
D[1100].start.O={19861} --old: nil
D[1100].obj={}
D[1100].obj.I={5790,5791} --old: nil
D[1102].race=690 --old: nil
D[1103].pre=nil --old: -100
D[1103].lvl=nil --old: -1
D[1106].obj={}
D[1106].obj.I={5827} --old: nil
D[1106].pre=nil --old: nil
D[1106].preg={1104,1105} --old: nil
D[1107].pre=nil --old: 1105
D[1107].preg={1104,1105} --old: nil
D[1111].obj={}
D[1111].obj.I={5799} --old: nil
D[1112].obj={}
D[1112].obj.I={5800} --old: nil
D[1114].obj={}
D[1114].obj.I={5802} --old: nil
D[1117].obj={}
D[1117].obj.I={5804} --old: nil
D[1118].obj={}
D[1118].obj.I={5826} --old: nil
D[1119].obj={}
D[1119].obj.I={5806} --old: nil
D[1119].preg={621,1118} --old: nil
D[1120].obj={}
D[1120].obj.I={5806} --old: nil
D[1120].excl={1121} --old: nil
D[1121].obj={}
D[1121].obj.I={5806} --old: nil
D[1121].excl={1120} --old: nil
D[1122].obj={}
D[1122].obj.I={5807} --old: nil
D[1122].pre={1120,1121} --old: nil
D[1123].pre={1000,1004,1018} --old: nil
D[1124].obj={}
D[1124].obj.I={17355} --old: nil
D[1124].pre={1123,6762} --old: nil
D[1131].pre=nil --old: 1130
D[1132].excl={1133} --old: nil
D[1133].pre=nil --old: 1132
D[1136].obj.I={5810,5811,5838} --old: {5810,5811}
D[1138].race=1101 --old: nil
D[1140].race=1101 --old: nil
D[1141].race=1101 --old: nil
D[1142].race=1101 --old: nil
D[1143].race=1101 --old: nil
D[1145].obj={}
D[1145].obj.I={5846} --old: nil
D[1146].obj={}
D[1146].obj.I={5850} --old: nil
D[1148].start.U={4132} --old: nil
D[1148].obj.I={5853,5854,5855,5877} --old: {5853,5854,5855}
D[1148].pre=1146 --old: nil
D[1167].race=1101 --old: nil
D[1179].obj={}
D[1179].obj.I={5849} --old: nil
D[1183].obj={}
D[1183].obj.I={5852} --old: nil
D[1188].obj={}
D[1188].obj.I={5862} --old: nil
D[1189].obj={}
D[1189].obj.I={5865} --old: nil
D[1194].obj={}
D[1194].obj.I={5866} --old: nil
D[1196].obj={}
D[1196].obj.I={5868} --old: nil
D[1197].obj.I={5868,5869} --old: {5869}
D[1204].pre=nil --old: 1260
D[1219].obj={}
D[1219].obj.I={5917} --old: nil
D[1220].obj={}
D[1220].obj.I={5917} --old: nil
D[1238].obj={}
D[1238].obj.I={5917} --old: nil
D[1239].obj={}
D[1239].obj.I={5918} --old: nil
D[1240].obj={}
D[1240].obj.I={5918} --old: nil
D[1241].obj={}
D[1241].obj.I={5948} --old: nil
D[1242].obj={}
D[1242].obj.I={5946} --old: nil
D[1242].race=1101 --old: nil
D[1243].obj={}
D[1243].obj.I={5960} --old: nil
D[1245].obj={}
D[1245].obj.I={5947} --old: nil
D[1251].obj={}
D[1251].obj.I={5919} --old: nil
D[1252].obj={}
D[1252].obj.I={5950} --old: nil
D[1252].pre={1282,1302} --old: nil
D[1253].obj={}
D[1253].obj.I={5919} --old: nil
D[1253].pre={1282,1302} --old: nil
D[1260].excl={1204} --old: nil
D[1262].obj={}
D[1262].obj.I={5942} --old: nil
D[1263].hide=true --old: nil
D[1268].start.O={21015,21016} --old: {187273}
D[1269].obj={}
D[1269].obj.I={5950} --old: nil
D[1271].preg={1204,1222} --old: nil
D[1272].hide=true --old: nil
D[1275].pre=nil --old: 3765
D[1276].obj={}
D[1276].obj.I={5919} --old: nil
D[1276].pre=1273 --old: 1323
D[1281].hide=true --old: nil
D[1282].excl={1302} --old: nil
D[1284].start.O={21015,21016} --old: {187273}
D[1284].pre={1282,1302} --old: nil
D[1288].obj={}
D[1288].obj.I={6075} --old: nil
D[1288].hide=true --old: nil
D[1289].hide=true --old: nil
D[1301].excl={1282,1302} --old: nil
D[1302].pre=nil --old: 1301
D[1302].excl={1282} --old: nil
D[1318].hide=true --old: nil
D[1319].obj={}
D[1319].obj.I={5919} --old: nil
D[1321].obj={}
D[1321].obj.I={5919} --old: nil
D[1338].obj={}
D[1338].obj.I={5998} --old: nil
D[1339].excl={1338} --old: nil
D[1358].obj={}
D[1358].obj.I={6016} --old: nil
D[1358].race=690 --old: nil
D[1359].obj={}
D[1359].obj.I={10283} --old: nil
D[1359].race=690 --old: nil
D[1361].excl={1362} --old: nil
D[1364].pre=1363 --old: nil
D[1369].pre={1367,1386} --old: nil
D[1370].pre={1368,1384} --old: nil
D[1388].obj={}
D[1388].obj.I={6086} --old: nil
D[1390].hide=true --old: nil
D[1391].obj={}
D[1391].obj.I={6089} --old: nil
D[1392].start.U={5477} --old: nil
D[1392].obj={}
D[1392].obj.I={6196} --old: nil
D[1395].obj={}
D[1395].obj.I={6091} --old: nil
D[1395].pre=nil --old: 1477
D[1418].excl={1419,1420} --old: nil
D[1420].obj={}
D[1420].obj.I={6167} --old: nil
D[1423].start.O={28604} --old: nil
D[1423].obj={}
D[1423].obj.I={6172} --old: nil
D[1425].obj={}
D[1425].obj.I={6178} --old: nil
D[1427].next=1428 --old: nil
D[1429].obj={}
D[1429].obj.I={6193} --old: nil
D[1431].race=690 --old: nil
D[1432].next=1433 --old: nil
D[1432].race=690 --old: nil
D[1434].pre=1432 --old: nil
D[1435].obj.I={6435,6436} --old: {6435}
D[1436].pre=nil --old: 1435
D[1436].preg={1434,1480} --old: nil
D[1445].race=690 --old: nil
D[1456].obj.I={6245,34130} --old: {6245}
D[1457].obj={}
D[1457].obj.I={6245} --old: nil
D[1464].lvl=nil --old: -1
D[1465].obj={}
D[1465].obj.I={6479} --old: nil
D[1467].obj={}
D[1467].obj.I={6253} --old: nil
D[1468].obj={}
D[1468].obj.I={18598} --old: nil
D[1468].hide=true --old: nil
D[1469].obj={}
D[1469].obj.I={6287} --old: nil
D[1470].excl={1485} --old: nil
D[1470].lvl=nil --old: -1
D[1471].obj.I={6284} --old: nil
D[1471].excl={1504} --old: nil
D[1471].lvl=nil --old: -1
D[1472].excl={1507} --old: nil
D[1472].lvl=nil --old: -1
D[1473].pre={1478,10789} --old: nil
D[1473].excl={1501} --old: nil
D[1473].lvl=nil --old: -1
D[1474].obj.I={6286} --old: nil
D[1474].lvl=nil --old: -1
D[1476].lvl=nil --old: -1
D[1477].excl={1395} --old: nil
D[1478].excl={1506} --old: nil
D[1478].lvl=nil --old: -1
D[1479].hide=true --old: nil
D[1480].obj={}
D[1480].obj.I={6766,20310} --old: nil
D[1483].excl={1093} --old: nil
D[1485].excl={1470} --old: nil
D[1485].lvl=nil --old: -1
D[1492].obj={}
D[1492].obj.I={6462} --old: nil
D[1498].lvl=nil --old: -1
D[1499].lvl=nil --old: -1
D[1500].hide=true --old: nil
D[1501].pre={1506,10790} --old: nil
D[1501].excl={1473} --old: nil
D[1501].lvl=nil --old: -1
D[1504].obj.I={7464} --old: nil
D[1504].excl={1471} --old: nil
D[1504].lvl=nil --old: -1
D[1505].excl={1818} --old: nil
D[1505].lvl=nil --old: -1
D[1506].excl={1478} --old: nil
D[1506].lvl=nil --old: -1
D[1507].excl={1472} --old: nil
D[1507].lvl=nil --old: -1
D[1508].lvl=nil --old: -1
D[1509].lvl=nil --old: -1
D[1510].lvl=nil --old: -1
D[1511].obj={}
D[1511].obj.I={6624} --old: nil
D[1511].lvl=nil --old: -1
D[1512].obj={}
D[1512].obj.I={6625} --old: nil
D[1512].lvl=nil --old: -1
D[1513].obj.I={6626} --old: nil
D[1513].lvl=nil --old: -1
D[1514].hide=true --old: nil
D[1515].obj={}
D[1515].obj.I={6624} --old: nil
D[1515].lvl=nil --old: -1
D[1517].obj.I={6635} --old: nil
D[1518].obj={}
D[1518].obj.I={6656} --old: nil
D[1520].obj.I={6635} --old: nil
D[1521].obj={}
D[1521].obj.I={6656} --old: nil
D[1522].excl={1523,2983,2984} --old: nil
D[1522].lvl=nil --old: -1
D[1523].excl={1522,2983,2984} --old: nil
D[1523].lvl=nil --old: -1
D[1524].obj={}
D[1524].obj.I={6653} --old: nil
D[1524].pre={1522,1523,2983,2984} --old: nil
D[1524].lvl=nil --old: -1
D[1525].lvl=nil --old: -1
D[1526].obj.I={6653,6655} --old: {6655}
D[1526].lvl=nil --old: -1
D[1527].obj={}
D[1527].obj.I={6654} --old: nil
D[1527].lvl=nil --old: -1
D[1528].excl={1529,2985} --old: nil
D[1528].lvl=nil --old: -1
D[1529].excl={1528,2985} --old: nil
D[1529].lvl=nil --old: -1
D[1530].pre={1528,1529,2985} --old: nil
D[1530].lvl=nil --old: -1
D[1531].excl={1532} --old: nil
D[1531].lvl=nil --old: -1
D[1532].excl={1531} --old: nil
D[1532].lvl=nil --old: -1
D[1534].obj.I={7767,7770} --old: {7770}
D[1534].lvl=nil --old: -1
D[1535].obj.I={7766,7769} --old: {7769}
D[1535].lvl=nil --old: -1
D[1536].obj.I={7768,7771} --old: {7771}
D[1536].lvl=nil --old: -1
D[1558].hide=true --old: nil
D[1559].pre=705 --old: nil
D[1559].skill={id=202,min=1} --old: id=202
D[1578].skill={id=164,min=35} --old: id=164
D[1579].skill={id=356,min=30} --old: id=356
D[1580].skill={id=356,min=30} --old: id=356
D[1581].skill={id=171,min=20} --old: id=171
D[1582].skill={id=165,min=90} --old: id=165
D[1598].excl={1599} --old: nil
D[1598].lvl=nil --old: -1
D[1599].pre=705 --old: nil
D[1599].excl={1598} --old: nil
D[1599].lvl=nil --old: -1
D[1618].skill={id=164,min=70} --old: id=164
D[1638].excl={1666,1678,1680,1683,1686} --old: nil
D[1638].lvl=nil --old: -1
D[1639].excl={1678} --old: nil
D[1639].lvl=nil --old: -1
D[1640].lvl=nil --old: -1
D[1641].excl={1642,1646,2997,2998,2999,3000,3681} --old: nil
D[1641].lvl=nil --old: -1
D[1642].obj={}
D[1642].obj.I={6775} --old: nil
D[1642].excl={1646,2997,2998,2999,3000,3681} --old: nil
D[1642].lvl=nil --old: -1
D[1643].lvl=nil --old: -1
D[1644].lvl=nil --old: -1
D[1645].excl={1642,1646,2997,2998,2999,3000,3681} --old: nil
D[1645].lvl=nil --old: -1
D[1646].obj={}
D[1646].obj.I={6916} --old: nil
D[1646].excl={1642,2997,2998,2999,3000,3681} --old: nil
D[1646].lvl=nil --old: -1
D[1647].lvl=nil --old: -1
D[1648].lvl=nil --old: -1
D[1649].obj={}
D[1649].obj.I={6776} --old: nil
D[1649].lvl=nil --old: -1
D[1650].lvl=nil --old: -1
D[1651].lvl=nil --old: -1
D[1652].lvl=nil --old: -1
D[1653].lvl=nil --old: -1
D[1654].obj.I={6895,6993,6994,6996,7083} --old: {6895,6993,6994,7083}
D[1656].obj={}
D[1656].obj.I={7626} --old: nil
D[1656].race=690 --old: nil
D[1657].obj.I={20387} --old: nil
D[1657].lvl=nil --old: -1
D[1657].race=690 --old: nil
D[1657].hide=true --old: nil
D[1658].lvl=nil --old: -1
D[1658].hide=true --old: nil
D[1661].excl={4485,4486} --old: nil
D[1661].lvl=nil --old: -1
D[1661].hide=true --old: nil
D[1665].obj={}
D[1665].obj.I={6781} --old: nil
D[1665].lvl=nil --old: -1
D[1666].pre={1639,1678,1683} --old: 1665
D[1678].excl={1639} --old: nil
D[1679].excl={1639,1666,1680,1683,1686} --old: nil
D[1679].lvl=nil --old: -1
D[1680].pre={1639,1678,1683} --old: 1678
D[1680].excl={1681} --old: nil
D[1683].lvl=nil --old: -1
D[1684].excl={1639,1666,1678,1680,1686} --old: nil
D[1684].lvl=nil --old: -1
D[1685].excl={1715} --old: nil
D[1685].lvl=nil --old: -1
D[1686].pre={1639,1678,1683} --old: 1683
D[1687].hide=true --old: nil
D[1688].lvl=nil --old: -1
D[1689].obj.I={6928} --old: nil
D[1689].lvl=nil --old: -1
D[1692].obj={}
D[1692].obj.I={6812} --old: nil
D[1700].obj={}
D[1700].obj.I={6926} --old: nil
D[1700].excl={1703,1704,1705} --old: nil
D[1700].race=1 --old: 1101
D[1701].obj.I={6838,6839,6840,6841,6842} --old: {6838,6839,6840,6841}
D[1702].obj={}
D[1702].obj.I={6843} --old: nil
D[1703].obj={}
D[1703].obj.I={6926} --old: nil
D[1703].excl={1700,1704,1710} --old: nil
D[1704].obj={}
D[1704].obj.I={6926} --old: nil
D[1704].excl={1700,1703,1708} --old: nil
D[1705].pre={1700,1703,1704} --old: 1700
D[1708].pre={1700,1703,1704} --old: 1704
D[1710].pre={1700,1703,1704} --old: 1703
D[1712].obj.I={3357,3901,4479,4480,4481,6851,6929} --old: {3357,3901,4479,4480,4481,6851}
D[1715].excl={1685} --old: nil
D[1715].lvl=nil --old: -1
D[1716].lvl=nil --old: -1
D[1717].lvl=nil --old: -1
D[1718].start.U={3041,3354,4595,5113,5479} --old: {3041,3354,4595,5113,5479,7315}
D[1718].lvl=nil --old: -1
D[1719].lvl=nil --old: -1
D[1738].lvl=nil --old: -1
D[1739].obj.I={6913} --old: nil
D[1739].lvl=nil --old: -1
D[1758].lvl=nil --old: -1
D[1778].lvl=nil --old: -1
D[1779].obj.I={6866} --old: nil
D[1779].lvl=nil --old: -1
D[1780].lvl=nil --old: -1
D[1781].obj.I={6866} --old: nil
D[1781].lvl=nil --old: -1
D[1783].lvl=nil --old: -1
D[1784].lvl=nil --old: -1
D[1785].lvl=nil --old: -1
D[1786].lvl=nil --old: -1
D[1787].lvl=nil --old: -1
D[1788].lvl=nil --old: -1
D[1789].lvl=nil --old: -1
D[1790].lvl=nil --old: -1
D[1793].excl={1649} --old: nil
D[1793].lvl=nil --old: -1
D[1794].excl={1649} --old: nil
D[1794].lvl=nil --old: -1
D[1795].obj.I={6999} --old: nil
D[1795].pre={1804,1805} --old: 1805
D[1795].lvl=nil --old: -1
D[1798].lvl=nil --old: -1
D[1800].hide=true --old: nil
D[1801].lvl=nil --old: -1
D[1802].lvl=nil --old: -1
D[1803].lvl=nil --old: -1
D[1804].obj.I={6930,7006} --old: {6930}
D[1804].lvl=nil --old: -1
D[1805].obj.I={6930,7006} --old: {6930}
D[1805].lvl=nil --old: -1
D[1818].excl={1505} --old: nil
D[1818].lvl=nil --old: -1
D[1819].lvl=nil --old: -1
D[1838].obj.I={3575,6841,7126,7127,7587} --old: {3575,6841,7126,7127}
D[1858].obj.I={7208,7209,7295} --old: {7208,7295}
D[1859].excl={1885} --old: nil
D[1860].excl=nil --old: nil
D[1861].obj.I={7206,7207} --old: {7206}
D[1861].pre={1860,1879} --old: 1860
D[1861].excl={1880} --old: nil
D[1879].excl=nil --old: nil
D[1880].pre={1860,1879} --old: 1879
D[1880].excl={1861} --old: nil
D[1881].excl={1883} --old: nil
D[1883].excl={1881} --old: nil
D[1885].excl={1859} --old: nil
D[1898].obj={}
D[1898].obj.I={7231} --old: nil
D[1918].start.U={12759} --old: nil
D[1918].obj={}
D[1918].obj.I={16408} --old: nil
D[1920].pre=nil --old: 1919
D[1943].excl={1944} --old: nil
D[1944].obj.I={7268,7269} --old: {7268}
D[1944].pre=nil --old: 1943
D[1948].obj.I={1529,7272,7273,7516} --old: {1529,7272,7273}
D[1959].start.U={2128,3049,5880,7311} --old: {7311}
D[1978].obj={}
D[1978].obj.I={7294} --old: nil
D[2019].obj={}
D[2019].obj.I={5060} --old: nil
D[2019].race=690 --old: nil
D[2019].hide=true --old: nil
D[2039].excl={2038} --old: nil
D[2041].excl={2040} --old: nil
D[2078].obj.I={7442} --old: nil
D[2078].race=1101 --old: nil
D[2098].race=1101 --old: nil
D[2118].obj.I={7586} --old: nil
D[2118].race=1101 --old: nil
D[2138].race=1101 --old: nil
D[2139].race=1101 --old: nil
D[2159].obj={}
D[2159].obj.I={7627} --old: nil
D[2160].obj={}
D[2160].obj.I={7646} --old: nil
D[2161].obj={}
D[2161].obj.I={7629} --old: nil
D[2178].skill={id=185,min=10} --old: id=185
D[2198].start.U={4852} --old: nil
D[2198].obj={}
D[2198].obj.I={7666} --old: nil
D[2200].obj={}
D[2200].obj.I={7667} --old: nil
D[2201].obj.I={7668,7669,7670,7671} --old: {7669,7670,7671}
D[2203].obj.I={7867,7870} --old: {7867}
D[2203].skill={id=171,min=210} --old: id=171
D[2205].obj={}
D[2205].obj.I={7674} --old: nil
D[2205].excl=nil --old: nil
D[2206].pre=2205 --old: nil
D[2218].excl=nil --old: nil
D[2239].obj={}
D[2239].obj.I={7715} --old: nil
D[2241].obj={}
D[2241].obj.I={7735} --old: nil
D[2241].excl=nil --old: nil
D[2259].excl={2260,2281} --old: nil
D[2260].pre=nil --old: 2259
D[2260].excl={2281} --old: nil
D[2279].obj={}
D[2279].obj.I={6064} --old: nil
D[2280].obj={}
D[2280].obj.I={6064} --old: nil
D[2281].excl={2299} --old: nil
D[2282].obj.I={5060,7871} --old: {7871}
D[2283].race=690 --old: nil
D[2284].race=690 --old: nil
D[2298].pre=nil --old: 2299
D[2298].excl={2281} --old: nil
D[2299].excl={2281} --old: nil
D[2300].pre=nil --old: 2205
D[2300].excl={2281} --old: nil
D[2318].obj={}
D[2318].obj.I={7886} --old: nil
D[2338].obj={}
D[2338].obj.I={7886} --old: nil
D[2338].race=690 --old: nil
D[2339].obj.I={7668,7669,7670,7671,7672} --old: {7669,7670,7671,7672}
D[2340].obj={}
D[2340].obj.I={7887} --old: nil
D[2358].race=1101 --old: nil
D[2358].hide=true --old: nil
D[2359].obj.I={7908,7923,8046} --old: {7908,7923}
D[2359].lvl=nil --old: -1
D[2360].lvl=nil --old: -1
D[2378].excl={2380} --old: nil
D[2379].pre={2378,2380} --old: nil
D[2380].excl={2378} --old: nil
D[2383].obj={}
D[2383].obj.I={12635} --old: nil
D[2438].race=1101 --old: nil
D[2439].obj={}
D[2439].obj.I={8070} --old: nil
D[2440].obj={}
D[2440].obj.I={8070} --old: nil
D[2458].obj.I={8051} --old: nil
D[2458].lvl=nil --old: -1
D[2459].race=1101 --old: nil
D[2460].lvl=nil --old: -1
D[2478].lvl=nil --old: -1
D[2479].obj={}
D[2479].obj.I={8087} --old: nil
D[2479].lvl=nil --old: -1
D[2480].lvl=nil --old: -1
D[2498].race=1101 --old: nil
D[2499].race=1101 --old: nil
D[2501].obj.I={7867,7870} --old: {7867}
D[2501].pre=nil --old: 2500
D[2501].preg={17,2500} --old: nil
D[2501].skill={id=171,min=210} --old: id=171
D[2520].obj.I={8155} --old: nil
D[2523].hide=true --old: nil
D[2541].race=1101 --old: nil
D[2561].obj.I={8149} --old: nil
D[2561].race=1101 --old: nil
D[2606].obj={}
D[2606].obj.I={8603} --old: nil
D[2661].obj={}
D[2661].obj.I={8528} --old: nil
D[2751].skill={id=164,min=140} --old: id=164
D[2752].skill={id=164,min=1} --old: id=164
D[2753].skill={id=164,min=1} --old: id=164
D[2754].skill={id=164,min=1} --old: id=164
D[2755].skill={id=164,min=1} --old: id=164
D[2756].skill={id=164,min=210} --old: id=164
D[2757].obj={}
D[2757].obj.I={8663} --old: nil
D[2757].skill={id=164,min=210} --old: id=164
D[2758].skill={id=164,min=210} --old: id=164
D[2759].obj={}
D[2759].obj.I={8663} --old: nil
D[2759].skill={id=164,min=210} --old: id=164
D[2760].obj={}
D[2760].obj.I={8686} --old: nil
D[2760].pre={2757,2759} --old: nil
D[2760].skill={id=164,min=210} --old: id=164
D[2761].skill={id=164,min=210} --old: id=164
D[2762].skill={id=164,min=210} --old: id=164
D[2763].skill={id=164,min=210} --old: id=164
D[2764].skill={id=164,min=210} --old: id=164
D[2765].preg={2761,2762,2763} --old: nil
D[2765].skill={id=164,min=210} --old: id=164
D[2766].obj={}
D[2766].obj.I={8705} --old: nil
D[2769].excl={2770} --old: nil
D[2771].skill={id=164,min=210} --old: id=164
D[2772].skill={id=164,min=210} --old: id=164
D[2773].skill={id=164,min=210} --old: id=164
D[2781].start.O={142122,150075} --old: {150075}
D[2782].obj={}
D[2782].obj.I={8724} --old: nil
D[2801].pre={2623,2783} --old: nil
D[2842].min=20 --old: 25
D[2847].skill={id=165,min=225} --old: id=165
D[2848].skill={id=165,min=225} --old: id=165
D[2849].skill={id=165,min=225} --old: id=165
D[2850].skill={id=165,min=225} --old: id=165
D[2851].skill={id=165,min=225} --old: id=165
D[2852].skill={id=165,min=225} --old: id=165
D[2853].obj={}
D[2853].obj.I={9235} --old: nil
D[2853].preg={2848,2849,2850,2851,2852} --old: nil
D[2853].skill={id=165,min=225} --old: id=165
D[2854].skill={id=165,min=225} --old: id=165
D[2855].skill={id=165,min=225} --old: id=165
D[2856].skill={id=165,min=225} --old: id=165
D[2857].skill={id=165,min=225} --old: id=165
D[2858].skill={id=165,min=225} --old: id=165
D[2859].skill={id=165,min=225} --old: id=165
D[2860].obj={}
D[2860].obj.I={9236} --old: nil
D[2860].preg={2855,2856,2857,2858,2859} --old: nil
D[2860].skill={id=165,min=225} --old: id=165
D[2861].start.U={4568,5144,5497,5885} --old: {3048,4568,5144,5497,5885}
D[2861].excl={2846} --old: nil
D[2864].excl={2865} --old: nil
D[2865].pre=nil --old: 2864
D[2871].obj={}
D[2871].obj.I={9248} --old: nil
D[2872].excl={2873} --old: nil
D[2873].pre=nil --old: 2872
D[2874].obj={}
D[2874].obj.I={9245} --old: nil
D[2876].obj={}
D[2876].obj.I={9250} --old: nil
D[2878].hide=true --old: nil
D[2879].obj.I={9255,9256,9257,9258,9263,9306} --old: {9255,9256,9257,9258,9306}
D[2880].race=1101 --old: nil
D[2882].obj.I={9254,9275} --old: {9275}
D[2903].obj={}
D[2903].obj.I={9266} --old: nil
D[2922].pre=nil --old: 2923
D[2923].excl={2922} --old: nil
D[2925].excl={2924} --old: nil
D[2926].obj.I={9283,9284} --old: {9284}
D[2926].pre=nil --old: 2927
D[2931].excl={2930} --old: nil
D[2932].obj.I={9320,15002} --old: {9320}
D[2932].race=690 --old: nil
D[2933].obj={}
D[2933].obj.I={9321} --old: nil
D[2937].obj.I={9323,9324} --old: {9324}
D[2938].obj={}
D[2938].obj.I={9436} --old: nil
D[2941].obj={}
D[2941].obj.I={9329} --old: nil
D[2942].obj.I={9306,9307} --old: {9307}
D[2943].obj={}
D[2943].obj.I={9331} --old: nil
D[2944].obj.I={9328,9330} --old: {9330}
D[2945].start.U={6212} --old: nil
D[2945].obj={}
D[2945].obj.I={9326} --old: nil
D[2946].obj={}
D[2946].obj.I={6064} --old: nil
D[2947].obj={}
D[2947].obj.I={9362} --old: nil
D[2948].obj.I={1206,2842,9362} --old: {1206,2842}
D[2949].obj={}
D[2949].obj.I={9362} --old: nil
D[2950].obj.I={1206,2842,9362} --old: {1206,2842}
D[2950].race=690 --old: nil
D[2951].pre={4601,4602} --old: nil
D[2952].excl={4605,4606} --old: nil
D[2954].pre={2946,2966} --old: nil
D[2962].obj.I={9364,9365} --old: {9365}
D[2966].obj={}
D[2966].obj.I={6064} --old: nil
D[2967].obj={}
D[2967].obj.I={6064} --old: nil
D[2969].obj={}
D[2969].obj.I={12301} --old: nil
D[2972].obj={}
D[2972].obj.I={9368} --old: nil
D[2976].obj={}
D[2976].obj.I={9462} --old: nil
D[2977].obj={}
D[2977].obj.I={6064} --old: nil
D[2978].start.O={143980} --old: nil
D[2978].obj={}
D[2978].obj.I={9370} --old: nil
D[2981].excl={2975} --old: nil
D[2983].excl={1522,1523,2984} --old: nil
D[2983].lvl=nil --old: -1
D[2984].excl={1522,1523,2983} --old: nil
D[2984].lvl=nil --old: -1
D[2985].excl={1528,1529} --old: nil
D[2985].lvl=nil --old: -1
D[2986].lvl=nil --old: -1
D[2987].obj.I={9463,9466} --old: {9463}
D[2990].obj={}
D[2990].obj.I={9468} --old: nil
D[2996].excl={3001} --old: nil
D[2996].lvl=nil --old: -1
D[2997].excl={1642,1646,2998,2999,3000,3681} --old: nil
D[2997].lvl=nil --old: -1
D[2998].excl={1642,1646,2997,2998,3000,3681} --old: nil
D[2998].lvl=nil --old: -1
D[2999].excl={1642,1646,2997,2998,3000,3681} --old: nil
D[2999].lvl=nil --old: -1
D[3000].excl={1642,1646,2997,2998,2999,3681} --old: nil
D[3000].lvl=nil --old: -1
D[3001].excl={2996} --old: nil
D[3001].lvl=nil --old: -1
D[3002].obj={}
D[3002].obj.I={9371} --old: nil
D[3022].obj={}
D[3022].obj.I={9507} --old: nil
D[3065].obj={}
D[3065].obj.I={6488} --old: nil
D[3082].obj={}
D[3082].obj.I={9564} --old: nil
D[3083].obj={}
D[3083].obj.I={9554} --old: nil
D[3084].obj={}
D[3084].obj.I={9562} --old: nil
D[3085].obj={}
D[3085].obj.I={9561} --old: nil
D[3086].obj={}
D[3086].obj.I={9575} --old: nil
D[3087].obj={}
D[3087].obj.I={9553} --old: nil
D[3088].obj={}
D[3088].obj.I={9560} --old: nil
D[3089].obj={}
D[3089].obj.I={9568} --old: nil
D[3090].obj={}
D[3090].obj.I={9579} --old: nil
D[3091].obj={}
D[3091].obj.I={9547} --old: nil
D[3092].obj={}
D[3092].obj.I={9565} --old: nil
D[3093].obj={}
D[3093].obj.I={9552} --old: nil
D[3094].obj={}
D[3094].obj.I={9581} --old: nil
D[3095].obj={}
D[3095].obj.I={9546} --old: nil
D[3096].obj={}
D[3096].obj.I={9559} --old: nil
D[3097].obj={}
D[3097].obj.I={9569} --old: nil
D[3097].race=690 --old: nil
D[3098].obj={}
D[3098].obj.I={9574} --old: nil
D[3099].obj={}
D[3099].obj.I={9578} --old: nil
D[3100].obj={}
D[3100].obj.I={9542} --old: nil
D[3101].obj={}
D[3101].obj.I={9570} --old: nil
D[3102].obj={}
D[3102].obj.I={9555} --old: nil
D[3103].obj={}
D[3103].obj.I={9548} --old: nil
D[3104].obj={}
D[3104].obj.I={9571} --old: nil
D[3105].obj={}
D[3105].obj.I={9576} --old: nil
D[3106].obj={}
D[3106].obj.I={9543} --old: nil
D[3107].obj={}
D[3107].obj.I={9563} --old: nil
D[3108].obj={}
D[3108].obj.I={9566} --old: nil
D[3109].obj={}
D[3109].obj.I={9550} --old: nil
D[3110].obj={}
D[3110].obj.I={9556} --old: nil
D[3112].obj={}
D[3112].obj.I={9544} --old: nil
D[3113].obj={}
D[3113].obj.I={9558} --old: nil
D[3114].obj={}
D[3114].obj.I={9573} --old: nil
D[3115].obj={}
D[3115].obj.I={9577} --old: nil
D[3116].obj={}
D[3116].obj.I={9545} --old: nil
D[3117].obj={}
D[3117].obj.I={9567} --old: nil
D[3117].race=8 --old: 1101
D[3118].obj={}
D[3118].obj.I={9551} --old: nil
D[3119].obj={}
D[3119].obj.I={9557} --old: nil
D[3120].obj={}
D[3120].obj.I={9580} --old: nil
D[3121].obj={}
D[3121].obj.I={9629} --old: nil
D[3122].obj={}
D[3122].obj.I={9628} --old: nil
D[3123].obj.I={9594,9618} --old: {9594}
D[3124].obj.I={9595,9619} --old: {9595}
D[3125].obj.I={9596,9620} --old: {9596}
D[3126].obj.I={9593,9606} --old: {9593}
D[3127].obj.I={9597,9621} --old: {9597}
D[3128].pre=3122 --old: nil
D[3129].preg={3127,3128} --old: nil
D[3161].obj.I={8443,9978} --old: {8443}
D[3181].start.U={5833} --old: nil
D[3181].obj={}
D[3181].obj.I={10000,10005} --old: nil
D[3182].obj={}
D[3182].obj.I={10005} --old: nil
D[3201].obj={}
D[3201].obj.I={10022} --old: nil
D[3221].race=690 --old: nil
D[3301].obj={}
D[3301].obj.I={10414} --old: nil
D[3321].preg={2771,2772,2773} --old: nil
D[3321].skill={id=164,min=210} --old: id=164
D[3363].hide=true --old: nil
D[3364].obj={}
D[3364].obj.I={10439} --old: nil
D[3365].obj={}
D[3365].obj.I={10440} --old: nil
D[3366].obj={}
D[3366].obj.I={10441} --old: nil
D[3366].hide=true --old: nil
D[3368].obj={}
D[3368].obj.I={10443} --old: nil
D[3369].obj={}
D[3369].obj.I={10649} --old: nil
D[3370].obj={}
D[3370].obj.I={10649} --old: nil
D[3373].obj={}
D[3373].obj.I={10454} --old: nil
D[3374].start.U={5353} --old: nil
D[3374].obj.I={10455,10589} --old: {10455}
D[3375].race=1101 --old: nil
D[3376].race=690 --old: nil
D[3379].skill={id=197,min=230} --old: id=197
D[3381].hide=true --old: nil
D[3385].skill={id=197,min=226} --old: id=197
D[3402].skill={id=197,min=1} --old: id=197
D[3444].pre={3380,3445} --old: nil
D[3446].obj={}
D[3446].obj.I={10466} --old: nil
D[3449].obj.I={10445,10563,10564,10565,10566} --old: {10563,10564,10565,10566}
D[3461].obj={}
D[3461].obj.I={10445} --old: nil
D[3463].obj.I={10515} --old: nil
D[3482].obj={}
D[3482].obj.I={10590} --old: nil
D[3504].obj={}
D[3504].obj.I={10643} --old: nil
D[3504].race=690 --old: nil
D[3505].race=690 --old: nil
D[3507].obj={}
D[3507].obj.I={10597} --old: nil
D[3507].race=690 --old: nil
D[3511].obj={}
D[3511].obj.I={10610} --old: nil
D[3513].start.U={5797} --old: nil
D[3513].obj={}
D[3513].obj.I={10621} --old: nil
D[3514].obj.I={10622} --old: nil
D[3517].race=690 --old: nil
D[3518].obj={}
D[3518].obj.I={10538} --old: nil
D[3518].race=690 --old: nil
D[3519].race=1101 --old: nil
D[3520].obj.I={10699} --old: nil
D[3521].race=1101 --old: nil
D[3522].obj={}
D[3522].obj.I={10642} --old: nil
D[3522].race=1101 --old: nil
D[3523].obj={}
D[3523].obj.I={10682} --old: nil
D[3524].race=1101 --old: nil
D[3526].obj={}
D[3526].obj.I={10789} --old: nil
D[3526].excl={3629,3630,3632,3633,3634,3635,3637,4181} --old: nil
D[3526].skill={id=202,min=200} --old: id=202
D[3528].obj.I={10465,10662,10663} --old: {10662,10663}
D[3541].obj={}
D[3541].obj.I={10539} --old: nil
D[3541].race=690 --old: nil
D[3542].obj={}
D[3542].obj.I={10540} --old: nil
D[3542].race=690 --old: nil
D[3561].obj={}
D[3561].obj.I={10541} --old: nil
D[3561].race=690 --old: nil
D[3562].obj={}
D[3562].obj.I={10678} --old: nil
D[3563].obj={}
D[3563].obj.I={10680} --old: nil
D[3563].race=690 --old: nil
D[3564].obj={}
D[3564].obj.I={10679} --old: nil
D[3564].race=690 --old: nil
D[3565].obj={}
D[3565].obj.I={10681} --old: nil
D[3568].obj.I={10691,10692,10693,10694,10695} --old: {10691,10692,10693,10694}
D[3569].obj={}
D[3569].obj.I={10712} --old: nil
D[3570].race=690 --old: nil
D[3602].obj.I={10714,10834} --old: {10714}
D[3621].obj={}
D[3621].obj.I={10738} --old: nil
D[3628].obj.I={10757,10759} --old: {10759}
D[3629].obj={}
D[3629].obj.I={10789} --old: nil
D[3629].excl={3526,3630,3632,3633,3634,3635,3637,4181} --old: nil
D[3629].skill={id=202,min=200} --old: id=202
D[3630].obj={}
D[3630].obj.I={10789} --old: nil
D[3630].excl={3526,3629,3632,3633,3634,3635,3637,4181} --old: nil
D[3630].skill={id=202,min=200} --old: id=202
D[3631].lvl=nil --old: -1
D[3631].hide=true --old: nil
D[3632].obj={}
D[3632].obj.I={10789} --old: nil
D[3632].excl={3526,3629,3630,3633,3634,3635,3637,4181} --old: nil
D[3632].skill={id=202,min=200} --old: id=202
D[3633].obj={}
D[3633].obj.I={10789} --old: nil
D[3633].excl={3526,3629,3630,3632,3634,3635,3637,4181} --old: nil
D[3633].skill={id=202,min=200} --old: id=202
D[3634].obj={}
D[3634].obj.I={10789} --old: nil
D[3634].excl={3526,3629,3630,3632,3633,3635,3637,4181} --old: nil
D[3634].skill={id=202,min=200} --old: id=202
D[3635].obj={}
D[3635].obj.I={10789} --old: nil
D[3635].excl={3526,3629,3630,3632,3633,3634,3637,4181} --old: nil
D[3635].skill={id=202,min=200} --old: id=202
D[3637].obj={}
D[3637].obj.I={10789} --old: nil
D[3637].excl={3526,3629,3630,3632,3633,3634,3635,4181} --old: nil
D[3637].skill={id=202,min=200} --old: id=202
D[3638].obj.I={10792,11270} --old: {11270}
D[3638].pre={3526,3629,3633,4181} --old: nil
D[3638].excl={3640,3642} --old: nil
D[3638].skill={id=202,min=200} --old: id=202
D[3639].excl={3641,3643} --old: nil
D[3639].skill={id=202,min=200} --old: id=202
D[3640].obj.I={10793,11283} --old: {11283}
D[3640].pre={3630,3632,3634} --old: nil
D[3640].excl={3638,3642} --old: nil
D[3640].skill={id=202,min=200} --old: id=202
D[3641].excl={3639} --old: nil
D[3641].skill={id=202,min=200} --old: id=202
D[3642].obj.I={10794,11282} --old: {11282}
D[3642].pre={3635,3637} --old: nil
D[3642].excl={3638,3640} --old: nil
D[3642].skill={id=202,min=200} --old: id=202
D[3643].excl={3639} --old: nil
D[3643].skill={id=202,min=200} --old: id=202
D[3644].skill={id=202,min=200} --old: id=202
D[3645].race=1101 --old: nil
D[3645].skill={id=202,min=200} --old: id=202
D[3646].skill={id=202,min=200} --old: id=202
D[3647].skill={id=202,min=200} --old: id=202
D[3681].excl={1642,1646,2997,2998,2999,3000} --old: nil
D[3681].lvl=nil --old: -1
D[3721].preg={648,836,2767} --old: nil
D[3762].excl={936,3761,3784} --old: nil
D[3763].excl={3764,3789,3790} --old: nil
D[3765].excl={1275} --old: nil
D[3781].obj={}
D[3781].obj.I={11103} --old: nil
D[3782].obj={}
D[3782].obj.I={11103} --old: nil
D[3784].excl={936,3761,3762} --old: nil
D[3785].obj.I={11018,11020,11040} --old: {11040}
D[3786].obj.I={11018,11020,11040} --old: {11040}
D[3787].excl={3788} --old: nil
D[3787].race=1101 --old: nil
D[3788].excl={3787} --old: nil
D[3789].excl={3763,3764,3790} --old: nil
D[3790].excl={3763,3764,3789} --old: nil
D[3791].obj.I={11020,11040} --old: {11040}
D[3791].pre={3787,3788} --old: nil
D[3825].obj.I={11079} --old: nil
D[3841].obj={}
D[3841].obj.I={11102} --old: nil
D[3843].obj={}
D[3843].obj.I={11471} --old: nil
D[3845].obj.I={11104,11105,11106,11107} --old: {11104,11105,11106}
D[3861].hide=true --old: nil
D[3883].obj.I={11131,11132} --old: {11131}
D[3884].obj={}
D[3884].obj.I={11116} --old: nil
D[3903].pre=18 --old: 33
D[3905].obj={}
D[3905].obj.I={11125} --old: nil
D[3908].obj={}
D[3908].obj.I={11133} --old: nil
D[3912].obj={}
D[3912].obj.I={11136} --old: nil
D[3913].obj={}
D[3913].obj.I={11136} --old: nil
D[3914].obj={}
D[3914].obj.I={11162} --old: nil
D[3921].obj={}
D[3921].obj.I={11142} --old: nil
D[3923].obj={}
D[3923].obj.I={11146} --old: nil
D[3961].obj.I={11522} --old: nil
D[3962].obj.I={11179,11522} --old: {11179}
D[4005].obj.I={11522,11617} --old: {11522}
D[4022].excl={4023} --old: nil
D[4023].excl={4022} --old: nil
D[4024].obj.I={11230,11231} --old: {11230}
D[4024].pre={4022,4023} --old: 4023
D[4062].obj={}
D[4062].obj.I={11267} --old: nil
D[4083].skill={id=186,min=230} --old: id=nil
D[4103].pre={5882,5883,5884,5885,5886} --old: 4101
D[4104].pre={5882,5883,5884,5885,5886} --old: 4101
D[4104].skill={id=186,min=1} --old: id=186
D[4105].pre={5882,5883,5884,5885,5886} --old: 4101
D[4105].skill={id=182,min=1} --old: id=182
D[4106].pre={5882,5883,5884,5885,5886} --old: 4101
D[4106].skill={id=393,min=1} --old: id=393
D[4107].pre={5882,5883,5884,5885,5886} --old: 4101
D[4107].skill={id=333,min=1} --old: id=333
D[4108].start.U={9529} --old: {9528}
D[4108]['end'].U={9529} --old: {9528}
D[4108].pre={5887,5888,5889,5890,5891} --old: 4103
D[4108].race=690 --old: 1101
D[4109].start.U={9529} --old: {9528}
D[4109]['end'].U={9529} --old: {9528}
D[4109].pre={5887,5888,5889,5890,5891} --old: 4104
D[4109].race=690 --old: 1101
D[4109].skill={id=186,min=1} --old: id=186
D[4110].start.U={9529} --old: {9528}
D[4110]['end'].U={9529} --old: {9528}
D[4110].pre={5887,5888,5889,5890,5891} --old: 4105
D[4110].race=690 --old: 1101
D[4110].skill={id=182,min=1} --old: id=182
D[4111].start.U={9529} --old: {9528}
D[4111]['end'].U={9529} --old: {9528}
D[4111].pre={5887,5888,5889,5890,5891} --old: 4106
D[4111].race=690 --old: 1101
D[4111].skill={id=393,min=1} --old: id=393
D[4112].start.U={9529} --old: {9528}
D[4112]['end'].U={9529} --old: {9528}
D[4112].pre={5887,5888,5889,5890,5891} --old: 4107
D[4112].race=690 --old: 1101
D[4112].skill={id=333,min=1} --old: id=333
D[4113].hide=true --old: nil
D[4114].hide=true --old: nil
D[4115].hide=true --old: nil
D[4116].hide=true --old: nil
D[4117].hide=true --old: nil
D[4118].hide=true --old: nil
D[4119].hide=true --old: nil
D[4122].obj.I={11286} --old: nil
D[4122].pre=4082 --old: nil
D[4122].race=690 --old: nil
D[4127].obj={}
D[4127].obj.I={11462} --old: nil
D[4129].obj={}
D[4129].obj.I={11462} --old: nil
D[4133].excl={4134} --old: nil
D[4133].race=690 --old: nil
D[4134].pre=nil --old: 4133
D[4134].race=690 --old: nil
D[4135].obj={}
D[4135].obj.I={11463} --old: nil
D[4142].obj={}
D[4142].obj.I={11316} --old: nil
D[4146].obj.I={11318,11319} --old: {11318}
D[4161].race=1101 --old: nil
D[4161].skill={id=185,min=1} --old: id=185
D[4181].obj={}
D[4181].obj.I={10789} --old: nil
D[4181].excl={3526,3629,3630,3632,3633,3634,3635,3637} --old: nil
D[4181].skill={id=202,min=200} --old: id=202
D[4183].obj={}
D[4183].obj.I={11366} --old: nil
D[4184].obj={}
D[4184].obj.I={11367} --old: nil
D[4186].obj={}
D[4186].obj.I={11368} --old: nil
D[4201].obj.I={8846,11405,11412,11413} --old: {8846,11405,11413}
D[4221].hide=true --old: nil
D[4222].hide=true --old: nil
D[4264].obj={}
D[4264].obj.I={11446} --old: nil
D[4267].obj={}
D[4267].obj.I={11466} --old: nil
D[4281].obj={}
D[4281].obj.I={11463} --old: nil
D[4292].obj.I={11510,11568} --old: {11510}
D[4295].hide=true --old: nil
D[4300].race=690 --old: nil
D[4321].preg={4285,4287,4288} --old: nil
D[4343].hide=true --old: nil
D[4401].hide=true --old: nil
D[4402].race=690 --old: nil
D[4403].hide=true --old: nil
D[4441].obj.I={5646,11682} --old: {5646}
D[4443].hide=true --old: nil
D[4444].hide=true --old: nil
D[4445].hide=true --old: nil
D[4446].hide=true --old: nil
D[4447].hide=true --old: nil
D[4448].hide=true --old: nil
D[4451].obj={}
D[4451].obj.I={11818} --old: nil
D[4461].hide=true --old: nil
D[4462].hide=true --old: nil
D[4464].hide=true --old: nil
D[4465].hide=true --old: nil
D[4466].hide=true --old: nil
D[4467].hide=true --old: nil
D[4485].excl={1661,4486} --old: nil
D[4486].excl={1661,4485} --old: nil
D[4487].lvl=nil --old: -1
D[4487].hide=true --old: nil
D[4488].lvl=nil --old: -1
D[4488].hide=true --old: nil
D[4489].lvl=nil --old: -1
D[4489].hide=true --old: nil
D[4490].lvl=nil --old: -1
D[4490].hide=true --old: nil
D[4491].obj.I={11804} --old: nil
D[4492].obj={}
D[4492].obj.I={15722} --old: nil
D[4493].pre=4267 --old: nil
D[4493].race=1101 --old: nil
D[4494].pre={32,7732} --old: nil
D[4494].race=690 --old: nil
D[4495].race=1101 --old: nil
D[4496].pre={4493,4494} --old: nil
D[4505].obj.I={12566,12567} --old: {12567}
D[4506].obj.I={12565} --old: nil
D[4507].obj.I={11833,11835} --old: {11835}
D[4508].obj={}
D[4508].obj.I={11844} --old: nil
D[4509].obj={}
D[4509].obj.I={11844} --old: nil
D[4510].obj={}
D[4510].obj.I={11843} --old: nil
D[4511].obj={}
D[4511].obj.I={11843} --old: nil
D[4512].obj.I={11912,11947,11949} --old: {11947,11949}
D[4513].obj.I={11954,11955} --old: {11954}
D[4542].obj={}
D[4542].obj.I={11886} --old: nil
D[4542].excl={4841} --old: nil
D[4581].obj={}
D[4581].obj.I={12060} --old: nil
D[4581].excl={1011} --old: nil
D[4601].pre={2951,4602} --old: nil
D[4602].pre={2951,4601} --old: nil
D[4603].hide=true --old: nil
D[4604].hide=true --old: nil
D[4605].excl={2952,4606} --old: nil
D[4606].excl={2952,4605} --old: nil
D[4621].pre=1036 --old: nil
D[4621].repu={id=87,min=3000} --old: id=nil
D[4641].excl={788} --old: nil
D[4642].obj.I={12288,12291} --old: {12291}
D[4642].preg={4293,4294} --old: nil
D[4681].race=1101 --old: nil
D[4701].race=1101 --old: nil
D[4722].obj={}
D[4722].obj.I={12289} --old: nil
D[4723].obj={}
D[4723].obj.I={12242} --old: nil
D[4725].obj={}
D[4725].obj.I={12292} --old: nil
D[4726].obj.I={12283,12284} --old: {12283}
D[4727].obj={}
D[4727].obj.I={12289} --old: nil
D[4728].obj={}
D[4728].obj.I={12242} --old: nil
D[4729].obj.I={12262,12263} --old: {12263}
D[4730].obj={}
D[4730].obj.I={12242} --old: nil
D[4731].obj={}
D[4731].obj.I={12292} --old: nil
D[4732].obj={}
D[4732].obj.I={12289} --old: nil
D[4733].obj={}
D[4733].obj.I={12242} --old: nil
D[4734].obj={}
D[4734].obj.I={12286} --old: nil
D[4735].obj.I={12241,12287} --old: {12241}
D[4736].excl={4737,4738,4739} --old: nil
D[4737].excl={4736,4738,4739} --old: nil
D[4738].excl={4736,4737,4739} --old: nil
D[4739].excl={4736,4737,4738} --old: nil
D[4740].race=1101 --old: nil
D[4743].obj.I={12324,12339} --old: {12324}
D[4761].race=1101 --old: nil
D[4762].obj.I={12349,12350} --old: {12349}
D[4762].race=1101 --old: nil
D[4763].obj.I={12341,12342,12343,12346,12347,12355} --old: {12341,12342,12343,12355}
D[4763].race=1101 --old: nil
D[4764].pre=nil --old: 4766
D[4765].obj={}
D[4765].obj.I={12437} --old: nil
D[4766].excl={4764} --old: nil
D[4768].pre=nil --old: 4769
D[4768].race=690 --old: nil
D[4769].excl={4768} --old: nil
D[4769].race=690 --old: nil
D[4771].obj.I={12368} --old: nil
D[4785].pre=nil --old: 4783
D[4808].obj={}
D[4808].obj.I={12438} --old: nil
D[4810].obj={}
D[4810].obj.I={12445} --old: nil
D[4812].obj.I={14338,14339} --old: {14339}
D[4822].hide=true --old: nil
D[4841].pre=nil --old: 4542
D[4867].obj.I={12712,12730} --old: {12712}
D[4881].start.U={10617} --old: nil
D[4881].obj={}
D[4881].obj.I={12564} --old: nil
D[4882].obj={}
D[4882].obj.I={12558} --old: nil
D[4883].obj={}
D[4883].obj.I={12558} --old: nil
D[4903].obj.I={12562,12563} --old: {12562}
D[4907].excl={4734} --old: nil
D[4962].obj.I={12647,12648} --old: {12648}
D[4962].excl={4963} --old: nil
D[4963].obj.I={12646,12649} --old: {12649}
D[4963].excl={4962} --old: nil
D[4964].excl={4975} --old: nil
D[4965].excl={4967,4968,4969} --old: nil
D[4967].excl={4965,4968,4969} --old: nil
D[4967].race=690 --old: 1101
D[4968].excl={4965,4967,4969} --old: nil
D[4968].race=1101 --old: 690
D[4969].excl={4965,4967,4968} --old: nil
D[4971].obj.I={12627} --old: nil
D[4975].excl={4964} --old: nil
D[4976].obj={}
D[4976].obj.I={12642} --old: nil
D[4981].race=690 --old: nil
D[4983].obj={}
D[4983].obj.I={12652} --old: nil
D[4986].obj={}
D[4986].obj.I={12663} --old: nil
D[4987].obj={}
D[4987].obj.I={12663} --old: nil
D[5002].obj={}
D[5002].obj.I={12770} --old: nil
D[5022].obj={}
D[5022].obj.I={12724} --old: nil
D[5023].obj={}
D[5023].obj.I={12724} --old: nil
D[5041].pre=nil --old: 871
D[5047].obj={}
D[5047].obj.I={12710} --old: nil
D[5048].obj={}
D[5048].obj.I={12724} --old: nil
D[5049].obj={}
D[5049].obj.I={12724} --old: nil
D[5050].obj={}
D[5050].obj.I={12721} --old: nil
D[5050].pre={5048,5049} --old: nil
D[5051].obj.I={12721,12722,12723} --old: {12722,12723}
D[5056].obj.I={12733} --old: nil
D[5059].pre=5058 --old: nil
D[5060].pre=5059 --old: nil
D[5061].obj={}
D[5061].obj.I={15885} --old: nil
D[5061].lvl=nil --old: -1
D[5066].excl={5090,5091} --old: nil
D[5082].pre=nil --old: 6603
D[5083].obj={}
D[5083].obj.I={12771} --old: nil
D[5085].obj={}
D[5085].obj.I={12813} --old: nil
D[5088].obj.I={12785,12925} --old: {12925}
D[5089].start.U={9568} --old: nil
D[5089].obj={}
D[5089].obj.I={12780} --old: nil
D[5090].excl={5066,5091} --old: nil
D[5091].excl={5066,5090} --old: nil
D[5092].pre={5066,5090,5091} --old: nil
D[5093].excl={5094,5095} --old: nil
D[5094].excl={5093,5095} --old: nil
D[5095].excl={5093,5094} --old: nil
D[5096].obj.I={12807,12814} --old: {12814}
D[5096].pre={5093,5094,5095} --old: nil
D[5097].obj.I={12815} --old: nil
D[5098].obj.I={12815} --old: nil
D[5103].skill={id=164,min=275} --old: id=164
D[5123].start.U={10738} --old: nil
D[5123].obj={}
D[5123].obj.I={12842} --old: nil
D[5124].skill={id=164,min=275} --old: id=nil
D[5126].skill={id=164,min=285} --old: id=164
D[5127].obj.I={12806,12847,12848} --old: {12806,12847}
D[5127].skill={id=164,min=285} --old: id=164
D[5128].obj={}
D[5128].obj.I={12842} --old: nil
D[5141].excl={5143,5144} --old: nil
D[5141].skill={id=165,min=225} --old: id=165
D[5142].excl={5601} --old: nil
D[5143].excl={5141,5144} --old: nil
D[5143].skill={id=165,min=225} --old: id=165
D[5144].excl={5141,5143} --old: nil
D[5144].skill={id=165,min=225} --old: id=165
D[5145].excl={5146,5148} --old: nil
D[5145].skill={id=165,min=225} --old: id=165
D[5146].excl={5145,5148} --old: nil
D[5146].skill={id=165,min=225} --old: id=165
D[5148].excl={5145,5146} --old: nil
D[5148].skill={id=165,min=225} --old: id=165
D[5149].pre={5142,5601} --old: nil
D[5151].obj.I={12942,12946} --old: {12946}
D[5157].obj.I={12907,12922} --old: {12907}
D[5158].obj={}
D[5158].obj.I={12907} --old: nil
D[5159].obj.I={12906} --old: nil
D[5160].obj={}
D[5160].obj.I={12923} --old: nil
D[5163].obj.I={12928} --old: nil
D[5165].obj.I={12906} --old: nil
D[5201].repu={id=589,min=1500} --old: id=nil
D[5202].obj={}
D[5202].obj.I={13140} --old: nil
D[5206].obj.I={13155,13156,13157} --old: {13155,13157}
D[5206].preg={5154,5168} --old: nil
D[5210].obj={}
D[5210].obj.I={13202} --old: nil
D[5211].pre=nil --old: 5241
D[5216].obj.I={13186,13194} --old: {13194}
D[5217].obj={}
D[5217].obj.I={13190} --old: nil
D[5218].pre={5217,5230} --old: nil
D[5219].obj.I={13187,13195} --old: {13195}
D[5220].obj={}
D[5220].obj.I={13191} --old: nil
D[5221].pre={5220,5232} --old: nil
D[5222].obj.I={13188,13197} --old: {13197}
D[5223].obj={}
D[5223].obj.I={13192} --old: nil
D[5224].pre={5223,5234} --old: nil
D[5225].obj.I={13189,13196} --old: {13196}
D[5226].obj={}
D[5226].obj.I={13193} --old: nil
D[5227].pre={5226,5236} --old: nil
D[5229].obj.I={13186,13194} --old: {13194}
D[5230].obj={}
D[5230].obj.I={13190} --old: nil
D[5231].obj.I={13187,13195} --old: {13195}
D[5232].obj={}
D[5232].obj.I={13191} --old: nil
D[5233].obj.I={13188,13197} --old: {13197}
D[5234].obj={}
D[5234].obj.I={13192} --old: nil
D[5235].obj.I={13189,13196} --old: {13196}
D[5236].obj={}
D[5236].obj.I={13193} --old: nil
D[5237].excl=nil --old: nil
D[5237].race=1101 --old: 690
D[5238].excl=nil --old: nil
D[5238].race=690 --old: 1101
D[5245].obj.I={12891,12896,12897,12898,12899} --old: {12896,12897,12898,12899}
D[5247].obj.I={11562,12655,16973,16974} --old: {11562,12655,16973}
D[5248].obj={}
D[5248].obj.I={13347} --old: nil
D[5249].excl={5250} --old: nil
D[5250].excl={5249} --old: nil
D[5252].obj={}
D[5252].obj.I={13347} --old: nil
D[5253].obj={}
D[5253].obj.I={13347} --old: nil
D[5261].excl={33} --old: nil
D[5262].start.U={10813} --old: nil
D[5262].obj={}
D[5262].obj.I={13250} --old: nil
D[5282].obj.I={13289} --old: nil
D[5283].excl={5284} --old: nil
D[5283].skill={id=164,min=200} --old: id=164
D[5284].excl={5283} --old: nil
D[5284].skill={id=164,min=200} --old: id=164
D[5301].excl={5302} --old: nil
D[5301].skill={id=164,min=200} --old: id=164
D[5302].excl={5301} --old: nil
D[5302].skill={id=164,min=200} --old: id=164
D[5305].skill={id=164,min=250} --old: id=164
D[5306].skill={id=164,min=250} --old: id=164
D[5307].skill={id=164,min=250} --old: id=164
D[5321].race=1101 --old: nil
D[5342].race=690 --old: nil
D[5361].obj={}
D[5361].obj.I={13507} --old: nil
D[5381].obj.I={13542,14523} --old: {13542}
D[5383].hide=true --old: nil
D[5384].obj.I={13523} --old: nil
D[5385].obj={}
D[5385].obj.I={13562} --old: nil
D[5401].race=1101 --old: nil
D[5405].race=690 --old: nil
D[5421].lvl=25 --old: 1
D[5441].obj.I={16114} --old: nil
D[5441].race=690 --old: nil
D[5462].obj={}
D[5462].obj.I={13585} --old: nil
D[5463].obj={}
D[5463].obj.I={13585} --old: nil
D[5464].obj={}
D[5464].obj.I={13624} --old: nil
D[5465].obj={}
D[5465].obj.I={13624} --old: nil
D[5466].obj.I={13626,13752} --old: {13626}
D[5502].preg={915,925} --old: nil
D[5502].hide=true --old: nil
D[5504].excl={5507,5513} --old: nil
D[5504].repu={id=529,min=21000} --old: id=nil
D[5507].excl={5504,5513} --old: nil
D[5507].repu={id=529,min=21000} --old: id=nil
D[5513].excl={5504,5507} --old: nil
D[5513].repu={id=529,min=21000} --old: id=nil
D[5514].obj={}
D[5514].obj.I={14628} --old: nil
D[5517].excl={5521,5524} --old: nil
D[5517].repu={id=529,min=42000} --old: id=nil
D[5521].excl={5517,5524} --old: nil
D[5521].repu={id=529,min=42000} --old: id=nil
D[5522].obj={}
D[5522].obj.I={13761} --old: nil
D[5524].excl={5517,5521} --old: nil
D[5524].repu={id=529,min=42000} --old: id=nil
D[5526].obj.I={18539,18540} --old: {18540}
D[5531].obj={}
D[5531].obj.I={13761} --old: nil
D[5538].obj={}
D[5538].obj.I={14628} --old: nil
D[5561].obj.I={13892} --old: nil
D[5581].obj.I={14547} --old: nil
D[5582].start.U={10678} --old: nil
D[5582].obj={}
D[5582].obj.I={13920} --old: nil
D[5601].excl={5142} --old: nil
D[5622].lvl=5 --old: 4
D[5627].lvl=nil --old: -1
D[5627].hide=true --old: nil
D[5634].start={}
D[5634].start.U={11401} --old: nil
D[5641].lvl=nil --old: -1
D[5641].hide=true --old: nil
D[5645].lvl=nil --old: -1
D[5645].hide=true --old: nil
D[5647].start={}
D[5647].start.U={11401} --old: nil
D[5647].lvl=nil --old: -1
D[5647].hide=true --old: nil
D[5658].hide=true --old: nil
D[5663].hide=true --old: nil
D[5713].race=1101 --old: nil
D[5721].obj.I={15209} --old: nil
D[5724].obj={}
D[5724].obj.I={14381} --old: nil
D[5726].race=690 --old: nil
D[5727].obj={}
D[5727].obj.I={14544} --old: nil
D[5727].race=690 --old: nil
D[5728].race=690 --old: nil
D[5729].race=690 --old: nil
D[5730].race=690 --old: nil
D[5742].preg={5542,5543,5544} --old: nil
D[5761].race=690 --old: nil
D[5762].obj={}
D[5762].obj.I={14542} --old: nil
D[5763].obj={}
D[5763].obj.I={14546} --old: nil
D[5801].obj.I={14644,14645} --old: {14645}
D[5802].obj.I={14644,14645} --old: {14645}
D[5805].obj={}
D[5805].obj.I={14646} --old: nil
D[5805].hide=true --old: nil
D[5841].obj={}
D[5841].obj.I={14647} --old: nil
D[5841].hide=true --old: nil
D[5842].obj={}
D[5842].obj.I={14648} --old: nil
D[5842].hide=true --old: nil
D[5843].obj={}
D[5843].obj.I={14649} --old: nil
D[5843].hide=true --old: nil
D[5844].obj={}
D[5844].obj.I={14650} --old: nil
D[5844].hide=true --old: nil
D[5847].obj={}
D[5847].obj.I={14651} --old: nil
D[5847].hide=true --old: nil
D[5861].obj={}
D[5861].obj.I={14872} --old: nil
D[5862].obj={}
D[5862].obj.I={14872} --old: nil
D[5881].obj={}
D[5881].obj.I={16189} --old: nil
D[5882].start.U={9528} --old: {9529}
D[5882]['end'].U={9528} --old: {9529}
D[5882].pre=4101 --old: 4102
D[5882].excl={5883,5884,5885,5886} --old: nil
D[5882].race=1101 --old: 690
D[5883].start.U={9528} --old: {9529}
D[5883]['end'].U={9528} --old: {9529}
D[5883].pre=4101 --old: 4102
D[5883].excl={5882,5884,5885,5886} --old: nil
D[5883].race=1101 --old: 690
D[5883].skill={id=186,min=1} --old: id=186
D[5884].start.U={9528} --old: {9529}
D[5884]['end'].U={9528} --old: {9529}
D[5884].pre=4101 --old: 4102
D[5884].excl={5882,5883,5885,5886} --old: nil
D[5884].race=1101 --old: 690
D[5884].skill={id=182,min=1} --old: id=182
D[5885].start.U={9528} --old: {9529}
D[5885]['end'].U={9528} --old: {9529}
D[5885].pre=4101 --old: 4102
D[5885].excl={5882,5883,5884,5886} --old: nil
D[5885].race=1101 --old: 690
D[5885].skill={id=393,min=1} --old: id=393
D[5886].start.U={9528} --old: {9529}
D[5886]['end'].U={9528} --old: {9529}
D[5886].pre=4101 --old: 4102
D[5886].excl={5882,5883,5884,5885} --old: nil
D[5886].race=1101 --old: 690
D[5886].skill={id=333,min=1} --old: id=333
D[5887].pre=4102 --old: 5882
D[5887].excl={5888,5889,5890,5891} --old: nil
D[5888].pre=4102 --old: 5883
D[5888].excl={5887,5889,5890,5891} --old: nil
D[5888].skill={id=186,min=1} --old: id=186
D[5889].pre=4102 --old: 5884
D[5889].excl={5887,5888,5890,5891} --old: nil
D[5889].skill={id=182,min=1} --old: id=182
D[5890].pre=4102 --old: 5885
D[5890].excl={5887,5888,5889,5891} --old: nil
D[5890].skill={id=393,min=1} --old: id=393
D[5891].pre=4102 --old: 5886
D[5891].excl={5887,5888,5889,5890} --old: nil
D[5891].skill={id=333,min=1} --old: id=333
D[5892].lvl=55 --old: -1
D[5893].lvl=55 --old: -1
D[5901].obj.I={15042,15043} --old: {15043}
D[5902].obj={}
D[5902].obj.I={15044} --old: nil
D[5903].obj.I={15042,15043} --old: {15043}
D[5904].obj={}
D[5904].obj.I={15044} --old: nil
D[5921].lvl=nil --old: -1
D[5922].lvl=nil --old: -1
D[5923].excl={5924,5925} --old: nil
D[5923].lvl=nil --old: -1
D[5924].excl={5923,5925} --old: nil
D[5924].lvl=nil --old: -1
D[5925].excl={5923,5924} --old: nil
D[5925].lvl=nil --old: -1
D[5926].excl={5927,5928} --old: nil
D[5926].lvl=nil --old: -1
D[5927].excl={5926,5928} --old: nil
D[5927].lvl=nil --old: -1
D[5928].excl={5926,5927} --old: nil
D[5928].lvl=nil --old: -1
D[5929].lvl=nil --old: -1
D[5930].lvl=nil --old: -1
D[5931].lvl=nil --old: -1
D[5932].lvl=nil --old: -1
D[5941].obj={}
D[5941].obj.I={15314} --old: nil
D[5942].obj={}
D[5942].obj.I={15328} --old: nil
D[5961].race=690 --old: nil
D[5981].repu={id=589,min=9000} --old: id=nil
D[6001].obj.I={15208} --old: nil
D[6001].lvl=nil --old: -1
D[6002].obj.I={15710} --old: nil
D[6002].lvl=nil --old: -1
D[6022].obj.I={15447,15448,15454} --old: {15447,15448}
D[6022].race=690 --old: nil
D[6027].obj.I={15766,15803} --old: {15803}
D[6028].obj={}
D[6028].obj.I={15788} --old: nil
D[6029].obj={}
D[6029].obj.I={15788} --old: nil
D[6030].obj={}
D[6030].obj.I={15790} --old: nil
D[6031].repu={id=576,min=3000} --old: id=nil
D[6032].skill={id=197,min=290} --old: id=197
D[6032].repu={id=576,min=3000} --old: id=nil
D[6041].obj.I={15736} --old: nil
D[6061].obj.I={15914} --old: nil
D[6061].lvl=nil --old: -1
D[6062].obj.I={15917} --old: nil
D[6062].lvl=nil --old: -1
D[6063].obj.I={15921} --old: nil
D[6063].lvl=nil --old: -1
D[6064].obj.I={15911} --old: nil
D[6064].lvl=nil --old: -1
D[6065].excl={6061,6066,6067} --old: nil
D[6065].lvl=nil --old: -1
D[6066].excl={6061,6065,6067} --old: nil
D[6066].lvl=nil --old: -1
D[6066].hide=true --old: nil
D[6067].excl={6061,6065,6066} --old: nil
D[6067].lvl=nil --old: -1
D[6068].start.U={3407} --old: {3154}
D[6068].excl={6062,6069,6070} --old: nil
D[6068].lvl=nil --old: -1
D[6069].start.U={11814} --old: {3407}
D[6069].excl={6062,6068,6070} --old: nil
D[6069].lvl=nil --old: -1
D[6070].start={}
D[6070].start.U={3038} --old: nil
D[6070].excl={6062,6068,6069} --old: nil
D[6070].lvl=nil --old: -1
D[6071].excl={6063,6072,6073,6721,6722} --old: nil
D[6071].lvl=nil --old: -1
D[6072].excl={6063,6071,6073,6721,6722} --old: nil
D[6072].lvl=nil --old: -1
D[6072].hide=true --old: nil
D[6073].start.U={5515} --old: {4205}
D[6073].excl={6063,6071,6072,6721,6722} --old: nil
D[6073].lvl=nil --old: -1
D[6074].start.U={5516} --old: {895}
D[6074].excl={6064,6075,6076} --old: nil
D[6074].lvl=nil --old: -1
D[6075].start.U={11807} --old: {5117}
D[6075].excl={6064,6074,6076} --old: nil
D[6075].lvl=nil --old: -1
D[6076].excl={6064,6074,6075} --old: nil
D[6076].lvl=nil --old: -1
D[6081].lvl=nil --old: -1
D[6082].obj.I={15920} --old: nil
D[6082].lvl=nil --old: -1
D[6083].obj.I={15919} --old: nil
D[6083].lvl=nil --old: -1
D[6084].obj.I={15913} --old: nil
D[6084].lvl=nil --old: -1
D[6085].obj.I={15908} --old: nil
D[6085].lvl=nil --old: -1
D[6086].lvl=nil --old: -1
D[6087].obj.I={15915} --old: nil
D[6087].lvl=nil --old: -1
D[6088].obj.I={15916} --old: nil
D[6088].lvl=nil --old: -1
D[6089].lvl=nil --old: -1
D[6101].obj.I={15922} --old: nil
D[6101].lvl=nil --old: -1
D[6102].obj.I={15923} --old: nil
D[6102].lvl=nil --old: -1
D[6103].lvl=nil --old: -1
D[6121].lvl=nil --old: -1
D[6122].obj.I={15844,15845} --old: {15845}
D[6122].lvl=nil --old: -1
D[6123].lvl=nil --old: -1
D[6124].obj.I={15826} --old: nil
D[6124].lvl=nil --old: -1
D[6125].lvl=nil --old: -1
D[6127].obj.I={15842,15843} --old: {15843}
D[6127].lvl=nil --old: -1
D[6128].lvl=nil --old: -1
D[6129].obj.I={15826} --old: nil
D[6129].lvl=nil --old: -1
D[6130].lvl=nil --old: -1
D[6131].hide=true --old: nil
D[6133].race=690 --old: nil
D[6134].obj.I={15848,15849} --old: {15849}
D[6135].race=690 --old: nil
D[6136].pre=6133 --old: nil
D[6141].excl={261} --old: nil
D[6144].preg={6022,6042,6133,6135,6136} --old: nil
D[6144].race=690 --old: nil
D[6146].obj.I={13852,15876} --old: {13852}
D[6148].race=690 --old: nil
D[6163].preg={6022,6042,6133,6135,6136} --old: nil
D[6181].obj={}
D[6181].obj.I={15998} --old: nil
D[6221].hide=true --old: nil
D[6241].hide=true --old: nil
D[6261].obj={}
D[6261].obj.I={16115} --old: nil
D[6281].obj={}
D[6281].obj.I={15998} --old: nil
D[6285].obj={}
D[6285].obj.I={16115} --old: nil
D[6321].obj={}
D[6321].obj.I={16209} --old: nil
D[6322].obj={}
D[6322].obj.I={16210} --old: nil
D[6323].obj={}
D[6323].obj.I={16209} --old: nil
D[6324].obj={}
D[6324].obj.I={16210} --old: nil
D[6341].obj={}
D[6341].obj.I={16262} --old: nil
D[6341].race=8 --old: 1101
D[6342].obj={}
D[6342].obj.I={16262} --old: nil
D[6342].race=8 --old: 1101
D[6343].obj={}
D[6343].obj.I={16263} --old: nil
D[6343].race=8 --old: 1101
D[6344].race=8 --old: 1101
D[6361].obj={}
D[6361].obj.I={16282} --old: nil
D[6362].obj={}
D[6362].obj.I={16282} --old: nil
D[6363].obj={}
D[6363].obj.I={16283} --old: nil
D[6364].obj={}
D[6364].obj.I={16283} --old: nil
D[6365].obj={}
D[6365].obj.I={16306} --old: nil
D[6381].obj.I={16208} --old: nil
D[6382].pre=882 --old: nil
D[6382].excl={235,742} --old: nil
D[6383].pre=nil --old: nil
D[6384].obj={}
D[6384].obj.I={16306} --old: nil
D[6385].obj={}
D[6385].obj.I={16307} --old: nil
D[6386].obj={}
D[6386].obj.I={16307} --old: nil
D[6387].obj={}
D[6387].obj.I={16310} --old: nil
D[6388].obj={}
D[6388].obj.I={16311} --old: nil
D[6389].obj={}
D[6389].obj.I={15044} --old: nil
D[6390].obj={}
D[6390].obj.I={15044} --old: nil
D[6391].obj={}
D[6391].obj.I={16310} --old: nil
D[6392].obj={}
D[6392].obj.I={16311} --old: nil
D[6394].race=690 --old: nil
D[6481].obj.I={16603} --old: nil
D[6501].obj={}
D[6501].obj.I={16662} --old: nil
D[6522].start.U={4421} --old: nil
D[6522].obj={}
D[6522].obj.I={17008} --old: nil
D[6541].excl={6542} --old: nil
D[6542].excl={6541} --old: nil
D[6543].obj.I={16763,16764,16765,16783} --old: {16763,16764,16765}
D[6562].excl={6563} --old: nil
D[6563].pre=nil --old: 6562
D[6564].start.U={4802} --old: nil
D[6564].obj={}
D[6564].obj.I={16790} --old: nil
D[6568].obj={}
D[6568].obj.I={16785} --old: nil
D[6570].obj.I={16787} --old: nil
D[6585].preg={6582,6583,6584} --old: nil
D[6601].obj={}
D[6601].obj.I={16888} --old: nil
D[6603].excl={5082} --old: nil
D[6604].excl={4861} --old: nil
D[6605].excl={4505} --old: nil
D[6606].hide=true --old: nil
D[6607].skill={id=356,min=225} --old: id=356
D[6608].excl={6607} --old: nil
D[6608].skill={id=356,min=225} --old: id=356
D[6609].excl={6607} --old: nil
D[6609].skill={id=356,min=225} --old: id=356
D[6610].skill={id=185,min=225} --old: id=185
D[6611].excl={6610} --old: nil
D[6611].skill={id=185,min=225} --old: id=185
D[6612].excl={6610} --old: nil
D[6612].skill={id=185,min=225} --old: id=185
D[6621].obj.I={16972,16976} --old: {16976}
D[6622].obj={}
D[6622].obj.I={16991} --old: nil
D[6622].skill={id=129,min=225} --old: id=129
D[6623].excl={6622} --old: nil
D[6623].skill={id=129,min=225} --old: id=129
D[6624].obj={}
D[6624].obj.I={16991} --old: nil
D[6624].skill={id=129,min=225} --old: id=129
D[6625].excl={6624} --old: nil
D[6625].skill={id=129,min=225} --old: id=129
D[6642].repu={id=59,min=9000} --old: id=nil
D[6643].repu={id=59,min=9000} --old: id=nil
D[6644].repu={id=59,min=9000} --old: id=nil
D[6645].repu={id=59,min=9000} --old: id=nil
D[6646].repu={id=59,min=9000} --old: id=nil
D[6661].obj.I={17117} --old: nil
D[6662].obj={}
D[6662].obj.I={17118} --old: nil
D[6681].obj.I={17125,17126} --old: nil
D[6701].repu={id=349,min=0} --old: id=nil
D[6721].start.U={5116} --old: {5117}
D[6721].excl={6063,6071,6072,6073,6722} --old: nil
D[6721].lvl=nil --old: -1
D[6722].start.U={1231} --old: {5515}
D[6722].excl={6063,6071,6072,6073,6721} --old: nil
D[6722].lvl=nil --old: -1
D[6741].lvl=nil --old: -1
D[6761].pre={1015,1019,1047} --old: nil
D[6762].pre={1015,1019,1047,6761} --old: 6761
D[6781].lvl=nil --old: -1
D[6801].lvl=nil --old: -1
D[6804].obj.I={17309,17310} --old: {17309}
D[6821].preg={6804,6805} --old: nil
D[6825].lvl=nil --old: -1
D[6826].lvl=nil --old: -1
D[6827].lvl=nil --old: -1
D[6844].obj={}
D[6844].obj.I={17346} --old: nil
D[6846].lvl=nil --old: -1
D[6847].hide=true --old: nil
D[6848].hide=true --old: nil
D[6881].lvl=nil --old: -1
D[6901].lvl=nil --old: -1
D[6922].start.U={12876} --old: nil
D[6922].obj={}
D[6922].obj.I={16782} --old: nil
D[6941].lvl=nil --old: -1
D[6942].lvl=nil --old: -1
D[6943].lvl=nil --old: -1
D[6961].excl={7021,7024} --old: nil
D[6961].lvl=nil --old: -1
D[6961].hide=true --old: nil
D[6962].lvl=nil --old: -1
D[6962].hide=true --old: nil
D[6963].lvl=nil --old: -1
D[6963].hide=true --old: nil
D[6964].lvl=nil --old: -1
D[6964].hide=true --old: nil
D[6981].start.U={3654} --old: nil
D[6981].obj={}
D[6981].obj.I={10441} --old: nil
D[6982].lvl=55 --old: -1
D[6983].lvl=nil --old: -1
D[6983].hide=true --old: nil
D[6984].lvl=nil --old: -1
D[6984].hide=true --old: nil
D[6985].lvl=55 --old: -1
D[7001].obj.I={17626} --old: nil
D[7001].lvl=nil --old: -1
D[7002].lvl=nil --old: -1
D[7003].obj.I={18904,18956} --old: {18956}
D[7021]['end'].U={13445} --old: {13444}
D[7021].excl={6961,7024} --old: nil
D[7021].lvl=nil --old: -1
D[7021].hide=true --old: nil
D[7022].excl={7023} --old: nil
D[7022].lvl=nil --old: -1
D[7022].hide=true --old: nil
D[7023].start.U={13435} --old: {13435,23010}
D[7023].excl={7022} --old: nil
D[7023].lvl=nil --old: -1
D[7023].hide=true --old: nil
D[7024].excl={6961,7021} --old: nil
D[7024].lvl=nil --old: -1
D[7024].hide=true --old: nil
D[7025].lvl=nil --old: -1
D[7025].hide=true --old: nil
D[7026].lvl=nil --old: -1
D[7027].obj.I={17689} --old: nil
D[7027].lvl=nil --old: -1
D[7029].obj.I={17693,17696} --old: {17696}
D[7041].obj.I={17693,17696} --old: {17696}
D[7042].lvl=nil --old: -1
D[7042].hide=true --old: nil
D[7043].lvl=nil --old: -1
D[7043].hide=true --old: nil
D[7045].lvl=nil --old: -1
D[7045].hide=true --old: nil
D[7061].obj={}
D[7061].obj.I={17735} --old: nil
D[7061].lvl=nil --old: -1
D[7061].hide=true --old: nil
D[7062].start.U={1365} --old: {1365,10877}
D[7062].lvl=nil --old: -1
D[7062].hide=true --old: nil
D[7063].obj={}
D[7063].obj.I={17735} --old: nil
D[7063].lvl=nil --old: -1
D[7063].hide=true --old: nil
D[7066].obj={}
D[7066].obj.I={17760} --old: nil
D[7067].obj.I={17757,17758,17781} --old: {17757,17758}
D[7081].lvl=nil --old: -1
D[7082].lvl=nil --old: -1
D[7101].lvl=nil --old: -1
D[7102].lvl=nil --old: -1
D[7121].excl={7122} --old: nil
D[7121].lvl=nil --old: -1
D[7122].lvl=nil --old: -1
D[7123].excl={7124} --old: nil
D[7123].lvl=nil --old: -1
D[7124].lvl=nil --old: -1
D[7141].lvl=nil --old: -1
D[7142].lvl=nil --old: -1
D[7161].lvl=nil --old: -1
D[7161].repu={id=729,min=0} --old: id=nil
D[7162].lvl=nil --old: -1
D[7162].repu={id=730,min=0} --old: id=nil
D[7163].lvl=nil --old: -1
D[7163].repu={id=729,min=3000} --old: id=nil
D[7164].lvl=nil --old: -1
D[7164].repu={id=729,min=9000} --old: id=nil
D[7165].lvl=nil --old: -1
D[7165].repu={id=729,min=21000} --old: id=nil
D[7166].lvl=nil --old: -1
D[7166].repu={id=729,min=42000} --old: id=nil
D[7167].lvl=nil --old: -1
D[7167].repu={id=729,min=42999} --old: id=nil
D[7168].lvl=nil --old: -1
D[7168].repu={id=730,min=3000} --old: id=nil
D[7169].lvl=nil --old: -1
D[7169].repu={id=730,min=9000} --old: id=nil
D[7170].lvl=nil --old: -1
D[7170].repu={id=730,min=21000} --old: id=nil
D[7171].lvl=nil --old: -1
D[7171].repu={id=730,min=42000} --old: id=nil
D[7172].lvl=nil --old: -1
D[7172].repu={id=730,min=42999} --old: id=nil
D[7201].pre=3906 --old: nil
D[7221].hide=true --old: nil
D[7222].hide=true --old: nil
D[7223].lvl=nil --old: -1
D[7224].lvl=nil --old: -1
D[7241].excl={7161} --old: nil
D[7241].lvl=nil --old: -1
D[7261].excl={7162} --old: nil
D[7261].lvl=nil --old: -1
D[7281].lvl=nil --old: -1
D[7282].lvl=nil --old: -1
D[7301].lvl=nil --old: -1
D[7302].lvl=nil --old: -1
D[7321].skill={id=185,min=1} --old: id=185
D[7364].hide=true --old: nil
D[7365].hide=true --old: nil
D[7367].lvl=nil --old: -1
D[7367].hide=true --old: nil
D[7368].lvl=nil --old: -1
D[7368].hide=true --old: nil
D[7383].obj.I={18151,18152} --old: {18151}
D[7383].race=1101 --old: nil
D[7385].lvl=nil --old: -1
D[7386].lvl=nil --old: -1
D[7401].hide=true --old: nil
D[7402].hide=true --old: nil
D[7421].hide=true --old: nil
D[7422].hide=true --old: nil
D[7423].hide=true --old: nil
D[7425].hide=true --old: nil
D[7426].race=1101 --old: nil
D[7426].hide=true --old: nil
D[7427].race=690 --old: nil
D[7427].hide=true --old: nil
D[7428].race=1101 --old: nil
D[7428].hide=true --old: nil
D[7462].hide=true --old: nil
D[7463].lvl=nil --old: -1
D[7483].pre={7481,7482} --old: nil
D[7484].pre={7481,7482} --old: nil
D[7485].pre={7481,7482} --old: nil
D[7488].pre=nil --old: 7494
D[7489].pre=nil --old: 7492
D[7490].obj={}
D[7490].obj.I={18422} --old: nil
D[7492].start.U={10879,10880,10881} --old: {10880}
D[7493].skill={id=165,min=300} --old: id=165
D[7494].start.U={2198,10877,10878} --old: {10877}
D[7495].obj={}
D[7495].obj.I={18423} --old: nil
D[7497].skill={id=165,min=300} --old: id=165
D[7498].obj={}
D[7498].obj.I={18356} --old: nil
D[7499].obj={}
D[7499].obj.I={18357} --old: nil
D[7500].obj={}
D[7500].obj.I={18358} --old: nil
D[7501].obj={}
D[7501].obj.I={18359} --old: nil
D[7502].obj={}
D[7502].obj.I={18360} --old: nil
D[7503].obj={}
D[7503].obj.I={18361} --old: nil
D[7504].obj={}
D[7504].obj.I={18362} --old: nil
D[7505].obj={}
D[7505].obj.I={18363} --old: nil
D[7506].obj={}
D[7506].obj.I={18364} --old: nil
D[7507].obj={}
D[7507].obj.I={18401} --old: nil
D[7507].class=3 --old: nil
D[7508].obj={}
D[7508].obj.I={18513} --old: nil
D[7508].class=3 --old: nil
D[7509].obj.I={18489,18492} --old: {18492}
D[7509].class=3 --old: nil
D[7521].hide=true --old: nil
D[7522].obj={}
D[7522].obj.I={18565} --old: nil
D[7562].lvl=nil --old: -1
D[7563].lvl=nil --old: -1
D[7564].obj={}
D[7564].obj.I={18591} --old: nil
D[7564].lvl=nil --old: -1
D[7581].lvl=nil --old: -1
D[7582].lvl=nil --old: -1
D[7583].obj.I={18601,18605} --old: {18605}
D[7583].lvl=nil --old: -1
D[7601].lvl=nil --old: -1
D[7602].lvl=nil --old: -1
D[7603].obj.I={18625,18626} --old: {18625}
D[7603].lvl=nil --old: -1
D[7604].obj.I={17203,18628} --old: {17203}
D[7623].lvl=nil --old: -1
D[7624].lvl=nil --old: -1
D[7625].lvl=nil --old: -1
D[7626].lvl=nil --old: -1
D[7627].lvl=nil --old: -1
D[7628].lvl=nil --old: -1
D[7629].obj.I={18688} --old: nil
D[7629].preg={7625,7630} --old: nil
D[7629].lvl=nil --old: -1
D[7630].preg={7626,7627,7628} --old: nil
D[7630].lvl=nil --old: -1
D[7631].obj.I={18818} --old: nil
D[7631].lvl=nil --old: -1
D[7632].obj={}
D[7632].obj.I={18703} --old: nil
D[7633].pre=7632 --old: nil
D[7636].obj.I={18708,18952,18953,18954,18955} --old: {18952,18953,18954,18955}
D[7637].pre={7638,7670} --old: nil
D[7637].lvl=nil --old: -1
D[7638].excl={7670} --old: nil
D[7638].lvl=nil --old: -1
D[7639].obj={}
D[7639].obj.I={18819} --old: nil
D[7639].lvl=nil --old: -1
D[7640].obj.I={18752} --old: nil
D[7640].lvl=nil --old: -1
D[7641].lvl=nil --old: -1
D[7642].lvl=nil --old: -1
D[7643].obj.I={18753,18775} --old: {18775}
D[7643].lvl=nil --old: -1
D[7644].obj={}
D[7644].obj.I={18792} --old: nil
D[7644].lvl=nil --old: -1
D[7645].lvl=nil --old: -1
D[7646].lvl=nil --old: -1
D[7647].obj.I={18749,18792,18799,18804} --old: {18749,18792,18799}
D[7647].lvl=nil --old: -1
D[7648].obj={}
D[7648].obj.I={18753} --old: nil
D[7648].lvl=nil --old: -1
D[7649].obj={}
D[7649].obj.I={18769} --old: nil
D[7649].skill={id=164,min=300} --old: id=164
D[7650].obj={}
D[7650].obj.I={18770} --old: nil
D[7650].skill={id=164,min=300} --old: id=164
D[7651].obj={}
D[7651].obj.I={18771} --old: nil
D[7651].skill={id=164,min=300} --old: id=164
D[7652].skill={id=164,min=265} --old: id=164
D[7653].skill={id=164,min=265} --old: id=164
D[7654].skill={id=164,min=265} --old: id=164
D[7655].skill={id=164,min=265} --old: id=164
D[7656].skill={id=164,min=265} --old: id=164
D[7657].skill={id=164,min=265} --old: id=164
D[7658].skill={id=164,min=265} --old: id=164
D[7659].skill={id=164,min=265} --old: id=164
D[7660].hide=true --old: nil
D[7661].hide=true --old: nil
D[7662].hide=true --old: nil
D[7663].hide=true --old: nil
D[7664].hide=true --old: nil
D[7665].hide=true --old: nil
D[7666].lvl=nil --old: -1
D[7668].start={}
D[7668].start.U={13417} --old: nil
D[7668]['end']={}
D[7668]['end'].U={13417} --old: nil
D[7668].obj.I={18746,18880} --old: {18880}
D[7668].excl={8258} --old: nil
D[7668].min=58 --old: 2
D[7668].race=690 --old: nil
D[7668].hide=true --old: nil
D[7669].start={}
D[7669].start.U={13417} --old: nil
D[7669]['end']={}
D[7669]['end'].U={13417} --old: nil
D[7669].race=690 --old: nil
D[7670].next=7637 --old: nil
D[7670].excl={7638} --old: nil
D[7670].lvl=60 --old: -1
D[7670].race=1101 --old: 1029
D[7671].hide=true --old: nil
D[7672].hide=true --old: nil
D[7673].hide=true --old: nil
D[7674].hide=true --old: nil
D[7675].hide=true --old: nil
D[7676].hide=true --old: nil
D[7677].hide=true --old: nil
D[7678].hide=true --old: nil
D[7725].obj.I={18904,18956} --old: {18956}
D[7732].obj={}
D[7732].obj.I={19020} --old: nil
D[7732].preg={7730,7731} --old: nil
D[7735].start.U={5299} --old: nil
D[7735].obj={}
D[7735].obj.I={18969} --old: nil
D[7737].repu={id=59,min=3000} --old: id=nil
D[7738].start.U={5299} --old: nil
D[7738].obj={}
D[7738].obj.I={18972} --old: nil
D[7761].start.U={9046} --old: nil
D[7761].obj={}
D[7761].obj.I={18987} --old: nil
D[7781].obj={}
D[7781].obj.I={19003} --old: nil
D[7783].obj={}
D[7783].obj.I={19002} --old: nil
D[7785].obj={}
D[7785].obj.I={19016} --old: nil
D[7785].class=15 --old: nil
D[7786].class=15 --old: nil
D[7787].obj={}
D[7787].obj.I={19018} --old: nil
D[7787].class=15 --old: nil
D[7788].excl={7871,7872,7873,7887,7921,8291} --old: nil
D[7788].hide=true --old: nil
D[7789].excl={7874,7875,7876,7922,7923,7924,7925,8293,8294} --old: nil
D[7789].hide=true --old: nil
D[7791].lvl=nil --old: -1
D[7792].lvl=nil --old: -1
D[7793].lvl=nil --old: -1
D[7794].lvl=nil --old: -1
D[7795].preg={7791,7793,7794} --old: nil
D[7795].lvl=nil --old: -1
D[7796].lvl=nil --old: -1
D[7798].lvl=nil --old: -1
D[7799].lvl=nil --old: -1
D[7800].preg={7792,7798,7799} --old: nil
D[7800].lvl=nil --old: -1
D[7801].lvl=nil --old: -1
D[7802].lvl=nil --old: -1
D[7803].lvl=nil --old: -1
D[7804].lvl=nil --old: -1
D[7805].preg={7802,7803,7804} --old: nil
D[7805].lvl=nil --old: -1
D[7806].lvl=nil --old: -1
D[7807].lvl=nil --old: -1
D[7808].lvl=nil --old: -1
D[7809].lvl=nil --old: -1
D[7810].obj={}
D[7810].obj.I={18706} --old: nil
D[7811].preg={7807,7808,7809} --old: nil
D[7811].lvl=nil --old: -1
D[7812].lvl=nil --old: -1
D[7813].lvl=nil --old: -1
D[7814].lvl=nil --old: -1
D[7816].pre=nil --old: 7815
D[7817].lvl=nil --old: -1
D[7818].preg={7813,7814,7817} --old: nil
D[7818].lvl=nil --old: -1
D[7819].lvl=nil --old: -1
D[7820].lvl=nil --old: -1
D[7821].lvl=nil --old: -1
D[7822].lvl=nil --old: -1
D[7823].preg={7820,7821,7822} --old: nil
D[7823].lvl=nil --old: -1
D[7824].preg={7826,7827,7831} --old: nil
D[7824].lvl=nil --old: -1
D[7825].lvl=nil --old: -1
D[7826].lvl=nil --old: -1
D[7827].lvl=nil --old: -1
D[7831].lvl=nil --old: -1
D[7832].lvl=nil --old: -1
D[7833].lvl=nil --old: -1
D[7834].lvl=nil --old: -1
D[7835].lvl=nil --old: -1
D[7836].preg={7833,7834,7835} --old: nil
D[7836].lvl=nil --old: -1
D[7837].lvl=nil --old: -1
D[7843].obj.I={19036} --old: nil
D[7863].excl={7864,7865} --old: nil
D[7863].repu={id=890,min=3000} --old: id=nil
D[7864].excl={7863,7865} --old: nil
D[7864].repu={id=890,min=9000} --old: id=nil
D[7865].excl={7863,7864} --old: nil
D[7865].repu={id=890,min=21000} --old: id=nil
D[7866].excl={7867,7868} --old: nil
D[7866].repu={id=889,min=3000} --old: id=nil
D[7867].excl={7866,7868} --old: nil
D[7867].repu={id=889,min=9000} --old: id=nil
D[7868].excl={7866,7867} --old: nil
D[7868].repu={id=889,min=21000} --old: id=nil
D[7871].excl={7788,7872,7873,7887,7921,8291} --old: nil
D[7871].hide=true --old: nil
D[7872].excl={7788,7871,7873,7887,7921,8291} --old: nil
D[7872].hide=true --old: nil
D[7873].excl={7788,7871,7872,7887,7921,8291} --old: nil
D[7873].hide=true --old: nil
D[7874].excl={7789,7875,7876,7922,7923,7924,7925,8293,8294} --old: nil
D[7874].hide=true --old: nil
D[7875].excl={7789,7874,7876,7922,7923,7924,7925,8293,8294} --old: nil
D[7875].hide=true --old: nil
D[7876].excl={7789,7874,7875,7922,7923,7924,7925,8293,8294} --old: nil
D[7876].hide=true --old: nil
D[7881].lvl=nil --old: -1
D[7881].hide=true --old: nil
D[7882].lvl=nil --old: -1
D[7882].hide=true --old: nil
D[7883].lvl=nil --old: -1
D[7883].hide=true --old: nil
D[7884].lvl=nil --old: -1
D[7884].hide=true --old: nil
D[7885].lvl=nil --old: -1
D[7885].hide=true --old: nil
D[7886].start={}
D[7886].start.U={14733} --old: nil
D[7886]['end']={}
D[7886]['end'].U={14733} --old: nil
D[7886].hide=true --old: nil
D[7887].start={}
D[7887].start.U={14733} --old: nil
D[7887]['end']={}
D[7887]['end'].U={14733} --old: nil
D[7887].hide=true --old: nil
D[7888].start={}
D[7888].start.U={14733} --old: nil
D[7888]['end']={}
D[7888]['end'].U={14733} --old: nil
D[7888].hide=true --old: nil
D[7889].lvl=nil --old: -1
D[7889].hide=true --old: nil
D[7890].lvl=nil --old: -1
D[7890].hide=true --old: nil
D[7891].lvl=nil --old: -1
D[7891].hide=true --old: nil
D[7892].lvl=nil --old: -1
D[7892].hide=true --old: nil
D[7893].lvl=nil --old: -1
D[7893].hide=true --old: nil
D[7894].lvl=nil --old: -1
D[7894].hide=true --old: nil
D[7895].lvl=nil --old: -1
D[7895].hide=true --old: nil
D[7896].lvl=nil --old: -1
D[7896].hide=true --old: nil
D[7897].lvl=nil --old: -1
D[7897].hide=true --old: nil
D[7898].lvl=nil --old: -1
D[7898].hide=true --old: nil
D[7899].lvl=nil --old: -1
D[7899].hide=true --old: nil
D[7900].lvl=nil --old: -1
D[7900].hide=true --old: nil
D[7901].lvl=nil --old: -1
D[7901].hide=true --old: nil
D[7902].lvl=nil --old: -1
D[7902].hide=true --old: nil
D[7903].lvl=nil --old: -1
D[7903].hide=true --old: nil
D[7905].obj={}
D[7905].obj.I={19338} --old: nil
D[7905].lvl=nil --old: -1
D[7905].hide=true --old: nil
D[7906].hide=true --old: nil
D[7907].obj={}
D[7907].obj.I={19228} --old: nil
D[7907].lvl=nil --old: -1
D[7907].hide=true --old: nil
D[7908].obj={}
D[7908].obj.I={18706} --old: nil
D[7921].start={}
D[7921].start.U={14733} --old: nil
D[7921]['end']={}
D[7921]['end'].U={14733} --old: nil
D[7921].hide=true --old: nil
D[7922].excl={7789,7874,7875,7876,7923,7924,7925,8293,8294} --old: nil
D[7922].hide=true --old: nil
D[7923].excl={7789,7874,7875,7876,7922,7924,7925,8293,8294} --old: nil
D[7923].hide=true --old: nil
D[7924].excl={7789,7874,7875,7876,7922,7923,7925,8293,8294} --old: nil
D[7924].hide=true --old: nil
D[7925].excl={7789,7874,7875,7876,7922,7923,7924,8293,8294} --old: nil
D[7925].hide=true --old: nil
D[7926].obj={}
D[7926].obj.I={19338} --old: nil
D[7926].lvl=nil --old: -1
D[7926].hide=true --old: nil
D[7927].obj={}
D[7927].obj.I={19277} --old: nil
D[7927].lvl=nil --old: -1
D[7927].hide=true --old: nil
D[7928].obj={}
D[7928].obj.I={19257} --old: nil
D[7928].lvl=nil --old: -1
D[7928].hide=true --old: nil
D[7929].obj={}
D[7929].obj.I={19267} --old: nil
D[7929].lvl=nil --old: -1
D[7929].hide=true --old: nil
D[7930].lvl=nil --old: -1
D[7930].hide=true --old: nil
D[7931].lvl=nil --old: -1
D[7931].hide=true --old: nil
D[7932].lvl=nil --old: -1
D[7932].hide=true --old: nil
D[7933].lvl=nil --old: -1
D[7933].hide=true --old: nil
D[7934].lvl=nil --old: -1
D[7934].hide=true --old: nil
D[7935].lvl=nil --old: -1
D[7935].hide=true --old: nil
D[7936].lvl=nil --old: -1
D[7936].hide=true --old: nil
D[7937].obj={}
D[7937].obj.I={19423} --old: nil
D[7937].lvl=nil --old: -1
D[7937].hide=true --old: nil
D[7938].obj={}
D[7938].obj.I={19424} --old: nil
D[7938].lvl=nil --old: -1
D[7938].hide=true --old: nil
D[7939].lvl=nil --old: -1
D[7939].repu={id=909,min=5500} --old: id=nil
D[7939].hide=true --old: nil
D[7940].lvl=nil --old: -1
D[7940].hide=true --old: nil
D[7941].lvl=nil --old: -1
D[7941].repu={id=909,min=5500} --old: id=nil
D[7941].hide=true --old: nil
D[7942].lvl=nil --old: -1
D[7942].repu={id=909,min=5500} --old: id=nil
D[7942].hide=true --old: nil
D[7943].lvl=nil --old: -1
D[7943].repu={id=909,min=5500} --old: id=nil
D[7943].hide=true --old: nil
D[7944].obj={}
D[7944].obj.I={19443} --old: nil
D[7944].lvl=nil --old: -1
D[7944].hide=true --old: nil
D[7945].obj={}
D[7945].obj.I={19452} --old: nil
D[7945].lvl=nil --old: -1
D[7945].hide=true --old: nil
D[7946].lvl=60 --old: -1
D[7946].hide=true --old: nil
D[7961].hide=true --old: nil
D[7981].lvl=nil --old: -1
D[7981].hide=true --old: nil
D[8001].hide=true --old: nil
D[8002].hide=true --old: nil
D[8021].lvl=nil --old: -1
D[8023].lvl=nil --old: -1
D[8026].lvl=nil --old: -1
D[8041].repu={id=270,min=3000} --old: id=nil
D[8042].repu={id=270,min=9000} --old: id=nil
D[8043].repu={id=270,min=21000} --old: id=nil
D[8044].repu={id=270,min=42000} --old: id=nil
D[8045].repu={id=270,min=3000} --old: id=nil
D[8046].repu={id=270,min=9000} --old: id=nil
D[8047].repu={id=270,min=21000} --old: id=nil
D[8048].repu={id=270,min=42000} --old: id=nil
D[8049].repu={id=270,min=3000} --old: id=nil
D[8050].repu={id=270,min=9000} --old: id=nil
D[8051].repu={id=270,min=21000} --old: id=nil
D[8052].repu={id=270,min=42000} --old: id=nil
D[8080].excl={8081,8154,8155,8156,8157,8158,8159,8297,8298} --old: nil
D[8080].hide=true --old: nil
D[8081].excl={8080,8154,8155,8156,8157,8158,8159,8297,8298} --old: nil
D[8081].hide=true --old: nil
D[8101].repu={id=270,min=3000} --old: id=nil
D[8102].repu={id=270,min=9000} --old: id=nil
D[8103].repu={id=270,min=21000} --old: id=nil
D[8104].repu={id=270,min=42000} --old: id=nil
D[8105].excl={8166,8167,8168} --old: nil
D[8106].repu={id=270,min=3000} --old: id=nil
D[8107].repu={id=270,min=9000} --old: id=nil
D[8108].repu={id=270,min=21000} --old: id=nil
D[8109].repu={id=270,min=42000} --old: id=nil
D[8110].repu={id=270,min=3000} --old: id=nil
D[8111].repu={id=270,min=9000} --old: id=nil
D[8112].repu={id=270,min=21000} --old: id=nil
D[8113].repu={id=270,min=42000} --old: id=nil
D[8114].repu={id=509,min=3000} --old: id=nil
D[8115].repu={id=509,min=42000} --old: id=nil
D[8116].repu={id=270,min=3000} --old: id=nil
D[8117].repu={id=270,min=9000} --old: id=nil
D[8118].repu={id=270,min=21000} --old: id=nil
D[8119].repu={id=270,min=42000} --old: id=nil
D[8120].excl={8169,8170,8171} --old: nil
D[8121].repu={id=510,min=3000} --old: id=nil
D[8122].repu={id=510,min=42000} --old: id=nil
D[8123].hide=true --old: nil
D[8124].excl={8161,8163,8164,8165,8300} --old: nil
D[8124].hide=true --old: nil
D[8141].repu={id=270,min=3000} --old: id=nil
D[8142].repu={id=270,min=9000} --old: id=nil
D[8143].repu={id=270,min=21000} --old: id=nil
D[8144].repu={id=270,min=42000} --old: id=nil
D[8145].repu={id=270,min=3000} --old: id=nil
D[8146].repu={id=270,min=9000} --old: id=nil
D[8147].repu={id=270,min=21000} --old: id=nil
D[8148].repu={id=270,min=42000} --old: id=nil
D[8149].obj.I={19850} --old: nil
D[8149].lvl=nil --old: -1
D[8149].hide=true --old: nil
D[8150].obj.I={19851} --old: nil
D[8150].excl={2851} --old: nil
D[8150].lvl=nil --old: -1
D[8150].hide=true --old: nil
D[8151].race=8 --old: nil
D[8154].excl={8080,8081,8155,8156,8157,8158,8159,8297,8298} --old: nil
D[8154].hide=true --old: nil
D[8155].excl={8080,8081,8154,8156,8157,8158,8159,8297,8298} --old: nil
D[8155].hide=true --old: nil
D[8156].excl={8080,8081,8154,8155,8157,8158,8159,8297,8298} --old: nil
D[8156].hide=true --old: nil
D[8157].excl={8080,8081,8154,8155,8156,8158,8159,8297,8298} --old: nil
D[8157].hide=true --old: nil
D[8158].excl={8080,8081,8154,8155,8156,8157,8159,8297,8298} --old: nil
D[8158].hide=true --old: nil
D[8159].excl={8080,8081,8154,8155,8156,8157,8158,8297,8298} --old: nil
D[8159].hide=true --old: nil
D[8160].hide=true --old: nil
D[8161].hide=true --old: nil
D[8162].hide=true --old: nil
D[8163].excl={8124,8161,8164,8165,8300} --old: nil
D[8163].hide=true --old: nil
D[8164].excl={8124,8161,8163,8165,8300} --old: nil
D[8164].hide=true --old: nil
D[8165].excl={8124,8161,8163,8164,8300} --old: nil
D[8165].hide=true --old: nil
D[8166].excl={8105,8167,8168} --old: nil
D[8167].excl={8105,8166,8168} --old: nil
D[8168].excl={8105,8166,8167} --old: nil
D[8169].excl={8120,8170,8171} --old: nil
D[8170].excl={8120,8169,8171} --old: nil
D[8171].excl={8120,8169,8170} --old: nil
D[8183].obj={}
D[8183].obj.I={19802} --old: nil
D[8184].class=1 --old: nil
D[8184].repu={id=270,min=3000} --old: id=nil
D[8185].class=2 --old: nil
D[8185].repu={id=270,min=3000} --old: id=nil
D[8186].class=8 --old: nil
D[8186].repu={id=270,min=3000} --old: id=nil
D[8187].class=4 --old: nil
D[8187].repu={id=270,min=3000} --old: id=nil
D[8188].class=64 --old: nil
D[8188].repu={id=270,min=3000} --old: id=nil
D[8189].class=128 --old: nil
D[8189].repu={id=270,min=3000} --old: id=nil
D[8190].class=256 --old: nil
D[8190].repu={id=270,min=3000} --old: id=nil
D[8191].class=16 --old: nil
D[8191].repu={id=270,min=3000} --old: id=nil
D[8192].class=1024 --old: nil
D[8192].repu={id=270,min=3000} --old: id=nil
D[8193].lvl=nil --old: -1
D[8193].skill={id=356,min=0} --old: id=356
D[8193].hide=true --old: nil
D[8194].lvl=nil --old: -1
D[8194].skill={id=356,min=1} --old: id=356
D[8194].hide=true --old: nil
D[8196].repu={id=270,min=9000} --old: id=nil
D[8201].obj.I={19880,19881,19883} --old: {19880,19881}
D[8221].lvl=nil --old: -1
D[8221].skill={id=356,min=0} --old: id=356
D[8221].hide=true --old: nil
D[8222].lvl=nil --old: -1
D[8222].hide=true --old: nil
D[8223].lvl=nil --old: -1
D[8223].repu={id=909,min=5500} --old: id=nil
D[8223].hide=true --old: nil
D[8224].lvl=nil --old: -1
D[8224].skill={id=356,min=0} --old: id=356
D[8224].hide=true --old: nil
D[8225].lvl=nil --old: -1
D[8225].skill={id=356,min=0} --old: id=356
D[8225].hide=true --old: nil
D[8227].obj={}
D[8227].obj.I={19973} --old: nil
D[8228].lvl=nil --old: -1
D[8228].race=1101 --old: nil
D[8228].hide=true --old: nil
D[8229].lvl=nil --old: -1
D[8229].race=690 --old: nil
D[8229].hide=true --old: nil
D[8243].repu={id=270,min=21000} --old: id=nil
D[8246].repu={id=270,min=42000} --old: id=nil
D[8251].pre=nil --old: 8250
D[8258].obj.I={18746,18880} --old: {18880}
D[8258].excl={7668} --old: nil
D[8260].excl={8261,8262} --old: nil
D[8260].repu={id=509,min=3000} --old: id=nil
D[8261].excl={8260,8262} --old: nil
D[8261].repu={id=509,min=3000} --old: id=nil
D[8262].excl={8260,8261} --old: nil
D[8263].excl={8264,8265} --old: nil
D[8263].repu={id=510,min=3000} --old: id=nil
D[8264].excl={8263,8265} --old: nil
D[8264].repu={id=510,min=3000} --old: id=nil
D[8265].excl={8263,8264} --old: nil
D[8265].repu={id=510,min=3000} --old: id=nil
D[8266].hide=true --old: nil
D[8267].hide=true --old: nil
D[8268].hide=true --old: nil
D[8269].hide=true --old: nil
D[8271].race=1101 --old: nil
D[8272].race=690 --old: nil
D[8273].race=690 --old: nil
D[8275].excl={8276} --old: nil
D[8276].excl={8275} --old: nil
D[8280].pre={8275,8276} --old: nil
D[8280].excl=nil --old: nil
D[8285].obj={}
D[8285].obj.I={20401} --old: nil
D[8287].obj={}
D[8287].obj.I={20405} --old: nil
D[8289].start={}
D[8289].start.U={14733} --old: nil
D[8289]['end']={}
D[8289]['end'].U={14733} --old: nil
D[8289].race=1101 --old: nil
D[8289].hide=true --old: nil
D[8290].hide=true --old: nil
D[8291].excl={7788,7871,7872,7873,7887,7921} --old: nil
D[8291].hide=true --old: nil
D[8292].hide=true --old: nil
D[8293].excl={7789,7874,7875,7876,7922,7923,7924,7925,8294} --old: nil
D[8293].hide=true --old: nil
D[8294].excl={7789,7874,7875,7876,7922,7923,7924,7925,8293} --old: nil
D[8294].hide=true --old: nil
D[8295].hide=true --old: nil
D[8296].race=690 --old: nil
D[8296].hide=true --old: nil
D[8297].excl={8080,8081,8154,8155,8156,8157,8158,8159,8298} --old: nil
D[8297].hide=true --old: nil
D[8298].excl={8080,8081,8154,8155,8156,8157,8158,8159,8297} --old: nil
D[8298].hide=true --old: nil
D[8299].hide=true --old: nil
D[8300].excl={8124,8161,8163,8164,8165} --old: nil
D[8300].hide=true --old: nil
D[8301].obj.I={20384,20402} --old: {20384}
D[8303].obj={}
D[8303].obj.I={20415} --old: nil
D[8303].repu={id=910,min=0} --old: id=nil
D[8304].obj.U={15170,15171} --old: {15221,15222}
D[8304].min=58 --old: 60
D[8305].repu={id=910,min=0} --old: id=nil
D[8307].skill={id=185,min=285} --old: id=185
D[8308].obj={}
D[8308].obj.I={20461} --old: nil
D[8309].obj.I={20453,20454,20455,20456} --old: {20454,20455,20456}
D[8311].race=1101 --old: nil
D[8311].hide=true --old: nil
D[8312].lvl=nil --old: -1
D[8312].race=690 --old: nil
D[8312].hide=true --old: nil
D[8313].obj={}
D[8313].obj.I={20467} --old: nil
D[8313].skill={id=185,min=285} --old: id=185
D[8314].obj={}
D[8314].obj.I={20463} --old: nil
D[8314].preg={8309,8310} --old: nil
D[8315].obj.I={20464,20465} --old: {20465}
D[8317].skill={id=185,min=285} --old: id=185
D[8322].obj={}
D[8322].obj.I={20605} --old: nil
D[8322].lvl=nil --old: -1
D[8322].hide=true --old: nil
D[8325].race=512 --old: 690
D[8326].race=512 --old: 690
D[8327].race=512 --old: 690
D[8328].race=512 --old: 690
D[8330].obj.I={20470,20471,20472,20474} --old: {20470,20471,20472}
D[8330].pre=nil --old: nil
D[8330].race=512 --old: 690
D[8331].excl={8332} --old: nil
D[8331].repu={id=609,min=3000} --old: id=nil
D[8332].pre=nil --old: 8331
D[8332].repu={id=609,min=3000} --old: id=nil
D[8333].repu={id=609,min=3000} --old: id=nil
D[8334].race=512 --old: 690
D[8335].race=512 --old: 690
D[8336].race=512 --old: 690
D[8338].start.U={15298} --old: nil
D[8338].obj={}
D[8338].obj.I={20483} --old: nil
D[8338].race=512 --old: 690
D[8341].repu={id=609,min=21000} --old: id=nil
D[8342].repu={id=609,min=21000} --old: id=nil
D[8343].repu={id=609,min=21000} --old: id=nil
D[8344].lvl=nil --old: -1
D[8344].race=512 --old: 690
D[8345].race=512 --old: 690
D[8347].race=512 --old: 690
D[8348].repu={id=609,min=3000} --old: id=nil
D[8349].repu={id=609,min=3000} --old: id=nil
D[8350].obj={}
D[8350].obj.I={20804} --old: nil
D[8351].repu={id=609,min=21000} --old: id=nil
D[8352].repu={id=609,min=21000} --old: id=nil
D[8353].obj={}
D[8353].obj.U={5111} --old: nil
D[8353].lvl=nil --old: -1
D[8353].race=1101 --old: nil
D[8353].hide=true --old: nil
D[8354].obj={}
D[8354].obj.U={6741} --old: nil
D[8354].lvl=nil --old: -1
D[8354].race=690 --old: nil
D[8354].hide=true --old: nil
D[8355].obj={}
D[8355].obj.U={6826} --old: nil
D[8355].lvl=nil --old: -1
D[8355].race=1101 --old: nil
D[8355].hide=true --old: nil
D[8356].obj={}
D[8356].obj.U={6740} --old: nil
D[8356].lvl=nil --old: -1
D[8356].race=1101 --old: nil
D[8356].hide=true --old: nil
D[8357].obj={}
D[8357].obj.U={6735} --old: nil
D[8357].hide=true --old: nil
D[8358].obj={}
D[8358].obj.U={11814} --old: nil
D[8358].lvl=nil --old: -1
D[8358].race=690 --old: nil
D[8358].hide=true --old: nil
D[8359].obj={}
D[8359].obj.U={6929} --old: nil
D[8359].lvl=nil --old: -1
D[8359].race=690 --old: nil
D[8359].hide=true --old: nil
D[8360].obj={}
D[8360].obj.U={6746} --old: nil
D[8360].hide=true --old: nil
D[8363].repu={id=609,min=3000} --old: id=nil
D[8364].repu={id=609,min=21000} --old: id=nil
D[8367].lvl=nil --old: -1
D[8367].min=61 --old: 51
D[8368].excl={8426,8427,8428,8429,8430} --old: nil
D[8368].hide=true --old: nil
D[8369].hide=true --old: nil
D[8370].hide=true --old: nil
D[8371].lvl=nil --old: -1
D[8371].min=61 --old: 51
D[8372].excl={8399,8400,8401,8402,8403} --old: nil
D[8372].hide=true --old: nil
D[8373].obj.I={20604} --old: nil
D[8373].lvl=nil --old: -1
D[8373].race=1101 --old: nil
D[8373].hide=true --old: nil
D[8374].hide=true --old: nil
D[8375].hide=true --old: nil
D[8383].hide=true --old: nil
D[8384].hide=true --old: nil
D[8385].lvl=nil --old: -1
D[8386].hide=true --old: nil
D[8387].hide=true --old: nil
D[8388].lvl=nil --old: -1
D[8389].hide=true --old: nil
D[8390].hide=true --old: nil
D[8391].hide=true --old: nil
D[8392].hide=true --old: nil
D[8393].hide=true --old: nil
D[8394].hide=true --old: nil
D[8395].hide=true --old: nil
D[8396].hide=true --old: nil
D[8397].hide=true --old: nil
D[8398].hide=true --old: nil
D[8399].excl={8372,8400,8401,8402,8403} --old: nil
D[8399].hide=true --old: nil
D[8400].excl={8372,8399,8401,8402,8403} --old: nil
D[8400].hide=true --old: nil
D[8401].excl={8372,8399,8400,8402,8403} --old: nil
D[8401].hide=true --old: nil
D[8402].excl={8372,8399,8400,8401,8403} --old: nil
D[8402].hide=true --old: nil
D[8403].excl={8372,8399,8400,8401,8402} --old: nil
D[8403].hide=true --old: nil
D[8404].hide=true --old: nil
D[8405].hide=true --old: nil
D[8406].hide=true --old: nil
D[8407].hide=true --old: nil
D[8408].hide=true --old: nil
D[8409].lvl=nil --old: -1
D[8409].hide=true --old: nil
D[8411].hide=true --old: nil
D[8416].obj={}
D[8416].obj.I={20612} --old: nil
D[8419].excl={8420} --old: nil
D[8420].excl={8419} --old: nil
D[8421].pre={8419,8420} --old: nil
D[8426].excl={8368,8427,8428,8429,8430} --old: nil
D[8426].hide=true --old: nil
D[8427].excl={8368,8426,8428,8429,8430} --old: nil
D[8427].hide=true --old: nil
D[8428].excl={8368,8426,8427,8429,8430} --old: nil
D[8428].hide=true --old: nil
D[8429].excl={8368,8426,8427,8428,8430} --old: nil
D[8429].hide=true --old: nil
D[8430].excl={8368,8426,8427,8428,8429} --old: nil
D[8430].hide=true --old: nil
D[8431].hide=true --old: nil
D[8432].hide=true --old: nil
D[8433].hide=true --old: nil
D[8434].hide=true --old: nil
D[8435].hide=true --old: nil
D[8436].hide=true --old: nil
D[8437].hide=true --old: nil
D[8438].hide=true --old: nil
D[8439].hide=true --old: nil
D[8440].hide=true --old: nil
D[8441].hide=true --old: nil
D[8442].hide=true --old: nil
D[8443].hide=true --old: nil
D[8446].obj={}
D[8446].obj.I={20644} --old: nil
D[8470].obj={}
D[8470].obj.I={20741} --old: nil
D[8471].obj={}
D[8471].obj.I={20742} --old: nil
D[8473].pre=nil --old: 9258
D[8474].start.U={15409} --old: nil
D[8474].obj={}
D[8474].obj.I={23228} --old: nil
D[8476].pre=nil --old: 9359
D[8478].hide=true --old: nil
D[8481].obj.I={21144,21145} --old: {21145}
D[8481].repu={id=576,min=42000} --old: id=nil
D[8482].start.U={15968} --old: nil
D[8482].obj={}
D[8482].obj.I={20765} --old: nil
D[8484].obj={}
D[8484].obj.I={21155} --old: nil
D[8484].pre=8481 --old: nil
D[8484].race=1101 --old: nil
D[8484].repu={id=576,min=42000} --old: id=nil
D[8485].obj={}
D[8485].obj.I={21155} --old: nil
D[8485].pre=8481 --old: nil
D[8485].repu={id=576,min=42000} --old: id=nil
D[8487].pre=nil --old: 9254
D[8489].hide=true --old: nil
D[8490].obj.I={22693} --old: nil
D[8490].pre=nil --old: 9253
D[8492].min=1 --old: 50
D[8492].race=1101 --old: nil
D[8493].race=1101 --old: nil
D[8494].min=1 --old: 40
D[8494].race=1101 --old: nil
D[8495].race=1101 --old: nil
D[8496].obj.I={6451,8545,14530,20806} --old: {6451,8545,14530}
D[8497].obj.I={7079,19440,20452,20807} --old: {7079,19440,20452}
D[8498].obj.I={20803,20943} --old: {20803}
D[8499].min=1 --old: 48
D[8499].race=1101 --old: nil
D[8501].obj.I={20941} --old: nil
D[8502].obj.I={20942} --old: nil
D[8503].min=1 --old: 37
D[8503].race=1101 --old: nil
D[8505].min=1 --old: 37
D[8505].race=1101 --old: nil
D[8507].obj.I={20810,21143} --old: {20810}
D[8508].obj.I={20810,23024} --old: {23024}
D[8509].min=1 --old: 34
D[8509].race=1101 --old: nil
D[8511].min=1 --old: 50
D[8511].race=1101 --old: nil
D[8512].race=1101 --old: nil
D[8513].min=1 --old: 52
D[8513].race=1101 --old: nil
D[8514].race=1101 --old: nil
D[8515].min=1 --old: 44
D[8515].race=1101 --old: nil
D[8516].race=1101 --old: nil
D[8517].min=1 --old: 51
D[8517].race=1101 --old: nil
D[8518].race=1101 --old: nil
D[8519].repu={id=910,min=0} --old: id=nil
D[8520].pre=nil --old: 2847
D[8520].min=1 --old: 51
D[8520].race=1101 --old: nil
D[8521].race=1101 --old: nil
D[8522].min=1 --old: 56
D[8522].race=1101 --old: nil
D[8523].race=1101 --old: nil
D[8524].min=1 --old: 54
D[8524].race=1101 --old: nil
D[8525].race=1101 --old: nil
D[8526].min=1 --old: 33
D[8526].race=1101 --old: nil
D[8528].min=1 --old: 42
D[8528].race=1101 --old: nil
D[8529].race=1101 --old: nil
D[8530].hide=true --old: nil
D[8532].min=1 --old: 54
D[8532].race=690 --old: nil
D[8533].race=690 --old: nil
D[8534].obj.I={21158,21165} --old: {21158}
D[8535].obj.I={20947} --old: nil
D[8536].obj.I={21751} --old: nil
D[8537].obj.I={20945} --old: nil
D[8538].obj.I={20948} --old: nil
D[8539].obj.I={21249} --old: nil
D[8540].obj.I={7936,20939} --old: {7936}
D[8541].obj.I={3486,7966,12644,20940} --old: {3486,7966,12644}
D[8542].min=1 --old: 54
D[8542].race=690 --old: nil
D[8543].race=690 --old: nil
D[8545].min=1 --old: 52
D[8545].race=690 --old: nil
D[8546].race=690 --old: nil
D[8547].obj={}
D[8547].obj.I={20938} --old: nil
D[8549].min=1 --old: 54
D[8549].race=690 --old: nil
D[8550].race=690 --old: nil
D[8551].min=35 --old: 40
D[8552].start.U={1493} --old: nil
D[8552].obj={}
D[8552].obj.I={3985} --old: nil
D[8555].repu={id=910,min=0} --old: id=nil
D[8565].hide=true --old: nil
D[8566].hide=true --old: nil
D[8567].hide=true --old: nil
D[8568].hide=true --old: nil
D[8569].hide=true --old: nil
D[8570].hide=true --old: nil
D[8575].start.U={15481} --old: nil
D[8575].obj={}
D[8575].obj.I={20949} --old: nil
D[8575].repu={id=910,min=0} --old: id=nil
D[8576].repu={id=910,min=0} --old: id=nil
D[8577].repu={id=910,min=0} --old: id=nil
D[8578].repu={id=910,min=0} --old: id=nil
D[8580].min=1 --old: 57
D[8580].race=690 --old: nil
D[8581].race=690 --old: nil
D[8582].min=1 --old: 50
D[8582].race=690 --old: nil
D[8583].race=690 --old: nil
D[8584].repu={id=910,min=0} --old: id=nil
D[8585].repu={id=910,min=0} --old: id=nil
D[8586].repu={id=910,min=0} --old: id=nil
D[8587].obj={}
D[8587].obj.I={21028} --old: nil
D[8587].repu={id=910,min=0} --old: id=nil
D[8588].min=1 --old: 53
D[8588].race=690 --old: nil
D[8589].race=690 --old: nil
D[8590].min=1 --old: 54
D[8590].race=690 --old: nil
D[8591].race=690 --old: nil
D[8597].repu={id=910,min=0} --old: id=nil
D[8598].obj={}
D[8598].obj.I={21029} --old: nil
D[8598].repu={id=910,min=0} --old: id=nil
D[8599].obj={}
D[8599].obj.I={21032} --old: nil
D[8599].repu={id=910,min=0} --old: id=nil
D[8600].min=1 --old: 55
D[8600].race=690 --old: nil
D[8601].race=690 --old: nil
D[8604].min=1 --old: 55
D[8604].race=690 --old: nil
D[8605].race=690 --old: nil
D[8606].obj.I={21042} --old: nil
D[8606].repu={id=910,min=0} --old: id=nil
D[8607].min=1 --old: 57
D[8607].race=690 --old: nil
D[8608].race=690 --old: nil
D[8609].min=1 --old: 59
D[8609].race=690 --old: nil
D[8610].race=690 --old: nil
D[8611].min=1 --old: 49
D[8611].race=690 --old: nil
D[8612].race=690 --old: nil
D[8613].min=1 --old: 52
D[8613].race=690 --old: nil
D[8614].race=690 --old: nil
D[8615].min=1 --old: 20
D[8615].race=690 --old: nil
D[8616].race=690 --old: nil
D[8618].hide=true --old: nil
D[8619].hide=true --old: nil
D[8620].obj.I={21103,21104,21105,21106,21107,21108,21109,21110,21111,21112} --old: {21111}
D[8620].repu={id=910,min=0} --old: id=nil
D[8635].hide=true --old: nil
D[8636].hide=true --old: nil
D[8642].hide=true --old: nil
D[8643].hide=true --old: nil
D[8644].hide=true --old: nil
D[8645].hide=true --old: nil
D[8646].hide=true --old: nil
D[8647].hide=true --old: nil
D[8648].hide=true --old: nil
D[8649].hide=true --old: nil
D[8650].hide=true --old: nil
D[8651].hide=true --old: nil
D[8652].hide=true --old: nil
D[8653].hide=true --old: nil
D[8654].hide=true --old: nil
D[8670].hide=true --old: nil
D[8671].hide=true --old: nil
D[8672].hide=true --old: nil
D[8673].hide=true --old: nil
D[8674].hide=true --old: nil
D[8675].hide=true --old: nil
D[8676].hide=true --old: nil
D[8677].hide=true --old: nil
D[8678].hide=true --old: nil
D[8679].hide=true --old: nil
D[8680].hide=true --old: nil
D[8681].hide=true --old: nil
D[8682].hide=true --old: nil
D[8683].hide=true --old: nil
D[8684].hide=true --old: nil
D[8685].hide=true --old: nil
D[8686].hide=true --old: nil
D[8687].obj.I={21251} --old: nil
D[8688].hide=true --old: nil
D[8713].hide=true --old: nil
D[8714].hide=true --old: nil
D[8715].hide=true --old: nil
D[8716].hide=true --old: nil
D[8717].hide=true --old: nil
D[8718].hide=true --old: nil
D[8719].hide=true --old: nil
D[8720].hide=true --old: nil
D[8721].hide=true --old: nil
D[8722].hide=true --old: nil
D[8723].hide=true --old: nil
D[8724].hide=true --old: nil
D[8725].hide=true --old: nil
D[8726].hide=true --old: nil
D[8727].hide=true --old: nil
D[8728].preg={8578,8587,8620} --old: nil
D[8728].repu={id=910,min=0} --old: id=nil
D[8729].obj.I={21136,21137} --old: {21137}
D[8729].repu={id=910,min=0} --old: id=nil
D[8730].repu={id=910,min=0} --old: id=nil
D[8731].obj.I={20810,21143} --old: {20810}
D[8732].obj.I={20810,23024} --old: {23024}
D[8733].repu={id=910,min=0} --old: id=nil
D[8734].repu={id=910,min=0} --old: id=nil
D[8735].repu={id=910,min=0} --old: id=nil
D[8736].repu={id=910,min=0} --old: id=nil
D[8737].obj.I={21245} --old: nil
D[8738].obj.I={21160,21166} --old: {21160}
D[8739].obj.I={21161,21167} --old: {21161}
D[8740].obj.I={20944} --old: nil
D[8741].obj={}
D[8741].obj.I={21139} --old: nil
D[8741].repu={id=910,min=0} --old: id=nil
D[8742].preg={8729,8730,8741} --old: nil
D[8742].repu={id=910,min=0} --old: id=nil
D[8743].repu={id=910,min=0} --old: id=nil
D[8743].hide=true --old: nil
D[8744].hide=true --old: nil
D[8745].repu={id=910,min=0} --old: id=nil
D[8746].obj.I={21211,21315} --old: {21211}
D[8746].lvl=nil --old: -1
D[8746].hide=true --old: nil
D[8747].excl={8752,8753,8754,8755,8756,8757,8758,8759,8760,8761} --old: nil
D[8747].repu={id=910,min=0} --old: id=nil
D[8748].excl={8752,8753,8754,8755,8756,8757,8758,8759,8760,8761} --old: nil
D[8748].repu={id=910,min=3000} --old: id=nil
D[8749].excl={8752,8753,8754,8755,8756,8757,8758,8759,8760,8761} --old: nil
D[8749].repu={id=910,min=9000} --old: id=nil
D[8750].excl={8752,8753,8754,8755,8756,8757,8758,8759,8760,8761} --old: nil
D[8750].repu={id=910,min=21000} --old: id=nil
D[8751].excl={8752,8753,8754,8755,8756,8757,8758,8759,8760,8761} --old: nil
D[8751].repu={id=910,min=42000} --old: id=nil
D[8752].excl={8747,8748,8749,8750,8751,8757,8758,8759,8760,8761} --old: nil
D[8752].repu={id=910,min=0} --old: id=nil
D[8753].excl={8747,8748,8749,8750,8751,8757,8758,8759,8760,8761} --old: nil
D[8753].repu={id=910,min=3000} --old: id=nil
D[8754].excl={8747,8748,8749,8750,8751,8757,8758,8759,8760,8761} --old: nil
D[8754].repu={id=910,min=9000} --old: id=nil
D[8755].excl={8747,8748,8749,8750,8751,8757,8758,8759,8760,8761} --old: nil
D[8755].repu={id=910,min=21000} --old: id=nil
D[8756].excl={8747,8748,8749,8750,8751,8757,8758,8759,8760,8761} --old: nil
D[8756].repu={id=910,min=42000} --old: id=nil
D[8757].excl={8747,8748,8749,8750,8751,8752,8753,8754,8755,8756} --old: nil
D[8757].repu={id=910,min=0} --old: id=nil
D[8758].excl={8747,8748,8749,8750,8751,8752,8753,8754,8755,8756} --old: nil
D[8758].repu={id=910,min=3000} --old: id=nil
D[8759].excl={8747,8748,8749,8750,8751,8752,8753,8754,8755,8756} --old: nil
D[8759].repu={id=910,min=9000} --old: id=nil
D[8760].excl={8747,8748,8749,8750,8751,8752,8753,8754,8755,8756} --old: nil
D[8760].repu={id=910,min=21000} --old: id=nil
D[8761].excl={8747,8748,8749,8750,8751,8752,8753,8754,8755,8756} --old: nil
D[8761].repu={id=910,min=42000} --old: id=nil
D[8762].obj.I={21211,21315} --old: {21211}
D[8762].lvl=nil --old: -1
D[8762].hide=true --old: nil
D[8763].lvl=nil --old: -1
D[8763].skill={id=185,min=300} --old: id=185
D[8763].hide=true --old: nil
D[8764].repu={id=910,min=42000} --old: id=nil
D[8765].repu={id=910,min=42000} --old: id=nil
D[8766].repu={id=910,min=42000} --old: id=nil
D[8767].excl={8788} --old: nil
D[8767].class=0 --old: 9
D[8767].race=2047 --old: nil
D[8767].hide=true --old: nil
D[8768].hide=true --old: nil
D[8769].hide=true --old: nil
D[8770].obj.I={21749} --old: nil
D[8771].obj.I={21750} --old: nil
D[8772].obj.I={21250} --old: nil
D[8773].obj.I={21248} --old: nil
D[8774].obj.I={21252} --old: nil
D[8775].obj.I={21253} --old: nil
D[8776].obj.I={21255} --old: nil
D[8777].obj.I={21256} --old: nil
D[8778].obj.I={8956,9061,15992,21257} --old: {8956,9061,15992}
D[8779].obj.I={11178,12364,14344,21259} --old: {11178,12364,14344}
D[8780].obj.I={4265,15564,21263} --old: {4265,15564}
D[8781].obj.I={3853,21260} --old: {3853}
D[8782].obj.I={14048,14227,14342,21262} --old: {14048,14227,14342}
D[8783].obj.I={12655,12810,21265} --old: {12655,12810}
D[8784].obj={}
D[8784].obj.I={21230} --old: nil
D[8785].obj.I={8152,8956,12804,21258} --old: {8152,8956,12804}
D[8786].obj.I={3855,21261} --old: {3855}
D[8787].obj.I={4265,15564,21264} --old: {4265,15564}
D[8788].excl={8767} --old: nil
D[8788].class=0 --old: 1494
D[8788].race=2047 --old: nil
D[8788].hide=true --old: nil
D[8791].obj={}
D[8791].obj.I={21220} --old: nil
D[8792].excl={8793,8794,10500} --old: nil
D[8792].min=1 --old: 10
D[8793].excl={8792,8794,10500} --old: nil
D[8793].min=1 --old: 10
D[8794].excl={8792,8793,10500} --old: nil
D[8794].min=1 --old: 10
D[8795].excl={8796,8797} --old: nil
D[8795].min=1 --old: 49
D[8795].race=1101 --old: nil
D[8796].excl={8795,8797} --old: nil
D[8796].race=1101 --old: nil
D[8797].excl={8795,8796} --old: nil
D[8797].race=1101 --old: nil
D[8798].skill={id=202,min=250} --old: id=202
D[8799].lvl=nil --old: -1
D[8799].skill={id=185,min=300} --old: id=185
D[8799].hide=true --old: nil
D[8801].obj={}
D[8801].obj.I={21221} --old: nil
D[8802].obj={}
D[8802].obj.I={21221} --old: nil
D[8803].hide=true --old: nil
D[8804].obj.I={7079,19440,20452,21378} --old: {7079,19440,20452}
D[8805].obj.I={7936,21379} --old: {7936}
D[8806].obj.I={3486,7966,12644,21380} --old: {3486,7966,12644}
D[8807].obj.I={11178,12364,14344,21382} --old: {11178,12364,14344}
D[8808].obj.I={14048,14227,14342,21384} --old: {14048,14227,14342}
D[8809].obj.I={12655,12810,21381} --old: {12655,12810}
D[8810].obj.I={6451,8545,14530,21385} --old: {6451,8545,14530}
D[8827].hide=true --old: nil
D[8828].hide=true --old: nil
D[8829].obj.I={12735,12753,20407,21514} --old: {12735,12753,20407}
D[8847].start={}
D[8847].start.U={15701} --old: nil
D[8847]['end']={}
D[8847]['end'].U={15701} --old: nil
D[8848].start={}
D[8848].start.U={15701} --old: nil
D[8848]['end']={}
D[8848]['end'].U={15701} --old: nil
D[8849].start={}
D[8849].start.U={15701} --old: nil
D[8849]['end']={}
D[8849]['end'].U={15701} --old: nil
D[8850].start={}
D[8850].start.U={15701} --old: nil
D[8850]['end']={}
D[8850]['end'].U={15701} --old: nil
D[8851].start={}
D[8851].start.U={15700} --old: nil
D[8851]['end']={}
D[8851]['end'].U={15700} --old: nil
D[8851].race=690 --old: nil
D[8852].start={}
D[8852].start.U={15700} --old: nil
D[8852]['end']={}
D[8852]['end'].U={15700} --old: nil
D[8852].race=690 --old: nil
D[8853].start={}
D[8853].start.U={15700} --old: nil
D[8853]['end']={}
D[8853]['end'].U={15700} --old: nil
D[8853].race=690 --old: nil
D[8854].start={}
D[8854].start.U={15700} --old: nil
D[8854]['end']={}
D[8854]['end'].U={15700} --old: nil
D[8854].race=690 --old: nil
D[8855].start={}
D[8855].start.U={15700} --old: nil
D[8855]['end']={}
D[8855]['end'].U={15700} --old: nil
D[8855].race=690 --old: nil
D[8856].obj.I={7079,19440,20452,20807} --old: {7079,19440,20452}
D[8856].hide=true --old: nil
D[8857].obj={}
D[8857].obj.I={21534} --old: nil
D[8857].hide=true --old: nil
D[8858].obj={}
D[8858].obj.I={21535} --old: nil
D[8858].hide=true --old: nil
D[8859].obj={}
D[8859].obj.I={21533} --old: nil
D[8859].hide=true --old: nil
D[8860].obj={}
D[8860].obj.I={21545} --old: nil
D[8860].lvl=nil --old: -1
D[8860].hide=true --old: nil
D[8861].obj={}
D[8861].obj.I={21545} --old: nil
D[8861].lvl=nil --old: -1
D[8861].hide=true --old: nil
D[8862].lvl=nil --old: -1
D[8862].hide=true --old: nil
D[8863].lvl=nil --old: -1
D[8863].hide=true --old: nil
D[8864].lvl=nil --old: -1
D[8864].hide=true --old: nil
D[8865].lvl=nil --old: -1
D[8865].hide=true --old: nil
D[8866].hide=true --old: nil
D[8867].obj.I={21557,21558,21559,21571,21574,21576} --old: nil
D[8867].hide=true --old: nil
D[8868].lvl=nil --old: -1
D[8868].hide=true --old: nil
D[8869].skill={id=164,min=0} --old: id=164
D[8870].excl={8867,8871,8872} --old: nil
D[8870].hide=true --old: nil
D[8871].excl={8867,8870,8872} --old: nil
D[8871].hide=true --old: nil
D[8872].excl={8867,8870,8871} --old: nil
D[8872].hide=true --old: nil
D[8873].excl={8867,8874,8875} --old: nil
D[8873].hide=true --old: nil
D[8874].excl={8867,8873,8875} --old: nil
D[8874].hide=true --old: nil
D[8875].excl={8867,8873,8874} --old: nil
D[8875].hide=true --old: nil
D[8876].lvl=nil --old: -1
D[8876].hide=true --old: nil
D[8877].lvl=nil --old: -1
D[8877].hide=true --old: nil
D[8878].lvl=nil --old: -1
D[8878].hide=true --old: nil
D[8879].lvl=nil --old: -1
D[8879].hide=true --old: nil
D[8880].lvl=nil --old: -1
D[8880].hide=true --old: nil
D[8881].lvl=nil --old: -1
D[8881].hide=true --old: nil
D[8882].lvl=nil --old: -1
D[8882].hide=true --old: nil
D[8883].hide=true --old: nil
D[8887].obj={}
D[8887].obj.I={21776} --old: nil
D[8889].obj.I={24337} --old: nil
D[8891].obj={}
D[8891].obj.I={21783} --old: nil
D[8894].pre=nil --old: 9394
D[8895].obj={}
D[8895].obj.I={21807} --old: nil
D[8896].hide=true --old: nil
D[8897].obj={}
D[8897].obj.I={21921} --old: nil
D[8897].excl={8898,8899,8903} --old: nil
D[8897].hide=true --old: nil
D[8898].obj={}
D[8898].obj.I={21920} --old: nil
D[8898].excl={8897,8899,8903} --old: nil
D[8898].hide=true --old: nil
D[8899].obj={}
D[8899].obj.I={21925} --old: nil
D[8899].excl={8897,8898,8903} --old: nil
D[8899].hide=true --old: nil
D[8900].obj={}
D[8900].obj.I={21926} --old: nil
D[8900].excl={8901,8902,8904} --old: nil
D[8900].hide=true --old: nil
D[8901].obj={}
D[8901].obj.I={22264} --old: nil
D[8901].excl={8900,8902,8904} --old: nil
D[8901].hide=true --old: nil
D[8902].obj={}
D[8902].obj.I={22265} --old: nil
D[8902].excl={8900,8901,8904} --old: nil
D[8902].hide=true --old: nil
D[8903].obj.I={11018,22143} --old: {22143}
D[8903].pre=nil --old: nil
D[8903].hide=true --old: nil
D[8904].obj.I={11018,22145} --old: {22145}
D[8904].pre=nil --old: nil
D[8904].hide=true --old: nil
D[8921].pre={8922,8923} --old: nil
D[8922].obj={}
D[8922].obj.I={21985} --old: nil
D[8922].pre={8905,8906,8907,8908,8909,8910,8911,8912,10492} --old: nil
D[8923].obj={}
D[8923].obj.I={22382} --old: nil
D[8923].pre={8913,8914,8915,8916,8917,8918,8919,8920,10493} --old: nil
D[8924].obj.I={21935,21936,21937,21946} --old: {21935,21936,21937}
D[8929].obj={}
D[8929].obj.I={22115} --old: nil
D[8929].pre={8926,8931,8932,8933,8934,8935,8936,8937,10494} --old: nil
D[8930].obj={}
D[8930].obj.I={22115} --old: nil
D[8930].pre={8927,8938,8939,8940,8941,8942,8943,8944} --old: nil
D[8945].pre={8929,8930} --old: nil
D[8946].obj={}
D[8946].obj.I={22139} --old: nil
D[8948].obj={}
D[8948].obj.I={21983} --old: nil
D[8951].obj.I={16715,16718,16719,22047} --old: {16715,16718,16719}
D[8952].obj.I={16675,16678,16679,22047} --old: {16675,16678,16679}
D[8953].obj.I={16682,16687,16689,22047} --old: {16682,16687,16689}
D[8954].obj.I={16725,16728,16729,22047} --old: {16725,16728,16729}
D[8955].obj.I={16691,16694,16695,22047} --old: {16691,16694,16695}
D[8956].obj.I={16708,16709,16711,22047} --old: {16708,16709,16711}
D[8957].obj.I={16668,16669,16670,22047} --old: {16668,16669,16670}
D[8958].obj.I={16699,16701,16704,22047} --old: {16699,16701,16704}
D[8959].obj.I={16732,16733,16734,22047} --old: {16732,16733,16734}
D[8960].pre={8951,8952,8953,8954,8955,8956,8958,8959} --old: nil
D[8961].pre={8960,9032} --old: nil
D[8962].excl={8963,8964,8965} --old: nil
D[8963].excl={8962,8964,8965} --old: nil
D[8964].excl={8962,8963,8965} --old: nil
D[8965].excl={8962,8963,8964} --old: nil
D[8966].obj.I={21984,22049} --old: {21984}
D[8967].obj.I={21984,22050} --old: {21984}
D[8968].obj.I={21984,22051} --old: {21984}
D[8969].obj.I={21984,22052} --old: {21984}
D[8970].obj.I={21984,22094} --old: {22094}
D[8970].pre={8966,8967,8968,8969} --old: nil
D[8977].obj={}
D[8977].obj.I={22115} --old: nil
D[8978].obj={}
D[8978].obj.I={22115} --old: nil
D[8979].hide=true --old: nil
D[8980].race=690 --old: nil
D[8980].hide=true --old: nil
D[8981].hide=true --old: nil
D[8982].hide=true --old: nil
D[8983].hide=true --old: nil
D[8984].excl={9028} --old: nil
D[8984].hide=true --old: nil
D[8985].pre={8964,8970} --old: 8970
D[8986].pre={8965,8970} --old: 8970
D[8987].pre={8962,8970} --old: 8970
D[8988].pre={8963,8970} --old: 8970
D[8989].obj.I={22046,22048,22049} --old: {22046,22048}
D[8990].obj.I={22046,22048,22050} --old: {22046,22048}
D[8991].obj.I={22046,22048,22051} --old: {22046,22048}
D[8992].obj.I={22046,22048,22052} --old: {22046,22048}
D[8993].hide=true --old: nil
D[8994].obj.I={13512,22048,22138} --old: {13512,22138}
D[8994].pre={8989,8990,8991,8992} --old: nil
D[8995].obj.I={22048,22056} --old: {22048}
D[9015].obj.I={21986,22047} --old: {22047}
D[9015].obj.U={16059} --old: {16166}
D[9016].obj.I={16715,16718,16719,22047} --old: {16715,16718,16719}
D[9017].obj.I={16675,16678,16679,22047} --old: {16675,16678,16679}
D[9018].obj.I={16682,16687,16689,21986} --old: {16682,16687,16689}
D[9019].obj.I={16691,16694,16695,22047} --old: {16691,16694,16695}
D[9020].obj.I={16708,16709,16711,22047} --old: {16708,16709,16711}
D[9021].obj.I={16699,16701,16704,22047} --old: {16699,16701,16704}
D[9022].obj.I={16732,16733,16734,22047} --old: {16732,16733,16734}
D[9024].hide=true --old: nil
D[9025].hide=true --old: nil
D[9026].race=1101 --old: nil
D[9026].hide=true --old: nil
D[9027].hide=true --old: nil
D[9028].excl={8984} --old: nil
D[9028].hide=true --old: nil
D[9029].pre={8984,9028} --old: 9028
D[9029].lvl=nil --old: -1
D[9029].hide=true --old: nil
D[9030].obj={}
D[9030].obj.I={22047} --old: nil
D[9032].pre={8957,9016,9017,9018,9019,9020,9021,9022} --old: nil
D[9033].pre={9121,9122,9123} --old: nil
D[9034].repu={id=529,min=9000} --old: id=nil
D[9036].repu={id=529,min=9000} --old: id=nil
D[9037].repu={id=529,min=9000} --old: id=nil
D[9038].repu={id=529,min=9000} --old: id=nil
D[9039].repu={id=529,min=9000} --old: id=nil
D[9040].repu={id=529,min=9000} --old: id=nil
D[9041].repu={id=529,min=9000} --old: id=nil
D[9042].repu={id=529,min=9000} --old: id=nil
D[9043].repu={id=529,min=9000} --old: id=nil
D[9044].repu={id=529,min=9000} --old: id=nil
D[9045].repu={id=529,min=9000} --old: id=nil
D[9046].repu={id=529,min=9000} --old: id=nil
D[9047].repu={id=529,min=9000} --old: id=nil
D[9048].repu={id=529,min=9000} --old: id=nil
D[9049].repu={id=529,min=9000} --old: id=nil
D[9050].repu={id=529,min=9000} --old: id=nil
D[9051].obj.I={22432} --old: nil
D[9054].repu={id=529,min=9000} --old: id=nil
D[9055].repu={id=529,min=9000} --old: id=nil
D[9056].repu={id=529,min=9000} --old: id=nil
D[9057].repu={id=529,min=9000} --old: id=nil
D[9058].repu={id=529,min=9000} --old: id=nil
D[9059].repu={id=529,min=9000} --old: id=nil
D[9060].repu={id=529,min=9000} --old: id=nil
D[9061].repu={id=529,min=9000} --old: id=nil
D[9064].obj={}
D[9064].obj.I={22414} --old: nil
D[9066].obj.I={22473} --old: nil
D[9068].repu={id=529,min=9000} --old: id=nil
D[9069].repu={id=529,min=9000} --old: id=nil
D[9070].repu={id=529,min=9000} --old: id=nil
D[9071].repu={id=529,min=9000} --old: id=nil
D[9072].repu={id=529,min=9000} --old: id=nil
D[9073].repu={id=529,min=9000} --old: id=nil
D[9074].repu={id=529,min=9000} --old: id=nil
D[9075].repu={id=529,min=9000} --old: id=nil
D[9077].repu={id=529,min=9000} --old: id=nil
D[9078].repu={id=529,min=9000} --old: id=nil
D[9079].repu={id=529,min=9000} --old: id=nil
D[9080].repu={id=529,min=9000} --old: id=nil
D[9081].repu={id=529,min=9000} --old: id=nil
D[9082].repu={id=529,min=9000} --old: id=nil
D[9083].repu={id=529,min=9000} --old: id=nil
D[9084].repu={id=529,min=9000} --old: id=nil
D[9085].lvl=nil --old: -1
D[9085].hide=true --old: nil
D[9086].repu={id=529,min=9000} --old: id=nil
D[9087].repu={id=529,min=9000} --old: id=nil
D[9088].repu={id=529,min=9000} --old: id=nil
D[9089].repu={id=529,min=9000} --old: id=nil
D[9090].repu={id=529,min=9000} --old: id=nil
D[9091].repu={id=529,min=9000} --old: id=nil
D[9092].repu={id=529,min=9000} --old: id=nil
D[9093].repu={id=529,min=9000} --old: id=nil
D[9094].lvl=nil --old: -1
D[9095].repu={id=529,min=9000} --old: id=nil
D[9096].repu={id=529,min=9000} --old: id=nil
D[9097].repu={id=529,min=9000} --old: id=nil
D[9098].repu={id=529,min=9000} --old: id=nil
D[9099].repu={id=529,min=9000} --old: id=nil
D[9100].repu={id=529,min=9000} --old: id=nil
D[9101].repu={id=529,min=9000} --old: id=nil
D[9102].repu={id=529,min=9000} --old: id=nil
D[9103].repu={id=529,min=9000} --old: id=nil
D[9104].repu={id=529,min=9000} --old: id=nil
D[9105].repu={id=529,min=9000} --old: id=nil
D[9106].repu={id=529,min=9000} --old: id=nil
D[9107].repu={id=529,min=9000} --old: id=nil
D[9108].repu={id=529,min=9000} --old: id=nil
D[9109].repu={id=529,min=9000} --old: id=nil
D[9110].repu={id=529,min=9000} --old: id=nil
D[9111].repu={id=529,min=9000} --old: id=nil
D[9112].repu={id=529,min=9000} --old: id=nil
D[9113].repu={id=529,min=9000} --old: id=nil
D[9114].repu={id=529,min=9000} --old: id=nil
D[9115].repu={id=529,min=9000} --old: id=nil
D[9116].repu={id=529,min=9000} --old: id=nil
D[9117].repu={id=529,min=9000} --old: id=nil
D[9118].repu={id=529,min=9000} --old: id=nil
D[9120].obj={}
D[9120].obj.I={22520} --old: nil
D[9121].excl={9122,9123} --old: nil
D[9121].repu={id=529,min=9000} --old: id=nil
D[9122].excl={9121,9123} --old: nil
D[9122].repu={id=529,min=21000} --old: id=nil
D[9123].excl={9121,9122} --old: nil
D[9123].repu={id=529,min=42000} --old: id=nil
D[9130].obj={}
D[9130].obj.I={22549} --old: nil
D[9130].repu={id=0,min=0} --old: id=nil
D[9133].obj={}
D[9133].obj.I={22549} --old: nil
D[9134].obj={}
D[9134].obj.I={22550} --old: nil
D[9135].obj={}
D[9135].obj.I={22550} --old: nil
D[9144].min=10 --old: 9
D[9145].repu={id=922,min=3000} --old: id=nil
D[9148].obj={}
D[9148].obj.I={22717} --old: nil
D[9149].pre=9327 --old: nil
D[9150].repu={id=922,min=3000} --old: id=nil
D[9152].pre={9327,9329} --old: nil
D[9153].lvl=nil --old: -1
D[9153].hide=true --old: nil
D[9154].obj={}
D[9154].obj.I={22595} --old: nil
D[9154].lvl=60 --old: -1
D[9154].hide=true --old: nil
D[9155].repu={id=922,min=3000} --old: id=nil
D[9160].repu={id=922,min=3000} --old: id=nil
D[9161].pre=nil --old: nil
D[9162].obj={}
D[9162].obj.I={22706} --old: nil
D[9164].obj.I={22628} --old: nil
D[9165].obj.I={22593} --old: nil
D[9166].obj={}
D[9166].obj.I={22594} --old: nil
D[9168].hide=true --old: nil
D[9171].repu={id=922,min=3000} --old: id=nil
D[9172].obj={}
D[9172].obj.I={22706} --old: nil
D[9173].repu={id=922,min=9000} --old: id=nil
D[9174].obj.I={22675} --old: nil
D[9175].obj={}
D[9175].obj.I={22597} --old: nil
D[9177].obj={}
D[9177].obj.I={22627} --old: nil
D[9178].obj.I={12643,22600} --old: {12643}
D[9179].obj.I={12422,22601} --old: {12422}
D[9180].obj={}
D[9180].obj.I={22627} --old: nil
D[9181].obj.I={12792,22602} --old: {12792}
D[9182].obj.I={12775,22603} --old: {12775}
D[9183].obj.I={12417,22604} --old: {12417}
D[9184].obj.I={15086,22605} --old: {15086}
D[9185].obj.I={15564,22606} --old: {15564}
D[9186].obj.I={15088,22607} --old: {15088}
D[9187].obj.I={15095,22608} --old: {15095}
D[9188].obj.I={14104,22609} --old: {14104}
D[9189].obj={}
D[9189].obj.I={22629} --old: nil
D[9190].obj.I={13864,22610} --old: {13864}
D[9191].obj.I={14046,22611} --old: {14046}
D[9192].repu={id=922,min=3000} --old: id=nil
D[9193].obj.I={22755} --old: nil
D[9194].obj.I={13858,22612} --old: {13858}
D[9195].obj.I={10646,22613} --old: {10646}
D[9196].obj.I={15993,22614} --old: {15993}
D[9197].obj.I={10725,22615} --old: {10725}
D[9198].obj.I={16000,22616} --old: {16000}
D[9200].obj.I={13444,22617} --old: {13444}
D[9201].obj.I={13461,22620} --old: {13461}
D[9202].obj.I={13446,22618} --old: {13446}
D[9203].obj.I={13506,22621} --old: {13506}
D[9204].obj.I={13422,22622} --old: {13422}
D[9205].obj.I={13890,22623} --old: {13890}
D[9206].obj.I={13757,22624} --old: {13757}
D[9208].repu={id=270,min=9000} --old: id=nil
D[9209].repu={id=270,min=9000} --old: id=nil
D[9210].repu={id=270,min=9000} --old: id=nil
D[9221].repu={id=529,min=3000} --old: id=nil
D[9222].repu={id=529,min=3000} --old: id=nil
D[9223].repu={id=529,min=9000} --old: id=nil
D[9224].repu={id=529,min=9000} --old: id=nil
D[9225].repu={id=529,min=21000} --old: id=nil
D[9226].repu={id=529,min=21000} --old: id=nil
D[9227].repu={id=529,min=42000} --old: id=nil
D[9228].repu={id=529,min=42000} --old: id=nil
D[9229].pre=9033 --old: nil
D[9232].pre=9033 --old: nil
D[9233].obj={}
D[9233].obj.I={22719} --old: nil
D[9234].class=3 --old: nil
D[9235].class=3 --old: nil
D[9236].class=3 --old: nil
D[9236].repu={id=529,min=42000} --old: id=nil
D[9237].repu={id=529,min=42000} --old: id=nil
D[9238].class=400 --old: nil
D[9239].class=400 --old: nil
D[9240].class=400 --old: nil
D[9240].repu={id=529,min=42000} --old: id=nil
D[9241].class=1032 --old: nil
D[9242].class=1032 --old: nil
D[9243].class=1032 --old: nil
D[9243].repu={id=529,min=42000} --old: id=nil
D[9244].class=68 --old: nil
D[9245].class=68 --old: nil
D[9246].class=68 --old: nil
D[9246].repu={id=529,min=42000} --old: id=nil
D[9247].obj={}
D[9247].obj.I={22723} --old: nil
D[9247].lvl=nil --old: -1
D[9248].repu={id=609,min=9000} --old: id=nil
D[9249].lvl=nil --old: -1
D[9249].hide=true --old: nil
D[9250].obj={}
D[9250].obj.I={22727} --old: nil
D[9255].obj={}
D[9255].obj.I={22735} --old: nil
D[9257].obj.I={22737} --old: nil
D[9257].excl={9269,9270,9271} --old: nil
D[9259].lvl=nil --old: -1
D[9260].hide=true --old: nil
D[9261].race=1101 --old: nil
D[9261].hide=true --old: nil
D[9262].race=1101 --old: nil
D[9262].hide=true --old: nil
D[9263].hide=true --old: nil
D[9264].hide=true --old: nil
D[9265].hide=true --old: nil
D[9266].lvl=nil --old: -1
D[9267].lvl=nil --old: -1
D[9268].lvl=nil --old: -1
D[9269].obj.I={22737} --old: nil
D[9269].excl={9257,9270,9271} --old: nil
D[9270].obj.I={22737} --old: nil
D[9270].excl={9257,9269,9271} --old: nil
D[9271].obj.I={22737} --old: nil
D[9271].excl={9257,9269,9270} --old: nil
D[9272].repu={id=87,min=1} --old: id=nil
D[9275].obj.I={22796} --old: nil
D[9278].obj={}
D[9278].obj.I={22888} --old: nil
D[9280].pre=nil --old: 9279
D[9280].excl={9369} --old: nil
D[9288].race=1024 --old: nil
D[9289].race=1101 --old: nil
D[9292].obj={}
D[9292].obj.I={22949} --old: nil
D[9292].lvl=nil --old: -1
D[9294].obj.I={22955} --old: nil
D[9295].obj={}
D[9295].obj.I={22932,22977} --old: nil
D[9295].lvl=nil --old: -1
D[9299].obj={}
D[9299].obj.I={22945,22972} --old: nil
D[9299].lvl=nil --old: -1
D[9300].obj={}
D[9300].obj.I={22946,22974} --old: nil
D[9300].lvl=nil --old: -1
D[9301].obj={}
D[9301].obj.I={22930,22970} --old: nil
D[9301].lvl=nil --old: -1
D[9302].obj={}
D[9302].obj.I={22944,22973} --old: nil
D[9302].lvl=nil --old: -1
D[9303].obj.I={22962} --old: nil
D[9303].obj.U={16518} --old: {16534}
D[9304].obj={}
D[9304].obj.I={22948,22975} --old: nil
D[9304].lvl=nil --old: -1
D[9310].obj={}
D[9310].obj.I={22950} --old: nil
D[9310].lvl=nil --old: -1
D[9317].lvl=nil --old: -1
D[9318].lvl=nil --old: -1
D[9319].lvl=nil --old: -1
D[9319].race=2047 --old: nil
D[9319].hide=true --old: nil
D[9320].lvl=nil --old: -1
D[9321].lvl=nil --old: -1
D[9322].lvl=nil --old: -1
D[9322].hide=true --old: nil
D[9323].lvl=nil --old: -1
D[9323].hide=true --old: nil
D[9324].obj={}
D[9324].obj.I={23179} --old: nil
D[9324].lvl=nil --old: -1
D[9324].hide=true --old: nil
D[9325].obj={}
D[9325].obj.I={23180} --old: nil
D[9325].lvl=nil --old: -1
D[9325].hide=true --old: nil
D[9326].obj={}
D[9326].obj.I={23181} --old: nil
D[9326].lvl=nil --old: -1
D[9326].hide=true --old: nil
D[9328].obj={}
D[9328].obj.I={22653} --old: nil
D[9330].obj={}
D[9330].obj.I={23182} --old: nil
D[9330].lvl=nil --old: -1
D[9330].hide=true --old: nil
D[9331].obj={}
D[9331].obj.I={23183} --old: nil
D[9331].lvl=nil --old: -1
D[9331].hide=true --old: nil
D[9332].obj={}
D[9332].obj.I={23184} --old: nil
D[9332].lvl=nil --old: -1
D[9332].hide=true --old: nil
D[9333].lvl=nil --old: -1
D[9334].lvl=nil --old: -1
D[9335].lvl=nil --old: -1
D[9336].lvl=nil --old: -1
D[9337].lvl=nil --old: -1
D[9339].preg={9324,9325,9326,11935} --old: nil
D[9339].lvl=nil --old: -1
D[9339].hide=true --old: nil
D[9341].lvl=nil --old: -1
D[9342].hide=true --old: nil
D[9343].lvl=nil --old: -1
D[9344].hide=true --old: nil
D[9346].hide=true --old: nil
D[9355].pre={10143,10483} --old: 10142
D[9357].hide=true --old: nil
D[9360].start.U={15407} --old: nil
D[9360].obj={}
D[9360].obj.I={23249} --old: nil
D[9361].obj.I={23248,23268,23270} --old: {23248,23270}
D[9364].obj.I={23250} --old: nil
D[9364].lvl=nil --old: -1
D[9365].preg={9330,9331,9332,11933} --old: nil
D[9365].lvl=nil --old: -1
D[9365].hide=true --old: nil
D[9367].lvl=nil --old: -1
D[9367].hide=true --old: nil
D[9368].lvl=nil --old: -1
D[9368].hide=true --old: nil
D[9369].excl={9280} --old: nil
D[9370].obj.I={23358} --old: nil
D[9373].obj={}
D[9373].obj.I={23338} --old: nil
D[9378].hide=true --old: nil
D[9380].hide=true --old: nil
D[9382].hide=true --old: nil
D[9383].obj.I={23417,23442} --old: {23442}
D[9386].lvl=nil --old: -1
D[9386].race=2047 --old: nil
D[9386].hide=true --old: nil
D[9388].hide=true --old: nil
D[9389].hide=true --old: nil
D[9391].obj.I={23480} --old: nil
D[9397].obj.I={23485,23486} --old: {23486}
D[9401].obj={}
D[9401].obj.I={23550} --old: nil
D[9403].obj.I={23552,23566} --old: {23552}
D[9405].obj={}
D[9405].obj.I={23550} --old: nil
D[9406].obj={}
D[9406].obj.I={23569} --old: nil
D[9408].hide=true --old: nil
D[9409].obj={}
D[9409].obj.I={23568} --old: nil
D[9409].pre={9280,9369} --old: nil
D[9409].race=1101 --old: nil
D[9410].obj.I={23669} --old: nil
D[9415].excl=nil --old: nil
D[9416].excl=nil --old: nil
D[9417].pre=nil --old: 9558
D[9418].start.U={17084} --old: nil
D[9418].obj={}
D[9418].obj.I={23580} --old: nil
D[9419].pre=nil --old: 9415
D[9421].pre={9280,9369} --old: nil
D[9422].pre=nil --old: nil
D[9422].race=690 --old: nil
D[9425].race=690 --old: nil
D[9427].obj.I={23361} --old: nil
D[9428].race=512 --old: nil
D[9429].race=1024 --old: nil
D[9433].obj.I={23670,23675} --old: {23670}
D[9434].obj={}
D[9434].obj.I={23644} --old: nil
D[9438].obj={}
D[9438].obj.I={23662} --old: nil
D[9440].obj.I={23659} --old: nil
D[9444].obj.I={23691} --old: nil
D[9444].obj.O={181653} --old: {1323,180204,181653}
D[9446].race=1101 --old: nil
D[9447].obj.I={23394} --old: nil
D[9448].race=1101 --old: nil
D[9449].lvl=4 --old: -1
D[9450].lvl=4 --old: -1
D[9451].obj={}
D[9451].obj.I={23671} --old: nil
D[9451].lvl=4 --old: -1
D[9452].obj.I={23614,23654} --old: {23614}
D[9453].obj={}
D[9453].obj.I={23672} --old: nil
D[9454].pre=nil --old: 9453
D[9455].obj={}
D[9455].obj.I={23678} --old: nil
D[9457].obj.I={23680,23681} --old: {23681}
D[9460].race=690 --old: nil
D[9461].lvl=10 --old: -1
D[9461].race=1101 --old: nil
D[9462].lvl=10 --old: -1
D[9464].lvl=10 --old: -1
D[9465].lvl=10 --old: -1
D[9467].obj.I={23682,23688,24336} --old: {23682,23688}
D[9467].lvl=10 --old: -1
D[9468].obj={}
D[9468].obj.I={23688} --old: nil
D[9468].lvl=10 --old: -1
D[9470].race=1101 --old: nil
D[9472].obj.I={23693,29112} --old: nil
D[9474].race=1101 --old: nil
D[9475].obj.I={23694,23695} --old: {23694}
D[9484].obj.I={23697} --old: nil
D[9484].lvl=nil --old: -1
D[9485].obj.I={23703} --old: nil
D[9485].lvl=nil --old: -1
D[9486].obj.I={23702} --old: nil
D[9486].lvl=nil --old: -1
D[9487].race=690 --old: nil
D[9489].race=512 --old: nil
D[9491].obj.I={5060,23717} --old: {23717}
D[9491].race=690 --old: nil
D[9492].race=1101 --old: nil
D[9494].race=1101 --old: nil
D[9495].race=690 --old: nil
D[9500].excl={10490} --old: nil
D[9501].obj={}
D[9501].obj.I={23871} --old: nil
D[9502].lvl=20 --old: -1
D[9502].race=1101 --old: nil
D[9504].obj.I={23749,23750} --old: {23750}
D[9504].lvl=20 --old: 24
D[9508].obj.I={23751,23997} --old: {23997}
D[9508].lvl=20 --old: 23
D[9509].obj={}
D[9509].obj.I={23752} --old: nil
D[9510].hide=true --old: nil
D[9511].hide=true --old: nil
D[9514].obj={}
D[9514].obj.I={23759} --old: nil
D[9520].obj={}
D[9520].obj.I={23777,23780} --old: nil
D[9521].obj={}
D[9521].obj.I={23778} --old: nil
D[9524].race=1101 --old: nil
D[9525].race=690 --old: nil
D[9526].obj.I={23788} --old: nil
D[9527].pre=nil --old: 10428
D[9529].lvl=nil --old: -1
D[9531].obj.I={23792} --old: nil
D[9531].obj.U={17318} --old: {17243}
D[9532].race=690 --old: nil
D[9535].obj={}
D[9535].obj.I={23797,23798} --old: nil
D[9538].obj={}
D[9538].obj.I={23818} --old: nil
D[9544].obj.I={23801} --old: nil
D[9545].obj.I={23645} --old: nil
D[9545].obj.U={16852} --old: {17413}
D[9547].excl={9551,10491} --old: nil
D[9547].lvl=30 --old: -1
D[9549].pre=nil --old: 10063
D[9550].obj={}
D[9550].obj.I={23837} --old: nil
D[9551].excl={9547,10491} --old: nil
D[9551].lvl=30 --old: -1
D[9552].lvl=30 --old: -1
D[9553].lvl=30 --old: -1
D[9554].obj={}
D[9554].obj.I={23843} --old: nil
D[9554].lvl=30 --old: -1
D[9555].lvl=10 --old: -1
D[9557].obj={}
D[9557].obj.I={23851} --old: nil
D[9558].pre={10143,10483} --old: nil
D[9560].pre=9544 --old: 9538
D[9562].pre=9544 --old: 9538
D[9564].start.U={17475} --old: nil
D[9564].obj={}
D[9564].obj.I={23850} --old: nil
D[9564].pre=9559 --old: 9538
D[9565].pre=9562 --old: 9560
D[9565].preg=nil --old: nil
D[9568].hide=true --old: nil
D[9571].obj={}
D[9571].obj.I={23860} --old: nil
D[9575].pre={10143,10483} --old: 10142
D[9576].start.U={17496} --old: nil
D[9576].obj={}
D[9576].obj.I={23870} --old: nil
D[9581].obj.I={23875,23878} --old: {23878}
D[9582].obj.I={23925} --old: nil
D[9582].race=1101 --old: nil
D[9584].obj.I={23876,23879} --old: {23879}
D[9585].obj.I={23877,23880} --old: {23880}
D[9586].race=1101 --old: nil
D[9587].obj={}
D[9587].obj.I={23890,23891} --old: nil
D[9588].obj={}
D[9588].obj.I={23892,23893} --old: nil
D[9591].obj.I={23896} --old: nil
D[9591].lvl=nil --old: -1
D[9592].obj.I={23897} --old: nil
D[9592].lvl=nil --old: -1
D[9593].obj.I={23898} --old: nil
D[9593].lvl=nil --old: -1
D[9594].start.U={17528} --old: nil
D[9594].obj.I={23900} --old: nil
D[9595].race=1101 --old: nil
D[9598].obj={}
D[9598].obj.I={23926} --old: nil
D[9598].lvl=nil --old: -1
D[9600].obj.I={6866} --old: nil
D[9600].lvl=nil --old: -1
D[9602].obj={}
D[9602].obj.I={23899} --old: nil
D[9603].obj={}
D[9603].obj.I={23902} --old: nil
D[9604].obj={}
D[9604].obj.I={23902} --old: nil
D[9605].obj={}
D[9605].obj.I={23903} --old: nil
D[9606].obj={}
D[9606].obj.I={23903} --old: nil
D[9616].obj={}
D[9616].obj.I={23910} --old: nil
D[9617].excl={10530} --old: nil
D[9617].lvl=nil --old: -1
D[9618].obj={}
D[9618].obj.I={23919} --old: nil
D[9618].race=690 --old: nil
D[9619].obj.I={23732} --old: nil
D[9619].lvl=nil --old: -1
D[9621].obj={}
D[9621].obj.I={23929} --old: nil
D[9623].obj={}
D[9623].obj.I={23928} --old: nil
D[9626].obj={}
D[9626].obj.I={23930} --old: nil
D[9629].obj.I={23995} --old: nil
D[9630].repu={id=967,min=9000} --old: id=nil
D[9631].obj={}
D[9631].obj.I={24152} --old: nil
D[9631].repu={id=967,min=9000} --old: id=nil
D[9632].obj={}
D[9632].obj.I={23937} --old: nil
D[9633].obj={}
D[9633].obj.I={23937} --old: nil
D[9635].race=690 --old: nil
D[9635].skill={id=202,min=305} --old: id=202
D[9636].skill={id=202,min=305} --old: id=202
D[9637].repu={id=967,min=9000} --old: id=nil
D[9638].repu={id=967,min=9000} --old: id=nil
D[9639].repu={id=967,min=9000} --old: id=nil
D[9640].repu={id=967,min=9000} --old: id=nil
D[9644].obj.I={24139,24140} --old: {24139}
D[9644].repu={id=967,min=9000} --old: id=nil
D[9645].obj.I={23934} --old: nil
D[9645].repu={id=967,min=9000} --old: id=nil
D[9663].obj.U={17440,40000,40001} --old: {17116,17240,17440}
D[9666].obj.I={24084} --old: nil
D[9667].obj.I={24099,40001} --old: {24099}
D[9667].obj.U={17682} --old: nil
D[9667].pre=9559 --old: 9538
D[9669].min=16 --old: 17
D[9671].min=15 --old: 18
D[9672].start.O={400000} --old: nil
D[9672].excl={9751} --old: nil
D[9673].lvl=nil --old: -1
D[9674].pre={9672,9751} --old: 9672
D[9675].lvl=nil --old: -1
D[9677].lvl=nil --old: -1
D[9678].lvl=nil --old: -1
D[9680].repu={id=967,min=9000} --old: id=nil
D[9681].lvl=nil --old: -1
D[9684].obj.I={24156,24157} --old: {24156}
D[9684].lvl=nil --old: -1
D[9684].hide=true --old: nil
D[9685].obj.I={24184} --old: nil
D[9685].lvl=nil --old: -1
D[9686].lvl=nil --old: -1
D[9689].obj.I={24221} --old: nil
D[9690].lvl=nil --old: -1
D[9691].lvl=nil --old: -1
D[9692].obj.I={6995,24223,24224,24225,24226} --old: {6995,24224,24225,24226}
D[9696].obj={}
D[9696].obj.I={24399} --old: nil
D[9697].repu={id=942,min=3000} --old: id=nil
D[9698].obj={}
D[9698].obj.I={24323} --old: nil
D[9699].obj={}
D[9699].obj.I={24230} --old: nil
D[9701].pre=nil --old: 9697
D[9701].min=61 --old: 60
D[9704].pre=nil --old: 8347
D[9705].obj={}
D[9705].obj.I={20804} --old: nil
D[9706].obj={}
D[9706].obj.I={24237} --old: nil
D[9707].obj={}
D[9707].obj.I={24239} --old: nil
D[9711].obj.I={24278,40002} --old: nil
D[9712].lvl=nil --old: -1
D[9712].hide=true --old: nil
D[9714].repu={id=970,min=3000} --old: id=nil
D[9715].repu={id=970,min=3000} --old: id=nil
D[9717].repu={id=970,min=0} --old: id=nil
D[9718].obj.I={25465} --old: nil
D[9719].repu={id=970,min=0} --old: id=nil
D[9720].obj.I={24355} --old: nil
D[9721].lvl=nil --old: -1
D[9722].lvl=nil --old: -1
D[9723].obj.I={8838,12360,14047,20520,24277} --old: {8838,12360,14047,20520}
D[9723].lvl=nil --old: -1
D[9725].lvl=nil --old: -1
D[9725].race=690 --old: nil
D[9726].repu={id=970,min=3000} --old: id=nil
D[9727].repu={id=970,min=3000} --old: id=nil
D[9728].pre=nil --old: 9778
D[9729].repu={id=970,min=42000} --old: id=nil
D[9731].obj.I={24330} --old: nil
D[9735].lvl=nil --old: -1
D[9736].lvl=nil --old: -1
D[9737].obj.I={24287} --old: nil
D[9737].lvl=nil --old: -1
D[9738].pre=nil --old: 9876
D[9739].repu={id=0,min=0} --old: id=nil
D[9743].repu={id=0,min=0} --old: id=nil
D[9748].obj.I={24317,24318} --old: {24317}
D[9749].hide=true --old: nil
D[9751].excl={9672} --old: nil
D[9751].hide=true --old: nil
D[9753].pre=nil --old: 9740
D[9753].race=1024 --old: 1101
D[9756].obj.U={17824} --old: {17974}
D[9757].lvl=nil --old: -1
D[9758].pre={9327,9329} --old: nil
D[9759].pre=9756 --old: 9760
D[9760].excl={9759} --old: nil
D[9764].obj={}
D[9764].obj.I={24367} --old: nil
D[9767].hide=true --old: nil
D[9769].race=690 --old: nil
D[9770].race=690 --old: nil
D[9771].race=690 --old: nil
D[9772].race=690 --old: nil
D[9773].obj.I={24374,25539} --old: {24374}
D[9774].obj.I={24375,25539} --old: {24375}
D[9774].race=690 --old: nil
D[9775].obj={}
D[9775].obj.I={24382} --old: nil
D[9775].race=690 --old: nil
D[9776].race=1101 --old: nil
D[9777].race=1101 --old: nil
D[9780].obj.I={24374,25539} --old: {24374}
D[9781].obj.I={25539} --old: nil
D[9781].race=1101 --old: nil
D[9782].race=1101 --old: nil
D[9783].race=1101 --old: nil
D[9785].repu={id=942,min=3000} --old: id=nil
D[9786].race=1101 --old: nil
D[9787].race=1101 --old: nil
D[9790].race=1101 --old: nil
D[9792].repu={id=978,min=0} --old: id=nil
D[9793].obj={}
D[9793].obj.I={24415} --old: nil
D[9793].excl={10104} --old: nil
D[9793].race=1101 --old: nil
D[9794].obj={}
D[9794].obj.I={26048} --old: nil
D[9796].excl={10105} --old: nil
D[9796].min=62 --old: 60
D[9798].start.U={16522} --old: nil
D[9798].obj={}
D[9798].obj.I={23003,24414} --old: nil
D[9801].race=1101 --old: nil
D[9803].obj.I={24428,24573} --old: {24573}
D[9803].race=1101 --old: nil
D[9805].obj.I={24467} --old: nil
D[9806].repu={id=970,min=0} --old: id=nil
D[9807].repu={id=970,min=0} --old: id=nil
D[9808].repu={id=970,min=0} --old: id=nil
D[9811].obj={}
D[9811].obj.I={22653} --old: nil
D[9812].obj={}
D[9812].obj.I={23929} --old: nil
D[9813].obj={}
D[9813].obj.I={23930} --old: nil
D[9814].race=690 --old: nil
D[9816].obj.I={24470} --old: nil
D[9816].race=690 --old: nil
D[9821].obj.I={24473,24475} --old: {24473}
D[9822].race=690 --old: nil
D[9823].race=690 --old: nil
D[9824].obj.I={24474} --old: nil
D[9826].obj={}
D[9826].obj.I={24482} --old: nil
D[9826].preg={9824,9825} --old: nil
D[9827].obj={}
D[9827].obj.I={24483} --old: nil
D[9828].obj={}
D[9828].obj.I={24484} --old: nil
D[9830].race=1101 --old: nil
D[9830].repu={id=978,min=0} --old: id=nil
D[9833].race=1101 --old: nil
D[9833].repu={id=978,min=0} --old: id=nil
D[9834].obj.I={24486,25539} --old: {24486}
D[9834].repu={id=978,min=0} --old: id=nil
D[9836].obj={}
D[9836].obj.I={24489} --old: nil
D[9841].race=690 --old: nil
D[9842].race=690 --old: nil
D[9845].obj.I={25539} --old: nil
D[9846].race=690 --old: nil
D[9847].obj.I={24498} --old: nil
D[9847].race=690 --old: nil
D[9849].obj.I={24501} --old: nil
D[9852].preg={9851,9856,9859} --old: nil
D[9861].obj={}
D[9861].obj.I={24504} --old: nil
D[9863].repu={id=941,min=0} --old: id=nil
D[9864].race=690 --old: nil
D[9864].repu={id=941,min=0} --old: id=nil
D[9865].race=690 --old: nil
D[9866].race=690 --old: nil
D[9867].race=690 --old: nil
D[9867].repu={id=941,min=0} --old: id=nil
D[9868].repu={id=941,min=0} --old: id=nil
D[9869].repu={id=978,min=0} --old: id=nil
D[9871].start.U={18238} --old: nil
D[9871].obj={}
D[9871].obj.I={24559} --old: nil
D[9872].start.U={18238} --old: nil
D[9872].obj={}
D[9872].obj.I={24558} --old: nil
D[9874].obj.I={24560} --old: nil
D[9874].repu={id=978,min=0} --old: id=nil
D[9875].obj={}
D[9875].obj.I={24407} --old: nil
D[9878].race=1101 --old: nil
D[9878].repu={id=978,min=0} --old: id=nil
D[9879].repu={id=978,min=0} --old: id=nil
D[9884].repu={id=933,min=9000} --old: id=nil
D[9885].repu={id=933,min=21000} --old: id=nil
D[9886].repu={id=933,min=3000} --old: id=nil
D[9887].repu={id=933,min=42000} --old: id=nil
D[9892].repu={id=933,min=3000} --old: id=nil
D[9893].repu={id=933,min=3000} --old: id=nil
D[9896].race=1101 --old: nil
D[9897].obj={}
D[9897].obj.I={25449} --old: nil
D[9898].race=690 --old: nil
D[9899].race=690 --old: nil
D[9902].obj.I={25539} --old: nil
D[9902].race=1101 --old: nil
D[9902].repu={id=978,min=0} --old: id=nil
D[9903].obj.I={25539} --old: nil
D[9904].obj.I={25539} --old: nil
D[9905].obj.I={25539} --old: nil
D[9905].race=1101 --old: nil
D[9905].repu={id=978,min=0} --old: id=nil
D[9910].obj.I={25458} --old: nil
D[9911].start.U={18285} --old: nil
D[9911].obj={}
D[9911].obj.I={25459} --old: nil
D[9913].excl={9882} --old: nil
D[9919].obj={}
D[9919].obj.I={25491} --old: nil
D[9919].repu={id=970,min=0} --old: id=nil
D[9923].obj.I={25490} --old: nil
D[9923].repu={id=978,min=0} --old: id=nil
D[9924].obj.I={25509} --old: nil
D[9927].obj.I={25552} --old: nil
D[9927].pre={10107,10108} --old: nil
D[9928].pre={10107,10108} --old: nil
D[9929].hide=true --old: nil
D[9930].hide=true --old: nil
D[9931].obj.I={25555} --old: nil
D[9931].preg={9927,9928} --old: nil
D[9932].obj.I={25658} --old: nil
D[9932].preg={9927,9928} --old: nil
D[9933].obj={}
D[9933].obj.I={25586} --old: nil
D[9933].preg={9931,9932} --old: nil
D[9934].obj={}
D[9934].obj.I={25586} --old: nil
D[9934].preg={9931,9932} --old: nil
D[9935].obj.U={18391} --old: {17146,17147,17148,18391,18397,18658,21276}
D[9935].repu={id=941,min=0} --old: id=nil
D[9936].obj.U={18391} --old: {17146,17147,17148,18391,18397,18658,21276}
D[9936].repu={id=978,min=0} --old: id=nil
D[9937].preg={9935,9939} --old: nil
D[9938].preg={9936,9940} --old: nil
D[9939].repu={id=941,min=0} --old: id=nil
D[9940].repu={id=978,min=0} --old: id=nil
D[9941].hide=true --old: nil
D[9942].hide=true --old: nil
D[9943].hide=true --old: nil
D[9944].repu={id=941,min=0} --old: id=nil
D[9947].hide=true --old: nil
D[9948].repu={id=941,min=0} --old: id=nil
D[9949].hide=true --old: nil
D[9950].hide=true --old: nil
D[9952].hide=true --old: nil
D[9953].hide=true --old: nil
D[9955].obj.I={25648} --old: nil
D[9955].hide=true --old: nil
D[9956].race=1101 --old: nil
D[9956].repu={id=978,min=0} --old: id=nil
D[9957].excl={9960,9961} --old: nil
D[9957].repu={id=942,min=3000} --old: id=nil
D[9958].hide=true --old: nil
D[9959].hide=true --old: nil
D[9960].excl={9957,9961} --old: nil
D[9961].excl={9957,9960} --old: nil
D[9963].hide=true --old: nil
D[9964].hide=true --old: nil
D[9965].hide=true --old: nil
D[9966].hide=true --old: nil
D[9969].hide=true --old: nil
D[9974].hide=true --old: nil
D[9975].obj.I={25684} --old: nil
D[9975].hide=true --old: nil
D[9976].obj.I={25684} --old: nil
D[9976].hide=true --old: nil
D[9978].preg={9968,9971} --old: nil
D[9980].hide=true --old: nil
D[9981].hide=true --old: nil
D[9982].excl={9991} --old: nil
D[9982].repu={id=978,min=0} --old: id=nil
D[9983].excl={9991} --old: nil
D[9984].obj={}
D[9984].obj.I={25705} --old: nil
D[9984].hide=true --old: nil
D[9985].obj={}
D[9985].obj.I={25706} --old: nil
D[9985].hide=true --old: nil
D[9988].hide=true --old: nil
D[9989].hide=true --old: nil
D[9991].pre=nil --old: nil
D[9994].obj={}
D[9994].obj.I={25746} --old: nil
D[9995].obj={}
D[9995].obj.I={25746} --old: nil
D[10000].min=62 --old: 60
D[10004].obj={}
D[10004].obj.I={25751} --old: nil
D[10009].obj.I={25766,25767,25768,25769} --old: {25767,25768,25769}
D[10012].obj={}
D[10012].obj.I={25765} --old: nil
D[10012].pre={9998,10000} --old: nil
D[10013].obj={}
D[10013].obj.I={25765} --old: nil
D[10013].pre={9998,10000} --old: nil
D[10014].hide=true --old: nil
D[10015].hide=true --old: nil
D[10017].pre=10211 --old: nil
D[10019].pre=10211 --old: 10017
D[10020].repu={id=932,min=3000} --old: id=nil
D[10021].obj.I={25817} --old: nil
D[10021].repu={id=932,min=3000} --old: id=nil
D[10024].pre=10211 --old: nil
D[10025].pre=10211 --old: 10024
D[10029].obj.I={25840} --old: nil
D[10029].hide=true --old: nil
D[10039].min=62 --old: 61
D[10040].obj.U={18716,18717,18719} --old: {26464,26465,26466}
D[10041].obj.U={18716,18717,18719} --old: {26464,26465,26466}
D[10044].pre=10011 --old: {9868,9934,10011}
D[10044].preg={9868,9934} --old: nil
D[10045].obj.I={25862,25863,25864,25865,25866} --old: {25862,25863,25864,25865}
D[10046].hide=true --old: nil
D[10047].obj.I={25889} --old: nil
D[10047].pre={10143,10483} --old: nil
D[10050].pre={10143,10483} --old: nil
D[10053].hide=true --old: nil
D[10054].hide=true --old: nil
D[10056].hide=true --old: nil
D[10058].pre={10143,10483} --old: nil
D[10059].hide=true --old: nil
D[10060].hide=true --old: nil
D[10061].hide=true --old: nil
D[10062].hide=true --old: nil
D[10063].excl={9549} --old: nil
D[10066].start.U={17986,18020} --old: {17986}
D[10067].start.U={17986,18020} --old: {17986}
D[10068].start.U={15279} --old: {15280}
D[10068].pre=8328 --old: 9676
D[10068].excl={8330} --old: nil
D[10069].start.U={15280} --old: {15279}
D[10069].pre=9676 --old: 8328
D[10069].excl={8330} --old: nil
D[10070].excl={8330} --old: nil
D[10071].excl={8330} --old: nil
D[10072].excl={8330} --old: nil
D[10073].excl={8330} --old: nil
D[10074].race=690 --old: nil
D[10075].race=690 --old: nil
D[10076].race=1101 --old: nil
D[10077].race=1101 --old: nil
D[10078].obj.I={26002} --old: nil
D[10079].pre={10143,10483} --old: 10142
D[10084].hide=true --old: nil
D[10087].obj.I={27479} --old: nil
D[10088].hide=true --old: nil
D[10089].hide=true --old: nil
D[10090].hide=true --old: nil
D[10092].hide=true --old: nil
D[10094].pre=10211 --old: nil
D[10095].pre=10211 --old: nil
D[10098].obj.I={27632,27633,27634,32888} --old: {27632,27633,27634}
D[10100].hide=true --old: nil
D[10104].excl={9793} --old: nil
D[10104].race=1101 --old: nil
D[10105].excl={9796} --old: nil
D[10105].race=690 --old: nil
D[10106].pre={10143,10483} --old: nil
D[10106].repu={id=946,min=0} --old: id=nil
D[10110].pre=10124 --old: nil
D[10110].repu={id=947,min=0} --old: id=nil
D[10113].excl={9789,9854,9857} --old: nil
D[10113].min=64 --old: 63
D[10114].excl={9789,9854,9857} --old: nil
D[10115].race=1101 --old: nil
D[10118].race=690 --old: nil
D[10120].obj={}
D[10120].obj.I={28024} --old: nil
D[10120].pre=nil --old: 9407
D[10122].hide=true --old: nil
D[10125].obj.I={28478} --old: nil
D[10125].hide=true --old: nil
D[10126].hide=true --old: nil
D[10127].hide=true --old: nil
D[10128].hide=true --old: nil
D[10129].obj.I={28038,40000} --old: nil
D[10130].hide=true --old: nil
D[10131].hide=true --old: nil
D[10133].hide=true --old: nil
D[10134].obj={}
D[10134].obj.I={29476} --old: nil
D[10135].obj={}
D[10135].obj.I={28046} --old: nil
D[10135].hide=true --old: nil
D[10137].obj.I={28047,28048} --old: {28047}
D[10137].hide=true --old: nil
D[10138].hide=true --old: nil
D[10139].hide=true --old: nil
D[10140].obj={}
D[10140].obj.I={28105} --old: nil
D[10144].obj.I={28106,28513} --old: {28513}
D[10145].hide=true --old: nil
D[10146].obj.I={28038} --old: nil
D[10147].hide=true --old: nil
D[10148].obj={}
D[10148].obj.I={28107} --old: nil
D[10148].hide=true --old: nil
D[10149].hide=true --old: nil
D[10150].hide=true --old: nil
D[10151].hide=true --old: nil
D[10152].hide=true --old: nil
D[10153].hide=true --old: nil
D[10154].hide=true --old: nil
D[10155].obj.I={28047,28048} --old: {28047}
D[10155].hide=true --old: nil
D[10156].hide=true --old: nil
D[10157].hide=true --old: nil
D[10158].hide=true --old: nil
D[10162].obj.I={28132,40000} --old: nil
D[10163].obj.I={28132} --old: nil
D[10166].obj.I={28209} --old: nil
D[10169].obj={}
D[10169].obj.I={28287} --old: nil
D[10169].repu={id=934,min=3000} --old: id=nil
D[10169].hide=true --old: nil
D[10173].obj.I={28292,29207} --old: {28292}
D[10174].obj={}
D[10174].obj.I={28455} --old: nil
D[10179].hide=true --old: nil
D[10182].obj.I={28351,29233} --old: nil
D[10183].obj={}
D[10183].obj.I={28359} --old: nil
D[10183].excl={11036,11037,11038,11039,11040,11042} --old: nil
D[10187].hide=true --old: nil
D[10188].obj.I={28368,28455} --old: {28368}
D[10189].repu={id=934,min=3000} --old: id=nil
D[10190].obj.I={28369} --old: nil
D[10190].obj.U={18879} --old: {19595}
D[10192].obj.I={28455,28472,28473,28474} --old: {28472,28473,28474}
D[10193].repu={id=934,min=3000} --old: id=nil
D[10194].repu={id=934,min=3000} --old: id=nil
D[10195].hide=true --old: nil
D[10196].hide=true --old: nil
D[10197].repu={id=934,min=3000} --old: id=nil
D[10198].obj.I={28607} --old: nil
D[10198].repu={id=934,min=3000} --old: id=nil
D[10202].repu={id=934,min=3000} --old: id=nil
D[10203].obj.I={30354} --old: nil
D[10204].obj={}
D[10204].obj.I={28452} --old: nil
D[10204].repu={id=934,min=3000} --old: id=nil
D[10207].hide=true --old: nil
D[10208].obj.I={28478,28513} --old: {28513}
D[10209].obj.I={28455,28479} --old: {28479}
D[10214].hide=true --old: nil
D[10221].obj.I={29429} --old: nil
D[10222].pre=10188 --old: nil
D[10225].obj={}
D[10225].obj.I={28526} --old: nil
D[10226].obj.I={28547,28548} --old: {28548}
D[10229].obj={}
D[10229].obj.I={28552} --old: nil
D[10240].obj.I={28725} --old: nil
D[10241].repu={id=932,min=3000} --old: id=nil
D[10242].obj={}
D[10242].obj.I={30404} --old: nil
D[10243].obj={}
D[10243].obj.I={28571} --old: nil
D[10243].pre=10241 --old: nil
D[10243].repu={id=932,min=3000} --old: id=nil
D[10244].obj={}
D[10244].obj.I={28598} --old: nil
D[10244].hide=true --old: nil
D[10245].obj={}
D[10245].obj.I={28580} --old: nil
D[10245].repu={id=932,min=3000} --old: id=nil
D[10246].pre=10299 --old: 10313
D[10246].repu={id=932,min=3000} --old: id=nil
D[10248].obj.I={28634} --old: nil
D[10250].obj.I={28651} --old: nil
D[10252].obj.I={28664,28665,28667,28668} --old: {28665,28667,28668}
D[10255].obj.I={23337} --old: nil
D[10256].obj.U={19938} --old: nil
D[10260].hide=true --old: nil
D[10263].preg={10186,10551} --old: nil
D[10263].excl={10264} --old: nil
D[10263].repu={id=932,min=3000} --old: id=nil
D[10264].preg={10186,10552} --old: nil
D[10264].excl={10263} --old: nil
D[10264].repu={id=934,min=3000} --old: id=nil
D[10265].pre=nil --old: nil
D[10268].obj={}
D[10268].obj.I={28934} --old: nil
D[10269].obj.I={28962} --old: nil
D[10274].obj.I={29101} --old: nil
D[10275].obj.I={29018} --old: nil
D[10278].obj.I={29027,29051} --old: {29051}
D[10280].obj={}
D[10280].obj.I={29106} --old: nil
D[10283].obj.I={25853} --old: nil
D[10288].obj={}
D[10288].obj.I={28105} --old: nil
D[10288].pre=nil --old: 10119
D[10289].obj={}
D[10289].obj.I={28024} --old: nil
D[10292].hide=true --old: nil
D[10295].obj.I={29162,29226} --old: {29162}
D[10297].obj.I={24289} --old: nil
D[10299].repu={id=932,min=3000} --old: id=nil
D[10301].obj.I={28455,28475} --old: {28475}
D[10302].pre=nil --old: 9371
D[10304].race=1101 --old: nil
D[10305].obj.I={28336,29234} --old: nil
D[10306].obj.I={28352,29235} --old: nil
D[10307].obj.I={28353,29236} --old: nil
D[10308].repu={id=933,min=3000} --old: id=nil
D[10309].obj.I={29260,29447} --old: {29260}
D[10310].pre=nil --old: 10311
D[10313].obj.I={29324} --old: nil
D[10313].repu={id=932,min=3000} --old: id=nil
D[10321].repu={id=932,min=3000} --old: id=nil
D[10322].repu={id=932,min=3000} --old: id=nil
D[10323].repu={id=932,min=3000} --old: id=nil
D[10325].pre=10211 --old: nil
D[10325].repu={id=932,min=0} --old: id=nil
D[10326].repu={id=932,min=0} --old: id=nil
D[10327].repu={id=932,min=0} --old: id=nil
D[10328].preg={10313,10321} --old: nil
D[10328].repu={id=932,min=3000} --old: id=nil
D[10329].repu={id=934,min=3000} --old: id=nil
D[10330].repu={id=934,min=3000} --old: id=nil
D[10334].obj={}
D[10334].obj.I={29428} --old: nil
D[10335].obj.I={29445} --old: nil
D[10338].repu={id=934,min=3000} --old: id=nil
D[10341].repu={id=934,min=3000} --old: id=nil
D[10345].obj.I={29473} --old: nil
D[10346].obj.I={28132} --old: nil
D[10347].obj.I={28132} --old: nil
D[10349].obj={}
D[10349].obj.I={29477} --old: nil
D[10351].obj.I={29478} --old: nil
D[10352].lvl=nil --old: -1
D[10354].lvl=nil --old: -1
D[10355].race=1101 --old: nil
D[10356].lvl=nil --old: -1
D[10357].lvl=nil --old: -1
D[10358].lvl=nil --old: -1
D[10359].lvl=nil --old: -1
D[10360].lvl=nil --old: -1
D[10361].lvl=nil --old: -1
D[10362].lvl=nil --old: -1
D[10363].lvl=nil --old: -1
D[10365].repu={id=934,min=3000} --old: id=nil
D[10366].lvl=nil --old: -1
D[10367].pre=nil --old: 10403
D[10368].obj.I={29501} --old: nil
D[10369].obj.I={29513} --old: nil
D[10370].hide=true --old: nil
D[10372].race=690 --old: nil
D[10375].hide=true --old: nil
D[10377].hide=true --old: nil
D[10379].race=690 --old: nil
D[10380].repu={id=932,min=3000} --old: id=nil
D[10381].repu={id=932,min=3000} --old: id=nil
D[10386].hide=true --old: nil
D[10387].hide=true --old: nil
D[10388].start.U={16576,19273} --old: {19273}
D[10388].pre=10129 --old: 10162
D[10393].obj={}
D[10393].obj.I={29589,29590} --old: nil
D[10395].obj={}
D[10395].obj.I={29588,29589} --old: nil
D[10398].hide=true --old: nil
D[10401].hide=true --old: nil
D[10403].start.U={20677,20678,20679} --old: {20678}
D[10404].hide=true --old: nil
D[10407].repu={id=932,min=3000} --old: id=nil
D[10408].obj.I={29618} --old: nil
D[10409].obj.I={29796} --old: nil
D[10409].repu={id=932,min=3000} --old: id=nil
D[10410].obj={}
D[10410].obj.I={29699} --old: nil
D[10410].repu={id=932,min=3000} --old: id=nil
D[10411].obj.I={29737} --old: nil
D[10412].pre=10211 --old: nil
D[10412].repu={id=934,min=0} --old: id=nil
D[10413].obj={}
D[10413].obj.I={29738} --old: nil
D[10414].repu={id=934,min=0} --old: id=nil
D[10415].repu={id=934,min=0} --old: id=nil
D[10416].repu={id=934,min=0} --old: id=nil
D[10419].repu={id=934,min=0} --old: id=nil
D[10420].repu={id=932,min=0} --old: id=nil
D[10421].repu={id=932,min=0} --old: id=nil
D[10424].obj.I={29769,29803} --old: {29769}
D[10426].obj.I={29818} --old: nil
D[10426].obj.U={20774} --old: {20983}
D[10427].obj.I={29817} --old: nil
D[10427].obj.U={20610,20777} --old: {20982}
D[10430].obj={}
D[10430].obj.I={29770} --old: nil
D[10431].repu={id=932,min=3000} --old: id=nil
D[10432].repu={id=934,min=3000} --old: id=nil
D[10438].obj.I={29778} --old: nil
D[10441].hide=true --old: nil
D[10445].hide=true --old: nil
D[10449].obj={}
D[10449].obj.I={30326} --old: nil
D[10457].obj.I={29952} --old: nil
D[10458].obj.I={30094} --old: nil
D[10458].pre=nil --old: nil
D[10459].repu={id=942,min=21000} --old: id=nil
D[10460].excl={10461,10462,10463} --old: nil
D[10460].repu={id=990,min=3000} --old: id=nil
D[10460].hide=true --old: nil
D[10461].excl={10460,10462,10463} --old: nil
D[10461].repu={id=990,min=3000} --old: id=nil
D[10461].hide=true --old: nil
D[10462].excl={10460,10461,10463} --old: nil
D[10462].repu={id=990,min=3000} --old: id=nil
D[10462].hide=true --old: nil
D[10463].excl={10460,10461,10462} --old: nil
D[10463].repu={id=990,min=3000} --old: id=nil
D[10463].hide=true --old: nil
D[10464].obj={}
D[10464].obj.I={29302} --old: nil
D[10464].repu={id=990,min=3000} --old: id=nil
D[10464].hide=true --old: nil
D[10465].obj={}
D[10465].obj.I={29307} --old: nil
D[10465].repu={id=990,min=9000} --old: id=nil
D[10465].hide=true --old: nil
D[10466].obj={}
D[10466].obj.I={29298} --old: nil
D[10466].hide=true --old: nil
D[10467].obj={}
D[10467].obj.I={29294} --old: nil
D[10467].hide=true --old: nil
D[10468].obj={}
D[10468].obj.I={29303} --old: nil
D[10468].repu={id=990,min=9000} --old: id=nil
D[10468].hide=true --old: nil
D[10469].obj={}
D[10469].obj.I={29306} --old: nil
D[10469].repu={id=990,min=9000} --old: id=nil
D[10469].hide=true --old: nil
D[10470].obj={}
D[10470].obj.I={29299} --old: nil
D[10470].hide=true --old: nil
D[10471].obj={}
D[10471].obj.I={29295} --old: nil
D[10471].hide=true --old: nil
D[10472].obj={}
D[10472].obj.I={29304} --old: nil
D[10472].repu={id=990,min=21000} --old: id=nil
D[10472].hide=true --old: nil
D[10473].obj={}
D[10473].obj.I={29308} --old: nil
D[10473].repu={id=990,min=21000} --old: id=nil
D[10473].hide=true --old: nil
D[10474].obj={}
D[10474].obj.I={29300} --old: nil
D[10474].hide=true --old: nil
D[10475].obj={}
D[10475].obj.I={29296} --old: nil
D[10475].repu={id=990,min=21000} --old: id=nil
D[10475].hide=true --old: nil
D[10476].repu={id=978,min=0} --old: id=nil
D[10479].repu={id=941,min=0} --old: id=nil
D[10480].obj.I={30094} --old: nil
D[10481].obj.I={30094} --old: nil
D[10488].obj.I={30175} --old: nil
D[10488].obj.U={20748} --old: {21142}
D[10490].excl={9500} --old: nil
D[10490].lvl=20 --old: -1
D[10491].excl={9547,9551} --old: nil
D[10491].lvl=30 --old: -1
D[10496].obj.I={16668,16669,16670,22047} --old: {16668,16669,16670}
D[10497].obj.I={16725,16728,16729,22047} --old: {16725,16728,16729}
D[10500].excl={8792,8793,8794} --old: nil
D[10503].obj.U={20728} --old: {19995,19998,20334,20723,20726,20728,20730,20731,20732,21296,21975}
D[10506].obj.I={30251} --old: nil
D[10506].obj.U={20058} --old: {21176}
D[10507].obj.I={29796,30259,30260} --old: {29796,30259}
D[10507].repu={id=934,min=3000} --old: id=nil
D[10508].repu={id=934,min=3000} --old: id=nil
D[10509].repu={id=934,min=3000} --old: id=nil
D[10512].obj.I={30353} --old: nil
D[10514].obj.I={30356,30462} --old: {30356}
D[10523].obj={}
D[10523].obj.I={30429} --old: nil
D[10524].obj.I={30431,30432,30433,30434} --old: {30432,30433,30434}
D[10525].obj.I={30481} --old: nil
D[10529].lvl=nil --old: -1
D[10530].excl={9617} --old: nil
D[10530].lvl=nil --old: -1
D[10541].obj={}
D[10541].obj.I={30454} --old: nil
D[10544].obj.I={30479} --old: nil
D[10545].obj.I={30353} --old: nil
D[10548].race=690 --old: nil
D[10550].obj={}
D[10550].obj.I={30501} --old: nil
D[10551].excl={10552} --old: nil
D[10552].excl={10551} --old: nil
D[10553].repu={id=934,min=3000} --old: id=nil
D[10554].repu={id=932,min=3000} --old: id=nil
D[10556].obj.I={30530} --old: nil
D[10558].repu={id=946,min=21000} --old: id=nil
D[10559].repu={id=947,min=21000} --old: id=nil
D[10560].repu={id=935,min=21000} --old: id=nil
D[10560].hide=true --old: nil
D[10561].repu={id=989,min=21000} --old: id=nil
D[10563].obj.I={30638} --old: nil
D[10564].obj.I={30614} --old: nil
D[10566].obj.I={30650,30655} --old: {30655}
D[10568].excl={10683} --old: nil
D[10568].repu={id=932,min=3000} --old: id=nil
D[10570].obj.I={30616,30617} --old: {30617}
D[10571].repu={id=932,min=3000} --old: id=nil
D[10574].repu={id=932,min=3000} --old: id=nil
D[10575].repu={id=932,min=3000} --old: id=nil
D[10577].obj.I={30639} --old: nil
D[10579].obj={}
D[10579].obj.I={30646} --old: nil
D[10580].excl={10584} --old: nil
D[10581].excl={10584} --old: nil
D[10584].obj.I={30656} --old: nil
D[10584].obj.U={21729,21731} --old: {21731}
D[10584].pre=nil --old: 10581
D[10586].obj.I={30688,30689} --old: {30689}
D[10586].preg={10583,10585} --old: nil
D[10587].repu={id=932,min=3000} --old: id=nil
D[10588].obj.I={30657} --old: nil
D[10588].preg={10523,10541,10579} --old: nil
D[10592].obj={}
D[10592].obj.I={30700} --old: nil
D[10594].obj.I={30701} --old: nil
D[10596].obj.I={30638} --old: nil
D[10598].obj.I={30614} --old: nil
D[10603].obj.I={30688,30689} --old: {30689}
D[10603].preg={10601,10602} --old: nil
D[10605].lvl=nil --old: -1
D[10605].race=690 --old: nil
D[10609].obj.I={30742,30743,30782,30783} --old: {30743,30782,30783}
D[10619].excl={10807} --old: nil
D[10619].repu={id=932,min=3000} --old: id=nil
D[10621].obj={}
D[10621].obj.I={30756} --old: nil
D[10622].pre={10575,10686} --old: nil
D[10623].obj={}
D[10623].obj.I={30579} --old: nil
D[10625].obj.I={30719} --old: nil
D[10629].obj.I={30794,30803} --old: {30794}
D[10633].obj.I={30721} --old: nil
D[10634].pre={10633,10644} --old: nil
D[10635].pre={10633,10644} --old: nil
D[10636].pre={10633,10644} --old: nil
D[10637].repu={id=932,min=3000} --old: id=nil
D[10639].preg={10634,10635,10636} --old: nil
D[10640].repu={id=932,min=3000} --old: id=nil
D[10641].pre={10640,10689} --old: nil
D[10643].obj.I={30719} --old: nil
D[10644].obj.I={30721} --old: nil
D[10645].preg={10634,10635,10636} --old: nil
D[10646].preg={10641,10668,10669} --old: nil
D[10650].repu={id=932,min=3000} --old: id=nil
D[10651].obj.I={30854} --old: nil
D[10651].repu={id=932,min=3000} --old: id=nil
D[10652].repu={id=934,min=3000} --old: id=nil
D[10653].pre=10211 --old: nil
D[10653].repu={id=932,min=0} --old: id=nil
D[10654].repu={id=932,min=0} --old: id=nil
D[10655].repu={id=932,min=0} --old: id=nil
D[10656].pre=10211 --old: nil
D[10656].repu={id=934,min=0} --old: id=nil
D[10657].obj.I={30818,30849} --old: {30849}
D[10658].repu={id=934,min=0} --old: id=nil
D[10659].repu={id=934,min=0} --old: id=nil
D[10662].obj={}
D[10662].obj.I={30822} --old: nil
D[10663].obj={}
D[10663].obj.I={30822} --old: nil
D[10664].pre={10662,10663} --old: nil
D[10667].preg={10665,10666} --old: nil
D[10668].pre={10640,10689} --old: nil
D[10669].obj.I={30853} --old: nil
D[10669].pre={10640,10689} --old: nil
D[10670].preg={10665,10666} --old: nil
D[10674].obj.I={30852} --old: nil
D[10674].obj.U={20635} --old: {21929}
D[10676].preg={10667,10670} --old: nil
D[10679].obj.I={30875,30876} --old: {30876}
D[10683].pre=10552 --old: nil
D[10683].excl={10568} --old: nil
D[10683].repu={id=934,min=3000} --old: id=nil
D[10684].repu={id=934,min=3000} --old: id=nil
D[10685].repu={id=934,min=3000} --old: id=nil
D[10686].repu={id=934,min=3000} --old: id=nil
D[10687].pre=10552 --old: nil
D[10687].repu={id=934,min=3000} --old: id=nil
D[10688].repu={id=934,min=3000} --old: id=nil
D[10689].repu={id=934,min=3000} --old: id=nil
D[10691].repu={id=934,min=3000} --old: id=nil
D[10692].obj.I={30854} --old: nil
D[10692].repu={id=934,min=3000} --old: id=nil
D[10708].obj={}
D[10708].obj.I={32646} --old: nil
D[10710].obj={}
D[10710].obj.I={30540} --old: nil
D[10710].pre={10557,10584} --old: 10584
D[10711].preg={10657,10710} --old: nil
D[10712].obj.I={31123,31124} --old: {31123}
D[10712].preg={10675,10711} --old: nil
D[10714].obj.I={31128} --old: nil
D[10716].hide=true --old: nil
D[10719].obj={}
D[10719].obj.I={31120} --old: nil
D[10720].obj.I={31141} --old: nil
D[10721].obj.I={31349,31350} --old: {31349}
D[10723].obj.I={31752,31754} --old: {31754}
D[10724].obj.I={31144,31755} --old: {31755}
D[10725].obj={}
D[10725].obj.I={29286} --old: nil
D[10725].repu={id=967,min=21000} --old: id=nil
D[10726].obj={}
D[10726].obj.I={29291} --old: nil
D[10726].repu={id=967,min=21000} --old: id=nil
D[10727].obj={}
D[10727].obj.I={29282} --old: nil
D[10727].repu={id=967,min=21000} --old: id=nil
D[10728].obj={}
D[10728].obj.I={29278} --old: nil
D[10728].repu={id=967,min=21000} --old: id=nil
D[10729].excl={10730,10731,10732} --old: nil
D[10729].repu={id=967,min=3000} --old: id=nil
D[10730].excl={10729,10731,10732} --old: nil
D[10730].repu={id=967,min=3000} --old: id=nil
D[10731].excl={10729,10730,10732} --old: nil
D[10731].repu={id=967,min=3000} --old: id=nil
D[10732].excl={10729,10730,10731} --old: nil
D[10732].repu={id=967,min=3000} --old: id=nil
D[10733].obj={}
D[10733].obj.I={29284} --old: nil
D[10733].repu={id=967,min=3000} --old: id=nil
D[10734].obj={}
D[10734].obj.I={29288} --old: nil
D[10734].repu={id=967,min=3000} --old: id=nil
D[10735].obj={}
D[10735].obj.I={29280} --old: nil
D[10735].repu={id=967,min=3000} --old: id=nil
D[10736].obj={}
D[10736].obj.I={29276} --old: nil
D[10736].repu={id=967,min=3000} --old: id=nil
D[10737].obj={}
D[10737].obj.I={24489} --old: nil
D[10738].obj={}
D[10738].obj.I={29285} --old: nil
D[10738].repu={id=967,min=9000} --old: id=nil
D[10739].obj={}
D[10739].obj.I={29289} --old: nil
D[10739].repu={id=967,min=9000} --old: id=nil
D[10740].obj={}
D[10740].obj.I={29281} --old: nil
D[10740].repu={id=967,min=9000} --old: id=nil
D[10741].obj={}
D[10741].obj.I={29277} --old: nil
D[10741].repu={id=967,min=9000} --old: id=nil
D[10742].obj.I={31146} --old: nil
D[10747].obj.I={31129,31130} --old: {31130}
D[10749].obj={}
D[10749].obj.I={31135} --old: nil
D[10750].obj.I={31108} --old: nil
D[10752].excl={990} --old: nil
D[10754].obj={}
D[10754].obj.I={31239} --old: nil
D[10755].obj={}
D[10755].obj.I={31241} --old: nil
D[10756].obj={}
D[10756].obj.I={31245} --old: nil
D[10758].obj.I={31251,31252} --old: {31252}
D[10762].obj={}
D[10762].obj.I={31245} --old: nil
D[10764].obj.I={31251,31252} --old: {31252}
D[10769].obj.I={31108,31279} --old: {31108}
D[10771].obj.I={31300} --old: nil
D[10772].obj.I={31310} --old: nil
D[10776].obj.I={31279,31310} --old: {31310}
D[10777].pre={10759,10761} --old: nil
D[10782].obj.I={31360,31365} --old: {31365}
D[10785].obj={}
D[10785].obj.I={31351} --old: nil
D[10788].start.U={5675,5875} --old: {5675}
D[10788].lvl=nil --old: -1
D[10789].excl={1478} --old: nil
D[10789].lvl=nil --old: -1
D[10790].excl={1506} --old: nil
D[10790].lvl=nil --old: -1
D[10791].obj.I={31344} --old: nil
D[10793].obj={}
D[10793].obj.I={31345} --old: nil
D[10797].obj={}
D[10797].obj.I={31363} --old: nil
D[10800].obj.I={31349,31403} --old: {31349}
D[10801].obj={}
D[10801].obj.I={31351} --old: nil
D[10802].obj.I={31754,31827} --old: {31754}
D[10804].hide=true --old: nil
D[10806].obj.I={31808} --old: nil
D[10807].pre=10552 --old: nil
D[10807].excl={10619} --old: nil
D[10807].repu={id=934,min=3000} --old: id=nil
D[10808].obj.I={31386} --old: nil
D[10810].obj={}
D[10810].obj.I={31384} --old: nil
D[10812].obj={}
D[10812].obj.I={31387} --old: nil
D[10813].obj.I={31463} --old: nil
D[10815].obj={}
D[10815].obj.I={31345} --old: nil
D[10815].hide=true --old: nil
D[10816].repu={id=932,min=3000} --old: id=nil
D[10817].repu={id=934,min=3000} --old: id=nil
D[10819].obj={}
D[10819].obj.I={31366} --old: nil
D[10822].repu={id=934,min=0} --old: id=nil
D[10823].repu={id=934,min=0} --old: id=nil
D[10824].pre=10552 --old: nil
D[10824].repu={id=934,min=0} --old: id=nil
D[10825].obj={}
D[10825].obj.I={31489} --old: nil
D[10826].pre=10551 --old: nil
D[10826].repu={id=932,min=0} --old: id=nil
D[10827].repu={id=932,min=0} --old: id=nil
D[10828].repu={id=932,min=0} --old: id=nil
D[10830].obj.I={31495,31517} --old: nil
D[10831].obj.I={31522,31530} --old: {31530}
D[10831].excl={10832,10833} --old: nil
D[10831].skill={id=197,min=325} --old: id=197
D[10832].obj.I={31741,31742} --old: {31741}
D[10832].excl={10831,10833} --old: nil
D[10832].skill={id=197,min=325} --old: id=197
D[10833].obj.I={31736} --old: nil
D[10833].excl={10831,10832} --old: nil
D[10833].skill={id=197,min=325} --old: id=197
D[10835].obj={}
D[10835].obj.I={31550} --old: nil
D[10838].obj.I={31606,31607} --old: {31607}
D[10839].obj.I={31610} --old: nil
D[10840].pre=10852 --old: 10849
D[10841].hide=true --old: nil
D[10842].obj.I={30527} --old: nil
D[10842].obj.U={21638} --old: nil
D[10842].pre=10852 --old: 10849
D[10844].hide=true --old: nil
D[10849].obj={}
D[10849].obj.I={31662} --old: nil
D[10853].obj.I={31656,31663} --old: {31656}
D[10854].obj.I={31652} --old: nil
D[10857].obj.I={31678} --old: nil
D[10859].obj.I={31668} --old: nil
D[10859].obj.U={20635} --old: {21929}
D[10862].excl={10908} --old: nil
D[10863].excl={10908} --old: nil
D[10870].hide=true --old: nil
D[10871].hide=true --old: nil
D[10872].hide=true --old: nil
D[10876].obj.I={31702,31706} --old: {31706}
D[10877].obj.I={31697,31705} --old: {31697}
D[10880].obj={}
D[10880].obj.I={31707} --old: nil
D[10888].preg={10884,10885,10886} --old: nil
D[10891].skill={id=164,min=265} --old: id=164
D[10892].skill={id=164,min=265} --old: id=164
D[10894].obj={}
D[10894].obj.I={31740} --old: nil
D[10895].obj.I={31739} --old: nil
D[10897].excl={10899,10902} --old: nil
D[10897].skill={id=171,min=325} --old: id=171
D[10899].excl={10897,10902} --old: nil
D[10899].skill={id=171,min=325} --old: id=171
D[10902].excl={10897,10899} --old: nil
D[10902].skill={id=171,min=325} --old: id=171
D[10905].excl={10906,10907} --old: nil
D[10905].skill={id=171,min=325} --old: id=171
D[10906].excl={10905,10907} --old: nil
D[10906].skill={id=171,min=325} --old: id=171
D[10907].excl={10905,10906} --old: nil
D[10907].skill={id=171,min=325} --old: id=171
D[10908].excl={10862,10863} --old: nil
D[10909].obj.I={31772} --old: nil
D[10910].obj.I={31763} --old: nil
D[10911].obj.I={31807} --old: nil
D[10912].obj.I={31763,31809} --old: {31763}
D[10913].obj.I={31769} --old: nil
D[10923].obj.I={31811,31812} --old: {31812}
D[10924].obj.I={31813,31815} --old: {31813}
D[10925].obj.I={31811} --old: nil
D[10925].hide=true --old: nil
D[10929].obj.I={31810,31814} --old: {31814}
D[10930].obj.I={31825,31826} --old: {31826}
D[10935].obj.I={31828} --old: nil
D[10938].obj={}
D[10938].obj.I={31890} --old: nil
D[10938].hide=true --old: nil
D[10939].obj={}
D[10939].obj.I={31891} --old: nil
D[10939].hide=true --old: nil
D[10940].obj={}
D[10940].obj.I={31907} --old: nil
D[10940].hide=true --old: nil
D[10941].obj={}
D[10941].obj.I={31914} --old: nil
D[10941].hide=true --old: nil
D[10942].obj={}
D[10942].obj.I={31880} --old: nil
D[10942].hide=true --old: nil
D[10943].obj={}
D[10943].obj.I={31881} --old: nil
D[10943].hide=true --old: nil
D[10944].hide=true --old: nil
D[10946].obj.I={31946} --old: nil
D[10946].hide=true --old: nil
D[10947].hide=true --old: nil
D[10948].hide=true --old: nil
D[10949].hide=true --old: nil
D[10955].lvl=nil --old: -1
D[10955].skill={id=762,min=300} --old: id=762
D[10957].hide=true --old: nil
D[10958].hide=true --old: nil
D[10959].hide=true --old: nil
D[10960].lvl=nil --old: -1
D[10961].lvl=nil --old: -1
D[10961].skill={id=762,min=300} --old: id=762
D[10964].obj={}
D[10964].obj.I={31953} --old: nil
D[10964].lvl=nil --old: -1
D[10964].skill={id=762,min=300} --old: id=762
D[10965].lvl=nil --old: -1
D[10965].skill={id=762,min=300} --old: id=762
D[10966].preg={10956,10962} --old: nil
D[10967].preg={10963,11975} --old: nil
D[10968].lvl=nil --old: -1
D[10969].repu={id=933,min=9000} --old: id=nil
D[10970].repu={id=933,min=9000} --old: id=nil
D[10970].hide=true --old: nil
D[10971].repu={id=933,min=9000} --old: id=nil
D[10972].repu={id=933,min=9000} --old: id=nil
D[10973].repu={id=933,min=21000} --old: id=nil
D[10974].obj.I={31994,32061} --old: {32061}
D[10977].obj={}
D[10977].obj.I={32069} --old: nil
D[10978].obj={}
D[10978].obj.I={32074} --old: nil
D[10978].lvl=nil --old: -1
D[10978].skill={id=762,min=300} --old: id=762
D[10979].lvl=nil --old: -1
D[10979].skill={id=762,min=300} --old: id=762
D[10980].obj.I={32244,32567} --old: {32567}
D[10980].lvl=nil --old: -1
D[10980].skill={id=762,min=300} --old: id=762
D[10981].repu={id=933,min=21000} --old: id=nil
D[10982].repu={id=933,min=42000} --old: id=nil
D[10983].excl={10989,11057} --old: nil
D[10985].hide=true --old: nil
D[10986].lvl=nil --old: -1
D[10986].skill={id=762,min=300} --old: id=762
D[10987].obj.I={32320,32321} --old: {32320}
D[10987].lvl=nil --old: -1
D[10987].skill={id=762,min=300} --old: id=762
D[10988].obj.I={32313,32315} --old: {32313}
D[10988].lvl=nil --old: -1
D[10988].skill={id=762,min=300} --old: id=762
D[10989].excl={10983,11057} --old: nil
D[10990].obj.I={32355,32657} --old: {32355}
D[10990].lvl=nil --old: -1
D[10990].skill={id=762,min=300} --old: id=762
D[10991].obj.I={32357,32657} --old: {32357}
D[10991].lvl=nil --old: -1
D[10991].skill={id=762,min=300} --old: id=762
D[10992].obj.I={32356,32657} --old: {32356}
D[10992].lvl=nil --old: -1
D[10992].skill={id=762,min=300} --old: id=762
D[10993].obj={}
D[10993].obj.I={32359} --old: nil
D[10993].lvl=nil --old: -1
D[10993].skill={id=762,min=300} --old: id=762
D[10994].lvl=nil --old: -1
D[10994].skill={id=762,min=300} --old: id=762
D[10995].pre={10983,10989,11057} --old: nil
D[10998].preg={10995,10996,10997} --old: nil
D[11000].obj.I={32383,32467} --old: {32383}
D[11001].obj.I={32449,32462} --old: {32449}
D[11001].lvl=nil --old: -1
D[11001].skill={id=762,min=300} --old: id=762
D[11002].obj={}
D[11002].obj.I={32385} --old: nil
D[11003].obj={}
D[11003].obj.I={32386} --old: nil
D[11004].skill={id=762,min=225} --old: id=762
D[11004].hide=true --old: nil
D[11005].hide=true --old: nil
D[11006].skill={id=762,min=225} --old: id=762
D[11006].hide=true --old: nil
D[11007].obj={}
D[11007].obj.I={32405} --old: nil
D[11007].hide=true --old: nil
D[11008].obj.I={32406} --old: nil
D[11008].skill={id=762,min=225} --old: id=762
D[11008].hide=true --old: nil
D[11009].hide=true --old: nil
D[11010].obj.I={32456} --old: nil
D[11010].hide=true --old: nil
D[11011].skill={id=762,min=300} --old: id=762
D[11012].skill={id=762,min=300} --old: id=762
D[11012].repu={id=1015,min=0} --old: id=nil
D[11013].obj={}
D[11013].obj.I={32469} --old: nil
D[11013].repu={id=1015,min=0} --old: id=nil
D[11013].hide=true --old: nil
D[11014].skill={id=762,min=300} --old: id=762
D[11014].repu={id=1015,min=0} --old: id=nil
D[11015].repu={id=1015,min=0} --old: id=nil
D[11015].hide=true --old: nil
D[11016].excl={11017,11018} --old: nil
D[11016].skill={id=393,min=350} --old: id=393
D[11016].repu={id=1015,min=0} --old: id=nil
D[11016].hide=true --old: nil
D[11017].excl={11016,11018} --old: nil
D[11017].skill={id=182,min=350} --old: id=182
D[11017].repu={id=1015,min=0} --old: id=nil
D[11017].hide=true --old: nil
D[11018].excl={11016,11017} --old: nil
D[11018].skill={id=186,min=350} --old: id=186
D[11018].repu={id=1015,min=0} --old: id=nil
D[11018].hide=true --old: nil
D[11019].repu={id=1015,min=0} --old: id=nil
D[11020].obj.I={32502,32503} --old: {32502}
D[11020].repu={id=1015,min=0} --old: id=nil
D[11020].hide=true --old: nil
D[11021].obj={}
D[11021].obj.I={32523} --old: nil
D[11021].skill={id=762,min=225} --old: id=762
D[11021].hide=true --old: nil
D[11023].obj.I={32456} --old: nil
D[11023].pre=11010 --old: nil
D[11023].min=70 --old: nil
D[11023].hide=true --old: nil
D[11024].obj={}
D[11024].obj.I={32564} --old: nil
D[11024].skill={id=762,min=225} --old: id=762
D[11024].hide=true --old: nil
D[11025].hide=true --old: nil
D[11026].obj.I={32696} --old: nil
D[11026].repu={id=1038,min=9000} --old: id=nil
D[11026].hide=true --old: nil
D[11027].preg={11051,11060} --old: nil
D[11027].repu={id=1038,min=9000} --old: id=nil
D[11028].skill={id=762,min=225} --old: id=762
D[11028].hide=true --old: nil
D[11029].obj.I={32741,32742} --old: {32742}
D[11029].skill={id=762,min=225} --old: id=762
D[11029].hide=true --old: nil
D[11030].hide=true --old: nil
D[11031].excl={11032,11033,11034} --old: nil
D[11031].repu={id=967,min=42000} --old: id=nil
D[11032].excl={11031,11033,11034} --old: nil
D[11032].repu={id=967,min=42000} --old: id=nil
D[11033].excl={11031,11032,11034} --old: nil
D[11033].repu={id=967,min=42000} --old: id=nil
D[11034].excl={11031,11032,11033} --old: nil
D[11034].repu={id=967,min=42000} --old: id=nil
D[11035].repu={id=1015,min=0} --old: id=nil
D[11035].hide=true --old: nil
D[11036].obj={}
D[11036].obj.I={32619} --old: nil
D[11036].excl={10183,11037,11038,11039,11040,11042} --old: nil
D[11037].excl={10183,11036,11038,11039,11040,11042} --old: nil
D[11037].repu={id=941,min=0} --old: id=nil
D[11038].start.U={23270,23271} --old: {23270}
D[11038].excl={10183,11036,11037,11039,11040,11042} --old: nil
D[11038].repu={id=932,min=3000} --old: id=nil
D[11039].excl={10183,11036,11037,11038,11040,11042} --old: nil
D[11039].repu={id=934,min=3000} --old: id=nil
D[11040].obj={}
D[11040].obj.I={32623} --old: nil
D[11040].excl={10183,11036,11037,11038,11039,11042} --old: nil
D[11040].min=67 --old: nil
D[11041].obj.I={32621} --old: nil
D[11041].repu={id=1015,min=0} --old: id=nil
D[11041].hide=true --old: nil
D[11042].excl={10183,11036,11037,11038,11039,11040} --old: nil
D[11042].min=67 --old: nil
D[11042].repu={id=978,min=0} --old: id=nil
D[11043].excl={11044,11045} --old: nil
D[11043].min=67 --old: nil
D[11044].excl={11043,11045} --old: nil
D[11044].min=67 --old: nil
D[11044].repu={id=978,min=0} --old: id=nil
D[11045].excl={10642,11043,11044} --old: nil
D[11049].repu={id=1015,min=0} --old: id=nil
D[11049].hide=true --old: nil
D[11050].repu={id=1015,min=0} --old: id=nil
D[11050].hide=true --old: nil
D[11051].obj.I={32696} --old: nil
D[11051].hide=true --old: nil
D[11052].obj={}
D[11052].obj.I={32646} --old: nil
D[11052].hide=true --old: nil
D[11053].repu={id=1015,min=3000} --old: id=nil
D[11053].hide=true --old: nil
D[11054].repu={id=1015,min=3000} --old: id=nil
D[11054].hide=true --old: nil
D[11055].obj.I={32680} --old: nil
D[11055].repu={id=1015,min=3000} --old: id=nil
D[11055].hide=true --old: nil
D[11056].skill={id=762,min=225} --old: id=762
D[11056].hide=true --old: nil
D[11057].excl={10983,10989} --old: nil
D[11057].min=70 --old: nil
D[11057].hide=true --old: nil
D[11058].hide=true --old: nil
D[11059].hide=true --old: nil
D[11060].repu={id=1038,min=9000} --old: id=nil
D[11061].hide=true --old: nil
D[11062].hide=true --old: nil
D[11063].repu={id=1015,min=9000} --old: id=nil
D[11064].repu={id=1015,min=9000} --old: id=nil
D[11064].hide=true --old: nil
D[11065].obj.I={32698} --old: nil
D[11065].pre=11010 --old: nil
D[11065].min=70 --old: nil
D[11065].hide=true --old: nil
D[11066].obj.I={32698} --old: nil
D[11066].hide=true --old: nil
D[11067].repu={id=1015,min=9000} --old: id=nil
D[11067].hide=true --old: nil
D[11068].repu={id=1015,min=9000} --old: id=nil
D[11068].hide=true --old: nil
D[11069].race=1101 --old: nil
D[11069].repu={id=1015,min=9000} --old: id=nil
D[11069].hide=true --old: nil
D[11070].repu={id=1015,min=9000} --old: id=nil
D[11070].hide=true --old: nil
D[11071].repu={id=1015,min=9000} --old: id=nil
D[11071].hide=true --old: nil
D[11072].hide=true --old: nil
D[11073].hide=true --old: nil
D[11074].skill={id=762,min=225} --old: id=762
D[11074].hide=true --old: nil
D[11075].repu={id=1015,min=3000} --old: id=nil
D[11075].hide=true --old: nil
D[11076].repu={id=1015,min=3000} --old: id=nil
D[11076].hide=true --old: nil
D[11077].repu={id=1015,min=3000} --old: id=nil
D[11077].hide=true --old: nil
D[11078].hide=true --old: nil
D[11079].hide=true --old: nil
D[11080].hide=true --old: nil
D[11081].obj={}
D[11081].obj.I={32726} --old: nil
D[11081].repu={id=1015,min=3000} --old: id=nil
D[11081].hide=true --old: nil
D[11082].hide=true --old: nil
D[11083].repu={id=1015,min=3000} --old: id=nil
D[11083].hide=true --old: nil
D[11084].repu={id=1015,min=9000} --old: id=nil
D[11084].hide=true --old: nil
D[11085].skill={id=762,min=225} --old: id=762
D[11085].hide=true --old: nil
D[11086].repu={id=1015,min=9000} --old: id=nil
D[11086].hide=true --old: nil
D[11089].obj.I={23448,23784,23786,32822,32823} --old: {23448,23784,23786,32822}
D[11089].repu={id=1015,min=6000} --old: id=nil
D[11089].hide=true --old: nil
D[11090].obj.I={32825} --old: nil
D[11090].repu={id=1015,min=6000} --old: id=nil
D[11090].hide=true --old: nil
D[11091].repu={id=1038,min=3000} --old: id=nil
D[11091].hide=true --old: nil
D[11092].repu={id=1015,min=21000} --old: id=nil
D[11092].hide=true --old: nil
D[11093].obj.I={32834} --old: nil
D[11093].skill={id=762,min=225} --old: id=762
D[11093].hide=true --old: nil
D[11094].obj={}
D[11094].obj.I={32842} --old: nil
D[11094].repu={id=934,min=1} --old: id=nil
D[11094].hide=true --old: nil
D[11095].obj={}
D[11095].obj.I={32842} --old: nil
D[11095].repu={id=934,min=1} --old: id=nil
D[11096].skill={id=762,min=225} --old: id=762
D[11096].hide=true --old: nil
D[11097].obj={}
D[11097].obj.I={32843} --old: nil
D[11097].repu={id=934,min=1} --old: id=nil
D[11097].hide=true --old: nil
D[11098].obj={}
D[11098].obj.I={32848} --old: nil
D[11098].pre=11096 --old: nil
D[11098].skill={id=762,min=225} --old: id=762
D[11098].hide=true --old: nil
D[11099].obj={}
D[11099].obj.I={32842} --old: nil
D[11099].pre=10211 --old: 11092
D[11099].repu={id=932,min=1} --old: id=nil
D[11099].hide=true --old: nil
D[11100].obj={}
D[11100].obj.I={32842} --old: nil
D[11100].pre=10211 --old: 11099
D[11100].repu={id=932,min=1} --old: id=nil
D[11101].obj={}
D[11101].obj.I={32853} --old: nil
D[11101].pre=10211 --old: 11100
D[11101].repu={id=932,min=1} --old: id=nil
D[11101].hide=true --old: nil
D[11102].obj.I={32456} --old: nil
D[11102].hide=true --old: nil
D[11103].repu={id=990,min=42000} --old: id=nil
D[11104].repu={id=990,min=42000} --old: id=nil
D[11105].repu={id=990,min=42000} --old: id=nil
D[11106].repu={id=990,min=42000} --old: id=nil
D[11107].repu={id=1015,min=42000} --old: id=nil
D[11108].repu={id=1015,min=42000} --old: id=nil
D[11108].hide=true --old: nil
D[11109].excl={11110,11111,11112,11113,11114} --old: nil
D[11109].repu={id=1015,min=42000} --old: id=nil
D[11110].excl={11109,11111,11112,11113,11114} --old: nil
D[11110].repu={id=1015,min=42000} --old: id=nil
D[11111].excl={11109,11110,11112,11113,11114} --old: nil
D[11111].repu={id=1015,min=42000} --old: id=nil
D[11112].excl={11109,11110,11111,11113,11114} --old: nil
D[11112].repu={id=1015,min=42000} --old: id=nil
D[11113].excl={11109,11110,11111,11112,11114} --old: nil
D[11113].repu={id=1015,min=42000} --old: id=nil
D[11114].excl={11109,11110,11111,11112,11113} --old: nil
D[11114].repu={id=1015,min=42000} --old: id=nil
D[11117].obj.I={32906,32907} --old: {32906}
D[11117].lvl=nil --old: -1
D[11117].hide=true --old: nil
D[11118].obj.I={32960} --old: nil
D[11118].hide=true --old: nil
D[11119].min=70 --old: nil
D[11119].hide=true --old: nil
D[11120].obj.I={32960} --old: nil
D[11120].hide=true --old: nil
D[11122].obj.I={33306} --old: nil
D[11122].lvl=nil --old: -1
D[11130].obj={}
D[11130].obj.I={33010} --old: nil
D[11130].hide=true --old: nil
D[11131].lvl=nil --old: -1
D[11131].race=1101 --old: nil
D[11131].hide=true --old: nil
D[11132].hide=true --old: nil
D[11133].obj.I={33015} --old: nil
D[11135].excl={11220} --old: nil
D[11135].race=1101 --old: nil
D[11135].hide=true --old: nil
D[11138].obj={}
D[11138].obj.I={33037} --old: nil
D[11140].obj.I={33041,33044,33045} --old: {33041,33044}
D[11146].obj.I={33069} --old: nil
D[11147].obj.I={33070} --old: nil
D[11150].obj.I={33072} --old: nil
D[11152].obj.I={33082} --old: nil
D[11159].obj.I={33091} --old: nil
D[11159].pre=11161 --old: nil
D[11161].obj.I={33087,33088} --old: {33087}
D[11162].obj.I={33095} --old: nil
D[11164].hide=true --old: nil
D[11169].obj.I={33101} --old: nil
D[11174].obj.I={33108} --old: nil
D[11174].pre=nil --old: 11172
D[11178].obj={}
D[11178].obj.I={33102} --old: nil
D[11178].hide=true --old: nil
D[11183].obj.I={33113} --old: nil
D[11185].obj={}
D[11185].obj.I={33114} --old: nil
D[11186].obj={}
D[11186].obj.I={33115} --old: nil
D[11193].obj={}
D[11193].obj.I={33127} --old: nil
D[11195].obj={}
D[11195].obj.I={33107} --old: nil
D[11196].hide=true --old: nil
D[11205].obj.I={33072} --old: nil
D[11208].obj={}
D[11208].obj.I={33163} --old: nil
D[11208].excl={11158} --old: nil
D[11209].obj.I={33166} --old: nil
D[11211].excl={11158} --old: nil
D[11214].excl={11158} --old: nil
D[11215].excl={11158} --old: nil
D[11219].lvl=nil --old: -1
D[11219].race=690 --old: nil
D[11219].hide=true --old: nil
D[11220].excl={11135} --old: nil
D[11220].race=690 --old: nil
D[11220].hide=true --old: nil
D[11242].obj={}
D[11242].obj.I={33277} --old: nil
D[11242].lvl=nil --old: -1
D[11293].obj.I={33306} --old: nil
D[11293].excl={11294,11407,11408} --old: nil
D[11293].lvl=nil --old: -1
D[11294].obj.I={33306} --old: nil
D[11294].excl={11293,11407,11408} --old: nil
D[11318].obj.I={33306} --old: nil
D[11318].lvl=nil --old: -1
D[11318].hide=true --old: nil
D[11321].obj={}
D[11321].obj.I={33955} --old: nil
D[11321].lvl=nil --old: -1
D[11335].excl={11336,11337,11338} --old: nil
D[11335].lvl=nil --old: -1
D[11335].race=1101 --old: nil
D[11336].excl={11335,11337,11338} --old: nil
D[11336].lvl=nil --old: -1
D[11336].race=1101 --old: nil
D[11337].excl={11335,11336,11338} --old: nil
D[11337].lvl=nil --old: -1
D[11337].race=1101 --old: nil
D[11338].excl={11335,11336,11337} --old: nil
D[11338].lvl=nil --old: -1
D[11338].race=1101 --old: nil
D[11339].excl={11340,11341,11342} --old: nil
D[11339].lvl=nil --old: -1
D[11339].race=690 --old: nil
D[11340].excl={11339,11341,11342} --old: nil
D[11340].lvl=nil --old: -1
D[11340].race=690 --old: nil
D[11341].excl={11339,11340,11342} --old: nil
D[11341].lvl=nil --old: -1
D[11341].race=690 --old: nil
D[11342].excl={11339,11340,11341} --old: nil
D[11342].lvl=nil --old: -1
D[11342].race=690 --old: nil
D[11354].excl={11362,11363,11368,11369,11370,11372,11373,11374,11375,11378,11382,11384,11386,11388,11499} --old: nil
D[11356].race=1101 --old: nil
D[11356].hide=true --old: nil
D[11357].race=690 --old: nil
D[11357].hide=true --old: nil
D[11360].lvl=nil --old: -1
D[11360].race=1101 --old: nil
D[11360].hide=true --old: nil
D[11361].race=690 --old: nil
D[11361].hide=true --old: nil
D[11362].excl={11354,11363,11368,11369,11370,11372,11373,11374,11375,11378,11382,11384,11386,11388,11499} --old: nil
D[11363].excl={11354,11362,11368,11369,11370,11372,11373,11374,11375,11378,11382,11384,11386,11388,11499} --old: nil
D[11364].excl={11371,11376,11383,11385,11387,11389,11500} --old: nil
D[11368].excl={11354,11362,11363,11369,11370,11372,11373,11374,11375,11378,11382,11384,11386,11388,11499} --old: nil
D[11369].excl={11354,11362,11363,11368,11370,11372,11373,11374,11375,11378,11382,11384,11386,11388,11499} --old: nil
D[11370].excl={11354,11362,11363,11368,11369,11372,11373,11374,11375,11378,11382,11384,11386,11388,11499} --old: nil
D[11371].excl={11364,11376,11383,11385,11387,11389,11500} --old: nil
D[11372].excl={11354,11362,11363,11368,11369,11370,11373,11374,11375,11378,11382,11384,11386,11388,11499} --old: nil
D[11373].excl={11354,11362,11363,11368,11369,11370,11372,11374,11375,11378,11382,11384,11386,11388,11499} --old: nil
D[11374].excl={11354,11362,11363,11368,11369,11370,11372,11373,11375,11378,11382,11384,11386,11388,11499} --old: nil
D[11375].excl={11354,11362,11363,11368,11369,11370,11372,11373,11374,11378,11382,11384,11386,11388,11499} --old: nil
D[11376].excl={11364,11371,11383,11385,11387,11389,11500} --old: nil
D[11377].obj.I={33837,33838,33839} --old: {33838,33839}
D[11377].excl={11379,11380,11381} --old: nil
D[11377].skill={id=185,min=275} --old: id=185
D[11378].excl={11354,11362,11363,11368,11369,11370,11372,11373,11374,11375,11382,11384,11386,11388,11499} --old: nil
D[11379].obj.I={33848,33852} --old: {33848}
D[11379].excl={11377,11380,11381} --old: nil
D[11379].skill={id=185,min=275} --old: id=185
D[11380].excl={11377,11379,11381} --old: nil
D[11380].skill={id=185,min=275} --old: id=185
D[11381].obj.I={33850,33851} --old: {33850}
D[11381].excl={11377,11379,11380} --old: nil
D[11381].skill={id=185,min=275} --old: id=185
D[11382].excl={11354,11362,11363,11368,11369,11370,11372,11373,11374,11375,11378,11384,11386,11388,11499} --old: nil
D[11383].obj.U={17839} --old: {17839,20744,21140,22172,24429}
D[11383].excl={11364,11371,11376,11385,11387,11389,11500} --old: nil
D[11384].excl={11354,11362,11363,11368,11369,11370,11372,11373,11374,11375,11378,11382,11386,11388,11499} --old: nil
D[11385].excl={11364,11371,11376,11383,11387,11389,11500} --old: nil
D[11386].excl={11354,11362,11363,11368,11369,11370,11372,11373,11374,11375,11378,11382,11384,11388,11499} --old: nil
D[11387].excl={11364,11371,11376,11383,11385,11389,11500} --old: nil
D[11388].excl={11354,11362,11363,11368,11369,11370,11372,11373,11374,11375,11378,11382,11384,11386,11499} --old: nil
D[11389].excl={11364,11371,11376,11383,11385,11387,11500} --old: nil
D[11392].obj={}
D[11392].obj.I={33985} --old: nil
D[11392].pre={11135,11220} --old: nil
D[11392].hide=true --old: nil
D[11400].obj={}
D[11400].obj.I={33978} --old: nil
D[11400].lvl=nil --old: -1
D[11400].hide=true --old: nil
D[11401].obj={}
D[11401].obj.I={33985} --old: nil
D[11401].lvl=nil --old: -1
D[11401].hide=true --old: nil
D[11403].obj={}
D[11403].obj.I={33277} --old: nil
D[11403].lvl=nil --old: -1
D[11404].obj={}
D[11404].obj.I={33985} --old: nil
D[11404].lvl=nil --old: -1
D[11404].hide=true --old: nil
D[11405].obj={}
D[11405].obj.I={33985} --old: nil
D[11405].lvl=nil --old: -1
D[11405].hide=true --old: nil
D[11407].obj.I={33306} --old: nil
D[11407].excl={11293,11294,11408} --old: nil
D[11408].obj.I={33306} --old: nil
D[11408].excl={11293,11294,11407} --old: nil
D[11408].lvl=nil --old: -1
D[11409].obj.I={33306} --old: nil
D[11409].lvl=nil --old: -1
D[11409].hide=true --old: nil
D[11412].obj.I={33306} --old: nil
D[11412].lvl=nil --old: -1
D[11413].obj={}
D[11413].obj.I={33955} --old: nil
D[11413].lvl=nil --old: -1
D[11419].obj={}
D[11419].obj.I={34028} --old: nil
D[11419].lvl=nil --old: -1
D[11431].obj.I={32906,32907} --old: {32906}
D[11431].lvl=nil --old: -1
D[11439].lvl=nil --old: -1
D[11439].race=1101 --old: nil
D[11439].hide=true --old: nil
D[11440].lvl=nil --old: -1
D[11440].race=1101 --old: nil
D[11440].hide=true --old: nil
D[11441].excl={11442} --old: nil
D[11441].lvl=nil --old: -1
D[11441].hide=true --old: nil
D[11442].excl={11441} --old: nil
D[11442].lvl=nil --old: -1
D[11442].hide=true --old: nil
D[11446].excl={11447} --old: nil
D[11446].lvl=nil --old: -1
D[11446].hide=true --old: nil
D[11447].excl={11446} --old: nil
D[11447].lvl=nil --old: -1
D[11447].hide=true --old: nil
D[11449].lvl=nil --old: -1
D[11449].race=690 --old: nil
D[11449].hide=true --old: nil
D[11450].lvl=nil --old: -1
D[11450].race=690 --old: nil
D[11450].hide=true --old: nil
D[11451].obj={}
D[11451].obj.I={34089} --old: nil
D[11451].race=1101 --old: nil
D[11454].hide=true --old: nil
D[11481].hide=true --old: nil
D[11482].hide=true --old: nil
D[11486].obj={}
D[11486].obj.I={34141} --old: nil
D[11487].obj={}
D[11487].obj.I={34141} --old: nil
D[11488].hide=true --old: nil
D[11496].hide=true --old: nil
D[11499].excl={11354,11362,11363,11368,11369,11370,11372,11373,11374,11375,11378,11382,11384,11386,11388} --old: nil
D[11500].excl={11364,11371,11376,11383,11385,11387,11389} --old: nil
D[11502].repu={id=978,min=0} --old: id=nil
D[11503].repu={id=941,min=0} --old: id=nil
D[11505].lvl=nil --old: -1
D[11506].lvl=nil --old: -1
D[11515].obj.I={34257,34259} --old: {34259}
D[11516].obj.I={34253} --old: nil
D[11517].hide=true --old: nil
D[11520].hide=true --old: nil
D[11521].hide=true --old: nil
D[11523].hide=true --old: nil
D[11524].obj.I={34368} --old: nil
D[11524].hide=true --old: nil
D[11525].obj.I={34368} --old: nil
D[11525].hide=true --old: nil
D[11526].obj.I={34420} --old: nil
D[11526].hide=true --old: nil
D[11528].lvl=nil --old: -1
D[11528].hide=true --old: nil
D[11531].obj={}
D[11531].obj.I={34469,34474} --old: nil
D[11531].skill={id=356,min=1} --old: id=356
D[11532].obj.I={34475} --old: nil
D[11532].hide=true --old: nil
D[11533].obj.I={34475} --old: nil
D[11533].hide=true --old: nil
D[11534].hide=true --old: nil
D[11535].hide=true --old: nil
D[11536].hide=true --old: nil
D[11537].obj.I={34414} --old: nil
D[11537].obj.U={25065} --old: {24999,25001,25002,25008,25065,25068}
D[11537].hide=true --old: nil
D[11538].obj.I={34414} --old: nil
D[11538].obj.U={25065} --old: {24999,25001,25002,25008,25065,25068}
D[11538].hide=true --old: nil
D[11539].hide=true --old: nil
D[11540].hide=true --old: nil
D[11541].hide=true --old: nil
D[11542].obj.I={34489} --old: nil
D[11542].hide=true --old: nil
D[11543].obj.I={34489} --old: nil
D[11543].hide=true --old: nil
D[11544].hide=true --old: nil
D[11545].hide=true --old: nil
D[11546].hide=true --old: nil
D[11547].obj.I={34533} --old: nil
D[11547].hide=true --old: nil
D[11548].hide=true --old: nil
D[11549].repu={id=1077,min=42000} --old: id=nil
D[11549].hide=true --old: nil
D[11550].hide=true --old: nil
D[11554].repu={id=1077,min=3000} --old: id=nil
D[11554].hide=true --old: nil
D[11555].repu={id=1077,min=9000} --old: id=nil
D[11555].hide=true --old: nil
D[11556].repu={id=1077,min=21000} --old: id=nil
D[11556].hide=true --old: nil
D[11557].repu={id=1077,min=42000} --old: id=nil
D[11557].hide=true --old: nil
D[11558].lvl=nil --old: -1
D[11580].lvl=nil --old: -1
D[11580].hide=true --old: nil
D[11581].lvl=nil --old: -1
D[11581].hide=true --old: nil
D[11583].lvl=nil --old: -1
D[11583].hide=true --old: nil
D[11584].lvl=nil --old: -1
D[11657].lvl=nil --old: -1
D[11665].excl={11666,11667,11668,11669} --old: nil
D[11665].skill={id=356,min=1} --old: id=356
D[11666].excl={11665,11667,11668,11669} --old: nil
D[11666].skill={id=356,min=1} --old: id=356
D[11667].excl={11665,11666,11668,11669} --old: nil
D[11667].skill={id=356,min=1} --old: id=356
D[11668].excl={11665,11666,11667,11669} --old: nil
D[11668].skill={id=356,min=1} --old: id=356
D[11669].excl={11665,11666,11667,11668} --old: nil
D[11669].skill={id=356,min=1} --old: id=356
D[11731].lvl=nil --old: -1
D[11731].race=1101 --old: nil
D[11731].hide=true --old: nil
D[11732].lvl=nil --old: -1
D[11732].hide=true --old: nil
D[11734].lvl=nil --old: -1
D[11734].hide=true --old: nil
D[11735].lvl=nil --old: -1
D[11735].hide=true --old: nil
D[11736].lvl=nil --old: -1
D[11736].hide=true --old: nil
D[11737].lvl=nil --old: -1
D[11737].hide=true --old: nil
D[11738].lvl=nil --old: -1
D[11738].hide=true --old: nil
D[11739].lvl=nil --old: -1
D[11739].hide=true --old: nil
D[11740].lvl=nil --old: -1
D[11740].hide=true --old: nil
D[11741].lvl=nil --old: -1
D[11741].hide=true --old: nil
D[11742].lvl=nil --old: -1
D[11742].hide=true --old: nil
D[11743].lvl=nil --old: -1
D[11743].hide=true --old: nil
D[11744].lvl=nil --old: -1
D[11744].hide=true --old: nil
D[11745].lvl=nil --old: -1
D[11745].hide=true --old: nil
D[11746].lvl=nil --old: -1
D[11746].hide=true --old: nil
D[11747].lvl=nil --old: -1
D[11747].hide=true --old: nil
D[11748].lvl=nil --old: -1
D[11748].hide=true --old: nil
D[11749].lvl=nil --old: -1
D[11749].hide=true --old: nil
D[11750].lvl=nil --old: -1
D[11750].hide=true --old: nil
D[11751].lvl=nil --old: -1
D[11751].hide=true --old: nil
D[11752].lvl=nil --old: -1
D[11752].hide=true --old: nil
D[11753].lvl=nil --old: -1
D[11753].hide=true --old: nil
D[11754].lvl=nil --old: -1
D[11754].hide=true --old: nil
D[11755].lvl=nil --old: -1
D[11755].hide=true --old: nil
D[11756].lvl=nil --old: -1
D[11756].hide=true --old: nil
D[11757].lvl=nil --old: -1
D[11757].hide=true --old: nil
D[11758].lvl=nil --old: -1
D[11758].hide=true --old: nil
D[11759].lvl=nil --old: -1
D[11759].hide=true --old: nil
D[11760].lvl=nil --old: -1
D[11760].hide=true --old: nil
D[11761].lvl=nil --old: -1
D[11761].hide=true --old: nil
D[11762].lvl=nil --old: -1
D[11762].hide=true --old: nil
D[11763].lvl=nil --old: -1
D[11763].hide=true --old: nil
D[11764].lvl=nil --old: -1
D[11764].hide=true --old: nil
D[11765].lvl=nil --old: -1
D[11765].hide=true --old: nil
D[11766].lvl=nil --old: -1
D[11766].hide=true --old: nil
D[11767].lvl=nil --old: -1
D[11767].hide=true --old: nil
D[11768].lvl=nil --old: -1
D[11768].hide=true --old: nil
D[11769].lvl=nil --old: -1
D[11769].hide=true --old: nil
D[11770].lvl=nil --old: -1
D[11770].hide=true --old: nil
D[11771].lvl=nil --old: -1
D[11771].hide=true --old: nil
D[11772].lvl=nil --old: -1
D[11772].hide=true --old: nil
D[11773].lvl=nil --old: -1
D[11773].hide=true --old: nil
D[11774].lvl=nil --old: -1
D[11774].hide=true --old: nil
D[11775].lvl=nil --old: -1
D[11775].hide=true --old: nil
D[11776].lvl=nil --old: -1
D[11776].hide=true --old: nil
D[11777].lvl=nil --old: -1
D[11777].hide=true --old: nil
D[11778].lvl=nil --old: -1
D[11778].hide=true --old: nil
D[11779].lvl=nil --old: -1
D[11779].hide=true --old: nil
D[11780].lvl=nil --old: -1
D[11780].hide=true --old: nil
D[11781].lvl=nil --old: -1
D[11781].hide=true --old: nil
D[11782].lvl=nil --old: -1
D[11782].hide=true --old: nil
D[11783].lvl=nil --old: -1
D[11783].hide=true --old: nil
D[11784].lvl=nil --old: -1
D[11784].hide=true --old: nil
D[11785].lvl=nil --old: -1
D[11785].hide=true --old: nil
D[11786].lvl=nil --old: -1
D[11786].hide=true --old: nil
D[11787].lvl=nil --old: -1
D[11787].hide=true --old: nil
D[11799].lvl=nil --old: -1
D[11799].hide=true --old: nil
D[11800].lvl=nil --old: -1
D[11800].hide=true --old: nil
D[11801].lvl=nil --old: -1
D[11801].hide=true --old: nil
D[11802].lvl=nil --old: -1
D[11802].hide=true --old: nil
D[11803].lvl=nil --old: -1
D[11803].hide=true --old: nil
D[11804].lvl=nil --old: -1
D[11804].hide=true --old: nil
D[11805].lvl=nil --old: -1
D[11805].hide=true --old: nil
D[11806].lvl=nil --old: -1
D[11806].hide=true --old: nil
D[11807].lvl=nil --old: -1
D[11807].hide=true --old: nil
D[11808].lvl=nil --old: -1
D[11808].hide=true --old: nil
D[11809].lvl=nil --old: -1
D[11809].hide=true --old: nil
D[11810].lvl=nil --old: -1
D[11810].hide=true --old: nil
D[11811].lvl=nil --old: -1
D[11811].hide=true --old: nil
D[11812].lvl=nil --old: -1
D[11812].hide=true --old: nil
D[11813].lvl=nil --old: -1
D[11813].hide=true --old: nil
D[11814].lvl=nil --old: -1
D[11814].hide=true --old: nil
D[11815].lvl=nil --old: -1
D[11815].hide=true --old: nil
D[11816].lvl=nil --old: -1
D[11816].hide=true --old: nil
D[11817].lvl=nil --old: -1
D[11817].hide=true --old: nil
D[11818].lvl=nil --old: -1
D[11818].hide=true --old: nil
D[11819].lvl=nil --old: -1
D[11819].hide=true --old: nil
D[11820].lvl=nil --old: -1
D[11820].hide=true --old: nil
D[11821].lvl=nil --old: -1
D[11821].hide=true --old: nil
D[11822].lvl=nil --old: -1
D[11822].hide=true --old: nil
D[11823].lvl=nil --old: -1
D[11823].hide=true --old: nil
D[11824].lvl=nil --old: -1
D[11824].hide=true --old: nil
D[11825].lvl=nil --old: -1
D[11825].hide=true --old: nil
D[11826].lvl=nil --old: -1
D[11826].hide=true --old: nil
D[11827].lvl=nil --old: -1
D[11827].hide=true --old: nil
D[11828].lvl=nil --old: -1
D[11828].hide=true --old: nil
D[11829].lvl=nil --old: -1
D[11829].hide=true --old: nil
D[11830].lvl=nil --old: -1
D[11830].hide=true --old: nil
D[11831].lvl=nil --old: -1
D[11831].hide=true --old: nil
D[11832].lvl=nil --old: -1
D[11832].hide=true --old: nil
D[11833].lvl=nil --old: -1
D[11833].hide=true --old: nil
D[11834].lvl=nil --old: -1
D[11834].hide=true --old: nil
D[11835].lvl=nil --old: -1
D[11836].lvl=nil --old: -1
D[11837].lvl=nil --old: -1
D[11838].lvl=nil --old: -1
D[11839].lvl=nil --old: -1
D[11840].lvl=nil --old: -1
D[11841].lvl=nil --old: -1
D[11842].lvl=nil --old: -1
D[11843].lvl=nil --old: -1
D[11844].lvl=nil --old: -1
D[11845].lvl=nil --old: -1
D[11846].lvl=nil --old: -1
D[11847].lvl=nil --old: -1
D[11848].lvl=nil --old: -1
D[11849].lvl=nil --old: -1
D[11850].lvl=nil --old: -1
D[11851].lvl=nil --old: -1
D[11852].lvl=nil --old: -1
D[11853].lvl=nil --old: -1
D[11854].lvl=nil --old: -1
D[11855].lvl=nil --old: -1
D[11856].lvl=nil --old: -1
D[11857].lvl=nil --old: -1
D[11858].lvl=nil --old: -1
D[11859].lvl=nil --old: -1
D[11860].lvl=nil --old: -1
D[11861].lvl=nil --old: -1
D[11862].lvl=nil --old: -1
D[11863].lvl=nil --old: -1
D[11880].obj.I={35233} --old: nil
D[11882].lvl=nil --old: -1
D[11882].hide=true --old: nil
D[11883].lvl=nil --old: -1
D[11885].obj.I={32620} --old: nil
D[11885].obj.U={23161,23163,23165} --old: {23161,23162,23163,23165,23204}
D[11885].skill={id=762,min=225} --old: id=762
D[11885].hide=true --old: nil
D[11886].lvl=nil --old: -1
D[11886].race=1101 --old: nil
D[11886].hide=true --old: nil
D[11891].lvl=nil --old: -1
D[11915].lvl=nil --old: -1
D[11915].hide=true --old: nil
D[11921].lvl=nil --old: -1
D[11922].lvl=nil --old: -1
D[11923].lvl=nil --old: -1
D[11924].lvl=nil --old: -1
D[11925].lvl=nil --old: -1
D[11926].lvl=nil --old: -1
D[11933].obj={}
D[11933].obj.I={35569} --old: nil
D[11933].lvl=nil --old: -1
D[11933].hide=true --old: nil
D[11935].obj={}
D[11935].obj.I={35568} --old: nil
D[11935].lvl=nil --old: -1
D[11935].hide=true --old: nil
D[11964].lvl=nil --old: -1
D[11964].hide=true --old: nil
D[11966].lvl=nil --old: -1
D[11966].hide=true --old: nil
D[11970].lvl=nil --old: -1
D[11970].hide=true --old: nil
D[11971].lvl=nil --old: -1
D[11971].hide=true --old: nil
D[11972].obj={}
D[11972].obj.I={35723} --old: nil
D[11972].lvl=nil --old: -1
D[11976].lvl=nil --old: -1
D[12020].lvl=nil --old: -1
D[12020].hide=true --old: nil
D[12022].lvl=nil --old: -1
D[12022].hide=true --old: nil
D[12191].lvl=nil --old: -1
D[12191].hide=true --old: nil
D[12193].obj={}
D[12193].obj.I={33955} --old: nil
D[12193].lvl=nil --old: -1
D[12194].obj={}
D[12194].obj.I={33955} --old: nil
D[12194].lvl=nil --old: -1
D[12194].hide=true --old: nil
D[12278].obj={}
D[12278].obj.I={37571} --old: nil
D[12278].lvl=nil --old: -1
D[12278].hide=true --old: nil
D[12306].obj.I={37571,37599} --old: nil
D[12306].lvl=nil --old: -1
D[12318].pre={11441,11442,11446,11447} --old: nil
D[12318].lvl=nil --old: -1
D[12318].race=1101 --old: nil
D[12491].obj={}
D[12491].obj.I={38280} --old: nil
D[12491].lvl=nil --old: -1
D[12492].obj={}
D[12492].obj.I={38281} --old: nil
D[12492].lvl=nil --old: -1
D[63866]={}
D[63866].start={}
D[63866].start.U={17718} --old: nil
D[63866]['end']={}
D[63866]['end'].U={17717} --old: nil
D[63866].obj={}
D[63866].obj.I={24156,24157} --old: nil
D[63866].pre=9681 --old: nil
D[63866].next=9685 --old: nil
D[63866].min=12 --old: nil
D[63866].class=2 --old: nil
D[63866].race=512 --old: nil
D[64028]={}
D[64028]['end']={}
D[64028]['end'].U={376,914,928,5495,5497,5505,5515,13283} --old: nil
D[64028].lvl=58 --old: nil
D[64028].min=58 --old: nil
D[64028].race=1101 --old: nil
D[64031]={}
D[64031].start={}
D[64031].start.U={376,914,928,5495,5497,5505,5515,13283} --old: nil
D[64031]['end']={}
D[64031]['end'].U={376,914,928,5495,5497,5505,5515,13283} --old: nil
D[64031].obj={}
D[64031].obj.O={400009,400010} --old: nil
D[64031].pre=64028 --old: nil
D[64031].lvl=58 --old: nil
D[64031].min=58 --old: nil
D[64031].race=1101 --old: nil
D[64034]={}
D[64034].start={}
D[64034].start.U={376,914,928,5495,5497,5505,5515,13283} --old: nil
D[64034]['end']={}
D[64034]['end'].U={376,914,928,5495,5497,5505,5515,13283} --old: nil
D[64034].obj={}
D[64034].obj.O={400011} --old: nil
D[64034].pre=64031 --old: nil
D[64034].lvl=58 --old: nil
D[64034].min=58 --old: nil
D[64034].race=1101 --old: nil
D[64035]={}
D[64035].start={}
D[64035].start.U={376,914,928,5495,5497,5505,5515,13283} --old: nil
D[64035]['end']={}
D[64035]['end'].U={376,914,928,5495,5497,5505,5515,13283} --old: nil
D[64035].obj={}
D[64035].obj.O={400012} --old: nil
D[64035].pre=64034 --old: nil
D[64035].lvl=58 --old: nil
D[64035].min=58 --old: nil
D[64035].race=1101 --old: nil
D[64037]={}
D[64037].start={}
D[64037].start.U={376,914,928,5495,5497,5505,5515,13283} --old: nil
D[64037]['end']={}
D[64037]['end'].U={11036} --old: nil
D[64037].obj={}
D[64037].obj.U={352} --old: nil
D[64037].pre=64035 --old: nil
D[64037].excl={64038} --old: nil
D[64037].lvl=58 --old: nil
D[64037].min=58 --old: nil
D[64037].race=1101 --old: nil
D[64038]={}
D[64038].start={}
D[64038].start.U={376,914,928,5495,5497,5505,5515,13283} --old: nil
D[64038]['end']={}
D[64038]['end'].U={16841} --old: nil
D[64038].obj={}
D[64038].obj.U={352} --old: nil
D[64038].pre=64035 --old: nil
D[64038].lvl=58 --old: nil
D[64038].min=58 --old: nil
D[64038].race=1101 --old: nil
D[64046]={}
D[64046]['end']={}
D[64046]['end'].U={3324,3328,3344,3353,3406,5885,5994} --old: nil
D[64046].lvl=58 --old: nil
D[64046].min=58 --old: nil
D[64046].race=690 --old: nil
D[64047]={}
D[64047]['end']={}
D[64047]['end'].U={3036} --old: nil
D[64047].lvl=58 --old: nil
D[64047].min=58 --old: nil
D[64047].class=1024 --old: nil
D[64047].race=32 --old: nil
D[64048]={}
D[64048].start={}
D[64048].start.U={3324,3328,3344,3353,3406,5885,5994} --old: nil
D[64048]['end']={}
D[64048]['end'].U={3324,3328,3344,3353,3406,5885,5994} --old: nil
D[64048].obj={}
D[64048].obj.O={400001,400002} --old: nil
D[64048].pre=64046 --old: nil
D[64048].lvl=58 --old: nil
D[64048].min=58 --old: nil
D[64048].race=690 --old: nil
D[64049]={}
D[64049].start={}
D[64049].start.U={3036} --old: nil
D[64049]['end']={}
D[64049]['end'].U={3036} --old: nil
D[64049].obj={}
D[64049].obj.O={400003,400004} --old: nil
D[64049].pre=64047 --old: nil
D[64049].lvl=58 --old: nil
D[64049].min=58 --old: nil
D[64049].class=1024 --old: nil
D[64049].race=32 --old: nil
D[64050]={}
D[64050].start={}
D[64050].start.U={3324,3328,3344,3353,3406,5885,5994} --old: nil
D[64050]['end']={}
D[64050]['end'].U={3324,3328,3344,3353,3406,5885,5994} --old: nil
D[64050].obj={}
D[64050].obj.O={400005} --old: nil
D[64050].pre=64048 --old: nil
D[64050].lvl=58 --old: nil
D[64050].min=58 --old: nil
D[64050].race=690 --old: nil
D[64051]={}
D[64051].start={}
D[64051].start.U={3036} --old: nil
D[64051]['end']={}
D[64051]['end'].U={3036} --old: nil
D[64051].obj={}
D[64051].obj.O={400006} --old: nil
D[64051].pre=64049 --old: nil
D[64051].lvl=58 --old: nil
D[64051].min=58 --old: nil
D[64051].class=1024 --old: nil
D[64051].race=32 --old: nil
D[64052]={}
D[64052].start={}
D[64052].start.U={3324,3328,3344,3353,3406,5885,5994} --old: nil
D[64052]['end']={}
D[64052]['end'].U={3324,3328,3344,3353,3406,5885,5994} --old: nil
D[64052].obj={}
D[64052].obj.O={400007} --old: nil
D[64052].pre=64050 --old: nil
D[64052].lvl=58 --old: nil
D[64052].min=58 --old: nil
D[64052].race=690 --old: nil
D[64053]={}
D[64053].start={}
D[64053].start.U={3036} --old: nil
D[64053]['end']={}
D[64053]['end'].U={3036} --old: nil
D[64053].obj={}
D[64053].obj.O={400008} --old: nil
D[64053].pre=64051 --old: nil
D[64053].lvl=58 --old: nil
D[64053].min=58 --old: nil
D[64053].class=1024 --old: nil
D[64053].race=32 --old: nil
D[64063]={}
D[64063].start={}
D[64063].start.U={3324,3328,3344,3353,3406,5885,5994} --old: nil
D[64063]['end']={}
D[64063]['end'].U={19254} --old: nil
D[64063].obj={}
D[64063].obj.U={1387,12136} --old: nil
D[64063].pre=64052 --old: nil
D[64063].excl={64217} --old: nil
D[64063].lvl=58 --old: nil
D[64063].min=58 --old: nil
D[64063].race=690 --old: nil
D[64064]={}
D[64064].start={}
D[64064].start.U={3036,3324,3328,3344,3353,3406,5885,5994} --old: nil
D[64064]['end']={}
D[64064]['end'].U={11036} --old: nil
D[64064].obj={}
D[64064].obj.U={9564} --old: nil
D[64064].pre={64052,64053} --old: nil
D[64064].excl={64063,64217} --old: nil
D[64064].lvl=58 --old: nil
D[64064].min=58 --old: nil
D[64064].race=690 --old: nil
D[64217]={}
D[64217].start={}
D[64217].start.U={3036} --old: nil
D[64217]['end']={}
D[64217]['end'].U={19254} --old: nil
D[64217].obj={}
D[64217].obj.U={1387,12136} --old: nil
D[64217].pre=64053 --old: nil
D[64217].excl={64063} --old: nil
D[64217].lvl=58 --old: nil
D[64217].min=58 --old: nil
D[64217].race=32 --old: nil
CodexDB.questiePatchVersion = CodexDB.questiePatchVersion or {}
CodexDB.questiePatchVersion.quest = '6.3.11'
