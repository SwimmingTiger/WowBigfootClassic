local mod = DBM:NewMod(548, "DBM-Party-BC", 15, 254)
local L = mod:GetLocalizedStrings()


mod:SetRevision("20210401043939")

mod:SetCreatureID(20870)
mod:SetEncounterID(1916)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 36127 39005",
	"SPELL_CAST_SUCCESS 36119 30533",
	"SPELL_AURA_APPLIED 39367 32863",
	"SPELL_AURA_REMOVED 39367 32863"
)

--TODO, GTFO for void zones
local warnVoid      = mod:NewSpellAnnounce(36119, 3)

local specwarnNova	= mod:NewSpecialWarningSpell(39005, nil, nil, nil, 2, 2)
local specwarnSoC	= mod:NewSpecialWarningDispel(39367, "Healer", nil, nil, 1, 2)

local timerSoC      = mod:NewTargetTimer(18, 39367, nil, "Healer", 2, 3, nil, DBM_CORE_L.MAGIC_ICON)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(36127, 39005) then
		specwarnNova:Show()
		specwarnNova:Play("aesoon")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(36119, 30533) then
		warnVoid:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(39367, 32863) then
		if self:CheckDispelFilter() then
			specwarnSoC:Show(args.destName)
			specwarnSoC:Play("dispelnow")
		end
		timerSoC:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(39367, 32863) then
		timerSoC:Stop(args.destName)
	end
end
