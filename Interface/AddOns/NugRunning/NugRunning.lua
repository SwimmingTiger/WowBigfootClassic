local _, helpers = ...

NugRunning = CreateFrame("Frame","NugRunning")
local NugRunning = NugRunning

NugRunning:SetScript("OnEvent", function(self, event, ...)
    return self[event](self, event, ...)
end)

local L = setmetatable({}, {
    __index = function(t, k)
        -- print(string.format('L["%s"] = ""',k:gsub("\n","\\n")));
        return k
    end,
    __call = function(t,k) return t[k] end,
})
helpers.L = L
NugRunning.L = L

--- Compatibility with Classic
local isClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
local UnitSpellHaste = isClassic and function() return 0 end or _G.UnitSpellHaste
local GetSpecialization = isClassic and function() return nil end or _G.GetSpecialization

local NRunDB = nil
local config = NugRunningConfig
local spells = config.spells
local activations = config.activations
local cooldowns = config.cooldowns
local itemcooldowns = config.itemcooldowns
local event_timers = config.event_timers
local nameplates
local MAX_TIMERS = 20
local check_event_timers
local playerGUID
local alltimers = {}
local active = {}
local free = {}
local Scouter
setmetatable(active,{ __newindex = function(t,k,v)
    rawset(free,k,nil)
    rawset(t,k,v)
end})
setmetatable(free,{ __newindex = function(t,k,v)
    if k.opts then
        if k.opts.with_cooldown then
            local cd_opts = k.opts.with_cooldown
            config.cooldowns[cd_opts.id] = cd_opts
            NugRunning:SPELL_UPDATE_COOLDOWN()
        else
            if (k.opts.ghost or k.scheduledGhost) and not k.isGhost then return k:BecomeGhost() end
            if k.isGhost and not k.expiredGhost then return end
            k.isGhost = nil
            k.expiredGhost = nil
        end
    end
    k:Hide()
    rawset(active,k,nil)
    if not k.isExternal then
        rawset(t,k,v)
    end
    NugRunning:ArrangeTimers()
end})
local leaveGhost = true

local gettimer = function(self,spellID,dstGUID,timerType)
    local foundTimer
    local spellActiveTimers = 0
    if type(spellID) == "number" then
        for timer in pairs(self) do
            if timer.spellID == spellID and timer.timerType == timerType then
                spellActiveTimers = spellActiveTimers + 1
                if timer.dstGUID == dstGUID then
                    foundTimer = timer
                    break
                end
            end
        end
    elseif type(spellID) == "string" then
        for timer in pairs(self) do
            if timer.spellName == spellID and timer.timerType == timerType then
                spellActiveTimers = spellActiveTimers + 1
                if timer.dstGUID == dstGUID then
                    foundTimer = timer
                    break
                end
            end
        end
    else -- comparing by opts table, instead of
        for timer in pairs(self) do
            if timer.opts == spellID and timer.timerType == timerType then
                spellActiveTimers = spellActiveTimers + 1
                if timer.dstGUID == dstGUID then
                    foundTimer = timer
                    break
                end
            end
        end
    end
    return foundTimer, spellActiveTimers
end
local IsPlayerSpell = IsPlayerSpell
local GetSpellInfo = GetSpellInfo
local string_sub = string.sub
-- local GetSpellInfo_ = GetSpellInfo
-- local GetSpellInfo = setmetatable({},{
--     __call = function(self, id)
--     local info = self[id]
--     if not info then
--         info = { GetSpellInfo_(id) }
--         self[id] = info
--     end
--     return unpack(info)
--     end
-- })

local GetSpellCooldown = GetSpellCooldown
local GetSpellCharges = GetSpellCharges
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local bit_band = bit.band
local UnitAura = UnitAura
local UnitGUID = UnitGUID
local table_wipe = table.wipe
local CheckSpec = helpers.CheckSpec
local COMBATLOG_OBJECT_AFFILIATION_MASK = COMBATLOG_OBJECT_AFFILIATION_MASK
local AFFILIATION_MINE = COMBATLOG_OBJECT_AFFILIATION_MINE
local AFFILIATION_PARTY_OR_RAID = COMBATLOG_OBJECT_AFFILIATION_RAID + COMBATLOG_OBJECT_AFFILIATION_PARTY
local AFFILIATION_OUTSIDER = COMBATLOG_OBJECT_AFFILIATION_OUTSIDER
local COMBATLOG_HOSTILE_PLAYER = COMBATLOG_OBJECT_CONTROL_PLAYER + COMBATLOG_OBJECT_REACTION_HOSTILE

local lastCastSpellID

NugRunning.active = active
NugRunning.free = free
NugRunning.timers = alltimers
NugRunning.gettimer = gettimer
NugRunning.helpers = helpers

local defaultFont = "ClearFont"
local defaultShowLocalNames = false
do
    local locale = GetLocale()
    if locale == "zhTW" or locale == "zhCN" or locale == "koKR" then
        defaultFont = LibStub("LibSharedMedia-3.0").DefaultMedia["font"]
        defaultShowLocalNames = true
        -- "預設" - zhTW
        -- "默认" - zhCN
        -- "기본 글꼴" - koKR
    end
end

local defaults = {
    anchors = {
        main = {
            point = "CENTER",
            parent = "UIParent",
            to = "CENTER",
            x = 155,
            y = 99,
        },
        secondary = {
            point = "CENTER",
            parent = "UIParent",
            to = "CENTER",
            x = -200,
            y = 0,
        },
    },
    groups = {
        player = { order = 1, name = "player", gap = 10, alpha = 1, anchor = "main" },
        target = { order = 2, name = "target", gap = 10, alpha = 1, anchor = "main"},
        buffs = { order = 3, name = "buffs", gap = 25, alpha = 1, anchor = "main"},
        offtargets = { order = 4, name = "offtargets", gap = 6, alpha = .7, anchor = "main"},
        procs = { order = 1, name = "procs", gap = 10, alpha = .8, anchor = "secondary"},
    },
    growth = "up",
    width = 150,
    height = 15,
    np_height = 7,
    np_width = 74,
    np_xoffset = 0,
    np_yoffset = 7,
    cooldownsEnabled = true,
    missesEnabled = true,
    targetTextEnabled = false,
    spellTextEnabled = true,
    shortTextEnabled = true,
    swapTarget = true,
    localNames = defaultShowLocalNames,
    totems = true,
    leaveGhost = false,
    nameplates = false,
    preghost = true,
    dotpower = true,
    dotticks = true,
    textureName = "Aluminium",
    nptextureName = "Aluminium",
    nameFont = { font = defaultFont, size = 10, alpha = 0.5 },
    timeFont = { font = defaultFont, size = 8, alpha = 1 },
    stackFont = { font = defaultFont, size = 12 },
}

local function SetupDefaults(t, defaults)
    if not defaults then return end
    for k,v in pairs(defaults) do
        if type(v) == "table" then
            if t[k] == nil then
                t[k] = CopyTable(v)
            elseif t[k] == false then
                t[k] = false --pass
            else
                SetupDefaults(t[k], v)
            end
        else
            if t[k] == nil then t[k] = v end
            if t[k] == "__REMOVED__" then t[k] = nil end
        end
    end
end
NugRunning.SetupDefaults = SetupDefaults

local function RemoveDefaults(t, defaults)
    if not defaults then return end
    for k, v in pairs(defaults) do
        if type(t[k]) == 'table' and type(v) == 'table' then
            RemoveDefaults(t[k], v)
            if next(t[k]) == nil then
                t[k] = nil
            end
        elseif t[k] == v then
            t[k] = nil
        end
    end
    return t
end
NugRunning.RemoveDefaults = RemoveDefaults

local function RemoveDefaultsPreserve(t, defaults)
    if not defaults then return end
    for k, v in pairs(defaults) do
        if type(t[k]) == 'table' and type(v) == 'table' then
            RemoveDefaultsPreserve(t[k], v)
            if next(t[k]) == nil then
                t[k] = nil
            end
        elseif t[k] == nil and v ~= nil then
            t[k] = "__REMOVED__"
        elseif t[k] == v then
            t[k] = nil
        end
    end
    return t
end
NugRunning.RemoveDefaultsPreserve = RemoveDefaultsPreserve

local function MergeTable(t1, t2)
    if not t2 then return false end
    for k,v in pairs(t2) do
        if type(v) == "table" then
            if t1[k] == nil then
                t1[k] = CopyTable(v)
            else
                MergeTable(t1[k], v)
            end
        elseif v == "__REMOVED__" then
            t1[k] = nil
        else
            t1[k] = v
        end
    end
    return t1
end
NugRunning.MergeTable = MergeTable


NugRunning:RegisterEvent("PLAYER_LOGIN")
NugRunning:RegisterEvent("PLAYER_LOGOUT")
function NugRunning.PLAYER_LOGIN(self,event,arg1)
    NRunDB_Global = NRunDB_Global or {}
    NRunDB_Char = NRunDB_Char or {}
    NRunDB_Global.charspec = NRunDB_Global.charspec or {}
    local user = UnitName("player").."@"..GetRealmName()
    if NRunDB_Global.charspec[user] then
        NRunDB = NRunDB_Char
    else
        NRunDB = NRunDB_Global
    end
    NugRunning.db = NRunDB

    SetupDefaults(NRunDB, defaults)

    leaveGhost = NRunDB.leaveGhost

    NugRunning.AddSpellNameRecognition = helpers.AddSpellNameRecognition

    NugRunningConfigCustom = NugRunningConfigCustom or {}

    NugRunningConfigMerged = CopyTable(NugRunningConfig)

    local _, class = UnitClass("player")
    local categories = {"spells", "cooldowns", "activations", "casts"}
    if not NugRunningConfigCustom[class] then NugRunningConfigCustom[class] = {} end

    local globalConfig = NugRunningConfigCustom["GLOBAL"]
    MergeTable(NugRunningConfigMerged, globalConfig)
    local classConfig = NugRunningConfigCustom[class]
    MergeTable(NugRunningConfigMerged, classConfig)

    NugRunning.spellNameToID = helpers.spellNameToID
    -- filling spellNameToID for user-added spells
    NugRunning:UpdateSpellNameToIDTable()

    config = NugRunningConfigMerged
    spells = config.spells
    activations = config.activations
    cooldowns = config.cooldowns
    itemcooldowns = config.itemcooldowns
    event_timers = config.event_timers

    -- filling up ranks for spells and casts
    local cloneIDs = {}
    local rankCategories = { "spells", "casts" }
    local tempTable = {}
    for _, category in ipairs(rankCategories) do
        table.wipe(tempTable)
        for spellID, opts in pairs(config[category]) do
            if not cloneIDs[spellID] and opts.clones then
                for i, additionalSpellID in ipairs(opts.clones) do
                    tempTable[additionalSpellID] = opts
                    cloneIDs[additionalSpellID] = true
                end
            end
        end
        for spellID, opts in pairs(tempTable) do
            config[category][spellID] = opts
        end
    end
    config.spellClones = cloneIDs
    -- for _, timerType in ipairs(categories) do
        -- for k, opts in pairs(classConfig[timerType]) do
            -- NugRunningConfigMerged[timerType]
        -- end
    -- end
    -- local mt = {
    --     __index = function(t,k)
    --         return t.defaults[k]
    --     end
    -- }
    -- local categories = {"spells", "cooldowns", "activations", "casts"}
    -- for


    NugRunning:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    if not isClassic then NugRunning:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED") end
    NugRunning.ACTIVE_TALENT_GROUP_CHANGED = NugRunning.ReInitSpells
    -- NugRunning:RegisterEvent("PLAYER_TALENT_UPDATE")
    -- NugRunning.PLAYER_TALENT_UPDATE = NugRunning.ReInitSpells
    NugRunning.CHARACTER_POINTS_CHANGED = NugRunning.ReInitSpells
    NugRunning:RegisterEvent("CHARACTER_POINTS_CHANGED")
    NugRunning:RegisterUnitEvent("UNIT_POWER_UPDATE", "player")

    NugRunning:ReInitSpells()


    NugRunning:RegisterEvent("PLAYER_TARGET_CHANGED")
    -- NugRunning:RegisterEvent("UNIT_AURA")

    if NRunDB.cooldownsEnabled then
        NugRunning:RegisterEvent("SPELL_UPDATE_COOLDOWN")
        if C_Timer then
        NugRunning.cooldownTicker = C_Timer.NewTicker(1, function()
            NugRunning:SPELL_UPDATE_COOLDOWN("PERIODIC_COOLDOWN_UPDATE", true)
        end)
        end
    end

    if NRunDB.nameplates then
        local found
        for _, opts in pairs(config.spells) do
            if opts.nameplates then found = true; break end
        end
        if found then
            NugRunning:DoNameplates()
            nameplates = NugRunningNameplates
        end
    end

    --NugRunning:RegisterEvent("SPELL_UPDATE_USABLE")
    if not isClassic then
        NugRunning:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
        NugRunning:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
    end


    if next(event_timers) then check_event_timers = true end
    playerGUID = UnitGUID("player")

    NugRunning.anchors = {}
    for name, opts in pairs(NRunDB.anchors) do
        local anchor = NugRunning:CreateAnchor(name, opts)
        NugRunning.anchors[name] = anchor
    end

    NugRunning.targetIndicator = NugRunning:CreateTargetIndicator()

    NugRunning:SetupArrange()

    for i=1,MAX_TIMERS do
        local timer = NugRunning:CreateTimer()
        free[timer] = true
    end
    --remove timer from the pool and change it to castbar
    local cbt = next(free)
    free[cbt] = nil
    NugRunning:CreateCastbarTimer(cbt)

    local _,class = UnitClass("player")
    if (class == "DRUID") and NRunDB.dotpower then
        NugRunning.dotpowerFrame:RegisterUnitEvent("UNIT_AURA", "player")
    end

    SLASH_NUGRUNNING1= "/nugrunning"
    SLASH_NUGRUNNING2= "/nrun"
    SlashCmdList["NUGRUNNING"] = NugRunning.SlashCmd

    if NRunDB.totems and NugRunning.InitTotems then NugRunning:InitTotems() end
    NugRunning.SetupSpecialTimers()


    local f = CreateFrame('Frame', nil, InterfaceOptionsFrame)
    f:SetScript('OnShow', function(self)
        self:SetScript('OnShow', nil)
        LoadAddOn('NugRunningOptions')
    end)
end

function NugRunning.PLAYER_LOGOUT(self, event)
    RemoveDefaults(NRunDB, defaults)
end

local DR_CategoryBySpellID = helpers.DR_CategoryBySpellID
local DR_TypesPVE = helpers.DR_TypesPVE
local DRResetTime = 18.4

local DRInfo = setmetatable({}, { __mode = "k" })
local COMBATLOG_OBJECT_TYPE_PLAYER = COMBATLOG_OBJECT_TYPE_PLAYER
local COMBATLOG_OBJECT_REACTION_FRIENDLY = COMBATLOG_OBJECT_REACTION_FRIENDLY

local DRMultipliers = { 0.5, 0.25, 0}
local function addDRLevel(dstGUID, category)
    local guidTable = DRInfo[dstGUID]
    if not guidTable then
        DRInfo[dstGUID] = {}
        guidTable = DRInfo[dstGUID]
    end

    local catTable = guidTable[category]
    if not catTable then
        guidTable[category] = {}
        catTable = guidTable[category]
    end

    local now = GetTime()
    local isExpired = (catTable.expires or 0) <= now
    if isExpired then
        catTable.level = 1
        catTable.expires = now + DRResetTime
    else
        catTable.level = catTable.level + 1
    end
end
local function clearDRs(dstGUID)
    DRInfo[dstGUID] = nil
end
local function getDRMul(dstGUID, spellID)
    local category = DR_CategoryBySpellID[spellID]
    if not category then return 1 end

    local guidTable = DRInfo[dstGUID]
    if guidTable then
        local catTable = guidTable[category]
        if catTable then
            local now = GetTime()
            local isExpired = (catTable.expires or 0) <= now
            if isExpired then
                return 1
            else
                return DRMultipliers[catTable.level]
            end
        end
    end
    return 1
end

local function CountDiminishingReturns(eventType, srcGUID, srcFlags, dstGUID, dstFlags, spellID, auraType)
    if auraType == "DEBUFF" then
        if eventType == "SPELL_AURA_REMOVED" or eventType == "SPELL_AURA_REFRESH" then
            local category = DR_CategoryBySpellID[spellID]
            if not category then return end

            local isDstPlayer = bit_band(dstFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0
            local isFriendly = bit_band(dstFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) > 0

            if isFriendly then return end

            -- -- not doing in depth Mind Control bullshit for now
            -- if not isDstPlayer then
            --     if string_sub(dstGUID,1,6) ~= "Player" then
            --         -- Players have same bitmask as player pets when they're mindcontrolled and MC aura breaks, so we need to distinguish these
            --         -- so we can ignore the player pets but not actual players
            --         isMindControlled = true
            --     end
            --     if not isMindControlled then return end
            -- else
            --     -- Ignore taunts for players
            --     if category == "taunt" then return end
            -- end

            if not isDstPlayer then
                if not DR_TypesPVE[category] then return end
            end

            addDRLevel(dstGUID, category)
        end
        if eventType == "UNIT_DIED" then
            clearDRs(dstGUID)
        end
    end
end




--------------------
-- CLEU dispatcher
--------------------
function NugRunning.COMBAT_LOG_EVENT_UNFILTERED( self, event )

    local timestamp, eventType, hideCaster,
    srcGUID, srcName, srcFlags, srcFlags2,
    dstGUID, dstName, dstFlags, dstFlags2,
    spellID, spellName, spellSchool, auraType, amount = CombatLogGetCurrentEventInfo()

    if auraType == "BUFF" or auraType == "DEBUFF" or eventType == "SPELL_MISSED" then

    if spellID == 0 then
        spellID = helpers.spellNameToID[spellName]
        if not spellID then
            return
        end
    end

    CountDiminishingReturns(eventType, srcGUID, srcFlags, dstGUID, dstFlags, spellID, auraType)

    if spells[spellID] then
        local affiliationStatus = (bit_band(srcFlags, AFFILIATION_MINE) == AFFILIATION_MINE)
        local opts = spells[spellID]
        if not affiliationStatus and opts.affiliation then
            affiliationStatus = (bit_band(srcFlags, COMBATLOG_OBJECT_AFFILIATION_MASK) <= opts.affiliation)
        end
        if opts.target and dstGUID ~= UnitGUID(opts.target) then return end
        if affiliationStatus then
            if eventType == "SPELL_AURA_REFRESH" then
                self:RefreshTimer(srcGUID, dstGUID, dstName, dstFlags, spellID, spellName, opts, auraType, nil, amount, nil)
            elseif eventType == "SPELL_AURA_APPLIED_DOSE" then
                self:RefreshTimer(srcGUID, dstGUID, dstName, dstFlags, spellID, spellName, opts, auraType, nil, amount, opts._ignore_applied_dose)
            elseif eventType == "SPELL_AURA_APPLIED" then
                self:ActivateTimer(srcGUID, dstGUID, dstName, dstFlags, spellID, spellName, opts, auraType)
            elseif eventType == "SPELL_AURA_REMOVED" then
                self:DeactivateTimer(srcGUID, dstGUID, spellID, spellName, opts, auraType)
            elseif eventType == "SPELL_AURA_REMOVED_DOSE" then
                self:RemoveDose(srcGUID, dstGUID, spellID, spellName, auraType, amount)
            elseif eventType == "SPELL_MISSED" then
                if NRunDB.missesEnabled then
                    self:ActivateTimer(srcGUID, dstGUID, dstName, dstFlags, spellID, spellName, opts, "MISSED", auraType) -- auraType = missType in this case
                end
            elseif eventType == "SPELL_CAST_SUCCESS" then
                lastCastSpellID = spellID
            end
        end
    end

    end

    if check_event_timers then
        if spellID == 0 then
            spellID = helpers.spellNameToID[spellName]
            if not spellID then
                return
            end
        end

        if event_timers[spellID] then
            local opts = event_timers[spellID]
            local opts_event = opts.event
            if opts_event == eventType or (type(opts_event) == "table" and opts_event[eventType]) then
                local affiliationStatus = (bit_band(srcFlags, AFFILIATION_MINE) == AFFILIATION_MINE)
                if affiliationStatus or (opts.affiliation and bit_band(srcFlags, COMBATLOG_OBJECT_AFFILIATION_MASK) <= opts.affiliation ) then
                    -- if spellID == opts.spellID then
                        if opts.action and not opts.disabled then
                            opts.action(active, srcGUID, dstGUID, spellID, auraType) --  auraType = damage amount for SPELL_DAMAGE
                        else
                            self:ActivateTimer(playerGUID, dstGUID, dstName, nil, spellID, spellName, opts, "EVENT", opts.duration)
                            -- break
                        end
                    -- end
                end
            end
        end
    end

    if eventType == "UNIT_DIED" or eventType == "UNIT_DESTROYED" then
        self:DeactivateTimersOnDeath(dstGUID)
    end
end

---------------------------------
-- ACTIVATION OVERLAY & USABLE
---------------------------------

--function NugRunning.SPELL_UPDATE_USABLE(self, event)
--end
function NugRunning.SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(self,event, spellID)
    if activations[spellID] then
        local opts = activations[spellID]
        if not opts.for_cd then
            if opts.showid then spellID = opts.showid end
            local timer = self:ActivateTimer(UnitGUID("player"),UnitGUID("player"), UnitName("player"), nil, spellID, opts.localname, opts, "ACTIVATION", opts.duration)
            if opts.instantGhost then
                timer:BecomeGhost()
            end
        else
            local cd_opts = cooldowns[spellID]
            local timer = gettimer(active,spellID, playerGUID, "COOLDOWN")
            if not timer then
                timer = self:ActivateTimer(playerGUID, playerGUID, UnitName("player"), nil, spellID, GetSpellInfo(spellID), cd_opts, "COOLDOWN", 5)
                if not timer then return end
                timer:BecomeGhost(opts.ghost) -- overriding the normal ghost length with the one in activation's opts
            end

            if opts.effect then
                timer.effect:SetEffect(opts.effect)
                timer.effect:Show()
            end
            local arrow = opts.arrow
            if arrow then
                local color = arrow[3] and arrow or {1,0,0}
                timer.arrow:SetVertexColor(unpack(color))
                timer.arrow:Show()
            end
        end
    end
end
function NugRunning.SPELL_ACTIVATION_OVERLAY_GLOW_HIDE(self,event, spellID)
    if activations[spellID] then
        local opts = activations[spellID]
        if not opts.for_cd then
            if opts.showid then spellID = opts.showid end
            self:DeactivateTimer(UnitGUID("player"),UnitGUID("player"), spellID, nil, opts, "ACTIVATION")
        else
            -- local cd_opts = cooldowns[spellID]
            local timer = gettimer(active,spellID,UnitGUID("player"),"COOLDOWN")
            if timer then
                if opts.effect then
                    timer.effect:SetEffect(opts.effect)
                    timer.effect:Hide()
                end
                if opts.arrow then
                    timer.arrow:Hide()
                end
            end
        end
    end
end

---------------------------
--   COOLDOWNS

local function GetSpellCooldownCharges(spellID)
    local startTime, duration, enabled = GetSpellCooldown(spellID)
    local charges, maxCharges, chargeStart, chargeDuration = GetSpellCharges(spellID)
    if charges and charges ~= maxCharges then
        startTime = chargeStart
        duration = chargeDuration
    end
    return startTime, duration, enabled, charges, maxCharges
end

local activeCooldownTimers = {}
local gcdDuration = 1.5
local wandUserMinDuration
local _, class = UnitClass("player")
if class == "WARLOCK" or class == "MAGE" or class == "PRIEST" then
    wandUserMinDuration = 3
end

local function CheckCooldown(spellID, opts, startTime, duration, enabled, charges, maxCharges, isItem)
    local cdType = isItem and "ITEMCOOLDOWN" or "COOLDOWN"
    local timer
    local old_timer = activeCooldownTimers[spellID]

    if old_timer and (old_timer.spellID == spellID and old_timer.timerType == cdType) then
        timer = old_timer
    end
    if opts.replaces then
        timer = gettimer(active, opts.replaces, UnitGUID("player"), cdType)
    end
    if duration then
        if duration <= gcdDuration then
            if timer and active[timer] then
                local oldcdrem = timer.endTime - GetTime()
                if oldcdrem > duration or oldcdrem < 0 then
                    if not timer.isGhost then
                        free[timer] = true
                        if timer.isGhost and not timer.shine:IsPlaying() then timer.shine:Play() end
                        activeCooldownTimers[spellID] = nil
                    end
                end
            end
        else
                if not active[timer] or timer.isGhost then
                    local mdur = opts.minduration or wandUserMinDuration
                    local time_remains = (duration + startTime) - GetTime()
                    local mrem = opts.hide_until
                    local isKnown = true
                    if opts.isknowncheck then
                        isKnown = opts.isknowncheck()
                    end
                    if isKnown and (not mdur or duration > mdur) and (not mrem or time_remains < mrem) then
                        timer = NugRunning:ActivateTimer(UnitGUID("player"),UnitGUID("player"), UnitName("player"), nil, spellID, opts.localname, opts, cdType, time_remains)
                    else
                        if timer and timer.isGhost then
                            NugRunning.GhostExpire(timer)
                        end
                    end
                    if timer then
                        timer.cd_startTime = startTime
                        timer.cd_duration = duration
                        timer.fixedoffset = timer.opts.fixedlen and duration - timer.opts.fixedlen or 0
                        timer:SetTime(startTime, startTime + duration,  timer.fixedoffset)
                        activeCooldownTimers[spellID] = timer
                    end
                else
                    local mdur = opts.minduration or wandUserMinDuration
                    if (timer.cd_startTime ~= startTime or timer.cd_duration ~= duration) and (not mdur or duration > mdur) then
                        timer.cd_startTime = startTime
                        timer.fixedoffset = timer.opts.fixedlen and duration - timer.opts.fixedlen or 0
                        timer:SetTime(startTime, startTime + duration, timer.fixedoffset)
                    -- elseif timer.cd_duration ~= duration then
                    end

                    if opts.replaces then
                        local name,_, texture = GetSpellInfo(spellID)
                        timer:SetIcon(texture)
                        timer:SetName(NugRunning:MakeName(opts, name, timer.dstName) )
                        if opts.color then timer:SetColor(unpack(opts.color)) end
                    end
                    activeCooldownTimers[spellID] = timer
                end
                if charges and timer then
                    activeCooldownTimers[spellID]:SetCount(maxCharges-charges)
                end
        end
    end
end

local lastCooldownUpdateTime = GetTime()
function NugRunning.SPELL_UPDATE_COOLDOWN(self,event, periodic)
    if periodic and GetTime() - lastCooldownUpdateTime < 0.9 then return end
    -- gcdDuration = UnitPowerType("player") == 3 and 1 or 1.5 -- If energy then 1

    for spellID,opts in pairs(cooldowns) do
        if not opts.check_known or IsPlayerSpell(spellID) then
            local startTime, duration, enabled, charges, maxCharges = GetSpellCooldownCharges(spellID)
            CheckCooldown(spellID, opts, startTime, duration, enabled, charges, maxCharges)
        end
    end
    for itemID,opts in pairs(itemcooldowns) do
        local startTime, duration, enabled = GetItemCooldown(itemID)
        CheckCooldown(itemID, opts, startTime, duration, enabled, nil, nil, true)
    end
    lastCooldownUpdateTime = GetTime()
end

local helpful = "HELPFUL"
local harmful = "HARMFUL"
function NugRunning.ActivateTimer(self,srcGUID,dstGUID,dstName,dstFlags, spellID, spellName, opts, timerType, override, amount, from_unitaura)  -- duration override
    if opts.disabled then return end

    if opts.target then
        if opts.target == "pvp" then
            if string_sub(dstGUID,1,6) ~= "Player" then return end
        else
            if dstGUID ~= UnitGUID(opts.target) then return end
        end
    end
    if timerType == "MISSED" then
        if override == "IMMUNE" or override == "ABSORB" then return end
        opts = { duration = 3, color = NugRunningConfig.colors.MISSED, scale = .8, maxtimers = 1, priority = opts.priority or 99999, shine = true }
    end

    if opts.specmask then
        local spec = GetSpecialization()
        if spec then
            if not CheckSpec(opts.specmask, spec) then return end
        end
    end
    local multiTargetGUID
    if opts.multiTarget then multiTargetGUID = dstGUID; dstGUID = nil; end

    local timer, totalTimers = gettimer(active, opts,dstGUID,timerType) -- finding timer by opts table id
    if timer then
        -- spellID = timer.spellID -- swapping current id for existing timer id in case they're different
                                -- refresh will be searching by spellID again
        if multiTargetGUID then timer.targets[multiTargetGUID] = true end
        return self:RefreshTimer(srcGUID, dstGUID or multiTargetGUID, dstName, dstFlags, spellID, spellName, opts, timerType, override, amount, from_unitaura)
    end

    if opts.maxtimers and totalTimers >= opts.maxtimers then
        -- if UnitGUID("target") ~= dstGUID then
            -- return
        -- end
        if UnitGUID("target") == dstGUID then
            local deltimer
            for t in pairs(active) do
                if t.opts == opts and (not deltimer or deltimer._touched > t._touched) then
                    deltimer = t
                end
            end
            if deltimer then
                deltimer.isGhost = true
                deltimer.expiredGhost = true
                -- deltimer.timeless = false
                free[deltimer] = true
            end
        else
            return
        end
    end

    timer = next(free)
    if not timer then return end
    active[timer] = true
    timer:SetScript("OnUpdate",NugRunning.TimerFunc)

    timer._touched = GetTime()

    if opts.init and not opts.init_done then
        opts:init()
        opts.init_done = true
    end
    if not from_unitaura then
        if opts.tick and NRunDB.dotticks then
            timer.tickPeriod = opts.tick > 0 and (opts.tick/(1+(UnitSpellHaste("player")/100))) or math.abs(opts.tick)
            timer.mark.fullticks = nil
        else
            timer.tickPeriod = nil
        end

        local plevel = self:GetPowerLevel()
        timer.powerLevel = plevel
        self:UpdateTimerPower(timer, plevel)
    end
    timer.srcGUID = srcGUID
    timer.dstGUID = dstGUID
    timer.dstName = dstName
    if multiTargetGUID then timer.targets[multiTargetGUID] = true end
    timer.spellID = spellID
    timer.spellName = spellName
    timer.comboPoints = helpers.GetCP()
    timer.timerType = timerType
    if opts.isItem then
        timer:SetIcon(select(5,GetItemInfoInstant(spellID)))
    else
        timer:SetIcon(select(3,GetSpellInfo(opts.showid or spellID)))
    end
    timer.opts = opts
    timer.onupdate = opts.onupdate

    if timerType == "BUFF"
        then timer.filter = "HELPFUL"
        else timer.filter = "HARMFUL"
    end

    local time
    if timerType == "MISSED" then
        time = opts.duration
    elseif override then time = override
    else
        time = NugRunning.SetDefaultDuration(dstFlags, opts, timer)

        local _guid = multiTargetGUID or dstGUID
        if _guid == playerGUID and (timerType == "BUFF" or timerType == "DEBUFF") then
            local uaTime, uaCount = NugRunning.QueueAura(spellName, _guid, timerType, timer)
            if uaTime then
                time = uaTime
                amount = uaCount
            end
        elseif timerType == "DEBUFF" then
            if not multiTargetGUID then
                local mul = getDRMul(dstGUID, spellID)
                time = time * mul
            end
        end
    end

    if timer.VScale then
        local scale = opts.scale
        if scale then
            timer:VScale(scale)
        else
            timer:VScale(1)
        end
    end

    timer.priority = opts.priority or 0
    local now = GetTime()
    timer.fixedoffset = opts.fixedlen and time - opts.fixedlen or 0

    if not opts.color then
        if timerType == "DEBUFF" then opts.color = NugRunningConfig.colors.DEFAULT_DEBUFF
        else opts.color = NugRunningConfig.colors.DEFAULT_BUFF end
    end
    timer:SetColor(unpack(opts.color))

    timer.timeless = (opts.timeless or opts.charged or override == -1)

    timer:EnableSpark(not opts.timeless)

    amount = amount or 1
    if opts.charged then
        timer:ToInfinite()
        local max = opts.maxcharge
        timer:SetMinMaxCharge(0,max)
        if opts.color2 then
            timer:SetColor(helpers.GetGradientColor(opts.color2, opts.color, amount/max))
        end
        timer:SetCharge(amount)
        timer:UpdateMark()
    elseif timer.timeless then
        timer:ToInfinite()
        timer:UpdateMark()
        timer:SetCount(amount)
    else
        timer:SetTime(now, now + time, timer.fixedoffset)
        timer:SetCount(amount)
    end
    timer.count = amount


    local nameText
    if opts.textfunc and type(opts.textfunc) == "function" then
        nameText = opts.textfunc(timer)
    elseif timerType == "MISSED" then
        if override then
            nameText = _G[override] or override
        else
            nameText = "Miss"
        end
    else
        nameText = NugRunning:MakeName(opts, spellName, dstName)
    end
    if timer.SetName then timer:SetName(nameText) end

    if timer.glow:IsPlaying() then timer.glow:Stop() end
    if timer.arrowglow:IsPlaying() then
        timer.arrowglow:Stop()
    end

    local effect = opts.effect
    if effect and not opts.effecttime then
        timer.effect:SetEffect(effect)
        timer.effect:Show()
    else
        timer.effect:Hide()
    end

    if opts.scale_until then
        if timer:Remains() > opts.scale_until then
            timer:VScale(0.4)
            timer:SetTime(nil, nil, nil, 0)
        end
    end

    local arrow = opts.arrow
    if arrow then
        local color = arrow[3] and arrow or {1,0,0}
        timer.arrow:SetVertexColor(unpack(color))
        timer.arrow:Show()
    else
        timer.arrow:Hide()
    end

    -- print(srcGUID,dstGUID,dstName,dstFlags, spellID, spellName, opts, timerType, override, amount)

    timer:Show()
    if not timer.animIn:IsPlaying() and not from_unitaura then timer.animIn:Play() end
    timer.shine.tex:SetAlpha(0)
    if opts.shine and not timer.shine:IsPlaying() then timer.shine:Play() end

    self:ArrangeTimers()
    return timer
end

function NugRunning.RefreshTimer(self,srcGUID,dstGUID,dstName,dstFlags, spellID, spellName, opts, timerType, override, amount, ignore_applied_dose)
    local multiTargetGUID
    if opts.multiTarget then multiTargetGUID = dstGUID; dstGUID = nil; end

    local timer = gettimer(active, opts or spellID,dstGUID,timerType)
    if not timer then
        return self:ActivateTimer(srcGUID, dstGUID or multiTargetGUID, dstName, dstFlags, spellID, spellName, opts, timerType, override)
    end
    if (timerType == "COOLDOWN" or timerType == "ITEMCOOLDOWN") and not timer.isGhost then return timer end
    -- if timer.isGhost then
        timer:SetScript("OnUpdate",NugRunning.TimerFunc)
        timer.isGhost = nil
        timer.expiredGhost = nil
        if not opts.color then
        if timerType == "DEBUFF" then opts.color = { 0.8, 0.1, 0.7}
        else opts.color = { 1, 0.4, 0.2} end
        end
        timer:SetColor(unpack(opts.color))
    -- end

    local time
    if override then time = override
    else
        if not ignore_applied_dose then -- why was it ignoring multi target?
            time = NugRunning.SetDefaultDuration(dstFlags, opts, timer)
        end

        local _guid = multiTargetGUID or dstGUID
        if _guid == playerGUID and (timerType == "BUFF" or timerType == "DEBUFF") then
            local uaTime, uaCount = NugRunning.QueueAura(spellName, _guid, timerType, timer)
            if uaTime then
                time = uaTime
                amount = uaCount
            end
        elseif timerType == "DEBUFF" then
            if not multiTargetGUID then
                local mul = getDRMul(dstGUID, spellID)
                time = time * mul
            end
        end
    end
    if amount and opts.charged then
        local max = opts.maxcharge
        timer:SetMinMaxCharge(0,max)
        if opts.color2 then
            timer:SetColor(helpers.GetGradientColor(opts.color2, opts.color, amount/max))
        end
        timer:SetCharge(amount)
    elseif not timer.timeless then
        local now = GetTime()
        timer.fixedoffset = opts.fixedlen and time - opts.fixedlen or 0
        if time then timer:SetTime(now, now + time, timer.fixedoffset) end
        timer:SetCount(amount)
    end
    timer.count = amount
    timer.comboPoints = helpers.GetCP()

    if not ignore_applied_dose then
        if opts.tick and NRunDB.dotticks then
            timer.tickPeriod = opts.tick > 0 and (opts.tick/(1+(UnitSpellHaste("player")/100))) or math.abs(opts.tick)
            timer.mark.fullticks = nil
        else
            timer.tickPeriod = nil
        end

        local plevel = self:GetPowerLevel()
        timer.powerLevel = plevel
        self:UpdateTimerPower(timer, plevel)
    end

    if opts.scale_until then
        if timer:Remains() > opts.scale_until then
            timer:VScale(0.4)
            -- timer:SetTime(nil,nil,
        end
    end

    local effect = opts.effect
    if effect and not opts.effecttime then
        timer.effect:SetEffect(effect)
        timer.effect:Show()
    else
        timer.effect:Hide()
    end

    local arrow = opts.arrow
    if arrow then
        local color = arrow[3] and arrow or {1,0,0}
        timer.arrow:SetVertexColor(unpack(color))
        timer.arrow:Show()
    else
        timer.arrow:Hide()
    end

    timer:UpdateMark()

    if timer.glow:IsPlaying() then timer.glow:Stop() end
    if timer.arrowglow:IsPlaying() then
        timer.arrowglow:Stop()
    end
    if not ignore_applied_dose and opts.shinerefresh and not timer.shine:IsPlaying() then timer.shine:Play() end -- ignore_applied_dose is the same as noshine

    self:ArrangeTimers()
    return timer
end

function NugRunning.RemoveDose(self,srcGUID,dstGUID, spellID, spellName, timerType, amount)
    for timer in pairs(active) do
        if  timer.spellID == spellID
        and timer.dstGUID == dstGUID
        and timer.timerType == timerType
        and timer.srcGUID == srcGUID
        then
            if timer.opts.charged then
                local opts = timer.opts
                local max = opts.maxcharge
                if opts.color2 then
                    timer:SetColor(helpers.GetGradientColor(opts.color2, opts.color, amount/max))
                end
                timer:SetCharge(amount)
            else
                timer:SetCount(amount)
            end
            timer.count = amount
        end
    end
end

function NugRunning.DeactivateTimer(self,srcGUID,dstGUID, spellID, spellName, opts, timerType)
    local multiTargetGUID
    if opts.multiTarget then multiTargetGUID = dstGUID; dstGUID = nil; end
    for timer in pairs(active) do
        if  timer.spellID == spellID
        and timer.dstGUID == dstGUID
        and timer.timerType == timerType
        and timer.srcGUID == srcGUID
        then
            if multiTargetGUID then
                timer.targets[multiTargetGUID] = nil
                if next(timer.targets) then return end
            end
            free[timer] = true
            self:ArrangeTimers()
            return
        end
    end
end

local function free_noghost(timer)
    timer._elapsed = 2.5
    free[timer] = true
end
function NugRunning.DeactivateTimersOnDeath(self,dstGUID)
    for timer in pairs(active) do
        if spells[timer.spellID] then
        if not timer.dstGUID then -- clearing guid from multi target list just in case
            timer.targets[dstGUID] = nil
            if not next(timer.targets) then free_noghost(timer) end
        elseif timer.dstGUID == dstGUID then free_noghost(timer) end
        end
    end
end

function NugRunning.SetDefaultDuration(dstFlags, opts, timer )
    if opts.pvpduration
        and bit_band(dstFlags, COMBATLOG_HOSTILE_PLAYER) == COMBATLOG_HOSTILE_PLAYER
    then
        return opts.pvpduration
    end
    return ((type(opts.duration) == "function" and opts.duration(timer, opts)) or opts.duration)
end

function NugRunning.MakeName(self, opts, spellName, dstName)
    if NRunDB.targetTextEnabled and dstName ~= UnitName("player") then
        return dstName
    elseif NRunDB.spellTextEnabled then
        if NRunDB.localNames then
            return spellName
        elseif NRunDB.shortTextEnabled and opts.short then
            return opts.short
        else
            return opts.name
        end
    else
        return ""
    end
end

------------------------------
-- UNIT_AURA Duration Queue
------------------------------
-- to get precise duration value from unitID, if it's available, after combat log event
-- 5.0 changes: UnitAura now returns correct info at the time of CLEU SPELL_AURA_APPLIED event
--              So, spells are no longer queued.

local debuffUnits = {"target","mouseover","focus","arena1","arena2","arena3","arena4","arena5"}
local buffUnits = {"player","target","mouseover"}

    function NugRunning.QueueAura(spellNameOrID, dstGUID, auraType, timer )
        local unit
        local auraUnits = (auraType == "DEBUFF") and debuffUnits or buffUnits
        for _,unitID in ipairs(auraUnits) do
            if dstGUID == UnitGUID(unitID) then
                unit = unitID
                break
            end
        end
        if not unit then return nil end

        return NugRunning:GetUnitAuraData(unit, timer, spellNameOrID)
    end

function NugRunning:UpdateTimerToSpellID(timer, newSpellID)
    if timer.spellID == newSpellID then return end
    local opts = timer.opts
    -- local oldSpellID = timer.spellID
    timer.spellID = newSpellID

    local dstGUID = timer.dstGUID

    local newDuration = NugRunning.SetDefaultDuration(0, opts, timer)
    local mul = getDRMul(dstGUID, newSpellID)

    local newDuration = newDuration * mul

    if newDuration then
        local startTime = timer.startTime
        timer:SetTime(startTime, startTime + newDuration, timer.fixedoffset)
    end
end

do
    local spellNameBasedCategories = { "spells", "event_timers" }
    function NugRunning:UpdateSpellNameToIDTable()
        local mergedConfig = NugRunningConfigMerged
        local visited = {}

        for _, catName in ipairs(spellNameBasedCategories) do
            local category = mergedConfig[catName]
            if category then
                for spellID, opts in pairs(category) do
                    if not visited[opts] then
                        local lastRankID
                        local clones = opts.clones
                        if clones then
                            lastRankID = clones[#clones]
                        else
                            lastRankID = spellID
                        end
                        helpers.AddSpellNameRecognition(lastRankID)

                        visited[opts] = true
                    end
                end
            end
        end
    end
end

function NugRunning.SetUnitAuraValues(self, timer, spellNameOrID, name, icon, count, dispelType, duration, expirationTime, caster, isStealable, shouldConsolidate, aura_spellID, canApplyAura, isBossDebuff)
            if aura_spellID then
                if (aura_spellID == spellNameOrID or name == spellNameOrID) and NugRunning.UnitAffiliationCheck(caster, timer.opts.affiliation) then
                    if timer.opts.charged then
                        local opts = timer.opts
                        local max = opts.maxcharge
                        timer:SetMinMaxCharge(0,max)
                        if opts.color2 then
                            timer:SetColor(helpers.GetGradientColor(opts.color2, opts.color, count/max))
                        end
                        timer:SetCharge(count)
                    elseif not timer.timeless then
                        timer:SetCount(count)

                        if duration == 0 then
                            timer.timeless = true
                            timer:ToInfinite()
                            timer:UpdateMark()
                            NugRunning:ArrangeTimers()
                        else
                            timer.fixedoffset = timer.opts.fixedlen and duration - timer.opts.fixedlen or 0
                            local oldExpTime = timer.endTime
                            timer:SetTime(expirationTime - duration,expirationTime, timer.fixedoffset)

                            if oldExpTime and oldExpTime ~= expirationTime then
                                -- if opts.tick and NRunDB.dotticks then
                                --     timer.tickPeriod = opts.tick > 0 and (opts.tick/(1+(UnitSpellHaste("player")/100))) or math.abs(opts.tick)
                                --     timer.mark.fullticks = nil
                                -- else
                                --     timer.tickPeriod = nil
                                -- end
                                local plevel = self:GetPowerLevel()
                                timer.powerLevel = plevel
                                self:UpdateTimerPower(timer, plevel)

                                NugRunning:ArrangeTimers()
                            end
                        end
                        timer:SetCount(count)
                    else
                        timer:SetCount(count)
                    end

                    return duration, count
                end
            end
end

function NugRunning.GetUnitAuraData(self, unit, timer, spellNameOrID)
        for auraIndex=1,100 do
            local name, icon, count, dispelType, duration, expirationTime, caster, isStealable, shouldConsolidate, aura_spellID, canApplyAura, isBossDebuff, value1, absorb, value3 = UnitAura(unit, auraIndex, timer.filter)
            if spellNameOrID == aura_spellID or spellNameOrID == name then
                return NugRunning:SetUnitAuraValues(timer, spellNameOrID, name, icon, count, dispelType, duration, expirationTime, caster, isStealable, shouldConsolidate, aura_spellID, canApplyAura, isBossDebuff, value1, absorb, value3)
            elseif name == nil then
                return
            end
        end
end


local function GetGradientColor(c1, c2, v)
    if v > 1 then v = 1 end
    local r = c1[1] + v*(c2[1]-c1[1])
    local g = c1[2] + v*(c2[2]-c1[2])
    local b = c1[3] + v*(c2[3]-c1[3])
    return r,g,b
end
helpers.GetGradientColor = GetGradientColor

local math_floor = math.floor
local round = function(v) return math_floor(v+.1) end
-----------------------------------
-- Timer internal functionality
-----------------------------------
function NugRunning.TimerFunc(self,time)
    self._elapsed = self._elapsed + time
    if self._elapsed < 0.02 then return end
    self._elapsed = 0

    local opts = self.opts
    if self.timeless or opts.charged then return end

    local endTime = self.endTime
    local beforeEnd = endTime - GetTime()

    if beforeEnd <= 0 then
        if not self.dontfree then
            table_wipe(self.targets)
            NugRunning.free[self] = true
            return
        end
    end

    self:Update(beforeEnd)

    if opts.color2 then
        local dur = endTime - self.startTime
        self:SetColor(GetGradientColor(opts.color2, opts.color, beforeEnd/dur))
    end

    local glowtime = opts.glowtime
    if glowtime then
        if beforeEnd < glowtime then
            if self.glow and not self.glow:IsPlaying() then self.glow:Play() end
        else
            if self.glow and self.glow:IsPlaying() then self.glow:Stop() end
        end
    end

    local glow2time = opts.glow2time
    if glow2time then
        if beforeEnd < glow2time then
            if self.arrowglow and not self.arrowglow:IsPlaying() then
                self.arrow:Show()
                self.arrowglow:Play()
            end
        else
            if self.arrowglow and self.arrowglow:IsPlaying() then
                -- self.arrow:Hide()
                self.arrowglow:Stop()
            end
        end
    end

    local effecttime = opts.effecttime
    if effecttime then
        if beforeEnd < effecttime then
            self.effect:SetEffect(opts.effect)
            self.effect:Show()
        else
            self.effect:Hide()
        end
    end

    local rm = opts.recast_mark
    if rm and beforeEnd < rm and beforeEnd > rm-0.1 then
        self.mark.shine:Play()
    end

    local scaleAnimLength = 1
    local su = opts.scale_until
    if su and beforeEnd <= su then
        local os = opts.scale or 1
        if self:GetVScale() ~= os then
            local ms = 0.4
            local progress = 1 - ((beforeEnd - (su - scaleAnimLength))/ scaleAnimLength)
            if progress > 0.98 then progress = 1 end
            local pscale = ms + (os-ms)*progress
            self:VScale(pscale)
            self:SetTime(nil, nil, nil, progress)
            if self._scale == os and not self.shine:IsPlaying() then self.shine:Play() end
        end
    end

    local tickPeriod = self.tickPeriod
    if tickPeriod then
        local fullticks = round(beforeEnd/tickPeriod)
        if self.mark.fullticks ~= fullticks then
            local closestTickTime = fullticks*tickPeriod
            self:UpdateMark(closestTickTime)

            if self.mark.fullticks and self.opts.tickshine then
                -- print(beforeEnd, self.tickPeriod, self.endTime - self.startTime)
                self.mark.shine:Play()
            else
                self.mark.spark:CatchUp()
            end

            self.mark.fullticks = fullticks
        end
    end

    local timer_onupdate = self.onupdate
    if timer_onupdate then timer_onupdate(self) end
end

function NugRunning:CreateTargetIndicator()
    local targetIndicator = NugRunning:CreateTexture(nil, "ARTWORK", nil, 3)
    targetIndicator:SetTexture("Interface\\BUTTONS\\WHITE8X8")
    targetIndicator:SetWidth(5)
    targetIndicator:SetVertexColor(1, 0.5, 1, 0.8)
    return targetIndicator
end

function NugRunning.GhostExpire(self)
    self:SetScript("OnUpdate", NugRunning.TimerFunc)
    self.expiredGhost = true
    if self.glow:IsPlaying() then self.glow:Stop() end
    self.arrow:Hide()
    if self.arrowglow:IsPlaying() then
        self.arrowglow:Stop()
    end
    free[self] = true
    self.isGhost = nil
end
function NugRunning.GhostFunc(self,time)
    self._elapsed = self._elapsed + time
    if self._elapsed < self.ghost_duration then return end
    -- if leaveGhost then return end

    -- if self.isPreghosting then
        -- return
    -- end

    NugRunning.GhostExpire(self)
end
local TimerBecomeGhost = function(self, override_ghost_duration)
    self.expiredGhost = nil
    self.isGhost = true
    self:SetPowerStatus(nil)
    self.arrow:Hide()
    self:ToGhost()
    local opts = self.opts
    local ghost_value = override_ghost_duration or opts.ghost
    if self.scheduledGhost then
        ghost_value = self.scheduledGhost
        self.scheduledGhost = nil
    end
    if type(ghost_value) == "number" then
        self.ghost_duration = ghost_value
    else
        self.ghost_duration = 3
    end
    if opts.ghosteffect then
        self.effect:SetEffect(opts.ghosteffect)
        self.effect:Show()
    end

    if opts.glowghost then
        if not self.glow:IsPlaying() then self.glow:Play() end
    end
    self._elapsed = 0
    self:SetScript("OnUpdate", NugRunning.GhostFunc)
end

--[======[local Timer_is_type = function(self, ...)
    local t = self.timerType
    local len = select("#", ...)
    if len == 0 then return true end
    for i=1,len do
    --for _,v in ipairs(...) do
        if t == select(i, ...) then return true end
    end
    return false
end

local Timer_matches = function(self, spellID, srcGUID, dstGUID, ...)
    return (
        (not spellID or self.spellID == spellID) and
        (not srcGUID or self.dstGUID == dstGUID) and
        (not srcGUID or self.srcGUID == srcGUID) --and
        --self:is_type(...)
    )
end]======]


function NugRunning.CreateTimer(self)
    local w = NugRunningConfig.width or NRunDB.width
    local h = NugRunningConfig.height or NRunDB.height

    local f = NugRunning.ConstructTimerBar(w,h)
    f._elapsed = 0
    f._width = w
    f._height = h

    f.prototype = NugRunning[f.prototype or "TimerBar"]

    local mtFrameMethods = getmetatable(f).__index
    setmetatable(f, { __index = function(t,k)
                                    if t.prototype[k] then return t.prototype[k] end
                                    return mtFrameMethods[k]
                                end})

    f:SetScript("OnUpdate", NugRunning.TimerFunc)

    f.BecomeGhost = TimerBecomeGhost
    -- f.is_type = Timer_is_type
    -- f.matches = Timer_matches

    f.targets = {}
    f:Hide()
    table.insert(alltimers,f)

    return f
end



------------------------------
-- Timer sorting & anchoring
------------------------------
do
    local xOffset = 0
    local yOffset = 4
    local point
    local to
    local ySign
    local doswap
    local anchors
    local dbanchors
    local targetIndicator
    local growthDirection

    local sortedTimerGroups -- table from which arrange function works, generated in setup

    local group_sortfunc = function(a,b)
        local ao = a.order or 0
        local bo = b.order or 0
        return ao < bo
    end

    local fixOfftargets = function(groups)
        local offtargetsIndex
        for i=1, #groups do
            if groups[i].name == "offtargets" then
                offtargetsIndex = i
                break
            end
        end
        if offtargetsIndex and offtargetsIndex ~= #groups then -- if offtarget group isn't last
            local g = table.remove(groups, offtargetsIndex) -- make it last
            table.insert(groups, g)
        end
    end
    function NugRunning:MakeSortedGroupsTable()
        local sorted = {}
        local dbgroups = NRunDB.groups -- group settings
        for name, group in pairs(dbgroups) do
            local groupAnchor = group.anchor
            if anchors[groupAnchor] then -- if such anchor created
                if not sorted[groupAnchor] then
                    sorted[groupAnchor] = {}
                end
                table.insert(sorted[groupAnchor], group)
            end
        end

        for name, groups in pairs(sorted) do
            table.sort(groups, group_sortfunc)
            fixOfftargets(groups)
        end
        return sorted
    end

    function NugRunning.SetupArrange(self)
        point = ( NRunDB.growth == "down" and "TOPLEFT" ) or "BOTTOMLEFT"
        to = ( NRunDB.growth == "down" and "BOTTOMLEFT" ) or "TOPLEFT"
        ySign = ( NRunDB.growth == "down" and -1 ) or 1
        growthDirection = NRunDB.growth
        doswap = NRunDB.swapTarget
        anchors = NugRunning.anchors -- frames
        dbanchors = NRunDB.anchors -- settings

        targetIndicator = NugRunning.targetIndicator

        sortedTimerGroups = NugRunning:MakeSortedGroupsTable()
    end
    -- local playerTimers = {}
    -- local targetTimers = {}
    -- local sorted = {}
    local groups = { player = {}, target = {} }
    local guid_groups = {}
    local sortfunc = function(a,b)
        local ap = a.priority or 0
        local bp = b.priority or 0
        if ap == bp then
            return a.endTime > b.endTime
        else
            return ap < bp
        end
    end

    function NugRunning.ArrangeTimers(self)
        for g,tbl in pairs(groups) do
            table_wipe(tbl)
        end
        table_wipe(guid_groups)
        local playerTimers = groups.player
        local targetTimers = groups.target
        local targetIndicatorUpdated

        local targetGUID = UnitGUID("target")
        for timer in pairs(active) do
            local custom_group = timer.opts.group
            if custom_group then
                groups[custom_group] = groups[custom_group] or {}
                table.insert(groups[custom_group],timer)
            elseif timer.dstGUID == playerGUID then table.insert(playerTimers,timer)
            elseif doswap and timer.dstGUID == targetGUID then table.insert(targetTimers,timer)
            elseif timer.dstGUID == nil then
                if timer.timerType == "BUFF" then
                    table.insert(playerTimers,timer)
                else
                    table.insert(targetTimers,timer)
                end
            else
                guid_groups[timer.dstGUID] = guid_groups[timer.dstGUID] or {}
                table.insert(guid_groups[timer.dstGUID],timer)
            end
        end

        for g,tbl in pairs(groups) do
            table.sort(tbl,sortfunc)
        end
        for g,tbl in pairs(guid_groups) do
            table.sort(tbl,sortfunc)
        end

        for name, anchorGroups in pairs(sortedTimerGroups) do
            local anchorFrame = anchors[name]
            local growth = dbanchors[name].growth or NRunDB.growth
            point = ( growth == "down" and "TOPLEFT" ) or "BOTTOMLEFT"
            to = ( growth == "down" and "BOTTOMLEFT" ) or "TOPLEFT"
            ySign = ( growth == "down" and -1 ) or 1
            local prev
            local gap = 0
            for _, gopts in pairs(anchorGroups) do
                local gname = gopts.name
                local alpha = gopts.alpha
                if gname == "offtargets" then
                    for guid, group_timers in pairs(guid_groups) do
                        for i,timer in ipairs(group_timers) do
                            local noswap_alpha = guid == targetGUID and 1 or alpha
                            timer:SetAlpha(noswap_alpha)
                            timer:SetPoint(point, prev or anchorFrame, prev and to  or "TOPRIGHT", xOffset, (yOffset+gap)*ySign)
                            if timer.onupdate then timer:onupdate() end
                            prev = timer
                            gap = 0
                        end

                        if not doswap and guid == targetGUID then
                            local lastTimer = group_timers[1]
                            local firstTimer = group_timers[#group_timers]
                            if growthDirection == "down" then
                                firstTimer, lastTimer = lastTimer, firstTimer
                            end
                            targetIndicatorUpdated = true
                            targetIndicator:Show()
                            targetIndicator:SetPoint("TOPRIGHT", firstTimer, "TOPLEFT", -10, 0)
                            targetIndicator:SetPoint("BOTTOMRIGHT", lastTimer, "BOTTOMLEFT", -10, 0)
                        end

                        gap = gopts.gap
                    end
                    break -- offtargets should always be the last group for anchor
                else
                    local group_timers = groups[gname]
                    if group_timers then
                    for i,timer in ipairs(group_timers) do
                        timer:SetAlpha(alpha)
                        timer:SetPoint(point, prev or anchorFrame, prev and to  or "TOPRIGHT", xOffset, (yOffset+gap)*ySign)
                        if timer.onupdate then timer:onupdate()end
                        prev = timer
                        gap = 0
                    end
                    end
                    gap = prev and gopts.gap or 0
                end
                if not doswap and not targetIndicatorUpdated then
                    targetIndicator:Hide()
                end
            end
        end

        if nameplates then
            nameplates:Update(targetTimers, guid_groups, doswap)
        end
    end
    function NugRunning.GetTimersByDstGUID(self, guid) -- for nameplate updates on target
        local guidTimers = {}
        for timer in pairs(active) do
            if timer.dstGUID == guid then table.insert(guidTimers, timer) end
        end
        table.sort(guidTimers,sortfunc)
        return guidTimers
    end
end


local IsPlayerSpell = IsPlayerSpell
local IsUsableSpell = IsUsableSpell
local function IsOriginalSpell(spellID)
    local replacedTexture, originalTexture = GetSpellTexture(spellID)
    return replacedTexture == originalTexture
end

local function IsAvailable(spellID)
    return IsPlayerSpell(spellID) and IsUsableSpell(spellID)
end

local previous_projections = {}
function NugRunning:PreGhost()
    for timer in pairs(previous_projections) do
        -- timer.isPreghosting = nil
        if timer.isGhost then
            self.GhostExpire(timer)
        end
        previous_projections[timer] = nil
    end
    if UnitExists("target") and UnitAffectingCombat("player") then
        for spellID, opts in pairs(spells) do
            if opts.preghost then
                local checkfunc = opts.isknowncheck or IsAvailable
                if checkfunc(spellID) then
                    local timer = gettimer(active, spellID, UnitGUID("target"), "DEBUFF")
                    if not timer then
                        local tempTime = 10
                        timer = self:ActivateTimer(playerGUID, UnitGUID("target"), UnitName("target"), nil, spellID, GetSpellInfo(spellID), opts, "DEBUFF", tempTime, nil, true)
                        if timer then
                            timer:BecomeGhost()
                        end
                    elseif not timer.isGhost then
                        local opts = timer.opts
                        local overlay = opts.overlay
                        local rm = opts.recast_mark or (overlay and type(overlay[2]) == "number" and overlay[2])
                        if rm and not timer.timeless then
                            local endTime = timer.endTime
                            local beforeEnd = endTime - GetTime()

                            if beforeEnd < rm then
                                timer.arrow:Show()
                                UIFrameFlash(timer.arrow, 0.15, 0.15, 1.2, false)
                            end
                        end
                    end

                    if timer then
                        previous_projections[timer] = true
                    end
                end
            end
        end
    end
end

function NugRunning.PLAYER_TARGET_CHANGED(self)
    self:UNIT_POWER_UPDATE(nil, "player", "COMBO_POINTS")
    if NRunDB.preghost then self:PreGhost() end
    self:ArrangeTimers()
end


do
    local currentPowerLevel = 0
    function NugRunning:GetPowerLevel()
        return currentPowerLevel
    end
    function NugRunning:UpdateTimerPower(timer, plevel)
        if timer.powerLevel > plevel then
            timer:SetPowerStatus("HIGH", timer.powerLevel-plevel)
        elseif timer.powerLevel < plevel then
            timer:SetPowerStatus("LOW", timer.powerLevel-plevel)
        else
            timer:SetPowerStatus(nil)
        end
    end

    local function UpdatePowerLevel()
        currentPowerLevel = 0
        for i=1, 100 do
            local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, spellID = UnitAura("player", i, "HELPFUL")
            if not name then return currentPowerLevel end
            if spellID == 5217 then -- Tiger's fury
                currentPowerLevel = currentPowerLevel + 15
            elseif spellID == 145152 then -- Bloodtalons
                currentPowerLevel = currentPowerLevel + 25
            end
        end
        return currentPowerLevel
    end

    local dotpowerFrame = CreateFrame("Frame", nil, UIParent)
    NugRunning.dotpowerFrame = dotpowerFrame
    dotpowerFrame:SetScript("OnEvent", function()
        local plevel = UpdatePowerLevel()
        for timer in pairs(active) do
            if timer.opts.showpower and timer.powerLevel and not timer.isGhost then
                -- timer:SetName(timer.powerLevel)
                NugRunning:UpdateTimerPower(timer, plevel)
            else
                timer:SetPowerStatus(nil)
            end
        end
    end)
end

function NugRunning.ReInitSpells(self,event,arg1)
    for id,opts in pairs(spells) do
        if type(opts) == "table" and opts.init then
            opts:init()
            opts.init_done = true
        end
    end
    for id, opts in pairs(event_timers) do
        if opts.init then
            opts:init()
            opts.init_done = true
        end
    end
    for id,opts in pairs(cooldowns) do
        if opts.init then
            opts:init()
            opts.init_done = true
        end
    end
end

------------------------------------------
-- Console Commands and related functions
------------------------------------------
function NugRunning.ClearTimers(self, keepSelfBuffs)
    for timer in pairs(active) do
        if not (keepSelfBuffs and (timer.dstGUID == timer.srcGUID)) then
            free[timer] = true
        end
    end
    self:ArrangeTimers()
end

function NugRunning.Unlock(self)
    local prev
    local i = 0
    local colorNames = {}
    local colors = NugRunningConfig.colors
    for color,v in pairs(colors) do
        table.insert(colorNames, color)
    end

    for timer in pairs(free) do
        i = i+1
        if i > 9 then break end
        local fakeopts = {}
        timer.opts = fakeopts
        timer.startTime = GetTime();
        timer.endTime = GetTime()+130-(i*10);
        timer:SetIcon("Interface\\Icons\\inv_misc_questionmark")

        local randColorIndex = math.random(#colorNames)
        local c = colors[colorNames[randColorIndex]]
        timer:SetName(colorNames[randColorIndex])
        timer:SetColor(unpack(c))
        timer:SetCount(math.random(3))
        timer:VScale(1)
        timer.effect:Hide()
        timer:Show()
        local point, to
        local xOffset, yOffset, ySign = 0, 4, 1
        if NRunDB.growth == "down" then
            point = "TOPLEFT"
            to = "BOTTOMLEFT"
            ySign = -1
        else
            point = "BOTTOMLEFT"
            to = "TOPLEFT"
            ySign = 1
        end
        timer:ClearAllPoints()
        timer:SetPoint(point,prev or NugRunning.anchors.main, prev and to or "TOPRIGHT", xOffset,yOffset * ySign)
        prev = timer
    end
    NugRunning.unlocked = true
end


local function capturesTable()

end



local protectedGroups = {
    player = true,
    target = true,
    buffs = true,
    offtargets = true,
    procs = true,
}
local protectedAnchors = {
    main = true,
    secondary = true,
}

local function Colorize(hexColor, text)
    return "|cff" .. tostring(hexColor or 'ffffff') .. tostring(text) .. "|r"
end

local ParseOpts = function(str)
    local t = {}
    local capture = function(k,v)
        t[k:lower()] = tonumber(v) or v
        return ""
    end
    str:gsub("(%w+)%s*=%s*%[%[(.-)%]%]", capture):gsub("(%w+)%s*=%s*(%S+)", capture)
    return t
end

NugRunning.Commands = {
    ["unlock"] = function()
        for name, anchor in pairs(NugRunning.anchors) do
            anchor:Show()
        end
        NugRunning:Unlock()
    end,
    ["lock"] = function()
        for name, anchor in pairs(NugRunning.anchors) do
            anchor:Hide()
        end
        for _,timer in ipairs(alltimers) do
            if not active[timer] then
                timer:Hide()
            end
        end
        NugRunning.unlocked = nil
    end,
    ["gui"] = function(v)
        LoadAddOn('NugRunningOptions')
        InterfaceOptionsFrame_OpenToCategory("NugRunning")
        InterfaceOptionsFrame_OpenToCategory("NugRunning")
    end,
    ["listauras"] = function(v)
        local unit = v
        local h = false
        for i=1, 100 do
            local name, _,_,_,duration,_,_,_,_, spellID = UnitAura(unit, i, "HELPFUL")
            if not name then break end
            if not h then print("BUFFS:"); h = true; end
            print(string.format("    %s (id: %d) Duration: %s", name, spellID, duration or "none" ))
        end
        h = false
        for i=1, 100 do
            local name, _,_,_,duration,_,_,_,_, spellID = UnitAura(unit, i, "HARMFUL")
            if not name then break end
            if not h then print("DEBUFFS:"); h = true; end
            print(string.format("    %s (id: %d) Duration: %s", name, spellID, duration or "none" ))
        end

    end,
    ["reset"] = function()
        for name, anchor in pairs(NRunDB.anchors) do
            anchor.point = "CENTER"
            anchor.parent = "UIParent"
            anchor.to = "CENTER"
            anchor.x = 0
            anchor.y = 0
            local pos = anchor
            if NugRunning.anchors[name] then
                NugRunning.anchors[name]:SetPoint(pos.point, pos.parent, pos.to, pos.x, pos.y)
            end
        end
    end,
    ["clear"] = function()
        NugRunning:ClearTimers(true)
    end,
    ["charspec"] = function()
        local user = UnitName("player").."@"..GetRealmName()
        if NRunDB_Global.charspec[user] then NRunDB_Global.charspec[user] = nil
        else NRunDB_Global.charspec[user] = true
        end
        print ("NRun: "..(NRunDB_Global.charspec[user] and "Enabled" or "Disabled").." character specific options. Will take effect after /reload")
    end,
    ["cooldowns"] = function()
        if NRunDB.cooldownsEnabled then
            NugRunning:UnregisterEvent("SPELL_UPDATE_COOLDOWN")
            if NugRunning.cooldownTicker then NugRunning.cooldownTicker:Cancel() end
        else
            NugRunning:RegisterEvent("SPELL_UPDATE_COOLDOWN")
            NugRunning.cooldownTicker = C_Timer.NewTicker(1, function()
                NugRunning:SPELL_UPDATE_COOLDOWN("PERIODIC_COOLDOWN_UPDATE", true)
            end)
        end
        NRunDB.cooldownsEnabled = not NRunDB.cooldownsEnabled
        print("NRun cooldowns "..(NRunDB.cooldownsEnabled and "enabled" or "disabled"))
    end,
    ["targettext"] = function()
        NRunDB.targetTextEnabled = not NRunDB.targetTextEnabled
        print("NRun target name text "..(NRunDB.targetTextEnabled and "enabled" or "disabled"))
    end,
    ["spelltext"] = function()
        NRunDB.spellTextEnabled = not NRunDB.spellTextEnabled
        print("NRun spell text "..(NRunDB.spellTextEnabled and "enabled" or "disabled"))
    end,
    ["leaveghost"] = function()
        NRunDB.leaveGhost = not NRunDB.leaveGhost
        leaveGhost = NRunDB.leaveGhost
        print("NRun leaveghost "..(NRunDB.leaveGhost and "enabled" or "disabled"))
    end,
    ["shorttext"] = function()
        NRunDB.shortTextEnabled = not NRunDB.shortTextEnabled
        print("NRun short spell text "..(NRunDB.shortTextEnabled and "enabled" or "disabled"))
    end,
    ["localnames"] = function()
        NRunDB.localNames = not NRunDB.localNames
        print("NRun localized spell names "..(NRunDB.localNames and "enabled" or "disabled"))
    end,
    ["misses"] = function()
        NRunDB.missesEnabled = not NRunDB.missesEnabled
        print("NRun miss timers "..(NRunDB.missesEnabled and "enabled" or "disabled"))
    end,
    ["swaptarget"] = function()
        NRunDB.swapTarget = not NRunDB.swapTarget
        NugRunning:SetupArrange()
        print("Target swapping turned "..(NRunDB.swapTarget and "on" or "off"))
    end,
    ["totems"] = function()
        NRunDB.totems = not NRunDB.totems
        print("Totems turned "..(NRunDB.swapTarget and "on" or "off")..". Will take effect after /reload")
    end,
    ["nameplates"] = function()
        NRunDB.nameplates = not NRunDB.nameplates
        print("Nameplates turned "..(NRunDB.nameplates and "on" or "off")..". Will take effect after /reload")
    end,
    ["dotticks"] = function()
        NRunDB.dotticks = not NRunDB.dotticks
        print("Dot ticks turned "..(NRunDB.dotticks and "on" or "off")..". Will take effect after /reload")
    end,
    ["dotpower"] = function()
        NRunDB.dotpower = not NRunDB.dotpower
        print("Dotpower turned "..(NRunDB.dotpower and "on" or "off")..". Will take effect after /reload")
    end,

    ["listgroups"] = function(v)
        print("|cffffaaaaNugRunning Groups:|r")
        local sortedGroups = NugRunning:MakeSortedGroupsTable()
        for anchorName, opts in pairs(NRunDB.anchors) do
            local hdr = string.format("Anchor: |cff33ff33%s|r", anchorName)
            if opts.growth then
                hdr = hdr .. string.format(" : growth=%s", opts.growth)
            end
            print(hdr)

            local groups = sortedGroups[anchorName]
            if groups then
                for i, g in ipairs(groups) do
                    local color = "ffffff"
                    if protectedGroups[g.name] then color = "888888" end

                    print(string.format("    <%d> %s : gap=%d alpha=%.2f order=%d",i, Colorize(color,g.name), g.gap, g.alpha, g.order))
                end
            end
        end
    end,


    ["createanchor"] = function(v)
        local p = ParseOpts(v)
        local name = p.anchor
        if name and not NRunDB.anchors[name] then
            NRunDB.anchors[name] = {
                groups = {
                },
                point = "CENTER",
                parent = "UIParent",
                to = "CENTER",
                x = 0,
                y = 0,
            }
            local anchor = NugRunning:CreateAnchor(name, NRunDB.anchors[name])
            NugRunning.anchors[name] = anchor
        end
    end,
    ["deleteanchor"] = function(v)
        local p = ParseOpts(v)
        local name = p.anchor
        if name and NRunDB.anchors[name] then
            if protectedAnchors[name] then
                print(string.format("Anchor '%s' is protected", name))
                return
            end

            NRunDB.anchors[name] = nil
            NugRunning.anchors[name]:Hide()
            NugRunning.anchors[name] = nil

            NugRunning:SetupArrange()
            NugRunning:ArrangeTimers()
        end
    end,

    ["creategroup"] = function(v)
        local p = ParseOpts(v)
        local anchor = p.anchor
        local group = p.group
        local orderSpecified = p.order

        if group and NRunDB.groups[group] then
            return print(string.format("Group '%s' already exists", group))
        end
        if not anchor then
            return print("Group's anchor not specified")
        end
        if not NRunDB.anchors[anchor] then
            return print(string.format("Anchor '%s' doesn't exists", anchor))
        end

        NRunDB.groups[group] = { name = group, gap = 10, alpha = 1, anchor = anchor, order = orderSpecified or 5 }
        NugRunning:SetupArrange()
        NugRunning:ArrangeTimers()
    end,

    ["deletegroup"] = function(v)
        local p = ParseOpts(v)
        local group = p.group
        if group then
            if protectedGroups[group] then
                print(string.format("Group '%s' is protected", group))
                return
            end

            NRunDB.groups[group] = nil
            NugRunning:SetupArrange()
            NugRunning:ArrangeTimers()
        end
    end,

    ["groupset"] = function(v)
        local p = ParseOpts(v)
        if p.group then
            local groupName = p.group
            local groupOpts = NRunDB.groups[groupName]
            if not groupOpts then
                return print(string.format("Group '%s' doesn't exist", groupName))
            end

            local newAnchor = p.anchor
            if newAnchor then
                if not NugRunning.anchors[newAnchor] then
                    return print(string.format("Anchor '%s' doesn't exists", newAnchor))
                end
            end

            groupOpts.gap = tonumber(p.gap) or groupOpts.gap
            groupOpts.alpha = tonumber(p.alpha) or groupOpts.alpha
            groupOpts.order = tonumber(p.order) or groupOpts.order
            groupOpts.anchor = newAnchor or groupOpts.anchor

            NugRunning:SetupArrange()
            NugRunning:ArrangeTimers()
        else
            print("missing 'group' parameter")
        end
    end,

    ["anchorset"] = function(v)
        local p = ParseOpts(v)
        local aname = p.anchor
        local anchor = NRunDB.anchors[aname]
        if not anchor then return print(string.format("Anchor '%s' doesn't exist", aname)) end
        anchor.growth = p.growth or anchor.growth
        if p.growth == "nil" then anchor.growth = nil end
        anchor.point = p.point or anchor.point
        anchor.parent = p.parent or anchor.parent
        anchor.to = p.to or anchor.to
        anchor.x = p.x or anchor.x
        anchor.y = p.y or anchor.y
        if p.point or p.to or p.x or p.y or p.parent then
            NugRunning.anchors[aname]:SetPoint(anchor.point, anchor.parent, anchor.to, anchor.x, anchor.y)
        end
        if p.growth then
            for i,timer in ipairs(alltimers) do timer:ClearAllPoints() end
            NugRunning:SetupArrange()
            NugRunning:ArrangeTimers()
        end
    end,

    ["set"] = function(v)
        local p = ParseOpts(v)
        NRunDB.width = p["width"] or NRunDB.width
        NRunDB.height = p["height"] or NRunDB.height
        local aname = p["anchor"]
        if aname then
            local growth = p["growth"]
            if NRunDB.anchors[aname] and growth then
                NRunDB.anchors[aname].growth = growth
            end
        else
            NRunDB.growth = p["growth"] or NRunDB.growth
        end
        for i,timer in ipairs(alltimers) do
            timer:Resize(NRunDB.width, NRunDB.height)

        end
        if NugRunning.unlocked  then
            NugRunning:Unlock()
        elseif NRunDB.growth then
            for i,timer in ipairs(alltimers) do timer:ClearAllPoints() end
            NugRunning:SetupArrange()
            NugRunning:ArrangeTimers()
        end
    end,
    ["debug"] = function()
        if not NugRunning.debug then
            NugRunning.debug = CreateFrame("Frame")
            NugRunning.debug:SetScript("OnEvent",function( self, event )
                local timestamp, eventType, hideCaster,
                srcGUID, srcName, srcFlags, srcFlags2,
                dstGUID, dstName, dstFlags, dstFlags2,
                spellID, spellName, spellSchool, auraType, amount = CombatLogGetCurrentEventInfo()
                local isSrcPlayer = (bit_band(srcFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) == COMBATLOG_OBJECT_AFFILIATION_MINE)
                if isSrcPlayer then
                    print ("ID:", spellID, string.format("|cffff8800%s|r",spellName), eventType, srcFlags, srcGUID,"|cff00ff00==>|r", dstGUID, dstFlags, amount)
                end
            end)
        end
        if not NugRunning.debug.enabled then
            NugRunning.debug:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            NugRunning.debug.enabled = true
            print("[NugRunning] Enabled combat log event display")
        else
            NugRunning.debug:UnregisterAllEvents()
            NugRunning.debug.enabled = false
            print("[NugRunning] Disabled combat log event display")
        end
    end,
}

function NugRunning.SlashCmd(msg)
    local k,v = string.match(msg, "([%w%+%-%=]+) ?(.*)")
    if not k or k == "help" then print([[Usage:
        |cff00ff00/nrun lock|r
        |cff00ff00/nrun unlock|r
        |cff00ff00/nrun reset|r
        |cff00ff00/nrun clear|r
        |cff00ff00/nrun debug|r
        |cff00ff00/nrun charspec|r : enable character specific settings
        |cff00ff00/nrun misses|r : toggle misses (immunes, resists)
        |cff00ff00/nrun cooldowns|r : toggle showing cooldowns
        |cff00ff00/nrun spelltext|r : toggle spell text on bars
        |cff00ff00/nrun shorttext|r : toggle using short names
        |cff00ff00/nrun nameplates|r : toggle nameplate timers
        |cff00ff00/nrun localnames|r: toggle localized spell names
        |cff00ff00/nrun set|r width=150 height=20 growth=up/down

        |cff00ff00/nrun createanchor|r anchor=anchorName
        |cff00ff00/nrun deleteanchor|r anchor=anchorName
        |cff00ff00/nrun anchorset|r anchor=anchorName growth=<up/down>

        |cff00ff00/nrun creategroup|r group=groupName anchor=anchorName
        |cff00ff00/nrun deletegroup|r group=groupName
        |cff00ff00/nrun listgroups|r
        |cff00ff00/nrun groupset|r group=groupName [gap=10 alpha=0.9 order=1 anchor=anchorName]
        ]]
    )end
    if NugRunning.Commands[k] then
        NugRunning.Commands[k](v)
    end

end

function NugRunning:CreateAnchor(name, opts)
    local f = CreateFrame("Frame",nil,UIParent)
    f:SetHeight(20)
    f:SetWidth(20)
    f:EnableMouse(true)
    f:SetMovable(true)
    f:Hide()

    local t = f:CreateTexture(nil,"BACKGROUND")
    t:SetTexture("Interface\\Buttons\\UI-RadioButton")
    t:SetTexCoord(0,0.25,0,1)
    t:SetAllPoints(f)

    t = f:CreateTexture(nil,"BACKGROUND")
    t:SetTexture("Interface\\Buttons\\UI-RadioButton")
    t:SetTexCoord(0.25,0.49,0,1)
    t:SetVertexColor(1, 0, 0)
    t:SetAllPoints(f)

    local label = f:CreateFontString(nil,"ARTWORK")
    label:SetFontObject("GameFontNormal")
    label:SetText("DRAG ->")
    label:SetPoint("RIGHT", f, "LEFT", 0,0)

    if not NRunDB.anchors[name] then
        NRunDB.anchors[name] = { point = "CENTER", parent ="UIParent", to = "CENTER", x = 0, y = 0}
    end
    f.db_tbl = NRunDB.anchors[name]
    f:SetScript("OnMouseDown",function(self)
        self:StartMoving()
    end)
    f:SetScript("OnMouseUp",function(self)
            local pos = self.db_tbl
            self:StopMovingOrSizing();
            local point,_,to,x,y = self:GetPoint(1)
            pos.point = point
            pos.parent = "UIParent"
            pos.to = to
            pos.x = x
            pos.y = y
    end)

    local pos = f.db_tbl
    if not _G[pos.parent] then
        pos = { point = "CENTER", parent = "UIParent", to = "CENTER", x = 0, y = 0}
    end
    f:SetPoint(pos.point, pos.parent, pos.to, pos.x, pos.y)
    return f
end


do
    -- It updates timers with UnitAura data on UNIT_AURA and PLAYER_TARGET_CHANGED events
    -- At this point this piece already became very important,
    -- and also i can abandon hope that blizzard will fix combat log refresh someday.
    local filters = { harmful, helpful }
    local targetTimers = {}

    local h = CreateFrame("Frame")
    local hUnits = {
        ["player"] = 0,
        ["target"] = 1,
        ["focus"] = 2,
        ["mouseover"] = 2,
        ["boss1"] = 2,
        ["boss2"] = 2,
        ["arena1"] = 2,
        ["arena2"] = 2,
        ["arena3"] = 2,
        ["arena4"] = 2,
        ["arena5"] = 2,
    }

    local function UnitAffiliationCheck(unit, affiliation)
        if not affiliation then return unit == "player" end
        if unit == "player" then return true end
        if not unit then return affiliation == AFFILIATION_OUTSIDER end
        if affiliation == AFFILIATION_OUTSIDER then return true end
        if string.find(unit, "raid") then return affiliation == AFFILIATION_PARTY_OR_RAID end
        if string.find(unit, "party") then return affiliation == AFFILIATION_PARTY_OR_RAID end
    end
    NugRunning.UnitAffiliationCheck = UnitAffiliationCheck

    local last_taget_update = 0
    local present_spells = {}
    local function UpdateUnitAuras(unit)

            if not (unit == "player" or unit == "target" or unit == "mouseover" or string.sub(unit, 1, 9) == "nameplate") then
                return
            end
            local unitGUID = UnitGUID(unit)

            local now = GetTime()
            -- if up == 1 then --throttle target updates
                -- if now - last_taget_update < 200 then return end
            -- end

            -- for timer in pairs(active) do
            --     if  timer.dstGUID == unitGUID and
            --         (timer.timerType == "BUFF" or timer.timerType == "DEBUFF")
            --     then
            --             NugRunning:SetUnitAuraValues(timer, timer.spellID, UnitAura(unit, GetSpellInfo(timer.spellID), nil, timer.filter))
            --     end
            -- end
            table_wipe(present_spells)

            for _, filter in ipairs(filters) do
                local timerType = filter == "HELPFUL" and "BUFF" or "DEBUFF"
                for i=1,200 do
                    local name, icon, count, dispelType, duration, expirationTime, caster, isStealable, shouldConsolidate, aura_spellID = UnitAura(unit, i, filter)
                    if not name then break end

                    local opts = spells[aura_spellID]
                    if opts and UnitAffiliationCheck(caster, opts.affiliation) then--and (unit ~= "mouseover" or not opts.singleTarget) then

                            local timer
                            timer = gettimer(active, name, unitGUID, timerType)
                            if timer then
                                if duration ~= 0 then
                                    NugRunning:SetUnitAuraValues(timer, timer.spellID, name, icon, count, dispelType, duration, expirationTime, caster, isStealable, shouldConsolidate, aura_spellID)
                                else
                                    -- print("setting timer ",name, timer.spellID,  "to", aura_spellID)
                                    NugRunning:UpdateTimerToSpellID(timer, aura_spellID)
                                end
                            end

                        present_spells[opts] = true
                    end
                end
            end
            for timer in pairs(active) do
                local opts = timer.opts
                if  timer.dstGUID == unitGUID and
                    timer.srcGUID == playerGUID and
                    not present_spells[opts] and
                    (timer.timerType == "BUFF" or timer.timerType == "DEBUFF")
                then
                    if not opts._skipunitaura then
                        free[timer] = true
                    end
                    NugRunning:ArrangeTimers()
                end
            end
    end
    NugRunning.UpdateUnitAuras = UpdateUnitAuras

    function NugRunning.OnAuraEvent(self, event, unit)
        if event == "UNIT_AURA" then
            return UpdateUnitAuras(unit)
        elseif event == "PLAYER_TARGET_CHANGED" then
            if UnitExists("target") then
                return UpdateUnitAuras("target")
            end
            --[[
        elseif event == "UPDATE_MOUSEOVER_UNIT" then
            return UnitExists("mouseover") and UpdateUnitAuras("mouseover")
        elseif event == "PLAYER_TARGET_CHANGED" then
            -- updating timers from target unit when possible
            local targetGUID = UnitGUID("target")
            if not targetGUID then return end
            table_wipe(targetTimers)
            for timer in pairs(active) do
                if timer.dstGUID == targetGUID then
                    -- if (timer.srcGUID == playerGUID or timer.opts.affiliation) then
                        table.insert(targetTimers, timer)
                    -- end
                else
                    if timer.opts.singleTarget then
                        timer.isGhost = true
                        timer.expiredGhost = true
                        free[timer] = true
                        timer.isGhost = nil
                        timer.expiredGhost = nil
                    end
                end
            end

            for _, filter in ipairs(filters) do
                for i=1,100 do
                    local name, _, count, _, duration, expirationTime, caster, _,_, aura_spellID = UnitAura("target", i, filter)
                    if not name then break end

                    local opts = spells[aura_spellID]
                    if opts and UnitAffiliationCheck(caster, opts.affiliation) then
                        if opts.target and opts.target ~= "target" then return end
                        local found, timerType
                        -- searching in generated earlier table of player->target timers for matching spell
                        for _, timer in ipairs(targetTimers) do
                            if  timer.spellID == aura_spellID then
                                found = true
                                timerType = timer.timerType
                                break
                            end
                        end
                        local newtimer
                        if duration == 0 then duration = -1 end
                        if found then
                            newtimer = NugRunning:RefreshTimer(playerGUID, targetGUID, UnitName("target"), nil, aura_spellID, name, spells[aura_spellID], timerType, duration, count, true)
                        else
                            timerType = filter == "HELPFUL" and "BUFF" or "DEBUFF"
                            newtimer = NugRunning:ActivateTimer(playerGUID, targetGUID, UnitName("target"), nil, aura_spellID, name, spells[aura_spellID], timerType, duration, count, true)
                        end
                        if newtimer and not newtimer.timeless then newtimer:SetTime( expirationTime - duration, expirationTime, newtimer.fixedoffset) end
                        if newtimer and newtimer.opts.maxtimers then
                            newtimer._touched = GetTime()
                        end
                    end
                end
            end
            ]]
        end
    end
    h:SetScript("OnEvent", NugRunning.OnAuraEvent)
    h:RegisterEvent("UNIT_AURA")
    -- h:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
    h:RegisterEvent("PLAYER_TARGET_CHANGED")


    -- h._elapsed = 0
    -- h:SetScript("OnUpdate", function(self, time)
    --     self._elapsed = self._elapsed + time
    --     if self._elapsed < 0.2 then return end
    --     self._elapsed = 0

    --     NugRunning.OnAuraEvent(nil, "UNIT_AURA", "mouseover")
    -- end)
end


function NugRunning:CreateCastbarTimer(timer)
    local f = timer
    NugRunning.free[timer] = nil
    self.castbar = timer

    f.stacktext:Hide()
    -- f:SetScript("OnUpdate",TimerOnUpdate)
    f.unit = "player"
    f.dstGUID = UnitGUID("player")
    f.srcGUID = UnitGUID("player")
    f.dontfree = true
    -- f.priority = 9001
    f.opts = {}


    f:RegisterEvent("UNIT_SPELLCAST_START")
    f:RegisterEvent("UNIT_SPELLCAST_DELAYED")
    -- f:RegisterEvent("PLAYER_TARGET_CHANGED")
    f:RegisterEvent("UNIT_SPELLCAST_STOP")
    f:RegisterEvent("UNIT_SPELLCAST_FAILED")
    f:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
    f:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
    f:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
    f:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")

    f:SetScript("OnEvent", function(self, event, ...)
        return f[event](self, event, ...)
    end)

    f.UpdateCastingInfo = function(self,name, texture, startTimeInt, endTimeInt, opts)
        local timer = self

        self.opts = opts
        self.priority = opts.priority or 0
        -- timer.fixedoffset = opts.fixedlen and time - opts.fixedlen or 0

        self:SetColor(unpack(opts.color or { 0.6, 0, 1 }))
        self.icon:SetTexture(texture)
        self.spellText:SetText(NugRunning:MakeName(opts, name))

        if opts.tick and NRunDB.dotticks then
            timer.tickPeriod = opts.tick > 0 and (opts.tick/(1+(UnitSpellHaste("player")/100))) or math.abs(opts.tick)
            timer.mark.fullticks = nil
        else
            timer.tickPeriod = nil
        end

        if timer.VScale then
            local scale = opts.scale
            if scale then
                timer:VScale(scale)
            else
                timer:VScale(1)
            end
        end

        local startTime = startTimeInt /1000
        local endTime = endTimeInt /1000
        local duration = endTime - startTime
        timer.fixedoffset = timer.opts.fixedlen and duration - timer.opts.fixedlen or 0
        timer:SetTime(startTime, startTime + duration, timer.fixedoffset)

        local arrow = opts.arrow
        if arrow then
            local color = arrow[3] and arrow or {1,0,0}
            timer.arrow:SetVertexColor(unpack(color))
            timer.arrow:Show()
        else
            timer.arrow:Hide()
        end
        -- self.startTime = startTime / 1000
        -- self.endTime = endTime / 1000
        -- self.bar:SetMinMaxValues(self.startTime,self.endTime)
        -- local color = NRunCast.coloredSpells[name] or  { 0.6, 0, 1 }
        -- local color = { 0.6, 0, 1 }
        -- self.bar:SetStatusBarColor(unpack(color))
        -- self.bar.bg:SetVertexColor(color[1]*.5,color[2]*.5,color[3]*.5)
        self:Show()
    end


    function f.UNIT_SPELLCAST_START(self,event, unit, castID, spellID)
        if unit ~= self.unit then return end
        if not config.casts[spellID] then return end
        local opts = config.casts[spellID]
        if opts.disabled then return end

        local name, text, texture, startTime, endTime, isTradeSkill, castID2, notInterruptible = CastingInfo()
        self.inverted = false
        self.castID = castID2
        self:UpdateCastingInfo(name,texture,startTime,endTime, opts)
        NugRunning.active[self] = true
        NugRunning:ArrangeTimers()
    end
    f.UNIT_SPELLCAST_DELAYED = f.UNIT_SPELLCAST_START
    function f.UNIT_SPELLCAST_CHANNEL_START(self,event, unit, castID, spellID)
        if unit ~= self.unit then return end
        if not config.casts[spellID] then return end
        local opts = config.casts[spellID]
        if opts.disabled then return end

        local name, text, texture, startTime, endTime, isTradeSkill, castID2, notInterruptible = ChannelInfo()
        self.inverted = true
        self.castID = castID2
        self:UpdateCastingInfo(name,texture,startTime,endTime, opts)

        NugRunning.active[self] = true
        NugRunning:ArrangeTimers()
    end
    f.UNIT_SPELLCAST_CHANNEL_UPDATE = f.UNIT_SPELLCAST_CHANNEL_START
    function f.UNIT_SPELLCAST_STOP(self,event, unit, castID, spellID)
        if unit ~= self.unit then return end
        self:Hide()
        NugRunning.active[self] = nil
        NugRunning:ArrangeTimers()
    end
    function f.UNIT_SPELLCAST_FAILED(self, event, unit,castID)
        if unit ~= self.unit then return end
        if self.castID == castID then self.UNIT_SPELLCAST_STOP(self, event, unit, nil) end
    end
    f.UNIT_SPELLCAST_INTERRUPTED = f.UNIT_SPELLCAST_STOP
    f.UNIT_SPELLCAST_CHANNEL_STOP = f.UNIT_SPELLCAST_STOP


    function f.PLAYER_TARGET_CHANGED(self)
        local newguid = UnitGUID("target") or UnitGUID("player")
        self.dstGUID = newguid
        NugRunning:ArrangeTimers()
    end
end

local Enum_PowerType_ComboPoints = Enum.PowerType.ComboPoints
function NugRunning.UNIT_POWER_UPDATE(self,event,unit, ptype)
    if ptype == "COMBO_POINTS" then
        self.cpWas = self.cpNow or 0
        self.cpNow = GetComboPoints(unit, "target")
    end
end