local mod	= DBM:NewMod("Anub'Rekhan", "DBM-Naxx", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20210403083254")
mod:SetCreatureID(15956)
mod:SetEncounterID(1107)
mod:SetModelID(15931)
mod:RegisterCombat("combat_yell", L.Pull1, L.Pull2)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 28785 28783",--54021
	"SPELL_AURA_REMOVED 28785"--54021
)

--TODO, add timer for crypt guards?
--TODO, warn if players are taking damage from locust swarm to move further away from boss?
--[[
(ability.id = 28783 or ability.id = 28785) and type = "begincast"
 or ability.id = 28785 and type = "removebuff"
 --]]
local warningLocustSoon		= mod:NewSoonAnnounce(28785, 2)
local warningLocustFaded	= mod:NewFadesAnnounce(28785, 1)
local warnImpale			= mod:NewTargetNoFilterAnnounce(28783, 3)

local specialWarningLocust	= mod:NewSpecialWarningSpell(28785, nil, nil, nil, 2, 2)
local yellImpale			= mod:NewYell(28783)

local timerLocustIn			= mod:NewCDTimer(80, 28785, nil, nil, nil, 6)-- 80-104
local timerLocustFade 		= mod:NewBuffActiveTimer(23, 28785, nil, nil, nil, 6)

function mod:OnCombatStart(delay)
	timerLocustIn:Start(80 - delay)--80-100
	warningLocustSoon:Schedule(75 - delay)
end

function mod:ImpaleTarget(targetname, uId)
	if not targetname then return end
	warnImpale:Show(targetname)
	if targetname == UnitName("player") then
		yellImpale:Yell()
	end
end

function mod:SPELL_CAST_START(args)
	--if args:IsSpellID(28785, 54021) then -- Locust Swarm
	if args.spellId == 28785 then -- Locust Swarm
		specialWarningLocust:Show()
		specialWarningLocust:Play("aesoon")
		timerLocustIn:Stop()
		timerLocustFade:Start(23)
	elseif args.spellId == 28783 then -- Impale
		self:BossTargetScanner(args.sourceGUID, "ImpaleTarget", 0.1, 6)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	--if args:IsSpellID(28785, 54021) and args.auraType == "BUFF" then
	if args.spellId == 28785 and args:IsDestTypeHostile() then--Want it removing from boss, not players, without ID we check hostility of affected unit
		warningLocustFaded:Show()
		timerLocustIn:Start(69.2)--More consistent
		warningLocustSoon:Schedule(54.2)
	end
end
