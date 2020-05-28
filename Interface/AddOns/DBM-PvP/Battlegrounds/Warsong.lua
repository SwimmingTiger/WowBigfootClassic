local mod = DBM:NewMod(WOW_PROJECT_ID == WOW_PROJECT_CLASSIC and "z489" or "z2106", "DBM-PvP")

mod:SetRevision("20200524113830")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)
mod:RegisterEvents("ZONE_CHANGED_NEW_AREA")

do
	function mod:OnInitialize()
		if DBM:GetCurrentArea() == 489 or DBM:GetCurrentArea() == 2106 then -- Classic, Retail
			DBM:GetModByName("PvPGeneral"):SubscribeFlags()
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		self:ScheduleMethod(1, "OnInitialize")
	end
end
