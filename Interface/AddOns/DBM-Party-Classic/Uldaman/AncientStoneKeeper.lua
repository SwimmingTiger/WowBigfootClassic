local mod	= DBM:NewMod(470, "DBM-Party-Classic", 18, 239)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(7206)
mod:SetEncounterID(551)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 10132 10094"
)

local warningSandStorms				= mod:NewSpellAnnounce(10132, 2)

local timerSandStormsCD				= mod:NewAITimer(180, 10132, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
	timerSandStormsCD:Start(1-delay)
end

do
	local SandStorms = DBM:GetSpellInfo(10132)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 10132 or args.spellId == 10094 then
		if args.spellName == SandStorms then
			warningSandStorms:Show()
			timerSandStormsCD:Start()
		end
	end
end
