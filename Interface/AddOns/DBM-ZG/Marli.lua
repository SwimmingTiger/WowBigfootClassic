local mod	= DBM:NewMod("Marli", "DBM-ZG", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(14510)
mod:SetEncounterID(786)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 24111 24300 24109",
	"SPELL_AURA_REMOVED 24111 24300",
	"SPELL_CAST_SUCCESS 24083"
)

--TODO, enlarge dispel warning valid?
local warnSpiders		= mod:NewSpellAnnounce(24083, 2)
local warnDrain			= mod:NewTargetNoFilterAnnounce(24300, 2, nil, "RemoveMagic|Healer")
local warnCorrosive		= mod:NewTargetNoFilterAnnounce(24111, 2, nil, "RemovePoison")
local warnEnlarge		= mod:NewTargetNoFilterAnnounce(24109, 3)

local specWarnEnlarge	= mod:NewSpecialWarningDispel(24109, "MagicDispeller", nil, nil, 1, 2)

local timerDrain		= mod:NewTargetTimer(7, 24300, nil, "RemoveMagic|Healer", nil, 5, nil, DBM_CORE_L.MAGIC_ICON)
local timerCorrosive	= mod:NewTargetTimer(30, 24111, nil, "RemovePoison", nil, 5, nil, DBM_CORE_L.POISON_ICON)

--function mod:OnCombatStart(delay)
--end

do
	local CorrosivePoison, DrainLife, Enlarge = DBM:GetSpellInfo(24111), DBM:GetSpellInfo(24300), DBM:GetSpellInfo(24109)
	function mod:SPELL_AURA_APPLIED(args)
		--if args:IsSpellID(24111) then
		if args.spellName == CorrosivePoison then
			warnCorrosive:Show(args.destName)
			timerCorrosive:Start(args.destName)
		--elseif args:IsSpellID(24300) then
		elseif args.spellName == DrainLife and args:IsDestTypePlayer() then
			warnDrain:Show(args.destName)
			timerDrain:Start(args.destName)
		--elseif args:IsSpellID(24109) then
		elseif args.spellName == Enlarge then
			if self.Options.SpecWarn24109dispel then
				specWarnEnlarge:Show(args.destName)
				specWarnEnlarge:Play("dispelboss")
			else
				warnEnlarge:Show(args.destName)
			end
		end
	end

	function mod:SPELL_AURA_REMOVED(args)
		--if args:IsSpellID(24111) then
		if args.spellName == CorrosivePoison then
			timerCorrosive:Stop(args.destName)
		--elseif args:IsSpellID(24300) then
		elseif args.spellName == DrainLife and args:IsDestTypePlayer() then
			timerDrain:Stop(args.destName)
		end
	end
end

do
	local HatchEggs = DBM:GetSpellInfo(24083)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args:IsSpellID(24083) then
		if args.spellName == HatchEggs then
			warnSpiders:Show()
		end
	end
end
