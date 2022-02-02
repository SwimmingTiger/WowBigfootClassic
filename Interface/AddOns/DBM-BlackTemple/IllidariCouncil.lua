local mod	= DBM:NewMod("Council", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220201054724")
mod:SetCreatureID(22949, 22950, 22951, 22952)
mod:SetEncounterID(608, 2480)
mod:SetModelID(21416)
mod:SetUsedIcons(1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 41455",
	"SPELL_CAST_SUCCESS 41455",
	"SPELL_AURA_APPLIED 41485 41481 41482 41541 41476 41475 41452 41453 41450 41451",
	"SPELL_AURA_REMOVED 41479 41485"
)

local warnPoison			= mod:NewTargetNoFilterAnnounce(41485, 3, nil, "Healer", 3)
local warnVanish			= mod:NewTargetNoFilterAnnounce(41476, 3)
local warnVanishEnd			= mod:NewEndAnnounce(41476, 3)
local warnDevAura			= mod:NewSpellAnnounce(41452, 3, nil, "Physical", 2)
local warnResAura			= mod:NewSpellAnnounce(41453, 3, nil, "-Physical", 2)

local specWarnShield		= mod:NewSpecialWarningReflect(41475, "Dps", nil, nil, 1, 2)
local specWarnGTFO			= mod:NewSpecialWarningGTFO(41481, nil, nil, nil, 1, 8)
local specWarnCoH			= mod:NewSpecialWarningInterrupt(41455, "HasInterrupt", nil, 2, 1, 2)
local specWarnImmune		= mod:NewSpecialWarning("Immune", false)

local timerVanish			= mod:NewBuffActiveTimer(30, 41476, nil, nil, nil, 6)
local timerShield			= mod:NewBuffActiveTimer(20, 41475, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.DAMAGE_ICON)
local timerMeleeImmune		= mod:NewTargetTimer(15, 41450, nil, "Physical", 2, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerSpellImmune		= mod:NewTargetTimer(15, 41451, nil, "-Physical", 2, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerDevAura			= mod:NewBuffActiveTimer(30, 41452, nil, "Physical", 2, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerResAura			= mod:NewBuffActiveTimer(30, 41453, nil, "-Physical", 2, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerNextCoH			= mod:NewCDTimer(14, 41455, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--Seems to be CD+lockout if interrupted, but not hardcoding every lockout in game to figure it out

local berserkTimer			= mod:NewBerserkTimer(900)

mod:AddSetIconOption("PoisonIcon", 41485)

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 41485 then
		warnPoison:Show(args.destName)
		if self.Options.PoisonIcon then
			self:SetIcon(args.destName, 1)
		end
	elseif args:IsSpellID(41481, 41482, 41541) and args:IsPlayer() and self:AntiSpam(2.5, 1) and not self:IsTrivial() then
		 specWarnGTFO:Show(args.spellName)
		 specWarnGTFO:Play("watchfeet")
	elseif spellId == 41476 then
		warnVanish:Show(args.destName)
		timerVanish:Start(args.destName)
	elseif spellId == 41475 and not self:IsTrivial() then
		specWarnShield:Show(args.destName)
		specWarnShield:Play("stopattack")
		timerShield:Start(args.destName)
	elseif spellId == 41452 and self:GetCIDFromGUID(args.destGUID) == 22949 then
		warnDevAura:Show()
		timerDevAura:Start()
	elseif spellId == 41453 and self:GetCIDFromGUID(args.destGUID) == 22949 then
		warnResAura:Show()
		timerResAura:Start()
	elseif spellId == 41450 and self:GetCIDFromGUID(args.destGUID) == 22951 then
		timerMeleeImmune:Start(args.destName)
		specWarnImmune:Show(L.Melee)
	elseif spellId == 41451 and self:GetCIDFromGUID(args.destGUID) == 22951 then
		timerSpellImmune:Start(args.destName)
		specWarnImmune:Show(L.Spell)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 41479 then
		warnVanishEnd:Show()
	elseif spellId == 41485 then
		if self.Options.PoisonIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 41455 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnCoH:Show(args.sourceName)
			specWarnCoH:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 41455 then
		timerNextCoH:Start(13.3)
	end
end
