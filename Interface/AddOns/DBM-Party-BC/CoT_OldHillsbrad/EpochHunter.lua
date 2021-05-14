local mod	= DBM:NewMod(540, "DBM-Party-BC", 11, 251)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20210401042132")
mod:SetCreatureID(18096)
mod:SetEncounterID(1906)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)