-- Copyright © 2008-2012 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.
-- Current distribution permissions only include curse.com, wowinterface.com and their respective addon updaters

if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers", true)

local SpellIDs = TotemTimers.SpellIDs
local SpellTextures = TotemTimers.SpellTextures
local SpellNames = TotemTimers.SpellNames
local AvailableSpells = TotemTimers.AvailableSpells


local cds = {}

local player = UnitName("player")


-- spells: bloodlust, astral shift, spiritwalkers grace, ancestral guidance,
-- call of the elements, elemental mastery, ancestral swiftness, ascendance

local CDEvent
local BuffEvent
local FeralSpiritEvent
local FeralSpiritCDEvent


local Ascendances = {SpellIDs.AscendanceElemental, SpellIDs.AscendanceEnhancement, SpellIDs.AscendanceRestoration}

local function ConfigureTimer(nr, spell, altcdspell)
	cds[nr].cdspell = spell
	cds[nr].altcdspell = altcdspell
	cds[nr].durationTimer.buffSpell = spell
	cds[nr].button.icon:SetTexture(SpellTextures[spell])
	cds[nr].durationTimer.button.icon:SetTexture(SpellTextures[spell])
	cds[nr].durationTimer.button.buffSpellName = SpellNames[spell]
	cds[nr].durationTimer.button.cooldown:SetAlpha(0.6)
	cds[nr].button:SetAttribute("*type*", "spell")
	if altcdspell then
		spell = GetSpellInfo(altcdspell)
	end
	cds[nr].button:SetAttribute("*spell1", spell)	
end


function TotemTimers.CreateLongCooldowns()

	for i = 1,8 do
		cds[i] = XiTimers:new(1)
		cds[i].durationTimer = XiTimers:new(1, true)
		cds[i].durationTimer.cdTimer = cds[i]
		cds[i].durationTimer.button:SetParent(cds[i].button)
		cds[i].durationTimer.button:EnableMouse(false)
		cds[i].button.anchorframe = TotemTimers_LongCooldownsFrame
		cds[i].durationTimer.hideInactive = true
		cds[i].durationTimer:SetPoint("CENTER", cds[i], "CENTER")
		
		cds[i].SetWidth = function(self, width)
			XiTimers.SetWidth(self, width)
			self.durationTimer:SetWidth(width)
		end
		cds[i].SetHeight = function(self, height)
			XiTimers.SetHeight(self, height)
			self.durationTimer:SetHeight(height)
		end
		cds[i].durationTimer:SetScale(2)
		cds[i].durationTimer.button:SetFrameStrata("BACKGROUND")
		
		cds[i].button:SetScript("OnEvent", CDEvent)
		cds[i].durationTimer.button:SetScript("OnEvent", BuffEvent)
		
		cds[i].durationTimer.maxAlpha = 0.2
		
		cds[i].button:RegisterForClicks("LeftButtonDown", "RightButtonDown", "MiddleButtonDown")
		
		cds[i].events[1] = "SPELL_UPDATE_COOLDOWN"
		
		cds[i].durationTimer.Activate = function(self)
			self.button:RegisterUnitEvent("UNIT_AURA", "player")
			XiTimers.Activate(self)
		end
		
		cds[i].durationTimer.Deactivate = function(self)
			self.button:UnregisterEvent("UNIT_AURA")
			XiTimers.Deactivate(self)
		end
		
		cds[i].durationTimer.showCooldown = true
		cds[i].durationTimer.hideTime = true
		cds[i].durationTimer.dontFlash = true
		
		cds[i].SetScale = function(self, scale)
			XiTimers.SetScale(self, scale)
			self.durationTimer:SetScale(scale*2)
		end
		
	end
	TotemTimers.LongCooldowns = cds
	
	if UnitFactionGroup("player") == "Alliance" then
		ConfigureTimer(1, SpellIDs.Heroism)
	else
		ConfigureTimer(1, SpellIDs.Bloodlust)
	end
	ConfigureTimer(3, SpellIDs.SpiritwalkersGrace)
	ConfigureTimer(7, SpellIDs.AstralShift)
	ConfigureTimer(4, SpellIDs.AncestralGuidance)
	ConfigureTimer(5, SpellIDs.CallOfElements)
	ConfigureTimer(6, SpellIDs.ElementalMastery)
	ConfigureTimer(2, SpellIDs.Ascendance)
	ConfigureTimer(8, SpellIDs.FeralSpirit)
	

	cds[8].durationTimer.button:SetScript("OnEvent", FeralSpiritEvent)
	cds[8].Update = FeralSpiritUpdate
	cds[8].durationTimer.Activate = function(self)
		self.button:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
		XiTimers.Activate(self)
	end
	cds[8].durationTimer.Deactivate = function(self)
		self.button:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
		XiTimers.Deactivate(self)
	end
	
	-- T15 Elemental 4pc, check Ascendance CD after every spellcast
	cds[2].durationTimer.Activate = function(self)
		self.button:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
		XiTimers.Activate(self)
	end
	cds[2].durationTimer.Deactivate = function(self)
		self.button:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
		XiTimers.Deactivate(self)
	end
	
end


function TotemTimers.ActivateLongCooldowns(activate)
	TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.Heroism] = TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.Bloodlust] --workaround for heroism
	for i = 1,8 do
			cds[i]:Deactivate()
			cds[i].durationTimer:Deactivate()
	end
	if AvailableSpells[SpellIDs.ElementalMastery] then ConfigureTimer(6, SpellIDs.ElementalMastery) else ConfigureTimer(6, SpellIDs.AncestralSwiftness) end
	local role = GetSpecialization()
	ConfigureTimer(2, SpellIDs.Ascendance, Ascendances[role])
		
	if activate then
		for i = 1,8 do
			if TotemTimers.ActiveProfile.LongCooldownSpells[cds[i].cdspell] and AvailableSpells[cds[i].cdspell] then
				cds[i]:Activate()
				cds[i].durationTimer:Activate()
			end
		end
	end
	TotemTimers.LayoutLongCooldowns()
end

local activecds = {}
function TotemTimers.LayoutLongCooldowns()
	wipe(activecds)
	for i = 1,#cds do
		cds[i]:ClearAnchors()
	end
	local point1, point2
	if TotemTimers.ActiveProfile.LongCooldownsArrange ~= "vertical" then
		point1 = "LEFT"
		point2 = "RIGHT"
	else
		point1 = "TOP"
		point2 = "BOTTOM"
	end
	for i=1,#cds do
		if cds[i].active then tinsert(activecds,cds[i]) end
	end
	if #activecds > 0 then
		activecds[1]:SetPoint("CENTER", TotemTimers_LongCooldownsFrame, "CENTER")
	end
	for i = 2,#activecds do
		activecds[i]:Anchor(activecds[i-1], point1, point2)
	end
end

CDEvent = function(self, event, unit, spell) 
	local spell = self.timer.cdspell
	if (self.timer.altcdspell) then spell = self.timer.altcdspell end
	local start, duration, enable = GetSpellCooldown(spell)
	if (not start and not duration) or (duration <= 1.5 and not InCombatLockdown()) then
		self.timer:Stop(1)					
	else
		if duration == 0 then
			self.timer:Stop(1)
		elseif duration > 2 and self.timer.timers[1]<=0 then
			self.timer:Start(1,start+duration-GetTime(),duration)
		end
		CooldownFrame_Set(self.cooldown, start, duration, enable)
	end 
end

BuffEvent = function(self, event)
	local name,_,_,count,_,duration,expiration = UnitBuff("player", self.buffSpellName)
	if duration and duration > 0 then
		self.timer:Start(1, expiration-GetTime(), duration)
	elseif self.timer.timers[1] > 0 then
		self.timer:Stop(1)
		--self.timer.cdTimer.button:CDEvent()
	end
end

local FeralSpiritName = SpellNames[SpellIDs.FeralSpirit]

FeralSpiritEvent = function(self,event,unit, spell)
    if spell == FeralSpiritName then
        self.timer:Start(1,30)
    end
end

local updates = 0
FeralSpiritUpdate = function(self, elapsed) 
	if self.timers[1] > 0 then
		updates = updates + 1
		if updates > 5 then
			updates = 0
			local start, duration, enable = GetSpellCooldown(SpellIDs.FeralSpirit)
			if (start and duration) then
				self.timers[1] = start+duration-GetTime()
			end
			XiTimers.Update(self, 0)
		else
			XiTimers.Update(self, elapsed)
		end
	end	
end

