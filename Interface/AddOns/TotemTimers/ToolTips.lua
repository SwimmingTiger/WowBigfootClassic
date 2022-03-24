-- Copyright © 2008 - 2012 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.
-- Current distribution permissions only include curse.com, wowinterface.com and their respective addon updaters

if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers", true)

local SpellNames = TotemTimers.SpellNames

local r = 0
local g = 0.9
local b = 1


local function SetTooltipSpellID(id)
    local name = GetSpellInfo(id)
    local _,_,_,_,_,_,maxSpellID = GetSpellInfo(name)
    if GetCVar("UberTooltips") == "1" then
         GameTooltip:SetSpellByID(maxSpellID)
    else
        GameTooltip:ClearLines()
        GameTooltip:AddLine(SpellNames[id],1,1,1)
    end
end

function TotemTimers.PositionTooltip(self)
    if not TotemTimers.ActiveProfile.TooltipsAtButtons then 
        GameTooltip_SetDefaultAnchor(GameTooltip, self)
    else
        local left = self:GetLeft()
        if left<UIParent:GetWidth()/2 then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        else			
            GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        end
    end
end

function TotemTimers.HideTooltip(self)
    GameTooltip:Hide()
end

function TotemTimers.timerTooltip(self)
    if false and self.timer and self.element and not IsModifierKeyDown() and TotemTimers.ActiveProfile.ShowRaidRangeTooltip then
        if self.timer.timers[1] <= 0 then return end
        local count = TotemTimers.GetOutOfRange(self.element)
        if count <= 0 then return end
        local missingBuffGUIDs, names, classes = TotemTimers.GetOutOfRangePlayers(self.element)
        GameTooltip:ClearLines()
        TotemTimers.PositionTooltip(self)
        for guid,_ in pairs(missingBuffGUIDs) do
            GameTooltip:AddLine(names[guid], RAID_CLASS_COLORS[classes[guid]].r, RAID_CLASS_COLORS[classes[guid]].g, RAID_CLASS_COLORS[classes[guid]].b)
        end
        GameTooltip:Show()
    elseif self:GetAttribute("tooltip") then
        local spell = self:GetAttribute("*spell1")
		if spell and type(spell) == "string" then spell = TotemTimers.NameToSpellID[spell] end
        if spell and spell > 0 then
            TotemTimers.PositionTooltip(self)
            SetTooltipSpellID(spell)
        end
    end
end


function TotemTimers.TotemTooltip(self)
    if not self:GetAttribute("tooltip") then return end
    local spell = self:GetAttribute("*spell1")
    if spell and type(spell) == "string" then spell = TotemTimers.NameToSpellID[spell] end
    TotemTimers.PositionTooltip(self)
    if spell and spell > 0 then
        SetTooltipSpellID(spell)
    end

    GameTooltip:AddLine(" ")
    GameTooltip:AddLine(L["Leftclick to cast spell"],r,g,b,1)
    GameTooltip:AddLine(L["Rightclick to assign totem to timer button"],r,g,b,1)
    GameTooltip:Show()
end


function TotemTimers.SetTooltip(self)
    if not self:GetAttribute("tooltip") then return end
    TotemTimers.PositionTooltip(self)
    GameTooltip:AddLine(L["Leftclick to open totem set menu"],r,g,b,1)
    GameTooltip:AddLine(L["Rightclick to save active totem configuration as set"],r,g,b,1)
    GameTooltip:Show()
end

function TotemTimers.SetButtonTooltip(self)
    TotemTimers.PositionTooltip(self)
    GameTooltip:AddLine(L["Leftclick to load totem set"],r,g,b,1)
    GameTooltip:AddLine(L["Rightclick to delete totem set"],r,g,b,1)
    GameTooltip:Show()
end

function TotemTimers.WeaponButtonTooltip(self)
    if not self:GetAttribute("tooltip")  then return end

    GameTooltip:ClearLines()
    TotemTimers.PositionTooltip(self)

    for i = 1, 2 do
        if self.timer.timers[i] > 0 then
            GameTooltip:AddLine(self.timer["enchant"..i])
        end
    end

    GameTooltip:AddLine(" ")

    local spell= self:GetAttribute("spell1")
    if spell and not self:GetAttribute("doublespell1") then
        GameTooltip:AddLine(format(L["Leftclick to cast %s"], spell),r,g,b,1)
    else
        local ds = self:GetAttribute("ds")
        if ds then
            local ds1 = self:GetAttribute("doublespell1")
            local ds2 = self:GetAttribute("doublespell2")
            if ds == 2 then ds1, ds2 = ds2, ds1 end
            if ds1 and ds2 then
                GameTooltip:AddLine(format(L["Leftclick to cast %s"], ds1),r,g,b,1)
                GameTooltip:AddLine(format(L["Next leftclick casts %s"], ds2),r,g,b,1)
            end
        end
    end
    local spell2 = self:GetAttribute("spell2")
    if spell2 then
        GameTooltip:AddLine(format(L["Rightclick to cast %s"], spell2),r,g,b,1)
    end
    --[[s = self:GetAttribute("spell2")
    if s then GameTooltip:AddLine(format(L["Rightclick to cast %s"],s),r,g,b,1)
    else
        s = self:GetAttribute("spell3")
        GameTooltip:AddLine(format(L["Middleclick to cast %s"],s),r,g,b,1)
    end --]]
    --GameTooltip:AddLine(L["Ctrl-Leftclick to remove weapon buffs"],r,g,b,1)
    GameTooltip:Show()
end

function TotemTimers.WeaponBarTooltip(self)
    if not self:GetAttribute("tooltip") then return end

    local spell = self:GetAttribute("*spell1")
    local doublespell = self:GetAttribute("doublespell1")

    TotemTimers.PositionTooltip(self)

    if not doublespell then
        if spell and type(spell) == "string" then spell = TotemTimers.NameToSpellID[spell] end
        if spell and spell > 0 then
            SetTooltipSpellID(spell)
        end
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(L["Leftclick to cast spell"],r,g,b,1)
        GameTooltip:AddLine(L["Rightclick to assign to weapon button leftclick"],r,g,b,1)
        GameTooltip:AddLine(L["Shift-Rightclick to assign to weapon button leftclick"],r,g,b,1)
    else
        GameTooltip:ClearLines()
        GameTooltip:AddLine(doublespell,1,1,1)
        GameTooltip:AddLine(self:GetAttribute("doublespell2"),1,1,1)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(L["Rightclick to assign to weapon button rightclick"],r,g,b,1)
    end

    GameTooltip:Show()
end

