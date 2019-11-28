local _, helpers = ...
NugRunningConfig = {}
NugRunningConfig.spells = {}
NugRunningConfig.nameplates = {}
NugRunningConfig.anchors = {}
NugRunningConfig.cooldowns = {}
NugRunningConfig.itemcooldowns = {}
NugRunningConfig.activations = {}
NugRunningConfig.event_timers = {}
NugRunningConfig.totems = {}
NugRunningConfig.casts = {}
local AFFILIATION_MINE = COMBATLOG_OBJECT_AFFILIATION_MINE
local AFFILIATION_PARTY_OR_RAID = COMBATLOG_OBJECT_AFFILIATION_RAID + COMBATLOG_OBJECT_AFFILIATION_PARTY
local AFFILIATION_OUTSIDER = COMBATLOG_OBJECT_AFFILIATION_OUTSIDER



-- local isLegion = select(4,GetBuildInfo()) < 80000
-- if isLegion then
--     helpers.CompatUnitAura = function(...)
--         local name, _, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, isCastByPlayer, nameplateShowAll, timeMod = UnitAura(...)
--         return name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, isCastByPlayer, nameplateShowAll, timeMod
--     end
-- else
-- end


helpers.Talent = function (spellID)
    return IsSpellKnown(spellID) and 1 or 0
end
helpers.ClassicTalent = function (...)
    for i=1, 5 do
        local spellID = select(i, ...)
        if not spellID then break end
        if IsPlayerSpell(spellID) then return i end
    end
    return 0
end
helpers.ClassicTalentByEnum = function (spellID)
    local spellName
    if type(spellID) == "number" then
        spellName = GetSpellInfo(spellID)
    elseif type(spellID) == "string" then
        spellName = spellID
    end

    local numTabs = GetNumTalentTabs()
    for tab=1, numTabs do
        local numTalents = GetNumTalents(tab)
        for i=1, numTalents do
            local name, _,_,_, rank = GetTalentInfo(tab, i)
            if spellName == name then
                return rank
            end
        end
    end
    return 0
end


helpers.GetCP = function()
    if not NugRunning.cpNow then return GetComboPoints("player", "target") end
    return NugRunning.cpWas > NugRunning.cpNow and NugRunning.cpWas or NugRunning.cpNow
end
helpers.Glyph = function (gSpellID)
    for i = 1, GetNumGlyphSockets() do
        if select(4,GetGlyphSocketInfo(i,GetActiveSpecGroup()) ) == gSpellID then return 1 end
    end
    return 0
end

local function apply_overrides(opts, mods)
    if not opts or not mods then return end
    for k,v in pairs(mods) do
        opts[k] = v
    end
end


helpers.Anchor = function(name, opts)
    NugRunningConfig.anchors[name] = opts
end

local SpellMixin = _G.Spell
helpers.spellNameToID = {}

helpers.AddSpellNameRecognition = function(lastRankID)
    local spellName = GetSpellInfo(lastRankID)
    helpers.spellNameToID[spellName] = lastRankID
end

helpers.Spell = function(id, opts)
    if not opts then NugRunningConfig[id] = opts; return end
    if opts.singleTarget then opts.target = "target" end
    if opts.affiliation == "raid" then opts.affiliation = AFFILIATION_PARTY_OR_RAID end
    if opts.affiliation == "any" then opts.affiliation = AFFILIATION_OUTSIDER end

    if type(id) == "table" then
        local clones = id
        id = table.remove(clones, 1) -- extract first spell id from the last as original
        opts.clones = clones
    end

    if opts and not GetSpellInfo(id) then print(string.format("nrun: misssing spell #%d (%s)",id,opts.name)) return end
    NugRunningConfig.spells[id] = opts
end
helpers.AddSpell = helpers.Spell
helpers.ModSpell = function(id, mods)
    if type(id) == "table" then
        for _, i in ipairs(id) do
            apply_overrides(NugRunningConfig.spells[i], mods)
        end
    else
        apply_overrides(NugRunningConfig.spells[id], mods)
    end
end

helpers.Cooldown = function(id, opts)
    if type(id) == "table" then id = id[1] end
    if opts then
        opts.localname = GetSpellInfo(id)
        if not opts.localname then print("nrun: misssing spell #"..id) return end
    end
    NugRunningConfig.cooldowns[id] = opts
end
helpers.AddCooldown = helpers.Cooldown
helpers.ModCooldown = function(id, mods)
    if type(id) == "table" then id = id[1] end
    apply_overrides(NugRunningConfig.cooldowns[id], mods)
end

helpers.Item = function(id, opts)
    if opts then
        opts.localname = GetItemInfo(id) or "Item"
        opts.isItem = true
        local start,duration, enabled = GetItemCooldown(id)
        if start == 0 and duration == 0 and enabled == 0 then
            print("nrun: no cooldown on item #"..id)
            return
        end
    end
    NugRunningConfig.itemcooldowns[id] = opts
end

helpers.Totem = function(id, opts)
    NugRunningConfig.totems[id] = opts
end

helpers.Cast = function(id, opts)
    if type(id) == "table" then
        -- opts.idgroup = {}
        local clones = id
        id = table.remove(clones, 1) -- extract first spell id from the last as original
        opts.clones = clones
    end
    if opts then
        opts.localname = GetSpellInfo(id)
        if not opts.localname then print("nrun: misssing spell #"..id) return end
    end
    NugRunningConfig.casts[id] = opts
end


helpers.Activation = function(id, opts)
    if opts then
        opts.localname = GetSpellInfo(id)
        if not opts.localname then print("nrun: misssing spell #"..id) return end
    end
    NugRunningConfig.activations[id] = opts
end
helpers.AddActivation = helpers.Activation
helpers.ModActivation = function(id, mods)
    apply_overrides(NugRunningConfig.activations[id], mods)
end

helpers.EventTimer = function( id, opts )
    if type(id) == "table" and opts == nil then
        opts = id
        id = opts.spellID
        opts.spellID = nil
    end

    if not opts.event then print(string.format("nrun: missing combat log event (#%s)", opts.spellID)); return end
    if not opts.duration and not opts.action then print(string.format("nrun: duration is required for event timers(#%s)", opts.spellID)); return end
    if not opts.name then opts.name = "" end
    if opts.affiliation == "raid" then opts.affiliation = AFFILIATION_PARTY_OR_RAID end
    if opts.affiliation == "any" then opts.affiliation = AFFILIATION_OUTSIDER end

    if type(id) == "table" then
        local clones = id
        id = table.remove(clones, 1) -- extract first spell id from the last as original
        opts.clones = clones
    end
    if opts and not GetSpellInfo(id) then print(string.format("nrun: misssing spell #%d (%s)",id,opts.name)) return end
    NugRunningConfig.event_timers[id] = opts
end
helpers.AddEventTimer = helpers.EventTimer

helpers.WipeColors = function()
    local L = { NugRunningConfig, NugRunningConfig.activations, NugRunningConfig.cooldowns }
    for _,T in ipairs(L) do
        print (T)
        for id, opts in pairs(T) do
            opts.color = nil
        end
    end
    for event,T in pairs(NugRunningConfig.event_timers) do
        for _, opts in pairs(T) do
            opts.color = nil
        end
    end
end

helpers.RemoveAll = function()
    NugRunningConfig = {}
    NugRunningConfig.cooldowns = {}
    NugRunningConfig.activations = {}
    NugRunningConfig.event_timers = {}
end


local bit_band = bit.band
local math_pow = math.pow
helpers.SPECS = function(...)
    local mask = 0
    for i, spec in ipairs({...}) do
        mask = mask + 0xF*math_pow(0x10, spec-1)
    end
    return mask
end
helpers.CheckSpec = function(specmask, spec)
    if not specmask then return true end
    local s = 0xF*math_pow(0x10, spec-1)
    return bit_band(specmask, s) == s
end

--[[
local ItemSetsRegistered = {}

local function TrackItemSet(tiername, itemArray)
    ItemSetsRegistered[tiername] = ItemSetsRegistered[tiername] or {}
    if not ItemSetsRegistered[tiername].items then
        ItemSetsRegistered[tiername].items = {}
        ItemSetsRegistered[tiername].callbacks = {}
        local bitems = ItemSetsRegistered[tiername].items
        for _, itemID in ipairs(itemArray) do
            bitems[itemID] = true
        end
    end
end

local function RegisterSetBonusCallback(tiername, pieces, handle_on, handle_off)
    local tier = ItemSetsRegistered[tiername]
    if not tier then error(string.format("Itemset '%s' is not registered", tiername)) end
    tier.callbacks[pieces] = {}
    tier.callbacks[pieces].equipped = false
    tier.callbacks[pieces].on = handle_on
    tier.callbacks[pieces].off = handle_off
end


local function IsSetBonusActive(tiername, bonuscount)
        local tier = ItemSetsRegistered[tiername]
        local tier_items = tier.items
        local pieces_equipped = 0
        for _, slot in ipairs(tierSlots) do
            local itemID = GetInventoryItemID("player", slot)
            if tier_items[itemID] then pieces_equipped = pieces_equipped + 1 end
        end
        return (pieces_equipped >= bonuscount)
end

helpers.TrackItemSet = TrackItemSet
helpers.RegisterSetBonusCallback = RegisterSetBonusCallback
helpers.IsSetBonusActive = IsSetBonusActive


local tierSlots = {
    (GetInventorySlotInfo("ChestSlot")),
    (GetInventorySlotInfo("HeadSlot")),
    (GetInventorySlotInfo("ShoulderSlot")),
    (GetInventorySlotInfo("LegsSlot")),
    (GetInventorySlotInfo("HandsSlot")),
}

local setwatcher = CreateFrame("Frame", nil, UIParent)
setwatcher:SetScript("OnEvent", function(self, event, ...)
    return self[event](self, event, ...)
end)

setwatcher:RegisterEvent("PLAYER_LOGIN")

function setwatcher:PLAYER_LOGIN()
    if next(ItemSetsRegistered) then
        self:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", "player")
        self:UNIT_INVENTORY_CHANGED(nil, "player")
    end
end


function setwatcher:UNIT_INVENTORY_CHANGED(event, unit)
    for tiername, tier in pairs(ItemSetsRegistered) do
        local tier_items = tier.items
        local pieces_equipped = 0
        for _, slot in ipairs(tierSlots) do
            local itemID = GetInventoryItemID("player", slot)
            if tier_items[itemID] then pieces_equipped = pieces_equipped + 1 end
        end

        for bp, bonus in pairs(tier.callbacks) do
            if pieces_equipped >= bp then
                if not bonus.equipped then
                    if bonus.on then bonus.on() end
                    bonus.equipped = true
                end
            else
                if bonus.equipped then
                    if bonus.off then bonus.off() end
                    bonus.equipped = false
                end
            end
        end
    end
end
]]