local mod = DBM:NewMod(WOW_PROJECT_ID == WOW_PROJECT_CLASSIC and "z529" or "z2107", "DBM-PvP")

mod:SetRevision("20200524113830")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)
mod:RegisterEvents("ZONE_CHANGED_NEW_AREA")

do
	function mod:OnInitialize()
		local zoneID = DBM:GetCurrentArea()
		if zoneID == 529 or zoneID == 1681 or zoneID == 2107 or zoneID == 2177 then -- Classic Arathi, Winter, Remastered Retail, AI
			local assaultID
			if zoneID == 529 then
				assaultID = 1461
			elseif zoneID == 1681 then
				assaultID = 837
			elseif zoneID == 2107 then
				assaultID = 93
			elseif zoneID == 2177 then
				assaultID = 1383
			end
			DBM:GetModByName("PvPGeneral"):SubscribeAssault(assaultID, 5)
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		self:ScheduleMethod(1, "OnInitialize")
	end
end
