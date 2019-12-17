local mod
if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	mod	= DBM:NewMod("z529", "DBM-PvP")
else
	mod	= DBM:NewMod("z2107", "DBM-PvP")
end

mod:SetRevision("20190908191948")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

do
	function mod:OnInitialize()
		local zoneID = DBM:GetCurrentArea()
		if zoneID == 529 or zoneID == 1681 or zoneID == 2107 or zoneID == 2177 then--Classic Arathi, Winter, Remastered Retail, AI
			local assaultID
			if zoneID == 1681 then
				assaultID = 837
			elseif zoneID == 2107 or zoneID == 529 then--Assumed classic also uses assault 93, verify
				assaultID = 93
			elseif zoneID == 2177 then
				assaultID = 1383
			end
			DBM:GetModByName("PvPGeneral"):SubscribeAssault(
				assaultID,
				{["Farm"] = {32, 34}, ["Gold Mine"] = {13,15}, ["Lumber Mill"] = {22,24}, ["Stables"] = {37,39}, ["Blacksmith"] = {27,29}},
				{1e-300, 10 / 12, 10 / 9, 10 / 6, 10 / 3, 30}
			)
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		self:ScheduleMethod(1, "OnInitialize")
	end
end
