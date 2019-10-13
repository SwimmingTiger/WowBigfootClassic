-- File: FasterLooting.lua
-- Name: FasterLooting
-- Author: cannon
-- Description: Auto loots all items without the delay currently in Classic
-- Version: 1.1.1

-- Time delay
local delay = 0
local DEBOUNCE_INTERVAL = 0.3


-- Fast loot function
function FastLoot()
    if GetTime() - delay >= DEBOUNCE_INTERVAL then
        delay = GetTime()
        if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
            for i = GetNumLootItems(), 1, -1 do
                LootSlot(i)
            end
            delay = GetTime()
        end
    end
end

-- event frame
local faster = CreateFrame("Frame")
faster:RegisterEvent("LOOT_READY")
faster:SetScript("OnEvent", FastLoot)