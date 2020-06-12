---@class NeteaseWargameLocale
local L = LibStub('AceLocale-3.0'):NewLocale('NeteaseWargame', 'zhCN', true, true)
if not L then
    return
end

L.ADDON_NAME = '战争游戏'

L.ERR_MATCH_NOT_EXISTS = '赛事不存在'
L.ERR_MATCH_NOT_START = '赛事未开始'
L.ERR_MATCH_ALREADY_CLOSED = '当前赛事已关闭'
L.ERR_MEMBERS_IN_DIFFERENT_TEAM = '匹配队员不在同一队伍'
L.ERR_CREATE_TEAM_FAILED = '创建队伍失败'
L.ERR_INVALID_PLAYER_COUNT_IN_TEAM = '队伍人数不对'
L.ERR_INVALID_STANDBY_OUT_OF_LIMIT = '新加入的成员已经超出队伍人数上限'
L.ERR_INVALID_RIVALS_TEAM = '无效的对手队伍'
L.ERR_INVALID_PLAYER = '无效的玩家'
L.ERR_INVALID_PLAYER_HAS_NO_TEAM = '当前没有加入任何队伍'
L.ERR_NOT_WAITING_MATCH = '没有在等待匹配'
L.ERR_TOTAL_GAMES_OUT_OF_LIMIT = '队伍总场次达到上限'
L.ERR_MATCH_TIMEOUT = '匹配超时'
L.ERR_MATCH_NOT_IN_VALIDITY = '还未到赛事开放的时间段'
L.ERR_WAIT_ENQUEUE_TIMEOUT = '等待进入匹配队列超时'
L.ERR_WAIT_BATTLE_TIMEOUT = '等待进入战场超时'
L.ERR_CLIENT_MAYBE_OFFLINE = '客户端已掉线'
L.ERR_BATTLE_OUT_OF_TIME = '战斗已超时'
L.ERR_MATCH_GUILD_CHANGED = '当前公会和创建队伍时的公会不一致'
L.ERR_MATCH_GAME_CONTINUE = '比赛继续进行'
L.ERR_MATCH_INVALID_GAME = '无效局，请重新匹配'
L.ERR_MATCH_TOO_MANY_BATTLE_ROOMS = '当前战场已满，建议选择其他时段匹配'
L.ERR_TEAM_NOT_PERSIST = '队伍还未组建完毕'

L.ERR_TEAM_STATE_ERROR = '匹配超时，请重新匹配'
L.ERR_TEAM_STATE_START_MATCHING = '匹配超时，请重新匹配'
L.ERR_TEAM_STATE_MATCHING = '匹配超时，请重新匹配'
L.ERR_WAIT_ENQUEUE = '匹配超时，请重新匹配'
L.ERR_TEAM_STATE_WAIT_BATTLE = '匹配超时，请重新匹配'
L.ERR_TEAM_STATE_BATTLING = '匹配超时，请重新匹配'

L.MATCH_DESCRIPTION = [[快速参与：
-由同一公会{{combatCount}}名玩家组成团队进行匹配；
-团长确保有至少1个以上的战网好友空位；
-团长点击匹配按钮，首次成功匹配即完成队伍创建；
-队伍大名单人数允许最多{{maxMemberCount}}人；
-每个角色在公测期间只能参与一支队伍；]]

L.WARSONG_RULES = [[
{{title}}规则说明

一、赛事规则

    1.每支参赛队伍可以在比赛日的指定时间段内参与最多{{maxRoundCount}}场战歌峡谷比赛。
    2.每场战歌峡谷比赛的有效时间上限为1小时，在1小时内，战歌峡谷比赛的胜负判定以最终夺得战歌峡谷中的旗帜为有效比分。超出1小时，以1小时内的战斗结果为准。
    3.当战歌峡谷的有效比分为3:2、3:1、3:0、2:1、2:0和1:0时，夺得旗帜多的一方记为比赛胜利，比分为2:2、1:1时，最后夺得旗帜的一方记为比赛胜利，比分为0:0时，判定为双败。

二、参赛队伍的创建

    1.参赛队伍匹配时必须为一个{{combatCount}}人团队，且来自同一公会。
    2.匹配时将检查团队人数，人数不足或超出{{combatCount}}人、成员不属于同一公会，将无法开启匹配。
    3.首次匹配成功即自动完成参赛队伍创建和注册，每个参赛队伍的大名单除了首次匹配时的{{combatCount}}人外，允许额外{{backupCount}}名同公会玩家作为轮换队员。每个参赛队伍的大名单人数上限为{{maxMemberCount}}人，当队伍人数到达上限后，非本队伍大名单的玩家进组将导致无法开始匹配。
    4.匹配时，参赛队伍的团长必须有至少1个战网好友空位方能匹配，当前战网好友上限为200人。
    5.成功创建的参赛队伍将以<公会名>-1队（2队、3队、4队…..）等编号自动命名。
    6.同一角色在赛事期间只能进入1支参赛队伍的大名单。
    7.参赛队伍大名单成员在进行匹配时，必须处于队伍注册时对应的公会内。如有队员在赛事期间退出公会，该队员须在匹配前须重新加入公会，方能正常匹配。

三、参赛队伍排名规则

    1.排行榜将按照胜场数进行排名，胜场数多的队伍排名靠前。
    2.相同胜场数的队伍，比赛总场次多的排名靠前。
    3.胜场数与总比赛场数均相同，净胜旗数多的排名靠前。

四、其他规则

    1.匹配队列提示超时的，不录入比赛战绩，参赛队伍可以重新开始匹配。
    2.对于滥用战场BUG的行为（包含但不限于：树桩、斜坡、联盟/部落方楼顶地形、BUFF房楼顶等导致敌方无法发起正常PvP操作等），我们接受相关举报，并在核实后作判负并取消比赛资格的处罚。
    3.当比赛时间不足1小时，因双方人数不足导致战场自动关闭时，会以服务器数据作为判定胜负标准，先退出战场的一方判负；同时退出战场的，则判断战场剩余人数，人数少的一方为负，人数相同判为双败。

五、鸣谢

    1.策划和举办相应赛事的目的旨在为广大玩家提供更多游戏玩法和活动方式。赛事组委会可能会修正、补充和变更本规则。相关改动将通过《魔兽世界》官网、社交媒体或官方管理群进行沟通。
    2.所有参赛选手应尊重电子竞技公平公正性，严禁任何不公正的，有害电子竞技公平性的作弊行为发生，包括但不仅限于：黑客行为，利用漏洞，代打，默契比赛等。
    3.网易暴雪感谢各位积极参与到本测试中，为怀旧服PVP更好的明天贡献自己的力量。
]]

L.FEEDBACK_TPL = [[请填写问题描述，格式如下
战网账号：
服务器名称：
人物角色名称：
阵营：
描述你所遇到的问题：]]

L.TEAM_CREATE_RULE = [[1.首次匹配成功即默认创建队伍
2.创建成功后的队伍以<公会名>-1队等编号自动命名
3.每个游戏角色参与赛事期间只可以加入一支队伍进行匹配]]
