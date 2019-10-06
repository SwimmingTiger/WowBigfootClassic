local mod	= DBM:NewMod("Tutenkash", "DBM-Party-Classic", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(7355)
--mod:SetEncounterID(585)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 12255 12252",
	"SPELL_AURA_APPLIED 12255"
)

local warningCurseofTut				= mod:NewTargetNoFilterAnnounce(12255, 2, nil, "RemoveCurse")
local warningWebSpray				= mod:NewSpellAnnounce(12252, 2)

local timerCurseofTutCD				= mod:NewAITimer(180, 12255, nil, nil, nil, 3, nil, DBM_CORE_CURSE_ICON)
local timerWebSprayCD				= mod:NewAITimer(180, 12252, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)

function mod:OnCombatStart(delay)
	timerCurseofTutCD:Start(1-delay)
	timerWebSprayCD:Start(1-delay)
end

do
	local CurseofTut, WebSpray = DBM:GetSpellInfo(12255), DBM:GetSpellInfo(12252)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 12255 then
		if args.spellName == CurseofTut then
			timerCurseofTutCD:Start()
		--elseif args.spellId == 12252 then
		elseif args.spellName == WebSpray then
			warningWebSpray:Show()
			timerWebSprayCD:Start()
		end
	end

	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 12255 and self:CheckDispelFilter() then
		if args.spellId == CurseofTut and self:CheckDispelFilter() then
			warningCurseofTut:Show(args.destName)
		end
	end
end
