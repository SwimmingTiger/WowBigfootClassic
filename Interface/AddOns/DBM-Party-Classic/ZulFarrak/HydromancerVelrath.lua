local mod	= DBM:NewMod("HydromancerVelrath", "DBM-Party-Classic", 20)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(7795)
mod:SetEncounterID(593)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 12491"
)

local specWarnHealingWave			= mod:NewSpecialWarningInterrupt(12491, "HasInterrupt", nil, nil, 1, 2)

local timerHealingWaveCD			= mod:NewAITimer(180, 12491, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)

function mod:OnCombatStart(delay)
	timerHealingWaveCD:Start(1-delay)
end

do
	local HealingWave = DBM:GetSpellInfo(12491)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 12491 then
		if args.spellName == HealingWave and args:IsSrcTypeHostile() then
			timerHealingWaveCD:Start()
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnHealingWave:Show(args.sourceName)
				specWarnHealingWave:Play("kickcast")
			end
		end
	end
end
