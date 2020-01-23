
local L = LibStub('AceLocale-3.0'):NewLocale('GoodLeader', 'zhCN')
if not L then
    return
end

L.ADDON_NAME = '好团长'
L.ADDON_TITLE = '好团长查询工具'

L.TIP_SUMMARY = [[1. 尽量和熟悉的团长一起游戏。
2. 团长的个人信息越多，就越值得信任。
3. 尽量不要在没拿到装备的时候产生任何交易。
4. 一般来说，大公会的团长更值得依赖。
5. 经常开团的团长装备不会太差。]]

L.TIP_TITLE = [[洛索斯·天痕
给您温馨提示：]]

L['正在初始化'] = true
L['团长ID：%s'] = true
L['查询团长信息'] = true
L['进入团队后查询'] = true
L['|cff808080物品等级：|r当前团长未安装好团长插件，需要自行查看。'] = true
L['|cff808080物品等级：|r当前团长的装备超过|cffffd100%s%%|r的玩家。'] = true
L['|cff808080公会成员：|r当前团队有|cffffd100%s|r名成员与团长相同公会，公会名：|cffffd100%s|r。'] =
    true
L['|cff808080公会成员：|r团长距离过远，无法获得公会信息，建议进入团队后查看。'] = true
