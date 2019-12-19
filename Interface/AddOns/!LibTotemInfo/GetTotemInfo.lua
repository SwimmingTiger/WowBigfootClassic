--[[
-- A compatible implementation of GetTotemInfo() API for WoW Classic 1.13.3.
-- The code from <https://git.neuromancy.net/projects/RM/repos/rotationmaster/browse/fake.lua?until=a0a2fc3bdfb5fa8199f14d66bd22666258f67aa4&untilPath=fake.lua>
-- by PreZ and edited / fixed by SwimmingTiger.
]]
local MAJOR = "LibTotemInfo-1.0"
local MINOR = 10002 -- Should be manually increased
local LibStub = _G.LibStub

assert(LibStub, MAJOR .. " requires LibStub")

local lib, oldMinor = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then
	return
end -- No upgrade needed

local TotemItems = {
    [EARTH_TOTEM_SLOT] = 5175,
    [FIRE_TOTEM_SLOT] = 5176,
    [WATER_TOTEM_SLOT] = 5177,
    [AIR_TOTEM_SLOT] = 5178,
}

-- Generate the table with this script:
-- <https://github.com/SwimmingTiger/LibTotemInfo/wiki/Generate-the-TotemSpells-table>
local TotemSpells = {
	[10595] = {
		["duration"] = 120,
		["name"] = "Nature Resistance Totem Rank 1",
		["element"] = 4,
	},
	[5394] = {
		["duration"] = 60,
		["name"] = "Healing Stream Totem Rank 1",
		["element"] = 3,
	},
	[10600] = {
		["duration"] = 120,
		["name"] = "Nature Resistance Totem Rank 2",
		["element"] = 4,
	},
	[8190] = {
		["duration"] = 20,
		["name"] = "Magma Totem Rank 1",
		["element"] = 1,
	},
	[16190] = {
		["duration"] = 12,
		["name"] = "Mana Tide Totem Rank 1",
		["element"] = 3,
	},
	[10478] = {
		["duration"] = 120,
		["name"] = "Frost Resistance Totem Rank 2",
		["element"] = 1,
	},
	[10479] = {
		["duration"] = 120,
		["name"] = "Frost Resistance Totem Rank 3",
		["element"] = 1,
	},
	[16387] = {
		["duration"] = 120,
		["name"] = "Flametongue Totem Rank 4",
		["element"] = 1,
	},
	[10613] = {
		["duration"] = 120,
		["name"] = "Windfury Totem Rank 2",
		["element"] = 4,
	},
	[10614] = {
		["duration"] = 120,
		["name"] = "Windfury Totem Rank 3",
		["element"] = 4,
	},
	[8071] = {
		["duration"] = 120,
		["name"] = "Stoneskin Totem Rank 1",
		["element"] = 2,
	},
	[10495] = {
		["duration"] = 60,
		["name"] = "Mana Spring Totem Rank 2",
		["element"] = 3,
	},
	[10496] = {
		["duration"] = 60,
		["name"] = "Mana Spring Totem Rank 3",
		["element"] = 3,
	},
	[10497] = {
		["duration"] = 60,
		["name"] = "Mana Spring Totem Rank 4",
		["element"] = 3,
	},
	[8075] = {
		["duration"] = 120,
		["name"] = "Strength of Earth Totem Rank 1",
		["element"] = 2,
	},
	[10627] = {
		["duration"] = 120,
		["name"] = "Grace of Air Totem Rank 2",
		["element"] = 4,
	},
	[6363] = {
		["duration"] = 35,
		["name"] = "Searing Totem Rank 2",
		["element"] = 1,
	},
	[6364] = {
		["duration"] = 40,
		["name"] = "Searing Totem Rank 3",
		["element"] = 1,
	},
	[6365] = {
		["duration"] = 45,
		["name"] = "Searing Totem Rank 4",
		["element"] = 1,
	},
	[27623] = {
		["duration"] = 5,
		["name"] = "Fire Nova Totem Rank 5",
		["element"] = 1,
	},
	[8227] = {
		["duration"] = 120,
		["name"] = "Flametongue Totem Rank 1",
		["element"] = 1,
	},
	[22047] = {
		["duration"] = 30,
		["name"] = "Testing Totem Rank 1",
		["element"] = 1,
	},
	[17354] = {
		["duration"] = 12,
		["name"] = "Mana Tide Totem Rank 2",
		["element"] = 3,
	},
	[25359] = {
		["duration"] = 120,
		["name"] = "Grace of Air Totem Rank 3",
		["element"] = 4,
	},
	[25361] = {
		["duration"] = 120,
		["name"] = "Strength of Earth Totem Rank 5",
		["element"] = 2,
	},
	[5675] = {
		["duration"] = 60,
		["name"] = "Mana Spring Totem Rank 1",
		["element"] = 3,
	},
	[10526] = {
		["duration"] = 120,
		["name"] = "Flametongue Totem Rank 3",
		["element"] = 1,
	},
	[6375] = {
		["duration"] = 60,
		["name"] = "Healing Stream Totem Rank 2",
		["element"] = 3,
	},
	[8154] = {
		["duration"] = 120,
		["name"] = "Stoneskin Totem Rank 2",
		["element"] = 2,
	},
	[8498] = {
		["duration"] = 5,
		["name"] = "Fire Nova Totem Rank 2",
		["element"] = 1,
	},
	[6377] = {
		["duration"] = 60,
		["name"] = "Healing Stream Totem Rank 3",
		["element"] = 3,
	},
	[10406] = {
		["duration"] = 120,
		["name"] = "Stoneskin Totem Rank 4",
		["element"] = 2,
	},
	[10407] = {
		["duration"] = 120,
		["name"] = "Stoneskin Totem Rank 5",
		["element"] = 2,
	},
	[10408] = {
		["duration"] = 120,
		["name"] = "Stoneskin Totem Rank 6",
		["element"] = 2,
	},
	[10537] = {
		["duration"] = 120,
		["name"] = "Fire Resistance Totem Rank 2",
		["element"] = 3,
	},
	[10538] = {
		["duration"] = 120,
		["name"] = "Fire Resistance Totem Rank 3",
		["element"] = 3,
	},
	[15111] = {
		["duration"] = 120,
		["name"] = "Windwall Totem Rank 2",
		["element"] = 4,
	},
	[15112] = {
		["duration"] = 120,
		["name"] = "Windwall Totem Rank 3",
		["element"] = 4,
	},
	[8160] = {
		["duration"] = 120,
		["name"] = "Strength of Earth Totem Rank 2",
		["element"] = 2,
	},
	[8161] = {
		["duration"] = 120,
		["name"] = "Strength of Earth Totem Rank 3",
		["element"] = 2,
	},
	[8512] = {
		["duration"] = 120,
		["name"] = "Windfury Totem Rank 1",
		["element"] = 4,
	},
	[8262] = {
		["duration"] = 30,
		["name"] = "Elemental Protection Totem Rank 1",
		["element"] = 3,
	},
	[8264] = {
		["duration"] = 20,
		["name"] = "Lava Spout Totem Rank 1",
		["element"] = 1,
	},
	[11314] = {
		["duration"] = 5,
		["name"] = "Fire Nova Totem Rank 4",
		["element"] = 1,
	},
	[8166] = {
		["duration"] = 120,
		["name"] = "Poison Cleansing Totem",
		["element"] = 3,
	},
	[10427] = {
		["duration"] = 15,
		["name"] = "Stoneclaw Totem Rank 5",
		["element"] = 2,
	},
	[10428] = {
		["duration"] = 15,
		["name"] = "Stoneclaw Totem Rank 6",
		["element"] = 2,
	},
	[6390] = {
		["duration"] = 15,
		["name"] = "Stoneclaw Totem Rank 2",
		["element"] = 2,
	},
	[6391] = {
		["duration"] = 15,
		["name"] = "Stoneclaw Totem Rank 3",
		["element"] = 2,
	},
	[6392] = {
		["duration"] = 15,
		["name"] = "Stoneclaw Totem Rank 4",
		["element"] = 2,
	},
	[1535] = {
		["duration"] = 5,
		["name"] = "Fire Nova Totem Rank 1",
		["element"] = 1,
	},
	[10438] = {
		["duration"] = 55,
		["name"] = "Searing Totem Rank 6",
		["element"] = 1,
	},
	[23419] = {
		["duration"] = 5,
		["name"] = "Corrupted Fire Nova Totem",
		["element"] = 1,
	},
	[25908] = {
		["duration"] = 120,
		["name"] = "Tranquil Air Totem",
		["element"] = 4,
	},
	[10442] = {
		["duration"] = 120,
		["name"] = "Strength of Earth Totem Rank 4",
		["element"] = 2,
	},
	[2484] = {
		["duration"] = 45,
		["name"] = "Earthbind Totem",
		["element"] = 2,
	},
	[17359] = {
		["duration"] = 12,
		["name"] = "Mana Tide Totem Rank 3",
		["element"] = 3,
	},
	[10601] = {
		["duration"] = 120,
		["name"] = "Nature Resistance Totem Rank 3",
		["element"] = 4,
	},
	[8170] = {
		["duration"] = 120,
		["name"] = "Disease Cleansing Totem",
		["element"] = 3,
	},
	[15107] = {
		["duration"] = 120,
		["name"] = "Windwall Totem Rank 1",
		["element"] = 4,
	},
	[8177] = {
		["duration"] = 45,
		["name"] = "Grounding Totem",
		["element"] = 4,
	},
	[11315] = {
		["duration"] = 5,
		["name"] = "Fire Nova Totem Rank 5",
		["element"] = 1,
	},
	[6495] = {
		["duration"] = 300,
		["name"] = "Sentry Totem",
		["element"] = 4,
	},
	[10437] = {
		["duration"] = 50,
		["name"] = "Searing Totem Rank 5",
		["element"] = 1,
	},
	[15786] = {
		["duration"] = 45,
		["name"] = "Earthbind Totem",
		["element"] = 2,
	},
	[15787] = {
		["duration"] = 5,
		["name"] = "Moonflare Totem",
		["element"] = 1,
	},
	[8835] = {
		["duration"] = 120,
		["name"] = "Grace of Air Totem Rank 1",
		["element"] = 4,
	},
	[8184] = {
		["duration"] = 120,
		["name"] = "Fire Resistance Totem Rank 1",
		["element"] = 3,
	},
	[8181] = {
		["duration"] = 120,
		["name"] = "Frost Resistance Totem Rank 1",
		["element"] = 1,
	},
	[10585] = {
		["duration"] = 20,
		["name"] = "Magma Totem Rank 2",
		["element"] = 1,
	},
	[3599] = {
		["duration"] = 30,
		["name"] = "Searing Totem Rank 1",
		["element"] = 1,
	},
	[10586] = {
		["duration"] = 20,
		["name"] = "Magma Totem Rank 3",
		["element"] = 1,
	},
	[10587] = {
		["duration"] = 20,
		["name"] = "Magma Totem Rank 4",
		["element"] = 1,
	},
	[8155] = {
		["duration"] = 120,
		["name"] = "Stoneskin Totem Rank 3",
		["element"] = 2,
	},
	[10462] = {
		["duration"] = 60,
		["name"] = "Healing Stream Totem Rank 4",
		["element"] = 3,
	},
	[10463] = {
		["duration"] = 60,
		["name"] = "Healing Stream Totem Rank 5",
		["element"] = 3,
	},
	[5730] = {
		["duration"] = 15,
		["name"] = "Stoneclaw Totem Rank 1",
		["element"] = 2,
	},
	[8499] = {
		["duration"] = 5,
		["name"] = "Fire Nova Totem Rank 3",
		["element"] = 1,
	},
	[8249] = {
		["duration"] = 120,
		["name"] = "Flametongue Totem Rank 2",
		["element"] = 1,
	},
	[8376] = {
		["duration"] = 30,
		["name"] = "Earthgrab Totem",
		["element"] = 2,
	},
	[8143] = {
		["duration"] = 120,
		["name"] = "Tremor Totem",
		["element"] = 2,
	},
}

local ActiveTotems = {}

function lib.HandleTotemSpell(id)
    local totem = TotemSpells[id]
    if totem then
        local name, _, icon = GetSpellInfo(id)
        name = name or ""
        icon = icon or 0
        local subtext = GetSpellSubtext(id)
        if subtext and #subtext > 0 then
            name = name..' '..subtext
        end

        ActiveTotems[totem.element] = {
            spellid = id,
            name = name,
            icon = icon,
            duration = totem.duration,
            cast = GetTime(),
            acknowledged = false,
        }
    end
end

function lib.HandleTotemEvent(elem)
    if ActiveTotems[elem] then
        if not ActiveTotems[elem].acknowledged then
            ActiveTotems[elem].acknowledged = true
        else
            ActiveTotems[elem] = nil
        end
    end
end

function lib.UNIT_SPELLCAST_SUCCEEDED(event, unit, castguid, spellid)
    lib.HandleTotemSpell(spellid)
end

function lib.PLAYER_TOTEM_UPDATE(event, elem)
    lib.HandleTotemEvent(elem)
end

lib.EventFrame = CreateFrame('Frame')
lib.EventFrame:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED')
lib.EventFrame:RegisterEvent('PLAYER_TOTEM_UPDATE')

lib.EventFrame:SetScript("OnEvent", function(_, event, ...)
    if type(lib[event]) == 'function' then
        lib[event](event, ...)
    end
end)


-- haveTotem, totemName, startTime, duration, icon = GetTotemInfo(1 through 4)
-- <https://wow.gamepedia.com/API_GetTotemInfo>
function lib.GetTotemInfo(elem)
    local haveTotem, spellName, startTime, duration, icon = false, "", 0, 0, 0

    if (TotemItems[elem]) then
        local totemItem = GetItemCount(TotemItems[elem])
        haveTotem = (totemItem and totemItem > 0) and true or false
    end

    if ActiveTotems[elem] then
        totemInfo = ActiveTotems[elem]
        spellName = totemInfo.name
        startTime = totemInfo.cast
        duration = totemInfo.duration
        icon = totemInfo.icon
    end

    return haveTotem, spellName, startTime, duration, icon
end

-- Exposing GetTotemInfo() to other addons
if type(GetTotemInfo) ~= 'function' then
    GetTotemInfo = lib.GetTotemInfo
end


-- timeLeft = GetTotemTimeLeft(1 through 4)
-- From: <https://github.com/SwimmingTiger/LibTotemInfo/issues/2>
-- Author: Road-block
function lib.GetTotemTimeLeft(elem)
    local _, _, startTime, duration = lib.GetTotemInfo(elem)
    local now = GetTime()
    local expiration = startTime and duration and (startTime + duration)
    if expiration and now < expiration then
        return expiration - now
    end
    return 0
end

-- Exposing GetTotemTimeLeft() to other addons
if type(GetTotemTimeLeft) ~= 'function' then
    GetTotemTimeLeft = lib.GetTotemTimeLeft
end
