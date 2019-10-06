local mod	= DBM:NewMod("Mograine_and_Whitemane", "DBM-Party-Classic", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(3977, 3976, 99999)--Whitemane, Mograine
--mod:SetEncounterID(585)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 12039",
	"SPELL_CAST_SUCCESS 9256",
	"UNIT_DIED"
)

local warnDeepSleep				= mod:NewSpellAnnounce(9256, 2)

local specWarnHeal				= mod:NewSpecialWarningInterrupt(12039, "HasInterrupt", nil, nil, 1, 2)

local timerDeepSleep			= mod:NewBuffFadesTimer(10, 9256, nil, nil, nil, 6)

mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.phase = 1
end

do
	local Heal = DBM:GetSpellInfo(12039)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 12039 then
		if args.spellName == Heal and args:IsSrcTypeHostile() then
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnHeal:Show(args.sourceName)
				specWarnHeal:Play("kickcast")
			end
		end
	end
end

do
	local DeepSleep = DBM:GetSpellInfo(9256)
	--3/28 16:22:43.810  SPELL_CAST_SUCCESS,0xF1300F8900000065,"High Inquisitor Whitemane",0xa48,0x0,0x0000000000000000,nil,0x80000000,0x80000000,9256,"Deep Sleep",0x20
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 9256 then--Phase 3
		if args.spellName == DeepSleep then--Phase 3
			self.vb.phase = 3
			warnDeepSleep:Show()
			timerDeepSleep:Start()
		end
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 3976 then
		if self.vb.phase == 3 then--Fight is over on 2nd death
			DBM:EndCombat(self)
		else--it's first death, he's down and whiteman is taking over
			self.vb.phase = 2
		end
	end
end
