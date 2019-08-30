local mod	= DBM:NewMod("ArcanistDoan", "DBM-Party-Classic", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190810222722")
mod:SetCreatureID(6487)
--mod:SetEncounterID(585)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 9435",
	"SPELL_CAST_SUCCESS 8988 9433",
	"SPELL_AURA_APPLIED 13323 8988"
)

local warningPolymorph				= mod:NewTargetNoFilterAnnounce(13323, 2)
local warningSilence				= mod:NewTargetNoFilterAnnounce(8988, 2)
local warningArcaneExplosion		= mod:NewSpellAnnounce(9433, 2)

local specWarnDetonation			= mod:NewSpecialWarningRun(9435, nil, nil, nil, 4, 2)

local timerDetonationCD				= mod:NewAITimer(180, 9435, nil, nil, nil, 2)
local timerSilenceCD				= mod:NewAITimer(180, 8988, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
local timerArcaneExplosionCD		= mod:NewAITimer(180, 9433, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)

function mod:OnCombatStart(delay)
	timerDetonationCD:Start(1-delay)
	timerSilenceCD:Start(1-delay)
	timerArcaneExplosionCD:Start(1-delay)
end

do
	local Detonation = DBM:GetSpellInfo(9435)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 9435 then
		if args.spellName == Detonation then
			specWarnDetonation:Show()
			specWarnDetonation:Play("justrun")
			timerDetonationCD:Start()
		end
	end
end

do
	local ArcaneExplosion, Silence, Polymorph = DBM:GetSpellInfo(9433), DBM:GetSpellInfo(8988), DBM:GetSpellInfo(13323)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 9433 then
		if args.spellName == ArcaneExplosion and args:IsSrcTypeHostile() then
			warningArcaneExplosion:Show()
			timerArcaneExplosionCD:Start()
		--elseif args.spellId == 8988 then
		elseif args.spellName == Silence and args:IsSrcTypeHostile() then
			timerSilenceCD:Start()
		end
	end

	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 13323 then
		if args.spellName == Polymorph and args:IsDestTypePlayer() then
			warningPolymorph:Show(args.destName)
		--elseif args.spellId == 8988 then
		elseif args.spellName == Silence and args:IsDestTypePlayer() then
			warningSilence:Show(args.destName)
		end
	end
end
