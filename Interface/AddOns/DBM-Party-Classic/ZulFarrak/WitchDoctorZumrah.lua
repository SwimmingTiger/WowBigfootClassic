local mod	= DBM:NewMod(486, "DBM-Party-Classic", 20, 241)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(7271)
mod:SetEncounterID(597)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 12491 15245",
	"SPELL_CAST_SUCCESS 11086"
)

local warningWardZumrah				= mod:NewSpellAnnounce(11086, 2)

local specWarnHealingWave			= mod:NewSpecialWarningInterrupt(12491, "HasInterrupt", nil, nil, 1, 2)
local specWarnShadowBoltVolley		= mod:NewSpecialWarningInterrupt(15245, "HasInterrupt", nil, nil, 1, 2)

local timerWardZumrahCD				= mod:NewAITimer(180, 11086, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
local timerHealingWaveCD			= mod:NewAITimer(180, 12491, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerShadowBoltVolleyCD		= mod:NewAITimer(180, 15245, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)

function mod:OnCombatStart(delay)
	timerWardZumrahCD:Start(1-delay)
	timerHealingWaveCD:Start(1-delay)
	timerShadowBoltVolleyCD:Start(1-delay)
end

do
	local HealingWave, ShadowBoltVolley = DBM:GetSpellInfo(12491), DBM:GetSpellInfo(15245)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 12491 then
		if args.spellName == HealingWave and args:IsSrcTypeHostile() then
			timerHealingWaveCD:Start()
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnHealingWave:Show(args.sourceName)
				specWarnHealingWave:Play("kickcast")
			end
		--elseif args.spellId == 15245 then
		elseif args.spellName == ShadowBoltVolley and args:IsSrcTypeHostile() then
			timerShadowBoltVolleyCD:Start()
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnShadowBoltVolley:Show(args.sourceName)
				specWarnShadowBoltVolley:Play("kickcast")
			end
		end
	end
end

do
	local WardZumrah = DBM:GetSpellInfo(11086)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 11086 then
		if args.spellName == WardZumrah then
			warningWardZumrah:Show()
			timerWardZumrahCD:Start()
		end
	end
end
