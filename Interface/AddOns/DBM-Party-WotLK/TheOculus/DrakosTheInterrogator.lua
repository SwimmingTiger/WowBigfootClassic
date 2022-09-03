local mod	= DBM:NewMod(622, "DBM-Party-WotLK", 9, 282)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220713234849")
mod:SetCreatureID(27654)
mod:SetEncounterID(2016)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"UNIT_DIED"
)

mod:AddBoolOption("MakeitCountTimer", true, "timer", nil, nil, nil, "at1868")

function mod:UNIT_DIED(args)
	if not self:IsDifficulty("normal5") then
		if self.Options.MakeitCountTimer and not DBT:GetBar(L.MakeitCountTimer) then
			local cid = self:GetCIDFromGUID(args.destGUID)
			if cid == 27654 then		-- Drakos The Interrogator
				DBT:CreateBar(1200, L.MakeitCountTimer)
			end
		end
	end
end
