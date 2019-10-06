local mod	= DBM:NewMod(420, "DBM-Party-Classic", 7, 231)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(7079)
mod:SetEncounterID(378)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 21687"
)

local warningToxicVolley			= mod:NewSpellAnnounce(21687, 2, nil, "Healer|RemovePoison")

local timerToxicVolleyCD			= mod:NewAITimer(180, 21687, nil, nil, nil, 3, nil, DBM_CORE_POISON_ICON)

function mod:OnCombatStart(delay)
	timerToxicVolleyCD:Start(1-delay)
end

do
	local ToxicVolley = DBM:GetSpellInfo(21687)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 21687 then
		if args.spellName == ToxicVolley then
			warningToxicVolley:Show()
			timerToxicVolleyCD:Start()
		end
	end
end
