-- Copyright © 2008 - 2012 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.

if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers_GUI", true)

local ElementValues = {
	[EARTH_TOTEM_SLOT] = L["Earth"],
	[FIRE_TOTEM_SLOT] = L["Fire"],
	[WATER_TOTEM_SLOT] = L["Water"],
	[AIR_TOTEM_SLOT] = L["Air"],
}

local function SetOrder(nr, value)
	local fromnr = 0;
	for i=1,4 do
		if TotemTimers.ActiveProfile.Order[i] == value then fromnr = i end
	end
	TotemTimers.ActiveProfile.Order[fromnr] = TotemTimers.ActiveProfile.Order[nr]
	TotemTimers.ActiveProfile.Order[nr] = value
	TotemTimers.ProcessSetting("Order")
end

TotemTimers.options.args.timers = {
    type = "group",
    name = "Timers",
    args = {
         show = {
            order = 0,
            type = "toggle",
            name = L["Enable"],
            desc = L["Enables the four totem timer buttons and menus"],
            set = function(info, val) TotemTimers.ActiveProfile.Show = val  TotemTimers.ProcessSetting("Show") end,
            get = function(info) return TotemTimers.ActiveProfile.Show end,
        },  
        clickthrough = {
            order = 1,
            type = "toggle", 
            name = L["Clickthrough"],
            desc = L["Clickthrough Desc"],
            set = function(info, val) TotemTimers.ActiveProfile.Timer_Clickthrough = val  TotemTimers.ProcessSetting("Timer_Clickthrough") end,
            get = function(info) return TotemTimers.ActiveProfile.Timer_Clickthrough end,
        },
        h1 = {
            order = 2,
            type = "header",
            name = "",
        },
        timer1 = {
            order = 3,
            type = "select",
            name = L["Timer Button 1"],
            values = ElementValues,
            set = function(info, val) SetOrder(1, val) end,
            get = function(info) return TotemTimers.ActiveProfile.Order[1] end,
        },  
        timer2 = {
            order = 3,
            type = "select",
            name = L["Timer Button 2"],
            values = ElementValues,
            set = function(info, val) SetOrder(2, val) end,
            get = function(info) return TotemTimers.ActiveProfile.Order[2] end,
        },
        timer3 = {
            order = 4,
            type = "select",
            name = L["Timer Button 3"],
            values = ElementValues,
            set = function(info, val) SetOrder(3, val) end,
            get = function(info) return TotemTimers.ActiveProfile.Order[3] end,
        },
        timer4 = {
            order = 5,
            type = "select",
            name = L["Timer Button 4"],
            values = ElementValues,
            set = function(info, val) SetOrder(4, val) end,
            get = function(info) return TotemTimers.ActiveProfile.Order[4] end,
        },
        arrange = {
            order = 6,
            type = "select",
            name = L["Arrangement"],
            desc = L["Basic layout of the four timer buttons, loose lets you move them individually"],
            values = {vertical = L["vertical"], horizontal = L["horizontal"],
                      box = L["box"], free = L["loose"],},
            set = function(info, val)
                        TotemTimers.ActiveProfile.Arrange = val
                        if not TotemTimers.ActiveProfile.MenusAlwaysVisible then
                            if val ~= "free" then
                                TotemTimers.ActiveProfile.CastBarDirection = "auto"
                            else
                                TotemTimers.ActiveProfile.CastBarDirection = "right"
                            end
                        end
                        TotemTimers.OrderTimers()
                        for i=1,4 do
                            XiTimers.timers[i]:SetTimerBarPos(XiTimers.timers[i].timerBarPos, true)
                        end
                  end,
            get = function(info) return TotemTimers.ActiveProfile.Arrange end,
        },
       --[[ time = {
            order = 8,
            type = "select",
            name = L["Time Style"],
            desc = L["Sets the format in which times are displayed"],
            values = {["mm:ss"] = "mm:ss", blizz = L["Blizz Style"], },
            set = function(info, val)
                        TotemTimers.ActiveProfile.TimeStyle = val  TotemTimers.ProcessSetting("TimeStyle")
                        TotemTimers.ActiveProfile.TimeStyle = val  TotemTimers.ProcessSetting("TimeStyle")
                  end,
            get = function(info) return TotemTimers.ActiveProfile.TimeStyle end,
        },]]
        timepos = {
            order = 9,
            type = "select",
            name = L["Timer Bar Position"],
            desc = L["Timer Bar Position Desc"],
            values = {	["LEFT"] = L["Left"], ["RIGHT"] = L["Right"], ["TOP"] = L["Top"], ["BOTTOM"] = L["Bottom"],},
            set = function(info, val)
                        TotemTimers.ActiveProfile.TimerTimePos = val  TotemTimers.ProcessSetting("TimerTimePos")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.TimerTimePos end,
        },
        menudirection = {
            order = 7,
            type = "select",
            name = L["Totem menu direction"],
            desc = L["Totem menu direction desc"],
            values = function()
                        if TotemTimers.ActiveProfile.Arrange == "horizontal" then
                            return {auto=L["Automatic"], up=L["Up"], down=L["Down"],}
                        elseif TotemTimers.ActiveProfile.Arrange == "vertical" or TotemTimers.ActiveProfile.Arrange == "box" then
                            return {auto=L["Automatic"], left=L["Left"], right=L["Right"],}
                        else
                            return {auto=L["Automatic"], left=L["Left"], right=L["Right"], up=L["Up"], down=L["Down"],}
                        end
                     end,
            set = function(info, val)
                        TotemTimers.ActiveProfile.CastBarDirection = val  TotemTimers.ProcessSetting("CastBarDirection")
                  end,
            get = function(info) return TotemTimers.ActiveProfile.CastBarDirection end,
        },
        sizes = {
            order = 10,
            type = "header",
            name = L["Scaling"],
        },
        timerSize = {
            order = 11,
            type = "range",
            name = L["Button Size"],
            desc = L["Scales the timer buttons"],
            min = 16,
            max = 96,
            step = 1,
            bigStep = 2,
            set = function(info, val)
                        TotemTimers.ActiveProfile.TimerSize = val  TotemTimers.ProcessSetting("TimerSize")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.TimerSize end,
        },
        timerTimeHeight = {
            order = 12,
            type = "range",
            name = L["Time Size"],
            desc = L["Sets the font size of time strings"],
            min = 6,
            max = 40,
            step = 1,
            set = function(info, val)
                        TotemTimers.ActiveProfile.TimerTimeHeight = val  TotemTimers.ProcessSetting("TimerTimeHeight")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.TimerTimeHeight end,
        },
        spacing = {
            order = 13,
            type = "range",
            name = L["Spacing"] ,
            desc = L["Sets the space between timer buttons"],
            min = -2,
            max = 20,
            step = 1,
            set = function(info, val)
                        TotemTimers.ActiveProfile.TimerSpacing = val  TotemTimers.ProcessSetting("TimerSpacing")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.TimerSpacing end,
        },
        timeSpacing = {
            order = 14,
            type = "range",
            name = L["Time Spacing"],
            desc = L["Sets the space between timer buttons and timer bars"],
            min = 0,
            max = 20,
            step = 1,
            set = function(info, val)
                        TotemTimers.ActiveProfile.TimerTimeSpacing = val  TotemTimers.ProcessSetting("TimerTimeSpacing")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.TimerTimeSpacing end,
        },
        timerBarWidth = {
            order = 15,
            type = "range",
            name = L["Timer Bar Width"],
            desc = L["Timer Bar Width Desc"],
            min = 36,
            max = 300,
            step = 4,
            set = function(info, val)
                        TotemTimers.ActiveProfile.TotemTimerBarWidth = val  TotemTimers.ProcessSetting("TotemTimerBarWidth")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.TotemTimerBarWidth end,
        },
        TotemMenuSpacing = {
            order = 16,
            type = "range",
            name = L["Totem Menu Spacing"],
            desc = L["Totem Menu Spacing Desc"],
            min = 0,
            max = 40,
            step = 1,
            set = function(info, val)
                        TotemTimers.ActiveProfile.TotemMenuSpacing = val
                        for i=1,4 do TTActionBars.bars[i]:SetDirection(TTActionBars.bars[i].direction, TTActionBars.bars[i].parentdirection) end
                  end,
            get = function(info) return TotemTimers.ActiveProfile.TotemMenuSpacing end,
        },
        advanced = {
            order = 30,
            type = "header",
            name = L["Advanced Options"],
        },
        openright = {
            order = 31,
            type = "toggle",
            name = L["Open On Rightclick"],
            desc = L["Rightclick Desc"],
            set = function(info, val) TotemTimers.ActiveProfile.OpenOnRightclick = val  TotemTimers.ProcessSetting("OpenOnRightclick") end,
            get = function(info) return TotemTimers.ActiveProfile.OpenOnRightclick end,
        },            
        alwaysopen = {
            order = 32,
            type = "toggle",
            name = L["Totem Menus Always Visible"],
            desc = L["Always Visible Desc"],
            set = function(info, val)
                      TotemTimers.ActiveProfile.MenusAlwaysVisible = val
                      TotemTimers.ProcessSetting("OpenOnRightclick")
                      TotemTimers.ProcessSetting("MenusAlwaysVisible")
                  end,
            get = function(info) return TotemTimers.ActiveProfile.MenusAlwaysVisible end,
        },            
        keybinds = {
            order = 33,
            type = "toggle",
            name = L["Totem Menu Key Bindings"],
            desc = L["Keybindings desc"],
            set = function(info, val) TotemTimers.ActiveProfile.BarBindings = val end,
            get = function(info) return TotemTimers.ActiveProfile.BarBindings end,
        },            
        reversekeybinds = {
            order = 34,
            type = "toggle",
            name = L["Reverse Key Bindings"],
            desc = L["Reverse Key Desc"],
            set = function(info, val) TotemTimers.ActiveProfile.ReverseBarBindings = val end,
            get = function(info) return TotemTimers.ActiveProfile.ReverseBarBindings end,
        },            
        miniicons = {
            order = 35,
            type = "toggle",
            name = L["Show Mini Icons"],
            desc = L["Mini Icons Desc"],
            set = function(info, val) TotemTimers.ActiveProfile.MiniIcons = val  TotemTimers.ProcessSetting("MiniIcons") end,
            get = function(info) return TotemTimers.ActiveProfile.MiniIcons end,
        },            
        procflash = {
            order = 36,
            type = "toggle",
            name = L["Enable Pulse Bar"],
            desc = L["Pulse desc"],
            set = function(info, val) TotemTimers.ActiveProfile.ProcFlash = val  TotemTimers.ProcessSetting("ProcFlash") end,
            get = function(info) return TotemTimers.ActiveProfile.ProcFlash end,
        },            
        ColorTimerBars = {
            order = 37,
            type = "toggle",
            name = L["Color Timer Bars"],
            desc = L["Color Timer Bars according to their elements."],
            set = function(info, val) TotemTimers.ActiveProfile.ColorTimerBars = val  TotemTimers.ProcessSetting("ColorTimerBars") end,
            get = function(info) return TotemTimers.ActiveProfile.ColorTimerBars end,
        },            
        ShowCooldowns = {
            order = 38,
            type = "toggle",
            name = L["Show Totem Cooldowns"],
            desc = L["Totem Cooldowns desc"],
            set = function(info, val) TotemTimers.ActiveProfile.ShowCooldowns = val  TotemTimers.ProcessSetting("ShowCooldowns") end,
            get = function(info) return TotemTimers.ActiveProfile.ShowCooldowns end,                          
        },                                               
        PlayerRange = {
            order = 39,
            type = "toggle",
            name = L["Player Range"],
            desc = L["Player Range Desc"],
            set = function(info, val) TotemTimers.ActiveProfile.CheckPlayerRange = val  TotemTimers.ProcessSetting("CheckPlayerRange") end,
            get = function(info) return TotemTimers.ActiveProfile.CheckPlayerRange end,                          
        },                                               
        RaidRange = {
            order = 40,
            type = "toggle",
            name = L["Raid Member Range"],
            desc = L["Range Desc"],
            set = function(info, val) TotemTimers.ActiveProfile.CheckRaidRange = val  TotemTimers.ProcessSetting("CheckRaidRange") end,
            get = function(info) return TotemTimers.ActiveProfile.CheckRaidRange end,                          
        },                                               
        RaidRangeTooltip = {
            order = 41,
            type = "toggle",
            name = L["Raid Range Tooltip"],
            desc = L["RR Tooltip Desc"],
            set = function(info, val) TotemTimers.ActiveProfile.ShowRaidRangeTooltip = val  TotemTimers.ProcessSetting("ShowRaidRangeTooltip") end,
            get = function(info) return TotemTimers.ActiveProfile.ShowRaidRangeTooltip end,                          
        },                                               
    },
}

local ACD = LibStub("AceConfigDialog-3.0")
local frame = ACD:AddToBlizOptions("TotemTimers", L["Timers"], "TotemTimers", "timers")
frame:SetScript("OnEvent", function(self) InterfaceOptionsFrame:Hide() end)
frame:HookScript("OnShow", function(self) if InCombatLockdown() then InterfaceOptionsFrame:Hide() end TotemTimers.LastGUIPanel = self end)
frame:RegisterEvent("PLAYER_REGEN_DISABLED")