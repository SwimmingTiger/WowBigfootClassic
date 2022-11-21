local mod	= DBM:NewMod(578, "DBM-Party-BC", 5, 262)

mod:SetRevision("20221029204055")
mod:SetCreatureID(17826)
mod:SetEncounterID(1947)
mod:SetModelID(18570)
mod:SetModelOffset(-0.4, 0, 0.3)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 31429",
	"SPELL_AURA_APPLIED 34971"
)

local warnRoar		= mod:NewSpellAnnounce(31429, 2)
local warnFrenzy	= mod:NewSpellAnnounce(34971, 4)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 31429 then
		warnRoar:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 34971 then
		warnFrenzy:Show()
	end
end
