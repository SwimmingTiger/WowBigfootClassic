local pairs, ipairs = pairs, ipairs
local select = select
local type = type
local floor = math.floor
local str_find, str_gsub, str_sub, str_format = string.find, string.gsub, string.sub, string.format
local tinsert = table.insert
local Gladdy = LibStub("Gladdy")
local L = Gladdy.L
local AuraUtil = AuraUtil
local GetSpellInfo = GetSpellInfo
local UnitIsUnit = UnitIsUnit

---------------------------

-- TAGS

---------------------------

local tags = {
    ["current"] = true,
    ["max"] = true,
    ["percent"] = true,
    ["race"] = "race",
    ["class"] = "class",
    ["arena"] = true,
    ["name"] = "name",
    ["status"] = true,
    ["spec"] = "spec",
}

local function str_extract(s, pattern)
    local t = {} -- table to store the indices
    local i, j = 0,0
    while true do
        i, j = str_find(s, pattern, i+1) -- find 'next' occurrence
        if i == nil then break end
        tinsert(t, str_sub(s, i, j))
    end
    return t
end

--TODO optimize this function as it's being called often!
local function getTagText(unit, tag, current, max, status)
    local button = Gladdy.buttons[unit]
    if not button then
        return
    end

    if str_find(tag, "percent") then
        return current and max and floor(current * 100 / max) .. "%%" or ""
    elseif str_find(tag, "current") then
        return current and max > 999 and ("%.1fk"):format(current / 1000) or current or ""
    elseif str_find(tag, "max") then
        return max and max > 999 and ("%.1fk"):format(max / 1000) or max or ""
    elseif str_find(tag, "status") then
        if str_find(tag, "%|") and status == nil then
            return nil
        else
            return status or ""
        end
    elseif str_find(tag, "name") then
        return button.name or ""
    elseif str_find(tag, "class") then
        return button.classLoc or ""
    elseif str_find(tag, "race") then
        return button.raceLoc or ""
    elseif str_find(tag, "arena") then
        local str,found = str_gsub(unit, "arena", "")
        return found == 1 and str or ""
    elseif str_find(tag, "spec") then
        if str_find(tag, "%|") and button.spec == nil then
            return nil
        else
            return button.spec or ""
        end
    end
end

function Gladdy:SetTag(unit, tagOption, current, max, status)
    local button = self.buttons[unit]
    if not button then
        return
    end

    local returnStr = tagOption

    local t = str_extract(returnStr, "%[[^%[].-%]")
    for _, tag in ipairs(t) do
        local replace
        if str_find(tag, "|") then -- or operator
            local indicators = str_extract(tag, "[%[|%|]%a+[%||%]]")
            local replaces = {}
            for _, indicator in ipairs(indicators) do
                tinsert(replaces, getTagText(unit, indicator, current, max, status))
            end
            replace = replaces[#replaces]
        else
            replace = getTagText(unit, tag, current, max, status)
        end

        if replace then
            local find = str_gsub(tag, "%[", "%%[")
            find = str_gsub(find, "%]", "%%]")
            find = str_gsub(find, "%|", "%%|")
            returnStr = str_gsub(returnStr, find, replace)
        end
    end
    return returnStr
end

function Gladdy:GetTagOption(name, order, enabledOption, func, toggle)
    if toggle then
        return func({
            type = "toggle",
            name = name,
            order = order,
            width = "full",
            desc = L["Custom Tags:\n"..
                    "\n|cff1ac742[current]|r - Shows current\n" ..
                    "\n|cff1ac742[max]|r - Shows max\n" ..
                    "\n|cff1ac742[percent]|r - Shows percent\n" ..
                    "\n|cff1ac742[name]|r - Shows name\n" ..
                    "\n|cff1ac742[arena]|r - Shows arena number\n" ..
                    "\n|cff1ac742[status]|r - Shows status (eg DEATH)\n" ..
                    "\n|cff1ac742[race]|r - Shows race\n" ..
                    "\n|cff1ac742[class]|r - Shows class\n" ..
                    "\n|cff1ac742[spec]|r - Shows spec\n\n" ..
                    "Can be combined with OR operator like |cff1ac742[percent|status]|r. The last valid option will be used.\n"],
        })
    else
        return func({
            type = "input",
            name = name,
            order = order,
            width = "full",
            disabled = function() return not Gladdy.db[enabledOption] end,
            desc = L["Custom Tags:\n"..
                    "\n|cff1ac742[current]|r - Shows current\n" ..
                    "\n|cff1ac742[max]|r - Shows max\n" ..
                    "\n|cff1ac742[percent]|r - Shows percent\n" ..
                    "\n|cff1ac742[name]|r - Shows name\n" ..
                    "\n|cff1ac742[arena]|r - Shows arena number\n" ..
                    "\n|cff1ac742[status]|r - Shows status (eg DEATH)\n" ..
                    "\n|cff1ac742[race]|r - Shows race\n" ..
                    "\n|cff1ac742[class]|r - Shows class\n" ..
                    "\n|cff1ac742[spec]|r - Shows spec\n\n" ..
                    "Can be combined with OR operator like |cff1ac742[percent|status]|r. The last valid option will be used.\n"],
        })
    end
end

function Gladdy:contains(entry, list)
    for _,v in pairs(list) do
        if entry == v then
            return true
        end
    end
    return false
end

local feignDeath = GetSpellInfo(5384)
function Gladdy:isFeignDeath(unit)
    return AuraUtil.FindAuraByName(feignDeath, unit)
end

function Gladdy:GetArenaUnit(unitCaster, unify)
    if unitCaster then
        for i=1,5 do
            local arenaUnit = "arena" .. i
            local arenaUnitPet = "arenapet" .. i
            if unify then
                if unitCaster and (UnitIsUnit(arenaUnit, unitCaster) or UnitIsUnit(arenaUnitPet, unitCaster)) then
                    return arenaUnit
                end
            else
                if unitCaster and UnitIsUnit(arenaUnit, unitCaster) then
                    return arenaUnit
                end
                if unitCaster and UnitIsUnit(arenaUnitPet, unitCaster) then
                    return arenaUnitPet
                end
            end
        end
    end
end

function Gladdy:ShallowCopy(table)
    local copy
    if type(table) == 'table' then
        copy = {}
        for k,v in pairs(table) do
            copy[k] = v
        end
    else -- number, string, boolean, etc
        copy = table
    end
    return copy
end

function Gladdy:DeepCopy(table)
    local copy
    if type(table) == 'table' then
        copy = {}
        for k,v in pairs(table) do
            if type(v) == 'table' then
                copy[k] = self:DeepCopy(v)
            else -- number, string, boolean, etc
                copy[k] = v
            end
        end
    else -- number, string, boolean, etc
        copy = table
    end
    return copy
end

function Gladdy:AddEntriesToTable(table, entries)
    for k,v in pairs(entries) do
        if not table[k] then
            table[k] = v
        end
    end
end

function Gladdy:GetExceptionSpellName(spellID)
    for k,v in pairs(Gladdy.exceptionNames) do
        if k == spellID and Gladdy:GetImportantAuras()[v] and Gladdy:GetImportantAuras()[v].altName then
            return Gladdy:GetImportantAuras()[v].altName
        end
    end
    return select(1, GetSpellInfo(spellID))
end

local function toHex(color)
    if not color or not color.r or not color.g or not color.b then
        return "000000"
    end
    return str_format("%.2x%.2x%.2x", floor(color.r * 255), floor(color.g * 255), floor(color.b * 255))
end
function Gladdy:SetTextColor(text, color)
    return "|cff" .. toHex(color) .. text or "" .. "|r"
end

function Gladdy:ColorAsArray(color)
    return {color.r, color.g, color.b, color.a}
end

function Gladdy:Dump(table, space)
    if type(table) ~= "table" then
        return
    end
    if not space then
        space = ""
    end
    for k,v in pairs(table) do
        Gladdy:Print(space .. k .. " - ", v)
        if type(v) == "table" then
            Gladdy:Dump(v, space .. " ")
        end
    end
end