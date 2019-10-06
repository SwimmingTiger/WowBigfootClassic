local mod	= DBM:NewMod("Broodlord", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(12017)
mod:SetEncounterID(612)
mod:SetModelID(14308)
mod:RegisterCombat("combat_yell", L.Pull)--L.Pull is backup for classic, since classic probably won't have ENCOUNTER_START to rely on and player regen never works for this boss

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 23331 18670",
	"SPELL_AURA_APPLIED 24573",
	"SPELL_AURA_REMOVED 24573"
)

--TODO, more timers?
local warnBlastWave		= mod:NewSpellAnnounce(23331, 2)
local warnKnockAway		= mod:NewSpellAnnounce(18670, 3)
local warnMortal		= mod:NewTargetNoFilterAnnounce(24573, 2, nil, "Tank", 2)

local timerMortal		= mod:NewTargetTimer(5, 24573, nil, "Tank", 2, 5, nil, DBM_CORE_TANK_ICON)

--function mod:OnCombatStart(delay)

--end

do
	local BlastWave, KnockAway = DBM:GetSpellInfo(23331), DBM:GetSpellInfo(18670)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 23331 then
		if args.spellName == BlastWave and args:IsSrcTypeHostile() then
			warnBlastWave:Show()
		--elseif args.spellId == 18670 then
		elseif args.spellName == KnockAway then
			warnKnockAway:Show()
		end
	end
end

do
	local MortalStrike = DBM:GetSpellInfo(24573)
	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 24573 then
		if args.spellName == MortalStrike and args:IsDestTypePlayer() then
			warnMortal:Show(args.destName)
			timerMortal:Start(args.destName)
		end
	end

	function mod:SPELL_AURA_REMOVED(args)
		--if args.spellId == 24573 then
		if args.spellName == MortalStrike and args:IsDestTypePlayer() then
			timerMortal:Stop(args.destName)
		end
	end
end
