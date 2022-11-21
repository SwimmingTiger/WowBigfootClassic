local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)
if not HandyNotes then return end
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_DungeonLocations (Classic)")

local LibQTip = LibStub('LibQTip-1.0')

local iconDefault = "Interface\\Addons\\HandyNotes_DungeonLocations (Classic)\\dungeon.tga"
local icons = { }

icons["Dungeon"] = "Interface\\Addons\\HandyNotes_DungeonLocations (Classic)\\dungeon.tga"
icons["Raid"] = "Interface\\Addons\\HandyNotes_DungeonLocations (Classic)\\raid.tga"
icons["Mixed"] = "Interface\\Addons\\HandyNotes_DungeonLocations (Classic)\\merged.tga"
icons["Gray"] = "Interface\\Addons\\HandyNotes_DungeonLocations (Classic)\\gray.tga"
icons["MeetingStone"] = "Interface\\Addons\\HandyNotes_DungeonLocations (Classic)\\gray.tga"

local db
local mapToContinent = { }
local nodes = { }
local minimap = { } -- For nodes that need precise minimap locations but would look wrong on zone or continent maps
local alterName = { }

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
	[L["Naxxramas"]] = {
		minimumLevel = 80,
	},
	[L["Hellfire Ramparts"]] = {
		recommendedLevelRange = '60-62',
	},
	[L["The Blood Furnace"]] = {
		recommendedLevelRange = '61-63',
	},
	[L["The Slave Pens"]] = {
		recommendedLevelRange = '62-64',
	},
	[L["The Underbog"]] = {
		recommendedLevelRange = '63-65',
	},
	[L["Mana-Tombs"]] = {
		recommendedLevelRange = '64-66',
	},
	[L["Auchenai Crypts"]] = {
		recommendedLevelRange = '65-67',
	},
	[L["Old Hillsbrad Foothills"]] = {
		recommendedLevelRange = '66-68',
	},
	[L["Sethekk Halls"]] = {
		recommendedLevelRange = '67-69',
	},
	[L["The Steamvault"]] = {
		recommendedLevelRange = '68-70',
	},
	[L["Shadow Labyrinth"]] = {
		recommendedLevelRange = '69-70',
	},
	[L["The Shattered Halls"]] = {
		recommendedLevelRange = '69-70',
	},
	[L["The Black Morass"]] = {
		recommendedLevelRange = '70',
	},
	[L["The Botanica"]] = {
		recommendedLevelRange = '70',
	},
	[L["The Mechanar"]] = {
		recommendedLevelRange = '70',
	},
	[L["The Arcatraz"]] = {
		recommendedLevelRange = '70',
	},
	[L["Magisters' Terrace"]] = {
		recommendedLevelRange = '70',
	},
	[L["Karazhan"]] = {
		recommendedLevelRange = '70',
	},
	[L["Zul'Aman"]] = {
		recommendedLevelRange = '70',
	},
	[L["Gruul's Lair"]] = {
		recommendedLevelRange = '70',
	},
	[L["Magtheridon's Lair"]] = {
		recommendedLevelRange = '70',
	},
	[L["Serpentshrine Cavern"]] = {
		recommendedLevelRange = '70',
	},
	[L["The Eye"]] = {
		recommendedLevelRange = '70',
	},
	[L["The Battle for Mount Hyjal"]] = {
		recommendedLevelRange = '70',
	},
	[L["Black Temple"]] = {
		recommendedLevelRange = '70',
	},
	[L["Sunwell Plateau"]] = {
		recommendedLevelRange = '70',
	},
	[L["Utgarde Keep"]] = {
		recommendedLevelRange = '70-72',
	},
	[L["Azjol-Nerub"]] = {
		recommendedLevelRange = '72-74',
	},
	[L["Ahn'kahet: The Old Kingdom"]] = {
		recommendedLevelRange = '73-75',
	},
	[L["The Nexus"]] = {
		recommendedLevelRange = '71-73',
	},
	[L["Drak'Tharon Keep"]] = {
		recommendedLevelRange = '74-76',
	},
	[L["The Violet Hold"]] = {
		recommendedLevelRange = '75-77',
	},
	[L["Gundrak"]] = {
		recommendedLevelRange = '76-78',
	},
	[L["Halls of Stone"]] = {
		recommendedLevelRange = '77-79',
	},
	[L["Halls of Lightning"]] = {
		recommendedLevelRange = '79-80',
	},
	[L["The Oculus"]] = {
		recommendedLevelRange = '79-80',
	},
	[L["Utgarde Pinnacle"]] = {
		recommendedLevelRange = '79-80',
	},
	[L["The Culling of Stratholme"]] = {
		recommendedLevelRange = '79-80',
	},
	[L["Trial of the Champion"]] = {
		recommendedLevelRange = '79-80',
	},
	[L["The Forge of Souls"]] = {
		recommendedLevelRange = '79-80',
	},
	[L["Pit of Saron"]] = {
		recommendedLevelRange = '79-80',
	},
	[L["Halls of Reflection"]] = {
		recommendedLevelRange = '79-80',
	},
	[L["Trial of the Crusader"]] = {
		recommendedLevelRange = '80',
	},
	[L["The Obsidian Sanctum"]] = {
		recommendedLevelRange = '80',
	},
	[L["The Ruby Sanctum"]] = {
		recommendedLevelRange = '80',
	},
	[L["Ulduar"]] = {
		recommendedLevelRange = '80',
	},
	[L["The Eye of Eternity"]] = {
		recommendedLevelRange = '80',
	},
	[L["Icecrown Citadel"]] = {
		recommendedLevelRange = '80',
	},
	[L["Vault of Archavon"]] = {
		recommendedLevelRange = '80',
	},
	[L["Onyxia's Lair"]] = {
		recommendedLevelRange = '80',
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
	
	--local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
	--if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
	--	tooltip:SetOwner(self, "ANCHOR_LEFT")
	--else
	--	tooltip:SetOwner(self, "ANCHOR_RIGHT")
	--end
	local tooltip = LibQTip:Acquire("HandyNotes_DungeonLocations", 2, "LEFT", "RIGHT")
	self.tooltip = tooltip

    if (not nodeData.name) then return end

	local instances = { strsplit("\n", nodeData.name) }

	for i, v in pairs(instances) do
		if DUNGEON_DATA[v]then
			if DUNGEON_DATA[v].recommendedLevelRange then
				tooltip:AddLine(v, '[' .. DUNGEON_DATA[v].recommendedLevelRange .. ']')
			elseif DUNGEON_DATA[v].meetingStone then
				tooltip:AddLine(v, '[' .. DUNGEON_DATA[v].meetingStone .. ']')
			elseif DUNGEON_DATA[v].minimumLevel then
				tooltip:AddLine(v, '[' .. DUNGEON_DATA[v].minimumLevel .. ']')
			end
		else
			tooltip:AddLine(v)
		end
	end
	tooltip:SmartAnchorTo(self)
	tooltip:Show()
end

function pluginHandler:OnLeave(mapFile, coord)
	if self.tooltip then
		LibQTip:Release(self.tooltip)
		self.tooltip = nil
		return
	end
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

		while value do			
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

					--if value.name == nil then print (value.id) end
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
		--print(uiMapId)
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
			tbl.data = nodes[uiMapId]
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
   MeetingStone = true,
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
 name = "DungeonLocations_Classic",
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
	[27081092] = { --
		name = L["Stratholme"],
		type = "Dungeon",
	}, -- Stratholme World 52902870
	--[39002600] = { -- Naxxramas		name = L["Naxxramas"],		type = "Raid",	}, Fairly sure this is gone now
}
nodes[1415] = { -- Stratholme
	[52902867] = { --
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
--[[
[53237057] = {
		name = L["The Stockade"],
		type = "MeetingStone",
		min = 21,
		max = 29,
	},
	]]--
nodes[1453] = { -- StormwindCity
	[50486638] = {
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

-- Outland
if (not self.db.profile.hideOutland) then
nodes[1949] = { -- BladesEdgeMountains
 [69302370] = {
  id = 746,
  name = L["Gruul's Lair"],
  type = "Raid",
 }, -- Gruul's Lair World 45301950
}
nodes[1942] = { -- Ghostlands
 [85206430] = {
  id = 77,
  name = L["Zul'Aman"],
  type = "Raid",
 }, -- Zul'Aman World 58302480
}
nodes[1944] = { -- Hellfire
 --[47505210] = { 747,type = "Raid" }, -- Magtheridon's Lair World 56705270
 --[47605360] = { 248,  type = "Dungeon" }, -- Hellfire Ramparts World 56805310 Stone 48405240 World 57005280
 --[47505200] = { 259,  type = "Dungeon" }, -- The Shattered Halls World 56705270
 --[46005180] = { 256,  type = "Dungeon" }, -- The Blood Furnace World 56305260
 [47205220] = {
  id = { 248, 256, 259, 747 },
  name = L["Hellfire Ramparts"] .. "\n" .. L["The Blood Furnace"] .. "\n" .. L["The Shattered Halls"] .. "\n" .. L["Magtheridon's Lair"],
  type = "Mixed",
  hideOnMinimap = true,
 }, -- Hellfire Ramparts, The Blood Furnace, The Shattered Halls, Magtheridon's Lair
}
nodes[1953] = { -- Netherstorm
 [71705500] = {
  id = 257,
  name = L["The Botanica"],
  type = "Dungeon",
 }, -- The Botanica
 [70606980] = {
  id = 258,
  name = L["The Mechanar"],
  type = "Dungeon",
 }, -- The Mechanar World 65602540
 [74405770] = {
  id = 254,
  name = L["The Arcatraz"],
  type = "Dungeon",
 }, -- The Arcatraz World 66802160
 [73806380] = {
  id = 749,
  name = L["The Eye"],
  type = "Raid",
 }, -- The Eye World 66602350
}
nodes[1952] = { -- TerokkarForest
 [34306560] = {
  id = 247,
  name = L["Auchenai Crypts"],
  type = "Dungeon",
 }, -- Auchenai Crypts World 44507890
 [39705770] = {
  id = 250,
  name = L["Mana-Tombs"],
  type = "Dungeon",
 }, -- Mana-Tombs World 46107640
 [44906560] = {
  id = 252,
  name = L["Sethekk Halls"],
  type = "Dungeon",
 }, -- Sethekk Halls World 47707890  Summoning Stone For Auchindoun 39806470, World: 46207860 
 [39607360] = {
  id = 253,
  name = L["Shadow Labyrinth"],
  type = "Dungeon",
 }, -- Shadow Labyrinth World 46108130
}
nodes[1948] = { -- ShadowmoonValley
 [71004660] = {
  id = 751,
  name = L["Black Temple"],
  type = "Raid",
 }, -- Black Temple World 72608410
}
nodes[1957] = { -- Sunwell, Isle of Quel'Danas
 [61303090] = {
  id = 249,
  name = L["Magisters' Terrace"],
  type = "Dungeon",
 }, -- Magisters' Terrace
 [44304570] = {
  id = 752,
  name = L["Sunwell Plateau"],
  type = "Raid",
 }, -- Sunwell Plateau World 55300380
}
nodes[1946] = { -- Zangarmarsh
 --[54203450] = { 262,  type = "Dungeon" }, -- Underbog World 35804330
 --[48903570] = { 260,  type = "Dungeon" }, -- Slave Pens World 34204370
 --[51903280] = { 748,  type = "Raid" }, -- Serpentshrine Cavern World 35104280
 [50204100] = {
  id = { 260, 261, 262, 748 },
  name = L["The Slave Pens"] .. "\n" .. L["The Steamvault"] .. "\n" .. L["The Underbog"] .. "\n" .. L["Serpentshrine Cavern"],
  type = "Mixed",
  hideOnMinimap = true,
 }, -- Mixed Location
}
nodes[1430] = { -- DeadwindPass
 [46907470] = {
  id = 745,
  name = L["Karazhan"],
  type = "Raid",
 },
}
minimap[1944] = { -- Hellfire
 [47605360] = {
  id = 248,
  name = L["Hellfire Ramparts"],
  type = "Dungeon",
 }, -- Hellfire Ramparts World 56805310 Stone 48405240 World 57005280
 [46005180] = {
  id = 256,
  name = L["The Blood Furnace"],
  type = "Dungeon",
 }, -- The Blood Furnace World 56305260
 [48405180] = {
  id = 259,
  name = L["The Shattered Halls"],
  type = "Dungeon",
 }, -- The Shattered Halls World 56705270, Old 47505200.  Adjusted for clarity
 [46405290] = {
  id = 747,
  name = L["Magtheridon's Lair"],
  type = "Raid",
 }, -- Magtheridon's Lair World 56705270, Old 47505210.  Adjusted for clarity
}
nodes[1446] = { -- CavernsofTime
 [65654992] = {
	name = L["The Black Morass"] .. "\n" .. L["Old Hillsbrad Foothills"] .. "\n" .. L["The Battle for Mount Hyjal"] .. "\n" .. L["The Culling of Stratholme"],
	type = "Mixed",
  },
 }

minimap[1946] = { -- Zangarmarsh
 [48903570] = {
  id = 260,
  name = L["The Slave Pens"],
  type = "Dungeon",
 }, -- Slave Pens World 34204370
 [50303330] = {
  id = 261,
  name = L["The Steamvault"],
  type = "Dungeon",
 }, -- The Steamvault
 [54203450] = {
  id = 262,
  name = L["The Underbog"],
  type = "Dungeon",
 }, -- Underbog World 35804330
 [51903280] = {
  id = 748,
  name = L["Serpentshrine Cavern"],
  type = "Raid",
 }, -- Serpentshrine Cavern World 35104280
}
minimap[1446] = { -- Cavern of Time stuffs
 [58576063] = {
  id = 255,
  name = L["The Black Morass"],
  type = "Dungeon",
 }, -- The Black Morass
 [57105594] = {
  id = 251,
  name = L["Old Hillsbrad Foothills"],
  type = "Dungeon",
 }, -- Old Hillsbrad Foothills
 [59815222] = {
  id = 750,
  name = L["The Battle for Mount Hyjal"],
  type = "Raid",
 }, -- The Battle for Mount Hyjal
 [57608260] = {
	name = L["The Culling of Stratholme"],
	type = "Dungeon",
 },
}
end

-- NORTHREND (16 Dungeons, 9 Raids)
if (not self.db.profile.hideNorthrend) then
nodes[114] = { --"BoreanTundra"
 [27602660] = {
  id = { 282, 756, 281 },
  name = L["The Nexus"] .. "\n" .. L["The Oculus"] .. "\n" .. L["The Eye of Eternity"],
  type = "Mixed",
 },
 -- Oculus same as eye of eternity
 --[27502610] = { "The Nexus",  type = "Dungeon" },
}
nodes[125] = {
 [66726812] = {
  id = 283,
  name = L["The Violet Hold"],
  type = "Dungeon",
  hideOnContinent = true,
 }, -- The Violet Hold
}
nodes[127] = {
 [28203640] = {
  id = 283,
  name = L["The Violet Hold"],
  type = "Dungeon",
 }, -- The Violet Hold
}
nodes[115] = { -- Dragonblight
 [28505170] = {
  id = 271,
  name = L["Ahn'kahet: The Old Kingdom"],
  type = "Dungeon",
  cont = true,
 }, -- Ahn'kahet: The Old Kingdom
 [26005090] = {
  id = 272,
  name = L["Azjol-Nerub"],
  type = "Dungeon",
 }, -- Azjol-Nerub
 [87305100] = {
  id = 754,
  name = L["Naxxramas"],
  type = "Raid",
 }, -- Naxxramas
 [61305260] = {
  id = 761,
  name = L["The Ruby Sanctum"],
  type = "Raid",
 }, -- The Ruby Sanctum
 [60005690] = {
  id = 755,
  name = L["The Obsidian Sanctum"],
  type = "Raid",
 }, -- The Obsidian Sanctum
}
nodes[117] = { -- HowlingFjord
 --[57304680] = { 285,  type = "Dungeon" }, -- Utgarde Keep, more accurate but right underneath Utgarde Pinnacle
 [58005000] = {
  id = 285,
  name = L["Utgarde Keep"],
  type = "Dungeon",
 }, -- Utgarde Keep, at doorway entrance
 [57204660] = {
  id = 286,
  name = L["Utgarde Pinnacle"],
  type = "Dungeon",
 }, -- Utgarde Pinnacle
}
nodes[118] = { -- IcecrownGlacier
 [54409070] = {
  id = { 276, 278, 280 },
  name = L["Halls of Reflection"] .. "\n" .. L["Pit of Saron"] .. "\n" .. L["The Forge of Souls"],
  type = "Dungeon",
  hideOnMinimap = true,
 }, -- The Forge of Souls, Halls of Reflection, Pit of Saron
 [74202040] = {
  id = 284,
  name = L["Trial of the Champion"],
  type = "Dungeon",
  hideOnContinent = true,
 }, -- Trial of the Champion
 [75202180] = {
  id = 757,
  name = L["Trial of the Crusader"],
  type = "Raid",
  hideOnContinent = true,
 }, -- Trial of the Crusader
 [53808720] = {
  id = 758,
  name = L["Icecrown Citadel"],
  type = "Raid",
 }, -- Icecrown Citadel
}
nodes[123] = { -- LakeWintergrasp
 [50001160] = {
  id = 753,
  name = L["Vault of Archavon"],
  type = "Raid",
 }, -- Vault of Archavon
}
nodes[120] = { -- TheStormPeaks
 [45302140] = {
  id = 275,
  name = L["Halls of Lightning"],
  type = "Dungeon",
 }, -- Halls of Lightning
 [39602690] = {
  id = 277,
  name = L["Halls of Stone"],
  type = "Dungeon",
 }, -- Halls of Stone
 [41601770] = {
  id = 759,
  name = L["Ulduar"],
  type = "Raid",
 }, -- Ulduar
}
nodes[121] = { -- ZulDrak
 [28508700] = {
  id = 273,
  name = L["Drak'Tharon Keep"],
  type = "Dungeon",
 }, -- Drak'Tharon Keep 17402120 Grizzly Hills
 [76202110] = {
  id = 274,
  name = L["Gundrak"],
  type = "Dungeon",
 }, -- Gundrak Left Entrance
 [81302900] = {
  id = 274,
  name = L["Gundrak"],
  type = "Dungeon",
 }, -- Gundrak Right Entrance
}

-- NORTHREND MINIMAP, For things that would be too crowded on the continent or zone maps but look correct on the minimap
minimap[118] = { -- IcecrownGlacier
 [54908980] = {
  id = 280,
  name = L["The Forge of Souls"],
  type = "Dungeon",
  hideOnContinent = true,
 }, -- The Forge of Souls
 [55409080] = {
  id = 276,
  name = L["Halls of Reflection"],
  type = "Dungeon",
  hideOnContinent = true,
 }, -- Halls of Reflection
 [54809180] = {
  id = 278,
  name = L["Pit of Saron"],
  type = "Dungeon",
  hideOnContinent = true,
 }, -- Pit of Saron 54409070 Summoning stone in the middle of last 3 dungeons
}

-- NORTHREND CONTINENT, For things that should be shown or merged only at the continent level
nodes[113] = { -- Northrend
 --[80407600] = { 285,  type = "Dungeon", false, 286 }, -- Utgarde Keep, Utgarde Pinnacle CONTINENT MERGE Location is slightly incorrect
 [47501750] = {
  id = { 757, 284 },
  name = L["Trial of the Champion"] .. '\n' .. L["Trial of the Crusader"],
  type = "Mixed",
  showOnContinent = true,
 }, -- Trial of the Crusader and Trial of the Champion
}
end

end

function Addon:FullUpdate()
	self:PopulateTable()
	self:PopulateMinimap()
end
