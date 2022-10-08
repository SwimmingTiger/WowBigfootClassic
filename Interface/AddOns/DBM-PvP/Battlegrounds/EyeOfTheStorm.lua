if WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2) then -- Added in TBC
	return
end
local mod	= DBM:NewMod("z566", "DBM-PvP")

mod:SetRevision("20220911171814")
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
			local assaultID
			if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then--TBC and Wrath classic
				assaultID = 1956
			elseif zoneID == 566 then
				assaultID = 122
			elseif zoneID == 968 then
				assaultID = 397
			end
			generalMod:SubscribeAssault(assaultID, 4)
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
