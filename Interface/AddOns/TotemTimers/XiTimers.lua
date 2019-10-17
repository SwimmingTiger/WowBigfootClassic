-- Copyright © 2008-2014 Xianghar
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.


if select(2,UnitClass("player")) ~= "SHAMAN" then return end

if not XiTimers then 
    XiTimers = {}
    XiTimers.version = 200
end

XiTimers.timers = {}
XiTimers.nrOfTimers = 0
XiTimers.__index = XiTimers
XiTimers.updateInterval = 0

local inActiveAlpha = 0.4


local XiTimers = XiTimers
local Timers = XiTimers.timers
local _G = getfenv()

local incombat = false


local function FormatTime(frame, sec, format)
	local seconds = floor(sec)

 	if format == "blizz" then
		frame:SetFormattedText(SecondsToTimeAbbrev(sec))
    elseif format == "sec" then
        seconds = floor(sec+0.5)
        if seconds == 0 then seconds = "" end
        frame:SetFormattedText(tostring(seconds))
	else
		if(seconds <= 0) then
			frame:SetText("")
		elseif seconds < 600 then
			local d, h, m, s = ChatFrame_TimeBreakDown(seconds)
			frame:SetFormattedText("%01d:%02d", m, s)
		elseif(seconds < 3600) then
			local d, h, m, s = ChatFrame_TimeBreakDown(seconds);
			frame:SetFormattedText("%02d:%02d", m, s)
		else
			frame:SetText("1 hr+")
		end
	end
end


local function SetButtonTime(fontstring, sec, format)
    if sec > 600 then
        FormatTime(fontstring, sec, "blizz")
    elseif sec > 60 then
        FormatTime(fontstring, sec, format)
    else
        FormatTime(fontstring, sec, "sec")
    end
end


local nextUpdate = 0

function XiTimers.UpdateTimers(self,elapsed) 
    if XiTimers.updateInterval > 0 then nextUpdate = nextUpdate + elapsed end
    if nextUpdate >= XiTimers.updateInterval then
        nextUpdate = nextUpdate - XiTimers.updateInterval
        for i=1,XiTimers.nrOfTimers do
            if Timers[i].active and Timers[i].running > 0 then Timers[i]:Update(elapsed) end
        end        
    end
end


function XiTimers:new(nroftimers, unclickable)
	local self = {}
	setmetatable(self, XiTimers)
	XiTimers.nrOfTimers = XiTimers.nrOfTimers + 1
    self.nr = XiTimers.nrOfTimers
	self.active = false
	self.running = 0
	self.timersRunning = {}
    self.unclickable = unclickable
	
	if unclickable then
        self.button = CreateFrame("CheckButton", "XiTimers_Timer"..XiTimers.nrOfTimers, UIParent, "XiTimersUnsecureTemplate")
    else
        self.button = CreateFrame("CheckButton", "XiTimers_Timer"..XiTimers.nrOfTimers, UIParent, "XiTimersTemplate")
		RegisterStateDriver(self.button, "petbattle", "[petbattle][overridebar][possessbar] active; none")
		RegisterStateDriver(self.button, "combat", "[combat] active; none")
		self.button:WrapScript(self.button, "OnAttributeChanged", [[
			if not self:GetAttribute("active") then return end
			if name == "state-petbattle" then
				if value == "active" then
					self:Hide()
				elseif not self:GetAttribute("HideOOC") then
					self:Show()
				end
			elseif name == "state-combat" then
				if value == "active" then
					self:Show()
				elseif self:GetAttribute("HideOOC") then
					self:Hide()
				end
			end
		]])
    end
	self.button:SetPoint("CENTER", UIParent, "CENTER")
	self.button.timer = self
	
	--for rActionButtonStyler
	self.button.action = 0 
    self.button:SetCheckedTexture(nil)
	self.button.SetCheckedTexture = function() end
    self.button.SetChecked = function() end
    self.button.GetChecked = function() return false end
    self.button.SetDisabledCheckedTexture = function() end
    
	self.button.unclickable = unclickable
	self.button.element = XiTimers.nrOfTimers
    
	
	self.nrOfTimers = nroftimers
	self.timers = {}
    self.durations = {}
    for i=1, nroftimers do self.timers[i] = 0 end
    self.barTimer = 0
    self.barDuration = 0
	self.timerBars = {}
	self.button.icons = {}
	self.button.flash = {}
	for i=1,nroftimers do
		self.timers[i] = 0
		self.timerBars[i] = CreateFrame("StatusBar", "XiTimers_TimerBar"..XiTimers.nrOfTimers.."_"..i, self.button, "XiTimersTimerBarTemplate")
        self.timerBars[i].background = _G["XiTimers_TimerBar"..XiTimers.nrOfTimers.."_"..i.."Background"]
        self.timerBars[i].time = _G["XiTimers_TimerBar"..XiTimers.nrOfTimers.."_"..i.."Time"]
        self.timerBars[i].icon = _G["XiTimers_TimerBar"..XiTimers.nrOfTimers.."_"..i.."Icon"]
        self.timerBars[i]:SetPoint("TOP", self.button, "BOTTOM")
		self.button.icons[i] = _G["XiTimers_Timer"..XiTimers.nrOfTimers.."Icon"..((i>1) and i or "")]
		self.button.flash[i] = _G["XiTimers_Timer"..XiTimers.nrOfTimers.."Flash"..((i>1) and i or "")]
        if self.button.flash[i] then
            local flash = self.button.flash[i]
            flash.animation = self.button.flash[i]:CreateAnimationGroup()
            flash.animation:SetLooping("NONE")
            flash.flashAnim = flash.animation:CreateAnimation()
            flash.flashAnim:SetDuration(15)
            flash.flashAnim.flash = flash
            flash.flashAnim:SetScript("OnPlay", function(self) self.flash:Show() end)
            flash.flashAnim:SetScript("OnFinished", function(self) self.flash:Hide() end)
            flash.flashAnim:SetScript("OnStop", function(self) self.flash:Hide() end)
            flash.flashAnim:SetScript("OnUpdate", function(self) self.flash:SetAlpha(BuffFrame.BuffAlphaValue) end)
        end
        if self.button.icons[i] then
            local flash = self.button.icons[i]
            flash.animation = self.button.flash[i]:CreateAnimationGroup()
            flash.animation:SetLooping("NONE")
            flash.flashAnim = flash.animation:CreateAnimation()
            flash.flashAnim:SetDuration(15)
            flash.flashAnim.flash = flash
            flash.flashAnim:SetScript("OnPlay", function(self) self.flash:Show() end)
            flash.flashAnim:SetScript("OnUpdate", function(self) self.flash:SetAlpha(BuffFrame.BuffAlphaValue) end)
			flash.flashAnim:SetScript("OnStop", function(self) self.flash:SetAlpha(inActiveAlpha) end)
			flash.flashAnim:SetScript("OnFinished", function(self) self.flash:SetAlpha(inActiveAlpha) end)
        end
		self:SetIconAlpha(self.button.icons[i], 0.4)
	end
    
    
    self.timeColor = {r=1,g=1,b=1}
	self.button.icons[1]:Show()
	self.timerBarPos = "BOTTOM"
	self.timeSpacing = 0
	self.spacing = 5
	self.timeStyle = "mm:ss"
    self.OOCAlpha = 1
	self.maxAlpha = 1
	self.warningMsgs = {}
    self.warningSpells = {}
	self.expirationMsgs = {}
	self.earlyExpirationMsgs = {}
    self.warningIcons = {}
	self.events = {}
	self.playerEvents = {}
	self.button.count = _G["XiTimers_Timer"..XiTimers.nrOfTimers.."Count"]
	self.button.cooldown = _G["XiTimers_Timer"..XiTimers.nrOfTimers.."Cooldown"]
	self.button.cooldown:SetSwipeColor(0, 0, 0)
	self.button.cooldown:SetHideCountdownNumbers(true)
	self.button.miniIcon = _G["XiTimers_Timer"..XiTimers.nrOfTimers.."MiniIcon"]
    self.button.miniIconFrame = _G["XiTimers_Timer"..XiTimers.nrOfTimers.."Mini"]
    self.button.bar = _G["XiTimers_Timer"..XiTimers.nrOfTimers.."Bar"]
    self.button.hotkey = _G["XiTimers_Timer"..XiTimers.nrOfTimers.."HotKey"]
    self.button.rangeCount = _G["XiTimers_Timer"..XiTimers.nrOfTimers.."RangeCount"]
	self.button.normalTexture = _G["XiTimers_Timer"..XiTimers.nrOfTimers.."NormalTexture"]
    local frame = CreateFrame("Frame", nil, self.button)
    frame:Show()
    frame:SetAllPoints(self.button)
    self.button.time = frame:CreateFontString(self.button:GetName().."Time", 'OVERLAY')
    self.button.time:SetPoint("CENTER",0,1)
    self.button.time:SetFont("Fonts\\FRIZQT__.TTF", 17, "OUTLINE")
    frame:SetFrameLevel(frame:GetFrameLevel()+10)
    self.button.time:Hide()
    --self.button.cooldown:SetFrameLevel(self.button.cooldown:GetFrameLevel()-1)
    self.button.cooldown.noCooldownCount = true
    self.button.cooldown.noOCC = true
    self.rangeCheckCount = 0
    self.manaCheckCount = 0
	self.warningPoint = 10
	
	if not IsAddOnLoaded("rActionButtonStyler") then
		self:HideNormalTexture()
	else
		ActionButton_Update(self.button)
	end
    
    self.animation = XiTimersAnimations:new(self.button)
    
	self.anchors = {}
	self.anchorchilds = {}
	
	--self.button:SetScript("OnDragStart", XiTimers.StartMoving)
	self.button:SetScript("OnDragStop", XiTimers.StopMoving)
    self.button:SetAttribute("_ondragstart", [[control:CallMethod("StartMove")]])
    --self.button:SetAttribute("_ondragstop", [[control:CallMethod("StopMoving")]])
    self.button.StartMove = XiTimers.StartMoving
    self.button.StopMove = XiTimers.StopMoving
	self.button:RegisterForDrag("LeftButton")
    
	table.insert(Timers, self)

    self.button:SetAttribute("_onattributechanged", [[ 
        if name=="state-invehicle" then
            if value == "show" and self:GetAttribute("active") then
                self:Show()
            else
                self:Hide()
            end
        end
        ]])

    self.button:Hide()
	
	return self
end

-- timer functions
local IsSpellInRange = IsSpellInRange
local IsUsableSpell = IsUsableSpell

function XiTimers:Update(elapsed)
	local timers = self.timers
    local button = self.button
	for i=1,self.nrOfTimers do
		if timers[i] > 0 then
			timers[i] = timers[i] - elapsed
			if timers[i] <= 0 then
				self:Stop(i) 
			else
				if timers[i]<self.warningPoint and self.warningMsgs[i] then
					self:PlayWarning(self.warningMsgs[i], self.warningSpells[i], self.warningIcons[i])
					self.warningMsgs[i] = nil
				end
                if not self.hideTime then 
					if i > 1 or not self.timerOnButton or self.forceBar then
						if timers[i] >= 600 then
							FormatTime(self.timerBars[i].time, timers[i], "blizz")
						else
							FormatTime(self.timerBars[i].time, timers[i], self.timeStyle)
						end
					else 
						SetButtonTime(button.time, timers[1], self.timeStyle)
					end
					if self.visibleTimerBars and (not self.timerOnButton or self.forceBar or i>1) then
						self.timerBars[i]:SetValue(timers[i])
					end
				end
                if i == 1 then
                    if not self.isAnimating and timers[i] <= self.warningPoint and timers[i] > 0 then
                        self.isAnimating = true
                        if not self.dontFlash then
                            if self.flashRed and self.button.flash[i] then
								self.button.flash[i].flashAnim:SetDuration(self.warningPoint+2)
                                self.button.flash[i].animation:Play()
                            elseif self.button.icons[i] then
								self.button.icons[i].flashAnim:SetDuration(self.warningPoint+2)
                                self.button.icons[i].animation:Play()
                            end
                        end
                    end
                    if self.nr < 8 and self.timers[1] <= 10 then button.time:SetTextColor(1,0,0) end
                    
                    if self.procFlash and timers[1] > 0 and self.bar then
                        button.bar:SetValue(self.bar - mod(timers[1] + self.barDelay, self.bar))
                        button.bar:Show()
                    end
                end
			end
		end
	end
    
    if self.barTimer > 0 then
        self.barTimer = self.barTimer - elapsed
        button.bar:SetValue(self.barTimer)        
    end 
end


function XiTimers:Activate()
	self.active = true
	for _,event in pairs(self.events) do
		self.button:RegisterEvent(event)
	end
	for _, event in pairs(self.playerEvents) do
		self.button:RegisterUnitEvent(event, "player")
	end
	if not self.hideInactive and (not self.HideOOC or InCombatLockdown()) and not self.ActiveWhileHidden then
        self.button:Show()
    end	
	self.button:SetAttribute("active", true)
	if self.ActiveWhileHidden then self.button:Hide() self.button:SetAttribute("active", false) end
	 if self.rangeCheck or self.manaCheck then
		self:AddRangeCheck()
	end
end

function XiTimers:Deactivate()
	self.active = false
	self.button:UnregisterAllEvents()
	self.button:Hide()
    self.button:SetAttribute("active", false)
	self:RemoveRangeCheck()
end

function XiTimers:Start(timer, time, duration)	
	if not self.timersRunning[timer] then
		self.running = self.running + 1
		self.timersRunning[timer] = true
	end
	if self.button.flash[timer] then self.button.flash[timer].animation:Stop() end
	if self.button.icons[timer] then self.button.icons[timer].animation:Stop() end
	duration = duration or time
    self.durations[timer] = duration
	local timerbar = self.timerBars[timer]
	self.timers[timer] = time
	FormatTime(timerbar.time, time, self.timeStyle)
    FormatTime(self.button.time, time, self.timeStyle)
	timerbar:SetMinMaxValues(0, duration)
    if (timer > 1 and (not self.nobars or (self.nobars and not self.timerOnButton))) then
        self:ShowTimerBar(timer)
    else
        self:HideTimerBar(timer)
    end        
        
	if self.visibleTimerBars and (timer>1 or not self.timerOnButton) then
		timerbar:SetValue(time)
	end
	if not self.dontAlpha then self:SetIconAlpha(self.button.icons[timer], self.maxAlpha) end
    if self.reverseAlpha then self:SetIconAlpha(self.button.icons[timer], 0.4) end
    if timer == 1 then
		self.button.time:Hide()
		if not self.hideTime then
			if not self.timerOnButton or self.forceBar then
				self.button.time:Hide()
				self:ShowTimerBar(timer)
			else 
				self:HideTimerBar(timer)
				self.button.time:Show()
				SetButtonTime(self.button.time, self.timers[1])
				self.button.time:SetTextColor(self.timeColor.r,self.timeColor.g,self.timeColor.b)
			end
		else
			self.button.time:Hide()
			self:HideTimerBar(timer)
		end
        if (self.showCooldown or self.timerOnButton) and not self.prohibitCooldown then
            CooldownFrame_Set(self.button.cooldown, GetTime()-duration+time, duration, 1)
        else
            self.button.cooldown:Hide()
        end
        if self.procFlash then
            self.button.bar:Show()
            self.button.bar:SetValue(0)            
        elseif self.barTimer <= 0 then
            self.button.bar:Hide()
        end
    end
    self.isAnimating = false
    self.flashRed = TotemTimers.ActiveProfile.flashRed
    --self.button.bar:SetValue(0)
    self:SetTimerBarPos(self.timerBarPos, true)
    if timer == 1 and self.hideInactive then
        self.button:Show()
    end
end

function XiTimers:Stop(timer)
	if not self.timersRunning[timer] then return end
	self.running = self.running - 1
	if self.running < 0 then self.running = 0 end
	self.timersRunning[timer] = false
	local timerbar = self.timerBars[timer]
    if not self.stopQuiet then
        if self.timers[timer]>1 then
            if self.earlyExpirationMsgs[timer] then
                self:PlayWarning(self.earlyExpirationMsgs[timer], self.warningSpells[timer], self.warningIcons[timer])
                self.earlyExpirationMsgs[timer] = nil
            end
        elseif self.expirationMsgs[timer] then
            self:PlayWarning(self.expirationMsgs[timer], self.warningSpells[timer], self.warningIcons[timer])
            self.expirationMsgs[timer] = nil
        end
        if self.StopPulse and timer == 1 then
            self.animation:SetTexture(self.button.icons[1]:GetTexture())
            self.animation:Play()
        end
    end
    self.stopQuiet = false
	timerbar.time:SetText("")
	if self.visibleTimerBars then		
		timerbar:SetValue(0)
	end
    self:HideTimerBar(timer)
    if timer == 1 then
        self.button.time:Hide()
        self.button.cooldown:Hide()
    end 
    if not self.dontAlpha then self:SetIconAlpha(self.button.icons[timer], 0.4) end
    if self.reverseAlpha then self:SetIconAlpha(self.button.icons[timer],self.maxAlpha) end
    self.button.bar:Hide()
    self:SetTimerBarPos(self.timerBarPos, true)
    if timer == 1 and self.hideInactive then
        self.button:Hide()
    end
    -- self:SetOutOfRange(false)
	self.timers[timer] = 0
end


function XiTimers:StartBarTimer(time, duration)
    self.barDuration = duration or time
    self.barTimer = time
    self.button.bar:SetMinMaxValues(0, duration)
    self.button.bar:SetValue(time)
    self.button.bar:Show()
end

function XiTimers:StopBarTimer()
    self.barTimer = 0
    self.button.bar:SetValue(0)
    self.button.bar:Hide()
end


function XiTimers:SetOutOfRange(outOfRange)
    self.outOfRange = outOfRange
    self:UpdateButtonColor()
end

function XiTimers:SetOutOfMane(outOfMana)
    self.outOfMana = outOfMana
    self:UpdateButtonColor()
end

function XiTimers:UpdateButtonColor()
    if self.outOfRange then
        self.button.icons[1]:SetVertexColor(1,0,0)
    elseif self.outOfMana then
        self.button.icons[1]:SetVertexColor(0.5,0.5,2)
    else
        self.button.icons[1]:SetVertexColor(1,1,1)
    end
end

function XiTimers:StartMoving()
    if self.timer.locked then return end
	if self.anchorframe and not self.timer.savePos then
		self.anchorframe:StartMoving()
	else
		self:StartMoving() 
	end
end

function XiTimers:StopMoving()
	if self.anchorframe and not self.timer.savePos then
		self.anchorframe:StopMovingOrSizing()
	else
		self:StopMovingOrSizing()
	end
    if XiTimers.SaveFramePositions then XiTimers.SaveFramePositions() end
    self.timer:SetTimerBarPos(self.timer.timerBarPos, true)
end

function XiTimers:SetIconAlpha(icon, alpha)
    if icon then
        icon:SetAlpha(alpha)
    end
end

function XiTimers:SetAlpha(alpha)
    self.button:SetAlpha(alpha)
end

function XiTimers:HideTimerBar(nr)
	self.timerBars[nr].background:Hide()
    self.timerBars[nr].background:SetValue(0)
    ---self.timerBars[nr].icon:Hide()
    self.timerBars[nr]:Hide()
end

function XiTimers:ShowTimerBar(nr)
    self.timerBars[nr]:Show()
	if self.visibleTimerBars then
        self.timerBars[nr].background:Show()
        self.timerBars[nr].background:SetValue(1)
    end
end

-- display functions

function XiTimers:SetTimerBarPos(side, notReanchor)
	self.timerBarPos = side
	
	local TimerBars = self.timerBars
	local nrOfTimers = self.nrOfTimers
		
	for i=1, nrOfTimers do
		TimerBars[i]:ClearAllPoints()
        TimerBars[i].icon:ClearAllPoints()
	end
    if side == "RIGHT" then
        for i=2,nrOfTimers do
            TimerBars[i].icon:SetPoint("LEFT", TimerBars[i], "RIGHT", -4, 0)
        end
    else
        for i=2,nrOfTimers do
            TimerBars[i].icon:SetPoint("RIGHT", TimerBars[i], "LEFT", 4, 0)
        end
    end
    local activetimers = 1
	if side == "LEFT" then
        local lastactive = 1
		for i=2,nrOfTimers do
            TimerBars[i]:SetPoint("TOP", TimerBars[lastactive], "BOTTOM") -- set all, but only active ones will be seen so they can lay atop one another
            if self.timers[i] > 0 then
                lastactive = i
                activetimers = activetimers + 1
            end
		end 
		TimerBars[1]:SetPoint("RIGHT", self.button, "LEFT", -self.timeSpacing, TimerBars[1]:GetHeight()*TimerBars[1]:GetEffectiveScale()/2*(activetimers-1))
	elseif side == "RIGHT" then
        local lastactive = 1
		for i=2,nrOfTimers do
            TimerBars[i]:SetPoint("TOP", TimerBars[lastactive], "BOTTOM")
            if self.timers[i] > 0 then
                lastactive = i
                activetimers = activetimers + 1
            end
		end
		TimerBars[1]:SetPoint("LEFT", self.button, "RIGHT", self.timeSpacing, TimerBars[1]:GetHeight()*TimerBars[1]:GetEffectiveScale()/2*(activetimers-1))
	elseif side == "TOP" then
        if TotemTimers.ActiveProfile.ShowCooldowns and self.nr < 5 and (TotemTimers.ActiveProfile.Arrange == "vertical" or TotemTimers.ActiveProfile.Arrange == "box") then
            TimerBars[1]:SetPoint("BOTTOM", self.button, "TOP", 0, self.timeSpacing)
            local active = 0
            local firstactive = 0
            for i = 2, nrOfTimers do
                if self.timers[i] > 0 then
                    active = active + 1
                    if firstactive == 0 then firstactive = i end
                end
            end
            if active > 0 then
                local left = self.button:GetLeft() < WorldFrame:GetWidth()/2
                if TotemTimers.ActiveProfile.Arrange == "box" and self.actnr then
                    left = self.actnr == 2 or self.actnr == 4
                end
                for i=2, nrOfTimers do
                    TimerBars[i].icon:ClearAllPoints()
                    if left then
                        TimerBars[i].icon:SetPoint("LEFT", TimerBars[i], "RIGHT", -4, 0)
                    else
                        TimerBars[i].icon:SetPoint("RIGHT", TimerBars[i], "LEFT", 4, 0)
                    end
                end
                if left then
                    TimerBars[firstactive]:SetPoint("LEFT", self.button, "RIGHT", 
                        self.timeSpacing, TimerBars[firstactive]:GetHeight()*TimerBars[firstactive]:GetEffectiveScale()/2*(active-1))
                else
                    TimerBars[firstactive]:SetPoint("RIGHT", self.button, "LEFT",
                        -self.timeSpacing, TimerBars[firstactive]:GetHeight()*TimerBars[firstactive]:GetEffectiveScale()/2*(active-1))
                end
                local last = firstactive
                for i = firstactive+1, nrOfTimers do
                    TimerBars[i]:SetPoint("TOP", TimerBars[last], "BOTTOM")
                    if self.timers[i] > 0 then                        
                        last = i
                    end
                end
                for i = 2, firstactive-1 do
                    TimerBars[i]:SetPoint("TOP", self.button, "BOTTOM")
                end
            end
        else
            local lastactive = 1
    		TimerBars[1]:SetPoint("BOTTOM", self.button, "TOP", 0, self.timeSpacing)
    		for i=2, nrOfTimers do
                TimerBars[i]:SetPoint("BOTTOM", TimerBars[lastactive], "TOP")
                if self.timers[i] > 0 then
                    lastactive = i
                end
    		end
        end
	elseif side == "BOTTOM" then
        if TotemTimers.ActiveProfile.ShowCooldowns and self.nr < 5 and (TotemTimers.ActiveProfile.Arrange == "vertical" or TotemTimers.ActiveProfile.Arrange == "box") then
            TimerBars[1]:SetPoint("TOP", self.button, "BOTTOM", 0, -self.timeSpacing)
            local active = 0
            local firstactive = 0
            for i = 2, nrOfTimers do
                if self.timers[i] > 0 then
                    active = active + 1
                    if firstactive == 0 then firstactive = i end
                end
            end
            if active > 0 then
                local left = self.button:GetLeft() < WorldFrame:GetWidth()/2
                if TotemTimers.ActiveProfile.Arrange == "box" and self.actnr then
                    left = self.actnr == 2 or self.actnr == 4
                end
                for i=2, nrOfTimers do
                    TimerBars[i].icon:ClearAllPoints()
                    if left then
                        TimerBars[i].icon:SetPoint("LEFT", TimerBars[i], "RIGHT", -4, 0)
                    else
                        TimerBars[i].icon:SetPoint("RIGHT", TimerBars[i], "LEFT", 4, 0)
                    end
                end
                if left then
                    TimerBars[firstactive]:SetPoint("LEFT", self.button, "RIGHT", 
                        self.timeSpacing, TimerBars[firstactive]:GetHeight()*TimerBars[firstactive]:GetEffectiveScale()/2*(active-1))
                else
                    TimerBars[firstactive]:SetPoint("RIGHT", self.button, "LEFT",
                        -self.timeSpacing, TimerBars[firstactive]:GetHeight()*TimerBars[firstactive]:GetEffectiveScale()/2*(active-1))
                end
                local last = firstactive
                for i = firstactive+1, nrOfTimers do
                    TimerBars[i]:SetPoint("TOP", TimerBars[last], "BOTTOM")
                    if self.timers[i] > 0 then
                        last = i
                    end
                end
                for i = 2, firstactive-1 do
                    TimerBars[i]:SetPoint("TOP", self.button, "BOTTOM")
                end
             end
        else
            local lastactive = 1
    		TimerBars[1]:SetPoint("TOP", self.button, "BOTTOM", 0, -self.timeSpacing)
    		for i=2, nrOfTimers do
                TimerBars[i]:SetPoint("TOP", TimerBars[lastactive], "BOTTOM")
                if self.timers[i] > 0 then
                    lastactive = i
                end
    		end
        end
	end
	if not InCombatLockdown() and not notReanchor then self:Reanchor() end
end

function XiTimers:GetBorder(side)
	local timerBarPos = self.timerBarPos
	if side == "TOP" and timerBarPos == "TOP" or side == "BOTTOM" and timerBarPos == "BOTTOM" then
        local height = self.timerBars[1]:GetHeight()*self.timerBars[1]:GetEffectiveScale()        
        if self.nr > 5 or TotemTimers.ActiveProfile.Arrange == "horizontal" then
            height = height * self.nrOfTimers
        end        
		return (self.timerOnButton and not self.forceBar) and 0 or self.timeSpacing + height
	elseif ((side == "LEFT" and timerBarPos == "LEFT" or side == "RIGHT" and timerBarPos == "RIGHT") and ((self.nrOfTimers>1 and TotemTimers.ActiveProfile.ShowCooldowns) or not self.timerOnButton or self.forceBar))
        or (self.nr < 5 and TotemTimers.ActiveProfile.ShowCooldowns and TotemTimers.ActiveProfile.Arrange == "vertical" and self.nrOfTimers > 1 and 
            ((side == "LEFT" and self.nrOfTimers > 1 and TotemTimersFrame:GetLeft() > WorldFrame:GetWidth()/2)
            or (side == "RIGHT" and self.nrOfTimers > 1 and TotemTimersFrame:GetLeft() < WorldFrame:GetWidth()/2)))
    then
		return (self.timeSpacing + self.timerBars[1]:GetWidth()*self.timerBars[1]:GetEffectiveScale())
	end
	return 0
end


function XiTimers:SetWidth(width)
	self.button:SetWidth(width)
end

function XiTimers:SetHeight(height)
	self.button:SetHeight(height)
end

function XiTimers:SetFont(font)
    for _,timerbar in pairs(self.timerBars) do
        local _,height = timerbar.time:GetFont()
        timerbar.time:SetFont(font, height)
    end
    local _,height = self.button.time:GetFont()
    self.button.time:SetFont(font, height, "OUTLINE")
end

function XiTimers:SetTimeHeight(height)
	for _,timerbar in pairs(self.timerBars) do
		timerbar:SetHeight(height)
		timerbar.background:SetHeight(height)
        local font = timerbar.time:GetFont()
		timerbar.time:SetFont(font, height)
	end
	self:Reanchor()
end

function XiTimers:SetTimeWidth(width)
	for _,timerbar in pairs(self.timerBars) do
		timerbar:SetWidth(width)
		timerbar.background:SetWidth(width)
		timerbar.time:SetWidth(width)
	end
	self:Reanchor()
end

function XiTimers:SetScale(scale)
	self.button:SetScale(scale)
	self:SetTimerBarPos(self.timerBarPos)
	--self:Reanchor()
end

function XiTimers:SetBarTexture(texture)
    for _,bar in pairs(self.timerBars) do
        bar:SetStatusBarTexture(texture)
        bar.background:SetStatusBarTexture(texture)
    end
end

function XiTimers:SetBarColor(r,g,b)
    for _,bar in pairs(self.timerBars) do 
		bar:SetStatusBarColor(r,g,b, 1.0)
        bar.background:SetStatusBarColor(r,g,b,0.4)
    end
end


--allowed position combinations are: CENTER/CENTER, LEFT/RIGHT, RIGHT/LEFT, TOP/BOTTOM, BOTTOM/TOP

local CounterPositions = {
	CENTER = "CENTER",
	LEFT = "RIGHT",
	RIGHT = "LEFT",
	TOP = "BOTTOM", 
	BOTTOM = "TOP",
    TOPLEFT = "BOTTOM",
    TOPRIGHT = "BOTTOM",
}

local DirectionXMult = {
	CENTER = 0,
	LEFT = 1,
	RIGHT = -1,
	TOP = 0,
	BOTTOM = 0,
    TOPRIGHT = -1,
    TOPLEFT = 1,
}

local DirectionYMult = {
	CENTER = 0,
	LEFT = 0,
	RIGHT = 0,
	TOP = -1,
	BOTTOM = -1,
    TOPRIGHT = -1,
    TOPLEFT = -1,
}


function XiTimers:SetPoint(pos, relframe, relpos, halfspace)
	local relborder = 0
	if relframe.button then 
		if not relpos then relborder = relframe:GetBorder(CounterPositions[pos])
        else relborder = relframe:GetBorder(relpos) end
		relframe = relframe.button
	end
	local borderx = self:GetBorder(pos)+relborder
    local bordery = borderx
    --hack for anchoring TOPRIGHT or TOPLEFT to BOTTOM, maybe change it account for all anchors someday if needed
    if relpos == "BOTTOM" then borderx = 0 end
	self.button:ClearAllPoints()
    if not relpos then relpos = CounterPositions[pos] end
    local spacingx = self.spacing
    if halfspace then spacingx = spacingx / 2 end
    local spacingy = self.spacing
	self.button:SetPoint(pos, relframe, relpos, (spacingx+borderx)*DirectionXMult[pos], (spacingy+bordery)*DirectionYMult[pos])
end

-- anchors this timer to another
function XiTimers:Anchor(timer, point, relpoint, halfspace)
	table.insert(self.anchors, {timer = timer, point = point, relpoint = relpoint, halfspace = halfspace})
	table.insert(timer.anchorchilds, self)
	self:SetPoint(point, timer, relpoint, halfspace) 
end

-- updates the positions of all frames anchored to this timer
function XiTimers:Reanchor()
	for _, anchor in pairs(self.anchors) do
		self:SetPoint(anchor.point, anchor.timer, anchor.relpoint)
	end
	for _, anchorchild in pairs(self.anchorchilds) do
		anchorchild:Reanchor()
	end
end

function XiTimers:ClearAnchors()
	self.anchors = {}
	self.anchorchilds = {}
end

function XiTimers:SetSpacing(spacing)
	self.spacing = spacing
	self:Reanchor()
end

function XiTimers:SetTimeSpacing(spacing)
	self.timeSpacing = spacing
	self:SetTimerBarPos(self.timerBarPos)
	--self:Reanchor()
end


function XiTimers:Show()
    self.button:Show()
    for i=1,self.nrOfTimers do
        if self.timers[i] > 0 then
            self:ShowTimerBar(i)
        end
    end
end

function XiTimers:Hide()
    self.button:Hide()
    for i=1,self.nrOfTimers do
        if self.timers[i] > 0 then
            self:HideTimerBar(i)
        end
    end
end

function XiTimers:HideNormalTexture()
	-- self.button.normalTexture:SetTexture(1,1,1,0)
end


--Out-of-combat-Fader

local oocframe = CreateFrame("Frame", "XiTimersOOCFaderFrame")
oocframe:RegisterEvent("PLAYER_REGEN_ENABLED")
oocframe:RegisterEvent("PLAYER_REGEN_DISABLED")

function XiTimers.invokeOOCFader()
    XiTimers.OOCFaderEvent(nil, (InCombatLockdown() and "PLAYER_REGEN_DISABLED") or "PLAYER_REGEN_ENABLED")
end

XiTimers.OOCFaderEvent = function(self, event, arg1, arg2)
    if event == "PLAYER_REGEN_ENABLED" then
        incombat = false
        for _,timer in pairs(XiTimers.timers) do
            if timer.active and timer.unclickable and timer.HideOOC then
                timer:Hide()
            end
            timer.button:SetAlpha(timer.OOCAlpha, false)
        end
    elseif event == "PLAYER_REGEN_DISABLED" then
        incombat = true
        for _,timer in pairs(XiTimers.timers, true) do
            if timer.active and timer.unclickable and timer.HideOOC and not timer.ActiveWhileHidden and not timer.hideInactive then
                timer:Show()
            end
            timer.button:SetAlpha(1)
        end        
	end
end
oocframe:SetScript("OnEvent", XiTimers.OOCFaderEvent)

local rangeManaFrame = CreateFrame("Frame")
local lastRangeUpdate = 0
local rangeManaCheckFrames = {}

local SpellRange = LibStub("SpellRange-1.0")
local IsSpellInRange = SpellRange.IsSpellInRange


local function rangeManaUpdate(self, elapsed)
	lastRangeUpdate = lastRangeUpdate + 1
	if lastRangeUpdate > #rangeManaCheckFrames then lastRangeUpdate = 1 end
	local timer = rangeManaCheckFrames[lastRangeUpdate]
	if not timer then return end
   --[[  if timer.rangeCheck then
        --self.rangeCheckCount = self.rangeCheckCount + 1
        --if self.rangeCheckCount > 8 then
           -- self.rangeCheckCount = 0
            timer.outofrange = IsSpellInRange(timer.rangeCheck, "target") == 0
            if timer.outofrange then
                timer.button.icons[1]:SetVertexColor(1,0,0)
            else
                timer.button.icons[1]:SetVertexColor(1,1,1)
            end
       -- end
    end ]]
    
    if timer.manaCheck then
        --self.manaCheckCount = self.manaCheckCount + 1
        --if self.manaCheckCount > 8 then
            --self.manaCheckCount = 0
            local _,nomana = IsUsableSpell(timer.manaCheck)
			if nomana then
                if timer.manaCheckMini then
                    timer.button.miniIcon:SetVertexColor(0.5,0.5,1)
                else
                    timer.button.icons[1]:SetVertexColor(0.5,0.5,1)
                end
            else
                if timer.manaCheckMini then
                    timer.button.miniIcon:SetVertexColor(1,1,1)
                else
                  --[[ if timer.outofrange then
                        timer.button.icons[1]:SetVertexColor(1,0,0)
                    else ]]
                        timer.button.icons[1]:SetVertexColor(1,1,1)
                   -- end
                end
            end
        --end
    end
end

rangeManaFrame:SetScript("OnUpdate", rangeManaUpdate)
rangeManaFrame:Show()

function XiTimers.AddRangeCheck(self)
	local isIn = false
	for i=1,#rangeManaCheckFrames do
		if rangeManaCheckFrames[i] == self then isIn = true end
	end
	if not isIn then table.insert(rangeManaCheckFrames, self) end
end

function XiTimers.RemoveRangeCheck(self)
	for i=1,#rangeManaCheckFrames do
		if rangeManaCheckFrames[i] and rangeManaCheckFrames[i] == self then
			table.remove(rangeManaCheckFrames,i)
			i = i - 1
		end
	end
end