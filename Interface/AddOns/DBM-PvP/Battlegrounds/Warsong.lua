local mod = DBM:NewMod(WOW_PROJECT_ID ~= (WOW_PROJECT_MAINLINE or 1) and "z489" or "z2106", "DBM-PvP")

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
		if not bgzone and (zoneID == 489 or zoneID == 2106) then -- Classic, Retail
			bgzone = true
			DBM:GetModByName("PvPGeneral"):SubscribeFlags()
		elseif bgzone and (zoneID ~= 489 and zoneID ~= 2106) then
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
