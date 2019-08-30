local mod	= DBM:NewMod("Majordomo", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190810001130")
mod:SetCreatureID(12018, 11663, 11664)
mod:SetEncounterID(671)
mod:SetModelID(12029)
mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.Kill)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 20619 21075 20534"
)

local warnTeleport			= mod:NewTargetNoFilterAnnounce(20534)

local specWarnMagicReflect	= mod:NewSpecialWarningReflect(20619, "-Melee")
local specWarnDamageShield	= mod:NewSpecialWarningReflect(21075, "Melee")

local timerMagicReflect		= mod:NewBuffActiveTimer(10, 20619, nil, nil, nil, 5, nil, DBM_CORE_DAMAGE_ICON)
local timerDamageShield		= mod:NewBuffActiveTimer(10, 21075, nil, nil, nil, 5, nil, DBM_CORE_DAMAGE_ICON)

do
	local MagicReflect, MeleeReflect, Teleport = DBM:GetSpellInfo(20619), DBM:GetSpellInfo(21075), DBM:GetSpellInfo(20534)
	function mod:SPELL_CAST_SUCCESS(args)
		--local spellId = args.spellId
		local spellName = args.spellName
		--if spellId == 20619 then
		if spellName == MagicReflect then
			specWarnMagicReflect:Show(BOSS)--Always a threat to casters
			specWarnMagicReflect:Play("stopattack")
			timerMagicReflect:Start()
		--elseif spellId == 21075 then
		elseif spellName == MeleeReflect then
			if self:IsDifficulty("event40") or not self:IsTrivial(75) then--Not a threat to high level melee
				specWarnDamageShield:Show(BOSS)
				specWarnDamageShield:Play("stopattack")
			end
			timerDamageShield:Start()
		--elseif spellId == 20534 then
		elseif spellName == Teleport then
			warnTeleport:Show(args.destName)
		end
	end
end
