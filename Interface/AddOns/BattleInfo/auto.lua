local _, ADDONSELF = ...
local L = ADDONSELF.L
local RegEvent = ADDONSELF.regevent
local RegisterKeyChangedCallback = ADDONSELF.RegisterKeyChangedCallback 


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

RegEvent("ADDON_LOADED", function()
    WorldStateScoreFrameLeaveButton:HookScript("OnUpdate", function()
        if timetoleave == 0 then
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
