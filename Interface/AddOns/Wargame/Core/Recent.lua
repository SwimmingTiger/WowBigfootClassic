-- Recent.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 7/3/2020, 2:04:22 PM
---@type ns
local ns = select(2, ...)

---@type NeteaseWargameRecent
local Recent = ns.Addon:NewModule('Recent', 'AceEvent-3.0')

function Recent:OnEnable()
    self.db = ns.Addon.C.recents
    self.game = ns.Wargame.game

    self:RegisterEvent('GROUP_ROSTER_UPDATE')
    self:GROUP_ROSTER_UPDATE()
end

function Recent:GROUP_ROSTER_UPDATE()
    if not IsWargame() then
        return
    end

    for _, unit in ns.IterateGroupUnits() do
        if UnitExists(unit) and not UnitIsUnit(unit, 'player') then
            self:SaveRecent(self.game.id, unit)
        end
    end
end

function Recent:SaveRecent(gameId, unit)
    self.db[gameId] = self.db[gameId] or {}

    local recents = self.db[gameId]
    local guid = UnitGUID(unit)

    local index = FindInTableIf(recents, function(v)
        return v.guid == guid
    end)

    if index then
        tremove(recents, index)
    end

    tinsert(recents, 1, { --
        guid = guid,
        name = UnitName(unit),
        race = ns.UnitRace(unit),
        class = ns.UnitClass(unit),
    })
end

function Recent:GetRecents(gameId)
    return self.db[gameId or 0]
end
