local mod	= DBM:NewMod("Bloodboil", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220923022829")
mod:SetCreatureID(22948)
mod:SetEncounterID(605, 2477)
mod:SetModelID(21443)
mod:SetHotfixNoticeRev(20220120000000)
mod:SetMinSyncRevision(20220120000000)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 40508",
	"SPELL_CAST_SUCCESS 42005",
	"SPELL_AURA_APPLIED 42005 40481 40491 40604",
	"SPELL_AURA_APPLIED_DOSE 40481",--42005 not in combat log for DOSE
	"SPELL_AURA_REFRESH 40481",
	"SPELL_AURA_REMOVED 40604 40594"
)

--[[
ability.id = 40508 and type = "begincast"
 or (ability.id = 40491 or ability.id = 42005) and type = "cast"
 or ability.id = 40604 and type = "applydebuff"
 or ability.id = 40594
--]]
local warnBreath		= mod:NewSpellAnnounce(40508, 2)
local warnBlood			= mod:NewTargetAnnounce(42005, 3)
local warnWound			= mod:NewStackAnnounce(40481, 2, nil, "Tank", 2)
local warnStrike		= mod:NewTargetNoFilterAnnounce(40491, 3, nil, "Tank", 2)
local warnRage			= mod:NewTargetAnnounce(40604, 4)
local warnRageSoon		= mod:NewSoonAnnounce(40604, 3)
local warnRageEnd		= mod:NewEndAnnounce(40604, 4)

--local specWarnBlood		= mod:NewSpecialWarningStack(42005, nil, 1, nil, nil, 1, 2)
local specWarnBlood		= mod:NewSpecialWarningYou(42005, nil, nil, nil, 1, 2)
local specWarnRage		= mod:NewSpecialWarningYou(40604, nil, nil, nil, 1, 2)
local yellRage			= mod:NewYell(40604)

--Most timers on fight are bad. there is a reason there is no strike or breath timer. blood and rage only ones that are kinda consistent
local timerBlood		= mod:NewCDTimer(10, 42005, nil, nil, nil, 5)--10-12. Most of time it's 11 but I have seen as low as 10.1
--local timerStrikeCD		= mod:NewCDTimer(25, 40491, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)--25-82? Is this even a CD timer?
local timerRageCD		= mod:NewCDTimer(52, 40604, nil, nil, nil, 3)
local timerRageEnd		= mod:NewTargetTimer(30, 40604, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddInfoFrameOption(42005)

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	warnRageSoon:Schedule(47-delay)
	timerBlood:Start(10.9-delay)
--	timerStrikeCD:Start(26.8-delay)
	timerRageCD:Start(-delay)--52-58
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(42005))
		DBM.InfoFrame:Show(30, "playerdebuffstacks", 42005, 1)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 40508 then
		warnBreath:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 42005 then
		timerBlood:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 42005 then
		warnBlood:CombinedShow(0.8, args.destName)
		if args:IsPlayer() then
			specWarnBlood:Show()--args.amount
			specWarnBlood:Play("targetyou")
		end
	elseif spellId == 40481 then
		local amount = args.amount or 1
		if (amount % 5 == 0) then
			warnWound:Show(args.destName, amount)
		end
	elseif spellId == 40491 then
		warnStrike:Show(args.destName)
--		timerStrikeCD:Start()
	elseif spellId == 40604 then
		timerRageEnd:Start(args.destName)
		timerBlood:Stop()
		if args:IsPlayer() then
			specWarnRage:Show()
			specWarnRage:Play("targetyou")
			yellRage:Yell()
		else
			warnRage:Show(args.destName)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 40604 then--Ending on player
		timerRageEnd:Stop(args.destName)
	elseif spellId == 40594 then--Ending on Boss
		warnRageEnd:Show()
		timerBlood:Start(12.5)
		warnRageSoon:Schedule(47)
		timerRageCD:Start(52)
	end
end
