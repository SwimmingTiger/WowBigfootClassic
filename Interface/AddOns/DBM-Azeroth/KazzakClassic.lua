local mod	= DBM:NewMod("KazzakClassic", "DBM-Azeroth")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(12397)--121818 TW ID, 12397 classic ID
--mod:SetModelID(17887)
mod:SetZone()

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
--	"SPELL_CAST_START 243712",
	"SPELL_AURA_APPLIED 21056"
--	"SPELL_AURA_APPLIED_DOSE 243713"
)

--TODO, maybe add yells for classic version, for timewalking version, it just doens't matter if marks don't run out
--TODO, needs valid spellIds for Classic
--local warnVoidBolt				= mod:NewStackAnnounce(243713, 2, nil, "Tank")
--local warningFrenzy				= mod:NewSpellAnnounce(156598, 3)
local warningMark				= mod:NewTargetAnnounce(21056, 4)
--local warningShadowBoltVolley	= mod:NewSpellAnnounce(243712, 2)

local specWarnMark				= mod:NewSpecialWarningYou(21056, nil, nil, nil, 1, 2)

--local timerVoidBoltCD			= mod:NewCDTimer(27.8, 243713, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--Iffy
local timerMarkCD				= mod:NewCDTimer(19.1, 21056, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
--local timerShadowBoltVolleyCD	= mod:NewCDTimer(7.6, 243712, nil, nil, nil, 2)

--mod:AddReadyCheckOption(48620, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		--timerVoidBoltCD:Start(8.3-delay)
		--timerShadowBoltVolleyCD:Start(11.5-delay)
		timerMarkCD:Start(14.1-delay)
	end
end

--[[
function mod:SPELL_CAST_START(args)
	if args.spellId == 243712 then
		warningShadowBoltVolley:Show()
		--timerShadowBoltVolleyCD:Start()
	end
end
--]]

do
	local MarkofKaz = DBM:GetSpellInfo(21056)
	function mod:SPELL_AURA_APPLIED(args)
		--local spellId = args.spellId
		local spellName = args.spellName
		--if spellId == 21056 then
		if spellName == MarkofKaz then
			warningMark:CombinedShow(0.5, args.destName)
			timerMarkCD:DelayedStart(0.5)
			if args:IsPlayer() then
				specWarnMark:Show()
				specWarnMark:Play("targetyou")
			end
		--elseif spellId == 243713 then
		--	local amount = args.amount or 1
		--	warnVoidBolt:Show(args.destName, amount)
		--	timerVoidBoltCD:Start()
		--elseif spellId == 156598 then
		--	warningFrenzy:Show()
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
