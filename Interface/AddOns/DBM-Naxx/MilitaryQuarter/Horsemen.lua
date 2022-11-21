local mod	= DBM:NewMod("Horsemen", "DBM-Naxx", 4)
local L		= mod:GetLocalizedStrings()
local isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)

mod:SetRevision("20221102181724")
mod:SetCreatureID(16063, 16064, 16065, 30549)
mod:SetEncounterID(1121)
mod:SetModelID(10729)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 28884 57467",
	"SPELL_CAST_SUCCESS 28832 28833 28834 28835 28863 28883",
	"SPELL_AURA_APPLIED 29061",
	"SPELL_AURA_REMOVED 29061",
	"SPELL_AURA_APPLIED_DOSE 28832 28833 28834 28835"
)

--TODO, first marks
--TODO, verify stuff migrated from naxx 40
local warnMarkSoon				= mod:NewAnnounce("WarningMarkSoon", 1, 28835, false, nil, nil, 28835)
local warnMeteor				= mod:NewSpellAnnounce(57467, 4)
local warnHolyWrath				= mod:NewTargetNoFilterAnnounce(28883, 3, nil, false)
local warnBoneBarrier			= mod:NewTargetNoFilterAnnounce(29061, 2)

local specWarnMarkOnPlayer		= mod:NewSpecialWarning("SpecialWarningMarkOnPlayer", nil, nil, nil, 1, 6, nil, nil, 28835)

local warnVoidZone
local specWarnVoidZone
local yellVoidZone
if isRetail then
	warnVoidZone				= mod:NewTargetNoFilterAnnounce(28863, 3)--Only warns for nearby targets, to reduce spam
	specWarnVoidZone			= mod:NewSpecialWarningYou(28863, nil, nil, nil, 1, 2)
	yellVoidZone				= mod:NewYell(28863)
else
	warnVoidZone				= mod:NewSpellAnnounce(28863, 4, nil, nil, nil, nil, nil, 2)
end

local timerMarkCD				= mod:NewTimer(12.9, "timerMark", 28835, nil, nil, 3)
--local timerMarkCD				= mod:NewCDTimer(12, 28835, nil, nil, nil, 3)
--local timerMeteorCD			= mod:NewCDTimer(12.9, 28884, nil, nil, nil, 3)-- 12.9-14.6
--local timerVoidZoneCD			= mod:NewCDTimer(12.9, 28863, nil, nil, nil, 3)-- 12.9-16
--local timerHolyWrathCD		= mod:NewCDTimer(11.3, 28883, nil, nil, nil, 3)-- 11.3-14.5
local timerBoneBarrier			= mod:NewTargetTimer(20, 29061, nil, nil, nil, 5)

mod.vb.markCount = 0

function mod:OnCombatStart(delay)
	self.vb.markCount = 0
	--timerMarkCD:Start()
	--warnMarkSoon:Schedule(7)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(28884, 57467) then
		warnMeteor:Show()
		--timerMeteorCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(28832, 28833, 28834, 28835) and self:AntiSpam(5, 1) then
		self.vb.markCount = self.vb.markCount + 1
		timerMarkCD:Start(nil, self.vb.markCount+1)
		warnMarkSoon:Schedule(7)
	elseif args.spellId == 28863 then
--		timerVoidZoneCD:Start()
		if isRetail then
			if args:IsPlayer() then
				specWarnVoidZone:Show()
				specWarnVoidZone:Play("targetyou")
				yellVoidZone:Yell()
			elseif self:CheckNearby(12, args.destName) then
				warnVoidZone:Show(args.destName)
			end
		else
			if self:AntiSpam(3, 2) then--Have to antispam this way since can't by distance in classic
				warnVoidZone:Show()
				warnVoidZone:Play("watchstep")
			end
		end
	elseif args.spellId == 28883 then
		warnHolyWrath:Show(args.destName)
--		timerHolyWrathCD:Start()
	end
end

local BoneBarrier = DBM:GetSpellInfo(29061)
function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 29061 then
		warnBoneBarrier:Show(args.destName)
		timerBoneBarrier:Start(20, args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 29061 then
		timerBoneBarrier:Stop(args.destName)
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(28832, 28833, 28834, 28835) and args:IsPlayer() then
		if args.amount >= 4 then
			specWarnMarkOnPlayer:Show(args.spellName, args.amount)
			specWarnMarkOnPlayer:Play("stackhigh")
		end
	end
end
