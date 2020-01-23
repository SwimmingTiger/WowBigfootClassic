if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	return
end
local mod	= DBM:NewMod("z2245", "DBM-PvP") -- Previously zone 1105

mod:SetRevision("20200118193210")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

do
	function mod:OnInitialize()
		if DBM:GetCurrentArea() == 2245 then -- Previously zone 1105
			DBM:GetModByName("PvPGeneral"):SubscribeAssault(
				1576, -- Previously 519, now 1576
				{["Quarry"] = {17,18,19,20}, ["Farm"] = {32,33,34,35},  ["Market"] = {208,205,209,206}, ["Ruins"] = {213,210,214,211}, ["Shrine"] = {218,215,219,216}}
			)
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		self:ScheduleMethod(1, "OnInitialize")
	end
end
