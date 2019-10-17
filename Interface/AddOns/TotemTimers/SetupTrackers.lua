-- Copyright © 2008 - 2012 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.
-- Current distribution permissions only include curse.com, wowinterface.com and their respective addon updaters

if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers")

local Timers = XiTimers.timers
local SpellNames = TotemTimers.SpellNames
local SpellIDs = TotemTimers.SpellIDs
local SpellTextures = TotemTimers.SpellTextures
local AvailableSpells = TotemTimers.AvailableSpells

local earthShieldTarget = nil

local playerName = UnitName("player")

local buttons = {"LeftButton", "RightButton", "MiddleButton", "Button4"}

local function splitString(ustring)
    local c = 0
    local s = ""
    for uchar in string.gmatch(ustring, "([%z\1-\127\194-\244][\128-\191]*)") do
        c = c + 1
        s = s..uchar
        if c == 4 then break end
    end
    return s
end

function TotemTimers.CreateTrackers()
	-- ankh tracker
	local ankh = XiTimers:new(1)
	ankh.button:SetScript("OnEvent", TotemTimers.AnkhEvent)
	ankh.button.icons[1]:SetTexture(SpellTextures[SpellIDs.Ankh])
	ankh.events[1] = "SPELL_UPDATE_COOLDOWN"
	ankh.button.anchorframe = TotemTimers_TrackerFrame
	ankh.showCooldown = true
	ankh.dontAlpha = true
	ankh.button.icons[1]:SetAlpha(1)
	ankh.timeStyle = "blizz"
	ankh.Activate = function(self) 
        XiTimers.Activate(self) 
        TotemTimers.AnkhEvent(ankh.button, "SPELL_UPDATE_COOLDOWN")
        TotemTimers.ProcessSetting("TimerSize")
    end
	ankh.button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    ankh.Deactivate = function(self)
        XiTimers.Deactivate(self)
        TotemTimers.ProcessSetting("TimerSize")
    end
    ankh.button.cooldown.noCooldownCount = true
    ankh.button.cooldown.noOCC = true
		
	local shield = XiTimers:new(1)
	shield.button.icons[1]:SetTexture(SpellTextures[SpellIDs.LightningShield])
	shield.button.anchorframe = TotemTimers_TrackerFrame
	shield.button:SetScript("OnEvent", TotemTimers.ShieldEvent)
	shield.events[1] = "UNIT_SPELLCAST_SUCCEEDED"
	shield.events[2] = "UNIT_AURA"
	shield.timeStyle = "blizz"
	shield.Activate = function(self)
        XiTimers.Activate(self)
        TotemTimers.ShieldEvent(self.button, "UNIT_AURA")
        if not TotemTimers.ActiveProfile.ShieldTracker then
            self.button:Hide()
        end
      end
	shield.button:SetAttribute("*type*", "spell")
    shield.button:SetAttribute("*unit*", "player")
	shield.button:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
    shield.button:SetAttribute("*spell1", SpellNames[SpellIDs.LightningShield])
    shield.button:SetScript("OnDragStop", function(self)
        XiTimers.StopMoving(self)
    end)
    ankh.button:SetScript("OnDragStop", function(self)
        XiTimers.StopMoving(self)
    end)

    local earthshield = XiTimers:new(1) -- unused for classis, but necessary
    local weapon = XiTimers:new(1)

    weapon.button.icons[1]:SetTexture(SpellTextures[SpellIDs.RockbiterWeapon])
    weapon.button.anchorframe = TotemTimers_TrackerFrame
    weapon.button:SetScript("OnEvent", TotemTimers.WeaponEvent)
    --weapon.events[1] = "COMBAT_LOG_EVENT_UNFILTERED"
    --weapon.events[2] = "UNIT_INVENTORY_CHANGED"
    --weapon.events[3] = "CHARACTER_POINTS_CHANGED"
    weapon.events[5] = "UNIT_SPELLCAST_SUCCEEDED"
    -- weapon.events[6] = "UNIT_AURA"
    --weapon.events[7] = "PLAYER_TALENT_UPDATE"
    weapon.timeStyle = "blizz"
    weapon.button:SetAttribute("*type*", "spell")
    weapon.button:SetAttribute("ctrl-spell1", ATTRIBUTE_NOOP)
    weapon.button:RegisterEvent("PLAYER_ALIVE")
    weapon.Update = TotemTimers.WeaponUpdate
    weapon.button:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
    weapon.timerBars[1]:SetMinMaxValues(0,1800)
    weapon.flashall = true
    weapon.Activate = function(self)
        XiTimers.Activate(self)
        if not TotemTimers.ActiveProfile.WeaponTracker then self.button:Hide() end
    end

    weapon.button.HideTooltip =  TotemTimers.HideTooltip
    WeaponBar = TTActionBars:new(7, weapon.button, nil, TotemTimers_TrackerFrame, "weapontimer")
    weapon.bar = WeaponBar
    weapon.button.ShowTooltip = TotemTimers.WeaponButtonTooltip
    weapon.button.SaveLastEnchant = function(self, name)
        if name == "spell1" then TotemTimers.ActiveProfile.LastWeaponEnchant = self:GetAttribute("spell1")
        elseif name == "spell2" or name == "spell3" then
            TotemTimers.ActiveProfile.LastWeaponEnchant2 = self:GetAttribute("spell2") or self:GetAttribute("spell3")
        elseif name == "doublespell2" then
            local ds2 = self:GetAttribute("doublespell2")
            if ds2 then
                if ds2 == SpellNames[SpellIDs.FlametongueWeapon] then
                    TotemTimers.ActiveProfile.LastWeaponEnchant = 5
                elseif ds2 == SpellNames[SpellIDs.FrostbrandWeapon] then
                    TotemTimers.ActiveProfile.LastWeaponEnchant = 6
                end
            end
        end
    end
    weapon.button:SetAttribute("_onattributechanged", [[ if name=="hide" then
                                                             control:ChildUpdate("show", false)
                                                             control:CallMethod("HideTooltip")
                                                         elseif name == "spell1" or name == "doublespell1" or name == "doublespell2" or name == "spell2" or name == "spell3"then
                                                             control:CallMethod("SaveLastEnchant", name)
                                                         elseif name == "state-invehicle" then
                                                            if value == "show" and self:GetAttribute("active") then
                                                                self:Show()
                                                            else
                                                                self:Hide()
                                                            end
                                                         end]])
    weapon.button:SetAttribute("_onenter", [[ if self:GetAttribute("tooltip") then control:CallMethod("ShowTooltip") end
                                              if self:GetAttribute("OpenMenu") == "mouseover" then
                                                  control:ChildUpdate("show", true)
                                              end ]])
    weapon.button:SetAttribute("_onleave", [[ control:CallMethod("HideTooltip") ]])
    weapon.button:WrapScript(weapon.button, "OnClick", [[ if button == self:GetAttribute("OpenMenu") then
                                                              local open = self:GetAttribute("open")
                                                              control:ChildUpdate("show", not open)
															  self:SetAttribute("open", not open)
                                                          end]])
    weapon.button:WrapScript(weapon.button, "PostClick", [[ if button == "LeftButton" then
                                                                local ds1 = self:GetAttribute("doublespell1")
                                                                if ds1 then
                                                                    if IsControlKeyDown() or self:GetAttribute("ds") ~= 1 then
                                                                        self:SetAttribute("macrotext", "/cast "..ds1.."\n/use 16")
																		self:SetAttribute("ds",1)
                                                                    else
                                                                        self:SetAttribute("macrotext", "/cast "..self:GetAttribute("doublespell2").."\n/use 17")
																		self:SetAttribute("ds",2)
                                                                    end
                                                                end
                                                           end]])

    weapon.button:SetAttribute("ctrl-type1", "cancelaura")
    weapon.button:SetAttribute("ctrl-target-slot1", GetInventorySlotInfo("MainHandSlot"))
    weapon.button:SetAttribute("ctrl-type2", "cancelaura")
    weapon.button:SetAttribute("ctrl-target-slot2", GetInventorySlotInfo("SecondaryHandSlot"))
    weapon.button:SetScript("OnDragStop", function(self)
        XiTimers.StopMoving(self)
        if not InCombatLockdown() then self:SetAttribute("hide", true) end
        TotemTimers.ProcessSetting("WeaponBarDirection")
    end)
    weapon.nobars = true
    weapon.Stop = function(self,timer)
        XiTimers.Stop(self,timer)
        self.button.bar:Show()
    end
    weapon.button.bar:Show()
    weapon.button.bar:SetStatusBarColor(0.7,1,0.7,0.7)

    weapon.Start = function(self, ...)
        XiTimers.Start(self, ...)
        self.running = 1
    end
    weapon.Stop = function(self, ...)
        XiTimers.Stop(self, ...)
        self.running = 1
    end
    weapon.running = 1
end

local AnkhName = SpellNames[SpellIDs.Ankh]
local AnkhID = SpellIDs.Ankh

function TotemTimers.AnkhEvent(self, event)
	if not AvailableSpells[SpellIDs.Ankh] then return end
    local start, duration, enable = GetSpellCooldown(AnkhID)
    if duration == 0 then
        self.timer:Stop(1)
    elseif self.timer.timers[1]<=0 and duration>2 then
        self.timer:Start(1,start+duration-floor(GetTime()),1800)
    end
end

--local shieldtable = {SpellNames[SpellIDs.LightningShield], SpellNames[SpellIDs.WaterShield], SpellNames[SpellIDs.EarthShield]}
local LightningShield = SpellNames[SpellIDs.LightningShield]
local ShieldChargesOnly = false

function TotemTimers.ShieldEvent(self, event, unit)
	if event=="UNIT_SPELLCAST_SUCCEEDED" and unit=="player" then
		local start, duration, enable = GetSpellCooldown(SpellIDs.LightningShield)
		if start and duration and (not self.timer.timerOnButton or self.timer.timers[1]<=0) then
            CooldownFrame_Set(self.cooldown, start, duration, enable)
        end
	elseif unit=="player" then
		self.count:SetText("")
		local name, texture, count, duration, endtime
        local hasBuff = false
        for i=1,40 do
            name,texture,count,_,duration,endtime = UnitBuff("player", i)
            if name == LightningShield then
                hasBuff = true
                local timeleft = endtime - GetTime()
                if name ~= self.shield or timeleft>self.timer.timers[1] then
                    self.icons[1]:SetTexture(texture)
                    self.timer.expirationMsgs[1] = "Shield"
                    self.timer.earlyExpirationMsgs[1] = "Shield"
                    self.timer.warningIcons[1] = texture
                    self.timer.warningSpells[1] = name
                    self.shield = name
                    if not ShieldChargesOnly then
                        self.timer:Start(1, timeleft, duration)
                    else
                        self.timer:Start(1, count, 3)
                    end
                end
                if not ShieldChargesOnly then
                    if count and count > 0 then
                        self.count:SetText(count)
                    else
                        self.count:SetText("")
                    end
                end
                break
            end
        end
		if not hasBuff and self.timer.timers[1]>0 then
			self.timer:Stop(1)
		end
	end  
end

local function EmptyUpdate() end

function TotemTimers.SetShieldUpdate()
    ShieldChargesOnly = TotemTimers.ActiveProfile.ShieldChargesOnly
    if ShieldChargesOnly then
        Timers[6].Update = EmptyUpdate
        Timers[6].prohibitCooldown = true
        Timers[6].timeStyle = "sec"
        Timers[6].button.count:SetText("")
    else
        Timers[6].Update = nil
        Timers[6].prohibitCooldown = false
        Timers[6].timeStyle = TotemTimers.ActiveProfile.TimeStyle --"blizz"
    end
    TotemTimers.ShieldEvent(Timers[6].button, "UNIT_AURA", "player")
end



local ButtonPositions = {
	["box"] = {{"CENTER",0,"CENTER"},{"LEFT",1,"RIGHT"},{"TOP",2,"BOTTOM"},{"LEFT",1,"RIGHT"}},
	["horizontal"] = {{"CENTER",0,"CENTER"},{"LEFT",1,"RIGHT"},{"LEFT",1,"RIGHT"},{"LEFT",1,"RIGHT"}},
	["vertical"] = {{"CENTER",0,"CENTER"},{"TOP",1,"BOTTOM"},{"TOP",1,"BOTTOM"},{"TOP",1,"BOTTOM"}}	
}

local TrackerOptions = {
    [5] = "AnkhTracker",
    [6] = "ShieldTracker",
}

function TotemTimers.OrderTrackers()
	local arrange = TotemTimers.ActiveProfile.TrackerArrange
    for e=5,8 do
		Timers[e]:ClearAnchors()
		Timers[e].button:ClearAllPoints()
	end
    if arrange == "free" then
        for i=5,6 do
            Timers[i].savePos = true
            local pos = TotemTimers.ActiveProfile.TimerPositions[i]            
            if not pos or not pos[1] then pos = {"CENTER", "UIParent", "CENTER", 0,0} end
            Timers[i].button:ClearAllPoints()
            Timers[i].button:SetPoint(pos[1], pos[2], pos[3], pos[4], pos[5])
        end
    else
    	local counter = 0
    	local buttons = {}
    	for i=5,8 do
            Timers[i].savePos = false
    		--if Timers[i].active then
            if Timers[i].button:IsVisible() then
    			counter = counter + 1
    			if counter == 1 then
    				Timers[i]:SetPoint(ButtonPositions[arrange][1][1], TotemTimers_TrackerFrame, ButtonPositions[arrange][1][3])
    			else
    				Timers[i]:Anchor(buttons[counter-ButtonPositions[arrange][counter][2]], ButtonPositions[arrange][counter][1])	
    			end
    			buttons[counter] = Timers[i]
    		end
    	end
    end
end



function TotemTimers.SetWeaponTrackerSpells()
    WeaponBar:ResetSpells()
    if  AvailableSpells[SpellIDs.WindfuryWeapon] then
        WeaponBar:AddSpell(SpellNames[SpellIDs.WindfuryWeapon])
    end
    if AvailableSpells[SpellIDs.RockbiterWeapon] then
        WeaponBar:AddSpell(SpellNames[SpellIDs.RockbiterWeapon])
    end
    if  AvailableSpells[SpellIDs.FlametongueWeapon] then
        WeaponBar:AddSpell(SpellNames[SpellIDs.FlametongueWeapon])
    end
    if  AvailableSpells[SpellIDs.FrostbrandWeapon] then
        WeaponBar:AddSpell(SpellNames[SpellIDs.FrostbrandWeapon])
    end

   --[[ if  AvailableSpells[SpellIDs.WindfuryWeapon] and AvailableSpells[SpellIDs.FlametongueWeapon] then
        WeaponBar:AddDoubleSpell(SpellNames[SpellIDs.WindfuryWeapon],SpellNames[SpellIDs.FlametongueWeapon])
    end
    if  AvailableSpells[SpellIDs.WindfuryWeapon] and AvailableSpells[SpellIDs.FrostbrandWeapon] then
        WeaponBar:AddDoubleSpell(SpellNames[SpellIDs.WindfuryWeapon],SpellNames[SpellIDs.FrostbrandWeapon])
    end --]]
end

local mainMsg = ""
local offMsg = ""

local GetWeaponEnchantInfo = GetWeaponEnchantInfo

local Enchanted, CastEnchant, CastTexture


local function SetWeaponEnchantTextureAndMsg(self, enchant, texture, nr)
    if nr == 1 then TotemTimers.ActiveProfile.LastMainEnchants[mainHandWeapon] = {enchant, texture}
    else TotemTimers.ActiveProfile.LastOffEnchants[offHandWeapon] = {enchant, texture} end
    self.icons[nr]:SetTexture(texture)
    self.timer.warningIcons[nr] = texture
    self.timer.warningSpells[nr] = enchant
    self.timer.expirationMsgs[nr] = "Weapon"
end

function TotemTimers.WeaponUpdate(self, elapsed)
    local enchant, expiration = GetWeaponEnchantInfo()
    if enchant then
        if expiration/1000 > self.timers[1] then
            self:Start(1, expiration/1000, 300)
            if Enchanted then
                Enchanted = nil
                SetWeaponEnchantTextureAndMsg(self.button, CastEnchant, CastTexture, 1)
            end
        end
        if expiration == 0 then
            self:Stop(1)
        else
            self.timers[1] = expiration/1000
        end
    elseif self.timers[1] > 0 then
        self:Stop(1)
    end
    XiTimers.Update(self, 0)
end

local function getWeapons()
    lastMhWeapon = mainHandWeapon
    mainHandWeapon = GetInventoryItemLink("player", 16)
    if mainHandWeapon then  mainHandWeapon = tonumber(select(3,string.find(mainHandWeapon, "item:(%d+):"))) else mainHandWeapon = 0 end
    TotemTimers.MainHand = mainHandWeapon
end


-- local lastMaelstromCount = 0
local WeaponBuffs = {SpellNames[SpellIDs.WindfuryWeapon], SpellNames[SpellIDs.RockbiterWeapon],
                     SpellNames[SpellIDs.FlametongueWeapon], SpellNames[SpellIDs.FrostbrandWeapon], SpellNames[SpellIDs.EarthlivingWeapon]}
local lastWeaponBuffCast

function TotemTimers.WeaponEvent(self, event, ...)
    --[[if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local _,eventtype,_,_,_,_,_,_,name,_,_,enchant,weapon = ...
        if eventtype == "ENCHANT_APPLIED" and name == playerName and enchant then
            print(enchant, weapon)
            getWeapons()
            CastEnchant = enchant
            if lastWeaponBuffCast then
                CastTexture = GetSpellTexture(lastWeaponBuffCast)
            end
            lastWeaponBuffCast = nil
            if not CastTexture then
                CastTexture = select(10,GetItemInfo(enchant))
                if not CastTexture then CastTexture = select(10, GetItemInfo(weapon)) end
            end
            Enchanted = true
        end
    elseif event == "UNIT_INVENTORY_CHANGED" then
        getWeapons()
        if mainHandWeapon ~= lastMhWeapon and mainHandWeapon ~= 0 then
            local enchant, texture
            if not TotemTimers.ActiveProfile.LastMainEnchants[mainHandWeapon] then
                enchant = ""
                texture = SpellTextures[SpellIDs.RockbiterWeapon]
            else
                enchant = TotemTimers.ActiveProfile.LastMainEnchants[mainHandWeapon][1]
                texture = TotemTimers.ActiveProfile.LastMainEnchants[mainHandWeapon][2]
            end
            SetWeaponEnchantTextureAndMsg(self, enchant, texture, 1)
        end ]]
    --[[ elseif event == "CHARACTER_POINTS_CHANGED" or event == "PLAYER_ALIVE" or event == "PLAYER_TALENT_UPDATE" then
        TotemTimers.SetNumWeaponTimers()
        if event == "PLAYER_ALIVE" then
            Timers[8].button:UnregisterEvent("PLAYER_ALIVE")
        end --]]
    --else
    if event == "UNIT_SPELLCAST_SUCCEEDED" and select(1,...) == "player" then
        local spell = select(3, ...)
        local spellName = GetSpellInfo(spell)
        for k,v in pairs(WeaponBuffs) do
            if v == spellName then
                getWeapons()
                lastWeaponBuffCast = v
                CastTexture = GetSpellTexture(lastWeaponBuffCast)
                CastEnchant = spellName
                Enchanted = true
                break
            end
        end
        local start, duration, enable = GetSpellCooldown(SpellNames[SpellIDs.RockbiterWeapon])
        if start and duration and (not self.timer.timerOnButton or self.timer.timers[1]<=0) then
            CooldownFrame_Set(self.cooldown, start, duration, enable)
        end
    --[[ elseif event == "UNIT_AURA" and select(1,...) == "player" then
        local name,_,_,count,_,duration,endtime = UnitBuff("player", SpellNames[SpellIDs.Maelstrom])
        self.bar:SetValue(count or 0)
        self.count:SetText(tostring(count or ""))
        if count == 5 and lastMaelstromCount ~= 5 then
            self.timer:PlayWarning("Maelstrom")
        end
        lastMaelstromCount = count or lastMaelstromCount --]]
    end
end