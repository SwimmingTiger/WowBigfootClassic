local _G = getfenv(0)
local pairs = _G.pairs
local FOLDER_NAME, private = ...
local LibStub = _G.LibStub;
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name);

local config = {}
private.config = config

config.options = {
	type = "group",
	name = addon.pluginName,
	desc = addon.description,
	get = function(info) return private.db[info[#info]] end,
	set = function(info, v)
		private.db[info[#info]] = v
		addon:SendMessage("HandyNotes_NotifyUpdate", addon.pluginName)
	end,
	args = {
		icon = {
			type = "group",
			name = L["Icon settings"],
			inline = true,
			order = 10,
			args = {
				desc = {
					name = L["These settings control the look and feel of the icon."],
					type = "description",
					order = 0,
				},
				icon_scale = {
					type = "range",
					name = L["Icon Scale"],
					desc = L["The scale of the icons"],
					min = 0.25, max = 2, step = 0.01,
					order = 20,
				},
				icon_alpha = {
					type = "range",
					name = L["Icon Alpha"],
					desc = L["The alpha transparency of the icons"],
					min = 0, max = 1, step = 0.01,
					order = 30,
				},
			},
		},
		display = {
			type = "group",
			name = L["What to display?"],
			inline = true,
			order = 20,
			args = {
				desc = {
					name = L["These settings control what type of icons to be displayed."],
					type = "description",
					order = 0,
				},
				show_boat = {
					type = "toggle",
					name = L["Boat"],
					desc = L["Show the boat locations."],
					order = 20,
				},
				show_aboat = {
					type = "toggle",
					name = L["Alliance Boat"],
					desc = L["Show the Alliance boat locations."],
					order = 22,
				},
				show_zepplin = {
					type = "toggle",
					name = L["Zeppelin"],
					desc = L["Show the Zeppelin locations."],
					order = 23,
				},	
				show_hzepplin = {
					type = "toggle",
					name = L["Horde Zeppelin"],
					desc = L["Show the Horde Zeppelin locations."],
					order = 24,
				},
--[[
				show_portal = {
					type = "toggle",
					name = L["Portal"],
					desc = L["Show the portal locations."],
					order = 25,
				},
]]--
				show_tram = {
					type = "toggle",
					name = L["Deeprun Tram"],
					desc = L["Show the Deeprun Tram locations in Stormwind and Ironforge."],
					order = 26,
				},
				show_note = {
					type = "toggle",
					name = L["Note"],
					desc = L["Show the node's additional notes when it's available."],
					order = 28,
				},
				easy_waypoint = {
					type = "toggle",
					name = L["Easy waypoints"],
					desc = L["easy_waypoints_desc"],
					order = 30,
				},
			},
		},
		plugin_config = {
			type = "group",
			name = L["AddOn Settings"],
			inline = true,
			order = 30,
			args = {
--[[				query_server = {
					type = "toggle",
					name = L["Query from server"],
					desc = L["Send query request to server to lookup localized name. May be a little bit slower for the first time lookup but would be very fast once the name is found and cached."],
					order = 10,
				},
]]--				
				unhide = {
					type = "execute",
					name = L["Reset hidden nodes"],
					desc = L["Show all nodes that you manually hid by right-clicking on them and choosing \"hide\"."],
					func = function()
						for map,coords in pairs(private.hidden) do
							wipe(coords)
						end
						addon:Refresh()
					end,
					order = 50,
				},
			},
		},
	},
}