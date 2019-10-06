local mod	= DBM:NewMod("Anub'Rekhan", "DBM-Naxx", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(15956)
mod:SetEncounterID(1107)
mod:SetModelID(15931)
mod:RegisterCombat("combat_yell", L.Pull1, L.Pull2)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 28785 54021",
	"SPELL_AURA_REMOVED 28785 54021"
)

--TODO, add timer for crypt guards?
local warningLocustSoon		= mod:NewSoonAnnounce(28785, 2)
local warningLocustFaded	= mod:NewFadesAnnounce(28785, 1)

local specialWarningLocust	= mod:NewSpecialWarningSpell(28785, nil, nil, nil, 2, 2)

local timerLocustIn			= mod:NewCDTimer(80, 28785, nil, nil, nil, 6)
local timerLocustFade 		= mod:NewBuffActiveTimer(26, 28785, nil, nil, nil, 6)

function mod:OnCombatStart(delay)
	timerLocustIn:Start(90 - delay)
	warningLocustSoon:Schedule(80 - delay)
end

do
	local LocustSwarm = DBM:GetSpellInfo(28785)
	function mod:SPELL_CAST_START(args)
		--if args:IsSpellID(28785, 54021) then  -- Locust Swarm
		if args.spellName == LocustSwarm then  -- Locust Swarm
			specialWarningLocust:Show()
			specialWarningLocust:Play("aesoon")
			timerLocustIn:Stop()
			timerLocustFade:Start(23)
		end
	end

	function mod:SPELL_AURA_REMOVED(args)
		--if args:IsSpellID(28785, 54021) and args.auraType == "BUFF" then
		if args.spellName == LocustSwarm and args.auraType == "BUFF" then
			warningLocustFaded:Show()
			timerLocustIn:Start()
			warningLocustSoon:Schedule(62)
		end
	end
end
