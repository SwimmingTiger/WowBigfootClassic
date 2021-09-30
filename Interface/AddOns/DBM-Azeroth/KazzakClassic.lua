local mod	= DBM:NewMod("KazzakClassic", "DBM-Azeroth")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20210721040603")
mod:SetCreatureID(12397)--121818 TW ID, 12397 classic ID
--mod:SetModelID(17887)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 21341",
	"SPELL_AURA_APPLIED 21056"
)

local warningMark				= mod:NewTargetNoFilterAnnounce(21056, 4)
local warningShadowBoltVolley	= mod:NewSpellAnnounce(21341, 2)

local specWarnMark				= mod:NewSpecialWarningYou(21056, nil, nil, nil, 1, 2)--No Yell on purpose, outdoor chat restrictions and all

--Timers seem totally random, like 5-40 type random nonsense, so are utterly worthless
--local timerMarkCD				= mod:NewCDTimer(19.1, 21056, nil, nil, nil, 3, nil, DBM_CORE_L.MAGIC_ICON)
--local timerShadowBoltVolleyCD	= mod:NewCDTimer(7.6, 21341, nil, nil, nil, 2)

--mod:AddReadyCheckOption(48620, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		--timerShadowBoltVolleyCD:Start(11.5-delay)
		--timerMarkCD:Start(14.1-delay)
	end
end

do
	local ShadowBoltVolley = DBM:GetSpellInfo(21341)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 243712 then
		if args.spellName == ShadowBoltVolley and args:IsSrcTypeHostile() then
			warningShadowBoltVolley:Show()
			--timerShadowBoltVolleyCD:Start()
		end
	end
end

do
	local MarkofKaz = DBM:GetSpellInfo(21056)
	function mod:SPELL_AURA_APPLIED(args)
		--local spellId = args.spellId
		local spellName = args.spellName
		--if spellId == 21056 then
		if spellName == MarkofKaz then
			self:SendSync("Mark", args.destName)
			if self:AntiSpam(5, 1) then
				if args:IsPlayer() then
					specWarnMark:Show()
					specWarnMark:Play("targetyou")
				else
					warningMark:Show(args.destName)
				end
			end
		end
	end
end

do
	local playerName = UnitName("player")
	function mod:OnSync(msg, targetName)
		if not self:IsInCombat() then return end
		if msg == "Mark" and targetName and self:AntiSpam(5, 1) then
			if targetName == playerName then
				specWarnMark:Show()
				specWarnMark:Play("targetyou")
			else
				warningMark:Show(targetName)
			end
		end
	end
end
