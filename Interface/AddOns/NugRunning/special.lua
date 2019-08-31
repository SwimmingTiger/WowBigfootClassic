local _, helpers = ...

local NugRunning = NugRunning
local class = select(2,UnitClass("player"))


local active = NugRunning.active
local free = NugRunning.free
local gettimer = NugRunning.gettimer
local UnitGUID = UnitGUID
local bit_band = bit.band
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local AFFILIATION_MINE = COMBATLOG_OBJECT_AFFILIATION_MINE

local function Overpower()

    local INVSLOT_OFFHAND = INVSLOT_OFFHAND
    local function IsShieldEquipped()
        local itemLink = GetInventoryItemLink("player", INVSLOT_OFFHAND)
        if itemLink then
            local _, _, _, itemEquipLoc = GetItemInfoInstant(itemLink)
            return itemEquipLoc == "INVTYPE_SHIELD"
        end
    end

    local LocalizedOverpower = GetSpellInfo(7384)
    local LocalizedRevenge = GetSpellInfo(6572)

    local IsInBattleStance = function() return GetShapeshiftForm() == 1 end
    local IsInDefensiveStance = function() return GetShapeshiftForm() == 2 end

    local function OnOverpowerActivate()
        if UnitLevel("player") < 12 then return end
        if not IsShieldEquipped() or IsInBattleStance() then
            local spellID = 7384
            local playerGUID = UnitGUID("player")
            local timer = gettimer(active,spellID, playerGUID, "COOLDOWN")
            if timer and not timer.isGhost then
                timer.scheduledGhost = 5
            end
            NugRunning:SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(nil, 7384)
        end
    end

    local function OnOverpowerSpent()
        NugRunning:SPELL_ACTIVATION_OVERLAY_GLOW_HIDE(nil, 7384)
    end

    local function OnRevengeActivate()
        if UnitLevel("player") < 14 then return end
        if IsInDefensiveStance() then
            local spellID = 6572
            local playerGUID = UnitGUID("player")
            local timer = gettimer(active,spellID, playerGUID, "COOLDOWN")
            if timer and not timer.isGhost then
                timer.scheduledGhost = 5
            end
            NugRunning:SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(nil, 6572)
        end
    end

    local function OnRevengeSpent()
        NugRunning:SPELL_ACTIVATION_OVERLAY_GLOW_HIDE(nil, 6572)
    end

    local f = CreateFrame("Frame", nil)
    f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    f:SetScript("OnEvent", function(self, event)
        local timestamp, eventType, hideCaster,
        srcGUID, srcName, srcFlags, srcFlags2,
        dstGUID, dstName, dstFlags, dstFlags2,
        arg1, arg2, arg3, arg4, arg5 = CombatLogGetCurrentEventInfo()

        if (bit_band(srcFlags, AFFILIATION_MINE) == AFFILIATION_MINE) then
            if eventType == "SWING_MISSED" or eventType == "SPELL_MISSED" then
                local missedType
                if eventType == "SWING_MISSED" then
                    missedType = arg1
                elseif eventType == "SPELL_MISSED" then
                    missedType = arg4
                end
                if missedType == "DODGE" then
                    -- print("----------------->DODGED", eventType, "from", srcName, bit_band(srcFlags, AFFILIATION_MINE) == AFFILIATION_MINE)
                    OnOverpowerActivate()
                end

            end

            if eventType == "SPELL_CAST_SUCCESS" then
                local spellName = arg2
                if spellName == LocalizedOverpower then
                    OnOverpowerSpent()
                end

                if spellName == LocalizedRevenge then
                    OnRevengeSpent()
                end
            end
        end


        if dstGUID == UnitGUID("player") then
            if eventType == "SWING_MISSED" or eventType == "SPELL_MISSED" then
                local missedType
                if eventType == "SWING_MISSED" then
                    missedType = arg1
                elseif eventType == "SPELL_MISSED" then
                    missedType = arg4
                end
                if missedType == "BLOCK" or missedType == "DODGE" or missedType == "PARRY" then
                    OnRevengeActivate()
                end
            end
            if eventType == "SWING_DAMAGE" then
                local blocked = arg5
                if blocked then
                    OnRevengeActivate()
                end
            end
        end
    end)
end

function NugRunning.SetupSpecialTimers()
    if class  == "WARRIOR" then
        Overpower()
    end
end
