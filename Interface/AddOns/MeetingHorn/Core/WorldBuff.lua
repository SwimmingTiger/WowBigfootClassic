-- 世界BUFF
local GetServerTime = GetServerTime
local GetTime = GetTime
local UnitPosition = UnitPosition
local UnitGUID = UnitGUID
local UnitFactionGroup = UnitFactionGroup
local strsplit = strsplit
local ipairs = ipairs
local pairs = pairs
local C_Map = C_Map
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local UnitName = UnitName

---@type ns
local ADDON_NAME, ns = ...
local L = ns.L

local NPC_DATA = {
    Alliance = {
        zone = {1453, 1429}, -- 暴风城, 艾尔文森林
        [L['玛丁雷少校']] = {
            id = 22888,
            npc = 14394, --
        },
        [L['艾法希比元帅']] = {
            id = 22888,
            npc = 14721, -- 
        },
    },
    Horde = {
        zone = {1454, 1411}, -- 奥格瑞玛, 杜隆塔尔
        [L['伦萨克']] = { -- 龙头
            id = 22888,
            npc = 14392,
        },
        [L['萨鲁法尔大王']] = { -- 龙头
            id = 22888,
            npc = 14720,
        },
        [L['萨尔']] = { -- 酋长祝福
            id = 16609,
            npc = 4949,
        },
    },
}

---@class MeetingHornBuff
local WorldBuff = ns.Addon:NewModule('WorldBuff', 'AceEvent-3.0', 'AceTimer-3.0', 'AceComm-3.0')
WorldBuff:Disable()

function WorldBuff:OnEnable()
    self.data = {}
    self:RegisterEvent('CHAT_MSG_MONSTER_YELL')
    self:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
    --[===[@debug@
    print('buff enable')
    --@end-debug@]===]
end

function WorldBuff:OnDisable()
    self:UnregisterAllEvents()
    --[===[@debug@
    print('buff disable')
    --@end-debug@]===]
end

function WorldBuff:SetStatus(enable)
    self.enable = enable
    --[===[@debug@
    print('SetStatus', enable, self:IsZoneUsable())
    --@end-debug@]===]
    self:CheckEnable()
end

function WorldBuff:CheckEnable()
    if self:IsZoneUsable() then
        self:Enable()
    else
        self:Disable()
    end
end

function WorldBuff:GetData()
    return NPC_DATA[(UnitFactionGroup('player'))]
end

function WorldBuff:IsZoneUsable()
    if not self.enable then
        return
    end

    if ns.UnitInGroup('player') then
        return
    end

    local data = self:GetData()
    if not data then
        return
    end

    local playerZone = C_Map.GetBestMapForUnit('player')
    for _, zoneId in ipairs(data.zone) do
        if zoneId == playerZone then
            return true
        end
    end
end

function WorldBuff:RecordYell(item, name)
    self.data[item.id] = self.data[item.id] or {}
    self.data[item.id][item.npc] = GetServerTime()
end

function WorldBuff:CHAT_MSG_MONSTER_YELL(_, msg, name)
    local data = self:GetData()
    local item = data and data[name] or nil
    if item then
        self:RecordYell(item, name)
        --[===[@debug@
        print('Record Yell', name, msg)
        --@end-debug@]===]
    end
end

function WorldBuff:SetPos(data)
    self.pos = {}
    for i, v in ipairs(data) do
        if type(v) == 'table' and #v == 4 then
            self.pos[v[1]] = {x = v[2], y = v[3], distance = v[4]}
        end
    end
    --[===[@debug@
    print(self.pos)
    --@end-debug@]===]
end

function WorldBuff:TestPlayerPos(npc)
    if not self.pos or not self.pos[npc] then
        return true
    end
    local pos = self.pos[npc]
    local x, y = UnitPosition('player')
    local distance = math.abs(((pos.x - x) ^ 2 + (pos.y - y) ^ 2) ^ 0.5)
    --[===[@debug@
    print('Test distance', distance <= pos.distance)
    --@end-debug@]===]
    return distance <= pos.distance
end

function WorldBuff:CheckValidBuff(spellName, id, data)
    local spellId = select(10, AuraUtil.FindAuraByName(spellName, 'player'))
    if spellId ~= id then
        --[===[@debug@
        print('Not found buff')
        --@end-debug@]===]
        return
    end
    for npc, t in pairs(data) do
        --[===[@debug@
        print('Test npc Yell time', GetServerTime(), t, GetServerTime() - t)
        --@end-debug@]===]
        if self:TestPlayerPos(npc) and GetServerTime() - t <= 10 then
            return npc
        end
    end
end

--[===[@debug@
function WorldBuff:Test()
    local data = self:GetData()
    if not data then
        print('INVALID DATA')
        return
    end

    local unitType, _, _, _, zoneId, npcId = strsplit('-', UnitGUID('target'))
    if unitType ~= 'Creature' then
        print('Target a NPC Please')
        return
    end

    for k, item in pairs(data) do
        if k ~= 'zone' then
            ns.LFG:KillWorldBuffNpc(zoneId, item.npc)
            print('KillWorldBuffNpc', zoneId, item.npc)
            ns.LFG:WorldBuff(zoneId, item.npc, item.id)
            print('WorldBuff', zoneId, item.npc, item.id)
        end
    end
end
C_Timer.After(3, function()
    SLASH_TESTWORLDBUFF1 = '/testwb'
    SlashCmdList.TESTWORLDBUFF = function()
        if WorldBuff.enable then
            WorldBuff:Test()
        else
            print('Server not open')
        end
    end
end)
--@end-debug@]===]

function WorldBuff:COMBAT_LOG_EVENT_UNFILTERED()
    local timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName,
          destFlags, destRaidFlags, _, spellName = CombatLogGetCurrentEventInfo()
    if subEvent == 'UNIT_DIED' then
        local data = self:GetData()
        if not data or not data[destName] then
            return
        end

        local unitType, _, _, _, zoneId, npcId = strsplit('-', destGUID)
        if unitType ~= 'Creature' then
            return
        end

        if not self:TestPlayerPos(npcId) then
            return
        end

        ns.LFG:KillWorldBuffNpc(zoneId, npcId)
    elseif subEvent == 'SPELL_AURA_APPLIED' or subEvent == 'SPELL_AURA_REFRESH' then
        if destName ~= UnitName('player') then
            return
        end

        --[===[@debug@
        print(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName,
              destFlags, destRaidFlags, _, spellName)
        --@end-debug@]===]

        local unitType, _, _, _, zoneId, npcId = strsplit('-', sourceGUID)
        if unitType ~= 'Creature' then
            return
        end

        --[===[@debug@
        print('Instance id', zoneId)
        --@end-debug@]===]

        for spellId, v in pairs(self.data) do
            local npc = self:CheckValidBuff(spellName, spellId, v)
            if npc then
                ns.LFG:WorldBuff(zoneId, npc, spellId)
                -- 回传一次就清空
                wipe(self.data)
                break
            end
        end
    end

end
