local mod	= DBM:NewMod("MordreshFireEye", "DBM-Party-Classic", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(7357)
--mod:SetEncounterID(585)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 12466",
	"SPELL_CAST_SUCCESS 12470"
)

local warningFireNova			= mod:NewSpellAnnounce(12470, 2)

local specWarnFireball			= mod:NewSpecialWarningInterrupt(12466, "HasInterrupt", nil, nil, 1, 2)

local timerFireballCD			= mod:NewAITimer(180, 12466, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerFireNovaCD			= mod:NewAITimer(180, 12470, nil, nil, nil, 5, nil, DBM_CORE_HEALER_ICON)

function mod:OnCombatStart(delay)
	timerFireballCD:Start(1-delay)
	timerFireNovaCD:Start(1-delay)
end

do
	local Fireball = DBM:GetSpellInfo(12466)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 12466 then
		if args.spellName == Fireball and args:IsSrcTypeHostile() then
			timerFireballCD:Start()
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnFireball:Show(args.sourceName)
				specWarnFireball:Play("kickcast")
			end
		end
	end
end

do
	local FireNova = DBM:GetSpellInfo(12470)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 12470 then
		if args.spellName == FireNova then
			warningFireNova:Show()
			timerFireNovaCD:Start()
		end
	end
end
