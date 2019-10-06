local mod	= DBM:NewMod("Flamegor", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(11981)
mod:SetEncounterID(615)
mod:SetModelID(6377)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 23339 22539",
	"SPELL_CAST_SUCCESS 23342"
)

local warnWingBuffet	= mod:NewCastAnnounce(23339, 2)
local warnShadowFlame	= mod:NewCastAnnounce(22539, 2)
local warnFrenzy		= mod:NewSpellAnnounce(23342, 3, nil, "Tank", 2)

local timerWingBuffet	= mod:NewNextTimer(31, 23339, nil, nil, nil, 2)
local timerFrenzyNext 	= mod:NewNextTimer(10, 23342, nil, "Tank", 2, 5, nil, DBM_CORE_TANK_ICON)

function mod:OnCombatStart(delay)
	timerWingBuffet:Start(-delay)
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
