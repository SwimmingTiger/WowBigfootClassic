local _G = getfenv(0)
local FOLDER_NAME, private = ...
private.addon_name = "HandyNotes_TravelGuide (Classic)"

local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

local constants = {}
private.constants = constants

constants.defaults = {
	profile = {
		icon_scale = 1.5,
		icon_alpha = 1.0,
		query_server = false,
--		show_portal = true,
		show_tram = true,
		show_boat = true,
		show_aboat = true,
		show_zepplin = true,
		show_hzepplin = true,
		show_note = true,
		easy_waypoint = true,
	},
	char = {
		hidden = {
			['*'] = {},
		},
	},
}

constants.icon_texture = {
	boat 		= "Interface\\AddOns\\HandyNotes_TravelGuide (Classic)\\Images\\Boat",
	aboat 		= "Interface\\AddOns\\HandyNotes_TravelGuide (Classic)\\Images\\Boat_Alliance",
	tram  		= "Interface\\AddOns\\HandyNotes_TravelGuide (Classic)\\Images\\Tram",
	flightmaster = "Interface\\MINIMAP\\TRACKING\\FlightMaster",	
	zeppelin 	= "Interface\\AddOns\\HandyNotes_TravelGuide (Classic)\\Images\\Zeppelin",			
	hzeppelin 	= "Interface\\AddOns\\HandyNotes_TravelGuide (Classic)\\Images\\Zeppelin_Horde",
}