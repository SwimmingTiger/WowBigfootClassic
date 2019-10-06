local mod	= DBM:NewMod(422, "DBM-Party-Classic", 7, 231)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(7800)
mod:SetEncounterID(382)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 10101 11130 11518 11521 11798 11524 11526 11527"
)

local warningKnockAway			= mod:NewSpellAnnounce(10101, 2)
local warningActivateBomb		= mod:NewSpellAnnounce(11518, 2)

local timerKnockAwayCD			= mod:NewAITimer(180, 10101, nil, nil, nil, 2)

function mod:OnCombatStart(delay)
	timerKnockAwayCD:Start(1-delay)
end

do
	local KnockAway = DBM:GetSpellInfo(10101)
	local BombOne, BombTwo, BombThree, BombFour, BombFive, BombSix = DBM:GetSpellInfo(11518), DBM:GetSpellInfo(11521), DBM:GetSpellInfo(11798), DBM:GetSpellInfo(11524), DBM:GetSpellInfo(11526), DBM:GetSpellInfo(11527)
	function mod:SPELL_CAST_SUCESS(args)
		--local spellId = args.spellId
		local spellName = args.spellName
		--if spellId == 10101 or spellId == 11130 then
		if spellName == KnockAway then
			warningKnockAway:Show()
			timerKnockAwayCD:Start()
		--elseif (spellId == 11518 or spellId == 11521 or spellId == 11798 or spellId == 11524 or spellId == 11526 or spellId == 11527) and self:AntiSpam(3, 1) then
		elseif (spellName == BombOne or spellName == BombTwo or spellName == BombThree or spellName == BombFour or spellName == BombFive or spellName == BombSix) and self:AntiSpam(3, 1) then
			warningActivateBomb:Show()
		end
	end
end
