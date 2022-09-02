local ns = select(2, ...)
local ENCOUNTER_BOSSES = {
[710] = {
bossId = 710,
summary = {
children = {
{
role = 'TANK',
children = {
{
title = '亚尔基公主',
expanded = true,
desc = '1.看时机切换狂暴姿态，确保大部分时间不被恐惧，打断公主的强效治疗术。\n2.公主死后群嘲出现的小怪。',
},
{
title = '维姆',
expanded = true,
desc = '维姆冲锋会清除仇恨，2个坦克一个拉住，一个远离，确保仇恨在2个坦克身上。',
},
{
title = '克里勋爵',
expanded = true,
desc = '将勋爵拉至远离大团处，若优先击杀其他两个BOSS，则在其他两个BOSS死后迅速拉住勋爵，将其拉回原位。',
},
},
desc = '三个boss，需要4名坦克。优先击杀的BOSS拉离其他2个BOSS位置。',
},
{
desc = '1.分配跟随坦克的治疗优先驱散毒箭。\n2.矮人牧师优先给予公主坦克反恐，期间CD一好就加；萨满插好战栗图腾。\n3.击杀勋爵后迅速远离勋爵尸体。',
role = 'HEALER',
},
{
desc = '1.根据击杀顺序输出BOSS。\n2.若安排至公主处，优先打断公主强效治疗术。\n3.击杀勋爵后迅速远离勋爵尸体。',
role = 'MELEE',
},
{
desc = '1.根据击杀顺序输出BOSS。2.击杀公主后优先击杀公主召唤出的小怪。3.击杀勋爵后迅速远离勋爵尸体。',
role = 'RANGE',
},
},
desc = '三个boss，需要4名坦克。优先击杀的BOSS拉离其他2个BOSS位置。',
},
abilities = {
children = {
{
noCollapse = true,
title = '维姆',
children = {
{
desc = '击退当前目标。',
spell = 18670,
},
{
desc = '随机向一名玩家冲锋，并清除仇恨。',
spell = 22120,
},
},
},
{
noCollapse = true,
title = '克里勋爵',
children = {
{
desc = '释放群体毒箭，使40码范围内玩家中毒，每秒受到150自然伤害，可叠加。',
spell = 25812,
},
{
desc = '对当前目标造成3000左右伤害。',
spell = 27794,
},
{
desc = '勋爵死后尸体会释放毒云，站在毒云内每秒受到2000点自然伤害。',
spell = 24319,
},
{
desc = '维姆死后，勋爵会进入狂暴状态，攻击力和攻击速度提高。',
spell = 26068,
},
},
},
{
noCollapse = true,
title = '亚尔基公主',
children = {
{
desc = '恐惧30码内玩家并清空仇恨，持续8秒。',
spell = 26580,
},
{
desc = '对当前目标造成3000左右伤害。',
spell = 9869,
},
{
desc = '恢复目标25%生命值。',
spell = 25807,
},
{
title = '召唤小怪',
desc = '公主死后会在尸体上召唤8只亚尔基的子嗣，每只15000左右血量。',
},
{
desc = '维姆死后，公主会进入狂暴状态，攻击力和攻击速度提高。',
spell = 26068,
},
},
},
},
desc = '安其拉三宝有三个BOSS：克里勋爵、亚尔基公主、维姆，不同击杀顺序掉落也会不同。',
},
icon = 1390436,
name = '安其拉三宝',
},
[1571] = {
bossId = 1571,
name = '莫洛格里·踏潮者',
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '整场战斗需要两个坦克，战斗开始主坦将BOSS拉至角落，使BOSS背对大团，副坦注意拉住召唤出的鱼人，辅助法师和术士清理小怪。',
},
{
role = 'MELEE',
expanded = false,
desc = '1.全程输出BOSS。在被水之墓穴点名，困在水泡并受到爆炸和掉落伤害后确保自身血量安全再上来输出BOSS。\n2.进入第二阶段时远离水滴。',
},
{
role = 'RANGE',
expanded = false,
desc = '1.和其他远程站在一起，远距离输出BOSS，出现鱼人优先清理鱼人，避免治疗受到伤害。\n2.在被水之墓穴点名，困在水泡并受到爆炸和掉落伤害后确保自身血量安全再上来输出BOSS。\n3.进入第二阶段时远离水滴。',
},
{
role = 'HEALER',
expanded = false,
desc = '1.治疗好坦克和队友血量，地震后缓慢治疗，避免拉到鱼人仇恨。鱼人清除之后加大治疗。被分配至水泡处的治疗照顾好被点名玩家血量。\n2.萨满可以放地缚图腾减慢鱼人移动，圣骑士可以在地震时加大治疗，吸引鱼人仇恨，确保鱼人不分散。\n3.在被水之墓穴点名，困在水泡并受到爆炸和掉落伤害后确保自身血量安全再回到原位。\n4.进入第二阶段时远离水滴。',
},
},
desc = '莫洛格里·踏潮者本身只需坦克拉住即可，战斗期间召唤的鱼人需要队友协助消灭，优先击杀召唤的水滴直至BOSS倒下。',
},
icon = '1385756',
abilities = {
children = {
{
noCollapse = false,
spell = '38028',
expanded = false,
desc = '每隔30秒传送4个随机目标到4个固定的位置，将他们困在水泡中，6秒后水泡爆炸造成大量冰霜伤害，并将目标甩至空中，造成掉落伤害。',
},
{
noCollapse = false,
spell = '37764',
expanded = false,
desc = '每隔40秒在35码范围内制造地震，对其中的玩家造成大量伤害，地震期间会召唤2波鱼人，每波6个。',
},
{
spell = '37730',
expanded = false,
noCollapse = false,
children = {
},
desc = '对前方范围内目标造成大量冰霜伤害并降低攻击速度。',
},
{
noCollapse = false,
spell = '37854',
expanded = false,
desc = '当BOSS血量低于25%后，会停止水之墓穴，每隔一段时间从4个固定位置召唤水滴，水滴在触及目标后会爆炸，造成大量伤害。',
},
},
desc = '莫洛格里·踏潮者在战斗期间会不断地震并召唤鱼人，25%血量后还会召唤水滴，处理好小怪是整场战斗的重要内容。',
},
},
[607] = {
bossId = 607,
abilities = {
children = {
{
spell = '41001',
title = '致命吸引',
noCollapse = false,
expanded = false,
desc = '将随机3名目标传送到一个随机位置并将他们联结起来，被传送的目标会对附近范围内的玩家造成持续性的暗影伤害，互相离开足够距离时将打破致命吸引。',
},
{
spell = '40810',
title = '军刀猛刺',
noCollapse = false,
expanded = false,
desc = '对最多3名敌人造成大量物理伤害，伤害将由所有受到影响的目标平均分担。',
},
{
spell = '40823',
title = '扰乱尖啸',
noCollapse = false,
expanded = false,
desc = '打断范围内的所有敌人的施法并使其沉默。',
},
{
spell = '40827',
title = '光束',
expanded = true,
noCollapse = false,
children = {
{
spell = '40827',
title = '罪孽射线',
expanded = false,
noCollapse = false,
children = {
},
desc = '对目标造成大量暗影伤害。',
},
{
spell = '40859',
title = '邪恶射线',
noCollapse = false,
expanded = false,
desc = '对目标造成暗影伤害并击飞。',
},
{
spell = '40860',
title = '败德射线',
noCollapse = false,
expanded = false,
desc = '对目标造成持续性暗影伤害。',
},
{
spell = '40861',
title = '堕落射线',
noCollapse = false,
expanded = false,
desc = '抽取目标部分法力值。',
},
},
desc = '向随机一名敌人施放射线，射线造成影响后会跳转至附近的另外一名敌人，射线有如下四种：',
},
{
title = '光环',
expanded = true,
noCollapse = false,
children = {
},
desc = '切换自身光环，每一种光环都会降低一种法术类型的伤害，同时提高另一种对应法术类型的伤害。火焰对应冰霜，神圣对应暗影，自然对应奥术。',
},
},
desc = '莎赫拉丝主母释放伤害大部分为暗影伤害，因此需要准备一些暗抗来减少团队治疗压力，主母施放的技能会带有一点随机的情况，需要玩家随时应变出现的各项技能。 ',
},
name = '莎赫拉丝主母',
icon = '1379000',
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '主坦将BOSS背对大团，其余两个T和主坦重合站位，帮助分担军刀猛刺技能。',
},
{
role = 'MELEE',
expanded = false,
desc = '1.站在BOSS身后输出。\n2.中致命吸引被传送时，需要远离其余两名玩家，使得光线被拉断，然后再返回原位。注意在光线没有被拉断的时候不要靠近大团，以免大团受到伤害。\n',
},
{
role = 'RANGE',
expanded = false,
desc = '1.按照指挥分配站位输出，法师术士可以注意BOSS释放的光环，根据光环效果选择输出手段。\n2.中致命吸引被传送时，需要远离其余两名玩家，使得光线被拉断，然后再返回原位。注意在光线没有被拉断的时候不要靠近大团，以免大团受到伤害。\n',
},
{
role = 'HEALER',
expanded = false,
desc = '1.按照指挥分配站位，注意坦克血量，确保自身法力值。\n2.中致命吸引被传送时，需要远离其余两名玩家，使得光线被拉断，然后再返回原位。注意在光线没有被拉断的时候不要靠近大团，以免大团受到伤害。\n',
},
},
desc = '莎赫拉丝主母战斗期间会随机点名三名玩家施放致命吸引，玩家会被传送，且三人之间会有光线联结，需要分散跑开足够距离打破光线之后才能消除光线所带来的伤害。',
},
},
[1111] = {
bossId = 1111,
name = '格罗布鲁斯',
zone = 4,
abilities = {
children = {
{
desc = '对主T方向释放一个范围性喷射，造成大量自然伤害，并且每个被击中的玩家都将召唤出一个小软泥怪。',
spell = 28157,
},
{
desc = 'BOSS脚下出现一片毒云，不会移动，但会随时间缓慢扩散开来，直到直径20码之后缓慢消失。接触到毒云会每秒掉血。',
spell = 28240,
},
{
desc = '随机对一名玩家注射毒素，毒素为疾病，可驱散，持续10秒或者被驱散后会在该玩家脚下出现一片毒云。',
spell = 28169,
},
{
desc = '投掷一个小软泥轰炸地面，小软泥拥有软泥溅射（28137）对附近所有敌人造成伤害。',
spell = 28280,
},
{
title = '狂暴',
desc = '进入战斗12分钟后BOSS会狂暴。',
},
},
},
url = 'https://www.bilibili.com/video/BV1dr4y1w7gW?p=8',
icon = 1378981,
summary = {
children = {
{
desc = '主T开怪后将BOSS拉至墙边，一旦BOSS脚下生成毒云就沿着墙后退，确保不会接触到毒云。',
role = 'TANK',
},
{
desc = '1.在场地中间集中站位，按照分配治疗T或者DPS，最远距离治疗。\n2.若被注射毒素（变异注射），速度跑到最后的毒云边上，等待解除疾病。\n3.指定解疾病的治疗随时注意被注射玩家，一旦位置站好立即驱散该玩家疾病。',
role = 'HEALER',
},
{
desc = '1.主T拉住后，站在主T的侧后方，面对着墙面攻击BOSS。\n2.不要站在主T前面，预防被BOSS喷射到。\n3.若被注射毒素（毒性注射），速度跑到最后的毒云边上，等待治疗解除疾病。\n4.出现小软泥怪优先击杀。\n注意：全程战斗注意毒云位置，边打边走，不要接触到毒云。',
role = 'MELEE',
},
{
desc = '1.在场地中间集中站位，最远距离输出BOSS。\n2.若被注射毒素（变异注射），速度跑到最后的毒云边上，等待治疗解除疾病。\n3.优先输出BOSS。',
role = 'RANGE',
},
},
},
},
[655] = {
bossId = 655,
summary = {
children = {
{
children = {
{
title = 'P1阶段',
desc = '主T将朱丽叶拉至到房间右边，注意打断朱丽叶技能。',
},
{
title = 'P2阶段',
desc = '罗密欧出现时主T将其拉至房间左边，使BOSS背靠墙壁，避免近战被击飞太远。',
},
{
title = 'P3阶段',
desc = '主副T在BOSS起来前就需要站在BOSS倒下的位置，BOSS起来后第一时间拉住仇恨。',
},
},
role = 'TANK',
},
{
desc = '注意坦克血量，德鲁伊和圣骑士第一时间驱散毒。',
role = 'HEALER',
},
{
children = {
{
title = 'P1阶段',
desc = '全力输出 ，打断朱丽叶技能，尤其是加血技能。',
},
{
title = 'P2阶段',
desc = '背靠墙壁输出罗密欧。',
},
{
title = 'P3阶段',
desc = '按照指挥分配输出朱丽叶或者罗密欧，仍旧要注意打断朱丽叶技能。注意2个BOSS血量，需要同时击杀两个BOSS。',
},
},
role = 'MELEE',
},
{
children = {
{
title = 'P1阶段',
desc = '全力输出 ，注意偷取或者驱散朱丽叶buff。术士可以召唤地狱犬去吞噬BOSS的buff。',
},
{
title = 'P2阶段',
desc = '全力输出罗密欧，注意偷取或者驱散罗密欧buff。',
},
{
title = 'P3阶段',
desc = '按照指挥分配输出朱丽叶或者罗密欧，仍旧要注意偷取或者驱散朱丽叶和罗密欧的buff。注意2个BOSS血量，需要同时击杀两个BOSS。',
},
},
role = 'RANGE',
},
},
desc = '歌剧院有三种BOSS组合，分别为绿野仙踪、小红帽、罗密欧和朱丽叶，每次随机选择一组。罗密欧和朱丽叶开场时只有朱丽叶在场，击杀之后罗密欧会出现，击杀了罗密欧两个BOSS会一起复活，需要同时击杀两个BOSS才能结束战斗。',
},
abilities = {
children = {
{
noCollapse = true,
title = '朱丽叶',
children = {
{
desc = '对一名玩家造成神圣伤害，并且附带持续性伤害效果。',
spell = 30890,
},
{
desc = '提高施法者伤害及攻击速度。',
spell = 30887,
},
{
desc = '使目标陷入昏迷，持续6秒。',
spell = 30889,
},
{
desc = '治疗盟友，可打断。',
spell = 30878,
},
},
},
{
noCollapse = true,
title = '罗密欧',
children = {
{
desc = '攻击BOSS身后一名玩家，造成物理伤害并击飞。',
spell = 30815,
},
{
desc = '对玩家造成武器伤害，并使目标属性降低，持续1分钟。',
spell = 30822,
},
{
desc = '提高施法者物理伤害和攻击速度。',
spell = 30841,
},
{
desc = '对BOSS前方范围敌人造成武器伤害。',
spell = 30817,
},
},
},
},
desc = '歌剧院有三种BOSS组合，分别为绿野仙踪、小红帽、罗密欧和朱丽叶，每次随机选择一组。\n罗密欧与朱丽叶整场战斗分为三个阶段，P1只有朱丽叶，P2只有罗密欧，P3同时存在朱丽叶和罗密欧，需要同时击杀才能结束战斗。',
},
icon = 1385758,
name = '歌剧院之罗密欧与朱丽叶',
},
[1572] = {
bossId = 1572,
summary = {
children = {
{
role = 'MELEE',
expanded = false,
desc = 'P1：输出BOSS，仇恨不要超过副T，中了静电充能远离其他玩家。\nP2：根据指挥分配站位，输出楼梯处刷新的元素怪，优先击杀腐化元素，击杀后拾取腐化核心，在包裹里面点击腐化核心扔给台子上的指定玩家。\nP3：优先清理完场地上的所有小怪，然后全力输出BOSS，仇恨不要超过副T，中了静电充能远离其他玩家。',
},
{
role = 'RANGE',
expanded = false,
desc = 'P1：输出BOSS，仇恨不要超过副T，中了静电充能远离其他玩家。\nP2：根据指挥分配站位，输出楼梯处刷新的元素怪或者是台子上的精英怪，楼梯处需要优先击杀腐化元素，击杀后拾取腐化核心，在包裹里面点击腐化核心扔给台子上的指定玩家，接到的继续将腐化核心扔给护盾生成器边上的玩家。台子上的需要有远程风筝盘牙巡逻者。\nP3：优先清理完场地上的所有小怪，然后全力输出BOSS，仇恨不要超过副T，中了静电充能远离其他玩家。',
},
{
role = 'HEALER',
expanded = false,
desc = 'P1：注意全团血量，尤其是T和中了静电充能的玩家。\nP2：根据指挥分配站位，治疗好范围内的输出和T，在DPS把腐化核心扔过来时打开包裹点击，扔给护盾生成器边上的玩家。\nP3：注意全团血量，尤其是T和中了静电充能的玩家。',
},
{
role = 'TANK',
expanded = false,
desc = 'P1：主T将瓦丝琪拉在台子中间，BOSS释放缠绕后，主T需要迅速脱离缠绕状态拉住BOSS，副T保持第二仇恨，在主T被震爆昏迷后拉住BOSS。\nP2：坦克需要拉住台子上的精英怪。\nP3：同P1阶段。坦克脚下出现毒性孢子污染时立即将瓦丝琪拉开。',
},
},
desc = '瓦丝琪整场战斗分为3个阶段，P1阶段需要坦克在BOSS缠绕后及时拉住BOSS，治疗加大对坦克的治疗，远离中了静电充能的玩家。P2阶段瓦丝琪处于无敌状态，台子上会每隔一段时间会刷新出盘牙精英需要尽快击杀，期间出现的盘牙巡逻者会不停释放恐惧，需要风筝。P2楼梯上会刷新魔化元素，需要根据指挥的分配，四组玩家分别于四个区域击杀缓慢靠近BOSS的元素怪，期间楼梯上还会刷新腐化元素，击杀后掉落腐化核心，扔给护盾生成器附近的玩家，每使用腐化核心关闭一个护盾生成器即可减少BOSS5%的血量。关闭4个后进入P3阶段，BOSS重新激活，继续P1阶段的所有技能，P3还会出现孢子蝙蝠，对地面喷射毒性孢子造成地面污染，所有人必须及时躲开污染区域。',
},
name = '瓦丝琪',
icon = '1385750',
abilities = {
children = {
{
spell = '38310',
title = '多重射击（P1、P3）',
children = {
},
noCollapse = false,
expanded = false,
desc = '对最多5个目标造成大量物理伤害。',
},
{
spell = '38280',
title = '静电充能（P1、P3）',
noCollapse = false,
expanded = false,
desc = '随机充能一个目标，对目标和目标临近的玩家造成持续性的自然伤害。',
},
{
spell = '38316',
title = '纠缠（P1、P3）',
noCollapse = false,
expanded = false,
desc = '纠缠周围所有目标，每2秒造成一次自然伤害，并使目标无法移动，持续10秒。',
},
{
spell = '38509',
title = '震爆（P1、P3）',
noCollapse = false,
expanded = false,
desc = '对当前目标射出闪电箭，造成大量伤害并陷入昏迷，瓦丝琪会攻击第二仇恨。',
},
{
spell = '22945',
title = '叉状闪电（P2）',
children = {
},
noCollapse = false,
expanded = false,
desc = '对瓦丝琪身前锥形范围内所有目标造成大量自然伤害。',
},
{
spell = '35004',
title = '毒性孢子（P3）',
noCollapse = false,
expanded = false,
desc = '第三阶段出现孢子蝙蝠，会对地面喷射毒性孢子造成地面污染，对站在污染区域的玩家造成大量伤害。',
},
},
desc = '毒蛇神殿最后BOSS是瓦丝琪，整场战斗分为3个阶段，P1注意躲避中了静电充能的玩家，坦克拉住瓦丝琪即可平稳度过，BOSS血量达到70%时会进入P2，P2阶段BOSS处于无敌状态，需要击杀腐化元素拾取腐化核心关闭护盾生成器。一共四个护盾生成器，每关闭一个会减少BOSS5%的血量，期间还需要击杀刷新出的各种精英怪。BOSS血量达到50%时进入P3阶段，瓦丝琪会重复P1阶段的技能，并且P3时场地上还会掉落毒性孢子，掉落速度会不断加快，需要全力输出击杀瓦丝琪。',
},
},
[1112] = {
bossId = 1112,
name = '肮脏的希尔盖',
zone = 2,
abilities = {
children = {
{
noCollapse = true,
title = 'P1阶段',
children = {
{
title = '疾病',
desc = '对10码范围内近战释放疾病，疾病会降低血量上限的50%，并每3秒造成500伤害。',
},
{
title = '法力燃烧',
desc = '对30码范围释放，吸收大量法力，并造成等量伤害。',
},
{
title = '熔岩喷射',
desc = '每隔10秒地面以固定规律喷射熔岩，造成每下4000左右自然伤害。',
},
{
title = '传送',
desc = '每隔一段时间随机传送3名玩家至隔壁通道。\n通道通道内存在眼球触须和蛆虫，BOSS进入P2时，通道会出现毒云，每3秒造成4000左右伤害。',
},
{
title = '通道',
children = {
{
title = '眼球触须',
desc = '会释放精神鞭笞，每秒造成750伤害，杀死后半分钟刷新。',
},
{
title = '蛆虫',
desc = '移动速度慢，可脱离战斗。',
},
},
desc = '通道内存在眼球触须和蛆虫，BOSS进入P2时，通道会出现毒云，每3秒造成4000左右伤害。',
},
},
},
{
children = {
{
title = '疾病',
desc = '给周围10码左右的玩家一个Debuff，每5秒造成4000伤害。',
},
{
title = '疾病',
desc = '地面以固定规律喷射熔岩，造成每下4000左右自然伤害，P2阶段喷射时间间隔变短。',
},
},
noCollapse = true,
title = 'P2阶段',
desc = '进入战斗90秒后，BOSS回到平台，释放疾病之云。',
},
},
},
url = 'https://www.bilibili.com/video/BV1dr4y1w7gW?p=5',
icon = 1378984,
summary = {
children = {
{
desc = 'BOSS所站台子为扇柄，台子以下区域为扇叶，将扇叶均分为4块区域（从门口至里面分别编号为1-2-3-4号）。\nP1阶段：主T开战后将BOSS拉至门口1号区域，等待其他区域熔岩喷射后移动至2号区域，再下一次熔岩喷射后移动到3号，再下一次为4号，然后还是在熔岩喷射后回到3号位置，再是2号、1号、2号、3号。（总体跑动区域顺序为1-2-3-4-3-2-1-2-3）\nP2阶段：不需要拉BOSS，回到1区域站定，仍旧按照1-2-3-4-3-2-1-2-3的顺序在4个区域内跑动躲开熔岩喷射，直到P2阶段结束。\nP2结束重新进入P1阶段，开始循环。\n注意：2阶段熔岩喷射速度会加快，集中精神注意跑动。',
role = 'TANK',
},
{
desc = 'BOSS所站台子为扇柄，台子以下区域为扇叶，将扇叶均分为4块区域（从门口至里面分别编号为1-2-3-4号）。\nP1阶段：站在台子上最远距离治疗，优先驱散T和近战的疾病。被随机传送进隔壁通道时，靠右边墙，边走边击杀触须，朝通道远处的出口跑出去即可。（无需击杀小虫子）\nP2阶段：到门口的1区域站定，跟随主T，按照1-2-3-4-3-2-1-2-3的顺序在4个区域内跑动躲开熔岩喷射。直到P2阶段结束。\nP2结束重新进入P1阶段，开始循环。',
role = 'HEALER',
},
{
desc = 'BOSS所站台子为扇柄，台子以下区域为扇叶，将扇叶均分为4块区域（从门口至里面分别编号为1-2-3-4号）。\nP1阶段：跟随主T按照1-2-3-4-3-2-1-2-3的顺序在4个区域内跑动躲开熔岩喷射。 跑动期间输出。被随机传送进隔壁通道时，靠右边墙，边走边击杀触须，朝通道远处的出口跑出去即可。（无需击杀小虫子）\nP2阶段：到门口的1区域站定，跟随主T，按照1-2-3-4-3-2-1-2-3的顺序在4个区域内跑动躲开熔岩喷射。直到P2阶段结束。\nP2结束重新进入P1阶段，开始循环。',
role = 'MELEE',
},
{
desc = 'BOSS所站台子为扇柄，台子以下区域为扇叶，将扇叶均分为4块区域（从门口至里面分别编号为1-2-3-4号）。\nP1阶段：站在台子上最远距离输出。被随机传送进隔壁通道时，靠右边墙，边走边击杀触须，朝通道远处的出口跑出去即可。（无需击杀小虫子）\nP2阶段：到门口的1区域站定，跟随主T，按照1-2-3-4-3-2-1-2-3的顺序在4个区域内跑动躲开熔岩喷射。直到P2阶段结束。\nP2结束重新进入P1阶段，开始循环。',
role = 'RANGE',
},
},
},
},
[711] = {
bossId = 711,
abilities = {
children = {
{
title = '精英小怪',
desc = 'BOSS身边带有3个守卫，守卫也会释放旋风斩。',
},
{
desc = '对范围10码内玩家造成3000左右伤害，无法打断，旋风斩后清空仇恨。',
spell = 26084,
},
{
desc = '造成2000左右伤害，降低护甲效果。',
spell = 25174,
},
{
desc = 'BOSS血量降至20%进入狂怒状态，攻击力和攻击速度增加。',
spell = 19953,
},
{
desc = '若在10分钟内将BOSS血量降到30%以下，那么在BOSS生命值为20%的时候将会触发狂暴，攻击力增强；若没有在10分钟内将BOSS血量降到30%以下，则BOSS会在20%血量时触发超级狂暴，攻击力是普通狂暴10倍以上。',
spell = 23537,
},
},
},
name = '沙尔图拉',
summary = {
children = {
{
desc = '1.3个副T分别拉住守卫，优先击杀，击杀后辅助主T拉住BOSS仇恨。\n2.主T在BOSS旋风斩后，迅速拉住仇恨。\n3.使用震荡猛击等技能眩晕BOSS。',
role = 'TANK',
},
{
desc = '1.进入战斗后分散站位，远距离治疗。\n2.成为守卫或BOSS目标时往没人的地方跑，目标改变后继续远距离治疗。',
role = 'HEALER',
},
{
desc = '1.先击杀守卫，再杀BOSS。\n2.优先使用技能眩晕守卫，释放旋风斩时分散躲开。',
role = 'MELEE',
},
{
desc = '1.进入战斗后分散站位，最远距离输出，\n2.先击杀守卫，再杀BOSS。\n3.成为守卫或BOSS目标时往没人的地方跑，目标改变后继续最远距离输出。',
role = 'RANGE',
},
},
},
icon = 1385720,
desc = '沙尔图拉的战斗是一场运动战，需要躲开BOSS和小怪的旋风斩技能。',
},
[1573] = {
bossId = 1573,
name = '奥',
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = 'P1：将二楼四个平台按顺序标注为1234号平台，根据指挥分配四个T分别站在四个平台上，奥过来时及时拉住，奥飞到空中时，所有坦克跳下平台返回一楼，1号和4号平台的坦克站在楼梯边上，奥下来时第一时间冲锋上前拉住BOSS，避免奥释放全屏烈焰打击。小凤凰出现时，还需要两个T拉至场地角落等待DPS击杀。\nP2：奥会在一楼重生，若主T受到了熔化护甲，被降低了护甲值，副T需要立即嘲讽，接替主T；当T中了火焰碎片时，需立即拉BOSS离开火焰碎片位置，奥冲锋或者是从空中下来时，T需要立即跟随过去，确保第一时间进入BOSS近战范围内。BOSS飞到空中释放流星时集合分担伤害，其余T需要注意流星后召唤出的小凤凰，拉至角落等待dps击杀。',
},
{
role = 'MELEE',
expanded = false,
desc = 'P1：缓慢输出BOSS，出现小凤凰后击杀，小凤凰即将死亡时赶紧远离避开爆炸。BOSS飞天期间需要跳下平台躲避技能。\nP2：输出BOSS，BOSS飞到空中释放流星时集合分担伤害，出现小凤凰后优先击杀，注意躲开火焰碎片及小凤凰的爆炸。',
},
{
role = 'RANGE',
expanded = false,
desc = 'P1：一楼输出平台上的BOSS。\nP2：输出BOSS，BOSS飞到空中释放流星时集合分担伤害，注意躲开火焰碎片及小凤凰的爆炸。',
},
{
role = 'HEALER',
expanded = false,
desc = 'P1：根据指挥安排治疗好负责的T。注意拉住小凤凰的T和输出的近战的血量。\nP2：治疗主副T和全团，注意躲开火焰碎片及小凤凰的爆炸',
},
},
desc = '奥的战斗开始后，P1阶段需要4个坦克在二楼4个平台站好，当奥更换平台的时候拉住BOSS。期间奥会飞到空中释放火之羽，此时需要所有玩家跳下平台呆在一楼，等奥下来T需要第一时间拉住。重生进入P2阶段后，所有玩家呆在一楼大厅，需要2个坦克拉住奥，其他坦克拉好中途出现的小凤凰。整场战斗中，每击杀一只小凤凰，奥就会损失3%生命值。',
},
icon = '1385712',
abilities = {
children = {
{
title = 'P1技能',
noCollapse = true,
expanded = false,
children = {
{
noCollapse = false,
spell = '34121',
expanded = false,
desc = '奥下地时若近战范围内没有玩家，会每1.5秒释放一次烈焰打击，对所有玩家造成大量火焰伤害并叠加一个火焰易伤debuff。',
},
{
noCollapse = false,
spell = '34229',
expanded = false,
desc = '对上层平台所有玩家造成大量火焰伤害。',
},
{
noCollapse = false,
spell = '25104',
expanded = false,
desc = '召唤精英小凤凰，小凤凰死后会爆炸造成大量伤害并附带击飞效果。',
},
},
},
{
title = 'P2技能',
noCollapse = true,
expanded = false,
children = {
{
noCollapse = false,
spell = '34342',
expanded = false,
desc = '从灰烬中重生，对范围内所有玩家造成火焰伤害并击退。',
},
{
spell = '26558',
expanded = false,
noCollapse = false,
children = {
},
desc = 'P2阶段奥每30秒飞到空中，朝随机目标释放流星，造成大量伤害，并召唤出两个精英小凤凰。',
},
{
spell = '26558',
title = '火焰碎片',
children = {
},
noCollapse = false,
expanded = false,
desc = '每30秒对随机玩家召唤火焰碎片，碎片会造成大量火焰伤害，并叠加一个受到火焰伤害提高10%的debuff。',
},
{
noCollapse = false,
spell = '24408',
expanded = false,
desc = '每30秒对随机玩家冲锋。',
},
{
noCollapse = false,
spell = '35410',
expanded = false,
desc = '每60秒对当前目标释放，使其护甲值降低80%。',
},
},
},
},
desc = '风暴要塞一号BOSS是奥，BOSS整场战斗分为两个阶段，战斗开始奥会在场地二楼的平台上移动，血量降至0后，奥会传送到房间中央重生进入P2阶段，在P2阶段击杀奥之后战斗结束。',
},
},
[608] = {
bossId = 608,
abilities = {
children = {
{
expanded = false,
noCollapse = false,
children = {
{
title = '祝福',
expanded = true,
noCollapse = false,
children = {
{
spell = '41451',
title = '法术结界祝福',
noCollapse = false,
expanded = false,
desc = '使目标对所有法术攻击免疫，持续数秒。',
},
{
spell = '41450',
title = '保护祝福',
noCollapse = false,
expanded = false,
desc = '使目标对所有物理攻击免疫，持续数秒。',
},
},
desc = '随机给除自己以外的其他三名议会成员施加一种祝福。同一时间场上只会存在一种祝福。',
},
{
title = '审判',
expanded = true,
noCollapse = false,
children = {
{
spell = '41461',
title = '鲜血审判',
noCollapse = false,
expanded = false,
desc = '对当前目标造成持续性的神圣伤害。',
},
{
spell = '41470',
title = '命令审判',
noCollapse = false,
expanded = false,
desc = '对当前目标造成大量神圣伤害。',
},
},
desc = '根据激活的圣印来施放审判，圣印会使每次攻击附带额外的神圣伤害，同一时间场上只会存在一种圣印。',
},
{
title = '光环',
expanded = true,
noCollapse = false,
children = {
{
spell = '41453',
title = '抗性光环',
noCollapse = false,
expanded = false,
desc = '增加全法术抗性。',
},
{
spell = '41452',
title = '虔诚光环',
noCollapse = false,
expanded = false,
desc = '增加额外的护甲值。',
},
},
desc = '使除自己以外的其他三名议会成员获得光环效果，同一时间场上只会存在一种光环。',
},
{
spell = '41541',
title = '奉献',
noCollapse = false,
expanded = false,
desc = '对范围内的的所有敌人造成大量神圣伤害，持续一段时间。',
},
{
spell = '41468',
title = '制裁之锤',
noCollapse = false,
expanded = false,
desc = '随机使一个目标陷入昏迷，无法移动或者攻击，持续一段时间。',
},
},
title = '击碎者加西奥斯技能（骑士）',
},
{
expanded = false,
noCollapse = false,
children = {
{
spell = '41476',
title = '消失',
noCollapse = false,
expanded = false,
desc = '进入潜行状态，出现时会给目标施放毒伤和致命药膏，连续5次，每次目标随机。',
},
{
spell = '41487',
title = '毒伤',
noCollapse = false,
expanded = false,
desc = '对一名敌人造成自然伤害。',
},
{
spell = '41485',
title = '致命药膏',
noCollapse = false,
expanded = false,
desc = '使一名目标中毒，在一段时间内造成持续性伤害。',
},
},
title = '维尔莱斯·深影技能（潜行者）',
},
{
expanded = false,
noCollapse = false,
children = {
{
spell = '41483',
title = '奥术箭',
noCollapse = false,
expanded = false,
desc = '对当前目标造成大量奥术伤害。',
},
{
spell = '41481',
title = '烈焰风暴',
noCollapse = false,
expanded = false,
desc = '灼烧随机区域内的所有敌人，在持续时间内造成火焰伤害。',
},
{
spell = '41482',
title = '暴风雪',
noCollapse = false,
expanded = false,
desc = '对随机区域内的所有敌人施放暴风雪，在持续时间内造成冰霜伤害。',
},
{
spell = '41478',
title = '抑制魔法',
noCollapse = false,
expanded = false,
desc = '对自身施放，降低受到的法术伤害和治疗效果，可偷取。',
},
{
spell = '41524',
title = '魔爆术',
noCollapse = false,
expanded = false,
desc = '若有人靠近，则对近战范围内的敌人造成奥术伤害。',
},
},
title = '高阶灵术师塞勒沃尔技能（法师）',
},
{
expanded = false,
noCollapse = false,
children = {
{
spell = '41455',
title = '治疗之环',
noCollapse = false,
expanded = false,
desc = '恢复所有议会成员一定量的生命值，可打断。',
},
{
spell = '41475',
title = '反射之盾',
noCollapse = false,
expanded = false,
desc = '给自身生成护盾，吸收伤害并对攻击者反射相当于吸收伤害的一半数值的伤害。',
},
{
spell = '41471',
title = '强力惩击',
noCollapse = false,
expanded = false,
desc = '对当前目标造成大量神圣伤害，可打断。',
},
{
spell = '41472',
title = '神圣愤怒',
noCollapse = false,
expanded = false,
desc = '对随机目标造成大量神圣伤害，后续还会额外造成持续性的伤害，可打断。',
},
},
title = '女公爵玛兰德技能（牧师）',
},
},
desc = '伊利达雷议会是一个议会型BOSS，由4个血精灵组成，分别是维尔莱斯·深影，女公爵玛兰德，击碎者加西奥斯，和高阶灵术师塞勒沃尔，他们之间共享生命值，并会用各自标志性的技能攻击敌人。',
},
name = '伊利达雷议会',
icon = '1385743',
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '1.由法师开场，法师坦需要偷取高阶灵术师塞勒沃尔的魔法抑制，然后远程攻击拉住高阶灵术师塞勒沃尔。\n2.按照指挥分配三个坦克分别拉住维尔莱斯·深影，女公爵玛兰德和击碎者加西奥斯，三者之间需要远离，且在遭受暴风雪或者是烈焰风暴时及时拉离技能范围。\n3.拉击碎者加西奥斯的坦克需要将BOSS拉离其他BOSS，随时注意BOSS脚下，拉开奉献范围。\n4.拉住维尔莱斯·深影的坦克需要在BOSS消失又出现的第一时间及时建立仇恨。\n5.拉住女公爵玛兰德的坦克将BOSS拉在台子上即可。\n',
},
{
role = 'MELEE',
expanded = false,
desc = '输出击碎者加西奥斯，远离奉献、烈焰风暴、暴风雪等群攻范围。\n指挥选定打断的近战需要输出女公爵玛兰德，注意打断女公爵的治疗之环、神圣愤怒等技能。\n',
},
{
role = 'RANGE',
expanded = false,
desc = '远距离输出击碎者加西奥斯，远离烈焰风暴、暴风雪等群攻范围。\n指挥选定打断的远程需要注意打断女公爵的治疗之环、神圣愤怒等技能。\n',
},
{
role = 'HEALER',
expanded = false,
desc = '按照指挥分配加好4个坦克。\n注意维尔莱斯·深影出现时选定的目标，以及中了范围伤害的玩家的的生命值。\n远离烈焰风暴、暴风雪等群攻范围。\n',
},
},
desc = '伊利达雷议战斗需要分别坦住四个BOSS，并且使用拉开距离、打断等手段来减少四个BOSS之间的技能加持。战斗期间还需要躲开BOSS的群攻技能范围，减少治疗压力。四个BOSS生命值共享，输出一个BOSS即可。',
},
},
[1113] = {
bossId = 1113,
name = '教官拉苏维奥斯',
zone = 3,
abilities = {
children = {
{
title = '瓦解怒吼',
desc = '凶猛的尖叫，吸取附近玩家的蓝量，全部转化成伤害。',
},
{
desc = '对当前目标释放，造成大量物理伤害并使其防御值降低，持续6秒。',
spell = 26613,
},
},
desc = '教官拉苏维奥斯物理攻击非常强力，玩家无法坦克，需要牧师控制BOSS边上的学员（学员拥有盾墙和嘲讽技能），让学员开盾墙去坦BOSS。',
},
url = 'https://www.bilibili.com/video/BV1dr4y1w7gW?p=11',
icon = 1378988,
summary = {
children = {
{
desc = '1名牧师心灵控制学员开怪，使用学员的嘲讽技能将坦克拉至楼梯口位置。\n3名T将其余3个学员拉至楼梯上方，方便牧师控制，学员脱离控制后拉回楼梯上方。',
role = 'TANK',
},
{
desc = '1.集中站在BOSS边上的楼梯扶手内，卡视野位置加好学员和拉学员的T的血量，躲避BOSS瓦解怒吼技能。\n2.心灵控制牧师控制一个学员，使用学员的嘲讽技能开怪，开启学员的盾墙技能后将BOSS拉至楼梯口。学员盾墙快结束时，放弃控制，另一个牧师控制另外的学员使用盾墙和嘲讽技能顶上，两个牧师轮流直至BOSS倒下。',
role = 'HEALER',
},
{
desc = '等学员拉住BOSS后输出即可。',
role = 'MELEE',
},
{
desc = '1.集中站在离BOSS较远距离的楼梯扶手处，进入战斗后输出BOSS。\n2.听指挥躲进扶手后，卡视野躲避BOSS瓦解怒吼技能。',
role = 'RANGE',
},
},
},
},
[656] = {
bossId = 656,
summary = {
children = {
{
desc = '主T将BOSS拉在角落，副T在BOSS边上，确保自己为第二仇恨。P2时副T也需要全力DPS。',
role = 'TANK',
},
{
desc = '分散站位，确保T和近战的血量。P2有蓝的治疗可以适当输出BOSS。',
role = 'HEALER',
},
{
children = {
{
title = 'P1阶段',
desc = '优先击杀闪电球，不要过于靠近远程和治疗队伍。',
},
{
title = 'P2阶段',
desc = '全力输出BOSS。',
},
},
role = 'MELEE',
},
{
children = {
{
title = 'P1阶段',
desc = '分散站位，优先击杀闪电球。',
},
{
title = 'P2阶段',
desc = '全力输出BOSS。',
},
},
role = 'RANGE',
},
},
desc = '馆长拥有高血量和强大的物理攻击，并且免疫奥系法术。战斗开始馆长身上会有减伤的BUFF，期间会消耗法力值召唤闪电球，在法力值消耗完毕之后就会停止攻击进入唤醒状态，在此状态下攻击BOSS会获得伤害加成，在法力值全满之后又进入P1阶段，如此循环直至BOSS倒下。',
},
abilities = {
children = {
{
desc = '对近战攻击命中的玩家造成额外的奥术伤害。',
spell = 30403,
},
{
desc = '对第二仇恨玩家造成大量奥术伤害。',
spell = 30383,
},
{
desc = '消耗自身法力值召唤闪电球，闪电球会释放闪电链，对目标造成奥术伤害，并弹跳至其他玩家身上造成伤害。',
spell = 30235,
},
{
desc = '法力值消耗完毕后进入唤醒回复法力值阶段，回复期间受到伤害提高200%。',
spell = 30254,
},
{
desc = 'BOSS血量降低至15%左右会进入激怒状态，伤害和攻击速度提高。',
spell = 8599,
},
},
desc = '馆长的战斗基本分为两阶段，P1馆长身上会有减伤的buff，因此DPS们需要优先击杀馆长放出的闪电球。馆长蓝量消耗完之后会进入P2开始唤醒，唤醒期间会有易伤，此时需要全力输出，唤醒结束继续回到P1阶段，如此循环直至BOSS倒下。12分钟后战斗未结束馆长会秒杀所有玩家。',
},
icon = 1379020,
name = '馆长',
},
[1574] = {
bossId = 1574,
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '战斗开始四个T站在BOSS周围，根据指挥分配做好仇恨循环，当主T被击退后，二T赶紧接上仇恨，随后二T被击退失去仇恨之后三T接上，三T被击退失去仇恨之后四T接上，然后是主T准备，如此循环直至BOSS倒下。期间保持命令怒吼和搓志怒吼，处于重击范围下确保有足够的怒气衔接仇恨。',
},
{
role = 'MELEE',
expanded = false,
desc = '战斗开始输出BOSS，在BOSS释放重击前远离BOSS，技能释放结束后返回继续输出。注意自身血量恢复后再返回。',
},
{
role = 'RANGE',
expanded = false,
desc = '战斗开始根据指挥分配跟自身的治疗站在一侧输出BOSS，若BOSS目标是自己或者附近玩家释放奥术宝珠时，赶紧走开，宝珠落地爆炸后返回原位。猎人的宝宝需要注意BOSS的重击技能，否则很容易死亡。',
},
{
role = 'HEALER',
expanded = false,
desc = '战斗开始根据指挥分配治疗T或者DPS，若BOSS目标是自己或者附近玩家释放奥术宝珠时，赶紧走开，宝珠落地爆炸后返回原位。注意保持全团血量以保证他们在下一次攻击时存活。坦克切换时注意当前T的血量。',
},
},
desc = '空灵机甲整场战斗需要4个坦克分散在BOSS周围循环拉住BOSS仇恨，远程DPS和治疗远离BOSS，分方位站定输出或治疗直至BOSS倒下。期间需要躲避BOSS释放的奥术宝珠。',
},
name = '空灵机甲',
icon = '1385772',
abilities = {
children = {
{
spell = '34172',
noCollapse = false,
expanded = false,
desc = '随机目标释放奥术宝珠，宝珠落地后对目标区域中所有玩家造成大量伤害并沉默6秒。',
},
{
spell = '25778',
noCollapse = false,
expanded = false,
desc = '击退当前目标并减少仇恨值。',
},
{
spell = '34162',
noCollapse = false,
expanded = false,
desc = '重击地面，对周围所有玩家造成大量伤害。',
},
},
desc = '空灵机甲是一个需要坦克建立仇恨链的BOSS，空灵机甲会在战斗开始10分钟后激怒，需要考验团队的整体DPS。',
},
},
[1114] = {
bossId = 1114,
name = '克尔苏加德',
zone = 5,
abilities = {
children = {
{
title = 'P1',
children = {
{
title = '骷髅',
expanded = true,
desc = '靠近人群会自爆释放暗影冲击，造成大量暗影伤害。',
},
{
title = '女妖',
expanded = true,
desc = '靠近目标会造成大量暗影伤害，且具有击退效果。',
},
{
title = '憎恶',
expanded = true,
desc = '对近战释放仇恨打击，对目标释放重伤，降低10%治疗效果，可叠加。',
},
},
desc = 'P1不断召唤3种小怪',
},
{
title = 'P2',
children = {
{
title = '单体寒冰箭',
expanded = true,
desc = '对当前目标释放，造成大量冰霜伤害且减速，可打断。',
},
{
title = '群体寒冰箭',
expanded = true,
desc = '对所有玩家释放，造成大量冰霜伤害。',
},
{
spell = 27810,
expanded = true,
desc = '随机在一名玩家脚下释放，5秒后对还在范围内玩家造成大量暗影伤害。',
},
{
spell = 27808,
expanded = true,
desc = '对随机玩家释放，使目标冻结进入昏迷状态，每秒造成大量冰霜伤害。',
},
{
spell = 27819,
expanded = true,
desc = '对随机一名有法力值的玩家释放，吸取该玩家部分法力值，且对周围玩家造成伤害。',
},
{
spell = 28410,
expanded = true,
desc = '随机控制五名玩家，被控制玩家体型变大，伤害和治疗能力增加。',
},
},
desc = 'P2开始输出BOSS，克尔苏加德技能如下',
},
{
title = 'P3',
children = {
{
spell = 28470,
expanded = true,
desc = '造成伤害提高15%。',
},
},
desc = '克尔苏加德血量降低至40%后进入P3，会刷新寒冰皇冠卫士（类似蜘蛛区老一）。\n寒冰皇冠卫士血量很高，每次切换目标都会叠加一个BUFF：活力分流。',
},
},
desc = '克尔苏加德整场战斗分为三个阶段，P1期间BOSS不参与战斗，不断召唤小怪。5分钟后进入P2，小怪不再刷新，开始输出BOSS，在BOSS血量降至40%时进入P3阶段，该阶段会召唤5个寒冰皇冠卫士。',
},
url = 'https://www.bilibili.com/video/BV1dr4y1w7gW?p=15',
icon = 1378989,
summary = {
children = {
{
title = 'P1',
children = {
{
desc = '拉住憎恶仇恨，远离女妖和骷髅。',
role = 'TANK',
},
{
desc = '场地中间集中站位，治疗全团，主看T。\n注意：牧师需要锁住P1阶段靠近大团的骷髅，P3阶段需要锁住寒冰皇冠卫士（大甲虫）。',
role = 'HEALER',
},
{
desc = '击杀憎恶，远离女妖和骷髅。',
role = 'MELEE',
},
{
desc = '场地中间集中站位，优先击杀骷髅和女妖。\n注意：猎人P1阶段不要多重引到未出来小怪。',
role = 'RANGE',
},
},
},
{
title = 'P2',
children = {
{
desc = '主T在场地中间拉住BOSS，其他T分散在BOSS四周，打断单体寒冰箭，躲开暗影裂隙。',
role = 'TANK',
},
{
desc = '全场10码距离分散站位，治疗中技能玩家，躲开暗影裂隙。',
role = 'HEALER',
},
{
desc = '清理完所有场上小怪后输出BOSS，释放冰霜冲击时往后分散站位，结束返回原位输出，打断单体寒冰箭，躲开暗影裂隙。',
role = 'MELEE',
},
{
desc = '全场10码距离分散站位，清理完所有场上小怪后最远距离输出BOSS，躲开暗影裂隙。',
role = 'RANGE',
},
},
},
{
title = 'P3',
children = {
{
desc = '其余T拉住未被锁住的寒冰皇冠卫士（大甲虫），使用减速技能尽量控制住它们。',
role = 'TANK',
},
{
desc = '全场10码距离分散站位治疗。',
role = 'HEALER',
},
{
desc = '开所有技能输出BOSS。',
role = 'MELEE',
},
{
desc = '开所有技能输出BOSS。',
role = 'RANGE',
},
},
},
},
},
},
[712] = {
bossId = 712,
abilities = {
children = {
{
desc = '对BOSS前方攻击范围内的玩家释放，减少目标10%的治疗效果，可叠加。',
spell = 25646,
},
{
desc = '战斗期间孵化出大量的甲虫。',
spell = 25832,
},
{
desc = '随机点名一名玩家，将该玩家传送至BOSS周围的巢穴中缠住，无法移动，无法施法，持续8秒。',
spell = 1121,
},
{
desc = '战斗期间刷新精英沙虫，沙虫不及时击杀会进入狂暴状态，造成大量伤害。',
spell = 25831,
},
},
},
name = '顽强的范克瑞斯',
summary = {
children = {
{
desc = '1.分配2个T拉BOSS，分别在BOSS的头和尾处，主T致命伤口叠加层数过多时，副T需要嘲讽，拉住BOSS仇恨。\n2.3T拉小甲虫，确保会不去攻击治疗，甲虫多了可群嘲后等待输出消灭甲虫。\n3.4T随时注意沙虫，刷新后第一时间拉住仇恨，沙虫狂暴后击晕沙虫。',
role = 'TANK',
},
{
desc = '1.和远程DPS站在一起治疗全团。\n2.分配1个治疗给被点名传送走的玩家刷血。\n圣骑士可以在沙虫出现后制裁沙虫。',
role = 'HEALER',
},
{
desc = '1.站在BOSS身侧输出。\n2.出现沙虫优先击杀。',
role = 'MELEE',
},
{
desc = '1.和治疗站在一起，输出BOSS。\n2.出现沙虫优先控制击杀。\n3.听指挥释放群攻击杀小甲虫。',
role = 'RANGE',
},
},
},
icon = 1385728,
desc = '整场战斗BOSS会不断召唤大量甲虫和几个精英虫子，需要听从指挥击杀它们。',
},
[601] = {
bossId = 601,
name = '高阶督军纳因图斯',
summary = {
children = {
{
role = 'MELEE',
expanded = false,
desc = '尽量分散站位，在BOSS背后输出，有玩家被穿刺时听从指挥拔除穿刺之脊，若拔出则需要在BOSS开水盾时使用穿刺之脊刺破水盾。',
},
{
role = 'TANK',
expanded = false,
desc = '将BOSS背对大团，有玩家被穿刺时听从指挥拔除穿刺之脊，若拔出则需要在BOSS开水盾时使用穿刺之脊刺破水盾。',
},
{
role = 'RANGE',
expanded = false,
desc = '按指挥分配分散站位输出，有玩家被穿刺时听从指挥拔除穿刺之脊，若拔出则需要在BOSS开水盾时使用穿刺之脊刺破水盾。',
},
{
role = 'HEALER',
expanded = false,
desc = '按指挥分配分散站位治疗全团，注意中技能的玩家生命值，且在水盾被刺破后恢复全团生命值。\n有玩家被穿刺时听从指挥拔除穿刺之脊，若拔出则需要在BOSS开水盾时使用穿刺之脊刺破水盾。\n',
},
},
desc = '高阶督军纳因图斯整场战斗需要和BOSS互动，在有玩家被穿刺之脊扎到的时候，需要有人及时拔出穿刺之脊，在BOSS开水盾的时候拔出穿刺之脊的玩家需要使用穿刺之脊刺破水盾，水盾破时会有群攻伤害，需要及时回复全团生命值。',
},
icon = '1378986',
abilities = {
children = {
{
spell = '39837',
title = '穿刺之脊',
noCollapse = false,
expanded = false,
desc = '随机对除坦克外的目标发射，使其昏迷并造成大量物理伤害，昏迷期间还会受到持续的额外物理伤害。',
},
{
spell = '39872',
title = '海潮之盾',
noCollapse = false,
expanded = false,
desc = '免疫伤害且BOSS持续回复生命值。',
},
{
spell = '39878',
title = '海潮爆发',
noCollapse = false,
expanded = false,
desc = '盾破时对所有玩家造成巨大的冰霜伤害。',
},
{
spell = '39835',
title = '针刺之脊',
noCollapse = false,
expanded = false,
desc = '对随机目标发射，造成大量伤害并对目标周围玩家造成额外伤害。',
},
{
spell = '39836',
title = '马蹄铁横扫',
noCollapse = false,
expanded = false,
desc = '对前方范围内目标造成武器伤害及额外伤害。',
},
{
spell = '19818',
title = '两次攻击',
noCollapse = false,
expanded = false,
desc = '攻击时有几率造成一次额外的近战攻击。',
},
},
desc = '高阶督军纳因图斯在战斗期间，每隔一段时间就会用穿刺之脊刺穿玩家，并使其昏迷，直到队友解救为止。战斗过程中BOSS还会施放海潮之盾免疫伤害并回复生命值，需要玩家使用穿刺之脊刺穿气泡。',
},
},
[609] = {
bossId = 609,
abilities = {
children = {
{
title = 'P1阶段',
expanded = true,
noCollapse = false,
children = {
{
spell = '41032',
title = '剪切',
noCollapse = false,
expanded = false,
desc = '使当前目标生命值上限降低，持续一段时间。',
},
{
spell = '40832',
title = '烈焰冲撞',
noCollapse = false,
expanded = false,
desc = '对当前目标所在区域造成火焰伤害并在地面留下一团火焰，每秒对站在其中的玩家造成大量火焰伤害。',
},
{
spell = '40904',
title = '吸取灵魂',
noCollapse = false,
expanded = false,
desc = '对面前锥形范围内所有目标造成大量暗影伤害，并为BOSS恢复一定量的生命值。',
},
{
spell = '41917',
title = '寄生暗影魔',
noCollapse = false,
expanded = false,
desc = '每隔一段时间点名随机目标寄生暗影魔，寄生期间会造成持续性暗影伤害，持续时间结束后，暗影魔会离开并寻找下一个目标寄生，再次出现暗影魔数量会成倍增加。',
},
},
desc = '和阿卡玛对话，等待剧情结束之后进入战斗',
},
{
title = 'P2阶段',
expanded = false,
noCollapse = false,
children = {
{
expanded = true,
noCollapse = false,
children = {
{
spell = '40631',
title = '烈焰冲击',
noCollapse = false,
expanded = false,
desc = '对正面所有敌人喷吐造成大量火焰伤害。',
},
{
spell = '40611',
title = '光芒',
noCollapse = false,
expanded = false,
desc = '在地面产生一道光芒之火，对范围内敌人造成持续性火焰伤害。',
},
{
spell = '39869',
title = '狂暴',
noCollapse = false,
expanded = false,
desc = '对远离火元素的目标冲锋，且进入狂暴状态，大幅度提升攻击力。\n',
},
},
title = '埃辛诺斯之焰',
},
{
expanded = true,
noCollapse = false,
children = {
{
spell = '40598',
title = '火球术',
noCollapse = false,
expanded = false,
desc = '对随机目标施放，造成大量火焰伤害，且对目标范围内的所有玩家同样造成火焰伤害。',
},
{
spell = '40932',
title = '眼棱',
noCollapse = false,
expanded = false,
desc = '每隔一段时间，伊利丹会以两把埃辛诺斯战刃所在位置为切点进行扫射，路径上会留下蓝色火焰，被扫中的目标会受到巨量伤害，火焰范围内目标也会受到大量火焰伤害。',
},
{
spell = '40585',
title = '黑暗弹幕',
noCollapse = false,
expanded = false,
desc = '随机选择目标，持续性的造成大量暗影伤害。',
},
},
title = '伊利丹·怒风',
},
},
desc = 'BOSS血量降低至65%之后进入第二阶段，伊利丹会飞天并在埃辛诺斯战刃所在的位置出现巨大的火元素“埃辛诺斯之焰”，伊利丹还会在天上不断施放技能。',
},
{
title = 'P3阶段',
expanded = false,
noCollapse = false,
children = {
{
title = '人形态',
expanded = false,
noCollapse = false,
children = {
{
spell = '40932',
title = '苦痛之焰',
noCollapse = false,
expanded = false,
desc = '对随机目标施放，立即对目标周围的所有敌人造成火焰伤害，并在随后的时间内造成巨量火焰伤害。',
},
},
desc = '除了一阶段的所有技能外，还额外增加了以下技能：',
},
{
title = '恶魔形态',
expanded = true,
noCollapse = false,
children = {
{
spell = '41078',
title = '暗影冲击',
noCollapse = false,
expanded = false,
desc = '对当前目标及周围的所有玩家造成大量暗影伤害。',
},
{
spell = '41126',
title = '火焰爆裂',
noCollapse = false,
expanded = false,
desc = '对全团玩家施放火球造成大量伤害，同时会爆炸，对范围内的其他玩家造成等量火焰伤害，爆炸伤害可叠加。',
},
{
spell = '41142',
title = '恐怖光环',
noCollapse = false,
expanded = false,
desc = '对伊利丹附近的所有敌人造成暗影伤害，并在持续时间内使其受到的暗影伤害提高，可叠加。',
},
{
spell = '41117',
title = '召唤影魔',
noCollapse = false,
expanded = false,
desc = '随机指定目标召唤影魔。影魔会使目标昏迷，并追逐该目标直到死亡。',
},
},
desc = '人形态持续一分钟后进入恶魔形态',
},
},
desc = '火元素死亡后进入第三阶段，伊利丹返回地面，开始人和恶魔双形态切换，各持续一分钟。\n',
},
{
title = 'P4阶段',
expanded = false,
noCollapse = false,
children = {
{
title = '玛维·影歌',
expanded = true,
noCollapse = false,
children = {
{
spell = '40761',
title = '牢笼陷阱',
noCollapse = false,
expanded = false,
desc = '玛维·影歌召唤一个暗影陷阱，若伊利丹进入陷阱则会昏迷并增加一个易伤BUFF。',
},
},
desc = '玛维·影歌会在随机位置放置陷阱，如果伊利丹被拉入其中则会受到易伤效果。',
},
{
title = '伊利丹·怒风',
expanded = true,
noCollapse = false,
children = {
{
spell = '40683',
title = '狂乱',
noCollapse = false,
expanded = false,
desc = '造成的伤害和攻击速度提高。',
},
},
desc = '这个阶段伊利丹的技能和第三阶段一样，只在人形态快结束时额外多了个技能狂乱。',
},
},
desc = '伊利丹血量降低至30%进入第四阶段，玛维·影歌加入战斗中。',
},
},
desc = '伊利丹·怒风的战斗较为漫长，一共会经历4个阶段，P1与人形态的伊利丹战斗；P2在BOSS血量到达65%时开启，伊利丹会飞到空中，并将埃辛诺斯战刃投向地面释放出两团烈焰，必须击败两团埃辛诺斯之焰才能让伊利丹落回地面开启下个阶段；P3伊利丹会在人形态和恶魔形态之间切换。直到生命值降至30%进入P4；届时玛维·影歌会抵达战场，帮助玩家战胜伊利丹·怒风。',
},
name = '伊利丹·怒风',
icon = '1378987',
summary = {
children = {
{
role = 'TANK',
expanded = false,
children = {
{
title = 'P1阶段',
noCollapse = false,
expanded = false,
desc = '主坦拉好BOSS，使BOSS背对大团，中剪切技能后开技能自保，可以使用盾牌格挡抵消该技能。需要带着BOSS调整位置来躲开脚下的蓝色火焰。',
},
{
title = 'P2阶段',
noCollapse = false,
expanded = false,
desc = '两个火炕较高的坦克各拉住一个火元素，沿着圆圈缓慢移动来躲开脚下出现的火焰，火元素不能面对大团，且坦克不要离另一个火元素过远。注意伊利丹的眼棱技能，躲好蓝色火焰。',
},
{
expanded = true,
noCollapse = false,
children = {
{
title = '人形态',
expanded = false,
noCollapse = false,
children = {
},
desc = '主坦拉好BOSS，使BOSS背对大团，中剪切技能后开技能自保，战士坦可以使用盾牌格挡抵消该技能。需要带着BOSS调整位置来躲开脚下的蓝色火焰。',
},
{
title = '恶魔形态',
expanded = false,
noCollapse = false,
children = {
},
desc = '需要术士坦克远程拉住伊利丹仇恨，术士坦克需要远离大团站位。',
},
},
title = 'P3阶段',
},
{
title = 'P4阶段',
noCollapse = false,
expanded = false,
desc = '同P3职责，另外可以将伊利丹拉至玛维施放的陷阱内，使伊利丹受到的伤害增加。',
},
},
},
{
role = 'MELEE',
expanded = false,
children = {
{
title = 'P1阶段',
noCollapse = false,
expanded = false,
desc = '在BOSS背后输出BOSS ，注意躲开脚下出现的火焰。中暗影魔的玩家需要跑到指定位置施放暗影魔，之后返回继续输出。',
},
{
title = 'P2阶段',
noCollapse = false,
expanded = false,
desc = '输出火元素时注意躲开脚下的火焰。',
},
{
title = 'P3阶段',
noCollapse = false,
expanded = true,
children = {
{
title = '人形态',
noCollapse = false,
expanded = false,
desc = '在BOSS背后输出BOSS ，注意躲开脚下出现的火焰。中暗影魔的玩家需要跑到指定位置施放暗影魔，之后返回继续输出。',
},
{
title = '恶魔形态',
noCollapse = false,
expanded = false,
desc = '远离伊利丹分散站位。',
},
},
},
{
title = 'P4阶段',
noCollapse = false,
expanded = false,
desc = '同P3职责',
},
},
},
{
role = 'RANGE',
expanded = false,
children = {
{
title = 'P1阶段',
noCollapse = false,
expanded = false,
desc = '和大团一起站位输出BOSS，中暗影魔的玩家需要跑到指定位置施放暗影魔，之后返回继续输出。指挥分配的远程法师优先处理出现的暗影魔。',
},
{
title = 'P2阶段',
noCollapse = false,
expanded = false,
desc = '按照指挥分配的位置站在圆圈内输出，躲开伊利丹施放的蓝色火焰，期间不要离两个火元素过远。',
},
{
title = 'P3阶段',
noCollapse = false,
expanded = true,
children = {
{
title = '人形态',
noCollapse = false,
expanded = false,
desc = '在BOSS背后全团分散站位输出BOSS ，中暗影魔的玩家需要跑到指定位置施放暗影魔，之后返回继续输出。指挥分配的远程法师优先处理出现的暗影魔。',
},
{
title = '恶魔形态',
noCollapse = false,
expanded = false,
desc = '远离伊利丹和术士坦克，分散站位，指挥分配的远程法师优先处理出现的影魔。',
},
},
},
{
title = 'P4阶段',
noCollapse = false,
expanded = false,
desc = '同P3职责',
},
},
},
{
role = 'HEALER',
expanded = false,
children = {
{
title = 'P1阶段',
noCollapse = false,
expanded = false,
desc = '注意主坦的血量。中暗影魔的玩家需要跑到指定位置施放暗影魔，之后返回大团。',
},
{
title = 'P2阶段',
noCollapse = false,
expanded = false,
desc = '按照指挥分配的位置站在圆圈内治疗全团，躲开伊利丹施放的蓝色火焰，期间不要离两个火元素过远。注意中技能的玩家血量。',
},
{
title = 'P3阶段',
noCollapse = false,
expanded = true,
children = {
{
title = '人形态',
noCollapse = false,
expanded = false,
desc = '在BOSS背后全团分散站位治疗 ，注意躲开脚下出现的火焰。中暗影魔的玩家需要跑到指定位置施放暗影魔，之后返回大团。',
},
{
title = '恶魔形态',
noCollapse = false,
expanded = false,
desc = '远离伊利丹和术士坦克，分散站位，指挥分配的治疗术士坦的治疗注意治疗距离。',
},
},
},
{
title = 'P4阶段',
noCollapse = false,
expanded = false,
desc = '同P3职责，人形态最后一段时间时注意坦克血量。',
},
},
},
},
desc = '伊利丹·怒风战斗开始后，P1阶段需要注意处理好寄生的暗影魔，P2需要两个火焰抗性较高的坦克拉住火元素，其他队友注意不要离火元素过远，消灭两个火元素后进入P3，P3需要处理好伊利丹人形态和恶魔形态的各种技能，人形态时和P1大致一样，恶魔形态则需要术士坦拉住，其他人远离，进入P4玛维就会和我们一起战斗，直到伊利丹倒下。',
},
},
['655-2'] = {
bossId = '655-2',
summary = {
children = {
{
desc = '主T将大灰狼拉至房间角落，小红帽变形结束后注意拉住BOSS仇恨。',
role = 'TANK',
},
{
desc = '站在场地中间治疗，注意被变形为小红帽玩家的血量。若被变形为小红帽则需要在房间外围绕圈跑，尽量远离大灰狼。',
role = 'HEALER',
},
{
desc = '全力输出BOSS，若被变形为小红帽则需要在房间外围绕圈跑，尽量远离大灰狼。',
role = 'MELEE',
},
{
desc = '站在场地中间输出BOSS。若被变形为小红帽则需要在房间外围绕圈跑，尽量远离大灰狼。',
role = 'RANGE',
},
},
desc = '歌剧院有三种BOSS组合，分别为绿野仙踪、小红帽、罗密欧和朱丽叶，每次随机选择一组。整场战斗只有大灰狼一个BOSS，最主要技能就是会随机将一个玩家变为小红帽，这时大灰狼就会无视仇恨追逐小红帽，被变成小红帽的玩家需要绕着房间外围逃跑避免被大灰狼追到，变化时间到了坦克再去拉住大灰狼仇恨，如此反复即可击杀BOSS。',
},
abilities = {
children = {
{
noCollapse = true,
title = '大灰狼',
children = {
{
desc = '恐惧附近玩家。',
spell = 30752,
},
{
desc = '将随机玩家标记为小红帽，持续10秒，大灰狼会无视仇恨只攻击小红帽。',
spell = 30753,
},
{
desc = '对前方范围内玩家造成伤害并击晕。',
spell = 30761,
},
},
},
},
desc = '歌剧院有三种BOSS组合，分别为绿野仙踪、小红帽、罗密欧和朱丽叶，每次随机选择一组。\n小红帽组只有一个BOSS：大灰狼，战斗期间会随机将一名玩家变为小红帽，BOSS会无视仇恨只追击小红帽。',
},
icon = 1385758,
name = '歌剧院之小红帽',
},
[649] = {
bossId = 649,
summary = {
children = {
{
children = {
{
title = 'P1阶段',
desc = '克洛什·火拳需要法师来坦住，拉在小BOSS原位即可，法师T需要每隔30秒偷取克洛什·火拳的法术护盾，确保受到的法术伤害降低。\n疯狂的基戈尔需要两个猎人来坦克，将小BOSS拉至房间左上角。\n盲眼坦克将小BOSS拉至房间左下角，注意打断加血技能。\n召唤者沃尔姆坦克将小BOSS拉至房间右上角，术士需要第一时间奴役小BOSS召唤的地狱犬，让地狱犬保持第二仇恨，确保T被死亡缠绕后，地狱犬可以坦住小BOSS。\n主T拉住莫加尔大王，将BOSS拉在通道入口处，背靠墙壁，避免被击退。',
},
{
title = 'P2阶段',
desc = '在BOSS冲锋之后，坦克需要将BOSS拉回原位。',
},
},
role = 'TANK',
},
{
children = {
{
title = 'P1阶段',
desc = '按照指挥分配治疗好各个坦住BOSS的T，负责给拉疯狂的基戈尔的猎人加血的治疗要最远距离加血，避免被羊。',
},
{
title = 'P2阶段',
desc = '牧师给主T加好反恐惧结界，萨满祭司插好战栗图腾，注意主T的血量即可。',
},
},
role = 'HEALER',
},
{
children = {
{
title = 'P1阶段',
desc = '按照顺序击杀，第一个先击杀盲眼先知，BOSS盾破之后注意打断治疗。第二个是召唤者沃尔姆。第三个疯狂的基戈尔，尽量背靠墙最远距离输出，避免被击飞。第四个是克洛什·火拳。最后去输出莫加尔大王，输出时躲好大王的旋风斩。',
},
{
title = 'P2阶段',
desc = '输出莫加尔大王，恐惧后继续返回输出即可。',
},
},
role = 'MELEE',
},
{
children = {
{
title = 'P1阶段',
desc = '按照顺序击杀，第一个先击杀盲眼先知。第二个是召唤者沃尔姆，术士注意第一时间奴役或者放逐召唤出的地狱犬。第三个疯狂的基戈尔。第四个是克洛什·火拳。最后去输出莫加尔大王。',
},
{
title = 'P2阶段',
desc = '输出莫加尔大王即可。',
},
},
role = 'RANGE',
},
},
desc = '莫加尔大王是格鲁尔的巢穴一号BOSS，BOSS战需要面对莫加尔大王和他的四个小弟，整场战斗需要一个法师去拉住克洛什·火拳，两个猎人拉住疯狂的基戈尔，术士需要控制召唤者沃尔姆召唤出的地狱犬，让地狱犬保持召唤者沃尔姆的第二仇恨，击杀掉四个小BOSS就进入P2阶段，莫加尔大王进入狂怒状态，击杀之后整场战斗结束。',
},
abilities = {
children = {
{
noCollapse = true,
title = '盲眼先知',
children = {
{
desc = '恢复自身血量。',
spell = 33144,
},
{
desc = '恢复自身及其他同伴血量，可打断。',
spell = 33152,
},
{
desc = '治疗祷言前释放盾，盾可吸收伤害并免疫控制技能。',
spell = 11974,
},
},
},
{
noCollapse = true,
title = '召唤者沃尔姆',
children = {
{
desc = '召唤一只地狱犬，可被术士奴役和放逐。',
spell = 33131,
},
{
desc = '对当前仇恨目标释放，造成大量暗影伤害并恐惧4秒。',
spell = 27223,
},
{
desc = '对当前仇恨目标释放，造成持续暗影伤害，无法驱散，但可被召唤的地狱犬吞噬。',
spell = 33129,
},
},
},
{
noCollapse = true,
title = '疯狂的基戈尔',
children = {
{
desc = '将范围内随机玩家变羊，不可驱散。',
spell = 851,
},
{
desc = '对当前仇恨目标释放，造成大量自然伤害。',
spell = 8246,
},
{
desc = '打断范围内随机玩家施法，持续5秒。',
spell = 33175,
},
{
desc = '对周围玩家造成自然伤害并击飞。',
spell = 33860,
},
},
},
{
noCollapse = true,
title = '克洛什·火拳',
children = {
{
desc = '放出一道火焰冲击波，所有被冲击波触及的玩家都会受到火焰伤害并降低移动速度。',
spell = 33061,
},
{
desc = '对一名玩家造成大量火焰伤害。',
spell = 33051,
},
{
desc = '降低受到的魔法伤害75%，持续30秒，法师可以偷取。',
spell = 33054,
},
},
},
{
noCollapse = true,
title = '莫加尔大王',
children = {
{
desc = '对周围所有玩家造成物理伤害，持续15秒。期间BOSS可移动，但移动速度降低。',
spell = 33238,
},
{
desc = '对前方范围内玩家造成物理伤害。',
spell = 845,
},
{
desc = '对当前仇恨目标释放，造成物理伤害并击退。',
spell = 33230,
},
{
title = '狂怒',
desc = '50%血量后进入狂怒状态。',
},
},
},
{
noCollapse = true,
title = '狂怒后增加2个新技能',
children = {
{
desc = '发出咆哮，恐惧周围10码范围内玩家，恐惧持续10秒。',
spell = 16508,
},
{
desc = '随机冲锋10码范围外玩家。',
spell = 32323,
},
},
},
},
desc = '莫加尔大王带着4个小BOSS，分别是克洛什·火拳、召唤者沃尔姆、盲眼先知和疯狂的基戈尔。BOSS战分为2阶段，P1需要先依次击杀4个小BOSS，然后输出莫加尔大王。在莫加尔血量到50%时进入P2，P2的莫加尔会狂暴，并且多出2个技能：恐惧和冲锋。',
},
icon = 1378985,
name = '莫加尔大王',
},
[657] = {
bossId = 657,
summary = {
children = {
{
desc = '主T将BOSS拉至绿圈附近，副T将精英小鬼拉在BOSS边上，精英小鬼再一次刷新出来时副T也要迅速拉住仇恨。\n指定术士T在传送门出现后不断的对BOSS上腐蚀之种，爆炸会对周围的小鬼造成伤害并拉住小鬼仇恨。',
role = 'TANK',
},
{
desc = '在绿圈附近治疗，尽量靠近远程输出，便于远程帮忙清理小鬼。期间有玩家被锁在绿圈就优先治疗被锁住的玩家，确保其在锁链被摧毁前存活。',
role = 'HEALER',
},
{
desc = '在绿圈附近输出BOSS，期间有玩家被锁在绿圈就优先击杀锁链救人，精英小鬼死后立即全力输出BOSS。',
role = 'MELEE',
},
{
desc = '在绿圈附近输出BOSS，期间有玩家被锁在绿圈就优先击杀锁链救人，精英小鬼死后立即全力输出BOSS。\n注意：传送门内小鬼出来的多了，需要法师配合术士清理掉一批之后再输出BOSS。',
role = 'RANGE',
},
},
desc = '特雷斯坦·邪蹄身边跟随着一个精英的小鬼，小鬼在死后会给予BOSS一个易伤的buff，30秒后BOSS会重新召唤精英小鬼。BOSS房间内还会出现2个传送门，不断刷新出非精英的小鬼，需要术士对着BOSS释放腐蚀之种，爆炸会对周围的小鬼造成伤害并拉住小鬼仇恨。BOSS还会随机将一名玩家传送到房间绿圈内锁住，需要优先摧毁锁链救出队友，然后再输出BOSS。',
},
abilities = {
children = {
{
noCollapse = true,
title = '特雷斯坦·邪蹄',
children = {
{
desc = '随机将一名玩家传送至房间绿圈内，玩家会被锁链锁住，每秒受到暗影伤害并处于昏迷状态，所受伤害还会恢复邪蹄血量，锁链可以被摧毁。',
spell = 30115,
},
{
desc = '召唤一道传送门，门内会周期性的召唤出非精英的小鬼。',
spell = 30171,
},
{
desc = '召唤基尔里克为BOSS作战。',
spell = 30066,
},
},
},
{
noCollapse = true,
title = '基尔里克（精英小鬼）',
children = {
{
desc = '使玩家受到的火焰伤害提高500点，持续25秒。',
spell = 30053,
},
{
desc = '基尔里克死亡，邪蹄受到伤害增加25%，持续30秒。时间结束邪蹄会重新召唤基尔里克。',
spell = 30065,
},
},
},
},
desc = '特雷斯坦·邪蹄带着一个精英小鬼，当这个小鬼被击杀之后BOSS会有易伤，30秒后易伤结束，精英小鬼也会重新刷新。整场战斗需要一个术士坦克，来拉住传送门内出来的小鬼仇恨。10分钟后未结束战斗，BOSS会释放群体暗影箭导致团灭。',
},
icon = 1379017,
name = '特雷斯坦·邪蹄',
},
[1576] = {
bossId = 1576,
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = 'P1：成为亵渎者萨拉德雷目标时绕房间风筝他，主T在将萨古纳尔男爵拉至角落等待输出，星术师卡波妮娅需要SST拉至房间另一边坦住，副T拉住首席技师塔隆尼库斯，期间可以躲避炸弹投掷，副T中了遥控玩具，另外的T需要及时接住首席技师塔隆尼库斯的仇恨。\nP2：根据指挥分配各个T拉住对应武器，灵魂之弦需要猎人作为坦克，将弓独立拉至角落，避免多重涉及伤到大团。每死亡一把武器需要将其他武器拉开，避免所有武器死在一堆导致无法顺利拾取武器。T可以拾取迁跃切割者、相位壁垒和无尽之刃。\nP3：成为亵渎者萨拉德雷目标时绕房间风筝他，主T在将萨古纳尔男爵拉至角落等待输出，可使用相位壁垒免疫恐惧。星术师卡波妮娅需要SST拉至房间另一边坦住，副T拉住首席技师塔隆尼库斯，期间可以躲避炸弹投掷，副T中了遥控玩具，另外的T需要及时接住首席技师塔隆尼库斯的仇恨。\nP4：主T将BOSS拉在台子上，在BOSS炎爆时使用相位壁垒技能吸收伤害，副T拉住出现的凤凰风筝直至凤凰死亡。除主副T外其他T可以装备无尽之刃使用低等级的近战攻击被精神控制的玩家，驱散精神控制。全程打断BOSS施法。\nP5：漂浮期间远离BOSS，分散站位，不要飘的离地面太远，避免漂浮结束受到坠落伤害，漂浮结束，主T拉住BOSS，副T拉住出现的凤凰风筝直至凤凰死亡。重复P5动作直至BOSS倒下。',
},
{
role = 'MELEE',
expanded = false,
desc = 'P1：输出萨古纳尔男爵和首席技师塔隆尼库斯，远离亵渎者萨拉德雷和星术师卡波妮，成为亵渎者萨拉德雷目标时绕房间风筝他。\nP2：优先打断宇宙灌注者的治疗，随后输出。无尽之刃死后拾取并装备。\nP3：优先输出首席技师塔隆尼库斯，然后是萨古纳尔男爵，远离亵渎者萨拉德雷和星术师卡波妮。\nP4：击杀所有顾问后输出BOSS，全程打断BOSS施法，装备无尽之刃使用低等级的近战攻击被精神控制的玩家，驱散精神控制。BOSS释放屏障时全力输出打破屏障后打断炎爆术。在凤凰变成卵之后优先打破卵避免凤凰重生。\nP5：漂浮期间远离BOSS，分散站位，不要飘的离地面太远，避免漂浮结束受到坠落伤害，漂浮结束后输出BOSS。重复P5动作直至BOSS倒下。',
},
{
role = 'RANGE',
expanded = false,
desc = 'P1：按照激活顺序输出4个顾问，成为亵渎者萨拉德雷目标时绕房间风筝他，分散站位最远距离输出星术师卡波妮。\nP2：等待坦克拉住所有武器之后使用群攻技能击杀武器，需要一个猎人坦住灵弦长弓，将其拉离大团最后击杀。武器死亡后，法师术士需要拾取瓦解法杖，猎人需要拾取灵弦长弓。\nP3：优先输出亵渎者萨拉德雷，然后是分散站位输出星术师卡波妮，随后再输出萨古纳尔男爵和首席技师塔隆尼库斯。需要一个法师在T的队伍里使用瓦解法杖，使T对昏迷、沉默和迷惑效果免疫。\nP4：击杀所有顾问后输出BOSS，远离召唤出的凤凰，在凤凰变成卵之后优先打破卵避免凤凰重生，BOSS释放屏障时全力输出打破屏障。需要一个法师在T的队伍里使用瓦解法杖，使T对昏迷、沉默和迷惑效果免疫。\nP5：漂浮期间远离BOSS，分散站位输出BOSS，不要飘的离地面太远，避免漂浮结束受到坠落伤害，漂浮结束后继续输出，远离召唤出的凤凰，在凤凰变成卵之后优先打破卵避免凤凰重生。重复P5动作直至BOSS倒下。',
},
{
role = 'HEALER',
expanded = false,
desc = 'P1：按照指挥分配治疗好拉住顾问的T，尤其是SST和受到星术师卡波妮娅燃烧技能的玩家，成为亵渎者萨拉德雷目标时绕房间风筝他。\nP2：治疗全团，等武器死亡之后拾取宇宙灌注者。\nP3：按照指挥分配治疗好拉住顾问的T，尤其是SST和受到星术师卡波妮娅燃烧技能的玩家，成为亵渎者萨拉德雷目标时绕房间风筝他。\nP4：治疗全团，在BOSS释放屏障时有必要的话也可以输出尽快打破屏障。\nP5：漂浮期间远离BOSS，分散治疗，不要飘的离地面太远，避免漂浮结束受到坠落伤害，漂浮结束后继续治疗全团。重复P5动作直至BOSS倒下。',
},
},
desc = '凯尔萨斯·逐日者战斗分为5个阶段，P1会一个个的激活BOSS边上的顾问，需要一个个的击杀，P2会同时召唤7种武器，武器击杀后可以拾取，装备后拥有每把武器的独特技能，使用可抵消部分顾问和BOSS的技能效果。P3会同时复活4个顾问，需要分别击杀，3分钟后将进入P4。P4王子开始攻击玩家，期间需要打破王子释放的屏障打断炎爆，召唤的凤凰会每秒自动下降血量，需要副T拉住并风筝，死后第一时间击杀凤凰卵防止凤凰重生。王子血量降低至50%进入P5阶段，会将所有人漂浮至空中，期间需要远离BOSS输出，落地之后近战再靠近输出BOSS。',
},
name = '凯尔萨斯·逐日者',
icon = '607669',
abilities = {
children = {
{
expanded = false,
noCollapse = true,
children = {
{
expanded = false,
noCollapse = false,
children = {
{
expanded = false,
noCollapse = false,
title = '凝视',
desc = '随机凝视一名玩家并跟随他，被凝视玩家将获得最大仇恨。',
},
{
spell = '30225',
noCollapse = false,
expanded = false,
desc = '每4秒释放一次，使10码范围内所有玩家沉默，持续8秒。',
},
{
spell = '36966',
noCollapse = false,
expanded = false,
desc = '将被凝视玩家击飞并造成大量伤害。',
},
{
spell = '36965',
noCollapse = false,
expanded = false,
desc = '对目标造成大量伤害，并附带一个每2秒遭受一次伤害的割裂效果。持续12秒。',
},
},
title = '亵渎者萨拉德雷',
},
{
expanded = false,
noCollapse = false,
children = {
{
spell = '44863',
noCollapse = false,
expanded = false,
desc = '使30码范围内玩家因恐惧而逃跑，持续4秒。',
},
},
title = '萨古纳尔男爵',
},
{
expanded = false,
noCollapse = false,
children = {
{
spell = '36970',
noCollapse = false,
expanded = false,
desc = '当有玩家处于近战范围内时会释放技能，对范围内玩家造成大量奥术伤害并击退，移动速度减慢。',
},
{
spell = '36971',
noCollapse = false,
expanded = false,
desc = '攻击仇恨最高目标，造成大量火焰伤害。',
},
{
spell = '37018',
noCollapse = false,
expanded = false,
desc = '随机对一名30码范围内玩家释放，每秒造成伤害并附带迷惑效果，持续10秒，被点燃玩家会对附近队友造成火焰伤害。',
},
},
title = '星术师卡波妮娅',
},
{
expanded = false,
noCollapse = false,
children = {
{
expanded = false,
noCollapse = false,
title = '炸弹投掷',
desc = '对目标投掷炸弹，造成大量伤害，范围攻击。',
},
{
spell = '37027',
noCollapse = false,
expanded = false,
desc = '随机对一个目标使用遥控玩具，目标将获得一个持续60秒的debuff，期间将随机4秒无法行动。',
},
},
title = '首席技师塔隆尼库斯',
},
},
title = '四顾问技能',
},
{
expanded = false,
noCollapse = true,
children = {
{
title = '毁灭（双手斧）',
footDesc = '装备命中后使你的移动速度提高50%，近战攻击速度提供20%，持续15秒。',
noCollapse = false,
expanded = false,
children = {
{
spell = '36981',
noCollapse = false,
expanded = false,
desc = '旋转挥舞武器，对周围玩家造成大量伤害。',
},
},
},
{
title = '灵弦长弓（弓）',
footDesc = '拾取装备后使你的远程武器暴击伤害加成提高50%，命中后使目标受到的物理伤害提高5%持续30秒，可叠加。',
noCollapse = false,
expanded = false,
children = {
{
expanded = false,
noCollapse = false,
title = '奥术射击',
desc = '对当前目标释放，造成大量奥术伤害。',
},
{
spell = '36979',
noCollapse = false,
expanded = false,
desc = '连续射出弹药，对多个目标造成大量伤害。',
},
},
},
{
title = '迁跃切割者（单手剑）',
footDesc = '装备命中后使你的移动速度提高50%，近战攻击速度提供20%，持续15秒。',
noCollapse = false,
expanded = false,
children = {
{
spell = '36991',
noCollapse = false,
expanded = false,
desc = '对目标造成大量伤害并附带割裂效果，可叠加。',
},
},
},
{
title = '宇宙灌注者（单手锤）',
footDesc = '装备后被施法者治疗的友方目标将获得一个保护效果，使火焰和暗影法术对其造成的伤害降低50%，持续30秒。',
noCollapse = false,
expanded = false,
children = {
{
spell = '36985',
noCollapse = false,
expanded = false,
desc = '治疗其他所有武器，并对附近玩家造成神圣伤害。',
},
{
spell = '36983',
noCollapse = false,
expanded = false,
desc = '治疗低血量武器。',
},
},
},
{
title = '瓦解法杖（双手杖）',
footDesc = '拾取后使用为周围半径30码范围内的友方目标施加心灵防护力场，使其对昏迷、沉默和迷惑效果免疫。',
noCollapse = false,
expanded = false,
children = {
{
spell = '36989',
children = {
},
noCollapse = false,
expanded = false,
desc = '对附近玩家造成伤害并冻结在原地。',
},
{
spell = '36990',
noCollapse = false,
expanded = false,
desc = '对目标造成冰霜伤害并降低移动速度。',
},
},
},
{
title = '无尽之刃（匕首）',
footDesc = '装备后使目标受到的法术伤害提高5%，并在近战攻击技能命中时驱散凯尔萨斯王子的精神控制效果，可叠加最多5次，持续30秒。',
noCollapse = false,
expanded = false,
children = {
{
spell = '3391',
noCollapse = false,
expanded = false,
desc = '随机释放额外2次攻击。',
},
},
},
{
title = '相位壁垒（盾）',
footDesc = '装备后使用可保护施法者，吸收伤害并使其对恐惧和诱捕效果免疫，持续4秒。',
noCollapse = false,
expanded = false,
children = {
{
spell = '2565',
title = '盾牌钉刺',
children = {
},
noCollapse = false,
expanded = false,
desc = '反射部分对它造成的近战伤害。',
},
{
spell = '30356',
children = {
},
noCollapse = false,
expanded = false,
desc = '对目标造成大量伤害。',
},
},
},
},
title = '七把武器技能',
},
{
expanded = false,
noCollapse = true,
children = {
{
spell = '36834',
title = '奥术干扰（P4和P5）',
noCollapse = false,
expanded = false,
desc = '每分钟释放一次，对所有玩家造成伤害并附带迷惑效果。',
},
{
spell = '36815',
title = '冲击屏障（P4和P5）',
noCollapse = false,
expanded = false,
desc = '每分钟展开屏障，可以吸收10万伤害并免疫打断，持续10秒。',
},
{
spell = '36805',
title = '火球术（P4和P5）',
noCollapse = false,
expanded = false,
desc = '对当前目标释放，造成大量火焰伤害。',
},
{
spell = '36797',
title = '精神控制（仅在P4）',
noCollapse = false,
expanded = false,
desc = '每隔一段时间精神控制2个玩家30秒。',
},
{
spell = '36819',
title = '炎爆术（仅在P4）',
noCollapse = false,
expanded = false,
desc = '屏障展开时对当前目标释放，造成大量火焰伤害。',
},
{
spell = '36723',
title = '召唤凤凰（P4和P5）',
noCollapse = false,
expanded = false,
desc = '对随机目标释放烈焰风暴，几秒后会生成一只带有地狱火技能的凤凰，凤凰死后会生成凤凰卵，若没有在15秒内击杀卵，将会重新孵化出凤凰。',
},
{
spell = '11327',
title = '重力消失（仅在P5）',
children = {
},
noCollapse = false,
expanded = false,
desc = '使所有人漂浮至空中30秒。',
},
{
spell = '35873',
title = '虚空光柱（仅在P5）',
noCollapse = false,
expanded = false,
desc = '当漂浮在空中时，对随机目标释放，对目标造成大量伤害并跳跃至附近玩家身上。',
},
{
spell = '35859',
title = '虚空雾气（仅在P5）',
noCollapse = false,
expanded = false,
desc = '漂浮期间，使近战范围内所有玩家获得一个debuff，每秒受到暗影伤害并降低总血量10%，持续60秒，可叠加。',
},
},
title = '凯尔萨斯·逐日者技能',
},
},
desc = '风暴要塞最终BOSS是血精灵王子凯尔萨斯·逐日者，整场战斗可以分为五个阶段，P1需要先一一击杀王子周围的4个顾问；P2王子会召唤7种武器，每种武器死后可以拾取并装备（临时性武器）；P3王子同时复活4个顾问，分散拉开并击杀；P4阶段开始输出王子，期间会召唤小凤凰；P5阶段王子会每隔一段时间将所有人漂浮在空中，仍旧输出王子直至王子倒下。',
},
},
[1116] = {
bossId = 1116,
name = '迈克斯纳',
zone = 1,
abilities = {
children = {
{
title = '蛛网束缚',
desc = 'BOSS随机将3名玩家弹至墙上并用蛛网包裹住，被上墙玩家会受到持续的自然伤害，蛛网有血条，可被打破。',
},
{
desc = '使用蛛网缠绕所有玩家，使玩家昏迷，持续4秒。',
spell = 29484,
},
{
title = '召唤蜘蛛',
desc = 'BOSS会周期性的召唤出小蜘蛛（普通怪）。',
},
{
title = '死灵毒药',
desc = '使目标在30秒内治疗效果降低90%，可驱散。',
},
{
title = '狂乱',
desc = 'BOSS血量30%后会狂乱，使BOSS攻击速度提高50%，伤害提高。',
},
},
desc = '战斗期间会有随机3名玩家被BOSS弹射上墙，位置在靠近入口的墙面上，需要迅速解救。',
},
url = 'https://www.bilibili.com/video/BV1dr4y1w7gW?p=3',
icon = 1378994,
summary = {
children = {
{
desc = '1.进入战斗后，主T将BOSS拉在原位，使BOSS背对所有玩家即可。\n2.蛛网喷射（全团缠绕）前和BOSS狂暴时注意开保命技能。',
role = 'TANK',
},
{
desc = '1.分配治疗上墙玩家的治疗者，靠近墙边站位，在BOSS释放技能时速度给上墙玩家治疗。（需要在被蛛网包裹前上好治疗手段，蛛网包裹后无法治疗）\n2.蛛网喷射（全团缠绕）前给主T加好所有持续性治疗手段，套好盾，确保主T可以抗住4秒。\n注意：第一时间驱散主T身上的毒。',
role = 'HEALER',
},
{
desc = '1.进入战斗后站在BOSS背后输出，若被弹上墙，下来后迅速返回输出BOSS。\n2.BOSS召唤小蜘蛛后迅速使用群攻技能击杀。',
role = 'MELEE',
},
{
desc = '1.分配解救上墙玩家的远程按指挥分配站位，若有玩家上墙，迅速按tab键选取目标，第一时间击杀蛛网解救玩家。\n2.其余远程和近战一起站位输出BOSS，召唤出小蜘蛛优先击杀。',
role = 'RANGE',
},
},
},
},
[713] = {
bossId = 713,
summary = {
children = {
{
noCollapse = true,
title = '特殊机制',
desc = 'BOSS在承受大概200下寒冰箭之后会冻结，冻结状态持续15秒，冻结期间受到一定数量的近战攻击会被打碎，打碎后分裂成小水滴（小水滴数量取决于当前BOSS的生命值）。小水滴在场地的外围出现，不断向场地中心移动，直到聚拢形成BOSS。小水滴不可控制，可被击杀。重新形成的BOSS血量取决于聚拢的小水滴数量，当BOSS血量低于10%时，再被冻结击碎就会死亡。',
},
{
desc = '1.主T开场将BOSS拉在场地中间。\n2.BOSS被击碎重新形成时第一时间拉住BOSS仇恨。\n3.若脚下出现毒云，则将BOSS拉离毒云范围。',
role = 'TANK',
},
{
desc = '1.法师组和主T组治疗开场就进，分散站位治疗主T和法师们。\n2.优先驱散中毒。\n3.优先治疗法师和主T，兼顾其他团员。。',
role = 'HEALER',
},
{
desc = '1.开场在BOSS门口外等待。\n2.BOSS即将被冻结就进场，等冻结就使用近战攻击击打BOSS。\n3.出小水滴的时候冲上前去，尽量击杀小水滴。\n4.在小水快要滴聚拢时在场地中间使用群攻技能，或者工程炸弹等。\n5.BOSS再度出现则出BOSS门口继续等待。\n6.注意远离毒云。\n7.不断重复以上步骤直至BOSS死亡。',
role = 'MELEE',
},
{
children = {
{
title = '除法师外其他远程DPS',
desc = '1.开场在BOSS门口外等待。\n2.BOSS即将被冻结就进场，等冻结就使用近战攻击击打BOSS。\n3.出小水滴的时候尽量击杀小水滴。\n4.在小水滴快要聚拢时在场地中间使用群攻技能，或者工程炸弹等。\n5.BOSS再度出现则出BOSS门口继续等待。\n6.注意远离毒云。\n7.不断重复以上步骤直至BOSS死亡。',
},
{
title = '法师',
desc = '1.进场分散站位，对BOSS使用一级寒冰剑。\n2.BOSS冻结后使用近战攻击击打BOSS。\n3.出小水滴的时候尽量击杀小水滴。\n4.在小水滴快要聚拢时在场地中间使用群攻技能，或者工程炸弹等。\n5.BOSS再度出现则继续对BOSS使用一级寒冰剑。\n6.注意远离毒云。\n7.不断重复以上步骤直至BOSS死亡。',
},
},
role = 'RANGE',
},
},
},
abilities = {
children = {
{
noCollapse = true,
title = '特殊机制',
desc = 'BOSS在承受大概200下寒冰箭之后会冻结，冻结状态持续15秒，冻结期间受到一定数量的近战攻击会被打碎，打碎后分裂成小水滴（小水滴数量取决于当前BOSS的生命值）。小水滴在场地的外围出现，不断向场地中心移动，直到聚拢形成BOSS。小水滴不可控制，可被击杀。重新形成的BOSS血量取决于聚拢的小水滴数量，当BOSS血量低于10%时，再被冻结击碎就会死亡。',
},
{
desc = '对100码范围内玩家释放群体毒箭，玩家会受到1500左右伤害并中毒，中毒后每秒持续掉血，可叠加。',
spell = 25991,
},
{
desc = '对目标造成1500左右的伤害。',
spell = 25993,
},
{
desc = '地面随机出现范围性毒云，站在毒云范围内会受到每秒1500的自然伤害。',
spell = 26575,
},
},
},
icon = 1385771,
name = '维希度斯',
},
[602] = {
bossId = 602,
abilities = {
children = {
{
children = {
{
spell = '40126',
title = '熔岩打击',
noCollapse = false,
expanded = false,
desc = '击打地面，周期性地创造熔岩烈焰。烈焰会攻击敌人，造成火焰伤害。',
},
{
spell = '41926',
title = '仇恨打击',
noCollapse = false,
expanded = false,
desc = '对近战范围内当前生命值最高的有仇恨目标造成大量伤害。',
},
},
noCollapse = false,
title = 'P1阶段',
expanded = true,
},
{
children = {
{
spell = '42055',
title = '火山喷射',
noCollapse = false,
expanded = false,
desc = '地面上一座活火山突然爆发，对范围内所有敌人造成火焰伤害。',
},
{
spell = '38067',
title = '锁定',
expanded = false,
noCollapse = false,
children = {
},
desc = '锁定一个随机目标。',
},
},
noCollapse = false,
title = 'P2阶段',
expanded = true,
},
},
desc = '苏普雷姆斯的战斗会在两个阶段之间不断切换，一阶段为阵地战，需要躲好地上的火焰，BOSS会对近战范围内生命值最高的玩家施放仇恨打击；二阶段BOSS会随机追逐目标，被凝视的玩家需要及时跑开风筝BOSS。',
},
name = '苏普雷姆斯',
icon = '1379016',
summary = {
children = {
{
role = 'TANK',
expanded = true,
children = {
{
title = 'P1阶段',
noCollapse = false,
expanded = false,
desc = '主坦将BOSS背对大团，注意躲开脚下的火焰，副坦需要保证自己的血量为全团最高，且在遭到仇恨打击时使用减伤技能确保自己存活。',
},
{
title = 'P2阶段',
noCollapse = false,
expanded = false,
desc = '当被BOSS凝视时跑开风筝BOSS，及时远离脚下出现的小火山。',
},
},
},
{
role = 'MELEE',
expanded = true,
children = {
{
title = 'P1阶段',
noCollapse = false,
expanded = false,
desc = '注意自身血量不要高于副T，注意躲开脚下火焰。再一次进入一阶段前注意停手等待坦克建立仇恨。',
},
{
title = 'P2阶段',
noCollapse = false,
expanded = false,
desc = '进入二阶段时远离BOSS，当被BOSS凝视时跑开风筝BOSS，及时远离出现的小火山。',
},
},
},
{
role = 'RANGE',
expanded = true,
children = {
{
title = 'P1阶段',
noCollapse = false,
expanded = false,
desc = '注意躲开脚下火焰。再一次进入一阶段前注意停手等待坦克建立仇恨。',
},
{
title = 'P2阶段',
noCollapse = false,
expanded = false,
desc = '当被BOSS凝视时跑开风筝BOSS，及时远离出现的小火山。',
},
},
},
{
role = 'HEALER',
expanded = true,
children = {
{
title = 'P1阶段',
noCollapse = false,
expanded = false,
desc = '及时恢复被仇恨打击的玩家生命值，注意躲开脚下火焰。',
},
{
title = 'P2阶段',
noCollapse = false,
expanded = false,
desc = '当被BOSS凝视时跑开风筝BOSS，及时远离出现的小火山。',
},
},
},
},
desc = '苏普雷姆斯战斗分为两个阶段，一阶段需要及时躲开地面的火焰，且BOSS会打击除主坦之外生命值最高的玩家，一分钟后进入二阶段，BOSS随机追逐一个玩家，玩家需要跑开风筝BOSS，所有人及时躲开出现的小火山。BOSS回到一阶段时注意仇恨不要OT。',
},
},
[618] = {
bossId = 618,
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '将BOSS拉在指定位置即可。脚下出现死亡凋零及时躲开。',
},
{
role = 'MELEE',
expanded = false,
desc = 'BOSS身后输出，注意仇恨，脚下出现死亡凋零及时躲开。',
},
{
role = 'RANGE',
expanded = false,
desc = '最远距离分散站位输出，注意仇恨，脚下出现死亡凋零及时躲开。',
},
{
role = 'HEALER',
expanded = false,
desc = '最远距离分散站位治疗，脚下出现死亡凋零及时躲开。\n注意坦克和中寒冰箭玩家的生命值。\n驱散魔法职业需要注意被冰环的人是否同时中死亡凋零，若有则需及时驱散冰环。\n',
},
},
desc = '雷基·冬寒会施放死亡凋零和冰霜新星，尤其是随机区域施放的死亡凋零，需要玩家及时察觉并躲开，战斗期间保护好吉安娜也是非常重要的。',
},
name = '雷基·冬寒',
icon = '1385762',
abilities = {
children = {
{
spell = '31249',
title = '寒冰箭',
expanded = false,
noCollapse = false,
children = {
},
desc = '随机点名一个目标造成冰霜伤害并冰冻目标，同时带有持续性伤害。',
},
{
spell = '31258',
title = '死亡凋零',
noCollapse = false,
expanded = false,
desc = '随机目标区域施放该技能，站在该区域内的玩家会受到持续伤害。',
},
{
spell = '31250',
title = '冰霜新星',
noCollapse = false,
expanded = false,
desc = '对近战范围内的玩家造成冰霜伤害并将其冻结在原地，冻结效果可驱散。',
},
},
desc = '雷基·冬寒在击杀完八波小怪后就会出现，击杀小怪期间灭团则需重新开始清理八波小怪，雷基·冬寒的战斗需要及时躲避BOSS施放的各种范围伤害。战斗期间还需要确保吉安娜不能死亡，她一旦死亡就战斗结束，BOSS消失。',
},
},
['655-1'] = {
bossId = '655-1',
summary = {
children = {
{
children = {
{
title = 'P1阶段',
desc = '主T拉住多萝西，远离人群。副T拉住铁皮人，当铁皮人生锈减速后可以风筝铁皮人，出现托托时拉住仇恨。',
},
{
title = 'P2阶段',
desc = '主T拉住巫婆，注意躲避龙卷风。',
},
},
role = 'TANK',
},
{
children = {
{
title = 'P1阶段',
desc = '治疗全团，注意被多萝西攻击的玩家血量。',
},
{
title = 'P2阶段',
desc = '治疗全团，注意躲避龙卷风。',
},
},
role = 'HEALER',
},
{
children = {
{
title = 'P1阶段',
desc = '听从指挥按顺序击杀所有BOSS，推荐击杀顺序为：多萝西>托托>狮子>稻草人>铁皮人。期间注意打断多萝西施法。',
},
{
title = 'P2阶段',
desc = '全力输出巫婆，注意躲避龙卷风。',
},
},
role = 'MELEE',
},
{
children = {
{
title = 'P1阶段',
desc = '听从指挥按顺序击杀所有BOSS，推荐击杀顺序为：多萝西>托托>狮子>稻草人>铁皮人。\n注意：控制稻草人法师需要全程对稻草人使用灼烧技能，确保其一直处于燃烧状态下。控制胆小的狮子的术士可以全程恐惧狮子。',
},
{
title = 'P2阶段',
desc = '全力输出巫婆，注意躲避龙卷风。',
},
},
role = 'RANGE',
},
},
desc = '歌剧院有三种BOSS组合，分别为绿野仙踪、小红帽、罗密欧和朱丽叶，每次随机选择一组。绿野仙踪开战时会有4个BOSS，战斗期间多萝茜还会召唤托托，其中多萝茜和托托需要坦克分别拉好，胆小的狮子可以选择术士全程恐惧，稻草人可以让法师全程使用灼烧攻击，令稻草人全程处于迷惑状态，而铁皮人速度会越来越慢，可以风筝他。全部击杀完毕之后进入P2阶段，出现巫婆，注意躲避龙卷风即可。',
},
abilities = {
children = {
{
noCollapse = true,
title = '多萝茜',
children = {
{
desc = '对目标造成大量冰伤害。',
spell = 31012,
},
{
desc = '范围恐惧玩家。',
spell = 31013,
},
{
desc = '召唤野兽托托。',
spell = 31014,
},
},
},
{
noCollapse = true,
title = '胆小的狮子',
children = {
{
desc = '降低目标的护甲值。',
spell = 31042,
},
},
},
{
noCollapse = true,
title = '稻草人',
children = {
{
desc = '猛击目标，使其陷入昏迷。',
spell = 31046,
},
{
desc = '使施法者在被火焰法术击中时陷入困惑。',
spell = 31075,
},
{
desc = '沉默一名玩家，持续4秒。',
spell = 31069,
},
},
},
{
noCollapse = true,
title = '铁皮人',
children = {
{
desc = '对目标及周围多个玩家造成物理伤害。',
spell = 31043,
},
{
desc = '使铁皮人生锈，移动速度降低。',
spell = 31086,
},
},
},
{
noCollapse = true,
title = '巫婆',
children = {
{
desc = '向目标射出一支闪电箭，闪电箭在命中目标后会弹跳至附近目标身上，最多可攻击5个目标，对击中的玩家造成递增的自然伤害。',
spell = 32337,
},
{
desc = '造成伤害并将目标卷上空中，打断目标施法。',
spell = 32334,
},
},
},
},
desc = '歌剧院有三种BOSS组合，分别为绿野仙踪、小红帽、罗密欧和朱丽叶，每次随机选择一组。\n绿野仙踪战斗分为两个阶段，P1开场会有四个BOSS，分别是多萝茜、胆小的狮子、稻草人和铁皮人，战斗期间多萝茜会召唤托托，全部击杀完毕之后进入P2，P2只有一个BOSS巫婆，击杀就结束了战斗。',
},
icon = 1385758,
name = '歌剧院之绿野仙踪',
},
[650] = {
bossId = 650,
summary = {
children = {
{
desc = '主T将BOSS拉在场地中间，被击退后将BOSS拉回原位。二T保持第二仇恨，被击退后立即返回。躲避好洞穴震颤技能，逃离掉落岩石碎片范围。石化碎裂时和周围玩家保持距离。',
role = 'TANK',
},
{
desc = '在BOSS场地外围分散治疗，躲避好洞穴震颤技能，逃离掉落岩石碎片范围。石化碎裂时和周围玩家保持距离。',
role = 'HEALER',
},
{
desc = '最远距离攻击BOSS，被击退后返回原位。躲避好洞穴震颤技能，逃离掉落岩石碎片范围。石化碎裂时和周围玩家保持距离。',
role = 'MELEE',
},
{
desc = '在BOSS场地外围分散站立输出BOSS。躲避好洞穴震颤技能，逃离掉落岩石碎片范围。石化碎裂时和周围玩家保持距离。',
role = 'RANGE',
},
},
desc = '屠龙者格鲁尔是格鲁尔的巢穴的最终BOSS，每过30秒格鲁尔都会增加伤害，体型变大，随着时间的增加战斗会越来越困难，越快结束战斗越轻松。',
},
abilities = {
children = {
{
desc = '每30秒伤害提高15%，体型增大。',
spell = 36300,
},
{
desc = '击退所有玩家，产生戈隆领主之握技能，5秒内减速并石化。',
spell = 33525,
},
{
desc = '粉碎所有石化的玩家，并对周围玩家产生伤害，距离越近受到伤害越大。',
spell = 33654,
},
{
desc = '随机目标区域掉落岩石碎片，对范围内玩家造成伤害并减速。',
spell = 36240,
},
{
desc = '每隔一段时间对第二仇恨玩家释放，造成大量物理伤害。',
spell = 33813,
},
},
desc = '屠龙者格鲁尔会随着时间增加而逐渐变强，越快结束战斗越轻松。',
},
icon = 1378982,
name = '格鲁尔',
},
[658] = {
bossId = 658,
summary = {
children = {
{
desc = '本场战斗埃兰法系技能目标随机，T站房间中间和近战一起分散输出，出水元素的时候T拉住水元素仇恨。战斗期间尽量打断BOSS的常规读条技能，烈焰花环的时候不要移动，魔爆术时迅速跑到房间最边缘躲避奥爆。',
role = 'TANK',
},
{
desc = '房间外围分散站位治疗，远离BOSS，烈焰花环的时候不要移动，魔爆术时迅速跑到房间最边缘躲避奥爆。\n注意：牧师、骑士优先驱散魔法，尤其是在奥爆时要尽量驱散玩家身上的减速效果。',
role = 'HEALER',
},
{
desc = '分散站位输出BOSS，战斗期间尽量打断BOSS的常规读条技能，优先打断火系技能，烈焰花环的时候不要移动，魔爆术时迅速跑到房间最边缘躲避奥爆。出水元素的时候优先击杀水元素。',
role = 'MELEE',
},
{
desc = '房间外围分散站位，远离BOSS，烈焰花环的时候不要移动，魔爆术时迅速跑到房间最边缘躲避奥爆。出水元素的时候优先击杀水元素。\n注意：出现水元素时，术士优先放逐水元素。',
role = 'RANGE',
},
},
desc = '埃兰之影是个纯法系的BOSS，精通三系天赋，除了单体攻击之外，还会释放暴风雪、烈焰花环、魔爆术，暴风雪需要赶紧离开，烈焰花环则不能移动，全体被拉至BOSS身边释放魔爆术时，则需要赶紧逃离BOSS，往房间四处的墙壁跑。而在BOSS血量降至40%时还会召唤4个水元素，优先击杀水元素之后再输出BOSS即可。',
},
abilities = {
children = {
{
noCollapse = true,
title = '常规',
children = {
{
title = '冰系法术',
children = {
{
desc = '对玩家造成冰霜伤害并减速。',
spell = 29954,
},
{
desc = '在玩家周围形成冰链，将目标定在原地，持续10秒。',
spell = 29991,
},
},
},
{
title = '火系法术',
children = {
{
desc = '对玩家造成火焰伤害。',
spell = 29953,
},
{
desc = '对面前锥形范围内玩家造成火焰伤害，并陷入混乱状态。',
spell = 35250,
},
},
},
{
title = '奥系法术',
children = {
{
desc = '对玩家射出魔法箭，造成奥术伤害。',
spell = 33419,
},
{
desc = '使玩家攻击速度和移动速度降低，持续10秒。',
spell = 29990,
},
},
},
{
desc = '打断10码内玩家施法。',
spell = 31596,
},
},
},
{
noCollapse = true,
title = '特殊',
children = {
{
desc = '房间随机范围下暴风雪，造成冰霜伤害并减速，暴风雪会绕场缓慢移动。',
spell = 29969,
},
{
desc = '随机玩家脚下出现火圈，任何出入火圈的移动都会造成爆炸效果，击飞当前玩家，全团受到大量火焰伤害。',
spell = 29946,
},
{
desc = 'BOSS使用磁力牵引将所有玩家传送至场地中间，同时释放群体减速，之后会开始读条释放奥爆，10秒后对所有30码范围内玩家造成过量奥术伤害。',
spell = 29973,
},
{
desc = 'BOSS血量降至40%时会在房间周围召唤出4个精英水元素。',
spell = 29962,
},
{
desc = 'BOSS法力值降低至20%时，会将所有玩家变羊，期间回复法力值，10秒后释放群体火球，对所有玩家造成大量火焰伤害。',
spell = 29848,
},
},
},
},
desc = '埃兰是个法系BOSS，精通三系天赋，无仇恨，攻击目标随机。埃兰常规技能可以打断，特殊技能无法打断。15分钟后未结束战斗会团灭。',
},
icon = 1379012,
name = '埃兰之影',
},
[1118] = {
bossId = 1118,
name = '帕奇维克',
zone = 4,
abilities = {
children = {
{
title = '普通物理攻击',
desc = '对主T造成2000伤害。',
},
{
title = '仇恨打击',
desc = '对近战范围内血量最高的人造成5500-8000的伤害。',
},
},
desc = '7分钟后BOSS狂暴，狂暴后秒杀任何职业。',
},
url = 'https://www.bilibili.com/video/BV1dr4y1w7gW?p=7',
icon = 1379005,
summary = {
children = {
{
desc = '主T：开怪，确保第一个进入BOSS仇恨列表。\n副T：确保血量高于其他团员（均高于主T），血量最高为2T，第二为3T，第三为4T。全程保持石盾药水、盾牌格挡、破甲、挫志怒吼。',
role = 'TANK',
},
{
desc = '主T治疗：开打后全程不间断的读大治疗术，大蓝和符文一到时间就喝。\n2T治疗：开打后全程不间断的读大治疗术，大蓝和符文一到时间就喝。\n3T治疗：2T掉血就读大治疗术，2T满血就打断读条，大蓝和符文一到时间就喝。\n4T治疗：2T和3T都掉血就读大治疗术，2T和3T有一个满血的就打断读条等待。\n注意：为了省蓝，主T治疗可以选择加1800左右血量的治疗法术，副T治疗可以选择加2500左右血量的治疗法术。',
role = 'HEALER',
},
{
desc = '注意仇恨，全力输出。',
role = 'MELEE',
},
{
desc = '注意仇恨，全力输出。',
role = 'RANGE',
},
},
},
},
[714] = {
bossId = 714,
abilities = {
children = {
{
desc = '对目标造成700点自然伤害，可叠加，最多4层。',
spell = 29653,
},
{
desc = '使目标陷入沉睡，如果睡眠被驱散，将受到4000点自然伤害。',
spell = 26180,
},
{
desc = 'BOSS攻击间隔缩短，持续8秒。',
spell = 26051,
},
{
desc = '对目标方向释放，每2秒造成750点伤害，具有沉默效果，不可驱散。',
spell = 26053,
},
{
desc = '使目标中毒，每2秒受到一次自然伤害，持续30秒。',
spell = 26050,
},
{
desc = '当BOSS血量降至30%，会不断朝最近的15个目标释放群体毒箭。',
spell = 26068,
},
},
},
name = '哈霍兰公主',
summary = {
children = {
{
desc = '需要2个坦克。\n1.主T拉住BOSS，副T在主T叠加3层毒之后接手BOSS，直至主T消除debuff后接回去，如此循环。\n2.BOSS血量降至30%以下后，当前T注意开破斧、盾墙等保命技能。',
role = 'TANK',
},
{
desc = '以主T位置为中心点呈伞型散开，站在远程和近战中间，人与人之间保持一定距离。\n1.分配的德鲁伊注意全程驱散T的睡眠。\n2.BOSS血量30%之前刷好全团的血，不驱散。\n3.BOSS血量30%后注意全团血量，尤其是近战，需要牧师刷群体治疗术。',
role = 'HEALER',
},
{
desc = '1.穿上自然抗装备，围着BOSS和主T站位输出。\n2.BOSS血量30%后注意喝自然抗药水保命，开爆发技能输出。',
role = 'MELEE',
},
{
desc = '1.以主T位置为中心点呈伞型散开，人与人之间保持一定距离。\n2.站最外围，最远距离输出。\n3.BOSS血量30%后开爆发技能输出。\n4.LR开启自然抗光环，确保近战都能吃到，在BOSS激怒情况下使用宁神射击。',
role = 'RANGE',
},
},
},
icon = 1385761,
desc = '哈霍兰公主需要近战拥有一定的自然抗装备来当沙包，确保BOSS狂暴后可以挡住毒箭不射向大团。',
},
[603] = {
bossId = 603,
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '按照指挥分配拉好两侧不断出现的精英小怪。',
},
{
expanded = false,
role = 'MELEE',
children = {
},
desc = 'P1阶段输出台子上的魔导师，P2阶段时全力输出阿卡玛之影。',
},
{
role = 'RANGE',
expanded = false,
desc = 'P1阶段按照指挥分配输出台子上的魔导师或者是两侧不断刷新的精英小怪，P2阶段时全力输出阿卡玛之影。',
},
{
role = 'HEALER',
expanded = false,
desc = '按照指挥分配站位治疗队友，P2时注意拉小怪的坦克血量。',
},
},
desc = '阿卡玛之影战斗需要和阿卡玛对话开启，按照指挥分配击杀三方小怪，禁锢阿卡玛之影的小怪减少至3只以下之后，阿卡玛之影会逐渐向阿卡玛移动，在阿卡玛倒下之前击杀阿卡玛之影即可获得战斗胜利。',
},
name = '阿卡玛之影',
icon = '1379011',
abilities = {
children = {
{
title = 'P1阶段',
expanded = true,
noCollapse = false,
children = {
{
children = {
{
spell = '40520',
title = '链接之魂',
noCollapse = false,
expanded = false,
desc = '使阿卡玛之影的移动速度降低。',
},
},
noCollapse = false,
title = '灰舌魔导师',
expanded = true,
},
{
children = {
{
spell = '40520',
title = '链接之魂',
noCollapse = false,
expanded = false,
desc = '使阿卡玛之影的移动速度降低。',
},
},
noCollapse = false,
title = '灰舌巫师',
expanded = true,
},
{
children = {
{
spell = '42025',
title = '灵魂治愈',
noCollapse = false,
expanded = false,
desc = '持续性恢复法术。',
},
{
spell = '42027',
title = '治疗链',
noCollapse = false,
expanded = false,
desc = '治疗目标，且会影响周围盟友，最多5个目标。',
},
{
spell = '42317',
title = '灵魂治疗',
noCollapse = false,
expanded = false,
desc = '使用神圣魔法治疗盟友。',
},
},
noCollapse = false,
title = '灰舌缚灵者',
expanded = true,
},
{
children = {
{
spell = '41177',
title = '刺骨',
noCollapse = false,
expanded = false,
desc = '对目标造成物理伤害。',
},
{
spell = '41978',
title = '衰弱之毒',
noCollapse = false,
expanded = false,
desc = '使目标中毒，攻击间隔和施法时间延长，并造成自然伤害。',
},
},
noCollapse = false,
title = '灰舌盗贼',
expanded = true,
},
{
children = {
{
spell = '41178',
title = '衰弱打击',
noCollapse = false,
expanded = false,
desc = '对目标造成武器伤害。',
},
{
spell = '41180',
title = '盾击',
noCollapse = false,
expanded = false,
desc = '会使用盾牌重击目标打断目标法术。',
},
{
spell = '41975',
title = '英勇打击',
noCollapse = false,
expanded = false,
desc = '使近战攻击造成伤害提高，且造成大量威胁值。',
},
},
noCollapse = false,
title = '灰舌防御者',
expanded = true,
},
{
children = {
{
spell = '42023',
title = '火焰之雨',
noCollapse = false,
expanded = false,
desc = '对随机区域中的敌人施放火雨，造成持续的火焰伤害。',
},
{
spell = '42024',
title = '闪电箭',
noCollapse = false,
expanded = false,
desc = '使用闪电箭对目标造成自然伤害。',
},
},
noCollapse = false,
title = '灰舌元素师',
expanded = true,
},
},
desc = '需要击败禁锢阿卡玛之影的灰舌导魔师和灰舌巫师，使得阿卡玛之影向阿卡玛移动。期间场地两侧还会刷新精英怪，各种怪物技能如下：',
},
{
title = 'P2阶段',
expanded = true,
noCollapse = false,
children = {
{
spell = '40874',
title = '毁灭之毒',
noCollapse = false,
expanded = false,
desc = '使目标中毒，使其受到的伤害提高。',
},
{
spell = '39945',
title = '闪电链',
noCollapse = false,
expanded = false,
desc = '射出一支闪电箭，在击中目标后继续攻击他周围最近的敌人，每次击中都会造成更高的自然伤害。',
},
},
desc = '在阿卡玛之影到达阿卡玛身边时开启，阿卡玛之影技能如下',
},
},
desc = '阿卡玛之影战斗分为两个阶段，第一阶段需要击败禁锢阿卡玛之影的几个精英，让阿卡玛之影来到阿卡玛身边，之后开启第二阶段，击败阿卡玛之影拯救阿卡玛，以赢得战斗的胜利。',
},
},
[619] = {
bossId = 619,
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '主坦拉住BOSS，副坦需要拉住出现的地狱火，远离BOSS的位置等待远程集火击杀。',
},
{
role = 'HEALER',
expanded = false,
desc = '所有治疗完全分散，根据指挥分配站位。\n注意中地狱火的玩家和坦克的血量。\n',
},
{
role = 'MELEE',
expanded = false,
desc = '在BOSS身后输出，随时注意自身血量，必要时候需要使用治疗药水、绷带等回复自身生命值。',
},
{
role = 'RANGE',
expanded = false,
desc = '根据指挥分配站位输出，远离出现的地狱火，优先击杀地狱火。',
},
},
desc = '安纳塞隆整场战斗治疗需要完全分散，避免多位治疗中腐臭蜂群，战斗期间出现的地狱火需要副坦拉离BOSS并优先集火击杀，之后继续输出BOSS，循环直至BOSS倒下。',
},
name = '安纳塞隆',
icon = '1385714',
abilities = {
children = {
{
spell = '31306',
title = '腐臭蜂群',
noCollapse = false,
expanded = false,
desc = '对一个目标方向施放扇形能量波，该方向区域内的所有玩家被施加一个debuff，使其治疗效果大幅度降低。',
},
{
spell = '31299',
title = '召唤地狱火',
noCollapse = false,
expanded = false,
desc = '选中目标，并在目标位置召唤地狱火，地狱火带有献祭光环，会对近战范围内的玩家造成持续火焰伤害。',
},
{
spell = '31298',
title = '催眠术',
noCollapse = false,
expanded = false,
desc = '随机点名一个目标使其昏睡，该效果无法被驱散。',
},
{
spell = '38196',
title = '吸血光环',
noCollapse = false,
expanded = false,
desc = '被动效果，攻击目标会根据伤害数值为自身恢复血量。且该光环会作用在被召唤的地狱火身上。',
},
},
desc = '安纳塞隆战斗前同样需要清理八波的小怪，需要注意新增小怪女妖， BOSS战时会出现地狱火，需要副坦拉住并集火击杀，同样注意吉安娜不能死亡。',
},
},
[1119] = {
bossId = 1119,
name = '萨菲隆',
zone = 5,
abilities = {
children = {
{
desc = '每秒造成600冰霜伤害。',
spell = 28531,
},
{
desc = '将随机目标禁锢在寒冰之中，使其陷入昏迷且对目标周围玩家造成大量冰霜伤害。',
spell = 28522,
},
{
desc = '对玩家造成2W多冰霜伤害，未躲避在冰块后的会被直接秒杀。',
spell = 28524,
},
{
title = '扫尾',
desc = '对位于BOSS身后锥形范围内玩家造成物理伤害，并击退。',
},
{
desc = '对随机玩家释放，每3秒造成大量暗影伤害且回复BOSS血量，可驱散。',
spell = 28542,
},
{
desc = '对目标和他周围玩家造成大量物理伤害。',
spell = 19983,
},
{
desc = '随机释放，且会小范围的移动，暴风雪范围内玩家会每2秒受到大量冰霜伤害且降低移动速度。',
spell = 28560,
},
},
desc = '由于萨菲隆具有冰霜光环，会持续的造成冰霜伤害，因此需要穿上冰霜抗性装备，降低伤害数值。而每隔60秒，BOSS会上天，在空中持续30秒。空中阶段时，每隔5秒会将随机一名玩家冻成冰块，且对冰块周围玩家造成大量的冰霜伤害。冰冻5名玩家后，会对场地正中间释放冰霜吐息，需要在冰块后躲避伤害，否则会被秒杀，吐息结束后冰龙回到地面。',
},
url = 'https://www.bilibili.com/video/BV1dr4y1w7gW?p=14',
icon = 1379010,
summary = {
children = {
{
desc = '1.萨菲隆只需要主T，开打后将BOSS拉在原地，且BOSS背对入口。\n2.躲避好暴风雪。\n3.BOSS上天后分散站位，冰霜吐息时第一时间到冰块后躲避。',
role = 'TANK',
},
{
desc = '1.根据指挥分配站位，在BOSS两侧分散治疗。\n2.躲好暴风雪。\n3.BOSS上天后分散站位，冰霜吐息时第一时间到冰块后躲避。\n注意：德鲁伊第一时间驱散好诅咒。',
role = 'HEALER',
},
{
desc = '1.根据指挥分配站位，在BOSS两侧输出BOSS。\n2.躲好暴风雪。\n3.BOSS上天后分散站位，冰霜吐息时第一时间到冰块后躲避。',
role = 'MELEE',
},
{
desc = '1.根据指挥分配站位，在BOSS两侧分散输出BOSS。\n2.躲好暴风雪。\n3.BOSS上天后分散站位继续输出BOSS，冰霜吐息时第一时间到冰块后躲避。\n注意：法师第一时间驱散好诅咒。',
role = 'RANGE',
},
},
},
},
[651] = {
bossId = 651,
summary = {
role = 'HEALER',
children = {
{
children = {
{
title = 'P1阶段',
desc = '按照指挥分配坦住5个地狱火导魔者，每个地狱火导魔者保持距离，打断暗影箭雨和黑暗治疗。',
},
{
title = 'P2阶段',
desc = '主T将BOSS拉至靠墙，其余坦克继续拉好地狱火导魔者并打断，直至全部击杀完毕。',
},
{
title = 'P3阶段',
desc = '主T拉住BOSS，其余坦克输出，期间注意躲避地面燃烧及天上掉落碎片。\n注意：BOSS释放火焰新星前，指挥分配好的玩家提前站位，技能释放时点击方盒打断BOSS技能。',
},
},
role = 'TANK',
},
{
children = {
{
title = 'P1阶段',
desc = '按指挥分配治疗好坦克，期间注意躲避地狱火。\n注意：BOSS释放火焰新星前，指挥分配好的玩家提前站位，技能释放时点击方盒打断BOSS技能。',
},
{
title = 'P2阶段',
desc = '治疗坦克，躲避地狱火和地面燃烧，敲击期间注意坦克血量，火焰新星期间治疗好点击方盒玩家。\n注意：BOSS释放火焰新星前，指挥分配好的玩家提前站位，技能释放时点击方盒打断BOSS技能。',
},
{
title = 'P3阶段',
desc = '优先治疗坦克，然后再恢复其他队友血量，期间躲避地面燃烧和天上掉落碎片，敲击期间注意坦克血量，火焰新星期间治疗好点击方盒玩家。\n注意：BOSS释放火焰新星前，指挥分配好的玩家提前站位，技能释放时点击方盒打断BOSS技能。',
},
},
role = 'HEALER',
},
{
children = {
{
title = 'P1阶段',
desc = '按顺序击杀地狱火导魔者，打断暗影箭雨和黑暗治疗。\n注意：BOSS释放火焰新星前，指挥分配好的玩家提前站位，技能释放时点击方盒打断BOSS技能。',
},
{
title = 'P2阶段',
desc = '优先击杀地狱火导魔者，期间注意打断，然后输出BOSS，注意躲避地面燃烧。\n注意：BOSS释放火焰新星前，指挥分配好的玩家提前站位，技能释放时点击方盒打断BOSS技能。',
},
{
title = 'P3阶段',
desc = '输出BOSS，期间注意躲避地面燃烧及天上掉落碎片。\n注意：BOSS释放火焰新星前，指挥分配好的玩家提前站位，技能释放时点击方盒打断BOSS技能。',
},
},
role = 'MELEE',
},
{
children = {
{
title = 'P1阶段',
desc = '按顺序击杀地狱火导魔者，打断暗影箭雨和黑暗治疗。\n注意：术士需要给每个地狱火导魔者上好语言诅咒，优先放逐或者恐惧地狱火。法师在敲击技能期间注意打断。BOSS释放火焰新星前，指挥分配好的玩家提前站位，技能释放时点击方盒打断BOSS技能。',
},
{
title = 'P2阶段',
desc = '优先击杀地狱火导魔者，注意打断，然后分散站位输出BOSS，注意躲避地面燃烧。\n注意：术士需要给每个地狱火导魔者上好语言诅咒，优先放逐或者恐惧地狱火。法师在敲击技能期间注意打断。BOSS释放火焰新星前，指挥分配好的玩家提前站位，技能释放时点击方盒打断BOSS技能。',
},
{
title = 'P3阶段',
desc = '输出BOSS，期间注意躲避地面燃烧及天上掉落碎片。 \n注意：术士需要给每个地狱火导魔者上好语言诅咒，优先放逐或者恐惧地狱火。法师在敲击技能期间注意打断。BOSS释放火焰新星前，指挥分配好的玩家提前站位，技能释放时点击方盒打断BOSS技能。',
},
},
role = 'RANGE',
},
},
desc = '玛瑟里顿的巢穴只有玛瑟里顿一个BOSS，玛瑟里顿处于房间中央，一开始是处于被五个地狱火导魔者监禁的状态，战斗开始就需要先击杀完5个导魔者，但是在战斗开始的2分钟后玛瑟里顿就会被激活，这时就需要优先击杀剩余的导魔者之后再去输出玛瑟里顿。玛瑟里顿最主要的技能是火焰新星，是一个全屏的火焰伤害，需要提前安排好五个人，在技能释放前到魔导者站的位置处点击方盒，五个方盒同时被激活即可打断技能。',
},
abilities = {
children = {
{
noCollapse = true,
title = '地狱火导魔者',
children = {
{
desc = '向附近玩家射出多支暗影箭，造成暗影伤害。',
spell = 25586,
},
{
desc = '使用黑暗魔法为一名盟友恢复生命值。',
spell = 30528,
},
{
desc = '周期性在玩家身边召唤地狱火，地狱火坠落时对周围玩家造成火焰伤害，地狱火会对目标释放火焰冲击造成火焰伤害。每个导魔者同一时间最多拥有2个地狱火，每个地狱火召唤后会存在1分钟。',
spell = 23426,
},
},
},
{
noCollapse = true,
title = '玛瑟里顿',
children = {
{
desc = '对前方范围内玩家造成物理伤害。',
spell = 845,
},
{
desc = '房间内随机地点释放火球，造成地面火焰效果，被火焰烧到玩家将受到火焰伤害并进入恐慌状态，持续时间内会周期性灼烧周围队友。',
spell = 16805,
},
{
desc = '每秒将房间内所有玩家震退一次，持续5秒。',
spell = 30658,
},
{
desc = '引导型法术，每2秒对房间内所有玩家造成大量火焰伤害，持续10秒。5个玩家同时点击五个方位上的方盒，使得玛瑟里顿身上出现5条控制线，即可打断技能。点击方盒后会有持续3分钟的心灵疲惫debuff，期间无法再点击方盒。',
spell = 30616,
},
},
},
},
desc = 'BOSS战分为三个阶段：P1阶段只持续2分钟，期间玛瑟里顿不参与战斗，需要先击杀房间内的5个地狱火导魔者。2分钟后进入P2，玛瑟里顿重获自由加入战斗。玛瑟里顿血量到30%时进入P3，房间墙壁将碎裂，对所有玩家造成大量物理伤害，P3期间玛瑟里顿拥有所有P2时期的技能，且天花板也会不时掉落碎片，需要躲避。',
},
icon = 1378996,
name = '玛瑟里顿的巢穴',
},
[659] = {
bossId = 659,
summary = {
children = {
{
role = 'TANK',
children = {
{
title = 'P1阶段',
desc = '主T将BOSS拉至场地中间，红光出现时注意调整自身位置，让红光射到主T身上。红光叠加层数过高时，听指挥让其他人接替红光。',
},
{
title = 'P2阶段',
desc = 'T拉住BOSS仇恨即可。',
},
{
title = '第二次P1',
desc = '副T将BOSS拉住，并挡住红色光线。红光叠加层数过高时，可听指挥让其他人接替红光。',
},
{
title = '第二次P2',
desc = 'T拉住BOSS仇恨即可。',
},
},
footDesc = '之后一直重复以上的阶段，主T和副T轮流挡住一个阶段的红光。阶段转换时仇恨会清空，第一时间拉住BOSS仇恨。',
},
{
role = 'HEALER',
children = {
{
title = 'P1阶段',
desc = '治疗全团，注意挡住蓝色光线的远程血量，躲避脚下黑圈。指挥分配的两名治疗提前站位，接替挡住绿色光线。',
},
{
title = 'P2阶段',
desc = '分散站位，治疗全团，确保全团血量在5000以上。',
},
},
footDesc = '两阶段循环直至BOSS倒下。',
},
{
role = 'MELEE',
children = {
{
title = 'P1阶段',
desc = '输出BOSS，注意躲避脚下黑圈。',
},
{
title = 'P2阶段',
desc = '分散最远距离输出BOSS。确保自己血量在5000以上。',
},
},
footDesc = '两阶段循环直至BOSS倒下，阶段转换的时候注意停手。',
},
{
role = 'RANGE',
children = {
{
title = 'P1阶段',
desc = '输出BOSS，注意躲避脚下黑圈。指挥分配的两名远程提前站位，接替挡住蓝色光线。',
},
{
title = 'P2阶段',
desc = '分散站位输出BOSS。不要超过治疗范围，确保自己血量在5000以上。',
},
},
footDesc = '两阶段循环直至BOSS倒下，阶段转换的时候注意停手。',
},
},
desc = '虚空幽龙战斗基本分为两个阶段，P1为虚空门阶段，P2是放逐阶段。P1的时候BOSS房间三个角落会出现三个虚空门，释放不同颜色的光线，这些光线射到BOSS身上会增强BOSS，所以需要提前分配好队友挡住光线。P2放逐阶段BOSS无法移动，会固定在房间中央，随机选择目标释放范围性的吐息，P2阶段只持续30秒就又进入P1阶段，两个阶段不断交替直至BOSS倒下。',
},
abilities = {
children = {
{
noCollapse = true,
title = '虚空幽龙',
children = {
{
desc = '每5秒对所有人造成一次暗影伤害。',
spell = 30522,
},
{
desc = '随机玩家脚下召唤一个虚空领域，对站在范围内的所有玩家造成暗影伤害',
spell = 28863,
},
},
},
{
children = {
{
desc = '硬化虚空幽龙的外壳，使其承受的伤害减少。玩家挡住光线会获得坚韧buff，减少生命值上限并成为BOSS仇恨目标，每次叠加玩家都会自动回满生命值。',
spell = 30466,
},
{
desc = '每秒为虚空幽龙恢复生命值。玩家挡住光线会获得平静buff，减少法力值上限和技能消耗，还会提升治疗效果。',
spell = 30467,
},
{
desc = '使虚空幽龙伤害提高。玩家挡住光线会获得统御buff，提升法术伤害。',
spell = 30468,
},
},
noCollapse = true,
title = 'P1阶段',
desc = '三个虚空门会射出三种不同的光线，每种光线射在玩家身上均会产生一个20秒的buff，buff可叠加并有各自不同的效果，buff消失后会产生“虚空疲劳“，90秒内无法再获得加成的buff。',
},
{
noCollapse = true,
title = 'P2阶段',
children = {
{
desc = '对目标方向锥形范围喷吐，范围内玩家都会受到大量伤害并被击退。',
spell = 38523,
},
},
},
},
desc = '虚空幽龙整场战斗可以分成两个阶段，P1为虚空门发射光线阶段，持续60秒左右，就会进入下一个阶段，P2虚空幽龙会处于放逐状态，无法移动，持续30秒之后又会重新进入P1，两个阶段不断交替直至BOSS倒下。9分钟内未结束战斗，BOSS伤害会大幅度增加导致团灭。',
},
icon = 1379002,
name = '虚空幽龙',
},
[1120] = {
bossId = 1120,
name = '塔迪乌斯',
zone = 4,
abilities = {
children = {
{
title = '斯塔拉格',
children = {
{
title = '能量激流',
expanded = true,
desc = 'BOSS攻击速度提高，持续10秒。',
},
{
title = '电磁牵引',
expanded = true,
desc = '每隔一段时间，斯塔拉格和费尔根同时使用电磁牵引，将对方的第一仇恨目标拖至自己面前，并将仇恨值交换。',
},
},
},
{
title = '费尔根',
children = {
{
title = '静电领域',
expanded = true,
desc = '每秒对自身平台上玩家造成自然伤害并吸收法力值。',
},
{
title = '电磁牵引',
expanded = true,
desc = '每隔一段时间，费尔根和斯塔拉格同时使用电磁牵引，将对方的第一仇恨目标拖至自己面前，并将仇恨值交换。',
},
},
},
{
title = '塔迪乌斯',
children = {
{
title = '极性转化',
expanded = true,
desc = '随机对所有玩家释放正能量电荷或者负能量电荷，相同电荷玩家互相靠近时，每次攻击所造成的伤害会提高。不同电荷玩家相互靠近时，会对附件所有玩家造成伤害。',
},
{
title = '闪电链',
expanded = true,
desc = '对当前目标释放，击中后继续攻击附近玩家，最多攻击5个目标。',
},
{
title = '狂暴',
expanded = true,
desc = '5分钟内没有击杀则BOSS狂暴。',
},
},
},
},
desc = '塔迪乌斯战斗分为2个阶段，第一阶段需要先同时击杀两边小平台的小boss斯塔拉格和费尔根，然后在15秒后BOSS激活，所有人需要跳至BOSS所在平台才能参与战斗。',
},
url = 'https://www.bilibili.com/video/BV1dr4y1w7gW?p=10',
icon = 1379019,
summary = {
children = {
{
title = '小BOSS阶段',
children = {
{
desc = '1.每个平台一个T，拉好当前小BOSS仇恨。\n2.被抛至另一平台后迅速拉好当前BOSS，循环直至小BOSS被同时击杀。',
role = 'TANK',
},
{
desc = '1.按照分配前往2个小BOSS平台，最远距离治疗。\n2.若T被交换位置，则BOSS的当前T。\n3.注意：电荷变换时打断读条，第一时间换位。',
role = 'HEALER',
},
{
desc = '1.前往右边费尔根平台，输出费尔根。\n2.注意费尔根血量，确保和斯塔拉格同时死亡。',
role = 'MELEE',
},
{
desc = '1.前往左边斯塔拉格平台，最远距离输出斯塔拉格。\n2.注意斯塔拉格血量，确保和费尔根同时死亡。',
role = 'RANGE',
},
},
},
{
title = '塔迪乌斯阶段',
children = {
{
desc = '1.跳上BOSS所在平台后，主T站在BOSS一侧等待BOSS激活。\n2.BOSS激活后拉住仇恨。\n3.BOSS释放电荷时第一时间查看身上电荷标记，若为正能量电荷（加号）则原地不动，若为负能量电荷（减号），需跑动至BOSS另一边，和其他负电荷玩家一起集中站位。每一次电荷变换均要注意，电荷仍旧为正极或者负极就原地不动，若正极变为负极，或者负极变为正极，就跑至BOSS对面，确保和所有同样电荷玩家站在一起。循环直至BOSS倒下。',
role = 'TANK',
},
{
desc = '1.跳上BOSS所在平台后，和主T站在一起等待BOSS激活。\n2.根据指挥分配看好T和自身队伍血量。\n3.BOSS释放电荷时第一时间查看身上电荷标记，若为正能量电荷（加号）则原地不动，若为负能量电荷（减号），需跑动至BOSS另一边，和其他负电荷玩家一起集中站位。每一次电荷变换均要注意，电荷仍旧为正极或者负极就原地不动，若正极变为负极，或者负极变为正极，就跑至BOSS对面，确保和所有同样电荷玩家站在一起。循环直至BOSS倒下。\n注意：电荷变换时打断读条，第一时间换位。',
role = 'HEALER',
},
{
desc = '1.跳上BOSS所在平台后，和主T站在一起等待BOSS激活，激活后输出BOSS。\n2.BOSS释放电荷时第一时间查看身上电荷标记，若为正能量电荷（加号）则原地不动，若为负能量电荷（减号），需跑动至BOSS另一边，和其他负电荷玩家一起集中站位。每一次电荷变换均要注意，电荷仍旧为正极或者负极就原地不动，若正极变为负极，或者负极变为正极，就跑至BOSS对面，确保和所有同样电荷玩家站在一起。循环直至BOSS倒下。',
role = 'MELEE',
},
{
desc = '1.跳上BOSS所在平台后，和主T站在一起等待BOSS激活，激活后输出BOSS。\n2.BOSS释放电荷时第一时间查看身上电荷标记，若为正能量电荷（加号）则原地不动，若为负能量电荷（减号），需跑动至BOSS另一边，和其他负电荷玩家一起集中站位。每一次电荷变换均要注意，电荷仍旧为正极或者负极就原地不动，若正极变为负极，或者负极变为正极，就跑至BOSS对面，确保和所有同样电荷玩家站在一起。循环直至BOSS倒下。\n3.注意：电荷变换时打断读条，第一时间换位。',
role = 'RANGE',
},
},
},
},
},
},
[715] = {
bossId = 715,
abilities = {
children = {
{
noCollapse = true,
title = '维克尼拉斯大帝（剑皇）',
children = {
{
desc = '对目标造成3000左右伤害，并将其击退。',
spell = 26007,
},
{
desc = '对当前目标释放，造成大量物理伤害并使其防御值降低，持续6秒。',
spell = 26613,
},
{
desc = '随机将身边的甲虫变大，甲虫生命值和伤害提高，并变为主动攻击。',
spell = 802,
},
},
},
{
noCollapse = true,
title = '维克洛尔大帝（魔皇）',
children = {
{
desc = '对当前目标释放，造成3000左右暗影伤害。',
spell = 26006,
},
{
desc = '当有人近身时，对10码范围内所有玩家造成3000左右奥术伤害，击退并减速。',
spell = 568,
},
{
desc = '随机对某一区域释放，减速并造成1300左右冰霜伤害。',
spell = 26607,
},
{
desc = '使身边的甲虫在3秒内爆炸，对甲虫周围的玩家造成大量伤害。',
spell = 804,
},
},
},
},
},
name = '双子皇帝',
summary = {
children = {
{
role = 'TANK',
children = {
{
title = '开怪时',
expanded = true,
desc = '1.左边术士T开维克洛尔大帝（魔皇），将BOSS拉到指定位置后站在BOSS10码外使用技能拉住仇恨。\n2.右边战士T拉维克尼拉斯大帝（剑皇），拉到指定位置后靠墙站。',
},
{
title = '进入循环后',
expanded = true,
desc = '1.战士T接手传送过来的剑皇，拉到指定位置后靠墙站。\n2.术士T接手传送过来的魔皇，站在BOSS10码外使用技能拉住仇恨。\n3.传送后，在术士T没有拉到魔皇仇恨之前，战士T需要与魔皇保持10码距离。',
},
},
desc = '每个BOSS都需要一个战士T和一个高暗抗术士T。副T拉好维克尼拉斯大帝（剑皇）边上变大的甲虫。',
},
{
desc = '1.按照指挥分配站好左右两边，最远距离加好坦克，呈伞形分散站位。\n2.维克洛尔大帝（剑皇）时，过量治疗好当前战士T。\n3.维克尼拉斯大帝（魔皇）时，确保战士T血量后，过量治疗好术士T。\n4.注意躲开爆炸虫和暴风雪。',
role = 'HEALER',
},
{
desc = '1.BOSS全程战斗不使用任何的群攻技能。\n2.全程对着维克尼拉斯大帝（剑皇）输出，在两个BOSS传送前跑向对面，确保远离维克洛尔大帝（魔皇）。\n3.跑动过程中注意躲开爆炸虫和暴风雪。',
role = 'MELEE',
},
{
desc = '1.BOSS全程战斗不使用任何的群攻技能。\n2.优先击杀维克洛尔大帝（剑皇）边上变大，并为主动攻击的甲虫。\n3.空余时间可最远距离对维克尼拉斯大帝（魔皇）输出，传送前停止攻击。\n4.跑动过程中注意躲开爆炸虫和暴风雪。\n5.若有玩家引到黄色小甲虫，需要远程帮助清理。',
role = 'RANGE',
},
},
},
icon = 1390437,
desc = '两个BOSS共享生命值，靠近60码内就会互相治疗，间隔大约30秒会互换位置。维克尼拉斯大帝免疫魔法伤害，维克洛尔大帝免疫物理伤害。',
},
[604] = {
bossId = 604,
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '本场战斗只需一个坦克，并将BOSS拉在原地即可。',
},
{
expanded = false,
role = 'MELEE',
children = {
},
desc = '跑到BOSS所在位置的后面去输出BOSS，中点名后跑向大门的角落边等待变身，击杀构造体后返回继续输出，变身后技能按键顺序可以参考以下内容：\n1.变身后立即施放灵魂箭雨对构造体造成群体伤害\n2.施放灵魂锁链冰住阴暗构造体\n3.使用灵魂长枪减速构造体，期间不断切换目标，边打边跑向大团\n4.灵魂锁链和灵魂箭雨冷却好了就用，继续输出即可消灭所有构造体\n5.消灭构造体之后若还有剩余时间可以用灵魂打击输出BOSS，直到引导结束死亡',
},
{
expanded = false,
role = 'RANGE',
children = {
},
desc = '跑到BOSS所在位置的后面去输出BOSS，术士需要在战斗中按照指挥要求绑定灵魂石。\n中点名后跑向大门的角落边等待变身，击杀构造体后返回继续输出，变身后技能按键顺序可以参考以下内容：\n1.变身后立即施放灵魂箭雨对构造体造成群体伤害\n2.施放灵魂锁链冰住阴暗构造体\n3.使用灵魂长枪减速构造体，期间不断切换目标\n4.灵魂锁链和灵魂箭雨冷却好了就用，继续输出即可消灭所有构造体\n5.消灭构造体之后若还有剩余时间可以用灵魂打击输出BOSS，直到引导结束死亡\n',
},
{
expanded = false,
role = 'HEALER',
children = {
},
desc = '站到BOSS所在位置后面按指挥要求治疗全团，特别注意中技能的玩家，优先驱散烧尽。\n中点名后跑向大门的角落边等待变身，击杀构造体后返回继续输出，变身后技能按键顺序可以参考以下内容：\n1.变身后立即施放灵魂箭雨对构造体造成群体伤害\n2.施放灵魂锁链冰住阴暗构造体\n3.使用灵魂长枪减速构造体，期间不断切换目标，边打边跑向大团\n4.灵魂锁链和灵魂箭雨冷却好了就用，继续输出即可消灭所有构造体\n5.消灭构造体之后若还有剩余时间可以用灵魂打击输出BOSS，直到引导结束死亡\n',
},
},
desc = '塔隆·血魔整场战斗只有一个阶段，战斗开始后会点名玩家，在一定时间后该玩家将被杀死变成复仇之灵，然后会刷新只能由复仇之灵击杀的阴暗构造体，变身的玩家需要使用复仇之灵技能击杀构造体，防止它们靠近大团。',
},
name = '塔隆·血魔',
icon = '1379018',
abilities = {
children = {
{
spell = '40251',
title = '死亡之影',
expanded = true,
noCollapse = false,
children = {
{
spell = '40326',
title = '阴暗构造体',
noCollapse = false,
expanded = true,
children = {
{
spell = '40327',
title = '萎缩',
noCollapse = false,
expanded = false,
desc = '对目标造成伤害并降低攻击速度和施法速度。',
},
{
spell = '40334',
title = '暗影打击',
noCollapse = false,
expanded = false,
desc = '每次攻击都会造成暗影伤害。',
},
},
},
{
spell = '27616',
title = '复仇之灵',
expanded = true,
noCollapse = false,
children = {
{
spell = '40325',
title = '灵魂打击',
noCollapse = false,
expanded = false,
desc = '削弱目标，使其所能造成的伤害降低。',
},
{
spell = '40157',
title = '灵魂长枪',
noCollapse = false,
expanded = false,
desc = '对目标释放强大的冲击波，造成大量伤害，并降低移动速度。只能对阴暗生物使用。',
},
{
spell = '40175',
title = '灵魂锁链',
noCollapse = false,
expanded = false,
desc = '束缚附近的目标，使它们在短时间内无法行动。只能对阴暗生物使用。',
},
{
spell = '40314',
title = '灵魂箭雨',
noCollapse = false,
expanded = false,
desc = '释放箭雨，对范围内的所有目标造成大量伤害。只能对阴暗生物使用。',
},
},
desc = '能够对构造体造成伤害，技能如下',
},
},
desc = '随机点名，在一段时间后被点名玩家死亡并变为复仇之灵形态。该玩家的位置上将额外滋生多个阴暗构造体。',
},
{
spell = '40188',
title = '召唤末日之花',
noCollapse = false,
expanded = false,
desc = '在附近位置召唤黑云，周期性地释放暗影箭，对随机目标造成暗影伤害。',
},
{
spell = '40239',
title = '烧尽',
noCollapse = false,
expanded = false,
desc = '对随机目标造成火焰伤害并额外造成持续伤害，可驱散。',
},
{
spell = '40243',
title = '毁灭之影',
noCollapse = false,
expanded = false,
desc = '使目标受到感染，在一段时间内受到的暗影伤害提高。',
},
},
desc = '塔隆·血魔战斗的难点在于血魔会随机点名玩家变成复仇之灵形态，然后刷新只能由复仇之灵造成伤害的构造体，若构造体没有被击杀就会攻击大团。',
},
},
[620] = {
bossId = 620,
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '主坦拉住BOSS，其余两个副坦需要和主坦站在一起分担恶毒顺劈的伤害。',
},
{
role = 'HEALER',
expanded = false,
desc = '分散站位，注意坦克血量，尤其在战争践踏之后，需要提前预读治疗法术治疗坦克。\n注意自身法力值，在卡兹洛加的印记发动时确保有足够的法力值被抽取，若实在法力值耗尽，需要远离大团避免爆炸波及其他人。\n',
},
{
role = 'MELEE',
expanded = false,
desc = '在BOSS身后全力输出，注意仇恨。',
},
{
role = 'RANGE',
expanded = false,
desc = '分散站位，最远距离输出BOSS 。\n输出时注意自身法力值，在卡兹洛加的印记发动时确保有足够的法力值被抽取，若实在法力值耗尽，需要远离大团避免爆炸波及其他人。\n',
},
},
desc = '卡兹洛加战斗开始后，3个坦克需要站在一起分担恶毒顺劈的伤害，有蓝职业则需要注意自己的法力值，确保印记期间有足够的法力值被吸取，实在是没有的就需要远离大团，避免爆炸时带走其他人。',
},
name = '卡兹洛加',
icon = '1385745',
abilities = {
children = {
{
spell = '31436',
title = '恶毒顺劈',
noCollapse = false,
expanded = false,
desc = '对目标造成巨量伤害，由所有受影响目标分摊伤害。',
},
{
spell = '31480',
title = '战争践踏',
noCollapse = false,
expanded = false,
desc = '对近战范围内的玩家造成伤害，并使其昏迷数秒。',
},
{
spell = '31477',
title = '残废术',
expanded = false,
noCollapse = false,
children = {
},
desc = '随机点名一个玩家施放，使其移动速度、攻击速度、力量降低，持续一段时间。',
},
{
spell = '31447',
title = '卡兹洛加的印记',
noCollapse = false,
expanded = false,
desc = '周期性的对全团施放一个印记，印记在持续期间会吸收法力值，当有蓝职业无法再被吸取法力时，会直接爆炸，同时还会对周围队友造成高额伤害。',
},
},
desc = '卡兹洛加前的八波小怪需要注意清理新增的石像鬼和冰霜巨龙，BOSS战对于DPS的要求较高，但是有蓝职业要随时注意自己的法力值，避免在卡兹洛加的印记施放时没有足够的法力值而造成减员，同时注意保护好萨尔。 ',
},
},
[1121] = {
bossId = 1121,
name = '天启四骑士',
zone = 3,
abilities = {
children = {
{
title = '库尔塔兹领主',
children = {
{
title = '流星',
expanded = true,
desc = '范围伤害，由陨石冲击点周围8码内所有玩家共同分担。',
},
{
spell = 28832,
expanded = true,
desc = '对光环内玩家造成伤害并留下印记，叠加的印记层数越多所受伤害越大。',
},
},
},
{
title = '瑟里耶克爵士',
children = {
{
title = '神圣愤怒',
expanded = true,
desc = '对周围玩家射出神圣箭矢，对目标和其身旁玩家造成神圣伤害，每次跳跃提高50%伤害。',
},
{
title = '神圣之箭',
expanded = true,
desc = '对离BOSS最近玩家造成大量神圣伤害。',
},
{
spell = 28835,
expanded = true,
desc = '对光环内玩家造成伤害并留下印记，叠加的印记层数越多所受伤害越大。',
},
},
},
{
title = '女公爵布劳缪克丝',
children = {
{
title = '暗影箭',
expanded = true,
desc = '对目标射出魔法箭，造成大量暗影伤害。',
},
{
spell = 28863,
expanded = true,
desc = '随机范围内玩家脚下召唤一个虚空领域，对站在范围内的所有玩家造成暗影伤害。',
},
{
spell = 28833,
expanded = true,
desc = '对光环内玩家造成伤害并留下印记，叠加的印记层数越多所受伤害越大。',
},
},
},
{
title = '大领主莫格莱尼',
children = {
{
title = '正义之火',
expanded = true,
desc = '对BOSS前方造成大量范围伤害。',
},
{
spell = 28834,
expanded = true,
desc = '对光环内玩家造成伤害并留下印记，叠加的印记层数越多所受伤害越大。',
},
},
desc = '注意：BOSS在血量50%、20%时会开启盾墙（29061），持续20秒。',
},
},
desc = '天启四骑士有4个BOSS，分别是库尔塔兹领主、瑟里耶克爵士、女公爵布劳缪克丝、大领主莫格莱尼，4个BOSS都有各自的光环印记和独特技能，相同光环印记可叠加，层数越高受到的伤害越多，每个BOSS的印记互不干涉。4个BOSS被拉到房间的4个角落后，整个房间只有BOSS所在台阶前面位置为安全点，不会吃到所有印记。',
},
url = 'https://www.bilibili.com/video/BV1dr4y1w7gW?p=13',
icon = 1385732,
summary = {
children = {
{
role = 'TANK',
children = {
{
title = '南场',
expanded = true,
desc = '1T站在门右边的角落拉大领主莫格莱尼\n2T站在门左边角落拉库尔塔兹领主\n34队T在安全点等待。\n印记叠加3层后，3T接替1T，4T接替2T，12队T返回安全点等待。',
},
{
title = '北场',
expanded = true,
desc = '5T将女公爵布劳缪克丝拉至左上角\n6T将瑟里耶克爵士拉至右上角\n78队T在安全点等待。\n印记叠加3层后， 7T接替5T，8T接替6T，56队T返回安全点等待。',
},
{
title = '注意',
expanded = true,
desc = '之后印记每叠加3层时，南北场安全点的T注意身上印记，哪个BOSS印记消失，就去接替哪个BOSS（只接替自己半场的T）。\n注意：若南场BOSS已击杀，多余T可根据身上印记情况去北场支援。BOSS印记消失后方可去接手该BOSS。',
},
},
desc = '整个战斗需要8个T，每个队伍一个T，整个战斗场地分为南北场作战，进门区域为南场，BOSS身后为北场。1234队T在南场，5678队T在北场。每次换T一定确保接替的T已经接到BOSS再走。拉大领主莫格莱尼的T注意将BOSS背对大团，拉女公爵布劳缪克丝拉的T注意随机躲避脚下的黑水。\n战斗开始，4个T分散在4个角落。',
},
{
desc = '1.跟随分配到的T，T去接手哪个BOSS就去跟随去治疗。\n2.治疗库尔塔兹领主时和T站在一起，治疗瑟里耶克爵时最远距离加血，治疗女公爵布劳缪克丝拉时注意随机躲避脚下的黑水。\n注意：身上印记叠加至3层就回安全点。BOSS印记消失后方可跟随T去治疗该BOSS。',
role = 'HEALER',
},
{
desc = '1.跟随分配到的T，T去接手哪个BOSS就去输出哪个BOSS。\n2.输出大领主莫格莱尼时注意站在BOSS背后，输出女公爵布劳缪克丝拉时注意随机躲避脚下的黑水。\n3.大领主莫格莱尼和库尔塔兹领主击杀后再去输出女公爵布劳缪克丝拉，不去输出瑟里耶克爵士。\n注意：身上印记叠加至3层就回安全点。BOSS印记消失后方可跟随T去输出该BOSS。',
role = 'MELEE',
},
{
desc = '1.跟随分配到的T，T去接手哪个BOSS就去输出哪个BOSS。\n2.输出库尔塔兹领主时和T站在一起，输出瑟里耶克爵士时最远距离输出，输出女公爵布劳缪克丝拉时注意随机躲避脚下的黑水。\n3.先击杀大领主莫格莱尼和库尔塔兹领主，这2个击杀之后再去输出女公爵布劳缪克丝拉和瑟里耶克爵士。\n注意：身上印记叠加至3层就回安全点。BOSS印记消失后方可跟随T去输出该BOSS。',
role = 'RANGE',
},
},
},
},
[652] = {
bossId = 652,
summary = {
children = {
{
children = {
{
title = 'P1阶段',
desc = '副T拉住午夜，阿图门出现时主T第一时间拉住，让BOSS背对大团，可以缴械BOSS。',
},
{
title = 'P2阶段',
desc = '阿图门上马后主T拉住，让BOSS背对大团。',
},
},
role = 'TANK',
},
{
desc = '注意主T血量，BOSS上马后靠近阿图门，在BOSS背面治疗。',
role = 'HEALER',
},
{
desc = '优先输出午夜，BOSS上马后输出阿图门，全程躲开阿图门正面。',
role = 'MELEE',
},
{
desc = '优先输出午夜，BOSS上马后靠近阿图门，在BOSS背面输出，法师注意解诅咒。',
role = 'RANGE',
},
},
desc = '卡拉赞一号BOSS是猎手阿图门，战斗开始时只有午夜单独存在，午夜血量降低至95%阿图门才会出现，午夜血量降至25%的时候，战斗进入P2阶段，阿图门会骑上午夜，并且血量全满，这时击杀了阿图门战斗即可结束。',
},
abilities = {
children = {
{
noCollapse = true,
title = '午夜',
children = {
{
desc = '对当前目标造成大量伤害并将其击倒，持续3秒',
spell = 29711,
},
},
},
{
noCollapse = true,
title = '阿图门',
children = {
{
title = 'P1阶段',
children = {
{
desc = '对目标和周围玩家造成大量暗影伤害。',
spell = 29832,
},
{
desc = '群体诅咒，每隔一段时间对一定范围内玩家释放，使玩家法术和近战攻击命中下降。',
spell = 29833,
},
},
},
{
title = 'P2阶段',
children = {
{
desc = '随机对一名远程目标进行冲锋并造成大量伤害。',
spell = 26561,
},
{
desc = '对目标和周围玩家造成大量暗影伤害。',
spell = 29832,
},
{
desc = '群体诅咒，每隔一段时间对一定范围内玩家释放，使玩家法术和近战攻击命中下降。',
spell = 29833,
},
},
},
},
},
},
desc = '猎手阿图门整场战斗分为2个阶段，P1一开始只有午夜在场，午夜血量降低至95%时阿图门会出现，需要主副T及时拉住两个BOSS仇恨。在午夜血量降低至25%时进入P2阶段，阿图门会骑上午夜并且血量全满。',
},
icon = 1378965,
name = '猎手阿图门',
},
[660] = {
bossId = 660,
summary = {
children = {
{
title = '人类步兵/兽人士兵',
desc = '向前，让开通道便于其他棋子出来。',
},
{
title = '召唤的水元素/被召唤的恶魔',
desc = '移动上前，吸引敌方棋子。',
},
{
title = '人类骑兵/兽人座狼',
desc = '移动上前，吸引敌方棋子。',
},
{
title = '人类召唤师/兽人术士',
desc = '优先消灭敌方的兽人通灵师/人类祭司。治疗死后就可以直接攻击敌方领袖。',
},
{
title = '国王/酋长',
desc = '给己方棋子加BUFF，移动至己方棋子身后参与攻击，不要直接受到敌方棋子攻击。',
},
{
title = '人类祭司/兽人通灵师',
desc = '1. 跟随在国王/酋长身后给己方领袖治疗。\n2. 集中攻击敌方领袖。',
},
},
desc = '国际象棋是一场非常特殊的战斗，整场战斗不需要使用角色技能，全靠控制棋子后，移动并使用棋子的技能击杀对立阵营领袖即可获得胜利。战斗开始后需要先移开前排中间的士兵，然后移动国王/酋长、人类祭司/兽人通灵师、人类法师/兽人术士。集中火力攻击对方阵营的治疗者，然后再攻击对方领袖，注意自己的领袖不要过于深入，人类祭司/兽人通灵师需要跟随好己方领袖并治疗即可。',
},
abilities = {
children = {
{
title = '国王/酋长',
desc = '1. 对身前范围内敌方棋子造成伤害。\n2. 提高周围己方棋子伤害，持续10秒。',
},
{
title = '人类法师/兽人术士',
desc = '1. 对敌方棋子造成单体伤害。\n2. 对任意敌方棋子及其周围棋子造成持续伤害。',
},
{
title = '人类祭司/兽人通灵师',
desc = '1. 恢复目标血量。\n2. 对敌方阵营棋子造成单体伤害。',
},
{
title = '人类骑兵/兽人座狼',
desc = '1. 对正面敌方棋子造成单体伤害。\n2. 降低周围敌方棋子的物理伤害。',
},
{
title = '召唤的水元素/被召唤的恶魔',
desc = '1. 对附近敌方棋子造成伤害。\n2. 使自身受到的伤害降低。',
},
{
title = '人类步兵/兽人士兵',
desc = '1. 对正面敌方棋子造成伤害。\n2. 吸收伤害技能。',
},
},
desc = '国际象棋是一场非常特殊的战斗，整场战斗不需要玩家角色技能，全靠控制棋子后，移动并使用棋子的技能。双方阵营各有16颗棋子，6种类型，与所属阵营的国王/酋长对话即可开启战斗，控制棋子清空对立阵营领袖血量，战斗即为胜利。\n注意：每个棋子都有技能冷却时间，若想要更换棋子，只需点击取消角色右上角的debuff即可。',
},
icon = 1385725,
name = '国际象棋',
},
[729] = {
bossId = 729,
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '开场T分别拉住3个小怪，需要分散拉开，BOSS激活后，主T拉住BOSS，使BOSS背对大团。副T需要拉住出现的欺诈者之手和各种镜像，躲开场地上出现的火圈。在BOSS释放千魂之暗时，全团躲进蓝龙的护盾内躲避全屏伤害。',
},
{
role = 'MELEE',
expanded = false,
desc = '在BOSS背后尽量分散站位输出，躲开场地上出现的火圈。在BOSS释放千魂之暗时，全团躲进蓝龙的护盾内躲避全屏伤害。',
},
{
role = 'RANGE',
expanded = false,
desc = '根据指挥安排分散站位输出，和周围人保持一定距离，优先击杀出现的镜像和护盾宝珠，躲开场地上出现的火圈。\n指挥安排人控制蓝龙，指定的人需要在宝珠激活之后控制蓝龙，给需要的人喷急速和恢复，在BOSS释放千魂之暗时开启蓝龙的护盾，全团躲进护盾内躲避全屏伤害。\n',
},
{
role = 'HEALER',
expanded = false,
desc = '根据指挥安排分散站位治疗全团，和周围人保持一定距离，躲开场地上出现的火圈，保证中火焰之花和暗影之刺人的存活。在BOSS释放千魂之暗时，全团躲进蓝龙的护盾内躲避全屏伤害。',
},
},
desc = '基尔加丹战斗开始需要先解决场地上的三个人形怪，激活BOSS后全团分散站位，和周围人保持一定得距离，在BOSS释放千魂之暗时集合躲进蓝龙的护盾内避免受到全屏伤害，期间还需要躲避地面出现的火圈。指挥需要安排人点击蓝龙宝珠，化身蓝龙使用技能辅助战斗。BOSS血量降低至25%之后进入软狂暴状态，需要全团移动躲避末日决战。',
},
name = '基尔加丹',
icon = '1385746',
abilities = {
children = {
{
title = '基尔加丹技能',
noCollapse = false,
expanded = true,
children = {
{
spell = '42165',
title = '击飞',
children = {
},
noCollapse = false,
expanded = false,
desc = '基尔加丹会击飞进入靠的过近的玩家。',
},
{
spell = '45442',
title = '灵魂鞭笞',
noCollapse = false,
expanded = false,
desc = '对当前目标施放，每秒造成大量暗影伤害并降低移动速度，持续数秒。',
},
{
spell = '45664',
title = '军团闪电',
noCollapse = false,
expanded = false,
desc = '对随机目标造成大量暗影伤害，并抽取法力值。该技能会像闪电链一样跳跃，每次跳跃都会降低部分伤害。',
},
{
spell = '45641',
title = '火焰之花',
noCollapse = false,
expanded = false,
desc = '对随机数个目标施放火焰之花，使之受到持续性火焰伤害，同时对其周围所有玩家造成同样伤害持续时间。',
},
{
spell = '45737',
title = '烈焰之刺',
noCollapse = false,
expanded = false,
desc = '对随机目标造成火焰伤害，并对范围内的玩家产生火焰溅射伤害附带减速效果，持续数秒。',
},
{
spell = '46589',
title = '暗影之刺',
noCollapse = false,
expanded = false,
desc = '在一段时间内持续对随机目标施放一个黑色的暗影之刺，对目标及其周围的所有目标造成大量暗影伤害，并使其受到的治疗效果降低。',
},
{
spell = '25502',
title = '护盾宝珠',
noCollapse = false,
expanded = false,
desc = '对可攻击范围内目标不停施放暗影箭，造成暗影伤害。',
},
{
spell = '45892',
title = '邪恶镜像',
noCollapse = false,
expanded = false,
desc = '对随机玩家施放，在其周围立刻生成数个复制镜像，镜像使用的技能与伤害只与职业有关，与天赋无关。',
},
{
spell = '45915',
title = '末日决战',
noCollapse = false,
expanded = false,
desc = '场地上出现火圈，数秒后炸下一颗陨石造成大量火焰伤害。',
},
{
spell = '46605',
title = '千魂之暗',
noCollapse = false,
expanded = false,
desc = '读条技能，对全屏玩家造成足以秒杀的暗影伤害，可以无敌冰箱抵挡。',
},
},
},
{
title = '蓝龙技能',
noCollapse = false,
expanded = true,
children = {
{
spell = '45848',
title = '蓝龙护盾',
noCollapse = false,
expanded = false,
desc = '制造一个以施法者为圆心的蓝龙护盾，使范围内的所有友方单位受到和制造的伤害都降低，施法者会每秒损失生命值。进入护盾后消除一切DEBUFF。持续数秒，有冷却时间。',
},
{
spell = '45862',
title = '闪烁',
noCollapse = false,
expanded = false,
desc = '向前闪烁，无冷却。',
},
{
spell = '45860',
title = '龙息：恢复',
noCollapse = false,
expanded = false,
desc = '向前方锥形区域喷出奥术能量，使该范围内的玩家在数秒内恢复部分生命值和法力值，有冷却时间。',
},
{
spell = '45856',
title = '龙息：急速',
noCollapse = false,
expanded = false,
desc = '向前方锥形区域喷出奥术能量，使该范围内玩家的攻击、施法和移动速度提高，同时也会免疫行动限制类效果，有冷却时间。',
},
},
},
},
desc = '基尔加丹是太阳之井高地的最终BOSS，技能很多，整场战斗需要分散站位，避免玩家在受到BOSS技能后，对周围的队友产生额外伤害。战斗期间还需要有人点击场地周围的宝珠，化身为蓝龙，使用蓝龙的技能辅助战斗，尤其是BOSS在施放全屏技能时所有人需要躲避在蓝龙开的罩子内避免受到伤害。',
},
},
[728] = {
bossId = 728,
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '黑暗纳鲁阶段：此阶段T不需要拉BOSS，拉住出现的人型怪以及虚空戒卫即可，远离出现的暗影魔。\n熵魔阶段：T拉住熵魔，躲避脚下出现的黑水，远离出现的暗影魔，被奇点追踪时尽量跑离大团，调整位置避免被击飞。\n',
},
{
role = 'MELEE',
expanded = false,
desc = '黑暗纳鲁阶段：优先输出虚空戒卫，然后是人型怪，远离出现的暗影魔。\n熵魔阶段：全力输出熵魔，躲避脚下出现的黑水，远离出现的暗影魔，被奇点追踪时尽量跑离大团，远离被奇点追踪的人。\n',
},
{
role = 'RANGE',
expanded = false,
desc = '黑暗纳鲁阶段：远程集中站位，优先输出虚空戒卫，然后是人型怪，有空再输出BOSS，远离出现的暗影魔。\n熵魔阶段：分散站位全力输出熵魔，躲避脚下出现的黑水，远离出现的暗影魔，被奇点追踪时尽量跑离大团，远离被奇点追踪的人。\n',
},
{
role = 'HEALER',
expanded = false,
desc = '黑暗纳鲁阶段：和远程一起站位治疗全团，远离出现的暗影魔，牧师优先群体驱散出现的暗影魔。\n熵魔阶段：分散站位治疗全团，躲避脚下出现的黑水，远离出现的暗影魔，牧师优先群体驱散出现的暗影魔，被奇点追踪时尽量跑离大团，远离被奇点追踪的人。\n',
},
},
desc = '穆鲁战斗分为两个阶段，黑暗纳鲁期间坦克不需要拉BOSS，拉住召唤出的各种小怪即可，牧师注意第一时间群体驱散黑暗魔，黑暗纳鲁血量清零后进入熵魔阶段，建议小怪尽量清完再进入熵魔阶段，这个阶段需要全团分散全力输出。',
},
name = '穆鲁',
icon = '1385757',
abilities = {
children = {
{
title = '穆鲁技能',
noCollapse = false,
expanded = true,
children = {
{
spell = '46008',
title = '负能量',
noCollapse = false,
expanded = false,
desc = '每秒对随机5个玩家造成暗影伤害。',
},
{
spell = '45185',
title = '黑暗',
noCollapse = false,
expanded = false,
desc = '每隔45秒穆鲁会以自己为圆心的一个圆形区域内召唤黑水，处于其中的人会受到暗影伤害并附带一个受到治疗效果降低100%的debuff。黑水地带还会产生黑暗魔，一旦碰到会对整个团队造成大量的暗影伤害，黑暗魔可驱散。',
},
{
spell = '45978',
title = '召唤虚空戒卫',
noCollapse = false,
expanded = false,
desc = '每隔30秒，穆鲁会从房间随机位置开启一扇虚空门，8秒之后从中出现一个虚空戒卫。虚空戒卫会单体虚空冲击技能和群攻的暗影冲击技能。戒卫死后会刷新数个会群体暗影箭的小虚空，必须拉离人群。',
},
{
title = '穆鲁战斗期间会不断召唤小怪',
children = {
},
noCollapse = false,
expanded = false,
desc = '影刃狂暴者：攻速很快的近战怪，狂乱之后攻击速度提升。\n影刃怒火法师：远程法术怪，会给自己加一个buff，提高技能伤害50%，在接下去的5发技能全部变成瞬发。',
},
},
},
{
title = '熵魔技能',
noCollapse = false,
expanded = true,
children = {
{
spell = '46285',
title = '负能量',
noCollapse = false,
expanded = false,
desc = '类似一阶段技能，对随机目标造成暗影伤害，但同时会跳跃至其他的额外目标上，时间越久射线越多。',
},
{
spell = '46282',
title = '黑洞',
noCollapse = false,
expanded = false,
desc = '战斗开始一段时间后，熵魔会随机选择目标召唤一个黑洞，数秒之后黑洞会变成奇点。奇点会随机追踪范围之内的玩家，并对附近玩家造成暗影伤害，附带拉扯效果。',
},
{
spell = '46269',
title = '黑暗',
noCollapse = false,
expanded = false,
desc = '战斗开始一段时间后，战斗场地随机位置会出现黑水，黑水内还会产生黑暗魔，一旦碰到会对整个团队造成大量的暗影伤害，黑暗魔可驱散。',
},
},
},
},
desc = '穆鲁战斗分为两个阶段，刚开始为黑暗纳鲁形态，血量清零后会变身为熵魔进入第二阶段。黑暗纳鲁形态会召唤大量的小怪，熵魔形态时会有负能量射线，时间越久射线越多，团队压力就越大。',
},
},
[726] = {
bossId = 726,
abilities = {
children = {
{
expanded = true,
noCollapse = false,
children = {
{
spell = '19983',
title = '顺劈斩',
noCollapse = false,
expanded = false,
desc = '对正面范围内目标造成物理伤害。',
},
{
spell = '45855',
title = '毒气新星',
noCollapse = false,
expanded = false,
desc = '大范围技能，对范围内的目标造成自然伤害，并在接下来的一段时间内吸取生命值和法力值，可驱散。',
},
{
spell = '47002',
title = '毒气',
noCollapse = false,
expanded = false,
desc = '光环技能，周期性对全团造成自然伤害。',
},
{
spell = '45662',
title = '压缩',
noCollapse = false,
expanded = false,
desc = '随机目标施放，使其昏迷并对该目标和范围内其他目标造成奥术伤害。',
},
{
spell = '45866',
title = '腐蚀',
noCollapse = false,
expanded = false,
desc = '使目标受到自然伤害并附加一个承受伤害增加的debuff。',
},
},
title = '地面阶段',
},
{
expanded = true,
noCollapse = false,
children = {
{
spell = '45402',
title = '恶魔蒸汽',
noCollapse = false,
expanded = false,
desc = '随机选择目标施放类似眼棱的绿线，绿线会跟踪目标，并在经过的地方留下雾气，雾气内玩家会受到自然伤害并附带一个持续性伤害的dot，且雾中还会召唤骷髅。',
},
{
spell = '45717',
title = '腐蚀之雾',
noCollapse = false,
expanded = false,
desc = '召唤一个大范围的绿色云雾，在其范围内的目标会被精神控制，被控制目标移动速度、杀伤力和治疗能力提高，该效果不可被移除。',
},
},
title = '空中阶段',
},
},
desc = '菲米丝战斗分为地面和空中两个阶段，开场为地面阶段，大致60秒之后进入空中阶段，会对地面释放毒线和吐息技能，100秒后又回到地面，两个阶段循环直至BOSS倒下，战斗十分钟后菲米丝会陷入狂暴状态。',
},
name = '菲米丝',
icon = '1385730',
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '地面阶段：T需要将BOSS拉在角落，侧面对大团。\n空中阶段：毒线时T需要拉住出现的所有骷髅，吐息时跟随大团一起跑动。\n',
},
{
role = 'HEALER',
expanded = false,
desc = '地面阶段：根据指挥分配，以队伍为单位集中站位治疗全团，尤其注意中压缩的人的血量，治疗自身中压缩也需要立即跑离大团，BUFF结束后返回。牧师注意在BOSS施放毒气新星时群体驱散。\n空中阶段：中毒线的跑离大团，其他人和大团集中站位加血，吐息时跟随大团一起跑动。\n',
},
{
role = 'MELEE',
expanded = false,
desc = '地面阶段：集中站在BOSS侧面输出，中压缩立即跑离大团，BUFF结束后返回继续输出。\n空中阶段：中毒线的跑离大团，其他人集中站位输出骷髅，吐息时跟随大团一起跑动。\n',
},
{
role = 'RANGE',
expanded = false,
desc = '地面阶段：根据指挥分配，以队伍为单位集中站位输出，中压缩立即跑离大团，BUFF结束后返回继续输出。\n空中阶段：中毒线的跑离大团，其他人集中站位输出骷髅，吐息时跟随大团一起跑动。\n',
},
},
desc = '菲米丝地面战斗期间需要团队以队伍为单位站位，便于牧师群体驱散。空中阶段除中毒线的玩家，其他都需要集中站位，便于坦克拉住出现的骷髅。BOSS在空中吐息的时候需要观察BOSS位置，听从指挥全团一起跑位躲避吐息，两个阶段不断循环直至战斗结束。',
},
},
[716] = {
bossId = 716,
abilities = {
children = {
{
desc = '击退当前目标并造成大量伤害。',
spell = 26100,
},
{
desc = '对近战范围内所有玩家造成2500左右伤害并击退。',
spell = 26103,
},
{
desc = '对仇恨最高玩家方向180度范围内释放，造成3000左右自然伤害，眩晕5秒并清除仇恨。',
spell = 26102,
},
{
desc = '奥罗潜入地下，召唤奥罗土堆追击目标，接触到土堆玩家均会受到伤害，30秒后土堆释放出小甲虫。',
spell = 26058,
},
{
desc = 'BOSS血量降至20%时进入狂暴状态，攻击速度提高150%。',
spell = 26615,
},
},
},
name = '奥罗',
summary = {
children = {
{
desc = '1.主T和治疗、输出对角站位，副T站主T边上。\n2.BOSS开展后确保仇恨，被击退后迅速返回。\n3.沙尘爆裂前后退，释放完迅速跑回。\n4.BOSS下地后和队友一起整体跑动，确保BOSS出来后第一时间拉到BOSS。\n5.主T中沙尘爆裂后，副T速度跑至主T位置接手仇恨。\n6.出现小甲虫后，副T拉住甲虫。',
role = 'TANK',
},
{
desc = '1.分配T的治疗站T后面位置。\n2.大团治疗站在远程输出位置。\n3.BOSS下地后和队友一起整体跑动。\n4.BOSS出来站位好继续治疗。\n5.躲开土堆，出现小甲虫后跑向副T位置。',
role = 'HEALER',
},
{
desc = '1.站主T对面输出。\n2.横扫前后退，释放完迅速跑回。\n3.BOSS下地后和队友一起整体跑动。\n4.BOSS出来站T对面继续输出。\n5.躲开土堆，出现小甲虫后优先击杀或控制小甲虫。 ',
role = 'MELEE',
},
{
desc = '1.站主T对面最远距离输出。\n2.BOSS下地后和队友一起整体跑动。\n3.BOSS出来站T对面继续输出。\n4.躲开土堆，出现小甲虫后优先击杀或控制小甲虫。 ',
role = 'RANGE',
},
},
},
icon = 1385760,
desc = '整场战斗BOSS在地面上时需要保持合适的距离，BOSS下地时则全团移动，确保不会被土堆追上。',
},
[1567] = {
bossId = 1567,
summary = {
children = {
{
children = {
},
role = 'TANK',
expanded = false,
desc = '1.开怪前坦克就可以开始清理BOSS前不停刷新的水元素，不会引到BOSS。战斗开始后这些水元素不会再刷新，所以在清理差不多之后，冰抗坦克就需要拉住BOSS开始战斗。\n2.整场战斗需要两个主坦克，冰抗较高坦克在冰伤阶段抗住BOSS，自然抗较高坦克需要在毒伤阶段抗住BOSS。\n3.当前坦克在印记叠加至50%之后就要移动BOSS位置，在叠加至100%时将BOSS拉下或者拉上台子来切换BOSS的形态，交给另一位坦克，避免印记叠加过高被秒。\n4.空闲的坦克需要在BOSS切换形态时拉住召唤出的4个水元素。',
},
{
role = 'MELEE',
expanded = false,
desc = '1.优先清理完BOSS前不停走动的水元素，然后根据指挥分配，分成两个小队集中站在BOSS两侧输出。\n2.阶段转换时优先击杀召唤出的水元素，待接替的坦克拉稳仇恨之后再输出BOSS。',
},
{
role = 'RANGE',
expanded = false,
desc = '1.优先清理完BOSS前不停走动的水元素，然后在场地周围分散站位，最远距离输出BOSS。\n2.阶段转换时优先击杀召唤出的水元素，分散站位，确保周围8码范围内没有其他玩家，待接替的坦克拉稳仇恨之后再输出BOSS。',
},
{
role = 'HEALER',
expanded = false,
desc = '1.治疗好当前坦克和中技能玩家。\n2.跟随坦克移动位置，分散站位，确保周围8码范围内没有其他玩家。',
},
},
desc = '不稳定的海度斯整场战斗需要在印记叠加过高之前调整BOSS位置使其进入另一阶段来消除当前印记，避免坦克被秒。10分钟未结束战斗就会灭团。',
},
name = '不稳定的海度斯',
icon = '1385741',
abilities = {
children = {
{
spell = '38218',
expanded = false,
noCollapse = false,
children = {
},
desc = '每15秒对所有敌人施加一个能量印记，使其受到的冰霜或自然伤害增加10%，25%，50%，100%，250%，持续30秒。',
},
{
spell = '38235',
expanded = false,
noCollapse = false,
children = {
},
desc = '将随机目标困在冰墓之中，击晕并造成大量冰霜伤害，持续4秒，该伤害会衍射到周围玩家并不断重复下去。（该技能仅在冰伤阶段出现）',
},
{
spell = '38246',
noCollapse = false,
expanded = false,
desc = '对随机目标释放，减少该目标50%的伤害和治疗效果，并每3秒造成自然伤害，持续24秒。（该技能仅在毒伤阶段出现）',
},
{
spell = '31687',
noCollapse = false,
expanded = false,
desc = '转换阶段时会在BOSS周围刷新4个水元素。',
},
},
desc = '不稳定的海度斯是毒蛇神殿一号BOSS，在台子上时有光线连接时为冰伤阶段，BOSS会造成冰霜伤害，并会释放可叠加的冰霜易伤印记，使受到冰霜伤害逐层提高。将BOSS拉至台子下光线会断开，进入毒伤阶段，BOSS会造成自然伤害，并释放可叠加的自然易伤印记，受到的自然伤害逐层提高。',
},
},
[605] = {
bossId = 605,
summary = {
children = {
{
role = 'TANK',
expanded = true,
children = {
{
title = 'P1阶段',
noCollapse = false,
expanded = false,
desc = '主坦将BOSS背对大团，副T也打上仇恨，需要几个坦克轮流拉住BOSS。',
},
{
title = 'P2阶段',
noCollapse = false,
expanded = false,
desc = '分散站位，离开BOSS正面范围。',
},
},
},
{
role = 'MELEE',
expanded = true,
children = {
{
title = 'P1阶段',
expanded = false,
noCollapse = false,
children = {
},
desc = '远离几个坦克输出BOSS。缓慢输出确保仇恨不会超过几个坦克。',
},
{
title = 'P2阶段',
noCollapse = false,
expanded = false,
desc = '分散站位，离开BOSS正面范围。',
},
},
},
{
role = 'RANGE',
expanded = true,
children = {
{
title = 'P1阶段',
noCollapse = false,
expanded = false,
desc = '先和大团一起站位，根据指挥分配轮流去最远处吃血沸技能。中了技能后返回大团，等待下一次吃技能再出去。缓慢输出确保仇恨不会超过几个坦克。',
},
{
title = 'P2阶段',
noCollapse = false,
expanded = false,
desc = '分散站位输出，离开BOSS正面范围。',
},
},
},
{
role = 'HEALER',
expanded = true,
children = {
{
title = 'P1阶段',
noCollapse = false,
expanded = false,
desc = '和大团一起站位，加好坦克和吃血沸技能的队友。',
},
{
title = 'P2阶段',
noCollapse = false,
expanded = false,
desc = '分散站位，离开BOSS正面范围，加好中血沸技能的队友。',
},
},
},
},
desc = '古尔图格·血沸第一阶段时需要安排远程队伍不断的站到最远距离去承担血液沸腾的点名，第二阶段BOSS会点名玩家一直攻击，直至该玩家死亡或者技能时间结束，需要全员分散，全力输出，两个阶段不断切换直至BOSS倒下。',
},
name = '古尔图格·血沸',
icon = '1378983',
abilities = {
children = {
{
children = {
{
spell = '42005',
title = '血液沸腾',
noCollapse = false,
expanded = false,
desc = '使最远处的目标血液沸腾，在短时间内造成持续伤害。',
},
{
spell = '40484',
title = '酸性创伤',
noCollapse = false,
expanded = false,
desc = '对当前目标的攻击有几率造成酸性创伤，持续造成自然伤害，并使其护甲值降低，可叠加。',
},
{
spell = '40491',
title = '混乱打击',
noCollapse = false,
expanded = false,
desc = '在造成伤害的同时使目标困惑一段时间。',
},
{
spell = '40457',
title = '圆弧斩',
noCollapse = false,
expanded = false,
desc = '对目标正面锥形区域内的敌人造成普通伤害外加额外伤害。',
},
},
noCollapse = false,
title = 'P1阶段',
expanded = true,
},
{
children = {
{
spell = '40594',
title = '邪能狂怒',
noCollapse = false,
expanded = false,
desc = '血沸造成的伤害提高，并叠加愤怒，攻击速度提高。血沸在受到邪能狂怒影响的同时会攻击其他邪能狂怒的玩家，并使其生命值和护甲值提高。',
},
{
spell = '40508',
title = '邪酸吐息',
noCollapse = false,
expanded = false,
desc = '对正面锥形区域内的敌人造成自然伤害和额外伤害。',
},
{
spell = '40599',
title = '邪能圆弧斩',
noCollapse = false,
expanded = false,
desc = '对正面锥形区域内的敌人造成普通伤害外加额外伤害。同时降低治疗效果。',
},
{
spell = '40569',
title = '邪能喷泉',
noCollapse = false,
expanded = false,
desc = '血沸的邪能喷泉对当前目标范围内的敌人造成自然伤害，并将他们击退。',
},
},
noCollapse = false,
title = 'P2阶段',
expanded = true,
},
},
desc = '古尔图格·血沸会在两个阶段之间切换，两个阶段使用的技能不同，第一阶段会点名最远处的目标，第二阶段则会随机锁定一名玩家全力攻击。',
},
},
[724] = {
bossId = 724,
abilities = {
children = {
{
expanded = true,
noCollapse = false,
children = {
{
spell = '45018',
title = '奥术打击',
noCollapse = false,
expanded = false,
desc = '对所有目标造成奥术伤害，并附带一个可叠加的debuff，增加目标所受的奥术伤害，持续40秒，不可被驱散。',
},
{
spell = '45122',
title = '扫尾',
noCollapse = false,
expanded = false,
desc = '对身后锥形范围内的目标造成伤害并击退。',
},
{
spell = '44799',
title = '冰霜吐息',
noCollapse = false,
expanded = false,
desc = '对前方锥形范围内目标造成冰霜伤害，并于一段时间内降低攻速，可驱散。',
},
{
spell = '44978',
title = '狂野魔法',
noCollapse = false,
expanded = false,
desc = '对一个目标施放，随机造成以下6种效果的其中一种：\n1.治疗效果增加100%\n2.施法时间增加100%\n3.近战和远程命中降低50%\n4.爆击伤害增加100%\n5.技能仇恨增加100%\n6.法术技能消耗减少50%\n',
},
{
spell = '44866',
title = '灵魂冲击',
noCollapse = false,
expanded = false,
desc = '每隔一段时间随机一个目标施放，传送该目标至“灵魂裂隙（内场）”，且对目标周围玩家造成大量伤害，在该目标位置还会生成一个可以进入内场的传送门。\n灵魂领域：传送进内场的玩家身上会产生的一个debuff。\n灵魂疲惫：从内场出来的玩家身上的debuff，期间玩家无法再进入内场。\n',
},
},
title = '卡雷苟斯外场技能',
},
{
expanded = true,
noCollapse = false,
children = {
{
spell = '45032',
title = '无边痛苦诅咒',
noCollapse = false,
expanded = false,
desc = '给随机目标施加诅咒，时间内受到不断增加的暗影伤害，诅咒效果结束或被驱散后会转移至另一个目标身上。',
},
{
spell = '44867',
title = '暗影箭雨',
noCollapse = false,
expanded = false,
desc = '向范围内目标发射暗影箭，造成暗影伤害。',
},
{
spell = '45029',
title = '腐蚀打击',
noCollapse = false,
expanded = false,
desc = '击倒目标使其受到大量伤害并附带一个3秒的dot。',
},
{
spell = '44806',
title = '狂暴之怒',
noCollapse = false,
expanded = false,
desc = '攻击速度和造成的物理伤害提高。',
},
},
title = '腐蚀者萨索瓦尔内场技能：',
},
},
desc = '卡雷苟斯整场战斗分为内外场两个部分，外场为蓝龙形态，内场为恶魔形态。战斗开始所有人在外场，一段时间后BOSS会释放传送门，点击传送门即可进入内场。需要内外场两个BOSS同时击杀方可结束战斗，恶魔形态血量低于10%后，两个BOSS会进入狂暴状态。',
},
name = '卡雷苟斯',
icon = '1385744',
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '卡雷苟斯战斗需要三个T，开始时一T抗卡雷苟斯，将BOSS拉在场地边缘，使BOSS背对大团，二T准备在第一个传送门开的时候就进入内场，进入内场后二T抗住腐蚀者；三T在第三个传送门开后进入内场接替二T，二T出去抗住卡雷苟斯，一T准备在第四个传送门开的时候进入内场接替三T，三T出来之后抗住卡雷苟斯，后续的传送门开只需确认自身DEBUFF没了就可以点传送门进入。',
},
{
role = 'MELEE',
expanded = false,
desc = '首先根据团长分配，确定好进入内场的顺序，然后按照顺序点击传送门进入内场，第一次进入传送门出来后只需确认自身DEBUFF没了就可以再点后续出现的传送门进入内场输出。\n外场时近战输出需要站在BOSS侧面输出，尽量分散站位。随时注意是否有中仇恨增加的debuff，注意自身仇恨。\n进入内场后近战在腐蚀者背后输出，尽量的分散站位。\n',
},
{
role = 'RANGE',
expanded = false,
desc = '首先根据团长分配，确定好进入内场的顺序，然后按照顺序点击传送门进入内场。第一次进入传送门出来后只需确认自身DEBUFF没了就可以再点后续出现的传送门进入内场输出。\n外场时远程按照队伍分散站位输出，和周围人保持距离，随时注意是否有中仇恨增加的debuff，注意自身仇恨。\n进入内场后仍旧需要分散站位输出，法师需要驱散诅咒，T的诅咒需要第一时间驱散，但是其他人的不要在第一时间驱散，建议等待十秒左右之后再驱。\n',
},
{
role = 'HEALER',
expanded = false,
desc = '首先根据团长分配，确定好进入内场的顺序，然后按照顺序点击传送门进入内场。第一次进入传送门出来后只需确认自身DEBUFF没了就可以再点后续出现的传送门进入。\n外场时按照队伍分散站位，和周围人保持距离，随时注意是否有中仇恨增加的debuff，注意自身仇恨。治疗好队伍内的人。\n进入内场后仍旧需要分散站位，确保内场内的T和队伍人的血量，德鲁伊需要驱散诅咒，T的诅咒需要第一时间驱散，但是其他人的不要在第一时间驱散，建议等待十秒左右之后再驱。\n',
},
},
desc = '卡雷苟斯战斗开始后，全团听从指挥分配队伍，轮流进入内场消除奥术打击的debuff，并输出内场的腐蚀者萨索瓦尔。三个坦克穿插在队伍中，接替拉住内外场两个BOSS，直到2个BOSS同时倒地。',
},
},
[621] = {
bossId = 621,
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '主坦拉住BOSS，缓慢后退移至指定位置，BOSS需要背对大团。\n副坦要随时注意躲开火雨范围，若有玩家中厄运，需要拉住生成的末日守卫。\n',
},
{
role = 'HEALER',
expanded = false,
desc = '分散站位，注意坦克血量，在BOSS施放阿兹加洛之嚎群体沉默之前，提前给坦克加各种持续性治疗手段，也可以让骑士无敌治疗坦克。\n随时注意躲开火雨范围，若中了厄运，需要在即将死亡前靠近副坦，便于副坦拉住出现的末日守卫。\n',
},
{
role = 'MELEE',
expanded = false,
desc = '在BOSS背后输出，随时注意躲开火雨范围。\n若中了厄运，需要在即将死亡前靠近副坦，便于副坦拉住出现的末日守卫。\n',
},
{
role = 'RANGE',
expanded = false,
desc = '分散站位，最远距离输出BOSS，随时注意躲开火雨范围。\n若中了厄运，需要在即将死亡前靠近副坦，便于副坦拉住出现的末日守卫。\n术士需要根据指挥分配在战斗中给中了厄运的玩家绑定灵魂石。\n',
},
},
desc = '阿兹加洛整场战斗会施放火雨，因此需要分散站位，且战斗期间BOSS会随机点名玩家，使其一段时间后死亡并生成一个末日守卫，需要副坦拉住，最主要的是需要在BOSS施放阿兹加洛之嚎群体沉默时，确保坦克血量。',
},
name = '阿兹加洛',
icon = '1385719',
abilities = {
children = {
{
spell = '31345',
title = '顺劈斩',
noCollapse = false,
expanded = false,
desc = '正面群伤技能，并伴随击退效果。',
},
{
spell = '31340',
title = '火焰之雨',
noCollapse = false,
expanded = false,
desc = '对随机指定区域召唤大范围火之雨，站在其中会受到火焰伤害。',
},
{
spell = '31344',
title = '阿兹加洛之嚎',
noCollapse = false,
expanded = false,
desc = '群体沉默，持续数秒。',
},
{
spell = '31347',
title = '厄运',
noCollapse = false,
expanded = false,
desc = '诅咒一个目标，使其一段时间后死亡，并生成一个末日守卫。',
},
},
desc = '阿兹加洛前的小怪需要注意新增的地狱犬和地狱火，BOSS战期间阿兹加洛会范围极广的群体沉默，因此要提前给坦克加各种持续性治疗手段，确保坦克血量，同样需要注意不要让萨尔死亡。',
},
},
[1569] = {
bossId = 1569,
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '1.人形阶段坦克将BOSS拉至场地中间，在BOSS释放旋风斩期间也要不断对BOSS造成仇恨，以免旋风斩结束后治疗OT，旋风斩结束后将BOSS拉回原位。\n2.恶魔阶段火炕术士坦克最远距离攻击BOSS拉住仇恨，确保BOSS技能不会伤害到近战。\n3.BOSS血量低于15%后，主坦拉住人形，SS坦拉住恶魔形态，直至人形被击杀。',
},
{
role = 'MELEE',
expanded = false,
desc = '1.人形阶段时在BOSS背后输出，旋风斩期间分散躲避，旋风斩结束之后等坦克拉住仇恨再输出。\n2.恶魔阶段时优先击杀自己的内心之魔，BOSS血量低于15%后全力输出人形BOSS。',
},
{
role = 'RANGE',
expanded = false,
desc = '1.人形阶段时分散站位，旋风斩期间停止输出，旋风斩结束之后等坦克拉住仇恨再输出。\n恶魔阶段时远离SS坦克，优先击杀自己的内心之魔，BOSS血量低于15%后全力输出人形BOSS。',
},
{
role = 'HEALER',
expanded = false,
desc = '1.分散站位治疗全团，旋风斩期间注意坦克血量，放缓治疗，避免拉到BOSS仇恨。\n2.恶魔阶段时远离SS坦克，注意SS坦克血量，优先击杀自己的内心之魔。\n3.BOSS血量低于15%后全力治疗全团。',
},
},
desc = '盲眼者莱欧瑟拉斯战斗需要先击杀3个小怪，释放出盲眼者莱欧瑟拉斯后才能开始，人形阶段持续约1分钟，释放2次旋风斩后进入恶魔阶段，恶魔形态需要火炕术士坦克拉住，期间会释放内心之魔，无法击杀内心之魔的玩家会被BOSS控制，持续约40秒后进入人形阶段，两个阶段交替直至血量低于15%，人形和恶魔会同时出现，但此时恶魔形态不会再释放内心之魔，迅速击杀人形态即可结束战斗。',
},
name = '盲眼者莱欧瑟拉斯',
icon = '1385751',
abilities = {
children = {
{
spell = '37640',
noCollapse = false,
expanded = false,
desc = '人形态技能，对范围10码内玩家造成大量伤害，并附带撕裂伤害，该技能无法打断，期间会清空仇恨。',
},
{
spell = '37675',
expanded = false,
noCollapse = false,
children = {
},
desc = '恶魔形态技能，对目标及目标周围10码范围内的玩家造成火焰伤害，并附带受到的火焰伤害增加的debuf，可叠加5次。',
},
{
spell = '37905',
title = '内心之魔',
children = {
},
noCollapse = false,
expanded = false,
desc = '恶魔形态技能，召唤一个和某一玩家血量相同的恶魔怪，该恶魔怪会释放暗影箭，只能由该玩家击杀。',
},
},
desc = '盲眼者莱欧瑟拉斯战斗开始后，BOSS会在人形态和恶魔形态下不断切换，当血量降低至15%的时候两种形态会同时在场，需要迅速击杀人形态才能结束战斗。',
},
},
[727] = {
bossId = 727,
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '高阶术士奥蕾塞丝需要一个高耐力的SS做坦克，SST开怪，在台阶下拉住BOSS，一旦地面燃烧了立即离开，在一个范围内小步移动，确保不会一直被燃烧，烈焰触摸过高时需要承受一下暗影伤害消除debuff。若优先击杀的是女王，则需要SST在奥蕾塞丝放暗影新星时跑到大团处，帮助大团消除烈焰触摸。\n开怪后，三个常规T在台阶下给萨洛拉丝女王上仇恨，确保前三仇恨是T，一旦当前T仇恨丢失或被迷惑，另外两个T立即拉住BOSS，中了点燃的人跑出大团，暗影触摸过高时需要去踩一下地面的火圈消除debuff。\n',
},
{
role = 'HEALER',
expanded = false,
desc = '分配一个治疗去给SST加血，其他人在台阶上方集合站位治疗全团，注意烈焰灼伤和中燃烧的人，若自身中了燃烧也需要跑出大团，若优先击杀的是女王，则需要下台阶集中站在奥蕾塞丝背后治疗全团。',
},
{
role = 'MELEE',
expanded = false,
desc = '根据指挥分配BOSS背后输出，中了燃烧的人跑出大团，一旦身上的debuff高了，就需要去踩地上的火圈或者承受暗影伤害来消除debuff。',
},
{
role = 'RANGE',
expanded = false,
desc = '在台阶上方集合站位输出BOSS，中了燃烧的人跑出大团。暗影触摸过高需要去踩地上的火圈消除，烈焰触摸过高则需要下去承受一次暗影伤害消除。若优先击杀的是女王，则需要下台阶集中站在奥蕾塞丝背后输出。',
},
},
desc = '艾瑞达双子需要三个T给萨洛拉丝女王上仇恨，高耐力的SS来坦住高阶术士奥蕾塞丝，一旦身上的debuff高了，就需要去踩地上的火圈或者承受暗影伤害来消除debuff，听从指挥先击杀一个BOSS，再击杀另一个，BOSS六分钟狂暴。',
},
name = '艾瑞达双子',
icon = '1390438',
abilities = {
children = {
{
title = '萨洛拉丝女王技能',
noCollapse = false,
expanded = true,
children = {
{
spell = '45185',
title = '混乱重击',
noCollapse = false,
expanded = false,
desc = '对目标造成大量的伤害，并使其迷惑，造成仇恨丢失。',
},
{
spell = '45248',
title = '暗影之刃',
noCollapse = false,
expanded = false,
desc = '对范围内数个目标造成大量暗影伤害，并降低移动速度，可叠加。',
},
{
spell = '45347',
title = '暗影触摸',
noCollapse = false,
expanded = false,
desc = '女王的暗影伤害会降低目标承受的治疗效果，可一直叠加到100%。火焰伤害均可移除此效果。',
},
{
spell = '45329',
title = '暗影新星',
noCollapse = false,
expanded = false,
desc = '对目标范围内所有人造成暗影伤害。',
},
{
spell = '45366',
title = '黑色魅影',
noCollapse = false,
expanded = false,
desc = '女王会每隔一段时间召唤数个黑色镜像，这些镜像会随机冲向团队成员造成暗影伤害并击晕，持续一段时间后镜像会消失。',
},
},
},
{
title = '高阶术士奥蕾塞丝技能',
noCollapse = false,
expanded = true,
children = {
{
spell = '45230',
title = '高热',
noCollapse = false,
expanded = false,
desc = '奥蕾塞丝自身buff，提高火焰伤害，可偷取或驱散。',
},
{
spell = '46771',
title = '烈焰触摸',
noCollapse = false,
expanded = false,
desc = '奥蕾塞丝的所有火焰伤害都会使目标持续性受到火焰伤害，最多可叠加20层，受到萨洛拉丝女王的暗影伤害可移除此效果。',
},
{
spell = '45342',
title = '燃烧',
noCollapse = false,
expanded = false,
desc = '奥蕾塞丝的所有火焰伤害都会使目标持续性受到火焰伤害，最多可叠加20层，受到萨洛拉丝女王的暗影伤害可移除此效果。',
},
{
spell = '45235',
title = '光芒',
noCollapse = false,
expanded = false,
desc = '使目标脚下的地面燃烧，造成持续性火焰伤害。',
},
{
spell = '46771',
title = '烈焰灼伤',
noCollapse = false,
expanded = false,
desc = '随机指定数个目标释放烈焰灼伤，数秒内承受持续性的火焰伤害。这些伤害每次都会叠加新的烈焰触摸。',
},
},
},
},
desc = '艾瑞达双子分别是萨洛拉丝女王和高阶术士奥雷塞斯，萨洛拉丝女王使用暗影系法术，高阶术士奥蕾塞丝使用火系法术。两个BOSS血量不共享，一方倒下另一个立即回满血。整场战斗中充斥着大量的群攻和持续性伤害，还有各种增幅承受伤害的debuff，不过可以通过另一方的技能来消除这些debuff。',
},
},
[1194] = {
bossId = 1194,
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = 'T将BOSS拉在场地中间即可，三阶段躲避好龙卷风',
},
{
role = 'MELEE',
expanded = false,
desc = '站在BOSS背后输出，躲避好一阶段的旋风斩和三阶段的龙卷风，每次转换阶段注意仇恨',
},
{
role = 'RANGE',
expanded = false,
desc = '远程分散站位，二阶段施放麻痹时集合以便于牧师群体驱散，三阶段时使用最长施法时间的技能攻击BOSS，躲避好龙卷风，五阶段被点名火柱及时躲开，每次转换阶段注意仇恨',
},
{
role = 'HEALER',
expanded = false,
desc = '分散站位治疗，一阶段需要注意中流血的玩家，血刷满才能解除流血效果。二阶段施放麻痹时集合以便于牧师群体驱散，优先驱散T和治疗的麻痹。三阶段时使用最长施法时间的技能加血，躲避好龙卷风，四阶段需要注意被BOSS点名的目标的血量。五阶段被点名火柱及时躲开，刷好点名玩家血量',
},
},
desc = '祖尔金下降20%血量就会进入下一个阶段，每次转换阶段都会清除仇恨。人形态近战需要躲开旋风斩，熊形态则需要牧师驱散好麻痹，雄鹰形态需要躲开龙卷风，山猫形态需要治疗注意被点名的玩家，最后的龙鹰全力输出即可',
},
name = '祖尔金',
icon = '522217',
abilities = {
children = {
{
children = {
{
spell = '36175',
title = '旋风斩',
noCollapse = false,
expanded = false,
desc = '对周围敌人造成物理伤害',
},
{
spell = '43093',
title = '重伤投掷',
noCollapse = false,
expanded = false,
desc = '对随机目标造成大量物理伤害，并附带持续性的流血效果，流血需要完全治愈才能中止',
},
},
noCollapse = false,
title = '人形态技能',
expanded = true,
},
{
children = {
{
spell = '43095',
title = '麻痹蔓延',
noCollapse = false,
expanded = false,
desc = '对所有玩家释放麻痹效果，6秒后会造成大量自然伤害并昏迷，可驱散',
},
},
noCollapse = false,
title = '巨熊形态',
expanded = true,
},
{
children = {
{
spell = '43983',
title = '能量风暴',
noCollapse = false,
expanded = false,
desc = '风暴笼罩全场，每次施法都会使施法者受到伤害',
},
{
spell = '41954',
title = '羽毛漩涡',
children = {
},
noCollapse = false,
expanded = false,
desc = '场地内出现龙卷风，触碰到的玩家将会受到自然伤害并击退',
},
},
noCollapse = false,
title = '雄鹰形态',
expanded = true,
},
{
children = {
{
spell = '43150',
title = '利爪之怒',
noCollapse = false,
expanded = false,
desc = '跳向随机目标，使其定身，并在接下来一段时间内受到数次利爪攻击的伤害，每次伤害都会附带受到伤害增加的debuff',
},
{
spell = '43153',
title = '山猫冲锋',
noCollapse = false,
expanded = false,
desc = '随机冲锋一个目标，造成大量物理伤害，并附带持续性流血伤害',
},
},
noCollapse = false,
title = '山猫形态',
expanded = true,
},
{
children = {
{
spell = '43208',
title = '烈焰旋风',
noCollapse = false,
expanded = false,
desc = '旋转喷吐火焰，对周围玩家造成火焰伤害并使其受到的火焰伤害提高',
},
{
spell = '23461',
title = '火息术',
children = {
},
noCollapse = false,
expanded = false,
desc = '对面前的目标造成大量火焰伤害',
},
{
spell = '43218',
title = '火焰之怒',
children = {
},
noCollapse = false,
expanded = false,
desc = '在随机目标处施放一根火柱，对身在其中的玩家造成持续性伤害',
},
},
noCollapse = false,
title = '龙鹰形态',
expanded = true,
},
},
desc = '祖尔金是祖阿曼最后BOSS，战斗分为5个阶段，每降低20%的血量就进入下一个阶段。第一阶段为人形态，80%血量进入第二阶段巨熊形态，60%血量进入第三阶段雄鹰形态，40%血量进入第四阶段山猫形态，20%血量进入五阶段龙鹰形态',
},
},
[653] = {
bossId = 653,
summary = {
children = {
{
desc = '主T将莫罗斯拉至台子下，副T保持莫罗斯的第二仇恨，在主T被致盲或者凿击之后拉住BOSS仇恨。被控制随从先不要去动，直到其他随从已被击杀再听从指挥拉住随从仇恨。\n注意：无论何种组合，随从击杀顺序推荐如下：卡翠欧娜·沃宁迪女伯爵>吉拉·拜瑞巴克女伯爵>杜萝希·米尔斯迪普女伯爵>罗宾·达尼斯伯爵>拉弗·德鲁格尔男爵>克里斯宾·费伦斯伯爵。',
role = 'TANK',
},
{
desc = '根据指挥分配治疗，注意被绞喉玩家血量。\n注意：牧师听从指挥优先使用束缚亡灵控制随从。',
role = 'HEALER',
},
{
desc = '按照指挥所说顺序击杀随从和莫罗斯。\n注意：无论何种组合，随从击杀顺序推荐如下：卡翠欧娜·沃宁迪女伯爵>吉拉·拜瑞巴克女伯爵>杜萝希·米尔斯迪普女伯爵>罗宾·达尼斯伯爵>拉弗·德鲁格尔男爵>克里斯宾·费伦斯伯爵。',
role = 'MELEE',
},
{
desc = '按照指挥所说顺序击杀随从和莫罗斯。法师和猎人可以辅助牧师控制随便，帮忙冰环或者冰冻陷阱。\n注意：无论何种组合，随从击杀顺序推荐如下：卡翠欧娜·沃宁迪女伯爵>吉拉·拜瑞巴克女伯爵>杜萝希·米尔斯迪普女伯爵>罗宾·达尼斯伯爵>拉弗·德鲁格尔男爵>克里斯宾·费伦斯伯爵。',
role = 'RANGE',
},
},
desc = '卡拉赞二号BOSS是莫罗斯，莫罗斯周围会带有4个随从，这4个随从是从6个固定的随从中随机刷新的。莫罗斯最主要技能时绞喉，随机目标持续五分钟，所以战斗越久队伍压力越大，莫罗斯和4个随从击杀顺序的安排就尤为重要。',
},
abilities = {
children = {
{
noCollapse = true,
title = '卡翠欧娜·沃宁迪女伯爵',
children = {
{
desc = '驱散目标身上魔法效果。',
spell = 15090,
},
{
desc = '为友方加上魔法护盾，吸收伤害。',
spell = 29408,
},
{
desc = '治疗友方目标。',
spell = 34119,
},
},
},
{
noCollapse = true,
title = '吉拉·拜瑞巴克女伯爵',
children = {
{
desc = '使附近友方目标攻击强度增加。',
spell = 29381,
},
{
desc = '治疗友方目标。',
spell = 29562,
},
},
},
{
noCollapse = true,
title = '杜萝希·米尔斯迪普女伯爵',
children = {
{
desc = '进入暗影形态，造成暗影伤害提高，受到近战伤害降低。',
spell = 29406,
},
{
desc = '抽取附近玩家法力值并使其受到伤害。',
spell = 29405,
},
},
},
{
noCollapse = true,
title = '罗宾·达尼斯伯爵',
children = {
{
desc = '对玩家造成大量物理伤害，并使任何对目标释放的治疗效果减弱，持续5秒。',
spell = 29572,
},
{
desc = '对玩家造成武器伤害，并使其移动速度降低。',
spell = 9080,
},
{
desc = '对周围所有玩家造成物理伤害。',
spell = 15589,
},
},
},
{
noCollapse = true,
title = '拉弗·德鲁格尔男爵',
children = {
{
desc = '使目标昏迷，持续5秒。',
spell = 13005,
},
{
desc = '审判玩家，造成神圣伤害。',
spell = 29386,
},
},
},
{
noCollapse = true,
title = '克里斯宾·费伦斯伯爵',
children = {
{
desc = '使用盾牌猛击敌人，打断并造成武器伤害。',
spell = 11972,
},
{
desc = '使敌人无法使用武器作战，持续10秒。',
spell = 8379,
},
},
},
{
noCollapse = true,
title = '莫罗斯',
children = {
{
desc = 'BOSS进入潜行状态。',
spell = 29448,
},
{
desc = '对玩家造成伤害并使其昏迷6秒，技能会在玩家面对BOSS的时候发动。',
spell = 29425,
},
{
desc = '使目标短暂失明并到处乱走。',
spell = 21060,
},
{
desc = '随机绞喉一名玩家，使其受到持续伤害，持续5分钟。',
spell = 37066,
},
{
desc = 'BOSS血量降低至30%进入激怒状态，伤害和攻击速度提高。',
spell = 8599,
},
},
},
},
desc = '莫罗斯身边会有四个随从，每次都是从六个随从内随机选取四个随从。可根据队伍配置选择先击杀的随从数量，剩余的可保持控制，BOSS击杀后再杀。\n各随从技能如下：',
},
icon = 1378999,
name = '莫罗斯',
},
[1568] = {
bossId = 1568,
summary = {
children = {
{
children = {
},
role = 'TANK',
expanded = false,
desc = 'P1：坦克需要站在无法被击飞的位置拉住BOSS，喷涌结束后迅速返回。鱼斯拉周围水域为热水，在潜水期间不要跳动，否则会加速血量减少速度。\nP2：根据指挥分配拉好中间台子或外围三个台子上的纳迦。',
},
{
role = 'MELEE',
expanded = false,
desc = 'P1：在BOSS两侧输出，BOSS喷涌时潜水躲避，喷涌完毕等待一会，旋风技能过后即可返回输出BOSS。鱼斯拉周围水域为热水，在潜水期间不要跳动，否则会加速血量减少速度。\nP2：根据指挥分配一一击杀中间台子的近战纳迦。',
},
{
role = 'RANGE',
expanded = false,
desc = 'P1：站在中间平台外圈或者外面的三个小平台上输出BOSS，BOSS喷涌时潜水躲避，喷涌结束返回平台继续输出。鱼斯拉周围水域为热水，在潜水期间不要跳动，否则会加速血量减少速度。\nP2：优先击杀自身平台上出现的远程纳迦，之后击杀中间平台的近战纳迦。法师根据分配羊好怪。',
},
{
role = 'HEALER',
expanded = false,
desc = 'P1：治疗好全团，BOSS喷涌时潜水躲避，且注意水里所有人的血量。喷涌结束返回平台继续治疗。鱼斯拉周围水域为热水，在潜水期间不要跳动，否则会加速血量减少速度。\nP2：注意所有人血量。',
},
},
desc = '鱼斯拉需要使用钓鱼技能钓出水面，然后开始战斗。水面的P1阶段会有360度的喷涌，所有玩家需要潜水躲避喷涌，P2阶段BOSS下潜后会在4个平台上共召唤9个纳迦，外围平台上各2个纳迦弓箭手，中间平台是3个纳迦战士，需要根据分配控制击杀。',
},
name = '鱼斯拉',
icon = '1385768',
abilities = {
children = {
{
spell = '10987',
children = {
},
noCollapse = false,
expanded = false,
desc = '喷射喷泉，对目标造成冰霜伤害并击退。',
},
{
spell = '37433',
children = {
},
noCollapse = false,
expanded = false,
desc = '每隔一段时间，鱼斯拉会从当前仇恨目标方向开始旋转喷涌水柱，顺时针或者逆时针旋转360度。被喷到目标会被击飞。',
},
{
spell = '40654',
noCollapse = false,
expanded = false,
desc = '对近战范围内目标造成大量物理伤害并击退。',
},
},
desc = '鱼斯拉是需要使用钓鱼技能钓上来的BOSS，全程分为两个阶段，P1鱼斯拉出现，需要坦克拉住，期间需要躲避鱼斯拉的喷涌技能。一小段时间后会进入P2阶段，鱼斯拉下潜，召唤纳迦小怪，大约1分钟后鱼斯拉会再度出现继续P1阶段，重复两个阶段直至击杀BOSS。\n1.喷泉（37138）：喷射喷泉，对目标造成冰霜伤害并击退。',
},
},
[1193] = {
bossId = 1193,
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '主T拉住BOSS，副T将无法控制的小怪拉住。若BOSS吸取了骑士的灵魂，主T注意躲开脚下的奉献',
},
{
role = 'HEALER',
expanded = false,
desc = 'BOSS施放全体暗影箭时注意刷好全团血量，BOSS吸取灵魂后尤其要刷好T的血，优先驱散各种技能',
},
{
role = 'MELEE',
expanded = false,
desc = '听从指挥优先输出需要击杀的小怪，再去输出BOSS，若BOSS吸取了骑士的灵魂，就需要注意躲开奉献技能，打断好BOSS可能会施放的治疗法术。若吸取了战士的灵魂，注意躲开旋风斩。吸取了萨满灵魂则需要优先打掉图腾',
},
{
role = 'RANGE',
expanded = false,
desc = '听从指挥法师羊怪、术士放逐、猎人冰冻陷阱，优先输出需要击杀的小怪，再分散站位输出BOSS，期间注意补各种控制技能',
},
},
desc = '妖术领主玛拉卡斯战斗开始后可以全部击杀小怪，也可以通过放逐、变羊等手段控制小怪。由于BOSS每30秒会吸收能量，使得BOSS伤害增加，相当于有个软狂暴，因此需要全力输出',
},
name = '妖术领主玛拉卡斯',
icon = '522235',
abilities = {
children = {
{
children = {
{
expanded = false,
noCollapse = false,
title = '黑心（亡灵）',
desc = '鬼魂，会对范围内玩家造成暗影伤害，会释放群体恐惧',
},
{
expanded = false,
noCollapse = false,
title = '库拉格（亡灵）',
desc = '亡灵巨人，会施放群体诅咒',
},
{
expanded = false,
noCollapse = false,
title = '滑行者（野兽）',
desc = '毒蛇，会吐出毒液，对目标造成自然伤害并附带持续伤害',
},
{
expanded = false,
noCollapse = false,
title = '卡扎克洛斯（恶魔）',
desc = '小鬼，会对目标射出火焰箭，造成火焰伤害',
},
{
expanded = false,
noCollapse = false,
title = '沼泽猎手（元素）',
desc = '毒性攻击，使目标受到伤害并中毒',
},
{
expanded = false,
noCollapse = false,
title = '阿莱松·安提雷（人型）',
desc = '血精灵，会释放奥术洪流沉默玩家，还会释放快速治疗和惩击',
},
{
expanded = false,
noCollapse = false,
title = '索尔格（人型）',
desc = '食人魔，近战怪物',
},
{
expanded = false,
noCollapse = false,
title = '兰尔丹（龙类）',
desc = '龙人战士，会雷霆和火焰吐息',
},
},
noCollapse = false,
title = '8个精英怪和对应技能如下',
expanded = false,
},
{
children = {
{
spell = '43383',
title = '灵魂之箭',
noCollapse = false,
expanded = false,
desc = '引导技能，对所有玩家发射暗影箭，引导期间会造成持续性的暗影伤害',
},
{
spell = '44131',
title = '吸取能量',
noCollapse = false,
expanded = false,
desc = '吸取所有人的力量，使其造成的伤害降低，BOSS伤害增加，每30秒一次',
},
{
spell = '43501',
title = '灵魂虹吸',
children = {
{
expanded = false,
noCollapse = false,
title = '战士',
desc = '法术反射、旋风斩、致死打击',
},
{
expanded = false,
noCollapse = false,
title = '骑士',
desc = '奉献、圣光术',
},
{
expanded = false,
noCollapse = false,
title = '萨满祭司',
desc = '火焰新星图腾、治疗波、闪电链',
},
{
expanded = false,
noCollapse = false,
title = '猎人',
desc = '各种陷阱',
},
{
expanded = false,
noCollapse = false,
title = '潜行者',
desc = '致盲、切割、毒药',
},
{
expanded = false,
noCollapse = false,
title = '德鲁伊',
desc = '生命绽放、荆棘术、月火',
},
{
expanded = false,
noCollapse = false,
title = '牧师',
desc = '精神鞭笞、心灵控制、治疗术、心灵尖啸、心灵震爆',
},
{
expanded = false,
noCollapse = false,
title = '法师',
desc = '火球、寒冰箭、冰霜新星',
},
{
expanded = false,
noCollapse = false,
title = '术士',
desc = '火焰之雨、诅咒、恐惧',
},
},
noCollapse = false,
expanded = true,
desc = '吸取随机目标的灵魂，根据其职业获得部分技能，技能如下：',
},
},
noCollapse = false,
title = '妖术领主玛拉卡斯技能',
expanded = true,
},
},
desc = '妖术领主玛拉卡斯战斗会有5个目标，BOSS加4个精英怪，这4个精英怪是从8个怪中随机抽取4个组合在一起，BOSS会随机吸取在场职业的灵魂，不同的职业拥有不同的技能',
},
},
[1192] = {
bossId = 1192,
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '需要两个T重合站位，分担伤害，副T需要拉住萨满形态时召唤出的山猫',
},
{
role = 'MELEE',
expanded = false,
desc = '站在BOSS背后输出，优先转火图腾，出现山猫时优先攻击',
},
{
role = 'RANGE',
expanded = false,
desc = '远程分散站位，远离闪电图腾，优先转火图腾，出现山猫时优先攻击，猎人一阶段打好凝神',
},
{
role = 'HEALER',
expanded = false,
desc = '分散站位，远离闪电图腾，所有治疗加好两个T，BOSS萨满状态时注意被震击的人的血量，优先驱散',
},
},
desc = '哈尔拉兹一阶段山猫状态时会施放军刀，需要两个坦克重合站位分担，在血量75%的时候进入二阶段，分裂为萨满和一只山猫之魂，此时萨满和山猫都会满血，将萨满或者山猫打至残血就会恢复正常状态。然后每隔25%的血量就会召唤一次，需要副T拉住山猫，血量25%会进入激怒状态，技能攻击力和释放速度会加快',
},
name = '哈尔拉兹',
icon = '522231',
abilities = {
children = {
{
spell = '32638',
title = '灵魂分裂',
children = {
},
noCollapse = false,
expanded = false,
desc = 'BOSS施展灵魂分裂，对所有玩家造成伤害并分裂出一只山猫之灵',
},
{
spell = '16804',
title = '烈焰震击',
children = {
},
noCollapse = false,
expanded = false,
desc = '对随机目标释放，造成大量伤害和一个持续性的附加伤害，DOT可驱散',
},
{
spell = '43301',
title = '召唤闪电图腾',
noCollapse = false,
expanded = false,
desc = '召唤一根腐化闪电图腾，释放连锁闪电，一定范围内的玩家会受到大量自然伤害',
},
{
spell = '26194',
title = '大地震击',
noCollapse = false,
expanded = false,
desc = '攻击随机目标，造成大量的自然伤害，打断其施法并在短时间内无法再施法',
},
},
desc = '哈尔拉兹是山猫之灵，他有二个阶段，一阶段是山猫形态，在血量75%的时候进入二阶段，分裂为满血的萨满和一只山猫之魂，然后每隔25%的血量就会分裂一次，最后的 25%血量后还会进入激怒状态，提升攻击力，并获得烈焰震击和闪电图腾的能力',
},
},
[1108] = {
bossId = 1108,
name = '格拉斯',
zone = 4,
abilities = {
children = {
{
title = '重伤',
desc = '对主T释放，受到治疗效果减少10%，可叠加。',
},
{
title = '激怒',
desc = '攻击间隔缩短25%，持续8秒。',
},
{
title = '残杀',
desc = '每隔一段时间，会把BOSS房间内任何玩家或小怪的血量都降低至5%。此时小僵尸会无视仇恨走向BOSS。',
},
{
title = '召唤僵尸',
desc = '战斗开始后，房间井口附近会不断刷新僵尸，BOSS会吞噬靠近自己的僵尸，每吞噬一只恢复BOSS 5%的血量。',
},
{
title = '群体恐惧',
desc = '每隔20秒将会恐惧所有20码范围内玩家。',
},
},
desc = 'BOSS战斗开始后，房间内3个窗口位置会不断刷新小僵尸，小僵尸吃一切控制技能。',
},
url = 'https://www.bilibili.com/video/BV1dr4y1w7gW?p=9',
icon = 1378977,
summary = {
children = {
{
desc = '1.主T将BOSS拉至门口位置，副T一起制造仇恨。主T身上重伤叠加层数过高时副T接手，期间注意防恐惧。\n2.拉小僵尸的T在残杀前风筝好小僵尸，残杀结束后继续拉住其他小僵尸仇恨，远离BOSS。',
role = 'TANK',
},
{
desc = '1.和远程一起集中站位治疗。\n2.BOSS残杀后第一时间刷好T的血量。\n注意：矮牧给拉BOSS坦克刷好反恐惧结界。',
role = 'HEALER',
},
{
desc = '1.进入战斗后靠近主T位置输出。被恐惧后第一时间回到BOSS边上继续输出。\n2.残杀后优先击杀小僵尸，阻止僵尸靠近BOSS。',
role = 'MELEE',
},
{
desc = '1.进入战斗后集中站位，最远距离输出BOSS。\n2.LR打好宁神。\n3.残杀后优先控制击杀小僵尸。\n4.分配好的远程辅助副T风筝小僵尸，例如猎人冰霜陷阱等。',
role = 'RANGE',
},
},
},
},
[1191] = {
bossId = 1191,
summary = {
children = {
{
children = {
},
role = 'TANK',
expanded = false,
desc = '主T将BOSS拉在场地中间，出现火焰炸弹时躲避炸弹，副T拉住孵化出的小龙鹰，等待法师减速后击杀小龙鹰和孵化者',
},
{
children = {
},
role = 'MELEE',
expanded = false,
desc = '尽可能的分散站位输出BOSS，躲避BOSS烈焰喷吐技能，出现火焰炸弹时注意和炸弹之间的距离，避免爆炸时受到伤害',
},
{
children = {
},
role = 'RANGE',
expanded = false,
desc = '1.远程DPS根据指挥分配分散站在两侧，躲避BOSS烈焰喷吐技能，出现火焰炸弹时注意和炸弹之间的距离，避免爆炸时受到伤害\n2.出现小龙鹰时猎人冰冻陷阱、FS暴风雪减速，控制住后A掉\n',
},
{
children = {
},
role = 'HEALER',
expanded = false,
desc = '分散站位，躲避BOSS烈焰喷吐技能，出现火焰炸弹时注意和炸弹之间的距离，避免爆炸时受到伤害。注意拉龙鹰的T的血量',
},
},
desc = '加亚莱战斗需要估量左右两侧孵化出的龙鹰数量，可以考虑先孵化一侧的蛋，避免在最后全部孵化时数量过多。火焰炸弹时注意和炸弹之间的距离，及时躲避',
},
name = '加亚莱',
icon = '522242',
abilities = {
children = {
{
spell = '43962',
title = '召唤孵化者',
noCollapse = false,
expanded = false,
desc = '召唤2个人形怪，前往场地两侧开蛋，孵化出小龙鹰，第一次1只，第二次2只，以此类推',
},
{
spell = '43140',
title = '烈焰吐息',
noCollapse = false,
expanded = false,
desc = '对随机目标施放一条线性的火焰，对目标及范围内玩家都造成大量火焰伤害',
},
{
spell = '42630',
title = '火焰炸弹',
noCollapse = false,
expanded = false,
desc = 'BOSS将所有人传送到场地中间，在地面上放置一个个圆形炸弹，数秒后爆炸，对范围内玩家造成巨量伤害',
},
{
spell = '43144',
title = '催化',
children = {
},
noCollapse = false,
expanded = false,
desc = '一次性孵化所有未孵化的蛋',
},
},
desc = '加亚莱是龙鹰之灵，整场战斗除了面对BOSS外，还要注意左右两侧的蛋，BOSS会召唤人型前往左右两侧孵化出龙鹰，没有孵化完的会在BOSS血量到35%左右时一次性全部孵化，需要及时处理孵化出的龙鹰。战斗期间还需要躲避出现的火焰炸弹，BOSS血量到达25%左右会狂暴，攻击力和攻击速度提高',
},
},
[1190] = {
bossId = 1190,
summary = {
children = {
{
children = {
},
role = 'TANK',
expanded = false,
desc = '人形态时副T拉住，主T站一起承担伤害，转换成熊形态时主T第一时间嘲讽拉住BOSS，熊形态时T的压力较大，需要随时开技能自保',
},
{
children = {
},
role = 'MELEE',
expanded = false,
desc = '近战DPS全力输出即可，转换形态时注意仇恨',
},
{
children = {
},
role = 'RANGE',
expanded = false,
desc = '远程DPS分散站位最远距离输出，人形态时被冲锋后靠近BOSS，避免被第二次冲锋',
},
{
children = {
},
role = 'HEALER',
expanded = false,
desc = '分散站位，熊形态期间注意T的血，保持T身上的HOT，确保T不会在沉默期间倒下',
},
},
desc = '纳洛拉克人形时会随机冲锋远程，被冲锋的需要靠近BOSS输出。熊形态时坦克压力较大，可以两个坦克轮流拉住仇恨，以免坦克死亡。',
},
name = '纳洛拉克',
icon = '522254',
abilities = {
children = {
{
children = {
{
spell = '42389',
title = '裂伤',
children = {
},
noCollapse = false,
expanded = false,
desc = '使当前目标受伤，承受100%的额外流血伤害。',
},
{
spell = '42402',
title = '奔袭',
noCollapse = false,
expanded = false,
desc = '随机冲锋一个远程目标，对其造成伤害后返回原位，同时会造成范围的击退效果。',
},
{
spell = '42384',
title = '野蛮横扫',
children = {
},
noCollapse = false,
expanded = false,
desc = '对当前的目标造成大量物理伤害，可被其他人分担。',
},
},
noCollapse = false,
title = '人形态技能',
expanded = true,
},
{
children = {
{
spell = '42397',
title = '撕裂',
children = {
},
noCollapse = false,
expanded = false,
desc = '使当前目标流血，持续性造成大量伤害。',
},
{
spell = '42395',
title = '刺裂',
noCollapse = false,
expanded = false,
desc = '对当前目标造成大量伤害，并在接下来的时间再造成一个持续性的伤害。',
},
{
spell = '42398',
title = '震耳咆哮',
noCollapse = false,
expanded = false,
desc = '对所有人造成物理伤害并沉默5秒。',
},
},
noCollapse = false,
title = '熊形态技能',
expanded = true,
},
},
desc = '纳洛拉克是巨熊之灵，BOSS一共有两个形态，一开始为人形，45秒后将变幻成巨熊形态，再过20秒会切换回人形，两个形态会不断切换直至BOSS倒下。',
},
},
[709] = {
bossId = 709,
abilities = {
children = {
{
desc = '随机控制玩家20秒，被控制玩家体型增大，攻击力、移动速度、各种抗性增强，不可驱散。',
spell = 785,
},
{
desc = '对范围15码内玩家造成1500左右奥术伤害。',
spell = 26192,
},
{
desc = '当BOSS仇恨目标不在近战范围内时，会每秒对随机玩家释放震击，造成2500左右伤害。',
spell = 26194,
},
{
desc = '随机传送至3个平台的固定位置上，并清空仇恨。',
spell = 20449,
},
{
desc = '当BOSS血量降至75%、50%、25%时，会召唤2个分身幻象，幻象具有本体一样的血量和技能。',
spell = 747,
},
},
},
name = '预言者斯克拉姆',
summary = {
children = {
{
desc = '1.3个坦克分别站在3个平台上，若BOSS或者分身传送到位置，则第一时间坦住。\n2.打断BOSS或者分身的奥爆技能。',
role = 'TANK',
},
{
desc = '分为2组站在BOSS平台的斜坡上，保持全团的血量。\n牧师、骑士优先驱散已恢复正常的玩家的变形术。\n',
role = 'HEALER',
},
{
desc = '输出BOSS，优先打断奥爆技能。',
role = 'MELEE',
},
{
desc = '分散站位，输出BOSS。\n法师优先对被控制的玩家释放变形术。\n',
role = 'RANGE',
},
},
},
icon = 1385769,
desc = '预言者斯克拉姆是安其拉神殿的一号BOSS，只有击杀他，才能打开安其拉神殿的大门。',
},
[717] = {
bossId = 717,
abilities = {
children = {
{
noCollapse = true,
title = 'P1克苏恩之眼阶段',
children = {
{
desc = '随机对一名玩家造成大量自然伤害，若该玩家10码范围内有另一名玩家，则伤害跳转至另一名玩家并伤害翻倍，无限递增。',
spell = 26134,
},
{
desc = '每隔45秒BOSS会随机盯着一个方向，3秒后射出红色光线，并随机方向转动红光180度左右，持续40秒，期间触碰到红光的玩家会被秒杀。',
spell = 26029,
},
{
title = '眼球触须',
children = {
{
desc = '触须刷新时，对附近玩家造成1500左右伤害并击飞。',
spell = 26478,
},
{
desc = '对随机玩家释放，每秒造成750点暗影伤害并降低移动速递，持续10秒。',
spell = 18808,
},
},
desc = '每隔45秒会在BOSS周围黑水边界上固定8个位置刷新眼球触须，眼球触须技能如下：',
},
{
title = '利爪触须',
children = {
{
desc = '触须刷新时，对附近玩家造成1500左右伤害并击飞。',
spell = 26478,
},
{
desc = '降低玩家移动速度，持续10秒。',
spell = 26141,
},
},
desc = '随机位置召唤，对附件玩家造成少量物理伤害，若近战范围内10秒没有玩家，则下地在其他玩家脚下重新刷新，触须技能如下：',
},
},
},
{
children = {
{
title = '眼球触须',
children = {
{
desc = '触须刷新时，对附近玩家造成1500左右伤害并击飞。',
spell = 26478,
},
{
desc = '对随机玩家释放，每秒造成750点暗影伤害并降低移动速递，持续10秒。',
spell = 18808,
},
},
desc = '每隔45秒会在BOSS周围黑水边界上固定8个位置刷新眼球触须，眼球触须技能如下：',
},
{
title = '巨钩触须',
children = {
{
desc = '触须刷新时，对附近玩家造成1500左右伤害并击飞。',
spell = 26478,
},
{
desc = '若近战范围内没有玩家，则大触须潜入地下恢复全部生命值并在随机其他玩家脚下出现。',
spell = 7201,
},
{
desc = '攻击时可能造成额外一次攻击。',
spell = 11607,
},
{
desc = '击倒附件所有玩家，并造成2秒昏迷效果。',
spell = 6524,
},
},
desc = '每隔60秒，会在随机玩家脚下刷新，造成高额伤害。技能如下：',
},
{
title = '巨眼触须',
desc = '每隔60秒，会在随机玩家脚下刷新，刷新时造成击飞效果，并释放眼棱（26134）。',
},
{
title = '巨口触须',
children = {
{
desc = '处于克苏恩体内时，每5秒受到一次自然伤害，可无限叠加。',
spell = 26476,
},
{
title = '血肉触须',
desc = '克苏恩体内有2根血肉触须，会对附近玩家造成物理伤害。当血肉触须均被击杀，则克苏恩进入虚弱阶段，持续45秒。',
},
{
noCollapse = true,
title = '注意',
desc = '玩家站在两根触须中间的平台上，则会被呕吐出体内，回到外场。',
},
},
desc = 'BOSS召唤巨口触须，将随机玩家吞噬进内场。内场技能如下：',
},
},
noCollapse = true,
title = 'P2克苏恩阶段',
desc = 'BOSS本体受到所有伤害降低99%。需击杀内场触须方可进入虚弱状态，虚弱阶段克苏恩将受到100%全额伤害。',
},
},
},
name = '克苏恩',
summary = {
children = {
{
children = {
{
title = 'P1阶段',
desc = '1.根据指挥分配，和主T保持10码距离进入战斗场地，并站好位置输出。\n2.输出时确保周围10码无其他玩家，实在近战人多，则可以和其他近战重合站位，不超过2人。\n3.当红光出现时，注意自身位置，躲好红光。移动时可帮忙击杀眼球触须和利爪触须，红光结束则返回原地。',
},
{
title = 'P2阶段',
desc = '1.根据指挥所说站位（集中站位或者站P1阶段的位置）。\n2.第一时间击杀巨眼触须、巨型利爪触须和附近的眼球触须。\n3.打断好巨眼触须和眼球触须的读条。\n4.若被吞噬进克苏恩内场，则迅速出来返回外场。\n5.BOSS虚弱时爆发输出。',
},
},
role = 'TANK',
},
{
children = {
{
title = 'P1阶段',
desc = '1.根据指挥分配，和主T保持10码距离进入战斗场地，并于本队近战身后呈伞形散开，和周围玩家保持10码距离站好位置治疗。\n2.当红光出现时，躲好红光，红光结束则返回原地。',
},
{
title = 'P2阶段',
desc = '1.根据指挥所说站位加血（集中站位或者站P1阶段的位置），优先治疗中精神鞭笞玩家。\n2.若被吞噬进克苏恩内场，给内场DPS加血，消化酸液叠加至5层就迅速出来返回外场。\n3.BOSS虚弱时辅助输出。',
},
},
role = 'HEALER',
},
{
children = {
{
title = 'P1阶段',
desc = '1.根据指挥分配，和主T保持10码距离进入战斗场地，并站好位置输出。\n2.输出时确保周围10码无其他玩家，实在近战人多，则可以和其他近战重合站位，不超过2人。\n3.当红光出现时，注意自身位置，躲好红光。移动时可帮忙击杀眼球触须和利爪触须，红光结束则返回原地。\n',
},
{
title = 'P2阶段',
desc = '1.根据指挥所说站位（集中站位或者站P1阶段的位置）。\n2.第一时间击杀巨眼触须、巨型利爪触须和附近的眼球触须。\n3.打断好巨眼触须和眼球触须的读条。\n4.若被吞噬进克苏恩内场，则迅速出来返回外场。\n5.BOSS虚弱时爆发输出。',
},
},
role = 'MELEE',
},
{
children = {
{
title = 'P1阶段',
desc = '1.根据指挥分配，和主T保持10码距离进入战斗场地，并于本队近战身后呈伞形散开，和周围玩家保持10码距离站好位置输出。\n2.输出时确保周围10码无其他玩家，第一时间击杀附近的眼球触须和利爪触须，注意打断眼球触须读条。\n3.当红光出现时，注意自身位置，躲好红光。移动时击杀眼球触须和利爪触须，红光结束则返回原地。',
},
{
title = 'P2阶段',
desc = '1.根据指挥所说站位（集中站位或者站P1阶段的位置）。\n2.第一时间打断眼球触须技能，并迅速击杀。\n3.远程输出巨眼触须和眼球触须。\n4.若被吞噬进克苏恩内场，站上平台攻击血肉触须，消化酸液叠加至5层就迅速出来返回外场。\n5.BOSS虚弱时爆发输出。',
},
},
role = 'RANGE',
},
},
},
icon = 1385726,
desc = '克苏恩全程战斗分为2个阶段，P1阶段只在外场，根据指挥分配8个队伍呈8个方向辐射分散站位（保持10码范围内无其他玩家）。击杀眼球之后出现克苏恩本体进入P2阶段。P2阶段分为内外两部分，将内场的两根血肉触须击杀之后，克苏恩进入虚弱阶段，才能在外场对克苏恩造成伤害。',
},
[725] = {
bossId = 725,
abilities = {
children = {
{
spell = '45185',
title = '践踏',
noCollapse = false,
expanded = false,
desc = '猛击地面，对目标造成物理伤害并降低护甲值。',
},
{
spell = '45150',
title = '流星猛击',
noCollapse = false,
expanded = false,
desc = '对前方范围内的所有目标造成大量火焰伤害，伤害可平摊，并会使击中的目标增加一个受到火焰伤害增幅的debuff。',
},
{
spell = '46394',
title = '燃烧',
noCollapse = false,
expanded = false,
desc = '使一个目标燃烧一段时间，每秒造成火焰伤害，并进入恐慌状态，该状态还会使周围玩家受到灼烧效果。',
},
},
desc = '布鲁塔卢斯的战斗开始后，坦克和治疗的压力非常大，需要队友帮T平摊BOSS的技能伤害，还有治疗不间断的刷血方可保住坦克，BOSS需要在6分钟内击杀，否则就会狂暴秒杀全团。',
},
name = '布鲁塔卢斯',
icon = '1385722',
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '布鲁塔卢斯的战斗需要两个T，两个T按照指挥分配站在BOSS两侧，根据流星猛击和践踏技能换T。T的血量压力非常大，需要随时开启饰品和技能保命。',
},
{
role = 'MELEE',
expanded = false,
desc = '根据队伍分配站在两个T的前方输出，帮T分摊伤害。中了燃烧立即跑出大团，前往特定治疗处接受治疗，debuff消失后返回原位继续输出。',
},
{
role = 'RANGE',
expanded = false,
desc = '根据队伍分配站在两个T的后方帮T分摊伤害，尽量的分散站位输出，中了燃烧立即跑出大团，前往特定治疗处接受治疗，debuff消失后返回原位继续输出。',
},
{
role = 'HEALER',
expanded = false,
desc = '根据指挥分配治疗一般分为三个部分，第一部分需要全程注意T的血量，不间断的刷血，第二部分需要注意自身位置周围玩家血量，第三部分需要站在大团之外的治疗燃烧的人。\n中了燃烧立即跑出大团，前往特定治疗处接受治疗，debuff消失后返回原位继续加血，大团内的治疗也需要在两个T的后方分散站位。\n',
},
},
desc = '布鲁塔卢斯的战斗需要以两个T的位置为基准，将所有人大致分为两块区域，便于帮T平摊BOSS技能伤害，另外还需分配几个治疗不间断的给当前T刷血，确保T的血量。',
},
},
[606] = {
bossId = 606,
name = '灵魂之匣',
summary = {
children = {
{
role = 'TANK',
expanded = false,
children = {
{
title = 'P1阶段',
noCollapse = false,
expanded = false,
desc = 'BOSS会凝视最近的玩家并只攻击他，需要坦克先站在BOSS脚下拉住BOSS，在血量不够的情况下，当前坦克缓慢后退，另一名坦克站在BOSS脚下，距离BOSS最近来切换BOSS的攻击目标。',
},
{
title = 'P2阶段',
noCollapse = false,
expanded = false,
desc = '将BOSS背对大团，最好是战士坦克抗二阶段BOSS，可以打断或者是盾反BOSS的技能。',
},
{
title = 'P3阶段',
noCollapse = false,
expanded = false,
desc = '将BOSS背对大团，可以靠嘲讽去复制仇恨确保DPS不会OT，期间需要不断泄怒防止中了灵魂尖啸被秒杀。',
},
},
},
{
role = 'MELEE',
expanded = false,
children = {
{
title = 'P1阶段',
noCollapse = false,
expanded = false,
desc = '尽量远的距离输出BOSS，不要比坦克更靠近BOSS。',
},
{
title = 'P2阶段',
noCollapse = false,
expanded = false,
desc = '缓慢输出BOSS，注意仇恨，按照指挥分配打断BOSS技能。注意自己的输出伤害和自身血量，防止被反伤秒杀。',
},
{
title = 'P3阶段',
noCollapse = false,
expanded = false,
desc = '缓慢输出BOSS，注意仇恨。',
},
},
},
{
role = 'RANGE',
expanded = false,
children = {
{
title = 'P1阶段',
noCollapse = false,
expanded = false,
desc = '最远距离输出BOSS。',
},
{
title = 'P2阶段',
noCollapse = false,
expanded = false,
desc = '缓慢输出BOSS，注意仇恨，按照指挥分配打断BOSS技能，法师可以偷取BOSS的符文护盾。注意自己的输出伤害和自身血量，防止被反伤秒杀。',
},
{
title = 'P3阶段',
noCollapse = false,
expanded = false,
desc = '分散站位，缓慢输出BOSS，注意仇恨。',
},
},
},
{
role = 'HEALER',
expanded = false,
children = {
{
title = 'P1阶段',
noCollapse = false,
expanded = false,
desc = '给坦克套盾，注意驱散，然后远距离全力输出BOSS',
},
{
title = 'P2阶段',
noCollapse = false,
expanded = false,
desc = '加好全团，注意坦克血量，第一时间驱散符文护盾。',
},
{
title = 'P3阶段',
noCollapse = false,
expanded = false,
desc = '分散站位加好全团，注意中敌意技能的玩家血量。',
},
},
},
},
desc = '灵魂之匣在开始战斗前先需要经过一条不断刷新小怪的通道，进入通道直到击杀灵魂之匣或者团灭才能脱离战斗。在靠近BOSS的角落里击杀完所有小怪即可开战，三个阶段需要有3种不同的应对方式。',
},
icon = '1385764',
abilities = {
desc = '灵魂之匣整场战斗有三个阶段，分别是苦痛精华、欲望精华和愤怒精华，对应三张不同的脸，每张脸都有不同的技能，在每次更换精华的间隙都会刷新灵魂以供回复法力值。',
children = {
{
expanded = true,
noCollapse = false,
title = 'P1阶段：苦痛精华',
children = {
{
spell = '41292',
title = '受难光环',
noCollapse = false,
expanded = false,
desc = '治疗效果降低100%，生命回复速度降低100%，护甲降低100%。',
},
{
spell = '41294',
title = '凝视',
noCollapse = false,
expanded = false,
desc = '注视距离最近的玩家，且持续时间内只会攻击他。',
},
{
spell = '41305',
title = '狂乱',
noCollapse = false,
expanded = false,
desc = '持续时间内造成的物理伤害、攻击速度提高。',
},
{
spell = '41303',
title = '灵魂吸取',
noCollapse = false,
expanded = false,
desc = '随机指定目标，短时间内对目标造成持续性伤害并吸取生命值和法力值，可驱散。',
},
},
},
{
expanded = true,
noCollapse = false,
children = {
{
spell = '41350',
title = '渴望光环',
noCollapse = false,
expanded = false,
desc = '对敌人造成伤害时自身也承受伤害。治疗效果提高100%。法力值上限持续下降。',
},
{
spell = '41410',
title = '衰减',
noCollapse = false,
expanded = false,
desc = '使当前目标在持续时间内受到的伤害提高，可打断。',
},
{
spell = '41426',
title = '灵魂震击',
noCollapse = false,
expanded = false,
desc = '对当前目标造成大量暗影伤害，并使其迷惑，可打断。',
},
{
spell = '41431',
title = '符文护盾',
noCollapse = false,
expanded = false,
desc = '吸收大量伤害并增加施法速度。免疫打断效果，可驱散可偷取。',
},
},
title = 'P2阶段：欲望精华',
},
{
expanded = true,
noCollapse = false,
children = {
{
spell = '41337',
title = '愤怒光环',
noCollapse = false,
expanded = false,
desc = '持续对所有目标造成暗影伤害且伤害不断提高。',
},
{
spell = '41364',
title = '沸腾',
noCollapse = false,
expanded = false,
desc = '转换目标后施放此技能，持续时间内攻击速度提高，使玩家造成的威胁值提高。',
},
{
spell = '41545',
title = '灵魂尖啸',
noCollapse = false,
expanded = false,
desc = '对正面的敌人造成暗影伤害，并燃烧法力值或怒气造成额外伤害。',
},
{
spell = '41376',
title = '敌意',
noCollapse = false,
expanded = false,
desc = '锁定一个目标，使其在一定时间内免疫一切伤害，但会在结束后造成大量伤害。',
},
},
title = 'P3阶段：愤怒精华',
},
},
footDesc = '注意：每个阶段转换期间都会出现被奴役的灵魂，击杀后可以回复法力值。',
},
},
[1189] = {
bossId = 1189,
summary = {
children = {
{
children = {
},
role = 'TANK',
expanded = false,
desc = '将BOSS拉在场地中间即可',
},
{
children = {
},
role = 'MELEE',
expanded = false,
desc = '近战DPS尽可能的分散站位输出',
},
{
children = {
},
role = 'RANGE',
expanded = false,
desc = '远程DPS一开始8码距离分散站位输出，提示闪电风暴时跑向T，技能结束后返回原位继续输出。可以听从指挥击杀BOSS召唤的雄鹰',
},
{
children = {
},
role = 'HEALER',
expanded = false,
desc = '治疗一开始8码距离分散站位加血，提示闪电风暴时跑向T，技能结束后返回原位即可，注意被击飞的人的血量',
},
},
desc = '埃基尔松需要一开始尽量分散站位，避免静态混乱连到其他人，提示闪电风暴时所有人和T站一起，技能结束后返回原位分散站位。',
},
name = '埃基尔松',
icon = '522190',
abilities = {
children = {
{
spell = '40338',
title = '召唤雄鹰',
children = {
},
noCollapse = false,
expanded = false,
desc = '召唤雄鹰从空中对一个随机目标造成大量伤害',
},
{
spell = '43622',
title = '静电瓦解',
children = {
},
noCollapse = false,
expanded = false,
desc = '对随机目标造成大量伤害并像闪电箭一样溅射至周围范围内玩家身上，会附加承受自然伤害增加的DEBUFF',
},
{
spell = '25161',
title = '强风',
noCollapse = false,
expanded = false,
desc = '对除T以外的任一随机目标造成伤害并击飞',
},
{
spell = '43657',
title = '电能风暴',
noCollapse = false,
expanded = false,
desc = '一个随机目标卷到空中，对不在技能中心的人造成伤害，伤害会每秒递增',
},
},
desc = '埃基尔松是雄鹰之灵，整场战斗需要注意距离和跑动，开场时所有玩家8码分散站位，闪电风暴时需要集中，等技能结束再返回原位。',
},
},
[622] = {
bossId = 622,
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '只需要一个坦克将BOSS拉在场地中间，发现有火墙靠近时需要及时躲开。战士坦可以在群体恐惧前切换姿态，避免被恐惧。',
},
{
role = 'MELEE',
expanded = false,
desc = '最远距离输出，注意仇恨，保证自己的存活。\n发现有火墙靠近时需要及时躲开，若被火墙追逐则赶紧跑开，避免被追上，期间注意不要靠近人群。\nBOSS在施放空气爆裂时远离坦克，避免波及到坦克，若被点名飞至空中时，需要看准时机使用女神之泪降低下降速度，避免摔死。\n确保自身在萨满的战栗图腾范围内，以免无法解除恐惧效果。\n',
},
{
role = 'RANGE',
expanded = false,
desc = '按照指挥分配，和队伍的人在一个范围内分散输出，确保自身在萨满的战栗图腾范围内，以免无法解除恐惧效果。\n发现有火墙靠近时需要及时躲开，若被火墙追逐则赶紧跑开，避免被追上，期间注意不要靠近人群。\n若被点名空气爆裂飞至空中时，需要看准时机使用女神之泪降低下降速度，避免摔死。法师牧师可使用漂浮术之类技能。\n法师和德鲁伊优先解除本队诅咒。\n',
},
{
role = 'HEALER',
expanded = false,
desc = '按照指挥分配，和队伍的人在一个范围内分散治疗，注意坦克血量，有人死亡时回复全团生命值，需要保证自己的存活。',
},
},
desc = '阿克蒙德战斗期间会施放毁灭之火，追逐点名的玩家，受到空气爆裂飞到空中需要使用女神之泪降低下降速度，BOSS还会施放群体恐惧，所有目标都会受到影响，需要充分熟悉阿克蒙德的技能，且了解所有的应对方式，才能战胜这个关底BOSS。',
},
name = '阿克蒙德',
icon = '1385716',
abilities = {
children = {
{
spell = '30210',
title = '毁灭之火',
expanded = false,
noCollapse = false,
children = {
},
desc = '召唤一团火焰并随机追逐玩家，路径上会留下火焰，碰到火焰的玩家除了会直接受到火焰伤害外还会中持续性的伤害。',
},
{
spell = '32014',
title = '空气爆裂',
noCollapse = false,
expanded = false,
desc = '随机对非坦克玩家施放，对附近玩家造成群攻伤害，并击飞目标至高空中。',
},
{
spell = '31970',
title = '恐惧咆哮',
noCollapse = false,
expanded = false,
desc = '群体恐惧所有目标。',
},
{
spell = '31972',
title = '军团之握',
noCollapse = false,
expanded = false,
desc = '随机点名一位玩家施放诅咒，诅咒期间会持续受到暗影伤害，可驱散。',
},
{
spell = '31984',
title = '死亡一指',
noCollapse = false,
expanded = false,
desc = '当近战范围内没有可攻击目标时，触发此技能，随机点名一位玩家直接秒杀。',
},
{
spell = '32057',
title = '灵魂充能',
expanded = false,
noCollapse = false,
children = {
{
spell = '32053',
title = '灵魂责罚',
expanded = false,
noCollapse = false,
children = {
},
desc = '圣骑士、牧师或术士死亡后阿克蒙德会获得红色灵魂责罚对全团造成火焰伤害并伴有沉默效果。',
},
{
spell = '32054',
title = '灵魂责罚',
expanded = false,
noCollapse = false,
children = {
},
desc = '盗贼、战士或法师死亡后阿克蒙德会获得黄色灵魂责罚对全团造成伤害并带有易伤效果。',
},
{
spell = '32057',
title = '灵魂责罚',
expanded = false,
noCollapse = false,
children = {
},
desc = '猎人、萨满或德鲁伊后阿克蒙德会获得绿色灵魂责罚对全团造成持续性伤害并消耗法力值。',
},
},
desc = '每当团队内有玩家死亡，灵魂就会为阿克蒙德充能。不同职业死亡阿克蒙德会获不同的充能效果。',
},
},
desc = '阿克蒙德是海加尔山之战的最终BOSS，战斗开始前可以在泰兰德处领取女神之泪，该道具会持续2小时，使用后可以暂时降低下降速度，10秒冷却，可以在BOSS施放空气爆裂被击飞到空中时使用，避免摔死。战斗期间每死一个人阿克蒙德就会对全团造成伤害，因此在阿克蒙德的战斗中，躲避技能保存自己是非常重要的。10分钟没有击杀BOSS，BOSS会施放死亡之手秒杀全团。',
},
},
[661] = {
bossId = 661,
summary = {
children = {
{
desc = '主T全程拉住BOSS仇恨即可。',
role = 'TANK',
},
{
desc = '最远距离治疗，中了能量衰弱后注意躲开地狱火的范围伤害，牧师注意驱散痛。进入P2注意T的血量，进入P3注意T和被飞斧攻击的玩家血量。',
role = 'HEALER',
},
{
desc = '输出BOSS，中了能量衰弱后立即离开BOSS身边，等血量恢复之后再返回输出，注意躲开地狱火的范围伤害。',
role = 'MELEE',
},
{
desc = '最远距离输出BOSS，中了能量衰弱后注意躲开地狱火的范围伤害。',
role = 'RANGE',
},
},
desc = '玛克扎尔王子是卡拉赞的最终BOSS，王子血量很高，整场战斗治疗的压力会比较大。战斗分为三个阶段，P1阶段BOSS会随机点名5位玩家将其血量降低为1点，并使受到的治疗效果降低100%，所以治疗无法加血，因此被点名的玩家需要及时躲避范围伤害，不然会被秒杀。BOSS血量60%的时候进入P2阶段，王子停止点名玩家，但增加了强力的物理攻击，需要保障好坦克血量。BOSS血量30%时进入P3阶段，王子会使用飞斧攻击随机目标，需要治疗多注意被飞斧攻击的玩家血量，同时他又开始随机点名玩家血量降至1点，被点名玩家注意躲避伤害。',
},
abilities = {
children = {
{
noCollapse = true,
title = 'P1阶段',
children = {
{
desc = '每3秒造成一次暗影伤害，持续18秒。',
spell = 30898,
},
{
desc = '对随机5名玩家释放，使其生命值降为1点，且受到的治疗效果和恢复生命值速度降低100%。',
spell = 30843,
},
{
desc = '释放能量衰弱后会释放暗影新星，对30码内所有玩家造成暗影伤害并击退。',
spell = 30852,
},
{
desc = '战斗开始45秒后会召唤一个地狱火，地狱火3秒后会开始释放地狱烈焰，使范围内所有玩家受到火焰伤害，同时最多存在4个地狱火，持续3分钟。',
spell = 12740,
},
},
},
{
noCollapse = true,
title = 'P2阶段',
children = {
{
desc = '施法者获得两次额外的攻击机会。',
spell = 3391,
},
{
desc = '每次破甲可以使目标护甲值降低，可叠加5次，持续20秒。',
spell = 30901,
},
},
},
{
noCollapse = true,
title = 'P3阶段',
children = {
{
desc = '使目标承受的所有伤害提高100%，持续10秒。',
spell = 39095,
},
{
desc = '召唤飞斧攻击随机目标。',
spell = 30891,
},
},
},
},
desc = '玛克扎尔王子是卡拉赞的终极BOSS，整场战斗分为3个阶段。BOSS血量到60%的时候进入P2，停止释放暗言术痛和地狱火，增加了强力的物理攻击技能，血量30%时进入P3，停止释放能量衰弱，增加了伤害增效技能，并使用飞斧攻击随机目标。',
},
icon = 1379006,
name = '玛克扎尔王子',
},
[1109] = {
bossId = 1109,
name = '收割者戈提克',
zone = 3,
abilities = {
children = {
{
title = '左侧房间',
children = {
{
title = '冷酷的学徒',
expanded = true,
children = {
{
desc = '将附件所有玩家击倒。',
spell = 5164,
},
{
title = '死亡疫病',
desc = '对当前玩家释放，持续造成自然伤害，可叠加。',
},
},
desc = '每次刷新3个，每个台子上刷新一个。',
},
{
title = '冷酷的死亡骑士',
expanded = true,
children = {
{
desc = '对目标和他周围玩家造成大量物理伤害。',
spell = 19983,
},
},
desc = '每次刷新2个，会在1号和3号台子上刷新。',
},
{
title = '冷酷的骑兵',
expanded = true,
children = {
{
desc = '对周围玩家释放多支暗影箭，造成暗影伤害。',
spell = 27831,
},
{
title = '邪恶光环',
desc = '每3秒对所有附近玩家造成暗影伤害。',
},
},
desc = '每次刷新1个，刷新在中间台子上。',
},
},
desc = '左边房间小怪只会刷新在3个平台上',
},
{
title = '右侧房间',
children = {
{
title = '鬼灵学徒',
expanded = true,
children = {
{
title = '魔爆术',
desc = '对附近玩家造成奥术伤害。',
},
{
desc = '恐惧范围内的玩家，持续4秒。',
spell = 27990,
},
},
desc = '由冷酷的学徒复活而来。',
},
{
title = '鬼灵骑士',
expanded = true,
children = {
{
title = '法力燃烧',
desc = '对周围玩家造成伤害且吸收法力值。',
},
{
title = '生命吸取',
desc = '吸取玩家的生命值转化为自身生命值。',
},
},
desc = '由冷酷的死亡骑士复活而来。',
},
{
title = '鬼灵骑兵',
expanded = true,
children = {
{
children = {
{
title = '法力燃烧',
desc = '对周围玩家造成伤害且吸收法力值。',
},
{
title = '生命吸取',
desc = '吸取玩家的生命值转化为自身生命值。',
},
},
expanded = true,
title = '鬼灵骑兵',
},
{
children = {
{
title = '践踏',
desc = '对周围玩家造成物理伤害且降低移动速度。',
},
},
expanded = true,
title = '鬼灵战马',
},
},
desc = '由冷酷的骑兵复活而来，会形成鬼灵骑兵和鬼灵战马2种怪。',
},
},
desc = '右边房间会在随机骨堆上复活三种小怪的灵魂形态，所有鬼灵均为魔法免疫状态。',
},
{
title = 'BOSS',
children = {
{
desc = '对当前目标释放，造成大量暗影伤害。',
spell = 29317,
},
{
desc = '对所有玩家释放，使得属性降低10%，持续60秒，每20秒释放一次，可叠加。',
spell = 28679,
},
{
title = '传送',
desc = 'BOSS每隔30秒会在左右两个房间内传送。',
},
},
desc = '战斗持续4分30秒后，BOSS会下楼。',
},
},
desc = 'BOSS自身难度不大，这场战斗主要是需要处理好BOSS下楼前的小怪。\nBOSS房间被分割为两部分，战斗开始中间门会关闭，变成2个独立的区域，在左边房间被击杀的小怪会在右边房间复活，且魔法免疫。',
},
url = 'https://www.bilibili.com/video/BV1dr4y1w7gW?p=12',
icon = 1378979,
summary = {
children = {
{
desc = '左半场坦克：分配2个坦克在左边，开始先拉死亡骑士仇恨，在骑兵出来后拉住骑兵仇恨，死亡骑士由牧师锁住。\n左半场坦克：站在骨堆边上，出现怪就拉住，优先鬼灵骑士。\n注意：BOSS出来后会随机在2个房间内出现， T注意拉住BOSS。',
role = 'TANK',
},
{
desc = '按照分配站在左右两个房间内。\n左边房间：和远程站在一起，治疗好左边房间玩家。\n注意：每个牧师需要锁住（束缚亡灵）一个死亡骑士，随时注意锁住的怪的状态，补上技能。\n右边房间：远离骨堆，最远距离治疗右边房间玩家。',
role = 'HEALER',
},
{
desc = '远程DPS基本会被分配至右边房间，站在骨堆周围，出现小怪就击杀，鬼灵学徒可控制，小怪击杀优先顺序为死亡骑士-骑兵-学徒。\n注意：BOSS出来先集中击杀BOSS。',
role = 'MELEE',
},
{
desc = '远程DPS基本会被分配至左边房间，集中站在3个台子前面，出现小怪就击杀，先集中击杀骑兵或者死亡骑士，牧师锁住的怪不要去打。\n注意：BOSS出来先击杀BOSS。',
role = 'RANGE',
},
},
},
},
[1117] = {
bossId = 1117,
name = '瘟疫使者诺斯',
zone = 2,
abilities = {
children = {
{
desc = '每隔45秒使BOSS身边的人受到诅咒，如果10秒内未被驱散，则周围的玩家都会遭受到一波暗影伤害。',
spell = 29213,
},
{
title = '闪现',
desc = '每隔45秒BOSS随机闪现至一个方向，并清除仇恨。',
},
{
title = '残废术',
desc = 'BOSS释放闪现时对近战范围内玩家释放，降低玩家移动速度和攻击速度，可驱散。',
},
{
title = '召唤',
desc = '每隔15秒，BOSS会从房间3个骨堆上各召唤一个瘟疫战士（精英小怪）。',
},
{
title = '上墙',
desc = '每隔一段时间BOSS会上到平台上，无法被攻击，期间会在骨堆上召唤更多的精英小怪，每一次上墙召唤的小怪都比上一次更多，小怪全部被击杀或者时间到达BOSS将会闪现回房间正中位置。第一次召唤4个瘟疫勇士（吃任何控制技能），第二次召唤4个瘟疫勇士+2个瘟疫卫士（会奥爆的法系，无法控制，可眩晕），第三次召唤4个瘟疫勇士+2个瘟疫卫士+2个构造体（会顺劈斩，免疫控制）。',
},
},
desc = '诺斯在战斗过程中会一直召唤3个精英小怪，每隔15秒小怪刷新在房间骨堆上。每隔一段时间BOSS还会传送到墙上的平台召唤更多的精英小怪，期间无法被攻击。',
},
url = 'https://www.bilibili.com/video/BV1dr4y1w7gW?p=4',
icon = 1379004,
summary = {
children = {
{
desc = 'BOSS战斗需要5个T，主T和副T拉BOSS，其余三个T需要分别站在3个骨堆边坦住召唤出的小怪。\n1.主T开怪，将BOSS拉在房间正中间，副T站在人群，等待BOSS闪现清仇恨后拉住BOSS，然后主T站在人群，等待BOSS下次闪现清仇恨后拉住，两个T一直循环。\n2.BOSS从平台下来之后会回到房间正中间，主T提早站位拉住BOSS，副T人群等待。\n3.3个小怪T分别面朝骨堆，出现小怪就拉住仇恨，BOSS上墙后出现的瘟疫勇士等怪拉在人群外围等待击杀。',
role = 'TANK',
},
{
desc = '1.根据指挥每个拉小怪的T都分配2个治疗，其他人则治疗主副T和人群。\n2.所有治疗尽量靠近人群站位，方便T在BOSS闪现后拉走BOSS。\n注意：德鲁伊第一时间驱散BOSS释放的群体诅咒。牧师可以在小怪多的时候锁住瘟疫战士。',
role = 'HEALER',
},
{
desc = '1.进入战斗后对BOSS输出。BOSS闪现时停止输出，等T拉住仇恨之后再输出。\n2.BOSS上墙后帮助击杀小怪，第二次上墙后优先控制击杀瘟疫卫士（奥爆法系怪）。\n3.3个小怪T分别面朝骨堆，出现小怪就拉住仇恨，BOSS上墙后出现的瘟疫勇士等怪拉在人群外围等待击杀。',
role = 'MELEE',
},
{
desc = '1.集中站位，优先帮助3个小怪T击杀召唤出的精英怪。\n2.小怪击杀完之后再输出BOSS，BOSS闪现时停止输出，等T拉住仇恨之后再输出。\n3.BOSS第二次上墙后优先控制击杀瘟疫卫士（奥爆法系怪），第三次上墙仍旧优先击杀瘟疫卫士，然后是构造体，再是瘟疫勇士。\n注意：法师第一时间驱散BOSS释放的群体诅咒。',
role = 'RANGE',
},
},
},
},
[654] = {
bossId = 654,
summary = {
children = {
{
desc = '本场战斗只需要一个坦克，主T将BOSS拉至场地中间。若没有牺牲祝福，T可以在忏悔期间将BOSS拉至治疗附近，以便于BOSS释放奉献时解除治疗的昏迷，解除完毕之后拉回原位。',
role = 'TANK',
},
{
desc = '分散在场地外围，和周围玩家保持距离，几个治疗间隔站位，确保可以驱散并治疗到所有玩家。优先驱散神圣之火。\n注意：若有圣骑士，给主T加好牺牲祝福，解除昏迷之后治疗主T。若没有圣骑士，治疗可以在忏悔之前进入BOSS奉献范围内，解除昏迷之后返回外围治疗。',
role = 'HEALER',
},
{
desc = '最远距离输出BOSS，打断好神圣之火。',
role = 'MELEE',
},
{
desc = '分散在场地外围，和周围玩家保持10码距离输出BOSS。',
role = 'RANGE',
},
},
desc = '卡拉赞三号BOSS是贞节圣女，贞节圣女整场战斗最主要技能是忏悔，会昏迷所有玩家10秒，受到伤害即可解除昏迷状态，所以圣骑士可以提前给坦克加上牺牲祝福，坦克受到伤害的时候圣骑士也会解除昏迷确保坦克血量。其他玩家也可以在技能来临之前提前进入BOSS奉献区域内，靠BOSS释放奉献技能造成伤害中断昏迷效果。',
},
abilities = {
children = {
{
desc = '对目标造成大量神圣伤害，会跳跃至范围内其他玩家，再链接至下一个范围内玩家，以此类推，每一次跳跃会造成更大的伤害，持续20秒。',
spell = 32445,
},
{
desc = '随机对一名玩家释放，造成大量火焰伤害并附带持续伤害效果，可驱散。',
spell = 29522,
},
{
desc = '在BOSS半径12码范围内不断释放，对范围内玩家造成神圣伤害，并沉默。',
spell = 26573,
},
{
desc = '对所有玩家造成大量神圣伤害，并使所有人昏迷10秒，受到任何伤害都可以解除昏迷状态。',
spell = 29511,
},
},
desc = '贞节圣女会群体控制技能，建议圣骑士给主T加好牺牲祝福，忏悔期间圣骑士可以解除昏迷，确保主T的血量。',
},
icon = 1378997,
name = '贞节圣女',
},
[1570] = {
bossId = 1570,
name = '深水领主卡拉瑟雷斯',
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '1.四个坦克按照指挥要求分将深水领主和三个守护拉至角落。\n2.拉住深水卫士卡莉蒂丝（牧师）的坦克需要注意打断守卫的治疗。期间猎人召唤的宠物也需要坦克拉住。\n3.在守卫被击杀完毕之后坦克也要去输出BOSS，优先清理图腾，保持自身血量在50%以上。',
},
{
children = {
},
role = 'MELEE',
expanded = false,
desc = '1.根据指挥安排分别击杀三个守卫，击杀深水卫士卡莉蒂丝（牧师）时优先打断治疗，击杀深水卫士泰达维斯（萨满）时优先清理图腾。\n2.三个守卫击杀完毕之后去输出BOSS，优先清除图腾。保持自身血量在50%以上。',
},
{
role = 'RANGE',
expanded = false,
desc = '1.根据指挥安排最远距离输出三个守卫，击杀深水卫士卡莉蒂丝（牧师）时优先打断治疗。躲开场地内的旋风。\n2.三个守卫击杀完毕之后去输出BOSS。保持自身血量在50%以上。',
},
{
role = 'HEALER',
expanded = false,
desc = '1.根据指挥安排跟随三个拉守卫的坦克，最远距离治疗，保持坦克血量，躲开场地内的旋风。\n2.BOSS获得守卫技能后加大对BOSS目标的治疗量，整场战斗需保持所有玩家的生命值不低于50%。',
},
},
desc = '深水领主卡拉瑟雷斯整场战斗需要先解决三个护卫，将三个护卫拉至场地三个角落，按照指挥要求依次击杀，最后击杀BOSS，BOSS会释放技能随机减少一名玩家50%的血量。',
},
icon = '1385729',
abilities = {
children = {
{
expanded = false,
noCollapse = true,
children = {
{
noCollapse = false,
spell = '38441',
expanded = false,
desc = '随机对一个目标发射暗影箭，减少目标50%的生命值。',
},
{
title = '护卫',
noCollapse = false,
expanded = false,
desc = '当一个卫士被击杀时，卡拉瑟雷斯将获得该守卫的一项能力。',
},
{
noCollapse = false,
spell = '42230',
expanded = false,
desc = '场地内会产生旋风，被刮到玩家会漂浮至空中并延长施法时间。',
},
},
title = '深水领主卡拉瑟雷斯技能',
},
{
title = '深水卫士沙克基斯（猎人）技能',
footDesc = '沙克基斯死后，深水领主将获得野兽之心，增加30%的伤害。',
noCollapse = true,
expanded = false,
children = {
{
noCollapse = false,
spell = '38366',
expanded = false,
desc = '对目标及其周围玩家造成伤害，最多击中3个目标。',
},
{
noCollapse = false,
spell = '29436',
expanded = false,
desc = '从目标身上吸取大量生命值和法力值。',
},
{
noCollapse = false,
spell = '38373',
expanded = false,
desc = '进入愤怒状态，增加30%的伤害。宠物也会同时进入愤怒状态，造成额外50%伤害。当被激怒时，野兽免疫一切定身技能。',
},
{
spell = '883',
expanded = false,
noCollapse = false,
children = {
},
desc = '沙克基斯会召唤一个宠物，宠物会是元素或者野兽。',
},
},
},
{
title = '深水卫士卡莉蒂丝（牧师）技能',
footDesc = '卡莉蒂丝死后，深水领主将获得海潮涌动，冻结周围玩家并造成伤害。',
noCollapse = true,
expanded = false,
children = {
{
noCollapse = false,
spell = '38335',
expanded = false,
desc = '对范围内所有玩家发射水箭，造成大量的冰霜伤害。',
},
{
noCollapse = false,
spell = '38358',
expanded = false,
desc = '将附近的玩家击退并冻结，造成3秒昏迷。',
},
{
noCollapse = false,
spell = '38330',
expanded = false,
desc = '治疗所有的友方目标血量。',
},
},
},
{
title = '深水卫士泰达维斯（萨满）技能',
footDesc = '泰达维斯死后，深水领主将获得飞火图腾，对多个目标造成火焰伤害。',
noCollapse = true,
expanded = false,
children = {
{
noCollapse = false,
spell = '38234',
expanded = false,
desc = '对目标造成冰霜伤害，并使其移动速度降低。',
},
{
noCollapse = false,
spell = '38304',
expanded = false,
desc = '会召唤地缚图腾、清毒图腾等各种图腾，特别需要注意飞火图腾，会对多个目标造成大量火焰伤害。',
},
{
spell = '25505',
expanded = false,
noCollapse = false,
children = {
},
desc = '每次击中目标都有几率获得附加伤害，数值相当于2次近战攻击。',
},
},
},
},
desc = '在深水领主卡拉瑟雷斯边上有三个小BOSS，他们有各自的技能，每当一个小BOSS被击杀，深水领主都会获得这个小BOSS的一项技能。',
},
},
[662] = {
bossId = 662,
summary = {
children = {
{
children = {
{
title = 'P1阶段',
desc = '主T将BOSS拉在场地中间，头朝外，避免其他玩家吃到吐息和扫尾。',
},
{
title = 'P2阶段',
desc = '夜之魇上天，期间和所有玩家一起躲避BOSS技能，骨雨落下时跑开，但不可出BOSS攻击范围，骨雨结束后拉住骷髅仇恨。\n等待BOSS下地第一时间拉住仇恨，两阶段循环直至BOSS倒下。',
},
},
role = 'TANK',
},
{
children = {
{
title = 'P1阶段',
desc = '站在BOSS两侧，最远距离加血，可以通过后退超出治疗主T的范围来躲避恐惧，注意躲避脚下灼烧范围。牧师给T加好反恐惧结界。\n注意：战斗期间骑士可以开火炕和虔诚光环。',
},
{
title = 'P2阶段',
desc = '夜之魇上天，骨雨落下时和所有玩家一起跑开，但不可出BOSS攻击范围，加好BOSS技能目标的血量，并及时驱散。\n注意：战斗期间骑士可以开火炕和虔诚光环。',
},
},
role = 'HEALER',
},
{
children = {
{
title = 'P1阶段',
desc = '站在BOSS两侧输出，被恐惧后返回继续输出，注意躲避脚下灼烧范围。',
},
{
title = 'P2阶段',
desc = '夜之魇上天，骨雨落下时和所有玩家一起移动，但不可出BOSS攻击范围，骨雨结束后击杀骷髅。\n注意：BOSS下地时停止攻击等待主T拉好仇恨。',
},
},
role = 'MELEE',
},
{
children = {
{
title = 'P1阶段',
desc = '站在BOSS两侧，最远距离输出，被恐惧后返回继续输出，注意躲避脚下灼烧范围。',
},
{
title = 'P2阶段',
desc = '夜之魇上天，骨雨落下时和所有玩家一起移动，但不可出BOSS攻击范围，骨雨结束后击杀骷髅。\n注意：BOSS下地时停止攻击等待主T拉好仇恨。',
},
},
role = 'RANGE',
},
},
desc = '夜之魇是在卡拉赞露台召唤的骨龙，需要完成一系列前置任务才能召唤。整场战斗在两个阶段间循环，P1为地面阶段，会群体恐惧，并且需要注意躲开地面的灼烧效果。在BOSS血量达到75%、50%、25%时都会进入P2空中阶段，此时BOSS会飞上天，对地面喷吐技能并生成骷髅，注意躲避并击杀骷髅。在空中一段时间之后就会下地进入P1，如此循环直至BOSS倒下。',
},
abilities = {
children = {
{
noCollapse = true,
title = '地面阶段',
children = {
{
desc = '释放龙吼，使得所有玩家因恐惧而逃跑。',
spell = 36922,
},
{
desc = '对目标及周围多个玩家造成物理伤害。',
spell = 31043,
},
{
spell = '30210',
children = {
},
noCollapse = false,
expanded = false,
desc = '对目标正前方的玩家造成大量暗影烈焰伤害。',
},
{
desc = '对目标后方的玩家造成物理伤害并击退。',
spell = 25653,
},
{
desc = '烧灼玩家脚下的地面，每秒对范围内玩家造成持续伤害。',
spell = 30129,
},
},
},
{
noCollapse = true,
title = '空中阶段',
children = {
{
desc = '对地面喷吐，造成伤害并生成5个骷髅。',
spell = 37091,
},
{
desc = '对仇恨最高玩家释放，造成大量物理伤害并附加一个持续伤害。',
spell = 30127,
},
{
desc = '夜之魇上天后，若有任何玩家在夜之魇攻击范围外，将释放此技能对所有玩家造成大量伤害，直到所有玩家进入攻击范围内。',
spell = 29647,
},
},
},
},
desc = '夜之魇是召唤出的BOSS，需要队伍内有玩家完成对应前置任务，才能在卡拉赞露台上召唤出夜之魇。整场战斗分为两个阶段，P1为地面阶段，P2为空中阶段。在BOSS血量达到75%、50%、25%时都会进入空中阶段，在空中一段时间之后就会下地，如此循环直至BOSS倒下。',
},
icon = 1379003,
name = '夜之魇',
},
[1575] = {
bossId = 1575,
name = '大星术师索兰莉安',
summary = {
children = {
{
role = 'TANK',
expanded = false,
desc = '开战后主T拉住BOSS，BOSS消失后出现的三道光门需要分别站一个T，将光门内出现的小怪拉到一起尽快消灭，BOSS再度出现，需要副T将精英祭司拉至一边等待DPS击杀。BOSS变身后主T拉住即可。中了星术师的愤怒远离大团，爆炸后返回。',
},
{
role = 'MELEE',
expanded = false,
desc = '输出BOSS，注意仇恨不要OT。光门小怪出现后释放群攻技能尽快清理，BOSS现身优先击杀精英祭司，打断治疗。中了星术师的愤怒远离大团，爆炸后返回。',
},
{
role = 'RANGE',
expanded = false,
desc = '输出BOSS，注意仇恨不要OT。光门小怪出现后释放群攻尽快清理，BOSS现身优先击杀精英祭司，打断治疗。中了星术师的愤怒远离大团，爆炸后返回。',
},
{
role = 'HEALER',
expanded = false,
desc = '治疗好全团，特别注意奥术飞弹目标的血量。BOSS消失小怪出现后优先治疗FS或者SS，确保他们在释放群攻时的生命值，BOSS现身前确保全团血量。中了星术师的愤怒远离大团，爆炸后返回。',
},
},
desc = '战斗开始后，索兰莉安的印记每隔大约40秒释放一次，导致后期奥数飞弹伤害会越来越高，因此整场战斗需要较高的DPS，尽快将BOSS血量降至20%进入P2恶魔阶段。小怪出现时需要所有人释放群攻技能尽快清理，BOSS和祭司出现时需要优先击杀会加血的祭司。',
},
icon = '1385739',
abilities = {
children = {
{
noCollapse = false,
spell = '7268',
expanded = false,
desc = '对随机目标释放，每发奥术飞弹都会造成大量奥术伤害。',
},
{
noCollapse = false,
spell = '33023',
expanded = false,
desc = '每隔大约40秒释放一次，降低奥术抗性15点，持续2分钟，可叠加。',
},
{
noCollapse = false,
spell = '42783',
expanded = false,
desc = '随机目标释放，目标获得奥术能量6秒后对附近玩家造成大量伤害。',
},
{
spell = '39329',
expanded = false,
noCollapse = false,
children = {
},
desc = '恶魔阶段技能，向目标射出魔法箭，对其造成大量暗影伤害。',
},
},
desc = '大星术士索兰莉安的战斗分为两个阶段，人形阶段会对随机目标释放奥术飞弹，随着索兰莉安的印记的叠加，奥术飞弹伤害会越来越高，战斗开始后，每两分钟左右BOSS会消失出现3道光门，每道光门都会召唤出5个小怪，30秒后星术师会带着2个精英祭司再度出现，重复这些内容直至BOSS血量降低至20%，进入P2恶魔形态阶段。',
},
},
[1110] = {
bossId = 1110,
name = '黑女巫法琳娜',
zone = 1,
abilities = {
children = {
{
desc = '向玩家喷射毒液造成自然伤害，并在接下来的8秒内每2秒造成一次额外伤害，可驱散。',
spell = 28796,
},
{
desc = '随机区域召唤火焰之雨，对范围内玩家造成火焰伤害。',
spell = 28794,
},
{
desc = 'BOSS攻击速度提高50%，对玩家造成的伤害提高。膜拜者解除BOSS狂乱技能为黑女巫的拥抱（28732）：阻止并移除目标的狂乱效果，使目标在30秒内无法释放自然法术，施法速度降低。',
spell = 28798,
},
},
desc = '法琳娜身边有2个追随者和4个膜拜者，牧师控制膜拜者后，可以使用膜拜者技能解除BOSS的狂乱效果并使BOSS在30秒内无法使用自然法术（群体毒箭）。',
},
url = 'https://www.bilibili.com/video/BV1dr4y1w7gW?p=2',
icon = 1378980,
summary = {
children = {
{
desc = '1.开战后主T将BOSS拉在平台中间。\n2.其余6个小怪需要6个副T拉住，优先击杀追随者。\n3.拉住膜拜者的4个副T站在台子的左手边，需要牧师控制时，听指挥将一个膜拜者拉往台子边缘方便牧师控制。',
role = 'TANK',
},
{
desc = '1.战斗开始后分散站位，躲好火雨，治疗好中毒箭的玩家。\n2.控制膜拜者的牧师听从指挥，在BOSS狂乱前控制膜拜者靠近BOSS，狂乱时对BOSS使用技能即可（使用技能后膜拜者就会死亡）。',
role = 'HEALER',
},
{
desc = '战斗开始后优先击杀2个追随者，随后输出BOSS。',
role = 'MELEE',
},
{
desc = '1.战斗开始后优先击杀2个追随者，随后输出BOSS。\n2.分散站位，躲好火雨。',
role = 'RANGE',
},
},
},
},
[1107] = {
bossId = 1107,
name = '阿努布雷坎',
zone = 1,
abilities = {
children = {
{
desc = '随机朝一个方向释放穿刺，并击飞同一直线方向上的玩家。',
spell = 28783,
},
{
desc = '战斗开始后，每隔一段时间BOSS会释放出一簇虫群，使BOSS移动速度降低并对附近玩家造成伤害，且附近玩家无法攻击BOSS或者施法，持续20秒。',
spell = 28785,
},
{
title = '召唤地穴卫士',
desc = 'BOSS在释放虫群风暴同时会召唤一只地穴卫士（精英怪）。',
},
{
title = '召唤甲虫',
desc = 'BOSS会随机从地穴卫士尸体或玩家的尸体上召唤出甲虫。',
},
},
desc = 'BOSS会释放虫群风暴，期间会使范围内玩家受到大量伤害，但是BOSS移动速度会降低，需要主T在虫群风暴期间拉着BOSS跑，直到技能结束。',
},
url = 'https://www.bilibili.com/video/BV1dr4y1w7gW',
icon = 1378964,
summary = {
children = {
{
desc = '1.开战后，主T需要将BOSS拉在房间最里面的角落上。\n2.在BOSS释放虫群风暴时，主T需要沿着房间右边的水沟风筝BOSS，保持一定距离不受虫群伤害，又确保BOSS沿着水沟移动远离其他玩家，在虫群风暴结束后将BOSS拉至房间入口处。第二轮虫群风暴开始时沿原路风筝BOSS回到最里面的角落，一直循环即可。\n3.2名副T在战斗开始后拉住BOSS边上的地穴卫士，将精英怪拉至房间左边，靠近水沟处击杀，2只地穴卫士死亡位置尽量靠在一起。后续召唤的地穴卫士都需要副T拉住并击杀于同一位置。',
role = 'TANK',
},
{
desc = '1.战斗开始后在场地中间分散站位治疗。\n2.治疗好被穿刺的玩家，确保在掉落地面时不会被摔死。\n3.虫群风暴开始后往场地左边靠，确保不会吃到虫群风暴。随时注意主T的血量。',
role = 'HEALER',
},
{
desc = '1.战斗开始后先击杀地穴卫士，击杀后去输出BOSS。\n2.虫群风暴期间远离BOSS，击杀召唤出来的虫群卫士。',
role = 'MELEE',
},
{
desc = '1.战斗开始后先击杀地穴卫士，之后于场地左半部分散开，最远距离输出BOSS。\n2.虫群风暴期间远离BOSS，击杀召唤出来的虫群卫士。\n3.法师尽量靠近地穴卫士尸体分散站位，在甲虫被召唤出来之后第一时间控制击杀。\n4.安排接引主T的猎人，站在场地右边中间输出，一旦虫群风暴，立即开启豹群接应主T，确保主T移动速度不会吃到虫群风暴。',
role = 'RANGE',
},
},
},
},
[1115] = {
bossId = 1115,
name = '洛欧塞布',
zone = 2,
abilities = {
children = {
{
desc = '战斗开始2分钟后，BOSS会对所有玩家释放必然的厄运诅咒，10秒后受到大量暗影伤害，之后每隔30秒释放一次，五分钟后会15秒释放一次。',
spell = 29204,
},
{
title = '腐化心灵',
desc = '战斗开始后，所有治疗法术、驱散法术每分钟只能释放一次。',
},
{
desc = '战斗开始后BOSS背后墙边会刷新孢子，血量很少，打掉后会使附近最多5位玩家近战暴击提高50%、远程法术暴击提高60%，所有近战和法术技能都不会造成仇恨，持续1分30秒。',
spell = 29234,
},
{
desc = '战斗开始后近战范围内玩家会受到该光环效果，每次发动受到自然伤害。',
spell = 29865,
},
},
desc = '洛欧塞布整场战斗所有治疗每分钟只能治疗一次，期间可以帮助输出BOSS。',
},
url = 'https://www.bilibili.com/video/BV1dr4y1w7gW?p=6',
icon = 1378991,
summary = {
children = {
{
desc = '战斗开始主T将BOSS拉在房间中间，拉住仇恨即可，不需要副T。',
role = 'TANK',
},
{
desc = '1.战斗开始前喝暗抗药水，战斗开始后所有治疗法术、驱散法术每分钟只能释放一次，听从指挥按照顺序给MT治疗。\n2.治疗冷却期间可以输出BOSS。若有需要，可以听指挥跟DPS一起去吃孢子。\n3.战斗全程期间不能治疗自己，每一次必然厄运结束后听指挥吃治疗石、补暗抗药水、或者是绑绷带等，确保自己血量足够。',
role = 'HEALER',
},
{
desc = '1.战斗开始前喝暗抗药水，进战斗后输出BOSS。\n2.听指挥轮到自己队伍时去孢子刷新地点击杀孢子后返回全力输出BOSS。\n3.战斗全程期间不会受到任何治疗，每一次必然厄运结束后听指挥吃治疗石、补暗抗药水、或者是绑绷带等，确保自己血量足够。',
role = 'MELEE',
},
{
desc = '1.战斗开始前喝暗抗药水，进战斗后输出BOSS。\n2.听指挥轮到自己队伍时去孢子刷新地点靠近孢子，等孢子被击杀后返回全力输出BOSS。\n3.战斗全程期间不会受到任何治疗，每一次必然厄运结束后听指挥吃治疗石、补暗抗药水、或者是绑绷带等，确保自己血量足够。\n注意：术士可以多制作治疗石分给全团。',
role = 'RANGE',
},
},
},
},
}
local ENCOUNTER_INSTANCES = {
[533] = {
zones = {
{
text = '蜘蛛区',
zone = 1,
},
{
text = '瘟疫区',
zone = 2,
},
{
text = '军事区',
zone = 3,
},
{
text = '构造区',
zone = 4,
},
{
text = '中心区',
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
[565] = {
zones = {
},
bosses = {
ENCOUNTER_BOSSES[649],
ENCOUNTER_BOSSES[650],
},
title = '格鲁尔的巢穴',
instanceId = 565,
},
[749] = {
zones = {
},
bosses = {
ENCOUNTER_BOSSES[1573],
ENCOUNTER_BOSSES[1574],
ENCOUNTER_BOSSES[1575],
ENCOUNTER_BOSSES[1576],
},
title = '风暴要塞',
instanceId = 749,
},
[532] = {
zones = {
},
bosses = {
ENCOUNTER_BOSSES[652],
ENCOUNTER_BOSSES[653],
ENCOUNTER_BOSSES[654],
ENCOUNTER_BOSSES[655],
ENCOUNTER_BOSSES['655-1'],
ENCOUNTER_BOSSES['655-2'],
ENCOUNTER_BOSSES[656],
ENCOUNTER_BOSSES[658],
ENCOUNTER_BOSSES[657],
ENCOUNTER_BOSSES[659],
ENCOUNTER_BOSSES[660],
ENCOUNTER_BOSSES[661],
ENCOUNTER_BOSSES[662],
},
title = '卡拉赞',
instanceId = 532,
},
[564] = {
bosses = {
ENCOUNTER_BOSSES[601],
ENCOUNTER_BOSSES[602],
ENCOUNTER_BOSSES[603],
ENCOUNTER_BOSSES[604],
ENCOUNTER_BOSSES[605],
ENCOUNTER_BOSSES[606],
ENCOUNTER_BOSSES[607],
ENCOUNTER_BOSSES[608],
ENCOUNTER_BOSSES[609],
},
zones = {
},
title = '黑暗神殿',
instanceId = 564,
},
[748] = {
zones = {
},
bosses = {
ENCOUNTER_BOSSES[1567],
ENCOUNTER_BOSSES[1568],
ENCOUNTER_BOSSES[1569],
ENCOUNTER_BOSSES[1570],
ENCOUNTER_BOSSES[1571],
ENCOUNTER_BOSSES[1572],
},
title = '毒蛇神殿',
instanceId = 748,
},
[580] = {
bosses = {
ENCOUNTER_BOSSES[724],
ENCOUNTER_BOSSES[725],
ENCOUNTER_BOSSES[726],
ENCOUNTER_BOSSES[727],
ENCOUNTER_BOSSES[728],
ENCOUNTER_BOSSES[729],
},
zones = {
},
title = '太阳之井高地',
instanceId = 580,
},
[568] = {
bosses = {
ENCOUNTER_BOSSES[1190],
ENCOUNTER_BOSSES[1189],
ENCOUNTER_BOSSES[1191],
ENCOUNTER_BOSSES[1192],
ENCOUNTER_BOSSES[1193],
ENCOUNTER_BOSSES[1194],
},
zones = {
},
title = '祖阿曼',
instanceId = 568,
},
[544] = {
zones = {
},
bosses = {
ENCOUNTER_BOSSES[651],
},
title = '玛瑟里顿的巢穴',
instanceId = 544,
},
[531] = {
zones = {
},
bosses = {
ENCOUNTER_BOSSES[709],
ENCOUNTER_BOSSES[710],
ENCOUNTER_BOSSES[711],
ENCOUNTER_BOSSES[712],
ENCOUNTER_BOSSES[713],
ENCOUNTER_BOSSES[714],
ENCOUNTER_BOSSES[715],
ENCOUNTER_BOSSES[716],
ENCOUNTER_BOSSES[717],
},
title = '安其拉',
instanceId = 531,
},
[534] = {
zones = {
},
bosses = {
ENCOUNTER_BOSSES[618],
ENCOUNTER_BOSSES[619],
ENCOUNTER_BOSSES[620],
ENCOUNTER_BOSSES[621],
ENCOUNTER_BOSSES[622],
},
title = '海加尔山之战',
instanceId = 534,
},
}
local ENCOUNTER_DATA = {
ENCOUNTER_INSTANCES[532],
ENCOUNTER_INSTANCES[544],
ENCOUNTER_INSTANCES[565],
ENCOUNTER_INSTANCES[533],
ENCOUNTER_INSTANCES[531],
ENCOUNTER_INSTANCES[748],
ENCOUNTER_INSTANCES[749],
ENCOUNTER_INSTANCES[534],
ENCOUNTER_INSTANCES[564],
ENCOUNTER_INSTANCES[568],
ENCOUNTER_INSTANCES[580],
}
ns.DEFAULT_ENCOUNTER_INSTANCE_ID = 580
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
