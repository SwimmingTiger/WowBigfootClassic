local mod	= DBM:NewMod("CThun", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190904054816")
mod:SetCreatureID(15589, 15727)
mod:SetEncounterID(717)
mod:RegisterCombat("combat")
mod:SetWipeTime(25)

mod:RegisterEventsInCombat(
	"CHAT_MSG_MONSTER_EMOTE",
	"UNIT_DIED"
)

local warnEyeTentacle		= mod:NewAnnounce("WarnEyeTentacle", 2)
--local warnClawTentacle		= mod:NewAnnounce("WarnClawTentacle", 2)
--local warnGiantEyeTentacle	= mod:NewAnnounce("WarnGiantEyeTentacle", 3)
--local warnGiantClawTentacle	= mod:NewAnnounce("WarnGiantClawTentacle", 3)
local warnPhase2			= mod:NewPhaseAnnounce(2)

local specWarnDarkGlare		= mod:NewSpecialWarningSpell(26029, nil, nil, nil, 3)--Dodge?
local specWarnWeakened		= mod:NewSpecialWarning("SpecWarnWeakened", nil, nil, nil, 2)

local timerDarkGlareCD		= mod:NewNextTimer(86, 26029)
local timerDarkGlare		= mod:NewBuffActiveTimer(39, 26029)
local timerEyeTentacle		= mod:NewTimer(45, "TimerEyeTentacle", nil, nil, nil, 1)
--local timerGiantEyeTentacle	= mod:NewTimer(60, "TimerGiantEyeTentacle", nil, nil, nil, 1)
--local timerClawTentacle		= mod:NewTimer(11, "TimerClawTentacle", nil, nil, nil, 1)
--local timerGiantClawTentacle = mod:NewTimer(60, "TimerGiantClawTentacle", nil, nil, nil, 1)
local timerWeakened			= mod:NewTimer(45, "TimerWeakened")

mod:AddBoolOption("RangeFrame", true)

mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	--timerClawTentacle:Start(-delay)
	timerEyeTentacle:Start(45-delay)
	timerDarkGlareCD:Start(48-delay)
	self:ScheduleMethod(45-delay, "EyeTentacle")
	self:ScheduleMethod(48-delay, "DarkGlare")
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:EyeTentacle()
	warnEyeTentacle:Show()
	timerEyeTentacle:Start()
	self:ScheduleMethod(45, "EyeTentacle")
end

function mod:DarkGlare()
	specWarnDarkGlare:Show()
	timerDarkGlare:Start()
	timerDarkGlareCD:Start()
	self:ScheduleMethod(86, "DarkGlare")
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg:find(L.Weakened) then
		specWarnWeakened:Show()
		timerWeakened:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 15589 then
		self.vb.phase = 2
		warnPhase2:Show()
		self:UnscheduleMethod("EyeTentacle")
		self:UnscheduleMethod("DarkGlare")
	end
end
