local mod	= DBM:NewMod(484, "DBM-Party-Classic", 20, 241)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(8127)
mod:SetEncounterID(595)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 11895 15982 4971 8376",
	"SPELL_CAST_SUCCESS 11894"
)

--TODO, Totems on shared timer?
--TODO, tone down special warnings if they are too much. They might be more than people are used to/want in classic
local warningEarthgrabTotem			= mod:NewSpellAnnounce(8376, 2)
local warningHealingWard			= mod:NewSpellAnnounce(4971, 4)

local specWarnHealingWaveSelf			= mod:NewSpecialWarningInterrupt(11895, "HasInterrupt", nil, nil, 1, 2)
local specWarnHealingWaveAlly			= mod:NewSpecialWarningInterrupt(15982, "HasInterrupt", nil, nil, 1, 2)
local specWarnMinions					= mod:NewSpecialWarningSwitch(11894, "Dps", nil, nil, 1, 2)

local timerHealingWaveSelfCD			= mod:NewAITimer(180, 11895, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerHealingWaveAllyCD			= mod:NewAITimer(180, 15982, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerMinionsCD					= mod:NewAITimer(180, 11894, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)

function mod:OnCombatStart(delay)
	timerHealingWaveSelfCD:Start(1-delay)
	timerHealingWaveAllyCD:Start(1-delay)
	timerMinionsCD:Start(1-delay)
end

do
	local HealingWaveOfAntusul, HealingWave, EarthGrabTotem, HealingWard = DBM:GetSpellInfo(11895), DBM:GetSpellInfo(15982), DBM:GetSpellInfo(8376), DBM:GetSpellInfo(4971)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 11895 then
		if args.spellName == HealingWaveOfAntusul then
			timerHealingWaveSelfCD:Start()
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnHealingWaveSelf:Show(args.sourceName)
				specWarnHealingWaveSelf:Play("kickcast")
			end
		--elseif args.spellId == 15982 then
		elseif args.spellName == HealingWave and args:IsSrcTypeHostile() then
			timerHealingWaveAllyCD:Start()
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnHealingWaveAlly:Show(args.sourceName)
				specWarnHealingWaveAlly:Play("kickcast")
			end
		--elseif args.spellId == 8376 then
		elseif args.spellName == EarthGrabTotem and args:IsSrcTypeHostile() then
			warningEarthgrabTotem:Show()
		--elseif args.spellId == 4971 then
		elseif args.spellName == HealingWard and args:IsSrcTypeHostile() then
			warningHealingWard:Show()
		end
	end
end

do
	local Minions = DBM:GetSpellInfo(11894)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 11894 then
		if args.spellName == Minions then
			specWarnMinions:Show()
			specWarnMinions:Play("killmob")
			timerMinionsCD:Start()
		end
	end
end
