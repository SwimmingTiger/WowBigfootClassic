local mod	= DBM:NewMod(455, "DBM-Party-Classic", 16, 236)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(10439)
mod:SetEncounterID(483)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 17307 5568"
)

local warningKnockout			= mod:NewSpellAnnounce(17307, 2)
local warningTrample			= mod:NewSpellAnnounce(5568, 2)

local timerKnockoutCD			= mod:NewAITimer(180, 17307, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerTrampleCD			= mod:NewAITimer(180, 5568, nil, nil, nil, 2)

function mod:OnCombatStart(delay)
	timerKnockoutCD:Start(1-delay)
	timerTrampleCD:Start(1-delay)
end

do
	local Knockout, Trample = DBM:GetSpellInfo(17307), DBM:GetSpellInfo(5568)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 17307 then
		if args.spellName == Knockout and args:IsSrcTypeHostile() then
			warningKnockout:Show()
			timerKnockoutCD:Start()
		--elseif args.spellId == 5568 then
		elseif args.spellName == Trample and args:IsSrcTypeHostile() then
			warningTrample:Show()
			timerTrampleCD:Start()
		end
	end
end
