-- ActivityBuilder.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/14/2021, 6:09:47 PM
--
---@type ns
local ns = select(2, ...)

local L = ns.L

local CATEGORY_LIST = {}
local ACTIVITY_LIST = {}
local MODE_LIST = {}

local CATEGORY_DATA = {}
local OUR_CHANNELS = {}
local ACTIVITY_IDS = {}
local MODE_IDS = {}

ns.ACTIVITY_MENU = {}
ns.ACTIVITY_FILTER_MENU = {{text = ALL}}
ns.MODE_MENU = {}
ns.MODE_FILTER_MENU = {{text = ALL}}

local BASE_INTERVAL = 50
local BASE_TIMEOUT = 90

local Builder = {}

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
    [3457] = 'KLZ',
    [3923] = '格鲁尔',
    [3836] = '玛瑟里顿',

    -- P(5, 1):raid(3457) -- 卡拉赞
    -- P(5, 1):raid(3923) -- 格鲁尔的巢穴
    -- P(5, 1):raid(3836) -- 玛瑟里顿的巢穴
    -- P(5, 2):raid(3607) -- 毒蛇神殿
    -- P(5, 2):raid(3845) -- 风暴要塞
    -- P(5, 2):raid(3606) -- 海加尔山
    -- P(5, 2):raid(3959) -- 黑暗神庙
    -- P(5, 3):raid(3805) -- 祖阿曼
    -- P(5, 4):raid(4075) -- 太阳井
}

local PROJECTS = {[2] = {[2] = true}, [5] = {[2] = true, [5] = true}}

---@class InstanceBuilder
local InstanceBuilder = {projectId = nil, phase = nil}

local function names(key, normalAndHero, isHero)
    local id = tonumber(key)
    local r
    if id then
        r = {C_Map.GetAreaInfo(id), SHORT_NAMES[key]}
    else
        r = {L[key], SHORT_NAMES[key]}
    end

    if normalAndHero then
        for i, v in pairs(r) do
            r[i] = v .. (isHero and '（英雄）' or '（普通）')
        end
    end
    return r
end

function InstanceBuilder:base(name, path, minLevel, members, class)
    local shortName, shortNameLower
    if type(name) == 'table' then
        name, shortName = unpack(name)
    end
    if not name then
        return
    end
    if self.projectId and not PROJECTS[WOW_PROJECT_ID][self.projectId] then
        return
    end

    if shortName == '' then
        shortName = nil
    end
    if shortName then
        shortNameLower = shortName:lower()
    end

    local id = #ACTIVITY_LIST + 1

    tinsert(ACTIVITY_LIST, {
        projectId = self.projectId,
        phase = self.phase,
        name = name,
        nameLower = name:lower(),
        shortName = shortName,
        shortNameLower = shortNameLower,
        path = path,
        members = members or 40,
        category = CATEGORY_DATA[path],
        minLevel = minLevel or 0,
        class = class,
        instanceName = ns.GetInstanceName(name),
        id = id,
    })

    ACTIVITY_IDS[name] = id
    if shortName then
        ACTIVITY_IDS[shortName] = id
    end
end

function InstanceBuilder:raid(key, members)
    local members = members or self.projectId == 2 and 40 or self.projectId == 5 and 25
    local minLevel = self.projectId == 2 and 60 or self.projectId == 5 and 70
    return self:base(names(key), 'Raid', minLevel, members)
end

function InstanceBuilder:normal(key, minLevel, members)
    return self:base(names(key, true, false), 'Dungeon', minLevel, members or 5)
end

function InstanceBuilder:hero(key, minLevel, members)
    return self:base(names(key, true, true), 'Dungeon', minLevel, members or 5)
end

function InstanceBuilder:dungeon(key, minLevel, members)
    return self:base(names(key), 'Dungeon', minLevel, members or 5)
end

function InstanceBuilder:pvp(key, minLevel, members)
    return self:base(names(key), 'PvP', minLevel, members)
end

function InstanceBuilder:quest(key, minLevel)
    return self:base(names(key), 'Quest', minLevel, 40)
end

function InstanceBuilder:boss(key)
    return self:base(names(key), 'Boss', 60, 40)
end

function InstanceBuilder:new(obj)
    self._mt = self._mt or {__index = self}
    return setmetatable(obj, self._mt)
end

---@return InstanceBuilder
function Builder.P(projectId, phase)
    return InstanceBuilder:new({projectId = projectId, phase = phase})
end

function Builder.M(name)
    tinsert(MODE_LIST, name)
    MODE_IDS[name] = #MODE_LIST
end

function Builder.C(path, name, channel, interval, timeout, inCity)
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

    local category = {
        path = path,
        name = name,
        channel = channel,
        channels = channels,
        interval = interval or BASE_INTERVAL,
        timeout = timeout or BASE_TIMEOUT,
        inCity = inCity,
    }

    tinsert(CATEGORY_LIST, category)
    CATEGORY_DATA[path] = category

    OUR_CHANNELS[channel] = true
    for k in pairs(channels) do
        OUR_CHANNELS[k] = true
    end
end

function Builder.End()
    ns.Builder = nil

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
                    -- hidden = function(...)
                    --     return v.phase and v.phase > 1
                    -- end,
                })

                minLevel = math.min(minLevel, v.minLevel)
            end
        end
        return result, minLevel
    end

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
            tinsert(ns.ACTIVITY_FILTER_MENU,
                    {text = category.name, hasArrow = true, value = path, menuTable = pick(path)})
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
end

ns.Builder = Builder

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
