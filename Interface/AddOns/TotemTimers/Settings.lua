-- Copyright © 2008 - 2012 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.
-- Current distribution permissions only include curse.com, wowinterface.com and their respective addon updaters

if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local TRACKER_START = 5
local TRACKER_END = 8
local Timers = XiTimers.timers

local SpellIDs = TotemTimers.SpellIDs
local SpellNames = TotemTimers.SpellNames
local AvailableSpells = TotemTimers.AvailableSpells

-- local TotemFrameScript = TotemFrame:GetScript("OnShow")

local LSM = LibStub:GetLibrary("LibSharedMedia-3.0", true)

local TotemColors = {
    [AIR_TOTEM_SLOT] = {0.7,0.7,1.0},
    [WATER_TOTEM_SLOT] = {0.4,0.4,1.0},
    [FIRE_TOTEM_SLOT] = {1.0,0.1,0.1},
    [EARTH_TOTEM_SLOT] = {0.7,0.5,0.3},
}

local SettingsFunctions

function TotemTimers.ProcessSetting(setting)
    if SettingsFunctions[setting] then
        SettingsFunctions[setting](TotemTimers.ActiveProfile[setting], XiTimers.timers)
    end
end


function TotemTimers.ProcessAllSettings()
    for k,v in pairs(TotemTimers.ActiveProfile) do
        TotemTimers.ProcessSetting(k)
    end
end


SettingsFunctions = {
    ShowTimerBars = 
        function(value, Timers) 
            for _,timer in pairs(Timers) do
                timer.visibleTimerBars = value
                for n,t in pairs(timer.timers) do
                    if t>0 and value then
                        timer:ShowTimerBar(n)
                    else
                        timer.timerBars[n].background:Hide()
                        timer.timerBars[n]:SetValue(0)
                    end					
                end
            end
            --[[ TotemTimers.fs.visibleTimerBars = true
            if TotemTimers.fs.timers[1]>0 then
                TotemTimers.fs:ShowTimerBar(1)
            end --]]
        end,

    FlashRed = 
        function(value, Timers)
        	for _,timer in pairs(Timers) do
                timer.flashRed = value
            end
        end,

    TimeStyle =
        function(value, Timers)
            for k,timer in pairs(Timers) do
                if ((k<6 or not TotemTimers.ActiveProfile.ShieldChargesOnly) or k>7) then
                    timer.timeStyle = value
                end
            end
        end,
        
    TimerSize = 
        function(value, Timers)
            local v = value
    		for e=1,4 do
    			Timers[e]:SetScale(v/36)
    		end
        end,
        
    TrackerSize = 
        function(value, Timers)
    		for e=TRACKER_START, TRACKER_END do
    			Timers[e]:SetScale(value/36)
    		end
        end,

    TimerTimeHeight =
        function(value, Timers)
    		for e=1,4 do
    			Timers[e]:SetTimeHeight(value)
                Timers[e].button.time:SetFont(Timers[e].button.time:GetFont(),value+5,"OUTLINE")
    		end        
        end,
        
    TrackerTimeHeight =
        function(value, Timers)
    		for e=TRACKER_START, TRACKER_END do
    			Timers[e]:SetTimeHeight(value)
                Timers[e].button.time:SetFont(Timers[e].button.time:GetFont(),value+5,"OUTLINE")
    		end
    		--[[ for e=22, 23 do
    			Timers[e]:SetTimeHeight(value)
                Timers[e].button.time:SetFont(Timers[e].button.time:GetFont(),value+5,"OUTLINE")
    		end ]]
        end,
        
    TimerSpacing = 
        function(value, Timers)
    		for e=1,4 do
    			Timers[e]:SetSpacing(value)
    		end
        end,
        
    TrackerSpacing =
        function(value, Timers)
    		for e=TRACKER_START, TRACKER_END do
    			Timers[e]:SetSpacing(value)
    		end
    		--[[ for e=22, 23 do
    			Timers[e]:SetSpacing(value)
    		end ]]
    end,
        
    TimerTimeSpacing = 
        function(value, Timers)
    		for e=1,4 do
    			Timers[e]:SetTimeSpacing(value)
    		end
        end,
        
    TrackerTimeSpacing =
        function(value, Timers)
    		for e=TRACKER_START, TRACKER_END do
    			Timers[e]:SetTimeSpacing(value)
    		end
           --[[ for e=22, 23 do
    			Timers[e]:SetTimeSpacing(value)
    		end ]]
        end,
        
    TimerTimePos = 
        function(value, Timers)
    		for e=1,4 do
    			Timers[e]:SetTimerBarPos(value)
    		end  
        end,
        
    TrackerTimePos =
        function(value, Timers)
    		for e=TRACKER_START, TRACKER_END do
    			Timers[e]:SetTimerBarPos(value)
    		end
        end,
    
    AnkhTracker = 
        function(value, Timers)
    		if value and AvailableSpells[SpellIDs.Ankh] then
    			Timers[5]:Activate()
    		else
    			Timers[5]:Deactivate()
    		end
    		TotemTimers.OrderTrackers()
        end,
        
    ShieldTracker =
        function(value, Timers)
            Timers[6].ActiveWhileHidden = TotemTimers.ActiveProfile.ActivateHiddenTimers and not value
    		if (value or TotemTimers.ActiveProfile.ActivateHiddenTimers) and (AvailableSpells[SpellIDs.LightningShield] or AvailableSpells[SpellIDs.WaterShield]) then
    			Timers[6]:Activate()
    		else
    			Timers[6]:Deactivate()
    		end            
    		TotemTimers.OrderTrackers()		
        end,

    ShieldChargesOnly =
        function(value, Timers)
            TotemTimers.SetShieldUpdate()
        end,
        
    --[[ EarthShieldTracker =
        function(value, Timers)
            Timers[7].ActiveWhileHidden = TotemTimers.ActiveProfile.ActivateHiddenTimers and not value
    		if (value or TotemTimers.ActiveProfile.ActivateHiddenTimers) and AvailableSpells[SpellIDs.EarthShield] then
    			Timers[7]:Activate()
    		else
    			Timers[7]:Deactivate()
    		end
    		TotemTimers.OrderTrackers()
        end, --]]

    WeaponTracker =
    function(value, Timers)
        Timers[8].ActiveWhileHidden = TotemTimers.ActiveProfile.ActivateHiddenTimers and not value
        if (value or TotemTimers.ActiveProfile.ActivateHiddenTimers) and AvailableSpells[SpellIDs.RockbiterWeapon] then
            Timers[8]:Activate()
        else
            Timers[8]:Deactivate()
        end
        TotemTimers.OrderTrackers()
    end,

    LastWeaponEnchant =
    function(value, Timers)
        if value == 5 then
            Timers[8].button:SetAttribute("type1", "macro")
            Timers[8].button:SetAttribute("macrotext", "/cast "..SpellNames[SpellIDs.WindfuryWeapon].."\n/use 16")
            Timers[8].button:SetAttribute("doublespell1", SpellNames[SpellIDs.WindfuryWeapon])
            Timers[8].button:SetAttribute("doublespell2", SpellNames[SpellIDs.FlametongueWeapon])
            Timers[8].button:SetAttribute("ds", 1)
        elseif value == 6 then
            Timers[8].button:SetAttribute("type1", "macro")
            Timers[8].button:SetAttribute("macrotext", "/cast "..SpellNames[SpellIDs.WindfuryWeapon].."\n/use 16")
            Timers[8].button:SetAttribute("*spell1", SpellNames[SpellIDs.WindfuryWeapon])
            Timers[8].button:SetAttribute("doublespell1", SpellNames[SpellIDs.WindfuryWeapon])
            Timers[8].button:SetAttribute("doublespell2", SpellNames[SpellIDs.FrostbrandWeapon])
            Timers[8].button:SetAttribute("ds", 1)
        else
            Timers[8].button:SetAttribute("type1", "spell")
            Timers[8].button:SetAttribute("spell1", value)
        end
    end,
        
       
     
    --[[ HideBlizzTimers =
        function(value)
            if value then
                TotemFrame:UnregisterEvent("PLAYER_TOTEM_UPDATE")
                TotemFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
                TotemFrame:SetScript("OnShow", function() TotemFrame:Hide() end)
                TotemFrame:Hide()
            else
                TotemFrame:RegisterEvent("PLAYER_TOTEM_UPDATE")
                TotemFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
                TotemFrame:Show()
                TotemFrame:SetScript("OnShow", TotemFrameScript)
            end
        end, ]]
            
    --[[ ShieldLeftButton =
        function(value, Timers)
    		Timers[6].button:SetAttribute("*spell1",value)
        end,
        
    ShieldRightButton =
        function(value, Timers)
    		Timers[6].button:SetAttribute("*spell2", value)
        end,
            
    ShieldMiddleButton =
        function(value, Timers)
    		Timers[6].button:SetAttribute("*spell3", value)
        end, ]]



    Order =
        function(value, Timers)
    		for i=1,4 do Timers[i] = _G["XiTimers_Timer"..value[i]].timer end            
    		TotemTimers.OrderTimers()
        end,
    
    OpenOnRightclick =
        function(value, Timers)
            for i = 1,4 do
                if value and not TotemTimers.ActiveProfile.MenusAlwaysVisible then 
                    Timers[i].button:SetAttribute("OpenMenu", "RightButton")
                    --Timers[i].button:SetAttribute("*macrotext3", "/script XiTimers.timers["..i.."].stopQuiet = true DestroyTotem("..Timers[i].nr..")")
					Timers[i].button:SetAttribute("*macrotext3", "/cast Totemic Recall")
                    Timers[i].button:SetAttribute("*macrotext2", "")
                else
                    Timers[i].button:SetAttribute("OpenMenu", "mouseover")
                    Timers[i].button:SetAttribute("*macrotext3", "/cast Totemic Recall")
					Timers[i].button:SetAttribute("*macrotext2", "/cast Totemic Recall")
                    --Timers[i].button:SetAttribute("*macrotext2", "/script XiTimers.timers["..i.."].stopQuiet = true DestroyTotem("..Timers[i].nr..")")
                end
            end
        end,
    
    MenusAlwaysVisible =
        function(value, Timers)
            if value then
                for i=1,4 do
                    Timers[i].button:SetAttribute("OpenMenu", "always")
                end
            end
            for i=1,4 do
                TTActionBars.bars[i]:SetAlwaysVisible(value)
            end
        end,
     
    MiniIcons =
        function(value, Timers)
            for e=1,4 do
                if value then
                    Timers[e].button.miniIconFrame:Show()
                else
                    Timers[e].button.miniIconFrame:Hide()
                end
            end
        end,
        
    Lock =
        function(value, Timers)
            for k,v in pairs(Timers) do
                v.locked = value
            end
        end,
        
    Show =
        function(value, Timers)
            if value then 
                for i=1,4 do 
                    if (Timers[i].nr == FIRE_TOTEM_SLOT and AvailableSpells[SpellIDs.Searing])
                      or (Timers[i].nr == EARTH_TOTEM_SLOT and (AvailableSpells[SpellIDs.Stoneskin] or AvailableSpells[SpellIDs.Earthbind] or AvailableSpells[SpellIDs.StoneBulwark]))
                      or (Timers[i].nr == WATER_TOTEM_SLOT and AvailableSpells[SpellIDs.HealingStream])
                      or (Timers[i].nr == AIR_TOTEM_SLOT and (AvailableSpells[SpellIDs.Grounding] or AvailableSpells[SpellIDs.NatureResistance] or AvailableSpells[SpellIDs.Windfury])) then
                        Timers[i]:Activate()
                    end
                end
                --TotemTimersFrame:Show()
                TotemTimers.OrderTimers()
            else
                for i=1,4 do
                    Timers[i]:Deactivate()
                end
                --TotemTimersFrame:Hide()
            end
        end,
     
    ProcFlash =
        function(value, Timers)
            for i=1,4 do
                Timers[i].procFlash = value
            end
        end,
     
    TimeFont =
        function(value, Timers)
            local font = LSM:Fetch("font", value)
            if font then
                for _,timer in pairs(Timers) do
                    timer:SetFont(font)
                end
            end
        end,
        
    TimerBarTexture =
        function(value, Timers) 
            local texture = LSM:Fetch("statusbar", value)
            if texture then
                for _,timer in pairs(Timers) do
                    timer:SetBarTexture(texture)
                end
            end
        end,
        
    ColorTimerBars =
        function(value, Timers)
            for i=1,#Timers do
                if value and i<5 then
                    Timers[i]:SetBarColor(TotemColors[Timers[i].nr][1], TotemColors[Timers[i].nr][2], TotemColors[Timers[i].nr][3],1)
                elseif i ~= 21 then
                    Timers[i]:SetBarColor(TotemTimers.ActiveProfile.TimerBarColor.r,TotemTimers.ActiveProfile.TimerBarColor.g,
                                          TotemTimers.ActiveProfile.TimerBarColor.b,TotemTimers.ActiveProfile.TimerBarColor.a)

                end
            end
        end,
        
    ShowCooldowns =
        function(value, Timers)
            if TotemTimers_IsSetUp then
                TotemTimers.OrderTimers()
                for i = 1,4 do TotemTimers.TotemEvent(Timers[i].button,"SPELL_UPDATE_COOLDOWN", i) end
            end
        end,
        
    BarBindings =
        function(value, Timers)
            for i=1,4 do
                for j=1,5 do
                    local key = GetBindingKey("TOTEMTIMERSCAST"..i..j)
                    if TotemTimers.ActiveProfile.BarBindings and not TotemTimers.ActiveProfile.MenusAlwaysVisible then
                        if TotemTimers.ActiveProfile.ReverseBarBindings then
                            getglobal("TT_ActionButton"..i..j.."HotKey"):SetText(key or tostring(10-j))
                            getglobal("TT_ActionButton"..i..j):SetAttribute("binding", tostring(10-j))
                        else
                            getglobal("TT_ActionButton"..i..j.."HotKey"):SetText(key or tostring(j))
                            getglobal("TT_ActionButton"..i..j):SetAttribute("binding", tostring(j))
                        end
                    else
                        getglobal("TT_ActionButton"..i..j.."HotKey"):SetText(key or "")
                        getglobal("TT_ActionButton"..i..j):SetAttribute("binding", nil)
                    end
                end
            end
        end,
        
   
    --[[ EnhanceCDs =
        function(value)
            if value then
                TotemTimers.ActivateEnhanceCDs() 
            else
                TotemTimers.DeactivateEnhanceCDs()
            end
        end,
        
    EnhanceCDsSize =
        function(value)
			local Timers = TotemTimers.EnhanceCDs
            for i=1,#Timers-1 do
                Timers[i]:SetScale(value/36)
            end
            TotemTimers.maelstrom.background:SetWidth(value*3+10)
            TotemTimers.maelstrom:SetWidth(value*3+10)
            TotemTimers.maelstrombutton:SetWidth(value*3+10)
            Timers[#Timers-1]:SetTimeWidth(value*3+10)
            TotemTimers.LayoutEnhanceCDs()
			for i = 1,#TotemTimers.LongCooldowns do
				TotemTimers.LongCooldowns[i]:SetScale(value/36)
			end
        end,
        
    EnhanceCDsTimeHeight = 
         function(value)
			local AllTimers = {TotemTimers.EnhanceCDs, TotemTimers.LongCooldowns}
			for t=1,2 do
				local Timers = AllTimers[t]
				for e=1,#Timers-1 do
					Timers[e]:SetTimeHeight(value)
					local font, _ = Timers[e].button.time:GetFont()
					Timers[e].button.time:SetFont(font, value+5, "OUTLINE")
				end 
			end
            TotemTimers.LayoutEnhanceCDs()
			TotemTimers.LayoutLongCooldowns()
        end,
        
    EnhanceCDsMaelstromHeight = 
        function(value, Timers)
            TotemTimers.maelstrom:SetHeight(value)
            TotemTimers.maelstrom.background:SetHeight(value)
            TotemTimers.maelstrombutton:SetHeight(value)
            TotemTimers.maelstrom.icon:SetWidth(value)
            TotemTimers.maelstrom.icon:SetHeight(value)
            Timers[21]:SetScale(value/36)
            Timers[21]:SetTimeHeight(value)
            Timers[21].timerBars[1]:SetScale(36/value)
            local font = TotemTimers.maelstrom.text:GetFont()
            local outline
            if Timers[9].timerOnButton then outline = "OUTLINE" end
    		TotemTimers.maelstrom.text:SetFont(font, value, outline)
            local font, value = _G["XiTimers_TimerBar17_1Time"]:GetFont()
            _G["XiTimers_TimerBar17_1Time"]:SetFont(font, value, outline)
            TotemTimers.LayoutEnhanceCDs()
        end, --]]
        
    Tooltips =  
        function(value, Timers)
            for i=1,TRACKER_END do
                Timers[i].button:SetAttribute("tooltip", value)
            end
            for i=1,TTActionBars.numbars do
                TTActionBars.bars[i]:SetTooltip(value)
            end
        end,
        
    TotemTimerBarWidth =
        function(value, Timers)
            for i=1,4 do
                for j=1,Timers[i].nrOfTimers do
                    Timers[i].timerBars[j]:SetWidth(value)
                end
            end
        end,
        
    TrackerTimerBarWidth =
        function(value, Timers)
            for i=TRACKER_START,TRACKER_END do
                for j=1,Timers[i].nrOfTimers do
                    Timers[i].timerBars[j]:SetWidth(value)
                end
            end
            --[[ for i=22,23 do
                for j=1,Timers[i].nrOfTimers do
                    Timers[i].timerBars[j]:SetWidth(value)
                end
            end ]]
        end,
        
    ActivateHiddenTimers =
        function(value, Timers)
            TotemTimers.ProcessSetting("ShieldTracker")
            -- TotemTimers.ProcessSetting("EarthShieldTracker")
            TotemTimers.ProcessSetting("WeaponTracker")
        end,
        
    ShowKeybinds =
        function(value, Timers)
            for _,t in pairs(Timers) do
                if value then
                    t.button.hotkey:Show()
                else
                    t.button.hotkey:Hide()
                end
            end
        end,
        
    FramePositions = 
        function(value, Timers)
            for name, pos in pairs(value) do
                if _G[name] and pos and pos[1] then
                    _G[name]:ClearAllPoints()
                    _G[name]:SetPoint(pos[1],pos[2],pos[3],pos[4],pos[5])
                end
            end
        end,

    WeaponBarDirection =
    function(value, Timers)
        TTActionBars.bars[5]:SetDirection(value, TotemTimers.ActiveProfile.TrackerArrange)
        --if #TTActionBars.bars > 5 then TotemTimers.ProcessSetting("MultiSpellBarDirection") end
    end,

    WeaponMenuOnRightclick =
    function(value, Timers)
        if value then
            XiTimers.timers[8].button:SetAttribute("OpenMenu", "RightButton")
        else
            XiTimers.timers[8].button:SetAttribute("OpenMenu", "mouseover")
        end
        TotemTimers.ProcessSetting("LastWeaponEnchant2")
    end,
        
    --[[ ESMainTankMenuDirection =
        function(value, Timers) 
            TTActionBars.bars[5]:SetDirection(value, TotemTimers.ActiveProfile.TrackerArrange)
            --if #TTActionBars.bars > 5 then TotemTimers.ProcessSetting("MultiSpellBarDirection") end
        end,  --]]
        
    --[[EnhanceCDsOOCAlpha =
        function(value)
			local Timers = TotemTimers.EnhanceCDs
            for i = 1,#Timers do
                Timers[i].OOCAlpha = value
            end
            TotemTimers.maelstrom:SetAlpha(value)
            XiTimers.invokeOOCFader()
        end, --]]
        
    TimersOnButtons = 
        function(value, Timers)
            for i=1,#Timers do
                if i ~= 21 then
                    Timers[i].timerOnButton = value
                    if not value and i > 8 and TotemTimers.ActiveProfile.CDTimersOnButtons then Timers[i].timerOnButton = true end
                    if Timers[i].timers[1] > 0 then Timers[i]:Start(1, Timers[i].timers[1], Timers[i].durations[1]) end
                    if Timers[i].nrOfTimers > 1 and Timers[i].timers[2] > 0 then Timers[i]:Start(2, Timers[i].timers[2], Timers[i].durations[1]) end
                end
            end
            TotemTimers.ProcessSetting("EnhanceCDsMaelstromHeight")
        end,
    
    TimeColor = 
        function(value, Timers)
            for i=1,#Timers do
                Timers[i].button.time:SetTextColor(value.r, value.g, value.b, 1)
                Timers[1].timeColor = value
                for j=1,#Timers[i].timerBars do
                    Timers[i].timerBars[j].time:SetTextColor(value.r,value.g,value.b,1)
                end
            end
        end,
        
   
    --[[ HideInVehicle =
        function(value, Timers)
            if value then
                for k,v in pairs(Timers) do
                    RegisterStateDriver(v.button,"invehicle","[bonusbar:5]hide;show")
                end
                --RegisterStateDriver(TotemTimers.MB,"invehicle","[bonusbar:5]hide;show")
            else
                for k,v in pairs(Timers) do
                    UnregisterStateDriver(v.button,"invehicle")
                end
                --UnregisterStateDriver(TotemTimers.MB,"invehicle")
            end
        end, --]]
   
    StopPulse =
        function(value, Timers)
            for i = 1,4 do
                Timers[i].StopPulse = value
            end
            for i = 6,TRACKER_END do
                Timers[i].StopPulse = value
            end
        end,
        
    --[[ HideEnhanceCDsOOC =
        function(value)
			local Timers = TotemTimers.EnhanceCDs
            for i = 1,#Timers do
                Timers[i].HideOOC = value
				Timers[i].button:SetAttribute("HideOOC", value)
            end
            TotemTimers.ConfigEnhanceCDs()
        end, --]]
        
        
    --[[ EarthShieldTargetName =
        function(value, Timers)
            if value then
                Timers[7].nameframe:Show()
            else
                Timers[7].nameframe:Hide()
            end
        end, ]]
        
    --[[ EnhanceCDs_Clickthrough =
        function(value)
			local Timers = TotemTimers.EnhanceCDs
            for i = 1,#Timers do
                Timers[i].button:EnableMouse(not value)
            end
			Timers = TotemTimers.LongCooldowns
            for i = 1,#Timers do
                Timers[i].button:EnableMouse(not value)
            end
            TotemTimers.maelstrom:EnableMouse(not value)
            TotemTimers.maelstrombutton:EnableMouse(not value)
        end, --]]
        
    Timer_Clickthrough = 
        function(value, Timers)
            for i = 1,4 do
                Timers[i].button:EnableMouse(not value)
            end
        end,
        
    Tracker_Clickthrough = 
        function(value, Timers)
            for i = TRACKER_START,TRACKER_END do
                Timers[i].button:EnableMouse(not value)
            end
        end,
        
    --[[ ESChargesOnly =
        function(value, Timers)
            TotemTimers.SetEarthShieldUpdate()
        end, --]]
        
    --[[ CrowdControlSize =
        function(value, Timers)
    		TotemTimers.CrowdControl[1]:SetScale(value/36)
    		TotemTimers.CrowdControl[2]:SetScale(value/36)
        end,
        
    CrowdControlTimePos =
        function(value, Timers)
  			TotemTimers.CrowdControl[1]:SetTimerBarPos(value)
			TotemTimers.CrowdControl[2]:SetTimerBarPos(value)
        end,
        
    CrowdControlClickthrough = 
        function(value, Timers)
            TotemTimers.CrowdControl[1].button:EnableMouse(not value)
			TotemTimers.CrowdControl[2].button:EnableMouse(not value)            
        end,
        
    CrowdControlEnable =
        function(value)
			local Timers = TotemTimers.CrowdControl
            if not value then				
                Timers[1]:Deactivate()
                Timers[2]:Deactivate()
                TotemTimers_CrowdControlFrame:Hide()
            else
                if TotemTimers.ActiveProfile.CrowdControlHex and AvailableSpells[SpellIDs.Hex] then Timers[1]:Activate() else Timers[1]:Deactivate() end
                if TotemTimers.ActiveProfile.CrowdControlBindElemental and AvailableSpells[SpellIDs.BindElemental] then Timers[2]:Activate() else Timers[2]:Deactivate() end
                TotemTimers_CrowdControlFrame:Show() 
            end
        end,

	LongCooldowns =
		function(value, Timers)
			TotemTimers.ActivateLongCooldowns(value)
		end,
		
	LongCooldownsArrange =
		function(value, Timers)
			TotemTimers.LayoutLongCooldowns()
		end,
		
	CooldownSpacing = 
        function(value, Timers)
    		for k,v in pairs(TotemTimers.LongCooldowns) do
    			v:SetSpacing(value)
    		end
			for k,v in pairs(TotemTimers.EnhanceCDs) do
				v:SetSpacing(value)
			end
        end, --]]
        
}

SettingsFunctions.ReverseBarBindings = SettingsFunctions.BarBindings


