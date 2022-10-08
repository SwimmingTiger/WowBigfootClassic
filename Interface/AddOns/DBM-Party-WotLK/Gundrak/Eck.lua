local mod	= DBM:NewMod(595, "DBM-Party-WotLK", 5, 274)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "heroic"

mod:SetRevision("20220724021612")
mod:SetCreatureID(29932)
mod:SetEncounterID(1988)
--
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)

local enrageTimer	= mod:NewBerserkTimer(120)

function mod:OnCombatStart(delay)
	enrageTimer:Start(120 - delay)
end
