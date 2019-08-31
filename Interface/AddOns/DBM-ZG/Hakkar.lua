local mod	= DBM:NewMod("Hakkar", "DBM-ZG", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(14834)
mod:SetEncounterID(793)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 24324",
	"SPELL_AURA_APPLIED 24327 24328"
)

local warnSiphonSoon	= mod:NewSoonAnnounce(24324)
local warnInsanity		= mod:NewTargetNoFilterAnnounce(24327, 4)
local warnBlood			= mod:NewTargetAnnounce(24328, 2)

local specWarnBlood		= mod:NewSpecialWarningMoveAway(24328, nil, nil, nil, 1, 2)

local timerSiphon		= mod:NewNextTimer(90, 24324, nil, nil, nil, 2)
local timerInsanity		= mod:NewTargetTimer(10, 24327, nil, nil, nil, 5)
local timerInsanityCD	= mod:NewCDTimer(20, 24327, nil, nil, nil, 3)

local enrageTimer		= mod:NewBerserkTimer(585)

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	warnSiphonSoon:Schedule(80-delay)
	timerSiphon:Start(-delay)
end

do
	local BloodSiphon = DBM:GetSpellInfo(24324)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args:IsSpellID(24324) then
		if args.spellName == BloodSiphon then
			warnSiphonSoon:Cancel()
			warnSiphonSoon:Schedule(80)
			timerSiphon:Start()
		end
	end
end

do
	local CauseInsanity, CorruptedBlood = DBM:GetSpellInfo(24327), DBM:GetSpellInfo(24328)
	function mod:SPELL_AURA_APPLIED(args)
		--if args:IsSpellID(24327) then
		if args.spellName == CauseInsanity then
			warnInsanity:Show(args.destName)
			timerInsanity:Start(args.destName)
			timerInsanityCD:Start()
		--elseif args:IsSpellID(24328) then
		elseif args.spellName == CorruptedBlood then
			if args:IsPlayer() then
				specWarnBlood:Show()
				specWarnBlood:Play("runout")
			else
				warnBlood:Show(args.destName)
			end
		end
	end
end
