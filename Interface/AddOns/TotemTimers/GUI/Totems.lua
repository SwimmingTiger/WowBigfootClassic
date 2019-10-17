-- Copyright © 2008 - 2012 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.

if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers_GUI", true)

local Elementss = {
	[EARTH_TOTEM_SLOT] = "earth",
	[FIRE_TOTEM_SLOT] = "fire",
	[WATER_TOTEM_SLOT] = "water",
	[AIR_TOTEM_SLOT] = "air",
}

TotemTimers.options.args.totems = {
    type = "group",
    name = "Totems",
    args = {
        [tostring(EARTH_TOTEM_SLOT)] = {
            order = 0,
            type = "group",
            name = L["Earth"],
            args = {
            },
        },  
        [tostring(FIRE_TOTEM_SLOT)] = {
            order = 1,
            type = "group",
            name = L["Fire"],
            args = {
            },
        },  
        [tostring(WATER_TOTEM_SLOT)] = {
            order = 2,
            type = "group",
            name = L["Water"],
            args = {
            },
        },  
        [tostring(AIR_TOTEM_SLOT)] = {
            order = 3,
            type = "group",
            name = L["Air"],
            args = {
            },
        },  
    },
}

for k,v in pairs(TotemData) do
    TotemTimers.options.args.totems.args[tostring(v.element)].args[tostring(k)] = {
        type="group",
        inline=true,
        name=TotemTimers.SpellNames[k],
        args={
            enable = {
                order = 0,
                type = "toggle",
                name = L["Enable"],
                set = function(info, val) TotemTimers.ActiveProfile.HiddenTotems[k] = not val;
                    TotemTimers.SetCastButtonSpells()
                end,
                get = function(info) return not TotemTimers.ActiveProfile.HiddenTotems[k] end,
            }, 
        },
    }
end

local ACD = LibStub("AceConfigDialog-3.0")
local frame = ACD:AddToBlizOptions("TotemTimers", "Totems", "TotemTimers", "totems")
frame:SetScript("OnEvent", function(self) InterfaceOptionsFrame:Hide() end)
frame:HookScript("OnShow", function(self) if InCombatLockdown() then InterfaceOptionsFrame:Hide() end TotemTimers.LastGUIPanel = self end)
frame:RegisterEvent("PLAYER_REGEN_DISABLED")