-- Access the namespace
local _, core = ...;

local characterStatsClassicEventFrame = CreateFrame("Frame");
characterStatsClassicEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
characterStatsClassicEventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
characterStatsClassicEventFrame:RegisterEvent("UNIT_AURA");
characterStatsClassicEventFrame:RegisterEvent("PLAYER_DAMAGE_DONE_MODS");
characterStatsClassicEventFrame:RegisterEvent("SKILL_LINES_CHANGED");
characterStatsClassicEventFrame:RegisterEvent("UPDATE_SHAPESHIFT_FORM");
characterStatsClassicEventFrame:RegisterEvent("UNIT_DAMAGE");
characterStatsClassicEventFrame:RegisterEvent("UNIT_ATTACK_SPEED");
characterStatsClassicEventFrame:RegisterEvent("UNIT_RANGEDDAMAGE");
characterStatsClassicEventFrame:RegisterEvent("UNIT_ATTACK");
characterStatsClassicEventFrame:RegisterEvent("UNIT_RESISTANCES");
characterStatsClassicEventFrame:RegisterEvent("UNIT_STATS");
characterStatsClassicEventFrame:RegisterEvent("UNIT_MAXHEALTH");
characterStatsClassicEventFrame:RegisterEvent("UNIT_ATTACK_POWER");
characterStatsClassicEventFrame:RegisterEvent("UNIT_RANGED_ATTACK_POWER");
characterStatsClassicEventFrame:RegisterEvent("COMBAT_RATING_UPDATE");

characterStatsClassicEventFrame:SetScript("OnEvent",
    function(self, event, ...)

        if (not core.UIConfig.CharacterStatsPanel:IsVisible()) then
            return;
        end

        local args = {...};

        if event == "VARIABLES_LOADED" then
            core.UIConfig:UpdateStats();
        end

        if args[1] == "player" then
            if ( event == "UNIT_DAMAGE" or
                event == "PLAYER_DAMAGE_DONE_MODS" or
                event == "UNIT_ATTACK_SPEED" or
                event == "UNIT_RANGEDDAMAGE" or
                event == "UNIT_ATTACK" or
                event == "UNIT_RESISTANCES" or
                event == "UNIT_STATS" or
                event == "UNIT_AURA" or
                event == "UNIT_MAXHEALTH" or
                event == "UNIT_ATTACK_POWER" or
                event == "UNIT_RANGED_ATTACK_POWER" or
                event == "SKILL_LINES_CHANGED" or
                event == "COMBAT_RATING_UPDATE") then
                self:SetScript("OnUpdate", CSC_QueuedUpdate);
            end
        end
    end)

function CSC_QueuedUpdate(self)
    self:SetScript("OnUpdate", nil);
    core.UIConfig:UpdateStats();
end

-- Exposing global functions for showing/hiding the stats panel. For compatibility with other addons
function CSC_HideStatsPanel()
    core.UIConfig.CharacterStatsPanel:Hide();
    core.UIConfig:SetStatsPanelVisibile(false);
end

function CSC_ShowStatsPanel()
    core.UIConfig.CharacterStatsPanel:Show();
    core.UIConfig:UpdateStats();
    core.UIConfig:SetStatsPanelVisibile(true);
end