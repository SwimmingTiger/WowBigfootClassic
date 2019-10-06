local mod	= DBM:NewMod(424, "DBM-Party-Classic", 8, 232)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(12258)
mod:SetEncounterID(423)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 15976"
)

--It doesn't do that much damage, but maybe useful if doing it under leveled
local warningPuncture				= mod:NewSpellAnnounce(15976, 2, nil, false)

local timerPunctureCD				= mod:NewAITimer(180, 15976, nil, false, nil, 5, nil, DBM_CORE_TANK_ICON)

function mod:OnCombatStart(delay)
	timerPunctureCD:Start(1-delay)
end

do
	local Puncture = DBM:GetSpellInfo(15976)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 15976 then
		if args.spellName == Puncture then
			warningPuncture:Show()
			timerPunctureCD:Start()
		end
	end
end
