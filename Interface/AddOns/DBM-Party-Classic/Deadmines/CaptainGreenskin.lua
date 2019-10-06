local mod	= DBM:NewMod("CaptainGreenskin", "DBM-Party-Classic", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(647)
--mod:SetEncounterID(1144)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 5208",
	"SPELL_AURA_APPLIED 5208"
)

--TODO, consider a cleave timer if not cast too often
local warningPoisonedHarpoon		= mod:NewTargetNoFilterAnnounce(5208, 2, nil, "RemovePoison")

local timerPoisonedHarpoonCD		= mod:NewAITimer(30, 5208, nil, "RemovePoison", nil, 5, nil, DBM_CORE_POISON_ICON)

function mod:OnCombatStart(delay)
	timerPoisonedHarpoonCD:Start(1-delay)
end

do
	local Harpoon = DBM:GetSpellInfo(5208)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 5208 then
		if args.spellName == Harpoon then
			timerPoisonedHarpoonCD:Start()
		end
	end

	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 5208 then
		if args.spellName == Harpoon then
			warningPoisonedHarpoon:Show(args.destName)
		end
	end
end
