local mod	= DBM:NewMod(421, "DBM-Party-Classic", 7, 231)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(6235)
mod:SetEncounterID(380)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 11082 11085",
	"SPELL_CAST_SUCCESS 11084"
)

local warningShock				= mod:NewSpellAnnounce(11084, 2, nil, "Tank|Healer")

local specWarnMegavolt			= mod:NewSpecialWarningInterrupt(11082, "HasInterrupt", nil, nil, 1, 2)
local specWarnChainBolt			= mod:NewSpecialWarningInterrupt(11085, "HasInterrupt", nil, nil, 1, 2)

local timerMegavoltCD			= mod:NewAITimer(180, 11082, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerChainBoltCD			= mod:NewAITimer(180, 11085, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerShockCD				= mod:NewAITimer(180, 11084, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_TANK_ICON)

function mod:OnCombatStart(delay)
	timerMegavoltCD:Start(1-delay)
	timerChainBoltCD:Start(1-delay)
	timerShockCD:Start(1-delay)
end

do
	local Megavolt, ChainBolt = DBM:GetSpellInfo(11082), DBM:GetSpellInfo(11085)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 11082 then
		if args.spellName == Megavolt then
			timerMegavoltCD:Start()
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnMegavolt:Show(args.sourceName)
				specWarnMegavolt:Play("kickcast")
			end
		--elseif args.spellId == 11085 then
		elseif args.spellName == ChainBolt then
			timerChainBoltCD:Start()
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnChainBolt:Show(args.sourceName)
				specWarnChainBolt:Play("kickcast")
			end
		end
	end
end

do
	local Shock = DBM:GetSpellInfo(11084)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 11084 then
		if args.spellName == Shock then
			warningShock:Show()
			timerShockCD:Start()
		end
	end
end
