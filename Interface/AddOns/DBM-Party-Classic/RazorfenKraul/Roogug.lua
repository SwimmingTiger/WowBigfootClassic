local mod	= DBM:NewMod("Roogug", "DBM-Party-Classic", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190907034931")
mod:SetCreatureID(6168)
--mod:SetEncounterID(438)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 8270"
)

--Rumbler spawned on engage
local warningSummonEarthRumbler		= mod:NewSpellAnnounce(8270, 2)

do
	local SummonEarthRumbler = DBM:GetSpellInfo(8270)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 8270 then
		if args.spellName == SummonEarthRumbler then
			warningSummonEarthRumbler:Show()
		end
	end
end
