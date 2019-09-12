local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)
if not HandyNotes then return end
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_FlightMasters (Classic)")

local iconDefault = "Interface\\MINIMAP\\TRACKING\\FlightMaster"
local iconUndiscovered = "Interface\\Addons\\HandyNotes_FlightMasters (Classic)\\flightmaster_undiscovered.tga"

local db, learned
local _, class, faction
local nodes = { }
nodes[1413] = {
	[44405900] = {
		name = L["Camp Taurajo, The Barrens"],
		npcName = L["Omusa Thunderhorn"],
		faction = "Horde",
	},
	[51503030] = {
		name = L["Crossroads, The Barrens"],
		npcName = L["Devrak"],
		faction = "Horde",
	},
	[63003700] = {
		name = L["Ratchet, The Barrens"],
		npcName = L["Bragok"],
		faction = "Neutral",
	},
}
nodes[1417] = { -- Arathi Highlands
	[45804620] = {
		name = L["Refuge Pointe, Arathi"],
		npcName = L["Cedrik Prose"],
		faction = "Alliance",
	},
	[73003260] = {
		name = L["Hammerfall, Arathi"],
		npcName = L["Urda"],
		faction = "Horde",
	},
}
nodes[1418] = {
	[04404500] = {
		name = L["Kargath, Badlands"],
		npcName = L["Gorrik"],
		faction = "Horde",
	},
}
nodes[1419] = {
	[65602440] = {
		name = L["Nethergarde Keep, Blasted Lands"],
		npcName = L["Alexandra Constantine"],
		faction = "Alliance",
	},
}
nodes[1421] = { -- Silverpine Forest
	[45604240] = {
		name = L["The Sepulcher, Silverpine Forest"],
		npcName = L["Karos Razok"],
		faction = "Horde",
	},
}
nodes[1422] = { -- Western Plaguelands
	[43008520] = {
		name = L["Chillwind Camp, Western Plaguelands"],
		npcName = L["Bibilfaz Featherwhistle"],
		faction = "Alliance",
	},
}
nodes[1423] = { -- Eastern Plaguelands
	[80205750] = {
		name = L["Light's Hope Chapel, Eastern Plaguelands"],
		npcName = L["Georgia"],
		faction = "Horde",
	},
	[81605920] = {
		name = L["Light's Hope Chapel, Eastern Plaguelands"],
		npcName = L["Khaelyn Steelwing"],
		faction = "Alliance",
	},
}
nodes[1424] = { -- Hillsbrad Foothills
	[49405240] = {
		name = L["Southshore, Hillsbrad"],
		npcName = L["Darla Harris"],
		faction = "Alliance",
	},
	[60201860] = {
		name = L["Tarren Mill, Hillsbrad"],
		npcName = L["Zarise"],
		faction = "Horde",
	},
}
nodes[1425] = {
	[11004600] = {
		name = L["Aerie Peak, The Hinterlands"],
		npcName = L["Guthrum Thunderfist"],
		faction = "Alliance",
	},
	[81608180] = {
		name = L["Revantusk Village, The Hinterlands"],
		npcName = L["Gorkas"],
		faction = "Horde",
	},
}
nodes[1427] = {
	[34803080] = {
		name = L["Thorium Point, Searing Gorge"],
		npcName = L["Grisha"],
		faction = "Horde",
	},
	[37803060] = {
		name = L["Thorium Point, Searing Gorge"],
		npcName = L["Lanie Reed"],
		faction = "Alliance",
	},
}
nodes[1428] = {
	[65602420] = {
		name = L["Flame Crest, Burning Steppes"],
		npcName = L["Vahgruk"],
		faction = "Horde",
	},
	[84406820] = {
		name = L["Morgan's Vigil, Burning Steppes"],
		npcName = L["Borgus Stoutarm"],
		faction = "Alliance",
	},
}
nodes[1431] = {
	[77604440] = {
		name = L["Darkshire, Duskwood"],
		npcName = L["Felicia Maline"],
		faction = "Alliance",
	},
}
nodes[1432] = {
	[33805080] = {
		name = L["Thelsamar, Loch Modan"],
		npcName = L["Thorgrum Borrelson"],
		faction = "Alliance",
	},
}
nodes[1433] = {
	[30605920] = {
		name = L["Lakeshire, Redridge"],
		npcName = L["Ariena Stormfeather"],
		faction = "Alliance",
	},
}
nodes[1434] = { -- Stranglethorn
	[32402920] = {
		name = L["Grom'gol, Stranglethorn"],
		npcName = L["Thysta"],
		faction = "Horde",
	},
	[26807700] = {
		name = L["Booty Bay, Stranglethorn"],
		npcName = L["Gringer"],
		faction = "Horde",
	},
	[27407760] = {
		name = L["Booty Bay, Stranglethorn"],
		npcName = L["Gyll"],
		faction = "Alliance",
	},
}
nodes[1435] = {
	[46005460] = {
		name = L["Stonard, Swamp of Sorrows"],
		npcName = L["Breyk"],
		faction = "Horde",
	},
}
nodes[1436] = {
	[56405260] = {
		name = L["Sentinel Hill, Westfall"],
		npcName = L["Thor"],
		faction = "Alliance",
	},
}
nodes[1437] = { -- Wetlands
	[09605960] = {
		name = L["Menethil Harbor, Wetlands"],
		npcName = L["Shellei Brondir"],
		faction = "Alliance",
	},
}
nodes[1438] = {
	[58409400] = {
		name = L["Rut'theran Village, Teldrassil"],
		npcName = L["Vesprystus"],
		faction = "Alliance",
	},
}
nodes[1439] = {
	[36404560] = {
		name = L["Auberdine, Darkshore"],
		npcName = L["Caylais Moonfeather"],
		faction = "Alliance"
	},
}
nodes[1440] = {
	[12203380] = {
		name = L["Zoram'gar Outpost, Ashenvale"],
		npcName = L["Andruk"],
		faction = "Horde",
	},
	[34404800] = {
		name = L["Astranaar, Ashenvale"],
		npcName = L["Daelyshia"],
		faction = "Alliance",
	},
	[73206160] = {
		name = L["Splintertree Post, Ashenvale"],
		npcName = L["Vhulgra"],
		faction = "Horde",
	},
}
nodes[1441] = {
	[45004920] = {
		name = L["Freewind Post, Thousand Needles"],
		npcName = L["Nyse"],
		faction = "Horde",
	},
}
nodes[1442] = {
	[36400720] = {
		name = L["Stonetalon Peak, Stonetalon Mountains"],
		npcName = L["Teloren"],
		faction = "Alliance",
	},
	[45205980] = {
		name = L["Sun Rock Retreat, Stonetalon Mountains"],
		npcName = L["Tharm"],
		faction = "Horde",
	},
}
nodes[1443] = {
	[21607400] = {
		name = L["Shadowprey Village, Desolace"],
		npcName = L["Thalon"],
		faction = "Horde",
	},
	[64601040] = {
		name = L["Nijel's Point, Desolace"],
		npcName = L["Baritanas Skyriver"],
		faction = "Alliance",
	},
}
nodes[1444] = {
	[30204320] = {
		name = L["Feathermoon, Feralas"],
		npcName = L["Fyldren Moonfeather"],
		faction = "Alliance",
	},
	[75404420] = {
		name = L["Camp Mojache, Feralas"],
		npcName = L["Shyn"],
		faction = "Horde",
	},
	[89404580] = {
		name = L["Thalanaar, Feralas"],
		npcName = L["Thyssiana"],
		faction = "Alliance",
	},
}
nodes[1445] = {
	[35603180] = {
		name = L["Brackenwall Village, Dustwallow Marsh"],
		npcName = L["Shardi"],
		faction = "Horde",
	},
	[67405120] = {
		name = L["Theramore, Dustwallow Marsh"],
		npcName = L["Baldruc"],
		faction = "Alliance",
	},
}
nodes[1446] = {
	[51002920] = {
		name = L["Gadgetzan, Tanaris"],
		npcName = L["Bera Stonehammer"],
		faction = "Alliance",
	},
	[51602560] = {
		name = L["Gadgetzan, Tanaris"],
		npcName = L["Bulkrek Ragefist"],
		faction = "Horde",
	},
}
nodes[1447] = {
	[11807740] = {
		name = L["Talrendis Point, Azshara"],
		npcName = L["Jarrodenus"],
		faction = "Alliance",
	},
	[22004960] = {
		name = L["Valormok, Azshara"],
		npcName = L["Kroum"],
		faction = "Horde",
	},
}
nodes[1448] = {
	[34405380] = {
		name = L["Bloodvenom Post, Felwood"],
		npcName = L["Brakkar"],
		faction = "Horde",
	},
	[62602420] = {
		name = L["Talonbranch Glade, Felwood"],
		npcName = L["Mishellena"],
		faction = "Alliance",
	},
}
nodes[1449] = {
	[45200580] = {
		name = L["Marshal's Refuge, Un'Goro Crater"],
		npcName = L["Gryfe"],
		faction = "Neutral",
	},
}
nodes[1450] = {
	[32206640] = {
		name = L["Moonglade"],
		npcName = L["Faustron"],
		faction = "Horde",
	},
	[44204520] = {
		name = L["Darnassus Flight Master"],
		npcName = L["Silva Fil'naveth"],
		faction = "Alliance",
		classes = { DRUID = true },
	},
	[44404540] = {
		name = L["Thunder Bluff Flight Master"],
		npcName = L["Bunthen Plainswind"],
		faction = "Horde",
		classes = { DRUID = true },
	},
	[48006700] = {
		name = L["Moonglade"],
		npcName = L["Sindrayl"],
		faction = "Alliance",
	},
}
nodes[1451] = {
	[48803660] = {
		name = L["Cenarion Hold, Silithus"],
		npcName = L["Runk Windtamer"],
		faction = "Horde",
	},
	[50603440] = {
		name = L["Cenarion Hold, Silithus"],
		npcName = L["Cloud Skydancer"],
		faction = "Alliance",
	},
}
nodes[1452] = {
	[60403620] = {
		name = L["Everlook, Winterspring"],
		npcName = L["Yugrek"],
		faction = "Horde",
	},
	[62203660] = {
		name = L["Everlook, Winterspring"],
		npcName = L["Maethrya"],
		faction = "Alliance",
	},
}
nodes[1453] = {
	[66206240] = {
		name = L["Stormwind, Elwynn"],
		npcName = L["Dungar Longdrink"],
		faction = "Alliance",
	},
}
nodes[1454] = { -- Orgrimmar
	[45206380] = {
		name = L["Orgrimmar, Durotar"],
		npcName = L["Doras"],
		faction = "Horde",
	},
}
nodes[1455] = { -- Ironforge
	[55604820] = {
		name = L["Ironforge, Dun Morogh"],
		npcName = L["Gryth Thurden"],
		faction = "Alliance",
	},
}
nodes[1456] = {
	[46805000] = {
		name = L["Thunder Bluff, Mulgore"],
		npcName = L["Tal"],
		faction = "Horde",
	},
}
nodes[1458] = { -- Undercity
	[63404860] = {
		name = L["Undercity, Tirisfal"],
		npcName = L["Michael Garrett"],
		faction = "Horde",
	},
}

local pluginHandler = { }
function pluginHandler:OnEnter(uiMapId, coord)
    local nodeData = nil
	
    --if (not nodes[mapFile][coord]) then return end
	if (nodes[uiMapId] and nodes[uiMapId][coord]) then
	 nodeData = nodes[uiMapId][coord]
	end
	
	if (not nodeData) then
		--print('No node data for', uiMapId, coord)
		return
	end
	
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
	if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

    if (not nodeData.name) then return end
	tooltip:AddLine(nodeData.name)
	if (nodeData.npcName) then
		tooltip:AddLine(nodeData.npcName, 0, 0.6, 0.1)
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

	local function iter(t, prestate)
		if not t then return end
		local data = t.data

		local state, value = next(data, prestate)

		while(state) do
			if value then
				if (value.faction == faction or value.faction == "Neutral")  and (not value.classes or value.classes[class]) then
					local icon = iconDefault
					-- I don't have a check for if the druids have "unlocked" their flight masters so just consider them discovered
					if db.undiscovered and not (value.classes and value.classes[class]) then
						icon = learned[value.name] and iconDefault or iconUndiscovered
					end
					return state, nil, icon, db.zoneScale, db.zoneAlpha
				end
			end
			state, value = next(data, state)
		end
		wipe(t)
		tablepool[t] = true
	end


	local function iterCont(t, prestate)
		if not t then return end
		if not db.continent then return end
		local zone = t.C[t.Z]
		local data = nodes[zone]
		local state, value
		while zone do
			if data then -- Only if there is data for this zone
				state, value = next(data, prestate)
				while state do -- Have we reached the end of this zone?
					if (value.faction == faction or value.faction == "Neutral") and (not value.hideOnContinent or zone == t.contId)   and (not value.classes or value.classes[class]) then -- Show on continent?
						local icon = iconDefault
						if db.undiscovered and not (value.classes and value.classes[class]) then
							icon = learned[value.name] and iconDefault or iconUndiscovered
						end
						return state, zone, icon, db.continentScale, db.continentAlpha
					end
					state, value = next(data, state) -- Get next data
				end
			end
			-- Get next zone
			t.Z = next(t.C, t.Z)
			zone = t.C[t.Z]
			data = nodes[zone]
			prestate = nil
		end
		wipe(t)
		tablepool[t] = true
	end

	function pluginHandler:GetNodes2(uiMapId, isMinimapUpdate)
		--print(uiMapId)
		local C = HandyNotes:GetContinentZoneList(uiMapId) -- Is this a continent?
		if C then
			local tbl = next(tablepool) or {}
			tablepool[tbl] = nil
			tbl.C = C
			tbl.Z = next(C)
			tbl.contId = uiMapId

			return iterCont, tbl, nil
		else -- It is a zone
			if (nodes[uiMapId] == nil) then return iter end -- Throws error if I don't do this
			--print('zone')
			local tbl = next(tablepool) or {}
			tablepool[tbl] = nil

			tbl.data = nodes[uiMapId]

			return iter, tbl, nil
		end
	end
end

local waypoints = {}
local function setWaypoint(mapFile, coord)
	if not TomTom then return end
	local x, y = HandyNotes:getXY(coord)
	TomTom:AddWaypoint(mapFile, x, y, {
		title = nodes[mapFile][coord].name,
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
		zoneScale = 1,
		zoneAlpha = 1,
		continentScale = 1,
		continentAlpha = 1,
		continent = true,
		tomtom = true,
		undiscovered = true,
	},
	char = {
		learned = {
			['*'] = false,
		}
	},
}

local Addon = CreateFrame("Frame")
Addon:RegisterEvent("PLAYER_LOGIN")
Addon:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end)

local function updateStuff()
	HandyNotes:SendMessage("HandyNotes_NotifyUpdate", "FlightMasters")
end

function Addon:PLAYER_ENTERING_WORLD()
	faction = UnitFactionGroup("player")
	_, class = UnitClass("player")
	updateStuff()
end

function Addon:TAXIMAP_OPENED()
	for i = 1, NumTaxiNodes() do
		self.db.char.learned[TaxiNodeName(i)] = true
	end
	updateStuff()
end

function Addon:PLAYER_LOGIN()
 local options = {
 type = "group",
 name = "FlightMasters",
 desc = "Locations of flightmasters.",
 get = function(info) return db[info[#info]] end,
 set = function(info, v) db[info[#info]] = v HandyNotes:SendMessage("HandyNotes_NotifyUpdate", "FlightMasters") end,
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
  undiscovered = {
	type = "toggle",
	name = L["Show Undiscovered"],
	desc = L["Use a different icon for undiscovered flightmasters"],
	order = 2.1,
  },
 },
}

 HandyNotes:RegisterPluginDB("FlightMasters", pluginHandler, options)
 self.db = LibStub("AceDB-3.0"):New("HandyNotes_FlightMastersClassicDB", defaults, true)
 db = self.db.profile
 learned = self.db.char.learned
 
 Addon:RegisterEvent("PLAYER_ENTERING_WORLD")
 Addon:RegisterEvent("TAXIMAP_OPENED")
end
