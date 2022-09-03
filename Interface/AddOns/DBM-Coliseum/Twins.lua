local mod	= DBM:NewMod("ValkTwins", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220816155700")
mod:SetCreatureID(34497, 34496)
mod:SetEncounterID(1089)
mod:SetModelID(29240)
mod:SetMinCombatTime(30)
mod:SetUsedIcons(1, 2, 3, 4)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 66046 66058 65875 65876",
	"SPELL_AURA_APPLIED 65724 65748 65950 66001 65879 65916 65874 65858",
	"SPELL_AURA_REMOVED 65874 65858 65950 66001",
	"SPELL_INTERRUPT"
)

local warnSpecial					= mod:NewAnnounce("WarnSpecialSpellSoon", 3)
local warnTouchDebuff				= mod:NewAnnounce("WarningTouchDebuff", 2, 66823)
local warnPoweroftheTwins			= mod:NewAnnounce("WarningPoweroftheTwins2", 4, 65916, "Healer", nil, nil, 65916)

local specWarnSpecial				= mod:NewSpecialWarning("SpecWarnSpecial")--Change Color, No voice ideas for this
local specWarnSwitch				= mod:NewSpecialWarning("SpecWarnSwitchTarget", nil, nil, nil, 1, 2, nil, nil, 65875)
local specWarnKickNow 				= mod:NewSpecialWarning("SpecWarnKickNow", "HasInterrupt", nil, 2, 1, 2, nil, nil, 65875)
local specWarnPoweroftheTwins		= mod:NewSpecialWarningDefensive(65916, "Tank", nil, 2, 1, 2)
local specWarnEmpoweredDarkness		= mod:NewSpecialWarningYou(65724)--No voice ideas for this
local specWarnEmpoweredLight		= mod:NewSpecialWarningYou(65748)--No voice ideas for this

local enrageTimer					= mod:NewBerserkTimer(360)
local timerSpecial					= mod:NewTimer(45, "TimerSpecialSpell", "132866", nil, nil, 6)
local timerHeal						= mod:NewCastTimer(15, 65875, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerLightTouch				= mod:NewTargetTimer(20, 65950, nil, false, 2, 3)
local timerDarkTouch				= mod:NewTargetTimer(20, 66001, nil, false, 2, 3)
local timerAchieve					= mod:NewAchievementTimer(180, 3815)

mod:AddBoolOption("SpecialWarnOnDebuff", false, "announce")
mod:AddSetIconOption("SetIconOnDebuffTarget", 66001, false, 0, {1, 2, 3, 4})
mod:AddInfoFrameOption(65874, true)

local lightEssence, darkEssence = DBM:GetSpellInfo(65686), DBM:GetSpellInfo(65684)
local debuffTargets = {}
mod.vb.debuffIcon = 1

function mod:OnCombatStart(delay)
	timerSpecial:Start(-delay)
	warnSpecial:Schedule(40-delay)
	timerAchieve:Start(-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		enrageTimer:Start(360-delay)
	else
		enrageTimer:Start(480-delay)
	end
	self.vb.debuffIcon = 1
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

do
	local function SpecialAbility(debuff)
		if not debuff then
			specWarnSpecial:Show()
		end
		timerSpecial:Start()
		warnSpecial:Schedule(40)
	end

	function mod:SPELL_CAST_START(args)
		if args.spellId == 66046 then
			local debuff = DBM:UnitDebuff("player", lightEssence)
			SpecialAbility(debuff)
		elseif args.spellId == 66058 then
			local debuff = DBM:UnitDebuff("player", darkEssence)
			SpecialAbility(debuff)
		elseif args.spellId == 65875 then
			timerHeal:Start()
			SpecialAbility(true)
			if self:GetUnitCreatureId("target") == 34497 then
				specWarnSwitch:Show()
				specWarnSwitch:Play("changetarget")
			end
		elseif args.spellId == 65876 then
			timerHeal:Start()
			SpecialAbility(true)
			if self:GetUnitCreatureId("target") == 34496 then
				specWarnSwitch:Show()
				specWarnSwitch:Play("changetarget")
			end
		end
	end
end

do
	local function resetDebuff(self)
		self.vb.debuffIcon = 1
	end

	local function warnDebuff(self)
		warnTouchDebuff:Show(table.concat(debuffTargets, "<, >"))
		table.wipe(debuffTargets)
		self:Unschedule(resetDebuff)
		self:Schedule(5, resetDebuff, self)
	end

	local function showPowerWarning(self, cid)
		local target = self:GetBossTarget(cid)
		if not target then return end
		if target == UnitName("player") then
			specWarnPoweroftheTwins:Show()
		else
			warnPoweroftheTwins:Show(target)
		end
	end

	local shieldHealth = {
		["heroic25"] = 1200000,
		["heroic10"] = 300000,
		["normal25"] = 700000,
		["normal10"] = 175000
	}

	function mod:SPELL_AURA_APPLIED(args)
		if args:IsPlayer() and args.spellId == 65724 then
			specWarnEmpoweredDarkness:Show()
		elseif args:IsPlayer() and args.spellId == 65748 then
			specWarnEmpoweredLight:Show()
		elseif args.spellId == 65950 then
			if args:IsPlayer() and self.Options.SpecialWarnOnDebuff then
				specWarnSpecial:Show()
			end
			timerLightTouch:Start(args.destName)
			if self.Options.SetIconOnDebuffTarget then
				self:SetIcon(args.destName, self.vb.debuffIcon, 15)
			end
			self.vb.debuffIcon = self.vb.debuffIcon + 1
			debuffTargets[#debuffTargets + 1] = args.destName
			self:Unschedule(warnDebuff)
			self:Schedule(0.9, warnDebuff, self)
		elseif args.spellId == 66001 then
			if args:IsPlayer() and self.Options.SpecialWarnOnDebuff then
				specWarnSpecial:Show()
			end
			timerDarkTouch:Start(args.destName)
			if self.Options.SetIconOnDebuffTarget then
				self:SetIcon(args.destName, self.vb.debuffIcon)
			end
			self.vb.debuffIcon = self.vb.debuffIcon + 1
			debuffTargets[#debuffTargets + 1] = args.destName
			self:Unschedule(warnDebuff)
			self:Schedule(0.75, warnDebuff, self)
		elseif args:IsSpellID(65879, 65916) then
			self:Schedule(0.1, showPowerWarning, self, args:GetDestCreatureID())
		elseif args:IsSpellID(65874, 65858) and self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, shieldHealth[(DBM:GetCurrentInstanceDifficulty())])--UnitGetTotalAbsorbs()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(65874, 65858) then
		specWarnKickNow:Show()
		specWarnKickNow:Play("kickcast")
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	elseif args.spellId == 65950 then
		timerLightTouch:Stop(args.destName)
		if self.Options.SetIconOnDebuffTarget then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 66001 then
		timerDarkTouch:Start(args.destName)
		if self.Options.SetIconOnDebuffTarget then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and (args.extraSpellId == 65875 or args.extraSpellId == 65876) then
		timerHeal:Stop()
	end
end
