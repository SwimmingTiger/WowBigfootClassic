local mod	= DBM:NewMod("Loatheb", "DBM-Naxx", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20201025150202")
mod:SetCreatureID(16011)
mod:SetEncounterID(1115)
mod:SetModelID(16110)
mod:RegisterCombat("combat")--Maybe change to a yell later so pull detection works if you chain pull him from tash gauntlet

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 29234 29204",
	"UNIT_DIED"
)

--TODO, the 5xxxx spellIds are not from classic
local warnSporeNow	= mod:NewSpellAnnounce(29234, 2, "134530")
local warnSporeSoon	= mod:NewSoonAnnounce(29234, 1, "134530")
local warnDoomNow	= mod:NewSpellAnnounce(29204, 3)
--local warnHealSoon	= mod:NewAnnounce("WarningHealSoon", 4, 55593)
--local warnHealNow	= mod:NewAnnounce("WarningHealNow", 1, 55593, false)

local timerSpore	= mod:NewNextTimer(12.9, 29234, nil, nil, nil, 5, "134530", DBM_CORE_L.DAMAGE_ICON)-- initial 11.3 then 12.92-12.99
local timerDoom		= mod:NewNextTimer(29, 29204, nil, nil, nil, 2)-- initial 130 then 29.1-32.4
--local timerAura		= mod:NewBuffActiveTimer(17, 55593, nil, nil, nil, 5, nil, DBM_CORE_L.HEALER_ICON)

mod.vb.doomCounter	= 0
mod.vb.sporeTimer	= 12.9

function mod:OnCombatStart(delay)
	self.vb.doomCounter = 0
	timerSpore:Start(11.3 - delay)
	warnSporeSoon:Schedule(self.vb.sporeTimer - 5 - delay)
	timerDoom:Start(130 - delay, self.vb.doomCounter + 1)
end

do
	local Spore, InevitableDoom = DBM:GetSpellInfo(29234), DBM:GetSpellInfo(29204)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 29234 then
		if args.spellName == Spore then
			timerSpore:Start(self.vb.sporeTimer)
			warnSporeNow:Show()
			warnSporeSoon:Schedule(self.vb.sporeTimer - 5)
		elseif args.spellName == InevitableDoom then
			self.vb.doomCounter = self.vb.doomCounter + 1
			local timer = 30
			if self.vb.doomCounter >= 7 then
				if self.vb.doomCounter % 2 == 0 then timer = 17
				else timer = 12 end
			end
			warnDoomNow:Show(self.vb.doomCounter)
			timerDoom:Start(timer, self.vb.doomCounter + 1)
		--elseif args.spellId == 55593 then
			--timerAura:Start()
			--warnHealSoon:Schedule(14)
			--warnHealNow:Schedule(17)
		end
	end
end

--because in all likelyhood, pull detection failed (cause 90s like to chargein there trash and all and pull it
--We unschedule the pre warnings on death as a failsafe
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 16011 then
		warnSporeSoon:Cancel()
		--warnHealSoon:Cancel()
		--warnHealNow:Cancel()
	end
end
