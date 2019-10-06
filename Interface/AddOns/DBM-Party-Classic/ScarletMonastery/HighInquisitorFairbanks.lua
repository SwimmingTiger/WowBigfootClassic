local mod	= DBM:NewMod("Fairbanks", "DBM-Party-Classic", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(4542)
--mod:SetEncounterID(585)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 8282"
)

local warningCurseofBlood			= mod:NewTargetNoFilterAnnounce(8282, 2, nil, "RemoveCurse")

do
	local CurseofBlood = DBM:GetSpellInfo(8282)
	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 8282 then
		if args.spellName == CurseofBlood then
			warningCurseofBlood:Show(args.destName)
		end
	end
end
