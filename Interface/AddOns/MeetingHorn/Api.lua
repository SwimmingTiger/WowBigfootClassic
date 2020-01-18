
---@type ns
local ADDON_NAME, ns = ...
local L = ns.L

---@class MeetingHornCategoryData
---@field path string
---@field name string
---@field channel string
---@field channels table<string, boolean>
---@field interval number
---@field timeout number
---@field members number
---@field inCity boolean

---@class MeetingHornActivityData
---@field name string
---@field shortName string
---@field nameLower string
---@field shortNameLower string
---@field path string
---@field members number
---@field minLevel number
---@field class string
---@field instanceName string
---@field category MeetingHornCategoryData

ns.MIN_INTERVAL = 10
ns.ADDON_PREFIX = format('|cff00ffff%s|r：', L.ADDON_NAME)
ns.ADDON_VERSION = GetAddOnMetadata(ADDON_NAME, 'Version')
ns.ADDON_TAG = '<' .. L.ADDON_NAME .. '>'

ns.APPLICANT_STATUS = {Normal = 1, Invited = 2, Declined = 3, Joined = 4}

local function invert(list, key)
    local result = {}
    for i, v in ipairs(list) do
        result[v[key]] = v
    end
    return result
end

local BASE_INTERVAL = 50
local BASE_TIMEOUT = 90

local function category(path, name, channel, interval, timeout, inCity)
    if not channel then
        channel = {L['CHANNEL: Group'], '寻求组队'}
    end

    local channels = {}
    if type(channel) == 'table' then
        for i, v in ipairs(channel) do
            channels[v] = true
        end
        channel = channel[1]
    else
        channels[channel] = true
    end

    return {
        path = path,
        name = name,
        channel = channel,
        channels = channels,
        interval = interval or BASE_INTERVAL,
        timeout = timeout or BASE_TIMEOUT,
        inCity = inCity,
    }
end

---@type MeetingHornCategoryData[]
local CATEGORY_LIST = {
    category('Quest', L.CATEGORY_QUEST), --
    category('Raid', L.CATEGORY_RAID), --
    category('Dungeon', L.CATEGORY_DUNGEON), --
    category('Boss', L.CATEGORY_BOSS), --
    category('PvP', L.CATEGORY_PVP), --
    category('Recruit', L.CATEGORY_RECRUIT, L['CHANNEL: Recruit'], 150, 300, true), --
    category('Port', L.CATEGORY_PORT, L['CHANNEL: Group'], 150, 300), --
    category('Summon', L.CATEGORY_SUMMON, L['CHANNEL: Group'], 150, 300), --
    category('Other', OTHER), --
    --[===[@debug@
    category('Debug', 'Debug', 'MeetingHornDebug'), --
    --@end-debug@]===]
}

local CLASS_INFO = FillLocalizedClassList{}
local MODE_LIST = {'带新', '自强', 'Roll', 'AA', '菜刀', '传送', '其它'}
local MODE_IDS = tInvert(MODE_LIST)
local CATEGORY_DATA = invert(CATEGORY_LIST, 'path')
local SHORT_NAMES = {
    [2717] = L['SHORT: Molten Core'], -- 熔火之心
    [2159] = L['SHORT: Onyxia\'s Lair'], -- 奥妮克希亚的巢穴
    [2677] = L['SHORT: Blackwing Lair'], -- 黑翼之巢
    [3428] = L['SHORT: Ahn\'Qiraj Temple'], -- 安其拉神殿
    [3456] = L['SHORT: Naxxramas'], -- 纳克萨玛斯
    [1977] = L['SHORT: Zul\'Gurub'], -- 祖尔格拉布
    [3429] = L['SHORT: Ruins of Ahn\'Qiraj'], -- 安其拉废墟
    [2017] = L['SHORT: Stratholme'], -- 斯坦索姆
    [2057] = L['SHORT: Scholomance'], -- 通灵学院
    ['Dire Maul - North'] = L['SHORT: Dire Maul - North'], -- 厄运之槌 - 北
    ['Dire Maul - West'] = L['SHORT: Dire Maul - West'], -- 厄运之槌 - 西
    ['Dire Maul - East'] = L['SHORT: Dire Maul - East'], -- 厄运之槌 - 东
    ['Upper Blackrock Spire'] = L['SHORT: Upper Blackrock Spire'], -- 黑石塔上层
    ['Lower Blackrock Spire'] = L['SHORT: Lower Blackrock Spire'], -- 黑石塔下层
    [1584] = L['SHORT: Blackrock Depths'], -- 黑石深渊
    [1477] = L['SHORT: The Temple of Atal\'Hakkar'], -- 阿塔哈卡神庙
    [2100] = L['SHORT: Maraudon'], -- 玛拉顿
    [1176] = L['SHORT: Zul\'Farrak'], -- 祖尔法拉克
    [1337] = L['SHORT: Uldaman'], -- 奥达曼
    [722] = L['SHORT: Razorfen Downs'], -- 剃刀高地
    ['Scarlet Monastery - Cathedral'] = L['SHORT: Scarlet Monastery - Cathedral'], -- 血色修道院 - 大教堂
    ['Scarlet Monastery - Armory'] = L['SHORT: Scarlet Monastery - Armory'], -- 血色修道院 - 军械库
    ['Scarlet Monastery - Library'] = L['SHORT: Scarlet Monastery - Library'], -- 血色修道院 - 图书馆
    ['Scarlet Monastery - Graveyard'] = L['SHORT: Scarlet Monastery - Graveyard'], -- 血色修道院 - 墓地
    [491] = L['SHORT: Razorfen Kraul'], -- 剃刀沼泽
    [721] = L['SHORT: Gnomeregan'], -- 诺莫瑞根
    [717] = L['SHORT: The Stockade'], -- 监狱
    [719] = L['SHORT: Blackfathom Deeps'], -- 黑暗深渊
    [209] = L['SHORT: Shadowfang Keep'], -- 影牙城堡
    [718] = L['SHORT: Wailing Caverns'], -- 哀嚎洞穴
    [1581] = L['SHORT: Deadmines'], -- 死亡矿井
    [2437] = L['SHORT: Ragefire Chasm'], -- 怒焰裂谷
    [2597] = L['SHORT: Alterac Valley'], -- 奥特兰克山谷
    [3277] = L['SHORT: Warsong Gulch'], -- 战歌峡谷
    [3358] = L['SHORT: Arathi Basin'], -- 阿拉希盆地
    ['Lord Kazzak'] = L['SHORT: Lord Kazzak'], -- 卡扎克
    ['Azuregos'] = L['SHORT: Azuregos'], -- 艾索雷葛斯
    ['Ysondre'] = L['SHORT: Ysondre'], -- 伊森德雷
    ['Taerar'] = L['SHORT: Taerar'], -- 泰拉尔
    ['Emeriss'] = L['SHORT: Emeriss'], -- 艾莫莉丝
    ['Lethon'] = L['SHORT: Lethon'], -- 莱索恩
}
local INSTANCE_NAMES = {
    [C_Map.GetAreaInfo(2717)] = C_Map.GetAreaInfo(2717), -- 熔火之心
    [C_Map.GetAreaInfo(2159)] = C_Map.GetAreaInfo(2159), -- 奥妮克希亚的巢穴
    [C_Map.GetAreaInfo(2677)] = C_Map.GetAreaInfo(2677), -- 黑翼之巢
    [C_Map.GetAreaInfo(3428)] = C_Map.GetAreaInfo(3428), -- 安其拉神殿
    [C_Map.GetAreaInfo(3456)] = C_Map.GetAreaInfo(3456), -- 纳克萨玛斯
    [C_Map.GetAreaInfo(1977)] = C_Map.GetAreaInfo(1977), -- 祖尔格拉布
    [C_Map.GetAreaInfo(3429)] = C_Map.GetAreaInfo(3429), -- 安其拉废墟
}

local function names(key)
    local id = tonumber(key)
    if id then
        return {C_Map.GetAreaInfo(id), SHORT_NAMES[key]}
    end
    return {L[key], SHORT_NAMES[key]}
end

local function base(name, path, minLevel, members, class)
    local shortName, shortNameLower
    if type(name) == 'table' then
        name, shortName = unpack(name)
    end

    if shortName == '' then
        shortName = nil
    end
    if shortName then
        shortNameLower = shortName:lower()
    end

    return {
        name = name,
        nameLower = name:lower(),
        shortName = shortName,
        shortNameLower = shortNameLower,
        path = path,
        members = members or 40,
        category = CATEGORY_DATA[path],
        minLevel = minLevel or 0,
        class = class,
        instanceName = INSTANCE_NAMES[name],
    }
end

local function raid(key, members)
    return base(names(key), 'Raid', 60, members or 40)
end

local function dungeon(key, minLevel, members)
    return base(names(key), 'Dungeon', minLevel, members or 5)
end

local function pvp(key, minLevel, members)
    return base(names(key), 'PvP', minLevel, members)
end

local function quest(key, minLevel)
    return base(names(key), 'Quest', minLevel, 40)
end

local function boss(key)
    return base(names(key), 'Boss', 60, 40)
end

---@type MeetingHornActivityData[]
local ACTIVITY_LIST = { --
    -- raid
    raid(2717), -- 熔火之心
    raid(2159), -- 奥妮克希亚的巢穴
    raid(2677), -- 黑翼之巢
    raid(3428), -- 安其拉神殿
    raid(3456), -- 纳克萨玛斯
    raid(1977, 20), -- 祖尔格拉布
    raid(3429, 20), -- 安其拉废墟
    -- 地下城
    dungeon(2017, 58), -- 斯坦索姆
    dungeon(2057, 58), -- 通灵学院
    dungeon('Dire Maul - North', 58), -- 厄运之槌 - 北
    dungeon('Dire Maul - West', 58), -- 厄运之槌 - 西
    dungeon('Dire Maul - East', 58), -- 厄运之槌 - 东
    dungeon('Upper Blackrock Spire', 55, 10), -- 黑石塔上层
    dungeon('Lower Blackrock Spire', 55), -- 黑石塔下层
    dungeon(1584, 52), -- 黑石深渊
    dungeon(1477, 50), -- 阿塔哈卡神庙
    dungeon(2100, 46), -- 玛拉顿
    dungeon(1176, 44), -- 祖尔法拉克
    dungeon(1337, 41), -- 奥达曼
    dungeon(722, 37), -- 剃刀高地
    dungeon('Scarlet Monastery - Cathedral', 35), -- 血色修道院 - 大教堂
    dungeon('Scarlet Monastery - Armory', 32), -- 血色修道院 - 军械库
    dungeon('Scarlet Monastery - Library', 29), -- 血色修道院 - 图书馆
    dungeon('Scarlet Monastery - Graveyard', 26), -- 血色修道院 - 墓地
    dungeon(491, 29), -- 剃刀沼泽
    dungeon(721, 29), -- 诺莫瑞根
    dungeon(717, 24), -- 监狱
    dungeon(719, 24), -- 黑暗深渊
    dungeon(209, 22), -- 影牙城堡
    dungeon(718, 17), -- 哀嚎洞穴
    dungeon(1581, 17), -- 死亡矿井
    dungeon(2437, 13), -- 怒焰裂谷
    -- 世界boss
    boss('Lord Kazzak'), -- 卡扎克
    boss('Azuregos'), -- 艾索雷葛斯
    boss('Ysondre'), -- 伊森德雷
    boss('Taerar'), -- 泰拉尔
    boss('Emeriss'), -- 艾莫莉丝
    boss('Lethon'), -- 莱索恩
    -- 战场
    pvp(2597, 40), -- 奥特兰克山谷
    pvp(3277, 10), -- 战歌峡谷
    pvp(3358, 15), -- 阿拉希盆地
    base(L['Wild PvP'], 'PvP'), -- 野外PVP
    -- 任务
    quest(1377), -- 希利苏斯
    quest(618), -- 冬泉谷
    quest(139), -- 东瘟疫之地
    quest(46), -- 燃烧平原
    quest(41), -- 逆风小径
    quest(28), -- 西瘟疫之地
    quest(16), -- 艾萨拉
    quest(361), -- 费伍德森林
    quest(490), -- 安戈洛环形山
    quest(4), -- 诅咒之地
    quest(51), -- 灼热峡谷
    quest(357), -- 菲拉斯
    quest(440), -- 塔纳利斯
    quest(47), -- 辛特兰
    quest(15), -- 尘泥沼泽
    quest(3), -- 荒芜之地
    quest(8), -- 悲伤沼泽
    quest(405), -- 凄凉之地
    quest(36), -- 奥特兰克山脉
    quest(45), -- 阿拉希高地
    quest(33), -- 荆棘谷
    quest(400), -- 千针石林
    quest(10), -- 暮色森林
    quest(267), -- 希尔斯布莱德丘陵
    quest(11), -- 湿地
    quest(331), -- 灰谷
    quest(406), -- 石爪山脉
    quest(44), -- 赤脊山
    quest(148), -- 黑海岸
    quest(17), -- 贫瘠之地
    quest(38), -- 洛克莫丹
    quest(130), -- 银松森林
    quest(40), -- 西部荒野
    quest(14), -- 杜隆塔尔
    quest(215), -- 莫高雷
    quest(141), -- 泰达希尔
    quest(1), -- 丹莫罗
    quest(12), -- 艾尔文森林
    quest(85), -- 提瑞斯法林地
    -- 传送
    base(L.CATEGORY_PORT, 'Port', 40, nil, 'MAGE'), --
    -- 召唤
    base(L.CATEGORY_SUMMON, 'Summon', 20, nil, 'WARLOCK'), --
    -- 招募
    base(L.CATEGORY_RECRUIT, 'Recruit'), --
    -- 其它
    base(OTHER, 'Other'), --
    --[===[@debug@
    base('Debug', 'Debug'),
    --@end-debug@]===]
}

ACTIVITY_LIST[0] = {path = 'Other', name = CHANNEL, interval = 30, timeout = 60, category = CATEGORY_DATA['Other']}

local function pick(path, isCreator)
    local result = {}
    local minLevel = 60
    for i, v in ipairs(ACTIVITY_LIST) do
        if v.path == path then
            tinsert(result, {
                text = v.name,
                value = i,
                disabled = isCreator and function()
                    return UnitLevel('player') < v.minLevel or (v.class and v.class ~= UnitClassBase('player')) or
                               (v.category.inCity and not ns.LFG:IsInCity())
                end,
                tooltipWhileDisabled = true,
                tooltipOnButton = true,
                tooltipMore = isCreator and function(tip)
                    tip:SetText(v.name)
                    if UnitLevel('player') < v.minLevel then
                        tip:AddLine(format(L['Requires Level %s'], v.minLevel), 1, 0, 0)
                    end
                    if v.class and v.class ~= UnitClassBase('player') then
                        tip:AddLine(format(L['Requires Class %s'], ns.GetClassLocale(v.class)), 1, 0, 0)
                    end
                    if v.category.inCity and not ns.LFG:IsInCity() then
                        tip:AddLine(L['Requires Zone City'], 1, 0, 0)
                    end
                end,
            })

            minLevel = math.min(minLevel, v.minLevel)
        end
    end
    return result, minLevel
end

ns.ACTIVITY_MENU = {}
ns.ACTIVITY_FILTER_MENU = {{text = ALL}}
ns.MODE_MENU = {}
ns.MODE_FILTER_MENU = {{text = ALL}}

for _, category in ipairs(CATEGORY_LIST) do
    local path = category.path
    local children, minLevel = pick(path, true)
    if #children > 1 then
        tinsert(ns.ACTIVITY_MENU, {
            text = category.name,
            hasArrow = true,
            notClickable = true,
            disabled = function()
                return UnitLevel('player') < minLevel
            end,
            menuTable = children,
        })
        tinsert(ns.ACTIVITY_FILTER_MENU, {text = category.name, hasArrow = true, value = path, menuTable = pick(path)})
    else
        tinsert(ns.ACTIVITY_MENU, children[1])
        tinsert(ns.ACTIVITY_FILTER_MENU, pick(path)[1])
    end
end

for id, mode in ipairs(MODE_LIST) do
    local menuItem = {text = mode, value = id}
    tinsert(ns.MODE_MENU, menuItem)
    tinsert(ns.MODE_FILTER_MENU, menuItem)
end

local ACTIVITY_IDS = {}

for id, v in ipairs(ACTIVITY_LIST) do
    assert(not ACTIVITY_IDS[v.name])
    ACTIVITY_IDS[v.name] = id

    if v.shortName then
        assert(not ACTIVITY_IDS[v.shortName])
        ACTIVITY_IDS[v.shortName] = id
    end
end

local OUR_CHANNELS = {}

for i, v in ipairs(CATEGORY_LIST) do
    OUR_CHANNELS[v.channel] = true

    for k, v in pairs(v.channels) do
        OUR_CHANNELS[k] = true
    end
end

function ns.NameToId(name)
    return ACTIVITY_IDS[name]
end

function ns.ModeToId(mode)
    return MODE_IDS[mode]
end

function ns.IdToMode(id)
    return MODE_LIST[id]
end

function ns.IsOurChannel(name)
    if OUR_CHANNELS[name] then
        return true
    end
    return OUR_CHANNELS[ns.Channel:GetUsChannelName(name)]
end

function ns.GetOurChannels()
    return OUR_CHANNELS
end

---@param id number
---@return MeetingHornActivityData
function ns.GetActivityData(id)
    return ACTIVITY_LIST[id]
end

---@param path string
---@return MeetingHornCategoryData
function ns.GetCategoryData(path)
    return CATEGORY_DATA[path]
end

function ns.IsCompatChannel(channelName)
    return --[[channelName == '交易' or]] channelName:match('^大脚世界频道')
end

function ns.ShortChannelName(channelName)
    if #channelName > 12 then
        return channelName:gsub('频道', '')
    end
    return channelName
end

function ns.UnitInGroup(unit)
    return UnitInParty(unit) or UnitInRaid(unit)
end

function ns.IsGroupLeader()
    return not IsInGroup(LE_PARTY_CATEGORY_HOME) or UnitIsGroupLeader('player', LE_PARTY_CATEGORY_HOME)
end

function ns.GetNumGroupMembers()
    local num = GetNumGroupMembers(LE_PARTY_CATEGORY_HOME)
    return num > 0 and num or 1
end

function ns.GetClassLocale(classFileName)
    return CLASS_INFO[classFileName]
end

local function GetSlotItemLevel(slot)
    local id = GetInventoryItemID('player', slot)
    if not id then
        return 0
    end
    local itemLevel = select(4, GetItemInfo(id))
    return itemLevel
end

local function IsNoRangeWeaponClass()
    local class = select(2, UnitClass('player'))
    return class == 'PALADIN' or class == 'SHAMAN' or class == 'DRUID'
end

local ITEMS = { --
    [1] = GetSlotItemLevel,
    [2] = GetSlotItemLevel,
    [3] = GetSlotItemLevel,
    [5] = GetSlotItemLevel,
    [6] = GetSlotItemLevel,
    [7] = GetSlotItemLevel,
    [8] = GetSlotItemLevel,
    [9] = GetSlotItemLevel,
    [10] = GetSlotItemLevel,
    [11] = GetSlotItemLevel,
    [12] = GetSlotItemLevel,
    [13] = GetSlotItemLevel,
    [14] = GetSlotItemLevel,
    [15] = GetSlotItemLevel,
    [16] = function(slot)
        local id = GetInventoryItemID('player', slot)
        if not id then
            return 0
        end
        local itemLevel, _, _, _, _, itemEquipLoc = select(4, GetItemInfo(id))
        if itemEquipLoc == 'INVTYPE_2HWEAPON' then
            return itemLevel * 2
        end
        return itemLevel
    end,
    [17] = GetSlotItemLevel,
    [18] = function()
        if IsNoRangeWeaponClass() then
            return 0
        end
        return GetSlotItemLevel(18)
    end,
}

function ns.GetPlayerItemLevel()
    local itemLevel = 0
    for slot, func in pairs(ITEMS) do
        itemLevel = itemLevel + func(slot)
    end
    local count = IsNoRangeWeaponClass() and 16 or 17
    return floor(itemLevel / count * 10) / 10
end

function ns.GetRaidId(raidName)
    for i = 1, GetNumSavedInstances() do
        local name, id = GetSavedInstanceInfo(i)
        if name == raidName then
            return id
        end
    end
    return -1
end

function ns.GetGroupLeader()
    if IsInRaid() then
        for i = 1, 40 do
            local unit = 'raid' .. i
            if UnitIsGroupLeader(unit) then
                return UnitName(unit), UnitGUID(unit)
            end
        end
    elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
        for i = 1, 4 do
            local unit = 'party' .. i
            if UnitIsGroupLeader(unit) then
                return UnitName(unit), UnitGUID(unit)
            end
        end
    end
    return UnitName('player'), UnitGUID('player')
end

function ns.GetGroupLooter()
    if IsInRaid() then
        for i = 1, 40 do
            local name, _, _, _, _, _, _, _, _, _, isML = GetRaidRosterInfo(i)
            if isML then
                return UnitName(name), UnitGUID(name)
            end
        end
    end
    return ns.GetGroupLeader()
end

function ns.tRemoveIf(t, condition)
    local any = false
    for i = #t, 1, -1 do
        local item = t[i]
        if condition(item) then
            tremove(t, i)
            any = true
        end
    end
    return any
end

function ns.Message(msg, ...)
    if select('#', ...) > 0 then
        return SendSystemMessage(string.format(ns.ADDON_PREFIX .. msg, ...))
    end
    return SendSystemMessage(ns.ADDON_PREFIX .. msg)
end

function ns.FireHardWare()
    return ns.LFG:OnHardWare()
end

-- function ns.ParseRaidTag(message)
--     for tag in string.gmatch(message, '%b{}') do
--         local term = strlower(string.gsub(tag, '[{}]', ''))
--         if ICON_TAG_LIST[term] and ICON_LIST[ICON_TAG_LIST[term]] then
--             message = string.gsub(message, tag, ICON_LIST[ICON_TAG_LIST[term]] .. '0|t')
--         end
--     end
--     return message
-- end

local function replace(x)
    return ''
end

function ns.ParseRaidTag(text)
    return (text:gsub('{([^{]+)}', replace))
end
