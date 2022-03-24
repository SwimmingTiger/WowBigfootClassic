if WOW_PROJECT_ID ~= (WOW_PROJECT_MAINLINE or 1) then -- Added in WotLK
	return
end
local mod	= DBM:NewMod("z628", "DBM-PvP")

mod:SetRevision("20210519214524")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)
mod:RegisterEvents(
	"LOADING_SCREEN_DISABLED",
	"ZONE_CHANGED_NEW_AREA"
)

do
	local bgzone = false

	local function Init()
		local zoneID = DBM:GetCurrentArea()
		if not bgzone and zoneID == 628 then
			bgzone = true
			local generalMod = DBM:GetModByName("PvPGeneral")
			generalMod:SubscribeAssault(169, 5)
			generalMod:TrackHealth(34922, "HordeBoss")
			generalMod:TrackHealth(34924, "AllianceBoss")
			-- TODO: Add gate health
		elseif bgzone and zoneID ~= 628 then
			bgzone = false
			DBM:GetModByName("PvPGeneral"):StopTrackHealth()
		end
	end

	function mod:LOADING_SCREEN_DISABLED()
		self:Schedule(1, Init)
	end
	mod.ZONE_CHANGED_NEW_AREA	= mod.LOADING_SCREEN_DISABLED
	mod.PLAYER_ENTERING_WORLD	= mod.LOADING_SCREEN_DISABLED
	mod.OnInitialize			= mod.LOADING_SCREEN_DISABLED
end
