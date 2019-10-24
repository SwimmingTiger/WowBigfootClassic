-- Access the namespace
local _, core = ...;

local characterStatsClassicEventFrame = CreateFrame("Frame");
characterStatsClassicEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
characterStatsClassicEventFrame:RegisterEvent("UNIT_MODEL_CHANGED");
characterStatsClassicEventFrame:RegisterEvent("UNIT_LEVEL");
characterStatsClassicEventFrame:RegisterEvent("UNIT_RESISTANCES");
characterStatsClassicEventFrame:RegisterEvent("UNIT_STATS");
characterStatsClassicEventFrame:RegisterEvent("UNIT_DAMAGE");
characterStatsClassicEventFrame:RegisterEvent("UNIT_RANGEDDAMAGE");
characterStatsClassicEventFrame:RegisterEvent("PLAYER_DAMAGE_DONE_MODS");
characterStatsClassicEventFrame:RegisterEvent("UNIT_ATTACK_SPEED");
characterStatsClassicEventFrame:RegisterEvent("UNIT_ATTACK_POWER");
characterStatsClassicEventFrame:RegisterEvent("UNIT_RANGED_ATTACK_POWER");
characterStatsClassicEventFrame:RegisterEvent("UNIT_ATTACK");
characterStatsClassicEventFrame:RegisterEvent("PLAYER_GUILD_UPDATE");
characterStatsClassicEventFrame:RegisterEvent("SKILL_LINES_CHANGED");

characterStatsClassicEventFrame:SetScript("OnEvent",
    function(self, event, ...)
        core.UIConfig:UpdateStats();
    end)