--[================[
LibSpellLocks-1.0
Author: d87
Description: Provides information about spell lock status after successful interrupts
--]================]


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

local isClassic = select(4,GetBuildInfo()) <= 19999

if not isClassic then
    -------------------
    -- LIVE
    -------------------
    Interrupt(212619, "Call Felhunter", 6) -- pvp talent
    Interrupt(119910, "Spell Lock", 6) -- Felhunter spell from action bar
    Interrupt(19647, "Spell Lock", 6) -- Felhunter spell from pet bar
    Interrupt(132409, "Spell Lock", 6) -- Command Demon after sacrificing Felhunter
    Interrupt(1766, "Kick", 5)
    Interrupt(6552, "Pummel", 4)
    Interrupt(116705, "Spear Hand Strike", 4)
    Interrupt(47528, "Mind Freeze", 3)
    Interrupt(2139, "Counterspell", 6)
    Interrupt(96231, "Rebuke", 4)
    Interrupt(106839, "Skull Bash", 4)
    Interrupt(183752, "Disrupt", 3)
    Interrupt(187707, "Muzzle", 3)
    Interrupt(147362, "Counter Shot", 3)
    Interrupt(57994, "Wind Shear", 3)

    -- PVE
    Interrupt(240448, "QuakingAffix", 5)
    Interrupt(257732, "Shattering Bellow", 5) -- Freehold
    Interrupt(266106, "Sonic Screech", 5) -- Underrot, Feral Bloodswarmer
    Interrupt(267257, "Thundering Crash", 4) -- King's Rest
    Interrupt(296084, "Mind Fracture", 1.5) -- Za'qul, The Eternal Palace

    -- Interrupt(288917, "Deafening Screech", 5) -- Screeching Phantasm, Battle of Dazar'Alor
    -- Interrupt(146367, "Rumbling Stomp", 3) -- Char'golm, Battle of Dazar'Alor
    -- Interrupt(263307, "Mind-Numbing Chatter", 5) -- Uldir



    -- Trial of Crusader Champions
    -- Interrupt(65973, "Earth Shock", 3)
else
    -------------------
    -- CLASSIC
    -------------------
    Interrupt(19244, "Spell Lock", 6) -- Rank 1
    Interrupt(19647, "Spell Lock", 8) -- Rank 2
    Interrupt({ 8042, 8044, 8045, 8046, 10412, 10413, 10414 }, "Earth Shock", 2)
    Interrupt(16979, "Feral Charge", 4)
    Interrupt(2139, "Counterspell", 10)
    Interrupt({ 1766, 1767, 1768, 1769 }, "Kick", 5)
    Interrupt({ 6552, 6554 }, "Pummel", 4)
    Interrupt({ 72, 1671, 1672 }, "Shield Bash", 6)
end



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
    spellID, arg2, arg3, arg4, arg5 = CombatLogGetCurrentEventInfo()

    if eventType == "SPELL_INTERRUPT" then
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