local select, string_gsub, tostring, pairs, ipairs = select, string.gsub, tostring, pairs, ipairs
local wipe = wipe
local unpack = unpack

local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local AURA_TYPE_DEBUFF = AURA_TYPE_DEBUFF
local AURA_TYPE_BUFF = AURA_TYPE_BUFF

local UnitName, UnitAura, UnitRace, UnitClass, UnitGUID, UnitIsUnit, UnitExists = UnitName, UnitAura, UnitRace, UnitClass, UnitGUID, UnitIsUnit, UnitExists
local UnitCastingInfo, UnitChannelInfo = UnitCastingInfo, UnitChannelInfo
local GetSpellInfo = GetSpellInfo
local FindAuraByName = AuraUtil.FindAuraByName
local GetTime = GetTime

local Gladdy = LibStub("Gladdy")
local L = Gladdy.L
local Cooldowns = Gladdy.modules["Cooldowns"]
local Diminishings = Gladdy.modules["Diminishings"]

local EventListener = Gladdy:NewModule("EventListener", 101, {
    test = true,
})

function EventListener:Initialize()
    self:RegisterMessage("JOINED_ARENA")
end

function EventListener.OnEvent(self, event, ...)
    EventListener[event](self, ...)
end

function EventListener:JOINED_ARENA()
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("ARENA_OPPONENT_UPDATE")
    self:RegisterEvent("UNIT_AURA")
    self:RegisterEvent("UNIT_SPELLCAST_START")
    self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    -- in case arena has started already we check for units
    for i=1,Gladdy.curBracket do
        if Gladdy.buttons["arena"..i].lastAuras then
            wipe(Gladdy.buttons["arena"..i].lastAuras)
        end
        if UnitExists("arena" .. i) then
            Gladdy:SpotEnemy("arena" .. i, true)
        end
        if UnitExists("arenapet" .. i) then
            Gladdy:SendMessage("PET_SPOTTED", "arenapet" .. i)
        end
    end
    self:SetScript("OnEvent", EventListener.OnEvent)
end

function EventListener:Reset()
    self:UnregisterAllEvents()
    self:SetScript("OnEvent", nil)
end

function Gladdy:SpotEnemy(unit, auraScan)
    local button = self.buttons[unit]
    if not unit or not button then
        return
    end
    if UnitExists(unit) then
        button.raceLoc = UnitRace(unit)
        button.race = select(2, UnitRace(unit))
        button.classLoc = select(1, UnitClass(unit))
        button.class = select(2, UnitClass(unit))
        button.name = UnitName(unit)
        Gladdy.guids[UnitGUID(unit)] = unit
    end
    if button.class and button.race then
        Gladdy:SendMessage("ENEMY_SPOTTED", unit)
    end
    if auraScan and not button.spec then
        Gladdy:SendMessage("AURA_FADE", unit, "HELPFUL")
        for n = 1, 30 do
            local spellName, texture, count, dispelType, duration, expirationTime, unitCaster, _, _, spellID = UnitAura(unit, n, "HELPFUL")
            if ( not spellName ) then
                Gladdy:SendMessage("AURA_GAIN_LIMIT", unit, AURA_TYPE_BUFF, n - 1)
                break
            end

            if Gladdy.exceptionNames[spellID] then
                spellName = Gladdy.exceptionNames[spellID]
            end

            if Gladdy.specBuffs[spellName] and unitCaster then -- Check for auras that detect a spec
                local unitPet = string_gsub(unit, "%d$", "pet%1")
                if UnitIsUnit(unit, unitCaster) or UnitIsUnit(unitPet, unitCaster) then
                    EventListener:DetectSpec(unit, Gladdy.specBuffs[spellName])
                end
            end
            if Gladdy.cooldownBuffs[spellName] and unitCaster then -- Check for auras that detect used CDs (like Fear Ward)
                for arenaUnit,v in pairs(self.buttons) do
                    if (UnitIsUnit(arenaUnit, unitCaster)) then
                        Cooldowns:CooldownUsed(arenaUnit, v.class, Gladdy.cooldownBuffs[spellName].spellId, Gladdy.cooldownBuffs[spellName].cd(expirationTime - GetTime()))
                        -- /run LibStub("Gladdy").modules["Cooldowns"]:CooldownUsed("arena5", "PRIEST", 6346, 10)
                    end
                end
            end
            if Gladdy.cooldownBuffs.racials[spellName] and Gladdy.cooldownBuffs.racials[spellName] then
                Gladdy:SendMessage("RACIAL_USED", unit, spellName, Gladdy.cooldownBuffs.racials[spellName].cd(expirationTime - GetTime()), spellName)
            end
            Gladdy:SendMessage("AURA_GAIN", unit, AURA_TYPE_BUFF, spellID, spellName, texture, duration, expirationTime, count, dispelType, n, unitCaster)
        end
    end
end

function EventListener:COMBAT_LOG_EVENT_UNFILTERED()
    -- timestamp,eventType,hideCaster,sourceGUID,sourceName,sourceFlags,sourceRaidFlags,destGUID,destName,destFlags,destRaidFlags,spellId,spellName,spellSchool
    local _,eventType,_,sourceGUID,_,_,_,destGUID,_,_,_,spellID,spellName,spellSchool,extraSpellId,extraSpellName,extraSpellSchool = CombatLogGetCurrentEventInfo()
    local srcUnit = Gladdy.guids[sourceGUID] -- can be a PET
    local destUnit = Gladdy.guids[destGUID] -- can be a PET
    if (Gladdy.db.shadowsightTimerEnabled and eventType == "SPELL_AURA_APPLIED" and spellID == 34709) then
        Gladdy.modules["Shadowsight Timer"]:AURA_GAIN(nil, nil, 34709)
    end

    if Gladdy.exceptionNames[spellID] then
        spellName = Gladdy.exceptionNames[spellID]
    end
    if destUnit then
        -- diminish tracker
        if Gladdy.buttons[destUnit] and Gladdy.db.drEnabled and extraSpellId == AURA_TYPE_DEBUFF then
            if (eventType == "SPELL_AURA_REMOVED") then
                Diminishings:AuraFade(destUnit, spellID)
            end
            if (eventType == "SPELL_AURA_REFRESH") then
                Diminishings:AuraGain(destUnit, spellID)
                --Diminishings:AuraFade(destUnit, spellID)
            end
            if (eventType == "SPELL_AURA_APPLIED") then
                Diminishings:AuraGain(destUnit, spellID)
            end
        end
        -- death detection
        if (eventType == "UNIT_DIED" or eventType == "PARTY_KILL" or eventType == "SPELL_INSTAKILL") then
            if not Gladdy:isFeignDeath(destUnit) then
                Gladdy:SendMessage("UNIT_DEATH", destUnit)
            end
        end
        -- spec detection
        if Gladdy.buttons[destUnit] and (not Gladdy.buttons[destUnit].class or not Gladdy.buttons[destUnit].race) then
            Gladdy:SpotEnemy(destUnit, true)
        end
        --interrupt detection
        if Gladdy.buttons[destUnit] and eventType == "SPELL_INTERRUPT" then
            Gladdy:SendMessage("SPELL_INTERRUPT", destUnit,spellID,spellName,spellSchool,extraSpellId,extraSpellName,extraSpellSchool)
        end
    end
    if srcUnit then
        srcUnit = string_gsub(srcUnit, "pet", "")
        if (not UnitExists(srcUnit)) then
            return
        end
        if not Gladdy.buttons[srcUnit].class or not Gladdy.buttons[srcUnit].race then
            Gladdy:SpotEnemy(srcUnit, true)
        end
        if not Gladdy.buttons[srcUnit].spec then
            self:DetectSpec(srcUnit, Gladdy.specSpells[spellName])
        end
        if (eventType == "SPELL_CAST_SUCCESS" or eventType == "SPELL_MISSED") then
            -- cooldown tracker
            if Gladdy.db.cooldown and Cooldowns.cooldownSpellIds[spellName] then
                local unitClass
                local spellId = Cooldowns.cooldownSpellIds[spellName] -- don't use spellId from combatlog, in case of different spellrank
                if spellID == 16188 or spellID == 17116 then -- Nature's Swiftness (same name for druid and shaman)
                    spellId = spellID
                end
                if Gladdy.db.cooldownCooldowns[tostring(spellId)] and (eventType == "SPELL_CAST_SUCCESS" or eventType == "SPELL_MISSED" or eventType == "SPELL_DODGED") then
                    if (Gladdy:GetCooldownList()[Gladdy.buttons[srcUnit].class][spellId]) then
                        unitClass = Gladdy.buttons[srcUnit].class
                    else
                        unitClass = Gladdy.buttons[srcUnit].race
                    end
                    if spellID ~= 16188 and spellID ~= 17116 and spellID ~= 16166 and spellID ~= 12043 and spellID ~= 5384 then -- Nature's Swiftness CD starts when buff fades
                        Gladdy:Debug("INFO", eventType, "- CooldownUsed", srcUnit, "spellID:", spellID)
                        Cooldowns:CooldownUsed(srcUnit, unitClass, spellId)
                    end
                end
            end
        end
        if (eventType == "SPELL_AURA_REMOVED" and (spellID == 16188 or spellID == 17116 or spellID == 16166 or spellID == 12043) and Gladdy.buttons[srcUnit].class) then
            Gladdy:Debug("INFO", "SPELL_AURA_REMOVED - CooldownUsed", srcUnit, "spellID:", spellID)
            Cooldowns:CooldownUsed(srcUnit, Gladdy.buttons[srcUnit].class, spellID)
        end
        if (eventType == "SPELL_AURA_REMOVED" and Gladdy.db.cooldown and Cooldowns.cooldownSpellIds[spellName]) then
            local unit = Gladdy:GetArenaUnit(srcUnit, true)
            local spellId = Cooldowns.cooldownSpellIds[spellName] -- don't use spellId from combatlog, in case of different spellrank
            if spellID == 16188 or spellID == 17116 then -- Nature's Swiftness (same name for druid and shaman)
                spellId = spellID
            end
            if unit then
                --Gladdy:Debug("INFO", "EL:CL:SPELL_AURA_REMOVED (srcUnit)", "Cooldowns:AURA_FADE", unit, spellId)
                Cooldowns:AURA_FADE(unit, spellId)
            end
        end
    end
end

function EventListener:ARENA_OPPONENT_UPDATE(unit, updateReason)
    --[[ updateReason: seen, unseen, destroyed, cleared ]]

    unit = Gladdy:GetArenaUnit(unit)
    local button = Gladdy.buttons[unit]
    local pet = Gladdy.modules["Pets"].frames[unit]
    Gladdy:Debug("INFO", "ARENA_OPPONENT_UPDATE", unit, updateReason)
    if button or pet then
        if updateReason == "seen" then
            -- ENEMY_SPOTTED
            if button then
                button.stealthed = false
                Gladdy:SendMessage("ENEMY_STEALTH", unit, false)
                if not button.class or not button.race then
                    Gladdy:SpotEnemy(unit, true)
                end
            end
            if pet then
                Gladdy:SendMessage("PET_SPOTTED", unit)
            end
        elseif updateReason == "unseen" then
            -- STEALTH
            if button then
                button.stealthed = true
                Gladdy:SendMessage("ENEMY_STEALTH", unit, true)
            end
            if pet then
                Gladdy:SendMessage("PET_STEALTH", unit)
            end
        elseif updateReason == "destroyed" then
            -- LEAVE
            if button then
                Gladdy:SendMessage("UNIT_DESTROYED", unit)
            end
            if pet then
                Gladdy:SendMessage("PET_DESTROYED", unit)
            end
        elseif updateReason == "cleared" then
            --Gladdy:Print("ARENA_OPPONENT_UPDATE", updateReason, unit)
        end
    end
end

Gladdy.cooldownBuffs = {
    [GetSpellInfo(6346)] = { cd = function(expTime) -- 180s uptime == cd
        return expTime
    end, spellId = 6346 }, -- Fear Ward
    [GetSpellInfo(11305)] = { cd = function(expTime) -- 15s uptime
        return 300 - (15 - expTime)
    end, spellId = 11305 }, -- Sprint
    [36554] = { cd = function(expTime) -- 3s uptime
        return 30 - (3 - expTime)
    end, spellId = 36554 }, -- Shadowstep speed buff
    [36563] = { cd = function(expTime) -- 10s uptime
        return 30 - (10 - expTime)
    end, spellId = 36554 }, -- Shadowstep dmg buff
    [GetSpellInfo(26889)] = { cd = function(expTime) -- 3s uptime
        return 180 - (10 - expTime)
    end, spellId = 26889 }, -- Vanish
    racials = {
        [GetSpellInfo(20600)] = { cd = function(expTime) -- 20s uptime
            return GetTime() - (20 - expTime)
        end, spellId = 20600 }, -- Perception
    }
}
--[[
/run local f,sn,dt for i=1,2 do f=(i==1 and "HELPFUL"or"HARMFUL")for n=1,30 do sn,_,_,dt=UnitAura("player",n,f) if(not sn)then break end print(sn,dt,dt and dt:len())end end
--]]
function EventListener:UNIT_AURA(unit, isFullUpdate, updatedAuras)
    local button = Gladdy.buttons[unit]
    if not button then
        return
    end
    if not button.auras then
        button.auras = {}
    end
    wipe(button.auras)
    if not button.lastAuras then
        button.lastAuras = {}
    end
    Gladdy:Debug("INFO", "AURA_FADE", unit, AURA_TYPE_BUFF, AURA_TYPE_DEBUFF)
    Gladdy:SendMessage("AURA_FADE", unit, AURA_TYPE_BUFF)
    Gladdy:SendMessage("AURA_FADE", unit, AURA_TYPE_DEBUFF)
    for i = 1, 2 do
        if not Gladdy.buttons[unit].class or not Gladdy.buttons[unit].race then
            Gladdy:SpotEnemy(unit, false)
        end
        local filter = (i == 1 and "HELPFUL" or "HARMFUL")
        local auraType = i == 1 and AURA_TYPE_BUFF or AURA_TYPE_DEBUFF
        for n = 1, 30 do
            local spellName, texture, count, dispelType, duration, expirationTime, unitCaster, _, shouldConsolidate, spellID = UnitAura(unit, n, filter)
            if ( not spellID ) then
                Gladdy:SendMessage("AURA_GAIN_LIMIT", unit, auraType, n - 1)
                break
            end
            if Gladdy.exceptionNames[spellID] then
                spellName = Gladdy.exceptionNames[spellID]
            end
            button.auras[spellID] = { auraType, spellID, spellName, texture, duration, expirationTime, count, dispelType }
            if not button.spec and Gladdy.specBuffs[spellName] and unitCaster then
                local unitPet = string_gsub(unit, "%d$", "pet%1")
                if unitCaster and (UnitIsUnit(unit, unitCaster) or UnitIsUnit(unitPet, unitCaster)) then
                    self:DetectSpec(unit, Gladdy.specBuffs[spellName])
                end
            end
            if (Gladdy.cooldownBuffs[spellName] or Gladdy.cooldownBuffs[spellID]) and unitCaster then -- Check for auras that hint used CDs (like Fear Ward)
                local cooldownBuff = Gladdy.cooldownBuffs[spellID] or Gladdy.cooldownBuffs[spellName]
                for arenaUnit,v in pairs(Gladdy.buttons) do
                    if (UnitIsUnit(arenaUnit, unitCaster)) then
                        Cooldowns:CooldownUsed(arenaUnit, v.class, cooldownBuff.spellId, cooldownBuff.cd(expirationTime - GetTime()))
                    end
                end
            end
            if Gladdy.cooldownBuffs.racials[spellName] then
                Gladdy:SendMessage("RACIAL_USED", unit, spellName, Gladdy.cooldownBuffs.racials[spellName].cd(expirationTime - GetTime()), spellName)
            end
            Gladdy:Debug("INFO", "AURA_GAIN", unit, auraType, spellName)
            Gladdy:SendMessage("AURA_GAIN", unit, auraType, spellID, spellName, texture, duration, expirationTime, count, dispelType, i, unitCaster)
        end
    end
    -- check auras
    for spellID,v in pairs(button.lastAuras) do
        if not button.auras[spellID] then
            if Gladdy.db.cooldown and Cooldowns.cooldownSpellIds[v[3]] then
                local spellId = Cooldowns.cooldownSpellIds[v[3]] -- don't use spellId from combatlog, in case of different spellrank
                if spellID == 16188 or spellID == 17116 then -- Nature's Swiftness (same name for druid and shaman)
                    spellId = spellID
                end
                --Gladdy:Debug("INFO", "EL:UNIT_AURA Cooldowns:AURA_FADE", unit, spellId)
                Cooldowns:AURA_FADE(unit, spellId)
                if spellID == 5384 then -- Feign Death CD Detection needs this
                    Cooldowns:CooldownUsed(unit, Gladdy.buttons[unit].class, 5384)
                end
            end
        end
    end
    wipe(button.lastAuras)
    button.lastAuras = Gladdy:DeepCopy(button.auras)
end

function EventListener:UpdateAuras(unit)
    local button = Gladdy.buttons[unit]
    if not button or button.lastAuras then
        return
    end
    for i=1, #button.lastAuras do
        Gladdy.modules["Auras"]:AURA_GAIN(unit, unpack(button.lastAuras[i]))
    end
end

function EventListener:UNIT_SPELLCAST_START(unit)
    if Gladdy.buttons[unit] then
        local spellName = UnitCastingInfo(unit)
        if Gladdy.specSpells[spellName] and not Gladdy.buttons[unit].spec then
            self:DetectSpec(unit, Gladdy.specSpells[spellName])
        end
    end
end

function EventListener:UNIT_SPELLCAST_CHANNEL_START(unit)
    if Gladdy.buttons[unit] then
        local spellName = UnitChannelInfo(unit)
        if Gladdy.specSpells[spellName] and not Gladdy.buttons[unit].spec then
            self:DetectSpec(unit, Gladdy.specSpells[spellName])
        end
    end
end

function EventListener:UNIT_SPELLCAST_SUCCEEDED(...)
    local unit, castGUID, spellID = ...
    unit = Gladdy:GetArenaUnit(unit, true)
    if Gladdy.buttons[unit] then
        local unitRace = Gladdy.buttons[unit].race
        local spellName = GetSpellInfo(spellID)

        if Gladdy.exceptionNames[spellID] then
            spellName = Gladdy.exceptionNames[spellID]
        end

        -- spec detection
        if spellName and  Gladdy.specSpells[spellName] and not Gladdy.buttons[unit].spec then
            self:DetectSpec(unit, Gladdy.specSpells[spellName])
        end

        -- trinket
        if spellID == 42292 or spellID == 59752 then
            Gladdy:Debug("INFO", "UNIT_SPELLCAST_SUCCEEDED - TRINKET_USED", unit, spellID)
            Gladdy:SendMessage("TRINKET_USED", unit)
        end

        -- racial
        if unitRace and  Gladdy:Racials()[unitRace].spellName == spellName and Gladdy:Racials()[unitRace][spellID] then
            Gladdy:Debug("INFO", "UNIT_SPELLCAST_SUCCEEDED - RACIAL_USED", unit, spellID)
            Gladdy:SendMessage("RACIAL_USED", unit)
        end

        --cooldown
        local unitClass
        if (Gladdy:GetCooldownList()[Gladdy.buttons[unit].class][unit]) then
            unitClass = Gladdy.buttons[unit].class
        else
            unitClass = Gladdy.buttons[unit].race
        end
        if spellID ~= 16188 and spellID ~= 17116 and spellID ~= 16166 and spellID ~= 12043 and spellID ~= 5384 then -- Nature's Swiftness CD starts when buff fades
            Gladdy:Debug("INFO", "UNIT_SPELLCAST_SUCCEEDED", "- CooldownUsed", unit, "spellID:", spellID)
            Cooldowns:CooldownUsed(unit, unitClass, spellID)
        end
    end
end

function EventListener:DetectSpec(unit, spec)
    local button = Gladdy.buttons[unit]
    if (not button or not spec or button.spec) then
        return
    end
    if button.class == "PALADIN" and not Gladdy:contains(spec, {L["Holy"], L["Retribution"], L["Protection"]})
            or button.class == "SHAMAN" and not Gladdy:contains(spec, {L["Restoration"], L["Enhancement"], L["Elemental"]})
            or button.class == "ROGUE" and not Gladdy:contains(spec, {L["Subtlety"], L["Assassination"], L["Combat"]})
            or button.class == "WARLOCK" and not Gladdy:contains(spec, {L["Demonology"], L["Destruction"], L["Affliction"]})
            or button.class == "PRIEST" and not Gladdy:contains(spec, {L["Shadow"], L["Discipline"], L["Holy"]})
            or button.class == "MAGE" and not Gladdy:contains(spec, {L["Frost"], L["Fire"], L["Arcane"]})
            or button.class == "DRUID" and not Gladdy:contains(spec, {L["Restoration"], L["Feral"], L["Balance"]})
            or button.class == "HUNTER" and not Gladdy:contains(spec, {L["Beast Mastery"], L["Marksmanship"], L["Survival"]})
            or button.class == "WARRIOR" and not Gladdy:contains(spec, {L["Arms"], L["Protection"], L["Fury"]})
            or button.class == "DEATHKNIGHT" and not Gladdy:contains(spec, {L["Unholy"], L["Blood"], L["Frost"]}) then
        return
    end
    if not button.spec then
        button.spec = spec
        Gladdy:SendMessage("UNIT_SPEC", unit, spec)
    end
end

function EventListener:Test(unit)
    local button = Gladdy.buttons[unit]
    if (button and Gladdy.testData[unit].testSpec) then
        button.spec = nil
        Gladdy:SpotEnemy(unit, false)
        self:DetectSpec(unit, button.testSpec)
    end
end
