local mod = DBM:NewMod(601, "DBM-Party-WotLK", 16, 276)
local L = mod:GetLocalizedStrings()

mod:SetRevision("20220713234849")
mod:SetCreatureID(38112)
mod:SetEncounterID(1992)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 72422 72426 72435",
	"SPELL_AURA_REMOVED 72422 72426"
)

local warnFear					= mod:NewSpellAnnounce(72435, 3)
local warnImpendingDespair		= mod:NewTargetNoFilterAnnounce(72426, 3)
local warnQuiveringStrike		= mod:NewTargetNoFilterAnnounce(72422, 3)

local timerImpendingDespair		= mod:NewTargetTimer(6, 72426, nil, "Healer", 2, 5, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.MAGIC_ICON)
local timerQuiveringStrike		= mod:NewTargetTimer(5, 72422, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 72422 then
		timerQuiveringStrike:Start(args.destName)
		warnQuiveringStrike:Show(args.destName)
	elseif args.spellId == 72426 then
		timerImpendingDespair:Start(args.destName)
		warnImpendingDespair:Show(args.destName)
	elseif args.spellId == 72435 and self:AntiSpam() then
		warnFear:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 72422 then
		timerQuiveringStrike:Stop(args.destName)
	elseif args.spellId == 72426 then
		timerImpendingDespair:Stop(args.destName)
	end
end
