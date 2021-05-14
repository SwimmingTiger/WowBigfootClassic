if WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2) then
	return
end
local mod	= DBM:NewMod("z566", "DBM-PvP")

mod:SetRevision("20210419223508")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)
mod:RegisterEvents(
	"LOADING_SCREEN_DISABLED",
	"ZONE_CHANGED_NEW_AREA"
)

do
	local bgzone = false
	local function Init()
		local zoneID = DBM:GetCurrentArea()
		if not bgzone and (zoneID == 566 or zoneID == 968) then
			bgzone = true
			local generalMod = DBM:GetModByName("PvPGeneral")
			generalMod:SubscribeAssault(DBM:GetCurrentArea() == 566 and 112 or 397, 4)
			generalMod:SubscribeFlags()
		elseif bgzone and (zoneID ~= 566 and zoneID ~= 968) then
			bgzone = false
		end
	end

	function mod:LOADING_SCREEN_DISABLED()
		self:Schedule(1, Init)
	end
	mod.ZONE_CHANGED_NEW_AREA	= mod.LOADING_SCREEN_DISABLED
	mod.PLAYER_ENTERING_WORLD	= mod.LOADING_SCREEN_DISABLED
	mod.OnInitialize			= mod.LOADING_SCREEN_DISABLED
end
