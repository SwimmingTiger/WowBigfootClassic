local mod	= DBM:NewMod(473, "DBM-Party-Classic", 18, 239)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(2748)
mod:SetEncounterID(554)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 10252 10258",
	"SPELL_CAST_SUCCESS 6524"
)

local warningAwakenEarthenGuardians		= mod:NewSpellAnnounce(10252, 2)
local warningAwakenVaultWarder			= mod:NewSpellAnnounce(10258, 2)
local warningGroundTremor				= mod:NewSpellAnnounce(6524, 3)

local timerAwakenEarthenGuardiansCD		= mod:NewAITimer(180, 10252, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
local timerGroundTremorCD				= mod:NewAITimer(180, 6524, nil, nil, nil, 2)

function mod:OnCombatStart(delay)
	timerAwakenEarthenGuardiansCD:Start(1-delay)
	timerGroundTremorCD:Start(1-delay)
end

do
	local EarthGuardians, VaultWarder = DBM:GetSpellInfo(10252), DBM:GetSpellInfo(10258)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 10252 then
		if args.spellName == EarthGuardians then
			warningAwakenEarthenGuardians:Show()
			timerAwakenEarthenGuardiansCD:Start()
		--elseif args.spellId == 10258 then
		elseif args.spellName == VaultWarder then
			warningAwakenVaultWarder:Show()
		end
	end
end

do
	local GroundTremor = DBM:GetSpellInfo(6524)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 6524 then
		if args.spellName == GroundTremor then
			warningGroundTremor:Show()
			timerGroundTremorCD:Start()
		end
	end
end
