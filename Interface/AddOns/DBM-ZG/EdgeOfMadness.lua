local mod	= DBM:NewMod("EdgeOfMadness", "DBM-ZG", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15083)
mod:SetEncounterID(788)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 24684 24699 24683",
	"SPELL_AURA_APPLIED 24664 8269",
	"SPELL_SUMMON 24728 24683"
)

--TODO, this mod was a huge mess, wrong spellIds, duplicate events. So It needs heavy review with logs
local warnIllusions	= mod:NewSpellAnnounce(24728)
local warnSleep		= mod:NewSpellAnnounce(24664)
local warnChainBurn	= mod:NewSpellAnnounce(24684)
local warnFrenzy	= mod:NewSpellAnnounce(8269)
local warnVanish	= mod:NewSpellAnnounce(24699)
local warnCloud		= mod:NewSpellAnnounce(24683)

local timerSleep	= mod:NewBuffActiveTimer(6, 24664, nil, nil, nil, 3)
local timerCloud	= mod:NewBuffActiveTimer(15, 24683, nil, nil, nil, 3)

--function mod:OnCombatStart(delay)
--end

do
	local ChainBurn, Vanish, LightningCloud = DBM:GetSpellInfo(24684), DBM:GetSpellInfo(24699), DBM:GetSpellInfo(24683)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args:IsSpellID(24684) then
		if args.spellName == ChainBurn then
			warnChainBurn:Show()
		--elseif args:IsSpellID(24699) then
		elseif args.spellName == Vanish and args:IsSrcTypeHostile() then
			warnVanish:Show()
		--elseif args:IsSpellID(24683) then
		elseif args.spellName == LightningCloud then
			warnCloud:Show()
			timerCloud:Start()
		end
	end
end

do
	local Sleep, Frenzy = DBM:GetSpellInfo(24684), DBM:GetSpellInfo(24699)
	function mod:SPELL_AURA_APPLIED(args)
		--if args:IsSpellID(24664) and self:AntiSpam(3, 1) then
		if args.spellName == Sleep and args:IsDestTypePlayer() and  self:AntiSpam(3, 1) then
			warnSleep:Show()
			timerSleep:Start()
		--elseif args:IsSpellID(8269) then
		elseif args.spellName == Frenzy and args:IsDestTypeHostile() then
			warnFrenzy:Show()
		end
	end
end

do
	local SummonIllusions = DBM:GetSpellInfo(24728)
	function mod:SPELL_SUMMON(args)
		--if args:IsSpellID(24728) then
		if args.spellName == SummonIllusions then
			warnIllusions:Show()
--		elseif args:IsSpellID(24683) then
--			warnCloud:Show()
--			timerCloud:Start()
		end
	end
end
