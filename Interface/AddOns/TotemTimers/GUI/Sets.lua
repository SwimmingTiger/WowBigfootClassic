-- Copyright © 2008 - 2012 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.

if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers_GUI", true)


TotemTimers.options.args.sets = {
    type = "group",
    name = "Sets",
    args = {},
}


local ACD = LibStub("AceConfigDialog-3.0")
local ACR =	LibStub("AceConfigRegistry-3.0")

local frame = ACD:AddToBlizOptions("TotemTimers", "Sets", "TotemTimers", "sets")

frame:SetScript("OnEvent", function(self) InterfaceOptionsFrame:Hide() end)

local StripRank = TotemTimers.StripRank

frame:HookScript("OnShow", function(self)
    if InCombatLockdown() then InterfaceOptionsFrame:Hide() end
    TotemTimers.LastGUIPanel = self
    TotemTimers.options.args.sets.args = {}

    local args = TotemTimers.options.args.sets.args

    if #TotemTimers.ActiveProfile.TotemSets == 0 then
        args.desc = {
            type="description",
            name="You did not create any totem sets yet."
        }
    else
        for i = 1, #TotemTimers.ActiveProfile.TotemSets do
            local set = TotemTimers.ActiveProfile.TotemSets[i]

            table.insert(args,  {
                type = "header",
                order = i * 10,
                name = not set.name and "Set "..i or set.name
            })

            local totems = {}
            for element = 1,4 do
                totems[element] = TotemTimers.ElementColors[element]:WrapTextInColorCode(StripRank(set[element]))
            end

            table.insert(args, {
                type = "description",
                order = i * 11,
                name = table.concat(totems, ", "),
            })

            table.insert(args, {
                type = "input",
                name = L["Rename"],
                order = i * 12,
                set = function(self, value)
                    set.name = value

                    ACR:NotifyChange("TotemTimers")
                    InterfaceOptionsFrame_OpenToCategory(frame)
                end,
            })

            table.insert(args, {
                type = "execute",
                name = L["Delete"],
                order = i * 13,
                func = function()
                	local popup = StaticPopup_Show("TOTEMTIMERS_DELETESET", not set.name and i or set.name)
                	popup.data = i
                end,
            })
        end
    end

    ACR:NotifyChange("TotemTimers")

end)
frame:RegisterEvent("PLAYER_REGEN_DISABLED")

local deleteOnAccept = StaticPopupDialogs["TOTEMTIMERS_DELETESET"].OnAccept
StaticPopupDialogs["TOTEMTIMERS_DELETESET"].OnAccept = function(self, nr)
    deleteOnAccept(self, nr)
    if frame:IsVisible() then
        ACR:NotifyChange("TotemTimers")
        InterfaceOptionsFrame_OpenToCategory(frame)
    end
end
