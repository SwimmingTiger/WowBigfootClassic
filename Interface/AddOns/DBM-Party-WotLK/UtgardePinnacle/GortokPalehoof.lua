local mod	= DBM:NewMod(642, "DBM-Party-WotLK", 11, 286)
local L		= mod:GetLocalizedStrings()


mod:SetRevision("20220724021612")
mod:SetCreatureID(26687)
mod:SetEncounterID(2027)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 48261 59268"
)

local warningImpale		= mod:NewTargetNoFilterAnnounce(48261, 2, nil, "Healer")

local timerImpale		= mod:NewTargetTimer(9, 48261, nil, "Healer", 2, 5, nil, DBM_COMMON_L.HEALER_ICON)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(48261, 59268) then
		warningImpale:Show(args.destName)
		timerImpale:Start(args.destName)
	end
end
