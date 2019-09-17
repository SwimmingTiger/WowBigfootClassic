local mod	= DBM:NewMod("Majordomo", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190911042406")
mod:SetCreatureID(12018, 11663, 11664)
mod:SetEncounterID(671)
mod:SetModelID(12029)
mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.Kill)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 20619 21075 20534"
)

--[[
(ability.id = 20619 or ability.id = 21075 or ability.id = 20534) and type = "cast"
--]]
local warnTeleport			= mod:NewTargetNoFilterAnnounce(20534)
local warnDamageShield		= mod:NewSpellAnnounce(21075, 2)

local specWarnMagicReflect	= mod:NewSpecialWarningReflect(20619, "CasterDps", nil, 2, 1, 2)
local specWarnDamageShield	= mod:NewSpecialWarningReflect(21075, false, nil, 2, 1, 2)

local timerMagicReflect		= mod:NewBuffActiveTimer(10, 20619, nil, nil, nil, 5, nil, DBM_CORE_DAMAGE_ICON)
local timerDamageShield		= mod:NewBuffActiveTimer(10, 21075, nil, nil, nil, 5, nil, DBM_CORE_DAMAGE_ICON)
local timerTeleportCD		= mod:NewCDTimer(25, 20534, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)--25-30
local timerShieldCD			= mod:NewTimer(30.3, "timerShieldCD", nil, nil, nil, 6, nil, DBM_CORE_DAMAGE_ICON)

function mod:OnCombatStart(delay)
	timerTeleportCD:Start(19.4-delay)
	timerShieldCD:Start(27.8-delay)--27-30
end

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
			timerShieldCD:Start()
		--elseif spellId == 21075 then
		elseif spellName == MeleeReflect then
			if self.Options.SpecWarn21075reflect and (self:IsDifficulty("event40") or not self:IsTrivial(75)) then--Not a threat to high level melee
				specWarnDamageShield:Show(BOSS)
				specWarnDamageShield:Play("stopattack")
			else
				warnDamageShield:Show()
			end
			timerDamageShield:Start()
			timerShieldCD:Start()
		--elseif spellId == 20534 then
		elseif spellName == Teleport then
			warnTeleport:Show(args.destName)
			timerTeleportCD:Start()
		end
	end
end
