local mod	= DBM:NewMod("Kurinnaxx", "DBM-AQ20", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(15348)
mod:SetEncounterID(718)
mod:SetModelID(15742)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 25646 25656",
	"SPELL_AURA_APPLIED_DOSE 25646 25656",
	"SPELL_AURA_REMOVED 25646"
)

local warnWound			= mod:NewStackAnnounce(25646, 3, nil, "Tank")
local warnSandTrap		= mod:NewTargetAnnounce(25656, 4)

local specWarnWound		= mod:NewSpecialWarningStack(25646, nil, 5, nil, nil, 1, 6)
local specWarnWoundTaunt= mod:NewSpecialWarningTaunt(25646, nil, nil, nil, 1, 2)

local timerWound		= mod:NewTargetTimer(15, 25646, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerSandTrap		= mod:NewTargetTimer(20, 25656, nil, false, nil, 3)

do
	local MortalWound, SandTrap = DBM:GetSpellInfo(25646), DBM:GetSpellInfo(25656)
	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 25646 and not self:IsTrivial(80) then
		if args.spellName == MortalWound then
			local amount = args.amount or 1
			timerWound:Start(args.destName)
			if amount >= 5 then
				if args:IsPlayer() then
					specWarnWound:Show(amount)
					specWarnWound:Play("stackhigh")
				elseif not DBM:UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
					specWarnWoundTaunt:Show(args.destName)
					specWarnWoundTaunt:Play("tauntboss")
				else
					warnWound:Show(args.destName, amount)
				end
			else
				warnWound:Show(args.destName, amount)
			end
		--elseif args.spellId == 25656 then
		elseif args.spellName == SandTrap then
			warnSandTrap:Show(args.destName)
			timerSandTrap:Start(args.destName)
		end
	end
	mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

	function mod:SPELL_AURA_REMOVED(args)
		--if args.spellId == 25646 then
		if args.spellName == MortalWound then
			timerWound:Stop(args.destName)
		--elseif args.spellId == 25656 then
		elseif args.spellName == SandTrap then
			timerSandTrap:Stop(args.destName)
		end
	end
end
