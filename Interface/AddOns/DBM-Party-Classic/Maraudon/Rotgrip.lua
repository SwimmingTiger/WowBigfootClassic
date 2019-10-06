local mod	= DBM:NewMod(430, "DBM-Party-Classic", 8, 232)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(13596)
mod:SetEncounterID(428)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 15976 16495"
)

--Puncture doesn't do that much damage, but maybe useful if doing it under leveled
local warningPuncture				= mod:NewSpellAnnounce(15976, 2, nil, false)
local warningFatalBite				= mod:NewSpellAnnounce(16495, 3)

local timerPunctureCD				= mod:NewAITimer(180, 15976, nil, false, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerFatalBiteCD				= mod:NewAITimer(180, 16495, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)

function mod:OnCombatStart(delay)
	timerPunctureCD:Start(1-delay)
	timerFatalBiteCD:Start(1-delay)
end

do
	local Puncture, FatalBite = DBM:GetSpellInfo(15976), DBM:GetSpellInfo(16495)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 15976 then
		if args.spellName == Puncture then
			warningPuncture:Show()
			timerPunctureCD:Start()
		--elseif args.spellId == 16495 then
		elseif args.spellName == FatalBite then
			warningFatalBite:Show()
			timerFatalBiteCD:Start()
		end
	end
end
