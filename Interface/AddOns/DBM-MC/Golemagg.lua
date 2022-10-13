local mod	= DBM:NewMod("Golemagg", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221010035226")
mod:SetCreatureID(11988)--, 11672
mod:SetEncounterID(670)
mod:SetModelID(11986)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 19798"
)

--TODO, quake not in combat log on classic?
local warnQuake		= mod:NewSpellAnnounce(19798)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 19798 then
		warnQuake:Show()
	end
end
