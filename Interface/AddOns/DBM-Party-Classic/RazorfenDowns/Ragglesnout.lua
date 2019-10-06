local mod	= DBM:NewMod("Ragglesnout", "DBM-Party-Classic", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(7354)
--mod:SetEncounterID(585)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 12039 7645",
	"SPELL_AURA_APPLIED 7645"
)

local warningDominateMind			= mod:NewTargetNoFilterAnnounce(7645, 2)

local specWarnHeal					= mod:NewSpecialWarningInterrupt(12039, "HasInterrupt", nil, nil, 1, 2)

local timerHealCD					= mod:NewAITimer(180, 12039, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerDominateMindCD			= mod:NewAITimer(180, 7645, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
	timerHealCD:Start(1-delay)
	timerDominateMindCD:Start(1-delay)
end

do
	local Heal, DominateMind = DBM:GetSpellInfo(12039), DBM:GetSpellInfo(7645)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 12039 then
		if args.spellName == Heal and args:IsSrcTypeHostile() then
			timerHealCD:Start()
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnHeal:Show(args.sourceName)
				specWarnHeal:Play("kickcast")
			end
		--elseif args.spellId == 7645 then
		elseif args.spellName == DominateMind then
			timerDominateMindCD:Start()
		end
	end

	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 7645 then
		if args.spellName == DominateMind then
			warningDominateMind:Show(args.destName)
		end
	end
end
