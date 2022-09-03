local mod	= DBM:NewMod("FlameLeviathan", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220816155700")

mod:SetCreatureID(33113)
mod:SetEncounterID(1132)
mod:SetModelID(28875)
mod:RegisterCombat("yell", L.YellPull)
--mod:SetMinSyncRevision(4182)
mod:SetMinSyncRevision(7)--Could break if someone is running out of date version with higher revision

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 62396 62475 62374 62297",
	"SPELL_AURA_REMOVED 62396 62374",
	"SPELL_SUMMON 62907"
)

local warnHodirsFury		= mod:NewTargetAnnounce(62297, 3)
local pursueTargetWarn		= mod:NewAnnounce("PursueWarn", 2, 62374, nil, nil, nil, 62374)
local warnNextPursueSoon	= mod:NewAnnounce("warnNextPursueSoon", 3, 62374, nil, nil, nil, 62374)

local warnSystemOverload	= mod:NewSpecialWarningSpell(62475, nil, nil, nil, 1, 12)
local pursueSpecWarn		= mod:NewSpecialWarning("SpecialPursueWarnYou", nil, nil, 2, 4, 2, nil, 62374)
local warnWardofLife		= mod:NewSpecialWarning("warnWardofLife", nil, nil, nil, 1, 2)

local timerSystemOverload	= mod:NewBuffActiveTimer(20, 62475, nil, nil, nil, 6)
local timerFlameVents		= mod:NewCastTimer(10, 62396, nil, nil, nil, 2)
local timerPursued			= mod:NewTargetTimer(30, 62374, nil, nil, nil, 3)

local guids = {}
local function buildGuidTable(self)
	table.wipe(guids)
	for uId in DBM:GetGroupMembers() do
		local name, server = GetUnitName(uId, true)
		local fullName = name .. (server and server ~= "" and ("-" .. server) or "")
		guids[UnitGUID(uId.."pet") or "none"] = fullName
	end
end

function mod:OnCombatStart(delay)
	buildGuidTable(self)
end

function mod:OnTimerRecovery()
	buildGuidTable(self)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62396 then		-- Flame Vents
		timerFlameVents:Start()
	elseif args.spellId == 62475 then	-- Systems Shutdown / Overload
		timerSystemOverload:Start()
		warnSystemOverload:Show()
		warnSystemOverload:Play("attacktank")
	elseif args.spellId == 62374 then	-- Pursued
		local target = guids[args.destGUID]
		warnNextPursueSoon:Schedule(25)
		timerPursued:Start(target)
		if target then
			pursueTargetWarn:Show(target)
			if target == UnitName("player") then
				pursueSpecWarn:Show()
				pursueSpecWarn:Play("justrun")
			end
		end
	elseif args.spellId == 62297 then		-- Hodir's Fury (Person is frozen)
		local target = guids[args.destGUID]
		if target then
			warnHodirsFury:Show(target)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 62396 then
		timerFlameVents:Stop()
	elseif args.spellId == 62374 then	-- Pursued
		local target = guids[args.destGUID]
		timerPursued:Stop(target)
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 62907 and self:AntiSpam(3, 1) then		-- Ward of Life spawned (Creature id: 34275)
		warnWardofLife:Show()
		warnWardofLife:Play("bigmob")
	end
end
