-- Copyright © 2008 - 2012 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.

if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local SpellNames = TotemTimers.SpellNames
local SpellIDs = TotemTimers.SpellIDs

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers_GUI", true)


TotemTimers.options.args.crowdcontrol = {
    type = "group",
    name = "crowdcontrol",
    args = {
        enable = {
            order = 0,
            type = "toggle",
            name = L["Enable"],
            set = function(info, val) TotemTimers.ActiveProfile.CrowdControlEnable = val  TotemTimers.ProcessSetting("CrowdControlEnable") end,
            get = function(info) return TotemTimers.ActiveProfile.CrowdControlEnable end,
        }, 
        hex = {
            order = 1,
            type = "toggle",
            name = SpellNames[SpellIDs.Hex],
            set = function(info, val) TotemTimers.ActiveProfile.CrowdControlHex = val  TotemTimers.ProcessSetting("CrowdControlEnable") end,
            get = function(info) return TotemTimers.ActiveProfile.CrowdControlHex end,
        }, 
        clickthrough = {
            order = 5,
            type = "toggle", 
            name = L["Clickthrough"],
            desc = L["Clickthrough Desc"],
            set = function(info, val) TotemTimers.ActiveProfile.CrowdControlClickthrough = val  TotemTimers.ProcessSetting("CrowdControlClickthrough") end,
            get = function(info) return TotemTimers.ActiveProfile.CrowdControlClickthrough end,
        },
        CrowdControlArrange = {
            order = 6,
            type = "select",
            name = L["Arrangement"],
            values ={vertical = L["vertical"], horizontal = L["horizontal"]},
            set = function(info, val) 
                TotemTimers.ActiveProfile.CrowdControlArrange = val
                TotemTimers.LayoutCrowdControl()
            end,            
            get = function(info) return TotemTimers.ActiveProfile.CrowdControlArrange end,
        },  
        cctimepos = {
            order = 9,
            type = "select",
            name = L["Timer Bar Position"],
            desc = L["Timer Bar Position Desc"],
            values = {	["LEFT"] = L["Left"], ["RIGHT"] = L["Right"], ["TOP"] = L["Top"], ["BOTTOM"] = L["Bottom"],},
            set = function(info, val)
                        TotemTimers.ActiveProfile.CrowdControlTimePos = val  TotemTimers.ProcessSetting("CrowdControlTimePos")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.CrowdControlTimePos end,
        },
        ccSize = {
            order = 11,
            type = "range",
            name = L["Button Size"],
            desc = L["Scales the timer buttons"],
            min = 16,
            max = 96,
            step = 1,
            bigStep = 2,
            set = function(info, val)
                        TotemTimers.ActiveProfile.CrowdControlSize = val  TotemTimers.ProcessSetting("CrowdControlSize")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.CrowdControlSize end,
        },
    },
}

local ACD = LibStub("AceConfigDialog-3.0")
local frame = ACD:AddToBlizOptions("TotemTimers", L["Crowd Control"], "TotemTimers", "crowdcontrol")
frame:SetScript("OnEvent", function(self) InterfaceOptionsFrame:Hide() end)
frame:HookScript("OnShow", function(self) if InCombatLockdown() then InterfaceOptionsFrame:Hide() end TotemTimers.LastGUIPanel = self end)
frame:RegisterEvent("PLAYER_REGEN_DISABLED")