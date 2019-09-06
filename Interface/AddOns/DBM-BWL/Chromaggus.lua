local mod	= DBM:NewMod("Chromaggus", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190901045350")
mod:SetCreatureID(14020)
mod:SetEncounterID(616)
mod:SetModelID(14367)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 23309 23313 23189 23316 23312",
	"SPELL_AURA_APPLIED 23155 23169 23153 23154 23170 23128 23537",
--	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED 23128",
	"UNIT_HEALTH mouseover target"
)

local warnBreath		= mod:NewAnnounce("WarnBreath", 2, 23316)
local warnRed			= mod:NewSpellAnnounce(23155, 2, nil, false)
local warnGreen			= mod:NewSpellAnnounce(23169, 2, nil, false)
local warnBlue			= mod:NewSpellAnnounce(23153, 2, nil, false)
local warnBlack			= mod:NewSpellAnnounce(23154, 2, nil, false)
local warnFrenzy		= mod:NewSpellAnnounce(23128, 3, nil, "Tank", 2)
local warnPhase2Soon	= mod:NewPrePhaseAnnounce(2, 1)
local warnPhase2		= mod:NewPhaseAnnounce(2)

local specWarnBronze	= mod:NewSpecialWarningYou(23170, nil, nil, nil, 1, 8)

local timerBreathCD		= mod:NewTimer(60, "TimerBreathCD", 23316, nil, nil, 3)
local timerFrenzy		= mod:NewBuffActiveTimer(8, 23128, nil, "Tank|RemoveEnrage", 2, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_ENRAGE_ICON)

mod.vb.phase = 1

function mod:OnCombatStart(delay)
	timerBreathCD:Start(30-delay, L.Breath1)
	timerBreathCD:Start(-delay, L.Breath2)--60
	self.vb.phase = 1
end

do
	local Incinerate, CorrosiveAcid, FrostBurn, IgniteFlesh, TimeLaps = DBM:GetSpellInfo(23309), DBM:GetSpellInfo(23313), DBM:GetSpellInfo(23189), DBM:GetSpellInfo(23316), DBM:GetSpellInfo(23312)
	function mod:SPELL_CAST_START(args)
		--if args:IsSpellID(23309, 23313, 23189, 23316, 23312) then
		if args.spellName == Incinerate or args.spellName == CorrosiveAcid or args.spellName == FrostBurn or args.spellName == IgniteFlesh or args.spellName == TimeLaps then
			warnBreath:Show(args.spellName)
			timerBreathCD:Start(args.spellName)
		end
	end
end

do
	local BroodAffRed, BroodAffGreen, BroodAffBlue, BroodAffBlack, BroodAffBronze = DBM:GetSpellInfo(23155), DBM:GetSpellInfo(23169), DBM:GetSpellInfo(23153), DBM:GetSpellInfo(23154), DBM:GetSpellInfo(23170)
	local Frenzy, Enrage = DBM:GetSpellInfo(23128), DBM:GetSpellInfo(23537)
	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 23155 and self:AntiSpam(3, 1) then
		if args.spellName == BroodAffRed and self:AntiSpam(3, 1) then
			warnRed:Show()
		--elseif args.spellId == 23169 and self:AntiSpam(3, 2) then
		elseif args.spellName == BroodAffGreen and self:AntiSpam(3, 2) then
			warnGreen:Show()
		--elseif args.spellId == 23153 and self:AntiSpam(3, 3) then
		elseif args.spellName == BroodAffBlue and self:AntiSpam(3, 3) then
			warnBlue:Show()
		--elseif args.spellId == 23154 and self:AntiSpam(3, 4) then
		elseif args.spellName == BroodAffBlack and self:AntiSpam(3, 4) then
			warnBlack:Show()
		--elseif args.spellId == 23170 and args:IsPlayer() then
		elseif args.spellName == BroodAffBronze and args:IsPlayer() then
			specWarnBronze:Show()
			specWarnBronze:Play("useitem")
		--elseif args.spellId == 23128 then
		elseif args.spellName == Frenzy and args:IsDestTypeHostile() then
			warnFrenzy:Show()
			timerFrenzy:Start()
		--elseif args.spellId == 23537 then
		elseif args.spellName == Enrage and args:IsDestTypeHostile() then
			self.vb.phase = 2
			warnPhase2:Show()
		end
	end
	--Possibly needed hard to say.
	--mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

	function mod:SPELL_AURA_REMOVED(args)
		--if args.spellId == 23128 then
		if args.spellName == Frenzy and args:IsDestTypeHostile() then
			timerFrenzy:Stop()
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitHealth(uId) / UnitHealthMax(uId) <= 0.25 and self:GetUnitCreatureId(uId) == 14020 and self.vb.phase == 1 then
		warnPhase2Soon:Show()
		self.vb.phase = 1.5
	end
end
