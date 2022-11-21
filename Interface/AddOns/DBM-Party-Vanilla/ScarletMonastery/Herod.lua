local mod	= DBM:NewMod("Herod", "DBM-Party-Vanilla", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221029204055")
mod:SetCreatureID(3975)
--mod:SetEncounterID(585)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 8989 8269"
)

local warningEnrage					= mod:NewTargetNoFilterAnnounce(8269, 2)
local warningWhirlwind				= mod:NewSpellAnnounce(8989, 2)

local specWarnWhirlwind				= mod:NewSpecialWarningRun(8989, false, nil, 2, 4, 2)

local timerWhirlwindCD				= mod:NewCDTimer(18, 8989, nil, nil, nil, 4, nil, DBM_COMMON_L.DEADLY_ICON)

function mod:OnCombatStart(delay)
	timerWhirlwindCD:Start(10.5-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 8269 and args:IsDestTypeHostile() and self:AntiSpam(3, 1) then
		if self.Options.SpecWarn8269run then
			specWarnWhirlwind:Show()
			specWarnWhirlwind:Play("justrun")
		else
			warningWhirlwind:Show()
		end
		timerWhirlwindCD:Start()
	elseif args.spellId == 8269 and args:IsDestTypeHostile() then
		warningEnrage:Show(args.destName)
	end
end
