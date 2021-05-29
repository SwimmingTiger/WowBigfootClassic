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
        icon_scale_portal = 1.5,
        icon_alpha_portal = 1.0,
        icon_scale_boat = 1.5,
        icon_alpha_boat = 1.0,
        icon_scale_zeppelin = 1.5,
        icon_alpha_zeppelin = 1.0,
        icon_scale_tram = 1.5,
        icon_alpha_tram = 1.0,

        show_portal = true,
        show_tram = true,
        show_boat = true,
        show_aboat = true,
        show_zeppelin = true,
        show_hzeppelin = true,
        show_note = true,
        easy_waypoint = true,

        force_nodes = false,
        show_prints = false,
    },
    global = {
        dev = false,
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
local left, right, top, bottom = GetObjectIconTextureCoords("4772") --MagePortalAlliance
local left2, right2, top2, bottom2 = GetObjectIconTextureCoords("4773") --MagePortalHorde

constants.icon = {
    portal = {
        icon = [[Interface\MINIMAP\OBJECTICONSATLAS]],
        tCoordLeft = left,
        tCoordRight = right,
        tCoordTop = top,
        tCoordBottom = bottom,
    },
    boat            = "Interface\\AddOns\\HandyNotes_TravelGuide (BCC)\\icons\\boat",
    aboat           = "Interface\\AddOns\\HandyNotes_TravelGuide (BCC)\\icons\\boat_alliance",
    tram            = "Interface\\AddOns\\HandyNotes_TravelGuide (BCC)\\icons\\tram",
    zeppelin        = "Interface\\AddOns\\HandyNotes_TravelGuide (BCC)\\icons\\zeppelin",
    hzeppelin       = "Interface\\AddOns\\HandyNotes_TravelGuide (BCC)\\icons\\zeppelin_horde",
}