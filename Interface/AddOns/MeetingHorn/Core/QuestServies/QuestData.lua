-- QuestData.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2022/4/20 13:22:48
--
---@class ns
local ns = select(2, ...)

ns.QUEST_CFG_DATA = { --
    [1] = {
        title = [[击杀{{bossName}}]],
        proto = {'bossId'},
        ctor = function(quest)
            quest.bossName = ns.GetEncouterBossName(quest.bossId)
        end,
    },
    [2] = {title = [[赢得{{progressMaxValue}}次任意战场胜利]], proto = {}},
    [3] = {title = [[完成{{progressMaxValue}}个任意日常任务]], proto = {}},
}
