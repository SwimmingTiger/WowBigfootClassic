CodexDatabase = {}

local loc = GetLocale()
local dbs = {"items", "quests", "objects", "units", "zones", "professions"}

-- build name databases
for key, value in pairs(dbs) do
    CodexDB[value]["loc"] = CodexDB[value][loc] or CodexDB[value]["enUS"]
end

-- Create DB Shortcuts
local items = CodexDB["items"]["data"]
local units = CodexDB["units"]["data"]
local objects = CodexDB["objects"]["data"]
local quests = CodexDB["quests"]["data"]
local refloot = CodexDB["refloot"]["data"]
local zones = CodexDB["zones"]["loc"]
local professions = CodexDB["professions"]["loc"]

local bitraces = {
    [1] = "Human",
    [2] = "Orc",
    [4] = "Dwarf",
    [8] = "NightElf",
    [16] = "Scourge",
    [32] = "Tauren",
    [64] = "Gnome",
    [128] = "Troll"
}
  
local bitclasses = {
    [1] = "WARRIOR",
    [2] = "PALADIN",
    [4] = "HUNTER",
    [8] = "ROGUE",
    [16] = "PRIEST",
    [64] = "SHAMAN",
    [128] = "MAGE",
    [256] = "WARLOCK",
    [1024] = "DRUID"
}

function CodexDatabase:PlayerHasSkill(skill)
    local minRank = 0
    if type(skill) == 'table' then
        minRank = skill.min
        skill = skill.id
    end
    if not professions[skill] then return false end

    for i = 0, GetNumSkillLines() do
        local name, _, _, rank = GetSkillLineInfo(i)
        if name == professions[skill] and rank >= minRank then
            return true
        end
    end

    return false
end

function CodexDatabase:PlayerHasReputation(repu)
    local minRank = 0
    if type(repu) == 'table' then
        minRank = repu.min
        repu = repu.id
    end
    local _, _, _, _, _, rank = GetFactionInfoByID(repu)
    return rank and rank > minRank
end

function CodexDatabase:GetBitByRace(model)
    for bit, v in pairs(bitraces) do
        if model == v then return bit end
    end
end

function CodexDatabase:GetBitByClass(model)
    for bit, v in pairs(bitclasses) do
        if model == v then return bit end
    end
end

local function stringCompare(old, new)
    local prv = {}
    for o = 0, string.len(old) do
        prv[o] = ""
    end

    for n = 1, string.len(new) do
        local nxt = {[0] = string.sub(new, 1, n)}
        local nn = string.sub(new, n, n)
        for o = 1, string.len(old) do
            local result
            if nn == string.sub(old, o, o) then
                result = prv[o - 1]
            else
                result = prv[o] .. n
                if string.len(nxt[o - 1]) <= string.len(result) then
                    result = nxt[o - 1]
                end
            end
            nxt[o] = result
        end
        prv = nxt
    end

    local diff = strlen(prv[string.len(old)])
    if diff == 0 then
        return 0
    elseif strlen(old) == 0 then
        return diff / 0.01
    else
        return diff / strlen(old)
    end
end

-- Compare Strings
function CodexDatabase:CompareString(old, new)
    local s1 = stringCompare(old, new)
    local s2 = stringCompare(new, old)

    return (math.abs(s1) + math.abs(s2)) / 2
end

function CodexDatabase:GetRaceMaskById(id, db)
    local factionMap = {["A"] = 77, ["H"] = 178, ["AH"] = 255, ["HA"] = 255}
    local raceMask = 0

    if db == "quests" then
        if quests[id]["race"] ~= nil then
            return quests[id]["race"]
        end

        if quests[id]["start"] then
            local questStartRaceMask = 0

            -- Get Quest starter faction
            if quests[id]["start"]["U"] then
                for _, unitId in pairs(quests[id]["start"]["U"]) do
                    if units[unitId]["fac"] and factionMap[units[unitId]["fac"]] then
                        questStartRaceMask = bit.bor(factionMap[units[unitId]["fac"]])
                    end
                end
            end

            -- Get Quest object starter faction
            if quests[id]["start"]["O"] then
                for _, objectId in pairs(quests[id]["start"]["O"]) do
                    if objects[objectId]["fac"] and factionMap[objects[objectId]["fac"]] then
                        questStartRaceMask = bit.bor(factionMap[objects[objectId]["fac"]])
                    end
                end
            end

            -- Apply starter faction as racemask
            if questStartRaceMask > 0 and questStartRaceMask ~= raceMask then
                raceMask = questStartRaceMask
            end
        end
    end

    return raceMask
end

-- Scans DB by name and returns list of matching IDs
function CodexDatabase:GetIdByName(name, db, partial, searchLimit)
    if not CodexDB[db] then return nil end
    local result = {}
    local count = 0
    
    for key, value in pairs(CodexDB[db]["loc"]) do
        if db == "quests" then value = value["T"] end

        if value and name then
            if partial == true and strfind(strlower(value), strlower(name), 1, true) then
                result[key] = value
                count = count + 1
                if searchLimit and (count >= searchLimit) then break end
            elseif partial == "LOWER" and strlower(value) == strlower(name) then
                result[key] = value
                count = count + 1
                if searchLimit and (count >= searchLimit) then break end
            elseif value == name then
                result[key] = value
                count = count + 1
                if searchLimit and (count >= searchLimit) then break end
            end
        end
    end

    return result, count
end

function CodexDatabase:GetIdByPartialId(partialId, db, exact, searchLimit)
    if not CodexDB[db] then return nil end
    local result = {}
    
    if exact then
        partialId = tonumber(partialId)
        local value = CodexDB[db]["loc"][partialId]
        if not value then return {}, 0 end
        if db == "quests" then value = value["T"] end
        result[partialId] = value
        return result, 1
    end

    local count = 0
    for key, value in pairs(CodexDB[db]["loc"]) do
        if db == "quests" then value = value["T"] end

        if partialId and value and strfind(tostring(key), partialId) then
            result[key] = value
            count = count + 1
            if searchLimit and (count >= searchLimit) then break end
        end
    end

    return result, count
end

function CodexDatabase:SearchQuestInSet(questSet, name, db, exact, searchLimit)
    if db ~= 'quests' or not CodexDB[db] then
        return {}, 0
    end

    local lvl = tonumber(name)
    local lvlMatch = lvl and true or false
    if lvlMatch and not exact then
        lvl = lvl - (lvl % 10)
    end

    local function lvlEqual(questId, lvl)
        if not quests[questId] then return false end
        local questLvl = quests[questId].lvl or quests[questId].min or 1
        if not exact then questLvl = questLvl - (questLvl % 10) end
        return questLvl == lvl
    end

    local function nameMatched(title, name)
        if exact then return title == name end
        return strfind(title, name)
    end

    local result = {}
    local count = 0
    local noFilter = strlen(name) == 0

    for questId, _ in pairs(questSet) do
        questId = tonumber(questId)
        if CodexDB[db]["loc"][questId] then
            local title = CodexDB[db]["loc"][questId]["T"]
            if noFilter or (lvlMatch and lvlEqual(questId, lvl)) or (not lvlMatch and nameMatched(title, name)) then
                result[questId] = title
                count = count + 1
                if searchLimit and (count >= searchLimit) then break end
            end
        end
    end

    return result, count
end

-- Scans a map table for all spawns
-- Return the map with the most spawns
function CodexDatabase:GetBestMap(maps)
    local bestMap, bestScore = nil, 0

    for map, count in pairs(maps or {}) do
        if count > bestScore then
            bestScore = count
            bestMap = map
        end
    end

    return bestMap or nil, bestScore or nil
end

-- Scans for all mobs with specified ID
-- Adds map nodes for each and returns its map table
function CodexDatabase:SearchUnitById(id, meta, maps)
    if not units[id] or not units[id]["coords"] then return maps end

    local maps = maps or {}

    local coordsNum = {}
    for _, data in pairs(units[id]["coords"]) do
        local _, _, zone = unpack(data)
        coordsNum[zone] = coordsNum[zone] and (coordsNum[zone] + 1) or 1
    end

    for _, data in pairs(units[id]["coords"]) do
        local x, y, zone, respawn = unpack(data)

        if zone > 0 then
            meta = meta or {}
            meta["spawn"] = CodexDB.units.loc[id]
            meta["spawnId"] = id

            meta["title"] = meta["quest"] or meta["item"] or meta["spawn"]
            meta["zone"] = zone
            meta["x"] = x
            meta["y"] = y

            meta["level"] = units[id]["lvl"] or UNKNOWN
            meta["spawnType"] = "Unit"
            meta["respawn"] = respawn > 0 and SecondsToTime(respawn)
            meta["coordsNum"] = coordsNum[zone]

            maps[zone] = maps[zone] and maps[zone] + 1 or 1
            CodexMap:AddNode(meta)
        end
    end

    return maps
end

function CodexDatabase:SearchUnitByName(name, meta, partial)
    local maps = {}

    for id in pairs(CodexDatabase:GetIdByName(name, "units", partial)) do
        if units[id] and units[id]["coords"] then
            maps = CodexDatabase:SearchUnitById(id, meta, maps)
        end
    end

    return maps
end

function CodexDatabase:SearchObjectById(id, meta, maps)
    if not objects[id] or not objects[id]["coords"] then return maps end

    local maps = maps or {}

    local coordsNum = {}
    for _, data in pairs(objects[id]["coords"]) do
        local _, _, zone = unpack(data)
        coordsNum[zone] = coordsNum[zone] and (coordsNum[zone] + 1) or 1
    end

    for _, data in pairs(objects[id]["coords"]) do
        local x, y, zone, respawn = unpack(data)

        if zone > 0 then
            meta = meta or {}
            meta["spawn"] = CodexDB.objects.loc[id]
            meta["spawnId"] = id

            meta["title"] = meta["quest"] or meta["item"] or meta["spawn"]
            meta["zone"] = zone
            meta["x"] = x
            meta["y"] = y

            meta["level"] = nil
            meta["spawnType"] = "Object"
            meta["respawn"] = respawn and SecondsToTime(respawn)
            meta["coordsNum"] = coordsNum[zone]

            maps[zone] = maps[zone] and maps[zone] + 1 or 1
            CodexMap:AddNode(meta)
        end
    end

    return maps
end

function CodexDatabase:SearchObjectByName(name, meta, partial)
    local maps = {}

    for id in pairs(CodexDatabase:GetIdByName(name, "objects", partial)) do
        if objects[id] and objects[id]["coords"] then
            maps = CodexDatabase:SearchObjectById(id, meta, maps)
        end
    end

    return maps
end

function CodexDatabase:SearchItemById(id, meta, maps, allowedTypes)
    if not items[id] then return maps end

    local maps = maps or {}
    local meta = meta or {}

    meta["itemId"] = id
    meta["item"] = CodexDB.items.loc[id]

    -- Apply filtering only to entries from the quest log.
    -- Allows all markers to be displayed from the browser.
    local minimumDropChance = 0
    if meta["questLogId"] ~= nil then
        minimumDropChance = CodexConfig.minimumDropChance
    end

    -- Search Unit drops
    if items[id]["U"] and ((not allowedTypes) or allowedTypes["U"]) then
        for unit, dropChance in pairs(items[id]["U"]) do
            if dropChance >= minimumDropChance then
                meta["texture"] = nil
                meta["dropRate"] = dropChance
                meta["sellCount"] = nil
                maps = CodexDatabase:SearchUnitById(unit, meta, maps)
            end
        end
    end

    -- Search Object loot
    if items[id]["O"] and ((not allowedTypes) or allowedTypes["O"]) then
        for object, dropChance in pairs(items[id]["O"]) do
            if dropChance >= minimumDropChance and dropChance > 0 then
                meta["texture"] = nil
                meta["dropRate"] = dropChance
                meta["sellCount"] = nil
                maps = CodexDatabase:SearchObjectById(object, meta, maps)
            end
        end
    end

    if items[id]["R"] then
        for ref, dropChance in pairs(items[id]["R"]) do
            if dropChance >= minimumDropChance and refloot[ref] then
                -- ref units
                if refloot[ref]["U"] and ((not allowedTypes) or allowedTypes["U"]) then
                    for unit in pairs(refloot[ref]["U"]) do
                        meta["texture"] = nil
                        meta["dropRate"] = dropChance
                        meta["sellCount"] = nil
                        maps = CodexDatabase:SearchUnitById(unit, meta, maps)
                    end
                end

                -- ref objects
                if refloot[ref]["O"] and ((not allowedTypes) or allowedTypes["O"]) then
                    for object in pairs(refloot[ref]["O"]) do
                        meta["texture"] = nil
                        meta["dropRate"] = dropChance
                        meta["sellCount"] = nil
                        maps = CodexDatabase:SearchObjectById(object, meta, maps)
                    end
                end
            end
        end
    end

    if items[id]["V"] and ((not allowedTypes) or allowedTypes["V"]) then
        for unit, dropChance in pairs(items[id]["V"]) do
            meta["texture"] = "Interface\\Addons\\ClassicCodex\\img\\icon_vendor.tga"
            meta["dropRate"] = nil
            meta["sellCount"] = dropChance
            maps = CodexDatabase:SearchUnitById(unit, meta, maps)
        end
    end

    return maps
end

function CodexDatabase:SearchItemByName(name, meta, partial)
    local maps = {}

    for id in pairs(CodexDatabase:GetIdByName(name, "items", partial)) do
        maps = CodexDatabase:SearchItemById(id, meta, maps)
    end

    return maps
end

function CodexDatabase:SearchVendorByItemName(item, meta)
    local maps = {}
    local meta = meta or {}

    for id in pairs(CodexDatabase:GetIdByName(item, "items")) do
        meta["itemId"] = id
        meta["item"] = CodexDB.items.loc[id]

        if items[id] and items[id]["V"] then
            for unit, dropChance in pairs(items[id]["V"]) do
                meta["texture"] = "Interface\\Addons\\ClassicCodex\\img\\icon_vendor.tga"
                meta["dropRate"] = nil
                meta["sellCount"] = dropChance
                maps = CodexDatabase:SearchUnitById(unit, meta, maps)
            end
        end
    end

    return maps
end

function CodexDatabase:SearchQuestById(id, meta, maps)
    local maps = maps or {}
    local meta = meta or {}

    meta["questId"] = id
    meta["quest"] = CodexDB.quests.loc[id].T
    meta["questLevel"] = quests[id]["lvl"]
    meta["questMinimumLevel"] = quests[id]["min"]

    if CodexConfig.currentQuestGivers then
        -- Find quest starter
        if quests[id]["start"] and not meta["questLogId"] then
            -- units
            if quests[id]["start"]["U"] then
                for _, unit in pairs(quests[id]["start"]["U"]) do
                    meta = meta or {}
                    meta["layer"] = meta["layer"] or 4
                    meta["texture"] = "Interface\\Addons\\ClassicCodex\\img\\available_c.tga"
                    maps = CodexDatabase:SearchUnitById(unit, meta, maps)
                end
            end

            -- objects
            if quests[id]["start"]["O"] then
                for _, object in pairs(quests[id]["start"]["O"]) do
                    meta = meta or {}
                    meta["texture"] = "Interface\\Addons\\ClassicCodex\\img\\available_c.tga"
                    maps = CodexDatabase:SearchObjectById(object, meta, maps)
                end
            end
        end

        -- Find quest ender
        if quests[id]["end"] then
            -- units
            if quests[id]["end"]["U"] then
                for _, unit in pairs(quests[id]["end"]["U"]) do
                    meta = meta or {}

                    if meta["questLogId"] then
                        local _, _, _, _, _, complete = GetQuestLogTitle(meta["questLogId"])
                        complete = complete or GetNumQuestLeaderBoards(meta["questLogId"]) == 0 and true or nil
                        if complete then
                            meta["texture"] = "Interface\\Addons\\ClassicCodex\\img\\complete_c.tga"
                        else
                            meta["texture"] = "Interface\\Addons\\ClassicCodex\\img\\complete.tga"
                        end
                    else
                        meta["texture"] = "Interface\\Addons\\ClassicCodex\\img\\complete_c.tga"
                    end
                    maps = CodexDatabase:SearchUnitById(unit, meta, maps)
                end
            end

            -- objects
            if quests[id]["end"]["O"] then
                for _, object in pairs(quests[id]["end"]["O"]) do
                    meta = meta or {}

                    if meta["questLogId"] then
                        local _, _, _, _, _, complete = GetQuestLogTitle(meta["questLogId"])
                        complete = complete or GetNumQuestLeaderBoards(meta["questLogId"]) == 0 and true or nil
                        if complete then
                            meta["texture"] = "Interface\\Addons\\ClassicCodex\\img\\complete_c.tga"
                        else
                            meta["texture"] = "Interface\\Addons\\ClassicCodex\\img\\complete.tga"
                        end
                    else
                        meta["texture"] = "Interface\\Addons\\ClassicCodex\\img\\complete_c.tga"
                    end
                    maps = CodexDatabase:SearchObjectById(object, meta, maps)
                end
            end
        end
    end

    local objectiveBlacklist = {
        ["U"] = {},
        ["O"] = {},
        ["I"] = {},
    }

    if meta["questLogId"] then
        local objectives = GetNumQuestLeaderBoards(meta["questLogId"])
        local _, _, _, _, _, complete = GetQuestLogTitle(meta["questLogId"])

        if objectives and not complete then
            for i = 1, objectives do
                local text, type, done = GetQuestLogLeaderBoard(i, meta["questLogId"])

                -- spawn data
                if type == "monster" then
                    local _, _, monsterName, objNum, objNeeded = strfind(text, Codex:SanitizePattern(QUEST_MONSTERS_KILLED))
                    for id in pairs(CodexDatabase:GetIdByName(monsterName, "units")) do
                        objectiveBlacklist["U"][id] = (objNum + 0 >= objNeeded + 0 or done) and "DONE" or "PROG"
                    end

                    for id in pairs(CodexDatabase:GetIdByName(monsterName, "objects")) do
                        objectiveBlacklist["O"][id] = (objNum + 0 >= objNeeded + 0 or done) and "DONE" or "PROG"
                    end
                end

                -- item data
                if type == "item" then
                    local _, _, itemName, objNum, objNeeded = strfind(text, Codex:SanitizePattern(QUEST_OBJECTS_FOUND))
                    for id in pairs(CodexDatabase:GetIdByName(itemName, "items")) do
                        objectiveBlacklist["I"][id] = (objNum + 0 >= objNeeded + 0 or done) and "DONE" or "PROG"
                    end
                end
            end
        end
    end

    if quests[id]["obj"] then
        if meta["questLogId"] then
            local _, _, _, _, _, complete = GetQuestLogTitle(meta["questLogId"])
            if complete then return maps end
        end

        -- Units
        if quests[id]["obj"]["U"] then
            for _, unit in pairs(quests[id]["obj"]["U"]) do
                if not objectiveBlacklist["U"][unit] or objectiveBlacklist["U"][unit] ~= "DONE" then
                    meta = meta or {}
                    meta["texture"] = nil
                    maps = CodexDatabase:SearchUnitById(unit, meta, maps)
                end
            end
        end

        -- Ojbects
        if quests[id]["obj"]["O"] then
            for _, object in pairs(quests[id]["obj"]["O"]) do
                if not objectiveBlacklist["O"][object] or objectiveBlacklist["O"][object] ~= "DONE" then
                    meta = meta or {}
                    meta["texture"] = nil
                    meta["layer"] = 2
                    maps = CodexDatabase:SearchObjectById(object, meta, maps)
                end
            end
        end

        -- Items
        if quests[id]["obj"]["I"] then
            for _, item in pairs(quests[id]["obj"]["I"]) do
                if not objectiveBlacklist["I"][item] or objectiveBlacklist["I"][item] ~= "DONE" then
                    meta = meta or {}
                    meta["texture"] = nil
                    meta["layer"] = 2
                    maps = CodexDatabase:SearchItemById(item, meta, maps)
                end
            end
        end
    end

    return maps
end

function CodexDatabase:SearchQuestByName(quest, meta, partial)
    local maps = {}

    for id in pairs(CodexDatabase:GetIdByName(quest, "quests", partial)) do
        maps = CodexDatabase:SearchQuestById(id, meta, maps)
    end

    return maps
end

-- Scans for all available quests
-- Adds map nodes for each quest starter and ender
function CodexDatabase:SearchQuests(meta, maps)
    local level, minLevel, maxLevel, race, class
    local maps = maps or {}
    local meta = meta or {}
    local completedQuests = GetQuestsCompleted()

    local playerLevel = UnitLevel("player")
    local playerFaction = UnitFactionGroup("player")
    if playerFaction == "Horde" then
        playerFaction = "H"
    elseif playerFaction == "Alliance" then
        playerFaction = "A"
    else
        playerFaction = "GM"
    end

    local _, race = UnitRace("player")
    local playerRace = CodexDatabase:GetBitByRace(race)
    local _, class = UnitClass("player")
    local playerClass = CodexDatabase:GetBitByClass(class)

    local currentQuests = {}
    for id=1, GetNumQuestLogEntries() do
        local _, _, _, header, _, _, _, questId = GetQuestLogTitle(id)
        if (not header) and CodexDB.quests.loc[questId] then
            -- Some quests have the same title, the same ends, but with different starts and different quest ids.
            -- They are mutually exclusive in game. Use title-based matching to filter out these quests.
            -- Also, the title returned by the Wow API is not used because the quest title in the database may not match the real title.
            local title = CodexDB.quests.loc[questId].T
            currentQuests[title] = true
        end
    end

    local function oneOfCompleted(questIds)
        if type(questIds) ~= 'table' then
            return completedQuests[questIds]
        end
        for _,id in pairs(questIds) do
            if completedQuests[id] then
                return true
            end
        end
        return false
    end

    local function allCompleted(questIds)
        if type(questIds) ~= 'table' then
            return completedQuests[questIds]
        end
        for _,id in pairs(questIds) do
            if not completedQuests[id] then
                return false
            end
        end
        return true
    end

    for id in pairs(quests) do
        minLevel = quests[id]["min"] or quests[id]["lvl"] or playerLevel
        maxLevel = quests[id]["lvl"] or quests[id]["min"] or playerLevel

        if CodexDB.quests.loc[id] and currentQuests[CodexDB.quests.loc[id].T] then
            -- hide active quest
        elseif completedQuests[id] then
            -- hide completed quests
        elseif CodexHiddenQuests[id] then
            -- hide quests hidden by the player
        elseif quests[id]["pre"] and not oneOfCompleted(quests[id]["pre"]) then
            -- hide missing pre-quest
            -- Need to complete one of these quests to pick up the quest
        elseif quests[id]["preg"] and not allCompleted(quests[id]["preg"]) then
            -- hide missing pre-quest groups
            -- Need to complete all these quests to pick up the quest
        elseif quests[id]["next"] and completedQuests[quests[id]["next"]] then
            -- hide unavailable quest because the next quest in the quest chain has been completed
        elseif quests[id]["excl"] and oneOfCompleted(quests[id]["excl"]) then
            -- hide unavailable quest because a quest that is mutually exclusive with the current quest has been completed
        elseif quests[id]["race"] and not (bit.band(quests[id]["race"], playerRace) == playerRace) then
            -- hide non-available quests for your race
        elseif quests[id]["class"] and not (bit.band(quests[id]["class"], playerClass) == playerClass) then
            -- hide non-available quests for your class
        elseif quests[id]["lvl"] and quests[id]["lvl"] < playerLevel - 9 and not CodexConfig.showLowLevel then
            -- hide low level quests
        elseif quests[id]["lvl"] and quests[id]["lvl"] > playerLevel + 10 then
            -- hide very high level quests
        elseif quests[id]["min"] and quests[id]["min"] > playerLevel + 3 then
            -- hide quests high level quests
        elseif quests[id]["hide"] and not CodexConfig.showFestival then
            -- hide event quests
        elseif minLevel > playerLevel and not CodexConfig.showHighLevel then
            -- hide level+3 quests
        elseif quests[id]["skill"] and not CodexDatabase:PlayerHasSkill(quests[id]["skill"]) then
            -- hide non-available quests for your profession??
        elseif quests[id]["repu"] and not CodexDatabase:PlayerHasReputation(quests[id]["repu"]) then
            -- hide non-available quests for poor reputation
        elseif id == 3861 then
            -- Hide the CLUCK! quest
        else
            -- set metadata
            meta["quest"] = (CodexDB.quests.loc[id] and CodexDB.quests.loc[id].T) or UNKNOWN
            meta["questId"] = id
            meta["texture"] = "Interface\\Addons\\ClassicCodex\\img\\available_c.tga"

            meta["questLevel"] = quests[id]["lvl"]
            meta["questMinimumLevel"] = quests[id]["min"]

            meta["vertex"] = {0, 0, 0}
            meta["layer"] = 3

            -- Tint high level quests red
            if minLevel > playerLevel then
                meta["texture"] = "Interface\\Addons\\ClassicCodex\\img\\available.tga"
                meta["vertex"] = {1, 0.4, 0.4}
                meta["layer"] = 2
            end

            -- Tint low level quests grey
            if maxLevel + 9 < playerLevel then
                meta["texture"] = "Interface\\Addons\\ClassicCodex\\img\\available.tga"
                meta["vertex"] = {1, 1, 1}
                meta["layer"] = 2
            end

            -- Festive quests
            if math.abs(minLevel - maxLevel) >= 30 then
                meta["texture"] = "Interface\\Addons\\ClassicCodex\\img\\available.tga"
                meta["vertex"] = {0.2, 0.8, 1}
                meta["layer"] = 2
            end

            -- iterate over all quest givers
            if quests[id]["start"] then
                -- units
                if quests[id]["start"]["U"] then
                    for _, unit in pairs(quests[id]["start"]["U"]) do
                        if units[unit] and strfind(units[unit]["fac"] or playerFaction, playerFaction) then
                            maps = CodexDatabase:SearchUnitById(unit, meta, maps)
                        end
                    end
                end

                -- objects
                if quests[id]["start"]["O"] then
                    for _, object in pairs(quests[id]["start"]["O"]) do
                        if objects[object] and strfind(objects[object]["fac"] or playerFaction, playerFaction) then
                            maps = CodexDatabase:SearchObjectById(object, meta, maps)
                        end
                    end
                end
            end
        end
    end
end

function CodexDatabase:SearchMetaRelation(query, meta, show)
    local maps = {}

    local relName = query[1] -- search name (chests / ores)
    local relMin = query[2] -- Min skill level
    local relMax = query[3] -- Max skill level

    if CodexDB["meta"] and CodexDB["meta"][relName] then
        for id, skill in pairs(CodexDB["meta"][relName]) do
            if (not relMin or tonumber(relMin) <= skill) and (not relMax or tonumber(relMax) >= skill) then
                if id < 0 then
                    CodexDatabase:SearchObjectById(math.abs(id), meta, maps)
                else
                    CodexDatabase:SearchUnitById(id, meta, maps)
                end
            end
        end
    end
    
    return maps
end

function CodexDatabase:FormatQuestText(text)
    text = string.gsub(text, "$[Nn]", UnitName("player"))
    text = string.gsub(text, "$[Cc]", strlower(UnitClass("player")))
    text = string.gsub(text, "$[Rr]", strlower(UnitRace("player")))
    text = string.gsub(text, "$[Bb]", "\n")

    return string.gsub(text, "($[Gg])(.+):(.+);", "%"..UnitSex("player"))
end

-- Deprecated: Since Blizzard's GetQuestLogTitle() returns the quest ID directly, no longer need to guess
-- Try to guess the quest ID based on the questlog ID
-- automatically runs a deep scan if no result was found.
-- Returns possible quest ID
--[[
function CodexDatabase:GetQuestIds(questId, deep)
    local oldId = GetQuestLogSelection()
    SelectQuestLogEntry(questId)
    local text, objective = GetQuestLogQuestText()
    local title, level, _, header = GetQuestLogTitle(questId)
    SelectQuestLogEntry(oldId)

    local _, race = UnitRace("player")
    local playerRace = CodexDatabase:GetBitByRace(race)
    local _, class = UnitClass("player")
    local playerClass = CodexDatabase:GetBitByClass(class)

    local best = 0
    local results = {}

    for id, data in pairs(CodexDB.quests.loc) do
        local score = 0

        if quests[id] and (data.T == title or (deep and strsub(CodexDatabase:FormatQuestText(CodexDB.quests.loc[id]["O"]), 0, 10) == strsub(objective, 0 ,10))) then
            if quests[id]["lvl"] == level then
                score = score + 1
            end

            if CodexDB.quests.loc[id]["O"] == objective then
                score = score + 2
            end

            if quests[id]["race"] and (bit.band(quests[id]["race"], playerRace) == playerRace) then
                score = score + 4
            end

            if quests[id]["class"] and (bit.band(quests[id]["class"], playerClass) == playerClass) then
                score = score + 4
            end

            local dbText = strsub(CodexDatabase:FormatQuestText(CodexDB.quests.loc[id]["D"]), 0, 10)
            local questText = strsub(text, 0 , 10)

            if CodexDatabase:CompareString(dbText, questText) < 0.1 then
                score = score + 8
            end

            if score > best then best = score end
            results[score] = results[score] or {}
            table.insert(results[score], id)
        end
    end

    return results[best] or (not deep and CodexDatabase:GetQuestIds(questId, 1) or {})
end
]]

-- BrowserSearch
-- Search for a list of IDs of the specified `searchType` based on if `query` is
-- part of the name or ID of the database entry it is compared against.
--
-- `query` must be a string. If the string represents a number, the search is
-- based on IDs, otherwise it compares names.
--
-- `searchType` must be one of these strings: "items", "quests", "objects" or
-- "units"
--
-- Returns a table and an integer, the latter being the element count of the
-- former. The table contains the ID as keys for the name of the search result.
-- E.g.: {{[5] = "Some Name", [231] = "Another Name"}, 2}
-- If the query doesn't satisfy the minimum search length requiered for its
-- type (number/string), the favourites for the `searchType` are returned.
function CodexDatabase:BrowserSearch(query, searchType, searchLimit)
    -- Search Mode: 1: title matching, 2: id matching, 3: completed quests, 4: hidden quests
    local searchMode = 1

    local questSet = nil
    if strlen(query) >= 1 then
        if query:sub(1, 1) == '@' then
            -- Start with @ to search complated quests
            searchMode = 3
            questSet = GetQuestsCompleted()
            query = query:sub(2)
        elseif query:sub(1, 1) == '!' then
            -- Start with @ to search manually hidden quests
            searchMode = 4
            questSet = CodexHiddenQuests
            query = query:sub(2)
        end
    end
    -- Start with # for exact match, such as "#123" or "#The People's Militia"
    local exactMatch = false
    if strlen(query) >= 1 and query:sub(1, 1) == '#' then
        exactMatch = true
        query = query:sub(2)
    end

    if searchMode == 1 and tonumber(query) then
        searchMode = 2
    end

    local queryLength = strlen(query)
    local results = {}
    local resultCount = 0

    -- Set the DB to be searched
    local minChars = 3
    local minInts = 1
    if questSet or (queryLength >= minChars) or (searchMode == 2 and (queryLength >= minInts)) then
        if questSet then
            results, resultCount = CodexDatabase:SearchQuestInSet(questSet, query, searchType, exactMatch, searchLimit)
        elseif searchMode == 2 then
            results, resultCount = CodexDatabase:GetIdByPartialId(query, searchType, exactMatch, searchLimit)
        else
            results, resultCount = CodexDatabase:GetIdByName(query, searchType, not exactMatch, searchLimit)
        end

        return results, resultCount, searchMode
    else
        -- min search length not satisfied, reset search results and return favorites or nil
        return {}, -1, nil
    end
end
