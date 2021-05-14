local mod	= DBM:NewMod(557, "DBM-Party-BC", 2, 256)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20210401042132")
mod:SetCreatureID(17377)--17377 is boss, 17653 are channelers that just pull with him.
mod:SetEncounterID(1923)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)