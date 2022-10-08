if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers", true)

local SpellNames = TotemTimers.SpellNames
local RankedNameToSpellID = TotemTimers.RankedNameToSpellID
local NameToSpellID = TotemTimers.NameToSpellID

local r = 0
local g = 0.9
local b = 1

local ElementColors = TotemTimers.ElementColors


XiTimersTooltip = {}

function XiTimersTooltip:new(button)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.button = button
    return o
end

function XiTimersTooltip:SetText() GameTooltip:AddLine("test") end

function XiTimersTooltip:Show()
    if not self.button then return end

    if not TotemTimers.ActiveProfile.TooltipsAtButtons then
        GameTooltip_SetDefaultAnchor(GameTooltip, self.button)
    else
        local left = self.button:GetLeft()
        if left<UIParent:GetWidth()/2 then
            GameTooltip:SetOwner(self.button, "ANCHOR_RIGHT")
        else
            GameTooltip:SetOwner(self.button, "ANCHOR_LEFT")
        end
    end

    self:SetText()
    GameTooltip:Show()
end

function XiTimersTooltip:Hide()
    GameTooltip:Hide()
end


function XiTimersTooltip:SetSpell(spell)
    --[[if not spell then return end

    local spellID = spell

    if spell and type(spell) == "string" then
        spellID = RankedNameToSpellID[spell]
        if not spellID then spellID = NameToSpellID[spell] end
    end

    spellID = tonumber(spellID)
    if not spellID then return end]]
    local spellID = select(7, GetSpellInfo(spell))

    GameTooltip:SetSpellByID(spellID)
end


TotemTimers.Tooltips = {}


local SpellTooltip = XiTimersTooltip:new()
TotemTimers.Tooltips.Spell = SpellTooltip

function SpellTooltip:SetText()
    local spell = self.button:GetAttribute("*spell1")
    if not spell then return end

    self:SetSpell(spell)
end


local TotemTooltip = XiTimersTooltip:new()
TotemTimers.Tooltips.Totem = TotemTooltip

function TotemTooltip:SetText()
    local spell = self.button:GetAttribute("*spell1")
    if not spell then return end

    self:SetSpell(spell)

    GameTooltip:AddLine(" ")
    GameTooltip:AddLine(L["Leftclick to cast spell"],r,g,b,1)
    if self.button.timer then
        if TotemTimers_MultiSpell and TotemTimers_MultiSpell.active then
            local mspellID = TotemTimers_MultiSpell:GetAttribute("*spell1")
            if mspellID then
                local disabled = TotemTimers.ActiveProfile.DisabledMultiSpells[mspellID.."-"..self.button.timer.nr]
                local message = L["Ctrl-Rightclick to disable totem for %s"]
                if disabled then message = L["Ctrl-Rightclick to enable element for %s"] end

                local mspell = GetSpellInfo(mspellID)
                GameTooltip:AddLine(format(message, mspell),r,g,b,1)

            end
        end
    else
        GameTooltip:AddLine(L["Rightclick to assign totem to timer button"],r,g,b,1)
    end
end



local SetAnchorTooltip = XiTimersTooltip:new()
TotemTimers.Tooltips.SetAnchor = SetAnchorTooltip

function SetAnchorTooltip:SetText()
    GameTooltip:AddLine(L["Leftclick to open totem set menu"],r,g,b,1)
    GameTooltip:AddLine(L["Rightclick to save active totem configuration as set"],r,g,b,1)
end



local SetButtonTooltip = XiTimersTooltip:new()
TotemTimers.Tooltips.SetButton = SetButtonTooltip

function SetButtonTooltip:SetText()
    local set = TotemTimers.ActiveProfile.TotemSets[self.button.nr]

    if set then
        GameTooltip:AddLine(not set.name and "Set " .. self.button.nr or set.name, 1, 1, 1)

        for i=1,4 do
            GameTooltip:AddLine(SpellNames[set[i]], ElementColors[i].r, ElementColors[i].g, ElementColors[i].b)
        end
        GameTooltip:AddLine(" ")
    end

    GameTooltip:AddLine(L["Leftclick to load totem set"],r,g,b,1)
    GameTooltip:AddLine(L["Rightclick to delete totem set"],r,g,b,1)
end



local WeaponTimerTooltip = XiTimersTooltip:new()
TotemTimers.Tooltips.WeaponTimer = WeaponTimerTooltip

WeaponTimerTooltip.new = ToolTipConstructor

function WeaponTimerTooltip:SetText()
    local button = self.button

    for i = 1, 2 do
        if button.timer.timers[i] and button.timer.timers[i] > 0 then
            GameTooltip:AddLine(button.timer["enchant"..i])
        end
    end

    GameTooltip:AddLine(" ")

    local spell = button:GetAttribute("spell1")
    if spell and not button:GetAttribute("doublespell1") then
        local spellName = GetSpellInfo(spell)
        if spellName then GameTooltip:AddLine(format(L["Leftclick to cast %s"], spellName),r,g,b,1) end
    else
        local ds = button:GetAttribute("ds")
        if ds then
            local ds1 = button:GetAttribute("doublespell1")
            local ds2 = button:GetAttribute("doublespell2")
            if ds == 2 then ds1, ds2 = ds2, ds1 end
            if ds1 and ds2 then
                GameTooltip:AddLine(format(L["Leftclick to cast %s"], ds1),r,g,b,1)
                GameTooltip:AddLine(format(L["Next leftclick casts %s"], ds2),r,g,b,1)
            end
        end
    end
    local spell2 = button:GetAttribute("spell2")
    if spell2 then
        local spellname = GetSpellInfo(spell2)
        if spellname then GameTooltip:AddLine(format(L["Rightclick to cast %s"], GetSpellInfo(spell2)),r,g,b,1) end
    end
    --[[s = self:GetAttribute("spell2")
    if s then GameTooltip:AddLine(format(L["Rightclick to cast %s"],s),r,g,b,1)
    else
        s = self:GetAttribute("spell3")
        GameTooltip:AddLine(format(L["Middleclick to cast %s"],s),r,g,b,1)
    end --]]
    --GameTooltip:AddLine(L["Ctrl-Leftclick to remove weapon buffs"],r,g,b,1)
end

local WeaponBarTooltip = XiTimersTooltip:new()
TotemTimers.Tooltips.WeaponBar = WeaponBarTooltip

function WeaponBarTooltip:SetText()
    local button = self.button

    local spell = button:GetAttribute("*spell1")
    local doublespell = button:GetAttribute("doublespell1")

    if not doublespell then
        self:SetSpell(spell)

        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(L["Leftclick to cast spell"],r,g,b,1)
        GameTooltip:AddLine(L["Rightclick to assign to weapon button leftclick"],r,g,b,1)
        GameTooltip:AddLine(L["Shift-Rightclick to assign to weapon button rightclick"],r,g,b,1)
    else
        --GameTooltip:ClearLines()
        GameTooltip:AddLine(doublespell,1,1,1)
        GameTooltip:AddLine(button:GetAttribute("doublespell2"),1,1,1)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(L["Rightclick to assign to weapon button leftclick"],r,g,b,1)
    end
end