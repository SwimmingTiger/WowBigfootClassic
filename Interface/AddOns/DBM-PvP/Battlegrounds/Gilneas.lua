if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	return
end
local mod	= DBM:NewMod("z761", "DBM-PvP")

mod:SetRevision("20200118194219")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

do
	function mod:OnInitialize()
		if DBM:GetCurrentArea() == 761 then
			DBM:GetModByName("PvPGeneral"):SubscribeAssault(
				275,
				{["Lighthouse"] = {9,11,12,13}, ["Mines"] = {17,18,19,20}, ["Waterworks"] = {27,28,29,30}}
			)
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		self:ScheduleMethod(1, "OnInitialize")
	end
end
