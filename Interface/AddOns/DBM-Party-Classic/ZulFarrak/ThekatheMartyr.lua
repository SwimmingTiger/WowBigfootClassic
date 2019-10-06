local mod	= DBM:NewMod(485, "DBM-Party-Classic", 20, 241)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(7272)
mod:SetEncounterID(596)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 11089",
	"SPELL_AURA_APPLIED 8600"
)

local warningFeveredPlague			= mod:NewTargetNoFilterAnnounce(8600, 2, nil, "RemoveDisease")
local warningThekaTransoform		= mod:NewSpellAnnounce(11089, 2)

do
	local ThekaTransform = DBM:GetSpellInfo(11089)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 11089 then
		if args.spellName == ThekaTransform then
			warningThekaTransoform:Show()
		end
	end
end

do
	local FeveredPlague = DBM:GetSpellInfo(8600)
	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 8600 and self:CheckDispelFilter() then
		if args.spellName == FeveredPlague and args:IsDestTypePlayer() and self:CheckDispelFilter() then
			warningFeveredPlague:Show(args.destName)
		end
	end
end
