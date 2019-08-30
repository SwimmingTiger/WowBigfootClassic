local mod	= DBM:NewMod(448, "DBM-Party-Classic", 16, 236)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(10811)
mod:SetEncounterID(477)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 17293",
	"SPELL_CAST_SUCCESS 17366",
	"SPELL_AURA_APPLIED 17293"
)

local warningBurningWinds			= mod:NewTargetNoFilterAnnounce(17293, 2)
local warningFireNova				= mod:NewSpellAnnounce(17366, 2)

local timerBurningWindsCD			= mod:NewAITimer(180, 17293, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
local timerFireNovaCD				= mod:NewAITimer(180, 17366, nil, nil, nil, 2)

function mod:OnCombatStart(delay)
	timerBurningWindsCD:Start(1-delay)
	timerFireNovaCD:Start(1-delay)
end

do
	local FireNova = DBM:GetSpellInfo(17366)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 17366 then
		if args.spellName == FireNova and args:IsSrcTypeHostile() then
			warningFireNova:Show()
			timerFireNovaCD:Start()
		end
	end
end

do
	local BurningWinds = DBM:GetSpellInfo(17293)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 17293 then
		if args.spellName == BurningWinds then
			timerBurningWindsCD:Start()
		end
	end

	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 17293 then
		if args.spellName == BurningWinds then
			warningBurningWinds:Show(args.destName)
		end
	end
end
