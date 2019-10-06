local mod	= DBM:NewMod("LadySerevess", "DBM-Party-Classic", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(4831)
--mod:SetEncounterID(1667)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 246",
	"SPELL_AURA_APPLIED 246"
)

local warningSlow			= mod:NewTargetNoFilterAnnounce(246, 2)

local timerSlowCD			= mod:NewAITimer(180, 246, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)

function mod:OnCombatStart(delay)
	timerSlowCD:Start(1-delay)
end

do
	local Slow = DBM:GetSpellInfo(246)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 246 and args:IsSrcTypeHostile() then
		if args.spellName == Slow and args:IsSrcTypeHostile() then
			timerSlowCD:Start()
		end
	end

	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 246 and args:IsDestTypePlayer() then
		if args.spellName == Slow and args:IsDestTypePlayer() then
			warningSlow:Show(args.destName)
		end
	end
end
