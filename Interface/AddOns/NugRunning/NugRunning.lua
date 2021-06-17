local _, helpers = ...

local NugRunning = CreateFrame("Frame","NugRunning", UIParent)

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
local apiLevel = math.floor(select(4,GetBuildInfo())/10000)
local isClassic = apiLevel <= 3
local isBC = apiLevel == 2
local isMainline = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE -- WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
-- local isClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC

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
local UpdateUnitAuras
local playerGUID
local alltimers = {}
local timersByGUID = {}
local timersByGUIDCounter = {}
local active = {}
local free = {}

function NugRunning:SetActive(timer)
    rawset(free,timer,nil)
    rawset(active,timer,true)
    if not timer.isExternal then
        NugRunning:AddTimerToGUID(timer.dstGUID, timer)
    end
end

function NugRunning:FreeTimer(timer, skipGhost)
    if timer.opts then
        if timer.opts.with_cooldown then
            local cd_opts = timer.opts.with_cooldown
            config.cooldowns[cd_opts.id] = cd_opts
            NugRunning:SPELL_UPDATE_COOLDOWN()
        else
            if not skipGhost then
                if NRunDB.leaveGhost and (timer.opts.ghost or timer.scheduledGhost) and not timer.isGhost then return timer:BecomeGhost() end
                if timer.isGhost and not timer.expiredGhost then return end
            end
            timer.isGhost = nil
            timer.expiredGhost = nil
        end
    end
    timer:Hide()

    rawset(active,timer,nil)

    if not timer.isExternal then
        free[timer] = true
        NugRunning:RemoveTimerFromGUID(timer.dstGUID, timer)
    end
    NugRunning:ArrangeTimers()
end

function NugRunning:FindFirstActiveTimer(spellID)
    for timer in pairs(active) do
        if timer.spellID == spellID and not timer.isGhost then
            return timer
        end
    end
end

local gettimer = function(self,spellID,dstGUID,timerType)
    local foundTimer
    local spellActiveTimers = 0
    if type(spellID) == "number" then
        local baseSpellID = config.spellClones[spellID] or spellID
        for timer in pairs(self) do
            if timer.baseSpellID == baseSpellID and timer.timerType == timerType then
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
local GetSpellCooldown = GetSpellCooldown
local GetSpellCharges = GetSpellCharges
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local bit_band = bit.band
local strfind = string.find
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

local defaultFont = "AlegreyaSans-Medium"
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
            x = 0,
            y = 0,
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
    height = 20,
    np_height = 7,
    np_width = 74,
    np_xoffset = 0,
    np_yoffset = 0,
    cooldownsEnabled = true,
    missesEnabled = true,
    targetTextEnabled = false,
    spellTextEnabled = true,
    shortTextEnabled = true,
    swapTarget = true,
    localNames = defaultShowLocalNames,
    totems = true,
    leaveGhost = true,
    nameplates = true,
    preghost = true,
    dotpower = true,
    dotticks = true,
    textureName = "Aluminium",
    nptextureName = "Aluminium",
    nameFont = { font = defaultFont, size = 10, alpha = 0.5, outline = false },
    timeFont = { font = defaultFont, size = 8, alpha = 1, outline = false },
    stackFont = { font = defaultFont, size = 12, outline = true },
}


local MergeTable = helpers.MergeTable
local RemoveDefaultsPreserve = helpers.RemoveDefaultsPreserve
local RemoveDefaults = helpers.RemoveDefaults
local SetupDefaults = helpers.SetupDefaults
NugRunning.SetupDefaults = SetupDefaults
NugRunning.RemoveDefaults = RemoveDefaults
NugRunning.RemoveDefaultsPreserve = RemoveDefaultsPreserve
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

    NugRunningConfigCustom = NugRunningConfigCustom or {}

    NugRunningConfigMerged = CopyTable(NugRunningConfig)

    local _, class = UnitClass("player")
    local categories = {"spells", "cooldowns", "activations", "casts"}
    if not NugRunningConfigCustom[class] then NugRunningConfigCustom[class] = {} end

    local function fixRemovedDefaultSpells(customConfig, defaultConfig)
        if not (customConfig and defaultConfig) then return end
        local toRemove = {}
        for spellID, opts in pairs(customConfig) do
            local dopts = defaultConfig[spellID]
            if not dopts and not opts.name then
                table.insert(toRemove, spellID)
            elseif opts.name then -- then it's a is probably an added spell
                opts.isAdded = true -- making sure it's marked as added
            end
        end
        for _, spellID in ipairs(toRemove) do
            customConfig[spellID] = nil
        end
    end

    local globalConfig = NugRunningConfigCustom["GLOBAL"]
    if globalConfig then
        for _, category in ipairs(categories) do
            fixRemovedDefaultSpells(globalConfig[category], config[category])
        end
    end
    MergeTable(NugRunningConfigMerged, globalConfig)
    local classConfig = NugRunningConfigCustom[class]
    if classConfig then
        for _, category in ipairs(categories) do
            fixRemovedDefaultSpells(classConfig[category], config[category])
        end
    end
    MergeTable(NugRunningConfigMerged, classConfig)
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
                opts.clones[spellID] = nil -- Removing possible input of original spell ID into clone list
                for i, additionalSpellID in ipairs(opts.clones) do
                    tempTable[additionalSpellID] = opts
                    cloneIDs[additionalSpellID] = spellID
                end
            end
        end
        for spellID, opts in pairs(tempTable) do
            config[category][spellID] = opts
        end
    end
    config.spellClones = cloneIDs

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
    NugRunning:RegisterEvent("UNIT_AURA")
    if apiLevel > 1 then NugRunning:RegisterEvent("UPDATE_MOUSEOVER_UNIT") end


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
        timer:Release()
    end
    --remove timer from the pool and change it to castbar
    local cbt = NugRunning:ExtractFromPool()
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




--------------------
-- CLEU dispatcher
--------------------
function NugRunning.COMBAT_LOG_EVENT_UNFILTERED( self, event )

    local timestamp, eventType, hideCaster,
    srcGUID, srcName, srcFlags, srcFlags2,
    dstGUID, dstName, dstFlags, dstFlags2,
    spellID, spellName, spellSchool, auraType, amount = CombatLogGetCurrentEventInfo()

    if spells[spellID] then
        local affiliationStatus = (bit_band(srcFlags, AFFILIATION_MINE) == AFFILIATION_MINE)
        local opts = spells[spellID]
        if not affiliationStatus and opts.affiliation then
            affiliationStatus = (bit_band(srcFlags, COMBATLOG_OBJECT_AFFILIATION_MASK) <= opts.affiliation)
        end
        if opts.target and dstGUID ~= UnitGUID(opts.target) then return end
        if affiliationStatus then
            if eventType == "SPELL_AURA_REFRESH" then
                self:RefreshTimer(srcGUID, dstGUID, dstName, dstFlags, spellID, spellName, opts, auraType, nil, amount)
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

    if check_event_timers then
        if event_timers[spellID] then
            local opts = event_timers[spellID]
            local opts_event = opts.event
            if opts_event == eventType or (type(opts_event) == "table" and opts_event[eventType]) then
                local affiliationStatus = (bit_band(srcFlags, AFFILIATION_MINE) == AFFILIATION_MINE)
                if affiliationStatus or (opts.affiliation and bit_band(srcFlags, COMBATLOG_OBJECT_AFFILIATION_MASK) <= opts.affiliation ) then
                    -- if spellID == opts.spellID then
                        if dstGUID == "" then dstGUID = srcGUID end
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
---------------------------
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
if isClassic then
    local _, class = UnitClass("player")
    if class == "WARLOCK" or class == "MAGE" or class == "PRIEST" then
        wandUserMinDuration = 3
    end
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
            if timer and timer:IsActive() then
                local oldcdrem = timer.endTime - GetTime()
                if oldcdrem > duration or oldcdrem < 0 then
                    if not timer.isGhost then
                        timer:Release()
                        if timer.isGhost and not timer.shine:IsPlaying() then timer.shine:Play() end
                        activeCooldownTimers[spellID] = nil
                    end
                end
            end
        else
                if not timer or not timer:IsActive() or timer.isGhost then
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
                            timer:GhostExpire()
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
                    -- print("1", spellID, startTime, duration)
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
    if isMainline then
        gcdDuration = select(2,GetSpellCooldown(61304)) -- gcd spell
    end

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
                deltimer:Release()
            end
        else
            return
        end
    end

    timer = NugRunning:AcquireTimer()
    if not timer then return end

    timer.srcGUID = srcGUID
    timer.dstGUID = dstGUID
    timer.dstName = dstName
    timer.spellID = spellID
    timer.baseSpellID = config.spellClones[spellID] or spellID
    timer.spellName = spellName
    timer.timerType = timerType
    timer:SetActive(true)
    timer:SetScript("OnUpdate",NugRunning.TimerFunc)

    if multiTargetGUID then timer.targets[multiTargetGUID] = true end

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

        local plevel = self:GetPowerLevel(spellID)
        timer.powerLevel = plevel
        self:UpdateTimerPower(timer, plevel)
    end

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
        -- print( "DEFAULT TIME", spellName, time, timerType)
        if timerType == "BUFF" or timerType == "DEBUFF" then
            local _guid = multiTargetGUID or dstGUID
            local uaTime, uaCount = NugRunning.QueueAura(spellID, _guid, timerType, timer)
            if uaTime then
                time = uaTime
                amount = uaCount
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
            nameText = override:sub(1,1)..override:sub(2):lower()
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
        if timerType == "BUFF" or timerType == "DEBUFF" then
            local _guid = dstGUID or multiTargetGUID
            NugRunning.QueueAura(spellID, _guid, timerType, timer)
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

    if not ignore_applied_dose then
        if opts.tick and NRunDB.dotticks then
            timer.tickPeriod = opts.tick > 0 and (opts.tick/(1+(UnitSpellHaste("player")/100))) or math.abs(opts.tick)
            timer.mark.fullticks = nil
        else
            timer.tickPeriod = nil
        end

        local plevel = self:GetPowerLevel(spellID)
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
            timer:Release()
            self:ArrangeTimers()
            return
        end
    end
end

local function free_noghost(timer)
    timer._elapsed = 2.5
    timer:Release()
end
function NugRunning.DeactivateTimersOnDeath(self,dstGUID)
    for timer in pairs(active) do
        if spells[timer.spellID] then
        if not timer.dstGUID then -- clearing guid from multi target list just in case
            timer.targets[dstGUID] = nil
            if not next(timer.targets) then timer:Release("NOGHOST") end
        elseif timer.dstGUID == dstGUID then timer:Release("NOGHOST") end
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

function NugRunning.SetUnitAuraValues(self, timer, spellNameOrID, name, icon, count, dispelType, duration, expirationTime, caster, isStealable, shouldConsolidate, aura_spellID, canApplyAura, isBossDebuff)
            if aura_spellID then
                if aura_spellID == spellNameOrID and NugRunning.UnitAffiliationCheck(caster, timer.opts.affiliation) then
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
                                local plevel = self:GetPowerLevel(aura_spellID)
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
            self:Release()
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

function NugRunning:AcquireTimer()
    return next(free)
end

function NugRunning:ExtractFromPool()
    local timer = self:AcquireTimer()
    timer.isExternal = true
    free[timer] = nil
    return timer
end

local TimerManagementMixin = {}
function TimerManagementMixin.Release(self, skipGhost)
    NugRunning:FreeTimer(self, skipGhost)
end

function TimerManagementMixin.SetActive(self, status)
    NugRunning:SetActive(self, true)
end
function TimerManagementMixin.IsActive(self)
    return active[self] ~= nil
end

function TimerManagementMixin.GhostExpire(self)
    self:SetScript("OnUpdate", NugRunning.TimerFunc)
    self.expiredGhost = true
    if self.glow:IsPlaying() then self.glow:Stop() end
    self.arrow:Hide()
    if self.arrowglow:IsPlaying() then
        self.arrowglow:Stop()
    end
    self:Release()
    self.isGhost = nil
end

local function GhostFunc(self,time)
    self._elapsed = self._elapsed + time
    if self._elapsed < self.ghost_duration then return end

    self:GhostExpire()
end

function TimerManagementMixin.BecomeGhost(self, override_ghost_duration)
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
    self:SetScript("OnUpdate", GhostFunc)
end

function NugRunning.CreateTimer(self)
    local w = NugRunningConfig.width or NRunDB.width
    local h = NugRunningConfig.height or NRunDB.height

    local f = NugRunning.ConstructTimerBar(w,h)
    f = Mixin(f, TimerManagementMixin)

    f._elapsed = 0
    f._width = w
    f._height = h

    f:SetScript("OnUpdate", NugRunning.TimerFunc)

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
        doswap = NRunDB.swapTarget
        anchors = NugRunning.anchors -- frames
        dbanchors = NRunDB.anchors -- settings

        targetIndicator = NugRunning.targetIndicator

        yOffset = helpers.pixelperfect(3.99, self)

        sortedTimerGroups = NugRunning:MakeSortedGroupsTable()
    end

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
    NugRunning.sortfunc = sortfunc

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
            if custom_group and custom_group ~= "default" then
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
                            timer:ClearAllPoints()
                            timer:SetPoint(point, prev or anchorFrame, prev and to  or "TOPRIGHT", xOffset, (yOffset+gap)*ySign)
                            if timer.onupdate then timer:onupdate() end
                            prev = timer
                            gap = 0
                        end

                        if not doswap and guid == targetGUID then
                            local lastTimer = group_timers[1]
                            local firstTimer = group_timers[#group_timers]
                            if growth == "down" then
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
                        timer:ClearAllPoints()
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
            nameplates:Update(timersByGUID)
        end
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
            timer:GhostExpire()
        end
        previous_projections[timer] = nil
    end
    if UnitExists("target") and UnitAffectingCombat("player") then
        for spellID, opts in pairs(spells) do
            if opts.preghost and not config.spellClones[spellID] then
                local checkfunc = opts.isknowncheck or IsAvailable
                if checkfunc(spellID) then
                    -- Even on BCC it's required to search by name/opts because spell ranks
                    -- local spellIdOrName = isClassic and GetSpellInfo(spellID) or spellID
                    local timer = gettimer(active, opts, UnitGUID("target"), "DEBUFF")
                    if not timer then
                        local someDuration = type(opts.duration) == "number" and opts.duration or 5
                        timer = self:ActivateTimer(playerGUID, UnitGUID("target"), UnitName("target"), nil, spellID, GetSpellInfo(spellID), opts, "DEBUFF", someDuration, nil, true)
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

function NugRunning:UNIT_AURA(event, unit)
    UpdateUnitAuras(unit)
end

function NugRunning:UPDATE_MOUSEOVER_UNIT()
    if UnitExists("mouseover") then
        UpdateUnitAuras("mouseover")
    end
end

function NugRunning:PLAYER_TARGET_CHANGED()
    if apiLevel > 1 then
        NugRunning:CancelSingleTargetTimers()
    end
    UpdateUnitAuras("target")
    if NRunDB.preghost then self:PreGhost() end
    self:ArrangeTimers()
end


do
    local bleedPowerLevel = 0
    local ripPowerLevel = 0
    function NugRunning:GetPowerLevel(spellID)
        if spellID == 1079 then
            return ripPowerLevel
        end
        return bleedPowerLevel
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
        bleedPowerLevel = 0
        ripPowerLevel = 0
        for i=1, 100 do
            local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, spellID = UnitAura("player", i, "HELPFUL")
            if not name then return bleedPowerLevel, ripPowerLevel end
            if spellID == 5217 then -- Tiger's fury
                bleedPowerLevel = bleedPowerLevel + 15
                ripPowerLevel = ripPowerLevel + 15
            elseif spellID == 145152 then -- Bloodtalons
                ripPowerLevel = ripPowerLevel + 25
            end
        end
        return bleedPowerLevel, ripPowerLevel
    end

    local dotpowerFrame = CreateFrame("Frame", nil, UIParent)
    NugRunning.dotpowerFrame = dotpowerFrame
    dotpowerFrame:SetScript("OnEvent", function()
        local bleedPowerLevel, ripPowerLevel = UpdatePowerLevel()
        for timer in pairs(active) do
            if timer.opts.showpower and timer.powerLevel and not timer.isGhost then
                -- timer:SetName(timer.powerLevel)
                if timer.spellID == 1079 then
                    NugRunning:UpdateTimerPower(timer, ripPowerLevel)
                else
                    NugRunning:UpdateTimerPower(timer, bleedPowerLevel)
                end
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
            timer:Release()
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
            if not timer:IsActive() then
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
        NugRunning:ArrangeTimers()
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
                    if string.sub(eventType, 1, 5) == "SPELL" then
                        print ("ID:", spellID, string.format("|cffff8800%s|r",spellName), eventType, srcFlags, srcGUID,"|cff00ff00==>|r", dstGUID, dstFlags, amount)
                    else
                        print ("ID:", spellID, spellName, eventType, srcFlags, srcGUID,"|cff00ff00==>|r", dstGUID, dstFlags, amount)
                    end
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
    label:SetText(string.format("%s ->", name))
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



function NugRunning.UnitAffiliationCheck(unit, affiliation)
    if not affiliation then return unit == "player" end
    if unit == "player" then return true end
    if not unit then return affiliation == AFFILIATION_OUTSIDER end
    if affiliation == AFFILIATION_OUTSIDER then return true end
    if string_sub(unit, 1, 4) == "raid" then return affiliation == AFFILIATION_PARTY_OR_RAID end
    if string_sub(unit, 1, 5) == "party" then return affiliation == AFFILIATION_PARTY_OR_RAID end
end
local UnitAffiliationCheck = NugRunning.UnitAffiliationCheck

do
    -- It updates timers with UnitAura data on UNIT_AURA and PLAYER_TARGET_CHANGED events
    -- At this point this piece already became very important,
    -- and also i can abandon hope that blizzard will fix combat log refresh someday.
    local filters = { harmful, helpful }

    local scanUnits = {
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
    for i=1,30 do
        local npUnit = "nameplate"..i
        scanUnits[npUnit] = 2
    end

    local present_spells = {}
    function NugRunning.UpdateUnitAuras(unit)
            local unitPrio = scanUnits[unit]
            local unitGUID = UnitGUID(unit)
            if not timersByGUIDCounter[unitGUID] and not unitPrio then return end

            if unitPrio == 2 and UnitIsUnit(unit, "target") then return end -- Skip double checks on target

            local now = GetTime()

            table_wipe(present_spells)

            for _, filter in ipairs(filters) do
                local timerType = filter == "HELPFUL" and "BUFF" or "DEBUFF"
                for i=1,200 do
                    local name, icon, count, dispelType, duration, expirationTime, caster, isStealable, shouldConsolidate, aura_spellID = UnitAura(unit, i, filter)
                    if not name then break end

                    local opts = spells[aura_spellID]
                    if opts and UnitAffiliationCheck(caster, opts.affiliation) then--and (unit ~= "mouseover" or not opts.singleTarget) then

                            local timer
                            timer = gettimer(active, opts, unitGUID, timerType)
                            if duration == 0 then duration = -1 end
                            if timer then
                                NugRunning:SetUnitAuraValues(timer, timer.spellID, name, icon, count, dispelType, duration, expirationTime, caster, isStealable, shouldConsolidate, aura_spellID)
                            else
                                timer = NugRunning:ActivateTimer(playerGUID, unitGUID, UnitName(unit), nil, aura_spellID, name, opts, timerType, duration, count, true)
                                if timer and not timer.timeless then
                                timer:SetTime( expirationTime - duration, expirationTime, timer.fixedoffset)
                                end
                            end

                        present_spells[opts] = true
                    end
                end
            end
            for timer in pairs(active) do
                if  timer.dstGUID == unitGUID and
                    timer.srcGUID == playerGUID and
                    not present_spells[timer.opts] and
                    (timer.timerType == "BUFF" or timer.timerType == "DEBUFF")
                then
                    timer:Release()
                    NugRunning:ArrangeTimers()
                end
            end
    end
    UpdateUnitAuras = NugRunning.UpdateUnitAuras -- init upvalue
end

function NugRunning:CancelSingleTargetTimers()
    local targetGUID = UnitGUID("target")
    if not targetGUID then return end

    for timer in pairs(active) do
        if timer.dstGUID ~= targetGUID and timer.opts.singleTarget then
            timer:Release("NoGhost")
        end
    end
end


function NugRunning:CreateCastbarTimer(timer)
    local f = timer
    self.castbar = timer

    f.stacktext:Hide()
    -- f:SetScript("OnUpdate",TimerOnUpdate)
    f.unit = "player"
    f.dstGUID = UnitGUID("player")
    f.srcGUID = UnitGUID("player")
    f.dontfree = true
    f.isExternal = true
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

        self:Show()
    end


    function f.UNIT_SPELLCAST_START(self,event, unit, castID, spellID)
        if unit ~= self.unit then return end
        if not config.casts[spellID] then return end
        local opts = config.casts[spellID]
        if opts.disabled then return end

        local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo(unit)
        self.inverted = false
        self.castID = castID
        self:UpdateCastingInfo(name,texture,startTime,endTime, opts)
        self:SetActive(true)
        NugRunning:ArrangeTimers()
    end
    f.UNIT_SPELLCAST_DELAYED = f.UNIT_SPELLCAST_START
    function f.UNIT_SPELLCAST_CHANNEL_START(self,event, unit, castID, spellID)
        if unit ~= self.unit then return end
        if not config.casts[spellID] then return end
        local opts = config.casts[spellID]
        if opts.disabled then return end

        local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitChannelInfo(unit)
        self.inverted = true
        self.castID = castID
        self:UpdateCastingInfo(name,texture,startTime,endTime, opts)

        self:SetActive(true)
        NugRunning:ArrangeTimers()
    end
    f.UNIT_SPELLCAST_CHANNEL_UPDATE = f.UNIT_SPELLCAST_CHANNEL_START
    function f.UNIT_SPELLCAST_STOP(self,event, unit, castID, spellID)
        if unit ~= self.unit then return end
        self:Release()
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
        self.cpNow = UnitPower("player", Enum_PowerType_ComboPoints)
    end
end



function NugRunning:FindActiveTimer(...)
    return gettimer(active, ...)
end
-------------------------------
-- By GUID timer table
-------------------------------
function NugRunning:RecountGUIDTimers(t)
    local count = 0
    for k,v in pairs(t) do
        if type(k) == "table" then
            count = count + 1
        end
    end
    return count
end
function NugRunning:AddTimerToGUID(dstGUID, timer)
    if not dstGUID then return end

    local guidTimers = timersByGUID[dstGUID]
    if not guidTimers then
        timersByGUID[dstGUID] = {}
        guidTimers = timersByGUID[dstGUID]
    end
    guidTimers[timer] = true
    local newCount = self:RecountGUIDTimers(guidTimers)
    timersByGUIDCounter[dstGUID] = newCount
end
function NugRunning:RemoveTimerFromGUID(dstGUID, timer)
    if not dstGUID then return end

    local guidTimers = timersByGUID[dstGUID]
    if not guidTimers then return end
    guidTimers[timer] = nil
    local newCount = self:RecountGUIDTimers(guidTimers)
    if newCount > 0 then
        timersByGUIDCounter[dstGUID] = newCount
    else
        timersByGUIDCounter[dstGUID] = nil
        timersByGUID[dstGUID] = nil
    end
end
do
    local emptyTable = {}
    function NugRunning:GetActiveTimersByGUID(dstGUID)
        if not dstGUID then return emptyTable end
        local guidTimers = timersByGUID[dstGUID]
        if not guidTimers then return emptyTable end
        return guidTimers
    end
end

-- function NugRunning.GetTimersByGUID(self, dstGUID)
--     return timersByGUID[dstGUID]
-- end