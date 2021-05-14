local mod	= DBM:NewMod(538, "DBM-Party-BC", 11, 251)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20210401042132")
mod:SetCreatureID(17848)
mod:SetEncounterID(1905)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 33792",
	"SPELL_AURA_REMOVED 33792"
)

local warnShot      = mod:NewTargetNoFilterAnnounce(33792)

local timerShot     = mod:NewTargetTimer(6, 33792, nil, nil, nil, 3)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 33792 then
		warnShot:Show(args.destName)
		timerShot:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 33792 then
		timerShot:Stop(args.destName)
	end
end
