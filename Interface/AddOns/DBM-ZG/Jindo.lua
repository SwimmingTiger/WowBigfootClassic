local mod	= DBM:NewMod("Jindo", "DBM-ZG", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(11380)
mod:SetEncounterID(792)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 24306 17172 24261",
	"SPELL_AURA_REMOVED 17172",
	"SPELL_CAST_SUCCESS 24466",
	"SPELL_SUMMON 24309 24262"
)

local warnDelusion			= mod:NewTargetNoFilterAnnounce(24306, 2, nil, "RemoveCurse")
local warnHex				= mod:NewTargetNoFilterAnnounce(17172, 2, nil, "RemoveMagic|Healer")
local warnBrainWash			= mod:NewTargetNoFilterAnnounce(24261, 4)
local warnBanish			= mod:NewTargetNoFilterAnnounce(24466, 2)

local specWarnHealingWard	= mod:NewSpecialWarningSwitch(24309, "Dps", nil, nil, 1, 2)
local specWarnBrainTotem	= mod:NewSpecialWarningSwitch(24262, "Dps", nil, nil, 1, 2)
local specWarnDelusion		= mod:NewSpecialWarningYou(24306, nil, nil, nil, 1, 2)--Don't remember why this has special warning, but trusting 2011 me

local timerHex				= mod:NewTargetTimer(5, 17172, nil, "RemoveMagic|Healer", nil, 5, nil, DBM_CORE_L.MAGIC_ICON)
local timerDelusion			= mod:NewTargetTimer(20, 24306, nil, "RemoveCurse", nil, 5, nil, DBM_CORE_L.CURSE_ICON)

--function mod:OnCombatStart(delay)
--end

do
	local DelusionsofJindo, Hex, BrainWash = DBM:GetSpellInfo(24306), DBM:GetSpellInfo(17172), DBM:GetSpellInfo(24261)
	function mod:SPELL_AURA_APPLIED(args)
		--if args:IsSpellID(24306) then
		if args.spellName == DelusionsofJindo then
			timerDelusion:Start(args.destName)
			if args:IsPlayer() then
				specWarnDelusion:Show()
				specWarnDelusion:Play("targetyou")
			else
				warnDelusion:Show(args.destName)
			end
		--elseif args:IsSpellID(17172) then
		elseif args.spellName == Hex and args:IsDestTypePlayer() then
			timerHex:Start(args.destName)
			warnHex:Show(args.destName)
		--elseif args:IsSpellID(24261) then
		elseif args.spellName == BrainWash then
			warnBrainWash:Show(args.destName)
		end
	end

	function mod:SPELL_AURA_REMOVED(args)
		--if args:IsSpellID(17172) then
		if args.spellName == Hex and args:IsDestTypePlayer() then
			timerHex:Stop(args.destName)
		end
	end
end

do
	local Banish = DBM:GetSpellInfo(24466)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args:IsSpellID(24466) then
		if args.spellName == Banish and args:IsSrcTypeHostile() then
			warnBanish:Show(args.destName)
		end
	end
end

do
	local HealingWard, BrainTotem = DBM:GetSpellInfo(24309), DBM:GetSpellInfo(24262)
	function mod:SPELL_SUMMON(args)
		--if args:IsSpellID(24309) then
		if args.spellName == HealingWard and args:IsDestTypeHostile() then
			specWarnHealingWard:Show()
			specWarnHealingWard:Play("attacktotem")
		--elseif args:IsSpellID(24262) then
		elseif args.spellName == BrainTotem then
			specWarnBrainTotem:Show()
			specWarnBrainTotem:Play("attacktotem")
		end
	end
end
