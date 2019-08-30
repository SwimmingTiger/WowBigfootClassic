local mod	= DBM:NewMod("BloodmageThalnos", "DBM-Party-Classic", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190810222722")
mod:SetCreatureID(4543)
--mod:SetEncounterID(585)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 8814",
	"SPELL_CAST_SUCCESS 12470"
)

local warningFlameSpike				= mod:NewSpellAnnounce(8814, 2)
local warningFireNova				= mod:NewSpellAnnounce(12470, 2)

local timerFlameSpikeCD				= mod:NewAITimer(180, 8814, nil, nil, nil, 3)
local timerFireNovaCD				= mod:NewAITimer(180, 12470, nil, nil, nil, 2)

function mod:OnCombatStart(delay)
	timerFlameSpikeCD:Start(1-delay)
end

do
	local Flamespike = DBM:GetSpellInfo(8814)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 8814 then
		if args.spellName == Flamespike then
			warningFlameSpike:Show()
			timerFlameSpikeCD:Start()
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
