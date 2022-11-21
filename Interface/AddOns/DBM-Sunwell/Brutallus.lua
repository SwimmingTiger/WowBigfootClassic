local mod	= DBM:NewMod("Brutallus", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221029204055")
mod:SetCreatureID(24882)
mod:SetEncounterID(725, 2489)
mod:DisableESCombatDetection()--ES fires for the RP event that has nothing to do with engaging boss
mod:SetModelID(22711)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20220514000000)
mod:SetMinSyncRevision(20200726000000)

mod:RegisterCombat("yell", L.Pull)
mod.disableHealthCombat = true

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 45150",
	"SPELL_CAST_SUCCESS 45141 45185",
	"SPELL_AURA_APPLIED 46394 45150",
	"SPELL_AURA_APPLIED_DOSE 45150",
	"SPELL_AURA_REMOVED 46394"
)

--[[
ability.id = 45150 and type = "begincast"
 or (ability.id = 45141 or ability.id = 45185) and type = "cast"
--]]
local warnMeteor		= mod:NewSpellAnnounce(45150, 3)
local warnBurn			= mod:NewTargetNoFilterAnnounce(46394, 3)--Announces boss cast target, not spread targets
local warnStomp			= mod:NewTargetNoFilterAnnounce(45185, 3, nil, "Tank", 2)

local specWarnMeteor	= mod:NewSpecialWarningStack(45150, nil, 4, nil, nil, 1, 6)
local specWarnBurn		= mod:NewSpecialWarningYou(46394, nil, nil, nil, 1, 2)
local yellBurnFades		= mod:NewShortFadesYell(46394)

local timerMeteorCD		= mod:NewCDTimer(11.7, 45150, nil, nil, nil, 3)
local timerStompCD		= mod:NewCDTimer(30.7, 45185, nil, nil, nil, 2)
local timerBurn			= mod:NewTargetTimer(60, 46394, nil, "false", 2, 3)
local timerBurnCD		= mod:NewCDTimer(21, 46394, nil, nil, nil, 3)

local berserkTimer		= mod:NewBerserkTimer(360)

mod:AddSetIconOption("BurnIcon", 46394, true, false, {1, 2, 3, 4, 5, 6, 7, 8})
mod:AddRangeFrameOption(46394, 4)

mod.vb.burnIcon = 8
local debuffName = DBM:GetSpellInfo(46394)

local DebuffFilter
do
	DebuffFilter = function(uId)
		return DBM:UnitDebuff(uId, debuffName)
	end
end

function mod:OnCombatStart(delay)
	self.vb.burnIcon = 8
	timerMeteorCD:Start(9.9-delay)--9.9-11.1
	timerBurnCD:Start(20-delay)
	timerStompCD:Start(30.5-delay)
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 45150 then
		warnMeteor:Show()
		timerMeteorCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 45141 then
		if args:IsPlayer() then
			if self:AntiSpam(5, 1) then
				specWarnBurn:Show()
				specWarnBurn:Play("targetyou")
			end
		else
			warnBurn:Show(args.destName)
		end
		timerBurnCD:Start()
	elseif args.spellId == 45185 then
		warnStomp:Show(args.destName)
		timerStompCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 46394 then
		timerBurn:Start(args.destName)
		if self.Options.BurnIcon then
			self:SetIcon(args.destName, self.vb.burnIcon)
		end
		if self.vb.burnIcon == 1 then
			self.vb.burnIcon = 8
		else
			self.vb.burnIcon = self.vb.burnIcon - 1
		end
		if args:IsPlayer() then
			if self:AntiSpam(5, 1) then
				specWarnBurn:Show()
				specWarnBurn:Play("targetyou")
			end
			yellBurnFades:Countdown(60)
		end
		if self.Options.RangeFrame then
			if DBM:UnitDebuff("player", args.spellName) then--You have debuff, show everyone
				DBM.RangeCheck:Show(4, nil)
			else--You do not have debuff, only show players who do
				DBM.RangeCheck:Show(4, DebuffFilter)
			end
		end
	elseif args.spellId == 45150 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 4 then
			specWarnMeteor:Show(amount)
			specWarnMeteor:Play("stackhigh")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 46394 then
		if args:IsPlayer() then
			yellBurnFades:Cancel()
		end
		if self.Options.BurnIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end
