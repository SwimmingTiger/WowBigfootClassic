local mod	= DBM:NewMod("Gilnid", "DBM-Party-Classic", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(1763)
--mod:SetEncounterID(1144)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 5213",
	"SPELL_AURA_APPLIED 5213"
)

local warningMoltenMetal	= mod:NewTargetNoFilterAnnounce(5213, 2)

local timerMoltenMetalCD	= mod:NewAITimer(180, 5213, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
	timerMoltenMetalCD:Start(1-delay)
end

do
	local MoltenMetal = DBM:GetSpellInfo(5213)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 5213 then
		if args.spellName == MoltenMetal then
			timerMoltenMetalCD:Start()
		end
	end

	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 5213 then
		if args.spellName == MoltenMetal then
			warningMoltenMetal:Show(args.destName)
		end
	end
end
