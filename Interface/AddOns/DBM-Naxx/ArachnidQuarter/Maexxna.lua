local mod	= DBM:NewMod("Maexxna", "DBM-Naxx", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(15952)
mod:SetEncounterID(1116)
mod:SetModelID(15928)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 28622",
	"SPELL_CAST_SUCCESS 29484 54125"
)

local warnWebWrap		= mod:NewTargetAnnounce(28622, 2)
local warnWebSpraySoon	= mod:NewSoonAnnounce(29484, 1)
local warnWebSprayNow	= mod:NewSpellAnnounce(29484, 3)
local warnSpidersSoon	= mod:NewAnnounce("WarningSpidersSoon", 2, 17332)
local warnSpidersNow	= mod:NewAnnounce("WarningSpidersNow", 4, 17332)

local specWarnWebWrap	= mod:NewSpecialWarningSwitch(28622, "RangedDps", nil, nil, 1, 2)
local yellWebWrap		= mod:NewYell(28622)

local timerWebSpray		= mod:NewNextTimer(40.5, 29484, nil, nil, nil, 2)
local timerSpider		= mod:NewTimer(30, "TimerSpider", 17332, nil, nil, 1)

function mod:OnCombatStart(delay)
	warnWebSpraySoon:Schedule(35.5 - delay)
	timerWebSpray:Start(40.5 - delay)
	warnSpidersSoon:Schedule(25 - delay)
	warnSpidersNow:Schedule(30 - delay)
	timerSpider:Start(30 - delay)
end

do
	local WebWrap = DBM:GetSpellInfo(28622)
	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 28622 then -- Web Wrap
		if args.spellName == WebWrap then -- Web Wrap
			warnWebWrap:CombinedShow(0.5, args.destName)
			if args.destName == UnitName("player") then
				specWarnWebWrap:Cancel()
				specWarnWebWrap:CancelVoice()
				yellWebWrap:Yell()
			elseif self:AntiSpam(3, 1) then
				specWarnWebWrap:Schedule(0.5)
				specWarnWebWrap:ScheduleVoice(0.5, "targetchange")
			end
		end
	end
end

do
	local WebSpray = DBM:GetSpellInfo(29484)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args:IsSpellID(29484, 54125) then -- Web Spray
		if args.spellName == WebSpray then -- Web Spray
			warnWebSprayNow:Show()
			warnWebSpraySoon:Schedule(35.5)
			timerWebSpray:Start()
			warnSpidersSoon:Schedule(25)
			warnSpidersNow:Schedule(30)
			timerSpider:Start()
		end
	end
end
