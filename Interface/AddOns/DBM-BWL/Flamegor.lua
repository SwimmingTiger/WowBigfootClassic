local mod	= DBM:NewMod("Flamegor", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20200217192345")
mod:SetCreatureID(11981)
mod:SetEncounterID(615)
mod:SetModelID(6377)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 23339 22539",
	"SPELL_CAST_SUCCESS 23342"
)

--(ability.id = 23339 or ability.id = 22539) and type = "begincast" or ability.id = 23342 and type = "cast"
local warnWingBuffet		= mod:NewCastAnnounce(23339, 2)
local warnShadowFlame		= mod:NewCastAnnounce(22539, 2)
local warnFrenzy			= mod:NewSpellAnnounce(23342, 3, nil, "Tank|RemoveEnrage", 3)

local timerWingBuffet		= mod:NewCDTimer(31, 23339, nil, nil, nil, 2)
local timerShadowFlameCD	= mod:NewCDTimer(14, 22539, nil, false)--14-21
local timerFrenzyNext 		= mod:NewCDTimer(8.5, 23342, nil, "Tank|RemoveEnrage", 3, 5, nil, DBM_CORE_ENRAGE_ICON)

function mod:OnCombatStart(delay)
	timerFrenzyNext:Start(9.6-delay)
	timerShadowFlameCD:Start(18-delay)
	timerWingBuffet:Start(30-delay)
	DBM:AddMsg("Shadowflame timer off by default because 14-21sec variance.")
end

do
	local WingBuffet, ShadowFlame = DBM:GetSpellInfo(23339), DBM:GetSpellInfo(22539)
	function mod:SPELL_CAST_START(args)--did not see ebon use any of these abilities
		--if args.spellId == 23339 then
		if args.spellName == WingBuffet then
			warnWingBuffet:Show()
			timerWingBuffet:Start()
		--elseif args.spellId == 22539 then
		elseif args.spellName == ShadowFlame then
			warnShadowFlame:Show()
			timerShadowFlameCD:Start()
		end
	end
end

do
	local Frenzy = DBM:GetSpellInfo(23342)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 23342 then
		if args.spellName == Frenzy and args:IsSrcTypeHostile() then
			warnFrenzy:Show()
			timerFrenzyNext:Start()
		end
	end
end
