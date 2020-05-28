if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	return
end
local mod	= DBM:NewMod("z2245", "DBM-PvP")

mod:SetRevision("20200524113830")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)
mod:RegisterEvents("ZONE_CHANGED_NEW_AREA")

do
	function mod:OnInitialize()
		if DBM:GetCurrentArea() == 2245 then
			DBM:GetModByName("PvPGeneral"):SubscribeAssault(1576, 5)
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		self:ScheduleMethod(1, "OnInitialize")
	end
end
