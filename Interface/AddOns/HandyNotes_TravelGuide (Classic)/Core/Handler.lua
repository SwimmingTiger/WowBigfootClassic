----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------

local FOLDER_NAME, private = ...

local addon = LibStub("AceAddon-3.0"):NewAddon(FOLDER_NAME, "AceEvent-3.0")
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local AceDB = LibStub("AceDB-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(FOLDER_NAME)
private.locale = L

addon.constants = private.constants

_G.HandyNotes_TravelGuide = addon

----------------------------------------------------------------------------------------------------
------------------------------------------------ICON------------------------------------------------
----------------------------------------------------------------------------------------------------

local function work_out_texture(point)
    local icon_key

    if (point.boat) then icon_key = "boat" end
    if (point.aboat) then icon_key = "aboat" end
    if (point.zeppelin) then icon_key = "zeppelin" end
    if (point.hzeppelin) then icon_key = "hzeppelin" end
    if (point.tram) then icon_key = "tram" end
    if (point.flightmaster) then icon_key = "flightmaster" end

    if (icon_key and private.constants.icon_texture[icon_key]) then
        return private.constants.icon_texture[icon_key]
    elseif (point.type and private.constants.icon_texture[point.type]) then
        return private.constants.icon_texture[point.type]
--    use the icon specified in point data
    elseif (point.icon) then
        return point.icon
    else
        return private.constants.defaultIcon
    end
end

local get_point_info = function(point)
    local icon
    if point then
        local label = point.label or point.label2 or UNKNOWN
            icon = work_out_texture(point)
        return label, label2, icon, quest, lvl, point.scale, point.alpha, point.zeppelin, point.hzeppelin, point.boat, point.aboat, point.tram
    end
end

local get_point_info_by_coord = function(uMapID, coord)
    return get_point_info(private.DB.points[uMapID] and private.DB.points[uMapID][coord])
end

----------------------------------------------------------------------------------------------------
----------------------------------------------TOOLTIP-----------------------------------------------
----------------------------------------------------------------------------------------------------

local function handle_tooltip(tooltip, point)
    if point then
        if (point.label) then
            tooltip:AddLine(point.label)
        end
        if (point.label1 and profile.show_note) then
            tooltip:AddDoubleLine(point.label1)
        else
            tooltip:AddLine(point.label2)
        end
        if (point.note and profile.show_note) then
            tooltip:AddLine("("..point.note..")")
        end
    else
        tooltip:SetText(UNKNOWN)
    end
    tooltip:Show()
end

local handle_tooltip_by_coord = function(tooltip, uMapID, coord)
    return handle_tooltip(tooltip, private.DB.points[uMapID] and private.DB.points[uMapID][coord])
end

----------------------------------------------------------------------------------------------------
-------------------------------------------PluginHandler--------------------------------------------
----------------------------------------------------------------------------------------------------

local PluginHandler = {}
local info = {}

function PluginHandler:OnEnter(uMapID, coord)
    local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
    if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end
    handle_tooltip_by_coord(tooltip, uMapID, coord)
end

function PluginHandler:OnLeave(uMapID, coord)
    if self:GetParent() == WorldMapButton then
        WorldMapTooltip:Hide()
    else
        GameTooltip:Hide()
    end
end

local function hideNode(button, uMapID, coord)
    private.hidden[uMapID][coord] = true
    addon:Refresh()
end

local function closeAllDropdowns()
    CloseDropDownMenus(1)
end

local function addTomTomWaypoint(button, uMapID, coord)
    if TomTom then
        local x, y = HandyNotes:getXY(coord)
        TomTom:AddWaypoint(uMapID, x, y, {
            title = get_point_info_by_coord(uMapID, coord),
            persistent = nil,
            minimap = true,
            world = true
        })
    end
end

--------------------------------------------CONTEXT MENU--------------------------------------------

do
    local currentMapID = nil
    local currentCoord = nil
    local function generateMenu(button, level)
        if (not level) then return end
        if (level == 1) then
--      local spacer = {text='', disabled=true, notClickable=true, notCheckable=true}

            -- Create the title of the menu
            info = UIDropDownMenu_CreateInfo()
            info.isTitle = true
            info.text = L["handler_context_menu_addon_name"]
            info.notCheckable = true
            UIDropDownMenu_AddButton(info, level)

--            UIDropDownMenu_AddButton(spacer, level)

            if TomTom and not profile.easy_waypoint then
                -- Waypoint menu item
                info = UIDropDownMenu_CreateInfo()
                info.text = L["handler_context_menu_add_tomtom"]
                info.notCheckable = true
                info.func = addTomTomWaypoint
                info.arg1 = currentMapID
                info.arg2 = currentCoord
                UIDropDownMenu_AddButton(info, level)
            end

            -- Hide menu item
            info = UIDropDownMenu_CreateInfo()
            info.text         = L["handler_context_menu_hide_node"]
            info.notCheckable = true
            info.func         = hideNode
            info.arg1         = currentMapID
            info.arg2         = currentCoord
            UIDropDownMenu_AddButton(info, level)

--          UIDropDownMenu_AddButton(spacer, level)

            -- Close menu item
            info = UIDropDownMenu_CreateInfo()
            info.text         = CLOSE
            info.func         = closeAllDropdowns
            info.notCheckable = true
            UIDropDownMenu_AddButton(info, level)
        end
    end

    local HL_Dropdown = CreateFrame("Frame", FOLDER_NAME.."DropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function PluginHandler:OnClick(button, down, uMapID, coord)
        if ((down or button ~= "RightButton") and profile.easy_waypoint and TomTom) then
            return
        end
        if ((button == "RightButton" and not down) and (not profile.easy_waypoint or not TomTom)) then
            currentMapID = uMapID
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        end
        if (IsControlKeyDown() and profile.easy_waypoint and TomTom) then
            currentMapID = uMapID
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        else
        if profile.easy_waypoint and TomTom then
            addTomTomWaypoint(button, uMapID, coord)
        end
        end
    end
end

do

local currentMapID = nil
    local function iter(t, prestate)
        if not t then return nil end
        local state, value = next(t, prestate)
        while state do 
            if value and private:ShouldShow(state, value, currentMapID) then
                local label, label2, icon, quest, lvl, scale, alpha, zeppelin, hzeppelin, boat, aboat, tram = get_point_info(value)
                if boat or aboat then
                    scale = (scale or 1) * (icon and icon.scale_boat or 1) * profile.icon_scale_boat
                    alpha = (alpha or 1) * (icon and icon.alpha_boat or 1) * profile.icon_alpha_boat
                elseif zeppelin or hzeppelin then
                    scale = (scale or 1) * (icon and icon.scale_zeppelin or 1) * profile.icon_scale_zeppelin
                    alpha = (alpha or 1) * (icon and icon.alpha_zeppelin or 1) * profile.icon_alpha_zeppelin
                elseif tram then
                    scale = (scale or 1) * (icon and icon.scale_others or 1) * profile.icon_scale_deeprun_tram
                    alpha = (alpha or 1) * (icon and icon.alpha_others or 1) * profile.icon_alpha_deeprun_tram
                end
                return state, nil, icon, scale, alpha
            end
            state, value = next(t, state)
        end
        return nil, nil, nil, nil, nil, nil
    end
    function PluginHandler:GetNodes2(uMapID, minimap)
        currentMapID = uMapID
        return iter, private.DB.points[uMapID], nil
    end
    function private:ShouldShow(coord, point, currentMapID)
        if (private.hidden[currentMapID] and private.hidden[currentMapID][coord]) then
            return false
        end
        -- this will check if any node is for specific class
        if (point.class and point.class ~= select(2, UnitClass("player")) and not private.db.force_nodes) then
            return false
        end
        -- this will check if any node is for specific faction
        if (point.faction and point.faction ~= select(1, UnitFactionGroup("player")) and not private.db.force_nodes) then
            return false
        end

        if (point.tram and not private.db.show_tram) then return false; end
        if (point.boat and not private.db.show_boat) then return false; end
        if (point.aboat and not private.db.show_aboat) then return false; end
        if (point.zeppelin and not private.db.show_zeppelin) then return false; end
        if (point.hzeppelin and not private.db.show_hzeppelin) then return false; end
        return true
    end
end

---------------------------------------------------------------------------------------------------
----------------------------------------------REGISTER---------------------------------------------
---------------------------------------------------------------------------------------------------

function addon:OnInitialize()
    self.db = AceDB:New("HandyNotes_TravelGuideClassicDB", private.constants.defaults)

    profile = self.db.profile
    private.db = profile
    private.hidden = self.db.char.hidden

    if private.db.dev then
        private.devmode()
    end

    -- Initialize database with HandyNotes
    HandyNotes:RegisterPluginDB(addon.pluginName, PluginHandler, private.config.options)
end

function addon:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", addon.pluginName)
end

function addon:OnEnable()
end

----------------------------------------------EVENTS-----------------------------------------------

local frame, events = CreateFrame("Frame"), {};
function events:ZONE_CHANGED(...)
    addon:Refresh()

    if private.db.dev and private.db.show_prints then
        print(addon.pluginName..": refreshed after ZONE_CHANGED")
    end
end

function events:ZONE_CHANGED_INDOORS(...)
    addon:Refresh()

    if private.db.dev and private.db.show_prints then
        print(addon.pluginName..": refreshed after ZONE_CHANGED_INDOORS")
    end
end

function events:QUEST_FINISHED(...)
    addon:Refresh()

    if private.db.dev and private.db.show_prints then
        print(addon.pluginName..": refreshed after QUEST_FINISHED")
    end
end

frame:SetScript("OnEvent", function(self, event, ...)
 events[event](self, ...); -- call one of the functions above
end);

for k, v in pairs(events) do
 frame:RegisterEvent(k); -- Register all events for which handlers have been defined
end