local mod	= DBM:NewMod(487, "DBM-Party-Classic", 20, 241)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(7796, 7275)--nekrum-gutchewer, shadowpriest-sezzziz
--mod:SetEncounterID(598, 599)--Each boss has it's own encounter ID?

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 8362 12039",
	"SPELL_CAST_SUCCESS 13704",
	"SPELL_AURA_APPLIED 8600",
	"UNIT_DIED"
)

local warningFeveredPlague			= mod:NewTargetNoFilterAnnounce(8600, 2, nil, "RemoveDisease")

local specWarnRenew					= mod:NewSpecialWarningInterrupt(8362, "HasInterrupt", nil, nil, 1, 2)
local specWarnHeal					= mod:NewSpecialWarningInterrupt(12039, "HasInterrupt", nil, nil, 1, 2)

local timerRenewCD					= mod:NewAITimer(180, 8362, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON..DBM_CORE_MAGIC_ICON)
local timerHealCD					= mod:NewAITimer(180, 12039, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerPsychicScreamCD			= mod:NewAITimer(180, 13704, nil, nil, nil, 2)

function mod:OnCombatStart(delay)
	timerRenewCD:Start(1-delay)
	timerHealCD:Start(1-delay)
	timerPsychicScreamCD:Start(1-delay)
end

do
	local Renew, Heal = DBM:GetSpellInfo(8362), DBM:GetSpellInfo(12039)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 8362 then
		if args.spellName == Renew and args:IsSrcTypeHostile() then
			timerRenewCD:Start()
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnRenew:Show(args.sourceName)
				specWarnRenew:Play("kickcast")
			end
		--elseif args.spellId == 12039 then
		elseif args.spellName == Heal and args:IsSrcTypeHostile() then
			timerHealCD:Start()
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnHeal:Show(args.sourceName)
				specWarnHeal:Play("kickcast")
			end
		end
	end
end

do
	local PsychicScream = DBM:GetSpellInfo(13704)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 13704 then
		if args.spellName == PsychicScream and args:IsSrcTypeHostile() then
			timerPsychicScreamCD:Start()
		end
	end
end

do
	local FeveredPlague = DBM:GetSpellInfo(8600)
	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 8600 and self:CheckDispelFilter() then
		if args.spellName == FeveredPlague and args:IsDestTypePlayer() and self:CheckDispelFilter() then
			warningFeveredPlague:Show(args.destName)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 7275 then--sezzziz
		timerRenewCD:Stop()
		timerHealCD:Stop()
		timerPsychicScreamCD:Stop()
	end
end
