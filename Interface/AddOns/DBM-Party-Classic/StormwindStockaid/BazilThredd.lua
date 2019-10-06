local mod	= DBM:NewMod("BazilThredd", "DBM-Party-Classic", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(1716)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 7964"
)

local warningSmokeBomb			= mod:NewSpellAnnounce(7964, 2)

local timerSmokeBombCD			= mod:NewCDTimer(15.8, 7964, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
	timerSmokeBombCD:Start(8-delay)
end

do
	local SmokeBomb = DBM:GetSpellInfo(7964)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 7964 then
		if args.spellName == SmokeBomb and args:IsSrcTypeHostile() then
			warningSmokeBomb:Show()
			timerSmokeBombCD:Start()
		end
	end
end
