-- Access the namespace
local _, core = ...;

local characterStatsClassicEventFrame = CreateFrame("Frame");
characterStatsClassicEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
characterStatsClassicEventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
characterStatsClassicEventFrame:RegisterEvent("UNIT_AURA");
characterStatsClassicEventFrame:RegisterEvent("PLAYER_DAMAGE_DONE_MODS");
characterStatsClassicEventFrame:RegisterEvent("SKILL_LINES_CHANGED");
characterStatsClassicEventFrame:RegisterEvent("UPDATE_SHAPESHIFT_FORM");

characterStatsClassicEventFrame:SetScript("OnEvent",
    function(self, event, ...)
        local args = {...};
        if args[1] == "player" then
            C_Timer.After(0.5, function ()
                core.UIConfig:UpdateStats();
            end)
        elseif event == "PLAYER_EQUIPMENT_CHANGED" then
            C_Timer.After(0.5, function ()
                core.UIConfig:UpdateStats();
            end)
        end
    end)