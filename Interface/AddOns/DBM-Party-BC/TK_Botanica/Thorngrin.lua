local mod = DBM:NewMod(560, "DBM-Party-BC", 14, 257)
local L = mod:GetLocalizedStrings()

mod:SetRevision("20210401042132")

mod:SetCreatureID(17978)
mod:SetEncounterID(1928)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 34661",
	"SPELL_AURA_REMOVED 34661"
)

local warnSacrifice       = mod:NewTargetNoFilterAnnounce(34661, 2)

local timerSacrifice      = mod:NewTargetTimer(8, 34661, nil, nil, nil, 3)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 34661 then
		warnSacrifice:Show(args.destName)
		timerSacrifice:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 34661 then
		timerSacrifice:Stop(args.destName)
	end
end
