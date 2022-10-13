local name, data = ...
local Main = LibStub("AceAddon-3.0"):GetAddon("HandyNotes_NPCs (Classic)")
local Addon = Main:NewModule("Options", "AceConsole-3.0")
local LSM = LibStub("LibSharedMedia-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_NPCs (Classic)")


function Addon:OnInitialize()
	local Search = Main:GetModule("Search")
	local RecipeTracker = Main:GetModule("AltRecipes")
	self.db = Main.db
	local options = {
		type = "group",
		name = "HandyNotes_NPCs",
		desc = L["Locations of various npcs"],
		get = function(info) return self.db.profile[info[#info]] end,
		set = function(info, v) self.db.profile[info[#info]] = v Main:CheckSettings() HandyNotes:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_NPCs") end,
		args = {
			generalOptions = {
				type = "group",
				name = L["General"],
				order = 1,
				args = {
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
						descStyle = "inline",
						width = "full",
						order = 1.1,
					},
					showVendorData = {
						type = "toggle",
						name = L["Advanced Vendor Tooltip"],
						desc = L["Show items sold by vendor in tooltip"],
						descStyle = "inline",
						width = "full",
						order = 1.101,
					},
					mapButton = {
						type = "toggle",
						name = L["Show Map Button"],
						order = 1.01,
					},
					minimapButton = {
						type = "toggle",
						name = L["Show Minimap Button"],
						order = 1.02,
						get = function() return not self.db.profile.minimapButton.hide end,
						set = function(info, value) self.db.profile.minimapButton.hide = not value Main:CheckSettings() end,
					},
					showAltRecipes = {
						type = "toggle",
						name = L["Show Alt Recipes"],
						desc = L["Show which alts can learn a recipe in the item's tooltip"],
						descStyle = "inline",
						order = 2,
						width = "full",
					},
					resetMapButton = {
						name = L["Reset Map Button"],
						desc = L["Places button back in default position"],
						type = "execute",
						order = 10,
						func = function() self.db.profile.button.x = -40 self.db.profile.button.y = -30 Main.button:ClearAllPoints() Main.button:SetPoint("TOPRIGHT", WorldMapFrame, "TOPRIGHT", self.db.profile.button.x, self.db.profile.button.y)end,
					},
					altList = {
						name = L["Remove Alt from Recipe Tracker"],
						order = 30,
						width = "full",
						type = "select",
						values = function() local alts = { } for k,v in pairs(RecipeTracker.db.realm) do alts[k] = k end return alts end,
						set = function(info, value) RecipeTracker.db.realm[value] = nil self:Print("Deleted", value) end,
					},
				},
			},
			iconGroup = {
				type = "group",
				name = L["Icon"],
				order = 2,
				args = {
					iconSettingsHeader = {
						type = "header",
						name = L["These settings control the look and feel of the icon."],
						order = 1,
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
				},
			},
			showOptions = {
				type = "group",
				name = L["Show NPCs"],
				order = 3,
				args = {
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
					showMountTrainers = {
						type = "toggle",
						name = L["Show Mount Trainers"],
						order = 3.71,
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
				},
			},
			showFlightMastersHeader = {
				name = L["Flight Masters"],
				type = "group",
				order = 4,
				args = {
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
				},
			},
			showVendorsHeader = {
				name = L["Show Vendors"],
				type = "group",
				order = 5,
				args = {
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
				},
			},
			searchHeader = {
				name = L["Search"],
				type = "group",
				order = 6,
				args = {
					searchScale = {
						type = "range",
						name = L["Search Scale"],
						desc = L["The scale of the search window"],
						min = 0.5, max = 3, step = 0.1,
						order = 5.6,
						get = function() return self.db.profile.search.scaleFactor end,
						set = function(info, value) self.db.profile.search.scaleFactor = value Search:UpdateSettings() end,
					},
					searchSearchFont = {
						name = L["Searchbar Font"],
						order = 5.1,
						type = "select",
						values = LSM:HashTable("font"),
						dialogControl = "LSM30_Font",
						get = function(info) return self.db.profile.search.search.font end,
						set = function(info, value) self.db.profile.search.search.font = value Search:UpdateSettings() end,
					},
					searchSearchFontsize = {
						name = L["Searchbar Fontsize"],
						order = 5.11,
						type = "range",
						min = 1, max = 72, step = 1,
						get = function(info) return self.db.profile.search.search.fontsize end,
						set = function(info, value) self.db.profile.search.search.fontsize = value; Search:UpdateSettings() end,
					},
					searchHeaderFont = {
						name = L["Header Font"],
						order = 5.2,
						type = "select",
						values = LSM:HashTable("font"),
						dialogControl = "LSM30_Font",
						get = function(info) return self.db.profile.search.header.font end,
						set = function(info, value) self.db.profile.search.header.font = value Search:UpdateSettings() end,
					},
					searchHeaderFontsize = {
						name = L["Header Fontsize"],
						order = 5.21,
						type = "range",
						min = 1, max = 72, step = 1,
						get = function(info) return self.db.profile.search.header.fontsize end,
						set = function(info, value) self.db.profile.search.header.fontsize = value; Search:UpdateSettings() end,
					},
					searchListFont = {
						name = L["List Font"],
						order = 5.3,
						type = "select",
						values = LSM:HashTable("font"),
						dialogControl = "LSM30_Font",
						get = function(info) return self.db.profile.search.list.font end,
						set = function(info, value) self.db.profile.search.list.font = value Search:UpdateSettings() end,
					},
					searchListFontsize = {
						name = L["List Fontsize"],
						order = 5.31,
						type = "range",
						min = 1, max = 72, step = 1,
						get = function(info) return self.db.profile.search.list.fontsize end,
						set = function(info, value) self.db.profile.search.list.fontsize = value; Search:UpdateSettings() end,
					},
					searchFooterFont = {
						name = L["Footer Font"],
						order = 5.4,
						type = "select",
						values = LSM:HashTable("font"),
						dialogControl = "LSM30_Font",
						get = function(info) return self.db.profile.search.footer.font end,
						set = function(info, value) self.db.profile.search.footer.font = value Search:UpdateSettings() end,
					},
					searchFooterFontsize = {
						name = L["Footer Fontsize"],
						order = 5.41,
						type = "range",
						min = 1, max = 72, step = 1,
						get = function(info) return self.db.profile.search.footer.fontsize end,
						set = function(info, value) self.db.profile.search.footer.fontsize = value; Search:UpdateSettings() end,
					},
				},
			},
		},
	}

 LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("HandyNotes_NPCs (Classic)", options)
end

function Addon:ShowOptions()
	LibStub("AceConfigDialog-3.0"):Open("HandyNotes_NPCs (Classic)")
end
