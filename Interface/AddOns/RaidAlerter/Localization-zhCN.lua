--修订日期：2011-05-16


if GetLocale() == "zhCN" then
	RaidAlerter_UIName				= "团队报警系统";

	RAL_TEXT_BINDING_1				= "开关警报";
	RAL_TEXT_BINDING_2				= "选项";
	RAL_TEXT_BINDING_3				= "观察";

	RaidAlerter_RAIDMODE = {
		[1]	= "10人团队模式",
		[2]	= "15人团队模式",
		[3]	= "20人团队模式",
		[4]	= "25人团队模式",
		[5]	= "30人团队模式",
		[6]	= "35人团队模式",
		[7]	= "40人团队模式",
	};

	RaidAlerter_RAIDICON = {
		[1]	= "{星形}",		--★
		[2]	= "{圆形}",		--●
		[3]	= "{菱形}",		--◆
		[4]	= "{三角}",		--▼
		[5]	= "{月亮}",		--月
		[6]	= "{方块}",		--█
		[7]	= "{十字}",		--╳
		[8]	= "{骷髅}",		--骷
	};

	--各种合剂Buff名称文本（可局部匹配，但必须唯一）
	RaidAlerter_SuperFlask_TEXT = {
	--	"合剂",
	--	"沙塔斯",
	--	"超级能量",
	--	"无情突袭",
	--	"强固",
	--	"强效回复",
	--	"泰坦",
	--	"精炼智慧",
	--	"盲目光芒",
	--	"多彩奇迹",
	--	"多重抗性",
	--	--ctm
	--	"钢皮合剂",
	--	"神龙心智合剂",
	--	"风行合剂",
	--	"泰坦之力合剂",
	--	"战斗合剂",
	--	"流水合剂",
	--MOP合剂
	"春华合剂",			--敏捷+1000
	"暖阳合剂",			--智力+1000
	"秋叶合剂",			--精神+1000
	"大地合剂",			--耐力+1000
	"冬噬合剂",			--力量+1000
	};

	--包含合剂在内的各种强化药剂Buff名称文本（可局部匹配，但必须唯一）
	RaidAlerter_ForceFlask_TEXT = {
		"合剂",
		--TBC药剂：移除
	--	"沙塔斯",
	--	"超级能量",
	--	"泰坦",
	--	"精炼智慧",
	--	"盲目光芒",
	--	"多彩奇迹",
	--	"多重抗性",
	--	"法能",
	--	"特效冰霜能量",
	--	"特效火力",
	--	"特效暗影能量",
	--	"特效敏捷",
	--	"特效力量",
	--	"强攻",
	--	"魔能力量药剂",
	--	"治疗能量",
	--	"德莱尼智慧",
	--	"特效魔血",
	--	"特效防御",
	--	"铁皮",
	--	"土灵",
	--	"掌控",
	--	"强效奥法",
	--	"猫鼬",
		--WLK新增
	--	"护甲穿透",
	--	"特效防御",			-- [极效防御药剂]
	--	"强效法力回复",		-- [极效魔血药剂]
	--	"精准",				-- [精准药剂] && [精确药剂]
	--	"致命打击",
	--	"闪电之速",			-- [闪电疾速药剂]
	--	"精神药水",
	--	"极效坚韧",
	--	"专家药剂",
	--	"法能药剂",			-- [法术能量药剂]
	--	"怒火药剂",
	--	"强效思维",			-- [极效思维药剂]
	--	"极效敏捷",
--		"防护药剂",			-- [防护药剂]
--		"强效力量",			-- [极效力量药剂]buff名和QS祝福重复，取消检测
		--CTM新增
		--"幽魂药剂",				--[国服待校正]
		--"纳迦药剂",				--[国服待校正]
		--"眼镜蛇药剂",			--[国服待校正]
		--"地核药剂",				--[国服待校正]
		--"无限精准药剂",		--[国服待校正]
		--"棱光药剂",				--[国服待校正]
		--"狂速药剂",			--[国服待校正]
		--"大师药剂",				--[国服待校正]
		--ctm合劑
		--"钢皮合剂",
		--"神龙心智合剂",
		--"风行合剂",
		--"泰坦之力合剂",
		--"战斗合剂",
		--"流水合剂",
		--MOP合剂
		"春华合剂",			--敏捷+1000
		"暖阳合剂",			--智力+1000
		"秋叶合剂",			--精神+1000
		"大地合剂",			--耐力+1000
		"冬噬合剂",			--力量+1000
		--MOP药剂
		"螳螂妖药剂",		--守护药剂：护甲+2250
		"疯狂猢狲药剂",		--战斗药剂：爆击+750
		"神兵药剂",			--战斗药剂：精准+750
		"激流药剂",			--战斗药剂：急速+750
		"安宁药剂",			--战斗药剂：精神+750
		"完美药剂",			--战斗药剂：命中+750
		"镜面药剂",			--守护药剂：躲闪+750
		"武僧药剂",			--战斗药剂：精通+750
	};

	--Boss清单默初始化为空，团队中会自动更新BOSS列表以供血量通报使用。若需添加某些特定怪物，可参照下面的表格式在{}内加入准确名称。
	RaidAlerter_Bosses = {};

	--定义不应被判定为Boss的特定怪物列表
	RaidAlerter_Bosses_EXC = {};
--[[旧数据备用
	RaidAlerter_Bosses_EXC = {
		"风暴锻铸护卫者",		--生态船
		"黑翼龙兽",				--禁魔监狱
		"暮光龙兽",				--禁魔监狱
		"节点潜行者",			--英雄法力陵墓
		"虚灵缚法者",			--英雄法力陵墓
		"虚灵妖术师",			--英雄法力陵墓
		"塞泰克预言者",			--英雄塞泰克大厅
		"塔伦米尔保卫者",		--英雄9SR
		"塔伦米尔斥候",			--英雄9SR
		"塔伦米尔卫兵",			--英雄9SR
		"永恒污染者",			--英雄9SR
		"永恒破坏者",			--英雄9SR
		"永恒杀戮者",			--英雄9SR
	};
]]
	RAL_TEXT_MINDMSG				= "团队报警系统5.0 由《挑战》公会升级(原作者:Oldhand)。命令帮助：";
	RAL_TEXT_OUTTEAM				= "你不在一个队伍中";
	RAL_TEXT_OUTRAID				= "你不在一个团队中";
	RAL_TEXT_SYNC_SELECT_FINISH		= "报警发送方自动选择为：";
	RAL_TEXT_SYNC_SELECT_NONE		= "** 无 **";
	RAL_TEXT_SYNC_START_CHECK		= "开始检查RaidAlerter版本...";
	RAL_TEXT_SYNC_END_CHECK			= "** 共检测到%s人 **";
	RAL_TEXT_ICON_CLEAR				= "临时团队标记已清除";
	RAL_TEXT_NUL					= "N/A";
	RAL_TEXT_ON						= "开启";
	RAL_TEXT_ON_SIMPLE				= "开";
	RAL_TEXT_OFF					= "关闭";
	RAL_TEXT_OFF_SIMPLE				= "关";
	RAL_TEXT_ETC					= "等.";
	RAL_TEXT_YOU					= "你";
	RAL_TEXT_I						= "我";
	RAL_TEXT_SEC					= "秒";
	RAL_TEXT_MIN					= "分";
	RAL_TEXT_HOUR					= "时";
	RAL_TEXT_ARROW_L				= "←";
	RAL_TEXT_ARROW_R				= "→";
	RAL_TEXT_LOOT_FREE_FOR_ALL		= "自由拾取";
	RAL_TEXT_LOOT_ROUND_ROBIN		= "轮流拾取";
	RAL_TEXT_LOOT_MASTER_LOOTER		= "队长分配";
	RAL_TEXT_LOOT_GROUP_LOOT		= "队伍分配";
	RAL_TEXT_LOOT_NEED_BEFORE_GREED	= "需求优先";
	RAL_TEXT_GROUP					= "队";
	RAL_TEXT_SELFGROUP				= "本队";

	RAL_TEXT_DRUID					= "德鲁伊";
	RAL_TEXT_HUNTER					= "猎人";
	RAL_TEXT_MAGE					= "法师";
	RAL_TEXT_PRIEST					= "牧师";
	RAL_TEXT_ROGUE					= "潜行者";
	RAL_TEXT_WARLOCK				= "术士";
	RAL_TEXT_WARRIOR				= "战士";
	RAL_TEXT_SHAMAN					= "萨满祭司";
	RAL_TEXT_PALADIN				= "圣骑士";
	RAL_TEXT_DEATHKNIGHT			= "死亡骑士";
	RAL_TEXT_MONK			= "武僧";

	RAL_TEXT_ZONE_1					= "黑翼之巢";
	RAL_TEXT_ZONE_2					= "安其拉";
	RAL_TEXT_ZONE_3					= "扳钳镇";
	RAL_TEXT_ZONE_4					= "虚空风暴";
	RAL_TEXT_ZONE_5					= "冬拥湖";

	RAL_TEXT_CPUMSG_1				= "设置完成！重载界面后即可生效。";
	RAL_TEXT_CPUMSG_2				= "立即重载界面";
	RAL_TEXT_CPUMSG_3				= "以后再说";

	RAL_TEXT_UINTNAME_1				= "其拉甲虫";
	RAL_TEXT_UINTNAME_2				= "其拉蝎虫";
	RAL_TEXT_UINTNAME_3				= "奥妮克希亚";

	RAL_TEXT_FRAME_ON				= "开";
	RAL_TEXT_FRAME_OFF				= "关";
	RAL_TEXT_FRAME_1				= "(%s)不在团队中";
	RAL_TEXT_FRAME_2				= "(%s)%s人队(%s:%s)";
	RAL_TEXT_FRAME_3				= "(%s)(MP总%s%%)(治疗%s%%)(死%s)";
	RAL_TEXT_FRAME_4				= "(%s)%s人团(%s:%s)";

	RAL_TEXT_TIP_1					= "当前战斗用时";
	RAL_TEXT_TIP_2					= "本次战斗用时";
	RAL_TEXT_TIP_3					= "上次战斗用时";
	RAL_TEXT_TIP_4					= "%s秒";
	RAL_TEXT_TIP_5					= "%s分%s秒";
	RAL_TEXT_TIP_6					= "灵魂石已保存%s人";
	RAL_TEXT_TIP_7					= "团队状态条操作";
	RAL_TEXT_TIP_8					= "左键";
	RAL_TEXT_TIP_9					= "右键";
	RAL_TEXT_TIP_10					= "右键拖动";
	RAL_TEXT_TIP_11					= "Ctrl";
	RAL_TEXT_TIP_12					= "Alt";
	RAL_TEXT_TIP_13					= "Shift";
	RAL_TEXT_TIP_14					= "开关警报";
	RAL_TEXT_TIP_15					= "选项菜单";
	RAL_TEXT_TIP_16					= "调整团队状态条位置";
	RAL_TEXT_TIP_17					= "公布到位检查结果";
	RAL_TEXT_TIP_18					= "公布合剂检查结果";
	RAL_TEXT_TIP_19					= "进行MT目标锁定检查";
	RAL_TEXT_TIP_20					= "公布增强药剂检查结果";
	RAL_TEXT_TIP_21					= "检查Buff";
	RAL_TEXT_TIP_22					= "立即清理插件内存";
	RAL_TEXT_TIP_23					= "血量危急自动喊话开关";
	RAL_TEXT_TIP_24					= "按住Ctrl键移到状态条上显示帮助";
	RAL_TEXT_TIP_25					= "系统资源占用";
	RAL_TEXT_TIP_26					= "内存";
	RAL_TEXT_TIP_27					= "CPU";
	RAL_TEXT_TIP_28					= "秒";
	RAL_TEXT_TIP_29					= "分";
	RAL_TEXT_TIP_30					= "5人";
	RAL_TEXT_TIP_31					= "10人";
	RAL_TEXT_TIP_32					= "25人";
	RAL_TEXT_TIP_33					= "普通";
	RAL_TEXT_TIP_34					= "英雄";
	RAL_TEXT_TIP_35					= "难度";
	RAL_TEXT_TIP_36					= "%s人%s";
	RAL_TEXT_TIP_37					= "动态";
	RAL_TEXT_TIP_38					= "法术编号";
	RAL_TEXT_TIP_39					= "源自";

	RAL_TEXT_CMD_1					= "命令";
	RAL_TEXT_CMD_2					= "或";
	RAL_TEXT_CMD_3					= "显示设置菜单";
	RAL_TEXT_CMD_4					= "显示此帮助讯息";
	RAL_TEXT_CMD_5					= "开关报警(默认开启)";
	RAL_TEXT_CMD_6					= "组队(非团队)模块开关";
	RAL_TEXT_CMD_7					= "OT报警开关(默认关闭)";
	RAL_TEXT_CMD_8					= "OT密语通知开关(默认关闭)";
	RAL_TEXT_CMD_9					= "开关OT密语的本机显示(默认关闭，隐藏显示)";
	RAL_TEXT_CMD_10					= "开关猎人标记和误导提示(默认开启)";
	RAL_TEXT_CMD_11					= "团队状态条显示开关(默认开启)";
	RAL_TEXT_CMD_12					= "将团队状态条位置重置于屏幕中间";
	RAL_TEXT_CMD_13					= "检查团队成员是否到位";
	RAL_TEXT_CMD_14					= "检查团队成员PvP状态及坦克列表"; -- new add
	RAL_TEXT_CMD_15					= "检查团队的灵魂石绑定状态";
	RAL_TEXT_CMD_16					= "合剂检查";
	RAL_TEXT_CMD_17					= "职业名称";
	RAL_TEXT_CMD_18					= "职业当前选定目标检查（省略职业名称时默认为MT目标检查）。例如/ral tc 法师 或/ral tc FS";
	RAL_TEXT_CMD_19					= "开关玩家生命危急自动喊话功能。默认界限30%，用“/ral myhp 数值”可更改";
	RAL_TEXT_CMD_20					= "开关状态条悬停提示的系统资源占用显示（默认关闭）";
	RAL_TEXT_CMD_21					= "开启系统资源占用提示中的CPU性能显示。开启此功能可能会稍微降低系统性能。";
	RAL_TEXT_CMD_22					= "重载界面后生效。";
	RAL_TEXT_CMD_23					= "关闭系统资源占用提示中的CPU性能显示";
	RAL_TEXT_CMD_24					= "立即强制执行垃圾内存回收";
	RAL_TEXT_CMD_25					= "重置RaidAlerter所有设定到默认状态";
	RAL_TEXT_CMD_26					= "显示RaidAlerter当前状态";
	RAL_TEXT_CMD_27					= "命令无效！键入/ral help查看帮助";

	RAL_TEXT_FUNC_1					= "报警";
	RAL_TEXT_FUNC_2					= "组队(非团队)模块";
	RAL_TEXT_FUNC_3					= "仅在本地讯息频道显示警报";
	RAL_TEXT_FUNC_4					= "仅在本地屏幕显示警报";
	RAL_TEXT_FUNC_5					= "Boss战通报最后一击";
	RAL_TEXT_FUNC_6					= "MT血量报警";
	RAL_TEXT_FUNC_7					= "MT血量危急上限设置为%s%%";
	RAL_TEXT_FUNC_8					= "MT阵亡报警";
--	RAL_TEXT_FUNC_9					= "通报战士的盾墙技能";
--	RAL_TEXT_FUNC_10				= "通报战士的破釜沉舟技能";
	RAL_TEXT_FUNC_11				= "通报战士的法术反射技能";
	RAL_TEXT_FUNC_12				= "MT嘲讽抵抗报警";
	RAL_TEXT_FUNC_13				= "驱散技能抵抗报警";
	RAL_TEXT_FUNC_14				= "变形技能抵抗报警";
	RAL_TEXT_FUNC_15				= "法术反制技能抵抗报警";
	RAL_TEXT_FUNC_16				= "法术吸取技能抵抗报警";
	RAL_TEXT_FUNC_17				= "猎人宁神射击通报";
	RAL_TEXT_FUNC_18				= "猎人标记提示";
	RAL_TEXT_FUNC_19				= "猎人误导提示";
	RAL_TEXT_FUNC_20				= "被控制警报";
	RAL_TEXT_FUNC_21				= "解除控制警报";
	RAL_TEXT_FUNC_22				= "打破控制警报";
	RAL_TEXT_FUNC_23				= "招架和灵魂石通报,驱散debuff也作通报";
	RAL_TEXT_FUNC_24				= "战斗结束后的阵亡通报";
	RAL_TEXT_FUNC_25				= "战场通报";
	RAL_TEXT_FUNC_26				= "Boss血量报警";
	RAL_TEXT_FUNC_27				= "逐一通报上限设置为%s%%";
	RAL_TEXT_FUNC_28				= "团队状态条";
	RAL_TEXT_FUNC_29				= "OT报警";
	RAL_TEXT_FUNC_30				= "OT密语通知";
	RAL_TEXT_FUNC_31				= "显示发送的OT密语";
	RAL_TEXT_FUNC_32				= "(NEF)堕落治疗警报";
	RAL_TEXT_FUNC_33				= "(NEF)狂野变形警报";
	RAL_TEXT_FUNC_34				= "魔法驱散通报";
	RAL_TEXT_FUNC_35				= "法术吸取通报";
	RAL_TEXT_FUNC_36				= "魔法打断通报";
	RAL_TEXT_FUNC_37				= "辅助提示通报";
	RAL_TEXT_FUNC_38				= "团队报警发送";
	RAL_TEXT_FUNC_39				= "强制开启";
	RAL_TEXT_FUNC_40				= "优先本地显示";
	RAL_TEXT_FUNC_41				= "默认：自动选择（推荐）";
	RAL_TEXT_FUNC_42				= "玩家生命危急自动喊话%s（界限=%s%%）";
	RAL_TEXT_FUNC_43				= "状态条已重置 - 屏幕位置正中；缩放比例%s";
	RAL_TEXT_FUNC_44				= "系统资源占用提示";
	RAL_TEXT_FUNC_45				= "状态条悬停提示的CPU性能显示";
	RAL_TEXT_FUNC_46				= "插件内存清理优化完毕，释放了%sK内存";
	RAL_TEXT_FUNC_47				= "内存清理界限已设置为%sK";
	RAL_TEXT_FUNC_48				= "已重置为默认设定";
	RAL_TEXT_FUNC_49				= "当前状态";
	RAL_TEXT_FUNC_50				= "版本";
	RAL_TEXT_FUNC_51				= "内存占用";
	RAL_TEXT_FUNC_52				= "团队模式：%s人";
	RAL_TEXT_FUNC_53				= "已设定为%s人团队模式";

	RAL_TEXT_CHECK_1				= "到位检查";
	RAL_TEXT_CHECK_2				= "%s人全部到位";
	RAL_TEXT_CHECK_3				= "已到位%s人";
	RAL_TEXT_CHECK_4				= "%s人离线";
	RAL_TEXT_CHECK_5				= "%s人死亡";
	RAL_TEXT_CHECK_6				= "%s人过远";
	RAL_TEXT_CHECK_7				= "PvP及坦克检查";
	RAL_TEXT_CHECK_8				= "%s人已开PvP";
	RAL_TEXT_CHECK_9				= "无人开PvP";
	RAL_TEXT_CHECK_10				= "%s人未开PvP";
	RAL_TEXT_CHECK_11				= "所有人均已开PvP";
	RAL_TEXT_CHECK_12				= "合剂";
	RAL_TEXT_CHECK_13				= "增强药剂";
	RAL_TEXT_CHECK_14				= "检查";
	RAL_TEXT_CHECK_15				= "%s人已有%s效果";
	RAL_TEXT_CHECK_16				= "无人有%s效果";
	RAL_TEXT_CHECK_17				= "%s人无%s效果";
	RAL_TEXT_CHECK_18				= "所有人均已有%s效果";
	RAL_TEXT_CHECK_19				= "RaidAlert Buff检查：常规Buff已齐全！";
	RAL_TEXT_CHECK_20				= "RaidAlert Buff检查：%s缺少！";
	RAL_TEXT_CHECK_21				= "*全无*";
	RAL_TEXT_CHECK_22				= "%s队(%s)";
	RAL_TEXT_CHECK_23				= "耐力";		--仅用于Buff检查消息标题
	RAL_TEXT_CHECK_24				= "未检测到团队的MT设定！";
	RAL_TEXT_CHECK_25				= "未检测到团队领袖或助理权限，警报只能在本机显示";
	RAL_TEXT_CHECK_26				= "检测到团队助手已设定%sMT";
	RAL_TEXT_CHECK_27				= "检测警报发送权限OK！（团队领袖L或助理A）";
	RAL_TEXT_CHECK_28				= "**%s目标锁定检查**";
	RAL_TEXT_CHECK_29				= "**检查结束**";
	RAL_TEXT_CHECK_30				= "%s "..RAL_TEXT_ARROW_R.." %s%s";		--目标锁定检查通报格式：玩家名字 "..RAL_TEXT_ARROW_R.." (标记符号)目标名称
	RAL_TEXT_CHECK_31				= "未选定目标！";
	RAL_TEXT_CHECK_32				= "未知的职业名称：%s";
	RAL_TEXT_CHECK_33				= "%s人未选定敌对目标：";
	RAL_TEXT_CHECK_34				= "%s人选定了相同标记：";

	RAL_TEXT_ALERT_1				= "**[仇恨!]%s"..RAL_TEXT_ARROW_R.."%s**";
--	RAL_TEXT_ALERT_2				= "[%s]仇恨==>你!!!";
	RAL_TEXT_ALERT_3				= "%s的仇恨目标是你! 小心!!";
	RAL_TEXT_ALERT_4				= "**%s(%s)的生命危急(%s%%)！**";
	RAL_TEXT_ALERT_5				= "**%s(%s)已经死亡！**";
	RAL_TEXT_ALERT_6				= "光荣的...战死...";
	RAL_TEXT_ALERT_7				= "**"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."被控制了(%s的%s)！**";
	RAL_TEXT_ALERT_8				= "**注意解除"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."的变形状态！**";
	RAL_TEXT_ALERT_9				= "**战斗结束！用时%s秒**";
	RAL_TEXT_ALERT_10				= "**战斗结束！用时%s分%s秒**";
	RAL_TEXT_ALERT_11				= "%s最先进入战斗状态(仅供参考)";
	RAL_TEXT_ALERT_12				= "本次战斗死亡(%s)人";
	RAL_TEXT_ALERT_13				= "灵魂石已保存(%s)人";
	RAL_TEXT_ALERT_14				= "团队MP(%s%%)";
	RAL_TEXT_ALERT_15				= "治疗MP(%s%%)";
--	RAL_TEXT_ALERT_16				= "**"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."已开启盾墙！注意治疗！**";
--	RAL_TEXT_ALERT_17				= "**"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."已开启破釜沉舟！注意治疗！**";


	RAL_TEXT_ALERT_17				= "**[%s]已施放%s！**"		--new add
	RAL_TEXT_ALERT_60				= "%s%s => %s"		--new add
	-- RAL_TEXT_ALERT_60				= "**%s %s 施放了%s！**"		--new add
	RAL_TEXT_ALERT_61				= "**"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."对%s施放了%s，造成%s伤害．**"		--new add 
	RAL_TEXT_ALERT_62				= "[招架加速] %s 招架了的 %s 的%s．"		--new add 


	RAL_TEXT_ALERT_16				= "**"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."已施放%s！注意治疗！**";
	RAL_TEXT_ALERT_18				= "**灵魂石已绑定"..RAL_TEXT_ARROW_R.."%s**";
--	RAL_TEXT_ALERT_19				= "**%s对"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."施放了误导**";
	RAL_TEXT_ALERT_20				= "**%s对"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."施放了%s**";
	RAL_TEXT_ALERT_21				= "**%s标记了"..RAL_TEXT_ARROW_R.."%s！**";
	RAL_TEXT_ALERT_22				= "**已启动%s：%s"..RAL_TEXT_ARROW_R.."%s！**";
	RAL_TEXT_ALERT_23				= "**"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."把%s变形了！注意解除！**";
	RAL_TEXT_ALERT_24				= "羊";		--控制技能的简写
	RAL_TEXT_ALERT_25				= "锁";		--控制技能的简写
	RAL_TEXT_ALERT_26				= "睡";		--控制技能的简写
	RAL_TEXT_ALERT_27				= "冰";		--控制技能的简写
	RAL_TEXT_ALERT_28				= "**[开%s] %s%s"..RAL_TEXT_ARROW_R.."%s（%s）**";		--打破控制
	-- new add 修改驱散提示
	--RAL_TEXT_ALERT_29				= "**%s驱散了%s的"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."！**";	
	RAL_TEXT_ALERT_29				= "**%s%s => %s的%s！**";
	RAL_TEXT_ALERT_30				= "**%s成功偷取了%s的"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."！**";
	RAL_TEXT_ALERT_31				= "**%s的"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."被%s抵抗了！**";
	RAL_TEXT_ALERT_32				= "**%s免疫了%s的"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."！**";
	RAL_TEXT_ALERT_33				= "**[反射] %s"..RAL_TEXT_ARROW_R.."%s（%s）**";
	RAL_TEXT_ALERT_34				= "**%s打断: %s => %s%s！**";
	RAL_TEXT_ALERT_35				= "**对%s进行最后一击的是"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."！**";
	RAL_TEXT_ALERT_36				= "**"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."的%s(AOE)击中了%s！**";
	RAL_TEXT_ALERT_37				= "**"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."的堕落治疗正在使%s受到DOT伤害！累计已受到至少%s点堕落治疗伤害（暗影）**";
	RAL_TEXT_ALERT_38				= "生命危急[%s%%]！%s队<%s>请求治疗!!";
	RAL_TEXT_ALERT_39				= "**%s施放%s！**";
	RAL_TEXT_ALERT_40				= "你对%s的仇恨过高! 小心OT!";
	RAL_TEXT_ALERT_41				= "**[高仇恨]%s（%s）**";
	RAL_TEXT_ALERT_42				= "你可能需要启用“正义之怒”Buff!";
	RAL_TEXT_ALERT_43				= "无正义之怒";
	RAL_TEXT_ALERT_44				= "**%s%s"..RAL_TEXT_ARROW_R.."%s**";
	--new add 特殊职业增益检测
	RAL_TEXT_ALERT_100				= "[%s]缺少: %s";

	RAL_TEXT_THREAT_INFO_01			= "*获得仇恨*";
	RAL_TEXT_THREAT_INFO_02			= "*仇恨消退*";
	RAL_TEXT_THREAT_INFO_03			= "*目标"..RAL_TEXT_ARROW_R.."%s*";
	RAL_TEXT_THREAT_INFO_04			= "*高仇恨*";
	RAL_TEXT_THREAT_INFO_05			= "*焦点"..RAL_TEXT_ARROW_R.."%s*";

	--用SPELL_CREATE判定：各种召唤团队物件的法术名称文本（MATCH：0局部匹配，1完全匹配）
	RAL_TEXT_RAIDSPELL_1 = {
		{["TEXT"]="鱼肉筵席",["MATCH"]=1,["TYPE"]="COOKFOOD",["DUR"]=180,},
		{["TEXT"]="地精烤肉野餐",["MATCH"]=1,["TYPE"]="COOKFOOD",["DUR"]=180,},
--		{["TEXT"]="烤全龙盛宴",["MATCH"]=1,["TYPE"]="COOKFOOD",["DUR"]=180,},			--国服无效
--		{["TEXT"]="海鲜盛宴",["MATCH"]=1,["TYPE"]="COOKFOOD",["DUR"]=180,},				--国服无效
		{["TEXT"]="公会盛宴：",["MATCH"]=0,["TYPE"]="COOKFOOD",["DUR"]=180,},				--[国服spellName]公会盛宴：海鲜大餐（海鲜盛宴）、公会盛宴：烤全龙（烤全龙盛宴）
		{["TEXT"]="盛宴",["MATCH"]=0,["TYPE"]="COOKFOOD",["DUR"]=180,},		--5.0后各种+275属性团队食物
		{["TEXT"]="大餐",["MATCH"]=0,["TYPE"]="COOKFOOD",["DUR"]=180,},		--5.0后各种+250属性团队食物
		{["TEXT"]="餐车",["MATCH"]=0,["TYPE"]="COOKFOOD",["DUR"]=180,},		--5.0后各种+250属性团队食物
		{["TEXT"]="传送门：",["MATCH"]=0,["TYPE"]="TRANS",["DUR"]=60,},		
	};
	--用SPELL_CAST_SUCCESS判定：各种召唤团队物件的法术名称文本（MATCH：0局部匹配，1完全匹配）
	RAL_TEXT_RAIDSPELL_2 = {
		{["TEXT"]="召唤餐桌",["MATCH"]=1,["TYPE"]="SPELL",["DUR"]=0,},
		{["TEXT"]="召唤仪式",["MATCH"]=1,["TYPE"]="SPELL",["DUR"]=0,},
		{["TEXT"]="灵魂仪式",["MATCH"]=1,["TYPE"]="SPELL",["DUR"]=0,},
		{["TEXT"]="基维斯",["MATCH"]=1,["TYPE"]="REPAIR",["DUR"]=600,},
		{["TEXT"]="废物贩卖机器人",["MATCH"]=1,["TYPE"]="REPAIR",["DUR"]=300,},
		{["TEXT"]="随身邮箱",["MATCH"]=1,["TYPE"]="REPAIR",["DUR"]=600,},
		{["TEXT"]="修理机器人",["MATCH"]=0,["TYPE"]="REPAIR",["DUR"]=600,},			--修理机器人74A型, 战地修理机器人110G
	};
	RAL_TEXT_RAIDSPELL_3 = {
		{["TEXT"]="防护药锅",["MATCH"]=0,["TYPE"]="ELIXIR",["DUR"]=300,},				--各种抗性药锅
		{["TEXT"]="战斗药锅",["MATCH"]=0,["TYPE"]="ELIXIR",["DUR"]=600,},				--战斗药锅, 大号战斗药锅
	};

	RAL_TEXT_SPELL_1				= "盾墙";
	RAL_TEXT_SPELL_2				= "破釜沉舟";
	RAL_TEXT_SPELL_3				= "灵魂石复活";
	RAL_TEXT_SPELL_4				= "误导";
	RAL_TEXT_SPELL_4_SPEC_1			= "嫁祸诀窍";
	RAL_TEXT_SPELL_5				= "宁神射击";
	RAL_TEXT_SPELL_6				= "猎人印记";
	RAL_TEXT_SPELL_7				= "神圣干涉";
	RAL_TEXT_SPELL_8				= "狂野变形";
	RAL_TEXT_SPELL_9				= "变形术";
	RAL_TEXT_SPELL_10				= "束缚亡灵";
	RAL_TEXT_SPELL_11				= "休眠";
	RAL_TEXT_SPELL_12				= "冰冻陷阱效果";
	RAL_TEXT_SPELL_13				= "驱散魔法";
	RAL_TEXT_SPELL_14				= "净化术";
	RAL_TEXT_SPELL_15				= "盾牌猛击";
	RAL_TEXT_SPELL_16				= "法术吸取";
	RAL_TEXT_SPELL_17				= "嘲讽";
	RAL_TEXT_SPELL_18				= "低吼";
	RAL_TEXT_SPELL_19				= "正义防御";
	RAL_TEXT_SPELL_20				= "精神控制";
	RAL_TEXT_SPELL_21				= "法术反制";
	RAL_TEXT_SPELL_22				= "剑刃乱舞";
	RAL_TEXT_SPELL_23				= "多重射击";
	RAL_TEXT_SPELL_24				= "乱射";
	RAL_TEXT_SPELL_25				= "顺劈斩";
	RAL_TEXT_SPELL_26				= "旋风斩";
	RAL_TEXT_SPELL_27				= "雷霆一击";
	RAL_TEXT_SPELL_28				= "堕落治疗";
	RAL_TEXT_SPELL_29				= "攻击";
	RAL_TEXT_SPELL_30				= "圣佑术";		--3.05新增，QS的“盾墙”
	RAL_TEXT_SPELL_31				= "生存本能";	--3.05新增，XD的“破釜沉舟”
	RAL_TEXT_SPELL_32				= "黑暗命令";	--WLK DK嘲讽技能
	RAL_TEXT_SPELL_33				= "冰封之韧";	--WLK DK盾墙技能
	RAL_TEXT_SPELL_34				= "反魔法护罩";	--WLK DK自身减魔法伤害技能
	RAL_TEXT_SPELL_35				= "反魔法领域";	--WLK DK减团队魔法伤害技能
	RAL_TEXT_SPELL_36				= "吸血鬼之血";	--WLK DK山寨破釜技能
	RAL_TEXT_SPELL_37				= "专注魔法";

	RAL_TEXT_SPELL_60				= "神圣牺牲"	--骑士团护技能 new add 70940
	RAL_TEXT_SPELL_61				= "圣盾术"	--骑士无敌技能 new add 642
	RAL_TEXT_SPELL_62				= "守护之魂"	--ms技能 new add 47788
	RAL_TEXT_SPELL_63				= "圣疗术"	--qs技能 new add 633(lv1)
	RAL_TEXT_SPELL_64				= "保护之手"	--qs技能 new add 1022
	RAL_TEXT_SPELL_65				= "牺牲之手"	--qs技能 new add 6940
	RAL_TEXT_SPELL_66				= "拯救之手"	--qs技能 new add 1038
	

	RAL_TEXT_SPELL_67				= "寒冰屏障"	-- 45438
	RAL_TEXT_SPELL_68				= "激活"	-- 29166
	RAL_TEXT_SPELL_69				= "复生"	-- 20484
	
	RAL_TEXT_SPELL_70				= "警戒"	-- 50720
	RAL_TEXT_SPELL_71				= "狂乱"	-- 49016
	RAL_TEXT_SPELL_72				= "能量灌注"	-- 10060
	RAL_TEXT_SPELL_73				= "法力之潮图腾"	--16190
	RAL_TEXT_SPELL_74				= "英勇"	--
	RAL_TEXT_SPELL_75				= "痛苦压制"	-- 33206
	RAL_TEXT_SPELL_76				= "防护恐惧结界"	-- 6346
	RAL_TEXT_SPELL_77				= "嫁祸诀窍"	--
	RAL_TEXT_SPELL_78				= "援护"	-- 3411
	RAL_TEXT_SPELL_79				= "专注魔法"	--54648
	RAL_TEXT_SPELL_80				= "光环掌握"	-- 31821
	RAL_TEXT_SPELL_81				= "清算之手"	-- 62124
	RAL_TEXT_SPELL_82				= "树皮术"	-- 22812 铁木树皮 102342
	
	RAL_TEXT_SPELL_83				= "清洁术"	-- 4987
	RAL_TEXT_SPELL_84				= "解除诅咒"	-- 2782,475
	RAL_TEXT_SPELL_85				= "净化灵魂"	-- 51886
	RAL_TEXT_SPELL_86				= "驱除疾病"	--
	RAL_TEXT_SPELL_87				= "驱毒术"	-- 德 88423
	RAL_TEXT_SPELL_88				= "祛病术"	-- 528
	RAL_TEXT_SPELL_89				= "Cleansing Totem Effect"	-- 52025
	RAL_TEXT_SPELL_90				= "消毒术"	--
	
	
	RAL_TEXT_SPELL_91				= "毒刃"	--解狂暴
	RAL_TEXT_SPELL_92				= "安抚"	--解狂暴
	
	RAL_TEXT_SPELL_93				= "躯不坏"	
	RAL_TEXT_SPELL_94				= "散魔功"	
	RAL_TEXT_SPELL_95				= "禅悟冥想"	
	RAL_TEXT_SPELL_96				= "还魂术"	
	RAL_TEXT_SPELL_97				= "作茧缚命"	
	RAL_TEXT_SPELL_98				= "共生术"	
	
	-- mop
	RAL_TEXT_MOP_BUFF_1 = ",命令怒吼,真言术：韧,黑暗意图,"; --10%耐力
	RAL_TEXT_MOP_BUFF_2 = ",王者祝福,帝王传承,野性印记,"; --5%属性
	RAL_TEXT_MOP_BUFF_3 = ",寒冬号角,战斗怒吼,强击光环,"; --10%强度
	RAL_TEXT_MOP_BUFF_4 = ",奥术智慧,黑暗意图,燃烧之怒,奥术光辉,达拉然光辉,"; --10%法强
	RAL_TEXT_MOP_BUFF_5 = ",兽群领袖,奥术智慧,奥术光辉,达拉然光辉,白虎传承,元素之誓,"; --5%crit
	RAL_TEXT_MOP_BUFF_6 = ",力量祝福,风之优雅,"; --精通
	
	RAL_MOP_BUFFCLASS_1 = "10%耐力"
	RAL_MOP_BUFFCLASS_2 = "5%主属性"
	RAL_MOP_BUFFCLASS_3 = "10%攻强"
	RAL_MOP_BUFFCLASS_4 = "10%法伤"
	RAL_MOP_BUFFCLASS_5 = "5%暴击"
	RAL_MOP_BUFFCLASS_6 = "精通"
	
	RAL_MOP_BUFFSPECIAL_1 = "心灵意志"

	RAL_TEXT_BUFF_1					= "灵魂石复活";
	RAL_TEXT_BUFF_2					= "猎人印记";
	RAL_TEXT_BUFF_3					= "巨熊形态";
	RAL_TEXT_BUFF_10				= "变形";		--中了变形魔法的DEBUFF名称，为简化判定只做局部匹配
	RAL_TEXT_BUFF_11				= "妖术";		--中了变形魔法的DEBUFF名称，为简化判定只做局部匹配

	RAL_TEXT_BUFF_21				= "正义之怒";
	RAL_TEXT_BUFF_24				= "进食充分";

	RAL_TEXT_MARCO_1				= "宏语法简介：";
	RAL_TEXT_MARCO_2				= "举例：";
	RAL_TEXT_MARCO_3				= "/run RAL.MSG(\"信息内容\"[,重复次数[,\"频道(s\||y\||p\||ra\||rw)\"[,防刷屏延时(单位秒)[,\"信息标识\"]]]])";
	RAL_TEXT_MARCO_4				= "/run RAL.MSG(\"正在对%t施放变羊！\",2)|r - 通知变羊(若省略频道参数则默认为say说，白字)，重复两次，短时间内(默认3s)狂按宏也只会发出一次信息";
	RAL_TEXT_MARCO_5				= "/run RAL.W(\"M语内容\"[,重复次数[,\"玩家名称\"[,防刷屏延时(单位秒)[,\"信息标识\"]]]])";
	RAL_TEXT_MARCO_6				= "/run RAL.W(\"速度过来集中!!!\",3)|r - M语已选定的目标玩家，重复三次，短时间内(默认3s)狂按宏也只会发出一次信息";

	RAL_TEXT_XML_1					= "检查到位";
	RAL_TEXT_XML_2					= "检查团队成员是否已到场";
	RAL_TEXT_XML_3					= "检查Buff";
	RAL_TEXT_XML_4					= "检查团队的常规增益效果";
	RAL_TEXT_XML_5					= "包括：\n全团10%耐力法伤攻强\n5%主属性暴击及通精\n进食充分（已放置团队烹饪食物时）";
	RAL_TEXT_XML_6					= "检查灵魂石";
	RAL_TEXT_XML_7					= "检查灵魂石是否已有绑定";
	RAL_TEXT_XML_8					= "检查MT目标";
	RAL_TEXT_XML_9					= "检查MT锁定的目标";
	RAL_TEXT_XML_10					= "可用于开怪前的检查";
	RAL_TEXT_XML_11					= "需预先设定团队MT：|r选中目标用命令|cFF00FF00/MT|r设定（|cFF00FF00/CLEARMT|r取消）；或者用oRA插件设置。";
	RAL_TEXT_XML_12					= "检查合剂";
	RAL_TEXT_XML_13					= "检查团队的合剂状态";
	RAL_TEXT_XML_14					= "包括各种常用合剂";
	RAL_TEXT_XML_15					= "检查增强药剂";
	RAL_TEXT_XML_16					= "检查团队的增强药剂状态";
	RAL_TEXT_XML_17					= "各种常用的战斗和守护药剂\n同时也包括合剂";
	RAL_TEXT_XML_18					= "坦克/治疗";
	RAL_TEXT_XML_19					= "检查团队的PvP,坦和治疗列表及状态(需要选择职责)";
	RAL_TEXT_XML_20					= "检查法师目标";
	RAL_TEXT_XML_21					= "检查法师锁定的目标";
	RAL_TEXT_XML_22					= "可用于变羊开怪前的检查";
	RAL_TEXT_XML_23					= "启用";
	RAL_TEXT_XML_24					= "开启团队警报";
	RAL_TEXT_XML_25					= "需要团长L或者助理A权限\n否则只在本机显示";
	RAL_TEXT_XML_26					= "5人小队";
	RAL_TEXT_XML_27					= "5人小队（非团队）状态也启用报警";
	RAL_TEXT_XML_28					= "此功能无需队长权限";
	RAL_TEXT_XML_29					= "仅本机";
	RAL_TEXT_XML_30					= "仅在本机讯息频道显示警报";
	RAL_TEXT_XML_31					= "勾选此项将不再发送团队警报\n包括各种检查结果";
	RAL_TEXT_XML_32					= "仅本屏";
	RAL_TEXT_XML_33					= "仅在本机屏幕显示警报";
	RAL_TEXT_XML_34					= "内存清理   ";
	RAL_TEXT_XML_35					= "界限";
	RAL_TEXT_XML_36					= "状态条";
	RAL_TEXT_XML_37					= "团队状态条";
	RAL_TEXT_XML_38					= "实时显示团队法力、治疗法力和死亡人数";
	RAL_TEXT_XML_39					= "缩放比例";
	RAL_TEXT_XML_40					= "重置";
	RAL_TEXT_XML_41					= "重置团队状态条位置和大小";
	RAL_TEXT_XML_42					= "Boss血量";
	RAL_TEXT_XML_43					= "通报Boss血量";
	RAL_TEXT_XML_44					= "每10%通报一次Boss血量\n低于设定上限则开始逐一通报";
	RAL_TEXT_XML_45					= "注：5人小队为20%间隔，逐一上限固定5%";
	RAL_TEXT_XML_46					= "通报上限";
	RAL_TEXT_XML_47					= "最后一击";
	RAL_TEXT_XML_48					= "Boss战通报是谁进行了最后一击";
	RAL_TEXT_XML_49					= "需捕捉PARTY_KILL事件\n不一定每次击杀都会出现";
	RAL_TEXT_XML_50					= "MT血量";
	RAL_TEXT_XML_51					= "警报MT血量危急";
	RAL_TEXT_XML_52					= "5人小队时警报队友血量危急";
	RAL_TEXT_XML_53					= "危急上限";
	RAL_TEXT_XML_54					= "MT阵亡";
	RAL_TEXT_XML_55					= "通报MT阵亡";
	RAL_TEXT_XML_56					= "5人小队时通报自己死亡";
	RAL_TEXT_XML_57					= "保命技能I";
	RAL_TEXT_XML_58					= "通报减伤类保命技能";
	RAL_TEXT_XML_58_1				= "战士：盾墙\n圣骑士：圣佑术\n死亡骑士：冰锢坚韧、反魔法护罩、反魔法领域";
	RAL_TEXT_XML_59					= "保命技能II";
	RAL_TEXT_XML_60					= "通报加血类保命技能";
	RAL_TEXT_XML_60_1				= "战士：破釜沉舟\n德鲁伊：生存本能\n死亡骑士：血族之裔";
	RAL_TEXT_XML_61					= "法术反射";
	RAL_TEXT_XML_62					= "通报战士的法术反射技能";
	RAL_TEXT_XML_63					= "仇恨";
	RAL_TEXT_XML_64					= "警报仇恨";
	RAL_TEXT_XML_65					= "1、第一仇恨者：Boss和较危险怪物\n  （非TANK职业获得第一仇恨通常都是OT）\n2、仇恨过高者：Boss战时仇恨超过MT";
	RAL_TEXT_XML_66					= "仇恨密语";
	RAL_TEXT_XML_67					= "使用密语通知";
	RAL_TEXT_XML_68					= "显示发送";
	RAL_TEXT_XML_69					= "是否显示你发出的密语通知";
	RAL_TEXT_XML_70					= "猎人标记";
	RAL_TEXT_XML_71					= "通报猎人印记技能";
	RAL_TEXT_XML_72					= "威胁转移";
	RAL_TEXT_XML_73					= "通报猎人的误导和潜行者的嫁祸诀窍技能";
	RAL_TEXT_XML_74					= "宁神类";
	RAL_TEXT_XML_75					= "通报猎人的宁神，德及盗的解狂暴状况";
	RAL_TEXT_XML_76					= "抵抗嘲讽";
	RAL_TEXT_XML_77					= "通报嘲讽技能的抵抗和免疫";
	RAL_TEXT_XML_78					= "包括战士、圣骑士、野德和死亡骑士的嘲讽技能";
	RAL_TEXT_XML_79					= "抵抗驱散";
	RAL_TEXT_XML_80					= "通报驱散技能的抵抗和免疫";
	RAL_TEXT_XML_81					= "抵抗变形";
	RAL_TEXT_XML_82					= "通报变形技能的抵抗和免疫";
	RAL_TEXT_XML_83					= "抵抗反制";
	RAL_TEXT_XML_84					= "通报法术反制技能的抵抗和免疫";
	RAL_TEXT_XML_85					= "抵抗法偷";
	RAL_TEXT_XML_86					= "通报法术吸取技能的抵抗和免疫";
	RAL_TEXT_XML_87					= "被控制";
	RAL_TEXT_XML_88					= "通报被控制者并作骷髅标记";
	RAL_TEXT_XML_89					= "此骷髅标记在战斗结束后会自动清除";
	RAL_TEXT_XML_90					= "解除控制";
	RAL_TEXT_XML_91					= "提醒解除控制";
	RAL_TEXT_XML_92					= "在团队频道通知TANK职业被变形";
	RAL_TEXT_XML_93					= "打破控制";
	RAL_TEXT_XML_94					= "通报打破控制者";
	RAL_TEXT_XML_95					= "包括羊、锁、睡和冰";
	RAL_TEXT_XML_96					= "魔法驱散";
	RAL_TEXT_XML_97					= "通报怪物身上的魔法被驱散，如：";
	RAL_TEXT_XML_98					= "驱散魔法\n净化术\n盾击";
	RAL_TEXT_XML_99					= "法术吸取";
	RAL_TEXT_XML_100				= "通报法师的法术吸取";
	RAL_TEXT_XML_101				= "魔法打断";
	RAL_TEXT_XML_102				= "通告怪物正在施放的魔法被谁成功打断";
	RAL_TEXT_XML_103				= "灵魂绑定";
	RAL_TEXT_XML_104				= "通报谁被绑定灵魂石及提示部分boss招架";
	RAL_TEXT_XML_105				= "辅助提示";
	RAL_TEXT_XML_106				= "开启大部分特殊辅助或友好技能的提示,比如专注魔法,保护之手等技能";
	RAL_TEXT_XML_107				= "阵亡通报";
	RAL_TEXT_XML_108				= "战斗结束时通报阵亡人数";
	RAL_TEXT_XML_109				= "视情况通报和法力和灵魂绑定状态等";
	RAL_TEXT_XML_110				= "密语通知";
	RAL_TEXT_XML_111				= "辅助技能是否密语通知目标";
	RAL_TEXT_XML_112				= "比如保护之手,援护等技能是否密语通知接收目标";
	RAL_TEXT_XML_113				= "所有驱散";
	RAL_TEXT_XML_114				= "通报所有敌友驱散情况，并在NEF战点名法师把近战变形时进行通报";
	RAL_TEXT_XML_115				= "战场警报";
	RAL_TEXT_XML_116				= "在战场及竞技场中也允许警报";
	RAL_TEXT_XML_117				= "注意,如果是随机战场,建议不要开启此项,以免影响他人正常游戏";
	RAL_TEXT_XML_118				= "默认";
	RAL_TEXT_XML_119				= "重置所有警报设定到默认值";
	RAL_TEXT_XML_120				= "全开";
	RAL_TEXT_XML_121				= "开启全部警报项目";
	RAL_TEXT_XML_122				= "全关";
	RAL_TEXT_XML_123				= "禁用全部警报项目";
	RAL_TEXT_XML_124				= "退出";
	RAL_TEXT_XML_125				= "关闭设置界面";
	RAL_TEXT_XML_126				= "仇恨提示";
	RAL_TEXT_XML_127				= "显示你的仇恨信息";
	RAL_TEXT_XML_128				= "1、当你获得任何怪物的第一仇恨时\n2、当你仇恨过高时\n（仅在本机屏幕显示，并非团队警报）";
	RAL_TEXT_XML_129				= "音效";
	RAL_TEXT_XML_130				= "为重要警报启用声音效果";
	RAL_TEXT_XML_131				= "增大镜头上限";
	RAL_TEXT_XML_132				= "使最大镜头距离超越系统可设定的上限";
	RAL_TEXT_XML_133				= "关闭此功能后，请在系统的界面设置里重新设定你习惯的镜头距离";
	RAL_TEXT_XML_134				= "|cFF00FF00屏|cFF00FFFF幕|cFFFF0000讯|cFFFF00FF息|r";
	RAL_TEXT_XML_135				= "在屏幕上显示一些讯息\n比如你的嘲讽抵抗、成功打断等";
	RAL_TEXT_XML_136				= "目标提示";
	RAL_TEXT_XML_137				= "1、当目标的目标转向你时\n2、当焦点的目标转向你时\n（仅在本机屏幕显示，并非团队警报）";
	RAL_TEXT_XML_138				= "测试";
	RAL_TEXT_XML_139				= "测试屏幕消息效果";
	RAL_TEXT_XML_140				= "团队物件";
	RAL_TEXT_XML_141				= "通报召唤团队物件的法术：";
	RAL_TEXT_XML_142				= "";

	RAL_TEXT_XML_150				= "关闭状态条";
	RAL_TEXT_XML_151				= "隐藏RaidAlert的状态条";
	for i, v in pairs(RAL_TEXT_RAIDSPELL_1) do
		RAL_TEXT_XML_142 = RAL_TEXT_XML_142..v["TEXT"].."\n";
	end
	for i, v in pairs(RAL_TEXT_RAIDSPELL_2) do
		RAL_TEXT_XML_142 = RAL_TEXT_XML_142..v["TEXT"].."\n";
	end
	RAL_TEXT_XML_143				= "显示法术编号和来源";
	RAL_TEXT_XML_144				= "在鼠标提示中显示法术编号\n以及Buff/Debuff的施放者";
end
