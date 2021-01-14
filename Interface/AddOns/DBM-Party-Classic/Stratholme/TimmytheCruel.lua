local mod	= DBM:NewMod(445, "DBM-Party-Classic", 16, 236)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(10808)
mod:SetEncounterID(474)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 8599"
)

local warningEnrage		= mod:NewTargetNoFilterAnnounce(8599, 2)

do
	local Enrage = DBM:GetSpellInfo(8599)
	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 8599 then
		if args.spellName == Enrage and args:IsDestTypeHostile() then
			warningEnrage:Show(args.destName)
		end
	end
end
