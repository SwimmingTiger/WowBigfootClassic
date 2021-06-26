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
ns.ADDON_VERSION = GetAddOnMetadata(ADDON_NAME, 'Version'):gsub('%-%d+', '')
ns.ADDON_TAG = '<' .. L.ADDON_NAME .. '>'

ns.APPLICANT_STATUS = {Normal = 1, Invited = 2, Declined = 3, Joined = 4}

local INSTANCE_DATA = {
    [2717] = {projectId = 2, logo = 'Ragnaros'}, -- 熔火之心
    [2159] = {projectId = 2, logo = 'Onyxia'}, -- 奥妮克希亚的巢穴
    [2677] = {projectId = 2, logo = 'Nefarian'}, -- 黑翼之巢
    [3428] = {projectId = 2, logo = 'CThun', instanceName = L['Ahn\'Qiraj Temple']}, -- 安其拉神殿
    [3456] = {projectId = 2, logo = 'KelThuzad'}, -- 纳克萨玛斯
    [1977] = {projectId = 2, logo = 'Avatar of Hakkar'}, -- 祖尔格拉布
    [3429] = {projectId = 2, logo = 'Ossirian the Unscarred'}, -- 安其拉废墟
    [3457] = {projectId = 5, logo = 'Prince Malchezaar'}, -- 卡拉赞
    [3923] = {projectId = 5, logo = 'Gruul the Dragonkiller'}, -- 格鲁尔的巢穴
    [3836] = {projectId = 5, logo = 'Magtheridon'}, -- 玛瑟里顿的巢穴
    [3607] = {projectId = 5, logo = 'Lady Vashj'}, -- 毒蛇神殿
    [3845] = {projectId = 5, logo = 'KaelThas Sunstrider'}, -- 风暴要塞
    [3606] = {projectId = 5, logo = 'Archimonde'}, -- 海加尔山
    [3959] = {projectId = 5, logo = 'Illidan Stormrage'}, -- 黑暗神庙
    [3805] = {projectId = 5, logo = 'Daakara'}, -- 祖阿曼
    [4075] = {projectId = 5, logo = 'Kiljaeden'}, -- 太阳井
}

ns.INSTANCE_DATA = {}
ns.CURRENT_RELEASE_INSTANCES = {}

for mapId, v in pairs(INSTANCE_DATA) do
    local name = C_Map.GetAreaInfo(mapId)
    if name then
        v.logo = [[Interface\ENCOUNTERJOURNAL\UI-EJ-BOSS-]] .. v.logo
        ns.INSTANCE_DATA[name] = v

        if v.projectId == WOW_PROJECT_ID then
            ns.CURRENT_RELEASE_INSTANCES[v.instanceName or name] = true
        end
    end
end

function ns.GetInstanceName(mapName)
    local data = ns.INSTANCE_DATA[mapName]
    if data then
        return data.instanceName or mapName
    end
end

function ns.GetInstanceLogo(mapName)
    local data = ns.INSTANCE_DATA[mapName]
    return data and data.logo
end

ns.GOODLEADER_INSTANCES = {
    ---- classic
    {projectId = 2, mapId = 2717, bossId = 672, image = 'moltencore'}, --
    {projectId = 2, mapId = 2159, bossId = 1084, image = 'onyxia'}, --
    {projectId = 2, mapId = 2677, bossId = 617, image = 'blackwinglair'}, --
    {projectId = 2, mapId = 3428, bossId = 717, image = 'templeofahnqiraj'}, --
    {projectId = 2, mapId = 3456, bossId = 1114, name = L['克尔苏加德'], image = 'naxxramas'}, --
    {projectId = 2, mapId = 3456, bossId = 1121, name = L['军事区'], image = 'naxxramas'}, --
    {projectId = 2, mapId = 3456, bossId = 1115, name = L['瘟疫区'], image = 'naxxramas'}, --
    {projectId = 2, mapId = 3456, bossId = 1116, name = L['蜘蛛区'], image = 'naxxramas'}, --
    {projectId = 2, mapId = 3456, bossId = 1120, name = L['构造区'], image = 'naxxramas'}, --
    {projectId = 2, mapId = 1977, bossId = 793, image = 'zulgurub'}, --
    {projectId = 2, mapId = 3429, bossId = 723, image = 'ruinsofahnqiraj'}, --
    ---- bcc
    {projectId = 5, mapId = 3457, bossId = 661, image = 'Karazhan'}, -- 卡拉赞
    {projectId = 5, mapId = 3923, bossId = 650, image = 'GruulsLair'}, -- 格鲁尔的巢穴
    {projectId = 5, mapId = 3836, bossId = 651, image = 'MagtheridonsLair'}, -- 玛瑟里顿的巢穴
    {projectId = 5, mapId = 3607, bossId = 628, image = 'CoilfangReservoir'}, -- 毒蛇神殿
    {projectId = 5, mapId = 3845, bossId = 733, image = 'TempestKeep'}, -- 风暴要塞
    {projectId = 5, mapId = 3606, bossId = 622, image = 'CavernsOfTime'}, -- 海加尔山
    {projectId = 5, mapId = 3959, bossId = 609, image = 'BlackTemple'}, -- 黑暗神庙
    {projectId = 5, mapId = 3805, bossId = 1189, image = 'ZulAman'}, -- 祖阿曼
    {projectId = 5, mapId = 4075, bossId = 729, image = 'SunwellPlateau'}, -- 太阳井
}

local CLASS_INFO = FillLocalizedClassList {}

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

local function GetSlotItemLevel(unit, slot)
    local id = GetInventoryItemID(unit, slot)
    if not id then
        return 0
    end
    local itemLevel = select(4, GetItemInfo(id))
    return itemLevel
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
    [16] = function(unit, slot)
        local id = GetInventoryItemID(unit, slot)
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
    [18] = GetSlotItemLevel,
}

function ns.GetPlayerItemLevel()
    return ns.GetUnitItemLevel('player')
end

function ns.GetUnitItemLevel(unit)
    local itemLevel = 0
    for slot, func in pairs(ITEMS) do
        itemLevel = itemLevel + (func(unit, slot) or 0)
    end
    local count = 17
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

local SOLO_GROUPS = {player = true}
local PARTY_GROUPS = (function()
    local r = {player = true}
    for i = 1, 4 do
        r['party' .. i] = true
    end
    return r
end)()
local RAID_GROUPS = (function()
    local r = {}
    for i = 1, 40 do
        r['raid' .. i] = true
    end
    return r
end)()

function ns.IterateGroup()
    if IsInRaid(LE_PARTY_CATEGORY_HOME) then
        return pairs(RAID_GROUPS)
    elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
        return pairs(PARTY_GROUPS)
    else
        return pairs(SOLO_GROUPS)
    end
end

function ns.UnitFullName(unit)
    local name, realm = UnitFullName(unit)
    if not name then
        return
    end
    return format('%s-%s', name, realm or GetRealmName():gsub('%s+', ''))
end

function ns.GetGroupLeader()
    for unit in ns.IterateGroup() do
        if UnitIsGroupLeader(unit) then
            return ns.UnitFullName(unit), UnitGUID(unit)
        end
    end
    return ns.UnitFullName('player'), UnitGUID('player')
end

function ns.GetGroupLooter()
    if IsInRaid() then
        for i = 1, 40 do
            local name, _, _, _, _, _, _, _, _, _, isML = GetRaidRosterInfo(i)
            if isML then
                return ns.UnitFullName(name), UnitGUID(name)
            end
        end
    end
    return ns.GetGroupLeader()
end

function ns.IsInGroup()
    return IsInGroup(LE_PARTY_CATEGORY_HOME)
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

function ns.SystemMessage(text)
    return DEFAULT_CHAT_FRAME:AddMessage(text, 1, 1, 0)
end

function ns.Message(msg, ...)
    if select('#', ...) > 0 then
        return ns.SystemMessage(string.format(ns.ADDON_PREFIX .. msg, ...))
    end
    return ns.SystemMessage(ns.ADDON_PREFIX .. msg)
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

function ns.FindAuraById(id, unit, filter)
    return AuraUtil.FindAura(function(idToFind, _, _, ...)
        local spellId = select(10, ...)
        return idToFind == spellId
    end, unit, filter, id)
end

function ns.RandomCall(sec, func, ...)
    local delay = random() * sec + 5
    local args = {...}
    C_Timer.After(delay, function()
        func(unpack(args))
    end)

    --[=[@debug@
    print('Random Call', delay, sec, func, ...)
    --@end-debug@]=]
end

local function SplitName(fullName)
    local name, realm = fullName:match('(.+)%-(.+)')
    if name then
        return name, realm
    end
    return fullName, GetRealmName():gsub('%s+', '')
end

function ns.MakeQRCode(leader)
    local name, realm = SplitName(leader)
    return format('https://tavern.blizzard.cn/miniprogram/goodLeader/detail?%s-%s-%s', realm, name, WOW_PROJECT_ID)
end

function ns.memorize(func)
    local cache = {}
    return function(k, ...)
        if not k then
            return
        end
        if cache[k] == nil then
            cache[k] = func(k, ...)
        end
        return cache[k]
    end
end

local R = ns.memorize(function(d)
    local r = {}
    for i, v in ipairs {strsplit(',', d)} do
        r[v] = true
    end
    return r
end)

local CLASS_ROLES = { --
    DRUID = {R('DAMAGER,MAGIC,RANGE'), R('TANK'), R('HEALER')},
    HUNTER = {R('DAMAGER,PHYSICAL,RANGE')},
    MAGE = {R('DAMAGER,MAGIC,RANGE')},
    PALADIN = {R('HEALER'), R('TANK'), R('DAMAGER,PHYSICAL,MELEE')},
    PRIEST = {R('HEALER'), R('HEALER'), R('DAMAGER,MAGIC,RANGE')},
    ROGUE = {R('DAMAGER,PHYSICAL,MELEE')},
    SHAMAN = {R('DAMAGER,MAGIC,RANGE'), R('DAMAGER,PHYSICAL,MELEE'), R('HEALER')},
    WARLOCK = {R('DAMAGER,MAGIC,RANGE')},
    WARRIOR = {R('DAMAGER,PHYSICAL,MELEE'), R('DAMAGER,PHYSICAL,MELEE'), R('TANK')},
}

local function GetCurrentRoles()
    local class = UnitClassBase('player')

    local roles = CLASS_ROLES[class]
    if #roles == 1 then
        return roles[1]
    end

    local maxTalentTabIndex
    do
        local maxPoints = -1
        for i = 1, GetNumTalentTabs() do
            local name, _, points = GetTalentTabInfo(i)
            if points > maxPoints then
                maxTalentTabIndex = i
                maxPoints = points
            end
        end
    end

    return roles[maxTalentTabIndex]
end

function ns.PlayerIsRole(role)
    return GetCurrentRoles()[role]
end

function ns.OpenUrlDialog(url)
    if not StaticPopupDialogs['MEETINGHORN_COPY_URL'] then
        StaticPopupDialogs['MEETINGHORN_COPY_URL'] = {
            text = '请按<|cff00ff00Ctrl+C|r>复制网址到浏览器打开',
            button1 = OKAY,
            timeout = 0,
            exclusive = 1,
            whileDead = 1,
            hideOnEscape = 1,
            hasEditBox = true,
            editBoxWidth = 260,
            EditBoxOnTextChanged = function(editBox, url)
                if editBox:GetText() ~= url then
                    editBox:SetMaxBytes(nil)
                    editBox:SetMaxLetters(nil)
                    editBox:SetText(url)
                    editBox:HighlightText()
                    editBox:SetCursorPosition(0)
                    editBox:SetFocus()
                end
            end,
        }
    end

    StaticPopup_Show('MEETINGHORN_COPY_URL', nil, nil, url)
end
