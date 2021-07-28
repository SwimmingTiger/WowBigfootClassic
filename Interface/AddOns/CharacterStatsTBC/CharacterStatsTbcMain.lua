-- Access the namespace
local _, core = ...;

local CharacterStatsTbcFrame = CreateFrame("Frame");
CharacterStatsTbcFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
CharacterStatsTbcFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
CharacterStatsTbcFrame:RegisterEvent("UNIT_AURA");
CharacterStatsTbcFrame:RegisterEvent("PLAYER_DAMAGE_DONE_MODS");
CharacterStatsTbcFrame:RegisterEvent("SKILL_LINES_CHANGED");
CharacterStatsTbcFrame:RegisterEvent("UPDATE_SHAPESHIFT_FORM");
CharacterStatsTbcFrame:RegisterEvent("UNIT_DAMAGE");
CharacterStatsTbcFrame:RegisterEvent("UNIT_ATTACK_SPEED");
CharacterStatsTbcFrame:RegisterEvent("UNIT_RANGEDDAMAGE");
CharacterStatsTbcFrame:RegisterEvent("UNIT_ATTACK");
CharacterStatsTbcFrame:RegisterEvent("UNIT_RESISTANCES");
CharacterStatsTbcFrame:RegisterEvent("UNIT_STATS");
CharacterStatsTbcFrame:RegisterEvent("UNIT_MAXHEALTH");
CharacterStatsTbcFrame:RegisterEvent("UNIT_ATTACK_POWER");
CharacterStatsTbcFrame:RegisterEvent("UNIT_RANGED_ATTACK_POWER");
CharacterStatsTbcFrame:RegisterEvent("COMBAT_RATING_UPDATE");
CharacterStatsTbcFrame:RegisterEvent("GROUP_ROSTER_UPDATE");

CharacterStatsTbcFrame:SetScript("OnEvent",
    function(self, event, ...)

        local args = {...};

        if event == "VARIABLES_LOADED" then
            core.UIConfig:UpdateStats();
            core.UIConfig:UpdateSideStats();
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
                event == "COMBAT_RATING_UPDATE" or
                event == "GROUP_ROSTER_UPDATE") then
                self:SetScript("OnUpdate", CSC_QueuedUpdate);
            end
        end
    end)

function CSC_QueuedUpdate(self)
    self:SetScript("OnUpdate", nil);
    
    if core.UIConfig.CharacterStatsPanel:IsVisible() then
        core.UIConfig:UpdateStats();
    end

    core.UIConfig:UpdateSideStats();
end

-- Exposing global functions for showing/hiding the stats panel. For compatibility with other addons
function CSC_HideStatsPanel()
    core.UIConfig.CharacterStatsPanel:Hide();
    core.UIConfig:SetStatsPanelVisibile(false);
end

function CSC_ShowStatsPanel()
    core.UIConfig.CharacterStatsPanel:Show();
    core.UIConfig:UpdateStats();
    core.UIConfig:UpdateSideStats();
    core.UIConfig:SetStatsPanelVisibile(true);
end