local mod	= DBM:NewMod("Herod", "DBM-Party-Classic", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20200720162120")
mod:SetCreatureID(3975)
--mod:SetEncounterID(585)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 8989 8269"
)

local warningEnrage					= mod:NewTargetNoFilterAnnounce(8269, 2)

local specWarnWhirlwind				= mod:NewSpecialWarningRun(8989, nil, nil, nil, 4, 2)

local timerWhirlwindCD				= mod:NewCDTimer(18, 8989, nil, nil, nil, 4, nil, DBM_CORE_L.DEADLY_ICON)

function mod:OnCombatStart(delay)
	timerWhirlwindCD:Start(10.5-delay)
end

do
	local Whirlwind = DBM:GetSpellInfo(8989)
	local Enrage = DBM:GetSpellInfo(8269)
	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 8269 then
		if args.spellName == Whirlwind and args:IsDestTypeHostile() then
			specWarnWhirlwind:Show()
			specWarnWhirlwind:Play("justrun")
			timerWhirlwindCD:Start()
		elseif args.spellName == Enrage and args:IsDestTypeHostile() then
			warningEnrage:Show(args.destName)
		end
	end
end
