local mod	= DBM:NewMod("Firemaw", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(11983)
mod:SetEncounterID(613)
mod:SetModelID(6377)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 23339 22539"
)

local warnWingBuffet	= mod:NewCastAnnounce(23339, 2)
local warnShadowFlame	= mod:NewCastAnnounce(22539, 2)
--local warnFlameBuffet	= mod:NewSpellAnnounce(23341)

local timerWingBuffet	= mod:NewNextTimer(31, 23339, nil, nil, nil, 2)
--local timerFlameBuffetCD = mod:NewCDTimer(10, 23341)

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
