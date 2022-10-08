local myname, ns = ...
local _, myfullname = GetAddOnInfo(myname)

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HL = LibStub("AceAddon-3.0"):NewAddon(myname, "AceEvent-3.0")
-- local L = LibStub("AceLocale-3.0"):GetLocale(myname, true)
ns.HL = HL

local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")

ns.DEBUG = GetAddOnMetadata(myname, "Version") == 'v6'

ns.CLASSIC = WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE

local ATLAS_CHECK, ATLAS_CROSS = "common-icon-checkmark", "common-icon-redx"
if ns.CLASSIC then
    ATLAS_CHECK, ATLAS_CROSS = "Tracker-Check", "Objective-Fail"
end

---------------------------------------------------------
-- Data model stuff:

-- flags for whether to show minimap icons in some zones, if Blizzard ever does the treasure-map thing again
ns.map_spellids = ns.map_spellids or {
    -- zone = spellid
}

ns.currencies = ns.currencies or {
    ANIMA = {
        name = '|cffff8000' .. POWER_TYPE_ANIMA .. '|r',
        texture = select(10, GetAchievementInfo(14339)),
    },
    ARTIFACT = {
        name = '|cffff8000' .. ARTIFACT_POWER .. '|r',
        texture = select(10, GetAchievementInfo(11144)),
    }
}
-- for fallbacks
ns.covenants = ns.covenants or {
    [Enum.CovenantType.Kyrian] = "Kyrian",
    [Enum.CovenantType.Necrolord] = "Necrolords",
    [Enum.CovenantType.NightFae] = "NightFae",
    [Enum.CovenantType.Venthyr] = "Venthyr",
}

ns.groups = ns.groups or {}

ns.hiddenConfig = ns.hiddenConfig or {}

ns.points = {
    --[[ structure:
    [uiMapID] = { -- "_terrain1" etc will be stripped from attempts to fetch this
        [coord] = {
            label=[string], -- label: text that'll be the label, optional
            loot={[id]}, -- itemids
            quest=[id], -- will be checked, for whether character already has it
            currency=[id], -- currencyid
            achievement=[id], -- will be shown in the tooltip
            criteria=[id], -- modifies achievement
            junk=[bool], -- doesn't count for any achievement
            npc=[id], -- related npc id, used to display names in tooltip
            note=[string], -- some text which might be helpful
            hide_before=[id], -- hide if quest not completed
            requires_buff=[id], -- hide if player does not have buff, mostly useful for buff-based zone phasing
            requires_no_buff=[id] -- hide if player has buff, mostly useful for buff-based zone phasing
        },
    },
    --]]
}
ns.POIsToPoints = {}
ns.VignetteIDsToPoints = {}
ns.WorldQuestsToPoints = {}
local function intotable(dest, value_or_table, point)
    if not value_or_table then return end
    if type(value_or_table) == "table" then
        for _, value in ipairs(value_or_table) do
            dest[value] = point
        end
        return
    end
    dest[value_or_table] = point
end
function ns.RegisterPoints(zone, points, defaults)
    if not ns.points[zone] then
        ns.points[zone] = {}
    end
    if defaults then
        local nodeType = ns.nodeMaker(defaults)
        for coord, point in pairs(points) do
            points[coord] = nodeType(point)
        end
    end
    ns.merge(ns.points[zone], points)
    for coord, point in pairs(points) do
        point._coord = coord
        point._uiMapID = zone
        intotable(ns.POIsToPoints, point.areaPoi, point)
        intotable(ns.VignetteIDsToPoints, point.vignette, point)
        intotable(ns.WorldQuestsToPoints, point.worldquest, point)
        if point.route and type(point.route) == "table" then
            -- avoiding a data migration
            point.routes = {point.route}
            point.route = nil
        end
        local proxy_meta
        if point.path or point.nearby then
            proxy_meta = {__index=point}
        end
        if point.path then
            local route = type(point.path) == "table" and point.path or {point.path}
            table.insert(route, 1, coord)
            ns.points[zone][route[#route]] = setmetatable({
                label=route.label or (point.npc and "Path to NPC" or "Path to treasure"),
                atlas=route.atlas or "poi-door", scale=route.scale or 0.95, minimap=true, texture=false,
                note=route.note or false,
                loot=route.loot,
                routes={route},
                _coord=route[#route],
            }, proxy_meta)
            -- highlight
            point.route = point.route or route[#route]
        end
        if point.nearby then
            local nearby = type(point.nearby) == "table" and point.nearby or {point.nearby}
            for _, ncoord in ipairs(point.nearby) do
                local npoint = setmetatable({
                    label=nearby.label or (point.npc and "Related to nearby NPC" or "Related to nearby treasure"),
                    atlas=nearby.atlas or "playerpartyblip",
                    texture=nearby.texture or false,
                    minimap=true, worldmap=false, scale=0.95,
                    note=nearby.note or false,
                    _coord=ncoord,
                }, proxy_meta)
                if nearby.color then
                    npoint.texture = ns.atlas_texture(npoint.atlas, nearby.color)
                end
                ns.points[zone][ncoord] = npoint
            end
        end
    end
end
function ns.RegisterVignettes(zone, vignettes, defaults)
    if defaults then
        defaults = ns.nodeMaker(defaults)
    end
    for vignetteID, point in pairs(vignettes) do
        point._coord = point._coord or 0
        point._uiMapID = zone
        point.always = true
        point.label = false

        ns.VignetteIDsToPoints[vignetteID] = defaults and defaults(point) or point
    end
end

ns.merge = function(t1, t2)
    if not t2 then return t1 end
    for k, v in pairs(t2) do
        t1[k] = v
    end
    return t1
end

ns.nodeMaker = function(defaults)
    local meta = {__index = defaults}
    return function(details)
        details = details or {}
        if details.note and defaults.note then
            details.note = details.note .. "\n" .. defaults.note
        end
        local meta2 = getmetatable(details)
        if meta2 and meta2.__index then
            return setmetatable(details, {__index = ns.merge(CopyTable(defaults), meta2.__index)})
        end
        return setmetatable(details, meta)
    end
end

ns.path = ns.nodeMaker{
    label = "Path to treasure",
    atlas = "poi-door", -- 'PortalPurple' / 'PortalRed'?
    minimap = true,
    scale = 0.95,
}

ns.lootitem = function(item)
    return type(item) == "table" and item[1] or item
end

local playerClassLocal, playerClass = UnitClass("player")
ns.playerClass = playerClass
ns.playerClassLocal = playerClassLocal
ns.playerClassColor = RAID_CLASS_COLORS[playerClass]
ns.playerName = UnitName("player")
ns.playerFaction = UnitFactionGroup("player")
ns.playerClassMask = ({
    WARRIOR = 0x1,
    PALADIN = 0x2,
    HUNTER = 0x4,
    ROGUE = 0x8,
    PRIEST = 0x10,
    DEATHKNIGHT = 0x20,
    SHAMAN = 0x40,
    MAGE = 0x80,
    WARLOCK = 0x100,
    MONK = 0x200,
    DRUID = 0x400,
    DEMONHUNTER = 0x800,
})[playerClass] or 0

---------------------------------------------------------
-- All the utility code

local cache_tooltip = _G["HNTreasuresCacheScanningTooltip"]
if not cache_tooltip then
    cache_tooltip = CreateFrame("GameTooltip", "HNTreasuresCacheScanningTooltip")
    cache_tooltip:AddFontStrings(
        cache_tooltip:CreateFontString("$parentTextLeft1", nil, "GameTooltipText"),
        cache_tooltip:CreateFontString("$parentTextRight1", nil, "GameTooltipText")
    )
end
local name_cache = {}
local function mob_name(id)
    if not name_cache[id] then
        -- this doesn't work with just clearlines and the setowner outside of this, and I'm not sure why
        cache_tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
        cache_tooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(id))
        if cache_tooltip:IsShown() then
            name_cache[id] = HNTreasuresCacheScanningTooltipTextLeft1:GetText()
        end
    end
    return name_cache[id]
end
local function quick_texture_markup(icon)
    -- needs less than CreateTextureMarkup
    return icon and ('|T' .. icon .. ':0:0:1:-1|t') or ''
end
local completeColor = CreateColor(0, 1, 0, 1)
local incompleteColor = CreateColor(1, 0, 0, 1)
local function render_string(s, context)
    if type(s) == "function" then s = s(context) end
    return s:gsub("{(%l+):([^:}]+):?([^}]*)}", function(variant, id, fallback)
        local mainid, subid = id:match("(%d+)%.(%d+)")
        mainid, subid = mainid and tonumber(mainid), subid and tonumber(subid)
        id = tonumber(id)
        if variant == "item" then
            local name, link, _, _, _, _, _, _, _, icon = GetItemInfo(id)
            if link and icon then
                return quick_texture_markup(icon) .. " " .. link:gsub("[%[%]]", "")
            end
        elseif variant == "spell" then
            local name, _, icon = GetSpellInfo(id)
            if name and icon then
                return quick_texture_markup(icon) .. " " .. name
            end
        elseif variant == "quest" or variant == "worldquest" then
            local name = C_QuestLog.GetTitleForQuestID(id)
            if not (name and name ~= "") then
                name = tostring(id)
            end
            local completed = C_QuestLog.IsQuestFlaggedCompleted(id)
            return CreateAtlasMarkup(variant == "worldquest" and "worldquest-tracker-questmarker" or "questnormal") ..
                (completed and completeColor or incompleteColor):WrapTextInColorCode(name)
        elseif variant == "questid" then
            return CreateAtlasMarkup("questnormal") .. (C_QuestLog.IsQuestFlaggedCompleted(id) and completeColor or incompleteColor):WrapTextInColorCode(id)
        elseif variant == "achievement" then
            if mainid and subid then
                local criteria = (subid < 40 and GetAchievementCriteriaInfo or GetAchievementCriteriaInfoByID)(mainid, subid)
                if criteria then
                    return criteria
                end
                id = 'achievement:'..mainid..'.'..subid
            else
                local _, name, _, completed = GetAchievementInfo(id)
                if name and name ~= "" then
                    return CreateAtlasMarkup("storyheader-cheevoicon") .. " " .. (completed and completeColor or incompleteColor):WrapTextInColorCode(name)
                end
            end
        elseif variant == "npc" then
            local name = mob_name(id)
            if name then
                return name
            end
        elseif variant == "currency" then
            local info = C_CurrencyInfo.GetCurrencyInfo(id)
            if info then
                return quick_texture_markup(info.iconFileID) .. " " .. info.name
            end
        elseif variant == "currencyicon" then
            local info = C_CurrencyInfo.GetCurrencyInfo(id)
            if info then
                return quick_texture_markup(info.iconFileID)
            end
        elseif variant == "covenant" then
            local data = C_Covenants.GetCovenantData(id)
            return COVENANT_COLORS[id]:WrapTextInColorCode(data and data.name or ns.covenants[id])
        elseif variant == "garrisontalent" then
            local info = C_Garrison.GetTalentInfo(id)
            if info then
                return quick_texture_markup(info.icon) .. " " .. (info.researched and completeColor or incompleteColor):WrapTextInColorCode(info.name)
            end
        end
        return fallback ~= "" and fallback or (variant .. ':' .. id)
    end)
end
local function cache_string(s, context)
    if not s then return end
    if type(s) == "function" then s = s(context) end
    for variant, id, fallback in s:gmatch("{(%l+):(%d+):?([^}]*)}") do
        id = tonumber(id)
        if variant == "item" then
            C_Item.RequestLoadItemDataByID(id)
        elseif variant == "spell" then
            C_Spell.RequestLoadSpellData(id)
        elseif variant == "quest" or variant == "worldquest" then
            C_QuestLog.RequestLoadQuestByID(id)
        elseif variant == "npc" then
            mob_name(id)
        end
    end
end
local function cache_loot(loot)
    if not loot then return end
    for _, item in ipairs(loot) do
        C_Item.RequestLoadItemDataByID(ns.lootitem(item))
    end
end
local render_string_list
do
    local out = {}
    function render_string_list(point, variant, ...)
        if not ... then return "" end
        if type(...) == "table" then return render_string_list(point, variant, unpack(...)) end
        wipe(out)
        for i=1,select("#", ...) do
            table.insert(out, ("{%s:%d}"):format(variant, (select(i, ...))))
        end
        return render_string(string.join(", ", unpack(out)), point)
    end
end
ns.render_string = render_string
ns.render_string_list = render_string_list

local npc_texture, follower_texture, currency_texture, junk_texture
local icon_cache = {}
local trimmed_icon = function(texture)
    if not icon_cache[texture] then
        icon_cache[texture] = {
            icon = texture,
            tCoordLeft = 0.1,
            tCoordRight = 0.9,
            tCoordTop = 0.1,
            tCoordBottom = 0.9,
        }
    end
    return icon_cache[texture]
end
local atlas_texture = function(atlas, extra, crop)
    atlas = C_Texture.GetAtlasInfo(atlas)
    if type(extra) == "number" then
        extra = {scale=extra}
    end
    if crop then
        local xcrop = (atlas.rightTexCoord - atlas.leftTexCoord) * crop
        local ycrop = (atlas.bottomTexCoord - atlas.topTexCoord) * crop
        atlas.rightTexCoord = atlas.rightTexCoord - xcrop
        atlas.leftTexCoord = atlas.leftTexCoord + xcrop
        atlas.bottomTexCoord = atlas.bottomTexCoord - ycrop
        atlas.topTexCoord = atlas.topTexCoord + xcrop
    end
    return ns.merge({
        icon = atlas.file,
        tCoordLeft = atlas.leftTexCoord, tCoordRight = atlas.rightTexCoord, tCoordTop = atlas.topTexCoord, tCoordBottom = atlas.bottomTexCoord,
    }, extra)
end
ns.atlas_texture = atlas_texture
local default_textures = {
    VignetteLoot = atlas_texture("VignetteLoot", 1.1),
    VignetteLootElite = atlas_texture("VignetteLootElite", 1.2),
    Garr_TreasureIcon = atlas_texture("Garr_TreasureIcon", 2.2),
}
local function work_out_label(point)
    local fallback
    if point.label then
        return (render_string(point.label, point))
    end
    if point.achievement and point.criteria and type(point.criteria) ~= "table" and point.criteria ~= true then
        local criteria = (point.criteria < 40 and GetAchievementCriteriaInfo or GetAchievementCriteriaInfoByID)(point.achievement, point.criteria)
        if criteria then
            return criteria
        end
        fallback = 'achievement:'..point.achievement..'.'..point.criteria
    end
    if point.follower then
        local follower = C_Garrison.GetFollowerInfo(point.follower)
        if follower then
            return follower.name
        end
        fallback = 'follower:'..point.follower
    end
    if point.npc then
        local name = mob_name(point.npc)
        if name then
            return name
        end
        fallback = 'npc:'..point.npc
    end
    if point.loot and #point.loot > 0 then
        -- handle multiples?
        local _, link = GetItemInfo(ns.lootitem(point.loot[1]))
        if link then
            return link:gsub("[%[%]]", "")
        end
        fallback = 'item:'..ns.lootitem(point.loot[1])
    end
    if point.achievement and not point.criteria or point.criteria == true then
        local _, achievement = GetAchievementInfo(point.achievement)
        if achievement then
            return achievement
        end
        fallback = 'achievement:'..point.achievement
    end
    if point.currency then
        if ns.currencies[point.currency] then
            return ns.currencies[point.currency].name
        end
        local info = C_CurrencyInfo.GetCurrencyInfo(point.currency)
        if info then
            return info.name
        end
    end
    return fallback or UNKNOWN
end
local function work_out_texture(point)
    if point.texture then
        return point.texture
    end
    if point.atlas then
        if not icon_cache[point.atlas] then
            icon_cache[point.atlas] = atlas_texture(point.atlas, point.scale)
        end
        return icon_cache[point.atlas]
    end
    if ns.db.icon_item or point.icon then
        if point.loot and #point.loot > 0 then
            local texture = select(10, GetItemInfo(ns.lootitem(point.loot[1])))
            if texture then
                return trimmed_icon(texture)
            end
        end
        if point.currency then
            if ns.currencies[point.currency] then
                local texture = ns.currencies[point.currency].texture
                if texture then
                    return trimmed_icon(texture)
                end
            else
                local info = C_CurrencyInfo.GetCurrencyInfo(point.currency)
                if info then
                    return trimmed_icon(info.iconFileID)
                end
            end
        end
        if point.achievement then
            local texture = select(10, GetAchievementInfo(point.achievement))
            if texture then
                return trimmed_icon(texture)
            end
        end
    end
    if point.follower then
        if not follower_texture then
            follower_texture = atlas_texture("GreenCross", 1.5)
        end
        return follower_texture
    end
    if point.npc then
        if not npc_texture then
            npc_texture = atlas_texture("DungeonSkull", 1)
        end
        return npc_texture
    end
    if point.currency then
        if not currency_texture then
            currency_texture = atlas_texture("Auctioneer", 1.3)
        end
        return currency_texture
    end
    if point.junk then
        if not junk_texture then
            junk_texture = atlas_texture("VignetteLoot", 1)
        end
        return junk_texture
    end
    if not default_textures[ns.db.default_icon] then
        default_textures[ns.db.default_icon] = atlas_texture(ns.db.default_icon, 1.5)
    end
    return default_textures[ns.db.default_icon] or default_textures["VignetteLoot"]
end
ns.point_active = function(point)
    if point.IsActive and not point:IsActive() then
        return false
    end
    if not point.active then
        return true
    end
    return ns.conditions.check(point.active)
end
ns.point_upcoming = function(point)
    if point.level and UnitLevel("player") < point.level then
        return true
    end
    if point.hide_before and not ns.conditions.check(point.hide_before) then
        return true
    end
    if point.covenant and point.covenant ~= C_Covenants.GetActiveCovenantID() then
        return true
    end
    return false
end
local inactive_cache = {}
local function get_inactive_texture_variant(icon)
    if not inactive_cache[icon] then
        inactive_cache[icon] = CopyTable(icon)
        if inactive_cache[icon].r then
            inactive_cache[icon].a = 0.5
        else
            inactive_cache[icon].r = 0.5
            inactive_cache[icon].g = 0.5
            inactive_cache[icon].b = 0.5
            inactive_cache[icon].a = 1
        end
    end
    return inactive_cache[icon]
end
local upcoming_cache = {}
local function get_upcoming_texture_variant(icon)
    if not upcoming_cache[icon] then
        upcoming_cache[icon] = CopyTable(icon)
        upcoming_cache[icon].r = 1
        upcoming_cache[icon].g = 0
        upcoming_cache[icon].b = 0
        upcoming_cache[icon].a = 0.7
    end
    return upcoming_cache[icon]
end
local get_point_info = function(point, isMinimap)
    if point then
        local label = work_out_label(point)
        local icon = work_out_texture(point)
        if not ns.point_active(point) then
            icon = get_inactive_texture_variant(icon)
        elseif ns.point_upcoming(point) then
            icon = get_upcoming_texture_variant(icon)
        end
        local category = "treasure"
        if point.npc then
            category = "npc"
        elseif point.junk then
            category = "junk"
        end
        if not isMinimap then
            cache_string(point.label, point)
            cache_string(point.note, point)
            cache_loot(point.loot, point)
        end
        return label, icon, category, point.quest, point.faction, point.scale, point.alpha or 1
    end
end
local get_point_info_by_coord = function(uiMapID, coord)
    return get_point_info(ns.points[uiMapID] and ns.points[uiMapID][coord])
end
local get_point_progress = function(point)
    if type(point.progress) == "number" then
        -- shortcut: if the progress is an objective of the tracking quest
        return select(4, GetQuestObjectiveInfo(point.quest, point.progress, false))
    elseif type(point.progress) == "table" then
        for i, q in ipairs(point.progress) do
            if not C_QuestLog.IsQuestFlaggedCompleted(q) then
                return i - 1, #point.progress
            end
        end
        return #point.progress, #point.progress
    else
        -- function
        return point:progress()
    end
end

local function tooltip_criteria(tooltip, achievement, criteriaid, ignore_quantityString)
    local getinfo = (criteriaid < 40 and GetAchievementCriteriaInfo or GetAchievementCriteriaInfoByID)
    local criteria, _, complete, _, _, _, _, _, quantityString = getinfo(achievement, criteriaid, true) -- include hidden
    if quantityString and not ignore_quantityString then
        tooltip:AddDoubleLine(
            (criteria and #criteria > 0) and criteria or PVP_PROGRESS_REWARDS_HEADER, quantityString,
            complete and 0 or 1, complete and 1 or 0, 0,
            complete and 0 or 1, complete and 1 or 0, 0
        )
    else
        tooltip:AddDoubleLine(" ", criteria,
            nil, nil, nil,
            complete and 0 or 1, complete and 1 or 0, 0
        )
    end
end
local function tooltip_loot(tooltip, item)
    local knownText
    local r, g, b = NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b
    local id = ns.lootitem(item)
    local _, itemType, itemSubtype, equipLoc, icon, classID, subclassID = GetItemInfoInstant(id)
    if ns.db.tooltip_charloot and not IsShiftKeyDown() then
        -- show loot for the current character only
        -- can't pass in a reusable table for the second argument because it changes the no-data case
        local specTable = GetItemSpecInfo(id)
        -- Some cosmetic items seem to be flagged as not dropping for any spec. I
        -- could only confirm this for some cosmetic back items but let's play it
        -- safe and say that any cosmetic item can drop regardless of what the
        -- spec info says...
        if specTable and #specTable == 0 and not (_G.IsCosmeticItem and IsCosmeticItem(id)) then
            return true
        end
        -- then catch covenants / classes / etc
        if ns.itemRestricted(item) then return true end
    end
    local _, link = GetItemInfo(ns.lootitem(item))
    local label = ENCOUNTER_JOURNAL_ITEM
    if classID == Enum.ItemClass.Armor and subclassID ~= Enum.ItemArmorSubclass.Shield then
        label = _G[equipLoc] or label
    else
        label = itemSubtype
    end
    if link then
        link = link:gsub("[%[%]]", "")
    else
        r, g, b = 0, 1, 1
        link = SEARCH_LOADING_TEXT
    end
    if type(item) == "table" then
        if item.mount then label = MOUNT
        elseif item.toy then label = TOY
        elseif item.pet then label = TOOLTIP_BATTLE_PET
        elseif item.set then
            label = WARDROBE_SETS
            local info = C_TransmogSets.GetSetInfo(item.set)
            if info then
                link = info.name
                if not info.collected then
                    local sources = C_TransmogSets.GetSetPrimaryAppearances(item.set)
                    if sources and #sources > 0 then
                        local numKnown = 0
                        for _, source in pairs(sources) do
                            if source.collected then
                                numKnown = numKnown + 1
                            end
                        end
                        knownText = RED_FONT_COLOR:WrapTextInColorCode(GENERIC_FRACTION_STRING:format(numKnown, #sources))
                    end
                end
            end
        end
        -- todo: faction?
        if item.covenant then
            local data = C_Covenants.GetCovenantData(item.covenant)
            -- local active = item.covenant == C_Covenants.GetActiveCovenantID()
            link = TEXT_MODE_A_STRING_VALUE_TYPE:format(link, COVENANT_COLORS[item.covenant]:WrapTextInColorCode(data and data.name or ns.covenants[item.covenant]))
        end
        if item.class then
            link = TEXT_MODE_A_STRING_VALUE_TYPE:format(link, RAID_CLASS_COLORS[item.class]:WrapTextInColorCode(LOCALIZED_CLASS_NAMES_FEMALE[item.class]))
        end
        if item.note then
            link = TEXT_MODE_A_STRING_VALUE_TYPE:format(link, render_string(item.note))
        end
    end
    local known = ns.itemIsKnown(item)
    if known ~= nil and (known == true or not ns.itemRestricted(item)) then
        if knownText then
            link = link .. " " .. knownText
        else
            link = link .. " " .. CreateAtlasMarkup(known and ATLAS_CHECK or ATLAS_CROSS)
        end
    end
    tooltip:AddDoubleLine(label, quick_texture_markup(icon) .. " " .. link,
        NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b,
        r, g, b
    )
end
local function handle_tooltip(tooltip, point, skip_label)
    if not point then
        tooltip:SetText(UNKNOWN)
        tooltip:Show()
        return
    end
    -- major:
    if not skip_label and point.label ~= false then
        tooltip:AddLine(work_out_label(point))
    end
    if point.follower then
        local follower = C_Garrison.GetFollowerInfo(point.follower)
        if follower then
            local quality = BAG_ITEM_QUALITY_COLORS[follower.quality]
            tooltip:AddDoubleLine(REWARD_FOLLOWER, follower.name,
                0, 1, 0,
                quality.r, quality.g, quality.b
            )
            tooltip:AddDoubleLine(follower.className, UNIT_LEVEL_TEMPLATE:format(follower.level))
        end
    end
    if point.currency then
        local name
        if ns.currencies[point.currency] then
            name = ns.currencies[point.currency].name
        else
            local info = C_CurrencyInfo.GetCurrencyInfo(point.currency)
            name = info and info.name
        end
        tooltip:AddDoubleLine(CURRENCY, name or point.currency)
    end
    if point.achievement then
        local _, name, _, complete = GetAchievementInfo(point.achievement)
        tooltip:AddDoubleLine(BATTLE_PET_SOURCE_6, name or point.achievement,
            nil, nil, nil,
            complete and 0 or 1, complete and 1 or 0, 0
        )
        if point.criteria then
            if point.criteria == true then
                local numCriteria = GetAchievementNumCriteria(point.achievement, true) -- include hidden
                if numCriteria > 10 then
                    local numComplete = 0
                    for criteria=1, numCriteria do
                        if select(3, GetAchievementCriteriaInfo(point.achievement, criteria, true)) then
                            numComplete = numComplete + 1
                        end
                    end
                    tooltip:AddDoubleLine(" ", GENERIC_FRACTION_STRING:format(numComplete, numCriteria),
                        nil, nil, nil,
                        complete and 0 or 1, complete and 1 or 0, 0
                    )
                else
                    for criteria=1, numCriteria do
                        tooltip_criteria(tooltip, point.achievement, criteria, true)
                    end
                end
            elseif type(point.criteria) == "table" then
                for _, criteria in ipairs(point.criteria) do
                    tooltip_criteria(tooltip, point.achievement, criteria, true)
                end
            elseif type(point.criteria) == "number" then
                tooltip_criteria(tooltip, point.achievement, point.criteria, true)
            end
        elseif GetAchievementNumCriteria(point.achievement) == 1 then
            tooltip_criteria(tooltip, point.achievement, 1)
        end
    end
    if point.progress then
        local fulfilled, required = get_point_progress(point)
        if fulfilled and required then
            tooltip:AddDoubleLine(PVP_PROGRESS_REWARDS_HEADER, GENERIC_FRACTION_STRING:format(fulfilled, required))
        end
    end
    if point.note then
        tooltip:AddLine(render_string(point.note, point), 1, 1, 1, true)
    end
    if point.loot then
        local hidden
        for _, item in ipairs(point.loot) do
            hidden = tooltip_loot(tooltip, item) or hidden
        end
        if hidden then
            tooltip:AddLine("Items for other characters hidden", 0, 1, 1)
        end
    end
    if point.covenant then
        local data = C_Covenants.GetCovenantData(point.covenant)
        local active = point.covenant == C_Covenants.GetActiveCovenantID()
        local cname = COVENANT_COLORS[point.covenant]:WrapTextInColorCode(data and data.name or ns.covenants[point.covenant])
        tooltip:AddLine(ITEM_REQ_SKILL:format(cname), active and 0 or 1, active and 1 or 0, 0)
    end
    if point.level and point.level > UnitLevel("player") then
        tooltip:AddLine(ITEM_MIN_LEVEL:format(point.level), 1, 0, 0)
    end
    if point.hide_before and not ns.conditions.check(point.hide_before) then
        tooltip:AddLine(COMMUNITY_TYPE_UNAVAILABLE, 1, 0, 0)
        tooltip:AddLine(ns.render_string(ns.conditions.summarize(point.hide_before), point), 1, 0, 0, true)
    end
    if point.active then
        local isActive = ns.point_active(point)
        tooltip:AddLine(
            ns.render_string(point.active.note or ns.conditions.summarize(point.active), point),
            isActive and 0 or 1, isActive and 1 or 0, 0, true
        )
    end

    if point.group then
        tooltip:AddDoubleLine(GROUP, render_string(ns.groups[point.group] or point.group, point))
    end

    if point.quest and ns.db.tooltip_questid then
        tooltip:AddDoubleLine("QuestID", render_string_list(point, "questid", point.quest), NORMAL_FONT_COLOR:GetRGB())
    end

    if ns.DEBUG then
        tooltip:AddDoubleLine("Coord", point._coord)
    end

    if (ns.db.tooltip_item or IsShiftKeyDown()) and (point.loot or point.npc or point.spell) then
        local comparison = ShoppingTooltip1

        do
            local side
            local leftPos = tooltip:GetLeft() or 0
            local rightPos = tooltip:GetRight() or 0
            local rightDist = GetScreenWidth() - rightPos

            if (leftPos and (rightDist < leftPos)) then
                side = "left"
            else
                side = "right"
            end

            -- see if we should slide the tooltip
            if tooltip:GetAnchorType() and tooltip:GetAnchorType() ~= "ANCHOR_PRESERVE" then
                local totalWidth = 0
                if ( primaryItemShown  ) then
                    totalWidth = totalWidth + comparison:GetWidth()
                end

                if ( (side == "left") and (totalWidth > leftPos) ) then
                    tooltip:SetAnchorType(tooltip:GetAnchorType(), (totalWidth - leftPos), 0)
                elseif ( (side == "right") and (rightPos + totalWidth) >  GetScreenWidth() ) then
                    tooltip:SetAnchorType(tooltip:GetAnchorType(), -((rightPos + totalWidth) - GetScreenWidth()), 0)
                end
            end

            comparison:SetOwner(tooltip, "ANCHOR_NONE")
            comparison:ClearAllPoints()

            if ( side and side == "left" ) then
                comparison:SetPoint("TOPRIGHT", tooltip, "TOPLEFT", 0, -10)
            else
                comparison:SetPoint("TOPLEFT", tooltip, "TOPRIGHT", 0, -10)
            end
        end

        if point.loot and #point.loot > 0 then
            comparison:SetItemByID(ns.lootitem(point.loot[1]))
        elseif point.npc then
            comparison:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(point.npc))
        elseif point.spell then
            comparison:SetSpellByID(point.spell)
        end
        comparison:Show()
    end

    tooltip:Show()
end
local handle_tooltip_by_coord = function(tooltip, uiMapID, coord)
    return handle_tooltip(tooltip, ns.points[uiMapID] and ns.points[uiMapID][coord])
end

---------------------------------------------------------
-- Plugin Handlers to HandyNotes
local HLHandler = {}

function HLHandler:OnEnter(uiMapID, coord)
    local point = ns.points[uiMapID] and ns.points[uiMapID][coord]
    if ns.RouteWorldMapDataProvider and (point.route or point.routes) then
        if point.route and ns.points[uiMapID][point.route] then
            point = ns.points[uiMapID][point.route]
        end
        ns.RouteWorldMapDataProvider:HighlightRoute(point, uiMapID, coord)
    end
    local tooltip = GameTooltip
    if ns.db.tooltip_pointanchor or self:GetParent() == Minimap then
        if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
            tooltip:SetOwner(self, "ANCHOR_LEFT")
        else
            tooltip:SetOwner(self, "ANCHOR_RIGHT")
        end
    else
        tooltip:SetOwner(WorldMapFrame.ScrollContainer, "ANCHOR_NONE")
        local x, y = HandyNotes:getXY(coord)
        if y < 0.5 then
            tooltip:SetPoint("BOTTOMLEFT", WorldMapFrame.ScrollContainer)
        else
            tooltip:SetPoint("TOPLEFT", WorldMapFrame.ScrollContainer)
        end
    end
    handle_tooltip_by_coord(tooltip, uiMapID, coord)
end

local function showAchievement(button, achievement)
    if OpenAchievementFrameToAchievement then
        OpenAchievementFrameToAchievement(achievement)
    else
        -- probably classic
        if ( not AchievementFrame ) then
            AchievementFrame_LoadUI()
        end
        if ( not AchievementFrame:IsShown() ) then
            AchievementFrame_ToggleAchievementFrame()
        end
        AchievementFrame_SelectAchievement(achievement)
    end
end

local function createWaypoint(button, uiMapID, coord)
    if TomTom then
        local x, y = HandyNotes:getXY(coord)
        TomTom:AddWaypoint(uiMapID, x, y, {
            title = get_point_info_by_coord(uiMapID, coord),
            persistent = nil,
            minimap = true,
            world = true
        })
    end
end

local function hideNode(button, uiMapID, coord)
    ns.hidden[uiMapID][coord] = true
    HL:Refresh()
end
local function hideAchievement(button, achievement)
    ns.db.achievementsHidden[achievement] = true
    HL:Refresh()
end
local function hideGroup(button, uiMapID, coord)
    local point = ns.points[uiMapID] and ns.points[uiMapID][coord]
    if not (point and point.group) then return end
    ns.db.groupsHidden[point.group] = true
    HL:Refresh()
end
local function hideGroupZone(button, uiMapID, coord)
    local point = ns.points[uiMapID] and ns.points[uiMapID][coord]
    if not (point and point.group) then return end
    ns.db.groupsHiddenByZone[uiMapID][point.group] = true
    HL:Refresh()
end

local function sendToChat(button, uiMapID, coord)
    local title = get_point_info_by_coord(uiMapID, coord)
    local x, y = HandyNotes:getXY(coord)
    local message = ("%s|cffffff00|Hworldmap:%d:%d:%d|h[%s]|h|r"):format(
        title and (title .. " ") or "",
        uiMapID,
        x * 10000,
        y * 10000,
        -- Can't do this:
        -- core:GetMobLabel(self.data.id) or UNKNOWN
        -- WoW seems to filter out anything which isn't the standard MAP_PIN_HYPERLINK
        MAP_PIN_HYPERLINK
    )
    PlaySound(SOUNDKIT.UI_MAP_WAYPOINT_CHAT_SHARE)
    -- if you have an open editbox, just paste to it
    if not ChatEdit_InsertLink(message) then
        -- open the chat to whatever it was on and add the text
        ChatFrame_OpenChat(message)
    end
end

local function closeAllDropdowns()
    LibDD:CloseDropDownMenus(1)
end

do
    local currentZone, currentCoord
    local function generateMenu(button, level)
        local point = ns.points[currentZone] and ns.points[currentZone][currentCoord]
        if not (level and point) then return end
        local info = LibDD:UIDropDownMenu_CreateInfo()
        if (level == 1) then
            -- Create the title of the menu
            info.isTitle = 1
            info.text = myfullname
            info.notCheckable = 1
            LibDD:UIDropDownMenu_AddButton(info, level)
            wipe(info)

            if point.achievement then
                -- Waypoint menu item
                info.text = OBJECTIVES_VIEW_ACHIEVEMENT
                info.notCheckable = 1
                info.func = showAchievement
                info.arg1 = point.achievement
                LibDD:UIDropDownMenu_AddButton(info, level)
                wipe(info)
            end

            if TomTom then
                -- Waypoint menu item
                info.text = "Create waypoint"
                info.notCheckable = 1
                info.func = createWaypoint
                info.arg1 = currentZone
                info.arg2 = currentCoord
                LibDD:UIDropDownMenu_AddButton(info, level)
                wipe(info)
            end

            if _G.MAP_PIN_HYPERLINK then
                info.text = COMMUNITIES_INVITE_MANAGER_LINK_TO_CHAT -- Link to chat
                info.notCheckable = 1
                info.func = sendToChat
                info.arg1 = currentZone
                info.arg2 = currentCoord
                LibDD:UIDropDownMenu_AddButton(info, level)
                wipe(info)
            end

            -- Hide menu item
            info.text         = "Hide node"
            info.notCheckable = 1
            info.func         = hideNode
            info.arg1         = currentZone
            info.arg2         = currentCoord
            LibDD:UIDropDownMenu_AddButton(info, level)
            wipe(info)

            if point.achievement then
                -- Waypoint menu item
                info.text = render_string("Hide all {achievement:" .. point.achievement .. "} in all zones")
                info.notCheckable = 1
                info.func = hideAchievement
                info.arg1 = point.achievement
                LibDD:UIDropDownMenu_AddButton(info, level)
                wipe(info)
            end

            if point.group then
                if not ns.hiddenConfig.groupsHiddenByZone then
                    local map = C_Map.GetMapInfo(currentZone)
                    info.text = "Hide all " .. render_string(ns.groups[point.group] or point.group, point) .. " in " .. (map and map.name or "this zone")
                    info.notCheckable = 1
                    info.func = hideGroupZone
                    info.arg1 = currentZone
                    info.arg2 = currentCoord
                    LibDD:UIDropDownMenu_AddButton(info, level)
                    wipe(info)
                end
                if not ns.hiddenConfig.groupsHidden then
                    info.text = "Hide all " .. render_string(ns.groups[point.group] or point.group, point) .. " in all zones"
                    info.notCheckable = 1
                    info.func = hideGroup
                    info.arg1 = currentZone
                    info.arg2 = currentCoord
                    LibDD:UIDropDownMenu_AddButton(info, level)
                    wipe(info)
                end
            end

            -- Close menu item
            info.text         = "Close"
            info.func         = closeAllDropdowns
            info.notCheckable = 1
            LibDD:UIDropDownMenu_AddButton(info, level)
            wipe(info)
        end
    end

    local HL_Dropdown
    function HLHandler:OnClick(button, down, uiMapID, coord)
        if down then return end
        currentZone = uiMapID
        currentCoord = coord
        -- given we're in a click handler, this really *should* exist, but just in case...
        local point = ns.points[currentZone] and ns.points[currentZone][currentCoord]
        if point then
            if button == "RightButton" then
                if not HL_Dropdown then
                    HL_Dropdown = LibDD:Create_UIDropDownMenu(myname .. "PointDropdown")
                    LibDD:UIDropDownMenu_SetInitializeFunction(HL_Dropdown, generateMenu)
                    LibDD:UIDropDownMenu_SetDisplayMode(HL_Dropdown, "MENU")
                end
                LibDD:ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
            end
            if button == "LeftButton" and IsShiftKeyDown() and _G.MAP_PIN_HYPERLINK then
                sendToChat(button, uiMapID, coord)
            end
        end
    end
end

function HLHandler:OnLeave(uiMapID, coord)
    GameTooltip:Hide()
    ShoppingTooltip1:Hide()

    local point = ns.points[uiMapID] and ns.points[uiMapID][coord]
    if ns.RouteWorldMapDataProvider and (point.route or point.routes) then
        if point.route and ns.points[uiMapID][point.route] then
            point = ns.points[uiMapID][point.route]
        end
        ns.RouteWorldMapDataProvider:UnhighlightRoute(point, uiMapID, coord)
    end
end

do
    -- This is a custom iterator we use to iterate over every node in a given zone
    local currentZone, isMinimap
    local function iter(t, prestate)
        if not t then return nil end
        local state, value = next(t, prestate)
        while state do -- Have we reached the end of this zone?
            if value and ns.should_show_point(state, value, currentZone, isMinimap) then
                local label, icon, _, _, _, scale, alpha = get_point_info(value, isMinimap)
                scale = (scale or 1) * (icon and icon.scale or 1) * ns.db.icon_scale
                return state, nil, icon, scale, ns.db.icon_alpha * alpha
            end
            state, value = next(t, state) -- Get next data
        end
        return nil, nil, nil, nil
    end
    function HLHandler:GetNodes2(uiMapID, minimap)
        -- Debug("GetNodes2", uiMapID, minimap)
        currentZone = uiMapID
        isMinimap = minimap
        return iter, ns.points[uiMapID], nil
    end
end

---------------------------------------------------------
-- Addon initialization, enabling and disabling

function HL:OnInitialize()
    -- Set up our database
    if ns.defaultsOverride then
        ns.merge(ns.defaults.profile, ns.defaultsOverride)
    end
    self.db = LibStub("AceDB-3.0"):New(myname.."DB", ns.defaults)
    ns.db = self.db.profile
    ns.hidden = self.db.char.hidden
    -- Initialize our database with HandyNotes
    HandyNotes:RegisterPluginDB(myname:gsub("HandyNotes_", ""), HLHandler, ns.options)

    -- Watch for events... but mitigate spammy events by bucketing in Refresh
    self:RegisterEvent("LOOT_CLOSED", "RefreshOnEvent")
    self:RegisterEvent("ZONE_CHANGED_INDOORS", "RefreshOnEvent")
    self:RegisterEvent("CRITERIA_EARNED", "RefreshOnEvent")
    self:RegisterEvent("BAG_UPDATE", "RefreshOnEvent")
    self:RegisterEvent("QUEST_TURNED_IN", "RefreshOnEvent")
    if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
        self:RegisterEvent("SHOW_LOOT_TOAST", "RefreshOnEvent")
        self:RegisterEvent("GARRISON_FOLLOWER_ADDED", "RefreshOnEvent")
    end
    -- This is sometimes spammy, but is the only thing that tends to get us casts:
    self:RegisterEvent("CRITERIA_UPDATE", "RefreshOnEvent")

    if ns.SetupMapOverlay then
        ns.SetupMapOverlay()
    end

    if ns.RouteWorldMapDataProvider then
        WorldMapFrame:AddDataProvider(ns.RouteWorldMapDataProvider)
    end
end

do
    local bucket = CreateFrame("Frame")
    bucket.elapsed = 0
    bucket:SetScript("OnUpdate", function(self, elapsed)
        self.elapsed = self.elapsed + elapsed
        if self.elapsed > 1.5 then
            self.elapsed = 0
            self:Hide()
            HL:Refresh()
        end
    end)
    function HL:Refresh()
        HL:SendMessage("HandyNotes_NotifyUpdate", myname:gsub("HandyNotes_", ""))
        if ns.RouteWorldMapDataProvider then
            ns.RouteWorldMapDataProvider:RefreshAllData()
        end
    end
    function HL:RefreshOnEvent(event)
        bucket:Show()
    end
end

hooksecurefunc(AreaPOIPinMixin, "TryShowTooltip", function(self)
    -- if not self.db.profile.show_on_world then return end
    if not self.areaPoiID then return end
    if not ns.POIsToPoints[self.areaPoiID] then return end
    local point = ns.POIsToPoints[self.areaPoiID]
    -- if not ns.should_show_point(point._coord, point, point._uiMapID, false) then return end
    handle_tooltip(GameTooltip, point, true)
end)

hooksecurefunc(VignettePinMixin, "OnMouseEnter", function(self)
    local vignetteInfo = self.vignetteInfo
    if not (vignetteInfo.vignetteID and ns.VignetteIDsToPoints[vignetteInfo.vignetteID]) then return end
    local point = ns.VignetteIDsToPoints[vignetteInfo.vignetteID]
    -- if not ns.should_show_point(point._coord, point, point._uiMapID, false) then return end
    handle_tooltip(GameTooltip, point, true)
end)

if _G.TaskPoi_OnEnter then
    hooksecurefunc("TaskPOI_OnEnter", function(self)
        if not self.questID then return end
        if not ns.WorldQuestsToPoints[self.questID] then return end
        local point = ns.WorldQuestsToPoints[self.questID]
        -- if not ns.should_show_point(point._coord, point, point._uiMapID, false) then return end
        handle_tooltip(GameTooltip, point, true)
    end)
end
