-- Copyright © 2008 - 2012 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.

if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local SpellNames = TotemTimers.SpellNames
local SpellIDs = TotemTimers.SpellIDs

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers_GUI", true)


TotemTimers.options.args.trackers = {
    type = "group",
    name = "Trackers",
    args = {
        clickthrough = {
            order = 1,
            type = "toggle", 
            name = L["Clickthrough"],
            desc = L["Clickthrough Desc"],
            set = function(info, val) TotemTimers.ActiveProfile.Tracker_Clickthrough = val  TotemTimers.ProcessSetting("Tracker_Clickthrough") end,
            get = function(info) return TotemTimers.ActiveProfile.Tracker_Clickthrough end,
        },
        TrackerArrange = {
            order = 2,
            type = "select",
            name = L["Arrangement"],
            values ={vertical = L["vertical"], horizontal = L["horizontal"], free = L["loose"],},
            set = function(info, val) 
                TotemTimers.ActiveProfile.TrackerArrange = val
                TotemTimers.OrderTrackers()
                XiTimers.timers[5]:SetTimerBarPos(XiTimers.timers[5].timerBarPos, true)
            end,
            get = function(info) return TotemTimers.ActiveProfile.TrackerArrange end,
        },  
        trackertimepos = {
            order = 9,
            type = "select",
            name = L["Timer Bar Position"],
            desc = L["Timer Bar Position Desc"],
            values = {	["LEFT"] = L["Left"], ["RIGHT"] = L["Right"], ["TOP"] = L["Top"], ["BOTTOM"] = L["Bottom"],},
            set = function(info, val)
                        TotemTimers.ActiveProfile.TrackerTimePos = val  TotemTimers.ProcessSetting("TrackerTimePos")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.TrackerTimePos end,
        },
        trackerSize = {
            order = 11,
            type = "range",
            name = L["Button Size"],
            desc = L["Scales the timer buttons"],
            min = 16,
            max = 96,
            step = 1,
            bigStep = 2,
            set = function(info, val)
                        TotemTimers.ActiveProfile.TrackerSize = val  TotemTimers.ProcessSetting("TrackerSize")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.TrackerSize end,
        },
        trackerTimeHeight = {
            order = 12,
            type = "range",
            name = L["Time Size"],
            desc = L["Sets the font size of time strings"],
            min = 6,
            max = 40,
            step = 1,
            set = function(info, val)
                        TotemTimers.ActiveProfile.TrackerTimeHeight = val  TotemTimers.ProcessSetting("TrackerTimeHeight")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.TrackerTimeHeight end,
        },
        trackertimespacing = {
            order = 13,
            type = "range",
            name = L["Spacing"] ,
            desc = L["Sets the space between timer buttons"],
            min = 0,
            max = 20,
            step = 1,
            set = function(info, val)
                        TotemTimers.ActiveProfile.TrackerSpacing = val  TotemTimers.ProcessSetting("TrackerSpacing")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.TrackerSpacing end,
        },
        trackerSpacing = {
            order = 14,
            type = "range",
            name = L["Time Spacing"],
            desc = L["Sets the space between timer buttons and timer bars"],
            min = 0,
            max = 20,
            step = 1,
            set = function(info, val)
                        TotemTimers.ActiveProfile.TrackerTimeSpacing = val  TotemTimers.ProcessSetting("TrackerTimeSpacing")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.TrackerTimeSpacing end,
        },
        trackertimerBarWidth = {
            order = 15,
            type = "range",
            name = L["Timer Bar Width"],
            desc = L["Timer Bar Width Desc"],
            min = 36,
            max = 300,
            step = 4,
            set = function(info, val)
                        TotemTimers.ActiveProfile.TrackerTimerBarWidth = val  TotemTimers.ProcessSetting("TrackerTimerBarWidth")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.TrackerTimerBarWidth end,
        },
        individual = {
            name = L["Trackers"] ,
            type = "group",
            order = 30,
            args = {
                ankh = {
                    order = 1,
                    name = L["Ankh Tracker"],
                    desc = L["Ankh Tracker Desc"],
                    type = "group",
                    args = {
                        enable = {
                            order = 0,
                            type = "toggle",
                            name = L["Enable"],
                            set = function(info, val) TotemTimers.ActiveProfile.AnkhTracker = val  TotemTimers.ProcessSetting("AnkhTracker") end,
                            get = function(info) return TotemTimers.ActiveProfile.AnkhTracker end,
                        },  
                    },
                },
                shield = {
                    order = 2,
                    name = L["Shield Tracker"],
                    type = "group",
                    args = {
                        enable = {
                            order = 0,
                            type = "toggle",
                            name = L["Enable"],
                            set = function(info, val) TotemTimers.ActiveProfile.ShieldTracker = val  TotemTimers.ProcessSetting("ShieldTracker") end,
                            get = function(info) return TotemTimers.ActiveProfile.ShieldTracker end,
                        },
                        ShieldChargesOnly = {
                            order = 1,
                            type = "toggle",
                            name = L["Show Charges Only"],
                            desc = L["Shows shield charges in place of the timer"],
                            set = function(info, val) TotemTimers.ActiveProfile.ShieldChargesOnly = val  TotemTimers.ProcessSetting("ShieldChargesOnly") end,
                            get = function(info) return TotemTimers.ActiveProfile.ShieldChargesOnly end
                        }
                        --LeftButton = {
                        --    order = 2,
                        --    type = "select",
                        --    name = L["Leftclick"],
                        --    values = { [SpellNames[SpellIDs.LightningShield]] = SpellNames[SpellIDs.LightningShield],
                        --               [SpellNames[SpellIDs.WaterShield]] = SpellNames[SpellIDs.WaterShield],
                        --               [SpellNames[SpellIDs.EarthShield]] = SpellNames[SpellIDs.EarthShield],
                        --               [SpellNames[SpellIDs.TotemicCall]] = SpellNames[SpellIDs.TotemicCall],
                        --             },
                        --    set = function(info, val) TotemTimers.ActiveProfile.ShieldLeftButton = val
                        --             TotemTimers.ProcessSetting("ShieldLeftButton") end,
                        --    get = function(info) return TotemTimers.ActiveProfile.ShieldLeftButton end,
                        --},
                        --RightButton = {
                        --    order = 3,
                        --    type = "select",
                        --    name = L["Rightclick"],
                        --    values = { [SpellNames[SpellIDs.LightningShield]] = SpellNames[SpellIDs.LightningShield],
                        --               [SpellNames[SpellIDs.WaterShield]] = SpellNames[SpellIDs.WaterShield],
                        --               [SpellNames[SpellIDs.EarthShield]] = SpellNames[SpellIDs.EarthShield],
                        --               [SpellNames[SpellIDs.TotemicCall]] = SpellNames[SpellIDs.TotemicCall],
                        --             },
                        --    set = function(info, val) TotemTimers.ActiveProfile.ShieldRightButton = val
                        --             TotemTimers.ProcessSetting("ShieldRightButton") end,
                        --    get = function(info) return TotemTimers.ActiveProfile.ShieldRightButton end,
                        --},
                        --MiddleButton = {
                        --    order = 4,
                        --    type = "select",
                        --    name = L["Middle Button"],
                        --    values = { [SpellNames[SpellIDs.LightningShield]] = SpellNames[SpellIDs.LightningShield],
                        --               [SpellNames[SpellIDs.WaterShield]] = SpellNames[SpellIDs.WaterShield],
                        --               [SpellNames[SpellIDs.EarthShield]] = SpellNames[SpellIDs.EarthShield],
                        --               [SpellNames[SpellIDs.TotemicCall]] = SpellNames[SpellIDs.TotemicCall],
                        --             },
                        --    set = function(info, val) TotemTimers.ActiveProfile.ShieldMiddleButton = val
                        --             TotemTimers.ProcessSetting("ShieldMiddleButton") end,
                        --    get = function(info) return TotemTimers.ActiveProfile.ShieldMiddleButton end,
                        --},
                    },
                },                
                --earthshield = {
                --    order = 3,
                --    name = L["Earth Shield Tracker"],
                --    desc = L["EarthShieldDesc"],
                --    type = "group",
                --    args = {
                --        enable = {
                --            order = 0,
                --            type = "toggle",
                --            name = L["Enable"],
                --            set = function(info, val) TotemTimers.ActiveProfile.EarthShieldTracker = val
                --                    TotemTimers.ProcessSetting("EarthShieldTracker") end,
                --            get = function(info) return TotemTimers.ActiveProfile.EarthShieldTracker end,
                --        },
                --        LeftButton = {
                --            order = 2,
                --            type = "select",
                --            name = L["Leftclick"],
                --            desc = L["EarthShieldOptionsDesc"],
                --            values = { focus = "focus",
                --                       target = "target",
                --                       targettarget = "targettarget",
                --                       player = "player",
                --                       recast = L["esrecast"],
                --                       menu = L["ES Main Tank menu"],
                --                     },
                --            set = function(info, val) TotemTimers.ActiveProfile.EarthShieldLeftButton = val
                --                     TotemTimers.SetEarthShieldButtons() end,
                --            get = function(info) return TotemTimers.ActiveProfile.EarthShieldLeftButton end,
                --        },
                --        RightButton = {
                --            order = 3,
                --            type = "select",
                --            name = L["Rightclick"],
                --            desc = L["EarthShieldOptionsDesc"],
                --            values = { focus = "focus",
                --                       target = "target",
                --                       targettarget = "targettarget",
                --                       player = "player",
                --                       recast = L["esrecast"],
                --                       menu = L["ES Main Tank menu"],
                --                     },
                --            set = function(info, val) TotemTimers.ActiveProfile.EarthShieldRightButton = val
                --                     TotemTimers.SetEarthShieldButtons() end,
                --            get = function(info) return TotemTimers.ActiveProfile.EarthShieldRightButton end,
                --        },
                --        MiddleButton = {
                --            order = 4,
                --            type = "select",
                --            name = L["Middle Button"],
                --            desc = L["EarthShieldOptionsDesc"],
                --            values = { focus = "focus",
                --                       target = "target",
                --                       targettarget = "targettarget",
                --                       player = "player",
                --                       recast = L["esrecast"],
                --                       menu = L["ES Main Tank menu"],
                --                     },
                --            set = function(info, val) TotemTimers.ActiveProfile.EarthShieldMiddleButton = val
                --                     TotemTimers.SetEarthShieldButtons() end,
                --            get = function(info) return TotemTimers.ActiveProfile.EarthShieldMiddleButton end,
                --        },
                --        Button4 = {
                --            order = 5,
                --            type = "select",
                --            name = L["Button 4"],
                --            desc = L["EarthShieldOptionsDesc"],
                --            values = { focus = "focus",
                --                       target = "target",
                --                       targettarget = "targettarget",
                --                       player = "player",
                --                       recast = L["esrecast"],
                --                       menu = L["ES Main Tank menu"],
                --                     },
                --            set = function(info, val) TotemTimers.ActiveProfile.EarthShieldButton4 = val
                --                     TotemTimers.SetEarthShieldButtons() end,
                --            get = function(info) return TotemTimers.ActiveProfile.EarthShieldButton4 end,
                --        },
                --        targetname = {
                --            order = 10,
                --            type = "toggle",
                --            name = L["ES Target Name"],
                --            set = function(info, val) TotemTimers.ActiveProfile.EarthShieldTargetName = val
                --                    TotemTimers.ProcessSetting("EarthShieldTargetName") end,
                --            get = function(info) return TotemTimers.ActiveProfile.EarthShieldTargetName end,
                --        },
                --        chargesonly = {
                --            order = 10,
                --            type = "toggle",
                --            name = L["ES Charges only"],
                --            desc = L["ES Charges only desc"],
                --            set = function(info, val) TotemTimers.ActiveProfile.ESChargesOnly = val
                --                    TotemTimers.ProcessSetting("ESChargesOnly") end,
                --            get = function(info) return TotemTimers.ActiveProfile.ESChargesOnly end,
                --        },
                --        maintankmenu = {
                --            order = 11,
                --            type = "toggle",
                --            name = L["ES Main Tank Menu"],
                --            desc = L["ES Main Tank Desc"],
                --            set = function(info, val) TotemTimers.ActiveProfile.ESMainTankMenu = val
                --                     TotemTimers.SetEarthShieldButtons() end,
                --            get = function(info) return TotemTimers.ActiveProfile.ESMainTankMenu end,
                --        },
                --        menudirection = {
                --            order = 12,
                --            type = "select",
                --            name = L["Menu Direction"],
                --            values = function()
                --                        if TotemTimers.ActiveProfile.TrackerArrange == "horizontal" then
                --                            return {auto=L["Automatic"], up=L["Up"], down=L["Down"],}
                --                        elseif TotemTimers.ActiveProfile.TrackerArrange == "vertical" then
                --                            return {auto=L["Automatic"], left=L["Left"], right=L["Right"],}
                --                        else
                --                            return {auto=L["Automatic"], left=L["Left"], right=L["Right"], up=L["Up"], down=L["Down"],}
                --                        end
                --                     end,
                --            set = function(info, val)
                --                        TotemTimers.ActiveProfile.ESMainTankMenuDirection = val  TotemTimers.ProcessSetting("ESMainTankMenuDirection")
                --                  end,
                --            get = function(info) return TotemTimers.ActiveProfile.ESMainTankMenuDirection end,
                --        },
                --    },
                --},
                weapons = {
                    order = 4,
                    name = L["Weapon Buff Tracker"],
                    desc = L["WeaponDesc"],
                    type = "group",
                    args = {
                        enable = {
                            order = 0,
                            type = "toggle",
                            name = L["Enable"],
                            set = function(info, val) TotemTimers.ActiveProfile.WeaponTracker = val
                                TotemTimers.ProcessSetting("WeaponTracker") end,
                            get = function(info) return TotemTimers.ActiveProfile.WeaponTracker end,
                        },
                        openright = {
                            order = 4,
                            type = "toggle",
                            name = L["Open On Rightclick"],
                            set = function(info, val)
                                TotemTimers.ActiveProfile.WeaponMenuOnRightclick = val  TotemTimers.ProcessSetting("WeaponMenuOnRightclick")
                                TotemTimers.InitializeBindings()
                            end,
                            get = function(info) return TotemTimers.ActiveProfile.WeaponMenuOnRightclick end,
                        },
                        menudirection = {
                            order = 5,
                            type = "select",
                            name = L["Menu Direction"],
                            values = function()
                                if TotemTimers.ActiveProfile.TrackerArrange == "horizontal" then
                                    return {auto=L["Automatic"], up=L["Up"], down=L["Down"],}
                                elseif TotemTimers.ActiveProfile.TrackerArrange == "vertical" then
                                    return {auto=L["Automatic"], left=L["Left"], right=L["Right"],}
                                else
                                    return {auto=L["Automatic"], left=L["Left"], right=L["Right"], up=L["Up"], down=L["Down"],}
                                end
                            end,
                            set = function(info, val)
                                TotemTimers.ActiveProfile.WeaponBarDirection = val  TotemTimers.ProcessSetting("WeaponBarDirection")
                            end,
                            get = function(info) return TotemTimers.ActiveProfile.WeaponBarDirection end,
                        },
                    },
                },
            },
        },
    },
}

local ACD = LibStub("AceConfigDialog-3.0")
local frame = ACD:AddToBlizOptions("TotemTimers", L["Trackers"], "TotemTimers", "trackers")
frame:SetScript("OnEvent", function(self) InterfaceOptionsFrame:Hide() end)
frame:HookScript("OnShow", function(self) if InCombatLockdown() then InterfaceOptionsFrame:Hide() end TotemTimers.LastGUIPanel = self end)
frame:RegisterEvent("PLAYER_REGEN_DISABLED")