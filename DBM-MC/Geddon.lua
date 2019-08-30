local mod	= DBM:NewMod("Geddon", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190810175354")
mod:SetCreatureID(12056)
mod:SetEncounterID(668)
mod:SetModelID(12129)
mod:SetUsedIcons(8)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 20475",
	"SPELL_AURA_REMOVED 20475",
	"SPELL_CAST_SUCCESS 19695 19659 20478"
)

local warnInferno		= mod:NewSpellAnnounce(19695, 3)
local warnIgnite		= mod:NewSpellAnnounce(19659, 2)
local warnBomb			= mod:NewTargetNoFilterAnnounce(20475, 4)
local warnArmageddon	= mod:NewSpellAnnounce(20478, 3)

local specWarnBomb		= mod:NewSpecialWarningYou(20475, nil, nil, nil, 3, 2)
local yellBomb			= mod:NewYell(20475)
local yellBombFades		= mod:NewShortFadesYell(20475)
local specWarnInferno	= mod:NewSpecialWarningSpell(19695, nil, nil, nil, 2, 2)

local timerInferno		= mod:NewBuffActiveTimer(8, 19695, nil, nil, nil, 2)
local timerBombCD		= mod:NewCDTimer(16, 20475, nil, nil, nil, 3)
local timerBomb			= mod:NewTargetTimer(8, 20475, nil, nil, nil, 3)
local timerArmageddon	= mod:NewCastTimer(8, 20478, nil, nil, nil, 2)

mod:AddSetIconOption("SetIconOnBombTarget", 20475)

function mod:OnCombatStart(delay)
	timerBombCD:Start(11-delay)
end

do
	local LivingBomb = DBM:GetSpellInfo(20475)
	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 20475 then
		if args.spellName == LivingBomb then
			timerBomb:Start(args.destName)
			timerBombCD:Start()
			if self.Options.SetIconOnBombTarget then
				self:SetIcon(args.destName, 8)
			end
			if args:IsPlayer() then
				specWarnBomb:Show()
				specWarnBomb:Play("runout")
				if self:IsDifficulty("event40") or not self:IsTrivial(75) then
					yellBomb:Yell()
					yellBombFades:Countdown(args.spellId)
				end
			else
				warnBomb:Show(args.destName)
			end
		end
	end

	function mod:SPELL_AURA_REMOVED(args)
		--if args.spellId == 20475 then
		if args.spellName == LivingBomb then
			timerBomb:Stop(args.destName)
			if self.Options.SetIconOnBombTarget then
				self:SetIcon(args.destName, 0)
			end
			if args:IsPlayer() then
				yellBombFades:Cancel()
			end
		end
	end
end

do
	local Inferno, Ignite, Armageddon = DBM:GetSpellInfo(19695), DBM:GetSpellInfo(19659), DBM:GetSpellInfo(20478)
	function mod:SPELL_CAST_SUCCESS(args)
		--local spellId = args.spellId
		local spellName = args.spellName
		--if spellId == 19695 then
		if spellName == Inferno then
			if self:IsDifficulty("event40") or not self:IsTrivial(75) then
				specWarnInferno:Show()
				specWarnInferno:Play("aesoon")
			else
				warnInferno:Show()
			end
			timerInferno:Start()
		--elseif spellId == 19659 then
		elseif spellName == Ignite and args:IsSrcTypeHostile() then
			warnIgnite:Show()
		--elseif spellId == 20478 then
		elseif spellName == Armageddon then
			warnArmageddon:Show()
			timerArmageddon:Start()
		end
	end
end
