local mod	= DBM:NewMod("Razuvious", "DBM-Naxx", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20210403083254")
mod:SetCreatureID(16061)
mod:SetEncounterID(1113)
mod:SetModelID(16582)
mod:RegisterCombat("combat_yell", L.Yell1, L.Yell2, L.Yell3, L.Yell4)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 29107 29060 29061",--55543
	"UNIT_DIED"
)

--TODO, find out if args:IsPetSource() actually works, or find something else that does
--[[
ability.id = 29107 and type = "cast"
--]]
local warnShoutNow		= mod:NewSpellAnnounce(29107, 1)
local warnShoutSoon		= mod:NewSoonAnnounce(29107, 3)
local warnShieldWall	= mod:NewAnnounce("WarningShieldWallSoon", 3, 29061)

local timerShout		= mod:NewCDTimer(25.8, 29107, nil, nil, nil, 2)-- 25.87-25.96 in classic, 16 in wrath
local timerTaunt		= mod:NewCDTimer(60, 29060, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerShieldWall	= mod:NewBuffFadesTimer(20, 29061, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)

function mod:OnCombatStart(delay)
	timerShout:Start(24 - delay)--It is 22-26 variation, but since users complained, using the median instead of the minimum
	warnShoutSoon:Schedule(19 - delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	--if args:IsSpellID(29107, 55543) then  -- Disrupting Shout
	if args.spellId == 29107 then--What does an MCed unit return?
		timerShout:Start()
		warnShoutNow:Show()
		warnShoutSoon:Schedule(20)
	elseif args.spellId == 29060 and args:IsPetSource() then -- Taunt
		timerTaunt:Start(60, args.sourceGUID)
	elseif args.spellId == 29061 and args:IsPetSource() then -- ShieldWall
		timerShieldWall:Start(20, args.sourceGUID)
		warnShieldWall:Schedule(15)
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 16803 then--Deathknight Understudy
		timerTaunt:Stop(args.destGUID)
		timerShieldWall:Stop(args.destGUID)
	end
end
