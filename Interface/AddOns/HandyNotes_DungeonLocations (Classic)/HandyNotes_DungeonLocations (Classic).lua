local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)
if not HandyNotes then return end
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_DungeonLocations (Classic)")

local iconDefault = "Interface\\Addons\\HandyNotes_DungeonLocations (Classic)\\dungeon.tga"
local icons = { }

icons["Dungeon"] = "Interface\\Addons\\HandyNotes_DungeonLocations (Classic)\\dungeon.tga"
icons["Raid"] = "Interface\\Addons\\HandyNotes_DungeonLocations (Classic)\\raid.tga"
icons["Mixed"] = "Interface\\Addons\\HandyNotes_DungeonLocations (Classic)\\merged.tga"
icons["Gray"] = "Interface\\Addons\\HandyNotes_DungeonLocations (Classic)\\gray.tga"

local db
local mapToContinent = { }
local nodes = { }
local minimap = { } -- For nodes that need precise minimap locations but would look wrong on zone or continent maps
local alterName = { }

if (DEBUG) then
	HNDL_NODES = nodes
	HNDL_MINIMAP = minimap
	HNDL_ALTERNAME = alterName
end

local DUNGEON_DATA = {
	[L["Blackfathom Deeps"]] = {
		minimumLevel = 10,
		meetingStone = '22-32',
		recommendedLevelRange = '22-32',
	},
	[L["Blackrock Depths"]] = {
		minimumLevel = 40,
		meetingStone = '52-60',
		recommendedLevelRange = '48-60',
	},
	[L["Blackrock Spire"]] = {
		minimumLevel = 45,
		meetingStone = '55-60',
	},
	[L["Blackwing Lair"]] = {
		recommendedLevelRange = '60',
	},
	[L["Deadmines"]] = {
		minimumLevel = 10,
		meetingStone = '17-26',
		recommendedLevelRange = '15-25',
	},
	[L["Dire Maul"]] = {
		minimumLevel = 45,
	},
	[L["Gnomeregan"]] = {
		minimumLevel = 15,
		meetingStone = '29-38',
		recommendedLevelRange = '24-34',
	},
	[L["Maraudon"]] = {
		minimumLevel = 30,
		recommendedLevelRange = '45-52',
	},
	[L["Molten Core"]] = {
		recommendedLevelRange = '60',
	},
	[L["Ragefire Chasm"]] = {
		recommendedLevelRange = '13-18',
	},
	[L["Razorfen Downs"]] = {
		minimumLevel = 35,
		recommendedLevelRange = '37-47',
	},
	[L["Razorfen Kraul"]] = {
		minimumLevel = 25,
		recommendedLevelRange = '32-42',
	},
	[L["Ruins of Ahn'Qiraj"]] = {
		minimumLevel = 60,
	},
	[L["Scarlet Monastery"]] = {
		recommendedLevelRange = '26-45',
	},
	[L["Scholomance"]] = {
		recommendedLevelRange = '55-60',
	},
	[L["Shadowfang Keep"]] = {
		recommendedLevelRange = '22-30',
	},
	[L["Stratholme"]] = {
		recommendedLevelRange = '55-60',
	},
	[L["Temple of Ahn'Qiraj"]] = {
		minimumLevel = 60,
	},
	[L["The Stockade"]] = {
		minimumLevel = 15,
		meetingStone = '24-32',
		recommendedLevelRange = '22-32',
	},
	[L["The Temple of Atal'hakkar"]] = {
		minimumLevel = 35,
		meetingStone = '50-60',
	},
	[L["Uldaman"]] = {
		minimumLevel = 30,
		meetingStone = '41-51',
	},
	[L["Blackrock Spire"]] = {
		recommendedLevelRange = '55-60',
	},
	[L["Wailing Caverns"]] = {
		recommendedLevelRange = '17-27',
	},
	[L["Zul'Farrak"]] = {
		minimumLevel = 39,
		recommendedLevelRange = '44-54',
	},
	[L["Zul'Gurub"]] = {
		minimumLevel = 50,
		recommendedLevelRange = '60',
	},
}

local pluginHandler = { }
function pluginHandler:OnEnter(uiMapId, coord)
    local nodeData = nil
	
	if (minimap[uiMapId] and minimap[uiMapId][coord]) then
	 nodeData = minimap[uiMapId][coord]
	end
	if (nodes[uiMapId] and nodes[uiMapId][coord]) then
	 nodeData = nodes[uiMapId][coord]
	end
	
	if (not nodeData) then return end
	
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
	if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

    if (not nodeData.name) then return end

	local instances = { strsplit("\n", nodeData.name) }

	for i, v in pairs(instances) do
		if DUNGEON_DATA[v]then
			if DUNGEON_DATA[v].recommendedLevelRange then
				tooltip:AddLine(v .. '     [' .. DUNGEON_DATA[v].recommendedLevelRange .. ']')
			elseif DUNGEON_DATA[v].meetingStone then
				tooltip:AddLine(v .. '     [' .. DUNGEON_DATA[v].meetingStone .. ']')
			elseif DUNGEON_DATA[v].minimumLevel then
				tooltip:AddLine(v .. '     [' .. DUNGEON_DATA[v].minimumLevel .. ']')
			end
		else
			tooltip:AddLine(v, nil, nil, nil, false)
		end
	end
	tooltip:Show()
end

function pluginHandler:OnLeave(mapFile, coord)
	if self:GetParent() == WorldMapButton then
		WorldMapTooltip:Hide()
	else
		GameTooltip:Hide()
	end
end

do
	local tablepool = setmetatable({}, {__mode = 'k'})
	
	local function deepCopy(object)
		local lookup_table = {}
		local function _copy(object)
			if type(object) ~= "table" then
				return object
			elseif lookup_table[object] then
				return lookup_table[object]
			end
			local new_table = {}
			lookup_table[object] = new_table
			for index, value in pairs(object) do
				new_table[_copy(index)] = _copy(value)
			end
			return setmetatable(new_table, getmetatable(object))
		end
			return _copy(object)
	end

	local function iter(t, prestate)
		if not t then return end
		local data = t.data

		local state, value = next(data, prestate)

		if value then	
			--print('Minimap', t.minimapUpdate, legionInstancesDiscovered[value.id])
--			if t.minimapUpdate then
			--print(value.type, db.show[value.type])
			if db.show[value.type] then
			 return state, nil, icons[value.type], db.zoneScale, db.zoneAlpha
			end
			state, value = next(data, state)
		end
		wipe(t)
		tablepool[t] = true
	end


	-- This is a funky custom iterator we use to iterate over every zone's nodes
	-- in a given continent + the continent itself
	local function iterCont(t, prestate)
		if not t then return end
		if not db.continent then return end
		local zone = t.C[t.Z]
		-- I'm using the continent map to store more precise minimap nodes; hopefully it doesn't cause problems
		local data = t.minimapUpdate and minimap[zone] or nodes[zone]
		local state, value
		while zone do
			if data then -- Only if there is data for this zone
				state, value = next(data, prestate)
				while state do -- Have we reached the end of this zone?

					if value.name == nil then print (value.id) end
					local instances = { strsplit("\n", value.name) }
					--alpha = db.continentAlpha
					--print(db.continent, value.hideOnContinent, db.show[value.type], zone == t.contId)
					--  or zone == t.contId I forgot what this was for so I'm taking it out
					if not value.hideOnContinent and db.continent and db.show[value.type] then -- Show on continent?
						return state, zone, icons[value.type], db.continentScale, db.continentAlpha
					end
					state, value = next(data, state) -- Get next data
				end
			end
			-- Get next zone
			t.Z = next(t.C, t.Z)
			zone = t.C[t.Z]
			data = t.minimapUpdate and minimap[zone] or nodes[zone]
			prestate = nil
		end
		wipe(t)
		tablepool[t] = true
	end

	function pluginHandler:GetNodes2(uiMapId, isMinimapUpdate)
		local C = deepCopy(HandyNotes:GetContinentZoneList(uiMapId)) -- Is this a continent?
		-- I copy the table so I can add in the continent map id
		if C then
			table.insert(C, uiMapId)
			local tbl = next(tablepool) or {}
			tablepool[tbl] = nil
			tbl.C = C
			tbl.Z = next(C)
			tbl.contId = uiMapId
			tbl.minimapUpdate = isMinimapUpdate
		--[[	if (isMinimapUpdate and minimap[uiMapId]) then
				print('Using minimap data')
				print(minimap[uiMapId])
				tbl.data = minimap[uiMapId]
			else]]--
				tbl.data = nodes[uiMapId]
			--end
			return iterCont, tbl, nil
		else -- It is a zone
			if (nodes[uiMapId] == nil) then return iter end -- Throws error if I don't do this
			--print('zone')
			local tbl = next(tablepool) or {}
			tablepool[tbl] = nil
			--print(isMinimapUpdate)
			tbl.minimapUpdate = isMinimapUpdate
			if (isMinimapUpdate and minimap[uiMapId]) then
				tbl.data = minimap[uiMapId]
			else
				tbl.data = nodes[uiMapId]
			end
			return iter, tbl, nil
		end
	end
end

local waypoints = {}
local function setWaypoint(mapFile, coord)
	local dungeon = nodes[mapFile][coord]

	local waypoint = nodes[dungeon]
	if waypoint and TomTom:IsValidWaypoint(waypoint) then
		return
	end

	local x, y = HandyNotes:getXY(coord)
	--print(x, y)
	waypoints[dungeon] = TomTom:AddWaypoint(mapFile, x, y, {
		title = dungeon.name,
		persistent = nil,
		minimap = true,
		world = true
	})
end

function pluginHandler:OnClick(button, pressed, mapFile, coord)
	if (not pressed) then return end
 --print(button, pressed, mapFile, coord)
	if (button == "RightButton" and db.tomtom and TomTom) then
		setWaypoint(mapFile, coord)
		return
	end
end

local defaults = {
 profile = {
  zoneScale = 2,
  zoneAlpha = 1,
  continentScale = 2,
  continentAlpha = 1,
  continent = true,
  tomtom = true,
  lockouts = true,
  lockoutgray = true,
  uselockoutalpha = false,
  lockoutalpha = 1,
  invertlockout = false,
  show = {
   Dungeon = true,
   Raid = true,
   Mixed = true,
  },
 },
}

local Addon = CreateFrame("Frame")
Addon:RegisterEvent("PLAYER_LOGIN")
Addon:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end)

local function updateStuff()
	HandyNotes:SendMessage("HandyNotes_NotifyUpdate", "DungeonLocations_Classic")
end

function Addon:PLAYER_ENTERING_WORLD()
	self:PopulateTable()
	self:PopulateMinimap()
 	--updateLockouts()
	updateStuff()
end

function Addon:PLAYER_LOGIN()
 local options = {
 type = "group",
 name = L["DungeonLocations_Classic"],
 desc = "Locations of dungeon and raid entrances.",
 get = function(info) return db[info[#info]] end,
 set = function(info, v) db[info[#info]] = v HandyNotes:SendMessage("HandyNotes_NotifyUpdate", "DungeonLocations_Classic") end,
 args = {
  desc = {
   name = L["These settings control the look and feel of the icon."],
   type = "description",
   order = 0,
  },
  zoneScale = {
   type = "range",
   name = L["Zone Scale"],
   desc = L["The scale of the icons shown on the zone map"],
   min = 0.2, max = 12, step = 0.1,
   order = 10,
  },
  zoneAlpha = {
   type = "range",
   name = L["Zone Alpha"],
   desc = L["The alpha of the icons shown on the zone map"],
   min = 0, max = 1, step = 0.01,
   order = 20,
  },
  continentScale = {
   type = "range",
   name = L["Continent Scale"],
   desc = L["The scale of the icons shown on the continent map"],
   min = 0.2, max = 12, step = 0.1,
   order = 10,
  },
  continentAlpha = {
   type = "range",
   name = L["Continent Alpha"],
   desc = L["The alpha of the icons shown on the continent map"],
   min = 0, max = 1, step = 0.01,
   order = 20,
  },
  continent = {
   type = "toggle",
   name = L["Show on Continent"],
   desc = L["Show icons on continent map"],
   order = 1,
  },
  tomtom = {
   type = "toggle",
   name = L["Enable TomTom integration"],
   desc = L["Allow right click to create waypoints with TomTom"],
   order = 2,
  },
  showheader = {
   type = "header",
   name = L["Filter Options"],
   order = 24,
  },
  showDungeons = {
   type = "toggle",
   name = L["Show Dungeons"],
   desc = L["Show dungeon locations on the map"],
   order = 24.1,
   get = function() return db.show["Dungeon"] end,
   set = function(info, v) db.show["Dungeon"] = v self:FullUpdate() HandyNotes:SendMessage("HandyNotes_NotifyUpdate", "DungeonLocations_Classic") end,
  },
  showRaids = {
   type = "toggle",
   name = L["Show Raids"],
   desc = L["Show raid locations on the map"],
   order = 24.2,
   get = function() return db.show["Raid"] end,
   set = function(info, v) db.show["Raid"] = v self:FullUpdate() HandyNotes:SendMessage("HandyNotes_NotifyUpdate", "DungeonLocations_Classic") end,
  },
  showMixed = {
   type = "toggle",
   name = L["Show Mixed"],
   desc = L["Show mixed (dungeons + raids) locations on the map"],
   order = 24.2,
   get = function() return db.show["Mixed"] end,
   set = function(info, v) db.show["Mixed"] = v self:FullUpdate() HandyNotes:SendMessage("HandyNotes_NotifyUpdate", "DungeonLocations_Classic") end,
  },
  lockoutheader = {
   type = "header",
   name = L["Lockout Options"],
   order = 25,
  },
  lockouts = {
   type = "toggle",
   name = L["Lockout Tooltip"],
   desc = L["Show lockout information on tooltips"],
   order = 25.1,
  },
  lockoutgray = {
   type = "toggle",
   name = L["Lockout Gray Icon"],
   desc = L["Use gray icon for dungeons and raids that are locked to any extent"],
   order = 25.11,
  },
  uselockoutalpha = {
   type = "toggle",
   name = L["Use Lockout Alpha"],
   desc = L["Use a different alpha for dungeons and raids that are locked to any extent"],
   order = 25.2,
  },
  lockoutalpha = {
   type = "range",
   name = L["Lockout Alpha"],
   desc = L["The alpha of dungeons and raids that are locked to any extent"],
   min = 0, max = 1, step = 0.01,
   order = 25.3,
  },
  invertlockout = {
   type = "toggle",
   name = L["Invert Lockout"],
   desc = L["Turn mixed icons grey when ANY dungeon or raid listed is locked"],
   order = 25.4,
  },
 },
}


 HandyNotes:RegisterPluginDB("DungeonLocations_Classic", pluginHandler, options)
 self.db = LibStub("AceDB-3.0"):New("HandyNotes_DungeonLocationsClassicDB", defaults, true)
 db = self.db.profile
 
 Addon:RegisterEvent("PLAYER_ENTERING_WORLD") -- Check for any lockout changes when we zone
end

-- I only put a few specific nodes on the minimap, so if the minimap is used in a zone then I need to add all zone nodes to it except for the specific ones
-- This could also probably be done better maybe
-- Looks like this function used to rely on the map id, changed so it doesn't error but needs further testing
function Addon:PopulateMinimap() -- This use to ignore duplicate dungeons but now it doesn't
 local temp = { }
 for k,v in pairs(nodes) do
  if (minimap[k]) then
   for a,b in pairs(minimap[k]) do -- Looks at the nodes we already have on the minimap and marks them down in a temp table
	temp[a] = true
   end
   for c,d in pairs(v) do -- Looks at the nodes in the normal node table and if they are also not in the temp table then add them to the minimap
    if (not temp[c] and not d.hideOnMinimap) then
	 minimap[k][c] = d
	end
   end
  end
 end
end

function Addon:PopulateTable()
	table.wipe(nodes)
	table.wipe(minimap)

nodes[1440] = { -- Ashenvale
 [14001310] = {
  name = L["Blackfathom Deeps"],
  type = "Dungeon",
 }, -- Blackfathom Deeps, not at portal but look
}
nodes[1418] = { -- Badlands
	[44531212] = { 
		name = L["Uldaman"],
		type = "Dungeon",
	}, -- Uldaman
	[65054337] = { 
		name = L["Uldaman"],
		type = "Dungeon",
	}, -- Uldaman (Secondary Entrance)
}
nodes[1413] = { -- Barrens
	[49139348] = {
		name = L["Razorfen Downs"],
		type = "Dungeon",
	}, -- Razorfen Downs
	[41898950] = {
		name = L["Razorfen Kraul"],
		type = "Dungeon",
	}, -- Razorfen Kraul
	[45973634] = { -- I've placed it at the cave entrance
		name = L["Wailing Caverns"],
		type = "Dungeon",
	}, -- Wailing Caverns
}
nodes[1451] = { -- Silithus
	[29099320] = {
		name = L["Ruins of Ahn'Qiraj"] .. '\n' .. L["Temple of Ahn'Qiraj"],
		type = "Raid",
		hideOnContinent = true,
	},
}

-- Caves and stuff seem to use the continent map
-- I use this to place icons more precisely
nodes[1414] = {
	[40958574] = {
		name = L["Temple of Ahn'Qiraj"],
		type = "Raid",
	},
	[42298649] = {
		name = L["Ruins of Ahn'Qiraj"],
		type = "Raid",
	},
}
minimap[1414] = { -- Kalimdor
	[40958574] = {
		name = L["Temple of Ahn'Qiraj"],
		type = "Raid",
	},
	[42298649] = {
		name = L["Ruins of Ahn'Qiraj"],
		type = "Raid",
	},
	[44353485] = {
		name = L["Blackfathom Deeps"],
		type = "Dungeon",
	},
	[42986745] = {
		name = L["Dire Maul - Capital Gardens"],
		type = "Dungeon",
	},
	[42986778] = {
		name = L["Dire Maul - Capital Gardens"],
		type = "Dungeon",
	},
	[43416652] = {
		name = L["Dire Maul - Gordok Commons"],
		type = "Dungeon",
	},
	[44276840] = {
		name = L["Dire Maul - Warpwood Quarter"],
		type = "Dungeon",
	},
	[39275819] = {
		name = L["Maraudon - Orange"],
		type = "Dungeon",
	},
	[38455781] = {
		name = L["Maraudon - Earth Song Falls"],
		type = "Dungeon",
	},
	[56527140] = {
		name = L["Onyxia's Lair"],
		type = "Raid",
	},
	[53237116] = {
		name = L["Razorfen Downs"],
		type = "Dungeon",
		--hideOnContinent = true,
	}, -- Razorfen Downs
	[52395520] = {
		name = L["Wailing Caverns"],
		type = "Dungeon",
		--hideOnContinent = true,
	},
}

minimap[1415] = {-- Eastern Kingdoms
	[48096242] = {
		name = L["Blackrock Depths"],
		type = "Dungeon",
	},
	[48956389] = {
		name = L["Blackrock Spire"],
		type = "Dungeon",
	},
	[48926448] = {
		name = L["Blackwing Lair"],
		type = "Raid",
	},
	[40707959] = {
		name = L["Deadmines"],
		type = "Dungeon",
	},
	[42825382] = {
		name = L["Gnomeregan"],
		type = "Dungeon",
	},
	[43305253] = {
		name = L["Gnomeregan"],
		type = "Dungeon", -- Workshop Entrance
	},
	[48416382] = {
		name = L["Molten Core"],
		type = "Raid",
	},
	[56817518] = {
		name = L["The Temple of Atal'hakkar"],
		type = "Dungeon",
	},
	[53855766] = {
		name = L["Uldaman"],
		type = "Dungeon",
	},
	[56156003] = {
		name = L["Uldaman"],
		type = "Dungeon", -- Side entrance
	},
}

nodes[1427] = {
	[34708600]= {
		name = L["Blackrock Depths"] ..'\n' .. L["Blackrock Spire"] .. '\n' .. L["Blackwing Lair"] .. '\n' .. L["Molten Core"],
		type = "Mixed",
		hideOnContinent = true,
	},
}

nodes[1428] = { -- BurningSteppes
	[29944778] = {
		name = L["Blackrock Depths"] ..'\n' .. L["Blackrock Spire"] .. '\n' .. L["Blackwing Lair"] .. '\n' .. L["Molten Core"],
		type = "Mixed", 
	}, -- Blackrock mountain dungeons and raids
}
nodes[1443] = { -- Desolace
	[29106250] = {
		name = L["Maraudon"],
		type = "Dungeon",
	}, -- Maraudon 29106250 Door at beginning
}
-- No clue why this is on the zone map but the other maraudon instances are on the continent map
minimap[1443] = {
	[30165462] = {
		name = L["Maraudon - Purple"],
		type = "Dungeon",
	},
}
nodes[1426] = { -- DunMorogh
	[24463981] = {
		name = L["Gnomeregan"],
		type = "Dungeon",
	}, -- Gnomeregan
}
nodes[1445] = { -- Dustwallow
 [52907770] = {
		name = L["Onyxia's Lair"],
		type = "Raid",
	}, -- Onyxia's Lair
}
nodes[1423] = { -- EasternPlaguelands
	[30851700] = { --
		name = L["Stratholme"],
		type = "Dungeon",
	}, -- Stratholme World 52902870

}
nodes[1444] = { -- Feralas
	 [77063695] = {
		name = L["Dire Maul - Warpwood Quarter"],
		type = "Dungeon",
	}, -- Entrance at Lariss Pavillion
	[59114328] = {
		name = L["Dire Maul"],
		type = "Dungeon",
	}, -- Dire Maul, probably dire maul east
}

nodes[1454] = { -- Orgrimmar
	[51604983] = { -- 52405800
		name = L["Ragefire Chasm"],
		type = "Dungeon",
	}, -- Ragefire Chasm Cleft of Shadow 70104880
}

nodes[1481] = { -- Silithus
	[36208420] = {
		name = L["Ruins of Ahn'Qiraj"],
		type = "Raid",
	}, -- Ruins of Ahn'Qiraj
	[23508620] =  {
		name = L["Temple of Ahn'Qiraj"],
		type = "Raid",
	}, -- Temple of Ahn'Qiraj
}
nodes[1421] = { -- Silverpine
	[44806780] = {
		name = L["Shadowfang Keep"],
		type = "Dungeon",
	}, -- Shadowfang Keep
}
nodes[1453] = { -- StormwindCity
	[40285521] = {
		name = L["The Stockade"],
		type = "Dungeon",
	}, -- The Stockade
}
nodes[1435] = { -- SwampOfSorrows
 [69505250] = {
		name = L["The Temple of Atal'hakkar"],
		type = "Dungeon",
	}, -- The Temple of Atal'hakkar
}
nodes[1446] = { --Tanaris
	[38722000] = {
		name = L["Zul'Farrak"],
		type = "Dungeon",
	}, -- Zul'Farrak
}
nodes[1420] = { -- Tirisfal
	[85303220] = {
		name = L["Scarlet Monastery"],
		type = "Dungeon",
	}, -- Scarlet Halls
}
nodes[1422] = { -- WesternPlaguelands
	[69007290] = {
		name = L["Scholomance"],
		type = "Dungeon",
	}, -- Scholomance
}
nodes[1436] = { -- Westfall
	[42577171] = {
		name = L["Deadmines"],
		type = "Dungeon",
	}, -- Deadmines
}

nodes[1434] = { -- Stranglethorn Vale
	[53961757] = {
		name = L["Zul'Gurub"],
		type = "Raid",
	},
}
end

function Addon:FullUpdate()
	self:PopulateTable()
	self:PopulateMinimap()
end
