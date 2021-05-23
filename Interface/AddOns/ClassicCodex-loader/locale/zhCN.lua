local L = LibStub("AceLocale-3.0"):NewLocale("ClassicCodex", "zhCN")
if not L then return end


L = L or {}

-- loader.lua
L['[ClassicCodex]'] = '[ClassicCodex 任务助手]'
L['Missing component %s'] = '组件缺失: %s'
L['Failed to load database, ClassicCodex cannot be launched'] = '加载数据库失败，任务助手无法启动'
L['Failed to load database locales, ClassicCodex cannot be launched'] = '加载数据库语言包失败，任务助手无法启动'
L['Failed to load ClassicCodex core, ClassicCodex cannot be launched'] = '加载ClassicCodex核心失败，任务助手无法启动'
L['Unable to load database patch, quest data may be inaccurate'] = '加载数据库补丁失败，任务数据可能不精确'
