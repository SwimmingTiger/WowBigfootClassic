local mod	= DBM:NewMod("Akumai", "DBM-Party-Classic", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(4829)
--mod:SetEncounterID(1672)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 3815",
	"SPELL_CAST_SUCCESS 3490"
)

local warningPoisonCloud		= mod:NewSpellAnnounce(3815, 4)
local warningFrenziedRage		= mod:NewSpellAnnounce(3490, 4)

local timerPoisonCloudCD		= mod:NewAITimer(180, 3815, nil, nil, nil, 3)
local timerFrenziedRageCD		= mod:NewAITimer(180, 3490, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)

function mod:OnCombatStart(delay)
	timerPoisonCloudCD:Start(1-delay)
	timerFrenziedRageCD:Start(1-delay)
end

do
	local PoisonCloud = DBM:GetSpellInfo(3815)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 3815 then
		if args.spellName == PoisonCloud then
			warningPoisonCloud:Show()
			timerPoisonCloudCD:Start()
		end
	end
end

do
	local FrenziedRage = DBM:GetSpellInfo(3490)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 3490 then
		if args.spellName == FrenziedRage then
			warningFrenziedRage:Show()
			timerFrenziedRageCD:Start()
		end
	end
end
