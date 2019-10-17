
if IsAddOnLoaded('ClassicSpellActivations') then return; end		--bf@178.com

local addonName, ns = ...

local f = CreateFrame("Frame", nil) --, UIParent)

f:SetScript("OnEvent", function(self, event, ...)
	if not BigFoot_SysTemSetTab.SpellActivations then return end
	return self[event](self, event, ...)
end)

local UnitGUID = UnitGUID
local bit_band = bit.band
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local AFFILIATION_MINE = COMBATLOG_OBJECT_AFFILIATION_MINE
local _, class = UnitClass("player")

local procCombatLog
local registeredFrames = {}
local activations = {}

local LocalizedOverpower = GetSpellInfo(7384)
local LocalizedRevenge = GetSpellInfo(6572)
local LocalizedRiposte = GetSpellInfo(14251)
local LocalizedCounterattack = GetSpellInfo(19306)
-- local LocalizedExecute = GetSpellInfo(20662)
-- local LocalizedShadowBolt = GetSpellInfo(686)
local LocalizedMongooseBite = GetSpellInfo(1495)
local LBG

local spellNamesByID = {
    [7384] = "Overpower",
    [7887] = "Overpower",
    [11584] = "Overpower",
    [11585] = "Overpower",

    [6572] = "Revenge",
    [6574] = "Revenge",
    [7379] = "Revenge",
    [11600] = "Revenge",
    [11601] = "Revenge",
    [25288] = "Revenge",

    [14251] = "Riposte",

    [19306] = "Counterattack",
    [20909] = "Counterattack",
    [20910] = "Counterattack",

    [20662] = "Execute",
    [20661] = "Execute",
    [20660] = "Execute",
    [20658] = "Execute",
    [5308] = "Execute",

    [686] = "ShadowBolt",
    [695] = "ShadowBolt",
    [705] = "ShadowBolt",
    [1088] = "ShadowBolt",
    [1106] = "ShadowBolt",
    [7641] = "ShadowBolt",
    [11659] = "ShadowBolt",
    [11660] = "ShadowBolt",
    [11661] = "ShadowBolt",
    [25307] = "ShadowBolt",

    [1495] = "MongooseBite",
    [14269] = "MongooseBite",
    [14270] = "MongooseBite",
    [14271] = "MongooseBite",

    [879] = "Exorcism",
    [5614] = "Exorcism",
    [5615] = "Exorcism",
    [10312] = "Exorcism",
    [10313] = "Exorcism",
    [10314] = "Exorcism",

    [24275] = "HammerOfWrath",
    [24274] = "HammerOfWrath",
    [24239] = "HammerOfWrath",
}

f:RegisterEvent("PLAYER_LOGIN")
function f:PLAYER_LOGIN()

    if class == "WARRIOR" or class == "ROGUE" or class == "HUNTER" or class == "WARLOCK" or class == "PALADIN" then
        self:RegisterEvent("SPELLS_CHANGED")
        self:SPELLS_CHANGED()

        local bars = {"ActionButton","MultiBarBottomLeftButton","MultiBarBottomRightButton","MultiBarLeftButton","MultiBarRightButton"}
        for _,bar in ipairs(bars) do
            for i = 1,12 do
                local btn = _G[bar..i]
                self:RegisterForActivations(btn)
            end
        end

        hooksecurefunc("ActionButton_UpdateOverlayGlow", function(self)
            ns.UpdateOverlayGlow(self)
        end)

        local LAB = LibStub("LibActionButton-1.0", true) -- Bartener support
        if LAB then
            LBG = LibStub("LibButtonGlow-1.0", true)
            self:RegisterForActivations(LAB.eventFrame)
            LAB:RegisterCallback("OnButtonUpdate", function(event, self)
                ns.LAB_UpdateOverlayGlow(self)
            end)
        end

        local LAB2 = LibStub("LibActionButton-1.0-ElvUI", true) -- ElvUI support
        if LAB2 then
            LBG = LibStub("LibButtonGlow-1.0", true)
            self:RegisterForActivations(LAB2.eventFrame)
            LAB2:RegisterCallback("OnButtonUpdate", function(event, self)
                ns.LAB_UpdateOverlayGlow(self)
            end)
        end
    end
    -- self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")


end

local UnitAura = UnitAura
local function FindAura(unit, spellID, filter)
    for i=1, 100 do
        local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, auraSpellID = UnitAura(unit, i, filter)
        if not name then return nil end
        if spellID == auraSpellID then
            return name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, auraSpellID
        end
    end
end

local hadShadowTrance
function f:SPELLS_CHANGED()
    if class == "WARRIOR" then
        self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        self:SetScript("OnUpdate", self.timerOnUpdate)
        if ns.findHighestRank("Overpower") and ns.findHighestRank("Revenge") then
            local CheckOverpower = ns.CheckOverpower
            local CheckRevenge = ns.CheckRevenge
            procCombatLog = function(...)
                CheckOverpower(...)
                CheckRevenge(...)
            end
        elseif ns.findHighestRank("Overpower") then
            procCombatLog = ns.CheckOverpower
        elseif ns.findHighestRank("Revenge") then
            procCombatLog = ns.CheckRevenge
        else
            self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            self:SetScript("OnUpdate", nil)
        end

        if ns.findHighestRank("Execute") then
            self:RegisterEvent("PLAYER_TARGET_CHANGED")
            self:RegisterUnitEvent("UNIT_HEALTH", "target")
            self.PLAYER_TARGET_CHANGED = ns.ExecuteCheck
            self.UNIT_HEALTH = ns.ExecuteCheck
        else
            self:UnregisterEvent("PLAYER_TARGET_CHANGED")
            self:UnregisterEvent("UNIT_HEALTH")
        end
    elseif class == "ROGUE" then
        if ns.findHighestRank("Riposte") then
            self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            procCombatLog = ns.CheckRiposte
            self:SetScript("OnUpdate", self.timerOnUpdate)
        else
            self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            self:SetScript("OnUpdate", nil)
        end

    elseif class == "PALADIN" then
        if ns.findHighestRank("Exorcism") then
            self:RegisterEvent("PLAYER_TARGET_CHANGED")
            self.PLAYER_TARGET_CHANGED = ns.PaladinExorcismCheck
            self:SetScript("OnUpdate", self.timerOnUpdate)

            if ns.findHighestRank("HammerOfWrath") then
                self:RegisterUnitEvent("UNIT_HEALTH", "target")
                self.PLAYER_TARGET_CHANGED = function(...)
                    ns.PaladinExorcismCheck(...)
                    ns.HOWCheck(...)
                end
                self.UNIT_HEALTH = ns.HOWCheck
            end
        end

    elseif class == "HUNTER" then
        self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        self:SetScript("OnUpdate", self.timerOnUpdate)
        if ns.findHighestRank("Counterattack") and ns.findHighestRank("MongooseBite") then
            local CheckCounterattack = ns.CheckCounterattack
            local CheckMongooseBite = ns.CheckMongooseBite
            procCombatLog = function(...)
                CheckCounterattack(...)
                CheckMongooseBite(...)
            end
        elseif ns.findHighestRank("MongooseBite") then
            procCombatLog = ns.CheckMongooseBite
        else
            self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            self:SetScript("OnUpdate", nil)
        end
    elseif class == "WARLOCK" then
        if IsPlayerSpell(18094) or IsPlayerSpell(18095) then
            self:RegisterUnitEvent("UNIT_AURA", "player")
            self.UNIT_AURA = function(self, event, unit)
                local name, _, _, _, duration, expirationTime = FindAura(unit, 17941, "HELPFUL") -- Shadow Trance
                local haveShadowTrance = name ~= nil
                if hadShadowTrance ~= haveShadowTrance then
                    if haveShadowTrance then
                        f:Activate("ShadowBolt", duration)
                    else
                        f:Deactivate("ShadowBolt")
                    end
                    hadShadowTrance = haveShadowTrance
                end
            end
        else
            self:UnregisterEvent("UNIT_AURA")
        end
    end
end

function f:RegisterForActivations(frame)
    registeredFrames[frame] = true
    -- registeredFrames:GetScript("OnEvent")
end
local function IsSpellOverlayed(spellID)
    local spellName = spellNamesByID[spellID]
    if not spellName then return false end
    local state = activations[spellName]
    if state then return state.active end
end

local GetActionInfo = _G.GetActionInfo
local GetMacroSpell = _G.GetMacroSpell
local ActionButton_ShowOverlayGlow = _G.ActionButton_ShowOverlayGlow
local ActionButton_HideOverlayGlow = _G.ActionButton_HideOverlayGlow
function ns.UpdateOverlayGlow(self)
    local spellType, id, subType  = GetActionInfo(self.action);
	if ( spellType == "spell" and IsSpellOverlayed(id) ) then
		ActionButton_ShowOverlayGlow(self);
	elseif ( spellType == "macro" ) then
		local spellId = GetMacroSpell(id);
		if ( spellId and IsSpellOverlayed(spellId) ) then
			ActionButton_ShowOverlayGlow(self);
		else
			ActionButton_HideOverlayGlow(self);
		end
	else
		ActionButton_HideOverlayGlow(self);
	end
end

function ns.LAB_UpdateOverlayGlow(self)
	local spellId = self:GetSpellId()
	if spellId and IsSpellOverlayed(spellId) then
		if LBG then
            LBG.ShowOverlayGlow(self)
        end
	else
		if LBG then
            LBG.HideOverlayGlow(self)
        end
	end
end

function f:FanoutEvent(event, ...)
    for frame, _ in pairs(registeredFrames) do
        local eventHandler = frame:GetScript("OnEvent")
		if not BigFoot_SysTemSetTab.SpellActivations then return end
        eventHandler(frame, event, ...)
    end
end

local reverseSpellRanks = {
    Overpower = { 11585, 11584, 7887, 7384 },
    Revenge = { 25288, 11601, 11600, 7379, 6574, 6572 },
    Riposte = { 14251 },
    Counterattack = { 20910, 20909, 19306 },
    Execute = { 20662, 20661, 20660, 20658, 5308 },
    ShadowBolt = { 25307, 11661, 11660, 11659, 7641, 1106, 1088, 705, 695, 686 },
    MongooseBite = { 14271, 14270, 14269, 1495 },
    Exorcism = { 10314, 10313, 10312, 5615, 5614, 879 },
    HammerOfWrath = { 24239, 24274, 24275 },
}
function ns.findHighestRank(spellName)
    for _, spellID in ipairs(reverseSpellRanks[spellName]) do
        if IsPlayerSpell(spellID) then return spellID end
    end
end
local findHighestRank = ns.findHighestRank

function f:Activate(spellName, duration)
    local state = activations[spellName]
    if not state then
        activations[spellName] = {}
        state = activations[spellName]
    end
    if not state.active then
        state.active = true
        state.expirationTime = duration and GetTime() + duration

        local highestRankSpellID = findHighestRank(spellName)
        self:FanoutEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW", highestRankSpellID)
    else
        state.expirationTime = duration and GetTime() + duration
    end
end
function f:Deactivate(spellName)
    local state = activations[spellName]
    if state and state.active == true then
        state.active = false
        state.expirationTime = nil

        local highestRankSpellID = findHighestRank(spellName)
        self:FanoutEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE", highestRankSpellID)
    end
end

local _OnUpdateCounter = 0
local periodicCheck = nil
function f.timerOnUpdate(self, elapsed)
    _OnUpdateCounter = _OnUpdateCounter + elapsed
    if _OnUpdateCounter < 0.2 then return end
    _OnUpdateCounter = 0


    if periodicCheck then
        periodicCheck()
    end

    local now = GetTime()
    for spellName, state in pairs(activations) do
        if state.expirationTime and now >= state.expirationTime then
            f:Deactivate(spellName)
        end
    end
end

function f:COMBAT_LOG_EVENT_UNFILTERED(event)
    local timestamp, eventType, hideCaster,
    srcGUID, srcName, srcFlags, srcFlags2,
    dstGUID, dstName, dstFlags, dstFlags2,
    arg1, arg2, arg3, arg4, arg5 = CombatLogGetCurrentEventInfo()

    local isSrcPlayer = bit_band(srcFlags, AFFILIATION_MINE) == AFFILIATION_MINE
    local isDstPlayer = dstGUID == UnitGUID("player")

    procCombatLog(eventType, isSrcPlayer, isDstPlayer, arg1, arg2, arg3, arg4, arg5)
end

-----------------
-- WARRIOR
-----------------

function ns.ExecuteCheck(self, event, unit)
    if UnitExists("target") and not UnitIsFriend("player", "target") then
        local h = UnitHealth("target")
        local hm = UnitHealthMax("target")
        if h > 0 and h/hm <= 0.2 then
            f:Activate("Execute", 10)
        else
            f:Deactivate("Execute")
        end
    else
        f:Deactivate("Execute")
    end
end

function ns.CheckOverpower(eventType, isSrcPlayer, isDstPlayer, ...)
    if isSrcPlayer then
        if eventType == "SWING_MISSED" or eventType == "SPELL_MISSED" then
            local missedType
            if eventType == "SWING_MISSED" then
                missedType = select(1, ...)
            elseif eventType == "SPELL_MISSED" then
                missedType = select(4, ...)
            end
            if missedType == "DODGE" then
                f:Activate("Overpower", 5)
            end

        end

        if eventType == "SPELL_CAST_SUCCESS" then
            local spellName = select(2, ...)
            if spellName == LocalizedOverpower then
                f:Deactivate("Overpower")
            end
        end
    end
end

function ns.CheckRevenge(eventType, isSrcPlayer, isDstPlayer, ...)
    if isDstPlayer then
        if eventType == "SWING_MISSED" or eventType == "SPELL_MISSED" then
            local missedType
            if eventType == "SWING_MISSED" then
                missedType = select(1, ...)
            elseif eventType == "SPELL_MISSED" then
                missedType = select(4, ...)
            end
            if missedType == "BLOCK" or missedType == "DODGE" or missedType == "PARRY" then
                f:Activate("Revenge", 5)
            end
        end
        if eventType == "SWING_DAMAGE" then
            local blocked = select(5, ...)
            if blocked then
                f:Activate("Revenge", 5)
            end
        end
    end

    if isSrcPlayer and eventType == "SPELL_CAST_SUCCESS" then
        local spellName = select(2, ...)
        if spellName == LocalizedRevenge then
            f:Deactivate("Revenge")
        end
    end
end

-----------------
-- ROGUE
-----------------

function ns.CheckRiposte(eventType, isSrcPlayer, isDstPlayer, ...)
    if isDstPlayer then
        if eventType == "SWING_MISSED" or eventType == "SPELL_MISSED" then
            local missedType
            if eventType == "SWING_MISSED" then
                missedType = select(1, ...)
            elseif eventType == "SPELL_MISSED" then
                missedType = select(4, ...)
            end
            if missedType == "PARRY" then
                f:Activate("Riposte", 5)
            end
        end
    end

    if isSrcPlayer and eventType == "SPELL_CAST_SUCCESS" then
        local spellName = select(2, ...)
        if spellName == LocalizedRiposte then -- Riposte
            f:Deactivate("Riposte")
        end
    end
end

-----------------
-- HUNTER
-----------------

function ns.CheckCounterattack(eventType, isSrcPlayer, isDstPlayer, ...)
    if isDstPlayer then
        if eventType == "SWING_MISSED" or eventType == "SPELL_MISSED" then
            local missedType
            if eventType == "SWING_MISSED" then
                missedType = select(1, ...)
            elseif eventType == "SPELL_MISSED" then
                missedType = select(4, ...)
            end
            if missedType == "PARRY" then
                f:Activate("Counterattack", 5)
            end
        end
    end

    if isSrcPlayer and eventType == "SPELL_CAST_SUCCESS" then
        local spellName = select(2, ...)
        if spellName == LocalizedCounterattack then
            f:Deactivate("Counterattack", 5)
        end
    end
end

function ns.CheckMongooseBite(eventType, isSrcPlayer, isDstPlayer, ...)
    if isDstPlayer then
        if eventType == "SWING_MISSED" or eventType == "SPELL_MISSED" then
            local missedType
            if eventType == "SWING_MISSED" then
                missedType = select(1, ...)
            elseif eventType == "SPELL_MISSED" then
                missedType = select(4, ...)
            end
            if missedType == "DODGE" then
                f:Activate("MongooseBite", 5)
            end
        end
    end

    if isSrcPlayer and eventType == "SPELL_CAST_SUCCESS" then
        local spellName = select(2, ...)
        if spellName == LocalizedMongooseBite then
            f:Deactivate("MongooseBite", 5)
        end
    end
end

-----------------
-- PALADIN
-----------------

do
    local LocalDemonTypes = { "Demon", "Dämon", "Demonio", "Demonio", "Démon", "Demone", "Demônio", "Демон", "악마", "恶魔", "惡魔" }
    local LocalUndeadTypes = { "Undead", "Untoter", "No-muerto", "No-muerto", "Mort-vivant", "Non Morto", "Renegado", "Нежить", "언데드", "亡灵", "不死族" }
    local LocIDs = {
        ["enUS"] = 1,
        ["deDE"] = 2,
        ["esES"] = 3,
        ["esMX"] = 4,
        ["frFR"] = 5,
        ["itIT"] = 6,
        ["ptBR"] = 7,
        ["ruRU"] = 8,
        ["koKR"] = 9,
        ["zhCN"] = 10,
        ["zhTW"] = 11,
    }
    local UndeadType
    local DemonType
    local locID = LocIDs[GetLocale()]
    if locID then
        UndeadType = LocalUndeadTypes[locID]
        DemonType = LocalDemonTypes[locID]
    end

    local exorcismTicker
    local exorcismCooldownState
    local exorcismTickerFunc = function()
        local startTime, duration, enabled = GetSpellCooldown(8092) -- fistt Rank
        local newState
        if duration <= 1.5 then
            newState = false
        else
            newState = true
        end

        if newState ~= exorcismCooldownState then
            if newState == false then
                f:Activate("Exorcism", 5)
            else
                f:Deactivate("Exorcism")
            end
        end
        exorcismCooldownState = newState
    end

    function ns.PaladinExorcismCheck(self, event)
        if UnitExists("target") and (UnitCreatureType("target") == UndeadType or UnitCreatureType("target") == DemonType) then
            exorcismCooldownState = not exorcismCooldownState
            exorcismTickerFunc()
            periodicCheck = exorcismTickerFunc
        else
            f:Deactivate("Exorcism")
            periodicCheck = nil
        end
    end
end

function ns.HOWCheck(self, event, unit)
    if UnitExists("target") and not UnitIsFriend("player", "target") then
        local h = UnitHealth("target")
        local hm = UnitHealthMax("target")
        if h > 0 and h/hm <= 0.2 then
            f:Activate("HammerOfWrath", 10)
        else
            f:Deactivate("HammerOfWrath")
        end
    else
        f:Deactivate("HammerOfWrath")
    end
end
