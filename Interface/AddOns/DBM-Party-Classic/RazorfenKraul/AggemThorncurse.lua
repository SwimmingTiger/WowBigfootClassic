local mod	= DBM:NewMod("AggemThorncurse", "DBM-Party-Classic", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190810210513")
mod:SetCreatureID(4424)
--mod:SetEncounterID(438)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 8286"
)

--https://classic.wowhead.com/spell=14900/chain-heal Nani?
local warningSummonBoar		= mod:NewSpellAnnounce(8286, 2)

local timerSummonBoarCD		= mod:NewAITimer(180, 8286, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)

function mod:OnCombatStart(delay)
	timerSummonBoarCD:Start(1-delay)
end

do
	local SummonBoar = DBM:GetSpellInfo(8286)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 8286 then
		if args.spellName == SummonBoar then
			warningSummonBoar:Show()
			timerSummonBoarCD:Start()
		end
	end
end
