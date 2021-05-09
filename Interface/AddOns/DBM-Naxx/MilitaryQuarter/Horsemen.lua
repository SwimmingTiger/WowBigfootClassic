local mod	= DBM:NewMod("Horsemen", "DBM-Naxx", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20210302030013")
mod:SetCreatureID(16062, 16063, 16064, 16065)--30549
mod:SetEncounterID(1121)
mod:SetModelID(10729)
mod:SetBossHPInfoToHighest()
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 28832 28833 28834 28835 28863 28883 28884",
	"SPELL_AURA_APPLIED 29061",
	"SPELL_AURA_REMOVED 29061",
	"SPELL_AURA_APPLIED_DOSE 28832 28833 28834 28835"
)

--[[
(ability.id = 28832 or ability.id = 28833 or ability.id = 28834 or ability.id = 28835 or ability.id = 28863 or ability.id = 28883 or ability.id = 28884) and type = "cast"
--]]
local warnMarkSoon				= mod:NewAnnounce("WarningMarkSoon", 1, 28835, false)
local warnMeteor				= mod:NewSpellAnnounce(28884, 4)
local warnVoidZone				= mod:NewTargetNoFilterAnnounce(28863, 3)--Only warns for nearby targets, to reduce spam
local warnHolyWrath				= mod:NewTargetNoFilterAnnounce(28883, 3, nil, false)
local warnBoneBarrier			= mod:NewTargetNoFilterAnnounce(29061, 2)

local specWarnMarkOnPlayer		= mod:NewSpecialWarning("SpecialWarningMarkOnPlayer", nil, nil, nil, 1, 6)
local specWarnVoidZone			= mod:NewSpecialWarningYou(28863, nil, nil, nil, 1, 2)
local yellVoidZone				= mod:NewYell(28863)

local timerMarkCD				= mod:NewTimer(12.9, "timerMark", 28835, nil, nil, 3)-- 12.9
local timerMeteorCD				= mod:NewCDTimer(12.9, 28884, nil, nil, nil, 3)-- 12.9-14.6
local timerVoidZoneCD			= mod:NewCDTimer(12.9, 28863, nil, nil, nil, 3)-- 12.9-16
local timerHolyWrathCD			= mod:NewCDTimer(11.3, 28883, nil, nil, nil, 3)-- 11.3-14.5
local timerBoneBarrier			= mod:NewTargetTimer(20, 29061, nil, nil, nil, 5)

mod.vb.markCount = 0

function mod:OnCombatStart(delay)
	self.vb.markCount = 0
	timerVoidZoneCD:Start(14.5 - delay)--14.5-16.1
	timerMarkCD:Start(20.9 - delay, 1)-- 20.98-21.44
	timerMeteorCD:Start(20.9 - delay)
	timerHolyWrathCD:Start(20.9 - delay)
	warnMarkSoon:Schedule(16 - delay)
end

do
	local MarkofKorthazz, MarkofBlaumeux, MarkofMorgraine, MarkofZeliek = DBM:GetSpellInfo(28832), DBM:GetSpellInfo(28833), DBM:GetSpellInfo(28834), DBM:GetSpellInfo(28835)
	local Meteor, voidZone, HolyWrath = DBM:GetSpellInfo(28884), DBM:GetSpellInfo(28863), DBM:GetSpellInfo(28883)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args:IsSpellID(28832, 28833, 28834, 28835) and self:AntiSpam(5) then
		if (args.spellName == MarkofKorthazz or args.spellName == MarkofBlaumeux or args.spellName == MarkofMorgraine or args.spellName == MarkofZeliek) and (args:GetSrcCreatureID() == 16062 or args:GetSrcCreatureID() == 16063 or args:GetSrcCreatureID() == 16064 or args:GetSrcCreatureID() == 16065) and self:AntiSpam(10) then
			self.vb.markCount = self.vb.markCount + 1
			timerMarkCD:Start(nil, self.vb.markCount+1)
			warnMarkSoon:Schedule(9.9, self.vb.markCount+1)
		elseif args.spellName == voidZone then
			timerVoidZoneCD:Start()
			if args:IsPlayer() then
				specWarnVoidZone:Show()
				specWarnVoidZone:Play("targetyou")
				yellVoidZone:Yell()
			elseif self:CheckNearby(12, args.destName) then
				warnVoidZone:Show(args.destName)
			end
		elseif args.spellName == HolyWrath then
			warnHolyWrath:Show(args.destName)
			timerHolyWrathCD:Start()
		elseif args.spellName == Meteor then
			warnMeteor:Show()
			timerMeteorCD:Start()
		end
	end


	function mod:SPELL_AURA_APPLIED_DOSE(args)
		--if args:IsSpellID(28832, 28833, 28834, 28835) and args:IsPlayer() then
		if (args.spellName == MarkofKorthazz or args.spellName == MarkofBlaumeux or args.spellName == MarkofMorgraine or args.spellName == MarkofZeliek) and args:IsPlayer() then
			if args.amount >= 4 then
				specWarnMarkOnPlayer:Show(args.spellName, args.amount)
				specWarnMarkOnPlayer:Play("stackhigh")
			end
		end
	end
end

do
	local BoneBarrier = DBM:GetSpellInfo(29061)
	function mod:SPELL_AURA_APPLIED(args)
		if args.spellName == BoneBarrier and args:IsSrcTypeHostile() then
			warnBoneBarrier:Show(args.destName)
			timerBoneBarrier:Start(20, args.destName)
		end
	end

	function mod:SPELL_AURA_REMOVED(args)
		if args.spellName == BoneBarrier then
			timerBoneBarrier:Stop(args.destName)
		end
	end
end
