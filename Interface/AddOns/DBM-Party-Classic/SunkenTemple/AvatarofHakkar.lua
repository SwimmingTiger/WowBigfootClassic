local mod	= DBM:NewMod(457, "DBM-Party-Classic", 17, 237)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(8443)
mod:SetEncounterID(492)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 12889 12888",
	"SPELL_AURA_APPLIED 12889 12888"
)

local warningCurseofTongues			= mod:NewTargetNoFilterAnnounce(12889, 2, nil, "RemoveCurse")
local warningCauseInsanity			= mod:NewTargetNoFilterAnnounce(12888, 4)

local timerCurseofTonguesCD			= mod:NewAITimer(180, 12889, nil, nil, nil, 3, nil, DBM_CORE_CURSE_ICON)
local timerCauseInsanityCD			= mod:NewAITimer(180, 12888, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
	timerCurseofTonguesCD:Start(1-delay)
	timerCauseInsanityCD:Start(1-delay)
end

do
	local CurseofTongues, CauseInsanity = DBM:GetSpellInfo(12889), DBM:GetSpellInfo(12888)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 12889 then
		if args.spellName == CurseofTongues then
			timerCurseofTonguesCD:Start()
		--elseif args.spellId == 12888 then
		elseif args.spellName == CauseInsanity then
			timerCauseInsanityCD:Start()
		end
	end

	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 12889 then
		if args.spellName == CurseofTongues then
			warningCurseofTongues:Show(args.destName)
		--elseif args.spellId == 12888 then
		elseif args.spellName == CauseInsanity then
			warningCauseInsanity:Show(args.destName)
		end
	end
end
