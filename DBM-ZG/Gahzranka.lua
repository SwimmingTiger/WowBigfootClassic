local mod	= DBM:NewMod("Gahzranka", "DBM-ZG", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15114)
mod:SetEncounterID(790)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 16099 22421"
)

--Correct Geyser ID? this one says hydrospawn in diremaul
local warnBreath	= mod:NewCastAnnounce(16099)
local warnGeyser	= mod:NewCastAnnounce(22421)

--function mod:OnCombatStart(delay)
--end

do
	local FrostBreath, MassiveGeyser = DBM:GetSpellInfo(16099), DBM:GetSpellInfo(22421)
	function mod:SPELL_CAST_START(args)
		--if args:IsSpellID(16099) then
		if args.spellName == FrostBreath then
			warnBreath:Show()
		--elseif args:IsSpellID(22421) then
		elseif args.spellName == MassiveGeyser then
			warnGeyser:Show()
		end
	end
end
