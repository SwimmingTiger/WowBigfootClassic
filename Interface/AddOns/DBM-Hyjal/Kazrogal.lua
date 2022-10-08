local mod	= DBM:NewMod("Kazrogal", "DBM-Hyjal")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220923022829")
mod:SetCreatureID(17888)
mod:SetEncounterID(620, 2470)
mod:SetModelID(17886)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 31447",
	"SPELL_CAST_SUCCESS 31480"
)

--[[
ability.id = 31447 and type = "begincast"
 or ability.id = 31480 and type = "cast"
--]]
local warnMark		= mod:NewCountAnnounce(31447, 3)
local warnStomp		= mod:NewSpellAnnounce(31480, 2)

local timerStompCD	= mod:NewCDTimer(10, 31480, nil, false, nil, 2)--10-26
local timerMark		= mod:NewBuffFadesTimer(6.2, 31447, nil, nil, nil, 2)
local timerMarkCD	= mod:NewNextCountTimer(45, 31447, nil, nil, nil, 3)

mod.vb.count = 0
mod.vb.time = 45

function mod:OnCombatStart(delay)
	self.vb.time = 45
	self.vb.count = 0
	timerMark:Start(45-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 31447 then
		self.vb.count = self.vb.count + 1
		if self.vb.time > 10 then
			self.vb.time = self.vb.time - 5
		end
		warnMark:Show(self.vb.count)
		timerMark:Start()
		timerMarkCD:Start(self.vb.time, self.vb.count+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 31480 then
		warnStomp:Show()
		timerStompCD:Start()
	end
end
