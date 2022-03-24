local mod	= DBM:NewMod("Muru", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20210813015935")
mod:SetCreatureID(25741)--25741 Muru, 25840 Entropius
mod:SetEncounterID(728, 2492)
mod:SetModelID(23404)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 45996",
	"SPELL_CAST_SUCCESS 46177",
	"SPELL_SUMMON 46268 46282",
	"UNIT_DIED"
)

local warnHuman			= mod:NewAnnounce("WarnHuman", 4, 27778)
local warnVoid			= mod:NewAnnounce("WarnVoid", 4, 46087)
local warnDarkness		= mod:NewSpellAnnounce(45996, 2)
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnFiend			= mod:NewAnnounce("WarnFiend", 2, 46268)
local warnBlackHole		= mod:NewSpellAnnounce(46282, 3)

local timerHuman		= mod:NewTimer(60, "TimerHuman", 27778, nil, nil, 6)
local timerVoid			= mod:NewTimer(30, "TimerVoid", 46087, nil, nil, 6)
local timerNextDarkness	= mod:NewNextTimer(45, 45996, nil, nil, nil, 2)
local timerBlackHoleCD	= mod:NewCDTimer(15, 46282)
local timerPhase		= mod:NewTimer(10, "TimerPhase", 46087, nil, nil, 6)

local berserkTimer		= mod:NewBerserkTimer(600)

mod.vb.humanCount = 1
mod.vb.voidCount = 1

local function HumanSpawn(self)
	warnHuman:Show(self.vb.humanCount)
	self.vb.humanCount = self.vb.humanCount + 1
	timerHuman:Start(nil, self.vb.humanCount)
	self:Schedule(60, HumanSpawn, self)
end

local function VoidSpawn(self)
	warnVoid:Show(self.vb.voidCount)
	self.vb.voidCount = self.vb.voidCount + 1
	timerVoid:Start(nil, self.vb.voidCount)
	self:Schedule(30, VoidSpawn, self)
end

local function phase2(self)
	self:SetStage(2)
	warnPhase2:Show()
	self:Unschedule(HumanSpawn)
	self:Unschedule(VoidSpawn)
	timerBlackHoleCD:Start(17)
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.humanCount = 1
	self.vb.voidCount = 1
	timerHuman:Start(15-delay, 1)
	timerVoid:Start(36.5-delay, 1)
	timerNextDarkness:Start(-delay)
	self:Schedule(15, HumanSpawn, self)
	self:Schedule(36.5, VoidSpawn, self)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 45996 and args:GetDestCreatureID() == 25741 then
		warnDarkness:Show()
		timerNextDarkness:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 46177 then
		timerNextDarkness:Stop()
		timerHuman:Stop()
		timerVoid:Stop()
		timerPhase:Start()
		self:Schedule(10, phase2, self)
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 46268 then
		warnFiend:Show()
	elseif args.spellId == 46282 then
		warnBlackHole:Show()
		timerBlackHoleCD:Start()
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 25840 then
		DBM:EndCombat(self)
	end
end

