-- Copyright © 2008 - 2012 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.
-- Current distribution permissions only include curse.com, wowinterface.com and their respective addon updaters

if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local TotemTimers = TotemTimers
local SpellNames = TotemTimers.SpellNames
local SpellIDs = TotemTimers.SpellIDs

local function GetSpellTab(tab)
    local _, _, offset, numSpells = GetSpellTabInfo(tab)
    local AvailableSpells = TotemTimers.AvailableSpells
    for s = offset + 1, offset + numSpells do 
        local spelltype, spell = GetSpellBookItemInfo(s, BOOKTYPE_SPELL)
        if spelltype == "SPELL" then
            AvailableSpells[spell] = true
        end
    end
end    

local GetSpellInfo = GetSpellInfo
local IsPlayerSpell = IsPlayerSpell
function TotemTimers.GetSpells()
    local AvailableSpells = TotemTimers.AvailableSpells
    wipe(AvailableSpells)
    for _,s in pairs(SpellIDs) do
		AvailableSpells[s] = IsPlayerSpell(s)
		if AvailableSpells[s] then
			AvailableSpells[s] = GetSpellInfo(SpellNames[s]) == SpellNames[s]
		end
    end
    --[[if AvailableSpells[TotemTimers.SpellIDs.PrimalStrike] and UnitLevel("player") > 10 then
        AvailableSpells[TotemTimers.SpellIDs.StormStrike] = true
    end]]
    return true
end

--[[function TotemTimers.GetTalents()
    wipe(TotemTimers.AvailableTalents)
    if select(5, GetTalentInfo(2,17))>0 then TotemTimers.AvailableTalents.Maelstrom = true end
    if select(5, GetTalentInfo(1,18))>0 then TotemTimers.AvailableTalents.LavaSurge = true end
    if select(5, GetTalentInfo(1,13))>0 then TotemTimers.AvailableTalents.Fulmination = true end
end]]


function TotemTimers.LearnedSpell(spell,tab)
	if spell then TotemTimers.AvailableSpells[spell] = true end
    TotemTimers.SetCastButtonSpells()
    TotemTimers.SetWeaponTrackerSpells()
    TotemTimers.ProcessSetting("AnkhTracker")
    TotemTimers.ProcessSetting("ShieldTracker")
    -- TotemTimers.ProcessSetting("EarthShieldTracker")
    -- TotemTimers.ProcessSetting("EnhanceCDs")
    TotemTimers.ProcessSetting("Show")
	-- TotemTimers.ProcessSetting("LongCooldowns")
    TotemTimers.ProgramSetButtons()
end


function TotemTimers.ChangedTalents()
	TotemTimers.GetSpells()
    TotemTimers.SelectActiveProfile()
    TotemTimers.ExecuteProfile()
end
