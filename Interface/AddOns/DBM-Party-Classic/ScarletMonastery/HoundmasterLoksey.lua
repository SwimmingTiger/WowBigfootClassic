local mod	= DBM:NewMod("HoundmasterLoksey", "DBM-Party-Classic", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(3974)
--mod:SetEncounterID(585)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 6742"
)

local warningBloodLust		= mod:NewTargetNoFilterAnnounce(6742, 2)

do
	local BloodLust = DBM:GetSpellInfo(6742)
	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 6742 then
		if args.spellName == BloodLust and args:IsDestTypeHostile() then
			warningBloodLust:Show(args.destName)
		end
	end
end
