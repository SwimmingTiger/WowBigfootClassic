if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	return
end
local mod	= DBM:NewMod("z1105", "DBM-PvP")

mod:SetRevision("20191220163458")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

do
	function mod:OnInitialize()
		if DBM:GetCurrentArea() == 1105 then
			DBM:GetModByName("PvPGeneral"):SubscribeAssault(
				519,
				{}, -- This is empty, because we use atlas info
				{1e-300, 8 / 5, 16 / 5, 32 / 5}
			)
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		self:ScheduleMethod(1, "OnInitialize")
	end
end
