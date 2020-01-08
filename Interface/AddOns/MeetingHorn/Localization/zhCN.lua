---@class MeetingHornLocale
local L = LibStub('AceLocale-3.0'):NewLocale('MeetingHorn', 'zhCN')
if not L then
    return
end

L.ADDON_NAME = '集结号'

L['Leader'] = '队长'
L['Comment'] = '说明'
L['Operation'] = '操作'

L['Activity'] = '活动类型'
L['Activity Mode'] = '活动模式'
L['Mode'] = '模式'
L['Activity Comment'] = '活动说明'
L['Manage Activity'] = '管理活动'
L['Choice Activity...'] = '选择活动类型...'
L['Choice Mode...'] = '选择活动模式...'
L['Create Activity'] = '创建活动'
L['Close Activity'] = '解散活动'
L['Update Activity'] = '更新活动'
L['Members'] = '队伍人数'
L['Whisper'] = '密语'

L['Manage'] = '管理'
L['Feedback'] = '用户反馈'
L['Feedback was submitted successfully.'] = '提交反馈成功。'
L['Requires Level %s'] = '需要等级%s'
L['Requires Class %s'] = '需要职业%s'
L['Requires Zone City'] = '需要处于城市中'

-- 活动

L.CATEGORY_QUEST = '任务'
L.CATEGORY_RAID = '团队副本'
L.CATEGORY_DUNGEON = '地下城'
L.CATEGORY_BOSS = '世界首领'
L.CATEGORY_PVP = 'PvP'
L.CATEGORY_PORT = '传送门'
L.CATEGORY_SUMMON = '召唤仪式'
L.CATEGORY_RECRUIT = '招募'

L.SUMMARY_NEW_VERSION = [[|cff00ffff%s|r：
发现新版本：%s，请及时下载更新
下载链接：%s]]

-- L['Quest'] = '任务'
-- L['Raid'] = '团队副本'
-- L['Dungeon'] = '地下城'
-- L['Boss'] = '世界首领'
-- L['PvP'] = true
-- L['Trade'] = '交易'

L['Sell'] = '出售'
L['Buy'] = '购买'

L['<Double-Click> Whisper to player'] = '<双击>密语'
L['<Right-Click> Open activity menu'] = '<右键>打开活动菜单'
L['(Include channel message)'] = '(包含频道聊天)'
L['Applicanted'] = '已申请'

L['|cff00ffff%s|r instance already exists, continue to create?'] = '|cff00ffff%s|r进度已存在，继续创建？'
L['Update activity success.'] = '更新活动成功。'
L['Create acitivty success.'] = '创建活动成功。'
L['Activity closed.'] = '活动已解散。'
L['There are no activity, please try searching.'] =
    '当前没有集结号活动，\n请尝试在上方搜索框中直接搜索关键字。'
L['Receiving active data, please wait patiently'] = '正在接收活动数据，请耐心等待'

L['Applicant Count'] = '申请人数'
L['Application Count'] = '申请中活动'
L['Activity Count'] = '活动总数'

L['Toggle MeetingHorn'] = '打开/关闭集结号'
L['Toggle MeetingHorn key binding'] = '打开/关闭集结号快捷键'
L['按键已绑定到|cffffd100%s|r，你确定要覆盖吗？'] = true

L['Options'] = '设置'
L['启用关键字过滤'] = true
L['关键字过滤'] = true
L['导入'] = true
L['导出'] = true
L['导入关键字'] = true
L['导出关键字'] = true
L['请输入需要屏蔽的关键字'] = true
L['正则?'] = true
L['添加失败，关键字错误。'] = true
L['添加失败，关键字“%s”已存在。'] = true
L['添加成功，关键字“%s”已添加。'] = true
L['删除失败，关键字错误。'] = true
L['删除失败，关键字“%s”不存在。'] = true
L['删除成功，关键字“%s”已删除。'] = true

L['Show data broker'] = '显示悬浮窗'
L['Hide activity in chat frame'] = '隐藏聊天窗口内的集结号活动'

L['CHANNEL: Port'] = '传送频道'
L['CHANNEL: Trade'] = '交易'
L['CHANNEL: Group'] = 'MeetingHorn'
L['CHANNEL: Recruit'] = '公会招募'

L['Wild PvP'] = '野外PvP'
L['Dire Maul - North'] = '厄运之槌 - 北' -- 厄运之槌 - 北
L['Dire Maul - West'] = '厄运之槌 - 西' -- 厄运之槌 - 西
L['Dire Maul - East'] = '厄运之槌 - 东' -- 厄运之槌 - 东
L['Upper Blackrock Spire'] = '黑石塔上层' -- 黑石塔上层
L['Lower Blackrock Spire'] = '黑石塔下层' -- 黑石塔下层
L['Scarlet Monastery - Cathedral'] = '血色修道院 - 大教堂' -- 血色修道院 - 大教堂
L['Scarlet Monastery - Armory'] = '血色修道院 - 军械库' -- 血色修道院 - 军械库
L['Scarlet Monastery - Library'] = '血色修道院 - 图书馆' -- 血色修道院 - 图书馆
L['Scarlet Monastery - Graveyard'] = '血色修道院 - 墓地' -- 血色修道院 - 墓地

L['Lord Kazzak'] = '卡扎克' -- 卡扎克
L['Azuregos'] = '艾索雷葛斯' -- 艾索雷葛斯
L['Ysondre'] = '伊森德雷' -- 伊森德雷
L['Taerar'] = '泰拉尔' -- 泰拉尔
L['Emeriss'] = '艾莫莉丝' -- 艾莫莉丝
L['Lethon'] = '莱索恩' -- 莱索恩

L['SHORT: Molten Core'] = 'MC' -- 熔火之心
L['SHORT: Onyxia\'s Lair'] = '黑龙' -- 奥妮克希亚的巢穴
L['SHORT: Blackwing Lair'] = 'BWL' -- 黑翼之巢
L['SHORT: Ahn\'Qiraj Temple'] = 'TAQ' -- 安其拉神殿
L['SHORT: Naxxramas'] = 'NAXX' -- 纳克萨玛斯
L['SHORT: Zul\'Gurub'] = 'ZUG' -- 祖尔格拉布
L['SHORT: Ruins of Ahn\'Qiraj'] = '废墟' -- 安其拉废墟
L['SHORT: Stratholme'] = 'STSM' -- 斯坦索姆
L['SHORT: Scholomance'] = 'TL' -- 通灵学院
L['SHORT: Dire Maul - North'] = '厄运北' -- 厄运之槌 - 北
L['SHORT: Dire Maul - West'] = '厄运西' -- 厄运之槌 - 西
L['SHORT: Dire Maul - East'] = '厄运东' -- 厄运之槌 - 东
L['SHORT: Upper Blackrock Spire'] = '黑上' -- 黑石塔上层
L['SHORT: Lower Blackrock Spire'] = '黑下' -- 黑石塔下层
L['SHORT: Blackrock Depths'] = '' -- 黑石深渊
L['SHORT: The Temple of Atal\'Hakkar'] = '神庙' -- 阿塔哈卡神庙
L['SHORT: Maraudon'] = 'MLD' -- 玛拉顿
L['SHORT: Zul\'Farrak'] = 'ZUL' -- 祖尔法拉克
L['SHORT: Uldaman'] = 'ADM' -- 奥达曼
L['SHORT: Razorfen Downs'] = '' -- 剃刀高地
L['SHORT: Scarlet Monastery - Cathedral'] = '' -- 血色修道院 - 大教堂
L['SHORT: Scarlet Monastery - Armory'] = '' -- 血色修道院 - 军械库
L['SHORT: Scarlet Monastery - Library'] = '' -- 血色修道院 - 图书馆
L['SHORT: Scarlet Monastery - Graveyard'] = '' -- 血色修道院 - 墓地
L['SHORT: Razorfen Kraul'] = '' -- 剃刀沼泽
L['SHORT: Gnomeregan'] = '' -- 诺莫瑞根
L['SHORT: The Stockade'] = '' -- 监狱
L['SHORT: Blackfathom Deeps'] = '' -- 黑暗深渊
L['SHORT: Shadowfang Keep'] = '' -- 影牙城堡
L['SHORT: Wailing Caverns'] = '' -- 哀嚎洞穴
L['SHORT: Deadmines'] = '' -- 死亡矿井
L['SHORT: Ragefire Chasm'] = '' -- 怒焰裂谷
L['SHORT: Alterac Valley'] = '奥山' -- 奥特兰克山谷
L['SHORT: Warsong Gulch'] = '战歌' -- 战歌峡谷
L['SHORT: Arathi Basin'] = '阿拉希' -- 阿拉希盆地
L['SHORT: Lord Kazzak'] = '' -- 卡扎克
L['SHORT: Azuregos'] = '蓝龙' -- 艾索雷葛斯
L['SHORT: Ysondre'] = '' -- 伊森德雷
L['SHORT: Taerar'] = '' -- 泰拉尔
L['SHORT: Emeriss'] = '' -- 艾莫莉丝
L['SHORT: Lethon'] = '' -- 莱索恩
