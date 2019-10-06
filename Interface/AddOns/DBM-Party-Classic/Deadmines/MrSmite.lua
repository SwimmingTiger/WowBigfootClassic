local mod	= DBM:NewMod("MrSmite", "DBM-Party-Classic", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(646)
--mod:SetEncounterID(1144)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 6432",
	"SPELL_AURA_APPLIED 6435 6264"
)

local warningSmiteSlam		= mod:NewTargetNoFilterAnnounce(6435, 2)
local warningNimbleReflexes	= mod:NewTargetNoFilterAnnounce(6264, 2)

local timerSmiteStomp		= mod:NewBuffFadesTimer(10, 6432, nil, nil, nil, 2)

--function mod:OnCombatStart(delay)

--end

do
	local Stomp = DBM:GetSpellInfo(6432)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 6432 then
		if args.spellName == Stomp then
			timerSmiteStomp:Start()
		end
	end
end

do
	local Slam, Nimble = DBM:GetSpellInfo(6435), DBM:GetSpellInfo(6264)
	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 6435 then
		if args.spellName == Slam then
			warningSmiteSlam:Show(args.destName)
		--elseif args.spellId == 6264 then
		elseif args.spellName == Nimble then
			warningNimbleReflexes:Show(args.destName)
		end
	end
end
