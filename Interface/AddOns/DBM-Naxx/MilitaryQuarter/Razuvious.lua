local mod	= DBM:NewMod("Razuvious", "DBM-Naxx", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221010034753")
mod:SetCreatureID(16061)
mod:SetEncounterID(1113)
mod:SetModelID(16582)
mod:RegisterCombat("combat_yell", L.Yell1, L.Yell2, L.Yell3, L.Yell4)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 55543 29107 29060 29061",
	"UNIT_DIED"
)

local warnShoutNow		= mod:NewSpellAnnounce(29107, 1)
local warnShoutSoon		= mod:NewSoonAnnounce(29107, 3)
local warnShieldWall	= mod:NewAnnounce("WarningShieldWallSoon", 3, 29061, nil, nil, nil, 29061)

local timerShout		= mod:NewNextTimer(16, 29107, nil, nil, nil, 2)
local timerTaunt		= mod:NewCDTimer(20, 29060, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerShieldWall	= mod:NewCDTimer(20, 29061, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

function mod:OnCombatStart(delay)
	timerShout:Start(16 - delay)
	warnShoutSoon:Schedule(11 - delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(55543, 29107) then  -- Disrupting Shout
		timerShout:Start()
		warnShoutNow:Show()
		warnShoutSoon:Schedule(11)
	elseif args.spellId == 29060 then -- Taunt
		timerTaunt:Start(20, args.sourceGUID)
	elseif args.spellId == 29061 then -- ShieldWall
		timerShieldWall:Start(20, args.sourceGUID)
		warnShieldWall:Schedule(15)
	end
end

function mod:UNIT_DIED(args)
	local guid = args.destGUID
	local cid = self:GetCIDFromGUID(guid)
	if cid == 16803 then--Deathknight Understudy
		timerTaunt:Stop(args.destGUID)
		timerShieldWall:Stop(args.destGUID)
	end
end
