local mod	= DBM:NewMod("OverlordRamtusk", "DBM-Party-Classic", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(4420)
--mod:SetEncounterID(1659)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 8259"
)

local warningWhirlingBarrage		= mod:NewCastAnnounce(8259, 2)

--function mod:OnCombatStart(delay)

--end

do
	local WhirlingBarrage = DBM:GetSpellInfo(8259)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 8259 and self:AntiSpam(3, 1) then
		if args.spellName == WhirlingBarrage and self:AntiSpam(3, 1) then
			warningWhirlingBarrage:Show()
		end
	end
end
