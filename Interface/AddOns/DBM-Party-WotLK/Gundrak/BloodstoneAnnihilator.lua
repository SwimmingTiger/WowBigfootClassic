local mod	= DBM:NewMod(593, "DBM-Party-WotLK", 5, 274)
local L		= mod:GetLocalizedStrings()


mod:SetRevision("20220930022912")
mod:SetCreatureID(29307)
mod:SetEncounterID(1983)
--
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 54850 54878",
	"SPELL_PERIODIC_DAMAGE 59451"
)

local warningStone			= mod:NewSpellAnnounce(54878, 3)
local warningElemental		= mod:NewSpellAnnounce(54850, 3)

local specWarnPurpleShit	= mod:NewSpecialWarningGTFO(59451, nil, nil, nil, 1, 8)

function mod:SPELL_CAST_START(args)
	if args.spellId == 54850 then
		warningElemental:Show()
	elseif args.spellId == 54878 then
		warningStone:Show()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 59451 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) and not self:IsTrivial() then
		specWarnPurpleShit:Show(spellName)
		specWarnPurpleShit:Play("watchfeet")
	end
end
