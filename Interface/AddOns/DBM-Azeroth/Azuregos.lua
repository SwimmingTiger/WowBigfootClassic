local mod	= DBM:NewMod("Azuregos", "DBM-Azeroth")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(6109)--121820 TW ID, 6109 classic ID
--mod:SetModelID(17887)
mod:SetZone()

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 21147"
--	"SPELL_CAST_SUCCESS"
)

--TODO, needs valid spellIds for Classic
--local warningFrostBreath		= mod:NewSpellAnnounce(243789, 3)

local specWarnArcaneVacuum		= mod:NewSpecialWarningSpell(21147, nil, nil, nil, 2, 5)
--local specWarnReflection		= mod:NewSpecialWarningSpell(243835, "SpellCaster", nil, nil, 1, 2)--Change to CasterDps after next core release

--local timerReflectionCD			= mod:NewCDTimer(15.7, 243835, nil, "SpellCaster", nil, 5, nil, DBM_CORE_DAMAGER_ICON)--15.7-30
--local timerFrostBreathCD		= mod:NewCDTimer(5, 243789, nil, nil, nil, 3)--8.5-20.1
--local timerArcaneVacuumCD		= mod:NewCDTimer(19.8, 243784, nil, nil, nil, 2)

--mod:AddReadyCheckOption(48620, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		--timerFrostBreathCD:Start(5.8-delay)
		--timerArcaneVacuumCD:Start(5.7-delay)--5.7-12
		--timerReflectionCD:Start(24.4-delay)--Recheck
	end
end

do
	local ArcaneVacuum = DBM:GetSpellInfo(21147)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 21147  and self:AntiSpam(5, 1) then
		if args.spellName == ArcaneVacuum  and self:AntiSpam(5, 1) then
			specWarnArcaneVacuum:Show()
			specWarnArcaneVacuum:Play("teleyou")
			--timerArcaneVacuumCD:Start()
		--elseif args.spellId == 243789 and self:AntiSpam(3, 2) then
			--warningFrostBreath:Show()
			--timerFrostBreathCD:Start()
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 243784 then
		specWarnReflection:Show()
		specWarnReflection:Play("stilldanger")
		--pull:176.7, 31.3, 23.1, 20.8, 30.6, 26.2, 25.5, 15.7, 33.1, 30.1
		timerReflectionCD:Start()
	end
end
--]]
