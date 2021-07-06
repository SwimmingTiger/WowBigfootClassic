local mod	= DBM:NewMod("Solarian", "DBM-TheEye")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20210623162544")
mod:SetCreatureID(18805)
mod:SetEncounterID(WOW_PROJECT_ID ~= (WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5) and 732 or 2466)
mod:SetModelID(18239)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 42783",
	"SPELL_CAST_START 37135",
	"CHAT_MSG_MONSTER_YELL"
)

local warnWrath			= mod:NewTargetNoFilterAnnounce(42783, 2)
local warnSplit			= mod:NewAnnounce("WarnSplit", 4, 39414)
local warnAgent			= mod:NewAnnounce("WarnAgent", 1, 39414)
local warnPriest		= mod:NewAnnounce("WarnPriest", 1, 39414)
local warnPhase2		= mod:NewPhaseAnnounce(2)

local specWarnDomination= mod:NewSpecialWarningInterrupt(37135, "HasInterrupt", nil, 2, 1, 2)
local specWarnWrath		= mod:NewSpecialWarningMoveAway(42783, nil, nil, nil, 1, 2)
local yellWrath			= mod:NewYell(42783)

local timerWrath		= mod:NewTargetTimer(6, 42783)
local timerSplit		= mod:NewTimer(90, "TimerSplit", 39414, nil, nil, 6)
local timerAgent		= mod:NewTimer(4, "TimerAgent", 39414, nil, nil, 1)
local timerPriest		= mod:NewTimer(20, "TimerPriest", 39414, nil, nil, 1)

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddSetIconOption("WrathIcon", 42783, true, false, {8})

function mod:OnCombatStart(delay)
	timerSplit:Start(50-delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 42783 then
		timerWrath:Start(args.destName)
		if args:IsPlayer() then
			specWarnWrath:Show()
			specWarnWrath:Play("runout")
			yellWrath:Yell()
		else
			warnWrath:Show(args.destName)
		end
		if self.Options.WrathIcon then
			self:SetIcon(args.destName, 8, 6)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 37135 then
		specWarnDomination:Show(args.sourceName)
		specWarnDomination:Play("kickcast")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellSplit1 or msg:find(L.YellSplit1) or msg == L.YellSplit2 or msg:find(L.YellSplit2) then
		warnSplit:Show()
		timerAgent:Start()
		warnAgent:Schedule(4)
		timerPriest:Start()
		warnPriest:Schedule(20)
		timerSplit:Start()
	elseif msg == L.YellPhase2 or msg:find(L.YellPhase2) then
		warnPhase2:Show()
		timerAgent:Cancel()
		warnAgent:Cancel()
		timerPriest:Cancel()
		warnPriest:Cancel()
		timerSplit:Cancel()
	end
end
