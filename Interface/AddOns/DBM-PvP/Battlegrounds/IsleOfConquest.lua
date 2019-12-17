if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	return
end
local mod	= DBM:NewMod("z628", "DBM-PvP")

mod:SetRevision("20190908234935")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

do
	function mod:OnInitialize()
		if DBM:GetCurrentArea() == 628 then
			--[[
			DBM:GetModByName("PvPGeneral"):SubscribeAssault(
				169,
				-- TODO: Get default ID's
				{},
				{1e-300, 1e-300, 1e-300, 1e-300, 1e-300, 1e-300} -- We don't use resources here
			)
			--]]
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		self:ScheduleMethod(1, "OnInitialize")
	end
end
