local mod	= DBM:NewMod(472, "DBM-Party-Classic", 18, 239)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(4854)
mod:SetEncounterID(553)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 8292 12167",
	"SPELL_CAST_SUCCESS 6742",
	"SPELL_AURA_APPLIED 6742 9906"
)

local warningBloodlust				= mod:NewTargetNoFilterAnnounce(6742, 3)
local warningReflection				= mod:NewTargetNoFilterAnnounce(9906, 4)
local warningCrystallineSlumber		= mod:NewTargetNoFilterAnnounce(3636, 4, nil, "RemoveMagic")

local specWarnChainBolt				= mod:NewSpecialWarningInterrupt(8292, "HasInterrupt", nil, nil, 1, 2)
local specWarnLightningBolt			= mod:NewSpecialWarningInterrupt(12167, false, nil, nil, 1, 2)

local timerChainBoltCD				= mod:NewAITimer(180, 8292, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerLightningBoltCD			= mod:NewAITimer(180, 12167, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerBloodlustCD				= mod:NewAITimer(180, 6742, nil, nil, nil, 5, nil, DBM_CORE_MAGIC_ICON)

function mod:OnCombatStart(delay)
	timerChainBoltCD:Start(1-delay)
	timerLightningBoltCD:Start(1-delay)
	timerBloodlustCD:Start(1-delay)
end

do
	local ChainBolt, LightingBolt = DBM:GetSpellInfo(8292), DBM:GetSpellInfo(12167)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 8292 then
		if args.spellName == ChainBolt and args:IsSrcTypeHostile() then
			timerChainBoltCD:Start()
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnChainBolt:Show(args.sourceName)
				specWarnChainBolt:Play("kickcast")
			end
		--elseif args.spellId == 12167 then
		elseif args.spellName == LightingBolt and args:IsSrcTypeHostile() then
			timerLightningBoltCD:Start()
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnLightningBolt:Show(args.sourceName)
				specWarnLightningBolt:Play("kickcast")
			end
		end
	end
end

do
	local Bloodlust, Reflection, CrystallineSlumber = DBM:GetSpellInfo(6742), DBM:GetSpellInfo(9906), DBM:GetSpellInfo(3636)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 6742 then
		if args.spellName == Bloodlust and args:IsSrcTypeHostile() then
			timerBloodlustCD:Start()
		end
	end

	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 6742 then
		if args.spellName == Bloodlust and args:IsDestTypeHostile() then
			warningBloodlust:Show(args.destName)
		--elseif args.spellId == 9906 then
		elseif args.spellName == Reflection then
			warningReflection:Show(args.destName)
		--elseif args.spellId == 3636 then
		elseif args.spellName == CrystallineSlumber then
			warningCrystallineSlumber:Show(args.destName)
		end
	end
end
