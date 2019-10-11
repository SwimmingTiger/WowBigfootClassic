local name, data = ...

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)
if not HandyNotes then return end

local Addon = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_NPCs (Classic)", "AceConsole-3.0", "AceEvent-3.0")
local Search, AltRecipes -- Modules
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_NPCs (Classic)")
local LibQTip = LibStub('LibQTip-1.0')

local iconDefault = "Interface\\MINIMAP\\TRACKING\\FlightMaster" -- Remove this later or something

local nodes = data["nodes"]

local icons = {
	flightmasters = "Interface\\MINIMAP\\TRACKING\\FlightMaster",
	flightmastersUndiscovered = "Interface\\Addons\\HandyNotes_NPCs (Classic)\\flightmaster_undiscovered.tga",
	auctioneers = "Interface\\MINIMAP\\TRACKING\\Auctioneer",
	bankers = "Interface\\MINIMAP\\TRACKING\\Banker",
	guildmasters = "Interface\\MINIMAP\\TRACKING\\POIArrow", -- TODO: Find a better icon
	innkeepers = "Interface\\MINIMAP\\TRACKING\\Innkeeper",
	mailboxes = "Interface\\MINIMAP\\TRACKING\\Mailbox",
	repair = "Interface\\MINIMAP\\TRACKING\\Repair",
	spirithealers = "Interface\\MINIMAP\\TRACKING\\Focus", -- TODO: Find a better icon
	stablemasters = "Interface\\MINIMAP\\TRACKING\\StableMaster",
	trainers = "Interface\\MINIMAP\\TRACKING\\Profession",
	vendors = "Interface\\MINIMAP\\TRACKING\\Food",
	classTrainer = "Interface\\MINIMAP\\TRACKING\\Class",
	ammo = "Interface\\MINIMAP\\TRACKING\\Ammunition",
	reagent = "Interface\\MINIMAP\\TRACKING\\Reagents",
	poison = "Interface\\MINIMAP\\TRACKING\\Poisons",
	primaryProfession = "Interface\\MINIMAP\\TRACKING\\Profession", -- Just in case I want seperate icons later
	secondaryProfession = "Interface\\MINIMAP\\TRACKING\\Profession", -- Same
	rares = "Interface\\MINIMAP\\Minimap_skull_normal",
	alchemy = "Interface\\ICONS\\Trade_Alchemy",
	blacksmithing = "Interface\\ICONS\\Trade_BlackSmithing",
	cooking = "Interface\\ICONS\\inv_misc_food_15",
	enchanting = "Interface\\ICONS\\Trade_Engraving",
	engineering = "Interface\\ICONS\\Trade_Engineering",
	first_aid = "Interface\\ICONS\\spell_holy_sealofsacrifice",
	fishing = "Interface\\ICONS\\Trade_Fishing",
	herbalism = "Interface\\ICONS\\Trade_Herbalism",
	leatherworking = "Interface\\ICONS\\Trade_LeatherWorking",
	mining = "Interface\\ICONS\\Trade_Mining",
	skinning = "Interface\\ICONS\\inv_misc_pelt_wolf_01",
	tailoring = "Interface\\ICONS\\Trade_Tailoring",
}

local PROFESSIONS = { }
PROFESSIONS[L["Alchemy"]] = "Alchemy"
PROFESSIONS[L["Blacksmithing"]] = "Blacksmithing"
PROFESSIONS[L["Enchanting"]] = "Enchanting"
PROFESSIONS[L["Engineering"]] = "Engineering"
PROFESSIONS[L["Leatherworking"]] = "Leatherworking"
PROFESSIONS[L["Tailoring"]] = "Tailoring"
PROFESSIONS[L["Herbalism"]] = "Herbalism"
PROFESSIONS[L["Mining"]] = "Mining"
PROFESSIONS[L["Skinning"]] = "Skinning"
PROFESSIONS[L["Cooking"]] = "Cooking"
PROFESSIONS[L["First Aid"]] = "First Aid"
PROFESSIONS[L["Fishing"]] = "Fishing"

local db, learned
local _, class, faction
local professions = { }

local pluginHandler = { }
function pluginHandler:OnEnter(uiMapId, coord)
	local nodeData = nodes[uiMapId][coord]
	--(nodeData.category == "vendors" or nodeData.category == "repair")
	if db.showVendorData and nodeData["npcID"] and data["vendors"][nodeData["npcID"]] then
		local tooltip = LibQTip:Acquire("HandyNotes_NPCs", 2, "LEFT", "RIGHT")
		self.tooltip = tooltip
		lineNumber = 1
		tooltip:AddHeader(nodeData.name)
		tooltip:SetLineTextColor(1, 0, 0.6, 0.1)
		tooltip:AddSeparator()
		lineNumber = lineNumber + 2
		if data["vendors"][nodeData["npcID"]] then
			for item in data["vendors"][nodeData["npcID"]]:gmatch("([^,]+)") do
				item = tonumber(item)
				if data["items"][item] then
					local icon = 'Interface\\ICONS\\' .. data["items"][item].icon
					local itemColor = ITEM_QUALITY_COLORS[data["items"][item].quality]
					-- TODO Add default icon and color just in case we don't have them
					tooltip:AddLine("|T".. icon ..":0|t" .. data["items"][item].name, GetCoinTextureString(data["items"][item].buyPrice))
					tooltip:SetCellTextColor(lineNumber, 1, itemColor.r, itemColor.g, itemColor.b)
					lineNumber = lineNumber + 1
				end
			end
		end
		tooltip:SmartAnchorTo(self)
		tooltip:Show()
	else
		local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
		if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
			tooltip:SetOwner(self, "ANCHOR_LEFT")
		else
			tooltip:SetOwner(self, "ANCHOR_RIGHT")
		end

		if (not nodeData.name) then return end
		tooltip:AddLine(nodeData.name)
		if (nodeData.description) then
			tooltip:AddLine(nodeData.description, 0, 0.6, 0.1)
		end
		if nodeData.subcategory == "weaponmaster" then
			if nodeData.npcID and data["weaponmasters"][nodeData.npcID] then
				for skill in data["weaponmasters"][nodeData.npcID]:gmatch("([^,]+)") do
					skill = tonumber(skill)
					tooltip:AddLine(data["weaponskills"][skill].name)
				end
			end
		end
		tooltip:Show()
		return
	end
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

	local function iter(t, prestate)
		local vendors = {
			ammo = db.showAmmoVendors,
		}
		if not t then return end
		local data = t.data

		local state, value = next(data, prestate)
		
		while(state) do
			if value then
				-- "Do you think God stays in heaven because he, too, lives in fear of what he's created here on earth?"
				if db.show then
				if (value.faction == faction or value.faction == "Neutral") then
				if not (value.category == "flightmasters") or db.showFlightMasters and (not value.classes or value.classes[class]) then
				if not (value.category == "guildmasters") or db.showGuildMasters then
				if not (value.category == "rares") or db.showRares then
				if not (value.subcatogories and value.subcategories["weaponmaster"]) or db.showWeaponMasters then
				if not (value.category == "spirithealers") or db.showSpiritHealers then
				if not (value.category == "vendors") or ((db.showAmmoVendors and (value.vendors and value.vendors['ammo'])) or (db.showReagentVendors and (value.subcategories and value.subcategories["reagent"])) or (db.showPoisonVendors and (value.subcategories and value.subcategories["poison"])) or (db.showMisc)) then
				if not (value.category == "repair") or ((db.showAmmoVendors and (value.vendors and value.vendors['ammo'])) or db.showRepair) then
				if not (value.category == "auctioneers") or db.showAuctioneers then
				if not (value.category == "bankers") or db.showBankers then
				if not (value.category == "innkeepers") or db.showInnkeepers then
				if not (value.category == "mailboxes") or db.showMailboxes then
				if not (value.category == "stablemasters") or class == "HUNTER" then -- Hide stablemasters for non-hunters
				if not (value.category == "trainers" and value.description == "Pet Trainer") or class == "HUNTER" or db.showClassTrainers == "ALL" then -- Hide pet trainers for non-hunters
				if not (value.category == "trainers" and value.subcategories and value.subcategories["classTrainer"]) or ((db.showClassTrainers == "ALL") or (db.showClassTrainers == "MINE" and value.classes and value.classes[class])) then
				if not (value.category == "primaryProfession" or value.category == "secondaryProfession") or ((db.showProfessions == "ALL") or (db.showProfessions == "MINE" and professions[value.profession])) then
					-- TODO merge subcategory and subcategories
					-- TODO Maybe unmerge them again; I've made this worse
					
					local icon = icons[value.category] or iconDefault
					if value.category == "vendors" and value.subcategories then
						if db.showReagentVendors and value.subcategories['reagent'] then
							icon = icons['reagent']
						elseif db.showPoisonVendors and value.subcategories['poison'] then
							icon = icons['poison']
						end
					end

					if (value.category == "vendors" or value.category == "repair") then
						if db.vendorsUseProfessionIcons and value.profession then
							--local i = next(value.subcategories)
							icon = icons[value.profession]
						end
						-- The whole point of this was to allow the player to further filter the vendors based on sold items
						-- but I don't like this
						for k, v in pairs(vendors) do
							if v and value.vendors and value.vendors[k] then
								icon = icons[k]
							end
						end
					end

						
					if value.category == "flightmasters" and db.undiscoveredFlightmasters and not (value.classes and value.classes[class]) then
						icon = learned[value.fpName] and icons[value.category] or icons["flightmastersUndiscovered"]
					end

					return state, nil, icon, db.zoneScale, db.zoneAlpha
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
			end
			state, value = next(data, state)
		end
		wipe(t)
		tablepool[t] = true
	end


	local function iterCont(t, prestate)
		if not t then return end
		if not db.continent and not db.alwaysShowFlightmastersOnContinent then return end
		local vendors = {
			ammo = db.showAmmoVendors,
		}
		local zone = t.C[t.Z]
		local data = nodes[zone]
		local state, value
		while zone do
			if data then -- Only if there is data for this zone
				state, value = next(data, prestate)
				while state do -- Have we reached the end of this zone?
					if db.show then
					if db.continent or (db.alwaysShowFlightmastersOnContinent and value.category == "flightmasters") then
					if (value.faction == faction or value.faction == "Neutral") and (not value.hideOnContinent or zone == t.contId) then -- Show on continent?
					if not (value.category == "flightmasters") or db.showFlightMasters and (not value.classes or value.classes[class]) then
					if not (value.category == "guildmasters") or db.showGuildMasters then
					if not (value.category == "rares") or db.showRares then
					if not (value.subcategory == "weaponmaster") or db.showWeaponMasters then
					if not (value.category == "spirithealers") or db.showSpiritHealers then
					if not (value.category == "vendors") or ((db.showAmmoVendors and (value.vendors and value.vendors['ammo'])) or (db.showReagentVendors and (value.subcategories and value.subcategories["reagent"])) or (db.showPoisonVendors and (value.subcategories and value.subcategories["poison"])) or (db.showMisc)) then
					if not (value.category == "repair") or ((db.showAmmoVendors and (value.vendors and value.vendors['ammo'])) or db.showRepair) then
					if not (value.category == "auctioneers") or db.showAuctioneers then
					if not (value.category == "bankers") or db.showBankers then
					if not (value.category == "innkeepers") or db.showInnkeepers then
					if not (value.category == "mailboxes") or db.showMailboxes then
					if not (value.category == "stablemasters") or class == "HUNTER" then -- Hide stablemasters for non-hunters
					if not (value.category == "trainers" and value.description == "Pet Trainer") or class == "HUNTER" or db.showClassTrainers == "ALL" then -- Hide pet trainers for non-hunters
					if not (value.category == "trainers" and value.subcategory == "classTrainer") or ((db.showClassTrainers == "ALL") or (db.showClassTrainers == "MINE" and value.classes and value.classes[class])) then
					if not (value.category == "primaryProfession" or value.category == "secondaryProfession") or ((db.showProfessions == "ALL") or (db.showProfessions == "MINE" and professions[value.profession])) then
						
					local icon = icons[value.category] or iconDefault
						if value.category == "vendors" and value.subcategories then
							if db.showReagentVendors and value.subcategories['reagent'] then
								icon = icons['reagent']
							elseif db.showPoisonVendors and value.subcategories['poison'] then
								icon = icons['poison']
							end
						end

						if (value.category == "vendors" or value.category == "repair") then
							if db.vendorsUseProfessionIcons and value.profession then
								--local i = next(value.subcategories)
								icon = icons[value.profession]
							end
						-- The whole point of this was to allow the player to further filter the vendors based on sold items
						-- but I don't like this
							for k, v in pairs(vendors) do
								if v and value.vendors and value.vendors[k] then
									icon = icons[k]
								end
							end
						end
						if value.category == "flightmasters" and db.undiscoveredFlightmasters and not (value.classes and value.classes[class]) then
							icon = learned[value.fpName] and icons[value.category] or icons["flightmastersUndiscovered"]
						end
						return state, zone, icon, db.continentScale, db.continentAlpha
					end
					end
					end
					end
					end
					end
					end
					end
					end
					end
					end
					end
					end
					end
					end
					end
					end
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
	title = nodes[mapFile][coord].name
	if nodes[mapFile][coord].description then
		title = title .. '\n' .. nodes[mapFile][coord].description
	end
	TomTom:AddWaypoint(mapFile, x, y, {
		title = title,
		persistent = nil,
		minimap = true,
		world = true
	})
end

function pluginHandler:OnClick(button, pressed, mapFile, coord)
	if (not pressed) then return end
 --print(button, pressed, mapFile, coord)
	if (button == "MiddleButton" and Search and nodes[mapFile][coord].npcID) then
		Search:DumpVendorItems(nodes[mapFile][coord].npcID, nodes[mapFile][coord].name)
		Search:ShowWindow(true)
	end
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
		continent = false,
		tomtom = true,
		showAltRecipes = false,
		showVendorData = false,
		vendorsUseProfessionIcons = false,
		showInnkeepers = false,
		showMailboxes = false,
		showBankers = false,
		showAuctioneers = false,
		showGuildMasters = false,
		showRepair = false,
		showSpiritHealers = true,
		showWeaponMasters = true,
		showProfessions = "NONE",
		showClassTrainers = "MINE",
		showMisc = false,
		showReagentVendors = false,
		showPoisonVendors = false,
		showAmmoVendors = false,
		showRares = false,
		showFlightMasters = true,
		alwaysShowFlightmastersOnContinent = true,
		undiscoveredFlightmasters = true,
		show = true, -- Controls visibility of all nodes
		mapButton = false,
		minimapButton = { -- for LibDBIcon
			hide = false,
		},
		button = {
			x = -40,
			y = -30,
		},
	},
	char = {
		learned = {
			['*'] = false,
		}
	}
}

function Addon:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("HandyNotes_NPCsClassicDB", defaults, true)
	db = self.db.profile
	learned = self.db.char.learned

	Addon:RegisterEvent("PLAYER_LOGIN")
	Addon:RegisterEvent("SKILL_LINES_CHANGED")
	Addon:RegisterEvent("TAXIMAP_OPENED")
	Search = Addon:GetModule("Search")
	AltRecipes = Addon:GetModule("AltRecipes")
	self.PROFESSIONS = PROFESSIONS -- For sub modules
	self.professions = professions
end

function Addon:updateStuff()
	HandyNotes:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_NPCs")
end

function Addon:PLAYER_ENTERING_WORLD()
	faction = UnitFactionGroup("player")
	data["faction"] = faction
	_, class = UnitClass("player")
	data["class"] = class
	self:updateStuff()
end

function Addon:PLAYER_LOGIN()
 local options = {
 type = "group",
 name = "NPCs",
 desc = L["Locations of various npcs"],
 get = function(info) return db[info[#info]] end,
 set = function(info, v) db[info[#info]] = v Addon:CheckSettings() HandyNotes:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_NPCs") end,
 args = {
  mapButton = {
	type = "toggle",
	name = L["Show Map Button"],
	order = 1.01,
  },
  minimapButton = {
	type = "toggle",
	name = L["Show Minimap Button"],
	order = 1.02,
	get = function() return not db.minimapButton.hide end,
	set = function(info, value) db.minimapButton.hide = not value Addon:CheckSettings() end,
  },
  iconSettingsHeader = {
	type = "header",
	name = L["These settings control the look and feel of the icon."],
	order = 1.1,
  },
  vendorsUseProfessionIcons = {
	type = "toggle",
	name = L["Vendor Profession Icon"],
	desc = L["Use profession icons for specialty vendors"],
	order = 1.11,
  },
  zoneScale = {
   type = "range",
   name = L["Zone Scale"],
   desc = L["The scale of the icons shown on the zone map"],
   min = 0.2, max = 12, step = 0.1,
   order = 1.2,
  },
  zoneAlpha = {
   type = "range",
   name = L["Zone Alpha"],
   desc = L["The alpha of the icons shown on the zone map"],
   min = 0, max = 1, step = 0.01,
   order = 1.3,
  },
  continentScale = {
   type = "range",
   name = L["Continent Scale"],
   desc = L["The scale of the icons shown on the continent map"],
   min = 0.2, max = 12, step = 0.1,
   order = 1.5,
  },
  continentAlpha = {
   type = "range",
   name = L["Continent Alpha"],
   desc = L["The alpha of the icons shown on the continent map"],
   min = 0, max = 1, step = 0.01,
   order = 1.6,
  },
  continent = {
   type = "toggle",
   name = L["Show on Continent"],
   desc = L["Show icons on continent map"],
   order = 1.05,
  },
  show = {
	type = "toggle",
	name = L["Show/Hide Toggle"],
	desc = L["Toggles between showing or hiding npcs"],
	order = 1.04,
  },
  tomtom = {
   type = "toggle",
   name = L["Enable TomTom integration"],
   desc = L["Allow right click to create waypoints with TomTom"],
   order = 1.1,
  },
  showAltRecipes = {
	type = "toggle",
	name = L["Show Alt Recipes"],
	desc = L["Show which alts can learn a recipe in the item's tooltip"],
	order = 1.09,
  },
  showVendorData = {
	type = "toggle",
	name = L["Advanced Vendor Tooltip"],
	desc = L["Show items sold by vendor in tooltip"],
	order = 1.101,
  },
  showHeader = {
	type = "header",
	name = L["Show NPCs"],
	order = 3,
  },
  showBankers = {
	type = "toggle",
	name = L["Show Bankers"],
	order = 3.1,
  },
  showAuctioneers = {
	type = "toggle",
	name = L["Show Auctioneers"],
	order = 3.2,
  },
  showMailboxes = {
	type = "toggle",
	name = L["Show Mailboxes"],
	order = 3.3,
  },
  showGuildMasters = {
	type = "toggle",
	name = L["Show Guildmasters"],
	order = 3.35,
  },
  showInnkeepers = {
	type = "toggle",
	name = L["Show Innkeepers"],
	order = 3.4,
  },
  showRepair = {
	type = "toggle",
	name = L["Show Repairers"],
	order = 3.5,
  },
  showSpiritHealers = {
	type = "toggle",
	name = L["Show Spirit Healers"],
	order = 3.6,
  },
  showWeaponMasters = {
	type = "toggle",
	name = L["Show Weapon Masters"],
	order = 3.7,
  },
  showRares = {
	type = "toggle",
	name = L["Show Rares"],
	order = 3.75,
  },
  showProfessions = {
	name = L["Show Professions"],
	type = "select",
	values = { ALL = L["All"], MINE = L["Learned"], NONE = L["None"] },
	style = "radio",
	order = 5,
  },
  showClassTrainers = {
	name = L["Show Class Trainers"],
	type = "select",
	values = { ALL = L["All"], MINE = L["Mine"], NONE = L["None"] },
	style = "radio",
	order = 6,
  },
  showFlightMastersHeader = {
	name = L["Flight Masters"],
	type = "header",
	order = 3.9,
  },
  showFlightMasters = {
	name = L["Show Flight Masters"],
	type = "toggle",
	order = 3.91,
  },
  undiscoveredFlightmasters = {
	name = L["Show Undiscovered"],
	desc = L["Use a different icon for undiscovered flightmasters"],
	type = "toggle",
	order = 3.92,
  },
  alwaysShowFlightmastersOnContinent = {
	name = L["Always Show on Continent"],
	desc = L["Show flightmasters on continent even if you disabled \"Show on Continent\"."],
	type = "toggle",
	order = 3.93,
  },
  showVendorsHeader = {
	name = L["Show Vendors"],
	type = "header",
	order = 4,
  },
  showMisc = {
	name = L["Misc. Vendors"],
	type = "toggle",
	desc= L["Catch-all for uncategorized vendors"],
	order = 4.1,
  },
  showReagentVendors = {
	name = L["Reagent Vendors"],
	type = "toggle",
	order = 4.2
  },
  showPoisonVendors = {
	name = L["Poison Vendors"],
	type = "toggle",
	order = 4.3,
  },
   showAmmoVendors = {
	name = L["Ammo Vendors"],
	type = "toggle",
	order = 4.35,
  },
  resetMapButton = {
	name = L["Reset Map Button"],
	desc = L["Places button back in default position"],
	type = "execute",
	order = 10,
	func = function() db.button.x = -40 db.button.y = -30 self.button:ClearAllPoints() self.button:SetPoint("TOPRIGHT", WorldMapFrame, "TOPRIGHT", db.button.x, db.button.y)end,
  },
 },
}

 HandyNotes:RegisterPluginDB("HandyNotes_NPCs", pluginHandler, options)

 
 local button = CreateFrame("Button", nil, WorldMapFrame, "UIPanelButtonTemplate")
 button:SetMovable(true)
 button:EnableMouse(true)
 button:SetClampedToScreen(true)
 button:RegisterForDrag("LeftButton")
 button:SetScript("OnDragStart", function(self, button) Addon:DragStart(self, button) end)
 button:SetScript("OnDragStop", function(self, button) Addon:DragStop(self, button) end)
 button:SetSize(50, 30)
 button:SetText("NPCs")
 button:SetPoint("TOPRIGHT", WorldMapFrame, "TOPRIGHT", db.button.x, db.button.y)
 button:SetFrameStrata("FULLSCREEN_DIALOG")
 self.button = button
 if db.mapButton then
	button:Show()
else
	button:Hide()
end
 
	local dropDownMenu = L_Create_UIDropDownMenu("HandyNotes_NPCsDropDownMenu", button)
	L_UIDropDownMenu_Initialize(dropDownMenu, HandyNotes_NPCsDropDownMenu, "MENU")
	button:SetScript("OnClick", function() L_ToggleDropDownMenu(1, nil, dropDownMenu, "cursor", 3, -3) end)
	button:SetScript("OnHide", function() L_CloseDropDownMenus() end)
 
	self.LDB = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("HandyNotes_NPCs", {
		type = "launcher",
		label = "NPCs",
		icon = "Interface\\MINIMAP\\TRACKING\\None",
		OnClick = function(clickedFrame, button)
		if (button == "LeftButton") then
			L_ToggleDropDownMenu(1, nil, dropDownMenu, "cursor", 3, -3)
		elseif (button == "RightButton") then
			if data["searchWindow"] then
				local w = data["searchWindow"]
				if w:IsVisible() then w:Hide() else w:Show() end
			end
		end
	end,
	})
	self.minimapButton = LibStub("LibDBIcon-1.0")
	self.minimapButton:Register("HandyNotes_NPCs", self.LDB, db.minimapButton)

	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:UnregisterEvent("PLAYER_LOGIN") -- Probably Not Needed
end

function Addon:SKILL_LINES_CHANGED()
	table.wipe(professions)
	for i = 1, GetNumSkillLines() do
		local skillName = GetSkillLineInfo(i)
		if PROFESSIONS[skillName] then
			professions[PROFESSIONS[skillName]] = true
		end
		--[[for k, v in pairs(data["weaponskills"]) do Weapon skills learned have slightly different name, for instance one-handed maces to maces
			if v.name == skillName then
				data.weaponSkillLearned[k] = true
			end
		end--]]
	end
	self:updateStuff()
end

function Addon:TAXIMAP_OPENED()
	for i = 1, NumTaxiNodes() do
		self.db.char.learned[TaxiNodeName(i)] = true
	end
	self:updateStuff()
end

function HandyNotes_NPCsDropDownMenu_OnClick(self, arg1, arg2, checked)
	if (arg2) then
		db[arg1] = arg2
	else
		if db[arg1] then
			db[arg1] = false
		else
			db[arg1] = true
		end
	end
	HandyNotes:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_NPCs")
end

function HandyNotes_NPCsDropDownMenu(frame, level, menuList)
	local info = L_UIDropDownMenu_CreateInfo()

	if level == 1 then
		local options = {
			showMailboxes = L["Show Mailboxes"],
			showBankers = L["Show Bankers"],
			showRepair = L["Show Repairers"],
			showSpiritHealers = L["Show Spirit Healers"],
			showWeaponMasters = L["Show Weapon Masters"],
			showAuctioneers = L["Show Auctioneers"],
			showInnkeepers = L["Show Innkeepers"],
			showGuildMasters = L["Show Guildmasters"],
			showRares = L["Show Rares"],
		}

		info.text, info.keepShownOnClick, info.checked = L["Show/Hide Toggle"], true, db["show"]
		info.arg1 = "show"
		info.func = HandyNotes_NPCsDropDownMenu_OnClick
		L_UIDropDownMenu_AddButton(info)
		info.checked = nil
		info.keepShownOnClick = nil
		info.arg1 = nil
		info.func = nil
		info.text, info.hasArrow, info.menuList = L["Class Trainers"], true, "showClassTrainers"
		L_UIDropDownMenu_AddButton(info)
		info.text, info.hasArrow, info.menuList = L["Profession Trainers"], true, "showProfessions"
		L_UIDropDownMenu_AddButton(info)
		info.text, info.hasArrow, info.menuList = L["Vendors"], true, "vendors"
		L_UIDropDownMenu_AddButton(info)
		info.text, info.hasArrow, info.menuList = L["Flight Masters"], true, "flightmasters"
		L_UIDropDownMenu_AddButton(info)
		info.menuList = nil
		for k, v in pairs(options) do
			info.text, info.checked, info.hasArrow = v, db[k], false
			info.keepShownOnClick = true
			info.arg1 = k
			info.func = HandyNotes_NPCsDropDownMenu_OnClick
			L_UIDropDownMenu_AddButton(info)
		end
		info.text, info.keepShownOnClick, info.checked = L["Show on Continent"], true, db["continent"]
		info.arg1 = "continent"
		info.func = HandyNotes_NPCsDropDownMenu_OnClick
		L_UIDropDownMenu_AddButton(info)
		info.arg1 = nil
		info.text, info.checked, info.hasArrow = L["Close"], false, false
		info.func = function() L_CloseDropDownMenus() end
		L_UIDropDownMenu_AddButton(info)
	elseif menuList == "showClassTrainers" or menuList == "showProfessions" then
		local options = {
		showClassTrainers = {
			ALL = L["All"],
			MINE = L["Mine"],
			NONE = L["None"],
		},
		showProfessions = {
			ALL = L["All"],
			MINE = L["Learned"],
			NONE = L["None"],
		},
		}
		for k, v in pairs(options[menuList]) do
			info.text = v
			info.checked = db[menuList] == k and true or false
			--info.keepShownOnClick = true
			info.arg1 = menuList
			info.arg2 = k
			info.func = HandyNotes_NPCsDropDownMenu_OnClick
			L_UIDropDownMenu_AddButton(info, level)
		end
	elseif menuList == "vendors" or menuList == "flightmasters" then
		local options = {
			vendors = {
				showMisc = L["Misc. Vendors"],
				showReagentVendors = L["Reagent Vendors"],
				showPoisonVendors = L["Poison Vendors"],
				showAmmoVendors = L["Ammo Vendors"],
			},
			flightmasters = {
				showFlightMasters = L["Show Flight Masters"],
				undiscoveredFlightmasters = L["Show Undiscovered"],
				alwaysShowFlightmastersOnContinent = L["Always Show on Continent"],
			},
		}
		for k, v in pairs(options[menuList]) do
			info.text , info.checked = v, db[k]
			info.keepShownOnClick = true
			info.arg1 = k
			info.func = HandyNotes_NPCsDropDownMenu_OnClick
			L_UIDropDownMenu_AddButton(info, level)
		end
	end
end

function Addon:CheckSettings()
	if self.db.profile.minimapButton.hide then
		self.minimapButton:Hide("HandyNotes_NPCs")
	else
		self.minimapButton:Show("HandyNotes_NPCs")
	end
	if self.db.profile.mapButton then
		self.button:Show()
	else
		self.button:Hide()
	end
	AltRecipes:Toggle()
end

local xB = 0
local yB = 0
function Addon:DragStart(frame, button) -- Copied from BartrubySummonPet, button seems to jump a little when done moving; FIX ME
 if (button == "LeftButton" and IsShiftKeyDown() and not frame.isMoving) then
  frame.isMoving = true
  frame:StartMoving()
  local _, _, _, x, y = frame:GetPoint()
  --print('Start', point, x, y)
  xB = x
  yB = y
 end
end

function Addon:DragStop(frame, button)
 if (frame.isMoving == true) then
  frame.isMoving = false

  local _, _, _, x, y = frame:GetPoint()
  frame:StopMovingOrSizing()

  local xDelta = x - xB
  local yDelta = y - yB
  --print('End', point, x, y, xDelta, yDelta)

  db.button.x = xDelta + db.button.x
  db.button.y = yDelta + db.button.y
  self.button:ClearAllPoints()
  self.button:SetPoint("TOPRIGHT", WorldMapFrame, "TOPRIGHT", db.button.x, db.button.y)
 end
end
