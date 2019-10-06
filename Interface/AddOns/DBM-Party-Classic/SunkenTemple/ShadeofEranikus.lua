local mod	= DBM:NewMod(463, "DBM-Party-Classic", 17, 237)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(5709)
mod:SetEncounterID(493)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 12890 12533 24375",
	"SPELL_AURA_APPLIED 12890"
)

local warningDeepSlumber			= mod:NewTargetNoFilterAnnounce(12890, 2)
local warningAcidBreath				= mod:NewSpellAnnounce(12533, 2)
local warningWarStomp				= mod:NewSpellAnnounce(24375, 2)

local timerDeepSlumberCD			= mod:NewAITimer(180, 12890, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
local timerAcidBreathCD				= mod:NewAITimer(180, 12533, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerWarStompCD				= mod:NewAITimer(180, 24375, nil, nil, nil, 2)

function mod:OnCombatStart(delay)
	timerDeepSlumberCD:Start(1-delay)
	timerAcidBreathCD:Start(1-delay)
	timerWarStompCD:Start(1-delay)
end

do
	local DeepSlumber, AcidBreath, WarStomp = DBM:GetSpellInfo(12890), DBM:GetSpellInfo(12533), DBM:GetSpellInfo(24375)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 12890 then
		if args.spellName == DeepSlumber then
			timerDeepSlumberCD:Start()
		--elseif args.spellId == 12533 then
		elseif args.spellName == AcidBreath then
			warningAcidBreath:Show()
			timerAcidBreathCD:Start()
		--elseif args.spellId == 24375 then
		elseif args.spellName == WarStomp and args:IsSrcTypeHostile() then
			warningWarStomp:Show()
			timerWarStompCD:Start()
		end
	end

	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 12890 then
		if args.spellName == DeepSlumber then
			warningDeepSlumber:Show(args.destName)
		end
	end
end
