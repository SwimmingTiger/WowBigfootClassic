local _, ADDONSELF = ...
local L = ADDONSELF.L
local RegEvent = ADDONSELF.regevent
local RegisterKeyChangedCallback = ADDONSELF.RegisterKeyChangedCallback 
local BattleZoneHelper = ADDONSELF.BattleZoneHelper

local autoleavetime = 120

RegisterKeyChangedCallback("auto_leave_bg_time", function(v)
    autoleavetime = v
end)

local timetoleave = 0
RegEvent("UPDATE_BATTLEFIELD_STATUS", function()
    if GetBattlefieldWinner() then
        timetoleave = time() + autoleavetime
    end
end)

RegEvent("PLAYER_ENTERING_WORLD", function()
    timetoleave = 0
end)

local function AnyPennyLeft()
    if not BattleZoneHelper:IsInAlterac() then
        return false
    end

    local data = BattleZoneHelper:GetAlteracPOI()

    return (data[BattleZoneHelper.POI_HORDE_TOWER_HALF] or 0) > 0 or
           (data[BattleZoneHelper.POI_ALLIANCE_TOWER_HALF] or 0) > 0 

end

RegEvent("ADDON_LOADED", function()
    WorldStateScoreFrameLeaveButton:HookScript("OnUpdate", function()
        if timetoleave == 0 then
            return
        end

        if AnyPennyLeft() then
            ADDONSELF.Print(L["Wait for Bunker/Tower to be destoryed, stop auto leaving"])
            timetoleave = 0
            return
        end

        local left = math.max(0, timetoleave - time())

        if left == 0 then
            timetoleave = 0
            LeaveBattlefield()
        end

        WorldStateScoreFrameLeaveButton:SetText(LEAVE_BATTLEGROUND .. GREEN_FONT_COLOR:WrapTextInColorCode("(" .. left .. ")"))

    end)
end)
