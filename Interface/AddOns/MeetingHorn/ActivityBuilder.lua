-- ActivityBuilder.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/14/2021, 6:09:47 PM
--
---@class ns
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
    ['Doomwalker'] = L['SHORT: Doomwalker'], -- 末日行者
    ['Lord Kazzak'] = L['SHORT: Lord Kazzak'], -- 卡扎克
    ['Azuregos'] = L['SHORT: Azuregos'], -- 艾索雷葛斯
    ['Ysondre'] = L['SHORT: Ysondre'], -- 伊森德雷
    ['Taerar'] = L['SHORT: Taerar'], -- 泰拉尔
    ['Emeriss'] = L['SHORT: Emeriss'], -- 艾莫莉丝
    ['Lethon'] = L['SHORT: Lethon'], -- 莱索恩
    [3457] = 'KLZ',
    [3923] = 'GLR',
    [3836] = 'MSLD',
    [3607] = 'DS',
    [3845] = 'FB',
    [3606] = 'HS',
    [3959] = 'BT',
    [3805] = 'ZAM',
    [4075] = 'SW',

    [4722] = 'TOC',
    [4812] = 'ICC',
    [4273] = 'ULD',
    [4603] = '宝库',
    [4493] = 'OS',
    [4987] = '红玉',
}

local SEARCH_MATCH = {['5H'] = {activityId = 'Dungeon', search = '英雄', input = '5H', name = '5H'}}
local AVAILABLE_ACTIVITY = {}

local DIFFICULTY_GROUP_SIZE = { --
    [3] = 10,
    [4] = 25,
    [5] = 10,
    [6] = 25,
}

---@class InstanceBuilder
local InstanceBuilder = {projectId = nil, phase = nil}

local function names(key, difficultyName)
    local id = tonumber(key)
    local r
    if id then
        r = {C_Map.GetAreaInfo(id), SHORT_NAMES[key]}
    else
        r = {L[key], SHORT_NAMES[key]}
    end

    if difficultyName then
        -- for i, v in ipairs(r) do
        --     r[i] = format('%s（%s）', v, difficultyName)
        -- end
        r[1] = format('%s（%s）', r[1], difficultyName)
    end
    return r
end

function InitAvailableActivity()
    local categories = C_LFGList.GetAvailableCategories();
    for k, v in ipairs(categories) do
        local activities = C_LFGList.GetAvailableActivities(v);
        local category = {categoryId = v, activities = {}}
        for k1, v1 in ipairs(activities) do
            local cfg = C_LFGList.GetActivityInfoTable(v1)
            local name = cfg.fullName;
            local name1, name2
            local s, e = strfind(name, '-')
            if s then
                name1 = strsub(name, 0, s - 2)
                name2 = strsub(name, e + 2)
            end
            tinsert(category.activities, {activityId = v1, name = name, name1 = name1, name2 = name2})
        end
        tinsert(AVAILABLE_ACTIVITY, category)
    end
end

function InstanceBuilder:base(name, path, minLevel, members, class)
    local shortName, shortNameLower
    if type(name) == 'table' then
        name, shortName = unpack(name)
    end
    if not name then
        return
    end
    if self.projectId and self.projectId > WOW_PROJECT_ID then
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
    if shortName and self.projectId < 11 then
        ACTIVITY_IDS[shortName] = id
    end
end

function InstanceBuilder:raid(key, members)
    local members = members or self.projectId == 2 and 40 or 25
    local minLevel = ns.PROJECT_DATA[self.projectId].maxLevel
    return self:base(names(key), 'Raid', minLevel, members)
end

function InstanceBuilder:raid2(key, difficultyId)
    local difficultyName = GetDifficultyInfo(difficultyId):gsub('（', ''):gsub('）', '')
    local members = DIFFICULTY_GROUP_SIZE[difficultyId]
    local minLevel = ns.PROJECT_DATA[self.projectId].maxLevel
    return self:base(names(key, difficultyName), 'Raid', minLevel, members)
end

function InstanceBuilder:normal(key, minLevel, members)
    local difficultyName = GetDifficultyInfo(1)
    return self:base(names(key, difficultyName), 'Dungeon', minLevel, members or 5)
end

function InstanceBuilder:hero(key, minLevel, members)
    local difficultyName = GetDifficultyInfo(2)
    return self:base(names(key, difficultyName), 'Dungeon', minLevel, members or 5)
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

function InstanceBuilder:boss(key, minLevel)
    return self:base(names(key), 'Boss', minLevel, 40)
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

function Builder.C(path, name, useProject, channel, interval, timeout, inCity)
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
        useProject = useProject,
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

    local function pickPath(path, isCreator, projectId)
        local result = {}
        local minLevel = ns.PROJECT_DATA[WOW_PROJECT_ID].maxLevel

        for i, v in ipairs(ACTIVITY_LIST) do
            if v.path == path and (not projectId or v.projectId == projectId) then
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

    local function pickProjects(path, isCreator)
        local result = {}
        local minLevel = ns.PROJECT_DATA[WOW_PROJECT_ID].maxLevel

        for _, projectId in ipairs(ns.PROJECT_DATA[WOW_PROJECT_ID].projects) do
            local menu, _minLevel = pickPath(path, isCreator, projectId)

            tinsert(result, { --
                text = ns.PROJECT_DATA[projectId].name,
                hasArrow = true,
                notClickable = true,
                menuTable = menu,
            })

            minLevel = math.min(minLevel, _minLevel)
        end
        return result, minLevel
    end

    local function pick(path, useProject, isCreator)
        if useProject then
            return pickProjects(path, isCreator)
        else
            return pickPath(path, isCreator)
        end
    end

    for _, category in ipairs(CATEGORY_LIST) do
        local children, minLevel
        local path = category.path
        children, minLevel = pick(path, category.useProject, true)

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
                    {text = category.name, hasArrow = true, value = path, menuTable = pick(path, category.useProject)})
        else
            tinsert(ns.ACTIVITY_MENU, children[1])
            tinsert(ns.ACTIVITY_FILTER_MENU, pickPath(path)[1])
        end
    end

    for id, mode in ipairs(MODE_LIST) do
        local menuItem = {text = mode, value = id}
        tinsert(ns.MODE_MENU, menuItem)
        tinsert(ns.MODE_FILTER_MENU, menuItem)
    end

    InitAvailableActivity()
end

ns.Builder = Builder

function ns.NameToId(name)
    return ACTIVITY_IDS[name]
end

function ns.MatchId(name)
    for _, v in ipairs(ACTIVITY_LIST) do
        if v.name:find(name, nil, true) then
            return v.id
        end
    end
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

function ns.GetMatchAvailableActivity(activityId)
    if #AVAILABLE_ACTIVITY == 0 then
        InitAvailableActivity()
    end
    local activityData = ns.GetActivityData(activityId)
    local activityName = activityData.name
    local index = strfind(activityName, '（普通）')
    activityName = strsub(activityName, 1, index and index - 1)
    for k, v in ipairs(AVAILABLE_ACTIVITY) do
        for k1, v1 in ipairs(v.activities) do
            if v1.name == activityName or v1.name1 == activityName or v1.name2 == activityName then
                return v.categoryId, v1.activityId
            end
        end
    end
end
