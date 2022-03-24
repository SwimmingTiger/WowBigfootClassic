SpyData = Spy:NewModule("SpyData")
local L = LibStub("AceLocale-3.0"):GetLocale("Spy", true)

local Spy = Spy

local bor = bit.bor
local band = bit.band
local time = time

local Spy_db = {
    session = {
        players = {},
    },
    pvp = {
        incoming = {},
        outgoing = {},
    },
    ignored = {},
    tooltips = {
        pets = {},
    },
}

-- session pointers to units
setmetatable(Spy_db.session.players, {
    __mode = "k",
    __index = function(t, k)
        rawset(t, k, {})
        return t[k]
    end,
})

-- pvp timer pointers to units
setmetatable(Spy_db.pvp.incoming, {__mode = "k"})
setmetatable(Spy_db.pvp.outgoing, {__mode = "k"})

local cache = {
    players = {
        name = {data = {}},
        level = {data = {}},
        class = {data = {}},
        guild = {data = {}},
        wins = {data = {}},	
        loses = {data = {}},
		time = {data = {}},
    },
r}

-- cache pointers to units
setmetatable(cache.players.time.data, {__mode = "v"})

-- temporary table pool
local tp = {}
setmetatable(tp, {__mode = "k"})

local function getTable()
    local t = next(tp) or {}
    tp[t] = nil
    return t
end

local function releaseTable(t)
    if type(t) ~= "table" then
		return
	end
    for k in pairs(t) do t[k] = nil end
    t[1] = true; t[1] = nil
    tp[t] = true
    return nil
end

local emptyTable = {}

function SpyData:OnInitialize()
    Spy:SetDataDb(Spy_db)  --> Spy.lua
end

function SpyData:OnEnable()
    -- unit testing
    if SpyUnitTest then
		SpyUnitTest:LoadData(Spy_db, cache)
	end
end

function SpyData:SetSavedVariablesDb(val)
	Spy_db.units = SpyDB.kosData[Spy.RealmName][Spy.FactionName][Spy.CharacterName].unit	
end

function SpyData:GetUnitSession(unit) --++
--    if unit.isEnemy then	
        return Spy_db.session.players[unit]
 --   end
end

function SpyData:SetUnitReason(unit, reason)  --??
    if unit.isEnemy then
		unit.reason = reason
	end	
end

function SpyData:AddPlayer(unit)  -- Delete
    if unit.isEnemy then	
		SpyPerCharDB.PlayerData[unit.name] = unit
		SpyDB.kosData[Spy.RealmName][Spy.FactionName][Spy.CharacterName][unit.name] = unit	
	end
end

function SpyData:IsPlayer(name)  --??
    return (SpyPerCharDB.PlayerData[name] and true or false)	
end

function SpyData:GetPlayer(name) --++
    return SpyPerCharDB.PlayerData[name]	
end

function SpyData:SetPlayerKos(unit, value) --??
    assert(unit, "Invalid unit (" .. tostring(unit) .. ")")
    if unit.isEnemy then
		unit.kos = (value and 1 or nil)
	end	
end

-- set unit pvp flag to current time. 
function SpyData:LogPvp(unit)
    assert(unit, "Invalid unit (" .. tostring(unit) .. ")")
    assert(unit.type, "Invalid unit type (" .. tostring(unit.type) .. ")")
    Spy_db.session.players[unit].pvp = time()
end

-- set attack time - kills within 60 seconds are credited as a win
function SpyData:LogOutgoingPvp(unit)  --??
    assert(unit, "Invalid unit (" .. tostring(unit) .. ")")
    assert(unit.type, "Invalid unit type (" .. tostring(unit.type) .. ")")
    Spy_db.pvp.outgoing[unit] = time()
end

-- set hostile attack time - death within 60 seconds are credited as a win
function SpyData:LogIncomingPvp(unit)  --??
    assert(unit, "Invalid unit (" .. tostring(unit) .. ")")
    assert(unit.type, "Invalid unit type (" .. tostring(unit.type) .. ")")
    Spy_db.pvp.incoming[unit] = time()
end

-- add win to hostile win counter
function SpyData:LogHostilePvpDeath(unit, session) --??
    assert(unit, "Invalid unit (" .. tostring(unit) .. ")")
    assert(unit.type, "Invalid unit type (" .. tostring(unit.type) .. ")")

    local now = time()

    -- save time of death to ignore dots events that may occur after death
    session.dead = now

    -- add to win count if final attack was within 60 seconds
    if Spy_db.pvp.outgoing[unit] and (Spy_db.pvp.outgoing[unit] > (now - 60)) then	
        unit.wins = (unit.wins and (unit.wins + 1) or 1)
        Spy_db.pvp.outgoing[unit] = nil
        Spy_db.pvp.incoming[unit] = nil
    end
end

-- add loss to hostile death counters
function SpyData:LogMyPvpDeath()
    local now = time()

    -- all hostiles that attacked within 60 seconds are credited with a win
    for unit, time in pairs(Spy_db.pvp.incoming) do
        if time > (now - 60) then		
            unit.loses = (unit.loses and (unit.loses + 1) or 1)			
            Spy_db.pvp.outgoing[unit] = nil
            Spy_db.pvp.incoming[unit] = nil
        end
    end
end

-- removes entries from the incoming and outgoing pvp lists if older than 60 seconds
function SpyData:PurgePvpTimers()
    local now = time()

    -- clean up other expired timers
    for unit, time in pairs(Spy_db.pvp.incoming) do
        if time < (now - 60) then		
            Spy_db.pvp.incoming[unit] = nil
        end
    end

    for unit, time in pairs(Spy_db.pvp.outgoing) do
        if time < (now - 60) then
            Spy_db.pvp.outgoing[unit] = nil
        end
    end
end

do -- SpyData:SortPlayersByTime()
    local function sorter(a, b)
        return a.time > b.time
    end

    function SpyData:SortPlayersByTime()
        local cache = cache.players.time.data		
        local i = 1

        for _, unit in pairs(SpyPerCharDB.PlayerData) do		
            cache[i] = unit
            i = i + 1
        end

        for j = i, #cache do cache[j] = nil end
        table.sort(cache, sorter)
    end
end

do -- SpyData:GetPlayers() - Iterators
    local sorters = {
        ["name"] = function (a, b) return (a.name and a.name or "") < (b.name and b.name or "") end,
        ["level"] = function (a, b) return (a.level and (a.level > 0 and a.level or 255) or 0) > (b.level and (b.level > 0 and b.level or 255) or 0) end,
        ["class"] = function (a, b) return (a.class and a.class or "zzzzzz") < (b.class and b.class or "zzzzzz") end,		
        ["guild"] = function (a, b) return (a.guild and a.guild or "zzzzzz") < (b.guild and b.guild or "zzzzzz") end,
        ["wins"] = function (a, b) return (a.wins and a.wins or 0) > (b.wins and b.wins or 0) end,
        ["loses"] = function (a, b) return (a.loses and a.loses or 0) > (b.loses and b.loses or 0) end,
        ["time"] = function (a, b) return (a.time and a.time or 0) > (b.time and b.time or 0) end,		
    }

    local function sort(sortBy)
        local cache = cache.players[sortBy].data		
        local i = 1
        for _, unit in pairs(SpyPerCharDB.PlayerData) do		
            cache[i] = unit
            i = i + 1
        end

        for j = i, #cache do cache[j] = nil end
        table.sort(cache, sorters[sortBy])
    end

    local function iterator(data, index)
        index = index + 1
        if data[index] then
            return index, data[index], Spy_db.session.players[data[index]]
        else
            return
        end
    end

    function SpyData:GetPlayers(sortBy)
        if not sortBy then sortBy = "time" end		
        sort(sortBy)
        return iterator, cache.players[sortBy].data, 0		
    end
end