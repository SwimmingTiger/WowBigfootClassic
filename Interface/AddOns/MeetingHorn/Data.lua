local ns = select(2, ...)
local ENCOUNTER_BOSSES = {
[1107] = {
bossId = 1107,
abilities = {
children = {
{
spell = '28783',
title = '穿刺',
noCollapse = false,
expanded = false,
desc = '随机朝一个方向释放穿刺对路线上的人造成伤害，并击飞同一直线方向上的玩家。',
},
{
spell = '28785',
title = '虫群风暴',
noCollapse = false,
expanded = false,
desc = '战斗开始后，每隔一段时间BOSS会释放出一簇虫群，使BOSS移动速度降低并对附近玩家造成伤害且伤害会叠加，BOSS移动过程中范围内玩家无法施法，持续20秒。',
},
{
title = '召唤地穴卫士',
noCollapse = false,
expanded = false,
desc = 'BOSS在释放虫群风暴同时会召唤一只地穴卫士（精英怪）。',
},
{
title = '召唤甲虫',
noCollapse = false,
expanded = false,
desc = '随机从地穴卫士尸体或玩家的尸体上召唤出甲虫。',
},
},
desc = '阿努布雷坎会释放虫群风暴，期间会使范围内玩家受到大量伤害，但是BOSS移动速度会降低，需要主T在虫群风暴期间拉着BOSS跑，直到技能结束。',
},
zone = 1,
summary = {
children = {
{
role = 'MELEE',
expanded = false,
desc = '1.    战斗开始后先击杀地穴卫士，然后再输出BOSS。\n2.    虫群风暴期间远离BOSS，击杀召唤出来的地穴卫士。',
},
{
role = 'RANGE',
expanded = false,
desc = '1.    战斗开始后先击杀地穴卫士，之后于场地左半边分散站位，最远距离输出BOSS。\n2.    虫群风暴期间远离BOSS，优先击杀召唤出来的地穴卫士。\n3.    法师尽量靠近地穴卫士尸体分散站位，在甲虫被召唤出来之后第一时间轮流冰环，控制后击杀。\n4.    安排接应主T的猎人，站在场地右边输出，虫群风暴后开启豹群接应主T，确保自己和主T不会吃到虫群风暴。',
},
{
role = 'TANK',
expanded = false,
desc = '1.    开战后，主T需要将BOSS拉在房间最里面的角落上。\n2.    在BOSS释放虫群风暴时，主T沿着房间右边的水沟风筝BOSS，保持一定距离不受虫群伤害，也需要确保BOSS沿着水沟移动远离其他玩家，在虫群风暴结束后将BOSS拉至房间入口处。第二轮虫群风暴开始时沿原路风筝BOSS回到最里面的角落，一直循环即可。\n3.    副T在战斗开始后拉住BOSS边上的地穴卫士，将精英怪拉至房间左边，靠近水沟处击杀，地穴卫士死亡位置尽量靠在一起。后续召唤的地穴卫士都需要副T拉住并击杀于同一位置。',
},
{
role = 'HEALER',
expanded = false,
desc = '1.    战斗开始后在场地中间分散站位治疗。\n2.    治疗好被穿刺的玩家，确保其在掉落地面时不会被摔死。\n3.    虫群风暴开始后往场地左边移动，远离BOSS，随时注意主T的血量。',
},
},
desc = '阿努布雷坎整场战斗远程远离BOSS输出，优先击杀小怪，近战虫群风暴时远离BOSS，治疗需要在虫群时最远距离治疗坦克，确保不会被沉默，所有人分散站位躲开地刺范围。',
},
icon = '1378964',
name = '阿努布雷坎',
},
[1108] = {
bossId = 1108,
summary = {
children = {
{
role = 'HEALER',
expanded = false,
desc = '1.    和远程一起集中站位治疗。\n2.    BOSS残杀后第一时间刷好T的血量，然后再刷满全团的血。',
},
{
role = 'MELEE',
expanded = false,
desc = '1.    进入战斗后输出BOSS。\n2.    残杀后优先击杀小僵尸，阻止僵尸靠近BOSS。',
},
{
role = 'RANGE',
expanded = false,
desc = '1.    进入战斗后集中站位，最远距离输出BOSS。\n2.    残杀后优先控制击杀小僵尸。\n3.    LR打好宁神。分配好的远程辅助副T风筝小僵尸，例如猎人冰霜陷阱等。',
},
{
role = 'TANK',
expanded = false,
desc = '1.    主T将BOSS拉至门口位置，副T一起制造仇恨。主T身上重伤叠加层数过高时副T接手。\n2.    拉小僵尸的T在残杀前风筝好小僵尸，使得小僵尸远离BOSS，残杀结束后继续拉住新出现的小僵尸仇恨。',
},
},
desc = '格拉斯战斗除了拉BOSS的两位坦克不断替换外，风筝小僵尸的也需要在残杀之前控制好小僵尸，残杀后治疗优先加满坦克，输出们优先击杀小僵尸。',
},
zone = 4,
name = '格拉斯',
icon = '1378977',
abilities = {
children = {
{
spell = '54378',
title = '致命伤',
noCollapse = false,
expanded = false,
desc = '对主T释放，造成伤害并附加受到治疗效果减少10%的debuff，可叠加。',
},
{
spell = '28317',
title = '激怒',
noCollapse = false,
expanded = false,
desc = '每30秒释放一次，攻击速度提高100%，持续8秒，可驱散。',
},
{
spell = '29307',
title = '感染之伤',
noCollapse = false,
expanded = false,
desc = '小僵尸每次攻击使目标受到的伤害提高，可叠加。',
},
{
spell = '28374',
title = '残杀',
noCollapse = false,
expanded = false,
desc = '每隔一段时间，会把BOSS房间内任何玩家和小怪的血量都降低至5%。此时小僵尸会无视仇恨走向BOSS。',
},
},
desc = '格拉斯战斗开始后，房间井口附近会不断刷新小僵尸，在残杀后，小僵尸会无视仇恨走向BOSS，BOSS会吞噬靠近自己的僵尸，每吞噬一只恢复BOSS 5%的血量。',
},
},
[1109] = {
bossId = 1109,
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '1.    T在面对BOSS的左边房间的三个台子边站位，开始先拉死亡骑士仇恨，在骑兵出来后拉住骑兵仇恨，死亡骑士由牧师锁住。\n2.    BOSS下楼后会在2个房间内传送， T注意拉住BOSS。',
},
{
role = 'HEALER',
expanded = false,
desc = '1.    在面对BOSS的左边房间时和远程站在一起，治疗好全团；亡灵怪出现时，最远距离治疗。\n2.    BOSS下楼后加好T。',
},
{
role = 'MELEE',
expanded = false,
desc = '1.    优先击杀骑兵和死亡骑士，亡灵小怪出现后骑士可以上去施展神圣愤怒。\n2.    BOSS下楼后全力输出BOSS。',
},
{
role = 'RANGE',
expanded = false,
desc = '1.    优先击杀骑兵和死亡骑士，亡灵小怪出现后法师冰环控制怪，远距离下暴风雪处理掉。\n2.    BOSS下楼后全力输出BOSS。',
},
},
desc = '收割者戈提克战斗开始，所有人都站在面对BOSS的左边房间，击杀完所有小怪之后中间的门开启，法师和骑士控制右边房间冲出来的亡灵怪，控制好之后A掉即可。',
},
zone = 3,
name = '收割者戈提克',
icon = '1378979',
abilities = {
children = {
{
title = '左边房间',
children = {
{
title = '冷酷的学徒',
noCollapse = false,
expanded = false,
children = {
{
spell = '55604',
title = '死亡疫病',
noCollapse = false,
expanded = false,
desc = '每3秒造成自然伤害。',
},
},
},
{
title = '冷酷的死亡骑士',
noCollapse = false,
expanded = false,
children = {
{
spell = '27825',
title = '暗影遮罩',
noCollapse = false,
expanded = false,
desc = '攻击附近的敌人造成武器伤害。',
},
},
},
{
title = '冷酷的骑兵',
noCollapse = false,
expanded = false,
children = {
{
spell = '27831',
title = '暗影箭雨',
noCollapse = false,
expanded = false,
desc = '对周围玩家释放多支暗影箭，造成暗影伤害。',
},
{
spell = '55606',
title = '邪恶光环',
noCollapse = false,
expanded = false,
desc = '每3秒对所有附近玩家造成暗影伤害。',
},
},
},
},
noCollapse = false,
expanded = true,
desc = '小怪只会刷新在3个平台上',
},
{
title = '右边房间',
children = {
{
title = '鬼灵学徒',
children = {
{
spell = '27989',
title = '魔爆术',
noCollapse = false,
expanded = false,
desc = '对附近玩家造成奥术伤害。',
},
{
spell = '27990',
title = '群体恐惧',
noCollapse = false,
expanded = false,
desc = '恐惧范围内的玩家，持续4秒。',
},
},
noCollapse = false,
expanded = false,
desc = '由冷酷的学徒复活而来',
},
{
title = '鬼灵死亡骑士',
children = {
{
spell = '56408',
title = '旋风斩',
noCollapse = false,
expanded = false,
desc = '对周围玩家造成物理伤害。',
},
},
noCollapse = false,
expanded = false,
desc = '由冷酷的死亡骑士复活而来',
},
{
title = '鬼灵骑兵',
children = {
{
spell = '55606',
title = '邪恶光环',
noCollapse = false,
expanded = false,
desc = '每3秒对所有附近玩家造成暗影伤害。',
},
{
spell = '27994',
title = '吸取生命',
noCollapse = false,
expanded = false,
desc = '从目标身上吸取生命值转移给施法者。',
},
},
noCollapse = false,
expanded = false,
desc = '由冷酷的骑兵复活而来，会形成鬼灵骑兵和鬼灵战马2种',
},
{
title = '鬼灵战马',
children = {
{
spell = '27993',
title = '践踏',
noCollapse = false,
expanded = false,
desc = '对周围玩家造成物理伤害且降低移动速度。',
},
},
noCollapse = false,
expanded = false,
desc = '由冷酷的骑兵复活而来，会形成鬼灵骑兵和鬼灵战马2种',
},
},
noCollapse = false,
expanded = true,
desc = '会在随机骨堆上复活三种小怪的灵魂形态',
},
{
title = '收割者戈提克',
noCollapse = false,
expanded = true,
children = {
{
spell = '29317',
title = '暗影箭',
noCollapse = false,
expanded = false,
desc = '对当前目标释放，造成大量暗影伤害。',
},
{
spell = '28679',
title = '收割灵魂',
noCollapse = false,
expanded = false,
desc = '对所有玩家释放，使得属性降低10%，持续60秒，每隔一段时间释放一次，可叠加。',
},
{
spell = '35517',
title = '传送',
noCollapse = false,
expanded = false,
desc = 'BOSS每隔30秒会在左右两个房间内传送。',
},
},
},
},
desc = '收割者戈提克自身难度不大，这场战斗主要是需要处理好BOSS下楼前的小怪。BOSS房间被分割为两部分，战斗开始中间门会关闭，变成2个独立的区域，在面对BOSS的左边房间被击杀的小怪会在右边房间复活。小怪被击杀完之后BOSS下楼，会并在两个房间内传送。',
},
},
[1110] = {
bossId = 1110,
summary = {
children = {
{
role = 'MELEE',
expanded = false,
desc = '1.    战斗开始后优先击杀2个追随者，随后输出BOSS，注意躲避火雨，10人模式下需要在BOSS狂乱时击杀一个膜拜者。',
},
{
role = 'RANGE',
expanded = false,
desc = '1.    战斗开始后优先击杀2个追随者，随后输出BOSS，10人模式下需要在BOSS狂乱时击杀一个膜拜者。\n2.    分散站位，躲好火雨。',
},
{
role = 'TANK',
expanded = false,
desc = '1.    开战后主T将BOSS拉在平台中间，注意躲避火雨。\n2.    其余6个小怪需要副T拉住，优先击杀追随者。\n3.    拉住膜拜者的副T站在台子的附近， BOSS狂乱时，听指挥将膜拜者拉近BOSS，方便击杀或者牧师控制。',
},
{
role = 'HEALER',
expanded = false,
desc = '1.    战斗开始后分散站位，躲好火雨，治疗好中毒箭的玩家。德鲁伊优先驱散毒。\n2.    25人模式下精神控制的牧师听从指挥，在BOSS狂乱前控制膜拜者靠近BOSS，狂乱时对BOSS使用黑女巫的拥抱技能即可（使用技能后膜拜者就会死亡）。',
},
},
desc = '黑女巫法琳娜的战斗10人和25人模式有所区别，10人模式下无法精神控制小怪，在BOSS附近击杀小怪即可解除狂乱状态；25人模式下需要精神控制小怪自爆之后解除BOSS的狂乱状态。',
},
zone = 1,
name = '黑女巫法琳娜',
icon = '1378980',
abilities = {
children = {
{
spell = '28796',
title = '毒液箭雨',
noCollapse = false,
expanded = false,
desc = '向所有人喷射毒液造成自然伤害，并在接下来的8秒内每2秒造成一次额外伤害，可驱散。',
},
{
spell = '28794',
title = '火焰之雨',
noCollapse = false,
expanded = false,
desc = '随机区域召唤火焰之雨，对范围内玩家造成火焰伤害。',
},
{
spell = '28798',
title = '狂乱',
noCollapse = false,
expanded = false,
desc = 'BOSS攻击速度提高50%，对玩家造成的伤害提高。10人模式下膜拜者无法被精神控制，当膜拜者死亡之后，会造成一个范围冲击，解除BOSS的狂乱状态。25人模式下需要精神控制膜拜者，使用膜拜者的技能：黑女巫的拥抱使用后膜拜者会自爆，解除BOSS的狂乱状态。',
},
},
desc = '黑女巫法琳娜身边有2个追随者和4个膜拜者，膜拜者是解除BOSS狂乱状态的关键，10人模式下击杀膜拜者即可解除BOSS狂乱效果，25人模式下需要控制膜拜者，使用黑女巫的拥抱技能，让膜拜者自爆解除。战斗期间BOSS还会释放群体毒箭和火雨。',
},
},
[1111] = {
bossId = 1111,
summary = {
children = {
{
role = 'HEALER',
expanded = false,
desc = '1.    在场地中间集中站位，按照分配最远距离治疗T和DPS。\n2.    若被注射毒素（变异注射），速度跑到墙角的毒云边上，等待治疗解除疾病。解除后返回继续治疗。\n3.    指定解疾病的治疗随时注意被注射玩家，疾病不要第一时间驱散，需要中的玩家站好位置后驱散疾病。',
},
{
role = 'MELEE',
expanded = false,
desc = '1.    主T拉住后，站在BOSS的侧后方输出。注意毒云位置，边打边走，不要接触到毒云。\n2.    优先击杀出现的小软泥怪。\n3.    若被注射毒素（变异注射），速度跑到墙角的毒云边上，等待治疗解除疾病。解除后返回继续输出。',
},
{
role = 'RANGE',
expanded = false,
desc = '1.    在场地中间集中站位，最远距离输出BOSS。\n2.    若被注射毒素（变异注射），速度跑到墙角的毒云边上，等待治疗解除疾病。解除后返回继续输出。',
},
{
role = 'TANK',
expanded = false,
desc = '1.    主T开怪后将BOSS拉至墙边，一旦BOSS脚下生成毒云就沿着墙后退，确保不会接触到毒云。\n2.    T需要将BOSS拉着背对或者是侧对着大团和近战，避免软泥喷射到人群。\n3.    副T拉住产生的小软泥怪。',
},
},
desc = '格罗布鲁斯战斗开始后需要主T拉着BOSS在场地上不断移动来使得近战和T躲开毒云，其他人可集中站位，中注射玩家需要跑离大团，到角落去释放注射产生的毒云。',
},
zone = 4,
name = '格罗布鲁斯',
icon = '1378981',
abilities = {
children = {
{
spell = '28157',
title = '软泥喷射',
noCollapse = false,
expanded = false,
desc = '对BOSS身前释放一个范围性喷射，造成大量自然伤害，并且每个被击中的玩家都将召唤出一个小软泥怪。',
},
{
spell = '28240',
title = '毒云',
noCollapse = false,
expanded = false,
desc = 'BOSS脚下出现一片毒云，不会移动，但会随时间缓慢扩散开来，直到直径30码之后缓慢消失。接触到毒云会每秒掉血。',
},
{
spell = '28169',
title = '变异注射',
noCollapse = false,
expanded = false,
desc = '随机对一名玩家注射毒素，毒素为疾病，持续10秒，可驱散。持续时间结束或者被驱散后该玩家会对周围人造成伤害，且会在脚下出现一片毒云。',
},
},
desc = '格罗布鲁斯战斗是一场移动战，BOSS会不断在脚下出现毒云，且随机注射一个玩家，该玩家需要及时跑开全团，否则注射时间到了或者被驱散后，该玩家脚下也会出现毒云。',
},
},
[1112] = {
bossId = 1112,
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '1.    10人模式下，一阶段T将BOSS拉到台子下面，靠近门口即可。二阶段需要和全团人在台子下集合，根据熔岩喷射的规律跑动，躲避伤害。\n2.    25人模式下，一阶段T先将BOSS拉到台子下面靠近门口处，然后根据熔岩喷射的规律拉着BOSS跑动，躲避伤害。二阶段需要和全团人在台子下集合，根据熔岩喷射的规律跑动，躲避伤害。\n3.    BOSS所站台子为扇柄，台子以下区域为扇叶，将扇叶均分为4块区域（从门口至里面分别编号为1-2-3-4号）。熔岩喷射时只有一块安全区域，安全区域出现顺序为：1-2-3-4-3-2-1-2-3-4……，需要根据这个规律找到安全区域，躲避熔岩伤害。\n4.    二阶段熔岩喷射节奏会加快，需要集中精神跑动。',
},
{
role = 'HEALER',
expanded = false,
desc = '1.    一阶段在台子上集合站位治疗全团，牧师、骑士和萨满需要优先驱散疾病。二阶段需要和全团人在台子下集合，根据熔岩喷射的规律跑动，躲避伤害。\n2.    BOSS所站台子为扇柄，台子以下区域为扇叶，将扇叶均分为4块区域（从门口至里面分别编号为1-2-3-4号）。熔岩喷射时只有一块安全区域，安全区域出现顺序为：1-2-3-4-3-2-1-2-3-4……，需要根据这个规律找到安全区域，躲避熔岩伤害。',
},
{
role = 'MELEE',
expanded = false,
desc = '1.    10人模式下，一阶段输出BOSS即可。二阶段需要和全团人在台子下集合，根据熔岩喷射的规律跑动，躲避伤害。\n2.    25人模式下，一阶段在输出BOSS的同时需要根据熔岩喷射的规律跑动，躲避伤害。二阶段需要和全团人在台子下集合，根据熔岩喷射的规律跑动，躲避伤害。\n3.    BOSS所站台子为扇柄，台子以下区域为扇叶，将扇叶均分为4块区域（从门口至里面分别编号为1-2-3-4号）。熔岩喷射时只有一块安全区域，安全区域出现顺序为：1-2-3-4-3-2-1-2-3-4……，需要根据这个规律找到安全区域，躲避熔岩伤害。\n4.    二阶段熔岩喷射节奏会加快，需要集中精神跑动。',
},
{
role = 'RANGE',
expanded = false,
desc = '1.    一阶段在台子上集合站位输出BOSS。二阶段需要和全团人在台子下集合，根据熔岩喷射的规律跑动，躲避伤害。\n2.    BOSS所站台子为扇柄，台子以下区域为扇叶，将扇叶均分为4块区域（从门口至里面分别编号为1-2-3-4号）。熔岩喷射时只有一块安全区域，安全区域出现顺序为：1-2-3-4-3-2-1-2-3-4……，需要根据这个规律找到安全区域，躲避熔岩伤害。',
},
},
desc = '肮脏的希尔盖战斗10人和25人模式有所区别，10人在一阶段期间不需要跑动，25人模式的一阶段会喷发熔岩，需要坦克拉动BOSS跑位躲避。二阶段则是两种模式一样，所有人一起跑动躲避熔岩。',
},
zone = 2,
abilities = {
children = {
{
expanded = true,
noCollapse = false,
children = {
{
spell = '29310',
title = '法术瓦解',
noCollapse = false,
expanded = false,
desc = '附近所有目标施法速度降低。',
},
{
spell = '55011',
title = '衰老热疫',
noCollapse = false,
expanded = false,
desc = '对近战范围内所有目标释放疾病，疾病会降低血量上限的50%，并每3秒造成500伤害。',
},
{
spell = '29371',
title = '爆发（25人模式）',
noCollapse = false,
expanded = false,
desc = '每隔数秒，地面以固定规律喷射熔岩，接触到熔岩的玩家将受到大量自然伤害。',
},
},
title = '一阶段',
},
{
title = '二阶段',
expanded = true,
noCollapse = false,
children = {
{
spell = '29350',
title = '瘟疫之云',
noCollapse = false,
expanded = false,
desc = '给范围内所有玩家一个Debuff，持续性造成大量伤害。',
},
{
spell = '29371',
title = '爆发',
noCollapse = false,
expanded = false,
desc = '地面以固定规律喷射熔岩，接触到熔岩的玩家将受到大量自然伤害，二阶段喷射节奏加快。',
},
},
desc = '90秒后，BOSS回到平台，释放瘟疫之云。',
},
},
desc = '肮脏的希尔盖整体分为两个阶段，一阶段时BOSS可移动，10人模式下地面不会喷射熔岩，25人模式下地面会以固定规律喷射熔岩。二阶段BOSS在台子上释放技能无法靠近，台子下的地面会喷射熔岩，需要全团所有人一起跑动避开。二阶段结束后会回到一阶段，两阶段循环直至BOSS倒下。',
},
icon = '1378984',
name = '肮脏的希尔盖',
},
[1113] = {
bossId = 1113,
abilities = {
children = {
{
spell = '55543',
title = '瓦解怒吼',
noCollapse = false,
expanded = false,
desc = '凶猛的尖叫，对所有玩家造成大量伤害。',
},
{
spell = '37123',
title = '裂纹小刀',
noCollapse = false,
expanded = false,
desc = '对随机目标投出一把匕首造成大量伤害，附带持续性伤害。',
},
{
spell = '55470',
title = '紊乱打击',
noCollapse = false,
expanded = false,
desc = '对当前目标释放，造成大量物理伤害并使其防御值降低，持续6秒。',
},
},
desc = '教官拉苏维奥斯物理攻击非常强力，玩家无法坦克，需要控制死亡骑士学员，依靠学员的白骨屏障和嘲讽技能拉住BOSS，治疗在加好全团的血量之外也要注意当前的学员的血量。',
},
zone = 3,
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '1.    由控制学员的人控制开怪，开启学员的白骨屏障和嘲讽技能将BOSS拉至靠近楼梯位置。学员白骨屏障快结束时，控制另外的学员使用白骨屏障和嘲讽技能顶上，轮流控制学员直至BOSS倒下。\n2.    主副T将其余学员拉至另一边，方便控制。',
},
{
role = 'HEALER',
expanded = false,
desc = '1.    和大团集中站位，加好全团和学员的血量。\n2.    注意中裂纹小刀的人的血。',
},
{
role = 'MELEE',
expanded = false,
desc = '1.    等学员拉住BOSS后输出即可。',
},
{
role = 'RANGE',
expanded = false,
desc = '1.    集中站在楼梯上输出BOSS。',
},
},
desc = '教官拉苏维奥斯战斗开始后，10人模式下，需要操作场地上的控制水晶控制BOSS边上的死亡骑士学员（学员拥有白骨屏障和嘲讽技能），让学员开白骨屏障去坦BOSS。而25人模式下就需要牧师精神控制死亡骑士学员去坦克。',
},
icon = '1378988',
name = '教官拉苏维奥斯',
},
[1114] = {
bossId = 1114,
abilities = {
children = {
{
title = 'P1',
children = {
{
expanded = false,
noCollapse = false,
title = '骷髅',
desc = '接触人群会自爆释放暗影冲击，对所有目标造成大量暗影伤害。',
},
{
expanded = false,
noCollapse = false,
title = '女妖',
desc = '靠近目标会造成大量暗影伤害，且具有击退效果。',
},
{
expanded = false,
noCollapse = false,
title = '憎恶',
desc = '对近战释放仇恨打击，对目标释放重伤，降低10%治疗效果，可叠加。',
},
},
noCollapse = false,
expanded = true,
desc = '不断召唤3种小怪',
},
{
title = 'P2',
children = {
{
spell = '28478',
title = '单体寒冰箭',
noCollapse = false,
expanded = false,
desc = '对当前目标释放，造成大量冰霜伤害且减速，可打断。',
},
{
spell = '28479',
title = '群体寒冰箭',
noCollapse = false,
expanded = false,
desc = '对所有玩家释放，造成大量冰霜伤害。',
},
{
spell = '27810',
title = '暗影裂隙',
noCollapse = false,
expanded = false,
desc = '随机在一名玩家脚下释放，5秒后对还在范围内玩家造成大量暗影伤害。',
},
{
spell = '27808',
title = '冰霜冲击',
noCollapse = false,
expanded = false,
desc = '对随机玩家释放，使目标冻结进入昏迷状态，每秒造成大量冰霜伤害。该技能会同样影响周围10码范围内的玩家，且数量无上限。',
},
{
spell = '27819',
title = '自爆法力',
noCollapse = false,
expanded = false,
desc = '对随机一名玩家释放，使其在4秒后产生爆炸，且对周围玩家造成伤害。',
},
{
spell = '28410',
title = '克尔苏加德锁链',
noCollapse = false,
expanded = false,
desc = '随机控制1-3名玩家，被控制玩家体型变大，伤害和治疗能力增加。',
},
},
noCollapse = false,
expanded = true,
desc = '开始输出BOSS',
},
{
expanded = false,
noCollapse = false,
title = 'P3',
desc = '克尔苏加德血量降低至45%后进入P3，会刷新寒冰皇冠卫士。BOSS技能和P2一样。',
},
},
desc = '克尔苏加德整场战斗分为三个阶段，P1期间BOSS不参与战斗，不断召唤小怪。P2阶段后小怪不再刷新，开始输出BOSS，在BOSS血量降至45%时进入P3阶段，该阶段会召唤寒冰皇冠卫士。',
},
zone = 5,
name = '克尔苏加德',
icon = '1378989',
summary = {
children = {
{
role = 'HEALER',
expanded = false,
desc = 'P1：场地中间集中站位，治疗全团之余可以使用攻击技能输出骷髅。牧师锁住靠近大团的骷髅。\nP2：全场10码距离分散站位，治疗中技能玩家，躲开暗影裂隙。\nP3：和P2一样站位，躲好暗影裂隙。牧师可以锁住出现的寒冰皇冠卫士。',
},
{
role = 'MELEE',
expanded = false,
desc = 'P1：击杀憎恶，远离女妖和骷髅。\nP2：清理完场上小怪后输出BOSS，按照指挥分配分堆站位，打断单体寒冰箭，躲开暗影裂隙。若身边有人被BOSS控制，可以使用技能控制一下。\nP3：和P2一样站位输出BOSS，打断单体寒冰箭，躲开暗影裂隙。',
},
{
role = 'RANGE',
expanded = false,
desc = 'P1：场地中间集中站位，优先击杀骷髅和女妖。\nP2：全场10码距离分散站位，清理完所有场上小怪后最远距离输出BOSS，躲开暗影裂隙。若有玩家被BOSS控制，法师优先变羊\nP3：和P2一样站位输出BOSS，躲好暗影裂隙。',
},
{
role = 'TANK',
expanded = false,
desc = 'P1：拉住憎恶仇恨，远离女妖和骷髅。\nP2：主T在场地中间拉住BOSS，副T和近战分堆站在BOSS四周，打断单体寒冰箭，躲开暗影裂隙。\nP3：副T拉住出现的寒冰皇冠卫士（大甲虫）。',
},
},
desc = '克尔苏加德战斗开始时需要所有人站在场地中间输出小怪，进入P2阶段后，近战需要分堆站位，远程分散站位，确保不会在中冰霜冲击时连累太多人，战斗过程中躲避好脚下出现的暗影裂隙；进入P3后，副T拉住出现的小怪，其他人继续输出BOSS。',
},
},
[1115] = {
bossId = 1115,
summary = {
children = {
{
role = 'HEALER',
expanded = false,
desc = '1.    在死灵光环失效期间加好全团的血，优先加满主T和血少的。\n2.    死灵光环存在期间输出BOSS。',
},
{
role = 'MELEE',
expanded = false,
desc = '1.    开场后输出BOSS，孢子出现后，按照指挥分配，和队友一起去孢子刷新地点击杀孢子，吃到孢子的buff后返回全力输出BOSS。\n2.    吃孢子的时候和队友靠近，没有轮到的时候远离孢子，避免重复。',
},
{
role = 'RANGE',
expanded = false,
desc = '1.    开场后输出BOSS，孢子出现后，按照指挥分配，和队友一起去孢子刷新地点击杀孢子，吃到孢子的buff后返回全力输出BOSS。\n2.    吃孢子的时候和队友靠近，没有轮到的时候远离孢子，避免重复。',
},
{
role = 'TANK',
expanded = false,
desc = '1.    战斗开始主T将BOSS拉在房间中间，拉住仇恨即可，自身低血量时注意开启减伤技能。',
},
},
desc = '洛欧塞布战斗开始后需要治疗们注意死灵光环的倒数计时，消失后有3秒时间将全团血量补满，然后光环会再次出现开始倒数，如此不断的循环，其余时间都需要帮助输出。近战和远程输出都需要轮流吃孢子，确保输出伤害和仇恨。',
},
zone = 2,
name = '洛欧塞布',
icon = '1378991',
abilities = {
children = {
{
spell = '29204',
title = '必然的厄运',
noCollapse = false,
expanded = false,
desc = '战斗开始2分钟后，BOSS会对所有玩家释放必然的厄运诅咒，10秒后受到大量暗影伤害，之后每隔30秒释放一次，五分钟后会15秒释放一次。',
},
{
spell = '55593',
title = '死灵光环',
noCollapse = false,
expanded = false,
desc = '战斗开始每持续17秒后光环会失效3秒，光环持续期间治疗效果会降低100%，只有在失效时间内才能进行有效治疗。',
},
{
spell = '29234',
title = '召唤孢子',
noCollapse = false,
expanded = false,
desc = '战斗开始后BOSS房间墙边会刷新孢子，血量很少，打掉后会使附近最多5位玩家爆击提高50%，所有法术和技能都不会造成仇恨，持续1.5分钟。',
},
{
spell = '29865',
title = '死亡之花',
noCollapse = false,
expanded = false,
desc = '每隔30秒释放一次，对所有人在6秒内造成大量伤害，结束时还会额外造成伤害。',
},
},
desc = '洛欧塞布战斗开始之后会有治疗量降低100%的光环，持续17秒后停止3秒，一直循环至战斗结束，只有在停止的3秒时间内才能治疗。BOSS每隔一段时间还会释放厄运和死亡之花，均会造成全团伤害。',
},
},
[1116] = {
bossId = 1116,
summary = {
children = {
{
role = 'RANGE',
expanded = false,
desc = '1.    分配解救在墙角被包裹玩家的远程靠近墙边站位，若有玩家被包裹，迅速选取目标，第一时间打破蛛网解救。\n2.    其余远程和近战一起站位输出BOSS，召唤出小蜘蛛优先击杀。',
},
{
role = 'TANK',
expanded = false,
desc = '1.    进入战斗后，主T将BOSS拉在原位，使BOSS背对大团。\n2.    蛛网喷射（全团缠绕）前和BOSS狂暴时注意开保命技能。',
},
{
role = 'HEALER',
expanded = false,
desc = '1.    分配治疗墙角被包裹玩家的治疗者，靠近墙边站位，在BOSS释放技能时速度给蛛网内玩家治疗。\n2.    蛛网喷射（全团缠绕）前给主T加好所有持续性治疗技能，套好盾，确保主T在全团昏迷期间存活。\n3.    分配德鲁伊第一时间驱散主T身上的死灵之毒。',
},
{
role = 'MELEE',
expanded = false,
desc = '1.    进入战斗后站在BOSS背后输出，若被弹至墙角包裹，解除后需要迅速返回输出BOSS。\n2.    BOSS召唤小蜘蛛时使用群攻技能击杀小蜘蛛。',
},
},
desc = '迈克斯纳战斗期间需要分配玩家解救被蛛网包裹的人，在蛛网束缚全团前给T上好所有持续性治疗技能，结束后第一时间治疗主T，确保T的存活，召唤出的小蜘蛛也需要第一时间清理。',
},
zone = 1,
name = '迈克斯纳',
icon = '1378994',
abilities = {
children = {
{
spell = '52086',
title = '蛛网裹体',
noCollapse = false,
expanded = false,
desc = 'BOSS随机将3名玩家弹至墙角并用蛛网包裹住，玩家会受到持续的自然伤害，蛛网有血条，可打破。',
},
{
spell = '29484',
title = '蛛网喷射',
noCollapse = false,
expanded = false,
desc = '使用蛛网缠绕所有玩家造成自然伤害，并使全团昏迷，持续数秒。',
},
{
spell = '51357',
title = '召唤蜘蛛',
noCollapse = false,
expanded = false,
desc = 'BOSS会周期性的召唤出小蜘蛛。',
},
{
spell = '54121',
title = '死灵之毒',
noCollapse = false,
expanded = false,
desc = '使目标在30秒内治疗效果降低90%，可驱散。',
},
{
spell = '54123',
title = '狂乱',
noCollapse = false,
expanded = false,
desc = 'BOSS血量30%后会狂乱，使BOSS攻击速度提高50%，伤害提高。',
},
},
desc = '迈克斯纳整场战斗在蛛网上进行，BOSS会随机点名玩家在墙角被蛛网包裹住，需要打破蛛网解救队友，每隔一段时间BOSS会蛛网喷射束缚全团，期间不能进行任何动作，BOSS还会召唤小蜘蛛，需要及时清理。',
},
},
[1117] = {
bossId = 1117,
summary = {
children = {
{
role = 'HEALER',
expanded = false,
desc = '1.    和人群集中站位，加好全团。\n2.    德鲁伊第一时间驱散BOSS释放的群体诅咒。牧师可以在小怪多的时候锁住天灾战士。',
},
{
role = 'MELEE',
expanded = false,
desc = '1.    进入战斗后对BOSS输出。BOSS瞬移时停止输出，等T拉住仇恨之后再输出。\n2.    BOSS上墙后帮助击杀小怪，第二次上墙后优先控制击杀天灾卫士。\n3.    BOSS下来后仍先击杀完小怪后再继续输出BOSS。',
},
{
role = 'TANK',
expanded = false,
desc = '1.    主T开怪，将BOSS拉在房间正中间，BOSS瞬移后和从阳台上下来时，都需要主T及时拉住仇恨。副T站在人群外，等待拉住召唤出的小怪。\n2.    BOSS上平台后，召唤出的小怪需要T拉出人群后等待击杀。',
},
{
children = {
},
role = 'RANGE',
expanded = false,
desc = '1.    集中站位，优先击杀召唤出的精英怪。\n2.    小怪击杀完之后再输出BOSS，BOSS瞬移时停止输出，等T拉住仇恨之后再输出。BOSS第二次上墙后优先控制击杀天灾卫士（奥爆法系怪）。\n3.    法师第一时间驱散BOSS释放的群体诅咒。',
},
},
desc = '药剂师诺斯的战斗需要主T在BOSS瞬移后及时拉住仇恨，并且在召唤小怪后和副T一起拉住小怪的仇恨，全团需要在BOSS第三次上平台前击杀BOSS，第三次BOSS下来就会狂暴灭团。',
},
zone = 2,
name = '瘟疫使者诺斯',
icon = '1379004',
abilities = {
children = {
{
spell = '54835',
title = '药剂师诅咒',
noCollapse = false,
expanded = false,
desc = '使BOSS身边的人受到诅咒，如果10秒内未被驱散，则周围的玩家都会遭受到一波暗影伤害，还会附带持续性伤害。',
},
{
spell = '65793',
title = '闪现',
noCollapse = false,
expanded = false,
desc = 'BOSS闪现至前方，并清除仇恨。',
},
{
spell = '54814',
title = '残废术',
noCollapse = false,
expanded = false,
desc = 'BOSS瞬移时对近战范围内玩家释放，降低玩家移动速度和攻击速度，可驱散。',
},
{
expanded = false,
noCollapse = false,
title = '召唤骷髅战士',
desc = '每隔30秒，BOSS会从房间的骨堆上召唤天灾战士（精英小怪）。',
},
{
expanded = false,
noCollapse = false,
title = '上平台',
desc = '每隔一段时间BOSS会上到阳台上，无法被攻击，期间会在骨堆上召唤更多的精英小怪，每一次上墙召唤的小怪都比上一次更多，时间到达BOSS将会瞬移回房间正中位置。第一次召唤4个天灾勇士，第二次召唤4个天灾勇士+2个天灾卫士，第三次召唤与第二次相似。',
},
},
desc = '药剂师诺斯战斗开始后会瞬移清空仇恨，期间还会释放群体残废，在战斗过程中会召唤精英小怪。每隔一段时间BOSS还会传送到墙上的阳台上召唤更多的精英小怪，期间无法被攻击。BOSS会在传送三次后进入狂暴状态，造成灭团伤害。',
},
},
[1118] = {
bossId = 1118,
summary = {
children = {
{
role = 'HEALER',
expanded = false,
desc = '按照指挥分配加好负责的T的血量，其他人不需要治疗。',
},
{
role = 'MELEE',
expanded = false,
desc = '确保自己血量低于坦克，注意仇恨，全力输出。',
},
{
role = 'RANGE',
expanded = false,
desc = '注意仇恨，全力输出。',
},
{
role = 'TANK',
expanded = false,
desc = '1.    主T开怪，确保第一个进入BOSS仇恨列表，副T确保血量高于其他团员。\n2.    最后阶段BOSS狂乱后开启保命技能。',
},
},
desc = '帕奇维克伤害很高，对坦克和治疗的压力都很大，坦克会吃到巨量的伤害，需要治疗们安排好治疗循环，另外对DPS的要求也很大，是一场输出竞赛。',
},
zone = 4,
abilities = {
children = {
{
spell = '41926',
title = '仇恨打击',
noCollapse = false,
expanded = false,
desc = '对近战范围内血量最高的有仇恨的目标造成巨量伤害。',
},
{
spell = '28131',
title = '狂乱',
noCollapse = false,
expanded = false,
desc = '当帕奇维克血量降低至5%后，攻击速度提升100%。',
},
},
desc = '帕奇维克伤害是纯物理伤害，伤害非常的高，需要坦克轮流承担伤害。BOSS战斗开始后规定时间内没有击杀，BOSS就会狂暴，造成足以秒杀的伤害。',
},
icon = '1379005',
name = '帕奇维克',
},
[1119] = {
bossId = 1119,
abilities = {
children = {
{
title = '地面阶段',
noCollapse = false,
expanded = true,
children = {
{
spell = '28531',
title = '冰霜光环',
noCollapse = false,
expanded = false,
desc = '每2秒造成冰霜伤害。',
},
{
spell = '28542',
title = '生命吸取',
children = {
},
noCollapse = false,
expanded = false,
desc = '对随机玩家释放诅咒，每3秒造成大量暗影伤害且恢复BOSS血量，可驱散。',
},
{
spell = '28560',
title = '召唤暴风雪',
noCollapse = false,
expanded = false,
desc = '随机位置释放一个暴风雪，且暴风雪会移动，暴风雪范围内玩家会每2秒受到大量冰霜伤害且降低移动速度。',
},
{
spell = '55697',
title = '扫尾',
noCollapse = false,
expanded = false,
desc = '对位于BOSS身后锥形范围内玩家造成物理伤害，并击退。',
},
{
spell = '19983',
title = '顺劈斩',
noCollapse = false,
expanded = false,
desc = '对目标和他周围玩家造成大量物理伤害。',
},
},
},
{
title = '空中阶段',
noCollapse = false,
expanded = true,
children = {
{
spell = '28531',
title = '冰霜光环',
noCollapse = false,
expanded = false,
desc = '每2秒造成冰霜伤害。',
},
{
spell = '28522',
title = '寒冰箭',
noCollapse = false,
expanded = false,
desc = '将随机目标禁锢在寒冰之中，使其陷入昏迷且对目标周围玩家造成大量冰霜伤害。',
},
{
spell = '44799',
title = '冰霜吐息',
noCollapse = false,
expanded = false,
desc = '对玩家造成足够秒杀的冰霜伤害，可在冰块后躲避。',
},
},
},
},
desc = '萨菲隆战斗分为两个阶段，开始时为地面阶段，每隔60秒，BOSS进入空中阶段，会数次将随机一名玩家冻成冰块，且对冰块周围玩家造成大量的冰霜伤害。冰冻结束后，BOSS对场地正中间释放冰霜吐息，需要在冰块后躲避伤害，否则会被秒杀，吐息结束后BOSS回到地面阶段，两阶段循环直至BOSS倒下。',
},
zone = 5,
name = '萨菲隆',
icon = '1379010',
summary = {
children = {
{
role = 'HEALER',
expanded = false,
desc = '1.    根据指挥分配站位，在BOSS两侧分散治疗。德鲁伊第一时间驱散好诅咒。\n2.    躲好暴风雪。\n3.    BOSS上天后分散站位，冰霜吐息时第一时间到冰块后躲避。',
},
{
role = 'MELEE',
expanded = false,
desc = '1.    根据指挥分配站位，在BOSS两侧输出BOSS。\n2.    躲好暴风雪。\n3.    BOSS上天后分散站位，冰霜吐息时第一时间到冰块后躲避。',
},
{
role = 'RANGE',
expanded = false,
desc = '1.    根据指挥分配站位，在BOSS两侧分散输出BOSS。法师第一时间驱散好诅咒。\n2.    躲好暴风雪。\n3.    BOSS上天后分散站位，冰霜吐息时第一时间到冰块后躲避。',
},
{
role = 'TANK',
expanded = false,
desc = '1.    萨菲隆只需要主T，开打后将BOSS拉在原地，且BOSS背对入口。\n2.    躲避好暴风雪。\n3.    BOSS上天后分散站位，冰霜吐息时第一时间到冰块后躲避。',
},
},
desc = '萨菲隆战斗地面阶段需要所有人躲避好暴风雪，空中阶段时需要所有人分散站位，避免被点名成冰块的人炸伤，在冰霜吐息出现后尽快躲到冰块后面避免被秒杀。',
},
},
[1120] = {
bossId = 1120,
name = '塔迪乌斯',
zone = 4,
abilities = {
children = {
{
title = '斯塔拉格',
noCollapse = false,
expanded = true,
children = {
{
spell = '54529',
title = '能量涌动',
noCollapse = false,
expanded = false,
desc = 'BOSS攻击速度提高，造成的伤害提高，持续10秒。',
},
{
spell = '54517',
title = '磁性牵引',
noCollapse = false,
expanded = false,
desc = '每隔一段时间，斯塔拉格和费尔根同时使用电磁牵引，将对方的第一仇恨目标拖至自己面前，并将仇恨值交换。',
},
},
},
{
title = '费尔根',
noCollapse = false,
expanded = true,
children = {
{
spell = '28135',
title = '静止力场',
noCollapse = false,
expanded = false,
desc = '每秒对自身平台上玩家造成自然伤害。',
},
{
spell = '54517',
title = '磁性牵引',
noCollapse = false,
expanded = false,
desc = '每隔一段时间，费尔根和斯塔拉格同时使用电磁牵引，将对方的第一仇恨目标拖至自己面前，并将仇恨值交换。',
},
},
},
{
title = '塔迪乌斯',
noCollapse = false,
expanded = false,
children = {
{
spell = '28089',
title = '极性转化',
noCollapse = false,
expanded = false,
desc = '每隔一段时间会对所有玩家随机释放正能量电荷或者负能量电荷，相同电荷玩家互相靠近时，会周围给同电荷玩家提高造成的伤害BUFF。不同电荷玩家相互靠近时，会对附近所有玩家造成伤害。',
},
{
spell = '28167',
title = '闪电链',
noCollapse = false,
expanded = false,
desc = '对当前目标释放，击中后继续攻击附近多个目标。',
},
{
spell = '28299',
title = '球状闪电',
noCollapse = false,
expanded = false,
desc = '当BOSS近战范围内没有可攻击目标时会释放此技能，每个闪电都会对目标造成巨量伤害。',
},
},
},
},
desc = '塔迪乌斯战斗分为2个阶段，第一阶段需要先同时击杀两边小平台的小boss斯塔拉格和费尔根，第二阶段需要跳至BOSS所在平台等待BOSS激活，BOSS每隔一段时间会释放电荷，所有人需要查看身上的电荷正负极，根据指挥分配位置和其他同一种电荷的站在一起。6分钟内没有击杀则BOSS狂暴。',
},
icon = '1379019',
summary = {
children = {
{
role = 'HEALER',
expanded = false,
children = {
{
expanded = false,
noCollapse = false,
title = '小BOSS阶段',
desc = '1.    按照分配前往2个小BOSS平台治疗。\n2.    T被交换位置时，及时切换目标，治疗BOSS的当前T。',
},
{
expanded = false,
noCollapse = false,
title = '塔迪乌斯阶段',
desc = '1.    跳上BOSS所在平台后，和主T站在一起等待BOSS激活。\n2.    根据指挥分配看好T和自身队伍血量。\n3.    BOSS释放电荷时第一时间查看身上电荷标记，然后按照指挥分配和其他同一种电荷（加号或者减号）的人一起站在BOSS侧面。每一次电荷变换均要注意，电荷仍旧为正极或者负极就原地不动，若正极变为负极，或者负极变为正极，就跑至BOSS对面，确保和所有同样电荷玩家站在一起。循环直至BOSS倒下。\n4.    注意：电荷变换时打断读条，第一时间换位。',
},
},
},
{
role = 'MELEE',
expanded = false,
children = {
{
expanded = false,
noCollapse = false,
title = '小BOSS阶段',
desc = '1.    按照分配前往两个小平台输出。\n2.    注意小BOSS血量，确保费尔根和斯塔拉格同时死亡。',
},
{
expanded = false,
noCollapse = false,
title = '塔迪乌斯阶段',
desc = '1.    跳上BOSS所在平台后，和主T站在一起等待BOSS激活，激活后输出BOSS。\n2.    BOSS释放电荷时第一时间查看身上电荷标记，然后按照指挥分配和其他同一种电荷（加号或者减号）的人一起站在BOSS侧面。每一次电荷变换均要注意，电荷仍旧为正极或者负极就原地不动，若正极变为负极，或者负极变为正极，就跑至BOSS对面，确保和所有同样电荷玩家站在一起。循环直至BOSS倒下。',
},
},
},
{
role = 'RANGE',
expanded = false,
children = {
{
expanded = false,
noCollapse = false,
title = '小BOSS阶段',
desc = '1.    按照分配前往两个小平台输出。\n2.    注意小BOSS血量，确保费尔根和斯塔拉格同时死亡。',
},
{
expanded = false,
noCollapse = false,
title = '塔迪乌斯阶段',
footDesc = '1.    跳上BOSS所在平台后，和主T站在一起等待BOSS激活，激活后输出BOSS。\n2.    BOSS释放电荷时第一时间查看身上电荷标记，然后按照指挥分配和其他同一种电荷（加号或者减号）的人一起站在BOSS侧面。每一次电荷变换均要注意，电荷仍旧为正极或者负极就原地不动，若正极变为负极，或者负极变为正极，就跑至BOSS对面，确保和所有同样电荷玩家站在一起。循环直至BOSS倒下。\n3.    注意：电荷变换时打断读条，第一时间换位。',
},
},
},
{
role = 'TANK',
expanded = false,
children = {
{
expanded = false,
noCollapse = false,
title = '小BOSS阶段',
desc = '1.    每个平台一个T，拉好当前小BOSS仇恨。\n2.    被抛至另一平台后迅速拉好当前BOSS，循环直至小BOSS被同时击杀。',
},
{
expanded = false,
noCollapse = false,
title = '塔迪乌斯阶段',
desc = '1.    跳上BOSS所在平台后，主T站在BOSS前方等待BOSS激活后拉住仇恨。\n2.    BOSS释放电荷时第一时间查看身上电荷标记，然后按照指挥分配和其他同一种电荷（加号或者减号）的人一起站在BOSS侧面。每一次电荷变换均要注意，电荷仍旧为正极或者负极就原地不动，若正极变为负极，或者负极变为正极，就跑至BOSS对面，确保和所有同样电荷玩家站在一起。循环直至BOSS倒下。',
},
},
},
},
desc = '塔迪乌斯战斗开始后需要先击杀两个平台上的小BOSS，小BOSS需要同时击杀，否则会再次复活，击杀之后跳至BOSS所在平台开启BOSS战。战斗期间BOSS释放电荷时注意自身的电荷属性，同一种电荷的站在一起会增加攻击力，而不同电荷的站一起会受到伤害。',
},
},
[1121] = {
bossId = 1121,
abilities = {
children = {
{
title = '瑞文戴尔男爵',
children = {
{
spell = '28882',
title = '邪恶之影',
noCollapse = false,
expanded = false,
desc = '对当前目标造成大量暗影伤害，并附带一个持续性伤害，不可驱散。',
},
{
spell = '28834',
title = '瑞文戴尔印记',
noCollapse = false,
expanded = false,
desc = '对光环范围内玩家造成伤害并留下印记，叠加的印记层数越多所受伤害越大。',
},
},
noCollapse = false,
expanded = true,
desc = '激活后会跑向大门右侧的角落',
},
{
title = '库尔塔兹领主',
children = {
{
spell = '57467',
title = '流星',
noCollapse = false,
expanded = false,
desc = '范围伤害，由陨石冲击点周围8码内所有玩家共同分担。',
},
{
spell = '28832',
title = '库尔塔兹印记',
noCollapse = false,
expanded = false,
desc = '对光环范围内玩家造成伤害并留下印记，叠加的印记层数越多所受伤害越大。',
},
},
noCollapse = false,
expanded = true,
desc = '激活后会跑向大门左侧的角落',
},
{
title = '瑟里耶克爵士',
children = {
{
spell = '28883',
title = '神圣愤怒',
children = {
},
noCollapse = false,
expanded = false,
desc = '对第一个目标射出神圣箭矢，随后会在目标和其身旁玩家间弹跳，造成神圣伤害，每次跳跃提高50%伤害。',
},
{
spell = '57376',
title = '神圣之箭',
noCollapse = false,
expanded = false,
desc = '对距离最近玩家连发此技能，造成大量神圣伤害。',
},
{
spell = '57377',
title = '谴责',
noCollapse = false,
expanded = false,
desc = '如瑟里耶克爵士无法攻击到任何玩家，对所有目标造成大量神圣伤害。',
},
{
spell = '28835',
title = '瑟里耶克印记',
noCollapse = false,
expanded = false,
desc = '对光环范围内玩家造成伤害并留下印记，叠加的印记层数越多所受伤害越大。',
},
},
noCollapse = false,
expanded = true,
desc = '激活后会跑向远离大门的右边角落',
},
{
title = '女公爵布劳缪克丝',
children = {
{
spell = '57374',
title = '暗影箭',
noCollapse = false,
expanded = false,
desc = '对距离自己最近的目标射出魔法箭，造成大量暗影伤害。',
},
{
spell = '28863',
title = '虚空领域',
noCollapse = false,
expanded = false,
desc = '随机范围内玩家脚下召唤一个虚空领域，对站在范围内的所有玩家造成暗影伤害。',
},
{
spell = '28833',
title = '布劳缪克丝印记',
noCollapse = false,
expanded = false,
desc = '对光环范围内玩家造成伤害并留下印记，叠加的印记层数越多所受伤害越大。',
},
{
spell = '57381',
title = '不灭痛楚',
noCollapse = false,
expanded = false,
desc = '如女公爵布劳缪克丝无法攻击到任何玩家，对所有目标造成大量暗影伤害',
},
},
noCollapse = false,
expanded = true,
desc = '激活后会跑向远离大门的左边角落',
},
},
desc = '天启四骑士有4个BOSS，分别是瑞文戴尔男爵、库尔塔兹领主、瑟里耶克爵士、女公爵布劳缪克丝，4个BOSS都有各自的光环印记和独特技能，相同光环印记可叠加，层数越高受到的伤害越多，每个BOSS的印记互不干涉。开战后BOSS会自动跑向房间的四个角落。',
},
zone = 3,
name = '天启四骑士',
icon = '1385732',
summary = {
children = {
{
role = 'HEALER',
expanded = false,
desc = '1.    跟随分配到的主副T，T去接手哪个BOSS就去跟随治疗。\n2.    进内场加血的治疗需要注意身上光环，一种光环叠加过高时去另一个BOSS附近即可。\n3.    击杀库尔塔兹领主时治疗和T站在一起，击杀女公爵布劳缪克丝拉时注意躲避脚下出现的黑水。',
},
{
role = 'MELEE',
expanded = false,
desc = '1.    和主T站一起全力爆发输出库尔塔兹领主。领主死亡后输出瑞文戴尔男爵。25人模式下若无法击杀瑞文戴尔男爵则需要去输出瑟里耶克爵士，等印记消掉之后再返回击杀瑞文戴尔男爵。\n2.    输出库尔塔兹领主时注意和T站在一起，输出女公爵布劳缪克丝拉时注意躲避脚下出现的黑水。',
},
{
role = 'RANGE',
expanded = false,
desc = '1.    和主T站一起全力爆发输出库尔塔兹领主。领主死亡后输出瑞文戴尔男爵。25人模式下若无法击杀瑞文戴尔男爵则需要去输出瑟里耶克爵士，等印记消掉之后再返回击杀瑞文戴尔男爵。\n2.    输出库尔塔兹领主时注意和T站在一起，输出女公爵布劳缪克丝拉时注意躲避脚下出现的黑水。',
},
{
role = 'TANK',
expanded = false,
desc = '1.    10人模式下需要主T拉住库尔塔兹领主和瑞文戴尔男爵。副T和一个血量较高的治疗去内场分别站在女公爵布劳缪克丝和瑟里耶克爵士附近。光环叠加过高时两个人互换位置即可。击杀完前场的两个BOSS，再去拉住后场两个BOSS。\n2.    25人模式下需要主T前往靠近大门的左侧角落拉住库尔塔兹领主。副T前往靠近大门的右侧角落拉住瑞文戴尔男爵。\n主T在库尔塔兹领主死后接手瑞文戴尔男爵，此时副T需要前往台子上等待消除印记，待印记消除后再去接手瑞文戴尔男爵。\n女公爵布劳缪克丝和瑟里耶克爵士需要2个血量较高的人去抗住伤害。在印记叠加过3层后交换位置即可。',
},
},
desc = '天启四骑士开场后需要大团优先击杀库尔塔兹领主，然后再去输出瑞文戴尔男爵，两个BOSS杀完之后再击杀剩余两个，注意一种印记叠加过高之后就需要切换到另一个BOSS处输出。瑟里耶克爵士和女公爵布劳缪克丝前期只需要他们的光环范围内有人，在光环叠加过高之后换位置去另一个BOSS范围内，待光环消除之后再更换回来即可。',
},
},
[1094] = {
bossId = 1094,
abilities = {
children = {
{
children = {
{
spell = '56272',
title = '奥术吐息',
noCollapse = false,
expanded = false,
desc = '对正面所有人造成大量伤害且附加一个数秒后会爆炸的debuff，爆炸会对周围人造成大量伤害。',
},
{
spell = '57473',
title = '奥术风暴',
noCollapse = false,
expanded = false,
desc = '随机对数个目标施放，造成大量伤害。',
},
{
spell = '56266',
title = '漩涡',
noCollapse = false,
expanded = false,
desc = 'BOSS飞至空中，将所有人卷上天，期间造成持续性的大量伤害。',
},
{
spell = '55849',
title = '能量火花',
noCollapse = false,
expanded = false,
desc = '每隔一段时间召唤一个火花，从场地外围向BOSS靠近，BOSS一旦吸收会提升攻击力。火花可击杀，击杀后会留下一个区域，站在其中的玩家会提升伤害。',
},
},
noCollapse = false,
title = 'P1阶段',
expanded = true,
},
{
children = {
{
spell = '56431',
title = '奥术炸弹',
noCollapse = false,
expanded = false,
desc = '对任意地点投掷奥术炸弹，击退附近目标并造成大量伤害。',
},
{
spell = '125030',
title = '深呼吸',
noCollapse = false,
expanded = false,
desc = '对整个场地释放吐息，每秒造成大量伤害。',
},
{
spell = '45848',
title = '蓝龙护盾',
noCollapse = false,
expanded = false,
desc = '场地上随机位置出现一个护盾，进入后会吸收BOSS的伤害，护盾会不断缩小，需要及时更换。',
},
},
noCollapse = false,
title = 'P2阶段',
expanded = true,
},
{
children = {
{
children = {
{
spell = '54672',
title = '能量涌动',
noCollapse = false,
expanded = false,
desc = '对随机目标造成持续性的大量伤害，技能无冷却时间。',
},
{
spell = '57428',
title = '静电力场',
noCollapse = false,
expanded = false,
desc = '随机对一个目标释放秘法球，对目标范围内的所有人造成大量群体伤害。',
},
},
noCollapse = false,
title = 'BOSS',
expanded = false,
},
{
children = {
{
spell = '56091',
title = '烈焰之刺',
noCollapse = false,
expanded = false,
desc = '向目标发射火焰，造成大量火焰伤害，奖励一个连击点数。',
},
{
spell = '56092',
title = '烈焰噬体',
noCollapse = false,
expanded = false,
desc = '喷射火焰，对目标造成持续性伤害，可叠加，根据连击点数决定持续时间。',
},
{
spell = '57090',
title = '再生',
noCollapse = false,
expanded = false,
desc = '每秒为目标恢复生命值，持续一段时间，可叠加，奖励一个连击点数。',
},
{
spell = '57143',
title = '生命爆发',
noCollapse = false,
expanded = false,
desc = '治疗周围范围内友方目标，并使施法者治疗效果提高。治疗效果和持续时间根据连击点数的数量决定。',
},
{
spell = '57108',
title = '烈焰之盾',
noCollapse = false,
expanded = false,
desc = '使施法者所有受到伤害降低，根据连击点数的数量决定持续时间。',
},
{
spell = '57092',
title = '炽热疾速',
noCollapse = false,
expanded = false,
desc = '飞行速度提高，持续数秒。',
},
},
noCollapse = false,
title = '坐骑龙',
expanded = false,
},
},
noCollapse = false,
title = 'P3阶段',
expanded = true,
},
},
desc = '整个永恒之眼副本只有玛里苟斯一个BOSS，整场战斗分为3个阶段。第一阶段在场地正中间，BOSS血量降低至50%的血量会进入第二阶段，玛里苟斯进入无法攻击状态，场地内出现站在飞盘上的小怪，在击杀完所有小怪后进入第三阶段，场地会被摧毁，全员骑龙，且使用龙的技能作战。',
},
name = '玛里苟斯',
icon = '1385753',
summary = {
children = {
{
role = 'HEALER',
expanded = false,
desc = 'P1：在BOSS侧面治疗全团，在漩涡结束后立即离开BOSS龙头方向。\nP2：注意大团血量，在蓝龙盾内躲避BOSS的深呼吸和远程小怪的技能，盾范围缩小后及时更换位置。\nP3：失去自身职业技能，全部使用坐骑龙的技能，按照指挥安排进行治疗或者输出。负责输出的可以按两下1技能，然后就按2技能叠加伤害，血少的按4技能回血。负责治疗的可以按两下3技能，再按4技能，所有人中点名技能了按5减伤。躲好BOSS放出的秘法球。',
},
{
role = 'MELEE',
expanded = false,
desc = 'P1：在BOSS侧面输出BOSS，在力量火花靠近BOSS时优先击杀能量火花。在漩涡结束后立即离开BOSS龙头方向。\nP2：优先击杀地面上的小怪，然后登录小怪留下的圆盘，操作圆盘飞上去击杀远程小怪。在地面时，注意进入蓝龙盾内躲避BOSS的深呼吸和远程小怪的技能，盾范围缩小后及时更换位置。\nP3：失去自身职业技能，全部使用坐骑龙的技能，按照指挥安排进行治疗或者输出。负责输出的可以按两下1技能，然后就按2技能叠加伤害，血少的按4技能回血。负责治疗的可以按两下3技能，再按4技能，所有人中点名技能了按5减伤。躲好BOSS放出的秘法球。',
},
{
children = {
},
role = 'RANGE',
expanded = false,
desc = 'P1：在BOSS侧面输出BOSS，优先击杀能量火花。火花死亡后地面会留下一个光环，站在上面可以增加伤害。在漩涡结束后立即离开BOSS龙头方向。\nP2：优先击杀地面上的小怪，然后再输出远程小怪，在蓝龙盾内躲避BOSS的深呼吸和远程小怪的技能，盾范围缩小后及时更换位置。\nP3：失去自身职业技能，全部使用坐骑龙的技能，按照指挥安排进行治疗或者输出。负责输出的可以按两下1技能，然后就按2技能叠加伤害，血少的按4技能回血。负责治疗的可以按两下3技能，再按4技能，所有人中点名技能了按5减伤。躲好BOSS放出的秘法球。',
},
{
role = 'TANK',
expanded = false,
desc = 'P1：主T将BOSS拉在中间，漩涡下地后立即拉住BOSS，避免龙头面向大团。\nP2：拉住降至地面的近战小怪，在蓝龙盾内躲避BOSS的深呼吸和远程小怪的技能。盾范围缩小后及时更换位置。\nP3：失去自身职业技能，全部使用坐骑龙的技能，按照指挥安排进行治疗或者输出。负责输出的可以按两下1技能，然后就按2技能叠加伤害，血少的按4技能回血。负责治疗的可以按两下3技能，再按4技能，所有人中点名技能了按5减伤。躲好BOSS放出的秘法球。',
},
},
desc = '玛里苟斯战斗分为三阶段，一阶段在场地正中间开打，BOSS会飞到空中释放漩涡，还会召唤火花，一旦火花被BOSS吸收掉就会提升BOSS攻击力。BOSS血量降低至50%的血量会进入第二阶段，场面上出现站在飞盘上的小怪，清理完之后进入第三阶段，场地会被摧毁，全员骑龙，失去自身的职业技能，使用龙的技能作战。',
},
},
[1126] = {
bossId = 1126,
summary = {
children = {
{
role = 'MELEE',
expanded = false,
desc = '1.    战斗开始全力输出BOSS，若边上有人中了岩石碎片技能，赶紧远离中技能的人。\n2.    远离重压跳跃后产生的云雾。',
},
{
role = 'HEALER',
expanded = false,
desc = '1.    分散站位治疗全团，特别是注意中岩石碎片和重压跳跃技能的人。主T在被穿刺时也需要照顾好两个坦克的血量。\n2.    若边上有人中了岩石碎片技能，赶紧远离中技能的人。\n3.    远离重压跳跃后产生的云雾。',
},
{
role = 'RANGE',
expanded = false,
desc = '1.    分散站位输出BOSS，若边上有人中了岩石碎片技能，赶紧远离中技能的人。\n2.    远离重压跳跃后产生的云雾。',
},
{
role = 'TANK',
expanded = false,
desc = '1.    主T拉住BOSS，在BOSS施放重压跳跃时主T要跑向BOSS拉住仇恨。\n2.    在主T被穿刺时需要副T嘲讽，接手BOSS。',
},
},
desc = '岩石看守者阿尔卡冯的战斗需要所有人躲避岩石碎片技能，且在边上人被重压跳跃后赶紧跑开，避免受到窒息云雾的伤害。副T在主T被穿刺的时候要及时拉住BOSS仇恨。',
},
name = ' 岩石看守者阿尔卡冯',
icon = '1385715',
abilities = {
children = {
{
spell = '58678',
title = '岩石碎片',
noCollapse = false,
expanded = false,
desc = '随机对一个玩家快速的发射石片，造成大量物理伤害，同时也会对目标周围的人造成伤害。',
},
{
spell = '58960',
title = '重压跳跃',
noCollapse = false,
expanded = false,
desc = '随机对一个玩家进行跳跃攻击，造成大量物理伤害并击退 ，会在地面上留下一片窒息云雾。',
},
{
spell = '58965',
title = '窒息云雾',
noCollapse = false,
expanded = false,
desc = '重压跳跃后地面留下一片云雾，云雾内的玩家会受到持续性的自然伤害，并使命中降低50%。',
},
{
spell = '58663',
title = '践踏',
noCollapse = false,
expanded = false,
desc = '使所有玩家眩晕，并造成大量的物理伤害。',
},
{
spell = '58978',
title = '穿刺',
noCollapse = false,
expanded = false,
desc = '践踏后的连续技能，对当前目标使用，造成大量物理伤害，并将该目标捏在手上使其数秒内无法行动，且会暂时移除仇恨。',
},
},
desc = '岩石看守者阿尔卡冯战斗开始后，会对随机目标发射岩石碎片，重压跳跃之后会留下云雾，都需要及时躲避，BOSS践踏技能后，还需要副T接手，BOSS会在战斗开始5分钟后狂暴。',
},
},
[772] = {
bossId = 772,
abilities = {
desc = '岩石看守者阿尔卡冯战斗开始后，会对随机目标发射岩石碎片，重压跳跃之后会留下云雾，都需要及时躲避，BOSS践踏技能后，还需要副T接手，BOSS会在战斗开始5分钟后狂暴。',
},
name = ' 岩石看守者阿尔卡冯',
summary = {
desc = '岩石看守者阿尔卡冯的战斗需要所有人躲避岩石碎片技能，且在边上人被重压跳跃后赶紧跑开，避免受到窒息云雾的伤害。副T在主T被穿刺的时候要及时拉住BOSS仇恨。',
},
icon = '1385715',
},
[742] = {
bossId = 742,
abilities = {
desc = '黑曜石圣殿只有萨塔里奥一个BOSS，在面对他之前要先清理周围的小怪，还有他的三条暮光幼龙“维斯匹隆”、“塔尼布隆”和“沙德隆”。BOSS萨塔里奥战斗开始后会从两边的熔岩内不断召唤熔岩元素，每隔一段时间还会召唤熔岩墙扫过战斗区域，随机释放的火雨也是需要注意的。',
},
name = '萨塔里奥',
summary = {
desc = '黑曜石圣殿内的三个暮光幼龙可以选择性击杀，每保留一个幼龙副本难度会增加且BOSS多一件装备掉落。在BOSS战时BOSS会召唤未被击杀的暮光龙，且每条龙在场地上被击杀时都会导致BOSS攻击增加。BOSS战时需要大团在场地侧面输出，躲避出现的所有技能。',
},
icon = '1385765',
},
[734] = {
bossId = 734,
abilities = {
desc = '整个永恒之眼副本只有玛里苟斯一个BOSS，整场战斗分为3个阶段。第一阶段在场地正中间，BOSS血量降低至50%的血量会进入第二阶段，玛里苟斯进入无法攻击状态，场地内出现站在飞盘上的小怪，在击杀完所有小怪后进入第三阶段，场地会被摧毁，全员骑龙，且使用龙的技能作战。',
},
name = '玛里苟斯',
summary = {
desc = '玛里苟斯战斗分为三阶段，一阶段在场地正中间开打，BOSS会飞到空中释放漩涡，还会召唤火花，一旦火花被BOSS吸收掉就会提升BOSS攻击力。BOSS血量降低至50%的血量会进入第二阶段，场面上出现站在飞盘上的小怪，清理完之后进入第三阶段，场地会被摧毁，全员骑龙，失去自身的职业技能，使用龙的技能作战。',
},
icon = '1385753',
},
[1090] = {
bossId = 1090,
abilities = {
children = {
{
children = {
{
spell = '59126',
title = '暗影吐息',
noCollapse = false,
expanded = false,
desc = '对正面锥形范围内的所有目标造成大量暗影伤害。',
},
{
spell = '59127',
title = '暗影裂隙',
noCollapse = false,
expanded = false,
desc = '会随机在一个目标脚下设置死亡之环，数秒后爆炸造成大量暗影伤害。',
},
},
noCollapse = false,
title = '暮光幼龙共有技能',
expanded = true,
},
{
children = {
{
expanded = false,
noCollapse = false,
title = '维斯匹隆技能',
desc = '战斗开始后会开启暮光之门，门外会增加所有人受到的伤害，同时进行攻击都会反弹一部分暗影伤害，需要进入暗影门后杀死里面的暮光信徒暗影门才会消失。',
},
{
expanded = false,
noCollapse = false,
title = '塔尼布隆技能',
desc = '战斗开始后会开启暮光之门，门内有正在孵化的龙蛋，数秒后会在门外孵化出来一些精英幼龙攻击目标，可进门摧毁龙蛋打断孵化。',
},
{
expanded = false,
noCollapse = false,
title = '沙德隆技能',
desc = '战斗开始后会开启暮光之门，沙德隆会得到一个buff，增加造成的伤害同时减少受到的伤害，进入暗影门后杀死里面的小怪这个BUFF就会消失。',
},
},
noCollapse = false,
title = '暮光幼龙独有技能',
expanded = true,
},
{
children = {
{
spell = '56908',
title = '烈焰吐息',
noCollapse = false,
expanded = false,
desc = '每隔一段时间对前方锥形范围内所有目标造成大量火焰伤害。',
},
{
spell = '57491',
title = '烈焰之啸',
noCollapse = false,
expanded = false,
desc = '进入战斗后每隔一段时间在场地随机一个方向召唤三股火墙，数秒后扫过战斗区域。被扫中的人会被击飞并附带一个造成持续性火焰伤害的DOT。',
},
{
spell = '60430',
title = '熔岩爆发',
noCollapse = false,
expanded = false,
desc = 'BOSS血量低于10%后会从两边的熔岩内不断召唤熔岩元素，被熔岩流碰到的元素会狂暴增加体型和攻击力。',
},
{
spell = '39363',
title = '流星火雨',
noCollapse = false,
expanded = false,
desc = '整个场地随机位置释放，对范围内的所有目标造成大量火焰伤害。',
},
{
spell = '74906',
title = '熔岩打击',
noCollapse = false,
expanded = false,
desc = '场地边上会有火焰旋风，随机对目标施放熔岩打击，造成火焰伤害，每波熔岩打击都会有几率召唤熔岩小怪加入战斗。小怪碰到火墙会被激怒，体型变大，增加血量和伤害等。',
},
},
noCollapse = false,
title = '萨塔里奥',
expanded = true,
},
},
desc = '黑曜石圣殿只有萨塔里奥一个BOSS，在面对他之前要先清理周围的小怪，还有他的三条暮光幼龙“维斯匹隆”、“塔尼布隆”和“沙德隆”。BOSS萨塔里奥战斗开始后会从两边的熔岩内不断召唤熔岩元素，每隔一段时间还会召唤熔岩墙扫过战斗区域，随机释放的火雨也是需要注意的。',
},
name = '萨塔里奥',
icon = '1385765',
summary = {
children = {
{
role = 'HEALER',
expanded = false,
desc = '1.    站在两道火墙出现的中间位置，便于躲避火墙。\n2.    躲避出现的火墙和火雨。\n3.    若保留了暮光幼龙，则需躲避脚下出现的暗影裂隙。另外需要有治疗跟随进暮光门的T，加好门内人的血。',
},
{
role = 'MELEE',
expanded = false,
desc = '1.    在BOSS侧面输出BOSS，注意躲避火墙和火雨。听从指挥击杀场地上出现的小怪。\n2.    若保留了暮光幼龙，塔尼布隆出现时，全力输出塔尼布隆，击杀塔尼布隆后优先清理场地上的小怪，然后再输出出现的沙德隆，在维斯匹隆出现后，优先进入它的传送门击杀信徒，之后再出门继续击杀沙德隆，等到信徒再一次出现时优先击杀。沙德隆被击杀后再输出维斯匹隆。所有人躲避脚下出现的暗影裂隙。',
},
{
role = 'RANGE',
expanded = false,
desc = '1.    在BOSS侧面输出BOSS，注意躲避火墙和火雨。听从指挥击杀场地上出现的小怪。\n2.    若保留了暮光幼龙，塔尼布隆出现时，全力输出塔尼布隆，击杀塔尼布隆后优先清理场地上的小怪，然后再输出出现的沙德隆，在维斯匹隆出现后，优先进入它的传送门击杀信徒，之后再出门继续击杀沙德隆，等到信徒再一次出现时优先击杀。沙德隆被击杀后再输出维斯匹隆。所有人躲避脚下出现的暗影裂隙。\n',
},
{
role = 'TANK',
expanded = false,
desc = '1.    萨塔里奥战斗基本为火焰伤害，需要T身上拥有一定量的火抗装备。\n2.    开怪后主T将BOSS拉至场地角落，使BOSS侧对大团。副T拉住场地上出现的小怪。\n3.    战斗过程中所有人注意躲避火墙和火雨。\n4.    若没有击杀幼龙，则还需要一名副T拉住出现的幼龙，在幼龙召唤了暮光门后需要一名副T进入门拉住门内的信徒。躲避脚下出现的暗影裂隙。',
},
},
desc = '黑曜石圣殿内的三个暮光幼龙可以选择性击杀，每保留一个幼龙副本难度会增加且BOSS多一件装备掉落。在BOSS战时BOSS会召唤未被击杀的暮光龙，且每条龙在场地上被击杀时都会导致BOSS攻击增加。BOSS战时需要大团在场地侧面输出，躲避出现的所有技能。',
},
},
}
local ENCOUNTER_INSTANCES = {
[533] = {
zones = {
{
zone = 1,
text = '蜘蛛区',
},
{
zone = 2,
text = '瘟疫区',
},
{
zone = 3,
text = '军事区',
},
{
zone = 4,
text = '构造区',
},
{
text = '冰龙区',
zone = 5,
},
},
bosses = {
ENCOUNTER_BOSSES[1107],
ENCOUNTER_BOSSES[1110],
ENCOUNTER_BOSSES[1116],
ENCOUNTER_BOSSES[1117],
ENCOUNTER_BOSSES[1112],
ENCOUNTER_BOSSES[1115],
ENCOUNTER_BOSSES[1113],
ENCOUNTER_BOSSES[1109],
ENCOUNTER_BOSSES[1121],
ENCOUNTER_BOSSES[1118],
ENCOUNTER_BOSSES[1111],
ENCOUNTER_BOSSES[1108],
ENCOUNTER_BOSSES[1120],
ENCOUNTER_BOSSES[1119],
ENCOUNTER_BOSSES[1114],
},
title = '纳克萨玛斯',
instanceId = 533,
},
[616] = {
zones = {
},
bosses = {
ENCOUNTER_BOSSES[734],
},
title = '永恒之眼',
instanceId = 616,
},
[615] = {
zones = {
},
bosses = {
ENCOUNTER_BOSSES[742],
},
title = '黑曜石圣殿',
instanceId = 615,
},
[624] = {
bosses = {
ENCOUNTER_BOSSES[772],
},
zones = {
},
title = '阿尔卡冯的宝库',
instanceId = 624,
},
}
local ENCOUNTER_DATA = {
ENCOUNTER_INSTANCES[533],
ENCOUNTER_INSTANCES[615],
ENCOUNTER_INSTANCES[616],
ENCOUNTER_INSTANCES[624],
}
ns.DEFAULT_ENCOUNTER_INSTANCE_ID = 624
ns.ENCOUNTER_BOSSES = ENCOUNTER_BOSSES
ns.ENCOUNTER_INSTANCES = ENCOUNTER_INSTANCES
ns.ENCOUNTER_DATA = ENCOUNTER_DATA

local QUEST_NAMES = {
    [1] = '关注|cff00ffff|Hqrcode:http://weixin.qq.com/q/02JtAwgez6cal10000M03f|h[暴雪游戏服务中心公众号]|h|r并绑定战网账号和手机号',
}

function ns.GetEncouterBossName(id)
    local data = ENCOUNTER_BOSSES[id]
    return data and data.name or UNKNOWN
end

function ns.GetEncounterRaidName(id)
    local data = ENCOUNTER_INSTANCES[id]
    return data and data.title or UNKNOWN
end

function ns.GetChallengeQuest(id)
    return QUEST_NAMES[id] or UNKNOWN
end
    