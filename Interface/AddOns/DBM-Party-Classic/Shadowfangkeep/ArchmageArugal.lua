local mod	= DBM:NewMod("ArchmageArugal", "DBM-Party-Classic", 14)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(4275)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 7621 7587",
	"SPELL_AURA_APPLIED 7621"
)

local warningArugalsCurse			= mod:NewTargetNoFilterAnnounce(7621, 2)
local warningShadowPort				= mod:NewSpellAnnounce(7587, 2)

local timerArugalsCurseCD			= mod:NewAITimer(180, 7621, nil, nil, nil, 3, nil, DBM_CORE_CURSE_ICON)
local timerShadowPortCD				= mod:NewAITimer(180, 7587, nil, nil, nil, 6)

function mod:OnCombatStart(delay)
	timerArugalsCurseCD:Start(1-delay)
	timerShadowPortCD:Start(1-delay)
end

do
	local ArugalsCurse, ShadowPort = DBM:GetSpellInfo(7621), DBM:GetSpellInfo(7587)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 7621 then
		if args.spellName == ArugalsCurse then
			timerArugalsCurseCD:Start()
		--elseif args.spellId == 7587 then
		elseif args.spellName == ShadowPort then
			warningShadowPort:Show()
			timerShadowPortCD:Start()
		end
	end

	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 7621 then
		if args.spellName == ArugalsCurse then
			warningArugalsCurse:Show(args.destName)
		end
	end
end
