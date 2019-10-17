-- Copyright © 2008 - 2012 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.
-- Current distribution permissions only include curse.com, wowinterface.com and their respective addon updaters

if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers", true)

local TimerCount = {[AIR_TOTEM_SLOT] = 7, [FIRE_TOTEM_SLOT] = 2, [EARTH_TOTEM_SLOT] = 6, [WATER_TOTEM_SLOT] = 4}

local RaidMembers = {}

local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS

local BuffNames = TotemTimers.BuffNames
local SpellNames = TotemTimers.SpellNames
local TextureToName = TotemTimers.TextureToName
local NameToSpellID = TotemTimers.NameToSpellID
local SpellIDs = TotemTimers.SpellIDs
local AvailableSpells = TotemTimers.AvailableSpells


function TotemTimers.CreateTimers()
	for e = 1,4 do
		local tt = XiTimers:new(TimerCount[e])

        tt.manaCheckMini = true
		tt.button:SetScript("OnEvent", TotemTimers.TotemEvent)
		tt.spacing = TotemTimers.ActiveProfile.timerSpacing
		tt.events[1] = "PLAYER_TOTEM_UPDATE"
        tt.events[2] = "SPELL_UPDATE_COOLDOWN"
        tt.events[3] = "PLAYER_ENTERING_WORLD"
        tt.events[4] = "UNIT_SPELLCAST_SUCCEEDED"
        tt.events[5] = "PLAYER_REGEN_ENABLED"
        --tt.events[6] = "UNIT_AURA"
        --tt.events[7] = "RAID_ROSTER_UPDATE"
        
		tt.button.anchorframe = TotemTimersFrame
		tt.button:RegisterForClicks("AnyDown")
		tt.button:SetAttribute("*type2", "macro")
		tt.button:SetAttribute("*type3", "macro")
		--tt.button:SetAttribute("*macrotext2", "/script DestroyTotem("..e..")")		
		tt.button:SetAttribute("*macrotext2", "/cast Totemic Recall")
		tt.button:SetAttribute("*macrotext3", "/cast Totemic Recall")
		tt.button:SetAttribute("*type1", "spell")
        tt.button.bar:SetStatusBarColor(0.7,1,0.7,0.5)
		tt.button.UpdateMiniIconAndProfile = function(self)
                local spell = self:GetAttribute("*spell1")
                if spell and spell ~= 0 then
                    local _,_,t = GetSpellInfo(self:GetAttribute("*spell1"))
                    self.miniIcon:SetTexture(t)
                    TotemTimers.TotemEvent(self, "SPELL_UPDATE_COOLDOWN", self.timer.nr)
                    self.timer.manaCheck = t
                    TotemTimers.ActiveProfile.LastTotems[self.timer.nr] = spell
				end
			end
        tt.button.ShowTooltip = TotemTimers.timerTooltip
        tt.button.HideTooltip = function(self) GameTooltip:Hide() end
		tt.button:SetAttribute("_onenter", [[ control:CallMethod("ShowTooltip")
                                              if self:GetAttribute("OpenMenu") == "mouseover" then
                                                  control:ChildUpdate("show", true)
                                              end ]])
		tt.button:SetAttribute("_onleave", [[ control:CallMethod("HideTooltip")]])
		tt.button:SetAttribute("_onattributechanged", [[ if name=="hide" then
                                                             control:ChildUpdate("show", false)
                                                         elseif name == "*spell1" then 
                                                            control:CallMethod("UpdateMiniIconAndProfile")
                                                         elseif name == "state-invehicle" then
                                                            if value == "show" and self:GetAttribute("active") then
                                                                self:Show()
                                                                local s = self:GetAttribute("*spell1")
                                                                if s then self:SetAttribute("*spell1", s) end
                                                            else
                                                                self:Hide()
                                                            end
                                                         end]])
        tt.button:WrapScript(tt.button, "OnClick", [[ if (button == self:GetAttribute("OpenMenu")
                                                        or (button == "Button4")) then
                                                          local open = self:GetAttribute("open")
                                                          control:ChildUpdate("show", not open)
														  self:SetAttribute("open", not open)
                                                      end ]])
        tt.Activate = function(self)
            XiTimers.Activate(self)
            TotemTimers.TotemEvent(self.button, "PLAYER_TOTEM_UPDATE", self.nr)
            TotemTimers.TotemEvent(self.button, "SPELL_UPDATE_COOLDOWN", self.nr)
			if not TotemTimers.ActiveProfile.LastTotems[self.nr] or 
			  (not AvailableSpells[TotemTimers.ActiveProfile.LastTotems[self.nr]] and not AvailableSpells[NameToSpellID[TotemTimers.ActiveProfile.LastTotems[self.nr]]]) then
				local save = TotemTimers.ActiveProfile.LastTotems[self.nr]
				--[[when switching specs this part gets executed several times, once for switching and then for each talent (because of events fired)
					so totems from talents are sometimes not available at this point.
					lasttotem is saved and restored if not nil so that talent totems aren't replaced when switching specs ]]
				for k,v in pairs(TotemData) do
					if AvailableSpells[k] and v.element == self.nr then
						self.button:SetAttribute("*spell1", SpellNames[k])
						self.button.icon:SetTexture(GetSpellTexture(k))
						break
					end
				end
				-- restore saved totem if not nil
				TotemTimers.ActiveProfile.LastTotems[self.nr] = save or TotemTimers.ActiveProfile.LastTotems[self.nr]
			else
				self.button:SetAttribute("*spell1", TotemTimers.ActiveProfile.LastTotems[self.nr])
				self.button.icon:SetTexture(GetSpellTexture(TotemTimers.ActiveProfile.LastTotems[self.nr]))
			end
        end
        
        --[[ tt.Update = function(self, elapsed)
            XiTimers.Update(self, elapsed)
            if self.timers[1] > 0 then
                self:SetOutOfRange(not TotemTimers.GetPlayerRange(self.button.element))
                --print(TotemTimers.GetPlayerRange(self.button.element))
                local count = TotemTimers.GetOutOfRange(self.button.element)
                if count > 0 then
                    self.button.rangeCount:SetText(count)
                else
                    self.button.rangeCount:SetText("")
                end
            end
        end ]]
        
        --tt.button:UpdateMiniIconAndProfile()
        tt.button:SetScript("OnDragStop", function(self)
                XiTimers.StopMoving(self)
                if not InCombatLockdown() then TotemTimers.PositionCastButtons() end
                if not InCombatLockdown() then self:SetAttribute("hide", true) end
            end)
			            
	end
	TotemTimers.CreateCastButtons()
end


local Cooldowns = {
    [EARTH_TOTEM_SLOT] = {
        [2] = SpellIDs.EarthBind,
        [3] = SpellIDs.Tremor,
        [4] = SpellIDs.Stoneclaw,
    },
    [WATER_TOTEM_SLOT] = {
        [2] = SpellIDs.ManaTide,
    },
    [FIRE_TOTEM_SLOT] = {
        [2] = SpellIDs.FireNova,
    },
    [AIR_TOTEM_SLOT] = {
    },
}

local TotemicCall = TotemTimers.SpellNames[TotemTimers.SpellIDs.TotemicCall]
local LightningBolt = TotemTimers.SpellNames[TotemTimers.SpellIDs.LightningBolt]
local FireElemental = TotemTimers.SpellNames[TotemTimers.SpellIDs.FireElemental]

function TotemTimers:TotemEvent(event, arg1, arg2)
    local settings = TotemTimers.ActiveProfile
    if event == "PLAYER_TOTEM_UPDATE" then
    	if self.element == arg1 then
    		local _, totem, startTime, duration, icon = GetTotemInfo(arg1)
            totem = string.gsub(totem, " [IV]*$", "") -- strip spell rank from name
            totem = NameToSpellID[totem]
    		if duration > 0 and totem and TotemData[totem] then
    			self.icons[1]:SetTexture(icon)
                self.timer.activeTotem = totem
    			self.timer.warningMsgs[1] = "TotemWarning"
    			self.timer.expirationMsgs[1] = "TotemExpiration"
    			self.timer.earlyExpirationMsgs[1] = "TotemDestroyed"
                self.timer.warningIcons[1] = icon
                self.timer.warningSpells[1] = SpellNames[totem]
                if TotemData[totem].flashInterval then
                    self.bar:SetMinMaxValues(0,TotemData[totem].flashInterval)
                    self.timer.bar = TotemData[totem].flashInterval
                    self.timer.barDelay = TotemData[totem].flashDelay or 0
                else
                    self.timer.bar = nil
                end
				self.timer.warningPoint = TotemData[totem].warningPoint or 10
    			self.timer:Start(1, startTime+duration-GetTime())
                --TotemTimers.SetTotemPosition(self.element)
                --[[ TotemTimers.ResetRange(self.element)
                self.timer:SetOutOfRange(false)
                if TotemData[totem].noRangeCheck then
                    self.rangeCount:SetText("")
                else TotemTimers.ResetRange(self.element)
                    self.rangeCount:SetText("")
                end --]]
            else
                --[[ TotemTimers.ResetRange(self.element)
                self.rangeCount:SetText("") --]]
                if self.timer.timers[1] > 0 then 
                    self.timer:Stop(1)
                end
    		end
    	end
    elseif event == "SPELL_UPDATE_COOLDOWN" then -- SPELL_UPDATE_COOLDOWN
        local spell = self:GetAttribute("*spell1")
        if spell and (not self.timer.timerOnButton or self.timer.timers[1] <= 0) then
            local start, duration, enable = GetSpellCooldown(spell)
            if start and duration then CooldownFrame_Set(self.cooldown, GetSpellCooldown(spell)) end
        end
        if settings.ShowCooldowns then
            for nr, spell in pairs(Cooldowns[self.timer.nr]) do
                if TotemTimers.AvailableSpells[spell] then
                    local start, duration, enable = GetSpellCooldown(spell)
					if not start and not duration then
						self.timer:stop(nr)
						return
			        end
                    if duration == 0 then
                        self.timer:Stop(nr)
                    elseif duration > 2 then --and self.timer.timers[nr]<=0 then  -- update running cooldown timers for Ele T12-2pc
                        self.timer:Start(nr,start+duration-floor(GetTime()),duration)
                        self.timer.timerBars[nr].icon:SetTexture(TotemTimers.SpellTextures[spell])
                    end
                elseif self.timer.timers[nr] > 0 then
                    self.timer:Stop(nr)
                end 
            end
        else
            for i = 2, self.timer.nrOfTimers do
                self.timer:Stop(i)
            end
        end
    elseif (event == "UNIT_SPELLCAST_SUCCEEDED" and arg1 == "player" and arg2 == TotemicCall)
        or event == "PLAYER_ENTERING_WORLD" then
        self.timer.StopQuiet = true
        self.timer:Stop(1)
        --self.rangeCount:SetText("")
    end
end


local ButtonPositions = {
	["box"] = {{"CENTER",0,"CENTER"},{"LEFT",1,"RIGHT"},{"TOP",2,"BOTTOM"},{"LEFT",1,"RIGHT"}},
	["horizontal"] = {{"CENTER",0,"CENTER"},{"LEFT",1,"RIGHT"},{"LEFT",1,"RIGHT"},{"LEFT",1,"RIGHT"}},
	["vertical"] = {{"CENTER",0,"CENTER"},{"TOP",1,"BOTTOM"},{"TOP",1,"BOTTOM"},{"TOP",1,"BOTTOM"}}	
}


function TotemTimers.OrderTimers()
	if InCombatLockdown() then return end
	local Timers = XiTimers.timers
	local Settings = TotemTimers.ActiveProfile
	for e=1,4 do
		Timers[e]:ClearAnchors()
		Timers[e].button:ClearAllPoints()
	end
    local c = 0
    local pos = {}
	for e=1,4 do
        if Timers[e].active then
            c = c + 1
            Timers[e].actnr = c
            local arrange = Settings.Arrange
            if arrange ~= "free" then
                if c == 1 then
                    Timers[e]:SetPoint(ButtonPositions[arrange][1][1], TotemTimersFrame, ButtonPositions[arrange][1][3])
                else
                    Timers[e]:Anchor(pos[c-ButtonPositions[arrange][c][2]], ButtonPositions[arrange][c][1])
                end
                Timers[e].savePos = false
            else
                local pos = TotemTimers.ActiveProfile.TimerPositions[Timers[e].nr]
                if not pos or not pos[1] then pos = {"CENTER", "UIParent", "CENTER", 0,0} end
                Timers[e].button:ClearAllPoints()
                Timers[e].button:SetPoint(pos[1], pos[2], pos[3], pos[4], pos[5])
                Timers[e].savePos = true
            end
            pos[c] = Timers[e]
		end
	end
end


local BarMiniIconPos = {
    ["horizontal"] = {{"BOTTOMLEFT","TOPLEFT"}, {"BOTTOM", "TOP"}, {"BOTTOMRIGHT", "TOPRIGHT"},},
    ["vertical"] = {{"TOPRIGHT", "TOPLEFT"}, {"RIGHT", "LEFT"}, {"BOTTOMRIGHT", "BOTTOMLEFT"},},
}


function TotemTimers.CreateCastButtons()
    for i = 1,4 do 
        TTActionBars:new(7, XiTimers.timers[i].button, _G["TotemTimers_CastBar"..i], TotemTimersFrame)
        for j = 1,7 do
            local button = _G["TT_ActionButton"..i..j]
            XiTimers.timers[i].button:SetFrameRef("f"..j, button)
            button.ChangeTotemOrder = function(self,_,_,totem1)
			if InCombatLockdown() then return end
                    --_, totem1 = GetSpellBookItemInfo(totem1, BOOKTYPE_SPELL)
                    local totem2 = self:GetAttribute("spellid")
                    local nr = self:GetParent().element
                    if nr and totem1 and totem2 and TotemData[totem1].element == TotemData[totem2].element then
                        local Order = TotemTimers.ActiveProfile.TotemOrder[nr]
                        local pos1, pos2 = 0,0
                        for i=1,#TotemTimers.ActiveProfile.TotemOrder[nr] do
                            if Order[i] == totem1 then pos1 = i end
                            if Order[i] == totem2 then pos2 = i end
                        end
						pos1 = pos1 or #TotemTimers.ActiveProfile.TotemOrder + 1
						pos2 = pos2 or #TotemTimers.ActiveProfile.TotemOrder + 1
                        if pos1 > 0 and pos2 > 0 then
							Order[pos1] = totem2
							Order[pos2] = totem1
                            --Order[pos1],Order[pos2] = Order[pos2],Order[pos1]
                            TotemTimers.SetCastButtonSpells()
                        end
                    end
                end
				
			button:SetAttribute("SpellIDs", TotemTimers.NameToSpellID)

            button:SetAttribute("_ondragstart",[[if IsShiftKeyDown() and self:GetAttribute("*spell1")~=0 then
                                                                            return "spell", self:GetAttribute("spellid")
                                                                       else control:CallMethod("StartBarDrag") end]])
            button:SetAttribute("_onreceivedrag",[[ if kind == "spell" then
                                                                            control:CallMethod("ChangeTotemOrder", value, ...)
                                                                            return "clear"
                                                                       end]])
        end
    end
    TotemTimers.PositionCastButtons()
    TotemTimers.SetCastButtonSpells()
end


local TotemCastPositions = {
    ["LEFT"] = {[1] = "BOTTOMRIGHT", [2] = "TOPRIGHT"},
    ["RIGHT"] = {[1] = "BOTTOMLEFT", [2] = "TOPLEFT"},
    ["TOP"] = {[1] = "BOTTOMRIGHT", [2] = "BOTTOMLEFT"},
    ["BOTTOM"] = {[1] = "TOPRIGHT", [2] = "TOPLEFT"},
}

function TotemTimers.PositionCastButtons()
    local Profile = TotemTimers.ActiveProfile
    for i = 1,4 do
        TTActionBars.bars[i]:SetDirection(Profile.CastBarDirection, Profile.Arrange)
    end
    
    -- and position totem cast buttons
    local pos = Profile.CastButtonPosition
    if Profile.Arrange == "horizontal" then
        if pos ~= "TOP" and pos ~= "BOTTOM" then
            local dir = TTActionBars.bars[1]:CalcDirection(Profile.CastBarDirection, Profile.Arrange)
            if dir == "down" then
                pos = "TOP"
            else
                pos = "BOTTOM"
            end
        end
    elseif Profile.Arrange == "vertical" then        
        if pos ~= "LEFT" and pos ~= "RIGHT" then
            local dir = TTActionBars.bars[1]:CalcDirection(Profile.CastBarDirection, Profile.Arrange)
            if dir == "left" then
                pos = "RIGHT"
            else
                pos = "LEFT"
            end
        end
    end
end



local SpellArray = {}


function TotemTimers.SetCastButtonSpells()
    local Profile = TotemTimers.ActiveProfile
	for i = 1,4 do
        local timer = XiTimers.timers[i]
        wipe(SpellArray)
        for k,v in pairs(Profile.TotemOrder[timer.nr]) do
            if TotemTimers.AvailableSpells[v] and not Profile.HiddenTotems[v] then
                table.insert(SpellArray, v)
            end
        end
        TTActionBars.bars[timer.nr]:SetSpells(SpellArray, true)
	end
end
