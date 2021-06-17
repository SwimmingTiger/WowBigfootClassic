-- ClassicCodex loader

local L = LibStub("AceLocale-3.0"):GetLocale("ClassicCodex")

local function log(...)
    print(L['[ClassicCodex]'], ...)
end

local function tryLoad(name)
    if IsAddOnLoadOnDemand(name) then
        return LoadAddOn(name)
    else
        log(L['Missing component %s']:format(name))
        return false
    end
end

-- load database
if not tryLoad('ClassicCodex-db') then
    log(L['Failed to load database, ClassicCodex cannot be launched'])
    return
end

-- load database locales
if not tryLoad('ClassicCodex-db-'..GetLocale()) then
    if not tryLoad('ClassicCodex-db-enUS') then
        log(L['Failed to load database locales, ClassicCodex cannot be launched'])
        return
    end
end

-- load core
if not tryLoad('ClassicCodex') then
    log(L['Failed to load ClassicCodex core, ClassicCodex cannot be launched'])
    return
end

-- load patch
if not tryLoad('ClassicCodex-patch') then
    log(L['Unable to load database patch, quest data may be inaccurate'])
end
