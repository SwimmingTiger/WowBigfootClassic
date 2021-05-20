----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------

local FOLDER_NAME, private = ...

local constants = {}
private.constants = constants

----------------------------------------------------------------------------------------------------
----------------------------------------------DEFAULTS----------------------------------------------
----------------------------------------------------------------------------------------------------

constants.defaults = {
    profile = {
        icon_scale_boat = 1.5,
        icon_alpha_boat = 1.0,
        icon_scale_zeppelin = 1.5,
        icon_alpha_zeppelin = 1.0,
        icon_scale_deeprun_tram = 1.5,
        icon_alpha_deeprun_tram = 1.0,

        show_tram = true,
        show_boat = true,
        show_aboat = true,
        show_zepplein = true,
        show_hzeppelin = true,
        show_note = true,
        easy_waypoint = true,
    
        dev = false,
        force_nodes = false,
        show_prints = false,
    },
    char = {
        hidden = {
            ['*'] = {},
        },
    },
}

----------------------------------------------------------------------------------------------------
------------------------------------------------ICONS-----------------------------------------------
----------------------------------------------------------------------------------------------------

constants.icon_texture = {
    boat            = "Interface\\AddOns\\HandyNotes_TravelGuide (Classic)\\icons\\boat",
    aboat           = "Interface\\AddOns\\HandyNotes_TravelGuide (Classic)\\icons\\boat_alliance",
    tram            = "Interface\\AddOns\\HandyNotes_TravelGuide (Classic)\\icons\\tram",
    zeppelin        = "Interface\\AddOns\\HandyNotes_TravelGuide (Classic)\\icons\\zeppelin",
    hzeppelin       = "Interface\\AddOns\\HandyNotes_TravelGuide (Classic)\\icons\\zeppelin_horde",
}