local mod	= DBM:NewMod(570, "DBM-Party-BC", 4, 260)
local L		= mod:GetLocalizedStrings()


mod:SetRevision("20210401043939")
mod:SetCreatureID(17941)
mod:SetEncounterID(1939)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_SUMMON 31991"
)

local specWarnCorruptedNova		= mod:NewSpecialWarningSwitch(31991, "Dps", nil, nil, 1, 2)

function mod:SPELL_SUMMON(args)
	if args.spellId == 31991 then
		specWarnCorruptedNova:Show()
		specWarnCorruptedNova:Play("attacktotem")
	end
end
