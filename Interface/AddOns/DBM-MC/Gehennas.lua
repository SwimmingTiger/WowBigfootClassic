local mod	= DBM:NewMod("Gehennas", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190904200802")
mod:SetCreatureID(12259)--, 11661
mod:SetEncounterID(665)
mod:SetModelID(13030)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 19716 19717",
	"SPELL_AURA_APPLIED 20277"
)

--[[
(ability.id = 19716 or ability.id = 19717) and type = "cast"
--]]
local warnRainFire	= mod:NewSpellAnnounce(19717, 2, nil, false)
local warnCurse		= mod:NewSpellAnnounce(19716, 3)
local warnFist		= mod:NewTargetAnnounce(20277, 2, nil, false, 2)

local specWarnRoF	= mod:NewSpecialWarningMove(19717, nil, nil, nil, 1, 2)

local timerRoF		= mod:NewCDTimer(6, 19717, nil, false, nil, 3)
local timerCurse	= mod:NewCDTimer(26.7, 19716, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON..DBM_CORE_CURSE_ICON)--26.7-30
local timerFist		= mod:NewBuffActiveTimer(4, 20277, nil, false, 2, 3)

function mod:OnCombatStart(delay)
	timerCurse:Start(6-delay)
	if self:IsDifficulty("event40") or not self:IsTrivial(75) then--Only want to warn if it's a threat
		self:RegisterShortTermEvents(
			"SPELL_PERIODIC_DAMAGE 19717",
			"SPELL_PERIODIC_MISSED 19717"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

do
	local Curse, RainofFire = DBM:GetSpellInfo(19716), DBM:GetSpellInfo(19717)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 19716 then
		if args.spellName == Curse and args:IsSrcTypeHostile() then
			timerCurse:Start()
			warnCurse:Show()
		--elseif args.spellId == 19717 then
		elseif args.spellName == RainofFire and args:IsSrcTypeHostile() then
			warnRainFire:Show()
			timerRoF:Start()
		end
	end
end

do
	local Fist = DBM:GetSpellInfo(20277)
	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 20277 and args:IsDestTypePlayer() then
		if args.spellName == Fist and args:IsDestTypePlayer() then
			warnFist:CombinedShow(0.3, args.destName)
		end
	end
end

do
	local RainofFire = DBM:GetSpellInfo(19717)
	function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId, spellName)
		--if spellId == 19717 and destGUID == UnitGUID("player") and self:AntiSpam() then
		if spellName == RainofFire and destGUID == UnitGUID("player") and self:AntiSpam() then
			specWarnRoF:Show(spellName)
			specWarnRoF:Play("runaway")
		end
	end
	mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
end
