if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	return
end
local mod	= DBM:NewMod("z628", "DBM-PvP")

mod:SetRevision("20200118194719")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

do
	function mod:OnInitialize()
		if DBM:GetCurrentArea() == 628 then
			DBM:GetModByName("PvPGeneral"):SubscribeAssault(
				169,
				{["Refinery"] = {152,153,154,155}, ["Quarry"] = {17,18,19,20}, ["Docks"] = {147,148,149,150}, ["Workshop"] = {137,138,139,140}, ["Hangar"] = {142,143,144,145}}
			)
			-- TODO: Add gate health
			-- TODO: Add boss health
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		self:ScheduleMethod(1, "OnInitialize")
	end
end
