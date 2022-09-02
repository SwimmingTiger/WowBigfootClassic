if select(2, UnitClass("player")) ~= "SHAMAN" then
    return
end

local Timers = XiTimers.timers

local ButtonPositions = {
    ["box"] = { { "CENTER", 0, "CENTER" }, { "LEFT", 1, "RIGHT" }, { "TOP", 2, "BOTTOM" }, { "LEFT", 1, "RIGHT" } },
    ["horizontal"] = { { "CENTER", 0, "CENTER" }, { "LEFT", 1, "RIGHT" }, { "LEFT", 1, "RIGHT" }, { "LEFT", 1, "RIGHT" } },
    ["vertical"] = { { "CENTER", 0, "CENTER" }, { "TOP", 1, "BOTTOM" }, { "TOP", 1, "BOTTOM" }, { "TOP", 1, "BOTTOM" } }
}

function TotemTimers.OrderTrackers()
    local arrange = TotemTimers.ActiveProfile.TrackerArrange
    for e = 5, 8 do
        Timers[e]:ClearAnchors()
        Timers[e].button:ClearAllPoints()
    end
    if arrange == "free" then
        for i = 5,8 do
            Timers[i].savePos = true
            local pos = TotemTimers.ActiveProfile.TimerPositions[i]
            if not pos or not pos[1] then
                pos = { "CENTER", "UIParent", "CENTER", 0, 0 }
            end
            Timers[i].button:ClearAllPoints()
            Timers[i].button:SetPoint(pos[1], pos[2], pos[3], pos[4], pos[5])
        end
    else
        local counter = 0
        local buttons = {}
        for i = 5, 8 do
            Timers[i].savePos = false
            --if Timers[i].active then
            if Timers[i].button:IsVisible() then
                counter = counter + 1
                if counter == 1 then
                    Timers[i]:SetPoint(ButtonPositions[arrange][1][1], TotemTimers_TrackerFrame, ButtonPositions[arrange][1][3])
                else
                    Timers[i]:Anchor(buttons[counter - ButtonPositions[arrange][counter][2]], ButtonPositions[arrange][counter][1])
                end
                buttons[counter] = Timers[i]
            end
        end
    end
end
