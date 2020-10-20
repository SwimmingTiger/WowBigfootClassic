local mod	= DBM:NewMod(469, "DBM-Party-Classic", 18, 239)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20200817152042")
mod:SetCreatureID(7228)
mod:SetEncounterID(549)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 8374 11876"
)

local warningArcingSmash			= mod:NewSpellAnnounce(8374, 2)
local warningWarStomp				= mod:NewSpellAnnounce(11876, 2)

local timerArcingSmashCD			= mod:NewAITimer(180, 8374, nil, "Tank", 2, 5, nil, DBM_CORE_L.TANK_ICON)
local timerWarStompCD				= mod:NewAITimer(180, 11876, nil, nil, nil, 2)

function mod:OnCombatStart(delay)
	timerArcingSmashCD:Start(1-delay)
	timerWarStompCD:Start(1-delay)
end

do
	local ArcingSmash, WarStomp = DBM:GetSpellInfo(8374),  DBM:GetSpellInfo(11876)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 8374 then
		if args.spellName == ArcingSmash then
			warningArcingSmash:Show()
			timerArcingSmashCD:Start()
		--elseif args.spellId == 11876 then
		elseif args.spellName == WarStomp then
			warningWarStomp:Show()
			timerWarStompCD:Start()
		end
	end
end
