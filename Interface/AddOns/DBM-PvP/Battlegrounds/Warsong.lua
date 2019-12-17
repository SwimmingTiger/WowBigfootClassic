local mod
if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	mod	= DBM:NewMod("z489", "DBM-PvP")
else
	mod	= DBM:NewMod("z2106", "DBM-PvP")
end

mod:SetRevision("20190825030134")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

do
	function mod:OnInitialize()
		if DBM:GetCurrentArea() == 489 or DBM:GetCurrentArea() == 2106 then--Classic, Retail
			DBM:GetModByName("PvPGeneral"):SubscribeFlags()
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		self:ScheduleMethod(1, "OnInitialize")
	end
end