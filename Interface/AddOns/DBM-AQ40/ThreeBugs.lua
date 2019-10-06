local mod	= DBM:NewMod("ThreeBugs", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(15544, 15511, 15543)
mod:SetEncounterID(710)
mod:SetModelID(15657)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 26580",
	"SPELL_CAST_START 25807",
	"UNIT_DIED"
)

local warnFear			= mod:NewSpellAnnounce(26580, 2)
local warnHeal			= mod:NewCastAnnounce(25807, 3)

local specWarnHeal		= mod:NewSpecialWarningInterrupt(25807, "HasInterrupt", nil, nil, 1, 2)

local timerFearCD		= mod:NewCDTimer(20.5, 26580, nil, nil, nil, 2)
local timerHeal			= mod:NewCastTimer(2, 25807, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)

function mod:OnCombatStart(delay)
	timerFearCD:Start(10-delay)
end

do
	local Fear = DBM:GetSpellInfo(26580)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 26580 and self:AntiSpam() then
		if args.spellName == Fear and args:IsSrcTypeHostile() and self:AntiSpam() then
			warnFear:Show()
			timerFearCD:Start()
		end
	end
end

do
	local GreatHeal = DBM:GetSpellInfo(25807)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 25807 then
		if args.spellName == GreatHeal and args:IsSrcTypeHostile() then
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnHeal:Show(args.sourceName)
				specWarnHeal:Play("kickcast")
			else
				warnHeal:Show()
			end
			timerHeal:Start()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 15543 then
		timerFearCD:Stop()
	end
end
