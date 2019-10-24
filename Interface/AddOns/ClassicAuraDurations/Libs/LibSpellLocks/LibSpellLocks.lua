--[================[
LibSpellLocks-1.0
Author: d87
Description: Provides information about spell lock status after successful interrupts
--]================]
if WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC then return end

local MAJOR, MINOR = "LibSpellLocks", 3
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end


lib.callbacks = lib.callbacks or LibStub("CallbackHandler-1.0"):New(lib)
lib.frame = lib.frame or CreateFrame("Frame")
lib.activeSpellLocks = lib.activeSpellLocks or setmetatable({}, { __mode = "k" })
lib.interrupts = lib.interrupts or  {}

local f = lib.frame
local callbacks = lib.callbacks
local interrupts = lib.interrupts
local activeSpellLocks = lib.activeSpellLocks
local data = interrupts
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local UnitGUID = UnitGUID
local UnitAura = UnitAura
local GetTime = GetTime
local C_Timer_After = C_Timer.After

f:SetScript("OnEvent", function(self, event, ...)
    return self[event](self, event, ...)
end)

local function Interrupt( id, name, duration )
    local opts = { duration = duration }
    if type(id) == "table" then
        for i, spellID in ipairs(id) do
            data[spellID] = opts
        end
        if #id > 2 then
            opts.originalID = id[1]
        end
    else
        data[id] = opts
    end
end


-------------------
-- CLASSIC
-------------------
-- Interrupt(19244, "Spell Lock", 6) -- Rank 1
Interrupt(19647, "Spell Lock", 8) -- Rank 2
Interrupt({ 8042, 8044, 8045, 8046, 10412, 10413, 10414 }, "Earth Shock", 2)
Interrupt(16979, "Feral Charge", 4)
Interrupt(2139, "Counterspell", 10)
Interrupt({ 1766, 1767, 1768, 1769 }, "Kick", 5)
Interrupt({ 6552, 6554 }, "Pummel", 4)
Interrupt({ 72, 1671, 1672 }, "Shield Bash", 6)

local spellNameToID = {
    [GetSpellInfo(19647)] = 19647,
    [GetSpellInfo(10414)] = 10414,
    [GetSpellInfo(16979)] = 16979,
    [GetSpellInfo(2139)] = 2139,
    [GetSpellInfo(1769)] = 1769,
    [GetSpellInfo(6554)] = 6554,
    [GetSpellInfo(1672)] = 1672,
}



-- local commonUnits = {
-- 	"player",
-- 	"target",
-- 	"focus",
-- 	"party1",
-- 	"party2",
-- 	"party3",
-- 	"party4",
-- 	"arena1",
-- 	"arena2",
-- 	"arena3",
-- 	"arena4",
-- 	"arena5",
-- }

-- local function maybeFindUnitByGUID(guid)
--     for i, unit in ipairs(commonUnits) do
--         if UnitGUID(unit) == guid then
--             return unit
--         end
--     end
-- end


-- local function FindAurByaSpellID(spellID, unit, filter)
--     for i=1, 100 do
--         local auraSpellID = select(10, UnitAura(unit, i, filter))
--         if not auraSpellID then return end
--         if auraSpellID == spellID then return i end
--     end
-- end

function f:COMBAT_LOG_EVENT_UNFILTERED(event)

    local timestamp, eventType, hideCaster,
    srcGUID, srcName, srcFlags, srcFlags2,
    dstGUID, dstName, dstFlags, dstFlags2,
    spellID, spellName, arg3, arg4, arg5 = CombatLogGetCurrentEventInfo()

    if eventType == "SPELL_INTERRUPT" then

        if spellID == 0 then
            spellID = spellNameToID[spellName]
        end

        local spellData = interrupts[spellID]
        if not spellData then return end
        -- if spellData.originalID then spellID = spellData.originalID end
        local duration = spellData.duration

        -- local unit = maybeFindUnitByGUID(dstGUID)
        -- if unit then
        -- end
        local oldData = activeSpellLocks[dstGUID]
        if oldData then
            local oldExpTime = oldData[3]
            local newExpTime = GetTime()+duration
            if newExpTime > oldExpTime then
                oldData[1] = spellID
                oldData[2] = duration
                oldData[3] = newExpTime
            end
        else
            activeSpellLocks[dstGUID] = { spellID, duration, GetTime()+duration }
        end

        callbacks:Fire("UPDATE_INTERRUPT", dstGUID, spellID)

        C_Timer_After(duration, function()
            callbacks:Fire("UPDATE_INTERRUPT", dstGUID, spellID)
        end)
    end
end

function lib:GetSpellLockInfo(unit)
    local guid = UnitGUID(unit)
    if activeSpellLocks[guid] then
        local spellID, duration, expirationTime = unpack(activeSpellLocks[guid])
        if GetTime() > expirationTime then return nil end
        local name, _, icon = GetSpellInfo(spellID)
        return spellID, name, icon, duration, expirationTime
    end
end

function callbacks.OnUsed()
    f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

function callbacks.OnUnused()
    f:UnregisterAllEvents()
end