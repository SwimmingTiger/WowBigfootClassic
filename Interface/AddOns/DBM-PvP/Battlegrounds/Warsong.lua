local mod = DBM:NewMod(WOW_PROJECT_ID == WOW_PROJECT_CLASSIC and "z489" or "z2106", "DBM-PvP")

mod:SetRevision("20201228165807")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)
mod:RegisterEvents("ZONE_CHANGED_NEW_AREA")

do
	local function Init()
		if DBM:GetCurrentArea() == 489 or DBM:GetCurrentArea() == 2106 then -- Classic, Retail
			DBM:GetModByName("PvPGeneral"):SubscribeFlags()
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		self:Schedule(1, Init)
	end
	mod.PLAYER_ENTERING_WORLD	= mod.ZONE_CHANGED_NEW_AREA
	mod.OnInitialize			= mod.ZONE_CHANGED_NEW_AREA
end
