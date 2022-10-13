local type, ipairs, pairs, tinsert = type, ipairs, pairs, tinsert
local GetSpellInfo = GetSpellInfo
local AURA_TYPE_DEBUFF, AURA_TYPE_BUFF = AURA_TYPE_DEBUFF, AURA_TYPE_BUFF

local LibClassAuras = LibStub:NewLibrary("LibClassAuras-1.0", 1)
LibClassAuras.debuffs = {}
LibClassAuras.debuffToId = {}
LibClassAuras.buffs = {}
LibClassAuras.buffToId = {}
LibClassAuras.altNames = {}

LibClassAuras.gameExpansion = ({
    [WOW_PROJECT_MAINLINE] = "retail",
    [WOW_PROJECT_CLASSIC] = "classic",
    [WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5] = "tbc"
})[WOW_PROJECT_ID]

local function Spell(id, opts, class, spellTable, idTable)
    if not opts or not class then
        return
    end

    local spellName
    if type(id) == "table" then
        local realIds = {}
        for i = 1, #id do
            if GetSpellInfo(id[i]) then
                tinsert(realIds, id[i])
                spellName = GetSpellInfo(id[i])
            end
        end
        id = realIds
    else
        spellName = GetSpellInfo(id)
    end
    
    if not spellName then
        return
    end
    if opts.altName then
        for _,v in ipairs(id) do
            LibClassAuras.altNames[v] = opts.altName
        end
        if idTable[opts.altName] then
            tinsert(idTable[opts.altName], {id = id , class = class})
        else
            idTable[opts.altName] = {[1] = {id = id , class = class}}
        end
    else
        if idTable[spellName] then
            tinsert(idTable[spellName], {id = id , class = class})
        else
            idTable[spellName] = {[1] = {id = id , class = class}}
        end
    end

    if type(id) == "table" then
        for _, spellID in ipairs(id) do
            spellTable[spellID] = opts
            spellTable[spellID].class = class
        end
    else
        spellTable[id] = opts
        spellTable[id].class = class
    end
end

local function Debuff(id, opts, class)
    Spell(id, opts, class, LibClassAuras.debuffs, LibClassAuras.debuffToId)
end
LibClassAuras.Debuff = Debuff

local function Buff(id, opts, class)
    Spell(id, opts, class, LibClassAuras.buffs, LibClassAuras.buffToId)
end
LibClassAuras.Buff = Buff

local function getClassDebuffs(class)
    local classSpells = {}
    for name, spells in pairs(LibClassAuras.debuffToId) do
        for _, spellInfo in ipairs(spells) do
            if spellInfo.class == class then
                tinsert(classSpells, {name = name, id = spellInfo.id})
            end
        end
    end
    return classSpells
end
LibClassAuras.GetClassDebuffs = getClassDebuffs

local function getClassBuffs(class)
    local classSpells = {}
    for name, spells in pairs(LibClassAuras.buffToId) do
        for _, spellInfo in ipairs(spells) do
            if spellInfo.class == class then
                tinsert(classSpells, {name = name, id = spellInfo.id})
            end
        end
    end
    return classSpells
end
LibClassAuras.GetClassBuffs = getClassBuffs

local function getSpellNameToId(auraType)
    if auraType == AURA_TYPE_DEBUFF then
        return LibClassAuras.debuffToId
    else
        return LibClassAuras.buffToId
    end
end

LibClassAuras.GetSpellNameToId = getSpellNameToId

local function getAltName(spellID)
    return LibClassAuras.altNames[spellID]
end
LibClassAuras.GetAltName = getAltName