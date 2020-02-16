local mod	= DBM:NewMod("Firemaw", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20200213221943")
mod:SetCreatureID(11983)
mod:SetEncounterID(613)
mod:SetModelID(6377)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 23339 22539"
)

--(ability.id = 23339 or ability.id = 22539) and type = "begincast"
local warnWingBuffet		= mod:NewCastAnnounce(23339, 2)
local warnShadowFlame		= mod:NewCastAnnounce(22539, 2)
--local warnFlameBuffet		= mod:NewSpellAnnounce(23341)

local timerWingBuffet		= mod:NewCDTimer(31, 23339, nil, nil, nil, 2)--Verified on classic 31-36
--local timerShadowFlameCD	= mod:NewCDTimer(14, 22539)--14-21

function mod:OnCombatStart(delay)
	timerWingBuffet:Start(30-delay)
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
			--timerShadowFlameCD:Start()
		end
	end
end

--[[
do
	local FlameBuffet = DBM:GetSpellInfo(23341)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 23341 then
		if args.spellName == FlameBuffet then
			warnFlameBuffet:Show()
		end
	end
end--]]
