local mod	= DBM:NewMod("Anetheron", "DBM-Hyjal")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220923022829")
mod:SetCreatureID(17808)
mod:SetEncounterID(619, 2469)
mod:SetModelID(21069)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 31306 31298",
	"SPELL_AURA_REFRESH 31306 31298",
	"SPELL_AURA_REMOVED 31306 31298",
	"SPELL_CAST_START 31299",
	"SPELL_CAST_SUCCESS 31306 31298"
)

--[[
ability.id = 31299 and type = "begincast"
 or (ability.id = 31306 or ability.id = 31298) and type = "cast"
--]]
local warnSwarm			= mod:NewSpellAnnounce(31306, 3)
local warnSleep			= mod:NewTargetNoFilterAnnounce(31298, 2)
local warnInferno		= mod:NewTargetNoFilterAnnounce(31299, 4)

local specWarnInferno	= mod:NewSpecialWarningYou(31299, nil, nil, nil, 1, 2)
local yellInferno		= mod:NewYell(31299)

local timerSwarm		= mod:NewBuffFadesTimer(20, 31306, nil, nil, nil, 3)
local timerSleep		= mod:NewBuffFadesTimer(10, 31298, nil, nil, nil, 3)
local timerSleepCD		= mod:NewCDTimer(19, 31298, nil, nil, nil, 3)
local timerInferno		= mod:NewCDTimer(51, 31299, nil, nil, nil, 3)-- ~55? leaving 51 for now

function mod:InfernoTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnInferno:Show()
		specWarnInferno:Play("targetyou")
		yellInferno:Yell()
	else
		warnInferno:Show(targetname)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 31306 and args:IsPlayer() then
		timerSwarm:Start()
	elseif args.spellId == 31298 and args:IsPlayer() then
		timerSleep:Start()
	end
end
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 31306 and args:IsPlayer() then
		timerSwarm:Stop()
	elseif args.spellId == 31298 and args:IsPlayer() then
		timerSleep:Stop()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 31299 then
		timerInferno:Start()
		self:BossTargetScanner(17808, "InfernoTarget", 0.05, 10)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 31306 then
		warnSwarm:Show()
	elseif args.spellId == 31298 then
		timerSleepCD:Start()
	end
end

